import requests
import argparse
from datetime import datetime

API_TOKEN = "YOUR_API_TOKEN_HERE"
TASKS_URL = "https://api.todoist.com/rest/v2/tasks"

def fetch_tasks():
    headers = {"Authorization": f"Bearer {API_TOKEN}"}
    try:
        return requests.get(TASKS_URL, headers=headers).json()
    except Exception as e:
        print(f"ERROR::{str(e)}")
        return None

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument("--count", action="store_true")
    args = parser.parse_args()

    tasks = fetch_tasks()
    
    if args.count:
        print(len(tasks) if tasks else 0)
        return

    if tasks:
        for task in tasks:
            content = task['content'].replace("||", "")
            due_date = task.get('due', {}).get('date', '')
            date_str = datetime.fromisoformat(due_date).strftime("%d/%m") if due_date else ""
            print(f"{date_str}||{content}")

if __name__ == "__main__":
    main()