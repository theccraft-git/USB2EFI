@echo off
title USB2EFI
setlocal enabledelayedexpansion

:: --- VERSION CONFIG ---
set "version=v1.0.0-beta"

:MENU
set "efi_path="
set "utb_path="
cls
echo ===========================================================================
echo   USB2EFI - Automated OpenCore USB Patching [%version%]
echo   Developed by @theccraft-git
echo ===========================================================================
echo.
echo [1] START: Patch EFI Folder
echo [2] INFO: What does this do?
echo [3] EXIT
echo.
set /p choice="Select an option (1-3): "

if "%choice%"=="1" goto :GET_PATHS
if "%choice%"=="2" goto :INFO
if "%choice%"=="3" exit
goto :MENU

:INFO
cls
echo 1. Replaces 'UTBDefault.kext' with 'UTBMap.kext' inside config.plist.
echo 2. Changes Kext-Architecture to 'Any'.
echo 3. Deletes 'UTBDefault.kext' and copies your 'UTBMap.kext'.
echo.
pause
goto :MENU

:GET_PATHS
cls
echo ===========================================================================
echo PATH SELECTION
echo ===========================================================================
echo.
echo Please drag and drop your EFI folder here:
set /p "raw_efi="
if not defined raw_efi goto :GET_PATHS
set "efi_path=%raw_efi:"=%"

echo.
echo Please drag and drop your UTBMap.kext here:
set /p "raw_utb="
if not defined raw_utb goto :GET_PATHS
set "utb_path=%raw_utb:"=%"

:START_CHECK
if not exist "%efi_path%\OC\config.plist" (
    echo.
    echo [ERROR] Could not find config.plist at: 
    echo "%efi_path%\OC\config.plist"
    pause
    goto :MENU
)
if not exist "%utb_path%" (
    echo.
    echo [ERROR] Could not find UTBMap.kext at:
    echo "%utb_path%"
    pause
    goto :MENU
)

:PROCESS
cls
echo ===========================================================================
echo PATCHING IN PROGRESS...
echo ===========================================================================
echo.

echo [1/4] Patching config.plist (Replacing Names)...
powershell -Command "(Get-Content '%efi_path%\OC\config.plist') -replace 'UTBDefault.kext', 'UTBMap.kext' | Set-Content '%efi_path%\OC\config.plist' -Encoding UTF8"

echo [2/4] Patching config.plist (Fixing Architecture)...
powershell -Command "(Get-Content '%efi_path%\OC\config.plist') -replace '<string>x86_64</string>', '<string>Any</string>' | Set-Content '%efi_path%\OC\config.plist' -Encoding UTF8"

echo [3/4] Removing old UTBDefault.kext...
if exist "%efi_path%\OC\Kexts\UTBDefault.kext" (
    rd /s /q "%efi_path%\OC\Kexts\UTBDefault.kext"
)

echo [4/4] Importing new UTBMap.kext...
robocopy "%utb_path%" "%efi_path%\OC\Kexts\UTBMap.kext" /e /is /it /njs /njh /ndl /nc /ns >nul

echo.
echo ===========================================================================
echo SUCCESS: EFI IS NOW USB-READY
echo ===========================================================================
echo [OK] Config.plist updated.
echo [OK] Files moved successfully.
echo.
echo Press enter to return to menu.
pause >nul
goto :MENU