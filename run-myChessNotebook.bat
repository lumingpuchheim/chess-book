@echo off
REM Smart incremental build using latexmk
REM This only rebuilds what has changed, not everything from scratch
REM latexmk automatically handles biber and makeindex when needed

cd /d "%~dp0"
echo Building myChessNotebook with latexmk (incremental mode)...
cd myChessNotebook
latexmk -pdf -interaction=nonstopmode myChessNotebook.tex
cd ..

if errorlevel 1 (
    echo.
    echo Build failed! Check myChessNotebook/myChessNotebook.log for errors.
    echo.
    echo If citations are still undefined, try running run-myChessNotebook-full.bat
    pause
    exit /b 1
) else (
    echo.
    echo Build successful!
    pause
)

