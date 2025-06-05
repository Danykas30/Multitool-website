@echo off
chcp 65001 >nul
color 0A
title Mr. Robot Style IP Scanner
cls

:: Banner Section
:banner
cls
echo.
echo                             ████╗  ██████╗ ████╗ ██████╗ ██████╗ ██████╗ 
echo                            ██╔══██╗██╔═══██╗╚══██╗██╔══██╗██╔══██╗██╔══██╗
echo                            ██████╔╝██║   ██║  ██╔╝██████╔╝██████╔╝██████╔╝
echo                            ██╔═══╝ ██║   ██║ ██╔╝ ██╔═══╝ ██╔═══╝ ██╔═══╝ 
echo                            ██║     ╚██████╔╝██╔╝  ██║     ██║     ██║     
echo                            ╚═╝      ╚═════╝ ╚═╝   ╚═╝     ╚═╝     ╚═╝     
echo.
echo                        [==> Mr. Robot-style IP Scanner <==]
echo.
echo                          print("MadeByAxqzme")
echo.

:menu
echo.
echo   [1] Exit
echo   [2] Start IP Scan
echo   [3] Credits
set /p choice=Select an option: 

if "%choice%"=="1" exit
if "%choice%"=="2" goto :scan
if "%choice%"=="3" goto :credits
goto :menu

:: Credits
:credits
cls
echo.
echo ====================== C R E D I T S ======================
echo.
echo                Script by: Axqzme 🧠
echo                Inspired by: Mr. Robot 💻
echo                Styled by: ChatGPT 🤖
echo.
echo   Follow for more CLI madness 😎
echo ============================================================
echo.
pause
goto :banner

:: Scanner
:scan
cls
echo Initializing scanner...
ping -n 1 127.0.0.1 >nul
echo Loading network module...
ping -n 1 127.0.0.1 >nul
echo Access granted.
echo Beginning IP sweep...
timeout /t 1 >nul
cls

setlocal EnableDelayedExpansion
echo Scanning random IPs...

for /L %%i in (1,1,30) do (
    set /a ip1=!random! %% 256
    set /a ip2=!random! %% 256
    set /a ip3=!random! %% 256
    set /a ip4=!random! %% 256
    set ip=!ip1!.!ip2!.!ip3!.!ip4!

    ping -n 1 -w 100 !ip! >nul
    if !errorlevel! == 0 (
        echo [FOUND] Host at !ip!
    ) else (
        echo [....] Scanning !ip!
    )
    timeout /nobreak /t 0 >nul
)

echo.
echo ======================
echo     SCAN COMPLETE
echo ======================
echo.
pause
goto :banner
