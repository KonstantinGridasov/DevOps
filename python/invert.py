from PIL import Image
import os
import sys

count = 0
name_destination='destination'
format='PNG'

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
    image_name =_path.split("/")[len(_path.split("/")) - 1].split('.')[0]
    if format=='PNG':
       img.save(f"{name_destination}/"+image_name +".png","PNG")
    elif format=='WEBP':
       img.save(f"{name_destination}/"+image_name +".webp","WEBP")
        



def main():
    global name_destination
    global format
    if len(sys.argv)<2:
        print("comand not full : python3 invert.py [namefolder] [optional : namedestination default=destination] [optional : format (def: PNG)]")
        return
    
    if len(sys.argv)>2:
        name_destination = sys.argv[2]
    if len(sys.argv)>3:
        format =sys.argv[3]

    os.mkdir(os.path.join(os.path.realpath(name_destination)))
    recursion_folder(os.path.join(os.path.realpath(sys.argv[1])))


if __name__ == "__main__":
    main()
