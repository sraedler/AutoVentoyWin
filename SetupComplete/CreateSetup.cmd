@echo off

:: don't run this twice!
if exist %systemroot%\DONE_SDI.tag exit

:: set USB and location Dir
set USB=%~d0
set FILEDIR=%USB%\SetupComplete\
set SETUPDIR=%WINDIR%\SETUP\
set SETUPFILES=%SETUPDIR%\SetupFiles\
set PRESETUPDIR=%SETUPDIR%\PreSetup\


:: create Temp folder and set log path
md %systemdrive%\Temp > nul
set log=%systemdrive%\temp\%~n0.log

echo "Copy started\r\n" >> %log%

xcopy /herky %FILEDIR%\*.* %SETUPDIR%\ >> %log%

if not exist %SETUPFILES% mkdir %SETUPFILES%

ping -n 1 google.de >> %log%
if errorlevel 1 (
echo.
echo NO INTERNET ACCESS!
start /wait /b cmd /c %PRESETUPDIR%\connect_to_wifi.bat
)

:: download snappy
START /WAIT %PRESETUPDIR%\wget.exe --no-check-certificate https://www.glenn.delahoy.com/downloads/sdio/SDIO_1.12.7.747.zip -O %PRESETUPDIR%\snappy.zip
:: extract snappy
tar -xf %PRESETUPDIR%\snappy.zip -C %PRESETUPDIR%

start /wait /b cmd /c %PRESETUPDIR%snappy.bat %PRESETUPDIR%

:: download Office Tools
START /WAIT %PRESETUPDIR%\wget.exe --no-check-certificate "https://otp.landian.vip/redirect/download.php?type=runtime&site=github" -O %SETUPFILES%\office.zip
:: extract office
tar -xf %SETUPFILES%\office.zip -C %SETUPFILES%

:: install Choco
	::download install.ps1
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://community.chocolatey.org/install.ps1','%PRESETUPDIR%\install.ps1'))"
	::run installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '%PRESETUPDIR%\install.ps1' %*"


:: push tag to stop
echo stop > %systemroot%\DONE_SDI.tag

echo "Successful executed" >> %log%

exit