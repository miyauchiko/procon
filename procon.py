import time
import random
import colorama
from colorama import Fore, Back, Style
colorama.init(autoreset=True)
gameover=False
p=1
h=5
w=7
stn=[]
flg=[]
for i in range(h*w):
    stn.append(i)
    flg.append(0)

def show_matrix():
    for i in range(w*h):
        if flg[i] == 0:
            print(str(stn[i]).zfill(2), end=" ")
        elif flg[i] == 1:
            print(Back.BLUE + str(stn[i]).zfill(2), end=" ")
        elif flg[1] == -1:
            print(Back.RED + str(stn[i]).zfill(2), end=" ")
        if i % w == w-1:
            print()

def pickup():
    if p == 0:
        print("P is 0")
    elif p == 1:
        return random.randint(0,w*h-1)
    elif p == -1:
        return random.randint(0,w*h-1)

def trial(picked):
    return picked

def flging(picked):
    global flg
    flg[picked] = p

def turning():
    global p
    global gameover
    if 0 not in flg:
        gameover = True
    p *= -1

def referee():
    global gameover
    if 0 not in flg:
        gameover=True
        print("winner is p")

while gameover == False:
    show_matrix()
    time.sleep(0.1)
    flging(trial(pickup()))
    referee()
    turning()
    #gameover=True
#EOF
