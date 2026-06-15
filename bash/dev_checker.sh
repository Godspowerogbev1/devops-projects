#!/bin/bash
PASSED=0
FAILED=0

header() {
	echo "=== Dev Environment Check ===" | tee -a dev_report.log
}
user() {
	echo $(whoami) | tee -a dev_report.log
}
current_date() {
	echo $(date '+%Y-%m-%d') | tee -a dev_report.log
}
current_directory() {
	echo $(pwd) | tee -a dev_report.log
}
check_python() {
	if command -v python3 &>/dev/null; then
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Python is installed" | tee -a dev_report.log
		((PASSED++))
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Missing" | tee -a dev_report.log
		((FAILED++))
	fi
}
check_git() {
	if command -v git &>/dev/null; then
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Git is installed" | tee -a dev_report.log
		((PASSED++))
	else
		echo "$(date '+%Y-%m-%d %H:%M:%S') - Missing" | tee -a dev_report.log
		((FAILED++))
	fi
}
disk_usage() {
	df / | tail -1 | awk '{print $5}' |  tr -d '%'
}
output() {
header
user
current_date
current_directory
check_python
check_git
DISK=$(disk_usage)
echo "Disk usage is ${DISK}%"
if [ $DISK -gt 90 ]; then
	echo "$(date '+%Y-%m-%d %H:%M:%S') - CRITICAL" | tee -a dev_report.log
	((FAILED++))
elif [ $DISK -gt 70 ]; then
	echo "$(date '+%Y-%m-%d %H:%M:%S') - Warning" | tee -a dev_report.log
	((FAILED++))
else
	echo "$(date '+%Y-%m-%d %H:%M:%S') - OK" | tee -a dev_report.log
	((PASSED++))
fi
}
output

tools=('python3' 'git' 'nano')
	for tool in "${tools[@]}"; do
		if command -v "$tool" &>/dev/null; then
			echo "$tool is installed"
			((PASSED++))
		else
			echo "$tool not installed"
			((FAILED++))
		fi
	done
echo -e "PASSED: $PASSED\nFAILED: $FAILED"
