# 🤖 LeetCode Q&A Scraper with GitHub Automation

This project uses **Python** and **Selenium** to scrape LeetCode Q&A content from my profile — specifically, the **questions and their corresponding answers** — and saves them into a structured JSON file. The data is then automatically pushed to a GitHub repository using a workflow I built in **[n8n](https://n8n.io/)**.

## 🔧 What It Does

- Scrapes **questions and answers** from LeetCode using Selenium
- Converts the scraped content into a clean, readable `.json` format
- Uses **n8n** to automate:
  - Creating a dated folder in the repo
  - Uploading the new JSON file
  - Repeating the process automatically on a schedule


## 🛠️ Technologies Used

- **Python**
  - `Selenium`: For scraping LeetCode Q&A data
  - `json`: For formatting the scraped data

- **n8n**
  - Workflow automation to handle GitHub folder creation and file updates

- **GitHub**
  - Serves as the storage for scraped and versioned Q&A data

## ✅ Use Cases

- Keep a personal archive of your LeetCode practice
- Track your progress and reflections over time
- Use the JSON files for visualizations, dashboards, or custom tools

⚙️ How It Works
- Run the Python script to scrape your latest LeetCode Q&A content.
- Convert the data into JSON format.
- Trigger the n8n workflow, which:
- Creates a folder based on the section name (Eg., If you're scraping SQL Practice problems, then there might be different sections like Basics, joins, etc,.)
- Creates a file with the name as the Question and its contents as the answer.
- Automate it to run daily, weekly, or after each practice session.

