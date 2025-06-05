@echo off
chcp 65001 >nul
color 0A
title Wi-Fi Host Scanner - MadeByAxqzme and Chatgpt
cls

:: Banner
echo.
echo ███████╗██╗██╗     ███████╗    ███████╗ █████╗ ███╗   ██╗██╗  ██╗███████╗
echo ██╔════╝██║██║     ██╔════╝    ██╔════╝██╔══██╗████╗  ██║██║ ██╔╝██╔════╝
echo ███████╗██║██║     █████╗█████╗█████╗  ███████║██╔██╗ ██║█████╔╝ █████╗  
echo ╚════██║██║██║     ██╔══╝╚════╝██╔══╝  ██╔══██║██║╚██╗██║██╔═██╗ ██╔══╝  
echo ███████║██║███████╗███████╗    ██║     ██║  ██║██║ ╚████║██║  ██╗███████╗
echo ╚══════╝╚═╝╚══════╝╚══════╝    ╚═╝     ╚═╝  ╚═╝╚═╝  ╚═══╝╚═╝  ╚═╝╚══════╝
echo.
echo [==> Real WiFi IP Scanner - MadeByAxqzmeAndChatGPT <==]
echo.

:: Get current subnet
for /f "tokens=2 delims=:" %%i in ('ipconfig ^| findstr /c:"IPv4"') do (
    set "ip=%%i"
)
setlocal enabledelayedexpansion
set "ip=!ip: =!"
for /f "tokens=1,2,3 delims=." %%a in ("!ip!") do (
    set "subnet=%%a.%%b.%%c."
)
echo Detected subnet: !subnet!
echo.

:: Start scan
echo Scanning for connected hosts on !subnet!* ...
echo This may take a few seconds...
echo.

for /L %%i in (1,1,254) do (
    ping -n 1 -w 100 !subnet!%%i >nul
)

echo.
echo ========================
echo Active Devices Found:
echo ========================
arp -a | findstr /R "!subnet![0-9][0-9]*"
echo.
echo ========================
echo      SCAN COMPLETE
echo ========================
echo.
pause
