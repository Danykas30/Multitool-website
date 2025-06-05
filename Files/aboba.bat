@echo off
chcp 65001 >nul
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
echo                         [==> Mr. Robot-style IP Scanner <==]
echo.
echo                  print("MadeByAxqzme")
echo.
echo Initializing network module...
ping -n 2 127.0.0.1 >nul
echo Connecting to secure node...
ping -n 2 127.0.0.1 >nul
echo Access granted.
echo Starting scan...
timeout /t 1 >nul
cls

:: Begin simulated IP scan
echo Scanning network for active hosts...
setlocal enabledelayedexpansion
for /L %%i in (1,1,20) do (
    set /a ip=%%i+80
    ping -n 1 -w 200 192.168.56.!ip! >nul
    if !errorlevel! == 0 (
        echo [FOUND] Host at 192.168.56.!ip!
    ) else (
        echo [....] Scanning 192.168.56.!ip!
    )
    timeout /t 0.5 >nul
)

echo.
echo Scan complete.
echo.
:menu
echo [1] Return to main menu
echo [2] Exit
set /p choice=Choose an option: 

if "%choice%"=="1" goto :start
if "%choice%"=="2" exit
goto :menu

:start
cls
call "%~f0"
