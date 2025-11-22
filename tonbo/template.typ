// 技術同人誌用テンプレート ver 2.12
// kanata
// https://techbookfest.org/organization/5642855536132096
// 
//　2025/11/13　あやの　tonbo.typ用に set page() のコメントアウトを追加
// set text() に Mac用のフォントを追加

//--------------------
//  バージョンチェック
//--------------------
// Typst ver 0.12以前の古いバージョンでは動作しません
#if not sys.version >= version(0, 13, 0) {
  panic("This template requires typst 0.13.0 or newer (current version " + array(sys.version).map(str).join(".") + ")")
} 

//--------------------
//      import
// https://typst.app/universe
//--------------------
// https://typst.app/universe/package/codelst
#import "@preview/codelst:2.0.2": sourcecode
// https://typst.app/universe/package/gentle-clues/
#import "@preview/gentle-clues:1.2.0": *
// https://typst.app/universe/package/rubby/
#import "@preview/rubby:0.10.2": get-ruby
// https://typst.app/universe/package/hydra/
#import "@preview/hydra:0.6.0": hydra

//--------------------
//    初期設定関数
//--------------------
#let init(body) = {
  //--------------------
  //     ページ設定
  // https://typst.app/docs/reference/layout/page/
  //--------------------
/*
  set page(
    paper: "a5", // 用紙サイズ
    flipped: false, // 用紙の向き（縦）
    binding: left, // ページの綴じ（技術書は左綴じ）
    margin: (
      // 余白設定
      top: 15mm, // 上余白(天)
      bottom: 15mm, // 下余白(地)
      inside: 20mm, // ページ内側の余白(のど、とじしろ)
      outside: 12mm, // ページ外側の余白(小口)
    ),
    columns: 1, // 段組み
    numbering: "1", // ページ番号（ノンブル）
    number-align: center, // ページ番号（ノンブル）の位置
  )
*/  
  //--------------------
  // 天に章の情報を表現する
  // 詳細は本書の第5章参照
  //--------------------
  set page(
    header: context {
      if calc.odd(here().page()) {
        align(right)[#text(size: 0.8em)[#underline(hydra(1))]]
      } else {
        align(left)[#h(-0.8em)#text(size: 0.8em)[#underline(hydra(1))]]
      }
    },
  )
  //--------------------
  //    フォント設定
  // https://typst.app/docs/reference/text/text/
  //--------------------
  set text(
    // 記載の順にフォントを検索します
    font: ("Meiryo UI", "Yu Gothic", "Arial"), // フォント設定
    /* フォント候補
      "Arial","New Computer Modern","Tahoma",
      "Times New Roman","Verdana",
      "Meiryo","Meiryo UI",
      "Yu Gothic","Yu Gothic UI","Yu Mincho",
    */
    size: 9pt, // フォントサイズ
    lang: "jp", // 言語
  )
  // コードブロック内のフォント指定
  show raw: set text(
    font: ("Lucida Console", "Meiryo UI", "Yu Gothic"), // フォント設定
    /* コードブロック内のフォント候補（等幅フォント推奨）
    "BIZ UDGothic","Consolas","Lucida Console",
    "MS Gothic",
    */
    //size: 8pt, // フォントサイズ
  )
  //--------------------
  //      段落設定
  // https://typst.app/docs/reference/model/par/
  //--------------------
  set par(
    leading: 0.8em, // 行間
    justify: true, // 両端揃え
    linebreaks: auto, // 改行の判断方法
    first-line-indent: (amount: 1.0em, all: true), // 全段落の最初の行のインデント
  )
  //--------------------
  //     見出し設定
  // https://typst.app/docs/reference/layout/block/
  //--------------------
  // 章、節、項の自動採番
  //#set heading(
  //    numbering: " 1.1.1 ",
  //)
  // 章の見た目をカスタマイズする
  //#show heading.where(level: 1): block.with(
  //  width: 100%,
  //  stroke: (
  //    left: (thickness: 6pt, paint: luma(110), cap: "butt") ,
  //    bottom:(thickness: 0.8pt, paint: luma(140), cap: "butt"),
  //  ),
  //  inset: 5pt,
  //)
  // 節の見た目をカスタマイズする
  show heading.where(level: 2): block.with(
    width: 100%,
    stroke: (
      left: (thickness: 6pt, paint: luma(140), cap: "butt"),
      bottom: (thickness: 0.8pt, paint: luma(170), cap: "butt"),
    ),
    inset: 5pt,
  )
  // 項の見た目をカスタマイズする
  show heading.where(level: 3): block.with(
    width: 100%,
    stroke: (
      //left: (thickness: 6pt, paint: luma(140), cap: "butt") ,
      bottom: (thickness: 0.8pt, paint: luma(120), cap: "butt" /*dash: "densely-dashed",*/),
    ),
    inset: 4pt,
  )
  //--------------------
  //    PDFメタデータ
  // https://typst.app/docs/reference/model/document/
  //--------------------
  set document(
    title: "ほげほげほげほげほげほげ（書籍タイトル）", // タイトル
    author: "Your name", // 著者
    date: auto, // 日付
    description: "書籍の説明を記載" // 説明
  )
  //--------------------
  //     目次設定
  //--------------------
  show outline.entry.where(level: 1): it => {
    v(14pt, weak: true)
    strong(it)
  }

  body
}

//--------------------
//  タイトル表示関数
//--------------------
#let display_title() = [
  \ \ \
  #align(center)[
    #text(
      font: "Meiryo UI", // フォント
      size: 18pt, // フォントサイズ
      lang: "jp", // 言語
    )[*ほげほげほげほげほげほげ（書籍タイトル）*]
    \ \
    #text(
      font: "Meiryo UI", // フォント
      size: 13pt, // フォントサイズ
      lang: "jp", // 言語
    )[*ふがふがふがふが（書籍サブタイトル）*]
    \ \
    #text(
      font: "Meiryo UI", // フォント
      size: 13pt, // フォントサイズ
      lang: "jp", // 言語
    )[Your name]
  ]
]
//--------------------
// 見出しのカスタマイズ関数
//--------------------
#let chapter_counter = counter("chapter_level1_counter") // 見出し用のカウンタの定義

//
// 見出し第1レベル（タイプ1）
//
#let display_chapter_type1(count: 99, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #text(size: 1.6em)[#h(-8pt)第 #count 章]\ \
  #text(size: 2.0em)[#body]

  #v(25pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ2）
//
#let display_chapter_type2(count: 99, image_path: none, body) = [
  #context[
    #if image_path == none {
      [No back ground image]
    } else {
      if page.margin == auto {
        // page.marginを設定していない場合、デフォルトはauto（短辺の2.5/21倍）
        place(dx: - 2.5 / 21 * calc.min(page.width,page.height), dy: - 2.5 / 21 * calc.min(page.width,page.height))[#image(image_path, width: page.width)]
      }else{
        // page.marginを設定している場合、偶数ページと奇数ページを考慮して調整
        if calc.odd(counter(page).at(here()).first()) {
          place(dx: - page.margin.at("inside"), dy: - page.margin.at("top"))[#image(image_path, width: page.width)]
        }else{
          place(dx: - page.margin.at("outside"), dy: - page.margin.at("top"))[#image(image_path, width: page.width)]
        }
      }
    }
  ]

  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #text(size: 1.6em)[#h(-8pt)第 #count 章]\ \
  #text(size: 2.0em)[#body]

  #v(25pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ3）
//
#let display_chapter_type3(count: 99, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #align(center)[
    #block(
      width: 100%,
      inset: 20pt,
      stroke: (
        top: (thickness: 6pt, paint: luma(100), cap: "butt"),
        bottom: (thickness: 6pt, paint: luma(100), cap: "butt"),
      ),
    )[
      #text(size: 1.6em)[#h(-8pt)第 #count 章]\ \
      #text(size: 2.0em)[#body]
    ]
  ]

  #{ "" } // 最初の段落の字下げ対応
  #v(5pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ4）
//
#let display_chapter_type4(count: 99, sub_title: none, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #block(
    width: 100%,
    outset: 12pt,
    fill: luma(220),
  )[
    #text(size: 1.2em)[第#count 章 #sub_title]
    #v(-7pt)
    #line(length: 100%)
    #h(0pt)#text(size: 2.0em)[#body]
  ]

  #{ "" } // 最初の段落の字下げ対応
  #v(5pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ5）
//
#let display_chapter_type5(count: 99, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）
  #context {
    if calc.odd(counter(page).at(here()).first()) {
      block(
        width: 100%,
        inset: 5pt,
        stroke: (
          right: (thickness: 25pt, paint: black, cap: "butt"),
        ),
      )[
        #align(right)[
          #text(
            size: 1.2em,
            font: "Mongolian Baiti", //"BIZ UDPMincho"
          )[#text(size: 1.4em)[C]HAPTER #text(size: 1.4em)[#count]]#h(20pt)

          #text(size: 2.0em)[#body]#h(20pt)
        ]
      ]
    } else {
      block(
        width: 100%,
        inset: 5pt,
        stroke: (
          left: (thickness: 25pt, paint: black, cap: "butt"),
        ),
      )[
        #align(left)[
          #text(
            size: 1.2em,
            font: "Mongolian Baiti", //"BIZ UDPMincho"
          )[#h(20pt)#text(size: 1.4em)[C]HAPTER #text(size: 1.4em)[#count]]

          #h(10pt)#text(size: 2.0em)[#body]
        ]
      ]
    }
  }
  #{ "" } // 最初の段落の字下げ対応
  #v(5pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ6）
//
#let display_chapter_type6(count: 99, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）
  #context {
    if calc.odd(counter(page).at(here()).first()) {
      block(
        width: 96%,
        inset: 5pt,
        stroke: (
          right: (thickness: 30pt, paint: gradient.linear(white, black, angle: 270deg), cap: "butt"),
        ),
      )[
        #align(right)[
          #text(
            size: 1.6em,
            font: "Mongolian Baiti", //"BIZ UDPMincho"
          )[
            #text(size: 1.2em)[C]HAPTER #text(size: 3.6em,font: "Sitka Text")[#count]
          ]#h(20pt)
        ]
      ]
    } else {
      block(
        width: 96%,
        inset: 5pt,
        stroke: (
          left: (thickness: 30pt, paint: gradient.linear(white, black, angle: 270deg), cap: "butt"),
        ),
      )[
        #align(left)[
          #text(
            size: 1.6em,
            font: "Mongolian Baiti", //"BIZ UDPMincho"
          )[
            #h(20pt)#text(size: 1.2em)[C]HAPTER #text(size: 3.6em,font: "Sitka Text")[#count]
          ]
        ]
      ]
    }
  }

  #align(center)[
    #text(size: 2.0em)[#body]
  ]

  #v(10pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ7）
//
#let display_chapter_type7(body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #block(
    width: 100%,
    inset: 8pt,
    stroke: (
      top: (thickness: 1pt, paint: black, cap: "butt"),
      right: (thickness: 8pt, paint: black, cap: "butt"),
      left: (thickness: 8pt, paint: black, cap: "butt"),
      bottom: (thickness: 1pt, paint: black, cap: "butt"),
    ),
  )[
    #h(5pt)#text(size: 1.6em)[#body]
  ]

  #{ "" } // 最初の段落の字下げ対応
  #v(-15pt) // 余白の調整
]

//
// 見出し第1レベル（タイプ8）
//
#let display_chapter_type8(count: 99, body) = [
  #show heading.where(level: 1): set text(size: 0em) // 第1レベルの見出しを表示させない（デフォルト1.4em）
  = #body // サイズ0ptで描画（表示されない）

  #block(
    width: 100%,
    radius: 7pt,
    stroke: (
      top: (thickness: 1pt, paint: black, cap: "butt"),
      right: (thickness: 1pt, paint: black, cap: "butt"),
      left: (thickness: 1pt, paint: black, cap: "butt"),
      bottom: (thickness: 1pt, paint: black, cap: "butt"),
    ),
  )[
    #stack(
      dir: ltr,
      rect(
        fill: black,
        radius: (left: 7pt),
      )[
        #text(size: 2.5em, fill: white, font: "Sitka Text")[#count]
      ],
      rect(
        stroke: none,
        inset: 7pt,
      )[
        #text(size: 1.6em)[#body]
      ],
    )
  ]

  #{ "" } // 最初の段落の字下げ対応
  #v(-15pt) // 余白の調整
]

//--------------------
//    目次表示関数
//--------------------
#let display_table_of_contents() = [
  #outline(
    title: "目次",
    depth: 3,
    indent: 2em,
  )
]

//--------------------
//   その他の諸設定
//--------------------
// カギカッコがどうしても字幅が変になる対応（フォントに依存）
//#show regex("「") : " 「"
//#show regex("」") : "」 "
// 句点の後ろが詰まりすぎている感じがする対応（フォントに依存）
//#show regex("。") : [。#h(0.3em)]

// TeXの字形
#let TeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(
    width: 1.7em,
    {
      block[T]
      place(top, dx: 0.56em, dy: 0.22em)[E]
      place(top, dx: 1.1em)[X]
    },
  )
}

// LaTeXの字形
#let LaTeX = {
  set text(font: "New Computer Modern", weight: "regular")
  box(
    width: 2.55em,
    {
      block[L]
      place(top, dx: 0.3em, text(size: 0.7em)[A])
      place(top, dx: 0.7em)[#TeX]
    },
  )
}

//--------------------
//      奥付表示
//--------------------
#let display_colophon() = [
  // hydraで表示した見出し情報をこのページだけは表示しない（白い四角で覆い隠す）
  #place(top + left,dx: -20pt,dy: -30pt,rect(fill: white, width:130%))
  \ \ \ \ \ \ \ \ \ \ \ \ // 改行で奥付の位置調整
  #text(
    font: "Meiryo UI", // フォント
    size: 12pt, // フォントサイズ
    lang: "jp", // 言語
  )[ほげほげほげほげほげほげ（書籍タイトル）]
  #line(length: 38em, stroke: 1pt) // 罫線
  #table(
    columns: (6em, auto),
    stroke: none,
    table.cell(colspan: 2)[2099年99月99日 初版発行],
    [], [],
    [発行者], [Your company],
    [著者], [Your name],
    [連絡先], [𝕏(旧Twitter): \@Your ID],
    [印刷会社], [ほげほげ出版],
  )
  #line(length: 38em, stroke: 1pt) // 罫線
]

//--------------------
//       本文
//--------------------
#show: init      // 初期設定

#import "tonbo.typ"
#let markly-context = tonbo.setup(
  tonbo: true,            // とんぼ（トンボ）を表示するかどうかを設定します。 true,false
  //stock-size: "A4",       // 印刷する用紙サイズを設定します。
  //content-size: "B5",     // 書籍の用紙サイズを設定します。
  stock-size: "B5",       // 印刷する用紙サイズを設定します。
  content-size: "A5",     // 書籍の用紙サイズを設定します。

  // 余白の設定
  top-margin:     15mm,   // 上余白(天)
  bottom-margin:  15mm,   // 下余白(地)
  inside-margin:  20mm,   // ページ内側の余白(のど、とじしろ)
  outside-margin: 12mm,   // ページ外側の余白(小口)
)
#show: tonbo.page-setup.with(markly-context)

#display_title() // タイトル表示（修正・カスタマイズは155行目～）
#pagebreak()     // 改ページ
#display_table_of_contents() // 目次表示（修正・カスタマイズは144行目～および436行目～）
#pagebreak()     // 改ページ

ここに文章を書くこともできます。
このファイルをテンプレートとして読み込んで、別のファイルに書くこともできます。
テンプレートとして読み込んだ場合は、このファイルの505行目以降（本文以降）は表示されません。
テンプレートとして読み込んで、別のファイルに書くサンプルは、以下を参照してください。
 - main.typ
 - chapter01.typ
 - chapter02.typ

#pagebreak()    // 改ページ
#display_colophon() // 奥付表示（修正・カスタマイズは482行目～）

// 以降はサンプルです。確認後削除してください。
//--------------------
//      sample
//--------------------
#pagebreak()

= サンプル

= 見出し1
== 見出し2
=== 見出し3
==== 見出し4

- コードブロック

```c
    #include <stdio.h>

    int main() {
        printf("Hello, World!\n");
        return 0;
    }
```

- コードブロック

#sourcecode[```c
    #include <stdio.h>

    int main() {
        printf("Hello, World!\n");
        return 0;
    }
```]

- 箇条書き

+ 数字連番の箇条書き
  - 黒点の箇条書き
+ 数字連番の箇条書き
  - 黒点の箇条書き
+ 数字連番の箇条書き
  - 黒点の箇条書き

- 説明

/ 用語: 説明

- 強調

*こんな感じ*になります

- 斜体

_こんな感じabc_ abcになります

 \ // 改行
- コメント

```
/* hoge */または// hoge
```

- 表

#figure(
  table(
    columns: (1fr, auto, auto),
    inset: 10pt,
    align: horizon,
    table.header(
      [], [*Area*], [*Parameters*],
    ),
    "テストA",
    $ pi h (D^2 - d^2) / 4 $,
    [
      $h$: height \
      $D$: outer radius \
      $d$: inner radius
    ],
    "テストB",
    $ sqrt(2) / 12 a^3 $,
    [$a$: edge length]
  ),
  caption: [ 表の名称とかを書く ],
  kind: "table",
  supplement: [表]
)

- 画像

#figure(
  image("Gemini_Generated_Image_c51nfgc51nfgc51n.png", width: 50%),
  caption: [ 画像の説明とかを書く ],
    kind: "image",
  supplement: [図]
)

- 脚注

メロスは激怒した。#footnote[なおこの後セリヌンティウスがとばっちりを受けます]必ず、

#pagebreak() // 改ページ
- gentle-clues

#info[ テスト ... ] 
#tip(title: "テスト１")[テスト２]
#clue(title: "テスト３", icon: none, accent-color: orange)[テスト４]

#pagebreak() // 改ページ
#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type1(count: context chapter_counter.display())[見出しサンプル：組版とは（タイプ
1）]

#lorem(16) // ダミー文章の表示

== 見出しサンプル：見出し2

#lorem(16) // ダミー文章の表示

=== 見出しサンプル：見出し3

#lorem(16) // ダミー文章の表示

==== 見出しサンプル：見出し4

#lorem(16) // ダミー文章の表示

#pagebreak() // 改ページ
#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type2(count: context chapter_counter.display(), image_path: "Gemini_Generated_Image_c51nfgc51nfgc51n.png")[見出しサンプル：組版とは（タイプ 2）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type3(count: context chapter_counter.display())[見出しサンプル：組版とは（タイプ
3）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type4(count: context chapter_counter.display(),sub_title: "hoge さんの考える")[見出しサンプル：組版とは（タイプ 4）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#pagebreak() // 改ページ

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type5(count: context chapter_counter.display())[見出しサンプル：組版とは（タイプ
5）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type6(count: context chapter_counter.display())[見出しサンプル：組版とは（タイプ
6）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type7()[見出しサンプル：組版とは（タイプ 7）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整

#chapter_counter.step() // 章番号のカウントアップ
#display_chapter_type8(count: context chapter_counter.display())[見出しサンプル：組版とは（タ
イプ 8）]

#lorem(16) // ダミー文章の表示
#v(4em) // 余白の調整
