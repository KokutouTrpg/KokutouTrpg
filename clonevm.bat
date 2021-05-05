set RPATH=.\VirtualBox VMs\
set SVNAME=%~1
set TVNAME=%~2

set TMAC_NAT=%~3
set TMAC_HO=%~4
set TMAC_IN=%~5
set TIP_HO=%~6
set TIP_IN=%~7

set SMACIP=%RPATH%%SVNAME%\
set /p SMAC_NAT=<"%SMACIP%MAC_NAT.txt"
set /p SMAC_HO=<"%SMACIP%MAC_HO.txt"
set /p SMAC_IN=<"%SMACIP%MAC_IN.txt"
set /p SIP_HO=<"%SMACIP%IP_HO.txt"
set /p SIP_IN=<"%SMACIP%IP_IN.txt"

VBoxManage clonevm %SVNAME% --name="%TVNAME%" --register --options=keepallmacs

set TMACIP=%RPATH%%TVNAME%\
echo %TMAC_NAT% > "%TMACIP%MAC_NAT.txt"
echo %TMAC_HO% > "%TMACIP%MAC_HO.txt"
echo %TMAC_IN% > "%TMACIP%MAC_IN.txt"
echo %TIP_HO% > "%TMACIP%IP_HO.txt"
echo %TIP_IN% > "%TMACIP%IP_IN.txt"

VBoxManage startvm "%TVNAME%" --type headless
timeout /nobreak 30
:L1
timeout /nobreak 5
ssh -i .\.ssh\id_rsa root@%SIP_HO%  ls
if %ERRORLEVEL%==0 goto :L1E
goto :L1
:L1E

ssh -i .\.ssh\id_rsa root@%SIP_HO% ./replaceNetworkSetting.sh %SMAC_NAT% %TMAC_NAT% NAT
ssh -i .\.ssh\id_rsa root@%SIP_HO% ./replaceNetworkSetting.sh %SMAC_HO% %TMAC_HO% HostOnly
ssh -i .\.ssh\id_rsa root@%SIP_HO% ./replaceNetworkSetting.sh %SMAC_IN% %TMAC_IN% Internel
ssh -i .\.ssh\id_rsa root@%SIP_HO% ./replaceNetworkSetting.sh %SIP_HO% %TIP_HO% HostOnly
ssh -i .\.ssh\id_rsa root@%SIP_HO% ./replaceNetworkSetting.sh %SIP_IN% %TIP_IN% Internel
timeout /nobreak 10

VBoxManage controlvm %TVNAME%  poweroff 
timeout /nobreak 10
	
VBoxManage modifyvm %TVNAME% --macaddress1 %TMAC_NAT::=%
VBoxManage modifyvm %TVNAME% --macaddress2 %TMAC_HO::=%
VBoxManage modifyvm %TVNAME% --macaddress3 %TMAC_IN::=%

VBoxManage startvm "%TVNAME%" --type headless
timeout /nobreak 30
:L2
timeout /nobreak 5
ssh -i .\.ssh\id_rsa root@%TIP_HO%  ls
if %ERRORLEVEL%==0 goto :L2E
GOTO :L2
:L2E

ssh -i .\.ssh\id_rsa root@%TIP_HO%
:ENND