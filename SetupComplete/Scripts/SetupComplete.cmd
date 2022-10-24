@echo off

:: create Temp folder and set log path
set log=%systemdrive%\SetupComplete.log

set SETUPDIR=%SystemRoot%\Setup\
set SETUPFILES=%SETUPDIR%\SetupFiles\

:: Install Office 2021 using Office Tool Plus https://help.coolhub.top/others/commands.html#deploy-commands
echo "Install Office" >> %log
"%SETUPFILES%\Office Tool\Office Tool Plus.Console.exe" deploy /addProduct O365ProPlusRetail_en-us_Publisher,Lync,Access,OneNote /channel Current /clientEdition 64 /acceptEULA
echo "Install Office > SUCCESS!" >> %log

:: Activate Office and Windows at this place using certain tools
echo "Activate Office" >> %log
start /wait cmd /c %SETUPDIR%\Scripts\activateOffice.cmd
echo "Activate Office > SUCCESS!" >> %log

:: Add some registry entries
echo "Add registry entries" >> %log
reg add "HKLM\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /d 1 /t REG_DWORD /f
reg add "HKCU\Software\Policies\Microsoft\Windows\CloudContent" /v DisableWindowsConsumerFeatures /d 1 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v ContentDeliveryAllowed /d 0 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager" /v SilentInstalledAppsEnabled /d 0 /t REG_DWORD /f
reg add "HKCU\SOFTWARE\Microsoft\Windows\CurrentVersion\ContentDeliveryManager\" /v SystemPaneSuggestionsEnabled /d 0 /t REG_DWORD /f
echo "Add registry entries > SUCCESS!" >> %log

:: Run Decrapifier Script
echo "Run Decrapifier Script" >> %log
SET PowerShellScriptPath=%SETUPDIR%\Scripts\decrapifier.ps1
PowerShell -NoProfile -ExecutionPolicy Bypass -Command "& {Start-Process PowerShell -ArgumentList '-NoProfile -ExecutionPolicy Bypass -File """"%PowerShellScriptPath%"""" -ClearStart' -Verb RunAs;}"
timeout 360
echo "Run Decrapifier Script > SUCCESS" >> %log

:: Deinstall OneDrive
echo "Deinstall OneDrive" >> %log
taskkill /f /im OneDrive.exe
%SystemRoot%\SysWOW64\OneDriveSetup.exe /uninstall
echo "Deinstall OneDrive > SUCCESS" >> %log

:: Deinstall Teams
echo "Deinstall Teams" >> %log
wmic product where name="Teams Machine-Wide Installer" call uninstall
echo "Deinstall Teams > SUCCESS" >> %log

:: Install Apps using scoop
echo "Install Apps using scoop" >> %log
start /wait cmd /c %SETUPDIR%\Scripts\scoop.cmd
echo "Install Apps using scoop > SUCCESS" >> %log

:: Install Apps using Choco
:: start /wait cmd /c %SETUPDIR%\Scripts\choco.cmd

:: Clean up
:: if exist "%SETUPDIR%\Ninite.exe" @DEL /S /Q "%SETUPDIR%\Ninite.exe"
if exist "%SETUPFILES%" @RD /S /Q "%SETUPFILES%"
if exist "%SETUPDIR%\PreSetup\" @RD /S /Q "%SETUPDIR%\PreSetup\"
if exist "%SETUPDIR%\Scripts\" @RD /S /Q "%SETUPDIR%\Scripts\"

::Reboot
shutdown /r /t 15

exit /b