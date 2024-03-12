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
  preface: none,
  contents: false,
  content_depth: 2,
  font_size: 11pt,
  body
)
```
这是函数的参数和默认值。这些参数的含义：
```typst
template: str      //选择模板，目前支持article、report、book
title: str         //标题
info: str          //信息，例如副标题、课程名、教师名等（可选）
authors: arr(str)  //作者（）
time: str          //时间
abstract: str      //摘要（可选）
keywords: arr(str) //关键词（可选）
preface: str       //前言（可选）
contents: bool     //是否生成目录（缺省值，可以不写）
content_depth: int //目录深度（缺省值，可以不写）
font_size: lengt   //字体大小（缺省值，可以不写）
```

目前支持：
- article：一般文档
- report：实验报告
- book：笔记、书籍

具体使用方法如下。
## article

有效的参数有：
```typst
template: "article",//（缺省值，可以不写）
title: "",
info:"",            //（可选）
authors: (),
time: "",
abstract: none,     //（可选）
keywords: (),       //（可选）
contents: false,    //（缺省值，可以不写）
content_depth: 2,   //（缺省值，可以不写）
font_size: 11pt,    //（缺省值，可以不写）
```
标题、（信息、）作者、时间、（摘要、关键词、目录）会依次写在标题页上。

具体效果详见[demo](demo/article.pdf)。

## report

有效的参数有：
```typst
template: "report",//（缺省值，可以不写）
title: "",
info:"",            //（可选）
authors: (),
time: "",
abstract: none,     //（可选）
keywords: (),       //（可选）
contents: false,    //（缺省值，可以不写）
content_depth: 2,   //（缺省值，可以不写）
font_size: 11pt,    //（缺省值，可以不写）
```
标题、（信息、）作者、时间，作为封面；（摘要、关键词、目录）会生成在目录页上。

具体效果详见[demo](demo/report.pdf)。

## book

有效的参数有：
```typst
template: "book",//（缺省值，可以不写）
title: "",
info:"",            //（可选）
authors: (),
time: "",
preface: none,      //（可选）
contents: false,    //（缺省值，可以不写）
content_depth: 2,   //（缺省值，可以不写）
font_size: 11pt,    //（缺省值，可以不写）
```
标题、（信息、）作者、时间，作为封面；（前言）会生成在前言页上；（目录）会生成在目录页上。

具体效果详见[demo](demo/book.pdf)。

# 其他模块

针对于其他问题，`template.typ`中还包含了一些其他的模块。

- `newpara()`

    针对于数学公式块、代码块后的段落缩进问题，可以使用`newpara()`函数。如果需要另起一段，可以使用`#newpara()`调用即可。

# TODO

- [x] 解决公式编号问题：默认有编号，可以通过`#set math.equation(numbering: none)`来取消公式的编号
- [x] 添加模板：Report
- [x] 添加模板：Notes
- [ ] 添加更多的模块，例如：定理证明等等
- [ ] report的页眉无法正常显示章节名（暂时没有找到解决方案）