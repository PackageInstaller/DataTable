__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_ActorAttrType = readonly({
  ActorAttrType_121209_AttributeDesc = {
    Text = "禁忌学識レベルは秘密守護者のレベルと一致し、以下の3種類の研究深度の効果を決定する。編成した覚醒体の平均レベルが秘密守護者のレベル以上の場合、禁忌学識レベルは編成した覚醒体の平均レベルと秘密守護者のレベルの平均値となる。\n生体研究深度：<Blue:{s1}>\n·覚醒体の体質属性100ポイントごとにチームHPへ変換する効果の強度を決定する。\n物象研究深度：<Blue:{s2}>\n·造物·刻印·鍵令による力·触腕ダメージ·シールド·HP回復·力低下系効果の強度を決定する。\n霊識研究深度：<Blue:{s3}>\n·造物·刻印·鍵令による固定中毒·固定反撃·固定ダメージ·固定出血系効果の強度を決定する。\n"
  },
  ActorAttrType_121209_Text = {
    Text = "禁忌学識レベル"
  },
  ActorAttrType_18103_Text = {
    Text = "覚醒体のシールド値"
  },
  ActorAttrType_18104_Text = {
    Text = "攻撃カードのダメージパーセンテージ修正"
  },
  ActorAttrType_18105_AttributeUpText = {
    Text = "クリティカルダメージ+{s1}"
  },
  ActorAttrType_18105_Text = {
    Text = "クリティカルダメージ"
  },
  ActorAttrType_18106_Text = {
    Text = "シールドの増加"
  },
  ActorAttrType_18107_AttributeUpText = {
    Text = "攻撃力+{s1}"
  },
  ActorAttrType_18107_Text = {Text = "攻撃力"},
  ActorAttrType_18108_Text = {Text = "体力"},
  ActorAttrType_18109_Text = {
    Text = "カードのダメージパーセンテージ修正"
  },
  ActorAttrType_18110_Text = {
    Text = "抑圧割合修正"
  },
  ActorAttrType_18111_Text = {
    Text = "シールド割合修正"
  },
  ActorAttrType_18112_AttributeUpText = {
    Text = "防御力+{s1}"
  },
  ActorAttrType_18112_Text = {
    Text = "防御力増加"
  },
  ActorAttrType_18113_AttributeDesc = {
    Text = "覚醒体の狂気チャージ増加効率"
  },
  ActorAttrType_18113_Text = {
    Text = "初期狂気値"
  },
  ActorAttrType_18114_AttributeDesc = {
    Text = "体力が高いほど、覚醒体の最大ライフが増加。\n調査レベルが高い程、体力が覚醒体の最大ライフに与える影響が強くなる。"
  },
  ActorAttrType_18114_AttributeUpText = {
    Text = "体力+{s1}"
  },
  ActorAttrType_18114_Text = {Text = "体力"},
  ActorAttrType_18115_AttributeDesc = {
    Text = "覚醒体が真貌顕現を解放した後、返還された狂気値"
  },
  ActorAttrType_18115_AttributeUpText = {
    Text = "狂気消費減少+{s1}"
  },
  ActorAttrType_18115_Text = {
    Text = "狂気消費減少"
  },
  ActorAttrType_18116_AttributeDesc = {
    Text = "体力が高いほど、覚醒体の最大ライフが増加。\n調査レベルが高い程、体力が覚醒体の最大ライフに与える影響が強くなる。"
  },
  ActorAttrType_18116_AttributeUpText = {
    Text = "体力+{s1}"
  },
  ActorAttrType_18116_Text = {
    Text = "体力増加"
  },
  ActorAttrType_18117_Text = {
    Text = "触腕ダメージ"
  },
  ActorAttrType_18118_Text = {
    Text = "超次元カードスロット数"
  },
  ActorAttrType_18119_Text = {
    Text = "被ダメージ割合修正"
  },
  ActorAttrType_18120_AttributeDesc = {
    Text = "覚醒体の最大蓄積狂気量と、狂気解放時の消費狂気量は、いずれも基礎狂気に等しい。"
  },
  ActorAttrType_18120_AttributeUpText = {
    Text = "狂気上限+{s1}"
  },
  ActorAttrType_18120_Text = {
    Text = "基礎狂気"
  },
  ActorAttrType_18121_AttributeDesc = {
    Text = "スキル2レベル"
  },
  ActorAttrType_18121_AttributeUpText = {
    Text = "スキル2レベル+{s1}"
  },
  ActorAttrType_18121_Text = {
    Text = "スキル2レベル"
  },
  ActorAttrType_18122_AttributeDesc = {
    Text = "防御レベル"
  },
  ActorAttrType_18122_AttributeUpText = {
    Text = "防御レベル+{s1}"
  },
  ActorAttrType_18122_Text = {
    Text = "防御レベル"
  },
  ActorAttrType_18123_Text = {
    Text = "ダメージ回数固定値修正"
  },
  ActorAttrType_18124_Text = {
    Text = "シールドの固定値修正"
  },
  ActorAttrType_18125_Text = {
    Text = "シールド固定値修正"
  },
  ActorAttrType_18126_AttributeDesc = {
    Text = "チームの界域知識はチーム内の覚醒体の界域知識の合計に等しい。界域知識はチームの界域の才能効果を増加させる。現在のチームが「至純深海/至純血肉/至純超次元」の場合、界域知識の効果は2倍になる。\n・<Blue:混沌>界域のチームは界域知識1点ごとに、キーオーダー使用後すべての覚醒体が追加で<Blue:0.05>狂気を獲得する。\n・<Blue:深海>界域のチームは界域知識1点ごとに、狂気解放後<Blue:0.25％>の確率で追加の触腕集結を1層獲得し（確率が100%を超えると複数層獲得可能）、「静海」に切り替え時に獲得するシールドが最大ライフの<Blue:0.01％>増加し、「怒涛」中に能動ダメージで発動する触腕攻撃の触腕ダメージが<Blue:0.02%>増加する。\n・<Blue:血肉>界域のチームは界域知識1点ごとに、毎ターン初めて捕食を発動した時、最大ライフの<Blue:0.01%>のシールドと<Blue:0.005%>の一時的な力を追加で獲得する（失ったライフに応じて増加、最大100％増加）。\n・<Blue:超次元>界域のチームは界域知識1点ごとに、ターン開始時<Blue:0.125%>の確率で「インスピレーション」を1枚獲得する（確率が100%を超えると複数枚獲得可能）。"
  },
  ActorAttrType_18126_AttributeUpText = {
    Text = "界域知識 +{s1}"
  },
  ActorAttrType_18126_Text = {
    Text = "界域知識"
  },
  ActorAttrType_18127_Text = {Text = "ライフ"},
  ActorAttrType_18128_AttributeUpText = {
    Text = "攻撃力+{s1}"
  },
  ActorAttrType_18128_Text = {
    Text = "攻撃力増加"
  },
  ActorAttrType_18129_AttributeDesc = {
    Text = "基礎ダメージボーナスが高いほど、覚醒体が与えるダメージを増加。"
  },
  ActorAttrType_18129_AttributeUpText = {
    Text = "基礎ダメージ +{s1}"
  },
  ActorAttrType_18129_Text = {
    Text = "基礎ダメージ"
  },
  ActorAttrType_18130_Text = {Text = "レベル"},
  ActorAttrType_18131_AttributeDesc = {
    Text = "ターン終了時、覚醒体が自動回復する狂気値（課題モードでは、覚醒体が行動するたびに狂気値が回復する）"
  },
  ActorAttrType_18131_AttributeUpText = {
    Text = "狂気自動増加+{s1}"
  },
  ActorAttrType_18131_Text = {
    Text = "狂気自動増加"
  },
  ActorAttrType_18132_Text = {
    Text = "霊知啓発レベル"
  },
  ActorAttrType_18133_Text = {
    Text = "狂気割合修正"
  },
  ActorAttrType_18135_Text = {
    Text = "覚醒体の現在の狂気値"
  },
  ActorAttrType_18136_Text = {
    Text = "被ダメージ固定値修正"
  },
  ActorAttrType_18137_AttributeDesc = {
    Text = "覚醒体がシールドや回復効果を付与する際、シールドと回復値の割合を増加。"
  },
  ActorAttrType_18137_AttributeUpText = {
    Text = "シールドと治癒力強化+{s1}"
  },
  ActorAttrType_18137_Text = {
    Text = "シールドと治癒力強化"
  },
  ActorAttrType_18138_Text = {
    Text = "治療力アップ"
  },
  ActorAttrType_18139_AttributeDesc = {
    Text = "指令カードを発射するか霊知啓発を行う際、1行動力を消費するごとに{s1}ポイントのキーエネルギーを獲得する。この属性が増加するにつれて、追加で増加するキーエネルギーは徐々に減衰する。"
  },
  ActorAttrType_18139_AttributeUpText = {
    Text = "キーチャージ＋{s1}"
  },
  ActorAttrType_18139_Text = {
    Text = "キーチャージ"
  },
  ActorAttrType_18140_Text = {
    Text = "死亡抵抗回数"
  },
  ActorAttrType_18141_AttributeDesc = {
    Text = "攻撃レベル"
  },
  ActorAttrType_18141_AttributeUpText = {
    Text = "攻撃レベル+{s1}"
  },
  ActorAttrType_18141_Text = {
    Text = "攻撃レベル"
  },
  ActorAttrType_18142_AttributeDesc = {
    Text = "すべての覚醒体が与える「基礎ダメージ」、付与する「毒ダメージ」と「反撃ダメージ」の点数、深海界域の「基礎触腕ダメージ」を割合で増加。"
  },
  ActorAttrType_18142_AttributeUpText = {
    Text = "ダメージ強化+{s1}"
  },
  ActorAttrType_18142_Text = {
    Text = "ダメージ強化"
  },
  ActorAttrType_18143_Text = {
    Text = "狂気解放のダメージパーセンテージ修正"
  },
  ActorAttrType_18144_AttributeDesc = {
    Text = "覚醒体がアクティブダメージを受ける際、クリティカルに抵抗する確率。"
  },
  ActorAttrType_18144_AttributeUpText = {
    Text = "クリティカル抵抗+{s1}"
  },
  ActorAttrType_18144_Text = {
    Text = "クリティカル抵抗"
  },
  ActorAttrType_18145_AttributeDesc = {
    Text = "真貌顕現レベル"
  },
  ActorAttrType_18145_AttributeUpText = {
    Text = "真貌顕現レベル+{s1}"
  },
  ActorAttrType_18145_Text = {
    Text = "真貌顕現レベル"
  },
  ActorAttrType_18146_Text = {
    Text = "治癒固定値修正"
  },
  ActorAttrType_18147_AttributeUpText = {
    Text = "刻印幸運率+{s1}"
  },
  ActorAttrType_18147_Text = {
    Text = "刻印幸運率"
  },
  ActorAttrType_18148_Text = {
    Text = "治癒力の固定値修正"
  },
  ActorAttrType_18149_Text = {
    Text = "体力増加"
  },
  ActorAttrType_18150_Text = {
    Text = "倦怠割合修正"
  },
  ActorAttrType_18151_AttributeDesc = {
    Text = "チームの死亡抵抗率はチーム内の覚醒体の死亡抵抗率の合計に等しい。\n戦闘中に致命的なダメージを受けた場合、1ライフを保持する可能性があり、発動後次のターンに追加で2算力を獲得しカードを2枚引く。現在及びその後に獲得する死亡抵抗率が半減し、調査終了まで持続。"
  },
  ActorAttrType_18151_AttributeUpText = {
    Text = "死亡抵抗率+{s1}"
  },
  ActorAttrType_18151_Text = {
    Text = "死亡抵抗率"
  },
  ActorAttrType_18152_Text = {
    Text = "狂気のパーセンテージを調整"
  },
  ActorAttrType_18155_AttributeDesc = {
    Text = "戦闘勝利後の黒章のドロップ率が割合で増加。"
  },
  ActorAttrType_18155_AttributeUpText = {
    Text = "黒章ドロップ率+{s1}"
  },
  ActorAttrType_18155_Text = {
    Text = "黒章ドロップ率"
  },
  ActorAttrType_18156_Text = {
    Text = "狂気固定値修正"
  },
  ActorAttrType_18157_Text = {
    Text = "行動予測を隠す"
  },
  ActorAttrType_18158_Text = {
    Text = "ダメージ固定値修正"
  },
  ActorAttrType_18159_AttributeUpText = {
    Text = "クリティカル率+{s1}"
  },
  ActorAttrType_18159_Text = {
    Text = "クリティカル率"
  },
  ActorAttrType_18160_AttributeDesc = {
    Text = "スキル1レベル"
  },
  ActorAttrType_18160_AttributeUpText = {
    Text = "スキル1レベル+{s1}"
  },
  ActorAttrType_18160_Text = {
    Text = "スキル1レベル"
  },
  ActorAttrType_18161_Text = {Text = "レベル"},
  ActorAttrType_18162_Text = {
    Text = "ダメージアップ"
  },
  ActorAttrType_18163_Text = {Text = "触腕数"},
  ActorAttrType_18164_Text = {
    Text = "治癒割合修正"
  },
  ActorAttrType_18165_Text = {
    Text = "最大行動力"
  },
  ActorAttrType_18166_Text = {
    Text = "軟化割合修正"
  },
  ActorAttrType_18167_AttributeUpText = {
    Text = "防御力+{s1}"
  },
  ActorAttrType_18168_AttributeDesc = {
    Text = "霊知覚醒レベル"
  },
  ActorAttrType_18168_AttributeUpText = {
    Text = "霊知覚醒レベル+{s1}"
  },
  ActorAttrType_18168_Text = {
    Text = "霊知覚醒レベル"
  },
  ActorAttrType_21322_Text = {
    Text = "キーチャージ"
  },
  ActorAttrType_22207_AttributeDesc = {
    Text = "狂気解放を発動するたびに、{s1}狂気を獲得。この能力値が高くなるほど、追加ボーナスの増加効率は低下する。"
  },
  ActorAttrType_22207_AttributeUpText = {
    Text = "狂気増加＋{s1}"
  },
  ActorAttrType_22207_Text = {
    Text = "狂気増加"
  },
  ActorAttrType_22214_Text = {
    Text = "狂気増加"
  }
})
return Text_ActorAttrType
