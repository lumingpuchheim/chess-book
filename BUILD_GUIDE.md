# LaTeX Build Optimization Guide

## Quick Start

**Use `run.bat` for incremental builds** - This uses `latexmk` which automatically detects what has changed and only rebuilds those parts. This is much faster than rebuilding everything from scratch!

## How It Works

`latexmk` tracks dependencies between your `.tex` files and auxiliary files (`.aux`, `.bbl`, `.idx`, etc.). When you run `run.bat`:

1. It checks which files have changed since the last build
2. Only runs the necessary compilation passes (pdflatex, makeindex, biber)
3. Skips steps that aren't needed

## Usage

### Normal Development (Recommended)
```batch
run.bat
```
This will only rebuild what's changed. Much faster!

### Full Clean Build
```batch
run-full.bat
```
Use this when you want to ensure everything is completely up to date, or if you're getting strange errors.

## Even Faster: Comment Out Sections During Development

If you're only working on one chapter, you can temporarily comment out other sections in `main.tex`:

```latex
% Temporarily comment out sections you're not working on
%\input{cards/chess/maneuvering/chess-problem}
%\input{cards/chess/maneuvering/conquest-nunn}
\input{cards/chess/maneuvering/fischer-keres}  % Only this one is active
%\input{cards/chess/maneuvering/petrosian-bannik}
```

This makes compilation much faster because LaTeX doesn't process those files at all.

**Remember to uncomment before final build!**

## Tips

- **First build**: The first time you run `run.bat`, it will do a full build (this is normal)
- **Subsequent builds**: Only changed files will be recompiled
- **If something seems wrong**: Run `run-full.bat` to force a complete rebuild
- **Clean auxiliary files**: `latexmk -C main.tex` removes all auxiliary files

## Troubleshooting

If `latexmk` is not found, you may need to install it:
- **MiKTeX**: Usually included, or install via MiKTeX Package Manager
- **TeX Live**: Usually included


