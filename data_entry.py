import time
import mysql.connector
from mysql.connector import Error
import pandas as pd
from selenium import webdriver
from selenium.webdriver.common.by import By
from selenium.webdriver.chrome.service import Service
from webdriver_manager.chrome import ChromeDriverManager
import tkinter as tk
from tkinter import messagebox

import config 

# ----------------------------------------------------------------------------------
#                      Connecting to MySQL and Fetching Dataset
# ----------------------------------------------------------------------------------

def create_connection():
    """Establishes a connection to the MySQL database."""
    try:
        connection = mysql.connector.connect(
            host=config.DB_HOST,
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

def fetch_all_competition_names(connection):
    query = "SELECT name FROM comp"
    cursor = connection.cursor(buffered=True)
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    return [name[0] for name in results] if results else []

def fetch_style_id(connection, style_name):
    cursor = connection.cursor()
    cursor.execute("SELECT id FROM style WHERE name LIKE %s", (style_name,))
    result = cursor.fetchone()
    cursor.close()
    return result[0] if result else None

def fetch_competition_id(connection, competition_name):
    cursor = connection.cursor()
    cursor.execute("SELECT id FROM comp WHERE name LIKE %s", (competition_name,))
    result = cursor.fetchone()
    cursor.close()
    return result[0] if result else None

def fetch_judge_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT name, id FROM judges")
    results = cursor.fetchall()
    cursor.close()
    return {judge_name: judge_id for judge_name, judge_id in results}

def fetch_people_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT name, id FROM people")
    results = cursor.fetchall()
    cursor.close()
    return {couple_name: people_id for couple_name, people_id in results}

# ----------------------------------------------------------------------------------
#                        User Entered Data, Data Collection
# ----------------------------------------------------------------------------------
def get_event_links(main_url):
    """Scrapes the main competition URL to gather all event links."""
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    driver.get(main_url)
    time.sleep(3)  # Wait for page to load

    event_links = []
    try:
        # Find all event-specific links on the main competition page
        link_elements = driver.find_elements(By.CSS_SELECTOR, "a")  # Adjust selector as needed based on HTML structure
        for element in link_elements:
            href = element.get_attribute("href")
            # Only add links that match the event-specific URL pattern
            if href and "results.php?cid=120&eid=" in href:
                event_links.append(href)
        print(f"Found {len(event_links)} event links.")
        
    except Exception as e:
        print("Error finding event links:", e)
    
    driver.quit()
    return event_links

def process_all_events(connection, main_url, competition_name):
    """Processes each event link found on the main competition page."""
    event_links = get_event_links(main_url)
    if not event_links:
        print("No event links found.")
        return

    # Process each event link individually
    for event_url in event_links:
        print(f"Processing event: {event_url}")
        process_data(connection, event_url, competition_name)
    print("Completed processing all events.")

def process_data(connection, url, competition_name):
    """Scrapes and processes data from a single event URL."""
    output_filename = config.OUTPUT_FILE
    style_name = scrape_table_to_excel(url, output_filename)
    if not style_name:
        print(f"Failed to scrape data from the webpage: {url}")
        return

    # Check if the style exists in the database, or add it if missing
    style_id = fetch_style_id(connection, style_name)
    if style_id is None:
        style_id = insert_missing_style(connection, style_name)

    # Set comp_id directly to 4
    comp_id = 4
    print(f"Using comp_id = {comp_id} for all entries.")

    # Fetch mappings for judges and couples
    judge_id_map = fetch_judge_id_mapping(connection)
    people_id_map = fetch_people_id_mapping(connection)

    # Load Excel data into DataFrame for processing
    df = pd.read_excel(output_filename)
    print("Excel data loaded successfully.")

    df = df.loc[:, ~df.columns.str.contains("Number", case=False)]
    judge_names = df.columns[2:]
    judge_ids = []
    missing_judges = []

    for judge_name in judge_names:
        judge_id = judge_id_map.get(judge_name)
        if judge_id is None:
            missing_judges.append(judge_name)
        judge_ids.append(judge_id)

    values_list = []
    missing_couples = []
    for _, row in df.iterrows():
        couple_name = row['Couple']
        people_id = people_id_map.get(couple_name)
        if people_id is None:
            missing_couples.append(couple_name)
            continue

        scores = row[2:].tolist()
        for score, judge_id in zip(scores, judge_ids):
            if pd.notna(score) and isinstance(score, (int, float)):
                values_list.append((int(score), people_id, judge_id, style_id, comp_id))

    # Automatically insert missing entries (judges and couples) if found
    if missing_judges or missing_couples:
        print("Adding missing entries to database...")
        insert_missing_entries(connection, missing_judges, missing_couples)
        print("Missing entries added successfully.")

        # Refresh judge and people mappings after insertion
        judge_id_map = fetch_judge_id_mapping(connection)
        people_id_map = fetch_people_id_mapping(connection)

        # Re-assign judge_ids after adding missing entries
        judge_ids = [judge_id_map.get(judge_name) for judge_name in judge_names]

        # Update people_ids for missing couples
        for _, row in df.iterrows():
            couple_name = row['Couple']
            if couple_name in missing_couples:
                people_id = people_id_map.get(couple_name)
                scores = row[2:].tolist()
                for score, judge_id in zip(scores, judge_ids):
                    if pd.notna(score) and isinstance(score, (int, float)):
                        values_list.append((int(score), people_id, judge_id, style_id, comp_id))

    # Insert scores after adding any missing entries
    if values_list:
        insert_scores(connection, values_list)
    
    print("Data entry completed for event.")

def get_user_input(connection):
    def submit_form():
        # Get user input from the form
        url = url_entry.get()
        competition_name = competition_name_var.get()

        if not url or not competition_name:
            messagebox.showerror("Input Error", "All fields are required.")
            return
        
        # Process data without closing the form
        process_data(connection, url, competition_name)
        
        # Clear fields for the next entry
        url_entry.delete(0, tk.END)
        competition_name_var.set(competition_names[0] if competition_names else '')

    # Window formatting
    root = tk.Tk()
    root.title("Competition Data Entry")
    root.geometry("400x300")
    root.resizable(False, False)

    tk.Label(root, text="Enter Competition Details", font=("Arial", 14)).pack(pady=10)
    frame = tk.Frame(root)
    frame.pack(pady=10)

    tk.Label(frame, text="URL:", font=("Arial", 10)).grid(row=0, column=0, sticky="e", padx=5, pady=5)
    url_entry = tk.Entry(frame, width=40)
    url_entry.grid(row=0, column=1, padx=5, pady=5)

    tk.Label(frame, text="Competition Name:", font=("Arial", 10)).grid(row=3, column=0, sticky="e", padx=5, pady=5)
    competition_name_var = tk.StringVar(root)
    competition_names = fetch_all_competition_names(connection)
    if competition_names:
        competition_name_var.set(competition_names[0])

    competition_dropdown = tk.OptionMenu(frame, competition_name_var, *competition_names)
    competition_dropdown.config(width=35)
    competition_dropdown.grid(row=1, column=1, padx=5, pady=5)

    submit_button = tk.Button(root, text="Submit", command=submit_form, font=("Arial", 20), bg="black", fg="white")
    submit_button.pack(padx=30, pady=20)

    root.mainloop()

def scrape_table_to_excel(url, output_filename=config.OUTPUT_FILE):
    # Configure headless browser options
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    # Access the URL
    driver.get(url)
    time.sleep(5)  # Wait for the page to load

    # Attempt to locate the header element and extract the style name
    style_name = None
    try:
        # Use the full CSS path to find the <h1> header element
        header_element = driver.find_element(By.CSS_SELECTOR, "html body div#all-wrapper div.main-wrapper div.main-content h1")
        header_text = header_element.text
        print(f"Original header: {header_text}")
        
        # Remove "Results for" and "Amateur Collegiate" from the header text
        style_name = header_text.replace("Results for", "").replace("Amateur Collegiate", "").strip()
        print(f"Extracted Style Name: {style_name}")
        
    except Exception as e:
        print("Could not find header in specified path:", e)
        driver.quit()
        return None  # Exit if header is not found

    # Locate the table on the page
    try:
        table = driver.find_element(By.XPATH, "//div[@id='results']//table")
    except Exception as e:
        print("No table found in the HTML.")
        driver.quit()
        return None  # Exit if table is not found

    # Extract table headers and rows
    headers = [header.text for header in table.find_elements(By.TAG_NAME, "th")]
    rows = table.find_elements(By.TAG_NAME, "tr")
    data = []
    for row in rows:
        cells = row.find_elements(By.TAG_NAME, "td")
        row_data = [cell.text for cell in cells]
        data.append(row_data)

    # Create DataFrame from the table data (no 'Style' column)
    df = pd.DataFrame(data, columns=headers)

    # Save to Excel without the 'Style' column
    df.to_excel(output_filename, index=False)
    print(f"Data scraped and saved to {output_filename}")

    driver.quit()
    return style_name  # Return the cleaned style name for further processing

# ----------------------------------------------------------------------------------
#                           Error Checking and Correction
# ----------------------------------------------------------------------------------

# Check for duplicate score entries
def check_for_duplicates(connection, score, people_id, judge_id, style_id, comp_id):
    cursor = connection.cursor()
    query = """
        SELECT 1 FROM scores
        WHERE score = %s AND people_id = %s AND judge_id = %s AND style_id = %s AND comp_id = %s
    """
    cursor.execute(query, (score, people_id, judge_id, style_id, comp_id))
    result = cursor.fetchone()
    cursor.close()
    return result is not None  # True if duplicate exists

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
    
def insert_missing_style(connection, style_name):
    """Insert a missing style into the database and return its ID."""
    cursor = connection.cursor()
    cursor.execute("INSERT INTO style (name) VALUES (%s)", (style_name,))
    connection.commit()
    style_id = cursor.lastrowid
    cursor.close()
    print(f"Added missing style: '{style_name}' with ID {style_id}")
    return style_id
    
# ----------------------------------------------------------------------------------
#                        Exporting Data to MySQL Database
# ----------------------------------------------------------------------------------

def insert_scores(connection, values_list):
    cursor = connection.cursor()
    try:
        non_duplicate_values = []
        for entry in values_list:
            score, people_id, judge_id, style_id, comp_id = entry
            if not check_for_duplicates(connection, score, people_id, judge_id, style_id, comp_id):
                non_duplicate_values.append(entry)
            else:
                print(f"Duplicate entry found, skipping: (score={score}, people_id={people_id}, judge_id={judge_id}, style_id={style_id}, comp_id={comp_id})")
        
        if non_duplicate_values:
            cursor.executemany(
                "INSERT INTO scores (score, people_id, judge_id, style_id, comp_id) VALUES (%s, %s, %s, %s, %s)",
                non_duplicate_values
            )
            connection.commit()
            print("Scores inserted successfully.")
    except Error as e:
        connection.rollback()
        print(f"Error inserting scores: {e}")
    finally:
        cursor.close()
        
# ===================================================================================

def main():
    connection = create_connection()
    if connection is None:
        print("Failed to connect to the database.")
        return
    
    # Replace this with the main competition URL
    main_competition_url = "https://ballroomcompexpress.com/results.php?cid=120"
    competition_name = "Competition Name"  # Replace with the actual competition name

    # Process all events for the given main competition URL
    process_all_events(connection, main_competition_url, competition_name)

if __name__ == "__main__":
    main()