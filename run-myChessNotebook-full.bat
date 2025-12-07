@echo off
REM Full clean build - rebuilds everything from scratch
REM Use this when you want to ensure everything is up to date

cd /d "%~dp0"
echo Cleaning previous build...
cd myChessNotebook
latexmk -C myChessNotebook.tex
cd ..

echo Building from scratch...
cd myChessNotebook
latexmk -pdf -interaction=nonstopmode myChessNotebook.tex
cd ..

if errorlevel 1 (
    echo.
    echo Build failed! Check myChessNotebook/myChessNotebook.log for errors.
    pause
    exit /b 1
) else (
    echo.
    echo Full build successful!
    pause
)

