# LaTeX build configuration for incremental compilation
# latexmk automatically tracks dependencies and only rebuilds what's needed

# Use pdflatex as the default engine
$pdf_mode = 1;

# Use biber for bibliography
$biber = 'biber %O %S';

# Use makeindex for index
$makeindex = 'makeindex %O -s indexstyle.ist %S';

# Maximum number of compilation passes
$max_repeat = 5;

# Standard pdflatex command with nonstopmode for faster compilation
$pdflatex = 'pdflatex -interaction=nonstopmode -file-line-error %O %S';

# Enable synctex for forward/inverse search in editors
$pdf_previewer = 'start %O %S';

# Custom dependency for index
add_cus_dep('idx', 'ind', 0, 'makeindex');
$hash_calc_ignore_pattern{'ind'} = '^[^%]*%';

# Custom dependency for bibliography
add_cus_dep('bcf', 'bbl', 0, 'biber');
$hash_calc_ignore_pattern{'bbl'} = '^[^%]*%';


