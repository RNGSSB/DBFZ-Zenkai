::Broscar#4765
@echo off
setlocal enabledelayedexpansion
pushd "%~dp0"
title Quick BBS - Build and pack

::Has to match the directory where your modified BBS files are stored
set mod_name=ZMOD
::Set to 1 to launch the game once the script has completed a cycle
set /p launch_game= Launch Game (0/1):

set /p pak= Pak or not (0/1):

:init
for /f "tokens=* delims=@" %%a in ('type "%~f0"') do set dbfz_directory=%%a
if "%dbfz_directory%"=="0" (
call:get_directory
exit /b 0
)
if not exist DBFZ_no-eac.lnk call:create_shortcut

:main
echo.DBFZ directory:
echo.[ %dbfz_directory% ]
echo.Packing the following mod:
echo.[ %mod_name% ]
echo.
echo.Converting to dbzscript...
for /r %%a in (!mod_name!\*.bbs) do call:convert_to_dbzscript "%%a"
echo.
echo.Injecting into uasset/uexp...
for /r %%a in (!mod_name!\dbzscript\*.dbzscript) do call:inject_dbzscript "%%a"
echo.
if "%pak%"=="1" {
echo.Copying to u4pak...
for /r %%a in (!mod_name!\uasset_uexp\*.uexp) do call:copy_u4pak "%%a"
for /r %%a in (!mod_name!\uasset_uexp\*.uasset) do call:copy_u4pak "%%a"
}

if "%pak%"=="0" {
echo.Copying to DBFZ Chara Folder...
for /r %%a in (!mod_name!\uasset_uexp\*.uexp) do call:copy_dbfzloose "%%a"
for /r %%a in (!mod_name!\uasset_uexp\*.uasset) do call:copy_dbfzloose "%%a"
echo
}

if "%pak%"=="1" {
echo.Packing assets...
echo.pack > .\u4pak\config.u4pak
echo.--version=3 >> .\u4pak\config.u4pak
echo.--mount-point=../../.. >> .\u4pak\config.u4pak
echo. >> .\u4pak\config.u4pak
echo."!mod_name!.pak" >> .\u4pak\config.u4pak
echo.":none,rename=/RED:./mod/RED" >> .\u4pak\config.u4pak
ping 123.45.67.89 -n 1 -w 1000>nul
.\u4pak\u4pak.exe .\u4pak\config.u4pak
echo.
echo.Copying to DBFZ mods directory...
if not exist "!dbfz_directory!\RED\Content\Paks\~mods" md "!dbfz_directory!\RED\Content\Paks\~mods" > nul
xcopy .\u4pak\!mod_name!.pak "!dbfz_directory!\RED\Content\Paks\~mods\!mod_name!.pak"* /y | find /v "File(s) copied"
xcopy .\u4pak\sample.sig "!dbfz_directory!\RED\Content\Paks\~mods\!mod_name!.sig"* /y | find /v "File(s) copied"
}
echo.
echo.Done^^!
goto:exit

:convert_to_dbzscript
bbscript rebuild -o dbfz "%~1" "%~dp0!mod_name!\dbzscript\%~n1.dbzscript"
goto:eof

:inject_dbzscript
cli_bbs_unpack.exe inject "%~1" "%~dp0!mod_name!\uasset_uexp\%~n1.uexp" "%~dp0!mod_name!\uasset_uexp\%~n1.uasset" > nul
goto:eof

:copy_u4pak
set char=%~n1
set char=!char:~4,3!
if not exist .\u4pak\mod\Red\Content\Chara\!char! md .\u4pak\mod\Red\Content\Chara\!char!\Common\Data > nul
xcopy "%~1" ".\u4pak\mod\Red\Content\Chara\!char!\Common\Data" /y | find /v "File(s) copied"
set char=
goto:eof

:copy_dbfzloose
set char=%~n1
set char=!char:~4,3!
if not exist "!dbfz_directory!\Red\Content\Chara\!char!" md "!dbfz_directory!\Red\Content\Chara\!char!\Common\Data" > nul
xcopy "%~1" "!dbfz_directory!\Red\Content\Chara\!char!\Common\Data" /y | find /v "File(s) copied"
set char=
goto:eof

:get_directory
echo.Please drag and drop "DBFighterZ.exe" into this window.
echo.This is used to automatically copy the mod to the correct location.
echo.
echo.Easy way to find it: right-click DBFZ on Steam, then go to [Manage] ^> [Browse local files].
echo.
set /p dbfz_directory=Directory: 
call:set_directory %dbfz_directory%
if "%dbfz_directory%"=="" goto:get_directory
goto:eof

:set_directory
if not "%~nx1"=="DBFighterZ.exe" (
echo.
echo.That wasn't DBFighterZ.exe, was it?...
echo.
set dbfz_directory=
goto:eof
)
set dbfz_directory=%~dp1
set dbfz_directory=%dbfz_directory:~0,-1%
echo.
echo.[ %dbfz_directory% ]
echo.
echo.This location will be saved to bottom of [ %~nx0 ]
echo.You can change/remove it later with any text editor if you ever decide to move your DBFZ folder.
echo.
echo.Press any key to save ^& exit (or close the window to exit without saving).
pause>nul
echo.%dbfz_directory%>>"%~f0"
goto:eof

:create_shortcut
echo.Set oWS = WScript.CreateObject("WScript.Shell") >> shortcut.vbs
echo.sLinkFile = "RED-Win64-Shipping.exe_no-eac.lnk" >> shortcut.vbs
echo.Set oLink = oWS.CreateShortcut(sLinkFile) >> shortcut.vbs
echo.oLink.TargetPath = "!dbfz_directory!\RED\Binaries\Win64\RED-Win64-Shipping.exe" >> shortcut.vbs
echo.oLink.Arguments = "-eac-nop-loaded" >> shortcut.vbs
echo.oLink.WorkingDirectory = "!dbfz_directory!\RED\Binaries\Win64\" >> shortcut.vbs
echo.oLink.Save >> shortcut.vbs
cscript /nologo shortcut.vbs
del /q shortcut.vbs
goto:eof

:exit
if "%launch_game%"=="1" (
echo.[ %~nx0 ] is currently configured to start the game after each run.
echo.Launching the game without Easy Anti-Cheat right now^^!
echo.Note: You have to close the game before you restart the script, otherwise it can't update the packed mod.
echo.
start "" "RED-Win64-Shipping.exe_no-eac.lnk"
set launch_game = 0
)
echo.Press any key to restart this script, or close the window to exit.
pause>nul
cls
goto:main

@
0
C:\Program Files (x86)\Steam\steamapps\common\DRAGON BALL FighterZ
