@echo off
:: Check if the script is being run as administrator
openfiles >nul 2>&1
if '%errorlevel%' NEQ '0' (
    echo Requesting administrator permissions...
    powershell -Command "Start-Process '%~f0' -Verb RunAs"
    exit /b
)

:: Delete files from the %temp% folder
echo Cleaning files from the TEMP folder...
for /r %temp% %%x in (*) do (
    del /f /s /q "%%x" >nul 2>&1
)

:: Delete files from the Prefetch folder
echo Cleaning files from the Prefetch folder...
if exist C:\Windows\Prefetch\ (
    for /r C:\Windows\Prefetch\ %%x in (*) do (
        del /f /s /q "%%x" >nul 2>&1
    )
) else (
    echo The Prefetch folder was not found.
)

:: Delete files from the Windows temporary logs folder
echo Cleaning files from the Windows Logs folder...
if exist C:\Windows\Temp\ (
    for /r C:\Windows\Temp\ %%x in (*) do (
        del /f /s /q "%%x" >nul 2>&1
    )
) else (
    echo The C:\Windows\Temp folder was not found.
)

:: Delete files from the users' Temp folder
echo Cleaning temporary files for all users...
for /d %%x in (C:\Users\*) do (
    if exist "%%x\AppData\Local\Temp\" (
        for /r "%%x\AppData\Local\Temp\" %%y in (*) do (
            del /f /s /q "%%y" >nul 2>&1
        )
    ) else (
        echo The Temp folder was not found for user %%x
    )
)

echo Cleaning complete!
pause
