这是AnZrew的typst模板，希望能够涵盖一般作业、实验、笔记等的需求。

# 使用方法

## 放在同一文件夹下

将`template.typ`放入同文件夹，并且在撰写的文档中使用
```typst
#import "template.typ": *
```
即可使用模板。

## 放置本地的Local packages中

也可以将改文件配置到本地的packages仓库中，参考[官方文档](https://github.com/typst/packages?tab=readme-ov-file#local-packages)。放置在`%APPDATA%\typst\packages\local\mytemplate\1.0.0`文件夹下，然后在文件夹中加入`typst.toml`文件，内容如下：
```toml
[package]
name = "mytemplate"
version = "1.0.0"
entrypoint = "template.typ"
authors = ["AnZreww"]
description = "AnZrew's typst template"
```
以使得编译器能够识别该模板。然后在文档中使用
```typst
#import "@local/mytemplate:1.0.0": *
```
来使用该模板。

# 模板

`project`函数是一个简单的模板函数，用来选择模板并生成标题页。

```typst
#show: project.with(
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
)
```
这是函数的参数和默认值。`template`是模板的名称，`title`是标题，`info`是副标题，`authors`是作者，`time`是时间，`abstract`是摘要，`keywords`是关键词，`contents`是是否生成目录，`content_depth`是目录的深度，`font_size`是正文字体大小。

目前支持：
- article：一般文档
- report：实验报告

# 其他模块

针对于其他问题，`template.typ`中还包含了一些其他的模块。

- `newpara()`

    针对于数学公式块、代码块后的段落缩进问题，可以使用`newpara()`函数。如果需要另起一段，可以使用`#newpara()`调用即可。

# TODO

- [x] 解决公式编号问题：默认有编号，可以通过`#set math.equation(numbering: none)`来取消公式的编号
- [x] 添加模板：Report
- [ ] 添加模板：Notes
- [ ] 添加更多的模块，例如：定理证明等等
- [ ] report的页眉无法正常显示章节名（暂时没有找到解决方案）