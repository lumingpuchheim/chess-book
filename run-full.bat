@echo off
REM Full clean build - rebuilds everything from scratch
REM Use this when you want to ensure everything is up to date

echo Cleaning previous build...
latexmk -C main.tex

echo Building from scratch...
latexmk -pdf -interaction=nonstopmode main.tex

if errorlevel 1 (
    echo.
    echo Build failed! Check main.log for errors.
    pause
    exit /b 1
) else (
    echo.
    echo Full build successful!
    pause
)


