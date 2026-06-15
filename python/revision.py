import os
import shutil
import datetime

name = input("Enter your name: ")
folder = input("Enter folder path: ")
folder = os.path.expanduser(folder)
date = datetime.datetime.now().strftime("%Y-%m-%d %H:%M:%S")

os.makedirs(folder, exist_ok=True)
ful_path = os.path.join(folder, "report.txt")
with open(ful_path, "w") as f:
    f.write(f"Name: {name}\nDate: {date}\nStatus: check complete")

for i in range(1, 11):
    if i % 2 == 0:
        print(i)


while True:
    number = int(input("Guess a number between 1-5"))
    if number == 3:
        print("Correct")
        break
    else:
        print("Wrong number, try again")

full_path = os.path.join(folder, "backup")
os.makedirs(full_path, exist_ok=True)
if not os.path.exists(os.path.join(full_path, "report.txt")):
    shutil.move(ful_path, full_path)

print(f"report is in {os.path.join(full_path, 'report.txt')}")
