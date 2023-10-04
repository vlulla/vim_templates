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

R_OPTS = --quiet --no-restore --no-init-file --no-site-file
PANDOC_OPTS=--from=markdown --standalone --highlight-style=tango --wrap=none --citeproc --toc --toc-depth=2
PANDOC_HTML_OPTS=--to=html5 --number-sections --mathjax --email-obfuscation=references
LILYPOND=lilypond

CC ?= gcc
CXX ?= g++
CFLAGS := $(if $(I),-Werror,) -Wextra -Wall -fsanitize=address -fsanitize=undefined
CPPFLAGS := $(if $(I),-Werror,) -Wextra -Wall -fsanitize=address -fsanitize=undefined


all: $(patsubst %.md,%.pdf,$(wildcard *.md))


% %.o: %.c Makefile
> $(CC) $(CFLAGS) -o $@ $<

% %.o: %.cc Makefile
> $(CXX) $(CPPFLAGS) -o $@ $<

% %.o: %.cpp Makefile
> $(CXX) $(CPPFLAGS) -o $@ $<

%.pdf: %.dot
> ## sed -i -E -e 's/([0-9]{4})-([0-9]{2})-([0-9]{2})/\1.\2.\3/g' $<
> dot -Tpdf -o $@ $<

%.pdf: %.gv
> sed -i -E -e 's/([0-9]{4})-([0-9]{2})-([0-9]{2})/\1.\2.\3/g' $<
> dot -Tpdf -o $@ $<

%.svg: %.dot
> dot -Tsvg -o $@ $<

%.svg: %.gv
> sed -i -E -e 's/([0-9]{4})-([0-9]{2})-([0-9]{2})/\1.\2.\3/g' $<
> dot -Tsvg -o $@ $<

%: %.rs
> rustc $<

## For debugging
%.native: %.md
> pandoc ${PANDOC_OPTS} --to=native --output=$@ $<

%.pdf: %.md Makefile
> pandoc ${PANDOC_OPTS} --to=latex --output=$@ $<

%.html: %.md Makefile
> pandoc ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} --output=$@ $<

%.docx: %.md Makefile
> pandoc ${PANDOC_OPTS} --to=docx --output=$@ $<

%.odt: %.md Makefile
> pandoc ${PANDOC_OPTS} --to=odt --output=$@ $<

%.pdf: %.ly Makefile
> ${LILYPOND} $<

%.pdf: %.qmd Makefile
> quarto render $< --to pdf --toc

%.html: %.qmd Makefile
> quarto render $< --to html --toc

%.pdf: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"

%.docx: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"

%.Rout: %.R Makefile
> R CMD BATCH ${R_OPTS} $<

%.html: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"

%.html: %.md Makefile
> pandoc ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} --output=$@ $<

%.html: %.tex Makefile
> pandoc $(PANDOC_OPTS) ${PANDOC_HTML_OPTS} --from=latex --output=$@ $<

clean:
> @echo "Do cleaning here"
> rm -rf $(patsubst %.md,%.pdf,$(wildcard *.md))

cleanall: clean
> @echo "Do some specialized cleaning here..."
> rm -rf *.Rout .RData
