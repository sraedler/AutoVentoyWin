echo %path%|find /i "choco" > NUL

if %errorlevel% == 0 (
choco feature enable -n allowEmptyChecksums
choco feature enable -n allowGlobalConfirmation
choco install adobereader -y -r
choco install lockhunter -y -r
)
