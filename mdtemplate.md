---
title: "Title goes here"
auhtor: "[Vijay Lulla](http://vijaylulla.com)"
date: "Date here"
output:
  html_document:
    toc: true
    toc_depth: 3
    number_sections: true
    fig_caption: true
    code_folding: hide
  pdf_document:
    toc: true
    toc_depth: 3
    keep_tex: false
    number_sections: true
    latex_engine: xelatex
  word_document:
    toc: true
    toc_depth: 3
    fig_caption: true
fontsize: 11pt
geometry: margin=1in
bibliography: mybibliography.bib
csl: apa.csl
---


# Introduction {#intro}

Write your introduction here!

It is usually multiple paragraphs.

# Literature Review (or background) {#background}

Write your background/literature review here!  You'll need to include citations
in your report.  Here's how to do citation [@bogar_green_space_2016].  And,
@farris_creation_2009 is the way to cite inline!

# Data and methods {#data-and-methods}

Since this is a report containing R snippets it will include stuff for R code
along with the descriptions of the data that you need.  Please also include
where you got the data from!


## Data Description {#data-description}

More description of the data if required.

# Results {#results}

Discuss your results here.  Instead of describing the tables and/or figures try
to explain how to interpret what we're seeing in the tables, figures, and
charts.

# Discussions {#discussion}

Discuss anything that doesn't fit anywhere else!

## Example of tables!

-------------------------------------------------------------
 Centered   Default           Right Left
  Header    Aligned         Aligned Aligned
----------- ------- --------------- -------------------------
   First    row                12.0 Example of a row that
                                    spans multiple lines.

  Second    row                 5.0 Here's another one. Note
                                    the blank line between
                                    rows.
-------------------------------------------------------------

Table: Here's the caption. It, too, may span
multiple lines.

To be able to use this the extensions `+multiline_tables` and `+table_captions`
will have to be used with the output format.  This is definitely needed for **html**.


Here are some miscellaneous notes:

<https://www.google.com> link directly!

[Google](https://www.google.com) link with separate content for link and href!

To show a code block indent by **four spaces**.  Let's see if it works

    randstr <- function(length=10) {
      paste0(sample(c(letters, LETTERS), length, replace=TRUE), collapse="")
    }
    set.seed(1234L)
    randstr()

Let's see if this actually works!


To include  a list just create a correctly aligned bullet-list like so:

* item 1
* item 2
* **bold item 3**

And here's an example of block quote:

> I returned and saw under the sun, that the race is not to the swift, nor the
> battle to the strong, neither yet bread to the wise, nor yet riches to men of
> understanding, nor yet favour to men of skill; but time and chance happenth to
> them all.
>
> --- In George Orwell's _Politics and the English Language_
> [Link](http://www.orwell.ru/library/essays/politics/english/e_polit)

The end!

# References {#references}
