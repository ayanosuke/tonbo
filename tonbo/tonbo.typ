//--------------------------------------------------
// tonbo.typ
// Copyright(C)'2025 Ayanosuke(Maison de DCC)
// 
// Typstを使って印刷所で使用できるトンボ付き入稿データ（裁断・塗り足しOK）を作る手順
// https://qiita.com/masashi_214/items/bd4fa1474dc6e15ee0bd
// 
// This software is released under the MIT License.
// http://opensource.org/licenses/mit-license.php
//
// markly をベースに日本の印刷所用のトンボに対応
// https://typst.app/universe/package/markly/
// 
// Typst同人誌の骨子にあたる template.typ
// kanata様のtemplate.typを参考にさせてもらいました。
// https://techbookfest.org/organization/5642855536132096
// 
// 隠しノンブルの設定
// marimo様のTypstで技術同人誌を書こう！すぐに役立つ20のトピックを
// 参考にさせてもらいました。
// https://techbookfest.org/organization/2Lb8ait6GBQhyvKHB6d3rD
//--------------------------------------------------

#import "@preview/cetz:0.4.2"

#let marks(markly-context) = {

  // Extract from markly-context
  let stock-width = markly-context.at("stock-width")
  let stock-height = markly-context.at("stock-height")
  let stock-size = markly-context.at("stock-size")

  let content-width = markly-context.at("content-width")
  let content-height = markly-context.at("content-height")

  let bleed = markly-context.at("bleed")

  let bleed-marks = markly-context.at("bleed-marks")
  let cut-marks = markly-context.at("cut-marks")

  let mark-length = 10mm        // コーナートンボの長さ
  let mark-standoff = bleed       // コーナートンボの位置調整用
  let cut-mark-color = black
//  let bleed-mark-color = red
  let bleed-mark-color = black  // bleed(塗りたし)

  let slug-width  = (stock-width - content-width) / 2
  let slug-height = (stock-height - content-height) / 2

  let Line-Width = 0.2mm       // トンボ線の太さ

  let top-margin = markly-context.at("top-margin") // 余白設定
  let bottom-margin = markly-context.at("bottom-margin")
  let inside-margin = markly-context.at("inside-margin")
  let outside-margin = markly-context.at("outside-margin")

  let tonbo = markly-context.at("tonbo")

  cetz.canvas(
    length: 1pt,
    {
      import cetz.draw: *

      // This just ensures that we have a coordinate system that covers the whole page
      // grid((0,0), (612,792), stroke:none, step: 72)
      grid((0,0), (stock-width.pt(),stock-height.pt()), stroke:none, step: 72)

      // コーナートンボ作成　cut ライン
      let draw-marks(top-left, top-right, bottom-left, bottom-right, color:black) = {
        // Top Left 上左
        let from = top-left
        from.at(1) += mark-standoff
        let to = from
        to.at(1) += mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = top-left
        from.at(0) -= mark-standoff
        let to = from
        to.at(0) -= mark-length
        line(from, to, stroke: Line-Width + color)  //横線

        // Top Right 上右
        let from = top-right
        from.at(1) += mark-standoff
        let to = from
        to.at(1) += mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = top-right
        from.at(0) += mark-standoff
        let to = from
        to.at(0) += mark-length
        line(from, to, stroke: Line-Width + color)  //横線

        // Bottom Left 下左
        let from = bottom-left
        from.at(1) -= mark-standoff
        let to = from
        to.at(1) -= mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = bottom-left
        from.at(0) -= mark-standoff
        let to = from
        to.at(0) -= mark-length
        line(from, to, stroke: Line-Width + color)  //横線

        // Bottom Right 下右
        let from = bottom-right
        from.at(1) -= mark-standoff
        let to = from
        to.at(1) -= mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = bottom-right
        from.at(0) += mark-standoff
        let to = from
        to.at(0) += mark-length
        line(from, to, stroke: Line-Width + color)  //横線
      }

      // コーナートンボ作成 bleed（塗りたし）ライン
      let draw-marks-bleed(top-left, top-right, bottom-left, bottom-right, color:black) = {
        // Top Left 上左
        let from = top-left
        from.at(1) += mark-standoff - (bleed * 2)
        let to = from
        to.at(1) += mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = top-left
        from.at(0) -= mark-standoff - (bleed * 2)
        let to = from
        to.at(0) -= mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //横線

        // Top Right 上右
        let from = top-right
        from.at(1) += mark-standoff - (bleed * 2)
        let to = from
        to.at(1) += mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = top-right
        from.at(0) += mark-standoff - (bleed * 2)
        let to = from
        to.at(0) += mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //横線

        // Bottom Left 下左
        let from = bottom-left
        from.at(1) -= mark-standoff - (bleed * 2)
        let to = from
        to.at(1) -= mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = bottom-left
        from.at(0) -= mark-standoff - (bleed * 2)
        let to = from
        to.at(0) -= mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //横線

        // Bottom Right 下右
        let from = bottom-right
        from.at(1) -= mark-standoff - (bleed * 2)
        let to = from
        to.at(1) -= mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = bottom-right
        from.at(0) += mark-standoff - (bleed * 2)
        let to = from
        to.at(0) += mark-length + bleed
        line(from, to, stroke: Line-Width + color)  //横線
      }

      // 上下中央トンボ
     let draw-udcenter-tonbo(top_center, bottom_center, color:black) = {
        // Top 
        let from = top_center
        from.at(1) += mark-standoff
        let to = from
        to.at(1) += mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = top_center
        from.at(0) += mark-length
        from.at(1) += bleed
        let to = from
        to.at(0) -= mark-length * 2
        line(from, to, stroke: Line-Width + color)  //横線

        // Bottom
        let from = bottom_center
        from.at(1) -= mark-standoff
        let to = from
        to.at(1) -= mark-length
        line(from, to, stroke: Line-Width + color)  //縦線

        let from = bottom_center
        from.at(0) += mark-length
        from.at(1) -= bleed
        let to = from
        to.at(0) -= mark-length * 2
        line(from, to, stroke: Line-Width + color)  //横線
      }

      // 左右中央トンボ
     let draw-lrcenter-tonbo(left_center, right_center, color:black) = {
        // left (横線)
        let from = left_center
        from.at(0) -= bleed
        //from.at(1)
        let to = from
        to.at(0) -= mark-length //長さ
        //to.at(1)
        //　　　x横    　　y縦             x長さ  y長さ   
        //line((from.at(0),from.at(1)),(to.at(0),to.at(1)))
        line(from, to, stroke: Line-Width + color) //横線

        // left (縦線)     
        let from = left_center
        from.at(0) -= bleed
        from.at(1) += mark-length // mark_standoff
        let to = from
        //to.at(0)
        to.at(1) -=  mark-length * 2
        line(from, to, stroke: Line-Width + color) //縦線

        // right (横線)
        let from = right_center
        from.at(0) += bleed
        //from.at(1)
        let to = from
        to.at(0) += mark-length
        //to.at(1)
        line(from, to, stroke: Line-Width + color) //横線

        // right (縦線)  
        let from = right_center
        from.at(0) += bleed
        from.at(1) += mark-length
        let to = from
        to.at(1) -=  mark-length * 2
        line(from, to, stroke: Line-Width + color)//横線
      }
  if tonbo {
      // cut カットトンボ
//      if cut-marks {
        let cut-top-left = (slug-width, stock-height - slug-height)
        let cut-top-right = (stock-width - slug-width, stock-height - slug-height)
        let cut-bottom-left = (slug-width, slug-height)
        let cut-bottom-right = (stock-width - slug-width, slug-height)
        draw-marks(cut-top-left, cut-top-right, cut-bottom-left, cut-bottom-right)
//      }

      // bleed 塗りたしトンボ
//      if bleed-marks and bleed != 0pt {
        let bleed-top-left = (slug-width - bleed, stock-height - slug-height + bleed)
        let bleed-top-right = (stock-width - slug-width + bleed, stock-height - slug-height + bleed)
        let bleed-bottom-left = (slug-width - bleed, slug-height - bleed)
        let bleed-bottom-right = (stock-width - slug-width + bleed, slug-height - bleed)

        draw-marks-bleed(bleed-top-left, bleed-top-right, bleed-bottom-left, bleed-bottom-right, color:bleed-mark-color)
//      }

      // 上下中央トンボ
      let cut-top-center = (stock-width / 2, stock-height - slug-height)
      let cut-bottom-center = (stock-width / 2, slug-height)
      draw-udcenter-tonbo(cut-top-center, cut-bottom-center)

       // 左右中央トンボ
      let cut-left-center = (slug-width, stock-height /2)
      let cut-right-center = (stock-width - slug-width, stock-height/2)
      draw-lrcenter-tonbo(cut-left-center, cut-right-center)

  }
    }
  )
}

// This creates a background color that extends to the bleed line on the left and right
// これは、左右の裁ち落とし（ブリードライン）まで背景色を広げます。
#let to-bleed(body, markly-context, color: white, bg-color:blue.darken(30%), inset-y:12pt) = {

  // Extract from markly-context
  let margin-width = markly-context.at("margin-width")
  let bleed = markly-context.at("bleed")

  block(
    fill: bg-color,
    width: 100%,
    outset: (x: bleed+margin-width), // paints until bleed cutoff
    inset: (y:inset-y), // padding height for background color
    text(color, body)
  )
}


// This creates a background color that extends to the bleed line on the right
#let to-bleed-right(body, markly-context, color: white, bg-color:blue.darken(30%), padding:12pt) = {

  // Extract from markly-context
  let margin-width = markly-context.at("margin-width")
  let bleed = markly-context.at("bleed")

  block(
    fill: bg-color,
    width: 100%,
    outset: (right: bleed+margin-width), // paints until bleed cutoff
    inset: (left:padding, y:padding), // padding height for background color
    text(color, body)
  )
}

// This creates a background color that extends to the bleed line on the left
#let to-bleed-left(body, markly-context, color: white, bg-color:blue.darken(30%), padding:12pt) = {

  // Extract from markly-context
  let margin-width = markly-context.at("margin-width")
  let bleed = markly-context.at("bleed")

  block(
    fill: bg-color,
    width: 100%,
    outset: (left: bleed+margin-width), // paints until bleed cutoff
    inset: (right:padding, y:padding), // padding height for background color
    text(color, body)
  )
}

#let img-to-bleed(img-data, markly-context) = {

  // Extract from markly-context
  let margin-width = markly-context.at("margin-width")
  let margin-height = markly-context.at("margin-height")
  let bleed = markly-context.at("bleed")

  place(
    top + left,
    dx: -(margin-width+bleed),
    dy: -(margin-height+bleed),
    image(
      bytes(img-data),
      width:100%+margin-width*2+bleed*2,
      height:100%+margin-height*2+bleed*2)
  )
}
//------------------------------------------------------------------
// Setup function
//------------------------------------------------------------------ 
#let setup(
  tonbo: true,            // とんぼ（トンボ）を表示するかどうかを設定します。 true,false
  //stock-size: "A4",       // 印刷する用紙サイズを設定します。
  //content-size: "B5",     // 書籍の用紙サイズを設定します。
  stock-size: "B5",       // 印刷する用紙サイズを設定します。
  content-size: "A5",     // 書籍の用紙サイズを設定します。

  stock-width:    182mm,  // 値はダミー
  stock-height:   257mm,  // 値はダミー
  content-width:  148mm,  // 値はダミー
  content-height: 210mm,  // 値はダミー

  // 塗り足しマーク（bleed marks）と断裁マーク（cut marks）の間隔を設定する
  bleed: 3mm,             // 塗りたし 

  // 断裁マーク（たちきり）（cut marks）とテキストとの距離を設定する
  // 2025/11/15 margin: で使ってないので、削除方向
  //margin-width: 3mm,
  //margin-height: 3mm,
  margin-width:   5mm,
  margin-height:  5mm,

  // content-size 書籍の用紙サイズに適用する余白の設定
  top-margin:     15mm,   // 上余白(天)
  bottom-margin:  15mm,   // 下余白(地)
  inside-margin:  20mm,   // ページ内側の余白(のど、とじしろ)
  outside-margin: 12mm,   // ページ外側の余白(小口)

  bleed-marks:  true,     // bleed 塗りたしトンボ 表示有効/無効フラグ
  cut-marks:    true,     // cut カットトンボ 表示有効/無効フラグ
) = {

  let markly-context = (:)  // 空の辞書を代入

  if tonbo == true {
    // 印刷する用紙サイズを設定します。
    if stock-size == "A5" {
      stock-width = 148mm
      stock-height = 210mm
    } else if stock-size == "B5" {
      stock-width = 182mm
      stock-height = 257mm
    } else if stock-size == "A4" {
      stock-width = 210mm
      stock-height = 297mm
    }

  } else {  // tonbo が無効な時は、大きさを stock = content するとトンボが表示されない 
    if content-size == "A5" {
      stock-width = 148mm
      stock-height = 210mm
    } else if scontent-size == "B5" {
      stock-width = 182mm
      stock-height = 257mm
    } else if content-size == "A4" {
      stock-width = 210mm
      stock-height = 297mm
    }
 }
  // 書籍の用紙サイズを設定します。
  if content-size == "A5" {
    content-width = 148mm
    content-height = 210mm
  } else if content-size == "B5" {
    content-width = 182mm
    content-height = 257mm
  }

  // markly-context の辞書に値を設定する
  markly-context.insert("stock-size", stock-size)
  markly-context.insert("stock-height", stock-height)
  markly-context.insert("stock-width",  stock-width)

  markly-context.insert("content-height", content-height)
  markly-context.insert("content-width",  content-width)

  markly-context.insert("margin-height", margin-height)
  markly-context.insert("margin-width",  margin-width)

  markly-context.insert("bleed",  bleed)

  markly-context.insert("bleed-marks", bleed-marks)
  markly-context.insert("cut-marks",  cut-marks)

  markly-context.insert("top-margin", top-margin) 
  markly-context.insert("bottom-margin",bottom-margin)
  markly-context.insert("inside-margin",inside-margin)
  markly-context.insert("outside-margin",outside-margin)

  markly-context.insert("tonbo",tonbo)

  return markly-context
}

#let page-setup(markly-context, body) = {
  set page(
    //トンボの設定
    width: markly-context.at("stock-width"),    // stock 印刷用紙サイズ
    height: markly-context.at("stock-height"),

    margin: (
      top: (markly-context.at("stock-height") - markly-context.at("content-height")) / 2 + markly-context.at("top-margin") ,       //上余白(天)
      
      bottom: (markly-context.at("stock-height") - markly-context.at("content-height")) / 2 + markly-context.at("bottom-margin") ,    // 下余白(地)

      inside: (markly-context.at("stock-width") - markly-context.at("content-width")) / 2 + markly-context.at("inside-margin"),     // ページ内側の余白(のど、とじしろ)

      outside: (markly-context.at("stock-width") - markly-context.at("content-width")) / 2 + markly-context.at("outside-margin"),    // ページ外側の余白(小口)
    ),
    //トンボの設定
    background: if markly-context.at("tonbo") {marks(markly-context) },
    //隠しノンブルの設定
    //marimo様のTypstで技術同人誌を書こう！すぐに役立つ20のトピックを参考にさせてもらいました。
    header: if markly-context.at("tonbo") { 
      context {
        if calc.odd(here().page()){ // 奇数ページ
          [
            #set text(7pt,font: "Arial") 
            #place(left, dx:-markly-context.at("inside-margin"), dy:markly-context.at("stock-height")/2)[#rotate(-90deg)[#here().page()]]
          ]
        } else {                    // 偶数ページ
          [
            #set text(7pt,font: "Arial")
            #place(right, dx: markly-context.at("inside-margin"), dy:markly-context.at("stock-height")/2)[#rotate(-90deg)[#here().page()]]
          ]
        }
      }
    },
    //書籍スタイルの設定、ここに記載しなくても良い方法があれば・・・
    columns: 1,           // 段組み
    numbering: "1",       // ページ番号（ノンブル）
    number-align: center, // ページ番号（ノンブル）の位置     
  )
  body
}
