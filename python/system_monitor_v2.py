import psutil
import sys
import time
from utils import log, get_timestamp, format_percent


def get_cpu():
    try:
        cpu_usage = psutil.cpu_percent(interval=1)
        return cpu_usage
    except Exception as e:
        log(f"Error: CPU check failed {e}", "monitor.log")
        return None


def get_memory():
    try:
        mem = psutil.virtual_memory().percent
        return mem
    except Exception as e:
        log(f"Error: Memory check failed {e}", "monitor.log")
        return None


def get_disk(path='/'):
    try:
        disk = psutil.disk_usage('/').percent
        return disk
    except FileNotFoundError:
        log(f"Error: Disk check failed, File not found!!!", "monitor.log")
        return None
    except Exception as e:
        log(f"Error: Disk check failed {e}", "monitor.log")
        return None


def check_metric(name, value, threshold):
    if value == None:
        return "ERROR"

    if value > threshold:
        return "WARNING"

    return "OK"


def run_monitor(cpu_threshold, mem_threshold, disk_threshold, interval=10, log_file="monitor.log"):
    while True:
        cpu = get_cpu()
        mem = get_memory()
        disk = get_disk()

        cpu_status = check_metric(
            "CPU", cpu, cpu_threshold) if cpu is not None else "ERROR"
        mem_status = check_metric(
            "Memory", mem, mem_threshold) if mem is not None else "ERROR"
        disk_status = check_metric(
            "Disk", disk, disk_threshold) if disk is not None else "ERROR"

        cpu_str = format_percent(cpu)if cpu is not None else "N/A"
        mem_str = format_percent(mem)if mem is not None else "N/A"
        disk_str = format_percent(disk)if disk is not None else "N/A"

        log_messagge = f"CPU: {cpu_str} - {cpu_status} | Disk: {disk_str} - {disk_status} | Memory: {mem_str} - {mem_status}"
        print(f"{get_timestamp()} - {log_messagge}")
        log(log_messagge, log_file)

        time.sleep(interval)


if __name__ == "__main__":
    cpu_default = 80
    disk_default = 85
    mem_default = 90

    if len(sys.argv) == 4:
        try:
            cpu_default = int(sys.argv[1])
            disk_default = int(sys.argv[2])
            mem_default = int(sys.argv[3])
        except ValueError:
            print("Error: value must be integar, using defaults")
    elif len(sys.argv) > 1:
        print(
            f"Usage: python3 {sys.argv[0]}, <cpu_threshold> <disk_threshold> <mem_threshold>")
        print("Using internal defaults....")

    print(
        f"Monitor started | CPU limit: {cpu_default}% | Memory limit: {mem_default}% | Disk limit: {disk_default}%")

    try:
        run_monitor(cpu_default, mem_default, disk_default)
    except KeyboardInterrupt:
        print("\nMonitor Stoppped")
        sys.exit(0)
