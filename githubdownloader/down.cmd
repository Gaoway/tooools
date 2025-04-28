@echo off
setlocal enabledelayedexpansion

:: Set default download location (modify as needed)
set "DEFAULT_LOCATION=C:\Users\gw\Documents\gitdown"

:: Verify and create default directory
if not exist "%DEFAULT_LOCATION%" mkdir "%DEFAULT_LOCATION%"

:: Get user input for target game ID
set /p "branch=Please input the target game ID from Steam (e.g.: 1551360): "

:: Set repository name (fixed for this use case)
set "repo=ManifestHub"

:: Construct download URL
set "download_url=https://github.com/SteamAutoCracks/ManifestHub/archive/refs/heads/%branch%.tar.gz"

:: Set output directory
set "output_dir=%DEFAULT_LOCATION%\%branch%"

:: Download the branch
echo Downloading branch %branch% from %repo% repository...
curl -L -o "%DEFAULT_LOCATION%\%branch%.tar.gz" "%download_url%"

if %errorlevel% neq 0 (
    echo Download failed
    pause
    exit /b 1
)

echo Download complete, extracting files...

:: Create output directory
if not exist "%output_dir%" mkdir "%output_dir%"

:: Extract files
tar -xzf "%DEFAULT_LOCATION%\%branch%.tar.gz" -C "%output_dir%" --strip-components=1

if %errorlevel% neq 0 (
    echo Extraction failed
    pause
    exit /b 1
)

:: Clean up temporary archive
del "%DEFAULT_LOCATION%\%branch%.tar.gz"

echo Files successfully downloaded and extracted to: %output_dir%
pause