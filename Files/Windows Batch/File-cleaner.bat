@echo off
title File Cleanup Tool
color 0C
echo.
echo =====================================
echo         FILE CLEANUP TOOL
echo =====================================
echo.
echo WARNING: This tool will delete temporary files and clear caches.
echo Make sure you've saved all important work before proceeding.
echo.

echo [1] Clean Temporary Files
echo [2] Clean Browser Cache (Chrome)
echo [3] Clean Recycle Bin
echo [4] Clean System Logs
echo [5] Full Cleanup (All Above)
echo [6] Custom File Cleanup
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto temp_files
if "%choice%"=="2" goto browser_cache
if "%choice%"=="3" goto recycle_bin
if "%choice%"=="4" goto system_logs
if "%choice%"=="5" goto full_cleanup
if "%choice%"=="6" goto custom_cleanup
if "%choice%"=="0" goto end
goto invalid

:temp_files
echo.
echo Cleaning temporary files...
del /q/f/s %TEMP%\*
del /q/f/s C:\Windows\Temp\*
del /q/f/s C:\Windows\Prefetch\*
echo Temporary files cleaned.
pause
goto menu

:browser_cache
echo.
echo Cleaning Chrome browser cache...
taskkill /f /im chrome.exe >nul 2>&1
timeout /t 2 >nul
rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Code Cache" >nul 2>&1
echo Chrome cache cleaned.
pause
goto menu

:recycle_bin
echo.
echo Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1
echo Recycle Bin emptied.
pause
goto menu

:system_logs
echo.
echo Cleaning system logs...
for /f "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo System logs cleaned.
pause
goto menu

:do_clear
wevtutil.exe cl %1 >nul 2>&1
goto :eof

:full_cleanup
echo.
echo Performing full cleanup...
echo.
echo [1/4] Cleaning temporary files...
del /q/f/s %TEMP%\* >nul 2>&1
del /q/f/s C:\Windows\Temp\* >nul 2>&1
del /q/f/s C:\Windows\Prefetch\* >nul 2>&1
echo.
echo [2/4] Cleaning browser cache...
taskkill /f /im chrome.exe >nul 2>&1
timeout /t 2 >nul
rd /s /q "%USERPROFILE%\AppData\Local\Google\Chrome\User Data\Default\Cache" >nul 2>&1
echo.
echo [3/4] Emptying Recycle Bin...
rd /s /q C:\$Recycle.Bin >nul 2>&1
echo.
echo [4/4] Cleaning system logs...
for /f "tokens=*" %%G in ('wevtutil.exe el') DO (call :do_clear "%%G")
echo.
echo Full cleanup completed!
pause
goto menu

:custom_cleanup
echo.
echo === CUSTOM FILE CLEANUP ===
echo.
set /p extension="Enter file extension to clean (e.g., .tmp, .log): "
set /p directory="Enter directory path (or press Enter for current directory): "

if "%directory%"=="" set directory=%cd%

echo.
echo Searching for %extension% files in %directory%...
dir "%directory%\*%extension%" /s /b 2>nul | find /c /v "" > temp_count.txt
set /p filecount=<temp_count.txt
del temp_count.txt

if %filecount%==0 (
    echo No %extension% files found in %directory%
) else (
    echo Found %filecount% files with %extension% extension.
    echo.
    set /p confirm="Delete all %extension% files? (Y/N): "
    if /i "%confirm%"=="Y" (
        del "%directory%\*%extension%" /s /q >nul 2>&1
        echo Files deleted successfully.
    ) else (
        echo Operation cancelled.
    )
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
echo         FILE CLEANUP TOOL
echo =====================================
echo.
echo WARNING: This tool will delete temporary files and clear caches.
echo Make sure you've saved all important work before proceeding.
echo.

echo [1] Clean Temporary Files
echo [2] Clean Browser Cache (Chrome)
echo [3] Clean Recycle Bin
echo [4] Clean System Logs
echo [5] Full Cleanup (All Above)
echo [6] Custom File Cleanup
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto temp_files
if "%choice%"=="2" goto browser_cache
if "%choice%"=="3" goto recycle_bin
if "%choice%"=="4" goto system_logs
if "%choice%"=="5" goto full_cleanup
if "%choice%"=="6" goto custom_cleanup
if "%choice%"=="0" goto end
goto invalid

:end
echo.
echo Thank you for using File Cleanup Tool!
pause
exit
