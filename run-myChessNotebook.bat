@echo off
REM Smart incremental build using latexmk
REM Usage:
REM   run-myChessNotebook.bat          -> build all content (default)
REM   run-myChessNotebook.bat false    -> skip heavy chapters (ideas/games/annotations)

setlocal
set "buildAll=%~1"
if "%buildAll%"=="" set "buildAll=true"

cd /d "%~dp0"
echo Building myChessNotebook with latexmk (incremental mode)...
cd myChessNotebook

if /I "%buildAll%"=="false" (
    echo   Skipping heavy chapters ^(ideas/games/annotations^)...
    latexmk -pdf -interaction=nonstopmode -jobname=myChessNotebook myChessNotebook-lite.tex
) else (
    latexmk -pdf -interaction=nonstopmode myChessNotebook.tex
)

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