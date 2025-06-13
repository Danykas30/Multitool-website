@echo off
title Quick Launcher Tool
color 0D
echo.
echo =====================================
echo        QUICK LAUNCHER TOOL
echo =====================================
echo.

echo [1] System Tools
echo [2] Development Tools
echo [3] File Operations
echo [4] Network Tools
echo [5] Custom Commands
echo [6] Add New Shortcut
echo [0] Exit
echo.

set /p choice="Select a category (0-6): "

if "%choice%"=="1" goto system_tools
if "%choice%"=="2" goto dev_tools
if "%choice%"=="3" goto file_ops
if "%choice%"=="4" goto network_tools
if "%choice%"=="5" goto custom_commands
if "%choice%"=="6" goto add_shortcut
if "%choice%"=="0" goto end
goto invalid

:system_tools
echo.
echo === SYSTEM TOOLS ===
echo.
echo [1] Task Manager
echo [2] Device Manager
echo [3] System Information
echo [4] Registry Editor
echo [5] Services
echo [6] Event Viewer
echo [7] System Configuration
echo [8] Disk Management
echo [9] Control Panel
echo [0] Back to Main Menu
echo.

set /p sys_choice="Select tool (0-9): "

if "%sys_choice%"=="1" start taskmgr
if "%sys_choice%"=="2" start devmgmt.msc
if "%sys_choice%"=="3" start msinfo32
if "%sys_choice%"=="4" start regedit
if "%sys_choice%"=="5" start services.msc
if "%sys_choice%"=="6" start eventvwr
if "%sys_choice%"=="7" start msconfig
if "%sys_choice%"=="8" start diskmgmt.msc
if "%sys_choice%"=="9" start control
if "%sys_choice%"=="0" goto menu

echo Tool launched!
pause
goto system_tools

:dev_tools
echo.
echo === DEVELOPMENT TOOLS ===
echo.
echo [1] Command Prompt
echo [2] PowerShell
echo [3] Notepad++
echo [4] Visual Studio Code
echo [5] Git Bash
echo [6] Node.js Command Prompt
echo [7] Python IDLE
echo [8] Calculator
echo [0] Back to Main Menu
echo.

set /p dev_choice="Select tool (0-8): "

if "%dev_choice%"=="1" start cmd
if "%dev_choice%"=="2" start powershell
if "%dev_choice%"=="3" start notepad++
if "%dev_choice%"=="4" start code
if "%dev_choice%"=="5" start "" "C:\Program Files\Git\bin\bash.exe"
if "%dev_choice%"=="6" start "" "C:\Program Files\nodejs\nodevars.bat"
if "%dev_choice%"=="7" start "" "C:\Program Files\Python\Lib\idlelib\idle.bat"
if "%dev_choice%"=="8" start calc
if "%dev_choice%"=="0" goto menu

echo Tool launched! (If not found, please check installation path)
pause
goto dev_tools

:file_ops
echo.
echo === FILE OPERATIONS ===
echo.
echo [1] File Explorer (Current Location)
echo [2] File Explorer (Downloads)
echo [3] File Explorer (Documents)
echo [4] File Explorer (Desktop)
echo [5] Find Files by Name
echo [6] Find Files by Extension
echo [7] Show Hidden Files Toggle
echo [8] Create New Folder
echo [0] Back to Main Menu
echo.

set /p file_choice="Select operation (0-8): "

if "%file_choice%"=="1" start explorer "%cd%"
if "%file_choice%"=="2" start explorer "%USERPROFILE%\Downloads"
if "%file_choice%"=="3" start explorer "%USERPROFILE%\Documents"
if "%file_choice%"=="4" start explorer "%USERPROFILE%\Desktop"
if "%file_choice%"=="5" goto find_by_name
if "%file_choice%"=="6" goto find_by_extension
if "%file_choice%"=="7" goto toggle_hidden
if "%file_choice%"=="8" goto create_folder
if "%file_choice%"=="0" goto menu

pause
goto file_ops

:find_by_name
echo.
set /p filename="Enter filename to search for: "
set /p search_path="Enter search path (or press Enter for C:\): "
if "%search_path%"=="" set search_path=C:\

echo.
echo Searching for "%filename%" in %search_path%...
dir "%search_path%\%filename%" /s /b 2>nul
pause
goto file_ops

:find_by_extension
echo.
set /p extension="Enter file extension (e.g., .txt, .pdf): "
set /p search_path="Enter search path (or press Enter for current directory): "
if "%search_path%"=="" set search_path=%cd%

echo.
echo Searching for %extension% files in %search_path%...
dir "%search_path%\*%extension%" /s /b 2>nul
pause
goto file_ops

:toggle_hidden
echo.
echo Toggling hidden files visibility...
attrib -h *.* /s
echo Hidden files are now visible. Run again to hide them.
pause
goto file_ops

:create_folder
echo.
set /p foldername="Enter new folder name: "
if not "%foldername%"=="" (
    mkdir "%foldername%"
    echo Folder "%foldername%" created successfully.
) else (
    echo Invalid folder name.
)
pause
goto file_ops

:network_tools
echo.
echo === NETWORK TOOLS ===
echo.
echo [1] Ping Test
echo [2] Trace Route
echo [3] IP Configuration
echo [4] Network Connections
echo [5] WiFi Passwords
echo [6] Flush DNS
echo [7] Release/Renew IP
echo [8] Open Network Settings
echo [0] Back to Main Menu
echo.

set /p net_choice="Select tool (0-8): "

if "%net_choice%"=="1" goto ping_custom
if "%net_choice%"=="2" goto trace_route
if "%net_choice%"=="3" ipconfig /all & pause
if "%net_choice%"=="4" netstat -an & pause
if "%net_choice%"=="5" netsh wlan show profiles & pause
if "%net_choice%"=="6" ipconfig /flushdns & echo DNS cache flushed & pause
if "%net_choice%"=="7" ipconfig /release && ipconfig /renew & echo IP renewed & pause
if "%net_choice%"=="8" start ms-settings:network
if "%net_choice%"=="0" goto menu

goto network_tools

:ping_custom
echo.
set /p ping_target="Enter IP address or domain to ping: "
ping -n 4 "%ping_target%"
pause
goto network_tools

:trace_route
echo.
set /p trace_target="Enter IP address or domain to trace: "
tracert "%trace_target%"
pause
goto network_tools

:custom_commands
echo.
echo === CUSTOM COMMANDS ===
echo.
echo You can add your frequently used commands here.
echo Edit this batch file to customize this section.
echo.
echo [1] Open Current Directory in VSCode
echo [2] Git Status (if in git repo)
echo [3] List Directory Contents
echo [4] System Uptime
echo [5] Memory Usage
echo [0] Back to Main Menu
echo.

set /p custom_choice="Select command (0-5): "

if "%custom_choice%"=="1" code "%cd%"
if "%custom_choice%"=="2" git status
if "%custom_choice%"=="3" dir /w
if "%custom_choice%"=="4" systeminfo | findstr "System Boot Time"
if "%custom_choice%"=="5" wmic OS get TotalVisibleMemorySize,FreePhysicalMemory /value
if "%custom_choice%"=="0" goto menu

echo.
pause
goto custom_commands

:add_shortcut
echo.
echo === ADD NEW SHORTCUT ===
echo.
echo This feature allows you to add new shortcuts by editing this batch file.
echo.
echo To add a new shortcut:
echo 1. Open this batch file in a text editor
echo 2. Find the appropriate section (system_tools, dev_tools, etc.)
echo 3. Add your command using the existing format
echo.
echo Example: if "%choice%"=="X" start notepad
echo.
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
echo        QUICK LAUNCHER TOOL
echo =====================================
echo.

echo [1] System Tools
echo [2] Development Tools
echo [3] File Operations
echo [4] Network Tools
echo [5] Custom Commands
echo [6] Add New Shortcut
echo [0] Exit
echo.

set /p choice="Select a category (0-6): "

if "%choice%"=="1" goto system_tools
if "%choice%"=="2" goto dev_tools
if "%choice%"=="3" goto file_ops
if "%choice%"=="4" goto network_tools
if "%choice%"=="5" goto custom_commands
if "%choice%"=="6" goto add_shortcut
if "%choice%"=="0" goto end
goto invalid

:end
echo.
echo Thank you for using Quick Launcher Tool!
pause
exit
