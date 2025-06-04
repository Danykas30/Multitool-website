@echo off
:: Set green text on black background
color 0A
cls

:: Display ASCII banner
echo.
echo █████  ██████   ██████  ██████  ███████ ██      ██ ███████     ████████  ██████   ██████  ██      
echo ██   ██ ██   ██ ██    ██ ██   ██ ██      ██      ██ ██             ██    ██    ██ ██    ██ ██      
echo ███████ ██████  ██    ██ ██████  █████   ██      ██ ███████        ██    ██    ██ ██    ██ ██      
echo ██   ██ ██   ██ ██    ██ ██   ██ ██      ██      ██      ██        ██    ██    ██ ██    ██ ██      
echo ██   ██ ██████   ██████  ██████  ███████ ███████ ██ ███████        ██     ██████   ██████  ███████ 
echo.
echo                            [==> Mr. Robot-style IP Scanner <==]
echo.
echo Initializing network module...
ping -n 2 127.0.0.1 >nul
echo Connecting to secure node...
ping -n 2 127.0.0.1 >nul
echo Access granted.
echo Starting scan...
timeout /t 2 >nul
cls

:: Begin simulated IP scan
echo Scanning network for active hosts...
setlocal enabledelayedexpansion
for /L %%i in (1,1,10) do (
    set /a ip=%%i+100
    ping -n 1 -w 300 192.168.1.!ip! >nul
    if !errorlevel! == 0 (
        echo [FOUND] Host at 192.168.1.!ip!
    ) else (
        echo [....] Scanning 192.168.1.!ip!
    )
    timeout /t 1 >nul
)

echo.
echo Scan complete.
echo Press any key to exit...
pause >nul
