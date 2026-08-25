__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_TrinketSuitEffect = readonly({
  TrinketSuitEffect_18335_Name = {
    Text = "四月の賛歌"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_1 = {
    Text = "クリティカルダメージ +7.2%"
  },
  TrinketSuitEffect_18335_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：ターン開始時、敵の総ライフが75％を超えている場合、装備者の一時的なクリティカル率とクリティカルダメージ+35％。"
  },
  TrinketSuitEffect_18336_Name = {
    Text = "環状詩篇（未完成）"
  },
  TrinketSuitEffect_18336_SuitEffectDesc_2 = {
    Text = "偶数ターン開始時、ランダムに手札の行動力消費が1点減少。"
  },
  TrinketSuitEffect_18337_Name = {
    Text = "深海航路"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_1 = {
    Text = "界域知識 +12"
  },
  TrinketSuitEffect_18337_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：戦闘開始時、装備者の攻撃力の12%に相当する力を獲得する。現在の界域が深海の場合、効果は「毎ターン開始時、(50+0.25*チーム界域精通)%の確率で触腕集結を1層獲得する。100%を超えた場合は複数層獲得可能。確率はボス戦で2倍になる」に変更される。"
  },
  TrinketSuitEffect_18338_Name = {
    Text = "呪いのウサギ"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_1 = {
    Text = "界域知識 +12"
  },
  TrinketSuitEffect_18338_SuitEffectDesc_2 = {
    Text = "装備者が与えるシールドとライフ回復が12％増加する。"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_1 = {
    Text = "キーチャージレベル +7.2"
  },
  TrinketSuitEffect_18339_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：装備者の基礎狂気が20ポイント上昇する。装備者の指令カードのクリティカル率、クリティカルダメージ、シールド、HP回復が20%上昇する。"
  },
  TrinketSuitEffect_18340_Name = {
    Text = "有機形態"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_1 = {
    Text = "黒章ドロップ +3.6%"
  },
  TrinketSuitEffect_18340_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>。探索開始時、最大100％の死亡抵抗を差し引く。1％の死亡抵抗を差し引くごとに、装備者が与える狂気が0.15％増加する。"
  },
  TrinketSuitEffect_18341_Name = {
    Text = "深紅の鼓動"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_1 = {
    Text = "クリティカルダメージ +7.2%"
  },
  TrinketSuitEffect_18341_SuitEffectDesc_2 = {
    Text = "キーオーダーを発動した後、装備者は30%の一時的なクリティカル率を獲得する。"
  },
  TrinketSuitEffect_18342_Name = {
    Text = "標準密約SSR"
  },
  TrinketSuitEffect_18342_SuitEffectDesc_2 = {
    Text = "装備者が与えるダメージ、治癒、シールドが15%増加。"
  },
  TrinketSuitEffect_18343_Name = {
    Text = "標準密約R"
  },
  TrinketSuitEffect_18343_SuitEffectDesc_2 = {
    Text = "装備者が与えるダメージ、治癒、シールドが15%増加。"
  },
  TrinketSuitEffect_18344_Name = {
    Text = "機神降臨"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_1 = {
    Text = "界域知識 +12"
  },
  TrinketSuitEffect_18344_SuitEffectDesc_2 = {
    Text = "各戦闘の最初のターンに算力を1ポイント獲得する。ボス戦では、4ターンごとに追加で算力を1ポイント獲得する"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_1 = {
    Text = "ダメージ強化 +7.2%"
  },
  TrinketSuitEffect_18345_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：装備者の指令カードが超次元空間に入った後、胚胎融合を+25〜50する。現在HPが低いほど獲得する胚胎融合が高くなる。"
  },
  TrinketSuitEffect_18346_Name = {Text = "再進化"},
  TrinketSuitEffect_18346_SuitEffectDesc_1 = {
    Text = "狂気増加 +2.4"
  },
  TrinketSuitEffect_18346_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：探索開始時、装備者は狂気を35ポイント獲得する。装備者が狂気バーストを使用した後、この戦闘中ターン終了時に狂気を2ポイント獲得する。この効果は最大3回まで累積する。"
  },
  TrinketSuitEffect_18347_Name = {
    Text = "生命力搾取"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_1 = {
    Text = "キーチャージレベル +7.2"
  },
  TrinketSuitEffect_18347_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：ターン終了時、装備者のキーチャージの200％に相当するキーエネルギーを獲得する。現在の界域が「血肉」の場合、効果は5キーチャージごとに胚胎融合+1に変わる。"
  },
  TrinketSuitEffect_18348_Name = {
    Text = "薬となる夢"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_1 = {
    Text = "ダメージ強化 +4.8%"
  },
  TrinketSuitEffect_18348_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>。戦闘終了時に獲得する黒章–8、戦闘開始時に装備者の打撃防御以外の指令カードのオリジナルコピーをドローパイルに混ぜる、各種最大1枚。"
  },
  TrinketSuitEffect_18349_Name = {
    Text = "ナメクジプリン"
  },
  TrinketSuitEffect_18349_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：1ターン内に「湮滅」を発動し、かつ触腕姿態を切り替えた場合、装備者の本ターンに与えるシールド、ライフ回復、最終ダメージ+25％、3ターンクールダウン。"
  },
  TrinketSuitEffect_18350_Name = {
    Text = "劇場猫（未完成）"
  },
  TrinketSuitEffect_18350_SuitEffectDesc_2 = {
    Text = "ライフが75%以上の敵に与える装備者の攻撃は必ずクリティカルになる。"
  },
  TrinketSuitEffect_18351_Name = {
    Text = "三十六房の環"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_1 = {
    Text = "狂気増加 +2.4"
  },
  TrinketSuitEffect_18351_SuitEffectDesc_2 = {
    Text = "<TeamUnique: 唯一装備>。キーエネルギー上限とキーオーダーのキーエネルギー消費が+200され、装備者の狂気解放のクリティカル率、クリティカルダメージ、シールド、ライフ回復が30%増加する。"
  },
  TrinketSuitEffect_18352_Name = {
    Text = "歪みの双子・白"
  },
  TrinketSuitEffect_18352_SuitEffectDesc_2 = {
    Text = "偶数ターン開始後、<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:消耗>が付与された装備者の「防御」を1枚手札に加える。"
  },
  TrinketSuitEffect_18353_Name = {
    Text = "深紅の抱擁"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_1 = {
    Text = "クリティカル率 +4.8%"
  },
  TrinketSuitEffect_18353_SuitEffectDesc_2 = {
    Text = "装備者がダメージを与えた時、銀キーエネルギーを35ポイント獲得する。クリティカルダメージを与えた場合、代わりに銀キーエネルギーを70ポイント獲得する。毎ターン最大3回まで発動。"
  },
  TrinketSuitEffect_18354_Name = {
    Text = "標準密約SR"
  },
  TrinketSuitEffect_18354_SuitEffectDesc_2 = {
    Text = "装備者が与えるダメージ、治癒、シールドが15%増加。"
  },
  TrinketSuitEffect_18355_Name = {
    Text = "無垢の啓示録"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_1 = {
    Text = "キーチャージレベル +7.2"
  },
  TrinketSuitEffect_18355_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：キーオーダー発動後、装備者の体質の12％に相当するライフを回復する。効果は損失ライフの割合に応じて増加し、最大で装備者の体質の24％のライフまで増加する。"
  },
  TrinketSuitEffect_18356_Name = {
    Text = "荒野の狼"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_1 = {
    Text = "ダメージ強化 +4.8%"
  },
  TrinketSuitEffect_18356_SuitEffectDesc_2 = {
    Text = "装備者が与える基礎ダメージが20％増加し、与える<IntoxicationIconKeywords:中毒>と<RetaliateIconKeywords:反撃>が10％増加する。"
  },
  TrinketSuitEffect_18357_Name = {
    Text = "遠くの宴"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_1 = {
    Text = "黒章ドロップ +3.6%"
  },
  TrinketSuitEffect_18357_SuitEffectDesc_2 = {
    Text = "探索開始時、黒章を10獲得する。装備者の「防御」が与えるシールドが60％増加する。"
  },
  TrinketSuitEffect_18358_Name = {
    Text = "歪みの双子・黒"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_1 = {
    Text = "クリティカル率 +4.8%"
  },
  TrinketSuitEffect_18358_SuitEffectDesc_2 = {
    Text = "奇数ターン開始後、<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:消耗>が付与された装備者の「打撃」を1枚手札に加える。"
  },
  TrinketSuitEffect_18359_Name = {
    Text = "少女の蛹"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_1 = {
    Text = "クリティカル率 +7.2%"
  },
  TrinketSuitEffect_18359_SuitEffectDesc_2 = {
    Text = "<TeamUnique: チーム唯一>：装備者が毎ターン初めて胚胎を消費した後、触腕1本につき8％の一時的クリティカルダメージを獲得、最大80％。"
  },
  TrinketSuitEffect_18360_Name = {
    Text = "墓地の囁き"
  },
  TrinketSuitEffect_18360_SuitEffectDesc_2 = {
    Text = "ステージ開始時、<DeathResistanceIconKeywords:死亡抵抗率>が25%上昇する。死亡抵抗を発動した後、装備者は狂気を50ポイント獲得する。"
  },
  TrinketSuitEffect_99234_Name = {Text = "腐植質"},
  TrinketSuitEffect_99234_SuitEffectDesc_1 = {
    Text = "一時的なテキスト"
  },
  TrinketSuitEffect_99234_SuitEffectDesc_2 = {
    Text = "一時的なテキスト"
  },
  TrinketSuitEffect_99235_Name = {Text = "飛昇"},
  TrinketSuitEffect_99235_SuitEffectDesc_1 = {
    Text = "一時的なテキスト"
  },
  TrinketSuitEffect_99235_SuitEffectDesc_2 = {
    Text = "一時的なテキスト"
  },
  TrinketSuitEffect_99236_Name = {
    Text = "スティックス"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_1 = {
    Text = "一時的なテキスト"
  },
  TrinketSuitEffect_99236_SuitEffectDesc_2 = {
    Text = "一時的なテキスト"
  }
})
return Text_TrinketSuitEffect
