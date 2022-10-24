echo %path%|find /i "scoop" > NUL

if %errorlevel% == 0 (

:: md %systemdrive%\Temp > nul
set log=%systemdrive%\%~n0.log

scoop install git >> %log%
scoop bucket add extras >> %log%
scoop bucket add main >> %log%

scoop install sudo >> %log%
scoop install clink >> %log%
clink autorun install >> %log%
scoop install firefox >> %log%
scoop install brave >> %log%
scoop install windows-terminal >> %log%

scoop bucket add anderlli0053_DEV-tools https://github.com/anderlli0053/DEV-tools >> %log%
scoop install HashTab >> %log%
scoop install autodarkmode >> %log%
scoop install itunes-portable >> %log%
scoop install mediainfo >> %log%
scoop install advancedrenamer >> %log%
scoop install vscode >> %log%
scoop install treesize-free >> %log%
scoop install defraggler >> %log%
scoop install vmware-workstation-pro >> %log%
)