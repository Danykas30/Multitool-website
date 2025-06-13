@echo off
title System Information Tool
color 0A
echo.
echo =====================================
echo       SYSTEM INFORMATION TOOL
echo =====================================
echo.

echo [1] Basic System Info
echo [2] Hardware Info
echo [3] Network Configuration
echo [4] Running Processes
echo [5] Disk Usage
echo [6] Full Report (All Above)
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto basic_info
if "%choice%"=="2" goto hardware_info
if "%choice%"=="3" goto network_info
if "%choice%"=="4" goto processes
if "%choice%"=="5" goto disk_usage
if "%choice%"=="6" goto full_report
if "%choice%"=="0" goto end
goto invalid

:basic_info
echo.
echo === BASIC SYSTEM INFORMATION ===
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" /C:"Available Physical Memory"
pause
goto menu

:hardware_info
echo.
echo === HARDWARE INFORMATION ===
wmic cpu get name,numberofcores,numberoflogicalprocessors
wmic memorychip get capacity,speed,manufacturer
wmic diskdrive get model,size,interfacetype
pause
goto menu

:network_info
echo.
echo === NETWORK CONFIGURATION ===
ipconfig /all
echo.
echo === DNS SERVERS ===
nslookup google.com
pause
goto menu

:processes
echo.
echo === TOP RUNNING PROCESSES (BY MEMORY) ===
tasklist /fi "memusage gt 50000" | sort /r
pause
goto menu

:disk_usage
echo.
echo === DISK USAGE ===
wmic logicaldisk get caption,size,freespace,filesystem
echo.
echo === FOLDER SIZES (Current Directory) ===
dir /s
pause
goto menu

:full_report
echo.
echo Generating full system report...
echo === FULL SYSTEM REPORT === > system_report.txt
echo Generated on %date% at %time% >> system_report.txt
echo. >> system_report.txt
echo === BASIC SYSTEM INFO === >> system_report.txt
systeminfo | findstr /C:"OS Name" /C:"OS Version" /C:"System Type" /C:"Total Physical Memory" >> system_report.txt
echo. >> system_report.txt
echo === HARDWARE INFO === >> system_report.txt
wmic cpu get name,numberofcores >> system_report.txt
echo. >> system_report.txt
echo === NETWORK CONFIG === >> system_report.txt
ipconfig /all >> system_report.txt
echo. >> system_report.txt
echo === DISK USAGE === >> system_report.txt
wmic logicaldisk get caption,size,freespace >> system_report.txt
echo.
echo Full report saved to 'system_report.txt'
pause
goto menu

:invalid
echo Invalid option. Please try again.
pause

:menu
cls
goto start

:start
echo.
echo =====================================
echo       SYSTEM INFORMATION TOOL
echo =====================================
echo.

echo [1] Basic System Info
echo [2] Hardware Info
echo [3] Network Configuration
echo [4] Running Processes
echo [5] Disk Usage
echo [6] Full Report (All Above)
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto basic_info
if "%choice%"=="2" goto hardware_info
if "%choice%"=="3" goto network_info
if "%choice%"=="4" goto processes
if "%choice%"=="5" goto disk_usage
if "%choice%"=="6" goto full_report
if "%choice%"=="0" goto end
goto invalid

:end
echo.
echo Thank you for using System Information Tool!
pause
exit
