@echo off
chcp 65001 >nul
color 0A
title Mr. Robot IP Scanner
cls

:: Banner — FULL BLOCK style like you wanted
:banner
cls
echo.
echo. █████  ██████   ██████  ██████  ███████ ██      ██ ███████     ████████  ██████   ██████  ██      
echo. ██   ██ ██   ██ ██    ██ ██   ██ ██      ██      ██ ██             ██    ██    ██ ██    ██ ██      
echo. ███████ ██████  ██    ██ ██████  █████   ██      ██ ███████        ██    ██    ██ ██    ██ ██      
echo. ██   ██ ██   ██ ██    ██ ██   ██ ██      ██      ██      ██        ██    ██    ██ ██    ██ ██      
echo. ██   ██ ██████   ██████  ██████  ███████ ███████ ██ ███████        ██     ██████   ██████  ███████ 
echo.
echo.                     [==> Mr. Robot-style IP Scanner <==]
echo.
echo.                      print("MadeByAxqzme")
echo.

:menu
echo.
echo   [1] Exit
echo   [2] Start IP Scan
echo   [3] Credits
echo.
set /p choice=Choose an option: 

if "%choice%"=="1" exit
if "%choice%"=="2" goto :scan
if "%choice%"=="3" goto :credits
goto :menu

:credits
cls
echo.
echo. ====================== C R E D I T S ======================
echo.
echo.                  ███╗   ███╗ █████╗ ██████╗ ███████╗
echo.                  ████╗ ████║██╔══██╗██╔══██╗██╔════╝
echo.                  ██╔████╔██║███████║██████╔╝█████╗  
echo.                  ██║╚██╔╝██║██╔══██║██╔═══╝ ██╔══╝  
echo.                  ██║ ╚═╝ ██║██║  ██║██║     ███████╗
echo.                  ╚═╝     ╚═╝╚═╝  ╚═╝╚═╝     ╚══════╝
echo.
echo.                Scripted by Axqzme with real CLI vibes.
echo.                Styled by ChatGPT – Made for the culture.
echo.
echo. ============================================================
echo.
pause
goto :banner

:scan
cls
echo Initializing scanner...
ping -n 1 127.0.0.1 >nul
echo Loading network modules...
ping -n 1 127.0.0.1 >nul
echo Access granted.
echo Beginning scan...
timeout /t 1 >nul
cls

setlocal EnableDelayedExpansion
echo Scanning network...

:: Random IP scan (faster & randomized)
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
