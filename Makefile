## The next few lines from https://tech.davis-hansson.com/p/make/  "Your Makefiles are wrong"
##
## So that we can use brace expansion which is unavailable in sh! Sheesh!
.SHELLFLAGS := -eu -o pipefail -c
.DELETE_ON_ERROR
.ONESHELL
SHELL := bash


.PHONY: all clean message
.DEFAULT_GOAL: all

R_OPTS = --no-restore --no-init-file --no-site-file
PANDOC_OPTS=--standalone --toc --toc-depth=2 --filter pandoc-citeproc
PANDOC_PDF_OPTS = -t latex
PANDOC_DOCX_OPTS = --to docx --listings
PANDOC_HTML_OPTS = --to html5 --self-contained --number-sections --listings
LILYPOND=lilypond

all:
	@echo "Modify the Makefile to fit your target"

%.tex: %.md
	pandoc ${PANDOC_OPTS} ${PANDOC_PDF_OPTS} -f markdown -o $@ $<

%.pdf: %.tex
	latexmk -silent -rules -xelatex $<
	latexmk -silent -pdf -c $<
%.pdf: %.ly
	${LILYPOND} $<
%.pdf: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"
## %.pdf: %.md
## 	pandoc ${PANDOC_OPTS} ${PANDOC_PDF_OPTS} -f markdown  -o $@ $<


%.docx: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"
%.docx: %.md
	pandoc ${PANDOC_OPTS} ${PANDOC_DOCX_OPTS} -f markdown -o $@ $<
%.odt: %.md
	pandoc ${PANDOC_OPTS} -f markdown -t odt -o $@ $<

%.Rout: %.R
	R CMD BATCH --no-restore $<

%.html: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"
%.html: %.md
	pandoc ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} -f markdown -o $@ $<
%.html: %.tex
	pandoc $(PANDOC_OPTS) ${PANDOC_HTML_OPTS} -f latex -o $@ $<

clean:
	@echo "Do cleaning here"
	rm -rf *.{Rout,RData}
