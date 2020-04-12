## The next few lines from https://tech.davis-hansson.com/p/make/  "Your Makefiles are wrong"
##
## So that we can use brace expansion which is unavailable in sh! Sheesh!
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR:
.ONESHELL:
SHELL := bash

MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules


.PHONY: all clean message cleanall
.DEFAULT_GOAL: all

R_OPTS = --no-restore --no-init-file --no-site-file
PANDOC_OPTS=--standalone --listings --toc --toc-depth=2 --filter=pandoc-citeproc
PANDOC_HTML_OPTS = -t html5 --self-contained --number-sections --listings --mathml --email-obfuscation=references 
LILYPOND=lilypond

all:
	@echo "Modify the Makefile to fit your target"

%.tex: %.md
	pandoc ${PANDOC_OPTS} -t latex -f markdown+pipe_tables+footnotes+tex_math_dollars -o $@ $<

%.pdf: %.tex
	# sed -i -e 's@\\linethicknes@2 pt@g' $<
	# latexmk -silent -rules -pdf -xelatex $<
	# latexmk -silent -pdflua $<  # Does not work with microtypeoptions
	latexmk -silent -pdf $<
	latexmk -silent -pdf -c $<
	# open $@
%.pdf: %.ly
	${LILYPOND} $<
%.pdf: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"
## %.pdf: %.md
## 	pandoc ${PANDOC_OPTS} -t latex -f markdown+pipe_tables+footnotes+tex_math_dollars  -o $@ $<


%.docx: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"
%.docx: %.md
	pandoc ${PANDOC_OPTS} -t docx -f markdown+pipe_tables+footnotes+tex_math_dollars -o $@ $<
%.odt: %.md
	pandoc ${PANDOC_OPTS} -f markdown+pipe_tables+footnotes+tex_math_dollars -t odt -o $@ $<

%.Rout: %.R
	R CMD BATCH --no-restore $<

%.html: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"
%.html: %.md
	pandoc ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} -f markdown+pipe_tables+footnotes+tex_math_dollars -o $@ $<
	# sed -i -e 's@<table>@<table border="1" style="border-collapse: collapse;">@g' $@
	# open $@
%.html: %.tex
	pandoc $(PANDOC_OPTS) ${PANDOC_HTML_OPTS} -f latex -o $@ $<

clean:
	@echo "Do cleaning here"
	rm -rf *.Rout .RData

cleanall: clean
	@echo "Do some specialized cleaning here...
