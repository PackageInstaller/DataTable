__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Setup = readonly({
  Setup_117381_SetupTitle = {
    Text = "テキスト識別を確認"
  },
  Setup_126062_SetupTitle = {
    Text = "アウトライン"
  },
  Setup_132685_SetupDesc = {
    Text = "現在の言語設定で、どのストーリーが人力翻訳済みかを確認します。"
  },
  Setup_132685_SetupTitle = {
    Text = "「調査活動」正式翻訳済みチャプターの表示マーク"
  },
  Setup_134015_SetupTitle = {
    Text = "ログイン背景アニメーションの変更"
  },
  Setup_148459_SetupDesc = {
    Text = "同調率が20レベルに達した時、この覚醒体は「調査」または「対人戦」の戦闘中に特別なカード外観を表示する。"
  },
  Setup_148459_SetupTitle = {
    Text = "「輝き」効果"
  },
  Setup_18433_SetupTitle = {
    Text = "ゲームテキスト"
  },
  Setup_18434_SetupTitle = {
    Text = "アンチエイリアス"
  },
  Setup_18436_SetupTitle = {
    Text = "レンダリング精度"
  },
  Setup_18438_SetupTitle = {Text = "色収差"},
  Setup_18441_SetupTitle = {
    Text = "エンフェリン全回復"
  },
  Setup_18443_SetupTitle = {
    Text = "狂気解放とキーオーダーの使用確認"
  },
  Setup_18444_SetupTitle = {
    Text = "画像品質"
  },
  Setup_18445_SetupTitle = {
    Text = "被写界深度"
  },
  Setup_18448_SetupTitle = {
    Text = "シーンエフェクト"
  },
  Setup_18449_SetupTitle = {
    Text = "アカウント管理"
  },
  Setup_18453_SetupTitle = {Text = "ボイス"},
  Setup_18454_SetupTitle = {Text = "BGM"},
  Setup_18455_SetupTitle = {
    Text = "派遣完了"
  },
  Setup_18456_SetupTitle = {
    Text = "ブルーム効果"
  },
  Setup_18458_SetupTitle = {
    Text = "リアルタイムライティング"
  },
  Setup_18459_SetupTitle = {Text = "SE"},
  Setup_18460_SetupTitle = {
    Text = "利用規約"
  },
  Setup_18461_SetupTitle = {
    Text = "輪郭のぼかし"
  },
  Setup_18463_SetupTitle = {
    Text = "ギフトコード"
  },
  Setup_18466_SetupTitle = {
    Text = "エフェクト品質"
  },
  Setup_18469_SetupDesc = {
    Text = "30フレームは省エネモード、60フレームは滑らか。"
  },
  Setup_18469_SetupTitle = {
    Text = "フレームレート設定"
  },
  Setup_21931_SetupTitle = {
    Text = "カスタマーサポートに連絡"
  },
  Setup_24952_SetupDesc = {
    Text = "設定時、メイン画面や調査画面などが重力センサーの影響を受ける。"
  },
  Setup_24952_SetupTitle = {
    Text = "ジャイロスコープ"
  },
  Setup_54468_SetupTitle = {
    Text = "画面設定"
  },
  Setup_54469_SetupTitle = {Text = "解像度"},
  Setup_54664_SetupTitle = {
    Text = "ショートカットキーを表示"
  },
  Setup_54673_SetupTitle = {
    Text = "手札8を選択"
  },
  Setup_54674_SetupTitle = {
    Text = "手札9を選択"
  },
  Setup_54675_SetupTitle = {
    Text = "手札2を選択"
  },
  Setup_54676_SetupTitle = {
    Text = "手札3を選択"
  },
  Setup_54677_SetupTitle = {
    Text = "キーオーダーを発動"
  },
  Setup_54678_SetupTitle = {
    Text = "手札6を選択"
  },
  Setup_54679_SetupTitle = {
    Text = "手札7を選択"
  },
  Setup_54680_SetupTitle = {
    Text = "手札4を選択"
  },
  Setup_54681_SetupTitle = {
    Text = "手札5を選択"
  },
  Setup_54682_SetupTitle = {
    Text = "狂気解放1"
  },
  Setup_54683_SetupTitle = {
    Text = "狂気解放2"
  },
  Setup_54684_SetupTitle = {
    Text = "狂気解放3"
  },
  Setup_54685_SetupTitle = {
    Text = "狂気解放4"
  },
  Setup_54686_SetupTitle = {
    Text = "山札を確認"
  },
  Setup_54687_SetupTitle = {
    Text = "手札20を選択"
  },
  Setup_54688_SetupTitle = {
    Text = "ターン終了"
  },
  Setup_54689_SetupTitle = {
    Text = "手札1を選択"
  },
  Setup_54690_SetupTitle = {
    Text = "キャンセルと設定"
  },
  Setup_54691_SetupTitle = {
    Text = "界域能力を発動"
  },
  Setup_54692_SetupTitle = {
    Text = "手札10を選択"
  },
  Setup_54693_SetupTitle = {
    Text = "手札11を選択"
  },
  Setup_54694_SetupTitle = {
    Text = "手札12を選択"
  },
  Setup_54695_SetupTitle = {
    Text = "手札13を選択"
  },
  Setup_54696_SetupTitle = {
    Text = "手札14を選択"
  },
  Setup_54697_SetupTitle = {
    Text = "手札15を選択"
  },
  Setup_54698_SetupTitle = {
    Text = "手札16を選択"
  },
  Setup_54699_SetupTitle = {
    Text = "手札17を選択"
  },
  Setup_54700_SetupTitle = {
    Text = "手札18を選択"
  },
  Setup_54701_SetupTitle = {
    Text = "手札19を選択"
  },
  Setup_55509_SetupTitle = {
    Text = "ゲーム終了"
  },
  Setup_70541_SetupTitle = {
    Text = "バックグラウンド再生"
  },
  Setup_72153_SetupTitle = {
    Text = "界域能力2を解放する"
  },
  Setup_94404_SetupTitle = {
    Text = "カード確認"
  },
  Setup_94405_SetupTitle = {
    Text = "前のカード"
  },
  Setup_94406_SetupTitle = {
    Text = "次のカード"
  },
  Setup_94566_SetupTitle = {
    Text = "戦闘の動的背景"
  }
})
return Text_Setup
