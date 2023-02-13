from PIL import Image
import os
import sys


def isImage(file):
    return ".png" in file or ".jpg" in file or ".webp" in file


def recursion_folder(_path):
    if os.path.isfile(_path):
        if isImage(_path):
            invert(os.path.abspath(_path))
        return
    else:
        for files in os.listdir(_path):
            recursion_folder(os.path.join(_path, files))


def invert(_path):
    
    avatar = Image.open(_path)
    img = avatar.convert("RGBA")
    datas = avatar.getdata()

    newData = []
    for items in datas:
        if items[3] ==255 :
            newData.append((0, 0, 0, 0))
        elif items[3] ==0 :
            newData.append((255, 255, 255, 255))
        else:
            item =255-items[3]
            newData.append((255, 255, 255, item))

    img.putdata(newData)
    image_path =_path.split("/")[len(_path.split("/")) - 1].split('.')[0]
    img.save("newline/"+image_path +".webp","WEBP")

recursion_folder(os.path.join(os.path.realpath(sys.argv[1])))