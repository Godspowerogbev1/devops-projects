## This contains projects I did during bash phase of my DevOps journey

- dev_checker.sh
## What it does
1. Show current user, date, and directory
2. Check if python3 is installed - logs OK or MISSING
3. Check if git is installed - slog OK or MISSING 
4. Get disk usage percentage and slog OK / WARNING (>70%) / CRITICAL (>90%) 
5. Write ALL results to a file called dev_report.log with timestamps 
6. Print how many checks passed vs failed

## Usage
'''bash
chmod +x dev_checker.sh
./dev_checker.sh
'''
