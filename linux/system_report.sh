#!/bin/bash
folder="$HOME/reports"
subfolders=("daily" "errors" "archive")
tools=('git' 'python3' 'curl' 'nano')
DISK=$(df / | tail -1 | awk '{print $5}' | tr -d '%')
CPU_USAGE=$(top -bn1 | grep "Cpu(s)" | awk '{print $2}')
MEM_USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}' | cut -d. -f1)
found=0

for sub in "${subfolders[@]}"; do
    if [ ! -d "$folder/$sub" ]; then
        mkdir -p "$folder/$sub"
    fi
done

for tool in "${tools[@]}"; do
	if command -v $tool &>/dev/null; then
		echo "$tool is installed" | tee -a ~/reports/daily/tools.log
		((found++))
	else
		echo "$tool is missing" | tee -a ~/reports/daily/tools.log
	fi
done

echo "$CPU_USAGE"
echo "$DISK"
echo "$MEM_USAGE"

echo "$(date '+%Y-%m-%d %H:%M:%S') : Disk usage is $DISK" >> ~/reports/daily/health.log
echo "$(date '+%Y-%m-%d %H:%M:%S') : CPU usage is $CPU_USAGE" >> ~/reports/daily/health.log
echo "$(date '+%Y-%m-%d %H:%M:%S') : Memory usage is $MEM_USAGE" >> ~/reports/daily/health.log

if [ $DISK -gt 50 ]; then
	echo "WARNING Disk is at ${DISK}%" >> ~/reports/errors/warnings_found.log
else
	echo "Disk is okay"
fi

grep -rl "WARNING" ~/reports 2>/dev/null >> ~/reports/errors/warnings_found.log

while true; do
	read -p "Enter folder path in this format '~/...' Type quit to exit " folder1
	if [ $folder1 = "quit" ]; then
		break
	elif [ -d "$folder1" ]; then
		echo "$(ls -la $folder1)"
	else
		mkdir -p "$folder1"
		echo "$folder1 created"
	fi
done

chmod 755 ~/system_report.sh
find ~/reports -name "*.log" -exec chmod 644 {} \;


echo "=== SYSTEM SUMMARY ==="
echo "Tools Found: $found"
echo "Disk Status: ${DISK}%"
echo -e "Logs Created:\n- $folder/daily/tools.log\n- $folder/daily/health.log\n- $folder/errors/warnings_found.log\n======================"

(crontab -l 2>/dev/null | grep -v "system_report.sh"; echo "0 7 * * * $HOME/system_report.sh") | crontab -
