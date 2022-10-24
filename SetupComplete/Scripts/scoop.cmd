echo %path%|find /i "scoop" > NUL

if %errorlevel% == 0 (

:: md %systemdrive%\Temp > nul
:: set log=%systemdrive%\%~n0.log
set LogFile=%systemdrive%\%~n0.log
set logg=^> _^&type _^&type _^>^>%LogFile

scoop install git >> %logg%
scoop bucket add extras >> %logg%
scoop bucket add main >> %logg%

scoop install sudo >> %logg%
scoop install clink >> %logg%
clink autorun install >> %logg%
scoop install firefox >> %logg%
scoop install brave >> %logg%
scoop install windows-terminal >> %logg%

scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools >> %logg%
scoop install HashTab >> %logg%
scoop install autodarkmode >> %logg%
scoop install itunes-portable >> %logg%
scoop install mediainfo >> %logg%
scoop install advancedrenamer >> %logg%
scoop install vscode >> %logg%
scoop install treesize-free >> %logg%
scoop install defraggler >> %logg%
scoop install vmware-workstation-pro >> %logg%
)