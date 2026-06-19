@echo off
cd /d "%~dp0"

if not exist "target_ip.txt" (
    echo target_ip.txt not found. Create this file with the server IP first.
    pause
    exit /b 1
)

set /p TARGET=<"target_ip.txt"

powershell -NoProfile -ExecutionPolicy Bypass -File "Get-TTL.ps1" -Target "%TARGET%" -Margin 1 -OutFile "ttl.txt"

pause