p=1
h=5
w=7
stn=[]
flg=[]
for i in range(5*7):
    stn.append(i)
    flg.append(0)

import sys
sys.stdout.flush()

for i in range(5*7):
    if flg[i] == 0:
        print(str(stn[i]).zfill(2), end=' ')
    elif flg[i] == 1:
        print('', end='')
    elif flg[i] == -1:
        print('', end='')
    else:
        print(str(stn[i]).zfill(2), end=' ')
    if stn[i] % w == w-1:
        print()

#EOF
