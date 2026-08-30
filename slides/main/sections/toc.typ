#import "../../globals.typ": *

= 目次

#slide[
  // show table of contents
  // cf. https://touying-typ.github.io/docs/tutorials/sections#table-of-contents
  #text(0.9em)[
    #show outline.entry.where(level: 2): set text(0.9em)
    #components.adaptive-columns(
      outline(title: none, indent: 1em),
    )
  ]
]
