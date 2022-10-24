@echo off

:: don't run this twice!
:: if exist %systemroot%\DONE_SDI.tag exit

:: set USB and location Dir
set USB=%~d0
set FILEDIR=%USB%\SetupComplete\
set SETUPDIR=%WINDIR%\SETUP\
set SETUPFILES=%SETUPDIR%\SetupFiles\
set PRESETUPDIR=%SETUPDIR%\PreSetup\


:: create Temp folder and set log path
::md %systemdrive%\Temp > nul
set log=%systemdrive%\%~n0.log

:: install Scoop
	::download install.ps1
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "((new-object net.webclient).DownloadFile('https://raw.githubusercontent.com/ScoopInstaller/Install/master/install.ps1','$ENV:SYSTEMDRIVEinstall.ps1'))"
	::run installer
%systemroot%\System32\WindowsPowerShell\v1.0\powershell.exe -NoProfile -ExecutionPolicy Bypass -Command "& '$ENV:SYSTEMDRIVE\install.ps1 >> $ENV:SYSTEMDRIVE/scoop_install.log' %*"
::&& ($LASTEXITCODE -eq 0) ? Write-Output "Scoop was installed correctly" >> $ENV:SYSTEMDRIVE/scoop_install.log  : Write-Output "Scoop was not installed correctly" >> $ENV:SYSTEMDRIVE/scoop_install.log
:: push tag to stop
::echo stop > %systemroot%\DONE_SDI.tag

echo "Successful executed" >> %log%

pause