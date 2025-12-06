@echo off
REM Smart incremental build using latexmk
REM This only rebuilds what has changed, not everything from scratch

echo Building with latexmk (incremental mode)...
latexmk -pdf -interaction=nonstopmode main.tex

if errorlevel 1 (
    echo.
    echo Build failed! Check main.log for errors.
    pause
    exit /b 1
) else (
    echo.
    echo Build successful!
    pause
)
