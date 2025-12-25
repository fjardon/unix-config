@echo off

rem We can configure the windows terminal to use MSYS2 using the
rem `bshell.bat` script:
rem 
rem ----
rem cmd.exe /k "bshell.bat --ucrt64"
rem ----

set arg=%1

if "%arg%" == "--help" goto:argHelp
if "%arg%" == "-h" goto:argHelp
if "%arg%" == "" goto:argHelp
if "%arg%" == "--git-bash" goto:runGitBash
if "%arg%" == "--ucrt64" goto:runUcrt64
goto:unknownArg

:runGitBash
"%PROGRAMFILES%\Git\bin\bash.exe" -l -i
goto:end

:runUcrt64
set MSYSTEM=UCRT64
set MSYS2_PATH_TYPE=inherit
"C:\msys64\usr\bin\bash" -l -i
goto:end

:printHelp
echo Usage:
echo     %~1 -h^|--help
echo     %~1 --git-bash^|--ucrt64
goto:eof

:unknownArg
call:printHelp %0
set errorlevel=1
goto:end

:argHelp
call:printHelp %0
goto:end

:end

