__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "戦闘開始後、「<MindWall:心の壁>」を1層獲得し、3ターン後に「<BarrierCrash:壁解崩壊>」に変換されます。"
  },
  RelicConfig_100300_Desc = {
    Text = "戦闘開始後、「<MindWall:心の壁>」を1層獲得し、3ターン後に「<BarrierCrash:壁解崩壊>」に変換されます。"
  },
  RelicConfig_100300_Name = {
    Text = "心の分析"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "自分の心をよく見極めて、誤った選択をしないように。"
  },
  RelicConfig_100399_BattleDesc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_100399_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:創造の遺物「金色の夢+」>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "変身の日がお前の死期だ。"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_100400_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:創造の遺物「恩恵の血+」>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "それは甘く芳醇で、薔薇の香りがする。"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  RelicConfig_100401_Desc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:創造の遺物「錆びた鋸+」>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "解剖医の目に映るのは、美しい女性ではなくーー骨、病の神経、炎症を起こした筋肉と組織だけ。"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:弱体>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  RelicConfig_100402_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:弱体>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:創造の遺物「春の祭り」>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "夜の笑い声の中、カヌーの影が湖面を滑っていた。"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_100404_Desc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:創造の遺物「重鎖」>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "厚くて頑丈な鍵、キーがなければ開けるのは難しそうだ。\nもちろん、ある神盗みには大したことではない。"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]％ 増加する。"
  },
  RelicConfig_100405_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]％ 増加する。"
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:創造の遺物「悪童」>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "純粋な悪から生まれたもの、それが彼の望みではないとしても。"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_100406_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:創造の遺物「金色の夢」>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "変身の日がお前の死期だ。"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。最大15回まで発動する。"
  },
  RelicConfig_100407_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。最大15回まで発動する。"
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:創造の遺物「縞瑪瑙」>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "ただの縞瑪瑙だろう、おそらく。"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_100408_Desc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:創造の遺物「重鎖+」>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "厚くて頑丈な鍵、キーがなければ開けるのは難しそうだ。\nもちろん、ある神盗みには大したことではない。"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]％ 増加する。"
  },
  RelicConfig_100409_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]％ 増加する。"
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:創造の遺物「悪童+」>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "純粋な悪から生まれたもの、それが彼の望みではないとしても。"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。最大15回まで発動する。"
  },
  RelicConfig_100410_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。最大15回まで発動する。"
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:創造の遺物「縞瑪瑙+」>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "ただの縞瑪瑙だろう、おそらく。"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:弱体>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  RelicConfig_100411_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:弱体>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:創造の遺物「春の祭り+」>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "夜の笑い声の中、カヌーの影が湖面を滑っていた。"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_100412_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:創造の遺物「恩恵の血」>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "それは甘く芳醇で、薔薇の香りがする。"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  RelicConfig_100413_Desc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:創造の遺物「錆びた鋸」>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "解剖医の目に映るのは、美しい女性ではなくーー骨、病の神経、炎症を起こした筋肉と組織だけ。"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン中に与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_100539_Desc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン中に与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:創造の遺物「血染めの小石」>"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン中に与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_100540_Desc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン中に与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:創造の遺物「血染めの小石+」>"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116382_Desc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116382_Name = {
    Text = "さびたキー"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116383_Desc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116383_Name = {
    Text = "さびたキー"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116384_Desc = {
    Text = "錆びたキーの束。ドアの鍵を開くのに使用できます。"
  },
  RelicConfig_116384_Name = {
    Text = "さびたキー"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "手札上限 +1 。\nターン開始時、すべての儀式が完了していない場合、最大生命の10%の<SacrificeKeyWord:献祭>を得る。「<DerivativeCardKeywords_119:敬献神明>」を1枚手札に置き、最大1枚を保持する。"
  },
  RelicConfig_119371_Desc = {
    Text = "手札上限 +1 。\nターン開始時、すべての儀式が完了していない場合、最大生命の10%の<SacrificeKeyWord:献祭>を得る。「<DerivativeCardKeywords_119:敬献神明>」を1枚手札に置き、最大1枚を保持する。"
  },
  RelicConfig_119371_Name = {
    Text = "真鍮香炉"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "「リモリアの工芸にならってこの香炉を作りました。あなたの安らかな眠りを、夜ごと助けてくれますように。ミリアムより。」"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "手札上限+[Arg1]。ターン開始時、[Arg2]枚の「<PVPDerivativeCardKeywords_11:不平等な交換>」を手札に追加する。"
  },
  RelicConfig_120372_Desc = {
    Text = "手札上限+[Arg1]。ターン開始時、[Arg2]枚の「<PVPDerivativeCardKeywords_11:不平等な交換>」を手札に追加する。"
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:万華鏡>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "最初に使用する「<PVPWeaponKeywords:運命の札>」[Arg1]枚の行動力消費を-5/-3/-1/+1、カードを1枚引く。"
  },
  RelicConfig_120373_Desc = {
    Text = "最初に使用する「<PVPWeaponKeywords:運命の札>」[Arg1]枚の行動力消費を-5/-3/-1/+1、カードを1枚引く。"
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:ミサゴの校章>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "ダメージを無効化"
  },
  RelicConfig_121214_Desc = {
    Text = "ダメージを無効化"
  },
  RelicConfig_121214_Name = {
    Text = "無敵テスト造物"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "与えられる最終ダメージが250%増加し、1回のダメージを与えるごとに50%減少し、与えられるシールドが10%増加する。最大5回まで発動し、ターン開始後にリセットされる。"
  },
  RelicConfig_121689_Desc = {
    Text = "与えられる最終ダメージが250%増加し、1回のダメージを与えるごとに50%減少し、与えられるシールドが10%増加する。最大5回まで発動し、ターン開始後にリセットされる。"
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:「純銀の帰路・誕生」>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "戦闘開始時、3枚のカードを選択し、「<RippleKeywords:余波>：カードを1枚引き、[Arg3]点の一時的な<PowerIconKeywords:力>を獲得する」を付与します。ターン開始時に<RippleKeywords:余波>を持つカードを2枚引き、すべての<RippleKeywords:余波>効果が追加で1回発動します。<RippleKeywords:余波>が10回発動した後、<DerivativeCardKeywords_1:「影の残響」>を1枚手札に加えます。"
  },
  RelicConfig_121690_Desc = {
    Text = "戦闘開始時、3枚のカードを選択し、「<RippleKeywords:余波>：カードを1枚引き、[Arg3]点の一時的な<PowerIconKeywords:力>を獲得する」を付与します。ターン開始時に<RippleKeywords:余波>を持つカードを2枚引き、すべての<RippleKeywords:余波>効果が追加で1回発動します。<RippleKeywords:余波>が10回発動した後、<DerivativeCardKeywords_1:「影の残響」>を1枚手札に加えます。"
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:「純銀の帰路・狂気」>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "すべての覚醒体の狂気解放の最終ダメージが100%増加し、各覚醒体が狂気解放を発動した後、その500%の基本狂気のキーエネルギーを獲得し、すべての覚醒体の基本狂気が20ポイント減少し、最大で5回まで減少する。"
  },
  RelicConfig_121691_Desc = {
    Text = "すべての覚醒体の狂気解放の最終ダメージが100%増加し、各覚醒体が狂気解放を発動した後、その500%の基本狂気のキーエネルギーを獲得し、すべての覚醒体の基本狂気が20ポイント減少し、最大で5回まで減少する。"
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:「純銀の帰途・恐怖」>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "すべての覚醒体が与える<RetaliateIconKeywords:反撃>、<IntoxicationIconKeywords:毒>、シールドおよびライフ回復が50%増加する。ターン終了時、現在のシールドの500%に相当する一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_121692_Desc = {
    Text = "すべての覚醒体が与える<RetaliateIconKeywords:反撃>、<IntoxicationIconKeywords:毒>、シールドおよびライフ回復が50%増加する。ターン終了時、現在のシールドの500%に相当する一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:「純銀の帰路・邪教」>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "手札上限 +5。ターン開始時にカードを2枚引き、2点の行動力を獲得する。デッキがリセットされるたびに、[Arg3]点の<PowerIconKeywords:力>と[Arg4]点の一時的な<AlertIconKeywords:警戒>を獲得し、狂気が最も高い覚醒体ごとに非派生の指令カードを1枚ずつ生成して山札に加え、それらの行動力消費を1点減少させる。"
  },
  RelicConfig_121693_Desc = {
    Text = "手札上限 +5。ターン開始時にカードを2枚引き、2点の行動力を獲得する。デッキがリセットされるたびに、[Arg3]点の<PowerIconKeywords:力>と[Arg4]点の一時的な<AlertIconKeywords:警戒>を獲得し、狂気が最も高い覚醒体ごとに非派生の指令カードを1枚ずつ生成して山札に加え、それらの行動力消費を1点減少させる。"
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:「純銀の帰途・刺骨」>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "すべての覚醒体は毎ターン最初の「コマンドカード」で25の狂気を獲得し、<DerivativeCardKeywords_4:啓示>を1枚手札に追加する。「狂気解放」を4回発動した後、すべての覚醒体の<Seal:封印>状態を解除し、すべての覚醒体が50の狂気を獲得する。"
  },
  RelicConfig_121694_Desc = {
    Text = "すべての覚醒体は毎ターン最初の「コマンドカード」で25の狂気を獲得し、<DerivativeCardKeywords_4:啓示>を1枚手札に追加する。「狂気解放」を4回発動した後、すべての覚醒体の<Seal:封印>状態を解除し、すべての覚醒体が50の狂気を獲得する。"
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:「純銀の帰路・幻想」>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "バトル開始時、[Arg4]ポイントの<PowerIconKeywords:力>を獲得し、シルバーキーエネルギーのストレージ上限が100%増加します。各ポイントの計算力消費時に獲得するシルバーキーエネルギーが100%増加し、シルバーキー覚醒やキーを解放した後、現在の<PowerIconKeywords:力>の20%に相当する一時的な<PowerIconKeywords:力>を獲得し、すべての覚醒体が20ポイントの狂気を獲得します。"
  },
  RelicConfig_121695_Desc = {
    Text = "バトル開始時、[Arg4]ポイントの<PowerIconKeywords:力>を獲得し、シルバーキーエネルギーのストレージ上限が100%増加します。各ポイントの計算力消費時に獲得するシルバーキーエネルギーが100%増加し、シルバーキー覚醒やキーを解放した後、現在の<PowerIconKeywords:力>の20%に相当する一時的な<PowerIconKeywords:力>を獲得し、すべての覚醒体が20ポイントの狂気を獲得します。"
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:「純銀の帰途・悲泣」>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "戦闘開始後、[Arg1]枚の「<PVPDerivativeCardKeywords_25:シルヴィアの紅茶>」を手札に追加する。"
  },
  RelicConfig_122625_Desc = {
    Text = "戦闘開始後、[Arg1]枚の「<PVPDerivativeCardKeywords_25:シルヴィアの紅茶>」を手札に追加する。"
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:セイロンティー>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "毎ターン、山札に[Arg1]枚の所有者がランダムな覚醒体の「<PVPDerivativeCardKeywords_14:現実模倣>」を追加する。"
  },
  RelicConfig_122626_Desc = {
    Text = "毎ターン、山札に[Arg1]枚の所有者がランダムな覚醒体の「<PVPDerivativeCardKeywords_14:現実模倣>」を追加する。"
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:マジックグローブ>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "毎ターン、最初に使用する「スキル」のダメージ、治癒、シールドが[Arg1]%増加する。"
  },
  RelicConfig_122627_Desc = {
    Text = "毎ターン、最初に使用する「スキル」のダメージ、治癒、シールドが[Arg1]%増加する。"
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:ルビーのブローチ>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "ターン終了後、追加で<Energy:[Arg1]>狂気を獲得する。"
  },
  RelicConfig_122628_Desc = {
    Text = "ターン終了後、追加で<Energy:[Arg1]>狂気を獲得する。"
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:悪夢の表象>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "山札の覚醒体のカード枚数が2倍になる。カードを使用後、手札がこのターンで初めて[Arg1]枚未満になった場合、カードを[Arg2]枚引く。"
  },
  RelicConfig_122629_Desc = {
    Text = "山札の覚醒体のカード枚数が2倍になる。カードを使用後、手札がこのターンで初めて[Arg1]枚未満になった場合、カードを[Arg2]枚引く。"
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:ハッピーレコード>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "手札上限+[Arg1]。毎ターン、山札に[Arg2]枚の「<PVPDerivativeCardKeywords_13:不朽の葬儀>」を追加する。"
  },
  RelicConfig_122630_Desc = {
    Text = "手札上限+[Arg1]。毎ターン、山札に[Arg2]枚の「<PVPDerivativeCardKeywords_13:不朽の葬儀>」を追加する。"
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:遺失の祭祀刀>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "ターン開始時に、行動力消費-1の「打撃」を[Arg1]枚引く。狂気の爆発を解放後、<DepleteIconKeywords:消費>、<PrepareKeypvewords:準備1>、<RetainIconKeywords:保留>を持つ対応する覚醒体の「打撃」を[Arg2]枚生成する。\n1ターン内に「打撃」を[Arg3]枚使用するごとに、[Arg4]ポイントの一時的<PowerIconKeywords:力>を獲得する。「打撃」を[Arg5]枚使用後、[Arg6]枚のカードを引き、[Arg7]ポイントの行動力を獲得する。「打撃」を[Arg8]枚使用後、すべての覚醒体は[Arg9]ポイントの狂気を獲得する。"
  },
  RelicConfig_122768_Desc = {
    Text = "ターン開始時に、行動力消費-1の「打撃」を[Arg1]枚引く。狂気の爆発を解放後、<DepleteIconKeywords:消費>、<PrepareKeypvewords:準備1>、<RetainIconKeywords:保留>を持つ対応する覚醒体の「打撃」を[Arg2]枚生成する。\n1ターン内に「打撃」を[Arg3]枚使用するごとに、[Arg4]ポイントの一時的<PowerIconKeywords:力>を獲得する。「打撃」を[Arg5]枚使用後、[Arg6]枚のカードを引き、[Arg7]ポイントの行動力を獲得する。「打撃」を[Arg8]枚使用後、すべての覚醒体は[Arg9]ポイントの狂気を獲得する。"
  },
  RelicConfig_122768_Name = {
    Text = "彼世の響き"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "異界の霧に混じる反響は、歪み、狂気、そして疑うことのできない真実へと通じている。"
  },
  RelicConfig_123724_BattleDesc = {
    Text = "ターン開始時、モカは[Arg1]ポイントの狂気を獲得し、消費0のモカの一時的な「打撃」を1枚生成する。「ドラマチックな出会い」を発動するたびに、「輝く☆竜巻」がこの戦闘で与える基礎ダメージと打撃ダメージアップの効果が[Arg2]％増加する。"
  },
  RelicConfig_123724_Desc = {
    Text = "ターン開始時、モカは[Arg1]ポイントの狂気を獲得し、消費0のモカの一時的な「打撃」を1枚生成する。「ドラマチックな出会い」を発動するたびに、「輝く☆竜巻」がこの戦闘で与える基礎ダメージと打撃ダメージアップの効果が[Arg2]％増加する。"
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:次元影像・モシャ>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "すべての覚醒体は毎ターン最初に指令カードを使用する際、[Arg1]の狂気を獲得する。1ターン内に異なる覚醒体に属する指令カードを4枚使用した後、すべての敵に味方の最大ライフの[Arg2]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  RelicConfig_125488_Desc = {
    Text = "すべての覚醒体は毎ターン最初に指令カードを使用する際、[Arg1]の狂気を獲得する。1ターン内に異なる覚醒体に属する指令カードを4枚使用した後、すべての敵に味方の最大ライフの[Arg2]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  RelicConfig_125488_Name = {
    Text = "妾の風格"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "ターン開始時、徐は[Arg1]の狂気を獲得し、すべての敵に1層の<WitherKeywords:酔い痴れ>を付与する。毎ターン発射される最初の徐の指令カードは必ず「共鳴」効果を発動する。"
  },
  RelicConfig_125489_Desc = {
    Text = "ターン開始時、徐は[Arg1]の狂気を獲得し、すべての敵に1層の<WitherKeywords:酔い痴れ>を付与する。毎ターン発射される最初の徐の指令カードは必ず「共鳴」効果を発動する。"
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:次元イメージ・徐>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "手札上限＋3。毎ターン発射した最初の3枚の非派生指令カードを記録し、3ターン後のターン開始時にその行動力消費を-1にし、<DepleteIconKeywords:消費>の複製を手札に加える。"
  },
  RelicConfig_126673_Desc = {
    Text = "手札上限＋3。毎ターン発射した最初の3枚の非派生指令カードを記録し、3ターン後のターン開始時にその行動力消費を-1にし、<DepleteIconKeywords:消費>の複製を手札に加える。"
  },
  RelicConfig_126673_Name = {
    Text = "運命の紡ぎ車"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "運命は巡り、永久に止まることはない。"
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:ゴールド調和>：「計算力調和」による計算力の向上効果の最大値は1点であり、1%のダメージ強化を持つごとに霊識研究深度の効果が1%向上します。\n<OrangeQuality:次元の贈り物>：探索開始時にランダムで1つの次元影像遺物を獲得し、手札上限が2増加します。\n<OrangeQuality:祝福の儀式>：第一、第二段階のボス撃破報酬がランダムな祝福された遺物3つの中から1つに変更されます。\n<RedQuality:長距離の疲れ>：戦闘中のすべてのライフ回復効果が50%減少し、「褪色遺骨」を選択して「安葬」する際は最大ライフの25%回復に変更されます。\n<RedQuality:眩暈の兆し>：戦闘開始時、すべての覚醒体の現在の狂気とキーエネルギーが50%減少します。\n<RedQuality:永夜の廊下>：探索開始時、すべての覚醒体の基本狂気とキーエネルギー上限が50%増加します。"
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:ゴールド調和>：「計算力調和」による計算力の向上効果の最大値は1点であり、1%のダメージ強化を持つごとに霊識研究深度の効果が1%向上します。\n<OrangeQuality:次元の贈り物>：探索開始時にランダムで1つの次元影像遺物を獲得し、手札上限が2増加します。\n<OrangeQuality:祝福の儀式>：第一、第二段階のボス撃破報酬がランダムな祝福された遺物3つの中から1つに変更されます。\n<RedQuality:長距離の疲れ>：戦闘中のすべてのライフ回復効果が50%減少し、「褪色遺骨」を選択して「安葬」する際は最大ライフの25%回復に変更されます。\n<RedQuality:眩暈の兆し>：戦闘開始時、すべての覚醒体の現在の狂気とキーエネルギーが50%減少します。\n<RedQuality:永夜の廊下>：探索開始時、すべての覚醒体の基本狂気とキーエネルギー上限が50%増加します。"
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:小「N」の混乱なカメラ>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "やばい！カメラが完全に壊れた！え？どうしてまだ動いてるの？ちょっと待って！この制限は何なの？！"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:ゴールド調和>：「行動力調和」による行動力の上昇効果は最大1ポイントであり、1％のダメージ強化ごとに霊識研究深度の効果が1％上昇します。\n<RedQuality:長距離の疲れ>：戦闘中、すべてのライフ回復効果が50％減少し、「褪色遺骨」を「安葬」に選択した際は最大ライフの25％を回復します。"
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:ゴールド調和>：「行動力調和」による行動力の上昇効果は最大1ポイントであり、1％のダメージ強化ごとに霊識研究深度の効果が1％上昇します。\n<RedQuality:長距離の疲れ>：戦闘中、すべてのライフ回復効果が50％減少し、「褪色遺骨」を「安葬」に選択した際は最大ライフの25％を回復します。"
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:小「N」の完全なカメラ>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "見ないで、これがカメラだ！新品で、子どもも大人もご安心。"
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:ゴールド調和>：「行動力調和」による行動力の向上効果は最大1ポイントで、1％のダメージ強化を持つごとに霊識研究深度の効果が1％向上します。\n<OrangeQuality:次元の贈り物>：探索開始時にランダムで1つの次元影像遺物を獲得し、手札上限が1増加します。\n<RedQuality:長距離の疲れ>：戦闘中のすべてのライフ回復効果が50％減少し、「褪色遺骨」で「安葬」を選択した場合、最大ライフの25％を回復に変更されます。\n<RedQuality:眩暈の兆し>：戦闘開始時、すべての覚醒体の現在の狂気とキーエネルギーが50％減少します。"
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:ゴールド調和>：「行動力調和」による行動力の向上効果は最大1ポイントで、1％のダメージ強化を持つごとに霊識研究深度の効果が1％向上します。\n<OrangeQuality:次元の贈り物>：探索開始時にランダムで1つの次元影像遺物を獲得し、手札上限が1増加します。\n<RedQuality:長距離の疲れ>：戦闘中のすべてのライフ回復効果が50％減少し、「褪色遺骨」で「安葬」を選択した場合、最大ライフの25％を回復に変更されます。\n<RedQuality:眩暈の兆し>：戦闘開始時、すべての覚醒体の現在の狂気とキーエネルギーが50％減少します。"
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:小「N」の古びたカメラ>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "だめだ！カメラが壊れちゃった！ちょっと修理してみる…………起動した！でもなんだか変な感じがする…………"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "ターン開始時にモスクは[Arg1]の狂気を獲得します。毎ターン最初に発射される「蓄力！」または「装填！」は2回効果を発揮します。"
  },
  RelicConfig_131079_Desc = {
    Text = "ターン開始時にモスクは[Arg1]の狂気を獲得します。毎ターン最初に発射される「蓄力！」または「装填！」は2回効果を発揮します。"
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:次元イメージ・モスク>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "最初の3ターン開始時に、毎ターン「カワウソのジレンマ」を1回発動する。5ターン目の開始時に、すべての「カワウソのジレンマ」のデバフ効果を解除し、「<DerivativeCardKeywords_135:二世の衝撃！」>を獲得する。"
  },
  RelicConfig_131080_Desc = {
    Text = "最初の3ターン開始時に、毎ターン「カワウソのジレンマ」を1回発動する。5ターン目の開始時に、すべての「カワウソのジレンマ」のデバフ効果を解除し、「<DerivativeCardKeywords_135:二世の衝撃！」>を獲得する。"
  },
  RelicConfig_131080_Name = {
    Text = "小さな炭団二世"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "モスクは厳しく言った、これが遺物だ。\n「悪者、噛め！」"
  },
  RelicConfig_131178_BattleDesc = {
    Text = "戦闘開始時、「<DerivativeCardKeywords_134:禁忌の真実>」を1枚山札のランダムな位置に追加する。各ターン、引くカード+[Arg1]。指令カード使用後、手札・山札・捨て札のそれぞれからランダムに[Arg2]枚の<ErosionColorInkKeywords:認知錯乱>が付与されていない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。"
  },
  RelicConfig_131178_Desc = {
    Text = "戦闘開始時、「<DerivativeCardKeywords_134:禁忌の真実>」を1枚山札のランダムな位置に追加する。各ターン、引くカード+[Arg1]。指令カード使用後、手札・山札・捨て札のそれぞれからランダムに[Arg2]枚の<ErosionColorInkKeywords:認知錯乱>が付与されていない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。"
  },
  RelicConfig_131178_Name = {
    Text = "ある男性の手記"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "記載内容には70個あまりのメルセンヌ素数が含まれている。"
  },
  RelicConfig_132540_BattleDesc = {
    Text = "ダメージを無効化"
  },
  RelicConfig_132540_Name = {
    Text = "集合テスト造物"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "クリティカル率が15%増加する。ターン開始時にライフが25%([Arg1])未満の場合、そのターン中クリティカル率が追加で30%増加する。"
  },
  RelicConfig_13740_Desc = {
    Text = "クリティカル率が15%増加する。ターン開始時にライフが25%未満の場合、そのターン中クリティカル率が追加で30%増加する。"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:秘典の星象儀>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "宇宙の神秘。"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "クリティカルダメージが15%増加する。シールドを持つ敵に与えるダメージは必ずクリティカルになる。"
  },
  RelicConfig_13741_Desc = {
    Text = "クリティカルダメージが15%増加する。シールドを持つ敵に与えるダメージは必ずクリティカルになる。"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:美学の原理>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "蝋人形師：医者の助手、葬儀業者のパトロン、墓虫の恩人。"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "クリティカルダメージ+50%。3回目の攻撃は必ずクリティカルになる。"
  },
  RelicConfig_13742_Desc = {
    Text = "クリティカルダメージ+50%。3回目の攻撃は必ずクリティカルになる。"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:時の振り子「瞑想」>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "ターン開始時、最も狂気が低い覚醒体が15狂気を獲得する。前のカードより行動力消費が低いカードを2回連続で使用した時、最も狂気が低い覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13743_Desc = {
    Text = "ターン開始時、最も狂気が低い覚醒体が15狂気を獲得する。前のカードより行動力消費が低いカードを2回連続で使用した時、最も狂気が低い覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:アルカナ遺物>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "運命の終焉。"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "ターン開始後、狂気が最も低い覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13744_Desc = {
    Text = "ターン開始後、狂気が最も低い覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:月桂樹のカフリンクス>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "月桂樹の模様が刻まれた銀のカフスボタン。\n精巧な作りで、輝いており、かつて二人の子供の友情を支えていた。"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "界域推薦ボーナス効果が50%に増加し、ステージ開始時にあなたの刻印幸運率が2倍になる。"
  },
  RelicConfig_13745_Desc = {
    Text = "界域推薦ボーナス効果が50%に増加し、ステージ開始時にあなたの刻印幸運率が2倍になる。"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:時の振り子「熟睡」>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "死亡を1回無効化し、発動後直ちにライフを10%回復する。3回発動すると永久に無効になる。"
  },
  RelicConfig_13747_Desc = {
    Text = "死亡を1回無効化し、発動後直ちにライフを10%回復する。3回発動すると永久に無効になる。"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆非常食☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "どうしてもという時以外は、これを食べないで。"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "戦闘開始時、あなたの現在の行動力消費が1のすべてのカードの、この戦闘中のダメージを[Arg1]点増加させ、シールドを[Arg2]点増加させる。"
  },
  RelicConfig_13748_Desc = {
    Text = "戦闘開始時、あなたの現在の行動力消費が1のすべてのカードの、この戦闘中のダメージを[Arg1]点増加させ、シールドを[Arg2]点増加させる。"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:ピュアマリー>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "論理はカクテルのようなもの、摂りすぎると益を失う。"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "4ターンごとにすべての敵がそのターンに受ける主動および触腕ダメージを倍にする。ただし、そのターン中に狂気解放を発動した後、すべての覚醒体を1ターン封印する。"
  },
  RelicConfig_13749_Desc = {
    Text = "4ターンごとにすべての敵がそのターンに受ける主動および触腕ダメージを倍にする。ただし、そのターン中に狂気解放を発動した後、すべての覚醒体を1ターン封印する。"
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:行道の骸>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離しても、その足跡は四海に広がっている。"
  },
  RelicConfig_13750_BattleDesc = {
    Text = "ターン終了時、シールドがない場合、ダメージを1回無効化する<ParcloseIconKeywords:屏障>を1層獲得する。各戦闘で1回のみ発動する。"
  },
  RelicConfig_13750_Desc = {
    Text = "ターン終了時、シールドがない場合、ダメージを1回無効化する<ParcloseIconKeywords:屏障>を1層獲得する。各戦闘で1回のみ発動する。"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆鎮痛薬☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "効果はそんなに一度で済むものではない。"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "クリティカル率が25%増加し、毎ターン初めて与えるダメージが2倍になる。"
  },
  RelicConfig_13751_Desc = {
    Text = "クリティカル率が25%増加し、毎ターン初めて与えるダメージが2倍になる。"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:時の振り子「深化」>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "ターン開始時に [Arg1] のライフを回復する。ライフが 50％ より低い場合、回復量が [Arg2] に変更される。"
  },
  RelicConfig_13752_Desc = {
    Text = "ターン開始時に [Arg1] のライフを回復する。ライフが 50％ より低い場合、回復量が [Arg2] に変更される。"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:恩恵の血>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "それは甘く芳醇で、バラの香りがする。"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "これは効果のないステージ遺物だ。"
  },
  RelicConfig_13753_Desc = {
    Text = "これは効果のないステージ遺物だ。"
  },
  RelicConfig_13753_Name = {
    Text = "任務遺物テスト"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "内容を補充する必要がある遺物。"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "与える5回目のダメージは必ずクリティカルになる。"
  },
  RelicConfig_13754_Desc = {
    Text = "与える5回目のダメージは必ずクリティカルになる。"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:視力矯正器>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "かつて誰かがそれを通して真実を見つけたことがある。"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "ターン開始時、<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚あるごとに、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。超次元ターンの場合、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13755_Desc = {
    Text = "ターン開始時、<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚あるごとに、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。超次元ターンの場合、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:三稜鏡>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "「光は七色で構成されている」"
  },
  RelicConfig_13756_BattleDesc = {
    Text = "拾取時に他のすべてのつくりものを失い、ランダムに2つのゴールドクリエイションを獲得する。"
  },
  RelicConfig_13756_Desc = {
    Text = "拾取時に他のすべてのつくりものを失い、ランダムに2つのゴールドクリエイションを獲得する。"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆逆向観賞☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "奇妙な時代に、花は人類の最初の観賞者だった。\n動かないで、彼らは静かな展示品を好む。"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "使用する8枚目の指令カードは効果が2回発動する。"
  },
  RelicConfig_13757_Desc = {
    Text = "使用する8枚目の指令カードは効果が2回発動する。"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:星々の酒>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "星々の間を漂う。"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "拾得後、最大HPが[Arg1]点増加し、攻撃を受けた時に獲得する狂気が2点増加する。"
  },
  RelicConfig_13758_Desc = {
    Text = "拾得後、最大HPが[Arg1]点増加し、攻撃を受けた時に獲得する狂気が2点増加する。"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:甘いインク>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "誰かが言った、これは悪魔の血だと。でも、ねえ、試してみよう！"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "狂気解放を発動する時、敵がダメージを1回与えるごとに、その敵に [Arg1] 層の<IntoxicationIconKeywords:中毒>を付与する"
  },
  RelicConfig_13759_Desc = {
    Text = "狂気解放を発動する時、敵がダメージを1回与えるごとに、その敵に [Arg1] 層の<IntoxicationIconKeywords:中毒>を付与する"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆光を放つ顎骨☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "あるコレクターのプライベート展示室に陳列された遺骨。\nコレクターはその美しい蛍光に心を奪われ、日夜鑑賞し、最終的に枯れ果て、同類となった。"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "最大行動力が1増加する。前のカードより行動力消費が高いカードを2回連続で使用した時、1点の行動力を獲得する。"
  },
  RelicConfig_13760_Desc = {
    Text = "最大行動力が1増加する。前のカードより行動力消費が高いカードを2回連続で使用した時、1点の行動力を獲得する。"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:アルカナ記録>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "運命の動向。"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "ターン開始時に前のターンの残り手札が3枚以上の場合、2点の行動力を獲得。"
  },
  RelicConfig_13761_Desc = {
    Text = "ターン開始時に前のターンの残り手札が3枚以上の場合、2点の行動力を獲得。"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:ミサゴの校章>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "ミサゴ大学が調査員に配布する校章。それは身分証明だけでなく、遠隔通信も可能なツールだ。"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "「防御」使用時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_13762_Desc = {
    Text = "「防御」使用時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_13762_Name = {
    Text = "異化イラクサのベスト"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "付着した液体を識別できません。"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点のシールドを獲得。ターン開始時にシールドを所持している場合、そのターン中、シールドと治癒力強化+50%。"
  },
  RelicConfig_13763_Desc = {
    Text = "戦闘開始時、[Arg1]点のシールドを獲得。ターン開始時にシールドを所持している場合、そのターン中、シールドと治癒力強化+50%。"
  },
  RelicConfig_13763_Name = {
    Text = "異化花園の守護者"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "拾得時、永久に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13764_Desc = {
    Text = "拾得時、永久に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:ルビーのブローチ>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "赤がじわりと滲み出る。"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "拾取時にカードを1枚選択し、そのカードに2つの3択から1つを選んで強化効果を付与します。(注：千面幻象のカード生成に似ています)"
  },
  RelicConfig_13766_Desc = {
    Text = "拾取時にカードを1枚選択し、そのカードに2つの3択から1つを選んで強化効果を付与します。(注：千面幻象のカード生成に似ています)"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆名家のタイプライター☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "本当に名作を書いたのはタイプライターだという噂がある。"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "入手時、ランダムな上位刻印を3つの中から1つ選んで獲得し、それを対応するカードに付与する。"
  },
  RelicConfig_13767_Desc = {
    Text = "入手時、ランダムな上位刻印を3つの中から1つ選んで獲得し、それを対応するカードに付与する。"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:ラインデのパピルス>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "次の問題：10人の僧侶が6つのパンを分けると、1人いくつもらえる？"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "最大行動力が2増加する。「攻撃」または「防御」使用後、対応する覚醒体が5狂気を獲得する。「狂気解放」発動後、対応する覚醒体の<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「攻撃」を1枚獲得し、「キーオーダー」発動後、ランダムに<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「防御」を1枚獲得する。"
  },
  RelicConfig_13768_Desc = {
    Text = "最大行動力が2増加する。「攻撃」または「防御」使用後、対応する覚醒体が5狂気を獲得する。「狂気解放」発動後、対応する覚醒体の<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「攻撃」を1枚獲得し、「キーオーダー」発動後、ランダムに<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「防御」を1枚獲得する。"
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:時の振り子「翼」>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "ターン開始時<EmbryoFusionIconKeywords:胚胎融合>+30。すべての<DevouredIconKeywords:捕食>効果が<UnlimitedDevouredIconKeywords:無限捕食>に変わる。"
  },
  RelicConfig_13769_Desc = {
    Text = "ターン開始時<EmbryoFusionIconKeywords:胚胎融合>+30。すべての<DevouredIconKeywords:捕食>効果が<UnlimitedDevouredIconKeywords:無限捕食>に変わる。"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:蠢く臍の緒>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "首に絡みつく。"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "ターン開始時に[Arg1]シールドを獲得し、1ターン経過するごとにそのシールド値が[Arg2]増加する。"
  },
  RelicConfig_13770_Desc = {
    Text = "ターン開始時に[Arg1]シールドを獲得し、1ターン経過するごとにそのシールド値が[Arg2]増加する。"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:守護の手>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "祈福の手、堅い拳。"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "すべての覚醒体のキーチャージが30増加する。「キーオーダー」発動後、<DerivativeCardKeywords_4:「啓示」>を3枚あなたの山札のランダムな位置に追加する。"
  },
  RelicConfig_13771_Desc = {
    Text = "すべての覚醒体のキーチャージが30増加する。「キーオーダー」発動後、<DerivativeCardKeywords_4:「啓示」>を3枚あなたの山札のランダムな位置に追加する。"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:時の振り子「浅眠」>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "戦闘終了後、追加で75黒章と症状カードを1枚獲得する。"
  },
  RelicConfig_13772_Desc = {
    Text = "戦闘終了後、追加で75黒章と症状カードを1枚獲得する。"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:翡翠の拓印>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "この拓印は千年不朽です。"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "アクティブダメージを1回与えるたび、自身に[Arg1]点の<BleedingIconKeywords:出血>を付与し、ダメージを与えた対象に[Arg2]点の<BleedingIconKeywords:出血>を付与する。敵を1体撃破するたび、自身の<BleedingIconKeywords:出血>状態を解除する。"
  },
  RelicConfig_13773_Desc = {
    Text = "アクティブダメージを1回与えるたび、自身に[Arg1]点の<BleedingIconKeywords:出血>を付与し、ダメージを与えた対象に[Arg2]点の<BleedingIconKeywords:出血>を付与する。敵を1体撃破するたび、自身の<BleedingIconKeywords:出血>状態を解除する。"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:虫群の意識>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "絡みつく、共生、群れ；恐怖、未知、制御。"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "行動力消費が3のカードを1枚使用した時、カードを1枚引き、2点の行動力を獲得する。\n行動力消費が4以上のカードを1枚使用した時、他の手札の行動力消費が1減少する。"
  },
  RelicConfig_13774_Desc = {
    Text = "行動力消費が3のカードを1枚使用した時、カードを1枚引き、2点の行動力を獲得する。\n行動力消費が4以上のカードを1枚使用した時、他の手札の行動力消費が1減少する。"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:時の振り子「眼」>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "入手時に指令カードを1枚選択し、それに「固有」、「保持」、「使用後カードを1枚引く」を付与する。"
  },
  RelicConfig_13775_Desc = {
    Text = "入手時に指令カードを1枚選択し、それに「固有」、「保持」、「使用後カードを1枚引く」を付与する。"
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:ファイルフォルダー>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "嘘、これは君と僕だけの秘密の取引だ。"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "戦闘開始後、触腕を1本獲得する。"
  },
  RelicConfig_13776_Desc = {
    Text = "戦闘開始後、触腕を1本獲得する。"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:黄色い小さな貝>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "この小さな黄色いカタツムリは高貴な出自を持ち、完璧で非の打ち所がない。"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "奇数ターン終了時、行動力が残っている場合、次のターン追加でカードを2枚引く。偶数ターン終了時、手札が残っている場合、次のターン追加で2点の行動力を獲得。"
  },
  RelicConfig_13777_Desc = {
    Text = "奇数ターン終了時、行動力が残っている場合、次のターン追加でカードを2枚引く。偶数ターン終了時、手札が残っている場合、次のターン追加で2点の行動力を獲得。"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:日月ルーレット>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "黒か白か、どっちだと思う？"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "触腕上限が1本増加する。ライフが50％以下の時、<TentacleInjurieIconKeywords:触腕ダメージ>が[Arg1]増加する。"
  },
  RelicConfig_13778_Desc = {
    Text = "触腕上限が1本増加する。ライフが50％以下の時、<TentacleInjurieIconKeywords:触腕ダメージ>が[Arg1]増加する。"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:海の歌>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "織紋螺などの食べられない動物が海洋の約80%の栄養を吸収していると言われています。"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "ターン開始時にカードを1枚引き、ターン終了時に手札を1枚保持することを選択できる。"
  },
  RelicConfig_13779_Desc = {
    Text = "ターン開始時にカードを1枚引き、ターン終了時に手札を1枚保持することを選択できる。"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:予言者のランプ>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "君の願いに応える。"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "狂気解放を発動するたびに、<DerivativeCardKeywords_7:「毒性侵染」>を1枚獲得する。手札に<DerivativeCardKeywords_7:「毒性侵染」>が3枚ある場合、<IntoxicationIconKeywords:中毒>を発動する<DerivativeCardKeywords_8:「毒性発作」>1枚に合成する。"
  },
  RelicConfig_13780_Desc = {
    Text = "狂気解放を発動するたびに、<DerivativeCardKeywords_7:「毒性侵染」>を1枚獲得する。手札に<DerivativeCardKeywords_7:「毒性侵染」>が3枚ある場合、<IntoxicationIconKeywords:中毒>を発動する<DerivativeCardKeywords_8:「毒性発作」>1枚に合成する。"
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:異種の舌>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "彼は悪魔ではないが、確かに異界の囁きを伝える。"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "1黒章を消費するごとに、すべての覚醒体が1狂気を獲得する。"
  },
  RelicConfig_13781_Desc = {
    Text = "1黒章を消費するごとに、すべての覚醒体が1狂気を獲得する。"
  },
  RelicConfig_13782_BattleDesc = {
    Text = "ダメージを無効化"
  },
  RelicConfig_13782_Desc = {
    Text = "ダメージを無効化"
  },
  RelicConfig_13782_Name = {
    Text = "テスト遺物"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "毎ターン3枚目のカードを使用した後に、<DerivativeCardKeywords_4:「啓示」>を1枚捨て札に追加。毎ターン6枚目のカードを使用した後に、捨て札から<DerivativeCardKeywords_4:「啓示」>を1枚手札に追加する。"
  },
  RelicConfig_13783_Desc = {
    Text = "毎ターン3枚目のカードを使用した後に、<DerivativeCardKeywords_4:「啓示」>を1枚捨て札に追加。毎ターン6枚目のカードを使用した後に、捨て札から<DerivativeCardKeywords_4:「啓示」>を1枚手札に追加する。"
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:文明の光>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "夜を切り裂く流星。"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "ターン開始時、敵1体につき1点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージに等しい<BleedingIconKeywords:出血>を付与。"
  },
  RelicConfig_13784_Desc = {
    Text = "ターン開始時、敵1体につき1点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージに等しい<BleedingIconKeywords:出血>を付与。"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:群衆の歌>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "あなたの耳を苦しめるために生まれた。"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "ターン終了時<EmbryoFusionIconKeywords:胚胎融合>+15、手札に<DerivativeCardKeywords_2:「胚胎」>がある場合、[Arg1]ライフを回復する。"
  },
  RelicConfig_13785_Desc = {
    Text = "ターン終了時<EmbryoFusionIconKeywords:胚胎融合>+15、手札に<DerivativeCardKeywords_2:「胚胎」>がある場合、[Arg1]ライフを回復する。"
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:疫病診断書>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "疫病——自然の無意識な苛立ちの偶然の表れ。"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "狂気解放を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_13786_Desc = {
    Text = "狂気解放を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:重鎖>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "厚くて頑丈な鍵、キーがなければ開けるのは難しそうだ。\nもちろん、ある神盗みには大したことではない。"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "ターン開始時にランダムな敵1体に[Arg1]点の<FixedDamage:純粋ダメージ>を与える。このバトル中に「打撃」を7回発射した後、ダメージ値が[Arg2]になり、「打撃」を21回発射した後、即座に全ての敵に[Arg3]点の<FixedDamage:純粋ダメージ>を与える。"
  },
  RelicConfig_13787_Desc = {
    Text = "ターン開始時にランダムな敵1体に[Arg1]点の<FixedDamage:純粋ダメージ>を与える。このバトル中に「打撃」を7回発射した後、ダメージ値が[Arg2]になり、「打撃」を21回発射した後、即座に全ての敵に[Arg3]点の<FixedDamage:純粋ダメージ>を与える。"
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:古いパズル>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "重い額縁に収められていた芸術品は、展示された初日からピースが一つ欠けていた。"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "触腕上限 -2。ターン終了時にすべての触腕が追加攻撃を1回行う。__「開発用」"
  },
  RelicConfig_13788_Desc = {
    Text = "触腕上限 -2。ターン終了時にすべての触腕が追加攻撃を1回行う。__「開発用」"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:苦痛の聖腕>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "苦痛を楽しめ。"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "山札がリセットされるたび、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13789_Desc = {
    Text = "山札がリセットされるたび、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:号泣パイプ>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "これは憎しみの産物か、それとも復讐の結果か？"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "マップ移動のたび10黒章を獲得するが、マップ移動による心労値が10点増加する。"
  },
  RelicConfig_13790_Desc = {
    Text = "マップ移動のたび10黒章を獲得するが、マップ移動による心労値が10点増加する。"
  },
  RelicConfig_13790_Name = {Text = "無底袋"},
  RelicConfig_13791_BattleDesc = {
    Text = "この遺物を入手した時に指令カードを1枚選択し、そのコピーを1枚山札に加える。"
  },
  RelicConfig_13791_Desc = {
    Text = "この遺物を入手した時に指令カードを1枚選択し、そのコピーを1枚山札に加える。"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:一瞬の火>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "揺れる光、微かな希望。"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "ライフを失うたびに、<EmbryoFusionIconKeywords:胚胎融合>+10。ライフが50％未満の場合、効果が倍になる。"
  },
  RelicConfig_13792_Desc = {
    Text = "ライフを失うたびに、<EmbryoFusionIconKeywords:胚胎融合>+10。ライフが50％未満の場合、効果が倍になる。"
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:錆びた鋸>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "解剖医の目に映るのは、美しい女性ではなく——骨、病の神経、炎症を起こした筋肉と組織だけ。"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "入手時にチームの黒章ドロップが元の値の150%になる。ライフ回復後、すべての覚醒体が3狂気を獲得する。ライフ喪失後、[Arg1]点の<PowerIconKeywords:力>と触腕ダメージを獲得し、毎ターン合計で最大5回まで発動する。"
  },
  RelicConfig_13793_Desc = {
    Text = "入手時にチームの黒章ドロップが元の値の150%になる。ライフ回復後、すべての覚醒体が3狂気を獲得する。ライフ喪失後、[Arg1]点の<PowerIconKeywords:力>と触腕ダメージを獲得し、毎ターン合計で最大5回まで発動する。"
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:時の振り子「月」>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "ターン終了後、すべての覚醒体が5狂気を獲得。残り行動力1点ごとに、すべての覚醒体が追加で3狂気を獲得。"
  },
  RelicConfig_13794_Desc = {
    Text = "ターン終了後、すべての覚醒体が5狂気を獲得。残り行動力1点ごとに、すべての覚醒体が追加で3狂気を獲得。"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:原型電池>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "携帯用の希望。"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "最大行動力が1増加。"
  },
  RelicConfig_13795_Desc = {
    Text = "最大行動力が1増加。"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "痙攣も活性の一種だ。"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "戦闘終了時、ライフ残量が50%以下の場合、1つの低級遺物にアップグレードする。"
  },
  RelicConfig_13796_Desc = {
    Text = "戦闘終了時、ライフが50％以下の場合、白銀造物にアップグレードする。"
  },
  RelicConfig_13796_Name = {
    Text = "古びたノート2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "古い日記、中に挿しこまれたページがいっぱいで、アイズルワースの地図、実験記録、三角の融蝕痕がついた手紙がざっと見える。\n初めの内容は端正に書かれているが、後に進むにつれて乱雑になっていく。"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "攻撃カードを3枚使用した後、1つの高級遺物にアップグレードする。"
  },
  RelicConfig_13797_Desc = {
    Text = "「攻撃」を3枚使用した後、黄金造物にアップグレードする。"
  },
  RelicConfig_13797_Name = {
    Text = "古びたノート1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "古い日記、中に挿しこまれたページがいっぱいで、アイズルワースの地図、実験記録、三角の融蝕痕がついた手紙がざっと見える。\n初めの内容は端正に書かれているが、後に進むにつれて乱雑になっていく。"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "戦闘開始時、すべての症状カードが<NothingnessIconKeywords:虚無>を獲得し、山札の症状カード1枚につき[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13798_Desc = {
    Text = "戦闘開始時、すべての症状カードが<NothingnessIconKeywords:虚無>を獲得し、山札の症状カード1枚につき[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:ハーフォードの霊薬>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "成分不明の薬物。\n有名なバイオリニストのエリックが愛用していたらしい。"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "戦闘の最初のターン開始時、<DerivativeCardKeywords_1:「影の残響」>を手札に追加する。第2ターンに<DerivativeCardKeywords_41:「シルバーキー共鳴」>を手札に追加する。第3ターンに<DerivativeCardKeywords_39:「過去の響き」>を手札に追加する。"
  },
  RelicConfig_13799_Desc = {
    Text = "戦闘の最初のターン開始時、<DerivativeCardKeywords_1:「影の残響」>を手札に追加する。第2ターンに<DerivativeCardKeywords_41:「シルバーキー共鳴」>を手札に追加する。第3ターンに<DerivativeCardKeywords_39:「過去の響き」>を手札に追加する。"
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:時の振り子「星々」>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_6:「日傘」>を1枚手札に追加し、カードを6枚使用した後、手札のすべての<DerivativeCardKeywords_6:「日傘」>の<AlertIconKeywords:警戒>が[Arg2]点増加する。"
  },
  RelicConfig_13800_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_6:「日傘」>を1枚手札に追加し、カードを6枚使用した後、手札のすべての<DerivativeCardKeywords_6:「日傘」>の<AlertIconKeywords:警戒>が[Arg2]点増加する。"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:旅行用の日傘>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "光のない地で咲く。"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "通常戦闘中、すべての敵のライフが30%増加し、戦闘勝利時、追加で25黒章を獲得する。"
  },
  RelicConfig_13801_Desc = {
    Text = "通常戦闘中、すべての敵のライフが30%増加し、戦闘勝利時、追加で25黒章を獲得する。"
  },
  RelicConfig_13801_Name = {
    Text = "破れた戦旗"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "拾得時、最大ライフが[Arg1]増加。拾得時にライフが25%未満の場合、最大ライフの増加は[Arg2]になる。"
  },
  RelicConfig_13802_Desc = {
    Text = "拾得時、最大ライフが[Arg1]増加。拾得時にライフが25%未満の場合、最大ライフの増加は[Arg2]になる。"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:セイロンティー>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "健康な食事は私たちから。"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "3ターンごとに一時的な触腕を3本獲得する。"
  },
  RelicConfig_13803_Desc = {
    Text = "3ターンごとに一時的な触腕を3本獲得する。"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:潜水ヘルメット>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "夢は星の海！"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "ターン終了時、[Arg1]点のシールドを獲得する。シールドが0または3の倍数の場合、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13804_Desc = {
    Text = "ターン終了時、[Arg1]点のシールドを獲得する。シールドが0または3の倍数の場合、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:救難信号>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "彼は救援を待たなかった。"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "症状カードを引いた時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。呪われた遺物を1つ持つごとにクリティカル率とクリティカルダメージが10%増加する。"
  },
  RelicConfig_13806_Desc = {
    Text = "症状カードを引いた時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。呪われた遺物を1つ持つごとにクリティカル率とクリティカルダメージが10%増加する。"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:深淵の通信>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "人けのない郊外、孤独な電話ボックスでベルが鳴る。\n「暗……シー……無限の……シーシー……闇……」"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "戦闘開始時<EmbryoFusionIconKeywords:胚胎融合>+50。狂気が50点以上の覚醒体が1名存在するごとに、追加で1回発動する"
  },
  RelicConfig_13807_Desc = {
    Text = "戦闘開始時<EmbryoFusionIconKeywords:胚胎融合>+50。狂気が50点以上の覚醒体が1名存在するごとに、追加で1回発動する。"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:親愛なる宝物>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "木工は妻のために生き生きとした木偶を作りました。それは彼らの息子の代わりに、彼女の腹の中で眠るのです。"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "「狂気解放」発動後、対応する覚醒体のランダムなカード1枚を手札に追加し、そのカードは<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を獲得する。戦闘終了後、ライフを[Arg1]点回復する。"
  },
  RelicConfig_13808_Desc = {
    Text = "「狂気解放」発動後、対応する覚醒体のランダムなカード1枚を手札に追加し、そのカードは<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を獲得する。戦闘終了後、ライフを[Arg1]点回復する。"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:医者のカバン>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "医者の象徴である重い手提げ箱。\n開けるのは本物の医者とは限らない。"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "すべての遺物の価格が20減少する。"
  },
  RelicConfig_13809_Desc = {
    Text = "すべての遺物の価格が20減少する。"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:鋭い舌>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "話が上手いのは商人だけでなく、信者もいる。"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "「打撃」を3回発射するたびに、全ての敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、対応する覚醒体は狂気を15獲得する。"
  },
  RelicConfig_13811_Desc = {
    Text = "「打撃」を3回発射するたびに、全ての敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、対応する覚醒体は狂気を15獲得する。"
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:錆びた柳葉刀>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "生体の切開には適していない。"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "取得時に最大ライフが100％増加し、ターン開始時に[Arg1]ポイントのライフを失います。"
  },
  RelicConfig_13812_Desc = {
    Text = "取得時に最大ライフが100％増加し、ターン開始時に[Arg1]ポイントのライフを失います。"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆長生者の肉☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "「海洋生物は腕を切り離して生き延びることが多い」"
  },
  RelicConfig_13813_BattleDesc = {
    Text = "戦闘開始後、エリート敵とボス敵の現在ライフが20%減少する。"
  },
  RelicConfig_13813_Desc = {
    Text = "戦闘開始後、エリート敵とボス敵の現在ライフが20%減少する。"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆古い船の錨☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "家に帰れ、老水夫よ。"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "ターン終了時に手札に使用していないカードが1枚あるごとに、すべての覚醒体が2狂気を獲得する。"
  },
  RelicConfig_13814_Desc = {
    Text = "ターン終了時に手札に使用していないカードが1枚あるごとに、すべての覚醒体が2狂気を獲得する。"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:不均衡な天秤>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "正義の象徴ではなくなった。"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "拾取後、カードを1選択し、その計算力消費を永久に1にする。"
  },
  RelicConfig_13815_Desc = {
    Text = "拾取後、カードを1選択し、その計算力消費を永久に1にする。"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆精巧な義眼☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "もはや純潔ではない眼球。"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "戦闘開始時、すべての敵が[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。ダメージを与えるたび、狂気が最も低い覚醒体が6点の狂気を獲得する。"
  },
  RelicConfig_13816_Desc = {
    Text = "戦闘開始時、すべての敵が[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。ダメージを与えるたび、狂気が最も低い覚醒体が6点の狂気を獲得する。"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆哀鳴の鈴☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "チリン、チリン、子供が泣いている。\nチリン、チリン、子供が叫んでいる。\nチリン、チリン、子供が嘆いている。\nチリン、チリン、お腹が空いているのがわかるでしょう。"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "指令カードを6枚使用するたび、<TentacleInjurieIconKeywords:触腕ダメージ>+[Arg1]。"
  },
  RelicConfig_13817_Desc = {
    Text = "指令カードを6枚使用するたび、<TentacleInjurieIconKeywords:触腕ダメージ>+[Arg1]。"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:裂頭条虫>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "私たちの脳が謎である限り、中に触腕が生えていても驚くことはない。"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "クリティカル率が50%増加するが、戦闘開始時に自身に3ターンの<FragileIconKeywords:抑圧>を付与する。"
  },
  RelicConfig_13818_Desc = {
    Text = "クリティカル率が50%増加するが、戦闘開始時に自身に3ターンの<FragileIconKeywords:抑圧>を付与する。"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:奇異な鉤爪>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "識別不能な種。"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "行動力消費が3以上のカードを1枚使用した時、カードを1枚引き、1点の行動力を獲得する。"
  },
  RelicConfig_13819_Desc = {
    Text = "行動力消費が3以上のカードを1枚使用した時、カードを1枚引き、1点の行動力を獲得する。"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆失われた美☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "彼女の美しさを覚えている者はいない。"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "症状カードを獲得するたびに、最大ライフが [Arg1] ポイント上昇します。"
  },
  RelicConfig_13820_Desc = {
    Text = "症状カードを獲得するたびに、最大ライフが [Arg1] ポイント上昇します。"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆乳香製剤☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "「甘い誘惑の香り」"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "狂気解放を発動すると、カードを1枚引く。ライフが25%未満の場合、1枚引く。"
  },
  RelicConfig_13821_Desc = {
    Text = "狂気解放を発動すると、カードを1枚引く。ライフが25%未満の場合、1枚引く。"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:知識の読書輪>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "読書中は安全に注意してください。"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "毎ターン能動ダメージを与えた時、[Arg1]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>を増加させる。最大3回までスタック可能。スタックが最大になると、触腕上限を無視する一時的な触腕を1本生成する。"
  },
  RelicConfig_13822_Desc = {
    Text = "毎ターンアクティブダメージを与えた時、[Arg1]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、最大3回まで累積する。層数が上限に達した時、触腕上限を無視する一時的な触腕を1本生成する。"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:ルルイエの歓喜>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "長眠の主よ、汝を夢に待つ。"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "[Arg1]枚目の指令カードは効果が2回発動し、使用後手札に戻る。"
  },
  RelicConfig_13823_Desc = {
    Text = "[Arg1]枚目の指令カードは効果が2回発動し、使用後手札に戻る。"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:星々の酒+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "星々の間を漂う。"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "毎ターン開始時、<DeathResistanceIconKeywords:死亡抵抗>が10%増加する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>が100%以上の場合、<ProficientInRealmsIconKeywords:界域知識>が100増加する。"
  },
  RelicConfig_13824_Desc = {
    Text = "毎ターン開始時、<DeathResistanceIconKeywords:死亡抵抗>が10%増加する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>が100%以上の場合、<ProficientInRealmsIconKeywords:界域知識>が100増加する。"
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:人魚の涙>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "それを水に入れないで。"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "10黒章を消費するごとに、ライフを[Arg1]点回復する。"
  },
  RelicConfig_13825_Desc = {
    Text = "10黒章を消費するごとに、ライフを1%回復する。"
  },
  RelicConfig_13826_BattleDesc = {
    Text = "「増益カード」/「症状カード」/「状態カード」を使用するたびに、狂気が最も低い覚醒体が10狂気を獲得。"
  },
  RelicConfig_13826_Desc = {
    Text = "「増益カード」/「症状カード」/「状態カード」を使用するたびに、狂気が最も低い覚醒体が10狂気を獲得。"
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:異国の切手帳>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "量化された思い。"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "獲得時、75黒章を獲得。1つの遺物を選択し、ランダムな呪われた遺物に変化させる。"
  },
  RelicConfig_13827_Desc = {
    Text = "獲得時、75黒章を獲得。1つの遺物を選択し、ランダムな呪われた遺物に変化させる。"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:呪いの石碑>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "撫でると深海の呼び声が聞こえた。"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "毎ターン初めて指令カードを使用し捨て札になった後、行動力消費が1減少したそのカードの一時的なコピーを山札のランダムな位置に追加する。"
  },
  RelicConfig_13828_Desc = {
    Text = "毎ターン初めて指令カードを使用し捨て札になった後、行動力消費が1減少したそのカードの一時的なコピーを山札のランダムな位置に追加する。"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:声を失った蓄音機>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "彼の声は風の中に消えた。"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "錆びた鍵束。\n扉の鍵を解放するために使用する。"
  },
  RelicConfig_13829_Desc = {
    Text = "錆びた鍵束。\n扉の鍵を解放するために使用する。"
  },
  RelicConfig_13829_Name = {Text = "扉の鍵"},
  RelicConfig_13830_BattleDesc = {
    Text = "ライフ回復を与えた時、[Arg1]点のシールドも獲得する。第3ターン開始後、[Arg2]点の<AlertIconKeywords:警戒>を獲得する。"
  },
  RelicConfig_13830_Desc = {
    Text = "ライフ回復を与えた時、[Arg1]点のシールドも獲得する。第3ターン開始後、[Arg2]点の<AlertIconKeywords:警戒>を獲得する。"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:蝶の標本>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "今でも、彼は誰かに深く愛されている。"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "指令カード1枚が<DimensionalSpaceIconKeywords:超次元空間>に入った後、対応する覚醒体に15狂気を獲得させる。"
  },
  RelicConfig_13831_Desc = {
    Text = "指令カード1枚が<DimensionalSpaceIconKeywords:超次元空間>に入った後、対応する覚醒体に15狂気を獲得させる。"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:時間の虫>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "時計店と昆虫博物館に同時に存在する懐中時計。\n洪積元年以降、大学のコレクションに加えられた。"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "超次元ターンに入った後、自身の<WeaknessIconKeywords:衰弱>と<FragileIconKeywords:脆弱>状態を解除し、すべての敵に3ターンの<WeaknessIconKeywords:衰弱>と<VulnerabilityIconKeywords:易傷>を付与する。このターン、すべての覚醒体の最終ダメージが15％増加する。"
  },
  RelicConfig_13832_Desc = {
    Text = "超次元ターンに入った後、自身の<WeaknessIconKeywords:衰弱>と<FragileIconKeywords:脆弱>状態を解除し、すべての敵に3ターンの<WeaknessIconKeywords:衰弱>と<VulnerabilityIconKeywords:易傷>を付与する。このターン、すべての覚醒体の最終ダメージが15％増加する。"
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:超弦懐中時計>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "「あら、懐中時計が止まった」"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "ダメージを1回与えるたび、対象に[Arg1]層の<IntoxicationIconKeywords:中毒>を付与する。この戦闘内で発動回数が累計25回に達すると、全体の敵の<IntoxicationIconKeywords:中毒>を即座に発動する。"
  },
  RelicConfig_13833_Desc = {
    Text = "ダメージを1回与えるたび、対象に[Arg1]層の<IntoxicationIconKeywords:中毒>を付与する。この戦闘内で発動回数が累計25回に達すると、全体の敵の<IntoxicationIconKeywords:中毒>を即座に発動する。"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆埃をかぶったミシン☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "慈愛に満ちた母親が心の傷を縫い合わせる。"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "5回目のシールド獲得時、同時に<RetaliateIconKeywords:反撃>を獲得し、反撃値は獲得したシールドの[Arg1]%に等しい。"
  },
  RelicConfig_13834_Desc = {
    Text = "5回目のシールド獲得時、同時に<RetaliateIconKeywords:反撃>を獲得し、反撃値は獲得したシールドの[Arg1]%に等しい。"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:賢者の断章>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "「人類はなんて愚かなんだ、古臭いものを盲信する」"
  },
  RelicConfig_13835_BattleDesc = {
    Text = "ターン開始時にカードを1枚引く。"
  },
  RelicConfig_13835_Desc = {
    Text = "ターン開始時にカードを1枚引く。"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:方位磁針>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "指示するのは方向ではなく、磁場だ。"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "戦闘開始時、ランダムに<DerivativeCardKeywords_3:「痙攣」>と<DerivativeCardKeywords_4:「霊感」>を<DimensionalSpaceIconKeywords:超次元空間>に上限まで配置する。超次元ターンに入った後、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13836_Desc = {
    Text = "戦闘開始時、ランダムに<DerivativeCardKeywords_3:「痙攣」>と<DerivativeCardKeywords_4:「霊感」>を<DimensionalSpaceIconKeywords:超次元空間>に上限まで配置する。超次元ターンに入った後、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:アルフォンソの器>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "運命の無常とは異なり、星々には独自の法則がある。"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "入手時、100%の<DeathResistanceIconKeywords:死亡抵抗>を獲得する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>発動後、この戦闘中毎ターン開始時にライフを[Arg1]点回復する。"
  },
  RelicConfig_13837_Desc = {
    Text = "入手時、100%の<DeathResistanceIconKeywords:死亡抵抗>を獲得する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>発動後、この戦闘中毎ターン開始時にライフを[Arg1]点回復する。"
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:人口呼吸>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "探検者に必須のアイテム。過度に依存すると、それがあなたの一部になる。"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "これは効果のないステージ遺物2だ。"
  },
  RelicConfig_13838_Desc = {
    Text = "これは効果のないステージ遺物2だ。"
  },
  RelicConfig_13838_Name = {
    Text = "任務遺物テスト2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "内容を補充する必要がある遺物。"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "手札の最後の 1 枚をプレイした時、2 枚ドローする。毎ターン最大 2 回まで発動する。"
  },
  RelicConfig_13839_Desc = {
    Text = "手札の最後の 1 枚をプレイした時、2 枚ドローする。毎ターン最大 2 回まで発動する。"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆マジックグローブ☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "「怖がらないで、ただの手品だよ」"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "3ターンごとにすべての敵に1層の<WeaknessIconKeywords:虚弱>を付与する。<WeaknessIconKeywords:虚弱>状態の敵にダメージを与えた後、[Arg1]点の一時的な<PowerIconKeywords:力量>を獲得する。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13840_Desc = {
    Text = "3ターンごとにすべての敵に1層の<WeaknessIconKeywords:虚弱>を付与する。<WeaknessIconKeywords:虚弱>状態の敵にダメージを与えた後、[Arg1]点の一時的な<PowerIconKeywords:力量>を獲得する。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:悪童>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "純粋な悪から生まれたもの。それが彼の望みでは、なかったとしても。"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "すべての「攻撃」が与えるクリティカルダメージが20%増加する。戦闘開始時、<DerivativeCardKeywords_40:「美しい瞬間」>を1枚手札に追加する。"
  },
  RelicConfig_13841_Desc = {
    Text = "すべての「攻撃」が与えるクリティカルダメージが20%増加する。戦闘開始時、<DerivativeCardKeywords_40:「美しい瞬間」>を1枚手札に追加する。"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:美しい瞬間>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "刹那の美を永遠に保存する。"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "死亡抵抗が発動しなかった致命ダメージを一度無効化し、ライフを[Arg1]点回復し、この造物を永久に無効にする。"
  },
  RelicConfig_13842_Desc = {
    Text = "死亡抵抗が発動しなかった致命ダメージを一度無効化し、ライフを[Arg1]点回復し、この造物を永久に無効にする。"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:身代わり人形>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "フフフ、ウフフ。あなたが私に借りがあるのよ？"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "<WeaknessIconKeywords:倦怠>を付与した時、[Arg1]点のシールドを獲得する。<VulnerabilityIconKeywords:軟化>を付与した時、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。1ターン内にこの2つの効果を発動した場合、追加で[Arg1]点のシールドと[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13844_Desc = {
    Text = "<WeaknessIconKeywords:倦怠>を付与した時、[Arg1]点のシールドを獲得する。<VulnerabilityIconKeywords:軟化>を付与した時、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。1ターン内にこの2つの効果を発動した場合、追加で[Arg1]点のシールドと[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:重い額縁>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "狂気の芸術家が残した最後の作品。彼の恐怖の表情が見えると言われている。"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "最後の1の行動力を使い果たすと、2点の行動力を獲得。1ターンに最大2回まで発動。"
  },
  RelicConfig_13845_Desc = {
    Text = "最後の1の行動力を使い果たすと、2点の行動力を獲得。1ターンに最大2回まで発動。"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆銀白の演算器☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "「それは歴史を変えた」"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "ライフを失うたび、[Arg1]点の<PowerIconKeywords:力>を獲得する。各戦闘で最大10回までスタック可能。スタックが満了時、失ったライフの25％を回復する。"
  },
  RelicConfig_13846_Desc = {
    Text = "ライフを失うたび、[Arg1]点の<PowerIconKeywords:力>を獲得する。各戦闘で最大10回までスタック可能。スタックが満了時、失ったライフの25％を回復する。"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:無上の栄誉>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "優雅で神秘的な黒猫、遠い砂漠の国で神の化身とされていたという。しかし、その神の名は今や誰も知らない。\n崇拝され、敬われ、忘れられる、それが神の宿命かもしれない。"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "デバフ状態の敵に与えるダメージが20%増加し、敵を撃破した後、撃破者は20狂気を獲得する。"
  },
  RelicConfig_13847_Desc = {
    Text = "デバフ状態の敵に与えるダメージが20%増加し、敵を撃破した後、撃破者は20狂気を獲得する。"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:祭司の杖>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "許されない信仰。"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "入手時にチームの界域知識が元の値の150%になる。毎ターン5枚目の「指令カード」を使用した後に、すべての覚醒体が20狂気を獲得する。"
  },
  RelicConfig_13848_Desc = {
    Text = "入手時にチームの界域知識が元の値の150%になる。毎ターン5枚目の「指令カード」を使用した後に、すべての覚醒体が20狂気を獲得する。"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:時の振り子「不浄」>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "毎ターン3回目のダメージを与えた後、[Arg1]点のシールドを獲得する。毎ターン6回目のダメージを与えた後、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13849_Desc = {
    Text = "毎ターン3回目のダメージを与えた後、[Arg1]点のシールドを獲得する。毎ターン6回目のダメージを与えた後、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:非常口>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "どうやら彼も逃げられなかったようだ。"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "<DevouredIconKeywords:捕食>を1回行うたびに、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_13851_Desc = {
    Text = "<DevouredIconKeywords:捕食>を1回行うたびに、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:スリの名人>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "殺人と略奪のための最高の道具。"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "入手時に覚醒体を1体選択して覚醒させ、その覚醒カードの行動力消費が永久に1減少する。"
  },
  RelicConfig_13852_Desc = {
    Text = "入手時に覚醒体を1体選択して覚醒させ、その覚醒カードの行動力消費が永久に1減少する。"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:イースターエッグ>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "楽しんでください、でも食べないでください。"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "ダメージを与えるたびに[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得する。毎ターン最大5回まで発動し、5回目の発動時に<DerivativeCardKeywords_4:「霊感」>を1枚山札に加える。"
  },
  RelicConfig_13853_Desc = {
    Text = "ダメージを与えるたびに[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得する。毎ターン最大5回まで発動し、5回目の発動時に<DerivativeCardKeywords_4:「霊感」>を1枚山札に加える。"
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:遺失の祭祀刀>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "刃が曲がった短剣。祭祀儀式に使われることが多い。"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "ターン開始時にカードを2枚引き、2点の行動力を獲得する。指令カードまたは霊知覚醒を1枚引くたび、その行動力消費をランダムに変化させる。（0-4）"
  },
  RelicConfig_13854_Desc = {
    Text = "ターン開始時にカードを2枚引き、2点の行動力を獲得する。指令カードまたは霊知覚醒を1枚引くたび、その行動力消費をランダムに変化させる。（0-4）"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:奇術のハット>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "ようこそ、カーシア嬢の幻想のサーカスへ！\nお気をつけて、マジック道具には触れないでくださいね。\n万が一噛まれたら、それは大変なことになります。\nなにしろ、最後に血の味を覚えたとき——その後の顛末は、恐ろしいものでしたから。\n\nシルクハットがまばたきをする。\nまるでいつでも羽化する準備ができているように。"
  },
  RelicConfig_13855_BattleDesc = {
    Text = "ターン開始時および毎ターンのライフ回復時に[Arg1]点の<RetaliateIconKeywords:カウンター>を獲得し、毎ターン最大3回まで獲得できる。上限に達した時、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13855_Desc = {
    Text = "ターン開始時および毎ターンのライフ回復時に[Arg1]点の<RetaliateIconKeywords:カウンター>を獲得し、毎ターン最大3回まで獲得できる。上限に達した時、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:小さなオルゴール>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "デクスターの邸宅には多くのコレクションがあり、壊れる前の小さなオルゴールはデクスターの娘が最も気に入っていたおもちゃでした。\n時が経ち、デクスターの娘が再びそれを見つけた時、ギアは緩み、音楽は変調していましたが、まだ回り続けていました。"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "クリティカルダメージが15%増加する。「攻撃」のクリティカル率が40%増加する。"
  },
  RelicConfig_13856_Desc = {
    Text = "クリティカルダメージが15%増加する。「攻撃」のクリティカル率が40%増加する。"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:白いカラスのくちばし>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "それの前には秘密などない。"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "狂気解放を発動した後、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。この戦闘内で6回目の発動時、あなたの<RetaliateIconKeywords:反撃>を倍にする。"
  },
  RelicConfig_13857_Desc = {
    Text = "狂気解放を発動した後、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。この戦闘内で6回目の発動時、あなたの<RetaliateIconKeywords:反撃>を倍にする。"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆六分儀☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "君の導きは、ただの迷い道だ。"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "毎ターン追加でカードを1枚引き、行動力を1点獲得する。"
  },
  RelicConfig_13858_Desc = {
    Text = "毎ターン追加でカードを1枚引き、行動力を1点獲得する。"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆美しい思い出☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "誰かがあの夏に永遠に留まった。"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "ターン開始時にカードを1枚引く。戦闘開始時、<DerivativeCardKeywords_4:「啓示」>を1枚あなたの山札のランダムな位置に追加する。戦闘に1回勝利するたび、追加される<DerivativeCardKeywords_4:「啓示」>が1枚増加する。最大3回まで。"
  },
  RelicConfig_13859_Desc = {
    Text = "ターン開始時にカードを1枚引く。戦闘開始時、<DerivativeCardKeywords_4:「啓示」>を1枚あなたの山札のランダムな位置に追加する。戦闘に1回勝利するたび、追加される<DerivativeCardKeywords_4:「啓示」>が1枚増加する。最大3回まで。"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:プラスノの鏡>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "光と影のトリック。"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "同一覚醒体のカードを連続で使う度、その覚醒体は8狂気を獲得。"
  },
  RelicConfig_13860_Desc = {
    Text = "同一覚醒体のカードを連続で使う度、その覚醒体は8狂気を獲得。"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:精密タイマー>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "人類が発明した中で最悪の発明の一つだ。"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "入手時に覚醒体のカードを1枚選択し、その行動力消費を1減少させ、それを「攻撃」とみなす。"
  },
  RelicConfig_13861_Desc = {
    Text = "入手時に覚醒体のカードを1枚選択し、その行動力消費を1減少させ、それを「攻撃」とみなす。"
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:偶然の誤り>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "思い切り笑え！"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "入手後、永久に[Arg1]<PowerIconKeywords:力量>を失う。ダメージを与えるたび、[Arg2]点のライフを回復する。毎ターン最大6回まで発動。"
  },
  RelicConfig_13862_Desc = {
    Text = "入手後、永久に[Arg1]<PowerIconKeywords:力量>を失う。ダメージを与えるたび、[Arg2]点のライフを回復する。毎ターン最大6回まで発動。"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:ヤツメウナギのキス>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "深いキスが欲しいですか？命を奪うような。"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "各戦闘の最初のターンに、3点の行動力を獲得する。"
  },
  RelicConfig_13863_Desc = {
    Text = "各戦闘の最初のターンに、3点の行動力を獲得する。"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:懐中時計の鏡>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "記憶が過去の時間に凝固し、黒い底に深く埋もれている。"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "毎ターン初めて指令カードを使用した後に、対応する覚醒体の「攻撃」1枚を手札に追加し、それに<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:除外>を付与する。"
  },
  RelicConfig_13864_Desc = {
    Text = "毎ターン初めて指令カードを使用した後に、対応する覚醒体の「攻撃」1枚を手札に追加し、それに<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:除外>を付与する。"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:新型車軸>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "田舎から都市へ、災厄から復興へ。"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "ターン中に最初に指令カードを使用した後、対応する覚醒体の「防御」を1枚手札に追加、<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:除外>を付与。"
  },
  RelicConfig_13865_Desc = {
    Text = "ターン中に最初に指令カードを使用した後、対応する覚醒体の「防御」を1枚手札に追加、<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:除外>を付与。"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:静かな序曲>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "有名なバイオリニスト、エリック・エイクシュタインのバイオリン。\n今では、もう演奏することはできない。"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "3ターンごとにすべての敵に1層の<VulnerabilityIconKeywords:易傷>を付与する。<VulnerabilityIconKeywords:易傷>状態の敵にダメージを与えた後、対象の一時的な<PowerIconKeywords:力量>を[Arg1]点減少させる。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13866_Desc = {
    Text = "3ターンごとにすべての敵に1層の<VulnerabilityIconKeywords:易傷>を付与する。<VulnerabilityIconKeywords:易傷>状態の敵にダメージを与えた後、対象の一時的な<PowerIconKeywords:力量>を[Arg1]点減少させる。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:春の祭り>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "夜の笑い声の中、カヌーの影が湖面を滑っていた。"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "手札上限が3増加するが、毎ターンのドロー枚数が1減少する。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_13867_Desc = {
    Text = "手札上限が3増加するが、毎ターンのドロー枚数が1減少する。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:意識の刻印>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "古い部族は、死者の頭に特別な印を刻むことで、その魂を留め、永遠の伴侶を獲得。と信じていた。"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "狂気解放を4回発動するごとに、すべての手札の行動力消費が1減少する。"
  },
  RelicConfig_13868_Desc = {
    Text = "狂気解放を4回発動するごとに、すべての手札の行動力消費が1減少する。"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆脱出平面図☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "「乗船後、まず客室に最も近い非常口を見つけてください」"
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が100増加する。アクティブダメージを1回与えるたび、一時的な触腕ダメージ+[Arg1]、触腕ダメージを1回与えるたび、[Arg2]点のシールドを獲得する。毎ターン最大6回まで発動する。"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が100増加する。アクティブダメージを1回与えるたび、一時的な触腕ダメージ+[Arg1]、触腕ダメージを1回与えるたび、[Arg2]点のシールドを獲得する。毎ターン最大6回まで発動する。"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:時の振り子「悪夢」>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "行動力を1消費するごとに、対応する覚醒体が2の狂気を獲得。"
  },
  RelicConfig_13870_Desc = {
    Text = "行動力を1消費するごとに、対応する覚醒体が2の狂気を獲得。"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:銀色バックルリボン>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "かつて事件現場にあったリボンは、外力で二つに裂かれた。\nその一つは高所から舞い降り、少女の手のひらに落ちた。"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "毎ターン開始時、すべての覚醒体が10狂気を獲得する。拾得時、最大ライフが30％減少する。"
  },
  RelicConfig_13871_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が10狂気を獲得する。拾得時、最大ライフが30％減少する。"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:悪夢の表象>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "気をつけて、放縦な深い眠りがすべてを飲み込む。"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "<ExaltIconKeywords:霊知覚醒>使用後、すべての敵のシールドを除去する。"
  },
  RelicConfig_13873_Desc = {
    Text = "<ExaltIconKeywords:霊知覚醒>使用後、すべての敵のシールドを除去する。"
  },
  RelicConfig_13873_Name = {
    Text = "黒い鏡面"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "奇数ターン中、残りの手札枚数が0の場合、カードを2枚引く。偶数ターン中、残りの行動力が0の場合、2点の行動力を獲得する。"
  },
  RelicConfig_13874_Desc = {
    Text = "奇数ターン中、残りの手札枚数が0の場合、カードを2枚引く。偶数ターン中、残りの行動力が0の場合、2点の行動力を獲得する。"
  },
  RelicConfig_13874_Name = {
    Text = "異化・黄金の導き手"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "「攻撃」と「防御」使用後、対応する覚醒体が35狂気を獲得する。ただし、それらの行動力消費+1。"
  },
  RelicConfig_13875_Desc = {
    Text = "「攻撃」と「防御」使用後、対応する覚醒体が35狂気を獲得する。ただし、それらの行動力消費+1。"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:欠けた顔>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "誰かの顔が恐怖に満ち、時間に凍りつく。"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "毎ターン2回目のシールド獲得後、[Arg1]層の<RetaliateIconKeywords:カウンター>を獲得する。毎ターン4回目のシールド獲得後、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13877_Desc = {
    Text = "毎ターン2回目のシールド獲得後、[Arg1]層の<RetaliateIconKeywords:カウンター>を獲得する。毎ターン4回目のシールド獲得後、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:知識の泉>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "それは無数の秘密を伝えた、積極的に言われたものも、受動的に言われたものも。"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "使用する6枚目の「指令カード」は捨て札から手札に戻る。"
  },
  RelicConfig_13878_Desc = {
    Text = "使用する6枚目の「指令カード」は捨て札から手札に戻る。"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:黄昏の中で>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "一緒に写真を撮ろう！本物の痛みを感じてみよう。"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "狂気解放を5回発動するたび、狂気解放を発動した覚醒体に100狂気を獲得させる。"
  },
  RelicConfig_13879_Desc = {
    Text = "狂気解放を5回発動するたび、狂気解放を発動した覚醒体に100狂気を獲得させる。"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:小さな産着>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "希望、祝福、愛を乗せて。"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "アクティブダメージを与えた時[Arg1]点のシールドを獲得する。ライフ回復時、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13880_Desc = {
    Text = "アクティブダメージを与えた時[Arg1]点のシールドを獲得する。ライフ回復時、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:我が家>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "彼らは以前も一緒にいて、これからも永遠に一緒にいる。彼らは愛し合う家族だ。"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "奇数ターン開始時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。偶数ターン開始時、[Arg2]点の一時的な<AlertIconKeywords:警戒>を獲得。"
  },
  RelicConfig_13881_Desc = {
    Text = "奇数ターン開始時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。偶数ターン開始時、[Arg2]点の一時的な<AlertIconKeywords:警戒>を獲得。"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:双子の人形>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "双生は旧時代の贈り物であり、未来への寓話だ。"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "毎ターン最初の指令カードを使用した対応する覚醒体は、ターン終了時に20狂気を獲得し、遺物「献身」を所有している場合、他の覚醒体も5狂気を獲得する。"
  },
  RelicConfig_13882_Desc = {
    Text = "毎ターン最初の指令カードを使用した対応する覚醒体は、ターン終了時に20狂気を獲得し、遺物「献身」を所有している場合、他の覚醒体も5狂気を獲得する。"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:母の像>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "「あげる、何でもあげるから、お願い、彼を放して」"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "覚醒体が1回<DevouredIconKeywords:捕食>を行うたびに、他の覚醒体は10狂気を獲得する。"
  },
  RelicConfig_13883_Desc = {
    Text = "覚醒体が1回<DevouredIconKeywords:捕食>を行うたびに、他の覚醒体は10狂気を獲得する。"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:金色の夢>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "変身の日はお前の死期だ。"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "「打撃」がすべての敵に[Arg1]層の<IntoxicationIconKeywords:中毒>を付与する。"
  },
  RelicConfig_13884_Desc = {
    Text = "「打撃」がすべての敵に[Arg1]層の<IntoxicationIconKeywords:中毒>を付与する。"
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:神経毒>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "抽出、精錬。"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "戦闘開始時、<DerivativeCardKeywords_1:「遺影回響」>を1枚手札に加える。ボス戦の場合、追加で<DerivativeCardKeywords_1:「遺影回響」>を1枚獲得する。"
  },
  RelicConfig_13885_Desc = {
    Text = "戦闘開始時、<DerivativeCardKeywords_1:「遺影回響」>を1枚手札に加える。ボス戦の場合、追加で<DerivativeCardKeywords_1:「遺影回響」>を1枚獲得する。"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:通信機>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "そのベルの音が鳴る瞬間を期待し、または恐れる。"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "山札をリセットするたびに、<DerivativeCardKeywords_5:「漁叉」>を2枚と<DerivativeCardKeywords_6:「陽傘」>を1枚手札に加える。"
  },
  RelicConfig_13886_Desc = {
    Text = "山札をリセットするたびに、<DerivativeCardKeywords_5:「漁叉」>を2枚と<DerivativeCardKeywords_6:「陽傘」>を1枚手札に加える。"
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆レディの小包☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "それは精巧さを運ぶべきで、死を運ぶべきではない。"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_5:「銛」>を1枚手札に追加する。「狂気解放」を発動した後、手札のすべての<DerivativeCardKeywords_5:「銛」>の<PowerIconKeywords:力>が[Arg2]点増加する。"
  },
  RelicConfig_13887_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_5:「銛」>を1枚手札に追加する。「狂気解放」を発動した後、手札のすべての<DerivativeCardKeywords_5:「銛」>の<PowerIconKeywords:力>が[Arg2]点増加する。"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:銛>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "どう見ても普通だ。"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点のシールドを獲得。この戦闘中に「防御」を7回使用すると、[Arg2]点のシールドを獲得。この戦闘中に「防御」を21回使用すると、1点の一時的なバリアを獲得。"
  },
  RelicConfig_13888_Desc = {
    Text = "戦闘開始時、[Arg1]点のシールドを獲得。この戦闘中に「防御」を7回使用すると、[Arg2]点のシールドを獲得。この戦闘中に「防御」を21回使用すると、1点の一時的なバリアを獲得。"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:プトニー新聞>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "あなたの最も親しいトイレの友。"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "超次元ターンに入った後、3点の行動力を獲得する。"
  },
  RelicConfig_13889_Desc = {
    Text = "超次元ターンに入った後、3点の行動力を獲得する。"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:輝きの砂時計>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "計測可能な時間。"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "戦闘開始時、すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与し、ボス戦の場合、追加で2ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  RelicConfig_13890_Desc = {
    Text = "戦闘開始時、すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与し、ボス戦の場合、追加で2ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:変色拘束服>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "時間だけじゃなく、恐怖と苦痛も布を変色させる。"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "毎ターン最初に出した指令カードが跳躍効果を発動した場合、カードを1枚引く。発動しなかった場合、1点の行動力を獲得する。超次元ターンの場合、上記2つの効果を同時に得る。"
  },
  RelicConfig_13891_Desc = {
    Text = "毎ターン最初に出した指令カードが跳躍効果を発動した場合、カードを1枚引く。発動しなかった場合、1点の行動力を獲得する。超次元ターンの場合、上記2つの効果を同時に得る。"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:跳躍装置>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "歪んだ影を映し出す。"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "任務を1つ獲得する。任務完了後、報酬を獲得する。【任務イベントプレースホルダー】"
  },
  RelicConfig_13892_Desc = {
    Text = "任務を1つ獲得する。任務完了後、報酬を獲得する。【任務イベントプレースホルダー】"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:古びた日記帳>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "古い日記、中に挿しこまれたページがいっぱいで、アイズルワースの地図、実験記録、三角の融蝕痕がついた手紙がざっと見える。\n初めの内容は端正に書かれているが、後に進むにつれて乱雑になっていく。"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "4回目のシールド獲得時、その50%のライフを回復。"
  },
  RelicConfig_13893_Desc = {
    Text = "4回目のシールド獲得時、その50%のライフを回復。"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:船乗りの笛>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "人魚以外にも、笛の音は嵐や臭いブーツ、100日間風呂に入っていない老水夫を呼び寄せる。"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "前のターンに使用したカードの枚数が4枚以下の場合、このターンに使用した最初のカードが2回発動する。"
  },
  RelicConfig_13894_Desc = {
    Text = "前のターンに使用したカードの枚数が4枚以下の場合、このターンに使用した最初のカードが2回発動する。"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆悪夢の魂灯☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "幻夢を導入する。"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "ライフを失うたび、最も狂気が低い覚醒体が10狂気を獲得する。5回ライフを失うたび、失ったライフの20%を回復する。"
  },
  RelicConfig_13895_Desc = {
    Text = "ライフを失うたび、最も狂気が低い覚醒体が10狂気を獲得する。5回ライフを失うたび、失ったライフの20%を回復する。"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:時の振り子「解析」>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "最大行動力が2増加する。山札をリセットするたび、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札に加える。"
  },
  RelicConfig_13896_Desc = {
    Text = "最大行動力が2増加する。山札をリセットするたび、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札に加える。"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:黒い蝋燭>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "意識を燃やし、虚無に堕ちる。"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "<ExaltIconKeywords:霊知覚醒>はターン終了時に保持される。"
  },
  RelicConfig_13897_Desc = {
    Text = "<ExaltIconKeywords:霊知覚醒>はターン終了時に保持される。"
  },
  RelicConfig_13897_Name = {
    Text = "白い鏡面"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "覚醒済みの覚醒体1体につき<ProficientInRealmsIconKeywords:界域知識>が35増加する。<ExaltIconKeywords:霊知覚醒>使用後、その覚醒体の指令カードをランダムに2枚獲得し、<DepleteIconKeywords:除外>を付与する。"
  },
  RelicConfig_13898_Desc = {
    Text = "覚醒済みの覚醒体1体につき<ProficientInRealmsIconKeywords:界域知識>が35増加する。<ExaltIconKeywords:霊知覚醒>使用後、その覚醒体の指令カードをランダムに2枚獲得し、<DepleteIconKeywords:除外>を付与する。"
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:主の神託>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "神は言った——恐れる事はないと。"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "ターン開始時、<ProficientInRealmsIconKeywords:界域精通>が50上昇する。デバフ状態でない場合、<ProficientInRealmsIconKeywords:界域精通>の上昇が150になる。"
  },
  RelicConfig_13899_Desc = {
    Text = "ターン開始時、<ProficientInRealmsIconKeywords:界域精通>が50上昇する。デバフ状態でない場合、<ProficientInRealmsIconKeywords:界域精通>の上昇が150になる。"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆「自由の尊重」☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "少し懐かしいシルバーコアの一握り。"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "「狂気解放」使用後、すべての手札の行動力消費-1。"
  },
  RelicConfig_13900_Desc = {
    Text = "「狂気解放」使用後、すべての手札の行動力消費-1。"
  },
  RelicConfig_13900_Name = {
    Text = "異化文明の光"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "指令カードを1枚使用するたび、[Arg2]%の<DeathResistanceIconKeywords:死亡抵抗>を獲得する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>が100%以上の場合、代わりに[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13901_Desc = {
    Text = "指令カードを1枚使用するたび、[Arg2]%の<DeathResistanceIconKeywords:死亡抵抗>を獲得する（このステージ内で死亡抵抗を1回発動するたび、獲得する死亡抵抗は半減する）。<DeathResistanceIconKeywords:死亡抵抗>が100%以上の場合、代わりに[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:怪蛇の抜け殻>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "残骸から再生。"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "ターン開始後、[Arg2]点のシールドを獲得する。ターン終了後、ランダムな敵に現在のシールド値の[Arg1]％に等しい<FixedDamage:純粋ダメージ>を与え、ボスバトルではダメージ効果が2倍になる。"
  },
  RelicConfig_13902_Desc = {
    Text = "ターン開始後、[Arg2]点のシールドを獲得する。ターン終了後、ランダムな敵に現在のシールド値の[Arg1]％に等しい<FixedDamage:純粋ダメージ>を与え、ボスバトルではダメージ効果が2倍になる。"
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:黄金の導き手>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "方向を見失った時に開けてみてください。ただし、日食は日光に当てないように注意してください。"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "敵の行動予測を隠す。毎ターン1点の行動力を獲得し、カードを1枚引く。"
  },
  RelicConfig_13904_Desc = {
    Text = "敵の行動予測を隠す。毎ターン1点の行動力を獲得し、カードを1枚引く。"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:惑わし風鈴>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "チリンチリン、チリンチリン。"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "戦闘開始後、[Arg2]層の<RetaliateIconKeywords:反撃>を獲得し、「防御」を出すと[Arg1]層の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_13905_Desc = {
    Text = "戦闘開始後、[Arg2]層の<RetaliateIconKeywords:反撃>を獲得し、「防御」を出すと[Arg1]層の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:イラクサのベスト>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "付着した液体を識別できません。"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "これは効果のない週替わり遺物4だ。"
  },
  RelicConfig_13906_Desc = {
    Text = "これは効果のない週替わり遺物4だ。"
  },
  RelicConfig_13906_Name = {
    Text = "日常チャレンジ週替わり遺物4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "ターン開始時、前のターンにカードを3枚以上使用していた場合、カードを2枚引く。"
  },
  RelicConfig_13907_Desc = {
    Text = "ターン開始時、前のターンにカードを3枚以上使用していた場合、カードを2枚引く。"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:新品の財布>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "ミサゴ大学の校章が刻まれた革財布。\n中は今空っぽで、何も入っていない。"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "「狂気解放」使用後、覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_13908_Desc = {
    Text = "「狂気解放」使用後、覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_13908_Name = {
    Text = "異化無名の神のヴェール"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "「狂気解放」発動後、現在のライフの8%を失い、すべての敵から[Arg1]点の<PowerIconKeywords:力>を一時的に奪い、敵が1体のみの場合、追加で[Arg2]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  RelicConfig_13909_Desc = {
    Text = "「狂気解放」発動後、現在のライフの8%を失い、すべての敵から[Arg1]点の<PowerIconKeywords:力>を一時的に奪い、敵が1体のみの場合、追加で[Arg2]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:不運の儀式鳥>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "干からびた死体が鳴き声を上げた。"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "狂気爆発を発動した後、対応する覚醒体が10狂気を獲得し、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_13910_Desc = {
    Text = "狂気爆発を発動した後、対応する覚醒体が10狂気を獲得し、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:無名の神のヴェール>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "神を直視してはならない。"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "毎ターン最後の指令カードを使用した対応する覚醒体は、ターン終了時に20狂気を獲得し、遺物「母の像」を所有している場合、他の覚醒体も5狂気を獲得する。"
  },
  RelicConfig_13911_Desc = {
    Text = "毎ターン最後の指令カードを使用した対応する覚醒体は、ターン終了時に20狂気を獲得し、遺物「母の像」を所有している場合、他の覚醒体も5狂気を獲得する。"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:献身>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "「あげる、何でもあげるから、お願い、私を許して」"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "ターン終了時、残りの手札1枚につき、次のターン開始時に1点の行動力を獲得する。"
  },
  RelicConfig_13912_Desc = {
    Text = "ターン終了時、残りの手札1枚につき、次のターン開始時に1点の行動力を獲得する。"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:時の振り子「演繹」>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "ターン開始時、ライフが[Arg1]より多い場合、ライフを[Arg1]点失い、そのターン中[Arg2]点の<PowerIconKeywords:力>と[Arg3]点の<AlertIconKeywords:警戒>を獲得する。"
  },
  RelicConfig_13913_Desc = {
    Text = "ターン開始時、ライフが[Arg1]より多い場合、ライフを[Arg1]点失い、そのターン中[Arg2]点の<PowerIconKeywords:力>と[Arg3]点の<AlertIconKeywords:警戒>を獲得する。"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:救済の肢>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離しても、その温かさを感じる。"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "「攻撃」は行2点の動力を獲得し、ランダムにカードを1枚捨てる。「防御」はカードを2枚引き、1点の行動力を失う。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13914_Desc = {
    Text = "「攻撃」は行2点の動力を獲得し、ランダムにカードを1枚捨てる。「防御」はカードを2枚引き、1点の行動力を失う。毎ターン最大3回まで発動する。"
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:ハッピーレコード>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "有名なバイオリニストの最後の演奏を録音したレコード。\nそれ以来、火をもたらす。"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "界域推薦ボーナス効果が50%に増加し、ステージ開始時にあなたの<ProficientInRealmsIconKeywords:界域知識>が2倍になる。"
  },
  RelicConfig_13915_Desc = {
    Text = "界域推薦ボーナス効果が50%に増加し、ステージ開始時にあなたの<ProficientInRealmsIconKeywords:界域知識>が2倍になる。"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:時の振り子「夢入」>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "「狂気解放」を発動した後、次に使用する指令カードは効果が2回発動する。"
  },
  RelicConfig_13916_Desc = {
    Text = "「狂気解放」を発動した後、次に使用する指令カードは効果が2回発動する。"
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:時の振り子「潜行」>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "敵の行動予測が攻撃の場合、ダメージを与えた後、[Arg1]点の<PowerIconKeywords:力>を一時的に減少させる。そうでない場合、ダメージの25%の<BleedingIconKeywords:出血>を付与。毎ターンに最大6回まで発動可能。"
  },
  RelicConfig_13917_Desc = {
    Text = "敵の行動予測が攻撃の場合、ダメージを与えた後、[Arg1]点の<PowerIconKeywords:力>を一時的に減少させる。そうでない場合、ダメージの25%の<BleedingIconKeywords:出血>を付与。毎ターンに最大6回まで発動可能。"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:異形の心>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "寄り添う2つの「心臓」"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、最大3回まで累積する。点数が上限に達した時、効果が2倍になる。"
  },
  RelicConfig_13918_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、最大3回まで累積する。点数が上限に達した時、効果が2倍になる。"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:縞瑪瑙>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "ただの瑪瑙の模様だと思う。たぶん。"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が50増加する。入手時に遺物を1つ選択し、それをランダムな遺物に交換する。"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が50増加する。入手時に遺物を1つ選択し、それをランダムな遺物に交換する。"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:万華鏡>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "見たものすべてが幻影。"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "付与する<WeaknessIconKeywords:倦怠>効果が5%増加する。<WeaknessIconKeywords:倦怠>を付与した時、対象から[Arg1]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  RelicConfig_13920_Desc = {
    Text = "与える虚弱効果が5%増加する。<WeaknessIconKeywords:虚弱>を付与した時、対象から[Arg1]点の<PowerIconKeywords:力量>を一時的に奪取する。"
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:色褪せた写真>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "ぼやけた写真はぼやけた記憶を載せている、あるいは——まさに記憶の欠落が写真の色あせを生んだのかもしれない。"
  },
  RelicConfig_13921_BattleDesc = {
    Text = "拾得時、指令カードを2枚選んで削除し、[Arg1]<PowerIconKeywords:力量>を獲得する。"
  },
  RelicConfig_13921_Desc = {
    Text = "拾得時、指令カードを2枚選んで削除し、[Arg1]<PowerIconKeywords:力量>を獲得する。"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:黒星の燃え殻>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "火はまだ消えていない。"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "毎ターン「狂気解放」を2回発動した後、すべての覚醒体が8狂気を獲得し、3回発動した後、すべての覚醒体は8狂気を獲得する。"
  },
  RelicConfig_13922_Desc = {
    Text = "毎ターン「狂気解放」を2回発動した後、すべての覚醒体が8狂気を獲得し、3回発動した後、すべての覚醒体は8狂気を獲得する。"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:忘れられし者の血>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "徐々に溶けていく。"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "ダメージを1回与えるたび、[Arg1]点のシールドを獲得する。ターン開始時に残りシールドが3点あるごとに、1点の一時的な<PowerIconKeywords:力>と触腕ダメージを獲得する。"
  },
  RelicConfig_13923_Desc = {
    Text = "ダメージを1回与えるたび、[Arg1]点のシールドを獲得する。ターン開始時に残りシールドが3点あるごとに、1点の一時的な<PowerIconKeywords:力>と触腕ダメージを獲得する。"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:時の振り子「秘密」>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "<TransitionIconKeywords:跳躍>効果を発動するたびに、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。敵が1体のみの場合、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_13924_Desc = {
    Text = "<TransitionIconKeywords:跳躍>効果を発動するたびに、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。敵が1体のみの場合、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:空間屈折装置>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "虚空に飛び込む。"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "ターン開始時にカードを1枚引く。前のカードと同じ行動力のカードを2回連続で使用した時、追加でカードを1枚引き、毎ターン最大3回まで発動する。"
  },
  RelicConfig_13925_Desc = {
    Text = "ターン開始時にカードを1枚引く。前のカードと同じ行動力のカードを2回連続で使用した時、追加でカードを1枚引き、毎ターン最大3回まで発動する。"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:万象霊知の秘儀>"
  },
  RelicConfig_13925_StoryDesc = {Text = "全能。"},
  RelicConfig_13926_BattleDesc = {
    Text = "戦闘開始時、デッキ内の刻印1つにつき[Arg1]点の<PowerIconKeywords:力>を獲得し、造物1つにつきHPを[Arg2]点回復する。"
  },
  RelicConfig_13926_Desc = {
    Text = "戦闘開始時、デッキ内の刻印1つにつき[Arg1]点の<PowerIconKeywords:力>を獲得し、造物1つにつきHPを[Arg2]点回復する。"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆商会の勲章☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "「これをつければ、君はロンディニウム商会の一員だ」"
  },
  RelicConfig_13927_BattleDesc = {
    Text = "入手時、症状カードを1枚削除する。ランダムな刻印1つを上位刻印にアップグレードする。"
  },
  RelicConfig_13927_Desc = {
    Text = "入手時、症状カードを1枚削除する。ランダムな刻印1つを上位刻印にアップグレードする。"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:幸運のウサギの足>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "ウサギにとっては、あまり幸運ではなかった。"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "クリティカル率が15%増加する。カードを1枚使用するたび、一時的なクリティカル率が5%増加する。"
  },
  RelicConfig_13928_Desc = {
    Text = "クリティカル率が15%増加する。カードを1枚使用するたび、一時的なクリティカル率が5%増加する。"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:メンフィスの鏡>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "「その中で何を見たの？」"
  },
  RelicConfig_13929_BattleDesc = {
    Text = "ライフを失うたびに、[Arg1]層の<RetaliateIconKeywords:カウンター>を獲得する。1ターン内で3回目の発動の場合、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13929_Desc = {
    Text = "ライフを失うたびに、[Arg1]層の<RetaliateIconKeywords:カウンター>を獲得する。1ターン内で3回目の発動の場合、全ての敵に100％の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:古い友の懐中時計>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "懐かしさと悲しみを抱え、未知へと進む。"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "ターン終了時に手札1枚につき、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  RelicConfig_13930_Desc = {
    Text = "ターン終了時に手札1枚につき、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:怪しい軟膏>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "自作の外傷用軟膏、医者の指導なしに使用しないでください。"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "拾得時[Arg1]<PowerIconKeywords:力>を獲得する。<DerivativeCardKeywords_2:「胚胎」>が融合されるたびに、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13931_Desc = {
    Text = "拾得時[Arg1]<PowerIconKeywords:力>を獲得する。<DerivativeCardKeywords_2:「胚胎」>が融合されるたびに、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:血染めの小石>"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "3回目の「防御」使用後、[Arg1]点のシールドを獲得し、対応する覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13932_Desc = {
    Text = "3回目の「防御」使用後、[Arg1]点のシールドを獲得し、対応する覚醒体が15狂気を獲得する。"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:沈黙の手袋>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "それらは無数の血、涙、カビに染まっていた。"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "これは効果のない週替わり遺物6だ。"
  },
  RelicConfig_13933_Desc = {
    Text = "これは効果のない週替わり遺物6だ。"
  },
  RelicConfig_13933_Name = {
    Text = "日常チャレンジ週替わり遺物6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "これは効果のない週替わり遺物5だ。"
  },
  RelicConfig_13934_Desc = {
    Text = "これは効果のない週替わり遺物5だ。"
  },
  RelicConfig_13934_Name = {
    Text = "日常チャレンジ週替わり遺物5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "クリティカル率が10%増加する。毎ターン初めてクリティカル発生後、クリティカル率が追加で20%増加し、毎ターン3回目のクリティカル発生後、クリティカルダメージが追加で50%増加する。"
  },
  RelicConfig_13935_Desc = {
    Text = "クリティカル率が10%増加する。毎ターン初めてクリティカル発生後、クリティカル率が追加で20%増加し、毎ターン3回目のクリティカル発生後、クリティカルダメージが追加で50%増加する。"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:祝祭の祝福>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "それは愛し合う人々に祝福をもたらすべきだ。"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "これは効果のない週替わり遺物3だ。"
  },
  RelicConfig_13936_Desc = {
    Text = "これは効果のない週替わり遺物3だ。"
  },
  RelicConfig_13936_Name = {
    Text = "日常チャレンジ週替わり遺物3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "これは効果のない週替わり遺物2だ。"
  },
  RelicConfig_13937_Desc = {
    Text = "これは効果のない週替わり遺物2だ。"
  },
  RelicConfig_13937_Name = {
    Text = "日常チャレンジ週替わり遺物2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "これは効果のない週替わり遺物1だ。"
  },
  RelicConfig_13938_Desc = {
    Text = "これは効果のない週替わり遺物1だ。"
  },
  RelicConfig_13938_Name = {
    Text = "日常チャレンジ週替わり遺物1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "第3ターン開始時、この戦闘のクリティカル率+15%、<DerivativeCardKeywords_39:「過去の響き」>を1枚手札に加える。"
  },
  RelicConfig_13939_Desc = {
    Text = "第3ターン開始時、この戦闘のクリティカル率+15%、<DerivativeCardKeywords_39:「過去の響き」>を1枚手札に加える。"
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:古の供物>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "かつての供物。"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "シールドを所有している時、この遺物は[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。シールドが現在のライフより高い時、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13940_Desc = {
    Text = "シールドを所有している時、この遺物は[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。シールドが現在のライフより高い時、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:鳩の羽扇>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "精巧で高価ですが、あまり実用的ではありません。"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "「攻撃」がライフを[Arg1]点回復し、自身の<IntoxicationIconKeywords:毒>を[Arg1]点減少させる。"
  },
  RelicConfig_13941_Desc = {
    Text = "「攻撃」がライフを[Arg1]点回復し、自身の<IntoxicationIconKeywords:毒>を[Arg1]点減少させる。"
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:止血鉗子>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "「早く、それを私に！」"
  },
  RelicConfig_13942_BattleDesc = {
    Text = "触腕1本につき、ターン終了時に[Arg1]点のシールドを獲得する。触腕が静海モードの場合、この効果で追加で50％のシールドを獲得する。"
  },
  RelicConfig_13942_Desc = {
    Text = "触腕1本につき、ターン終了時に[Arg1]点のシールドを獲得する。触腕が静海モードの場合、この効果で追加で50％のシールドを獲得する。"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:名無しの肢体>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "刺さないように気をつけて。"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "ターン開始時、沙耶は[Arg1]の狂気を獲得する。沙耶の狂気爆発で100ポイントの狂気を消費するごとに、ランダムな生成された「スキル」1枚を追加で1回発動させる。"
  },
  RelicConfig_139929_Desc = {
    Text = "ターン開始時、沙耶は[Arg1]の狂気を獲得する。沙耶の狂気爆発で100ポイントの狂気を消費するごとに、ランダムな生成された「スキル」1枚を追加で1回発動させる。"
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:次元映像·沙耶>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:背水>：ターン開始時、最大HPを1％失うごとに一時最終ダメージが5％上昇する。前のターンで死亡抵抗が発動していた場合、この効果が倍になる。\n<RedQuality:至高>：全ての敵の最大HPが300％上昇する。"
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:背水>：ターン開始時、最大HPを1％失うごとに一時最終ダメージが5％上昇する。前のターンで死亡抵抗が発動していた場合、この効果が倍になる。\n<RedQuality:至高>：全ての敵の最大HPが300％上昇する。"
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:次元霊擺–死戦>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:増殖>：毎ターン各覚醒体が初めて「スキル」を出した時、その一時的な原始コピーを2枚生成する。演算コストが0または1の指令カードを出した時、全覚醒体が狂気を5ポイント獲得する。\n<RedQuality:堡塁>：原始演算コストが3以上のカードを出した時、全ての敵が最大HPの20％のシールドを獲得する。"
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:増殖>：毎ターン各覚醒体が初めて「スキル」を出した時、その一時的な原始コピーを2枚生成する。演算コストが0または1の指令カードを出した時、全覚醒体が狂気を5ポイント獲得する。\n<RedQuality:堡塁>：原始演算コストが3以上のカードを出した時、全ての敵が最大HPの20％のシールドを獲得する。"
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:次元霊振–警戒>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:回生>：獲得するシールドと回復効果が25％上昇する。HP回復またはシールド獲得時、最大HPの1％分の回復またはシールド効果を与えるごとに、10％の一時ダメージ強化を獲得する。\n<RedQuality:低語>：毎ターン最大HPの10％に相当する攻撃力低下効果を受ける。"
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:回生>：獲得するシールドと回復効果が25％上昇する。HP回復またはシールド獲得時、最大HPの1％分の回復またはシールド効果を与えるごとに、10％の一時ダメージ強化を獲得する。\n<RedQuality:低語>：毎ターン最大HPの10％に相当する攻撃力低下効果を受ける。"
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:次元霊擺–威嚇>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:破暁>：全ての覚醒体の基礎キョウキが30ポイント低下する。毎ターン最初に発動したキョウキ爆発の最終ダメージが200％上昇し、シールド・HP回復が100％上昇する。キョウキ爆発を5回発動するごとに、覚醒体を1名選んで覚醒させ、キョウキ爆発の増幅効果をリセットする。\n<RedQuality:枯渇>：基礎銀鍵エネルギーが200％上昇する"
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:破暁>：全ての覚醒体の基礎キョウキが30ポイント低下する。毎ターン最初に発動したキョウキ爆発の最終ダメージが200％上昇し、シールド・HP回復が100％上昇する。キョウキ爆発を5回発動するごとに、覚醒体を1名選んで覚醒させ、キョウキ爆発の増幅効果をリセットする。\n<RedQuality:枯渇>：基礎銀鍵エネルギーが200％上昇する"
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:次元霊擺–詭呪>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:覚醒>：毎ターン初めて狂気爆発を発動した後、その覚醒体の狂気爆発クールダウンをリセットし、50の狂気を獲得させ、演算コストが0の全「スキル」の一時的コピーを生成する。\n<RedQuality:封印>：毎ターン初めて狂気爆発を発動した後、他の覚醒体を封印する。"
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:覚醒>：毎ターン初めて狂気爆発を発動した後、その覚醒体の狂気爆発クールダウンをリセットし、50の狂気を獲得させ、演算コストが0の全「スキル」の一時的コピーを生成する。\n<RedQuality:封印>：毎ターン初めて狂気爆発を発動した後、他の覚醒体を封印する。"
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:次元霊振–決闘>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:回響>：ターン開始後、ドローパイルから演算力が最も高い指令カードを3枚引く。毎ターン最初に出した指令カードが2回発動する。\n<RedQuality:眩暈>：指令カードを出した後、それ以上の演算力消費を持つ他の指令カードを全て捨てる。"
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:回響>：ターン開始後、ドローパイルから演算力が最も高い指令カードを3枚引く。毎ターン最初に出した指令カードが2回発動する。\n<RedQuality:眩暈>：指令カードを出した後、それ以上の演算力消費を持つ他の指令カードを全て捨てる。"
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:次元霊擺–惑乱>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:偉力>：全覚醒体が与える<PowerIconKeywords:力量>が50％上昇し、ダメージを1回与えるごとに[Arg2]ポイントの一時的な<PowerIconKeywords:力量>を獲得する。\n<RedQuality:無形>：戦闘開始時、全ての敵が<ParcloseIconKeywords:障壁>を50層獲得する。"
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:偉力>：全覚醒体が与える<PowerIconKeywords:力量>が50％上昇し、ダメージを1回与えるごとに[Arg2]ポイントの一時的な<PowerIconKeywords:力量>を獲得する。\n<RedQuality:無形>：戦闘開始時、全ての敵が<ParcloseIconKeywords:障壁>を50層獲得する。"
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:次元霊振–潜匿>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "手札上限 +1。戦闘開始時に「<DerivativeCardKeywords_148:驭魇>」を1枚生成して手札に加える。覚醒体の「基礎打撃」を発射した時、「<DerivativeCardKeywords_148:驭魇>」の行動力消費 -1、全ての敵に [Arg1] 点の侵蝕を与える。覚醒体の「基礎防御」を発射した時、[Arg2] 点の力を獲得し、次に「<DerivativeCardKeywords_148:驭魇>」を発射した際の最終ダメージ効果と力が [Arg3]% 増加する。"
  },
  RelicConfig_140840_Desc = {
    Text = "手札上限 +1。戦闘開始時に「<DerivativeCardKeywords_148:驭魇>」を1枚生成して手札に加える。覚醒体の「基礎打撃」を発射した時、「<DerivativeCardKeywords_148:驭魇>」の行動力消費 -1、全ての敵に [Arg1] 点の侵蝕を与える。覚醒体の「基礎防御」を発射した時、[Arg2] 点の力を獲得し、次に「<DerivativeCardKeywords_148:驭魇>」を発射した際の最終ダメージ効果と力が [Arg3]% 増加する。"
  },
  RelicConfig_140840_Name = {
    Text = "徒労者の足掻き"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "徒労者は変化を恐れ、物事が制御を超えることを恐れ、最も深いところで、ヒステリックに失うことを恐れている。\n 彼は何度も何度も哨笛を吹き鳴らし、哨笛によってすべてを支配しようとしたが、何ひとつ留めることができなかった。"
  },
  RelicConfig_143665_BattleDesc = {
    Text = "ターン開始時にポントスが [Arg1] 狂気を獲得する。拾得後の次の戦闘開始時、永続「囚魘」を3枚生成する。「囚魘」を発射するとポントスが3点の狂気を獲得する。"
  },
  RelicConfig_143665_Desc = {
    Text = "ターン開始時にポントスが [Arg1] 狂気を獲得する。拾得後の次の戦闘開始時、永続「囚魘」を3枚生成する。「囚魘」を発射するとポントスが3点の狂気を獲得する。"
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:次元映像·ポントス>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "ターン開始時に蝕滅・ロータンが [Arg1] 点の狂気を獲得し、「断界の剣」により次のターン開始時に「冥刀の追撃」追撃を放す：全ての敵に蝕滅・ロータンの攻撃力400％のダメージを与える。このダメージは今回の「断界の剣」が「大剣・鯨堕」を通じて獲得したダメージボーナスを享受し、「打撃」とみなす。"
  },
  RelicConfig_145438_Desc = {
    Text = "ターン開始時に蝕滅・ロータンが [Arg1] 点の狂気を獲得し、「断界の剣」により次のターン開始時に「冥刀の追撃」追撃を放す：全ての敵に蝕滅・ロータンの攻撃力400％のダメージを与える。このダメージは今回の「断界の剣」が「大剣・鯨堕」を通じて獲得したダメージボーナスを享受し、「打撃」とみなす。"
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:次元影像·蝕滅・ロータン>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "手札上限 +1。戦闘開始時または「<DerivativeCardKeywords_157:剣の骨>」を発射した後、「<DerivativeCardKeywords_155:狂の骨>」1枚を手札に加え、「<DerivativeCardKeywords_156:傷の骨>」1枚をドロー山にシャッフルする。同じターン中に「<DerivativeCardKeywords_155:狂の骨>」と「<DerivativeCardKeywords_156:傷の骨>」を両方発射した場合、この2枚を合成して「<DerivativeCardKeywords_157:剣の骨>」として手札に加える。"
  },
  RelicConfig_146128_Desc = {
    Text = "手札上限 +1。戦闘開始時または「<DerivativeCardKeywords_157:剣の骨>」を発射した後、「<DerivativeCardKeywords_155:狂の骨>」1枚を手札に加え、「<DerivativeCardKeywords_156:傷の骨>」1枚をドロー山にシャッフルする。同じターン中に「<DerivativeCardKeywords_155:狂の骨>」と「<DerivativeCardKeywords_156:傷の骨>」を両方発射した場合、この2枚を合成して「<DerivativeCardKeywords_157:剣の骨>」として手札に加える。"
  },
  RelicConfig_146128_Name = {
    Text = "鯨骨の鎧"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "リヴァイアサンの骸骨が選ばれし者を守護し、無敵にして不死不滅たらしめる。"
  },
  RelicConfig_147547_BattleDesc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたびに、カーシアは[Arg2]狂気を獲得する。カーシアが狂気解放する際、すべての敵は[Arg3]点の力を失う。"
  },
  RelicConfig_147547_Desc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたびに、カーシアは[Arg2]狂気を獲得する。カーシアが狂気解放する際、すべての敵は[Arg3]点の力を失う。"
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:次元影像・カーシア>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "行動力上限と毎ターンのドロー数が+1される。ターン開始時、3個の「<Caroboo_Tips:ピストルチョコチョコレート>」を<FaxianKeywords:発見>して1つを選択する。そのうち本物は1つのみ：本物を選んだ場合はその正面効果を得て自身のランダムな負面ステータス1種を解除する；偽物を選んだ場合はその負面効果を受け、次回の<FaxianKeywords:発見>時に本物の選択肢が+1され効果が2倍になり、本物を選んだ後リセットされる。"
  },
  RelicConfig_147665_Desc = {
    Text = "行動力上限と毎ターンのドロー数が+1される。ターン開始時、3個の「<Caroboo_Tips:ピストルチョコチョコレート>」を<FaxianKeywords:発見>して1つを選択する。そのうち本物は1つのみ：本物を選んだ場合はその正面効果を得て自身のランダムな負面ステータス1種を解除する；偽物を選んだ場合はその負面効果を受け、次回の<FaxianKeywords:発見>時に本物の選択肢が+1され効果が2倍になり、本物を選んだ後リセットされる。"
  },
  RelicConfig_147665_Name = {
    Text = "ピストルチョコチョコレート"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "甘くて貴重……なの？"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "ターン開始時に負誓·オジールは[Arg1]点の狂気を獲得し、「暗涌」はドロー数を減少させなくなる。"
  },
  RelicConfig_148525_Desc = {
    Text = "ターン開始時に負誓·オジールは[Arg1]点の狂気を獲得し、「暗涌」はドロー数を減少させなくなる。"
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:次元影像·負誓·オジール>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "現在の環境を「氷原」とみなす。\n終北大陸：ドロー段階後、手札の中で行動力が最も高い凍結していない指令カード 2 枚に 1 層の<SlowIconKeywords:遅延>・<RetainIconKeywords:保留>を付与する。いずれかの指令カードが 3 層以上の<SlowIconKeywords:遅延>を持つ場合、その<SlowIconKeywords:遅延>と本戦闘中に付与された<RetainIconKeywords:保留>を除去して「凍結」させ、25 層の<TempPowerKeywords2:強化>を付加する。"
  },
  RelicConfig_149665_Desc = {
    Text = "現在の環境を「氷原」とみなす。\n終北大陸：ドロー段階後、手札の中で行動力が最も高い凍結していない指令カード 2 枚に 1 層の<SlowIconKeywords:遅延>・<RetainIconKeywords:保留>を付与する。いずれかの指令カードが 3 層以上の<SlowIconKeywords:遅延>を持つ場合、その<SlowIconKeywords:遅延>と本戦闘中に付与された<RetainIconKeywords:保留>を除去して「凍結」させ、25 層の<TempPowerKeywords2:強化>を付加する。"
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:氷原晶核>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "それは寒さをもたらすのではない。\nただ大地に思い起こさせるのだ、冬は去っていなかったと。"
  },
  RelicConfig_20164_BattleDesc = {
    Text = "ダメージを1回与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、最大5層まで累積する。層数が上限に達した時、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_20164_Desc = {
    Text = "ダメージを1回与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、最大5層まで累積する。層数が上限に達した時、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:時の振り子「不眠」>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "獲得時、すべての覚醒体を覚醒させる。<ExaltIconKeywords:霊知覚醒>を使用時、その覚醒体の「指令カード」をランダムに2枚獲得し、「除外」と「虚無」を付与する。"
  },
  RelicConfig_20165_Desc = {
    Text = "獲得時、すべての覚醒体を覚醒させる。<ExaltIconKeywords:霊知覚醒>を使用時、その覚醒体の「指令カード」をランダムに2枚獲得し、「除外」と「虚無」を付与する。"
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:主の神託+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "神は言った——恐れる事はないと。"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>+100。毎ターン初めて使用したカードを手札に戻す。超次元ターン開始時、手札上限を5枚増加し、手札をコピーする。"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が100増加する。毎ターン最初に使用したカードを捨て札から手札に戻す。超次元ターン開始時、そのターンの手札上限+5、手札を複製する。複製されたカードに<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:消耗>を付与する。"
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:時の振り子「夢盗み」>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "ターン終了時に行動力が残っている場合、次のターン追加でカードを2枚引き、手札が残っている場合、次のターン追加で2点の行動力を獲得する。"
  },
  RelicConfig_20167_Desc = {
    Text = "ターン終了時に行動力が残っている場合、次のターン追加でカードを2枚引き、手札が残っている場合、次のターン追加で2点の行動力を獲得する。"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:日月ルーレット+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "黒か白か、どっちだと思う？"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "触腕上限+2。「狂気解放」発動後、触腕ダメージ+[Arg1]。1ターン中に「狂気解放」を3回発動した場合、すべての触腕を1回触発する。"
  },
  RelicConfig_20168_Desc = {
    Text = "触腕上限+2。「狂気解放」発動後、触腕ダメージ+[Arg1]。1ターン中に「狂気解放」を3回発動した場合、すべての触腕を1回触発する。"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:時の振り子「浅眠」>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が100増加する。カードを1枚使用するたび<EmbryoFusionIconKeywords:胚胎融合>+10、ライフが25%未満の場合20に増加し、毎ターン最大10回まで発動する。"
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域知識>が100増加する。カードを1枚使用するたび<EmbryoFusionIconKeywords:胚胎融合>+10、ライフが25%未満の場合20に増加し、毎ターン最大10回まで発動する。"
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:時の振り子「渦巻」>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "戦闘開始時、すべての覚醒体が50狂気を獲得する。<DerivativeCardKeywords_1:「影の残響」>を2枚手札に追加する。"
  },
  RelicConfig_20170_Desc = {
    Text = "戦闘開始時、すべての覚醒体が50狂気を獲得する。<DerivativeCardKeywords_1:「影の残響」>を2枚手札に追加する。"
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:通信設備+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "そのベルの音が鳴る瞬間を期待し、または恐れる。"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "入手時、ランダムに低級遺物を1つ、高級遺物を1つ、呪われた遺物を1つ獲得する。"
  },
  RelicConfig_20171_Desc = {
    Text = "入手時、ランダムに低級遺物を1つ、高級遺物を1つ、呪われた遺物を1つ獲得する。"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:逆向観賞+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "奇妙な時代に、花は人類の最初の観賞者だった。\n動かないで、彼らは静かな展示品を好む。"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "毎ターン使用した指令カードが3枚に達した時<DerivativeCardKeywords_4:「啓示」>を1枚獲得し、6枚に達した時<DerivativeCardKeywords_4:「啓示」>を1枚獲得し、10枚に達した後、次のターン開始時に山札の中から任意のカードを2枚選び手札に追加することができる。"
  },
  RelicConfig_20172_Desc = {
    Text = "毎ターン使用した指令カードが3枚に達した時<DerivativeCardKeywords_4:「啓示」>を1枚獲得し、6枚に達した時<DerivativeCardKeywords_4:「啓示」>を1枚獲得し、10枚に達した後、次のターン開始時に山札の中から任意のカードを2枚選び手札に追加することができる。"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:時の振り子「反響」>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "デバフ状態の敵に対するダメージが50%増加し、敵を倒すと倒した者が100狂気を獲得。"
  },
  RelicConfig_20173_Desc = {
    Text = "デバフ状態の敵に対するダメージが50%増加し、敵を倒すと倒した者が100狂気を獲得。"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:祭司の杖+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "許されない信仰。"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "取得後、チームのダメージ強化が元の値の150%になる。ターン開始後、ランダムな敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、このバトル中にキーオーダーを1回使用するたびにダメージ+[Arg2]となり、このダメージ上昇はチームのダメージ強化ボーナスの恩恵を受ける。"
  },
  RelicConfig_20174_Desc = {
    Text = "取得後、チームのダメージ強化が元の値の150%になる。ターン開始後、ランダムな敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、このバトル中にキーオーダーを1回使用するたびにダメージ+[Arg2]となり、このダメージ上昇はチームのダメージ強化ボーナスの恩恵を受ける。"
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:時の振り子「迷子」>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "与える<WeaknessIconKeywords:倦怠>効果が8％増加し、<VulnerabilityIconKeywords:軟化>効果が25％増加する。<WeaknessIconKeywords:倦怠>または<VulnerabilityIconKeywords:軟化>を付与した時、対象の[Arg1]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  RelicConfig_20175_Desc = {
    Text = "与える<WeaknessIconKeywords:倦怠>効果が8％増加し、<VulnerabilityIconKeywords:軟化>効果が25％増加する。<WeaknessIconKeywords:倦怠>または<VulnerabilityIconKeywords:軟化>を付与した時、対象の[Arg1]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:色褪せた写真+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "ぼやけた写真にはぼんやりとした記憶が宿る。あるいは——記憶の不完全さゆえに写真が色褪せたのかもしれない。"
  },
  RelicConfig_20176_BattleDesc = {
    Text = "ターン開始時、敵1体につき2点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージの2倍の<BleedingIconKeywords:出血>を付与。"
  },
  RelicConfig_20176_Desc = {
    Text = "ターン開始時、敵1体につき2点の行動力を獲得。アクティブダメージで敵を倒すと、他の敵に過剰ダメージの2倍の<BleedingIconKeywords:出血>を付与。"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:群衆の歌+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "あなたの耳を苦しめるために生まれた。"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "入手後死亡抵抗が2倍になる。ダメージを与えた後、対象にダメージの50%相当の<BleedingIconKeywords:出血>を付与する。死亡抵抗を1回発動するたび、すべての敵の出血が1回発動する。"
  },
  RelicConfig_20177_Desc = {
    Text = "入手後死亡抵抗が2倍になる。ダメージを与えた後、対象にダメージの50%相当の<BleedingIconKeywords:出血>を付与する。死亡抵抗を1回発動するたび、すべての敵の出血が1回発動する。"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:時の振り子「復活」>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "アクティブダメージを1回与えるたび3狂気を獲得し、対象に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。この戦闘中に発動回数が累計25回に達した場合、直ちにすべての敵の<IntoxicationIconKeywords:毒>を誘発する。"
  },
  RelicConfig_20178_Desc = {
    Text = "アクティブダメージを1回与えるたび3狂気を獲得し、対象に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。この戦闘中に発動回数が累計25回に達した場合、直ちにすべての敵の<IntoxicationIconKeywords:毒>を誘発する。"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:埃をかぶったミシン+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "慈愛に満ちた母親が心の傷を縫い合わせる。"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "「攻撃」は3点の行動力を獲得し、ランダムにカードを1枚捨てる。「防御」はカードを3枚引き、1点の行動力を失う。"
  },
  RelicConfig_21906_Desc = {
    Text = "「攻撃」は3点の行動力を獲得し、ランダムにカードを1枚捨てる。「防御」はカードを3枚引き、1点の行動力を失う。"
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:ハッピーレコード+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "有名なバイオリニストの最後の演奏を録音したレコード。\nそれ以来、火をもたらす。"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "<DevouredIconKeywords:捕食>を1回発動するたび、30点の<EmbryoFusionIconKeywords:胚胎融合>と[Arg1]点の<PowerIconKeywords:力>を獲得する。1ターン中に2回発動した場合、行動力を1点獲得し、カードを1枚引く。1ターン中に3回発動した場合、2点の行動力を獲得し、カードを2枚引く。"
  },
  RelicConfig_23688_Desc = {
    Text = "<DevouredIconKeywords:捕食>を1回発動するたび、30点の<EmbryoFusionIconKeywords:胚胎融合>と[Arg1]点の<PowerIconKeywords:力>を獲得する。1ターン中に2回発動した場合、行動力を1点獲得し、カードを1枚引く。1ターン中に3回発動した場合、2点の行動力を獲得し、カードを2枚引く。"
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:時の振り子「逆襲」>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "入手後、すべての覚醒体が30狂気を獲得する。「狂気解放」を1回発動するたび、カウントが1点増加する。「キーオーダー」を発動した後、[Arg1]点の一時的な警戒、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、すべての覚醒体が6狂気を獲得し、すべてのカウントを消費し、1カウントにつき効果が追加で1回発動する。"
  },
  RelicConfig_23689_Desc = {
    Text = "入手後、すべての覚醒体が30狂気を獲得する。「狂気解放」を1回発動するたび、カウントが1点増加する。「キーオーダー」を発動した後、[Arg1]点の一時的な警戒、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、すべての覚醒体が6狂気を獲得し、すべてのカウントを消費し、1カウントにつき効果が追加で1回発動する。"
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:時の振り子「蓄力」>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "追加で1点の行動力を獲得するか、追加でカードを1枚引くたび、すべての敵から[Arg1]点の<PowerIconKeywords:力>を奪い、4%の一時的なクリティカル率を獲得し、精鋭またはボス戦では効果が2倍になる。超次元ターン開始後、[Arg2]点の<PowerIconKeywords:力>を獲得し、クリティカルダメージ+15%。"
  },
  RelicConfig_23690_Desc = {
    Text = "追加で1点の行動力を獲得するか、追加でカードを1枚引くたび、すべての敵から[Arg1]点の<PowerIconKeywords:力>を奪い、4%の一時的なクリティカル率を獲得し、精鋭またはボス戦では効果が2倍になる。超次元ターン開始後、[Arg2]点の<PowerIconKeywords:力>を獲得し、クリティカルダメージ+15%。"
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:時の振り子「隙間」>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "ダメージを5回与えるたび、ライフを[Arg1]点回復する。ライフを1回失うたび、触腕ダメージ+[Arg2]、失ったライフが[Arg3]点を超えた場合、すべての触腕を1回触発する。"
  },
  RelicConfig_23691_Desc = {
    Text = "ダメージを5回与えるたび、ライフを[Arg1]点回復する。ライフを1回失うたび、触腕ダメージ+[Arg2]、失ったライフが最大ライフの10%を超えた場合、すべての触腕を1回触発する。"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:時の振り子「潮流」>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "ダメージを1回与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>と[Arg2]点の一時的な触腕ダメージを獲得し、毎ターン最大12回まで発動する。1ターン内に4回ダメージを与えた場合、すべての敵に1点の軟化を付与し[Arg3]点のシールドを獲得し、8回ダメージを与えた場合、すべての敵に1点の倦怠を付与しライフを[Arg3]点回復する。"
  },
  RelicConfig_35135_Desc = {
    Text = "ダメージを1回与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>と[Arg2]点の一時的な触腕ダメージを獲得し、毎ターン最大12回まで発動する。1ターン内に4回ダメージを与えた場合、すべての敵に1点の軟化を付与し[Arg3]点のシールドを獲得し、8回ダメージを与えた場合、すべての敵に1点の倦怠を付与しライフを[Arg3]点回復する。"
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:時の振り子「夢中」>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "「攻撃」が与えるダメージと「防御」が獲得するシールドが30%増加し、1ターン中に「攻撃」と「防御」を4枚以上使用した場合、次のターン開始時にカードを2枚引き、1点の行動力を獲得する。"
  },
  RelicConfig_35136_Desc = {
    Text = "「攻撃」が与えるダメージと「防御」が獲得するシールドが30%増加し、1ターン中に「攻撃」と「防御」を4枚以上使用した場合、次のターン開始時にカードを2枚引き、1点の行動力を獲得する。"
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:時の振り子「執念」>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "カードを1枚使用するたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、[Arg2]ライフを回復する。アクティブダメージを与えた後、この遺物によって獲得した[Arg2]点の<PowerIconKeywords:力>を除去する。覚醒体が敵を1体撃破するごとに、30狂気を獲得する。"
  },
  RelicConfig_35137_Desc = {
    Text = "カードを1枚使用するたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、[Arg2]ライフを回復する。アクティブダメージを与えた後、この遺物によって獲得した[Arg2]点の<PowerIconKeywords:力>を除去する。覚醒体が敵を1体撃破するごとに、30狂気を獲得する。"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:時の振り子「蓄積」>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "「狂気解放」発動後、ランダムな敵に[Arg1]点の毒を付与し、指令カードを1枚使用するたび、[Arg2]点の一時的反撃を獲得する。4ターン終了するごとに、すべての敵に敵の毒の点数と自身の反撃の点数の合計に等しいダメージを与える。"
  },
  RelicConfig_35138_Desc = {
    Text = "「狂気解放」発動後、ランダムな敵に[Arg1]点の毒を付与し、指令カードを1枚使用するたび、[Arg2]点の一時的反撃を獲得する。4ターン終了するごとに、すべての敵に敵の毒の点数と自身の反撃の点数の合計に等しいダメージを与える。"
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:時の振り子「蔓延」>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "入手後チームのダメージ強化が30%増加する。与える4回目のダメージは必ずクリティカルになり、かつクリティカルダメージが50%増加し、そのダメージで撃破した場合、5黒章を獲得する。"
  },
  RelicConfig_35139_Desc = {
    Text = "入手後チームのダメージ強化が30%増加する。与える4回目のダメージは必ずクリティカルになり、かつクリティカルダメージが50%増加し、そのダメージで撃破した場合、5黒章を獲得する。"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:時の振り子「終焉」>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "「狂気解放」発動後カードを1枚引く。カードを1枚捨てるたび、すべての覚醒体が3狂気を獲得する。毎ターン最大15点。"
  },
  RelicConfig_36823_Desc = {
    Text = "「狂気解放」発動後カードを1枚引く。カードを1枚捨てるたび、すべての覚醒体が3狂気を獲得する。毎ターン最大15点。"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:時の振り子「往来」>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "行動力を消費するたび、カードを1枚引き、毎ターン最大5回まで発動する。山札がリセットされるたび、2点の行動力を獲得する。"
  },
  RelicConfig_36824_Desc = {
    Text = "行動力を消費するたび、カードを1枚引き、毎ターン最大5回まで発動する。山札がリセットされるたび、2点の行動力を獲得する。"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:時の振り子「不眠」>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "ダメージを4回与えるたび、<DerivativeCardKeywords_4:「啓示」>を1枚山札のランダムな位置に追加し、毎ターン最大3回まで発動する。「狂気解放」発動後、山札のすべての<DerivativeCardKeywords_4:「啓示」>を使用し、除外する。"
  },
  RelicConfig_39302_Desc = {
    Text = "ダメージを4回与えるたび、<DerivativeCardKeywords_4:「啓示」>を1枚山札のランダムな位置に追加し、毎ターン最大3回まで発動する。「狂気解放」発動後、山札のすべての<DerivativeCardKeywords_4:「啓示」>を使用し、除外する。"
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:時の振り子「夢迷」>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "現在の行動力が奇数の場合、追加で[Arg2]点の一時的な警戒を所有しているとみなす。現在の行動力が偶数の場合、追加で[Arg1]点の一時的な<PowerIconKeywords:力>と[Arg3]点の一時的な触腕ダメージを所有しているとみなす。黄金造物を1つ所有するごとに、この遺物の効果が50%増加し、呪い造物を1つ所有するごとに80%増加する。"
  },
  RelicConfig_39303_Desc = {
    Text = "現在の行動力が奇数の場合、追加で[Arg2]点の一時的な警戒を所有しているとみなす。現在の行動力が偶数の場合、追加で[Arg1]点の一時的な<PowerIconKeywords:力>と[Arg3]点の一時的な触腕ダメージを所有しているとみなす。黄金造物を1つ所有するごとに、この遺物の効果が50%増加し、呪い造物を1つ所有するごとに80%増加する。"
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:時の振り子「驚夢」>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "毎ターン開始時、すべての覚醒体が20の狂気を獲得。獲得時、最大ライフが50％減少。"
  },
  RelicConfig_44192_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が20の狂気を獲得。獲得時、最大ライフが50％減少。"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:罪悪・悪夢の表象>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "深い眠りは欲望となり、知らぬ間にすべてを食らう。"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "毎ターン開始時、すべての覚醒体が25の狂気を獲得。獲得時、最大ライフが3倍になる。"
  },
  RelicConfig_44300_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が25の狂気を獲得。獲得時、最大ライフが3倍になる。"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:祝福・悪夢の表象>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "恐れるな、迷うな。これは一瞬の夢に過ぎない、父なる神の光はまだあなたを照らしている。"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "戦闘終了後、100黒章と2枚の「症状」カードを獲得する。"
  },
  RelicConfig_44592_Desc = {
    Text = "戦闘終了後、100黒章と2枚の「症状」カードを獲得する。"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:罪悪・翡翠の拓印>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "古代の罪悪がここに刻まれている。"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "入手時、これ以外のランダムな罪悪の遺物1つに変形し、75黒章を獲得する。"
  },
  RelicConfig_44593_Desc = {
    Text = "入手時、これ以外のランダムな罪悪の遺物1つに変形し、75黒章を獲得する。"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:罪悪・呪いの石碑>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "聞いて、誰かが中で呼んでいる。"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "2ターンごとにすべての敵が受ける能動ダメージと触腕ダメージを倍増させる。ただし、そのターン中に「狂気解放」を1回発動するたび、すべての覚醒体を1ターン封印し、自身に易傷を付与する。"
  },
  RelicConfig_44594_Desc = {
    Text = "2ターンごとにすべての敵が受ける能動ダメージと触腕ダメージを倍増させる。ただし、そのターン中に「狂気解放」を1回発動するたび、すべての覚醒体を1ターン封印し、自身に易傷を付与する。"
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:罪悪・行道の骸>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離後、それは罪悪に侵された。"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "能動ダメージを1回与えるたび、自身に[Arg1]層の<BleedingIconKeywords:出血>を付与し、ダメージ対象に[Arg2]層の<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_44597_Desc = {
    Text = "能動ダメージを1回与えるたび、自身に[Arg1]層の<BleedingIconKeywords:出血>を付与し、ダメージ対象に[Arg2]層の<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:罪悪・虫群の意識>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "絡みつく、共生、群れ；恐怖、未知、制御。"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "「狂気解放」発動後、現在のライフの12%を失い、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力量>を奪う。敵が1体のみの場合、さらに[Arg2]点の一時的な<PowerIconKeywords:力量>を追加で奪う。"
  },
  RelicConfig_44598_Desc = {
    Text = "「狂気解放」発動後、現在のライフの12%を失い、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力量>を奪う。敵が1体のみの場合、さらに[Arg2]点の一時的な<PowerIconKeywords:力量>を追加で奪う。"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:罪悪・不運の儀式鳥>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "貪欲で死んだ哀れな生き物、干からびた胸腔から耳障りな訴えを発する。"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "手札上限が5増加し、戦闘開始時にカードを6枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードを保持するが、毎ターンのドロー数が2減少する。"
  },
  RelicConfig_44603_Desc = {
    Text = "手札上限が5増加し、戦闘開始時にカードを6枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードを保持するが、毎ターンのドロー数が2減少する。"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:罪悪・意識の刻印>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "貪欲者は他人を物として扱い、他人の苦しみから自分の楽しみを獲得。"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "入手後、永久に[Arg1]<PowerIconKeywords:力量>を失う。ダメージを与えるたび、[Arg2]点のライフを回復する。毎ターン最大6回まで発動。"
  },
  RelicConfig_44608_Desc = {
    Text = "入手後、永久に[Arg1]<PowerIconKeywords:力量>を失う。ダメージを与えるたび、[Arg2]点のライフを回復する。毎ターン最大6回まで発動。"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:罪悪・ヤツメウナギのキス>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "それのキスは君を堕落させる——もちろん、堕落するのは君自身かもしれない。"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "最大行動力が3増加する。山札をリセットするたび、2枚の<DerivativeCardKeywords_9:「よろよろ」>を山札に追加する。"
  },
  RelicConfig_44609_Desc = {
    Text = "最大行動力が3増加する。山札をリセットするたび、2枚の<DerivativeCardKeywords_9:「よろよろ」>を山札に追加する。"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:罪悪・黒い蝋燭>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "理性を燃やし、狂乱へと堕ちる。"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "クリティカル率とクリティカルダメージが50%増加する。毎ターン開始時、自身に1ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  RelicConfig_44610_Desc = {
    Text = "クリティカル率とクリティカルダメージが50%増加する。毎ターン開始時、自身に1ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:罪悪・奇異な鉤爪>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "欲望に歪められた爪。"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "最大行動力が4増加。デッキをリセットするたび、4枚の<DerivativeCardKeywords_4:「啓示」>を山札に追加。"
  },
  RelicConfig_44654_Desc = {
    Text = "最大行動力が4増加。デッキをリセットするたび、4枚の<DerivativeCardKeywords_4:「啓示」>を山札に追加。"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:祝福・黒い蝋燭>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "欲望を燃やし、救済を得る。"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "遺物上限+[Arg1]、「融痕」中のリフレッシュ回数+1。戦闘終了後、125黒章を獲得する。入手時、最大6枚の「症状」カードを選択して除去する。"
  },
  RelicConfig_44656_Desc = {
    Text = "遺物上限+[Arg1]、「融痕」中のリフレッシュ回数+1。戦闘終了後、125黒章を獲得する。入手時、最大6枚の「症状」カードを選択して除去する。"
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:祝福・翡翠の拓印>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "父なる神の救いが痛みを消した。"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "狂気解放を発動後、[Arg1]点の一時的な力を獲得し、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。敵が1体のみの場合、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_44658_Desc = {
    Text = "狂気解放を発動後、[Arg1]点の一時的な力を獲得し、すべての敵から[Arg1]点の一時的な<PowerIconKeywords:力>を奪う。敵が1体のみの場合、追加で[Arg2]点の一時的な<PowerIconKeywords:力>を奪う。"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:祝福・不運の儀式鳥>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "赦しの光が貪欲な残骸を包み、死んだ鳥が最後の歌を歌う。"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "能動ダメージを1回与えるたびに、ライフを[Arg1]回復し、ダメージ対象に[Arg2]層の<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_44659_Desc = {
    Text = "能動ダメージを1回与えるたびに、ライフを[Arg1]回復し、ダメージ対象に[Arg2]層の<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:祝福・虫群の意識>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "絡みつく、共生、群れ；団結、共存、保護。"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "手札上限が5増加し、戦闘開始時に手札を上限まで補充する。ターン開始時に追加でカードを1枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_44660_Desc = {
    Text = "手札上限が5増加し、戦闘開始時に手札を上限まで補充する。ターン開始時に追加でカードを1枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:祝福・意識の刻印>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "貪欲者は自分の過ちを心に刻み、過去の贖罪に専念する。"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "2ターンごとにすべての敵が受ける能動ダメージと触腕ダメージを倍増させる。このターン中、狂気解放を1回発動するたびに、ランダムなデバフ状態を1つ解除する。"
  },
  RelicConfig_44662_Desc = {
    Text = "2ターンごとにすべての敵が受ける能動ダメージと触腕ダメージを倍増させる。このターン中、狂気解放を1回発動するたびに、ランダムなデバフ状態を1つ解除する。"
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:祝福・行道の骸>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離しても、その足跡は四海に広がっている。"
  },
  RelicConfig_44663_BattleDesc = {
    Text = "クリティカル率が50%増加し、クリティカルダメージが100%増加する。"
  },
  RelicConfig_44663_Desc = {
    Text = "クリティカル率が50%増加し、クリティカルダメージが100%増加する。"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:祝福・奇異な鉤爪>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "すべての欲望を捨てた。"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "入手後、永久的に[Arg1]<PowerIconKeywords:力>を獲得する。ダメージを与えるたびに、ライフを[Arg2]点回復する。毎ターン最大6回まで発動する。"
  },
  RelicConfig_44664_Desc = {
    Text = "入手後、永久的に[Arg1]<PowerIconKeywords:力>を獲得する。ダメージを与えるたびに、ライフを[Arg2]点回復する。毎ターン最大6回まで発動する。"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:祝福・ヤツメウナギのキス>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "この堕落のキスを拒否しなさい。父の抱擁はどんな闇よりも温かい。"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "「攻撃」と「防御」で追加50のキーエネルギーを獲得。行動力消費が2以上のカードを使用するたびに、行動力消費が1のカードを1枚引き、その行動力消費を0にする。1ターンに最大3回まで。"
  },
  RelicConfig_47444_Desc = {
    Text = "「攻撃」と「防御」で追加50のキーエネルギーを獲得。行動力消費が2以上のカードを使用するたびに、行動力消費が1のカードを1枚引き、その行動力消費を0にする。1ターンに最大3回まで。"
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:時の振り子「双生」>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "戦闘開始時、すべての覚醒体の<ExaltIconKeywords:霊知覚醒>を山札のランダムな位置に追加する。第6ターン開始後、タイスは毎ターン戦闘支援を行う。"
  },
  RelicConfig_50338_Desc = {
    Text = "戦闘開始時、すべての覚醒体の<ExaltIconKeywords:霊知覚醒>を山札のランダムな位置に追加する。第6ターン開始後、タイスは毎ターン戦闘支援を行う。"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:時の振り子「恋慕」>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "神は言った——恐れる事はないと。"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "入手後にカードを1枚選択し、その行動力消費を永久に1にする。"
  },
  RelicConfig_50385_Desc = {
    Text = "入手後にカードを1枚選択し、その行動力消費を永久に1にする。"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆枯れた瞳孔☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "砂漠で最も貴重な水を失い、彼女の瞳はすでに枯れている。"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "戦闘の最初のターン開始時、<DerivativeCardKeywords_46:「プリオン」>を手札に追加する。第3ターンに<DerivativeCardKeywords_49:「貪り攻撃」>を手札に追加する。死亡抵抗発動後、<DerivativeCardKeywords_52:「復活の繭」>を手札に追加する。"
  },
  RelicConfig_50487_Desc = {
    Text = "戦闘の最初のターン開始時、<DerivativeCardKeywords_46:「プリオン」>を手札に追加する。第3ターンに<DerivativeCardKeywords_49:「貪り攻撃」>を手札に追加する。死亡抵抗発動後、<DerivativeCardKeywords_52:「復活の繭」>を手札に追加する。"
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:時の振り子「祝福」>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "ターン終了時：最も狂気が低い覚醒体が35狂気を獲得する。残りライフが50%以上の場合、[Arg1]点の<PowerIconKeywords:力>を獲得する。残りライフが50%未満の場合、ライフを[Arg2]点回復する。"
  },
  RelicConfig_50488_Desc = {
    Text = "ターン終了時：最も狂気が低い覚醒体が35狂気を獲得する。現在のライフが50%以上の場合、[Arg1]点の<PowerIconKeywords:力>を獲得する。現在のライフが50%未満の場合、ライフを[Arg2]点回復する。"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:時の振り子「均衡」>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "クリティカル率とクリティカルダメージが100%増加する。ダメージを1回与えるたびに、すべての覚醒体のクリティカル率とクリティカルダメージが10%減少し、最大50%まで減少する。ダメージを1回与えるたびに、このターン中に与える毒と反撃が10%増加し、最大50%まで増加する。"
  },
  RelicConfig_50489_Desc = {
    Text = "クリティカル率、クリティカルダメージが100%増加する。ダメージ/触腕ダメージを1回与えるたび、このターンすべての覚醒体のクリティカル率とクリティカルダメージが10%減少する。最大50%減少。与える毒と反撃が10%増加する。最大50%増加。"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:時の振り子「移動」>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "前のカードと覚醒体が異なる指令カードを1枚使用するたび、その覚醒体は3狂気を獲得し、「活性」を1点蓄積する。10点蓄積した時、すべての「活性」をクリアし、すべての覚醒体の、行動力消費が1減少し<DepleteIconKeywords:除外>を持つランダムな指令カードをそれぞれ1枚手札に追加する。1ターンに1回のみ有効。"
  },
  RelicConfig_51686_Desc = {
    Text = "前のカードと覚醒体が異なる指令カードを1枚使用するたび、その覚醒体は3狂気を獲得し、「活性」を1点蓄積する。10点蓄積した時、すべての「活性」をクリアし、すべての覚醒体の、行動力消費が1減少し<DepleteIconKeywords:除外>を持つランダムな指令カードをそれぞれ1枚手札に追加する。1ターンに1回のみ有効。"
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:時の振り子「進化」>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "「攻撃」「防御」以外の指令カードを使用した後、このカードが派生カードでない場合、対応する覚醒体は15狂気を獲得し、毎ターン最大5回まで発動する。毎ターン1回目の発動時、使用したカードを手札に戻す。"
  },
  RelicConfig_51687_Desc = {
    Text = "「攻撃」「防御」以外の指令カードを使用した後、そのカードが派生カードでない場合、対応する覚醒体は15狂気を獲得し、毎ターン最大5回まで発動する。毎ターン1回目の発動時、使用したカードを手札に戻す。"
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:時の振り子「投影」>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "入手時、すべての指令カードに「保持」を付与する。ターン終了時、手札が5枚以上の場合、ランダムな手札3枚の行動力消費が1減少し、そうでなければカードを3枚引く。"
  },
  RelicConfig_51688_Desc = {
    Text = "入手時、すべての指令カードに「保持」を付与する。ターン終了時、手札が5枚以上の場合、ランダムな手札3枚の行動力消費が1減少し、そうでなければカードを3枚引く。"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:時の振り子「温床」>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "戦闘開始時、ランダムな症状カードを3枚山札に加える。ターン開始時、カードを1枚引く。症状カードを1枚使用するたび、2点の行動力を獲得する。症状カードを1枚捨てるたび、すべての覚醒体が5狂気を獲得する。毎ターン最大5回まで発動。"
  },
  RelicConfig_51689_Desc = {
    Text = "戦闘開始時、ランダムな症状カードを3枚山札に加える。ターン開始時、カードを1枚引く。症状カードを1枚使用するたび、2点の行動力を獲得する。症状カードを1枚捨てるたび、すべての覚醒体が5狂気を獲得する。毎ターン最大5回まで発動。"
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:時の振り子「疫病」>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "シミュレーション戦標準遺物7セット。"
  },
  RelicConfig_55847_Desc = {
    Text = "シミュレーション戦標準遺物7セット。"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆模擬戦の遺物☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "奇妙な時代に、花は人類の最初の観賞者だった。\n動かないで、彼らは静かな展示品を好む。"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、ランダムな「イメージ」を1枚デッキに加える。"
  },
  RelicConfig_55874_Desc = {
    Text = "戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、ランダムな「イメージ」を1枚デッキに加える。"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:オルラのペンとインク>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "古代の罪悪がここに刻まれている。"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "手札上限+2。ターン開始時、カードを1枚引く。戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、「イメージ」を1枚選択してデッキに加える。"
  },
  RelicConfig_56355_Desc = {
    Text = "手札上限+2。ターン開始時、カードを1枚引く。戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、「イメージ」を1枚選択してデッキに加える。"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:オルラのペンとインク>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "古代の罪悪がここに刻まれている。"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、「イメージ」を1枚選択してデッキに加える。"
  },
  RelicConfig_56356_Desc = {
    Text = "戦闘終了後、[Arg1]点の「ペンとインク」を獲得する。「ペンとインク」が2点に達すると消費され、「イメージ」を1枚選択してデッキに加える。"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:オルラのペンとインク>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "古代の罪悪がここに刻まれている。"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "最初に2点の「神母の権能」を持つ。第3ターン以降、毎ターン開始時に「神母の権能」を消費するいずれかの効果か、「神母の権能」の回復を選択できる。致死ダメージを受けた場合、すべての「神母の権能」を消費して復活し、1点につきライフを10%回復する。この効果は1回のみ発動可能。"
  },
  RelicConfig_57667_Desc = {
    Text = "最初に2点の「神母の権能」を持つ。第3ターン以降、毎ターン開始時に「神母の権能」を消費するいずれかの効果か、「神母の権能」の回復を選択できる。致死ダメージを受けた場合、すべての「神母の権能」を消費して復活し、1点につきライフを10%回復する。この効果は1回のみ発動可能。"
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:神母の庇護>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "すべての覚醒体のクリティカル率が15%増加する。ライカーとダイスのランダム効果の最終結果が1増加する。"
  },
  RelicConfig_57732_Desc = {
    Text = "すべての覚醒体のクリティカル率が15%増加する。ライカーとダイスのランダム効果の最終結果が1増加する。"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:高級な幸運のコート>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "それは分厚い壁となって、風雨や不運を寄せつけない。"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "ターン開始時及びライカーまたはダイスのランダム効果発動時、100キーエネルギーと4%のクリティカルダメージを獲得。最大50%までクリティカルダメージを獲得でき、戦闘終了時に解除される。"
  },
  RelicConfig_57733_Desc = {
    Text = "ターン開始時及びライカーまたはダイスのランダム効果発動時、100キーエネルギーと4%のクリティカルダメージを獲得。最大50%までクリティカルダメージを獲得でき、戦闘終了時に解除される。"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:精巧な大口ボタン>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "大口のボタンは丸いものが大好き、例えば月、チップ、新鮮な眼球。\n満月の夜には黒い霧を吐き出すが、その原因は不明である。"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "キーオーダーを発動するたび、「輝くイカサマダイス」を手札に1枚追加する。"
  },
  RelicConfig_57734_Desc = {
    Text = "キーオーダーを発動するたび、「輝くイカサマダイス」を手札に1枚追加する。"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:輝くイカサマダイス>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "きらきらと輝くのは外見だけではない。\nそこには、不屈の心もまた輝いている。\nそれを5秒以上見つめると、@2を引き寄せてしまう。"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "ターン開始時及びライカーまたはダイスのランダム効果発動時、50キーエネルギーと2%のクリティカルダメージを獲得。最大30%までクリティカルダメージを獲得でき、戦闘終了時に解除される。"
  },
  RelicConfig_57735_Desc = {
    Text = "ターン開始時及びライカーまたはダイスのランダム効果発動時、50キーエネルギーと2%のクリティカルダメージを獲得。最大30%までクリティカルダメージを獲得でき、戦闘終了時に解除される。"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:大口ボタン>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "大口のボタンは丸いものが大好き、例えば月、チップ、新鮮な眼球。\n満月の夜には黒い霧を吐き出すが、その原因は不明である。"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "キーオーダーを発動するたび、「イカサマダイス」を手札に1枚追加する。"
  },
  RelicConfig_57736_Desc = {
    Text = "キーオーダーを発動するたび、「イカサマダイス」を手札に1枚追加する。"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:イカサマダイス>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "きらきらと輝くのは外見だけではない。\nそこには、不屈の心もまた輝いている。\nそれを5秒以上見つめると、@2を引き寄せてしまう。"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "すべての覚醒体のクリティカル率が10%増加する。ライカーとダイスのすべてのランダム効果で最低値は出現しない。"
  },
  RelicConfig_57737_Desc = {
    Text = "すべての覚醒体のクリティカル率が10%増加する。ライカーとダイスのすべてのランダム効果で最低値は出現しない。"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:幸運のコート>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "それは分厚い壁となって、風雨や不運を寄せつけない。"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「ルビーのブローチ、縞瑪瑙、救難信号、厄運の儀式鳥、時の振り子「夢中」」。"
  },
  RelicConfig_57791_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「ルビーのブローチ、縞瑪瑙、救難信号、厄運の儀式鳥、時の振り子「夢中」」。"
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「漁叉、異郷の切手挟み、アルカナ記録、意識銘刻、時の振り子「蓄積」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57792_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「漁叉、異郷の切手挟み、アルカナ記録、意識銘刻、時の振り子「蓄積」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「レーザー顎骨、怪しい軟膏、埃被りミシン、異種喉舌、時の振り子「移動」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57793_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「レーザー顎骨、怪しい軟膏、埃被りミシン、異種喉舌、時の振り子「移動」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「イラクサのベスト、古い友の懐中時計、先賢断章、救済の肢、時の振り子「蔓延」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57794_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「イラクサのベスト、古い友の懐中時計、先賢断章、救済の肢、時の振り子「蔓延」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「錆びたメス、止血鉗子、古びたパズル、虫群意識、時の振り子「双生」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57795_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「錆びたメス、止血鉗子、古びたパズル、虫群意識、時の振り子「双生」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「精密タイマー、月桂樹のカフリンクス、無名の神のヴェール、悪夢の表象、時の振り子「均衡」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57796_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「精密タイマー、月桂樹のカフリンクス、無名の神のヴェール、悪夢の表象、時の振り子「均衡」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「新品の財布、ミサゴの校章、群星の酒、ヤツメウナギの口づけ、時の振り子「眼」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57797_Desc = {
    Text = "遺物上限+1。戦闘開始後の最初の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「新品の財布、ミサゴの校章、群星の酒、ヤツメウナギの口づけ、時の振り子「眼」」。これらの遺物は戦闘開始後の効果を発動する。"
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:時の振り子「沈没船の秘宝」>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "伝説によれば、リモリアはこの海域で陥落した。誰が沈没船の宝の秘密を探ることを我慢できるだろうか？"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「錆びたメス、新式車軸、我が家、奇妙な鉤爪、時の振り子・入迷」。"
  },
  RelicConfig_58872_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「錆びたメス、新式車軸、我が家、奇妙な鉤爪、時の振り子・入迷」。"
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:時の振り子「秘宝α」>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「甘いインク、失声蓄音機、群星の酒、奇術シルクハット、時の振り子・移動」。"
  },
  RelicConfig_58873_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「甘いインク、失声蓄音機、群星の酒、奇術シルクハット、時の振り子・移動」。"
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:時の振り子「秘宝β」>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "ターン開始後、「ライカーのラッキーダイス」を1枚獲得。このカードのダイスの出目が2～7になる。ターン開始時とダイスを振るたびにすべての覚醒体は4%のクリティカルダメージを獲得し、最大100%まで獲得できる。"
  },
  RelicConfig_59118_Desc = {
    Text = "ターン開始後、「ライカーのラッキーダイス」を1枚獲得。このカードのダイスの出目が2～7になる。ターン開始時とダイスを振るたびにすべての覚醒体は4%のクリティカルダメージを獲得し、最大100%まで獲得できる。"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:時の振り子「混沌の贈り物」>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "古代の罪悪がここに刻まれている。"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "シミュレーション戦標準遺物7セット。"
  },
  RelicConfig_59687_Desc = {
    Text = "シミュレーション戦標準遺物7セット。"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆模擬戦の遺物☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "奇妙な時代に、花は人類の最初の観賞者だった。\n動かないで、彼らは静かな展示品を好む。"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "最大行動力が1点増加、ターン開始時に追加でカードを1枚引き、「調和する響き」を1枚獲得。連続して3回、同じ行動力消費の指令カードを使用すると、すべての覚醒体に20狂気を付与、ターン開始時と発動後に回数がリセット。"
  },
  RelicConfig_60723_Desc = {
    Text = "最大行動力が1点増加、ターン開始時に追加でカードを1枚引き、「調和する響き」を1枚獲得。連続して3回、同じ行動力消費の指令カードを使用すると、すべての覚醒体に20狂気を付与、ターン開始時と発動後に回数がリセット。"
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:指揮者のタクト>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "細い指揮棒、それは鉄槌よりも強力だ。\n\n音符を指揮し、魂を指揮し、運命を指揮する。"
  },
  RelicConfig_60724_BattleDesc = {
    Text = "戦闘開始時、「軟化」の刻印と「爆発」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60724_Desc = {
    Text = "戦闘開始時、「軟化」の刻印と「爆発」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60725_BattleDesc = {
    Text = "戦闘開始時、「狂気」の刻印と「触媒」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60725_Desc = {
    Text = "戦闘開始時、「狂気」の刻印と「触媒」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60726_BattleDesc = {
    Text = "戦闘開始時、「倦怠」の刻印と「策謀」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60726_Desc = {
    Text = "戦闘開始時、「倦怠」の刻印と「策謀」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60727_BattleDesc = {
    Text = "戦闘開始時、「鉄壁」の刻印と「神技」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60727_Desc = {
    Text = "戦闘開始時、「鉄壁」の刻印と「神技」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60728_BattleDesc = {
    Text = "戦闘開始時、刻印「受胎」と刻印「準備」、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60728_Desc = {
    Text = "戦闘開始時、刻印「受胎」と刻印「準備」、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60729_BattleDesc = {
    Text = "戦闘開始時、「神技」の刻印と「啓示」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60729_Desc = {
    Text = "戦闘開始時、「神技」の刻印と「啓示」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60730_BattleDesc = {
    Text = "戦闘開始時、「剛力」の刻印と「衰弱」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60730_Desc = {
    Text = "戦闘開始時、「剛力」の刻印と「衰弱」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60731_BattleDesc = {
    Text = "戦闘開始時、2つの「合奏」の刻印とその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60731_Desc = {
    Text = "戦闘開始時、2つの「合奏」の刻印とその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_60732_BattleDesc = {
    Text = "戦闘開始時、「策謀」の刻印と「鏡像」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60732_Desc = {
    Text = "戦闘開始時、「策謀」の刻印と「鏡像」の刻印、およびその上位刻印を獲得し、カードに刻印するものを選択する。"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:時の振り子「校長の言葉」>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_65376_BattleDesc = {
    Text = "最初に調査隊の人数を[Arg1]人所持する。戦闘開始時、<DerivativeCardKeywords_73:疑念>を5枚山札にに追加する。"
  },
  RelicConfig_65376_Desc = {
    Text = "最初に調査隊の人数を[Arg1]人所持する。戦闘開始時、<DerivativeCardKeywords_73:疑念>を5枚山札に追加する。"
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:調査隊>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "ミサゴ創設者の言葉が耳元に響く。\n\n銀の鍵が道を照らさんことを、ミサゴの守秘者よ。"
  },
  RelicConfig_65406_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_71:「きらめく人間性の輝き」>を[Arg1]枚獲得。\n<D05EX_Relic:あなたのすべての努力は報われた。調査隊のほとんどを無事に守り抜き、生き残った人々は心からあなたに感謝している。>"
  },
  RelicConfig_65406_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_71:「きらめく人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたのすべての努力は報われた。調査隊のほとんどを無事に守り抜き、生き残った人々は心からあなたに感謝している。>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:救難勲章・プラチナ>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "あなたのすべての努力は報われた。調査隊のほとんどを無事に守り抜き、生き残った人々は心からあなたに感謝している。"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_72:「まばゆい人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは驚くべき奇跡を起こした。全員がこの災厄を生き残った。あなたは人々の偉大な英雄となり、この伝説は雪山の周辺に語り継がれていくことだろう。>"
  },
  RelicConfig_65407_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_72:「まばゆい人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは驚くべき奇跡を起こした。全員がこの災厄を生き残った。あなたは人々の偉大な英雄となり、この伝説は雪山の周辺に語り継がれていくことだろう。>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:救難勲章・ダイヤモンド>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "あなたは驚くべき奇跡を起こした。全員がこの災厄を生き残った。あなたは人々の偉大な英雄となり、この伝説は雪山の周辺に語り継がれていくことだろう。"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_68:「ほの暗い人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:雪山を抜け出すため、あなたは効率を最優先する戦略を選んだ。一人また一人と死んでいく隊員を見送った。生存者たちのあなたを見る眼差しは、感謝よりも恐怖の方が大きかった。>"
  },
  RelicConfig_65408_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_68:「ほの暗い人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:雪山を抜け出すため、あなたは効率を最優先する戦略を選んだ。一人また一人と死んでいく隊員を見送った。生存者たちのあなたを見る眼差しは、感謝よりも恐怖の方が大きかった。>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:救難勲章・ブロンズ>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "雪山を抜け出すため、あなたは効率を最優先する戦略を選んだ。一人また一人と死んでいく隊員を見送った。生存者たちのあなたを見る眼差しは、感謝よりも恐怖の方が大きかった。"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_69:「微かな人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは全力を尽くしたのだろう。半数の隊員は命を落としたが、少なくとも残りの半数を救った。結局のところ、犠牲は避けられないものなのだ。>"
  },
  RelicConfig_65409_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_69:「微かな人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは全力を尽くしたのだろう。半数の隊員は命を落としたが、少なくとも残りの半数を救った。結局のところ、犠牲は避けられないものなのだ。>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:救難勲章・シルバー>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "あなたは全力を尽くしたのだろう。半数の隊員は命を落としたが、少なくとも残りの半数を救った。結局のところ、犠牲は避けられないものなのだ。"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "ターン開始時、<DerivativeCardKeywords_70:「人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは人々の大半を救い、本来なら悲劇で終わるはずだった運命を書き替えた。あなたは最善を尽くしたのではないか？>"
  },
  RelicConfig_65410_Desc = {
    Text = "ターン開始時、<DerivativeCardKeywords_70:「人間性の輝き」>を[Arg1]枚獲得する。\n<D05EX_Relic:あなたは人々の大半を救い、本来なら悲劇で終わるはずだった運命を書き替えた。あなたは最善を尽くしたのではないか？>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:救難勲章・ゴールド>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "あなたは人々の大半を救い、本来なら悲劇で終わるはずだった運命を書き替えた。あなたは最善を尽くしたのではないか？"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "戦闘開始時にランダムな「症状」を3枚山札に追加し、「症状」を使用した時、[Arg1]点の力を獲得する。\n<D05EX_Relic:あなたの助けも虚しく、調査隊は全滅した。あなたは冷酷に最大利益を追求したが、本当にそれで良かったのか？>"
  },
  RelicConfig_65456_Desc = {
    Text = "戦闘開始時にランダムな「症状」を3枚山札に追加し、「症状」を使用した時、[Arg1]点の力を獲得する。\n<D05EX_Relic:あなたの助けも虚しく、調査隊は全滅した。あなたは冷酷に最大利益を追求したが、本当にそれで良かったのか？>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:孤独者の徽章>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "あなたの助けも虚しく、調査隊は全滅した。あなたは冷酷に最大利益を追求したが、本当にそれで良かったのか？"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「通信機、春の祭典、祭司の杖、厄運儀式鳥、時の振り子・投射」。"
  },
  RelicConfig_65569_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「通信機、春の祭典、祭司の杖、厄運儀式鳥、時の振り子・投射」。"
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:時の振り子「秘宝δ」>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「ミサゴの校章、医者の手提げ鞄、原型電池、意識銘刻、時の振り子・衍化」。"
  },
  RelicConfig_65570_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に遺物を1つ獲得する。内容は「ミサゴの校章、医者の手提げ鞄、原型電池、意識銘刻、時の振り子・衍化」。"
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:時の振り子「秘宝γ」>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に造物を1つ獲得する。内容は「プトニー朝報、美学原理、群氓の歌、残欠の顔、時の振り子·往来」。"
  },
  RelicConfig_66515_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。その後の5ターン、毎ターン開始時に造物を1つ獲得する。内容は「プトニー朝報、美学原理、群氓の歌、残欠の顔、時の振り子·往来」。"
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:時の振り子「秘宝ε」>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_66518_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:時の振り子「祈りβ」>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_66519_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:時の振り子「祈りα」>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "毎ターン開始時、すべての覚醒体が25狂気を獲得。拾得時、最大ライフが1.5倍になる。"
  },
  RelicConfig_67690_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が25狂気を獲得。拾得時、最大ライフが1.5倍になる。"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:祝福・悪夢の表象β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "恐れるな、迷うな。これは一瞬の夢に過ぎない、父なる神の光はまだあなたを照らしている。"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "入手時、3点の行動力を獲得する。"
  },
  RelicConfig_67788_Desc = {
    Text = "入手時、3点の行動力を獲得する。"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:懐中時計の鏡>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "記憶が過去の時間に凝固し、黒い底に深く埋もれている。"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "入手時、<DerivativeCardKeywords_1:「影の残響」>を1枚手札に追加する。"
  },
  RelicConfig_67789_Desc = {
    Text = "入手時、<DerivativeCardKeywords_1:「影の残響」>を1枚手札に追加する。"
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:通信機>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "そのベルの音が鳴る瞬間を期待し、または恐れる。"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "すべての「攻撃」が与えるクリティカルダメージが20%増加する。入手時、<DerivativeCardKeywords_40:「美しい瞬間」>を1枚手札に追加する。"
  },
  RelicConfig_67790_Desc = {
    Text = "すべての「攻撃」が与えるクリティカルダメージが20%増加する。入手時、<DerivativeCardKeywords_40:「美しい瞬間」>を1枚手札に追加する。"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:美しい瞬間>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "刹那の美を永遠に保存する。"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "入手時、すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  RelicConfig_67791_Desc = {
    Text = "入手時、すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:変色拘束服>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "時間だけじゃなく、恐怖と苦痛も布を変色させる。"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "戦闘開始時、すべての覚醒体が50狂気を獲得する。<DerivativeCardKeywords_1:「影の残響」>を2枚手札に追加する。"
  },
  RelicConfig_67793_Desc = {
    Text = "入手時、すべての覚醒体が50狂気を獲得し、<DerivativeCardKeywords_1:「影の残響」>を2枚手札に追加する。"
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:通信機+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "そのベルの音が鳴る瞬間を期待し、または恐れる。"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "手札上限が5増加し、戦闘開始時に手札を上限まで補充する。ターン開始時に追加でカードを1枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_67794_Desc = {
    Text = "手札上限が5増加し、戦闘開始時に手札を上限まで補充する。ターン開始時に追加でカードを1枚引く。ターン終了時、手札のすべての「症状」カードと「ステータス」カードを捨て、その他のカードに「保持」を付与する。"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:祝福・意識の刻印β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "貪欲者は自分の過ちを心に刻み、過去の贖罪に専念する。"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67818_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:「万象の門ε」>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67819_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:「万象の門ζ」>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67820_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:「万象の門θ」>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67821_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:「万象の門γ」>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67822_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:「万象の門α」>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67823_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:「万象の門η」>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67824_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:「万象の門δ」>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67825_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:「万象の門β」>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67826_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。ターン開始時、ランダムに「遺物」または「支援」を1つ発見し、合計5回発見する。"
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:「万象の門ι」>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_84:「追憶の微光-未完成の蝋人形」>を手札に追加し、山札のすべてのカードをコピーする。毎ターン追加でカードを5枚引き、行動力を5点獲得する。「攻撃」または「防御」使用後、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_68651_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_84:「追憶の微光-未完成の蝋人形」>を手札に追加し、山札のすべてのカードをコピーする。毎ターン追加でカードを5枚引き、行動力を5点獲得する。「攻撃」または「防御」使用後、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:「純銀の核・恐怖」>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_85:「追憶の微光-異形の心臓」>を手札に追加する。ターン開始時、任意の手札を捨て、捨てた枚数と同数のカードを引くことができる。奇数ターンに[Arg1]点の一時的な力を獲得し、「<DerivativeCardKeywords_97:「不屈の戦意β」>」を手札に追加する。偶数ターンに[Arg2]点の一時的な警戒を獲得し、<DerivativeCardKeywords_98:「隠れるβ」>を手札に追加する。"
  },
  RelicConfig_68652_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_85:「追憶の微光-異形の心臓」>を手札に追加する。ターン開始時、任意の手札を捨て、捨てた枚数と同数のカードを引くことができる。奇数ターンに[Arg1]点の一時的な力を獲得し、「<DerivativeCardKeywords_97:「不屈の戦意β」>」を手札に追加する。偶数ターンに[Arg2]点の一時的な警戒を獲得し、<DerivativeCardKeywords_98:「隠れるβ」>を手札に追加する。"
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:「純銀の核・刺骨」>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_83:「追憶の微光-無邪気な贈り物」>を手札に追加する。すべての覚醒体は毎ターン追加で1回「狂気解放」を発動でき、「狂気解放」を発動した後、敵から[Arg2]点の力を減少させる。ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_68653_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_83:「追憶の微光-無邪気な贈り物」>を手札に追加する。すべての覚醒体は毎ターン追加で1回「狂気解放」を発動でき、「狂気解放」を発動した後、敵から[Arg2]点の力を減少させる。ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:「純銀の核・悲観」>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_88:「追憶の微光-理想郷の帳」>を手札に追加し、チームの手札上限+2、キーエネルギー貯蔵上限+100%。「キーオーダー」発動後、すべての覚醒体の一時的なクリティカル率とクリティカルダメージ+[Arg1]%、最大ライフの20%のシールドを獲得し、手札が上限に達するまでカードを引く。"
  },
  RelicConfig_68654_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_88:「追憶の微光-理想郷の帳」>を手札に追加し、チームの手札上限+2、キーエネルギー貯蔵上限+100%。「キーオーダー」発動後、すべての覚醒体の一時的なクリティカル率とクリティカルダメージ+[Arg1]%、最大ライフの20%のシールドを獲得し、手札が上限に達するまでカードを引く。"
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:「純銀の核・狂気」>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_89:「追憶の微光-豊穣の核」>を手札に追加する。ターン終了時、残り行動力を保持し、手札を捨てない。アクティブダメージを1回与えるたび、[Arg1]点の一時的な力と[Arg2]点のシールドを獲得する。"
  },
  RelicConfig_68655_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_89:「追憶の微光-豊穣の核」>を手札に追加する。ターン終了時、残り行動力を保持し、手札を捨てない。アクティブダメージを1回与えるたび、[Arg1]点の一時的な力と[Arg2]点のシールドを獲得する。"
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:「純銀の核・誕生」>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_86:「追憶の微光-蜂蜜酒」>を手札に追加し、すべての覚醒体のクリティカルダメージが1.5倍になる。ターン終了時に「狂気解放」を発動しなかった覚醒体は[Arg1]狂気を獲得する。使用したカード数が[Arg2]枚未満の場合、次のターンカードを2枚引き、行動力を2点獲得する。"
  },
  RelicConfig_68656_Desc = {
    Text = "戦闘開始時にすべての覚醒体を覚醒させ、<DerivativeCardKeywords_86:「追憶の微光-蜂蜜酒」>を手札に追加し、すべての覚醒体のクリティカルダメージが1.5倍になる。ターン終了時に「狂気解放」を発動しなかった覚醒体は[Arg1]狂気を獲得する。使用したカード数が[Arg2]枚未満の場合、次のターンカードを2枚引き、行動力を2点獲得する。"
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:「純銀の核・幻想」>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "バトル開始時に全ての覚醒体を覚醒させ、<DerivativeCardKeywords_87:「追憶の微光 - 代行者の裁決」>を手札に加え、チームのダメージ強化が2倍になる。プレイヤーが与える虚弱効果が25%から50%に上昇し、毎ターン終了時に最大ライフの[Arg1]％のシールドを獲得し、全ての敵に自身のシールドの[Arg2]倍に等しい<FixedDamage:純粋ダメージ>を与える。"
  },
  RelicConfig_68657_Desc = {
    Text = "バトル開始時に全ての覚醒体を覚醒させ、<DerivativeCardKeywords_87:「追憶の微光 - 代行者の裁決」>を手札に加え、チームのダメージ強化が2倍になる。プレイヤーが与える虚弱効果が25%から50%に上昇し、毎ターン終了時に最大ライフの[Arg1]％のシールドを獲得し、全ての敵に自身のシールドの[Arg2]倍に等しい<FixedDamage:純粋ダメージ>を与える。"
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:「純銀の核・邪教」>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "タヴィが与えるダメージ、治癒力、シールドが50%増加する。戦闘開始時、タヴィは120狂気を獲得する。"
  },
  RelicConfig_68886_Desc = {
    Text = "タヴィが与えるダメージ、シールド、ライフ回復が50%増加する。戦闘開始時、タヴィは120狂気を獲得する。"
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:「全知の眼」>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "扉から出て、彼は唯一正しい道を踏み出した。"
  },
  RelicConfig_69319_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69319_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:時の振り子「祈りε」>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69320_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:時の振り子「祈りγ」>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69321_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、遺物を1つ発見し、合計5回発見する。"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:時の振り子「祈りδ」>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "ターン開始時、「深淵の源泉エネルギー」を1点蓄積し、「熟睡」または「目覚め」を選択する。「熟睡」：「深淵の源泉エネルギー」を1点追加で蓄積。「目覚め」：「深淵の源泉エネルギー」を1/5/10点消費し、トゥルーの援助を得る。「深淵の源泉エネルギー」を消費するほど、トゥルーの援助効果は増加。"
  },
  RelicConfig_70042_Desc = {
    Text = "ターン開始時、「深淵の源泉エネルギー」を1点蓄積し、「熟睡」または「目覚め」を選択する。「熟睡」：「深淵の源泉エネルギー」を1点追加で蓄積。「目覚め」：「深淵の源泉エネルギー」を1/5/10点消費し、トゥルーの援助を得る。「深淵の源泉エネルギー」を消費するほど、トゥルーの援助効果は増加。"
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:神王の権能>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "戦闘開始時、すべての覚醒体の「霊知覚醒」を山札のランダムな位置に追加する。"
  },
  RelicConfig_70084_Desc = {
    Text = "戦闘開始時、すべての覚醒体の「霊知覚醒」を山札のランダムな位置に追加する。"
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:霊知覚醒>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加。"
  },
  RelicConfig_70700_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加。"
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:号泣パイプ>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "これは憎しみの産物か、それとも復讐の結果か？"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70701_Desc = {
    Text = "ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:原型電池>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "携帯用の希望。"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "「狂気解放」を発動した後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70702_Desc = {
    Text = "「狂気解放」を発動した後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:重鎖+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "厚くて頑丈な鍵、キーがなければ開けるのは難しそうだ。\nもちろん、ある神盗みには大したことではない。"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "「攻撃」は追加で覚醒体の攻撃力の[Arg1]%のダメージを1回与え、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70703_Desc = {
    Text = "「攻撃」は追加で覚醒体の攻撃力の[Arg1]%のダメージを1回与え、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:錆びた柳葉刀>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "生体の切開には適していない。"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70704_Desc = {
    Text = "シルバーキー覚醒後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:怪しい軟膏+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "自作の外傷用軟膏、医者の指導なしに使用しないでください。"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "「攻撃」はダメージの[Arg1]%の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大[Arg2]点まで付与する。"
  },
  RelicConfig_70705_Desc = {
    Text = "「攻撃」はダメージの[Arg1]%の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大[Arg2]点まで付与する。"
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:異種の舌+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "彼は悪魔ではないが、確かに異界の囁きを伝える。"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>の自動獲得量が[Arg1]%増加する。"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>の自動獲得量が[Arg1]%増加する。"
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:疫病診断書>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "疫病——自然の無意識な苛立ちの偶然の表れ。"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての覚醒体は[Arg1]狂気と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70707_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体は[Arg1]狂気と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:月桂樹のカフリンクス+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "月桂樹の模様が刻まれた銀のカフスボタン。\n精巧な作りで、輝いており、かつて二人の子供の友情を支えていた。"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<IntoxicationIconKeywords:毒>と遺物が与える<IntoxicationIconKeywords:毒>が[Arg2]%増加する。"
  },
  RelicConfig_70708_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<IntoxicationIconKeywords:毒>と遺物が与える<IntoxicationIconKeywords:毒>が[Arg2]%増加する。"
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:埃をかぶったミシン+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "慈愛に満ちた母親が心の傷を縫い合わせる。"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "超次元ターンに入った後、最初に使用した非派生指令カードは追加で[Arg1]回効果が発動する。"
  },
  RelicConfig_70709_Desc = {
    Text = "超次元ターンに入った後、最初に使用した非派生指令カードは追加で[Arg1]回効果が発動する。"
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:輝きの砂時計>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "計測可能な時間。"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<RetaliateIconKeywords:反撃>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70711_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<RetaliateIconKeywords:反撃>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:賢者の断章+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "「人類はなんて愚かなんだ、古臭いものを盲信する」"
  },
  RelicConfig_70712_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<PowerIconKeywords:力>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70712_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<PowerIconKeywords:力>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:我が家>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "彼らは以前も一緒にいて、これからも永遠に一緒にいる。彼らは愛し合う家族だ。"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "ライフを失った時、ライフ損失量の[Arg1]%の深紅の炉を獲得する。"
  },
  RelicConfig_70713_Desc = {
    Text = "ライフを失った時、ライフ損失量の[Arg1]%の深紅の炉を獲得する。"
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:錆びた鋸>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "解剖医の目に映るのは、美しい女性ではなく——骨、病の神経、炎症を起こした筋肉と組織だけ。"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<RetaliateIconKeywords:反撃>と遺物が与える<RetaliateIconKeywords:反撃>が[Arg2]%増加する。"
  },
  RelicConfig_70714_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<RetaliateIconKeywords:反撃>と遺物が与える<RetaliateIconKeywords:反撃>が[Arg2]%増加する。"
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:知識の泉>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "それは無数の秘密を伝えた、積極的に言われたものも、受動的に言われたものも。"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "シルバーキー覚醒後、カードを[Arg1]枚引き、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70715_Desc = {
    Text = "シルバーキー覚醒後、カードを[Arg1]枚引き、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:新品の財布+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "ミサゴ大学の校章が刻まれた革財布。\n中は今空っぽで、何も入っていない。"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "ターン開始時にカードを[Arg1]枚引く。"
  },
  RelicConfig_70717_Desc = {
    Text = "ターン開始時にカードを[Arg1]枚引く。"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:方位磁針+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "指示するのは方向ではなく、磁場だ。"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "「狂気解放」を使用した後、全ての敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、[Arg2]%の<IntoxicationIconKeywords:毒>を発動する。"
  },
  RelicConfig_70718_Desc = {
    Text = "「狂気解放」を使用した後、全ての敵に味方の最大ライフ値の[Arg2]%に等しい<FixedDamage:純粋ダメージ>を1回与え、[Arg2]%の<IntoxicationIconKeywords:毒>を発動する。"
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:光を放つ顎骨>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "あるコレクターのプライベート展示室に陳列された遺骨。\nコレクターはその美しい蛍光に心を奪われ、日夜鑑賞し、最終的に枯れ果て、同類となった。"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70719_Desc = {
    Text = "ターン開始時、すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:原型電池+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "携帯用の希望。"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70720_Desc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:無上の栄誉>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "優雅で神秘的な黒猫、遠い砂漠の国で神の化身とされていたという。しかし、その神の名は今や誰も知らない。\n崇拝され、敬われ、忘れられる、それが神の宿命かもしれない。"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "1ターンに「狂気解放」を4回発動した後、[Arg1]点の行動力を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70721_Desc = {
    Text = "1ターンに「狂気解放」を4回発動した後、[Arg1]点の行動力を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:銀白の演算器>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "「それは歴史を変えた」"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<PowerIconKeywords:力>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70722_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<PowerIconKeywords:力>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:我が家+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "彼らは以前も一緒にいて、これからも永遠に一緒にいる。彼らは愛し合う家族だ。"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "前のカードより行動力消費が高いカードを2回連続で使用した時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70723_Desc = {
    Text = "前のカードより行動力消費が高いカードを2回連続で使用した時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:アルカナ記録+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "運命の動向。"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "戦闘開始時に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70724_Desc = {
    Text = "戦闘開始時に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:ルビーのブローチ+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "赤がじわりと滲み出る。"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<WeaknessIconKeywords:倦怠>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70725_Desc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<WeaknessIconKeywords:倦怠>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:悪童+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "純粋な悪から生まれたもの。それが彼の望みでは、なかったとしても。"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "黒渦消滅は[Arg1]点のシールドを獲得し、クールダウン3ターン。"
  },
  RelicConfig_70726_Desc = {
    Text = "黒渦消滅は[Arg1]点のシールドを獲得し、クールダウン3ターン。"
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:超弦懐中時計>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "「あら、懐中時計が止まった」"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_70727_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:恩恵の血+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "それは甘く芳醇で、バラの香りがする。"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "「静海」姿勢を使用した後、すべての敵から[Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させ、クールダウン3ターン。"
  },
  RelicConfig_70728_Desc = {
    Text = "「静海」姿勢を使用した後、すべての敵から[Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させ、クールダウン3ターン。"
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:名無しの肢体+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "刺さないように気をつけて。"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "戦闘開始時に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70730_Desc = {
    Text = "戦闘開始時に[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:ルビーのブローチ>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "赤がじわりと滲み出る。"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "敵の攻撃を受けた時、その敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、このダメージは[Arg2]%の<RetaliateIconKeywords:カウンター>ボーナスの恩恵を受け、各敵につき毎ターン最大1回まで発動する。"
  },
  RelicConfig_70731_Desc = {
    Text = "敵の攻撃を受けた時、その敵に味方の最大ライフ値の[Arg3]%に等しい<FixedDamage:純粋ダメージ>を与え、このダメージは[Arg2]%の<RetaliateIconKeywords:カウンター>ボーナスの恩恵を受け、各敵につき毎ターン最大1回まで発動する。"
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:遺失の祭祀刀+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "刃が曲がった短剣。祭祀儀式に使われることが多い。"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "超次元ターンに入った後、最初に使用した非派生指令カードは追加で[Arg1]回効果が発動する。"
  },
  RelicConfig_70732_Desc = {
    Text = "超次元ターンに入った後、最初に使用した非派生指令カードは追加で[Arg1]回効果が発動する。"
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:輝きの砂時計+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "計測可能な時間。"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>の自動獲得量が[Arg1]%増加する。"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>の自動獲得量が[Arg1]%増加する。"
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:疫病診断書+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "疫病——自然の無意識な苛立ちの偶然の表れ。"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が与える基礎ダメージが[Arg1]%増加し、[Arg2]シルバーキーエネルギーを獲得。"
  },
  RelicConfig_70734_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が与える基礎ダメージが[Arg1]%増加し、[Arg2]シルバーキーエネルギーを獲得。"
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:秘典の星象儀>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "宇宙の神秘。"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "前のカードより行動力消費が低いカードを2回連続で使用した時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70735_Desc = {
    Text = "前のカードより行動力消費が低いカードを2回連続で使用した時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:アルカナ遺物+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "運命の終焉。"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "「静海」姿勢を使用した後、すべての敵から[Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させ、クールダウン3ターン。"
  },
  RelicConfig_70736_Desc = {
    Text = "「静海」姿勢を使用した後、すべての敵から[Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させ、クールダウン3ターン。"
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:名無しの肢体>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "刺さないように気をつけて。"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "カード使用後、手札枚数が[Arg1]枚以下の場合、カードを[Arg2]枚引き、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_70737_Desc = {
    Text = "カード使用後、手札枚数が[Arg1]枚以下の場合、カードを[Arg2]枚引き、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:マジックグローブ>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "「怖がらないで、ただの手品だよ」"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_70738_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:恩恵の血>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "それは甘く芳醇で、バラの香りがする。"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点のシールドと[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70739_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点のシールドと[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:蝶の標本>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "今でも、彼は誰かに深く愛されている。"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が与える基礎ダメージが[Arg1]%増加し、[Arg2]シルバーキーエネルギーを獲得。"
  },
  RelicConfig_70740_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体が与える基礎ダメージが[Arg1]%増加し、[Arg2]シルバーキーエネルギーを獲得。"
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:秘典の星象儀+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "宇宙の神秘。"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "最大行動力が[Arg1]点増加する。"
  },
  RelicConfig_70741_Desc = {
    Text = "最大行動力が[Arg1]点増加する。"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "痙攣も活性の一種だ。"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "戦闘開始時、触腕上限+[Arg1]、触腕を[Arg2]本獲得する。"
  },
  RelicConfig_70742_Desc = {
    Text = "戦闘開始時、触腕上限+[Arg1]、触腕を[Arg2]本獲得する。"
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:海の歌>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "織紋螺などの食べられない動物が海洋の約80%の栄養を吸収していると言われています。"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70743_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:金色の夢>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "変身の日はお前の死期だ。"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "非派生指令カードを使用した後、行動力消費が2減少した一時的なコピー[Arg1]枚を山札のランダムな位置に追加する。クールダウン3ターン。"
  },
  RelicConfig_70744_Desc = {
    Text = "非派生指令カードを使用した後、行動力消費が2減少した一時的なコピー[Arg1]枚を山札のランダムな位置に追加する。クールダウン3ターン。"
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:声を失った蓄音機+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "彼の声は風の中に消えた。"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70745_Desc = {
    Text = "戦闘開始時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:イラクサのベスト+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "付着した液体を識別できません。"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70746_Desc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:無上の栄誉+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "優雅で神秘的な黒猫、遠い砂漠の国で神の化身とされていたという。しかし、その神の名は今や誰も知らない。\n崇拝され、敬われ、忘れられる、それが神の宿命かもしれない。"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "カード使用後、手札枚数が[Arg1]枚以下の場合、カードを[Arg2]枚引き、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_70747_Desc = {
    Text = "カード使用後、手札枚数が[Arg1]枚以下の場合、カードを[Arg2]枚引き、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:マジックグローブ+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "「怖がらないで、ただの手品だよ」"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点のシールドと[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70748_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点のシールドと[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:蝶の標本+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "今でも、彼は誰かに深く愛されている。"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "カードが1枚超次元空間に入るたび、そのカードが超次元空間の他のカードと帰属者が異なる場合、<DerivativeCardKeywords_4:「啓示」>を[Arg1]枚手札に追加する。"
  },
  RelicConfig_70749_Desc = {
    Text = "カードが1枚超次元空間に入るたび、そのカードが超次元空間の他のカードと帰属者が異なる場合、<DerivativeCardKeywords_4:「啓示」>を[Arg1]枚手札に追加する。"
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:アルフォンソの器+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "運命の無常とは異なり、星々には独自の法則がある。"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "前のカードより行動力消費が高いカードを2回連続で使用した時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70750_Desc = {
    Text = "前のカードより行動力消費が高いカードを2回連続で使用した時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:アルカナ記録>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "運命の動向。"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の行動力と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70751_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の行動力と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:ミサゴの校章>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "ミサゴ大学が調査員に配布する校章。それは身分証明だけでなく、遠隔通信も可能なツールだ。"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<RetaliateIconKeywords:反撃>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70752_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の<RetaliateIconKeywords:反撃>と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:賢者の断章>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "「人類はなんて愚かなんだ、古臭いものを盲信する」"
  },
  RelicConfig_70753_BattleDesc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<VulnerabilityIconKeywords:軟化>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70753_Desc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<VulnerabilityIconKeywords:軟化>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:春の祭り+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "夜の笑い声の中、カヌーの影が湖面を滑っていた。"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン内のアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_70754_Desc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン内のアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:血染めの小石>"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大15回まで発動する。"
  },
  RelicConfig_70755_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大15回まで発動する。"
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:縞瑪瑙+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "ただの瑪瑙の模様だと思う。たぶん。"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "シルバーキー覚醒後、[Arg1]点の行動力と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70756_Desc = {
    Text = "シルバーキー覚醒後、[Arg1]点の行動力と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:ミサゴの校章+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "ミサゴ大学が調査員に配布する校章。それは身分証明だけでなく、遠隔通信も可能なツールだ。"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "怒涛モードを使用すると、直ちにすべての触腕を触発して敵に[Arg1]回攻撃させる。クールダウン3ターン。"
  },
  RelicConfig_70757_Desc = {
    Text = "怒涛モードを使用すると、直ちにすべての触腕を触発して敵に[Arg1]回攻撃させる。クールダウン3ターン。"
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:ルルイエの歓喜>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "長眠の主よ、汝を夢に待つ。"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "前のカードより行動力消費が低いカードを2回連続で使用した時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70758_Desc = {
    Text = "前のカードより行動力消費が低いカードを2回連続で使用した時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:アルカナ遺物>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "運命の終焉。"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<WeaknessIconKeywords:倦怠>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70759_Desc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<WeaknessIconKeywords:倦怠>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:悪童>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "純粋な悪から生まれたもの。それが彼の望みでは、なかったとしても。"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70760_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:神経毒>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "抽出、精錬。"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<VulnerabilityIconKeywords:軟化>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70761_Desc = {
    Text = "戦闘開始後、すべての敵に[Arg1]層の<VulnerabilityIconKeywords:軟化>を付与し、ボス戦では効果が2倍になる。すべての覚醒体が与える基礎ダメージが[Arg2]%増加。"
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:春の祭り>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "夜の笑い声の中、カヌーの影が湖面を滑っていた。"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "1ターンに「狂気解放」を4回発動した後、[Arg1]点の行動力を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70762_Desc = {
    Text = "1ターンに「狂気解放」を4回発動した後、[Arg1]点の行動力を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:銀白の演算器+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "「それは歴史を変えた」"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "「狂気解放」を発動した後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70763_Desc = {
    Text = "「狂気解放」を発動した後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:重鎖>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "厚くて頑丈な鍵、キーがなければ開けるのは難しそうだ。\nもちろん、ある神盗みには大したことではない。"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "敵の攻撃を受けた時、その敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、このダメージは[Arg2]%の<RetaliateIconKeywords:カウンター>ボーナスの恩恵を受け、各敵につき毎ターン最大1回まで発動する。"
  },
  RelicConfig_70764_Desc = {
    Text = "敵の攻撃を受けた時、その敵に味方の最大ライフ値の[Arg3]%に等しい<FixedDamage:純粋ダメージ>を与え、このダメージは[Arg2]%の<RetaliateIconKeywords:カウンター>ボーナスの恩恵を受け、各敵につき毎ターン最大1回まで発動する。"
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:遺失の祭祀刀>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "刃が曲がった短剣。祭祀儀式に使われることが多い。"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大15回まで発動する。"
  },
  RelicConfig_70765_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大15回まで発動する。"
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:縞瑪瑙>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "ただの瑪瑙の模様だと思う。たぶん。"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_70766_Desc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:守護の手>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "祈福の手、堅い拳。"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "黒渦消滅は最も狂気が低い覚醒体に[Arg1]狂気を獲得させ、クールダウン3ターン。"
  },
  RelicConfig_70767_Desc = {
    Text = "黒渦消滅は最も狂気が低い覚醒体に[Arg1]狂気を獲得させ、クールダウン3ターン。"
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:時間の虫>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "時計店と昆虫博物館に同時に存在する懐中時計。\n洪積元年以降、大学のコレクションに加えられた。"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<RetaliateIconKeywords:反撃>と遺物が与える<RetaliateIconKeywords:反撃>が[Arg2]%増加する。"
  },
  RelicConfig_70768_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<RetaliateIconKeywords:反撃>と遺物が与える<RetaliateIconKeywords:反撃>が[Arg2]%増加する。"
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:知識の泉+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "それは無数の秘密を伝えた、積極的に言われたものも、受動的に言われたものも。"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン内のアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_70769_Desc = {
    Text = "毎ターン初めて「胚胎」を直接使用した後、このターン内のアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:血染めの小石+>"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "ターン開始時にカードを[Arg1]枚引く。"
  },
  RelicConfig_70770_Desc = {
    Text = "ターン開始時にカードを[Arg1]枚引く。"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:方位磁針>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "指示するのは方向ではなく、磁場だ。"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "「攻撃」は追加で覚醒体の攻撃力の[Arg1]%のダメージを2回与え、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70771_Desc = {
    Text = "「攻撃」は追加で覚醒体の攻撃力の[Arg1]%のダメージを2回与え、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:錆びた柳葉刀+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "生体の切開には適していない。"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "シルバーキー覚醒後、カードを[Arg1]枚引き、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70772_Desc = {
    Text = "シルバーキー覚醒後、カードを[Arg1]枚引き、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:新品の財布>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "ミサゴ大学の校章が刻まれた革財布。\n中は今空っぽで、何も入っていない。"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "毎ターン最初の5回のダメージが[Arg1]%増加する。"
  },
  RelicConfig_70774_Desc = {
    Text = "毎ターン最初の5回のダメージが[Arg1]%増加する。"
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:視力矯正器>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "かつて誰かがそれを通して真実を見つけたことがある。"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70776_Desc = {
    Text = "戦闘開始時、[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:イラクサのベスト>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "付着した液体を識別できません。"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "1ターン内に異なる覚醒体の指令カードを4枚使用した後、すべての覚醒体が[Arg1]狂気を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70777_Desc = {
    Text = "1ターン内に異なる覚醒体の指令カードを4枚使用した後、すべての覚醒体が[Arg1]狂気を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:無名の神のヴェール>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "神を直視してはならない。"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70778_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、ボス戦では効果が2倍になる。"
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:神経毒+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "抽出、精錬。"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70779_Desc = {
    Text = "シルバーキー覚醒後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:怪しい軟膏>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "自作の外傷用軟膏、医者の指導なしに使用しないでください。"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "「攻撃」はダメージの[Arg1]%の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大[Arg2]点まで付与する。"
  },
  RelicConfig_70780_Desc = {
    Text = "「攻撃」はダメージの[Arg1]%の<IntoxicationIconKeywords:毒>を付与し、毎ターン最大[Arg2]点まで付与する。"
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:異種の舌>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "彼は悪魔ではないが、確かに異界の囁きを伝える。"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_70781_Desc = {
    Text = "ターン開始時、ライフが25%未満の場合、[Arg1]点のシールドを獲得する。"
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:守護の手+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "祈福の手、堅い拳。"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "ライフを失った時、ライフ損失量の[Arg1]%の深紅の炉を獲得する。"
  },
  RelicConfig_70782_Desc = {
    Text = "ライフを失った時、ライフ損失量の[Arg1]%の深紅の炉を獲得する。"
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:錆びた鋸+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "解剖医の目に映るのは、美しい女性ではなく——骨、病の神経、炎症を起こした筋肉と組織だけ。"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "毎ターン最初の5回のダメージが[Arg1]%増加する。"
  },
  RelicConfig_70783_Desc = {
    Text = "毎ターン最初の5回のダメージが[Arg1]%増加する。"
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:視力矯正器+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "かつて誰かがそれを通して真実を見つけたことがある。"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "カードが1枚超次元空間に入るたび、そのカードが超次元空間の他のカードと帰属者が異なる場合、<DerivativeCardKeywords_4:「啓示」>を[Arg1]枚手札に追加する。"
  },
  RelicConfig_70784_Desc = {
    Text = "カードが1枚超次元空間に入るたび、そのカードが超次元空間の他のカードと帰属者が異なる場合、<DerivativeCardKeywords_4:「啓示」>を[Arg1]枚手札に追加する。"
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:アルフォンソの器>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "運命の無常とは異なり、星々には独自の法則がある。"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "1ターン内に異なる覚醒体の指令カードを4枚使用した後、すべての覚醒体が[Arg1]狂気を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70785_Desc = {
    Text = "1ターン内に異なる覚醒体の指令カードを4枚使用した後、すべての覚醒体が[Arg1]狂気を獲得し、クールダウン3ターン。"
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:無名の神のヴェール+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "神を直視してはならない。"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "ターン終了時、潮流モード状態の場合、<TentacleInjurieIconKeywords:触腕ダメージ>を[Arg1]点獲得し、クールダウン3ターン。"
  },
  RelicConfig_70786_Desc = {
    Text = "ターン終了時、潮流モード状態の場合、<TentacleInjurieIconKeywords:触腕ダメージ>を[Arg1]点獲得し、クールダウン3ターン。"
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:裂頭条虫>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "私たちの脳が謎である限り、中に触腕が生えていても驚くことはない。"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加。"
  },
  RelicConfig_70787_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加。"
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:号泣パイプ+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "これは憎しみの産物か、それとも復讐の結果か？"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "シルバーキー覚醒後、すべての覚醒体は[Arg1]狂気と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70788_Desc = {
    Text = "シルバーキー覚醒後、すべての覚醒体は[Arg1]狂気と[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:月桂樹のカフリンクス>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "月桂樹の模様が刻まれた銀のカフスボタン。\n精巧な作りで、輝いており、かつて二人の子供の友情を支えていた。"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<IntoxicationIconKeywords:毒>と遺物が与える<IntoxicationIconKeywords:毒>が[Arg2]%増加する。"
  },
  RelicConfig_70789_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。すべての覚醒体が与える<IntoxicationIconKeywords:毒>と遺物が与える<IntoxicationIconKeywords:毒>が[Arg2]%増加する。"
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:埃をかぶったミシン>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "慈愛に満ちた母親が心の傷を縫い合わせる。"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "黒渦消滅は最も狂気が低い覚醒体に[Arg1]狂気を獲得させ、クールダウン3ターン。"
  },
  RelicConfig_70790_Desc = {
    Text = "黒渦消滅は最も狂気が低い覚醒体に[Arg1]狂気を獲得させ、クールダウン3ターン。"
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:時間の虫+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "時計店と昆虫博物館に同時に存在する懐中時計。\n洪積元年以降、大学のコレクションに加えられた。"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "戦闘開始時、触腕上限+[Arg1]、触腕を[Arg2]本獲得する。"
  },
  RelicConfig_70791_Desc = {
    Text = "戦闘開始時、触腕上限+[Arg1]、触腕を[Arg2]本獲得する。"
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:海の歌+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "織紋螺などの食べられない動物が海洋の約80%の栄養を吸収していると言われています。"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "ターン終了時、潮流モード状態の場合、<TentacleInjurieIconKeywords:触腕ダメージ>を[Arg1]点獲得し、クールダウン3ターン。"
  },
  RelicConfig_70792_Desc = {
    Text = "ターン終了時、潮流モード状態の場合、<TentacleInjurieIconKeywords:触腕ダメージ>を[Arg1]点獲得し、クールダウン3ターン。"
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:裂頭条虫+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "私たちの脳が謎である限り、中に触腕が生えていても驚くことはない。"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70793_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:金色の夢+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "変身の日はお前の死期だ。"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "黒渦消滅は[Arg1]点のシールドを獲得し、クールダウン3ターン。"
  },
  RelicConfig_70794_Desc = {
    Text = "黒渦消滅は[Arg1]点のシールドを獲得し、クールダウン3ターン。"
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:超弦懐中時計+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "「あら、懐中時計が止まった」"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "非派生指令カードを使用した後、行動力消費が2減少した一時的なコピー[Arg1]枚を山札のランダムな位置に追加する。クールダウン3ターン。"
  },
  RelicConfig_70795_Desc = {
    Text = "非派生指令カードを使用した後、行動力消費が2減少した一時的なコピー[Arg1]枚を山札のランダムな位置に追加する。クールダウン3ターン。"
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:声を失った蓄音機>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "彼の声は風の中に消えた。"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "「狂気解放」を使用した後、全ての敵に[Arg1]点の<FixedDamage:純粋ダメージ>を与え、[Arg2]%の<IntoxicationIconKeywords:毒>を発動する。"
  },
  RelicConfig_70796_Desc = {
    Text = "「狂気解放」を使用した後、全ての敵に味方の最大ライフ値の[Arg2]%に等しい<FixedDamage:純粋ダメージ>を1回与え、[Arg2]%の<IntoxicationIconKeywords:毒>を発動する。"
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:光を放つ顎骨+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "あるコレクターのプライベート展示室に陳列された遺骨。\nコレクターはその美しい蛍光に心を奪われ、日夜鑑賞し、最終的に枯れ果て、同類となった。"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "最大行動力が[Arg1]点増加する。"
  },
  RelicConfig_70797_Desc = {
    Text = "最大行動力が[Arg1]点増加する。"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "痙攣も活性の一種だ。"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "怒涛モードを使用すると、直ちにすべての触腕を触発して敵に[Arg1]回攻撃させる。クールダウン3ターン。"
  },
  RelicConfig_70798_Desc = {
    Text = "怒涛モードを使用すると、直ちにすべての触腕を触発して敵に[Arg1]回攻撃させる。クールダウン3ターン。"
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:ルルイエの歓喜+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "長眠の主よ、汝を夢に待つ。"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "「防御」は[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70799_Desc = {
    Text = "「防御」は[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:古い友の懐中時計+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "懐かしさと悲しみを抱え、未知へと進む。"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "「防御」は[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70800_Desc = {
    Text = "「防御」は[Arg1]点の一時的な<RetaliateIconKeywords:反撃>を獲得し、毎ターン最大3回まで発動する。"
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:古い友の懐中時計>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "懐かしさと悲しみを抱え、未知へと進む。"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、2つの遺物から1つを選んで獲得し、この効果は5回の奇数ターン持続する。"
  },
  RelicConfig_70986_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、2つの遺物から1つを選んで獲得し、この効果は5回の奇数ターン持続する。"
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:時の振り子「祈りη」>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、2つの遺物から1つを選んで獲得し、この効果は5回の奇数ターン持続する。"
  },
  RelicConfig_70987_Desc = {
    Text = "戦闘開始時、行動力上限+1、すべての覚醒体を覚醒させる。奇数ターン開始時、2つの遺物から1つを選んで獲得し、この効果は5回の奇数ターン持続する。"
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:時の振り子「祈りζ」>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "ターン開始時、環行・ラモンナは[Arg1]狂気を獲得する。毎ターン初めて「ループ」が発動するたび、[Arg2]キーエネルギーと[Arg3]点の「ネゲントロピー」を獲得する。"
  },
  RelicConfig_71195_Desc = {
    Text = "ターン開始時、環行・ラモンナは[Arg1]狂気を獲得する。毎ターン初めて「ループ」が発動するたび、[Arg2]キーエネルギーと[Arg3]点の「ネゲントロピー」を獲得する。"
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:次元影像・環行・ラモンナ>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "ターン開始時、ロータンは[Arg1]狂気を獲得する。毎ターン初めてロータンの「防御」を使用した後、「虚無」と「除外」が付与された「傲慢の刃」を[Arg2]枚手札に追加する。"
  },
  RelicConfig_71196_Desc = {
    Text = "ターン開始時、ロータンは[Arg1]狂気を獲得する。毎ターン初めてロータンの「防御」を使用した後、「虚無」と「除外」が付与された「傲慢の刃」を[Arg2]枚手札に追加する。"
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:次元影像・ロータン>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "ターン開始時、ラモンナは[Arg1]狂気を獲得する。[Arg2]枚目のラモンナの指令カードを使用するたび、その指令カードは追加で1回発動し、[Arg3]キーエネルギーを獲得する。"
  },
  RelicConfig_71197_Desc = {
    Text = "ターン開始時、ラモンナは[Arg1]狂気を獲得する。[Arg2]枚目のラモンナの指令カードを使用するたび、その指令カードは追加で1回発動し、[Arg3]キーエネルギーを獲得する。"
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:次元影像・ラモンナ>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "ターン開始時にレーアは [Arg1] 狂気を獲得する。ライフを失う度に [Arg2] 点の力を獲得し、1戦闘につき最大 [Arg3] 回まで重複する。[Arg3] 回重複後、「苦痛と歓喜」の基礎行動力消費が2低下し、ダメージ回数が1増加する。"
  },
  RelicConfig_71230_Desc = {
    Text = "ターン開始時にレーアは [Arg1] 狂気を獲得する。ライフを失う度に [Arg2] 点の力を獲得し、1戦闘につき最大 [Arg3] 回まで重複する。[Arg3] 回重複後、「苦痛と歓喜」の基礎行動力消費が2低下し、ダメージ回数が1増加する。"
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:次元影像・レーア>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "ターン開始時、オレッタは[Arg1]狂気を獲得する。「腺体分裂」のダメージ回数を[Arg2]回増加させる、オレッタの「防御」を使用した後に、「腺体分裂」を1枚手札に追加する。"
  },
  RelicConfig_71231_Desc = {
    Text = "ターン開始時、オレッタは[Arg1]狂気を獲得する。「腺体分裂」のダメージ回数を[Arg2]回増加させる、オレッタの「防御」を使用した後に、「腺体分裂」を1枚手札に追加する。"
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:次元影像・オレッタ>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "ターン開始時、ティンクトは[Arg1]狂気を獲得する。ティンクトの指令カードが跳躍を発動した後、それを手札に戻し、行動力消費を1点減少させる、毎ターン最大[Arg2]回まで発動する。"
  },
  RelicConfig_71232_Desc = {
    Text = "ターン開始時、ティンクトは[Arg1]狂気を獲得する。ティンクトの指令カードが跳躍を発動した後、それを手札に戻し、行動力消費を1点減少させる、毎ターン最大[Arg2]回まで発動する。"
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:次元影像・ティンクト>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "ターン開始時、ナウティラは[Arg1]狂気を獲得する。ナウティラの「狂気解放」後、現在のシールドの[Arg2]%に等しい<RetaliateIconKeywords:反撃>と遅延シールドを獲得する。毎ターン最大1回まで発動する。"
  },
  RelicConfig_71233_Desc = {
    Text = "ターン開始時、ナウティラは[Arg1]狂気を獲得する。ナウティラが「狂気解放」を発動した後、現在のシールドの[Arg2]%に等しい反撃と遅延シールドを獲得する。毎ターン最大1回まで発動する。"
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:次元影像・ナウティラ>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "ターン開始時、溶壊・ドールは[Arg1]狂気を獲得する。溶融・ドールが狂気解放後、[Arg2]狂気を消費するたびに他の覚醒体は1狂気を獲得する。"
  },
  RelicConfig_71234_Desc = {
    Text = "ターン開始時、熔解・ドールは[Arg1]狂気を獲得する。熔解・ドールが「狂気解放」を発動した後、消費した狂気[Arg2]点ごとに、他の覚醒体は1狂気を獲得する。"
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:次元影像・溶壊・ドール>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "ターン開始時、ヘロットは[Arg1]狂気を獲得する。カードが1枚捨てられるたびに、ヘロットは[Arg2]狂気を獲得する。"
  },
  RelicConfig_71235_Desc = {
    Text = "ターン開始時、ヘロットは[Arg1]狂気を獲得する。カードが1枚捨てられるたびに、ヘロットは[Arg2]狂気を獲得する。"
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:次元影像・ヘロット>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "ターン開始時、ダフォダイルは[Arg1]狂気と1枚の「霊感」を獲得する。「異質の潮汐」で獲得する力を[Arg2]%増加させる。使用するたびにこの探索中に永久的に[Arg3]%増加し、最大[Arg4]%まで増加する。"
  },
  RelicConfig_71236_Desc = {
    Text = "ターン開始時、ダフォダイルは[Arg1]狂気と1枚の「霊感」を獲得する。「異質の潮汐」で獲得する力を[Arg2]%増加させる。使用するたびにこの探索中に永久的に[Arg3]%増加し、最大[Arg4]%まで増加する。"
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:次元影像・ダフォダイル>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "ターン開始時、ワンダは[Arg1]狂気を獲得し、[Arg2]層の「夢引き」を獲得する。現在が超次元ターンの場合、追加で一時的な「脊椎針の鎖」と「迷い人の守護」をそれぞれ1枚手札に追加し、ワンダの次の指令カードを2回発動させる。"
  },
  RelicConfig_71237_Desc = {
    Text = "ターン開始時、ワンダは[Arg1]狂気を獲得し、[Arg2]層の「夢引き」を獲得する。現在が超次元ターンの場合、追加で一時的な「脊椎針の鎖」と「迷い人の守護」をそれぞれ1枚手札に追加し、ワンダの次の指令カードを2回発動させる。"
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:次元影像・ワンダ>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "ターン開始時、アグリッパは[Arg1]狂気を獲得する。「耐え難い施し」は、アグリッパがこのターン中に行動力消費を[Arg2]点減少させる効果も持つ、毎ターン最大1回まで発動する。"
  },
  RelicConfig_71238_Desc = {
    Text = "ターン開始時、アグリッパは[Arg1]狂気を獲得する。「耐え難い施し」は、アグリッパがこのターン中に行動力消費を[Arg2]点減少させる効果も持つ、毎ターン最大1回まで発動する。"
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:次元影像・アグリッパ>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "ターン開始時、「24」は[Arg1]狂気を獲得する。ターン開始時、「24」が「抑鬱人格」の状態である場合、追加で[Arg2]狂気を獲得する。「躁狂人格」の状態である場合、「24」の一時的なクリティカル率と一時的なクリティカルダメージを[Arg2]%増加させる。"
  },
  RelicConfig_71239_Desc = {
    Text = "ターン開始時、「24」は[Arg1]狂気を獲得する。ターン開始時、「24」が「抑鬱人格」の状態である場合、追加で[Arg2]狂気を獲得する。「躁狂人格」の状態である場合、「24」の一時的なクリティカル率と一時的なクリティカルダメージを[Arg2]%増加させる。"
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:次元影像・「24」>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "ターン開始時、リッツは[Arg1]狂気を獲得する。「死告の舞い」で捨てられたカードは追加で1回発動する、3ターンのクールダウン。"
  },
  RelicConfig_71240_Desc = {
    Text = "ターン開始時、リッツは[Arg1]狂気を獲得する。「死告の舞い」で捨てられたカードは追加で1回発動する、3ターンのクールダウン。"
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:次元影像・リッツ>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "ターン開始時、血ノ鎖・ヘロットは[Arg1]狂気を獲得。血ノ鎖・ヘロットのアクティブダメージに[Arg2]%の出血を追加し、敵を倒すと、他の敵に過剰ダメージに等しい<BleedingIconKeywords:出血>を付与。"
  },
  RelicConfig_71241_Desc = {
    Text = "ターン開始時、血鎖・ヘロットは[Arg1]狂気を獲得する。血鎖・ヘロットのアクティブダメージは[Arg2]%の出血を付与し、敵を撃破した場合、他のすべての敵に過剰ダメージと同量の出血を付与する。"
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:次元影像・血ノ鎖・ヘロット>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "ターン開始時、シレストは[Arg1]狂気を獲得する。ターン終了前、手札にシレストの指令カードが1枚あるごとに、触腕1本に敵を攻撃させ、ライフを[Heal:Arg2]回復する。"
  },
  RelicConfig_71242_Desc = {
    Text = "ターン開始時、シレストは[Arg1]狂気を獲得する。ターン終了前、手札にシレストの指令カードが1枚あるごとに、触腕1本に敵を攻撃させ、ライフを[Heal:Arg2]回復する。"
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:次元影像・シレスト>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたびに、カーシアは[Arg2]狂気を獲得する。カーシアが狂気解放する際、すべての敵は[Arg3]点の力を失う。"
  },
  RelicConfig_71243_Desc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたびに、カーシアは[Arg2]狂気を獲得する。カーシアが狂気解放する際、すべての敵は[Arg3]点の力を失う。"
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:次元影像・カーシア>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "ターン開始時、ソレールは[Arg1]狂気を獲得する。ソレールがダメージを与えるたび、胚胎融合+[Arg2]、毎ターン最大[Arg3]回まで発動する。この効果が10回発動した後、この戦闘におけるソレールの最終ダメージ+[Arg4]%。"
  },
  RelicConfig_71244_Desc = {
    Text = "ターン開始時、ソレールは[Arg1]狂気を獲得する。ソレールがダメージを与えるたび、胚胎融合+[Arg2]、毎ターン最大[Arg3]回まで発動する。この効果が10回発動した後、この戦闘におけるソレールの最終ダメージ+[Arg4]%。"
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:次元影像・ソレール>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "ターン開始時、オジールは[Arg1]狂気を獲得する。毎ターン初めてオジールの「刺突の槍」または「打撃」を使用した後に、オジールがこのターン中に与えるシールドと力を[Arg2]%増加させる。"
  },
  RelicConfig_71245_Desc = {
    Text = "ターン開始時、オジールは[Arg1]狂気を獲得する。毎ターン初めてオジールの「刺突の槍」または「打撃」を使用した後に、オジールがこのターン中に与えるシールドと力を[Arg2]%増加させる。"
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:次元影像・オジール>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "ターン開始時、アルバは[Arg1]狂気を獲得する。アルバが1ターン内に[Arg2]枚目の「防御」を使用した際、除外の「心眼の刃」を1枚手札に追加する。[Arg3]枚目の「攻撃」を使用した際、除外の「戦闘体勢」を1枚手札に追加する。"
  },
  RelicConfig_71246_Desc = {
    Text = "ターン開始時、アルバは[Arg1]狂気を獲得する。アルバが1ターン内に[Arg2]枚目の「防御」を使用した際、除外の「心眼の刃」を1枚手札に追加する。[Arg3]枚目の「攻撃」を使用した際、除外の「戦闘体勢」を1枚手札に追加する。"
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:次元影像・アルバ>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "ターン開始時、ジェンキンは[Arg1]狂気を獲得し、最終ダメージが[Arg2]%増加する。「ブラウン出撃！」の基礎ダメージと与えるダメージ成長を[Arg3]%増加させる。"
  },
  RelicConfig_71247_Desc = {
    Text = "ターン開始時、ジェンキンは[Arg1]狂気を獲得し、最終ダメージが[Arg2]%増加する。「ブラウン出撃！」の基礎ダメージと与えるダメージ成長を[Arg3]%増加させる。"
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:次元影像・ジェンキン>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "ターン開始時、ドールは[Arg1]狂気を獲得する。戦闘開始後、ドールの「等価交換」の行動力消費を0にする。使用後、次のターンに追加で[Arg2]枚カードを引く。"
  },
  RelicConfig_71248_Desc = {
    Text = "ターン開始時、ドールは[Arg1]狂気を獲得する。戦闘開始後、ドールの「等価交換」の行動力消費を0にする。使用後、次のターンに追加で[Arg2]枚カードを引く。"
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:次元影像・ドール>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "ターン開始時、ライカーは[Arg1]狂気を獲得する。毎ターン最初のダイスは必ず最大値が出る。"
  },
  RelicConfig_71249_Desc = {
    Text = "ターン開始時、ライカーは[Arg1]狂気を獲得する。毎ターン最初のダイスは必ず最大値が出る。"
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:次元影像・ライカー>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "ターン開始時、ミリアムは[Arg1]狂気を獲得し、「聖礼」を1枚手札に追加する。"
  },
  RelicConfig_71250_Desc = {
    Text = "ターン開始時、ミリアムは[Arg1]狂気を獲得し、「聖礼」を1枚手札に追加する。"
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:次元影像・ミリアム>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "ターン開始時、ウインクルは[Arg1]狂気を獲得する。他の覚醒体が狂気解放するたびに、ウインクルは[Arg2]狂気を獲得し、手札にある「精神再建」の行動力消費を[Arg3]点減少させる。"
  },
  RelicConfig_71251_Desc = {
    Text = "ターン開始時、ウインクルは[Arg1]狂気を獲得する。他の覚醒体が狂気解放するたびに、ウインクルは[Arg2]狂気を獲得し、手札にある「精神再建」の行動力消費を[Arg3]点減少させる。"
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:次元影像・ウインクル>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "ターン開始時、トゥルーは[Arg1]狂気を獲得する。トゥルーの基礎狂気が[Arg2]点減少し、「狂気解放」を発動後、即座に[Arg3]本の一時的な触腕を生成する。"
  },
  RelicConfig_71252_Desc = {
    Text = "ターン開始時、トゥルーは[Arg1]狂気を獲得する。トゥルーの基礎狂気が[Arg2]点減少し、「狂気解放」を発動後、即座に[Arg3]本の一時的な触腕を生成する。"
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:次元影像・トゥルー>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "ターン開始時、ファイントは[Arg1]狂気を獲得する。ファイントが与えるシールド、<RetaliateIconKeywords:反撃>、ライフ回復を[Arg2]%増加させる。死亡抵抗が発動するたびに、この効果をこの探索中に[Arg3]%増加させる、最大[Arg4]回まで発動する。"
  },
  RelicConfig_71253_Desc = {
    Text = "ターン開始時、ファイントは[Arg1]狂気を獲得する。ファイントが与えるシールド、<RetaliateIconKeywords:反撃>、ライフ回復を[Arg2]%増加させる。死亡抵抗が発動するたびに、この効果をこの探索中に[Arg3]%増加させる、最大[Arg4]回まで発動する。"
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:次元影像・ファイント>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "ターン開始時、タヴィは[Arg1]狂気を獲得する。1ターン内にタヴィの指令カードを[Arg2]枚使用した場合、<DerivativeCardKeywords_67:「シルバーキーの暁光」>を1枚手札に追加し、クールダウン[Arg3]ターン。"
  },
  RelicConfig_71254_Desc = {
    Text = "ターン開始時、タヴィは[Arg1]狂気を獲得する。1ターン内にタヴィの指令カードを[Arg2]枚使用した場合、<DerivativeCardKeywords_67:「シルバーキーの暁光」>を1枚手札に追加し、クールダウン[Arg3]ターン。"
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:次元影像・タヴィ>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "ターン開始時にハムリンは [Arg1] 狂気を獲得する。「ソウルプレリュード」の基礎行動力消費が [Arg2] 低下し、基礎ダメージ回数が [Arg3] 増加する。"
  },
  RelicConfig_71255_Desc = {
    Text = "ターン開始時にハムリンは [Arg1] 狂気を獲得する。「ソウルプレリュード」の基礎行動力消費が [Arg2] 低下し、基礎ダメージ回数が [Arg3] 増加する。"
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:次元影像・ハムリン>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "ターン開始時、オルラは[Arg1]狂気を獲得する。戦闘開始時、すべての感情の隠喩をそれぞれ[Arg2]点獲得する。「隠喩」効果は50%増加する。"
  },
  RelicConfig_71256_Desc = {
    Text = "ターン開始時、オルラは[Arg1]狂気を獲得する。戦闘開始時、すべての感情の隠喩をそれぞれ[Arg2]点獲得する。「隠喩」効果は50%増加する。"
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:次元影像・オルラ>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "ターン開始時、マーフィーは[Arg1]狂気を獲得する。マーフィーの「攻撃」と「防御」は、[Arg2]%の「献上」を一時的な触腕ダメージに変換できるが、毎ターン最大1回まで発動する。"
  },
  RelicConfig_71257_Desc = {
    Text = "ターン開始時、マーフィーは[Arg1]狂気を獲得する。マーフィーの「攻撃」と「防御」は、[Arg2]%の「献上」を一時的な触腕ダメージに変換できるが、毎ターン最大1回まで発動する。"
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:次元影像・マーフィー>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "ターン開始時、ユウハシュは[Arg1]狂気を獲得する。ユウハシュの基礎狂気消費を[Arg2]点減少させ、狂気爆発を発動するたびに追加で5点減少し、毎ターン[Arg3]回狂気爆発を発動できる。"
  },
  RelicConfig_71258_Desc = {
    Text = "ターン開始時、ユウハシュは[Arg1]狂気を獲得する。ユウハシュの基礎狂気消費を[Arg2]点減少させ、狂気爆発を発動するたびに追加で5点減少し、毎ターン[Arg3]回狂気爆発を発動できる。"
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:次元影像・ユウハシュ>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "ターン開始時、アイギスは[Arg1]狂気を獲得する。アイギスが軟化状態の敵にダメージを与えた際、その敵から[Arg2]点の力を一時的に奪う、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_71259_Desc = {
    Text = "ターン開始時、アイギスは[Arg1]狂気を獲得する。アイギスが軟化状態の敵にダメージを与えた際、その敵から[Arg2]点の力を一時的に奪う、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:次元影像・アイギス>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "ターン開始時、タイスは[Arg1]狂気を獲得する。タイスが1ターン内に[Arg2]枚の指令カードを使用した後、<DerivativeCardKeywords_10:聖純の子>を1枚と[Arg3]点の一時的な力を獲得する、[Arg4]ターンのクールダウン。"
  },
  RelicConfig_71260_Desc = {
    Text = "ターン開始時、タイスは[Arg1]狂気を獲得する。タイスが1ターン内に[Arg2]枚の指令カードを使用した後、<DerivativeCardKeywords_10:聖純の子>を1枚と[Arg3]点の一時的な力を獲得する、[Arg4]ターンのクールダウン。"
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:次元影像・タイス>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "ターン開始時、ファロスは[Arg1]狂気を獲得する。触腕ダメージを2回与えるたび、ファロスがこの戦闘で与える毒とシールドを[Arg2]%増加させる。最大50%まで。"
  },
  RelicConfig_71261_Desc = {
    Text = "ターン開始時、ファロスは[Arg1]狂気を獲得する。触腕ダメージを2回与えるたび、ファロスがこの戦闘で与える毒とシールドを[Arg2]%増加させる。最大50%まで。"
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:次元影像・ファロス>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "ターン開始時、パンディアは[Arg1]狂気を獲得する。パンディアが狂気解放後、[Arg2]%の一時的な反撃に等しい永続反撃を獲得する。"
  },
  RelicConfig_71262_Desc = {
    Text = "ターン開始時、パンディアは[Arg1]狂気を獲得する。パンディアが狂気解放後、[Arg2]%の一時的な反撃に等しい永続反撃を獲得する。"
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:次元影像・パンディア>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "ターン開始時、リリーは[Arg1]狂気を獲得する。リリーの「忍耐」の上限が100%増加し、「泥に咲く不滅の花」または「返しの一撃」を使用した時、「忍耐」の層数の8%のライフを回復する。"
  },
  RelicConfig_71263_Desc = {
    Text = "ターン開始時、リリーは[Arg1]狂気を獲得する。リリーの「忍耐」の上限が100%増加し、「泥に咲く不滅の花」または「返しの一撃」を使用した時、「忍耐」の層数の8%のライフを回復する。"
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:次元影像・リリー>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "ターン開始時、カレンは[Arg1]狂気を獲得する。「静観」を使用すると、消費した行動力の2倍を返還する、[Arg2]ターンのクールダウン。"
  },
  RelicConfig_71264_Desc = {
    Text = "ターン開始時、カレンは[Arg1]狂気を獲得する。「静観」を使用すると、消費した行動力の2倍を返還する、[Arg2]ターンのクールダウン。"
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:次元影像・カレン>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "ターン開始時、サルバドルは[Arg1]狂気を獲得する。深紅の炉を蓄積するたび、蓄積量の[Arg2]%分の「力」を獲得する。サルバドルの「攻撃」と「苦痛の解消」は追加で[Arg3]倍の力ボーナスを獲得する。"
  },
  RelicConfig_71265_Desc = {
    Text = "ターン開始時、サルバドルは[Arg1]狂気を獲得する。深紅の炉を蓄積するたび、蓄積量の[Arg2]%分の「力」を獲得する。サルバドルの「攻撃」と「苦痛の解消」は追加で[Arg3]倍の力ボーナスを獲得する。"
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:次元影像・サルバドル>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "ターン開始時、カエクスは[Arg1]狂気を獲得する。カエクスがシールドを獲得した際、シールド量[Arg2]%分のライフを回復する。"
  },
  RelicConfig_71266_Desc = {
    Text = "ターン開始時、カエクスは[Arg1]狂気を獲得する。カエクスがシールドを獲得した際、シールド量[Arg2]%分のライフを回復する。"
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:次元影像・カエクス>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "ターン開始時、ニムフィーアは[Arg1]狂気を獲得する。ニムフィーアの「攻撃」を使用後、ニムフィーアがこの戦闘で与える毒を[Arg2]%増加させ、ニムフィーアの「防御」を使用後、すべての敵の[Arg3]%の毒を発動させる。毎ターン、それぞれ最大1回まで発動する。"
  },
  RelicConfig_71267_Desc = {
    Text = "ターン開始時、ニムフィーアは[Arg1]狂気を獲得する。ニムフィーアの「攻撃」を使用後、ニムフィーアがこの戦闘で与える毒を[Arg2]%増加させ、ニムフィーアの「防御」を使用後、すべての敵の[Arg3]%の毒を発動させる。毎ターン、それぞれ最大1回まで発動する。"
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:次元影像・ニムフィーア>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "ターン開始時、エリカは[Arg1]狂気を獲得する。エリカが1ターン内に[Arg2]枚の指令カードを使用した後に、2点の行動力を獲得し、この戦闘で「電磁爆破」が獲得する力と警戒ボーナスを1倍増加させる。"
  },
  RelicConfig_71268_Desc = {
    Text = "ターン開始時、エリカは[Arg1]狂気を獲得する。エリカが1ターン内に[Arg2]枚の指令カードを使用した後に、2点の行動力を獲得し、この戦闘で「電磁爆破」が獲得する力と警戒ボーナスを1倍増加させる。"
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:次元影像・エリカ>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "ターン開始時、ゴリアテは[Arg1]狂気を獲得する。ゴリアテが1ターン内に[Arg2]回ダメージを与えた場合、ゴリアテが与えるダメージはこの戦闘中、追加で1倍の力のボーナスを獲得する、3ターンのクールダウン。"
  },
  RelicConfig_71269_Desc = {
    Text = "ターン開始時、ゴリアテは[Arg1]狂気を獲得する。ゴリアテが1ターン内に[Arg2]回ダメージを与えた場合、ゴリアテが与えるダメージはこの戦闘中、追加で1倍の力のボーナスを獲得する、3ターンのクールダウン。"
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:次元影像・ゴリアテ>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "ターン開始時、サンガーは[Arg1]狂気を獲得する。戦闘開始時、サンガーのすべての指令カードに保留、準備1、[Arg2]点のシールドを付与する。"
  },
  RelicConfig_71270_Desc = {
    Text = "ターン開始時、サンガーは[Arg1]狂気を獲得する。戦闘開始時、サンガーのすべての指令カードに保留、準備1、[Arg2]点のシールドを付与する。"
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:次元影像・サンガー>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "偶数ターン開始時、<DerivativeCardKeywords_105:「無限の宝物庫」>を1枚手札に追加する。"
  },
  RelicConfig_71662_Desc = {
    Text = "偶数ターン開始時、<DerivativeCardKeywords_105:「無限の宝物庫」>を1枚手札に追加する。"
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:猫の宝物>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "手札上限+1。ターン開始時、現在研究を行っていない場合、未実施の研究項目を1つ選択し、研究完了後、溶壊・ドールの対応する研究成果を獲得する。研究を3つ完了した時、「虚無終結」を手札に追加し、この遺物は無効になる。"
  },
  RelicConfig_72226_Desc = {
    Text = "手札上限+1。ターン開始時、現在研究を行っていない場合、未実施の研究項目を1つ選択し、研究完了後、溶壊・ドールの対応する研究成果を獲得する。研究を3つ完了した時、「虚無終結」を手札に追加し、この遺物は無効になる。"
  },
  RelicConfig_72226_Name = {
    Text = "終末の研究原稿"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "手札上限+1。ターン開始時にカスタマイズされた「禁忌の取引」を1枚獲得し、「禁忌の取引」を使用した後、次のターンに再度発動可能。「禁忌の取引」を所持している時に異なるタイプの「指令カード」を使用すると、その中の対応する効果がアップグレードされる。"
  },
  RelicConfig_74832_Desc = {
    Text = "手札上限+1。ターン開始時にカスタマイズされた「禁忌の取引」を1枚獲得し、「禁忌の取引」を使用した後、次のターンに再度発動可能。「禁忌の取引」を所持している時に異なるタイプの「指令カード」を使用すると、その中の対応する効果がアップグレードされる。"
  },
  RelicConfig_74832_Name = {
    Text = "千面の招待状"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "手紙に記された文字は絶えず変化し、やがて抗いがたい渇望へと姿を変える。"
  },
  RelicConfig_78664_BattleDesc = {
    Text = "1ターン内に異なる覚醒体に所属する指令カードを4枚使用した後、すべての覚醒体がこのターン与える最終ダメージを[Arg1]％増加させ、[Arg2]狂気を失う。この効果は毎ターン最大1回まで発動する。"
  },
  RelicConfig_78664_Desc = {
    Text = "1ターン内に異なる覚醒体に所属する指令カードを4枚使用した後、すべての覚醒体がこのターン与える最終ダメージを[Arg1]％増加させ、[Arg2]狂気を失う。この効果は毎ターン最大1回まで発動する。"
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:奇異な鉤爪>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "識別不能な種。"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "ターン開始時のドロー枚数が[Arg1]枚少なくなる。実際の行動力消費が[Arg2]以上のカードを1枚使用するたび1点の行動力を獲得し、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_78665_Desc = {
    Text = "ターン開始時、ドロー枚数が[Arg1]毎少なくなる。行動力消費が[Arg2]以上のカードを1枚使用するたびに1点の行動力を獲得し、毎ターン最大[Arg3]回まで発動する。"
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:哀鳴の鈴>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "チリン、チリン、子供が泣いている。\nチリン、チリン、子供が叫んでいる。\nチリン、チリン、子供が嘆いている。\nチリン、チリン、お腹が空いているのがわかるでしょう。"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "ターン開始時、[Arg1]点の反撃を獲得する。1ターン内に狂気解放を[Arg2]回発動した後、自身の永続反撃を[Arg3]%解除し、解除した量の[Arg4]%の一時的反撃を獲得し、クールダウン[Arg5]ターン。"
  },
  RelicConfig_78666_Desc = {
    Text = "ターン開始時、[Arg1]点の反撃を獲得する。1ターン内に狂気解放を[Arg2]回発動した後、自身の永続反撃を[Arg3]%解除し、解除した量の[Arg4]%の一時的反撃を獲得し、クールダウン[Arg5]ターン。"
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:行道の骸>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離しても、その足跡は四海に広がっている。"
  },
  RelicConfig_78667_BattleDesc = {
    Text = "ドローフェイズ後、追加でカードを[Arg1]枚引き、手札を[Arg2]枚選んで捨てる。"
  },
  RelicConfig_78667_Desc = {
    Text = "ドローフェイズ後、追加でカードを[Arg1]枚引き、手札を[Arg2]枚選んで捨てる。"
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:奇術のハット>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "ようこそ、カーシア嬢の幻想のサーカスへ！\nお気をつけて、マジック道具には触れないでくださいね。\n万が一噛まれたら、それは大変なことになります。\nなにしろ、最後に血の味を覚えたとき——その後の顛末は、恐ろしいものでしたから。\n\nシルクハットがまばたきをする。\nまるでいつでも羽化する準備ができているように。"
  },
  RelicConfig_78668_BattleDesc = {
    Text = "銀の鍵覚醒を使用した後、対応する覚醒体の [Arg1] 枚の非派生指令カードを選択して消費し、[Arg2] 枚の追加消費したオリジナルコピーをそれぞれドロー山、手札、捨て札に置く。"
  },
  RelicConfig_78668_Desc = {
    Text = "銀の鍵覚醒を使用した後、対応する覚醒体の [Arg1] 枚の非派生指令カードを選択して消費し、[Arg2] 枚の追加消費したオリジナルコピーをそれぞれドロー山、手札、捨て札に置く。"
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:翡翠の拓印>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "この拓印は千年不朽です。"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点の力を獲得する。ターン開始時、[Arg2]点の永続の力ごとに[Arg3]点の一時的な力を獲得し、最大[Arg4]点まで一時的な力を獲得し、ターン終了時、この遺物によって獲得した一時的な力の半分のシールドを失う。"
  },
  RelicConfig_78669_Desc = {
    Text = "戦闘開始時、[Arg1]点の力を獲得する。ターン開始時、[Arg2]点の永続の力ごとに[Arg3]点の一時的な力を獲得し、最大[Arg4]点まで一時的な力を獲得し、ターン終了時、この遺物によって獲得した一時的な力の半分のシールドを失う。"
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:不運の儀式鳥>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "干からびた死体が鳴き声を上げた。"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "すべての覚醒体の基礎ダメージが[Arg1]%増加し、山札をリセットするたび追加で[Arg2]%増加するが、「よろよろ」を1枚手札に追加し、増加値は最大[Arg3]%。"
  },
  RelicConfig_78670_Desc = {
    Text = "すべての覚醒体の基礎ダメージが[Arg1]%増加し、山札をリセットするたび追加で[Arg2]%増加するが、「よろよろ」を1枚手札に追加し、増加値は最大[Arg3]%。"
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:黒い蝋燭>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "意識を燃やし、虚無に堕ちる。"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "ターン開始時、胚胎融合+[Arg1]、「胚胎」はターン終了時に捨てられる。"
  },
  RelicConfig_78671_Desc = {
    Text = "ターン開始時、胚胎融合+[Arg1]、「胚胎」はターン終了時に捨てられる。"
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:蠢く臍の緒>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "首に絡みつく。"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "ターン開始時、[Arg2]層の毒を受け、「超次元空間」に空きが1つあるごとに[Arg1]点の力を獲得する。"
  },
  RelicConfig_78672_Desc = {
    Text = "ターン開始時、[Arg2]層の毒を受け、「超次元空間」に空きが1つあるごとに[Arg1]点の力を獲得する。"
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:虫群の意識>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "絡みつく、共生、群れ；恐怖、未知、制御。"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "シルバーキー覚醒後、追加で[Arg1]キーエネルギーを消費し、獲得した霊知覚醒カードの行動力消費を0にし、使用後、対応する覚醒体に追加で[Arg2]狂気を獲得させる。"
  },
  RelicConfig_78673_Desc = {
    Text = "シルバーキー覚醒後、追加で[Arg1]キーエネルギーを消費し、獲得した霊知覚醒カードの行動力消費を0にし、使用後、対応する覚醒体に追加で[Arg2]狂気を獲得させる。"
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:意識の刻印>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "古い部族は、死者の頭に特別な印を刻むことで、その魂を留め、永遠の伴侶を獲得。と信じていた。"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の毒を付与する。ターン開始時、敵の毒を[Arg2]%解除し、解除した量の[Arg3]%の出血を付与する。"
  },
  RelicConfig_78674_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の毒を付与する。ターン開始時、敵の毒を[Arg2]%解除し、解除した量の[Arg3]%の出血を付与する。"
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:救済の肢>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "神聖な一部。\n胴体から分離しても、その温かさを感じる。"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "ターン開始時、永続的な触腕が[Arg1]本を超えている場合、触腕を[Arg2]本失い一時的な触腕を[Arg3]本獲得し、そうでなければ永続的な触腕を[Arg4]本獲得する。"
  },
  RelicConfig_78675_Desc = {
    Text = "ターン開始時、永続的な触腕が[Arg1]本を超えている場合、触腕を[Arg2]本失い一時的な触腕を[Arg3]本獲得し、そうでなければ永続的な触腕を[Arg4]本獲得する。"
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:苦痛の聖腕>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "苦痛を楽しめ。"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "手札の上限+2、ドロー数+2。開始時の「清明の記憶」は5点で、マークされたカードを使用すると「清明の記憶」の点数が変化する。「清明の記憶」が5点未満の場合、1点減少するごとに最終ダメージ+10％、シールドとライフ回復が5％減少する。「清明の記憶」が5点以上の場合、1点増加するごとにシールドとライフ回復が5％増加し、最終ダメージ-10％。"
  },
  RelicConfig_79408_Desc = {
    Text = "手札の上限+2、ドロー数+2。開始時の「清明の記憶」は5点で、マークされたカードを使用すると「清明の記憶」の点数が変化する。「清明の記憶」が5点未満の場合、1点減少するごとに最終ダメージ+10％、シールドとライフ回復が5％減少する。「清明の記憶」が5点以上の場合、1点増加するごとにシールドとライフ回復が5％増加し、最終ダメージ-10％。"
  },
  RelicConfig_79408_Name = {
    Text = "「記憶」と「夢」"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "「さあ、耳を貸して」\n「あなたの記憶と夢を」\n「とびきり美味しいデザートにしてあげる」"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "ターン開始時、クレメンタインは[Arg1]狂気を獲得する。クレメンタインのすべての指令カードのダメージ、シールド、ライフ回復、狂気獲得、キーエネルギー獲得の効果発動回数が1増加する。"
  },
  RelicConfig_80340_Desc = {
    Text = "ターン開始時、クレメンタインは[Arg1]狂気を獲得する。クレメンタインのすべての指令カードのダメージ、シールド、ライフ回復、狂気獲得、キーエネルギー獲得の効果発動回数が1増加する。"
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:次元影像・クレメンタイン>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "探索開始時、遺物の上限+1、「深海」界域の覚醒体はその「次元影像」を獲得する。チームに「深海」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83509_Desc = {
    Text = "探索開始時、遺物の上限+1、「深海」界域の覚醒体はその「次元影像」を獲得する。チームに「深海」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:「深海の指輪」>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "深淵の冥海に眠るものが、今は忘れられた威厳を世に示す。"
  },
  RelicConfig_83510_BattleDesc = {
    Text = "探索開始時、遺物の上限+1、「血肉」界域の覚醒体はその「次元影像」を獲得する。チームに「血肉」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83510_Desc = {
    Text = "探索開始時、遺物の上限+1、「血肉」界域の覚醒体はその「次元影像」を獲得する。チームに「血肉」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:「血肉の指輪」>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "弱さも苦しみも知らず、すでに超越へ至る。"
  },
  RelicConfig_83511_BattleDesc = {
    Text = "探索開始時、遺物の上限+1、「超次元」界域の覚醒体はその「次元影像」を獲得する。チームに「超次元」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83511_Desc = {
    Text = "探索開始時、遺物の上限+1、「超次元」界域の覚醒体はその「次元影像」を獲得する。チームに「超次元」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:「超次元の指輪」>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "無限の次元が重なり合い、この瞬間、「我」は限りなく完全となる。"
  },
  RelicConfig_83512_BattleDesc = {
    Text = "探索開始時、遺物の上限+1、「混沌」界域の覚醒体はその「次元影像」を獲得する。チームに「混沌」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83512_Desc = {
    Text = "探索開始時、遺物の上限+1、「混沌」界域の覚醒体はその「次元影像」を獲得する。チームに「混沌」界域の覚醒体が1名いるごとに、遺物の上限+1。"
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:「混沌の指輪」>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "混沌は形を持たず、実体もなく、万物の中へ溶け込んでいる。"
  },
  RelicConfig_83606_BattleDesc = {
    Text = "手札の上限+1 。ターン開始時に「航海士の選択」がない場合、手札に追加する。\nボスが初期最大体力の10%を失うたび、「出航」を1点獲得し、上限は10点。「出航」は「荒波の船出」の効果を増加させる。\n自身が初期最大体力の10%を失うたび、「停泊」を1点獲得し、上限は10点。「停泊」は「休息の寄港」の効果を高める。"
  },
  RelicConfig_83606_Desc = {
    Text = "手札の上限+1 。ターン開始時に「航海士の選択」がない場合、手札に追加する。\nボスが初期最大体力の10%を失うたび、「出航」を1点獲得し、上限は10点。「出航」は「荒波の船出」の効果を増加させる。\n自身が初期最大体力の10%を失うたび、「停泊」を1点獲得し、上限は10点。「停泊」は「休息の寄港」の効果を高める。"
  },
  RelicConfig_83606_Name = {
    Text = "エラスムスの導き"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "閃く雷光が進むべき道を示す。"
  },
  RelicConfig_84112_BattleDesc = {
    Text = "ターン開始時、アグリッパは[Arg1]狂気を獲得する。「耐え難い施し」は、このターンの間、アグリッパの行動力消費を[Arg2]減少させ、毎ターン最大1回まで発動する。"
  },
  RelicConfig_84112_Desc = {
    Text = "ターン開始時、アグリッパは[Arg1]狂気を獲得する。「耐え難い施し」は、このターンの間、アグリッパの行動力消費を[Arg2]減少させ、毎ターン最大1回まで発動する。"
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:次元影像・アグリッパ>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "ターン開始時にカラブは [Arg1] 狂気を獲得する。カラブが<FaxianKeywords:発見> <DerivativeCardKeywords_152:「しゅくふく」>するたびに追加選択肢が 1 つ出現し、狂気解放は同量のダメージの<Corrosion:侵蝕>を与える。"
  },
  RelicConfig_84113_Desc = {
    Text = "ターン開始時にカラブは [Arg1] 狂気を獲得する。カラブが<FaxianKeywords:発見> <DerivativeCardKeywords_152:「しゅくふく」>するたびに追加選択肢が 1 つ出現し、狂気解放は同量のダメージの<Corrosion:侵蝕>を与える。"
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:次元影像·カラブ>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "ターン開始時、ピックマンは[Arg1]狂気を獲得する。「創意」を1層獲得するたび、ランダムな手札1枚の今ターンの算力消費を1減少させ、ピックマンが「創意」を消費した時、追加ですべての覚醒体に[Arg2]点の狂気を獲得させる。"
  },
  RelicConfig_84114_Desc = {
    Text = "ターン開始時、ピックマンは[Arg1]狂気を獲得する。「創意」を1層獲得するたび、ランダムな手札1枚の今ターンの算力消費を1減少させ、ピックマンが「創意」を消費した時、追加ですべての覚醒体に[Arg2]点の狂気を獲得させる。"
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:次元影像・ピックマン>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "ターン開始時、エリカは[Arg1]狂気を獲得する。エリカが1ターン内に指令カードを[Arg2]枚使用した後、2点の行動力を獲得し、この戦闘中「電磁爆破」が獲得する力と警戒ボーナスが2倍になる。"
  },
  RelicConfig_84116_Desc = {
    Text = "ターン開始時、エリカは[Arg1]狂気を獲得する。エリカが1ターン内に指令カードを[Arg2]枚使用した後、2点の行動力を獲得し、この戦闘中「電磁爆破」が獲得する力と警戒ボーナスが2倍になる。"
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:次元影像・エリカ>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "ターン開始時、妄誕・マーフィーは[Arg1]狂気を獲得する。「螺旋円舞」は3回目の使用ごとに3回発動する。"
  },
  RelicConfig_84117_Desc = {
    Text = "ターン開始時、妄誕・マーフィーは[Arg1]狂気を獲得する。「螺旋円舞」は3回目の使用ごとに3回発動する。"
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:次元影像・誕妄・マーフィー>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたび、カーシアは[Arg2]狂気を獲得する。カーシアが「狂気解放」を発動した時、すべての敵から[Arg3]点の力を減少させる。"
  },
  RelicConfig_84118_Desc = {
    Text = "ターン開始時、カーシアは[Arg1]狂気を獲得する。カードを1枚引くたび、カーシアは[Arg2]狂気を獲得する。カーシアが「狂気解放」を発動した時、すべての敵から[Arg3]点の力を減少させる。"
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:次元影像・カーシア>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "ターン開始時、マーフィーは[Arg1]狂気を獲得する。マーフィーの「攻撃」と「防御」は、[Arg2]%の「供儀」を一時的な触腕ダメージに変換し、毎ターン最大1回まで発動する。"
  },
  RelicConfig_84119_Desc = {
    Text = "ターン開始時、マーフィーは[Arg1]狂気を獲得する。マーフィーの「攻撃」と「防御」は、[Arg2]%の「供儀」を一時的な触腕ダメージに変換し、毎ターン最大1回まで発動する。"
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:次元影像・マーフィー>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "ターン開始時、アラクネは[Arg1]狂気を獲得する。「打撃」と「防御」を使用した後、即座に「無限の糸」追撃を1回発動する。この効果はそれぞれ各ターンで最大1回まで有効。"
  },
  RelicConfig_84121_Desc = {
    Text = "ターン開始時、アラクネは[Arg1]狂気を獲得する。「打撃」と「防御」を使用した後、即座に「無限の糸」追撃を1回発動する。この効果はそれぞれ各ターンで最大1回まで有効。"
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:次元影像・アラクネ>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "ターン開始時、トゥルーは[Arg1]狂気を獲得する。トゥルーの狂気消費が[Arg2]減少し、「狂気解放」を発動後、即座に[Arg3]本の一時的な触腕を獲得する。"
  },
  RelicConfig_84122_Desc = {
    Text = "ターン開始時、トゥルーは[Arg1]狂気を獲得する。トゥルーの狂気消費が[Arg2]減少し、「狂気解放」を発動後、即座に[Arg3]本の一時的な触腕を獲得する。"
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:次元影像・トゥルー>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "ターン開始時、ポリュクスは[Arg1]狂気を獲得する。戦闘開始時、「聖心」を1枚獲得し、「聖心」が3回目の使用で消費された時、すべての敵に被ダメージ増加を付与し、2回ダメージを与える。"
  },
  RelicConfig_84123_Desc = {
    Text = "ターン開始時、ポリュクスは[Arg1]狂気を獲得する。戦闘開始時、「聖心」を1枚獲得し、「聖心」が3回目の使用で消費された時、すべての敵に被ダメージ増加を付与し、2回ダメージを与える。"
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:次元影像・ポリュクス>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "ターン開始時、ハムリンは[Arg1]狂気を獲得する。「魂の序曲」の行動力消費が[Arg2]減少し、与える基礎ダメージ回数が[Arg3]増加する。"
  },
  RelicConfig_84124_Desc = {
    Text = "ターン開始時、ハムリンは[Arg1]狂気を獲得する。「魂の序曲」の行動力消費が[Arg2]減少し、与える基礎ダメージ回数が[Arg3]増加する。"
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:次元影像・ハムリン>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "ターン開始時、ケティグラは[Arg1]狂気を獲得する。累計10層の「活焔」を消費した後、即座にケティグラの指令カードを1枚引き、3層の「活焔」を付与する。このターン中は層数を累計しない。"
  },
  RelicConfig_84125_Desc = {
    Text = "ターン開始時、ケティグラは[Arg1]狂気を獲得する。累計10層の「活焔」を消費した後、即座にケティグラの指令カードを1枚引き、3層の「活焔」を付与する。このターン中は層数を累計しない。"
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:次元影像・ケティグラ>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "ターン開始時、カストルは[Arg1]狂気を獲得する。戦闘開始時、「黒羽」を2枚手札に追加し、毎ターン初めて「黒羽」を初めて使用した後、[Arg2]点の一時的な力を獲得する。"
  },
  RelicConfig_84126_Desc = {
    Text = "ターン開始時、カストルは[Arg1]狂気を獲得する。戦闘開始時、「黒羽」を2枚手札に追加し、毎ターン初めて「黒羽」を初めて使用した後、[Arg2]点の一時的な力を獲得する。"
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:次元影像・カストル>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "ターン開始時、コーパサントは[Arg1]狂気を獲得し、1本の一時的な触腕を獲得する。死亡抵抗を発動するたび、コーパサントは[Arg2]狂気を獲得し、消費が付与された行動力消費0の「戒めの雷」1枚を手札に追加する。"
  },
  RelicConfig_84127_Desc = {
    Text = "ターン開始時、コーパサントは[Arg1]狂気を獲得し、1本の一時的な触腕を獲得する。死亡抵抗を発動するたび、コーパサントは[Arg2]狂気を獲得し、消費が付与された行動力消費0の「戒めの雷」1枚を手札に追加する。"
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:次元影像・コーパサント>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "行動力の上限が1増加し、毎ターンドロー数が1増加する。戦闘開始時に[Arg1]点の「宿命の檻」を獲得する。\n「宿命の檻」の点数ごとにすべての覚醒体が獲得する狂気が[Arg2]%減少し、「狂気解放」を発動するたび「宿命の檻」の点数が1減少する。すべての「宿命の檻」が除去されると、すべての覚醒体が[Arg3]狂気を獲得し、「不屈の心」を獲得する：すべての覚醒体が獲得する狂気が[Arg4]%増加し、毎ターン2回まで「狂気解放」を発動可能になる。"
  },
  RelicConfig_89252_Desc = {
    Text = "行動力の上限が1増加し、毎ターンドロー数が1増加する。戦闘開始時に[Arg1]点の「宿命の檻」を獲得する。\n「宿命の檻」の点数ごとにすべての覚醒体が獲得する狂気が[Arg2]%減少し、「狂気解放」を発動するたび「宿命の檻」の点数が1減少する。すべての「宿命の檻」が除去されると、すべての覚醒体が[Arg3]狂気を獲得し、「不屈の心」を獲得する：すべての覚醒体が獲得する狂気が[Arg4]%増加し、毎ターン2回まで「狂気解放」を発動可能になる。"
  },
  RelicConfig_89252_Name = {
    Text = "呪われた羽根"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "今や、この羽根が空を翔ることはない。"
  },
  RelicConfig_89645_BattleDesc = {
    Text = "手札の上限+2、「狂気解放」を発動後、最終ダメージが一時的に10%増加する。\nカードが超次元空間に入ると、手札の「胚胎」1枚が「聖純の子」に変化する。\n「胚胎」を1枚獲得するごとに、超次元空間にあるランダムなカード1枚の行動力消費が1減少する。"
  },
  RelicConfig_89645_Desc = {
    Text = "手札の上限+2、「狂気解放」を発動後、最終ダメージが一時的に10%増加する。\nカードが超次元空間に入ると、手札の「胚胎」1枚が「聖純の子」に変化する。\n「胚胎」を1枚獲得するごとに、超次元空間にあるランダムなカード1枚の行動力消費が1減少する。"
  },
  RelicConfig_89645_Name = {
    Text = "超弦腐血の霊薬"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "ターン開始時、250キーエネルギーを獲得する。\nシルバーキー覚醒後、<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。\nターン開始時に覚醒体の支援を1枚発見する。"
  },
  RelicConfig_89646_Desc = {
    Text = "ターン開始時、250キーエネルギーを獲得する。\nシルバーキー覚醒後、<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。\nターン開始時に覚醒体の支援を1枚発見する。"
  },
  RelicConfig_89646_Name = {
    Text = "総合進化の霊薬"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "毎ターン最初に出す指令カードが追加で1回効果を発動する。\n「湮滅」を使用すると1本の触腕を獲得する。\n触腕を「怒涛」姿態に切り替えた後、このターンの次に出す1枚目の指令カードの「跳躍」効果が必ず発動し、そのコピーを2枚超次元空間に置く。クールダウン3ターン。"
  },
  RelicConfig_89647_Desc = {
    Text = "毎ターン最初に出す指令カードが追加で1回効果を発動する。\n「湮滅」を使用すると1本の触腕を獲得する。\n触腕を「怒涛」姿態に切り替えた後、このターンの次に出す1枚目の指令カードの「跳躍」効果が必ず発動し、そのコピーを2枚超次元空間に置く。クールダウン3ターン。"
  },
  RelicConfig_89647_Name = {
    Text = "超弦深淵の霊薬"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "界域知識が200点増加する。\n猩紅炉を消費すると、触腕ダメージが消費量の15％分増加する。\n触腕が攻撃するたび、[Arg3]点の猩紅炉を蓄積する。"
  },
  RelicConfig_89648_Desc = {
    Text = "界域知識が200点増加する。\n猩紅炉を消費すると、触腕ダメージが消費量の15％分増加する。\n触腕が攻撃するたび、[Arg3]点の猩紅炉を蓄積する。"
  },
  RelicConfig_89648_Name = {
    Text = "腐血深淵の霊薬"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "ラウンド開始時、双方は1層の<Kuangre:狂熱>を得る。各層の<Kuangre:狂熱>は、与えた能動的および触腕ダメージに10％のダメージに相当する<BleedingIconKeywords:出血>を追加する。\nボスの生命20％のダメージを与えるごとに、すべての覚醒体が10の狂気を得る。\n戦闘開始時、<DerivativeCardKeywords_108:「子嗣激励」>と<DerivativeCardKeywords_109:「子嗣庇佑」>をドローデッキにシャッフルする。"
  },
  RelicConfig_91096_Desc = {
    Text = "ラウンド開始時、双方は1層の<Kuangre:狂熱>を得る。各層の<Kuangre:狂熱>は、与えた能動的および触腕ダメージに10％のダメージに相当する<BleedingIconKeywords:出血>を追加する。\nボスの生命20％のダメージを与えるごとに、すべての覚醒体が10の狂気を得る。\n戦闘開始時、<DerivativeCardKeywords_108:「子嗣激励」>と<DerivativeCardKeywords_109:「子嗣庇佑」>をドローデッキにシャッフルする。"
  },
  RelicConfig_91096_Name = {
    Text = "蒼白の卵"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "蒼白なる子がまもなく誕生しようとする、その鼓動。\n気をつけろ、彼らは、すぐそこまで来ている。"
  },
  RelicConfig_94695_BattleDesc = {
    Text = "覚醒体が撃破されると、他の味方が[Arg1]点の<StrongEffectKeywords:特効>を獲得する。この効果は各覚醒体につき一度だけ発動できる。"
  },
  RelicConfig_94695_Desc = {
    Text = "覚醒体が撃破されると、他の味方が[Arg1]点の<StrongEffectKeywords:特効>を獲得する。この効果は各覚醒体につき一度だけ発動できる。"
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:黒星の燃え殻>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "戦闘開始後、[Arg1]枚の「<PVPDerivativeCardKeywords_21:骨を蝕む抱擁>」を手札に追加する。"
  },
  RelicConfig_94696_Desc = {
    Text = "戦闘開始後、[Arg1]枚の「<PVPDerivativeCardKeywords_21:骨を蝕む抱擁>」を手札に追加する。"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "ターン終了時、すべての手札を捨て、同数のカードを引く。"
  },
  RelicConfig_94697_Desc = {
    Text = "ターン終了時、すべての手札を捨て、同数のカードを引く。"
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:惑わし風鈴>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "戦闘開始後、山札に[Arg1]枚の「<PVPDerivativeCardKeywords_22:後の先>」と「<PVPDerivativeCardKeywords_23:頭の中の音>」を追加する。"
  },
  RelicConfig_94698_Desc = {
    Text = "戦闘開始後、山札に[Arg1]枚の「<PVPDerivativeCardKeywords_22:後の先>」と「<PVPDerivativeCardKeywords_23:頭の中の音>」を追加する。"
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:アルフォンソの器>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "手札の上限+1。\nターン開始時に「魂の捕食」がない場合、手札に追加する。「満腹」が10に達すると、「記憶の共鳴」に変化する。"
  },
  RelicConfig_95975_Desc = {
    Text = "手札の上限+1。\nターン開始時に「魂の捕食」がない場合、手札に追加する。「満腹」が10に達すると、「記憶の共鳴」に変化する。"
  },
  RelicConfig_95975_Name = {
    Text = "骸骨の盃"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "「血の月が高く昇るとき、群れなす骸は杯を掲げ、共に飲み交わす」"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "ターン開始時、ドゥルセインは[Arg1]狂気と[Arg2]点の力を獲得する。ドゥルセインが「残骸」を消費した時、永続の力の20%分の一時的な力を獲得する。"
  },
  RelicConfig_95976_Desc = {
    Text = "ターン開始時、ドゥルセインは[Arg1]狂気と[Arg2]点の力を獲得する。ドゥルセインが「残骸」を消費した時、永続の力の20%分の一時的な力を獲得する。"
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:次元影像・ドゥルセイン>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "ターン開始時、手札の指令カード1枚に「<BurningKeywords2:燃焼>」を付与し、「<Heat:深暗の炎>」を1層蓄積する。「<Heat:深暗の炎>」が3層に達すると、「<Overload:無尽の爆炎>」を1枚手札に追加する。"
  },
  RelicConfig_96652_Desc = {
    Text = "ターン開始時、手札の指令カード1枚に「<BurningKeywords2:燃焼>」を付与し、「<Heat:深暗の炎>」を1層蓄積する。「<Heat:深暗の炎>」が3層に達すると、「<Overload:無尽の爆炎>」を1枚手札に追加する。"
  },
  RelicConfig_96652_Name = {
    Text = "深き闇の炎"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "漆黒の炎が彼女の意志を貫き、すべてを焼き尽くす。"
  },
  RelicConfig_97344_BattleDesc = {
    Text = "最後の1枚の手札を失うと、2枚のカードを引き、[Arg1] ポイントのシルバーキーエネルギーを得ます。デッキをリセットするたびに、触手ダメージが [Arg2] ポイント増加します。"
  },
  RelicConfig_97344_Desc = {
    Text = "最後の1枚の手札を失うと、2枚のカードを引き、[Arg1] ポイントのシルバーキーエネルギーを得ます。デッキをリセットするたびに、触手ダメージが [Arg2] ポイント増加します。"
  },
  RelicConfig_97344_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "今日、私たちは恐怖を忘れ、悲嘆を忘れ、ただ狂騒を楽しむ。"
  },
  RelicConfig_97345_BattleDesc = {
    Text = "3枚のコマンドカードをプレイするたびに、1の計算力を獲得し、1枚のカードを引く。1回の能動ダメージを与えるたびに、一時的な最終ダメージが2％上昇し、最大で50％まで上昇する。"
  },
  RelicConfig_97345_Desc = {
    Text = "3枚のコマンドカードをプレイするたびに、1の計算力を獲得し、1枚のカードを引く。1回の能動ダメージを与えるたびに、一時的な最終ダメージが2％上昇し、最大で50％まで上昇する。"
  },
  RelicConfig_97345_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "今日、私たちは恐怖を忘れ、悲嘆を忘れ、ただ狂騒を楽しむ。"
  },
  RelicConfig_97346_BattleDesc = {
    Text = "すべての覚醒体のクリティカル率が30%増加し、奇数ターン開始時にすべての敵は現在のライフの25%を失う。自身のライフ割合が敵より低い場合、最終ダメージが50%増加する；自身のライフ割合が敵より高い場合、狂気爆発を発動した後、35ポイントの狂気を獲得する。"
  },
  RelicConfig_97346_Desc = {
    Text = "すべての覚醒体のクリティカル率が30%増加し、奇数ターン開始時にすべての敵は現在のライフの25%を失う。自身のライフ割合が敵より低い場合、最終ダメージが50%増加する；自身のライフ割合が敵より高い場合、狂気爆発を発動した後、35ポイントの狂気を獲得する。"
  },
  RelicConfig_97346_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "今日、私たちは恐怖を忘れ、悲嘆を忘れ、ただ狂騒を楽しむ。"
  },
  RelicConfig_97347_BattleDesc = {
    Text = "最大行動力が2ポイント増加し、未消費の行動力は次のターンに持ち越せます。2ポイントを超えて行動力を持ち越えた場合、次のターンの開始時にすべての覚醒体が20の狂気を獲得します。4ポイントを超えて行動力を持ち越えた場合、次のターンの基礎ダメージが100％増加します。"
  },
  RelicConfig_97347_Desc = {
    Text = "最大行動力が2ポイント増加し、未消費の行動力は次のターンに持ち越せます。2ポイントを超えて行動力を持ち越えた場合、次のターンの開始時にすべての覚醒体が20の狂気を獲得します。4ポイントを超えて行動力を持ち越えた場合、次のターンの基礎ダメージが100％増加します。"
  },
  RelicConfig_97347_Name = {
    Text = "ミサゴ大学優勝杯"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "今日、私たちは恐怖を忘れ、悲嘆を忘れ、ただ狂騒を楽しむ。"
  },
  RelicConfig_98274_BattleDesc = {
    Text = "手札上限 +1、戦闘開始時「<DerivativeCardKeywords_116:パレット>」を獲得する。\nターン開始時に「<PrimaryColor:原色>」を1つ獲得し、ランダムに2枚の指令カードに「<ColorInkKeywords:認知的不協和>」を付与する。「<ColorInkKeywords:認知的不協和>」のカードを使用すると、順番に「<PrimaryColor:原色>」を1つ獲得する。\n「<PrimaryColor:原色>」は使用後「<DerivativeCardKeywords_116:パレット>」に記録される。「<DerivativeCardKeywords_116:パレット>」に2種類の異なる「<PrimaryColor:原色>」が存在する場合、持続的なバフ効果をもたらす。\n「<PrimaryColor:原色>」が3種類揃うと、即座にすべての敵の最大HPの5％を失わせ、「<DerivativeCardKeywords_116:パレット>」をクリアする。"
  },
  RelicConfig_98274_Desc = {
    Text = "手札上限 +1、戦闘開始時「<DerivativeCardKeywords_116:パレット>」を獲得する。\nターン開始時に「<PrimaryColor:原色>」を1つ獲得し、ランダムに2枚の指令カードに「<ColorInkKeywords:認知的不協和>」を付与する。「<ColorInkKeywords:認知的不協和>」のカードを使用すると、順番に「<PrimaryColor:原色>」を1つ獲得する。\n「<PrimaryColor:原色>」は使用後「<DerivativeCardKeywords_116:パレット>」に記録される。「<DerivativeCardKeywords_116:パレット>」に2種類の異なる「<PrimaryColor:原色>」が存在する場合、持続的なバフ効果をもたらす。\n「<PrimaryColor:原色>」が3種類揃うと、即座にすべての敵の最大HPの5％を失わせ、「<DerivativeCardKeywords_116:パレット>」をクリアする。"
  },
  RelicConfig_98274_Name = {
    Text = "異象のパレット"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "怪奇現象の中で、私たちは「芸術」の誕生を目撃する。"
  },
  RelicConfig_98367_BattleDesc = {
    Text = "すべての覚醒体が与えるライフ回復とシールドが[Arg1]%増加する。"
  },
  RelicConfig_98367_Desc = {
    Text = "すべての覚醒体が与えるライフ回復とシールドが[Arg1]%増加する。"
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:怪蛇の抜け殻>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "自傷し殻を脱ぎ捨て、生まれ変わる。"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で[Arg1]%の一時的なダメージ強化を獲得する。"
  },
  RelicConfig_98368_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で[Arg1]%の一時的なダメージ強化を獲得する。"
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:万華鏡+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "思い描くもの、目にするもの、すべては幻である。"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "シルバーキー覚醒後、手札の中で最も行動力が高いカード[Arg1]枚に、次に使用するまで保持と予備を付与する。[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98369_Desc = {
    Text = "シルバーキー覚醒後、手札の中で最も行動力が高いカード[Arg1]枚に、次に使用するまで保持と予備を付与する。[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:異国の切手帳>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "数値化された想い。"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:弱体>を付与する。「湮滅」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98370_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:弱体>を付与する。「湮滅」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:空間屈折装置>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "虚空に飛び込む。"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98371_Desc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:不均衡な天秤>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "もはや公正の象徴ではない。"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "ターン終了時にキーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費して<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。"
  },
  RelicConfig_98372_Desc = {
    Text = "ターン終了時にキーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費して<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。"
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:黄昏の中で>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "一緒に写真を撮りましょう！真実に向き合う痛みを、体験してください。"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "「狂気解放」を発動した後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98373_Desc = {
    Text = "「狂気解放」を発動した後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:美しき瞬間+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "一瞬の美を永遠に留める。"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、 [Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_98374_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、 [Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:予言者の祈願灯+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "君の願いに応える。"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "ターン終了時にキーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費して<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。"
  },
  RelicConfig_98375_Desc = {
    Text = "ターン終了時にキーエネルギーが上限に達している場合、[Arg1]キーエネルギーを消費して<DerivativeCardKeywords_129:「シルバーキーの微光」>を1枚手札に追加する。"
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:黄昏の中で+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "一緒に写真を撮りましょう！真実に向き合う痛みを、体験してください。"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "すべての覚醒体が与えるライフ回復とシールドが[Arg1]%増加する。"
  },
  RelicConfig_98376_Desc = {
    Text = "すべての覚醒体が与えるライフ回復とシールドが[Arg1]%増加する。"
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:怪蛇の抜け殻+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "自傷し殻を脱ぎ捨て、生まれ変わる。"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "カードが超次元空間に入るたび、対応する覚醒体の指令カードを[Arg1]枚引く。山札にカードがない場合は、同数の行動力を獲得する。毎ターンで最大2回まで発動可能。"
  },
  RelicConfig_98377_Desc = {
    Text = "カードが超次元空間に入るたび、対応する覚醒体の指令カードを[Arg1]枚引く。山札にカードがない場合は、同数の行動力を獲得する。毎ターンで最大2回まで発動可能。"
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:三稜鏡>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "「光は七色で構成されている」"
  },
  RelicConfig_98378_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。ダメージを受けた後、[Arg2]点の<RetaliateIconKeywords:反撃> を獲得し、毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98378_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。ダメージを受けた後、[Arg2]点の<RetaliateIconKeywords:反撃> を獲得し、毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:安全な出口+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "どうやら彼も逃げられなかったようだ。"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、対象がそのターンに受ける触腕ダメージを[Arg1]%増加させる。毎ターン最大20回まで発動可能。"
  },
  RelicConfig_98379_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、対象がそのターンに受ける触腕ダメージを[Arg1]%増加させる。毎ターン最大20回まで発動可能。"
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:潜水ヘルメット>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "夢は星の海！"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "戦闘開始時と死亡抵抗を発動後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98380_Desc = {
    Text = "戦闘開始時と死亡抵抗を発動後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:古の供物>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "かつての供物。"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "シルバーキー覚醒後、ライフを[Heal:Arg1]回復し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98381_Desc = {
    Text = "シルバーキー覚醒後、ライフを[Heal:Arg1]回復し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:旅行用の日傘>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "光の届かぬ場所で咲く。"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。奇数ターン開始時にカードを[Arg2]枚引き、偶数ターン開始時に[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98382_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。奇数ターン開始時にカードを[Arg2]枚引き、偶数ターン開始時に[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:日月ルーレット+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "黒か白か、どっちだと思う？"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕を触発して敵に[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  RelicConfig_98383_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕を触発して敵に[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:黄色い小さな貝+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "この小さな黄色いカタツムリは高貴な出自を持ち、完璧で非の打ち所がない。"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」発動時、対応する覚醒体の基礎ダメージが一時的に[Arg2]%増加する。"
  },
  RelicConfig_98384_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」発動時、対応する覚醒体の基礎ダメージが一時的に[Arg2]%増加する。"
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:忘れられし者の血>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "次第に消えていく。"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、 [Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_98385_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、 [Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:予言者の祈願灯>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "君の願いに応える。"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "ターン開始時、ライフが50％未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25％未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98386_Desc = {
    Text = "ターン開始時、ライフが50％未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25％未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:医者の鞄>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "医者の象徴である重い手提げ箱。\n開けるのは本物の医者とは限らない。"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:弱体>を付与する。「湮滅」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98387_Desc = {
    Text = "戦闘開始時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:弱体>を付与する。「湮滅」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:空間屈折装置+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "虚空に飛び込む。"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "戦闘開始時と死亡抵抗を発動後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98388_Desc = {
    Text = "戦闘開始時と死亡抵抗を発動後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:古の供物+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "かつての供物。"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。奇数ターン開始時にカードを[Arg2]枚引き、偶数ターン開始時に[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98389_Desc = {
    Text = "戦闘開始後、[Arg1]点の<ProficientInRealmsIconKeywords:界域知識>を獲得する。奇数ターン開始時にカードを[Arg2]枚引き、偶数ターン開始時に[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:日月ルーレット>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "黒か白か、どっちだと思う？"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "カードを1枚引くか捨てるごとに、[Arg1]点の一時的<PowerIconKeywords:力>を獲得する。毎ターン最大で15回まで発動可能。"
  },
  RelicConfig_98390_Desc = {
    Text = "カードを1枚引くか捨てるごとに、[Arg1]点の一時的<PowerIconKeywords:力>を獲得する。毎ターン最大で15回まで発動可能。"
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:静寂の序曲>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "著名なバイオリニスト、エリック・エックシュタインのバイオリン。\n今や、二度と奏でられることはない。"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "毎ターン初めての「キーオーダー」で一時的なダメージ効果が＋[Arg2]％上昇し、ライフが低いほど効果が強化される。"
  },
  RelicConfig_98391_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、一時的なダメージ強化+[Arg1]％。ライフが低いほど効果が上昇する。"
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:ハーフォードの霊薬>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "成分不明の薬品。\n著名なバイオリニストのエリックが特に愛用していたという。"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "毎ターン初めての「キーオーダー」で一時的なダメージ効果が＋[Arg2]％上昇し、ライフが低いほど効果が強化される。"
  },
  RelicConfig_98392_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、一時的なダメージ強化+[Arg1]％。ライフが低いほど効果が上昇する。"
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:ハーフォードの霊薬+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "成分不明の薬品。\n著名なバイオリニストのエリックが特に愛用していたという。"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98393_Desc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:口達者>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "口が立つのは商人だけとは限らない。敬虔な信者も同じだ。"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  RelicConfig_98394_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:幸運な兎の足>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "兎にとっては、そうでもない。"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。アクティブダメージを与えた後、すべての敵に[Arg2]点の <IntoxicationIconKeywords:毒> を付与し、毎ターン最大5回まで発動可能。"
  },
  RelicConfig_98395_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。アクティブダメージを与えた後、すべての敵に[Arg2]点の <IntoxicationIconKeywords:毒> を付与し、毎ターン最大5回まで発動可能。"
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:祭司の杖+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "許されない信仰。"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で[Arg1]%の一時的なダメージ強化を獲得する。"
  },
  RelicConfig_98396_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。異なる覚醒体の指令カードを1枚使用するたび、追加で[Arg1]%の一時的なダメージ強化を獲得する。"
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:万華鏡>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "思い描くもの、目にするもの、すべては幻である。"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "毎ターン2回目に「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体に[Arg2]狂気を獲得させる。"
  },
  RelicConfig_98397_Desc = {
    Text = "毎ターン2回目に「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体に[Arg2]狂気を獲得させる。"
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:精密タイマー+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "人類が発明した中で最悪の発明の一つだ。"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。「猩紅炉」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98398_Desc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。「猩紅炉」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:スリの名人+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "殺人と略奪のための最高の道具。"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "毎ターン2回目に「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体に[Arg2]狂気を獲得させる。"
  },
  RelicConfig_98399_Desc = {
    Text = "毎ターン2回目に「キーオーダー」を発動した後、[Arg1]キーエネルギーを獲得し、すべての覚醒体に[Arg2]狂気を獲得させる。"
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:精密タイマー>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "人類が発明した中で最悪の発明の一つだ。"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "カードを1枚引くか捨てるごとに、[Arg1]点の一時的<PowerIconKeywords:力>を獲得する。毎ターン最大で15回まで発動可能。"
  },
  RelicConfig_98400_Desc = {
    Text = "カードを1枚引くか捨てるごとに、[Arg1]点の一時的<PowerIconKeywords:力>を獲得する。毎ターン最大で15回まで発動可能。"
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:静寂の序曲+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "著名なバイオリニスト、エリック・エックシュタインのバイオリン。\n今や、二度と奏でられることはない。"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<RetaliateIconKeywords:反撃>を獲得した後、 [Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98401_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<RetaliateIconKeywords:反撃>を獲得した後、 [Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:パットニー朝刊+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "あなたの最も心強いトイレの相棒。"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、対象がそのターンに受ける触腕ダメージを[Arg1]%増加させる。毎ターン最大20回まで発動可能。"
  },
  RelicConfig_98402_Desc = {
    Text = "アクティブダメージまたは触腕ダメージを与えた後、対象がそのターンに受ける触腕ダメージを[Arg1]%増加させる。毎ターン最大20回まで発動可能。"
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:潜水ヘルメット+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "夢は星の海！"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点の<PowerIconKeywords:力> を獲得する。「除外」が付与されたカードを使用するごとに、 [Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大10回まで発動可能。"
  },
  RelicConfig_98403_Desc = {
    Text = "戦闘開始時、[Arg1]点の<PowerIconKeywords:力> を獲得する。「除外」が付与されたカードを使用するごとに、 [Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大10回まで発動可能。"
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:小さなオルゴール+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "デクスター邸の数あるコレクションの中でも、この小さなオルゴールは、デクスター家の幼いお嬢様のお気に入りの玩具だった。\n時は流れ、彼女が再びそれを見つけた時、歯車は緩み、音色も狂っていたが、それでもなお回転を続けていた。"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "「狂気解放」を発動した後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98404_Desc = {
    Text = "「狂気解放」を発動した後、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:美しき瞬間>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "一瞬の美を永遠に留める。"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98405_Desc = {
    Text = "すべての覚醒体が毎ターン初めて使用する「指令カード」は、[Arg1]キーエネルギーを獲得する。"
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:口達者+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "口が立つのは商人だけとは限らない。敬虔な信者も同じだ。"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "「胚胎」を1枚獲得するたび、猩紅炉を[Arg1]点蓄積する。毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98406_Desc = {
    Text = "「胚胎」を1枚獲得するたび、猩紅炉を[Arg1]点蓄積する。毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:親愛なる宝物+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "大工は妻のために生き生きとした木偶を作りました。それは彼らの息子の代わりに、彼女の腹の中で眠るのです。"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  RelicConfig_98407_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、消費したキーエネルギーの[Arg1]%を返還する。"
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:幸運な兎の足+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "兎にとっては、そうでもない。"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "ターン開始時、狂気解放の発動に必要な狂気が不足しているすべての覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98408_Desc = {
    Text = "ターン開始時、狂気解放の発動に必要な狂気が不足しているすべての覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:イースタータイム>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "存分にお楽しみください。ただし、食べられません。"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。「猩紅炉」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98409_Desc = {
    Text = "戦闘開始時、すべての敵から[Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。「猩紅炉」使用後もこの効果が発動し、クールダウン3ターン。"
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:スリの名人>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "殺人と略奪のための最高の道具。"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "「胚胎」を1枚獲得するたび、猩紅炉を[Arg1]点蓄積する。毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98410_Desc = {
    Text = "「胚胎」を1枚獲得するたび、猩紅炉を[Arg1]点蓄積する。毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:親愛なる宝物>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "大工は妻のために生き生きとした木偶を作りました。それは彼らの息子の代わりに、彼女の腹の中で眠るのです。"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "ターン開始時、キーエネルギーが[Arg1]より多い場合、[Arg1]キーエネルギーを消費し、<DerivativeCardKeywords_115:「上級啓示」>を1枚手札に追加する。"
  },
  RelicConfig_98411_Desc = {
    Text = "ターン開始時、キーエネルギーが[Arg1]より多い場合、[Arg1]キーエネルギーを消費し、<DerivativeCardKeywords_115:「上級啓示」>を1枚手札に追加する。"
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:悪夢の表象>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "気をつけて、放縦な深い眠りがすべてを飲み込む。"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "「狂気解放」を5回発動するたび、[Arg1]枚の非派生指令カードが追加で1回効果を発動する。"
  },
  RelicConfig_98412_Desc = {
    Text = "「狂気解放」を5回発動するたび、[Arg1]枚の非派生指令カードが追加で1回効果を発動する。"
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:星々の酒+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "星々の間を彷徨う。"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。ダメージを受けた後、[Arg2]点の<RetaliateIconKeywords:反撃> を獲得し、毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98413_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。ダメージを受けた後、[Arg2]点の<RetaliateIconKeywords:反撃> を獲得し、毎ターン最大3回まで発動可能。"
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:安全な出口>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "どうやら彼も逃げられなかったようだ。"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」発動時、対応する覚醒体の基礎ダメージが一時的に[Arg2]%増加する。"
  },
  RelicConfig_98414_Desc = {
    Text = "すべての覚醒体が与える基礎ダメージが[Arg1]%増加する。「狂気解放」発動時、対応する覚醒体の基礎ダメージが一時的に[Arg2]%増加する。"
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:忘れられし者の血+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "次第に消えていく。"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "シルバーキー覚醒後、ライフを[Heal:Arg1]回復し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98415_Desc = {
    Text = "シルバーキー覚醒後、ライフを[Heal:Arg1]回復し、[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:旅行用の日傘+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "光の届かぬ場所で咲く。"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<RetaliateIconKeywords:反撃>を獲得した後、 [Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98416_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<RetaliateIconKeywords:反撃>を獲得した後、 [Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:パットニー朝刊>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "あなたの最も心強いトイレの相棒。"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "ターン開始時、狂気解放の発動に必要な狂気が不足しているすべての覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98417_Desc = {
    Text = "ターン開始時、狂気解放の発動に必要な狂気が不足しているすべての覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:イースタータイム+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "存分にお楽しみください。ただし、食べられません。"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<IntoxicationIconKeywords:毒>を付与した後、カードを[Arg2]枚引く。"
  },
  RelicConfig_98418_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<IntoxicationIconKeywords:毒>を付与した後、カードを[Arg2]枚引く。"
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:リンド・パピルス+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "では問題です。10人の僧侶で6個のパンを分け合うと、それぞれどのくらい貰えるでしょうか？"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "「狂気解放」を5回発動するたび、[Arg1]枚の非派生指令カードが追加で1回効果を発動する。"
  },
  RelicConfig_98419_Desc = {
    Text = "「狂気解放」を5回発動するたび、[Arg1]枚の非派生指令カードが追加で1回効果を発動する。"
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:星々の酒>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "星々の間を彷徨う。"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "カードが超次元空間に入るたび、対応する覚醒体の指令カードを[Arg1]枚引く。山札にカードがない場合は、同数の行動力を獲得する。毎ターンで最大2回まで発動可能。"
  },
  RelicConfig_98420_Desc = {
    Text = "カードが超次元空間に入るたび、対応する覚醒体の指令カードを[Arg1]枚引く。山札にカードがない場合は、同数の行動力を獲得する。毎ターンで最大2回まで発動可能。"
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:三稜鏡+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "「光は七色で構成されている」"
  },
  RelicConfig_98421_BattleDesc = {
    Text = "シルバーキー覚醒後、手札の中で最も行動力が高いカード[Arg1]枚に、次に使用するまで保持と予備を付与する。[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98421_Desc = {
    Text = "シルバーキー覚醒後、手札の中で最も行動力が高いカード[Arg1]枚に、次に使用するまで保持と予備を付与する。[Arg2]キーエネルギーを獲得する。"
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:異郷の切手帳+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "数値化された想い。"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98422_Desc = {
    Text = "ターン終了時、手札にある指令カードに対応する覚醒体に[Arg1]狂気を獲得させる。"
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:不均衡な天秤+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "もはや公正の象徴ではない。"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。アクティブダメージを与えた後、すべての敵に[Arg2]点の <IntoxicationIconKeywords:毒> を付与し、毎ターン最大5回まで発動可能。"
  },
  RelicConfig_98423_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。アクティブダメージを与えた後、すべての敵に[Arg2]点の <IntoxicationIconKeywords:毒> を付与し、毎ターン最大5回まで発動可能。"
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:祭司の杖>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "許されない信仰。"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<IntoxicationIconKeywords:毒>を付与した後、カードを[Arg2]枚引く。"
  },
  RelicConfig_98424_Desc = {
    Text = "戦闘開始時、[Arg1]%のダメージ強化を獲得する。毎ターン初めて<IntoxicationIconKeywords:毒>を付与した後、カードを[Arg2]枚引く。"
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:リンド・パピルス>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "では問題です。10人の僧侶で6個のパンを分け合うと、それぞれどのくらい貰えるでしょうか？"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "戦闘開始時、[Arg1]点の<PowerIconKeywords:力> を獲得する。「除外」が付与されたカードを使用するごとに、 [Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大10回まで発動可能。"
  },
  RelicConfig_98425_Desc = {
    Text = "戦闘開始時、[Arg1]点の<PowerIconKeywords:力> を獲得する。「除外」が付与されたカードを使用するごとに、 [Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、毎ターン最大10回まで発動可能。"
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:小さなオルゴール>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "デクスター邸の数あるコレクションの中でも、この小さなオルゴールは、デクスター家の幼いお嬢様のお気に入りの玩具だった。\n時は流れ、彼女が再びそれを見つけた時、歯車は緩み、音色も狂っていたが、それでもなお回転を続けていた。"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕を触発して敵に[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  RelicConfig_98426_Desc = {
    Text = "毎ターン初めて「キーオーダー」を発動した後、すべての触腕を触発して敵に[Arg1]回攻撃させ、50%のダメージを与える。"
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:黄色い小さな貝>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "この小さな黄色いカタツムリは高貴な出自を持ち、完璧で非の打ち所がない。"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "ターン開始時、ライフが50％未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25％未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98427_Desc = {
    Text = "ターン開始時、ライフが50％未満の場合、一時的なダメージ強化+[Arg1]%。ライフが25％未満の場合、追加でカードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:医者の鞄＋>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "医者の象徴である重い手提げ箱。\n開けるのは本物の医者とは限らない。"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "戦闘開始後、5層の「<LostWay:迷子>」を獲得し、3枚の指令カードを発射するごとに1層減少する。\nすべての「<LostWay:迷子>」が除去された後、すべての覚醒体は100の狂気を獲得し、3枚の指令カードを発射するごとに[Arg1]のライフを回復し、前列の敵に敵の最大ライフの1％の<Corrosion:侵蝕>を付与する。"
  },
  RelicConfig_98891_Desc = {
    Text = "戦闘開始後、5層の「<LostWay:迷子>」を獲得し、3枚の指令カードを発射するごとに1層減少する。\nすべての「<LostWay:迷子>」が除去された後、すべての覚醒体は100の狂気を獲得し、3枚の指令カードを発射するごとに[Arg1]のライフを回復し、前列の敵に敵の最大ライフの1％の<Corrosion:侵蝕>を付与する。"
  },
  RelicConfig_98891_Name = {
    Text = "救いの灯"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "いかなる暗黒を経ようとも、救世の灯は死の中で再び燃え続ける。"
  }
})
return Text_RelicConfig
