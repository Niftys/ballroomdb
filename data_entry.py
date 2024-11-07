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

def create_connection():
    try:
        connection = mysql.connector.connect(
            host="127.0.0.1",
            user="root",
            password="shusushi",
            database="ballroomdb"
        )
        if connection.is_connected():
            print("Connection successful")
        return connection
    except Error as e:
        print("Error connecting to MySQL", e)
        return None

def fetch_all_competition_names(connection):
    query = "SELECT name FROM Comp"
    cursor = connection.cursor(buffered=True)
    cursor.execute(query)
    results = cursor.fetchall()
    cursor.close()
    return [name[0] for name in results] if results else []

def get_user_input(connection):
    def submit_form():
        # Store user inputs in a dictionary
        user_inputs["url"] = url_entry.get()
        user_inputs["competition_name"] = competition_name_var.get()
        user_inputs["style_name"] = style_name_entry.get()

        if not user_inputs["url"] or not user_inputs["competition_name"] or not user_inputs["style_name"]:
            messagebox.showerror("Input Error", "All fields are required.")
            return
        else:
            root.destroy()  # Close the form window

    user_inputs = {}

    root = tk.Tk()
    root.title("Competition Data Entry")
    root.geometry("400x250")
    root.resizable(False, False)

    tk.Label(root, text="Enter Competition Details", font=("Arial", 14)).pack(pady=10)
    frame = tk.Frame(root)
    frame.pack(pady=10)

    tk.Label(frame, text="URL:", font=("Arial", 10)).grid(row=0, column=0, sticky="e", padx=5, pady=5)
    url_entry = tk.Entry(frame, width=40)
    url_entry.grid(row=0, column=1, padx=5, pady=5)

    tk.Label(frame, text="Competition Name:", font=("Arial", 10)).grid(row=1, column=0, sticky="e", padx=5, pady=5)
    competition_name_var = tk.StringVar(root)
    competition_names = fetch_all_competition_names(connection)
    if competition_names:
        competition_name_var.set(competition_names[0])

    competition_dropdown = tk.OptionMenu(frame, competition_name_var, *competition_names)
    competition_dropdown.config(width=35)
    competition_dropdown.grid(row=1, column=1, padx=5, pady=5)

    tk.Label(frame, text="Style Name:", font=("Arial", 10)).grid(row=2, column=0, sticky="e", padx=5, pady=5)
    style_name_entry = tk.Entry(frame, width=40)
    style_name_entry.grid(row=2, column=1, padx=5, pady=5)

    submit_button = tk.Button(root, text="Submit", command=submit_form, font=("Arial", 10), bg="black", fg="white")
    submit_button.pack(pady=10)

    root.mainloop()
    return user_inputs["url"], user_inputs["competition_name"], user_inputs["style_name"]

# Rest of the code continues as before...


def scrape_table_to_excel(url, output_filename='E:/Desktop/Coding/Python/ballroomdb/competition_data.xlsx'):
    options = webdriver.ChromeOptions()
    options.add_argument("--headless")
    driver = webdriver.Chrome(service=Service(ChromeDriverManager().install()), options=options)

    driver.get(url)
    time.sleep(5)

    try:
        table = driver.find_element(By.XPATH, "//div[@id='results']//table")
    except Exception as e:
        print("No table found in the HTML.")
        driver.quit()
        return False

    headers = [header.text for header in table.find_elements(By.TAG_NAME, "th")]
    rows = table.find_elements(By.TAG_NAME, "tr")
    data = []
    for row in rows:
        cells = row.find_elements(By.TAG_NAME, "td")
        row_data = [cell.text for cell in cells]
        data.append(row_data)

    df = pd.DataFrame(data, columns=headers)
    df.to_excel(output_filename, index=False)
    print(f"Data scraped and saved to {output_filename}")

    driver.quit()
    return True

def fetch_style_id(connection, style_name):
    cursor = connection.cursor()
    cursor.execute("SELECT id FROM Style WHERE name LIKE %s", (style_name,))
    result = cursor.fetchone()
    cursor.close()
    return result[0] if result else None

def fetch_competition_id(connection, competition_name):
    cursor = connection.cursor()
    cursor.execute("SELECT id FROM Comp WHERE name LIKE %s", (competition_name,))
    result = cursor.fetchone()
    cursor.close()
    return result[0] if result else None

def fetch_judge_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT name, id FROM Judges")
    results = cursor.fetchall()
    cursor.close()
    return {judge_name: judge_id for judge_name, judge_id in results}

def fetch_people_id_mapping(connection):
    cursor = connection.cursor()
    cursor.execute("SELECT name, id FROM People")
    results = cursor.fetchall()
    cursor.close()
    return {couple_name: people_id for couple_name, people_id in results}

# Check for duplicate score entries
def check_for_duplicates(connection, score, people_id, judge_id, style_id, comp_id):
    cursor = connection.cursor()
    query = """
        SELECT 1 FROM Scores
        WHERE score = %s AND people_id = %s AND judge_id = %s AND style_id = %s AND comp_id = %s
    """
    cursor.execute(query, (score, people_id, judge_id, style_id, comp_id))
    result = cursor.fetchone()
    cursor.close()
    return result is not None  # True if duplicate exists

def insert_missing_entries(connection, missing_judges, missing_couples):
    cursor = connection.cursor()
    cursor.executemany("INSERT INTO Judges (name) VALUES (%s)", [(judge,) for judge in missing_judges])
    cursor.executemany("INSERT INTO People (name) VALUES (%s)", [(couple,) for couple in missing_couples])

    connection.commit()
    cursor.close()

def insert_scores(connection, values_list):
    cursor = connection.cursor()
    try:
        # Insert scores that are not duplicates
        non_duplicate_values = []
        for entry in values_list:
            score, people_id, judge_id, style_id, comp_id = entry
            if not check_for_duplicates(connection, score, people_id, judge_id, style_id, comp_id):
                non_duplicate_values.append(entry)
            else:
                print(f"Duplicate entry found, skipping: (score={score}, people_id={people_id}, judge_id={judge_id}, style_id={style_id}, comp_id={comp_id})")
        
        if non_duplicate_values:
            cursor.executemany(
                "INSERT INTO Scores (score, people_id, judge_id, style_id, comp_id) VALUES (%s, %s, %s, %s, %s)",
                non_duplicate_values
            )
            connection.commit()
            print("Scores inserted successfully.")
    except Error as e:
        connection.rollback()
        print(f"Error inserting scores: {e}")
    finally:
        cursor.close()

def main():
    connection = create_connection()
    if connection is None:
        print("Failed to connect to the database.")
        return

    while True:
        url, competition_name, style_name = get_user_input(connection)
        if not url or not competition_name or not style_name:
            print("URL, competition name, or style name not provided.")
            return

        output_filename = "E:/Desktop/Coding/Python/ballroomdb/competition_data.xlsx"
        scrape_success = scrape_table_to_excel(url, output_filename)
        if not scrape_success:
            print("Failed to scrape data from the webpage.")
            return

        style_id = fetch_style_id(connection, style_name)
        comp_id = fetch_competition_id(connection, competition_name)
        if style_id is None or comp_id is None:
            print("Style or competition not found in the database. Please verify the names.")
            return

        judge_id_map = fetch_judge_id_mapping(connection)
        people_id_map = fetch_people_id_mapping(connection)

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

        insert_missing_entries(connection, missing_judges, missing_couples)
        if not missing_judges and not missing_couples and values_list:
            insert_scores(connection, values_list)
        
        print("Data entry completed.")

if __name__ == "__main__":
    main()
