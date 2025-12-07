@echo off
REM Full clean build - rebuilds everything from scratch
REM Use this when you want to ensure everything is up to date

cd /d "%~dp0"
echo Cleaning previous build...
cd main
latexmk -C main.tex
cd ..

echo Building from scratch...
cd main
latexmk -pdf -interaction=nonstopmode main.tex
cd ..

if errorlevel 1 (
    echo.
    echo Build failed! Check main/main.log for errors.
    pause
    exit /b 1
) else (
    echo.
    echo Full build successful!
    pause
)


