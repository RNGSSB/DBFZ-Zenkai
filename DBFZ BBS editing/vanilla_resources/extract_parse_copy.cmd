::Broscar#4765
@echo off
pushd "%~dp0"
title Quick BBS - Extract, parse, copy
setlocal enableDelayedExpansion

:init
set script_location=%~dp0
set script_location=%script_location:~0,-1%
for /d %%a in ("%script_location%") do set vanilla_location=%%~nxa
cd ..
if not exist pack_mod.cmd echo.Where is pack_mod.cmd? && goto:exit
for /f "tokens=2 delims==" %%a in ('type pack_mod.cmd ^| find /i "set mod_name="') do set mod_name=%%a
if not "%~1"=="" goto:copy_check

:main
echo.Unpacking game files...
for /r %%a in (.\!vanilla_location!\uasset_uexp\BBS_*.uexp) do call:unpack_dbzscript "%%a"
echo.
echo.Parsing...
for /r %%a in (.\!vanilla_location!\BBS_*.dbzscript) do call:parse_bbs "%%a"
echo.
goto:exit

:unpack_dbzscript
echo.%~n1.dbzscript
cli_bbs_unpack.exe extract "%~1" .\!vanilla_location!\%~n1.dbzscript
goto:eof

:parse_bbs
echo.%~n1.bbs
bbscript parse dbfz -o "%~1" ".\!vanilla_location!\%~n1".bbs
del /q "%~1"
goto:eof

:copy_check
if "%~1"=="" goto:exit
call:copy "%~1"
shift
goto:copy_check

:copy
if not exist "%~1" echo.Error^^! Not a file?&& goto:exit
if not "%~x1"==".bbs" echo.Error^^! Not a .bbs file?&& goto:exit
echo.Copying to !mod_name!...
if exist ".\!mod_name!\%~nx1" echo.Error^^! .bbs file already exists at location?&& goto:exit
xcopy "%~1" ".\!mod_name!" /y | find /v "File(s) copied"
xcopy ".\!vanilla_location!\uasset_uexp\%~n1.uasset" ".\!mod_name!\uasset_uexp" /y | find /v "File(s) copied"
xcopy ".\!vanilla_location!\uasset_uexp\%~n1.uexp" ".\!mod_name!\uasset_uexp" /y | find /v "File(s) copied"
echo.
goto:eof

:exit
echo.
echo.Press any key to exit.
pause>nul
exit /b 0