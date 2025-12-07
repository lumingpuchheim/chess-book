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

echo Running pdflatex (first pass)...
pdflatex -interaction=nonstopmode myChessNotebook.tex

echo Running biber for bibliography...
biber myChessNotebook

echo Running makeindex for index...
if exist myChessNotebook.idx (
    makeindex -s ../indexstyle.ist myChessNotebook.idx
)

echo Running pdflatex (second pass)...
pdflatex -interaction=nonstopmode myChessNotebook.tex

echo Running pdflatex (third pass to resolve all references)...
pdflatex -interaction=nonstopmode myChessNotebook.tex

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

