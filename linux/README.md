## This contains projects done in Linux phase of my DevOps journey

- server_setup.sh
## What it does
1. Creates this folder structure: ~/server/{logs, scripts, backup, config}
2. Check if git, curl, and python3 are installed using a for loop, and lods each result to
~/server/logs/setup.log with timestamps 
3. Set an environment variable called SERVER_NAME and write it to ~/server/config/.env 
4. Create a file called ~/server/config/info.txt containing: hostname, current user, date, and disk usage
5. Find all .sh files in the home folder and list them in ~/server/logs/scripts_found.log
6. Check disk usage - if above 80% write a warning to ~/server/logs/setup.log
7. Set correct permissions: 755 on all .sh files in ~/server/scripts, 644 on all .txt and .log files
8. Scheduled to run every day at 8 AM using crontab

- system_report.sh
## What it does
1. Creates folder structure ~/reports{daily,error,archive}
2.  Checks if git, curl, nano and python3 are installed using a for loop - log each result to
~/reports/daily/tools.log with timestamp
3. Gets disk, CPU and memory usage - logs all three to _/reports/daily/health.log with timestamp
4. Writes a warning line to ~/reports/errors/warnings_found.log if disk is above 50%
5. Search ~/reports recursively for files containing the word "ERROR"
6. Asks user for a folder path and echoes it's contents if it exists. Keeps asking until user types quit
7. Used cron job to run script everyday at 7 AM

## Usage
'''bash
chmod +x file_name.sh
./filename.sh
'''
