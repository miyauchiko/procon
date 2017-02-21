import os
import time
import random
import platform
import colorama
from colorama import Fore, Back, Style
colorama.init(autoreset=True)
gameover=False
p=1
h=3
w=4
ps=[]
stn=[i for i in range(h*w)]
flg=[0 for i in range(h*w)]
def show_matrix():
    if p==1:
        print(Back.BLUE+"turn of "+str(p))
    else:
        print(Back.RED +"turn of "+str(p))
    for i in range(w*h):
        if flg[i]==0:
            print(str(stn[i]).zfill(2), end=" ")
        elif flg[i]==1:
            print(Back.BLUE+str(stn[i]).zfill(2), end=" ")
        elif flg[i]==-1:
            print(Back.RED +str(stn[i]).zfill(2), end=" ")
        if i % w==w-1:
            print()
def pickup():
    if   p==1:
        return [random.randint(0,w*h-1),random.randint(0,w*h-1)]
    elif p==-1:
        return [random.randint(0,w*h-1)]
def trial(picked):
    global ps
    if p==1:
        print(Back.BLUE+str(p)+" picked "+str(picked))
    else:
        print(Back.RED +str(p)+" picked "+str(picked))
    for cs in picked:
        if flg[cs]==1:
            print("already!")
            return False
    ps=picked
    return True
def flging(picked):
    global flg
    for s in picked:
        flg[s] = p
def turning():
    global p
    p *= -1
def referee():
    global gameover
    if 0 not in flg:
        gameover=True
        print(Back.CYAN + "winner is %d" % -p)
def clearance():
    if  platform.system() == 'Windows':
        os.system('cls')
while gameover==False:
    clearance()
    show_matrix()
    while trial(pickup())==False:continue
    time.sleep(0.5)
    flging(ps)
    referee()
    turning()
#EOF
