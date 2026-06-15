import os
import shutil

# defining folderrs
folder = input("Enter folder path: ")
video = os.path.join(folder, "Videos")
music = os.path.join(folder, "Music")
images = os.path.join(folder, "Images")
docs = os.path.join(folder, "Document")
others = os.path.join(folder, "Others")
files = os.listdir(folder)

# Checking if folder exists
if not os.path.exists(folder):
    print(f"{folder} does not exist")

for destination in [video, music, images, docs, others]:
    if not os.path.exists(destination):
        os.makedirs(destination)

for file in files:
    file_path = os.path.join(folder, file)
    if os.path.isfile(file_path):
        file_name = os.path.splitext(file)
        extension = file_name[1]
        extension = extension.lower()

        if extension in [".mp4", ".mkv", ".avi", ".mov"]:
            shutil.move(file_path, video)
        elif extension in [".mp3", ".wav", ".flac", ".aac"]:
            shutil.move(file_path, music)
        elif extension in [".jpg", ".jpeg", ".png", ".gif", ".svg"]:
            shutil.move(file_path, images)
        elif extension in [".pdf", ".docx", ".txt", ".csv", ".md"]:
            shutil.move(file_path, docs)
        else:
            shutil.move(file_path, others)
