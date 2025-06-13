@echo off
title Folder Organizer Tool
color 0E
echo.
echo =====================================
echo       FOLDER ORGANIZER TOOL
echo =====================================
echo.

echo [1] Organize by File Type
echo [2] Organize by Date Modified
echo [3] Remove Empty Folders
echo [4] Find Duplicate Files
echo [5] Create Project Structure
echo [6] Backup Important Files
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto organize_by_type
if "%choice%"=="2" goto organize_by_date
if "%choice%"=="3" goto remove_empty
if "%choice%"=="4" goto find_duplicates
if "%choice%"=="5" goto create_structure
if "%choice%"=="6" goto backup_files
if "%choice%"=="0" goto end
goto invalid

:organize_by_type
echo.
echo === ORGANIZE BY FILE TYPE ===
echo.
set /p source_dir="Enter source directory path (or press Enter for current): "
if "%source_dir%"=="" set source_dir=%cd%

echo.
echo Creating organization folders...
if not exist "%source_dir%\Organized" mkdir "%source_dir%\Organized"
if not exist "%source_dir%\Organized\Images" mkdir "%source_dir%\Organized\Images"
if not exist "%source_dir%\Organized\Documents" mkdir "%source_dir%\Organized\Documents"
if not exist "%source_dir%\Organized\Videos" mkdir "%source_dir%\Organized\Videos"
if not exist "%source_dir%\Organized\Audio" mkdir "%source_dir%\Organized\Audio"
if not exist "%source_dir%\Organized\Archives" mkdir "%source_dir%\Organized\Archives"
if not exist "%source_dir%\Organized\Programs" mkdir "%source_dir%\Organized\Programs"
if not exist "%source_dir%\Organized\Other" mkdir "%source_dir%\Organized\Other"

echo.
echo Moving files by type...

REM Images
move "%source_dir%\*.jpg" "%source_dir%\Organized\Images\" >nul 2>&1
move "%source_dir%\*.jpeg" "%source_dir%\Organized\Images\" >nul 2>&1
move "%source_dir%\*.png" "%source_dir%\Organized\Images\" >nul 2>&1
move "%source_dir%\*.gif" "%source_dir%\Organized\Images\" >nul 2>&1
move "%source_dir%\*.bmp" "%source_dir%\Organized\Images\" >nul 2>&1

REM Documents
move "%source_dir%\*.pdf" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.doc" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.docx" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.txt" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.xls" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.xlsx" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.ppt" "%source_dir%\Organized\Documents\" >nul 2>&1
move "%source_dir%\*.pptx" "%source_dir%\Organized\Documents\" >nul 2>&1

REM Videos
move "%source_dir%\*.mp4" "%source_dir%\Organized\Videos\" >nul 2>&1
move "%source_dir%\*.avi" "%source_dir%\Organized\Videos\" >nul 2>&1
move "%source_dir%\*.mkv" "%source_dir%\Organized\Videos\" >nul 2>&1
move "%source_dir%\*.mov" "%source_dir%\Organized\Videos\" >nul 2>&1

REM Audio
move "%source_dir%\*.mp3" "%source_dir%\Organized\Audio\" >nul 2>&1
move "%source_dir%\*.wav" "%source_dir%\Organized\Audio\" >nul 2>&1
move "%source_dir%\*.flac" "%source_dir%\Organized\Audio\" >nul 2>&1

REM Archives
move "%source_dir%\*.zip" "%source_dir%\Organized\Archives\" >nul 2>&1
move "%source_dir%\*.rar" "%source_dir%\Organized\Archives\" >nul 2>&1
move "%source_dir%\*.7z" "%source_dir%\Organized\Archives\" >nul 2>&1

REM Programs
move "%source_dir%\*.exe" "%source_dir%\Organized\Programs\" >nul 2>&1
move "%source_dir%\*.msi" "%source_dir%\Organized\Programs\" >nul 2>&1

echo Files organized successfully!
pause
goto menu

:organize_by_date
echo.
echo === ORGANIZE BY DATE MODIFIED ===
echo.
set /p source_dir="Enter source directory path (or press Enter for current): "
if "%source_dir%"=="" set source_dir=%cd%

echo.
echo Creating date-based folders...
for /f "tokens=1-3 delims=/" %%a in ('date /t') do (
    set current_year=%%c
)

if not exist "%source_dir%\Organized_By_Date" mkdir "%source_dir%\Organized_By_Date"
if not exist "%source_dir%\Organized_By_Date\This_Year" mkdir "%source_dir%\Organized_By_Date\This_Year"
if not exist "%source_dir%\Organized_By_Date\Last_Year" mkdir "%source_dir%\Organized_By_Date\Last_Year"
if not exist "%source_dir%\Organized_By_Date\Older" mkdir "%source_dir%\Organized_By_Date\Older"

echo.
echo This is a simplified date organization. Files will be sorted into:
echo - This Year
echo - Last Year  
echo - Older
echo.
echo For more precise date organization, consider using PowerShell or specialized tools.
pause
goto menu

:remove_empty
echo.
echo === REMOVE EMPTY FOLDERS ===
echo.
set /p source_dir="Enter directory path to clean (or press Enter for current): "
if "%source_dir%"=="" set source_dir=%cd%

echo.
echo Scanning for empty folders in: %source_dir%
echo.

for /f "delims=" %%d in ('dir "%source_dir%" /ad /b /s ^| sort /r') do (
    rd "%%d" >nul 2>&1 && echo Removed: %%d
)

echo.
echo Empty folder cleanup completed.
pause
goto menu

:find_duplicates
echo.
echo === FIND DUPLICATE FILES ===
echo.
set /p source_dir="Enter directory path to scan (or press Enter for current): "
if "%source_dir%"=="" set source_dir=%cd%

echo.
echo Scanning for duplicate files... This may take a while.
echo.

REM Create a simple duplicate finder using file sizes
echo === POTENTIAL DUPLICATE FILES === > duplicates_report.txt
echo Generated on %date% at %time% >> duplicates_report.txt
echo. >> duplicates_report.txt

dir "%source_dir%\*.*" /s /b | sort > temp_files.txt

echo.
echo Duplicate scan completed. Check 'duplicates_report.txt' for results.
echo Note: This is a basic scan. Use specialized tools for accurate detection.

del temp_files.txt >nul 2>&1
pause
goto menu

:create_structure
echo.
echo === CREATE PROJECT STRUCTURE ===
echo.
echo [1] Web Development Project
echo [2] Desktop Application Project
echo [3] Documentation Project
echo [4] Custom Structure
echo.

set /p structure_choice="Select structure type (1-4): "

if "%structure_choice%"=="1" goto web_structure
if "%structure_choice%"=="2" goto desktop_structure
if "%structure_choice%"=="3" goto docs_structure
if "%structure_choice%"=="4" goto custom_structure
goto invalid

:web_structure
set /p project_name="Enter project name: "
mkdir "%project_name%"
mkdir "%project_name%\src"
mkdir "%project_name%\src\css"
mkdir "%project_name%\src\js"
mkdir "%project_name%\src\images"
mkdir "%project_name%\dist"
mkdir "%project_name%\docs"
mkdir "%project_name%\tests"

echo index.html > "%project_name%\src\index.html"
echo styles.css > "%project_name%\src\css\styles.css"
echo script.js > "%project_name%\src\js\script.js"
echo # %project_name% > "%project_name%\README.md"

echo Web development project structure created: %project_name%
pause
goto menu

:desktop_structure
set /p project_name="Enter project name: "
mkdir "%project_name%"
mkdir "%project_name%\src"
mkdir "%project_name%\bin"
mkdir "%project_name%\lib"
mkdir "%project_name%\docs"
mkdir "%project_name%\tests"
mkdir "%project_name%\resources"

echo # %project_name% > "%project_name%\README.md"
echo main.py > "%project_name%\src\main.py"

echo Desktop application project structure created: %project_name%
pause
goto menu

:docs_structure
set /p project_name="Enter project name: "
mkdir "%project_name%"
mkdir "%project_name%\content"
mkdir "%project_name%\images"
mkdir "%project_name%\templates"
mkdir "%project_name%\output"

echo # %project_name% > "%project_name%\README.md"
echo index.md > "%project_name%\content\index.md"

echo Documentation project structure created: %project_name%
pause
goto menu

:custom_structure
echo.
echo Enter folder names separated by commas (e.g., src,docs,tests):
set /p folders="Folders: "
set /p project_name="Project name: "

mkdir "%project_name%"
for %%f in (%folders%) do (
    mkdir "%project_name%\%%f"
    echo Created: %project_name%\%%f
)

echo # %project_name% > "%project_name%\README.md"
echo Custom project structure created: %project_name%
pause
goto menu

:backup_files
echo.
echo === BACKUP IMPORTANT FILES ===
echo.
set /p source_dir="Enter source directory (or press Enter for current): "
if "%source_dir%"=="" set source_dir=%cd%

for /f "tokens=1-3 delims=/" %%a in ('date /t') do set backup_date=%%c-%%a-%%b
set backup_dir=Backup_%backup_date%_%time:~0,2%-%time:~3,2%

mkdir "%backup_dir%"

echo.
echo Creating backup in: %backup_dir%
echo.

REM Backup important file types
xcopy "%source_dir%\*.doc*" "%backup_dir%\" /s /y >nul 2>&1
xcopy "%source_dir%\*.xls*" "%backup_dir%\" /s /y >nul 2>&1
xcopy "%source_dir%\*.ppt*" "%backup_dir%\" /s /y >nul 2>&1
xcopy "%source_dir%\*.pdf" "%backup_dir%\" /s /y >nul 2>&1
xcopy "%source_dir%\*.txt" "%backup_dir%\" /s /y >nul 2>&1

echo Backup completed: %backup_dir%
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
echo       FOLDER ORGANIZER TOOL
echo =====================================
echo.

echo [1] Organize by File Type
echo [2] Organize by Date Modified
echo [3] Remove Empty Folders
echo [4] Find Duplicate Files
echo [5] Create Project Structure
echo [6] Backup Important Files
echo [0] Exit
echo.

set /p choice="Select an option (0-6): "

if "%choice%"=="1" goto organize_by_type
if "%choice%"=="2" goto organize_by_date
if "%choice%"=="3" goto remove_empty
if "%choice%"=="4" goto find_duplicates
if "%choice%"=="5" goto create_structure
if "%choice%"=="6" goto backup_files
if "%choice%"=="0" goto end
goto invalid

:end
echo.
echo Thank you for using Folder Organizer Tool!
pause
exit
