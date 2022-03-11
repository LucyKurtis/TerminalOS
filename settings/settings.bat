@echo off
SETLOCAL EnableDelayedExpansion
for /F "tokens=1,2 delims=#" %%a in ('"prompt #$H#$E# & echo on & for %%b in (1) do     rem"') do (
  set "DEL=%%a"
)
:main
cls
color 3e
type Resources\\settings.txt
echo.
echo.
ping localhost -n 1.9 >nul
echo  Quick System Settings:
echo.
echo  1 - Change your computers RGB LED lighting colors (if availible) 
ping localhost -n 1.9 >nul
echo  2 - Change Power Mode (Most likely will not actually work, even if it says it is. I'm working on a fix dont worry)
ping localhost -n 1.9 >nul
echo.
echo  TerminalOS Settings:
echo.
ping localhost -n 1.9 >nul
echo  3 - Change Password
ping localhost -n 1.9 >nul
echo  4 - Toggle Start Fullscreen
ping localhost -n 1.9 >nul
echo.
echo  m - Return to Main Menu
ping localhost -n 1.9 >nul
echo.
set /p cmd= Listening ^> 
if "%cmd%"=="1" goto colors
if "%cmd%"=="2" goto power
if "%cmd%"=="3" goto resetpass
if "%cmd%"=="4" goto setfullsc
if "%cmd%"=="m" goto close
if not "%cmd%"=="1"/"2"/"3"/"4"/"m"/stop goto main
:colors
cls
call settings\rgb.bat
goto Main
:power
ping localhost -n 1.9 >nul
cls
color 3e
type Resources\\settings.txt
echo.
ping localhost -n 1.9 >nul
echo  Which power mode would you like?
echo. 
ping localhost -n 1.9 >nul
echo  Installed power modes:
echo.
ping localhost -n 1.9 >nul
call :ColorText 39 " 1 - Low Power"
ping localhost -n 1.9 >nul
call :ColorText 3c " 2 - High Power"
ping localhost -n 1.9 >nul
echo.
echo  m - Return to Settings Menu
echo.
ping localhost -n 1.9 >nul
set /p pwr= Listening ^> 
if "%pwr%"=="1" goto lowpwr
if "%pwr%"=="2" goto hipwr
if "%pwr%"=="m" goto Main
if not "%pwr%"=="1"/"2"/"m"/stop goto power
:setfullsc
cls
color 3e
type Resources\settings.txt
ping localhost -n 1.9 >nul
echo.
echo  Set fullscreen setting:
ping localhost -n 1.9 >nul
echo.
echo  1 - Start Fullscreen Enabled
ping localhost -n 1.9 >nul
echo  2 - Start Fullscreen Disabled
echo.
ping localhost -n 1.9 >nul
echo  m - Return to Settings Menu
echo.
ping localhost -n 1.9 >nul
attrib -h fullscreen.txt
echo.> fullscreen.txt
set /p fsc= Listening ^> 
if "%fsc%"=="m" goto main
if "%fsc%"=="1" goto setfsc
if "%fsc%"=="2" goto setfsc
if not "%fsc%"=="1"/"2"/"m"stop goto setfullsc
:setfsc
>tfullscreen.txt echo %fsc%
findstr /v "^$" tfullscreen.txt > fullscreen.txt
del tfullscreen.txt
attrib +h fullscreen.txt
goto main
:lowpwr
ping localhost -n 1.9 >nul
cls
color 3e
type Resources\\settings.txt
echo.
ping localhost -n 1.9 >nul
echo  Setting power state to Low...
echo.
powercfg /setactive a1841308-3541-4fab-bc81-f71556f20b4a
ping localhost -n 2 >nul
echo  Limiting CPU Frequency...
echo.
ping localhost -n 2 >nul
echo  Success
ping localhost -n 2 >nul
goto main
:hipwr
cls
color 3e
type Resources\\settings.txt
echo.
ping localhost -n 1.9 >nul
echo  Setting power state to High...
echo.
powercfg /setactive 8851a545-78ca-41b6-9828-b69a4bd9a3d8
ping localhost -n 2 >nul
echo  Turning up CPU Frequency...
echo.
ping localhost -n 2 >nul
echo  Success
ping localhost -n 2 >nul
goto main
:resetpass
cls
color 0e
type Resources\logo.txt
echo.
attrib -h password.txt
attrib -h null.txt
ping localhost -n 1.9 >nul
echo.> password.txt
echo.> null.txt
set /p cpass= Please enter your new password ^> 
echo | set /p =%cpass%>> tpassword.txt <NUL
findstr /v "^$" tpassword.txt > password.txt
del tpassword.txt
attrib +h password.txt
attrib +h null.txt
cls
color 0a
type Resources\logo.txt
echo.
echo Please enter your new password ^> 
echo.
echo  -- New Password Saved --
ping localhost -n 3 >nul
goto restart
:restart
call functions\restart.bat
:close
cls
exit /b
:ColorText
echo off
echo %DEL% > "%~2"
findstr /v /a:%1 /R "^$" "%~2" nul
del "%~2" > nul 2>&1
goto :eof