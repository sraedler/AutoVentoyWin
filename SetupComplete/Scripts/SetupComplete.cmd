@echo off

set SETUPDIR=%SystemRoot%\Setup\
set SETUPFILES=%SETUPDIR%\SetupFiles\


:: Install Office 2021 using Office Tool Plus
"%SETUPFILES%\Office Tool\Office Tool Plus.Console.exe" deploy /addProduct ProPlus2021Volume_de-de_Publisher,Lync,Access,OneNote /channel PerpetualVL2021 /clientEdition 64 /acceptEULA

:: Activate Office and Windows at this place using certain tools

:: Start Ninite to Install Basics
"%SETUPDIR%\Ninite.exe"

:: Install Apps using Choco
start /wait cmd /c %SETUPDIR%\Scripts\choco.cmd

:: Clean up
if exist "%SETUPDIR%\Ninite.exe" @DEL /S /Q "%SETUPDIR%\Ninite.exe"
if exist "%SETUPFILES%" @RD /S /Q "%SETUPFILES%"
if exist "%SETUPDIR%\PreSetup\" @RD /S /Q "%SETUPDIR%\PreSetup\"
if exist "%SETUPDIR%\Scripts\" @RD /S /Q "%SETUPDIR%\Scripts\"
exit /b
