__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_GuideConfig = readonly({
  GuideConfig_10_Content_1 = {
    Text = "少し先に<RedQuality:六つの銀色の翼を持つ巨体>が立っており、眩しい光を放っている"
  },
  GuideConfig_11_Content_1 = {
    Text = "私たちは、それと直接対峙することもできる……あるいは、ここに徘徊する怪物を一掃し、休憩所を探すこともできる。決めるのはあなたです、守秘者。"
  },
  GuideConfig_12_Content_1 = {
    Text = "指令カードを押し続けて上にドラッグすることで指令を出せます。"
  },
  GuideConfig_13_Content_1 = {
    Text = "敵が致命的ダメージを与える攻撃を準備している。防御命令を出して、守秘者！"
  },
  GuideConfig_14_Content_1 = {
    Text = "女王の剣を連続で使うことで、この局面を一気に打開できる。この一手で相手を倒してみるか？"
  },
  GuideConfig_15_Content_1 = {
    Text = "攻撃指令を実行すると狂気を獲得し、狂気が満ちると強力な狂気解放を使える。"
  },
  GuideConfig_1_Content_1 = {
    Text = "守秘者、今は前に進めます。"
  },
  GuideConfig_2_Content_1 = {
    Text = "ミサゴの休憩所です、シルバーキー共鳴することでライフを回復できます、これが私たちに必要なものです。"
  },
  GuideConfig_34_Content_1 = {
    Text = "まだ指令カードを出せます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_35_Content_1 = {
    Text = "まだ指令カードを出せます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_36_Content_1 = {
    Text = "まだ指令カードを出せます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_37_Content_1 = {
    Text = "まだ指令カードを出せます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_38_Content_1 = {
    Text = "まだ狂気解放を使用できます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_39_Content_1 = {
    Text = "まだ狂気解放を使用できます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_3_Content_1 = {
    Text = "<RedQuality:暴走する飛び立つ鯨>を早く倒せ、もうあんな悲劇は見たくない。"
  },
  GuideConfig_40_Content_1 = {
    Text = "まだ狂気解放を使用できます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_41_Content_1 = {
    Text = "まだ狂気解放を使用できます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_42_Content_1 = {
    Text = "まだキーオーダーを使用できます。戦闘チュートリアル完了後に自由にプレイできます。"
  },
  GuideConfig_47_Content_1 = {
    Text = "混沌界域はシルバーキーと強い共鳴を持ち、毎ターン250ポイントのシルバーキーエネルギーを獲得でき、「キーオーダー」がより速く発動します。チームに他の界域の覚醒体がいない場合、ステージ進入時にシルバー造物を1つ獲得します。造物の力を活用して敵を倒しましょう。"
  },
  GuideConfig_49_Content_1 = {
    Text = "深海界域は戦闘開始時に1本の触腕を生成します。\n触腕は各ターン終了時に前列の敵を攻撃します。\n\n深海覚醒体は触腕に様々な強化を付与できます。\n触腕アイコン下の数値で、現在の触腕ダメージを確認できます。"
  },
  GuideConfig_4_Content_1 = {
    Text = "黒章は密境の<Yellow:交換所>で交換することで、さまざまな<Yellow:遺物>を獲得でき、戦闘に役立ちます。"
  },
  GuideConfig_55_Content_1 = {
    Text = "血肉界域はターンごとに胚胎融合と深紅の炉を蓄積し、ライフが低いほど蓄積効率が上がります。胚胎融合度が上限に達すると、胚胎を生成して手札に追加します。胚胎は直接使用することで、対応する覚醒体に狂気と一時的な会心率を与えます。もしくは、血肉界域の覚醒体の狂気解放を行う時に捕食され、追加効果を発動できます。"
  },
  GuideConfig_57_Content_1 = {
    Text = "「深紅の炉」を使ってライフを回復し、攻撃に備えましょう！"
  },
  GuideConfig_58_Content_1 = {
    Text = "血肉界域の覚醒体が狂気解放を発動すると、\n手札の「胚胎」を捕食して狂気解放の効果を強化できます。\n「永遠の瞳」を発動し、捕食を発動してみましょう！"
  },
  GuideConfig_5_Content_1 = {
    Text = "<Yellow:交換所>を発見、蓄えた黒章を投入しなさい。"
  },
  GuideConfig_60_Content_1 = {
    Text = "超次元界域では、毎ターン最初に出した指令カードの一時的なコピーが超次元空間に入ります。超次元空間が上限に達すると、新たなターンに入ることができます。新たなターンではカードをドローせず、超次元空間のカードを手札に追加します。"
  },
  GuideConfig_60_TipsTitle_1 = {
    Text = "超次元界域"
  },
  GuideConfig_6_Content_1 = {
    Text = "これが<Yellow:遺物>だ、密境のものだ。すぐにその力を感じるだろう。残念ながら、遺物は密境を離れると消える。"
  },
  GuideConfig_7_Content_1 = {
    Text = "前方に<Yellow:事件>があるようだ。見に行こう。予想外の強化が獲得できるかもしれないが、代償が伴うこともある。"
  },
  GuideConfig_8_Content_1 = {
    Text = "前方にまだ敵がいるようだ。"
  },
  GuideConfig_9_Content_1 = {
    Text = "これは一方通行の通路だ、地下ロビーに通じている、行こう、私たちの使命を果たすために"
  }
})
return Text_GuideConfig
