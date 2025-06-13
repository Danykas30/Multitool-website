@echo off
title Network Diagnostics Tool
color 0B
echo.
echo =====================================
echo      NETWORK DIAGNOSTICS TOOL
echo =====================================
echo.

echo [1] Ping Test (Google, Cloudflare)
echo [2] DNS Lookup Test
echo [3] Network Speed Test (Basic)
echo [4] Port Scanner (Local)
echo [5] WiFi Information
echo [6] Full Network Report
echo [7] Reset Network Settings
echo [0] Exit
echo.

set /p choice="Select an option (0-7): "

if "%choice%"=="1" goto ping_test
if "%choice%"=="2" goto dns_test
if "%choice%"=="3" goto speed_test
if "%choice%"=="4" goto port_scan
if "%choice%"=="5" goto wifi_info
if "%choice%"=="6" goto full_report
if "%choice%"=="7" goto reset_network
if "%choice%"=="0" goto end
goto invalid

:ping_test
echo.
echo === PING TEST ===
echo.
echo Testing Google (8.8.8.8)...
ping -n 4 8.8.8.8
echo.
echo Testing Cloudflare (1.1.1.1)...
ping -n 4 1.1.1.1
echo.
echo Testing your default gateway...
for /f "tokens=2 delims=:" %%a in ('ipconfig ^| findstr "Default Gateway"') do (
    for /f "tokens=1" %%b in ("%%a") do ping -n 4 %%b
)
pause
goto menu

:dns_test
echo.
echo === DNS LOOKUP TEST ===
echo.
echo Testing DNS resolution...
nslookup google.com
echo.
nslookup github.com
echo.
nslookup microsoft.com
pause
goto menu

:speed_test
echo.
echo === BASIC NETWORK SPEED TEST ===
echo.
echo Testing download speed using Windows built-in tools...
echo This is a basic test - for accurate results use specialized tools.
echo.
powershell -Command "(New-Object Net.WebClient).DownloadString('http://speedtest-cli.googlecode.com/svn/trunk/speedtest.py')" >nul 2>&1
if %errorlevel% equ 0 (
    echo Network connection is working.
) else (
    echo Network connection might have issues.
)
echo.
echo For accurate speed testing, visit: https://fast.com or https://speedtest.net
pause
goto menu

:port_scan
echo.
echo === LOCAL PORT SCANNER ===
echo.
echo Scanning common local ports...
echo.
netstat -an | findstr LISTENING
echo.
echo Active network connections:
netstat -an | findstr ESTABLISHED
pause
goto menu

:wifi_info
echo.
echo === WIFI INFORMATION ===
echo.
echo Current WiFi profiles:
netsh wlan show profiles
echo.
echo Current connection details:
netsh wlan show interfaces
echo.
set /p profile_name="Enter WiFi profile name to view details (or press Enter to skip): "
if not "%profile_name%"=="" (
    echo.
    echo Details for %profile_name%:
    netsh wlan show profile name="%profile_name%" key=clear
)
pause
goto menu

:full_report
echo.
echo Generating full network report...
echo === NETWORK DIAGNOSTICS REPORT === > network_report.txt
echo Generated on %date% at %time% >> network_report.txt
echo. >> network_report.txt

echo === IP CONFIGURATION === >> network_report.txt
ipconfig /all >> network_report.txt
echo. >> network_report.txt

echo === ROUTING TABLE === >> network_report.txt
route print >> network_report.txt
echo. >> network_report.txt

echo === ARP TABLE === >> network_report.txt
arp -a >> network_report.txt
echo. >> network_report.txt

echo === NETWORK STATISTICS === >> network_report.txt
netstat -s >> network_report.txt
echo. >> network_report.txt

echo === ACTIVE CONNECTIONS === >> network_report.txt
netstat -an >> network_report.txt

echo.
echo Full network report saved to 'network_report.txt'
pause
goto menu

:reset_network
echo.
echo === NETWORK SETTINGS RESET ===
echo.
echo WARNING: This will reset all network settings to default.
echo This includes WiFi passwords, VPN settings, and firewall rules.
echo.
set /p confirm="Are you sure you want to continue? (Y/N): "
if /i "%confirm%"=="Y" (
    echo.
    echo Resetting network settings...
    netsh winsock reset
    netsh int ip reset
    ipconfig /release
    ipconfig /renew
    ipconfig /flushdns
    echo.
    echo Network settings have been reset. Please restart your computer.
) else (
    echo Operation cancelled.
)
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
echo      NETWORK DIAGNOSTICS TOOL
echo =====================================
echo.

echo [1] Ping Test (Google, Cloudflare)
echo [2] DNS Lookup Test
echo [3] Network Speed Test (Basic)
echo [4] Port Scanner (Local)
echo [5] WiFi Information
echo [6] Full Network Report
echo [7] Reset Network Settings
echo [0] Exit
echo.

set /p choice="Select an option (0-7): "

if "%choice%"=="1" goto ping_test
if "%choice%"=="2" goto dns_test
if "%choice%"=="3" goto speed_test
if "%choice%"=="4" goto port_scan
if "%choice%"=="5" goto wifi_info
if "%choice%"=="6" goto full_report
if "%choice%"=="7" goto reset_network
if "%choice%"=="0" goto end
goto invalid

:end
echo.
echo Thank you for using Network Diagnostics Tool!
pause
exit
