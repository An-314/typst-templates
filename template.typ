/* This is a template for writing articles in Chinese. */

#let newpara() = {
  par()[#text(size: 0.0em)[#h(0.0em)]]
  v(-12pt)
}

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

  // 调整标题
  show heading: it => box(width: 100%)[
    #set text(font: heading-font)
    #v(-0.8em)
    #if it.numbering != none { counter(heading).display() }
    #h(0.2em)
    #it.body
    #v(0.5em)
  ]
  show heading.where(level: 1): it => box(width: 100%)[
    #v(0.3em)
    #set heading(numbering: "一")
    #it
  ]

  /** 把每一板块封装成函数 */
  let mktitle(title) ={
    align(center)[
      #if(template == "report") {
        v(10em)
        block(text(font: title-font, weight: 700, 2.2em, title))
        v(5em)
      } else if(template == "book") {
        v(5em)
        block(text(font: title-font, weight: 700, 2.5em, title))
        v(2em)
      } else [
        #block(text(font: title-font, weight: 700, 2.3em, title))
      ]
  ]}
  let mkinfo(info) = {
    if(info != ""){
      align(center)[
        #if (template == "report") {
          align(center)[
            #v(0em)
            #block(text(font: title-font, weight: 700, 2.5em, info))
            #v(15em)
          ]}else{
            v(0.5em)
            block(text(font: author-font, 1.5em, info))
        }
      ]
    }
  }
  let mkauthor(author) = {
    let author-size = if(template == "report"){ 1.3em }else{ 1.0em }
    pad(
      top: 0.5em,
      bottom: 0.5em,
      x: 2em,
      grid(
        columns: (1fr,) * calc.min(3, authors.len()),
        gutter: 1em,
        ..authors.map(author => align(center, text(font: author-font,size: author-size, author))),
      ),
    )
  }
  let mktime(time) = {
  if (time != "") {align(center)[
    #if(template == "report") {
      v(10em)
      set text(1.3em)
      time
    } else{
      set text(1em)
      time
  }]}}
  let mkabstruct(abstract, keywords) = {
    if (abstract != none) {
      set par(first-line-indent: 0em,leading: 1.1em)
      v(2pt)
      [*摘要：*#abstract]
      v(1pt)
      if keywords!= () [
        *关键字：* 
        #text(font: kai, keywords.join("；"))
      ]
      v(10pt)
    }
  }
  let mkcontent(contents) = {
    if(contents) {
      set par(first-line-indent: 2em,leading: 1em)
      show outline.entry.where(level: 1): it => {
          v(0.3em)
          h(-2.0em)
          set text(15pt)
          strong(it)
      }
      outline(indent: auto, depth: content_depth, fill: repeat( "  ·"))
      v(20pt)
    }
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
  // 数学公式
  show heading.where(level:1): it => {
  counter(math.equation).update(0)
  it
  }
  set math.equation(numbering: it => {
    locate(loc => {
      let count = counter(heading.where(level:1)).at(loc).last()
      numbering("(1.1)", count, it)
    })
  })
  // 调整页眉页脚
  let pageheading = [
    #set text(font: header-font)
    #let header = if(template in ("article")) {
      locate(loc => [#locate(loc => [#counter(heading.where(level:1)).display() #query(selector(heading.where(level:1)).before(loc), loc).last().body.text])])
    }else{
      ""
    }
    #if(header != "" and header != none) {
      locate(loc => if(loc.page() != 1) [#title #h(1fr) #info #h(1fr) #header])}else{
      locate(loc => if(loc.page() != 1) [#title #h(1fr) #info])
    }
  ]
  // 正文
  if(template in ("article")){
    set page(numbering: "1", number-align: center, header: pageheading,)
    mktitle(title)
    mkinfo(info)
    mkauthor(authors)
    mktime(time)
    mkabstruct(abstract, keywords)
    mkcontent(contents)
    body
  }else if(template in ("book", "report")){
    mktitle(title)
    mkinfo(info)
    mkauthor(authors)
    mktime(time)
    set page(numbering: "I", number-align: center,header: pageheading,)
    counter(page).update(1)
    mkabstruct(abstract, keywords)
    mkcontent(contents)
    set page(numbering: "1", number-align: center)
    counter(page).update(1)
    body
  }
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