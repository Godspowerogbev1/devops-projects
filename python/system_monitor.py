import psutil
import time
import datetime

while True:
    date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

    cpu = psutil.cpu_percent(interval=1)  # Check cpu
    print(f"CPU usage is: {cpu}%")

    memory = psutil.virtual_memory()  # Check RAM

    print(
        f"Total RAM is: {memory.total // (1024**3)}GB | RAM usage is: {memory.percent}%")

    disk = psutil.disk_usage("/")  # Check storage used
    print(
        f"Total disk space is: {disk.total // (1024**3)}GB | Disk usage is: {disk.percent}%")

    log = f"CPU: {cpu}% | RAM: {memory}% | Disk: {disk}% | Date: {date}\n"
    with open("report.txt", "a") as f:
        f.write(log)
    time.sleep(300)
