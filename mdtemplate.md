---
title: "Title goes here"
subtitle: "subtitle here"
author:
- "[Vijay Lulla](https://vlulla.github.io/)"
- Author Two
date: "Date here"
keywords:
- keyword 1
- keyword 2
abstract: |
  Put the multline abstract here!

  It can contain multiple paragraphs too.
documentclass: scrartcl
fontfamilyoptions:
- osf
- p
fontsize: 11pt
toc: true
lot: true
lof: true
geometry:
- margin=1in
- heightrounded
hyperrefoptions:
- linktoc=all
- pdfwindowui
urlcolor: blue
linkcolor: red
microtypeoptions:
- final
- tracking=true
- kerning=true
- spacing=true
- factor=1100
- shrink=10
- stretch=10
bibliography: mybibliography.bib
link-citations: true
csl: apa.csl
---


# Introduction {#intro}

Write your introduction here!  Here's how to do some common font formatting
in markdown files:

- _Emphasized text_
- *Emphasized text*
- __Bolded text__
- **Bolded text**
- ~~Strikethrough~~
- _Emphasized **with bolded**_
- [Small caps]{.smallcaps} -- Example of small caps

It is usually multiple paragraphs.  And, it can contain subsections too!

## Subsection in Introduction

Find this in the TOC!

# Literature Review (or background) {#background}

Write your background/literature review here!  You'll need to include citations
in your report.  Here's how to do citation [@bogar_green_space_2016].  And,
@farris_creation_2009 is the way to cite inline! Here's an example of citations
with some specifics [@nelson_2016; @kegan_2001, chap. 2; @putnam_2016, chap. 1].

## Subsection in Literature Review

This will definitely have subsection. Since this section might need quotations here's
how to do it in markdown.
Block quotes start with a `>`. And here's an example of block quote:

> I returned and saw under the sun, that the race is not to the swift, nor the
> battle to the strong, neither yet bread to the wise, nor yet riches to men of
> understanding, nor yet favour to men of skill; but time and chance happenth to
> them all.
>
> --- In George Orwell's _Politics and the English Language_
> [Link](http://www.orwell.ru/library/essays/politics/english/e_polit)


### Subsubsection in Literature Review

Subsubsection!!

# Data and methods {#data-and-methods}

Since this is a report containing R snippets it will include stuff for R code
along with the descriptions of the data that you need.  Please also include
where you got the data from!

Since you'll need to print lists here's how to do them in markdown. Unordered
list items start with `*`, `-`, `+`.  They can be nested.  Here's an example:

- unordered first item
- unordered second item
- unordered third item
   - sub item one
   - sub item two
      - sub sub item one
      - sub sub item three
   - sub item three

Here's another unordered list example:

* item 1
* item 2
* **bold item 3**

Ordered list items start with numbers.  And, here's a neat tip: don't bother
numbering them yourself...just use the same number for each item and it will show
up correctly.  Check out the example:

1. First item
1. Second item

   This paragraph is part of the list!

   And so is this paragraph.  Ensure not to include a newline after this
   paragraph to keep this as one list!
1. Third item
   - unordered sub item
   - unordered sub item
1. Fourth item -- for this to work indent sublists with **at least three spaces**!
   It's a good idea to indent your list contents (sub-lists or paragraphs) by
   at least three spaces!
   1. ordered sub item
   1. ordered sub item


## Data Description {#data-description}


# Results {#results}

Discuss your results here.  Instead of describing the tables and/or figures try
to explain how to interpret what we're seeing in the tables, figures, and
charts.

Here's some example of math.
Depending upon the value of $x$ the equation $f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}$ may diverge or converge.
And here's that same equation in display mode.
$$
f(x) = \sum_{i=0}^{n} \frac{a_i}{1+x}
$$
And the next line continues below it!

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
multiple lines. Let's write a long caption here.  If this is not enough
we'll add more fluff!

To be able to use this the extensions `+multiline_tables` and `+table_captions`
will have to be used with the output format.  This is definitely needed for **html**.

----

Here's another way to create a horizontal line.  This paragraph has a preceding and following
horizontal line!

****

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

Or you can use backticks with specific language to control code listing/coloring.
Below is some python code.

```python
def average(*nums):
    n = [n for n in nums if isinstance(n, (int,float))]
    return sum(n)/len(n)
```

And the above R code can be expressed as code listing/highlighting:

```r
randstr <- function(length=10) {
  paste0(sample(c(letters, LETTERS), length, replace=TRUE), collapse="")
}
set.seed(1234L)
randstr()
```


Since bibliography is placed at the end of the document include a section header at the
end of the document (like this document).  Or, you can also use the `reference-section-title`
in the YAML metadata.

# References {#references}
