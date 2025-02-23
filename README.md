A minimalist widget to display your Todoist tasks on your desktop.
## Beta Notice
This is an experimental/beta project. While it has been tested, you may encounter unexpected issues. Please report any bugs or suggestions in the Issues section.

## Features
- Displays pending tasks from Todoist.
- Customizable filters (by project, labels, etc.).
- Automatic updates every 5 minutes.
- Clean and customizable design.
- Starts automatically at login.

## Requirements
- Conky (v1.10 or higher)
- Python 3 (with the requests library)
- Bash (for helper scripts)

## Installation
### 1. Run the installation script:
```bash
bash <(curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/install.sh)
```

### 2. Configure the API Token:
1. Get your API Token from [Todoist](https://todoist.com/app/settings/integrations).
2. Edit the configuration file:
```bash
nano ~/.config/conky/todoist-conky/scripts/todoist_conky.py
```
3. Replace `YOUR_API_TOKEN_HERE` with your token.

## Usage
### Start manually:
```bash
conky -c ~/.config/conky/todoist-conky/conky.conf
```

### Restart after changes:
If you modify the script or configuration, restart Conky:
```bash
killall conky && conky -c ~/.config/conky/todoist-conky/conky.conf
```

### Automatic updates:
The widget updates every 5 minutes.
You can also restart your system to apply changes.

## Customization
Filters:
Edit the todoist_conky.py file and modify the FILTER variable:
```python
FILTER = "project:Work & due:today"  # Example: tasks from the "Work" project due today
```
Colors and fonts:
Edit `~/.config/conky/todoist-conky/conky.conf` to adjust:
- Fonts (font).
- Colors (color0, color1, etc.).
- Position (alignment, gap_x, gap_y).

## Uninstallation
1. Run the uninstallation script:
```bash
bash <(curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/uninstall.sh)
```
2. Manual removal (optional):
If you prefer to do it manually:
```bash
rm -rf ~/.config/conky/todoist-conky
rm ~/.config/autostart/conky-todoist.desktop
killall conky
```
## Troubleshooting
### 1. Tasks not showing:
- Verify that the API Token is correct.
- Ensure the filter is not hiding tasks.

### 2. Error 404 during installation:
Run in debug mode:
```bash
Copy
bash -x <(curl -sL https://raw.githubusercontent.com/oscar370/conky-todoist/main/install.sh)
```

### 3. Widget does not start automatically:
- Verify that the .desktop file is in ~/.config/autostart/.
- Ensure Conky is installed correctly.
