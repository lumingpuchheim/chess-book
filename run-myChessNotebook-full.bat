@echo off
REM Full clean build - rebuilds everything from scratch
REM Use this when you want to ensure everything is up to date
REM
REM Usage:
REM   run-myChessNotebook-full.bat          -> build all content (default)
REM   run-myChessNotebook-full.bat false    -> skip heavy chapters (ideas/games/annotations)

setlocal
set "buildAll=%~1"
if "%buildAll%"=="" set "buildAll=true"

cd /d "%~dp0"
echo Cleaning previous build...
cd myChessNotebook
latexmk -C myChessNotebook.tex
cd ..

echo Building from scratch...
cd myChessNotebook

echo Running pdflatex (first pass)...
if /I "%buildAll%"=="false" (
    echo   Skipping heavy chapters ^(ideas/games/annotations^) in this full build...
    pdflatex -interaction=nonstopmode -jobname=myChessNotebook-lite myChessNotebook-lite.tex
) else (
    pdflatex -interaction=nonstopmode myChessNotebook.tex
)

echo Running biber for bibliography...
if /I "%buildAll%"=="false" (
    biber myChessNotebook-lite
) else (
    biber myChessNotebook
)

echo Running makeindex for index...
if /I "%buildAll%"=="false" (
    if exist myChessNotebook-lite.idx (
        makeindex -s ../indexstyle.ist myChessNotebook-lite.idx
    )
) else (
    if exist myChessNotebook.idx (
        makeindex -s ../indexstyle.ist myChessNotebook.idx
    )
)

echo Running pdflatex (second pass)...
if /I "%buildAll%"=="false" (
    pdflatex -interaction=nonstopmode -jobname=myChessNotebook-lite myChessNotebook-lite.tex
) else (
    pdflatex -interaction=nonstopmode myChessNotebook.tex
)

echo Running pdflatex (third pass to resolve all references)...
if /I "%buildAll%"=="false" (
    pdflatex -interaction=nonstopmode -jobname=myChessNotebook-lite myChessNotebook-lite.tex
) else (
    pdflatex -interaction=nonstopmode myChessNotebook.tex
)

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


