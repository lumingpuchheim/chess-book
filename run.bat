@echo off
REM Smart incremental build using latexmk
REM This only rebuilds what has changed, not everything from scratch

cd /d "%~dp0"
echo Building with latexmk (incremental mode)...
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
    echo Build successful!
    pause
)
