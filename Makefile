## The next few lines from https://tech.davis-hansson.com/p/make/  "Your Makefiles are wrong"
##
## So that we can use brace expansion which is unavailable in sh! Sheesh!
SHELL := bash
.ONESHELL:
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.RECIPEPREFIX = >

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


.PHONY: all clean message cleanall
.DEFAULT_GOAL: all

R_OPTS = --no-restore --no-init-file --no-site-file
PANDOC_OPTS=-f markdown+pipe_tables+footnotes+tex_math_dollars+implicit_figures --standalone --listings --toc --toc-depth=2 --filter=pandoc-citeproc
PANDOC_HTML_OPTS = -t html5 --self-contained --number-sections --listings --mathml --email-obfuscation=references 
LILYPOND=lilypond

all:
> @echo "Modify the Makefile to fit your target"

%.tex: %.md Makefile
> pandoc ${PANDOC_OPTS} -t latex -o $@ $<

%.pdf: %.tex Makefile
> sed -i -e 's@\\linethicknes@2 pt@g' $<
> # latexmk -silent -rules -pdf -xelatex $<
> # latexmk -silent -pdflua $<  # Does not work with microtypeoptions
> latexmk -silent -pdf $<
> latexmk -silent -pdf -c $<
> # open $@

%.pdf: %.ly Makefile
> ${LILYPOND} $<

%.pdf: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"

## %.pdf: %.md Makefile
## 	pandoc ${PANDOC_OPTS} -t latex  -o $@ $<

%.docx: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"

%.docx: %.md Makefile
> pandoc ${PANDOC_OPTS} -t docx -o $@ $<

%.odt: %.md Makefile
> pandoc ${PANDOC_OPTS} -t odt -o $@ $<

%.Rout: %.R Makefile
> R CMD BATCH --no-restore $<

%.html: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"

%.html: %.md Makefile
> pandoc ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} -o $@ $<
> # sed -i -e 's@<table>@<table border="1" style="border-collapse: collapse;">@g' $@
> # open $@

%.html: %.tex Makefile
> pandoc $(PANDOC_OPTS) ${PANDOC_HTML_OPTS} -f latex -o $@ $<

clean:
> @echo "Do cleaning here"
> rm -rf *.Rout .RData

cleanall: clean
> @echo "Do some specialized cleaning here..."
