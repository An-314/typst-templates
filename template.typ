/* This is a template for writing articles in Chinese. */

#let project(
  template: "article",
  title: "",
  info:"",
  authors: (),
  time: "",
  abstract: none,
  keywords: (),
  contents: false,
  content_depth: 2,
  font_size: 11pt,
  body
) = {
  let song = ("Linux Libertine", "SimSun")
  let hei = ("Linux Libertine", "SIMHEI")
  let kai = ("Linux Libertine", "KaiTi",)
  let xbsong = "FZXiaoBiaoSong-B05"
  let code = "Consolas"
  let title-font = hei
  let author-font = kai
  let body-font = song
  let heading-font = hei
  let caption-font = kai
  let header-font = kai
  let strong-font = hei
  let emph-font = kai
  let quote-font = kai
  let raw-font = code
  
  set document(author: authors, title: title)
  set heading(numbering: "1.1")
  set text(font: body-font, lang: "zh", region: "cn")
  set bibliography(style: "gb-7714-2015-numeric")

  // 设置字体字号
  set par(first-line-indent: 2em,leading: 1.1em)
  set enum(indent: 2em)
  set figure(gap: 0.5cm)
  set text(font: body-font, size: font_size)
  show strong: set text(font: strong-font)
  show emph: set text(font: emph-font)
  show ref: set text(red)
  show raw.where(block: true): block.with(
    width: 100%,
    fill: luma(240),
    inset: 10pt,
  )
  show raw.where(block: true): set par(leading: 0.7em)
  show raw: set text(font: (raw-font, "simsun"), size: 10pt)
  show link: underline
  show link: set text(blue)

  // 页码标记：首页
  set page(numbering: "1", number-align: center, header: align(left)[
    #set text(font: header-font)
    #locate(loc => if(loc.page() != 1) [#title])
  ])

  // 设置标题
  if(template == "article") {
    // 标题
    align(center)[
      #block(text(font: title-font, weight: 700, 2.3em, title))
    ]
    // 信息
    if(info != ""){
    align(center)[
      #v(0.5em)
      #block(text(font: author-font, 1.5em, info))
    ]}
    // 作者信息
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, text(font: author-font, author))),
      ),
    )
    // 时间
    if (time != "") {align(center)[
      #set text(1em)
      #time
    ]}
    // 摘要
    if abstract != none [
      #v(2pt)
      *摘要：*#abstract
      #v(1pt)
      #if keywords!= () [
        *关键字：* 
        #text(font: kai, keywords.join("；"))
      ]
      #v(10pt)
    ]
  }
  // 定义标题样式
  show heading: it => box(width: 100%)[
    #set text(font: heading-font)
    #if it.numbering != none { counter(heading).display() }
    #h(0.2em)
    #it.body
  ]
  show heading.where(level: 1): it => box(width: 100%)[
    #v(0.3em)
    #set heading(numbering: "一")
    #it
    #v(0.2em)
  ]
  // 显示目录
  if(contents) {
    let _TEMPLATE_LISTS_ = ("book", "report")
    if(template in ("book", "report")) {
      set page(
        numbering: "I", number-align: center, header: align(left)[
        #set text(font: header-font)
        #title])
      counter(page).update(1)
    }
    set par(first-line-indent: 2em,leading: 1em)
    show outline.entry.where(level: 1): it => {
        v(0.3em)
        h(-2.0em)
        set text(15pt)
        strong(it)
    }
    outline(indent: auto, depth: content_depth, fill: repeat( "  ·"))
    pagebreak()
  }
  // 调整图片
  show figure: it => [
    #v(2pt)
    #set text(font: caption-font)
    #it
    #v(-2em)
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(13pt)
  ]
  show image: it => [
    #it
    #v(-1.1em)
    #par()[#text(size: 0.0em)[#h(1.0em)]]
  ]
  // 调整表格
  show table: it => [
    #set text(font: body-font)
    #it
  ]
  // 调整列表
  show enum: it => [
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(-12pt)
  ]
  show list: it => [
    #it
    #par()[#text(size: 0.0em)[#h(0.0em)]]
    #v(-12pt)
  ]
  // 调整引用
  show quote: it => [
    #set text(font: quote-font)
    #align(center)[#it]
  ]
  body
}

#let newpara() = {
  par()[#text(size: 0.0em)[#h(0.0em)]]
  v(-12pt)
}

#let problem-counter = counter("problem")
#problem-counter.step()

#let problem(body) = {
  problem-counter.step()
  set enum(numbering: "(1)")
  block(
    fill: rgb(241, 241, 255),
    inset: 8pt,
    radius: 2pt,
    width: 100%,
  )[*题目 #problem-counter.display().* #h(0.75em) #body]
}

#let solution(body) = {
  set enum(numbering: "(1)")
  block(
    inset: 8pt,
    width: 100%
  )[*解答.* #h(0.75em) #body]
}