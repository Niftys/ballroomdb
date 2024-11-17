import re
import time
import mysql.connector
from mysql.connector import Error
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
from urllib.parse import urlparse, parse_qs
import config

# ----------------------------------------------------------------------------------
#                     Configurable Main URL and Competition Name
# ----------------------------------------------------------------------------------

MAIN_COMPETITION_URL = "https://ballroomcompexpress.com/results.php?cid=131"  # Enter main competition URL here
COMPETITION_NAME = "Triangle Open DanceSport Competition 2024"  # Enter the competition name and year here

# ----------------------------------------------------------------------------------
#                      Extract CID from URL
# ----------------------------------------------------------------------------------
    # Extracts the 'cid' parameter from the URL
def extract_cid_from_url(url):
    query_params = parse_qs(urlparse(url).query)
    cid = query_params.get('cid', [None])[0]
    if cid:
        print(f"Extracted cid: {cid}")
    else:
        print("No 'cid' parameter found in the URL.")
    return cid

CID = extract_cid_from_url(MAIN_COMPETITION_URL)

# ----------------------------------------------------------------------------------
#                      Connecting to MySQL and Fetching Dataset
# ----------------------------------------------------------------------------------
    # Establishes a connection to the MySQL database
def create_connection():
    try:
        connection = mysql.connector.connect(
            host=config.DB_HOST, # Top Secret information
            user=config.DB_USER,
            password=config.DB_PASSWORD,
            database=config.DB_NAME
        )
        if connection.is_connected():
            print("Connection successful")
        return connection
    except Error as e:
        print("Error connecting to MySQL", e)
        return None

    # Fetches all necessary mappings in one go for efficiency
def fetch_data_mappings(connection):
    mappings = {}
    cursor = connection.cursor(dictionary=True)
    
    # Fetch all mappings in a single query per table
    cursor.execute("SELECT name, id FROM judges")
    mappings['judges'] = {row['name']: row['id'] for row in cursor.fetchall()}
    
    cursor.execute("SELECT name, id FROM people")
    mappings['people'] = {row['name']: row['id'] for row in cursor.fetchall()}
    
    cursor.execute("SELECT name, id FROM style")
    mappings['styles'] = {row['name']: row['id'] for row in cursor.fetchall()}

    cursor.close()
    return mappings

    #Fetches the competition ID if it exists; otherwise, adds the competition and returns the new ID
def get_or_create_competition_id(connection, competition_name):
    cursor = connection.cursor()
    
    # Check if the competition exists
    cursor.execute("SELECT id FROM comp WHERE name = %s", (competition_name,))
    result = cursor.fetchone()
    
    if result:
        comp_id = result[0]
        print(f"Competition '{competition_name}' found with comp_id = {comp_id}.")
    else:
        # Insert new competition
        cursor.execute("INSERT INTO comp (name) VALUES (%s)", (competition_name,))
        connection.commit()
        comp_id = cursor.lastrowid
        print(f"Competition '{competition_name}' added with new comp_id = {comp_id}.")

    cursor.close()
    return comp_id

    # Inserts missing judges/couples
def insert_missing_entries(connection, missing_judges, missing_couples):
    cursor = connection.cursor()
    
    # Insert missing judges if any
    if missing_judges:
        cursor.executemany("INSERT INTO judges (name) VALUES (%s)", [(judge,) for judge in missing_judges])
        print(f"Inserted missing judges: {', '.join(missing_judges)}")
    
    # Insert missing couples if any
    if missing_couples:
        cursor.executemany("INSERT INTO people (name) VALUES (%s)", [(couple,) for couple in missing_couples])
        print(f"Inserted missing couples: {', '.join(missing_couples)}")
    
    # Commit changes to save the inserted entries
    connection.commit()
    cursor.close()
    
    # Identify missing styles and enter new IDs
def insert_missing_style(connection, style_name):
    cursor = connection.cursor()
    cursor.execute("INSERT INTO style (name) VALUES (%s)", (style_name,))
    connection.commit()
    style_id = cursor.lastrowid
    cursor.close()
    print(f"Added missing style: '{style_name}' with ID {style_id}")
    return style_id

# ----------------------------------------------------------------------------------
#                        User Entered Data, Data Collection
# ----------------------------------------------------------------------------------

    # Scrapes the main competition URL to gather all event links
def get_event_links():
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    
    # Using pre-installed ChromeDriver path here for faster execution
    driver = webdriver.Chrome(options=options)

    driver.get(MAIN_COMPETITION_URL)

    # Collect links dynamically using the extracted CID
    event_links = [
        element.get_attribute("href")
        for element in driver.find_elements(By.CSS_SELECTOR, f"a[href*='results.php?cid={CID}&eid=']")
    ]
    print(f"Found {len(event_links)} event links.")
    
    driver.quit()
    return event_links

    # Processes each event link found on the main competition page
def process_all_events(connection):
    # Get or create the competition ID
    comp_id = get_or_create_competition_id(connection, COMPETITION_NAME)

    event_links = get_event_links()
    if not event_links:
        print("No event links found.")
        return

    for event_url in event_links:
        print(f"Processing event: {event_url}")
        process_data(connection, event_url, comp_id)
    print("Completed processing all events.")

    # Main function for scraping data from URL
def process_data(connection, url, comp_id):
    output_filename = config.OUTPUT_FILE
    style_name = scrape_table_to_excel(url, output_filename)
    if not style_name:
        print(f"Failed to scrape data from the webpage: {url}")
        return

    # Load and filter Excel data directly
    df = pd.read_excel(output_filename).filter(regex="^(?!Number)")
    print("Excel data loaded and filtered successfully.")
    print("Columns found in the data:", df.columns)  # Debugging line to check column names

    # Determine the correct column name for the competitors
    competitor_column = None
    if 'Couple' in df.columns:
        competitor_column = 'Couple'
    elif 'Dancer' in df.columns:
        competitor_column = 'Dancer'
    else:
        print("Error: Neither 'Couple' nor 'Entrant' column found in the data. Available columns:", df.columns)
        return  # Exit if neither 'Couple' nor 'Entrant' column is found

    # Proceed with processing if the competitor column is found
    mappings = fetch_data_mappings(connection)
    style_id = mappings['styles'].get(style_name)
    if style_id is None:
        style_id = insert_missing_style(connection, style_name)
        mappings['styles'][style_name] = style_id  # Update mappings
    
    print(f"Using comp_id = {comp_id} for all entries.")
    judge_id_map, people_id_map = mappings['judges'], mappings['people']

    # Map judge ids to judges
    judge_ids = []
    missing_judges = []
    for judge_name in df.columns[2:]:
        judge_id = judge_id_map.get(judge_name)
        if judge_id is None:
            missing_judges.append(judge_name)
        judge_ids.append(judge_id)

    # Map couples id to couples, and score, and judge
    values_list = []
    missing_couples = []
    for _, row in df.iterrows():
        couple_name = row[competitor_column]  # Use the identified column for competitor name
        people_id = people_id_map.get(couple_name)
        if people_id is None:
            missing_couples.append(couple_name)
            continue

        scores = row[2:].tolist()
        for score, judge_id in zip(scores, judge_ids):
            if pd.notna(score) and isinstance(score, (int, float)):
                values_list.append((int(score), people_id, judge_id, style_id, comp_id))

    # Insert missing entries
    if missing_judges or missing_couples:
        print("Adding missing entries to database...")
        insert_missing_entries(connection, missing_judges, missing_couples)
        print("Missing entries added successfully.")

        # Refresh mappings after insertion
        mappings = fetch_data_mappings(connection)
        judge_id_map, people_id_map = mappings['judges'], mappings['people']

        # Update missing couples' people_ids
        for couple_name in missing_couples:
            people_id = people_id_map.get(couple_name)
            for _, row in df.iterrows():
                if row[competitor_column] == couple_name:
                    scores = row[2:].tolist()
                    for score, judge_id in zip(scores, judge_ids):
                        if pd.notna(score) and isinstance(score, (int, float)):
                            values_list.append((int(score), people_id, judge_id, style_id, comp_id))

    # Insert scores
    if values_list:
        insert_scores(connection, values_list)
    
    print("Data entry completed for event.")

    # Scrapes table data from the event URL and saves it to an Excel file
def scrape_table_to_excel(url, output_filename=config.OUTPUT_FILE):
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(options=options)
    driver.get(url)

    try:
        header_element = driver.find_element(By.CSS_SELECTOR, "h1")
        # Extract and format style name from header element
        style_name = re.sub(
            r"\b(Amateur|Collegiate|Two-Step|Country)\b", # Remove unnecessary information (Amateur Collegiate is repeated too often)
            lambda match: {
                "Country": "Country Western", # Replacing specific terms for standardization
                "Two-Step": "Two Step"
            }.get(match.group(0), ""),
            header_element.text.replace("Results for", "")
        )

        # Remove all extra spaces within the string
        style_name = re.sub(r'\s+', ' ', style_name).strip()

        print(style_name)
    except Exception as e:
        print("Could not find header:", e)
        driver.quit()
        return None

    try:
        table = driver.find_element(By.XPATH, "//div[@id='results']//table")
        headers = [header.text for header in table.find_elements(By.TAG_NAME, "th")]
        rows = table.find_elements(By.TAG_NAME, "tr")
        data = [[cell.text for cell in row.find_elements(By.TAG_NAME, "td")] for row in rows]
        df = pd.DataFrame(data, columns=headers).drop(columns=['Style'], errors='ignore')
        df.to_excel(output_filename, index=False)
        print(f"Data saved to {output_filename}")
    except Exception as e:
        print("No table found:", e)
        driver.quit()
        return None

    driver.quit()
    return style_name

# ----------------------------------------------------------------------------------
#                           Optimized Database Insertion
# ----------------------------------------------------------------------------------

    # Inserts non-duplicate scores in bulk
def insert_scores(connection, values_list):
    cursor = connection.cursor()
    cursor.executemany(
        """
        INSERT IGNORE INTO scores (score, people_id, judge_id, style_id, comp_id)
        VALUES (%s, %s, %s, %s, %s)
        """,
        values_list
    )
    connection.commit()
    print("Scores inserted successfully.")
    cursor.close()

# ===================================================================================

def main():
    connection = create_connection()
    if connection is None:
        print("Failed to connect to the database.")
        return

    # Process all events for the given main competition URL
    process_all_events(connection)

if __name__ == "__main__":
    main()