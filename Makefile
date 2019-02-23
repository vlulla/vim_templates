.PHONY: all clean message
# .DEFAULT: alll
.DEFAULT: message

R_OPTS = --no-save --no-restore --no-init-file --no-site-file

## TODO: Delete this target when you've modified Makefile for your project
## TODO: Update the .DEFAULT target above too!
message:
	@echo "Modify the Makefile to fit your target"

all: tst.pdf

%.pdf: %.tex
	latexmk -silent -rules -xelatex $<
	latexmk -silent -c $<

%.pdf: %.ly
	${LILYPOND} $<

%.html: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"
%.docx: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"
%.pdf: %.Rmd
	R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"
%.pdf: %.md
	R ${R_OPTS} -e "rmarkdown::render('$<')"

%.Rout: %.R
	R CMD BATCH --no-restore $<

%.html: %.tex
	pandoc -s --ascii -t html5 -o $@ $<

clean:
	@echo "Do cleaning here"
	rm -rf *.Rout
