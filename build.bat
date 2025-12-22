@echo off
REM ================================================================
REM Generic LaTeX book build script
REM
REM Usage (from this folder):
REM   build myChessNotebook
REM   build myChessNotebook false
REM   build Endgame
REM   build Endgame false
REM
REM  - First argument  : book name = folder name = main .tex basename
REM                      (e.g. myChessNotebook -> myChessNotebook\myChessNotebook.tex)
REM  - Second argument : optional, "false" to build the *-lite* variant
REM                      that defines \nobuildall and skips heavy chapters.
REM ================================================================

setlocal

if "%~1"=="" (
    echo Usage: build BOOKNAME [true^|false]
    echo Example: build myChessNotebook
    echo          build myChessNotebook false
    exit /b 1
)

set "BOOK=%~1"
set "BUILDALL=%~2"
if "%BUILDALL%"=="" set "BUILDALL=true"

REM Move to the directory where this script lives
cd /d "%~dp0"

REM ----------------------------------------------------------------
REM Derive main file and jobname
REM ----------------------------------------------------------------
if /I "%BUILDALL%"=="false" (
    set "JOB=%BOOK%-lite"
    set "MAIN=%BOOK%-lite.tex"
) else (
    set "JOB=%BOOK%"
    set "MAIN=%BOOK%.tex"
)

REM ----------------------------------------------------------------
REM Clean previous build artifacts for this book
REM ----------------------------------------------------------------
if not exist "%BOOK%\%MAIN%" (
    echo ERROR: Expected main file "%BOOK%\%MAIN%" not found.
    echo Make sure the folder and .tex file exist and match the BOOK name.
    exit /b 1
)

echo Cleaning previous build for %JOB%...
cd "%BOOK%"
latexmk -C "%BOOK%.tex" >nul 2>&1
if exist "%BOOK%-lite.tex" (
    latexmk -C "%BOOK%-lite.tex" >nul 2>&1
)

REM ----------------------------------------------------------------
REM Build passes: pdflatex, biber, makeindex, makeglossaries, pdflatex x3
REM ----------------------------------------------------------------
echo.
echo Building %JOB%...

echo Running pdflatex (first pass)...
pdflatex -interaction=nonstopmode -jobname="%JOB%" "%MAIN%"

echo Running biber for bibliography (if needed)...
if exist "%JOB%.bcf" (
    biber "%JOB%"
) else (
    echo   No .bcf file found for %JOB%, skipping biber...
)

echo Running makeindex for index (if needed)...
if exist "%JOB%.idx" (
    makeindex -s "..\indexstyle.ist" "%JOB%.idx"
) else (
    echo   No .idx file found for %JOB%, skipping makeindex...
)

echo Running makeglossaries for glossary (if needed)...
if exist "%JOB%.glo" (
    makeglossaries "%JOB%"
) else (
    echo   No .glo file found for %JOB%, skipping makeglossaries...
)

echo Running pdflatex (second pass)...
pdflatex -interaction=nonstopmode -jobname="%JOB%" "%MAIN%"

echo Running pdflatex (third pass to resolve references)...
pdflatex -interaction=nonstopmode -jobname="%JOB%" "%MAIN%"

echo Running pdflatex (fourth pass to fully resolve glossary/index)...
pdflatex -interaction=nonstopmode -jobname="%JOB%" "%MAIN%"

cd ..

if errorlevel 1 (
    echo.
    echo Build failed! Check "%BOOK%\%JOB%.log" for errors.
    pause
    exit /b 1
) else (
    echo.
    echo Build of %JOB% successful!
    pause
)


