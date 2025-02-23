import requests
import argparse
from datetime import datetime

API_TOKEN = "YOUR_API_TOKEN_HERE"
TASKS_URL = "https://api.todoist.com/rest/v2/tasks"
FILTER = ""  # Optional: "due:today | project:Work"

def fetch_tasks():
    headers = {"Authorization": f"Bearer {API_TOKEN}"}
    try:
        response = requests.get(TASKS_URL, headers=headers)
        response.raise_for_status()
        return response.json()
    except Exception as e:
        print(f"ERROR::{str(e)}")
        return None

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--count", action="store_true")
    args = parser.parse_args()

    tasks = fetch_tasks()
    
    if args.count:
        print(len(tasks) if tasks and isinstance(tasks, list) else 0)
        return

    if not tasks or not isinstance(tasks, list):
        return

    for task in tasks:
        if not task or not isinstance(task, dict):
            continue  # Skip invalid tasks

        content = task.get('content', '').replace("||", "")
        due_data = task.get('due') or {}
        due_date = due_data.get('date', '') if isinstance(due_data, dict) else ''
        
        try:
            date_str = datetime.fromisoformat(due_date).strftime("%d/%m") if due_date else ""
        except ValueError:
            date_str = ""

        print(f"{date_str}||{content}" if date_str else f"||{content}")

if __name__ == "__main__":
    main()