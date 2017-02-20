#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
$gameover=$false
$h=5
$w=7
$p=1
$m=4
$ss=@()
$rs=@()
$flg=@(0)*$h*$w
$rs=$stones=0..($h*$w-1)
for($i=0;$i-lt$stones.Length;$i++){$stones[$i] = "{0:00}" -F $stones[$i]}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function display(){
    cls
    innermessage turn
    for($i=0; $i-lt$stones.Length; $i++){
        switch ($flg[$i]){
           -1{Write-Host -Object $stones[$i] -No -Back Red}
            0{Write-Host -Object $stones[$i] -No}
            1{Write-Host -Object $stones[$i] -No -Back Blue}
            2{Write-Host -Object $stones[$i] -No -Back White -Fore Black}
        }
        Write-Host " " -No
        if($i%$w-eq$w-1){Write-Host}
    }
    Start-Sleep -Milliseconds 50
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function ssreset(){
    for($i=0; $i-lt$flg.Count; $i++){
        if($flg[$i]-eq2){$flg[$i]=0}
    }
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function pickup(){
    ssreset
    $script:ss=$null
    switch ($p){
        -1{
            "get a stone at random"
            $script:ss+=Get-Random $rs -Count (Get-Random -Max $m -Min 3)
        }
        1{
            "get a stone at random"
            $script:ss+=Get-Random $rs -Count (Get-Random -Max $m -Min 3)
            #$script:ss+=Read-Host -Prompt "`ninput number "
            #$script:ss=$ss -split ","
            #$script:ss=$ss -split " "
        }
    }
    foreach($s in $ss){
        $script:flg[$s] = 2
    }
    if(!$ss){
        pickup
    }
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function decide(){
    $ss=[int[]]$ss|Sort-Object
    innermessage "select : $ss"
    $len=$ss.Count-1
    $max=$ss[$len]
    $min=$ss[0]
    $maxmod=$max%$w
    $maxdiv=($max-$maxmod)/$w
    $minmod=$min%$w
    $mindiv=($min-$minmod)/$w
    Write-Host "<check> " -NoNewline
    # error case
    if($ss -eq $null){
        Write-Host "null Retry!!"
        return $false
    }
    if($ss.Count -gt $m){
        Write-Host "over$m Retry!!"
        return $false
    }
    foreach($s in $ss){
        if($flg[$s]-eq1 -or $flg[$s]-eq-1){
            Write-Host "already Retry!!"
            return $false
        }
        if(0..($h*$w-1) -notcontains $s){
            Write-Host "out range Retry!!"
            return $false
        }
    }
    # regal case
    if($ss.Count-gt1){
        $comboflg=""
        # y = b
        <#
        if($max -eq $min+$len){
            if($maxdiv-eq$mindiv){
                for($i=0; $i-lt$len; $i++){
                    if(($ss[$i]-$ss[$i]%$w)/$w -eq ($ss[$i+1]-$ss[$i+1]%$w)/$w){
                        $comboflg="y=b"
                        $comboflg="horizontal"
                    }else{
                        return $false
                    }
                }
            }
        }
        #>
        # x = a
        <#
        if($max-eq$min+$len*$w){
            if($maxmod-eq$minmod){
                for($i=0; $i-lt$len; $i++){
                    if($ss[$i]%$w -eq $ss[$i+1]%$w){
                        $comboflg="y=b"
                        $comboflg="vertical"
                    }else{
                        return $false
                    }
                }
            }
        }
        #>
        # y = x()
        if($max -eq $min+$len*($w-1)){
            for($i=0; $i-lt$len; $i++){
                if($ss[$i]%$w -eq $ss[$i+1]%$w+1){
                    $comboflg="y(x)"
                }else{
                    return $false
                }
            }
        }
        # y = -x()
        if($max -eq $min+$len*($w+1)){
            for($i=0; $i-lt$len; $i++){
                if($ss[$i]%$w -eq $ss[$i+1]%$w-1){
                    #if(($ss[$i]-$ss[$i]%$w)/$w -eq ($ss[$i+1]-$ss[$i+1]%$w)/$w){
                        $comboflg="y(-x)"
                    #}
                }else{
                    return $false
                }
            }
        }
        if($comboflg){
            Write-Host "$comboflg combination!!" -NoNewline
        }else{
            Write-Host "miss combos"
            return $false
        }
    }else{
        Write-Host "single!!" -No
    }
    Write-Host "OK!!!`n"
    return $true
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function update(){
    foreach($s in $ss){
        $script:flg[$s] = $p
    }
    $script:rs=@()
    for($i=0; $i-lt$stones.Length; $i++){
        if($flg[$i] -eq 0){
            $script:rs+=[int]$stones[$i]
        }
    }
    $script:p *= -1
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function referee(){
    if($flg -notcontains 0){$script:gameover=$true}
    if($gameover){
        innermessage "W I N ! ! ! ! ! ! !"
    }
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
function innermessage($message){
    switch ($p){
        -1{Write-Host "`n[B $message]`n" -BackgroundColor Red}
         1{Write-Host "`n[A $message]`n" -BackgroundColor Blue}
    }
}
#■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■■
do{ 
    display
    do{pickup;display}while(!$(decide))
    Read-Host -Prompt "Press any key to continue"
    update
    referee
}while(!$gameover)
#EOF