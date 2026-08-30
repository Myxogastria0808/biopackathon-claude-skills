#import "@preview/touying:0.7.4": *
// slide theme
#import themes.simple: *
// for numbering slides
#import "@preview/numbly:0.1.0": numbly
// for category theory diagrams
#import "@preview/fletcher:0.5.7" as fletcher: diagram, edge, node

// flecher binding for touring
#let diagram = touying-reduce.with(fletcher)

// a speech-bubble callout, with a triangular tail pointing away from the
// block's center at `angle` (0deg = right, 90deg = up, counterclockwise,
// same convention as `calc.cos`/`calc.sin`)
#let speech-bubble(
  body,
  fill: luma(230),
  radius: 4pt,
  inset: 15pt,
  tail-length: 10pt,
  tail-width: 16pt,
  angle: 180deg,
) = context {
  let content-block = block(fill: fill, inset: inset, radius: radius, body)
  let size = measure(content-block)
  let hw = size.width / 2
  let hh = size.height / 2
  let dir = (calc.cos(angle), calc.sin(angle))
  // distance from the center to the rectangle's boundary along `dir`
  let t = if dir.at(0) == 0 {
    hh / calc.abs(dir.at(1))
  } else if dir.at(1) == 0 {
    hw / calc.abs(dir.at(0))
  } else {
    calc.min(hw / calc.abs(dir.at(0)), hh / calc.abs(dir.at(1)))
  }
  let base-center = (t * dir.at(0), t * dir.at(1))
  let perp = (-dir.at(1), dir.at(0))
  let apex = (
    base-center.at(0) + dir.at(0) * tail-length,
    base-center.at(1) + dir.at(1) * tail-length,
  )
  let base1 = (
    base-center.at(0) + perp.at(0) * tail-width / 2,
    base-center.at(1) + perp.at(1) * tail-width / 2,
  )
  let base2 = (
    base-center.at(0) - perp.at(0) * tail-width / 2,
    base-center.at(1) - perp.at(1) * tail-width / 2,
  )
  // convert from center-origin/y-up math coords to top-left-origin/y-down
  let to-screen(p) = (hw + p.at(0), hh - p.at(1))
  let pts = (to-screen(apex), to-screen(base1), to-screen(base2))
  let min-x = calc.min(..pts.map(p => p.at(0)))
  let min-y = calc.min(..pts.map(p => p.at(1)))
  box(width: size.width, height: size.height, {
    place(top + left, content-block)
    place(
      top + left,
      dx: min-x,
      dy: min-y,
      polygon(fill: fill, ..pts.map(p => (p.at(0) - min-x, p.at(1) - min-y))),
    )
  })
}

// section-divider slide for level 1 headings, using a lighter weight than
// the theme's default `weight: "bold"`
#let my-new-section-slide(config: (:), body) = centered-slide(config: config, [
  #text(1.4em, weight: "regular", utils.display-current-heading(level: 1))
  #body
])

// apply this in each slide file via `#show: my-theme`
#let my-theme(body) = {
  // use a thinner Noto Sans (gothic) font
  set text(font: "Noto Sans CJK JP", weight: "light")
  // use a thinner Noto Sans (gothic) font for raw text blocks, which otherwise
  show raw: set text(font: "Noto Sans CJK JP", weight: "light")
  // wrap fenced code blocks (```lang ...```) in a rounded silver panel,
  // matching the block() styling used for note callouts; leaves inline
  // `code` spans untouched
  show raw.where(block: true): it => block(fill: silver, inset: 8pt, radius: 4pt, width: 100%, it)
  // set slide numbering style
  // the title page uses `#title-slide`, independent of the heading tree,
  // so level 1 and level 2 headings are free to number normal chapters/sections
  set heading(numbering: numbly("{1}.", "{1}.{2}."))
  // style hyperlinks (both explicit `#link` and bare-URL auto-links) so
  // they read as clickable in the exported PDF
  show link: it => text(fill: rgb("#1a56db"), underline(it))
  show: simple-theme.with(
    // aspects ratio for slides, default is 16:9
    aspect-ratio: "16-9",
    config-common(
      // set handout mode for printing, default is false
      // you can select the sub slides where you want to show in handout mode
      // e.g.
      // ```
      // // Keep only the first subslide (useful for "before" snapshots)
      // config-common(handout: true, handout-subslides: 1)
      // Keep the first and last subslides
      // config-common(handout: true, handout-subslides: (1, -1))
      // // Keep a range expressed as a string (same syntax as `only`/`uncover`)
      // config-common(handout: true, handout-subslides: "1-2")
      // ```
      // cf. https://touying-typ.github.io/docs/tutorials/dynamic/handout
      handout: false,
      // use a lighter weight than the theme's default `weight: "bold"`
      new-section-slide-fn: my-new-section-slide,
      // by default touying colors `*bold*` text with the primary color
      // (a greenish teal here); keep it plain black bold instead
      show-strong-with-alert: false,
    ),
    // the theme's own per-slide init hard-codes `size: 25pt`, overriding any
    // outer `set text(size: ...)`, so it must be overridden here instead
    config-methods(init: (self: none, body) => {
      set text(size: 20pt)
      body
    }),
    // content shown at the top of every slide created by a level 2 heading;
    // overrides the theme's default `weight: "bold"` with a lighter weight
    subslide-preamble: block(
      below: 1.5em,
      text(1.2em, weight: "regular", utils.display-current-heading(level: 2)),
    ),
    header: [
      // show current section (level: 1) in the header
      #text(gray, utils.display-current-heading(level: 1))
    ],
    // show progress bar in the footer
    // cf. https://touying-typ.github.io/docs/tutorials/progress/counters#progress-bar
    footer: self => utils.touying-progress(ratio => {
      // ratio is a float between 0.0 and 1.0
      box(width: ratio * 100%, height: 4pt, fill: self.colors.primary)
    }),
    footer-right: none,
  )
  body
}

