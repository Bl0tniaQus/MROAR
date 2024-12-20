import os
import shutil
#XX_YY_ZZ
#XX - klasa zabytku
#YY - pora dnia/roku
#ZZ - numer zdjecia

##YY:
#00 - dzien jesien
#01 - noc jesien
#02 - dzien zima
#03 - noc zima
#04 - dzien wiosna
#05 - noc wiosna

pory = {"00" : "dzien_jesien", "01": "noc_jesien", "02" : "dzien_zima", "03" : "noc_zima", "04" : "dzien_wiosna", "05" : "noc_wiosna"}    
def makeDirs():
    os.mkdir("images")
    os.mkdir(os.path.join("images", "dzien_jesien"))
    os.mkdir(os.path.join("images", "noc_jesien"))
    os.mkdir(os.path.join("images", "dzien_zima"))
    os.mkdir(os.path.join("images", "noc_zima"))
    os.mkdir(os.path.join("images", "dzien_wiosna"))
    os.mkdir(os.path.join("images", "noc_wiosna"))
    for folder in os.scandir("images"):
        name = folder.name
        for i in range(50):
            if i<10:
                os.mkdir(os.path.join("images", name, str(0)+str(i)))
            else:
                os.mkdir(os.path.join("images", name, str(i)))


makeDirs()
for img in os.scandir("BR"):
    name_parts = img.name.split("_")
    shutil.copy(os.path.join("BR", img.name), os.path.join("images", pory[name_parts[1]], name_parts[0]))
