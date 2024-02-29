---
title: "Example of how to use markdown to create documents"
subtitle: "(using pandoc markdown)"
author:
- "[Vijay Lulla](https://vlulla.github.io/)"
- Author Two
date: "«Date goes here»"
keywords:
- keyword 1
- keyword 2
abstract: |
  Put the multline abstract here!

  It can contain multiple paragraphs too.
fontfamilyoptions:
- osf
- p
geometry:
- margin=1in
- heightrounded
hyperrefoptions:
- linktoc=all
- pdfwindowui
linestretch: 1
pagestyle: headings
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
``` {=html}
<style>body{min-width: 90% !important;}</style>
```

This is a brief introduction to markdown.
Specifically, pandoc markdown!
Pandoc is awesome software!
I encourage you to bookmark <https://pandoc.org/MANUAL.txt> and peruse it as often as you can.

There are great many tutorials about how to use markdown but I encourage you to 
stick with [pandoc's markdown](https://pandoc.org/MANUAL.html#pandocs-markdown) because pandoc
is very versatile and it can convert `pandoc markdown` into any other format you need.

# Introduction {#intro}

Here is a level 1 section. 
Here's how to do some common font formatting in markdown files:

- _Emphasized text_
- *Emphasized text*
- __Bolded text__
- **Bolded text**
- ~~Strikethrough~~
- _Emphasized **with bolded**_
- [Small caps]{.smallcaps} -- Example of small caps
- Feas*ible*, not feas*able*.
- H~2~O is liquid. 2^10^ is 1024. And, subscript with space P~a\ cat~.
<!-- end of list -->

The above is an example of creating a *bullet* (or unordered) list. This same list can be rendered as a "loose" list like so:

- _Emphasized text_

- *Emphasized text*

- __Bolded text__

- **Bolded text**

- ~~Strikethrough~~

- _Emphasized **with bolded**_

- [Small caps]{.smallcaps} -- Example of small caps

- Feas*ible*, not feas*able*.

- H~2~O is liquid. 2^10^ is 1024. And, subscript with space P~a\ cat~.
<!-- end of list -->

Line blocks are very useful. Especially for formatting addresses and/or poetry with
specific spacing requirements! Check out how to use line blocks.

| Vijay Lulla PhD
|
| Email: 
| Ph:

Sections can contain many paragraphs.
And, a paragraph is a     collection of sentences with newlines on either sided (beginning and ending).
Pandoc is very smart and it removes mutliple spaces between words/paragraphs.
This helps you have visual separation in your source (markdown) documents without impacting the final output.

## Subsection in Introduction

Sections can have subsections.
And, by default pandoc displays 3 levels of sections in the table of contents (TOC). 
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

Now compare this with the following (check last three lines):

> I returned and saw under the sun, that the race is not to the swift, nor the
> battle to the strong, neither yet bread to the wise, nor yet riches to men of
> understanding, nor yet favour to men of skill; but time and chance happenth to
> them all.
> --- In George Orwell's _Politics and the English Language_
> [Link](http://www.orwell.ru/library/essays/politics/english/e_polit)

### Subsubsection in Literature Review

This is a subsubsection!
You can have up to six levels of headers.
I do not know what happens if you need more than six levels of headings.

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
<!-- end of list -->

Here's another unordered list example:

* item 1
* item 2
* **bold item 3**
<!-- end of list -->

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

<!-- -->

#. Include the `<!-- -->` empty html tag to break consecutive lists! Or better
   yet include `<!-- end of list -->` explicitly after end of each list.
#. This is a distinct list from previous list.

In general, try to avoid having too many [un]ordered lists.
While lists are helpful for quick skimming or ensuring that steps are followed, try to
avoid them for more complex texts.
Lists interrupt reading speed and do not help with overall comprehension.

## Data Description {#data-description}

Describe your data here.
This just an example of subsection.

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

Most of the math rendering (especially inline math rendering) is not distinguishable in html output.
Look at the pdf output generated by pandoc!

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

```{.r .numberLines .lineAnchors startFrom="1" }
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
