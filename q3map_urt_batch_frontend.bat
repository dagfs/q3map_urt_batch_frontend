@echo off
title Batch Compiler - Working on: %~n1
color

:Start
cls

rem Get paths
rem complie lines
set __BSP=-v -meta -scale 2.0
set __VIS=-v -vis -fast
set __LIGHT=-v -light -fast

rem bot compile
set __ASS=-meta

rem paths
set __BasePath=C:\mapping\

set __FSGame=q3ut4
set __GameEXE=Quake3-UrT.exe
set __CompilerPath=q3map_2.5.16_win32_x86\q3map2.exe
set __BPSPath=compile\sfs\bsp.exe

cd %__BasePath%


:MainMenu
cls

echo 0. Refresh
echo 1. Test Compile
echo 2. Devmap
echo 3. Compile
echo 4. Surface Sound
echo 5. bots
echo 6. Autoscript
echo 7. Convert
echo 8. Settings
echo 9. Exit


CHOICE /C 0123456789 /N /M "Choose a option."


if errorlevel 10 goto :Exit
if errorlevel 9 goto :Settings
if errorlevel 8 goto :Convert
if errorlevel 7 goto :AS
if errorlevel 6 goto :BOT
if errorlevel 5 goto :SFS
if errorlevel 4 goto :Compile
if errorlevel 3 goto :Devmap
if errorlevel 2 goto :TestCompile
if errorlevel 1 goto :Start

goto :MainMenu



:TestCompile
cls

time /T
echo STARTING BSP:
start /low /B /wait %__BasePath%%__CompilerPath% -v -meta -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.map"

time /T
echo STARTING VIS:
start /low /B /wait %__BasePath%%__CompilerPath% -v -vis -fast -fs_basepath %__basePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

time /T
echo STARTING RAD:
start /low /B /wait %__BasePath%%__CompilerPath% -v -light -fast -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

pause

goto :MainMenu



:Devmap
start %__basepath%%__GameEXE% +sv_pure 0 +r_gamma 1 +devmap %~n1
pause
goto :MainMenu



:Compile

time /T
echo STARTING BSP:
start /low /B /wait %__BasePath%%__CompilerPath% %__BSP% -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.map"

time /T
echo STARTING VIS:
start /low /B /wait %__BasePath%%__CompilerPath% %__VIS% -fs_basepath %__basePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

time /T
echo STARTING RAD:
start /low /B /wait %__BasePath%%__CompilerPath% %__LIGHT% -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

pause
goto :MainMenu



:SFS
   
start "Making .surface file" /B /wait %__BasePath%%__BPSPath% -se %~d1%~p1%~n1.bsp %~d1%~p1%~n1.surface
start "Opening surface sounds" /B compile/sfs/surfacesounds.surface "C:\Program Files (x86)\Windows NT\Accessories\wordpad.exe"                                       rem C:\Program Files (x86)\Windows NT\Accessories\
Start "Editing . surface file" /B /wait %~d1%~p1%~n1.surface "C:\Program Files (x86)\Windows NT\Accessories\wordpad.exe"                                  rem C:\Program Files (x86)\Windows NT\Accessories\
start "Applying .surface file to .bsp" /B /wait %__BasePath%%__BPSPath% -si %~d1%~p1%~n1.bsp %~d1%~p1%~n1.surface

pause
goto :MainMenu



:BOT
echo not done yet
pause
goto :MainMenu



:AS
echo not done yet
pause
goto :MainMenu



:Convert
cls

echo 0. map to ase
echo 1. bsp to ase
echo 2. bsp to map
echo 3. Main Menu


CHOICE /C 0123 /N /M "Choose a option."

if errorlevel 4 goto :MainMenu
if errorlevel 3 goto :Convert_bsp_map
if errorlevel 2 goto :Convert_bsp_ase
if errorlevel 1 goto :Convert_map_ase

goto :MainMenu



:Convert_map_ase
start /low /B /wait %__BasePath%%__CompilerPath% -v -meta -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.map"
start /low /B /wait %__BasePath%%__CompilerPath% -convert -format ase -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

goto :MainMenu



:Convert_bsp_ase
start /low /B /wait %__BasePath%%__CompilerPath% -convert -format ase -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

goto :MainMenu

:Convert_bsp_map
start /low /B /wait %__BasePath%%__CompilerPath% -convert -format map -fs_basepath %__BasePath% -fs_game %__FSGame% "%~d1%~p1%~n1.bsp"

goto :MainMenu



:Settings

pause
goto :MainMenu



:Exit
exit