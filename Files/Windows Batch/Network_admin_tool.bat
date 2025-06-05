@echo off
title Network Admin Toolkit
color 1F

:: Check if running as admin
net session >nul 2>&1
if %errorlevel% neq 0 (
    echo This script must be run as Administrator.
    pause
    exit
)

:MENU
cls
echo ================================
echo      Network Admin Toolkit
echo ================================
echo 1. Show IP Configuration
echo 2. Release and Renew IP
echo 3. Flush DNS Cache
echo 4. Show Routing Table
echo 5. Open Firewall Settings
echo 6. Open Local Users and Groups (lusrmgr.msc)
echo 7. Start Remote Desktop Services
echo 8. Ping Test
echo 9. Exit
echo ================================
set /p choice=Enter your choice (1-9): 

if "%choice%"=="1" goto ipconfig
if "%choice%"=="2" goto renewip
if "%choice%"=="3" goto flushdns
if "%choice%"=="4" goto route
if "%choice%"=="5" goto firewall
if "%choice%"=="6" goto users
if "%choice%"=="7" goto rdp
if "%choice%"=="8" goto pingtest
if "%choice%"=="9" exit
goto MENU

:ipconfig
cls
echo ==== IP Configuration ====
ipconfig /all
pause
goto MENU

:renewip
cls
echo ==== Releasing and Renewing IP ====
ipconfig /release
ipconfig /renew
pause
goto MENU

:flushdns
cls
echo ==== Flushing DNS Cache ====
ipconfig /flushdns
pause
goto MENU

:route
cls
echo ==== Routing Table ====
route print
pause
goto MENU

:firewall
cls
echo ==== Opening Windows Firewall ====
control firewall.cpl
goto MENU

:users
cls
echo ==== Opening Local Users and Groups ====
start lusrmgr.msc
goto MENU

:rdp
cls
echo ==== Starting Remote Desktop Services ====
sc start TermService
echo Remote Desktop Services started.
pause
goto MENU

:pingtest
cls
set /p target=Enter IP or domain to ping: 
ping %target%
pause
goto MENU
