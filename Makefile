.PHONY: all clean message
.DEFAULT_GOAL: all

R_OPTS = --no-restore --no-init-file --no-site-file
PANDOC_OPTS=--standalone --toc --toc-depth=2 --filter pandoc-citeproc
PANDOC_PDF_OPTS = -t latex
PANDOC_DOCX_OPTS = --to docx
PANDOC_HTML_OPTS = --to html5 --self-contained --number-sectiosn
LILYPOND=lilypond

all:
	@echo "Modify the Makefile to fit your target"

%.pdf: %.tex
	latexmk -silent -rules -xelatex $<
	latexmk -silent -pdf -c $<
%.pdf: %.ly
	${LILYPOND} $<
%.pdf: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"
## %.pdf: %.md
## 	pandoc ${PANDOC_OPTS} ${PANDOC_PDF_OPTS} -f markdown  -o $@ $<

%.tex: %.md
	pandoc ${PANDOC_OPTS} ${PANDOC_PDF_OPTS} -f markdown -o $@ $<

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
%.html: %.tex
	pandoc $(PANDOC_OPTS) --ascii -t html5 -o $@ $<
%.html: %.md
	pandoc ${PANDOC_OPTS} -f markdown -t html5 -o $@ $<

clean:
	@echo "Do cleaning here"
	rm -rf *.Rout .RData
