@echo off
TITLE Safe Driver Installer Tool by UseUr
cls
echo 1. Set TESTSIGNING ON (for Installing Lan driver)
echo 2. Set TESTSIGNING OFF (After installation)
echo 3. Restart
echo.

CHOICE /C 123 /M "Enter your Choice:"

::Command numbers go from highest to lowest....

IF ERRORLEVEL 3 GOTO Restart
IF ERRORLEVEL 2 GOTO Off
IF ERRORLEVEL 1 GOTO On

:On
bcdedit /set TESTSIGNING ON
timeout /t 1
goto Restart

:Off
bcdedit /set TESTSIGNING OFF
timeout /t 1
goto Restart

:Restart
shutdown /r /t 0