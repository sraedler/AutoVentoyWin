REM =============================
REM WIFI Connection Tool
REM An open source batch script based program that enables to connect to WIFI using the console.
REM Version: 0.0.1 [Beta]
REM Github: 
REM Licensed Under The MIT License: http://opensource.org/licenses/MIT
REM Copyright (c) 2021 sraedler
REM 
REM =============================


cls
@echo off

echo =============================
echo WIFI Connection Tool by sraedler
echo =============================
echo. 
echo. 


REM =============================
REM Setup Variables
REM =============================
set appname=WIFI Connection Tool
set appvers=v0.0.1
set dev=sraedler
set desc=An open source batch script based program that enables to connect to WIFI using the console.
set uicolor=a
set infouicolor=b
set erruicolor=c
set cliN=$%appname%
set divider======================================
set tempdivider=================================================


rem =============================
rem Main Menu
rem =============================
:mainMenu
del null
cls
title %appname% %appvers% - %appstat% [Main Menu]
echo # %divider%
echo # %appname% %appvers% - %appstat%
echo # by %dev%
echo # %divider%
color %uicolor%
echo # %desc%
echo # %divider%
echo #
echo # Show WIFI ................. [1]
echo # Connect By SSID ........... [2]
echo # Test WIFI ................. [3]
echo # Exit ...................... [4]
echo #
set /p "mainMenu=# $WIFIConnector> " || set mainMenu=1
if %mainMenu%==1 goto showWIFI
if %mainMenu%==2 goto connectBySSID
if %mainMenu%==3 goto testWIFI
if %mainMenu%==4 goto exitProgram
goto fail4
pause>null


rem =============================
rem Show WIFI
rem =============================
:showWIFI
cls
title %appname% %appvers% - %appstat% [Show WIFI]
color %uicolor%
echo # %divider%
echo # %appname% %appvers% - %appstat%
echo # by %dev%
echo # %divider%
echo #
echo # Checking for wireless interface...
netsh wlan show networks|find "SSID"
if %errorlevel%==1 goto fail4
echo # 
echo # %divider%
echo #
echo # Retry Search .............. [1]
echo # Connect To WIFI ........... [2]
echo # Main Menu ................. [3]
echo #

set /p "mainMenu=# $WIFIConnector> " || set mainMenu=1
if %mainMenu%==1 goto refreshWIFI
if %mainMenu%==2 goto connectBySSID
if %mainMenu%==3 goto mainMenu
goto fail4
pause>null


rem =============================
rem ForceRefresh WIFI networks
rem =============================
:refreshWIFI
netsh interface set interface name=WLAN admin=DISABLED
echo WIFI DISABLED
netsh interface set interface name=WLAN admin=ENABLED
echo Wait 5 Seconds for interface is being enabled
timeout 5
goto showWIFI

rem =============================
rem Connect WIFI by SSID
rem =============================
:connectBySSID
cls
title %appname% %appvers% - %appstat% [Connect WIFI by SSID]
color %uicolor%
echo # %divider%
echo # %appname% %appvers% - %appstat%
echo # by %dev%
echo # %divider%
echo #
echo # Checking for wireless interface...
netsh wlan show networks|find "SSID"
if %errorlevel%==1 goto fail4
echo # 
echo # %divider%
echo #
set /p "SSID=# Please Enter WIFI SSID> " || set SSID=1
echo #
set /p "Password=# Please Enter WIFI Password> " || set Password=1
echo #
(
    echo ^<^?xml version=^"1.0^"^?^>
    echo ^<WLANProfile xmlns=^"http:^/^/www.microsoft.com^/networking^/WLAN^/profile^/v1^"^>
    echo 	^<name^>%SSID%^<^/name^>
    echo 	^<SSIDConfig^>
    echo 		^<SSID^>
    echo 			^<name^>%SSID%^<^/name^>
    echo 		^<^/SSID^>
    echo 	^<^/SSIDConfig^>
    echo 	^<connectionType^>ESS^<^/connectionType^>
    echo 	^<connectionMode^>auto^<^/connectionMode^>
    echo 	^<MSM^>
    echo 		^<security^>
    echo 			^<authEncryption^>
    echo 				^<authentication^>WPA2PSK^<^/authentication^>
    echo 				^<encryption^>AES^<^/encryption^>
    echo 			^<^/authEncryption^>
    echo 		^<^/security^>
    echo 	^<^/MSM^>
    echo ^<^/WLANProfile^>
) > "%TEMP%\TempProfile.xml"
netsh wlan add profile filename="%TEMP%\TempProfile.xml"
netsh wlan set profileparameter ^
    name="%SSID%" ^
    SSIDname="%SSID%" ^
    keyType=passphrase ^
    keyMaterial="%Password%"
netsh wlan connect "%SSID%" && del /f /q "%TEMP%\TempProfile.xml"
timeout 5
ping google.de
echo #
echo # %divider%
echo #
echo # Retry Connect ............. [1]
echo # Test WIFI ................. [2]
echo # Main Menu ................. [3]
echo #

set /p "mainMenu=# $WIFIConnector> " || set mainMenu=1
if %mainMenu%==1 goto connectBySSID
if %mainMenu%==2 goto testWIFI
if %mainMenu%==3 goto mainMenu
goto fail4
pause>null

rem =============================
rem Test WIFI
rem =============================
:testWIFI
cls
title %appname% %appvers% - %appstat% [Test WIFI]
color %uicolor%
echo # %divider%
echo # %appname% %appvers% - %appstat%
echo # by %dev%
echo # %divider%
echo #
ping google.de
echo #
echo # Retry ................ [1]
echo # Main Menu ................. [2]
echo #

set /p "mainMenu=# $WIFIConnector> " || set mainMenu=1
if %mainMenu%==1 goto testWIFI
if %mainMenu%==2 goto mainMenu
goto fail4
pause>null

rem =============================
rem Program Error
rem =============================
:fail4
del null
cls
title %appname% %appvers% - %appstat% [Error]
color %erruicolor%
echo # %divider%
echo # %appname% %appvers% - %appstat%
echo # by %dev%
echo # %divider%
echo # Invalid option! Please try again...
echo # %divider%
echo #
echo # Press any key to continue... (except power button lol)
pause>null
goto mainMenu


rem =============================
rem Program Exit
rem =============================
:exitProgram
del null
exit