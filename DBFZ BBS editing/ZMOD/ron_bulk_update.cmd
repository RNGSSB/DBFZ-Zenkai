::Broscar#4765
@echo off
pushd "%~dp0"
title Quick BBS - dbfz.ron bulk update

:init
set script_location=%~dp0
set script_location=%script_location:~0,-1%
for /d %%a in ("%script_location%") do set mod_name=%%~nxa
setlocal enabledelayedexpansion
cd ..

:main
echo.This script is used to transition your custom .bbs scripts to a new dbfz.ron
echo.If you're not updating your .ron, just close this window and enjoy the rest of your day.
echo.
echo.
echo.Step 1: If you've made any changes to your .bbs scripts that haven't been packed yet, run [ pack_mod.cmd ] once.
echo.Step 2: Copy the new dbfz.ron to [ static_db ]
echo.Step 3: Enter "yes" to start the process of updating your .bbs files.
echo.
echo.Note: This script will overwrite all .bbs files in this directory.
echo.
echo.Current .bbs scripts in this directory:
for /f "tokens=* delims= " %%a in ('dir /b ".\!mod_name!" ^| find /i ".bbs"') do set bbslist=%%a !bbslist!
echo.%bbslist%
echo.
echo.Are you sure you want to continue?
set /p confirm=[yes/no]: 
if not "%confirm%"=="yes" goto:exit
echo.Press any key to start.
pause>nul
goto:parse

:parse
echo.
echo.Parsing .dbzscript and writing new .bbs files...
for /r %%a in (.\!mod_name!\dbzscript\BBS_*.dbzscript) do call:process "%%a"
goto:exit

:process
echo..\%~n1.bbs
bbscript parse dbfz -o "%~1" ".\!mod_name!\%~n1.bbs"
goto:eof

:get_mod_name
if "%1"=="" goto:eof
set mod_name=%1
shift
goto:get_mod_name

:exit
echo.
echo.Press any key to exit.
pause>nul
exit /b 0