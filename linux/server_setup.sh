#!/bin/bash

DISKS=$(df / | tail -1 | awk '{print $5}'| tr -d '%')
echo "=== Server Setup Script ==="
mkdir -p  ~/server/{logs,scripts,backup,config}
tools=('git' 'curl' 'python3')
found=0

for tool in "${tools[@]}"; do
	if command -v "$tool" &> /dev/null; then
		echo "$(date '+%Y-%m-%d %H:%M:%S') - $tool is installed" | tee -a ~/server/logs/setup.log
		((found++))
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S') - $tool not installed" | tee -a ~/server/logs/setup.log
	fi
done

SERVER_NAME="godspower-server"
export SERVER_NAME

echo "SERVER_NAME=$SERVER_NAME" >> ~/server/config/.env

cat > ~/server/config/info.txt << EOF
HOSTNAME=$(hostname)
CURRENT_USER=$USER
DATE=$(date '+%Y-%m-%d')
DISK_USAGE=${DISKS}%
EOF

find ~ -type f -name "*.sh" >>  ~/server/logs/scripts_found.log

if [ $DISKS -gt 80 ]; then
	echo "WARNING!!!, Disk usage is at $DISKS" >> ~/server/logs/setup.log
fi

chmod 755 ~/server/scripts/*.sh 2>/dev/null
chmod 644 ~/server/config/*.txt  ~/server/logs/*.log 2>/dev/null

echo "=== Summary ==="
echo "$found tools were found"
if [ $DISKS -gt 80 ]; then
	echo "Warning!!! Disk is at ${DISKS}%"
else
	echo "Disk is fine"
fi
echo -e "Created paths:\n~/server/logs/setup\n~/server/config/.env\n~/server/config/info.txt\n~/server/logs/scripts_found.log"


(crontab -l 2>/dev/null | grep -v "server_setup.sh"; echo "0 8 * * * $HOME/server/server_setup.sh") | crontab -
echo "Scheduled to run daily at 8 AM"
