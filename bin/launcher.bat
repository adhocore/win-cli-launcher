@echo off
rem
rem A tool for windows OS to make launcher of anything
rem The launcher will have a name that can be run in cli
rem author Jitendra Adhikari <jiten.adhikary@gmail.com>
rem

rem The wrapper and shortcuts are placed in binpath.
rem Make sure the binpath is in PATH env
rem You can set the binpath below (no trailing spaces):
set binpath=C:\bin

rem Donot change anything below.

rem Validate binpath
if not exist "%binpath%" (
	echo The binpath %binpath% doesnot exist.
	echo Please create the path %binpath% and try again.
	goto END
)

rem Add self to binpath
if not exist "%binpath%\launcher.bat" (
	copy "%~f0" "%binpath%\launcher.bat"
)

rem Add binpath to env autoload path
if not exist "%binpath%\.launcher.init" (
	for /f "usebackq tokens=2,*" %%A in (`reg query HKCU\Environment /v PATH`) do (
		setx PATH "%binpath%;%%B"
		goto INSTALLED
	)	
	setx PATH "%binpath%"
	goto INSTALLED
)

rem Show help if no args given
if "%~1" == "" goto SHOWHELP

rem Validate first arg: targetFile
if not exist "%~1" (
	echo The targetFile "%~1" doesnot exist.
	goto END
)
set target=%~1

rem check second arg: alias
if NOT "%~2" == "" (
	set alias=%~2
	goto CHECKALIAS	
)

rem set default alias if second arg empty
if "%~2" == "" (
	set alias=%~n1
	goto CHECKALIAS
)

:CHECKALIAS
rem validate alias
set alias=%alias: =%
if exist "%binpath%\%alias%.bat" (
	echo The targetName %alias% already exist.
	goto END
)

rem  Add a .bat to wrap around the targetFile
echo @echo off > "%binpath%\%alias%.bat"
echo start "" "%target%" %%* >> "%binpath%\%alias%.bat"
if not exist "%binpath%\%alias%.bat" (
	echo Couldnot create launcher
	goto END
)
echo .
echo Command: %alias%
echo Target:  %target%
echo .
goto END 

:INSTALLED	
echo .
echo . > "%binpath%\.launcher.init"
echo The path %binpath% has been added to PATH
echo Relaunch command terminal to start using launcher
echo .
pause
exit

:SHOWHELP
echo Usage:
echo launcher targetFile alias
echo   targetFile The fullpath of file to be invoked via command
echo   alias      The command that will invoke targetFile
echo              [Optional, defaults to name of targetFile]
echo .

:END
rem cleanup vars
set newpath=
set binpath=
set target=
set alias=
