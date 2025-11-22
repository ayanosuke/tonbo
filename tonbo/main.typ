#import "template.typ": * // テンプレートのインポート
#show: init // テンプレートの初期設定処理

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


#display_title() // タイトルの表示
#pagebreak() // ページの区切り
#display_table_of_contents() // 目次の表示

#pagebreak() // ページの区切り
#include "chapter01.typ" // 1章のインポート
#pagebreak() // ページの区切り
#include "chapter02.typ" // 2章のインポート

#pagebreak() // ページの区切り
#display_colophon() // 奥付の表示

