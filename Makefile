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

.PHONY: all clean message cleanall pyshell update-repo
.DEFAULT_GOAL: all

R_OPTS = --quiet --no-restore --no-init-file --no-site-file
PANDOC_OPTS=--from=markdown --standalone --highlight-style=tango --wrap=none --citeproc --toc --toc-depth=2
PANDOC_HTML_OPTS=--to=html5 --number-sections --mathjax --email-obfuscation=references
LILYPOND=lilypond

CC  := $(shell command -v clang   || command -v gcc 2>/dev/null)
CXX := $(shell command -v clang++ || command -v g++ 2>/dev/null)
CFLAGS   := $(if $(I),-Werror,) -Wextra -Wall -fsanitize=address -fsanitize=undefined
CPPFLAGS := $(if $(I),-Werror,) -Wextra -Wall -fsanitize=address -fsanitize=undefined

md_files = $(wildcard *.md)
all: $(md_files:.md=.pdf) $(md_files:.md=.html)

update-repo:
> git stash push --include-untracked
> git pull --ff-only
> git stash pop || exit 0 ## '...' ## no stash entry generates a non-zero exit indicating error :-(
## Modify the env to your choice...
pyshell:
> micromamba run --name base python3 -I -s -E -OO

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
> docker run --rm --platform=linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc-komascript ${PANDOC_OPTS} --to=native --output=$@ $<

%.pdf: %.md Makefile
> docker run --rm --platform=linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc-komascript ${PANDOC_OPTS} --to=latex --output=$@ $<

%.html: %.md Makefile
> docker run --rm --platform=linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc-komascript  ${PANDOC_OPTS} ${PANDOC_HTML_OPTS} --output=$@ $<

%.docx: %.md Makefile
> docker run --rm --platform=linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc-komascript ${PANDOC_OPTS} --to=docx --output=$@ $<

%.odt: %.md Makefile
> docker run --rm --platform=linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc-komascript ${PANDOC_OPTS} --to=odt --output=$@ $<

%.pdf: %.ly Makefile
> ${LILYPOND} $<

%.pdf: %.qmd Makefile
> quarto render $< --to pdf --toc

%.html: %.qmd Makefile
> quarto render $< --to html --toc

%.pdf: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'pdf_document')"

%.html: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'html_document')"
>
%.docx: %.Rmd Makefile
> R ${R_OPTS} -e "rmarkdown::render('$<', 'word_document')"

%.Rout: %.R Makefile
> R CMD BATCH ${R_OPTS} $<


%.R: %.Rmd Makefile
> R ${R_OPTS} -e "knitr::purl(input='$<',output='$@',documentation=0)"

%.html: %.tex Makefile
> docker run --rm --platform linux/amd64 --mount "type=bind,src=$$(pwd),dst=/data" --user "$$(id -u):$$(id -g)" pandoc/latex:3.1 $(PANDOC_OPTS) ${PANDOC_HTML_OPTS} --from=latex --output=$@ $<

clean:
> @echo "Do cleaning here"
> rm -rf $(md_files:.md=.pdf) $(md_files:.md=.html)

cleanall: clean
> @echo "Do some specialized cleaning here..."
> rm -rf *.Rout .RData __pycache__

## to debug variables define in Makefile...
## bash $ make -n vars 2>/dev/null ## suppress --warn-undefined-variables flag set earlier...
## from https://stackoverflow.com/a/7119460
vars:; $(foreach v,$(.VARIABLES),$(info $(v) = $($(v)) ))
