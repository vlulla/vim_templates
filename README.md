This directory contains template files that can be used as skeletons in vim.
Try `:h skeleton` in vim to see how to use these template files.

The following lines are from my `.vimrc` file:

```
" See :help template
autocmd BufNewFile *.tex 0r <your folder path>/vim_templates/latextemplate.tex
autocmd BufNewFile *.ly 0r <your folder path>/vim_templates/lilypondtemplate.ly
autocmd BufNewFile *.Rmd 0r <your folder path>/vim_templates/Rmdtemplate.Rmd
autocmd BufNewFile *.md 0r <your folder path>/vim_templates/mdtemplate.md
autocmd BufNewFile *.R 0r <your folder path>/vim_templates/Rtemplate.R
autocmd BufNewFile Makefile 0r <your folder path>/vim_templates/Makefile
autocmd BufNewFile *.go 0r <your folder path>/vim_templates/gotemplate.go
autocmd BufNewFile *.py 0r <your folder path>/vim_templates/pythontemplate.py
autocmd BufNewFile build.sbt 0r <your folder path>/vim_templates/build.sbt
```
