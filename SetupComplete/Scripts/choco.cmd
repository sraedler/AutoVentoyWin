echo %path%|find /i "choco" > NUL

if %errorlevel% == 0 (
set log=%systemdrive%\%~n0.log
choco feature enable -n allowEmptyChecksums
choco feature enable -n allowGlobalConfirmation
choco install sudo -y -r %log%
choco install clink-maintained -y -r %log%
choco install choco-cleaner -y -r %log%
choco install firefox -y -r %log%
choco install brave -y -r %log%
choco install microsoft-windows-terminal -y -r %log%
choco install hashtab -y -r %log%
choco install 7z -y -r %log%
choco install auto-dark-mode -y -r %log%
choco install itunes -y -r %log%
choco install mediainfo -y -r %log%
choco install advanced-renamer -y -r %log%
choco install vscode -y -r %log%
choco install treesizefree -y -r %log%
choco install defraggler -y -r %log%
choco install vmwareworkstation -y -r %log%
)