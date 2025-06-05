@echo off
setlocal enabledelayedexpansion
mode con: cols=100 lines=40
title Advanced Windows Multi-Tool v2.0

:: Set default color scheme
set "COLOR_SCHEME=0A"
if exist "%APPDATA%\WinMultiTool\settings.ini" (
    for /f "tokens=1,2 delims==" %%a in (%APPDATA%\WinMultiTool\settings.ini) do (
        if "%%a"=="ColorScheme" set "COLOR_SCHEME=%%b"
    )
)
color %COLOR_SCHEME%

:: Create log directory if it doesn't exist
if not exist "%APPDATA%\WinMultiTool\logs\" mkdir "%APPDATA%\WinMultiTool\logs\"
set "LOGFILE=%APPDATA%\WinMultiTool\logs\multitool_%date:~-4,4%%date:~-7,2%%date:~-10,2%.log"

:: Check for admin rights
net session >nul 2>&1
if %errorlevel% neq 0 (
    set "ADMIN_STATUS=Non-Administrator Mode"
) else (
    set "ADMIN_STATUS=Administrator Mode"
)

:: Log startup
call :LOG "Tool started - %ADMIN_STATUS%"

:MAIN_MENU
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                                                                ║
echo  ║                      ADVANCED WINDOWS MULTI-TOOL v2.0                          ║
echo  ║                                                                                ║
echo  ║                              [ %ADMIN_STATUS% ]                              ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] System Information       [6] Disk Utilities           [11] Help
echo   [2] Network Tools            [7] Security Tools           [12] Settings
echo   [3] File Management          [8] Registry Management      [13] About
echo   [4] System Maintenance       [9] User Account Management  [14] Exit
echo   [5] Process Management       [10] Startup Manager
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║ Last action: %-68s ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p choice="Select an option [1-14]: "
call :LOG "Selected option %choice% from Main Menu"

if "%choice%"=="1" goto SYSTEM_INFO
if "%choice%"=="2" goto NETWORK_TOOLS
if "%choice%"=="3" goto FILE_MANAGEMENT
if "%choice%"=="4" goto SYSTEM_MAINTENANCE
if "%choice%"=="5" goto PROCESS_MANAGEMENT
if "%choice%"=="6" goto DISK_UTILITIES
if "%choice%"=="7" goto SECURITY_TOOLS
if "%choice%"=="8" goto REGISTRY_MANAGEMENT
if "%choice%"=="9" goto USER_ACCOUNT_MANAGEMENT
if "%choice%"=="10" goto STARTUP_MANAGER
if "%choice%"=="11" goto HELP_MENU
if "%choice%"=="12" goto SETTINGS
if "%choice%"=="13" goto ABOUT
if "%choice%"=="14" goto EXIT
goto INVALID_CHOICE

:SYSTEM_INFO
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            SYSTEM INFORMATION                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] Basic System Info         [5] Battery Information
echo   [2] Detailed Hardware Info    [6] Driver Information
echo   [3] Installed Software        [7] Windows Activation Status
echo   [4] System Uptime             [8] Back to Main Menu
echo.
set /p choice="Select an option [1-8]: "
call :LOG "Selected option %choice% from System Information"

if "%choice%"=="1" goto BASIC_SYSTEM_INFO
if "%choice%"=="2" goto HARDWARE_INFO
if "%choice%"=="3" goto INSTALLED_SOFTWARE
if "%choice%"=="4" goto SYSTEM_UPTIME
if "%choice%"=="5" goto BATTERY_INFO
if "%choice%"=="6" goto DRIVER_INFO
if "%choice%"=="7" goto ACTIVATION_STATUS
if "%choice%"=="8" goto MAIN_MENU
goto INVALID_CHOICE

:BASIC_SYSTEM_INFO
cls
call :LOG "Viewing Basic System Information"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                         BASIC SYSTEM INFORMATION                               ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Computer Name: %COMPUTERNAME%
echo  Username: %USERNAME%
echo  Domain: %USERDOMAIN%
echo.
echo  Operating System:
systeminfo | findstr /B /C:"OS Name" /C:"OS Version" /C:"OS Manufacturer" /C:"OS Configuration" /C:"OS Build Type"
echo.
echo  Processor:
wmic cpu get Name, MaxClockSpeed, NumberOfCores, NumberOfLogicalProcessors /format:list | findstr /B /C:"MaxClockSpeed" /C:"Name" /C:"NumberOfCores" /C:"NumberOfLogicalProcessors"
echo.
echo  Memory:
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
wmic OS get FreePhysicalMemory,TotalVirtualMemorySize,FreeVirtualMemory /format:list | findstr /B /C:"FreePhysicalMemory" /C:"TotalVirtualMemorySize" /C:"FreeVirtualMemory"
echo.
echo  Graphics:
wmic path win32_VideoController get Name, AdapterRAM, DriverVersion /format:list | findstr /B /C:"AdapterRAM" /C:"DriverVersion" /C:"Name"
echo.
echo  BIOS:
wmic bios get Manufacturer, Name, Version /format:list | findstr /B /C:"Manufacturer" /C:"Name" /C:"Version"
echo.
pause
goto SYSTEM_INFO

:HARDWARE_INFO
cls
call :LOG "Viewing Detailed Hardware Information"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                      DETAILED HARDWARE INFORMATION                             ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Full System Information
echo  [2] CPU Information
echo  [3] Memory Information
echo  [4] Disk Information
echo  [5] Network Adapter Information
echo  [6] Back to System Information
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Running full system scan... Please wait...
    echo.
    systeminfo
    echo.
    pause
    goto HARDWARE_INFO
) else if "%choice%"=="2" (
    cls
    echo.
    echo  CPU Information:
    echo.
    wmic cpu get Caption, DeviceID, Name, NumberOfCores, NumberOfLogicalProcessors, MaxClockSpeed, L2CacheSize, L3CacheSize, Status /format:list
    echo.
    pause
    goto HARDWARE_INFO
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Memory Information:
    echo.
    wmic memorychip get BankLabel, DeviceLocator, Capacity, Speed, MemoryType, TypeDetail /format:list
    echo.
    pause
    goto HARDWARE_INFO
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Disk Information:
    echo.
    wmic diskdrive get Model, Size, InterfaceType, MediaType, SerialNumber, Status /format:list
    echo.
    echo  Partition Information:
    echo.
    wmic partition get Name, Size, Type, BootPartition, PrimaryPartition /format:list
    echo.
    pause
    goto HARDWARE_INFO
) else if "%choice%"=="5" (
    cls
    echo.
    echo  Network Adapter Information:
    echo.
    wmic nicconfig get Description, IPAddress, MACAddress, DHCPEnabled, IPEnabled, DefaultIPGateway /format:list
    echo.
    pause
    goto HARDWARE_INFO
) else if "%choice%"=="6" (
    goto SYSTEM_INFO
) else (
    goto INVALID_CHOICE
)

:INSTALLED_SOFTWARE
cls
call :LOG "Viewing Installed Software"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            INSTALLED SOFTWARE                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View All Installed Software
echo  [2] Search for Specific Software
echo  [3] Export Software List to File
echo  [4] Back to System Information
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Generating list of installed software... Please wait...
    echo.
    wmic product get Name,Version,Vendor /format:list
    echo.
    pause
    goto INSTALLED_SOFTWARE
) else if "%choice%"=="2" (
    cls
    echo.
    set /p searchterm="Enter software name to search for: "
    echo.
    echo  Searching for "%searchterm%"... Please wait...
    echo.
    wmic product where "Name like '%%%searchterm%%%'" get Name,Version,Vendor /format:list
    echo.
    pause
    goto INSTALLED_SOFTWARE
) else if "%choice%"=="3" (
    cls
    echo.
    set "exportfile=%USERPROFILE%\Desktop\InstalledSoftware.txt"
    echo  Exporting software list to %exportfile%... Please wait...
    echo.
    wmic product get Name,Version,Vendor /format:list > "%exportfile%"
    echo  Export completed.
    echo.
    pause
    goto INSTALLED_SOFTWARE
) else if "%choice%"=="4" (
    goto SYSTEM_INFO
) else (
    goto INVALID_CHOICE
)

:SYSTEM_UPTIME
cls
call :LOG "Viewing System Uptime"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               SYSTEM UPTIME                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  System has been running for:
net statistics workstation | find "Statistics since"
echo.
echo  Detailed uptime information:
echo.
wmic os get lastbootuptime
for /f "skip=1" %%a in ('wmic os get lastbootuptime') do (
    set "boottime=%%a"
    goto :DISPLAY_UPTIME
)

:DISPLAY_UPTIME
set "year=%boottime:~0,4%"
set "month=%boottime:~4,2%"
set "day=%boottime:~6,2%"
set "hour=%boottime:~8,2%"
set "minute=%boottime:~10,2%"
set "second=%boottime:~12,2%"
echo  Last boot time: %day%/%month%/%year% %hour%:%minute%:%second%
echo.
pause
goto SYSTEM_INFO

:BATTERY_INFO
cls
call :LOG "Viewing Battery Information"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            BATTERY INFORMATION                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
wmic path win32_battery get BatteryStatus, EstimatedChargeRemaining, EstimatedRunTime, Name, Status /format:list
echo.
echo  Battery Status Codes:
echo  1 = The battery is discharging
echo  2 = The system has access to AC power
echo  3 = Fully charged
echo  4 = Low
echo  5 = Critical
echo  6 = Charging
echo  7 = Charging and high
echo  8 = Charging and low
echo  9 = Charging and critical
echo  10 = Undefined
echo  11 = Partially charged
echo.
pause
goto SYSTEM_INFO

:DRIVER_INFO
cls
call :LOG "Viewing Driver Information"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            DRIVER INFORMATION                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View All Drivers
echo  [2] Search for Specific Driver
echo  [3] Export Driver List to File
echo  [4] Back to System Information
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Generating list of drivers... Please wait...
    echo.
    driverquery /v
    echo.
    pause
    goto DRIVER_INFO
) else if "%choice%"=="2" (
    cls
    echo.
    set /p searchterm="Enter driver name to search for: "
    echo.
    echo  Searching for "%searchterm%"... Please wait...
    echo.
    driverquery /v | findstr /i "%searchterm%"
    echo.
    pause
    goto DRIVER_INFO
) else if "%choice%"=="3" (
    cls
    echo.
    set "exportfile=%USERPROFILE%\Desktop\DriverList.txt"
    echo  Exporting driver list to %exportfile%... Please wait...
    echo.
    driverquery /v > "%exportfile%"
    echo  Export completed.
    echo.
    pause
    goto DRIVER_INFO
) else if "%choice%"=="4" (
    goto SYSTEM_INFO
) else (
    goto INVALID_CHOICE
)

:ACTIVATION_STATUS
cls
call :LOG "Checking Windows Activation Status"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                        WINDOWS ACTIVATION STATUS                               ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Checking Windows activation status... Please wait...
echo.
slmgr /dli
echo.
pause
goto SYSTEM_INFO

:NETWORK_TOOLS
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              NETWORK TOOLS                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] IP Configuration          [6] Trace Route
echo   [2] Ping Test                 [7] Network Connections
echo   [3] DNS Flush                 [8] Network Diagnostics
echo   [4] Network Statistics        [9] Wi-Fi Information
echo   [5] Open Ports                [10] Back to Main Menu
echo.
set /p choice="Select an option [1-10]: "
call :LOG "Selected option %choice% from Network Tools"

if "%choice%"=="1" goto IP_CONFIG
if "%choice%"=="2" goto PING_TEST
if "%choice%"=="3" goto DNS_FLUSH
if "%choice%"=="4" goto NETWORK_STATS
if "%choice%"=="5" goto OPEN_PORTS
if "%choice%"=="6" goto TRACE_ROUTE
if "%choice%"=="7" goto NETWORK_CONNECTIONS
if "%choice%"=="8" goto NETWORK_DIAGNOSTICS
if "%choice%"=="9" goto WIFI_INFO
if "%choice%"=="10" goto MAIN_MENU
goto INVALID_CHOICE

:IP_CONFIG
cls
call :LOG "Viewing IP Configuration"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            IP CONFIGURATION                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Basic IP Configuration
echo  [2] Detailed IP Configuration
echo  [3] Release IP Address
echo  [4] Renew IP Address
echo  [5] Back to Network Tools
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Basic IP Configuration:
    echo.
    ipconfig
    echo.
    pause
    goto IP_CONFIG
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Detailed IP Configuration:
    echo.
    ipconfig /all
    echo.
    pause
    goto IP_CONFIG
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Releasing IP Address... Please wait...
    echo.
    ipconfig /release
    echo.
    echo  IP Address released.
    echo.
    pause
    goto IP_CONFIG
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Renewing IP Address... Please wait...
    echo.
    ipconfig /renew
    echo.
    echo  IP Address renewed.
    echo.
    pause
    goto IP_CONFIG
) else if "%choice%"=="5" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:PING_TEST
cls
call :LOG "Running Ping Test"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                 PING TEST                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Standard Ping Test
echo  [2] Continuous Ping Test
echo  [3] Advanced Ping Test
echo  [4] Back to Network Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p pingaddr="Enter website or IP address to ping: "
    echo.
    echo  Pinging %pingaddr%... Please wait...
    echo.
    ping -n 4 %pingaddr%
    echo.
    pause
    goto PING_TEST
) else if "%choice%"=="2" (
    cls
    echo.
    set /p pingaddr="Enter website or IP address to ping continuously (Ctrl+C to stop): "
    echo.
    echo  Pinging %pingaddr% continuously... Press Ctrl+C to stop.
    echo.
    ping -t %pingaddr%
    echo.
    pause
    goto PING_TEST
) else if "%choice%"=="3" (
    cls
    echo.
    set /p pingaddr="Enter website or IP address to ping: "
    set /p pingsize="Enter packet size (default is 32): "
    set /p pingcount="Enter number of pings (default is 4): "
    echo.
    echo  Running advanced ping test... Please wait...
    echo.
    if not defined pingsize set "pingsize=32"
    if not defined pingcount set "pingcount=4"
    ping -n %pingcount% -l %pingsize% %pingaddr%
    echo.
    pause
    goto PING_TEST
) else if "%choice%"=="4" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:DNS_FLUSH
cls
call :LOG "Flushing DNS Cache"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                 DNS FLUSH                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Flush DNS Cache
echo  [2] Display DNS Cache
echo  [3] Register DNS
echo  [4] Back to Network Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Flushing DNS cache... Please wait...
    echo.
    ipconfig /flushdns
    echo.
    pause
    goto DNS_FLUSH
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Displaying DNS cache... Please wait...
    echo.
    ipconfig /displaydns
    echo.
    pause
    goto DNS_FLUSH
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Registering DNS... Please wait...
    echo.
    ipconfig /registerdns
    echo.
    pause
    goto DNS_FLUSH
) else if "%choice%"=="4" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:NETWORK_STATS
cls
call :LOG "Viewing Network Statistics"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           NETWORK STATISTICS                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Basic Network Statistics
echo  [2] TCP Statistics
echo  [3] UDP Statistics
echo  [4] ICMP Statistics
echo  [5] IP Statistics
echo  [6] Back to Network Tools
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Basic Network Statistics:
    echo.
    netstat -an
    echo.
    pause
    goto NETWORK_STATS
) else if "%choice%"=="2" (
    cls
    echo.
    echo  TCP Statistics:
    echo.
    netstat -s -p tcp
    echo.
    pause
    goto NETWORK_STATS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  UDP Statistics:
    echo.
    netstat -s -p udp
    echo.
    pause
    goto NETWORK_STATS
) else if "%choice%"=="4" (
    cls
    echo.
    echo  ICMP Statistics:
    echo.
    netstat -s -p icmp
    echo.
    pause
    goto NETWORK_STATS
) else if "%choice%"=="5" (
    cls
    echo.
    echo  IP Statistics:
    echo.
    netstat -s -p ip
    echo.
    pause
    goto NETWORK_STATS
) else if "%choice%"=="6" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:OPEN_PORTS
cls
call :LOG "Scanning Open Ports"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                OPEN PORTS                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View All Open Ports
echo  [2] View Ports with Process Information
echo  [3] Check Specific Port
echo  [4] Back to Network Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Scanning for open ports... Please wait...
    echo.
    netstat -an | findstr "LISTENING"
    echo.
    pause
    goto OPEN_PORTS
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Scanning for open ports with process information... Please wait...
    echo.
    netstat -ano | findstr "LISTENING"
    echo.
    pause
    goto OPEN_PORTS
) else if "%choice%"=="3" (
    cls
    echo.
    set /p portnum="Enter port number to check: "
    echo.
    echo  Checking port %portnum%... Please wait...
    echo.
    netstat -an | findstr ":%portnum% "
    echo.
    pause
    goto OPEN_PORTS
) else if "%choice%"=="4" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:TRACE_ROUTE
cls
call :LOG "Running Trace Route"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               TRACE ROUTE                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p traceaddr="Enter website or IP address to trace: "
echo.
echo  Tracing route to %traceaddr%... Please wait...
echo.
tracert %traceaddr%
echo.
pause
goto NETWORK_TOOLS

:NETWORK_CONNECTIONS
cls
call :LOG "Viewing Network Connections"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                          NETWORK CONNECTIONS                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View All Network Connections
echo  [2] View Active TCP Connections
echo  [3] View Active UDP Connections
echo  [4] Back to Network Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing all network connections... Please wait...
    echo.
    netstat -a
    echo.
    pause
    goto NETWORK_CONNECTIONS
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Viewing active TCP connections... Please wait...
    echo.
    netstat -a | findstr "TCP"
    echo.
    pause
    goto NETWORK_CONNECTIONS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Viewing active UDP connections... Please wait...
    echo.
    netstat -a | findstr "UDP"
    echo.
    pause
    goto NETWORK_CONNECTIONS
) else if "%choice%"=="4" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:NETWORK_DIAGNOSTICS
cls
call :LOG "Running Network Diagnostics"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           NETWORK DIAGNOSTICS                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Run Network Troubleshooter
echo  [2] Check Internet Connectivity
echo  [3] Reset Network Adapter
echo  [4] Reset TCP/IP Stack
echo  [5] Reset Winsock Catalog
echo  [6] Back to Network Tools
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Running Network Troubleshooter... Please wait...
    echo.
    msdt.exe /id NetworkDiagnosticsNetworkAdapter
    echo.
    pause
    goto NETWORK_DIAGNOSTICS
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Checking Internet connectivity... Please wait...
    echo.
    ping -n 4 www.google.com
    echo.
    pause
    goto NETWORK_DIAGNOSTICS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This will temporarily disconnect your network connection.
    set /p confirm="Are you sure you want to continue? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo.
        echo  Resetting network adapter... Please wait...
        echo.
        ipconfig /release
        ipconfig /renew
        echo.
        echo  Network adapter reset completed.
    ) else (
        echo.
        echo  Operation cancelled.
    )
    echo.
    pause
    goto NETWORK_DIAGNOSTICS
) else if "%choice%"=="4" (
    cls
    echo.
    echo  WARNING: This will reset your TCP/IP stack and requires a system restart.
    set /p confirm="Are you sure you want to continue? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo.
        echo  Resetting TCP/IP stack... Please wait...
        echo.
        netsh int ip reset
        echo.
        echo  TCP/IP stack reset completed. Please restart your computer.
    ) else (
        echo.
        echo  Operation cancelled.
    )
    echo.
    pause
    goto NETWORK_DIAGNOSTICS
) else if "%choice%"=="5" (
    cls
    echo.
    echo  WARNING: This will reset your Winsock catalog and requires a system restart.
    set /p confirm="Are you sure you want to continue? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo.
        echo  Resetting Winsock catalog... Please wait...
        echo.
        netsh winsock reset
        echo.
        echo  Winsock catalog reset completed. Please restart your computer.
    ) else (
        echo.
        echo  Operation cancelled.
    )
    echo.
    pause
    goto NETWORK_DIAGNOSTICS
) else if "%choice%"=="6" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:WIFI_INFO
cls
call :LOG "Viewing Wi-Fi Information"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             WI-FI INFORMATION                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Show Wi-Fi Networks
echo  [2] Show Wi-Fi Profiles
echo  [3] Show Current Wi-Fi Status
echo  [4] Export Wi-Fi Profiles
echo  [5] Back to Network Tools
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Scanning for Wi-Fi networks... Please wait...
    echo.
    netsh wlan show networks mode=bssid
    echo.
    pause
    goto WIFI_INFO
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Showing Wi-Fi profiles... Please wait...
    echo.
    netsh wlan show profiles
    echo.
    pause
    goto WIFI_INFO
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Showing current Wi-Fi status... Please wait...
    echo.
    netsh wlan show interfaces
    echo.
    pause
    goto WIFI_INFO
) else if "%choice%"=="4" (
    cls
    echo.
    set "exportdir=%USERPROFILE%\Desktop\WiFiProfiles"
    echo  Exporting Wi-Fi profiles to %exportdir%... Please wait...
    echo.
    if not exist "%exportdir%" mkdir "%exportdir%"
    for /f "tokens=2 delims=:" %%a in ('netsh wlan show profiles ^| findstr /C:"All User Profile"') do (
        set "profile=%%a"
        set "profile=!profile:~1!"
        netsh wlan export profile name="!profile!" folder="%exportdir%" key=clear
    )
    echo  Wi-Fi profiles exported successfully.
    echo.
    pause
    goto WIFI_INFO
) else if "%choice%"=="5" (
    goto NETWORK_TOOLS
) else (
    goto INVALID_CHOICE
)

:FILE_MANAGEMENT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             FILE MANAGEMENT                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] File Search               [5] File Encryption
echo   [2] Disk Space Usage          [6] File Permissions
echo   [3] File Cleanup              [7] File Comparison
echo   [4] Create Backup             [8] Back to Main Menu
echo.
set /p choice="Select an option [1-8]: "
call :LOG "Selected option %choice% from File Management"

if "%choice%"=="1" goto FILE_SEARCH
if "%choice%"=="2" goto DISK_SPACE
if "%choice%"=="3" goto FILE_CLEANUP
if "%choice%"=="4" goto CREATE_BACKUP
if "%choice%"=="5" goto FILE_ENCRYPTION
if "%choice%"=="6" goto FILE_PERMISSIONS
if "%choice%"=="7" goto FILE_COMPARISON
if "%choice%"=="8" goto MAIN_MENU
goto INVALID_CHOICE

:FILE_SEARCH
cls
call :LOG "Using File Search"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                FILE SEARCH                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Search by Filename
echo  [2] Search by Content
echo  [3] Search by Date
echo  [4] Search by Size
echo  [5] Back to File Management
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p searchterm="Enter file name to search for (wildcards allowed, e.g., *.txt): "
    set /p searchpath="Enter path to search in (e.g., C:\): "
    echo.
    echo  Searching for %searchterm% in %searchpath%... Please wait...
    echo.
    dir "%searchpath%\%searchterm%" /s /b
    echo.
    pause
    goto FILE_SEARCH
) else if "%choice%"=="2" (
    cls
    echo.
    set /p searchcontent="Enter text content to search for: "
    set /p searchpath="Enter path to search in (e.g., C:\): "
    set /p searchext="Enter file extension to search in (e.g., *.txt): "
    echo.
    echo  Searching for "%searchcontent%" in %searchext% files in %searchpath%... Please wait...
    echo.
    findstr /s /i /m "%searchcontent%" "%searchpath%\%searchext%"
    echo.
    pause
    goto FILE_SEARCH
) else if "%choice%"=="3" (
    cls
    echo.
    set /p searchdate="Enter date to search for (MM/DD/YYYY): "
    set /p searchpath="Enter path to search in (e.g., C:\): "
    echo.
    echo  Searching for files modified on %searchdate% in %searchpath%... Please wait...
    echo.
    forfiles /p "%searchpath%" /s /d %searchdate% /c "cmd /c echo @path"
    echo.
    pause
    goto FILE_SEARCH
) else if "%choice%"=="4" (
    cls
    echo.
    set /p searchsize="Enter minimum file size in bytes: "
    set /p searchpath="Enter path to search in (e.g., C:\): "
    echo.
    echo  Searching for files larger than %searchsize% bytes in %searchpath%... Please wait...
    echo.
    forfiles /p "%searchpath%" /s /m "*.*" /c "cmd /c if @fsize gtr %searchsize% echo @path @fsize bytes"
    echo.
    pause
    goto FILE_SEARCH
) else if "%choice%"=="5" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:DISK_SPACE
cls
call :LOG "Viewing Disk Space Usage"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             DISK SPACE USAGE                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Disk Space Information
echo  [2] View Folder Sizes
echo  [3] View Large Files
echo  [4] Back to File Management
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Disk space information:
    echo.
    wmic logicaldisk get deviceid,volumename,description,freespace,size
    echo.
    pause
    goto DISK_SPACE
) else if "%choice%"=="2" (
    cls
    echo.
    set /p folderpath="Enter folder path to analyze (e.g., C:\Users): "
    echo.
    echo  Analyzing folder sizes in %folderpath%... Please wait...
    echo.
    for /d %%a in ("%folderpath%\*") do (
        set "size=0"
        for /f "tokens=3" %%b in ('dir /s /a /-c "%%a" ^| findstr /i "File(s)"') do set "size=%%b"
        echo %%a - !size! bytes
    )
    echo.
    pause
    goto DISK_SPACE
) else if "%choice%"=="3" (
    cls
    echo.
    set /p searchpath="Enter path to search in (e.g., C:\): "
    set /p minsize="Enter minimum file size in MB: "
    echo.
    echo  Searching for files larger than %minsize% MB in %searchpath%... Please wait...
    echo.
    set /a minsize_bytes=%minsize%*1024*1024
    forfiles /p "%searchpath%" /s /m "*.*" /c "cmd /c if @fsize gtr %minsize_bytes% echo @path @fsize bytes"
    echo.
    pause
    goto DISK_SPACE
) else if "%choice%"=="4" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:FILE_CLEANUP
cls
call :LOG "Using File Cleanup"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               FILE CLEANUP                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Clean Temporary Files
echo  [2] Clean Windows Update Cache
echo  [3] Clean Recycle Bin
echo  [4] Clean Browser Cache
echo  [5] Clean System Logs
echo  [6] Back to File Management
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Cleaning temporary files... Please wait...
    echo.
    del /q /f /s %temp%\*
    del /q /f /s %windir%\Temp\*
    echo  Temporary files cleaned.
    echo.
    pause
    goto FILE_CLEANUP
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Cleaning Windows Update cache... Please wait...
    echo.
    net stop wuauserv
    rd /s /q C:\Windows\SoftwareDistribution
    net start wuauserv
    echo  Windows Update cache cleaned.
    echo.
    pause
    goto FILE_CLEANUP
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Cleaning Recycle Bin... Please wait...
    echo.
    rd /s /q C:\$Recycle.Bin
    echo  Recycle Bin cleaned.
    echo.
    pause
    goto FILE_CLEANUP
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Cleaning browser cache... Please wait...
    echo.
    echo  Cleaning Chrome cache...
    rd /s /q "%LOCALAPPDATA%\Google\Chrome\User Data\Default\Cache"
    echo  Cleaning Edge cache...
    rd /s /q "%LOCALAPPDATA%\Microsoft\Edge\User Data\Default\Cache"
    echo  Cleaning Firefox cache...
    rd /s /q "%LOCALAPPDATA%\Mozilla\Firefox\Profiles\*.default\cache2"
    echo  Browser cache cleaned.
    echo.
    pause
    goto FILE_CLEANUP
) else if "%choice%"=="5" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Cleaning system logs... Please wait...
    echo.
    wevtutil cl Application
    wevtutil cl System
    wevtutil cl Security
    echo  System logs cleaned.
    echo.
    pause
    goto FILE_CLEANUP
) else if "%choice%"=="6" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:CREATE_BACKUP
cls
call :LOG "Creating Backup"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               CREATE BACKUP                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Create File Backup
echo  [2] Create System Restore Point
echo  [3] Schedule Backup
echo  [4] Back to File Management
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p backupsrc="Enter source folder to backup: "
    set /p backupdest="Enter destination folder for backup: "
    set backupname=backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%_%time:~0,2%%time:~3,2%%time:~6,2%
    set backupname=%backupname: =0%
    echo.
    echo  Creating backup of %backupsrc% to %backupdest%\%backupname%...
    echo.
    if not exist "%backupdest%" mkdir "%backupdest%"
    xcopy "%backupsrc%" "%backupdest%\%backupname%" /e /i /h /y
    echo  Backup completed.
    echo.
    pause
    goto CREATE_BACKUP
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Creating system restore point... Please wait...
    echo.
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "MultiTool Restore Point", 100, 7
    echo  System restore point created.
    echo.
    pause
    goto CREATE_BACKUP
) else if "%choice%"=="3" (
    cls
    echo.
    set /p backupsrc="Enter source folder to backup: "
    set /p backupdest="Enter destination folder for backup: "
    set /p backuptime="Enter time for scheduled backup (HH:MM): "
    echo.
    echo  Scheduling backup of %backupsrc% to %backupdest% at %backuptime% daily...
    echo.
    schtasks /create /tn "MultiTool Backup" /tr "xcopy \"%backupsrc%\" \"%backupdest%\\backup_%date:~-4,4%%date:~-7,2%%date:~-10,2%\" /e /i /h /y" /sc daily /st %backuptime%
    echo  Backup scheduled.
    echo.
    pause
    goto CREATE_BACKUP
) else if "%choice%"=="4" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:FILE_ENCRYPTION
cls
call :LOG "Using File Encryption"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             FILE ENCRYPTION                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Encrypt File/Folder (EFS)
echo  [2] Decrypt File/Folder (EFS)
echo  [3] Back to File Management
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p encpath="Enter file or folder path to encrypt: "
    echo.
    echo  Encrypting %encpath%... Please wait...
    echo.
    cipher /e "%encpath%"
    echo  Encryption completed.
    echo.
    pause
    goto FILE_ENCRYPTION
) else if "%choice%"=="2" (
    cls
    echo.
    set /p decpath="Enter file or folder path to decrypt: "
    echo.
    echo  Decrypting %decpath%... Please wait...
    echo.
    cipher /d "%decpath%"
    echo  Decryption completed.
    echo.
    pause
    goto FILE_ENCRYPTION
) else if "%choice%"=="3" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:FILE_PERMISSIONS
cls
call :LOG "Managing File Permissions"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            FILE PERMISSIONS                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View File/Folder Permissions
echo  [2] Grant Full Control
echo  [3] Remove Permissions
echo  [4] Take Ownership
echo  [5] Back to File Management
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p permpath="Enter file or folder path to view permissions: "
    echo.
    echo  Viewing permissions for %permpath%... Please wait...
    echo.
    icacls "%permpath%"
    echo.
    pause
    goto FILE_PERMISSIONS
) else if "%choice%"=="2" (
    cls
    echo.
    set /p permpath="Enter file or folder path to grant permissions: "
    set /p username="Enter username to grant permissions to: "
    echo.
    echo  Granting full control to %username% for %permpath%... Please wait...
    echo.
    icacls "%permpath%" /grant "%username%":F
    echo  Permissions granted.
    echo.
    pause
    goto FILE_PERMISSIONS
) else if "%choice%"=="3" (
    cls
    echo.
    set /p permpath="Enter file or folder path to remove permissions: "
    set /p username="Enter username to remove permissions from: "
    echo.
    echo  Removing permissions for %username% from %permpath%... Please wait...
    echo.
    icacls "%permpath%" /remove "%username%"
    echo  Permissions removed.
    echo.
    pause
    goto FILE_PERMISSIONS
) else if "%choice%"=="4" (
    cls
    echo.
    set /p permpath="Enter file or folder path to take ownership: "
    echo.
    echo  Taking ownership of %permpath%... Please wait...
    echo.
    takeown /f "%permpath%" /r /d y
    echo  Ownership taken.
    echo.
    pause
    goto FILE_PERMISSIONS
) else if "%choice%"=="5" (
    goto FILE_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:FILE_COMPARISON
cls
call :LOG "Using File Comparison"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             FILE COMPARISON                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p file1="Enter path to first file: "
set /p file2="Enter path to second file: "
echo.
echo  Comparing %file1% and %file2%... Please wait...
echo.
fc "%file1%" "%file2%"
echo.
pause
goto FILE_MANAGEMENT

:SYSTEM_MAINTENANCE
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           SYSTEM MAINTENANCE                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] Check Disk               [6] System Restore
echo   [2] System File Checker      [7] Memory Diagnostics
echo   [3] Defragment Disk          [8] Power Configuration
echo   [4] Windows Update           [9] System Reset
echo   [5] DISM Repair              [10] Back to Main Menu
echo.
set /p choice="Select an option [1-10]: "
call :LOG "Selected option %choice% from System Maintenance"

if "%choice%"=="1" goto CHECK_DISK
if "%choice%"=="2" goto SYSTEM_FILE_CHECKER
if "%choice%"=="3" goto DEFRAG_DISK
if "%choice%"=="4" goto WINDOWS_UPDATE
if "%choice%"=="5" goto DISM_REPAIR
if "%choice%"=="6" goto SYSTEM_RESTORE
if "%choice%"=="7" goto MEMORY_DIAGNOSTICS
if "%choice%"=="8" goto POWER_CONFIG
if "%choice%"=="9" goto SYSTEM_RESET
if "%choice%"=="10" goto MAIN_MENU
goto INVALID_CHOICE

:CHECK_DISK
cls
call :LOG "Running Check Disk"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                 CHECK DISK                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Check Disk (Read-Only)
echo  [2] Check and Fix Errors
echo  [3] Check, Fix Errors, and Recover Bad Sectors
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p drive="Enter drive letter to check (e.g., C): "
    echo.
    echo  Checking drive %drive%:... Please wait...
    echo.
    chkdsk %drive%:
    echo.
    pause
    goto CHECK_DISK
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    set /p drive="Enter drive letter to check and fix (e.g., C): "
    echo.
    echo  This will schedule a disk check on the next system restart.
    echo.
    chkdsk %drive%: /f
    echo.
    pause
    goto CHECK_DISK
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    set /p drive="Enter drive letter to check, fix, and recover (e.g., C): "
    echo.
    echo  This will schedule a disk check on the next system restart.
    echo.
    chkdsk %drive%: /f /r
    echo.
    pause
    goto CHECK_DISK
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:SYSTEM_FILE_CHECKER
cls
call :LOG "Running System File Checker"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                          SYSTEM FILE CHECKER                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Scan System Files
echo  [2] Scan and Repair System Files
echo  [3] Verify System Files
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Scanning system files... Please wait...
    echo.
    sfc /scannow
    echo.
    pause
    goto SYSTEM_FILE_CHECKER
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Scanning and repairing system files... Please wait...
    echo.
    sfc /scannow /offbootdir=c:\ /offwindir=c:\windows
    echo.
    pause
    goto SYSTEM_FILE_CHECKER
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Verifying system files... Please wait...
    echo.
    sfc /verifyonly
    echo.
    pause
    goto SYSTEM_FILE_CHECKER
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:DEFRAG_DISK
cls
call :LOG "Running Disk Defragmentation"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           DEFRAGMENT DISK                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Analyze Disk
echo  [2] Defragment Disk
echo  [3] Optimize All Drives
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    set /p drive="Enter drive letter to analyze (e.g., C): "
    echo.
    echo  Analyzing drive %drive%:... Please wait...
    echo.
    defrag %drive%: /a
    echo.
    pause
    goto DEFRAG_DISK
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    set /p drive="Enter drive letter to defragment (e.g., C): "
    echo.
    echo  Defragmenting drive %drive%:... Please wait...
    echo.
    defrag %drive%: /u /v
    echo.
    pause
    goto DEFRAG_DISK
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Optimizing all drives... Please wait...
    echo.
    defrag /c /h /u /v
    echo.
    pause
    goto DEFRAG_DISK
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:WINDOWS_UPDATE
cls
call :LOG "Managing Windows Update"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             WINDOWS UPDATE                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Check for Updates
echo  [2] View Update History
echo  [3] Reset Windows Update
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Opening Windows Update...
    echo.
    start ms-settings:windowsupdate
    echo.
    pause
    goto WINDOWS_UPDATE
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Opening Windows Update History...
    echo.
    start ms-settings:windowsupdate-history
    echo.
    pause
    goto WINDOWS_UPDATE
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Resetting Windows Update... Please wait...
    echo.
    net stop wuauserv
    net stop cryptSvc
    net stop bits
    net stop msiserver
    ren C:\Windows\SoftwareDistribution SoftwareDistribution.old
    ren C:\Windows\System32\catroot2 catroot2.old
    net start wuauserv
    net start cryptSvc
    net start bits
    net start msiserver
    echo  Windows Update reset completed.
    echo.
    pause
    goto WINDOWS_UPDATE
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:DISM_REPAIR
cls
call :LOG "Running DISM Repair"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               DISM REPAIR                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Check Image Health
echo  [2] Scan Image Health
echo  [3] Restore Image Health
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Checking image health... Please wait...
    echo.
    DISM /Online /Cleanup-Image /CheckHealth
    echo.
    pause
    goto DISM_REPAIR
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Scanning image health... Please wait...
    echo.
    DISM /Online /Cleanup-Image /ScanHealth
    echo.
    pause
    goto DISM_REPAIR
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Restoring image health... Please wait...
    echo.
    DISM /Online /Cleanup-Image /RestoreHealth
    echo.
    pause
    goto DISM_REPAIR
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:SYSTEM_RESTORE
cls
call :LOG "Managing System Restore"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             SYSTEM RESTORE                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Create Restore Point
echo  [2] Restore System
echo  [3] Configure System Restore
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Creating system restore point... Please wait...
    echo.
    wmic.exe /Namespace:\\root\default Path SystemRestore Call CreateRestorePoint "MultiTool Restore Point", 100, 7
    echo  System restore point created.
    echo.
    pause
    goto SYSTEM_RESTORE
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Opening System Restore...
    echo.
    rstrui.exe
    echo.
    pause
    goto SYSTEM_RESTORE
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Opening System Protection Settings...
    echo.
    systempropertiesprotection
    echo.
    pause
    goto SYSTEM_RESTORE
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:MEMORY_DIAGNOSTICS
cls
call :LOG "Running Memory Diagnostics"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           MEMORY DIAGNOSTICS                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: This will restart your computer.
set /p confirm="Are you sure you want to run memory diagnostics? (Y/N): "
if /i "%confirm%"=="Y" (
    echo.
    echo  Starting Windows Memory Diagnostic Tool...
    echo.
    mdsched.exe
) else (
    echo.
    echo  Operation cancelled.
    echo.
    pause
)
goto SYSTEM_MAINTENANCE

:POWER_CONFIG
cls
call :LOG "Managing Power Configuration"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                          POWER CONFIGURATION                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Power Plans
echo  [2] Create Power Report
echo  [3] Open Power Options
echo  [4] Back to System Maintenance
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing power plans... Please wait...
    echo.
    powercfg /list
    echo.
    pause
    goto POWER_CONFIG
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Creating power report... Please wait...
    echo.
    powercfg /energy
    echo.
    echo  Power report created at %windir%\system32\energy-report.html
    echo.
    pause
    goto POWER_CONFIG
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Opening Power Options...
    echo.
    control powercfg.cpl
    echo.
    pause
    goto POWER_CONFIG
) else if "%choice%"=="4" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:SYSTEM_RESET
cls
call :LOG "System Reset Options"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              SYSTEM RESET                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: These options will reset your system.
echo.
echo  [1] Open Reset This PC
echo  [2] Open Advanced Startup Options
echo  [3] Back to System Maintenance
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Opening Reset This PC...
    echo.
    systemreset
    echo.
    pause
    goto SYSTEM_RESET
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Opening Advanced Startup Options...
    echo.
    shutdown /r /o /f /t 0
    echo.
    pause
    goto SYSTEM_RESET
) else if "%choice%"=="3" (
    goto SYSTEM_MAINTENANCE
) else (
    goto INVALID_CHOICE
)

:PROCESS_MANAGEMENT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           PROCESS MANAGEMENT                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] View Running Processes    [5] CPU Usage Monitor
echo   [2] Kill Process              [6] Memory Usage Monitor
echo   [3] Start Process             [7] Process Priority
echo   [4] Services Management       [8] Back to Main Menu
echo.
set /p choice="Select an option [1-8]: "
call :LOG "Selected option %choice% from Process Management"

if "%choice%"=="1" goto VIEW_PROCESSES
if "%choice%"=="2" goto KILL_PROCESS
if "%choice%"=="3" goto START_PROCESS
if "%choice%"=="4" goto SERVICES_MANAGEMENT
if "%choice%"=="5" goto CPU_MONITOR
if "%choice%"=="6" goto MEMORY_MONITOR
if "%choice%"=="7" goto PROCESS_PRIORITY
if "%choice%"=="8" goto MAIN_MENU
goto INVALID_CHOICE

:VIEW_PROCESSES
cls
call :LOG "Viewing Running Processes"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           RUNNING PROCESSES                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Basic Process List
echo  [2] View Detailed Process List
echo  [3] View Process Tree
echo  [4] View Process by CPU Usage
echo  [5] View Process by Memory Usage
echo  [6] Back to Process Management
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing basic process list... Please wait...
    echo.
    tasklist
    echo.
    pause
    goto VIEW_PROCESSES
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Viewing detailed process list... Please wait...
    echo.
    tasklist /v
    echo.
    pause
    goto VIEW_PROCESSES
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Viewing process tree... Please wait...
    echo.
    wmic process get Caption,ProcessId,ParentProcessId /format:list
    echo.
    pause
    goto VIEW_PROCESSES
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Viewing processes by CPU usage... Please wait...
    echo.
    wmic process get Caption,ProcessId,ThreadCount,HandleCount,WorkingSetSize,KernelModeTime,UserModeTime /format:list
    echo.
    pause
    goto VIEW_PROCESSES
) else if "%choice%"=="5" (
    cls
    echo.
    echo  Viewing processes by memory usage... Please wait...
    echo.
    tasklist /v /fi "memusage gt 10000" /sort:memusage
    echo.
    pause
    goto VIEW_PROCESSES
) else if "%choice%"=="6" (
    goto PROCESS_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:KILL_PROCESS
cls
call :LOG "Killing Process"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               KILL PROCESS                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Kill Process by Name
echo  [2] Kill Process by PID
echo  [3] Kill All Instances of a Process
echo  [4] Back to Process Management
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p procname="Enter process name to kill (e.g., notepad.exe): "
    echo.
    echo  Killing process %procname%... Please wait...
    echo.
    taskkill /f /im "%procname%"
    echo.
    pause
    goto KILL_PROCESS
) else if "%choice%"=="2" (
    cls
    echo.
    set /p procid="Enter process ID (PID) to kill: "
    echo.
    echo  Killing process with PID %procid%... Please wait...
    echo.
    taskkill /f /pid %procid%
    echo.
    pause
    goto KILL_PROCESS
) else if "%choice%"=="3" (
    cls
    echo.
    set /p procname="Enter process name to kill all instances (e.g., chrome.exe): "
    echo.
    echo  Killing all instances of %procname%... Please wait...
    echo.
    taskkill /f /im "%procname%" /t
    echo.
    pause
    goto KILL_PROCESS
) else if "%choice%"=="4" (
    goto PROCESS_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:START_PROCESS
cls
call :LOG "Starting Process"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               START PROCESS                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Start Program
echo  [2] Start Program with Arguments
echo  [3] Start Program as Administrator
echo  [4] Back to Process Management
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p procpath="Enter full path of program to start: "
    echo.
    echo  Starting %procpath%...
    echo.
    start "" "%procpath%"
    echo  Process started.
    echo.
    pause
    goto START_PROCESS
) else if "%choice%"=="2" (
    cls
    echo.
    set /p procpath="Enter full path of program to start: "
    set /p procargs="Enter arguments: "
    echo.
    echo  Starting %procpath% with arguments %procargs%...
    echo.
    start "" "%procpath%" %procargs%
    echo  Process started.
    echo.
    pause
    goto START_PROCESS
) else if "%choice%"=="3" (
    cls
    echo.
    set /p procpath="Enter full path of program to start as administrator: "
    echo.
    echo  Starting %procpath% as administrator...
    echo.
    powershell -Command "Start-Process '%procpath%' -Verb RunAs"
    echo  Process started.
    echo.
    pause
    goto START_PROCESS
) else if "%choice%"=="4" (
    goto PROCESS_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:SERVICES_MANAGEMENT
cls
call :LOG "Managing Services"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           SERVICES MANAGEMENT                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View All Services
echo  [2] View Running Services
echo  [3] Start Service
echo  [4] Stop Service
echo  [5] Restart Service
echo  [6] Change Service Startup Type
echo  [7] Back to Process Management
echo.
set /p choice="Select an option [1-7]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing all services... Please wait...
    echo.
    sc query type= service state= all
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Viewing running services... Please wait...
    echo.
    sc query type= service state= active
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="3" (
    cls
    echo.
    set /p svcname="Enter service name to start: "
    echo.
    echo  Starting service %svcname%... Please wait...
    echo.
    sc start "%svcname%"
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="4" (
    cls
    echo.
    set /p svcname="Enter service name to stop: "
    echo.
    echo  Stopping service %svcname%... Please wait...
    echo.
    sc stop "%svcname%"
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="5" (
    cls
    echo.
    set /p svcname="Enter service name to restart: "
    echo.
    echo  Restarting service %svcname%... Please wait...
    echo.
    sc stop "%svcname%"
    timeout /t 2 >nul
    sc start "%svcname%"
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="6" (
    cls
    echo.
    set /p svcname="Enter service name: "
    echo.
    echo  [1] Auto
    echo  [2] Manual
    echo  [3] Disabled
    echo.
    set /p starttype="Select startup type [1-3]: "
    echo.
    if "%starttype%"=="1" (
        sc config "%svcname%" start= auto
    ) else if "%starttype%"=="2" (
        sc config "%svcname%" start= demand
    ) else if "%starttype%"=="3" (
        sc config "%svcname%" start= disabled
    )
    echo  Service startup type changed.
    echo.
    pause
    goto SERVICES_MANAGEMENT
) else if "%choice%"=="7" (
    goto PROCESS_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:CPU_MONITOR
cls
call :LOG "Monitoring CPU Usage"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             CPU USAGE MONITOR                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Press Ctrl+C to stop monitoring.
echo.
echo  Monitoring CPU usage... Refreshing every 2 seconds.
echo.
:CPU_MONITOR_LOOP
cls
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             CPU USAGE MONITOR                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Press Ctrl+C to stop monitoring.
echo.
echo  Current Date and Time: %date% %time%
echo.
echo  Top CPU-consuming processes:
echo.
wmic process get Caption,ProcessId,ThreadCount,HandleCount,WorkingSetSize,KernelModeTime,UserModeTime /format:list | findstr /i "Caption ProcessId KernelModeTime UserModeTime"
echo.
timeout /t 2 >nul
goto CPU_MONITOR_LOOP

:MEMORY_MONITOR
cls
call :LOG "Monitoring Memory Usage"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           MEMORY USAGE MONITOR                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Press Ctrl+C to stop monitoring.
echo.
echo  Monitoring memory usage... Refreshing every 2 seconds.
echo.
:MEMORY_MONITOR_LOOP
cls
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           MEMORY USAGE MONITOR                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  Press Ctrl+C to stop monitoring.
echo.
echo  Current Date and Time: %date% %time%
echo.
echo  System Memory Information:
echo.
systeminfo | findstr /C:"Total Physical Memory" /C:"Available Physical Memory"
echo.
echo  Top memory-consuming processes:
echo.
tasklist /v /fi "memusage gt 10000" /sort:memusage
echo.
timeout /t 2 >nul
goto MEMORY_MONITOR_LOOP

:PROCESS_PRIORITY
cls
call :LOG "Managing Process Priority"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            PROCESS PRIORITY                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Set Process Priority
echo  [2] View Process Priority
echo  [3] Back to Process Management
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p procid="Enter process ID (PID): "
    echo.
    echo  [1] Low
    echo  [2] Below Normal
    echo  [3] Normal
    echo  [4] Above Normal
    echo  [5] High
    echo  [6] Realtime (Not Recommended)
    echo.
    set /p priority="Select priority level [1-6]: "
    echo.
    if "%priority%"=="1" (
        wmic process where ProcessId="%procid%" CALL setpriority "64"
    ) else if "%priority%"=="2" (
        wmic process where ProcessId="%procid%" CALL setpriority "16384"
    ) else if "%priority%"=="3" (
        wmic process where ProcessId="%procid%" CALL setpriority "32"
    ) else if "%priority%"=="4" (
        wmic process where ProcessId="%procid%" CALL setpriority "32768"
    ) else if "%priority%"=="5" (
        wmic process where ProcessId="%procid%" CALL setpriority "128"
    ) else if "%priority%"=="6" (
        wmic process where ProcessId="%procid%" CALL setpriority "256"
    )
    echo  Process priority changed.
    echo.
    pause
    goto PROCESS_PRIORITY
) else if "%choice%"=="2" (
    cls
    echo.
    set /p procid="Enter process ID (PID): "
    echo.
    echo  Viewing process priority... Please wait...
    echo.
    wmic process where ProcessId="%procid%" get Caption,ProcessId,Priority
    echo.
    pause
    goto PROCESS_PRIORITY
) else if "%choice%"=="3" (
    goto PROCESS_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:DISK_UTILITIES
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              DISK UTILITIES                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] List Drives               [5] Disk Benchmarking
echo   [2] Drive Properties          [6] Disk Partitioning
echo   [3] Disk Cleanup              [7] Mount/Unmount Drives
echo   [4] Disk Health               [8] Back to Main Menu
echo.
set /p choice="Select an option [1-8]: "
call :LOG "Selected option %choice% from Disk Utilities"

if "%choice%"=="1" goto LIST_DRIVES
if "%choice%"=="2" goto DRIVE_PROPERTIES
if "%choice%"=="3" goto DISK_CLEANUP
if "%choice%"=="4" goto DISK_HEALTH
if "%choice%"=="5" goto DISK_BENCHMARK
if "%choice%"=="6" goto DISK_PARTITION
if "%choice%"=="7" goto MOUNT_DRIVES
if "%choice%"=="8" goto MAIN_MENU
goto INVALID_CHOICE

:LIST_DRIVES
cls
call :LOG "Listing Drives"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                                LIST DRIVES                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] List All Drives
echo  [2] List Fixed Drives
echo  [3] List Removable Drives
echo  [4] List Network Drives
echo  [5] Back to Disk Utilities
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Listing all drives... Please wait...
    echo.
    wmic logicaldisk get deviceid,volumename,description,filesystem,size,freespace
    echo.
    pause
    goto LIST_DRIVES
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Listing fixed drives... Please wait...
    echo.
    wmic logicaldisk where "drivetype=3" get deviceid,volumename,description,filesystem,size,freespace
    echo.
    pause
    goto LIST_DRIVES
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Listing removable drives... Please wait...
    echo.
    wmic logicaldisk where "drivetype=2" get deviceid,volumename,description,filesystem,size,freespace
    echo.
    pause
    goto LIST_DRIVES
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Listing network drives... Please wait...
    echo.
    wmic logicaldisk where "drivetype=4" get deviceid,volumename,description,filesystem,size,freespace
    echo.
    pause
    goto LIST_DRIVES
) else if "%choice%"=="5" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:DRIVE_PROPERTIES
cls
call :LOG "Viewing Drive Properties"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             DRIVE PROPERTIES                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p drive="Enter drive letter (e.g., C): "
echo.
echo  Viewing properties for drive %drive%:... Please wait...
echo.
echo  Drive Information:
echo.
wmic logicaldisk where "DeviceID='%drive%:'" get DeviceID,VolumeName,Description,FileSystem,Size,FreeSpace,VolumeSerialNumber /format:list
echo.
echo  File System Information:
echo.
fsutil fsinfo ntfsinfo %drive%:
echo.
echo  Volume Information:
echo.
fsutil volume diskfree %drive%:
echo.
pause
goto DISK_UTILITIES

:DISK_CLEANUP
cls
call :LOG "Running Disk Cleanup"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               DISK CLEANUP                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Run Standard Disk Cleanup
echo  [2] Run Advanced Disk Cleanup
echo  [3] Clean System Files
echo  [4] Back to Disk Utilities
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p drive="Enter drive letter to clean (e.g., C): "
    echo.
    echo  Starting Disk Cleanup for drive %drive%:...
    echo.
    cleanmgr /d%drive%:
    echo.
    pause
    goto DISK_CLEANUP
) else if "%choice%"=="2" (
    cls
    echo.
    set /p drive="Enter drive letter to clean (e.g., C): "
    echo.
    echo  Starting Advanced Disk Cleanup for drive %drive%:...
    echo.
    cleanmgr /sageset:1
    cleanmgr /sagerun:1 /d%drive%:
    echo.
    pause
    goto DISK_CLEANUP
) else if "%choice%"=="3" (
    cls
    echo.
    set /p drive="Enter drive letter to clean system files (e.g., C): "
    echo.
    echo  Starting System Files Cleanup for drive %drive%:...
    echo.
    cleanmgr /verylowdisk /d%drive%:
    echo.
    pause
    goto DISK_CLEANUP
) else if "%choice%"=="4" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:DISK_HEALTH
cls
call :LOG "Checking Disk Health"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                               DISK HEALTH                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Check Disk Status
echo  [2] View SMART Attributes
echo  [3] Back to Disk Utilities
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Checking disk status... Please wait...
    echo.
    wmic diskdrive get Caption,Status,Size,InterfaceType,MediaType
    echo.
    pause
    goto DISK_HEALTH
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Viewing SMART attributes requires third-party tools.
    echo  Opening Windows Event Viewer for disk-related events...
    echo.
    eventvwr /c:System /f:"Disk"
    echo.
    pause
    goto DISK_HEALTH
) else if "%choice%"=="3" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:DISK_BENCHMARK
cls
call :LOG "Running Disk Benchmark"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             DISK BENCHMARKING                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Quick Read/Write Test
echo  [2] Back to Disk Utilities
echo.
set /p choice="Select an option [1-2]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p drive="Enter drive letter to test (e.g., C): "
    echo.
    echo  Running quick read/write test on drive %drive%:... Please wait...
    echo.
    echo  Creating test file...
    fsutil file createnew %drive%:\speedtest.dat 104857600
    echo  Testing write speed...
    copy %drive%:\speedtest.dat %drive%:\speedtest2.dat /y
    echo  Testing read speed...
    copy %drive%:\speedtest.dat nul
    echo  Cleaning up test files...
    del %drive%:\speedtest.dat
    del %drive%:\speedtest2.dat
    echo  Test completed.
    echo.
    pause
    goto DISK_BENCHMARK
) else if "%choice%"=="2" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:DISK_PARTITION
cls
call :LOG "Managing Disk Partitions"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            DISK PARTITIONING                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: This requires administrator privileges.
echo  [1] List Disk Partitions
echo  [2] Open Disk Management
echo  [3] Back to Disk Utilities
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Listing disk partitions... Please wait...
    echo.
    wmic partition get Name,Size,Type,BootPartition,PrimaryPartition,DiskIndex
    echo.
    pause
    goto DISK_PARTITION
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Opening Disk Management...
    echo.
    diskmgmt.msc
    echo.
    pause
    goto DISK_PARTITION
) else if "%choice%"=="3" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:MOUNT_DRIVES
cls
call :LOG "Mounting/Unmounting Drives"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           MOUNT/UNMOUNT DRIVES                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Map Network Drive
echo  [2] Disconnect Network Drive
echo  [3] Back to Disk Utilities
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p driveletter="Enter drive letter to map (e.g., Z): "
    set /p networkpath="Enter network path (e.g., \\server\share): "
    echo.
    echo  Mapping network drive %driveletter%: to %networkpath%... Please wait...
    echo.
    net use %driveletter%: "%networkpath%"
    echo.
    pause
    goto MOUNT_DRIVES
) else if "%choice%"=="2" (
    cls
    echo.
    set /p driveletter="Enter drive letter to disconnect (e.g., Z): "
    echo.
    echo  Disconnecting network drive %driveletter%:... Please wait...
    echo.
    net use %driveletter%: /delete
    echo.
    pause
    goto MOUNT_DRIVES
) else if "%choice%"=="3" (
    goto DISK_UTILITIES
) else (
    goto INVALID_CHOICE
)

:SECURITY_TOOLS
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              SECURITY TOOLS                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] Windows Defender          [5] Password Generator
echo   [2] Firewall Management       [6] Security Scan
echo   [3] User Account Security     [7] Security Event Viewer
echo   [4] Encryption Tools          [8] Back to Main Menu
echo.
set /p choice="Select an option [1-8]: "
call :LOG "Selected option %choice% from Security Tools"

if "%choice%"=="1" goto WINDOWS_DEFENDER
if "%choice%"=="2" goto FIREWALL_MANAGEMENT
if "%choice%"=="3" goto USER_ACCOUNT_SECURITY
if "%choice%"=="4" goto ENCRYPTION_TOOLS
if "%choice%"=="5" goto PASSWORD_GENERATOR
if "%choice%"=="6" goto SECURITY_SCAN
if "%choice%"=="7" goto SECURITY_EVENT_VIEWER
if "%choice%"=="8" goto MAIN_MENU
goto INVALID_CHOICE

:WINDOWS_DEFENDER
cls
call :LOG "Managing Windows Defender"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            WINDOWS DEFENDER                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Run Quick Scan
echo  [2] Run Full Scan
echo  [3] Update Definitions
echo  [4] View Defender Status
echo  [5] Open Windows Security
echo  [6] Back to Security Tools
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Running quick scan... Please wait...
    echo.
    powershell -Command "Start-MpScan -ScanType QuickScan"
    echo.
    pause
    goto WINDOWS_DEFENDER
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Running full scan... Please wait...
    echo.
    powershell -Command "Start-MpScan -ScanType FullScan"
    echo.
    pause
    goto WINDOWS_DEFENDER
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Updating definitions... Please wait...
    echo.
    powershell -Command "Update-MpSignature"
    echo.
    pause
    goto WINDOWS_DEFENDER
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Viewing Windows Defender status... Please wait...
    echo.
    powershell -Command "Get-MpComputerStatus"
    echo.
    pause
    goto WINDOWS_DEFENDER
) else if "%choice%"=="5" (
    cls
    echo.
    echo  Opening Windows Security...
    echo.
    start ms-settings:windowsdefender
    echo.
    pause
    goto WINDOWS_DEFENDER
) else if "%choice%"=="6" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:FIREWALL_MANAGEMENT
cls
call :LOG "Managing Firewall"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           FIREWALL MANAGEMENT                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Firewall Status
echo  [2] Enable Firewall
echo  [3] Disable Firewall
echo  [4] View Firewall Rules
echo  [5] Open Firewall Settings
echo  [6] Back to Security Tools
echo.
set /p choice="Select an option [1-6]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing firewall status... Please wait...
    echo.
    netsh advfirewall show allprofiles
    echo.
    pause
    goto FIREWALL_MANAGEMENT
) else if "%choice%"=="2" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  Enabling firewall... Please wait...
    echo.
    netsh advfirewall set allprofiles state on
    echo.
    pause
    goto FIREWALL_MANAGEMENT
) else if "%choice%"=="3" (
    cls
    echo.
    echo  WARNING: This requires administrator privileges.
    echo  WARNING: Disabling the firewall may pose security risks.
    set /p confirm="Are you sure you want to disable the firewall? (Y/N): "
    if /i "%confirm%"=="Y" (
        echo.
        echo  Disabling firewall... Please wait...
        echo.
        netsh advfirewall set allprofiles state off
    ) else (
        echo.
        echo  Operation cancelled.
    )
    echo.
    pause
    goto FIREWALL_MANAGEMENT
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Viewing firewall rules... Please wait...
    echo.
    netsh advfirewall firewall show rule name=all
    echo.
    pause
    goto FIREWALL_MANAGEMENT
) else if "%choice%"=="5" (
    cls
    echo.
    echo  Opening firewall settings...
    echo.
    control firewall.cpl
    echo.
    pause
    goto FIREWALL_MANAGEMENT
) else if "%choice%"=="6" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:USER_ACCOUNT_SECURITY
cls
call :LOG "Managing User Account Security"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                         USER ACCOUNT SECURITY                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View User Accounts
echo  [2] Change Password
echo  [3] Enable/Disable User Account
echo  [4] Open User Account Settings
echo  [5] Back to Security Tools
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing user accounts... Please wait...
    echo.
    net user
    echo.
    pause
    goto USER_ACCOUNT_SECURITY
) else if "%choice%"=="2" (
    cls
    echo.
    set /p username="Enter username to change password: "
    echo.
    echo  Changing password for %username%...
    echo.
    net user %username% *
    echo.
    pause
    goto USER_ACCOUNT_SECURITY
) else if "%choice%"=="3" (
    cls
    echo.
    set /p username="Enter username to enable/disable: "
    echo.
    echo  [1] Enable Account
    echo  [2] Disable Account
    echo.
    set /p action="Select action [1-2]: "
    echo.
    if "%action%"=="1" (
        echo  Enabling account for %username%... Please wait...
        net user %username% /active:yes
    ) else if "%action%"=="2" (
        echo  Disabling account for %username%... Please wait...
        net user %username% /active:no
    )
    echo.
    pause
    goto USER_ACCOUNT_SECURITY
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Opening user account settings...
    echo.
    control userpasswords2
    echo.
    pause
    goto USER_ACCOUNT_SECURITY
) else if "%choice%"=="5" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:ENCRYPTION_TOOLS
cls
call :LOG "Using Encryption Tools"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             ENCRYPTION TOOLS                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Encrypt File/Folder
echo  [2] Decrypt File/Folder
echo  [3] BitLocker Management
echo  [4] Back to Security Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p encpath="Enter file or folder path to encrypt: "
    echo.
    echo  Encrypting %encpath%... Please wait...
    echo.
    cipher /e "%encpath%"
    echo.
    pause
    goto ENCRYPTION_TOOLS
) else if "%choice%"=="2" (
    cls
    echo.
    set /p decpath="Enter file or folder path to decrypt: "
    echo.
    echo  Decrypting %decpath%... Please wait...
    echo.
    cipher /d "%decpath%"
    echo.
    pause
    goto ENCRYPTION_TOOLS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  [1] View BitLocker Status
    echo  [2] Enable BitLocker
    echo  [3] Disable BitLocker
    echo  [4] Back to Encryption Tools
    echo.
    set /p bitlocker="Select BitLocker option [1-4]: "
    echo.
    if "%bitlocker%"=="1" (
        echo  Viewing BitLocker status... Please wait...
        echo.
        manage-bde -status
    ) else if "%bitlocker%"=="2" (
        set /p drive="Enter drive letter to encrypt (e.g., C): "
        echo.
        echo  Enabling BitLocker on drive %drive%:... Please wait...
        echo.
        manage-bde -on %drive%:
    ) else if "%bitlocker%"=="3" (
        set /p drive="Enter drive letter to decrypt (e.g., C): "
        echo.
        echo  Disabling BitLocker on drive %drive%:... Please wait...
        echo.
        manage-bde -off %drive%:
    ) else if "%bitlocker%"=="4" (
        goto ENCRYPTION_TOOLS
    )
    echo.
    pause
    goto ENCRYPTION_TOOLS
) else if "%choice%"=="4" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:PASSWORD_GENERATOR
cls
call :LOG "Using Password Generator"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           PASSWORD GENERATOR                                   ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Generate Simple Password
echo  [2] Generate Complex Password
echo  [3] Generate Passphrase
echo  [4] Back to Security Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    set /p length="Enter password length (8-32): "
    echo.
    echo  Generating simple password... Please wait...
    echo.
    setlocal EnableDelayedExpansion
    set "chars=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
    set "password="
    for /L %%i in (1,1,%length%) do (
        set /a rand=!random! %% 62
        for /f %%j in ("!rand!") do set "password=!password!!chars:~%%j,1!"
    )
    echo  Generated password: !password!
    echo.
    pause
    goto PASSWORD_GENERATOR
) else if "%choice%"=="2" (
    cls
    echo.
    set /p length="Enter password length (8-32): "
    echo.
    echo  Generating complex password... Please wait...
    echo.
    setlocal EnableDelayedExpansion
    set "chars=ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789!@#$%%^&*()_+-=[]{}|;:,.<>?"
    set "password="
    for /L %%i in (1,1,%length%) do (
        set /a rand=!random! %% 90
        for /f %%j in ("!rand!") do set "password=!password!!chars:~%%j,1!"
    )
    echo  Generated password: !password!
    echo.
    pause
    goto PASSWORD_GENERATOR
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Generating passphrase... Please wait...
    echo.
    setlocal EnableDelayedExpansion
    set "words=apple banana orange grape melon cherry strawberry blueberry raspberry blackberry peach pear plum apricot nectarine mango pineapple kiwi watermelon cantaloupe honeydew lemon lime coconut fig date papaya guava"
    set "passphrase="
    for /L %%i in (1,1,4) do (
        set /a rand=!random! %% 30
        set /a count=0
        for %%w in (%words%) do (
            if !count! equ !rand! set "word=%%w"
            set /a count+=1
        )
        set "passphrase=!passphrase!!word!-"
    )
    set "passphrase=!passphrase:~0,-1!"
    echo  Generated passphrase: !passphrase!
    echo.
    pause
    goto PASSWORD_GENERATOR
) else if "%choice%"=="4" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:SECURITY_SCAN
cls
call :LOG "Running Security Scan"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                              SECURITY SCAN                                     ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Run Security Assessment
echo  [2] Check for Open Ports
echo  [3] Check for Pending Updates
echo  [4] Back to Security Tools
echo.
set /p choice="Select an option [1-4]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Running security assessment... Please wait...
    echo.
    echo  Checking Windows Defender status...
    powershell -Command "Get-MpComputerStatus | Select-Object AntivirusEnabled, RealTimeProtectionEnabled, IoavProtectionEnabled, AntispywareEnabled"
    echo.
    echo  Checking firewall status...
    netsh advfirewall show allprofiles state
    echo.
    echo  Checking for pending updates...
    wmic qfe list brief
    echo.
    echo  Checking for unauthorized users...
    net user
    echo.
    echo  Security assessment completed.
    echo.
    pause
    goto SECURITY_SCAN
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Checking for open ports... Please wait...
    echo.
    netstat -an | findstr "LISTENING"
    echo.
    pause
    goto SECURITY_SCAN
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Checking for pending updates... Please wait...
    echo.
    wmic qfe list brief
    echo.
    pause
    goto SECURITY_SCAN
) else if "%choice%"=="4" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:SECURITY_EVENT_VIEWER
cls
call :LOG "Viewing Security Events"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                          SECURITY EVENT VIEWER                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Security Log
echo  [2] View Failed Login Attempts
echo  [3] View Account Management Events
echo  [4] Open Event Viewer
echo  [5] Back to Security Tools
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing security log... Please wait...
    echo.
    wevtutil qe Security /c:5 /f:text
    echo.
    pause
    goto SECURITY_EVENT_VIEWER
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Viewing failed login attempts... Please wait...
    echo.
    wevtutil qe Security /q:"*[System[(EventID=4625)]]" /c:5 /f:text
    echo.
    pause
    goto SECURITY_EVENT_VIEWER
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Viewing account management events... Please wait...
    echo.
    wevtutil qe Security /q:"*[System[(EventID=4720 or EventID=4722 or EventID=4724 or EventID=4738)]]" /c:5 /f:text
    echo.
    pause
    goto SECURITY_EVENT_VIEWER
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Opening Event Viewer...
    echo.
    eventvwr
    echo.
    pause
    goto SECURITY_EVENT_VIEWER
) else if "%choice%"=="5" (
    goto SECURITY_TOOLS
) else (
    goto INVALID_CHOICE
)

:REGISTRY_MANAGEMENT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           REGISTRY MANAGEMENT                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] Open Registry Editor       [5] Import Registry File
echo   [2] Backup Registry            [6] Registry Tweaks
echo   [3] Restore Registry           [7] Back to Main Menu
echo   [4] Export Registry Key
echo.
set /p choice="Select an option [1-7]: "
call :LOG "Selected option %choice% from Registry Management"

if "%choice%"=="1" goto REGISTRY_EDITOR
if "%choice%"=="2" goto BACKUP_REGISTRY
if "%choice%"=="3" goto RESTORE_REGISTRY
if "%choice%"=="4" goto EXPORT_REGISTRY
if "%choice%"=="5" goto IMPORT_REGISTRY
if "%choice%"=="6" goto REGISTRY_TWEAKS
if "%choice%"=="7" goto MAIN_MENU
goto INVALID_CHOICE

:REGISTRY_EDITOR
cls
call :LOG "Opening Registry Editor"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             REGISTRY EDITOR                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: Modifying the registry can cause serious system problems.
echo  Only make changes if you know what you're doing.
echo.
echo  Opening Registry Editor...
echo.
regedit
echo.
pause
goto REGISTRY_MANAGEMENT

:BACKUP_REGISTRY
cls
call :LOG "Backing Up Registry"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             BACKUP REGISTRY                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] Full Registry Backup
echo  [2] Partial Registry Backup
echo  [3] Back to Registry Management
echo.
set /p choice="Select an option [1-3]: "

if "%choice%"=="1" (
    cls
    echo.
    set "backupfile=%USERPROFILE%\Desktop\RegistryBackup_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg"
    echo  Creating full registry backup to %backupfile%... Please wait...
    echo.
    reg export HKLM "%backupfile%"
    echo  Registry backup completed.
    echo.
    pause
    goto BACKUP_REGISTRY
) else if "%choice%"=="2" (
    cls
    echo.
    echo  [1] HKEY_CURRENT_USER
    echo  [2] HKEY_LOCAL_MACHINE
    echo  [3] HKEY_CLASSES_ROOT
    echo  [4] HKEY_USERS
    echo  [5] HKEY_CURRENT_CONFIG
    echo.
    set /p regkey="Select registry key to backup [1-5]: "
    echo.
    set "backupfile=%USERPROFILE%\Desktop\RegistryBackup_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg"
    if "%regkey%"=="1" (
        echo  Creating HKEY_CURRENT_USER backup to %backupfile%... Please wait...
        reg export HKCU "%backupfile%"
    ) else if "%regkey%"=="2" (
        echo  Creating HKEY_LOCAL_MACHINE backup to %backupfile%... Please wait...
        reg export HKLM "%backupfile%"
    ) else if "%regkey%"=="3" (
        echo  Creating HKEY_CLASSES_ROOT backup to %backupfile%... Please wait...
        reg export HKCR "%backupfile%"
    ) else if "%regkey%"=="4" (
        echo  Creating HKEY_USERS backup to %backupfile%... Please wait...
        reg export HKU "%backupfile%"
    ) else if "%regkey%"=="5" (
        echo  Creating HKEY_CURRENT_CONFIG backup to %backupfile%... Please wait...
        reg export HKCC "%backupfile%"
    )
    echo  Registry backup completed.
    echo.
    pause
    goto BACKUP_REGISTRY
) else if "%choice%"=="3" (
    goto REGISTRY_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:RESTORE_REGISTRY
cls
call :LOG "Restoring Registry"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            RESTORE REGISTRY                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p regfile="Enter path to registry backup file (.reg): "
echo.
echo  WARNING: Restoring registry can cause system instability if the backup is corrupted.
set /p confirm="Are you sure you want to restore this registry backup? (Y/N): "
if /i "%confirm%"=="Y" (
    echo.
    echo  Restoring registry from %regfile%... Please wait...
    echo.
    reg import "%regfile%"
    echo  Registry restore completed.
) else (
    echo.
    echo  Operation cancelled.
)
echo.
pause
goto REGISTRY_MANAGEMENT

:EXPORT_REGISTRY
cls
call :LOG "Exporting Registry Key"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           EXPORT REGISTRY KEY                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] HKEY_CURRENT_USER
echo  [2] HKEY_LOCAL_MACHINE
echo  [3] HKEY_CLASSES_ROOT
echo  [4] HKEY_USERS
echo  [5] HKEY_CURRENT_CONFIG
echo  [6] Back to Registry Management
echo.
set /p regkey="Select registry key to export [1-6]: "
echo.
if "%regkey%"=="6" goto REGISTRY_MANAGEMENT
set /p subkey="Enter subkey to export (e.g., Software\Microsoft\Windows): "
set "exportfile=%USERPROFILE%\Desktop\RegExport_%date:~-4,4%%date:~-7,2%%date:~-10,2%.reg"
echo.
echo  Exporting registry key to %exportfile%... Please wait...
echo.
if "%regkey%"=="1" (
    reg export "HKCU\%subkey%" "%exportfile%"
) else if "%regkey%"=="2" (
    reg export "HKLM\%subkey%" "%exportfile%"
) else if "%regkey%"=="3" (
    reg export "HKCR\%subkey%" "%exportfile%"
) else if "%regkey%"=="4" (
    reg export "HKU\%subkey%" "%exportfile%"
) else if "%regkey%"=="5" (
    reg export "HKCC\%subkey%" "%exportfile%"
)
echo  Registry key exported.
echo.
pause
goto REGISTRY_MANAGEMENT

:IMPORT_REGISTRY
cls
call :LOG "Importing Registry File"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           IMPORT REGISTRY FILE                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
set /p regfile="Enter path to registry file (.reg) to import: "
echo.
echo  WARNING: Importing registry files can cause system instability.
set /p confirm="Are you sure you want to import this registry file? (Y/N): "
if /i "%confirm%"=="Y" (
    echo.
    echo  Importing registry file %regfile%... Please wait...
    echo.
    reg import "%regfile%"
    echo  Registry file imported.
) else (
    echo.
    echo  Operation cancelled.
)
echo.
pause
goto REGISTRY_MANAGEMENT

:REGISTRY_TWEAKS
cls
call :LOG "Applying Registry Tweaks"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             REGISTRY TWEAKS                                    ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: Modifying the registry can cause serious system problems.
echo  Only apply tweaks if you understand their effects.
echo.
echo  [1] Disable Windows Animations
echo  [2] Enable Windows Animations
echo  [3] Disable Startup Delay
echo  [4] Enable Startup Delay
echo  [5] Show File Extensions
echo  [6] Hide File Extensions
echo  [7] Back to Registry Management
echo.
set /p choice="Select an option [1-7]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Disabling Windows animations... Please wait...
    echo.
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 0 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 3 /f
    echo  Windows animations disabled.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="2" (
    cls
    echo.
    echo  Enabling Windows animations... Please wait...
    echo.
    reg add "HKCU\Control Panel\Desktop\WindowMetrics" /v MinAnimate /t REG_SZ /d 1 /f
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\VisualEffects" /v VisualFXSetting /t REG_DWORD /d 1 /f
    echo  Windows animations enabled.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Disabling startup delay... Please wait...
    echo.
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /t REG_DWORD /d 0 /f
    echo  Startup delay disabled.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Enabling startup delay... Please wait...
    echo.
    reg delete "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Serialize" /v StartupDelayInMSec /f
    echo  Startup delay enabled.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="5" (
    cls
    echo.
    echo  Showing file extensions... Please wait...
    echo.
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 0 /f
    echo  File extensions will be shown. Please restart Explorer for changes to take effect.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="6" (
    cls
    echo.
    echo  Hiding file extensions... Please wait...
    echo.
    reg add "HKCU\Software\Microsoft\Windows\CurrentVersion\Explorer\Advanced" /v HideFileExt /t REG_DWORD /d 1 /f
    echo  File extensions will be hidden. Please restart Explorer for changes to take effect.
    echo.
    pause
    goto REGISTRY_TWEAKS
) else if "%choice%"=="7" (
    goto REGISTRY_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:USER_ACCOUNT_MANAGEMENT
cls
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                        USER ACCOUNT MANAGEMENT                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo   [1] View User Accounts         [5] Change Account Type
echo   [2] Create User Account        [6] User Profile Management
echo   [3] Delete User Account        [7] Back to Main Menu
echo   [4] Reset Password
echo.
set /p choice="Select an option [1-7]: "
call :LOG "Selected option %choice% from User Account Management"

if "%choice%"=="1" goto VIEW_USERS
if "%choice%"=="2" goto CREATE_USER
if "%choice%"=="3" goto DELETE_USER
if "%choice%"=="4" goto RESET_PASSWORD
if "%choice%"=="5" goto CHANGE_ACCOUNT_TYPE
if "%choice%"=="6" goto USER_PROFILE_MANAGEMENT
if "%choice%"=="7" goto MAIN_MENU
goto INVALID_CHOICE

:VIEW_USERS
cls
call :LOG "Viewing User Accounts"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                             USER ACCOUNTS                                      ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  [1] View Basic User List
echo  [2] View Detailed User Information
echo  [3] View Administrator Accounts
echo  [4] View User Groups
echo  [5] Back to User Account Management
echo.
set /p choice="Select an option [1-5]: "

if "%choice%"=="1" (
    cls
    echo.
    echo  Viewing basic user list... Please wait...
    echo.
    net user
    echo.
    pause
    goto VIEW_USERS
) else if "%choice%"=="2" (
    cls
    echo.
    set /p username="Enter username to view details: "
    echo.
    echo  Viewing detailed information for %username%... Please wait...
    echo.
    net user "%username%"
    echo.
    pause
    goto VIEW_USERS
) else if "%choice%"=="3" (
    cls
    echo.
    echo  Viewing administrator accounts... Please wait...
    echo.
    net localgroup administrators
    echo.
    pause
    goto VIEW_USERS
) else if "%choice%"=="4" (
    cls
    echo.
    echo  Viewing user groups... Please wait...
    echo.
    net localgroup
    echo.
    pause
    goto VIEW_USERS
) else if "%choice%"=="5" (
    goto USER_ACCOUNT_MANAGEMENT
) else (
    goto INVALID_CHOICE
)

:CREATE_USER
cls
call :LOG "Creating User Account"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                            CREATE USER ACCOUNT                                 ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: This requires administrator privileges.
set /p username="Enter new username: "
set /p fullname="Enter full name: "
set /p description="Enter description: "
echo.
echo  [1] Standard User
echo  [2] Administrator
echo.
set /p accounttype="Select account type [1-2]: "
echo.
echo  Creating user account %username%... Please wait...
echo.
net user "%username%" * /add /fullname:"%fullname%" /comment:"%description%"
if "%accounttype%"=="2" (
    net localgroup administrators "%username%" /add
    echo  User %username% added to administrators group.
)
echo  User account created.
echo.
pause
goto USER_ACCOUNT_MANAGEMENT

:DELETE_USER
cls
call :LOG "Deleting User Account"
echo.
echo  ╔════════════════════════════════════════════════════════════════════════════════╗
echo  ║                           DELETE USER ACCOUNT                                  ║
echo  ╚════════════════════════════════════════════════════════════════════════════════╝
echo.
echo  WARNING: This requires administrator privileges.
echo  WARNING: Deleting a user account will remove all associated data.
echo.
set /p username="Enter username to delete: "
echo.
echo  WARNING: This will permanently delete the user account %username% and all associated data.
set /p confirm="Are you sure you want to continue? (Y/N): "
if /i "%confirm%"=="Y" 
