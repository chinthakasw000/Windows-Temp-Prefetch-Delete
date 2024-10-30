@echo off
:: Request admin permissions
:checkPrivileges
net session >nul 2>&1
if %errorLevel% == 0 (
    goto admin
) else (
    echo Requesting administrative privileges...
    powershell -Command "Start-Process cmd -ArgumentList '/c %~s0' -Verb RunAs"
    exit
)

:admin
:: Delete all files in the specified directories
echo Deleting files in C:\Windows\Prefetch
del /q /f C:\Windows\Prefetch\*
echo Deleting files in C:\Windows\Temp
del /q /f C:\Windows\Temp\*
echo Deleting files in C:\Users\chint\AppData\Local\Temp
del /q /f C:\Users\chint\AppData\Local\Temp\*

:: Remove empty directories
echo Removing empty directories in C:\Windows\Prefetch
for /d %%i in (C:\Windows\Prefetch\*) do rmdir /s /q "%%i"
echo Removing empty directories in C:\Windows\Temp
for /d %%i in (C:\Windows\Temp\*) do rmdir /s /q "%%i"
echo Removing empty directories in C:\Users\chint\AppData\Local\Temp
for /d %%i in (C:\Users\chint\AppData\Local\Temp\*) do rmdir /s /q "%%i"

echo Done.
pause
