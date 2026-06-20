import datetime
import os


def get_timestamp():
    return datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")


def log(message, filename):
    with open(filename, "a") as f:
        f.write(f"{get_timestamp()} - message\n")


def format_percent(value):
    return f"{value:.1f}%"
