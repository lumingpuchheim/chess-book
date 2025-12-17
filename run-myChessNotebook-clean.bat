@echo off
REM Clean all build artifacts for myChessNotebook (full and lite)
REM This removes temporary and output files for both jobnames.

cd /d "%~dp0"

echo Cleaning LaTeX build artifacts for myChessNotebook...
cd myChessNotebook

REM Use latexmk to clean for both main and lite variants (if present)
if exist myChessNotebook.tex (
    latexmk -C myChessNotebook.tex >nul 2>&1
)
if exist myChessNotebook-lite.tex (
    latexmk -C myChessNotebook-lite.tex >nul 2>&1
)

REM Extra safety: remove common auxiliary files for both jobnames
for %%J in (myChessNotebook myChessNotebook-lite) do (
    del /Q "%%J.aux"        2>nul
    del /Q "%%J.bbl"        2>nul
    del /Q "%%J.blg"        2>nul
    del /Q "%%J.idx"        2>nul
    del /Q "%%J.ind"        2>nul
    del /Q "%%J.ilg"        2>nul
    del /Q "%%J.lof"        2>nul
    del /Q "%%J.lot"        2>nul
    del /Q "%%J.out"        2>nul
    del /Q "%%J.toc"        2>nul
    del /Q "%%J.synctex.gz" 2>nul
    del /Q "%%J.fdb_latexmk" 2>nul
    del /Q "%%J.fls"        2>nul
    del /Q "%%J.run.xml"    2>nul
)

cd ..

echo.
echo Clean complete.
pause


