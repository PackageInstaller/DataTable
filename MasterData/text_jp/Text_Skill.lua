__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Skill = readonly({
  Skill_100224_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  Skill_100224_Name = {
    Text = "創造の遺物「恩恵の血」"
  },
  Skill_100225_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  Skill_100225_Name = {
    Text = "創造の遺物「春の祭り」"
  },
  Skill_100226_Desc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  Skill_100226_Name = {
    Text = "創造の遺物「錆びた鋸」"
  },
  Skill_100227_Desc = {
    Text = "毎ターン初めて「胚胎」を使用した後、このターンに与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_100227_Name = {
    Text = "創造の遺物「血染めの小石」"
  },
  Skill_100228_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。最大15回まで。"
  },
  Skill_100228_Name = {
    Text = "創造の遺物「縞瑪瑙」"
  },
  Skill_100229_Desc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_100229_Name = {
    Text = "創造の遺物「重鎖」"
  },
  Skill_100230_Desc = {
    Text = "「狂気解放」を発動後、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_100230_Name = {
    Text = "創造の遺物「重鎖」"
  },
  Skill_100231_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_100231_Name = {
    Text = "創造の遺物「金色の夢」"
  },
  Skill_100232_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  Skill_100232_Name = {
    Text = "創造の遺物「春の祭り」"
  },
  Skill_100233_Desc = {
    Text = "ライフを失った時、失ったライフの[Arg1]%を猩紅炉に蓄積する。"
  },
  Skill_100233_Name = {
    Text = "創造の遺物「錆びた鋸」"
  },
  Skill_100234_Desc = {
    Text = "ターン終了時、ライフを[Arg1]回復する。"
  },
  Skill_100234_Name = {
    Text = "創造の「恩恵の血」"
  },
  Skill_100235_Desc = {
    Text = "ダメージを与えるたび、[Arg1]点の一時的<PowerIconKeywords:力>を獲得する。最大15回まで。"
  },
  Skill_100235_Name = {
    Text = "創造の遺物「縞瑪瑙」"
  },
  Skill_100236_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが[Arg2]%増加する。"
  },
  Skill_100236_Name = {
    Text = "創造の遺物「悪童」"
  },
  Skill_100237_Desc = {
    Text = "入手時、すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。すべての覚醒体が与える基礎ダメージが [Arg2]％ 増加する。"
  },
  Skill_100237_Name = {
    Text = "創造の遺物「悪童」"
  },
  Skill_100238_Desc = {
    Text = "毎ターン初めて「胚胎」を使用した後、このターンに与えるアクティブダメージは、ダメージの[Arg1]%に等しい<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_100238_Name = {
    Text = "創造の遺物「血染めの小石」"
  },
  Skill_100239_Desc = {
    Text = "毎ターン初めて<DevouredIconKeywords:捕食>した時、他の覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_100239_Name = {
    Text = "創造の遺物「金色の夢」"
  },
  Skill_100304_Desc = {
    Text = "覚醒体を1名選択し、[Arg1]狂気を獲得させ、<DerivativeCardKeywords_4:「啓示」>を1枚山札に追加する。ピックマンがチームいる場合、1点の「<Chuangyi:発想>」を獲得する。"
  },
  Skill_100304_Name = {
    Text = "虚空の色彩"
  },
  Skill_100467_Desc = {
    Text = "10層クリエイティブ"
  },
  Skill_100467_Name = {
    Text = "10層クリエイティブ"
  },
  Skill_100598_Desc = {
    Text = "[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。[Arg2]点の<Undercurrent:暗流>、2本の一時的な触腕を獲得。"
  },
  Skill_100598_Name = {
    Text = "深淵の暗流"
  },
  Skill_100599_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。対象の<IntoxicationIconKeywords:毒>1点につき、ダメージが1増加する。2点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_100599_Name = {
    Text = "狂熱の海"
  },
  Skill_100600_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。対象の<IntoxicationIconKeywords:毒>1点につき、ダメージが1増加する。1点の「<FlickeringCandle:小さな灯火>」を付与。"
  },
  Skill_100600_Name = {
    Text = "狂熱の海"
  },
  Skill_100601_Desc = {
    Text = "敵の「<FlickeringCandle:小さな灯火>」を同量の「<LightOfTheLost:迷航の光>」にアップグレードする。触腕の上限を3本獲得。"
  },
  Skill_100601_Name = {
    Text = "崩壊の執念"
  },
  Skill_100602_Desc = {
    Text = "この行動予測に転換すると、1倍の一時的な触腕を獲得し、<TentacleInjurieIconKeywords:触腕ダメージ>が一時的に50%減少する。<Block:[Block:Arg1]>点のシールドを獲得し、1ターンの間、デバフ状態を無効化する。"
  },
  Skill_100602_Name = {
    Text = "失われた古都"
  },
  Skill_100603_Desc = {
    Text = "この行動予測に転換すると、1倍の一時的な触腕を獲得し、<TentacleInjurieIconKeywords:触腕ダメージ>が一時的に50%減少する。<Block:[Block:Arg1]>点のシールドを獲得し、1ターンの間、デバフ状態を無効化する。"
  },
  Skill_100603_Name = {
    Text = "失われた古都"
  },
  Skill_100604_Desc = {
    Text = "[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。[Arg2]点の<Undercurrent:暗流>、2本の一時的な触腕を獲得。"
  },
  Skill_100604_Name = {
    Text = "深淵の暗流"
  },
  Skill_116332_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドとシールドの10%に等しい一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_116332_Name = {
    Text = "束の間の夢"
  },
  Skill_116513_Desc_1 = {
    Text = "<PVPCapKeywords:行動力上限> +[Arg1]。相手の<PVPCapKeywords:行動力上限> +[Arg2]。"
  },
  Skill_116513_Name_1 = {
    Text = "束の間の夢"
  },
  Skill_116513_UnknownName = {
    Text = "束の間の夢"
  },
  Skill_117171_Desc_1 = {
    Text = "全ての敵に<PVPCorrosionKeywords:罪印>を発動し、等量のダメージのライフを回復。"
  },
  Skill_117171_Name_1 = {
    Text = "光明の道"
  },
  Skill_117172_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_18:「苦痛の根源·知」>、<PVPDerivativeCardKeywords_19:「霊魂の枷·惑」>、<PVPDerivativeCardKeywords_20:「破壊信仰·執」> を各1枚手札に置きます。"
  },
  Skill_117172_Name_1 = {
    Text = "罪なき聖裁"
  },
  Skill_117173_Desc_1 = {
    Text = "敵1体の正面ステータスを解除し、<Damage:[Damage:Arg1]>ダメージを与え、<PVPEntanglementKeywords:纏着>します。全ての敵に<PVPCorrosionKeywords:罪悪>を発動させ、<Damage:[Arg2]>ライフを失わせます。"
  },
  Skill_117173_Name_1 = {
    Text = "信念を破壊する・執"
  },
  Skill_117174_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> の <PVPCorrosionKeywords:罪印> を付与し、<Damage:[Arg2]> ライフを失い、"
  },
  Skill_117174_Name_1 = {
    Text = "聖なる心を冒涜する"
  },
  Skill_117175_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>と<PVPWeaknessKeywords:虚弱>を対象に適用し、<Damage:[Damage:Arg1]>ダメージを与えます。全ての敵に<PVPCorrosionKeywords:罪印>を発動し、<Damage:[Arg2]>ライフを失います。"
  },
  Skill_117175_Name_1 = {
    Text = "魂の枷・惑"
  },
  Skill_117176_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_117176_Name_1 = {Text = "攻撃"},
  Skill_117177_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に [Arg1] <PVPCorrosionKeywords:罪印>を付与し、<Damage:[Damage:Arg1]> ダメージを与える。"
  },
  Skill_117177_Name_1 = {
    Text = "無妄の帰依"
  },
  Skill_117178_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<DisarmKeywords:麻痺>、<PVPMethysisKeywords:中毒>。全体の敵の<PVPCorrosionKeywords:罪印>を発動し、<Damage:[Arg2]> HPを失う。"
  },
  Skill_117178_Name_1 = {
    Text = "苦痛の根源・知"
  },
  Skill_117207_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」前とターン終了時、<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> スタックの<PVPCorrosionKeywords:罪印>を付与する。"
  },
  Skill_117207_Name_1 = {
    Text = "歪んだ騎士詩"
  },
  Skill_117208_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」とターン終了時、狂気が最も高い敵に[Arg1]の<PVPfengsuoKeywords:バーストロック>を与える。"
  },
  Skill_117208_Name_1 = {
    Text = "神子の尊顔"
  },
  Skill_117272_Desc = {
    Text = "すべての手札を捨て、カードを5枚引く。「循環する影」を手札、山札、捨て札に追加する。"
  },
  Skill_117272_Name = {
    Text = "遥か昔の夢"
  },
  Skill_117274_Desc = {
    Text = "<FaxianKeywords:発現>：「追憶」3枚から1枚を選択し、発動する。<Posse:[Arg1]>キーエネルギーを獲得。「除外」と刻印「深海の反響」が付与されたランダムなカードを1枚捨て札に追加する。<RippleKeywords:余波>：すべての覚醒体は5狂気を獲得。"
  },
  Skill_117274_Name = {
    Text = "循環する影"
  },
  Skill_117275_Desc = {
    Text = "<FaxianKeywords:発現>： 「追憶」3枚から1枚を選択し、発動する。<RippleKeywords:余波>：すべての覚醒体が5狂気を獲得。"
  },
  Skill_117275_Name = {
    Text = "循環する影"
  },
  Skill_117276_BattleDesc = {
    Text = "すべての手札を捨て、カードを5枚引く。「循環する影」を手札、山札、捨て札に追加する。[Arg1]回使用可能。"
  },
  Skill_117276_Desc = {
    Text = "すべての手札を捨て、カードを5枚引く。「循環する影」を手札、山札、捨て札に追加する。3回使用可能。"
  },
  Skill_117276_Name = {
    Text = "遥か昔の夢"
  },
  Skill_117277_Desc = {
    Text = "手札から1枚の非派生指令カードを選択し、そのカードがこの戦闘で与えるダメージ、シールド、ライフ回復を[Arg1]％増加させ、次に打ち出すまで行動力消費を0にする。"
  },
  Skill_117277_Name = {
    Text = "未完成の蝋人形"
  },
  Skill_117278_Desc = {
    Text = "<FaxianKeywords:発現>： 「追憶」3枚から1枚を選択し、発動する。<Posse:[Arg1]>キーエネルギーを獲得。<RippleKeywords:余波>：すべての覚醒体が5狂気を獲得。"
  },
  Skill_117278_Name = {
    Text = "循環する影"
  },
  Skill_117301_Desc = {
    Text = "手札から1枚の非派生指令カードを選択し、そのカードの3枚の<DepleteIconKeywords:消耗>を持つ原始コピーをドローデッキにシャッフルする。これらのカードは次に打ち出すまで行動力消費が1減少する。"
  },
  Skill_117301_Name = {
    Text = "豊穣の核"
  },
  Skill_117302_Desc_1 = {
    Text = "行動力消費が最も高い「スキル」を[Arg1]枚引き、<PrepareKeywords:準備2>を付与する。"
  },
  Skill_117302_Name_1 = {
    Text = "泣血の聖心"
  },
  Skill_117302_UnknownName = {
    Text = "泣血の聖心"
  },
  Skill_117312_AwakerSkillBackgroundStory = {
    Text = "かつてジュリエットは言った。世界は汚れており、教会の使命はこの世の罪を洗い流すことである、と。\n彼は神に選ばれた御子であり、数々の試練を乗り越え、聖なる心臓を宿している。\nわずかな祈りを捧げるだけで、敬虔な信徒たちは感謝の涙にむせぶ。\nさあ、その魂を灯芯のごとく燃やし、神の恩恵を与えるのだ。その光の照らすところ、必ずや清らかなる祝福がもたらされよう。"
  },
  Skill_117312_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。最も行動力消費が低い指令カードを2枚引く。"
  },
  Skill_117312_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_117312_Name = {
    Text = "魂を焼き尽くす光"
  },
  Skill_117312_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_117313_AwakerSkillBackgroundStory = {
    Text = "彼が授けた祝福は、同時に漆黒の毒でもあった。"
  },
  Skill_117313_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_117313_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ポリュクスは <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_117313_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_117313_Name = {Text = "攻撃"},
  Skill_117313_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_117314_AwakerSkillBackgroundStory = {
    Text = "彼らには罪がある。その身に流れる黒き神血が、何よりの証拠だ。\n彼らは裁かれねばならない。罪を洗い清めてこそ、浄土に入ることが許される。\nさあ、裁きを下せ。罪を告げ、その血を流させ、罰をその身に与えよ。\nそれこそが御子に与えられし力であり、果たすべき使命なのだ。"
  },
  Skill_117314_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。超次元ターン開始時、自動的に手札に追加される。"
  },
  Skill_117314_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。「聖心」を使用するたび、行動力消費が1減少する。超次元ターン開始時、自動的に手札に追加される。"
  },
  Skill_117314_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_117314_Name = {
    Text = "浄罪の審判"
  },
  Skill_117314_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_117315_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、3点の<ZuiyinKeywords:罪印>を獲得。使用後、山札の一番上に置く。3回目の使用後に<DepleteIconKeywords:除外>し、自身の次の指令カードは「苦痛による贖罪」の效果を獲得する。([Arg2]/3)"
  },
  Skill_117315_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、3点の<ZuiyinKeywords:罪印>を獲得。使用後、山札の一番上に置く。3回目の使用後に<DepleteIconKeywords:除外>され、自身の次の指令カードは「苦痛による贖罪」の効果を獲得し、2回発動する。([Arg2]/3)"
  },
  Skill_117315_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、3点の<ZuiyinKeywords:罪印>を獲得。使用後、山札の一番上に置く。3回目の使用後に<DepleteIconKeywords:除外>し、自身の次の指令カードは「苦痛による贖罪」の效果を獲得する。"
  },
  Skill_117315_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、3点の<ZuiyinKeywords:罪印>を獲得。使用後、山札の一番上に置く。3回目の使用後に<DepleteIconKeywords:除外>され、自身の次の指令カードは「苦痛による贖罪」の効果を獲得し、2回発動する。"
  },
  Skill_117315_Name = {Text = "聖心"},
  Skill_117315_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、<ZuiyinKeywords:罪印>を3スタック獲得する。発射後、このカードをドロー山の一番上にシャッフルする。3回目の発射時に<DepleteIconKeywords:消費>し、自身の次の指令カードに「苦痛の救済」効果を付与する([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点ダメージ，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入ドローデッキ顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、[Arg3]％の出血を付与し、<ZuiyinKeywords:罪印>を3スタック獲得する。発射後、このカードをドロー山の一番上にシャッフルする。3回目の発射時に<DepleteIconKeywords:消費>し、自身の次の指令カードに「苦痛の救済」効果を付与する([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_4 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]％の出血を付与する。3層の<ZuiyinKeywords:罪印>を獲得。使用後、山札の一番上に戻す。3回目の使用後に<DepleteIconKeywords:除外>され、自身の次の指令カードは「苦痛による贖罪」の効果を獲得し、2回発動する([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_5 = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを与え、[Arg3]％の出血を付与し、<ZuiyinKeywords:罪印>を3層獲得する。使用後このカードをドローパイルの上に戻し、このターンの演算力消費が0になり、100％ダメージ分の<BleedingIconKeywords:出血>を付与する。3回目に使用した時<DepleteIconKeywords:消耗>し、自身の次の指令カードに「苦痛救済」効果を付与し2回発動する（[Arg2]/3）。"
  },
  Skill_117316_AwakerSkillBackgroundStory = {
    Text = "この光明なる心は、あらゆる悪から彼を守るだろう。"
  },
  Skill_117316_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_117316_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ポリュクスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_117316_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_117316_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_117317_AwakerSkillBackgroundStory = {
    Text = "「ポリュクス、あなたの聖心は灯明者の輝きを宿している。かの御方を敬うのと同じように、この栄誉を大切にしなさい」\nこうして彼は、虚無の冠を頭に戴き、一瞬たりとも気を抜くことはなかった。\n「ポリュクス、怖がらなくていい。自由の味を、その身で確かめるんだ……」\n彼はその栄誉によってすべてを手に入れ、栄誉によってすべてを失った。そして、この冠がただの見えない枷に過ぎないことに気がついた。\n彼は王冠をかなぐり捨て、そのとき初めて、虚ろな心臓は白昼のごとき光を放った。だが、その怒りに満ちた慟哭はもはや、もう一人の半身の耳に届くことはなかった。"
  },
  Skill_117317_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。このターン、自身の次の指令カードは「苦痛による贖罪」の効果を獲得する。<DerivativeCardKeywords_118:「聖心」>を1枚手札に追加する。"
  },
  Skill_117317_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_117317_Name = {
    Text = "罪なき聖裁"
  },
  Skill_117317_OverLimitUtlSkillDesc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。このターン、自身の次の指令カードは「苦痛による贖罪」の効果を獲得する。<DerivativeCardKeywords_118:「聖心」>を2枚手札に追加する。このターン、ポリュクスが使用する指令カードは追加で50％分の「苦痛による贖罪」の効果を獲得し、自身の次の指令カードは追加で1回発動する。"
  },
  Skill_117317_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_117318_AwakerSkillBackgroundStory = {
    Text = "かつて彼の目は陰りに閉ざされ、暗闇を白昼のように見ていた。\nだが、世界の真実を目の当たりにした今、彼は踵を返し、逆の道へと足を踏み出した。\nいかなる時も、彼は常に光に向かって進み続けている。"
  },
  Skill_117318_Desc_0 = {
    Text = "ポリュクスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：使用時と捨て札フェイズ後に3層の<ZuiyinKeywords:罪印>を獲得。手札1枚につき、追加で1層の<ZuiyinKeywords:罪印>を獲得。「聖心」はダメージの100%の出血を与える。"
  },
  Skill_117318_Desc_15 = {
    Text = "ポリュクスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：使用時と捨て札フェイズ後に3層の<ZuiyinKeywords:罪印>を獲得。手札1枚につき、追加で1層の<ZuiyinKeywords:罪印>を獲得。「聖心」はダメージの100%の出血を与える。使用後に山札に戻った場合、その「聖心」はこのターンの行動力消費が0になり、ダメージの100％の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_117318_EffectNameList = {Text = "狂気"},
  Skill_117318_Name = {
    Text = "浄化の道"
  },
  Skill_117494_Desc_1 = {
    Text = "狂気を取り除く"
  },
  Skill_117494_Name_1 = {
    Text = "狂気を取り除く"
  },
  Skill_117740_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> <PVPCorrosionKeywords:罪印>を発動する。"
  },
  Skill_117740_Name_1 = {
    Text = "罪印テスト"
  },
  Skill_117757_Desc = {
    Text = "1枚のカードを引き、行動力消費を1減少させる。指令カードを引いた場合、その所有者は[Arg1]％の一時的にクリティカルダメージが増加する。ポリュクスがチームにいる場合、[Arg2]層の<ZuiyinKeywords:罪印>を獲得する。"
  },
  Skill_117757_Name = {
    Text = "泣血の聖心"
  },
  Skill_117861_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。同量の<BleedingIconKeywords:出血>とダメージの10%の<IntoxicationColour:毒>を付与する。"
  },
  Skill_117861_Name = {
    Text = "穢れた血"
  },
  Skill_117862_Desc = {
    Text = "[Arg1]点の<SacrificeKeyWord:献上>と1点の<EmptinessKeywords:虚無>を付与する。"
  },
  Skill_117862_Name = {
    Text = "深淵の宣告"
  },
  Skill_117863_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_117863_Name = {
    Text = "振り下ろす"
  },
  Skill_118055_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にブロックされなかった場合、[Arg3]点の「相互契約：深海の増殖体」を獲得する。"
  },
  Skill_118055_Name = {
    Text = "提灯の光"
  },
  Skill_118056_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1点の<HeavyInjuryKeywords:重傷>を付与する。プレイヤーのシールド1点につきダメージが1減少する。"
  },
  Skill_118056_Name = {
    Text = "霊知汚染"
  },
  Skill_118057_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の重傷を付与する。プレイヤーのシールド1点につきダメージが1減少する。"
  },
  Skill_118057_Name = {
    Text = "痛烈な一撃"
  },
  Skill_118058_Desc = {
    Text = "この行動予測に転換すると、1点の<Flaw:破綻>を獲得する。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。敵に[Arg3]点の<BirthRitual:誕生の儀>を付与し、<FatePact:命契>1点につき1点増加する。"
  },
  Skill_118058_Name = {
    Text = "永劫輪廻の天幕"
  },
  Skill_118059_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<RetaliateIconKeywords:一時的な反撃>を獲得する。プレイヤーの残り手札1枚につき、[Arg4]点の<RetaliateIconKeywords:一時的な反撃>を獲得する。"
  },
  Skill_118059_Name = {
    Text = "怨恨と復讐"
  },
  Skill_118060_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える(触腕2本ごとにダメージ回数が1回増加)。[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、自身のデバフ状態を解除する。"
  },
  Skill_118060_Name = {
    Text = "ルルイエの逆流"
  },
  Skill_118061_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ターン終了前の手札1枚ごとに攻撃回数が1減少する。最低3回。"
  },
  Skill_118061_Name = {
    Text = "魂を喰らう蛇"
  },
  Skill_118062_Desc = {
    Text = "前列に「リモリアの覚醒体」を1体召喚する。"
  },
  Skill_118062_Name = {
    Text = "選ばれし者"
  },
  Skill_118063_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<DerivativeCardKeywords_3:「痙攣」>を[Arg3]枚山札に追加する。"
  },
  Skill_118063_Name = {
    Text = "至高の生贄"
  },
  Skill_118064_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の「相互契約：深海の増殖体」を獲得。"
  },
  Skill_118064_Name = {
    Text = "光「信仰の結集」"
  },
  Skill_118065_Desc = {
    Text = "この行動予測に転換すると、現在の触腕数と同数の一時的な触腕を獲得する。<Block:[Block:Arg1]>点のシールドを獲得。<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_118065_Name = {
    Text = "自由の誓い"
  },
  Skill_118066_Desc = {
    Text = "「呼び声」が追加効果を獲得：5点で即座にすべての覚醒体を封印する。"
  },
  Skill_118066_Name = {Text = "覚醒"},
  Skill_118068_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_118068_Name = {
    Text = "噛みつく"
  },
  Skill_118070_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージを与えるたびに、1点の<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<Decay:腐朽>を順に付与する。"
  },
  Skill_118070_Name = {
    Text = "楽園再始動"
  },
  Skill_118071_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1点の<Decay:腐朽>を付与する。ターン開始時、「聖象の祝福」を1枚選択し、「呪い」に反転させる。"
  },
  Skill_118071_Name = {
    Text = "「幕を開く」"
  },
  Skill_118072_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[TentaclePower:Arg3]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。"
  },
  Skill_118072_Name = {Text = "攻撃"},
  Skill_118074_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>と[Arg3]点の<Undercurrent:暗流>を獲得。"
  },
  Skill_118074_Name = {
    Text = "触腕の壁"
  },
  Skill_118076_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<Decay:腐朽>を付与。"
  },
  Skill_118076_Name = {
    Text = "なぎ払う"
  },
  Skill_118077_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にブロックされなかった場合、[Arg3]点の「相互契約：深海の増殖体」を獲得する。"
  },
  Skill_118077_Name = {
    Text = "提灯の光"
  },
  Skill_118078_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、最も狂気の多い覚醒体を1ターン封印する。"
  },
  Skill_118078_Name = {Text = "神の刃"},
  Skill_118080_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与え、プレイヤーの保持している手札をすべて捨てる。ブロックされなかったダメージを与えるたび、<DerivativeCardKeywords_37:窒息>を[Arg3]枚山札の一番上に追加する。"
  },
  Skill_118080_Name = {Text = "絞殺"},
  Skill_118083_Desc = {
    Text = "<Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg2]回与え、追加でプレイヤーの現在のライフの50%のダメージ(<Damage:[Damage:Arg4]>)を与える。[Arg5]点の<Decay:腐朽>を付与する。"
  },
  Skill_118083_Name = {
    Text = "腐骨の重撃"
  },
  Skill_118084_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。「呼び声」1点につきシールドが<Block:[Block:Arg4]>点増加する。"
  },
  Skill_118084_Name = {Text = "試み"},
  Skill_118086_Desc = {
    Text = "この行動予測に転換すると、[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。対象のライフが50%未満の場合、[Arg2]点の<Decay:腐朽>を付与し、そうでない場合は[Arg3]点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_118086_Name = {
    Text = "乞霊の呪文"
  },
  Skill_118087_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールド、[Arg2]点の<SacrificeKeyWord:献上>と[TentaclePower:Arg3]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。"
  },
  Skill_118087_Name = {
    Text = "聖女創造"
  },
  Skill_118090_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ダメージを1回与えるたび、一時的な触腕を1本獲得する。ターン終了前の手札1枚ごとに攻撃回数が1減少する。最低3回。"
  },
  Skill_118091_Desc = {
    Text = "[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、触腕の上限が1増加する。自身は[Arg2]点の<SacrificeKeyWord:献上>を受ける。"
  },
  Skill_118091_Name = {
    Text = "深海の聖歌"
  },
  Skill_118092_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<ResentChainsKeywords:怨恨の鎖>を獲得する。<Abyssallock:夢の束縛>を1点失うごとに、獲得する<ResentChainsKeywords:怨恨の鎖>が1点増加し、ダメージが<Damage:[Damage:Arg4]>増加する。"
  },
  Skill_118092_Name = {
    Text = "永遠の牢獄"
  },
  Skill_118093_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、ドロー山と捨て札の [Arg3] 枚のランダムなカードに<SeastriderCurse:蹈海者の呪怨>を付与する。"
  },
  Skill_118093_Name = {
    Text = "提灯の光"
  },
  Skill_118094_Desc = {
    Text = "[Arg1]点の「血の誓い」と[Arg2]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_118094_Name = {
    Text = "燃え尽きた灯芯"
  },
  Skill_118095_Desc = {
    Text = "この行動予測に転換すると、現在の触腕数と同量の一時的な触腕を獲得。<Block:[Block:Arg1]>点のシールドを獲得する。 <Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_118095_Name = {
    Text = "虚妄の継承者"
  },
  Skill_118096_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、 [Arg3]点の<HeavyInjuryKeywords:重傷>を付与する。プレイヤーのシールド1点につきダメージが1減少する。"
  },
  Skill_118096_Name = {
    Text = "罪の鞭打ち"
  },
  Skill_118097_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。この行動予測に転換すると、[Arg3]点の一時的な<Abyssallock2:夢の束縛>を獲得する。ターン終了時、手札にある<SlowIconKeywords:遅延>カード1枚ごとに、追加でダメージを1回与える。"
  },
  Skill_118097_Name = {
    Text = "「安らぎの浄土」"
  },
  Skill_118099_Desc = {
    Text = "[Arg1]点の「血の誓い」と[Arg2]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_118099_Name = {
    Text = "燃え尽きた灯芯"
  },
  Skill_118100_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<Decay:腐朽>を付与。"
  },
  Skill_118100_Name = {
    Text = "なぎ払う"
  },
  Skill_118101_Desc = {
    Text = "<Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg2]回与え、追加でプレイヤーの現在のライフの25%のダメージ(<Damage:[Damage:Arg4]>)を与える。同量の<BleedingIconKeywords:出血>と[Arg5]点の<Decay:腐朽>を付与する。"
  },
  Skill_118101_Name = {
    Text = "腐骨の重撃"
  },
  Skill_118102_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「血の誓い」2点ごとに、一時的な触腕を1本獲得する。"
  },
  Skill_118102_Name = {
    Text = "深海の助祭"
  },
  Skill_118103_Desc = {
    Text = "[Arg1]点の「血の誓い」と[Arg2]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_118103_Name = {
    Text = "燃え尽きた灯芯"
  },
  Skill_118104_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、すべての覚醒体を1ターン「封印」する。2点の<MutualAid1:相互契約：リモリア>を獲得する。"
  },
  Skill_118104_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_118105_Desc = {
    Text = "敵に[Arg1]点の<BirthRitual:誕生の儀>を付与する。[Arg2]点の<FatePact:命契>を獲得し、1点の<VulnerabilityIconKeywords:易傷>を獲得する。"
  },
  Skill_118105_Name = {
    Text = "ルルイエ円舞"
  },
  Skill_118106_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。触腕の上限が[Arg3]増加し、触腕を[Arg3]本獲得。[TentaclePower:Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。[Arg5]点の<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_118106_Name = {
    Text = "「神国の幻像」"
  },
  Skill_118107_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「血の誓い」2点ごとに、一時的な触腕を1本獲得する。"
  },
  Skill_118107_Name = {
    Text = "罪の鞭打ち"
  },
  Skill_118108_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<RetaliateIconKeywords:一時的な反撃>を獲得する。プレイヤーの残り手札1枚につき、[Arg4]点の<RetaliateIconKeywords:一時的な反撃>を獲得する。"
  },
  Skill_118108_Name = {
    Text = "怨恨と復讐"
  },
  Skill_118109_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。敵のライフが低いほどダメージが増加する。最大<Damage:[Damage:Arg4]>ダメージ。"
  },
  Skill_118109_Name = {
    Text = "ブルーリングの毒素"
  },
  Skill_118648_Desc = {
    Text = "[Arg2] 層の<IntoxicationIconKeywords:ポイズン>を付与。まだ他の敵が存在する場合、犠牲になり寄生し、「寄生された」ステータスを付与。"
  },
  Skill_118767_Desc = {
    Text = "<Damage:[Damage:Arg3]>刺突ダメージを[AttackTimes:Arg2]回与え、追加でプレイヤーの現在のライフの50%の刺突ダメージ(<Damage:[Damage:Arg4]>)を与える。同量の<BleedingIconKeywords:出血>と[Arg5]点の<Decay:腐朽>を付与する。"
  },
  Skill_118767_Name = {
    Text = "腐骨「<PunctureDamagewords:刺突>」"
  },
  Skill_118929_Desc = {
    Text = "触腕を2本獲得し、触腕の上限が2増加する。"
  },
  Skill_118929_Name = {
    Text = "造られし物"
  },
  Skill_118974_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える(触腕2本ごとにダメージ回数が1回増加)。[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、自身のデバフ状態を解除する。"
  },
  Skill_118974_Name = {
    Text = "ルルイエの逆流"
  },
  Skill_118975_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールド、[Arg2]点の<SacrificeKeyWord:献上>と[TentaclePower:Arg3]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。"
  },
  Skill_118975_Name = {
    Text = "聖女創造"
  },
  Skill_119040_Desc_1 = {
    Text = "ランダムな味方の「打撃」を[Arg1]枚シャッフルしてドロー山に追加し、「打撃」を[Arg2]枚引く。"
  },
  Skill_119040_Name_1 = {
    Text = "霧境より"
  },
  Skill_119040_UnknownName = {
    Text = "霧境より"
  },
  Skill_119041_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：全体の味方の「攻撃」のダメージが[Arg1]%増加する。"
  },
  Skill_119041_Name_1 = {
    Text = "理性の灯"
  },
  Skill_119042_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[Arg1]%増加し、任意の味方が「攻撃」を使用した後に[Arg3]枚のカードを引く。毎ターン最大[Arg2]回発動する。"
  },
  Skill_119042_Name_1 = {
    Text = "終末まで蹂躙"
  },
  Skill_119043_Desc_1 = {
    Text = "合計[Arg1]<PVPSacrificeKeyWords:犠牲>を与え、すべての敵に均等に分配する。"
  },
  Skill_119043_Name_1 = {
    Text = "彷徨う船"
  },
  Skill_119043_UnknownName = {
    Text = "彷徨う船"
  },
  Skill_119044_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、犠牲が最も少ない敵に [Arg1] の<PVPSacrificeKeyWords:犠牲>を付与し、[Arg2] 回繰り返す。味方全体は<PVPCapKeywords:行動力上限>減少効果の影響を受けなくなる。"
  },
  Skill_119044_Name_1 = {
    Text = "暗闇の中の安眠"
  },
  Skill_119045_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、全ての敵は本回合の主动ダメージを受けた後、ダメージの[Arg1]%の<PVPSacrificeKeyWords:犠牲>を得ます。"
  },
  Skill_119045_Name_1 = {
    Text = "ブルーリングの毒素"
  },
  Skill_119088_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<WeaknessIconKeywords:虚弱> を付与し、<Block:[Block:Arg3]>点のシールドを獲得する。「呼び声」1点につきシールドが<Block:[Block:Arg4]>点増加する。"
  },
  Skill_119088_Name = {Text = "試み"},
  Skill_119089_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、狂気が最も多い覚醒体を 1 ターン封印する。山札のランダムな指令カード[Arg3]枚に1点の <SlowIconKeywords:遅延> を付与する。"
  },
  Skill_119089_Name = {Text = "神の刃"},
  Skill_119090_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ランダムな症状カードを[Arg3]枚山札に追加する。"
  },
  Skill_119090_Name = {
    Text = "至高の生贄"
  },
  Skill_119091_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、すべての覚醒体を1ターン「封印」する。2点の<MutualAid1:相互契約：リモリア>を獲得する。"
  },
  Skill_119091_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_119092_Desc = {
    Text = "失ったライフの10%を回復し、「呼び声」1点につき回復量が20%増加する。「リモリアの覚醒体」を1体前列に召喚する。"
  },
  Skill_119092_Name = {
    Text = "選ばれし者"
  },
  Skill_119110_Desc = {
    Text = "[Arg1]点の<SacrificeKeyWord:献上>を付与する。ターン開始時に[Arg2]点の<FatePact:命契>を獲得する。"
  },
  Skill_119110_Name = {
    Text = "運命の分かれ道"
  },
  Skill_119113_Desc_1 = {
    Text = "自身を <StrengthenKeywords:強化> し、<Energy:[Energy:Arg1]> 狂気を獲得する。"
  },
  Skill_119113_Name_1 = {
    Text = "逆境の狂気"
  },
  Skill_119114_BattleDesc_1 = {
    Text = "自身のデバフを解除し、全体の敵に[Arg2]回 <Damage:[Damage:Arg1]> ダメージを与える。死亡した味方1体につき追加で1回ダメージを与える。"
  },
  Skill_119114_Desc_1 = {
    Text = "自身のデバフを解除し、全体の敵に1回 <Damage:[Damage:Arg1]> ダメージを与える。死亡した味方1体につき追加で1回ダメージを与える。"
  },
  Skill_119114_Name_1 = {
    Text = "シャイニング☆トルネード"
  },
  Skill_119115_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>の<PVPBleedingKeywords:出血>を与える。「攻撃」を1枚使用するごとに、行動力消費が-1される。"
  },
  Skill_119115_Name_1 = {
    Text = "破壊の裂傷"
  },
  Skill_119116_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_119116_Name_1 = {Text = "攻撃"},
  Skill_119118_Desc_1 = {
    Text = "ランダムに [Arg1] 回 <Damage:[Damage:Arg2]> ダメージを与え、同数の<PVPBleedingKeywords:出血>を発動し、同時に「打撃」として扱う。"
  },
  Skill_119118_Name_1 = {
    Text = "霧を破る強襲"
  },
  Skill_119313_Desc = {
    Text = "追加で3枚のライフバーを獲得し、最大ライフが250%増加する。最大ライフの10%の「古の残り火」を獲得する。触腕の上限が5増加し、「触手集結」を獲得する。"
  },
  Skill_119313_Name = {
    Text = "海の輪廻"
  },
  Skill_119334_BattleDesc = {
    Text = "2000キーエネルギーを獲得。自身の<SacrificeKeyWord:献上>をすべて解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119334_Desc = {
    Text = "2000キーエネルギーを獲得。自身の<SacrificeKeyWord:献上>をすべて解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119334_Name = {
    Text = "幻想的な儀式"
  },
  Skill_119335_BattleDesc = {
    Text = "儀式目標：「防御」を4枚使用する。\n儀式報酬：失ったライフの50%を回復。すべての<SacrificeKeyWord:献祭>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119335_Desc = {
    Text = "儀式目標：「防御」を4枚使用する。\n儀式報酬：失ったライフの50%を回復。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119335_Name = {
    Text = "素朴な儀式"
  },
  Skill_119336_BattleDesc = {
    Text = "儀式目標：「狂気解放」を4回発動する([Arg1]/4)。\n儀式報酬：すべての覚醒体が<Energy:30>狂気を獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119336_Desc = {
    Text = "儀式目標：「狂気解放」を4回発動する。\n儀式報酬：すべての覚醒体が<Energy:30>狂気を獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119336_Name = {
    Text = "自由な儀式"
  },
  Skill_119337_BattleDesc = {
    Text = "儀式目標：「狂気解放」を4回発動する。\n儀式報酬：すべての覚醒体が<Energy:30>狂気を獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフ5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119337_Desc = {
    Text = "儀式目標：「狂気解放」を4回発動する。\n儀式報酬：すべての覚醒体が<Energy:30>狂気を獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119337_Name = {
    Text = "自由な儀式"
  },
  Skill_119338_BattleDesc = {
    Text = "失ったライフの50%を回復。自身の<SacrificeKeyWord:献上>をすべて解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119338_Desc = {
    Text = "失ったライフの50%を回復。自身の<SacrificeKeyWord:献上>をすべて解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119338_Name = {
    Text = "素朴な儀式"
  },
  Skill_119339_BattleDesc = {
    Text = "儀式目標：「キーオーダー」を3回発動する([Arg1]/3)。\n儀式報酬：2000キーエネルギーを獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119339_Desc = {
    Text = "儀式目標：「キーオーダー」を3回発動する。\n儀式報酬：2000キーエネルギーを獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119339_Name = {
    Text = "幻想的な儀式"
  },
  Skill_119340_BattleDesc = {
    Text = "すべての覚醒体が<Energy:30>狂気を獲得。自身の<SacrificeKeyWord:献上>をすべて解除、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119340_Desc = {
    Text = "すべての覚醒体が<Energy:30>狂気を獲得。自身の<SacrificeKeyWord:献上>をすべて解除、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119340_Name = {
    Text = "自由な儀式"
  },
  Skill_119341_BattleDesc = {
    Text = "儀式目標：「防御」を4枚使用する([Arg1]/4)。\n儀式報酬：失ったライフの50%を回復。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119341_Desc = {
    Text = "儀式目標：「防御」を4枚使用する。\n儀式報酬：失ったライフの50%を回復。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119341_Name = {
    Text = "素朴な儀式"
  },
  Skill_119342_Desc = {
    Text = "献上の儀式を1つ選択する。それぞれ1回のみ選択可能。"
  },
  Skill_119342_Name = {
    Text = "神に捧ぐ"
  },
  Skill_119343_BattleDesc = {
    Text = "儀式目標：「キーオーダー」を3回発動する。\n儀式報酬：2000キーエネルギーを獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%の<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119343_Desc = {
    Text = "儀式目標：「キーオーダー」を3回発動する。\n儀式報酬：2000キーエネルギーを獲得。すべての<SacrificeKeyWord:献上>を解除し、すべての敵に最大ライフの5%<SacrificeKeyWord:献上>を付与する。"
  },
  Skill_119343_Name = {
    Text = "幻想的な儀式"
  },
  Skill_119574_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」前、「スキル」前、「狂気解放」前に一時的に<StrongEffectKeywords:特効> +[Arg1]、各効果は毎ターン1回のみ発動できます。"
  },
  Skill_119574_Name_1 = {
    Text = "再び会う運命"
  },
  Skill_119712_BattleDesc = {
    Text = "「<DerivativeCardKeywords_122:聖像の祝福：知恵の夢>」を失う。即座にすべての覚醒体が狂気の50%を失い、すべての覚醒体が獲得する狂気が50%減少する。"
  },
  Skill_119712_Desc = {
    Text = "「<DerivativeCardKeywords_122:聖像の祝福：知恵の夢>」を失う。即座にすべての覚醒体が狂気の50%を失い、すべての覚醒体が獲得する狂気が50%減少する。"
  },
  Skill_119712_Name = {
    Text = "聖像の呪い：愚者の嘆き"
  },
  Skill_119713_BattleDesc = {
    Text = "使用後、このターンは「聖像の呪い」の効果を受けず、すべてのダメージを無効化する。敵の「古の残り火」の効果が永久に倍増する。"
  },
  Skill_119713_Desc = {
    Text = "使用後、このターンは「聖像の呪い」の効果を受けず、すべてのダメージを無効化する。敵の「古の残り火」の効果が永久に倍増する。"
  },
  Skill_119713_Name = {
    Text = "銀の鍵が道を照らさんことを"
  },
  Skill_119714_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。触腕の上限が[Arg3]増加し、触腕を[Arg3]本獲得。[TentaclePower:Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得する。[Arg5]点の<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_119714_Name = {
    Text = "「神国の幻像・終焉」"
  },
  Skill_119715_BattleDesc = {
    Text = "毎ターン開始時、最大ライフの5%の<PowerIconKeywords:力>を獲得し、一時的なクリティカル率+25%。"
  },
  Skill_119715_Desc = {
    Text = "毎ターン開始時、最大ライフの5%の<PowerIconKeywords:力>を獲得し、一時的なクリティカル率+25%。"
  },
  Skill_119715_Name = {
    Text = "聖像の祝福：神威の夢"
  },
  Skill_119716_BattleDesc = {
    Text = "毎ターン開始時、失ったライフの15%を回復する。"
  },
  Skill_119716_Desc = {
    Text = "毎ターン開始時、失ったライフの15%を回復する。"
  },
  Skill_119716_Name = {
    Text = "聖像の祝福：永遠の夢"
  },
  Skill_119717_BattleDesc = {
    Text = "「<DerivativeCardKeywords_120:聖像の祝福：永遠の夢>」を失う。即座に最大ライフの50%を失い、すべての覚醒体のライフ回復効果が50%減少する。"
  },
  Skill_119717_Desc = {
    Text = "「<DerivativeCardKeywords_120:聖像の祝福：永遠の夢>」を失う。即座に最大ライフの50%を失い、すべての覚醒体のライフ回復効果が50%減少する。"
  },
  Skill_119717_Name = {
    Text = "聖像の呪い：破滅の恨み"
  },
  Skill_119718_BattleDesc = {
    Text = "毎ターン開始時、すべての覚醒体が<Energy:10>狂気を獲得する。"
  },
  Skill_119718_Desc = {
    Text = "毎ターン開始時、すべての覚醒体が<Energy:10>狂気を獲得する。"
  },
  Skill_119718_Name = {
    Text = "聖像の祝福：知恵の夢"
  },
  Skill_119719_BattleDesc = {
    Text = "「<DerivativeCardKeywords_121:聖像の祝福：神威の夢>」を失う。即座に力の50%を失い、すべての覚醒体の力獲得効果が50%減少する。"
  },
  Skill_119719_Desc = {
    Text = "「<DerivativeCardKeywords_121:聖像の祝福：神威の夢>」を失う。即座に力の50%を失い、すべての覚醒体の力獲得効果が50%減少する。"
  },
  Skill_119719_Name = {
    Text = "聖像の呪い：衰亡の哀しみ"
  },
  Skill_119762_AwakerSkillBackgroundStory = {
    Text = "神母の指示に逆らうことは許されない。"
  },
  Skill_119762_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_119762_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点ダメージ。获得 <Energy:[Energy:Arg2]> 点狂気。抽 1 张「深海の聖歌」，每回合最多生效 1 次( [Arg3]/1 )。"
  },
  Skill_119762_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。誕妄・マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_119762_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。誕妄・マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。「深海の聖歌」を1枚引く。毎ターン最大1回まで発動。"
  },
  Skill_119762_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_119762_Name = {Text = "攻撃"},
  Skill_119762_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_119763_AwakerSkillBackgroundStory = {
    Text = "彼女は傲慢だ。その傲慢さで、埋めようのない心の虚無を覆い隠している。\n彼女は忘れてしまったのだ。かつて自分が何者であったのか、そして何者であるべきだったのかを。\n無数の海踊人たちが、足元にひれ伏す。だが彼女は、その崇敬の声の中で、最も大切なことを忘れてしまった——彼女自身がすでに、この空虚な運命に服従しているということを。"
  },
  Skill_119763_BattleDesc = {
    Text = "2点の行動力を獲得し、カードを2枚引く。次のターンの開始時、[Arg3]点の<SacrificeKeyWord:献上>を受ける。<RippleKeywords:余波>： [Arg4]点の<SacrificeKeyWord:献上>を除去。"
  },
  Skill_119763_Desc = {
    Text = "2点の行動力を獲得し、カードを2枚引く。次のターン開始時、最大ライフの[Arg1]%の<SacrificeKeyWord:献上>を受ける。<RippleKeywords:余波>：最大ライフの[Float:Arg2]%の<SacrificeKeyWord:献上>を除去。"
  },
  Skill_119763_EffectNameList = {
    Text = "除去「献上」割合"
  },
  Skill_119763_Name = {
    Text = "深海の聖歌"
  },
  Skill_119764_AwakerSkillBackgroundStory = {
    Text = "マーフィーの手にある象牙の像、その由来には様々な噂がある。\nある者は、マーフィーが探索を指示した海底遺跡で発見されたと言い、またある者は、「聖なる赤子」とともに、彼女の胸腔から生まれ落ちたのだと語る。\nだが、ひとつだけ確かなことがある。それは、この像が、光の届かぬ海底に沈む「ルルイエの城」と彼女の深いつながりを示すものであり、マーフィーが「真なる神母」となったその日に、海踊人たちの前に現れたという事実だ。\nその後、信徒たちは、マーフィーがこの象牙の像を用いて嵐を退け、血の海を切り開くさまを目の当たりにすることとなる。\n絶対的な権力とは、往々にして虚ろな象徴にとどまるものではない。人は、絶対的な力の権威の下にのみ、屈するようにできているのだ。"
  },
  Skill_119764_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、次のターンの開始時、[Arg7]点の<SacrificeKeyWord:献上>を受ける。すべての敵に[Arg3]点の<DwmofeiKeywords:誕生の儀>を付与する。ライフが最も高い敵に<Damage:[Damage:Arg5]>ダメージを[Arg4]回与え、[Arg6]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。"
  },
  Skill_119764_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、次のターン開始時、最大ライフ[Arg2]%分の<SacrificeKeyWord:献上>を受ける。すべての敵に[Arg3]点の<DwmofeiKeywords:誕生の儀>を付与する。ライフが最も高い敵に<Damage:[Damage:Arg5]>ダメージを[Arg4]回与え、[Arg6]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。"
  },
  Skill_119764_EffectNameList = {
    Text = "シールド、誕生の儀、ダメージ、触腕ダメージボーナス"
  },
  Skill_119764_Name = {
    Text = "虚妄の王女"
  },
  Skill_119764_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。次のターン開始時、[Arg7]点の<SacrificeKeyWord:献上>を受ける。すべての敵に[Arg8]点の<DwmofeiKeywords:誕生の儀>を付与する。ライフが最も高い敵に<Damage:[Damage:Arg5]>ダメージを[Arg4]回与え、[Arg6]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。<DepleteIconKeywords:除外>と<PrepareKeypvewords1:準備1>が付与された行動力消費2の「ルルイエ円舞」を3枚手札に追加。"
  },
  Skill_119764_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3,$GrowValue4％"
  },
  Skill_119765_AwakerSkillBackgroundStory = {
    Text = "彼女は軽薄だ。その軽薄さで、崩壊した現実に抗っている。\nさあ、踊りましょう、と彼女は言う。神に捧げる舞を。\n倒錯した因果、歪んだ過去、そして予測不能な未来を授けた神に、感謝を捧げましょう。\nスポットライトの下、彼女はすべてにして、唯一の焦点となる。"
  },
  Skill_119765_BattleDesc = {
    Text = "<Posse:[Arg7]>キーエネルギーを獲得。触腕の姿勢に応じた効果を獲得する。「潮流」：<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]、触腕を1本獲得。「静海」：<Block:[Block:Arg2]>点のシールドを獲得し、シールドの50%を次のターンまで保持する。「怒涛」：ライフが最も高い敵に<Damage:[Damage:Arg4]>ダメージを[Arg3]回与え、[Arg5]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得。"
  },
  Skill_119765_Desc = {
    Text = "キーチャージの[Arg6]%のキーエネルギーを獲得。触腕の姿勢に応じた効果を獲得する。「潮流」：<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg8]、触腕を1本獲得。「静海」：<Block:[Block:Arg9]>点のシールドを獲得し、シールドの50%を次のターンまで保持する。「怒涛」：ライフが最も高い敵に<Damage:[Damage:Arg4]>ダメージを[Arg3]回与え、[Arg5]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得。"
  },
  Skill_119765_EffectNameList = {
    Text = "触腕ダメージ、シールド、ダメージ、触腕ダメージボーナス、キーチャージ効率"
  },
  Skill_119765_Name = {
    Text = "ルルイエ円舞"
  },
  Skill_119765_PropertyNameList = {
    Text = "攻撃力×GrowValue1、防御力×GrowValue2、攻撃力×GrowValue3、$GrowValue4％、$GrowValue5％"
  },
  Skill_119766_AwakerSkillBackgroundStory = {
    Text = "彼女は神の臍帯血を海に滴らせ、終わりのない航路を願った。夢の泡沫が消えぬ限り、彼女は唯一の神母として在り続ける。"
  },
  Skill_119766_Desc_0 = {
    Text = "誕想・マーフィーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：誕妄・マーフィーが与えるダメージは[Arg2]%の<SacrificeKeyWord:献上>を付与する。ターン開始時、1点の<MingqiKeywords:命契>を獲得。"
  },
  Skill_119766_Desc_15 = {
    Text = "誕妄·マーフィーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：誕妄・マーフィーが与えるダメージは[Arg2]%の<SacrificeKeyWord:献上>を付与する。2点の<MingqiKeywords:命契>を獲得。ターン開始時、1点の<MingqiKeywords:命契>を獲得。ターン終了時に「潮湧」姿態の場合、追加で1点の<MingqiKeywords:命契>を獲得。"
  },
  Skill_119766_EffectNameList = {
    Text = "狂気、「献上」比率"
  },
  Skill_119766_Name = {
    Text = "海祭の儀"
  },
  Skill_119767_AwakerSkillBackgroundStory = {
    Text = "神母の言動を批判することは許されない。"
  },
  Skill_119767_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_119767_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。「深海の聖歌」を1枚引く。毎ターン最大1回まで発動( [Arg3]/1 )。"
  },
  Skill_119767_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。誕妄・マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_119767_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。誕妄・マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。「深海の聖歌」を1枚引く。毎ターン最大1回まで発動。"
  },
  Skill_119767_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_119767_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_119835_Desc = {
    Text = "捨て札から1枚の指令カードを選択して手札に戻す。「ラモナ」がチームにいる場合、このターン中に次に使用する指令カードの効果が[Arg1]倍になる。"
  },
  Skill_119835_Name = {
    Text = "再会の願い"
  },
  Skill_119845_Desc_1 = {
    Text = "<PVPHoldingKeywords:保有>：本ターン内で最後に発射した「スキル」として扱い、行動力消費 -[Arg1]。このカードは戦闘開始後、2番目のドロー山の頂部に置かれる。"
  },
  Skill_119845_Name_1 = {
    Text = "再会の願い"
  },
  Skill_119845_UnknownName = {
    Text = "再会の願い"
  },
  Skill_120314_Desc = {
    Text = "1点の行動力を獲得し、すべての敵に5層の<DwmofeiKeywords:誕生の儀>を付与する。「誕妄・マーフィー」がチームにいる場合、「ルルイエ円舞」カードを1枚引く。"
  },
  Skill_120314_Name = {
    Text = "彷徨う船"
  },
  Skill_120896_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。全ての味方は [Arg3] 層の<RetaliateIconKeywords:反撃>を得る。"
  },
  Skill_120896_Name = {
    Text = "破砕の沈戟"
  },
  Skill_120942_Desc = {
    Text = "1000000ライフを追加"
  },
  Skill_120942_Name = {
    Text = "1000000ライフを追加"
  },
  Skill_121138_Desc = {
    Text = "この行動予測に転換すると、1倍の一時的な触腕を獲得し、<TentacleInjurieIconKeywords:触腕ダメージ>が一時的に50%減少する。すべての味方が<Block:[Block:Arg1]>点のシールドを獲得し、1ターンの間、デバフ状態を無効化する。"
  },
  Skill_121138_Name = {
    Text = "失われた古都"
  },
  Skill_121342_Desc = {
    Text = "前列のモンスターに99999999ダメージを与える"
  },
  Skill_121342_Name = {
    Text = "前衛のモンスターを一撃で倒す"
  },
  Skill_121354_Desc = {
    Text = "全てのモンスターに99999999ダメージを与える"
  },
  Skill_121354_Name = {
    Text = "全てのモンスターを一撃で倒す"
  },
  Skill_121360_Desc = {
    Text = "無敵を解除することを追加"
  },
  Skill_121360_Name = {
    Text = "無敵を解除することを追加"
  },
  Skill_121361_Desc = {
    Text = "無敵を追加"
  },
  Skill_121361_Name = {
    Text = "無敵を追加"
  },
  Skill_121366_Desc = {
    Text = "500ライフを追加"
  },
  Skill_121366_Name = {
    Text = "500ライフを追加"
  },
  Skill_121800_Desc = {
    Text = "敵の触腕ダメージを一時的に80%減少させ、同量の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_121800_Name = {
    Text = "天を覆す"
  },
  Skill_121801_Desc = {
    Text = "覚醒体を1体選択し、50狂気を獲得させる。3回繰り返す。"
  },
  Skill_121801_Name = {
    Text = "揺るぎない信仰"
  },
  Skill_121802_Desc = {
    Text = "即座に最大ライフの25%を回復し、最大ライフの500%の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_121802_Name = {
    Text = "崇拝と鼓舞"
  },
  Skill_121803_Desc = {
    Text = "カードを5枚引く。すべての手札の<SlowIconKeywords:遅延>を解除する。"
  },
  Skill_121803_Name = {
    Text = "神聖なる輝き"
  },
  Skill_122118_Desc = {
    Text = "カードを1枚引き、<DerivativeCardKeywords_128:「カウントダウン: 0」>を捨て札に加える。"
  },
  Skill_122118_Name = {
    Text = "カウントダウン：1"
  },
  Skill_122119_Desc = {
    Text = "カードを3枚引き、3点の行動力を獲得し、[Arg1]%の確率で<DerivativeCardKeywords_123:「カウントダウン: 5」>を捨て札にシャッフルします。"
  },
  Skill_122119_Name = {
    Text = "カウントダウン：0"
  },
  Skill_122120_Desc = {
    Text = "カードを1枚引き、<DerivativeCardKeywords_125:「カウントダウン: 3」>を捨て札に追加する。"
  },
  Skill_122120_Name = {
    Text = "カウントダウン：4"
  },
  Skill_122121_Desc = {
    Text = "カードを1枚引き、<DerivativeCardKeywords_124:「カウントダウン: 4」>を捨て札に加えてシャッフルする。"
  },
  Skill_122121_Name = {
    Text = "カウントダウン：5"
  },
  Skill_122122_Desc = {
    Text = "カードを1枚引き、<DerivativeCardKeywords_126:「カウントダウン: 2」>を捨て札にシャッフルする。"
  },
  Skill_122122_Name = {
    Text = "カウントダウン：3"
  },
  Skill_122123_Desc = {
    Text = "カードを1枚引き、<DerivativeCardKeywords_127:「カウントダウン: 1」>を捨て札に加えてシャッフルする。"
  },
  Skill_122123_Name = {
    Text = "カウントダウン：2"
  },
  Skill_122413_Desc = {
    Text = "ムシェットがブロックされなかったダメージを与えた後、2点の<Monster_Fervor:一時的な熱狂>を獲得する。80点の<ReinforcePVEKeywords:堅固>を獲得し、敵のターン開始時に除去する。"
  },
  Skill_122413_Name = {
    Text = "霧境の遺脈"
  },
  Skill_122414_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、敵のシールド<Block:[Block:Arg3]>点ごとに、与えるダメージが1増加する。[Arg4]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_122414_Name = {
    Text = "人間爆破"
  },
  Skill_122415_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_122415_Name = {
    Text = "シャイニングトルネード"
  },
  Skill_122416_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_122416_Name = {
    Text = "シャイニングトルネード"
  },
  Skill_122417_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1回ブロックされるたびに[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_122417_Name = {
    Text = "嵐の衝撃"
  },
  Skill_122432_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に<Block:[Block:Arg1]>点のシールドと<Energy:[Energy:Arg1]>狂気を獲得。ターン終了時にこの命輪は自動的に装備を解除し、次回「箱の中の童趣」を装備する際に獲得する狂気とシールドが増加する[Arg2]。"
  },
  Skill_122432_Name_1 = {
    Text = "箱の中の童心"
  },
  Skill_122433_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に3点の<PVPReciprocalKeywords:カウントダウン>を獲得。"
  },
  Skill_122433_Name_1 = {
    Text = "カウントダウン"
  },
  Skill_122483_AwakerSkillBackgroundStory = {
    Text = "戦闘は、生命の最後の瞬間のようだ。\n霧に包まれた「自分」の世界に戻るために。"
  },
  Skill_122483_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。このカードは「攻撃」として扱う。"
  },
  Skill_122483_Desc_2 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。最後に使用した他の「攻撃」の一時的なコピーを1枚獲得し、その行動力消費を1減少させる。このカードは「攻撃」として扱う。"
  },
  Skill_122483_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_122483_Name = {
    Text = "人間爆破"
  },
  Skill_122483_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_122484_AwakerSkillBackgroundStory = {
    Text = "すべての人は死ぬ、彼女もそうだ——彼女は死を拒まず、死を受け入れている。\nしかし申し訳ないが、彼女の死期は今日でも、この瞬間でもない。\n彼女はまだ楽しんでいないのだから！"
  },
  Skill_122484_Desc = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。<Energy:[Energy:Arg3]>狂気を獲得。このカードは「攻撃」として扱う。"
  },
  Skill_122484_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_122484_Name = {
    Text = "嵐の衝撃"
  },
  Skill_122484_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_122485_AwakerSkillBackgroundStory = {
    Text = "過去を忘れないで、霧境調査団を忘れないで。\n忘れることは、裏切りを意味する。\nそして彼女、モシャは、決して裏切らない。"
  },
  Skill_122485_Desc_0 = {
    Text = "ムシェットは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「ドラマチックな出会い」のダメージ回数+2。「ドラマチックな出会い」を発動するたび、ムシェットの「攻撃」の一時的な最終ダメージ+25%。即座に一時的な「人間爆破」を1枚生成する。"
  },
  Skill_122485_Desc_15 = {
    Text = "ムシェットは <Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「ドラマチックな出会い」のダメージ回数+2。ターンごとの発動回数の上限が5回に増加。「ドラマチックな出会い」を発動するたび、ムシェットの「攻撃」の一時的な最終ダメージ+25%。行動力消費0の「人間爆破」を2枚即座に獲得。"
  },
  Skill_122485_EffectNameList = {Text = "狂気"},
  Skill_122485_Name = {
    Text = "霧境の遺脈"
  },
  Skill_122486_AwakerSkillBackgroundStory = {
    Text = "「異世界に行ってもそれを叫ぶの？」\n「わかった、じゃあよく聞いて——」\n「来た！男女老少が大好きな！シャイニング☆トルネード——！！」"
  },
  Skill_122486_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。このターン中、すべての覚醒体の「攻撃」のダメージが[Arg3]増加する。"
  },
  Skill_122486_BattleDesc_3 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。このターン中、ムシェットのダメージ回数+1。すべての覚醒体の「攻撃」のダメージが[Arg3]増加する。"
  },
  Skill_122486_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。このターン中、すべての覚醒体の「攻撃」のダメージが[Arg3]増加する。"
  },
  Skill_122486_Desc_3 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。このターン中、ムシェットのダメージ回数+1。すべての覚醒体の「攻撃」のダメージが[Arg3]増加する。"
  },
  Skill_122486_EffectNameList = {
    Text = "ダメージ,「攻撃」ダメージ増加"
  },
  Skill_122486_Name = {
    Text = "シャイニング☆トルネード"
  },
  Skill_122486_OverLimitUtlSkillDesc_0 = {
    Text = "全体の敵に<Damage:[Damage:Arg1]>点のダメージを[Arg4]回与える。すべての覚醒体の「打撃」ダメージが[Arg3]点アップ。次に発射する「嵐の衝撃」の基礎行動力消費を0にする。本戦闘で初めて発動した場合、追加ですべての敵を<HunmiKeywords:昏睡>させる。"
  },
  Skill_122486_OverLimitUtlSkillDesc_3 = {
    Text = "全体の敵に<Damage:[Damage:Arg1]>点のダメージを[Arg4]回与える。このターン中のムシェットのダメージ回数+1、すべての覚醒体の「打撃」ダメージが[Arg3]点アップ。次に発射する「嵐の衝撃」の基礎行動力消費を0にする。本戦闘で初めて発動した場合、追加ですべての敵を<HunmiKeywords:昏睡>させる。"
  },
  Skill_122486_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_122487_AwakerSkillBackgroundStory = {
    Text = "「まだ反抗するつもり？怒っちゃうよ——おとなしく死んで待ってなさい！」"
  },
  Skill_122487_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_122487_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ムシェットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_122487_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_122487_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_122488_AwakerSkillBackgroundStory = {
    Text = "「ハハハハ、そうこなくっちゃ、事態が面白くなってきた！」\n「遊んでくれてありがとう、私は本当に嬉しい…………」"
  },
  Skill_122488_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_122488_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ムシェットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_122488_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_122488_Name = {Text = "攻撃"},
  Skill_122488_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_122656_Desc_1 = {
    Text = "敵の覚醒体1体を撃破し、味方の覚醒体がその最大ライフ、ライフ、シールド、狂気を分け合う。"
  },
  Skill_122656_Name_1 = {
    Text = "シルヴィアの紅茶"
  },
  Skill_122836_Desc = {
    Text = "ライフを500に設定する"
  },
  Skill_122836_Name = {
    Text = "ライフを500に設定する"
  },
  Skill_123159_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。"
  },
  Skill_123159_Name = {
    Text = "ドラマチックな出会い"
  },
  Skill_123270_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札または捨て札にあるランダムな指令カード[Arg3]枚に<BurningKeywords:燃焼>を付与する。[Arg4]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_123270_Name = {
    Text = "ギガフレア"
  },
  Skill_123509_Desc = {
    Text = "「攻撃」を2枚引く。「ムシェット」がパーティにいる場合、それらの計算力消費を1減少させる。"
  },
  Skill_123509_Name = {
    Text = "霧境より"
  },
  Skill_124013_Desc_1 = {
    Text = "公式に従って状態を追加するテストカードを生成"
  },
  Skill_124013_Name_1 = {
    Text = "テストカードを生成"
  },
  Skill_124014_Desc_1 = {
    Text = "公式に従って状態をターゲットにのみ追加"
  },
  Skill_124014_Name_1 = {
    Text = "ターゲットのみ"
  },
  Skill_124015_Desc_1 = {
    Text = "公式に従って状態を自身にのみ追加"
  },
  Skill_124015_Name_1 = {
    Text = "ただ自分自身"
  },
  Skill_124025_Desc_1 = {
    Text = "公式に従って状態を両方追加"
  },
  Skill_124069_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与え、ブロックされなかったダメージを [Arg3] 回与えるごとにドロー山の一番上の指令カードに [Arg4] スタックの<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_124069_Name = {Text = "攻撃"},
  Skill_124070_Desc = {
    Text = "すべてのデバフを解除し、相手のターン終了時に手札を捨てない。ターン終了時、[Arg1]点の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重傷>、<VulnerabilityIconKeywords:易傷>を順に付与する。"
  },
  Skill_124070_Name = {
    Text = "界外の音"
  },
  Skill_124071_Desc = {
    Text = "すべての味方が<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_124071_Name = {
    Text = "響き渡る音"
  },
  Skill_124072_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、手札のランダムな [Arg2] 枚の指令カードとドロー山のランダムな [Arg2] 枚の指令カードに [Arg3] スタックの<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_124072_Name = {
    Text = "星の極光"
  },
  Skill_124073_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、すべての味方に[Arg3]点の<PowerIconKeywords:力>を付与する。自身または他の味方が<WeaknessIconKeywords:虚弱>または<VulnerabilityIconKeywords:易傷>を持つ場合、それを敵に移す。"
  },
  Skill_124073_Name = {Text = "鎮魂歌"},
  Skill_124074_Desc = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得し、敵の手札に<SlowIconKeywords:遅延>カードが [Arg2] 枚あるごとに、[Arg3] スタックの一時的な<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_124074_Name = {
    Text = "響き渡る音"
  },
  Skill_124075_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_124075_Name = {Text = "攻撃"},
  Skill_124076_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージの[Arg3]%の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_124076_Name = {Text = "攻撃"},
  Skill_124077_Desc = {
    Text = "全ての味方が失ったライフの[Arg1]%を回復する。"
  },
  Skill_124078_Desc = {
    Text = "失ったライフの[Arg1]%を回復し、[Arg2]点の<ReinforcePVEKeywords:堅固>を獲得する。"
  },
  Skill_124079_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。自身が<WeaknessIconKeywords:虚弱>または<VulnerabilityIconKeywords:易傷>を持つ場合、それを敵に移す。"
  },
  Skill_124079_Name = {Text = "鎮魂歌"},
  Skill_124080_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージの[Arg3]%の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_124080_Name = {Text = "攻撃"},
  Skill_124081_Desc = {
    Text = "[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。前進する。"
  },
  Skill_124081_Name = {
    Text = "星のゆりかご"
  },
  Skill_124082_Desc = {
    Text = "[Arg1]点の<Guaiwusiwangdikang:死亡抵抗>を獲得し、<Guaiwusiwangdikang:死亡抵抗>によるライフ回復効果が[Arg2]%増加する。敵が指令カードを[Arg3]枚使用するたび、[Arg4]点の<PowerIconKeywords:力>を一時的に奪う。"
  },
  Skill_124082_Name = {
    Text = "星のゆりかご"
  },
  Skill_124083_Desc = {
    Text = "[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、<Block:[Block:Arg2]>点のシールドと[Arg3]点の<Guaiwusiwangdikang:死亡抵抗>を獲得する。"
  },
  Skill_124083_Name = {
    Text = "星のゆりかご"
  },
  Skill_124084_Desc = {
    Text = "最大ライフ+[Arg1]%、[Arg2]%の<PowerIconKeywords:力>を奪う。敵のライフ上限-[Arg3]%。"
  },
  Skill_124084_Name = {
    Text = "養分吸収"
  },
  Skill_124085_Desc = {
    Text = "最大ライフ+[Arg1]%、[Arg2]%の力を奪う。このターンでライフを失っていない場合、敵のライフ上限 -[Arg3]%。"
  },
  Skill_124085_Name = {
    Text = "養分吸収"
  },
  Skill_124086_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、手札のランダムな [Arg2] 枚の指令カードとドロー山のランダムな [Arg2] 枚の指令カードに [Arg3] スタックの<SlowIconKeywords:遅延>を付与する。後退する。"
  },
  Skill_124086_Name = {
    Text = "星の極光"
  },
  Skill_124182_Desc = {
    Text = "最大ライフ+[Arg1]%、[Arg2]%の<PowerIconKeywords:力>を奪う。"
  },
  Skill_124182_Name = {
    Text = "養分吸収"
  },
  Skill_124205_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。敵のシールド<Block:[Block:Arg3]>点ごとに、与えるダメージが1増加する。[Arg4]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_124205_Name = {
    Text = "人間爆破"
  },
  Skill_124218_Desc_1 = {
    Text = "ランダムに生存覚醒体を取得"
  },
  Skill_124218_Name_1 = {
    Text = "ランダムに生存覚醒体を取得"
  },
  Skill_124225_Desc_1 = {
    Text = "ランダムにカードを取得"
  },
  Skill_124225_Name_1 = {
    Text = "ランダムにカードを取得"
  },
  Skill_124420_Desc = {
    Text = "ムシェットがブロックされなかったダメージを与えた後、2点の<Monster_Fervor:一時的な熱狂>を獲得する。"
  },
  Skill_124420_Name = {
    Text = "霧境の遺脈"
  },
  Skill_124422_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1回ブロックされるごとに[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_124422_Name = {
    Text = "嵐の衝撃"
  },
  Skill_124423_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_124423_Name = {
    Text = "シャイニングトルネード"
  },
  Skill_124424_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_124424_Name = {
    Text = "シャイニングトルネード"
  },
  Skill_124740_Desc = {
    Text = "4体の覚醒体が順番に必殺技を発動します。ブラックリストの監視は静止します。"
  },
  Skill_124740_Name = {
    Text = "追撃テスト"
  },
  Skill_124742_Desc = {
    Text = "4体の覚醒体が順番に攻撃を行います。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124742_Name = {
    Text = "追撃テスト"
  },
  Skill_124755_Desc = {
    Text = "プレイヤーは指名キーオーダーを発動します。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124755_Name = {
    Text = "追撃テスト"
  },
  Skill_124761_Desc = {
    Text = "プレイヤーが指名キーオーダーを発動する。すべてのリスナーが発動します。"
  },
  Skill_124761_Name = {
    Text = "追撃テスト"
  },
  Skill_124762_Desc = {
    Text = "4体の覚醒体が順番に必殺技を放ちます。すべてのリスナーが発動します。"
  },
  Skill_124762_Name = {
    Text = "追撃テスト"
  },
  Skill_124763_Desc = {
    Text = "4体の覚醒体が順番に攻撃を行います。すべてのリスニングをトリガーします。"
  },
  Skill_124763_Name = {
    Text = "追撃テスト"
  },
  Skill_124814_Desc = {
    Text = "4体の覚醒体が順番に防御を発射します。すべてのリスナーが発動します。"
  },
  Skill_124814_Name = {
    Text = "追撃テスト"
  },
  Skill_124815_Desc = {
    Text = "4体の覚醒体が順番にスキル1を発動します。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124815_Name = {
    Text = "追撃テスト"
  },
  Skill_124816_Desc = {
    Text = "4体の覚醒体が順番に覚醒を発動します。すべてのリスナーが発動します。"
  },
  Skill_124816_Name = {
    Text = "追撃テスト"
  },
  Skill_124817_Desc = {
    Text = "4体の覚醒体が順番に覚醒を発動します。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124817_Name = {
    Text = "追撃テスト"
  },
  Skill_124818_Desc = {
    Text = "4体の覚醒体が順番にスキル1を発動します。すべてのリスナーが発動します。"
  },
  Skill_124818_Name = {
    Text = "追撃テスト"
  },
  Skill_124819_Desc = {
    Text = "4体の覚醒体が順番に防御を発動します。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124819_Name = {
    Text = "追撃テスト"
  },
  Skill_124820_Desc = {
    Text = "空のポーションカード、[Block:Arg1]点のシールドを獲得。"
  },
  Skill_124820_Name = {
    Text = "追撃テスト"
  },
  Skill_124821_Desc = {
    Text = "プレイヤーが指名カードを発射します。ブラックリストの監視は静かに保たれます。"
  },
  Skill_124821_Name = {
    Text = "追撃テスト"
  },
  Skill_124822_Desc = {
    Text = "プレイヤーが指名カードを発射します。すべてのリスナーが発動します。"
  },
  Skill_124822_Name = {
    Text = "追撃テスト"
  },
  Skill_124839_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、相手の手札のランダムなカード[Arg2]枚と山札のランダムなカード[Arg2]枚に[Arg3]点の<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_124839_Name = {
    Text = "星の極光"
  },
  Skill_124840_Desc = {
    Text = "[Arg1]点の<RetaliateIconKeywords:反撃>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_124840_Name = {
    Text = "星のゆりかご"
  },
  Skill_124871_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者のスキルカードを発射した後、[Arg1]枚のカードを引き、優先的に他の覚醒体のカードを引く。毎ターン1回まで発動。"
  },
  Skill_124871_Name_1 = {
    Text = "宿命の紡輪"
  },
  Skill_124872_Desc_1 = {
    Text = "味方を1体選択し、次に出す「スキル」を2回発動させる。"
  },
  Skill_124872_Name_1 = {
    Text = "絡まった糸"
  },
  Skill_124874_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身が下に[Arg1]枚発射した「スキル」を2回発動させる。"
  },
  Skill_124874_Name_1 = {
    Text = "永世に紡ぐ網"
  },
  Skill_124875_Desc_1 = {
    Text = "[Arg1] 枚ドローし、[Arg1] 点の行動力を獲得。任意の覚醒体を選択し、自身の次のターン開始まで、その覚醒体が与えるおよび受ける致命的なアクティブダメージを同量の<PVPDestinedDeathKeyWords:定命の予兆>の付与に変更。"
  },
  Skill_124875_Name_1 = {
    Text = "運命よ、我が意のままに"
  },
  Skill_124876_BattleDesc_1 = {
    Text = "ランダムに[Arg3]回<Damage:[Damage:Arg2]>ダメージを与え、<PVPDestinedDeathKeyWords:命定予兆>、このカードを山札にシャッフルし、すべての「織物」のダメージ回数を+1する。"
  },
  Skill_124876_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与え、<PVPDestinedDeathKeyWords:命定予兆>、このカードを山札にシャッフルし、すべての「織物」のダメージ回数を+1する。"
  },
  Skill_124876_Name_1 = {Text = "織る"},
  Skill_124877_Desc_1 = {
    Text = "前方の敵に<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を得る。"
  },
  Skill_124877_Name_1 = {Text = "攻撃"},
  Skill_124878_Desc_1 = {
    Text = "<PVPHoldingKeywords:保有>：カードを発射するたびに敵の手中のランダムな「スキル」に変化し、その行動力消費を -[Arg1] する。"
  },
  Skill_124878_Name_1 = {Text = "予言"},
  Skill_124900_Desc_1 = {
    Text = "味方1体に+[Arg1]<StrongEffectKeywords:強効>を付与する。このカードは次のドローパイルに混ぜ入れられ、次に使用する時+[Arg2]<StrongEffectKeywords:強効>。"
  },
  Skill_124900_Name_1 = {
    Text = "逃れえぬ輪廻"
  },
  Skill_124900_UnknownName = {
    Text = "逃れえぬ輪廻"
  },
  Skill_125370_Desc_1 = {
    Text = "味方1体を選択し、他の味方と敵全体に[Arg1]層の<PVPLostSoulKeyWords:痴酔>を付与させる。"
  },
  Skill_125370_Name_1 = {
    Text = "屋敷に眠る過去"
  },
  Skill_125370_UnknownName = {
    Text = "屋敷に眠る過去"
  },
  Skill_125371_AwakerSkillBackgroundStory = {
    Text = "彼らは彼女の起源については決して語らず、彼女の降誕時の言葉に表せない巨大な歓喜についてだけ語る。\nあなたの意識は狂喜の中で溶け、あなたの過去は狂喜の中で溶け、あなたの頭蓋骨は狂喜の中で溶け…………あなたの脳髄は狂喜の中で溶ける。\nただ柔らかいお菓子を口に運ぶ——「相思」を引き合いに出して。"
  },
  Skill_125371_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>クリティカルダメージを与え、[Arg2]％の毒を発動する。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]（[Arg5]/3）。"
  },
  Skill_125371_BattleDesc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>クリティカルダメージを与え、[Arg2]％の毒を発動する。<EmbryoFusionIconKeywords:胚胎融合>+[Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]（[Arg5]/3）。"
  },
  Skill_125371_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>クリティカルダメージを与え、[Arg2]％の毒を発動する。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]。"
  },
  Skill_125371_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>クリティカルダメージを与え、[Arg2]％の毒を発動する。<EmbryoFusionIconKeywords:胚胎融合>+[Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]。"
  },
  Skill_125371_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_125371_Name = {
    Text = "骨まで染みる想い"
  },
  Skill_125371_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_125372_Desc_1 = {
    Text = "対象と<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、1層の<PVPLostSoulKeyWords:酔い痴れ>を付与する。"
  },
  Skill_125372_Name_1 = {
    Text = "レンコンの糸は殺しにくい"
  },
  Skill_125373_AwakerSkillBackgroundStory = {
    Text = "なぜ彼らを誘惑するのか？彼らはもともと抵抗する力がない。\nなぜ彼らを唆すのか？より高く、より広く、権力欲の渦が視界に入るすべてを巻き込む。\nなぜなら、情に囚われた凡人の肉体は飲み込みにくいからだ。野心に漬け込まれていない凡俗の肉体は退屈で仕方がない。\n夢の故郷ではないのは、捕食者が獲物に残したかすかな恩恵だ。\nその歓喜の中心には何もなく、ただ無限の混乱と無限の欺瞞が広がっている。"
  },
  Skill_125373_Desc_0 = {
    Text = "徐は<Energy:[Energy:Arg1]>点の狂気を獲得。<ExaltIconKeywords:霊知啓発>：徐の各種指令カードが毎ターン初めて<ResonanceKeywords:共鳴>効果を発動した時、その基礎行動力消費を0にする。"
  },
  Skill_125373_Desc_15 = {
    Text = "徐は<Energy:[Energy:Arg1]>点の狂気を獲得。<ExaltIconKeywords:霊知啓発>：徐の各種指令カードが毎ターン初めて<ResonanceKeywords:共鳴>効果を発動した時、その基礎行動力消費を0にする。<WitherKeywords0:酔い痴れ>の重ね掛け上限が15層に引き上げられ、徐が毎ターン最初に発射した指令カードが1回追加で発動する。"
  },
  Skill_125373_EffectNameList = {Text = "狂気"},
  Skill_125373_Name = {
    Text = "夢なき世界の主"
  },
  Skill_125374_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_125374_Name_1 = {Text = "攻撃"},
  Skill_125375_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、1層の<PVPLostSoulKeyWords:酔い痴れ>を付与する。"
  },
  Skill_125375_Name_1 = {
    Text = "暗い通路"
  },
  Skill_125376_AwakerSkillBackgroundStory = {
    Text = "古往今来、情という字。\n無論どうあれ、人を業の海に向かわせ、振り返ることを許さない。"
  },
  Skill_125376_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：すべての敵から[Exhaustion:Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。】[Arg2]点の行動力を獲得し、すべての敵に[Poison:Arg3]点の<IntoxicationIconKeywords:毒>を付与する。選択：<WitherKeywords1:心を交わす>または<WitherKeywords2:魂を奪う>。"
  },
  Skill_125376_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：すべての敵から[Exhaustion:Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。】[Arg2]点の行動力を獲得し、すべての敵に[Poison:Arg3]点の<IntoxicationIconKeywords:毒>を付与する。次の<ResonanceKeywords:共振>効果が2倍になる。選択：<WitherKeywords1:心を交わす>または<WitherKeywords2:魂を奪う>。"
  },
  Skill_125376_EffectNameList = {
    Text = "毒,力減少"
  },
  Skill_125376_Name = {
    Text = "夜霧の下の誓い"
  },
  Skill_125376_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：すべての敵から[Exhaustion:Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。】[Arg2]点の行動力を獲得し、<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]。すべての敵に[Poison:Arg3]層の<IntoxicationIconKeywords:毒>を付与する。選択：<WitherKeywords3:心を交わす>または<WitherKeywords4:魂を奪う>。"
  },
  Skill_125376_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：すべての敵から[Exhaustion:Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。】[Arg2]点の行動力を獲得し、<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]。すべての敵に[Poison:Arg3]層の<IntoxicationIconKeywords:毒>を付与する。自身の次に発動する<ResonanceKeywords:共振>効果が2倍になる。選択：<WitherKeywords3:心を交わす>または<WitherKeywords4:魂を奪う>。"
  },
  Skill_125376_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_125377_Desc_1 = {
    Text = "<PVPSneakKeywords:ステルス>、<Energy:[Energy:Arg1]>の狂気を獲得。"
  },
  Skill_125377_Name_1 = {
    Text = "情熱の夜霧"
  },
  Skill_125378_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、<HPAndShieldMax:ライフとシールドが最も高い>敵に [Arg1] 層の<PVPLostSoulKeyWords:酔い痴れ>を付与する。"
  },
  Skill_125378_Name_1 = {
    Text = "白木蓮の餌"
  },
  Skill_125379_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：他の味方が「狂気解放」の後、手札の装備者のすべての「スキル」の行動力消費を-1する。"
  },
  Skill_125379_Name_1 = {
    Text = "無駄に眉をひそめる"
  },
  Skill_125380_AwakerSkillBackgroundStory = {
    Text = "彼女の扇の下には一つのキスがあり、彼女の扇の下には無数のキスがある。\n豊かで、多汁で、柔らかい…………包み込み、融解し、沈黙。"
  },
  Skill_125380_BattleDesc = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。<ResonanceKeywords:共振3>：すべての敵に1点の<WitherKeywords:陶酔>( [Arg3]/3 )を付与する。"
  },
  Skill_125380_Desc_0 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。<ResonanceKeywords:共振3>：すべての敵に1点の<WitherKeywords:陶酔>を付与する。"
  },
  Skill_125380_Desc_3 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。<ResonanceKeywords:共振3>：すべての敵に1点の<WitherKeywords0:陶酔>を付与する。"
  },
  Skill_125380_EffectNameList_0 = {
    Text = "毒,力減少"
  },
  Skill_125380_Name = {
    Text = "扇に寄せる口づけ"
  },
  Skill_125380_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_125381_AwakerSkillBackgroundStory = {
    Text = "「古怪で、怪しい古、亡き妻が三時に土から這い出し、浪子が心を失い鍋の中で煮る。」"
  },
  Skill_125381_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_125381_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。<ResonanceKeywords:共振3>：追加で<Energy:[Energy:Arg3]>狂気を獲得。( [Arg4]/3 )"
  },
  Skill_125381_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。徐は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_125381_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。徐は<Energy:[Energy:Arg2]>狂気を獲得。<ResonanceKeywords:共振3>：追加で<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_125381_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_125381_Name = {Text = "攻撃"},
  Skill_125381_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_125382_Desc_1 = {
    Text = "対象の全ての<PVPLostSoulKeyWords:痴酔>を除去し、<Damage:[Damage:Arg1]> ダメージを与える。1層除去するごとにランダムな敵1体に<Damage:[Damage:Arg2]> ダメージを1回与え、<StrongEffectKeywords:強効> +[Arg3]。"
  },
  Skill_125382_Name_1 = {
    Text = "夜霧の下の誓い"
  },
  Skill_125383_AwakerSkillBackgroundStory = {
    Text = "「無相の神女よ、苦しみを救い、面を割り、心を剖いて郎の骨を取り、私の堂前に至高の主を捧げよう。」"
  },
  Skill_125383_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_125383_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<ResonanceKeywords:共振3>：追加で<Energy:[Energy:Arg3]>狂気を獲得。( [Arg4]/3 )"
  },
  Skill_125383_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。徐は<Block:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_125383_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。徐は<Block:[Energy:Arg2]>狂気を獲得。<ResonanceKeywords:共振3>：追加で<Block:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_125383_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_125383_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_125903_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<PowerIconKeywords:力>を得る。山札と捨て札から指令カードを[Arg3]枚発現し、[Arg4]枚選んで<DepleteIconKeywords:除外>する。"
  },
  Skill_125903_Name = {
    Text = "万象同源"
  },
  Skill_125904_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_125904_Name = {
    Text = "六翼の解放"
  },
  Skill_125905_Desc = {
    Text = "ターン終了時に手札にある場合、すべての覚醒体が3狂気を失う。捨てた後、これを<DepleteIconKeywords:除外>する。"
  },
  Skill_125905_Name = {Text = "沈黙"},
  Skill_125906_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>を付与する。指令カードを[Arg4]枚使用した場合、<Damage:[Damage:Arg5]>ダメージを[AttackTimes:Arg6]回与え、[Arg7]点の<FragileIconKeywords:脆弱>と<WeaknessIconKeywords:虚弱>を付与する「四翼の芽生え」に行動予測を転換する。"
  },
  Skill_125906_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_125907_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。次に使用した指令カードに対応する覚醒体を、[Arg2]のターンの間、<Seal:封印>する。"
  },
  Skill_125907_Name = {
    Text = "時を貫く翼"
  },
  Skill_125908_Desc = {
    Text = "敵が行動力を消費した場合、獲得するキーエネルギーが[Arg1]%減少する。 タヴィがブロックされなかったダメージを与えた場合、「<DerivativeCardKeywords_131:真・輪廻パラドックス>」を[Arg2]枚手札に追加する。"
  },
  Skill_125908_Name = {
    Text = "銀の鍵の門を超えて"
  },
  Skill_125909_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:脆弱>と<WeaknessIconKeywords:虚弱>を付与する。[Arg4]枚の指令カードを使用した場合、<Damage:[Damage:Arg5]>ダメージを[AttackTimes:Arg6]回与え、[Arg7]点の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を付与する「六翼の解放」に行動予測を転換する。"
  },
  Skill_125909_Name = {
    Text = "四翼の芽生え"
  },
  Skill_126008_Desc = {
    Text = "覚醒体を1体選択し30狂気を獲得させ、他の覚醒体は10狂気を失う。このカードがターン終了時に手札にある場合、味方にダメージを与える。"
  },
  Skill_126008_Name = {
    Text = "真・輪回パラドックス"
  },
  Skill_126350_Desc_1 = {
    Text = "対象1体に<PVPSneakKeywords:ステルス>を付与する。"
  },
  Skill_126446_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%([Arg4])の<IntoxicationIconKeywords:毒>を付与する。手札[Arg5]枚に<BurningKeywords:燃焼>を付与する。"
  },
  Skill_126446_Name = {
    Text = "腐敗の緑炎"
  },
  Skill_126447_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%([Arg4])の<IntoxicationIconKeywords:毒>を付与する。手札[Arg5]枚に<BurningKeywords:燃焼>を付与する。"
  },
  Skill_126447_Name = {
    Text = "死滅の緑炎"
  },
  Skill_126448_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%([Arg4])の<IntoxicationIconKeywords:毒>を付与する。手札[Arg5]枚に<BurningKeywords:燃焼>を付与する。"
  },
  Skill_126448_Name = {Text = "緑炎"},
  Skill_126449_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得。この行動予測に転換すると、このターン中に「攻撃」を[Arg3]回受けるたび、[Arg4]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。"
  },
  Skill_126449_Name = {
    Text = "誘蛾の炎"
  },
  Skill_126450_Desc = {
    Text = "[Arg1]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。ライフを[Arg2]%失うごとに、[Arg3]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。<ExhaustionCounter:目には目を>を獲得。"
  },
  Skill_126450_Name = {
    Text = "翡翠の映像"
  },
  Skill_126451_Desc = {
    Text = "この行動予測に転換すると、デバフ状態を解除する。[Arg1]点の<PowerIconKeywords:力>を獲得し、すべての手札を捨てる。<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。カードを1枚捨てるごとに、追加でダメージを1回与え、1点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。"
  },
  Skill_126451_Name = {
    Text = "死告の舞い"
  },
  Skill_126452_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、すべての手札を捨てる。<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。手札を[Arg4]枚の捨てるごとに、追加で[Arg5]回のダメージを与え、[Arg6]点の<MonsterLizVerdantSpark:翠緑の火種>を獲得する。"
  },
  Skill_126452_Name = {
    Text = "死告の舞い"
  },
  Skill_126484_AwakerSkillBackgroundStory = {
    Text = "最初の糸が垂れ下がった時、運命はすでにその裁きを告げていた。"
  },
  Skill_126484_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_126484_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。アラクネは <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_126484_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_126484_Name = {Text = "攻撃"},
  Skill_126484_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_126484_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_126484_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>点ダメージを与える。<Energy:[Energy:Arg2]>点狂気を得る。今ターン初めて発射する場合、1回「無尽線縷」の追撃を発動する（[Arg3]/1）。"
  },
  Skill_126485_AwakerSkillBackgroundStory = {
    Text = "運命もまた、人形の無謀さに道を譲ることがある。\nもし、それらが定められた代償を受け入れる覚悟があるならば。"
  },
  Skill_126485_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_126485_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。アラクネは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_126485_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_126485_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_126485_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_126485_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点シールドを得る。<Energy:[Energy:Arg2]>点狂気を得る。今ターン初めて発射する場合、1回「無尽線縷」の追撃を発動する（[Arg3]/1）。"
  },
  Skill_126486_AwakerSkillBackgroundStory = {
    Text = "彼女は運命の名において、ここに宣告する――\nすべての誤った運命は、時の塵に帰す。世界の運命は、定められた軌道へと還る。\n乱れた糸は、ここで断ち切られる。見捨てられし不幸なる者は、ここに安息を得る。"
  },
  Skill_126486_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。一時的なダメージ強化+[Arg2]％追加。すべての手札の<SlowIconKeywords:遅延>状態を解除する。<SingularityKeywords:特異点転送>：このターン残り時間中、他の覚醒体の指令カードを使用するごとに、1層<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無限の糸>」の追撃を行う。"
  },
  Skill_126486_EffectNameList = {
    Text = "シールド,ダメージ強化,無限の糸,運命の裁き"
  },
  Skill_126486_Name = {
    Text = "運命よ、我が意のままに"
  },
  Skill_126486_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。一時的なダメージ強化+[Arg2]％追加。すべての手札の<SlowIconKeywords:遅延>状態を解除する。手札と超次元空間にある<SingularityKeywords1:特異点ビーコン>を持つカードを最大5枚まで一時的な基本のコピーを生成し、ランダムに山札と捨て札に置き、その行動力消費を0にする。<SingularityKeywords:特異点転送>：このターン残り時間中、他の覚醒体の指令カードを使用するごとに、1層<SilkKeywords:織命>を消費して「<DerivativeCardKeywords_137:無限の糸>」の追撃を行う。"
  },
  Skill_126486_PropertyNameList = {
    Text = "防御力*GrowValue1、$GrowValue2％、攻撃力*GrowValue3"
  },
  Skill_126488_BattleDesc_0 = {
    Text = "[Float:Arg3]％の最大ライフ（[Arg4]）を失い、1層の<SilkKeywords:織命>を獲得。この戦闘中「<DerivativeCardKeywords_138:導きの糸>」が失ったライフとアラクネが与える<CutKeywords:運命の裁き>が[Arg2]％増加。虚無：アラクネはランダムに15〜30狂気を獲得。"
  },
  Skill_126488_Desc_0 = {
    Text = "[Arg1]％の最大ライフを失い、1層の<SilkKeywords:織命>を獲得。この戦闘中「<DerivativeCardKeywords_138:導きの糸>」が失ったライフとアラクネが与える<CutKeywords:運命の裁き>が[Arg2]％増加。虚無：アラクネはランダムに15〜30狂気を獲得。"
  },
  Skill_126488_Name = {
    Text = "導きの糸"
  },
  Skill_126490_AwakerSkillBackgroundStory = {
    Text = "帷が上がるその瞬間、 人形たちは頭を上げ、紡ぎ車の向こうにある優しい顔を見た。\n糸が張り詰め、人形たちの歌と踊りの中で、彼女は母のように微笑んだ。 \n運命の劇場で、彼女はそれらの唯一の観客だった。"
  },
  Skill_126490_BattleDesc_0 = {
    Text = "アラクネは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：「湮滅」：超次元空間のカード1枚を取り出して次に使用する時に2回効果を発動させ、 次に出す指令カードに<SingularityKeywords3:次元転移>を発動させるように変更する。"
  },
  Skill_126490_BattleDesc_15 = {
    Text = "アラクネは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「湮滅」が超次元空間の指令カードを 1 枚選んで取り出し、「次に発射した後1回追加で発動」を付与し、次に発射する 1 枚の指令カードに<SingularityKeywords3:次元シャトル>を発動させる効果に変わる。「湮滅」を発動した直後、全ての敵に「運命裁断」の 50％ に相当する<FixedDamage:純粋ダメージ>を与え、次の狂気解放が与えるダメージ強化とシールドを 50％ 上昇させる。"
  },
  Skill_126490_Desc_0 = {
    Text = "アラクネは [Arg2]％ 基礎狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「湮滅」：超次元空間のカード1枚を取り出して「次に使用する時に追加で1回発動」を付与し、次に出す指令カードに<SingularityKeywords3:次元転移>を発動させるように変更する。"
  },
  Skill_126490_Desc_15 = {
    Text = "アラクネは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「湮滅」が超次元空間の指令カードを 1 枚選んで取り出し、「次に発射した後1回追加で発動」を付与し、次に発射する 1 枚の指令カードに<SingularityKeywords3:次元シャトル>を発動させる効果に変わる。「湮滅」を発動した直後、全ての敵に「運命裁断」の 50％ に相当する<FixedDamage:純粋ダメージ>を与え、次の狂気解放が与えるダメージ強化とシールドを 50％ 上昇させる。"
  },
  Skill_126490_EffectNameList = {Text = "狂気"},
  Skill_126490_Name = {
    Text = "人形劇の開幕"
  },
  Skill_126656_Desc = {
    Text = "位置1の覚醒体に後置行動を追加し、その打撃カードを発射する。"
  },
  Skill_126656_Name = {
    Text = "追撃テスト"
  },
  Skill_126657_Desc = {
    Text = "前列の敵に後置行動を追加し、その現在の意図を発射する。"
  },
  Skill_126657_Name = {
    Text = "追撃テスト"
  },
  Skill_126658_Desc = {
    Text = "守秘者に後置行動を追加させ、スキル@主人公スキル@頭の中の音を発射する。"
  },
  Skill_126658_Name = {
    Text = "追撃テスト"
  },
  Skill_126767_BattleDesc = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords:陶酔>を付与する。"
  },
  Skill_126767_Desc_0 = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords:陶酔>を付与する。"
  },
  Skill_126767_Desc_3 = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords0:陶酔>を付与する。"
  },
  Skill_126767_Name = {
    Text = "心を交わす"
  },
  Skill_126768_BattleDesc = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126768_Desc_0 = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126768_Desc_3 = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126768_Name = {
    Text = "魂を奪う"
  },
  Skill_126793_Desc = {
    Text = "1点の行動力を獲得し、すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点減少させる。「徐」がチームにいる場合、すべての敵に1層の<WitherKeywords:陶酔>を付与する。"
  },
  Skill_126793_Name = {
    Text = "屋敷に眠る過去"
  },
  Skill_126880_BattleDesc = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords:陶酔>を付与し、付与する毒が200％増加する。"
  },
  Skill_126880_Desc_0 = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords:陶酔>を付与し、付与する毒が200％増加する。"
  },
  Skill_126880_Desc_3 = {
    Text = "すべての敵に[Arg1]点の<WitherKeywords0:陶酔>を付与し、付与する毒が200％増加する。"
  },
  Skill_126880_Name = {
    Text = "心を交わす"
  },
  Skill_126881_BattleDesc = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに [Arg3] 点の猩紅炉を蓄積し、対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126881_Desc_0 = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに [Arg3] 点の猩紅炉を蓄積し、対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126881_Desc_3 = {
    Text = "全ての敵の<WitherKeywords:酔い痴れ>を除去し、1 スタック除去するごとに [Arg3] 点の猩紅炉を蓄積し、対象の最大ライフの [Arg1]％ の<FixedDamage:純粋ダメージ>を与え、その [Arg2]％ の毒を発動する。"
  },
  Skill_126881_Name = {
    Text = "魂を奪う"
  },
  Skill_127246_Desc = {
    Text = "[Arg1]点の<MonsterTimeBeacon:ループ>を獲得。その後、毎ターン終了時に[Arg2]点の<MonsterTimeBeacon:ループ>を獲得する。"
  },
  Skill_127246_Name = {
    Text = "エントロピー逆行"
  },
  Skill_127247_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。追加で[Arg3]倍の<PowerIconKeywords:力>と<ExhaustionIconKeywords:力減少>を獲得する。使用後、[Arg4]倍に増加する。<MonsterTimeBeacon:ループ>：[Arg5]倍のダメージを与える。"
  },
  Skill_127247_Name = {
    Text = "運命の剣"
  },
  Skill_127248_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。山札と捨て札のカードを[Arg2]枚手札に追加し、<MonsterSightUnbound:超越の眼>と<RetainIconKeywords:保持>を永続的に付与する。<MonsterTimeBeacon:ループ>：追加で[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_127248_Name = {
    Text = "超越の眼"
  },
  Skill_127249_Desc = {
    Text = "敵のターン開始時に、前のターンに最後に使用した[Arg1]枚の指令カードを手札に追加し、<NothingnessIconKeywords:虚無>を付与する。手札に追加できる指令カードが不足している場合は、同じ枚数のカードを引く。[Arg2]点の<MonsterTimeBeacon:ループ>を獲得する。"
  },
  Skill_127249_Name = {
    Text = "背理収束"
  },
  Skill_127250_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<BlindingKeywords:盲目>を付与する。<MonsterTimeBeacon:ループ>：追加で[Arg4]回のダメージと[Arg5]点の<BlindingKeywords:盲目>を付与する。"
  },
  Skill_127250_Name = {Text = "攻撃"},
  Skill_127251_Desc = {
    Text = "敵のターン開始時に、前のターンに最後に使用した[Arg1]枚の指令カードを手札に追加し、<NothingnessIconKeywords:虚無>と<DepleteIconKeywords:除外>を付与する。手札に追加できる指令カードが不足している場合は、同じ枚数のカードを引く。[Arg2]点の<MonsterTimeBeacon:ループ>を獲得する。"
  },
  Skill_127251_Name = {
    Text = "背理収束"
  },
  Skill_127252_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。山札と捨て札のカード[Arg2]枚を手札に追加し、<MonsterSightUnbound:超越の眼>、<RetainIconKeywords:保持>、<SlowIconKeywords:遅延>を永続的に付与する。<MonsterTimeBeacon:ループ>：追加で[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_127252_Name = {
    Text = "超越の眼"
  },
  Skill_127698_Desc = {
    Text = "[Arg1]点の<FragileIconKeywords:脆弱>を付与する。カード[Arg2]枚に[Arg3]点の<BrokenCard:陰の妨害>を付与する。"
  },
  Skill_127698_Name = {Text = "破断"},
  Skill_127699_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手の山札にランダムな症状を[Arg3]枚追加する。"
  },
  Skill_127699_Name = {
    Text = "黒き死の口づけ"
  },
  Skill_127700_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_127700_Name = {
    Text = "毒の唾液"
  },
  Skill_128020_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。カード[Arg2]枚に[Arg3]点の<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_128020_Name = {
    Text = "影に絡む糸"
  },
  Skill_128021_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。相手の山札に<DepleteIconKeywords:除外>が付与されたランダムな覚醒体の「攻撃」を[Arg3]枚追加する。"
  },
  Skill_128021_Name = {
    Text = "幻毒の侵蝕"
  },
  Skill_128048_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージを1回与えるたび、対象から[Arg3]点の<PowerIconKeywords:力>を減少させる。"
  },
  Skill_128049_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:虚弱>を付与する。手札または山札にある指令カード[Arg2]枚を[Arg3]ターンの間封印する。"
  },
  Skill_128049_Name = {
    Text = "呪縛の網"
  },
  Skill_128052_Desc = {
    Text = "[Arg1] 層の<WeaknessIconKeywords:虚弱>を付与し、手札またはドロー山の上から [Arg2] 枚の指令カードを [Arg3] ターン封印する。前列に移動し、後方に [Arg4] 体の冷蛛群を召喚する。"
  },
  Skill_128052_Name = {
    Text = "呪縛の網"
  },
  Skill_128053_Desc = {
    Text = "[Arg1]層の<WeaknessIconKeywords:虚弱>を付与し、[Arg2]枚の手札またはドロー山の上の指令カードを[Arg3]ターン封印する。前列に移動し、後列に[Arg4]体の小型冷蛛白群を召喚する。"
  },
  Skill_128053_Name = {
    Text = "呪縛の網"
  },
  Skill_128207_Desc = {
    Text = "行動を終了するたび、[Arg1]点の<ParcloseIconKeywords:バリア>と[Arg2]点の<Chapter5_Monster_Fervor1:一時的な狂熱>を獲得する。"
  },
  Skill_128207_Name = {
    Text = "織母の揺りかご"
  },
  Skill_128227_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージを1回与えるたび、対象の指令カードを[Arg3]枚捨てさせる。"
  },
  Skill_128227_Name = {Text = "壊滅"},
  Skill_128229_Desc = {
    Text = "[Arg1] 層の<FragileIconKeywords: 脆弱>を付与し、手札またはドロー山の上から [Arg2] 枚の指令カードに [Arg3] 層の<BrokenCard:暗中破坏>を付加する。前列に移動し、後方に [Arg4] 体の淵獄蜘蛛群を召喚する。"
  },
  Skill_128229_Name = {
    Text = "崩壊の糸"
  },
  Skill_128230_Desc = {
    Text = "[Arg1]点の<FragileIconKeywords:脆弱>を付与し、手札またはドロー山の上にある[Arg2]枚の指令カードに[Arg3]点の<BrokenCard:暗中破壊>を付与する。前列に移動し、後列に[Arg4]体の小型冷蛛黒群を召喚する。"
  },
  Skill_128230_Name = {
    Text = "崩壊の糸"
  },
  Skill_128233_Desc = {
    Text = "[Arg1]点の<FragileIconKeywords:脆弱>を付与する。手札または山札にある指令カード[Arg2]枚に[Arg3]点の<BrokenCard:陰の妨害>を付与する。"
  },
  Skill_128233_Name = {
    Text = "崩壊の糸"
  },
  Skill_128254_Desc = {
    Text = "毎ターン終了時、[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の<Chapter5_Monster_Fervor2:一時的な狂熱>を獲得。"
  },
  Skill_128254_Name = {
    Text = "織母の囁き"
  },
  Skill_128474_Desc = {
    Text = "前列の味方と位置を交換し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与える。このターンに「古の残り火」をすべて除去した場合、[Arg3]点の一時的な<ReinforcePVEKeywords:堅固>を獲得し、<Damage:[Damage:Arg4]>ダメージを[AttackTimes:Arg5]回与え、[Arg6]点の<Chapter5_Monster_Fervor1:一時的な狂熱>を獲得する「叩撃」に転換する。"
  },
  Skill_128474_Name = {
    Text = "狂気の叩撃"
  },
  Skill_128475_Desc = {
    Text = "前列の味方と位置を交換し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与える。[Arg3]点の<Chapter5_Monster_Fervor1:一時的な狂熱>を獲得する。"
  },
  Skill_128475_Name = {Text = "叩撃"},
  Skill_128476_Desc = {
    Text = "前列の味方と位置を交換し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。このターンに「古の残り火」をすべて除去した場合、[Arg3]点の一時的な<ReinforcePVEKeywords:堅固>を獲得し、<Damage:[Damage:Arg4]>ダメージを[AttackTimes:Arg5]回与え、[Arg6]点の<Chapter5_Monster_Fervor1:一時的な狂熱>を獲得する「叩撃」に転換する。"
  },
  Skill_128476_Name = {
    Text = "狂気の叩撃"
  },
  Skill_128477_Desc = {
    Text = "前列の味方と位置を交換し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<Chapter5_Monster_Fervor1:一時的な狂熱>を獲得する。"
  },
  Skill_128477_Name = {Text = "叩撃"},
  Skill_128624_Desc = {
    Text = "この行動予測に転換すると、即座に[Arg1]点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。ブロックされなかったダメージを[Arg4]回与えるたび、[Arg5]点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。"
  },
  Skill_128624_Name = {
    Text = "狂喜の繭"
  },
  Skill_128625_Desc = {
    Text = "この行動予測に転換すると、即座に[Arg1]点の<EmptinessKeywords:虚無>を付与し、すべての覚醒体が[Arg2]狂気を失う。[Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg4]回与え、すべての手札を捨てる。"
  },
  Skill_128625_Name = {
    Text = "恐惧の繭"
  },
  Skill_128627_Desc = {
    Text = "この行動予測に転換すると、次のターン開始まで、指令カードを[Arg1]枚使用するたび、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。<Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg4]回与える。相手のライフが低いほどダメージが増加し、最大<Damage:[Damage:Arg5]>ダメージ。"
  },
  Skill_128627_Name = {
    Text = "暴怒の繭"
  },
  Skill_128628_Desc = {
    Text = "この行動予測に転換すると、ランダムな症状を[Arg1]枚手札に追加する。[Arg2]点の<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>と[Arg3]点の<BleedingIconKeywords:出血>を付与し、このターンに症状を[Arg4]枚使用するたび<BleedingIconKeywords:出血>効果が[Arg5]増加する。"
  },
  Skill_128628_Name = {
    Text = "哀憐の繭"
  },
  Skill_128689_Desc = {
    Text = "一時的なクリティカルレート +[Arg1]%、行動力を1点獲得する。本戦闘で初めて発動した時、すべての敵に [Arg3] 点の<AshesPastKeyWord:古代の灰>を与える。"
  },
  Skill_128689_Name = {
    Text = "年の瀬の花火"
  },
  Skill_129565_BattleDesc_1 = {
    Text = "味方全体に一時的な<StrongEffectKeywords:強効>+[Arg3]を付与。戦死した味方1体につき追加で[Arg1]の一時的な<StrongEffectKeywords:強効>を獲得。"
  },
  Skill_129565_Desc_1 = {
    Text = "味方全体に一時的な<StrongEffectKeywords:強効>+[Arg1]を付与。味方が1体死亡するごとに一時的な<StrongEffectKeywords:強効>+1。"
  },
  Skill_129565_Name_1 = {
    Text = "年の瀬の花火"
  },
  Skill_129565_UnknownName = {
    Text = "年の瀬の花火"
  },
  Skill_129615_Desc = {
    Text = "この行動予測に転換する地、即座に[Arg1]点の<EmptinessKeywords:虚無>を付与し、すべての覚醒体が[Arg2]狂気を失う。[Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg4]回与え、すべての手札を捨てる。"
  },
  Skill_129615_Name = {
    Text = "恐惧の繭"
  },
  Skill_129616_Desc = {
    Text = "この行動予測に転換すると、次のターン開始まで、指令カードを[Arg1]枚使用するたび、[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。<Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg4]回与える。相手のライフが低いほどダメージが増加し、最大<Damage:[Damage:Arg5]>ダメージ。"
  },
  Skill_129616_Name = {
    Text = "暴怒の繭"
  },
  Skill_129617_Desc = {
    Text = "この行動予測に転換すると、ランダムな症状を[Arg1]枚手札に追加する。[Arg2]点の<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重傷>と[Arg3]点の<BleedingIconKeywords:出血>を付与し、このターンに症状を[Arg4]枚使用するたび、<BleedingIconKeywords:出血>効果が[Arg5]増加する。"
  },
  Skill_129617_Name = {
    Text = "哀憐の繭"
  },
  Skill_129618_Desc = {
    Text = "この行動予測に転換すると、即座に[Arg1]点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。ブロックされなかったダメージを[Arg4]回与えるたび、[Arg5]点の<Chapter5_Monster_Fervor3:狂熱>を獲得する。"
  },
  Skill_129618_Name = {
    Text = "狂喜の繭"
  },
  Skill_129622_Desc = {
    Text = "この行動予測に転換すると、即座に[Arg1]点の<EmptinessKeywords:虚無>を付与し、すべての覚醒体が[Arg2]狂気を失う。[Damage:[Damage:Arg3]>ダメージを[AttackTimes:Arg4]回与え、すべての手札を捨てる。"
  },
  Skill_129622_Name = {
    Text = "恐惧の繭"
  },
  Skill_129638_Desc = {
    Text = "この行動予測は転換不可。この行動予測に転換すると、即座に[Arg1]点の一時的な<ReinforcePVEKeywords:堅固>を獲得する。\n<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。ランダムな症状を[Arg4]枚追加する。[Arg5]点の<Chapter5_Monster_Fervor3:狂熱>を獲得。すべての覚醒体は[Arg6]狂気を失う。"
  },
  Skill_129638_Name = {
    Text = "繭を破りし狂宴"
  },
  Skill_129811_Desc = {
    Text = "戦略を1つ選択する。「葬骸の主」が「残骸収集」を発動するたび、手札に追加する。"
  },
  Skill_129811_Name = {
    Text = "戦略を立てる"
  },
  Skill_129812_Desc = {
    Text = "すべての敵が与えるダメージを一時的に30%減少させる。"
  },
  Skill_129812_Name = {Text = "干渉"},
  Skill_129813_Desc = {
    Text = "すべての敵が[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。「葬骸の主」は<Guaiwucanhai:残骸>を半分失う。"
  },
  Skill_129813_Name = {Text = "奇襲"},
  Skill_129822_Desc = {
    Text = "[Arg1]点の<EmptinessKeywords:虚無>と<WeaknessIconKeywords:虚弱>状態を付与し、失ったライフの[Arg2]%を回復する。超次元空間の左から[Arg3]枚のカードを山札の一番上追加し、ランダムな指令カード[Arg4]枚を「次元の裂け目」に入れる。"
  },
  Skill_129822_Name = {
    Text = "運命の縛糸"
  },
  Skill_129823_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「次元の裂け目」のカード1枚につき、追加でダメージを1回与える。"
  },
  Skill_129823_Name = {
    Text = "無限の糸"
  },
  Skill_129824_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:易傷>を付与し、「次元の裂け目」のカード1枚につき、追加で1点付与する。"
  },
  Skill_129824_Name = {
    Text = "永遠の織成"
  },
  Skill_129826_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。ランダムな指令カード[Arg2]枚コピーを「次元の裂け目」に入れ、<DerivativeCardKeywords_23:傷口>を[Arg3]枚山札に追加する。"
  },
  Skill_129826_Name = {
    Text = "運命よ、我が意のままに"
  },
  Skill_129827_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、ランダムな指令カード[Arg2]枚のコピーを「次元の裂け目」に入れる。ランダムな<AberrationKeywords:変異>を[Arg3]枚山札に追加する。"
  },
  Skill_129827_Name = {
    Text = "運命を凌駕する悲歌"
  },
  Skill_129828_Desc = {
    Text = "「断糸震鳴」発動後のインテントを変更する。ランダムな指令カード [Arg1] 枚のコピーを「次元裂隙」に置き、[Arg2] 枚のカードが「次元裂隙」から離れるたびに [Arg3] 層の<BrokenCard:暗中破壊>を付与する。"
  },
  Skill_129828_Name = {
    Text = "人形劇の開幕"
  },
  Skill_129856_Desc = {
    Text = "触腕を1本生成し、[Arg1]点の一時的な触腕ダメージを獲得する。"
  },
  Skill_129856_Name = {
    Text = "王権の威"
  },
  Skill_129857_Desc = {
    Text = "「震怒」、12点の「眠気」、[Arg1]点の触腕ダメージを獲得する。"
  },
  Skill_129857_Name = {
    Text = "不朽の威厳"
  },
  Skill_129858_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。自身のライフ上限を[Arg3]%増加。"
  },
  Skill_129858_Name = {
    Text = "等価交換"
  },
  Skill_129869_Desc = {
    Text = "カスタム実行指令"
  },
  Skill_129869_Name = {
    Text = "封印テスト"
  },
  Skill_130234_Desc_1 = {
    Text = "他のランダムな「キーオーダー」を[Arg1]枚見て、1枚を選択して手札に追加する。"
  },
  Skill_130234_Name_1 = {
    Text = "不平等な交換"
  },
  Skill_130234_UnknownName = {
    Text = "不平等な交換"
  },
  Skill_130240_Desc = {
    Text = "覚醒体を1体選択し、[Arg1]狂気を獲得する。他の覚醒体に[Arg2]狂気を獲得させる。「モス」がパーティにいる場合、「渦巻き！流れろ！弾て！」追撃を行う。"
  },
  Skill_130240_Name = {
    Text = "溺れゆく純真"
  },
  Skill_130351_Desc = {
    Text = "ドローフェイズ後手札にある場合、ランダムな指令カード1枚を「強制的に使用」し、効果を2回発動する。\n使用後、次に使用する指令カードは追加で効果を2回発動する。[Arg1]回使用後に、これを除外する。([Arg2]/[Arg1])"
  },
  Skill_130351_Name = {
    Text = "操り人形"
  },
  Skill_130385_Desc = {
    Text = "ドローフェイズ後に手札にある場合、手札ランダムな指令カード2枚から1枚を選んで強制的に使用し、効果を2回発動させる。\n使用後、次に使用する指令カードは行動力消費が2減少し、効果を2回発動する。[Arg1]回使用後、これを除外する。([Arg2]/[Arg1])"
  },
  Skill_130385_Name = {
    Text = "操り人形"
  },
  Skill_130386_Desc = {
    Text = "ドローフェイズ後手札にある場合、ランダムな指令カード2枚から1枚を選んで強制的に使用し、効果を2回発動する。\n使用後、次に使用する指令カードは追加で2回効果を発動する。[Arg1]回使用後に、これを除外する。([Arg2]/[Arg1])"
  },
  Skill_130386_Name = {
    Text = "操り人形"
  },
  Skill_130471_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。次元の裂け目にあるカード1枚につき、ダメージが[Arg3]増加する。ブロックされなかったダメージを1回与えるたび、1点の<ResentChainsKeywords:怨恨の鎖>を獲得する。"
  },
  Skill_130471_Name = {
    Text = "貫く無数の糸"
  },
  Skill_130472_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身のデバフを解除する。ブロックされなかったダメージを1回与えるたび、自身の最大ライフが3%増加する。"
  },
  Skill_130472_Name = {
    Text = "「岡目八目」"
  },
  Skill_130473_Desc = {
    Text = "他の味方が[Arg1]点の<PowerIconKeywords:力>を獲得し、自身は[Arg2]点の<PowerIconKeywords:力>と[Arg3]%の一時的な<Baojidikang:クリティカル耐性>を獲得し、<Chapter5_Monster_Agitation:淵獄の門>が付与された眷属を2体召喚する。"
  },
  Skill_130473_Name = {
    Text = "眷属の羽化"
  },
  Skill_130474_Desc = {
    Text = "この行動予測に転換すると、[Arg1]点の<BleedingIconKeywords:出血>を付与する。[Arg2]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_130474_Name = {
    Text = "運命を断つ赤い糸"
  },
  Skill_130475_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、すべての覚醒体の基礎狂気+[Arg2]。"
  },
  Skill_130475_Name = {
    Text = "「暗夜行路」"
  },
  Skill_130476_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。「次元の裂け目」を閉じる。"
  },
  Skill_130476_Name = {
    Text = "運命を凌駕する悲歌"
  },
  Skill_130477_Desc = {
    Text = "この行動予測に転換すると、「運命の誓約」と<Chapter5_Monster_Fervor4:狂熱>を除去し、他の味方を消滅させる。自身の現在のライフと最大ライフが250%増加する。「古の残り火」の点数が2倍になる。50点の「融蝕の霧の盾」を獲得し、「次元の裂け目」を開く。"
  },
  Skill_130477_Name = {
    Text = "暗夜を紡ぐ糸車"
  },
  Skill_130478_Desc = {
    Text = "「運命の断片」を持つすべての指令カードを[Arg1]ターン「封印」し、他の指令カードに[Arg2]点の<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_130478_Name = {
    Text = "「覆水盆に返らず」"
  },
  Skill_130479_Desc = {
    Text = "この行動予測に転換すると、[Arg1]点の<BleedingIconKeywords:出血>を付与する。[Arg2]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。次元の裂け目にカードが[Arg3]枚以上ある場合、追加で[Arg4]点の<FragileIconKeywords:脆弱>、<BlindingKeywords:盲目>、<Decay:腐朽>を付与する。"
  },
  Skill_130479_Name = {
    Text = "朽ちた運命の赤い糸"
  },
  Skill_130491_Desc = {
    Text = "プレイヤーは[Power:Arg1]点の<PowerIconKeywords:力>、<Block:[Block:Arg2]>点のシールド、[Heal:Arg3]点の治癒、[TentaclePower:Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5]層の<RetaliateIconKeywords:反撃>を得て、前列の敵に<Damage:[Damage:Arg6]>点のダメージを[Arg7]回与え、[Poison:Arg8]層の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg9]層の<ExhaustionIconKeywords:衰弱>を付与します。"
  },
  Skill_130491_Name = {
    Text = "七色大砲α"
  },
  Skill_130493_Desc = {
    Text = "2点の行動力を獲得し、カードを2枚引く。"
  },
  Skill_130493_Name = {
    Text = "リアのコイン"
  },
  Skill_130506_Desc = {
    Text = "手札のすべての指令カードをランダムに山札へ戻す。戻した指令カードは、次回使用時に25%の確率で追加でもう1回発動する。指令カードを1枚戻すごとに、すべての覚醒体が2狂気を獲得。"
  },
  Skill_130506_Name = {
    Text = "ギャンブルの知恵"
  },
  Skill_130507_Desc = {
    Text = "手札のすべての指令カードをランダムに山札へ戻す。戻した指令カードは、次回使用時に13%の確率で追加でもう1回発動する。指令カードを1枚戻すごとに、すべての覚醒体が2狂気を獲得。"
  },
  Skill_130507_Name = {
    Text = "ギャンブルの知恵"
  },
  Skill_130508_Desc = {
    Text = "手札のすべての指令カードをランダムに山札へ戻す。戻した指令カードは、次回使用時に17%の確率で追加でもう1回発動する。指令カードを1枚戻すごとに、すべての覚醒体が2狂気を獲得。"
  },
  Skill_130508_Name = {
    Text = "ギャンブルの知恵"
  },
  Skill_130509_Desc = {
    Text = "手札のすべての指令カードをランダムに山札へ戻す。戻した指令カードは、次回使用時に21%の確率で追加でもう1回発動する。指令カードを1枚戻すごとに、すべての覚醒体が2狂気を獲得。"
  },
  Skill_130509_Name = {
    Text = "ギャンブルの知恵"
  },
  Skill_130513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：装備時とターン開始時、以下の効果からランダムに1つ発動する：<Energy:[Energy:Arg1]> 狂気を獲得し自身を<PVPSlowKeywords:鈍足>にする；<Energy:[Energy:Arg3]> 狂気を獲得する；<Energy:[Energy:Arg4]> と[Arg5]枚の<PVPDerivativeCardKeywords_17:「インスピレーション」>を獲得する。"
  },
  Skill_130513_Name_1 = {
    Text = "ギャンブルの知恵"
  },
  Skill_130928_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与える。キルを達成しなかった場合、[Arg2]層の<PVPWaterPowerKeyWords:渦流>を獲得。"
  },
  Skill_130928_Name_1 = {
    Text = "深淵！渦巻き！大爆発"
  },
  Skill_130929_AwakerSkillBackgroundStory = {
    Text = "活き活きと恐ろしい大砲を振り回し、ぴょんぴょん跳ねながら戦場に入る。\n悩みも危険も気にせず、友達に比べれば、それらはなんて些細なことだ。\n「友達、困った！モスク、登場！」"
  },
  Skill_130929_BattleDesc_0 = {
    Text = "モスクは<Energy:[Energy:Arg1]>点の狂気を獲得します。<ExaltIconKeywords:霊知啓発>：1枚の「装填」を引く。モスクが追撃を放った後、次回モスクの狂気解放は最大[Arg3]回まで+[Arg2]％の触腕ダメージバフを追加で享受します。"
  },
  Skill_130929_BattleDesc_15 = {
    Text = "モスは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「装填」を 1 枚ドローする。モスが追撃を発動した後、次のモスの狂気解放は追加で [Arg2]％ の触手ダメージバフを受け、次の狂気解放でライフが最も高い敵に最大ライフの [Arg4]％ の<FixedDamage:純粋ダメージ>を与え、最大 [Arg3] 回まで重複する。"
  },
  Skill_130929_Desc_0 = {
    Text = "モスは[Arg5]％の基礎狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「チャージ！」を1枚引く。モスが追撃を発動した後、次のモスの狂気解放は追加で[Arg2]％の触腕ダメージボーナスを獲得する。最大[Arg3]回まで。"
  },
  Skill_130929_Desc_15 = {
    Text = "モスは [Arg5]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「装填」を 1 枚ドローする。モスが追撃を発動した後、次のモスの狂気解放は追加で [Arg2]％ の触手ダメージバフを受け、次の狂気解放でライフが最も高い敵に最大ライフの [Arg4]％ の<FixedDamage:純粋ダメージ>を与え、最大 [Arg3] 回まで重複する。"
  },
  Skill_130929_EffectNameList = {
    Text = "狂気,触腕ダメージボーナス"
  },
  Skill_130929_Name = {
    Text = "渦巻き、来る！"
  },
  Skill_130930_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Block:[Block:Arg1]>点のシールドと<DelayKeywords:レイテンシ>：<Energy:[Energy:Arg2]>狂気を獲得する。"
  },
  Skill_130930_Name_1 = {
    Text = "遠いエデン"
  },
  Skill_130931_AwakerSkillBackgroundStory = {
    Text = "渦巻きは破壊をもたらし、深淵は破壊をもたらす。\n友情と陽光を求める少女は結局、永遠の孤独に帰還した。\n泣き叫ぶ、哀号する、ねじれる、クラッシュする、それは彼女がモスクスにいる時の往復ループだ。\nこれはモスクスの下で深淵が全てを飲み込む咆哮である。\nまた、モスクが彼を打ち勝つ証明でもある。"
  },
  Skill_130931_BattleDesc_0 = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にして([Arg4]本)、この狂気解放のクリティカルダメージ+50%。（クリティカル率：[Arg5]%、触腕ダメージボーナス：[Arg8]%）"
  },
  Skill_130931_BattleDesc_1 = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にし([Arg4]本)、1本につきこの狂気解放のクリティカルダメージ+50%。（クリティカル率:：[Arg5]%、触腕ダメージボーナス：[Arg8]%）[Arg6]点の界域知識を獲得。"
  },
  Skill_130931_BattleDesc_3 = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に3倍のダメージを与える。最大3本の永久的な触腕を犠牲にし([Arg4]体)、1本につきこの狂気解放のクリティカルダメージを+50%。（クリティカル率:：[Arg5]%、触腕ダメージボーナス：[Arg8]%）[Arg6]点の界域知識を獲得。狂気を20消費するごとに、他の覚醒体に1狂気を獲得させる。"
  },
  Skill_130931_Desc_0 = {
    Text = "手札にあるカードの<BurningKeywords2:燃焼>を解除。すべての敵に[Arg7]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスのダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にして、1本につきこの狂気解放のクリティカルダメージ+50％。"
  },
  Skill_130931_Desc_1 = {
    Text = "手札にあるカードの<BurningKeywords2:燃焼>を解除。すべての敵に[Arg7]%の<TentacleInjurieIconKeywords:触腕ダメージ>を与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にして、1本につきこの狂気解放のクリティカルダメージ+50%。[Arg6]点の界域知識を獲得。"
  },
  Skill_130931_Desc_3 = {
    Text = "手札にあるカードの<BurningKeywords2:燃焼>を解除。すべての敵に[Arg7]%の<TentacleInjurieIconKeywords:触腕ダメージ>を与え、ライフが最も高い敵に3倍のダメージを与える。最大3本の永久的な触腕を犠牲にして、1本につきこの狂気解放のクリティカルダメージ+50%。[Arg6]点の界域知識を獲得。狂気を20消費するごとに他の覚醒体に1狂気を獲得させる。"
  },
  Skill_130931_EffectNameList = {
    Text = "触腕ダメージボーナス"
  },
  Skill_130931_Name = {
    Text = "深淵！渦巻き！大砲！"
  },
  Skill_130931_OverLimitUtlSkillDesc = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に3倍のダメージを与える。最大3本の永久的な触腕を犠牲にし([Arg4]本)、1本につきこの狂気解放のクリティカルダメージ+100%。（クリティカル率：[Arg5]%、触腕ダメージボーナス：[Arg8]%）[Arg6]点の界域知識を獲得。次の5回の「渦巻き！流れろ！弾て！」は2回発動する。"
  },
  Skill_130931_tempBattleDesc_1 = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にして([Arg4]本)、この狂気解放のクリティカルダメージ+50%。（クリティカル率：[Arg5]%、触腕ダメージボーナス：[Arg8]%）"
  },
  Skill_130931_tempBattleDesc_2 = {
    Text = "手札にあるカードの<BurningKeywords:燃焼>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の永久的な触腕を犠牲にし([Arg4]本)、1本につきこの狂気解放のクリティカルダメージ+50%。（クリティカル率:：[Arg5]%、触腕ダメージボーナス：[Arg8]%）[Arg6]点の界域知識を獲得。"
  },
  Skill_130931_tempBattleDesc_3 = {
    Text = "手札のすべてのカードの<BurningKeywords:燃焼>ステータスを解除する。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフが最も高い敵には3倍のダメージを与える。最大3体の永久的なタッチアーム([Arg4]体)を犠牲にし、各タッチアームが今回の狂気解放のクリティカルダメージを＋50％にする（現在のクリティカル率: [Arg5]％。触腕ダメージバフ: [Arg8]％）。[Arg6]ポイントの界域知識を獲得し、20ポイントの狂気を消費するごとに他の覚醒体に1ポイントの狂気を与える。"
  },
  Skill_130931_tempBattleDesc_4 = {
    Text = "手札の全カードの<BurningKeywords:燃焼>ステータスを解除する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを与え、ライフが最も高い敵に三倍のダメージと最大ライフの [Arg9]％ の<FixedDamage:純粋ダメージ>を与える。最大 3 本の追加の永久的なタッチアーム（[Arg4] 本）を犠牲にし、1 本ごとに今回の狂気解放のクリティカルダメージ +50％（現在のクリティカル率：[Arg5]％。触手ダメージバフ：[Arg8]％）。[Arg6] 点の界域知識を獲得し、20 点の狂気を消費するごとに他の覚醒体が 1 点の狂気を獲得する。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_1 = {
    Text = "手札のすべてのカードの<BurningKeywords:燃焼>ステータスを解除。すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の余分な永久的なタッチアーム([Arg4]本)を犠牲にし、1本ごとに今回の狂気解放のクリティカルダメージ+100％(現在のクリティカル率：[Arg5]％。触腕ダメージバフ：[Arg8]％)。次に発動する5回の「渦！流！弾！」が2回発動する。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_2 = {
    Text = "手札のすべてのカードの<BurningKeywords:燃焼>ステータスを解除。すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、ライフが最も高い敵に2倍のダメージを与える。最大3本の余分な永久的なタッチアーム([Arg4]本)を犠牲にし、1本ごとに今回の狂気解放のクリティカルダメージ+100％(現在のクリティカル率：[Arg5]％。触腕ダメージバフ：[Arg8]％)。[Arg6]点の界域知識を獲得。次に発動する5回の「渦！流！弾！」が2回発動する。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_3 = {
    Text = "手札のすべてのカードの<BurningKeywords:燃焼>ステータスを解除。すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、ライフが最も高い敵に3倍のダメージを与える。最大3本の余分な永久的なタッチアーム([Arg4]本)を犠牲にし、1本ごとに今回の狂気解放のクリティカルダメージ+100％(現在のクリティカル率：[Arg5]％。触腕ダメージバフ：[Arg8]％)。[Arg6]点の界域知識を獲得し、狂気を20点消費するごとに他の覚醒体が1点の狂気を獲得する。次に発動する5回の「渦！流！弾！」が2回発動する。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_4 = {
    Text = "手札の全カードの<BurningKeywords:燃焼>ステータスを解除する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを与え、ライフが最も高い敵に三倍のダメージと最大ライフの [Arg9]％ の<FixedDamage:純粋ダメージ>を与える。最大 3 本の追加の永久的なタッチアーム（[Arg4] 本）を犠牲にし、1 本ごとに今回の狂気解放のクリティカルダメージ +100％（現在のクリティカル率：[Arg5]％。触手ダメージバフ：[Arg8]％）。[Arg6] 点の界域知識を獲得する。次に発動する 5 回の「渦！流！弾！」が 2 回発動する。"
  },
  Skill_130932_AwakerSkillBackgroundStory = {
    Text = "「ギシギシ…………」\n凶悪な巨大砲が青い渦を次々と飲み込み、存在しない音を発している。\n一発飲み込むごとに、モンスターの瞳孔の猩紅が一層濃くなる。\nそれは待っている、待っている…………\n天真爛漫な主人が命令を下すその瞬間を。"
  },
  Skill_130932_BattleDesc = {
    Text = "<DerivativeCardKeywords_132:>1点の<WhirlpoolKeywords:渦巻き充填>を獲得し、[Arg1]回使用可能。"
  },
  Skill_130932_Desc = {
    Text = "<DerivativeCardKeywords_132:>1点の<WhirlpoolKeywords:渦巻き充填>を獲得し、3回使用可能。"
  },
  Skill_130932_EffectNameList = {
    Text = "「渦巻き！流れろ！弾て！」レベル"
  },
  Skill_130932_Name = {
    Text = "リロード！"
  },
  Skill_130933_Desc = {
    Text = "すべての敵が25点の<ReinforcePVEKeywords:堅固>を獲得。毎ターンドロー枚数-1。すべての覚醒体が獲得するシールドとライフ回復効果が20%増加する。"
  },
  Skill_130933_Name = {
    Text = "毛並みを整える"
  },
  Skill_130934_Desc_0 = {
    Text = "ライフが最も高い敵に [Arg1] の<RealDamage:固定ダメージ>を与え、<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Desc_1 = {
    Text = "ライフが最も高い敵に [Arg1] 点の<RealDamage:固定ダメージ>と対象の最大ライフの [Float:Arg3]％ の<FixedDamage:純粋ダメージ>を与える。<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Name = {
    Text = "渦巻き！流れろ！弾て！"
  },
  Skill_130935_AwakerSkillBackgroundStory = {
    Text = "「ぱたぱた〜悪者を倒す〜」"
  },
  Skill_130935_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>のダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_130935_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与える。<Energy:[Energy:Arg2]>点の狂気を獲得。モスの次の狂気解放のクリティカル率+[Arg3]％、次の「装填」の基礎行動力消費が1減少。"
  },
  Skill_130935_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。モスは <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_130935_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与える。モスは<Energy:[Energy:Arg2]>点の狂気を獲得。モスの次の狂気解放のクリティカル率+[Arg3]％、次の「装填」の基礎行動力消費が1減少。"
  },
  Skill_130935_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_130935_Name = {Text = "攻撃"},
  Skill_130935_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_130936_Desc_1 = {
    Text = "<DelayKeywords:遅延>：<Energy:[Energy:Arg1]> 狂気。次のターン開始まで、ライフを失った後、同量の遅延狂気をシールドに変換する。"
  },
  Skill_130936_Name_1 = {
    Text = "渦流護身"
  },
  Skill_130937_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_130937_Name_1 = {Text = "攻撃"},
  Skill_130938_AwakerSkillBackgroundStory = {
    Text = "「シュッラシュッラ〜友達を守る〜」"
  },
  Skill_130938_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_130938_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>点の狂気を獲得。モスの次の狂気解放のクリティカル率+[Arg3]％、次の「装填」の基礎行動力消費が1減少。"
  },
  Skill_130938_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。モスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_130938_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。モスは<Energy:[Energy:Arg2]>点の狂気を獲得。モスの次の狂気解放のクリティカル率+[Arg3]％、次の「装填」の基礎行動力消費が1減少。"
  },
  Skill_130938_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_130938_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_130939_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージを与え、<PVPDerivativeCardKeywords_27:「深淵！渦！二式！」>にアップグレード。キルを達成しなかった場合、[Arg2]層の<PVPWaterPowerKeyWords:渦流>を獲得。<PVPDerivativeCardKeywords_28:>"
  },
  Skill_130939_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<PVPPenetrateKeywords:貫通>、<PVPDerivativeCardKeywords_28:「深淵！渦！大爆撃！」>にアップグレード。キルを達成しなかった場合、[Arg2]層の<PVPWaterPowerKeyWords:渦流>を獲得。"
  },
  Skill_130939_Desc_3 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与える。キルを達成しなかった場合、[Arg2]層の<PVPWaterPowerKeyWords:渦流>を獲得。"
  },
  Skill_130939_Name_1 = {
    Text = "深淵！渦巻き！大砲！"
  },
  Skill_130939_Name_2 = {
    Text = "深淵！渦巻き！二式"
  },
  Skill_130939_Name_3 = {
    Text = "深淵！渦巻き！大爆発"
  },
  Skill_130940_Desc = {
    Text = "すべての敵の<ReinforcePVEKeywords:堅固>を除去する。失ったライフの50%を回復し、すべての覚醒体は狂気上限分の狂気を獲得する。このターン中、すべての覚醒体は「狂気解放」を2回発動可能。"
  },
  Skill_130940_Name = {
    Text = "二世の攻撃！"
  },
  Skill_130941_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：各ターン初めて「スキル」を発射した後、<HPAndShieldMin:ライフとシールドが最も低い>敵に <Damage:[Damage:Arg1]> のダメージを与える。"
  },
  Skill_130941_Name_1 = {
    Text = "囚われた狂気"
  },
  Skill_130942_AwakerSkillBackgroundStory = {
    Text = "実験でモスクが力を貯める方法を学んで以来、彼女が引き起こす破壊は倍増し始めました。\nしたがって、モスクの周囲に異常な湿気が現れ始めたら、すぐに敵との距離を取ってください。\nモスク自身の言葉を借りると、「まずは蓄力、次に発射、威力大！」です。"
  },
  Skill_130942_Desc = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。次のモスの狂気解放のクリティカル率+[Arg2]％。<RippleKeywords:余波>：他の覚醒体は<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_130942_EffectNameList = {
    Text = "狂気,クリティカル率"
  },
  Skill_130942_Name = {
    Text = "チャージ！"
  },
  Skill_130943_Desc = {
    Text = "すべての敵が25点の<ReinforcePVEKeywords:堅固>を獲得。キーエネルギーの上限と「キーオーダー」発動時に消費するキーエネルギー+350。毎ターン初めて発動する「キーオーダー」は効果が2回発動する。"
  },
  Skill_130943_Name = {
    Text = "おやつを与える"
  },
  Skill_130944_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_130944_Name_1 = {Text = "波動弾"},
  Skill_130945_Desc = {
    Text = "すべての敵が25点の<ReinforcePVEKeywords:堅固>を獲得。すべての覚醒体の基礎狂気が10点増加する。「狂気解放」を発動後、1点の行動力を獲得。覚醒体ごとに毎ターン1回のみ発動可能。"
  },
  Skill_130945_Name = {
    Text = "頬をすり寄せる"
  },
  Skill_130946_Desc_1 = {
    Text = "味方全体に+[Arg1]<PVPWaterPowerKeyWords:渦流>を付与。戦死した味方1体につき追加で+[Arg2]<PVPWaterPowerKeyWords:渦流>。"
  },
  Skill_130946_Name_1 = {
    Text = "溺れゆく純真"
  },
  Skill_130946_UnknownName = {
    Text = "溺れゆく純真"
  },
  Skill_130947_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<PVPPenetrateKeywords:貫通>、<PVPDerivativeCardKeywords_28:「深淵！渦！大爆撃！」>にアップグレード。キルを達成しなかった場合、[Arg2]層の<PVPWaterPowerKeyWords:渦流>を獲得。"
  },
  Skill_130947_Name_1 = {
    Text = "深淵！渦巻き！二式"
  },
  Skill_130948_Desc_1 = {
    Text = "[Arg1]点の<PVPWaterPowerKeyWords:渦流>を獲得し、[Arg2]枚の<PVPDerivativeCardKeywords_26:「波動弾」>を手札に追加する。"
  },
  Skill_130948_Name_1 = {
    Text = "揺蕩波動"
  },
  Skill_131102_Desc = {
    Text = "手札のランダムな指令カード2枚に「<Chapter5_Monster_Support1:繁殖の理>」の刻印を付与する。"
  },
  Skill_131102_Name = {
    Text = "繁殖の理"
  },
  Skill_131114_Desc = {
    Text = "手札のランダムな指令カード2枚に「<Chapter5_Monster_Support2:知識の理>」の刻印を付与する。"
  },
  Skill_131114_Name = {
    Text = "知識の理"
  },
  Skill_131115_Desc = {
    Text = "手札のランダムな指令カード2枚に「<Chapter5_Monster_Support3:歓喜の理>」の刻印を付与する。"
  },
  Skill_131115_Name = {
    Text = "歓喜の理"
  },
  Skill_131192_Desc = {
    Text = "手札にある<ErosionColorInkKeywords:認知錯乱>が付与されたカードすべての行動力消費を-1し、1枚につき狂気が最も少ない覚醒体が<Energy:5>点の狂気を獲得する。その後、各地の<ErosionColorInkKeywords:認知錯乱>が付与されたカードを復元する。本ターン、カードを使用しても他のカードに<ErosionColorInkKeywords:認知錯乱>を付与しない。"
  },
  Skill_131192_Name = {
    Text = "禁忌の真実"
  },
  Skill_131241_Desc = {
    Text = "プレイヤーは[Power:Arg1]点の<PowerIconKeywords:力>、<Block:[Block:Arg2]>点のシールド、[Heal:Arg3]点の治癒、[TentaclePower:Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5]層の<RetaliateIconKeywords:反撃>を得て、前列の敵に<Damage:[Damage:Arg6]>点のダメージを[Arg7]回与え、[Poison:Arg8]層の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg9]層の<ExhaustionIconKeywords:衰弱>を付与します。"
  },
  Skill_131241_Name = {
    Text = "七色大砲β"
  },
  Skill_131365_Desc = {
    Text = "敵のライフに一定割合のダメージを与え、その超次元空間を破壊する。"
  },
  Skill_131365_Name = {
    Text = "糸よ、あるべき場所へ"
  },
  Skill_131438_Desc = {
    Text = "ドローフェイズ後に手札にある場合、手札のランダムな指令カード2枚から1枚を選んで強制的に使用し、効果を2回発動させる。\n使用後、次に使用する指令カードは行動力消費が0になり、効果を2回発動する。[Arg1]回後に、これを除外する。([Arg2]/[Arg1])"
  },
  Skill_131438_Name = {
    Text = "操り人形"
  },
  Skill_131654_Desc = {
    Text = "発射後、指定した覚醒体の狂気値をクリアし、その後1倍の基本狂気を獲得します。"
  },
  Skill_131654_Name = {
    Text = "狂気重盈1倍"
  },
  Skill_131786_Desc = {
    Text = "発射後、ランダムな対象に[Damage:Arg1]ダメージを与え、他の敵に[Damage:Arg2]ダメージを与える。"
  },
  Skill_131786_Name = {
    Text = "目標テスト"
  },
  Skill_131856_AwakerSkillBackgroundStory = {
    Text = "眼球、鼓膜、舌、皮膚、そして大脳……\n行きわたる感覚。\n分かち合う愛と優しさは、あなたのまわりを永遠に巡り続ける……死のその時まで。\n"
  },
  Skill_131856_BattleDesc_0 = {
    Text = "沙耶は <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」を使用した後、各所にいる他の覚醒体が「<DestructionKeywords:破壊>」を持たない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。1ターンに最初の3回、<ErosionColorInkKeywords:認知錯乱>を持つ指令カードを発射すると、沙耶とその指令カードが属する覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_131856_BattleDesc_15 = {
    Text = "沙耶は <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、沙耶は <Energy:[Energy:Arg4]> 点の狂気と1層の<KaiHuajishu:羽種>を獲得する。各地の他の覚醒体が「<DestructionKeywords:破壊>」を持たない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。毎ターン最初の3回、<ErosionColorInkKeywords:認知錯乱>を持つ指令カードを発射すると、沙耶とその指令カードが属する覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_131856_Desc_0 = {
    Text = "沙耶は [Arg3]％ 基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、各所にいる他の覚醒体で「<DestructionKeywords:破壊>」を持たない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。1ターン中の最初の3回、<ErosionColorInkKeywords:認知錯乱>を持つ指令カードを発射すると、沙耶とその指令カードが属する覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_131856_Desc_15 = {
    Text = "沙耶は [Arg3]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、沙耶は <Energy:[Energy:Arg4]> 点の狂気と1層の<KaiHuajishu:羽種>を獲得する。各地の他の覚醒体が「<DestructionKeywords:破壊>」を持たない指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。1ターン中の最初の3回、<ErosionColorInkKeywords:認知錯乱>を持つ指令カードを発射すると、沙耶とその指令カードが属する覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_131856_EffectNameList = {
    Text = "狂気,追加狂気"
  },
  Skill_131856_Name = {
    Text = "認知改造"
  },
  Skill_131857_AwakerSkillBackgroundStory = {
    Text = "求め続けたあの世界へ。\nもう隠れ回る必要のない世界へ辿り着くまで。\nその道を阻むものはすべて、倒すべき『敵』なのだ。"
  },
  Skill_131857_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_131857_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得する。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131857_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。沙耶は<Energy:[Energy:Arg2]>狂気を獲得する。"
  },
  Skill_131857_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを与える。沙耶は <Energy:[Energy:Arg2]> ポイントの狂気を獲得する。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]、現在のライフが低いほど効果が高く、最大 100% 上昇"
  },
  Skill_131857_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_131857_Name = {Text = "攻撃"},
  Skill_131857_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_131858_AwakerSkillBackgroundStory = {
    Text = "恐ろしく、美しく、そして絶望的に。\n「愛」に染まった輝ける生命は、咲き誇りながら歌い上げる。\nそれは、新世界の幕開けを告げ、旧世界の滅びを奏でる唄。"
  },
  Skill_131858_BattleDesc = {
    Text = "【<DevouredIconKeywords:捕食> ：コピーされた「基礎打撃」または「基礎防御」からランダムに 2 枚の行動力消費が 0 になり、追加で 1 回発動する。】<Block:[Block:Arg1]> 点のシールドを獲得する。他の覚醒体一人を選び、山札と捨て札にそれぞれその覚醒体のすべての基本指令カードの原始複製を 1 枚ずつ加え、<NothingnessIconKeywords:虚無>と<DestructionKeywords:破壊>を付与する。すべての<KaiHuajishu:羽種>を消費し、1 層消費するごとにそのうちランダムな「スキル」1 枚の行動力消費が 0 になる。"
  },
  Skill_131858_Desc = {
    Text = "【<DevouredIconKeywords:捕食> ：コピーされた「基礎打撃」または「基礎防御」からランダムに 2 枚の行動力消費が 0 になり、追加で 1 回発動する。】<Block:[Block:Arg1]> 点のシールドを獲得する。他の覚醒体一人を選び、山札と捨て札にそれぞれその覚醒体のすべての基本指令カードの原始複製を 1 枚ずつ加え、<NothingnessIconKeywords:虚無>と<DestructionKeywords:破壊>を付与する。すべての<KaiHuajishu:羽種>を消費し、1 層消費するごとにそのうちランダムな「スキル」1 枚の行動力消費が 0 になる。"
  },
  Skill_131858_EffectNameList = {
    Text = "シールド"
  },
  Skill_131858_Name = {
    Text = "沙耶の唄"
  },
  Skill_131858_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食> ：コピーされた「基礎打撃」または「基礎防御」からランダムに 2 枚の行動力消費が 0 になり、追加で 1 回発動する。】<Block:[Block:Arg1]> 点のシールドを獲得する。他の覚醒体一人を選び、山札と捨て札にそれぞれその覚醒体のすべての基本指令カードの原始複製を 1 枚ずつ加え、<NothingnessIconKeywords:虚無>と<DestructionKeywords:破壊>を付与し、コピーされたすべての「スキル」が追加で 1 回発動する。すべての<KaiHuajishu:羽種>を消費し、1 層消費するごとにそのうちランダムな「スキル」1 枚の行動力消費が 0 になる。"
  },
  Skill_131858_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_131860_AwakerSkillBackgroundStory = {
    Text = "当該覚醒体は、網状筋肉組織を含む一部の原種族の特徴を保持している。\n攻撃を受けた瞬間、筋肉組織が全方位に伸縮し、物理的な手段では損傷を与えることは難しい。"
  },
  Skill_131860_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_131860_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。<Energy:[Energy:Arg2]>狂気を獲得する。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131860_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。沙耶は<Energy:[Energy:Arg2]>狂気を獲得する。"
  },
  Skill_131860_Desc_2 = {
    Text = "<Block:[Block:Arg1]> ポイントのシールドを獲得する。沙耶は <Energy:[Energy:Arg2]> ポイントの狂気を獲得する。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]、現在のライフが低いほど効果が高く、最大 100% 上昇する"
  },
  Skill_131860_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_131860_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_131902_Desc = {
    Text = "発射後、モスクの狂気上限を印刷する。"
  },
  Skill_131902_Name = {
    Text = "機能属性"
  },
  Skill_132227_Desc = {
    Text = "チームに神国深海覚醒体がいる場合+1000パワー、そうでなければ+1000衰弱"
  },
  Skill_132227_Name = {
    Text = "スキル@テスト@新深海職業判定テスト"
  },
  Skill_132357_AwakerSkillBackgroundStory = {
    Text = "「見て！オレッタが魚みたいに泡を吐いてる！」"
  },
  Skill_132357_Desc = {
    Text = "<Block:[Block:Arg1]>ポイントのシールドを獲得し、自身・プレイヤー・前列の敵それぞれにステータスを付与する。発射値・実際値をそれぞれ1回ずつ。"
  },
  Skill_132357_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_132357_Name = {
    Text = "テスト·防御"
  },
  Skill_132357_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_132358_AwakerSkillBackgroundStory = {
    Text = "少女は名残惜しそうに破産した水族館を後にした。報酬として、彼女は数匹のクラゲを家に持ち帰ることを許された。\nそれは彼女の大好きな小さな生き物で、海を漂う精霊、生き生きとした花のような存在だった。\n心を込めて世話をすれば、水槽いっぱいに広がるはず！——彼女はそんな光景を期待していた。"
  },
  Skill_132358_Desc_0 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。"
  },
  Skill_132358_Desc_15 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。オレッタの「攻撃」は刺突ダメージになり、追加でダメージを2回与える。"
  },
  Skill_132358_EffectNameList = {Text = "狂気"},
  Skill_132358_Name = {
    Text = "テスト·覚醒"
  },
  Skill_132359_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132359_Desc = {
    Text = "プレイヤーが [Power:Arg1] ポイントの<PowerIconKeywords:力>、<Block:[Block:Arg2]>  ポイントのシールド、[Heal:Arg3] ポイントの回復、[TentaclePower:Arg4] ポイントの<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5] 層の<RetaliateIconKeywords:反撃>を獲得し、前列の敵に <Damage:[Damage:Arg6]> ポイントのダメージを[Arg7]回与え、[Poison:Arg8] 層の<IntoxicationIconKeywords:中毒>を付与、[Exhaustion:Arg9] 層の<ExhaustionIconKeywords:衰弱>を付与、[FateCut:Arg10] 層の<CutKeywords:運命裁断>を付与する。"
  },
  Skill_132359_Name = {
    Text = "カラフル奥義"
  },
  Skill_132359_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。[Power:Arg2]点の<PowerIconKeywords:力量>と[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、以降5回「腺体分裂」を発動する際、1枚カードを引く。"
  },
  Skill_132360_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132360_Desc = {
    Text = "前列の敵に [Arg1] の通常固定ダメージを [Arg2] 回与える。"
  },
  Skill_132360_Name = {
    Text = "テスト·屈折"
  },
  Skill_132361_AwakerSkillBackgroundStory = {
    Text = "「ふふ！驚いたかい！」"
  },
  Skill_132361_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132361_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132361_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132361_Name = {
    Text = "テスト·打撃"
  },
  Skill_132361_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132361_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132361_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを<PunctureDamagewords:刺突ダメージ>3回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132362_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132362_Desc = {
    Text = "前列の敵に [Arg1] のスパイク固定ダメージを [Arg2] 回与える。"
  },
  Skill_132362_Name = {
    Text = "テスト·鏡返"
  },
  Skill_132363_Desc_1 = {
    Text = "現在行動カード対象テスト"
  },
  Skill_132363_Name_1 = {
    Text = "現在行動カード対象テスト"
  },
  Skill_132425_AwakerSkillBackgroundStory = {
    Text = "少女は名残惜しそうに破産した水族館を後にした。報酬として、彼女は数匹のクラゲを家に持ち帰ることを許された。\nそれは彼女の大好きな小さな生き物で、海を漂う精霊、生き生きとした花のような存在だった。\n心を込めて世話をすれば、水槽いっぱいに広がるはず！——彼女はそんな光景を期待していた。"
  },
  Skill_132425_Desc_0 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。"
  },
  Skill_132425_Desc_15 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。オレッタの「攻撃」は刺突ダメージになり、追加でダメージを2回与える。"
  },
  Skill_132425_EffectNameList = {Text = "狂気"},
  Skill_132425_Name = {
    Text = "テスト·覚醒"
  },
  Skill_132426_AwakerSkillBackgroundStory = {
    Text = "「ふふ！驚いたかい！」"
  },
  Skill_132426_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132426_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132426_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132426_Name = {
    Text = "テスト·打撃"
  },
  Skill_132426_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132426_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132426_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを<PunctureDamagewords:刺突ダメージ>3回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132427_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132427_Desc = {
    Text = "プレイヤーが [Power:Arg1] ポイントの<PowerIconKeywords:力>、<Block:[Block:Arg2]>  ポイントのシールド、[Heal:Arg3] ポイントの回復、[TentaclePower:Arg4] ポイントの<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5] 層の<RetaliateIconKeywords:反撃>を獲得し、前列の敵に <Damage:[Damage:Arg6]> ポイントのダメージを[Arg7]回与え、[Poison:Arg8] 層の<IntoxicationIconKeywords:中毒>を付与、[Exhaustion:Arg9] 層の<ExhaustionIconKeywords:衰弱>を付与、[FateCut:Arg10] 層の<CutKeywords:運命裁断>を付与する。"
  },
  Skill_132427_Name = {
    Text = "テスト·屈折"
  },
  Skill_132428_AwakerSkillBackgroundStory = {
    Text = "少女は名残惜しそうに破産した水族館を後にした。報酬として、彼女は数匹のクラゲを家に持ち帰ることを許された。\nそれは彼女の大好きな小さな生き物で、海を漂う精霊、生き生きとした花のような存在だった。\n心を込めて世話をすれば、水槽いっぱいに広がるはず！——彼女はそんな光景を期待していた。"
  },
  Skill_132428_Desc_0 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。"
  },
  Skill_132428_Desc_15 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。オレッタの「攻撃」は刺突ダメージになり、追加でダメージを2回与える。"
  },
  Skill_132428_EffectNameList = {Text = "狂気"},
  Skill_132428_Name = {
    Text = "テスト·覚醒"
  },
  Skill_132429_AwakerSkillBackgroundStory = {
    Text = "海は深く静かで、生への渇望と死への恐怖を抱えている。\nしかし、誰かが笑いと遊びで海を満たそうとする——オレッタがそんな招待をすると、「一緒に騒いでもいいじゃないか」という気持ちが湧き上がり、シンプルな喜びが胸を満たす。"
  },
  Skill_132429_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。"
  },
  Skill_132429_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。山札と捨て札の中から最大10枚の「腺体分裂」を消費し、1枚につき追加でダメージを1回与える。「腺体分裂」を2枚手札に追加する。この戦闘中、「オレッタ」の与えるダメージが[Arg2]増加する。"
  },
  Skill_132429_EffectNameList = {
    Text = "ダメージ,以降ダメージ上昇"
  },
  Skill_132429_Name = {
    Text = "テスト·狂爆"
  },
  Skill_132429_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。[Power:Arg2]点の<PowerIconKeywords:力量>と[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、以降5回「腺体分裂」を発動する際、1枚カードを引く。"
  },
  Skill_132429_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_132430_AwakerSkillBackgroundStory = {
    Text = "海は深く静かで、生への渇望と死への恐怖を抱えている。\nしかし、誰かが笑いと遊びで海を満たそうとする——オレッタがそんな招待をすると、「一緒に騒いでもいいじゃないか」という気持ちが湧き上がり、シンプルな喜びが胸を満たす。"
  },
  Skill_132430_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。"
  },
  Skill_132430_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。山札と捨て札の中から最大10枚の「腺体分裂」を消費し、1枚につき追加でダメージを1回与える。「腺体分裂」を2枚手札に追加する。この戦闘中、「オレッタ」の与えるダメージが[Arg2]増加する。"
  },
  Skill_132430_EffectNameList = {
    Text = "ダメージ,以降ダメージ上昇"
  },
  Skill_132430_Name = {
    Text = "テスト·狂爆"
  },
  Skill_132430_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。[Power:Arg2]点の<PowerIconKeywords:力量>と[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、以降5回「腺体分裂」を発動する際、1枚カードを引く。"
  },
  Skill_132430_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_132431_AwakerSkillBackgroundStory = {
    Text = "「見て！オレッタが魚みたいに泡を吐いてる！」"
  },
  Skill_132431_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_132431_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132431_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132431_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。オレッタは<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_132431_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_132431_Name = {
    Text = "テスト·防御"
  },
  Skill_132431_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_132432_AwakerSkillBackgroundStory = {
    Text = "子供たちは徐々に童話の本質を見抜き、神話の背後にある寓話を理解するようになる。この過程は人間の言葉で「成長」と呼ばれる。\nしかし、寝る前の物語をますます信じる子供たちもいる。彼らは空に虹の橋が本当にあり、文明が深海に沈んでいると固く信じている。\nオレッタはこれらの物語が好きで、この喜びをもっと多くの仲間と分かち合いたいと思っている。"
  },
  Skill_132432_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg1]。すべての手札を捨て、同数のカードを引く。「腺体分裂」を1枚捨て札に混ぜ入れる。"
  },
  Skill_132432_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]。すべての手札を捨て、同数+1のカードを引く。「腺体分裂」を1枚捨て札に追加する。"
  },
  Skill_132432_EffectNameList = {
    Text = "触腕ダメージ,「腺体分裂」レベル"
  },
  Skill_132432_Name = {
    Text = "テスト·スキル2"
  },
  Skill_132432_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132433_AwakerSkillBackgroundStory = {
    Text = "世界には特別なクラゲが存在し、傷つくとその落ちた組織が再び完全なポリプ体に成長することができる。\n「オレッタもクラゲを生む！だからオレッタもクラゲだ！」\n子供が世界を認識するこの段階では、彼女の興を削がない方がいいだろう。"
  },
  Skill_132433_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_132433_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_132433_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132433_Name = {
    Text = "テスト·スキル1"
  },
  Skill_132433_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132434_AwakerSkillBackgroundStory = {
    Text = "子供たちは徐々に童話の本質を見抜き、神話の背後にある寓話を理解するようになる。この過程は人間の言葉で「成長」と呼ばれる。\nしかし、寝る前の物語をますます信じる子供たちもいる。彼らは空に虹の橋が本当にあり、文明が深海に沈んでいると固く信じている。\nオレッタはこれらの物語が好きで、この喜びをもっと多くの仲間と分かち合いたいと思っている。"
  },
  Skill_132434_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg1]。すべての手札を捨て、同数のカードを引く。「腺体分裂」を1枚捨て札に混ぜ入れる。"
  },
  Skill_132434_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]。すべての手札を捨て、同数+1のカードを引く。「腺体分裂」を1枚捨て札に追加する。"
  },
  Skill_132434_EffectNameList = {
    Text = "触腕ダメージ,「腺体分裂」レベル"
  },
  Skill_132434_Name = {
    Text = "テスト·スキル2"
  },
  Skill_132434_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132435_AwakerSkillBackgroundStory = {
    Text = "少女は名残惜しそうに破産した水族館を後にした。報酬として、彼女は数匹のクラゲを家に持ち帰ることを許された。\nそれは彼女の大好きな小さな生き物で、海を漂う精霊、生き生きとした花のような存在だった。\n心を込めて世話をすれば、水槽いっぱいに広がるはず！——彼女はそんな光景を期待していた。"
  },
  Skill_132435_Desc_0 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。"
  },
  Skill_132435_Desc_15 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。オレッタの「攻撃」は刺突ダメージになり、追加でダメージを2回与える。"
  },
  Skill_132435_EffectNameList = {Text = "狂気"},
  Skill_132435_Name = {
    Text = "テスト·覚醒"
  },
  Skill_132436_AwakerSkillBackgroundStory = {
    Text = "「見て！オレッタが魚みたいに泡を吐いてる！」"
  },
  Skill_132436_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_132436_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132436_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132436_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。オレッタは<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_132436_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_132436_Name = {
    Text = "テスト·防御"
  },
  Skill_132436_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_132437_AwakerSkillBackgroundStory = {
    Text = "「見て！オレッタが魚みたいに泡を吐いてる！」"
  },
  Skill_132437_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_132437_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132437_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132437_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。オレッタは<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_132437_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_132437_Name = {
    Text = "テスト·防御"
  },
  Skill_132437_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_132438_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132438_Desc = {
    Text = "プレイヤーが [Power:Arg1] ポイントの<PowerIconKeywords:力>、<Block:[Block:Arg2]>  ポイントのシールド、[Heal:Arg3] ポイントの回復、[TentaclePower:Arg4] ポイントの<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5] 層の<RetaliateIconKeywords:反撃>を獲得し、前列の敵に <Damage:[Damage:Arg6]> ポイントのダメージを[Arg7]回与え、[Poison:Arg8] 層の<IntoxicationIconKeywords:中毒>を付与、[Exhaustion:Arg9] 層の<ExhaustionIconKeywords:衰弱>を付与、[FateCut:Arg10] 層の<CutKeywords:運命裁断>を付与する。"
  },
  Skill_132438_Name = {
    Text = "カラフル奥義"
  },
  Skill_132438_OverLimitUtlSkillDesc = {
    Text = "プレイヤーは[Power:Arg1]点の<PowerIconKeywords:力>、<Block:[Block:Arg2]>点のシールド、[Heal:Arg3]点の治癒、[TentaclePower:Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>、[Counterattack:Arg5]層の<RetaliateIconKeywords:反撃>を得て、前列の敵に<Damage:[Damage:Arg6]>点のダメージを[Arg7]回与え、[Poison:Arg8]層の<IntoxicationIconKeywords:毒>を付与し、[Exhaustion:Arg9]層の<ExhaustionIconKeywords:衰弱>を付与します。"
  },
  Skill_132439_AwakerSkillBackgroundStory = {
    Text = "光の七色、絢爛にして幻惑〜"
  },
  Skill_132439_Desc = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ポイントのダメージを[Arg2]回与え、同量の<IntoxicationIconKeywords:中毒>、同量の<CutKeywords:運命裁断>を付与し、同量の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_132439_Name = {
    Text = "テスト·鏡返"
  },
  Skill_132440_AwakerSkillBackgroundStory = {
    Text = "世界には特別なクラゲが存在し、傷つくとその落ちた組織が再び完全なポリプ体に成長することができる。\n「オレッタもクラゲを生む！だからオレッタもクラゲだ！」\n子供が世界を認識するこの段階では、彼女の興を削がない方がいいだろう。"
  },
  Skill_132440_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_132440_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_132440_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132440_Name = {
    Text = "テスト·スキル1"
  },
  Skill_132440_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132441_AwakerSkillBackgroundStory = {
    Text = "「ふふ！驚いたかい！」"
  },
  Skill_132441_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132441_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132441_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132441_Name = {
    Text = "テスト·打撃"
  },
  Skill_132441_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132441_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132441_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを<PunctureDamagewords:刺突ダメージ>3回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132442_AwakerSkillBackgroundStory = {
    Text = "「ふふ！驚いたかい！」"
  },
  Skill_132442_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132442_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132442_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_132442_Name = {
    Text = "テスト·打撃"
  },
  Skill_132442_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_132442_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_132442_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを<PunctureDamagewords:刺突ダメージ>3回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_132494_Desc = {
    Text = "全ての手札を捨て、[Arg1]枚の集合テストカードを生成し、先頭[Arg2]枚と末尾[Arg3]枚の差集合を取り、消費を付与する。"
  },
  Skill_132494_Name = {Text = "差集合"},
  Skill_132495_Desc = {
    Text = "全ての手札を捨て、[Arg1]枚の集合テストカードを生成し、先頭[Arg2]枚と末尾[Arg3]枚の対称差を取り、消費を付与する。"
  },
  Skill_132495_Name = {Text = "対称差"},
  Skill_132496_Name = {
    Text = "集合テスト"
  },
  Skill_132497_Desc = {
    Text = "全ての手札を捨て、[Arg1]枚の集合テストカードを生成し、先頭[Arg2]枚と末尾[Arg3]枚の和集合を取り、消費を付与する。"
  },
  Skill_132497_Name = {Text = "和集合"},
  Skill_132498_Desc = {
    Text = "全ての手札を捨て、[Arg1]枚の集合テストカードを生成し、先頭[Arg2]枚と末尾[Arg3]枚の積集合を取り、消費を付与する。"
  },
  Skill_132498_Name = {Text = "積集合"},
  Skill_132884_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に[Arg1] <StrongEffectKeywords:強効>を獲得する。他の味方が狂気爆発した後、その味方に<PVPOneMeetingKeywords:一期一会>を付与する。"
  },
  Skill_132884_Name_1 = {
    Text = "桜花の幻想"
  },
  Skill_133319_Desc_1 = {
    Text = "味方1体の次の指令カードの行動力消費-[Arg1]、<Damage:[Arg2]>ライフを失う。"
  },
  Skill_133319_Name_1 = {Text = "改変"},
  Skill_133322_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_133322_Name_1 = {Text = "攻撃"},
  Skill_133323_BattleDesc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg4]>ダメージを与え、ライフを[Arg2]失うごとにダメージ+[Arg3]、自身は同量のライフを回復する。"
  },
  Skill_133323_Desc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg1]>ダメージを与え、ライフを[Arg2]失うごとにダメージ+[Arg3]、自身は同量のライフを回復する。"
  },
  Skill_133323_Name_1 = {Text = "略奪"},
  Skill_133324_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、<PVPCognitiveDissonanceKeyWords:認知錯乱>を付与する。"
  },
  Skill_133324_Name_1 = {
    Text = "沙耶の唄"
  },
  Skill_133325_BattleDesc_1 = {
    Text = "味方1体を選択し、<Heal:[Heal:Arg4]>の<PVPFeatheredSeedsKeyWords:羽の種>と同量のライフを獲得させる。行動力を[Arg2]消費するごとに、<PVPFeatheredSeedsKeyWords:羽の種>と同量のライフが[Arg3]増加する。"
  },
  Skill_133325_Desc_1 = {
    Text = "味方1体を選択し、<Heal:[Heal:Arg1]>の<PVPFeatheredSeedsKeyWords:羽の種>と同量のライフを獲得させる。行動力を[Arg2]消費するごとに、<PVPFeatheredSeedsKeyWords:羽の種>と同量のライフが[Arg3]増加する。"
  },
  Skill_133325_Name_1 = {Text = "拡散"},
  Skill_133346_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重傷>、<PVPPenetrateKeywords:刺突>を与え、<DelayKeywords:レイテンシ>：全体の味方のライフを <Heal:[Heal:Arg1]> 回復し、<PVPSeriousInjuryKeywords:重傷>がシールドを [Arg2] 消散させるか<DelayKeywords:レイテンシ>で治療するたびに、ライフ回復 +[Arg3]。"
  },
  Skill_133346_Name_1 = {
    Text = "新世界に捧ぐ"
  },
  Skill_133346_UnknownName = {
    Text = "新世界に捧ぐ"
  },
  Skill_133347_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：この命輪は死亡後も保留される。装備者の死亡時および死亡状態での以降 [Arg2] ターン終了後、他の味方は <Heal:[Heal:Arg1]> の<PVPFeatheredSeedsKeyWords:羽種>とライフを獲得する。"
  },
  Skill_133347_Name_1 = {
    Text = "花香る世界を願って"
  },
  Skill_133348_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時、装備者の「攻撃」「スキル」「狂気解放」の説明が融蝕文字として表示されるが、ダメージ、治癒、シールドがランダムで[Arg1]%～[Arg2]%増加する。"
  },
  Skill_133348_Name_1 = {
    Text = "汚泥の中の童話"
  },
  Skill_133365_AwakerSkillBackgroundStory = {
    Text = "彼女は幾度となく糸が切れる音を聞いた。\n果たされなかった再会。告げられなかった告白。生まれなかった子供。\n世に出なかった音楽。勝てなかった戦争。生き残れなかった文明。\n糸は編まれ、糸は切れ、糸は再びあの巨大な網へと還る。\n運命の神はとうに知っていた——真に消え去るものは何もなく、真に存在したものも何もないと。"
  },
  Skill_133365_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。他の覚醒体に<Energy:[Energy:Arg2]>点の狂気を与える。次の「<DerivativeCardKeywords_139:永遠の織成>」は追加の「<DerivativeCardKeywords_138:導きの糸>」を山札と捨て札に加える。"
  },
  Skill_133365_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_133365_Name = {
    Text = "運命の縛糸"
  },
  Skill_133365_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_133366_AwakerSkillBackgroundStory = {
    Text = "彼女が生まれたその日から、運命の糸が広がるのが見えた。\n糸の軌跡を辿り、彼女は扉をくぐり、囚人としての果てなき運命を受け入れた。\n糸はモイライと呼ばれる紡ぎ車を通り、城壁と海峡を越え、誓いと嘘を貫き、自ら選択していると信じるすべての魂を貫いた。\nこの自由という幻の中で、紡ぎ車は回り続け、永遠に止まることはない。"
  },
  Skill_133366_Desc_0 = {
    Text = "すべての敵に[FateCut:Arg1]点の<CutKeywords:運命の裁き>をを付与し、1枚の「<DerivativeCardKeywords_138:導きの糸>」を手札に加える。"
  },
  Skill_133366_EffectNameList = {
    Text = "運命の裁き"
  },
  Skill_133366_Name = {
    Text = "永遠の織成"
  },
  Skill_133366_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_133366_tempBattleDesc_1 = {
    Text = "すべての敵に[FateCut:Arg1]ポイントの<CutKeywords:運命の裁断>を与え、1枚の「<DerivativeCardKeywords_138:運命の糸を引く>」を手札に加える。"
  },
  Skill_133366_tempBattleDesc_2 = {
    Text = "すべての敵に[FateCut:Arg1]ポイントの<CutKeywords:運命の裁断>を与え、1枚の「<DerivativeCardKeywords_138:運命の糸を引く>」を手札に加え、ドロー山と捨て札に置く。"
  },
  Skill_133381_Desc_0 = {
    Text = "5層の臨時<SingularityKeywords2:特異点プリズム>を獲得。HPが最も低い敵に [FateCut:Arg2] 点の<CutKeywords:運命の裁き>を付与する。"
  },
  Skill_133381_Desc_3 = {
    Text = "10層の臨時<SingularityKeywords2:特異点プリズム>を獲得。HPが最も低い敵に [FateCut:Arg2] 点の<CutKeywords:運命の裁き>を付与する。"
  },
  Skill_133381_Name = {
    Text = "無限の糸"
  },
  Skill_133473_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手の山札にランダムな症状を[Arg3]枚追加する。"
  },
  Skill_133473_Name = {
    Text = "黒き死の口づけ"
  },
  Skill_133474_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。相手の山札に<DepleteIconKeywords:除外>が付与されたランダムな覚醒体の「攻撃」を[Arg3]枚追加する。"
  },
  Skill_133474_Name = {
    Text = "幻毒の侵蝕"
  },
  Skill_133715_Desc = {
    Text = "覚醒体を1体選択し、カード属性を追加して、その全ての現在及び未来のカードに伝播する。"
  },
  Skill_133715_Name = {
    Text = "カード属性伝播"
  },
  Skill_133950_Desc = {
    Text = "ランダムな3つのキーオーダーから1つを選んで発動し、その効果を2回発動する。発射後、永久に「<DerivativeCardKeywords_140:春の便り>」に変化する。"
  },
  Skill_133951_Desc = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得し、使用後永久に「<DerivativeCardKeywords_141:桜満開>」に変化する。"
  },
  Skill_133951_Name = {
    Text = "春の便り"
  },
  Skill_133952_Desc = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得し、使用後永久に「<DerivativeCardKeywords_142:花吹雪>」に変化する。"
  },
  Skill_133952_Name = {Text = "満開"},
  Skill_133953_Desc = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得し、使用後永久に「<DerivativeCardKeywords_143:一期一会>」に変化する。"
  },
  Skill_134007_Desc = {
    Text = "使用後、選択した覚醒体に奥義を複数回強制発動させる。"
  },
  Skill_134007_Name = {
    Text = "奥義強制発動"
  },
  Skill_134008_Desc = {
    Text = "使用後、モンスターに現在の意図を強制実行させる。"
  },
  Skill_134008_Name = {
    Text = "意図強制実行"
  },
  Skill_134009_Desc = {
    Text = "使用後、手札の山の一番上のカード1枚を複数回強制使用する。"
  },
  Skill_134009_Name = {
    Text = "カード強制使用"
  },
  Skill_134010_Desc = {
    Text = "使用後、プレイヤーに鍵令を複数回強制発動させる。"
  },
  Skill_134010_Name = {
    Text = "鍵令強制使用"
  },
  Skill_134203_Desc = {
    Text = "臨時クリティカルダメージ+70%。"
  },
  Skill_134203_Name = {
    Text = "私的な休息"
  },
  Skill_134204_Desc = {
    Text = "臨時クリティカルダメージ+60%。"
  },
  Skill_134204_Name = {
    Text = "私的な休息"
  },
  Skill_134205_Desc = {
    Text = "臨時クリティカルダメージ+80%。"
  },
  Skill_134205_Name = {
    Text = "私的な休息"
  },
  Skill_134206_Desc = {
    Text = "臨時クリティカルダメージ+50%。"
  },
  Skill_134206_Name = {
    Text = "私的な休息"
  },
  Skill_134210_Desc = {
    Text = "全覚醒を解放"
  },
  Skill_134210_Name = {
    Text = "全覚醒を解放"
  },
  Skill_134212_Desc = {
    Text = "[Arg1]点シールドと[Arg2]％一時的ダメージ強化を得る。「アラクネ」がチームにいる場合、「永遠の織成」を1枚引き、その行動力消費を-1する。"
  },
  Skill_134212_Name = {
    Text = "逃れえぬ輪廻"
  },
  Skill_134252_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」後、自身が次に与えるダメージが2倍になる。"
  },
  Skill_134252_Name_1 = {
    Text = "私用の昼休み"
  },
  Skill_138603_Desc = {
    Text = "すべての敵に最大ライフの1%のダメージを3回与える。その超次元空間を破壊し、中のカードをすべて消去する。"
  },
  Skill_138603_Name = {
    Text = "糸よ、あるべき場所へ"
  },
  Skill_138768_Desc = {
    Text = "立ち絵配置のテストカード。"
  },
  Skill_138768_Name = {
    Text = "追撃テスト"
  },
  Skill_138769_Desc = {
    Text = "特定のカードで追撃を行い、そのカードのカード面を再生する。"
  },
  Skill_138769_Name = {
    Text = "追撃テスト"
  },
  Skill_138810_AwakerSkillBackgroundStory = {
    Text = "外見が大切なのか、それとも心が大切なのか。\n答えはあるのか、それともないのか。\n\n愛の中でもがく者はかくも迷いゆく。\nそして、巻き込まれた犠牲者たちを、愛おしい気持ちで、すべて喰らい尽くす。"
  },
  Skill_138810_BattleDesc_0 = {
    Text = "現在のライフの10%（[Arg4]）を失い、すべての敵に[Corrosion:Arg1]ポイントの<Corrosion:侵蝕>を与える。すべての指令カードを捨て、同じ枚数（[Arg3]）のカードを引く。"
  },
  Skill_138810_BattleDesc_1 = {
    Text = "現在のライフの10%（[Arg4]）を失い、すべての敵に[Corrosion:Arg1]ポイントの<Corrosion:侵蝕>を与える。すべての指令カードを捨て、同じ枚数（[Arg3]）のカードを引く。"
  },
  Skill_138810_BattleDesc_3 = {
    Text = "現在ライフの 10%([Arg4]) を失い、すべての敵に[Corrosion:Arg1]点の<Corrosion:侵蝕>を付与し、追加で対象の最大ライフの 0.5%の<Corrosion:侵蝕>を付与する。すべての指令カードを捨て、[Arg3]枚のカードを引く。"
  },
  Skill_138810_Desc_0 = {
    Text = "現在のライフの10%を失い、すべての敵に[Corrosion:Arg1]点の<Corrosion:侵蝕>を付与する。すべての指令カードを捨て、同じ枚数のカードを引く。"
  },
  Skill_138810_Desc_1 = {
    Text = "現在のライフの10%を失い、すべての敵に[Corrosion:Arg1]点の<Corrosion:侵蝕>を付与する。すべての指令カードを捨て、同じ枚数のカードを引く。"
  },
  Skill_138810_Desc_3 = {
    Text = "現在のライフの10%を失い、すべての敵に[Corrosion:Arg1]の<Corrosion:侵蝕>を与え、さらに対象の最大ライフの0.5％分の<Corrosion:侵蝕>を付与する。すべての指令カードを捨て、同じ枚数のカードを引く。"
  },
  Skill_138810_EffectNameList = {Text = "侵蝕"},
  Skill_138810_Name = {
    Text = "血脂爛漫"
  },
  Skill_138810_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_139862_Desc = {
    Text = "[Arg1] 点のシールドを獲得し、「技能」を2枚ドローして<ErosionColorInkKeywords:認知錯乱>を付与する。沙耶がパーティにいる場合、<KaiHuajishu:羽種>を1スタック獲得する。"
  },
  Skill_139862_Name = {
    Text = "新世界に捧ぐ"
  },
  Skill_140120_Desc_1 = {
    Text = "対象1体に命途を付与し、この諭示に従う。"
  },
  Skill_140120_Name_1 = {
    Text = "運命よ、我が意のままに"
  },
  Skill_140144_Desc_1 = {
    Text = "ターゲット1名に <ReinforceKeywords:痴酔> を付与する。"
  },
  Skill_140144_Name_1 = {Text = "陶酔"},
  Skill_140457_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時および任意の覚醒体が「キョウキ爆発」を発動した後、自身が <Block:[Block:Arg1]> シールドを獲得する。"
  },
  Skill_140457_Name_1 = {
    Text = "群星に捧ぐ"
  },
  Skill_140566_Desc = {
    Text = "使用後、テスト用聖女作成（特異点ビーコン30付き）、テスト用仲間の力を獲得する。"
  },
  Skill_140567_Desc = {
    Text = "使用後、テスト用聖女作成、テスト用仲間の力（特異点ビーコン30付き）を獲得する。"
  },
  Skill_140592_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>を付与し、ドローパイルのランダムな2枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140598_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与え、ドローパイルのランダムな1枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140600_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与え、ドローパイルのランダムな1枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140601_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。ドローパイルのランダムな3枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140604_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。<PowerIconKeywords:力量>を[Arg3]ポイント獲得し、ドローパイルのランダムな1枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140608_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与え、ドローパイルのランダムな1枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140609_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<WeaknessIconKeywords:衰弱>を付与し、ドローパイルのランダムな1枚のカードに<ErosionColorInkKeywords:認知錯乱>を付加する。"
  },
  Skill_140665_Desc = {
    Text = "一時的な<SingularityKeywords2:特異点プリズム>を獲得し、HPが最も低い敵に<CutKeywords:運命裁断>を与える。"
  },
  Skill_140665_Name = {
    Text = "無限の糸"
  },
  Skill_140666_Desc_1 = {
    Text = "ターゲット1体に 認知錯乱を付与する。"
  },
  Skill_140666_Name_1 = {
    Text = "認知錯乱"
  },
  Skill_140680_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に<MaxHPKeywords:最大ライフ>[Arg1]を獲得する。ターン終了時に<Heal:[Heal:Arg2]>のライフを回復し、回復量は装備者のライフが低いほど増加し、最大[Arg3]%まで上昇する。"
  },
  Skill_140680_Name_1 = {
    Text = "夢遊の異界"
  },
  Skill_140714_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを2回与え、1スタックの<HungerKeywords:飢餓>を獲得する。ガードされなかったダメージを与えるたびに追加で1スタックの<HungerKeywords:飢餓>を獲得する。"
  },
  Skill_140714_tempName_2 = {
    Text = "肉を探す"
  },
  Skill_140716_Desc = {
    Text = "自身の負のステータスを解除し、「護食」ステータスを獲得する：毎ターン開始時に飢餓を1層獲得し、ブロックされなかったダメージを与えた時に最大ライフの2%分のシールドを獲得し、適応の最大スタック数が75に上昇する。"
  },
  Skill_140716_tempName_2 = {Text = "変身"},
  Skill_140717_Desc = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、同量の<BleedingIconKeywords:出血>を付与する。自身の最大ライフが5%上昇し、プレイヤーの手札からランダムな「スキル」1枚を飲み込んで消費する。"
  },
  Skill_140717_tempName_2 = {Text = "喰らう"},
  Skill_140765_Desc = {
    Text = "このインテントに切り替えた時、自身の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を敵に転移する。転移に成功した場合、失ったライフの10%（<Heal:[Heal:Arg3]>）を回復し、<HungerKeywords:飢餓>を1層獲得する。失敗した場合、<Damage:[Damage:Arg1]>ポイントのダメージを与え、<HungerKeywords:飢餓>を2層獲得する。"
  },
  Skill_140765_tempName_2 = {
    Text = "過剰反応"
  },
  Skill_140766_Desc = {
    Text = "このインテントに切り替えた時、自身の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を敵に転移する。転移に成功した場合、失ったライフの10%（<Heal:[Heal:Arg3]>）を回復し、<HungerKeywords:飢餓>を1層獲得する。失敗した場合、<Damage:[Damage:Arg1]>ポイントのダメージを与え、<HungerKeywords:飢餓>を2層獲得する。"
  },
  Skill_140766_tempName_2 = {
    Text = "過剰反応"
  },
  Skill_140767_Desc = {
    Text = "このインテントに切り替えた時、自身の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を敵に転移する。転移に成功した場合、失ったライフの10%（<Heal:[Heal:Arg3]>）を回復し、<HungerKeywords:飢餓>を1層獲得する。失敗した場合、<Damage:[Damage:Arg1]>ポイントのダメージを与え、<HungerKeywords:飢餓>を2層獲得する。"
  },
  Skill_140767_tempName_2 = {
    Text = "過剰反応"
  },
  Skill_140829_Desc = {
    Text = "一時的に最終ダメージ +[Arg1]%、すべての敵に最大ライフの [Arg2]% の侵蝕を与える。"
  },
  Skill_140829_Name = {Text = "猟取"},
  Skill_140830_Desc = {
    Text = "<Pangtuosihuodong_Defend:「護衛」>または<Pangtuosihuodong_Attack:「猎取」>を選択する。"
  },
  Skill_140830_Name = {
    Text = "魇を駆る"
  },
  Skill_140831_Desc = {
    Text = "すべての敵が今ターンに与えるダメージを [Arg1]% 低下させ、[Arg2] 点の力を獲得する。"
  },
  Skill_140831_Name = {Text = "護衛"},
  Skill_140849_Desc = {
    Text = "装備者は<Energy:[Arg1]>狂気と<Yishiganshe:「意識干渉」>を獲得する。"
  },
  Skill_140849_Name = {
    Text = "夢遊の異界"
  },
  Skill_140850_Desc = {
    Text = "装備者は <Energy:[Arg1]> 狂気と<Yishiganshe:「意識干渉」>を獲得する。"
  },
  Skill_140850_Name = {
    Text = "夢遊の異界"
  },
  Skill_140851_Desc = {
    Text = "装備者は <Energy:[Arg1]> 狂気と<Yishiganshe:「意識干渉」>を獲得する。"
  },
  Skill_140851_Name = {
    Text = "夢遊の異界"
  },
  Skill_140852_Desc = {
    Text = "装備者は <Energy:[Arg1]> 狂気と<Yishiganshe:「意識干渉」>を獲得する。"
  },
  Skill_140852_Name = {
    Text = "夢遊の異界"
  },
  Skill_141020_Desc_1 = {
    Text = "テスト用のステータスを追加する。"
  },
  Skill_141020_Name_1 = {
    Text = "状態追加"
  },
  Skill_141058_AwakerSkillBackgroundStory = {
    Text = "旺盛すぎる好奇心と卓越した学習能力により、沙耶は人間を模倣する過程で、あまりにも人間の少女によく似た魂を手に入れた。\nそのせいで、彼女はよりいっそう孤独になった。\nしかし、この上なく幸福にもなった。"
  },
  Skill_141058_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。<KaiHuajishu:羽の種>を 1 層獲得する。"
  },
  Skill_141058_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]、現在のライフが低いほど効果が増加し、最大で 100% まで上昇する。<KaiHuajishu:羽の種>を 1 層獲得する。"
  },
  Skill_141058_Name = {
    Text = "生体擬態"
  },
  Skill_141947_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時およびターン終了時、<PVPDiscoveryKeyWords:発見> [Arg1] 枚の<PVPVoidKeywords:虚無>が付加された「スキル」を手札に加える。"
  },
  Skill_141947_Name_1 = {
    Text = "上への墜落"
  },
  Skill_142022_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。自身の負のステータスを除去し、「聖潔の翼」を獲得する：永久に自身のターンに受けるダメージを 10% 低下させる。"
  },
  Skill_142022_Name = {
    Text = "聖潔の翼"
  },
  Skill_142023_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142023_Name = {
    Text = "四翼の芽生え"
  },
  Skill_142024_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。<ResentChainsKeywords:怨恨の鎖> を 3 層獲得する。このインテントに切り替えた時、狂気が最も高い覚醒体の狂気解放とすべての指令カードを 1 ターン封印する。"
  },
  Skill_142024_Name = {
    Text = "四翼の芽生え-封鎖"
  },
  Skill_142025_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。すべての覚醒体の現在の狂気を半減する。"
  },
  Skill_142025_Name = {
    Text = "四翼の芽生え-冷寂"
  },
  Skill_142026_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_142026_Name = {
    Text = "翼を広げる"
  },
  Skill_142027_Desc = {
    Text = "「融食のコア」を 1 枚ドロー山に置く。自身のスキルに強化を付与する。"
  },
  Skill_142027_Name = {
    Text = "ドア全開"
  },
  Skill_142028_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。<HeavyInjuryKeywords:重傷> を 2 層付与する。このインテントに切り替えた時、<HeavyInjuryKeywords:重傷> を 1 層付与する。"
  },
  Skill_142028_Name = {
    Text = "双翼の羽ばたき-重傷"
  },
  Skill_142029_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。2 層の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_142029_Name = {
    Text = "双翼の羽ばたき-虚弱"
  },
  Skill_142030_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142030_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_142031_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142031_Name = {
    Text = "六翼の解放"
  },
  Skill_142032_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。2 層の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_142032_Name = {
    Text = "双翼の羽ばたき-重傷"
  },
  Skill_142033_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。敵の永久パワー・永久反撃・触腕ダメージの 50% を除去し、「呪いの翼」を与える：永久に与える力・反撃・触腕ダメージを 10% 低下させる。"
  },
  Skill_142033_Name = {
    Text = "呪いの翼"
  },
  Skill_142034_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142034_Name = {
    Text = "六翼の解放"
  },
  Skill_142035_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。各所の指令カードの半数に <SlowIconKeywords:遅延> を 1 層付与する。このインテントに切り替えた時、手札の半数の指令カードに <SlowIconKeywords:遅延> を 1 層付与する。"
  },
  Skill_142035_Name = {
    Text = "四翼の芽生え-遅延"
  },
  Skill_142036_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。<WeaknessIconKeywords:虚弱> を 2 層付与する。このインテントに切り替えた時、<WeaknessIconKeywords:虚弱> を 1 層付与する。"
  },
  Skill_142036_Name = {
    Text = "双翼の羽ばたき-虚弱"
  },
  Skill_142037_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。2 層の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_142037_Name = {
    Text = "双翼の羽ばたき-脆弱"
  },
  Skill_142038_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。敵のライフが低いほどダメージが高くなり、最大 100% 上昇する。"
  },
  Skill_142038_Name = {
    Text = "六翼の解放-臨終のささやき"
  },
  Skill_142039_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。<FragileIconKeywords:脆弱> を 2 層付与する。このインテントに切り替えた時、<FragileIconKeywords:脆弱> を 1 層付与する。"
  },
  Skill_142039_Name = {
    Text = "双翼の羽ばたき-脆弱"
  },
  Skill_142040_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。敵の現在のダメージ強化の 25% を除去し、「弱体の翼」を与える：永久に与える基礎ダメージ・毒・反撃を 10% 低下させる。"
  },
  Skill_142040_Name = {
    Text = "穢れの翼"
  },
  Skill_142041_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。<ResentChainsKeywords:怨恨の鎖> を 3 層獲得する。"
  },
  Skill_142041_Name = {
    Text = "四翼の芽生え-封鎖"
  },
  Skill_142042_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。各段ごとに対象の現在ライフの 5% の追加ダメージを与える。"
  },
  Skill_142042_Name = {
    Text = "六翼の解放-満星の墜落"
  },
  Skill_142043_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142043_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_142044_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。各段ごとに対象の現在ライフの 5% の追加ダメージを与える。このインテントに切り替えた時、このターン中ネガティブなステータスを免疫する。"
  },
  Skill_142044_Name = {
    Text = "六翼の解放-満星の墜落"
  },
  Skill_142045_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。各所の指令カードの半数に <SlowIconKeywords:遅延> を 1 層付与する。"
  },
  Skill_142045_Name = {
    Text = "四翼の芽生え-遅延"
  },
  Skill_142046_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。ライフが低い敵ほどダメージが高くなり、最大 100% 上昇する。このインテントに切り替えた時、[Arg3] の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_142046_Name = {
    Text = "六翼の解放-臨終のささやき"
  },
  Skill_142047_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。ダメージアップ 100%、ただし本ターン自身が最大ライフの 2% のダメージを受けるたびにこの効果が 10% 低下し、最大 50% まで低下する。"
  },
  Skill_142047_Name = {
    Text = "六翼の解放-二重啓示"
  },
  Skill_142048_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。すべての覚醒体の現在の狂気を半減する。このインテントに切り替えた時、すべての覚醒体が狂気を 25 点失う。"
  },
  Skill_142048_Name = {
    Text = "四翼の芽生え-冷寂"
  },
  Skill_142049_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。ダメージアップ 100%、ただし本ターン自身が最大ライフの 2% のダメージを受けるたびにこの効果が 10% 低下し、最大 50% まで低下する。  このインテントに切り替えた時、最大ライフの 10% のシールドを獲得する。"
  },
  Skill_142049_Name = {
    Text = "六翼の解放-二重啓示"
  },
  Skill_142050_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_142050_Name = {
    Text = "四翼の芽生え"
  },
  Skill_142449_Desc_1 = {
    Text = "何だろう？"
  },
  Skill_142449_Name_1 = {Text = "宝物"},
  Skill_142449_UnknownName = {Text = "宝物"},
  Skill_142686_Desc_1 = {
    Text = "対象の命輪を永久に無効化し、再度使用すると解除する。"
  },
  Skill_142686_Name_1 = {
    Text = "スーパー纏着"
  },
  Skill_142689_Desc_1 = {
    Text = "対象に命輪を装備させる。"
  },
  Skill_142689_Name_1 = {
    Text = "命輪の装備"
  },
  Skill_142695_AwakerSkillBackgroundStory = {
    Text = "彼はすべての肉親と愛する者の最も生き生きとした面白い部分を留め、すべての敵に最も凄惨で長い苦しみを与えた。\n杯を交わすたびの夜、彼は笑いながら空の抜け殻が成す海へと落ちていった。"
  },
  Skill_142695_BattleDesc = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点低下させる。ライフが最も低い敵に触腕ダメージの[Arg2]％( [Arg3] )に相当する<RealDamage:固定ダメージ>を与え、キルした場合、永続的に1枚の<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を手札に加える。1戦闘につき最大3枚まで永続生成する。"
  },
  Skill_142695_Desc = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg8] 点減少させる。ライフが最も低い敵に [Arg2]％ の触腕ダメージに相当する<RealDamage:固定ダメージ>を与え、キルした場合は永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>を1枚手札に生成する。1戦闘中に生成できる永久「囚魘」は最大3枚。"
  },
  Skill_142695_EffectNameList = {
    Text = "一時的な力減少,触手ダメージバフ,囚魘レベル"
  },
  Skill_142695_Name = {
    Text = "無休の狩宴"
  },
  Skill_142695_OverLimitUtlSkillDesc = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点減少させる。ライフが最も低い敵に[Arg6]％の触腕ダメージに等しい<RealDamage:固定ダメージ>( [Arg7] )を与え、キルした場合は永久に<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を2枚手札に生成し、1戦闘につき最大3枚まで永久生成できる。各所の「囚魘」の行動力消費を-1する。"
  },
  Skill_142695_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,$GrowValue3"
  },
  Skill_142695_tempBattleDesc_1 = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点低下させる。ライフが最も低い敵に触腕ダメージの[Arg2]％( [Arg3] )に相当する<RealDamage:固定ダメージ>を与え、キルした場合、永続的に1枚の<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を手札に加える。1戦闘につき最大3枚まで永続生成する。"
  },
  Skill_142695_tempBattleDesc_2 = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点低下させる。ライフが最も低い敵に触腕ダメージの[Arg2]％( [Arg3] )に相当する<RealDamage:固定ダメージ>を与え、キルした場合、永続的に1枚の<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を手札に加える。1戦闘につき最大3枚まで永続生成する。[Arg5]層の<BattueKeywords:包囲狩猟>を獲得する。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_1 = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点減少させる。ライフが最も低い敵に[Arg6]％の触腕ダメージに等しい<RealDamage:固定ダメージ>( [Arg7] )を与え、キルした場合は永久に<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を2枚手札に生成し、1戦闘につき最大3枚まで永久生成できる。各所の「囚魘」の行動力消費を-1する。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_2 = {
    Text = "自身の<ExhaustionIconKeywords:力減少>ステータスを除去する。すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg1]点減少させる。ライフが最も低い敵に[Arg6]％の触腕ダメージに等しい<RealDamage:固定ダメージ>( [Arg7] )を与え、キルした場合は永久に<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を2枚手札に生成し、1戦闘につき最大3枚まで永久生成できる。各所の「囚魘」の行動力消費を-1する。<BattueKeywords:包囲狩猟>を[Arg5]層獲得する。"
  },
  Skill_142696_AwakerSkillBackgroundStory = {
    Text = "「私に祈れ、望み通りの死を与えよう。」"
  },
  Skill_142696_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_142696_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初回使用時、「囚魘」を1枚ドローする（ [Arg3]/1 ）。"
  },
  Skill_142696_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与える。ポントスは<Energy:[Energy:Arg2]>点の狂気を獲得。"
  },
  Skill_142696_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。ポントスは <Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初回使用時、「囚魘」を1枚ドローする。"
  },
  Skill_142696_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_142696_Name = {Text = "攻撃"},
  Skill_142696_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_142699_AwakerSkillBackgroundStory = {
    Text = "「エポヤンスで眠り、エポヤンスで痛飲せよ、あの永久なる、古き、深淵の源にて。」"
  },
  Skill_142699_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_142699_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初回使用時、「囚魘」を1枚ドローする（ [Arg3]/1 ）。"
  },
  Skill_142699_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ポントスは<Energy:[Energy:Arg2]>点の狂気を獲得。"
  },
  Skill_142699_Desc_3 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。ポントスは <Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初回使用時、「囚魘」を1枚ドローする。"
  },
  Skill_142699_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_142699_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_142700_AwakerSkillBackgroundStory = {
    Text = "「あなたは何が欲しい？」\n力、秩序、失って取り戻すこと、血で仇を雪ぐこと…………\n彼は長く暗い沈黙に沈んだ。しかし実はとうに答えを持っていた、解のない答えを。\n彼は太陽が東から昇り西へ沈むことを望み、すべてが普段通りであることを望んだ。"
  },
  Skill_142700_BattleDesc_0 = {
    Text = "ポントスは<Energy:[Energy:Arg1]>点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：デッキに「囚魘」が3枚あるごとに、「終わりなき狩宴」はさらに<BattueKeywords:包囲狩猟>を1層獲得する。ポントスのカードを1枚発射するごとに、次の「終わりなき狩宴」の一時的な力減少効果が[Arg3]％向上する。毎ターン最大3回まで発動する。"
  },
  Skill_142700_BattleDesc_15 = {
    Text = "ポントスは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：デッキ内に「囚魘」が2枚あるごとに、「終わりなき狩宴」は追加で<BattueKeywords:包囲狩猟>を1層獲得する。ポントスのカードを1枚発射するごとに、次の「終わりなき狩宴」の一時的な力減少効果が [Arg3]％ 上昇し、各ターン最大3回まで発動する。各ターン初回の「打撃」と初回の「防御」で追加で <Energy:[Energy:Arg4]> 点の狂気を獲得する"
  },
  Skill_142700_Desc_0 = {
    Text = "ポントスは[Arg2]％の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：デッキに「囚魘」が3枚あるごとに、「終わりなき狩宴」は<BattueKeywords:包囲狩猟>を1層獲得する。ポントスのカードを1枚発射するごとに、次の「終わりなき狩宴」の一時的な力減少効果が[Arg3]％向上する。毎ターン最大3回まで発動する。"
  },
  Skill_142700_Desc_15 = {
    Text = "ポントスは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：デッキ内に「囚魘」が2枚あるごとに、「終わりなき狩宴」は<BattueKeywords:包囲狩猟>を1層獲得する。ポントスのカードを1枚発射するごとに、次の「終わりなき狩宴」の一時的な力減少効果が [Arg3]％ 上昇し、各ターン最大3回まで発動する。各ターン初回の「打撃」と初回の「防御」で追加で <Energy:[Energy:Arg4]> 点の狂気を獲得する"
  },
  Skill_142700_EffectNameList = {Text = "狂気"},
  Skill_142700_Name = {
    Text = "深淵に沈む怨嗟"
  },
  Skill_142802_Desc = {
    Text = "装備者は <Yellow:[Arg1]> 点の固定狂気を獲得し、各所の指令カードの<ErosionColorInkKeywords:認知錯乱>効果を除去する。"
  },
  Skill_142802_Name = {
    Text = "上への墜落"
  },
  Skill_142803_BattleDesc = {
    Text = "すべての敵に [Arg1] 点および最大ライフの1％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace24:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142803_Desc = {
    Text = "すべての敵に装備者の攻撃力3000％および最大ライフの1％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace24:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142803_Name = {
    Text = "人間界への足跡"
  },
  Skill_142804_Desc = {
    Text = "装備者は <Yellow:[Arg1]> 点の固定狂気を獲得し、各所の指令カードの<ErosionColorInkKeywords:認知錯乱>効果を除去する。"
  },
  Skill_142804_Name = {
    Text = "上への墜落"
  },
  Skill_142805_Desc = {
    Text = "装備者は <Yellow:[Arg1]> 点の固定狂気を獲得し、各所の指令カードの<ErosionColorInkKeywords:認知錯乱>効果を除去する。"
  },
  Skill_142805_Name = {
    Text = "上への墜落"
  },
  Skill_142806_BattleDesc = {
    Text = "すべての敵に [Arg1] 点および最大ライフの0.4％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace21:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142806_Desc = {
    Text = "すべての敵に装備者の攻撃力1500%およびその最大ライフの0.4%の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付加し、1枚の<Falltospace21:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142806_Name = {
    Text = "人間界への足跡"
  },
  Skill_142807_Desc = {
    Text = "装備者は <Yellow:[Arg1]> 点の固定狂気を獲得し、各所の指令カードの<ErosionColorInkKeywords:認知錯乱>効果を除去する。"
  },
  Skill_142807_Name = {
    Text = "上への墜落"
  },
  Skill_142808_BattleDesc = {
    Text = "すべての敵に [Arg1] 点および最大ライフの0.8％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace23:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142808_Desc = {
    Text = "すべての敵に装備者の攻撃力2500％および最大ライフの0.8％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace23:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142808_Name = {
    Text = "人間界への足跡"
  },
  Skill_142809_BattleDesc = {
    Text = "すべての敵に [Arg1] 点および最大ライフの0.6％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace22:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142809_Desc = {
    Text = "すべての敵に装備者の攻撃力2000％および最大ライフの0.6％の固定<Corrosion:侵蝕>を与え、各所にいる他の覚醒体の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与し、1枚の<Falltospace22:「上への墜落」>をドロー山にシャッフルする。"
  },
  Skill_142809_Name = {
    Text = "人間界への足跡"
  },
  Skill_142846_AwakerSkillBackgroundStory = {
    Text = "人間の耳と現在のシルバーコアテクノロジーでは、ポントスの猟の哨笛からいかなる有効な情報も得ることが今のところできない。\nしかしエポヤンスに同化されたすべての個体は、哨笛の指令に従うことに極めて速く適応しているようだ。"
  },
  Skill_142846_Desc = {
    Text = "本戦闘で初めて発動した場合、3種類の異なる<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>「囚魘」を生成して手札に加え、<Block:[Block:Arg1]>点のシールドを獲得する。永久囚魘を4枚持つごとにそのうち1枚を「双生の魘鬼」にアップグレードする。そうでない場合、「囚魘」を3枚ドローする。"
  },
  Skill_142846_EffectNameList = {
    Text = "シールド、囚魘レベル"
  },
  Skill_142846_Name = {
    Text = "魇を駆る哨笛"
  },
  Skill_142846_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_142847_AwakerSkillBackgroundStory = {
    Text = "エポヤンスの出現頻度は規則的ではなく、その全貌も観測することができない。\n唯一知られているのは、あの顔のない生物が群れをなして天空に現れるとき、窓の内側から名状しがたい珠光を放つ一棟の家屋が、霧の中のどこかの断崖の上に屹立するということだ。"
  },
  Skill_142847_BattleDesc_0 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の必ずクリティカルとなるダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。追加でX回発動する。"
  },
  Skill_142847_BattleDesc_2 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の必ずクリティカルとなるダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。追加でX+1回発動する。"
  },
  Skill_142847_Desc_0 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の必ずクリティカルとなるダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。追加でX回発動する。"
  },
  Skill_142847_Desc_2 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の必ずクリティカルとなるダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。追加でX+1回発動する。"
  },
  Skill_142847_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_142847_Name = {
    Text = "縦横掠奪"
  },
  Skill_142847_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_142874_Desc_1 = {
    Text = "敵に <Damage:[Damage:Arg1]> ダメージを与え、ダメージ量の半分のライフを失う、または味方に <Block:[Block:Arg2]> シールドを付与する。[Arg3] 枚ドローする。"
  },
  Skill_142874_Name_1 = {
    Text = "囚われた悪夢"
  },
  Skill_142875_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_142875_Name_1 = {Text = "攻撃"},
  Skill_142876_Desc_1 = {
    Text = "<TauntKeywords:挑発>、攻撃を受けるたびに [Arg1] 枚の<PVPDerivativeCardKeywords_30:「猎魇」>を手札に加える。"
  },
  Skill_142876_Name_1 = {
    Text = "領主の儀"
  },
  Skill_142877_Desc_1 = {
    Text = "任意の他のターゲットを選択する。味方の場合、自身と味方が <Block:[Block:Arg1]> シールドを獲得し、次のターン開始前に受けたダメージの半分を肩代わりする；敵の場合、次のターン開始前に受けたダメージの半分を転嫁する。"
  },
  Skill_142877_Name_1 = {
    Text = "無休の狩宴"
  },
  Skill_142878_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> のダメージを与える。対象の狂気が [Arg2] 未満の場合、ダメージが2倍になる。そうでなければ<PVPEmptinessKeywords:虚無>を与える。"
  },
  Skill_142878_Name_1 = {
    Text = "狩りの芸術"
  },
  Skill_142879_Desc_1 = {
    Text = "[Arg1] 枚の<PVPDerivativeCardKeywords_30:「猎魇」>をドロー山に加え、[Arg2] 枚ドローする。"
  },
  Skill_142879_Name_1 = {
    Text = "悪夢使い"
  },
  Skill_142958_Desc_1 = {
    Text = "指定した味方に <Block:[Block:Arg1]> のシールドを付与し、<PVPGrowthKeywords:成長> -[Arg2]、シールド効果がゼロになった後、代わりに [Arg3] 枚ドローする。"
  },
  Skill_142958_Desc_2 = {
    Text = "[Arg3] 枚ドローする。"
  },
  Skill_142960_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142960_Name_1 = {
    Text = "ランティゴス専用武器（仮テキスト）"
  },
  Skill_142961_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」前に現在ライフの 25% を失う；「狂気解放」後に全体の敵に [Arg1] ダメージを与え、同量のライフを吸収する。"
  },
  Skill_142961_Name_1 = {
    Text = "甘美な欺瞞"
  },
  Skill_142962_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142962_Name_1 = {
    Text = "ツァトゥグァSR（仮テキスト）"
  },
  Skill_142963_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142963_Name_1 = {
    Text = "ハゲワシSR(仮テキスト)"
  },
  Skill_142964_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142964_Name_1 = {
    Text = "アヤヴァゴモンSR（仮テキスト）"
  },
  Skill_142965_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142965_Name_1 = {
    Text = "シャタク鳥専用武器（仮テキスト）"
  },
  Skill_142966_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時とターン開始時、ランダムな敵に [Arg1] 層<PVPCompassKeywords:岐路を示す羅針盤>を付与する。"
  },
  Skill_142966_Name_1 = {
    Text = "岐路を指す羅針盤"
  },
  Skill_142967_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142967_Name_1 = {
    Text = "ハゲワシ専用武器（仮テキスト）"
  },
  Skill_142968_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142968_Name_1 = {
    Text = "ファラオSR（仮テキスト）"
  },
  Skill_142969_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142969_Name_1 = {
    Text = "起源オジール専用武器(仮テキスト)"
  },
  Skill_142970_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142970_Name_1 = {
    Text = "ヘキサン専用武器（仮テキスト）"
  },
  Skill_142971_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手札上限+ [Arg1] 、装備者または味方が死亡した際、そのカードは<PVPDerivativeCardKeywords_2:「幻影」>に変換されず、<PVPDerivativeCardKeywords_30:「魘鬼狩り」>に変換される。"
  },
  Skill_142971_Name_1 = {
    Text = "生きた囚人籠"
  },
  Skill_142972_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142972_Name_1 = {
    Text = "本源オージルSR（仮テキスト）"
  },
  Skill_142973_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142973_Name_1 = {
    Text = "真貌・トゥルーSR(仮テキスト)"
  },
  Skill_142975_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142975_Name_1 = {
    Text = "サトグア専用武器(仮テキスト)"
  },
  Skill_142977_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142977_Name_1 = {
    Text = "ランティゴスSR(仮テキスト)"
  },
  Skill_142978_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、敵全体に [Arg1] 層の<PVPBless:祝福>を付与する。"
  },
  Skill_142978_Name_1 = {
    Text = "穏やかな真実"
  },
  Skill_142980_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142980_Name_1 = {
    Text = "シャタク鳥SR（仮テキスト）"
  },
  Skill_142981_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_142981_Name_1 = {
    Text = "アヤヴァゴモン専用武器（仮テキスト）"
  },
  Skill_143024_Desc_1 = {
    Text = "味方のポジション1またはポジション2または敵を選択し、メカニズムを無視しない。"
  },
  Skill_143024_Name_1 = {
    Text = "ターゲットテスト4"
  },
  Skill_143025_Desc_1 = {
    Text = "味方または敵を選択し、敵の挑発を無視する。"
  },
  Skill_143025_Name_1 = {
    Text = "ターゲットテスト2"
  },
  Skill_143026_Desc_1 = {
    Text = "味方のポジション1またはポジション2または敵を選択し、敵の潜行を無視する。"
  },
  Skill_143026_Name_1 = {
    Text = "ターゲットテスト3"
  },
  Skill_143027_Desc_1 = {
    Text = "味方または敵を選択し、敵の潜行と挑発を無視する。"
  },
  Skill_143027_Name_1 = {
    Text = "ターゲットテスト1"
  },
  Skill_143028_Desc_1 = {
    Text = "対象のテストに必要なカードを獲得する。"
  },
  Skill_143028_Name_1 = {
    Text = "目標テスト"
  },
  Skill_143392_Desc_1 = {
    Text = "覚醒体1体のライフをゼロにする。"
  },
  Skill_143392_Name_1 = {
    Text = "ライフをゼロに"
  },
  Skill_143432_Desc = {
    Text = "行動力消費を1増加"
  },
  Skill_143432_Name = {
    Text = "行動力消費を1増加"
  },
  Skill_143433_Desc = {
    Text = "固定行動力1"
  },
  Skill_143433_Name = {
    Text = "固定行動力1"
  },
  Skill_143434_Desc = {
    Text = "固定行動力5"
  },
  Skill_143434_Name = {
    Text = "固定行動力5"
  },
  Skill_143443_Desc = {
    Text = "条件に応じて覚醒体を選択する"
  },
  Skill_143443_Name = {
    Text = "インターフェーステスト"
  },
  Skill_143494_Desc_1 = {
    Text = "純粋ダメージを免疫する。二度目の発動で解除。"
  },
  Skill_143494_Name_1 = {
    Text = "純粋ダメージ免疫"
  },
  Skill_143495_Desc_1 = {
    Text = "アクティブダメージを免疫する。二度目の発動で解除。"
  },
  Skill_143495_Name_1 = {
    Text = "アクティブダメージ免疫"
  },
  Skill_143556_Desc = {
    Text = "囚われた悪夢テスト"
  },
  Skill_143556_Name = {
    Text = "囚われた悪夢テスト"
  },
  Skill_143557_Desc_0 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点減少させ、<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。"
  },
  Skill_143557_Desc_3 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点減少させ、<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。<RippleKeywords:余波>：行動力消費 -1。"
  },
  Skill_143557_Name = {
    Text = "惑乱の魘鬼"
  },
  Skill_143557_tempName_1 = {
    Text = "惑乱の魘鬼"
  },
  Skill_143557_tempName_2 = {
    Text = "双子·惑乱の魘鬼"
  },
  Skill_143558_BattleDesc_0 = {
    Text = "ライフが最も低い敵に [Arg1]％ の触腕ダメージに等しい<RealDamage:固定ダメージ>( [Arg2] )を与える。ポントスの基礎クリティカルダメージの [Arg3]% に等しい一時的なクリティカルダメージ( [Arg4]％ )を獲得する。"
  },
  Skill_143558_BattleDesc_3 = {
    Text = "ライフが最も低い敵に [Arg1]％ の触腕ダメージに等しい<RealDamage:固定ダメージ>( [Arg2] )を与える。ポントスの基礎クリティカルダメージの [Arg3]% に等しい一時的なクリティカルダメージ( [Arg4]％ )を獲得する。<RippleKeywords:余波>：行動力消費 -1。"
  },
  Skill_143558_Desc_0 = {
    Text = "ライフが最も低い敵に [Arg5]％ の触腕ダメージに相当する<RealDamage:固定ダメージ>を与える。ポントスの基礎クリティカルダメージの [Arg3]％ に相当する一時的なクリティカルダメージを獲得する。"
  },
  Skill_143558_Desc_3 = {
    Text = "ライフが最も低い敵に [Arg5]％ の触腕ダメージに相当する<RealDamage:固定ダメージ>を与える。ポントスの基礎クリティカルダメージの [Arg3]％ に相当する一時的なクリティカルダメージを獲得する。<RippleKeywords:余波>：行動力消費 -1。"
  },
  Skill_143558_Name = {
    Text = "狩殺の魘鬼"
  },
  Skill_143558_tempName_1 = {
    Text = "狩殺の魘鬼"
  },
  Skill_143558_tempName_2 = {
    Text = "双子·狩殺の魘鬼"
  },
  Skill_143559_Desc_0 = {
    Text = "[Arg1] 枚の<DerivativeCardKeywords_4:「啓示」>をドロー山にシャッフルし、他の覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_143559_Desc_3 = {
    Text = "[Arg1] 枚の<DerivativeCardKeywords_4:「啓示」>をドロー山にシャッフルし、他の覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得する。<RippleKeywords:余波>：行動力消費 -1。"
  },
  Skill_143559_Name = {
    Text = "略奪の魘鬼"
  },
  Skill_143559_tempName_1 = {
    Text = "略奪の魘鬼"
  },
  Skill_143559_tempName_2 = {
    Text = "双子·略奪の魘鬼"
  },
  Skill_143604_Desc = {
    Text = "一時的なクリティカルダメージ +[Arg1]％、すべての敵の<ExhaustionIconKeywords:力>を一時的に [Arg2] 点減少させる。ポントスがパーティにいる場合、<BattueKeywords:囲い猟>を1層獲得する。"
  },
  Skill_143686_Desc = {
    Text = "囚魘テスト2"
  },
  Skill_143686_Name = {
    Text = "囚魘テスト2"
  },
  Skill_143687_Desc = {
    Text = "プレイヤーが虚弱でなければカード面は通常の胚胎、虚弱であれば聖胎"
  },
  Skill_143687_Name = {
    Text = "カード条件式テスト"
  },
  Skill_144438_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：味方が死亡した時、自身が <Energy:[Energy:Arg1]> 狂気を獲得する。味方が復活した時、その味方が <Energy:[Energy:Arg2]> 狂気を獲得する。狂気獲得効果は対象の狂気が満タンでない時のみ発動し、最大 [Arg8] 回まで発動可能。回数を使い切ると命輪を破壊する。"
  },
  Skill_144438_Name_1 = {
    Text = "霊魂同調"
  },
  Skill_144486_AwakerSkillBackgroundStory = {
    Text = "仙女と魔法使いが出会ったのは、町外れの人気のない空き地だった。\nその時、彼女は華やかな身なりの余所者の子供たちに笑顔で声をかけており、魔法使いは母親の手首でじゃらじゃら鳴る金の腕輪に、素知らぬ顔で目をつけていた。\n二人の視線が空中でぶつかった瞬間、互いの意図を悟った。\nこの無言の駆け引きは、最終的に魔法使いが一枚上手で、老練な経験をもって辛くも制した。\nしかし、新たな、詐欺まがいの素晴らしき事業が、ここに幕を開けたのだった。"
  },
  Skill_144486_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：1 スタックの<WormGrowth1:飽満>を獲得する。ダメージを与えるたびに対象に [Corrosion:Arg10] 点の<Corrosion:侵蝕>を付与する。】手札にある全カードの<BurningKeywords2:燃焼>ステータスを解除する。<Block:[Block:Arg2]> 点のシールドを獲得する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg8] 回与える。<WormGrowth1:飽満> 1 スタックごとに狂気解放の基礎ダメージとシールドが [Arg6]% 上昇する。全ての<SacrificialMark1:供物>を消費し、各スタックごとにダメージ回数 +1 し、<WormGrowth1:飽満>を獲得する。現在の<WormGrowth1:飽満>スタック数：[Arg9]、本戦闘での累積スタック数：[Arg11]"
  },
  Skill_144486_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：1 スタックの<WormGrowth2:飽満>を獲得し、ダメージを与えるたびに対象に [Corrosion:Arg10] 点の<Corrosion:侵蝕>を付与する。】手札にある全カードの<BurningKeywords2:燃焼>ステータスを解除する。<Block:[Block:Arg2]> 点のシールドを獲得する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg8] 回与える。<WormGrowth2:飽満> 1 スタックごとに狂気解放の基礎ダメージとシールドが [Arg6]% 上昇する。全ての<SacrificialMark1:供物>を消費し、各スタックごとにダメージ回数 +1 し、<WormGrowth2:飽満>を獲得する。現在の<WormGrowth2:飽満>スタック数：[Arg9]、本戦闘での累積スタック数：[Arg11]"
  },
  Skill_144486_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：1 スタックの<WormGrowth1:飽満>を獲得する。ダメージを与えるたびに対象に [Corrosion:Arg10] 点の<Corrosion:侵蝕>を付与する。】手札にある全カードの<BurningKeywords2:燃焼>ステータスを解除する。<Block:[Block:Arg2]> 点のシールドを獲得する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg8] 回与える。<WormGrowth1:飽満> 1 スタックごとに狂気解放の基礎ダメージとシールドが [Arg6]% 上昇する。全ての<SacrificialMark1:供物>を消費し、各スタックごとにダメージ回数 +1 し、<WormGrowth1:飽満>を獲得する。"
  },
  Skill_144486_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：1 スタックの<WormGrowth2:飽満>を獲得し、ダメージを与えるたびに対象に [Corrosion:Arg10] 点の<Corrosion:侵蝕>を付与する。】手札にある全カードの<BurningKeywords2:燃焼>ステータスを解除する。<Block:[Block:Arg2]> 点のシールドを獲得する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg8] 回与える。<WormGrowth2:飽満> 1 スタックごとに狂気解放の基礎ダメージとシールドが [Arg6]% 上昇する。全ての<SacrificialMark1:供物>を消費し、各スタックごとにダメージ回数 +1 し、<WormGrowth2:飽満>を獲得する。"
  },
  Skill_144486_EffectNameList = {
    Text = "シールド,ダメージ,捕食侵蝕"
  },
  Skill_144486_Name = {
    Text = "じゃじゃーん★妖精さん登場！"
  },
  Skill_144486_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食>：1 スタックの<WormGrowth2:飽満>を獲得する。ダメージを与えるたびに対象に [Corrosion:Arg10] 点の<Corrosion:侵蝕>を付与する】手札にある全カードの<BurningKeywords2:燃焼>ステータスを解除する。<Block:[Block:Arg2]> 点のシールドを獲得する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg8] 回与える。<WormGrowth2:飽満> 1 スタックごとに狂気解放の基礎ダメージとシールドが [Arg6]% 上昇する。全ての<SacrificialMark1:供物>を消費し、各スタックごとにダメージ回数 +1 し、<WormGrowth2:飽満>を獲得する。<FaxianKeywords:発見> 2 組の<Blessing:贈り物>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、各組 2 枚を含み、1 組を選択して手札に加える。  全ての敵の<ExhaustionIconKeywords:力>を永久に [Exhaustion:Arg12] 点減少させる。現在の<WormGrowth2:飽満>スタック数：[Arg9]。本戦闘での累積スタック数：[Arg11]"
  },
  Skill_144486_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_144487_AwakerSkillBackgroundStory = {
    Text = "雪が降りそうな澄んだ夜になると、カラブはいつも煙突のそばに登り、静かに暗い空を見上げる。\n魔法の杖を天に向け、自ら作った呪文を描く。\nそして舞い落ちる粉雪が、かつて魂を捧げたあの雪の夜へと彼女を連れ戻す。\n「見て、これが私の魔法よ。」"
  },
  Skill_144487_Desc_0 = {
    Text = "ライフが最も高い敵に [Arg1] 点の<RealDamage:固定ダメージ>を与える。[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_144487_Desc_1 = {
    Text = "ライフが最も高い敵に [Arg1] 点の<RealDamage:固定ダメージ>を与える。[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。<Energy:[Energy:Arg3]> 点の狂気を獲得する。"
  },
  Skill_144487_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_144487_Name = {
    Text = "粉雪の呪い"
  },
  Skill_144487_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_144487_tempBattleDesc_1 = {
    Text = "ライフが最も高い敵に [Arg1] 点の<RealDamage:固定ダメージ>を [Arg4] 回与える。[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_144487_tempBattleDesc_2 = {
    Text = "ライフが最も高い敵に [Arg1] 点の<RealDamage:固定ダメージ>を [Arg4] 回与える。[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。<Energy:[Energy:Arg3]> 点の狂気を獲得する。"
  },
  Skill_144487_tempBattleDesc_3 = {
    Text = "全ての敵に [Arg1] 点の<RealDamage:固定ダメージ>を [Arg4] 回与え、[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_144487_tempBattleDesc_4 = {
    Text = "全ての敵に [Arg1] 点の<RealDamage:固定ダメージ>を [Arg4] 回与え、[Arg2] ターンの<WeaknessIconKeywords:虚弱>を付与する。<Energy:[Energy:Arg3]> 点の狂気を獲得する。"
  },
  Skill_144488_AwakerSkillBackgroundStory = {
    Text = "「この仙女が守ってあげる！超級防御魔法はいかなる攻撃も防ぎ切る！」"
  },
  Skill_144488_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_144488_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<Energy:[Energy:Arg2]> 点の狂気を獲得する。[Arg3] / 7 回「打撃」または「防御」を発射するたびに、1 スタックの<SacrificialMark1:供物>を獲得し、<FaxianKeywords:発見> [Arg4] 枚の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、1 枚を選択して手札に加える。"
  },
  Skill_144488_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。カラブは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_144488_Desc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。カラブは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_144488_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_144488_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_144489_BattleDesc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_144489_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_144489_Name = {
    Text = "機運の祝福·行動力"
  },
  Skill_144490_AwakerSkillBackgroundStory = {
    Text = "「この仙女が出るわよ！超級攻撃魔法はあらゆる盾を打ち砕く！」"
  },
  Skill_144490_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_144490_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。[Arg3] / 7 回「打撃」または「防御」を発射するたびに、1 スタックの<SacrificialMark1:供物>を獲得し、<FaxianKeywords:発見> [Arg4] 枚の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、1 枚を選択して手札に加える。"
  },
  Skill_144490_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。カラブは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_144490_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。カラブは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_144490_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_144490_Name = {Text = "攻撃"},
  Skill_144490_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_144491_AwakerSkillBackgroundStory = {
    Text = "強欲は人の本性。\n甘いものの誘惑を断れる者などいない、仙女の名付け親本人でさえも例外ではない。\nカラブは口を大きく開けて笑い、真っ黒な尖った牙をむき出しにした。"
  },
  Skill_144491_BattleDesc_0 = {
    Text = "カラブは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、次の「奇跡の祝福」の行動力消費 -3、各<FaxianKeywords:発見>の選択肢に追加で 1 枚の<DerivativeCardKeywords_152:「しゅくふく」>を含め、1 組を選択してドロー山に加える。"
  },
  Skill_144491_BattleDesc_15 = {
    Text = "カラブは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、次の「奇跡の祝福」の行動力消費 -3、各<FaxianKeywords:発見>の選択肢に追加で 2 枚の<DerivativeCardKeywords_152:「しゅくふく」>を含め、1 組を選択してドロー山に加える。「しゅくふく」を発射した後、胎児融合 +10、現在のライフが低いほど効果が高く、最大 100% 上昇する。"
  },
  Skill_144491_Desc_0 = {
    Text = "カラブは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、次の「奇跡の祝福」の行動力消費 -3、各<FaxianKeywords:発見>の選択肢に追加で 1 枚の<DerivativeCardKeywords_152:「しゅくふく」>を含め、1 組を選択してドロー山に加える。"
  },
  Skill_144491_Desc_15 = {
    Text = "カラブは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「猩紅炉」使用後、次の「奇跡の祝福」の行動力消費 -3、各<FaxianKeywords:発見>の選択肢に追加で 2 枚の<DerivativeCardKeywords_152:「しゅくふく」>を含め、1 組を選択してドロー山に加える。<Blessing:祝福>を発射した後、胎児融合 +10、現在のライフが低いほど効果が高く、最大 100% 上昇する。"
  },
  Skill_144491_EffectNameList = {Text = "狂気"},
  Skill_144491_Name = {
    Text = "魅惑の甘い果実"
  },
  Skill_144492_AwakerSkillBackgroundStory = {
    Text = "「果てしない財宝が欲しいか？」\n「無限の権力が欲しいか？」\n「死者をも蘇らせる霊薬が欲しいか？」\n「人の心を見透かす水晶球が欲しいか？」\n「愛しい人の心を取り戻す呪符が欲しいか？」\n「あらゆる問いに答える魔法の鏡が欲しいか？」\n「すべての欲望をたちまち満たす蜜の果実が欲しいか？」\n願いさえ唱えれば、ここには何でも揃っている。\nさあ、誠意を見せて、仙女の名付け親に捧げ物をするがよい！\n奇跡が訪れる、3秒お待ちを！\n3、2、1――逃げるが勝ち！"
  },
  Skill_144492_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> [Arg2] 枚の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、[Arg3] 枚を選択してドロー山に加える。"
  },
  Skill_144492_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> [Arg2] 枚の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、[Arg3] 枚を選択してドロー山に加える。"
  },
  Skill_144492_EffectNameList = {
    Text = "シールド、力、一時的な力減少、固定狂気、キーエネルギー、一時的なダメージ強化"
  },
  Skill_144492_Name = {
    Text = "奇跡の祝福"
  },
  Skill_144492_PropertyNameList = {
    Text = "防御*GrowValue1、攻撃力*GrowValue2、防御*GrowValue3、$GrowValue4、$GrowValue5、$GrowValue6％"
  },
  Skill_144492_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> [Arg2] 枚の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、[Arg3] 枚を選択してドロー山に加える。"
  },
  Skill_144492_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> 2 組の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、各組 2 枚を含み、1 組を選択してドロー山に加える。"
  },
  Skill_144492_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> 3 組の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、各組 2 枚を含み、1 組を選択してドロー山に加える。"
  },
  Skill_144492_tempBattleDesc_4 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> 2 組の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、各組 3 枚を含み、1 組を選択してドロー山に加える。"
  },
  Skill_144492_tempBattleDesc_5 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<FaxianKeywords:発見> 3 組の<BlessingNegativeEffect:代償>が異なる<DerivativeCardKeywords_152:「しゅくふく」>を行い、各組 3 枚を含み、1 組を選択してドロー山に加える。"
  },
  Skill_144512_Name = {
    Text = "テストタイトル名2"
  },
  Skill_144513_Name = {
    Text = "テストタイトル名3"
  },
  Skill_144514_Desc = {
    Text = "発射後、キーオーダーパック3択を行う。各パックには3つのキーオーダーが含まれる。選択後、順番に直接発動する。"
  },
  Skill_144514_Name = {
    Text = "キーオーダーパック3択"
  },
  Skill_144515_Name = {
    Text = "テストタイトル名1"
  },
  Skill_145386_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に [Arg2] スタックの<EnergyStorageKeywords:蓄力>を獲得し、「打撃」のダメージアップ [Arg1]% かつ<PVPPunctureDamagewords:刺突ダメージ>に変更する。"
  },
  Skill_145386_Name_1 = {
    Text = "天より堕ちる"
  },
  Skill_145387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージアップ [Arg1]% 、「打撃」のたびにダメージが追加で [Arg2]% アップし、最大 [Arg3]% まで上昇する。"
  },
  Skill_145387_Name_1 = {
    Text = "不滅の餓骨"
  },
  Skill_145439_BattleDesc = {
    Text = "行動力を 1 点獲得する。保留：<Green:[Arg1]> 点の固定ライフ回復量と <Yellow:[Arg2]> 点の固定狂気を蓄積する（蓄積済み <Green:[Arg3]> ライフ回復量、<Yellow:[Arg4]> 点の狂気）。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145439_Desc = {
    Text = "行動力を 1 点獲得する。保留：装備者の体力の 5％ 分の固定ライフ回復量と 3 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145439_Name = {
    Text = "霊魂同調"
  },
  Skill_145440_BattleDesc = {
    Text = "行動力を 1 点獲得する。保留：<Green:[Arg1]> 点の固定ライフ回復量と <Yellow:[Arg2]> 点の固定狂気を蓄積する（蓄積済み <Green:[Arg3]> ライフ回復量、<Yellow:[Arg4]> 点の狂気）。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145440_Desc = {
    Text = "行動力を 1 点獲得する。保留：装備者の体力の 6％ 分の固定ライフ回復量と 4 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145440_Name = {
    Text = "霊魂同調"
  },
  Skill_145441_BattleDesc = {
    Text = "行動力を 1 点獲得する。保留：<Green:[Arg1]> 点の固定ライフ回復量と <Yellow:[Arg2]> 点の固定狂気を蓄積する（蓄積済み <Green:[Arg3]> ライフ回復量、<Yellow:[Arg4]> 点の狂気）。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145441_Desc = {
    Text = "行動力を 1 点獲得する。保留：装備者の体力の 4％ 分の固定ライフ回復量と 2 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145441_Name = {
    Text = "霊魂同調"
  },
  Skill_145442_BattleDesc = {
    Text = "行動力を 1 点獲得する。保留：<Green:[Arg1]> 点の固定ライフ回復量と <Yellow:[Arg2]> 点の固定狂気を蓄積する（蓄積済み <Green:[Arg3]> ライフ回復量、<Yellow:[Arg4]> 点の狂気）。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145442_Desc = {
    Text = "行動力を 1 点獲得する。保留：装備者の体力の 3％ 分の固定ライフ回復量と 1 点の固定狂気をこのカードに蓄積する。このカードが破壊されていない場合、一度だけ死亡を免疫し、蓄積した全てのライフ回復量と狂気を解放し、その後このカードを破壊する。"
  },
  Skill_145442_Name = {
    Text = "霊魂同調"
  },
  Skill_145536_BattleDesc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_145536_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145536_Name = {
    Text = "機運の祝福·キーエネルギー"
  },
  Skill_145537_BattleDesc = {
    Text = "全ての覚醒体が <Yellow:[Arg1]> 点の固定狂気を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145537_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145537_Name = {
    Text = "機運の祝福·狂気"
  },
  Skill_145538_BattleDesc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_145538_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145538_Name = {
    Text = "機運の祝福·ダメージ強化"
  },
  Skill_145539_BattleDesc = {
    Text = "[Arg1] 枚のカードをドローする。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_145539_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145539_Name = {
    Text = "機運の祝福·ドロー"
  },
  Skill_145540_BattleDesc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_145540_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145540_Name = {
    Text = "機運の祝福·力"
  },
  Skill_145541_BattleDesc = {
    Text = "一時的にすべての敵の【Exhaustion:Arg1】点の<ExhaustionIconKeywords:力>を低下させる。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を 1 層獲得する。"
  },
  Skill_145541_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_145541_Name = {
    Text = "機運の祝福·衰弱"
  },
  Skill_145557_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージを与え、与えたダメージの半分のライフを回復する。「打撃」として扱う。"
  },
  Skill_145557_Name_1 = {Text = "喰の刃"},
  Skill_145558_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_145558_Name_1 = {Text = "攻撃"},
  Skill_145559_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:刺突ダメージ>を与え、いずれかの敵をキルした場合、[Arg2] <PVPPowerIconKeywords:力>を獲得する。"
  },
  Skill_145559_Name_1 = {
    Text = "海に沈みし鯨"
  },
  Skill_145560_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与え、一時的に [Arg2] <PVPPowerIconKeywords:力>を奪い、[Arg3] ライフを失う。"
  },
  Skill_145560_Name_1 = {Text = "滅の刃"},
  Skill_145561_Desc_1 = {
    Text = "目標の味方以外のすべての覚醒体に <Damage:[Damage:Arg1]> の<PVPPunctureDamagewords:刺突ダメージ>を与え、以降ターン開始のたびにこの効果を繰り返す。"
  },
  Skill_145561_Name_1 = {
    Text = "鯨を呑み込む嵐"
  },
  Skill_145561_UnknownName = {
    Text = "鯨を呑み込む嵐"
  },
  Skill_145562_Desc_1 = {
    Text = "敵を1体選択し、双方が互いに<PVPLock:ロック>され、対象に <Damage:[Damage:Arg1]> ダメージを与える。対象が<PVPLock:ロック>中に死亡した場合、このカードを手札に戻す。<PVPFusion:融合>：ダメージ+ [Arg2] 。"
  },
  Skill_145562_Name_1 = {
    Text = "決闘の契約"
  },
  Skill_145612_Desc = {
    Text = "祝福は行動力消費 1、<RetainIconKeywords:保留>・<PrepareKeypvewords:準備>・<DepleteIconKeywords:消耗>を持つバフカードです。\n発射時に<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。「しゅくふく」には 3 種類あります：\n「機運の祝福」：「逃した好機」を発動しない。\n「朴直の祝福」：「大仰な言葉」を発動しない。\n「真心の祝福」：「秘めた悪意」を発動しない。"
  },
  Skill_145612_Name = {Text = "祝福"},
  Skill_145664_Desc = {
    Text = "公式に従い [Poison:Arg1] 毒、[Counterattack:Arg2] カウンター、[Power:Arg3] 力、[Exhaustion:Arg4] 衰弱、[TentaclePower:Arg5] 触腕ダメージ、[FateCut:Arg6] 運命裁断、[Corrosion:Arg7] 侵蝕を付与する。"
  },
  Skill_145664_Name = {
    Text = "公式に従いステータスを付与"
  },
  Skill_145673_AwakerSkillBackgroundStory = {
    Text = "「見えているか？彼らの肉がお前の刃の下でいかに裂け、鮮やかな血の花を咲かせたかを。」\n「目を閉じれば存在しないなどと思い上がるな、愛しき子よ。」\n「お前にはわかっている、お前は知っている。」\n「お前が磨き上げた技は、とうに死の色に染まり、他者に次なる災厄を招くだけだ。」"
  },
  Skill_145673_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_145673_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを2回与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_145673_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。負誓·オジールは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_145673_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを2回与える。負誓·オジールは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_145673_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_145673_Name = {Text = "攻撃"},
  Skill_145673_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_145674_AwakerSkillBackgroundStory = {
    Text = "「聞こえているか？彼らの嘆きがいかにあらゆる場所に響き渡り、それでも誰一人として庇護の手を差し伸べなかったかを。」\n「耳を塞げば無視できると思うな、無能な騎士よ。」\n「お前は目の当たりにした、お前は選んだ。」\n「敵の波が押し寄せた時、お前は甲冑を脱ぎ捨て、彼らがお前の最愛の地を蹂躙するままに任せた。」"
  },
  Skill_145674_BattleDesc = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_145674_Desc = {
    Text = "<Block:[Block:Arg3]> 点のシールドを獲得する。負誓·オジールは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_145674_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_145674_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_145675_AwakerSkillBackgroundStory = {
    Text = "実のところ、オジールはあの城の真の姿をとうに忘れていた。\nしかし今、彼は心の奥底にある祈りを拠り所に、新たな壁を築くことができる。\n彼の守護のもとで、人々の笑い声が今なお聞こえ、見慣れた花々が再び野原に咲き乱れるならば……\nそれならば、すでに異形と化したその心臓にも、この世に留まる意味があるというものだ。"
  },
  Skill_145675_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>ポイントのシールドを獲得し、[Power:Arg2]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu:暗涌>を消費し、1層消費するごとに与えるシールドと力が33%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>ポイントのシールドを獲得し、[Power:Arg2]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu2:暗涌>を消費し、1層消費するごとに与えるシールドと力が50%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_Desc_0 = {
    Text = "<Block:[Block:Arg3]>ポイントのシールドを獲得し、[Power:Arg4]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu:暗涌>を消費し、1層消費するごとに与えるシールドと力が33%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_Desc_3 = {
    Text = "<Block:[Block:Arg3]>ポイントのシールドを獲得し、[Power:Arg4]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu2:暗涌>を消費し、1層消費するごとに与えるシールドと力が50%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_EffectNameList = {
    Text = "シールド,力"
  },
  Skill_145675_Name = {
    Text = "墜ちぬ騎士の心"
  },
  Skill_145675_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]>ポイントのシールドを獲得し、[Power:Arg5]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu:暗涌>を消費し、1層消費するごとに与えるシールドと力が33%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>ポイントのシールドを獲得し、[Power:Arg5]ポイントの<PowerIconKeywords:力>を獲得する。すべての<KuangNu2:暗涌>を消費し、1層消費するごとに与えるシールドと力が50%上昇する。<ShuZui:自罪>を1層獲得する。"
  },
  Skill_145675_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_145676_AwakerSkillBackgroundStory = {
    Text = "騎士たちは叙任の誓いを立てる時、その身に帯びた刃にも等しく栄光が宿る。\nしかし彼のものであった最初の、神聖なる使命を与えられた銀の槍は、とうに戦火の残燼の中に溶け消えていた。\nだが、どうせ罪を背負った身であれば、この罪深い漆黒を新たな武器とするのも悪くない。そうすれば、たとえさらに多くの血に染まろうとも、もはや故人に恥をかかせることはないだろう、と彼は思った。"
  },
  Skill_145676_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与え、[Arg2]％の力量ボーナスを享受し、<KuangNu:暗涌>を 1 層獲得する。"
  },
  Skill_145676_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、[Arg2]%の力ボーナスを享受する。<KuangNu2:暗涌>を1層獲得する。"
  },
  Skill_145676_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与え、300％の力量ボーナスを享受し、<KuangNu:暗涌>を 1 層獲得する。"
  },
  Skill_145676_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、力の300%ボーナスを享受する。<KuangNu2:暗涌>を1層獲得する。"
  },
  Skill_145676_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_145676_Name = {
    Text = "染罪の銃鋒"
  },
  Skill_145676_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_145677_AwakerSkillBackgroundStory = {
    Text = "かつて、少年はこの邪悪な黒い泥を自分の身から引き剥がそうと試みた。しかし何をしようとも――手で引き裂き、刃物で切り刻み、鈍器で打ち砕こうとも……目に見えぬ悪夢は払いのけられず、むしろますます図に乗るばかりだった。\nついに彼は認めた。自分とソレはとうに完全に一つに融合する存在となり、もはや分かつことはできないのだと。\nソレは彼の影となった。"
  },
  Skill_145677_BattleDesc_0 = {
    Text = "負誓·オジールは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：負誓·オジールは毎ターン初めて「染罪の銃鋒」がダメージを与えた際、同量の<Corrosion:侵蝕>を付与する。「防御」のシールドが 50％ 上昇し、1 枚ドローする。"
  },
  Skill_145677_BattleDesc_15 = {
    Text = "負誓·オジールは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：負誓·オジールは毎ターン初めて「染罪の銃鋒」がダメージを与えた際、同量の<Corrosion:侵蝕>を付与する。「染罪の銃鋒」の基礎ダメージが 100％ 上昇し、追加で 200％ の力ボーナスを受ける。「防御」のシールドが 100％ 上昇し、1 枚ドローする。"
  },
  Skill_145677_Desc_0 = {
    Text = "負誓·オジールは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：負誓·オジールは毎ターン初めて「染罪の銃鋒」がダメージを与えた際、同量の<Corrosion:侵蝕>を付与する。「防御」のシールドが 50％ 上昇し、1 枚ドローする。"
  },
  Skill_145677_Desc_15 = {
    Text = "負誓·オジールは [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：負誓·オジールは毎ターン初めて「染罪の銃鋒」がダメージを与えた際、同量の<Corrosion:侵蝕>を付与する。「染罪の銃鋒」の基礎ダメージが 100％ 上昇し、追加で 200％ の力ボーナスを受ける。「防御」のシールドが 100％ 上昇し、1 枚ドローする。"
  },
  Skill_145677_EffectNameList = {Text = "狂気"},
  Skill_145677_Name = {
    Text = "黒沼との共生"
  },
  Skill_145678_AwakerSkillBackgroundStory = {
    Text = "ミサゴの定期検査において、研究員たちはこの不定形の漆黒の物体を専門的に調査したことがあった。\n意外なことに、彼らはそこからいくつかの物質成分を実際に抽出することに成功し、矢も盾もたまらず第二次実験を開始した。しかし得られた結果はまったく異なるものだった。\nまるでその不定形という特性と呼応するかのように、それを構成する成分もまた刻一刻と変化し続け、まるで儚い幻影のようだった。\n形なきものの、根源もまた形なし。"
  },
  Skill_145678_Desc = {
    Text = "全ての敵の【Exhaustion:Arg1】点の<ExhaustionIconKeywords:力>を一時的に減少させ、【Power:Arg2】点の<PowerIconKeywords:力>を獲得する。追加でⅩ回発動する。Ⅹは最大 5 である。"
  },
  Skill_145678_EffectNameList = {
    Text = "一時的な力減少,力"
  },
  Skill_145678_Name = {
    Text = "無辺の荒影"
  },
  Skill_145678_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_145713_Desc = {
    Text = "発射後、プレイヤーの基礎シルバーキー上限を読み取り、シルバーキーを最大まで蓄積して出力する。"
  },
  Skill_145713_Name = {
    Text = "シルバーキー属性を取得"
  },
  Skill_145971_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、対象の現在ライフが自身より多い場合、双方の現在ライフを交換する。"
  },
  Skill_145971_Name_1 = {
    Text = "狂気解放"
  },
  Skill_145972_Desc_1 = {
    Text = "任意のターゲットのライフを <Heal:[Heal:Arg1]> 回復し、次のターン開始時に消費されていないライフを除去する。"
  },
  Skill_145972_Name_1 = {
    Text = "偽りなきもの"
  },
  Skill_145972_UnknownName = {
    Text = "偽りなきもの"
  },
  Skill_145973_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_145973_Name_1 = {Text = "攻撃"},
  Skill_145974_Desc_1 = {
    Text = "一名の敵に [Arg1] スタックの<PVPBless:祝福>を付与する。自身は <Damage:[Arg2]> ライフを失う。"
  },
  Skill_145974_Name_1 = {
    Text = "スキル三"
  },
  Skill_145975_Desc_1 = {
    Text = "<PVPBluff:誘惑>で一名の敵を戦意喪失させる。<PVPBluff:誘惑>終了後、全体の敵に <Damage:[Damage:Arg1]> ダメージを与える。"
  },
  Skill_145975_Name_1 = {
    Text = "スキル一"
  },
  Skill_145976_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂気を獲得し、<Damage:[Arg2]> ライフを失う。<DelayKeywords:レイテンシ 1>：[Arg1] 狂気を消費する。"
  },
  Skill_145976_Name_1 = {
    Text = "スキル二"
  },
  Skill_145988_Desc = {
    Text = "一時的に全体の敵の<ExhaustionIconKeywords:力>を [Arg1] ポイント低下させる。"
  },
  Skill_145988_Name = {
    Text = "原初の記憶·衰弱"
  },
  Skill_145989_Desc = {
    Text = "すべての覚醒体が <Energy:[Arg1]> 点の狂気を獲得する。"
  },
  Skill_145989_Name = {
    Text = "原初の記憶·触媒"
  },
  Skill_145990_Desc = {
    Text = "<Heal:[Arg1]> ポイントのライフを回復する"
  },
  Skill_145990_Name = {
    Text = "原初の記憶·回復"
  },
  Skill_145991_Desc = {
    Text = "すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_145991_Name = {
    Text = "原初の記憶·毒素"
  },
  Skill_145992_Desc = {
    Text = "[Arg1] 層の<RetaliateIconKeywords:一時的反撃>を獲得する。"
  },
  Skill_145992_Name = {
    Text = "原初の記憶·尖刺"
  },
  Skill_145993_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_145993_Name = {
    Text = "原初の記憶·剛力"
  },
  Skill_145995_Desc = {
    Text = "<Block:[Arg1]>点のシールドを獲得する。"
  },
  Skill_145995_Name = {
    Text = "原初の記憶·鉄壁"
  },
  Skill_146011_AwakerSkillBackgroundStory = {
    Text = "骨剣が描く弧線は、常に落ち着いて優雅だ。\n一振り一振りを真剣に放つこと——それが彼女の相手への、そして戦闘そのものへの、最大の敬意だ。"
  },
  Skill_146011_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_146011_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初めて発射した時、「短刀・喰」を1枚ドローする（ [Arg4]/1 ）。"
  },
  Skill_146011_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与える。蝕滅・ロータンは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_146011_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与える。蝕滅・ロータンは <Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初めて発射した時、「短刀・喰」を1枚ドローする。"
  },
  Skill_146011_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_146011_Name = {Text = "攻撃"},
  Skill_146011_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_146012_Desc = {
    Text = "出せない。このカードを保有している間、全ての敵が与えるダメージが 25% アップし、蝕滅・ロータンの指令カードが全て<DerivativeCardKeywords_154:「蝕滅」>に変化し、ターン開始時に<DerivativeCardKeywords_154:「蝕滅」>を 1 枚ドローする。"
  },
  Skill_146012_Name = {
    Text = "大剣・鯨堕"
  },
  Skill_146013_AwakerSkillBackgroundStory = {
    Text = "ごく稀に、ロータンは剣を収める。\nその異色の双眸は冷静に観察している。剣を収めるのは、常により良く剣を繰り出すためだけだ。"
  },
  Skill_146013_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_146013_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。<Energy:[Energy:Arg2]> 点の狂気を獲得する。毎ターン初めて発射した時、「長刀・滅」を1枚ドローする( [Arg4]/1 )。"
  },
  Skill_146013_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。蝕滅・ロータンは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_146013_Desc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。蝕滅・ロータンは <Energy:[Energy:Arg2]> 点の狂気を獲得する。各ターン初めて発射した時、「長刀・滅」を1枚ドローする。"
  },
  Skill_146013_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_146013_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_146014_AwakerSkillBackgroundStory = {
    Text = "リヴァイアサンの最も重く硬い頭蓋骨が長刃に磨かれ、彼女はそれを「陨」と呼んだ。\n重剣が横薙ぎに振るわれ、剣先の弧は巨大な鯨が尾鰭を揺らすかのようで、重厚な白骨が眼前のすべてを砕き潰す。\n私の鮮血を啜り、私のライフを喰らえ、とロータンは言った。\nそして、すべての生き物を、お前の止められない軌跡の中に陨落させよ。"
  },
  Skill_146014_Desc = {
    Text = "全体の敵に [Arg3] 回 <Damage:[Damage:Arg1]> 点のダメージを与え、[Arg2]% の力ボーナスを享受し、「打撃」として扱う。今ターン「打撃」を 1 枚発射するごとに、次に発射する「長刀・滅」の行動力消費 -1。"
  },
  Skill_146014_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_146014_Name = {
    Text = "長刀・滅"
  },
  Skill_146014_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_146015_AwakerSkillBackgroundStory = {
    Text = "リヴァイアサンは、彼女がその一撃を放った瞬間のことを永遠に覚えている。\n祂の領域において、その身の程知らずの影はすでに傷だらけだった。人間の肉体はかくも脆弱で、ほぼひと息つく間もなく彼女は再び立ち上がれなくなるはずだった。愚かで、傲慢で、哀れである——それがリヴァイアサンの彼女への全ての審判だった。\n審判が下される前に、その弱小な影は再び立ち上がった。彼女の笑い声は、祂にかつて感じたことのない感情をもたらした。\n祂は彼女が砕けた武器と傷ついた身体を携えて、祂へと高く跳躍するのを見た。祂は、星海をも断ち切るかのような剣意が、祂の眼前に迫るのを見た。\nその剣が祂を貫いた瞬間、リヴァイアサンはようやく悟った——祂がかつて経験したことのないその感情の名を、恐怖と。"
  },
  Skill_146015_Desc_0 = {
    Text = "<DerivativeCardKeywords_153:「大剣・鯨堕」>を消費することで発動できる。最もダメージの高い敵に <Damage:[Damage:Arg1]> 点の必中クリティカルダメージを与え、[Arg2]% の力ボーナスを享受する。目標が<DerivativeCardKeywords_153:「大剣・鯨堕」>を通じてダメージを1点上昇させるごとに、「断界の剣」のダメージ +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_Desc_3 = {
    Text = "<DerivativeCardKeywords_153:「大剣・鯨堕」>を消費することで発動できる。最もダメージの高い敵に <Damage:[Damage:Arg1]> 点の必中クリティカルダメージを与え、[Arg2]% の力ボーナスを享受する。目標が<DerivativeCardKeywords_153:「大剣・鯨堕」>を通じてダメージを1点上昇させるごとに、「断界の剣」のダメージ +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_EffectNameList = {
    Text = "ダメージ,力ボーナス"
  },
  Skill_146015_Name = {
    Text = "断界の剣"
  },
  Skill_146015_OverLimitUtlSkillDesc = {
    Text = "<DerivativeCardKeywords_153:「大剣・鯨堕」>を消費することで発動できる。[Power:Arg3] 点の<PowerIconKeywords:力>を獲得する。最もダメージの高い敵に <Damage:[Damage:Arg1]> 点の必中クリティカルダメージを与え、[Arg2]% の力ボーナスを享受する。目標が<DerivativeCardKeywords_153:「大剣・鯨堕」>を通じてダメージを1点上昇させるごとに、「断界の剣」のダメージ +[Arg4]。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2％"
  },
  Skill_146016_AwakerSkillBackgroundStory = {
    Text = "神明は彼女の霊と肉を引き裂き、それが混沌への究極の審判だと思っていた。\nしかし空虚な魂は追い求めることをやめず、剥ぎ取られた力も真には消え去らなかった。\n骨甲が再び彼女の身体を覆い、リヴァイアサンの鼓動が再び彼女の意志と共鳴した時――すべての拘束はその瞬間に砕け散った。\n霊と肉は星海の深淵で再び交わった。混沌の獣はもはや欠けていない。\nこの星海は、完全な彼女を再び迎え入れるだろう。"
  },
  Skill_146016_BattleDesc_0 = {
    Text = "「蝕滅・ロータン」は <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「蝕滅・ロータン」の指令カードのダメージ回数 +1。ターン開始時に<DerivativeCardKeywords_153:「大剣・鯨堕」>が手札にある場合、今ターン初回の<DerivativeCardKeywords_154:「蝕滅」>が狂気を 1 点盗むごとに、次の「断界の剣」の最終ダメージ +1％、最大 90％ まで累積。"
  },
  Skill_146016_BattleDesc_15 = {
    Text = "「蝕滅・ロータン」は <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「蝕滅・ロータン」の指令カードのダメージ回数 +1、<DerivativeCardKeywords_154:「蝕滅」>が盗む狂気が 50％ 増加する。ターン開始時に<DerivativeCardKeywords_153:「大剣・鯨堕」>が手札にある場合、今ターン初回の<DerivativeCardKeywords_154:「蝕滅」>が狂気を 1 点盗むごとに、次の「断界の剣」の最終ダメージ +1.5％、最大 135％ まで累積。"
  },
  Skill_146016_Desc_0 = {
    Text = "「蝕滅・ロータン」は [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「蝕滅・ロータン」の指令カードのダメージ回数 +1。ターン開始時に<DerivativeCardKeywords_153:「大剣・鯨堕」>が手札にある場合、今ターン初回の<DerivativeCardKeywords_154:「蝕滅」>が狂気を 1 点盗むごとに、次の「断界の剣」の最終ダメージ +1％、最大 90％ まで累積。"
  },
  Skill_146016_Desc_15 = {
    Text = "「蝕滅・ロータン」は [Arg2]％ の基礎狂気を獲得する。<ExaltIconKeywords:霊知啓発>：「蝕滅・ロータン」の指令カードのダメージ回数 +1、<DerivativeCardKeywords_154:「蝕滅」>が盗む狂気が 50％ 増加する。ターン開始時に<DerivativeCardKeywords_153:「大剣・鯨堕」>が手札にある場合、今ターン初回の<DerivativeCardKeywords_154:「蝕滅」>が狂気を 1 点盗むごとに、次の「断界の剣」の最終ダメージ +1.5％、最大 135％ まで累積。"
  },
  Skill_146016_EffectNameList = {Text = "狂気"},
  Skill_146016_Name = {
    Text = "原初への回帰"
  },
  Skill_146017_AwakerSkillBackgroundStory = {
    Text = "リヴァイアサンの最も鋭い牙が短刃に磨かれ、彼女はそれを「噬」と呼んだ。\nそれは弱者には一切の興味を示さず、剣先は常に最も強大な敵へと向けられる。刃は極めて速く突き出され、残像が消え去る頃には、星海のごとき広大な力も捕食し尽くされているだろう。\nその強欲に果てはなく、その飢餓の眼差しは生まれた瞬間からロータンを見つめ続け、一撃ごとにロータンの体内から血肉を噛みつく。\nロータンは気にしない。彼女は鮮血でそれを養い、力でそれを制する。彼女はそれを最強の相手へと振るい、力の味を、彼女はそれと共に味わう。"
  },
  Skill_146017_BattleDesc = {
    Text = "ランダムに <Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与え、[Power:Arg2] 点の<PowerIconKeywords:力>を獲得し、「打撃」として扱う。発射後ドロー山に戻す。このカードを3回発射するごとに1回追加で発動し、本ターン次に「長刀・滅」を発射した時に<DerivativeCardKeywords_153:「大剣・鯨堕」>に合成する（ [Arg4]/3 ）<DerivativeCardKeywords_154:>"
  },
  Skill_146017_Desc = {
    Text = "「打撃」として扱う。ランダムな敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与え、[Power:Arg2] 点の<PowerIconKeywords:力>を獲得し、発射後ドロー山に戻す。このカードを3回発射するごとに1回追加で発動し、本ターン次に「長刀・滅」を発射した時に<DerivativeCardKeywords_153:「大剣・鯨堕」>に合成する<DerivativeCardKeywords_154:>"
  },
  Skill_146017_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_146017_Name = {
    Text = "短刀・喰"
  },
  Skill_146017_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_146018_Desc = {
    Text = "カードを1枚引く。他の覚醒体から最大[Arg1]点の狂気を盗む。"
  },
  Skill_146018_Name = {Text = "蝕滅"},
  Skill_146018_tempBattleDesc_1 = {
    Text = "カードを1枚引く。他の覚醒体から最大[Arg1]点の狂気を盗む。"
  },
  Skill_146018_tempBattleDesc_2 = {
    Text = "カードを1枚引く。他の覚醒体から最大[Arg1]点の狂気を盗み、盗んだ値の50％の狂気を追加で獲得する。"
  },
  Skill_146067_Desc_1 = {
    Text = "カードを取り戻し、<Damage:[Arg1]> ダメージを受ける。"
  },
  Skill_146067_Name_1 = {Text = "祝福？"},
  Skill_146069_Desc = {
    Text = "発射後、手札を空にし、空白キーオーダーを手札に加える。"
  },
  Skill_146069_Name = {
    Text = "空白キーオーダーを取得"
  },
  Skill_146097_Desc = {
    Text = "発射後、手札を空にし、編隊キーオーダーを手札に加える。"
  },
  Skill_146097_Name = {
    Text = "編隊キーオーダーを取得"
  },
  Skill_146112_Desc = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得する。[Arg2]層の<Shimieluotanhuodong1:戦意>を蓄積する。発射後にドロー山へシャッフルされる。"
  },
  Skill_146112_Name = {Text = "狂の骨"},
  Skill_146113_Desc = {
    Text = "すべての覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得する。[Arg2] 点の<PowerIconKeywords:力>を獲得する。すべての<Shimieluotanhuodong1:戦意>を消費し、<Shimieluotanhuodong1:戦意> 1 層を消費するごとにすべての覚醒体の最終ダメージが 3％ 上昇する。"
  },
  Skill_146113_Name = {Text = "剣の骨"},
  Skill_146114_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。発射後、本ターン内でダメージを受けるたびに [Arg2] 層の<Shimieluotanhuodong1:戦意>を蓄積する。"
  },
  Skill_146114_Name = {Text = "傷の骨"},
  Skill_146132_Desc = {
    Text = "新しい真夏の夢のロジック。カードを1枚ドローし、指令カードまたは霊知啓発をドローした場合、その行動力消費を0にし、その所有者は <Energy:[Arg1]> 点の狂気を獲得する。そうでない場合、そのカードを捨て、この効果を繰り返す。"
  },
  Skill_146132_Name = {
    Text = "真夏の夢"
  },
  Skill_146388_Desc = {
    Text = "狂気解放の発動を許可する"
  },
  Skill_146388_Name = {
    Text = "本源ロタンテスト"
  },
  Skill_146461_Desc = {
    Text = "テキスト不要、翻訳不要。"
  },
  Skill_146461_Name = {
    Text = "冥刀の追撃"
  },
  Skill_146484_Desc = {
    Text = "[Arg1]％ の一時的ダメージ強化を獲得する。"
  },
  Skill_146484_Name = {
    Text = "原初の記憶·怒火"
  },
  Skill_146517_Desc = {
    Text = "保有キーオーダーから [Arg1] 種のキーオーダーを<FaxianKeywords:発見>し、[Arg2] 個のキーオーダーを選択して [Arg3] 回発動させる。"
  },
  Skill_146517_Name = {
    Text = "原初·双生の再演"
  },
  Skill_146519_Desc = {
    Text = "保有キーオーダーから [Arg1] 組のキーオーダーを<FaxianKeywords:発見>する。各組のキーオーダーは [Arg2] 個の異なるキーオーダーで構成される。[Arg3] 組のキーオーダーを選択し、その中のキーオーダーを順番に [Arg4] 回発動させる。"
  },
  Skill_146519_Name = {
    Text = "原初·三相の啓示"
  },
  Skill_146647_Desc = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得し、界域知識が [Arg2] 上昇する。カラブがパーティにいる場合、次の 1 回の<DerivativeCardKeywords_152:「しゅくふく」>が「負面効果」を発動しなくなる。"
  },
  Skill_146647_Name = {
    Text = "偽りなきもの"
  },
  Skill_146648_Desc = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得し、覚醒体を1体選択して他の覚醒体から最大 [Arg1] 点の狂気を盗む。蝕滅・ロータンがチームにいる場合、次の蝕滅・ロータンの「打撃」が1回追加で発動する。"
  },
  Skill_146648_Name = {
    Text = "鯨を呑み込む嵐"
  },
  Skill_146658_Name = {Text = "第3組"},
  Skill_146659_Name = {Text = "第1組"},
  Skill_146660_Name = {Text = "第2組"},
  Skill_147427_Desc_0 = {
    Text = "本ターン中、すべての敵から [Arg1] 点の<PowerIconKeywords:力>を奪う。"
  },
  Skill_147427_Desc_4000 = {
    Text = "このターン中、すべての敵から [Arg1] pt の<PowerIconKeywords:力>を盗む。<TransitionIconKeywords:ワープ>：計算力消費が 0 pt になる。"
  },
  Skill_147427_EffectNameList_0 = {
    Text = "力の吸収"
  },
  Skill_147427_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_147428_Name_1 = {Text = "攻撃"},
  Skill_147429_Desc = {
    Text = "暮星・ティンクトは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：暮星・ティンクトの全カードはランダムな効果を1つ獲得し、その刻印効果は戦闘終了時に除去される。"
  },
  Skill_147429_EffectNameList = {Text = "狂気"},
  Skill_147429_Name = {
    Text = "界外の音(未完成)"
  },
  Skill_147430_Name_1 = {
    Text = "復活の音"
  },
  Skill_147431_Desc_0 = {
    Text = "このターン中に[Arg1]点<PowerIconKeywords:力>を獲得。すべての手札はランダムな効果を1つ獲得し、その効果は使用後、または戦闘終了時に除去。<TransitionIconKeywords:跳躍>：ランダム効果がアップグレードされる。"
  },
  Skill_147431_Desc_6 = {
    Text = "このターン中に[Arg1]点<PowerIconKeywords:力>を獲得。すべての手札はランダムな効果を1つ獲得し、その効果は使用後、または戦闘終了時に除去。<TransitionIconKeywords:跳躍>：ランダム効果がアップグレードされる。"
  },
  Skill_147431_EffectNameList = {Text = "力"},
  Skill_147431_Name = {
    Text = "プリズムファンタジー(未完成)"
  },
  Skill_147431_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_147432_Name_1 = {
    Text = "星の極光"
  },
  Skill_147433_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。暮星·ティンクトは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_147433_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_147433_Name = {
    Text = "攻撃(未完成)"
  },
  Skill_147433_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_147434_Desc = {
    Text = "前のターンでライフを失っていない場合、このターンのクリティカル率が[Arg2]%向上。すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_147434_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_147434_EffectNameList_1000 = {
    Text = "ダメージ,追加ダメージ"
  },
  Skill_147434_Name = {
    Text = "深空反響(未完成)"
  },
  Skill_147434_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_147434_PropertyNameList_1000 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue1"
  },
  Skill_147435_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：プレースホルダー説明"
  },
  Skill_147435_Name_1 = {
    Text = "暮星・ティンクトSR（一時的テキスト）"
  },
  Skill_147436_Name_1 = {Text = "鎮魂歌"},
  Skill_147437_Desc = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得する。暮星·ティンクトは <Energy:[Energy:Arg2]> 点の狂気を獲得する。"
  },
  Skill_147437_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_147437_Name = {
    Text = "防御(未完)"
  },
  Skill_147437_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_147438_Name_1 = {
    Text = "天を衝く歌声"
  },
  Skill_147551_Desc = {
    Text = "一時的なテキスト"
  },
  Skill_147551_Name = {
    Text = "仮置きキーオーダー"
  },
  Skill_147734_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に [Arg1] <MaxHPKeywords:最大ライフ>を獲得する。ターン開始時、全体の敵に <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_147734_Name_1 = {
    Text = "暗闇から暗闇へ"
  },
  Skill_147742_BattleDesc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得するか、[Arg1] 点の一時的な<ExhaustionIconKeywords:衰弱>を獲得する。"
  },
  Skill_147742_Desc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得するか、[Arg1] 点の一時的な<ExhaustionIconKeywords:衰弱>を獲得する。"
  },
  Skill_147742_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_147743_BattleDesc = {
    Text = "上限を無視した 1000 のキーエネルギーを獲得するか、1000 点のキーエネルギーを失う。"
  },
  Skill_147743_Desc = {
    Text = "上限を無視した 1000 のキーエネルギーを獲得するか、1000 点のキーエネルギーを失う。"
  },
  Skill_147743_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_147744_BattleDesc = {
    Text = "全ての覚醒体は狂気を 20 獲得するか、狂気を 20 失う。"
  },
  Skill_147744_Desc = {
    Text = "全ての覚醒体は狂気を 20 獲得するか、狂気を 20 失う。"
  },
  Skill_147744_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_147745_BattleDesc = {
    Text = "最大ライフの 5% を回復するか、最大ライフの 5% を失う。"
  },
  Skill_147745_Desc = {
    Text = "最大ライフの 5% を回復するか、最大ライフの 5% を失う。"
  },
  Skill_147745_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_147746_BattleDesc = {
    Text = "次のターン開始時、追加で「<DerivativeCardKeywords_115:上位啓示>」を1枚獲得するか、行動力を2点失い、ドローを2枚減らす。"
  },
  Skill_147746_Desc = {
    Text = "次のターン開始時、追加で「<DerivativeCardKeywords_115:上位啓示>」を1枚獲得するか、行動力を2点失い、ドローを2枚減らす。"
  },
  Skill_147746_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_147917_Name = {
    Text = "朴直の祝福"
  },
  Skill_147918_Name = {
    Text = "真心の祝福"
  },
  Skill_147919_Name = {
    Text = "機運の祝福"
  },
  Skill_147937_Desc = {
    Text = "[Arg1]スタック数の<MonsterPainKeywords:苦痛の救済>を獲得する。以降、プレイヤーが「<DerivativeCardKeywords_158:身代わり>」を発射した際に<MonsterSinMarkKeywords:罪印>を50％しか消散させず、指令カードを1枚発射するごとに<MonsterSinMarkKeywords:罪印>を1獲得する。ターン終了後に<InvincibleUntilRoused:銀芯固化>を除去する。"
  },
  Skill_147937_Name = {
    Text = "浄化の道"
  },
  Skill_147938_Desc = {
    Text = "キーオーダーを発動するたびに、次に発射する際の行動力消費を 1 点減少させる。発射後、「聖子・白夜」の<MonsterSinMarkKeywords:罪印>スタック数を半分駆散する。"
  },
  Skill_147938_Name = {
    Text = "身代わり"
  },
  Skill_147939_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを[AttackTimes:Arg2]回与える。<PowerIconKeywords:力量>を[Arg3]スタック獲得する。"
  },
  Skill_147939_Name = {
    Text = "魂を焼き尽くす光"
  },
  Skill_147940_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを[AttackTimes:Arg2]回与える。<MonsterSinMarkKeywords:罪印>を[Arg3]スタック獲得する。"
  },
  Skill_147940_Name = {Text = "聖心"},
  Skill_147941_Desc = {
    Text = "キーオーダーを発動するたびに、次に発射する際の行動力消費を[Arg1]点低下させる。発射後に「聖子・白夜」の[Arg2]％の<MonsterSinMarkKeywords:罪印>スタック数を消散させる。"
  },
  Skill_147941_Name = {
    Text = "身代わり"
  },
  Skill_147942_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを[AttackTimes:Arg2]回与える。[Arg3]スタック数の<MonsterPainKeywords:苦痛の救済>を獲得し、[Arg4]スタック数の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_147942_Name = {
    Text = "罪なき聖裁"
  },
  Skill_147943_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。[Arg3] スタックの<MonsterPainKeywords:苦痛の救済>を蓄積し、[Arg4] スタックの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_147943_Name = {
    Text = "白夜を照らす光"
  },
  Skill_147944_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_147944_Name = {
    Text = "浄罪の審判"
  },
  Skill_148024_Desc = {
    Text = "覚醒体を1体選択し、このターン中にその覚醒体が次に狂気解放を行った際、狂気を1点消費するごとに[Arg1]点のキーエネルギーを獲得する。"
  },
  Skill_148024_Name = {
    Text = "万化の果実 - 悪魔の鍵"
  },
  Skill_148025_Desc = {
    Text = "覚醒体を1体選択し、このターン中にその覚醒体が次に狂気解放を行った際に獲得するシールドとライフ回復を[Arg1]％上昇させる。"
  },
  Skill_148025_Name = {
    Text = "万化の果実 - 公正の羽"
  },
  Skill_148026_Desc = {
    Text = "覚醒体を1体選択し、このターン中にその覚醒体の指令カードが与えるダメージに[Arg1]％の出血を付与する。"
  },
  Skill_148026_Name = {
    Text = "万化の果実 - 必滅の眼"
  },
  Skill_148027_Desc = {
    Text = "覚醒体を1体選択し、その覚醒体の行動力が最も高い[Arg1]枚の指令カードの行動力消費を[Arg2]低下させる。"
  },
  Skill_148027_Name = {
    Text = "万化の果実 - 予見の鏡"
  },
  Skill_148028_BattleDesc = {
    Text = "覚醒体を1体選択し、このターン中にその覚醒体の指令カードを[Arg1]回発射するたびに、失ったライフの[Arg2]％に等しいシールドを獲得する（[Arg3]）。消耗：次のターン開始時、「万化の果実」を1枚生成してドロー山に加える。"
  },
  Skill_148028_Desc = {
    Text = "覚醒体を1体選択し、このターン中に[Arg1]回その覚醒体の指令カードを発射するたびに、[Arg2]％の失ったライフに等しいシールドを獲得する。"
  },
  Skill_148028_Name = {
    Text = "万化の果実 – 誘惑の果実"
  },
  Skill_148029_Desc = {
    Text = "覚醒体を1体選択し、このターン中にその覚醒体が次に狂気解放を行った際に与えるダメージに[Arg1]% <CutKeywords:運命裁断>を付与する。"
  },
  Skill_148029_Name = {
    Text = "万化の果実 - 運命の糸"
  },
  Skill_148042_BattleDesc = {
    Text = "[Arg1] 枚のカードをドローする。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148042_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148042_Name = {
    Text = "朴直の祝福·ドロー"
  },
  Skill_148043_BattleDesc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148043_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148043_Name = {
    Text = "朴直の祝福·行動力"
  },
  Skill_148044_BattleDesc = {
    Text = "全ての覚醒体が <Yellow:[Arg1]> 点の固定狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148044_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148044_Name = {
    Text = "真心の祝福·狂気"
  },
  Skill_148045_BattleDesc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148045_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148045_Name = {
    Text = "真心の祝福·行動力"
  },
  Skill_148046_BattleDesc = {
    Text = "全ての覚醒体が <Yellow:[Arg1]> 点の固定狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148046_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148046_Name = {
    Text = "朴直の祝福·狂気"
  },
  Skill_148047_BattleDesc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。1層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148047_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148047_Name = {
    Text = "真心の祝福·キーエネルギー"
  },
  Skill_148048_BattleDesc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148048_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148048_Name = {
    Text = "朴直の祝福·ダメージ強化"
  },
  Skill_148049_BattleDesc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148049_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148049_Name = {
    Text = "朴直の祝福·衰弱"
  },
  Skill_148050_BattleDesc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148050_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148050_Name = {
    Text = "朴直の祝福·力"
  },
  Skill_148051_BattleDesc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148051_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148051_Name = {
    Text = "真心の祝福·力"
  },
  Skill_148052_BattleDesc = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。1層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148052_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148052_Name = {
    Text = "真心の祝福·衰弱"
  },
  Skill_148053_BattleDesc = {
    Text = "[Arg1] 枚のカードをドローする。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。1層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148053_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148053_Name = {
    Text = "真心の祝福·ドロー"
  },
  Skill_148054_BattleDesc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_148054_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148054_Name = {
    Text = "朴直の祝福·キーエネルギー"
  },
  Skill_148055_BattleDesc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。1層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148055_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_148055_Name = {
    Text = "真心の祝福·ダメージ強化"
  },
  Skill_148360_Desc = {
    Text = "このインテントに切り替えた時、敵のシールドを破壊し、そのターン中シールドを獲得できなくさせ、即座に [Arg3] スタックの<MonsterB05EXFever:狂熱>を獲得する。 ターン終了まで、自身の与えるダメージに 100%の<BleedingIconKeywords:出血>を付加する。<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。"
  },
  Skill_148360_Name = {
    Text = "束縛されし怨念"
  },
  Skill_148361_Desc = {
    Text = "このインテントに切り替えた時、敵のシールドを破壊し、そのターン中シールドを獲得できなくさせ、即座に [Arg3] スタックの<MonsterB05EXFever:狂熱>を獲得する。 ターン終了まで、自身の与えるダメージに 100%の<BleedingIconKeywords:出血>を付加する。<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与える。"
  },
  Skill_148361_Name = {
    Text = "呪縛の鎖"
  },
  Skill_148362_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを[AttackTimes:Arg2]回与え、[Arg3]％の<BleedingIconKeywords:出血>を付与し、現在のライフの[Arg4]％を失う。このインテントに切り替えた際に[Arg5]スタック数の「憎しみ」を持っている場合、インテントは<Damage:[Damage:Arg6]>点のダメージを[AttackTimes:Arg7]回与える「嗜血のチェインボール」に置き換えられる。そうでない場合は「憎しみ」を1スタック獲得する。"
  },
  Skill_148362_Name = {
    Text = "鮮血の鎖"
  },
  Skill_148364_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与え、敵の<BleedingIconKeywords:出血> 3 スタックごとにダメージが 1 上昇し、失ったライフの 30%を回復する。"
  },
  Skill_148364_Name = {
    Text = "血に狂う鉄球"
  },
  Skill_148365_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2] 回与え、[Arg3] の<PowerIconKeywords:力量>を獲得する。自身のライフが [Arg4]（50%）を下回る場合、ダメージと獲得する<PowerIconKeywords:力量>が2倍になる。"
  },
  Skill_148365_Name = {
    Text = "憎悪の奔流"
  },
  Skill_148393_Desc = {
    Text = "ターン開始時に [Arg1] スタックの<ResentChainsKeywords:怨恨の鎖>を獲得する。 インテントが「嗜血のチェインボール」に切り替わった時、敵のターン終了まで一切のダメージとライフ損失効果を免疫する。"
  },
  Skill_148393_Name = {
    Text = "復讐の誓い"
  },
  Skill_148499_Name = {
    Text = "魔法の宝箱"
  },
  Skill_148502_Name = {
    Text = "魔法の宝箱"
  },
  Skill_148506_Name = {
    Text = "魔法の宝箱"
  },
  Skill_148531_Desc = {
    Text = "覚醒体を1体選択し、その覚醒体の指令カードを1枚引いて行動力消費を0にする。その覚醒体の次の狂気解放は極限解放として扱い、すでに極限解放の場合は基礎狂気の100％を返還する。"
  },
  Skill_148531_Name = {
    Text = "万化の果実 - 永遠の冠"
  },
  Skill_149049_Desc = {
    Text = "[Arg1] スタックの<Guaiwusiwangdikang:デスレジスタンス>を獲得する。<SlowIconKeywords:遅延>状態の指令カードを全て「凍結」してその<SlowIconKeywords:遅延>効果を除去し、全ての覚醒体の狂気を <Energy:[Energy:Arg2]> 点除去する。"
  },
  Skill_149049_Name = {
    Text = "生存者の歌"
  },
  Skill_149077_Desc = {
    Text = "このインテントに切り替えた際、狂気が最も高い覚醒体から最大<Energy:[Energy:Arg1]>点の狂気を呑食し、死亡後に返還する。<Damage:[Damage:Arg2]>点のダメージを[AttackTimes:Arg3]回与え、同量の<BleedingIconKeywords:出血>を付与し、狂気が最も高い覚醒体に[Arg4]スタック数の狂気の封印を付与する。"
  },
  Skill_149077_Name = {Text = "呑食"},
  Skill_149078_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_149078_Name = {
    Text = "噛みつき"
  },
  Skill_149079_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_149079_Name = {
    Text = "噛みつき"
  },
  Skill_149080_Desc = {
    Text = "このインテントに切り替えた時、狂気が最も低い覚醒体の指令カード [Arg1] 枚を凍結し、死亡後にその覚醒体の凍結を解除する。<Damage:[Damage:Arg2]> 点のダメージを [AttackTimes:Arg3] 回与え、同量の<BleedingIconKeywords:出血>を付与し、ドロー山または捨て札の [Arg4] 枚のカードに [Arg5] スタックの<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_149080_Name = {Text = "呑食"},
  Skill_149081_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力量>を獲得し、吸収した狂気を消化する。"
  },
  Skill_149082_Desc = {
    Text = "[Arg1] スタックの<PowerIconKeywords:力量>を獲得し、対象の覚醒体の凍結されたすべての指令カードを砕いて噛みつき、それらを<DepleteIconKeywords:消耗>させる。"
  },
  Skill_149129_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層の<WeaknessIconKeywords:虚弱>を付与し、手札のカードをすべて捨てる。"
  },
  Skill_149129_Name = {Text = "離散"},
  Skill_149130_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<BloodOath_New:血の誓い>があるごとに与えるダメージが [Arg4] 上昇する。"
  },
  Skill_149130_Name = {
    Text = "新生を抱く"
  },
  Skill_149131_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [AttackTimes:Arg2]回与え、同量の<BleedingIconKeywords:出血>を付加する。"
  },
  Skill_149131_Name = {
    Text = "灯炎灼魂"
  },
  Skill_149132_Desc = {
    Text = "[Arg1] 層<PowerIconKeywords:力>を獲得する。ドロー山または捨て札の [Arg2] 枚の指令カードに [Arg3] 層<SlowIconKeywords:遅延>を付与し、敵方の各カードに [Arg4] 層<SlowIconKeywords:遅延>があるごとに、自身は [Arg5] 層<BloodOath_New:血の誓い>を獲得する。"
  },
  Skill_149132_Name = {
    Text = "聖容を映す"
  },
  Skill_149150_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<BoneHitKeywords:Scathe>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、同量の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_149150_Name = {
    Text = "永冬の意志"
  },
  Skill_149151_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、ダメージの [Arg3]％の<BoneHitKeywords:Scathe>を付与し、自身がシールドを持つ場合、付与する<BoneHitKeywords:Scathe>が2倍になる。"
  },
  Skill_149151_Name = {Text = "氷の棘"},
  Skill_149152_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<HeavyInjuryKeywords:重傷>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149152_Name = {Text = "喉切り"},
  Skill_149153_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、失ったライフの [Arg3]％を回復する。"
  },
  Skill_149153_Name = {
    Text = "吸血の噛みつき"
  },
  Skill_149175_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<BlindingKeywords:盲目>を付与し、[Arg4] 枚のランダムな症状カードを相手のドロー山にシャッフルする。"
  },
  Skill_149175_Name = {
    Text = "魂の説教"
  },
  Skill_149176_Desc = {
    Text = "手札のカードをすべて捨て、捨て札のすべての指令カードに [Arg1] 層の<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_149176_Name = {
    Text = "罪火纏縛"
  },
  Skill_149177_Desc = {
    Text = "[Arg1] 層<PowerIconKeywords:力>を獲得する。ドロー山または捨て札の [Arg2] 枚の指令カードに [Arg3] 層<SlowIconKeywords:遅延>を付与し、敵方の各カードに [Arg4] 層<SlowIconKeywords:遅延>があるごとに、自身は [Arg5] 層<BloodOath_New:血の誓い>を獲得する。"
  },
  Skill_149177_Name = {
    Text = "聖容を映す"
  },
  Skill_149178_Desc = {
    Text = "[Arg1] 層<PowerIconKeywords:力>を獲得する。ドロー山または捨て札の [Arg2] 枚の指令カードに [Arg3] 層<SlowIconKeywords:遅延>を付与し、敵方の各カードに [Arg4] 層<SlowIconKeywords:遅延>があるごとに、自身は [Arg5] 層<BloodOath_New:血の誓い>を獲得する。"
  },
  Skill_149178_Name = {
    Text = "聖容を映す"
  },
  Skill_149181_Desc = {
    Text = "前列の敵に [Arg1] の通常固定ダメージを [Arg2] 回与える。"
  },
  Skill_149181_Name = {
    Text = "固定ダメージテスト"
  },
  Skill_149182_Desc = {
    Text = "前列の敵に [Arg1] のスパイク固定ダメージを [Arg2] 回与える。"
  },
  Skill_149182_Name = {
    Text = "固定ダメージテスト"
  },
  Skill_149208_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、[Arg3]% のダメージの<BleedingIconKeywords:出血>を付与する。自身がシールドを持つ場合、付与する<BleedingIconKeywords:出血>が2倍になる。"
  },
  Skill_149208_Name = {Text = "呪刺"},
  Skill_149209_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<IntoxicationIconKeywords:毒>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、同量の<CardKeyWord:呪盾>を獲得する。"
  },
  Skill_149209_Name = {
    Text = "燃灯の意志"
  },
  Skill_149210_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<EmptinessKeywords: 虚無>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149210_Name = {Text = "喉封じ"},
  Skill_149236_Desc = {
    Text = "前列の敵に狂気解放パーセント補正–50を付与する"
  },
  Skill_149236_Name = {
    Text = "狂気解放パーセント補正テスト"
  },
  Skill_149237_Desc = {
    Text = "前列の敵に狂気解放パーセント補正+50を付与する"
  },
  Skill_149237_Name = {
    Text = "狂気解放パーセント補正テスト"
  },
  Skill_149239_Desc = {
    Text = "前列の敵に受ける指令カードダメージパーセント補正+50を付与する"
  },
  Skill_149239_Name = {
    Text = "受ける指令カードダメージパーセント補正テスト"
  },
  Skill_149248_Desc = {
    Text = "前列の敵に受ける指令カードダメージパーセント補正–50を付与する"
  },
  Skill_149248_Name = {
    Text = "受ける指令カードダメージパーセント補正テスト"
  },
  Skill_149255_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、ブロックされなかった回数ごとにすべての覚醒体の [Arg3] 狂気を除去する。"
  },
  Skill_149255_Name = {
    Text = "力溜め狩り"
  },
  Skill_149256_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、ブロックされなかったダメージの [Arg3]% の<BoneHitKeywords:Scathe>を付与する。"
  },
  Skill_149256_Name = {Text = "雪害"},
  Skill_149277_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<HeavyInjuryKeywords:重傷>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149277_Name = {Text = "喉切り"},
  Skill_149278_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<HeavyInjuryKeywords:重傷>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149278_Name = {Text = "喉切り"},
  Skill_149279_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、[Arg3]% のダメージの<BleedingIconKeywords:出血>を付与する。自身がシールドを持つ場合、付与する<BleedingIconKeywords:出血>が2倍になる。"
  },
  Skill_149279_Name = {Text = "呪刺"},
  Skill_149280_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、失ったライフの [Arg3]％を回復する。"
  },
  Skill_149280_Name = {
    Text = "吸血の噛みつき"
  },
  Skill_149281_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<EmptinessKeywords: 虚無>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149281_Name = {Text = "喉封じ"},
  Skill_149282_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<BoneHitKeywords:Scathe>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、[Arg3]％の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_149282_Name = {
    Text = "永冬の意志"
  },
  Skill_149283_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<BoneHitKeywords:Scathe>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、[Arg3]％の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_149283_Name = {
    Text = "永冬の意志"
  },
  Skill_149284_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、[Arg3]% のダメージの<BleedingIconKeywords:出血>を付与する。自身がシールドを持つ場合、付与する<BleedingIconKeywords:出血>が2倍になる。"
  },
  Skill_149284_Name = {Text = "呪刺"},
  Skill_149285_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<IntoxicationIconKeywords:毒>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、[Arg3]％の<CardKeyWord:呪盾>を獲得する。"
  },
  Skill_149285_Name = {
    Text = "燃灯の意志"
  },
  Skill_149286_Desc = {
    Text = "[Arg1] 層の<PowerIconKeywords:力>を獲得し、シールドを持つ場合は [Arg1] 層の<IntoxicationIconKeywords:毒>を付与し、そうでない場合は現在のライフの [Arg2]％を失い、[Arg3]％の<CardKeyWord:呪盾>を獲得する。"
  },
  Skill_149286_Name = {
    Text = "燃灯の意志"
  },
  Skill_149287_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、ダメージの [Arg3]％の<BoneHitKeywords:Scathe>を付与し、自身がシールドを持つ場合、付与する<BoneHitKeywords:Scathe>が2倍になる。"
  },
  Skill_149287_Name = {Text = "氷の棘"},
  Skill_149288_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 層<EmptinessKeywords: 虚無>を付与し、ガードされなかった場合 [Arg4]％のデスレジスタンスを除去する。"
  },
  Skill_149288_Name = {Text = "喉封じ"},
  Skill_149289_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、ダメージの [Arg3]％の<BoneHitKeywords:Scathe>を付与し、自身がシールドを持つ場合、付与する<BoneHitKeywords:Scathe>が2倍になる。"
  },
  Skill_149289_Name = {Text = "氷の棘"},
  Skill_149333_Desc = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得し、[Arg2] 点の<PowerIconKeywords:力>を獲得する。負誓·オジールがパーティにいる場合、負誓·オジールは [Arg3] 点の狂気を獲得し、1 スタックの<KuangNu:暗涌>を獲得する"
  },
  Skill_149333_Name = {
    Text = "永続新章"
  },
  Skill_149334_Name_1 = {
    Text = "永続新章"
  },
  Skill_149334_UnknownName = {
    Text = "永続新章"
  },
  Skill_149345_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149345_Name = {
    Text = "真心の祝福·キーエネルギー"
  },
  Skill_149346_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149346_Name = {
    Text = "真心の祝福·力"
  },
  Skill_149347_Desc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを [AttackTimes:Arg2] 回与え、[Arg3] スタックの<WeaknessIconKeywords:虚弱>を付与し、デッキ内の [Arg4] 枚の指令カードに [Arg5] スタックの<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_149347_Name = {
    Text = "粉雪の呪い"
  },
  Skill_149348_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149348_Name = {
    Text = "機運の祝福·衰弱"
  },
  Skill_149349_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149349_Name = {
    Text = "真心の祝福·衰弱"
  },
  Skill_149350_Desc = {
    Text = "すべての覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149350_Name = {
    Text = "真心の祝福·狂気"
  },
  Skill_149353_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149353_Name = {
    Text = "機運の祝福·行動力"
  },
  Skill_149354_Desc = {
    Text = "<Block:[Block:Arg4]> のフロストシールドを獲得し、[Arg5] 回の<Bleesing_Negative:秘めた悪意>効果を与える。<Blessing:贈り物>と<BlessingNegativeEffect:代償>が付いた「<DerivativeCardKeywords_161:祝福>」を [Arg1] 組発見する。各組 [Arg2] 枚で、[Arg3] 組を選んで手札に加える。"
  },
  Skill_149354_Name = {
    Text = "奇跡の祝福"
  },
  Skill_149355_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149355_Name = {
    Text = "機運の祝福·キーエネルギー"
  },
  Skill_149356_Desc = {
    Text = "すべての覚醒体が<Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149356_Name = {
    Text = "機運の祝福·狂気"
  },
  Skill_149357_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149357_Name = {
    Text = "朴直の祝福·衰弱"
  },
  Skill_149358_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149358_Name = {
    Text = "朴直の祝福·ダメージ強化"
  },
  Skill_149359_Desc = {
    Text = "[Arg1] 枚のカードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149359_Name = {
    Text = "真心の祝福·ドロー"
  },
  Skill_149360_Desc = {
    Text = "すべての覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149360_Name = {
    Text = "朴直の祝福·狂気"
  },
  Skill_149361_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149361_Name = {
    Text = "朴直の祝福·行動力"
  },
  Skill_149362_Desc = {
    Text = "<MonsterBless:贈り物>を1種と<BlessingNegativeEffect:代償>を1種獲得する。「祝福」には3種類ある：「機運の祝福」、「朴直の祝福」、「真心の祝福」。\n「機運の祝福」：「逃した好機」を発動しない。\n「朴直の祝福」：「大仰な言葉」を発動しない。\n「真心の祝福」：「秘めた悪意」を発動しない。"
  },
  Skill_149362_Name = {Text = "祝福"},
  Skill_149364_Desc = {
    Text = "「白雪の妖精」が「完璧なおとぎ話」を使用した後、次の [Arg1] 個の意図はすべて「粉雪の呪い」になる。 毎ターン、[Arg2] 枚の [Arg3] 層の<SlowIconKeywords:遅延>を持つランダムな「<DerivativeCardKeywords_161:祝福>」をデッキにシャッフルする。"
  },
  Skill_149364_Name = {
    Text = "魅惑の甘い果実"
  },
  Skill_149365_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149365_Name = {
    Text = "機運の祝福·力"
  },
  Skill_149366_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149366_Name = {
    Text = "朴直の祝福·キーエネルギー"
  },
  Skill_149367_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149367_Name = {
    Text = "真心の祝福·行動力"
  },
  Skill_149369_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149369_Name = {
    Text = "完璧なおとぎ話"
  },
  Skill_149372_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149372_Name = {
    Text = "真心の祝福·ダメージ強化"
  },
  Skill_149373_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149373_Name = {
    Text = "じゃじゃーん★妖精さん登場！"
  },
  Skill_149374_Desc = {
    Text = "[Arg1] 枚のカードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149374_Name = {
    Text = "朴直の祝福·ドロー"
  },
  Skill_149375_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149375_Name = {
    Text = "朴直の祝福·力"
  },
  Skill_149376_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149376_Name = {
    Text = "機運の祝福·ダメージ強化"
  },
  Skill_149377_Desc = {
    Text = "[Arg1] 枚カードを引く。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149377_Name = {
    Text = "機運の祝福·ドロー"
  },
  Skill_149378_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg3] 枚の [Arg4] 層の<SlowIconKeywords:遅延>を持つランダムな「<DerivativeCardKeywords_161:祝福>」をデッキにシャッフルする。"
  },
  Skill_149378_Name = {Text = "攻撃"},
  Skill_149636_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149636_Name = {
    Text = "じゃじゃーん★妖精さん登場！\n供物・行動力"
  },
  Skill_149639_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149639_Name = {
    Text = "じゃじゃーん★妖精さん登場！\n供物・シルバーキー"
  },
  Skill_149642_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149642_Name = {
    Text = "じゃじゃーん★妖精さん登場！\n供物・カード"
  },
  Skill_149643_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149643_Name = {
    Text = "じゃじゃーん★妖精さん登場！\n供物・狂気"
  },
  Skill_149644_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149644_Name = {
    Text = "完璧なおとぎ話\n供物・行動力、カード"
  },
  Skill_149645_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149645_Name = {
    Text = "完璧なおとぎ話\n供物・シルバーキー、狂気"
  },
  Skill_149646_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149646_Name = {
    Text = "完璧なおとぎ話\n供物・カード、狂気"
  },
  Skill_149647_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149647_Name = {
    Text = "完璧なおとぎ話\n供物・行動力、シルバーキー"
  },
  Skill_149648_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149648_Name = {
    Text = "完璧なおとぎ話\n供物・行動力、狂気"
  },
  Skill_149649_Desc = {
    Text = "このインテントに切り替えた時、ランダムに敵から [Arg1] 種の供物を要求する。<Damage:[Damage:Arg4]> のダメージを [AttackTimes:Arg5] 回与える。供物の捧げに成功した場合、「白雪の妖精」のライフ上限が [Arg2]% 上昇し、<MonsterB11_AFFull:飽食>を 1 層獲得する；失敗した場合、[Arg3] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_149649_Name = {
    Text = "完璧なおとぎ話\n供物・シルバーキー、カード"
  },
  Skill_149706_Desc_1 = {
    Text = "PVPの純粋ダメージを免疫し、二度目の発動で解除される。"
  },
  Skill_149706_Name_1 = {
    Text = "純粋ダメージ免疫"
  },
  Skill_149722_BattleDesc = {
    Text = "上限を無視した 1000 のキーエネルギーを獲得するか、1000 点のキーエネルギーを失う。"
  },
  Skill_149722_Desc = {
    Text = "上限を無視した 1000 のキーエネルギーを獲得するか、1000 点のキーエネルギーを失う。"
  },
  Skill_149722_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_149723_BattleDesc = {
    Text = "全ての覚醒体は狂気を 20 獲得するか、狂気を 20 失う。"
  },
  Skill_149723_Desc = {
    Text = "全ての覚醒体は狂気を 20 獲得するか、狂気を 20 失う。"
  },
  Skill_149723_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_149724_BattleDesc = {
    Text = "次のターン開始時、追加で「<DerivativeCardKeywords_115:上位啓示>」を1枚獲得するか、行動力を2点失い、ドローを2枚減らす。"
  },
  Skill_149724_Desc = {
    Text = "次のターン開始時、追加で「<DerivativeCardKeywords_115:上位啓示>」を1枚獲得するか、行動力を2点失い、ドローを2枚減らす。"
  },
  Skill_149724_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_149725_BattleDesc = {
    Text = "最大ライフの 5% を回復するか、最大ライフの 5% を失う。"
  },
  Skill_149725_Desc = {
    Text = "最大ライフの 5% を回復するか、最大ライフの 5% を失う。"
  },
  Skill_149725_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_149726_BattleDesc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得するか、[Arg1] 点の一時的な<ExhaustionIconKeywords:衰弱>を獲得する。"
  },
  Skill_149726_Desc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得するか、[Arg1] 点の一時的な<ExhaustionIconKeywords:衰弱>を獲得する。"
  },
  Skill_149726_Name = {
    Text = "ピストルチョコチョコレート"
  },
  Skill_149842_Name = {
    Text = "ScatheSkill1"
  },
  Skill_149843_Name = {
    Text = "大口Attack1"
  },
  Skill_149844_Name = {
    Text = "七大「神器」の宝光ExSkill"
  },
  Skill_149845_Name = {
    Text = "ScatheSkill2"
  },
  Skill_149846_Name = {
    Text = "深淵の刈り取りAttack2"
  },
  Skill_149847_Name = {
    Text = "永遠不滅の彩りSummon"
  },
  Skill_149901_Desc = {
    Text = "全宝物特効オフ"
  },
  Skill_149901_Name = {
    Text = "全宝物特効オフ"
  },
  Skill_149902_Name = {
    Text = "スキル@マクロファージワームウィリアムサポートカード3"
  },
  Skill_149903_Name = {
    Text = "スキル@マクロファージワームNサポートカード"
  },
  Skill_149904_Name = {
    Text = "スキル@マクロファージワームウィリアムサポートカード1"
  },
  Skill_149905_Name = {
    Text = "スキル@マクロファージワームウィリアムサポートカード2"
  },
  Skill_149906_Desc = {
    Text = "テスト特効カード取得"
  },
  Skill_149906_Name = {
    Text = "テスト特効カード取得"
  },
  Skill_149907_Desc = {
    Text = "全宝物特効オン"
  },
  Skill_149907_Name = {
    Text = "全宝物特効オン"
  },
  Skill_149959_BattleDesc = {
    Text = "[Arg1]枚カードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149959_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149959_Name = {
    Text = "朴直の祝福·ドロー"
  },
  Skill_149959_tempBattleDesc_1 = {
    Text = "[Arg2] 枚のカードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149959_tempBattleDesc_2 = {
    Text = "[Arg1] 枚のカードを引く。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149959_tempBattleDesc_3 = {
    Text = "[Arg1] 枚のカードを引く。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149960_BattleDesc = {
    Text = "[Arg1] 枚のカードを引く、注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149960_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149960_Name = {
    Text = "機運の祝福·ドロー"
  },
  Skill_149960_tempBattleDesc_1 = {
    Text = "[Arg2] 枚のカードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149960_tempBattleDesc_2 = {
    Text = "[Arg1] 枚のカードを引く。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149960_tempBattleDesc_3 = {
    Text = "[Arg1] 枚のカードを引く。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149961_BattleDesc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する、注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149961_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149961_Name = {
    Text = "朴直の祝福·キーエネルギー"
  },
  Skill_149961_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149961_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149961_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149962_BattleDesc = {
    Text = "一時的なダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149962_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149962_Name = {
    Text = "朴直の祝福·ダメージ強化"
  },
  Skill_149962_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149962_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149962_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149963_BattleDesc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149963_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149963_Name = {
    Text = "機運の祝福·行動力"
  },
  Skill_149963_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149963_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149963_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149964_BattleDesc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する、注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149964_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149964_Name = {
    Text = "朴直の祝福·力"
  },
  Skill_149964_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149964_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149964_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149965_BattleDesc = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する、注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149965_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149965_Name = {
    Text = "機運の祝福·狂気"
  },
  Skill_149965_tempBattleDesc_1 = {
    Text = "すべての覚醒体が<Yellow:[Arg2]> 点の固定狂気を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149965_tempBattleDesc_2 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149965_tempBattleDesc_3 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149966_BattleDesc = {
    Text = "[Arg1]枚カードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149966_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149966_Name = {
    Text = "真心の祝福·ドロー"
  },
  Skill_149966_tempBattleDesc_1 = {
    Text = "[Arg2] 枚のカードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149966_tempBattleDesc_2 = {
    Text = "[Arg1] 枚のカードを引く。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149966_tempBattleDesc_3 = {
    Text = "[Arg1] 枚のカードを引く。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149967_BattleDesc = {
    Text = "[Arg1] 点の行動力を獲得する、注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149967_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149967_Name = {
    Text = "朴直の祝福·行動力"
  },
  Skill_149967_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149967_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149967_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149968_BattleDesc = {
    Text = "一時的にダメージ強化 +[Arg1]％、注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149968_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149968_Name = {
    Text = "機運の祝福·ダメージ強化"
  },
  Skill_149968_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149968_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149968_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149969_BattleDesc = {
    Text = "[Arg1]ポイントの行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149969_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149969_Name = {
    Text = "真心の祝福·行動力"
  },
  Skill_149969_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149969_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149969_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149970_BattleDesc = {
    Text = "すべての覚醒体は<Yellow:[Arg1]>ポイントの固定狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149970_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149970_Name = {
    Text = "朴直の祝福·狂気"
  },
  Skill_149970_tempBattleDesc_1 = {
    Text = "すべての覚醒体が<Yellow:[Arg2]> 点の固定狂気を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149970_tempBattleDesc_2 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149970_tempBattleDesc_3 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149971_BattleDesc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる、注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149971_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149971_Name = {
    Text = "機運の祝福·衰弱"
  },
  Skill_149971_tempBattleDesc_1 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149971_tempBattleDesc_2 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149971_tempBattleDesc_3 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149972_BattleDesc = {
    Text = "<Posse:[Arg1]>ポイントのキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149972_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149972_Name = {
    Text = "真心の祝福·キーエネルギー"
  },
  Skill_149972_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149972_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149972_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149973_BattleDesc = {
    Text = "すべての覚醒体は<Yellow:[Arg1]>ポイントの固定狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149973_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149973_Name = {
    Text = "真心の祝福·狂気"
  },
  Skill_149973_tempBattleDesc_1 = {
    Text = "すべての覚醒体が<Yellow:[Arg2]> 点の固定狂気を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149973_tempBattleDesc_2 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149973_tempBattleDesc_3 = {
    Text = "すべての覚醒体が<Yellow:[Arg1]> 点の固定狂気を獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149974_BattleDesc = {
    Text = "<PowerIconKeywords:力>を[Arg1]ポイント獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149974_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149974_Name = {
    Text = "真心の祝福·力"
  },
  Skill_149974_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149974_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149974_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149975_BattleDesc = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] ポイント低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149975_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149975_Name = {
    Text = "真心の祝福·衰弱"
  },
  Skill_149975_tempBattleDesc_1 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149975_tempBattleDesc_2 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149975_tempBattleDesc_3 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149976_BattleDesc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149976_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149976_Name = {
    Text = "機運の祝福·力"
  },
  Skill_149976_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149976_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149976_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149977_BattleDesc = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] ポイント低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149977_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149977_Name = {
    Text = "朴直の祝福·衰弱"
  },
  Skill_149977_tempBattleDesc_1 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149977_tempBattleDesc_2 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149977_tempBattleDesc_3 = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149978_BattleDesc = {
    Text = "一時的なダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果を含む。<SacrificialMark1:供物>を1層獲得する。"
  },
  Skill_149978_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149978_Name = {
    Text = "真心の祝福·ダメージ強化"
  },
  Skill_149978_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が50％減少する。"
  },
  Skill_149978_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2ターン後に発動する。"
  },
  Skill_149978_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149979_BattleDesc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149979_Desc_0 = {
    Text = "<BlessingNegativeEffect:代償>を持つ<Blessing:贈り物>と 1 層の<SacrificialMark1:供物>を獲得する。"
  },
  Skill_149979_Name = {
    Text = "機運の祝福·キーエネルギー"
  },
  Skill_149979_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149979_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149979_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。自身にランダムな1種類の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149995_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_149995_Name = {
    Text = "朴直の祝福·ダメージ強化"
  },
  Skill_149995_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149995_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149995_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149996_Desc = {
    Text = "[Arg1] 枚のカードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_149996_Name = {
    Text = "真心の祝福·ドロー"
  },
  Skill_149996_tempBattleDesc_1 = {
    Text = "[Arg2] 枚カードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149996_tempBattleDesc_2 = {
    Text = "[Arg1] 枚カードを引く。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149996_tempBattleDesc_3 = {
    Text = "[Arg1] 枚カードを引き、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149997_Desc = {
    Text = "[Arg1] 枚カードを引く。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149997_Name = {
    Text = "機運の祝福·ドロー"
  },
  Skill_149997_tempBattleDesc_1 = {
    Text = "[Arg2] 枚カードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149997_tempBattleDesc_2 = {
    Text = "[Arg1] 枚カードを引く。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149997_tempBattleDesc_3 = {
    Text = "[Arg1] 枚カードを引き、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149998_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149998_Name = {
    Text = "機運の祝福·行動力"
  },
  Skill_149998_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149998_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149998_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_149999_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_149999_Name = {
    Text = "機運の祝福·衰弱"
  },
  Skill_149999_tempBattleDesc_1 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_149999_tempBattleDesc_2 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_149999_tempBattleDesc_3 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させ、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150000_Desc = {
    Text = "すべての覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150000_Name = {
    Text = "真心の祝福·狂気"
  },
  Skill_150000_tempBattleDesc_1 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得し、<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150000_tempBattleDesc_2 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150000_tempBattleDesc_3 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150001_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_150001_Name = {
    Text = "機運の祝福·ダメージ強化"
  },
  Skill_150001_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150001_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150001_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150002_Desc = {
    Text = "すべての覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150002_Name = {
    Text = "朴直の祝福·狂気"
  },
  Skill_150002_tempBattleDesc_1 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得し、<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150002_tempBattleDesc_2 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150002_tempBattleDesc_3 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150003_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150003_Name = {
    Text = "真心の祝福·行動力"
  },
  Skill_150003_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150003_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150003_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150004_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150004_Name = {
    Text = "朴直の祝福·キーエネルギー"
  },
  Skill_150004_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150004_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150004_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150005_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_150005_Name = {
    Text = "機運の祝福·力"
  },
  Skill_150005_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150005_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150005_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150006_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150006_Name = {
    Text = "朴直の祝福·衰弱"
  },
  Skill_150006_tempBattleDesc_1 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150006_tempBattleDesc_2 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150006_tempBattleDesc_3 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させ、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150007_Desc = {
    Text = "一時的にダメージ強化 +[Arg1]%。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150007_Name = {
    Text = "真心の祝福·ダメージ強化"
  },
  Skill_150007_tempBattleDesc_1 = {
    Text = "一時的にダメージ強化 +[Arg2]％。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150007_tempBattleDesc_2 = {
    Text = "一時的にダメージ強化 +[Arg1]％。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150007_tempBattleDesc_3 = {
    Text = "一時的にダメージ強化 +[Arg1]％。自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150008_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_150008_Name = {
    Text = "機運の祝福·キーエネルギー"
  },
  Skill_150008_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150008_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150008_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150009_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150009_Name = {
    Text = "真心の祝福·力"
  },
  Skill_150009_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150009_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150009_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150010_Desc = {
    Text = "すべての敵の<ExhaustionIconKeywords:力>を一時的に [Exhaustion:Arg1] 点低下させる。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150010_Name = {
    Text = "真心の祝福·衰弱"
  },
  Skill_150010_tempBattleDesc_1 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg2] 点低下させる。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150010_tempBattleDesc_2 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させる。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150010_tempBattleDesc_3 = {
    Text = "一時的にすべての敵の<ExhaustionIconKeywords:力>を [Exhaustion:Arg1] 点低下させ、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150011_Desc = {
    Text = "すべての覚醒体が<Energy:[Energy:Arg1]> 点の狂気を獲得する。注意！<Bleesing_Exaggerate:大仰な言葉>または<Bleesing_Negative:秘めた悪意>の効果を含む。"
  },
  Skill_150011_Name = {
    Text = "機運の祝福·狂気"
  },
  Skill_150011_tempBattleDesc_1 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg2]> 点の狂気を獲得し、<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150011_tempBattleDesc_2 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150011_tempBattleDesc_3 = {
    Text = "すべての覚醒体は <Energy:[Energy:Arg1]> 点の狂気を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150012_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150012_Name = {
    Text = "朴直の祝福·力"
  },
  Skill_150012_tempBattleDesc_1 = {
    Text = "[Arg2] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150012_tempBattleDesc_2 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150012_tempBattleDesc_3 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150013_Desc = {
    Text = "[Arg1] 点の行動力を獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150013_Name = {
    Text = "朴直の祝福·行動力"
  },
  Skill_150013_tempBattleDesc_1 = {
    Text = "[Arg2] 点の行動力を獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150013_tempBattleDesc_2 = {
    Text = "[Arg1] 点の行動力を獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150013_tempBattleDesc_3 = {
    Text = "[Arg1] 点の行動力を獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150014_Desc = {
    Text = "[Arg1] 枚のカードを引く。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Negative:秘めた悪意>の効果が含まれる。"
  },
  Skill_150014_Name = {
    Text = "朴直の祝福·ドロー"
  },
  Skill_150014_tempBattleDesc_1 = {
    Text = "[Arg2] 枚カードを引く。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150014_tempBattleDesc_2 = {
    Text = "[Arg1] 枚カードを引く。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150014_tempBattleDesc_3 = {
    Text = "[Arg1] 枚カードを引き、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_150015_Desc = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。注意！<Bleesing_Delay:逃した好機>または<Bleesing_Exaggerate:大仰な言葉>の効果が含まれる。"
  },
  Skill_150015_Name = {
    Text = "真心の祝福·キーエネルギー"
  },
  Skill_150015_tempBattleDesc_1 = {
    Text = "<Posse:[Arg2]> 点のキーエネルギーを獲得する。<Bleesing_Exaggerate:大仰な言葉>：効果が 50％ 減少する。"
  },
  Skill_150015_tempBattleDesc_2 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得する。<Bleesing_Delay:逃した好機>：2 ターン後に発動する。"
  },
  Skill_150015_tempBattleDesc_3 = {
    Text = "<Posse:[Arg1]> 点のキーエネルギーを獲得し、自身にランダムな 1 種の<Bleesing_Negative:秘めた悪意>効果を付与する。"
  },
  Skill_19313_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Block:[Block:Arg1]>点のシールドと<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_19313_Name_1 = {
    Text = "冬の夜の追憶"
  },
  Skill_19314_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19314_Name_1 = {Text = "攻撃"},
  Skill_19315_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン開始時、バフの<PVPWonderfulEffectKeywords:不思議な効果>を獲得。敵が毎ターン初めて「キーオーダー」を使用した時、<PVPDerivativeCardKeywords_3:「華麗な光景」>を[Arg1]枚手札に追加する。"
  },
  Skill_19315_Name_1 = {
    Text = "無声の宴"
  },
  Skill_19316_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時に <Energy:[Energy:Arg1]> の狂気を獲得する。"
  },
  Skill_19316_Name_1 = {
    Text = "アクートの春"
  },
  Skill_19320_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_19320_Name_1 = {
    Text = "死を超える"
  },
  Skill_19321_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：死亡後、次のターン開始時に自身を<PVPResurrectionKeywords:復活>させ、<Heal:[Heal:Arg1]>のHPと<Block:[Block:Arg2]>のシールドを獲得し、この「命輪」を破壊する。"
  },
  Skill_19322_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19322_Name_1 = {Text = "攻撃"},
  Skill_19323_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：手札上限 +[Arg2]。ターン終了時、手札からランダムに[Arg1]枚の「スキル」のコピーを獲得する。"
  },
  Skill_19323_Name_1 = {
    Text = "集会の時"
  },
  Skill_19324_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：毎ターン最初の[Arg2]枚の「スキル」の算力消費–[Arg1]。"
  },
  Skill_19324_Name_1 = {Text = "悟り"},
  Skill_19327_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、[Arg1]枚のカードを引く。"
  },
  Skill_19327_Name_1 = {Text = "強欲"},
  Skill_19328_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19328_Name_1 = {Text = "攻撃"},
  Skill_19329_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>させ、味方1名を<ComaKeywords:昏睡>状態にし、<Block:[Block:Arg1]> のシールドを付与する。次のターン開始時にその味方がまだ死亡状態の場合、このキーオーダーの効果を1回再発動する。"
  },
  Skill_19329_Name_1 = {
    Text = "永遠の執念"
  },
  Skill_19329_UnknownName = {
    Text = "永遠の執念"
  },
  Skill_19331_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19331_Name_1 = {Text = "攻撃"},
  Skill_19334_Desc_1 = {
    Text = "指定した味方のライフを<Heal:[Heal:Arg1]>回復する。"
  },
  Skill_19334_Name_1 = {
    Text = "注射の加護"
  },
  Skill_19334_UnknownName = {
    Text = "注射の加護"
  },
  Skill_19337_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19337_Name_1 = {Text = "攻撃"},
  Skill_19339_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19339_Name_1 = {Text = "攻撃"},
  Skill_19340_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に、お互いにすべての手札を捨てさせ、捨てた枚数+1枚のカードを引かせる。"
  },
  Skill_19340_Name_1 = {
    Text = "マジックショー"
  },
  Skill_19341_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：ターン終了時、自身が<Energy:[Energy:Arg1]> 狂気を獲得し、残りの全演算力を消費する。演算力を1消費するごとに獲得する狂気が[Arg3]増加する。"
  },
  Skill_19341_Name_1 = {
    Text = "秘められた誕生"
  },
  Skill_19342_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に自身を<ComaKeywords:昏睡>状態にする。「狂気解放」の前にすべての味方のデバフステータスを解除する。"
  },
  Skill_19342_Name_1 = {
    Text = "貴族の杖"
  },
  Skill_19343_Desc_1 = {
    Text = "他のランダムな「キーオーダー」を[Arg1]枚見て、1枚を選択して手札に追加する。"
  },
  Skill_19343_Name_1 = {
    Text = "不平等な交換"
  },
  Skill_19343_UnknownName = {
    Text = "不平等な交換"
  },
  Skill_19346_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19346_Name_1 = {Text = "攻撃"},
  Skill_19349_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時、自身を<ComaKeywords:昏睡>させる。「狂気解放」の前にすべての敵のバフ状態を解除する。"
  },
  Skill_19349_Name_1 = {Text = "錯乱"},
  Skill_19350_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：ターン開始時、自身に<PVPSeriousInjuryKeywords:痛撃>を与え、<Damage:[Damage:Arg1]> 層の<PVPCorrosionKeywords:罪印>を獲得する。ターン終了時、自身を<ReinforceKeywords:強固>にする。"
  },
  Skill_19350_Name_1 = {
    Text = "女王の戒律"
  },
  Skill_19353_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は自身のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_19353_Name_1 = {Text = "吸う"},
  Skill_19354_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：「打撃」が対象を<PVPVulnerabilityIconKeywords:被ダメージ増加>にする。装備時とターン終了時に[Arg1]層の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_19354_Name_1 = {Text = "臨界点"},
  Skill_19355_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージが[Arg1]%増加し、「打撃」で対象を選択できます。"
  },
  Skill_19355_Name_1 = {Text = "寵愛"},
  Skill_19356_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：毎ターン最初の「打撃」が追加で<Damage:[Damage:Arg1]>ダメージを与え、<PVPMethysisKeywords:中毒>にする。"
  },
  Skill_19356_Name_1 = {
    Text = "苦しみの呪縛"
  },
  Skill_19358_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19358_Name_1 = {Text = "攻撃"},
  Skill_19360_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19360_Name_1 = {Text = "攻撃"},
  Skill_19361_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、カードを[Arg1]枚引く。"
  },
  Skill_19361_Name_1 = {Text = "湧出"},
  Skill_19363_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、他の味方は<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_19363_Name_1 = {
    Text = "存在しない場所"
  },
  Skill_19364_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：「打撃」が<PVPSeriousInjuryKeywords:痛撃>を与え、ダメージが[Arg1]％上昇するが、自身はダメージの半分のライフを失う。"
  },
  Skill_19364_Name_1 = {
    Text = "疼痛の鰭"
  },
  Skill_19370_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、全ての味方に<Block:[Block:Arg1]>シールドを付与します。"
  },
  Skill_19370_Name_1 = {
    Text = "心の障壁"
  },
  Skill_19372_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージアップ [Arg1]%、「狂気解放」後に自身の<PVPPowerIconKeywords:力>+ [Arg2] となり「打撃」ダメージがさらに [Arg3]%アップ、最大100%。"
  },
  Skill_19372_Name_1 = {
    Text = "星天の獣"
  },
  Skill_19374_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択でき、対象の<Energy:[Energy:Arg1]>狂気を減少させる。"
  },
  Skill_19374_Name_1 = {
    Text = "欲望の海"
  },
  Skill_19378_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19378_Name_1 = {Text = "攻撃"},
  Skill_19379_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、最も狂気が低い味方に<Energy:[Energy:Arg1]>狂気を獲得させ、ライフ損失が最も多い味方のライフを<Heal:[Heal:Arg2]>回復。"
  },
  Skill_19379_Name_1 = {
    Text = "慈悲の育み"
  },
  Skill_19380_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19380_Name_1 = {Text = "攻撃"},
  Skill_19381_Desc_1 = {
    Text = "<PVPHoldingKeywords:保有>：カードを使用した後、このカードは他のランダムな「運命の札」に変化し、その行動力消費を-1する。"
  },
  Skill_19381_Name_1 = {
    Text = "魂の誕生"
  },
  Skill_19383_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：我が方の覚醒体が死亡したとき、全ての敵に <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>を与える。装備者が死亡した場合、追加で <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_19383_Name_1 = {
    Text = "珊瑚の女の死"
  },
  Skill_19384_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」後、「スキル」を[Arg1]枚引き、そのコピーを手札に[Arg2]枚追加する。"
  },
  Skill_19384_Name_1 = {
    Text = "幸運の時"
  },
  Skill_19387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、行動力を[Arg1]獲得し、<DelayKeywords:レイテンシ>：行動力を[Arg2]消費する。"
  },
  Skill_19387_Name_1 = {
    Text = "記憶障害"
  },
  Skill_19388_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備時に <Energy:[Energy:Arg1]> 狂気を獲得する。味方の覚醒体が「狂気爆発」を発動した後、自身が<DelayKeywords:遅延>：<Energy:[Energy:Arg2]> 狂気を獲得する。"
  },
  Skill_19388_Name_1 = {
    Text = "神王の讃歌"
  },
  Skill_19389_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：このカードを対象が装備している「運命の札」に変化させる。対象が「運命の札」を装備していない場合、「幻視」を[Arg1]枚獲得し、消費した行動力が返還される。"
  },
  Skill_19389_Name_1 = {
    Text = "旅の荷物"
  },
  Skill_19391_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19391_Name_1 = {Text = "攻撃"},
  Skill_19393_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「打撃」のダメージが[Arg1]%上昇し、自身を<ReinforceKeywords:堅固>にする。"
  },
  Skill_19393_Name_1 = {
    Text = "不屈の意志"
  },
  Skill_19394_Desc_1 = {
    Text = "カードを[Arg1]枚引き、[Arg2]点の行動力を獲得。"
  },
  Skill_19394_Name_1 = {Text = "後の先"},
  Skill_19400_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後に<HPAndShieldMin:ライフとシールドが最も低い>味方に [Arg1] スタックの<PVPProtectiveKeywords:バリア>を付与する。"
  },
  Skill_19400_Name_1 = {Text = "親友へ"},
  Skill_19401_Desc_1 = {
    Text = "行動力を[Arg1]獲得し、<DelayKeywords:レイテンシ>：行動力を[Arg2]消費する。"
  },
  Skill_19401_Name_1 = {
    Text = "鼠の知恵"
  },
  Skill_19401_UnknownName = {
    Text = "鼠の知恵"
  },
  Skill_19402_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身が<PVPProtectiveKeywords:バリア>を持っていない場合は[Arg1]点の<PVPProtectiveKeywords:バリア>を獲得し、そうでない場合は手札の自身の行動力消費が最も高い1枚の「スキル」の行動力消費を-1する。"
  },
  Skill_19402_Name_1 = {
    Text = "神言の石板"
  },
  Skill_19403_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[Arg1]。"
  },
  Skill_19403_Name_1 = {
    Text = "記憶螺旋"
  },
  Skill_19406_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：「狂気爆発」後、敵全体に<Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_19406_Name_1 = {
    Text = "迷いの道"
  },
  Skill_19409_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象1体に攻撃するごとに[Arg1]点の行動力を獲得。"
  },
  Skill_19409_Name_1 = {
    Text = "縛られた歌"
  },
  Skill_19411_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」が与えるダメージ、治癒、シールドが[Arg1]%増加する。「スキル」使用後、<PVPProtectiveKeywords:バリア>がない場合、1点の<PVPProtectiveKeywords:バリア>を獲得。"
  },
  Skill_19411_Name_1 = {
    Text = "詩の結び"
  },
  Skill_19412_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」は自身を<ReinforceKeywords:堅固>にする。"
  },
  Skill_19412_Name_1 = {
    Text = "騎士の心"
  },
  Skill_19413_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19413_Name_1 = {Text = "攻撃"},
  Skill_19414_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：自身がデバフ状態を解除する時、解除可能なデバフ状態がない場合はライフを<Heal:[Heal:Arg1]>回復。ターン終了時、<DelayKeywords:遅延>：自身のデバフ状態を解除。"
  },
  Skill_19414_Name_1 = {
    Text = "導きの帆"
  },
  Skill_19415_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：「狂気爆発」によるダメージ、回復、シールド効果が[Arg1]％上昇する。"
  },
  Skill_19415_Name_1 = {
    Text = "薔薇の名において"
  },
  Skill_19418_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前にすべての味方に<StrengthenKeywords:強化>を付与する。"
  },
  Skill_19418_Name_1 = {
    Text = "信仰の力"
  },
  Skill_19419_Desc_1 = {
    Text = "味方1体に<Energy:[Energy:Arg1]>狂気を付与する。"
  },
  Skill_19419_Name_1 = {Text = "幻影"},
  Skill_19420_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<PVPDerivativeCardKeywords_11:「不平等な交換」>を[Arg1]枚山札のランダムな位置に追加する。"
  },
  Skill_19420_Name_1 = {
    Text = "情報は命"
  },
  Skill_19421_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に、自身に<StrengthenKeywords:強化>と<ReinforceKeywords:堅固>を付与する。"
  },
  Skill_19421_Name_1 = {
    Text = "痛みを越えて"
  },
  Skill_19422_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19422_Name_1 = {Text = "攻撃"},
  Skill_19424_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19424_Name_1 = {Text = "攻撃"},
  Skill_19425_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19425_Name_1 = {Text = "攻撃"},
  Skill_19426_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_19426_Name_1 = {Text = "庇護"},
  Skill_19430_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン初めて敵からの攻撃を受けた後、その敵に[Arg1]ダメージを与え、<PVPEntanglementKeywords:纏着>を付与する。"
  },
  Skill_19430_Name_1 = {
    Text = "蒼白の末裔"
  },
  Skill_19431_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：装備時とターン開始時、敵全体に<Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>を与え、対象の手札1枚につき追加で[Arg2] <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_19431_Name_1 = {
    Text = "血肉の宴"
  },
  Skill_19432_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19432_Name_1 = {Text = "攻撃"},
  Skill_19433_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に自身に[Arg2]のダメージを与え、<PVPEntanglementKeywords:纏着>。死亡した味方1体につき、<StrongEffectKeywords:特効>+[Arg1]。"
  },
  Skill_19433_Name_1 = {
    Text = "至高の秘蔵品"
  },
  Skill_19437_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」ダメージが[Arg1]%増加します。攻撃を受けるたびに、[Arg2]層<EnergyStorageKeywords:蓄力>を獲得します。"
  },
  Skill_19438_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、[Arg1]点の一時的な<PVPRetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_19438_Name_1 = {Text = "核溶解"},
  Skill_19439_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19439_Name_1 = {Text = "攻撃"},
  Skill_19444_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、装備者は<HPAndShieldMax:ライフとシールドが最も高い>敵に [Arg1] ダメージを与え、<PVPMethysisKeywords:毒>を付与する。"
  },
  Skill_19444_Name_1 = {
    Text = "腐朽の贈り物"
  },
  Skill_19446_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の前に自身のデバフ状態を解除し、[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_19446_Name_1 = {
    Text = "鎖を断ち切る日"
  },
  Skill_19448_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：毎ターン、相手が第[Arg1]枚の「スキル」を使用すると、その行動力消費を-[Arg2]したコピーを手札に追加。"
  },
  Skill_19448_Name_1 = {Text = "洞察"},
  Skill_19449_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19449_Name_1 = {Text = "攻撃"},
  Skill_19451_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：毎ターン最初に使用した装備者の「スキル」のダメージが[Arg1]％上昇する。"
  },
  Skill_19451_Name_1 = {
    Text = "巨人の刃"
  },
  Skill_19452_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19452_Name_1 = {Text = "攻撃"},
  Skill_19453_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、<PVPDerivativeCardKeywords_2:「幻象」>を1枚獲得する。手札に<PVPDerivativeCardKeywords_2:「幻象」>が2枚ある時、それらを<PVPDerivativeCardKeywords_12:「小さな願い」>1枚に合成する。"
  },
  Skill_19455_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者が毎ターン初めて「スキル」を使用した後に、その行動力消費が-[Arg1]されたコピーを1枚山札のランダムな位置に追加する。"
  },
  Skill_19455_Name_1 = {
    Text = "回れ回れ"
  },
  Skill_19456_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」「スキル」「狂気解放」が与えるダメージ、治癒、シールドは[Arg3]%増加し、[Arg2]%の<PVPGrowthKeywords:成長>を獲得する。"
  },
  Skill_19456_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」「スキル」「狂気解放」によるダメージ・回復・シールドの増加が [Arg1]%アップ、<PVPGrowthKeywords:成長> [Arg2]%。"
  },
  Skill_19456_Name_1 = {Text = "落日"},
  Skill_19457_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は自身に<Energy:[Energy:Arg1]>狂気を獲得させる。"
  },
  Skill_19458_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打撃」で<HPAndShieldMax:ライフとシールドが最も高い>敵を攻撃し、さらにダメージの [Arg1]% の<PVPBleedingKeywords:出血>を追加で与える。"
  },
  Skill_19458_Name_1 = {
    Text = "切断と危害"
  },
  Skill_19460_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択でき、[Arg1]点の<PVPSlowKeywords:遅延>を与える。毎ターン最初の対象に発動する際、効果は2倍になる。"
  },
  Skill_19460_Name_1 = {
    Text = "忘却の手"
  },
  Skill_19463_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19463_Name_1 = {Text = "攻撃"},
  Skill_19465_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_19465_Name_1 = {Text = "攻撃"},
  Skill_19466_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Block:[Block:Arg1]>点のシールドを獲得し、他の味方に<Energy:[Energy:Arg2]>狂気を付与する。"
  },
  Skill_19466_Name_1 = {
    Text = "計算不能な演算"
  },
  Skill_19467_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ライフを失うことで獲得する狂気が2倍になる。"
  },
  Skill_19467_Name_1 = {Text = "海の夢"},
  Skill_19468_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、手札の中で行動力消費が最も高いカード1枚の、消費行動力を-[Arg1]する。"
  },
  Skill_19468_Name_1 = {
    Text = "精神集中"
  },
  Skill_19470_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_19470_Name_1 = {
    Text = "奇体の反噬"
  },
  Skill_19471_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_19471_Name_1 = {Text = "追放"},
  Skill_19473_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」使用時およびターン終了時、ライフ損失が最も多い味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_19473_Name_1 = {Text = "希望"},
  Skill_19475_Desc_1 = {
    Text = "すべての手札を捨て、同数のカードを引く。手札が空の場合、ランダムな「キーオーダー」を[Arg1]枚獲得する。"
  },
  Skill_19475_Name_1 = {
    Text = "純白の出会い"
  },
  Skill_19475_UnknownName = {
    Text = "純白の出会い"
  },
  Skill_19477_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」使用時およびターン終了時、自身は<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_19477_Name_1 = {Text = "呟き"},
  Skill_19479_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、前のターンに最後に使用した「スキル」を手札に追加し、その行動力消費を-1にする。この効果が複数回発動した場合、さらに前のターンへと遡る。"
  },
  Skill_19479_Name_1 = {
    Text = "時を遡る時計"
  },
  Skill_19483_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、<PVPDerivativeCardKeywords_11:「不平等な交換」>を[Arg1]枚手札に追加する。"
  },
  Skill_19483_Name_1 = {
    Text = "暴風雨の中で"
  },
  Skill_19484_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、他の味方に<Energy:[Energy:Arg1]>狂気を付与する。この効果で付与された狂気の余剰は装備者に半分返還される。"
  },
  Skill_19484_Name_1 = {Text = "職責"},
  Skill_19486_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：死亡後、他の味方に[Arg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  Skill_19486_Name_1 = {
    Text = "死の分析"
  },
  Skill_19487_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、<PVPCapKeywords:行動力上限>1点ごとに<HPAndShieldMin:ライフとシールドが最も低い>敵に [Arg1] <PVPBleedingKeywords:出血>を与え、合計 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>ダメージを与える。"
  },
  Skill_19487_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、<PVPCapKeywords:行動力上限>1点ごとに<HPAndShieldMin:ライフとシールドが最も低い>敵に [Arg1] <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_19487_Name_1 = {
    Text = "夜に伏す"
  },
  Skill_19489_Desc_1 = {
    Text = "味方1体に<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_19489_Name_1 = {
    Text = "小さな願い"
  },
  Skill_19489_UnknownName = {
    Text = "小さな願い"
  },
  Skill_19493_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」のダメージが[Arg1]%増加する。「狂気解放」の後、自身のライフを<Heal:[Heal:Arg2]>回復。"
  },
  Skill_19493_Name_1 = {
    Text = "捕食者の子守唄"
  },
  Skill_19495_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後<DelayKeywords:遅延>：すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_19495_Name_1 = {
    Text = "暴食寓話"
  },
  Skill_19497_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」後、全ての敵に[Arg1]ダメージを与え、<DisarmKeywords:麻痺>を付与します。"
  },
  Skill_19497_Name_1 = {Text = "懲罰"},
  Skill_19499_Desc_1 = {
    Text = "すべての味方に<Block:[Block:Arg1]>点のシールドを与える。"
  },
  Skill_19499_Name_1 = {
    Text = "頭の中の音"
  },
  Skill_19499_UnknownName = {
    Text = "頭の中の音"
  },
  Skill_20075_Desc = {
    Text = "前列の敵をノックバックさせる。"
  },
  Skill_20075_Name = {
    Text = "位相変換"
  },
  Skill_20841_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_20841_Name = {
    Text = "沸け！血よ"
  },
  Skill_20842_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_20842_Name = {
    Text = "血と砂の歌"
  },
  Skill_20843_Desc = {
    Text = "[Arg1]点のシールドを獲得し、[Arg2]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_20843_Name = {
    Text = "叫べ！血よ"
  },
  Skill_20844_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_20850_Desc = {
    Text = "「深紅の刃」の行動1回分を、脅威の低い、単発攻撃に歪曲させる。"
  },
  Skill_20850_Name = {
    Text = "契約の残響"
  },
  Skill_20974_Desc = {
    Text = "この行動は誓約反響で歪曲できない。「血の狂暴・終結」状態を獲得し、一定のライフを失うと非常に高いダメージの狂気解放を発動。"
  },
  Skill_20974_Name = {Text = "覚醒"},
  Skill_20975_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得し、「融蝕」を2枚山札のランダムな位置に追加する。"
  },
  Skill_20975_Name = {
    Text = "血と砂の歌・狂"
  },
  Skill_21308_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。攻撃を1回受けるごとに攻撃回数が1回減少、最低3回。"
  },
  Skill_21308_Name = {
    Text = "血怒連撃(弱点)"
  },
  Skill_21313_Desc_1 = {
    Text = "対象1体に<PVPVulnerabilityIconKeywords:軟化>を付与する。"
  },
  Skill_21313_Name_1 = {Text = "軟化"},
  Skill_21314_Desc_1 = {
    Text = "対象1体に<StrengthenKeywords:強化>を付与する。"
  },
  Skill_21314_Name_1 = {Text = "強化"},
  Skill_21315_Desc_1 = {
    Text = "対象1体に<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_21316_Desc_1 = {
    Text = "対象1体に<ReinforceKeywords:堅固>を付与する。"
  },
  Skill_21316_Name_1 = {Text = "堅固"},
  Skill_21320_Desc_1 = {
    Text = "すべてのカードを捨てる。"
  },
  Skill_21320_Name_1 = {
    Text = "すべての手札を捨てる"
  },
  Skill_21321_Desc_1 = {
    Text = "テストコマンドを実行。"
  },
  Skill_21321_Name_1 = {
    Text = "テスト指令"
  },
  Skill_21330_Desc_1 = {
    Text = "対象1体に<Damage:[Damage:Arg1]>ダメージと同量の<PVPMethysisKeywords:毒>を与える。"
  },
  Skill_21330_Name_1 = {Text = "毒"},
  Skill_21332_Desc_1 = {
    Text = "[Arg1]ダメージを与え、<ComaKeywords:昏睡>させる。"
  },
  Skill_21332_Name_1 = {Text = "混乱"},
  Skill_21333_Desc_1 = {
    Text = "対象1体のバフ効果を解除する。"
  },
  Skill_21333_Name_1 = {
    Text = "バフを解除"
  },
  Skill_21334_Desc_1 = {
    Text = "対象1体に<TauntKeywords:挑発>を付与する。"
  },
  Skill_21334_Name_1 = {Text = "挑発"},
  Skill_21336_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：<Energy:[Energy:Arg1]>狂気を獲得、を付与する。"
  },
  Skill_21336_Name_1 = {
    Text = "遅延狂気"
  },
  Skill_21337_Desc_1 = {
    Text = "対象1体に[Arg1]点の一時的な<StrengthenKeywords:反撃>を付与する。"
  },
  Skill_21337_Name_1 = {Text = "反撃"},
  Skill_21338_Desc_1 = {
    Text = "対象1体に<Energy:[Energy:Arg1]>狂気を付与する。"
  },
  Skill_21338_Name_1 = {Text = "狂気"},
  Skill_21339_Desc_1 = {
    Text = "対象1体のデバフ効果を解除する。"
  },
  Skill_21339_Name_1 = {
    Text = "デバフを解除"
  },
  Skill_21341_Desc_1 = {
    Text = "対象1体に<StrengthenKeywords:シールド>を付与する。"
  },
  Skill_21341_Name_1 = {
    Text = "シールド"
  },
  Skill_21355_Desc_1 = {
    Text = "対象1体に[Arg1]点の<StrengthenKeywords:遅延>を付与する。"
  },
  Skill_21355_Name_1 = {Text = "鈍化"},
  Skill_21356_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：カードを[Arg1]枚引く、を付与する。"
  },
  Skill_21356_Name_1 = {
    Text = "遅延ドロー"
  },
  Skill_21357_Desc_1 = {
    Text = "対象1体から<Energy:[Energy:Arg1]>狂気を失わせる。"
  },
  Skill_21357_Name_1 = {
    Text = "狂気減少"
  },
  Skill_21361_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：ライフを<Heal:[Heal:Arg1]>回復、を付与する。"
  },
  Skill_21361_Name_1 = {
    Text = "遅延治癒"
  },
  Skill_21362_Desc_1 = {
    Text = "対象を1体<PVPResurrectionKeywords:復活>させ、 <Heal:[Heal:Arg1]>ライフを獲得。"
  },
  Skill_21362_Name_1 = {Text = "復活"},
  Skill_21379_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_21403_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_21582_BattleDesc_1 = {
    Text = "すべてのカードを捨て、対象の山札を生成し、行動力を50点にし、1狂気を獲得。"
  },
  Skill_21582_Desc_1 = {
    Text = "すべてのカードを捨て、対象の山札を生成し、行動力を50点にし、1狂気を獲得。100回使用可能。"
  },
  Skill_21582_Name_1 = {
    Text = "山札作成"
  },
  Skill_21602_Desc_1 = {
    Text = "対象1体に[Arg1]点の<EnergyStorageColour:蓄力>を付与する。"
  },
  Skill_21603_Desc_1 = {
    Text = "対象1体に[Arg1]点の<PowerColourKeywords:力>を付与する。"
  },
  Skill_21603_Name_1 = {Text = "力"},
  Skill_21615_AwakerSkillBackgroundStory = {
    Text = "オジールの記憶は融蝕現象で断片化している。\n彼は舞踏会の笑い声を覚えているが、主役の名前を忘れている\n彼は騎士団での訓練を覚えているが、大公がなぜ幼い彼を騎士にしたのかは知らない\n彼は重装騎兵の下で命を落としたことを覚えているが、守っていた笑顔がどんなものだったかは思い出せない。\n誰も彼を責めることはできない、彼は騎士としてのすべての責務を果たした——守る意志のために命を捧げることも含めて。"
  },
  Skill_21615_Desc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>状態を解除する。<Block:[Block:Arg1]>点のシールドを獲得する。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_21615_Desc_2 = {
    Text = "自身の<FragileIconKeywords:脆弱>を解除し、<Block:[Block:Arg3]>点のシールドを獲得。<Block:[Block:Arg1]>点のシールドを獲得。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_21615_EffectNameList_0 = {
    Text = "シールド,力"
  },
  Skill_21615_EffectNameList_2 = {
    Text = "デバフ解除のシールド,シールド,力"
  },
  Skill_21615_Name = {
    Text = "七つの技、継承した美徳"
  },
  Skill_21615_OverLimitUtlSkillDesc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>ステータスを解除する。<Block:[Block:Arg1]> 点シールドを獲得する。[Power:Arg2] 点の一時的な<PowerIconKeywords:力>を獲得する。獲得するシールドが200%増加する。オジールが与えるダメージ回数+1、3ターン持続する。"
  },
  Skill_21615_OverLimitUtlSkillDesc_2 = {
    Text = "自身の<FragileIconKeywords:脆弱>を解除し、<Block:[Block:Arg3]>点のシールドを獲得。<Block:[Block:Arg1]>点のシールドを獲得。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。獲得するシールドが200%増加する。オジールのダメージ回数+1、3ターン持続。"
  },
  Skill_21615_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_21615_PropertyNameList_2 = {
    Text = "防御力×GrowValue3,防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_21620_AwakerSkillBackgroundStory = {
    Text = "理性は彼女の視点を決め、真理は彼女の思考を広げ、現実は彼女の道徳を縛った。\nこの天才にとって、科学もまた哲学である。"
  },
  Skill_21620_Desc_0 = {
    Text = "自身の<VulnerabilityIconKeywords:易傷>状態を解除する。<Heal:[Heal:Arg1]>ライフを回復し、他の覚醒体は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_21620_Desc_3 = {
    Text = "自身の<VulnerabilityIconKeywords:易傷>を解除。ライフを<Heal:[Heal:Arg1]>回復し、すべての覚醒体は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_21620_EffectNameList_0 = {
    Text = "回復,狂気"
  },
  Skill_21620_EffectNameList_7 = {
    Text = "回復,狂気,毎ターン回復"
  },
  Skill_21620_Name = {
    Text = "理性、真理と現実"
  },
  Skill_21620_OverLimitUtlSkillDesc_0 = {
    Text = "自身の<VulnerabilityIconKeywords:易傷>状態を駆散する。<Heal:[Heal:Arg1]> 点のライフを回復し、他の覚醒体は <Energy:[Energy:Arg2]> 点の狂気を得る。ターン開始時に <Heal:[Heal:Arg3]> 点のライフを回復し、3ターン持続する。"
  },
  Skill_21620_OverLimitUtlSkillDesc_3 = {
    Text = "自身の<VulnerabilityIconKeywords:易傷>状態を解除する。<Heal:[Heal:Arg1]>ライフを回復し、すべての覚醒体は<Energy:[Energy:Arg2]>狂気を獲得。ターン開始時に<Heal:[Heal:Arg3]>ライフを回復、3ターン持続。"
  },
  Skill_21620_PropertyNameList_0 = {
    Text = "体力×GrowValue1,$GrowValue2"
  },
  Skill_21620_PropertyNameList_7 = {
    Text = "体力×GrowValue1,$GrowValue2,体力×GrowValue3"
  },
  Skill_21663_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得する。覚醒後、毎ターン<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>状態を3点解除する。"
  },
  Skill_21663_Name = {
    Text = "戦欲抑え難し"
  },
  Skill_21668_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_21672_Desc_1 = {
    Text = "すべての敵に30ダメージを与える。"
  },
  Skill_21672_Name_1 = {
    Text = "広範囲ダメージ"
  },
  Skill_21721_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、全体が[Arg3]点のシールドを獲得し、<DerivativeCardKeywords_26:「症状：妄想」>を2枚山札のランダムな位置に追加する。"
  },
  Skill_21721_Name = {
    Text = "隠密奇襲"
  },
  Skill_21783_Desc_1 = {
    Text = "対象1体を撃破する。"
  },
  Skill_21783_Name_1 = {Text = "撃破"},
  Skill_21837_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_21837_Name = {
    Text = "噛みつく"
  },
  Skill_21902_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！！！"
  },
  Skill_21939_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_21940_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点失い、ターン終了時にすべて失う。"
  },
  Skill_21940_Name = {Text = "祈り"},
  Skill_21948_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、ターン終了時にすべて失う。"
  },
  Skill_21948_Name = {Text = "祈り"},
  Skill_21949_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_22056_Desc = {
    Text = "[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_22056_Name = {
    Text = "復讐宣言"
  },
  Skill_22152_Desc = {
    Text = "<Block:[Block:Arg1]>点の<CardKeyWord:フロストシールド>を獲得し、プレイヤーに[Arg2]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_22152_Name = {
    Text = "深海の呼び声"
  },
  Skill_22153_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22154_Desc = {
    Text = "自身が死亡し、ライフが自身と同等の「海中のもの」2体に分裂する。"
  },
  Skill_22155_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。次のターン開始時に[Arg3]枚の<DerivativeCardKeywords_80:「窒息」>を手札に追加。"
  },
  Skill_22156_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22162_Desc = {
    Text = "<Block:[Block:Arg1]>点の<CardKeyWord:フロストシールド>を獲得し、プレイヤーに[Arg2]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_22162_Name = {
    Text = "深海の呼び声"
  },
  Skill_22196_Desc = {
    Text = "<Block:[Block:Arg1]>点の<CardKeyWord:フロストシールド>を獲得し、プレイヤーに[Arg2]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_22196_Name = {
    Text = "深海の呼び声"
  },
  Skill_22197_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22198_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。次のターンに[Arg3]枚の<DerivativeCardKeywords_80:「窒息」>を獲得。"
  },
  Skill_22199_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22209_Desc_1 = {
    Text = "相手が指令カードと攻撃を出せないようにする。"
  },
  Skill_22209_Name_1 = {
    Text = "超絶鈍化"
  },
  Skill_22212_Desc_1 = {
    Text = "対象1体に[Arg1]点の<EnergyStorageColour:死闘>を付与する。"
  },
  Skill_22212_Name_1 = {Text = "死闘"},
  Skill_22218_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札の上[Arg3]枚のカードに[Arg4]点の鈍化を付与する。"
  },
  Skill_22218_Name = {
    Text = "寒気攻撃"
  },
  Skill_22233_Desc = {
    Text = "「次元干渉型融蝕生物」に進化する。現在のライフが高いほど進化後の敵はより強くなる。"
  },
  Skill_22233_Name = {
    Text = "融蝕の進化"
  },
  Skill_22234_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_45:「次元閉鎖」>を1枚プレイヤーの手札に追加する。"
  },
  Skill_22234_Name = {
    Text = "次元の封鎖"
  },
  Skill_22306_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_22306_Name = {
    Text = "氷の盾攻撃"
  },
  Skill_22316_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーのランダムな[Arg3]枚のカードに<CardKeyWord:「怒涛の印」>を付与する。「怒涛の印」：この印のあるカードを使用すると、このターンの敵の攻撃回数が+1される。「怒涛の印」は使用後に除去される。"
  },
  Skill_22316_Name = {
    Text = "怒涛の牽引"
  },
  Skill_22317_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、このターン攻撃を1回受けるたび、[Arg3]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_22317_Name = {
    Text = "巨刃の斬撃"
  },
  Skill_22318_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の寄生を付与する。"
  },
  Skill_22318_Name = {Text = "骨侵食"},
  Skill_22319_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_22319_Name = {Text = "深淵"},
  Skill_22320_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22320_Name = {Text = "斬る"},
  Skill_22331_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_22332_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_22333_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<CardKeyWord:外傷>を付与する。<CardKeyWord:外傷>：「攻撃」使用後、山札の上に<DerivativeCardKeywords_23:「傷口」>を2枚追加する。"
  },
  Skill_22333_Name = {
    Text = "外傷重撃"
  },
  Skill_22344_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_22345_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<CardKeyWord:外傷>を付与する。<CardKeyWord:外傷>：「攻撃」使用後、山札の上に<DerivativeCardKeywords_23:「傷口」>を2枚追加する。"
  },
  Skill_22345_Name = {
    Text = "外傷猛撃"
  },
  Skill_22346_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_22698_Desc_1 = {
    Text = "ランダムで1～[Arg1]枚の<PVPDerivativeCardKeywords_2:「幻視」>を山札に追加。"
  },
  Skill_22698_Name_1 = {
    Text = "幻視の山札追加"
  },
  Skill_22700_Desc = {
    Text = "[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_22700_Name = {
    Text = "次元の霧"
  },
  Skill_23407_Desc = {
    Text = "[Arg1]点のシールドと、現在の<RetaliateIconKeywords:反撃>に等しい一時的な<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_23407_Name = {
    Text = "逆鱗の守り"
  },
  Skill_23408_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23409_Desc = {
    Text = "現在の<RetaliateIconKeywords:反撃>に等しい<PowerIconKeywords:力>を獲得。その後、毎ターン[Arg1]点の反撃も獲得。"
  },
  Skill_23409_Name = {
    Text = "変身する体"
  },
  Skill_23410_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_23410_Name = {
    Text = "破砕の沈戟"
  },
  Skill_23411_Desc = {
    Text = "[Arg2]点のシールドと[Arg1]点の再生力を獲得。再生力：ターン終了時に点数に等しいライフを回復し、ライフを5点失うごとに1点減少。"
  },
  Skill_23411_Name = {
    Text = "異端の継承"
  },
  Skill_23467_Desc = {
    Text = "3つの行動から2つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23467_Name = {
    Text = "千変万化・実"
  },
  Skill_23468_Desc = {
    Text = "3つの行動から2つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23468_Name = {
    Text = "千変万化・実"
  },
  Skill_23469_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「症状：錯乱」と「症状：盲従」を山札のランダムな位置に追加する。"
  },
  Skill_23469_Name = {
    Text = "連撃+症状"
  },
  Skill_23470_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_23470_Name = {
    Text = "連撃+出血"
  },
  Skill_23471_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての覚醒体から[Arg3]狂気を減少する。"
  },
  Skill_23471_Name = {
    Text = "連撃+狂気減少"
  },
  Skill_23472_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。敵の<PowerIconKeywords:力>を[Arg3]点減少させる。"
  },
  Skill_23472_Name = {
    Text = "ダメージ+力の減少"
  },
  Skill_23473_Desc = {
    Text = "「症状：錯乱」と「症状：盲従」を山札のランダムな位置に追加する。"
  },
  Skill_23473_Name = {
    Text = "VL-13号フィルム"
  },
  Skill_23474_Desc = {
    Text = "すべての覚醒体から[Arg1]狂気を減少する。"
  },
  Skill_23474_Name = {
    Text = "VL-9号フィルム"
  },
  Skill_23475_Desc = {
    Text = "攻撃に[Arg1]点の<BleedingIconKeywords:出血>の付与を追加する。"
  },
  Skill_23475_Name = {
    Text = "VL-7号フィルム"
  },
  Skill_23476_Desc = {
    Text = "[Arg1]点の力の減少を追加する。"
  },
  Skill_23476_Name = {
    Text = "光り輝く頭"
  },
  Skill_23477_Desc = {
    Text = "攻撃が1回増加する。"
  },
  Skill_23477_Name = {
    Text = "騒がしい頭"
  },
  Skill_23478_Desc = {
    Text = "2点の易傷を付与する。"
  },
  Skill_23478_Name = {
    Text = "咆哮する頭"
  },
  Skill_23479_Desc = {
    Text = "[Arg1]点のシールドを獲得。"
  },
  Skill_23480_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23481_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、それぞれ1枚の<DerivativeCardKeywords_45:「次元閉鎖」>をプレイヤーの山札と捨て札に追加する。"
  },
  Skill_23481_Name = {
    Text = "根源の海"
  },
  Skill_23482_Desc = {
    Text = "[Arg1]点のシールドを獲得。"
  },
  Skill_23483_Desc = {
    Text = "「千変万化」の効果を強化：2回の行動選択をする必要がある。カードを捨てた場合、すべての覚醒体が20狂気を失い、「症状」を5枚プレイヤーの山札に追加する。"
  },
  Skill_23483_Name = {
    Text = "次元の投影"
  },
  Skill_23484_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_23484_Name = {
    Text = "シールド+ダメージ"
  },
  Skill_23485_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<BleedingIconKeywords:出血>を付与し、「症状：錯乱」を2枚挿入する。"
  },
  Skill_23485_Name = {
    Text = "連撃+出血+症状"
  },
  Skill_23486_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、すべての覚醒体から[Arg3]狂気を減少し、「症状：錯乱」を2枚挿入する。"
  },
  Skill_23486_Name = {
    Text = "連撃+狂気減少+症状"
  },
  Skill_23487_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23488_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23489_Desc = {
    Text = "3つの行動から2つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23489_Name = {
    Text = "千変万化・実"
  },
  Skill_23490_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_23490_Name = {
    Text = "首切りの一撃"
  },
  Skill_23491_Desc = {
    Text = "[Arg1]点のシールドを獲得し、[Arg2]点の力を増加する。"
  },
  Skill_23491_Name = {
    Text = "シールド+力"
  },
  Skill_23492_Desc = {
    Text = "[Arg1]点のシールドを獲得し、ダフォダイルのすべてのデバフ状態を解除する。"
  },
  Skill_23492_Name = {
    Text = "シールド"
  },
  Skill_23493_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_23493_Name = {
    Text = "シールド+ダメージ"
  },
  Skill_23494_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての覚醒体からの[Arg3]狂気を減少し、[Arg4]点の<BleedingIconKeywords:出血>を付与し、「症状：錯乱」と「症状：盲従」を山札のランダムな位置に追加する。"
  },
  Skill_23494_Name = {
    Text = "千変万化"
  },
  Skill_23495_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_23495_Name = {
    Text = "ダメージ+軟化"
  },
  Skill_23496_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。敵の<PowerIconKeywords:力>を[Arg3]点減少させる。2点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_23496_Name = {
    Text = "ダメージ+軟化+力の減少"
  },
  Skill_23497_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_23497_Name = {
    Text = "脳食の水仙"
  },
  Skill_23498_Desc = {
    Text = "[Arg1]点のシールドを獲得し、ダフォダイルのすべてのデバフ状態を解除する。"
  },
  Skill_23498_Name = {
    Text = "腐食の水仙"
  },
  Skill_23499_Desc = {
    Text = "[Arg1]点の力を増加する。"
  },
  Skill_23499_Name = {
    Text = "肉食の水仙"
  },
  Skill_23500_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、敵の<PowerIconKeywords:力>を[Arg3]点減少させ、2点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_23500_Name = {
    Text = "千変万化"
  },
  Skill_23501_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23501_Name = {
    Text = "ダメージ"
  },
  Skill_23502_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、敵の<PowerIconKeywords:力>を[Arg3]点減少させる。"
  },
  Skill_23502_Name = {
    Text = "ダメージ+力の減少"
  },
  Skill_23503_Desc = {
    Text = "[Arg1]点のシールドを獲得し、[Arg2]点の力を増加する。"
  },
  Skill_23503_Name = {
    Text = "シールド+力"
  },
  Skill_23504_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。[Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_23504_Name = {
    Text = "シールド+ダメージ+力"
  },
  Skill_23505_Desc = {
    Text = "3つの行動から1つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23505_Name = {
    Text = "千変万化・虚"
  },
  Skill_23506_Desc = {
    Text = "3つの行動から1つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23506_Name = {
    Text = "千変万化・虚"
  },
  Skill_23507_Desc = {
    Text = "3つの行動から1つを選び、ダフォダイルの行動に付与する。"
  },
  Skill_23507_Name = {
    Text = "千変万化・虚"
  },
  Skill_23508_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_23508_Name = {
    Text = "ダメージ+軟化"
  },
  Skill_23509_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_23509_Name = {
    Text = "首切りの一撃"
  },
  Skill_23510_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。[Arg4]点の<PowerIconKeywords:力>を獲得。ダフォダイルのすべてのデバフを解除する。"
  },
  Skill_23510_Name = {
    Text = "千変万化"
  },
  Skill_23511_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<BleedingIconKeywords:出血>を付与し、すべての覚醒体から[Arg4]狂気を減少する。"
  },
  Skill_23511_Name = {
    Text = "連撃+出血+狂気減少"
  },
  Skill_23729_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ブロックされなかったダメージを与えるたび、1層の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_23729_Name = {Text = "狩り"},
  Skill_23756_Desc = {
    Text = "発射後、[Arg1] 点の<FixedDamage:純粋ダメージ>を受け、カードを 2 枚引く。"
  },
  Skill_23756_Name = {
    Text = "ジョーカー"
  },
  Skill_23758_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーがこのターン最後に使用した指令カードを山札の一番上に戻し、相手の次のターン、ドロー枚数を-1。"
  },
  Skill_23758_Name = {
    Text = "念動力操作"
  },
  Skill_23761_Desc = {
    Text = "カーシアが「幻影転身」を獲得。相手がカードを10回出すと、即座に少量のライフを持つ「分身」を召喚する。"
  },
  Skill_23761_Name = {Text = "覚醒"},
  Skill_23810_Desc = {
    Text = "<TouquKeywords:永久的に>[Arg1]点の<PowerIconKeywords:力>を奪う。次のターン開始時、相手のドロー枚数を–3し、山札の一番上の3枚を公開し、相手が1枚を手札に追加。"
  },
  Skill_23810_Name = {
    Text = "消失マジック"
  },
  Skill_23811_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「跳動する爆弾」1枚を行動力消費3として即座に手札に追加。フーディーニが「得意満面」を1点持つごとに、「跳動する爆弾」の行動力消費が1減少する。"
  },
  Skill_23811_Name = {
    Text = "無から有を生む"
  },
  Skill_23812_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_23812_Name = {
    Text = "マジックカード：貫通"
  },
  Skill_23813_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。同時に5枚の「冒涜的な幻想」カードを手札に追加し、フーディーニが1点の「得意満面」を持つごとに、その中の1枚「冒涜的な幻想」を「啓示」に置き換える。"
  },
  Skill_23813_Name = {
    Text = "特技フライングカード"
  },
  Skill_23814_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。5枚の「ジョーカー」を相手の手札、山札、捨て札にそれぞれ追加。"
  },
  Skill_23814_Name = {
    Text = "マジックカーニバル"
  },
  Skill_23815_Desc = {
    Text = "自身の前方に「フーディーニ」の人形を1体召喚する。「得意満面」1点につきその最大ライフが20%減少する。最低1まで。"
  },
  Skill_23815_Name = {Text = "大変身"},
  Skill_23816_Desc = {
    Text = "「除外」と「保留」を持つ「幸運な観客」を1枚相手の手札に追加する。"
  },
  Skill_23816_Name = {
    Text = "幸運な観客"
  },
  Skill_23817_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_23817_Name = {
    Text = "マジックカード：衰弱"
  },
  Skill_23818_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_23818_Name = {
    Text = "魔術連打"
  },
  Skill_23819_Desc = {
    Text = "爆弾が手札にある間、1 ターン経過するごとにカウントが 1 増加し、カウントが 2 に達した状態でターン終了時に手札にある場合、味方チームに<Damage:[Damage:Arg1]> 点の<FixedDamage:純粋ダメージ>を与え、破壊される。現在のカウント：<RedQuality:[Arg2]>。"
  },
  Skill_23819_Name = {
    Text = "跳ねる爆弾"
  },
  Skill_23820_Desc = {
    Text = "爆弾が手札にある間、1 ターン経過するごとにカウントが 1 増加し、カウントが 2 に達した状態でターン終了時に手札にある場合、味方チームに<Damage:[Damage:Arg1]> 点の<FixedDamage:純粋ダメージ>を与え、破壊される。現在のカウント：<RedQuality:[Arg2]>。"
  },
  Skill_23820_Name = {
    Text = "跳ねる爆弾"
  },
  Skill_23821_Desc = {
    Text = "爆弾が手札にある間、1 ターン経過するごとにカウントが 1 増加し、カウントが 2 に達した状態でターン終了時に手札にある場合、味方チームに<Damage:[Damage:Arg1]> 点の<FixedDamage:純粋ダメージ>を与え、破壊される。現在のカウント：<RedQuality:[Arg2]>。"
  },
  Skill_23821_Name = {
    Text = "跳ねる爆弾"
  },
  Skill_23822_Desc = {
    Text = "爆弾が手札にある間、1 ターン経過するごとにカウントが 1 増加し、カウントが 2 に達した状態でターン終了時に手札にある場合、味方チームに<Damage:[Damage:Arg1]> 点の<FixedDamage:純粋ダメージ>を与え、破壊される。現在のカウント：<RedQuality:[Arg2]>。"
  },
  Skill_23822_Name = {
    Text = "跳ねる爆弾"
  },
  Skill_24173_Desc_1 = {
    Text = "指定されたすべての覚醒体は死亡しない。"
  },
  Skill_24173_Name_1 = {
    Text = "死の無効化"
  },
  Skill_24209_Desc = {
    Text = "現在のライフの[Arg1]%([Arg2])を失い、「神国の腕肢」に後列の敵へ3倍のダメージ([Arg3])を与えさせ、ボス戦の場合、10倍のダメージ([Arg4])を与える。"
  },
  Skill_24209_Name = {
    Text = "代行者の裁決"
  },
  Skill_24243_Desc = {
    Text = "次のターゲットを探している…"
  },
  Skill_24243_Name = {
    Text = "痕跡を探す"
  },
  Skill_24244_Desc = {
    Text = "覚醒体を1体選択し、50狂気を獲得する。しかし、「ヒドラ」に[Arg1]点の力を獲得させる。"
  },
  Skill_24244_Name = {Text = "執念"},
  Skill_24417_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_24417_Name = {Text = "神の刃"},
  Skill_24418_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_24418_Name = {
    Text = "至高の生贄"
  },
  Skill_24586_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを1回与え、自身が死亡する。"
  },
  Skill_24586_Name = {
    Text = "最期の贈り物"
  },
  Skill_24587_Desc = {
    Text = "相手がこのターン行動力3以上のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24587_Name = {
    Text = "「囁き」\n行動力≥3"
  },
  Skill_24604_Desc = {
    Text = "すべての「N」の分身を気絶させる。"
  },
  Skill_24604_Name = {
    Text = "薔薇の願い"
  },
  Skill_24605_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身に1点の「暗黒」と4点の「混沌」状態を付与し、「暗黒」状態1点ごとに最大3体の分身を生成する。"
  },
  Skill_24605_Name = {
    Text = "黒い召喚"
  },
  Skill_24606_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「至高の恩寵」1枚を相手の手札に追加。"
  },
  Skill_24606_Name = {
    Text = "盲目の契約"
  },
  Skill_24607_Desc = {
    Text = "行動力を2点獲得し、分身を気絶させることができる「薔薇の願い」を1枚手札に追加し、山札のカード4枚に<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_24607_Name = {
    Text = "至高の恩寵"
  },
  Skill_24608_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_24609_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての味方に[Arg3]点の<RetaliateIconKeywords:反撃>を付与。"
  },
  Skill_24609_Name = {
    Text = "潜行の霧"
  },
  Skill_24634_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「輪廻のパラドックス」を4枚手札に追加する。"
  },
  Skill_24634_Name = {
    Text = "四翼の芽生え"
  },
  Skill_24635_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「輪廻のパラドックス」を6枚手札に追加する。"
  },
  Skill_24635_Name = {
    Text = "六翼の解放"
  },
  Skill_24636_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「輪廻のパラドックス」を2枚手札に追加する。"
  },
  Skill_24636_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_24637_Desc = {
    Text = "ライフ上限を2倍に増加させる。毎ターン開始時に「タヴィに答える」を1枚手札に追加する。"
  },
  Skill_24637_Name = {Text = "復興"},
  Skill_24638_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と<Block:[Block:Arg2]>点のシールドを獲得し、2ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_24638_Name = {
    Text = "翼を広げる"
  },
  Skill_24646_Desc = {
    Text = "相手がこのターン症状カードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24646_Name = {
    Text = "「囁き」\n症状"
  },
  Skill_24647_Desc = {
    Text = "相手がこのターン使用したカードが5枚に達した時、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24647_Name = {
    Text = "「囁き」\nカード使用5"
  },
  Skill_24648_Desc = {
    Text = "相手がこのターン「キーオーダー」を発動した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24648_Name = {
    Text = "「囁き」\nキーオーダー"
  },
  Skill_24649_Desc = {
    Text = "相手がこのターン行動力0のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24649_Name = {
    Text = "「囁き」\n行動力0"
  },
  Skill_24650_Desc = {
    Text = "相手がこのターン狂気解放を2回使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24650_Name = {
    Text = "「囁き」\n狂気解放2"
  },
  Skill_24695_Desc = {
    Text = "相手がこのターン使用したカードが5枚に達した時、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24695_Name = {
    Text = "「囁き」\nカード使用5"
  },
  Skill_24696_Desc = {
    Text = "相手がこのターン症状カードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24696_Name = {
    Text = "「囁き」\n症状"
  },
  Skill_24697_Desc = {
    Text = "相手がこのターン「キーオーダー」を発動した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24697_Name = {
    Text = "「囁き」\nキーオーダー"
  },
  Skill_24698_Desc = {
    Text = "相手がこのターン「キーオーダー」を発動した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24698_Name = {
    Text = "「囁き」\nキーオーダー"
  },
  Skill_24699_Desc = {
    Text = "相手がこのターン行動力3以上のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24699_Name = {
    Text = "「囁き」\n行動力≥3"
  },
  Skill_24700_Desc = {
    Text = "相手がこのターン行動力3以上のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24700_Name = {
    Text = "「囁き」\n行動力≥3"
  },
  Skill_24701_Desc = {
    Text = "相手がこのターン行動力0のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24701_Name = {
    Text = "「囁き」\n行動力0"
  },
  Skill_24702_Desc = {
    Text = "相手がこのターン行動力0のカードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24702_Name = {
    Text = "「囁き」\n行動力0"
  },
  Skill_24703_Desc = {
    Text = "相手がこのターン狂気解放を2回使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24703_Name = {
    Text = "「囁き」\n狂気解放2"
  },
  Skill_24704_Desc = {
    Text = "相手がこのターン使用したカードが5枚に達した時、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24704_Name = {
    Text = "「囁き」\nカード使用5"
  },
  Skill_24705_Desc = {
    Text = "相手がこのターン狂気解放を2回使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24705_Name = {
    Text = "「囁き」\n狂気解放2"
  },
  Skill_24706_Desc = {
    Text = "相手がこのターン症状カードを使用した後、行動予測は「最期の贈り物」に変化する。"
  },
  Skill_24706_Name = {
    Text = "「囁き」\n症状"
  },
  Skill_24713_Desc = {
    Text = "「環行・ラモンナ」は狂気を 15 獲得し、他の覚醒体は狂気を 3 失う。このカードがターン終了時に手札にある場合、味方に[Arg1] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_24713_Name = {
    Text = "輪回のパラドックス"
  },
  Skill_24714_Desc_1 = {
    Text = "対象1体に[Arg1]点の<PowerColourKeywords:力の減少>を付与する。"
  },
  Skill_24714_Name_1 = {
    Text = "力の減少"
  },
  Skill_24982_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、カレンの失ったライフを[Arg2]%回復し、同量のシールドを獲得する。"
  },
  Skill_24982_Name = {Text = "静観"},
  Skill_24983_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_24983_Name = {
    Text = "メイドの魔法"
  },
  Skill_24984_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。相手の最大ライフを[Arg3]点減少させる。"
  },
  Skill_24984_Name = {Text = "食中毒"},
  Skill_24986_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1ターンの<WeaknessIconKeywords:虚弱>を付与し、「暗黒料理」を1枚手札に追加。"
  },
  Skill_24986_Name = {
    Text = "ガマシチュー"
  },
  Skill_24987_Desc = {
    Text = "使用後、3点の行動力を獲得し、自身に1ターンの<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>と[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。ターン終了時に手札にある場合、山札か捨て札にあるランダムな指令カード2枚に<SlowIconKeywords:遅延>を付与する。"
  },
  Skill_24987_Name = {
    Text = "カレン特製料理"
  },
  Skill_24988_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「暗黒料理」を2枚相手の手札に追加。2ターンの「満腹」を獲得：味方チームが行動力を消費するたびに、カレンが[Arg3]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_24988_Name = {
    Text = "ごゆっくり！"
  },
  Skill_24989_Desc = {
    Text = "使用後、2点の行動力と[Arg1]点の<IntoxicationIconKeywords:毒>を獲得する。ターン終了時に手札にある場合、山札または捨て札のランダムな指令カード1枚に<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_24989_Name = {
    Text = "暗黒料理"
  },
  Skill_25058_Desc = {
    Text = "「カレンの特製料理」を2枚相手の手札に追加し、「満腹」を3ターン獲得する：「満腹」：行動力を消費するたび、カレンが[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_25058_Name = {Text = "覚醒"},
  Skill_25127_Desc_1 = {
    Text = "すべてのカードを捨て、各覚醒体は2枚の攻撃を獲得。"
  },
  Skill_25127_Name_1 = {
    Text = "攻撃の獲得"
  },
  Skill_25173_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_25174_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_25174_Name = {
    Text = "黒い混沌"
  },
  Skill_25175_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与えます。<WeaknessIconKeywords:弱り> を [Arg3] ターン付与します。"
  },
  Skill_25176_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての味方に[Arg3]点の<RetaliateIconKeywords:反撃>を付与。"
  },
  Skill_25176_Name = {
    Text = "潜行の霧"
  },
  Skill_25182_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_24:「裂傷」>を4枚手札に追加する。"
  },
  Skill_25182_Name = {
    Text = "四翼の芽生え"
  },
  Skill_25183_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2枚の<DerivativeCardKeywords_24:「裂傷」>を手札に追加。"
  },
  Skill_25183_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_25184_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_24:「裂傷」>を6枚手札に追加する。"
  },
  Skill_25184_Name = {
    Text = "六翼の解放"
  },
  Skill_25389_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_25389_Name = {
    Text = "驚異のパフォーマンス"
  },
  Skill_25411_Desc = {
    Text = "毎ターン開始時の基本の触腕モード。触腕ダメージは100%。ターン終了時に「潮涌」モードのままの場合、永久触腕を1本生成する。"
  },
  Skill_25411_Name = {Text = "潮流"},
  Skill_25412_Desc = {
    Text = "·このターンの触腕ダメージが50％低下し、<Block:[Block:Arg1]>点のシールドを獲得する。以降、触腕が攻撃するたびに<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_25412_tempBattleDesc_1 = {
    Text = "·このターンの触腕ダメージが50％低下し、<Block:[Block:Arg1]>点のシールドを獲得する。以降、触腕が攻撃するたびに<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_25412_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg3]>点のシールドを獲得し、ターン終了時に触腕は攻撃しなくなり、クールダウンは3ターン。"
  },
  Skill_25412_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg3]>点のシールドを獲得し、ターン終了時に触腕は攻撃しなくなり、クールダウンは3ターン。"
  },
  Skill_25413_Desc = {
    Text = "·このターンの触腕ダメージが[Arg1]%になる。アクティブダメージを与えた後、触腕1本に対象の敵を攻撃させ、[Arg3]％の触腕ダメージを与える。ターン終了時に触腕を1本失う。現在の永久触腕の数が1本を超えた時のみ、このモードを選択可能。"
  },
  Skill_25413_tempBattleDesc_1 = {
    Text = "·このターンの触腕ダメージが[Arg1]%になる。アクティブダメージを与えた後、触腕1本に対象の敵を攻撃させ、[Arg3]％の触腕ダメージを与える。ターン終了時に触腕を1本失う。現在の永久触腕の数が1本を超えた時のみ、このモードを選択可能。"
  },
  Skill_25413_tempBattleDesc_2 = {
    Text = "今ターンの触腕ダメージは[Arg2]％となり、アクティブダメージを与えた後、1本の触腕が敵に攻撃する。ターン終了時に1本の触腕を失う。現在の永久触腕数が1本を超えている場合のみ、この姿勢を選択でき、クールダウンは3ターン。"
  },
  Skill_25413_tempBattleDesc_3 = {
    Text = "今ターンの触腕ダメージは[Arg2]％となり、アクティブダメージを与えた後、1本の触腕が敵に攻撃する。ターン終了時に1本の触腕を失う。現在の永久触腕数が1本を超えている場合のみ、この姿勢を選択でき、クールダウンは3ターン。"
  },
  Skill_30362_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1枚の「ジョーカー」を相手の山札の一番上に追加。"
  },
  Skill_30362_Name = {
    Text = "サプライズ！"
  },
  Skill_34668_Desc = {
    Text = "すべての手札を捨て、他の覚醒体を1体選択し100狂気を獲得させ、そのすべての山札を獲得し「手札帰還」を付与し、行動力が100にリセットされ、その後「山札作成」が手札に戻る。"
  },
  Skill_34668_Name = {
    Text = "山札作成"
  },
  Skill_34674_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_34675_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_34676_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。<DerivativeCardKeywords_45:「次元閉鎖」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_34677_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。<DerivativeCardKeywords_80:「窒息」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_34682_Desc = {
    Text = "すべての敵のライフを+9999999。"
  },
  Skill_34682_Name = {
    Text = "無敵の怪物"
  },
  Skill_35502_Desc = {
    Text = "猩紅炉のすべての回復量を消費し、ライフを[Heal:Arg1]回復する。最大[Arg2]点まで蓄積可能。"
  },
  Skill_35502_Name = {
    Text = "深紅の炉"
  },
  Skill_35502_tempBattleDesc_1 = {
    Text = "猩紅炉の回復量をすべて消費し、[Heal:Arg1]ポイントのライフを回復する。最大 [Arg2] ポイントの猩紅炉を蓄積できる。すべての敵に対象の最大ライフの1％の侵蝕を与え、消費した猩紅炉が多いほど侵蝕効果が強くなり、最大100%上昇する。「空殻」の敵に対して5倍の侵蝕効果を与える。3ターンクールダウン。"
  },
  Skill_35507_Desc = {
    Text = "覚醒体を1体選択して「幸運な観客」にし、そのすべてのカードに「保持」を付与する。「幸運な観客」のカードを使用すると「フーディーニ」のスキルが弱体化し、その力が減少するが、最大ライフを少量失う。"
  },
  Skill_35507_Name = {
    Text = "幸運な観客"
  },
  Skill_35522_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！！！"
  },
  Skill_35522_Name = {
    Text = "頭蓋骨猛撃"
  },
  Skill_35523_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_35524_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_35526_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_35526_Name = {Text = "重撃"},
  Skill_35528_Desc = {
    Text = "[Arg1]点の出血を付与する。"
  },
  Skill_35671_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_35671_Name = {Text = "強化"},
  Skill_35742_Desc = {
    Text = "失ったライフの[Arg1]%([Arg2])を回復し、同量のシールドを獲得し、[Arg3]キーエネルギーを獲得する。"
  },
  Skill_35742_Name = {
    Text = "理想郷の帳"
  },
  Skill_35743_Desc = {
    Text = "未装備の3つの「キーオーダー」から、1つを選んで直ちに発動する。"
  },
  Skill_35743_Name = {
    Text = "理想郷の帳"
  },
  Skill_35960_Desc = {
    Text = "1ターンの<FragileIconKeywords:脆弱>と[Arg1]点の毒を付与する。"
  },
  Skill_35960_Name = {
    Text = "抑圧毒素"
  },
  Skill_35961_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_35961_Name = {Text = "殉死"},
  Skill_35962_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_35963_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_35963_Name = {Text = "殉死"},
  Skill_35964_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_35965_Desc = {
    Text = "1ターンの<WeaknessIconKeywords:虚弱>を付与し、最も狂気が高い覚醒体を1ターン封印する。"
  },
  Skill_35965_Name = {
    Text = "原初の呪い"
  },
  Skill_36003_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36003_Name = {
    Text = "蛸の接吻"
  },
  Skill_36004_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_36005_Desc = {
    Text = "デバフ状態を解除し、<Block:[Block:Arg1]>点のシールドと1点の発狂を獲得する。"
  },
  Skill_36005_Name = {Text = "変身"},
  Skill_36025_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36026_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36027_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36028_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、プレイヤーの行動力が最も低いカード4枚に「水底の印」を付与する。"
  },
  Skill_36028_Name = {
    Text = "ロックオン"
  },
  Skill_36029_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36030_Desc = {
    Text = "棘のあるサンゴが体内に突き刺さった！"
  },
  Skill_36030_Name = {
    Text = "珊瑚寄生"
  },
  Skill_36031_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36032_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36033_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36034_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、プレイヤーの行動力が最も低いカード4枚に「水底の印」を付与する。"
  },
  Skill_36034_Name = {
    Text = "ロックオン"
  },
  Skill_36035_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36036_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36037_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。「睡夢の子」を1体前に、「水の子」を1体後ろに召喚する。"
  },
  Skill_36037_Name = {Text = "信仰"},
  Skill_36038_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36039_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「寄生珊瑚」を1枚山札の一番上に加える。"
  },
  Skill_36039_Name = {Text = "岩礁化"},
  Skill_36040_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_36040_Name = {Text = "信仰"},
  Skill_36041_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36042_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、プレイヤーの行動力が最も低いカード2枚に「水底の印」を付与する。"
  },
  Skill_36042_Name = {
    Text = "ロックオン"
  },
  Skill_36043_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36044_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。「睡夢の子」を1体前に召喚する。"
  },
  Skill_36044_Name = {Text = "信仰"},
  Skill_36045_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。「水の子」を1体後ろに召喚する。"
  },
  Skill_36045_Name = {Text = "信仰"},
  Skill_36046_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「寄生珊瑚」を1枚山札の一番上と捨て札の一番上に加える。"
  },
  Skill_36046_Name = {
    Text = "岩礁化加速"
  },
  Skill_36047_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_36047_Name = {Text = "信仰"},
  Skill_36048_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36049_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36076_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。他の味方のライフを自身のライフと同じ値回復し、自身は死亡する。"
  },
  Skill_36076_Name = {Text = "殉死"},
  Skill_36077_Desc = {
    Text = "1点の発狂を獲得し、カード2枚に1点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_36077_Name = {Text = "発狂"},
  Skill_36078_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーの手札をすべて捨てる。"
  },
  Skill_36078_Name = {Text = "離散"},
  Skill_36079_Desc = {
    Text = "1点の発狂を獲得し、カード3枚に1点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_36079_Name = {Text = "発狂"},
  Skill_36080_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「寄生珊瑚」を1枚山札の一番上に加える。"
  },
  Skill_36080_Name = {Text = "岩礁化"},
  Skill_36081_Desc = {
    Text = "1点の発狂を獲得し、カード2枚に1点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_36081_Name = {Text = "発狂"},
  Skill_36082_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「霊覚の子」を召喚する。"
  },
  Skill_36082_Name = {Text = "悪誕"},
  Skill_36083_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_36083_Name = {
    Text = "深海の洗礼"
  },
  Skill_36084_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーの手札をすべて捨てる。"
  },
  Skill_36084_Name = {Text = "離散"},
  Skill_36085_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。他の味方1体につき、自身は1層の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_36085_Name = {
    Text = "深海の洗礼"
  },
  Skill_36086_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_36086_Name = {
    Text = "深海の洗礼"
  },
  Skill_36087_Desc = {
    Text = "「裂傷」を3枚手札に追加する。"
  },
  Skill_36087_Name = {Text = "裂傷"},
  Skill_36088_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーの手札をすべて捨てる。"
  },
  Skill_36088_Name = {Text = "離散"},
  Skill_36089_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_36090_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「水の子」を1体召喚。"
  },
  Skill_36090_Name = {Text = "悪誕"},
  Skill_36177_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「霊覚の子」、「睡夢の子」、「水の子」を召喚する。"
  },
  Skill_36177_Name = {Text = "禍誕"},
  Skill_36179_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_36180_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_36255_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>と[Arg2]点のシールドを付与する。"
  },
  Skill_36255_Name = {
    Text = "旧日の夢"
  },
  Skill_36256_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札または捨て札のランダムな指令カード3枚に1点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_36256_Name = {
    Text = "悪夢の織り手"
  },
  Skill_36257_Desc = {
    Text = "ライフ上限が300%増加し、すべてのライフを回復し、[Arg3]点のシールドを獲得。7本の触腕上限を獲得。毎ターン終了時に[Arg1]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_36257_Name = {
    Text = "誕生の種"
  },
  Skill_36258_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの50%相当の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_36258_Name = {
    Text = "永遠の苦しみ"
  },
  Skill_36259_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ランダムに[Arg3]体の覚醒体を封印する。"
  },
  Skill_36259_Name = {Text = "長い夢"},
  Skill_36260_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_36260_Name = {Text = "夢話"},
  Skill_36261_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>、<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  Skill_36261_Name = {Text = "泣き声"},
  Skill_36326_Desc = {
    Text = "神母の権能を1点消費する。[Arg3]点の<PowerIconKeywords:力>を獲得し、「聖なる赤子」の触腕ダメージを[Arg2]点減少させる。\n（神母の権能：[Arg1]点）"
  },
  Skill_36326_Name = {
    Text = "恩仇に報う叱責"
  },
  Skill_36327_Desc = {
    Text = "神母の権能を1点消費する。3点の行動力を獲得し、カードを3枚引く。\n（神母の権能：[Arg1]点）"
  },
  Skill_36327_Name = {
    Text = "自由を敬う犠牲"
  },
  Skill_36328_Desc = {
    Text = "神母の権能を1点消費する。すべての覚醒体は20狂気を獲得する。さらに、「聖なる赤子」の触腕に「聖なる赤子」自身へ10倍のダメージ（[Arg2]点）の触腕ダメージを[Arg3]回直ちに与えさせる。\n（神母の権能：[Arg1]点）"
  },
  Skill_36328_Name = {
    Text = "威厳を示す斬首"
  },
  Skill_36329_Desc = {
    Text = "神母の権能を1点回復する。神母の権能はマーフィーの他の能力を発動するために消費できる。最大3点。\n（神母の権能：[Arg1]点）"
  },
  Skill_36329_Name = {Text = "小休憩"},
  Skill_36330_Desc = {
    Text = "前列の敵に最大ライフの 25%（[Arg1]）の<FixedDamage:純粋ダメージ>を与え、1 ターン昏睡させる。"
  },
  Skill_36330_Name = {Text = "王権"},
  Skill_36331_Desc = {
    Text = "昏睡中、行動不能。"
  },
  Skill_36331_Name = {Text = "昏睡"},
  Skill_36356_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身は死亡する。"
  },
  Skill_36356_Name = {Text = "殉死"},
  Skill_36357_Desc = {
    Text = "<TouquKeywords:永久的に奪う>：プレイヤーの<PowerIconKeywords:力>バフを[Arg1]点奪う。"
  },
  Skill_36357_Name = {Text = "吸う"},
  Skill_36358_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_36365_Desc = {
    Text = "「海中のもの」を1体前に召喚する。"
  },
  Skill_36365_Name = {Text = "眷属！"},
  Skill_36366_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の<DerivativeCardKeywords_23:「傷口」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_36367_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。狂気が最も高い覚醒体を封印。"
  },
  Skill_36368_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点のシールドを獲得し、プレイヤーが持つ残り手札1枚ごとに追加で[Arg4]点のシールドを獲得。"
  },
  Skill_36368_Name = {Text = "試み"},
  Skill_36648_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]シールドを獲得し、「生出」1点につきシールドが[Arg4]増加。"
  },
  Skill_36648_Name = {Text = "試み"},
  Skill_36649_Desc = {
    Text = "「霊覚の子」を1体後ろに召喚する。「生出」1点につきその力は増す！"
  },
  Skill_36649_Name = {
    Text = "選ばれし者"
  },
  Skill_36650_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]シールドを獲得し、プレイヤーが持つ残りカード1枚ごとに追加で[Arg4]シールドを獲得。"
  },
  Skill_36650_Name = {Text = "試み"},
  Skill_36651_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の<DerivativeCardKeywords_3:「痙攣」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_36651_Name = {
    Text = "至高の生贄"
  },
  Skill_36652_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。狂気が最も高い覚醒体を封印。"
  },
  Skill_36653_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2体の「睡夢の子」を前に召喚。"
  },
  Skill_36653_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_36654_Desc = {
    Text = "「海中のもの」を1体後ろに召喚する。"
  },
  Skill_36654_Name = {Text = "眷属！"},
  Skill_36655_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての覚醒体を封印し、2体の「リモリアの希望」を前に召喚。"
  },
  Skill_36655_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_36656_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。最も狂気の多い覚醒体を1ターン封印。"
  },
  Skill_36656_Name = {Text = "神の刃"},
  Skill_36657_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の<DerivativeCardKeywords_23:「傷口」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_36800_Desc = {
    Text = "山札から行動力消費が最も低いカードを[Arg1]枚引く。現在の界域が「深海」の場合、追加で<TentacleInjurieIconKeywords:触腕ダメージ>を[Arg2]点上昇させる。"
  },
  Skill_36800_Name = {
    Text = "オレッタの宝物"
  },
  Skill_36807_BattleDesc = {
    Text = "覚醒体を1名選択し、その覚醒体は<Energy:[Arg2]>狂気と[Arg3]点の<PowerIconKeywords:力>を獲得する。現在の界域が「血肉」の場合、追加で<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]、現在のライフの10％([Arg1])を失う。"
  },
  Skill_36807_Desc = {
    Text = "覚醒体を1体選択し、<Energy:[Arg2]>点の狂気を獲得させる。[Arg3]点の<PowerIconKeywords:力>を獲得する。現在の界域が「血肉」の場合、追加で<EmbryoFusionIconKeywords:胚胎融合>+[Arg4]するが、現在HPの10％を失う。"
  },
  Skill_36807_Name = {
    Text = "咆哮する血と砂"
  },
  Skill_36808_Desc = {
    Text = "[Arg4] 点の演算力を獲得する。覚醒体を1体選択し、その「打撃」[Arg1] 枚と「防御」[Arg1] 枚の未強化コピーを手札に追加し、<DepleteIconKeywords:除外>、<NothingnessIconKeywords:虚無>を付与する。現在の界域が「超次元」の場合、追加で [Arg2] 点の一時的な<PowerIconKeywords:力>と [Arg3] 点の一時的な<AlertIconKeywords:警戒>を獲得する。"
  },
  Skill_36808_Name = {
    Text = "儚き永遠"
  },
  Skill_36809_Desc = {
    Text = "[Arg1]％の一時クリティカル率と[Arg2]点の一時的な<PowerIconKeywords:力>を獲得する。ボス戦中かつこのターンにまだカードを出していない場合、[Arg3]回の死亡抵抗を発動しようとし、成功した場合<Block:[Block:Arg4]>点のシールドを獲得する。この効果は[Arg5]回のみ発動可能。"
  },
  Skill_36809_Name = {
    Text = "最後の誓い"
  },
  Skill_36843_Desc = {
    Text = "ドローパイルから [Arg1] 枚のカードを選択して手札に加え、その演算力消費を [Arg2] 減少させる。"
  },
  Skill_36843_Name = {
    Text = "回帰の扉を越え"
  },
  Skill_36844_Desc = {
    Text = "ライフが最も高い敵に [Arg2] 点の<IntoxicationIconKeywords:毒>を与え、<Block:[Block:Arg1]> 点のシールドを獲得する。今回のターンに「捕食」を発動していた場合、シールドを獲得せず、その敵の 50％ <IntoxicationIconKeywords:毒>を発動する。"
  },
  Skill_36844_Name = {
    Text = "湖畔の回想"
  },
  Skill_36845_Desc = {
    Text = "[Arg1] 点の演算力を獲得し、次のターン開始時に <Block:[Block:Arg2]> 点のシールドを獲得する。現在の界域が「深海」かつ「潮湧」姿態の場合、効果が触腕を [Arg3] 本生成に変わる。"
  },
  Skill_36845_Name = {
    Text = "骨を蝕む抱擁"
  },
  Skill_36846_Desc = {
    Text = "[Arg1] 点の<RetaliateIconKeywords:カウンター>を獲得し、全ての敵の<ExhaustionIconKeywords:力量>を一時的に [Arg2] 点低下させる。現在「超次元ターン」中の場合、一時的な<PowerIconKeywords:力量>の低下は行わず、全ての敵に対して 100％ の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_36846_Name = {
    Text = "腐敗の饗宴"
  },
  Skill_36851_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、[Arg2] 枚の<DerivativeCardKeywords_4:「霊感」>を手札に追加する。現在が超次元ターンの場合、効果が [Arg3] 枚の<DerivativeCardKeywords_4:「霊感」>を手札に追加に変更される。"
  },
  Skill_36851_Name = {
    Text = "灰霧の正体"
  },
  Skill_36852_Desc = {
    Text = "カードを1枚引く。指令カードまたは霊知覚醒を引いた場合、その演算力消費を0にし、その所有者に <Energy:[Arg1]> 点の狂気を獲得させる。それ以外の場合、そのカードを捨ててこの効果を繰り返す。"
  },
  Skill_36852_Name = {
    Text = "真夏の夢"
  },
  Skill_36853_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得する。攻撃ダメージを受けた時、次のターン開始時にダメージの [Arg2]% 分のシールドを獲得する。現在の界域が「血肉」の場合、遅延シールドを獲得せず、ダメージの10%分の回復量を猩紅溶炉に蓄積する。"
  },
  Skill_36853_Name = {
    Text = "神の御業"
  },
  Skill_36854_Desc = {
    Text = "行動力を1点と [Arg1] 点の<PowerIconKeywords:力>を獲得し、覚醒体を一体選んで [Arg2] 点の狂気を獲得させる。現在の界域が「深海」かつ「怒涛」姿態の場合、効果が [Arg3]% の一時的なクリティカルレートと一時的なクリティカルダメージの獲得に変わる。"
  },
  Skill_36854_Name = {
    Text = "巨人の覇道"
  },
  Skill_36855_Desc = {
    Text = "界域精通を [Arg1] 増加する。覚醒体を1体選択し <Energy:[Energy:Arg2]> 点の狂気を獲得させる。"
  },
  Skill_36855_Name = {
    Text = "すべてが彼女"
  },
  Skill_36856_BattleDesc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得し、カードを2枚引く。現在の界域が「血肉」の場合、現在ライフの10%（[Arg3]）を失い、追加で [Arg2] 点の一時的な<PowerIconKeywords:力>を獲得する。手札の<DerivativeCardKeywords_2:「胚胎」>1枚につき追加で [Arg2] 点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_36856_Desc = {
    Text = "[Arg1] 点の一時的な<PowerIconKeywords:力>を獲得し、カードを2枚引く。現在の界域が「血肉」の場合、現在ライフの10%を失い、追加で [Arg2] 点の一時的な<PowerIconKeywords:力>を獲得する。手札の<DerivativeCardKeywords_2:「胚胎」>1枚につき追加で [Arg2] 点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_36856_Name = {
    Text = "薔薇の勝利"
  },
  Skill_39273_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_3950_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_3951_AwakerSkillBackgroundStory = {
    Text = "白鳥が鏡のような湖面をさまよう。"
  },
  Skill_3951_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3951_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の[Arg3]％の<IntoxicationIconKeywords:毒>を発動。"
  },
  Skill_3951_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。リッツは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3951_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。リッツは<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の[Arg3]％の<IntoxicationIconKeywords:毒>を発動。"
  },
  Skill_3951_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_3951_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_3952_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。毎ターン手札に残っているカードに「<SlowIconKeywords:鈍化>」を付与する。"
  },
  Skill_3952_Name = {Text = "覚醒"},
  Skill_3953_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3954_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与える。[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_3954_Name = {
    Text = "恣意の波"
  },
  Skill_3955_Desc = {
    Text = "前列の味方に[Arg1]点の<ParcloseIconKeywords:バリア>を付与する。"
  },
  Skill_3955_Name = {Text = "バリア"},
  Skill_3956_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3957_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3958_Desc = {
    Text = "毎ターン開始時、前のターンに受けたダメージの半分に等しいシールドを獲得する。"
  },
  Skill_3958_Name = {
    Text = "林檎磨きの抱擁"
  },
  Skill_3960_Desc = {
    Text = "ターン終了時に手札にある場合、自身が1ターンの<WeaknessIconKeywords:虚弱>になる。使用後、すべての敵を1ターンの<WeaknessIconKeywords:虚弱>にする。売却不可。"
  },
  Skill_3961_AwakerSkillBackgroundStory = {
    Text = "名人の一手を見れば、その腕はすぐにわかる。\n賢い人はライカーの賭け方を真似るべきだ。"
  },
  Skill_3961_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3961_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。行動力が不足している場合、3黒章を消費して2回発動可能。（現在の黒章：[Arg3]）"
  },
  Skill_3961_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ライカーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3961_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ライカーは<Energy:[Energy:Arg2]>狂気を獲得。行動力が不足している場合、3黒章を消費して2回発動可能。"
  },
  Skill_3961_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_3961_Name = {Text = "攻撃"},
  Skill_3961_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_3962_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後続の「連続噛み付き」の攻撃回数を増加させる。"
  },
  Skill_3962_Name = {
    Text = "連続噛み付き"
  },
  Skill_3963_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、後退する。"
  },
  Skill_3964_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、3ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_3965_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_3966_Desc = {
    Text = "[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_3966_Name = {
    Text = "次元の空洞"
  },
  Skill_3967_AwakerSkillBackgroundStory = {
    Text = "誰かがかつて少女に言った。\n\n「クマちゃんを抱いて。彼がきっと夢を守ってくれるよ」\n\nこれが覚醒後にテディベアが彼女の守護者になった理由かもしれない。"
  },
  Skill_3967_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：今回の「永遠の瞳」はすべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、最終ダメージが200%増加する。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが[Arg3]%増加する。"
  },
  Skill_3967_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_3967_Name = {
    Text = "永遠の瞳"
  },
  Skill_3967_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：すべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、今回の「永遠の瞳」の最終ダメージが200%増加。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが50%増加する。このターン中、すべての覚醒体が与える最終ダメージが25%増加する。"
  },
  Skill_3967_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_3967_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:捕食>：今回の「永遠の瞳」はすべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、最終ダメージが200%増加する。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが[Arg3]%増加する。"
  },
  Skill_3967_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:捕食>：今回の「永遠の瞳」はすべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、最終ダメージが200%増加する。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが[Arg3]%増加する。アイギスが次に使用する「防御」は3回発動する。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:捕食>：すべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、今回の「永遠の瞳」の最終ダメージが200%増加する。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが[Arg3]%増加する。このターン、すべての覚醒体が与える最終ダメージが25%増加する。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:捕食>：すべての敵に1ターンの<PetrifactionIconKeywords:石化>を付与する。対象が石化耐性を持っている場合、今回の「永遠の瞳」の最終ダメージが200%増加する。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。発動するたび、「永遠の瞳」の基礎ダメージが[Arg3]%増加する。このターン、すべての覚醒体が与える最終ダメージが25%増加する。アイギスが次に使用する「防御」は3回発動する。"
  },
  Skill_3968_Desc = {
    Text = "ターン終了時に手札にある場合、[Arg1]点の<IntoxicationIconKeywords:毒>を獲得する。"
  },
  Skill_3969_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、自身の<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を解除する。"
  },
  Skill_3969_Name = {
    Text = "絶望からの生還"
  },
  Skill_3970_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_3971_AwakerSkillBackgroundStory = {
    Text = "彼女の手にある刃は、ただ正義のために振るわれる。"
  },
  Skill_3971_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_3971_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。アルバは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3971_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_3971_Name = {Text = "攻撃"},
  Skill_3971_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_3972_AwakerSkillBackgroundStory = {
    Text = "彼女は次元の中の奇妙な追跡者を恐れない。\n彼女には自身の秘術があるのだ。"
  },
  Skill_3972_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3972_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。 [Power:Arg3]点の<PowerIconKeywords:力>を獲得。 <TransitionIconKeywords:跳躍>： 1点の行動力を獲得。"
  },
  Skill_3972_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ダフォダイルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_3972_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ダフォダイルは<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。<TransitionIconKeywords:跳躍>：1点の行動力を獲得。"
  },
  Skill_3972_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_3972_EffectNameList_1 = {
    Text = "シールド,狂気,力"
  },
  Skill_3972_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_3972_PropertyNameList_1 = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_3973_AwakerSkillBackgroundStory = {
    Text = "静寂に飲み込まれそうなその瞬間、彼女は溺死した侍女を見た気がした。\n\n侍女の肌は白く、腐った睡蓮のように湖に浮かんでいた。\n首筋の傷痕は青白い静脈に沿って、見えないほど遠くまで伸びていた。\n\n「あなたのキャッツアイのネックレスを見てごらん」\n死体が言った。\n「全部灰になったよ。灰になった……」"
  },
  Skill_3973_Desc = {
    Text = "<Heal:[Heal:Arg1]>ライフを回復し、<Block:[Block:Arg2]>点のシールドを獲得。ターン終了時に手札にある場合、行動力消費が1増加し、回復ライフとシールドが倍になる。最大[Arg3]回まで重複可能。"
  },
  Skill_3973_EffectNameList = {
    Text = "回復,シールド"
  },
  Skill_3973_Name = {Text = "静観"},
  Skill_3973_PropertyNameList = {
    Text = "体力×GrowValue1,防御力×GrowValue2"
  },
  Skill_3974_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3974_Name = {Text = "喉切り"},
  Skill_3975_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_3977_AwakerSkillBackgroundStory = {
    Text = "「もっと近くに、恥ずかしがらずに！シルクハット氏に君の笑顔と楽しさを味わわせてあげよう」\n\nカーシアは帽子の縁に触れ、バンッ！とリボンとカードを出現させる！\n\n「心の中でカードを選んで。しーっ！誰にも言わないで。\nマスターカーシアがあなたのカードを当ててご覧にいれよう！」"
  },
  Skill_3977_Desc_0 = {
    Text = "「打撃」とみなす。<DimensionalSpaceIconKeywords:超次元空間>の任意1枚のカードを選択して手札に追加し、その行動力消費を–2する。ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_3977_Desc_3 = {
    Text = "<DimensionalSpaceIconKeywords:超次元空間>のカードを1枚選択して手札に追加し、その行動力消費2減少させる。ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。このカードは「攻撃」として扱う。<RippleKeywords:余波>：<DerivativeCardKeywords_4:「啓示」>を1枚山札に追加。"
  },
  Skill_3977_EffectNameList = {
    Text = "ダメージ,一時的な力"
  },
  Skill_3977_Name = {
    Text = "念動力操作"
  },
  Skill_3977_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_3978_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_3979_AwakerSkillBackgroundStory = {
    Text = "Schizophrenia――統合失調症。\nこの言葉が生まれる前から、ハーバートは実験室で無数の「症例」を作り出していた。\n\n24はその集大成だった。\n彼女の人格は驚くべき速度で増殖し、しかもそれぞれが互いに干渉しない。\n\nある意味で彼女の脳は、騒がしい住人でいっぱいの混雑したアパートのようだった。"
  },
  Skill_3979_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。"
  },
  Skill_3979_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_3979_Name = {
    Text = "乱れ切り"
  },
  Skill_3979_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_3980_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_3981_AwakerSkillBackgroundStory = {
    Text = "異種の血を受け継ぎ、異端と見なされたその血脈。\nその尊さと偉大さを信じ抜くことでしか、\nこの苛酷な世界にかろうじて生き延びることはできなかった。\n叔父アウンが遺した手巻き文書と、そこに描かれた美しき深海の古都——\nそれが彼にとって唯一の心の拠り所だった。\n「血が目覚めるその時、\nきっと深海の至高なる力が与えられるに違いない」"
  },
  Skill_3981_Desc = {
    Text = "ライフを<Heal:[Heal:Arg3]>回復し、自身の<WeaknessIconKeywords:虚弱>を解除。すべての敵に[Arg4]点の<VulnerabilityIconKeywords:易傷>を付与する。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]。[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。次のターン開始まで、攻撃を1回受けるたび1本の触腕が攻撃者に反撃する。"
  },
  Skill_3981_EffectNameList = {
    Text = "回復,触腕ダメージ,反撃"
  },
  Skill_3981_Name = {
    Text = "異端の継承"
  },
  Skill_3981_OverLimitUtlSkillDesc = {
    Text = "ライフを<Heal:[Heal:Arg3]>回復し、自身の<WeaknessIconKeywords:虚弱>を解除する。すべての敵に[Arg4]点の<VulnerabilityIconKeywords:易傷>を付与する。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]。[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。次のターン開始まで、攻撃を1回受けるたび1本の触腕が攻撃者を反撃する。触腕1本に5回攻撃させ、25%の反撃を獲得する。"
  },
  Skill_3981_PropertyNameList = {
    Text = "体力×GrowValue2,攻撃力×GrowValue1,攻撃力×GrowValue3"
  },
  Skill_3982_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_24:「裂傷」>を4枚手札に追加する。"
  },
  Skill_3982_Name = {
    Text = "四翼の芽生え"
  },
  Skill_3983_AwakerSkillBackgroundStory = {
    Text = "実験後、24はすべての鏡を壊した。\n\n「いい子だ」\n片目の科学者は彼女の髪をなでながら、静かに言った。\n「……おとなしくしていなさい」\n\n24は科学者の目の奥に「自分ではない何か」を見た。\n彼女は狂っていたに違いない。彼の目を抉ろうとしたなんて——\n\nだからこそ、彼女は蝋人形の中に「仕舞われた」のだ。"
  },
  Skill_3983_Desc = {
    Text = "「24」は<Energy:[Energy:Arg1]>狂気を獲得。\n<ExaltIconKeywords:霊知啓発>："
  },
  Skill_3983_EffectNameList = {
    Text = "狂気、狂気解放最終ダメージ上昇、触腕ダメージボーナス割合、力、混沌クリティカル率とクリティカルダメージ、反撃ダメージボーナス割合"
  },
  Skill_3983_Name = {
    Text = "調停人格"
  },
  Skill_3983_PropertyNameList = {
    Text = "$GrowValue1,GrowValue2,$GrowValue3,攻撃力×GrowValue4,$GrowValue5,$GrowValue6"
  },
  Skill_3984_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_24:「裂傷」>を6枚手札に追加する。"
  },
  Skill_3984_Name = {
    Text = "六翼の解放"
  },
  Skill_3986_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_3987_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点のシールドを獲得する。プレイヤーのターン終了前に手札1枚につき追加で[Arg4]点のシールドを獲得する。"
  },
  Skill_3987_Name = {Text = "試み"},
  Skill_3988_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3989_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3989_Name = {Text = "刺突"},
  Skill_3991_Desc = {
    Text = "<DerivativeCardKeywords_9:「よろよろ」>を[Arg1]枚相手の山札のランダムな位置に追加する。"
  },
  Skill_3991_Name = {
    Text = "よろよろ"
  },
  Skill_3992_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の<ParcloseIconKeywords:バリア>を獲得し、前進する。"
  },
  Skill_3993_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_3994_AwakerSkillBackgroundStory = {
    Text = "種を持たないものは芽吹きを望まない。\n植物は陽光と雨露を浴びて土を破り、幼子は愛と希望に浸り成長する。\nファイントは揺りかごの中で貴重な養分を抱き、静かにその時を待っている……"
  },
  Skill_3994_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、<Heal:[Heal:Arg2]>点のライフを回復。本戦闘中に<DeathResistanceIconKeywords:死亡抵抗>が発動したことがある場合、追加で1回発動する。"
  },
  Skill_3994_EffectNameList = {
    Text = "シールド,回復"
  },
  Skill_3994_PropertyNameList = {
    Text = "防御力×GrowValue1,体力×GrowValue2"
  },
  Skill_3995_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_3996_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<DerivativeCardKeywords_33:「助けて」>を手札に追加。"
  },
  Skill_3996_Name = {Text = "助けて"},
  Skill_3997_AwakerSkillBackgroundStory = {
    Text = "「ストリートファイトにルールなんてない。使えるものは何でも使うさ」"
  },
  Skill_3997_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_3997_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_3997_Name = {Text = "攻撃"},
  Skill_3997_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_3999_Desc = {
    Text = "使用不可。「狂気解放」を発動した後、すべての覚醒体を1ターン封印する。"
  },
  Skill_3999_Name = {
    Text = "次元閉鎖"
  },
  Skill_4000_Desc = {
    Text = "停滞中、行動不能。"
  },
  Skill_4000_Name = {Text = "停滞"},
  Skill_4001_AwakerSkillBackgroundStory = {
    Text = "蜘蛛の糸が彼女をしっかりと包み込む。彼女は温かく安全な繭の中で、外に向かってふいに変顔をした。"
  },
  Skill_4001_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。アグリッパは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4001_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。アグリッパは<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動する。"
  },
  Skill_4001_EffectNameList = {
    Text = "シールド、狂気"
  },
  Skill_4001_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4002_BattleDesc = {
    Text = "[Arg1]点のシールドを獲得する。引いた時、すべての覚醒体は3狂気を失う。"
  },
  Skill_4002_Desc = {
    Text = "最大ライフの10%のシールドを獲得する。引いた時、すべての覚醒体は3狂気を失う。"
  },
  Skill_4002_Name = {
    Text = "症状：憂鬱"
  },
  Skill_4003_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_4004_Desc = {
    Text = "[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4004_Name = {
    Text = "次元の霧"
  },
  Skill_4005_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4005_Name = {
    Text = "シールド"
  },
  Skill_4006_Desc = {
    Text = "ステータスカード。"
  },
  Skill_4006_Name = {
    Text = "よろよろ"
  },
  Skill_4007_Desc = {
    Text = "<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。<Block:[Block:Arg1]>点のシールドを獲得し、ターン終了時に残りシールドが2倍のライフに変換される。"
  },
  Skill_4008_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与え、1点の発狂を獲得する。"
  },
  Skill_4009_AwakerSkillBackgroundStory = {
    Text = "彼女は儚く、しかし甘美な誘惑を纏う雛鳥。空へ、大地へ、押し寄せる人波へとその身を向け、すべての防壁を解き放った。"
  },
  Skill_4009_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4009_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。レーアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4009_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4009_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4010_AwakerSkillBackgroundStory = {
    Text = "ヘロットはこの奇妙な力を、いつ得たのか覚えていない。\n\n星の見えない夜、ヘロットは牢獄の泥地で目覚め、側に蠢く黒い泥を見つけた。\nそれは新たな腕のように、彼女の頑丈な鎖を引き裂いた。\n\n彼女は隣に囚われていた、かつて彼女が嘆願した老いた農奴のことを思い、急ぎ駆け寄った。\nだが、そこに残っていたのは、ほぼ乾ききった血痕だけだった。\n\nそれは彼女の父だった。\n昼夜を問わぬ労苦は彼の命を奪わなかった。\n無慈悲な鞭も彼の命を奪わなかった。\n彼を殺したのは、彼女自身の嘆願であり、聞き入れた偽善者の中傷であり、正義を顧みぬ支配者の決断だった。\n\n涙は既に枯れ果て、流れるのは憎悪に染まりきった黒い液体だけだった。"
  },
  Skill_4010_BattleDesc = {
    Text = "現在のライフの[Arg1]%([Arg3])を失う。すべての敵に<Damage:[Damage:Arg2]>ダメージと同量の<BleedingIconKeywords:出血>を与える。ランダムな覚醒体の「攻撃」を2枚手札に追加し、<DepleteIconKeywords:除外>を付与する。このカードは「攻撃」として扱う。"
  },
  Skill_4010_Desc = {
    Text = "現在のライフの[Arg1]%を失う。すべての敵に<Damage:[Damage:Arg2]>ダメージと同量の<BleedingIconKeywords:出血>を付与する。ランダムな覚醒体の「攻撃」を2枚手札に追加し、<DepleteIconKeywords:除外>を付与する。このカードは「攻撃」として扱う。"
  },
  Skill_4010_EffectNameList = {
    Text = "ダメージ,「打撃」レベル"
  },
  Skill_4010_Name = {
    Text = "長き憎しみ"
  },
  Skill_4010_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4011_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4011_Name = {
    Text = "シールド"
  },
  Skill_4012_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4013_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4014_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4014_Name = {
    Text = "弔いの鐘の音"
  },
  Skill_4015_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4016_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_23:「傷口」>を[Arg3]枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4016_Name = {
    Text = "傷を与える"
  },
  Skill_4017_AwakerSkillBackgroundStory = {
    Text = "長い孤独の中で、彼女はなぜ剣を振るうのかを忘れてしまった。\nしかし、彼女はこの一撃を振るわねばならないことを知っている。"
  },
  Skill_4017_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。使用時、<PowerIconKeywords:力>の効果が[Arg2]倍になる。キーオーダーを使用するたび、この戦闘中の力の倍率+1。<TimeBeacon:ループ>：<C01EXCardKeyWord1:輪廻の庭>または<C01EXCardKeyWord2:未来讃歌>を選択。"
  },
  Skill_4017_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4017_Name = {
    Text = "運命の剣"
  },
  Skill_4017_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4018_AwakerSkillBackgroundStory = {
    Text = "痛み――痛み――\n漆黒で冷たい痛みは、彼女が覚えている少しだけものの一つ。\n\nもし彼女が本物の忘失の鸚鵡螺のように、美しい硬い殻を持っていたら、そんなに痛くなかったのだろうか？"
  },
  Skill_4018_Desc_0 = {
    Text = "ナウティラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ナウティラが獲得するシールドと<RetaliateIconKeywords:反撃>が[Arg2]%増加する。"
  },
  Skill_4018_Desc_15 = {
    Text = "ナウティラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ナウティラが獲得するシールドと<RetaliateIconKeywords:反撃>が[Arg2]%増加する。すべての覚醒体が与える<RetaliateIconKeywords:反撃>が[Arg3]%増加する。"
  },
  Skill_4018_EffectNameList = {Text = "狂気"},
  Skill_4018_Name = {
    Text = "修繕の達人"
  },
  Skill_4019_AwakerSkillBackgroundStory = {
    Text = "一から万物が生まれ、万物が一へと還る理論のように、彼女はパラドックスの罠にはまってしまったのだ。"
  },
  Skill_4019_Desc_0 = {
    Text = "<Posse:[Arg1]>分のキーエネルギーを獲得する。前のターンに最後に使用した3枚の異なる非派生指令カードの未強化コピーを手札に追加し、行動力消費を1減少させ、<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を付与する。手札に追加できる指令カードが不足する場合、同数のカードを引く。"
  },
  Skill_4019_Desc_3 = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得。前のターンに最後に使用した3枚の異なる非派生指令カードのコピーを手札に追加し、行動力消費を1減少させ、<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を付与する。手札に追加できる指令カードが不足している場合、同じ枚数のカードを引く。任意の解放済みのキーオーダーを1つ選択し、現在のキーオーダーと入れ替える。キーオーダーを使用するか、戦闘終了後に元に戻る。"
  },
  Skill_4019_EffectNameList = {
    Text = "キーチャージ"
  },
  Skill_4019_Name = {
    Text = "背理収束"
  },
  Skill_4019_OverLimitUtlSkillDesc_0 = {
    Text = "<Posse:[Arg1]> 点キーエネルギーを獲得する。前のターンに最後に発射した3枚の異なる非派生指令カードを原始複製して手札に加え、それらの行動力消費を0にし、<DepleteIconKeywords:消耗>と<NothingnessIconKeywords:虚無>を付与する。手札に加えられる指令カードが不足する場合、同数のカードをドローして代替する。上限を無視した<TimeBeacon2:ネゲントロピー>を3層獲得する。"
  },
  Skill_4019_OverLimitUtlSkillDesc_3 = {
    Text = "<Posse:[Arg1]>分のキーエネルギーを獲得。前のターンに最後に使用した3枚の異なる非派生指令カードの未強化コピーを手札に追加し、行動力消費を0にし、<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を獲得。手札に追加できる指令カードが不足する場合、同数のカードを引く。解放済みの任意のキーコマンド1つを選択して現在のキーコマンドと入れ替え、キーコマンド使用後または戦闘終了後に元に戻る。上限を無視して3層の<TimeBeacon2:ネゲントロピー>を獲得。"
  },
  Skill_4020_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4020_Name = {
    Text = "融蝕を抱く"
  },
  Skill_4021_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。次の「連続噛み付き」の攻撃回数を増加。"
  },
  Skill_4021_Name = {
    Text = "連続噛み付き"
  },
  Skill_4022_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後続の「連続噛み付き」の攻撃回数を増加させる。"
  },
  Skill_4022_Name = {
    Text = "連続噛み付き"
  },
  Skill_4023_AwakerSkillBackgroundStory = {
    Text = "リッツは緑炎を得たあの日の情景をまだ覚えている。\n\n手の中で青い火種がで燃え上がり、長く抑え込んできた願いを果たせと彼女を駆り立てた。"
  },
  Skill_4023_Desc = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg2]%ダメージ分の<IntoxicationIconKeywords:毒>を付与。ターン終了時に手札または<DimensionalSpaceIconKeywords:超次元空間>にある場合、「<DerivativeCardKeywords_19:腐敗の緑炎>」にアップグレード。行動力不足時でも強制的に使用可能、効果は<Energy:[Energy:Arg3]>狂気を獲得し除外に変更。"
  },
  Skill_4023_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4023_Name = {Text = "緑炎"},
  Skill_4023_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4024_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4025_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>を付与し、「鼠群の怒り」を獲得する。「鼠群の怒り」：次のターン攻撃を1回受けるたびに[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4025_Name = {
    Text = "鼠たちの集結"
  },
  Skill_4026_Desc = {
    Text = "<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_4026_Name = {
    Text = "絶望からの生還"
  },
  Skill_4027_AwakerSkillBackgroundStory = {
    Text = "ファイントは薄殻から離れることができない。\nだからティンクトは彼女の傍らで、よくこの鎮魂歌を静かに歌った。\n\n「あなたの命を吸い取ってしまうかもしれない」ファイントは言った。\n「大丈夫、私たちの命はひとつだもの」ティンクトは答えた。"
  },
  Skill_4027_BattleDesc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を解除。すべての敵の<ExhaustionIconKeywords:力>を[Exhaustion:Arg1]点一時的に減少させ、敵1体につき[Power:Arg1]点の<PowerIconKeywords:一時的な力>を獲得。このターンの次の跳躍効果は必ず発動する。<TransitionIconKeywords:跳躍>：代わりにすべての敵の<ExhaustionIconKeywords:力>を[Exhaustion:Arg2]点一時的に減少させ、敵1体につき[Power:Arg2]点の<PowerIconKeywords:一時的な力>を獲得。"
  },
  Skill_4027_Desc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を解除。すべての敵から[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:奪う>。このターンの次の跳躍効果は必ず発動する。<TransitionIconKeywords:跳躍>：代わりに[Arg2]点の<PowerIconKeywords:力>を<TouquKeywords:奪う>。"
  },
  Skill_4027_EffectNameList = {
    Text = "力の奪取,跳躍時の力の奪取"
  },
  Skill_4027_Name = {Text = "鎮魂歌"},
  Skill_4027_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4028_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_4028_Name = {
    Text = "自爆攻撃"
  },
  Skill_4029_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>を付与し、[Arg2]点の<PowerIconKeywords:力>を減少させる。"
  },
  Skill_4029_Name = {
    Text = "侵蝕の視線"
  },
  Skill_4030_Desc = {
    Text = "毎ターン[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4030_Name = {
    Text = "古代の呼び声"
  },
  Skill_4031_Desc = {
    Text = "[Arg1]点のシールドを獲得し、[Arg2]点の<AlertIconKeywords:警戒>が減少する。"
  },
  Skill_4031_Name = {
    Text = "枷：政務官夫人"
  },
  Skill_4032_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4032_Name = {Text = "重撃"},
  Skill_4033_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。歪んだ死体の宴のダメージを<Damage:[Damage:Arg3]>増加させる。"
  },
  Skill_4033_Name = {
    Text = "乱れ切り"
  },
  Skill_4034_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4035_AwakerSkillBackgroundStory = {
    Text = "錯乱する魂たちは、己の内側にしか目を向けない。\nゆえに、彼らは常に隙だらけだった。"
  },
  Skill_4035_BattleDesc = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_4035_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。「24」<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4035_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4035_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4036_AwakerSkillBackgroundStory = {
    Text = "細かい操作をするとき、ドールのこのハサミ状の鉗はあまり役に立たない。\nしかし、外界技術を人間用に完全に改造するまでは、彼女は「この手」を少なくとも十年は我慢しなければならない。"
  },
  Skill_4036_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4036_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ドールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4036_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4036_Name = {Text = "攻撃"},
  Skill_4036_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4037_Desc = {
    Text = "すべての手札の<SlowIconKeywords:鈍化>効果を解除する。"
  },
  Skill_4037_Name = {
    Text = "私は操り人形じゃない"
  },
  Skill_4038_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4041_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4042_Desc = {
    Text = "寄生が中断されたため、一時的な混乱に陥った…"
  },
  Skill_4043_BattleDesc = {
    Text = "敵全体に1ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を与え、敵全体の [Arg1] ポイント<ExhaustionIconKeywords:力>を一時的に減少させ、敵が1体いるごとに [Arg1] ポイントの一時的な<PowerIconKeywords:力>を得る。"
  },
  Skill_4043_Desc = {
    Text = "すべての敵に1ターンの<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を付与し、すべての敵から[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:奪取>する。"
  },
  Skill_4043_Name = {
    Text = "頭の中の音"
  },
  Skill_4044_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4045_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得し、ガードされなかったダメージと同量のライフを回復する。"
  },
  Skill_4045_Name = {
    Text = "歓喜と血"
  },
  Skill_4046_AwakerSkillBackgroundStory = {
    Text = "指令：攻撃。噛みつく。"
  },
  Skill_4046_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4046_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。リリーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4046_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4046_Name = {Text = "攻撃"},
  Skill_4046_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4047_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4048_Desc = {
    Text = "覚醒体を1体選択し、<Energy:[Arg1]>狂気を獲得させる。"
  },
  Skill_4048_Name = {
    Text = "小さな願い"
  },
  Skill_4049_Desc = {
    Text = "ライフを[Arg1]回復し、ターン終了時にすべてのシールドを失う。"
  },
  Skill_4049_Name = {
    Text = "枷：刑を受ける奴隷"
  },
  Skill_4050_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_3:「痙攣」>を2枚山札のランダムな位置に追加する。"
  },
  Skill_4050_Name = {Text = "明滅"},
  Skill_4051_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ライフが低いほどダメージが高くなる。"
  },
  Skill_4051_Name = {
    Text = "返しの一撃"
  },
  Skill_4052_Desc = {
    Text = "「血肉界域」の覚醒体が狂気解放を発動した時これを除外し、1回の<DevouredIconKeywords:捕食>効果を発動する。直接使用した場合、覚醒体を1体選択し<Energy:[Energy:Arg1]>狂気を獲得し、このターンのクリティカル率が[Arg2]%増加する。"
  },
  Skill_4052_tempBattleDesc_1 = {
    Text = "「血肉界域」の覚醒体が狂気解放を発動した時これを除外し、1回の<DevouredIconKeywords:捕食>効果を発動する。直接使用した場合、覚醒体を1体選択し<Energy:[Energy:Arg1]>狂気を獲得し、このターンのクリティカル率が[Arg2]%増加する。"
  },
  Skill_4052_tempBattleDesc_2 = {
    Text = "血肉界域覚醒体が狂気解放を発動する際にこれを消費し、1 回の<DevouredIconKeywords:捕食>効果を発動する。使用後、覚醒体を1体選択して <Energy:[Energy:Arg1]> ポイントの狂気を獲得する。覚醒体が毎ターン初めて「胚胎」または「聖純の子」を消費した時、[Arg3] 層の<BreedingKeywords1:繁殖祭典>を獲得する。"
  },
  Skill_4052_tempName_2 = {
    Text = "繁殖· 胚胎"
  },
  Skill_4053_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、3ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4054_Desc = {
    Text = "特殊な引き裂く傷口。ターン終了時に手札にある場合、[Arg1] 点の<FixedDamage:純粋ダメージ>を受ける。捨てた時にそれを<DepleteIconKeywords:消耗>する。"
  },
  Skill_4054_Name = {Text = "裂傷"},
  Skill_4055_AwakerSkillBackgroundStory = {
    Text = "果てしない大海の中、孤独な帆船は波に揺られていた。\n彼らは祈り、嘆き、懇願する。\n白き聖女が自分たちをこの海から救い出し、再び故郷の地へと導いてくれるようにと。\n中央のマストの上——白いドレスの少女が顔を上げ、空を舞う白い鳥を見つける。\n「舵を、私に。私が、あなたたちを家へ導きます」"
  },
  Skill_4055_BattleDesc_0 = {
    Text = "自身の<HeavyInjuryKeywords:重傷>状態を解除し、ライフを<Heal:[Heal:Arg1]>回復して算力を1獲得する。本戦闘中に致死ダメージを受けた時、復活してライフを[Arg2]%（<Heal:[Arg3]>）回復する（各戦闘で1回のみ発動可能）。"
  },
  Skill_4055_BattleDesc_3 = {
    Text = "自身の<HeavyInjuryKeywords:重傷>を解除。ライフを<Heal:[Heal:Arg1]>回復し、1点の行動力を獲得する。この戦闘中に致命的なダメージを受けた場合、復活し、[Arg2]%(<Heal:[Arg3]>)のライフを回復し、すべての覚醒体は<Energy:[Energy:Arg4]>狂気を獲得する。復活効果は6ターンに1回のみ発動可能。"
  },
  Skill_4055_Desc_0 = {
    Text = "自身の<HeavyInjuryKeywords:重傷>状態を解除し、ライフを<Heal:[Heal:Arg1]>回復して算力を1獲得する。本戦闘中に致死ダメージを受けた時、復活してライフを[Arg2]%回復する（各戦闘で1回のみ発動可能）。"
  },
  Skill_4055_Desc_3 = {
    Text = "自身の<HeavyInjuryKeywords:重傷>を解除。<Heal:[Heal:Arg1]>のライフを回復し、1点の行動力を獲得する。この戦闘中に致命的なダメージを受けた場合、復活し、[Arg2]%のライフを回復し、すべての覚醒体は<Energy:[Energy:Arg4]>狂気を獲得する。復活効果は6ターンに1回のみ発動可能。"
  },
  Skill_4055_EffectNameList = {
    Text = "回復,パーセント回復"
  },
  Skill_4055_Name = {
    Text = "不死の極楽鳥"
  },
  Skill_4055_OverLimitUtlSkillDesc_0 = {
    Text = "<Heal:[Heal:Arg1]> 点のライフを回復し、行動力を1得て、自身の<HeavyInjuryKeywords:重傷>状態を駆散する。本戦闘中、致死ダメージを受けた時に復活し、[Arg2]%(<Heal:[Arg3]>) のライフを回復する。1戦闘につき1回のみ発動可能。回復が50%増加した「純白の夢」を3枚手札に加え、消耗を付与する。"
  },
  Skill_4055_OverLimitUtlSkillDesc_3 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復して算力を1獲得し、自身の<HeavyInjuryKeywords:重傷>状態を解除する。本戦闘中に致死ダメージを受けた時、復活してライフを[Arg2]%（<Heal:[Arg3]>）回復し、すべての覚醒体が<Energy:[Energy:Arg4]>ポイントの狂気を獲得する。発動後、再度復活効果を付与するには6ターンの間隔が必要。回復が50%上昇した「純白夢境」を3枚手札に加え、消耗を付与する。"
  },
  Skill_4055_PropertyNameList = {
    Text = "体力×GrowValue1,$GrowValue2"
  },
  Skill_4056_AwakerSkillBackgroundStory = {
    Text = "「ありがとう、クマちゃん——あ、怒らないで、間違えた。ありがとう、小さなお目々ちゃん」"
  },
  Skill_4056_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4056_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。アイギスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4056_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4056_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4057_Desc = {
    Text = "「血の灯」を解放する：毎ターン終了後、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4057_Name = {Text = "血の灯"},
  Skill_4058_Desc = {
    Text = "「分裂症患者」を気絶させ、カードを3枚引き、3点の行動力を獲得する。"
  },
  Skill_4058_Name = {Text = "助けて"},
  Skill_4059_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4059_Name = {
    Text = "灼蝋の欲望"
  },
  Skill_4060_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4061_AwakerSkillBackgroundStory = {
    Text = "人は一生のうちに必ず三つのことを経験する。生まれること、死ぬこと、アグリッパを怒らせること。"
  },
  Skill_4061_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。アグリッパは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4061_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。アグリッパは<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動する。"
  },
  Skill_4061_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4061_Name = {Text = "攻撃"},
  Skill_4061_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_4062_Desc = {
    Text = "99層の<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。<DerivativeCardKeywords_33:「助けて」>を1枚手札に追加。"
  },
  Skill_4062_Name = {
    Text = "まるで私"
  },
  Skill_4063_Desc = {
    Text = "症状カードを5枚山札のランダムな位置に追加する。"
  },
  Skill_4063_Name = {Text = "罹患"},
  Skill_4064_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4065_AwakerSkillBackgroundStory = {
    Text = "上位存在の悪意が騒ぎ立てるが、人間の意志も黙って飲み込まれはしない。\n\nすべてを溶かす黒い粘液が上位存在の精神を蝕む。\nそれは人間の唯一の助けとなった。\n\n人形師は一時的に優位に立ち、両腕を広げ、破壊の電流を守護の弧に変えた。"
  },
  Skill_4065_BattleDesc_0 = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得。<Posse:[Arg2]>点の銀鍵エネルギーを獲得。自身の<FragileIconKeywords:脆弱>状態を解除。1枚のカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_13:「機械武装–放」>に変形する。"
  },
  Skill_4065_BattleDesc_1 = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得。<Posse:[Arg2]>キーエネルギーを獲得。自身の<FragileIconKeywords:脆弱>を解除。「<DepleteIconKeywords:除外>」が付与されたエリカの「防御」を1枚手札に追加する。<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚置かれるたび、<DerivativeCardKeywords_13:「機械武装・放」>に切り替える。"
  },
  Skill_4065_Desc_0 = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得。エリカの銀鍵チャージと同等の銀鍵エネルギーを獲得。自身の<FragileIconKeywords:脆弱>状態を解除。1枚のカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_13:「機械武装–放」>に変形する。"
  },
  Skill_4065_Desc_1 = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得。エリカのキーチャージに等しいキーエネルギーを獲得。自身の<FragileIconKeywords:脆弱>を解除。「<DepleteIconKeywords:除外>」が付与されたエリカの「防御」を1枚手札に追加する。<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚置かれるたび、<DerivativeCardKeywords_13:「機械武装・放」>に切り替わる。"
  },
  Skill_4065_EffectNameList = {
    Text = "パワー,警戒"
  },
  Skill_4065_Name = {
    Text = "機械武装-収"
  },
  Skill_4065_PropertyNameList = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4066_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4067_Desc = {
    Text = "[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4067_Name = {
    Text = "復讐宣言"
  },
  Skill_4068_AwakerSkillBackgroundStory = {
    Text = "少女は幼い頃から厳格な貴族教育を受けていた。\nその複雑な教えを一言で表すならば、「抑制」。\nそれは姿勢、食欲、話し声の大きさを含むが、それだけには留まらない。\n\n少女は一日中、花が咲き誇る庭で詩を読み、歌い、祈っていた。\n彼女はひどく空腹を感じていた。"
  },
  Skill_4068_BattleDesc_0 = {
    Text = "現在のライフの[Arg1]%（[Arg4]）を失う。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_4068_BattleDesc_2 = {
    Text = "現在のライフの[Arg1]%（[Arg4]）を失う。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。<Energy:[Energy:Arg5]>狂気を獲得。"
  },
  Skill_4068_Desc_0 = {
    Text = "現在のライフの[Arg1]%を失う。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_4068_Desc_2 = {
    Text = "現在のライフの[Arg1]%を失う。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。<Energy:[Energy:Arg5]>狂気を獲得。"
  },
  Skill_4068_EffectNameList_0 = {
    Text = "力,胚胎融合"
  },
  Skill_4068_Name = {
    Text = "満たされぬ痛み"
  },
  Skill_4068_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4069_AwakerSkillBackgroundStory = {
    Text = "「防御モード切り替え完了。私の後ろに隠れてください」"
  },
  Skill_4069_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4069_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。エリカは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4069_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4069_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4070_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4071_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4072_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>を獲得し、自身は<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4072_Name = {
    Text = "全体強化"
  },
  Skill_4073_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4073_Name = {Text = "歓喜"},
  Skill_4074_Desc = {
    Text = "すべての覚醒体の「防御」を手札に追加する。暴走したヘロットはリリーにしか関心がないようだ……"
  },
  Skill_4074_Name = {Text = "隠れる"},
  Skill_4075_AwakerSkillBackgroundStory = {
    Text = "ニムフィーアは花が大好きだった。\n文学小説と並んで、それは病床に伏す彼女にいつも寄り添うものだった。\n\nただ、両親を亡くしてからは、慰めの花束を送る人もいなくなった。\n最後に受け取った百合の花束も、時の流れとともに色褪せていった。\n\nだからこそ、彼女は自らの葬送のために、その花を迷わず持っていった。\n\n光と影に合わせて泳ぐ魚、茎葉のように枝分かれするサンゴ――海流に導かれ、少女の目指すその遠くへと向かって舞い始める。"
  },
  Skill_4075_BattleDesc_0 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg3]%の<IntoxicationIconKeywords:毒>を発動する。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4075_BattleDesc_3 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg3]%の<IntoxicationIconKeywords:毒>を発動する。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。この戦闘後、「自我の葬儀」で付与する<IntoxicationIconKeywords:毒>が[Poison:Arg4]点増加する。"
  },
  Skill_4075_Desc_0 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg3]%の<IntoxicationIconKeywords:毒>を発動する。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4075_Desc_3 = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与し、[Arg3]%の<IntoxicationIconKeywords:毒>を発動する。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。この戦闘後、「自我の葬儀」で付与する<IntoxicationIconKeywords:毒>が[Poison:Arg4]点増加する。"
  },
  Skill_4075_EffectNameList_0 = {Text = "毒,力"},
  Skill_4075_EffectNameList_3 = {
    Text = "毒,力,追加毒ボーナス"
  },
  Skill_4075_Name = {
    Text = "自我の葬儀"
  },
  Skill_4075_OverLimitUtlSkillDesc_0 = {
    Text = "全ての敵に [Poison:Arg1] スタックの<IntoxicationIconKeywords:毒>を付与し、<IntoxicationIconKeywords:毒>を [Arg3]％ 発動する。[Power:Arg2] 点の<PowerIconKeywords:力>を得る。ニムフィーアが与える<IntoxicationIconKeywords:毒>が50%上昇し、3ターン持続する。"
  },
  Skill_4075_OverLimitUtlSkillDesc_3 = {
    Text = "すべての敵に[Poison:Arg1]層の<IntoxicationIconKeywords:毒>を付与し、[Arg3]％の<IntoxicationIconKeywords:毒>効果を発動する。[Power:Arg2]点の<PowerIconKeywords:力量>を獲得する。本戦闘中の後続の「自我の葬儀」発動時に付与される<IntoxicationIconKeywords:毒>のスタック数が[Poison:Arg4]層増加する。ニンフィアが与える<IntoxicationIconKeywords:毒>が50%増加し、3ターン持続する。"
  },
  Skill_4075_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4075_PropertyNameList_3 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4076_AwakerSkillBackgroundStory = {
    Text = "毛皮をまとったヴィーナスよ、奴隷の背に足を乗せよ！\n彼らの首に鎖を巻きつけ、傷ついた心臓を脊椎針で突き刺せ。"
  },
  Skill_4076_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。このダメージは[Arg4]％の<RetaliateIconKeywords:反撃>ボーナスを受け、攻撃するたびにダメージ対象の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg3]点減少させる。<TransitionIconKeywords:跳躍>：5層の<DreamGuide:夢引き>を消費し、成功した場合は消費した算力を返還しさらに2回のダメージを与える。失敗した場合は2層の<DreamGuide:夢引き>を獲得する。"
  },
  Skill_4076_Desc_1 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Arg4]%の<RetaliateIconKeywords:反撃>ボーナスを獲得する。ダメージを与えるたび、対象から[Exhaustion:Arg3]点の<ExhaustionIconKeywords:力>を一時的に減少させる。このカードのクリティカル率が25%増加する。<TransitionIconKeywords:跳躍>：5点の<DreamGuide:夢引き>を消費し、成功した場合は消費した行動力を返還し、追加で2回のダメージを与える。失敗した場合は2点の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4076_EffectNameList = {
    Text = "ダメージ,力減少,反撃ボーナス"
  },
  Skill_4076_Name = {
    Text = "脊椎針の鎖"
  },
  Skill_4076_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2,$GrowValue3%"
  },
  Skill_4077_AwakerSkillBackgroundStory = {
    Text = "それらの触肢がどの神に属するのか、もはや知るすべはない。\nそれらは深淵より来たり、深海に潜み、自由にその腕を伸ばす——\n彼らはルルイエの主の命令に従うだろう。"
  },
  Skill_4077_BattleDesc_0 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg3]%の触腕ダメージボーナスと力ボーナスを獲得する。すべての触腕に[Arg2]回攻撃させ、[Arg4]%の<PunctureDamagewords:刺突ダメージ>を与える。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4077_BattleDesc_1 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg3]%の触腕ダメージボーナスと力のボーナスを獲得する。すべての触腕にすべての敵を[Arg2]回攻撃させ、[Arg4]%の<PunctureDamagewords:刺突ダメージ>を与える。現在の姿態が「静海」の場合、行動力消費が2点減少する。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4077_Desc_0 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg3]%の触腕ダメージボーナスと力ボーナスを獲得する。すべての触腕に[Arg2]回攻撃させ、[Arg4]%の<PunctureDamagewords:刺突ダメージ>を与える。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4077_Desc_1 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> 点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg3]%の触腕ダメージボーナスと力のボーナスを獲得する。すべての触腕にすべての敵を[Arg2]回攻撃させ、[Arg4]%の<PunctureDamagewords:刺突ダメージ>を与える。現在の姿態が「静海」の場合、行動力消費が2点減少する。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4077_EffectNameList = {
    Text = "ダメージ,全触腕攻撃ダメージ割合"
  },
  Skill_4077_Name = {
    Text = "深淵の号令"
  },
  Skill_4077_PropertyNameList = {
    Text = "攻撃力×GrowValue1,GrowValue2"
  },
  Skill_4078_Desc = {
    Text = "ターン終了時、このカードがまだ手札にあり、このターンに使用したカードが3枚以下の場合、次のターン追加で2点の行動力を獲得する。"
  },
  Skill_4078_Name = {
    Text = "症状：疑心"
  },
  Skill_4080_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、攻撃ダメージを受けるたびにダメージ回数が1増加する。"
  },
  Skill_4080_Name = {
    Text = "狂気を操る鞭"
  },
  Skill_4081_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、3ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4082_Desc = {
    Text = "1点の一時的な<ParcloseIconKeywords:バリア>を獲得し、行動力が永久に2点減少する。"
  },
  Skill_4082_Name = {
    Text = "枷：復活した聖女"
  },
  Skill_4085_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>を付与し、[Arg2]点の<PowerIconKeywords:力>を減少させる。"
  },
  Skill_4085_Name = {
    Text = "侵蝕の視線"
  },
  Skill_4086_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後退する。"
  },
  Skill_4087_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身は[Arg3]点の「蝋質のコーティング」を獲得する：状態異常を無効化し、クリティカルを受けるたびに1点減少する。"
  },
  Skill_4087_Name = {
    Text = "蝋人形登場"
  },
  Skill_4088_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1枚の<DerivativeCardKeywords_38:「幻覚」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_4088_Name = {Text = "幻覚"},
  Skill_4089_Desc = {
    Text = "最も狂気が低い覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_4089_Name = {
    Text = "無邪気な贈り物"
  },
  Skill_4090_Desc = {
    Text = "対象の覚醒体は[Arg1]狂気を獲得。"
  },
  Skill_4090_Name = {
    Text = "無邪気な贈り物"
  },
  Skill_4092_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4092_Name = {Text = "事故死"},
  Skill_4093_AwakerSkillBackgroundStory = {
    Text = "ウインクルと常に一緒にいる装置は「測位システム-Y031」と呼ばている。\n表向きには、精神を安定させ、精神波動を検出できるとされている。\n\nだが、それがなぜ精神力を圧縮し砲弾のように放つ機能まで備えているのか、ウインクルは語ろうとしない。"
  },
  Skill_4093_Desc_0 = {
    Text = "すべての敵の<ParcloseIconKeywords:バリア>を解除し、<Damage:[Damage:Arg1]>ダメージを与え、1ターンの<WeaknessIconKeywords:虚弱>を付与する。[Arg3]キーエネルギーを獲得。<TransitionIconKeywords:跳躍>：代わりに<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4093_Desc_1 = {
    Text = "すべての敵の<ParcloseIconKeywords:バリア>を解除。<Damage:[Damage:Arg1]>ダメージを与え、1点の<WeaknessIconKeywords:虚弱>を付与する。[Arg3]キーエネルギーを獲得。<TransitionIconKeywords:跳躍>：代わりに、<Energy:[Energy:Arg2]>狂気を獲得。[Arg4]%の反撃ボーナスを獲得。"
  },
  Skill_4093_EffectNameList_0 = {
    Text = "ダメージ,狂気,銀鍵エネルギー"
  },
  Skill_4093_EffectNameList_1 = {
    Text = "ダメージ,狂気,キーエネルギー,カウンターバフ"
  },
  Skill_4093_Name = {
    Text = "エネルギーレイ"
  },
  Skill_4093_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4093_PropertyNameList_1 = {
    Text = "攻撃力*GrowValue1,$GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4094_Desc = {
    Text = "1体の覚醒体のカードに「狩猟目標」状態を付与し、自身に2点の「狩猟の印」を付与する。"
  },
  Skill_4094_Name = {
    Text = "狩猟の儀式"
  },
  Skill_4095_AwakerSkillBackgroundStory = {
    Text = "ひとりぼっちの鼠が暗い隅を走り回る。\nそれは痩せ細り、小さく、ほうき一本で簡単に追い払える存在。\n\nストリートチルドレンもまた同じだった。\n\nしかし、小さき者にこそ宿る力がある。\n子どもと鼠が手を組んだとき、彼女たちは誰にも止められない存在になる。"
  },
  Skill_4095_Desc_0 = {
    Text = "行動力をすべて消費し、<DerivativeCardKeywords_12:「鼠たちの突撃」>を1枚山札のランダムな位置に追加する。「鼠たちの突撃」はランダムに<Damage:[Damage:Arg1]>ダメージを、消費した行動力+1回与える。"
  },
  Skill_4095_Desc_3 = {
    Text = "行動力をすべて消費し、<DerivativeCardKeywords_12:「鼠たちの突撃」>を1枚山札のランダムな位置に追加する。「鼠たちの突撃」はランダムに<Damage:[Damage:Arg1]>ダメージを、消費した行動力+2回与える。"
  },
  Skill_4095_EffectNameList = {
    Text = "「鼠たちの突撃」ダメージ"
  },
  Skill_4095_Name = {
    Text = "鼠たちの集結"
  },
  Skill_4095_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4097_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージと同量のライフを回復する。"
  },
  Skill_4098_Desc = {
    Text = "粘液が再びリリーを形成し、「不滅の花」状態を獲得し、攻撃形態を切り替える。「膿」を1体召喚する。"
  },
  Skill_4098_Name = {
    Text = "粘液の集合"
  },
  Skill_4099_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4100_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4102_AwakerSkillBackgroundStory = {
    Text = "空腹を抱えたライカーは腹をさすりながら街を歩いていた。\n今、目の前に焼き鳥でも現れたらいいのに、と彼は思った。\n\nその時、黒い影が彼のそばを駆け抜け、女性の悲鳴が響いた。\nライカーは素早くその影を捕らえる。\nバッグを返そうとしたが、女性の様子がどこかおかしかった。\n\n一悶着の後、巡査が遅れて到着。\nなんとその女性は有名な宝石怪盗だったのだ。\n\n持ち主はライカーにご馳走し、さらに金色の宝石を贈った。\n\n「まさかの収穫だな」とライカーは腹をさすりながら言った。"
  },
  Skill_4102_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。山札から1枚選んで手札に追加。クリティカルなら選んだカードの行動力消費を1点減少させる。"
  },
  Skill_4102_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。山札から1枚選んで手札に追加。クリティカルなら選んだカードの行動力消費を2点減少させる。"
  },
  Skill_4102_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4102_Name = {
    Text = "思わぬ収穫"
  },
  Skill_4102_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4103_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4104_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「狩猟の印」1点ごとに[Arg4]点の<PowerIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4104_Name = {
    Text = "裂頭一撃"
  },
  Skill_4105_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4105_Name = {Text = "試み"},
  Skill_4106_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得する。ジェンキンがガードされなかったダメージを与えるたび、ランダムな「指令カード」に永久の傷跡を残す。"
  },
  Skill_4106_Name = {
    Text = "空間歪曲"
  },
  Skill_4107_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4108_Desc = {
    Text = "すべての症状カードを<DerivativeCardKeywords_37:「窒息」>に変化させる。<DerivativeCardKeywords_37:「窒息」>：行動力1。ターン終了時にまだ手札にある場合、自身に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4108_Name = {
    Text = "苦海に沈む"
  },
  Skill_4109_AwakerSkillBackgroundStory = {
    Text = "穏やかな海風に包まれて、彼女はまどろみに落ちていた。\nだが羽ばたきの音で目を覚ました。\n真っ白な小鳥が彼女の頭上をかすめ、同じく白い雲の中に消えていった。\nこんなに陸地から離れた大洋の真ん中に、はぐれた鳥などいるはずがない。\nきっと、あれは夢だったのだろう。\nそう思いながらも、彼女は抑えきれない希望と憧憬を感じた。"
  },
  Skill_4109_BattleDesc_0 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。[Arg2]点の行動力を獲得し、手札の<SlowIconKeywords:遅延>を解除する。触腕1本に敵を攻撃させ、[Arg3]%の触腕ダメージを与える。"
  },
  Skill_4109_BattleDesc_2 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。[Arg2]点の行動力を獲得し、手札の<SlowIconKeywords:遅延>を解除する。1ターン<RetainIconKeywords:保持>するごとに、回復するライフが<Heal:[Arg3]>増加する。触腕1本に敵を攻撃させ、[Arg4]%の触腕ダメージを与える。"
  },
  Skill_4109_Desc_0 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。[Arg2]点の行動力を獲得し、手札の<SlowIconKeywords:遅延>を解除する。触腕1本に敵を攻撃させ、[Arg3]%の触腕ダメージを与える。"
  },
  Skill_4109_Desc_2 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。[Arg2]点の行動力を獲得し、手札の<SlowIconKeywords:遅延>を解除する。1ターン<RetainIconKeywords:保持>するごとに、回復するライフが<Heal:[Arg3]>増加する。触腕1本に敵を攻撃させ、[Arg4]%の触腕ダメージを与える。"
  },
  Skill_4109_EffectNameList_0 = {Text = "回復"},
  Skill_4109_EffectNameList_2 = {
    Text = "回復,追加回復"
  },
  Skill_4109_Name = {
    Text = "純白の夢"
  },
  Skill_4109_PropertyNameList_0 = {
    Text = "体力×GrowValue1,"
  },
  Skill_4109_PropertyNameList_2 = {
    Text = "体力×GrowValue1,体力×GrowValue2"
  },
  Skill_4110_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4110_Name = {
    Text = "蝋人形登場"
  },
  Skill_4111_AwakerSkillBackgroundStory = {
    Text = "次元を超える切断は、油断した者を瞬時に首と胴に分かつ。"
  },
  Skill_4111_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4111_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、2倍の力ボーナスを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1点の行動力を獲得。"
  },
  Skill_4111_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ダフォダイルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4111_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、2倍の力ボーナスを獲得。ダフォダイルは<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1点の行動力を獲得。"
  },
  Skill_4111_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4111_Name = {Text = "攻撃"},
  Skill_4111_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4112_Desc = {
    Text = "山札からカードを1枚選んで手札に追加する。"
  },
  Skill_4112_Name = {Text = "検索"},
  Skill_4113_AwakerSkillBackgroundStory = {
    Text = "ニムフィーアは海の寵児。祈りを捧げると、海の精霊たちが彼女の周りに集まり、長く離れない。"
  },
  Skill_4113_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4113_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ニムフィーアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4113_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4113_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4114_AwakerSkillBackgroundStory = {
    Text = "「簡単な芸ですが、とくとご覧くださいませ、わたくしの尊きお客様」"
  },
  Skill_4114_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]> のシールドを獲得。 <Energy:[Energy:Arg2]> の狂気を獲得。"
  },
  Skill_4114_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。現在のライフが50％未満の場合、追加で1回シールドを獲得、<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg4]。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4114_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ソレールは<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_4114_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。現在のライフが50%未満の場合、追加で1回シールドを獲得。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg4]。ソレールは<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_4114_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4114_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4115_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4116_Desc = {
    Text = "引いた時、自身の最大ライフが20%減少する。使用後、すべての覚醒体のこのターンのクリティカルダメージが100%増加する。"
  },
  Skill_4116_Name = {Text = "融蝕"},
  Skill_4117_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2枚の<DerivativeCardKeywords_34:「満たされぬ痛み」>を山札に追加。"
  },
  Skill_4118_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4118_Name = {
    Text = "自我の葬儀"
  },
  Skill_4119_BattleDesc = {
    Text = "ライフを[Arg1]失い、2点の行動力を獲得する。売却不可。"
  },
  Skill_4119_Desc = {
    Text = "最大ライフの10%を失い、2点の行動力を獲得する。売却不可。"
  },
  Skill_4120_AwakerSkillBackgroundStory = {
    Text = "彼女は剣闘士に、自らの命を絶つよう願い出た。\n「すぐに奴らが私を見つけ、辱め、首を刎ねるでしょう——両親にしたように。\n私は、あの下賤な虫けらの手で死ぬのは嫌。\n……でもあなたは、彼らとは違う。\nこれが私の唯一の願いです——私を殺して」\n剣闘士は大笑いし、その咆哮は胸の奥から響き上がり、身に着けた枷をガラガラと揺らした。\n彼は彼女の言葉に心を動かされることはなかったが——自ら差し出された新鮮な血を拒んだことは、一度もなかった。"
  },
  Skill_4120_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。現在の<EmbryoFusionIconKeywords:胚胎融合>が2倍になる。"
  },
  Skill_4120_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。現在の<EmbryoFusionIconKeywords:胚胎融合>が2倍になる。手札にある行動力消費が最も高いカード1枚の、このターンの行動力消費を1減少させる。"
  },
  Skill_4120_EffectNameList_0 = {
    Text = "シールド"
  },
  Skill_4120_Name = {
    Text = "耐え難い施し"
  },
  Skill_4120_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4121_AwakerSkillBackgroundStory = {
    Text = "穏やかで美しいだけでなく、鋭さと攻撃性も芸術の一部だ。"
  },
  Skill_4121_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_4121_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。サンガーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4121_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4121_Name = {Text = "攻撃"},
  Skill_4121_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4122_AwakerSkillBackgroundStory = {
    Text = "ヒレを守るは劣等感、それは疎外された者が自ら築く壁。"
  },
  Skill_4122_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4122_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。カエクスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4122_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4122_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4123_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4124_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4125_AwakerSkillBackgroundStory = {
    Text = "エリカの腰に装着された装置こそが、彼女の動力源。\n複雑な機械が理解不能な原理で絶え間なく電流を供給している。\n\n彼女と同様に、この装置も非常に不安定で、ショートした瞬間に莫大なエネルギーを噴出し、目に見える電流が周囲を焼き尽くす。"
  },
  Skill_4125_Desc_0 = {
    Text = "行動力消費が偶数の場合、<Damage:[Damage:Arg2]>ダメージをX+2回与える。そうでなければ<Block:[Block:Arg3]>点のシールドをX+1回獲得する。"
  },
  Skill_4125_Desc_3 = {
    Text = "行動力消費が偶数の場合、<Damage:[Damage:Arg2]>ダメージをX+2回与える。そうでない場合、<Block:[Block:Arg3]>点のシールドをX+1回与える。<TransitionIconKeywords:跳躍>：両方の効果が同時に発動。"
  },
  Skill_4125_EffectNameList = {
    Text = "ダメージ,シールド"
  },
  Skill_4125_Name = {
    Text = "機能過負荷"
  },
  Skill_4125_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4126_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後列に「請願者」を召喚する。"
  },
  Skill_4126_Name = {
    Text = "分裂攻撃"
  },
  Skill_4127_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を1枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4127_Name = {
    Text = "盛大な歓迎"
  },
  Skill_4128_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4129_Desc = {
    Text = "すべての手札を捨て、捨てた枚数+2のカードを引く。"
  },
  Skill_4129_Name = {
    Text = "純白の出会い"
  },
  Skill_4130_AwakerSkillBackgroundStory = {
    Text = "「さぁ、笑って！叫んで！はっちゃけて！これがカーニバルだよ！」"
  },
  Skill_4130_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4130_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。カーシアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4130_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4130_Name = {Text = "攻撃"},
  Skill_4130_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4131_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4132_Desc = {
    Text = "使用不可。"
  },
  Skill_4132_Name = {Text = "幻覚"},
  Skill_4133_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4133_Name = {
    Text = "石の分解"
  },
  Skill_4134_AwakerSkillBackgroundStory = {
    Text = "司教は祝福の儀式を敬虔に行う。\n人々が傷つかず、苦しまず、苦難のない国が訪れますように。"
  },
  Skill_4134_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4134_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。狂気を<Energy:[Energy:Arg2]>点獲得。<Heal:[Heal:Arg3]>点の猩紅炉を蓄積。"
  },
  Skill_4134_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。サルバドルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4134_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。サルバドルは<Energy:[Energy:Arg2]>狂気を獲得。<Heal:[Heal:Arg3]>点の猩紅炉を蓄積。"
  },
  Skill_4134_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4134_EffectNameList_1 = {
    Text = "シールド,狂気,猩紅炉蓄積量"
  },
  Skill_4134_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4134_PropertyNameList_1 = {
    Text = "防御力×GrowValue1,$GrowValue2,体力×GrowValue3"
  },
  Skill_41357_Desc = {
    Text = "10点の<DreamGuide:夢引き>を消費し、すべての敵をこのターン「夢の呟き」状態にする。「夢の呟き」：ダメージが[Arg3]%減少するが、攻撃回数が倍増。"
  },
  Skill_41357_Name = {
    Text = "夢の呟きの反響"
  },
  Skill_41358_Desc = {
    Text = "1点の<DreamGuide:夢引き>を獲得。"
  },
  Skill_41358_Name = {
    Text = "催眠回路"
  },
  Skill_41359_Desc = {
    Text = "5層の<DreamGuide:夢引き>を消費し、ワンダは<Energy:[Energy:Arg1]>狂気を獲得し、[Arg2]％の永続的な<RetaliateIconKeywords:反撃>（[Arg3]）に等しい一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_41359_Name = {
    Text = "深眠反撃"
  },
  Skill_4135_Desc = {Text = "廃棄"},
  Skill_4135_Name = {Text = "廃棄"},
  Skill_4136_Desc = {
    Text = "すべての手札を捨てる、"
  },
  Skill_4136_Name = {
    Text = "異形の心臓"
  },
  Skill_4137_AwakerSkillBackgroundStory = {
    Text = "演繹法は論理的推理であり、正しい前提を持って初めて正確な結論を導ける。\n調査員になる前、ラモンナは演繹法で世界を理解していた。\n冒険を重ねた後、彼女は帰納法を考え始めるかもしれない。"
  },
  Skill_4137_Desc_0 = {
    Text = "<Posse:[Arg1]>点の銀鍵エネルギーを獲得。山札か捨て札の山にあるカードを1枚選択して手札に追加し、その行動力消費を0にする。"
  },
  Skill_4137_Desc_3 = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得。山札か捨て札にある指令カードから1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_4:「啓示」>を1枚山札に追加する。"
  },
  Skill_4137_EffectNameList = {
    Text = "キーチャージ"
  },
  Skill_4137_Name = {
    Text = "世界演繹法"
  },
  Skill_4137_OverLimitUtlSkillDesc_0 = {
    Text = "<Posse:[Arg1]> 点キーエネルギーを獲得する。ドロー山または捨て札から1枚を手札に加え、その行動力消費を0にする。全ての敵に<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を1ターン付与し、次に発動するキーオーダーが2回発動する。"
  },
  Skill_4137_OverLimitUtlSkillDesc_3 = {
    Text = "<Posse:[Arg1]>点の銀鍵エネルギーを獲得。山札または捨て札の山からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_4:「インスピレーション」>を1枚山札に混ぜ入れる。すべての敵を1ターン<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>にし、次に発動するキーオーダーが2回発動する。"
  },
  Skill_4138_AwakerSkillBackgroundStory = {
    Text = "ラモンナは10歳の時、戦闘訓練を受けたいと申し出た。\n騎士ごっこをしたいわけではなく、養父の浪費を目の当たりにして、破産に備えようと決めたのだ。\n「女王の護衛の報酬は、警察の給料より高いよね？」"
  },
  Skill_4138_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。使用後、「女王の剣」のダメージ回数が+1増加し、最大[Arg3]回まで増加。[Arg7]点の一時的な界域精通を獲得。"
  },
  Skill_4138_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [Arg5] 回与え、ダメージを与えるたびに [Power:Arg4] 点の一時的な<PowerIconKeywords:力>を獲得する。発射後「女王の剣」のダメージ回数 +1、最大 [Arg6] 回まで増加。[Arg7] 点の一時的な界域知識を獲得する。<RippleKeywords:余波>：ラモンナのキーチャージと同等の 300% のキーエネルギーを獲得する。"
  },
  Skill_4138_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを [Arg5] 回与え、ダメージを与えるたびに [Power:Arg4] 点の一時的な<PowerIconKeywords:力>を獲得する。発射後「女王の剣」のダメージ回数 +1、最大 [Arg6] 回まで増加。[Arg7] 点の一時的な界域知識を獲得する。<RippleKeywords:余波>：ラモンナのキーチャージと同等の 300% のキーエネルギーを獲得する。"
  },
  Skill_4138_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4138_EffectNameList_1 = {
    Text = "ダメージ,一時的な力"
  },
  Skill_4138_Name = {
    Text = "女王の剣"
  },
  Skill_4138_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4138_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4139_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>と<Block:[Block:Arg2]>点のシールドと[Arg3]点の<AlertIconKeywords:警戒>を獲得する。"
  },
  Skill_4139_Name = {
    Text = "全体強化"
  },
  Skill_4140_Desc = {
    Text = "引いた時、1ライフを失う。使用後カードを1枚引く。身体が消えていくようだ……"
  },
  Skill_4140_Name = {Text = "融蝕液"},
  Skill_4141_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4142_Desc = {
    Text = "カードを2枚引き、「症状：夢の呟き」を1枚捨て札に追加。売却不可。"
  },
  Skill_4142_Name = {
    Text = "症状：夢の呟き"
  },
  Skill_4143_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4144_AwakerSkillBackgroundStory = {
    Text = "主人の命令なら、リリーはあの大物を投げられる。\n\nそれは痛みを恐れない。\n\n痛みは力に変わり、痛みは狂気を駆り立てる。\nリリーは痛みを恐れず、それも痛みを恐れない。\n\nだから、きっと主人の敵を倒せる。"
  },
  Skill_4144_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の<IntoxicationIconKeywords:毒>を[Arg3]％発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。このカードは「打撃」として扱う。<PainWord:忍耐>1点につきダメージが2増加し、使用後<PainWord:忍耐>を除去する。"
  },
  Skill_4144_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の<IntoxicationIconKeywords:毒>を[Arg3]％発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。このカードは「打撃」として扱う。<PainWord:忍耐>1点につきダメージが2増加し、使用後<PainWord:忍耐>を除去する。このカードのクリティカル率が20%増加する。"
  },
  Skill_4144_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の[Arg3]％の<IntoxicationIconKeywords:毒>効果を発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。「打撃」として扱う。<PainWord:忍耐>1層につき、ダメージが2増加し、使用後<PainWord:忍耐>の半分を除去する。このカードのクリティカル率が20%増加する。"
  },
  Skill_4144_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4144_Name = {
    Text = "返しの一撃"
  },
  Skill_4144_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4144_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の<IntoxicationIconKeywords:毒>を[Arg3]％発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。このカードは「打撃」として扱う。<PainWord:忍耐>1点につき、ダメージが2増加する。"
  },
  Skill_4144_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の[Arg3]％の<IntoxicationIconKeywords:毒>効果を発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。「打撃」として扱う。<PainWord:忍耐>1層につき、ダメージが2増加し、使用後<PainWord:忍耐>を除去する。このカードのクリティカル率が20%増加する。"
  },
  Skill_4144_tempBattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の[Arg3]％の<IntoxicationIconKeywords:毒>効果を発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。「打撃」として扱う。<PainWord:忍耐>1層につき、ダメージが2増加し、使用後<PainWord:忍耐>の半分を除去する。このカードのクリティカル率が20%増加する。"
  },
  Skill_4144_tempBattleDesc_4 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、対象の[Arg3]％の<IntoxicationIconKeywords:毒>効果を発動する。クリティカルが出た場合、発動割合が[Arg4]％に増加する。「打撃」として扱う。<PainWord:忍耐>1層につき、ダメージが[Float:Arg6]増加し、使用後<PainWord:忍耐>の半分を除去する。このカードのクリティカル率が20%増加する。"
  },
  Skill_4145_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。"
  },
  Skill_4146_Desc = {
    Text = "自身に [Arg1] 点の<FixedDamage:純粋ダメージ>を与え、[Arg2] 点の一時的な<PowerIconKeywords:力量>を獲得し、カードを 1 枚引く。"
  },
  Skill_4146_Name = {
    Text = "満たされぬ痛み"
  },
  Skill_4147_Desc_0 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_4147_EffectNameList = {
    Text = "「鼠たちの突撃」ダメージ"
  },
  Skill_4147_Name = {
    Text = "鼠たちの突撃"
  },
  Skill_4147_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4148_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4149_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得し、前進する。"
  },
  Skill_4150_Desc = {
    Text = "[Arg1]点のシールドを獲得し、シールド消滅時、残りシールドが2倍のライフに変換される。"
  },
  Skill_4150_Name = {
    Text = "不滅の花"
  },
  Skill_4151_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4152_AwakerSkillBackgroundStory = {
    Text = "血が地に満ちようと、屍が野に横たわろうと、心臓を貫く痛みを受けようとも。\n神の国土を再臨させるためには、これらは些細な犠牲だ。\n\n彼女は、自分がその選ばれし者ではないこと、牢獄に囚われたあの少女ではないことを、ただ恨んだ。"
  },
  Skill_4152_Desc_0 = {
    Text = "他の覚醒体を1体選択し、<Energy:[Energy:Arg2]>狂気を獲得させる。<O07CardKeyWord:祭儀>：獲得させる狂気が[Arg4]/[Arg5]/[Arg6]増加。"
  },
  Skill_4152_Desc_2 = {
    Text = "他の覚醒体を1体選択し、<Energy:[Energy:Arg2]>狂気を獲得させる。界域知識+[Arg3]。<O07CardKeyWord:祭儀>：獲得させる狂気が[Arg4]/[Arg5]/[Arg6]増加。"
  },
  Skill_4152_EffectNameList = {Text = "狂気"},
  Skill_4152_Name = {
    Text = "選ばれし者"
  },
  Skill_4154_AwakerSkillBackgroundStory = {
    Text = "聴こえるだろうか？——自らのために鳴り響く、弔鐘の音を。\n\n彼女は狂気の探求者でも、迷いに沈んだ彷徨者でもない。\nただ静かに自らの終焉を選んだ者だ。\n\n枯れゆく花弁が、彼女の葬列に捧げる最後の舞となる。\n荒れ狂う海風が、彼女のための葬送歌となり泣き叫ぶ。\n\nそしてその弔鐘が、胸の奥まで響き渡った瞬間——世界は、まるで死のごとき沈黙に包まれた。"
  },
  Skill_4154_Desc_0 = {
    Text = "すべての敵に[Poison:Arg1]層の<IntoxicationIconKeywords:毒>を付与し、[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:被ダメージ増加>を付与する。"
  },
  Skill_4154_Desc_1 = {
    Text = "すべての敵に[Poison:Arg1]層の<IntoxicationIconKeywords:毒>を付与し、[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:被ダメージ増加>を付与し、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4154_EffectNameList_0 = {Text = "毒"},
  Skill_4154_EffectNameList_1 = {
    Text = "ポイズン,シールド"
  },
  Skill_4154_Name = {
    Text = "弔いの鐘の音"
  },
  Skill_4154_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4154_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4155_AwakerSkillBackgroundStory = {
    Text = "古より来たり、無知から生じ、恐怖に根ざす。タイスの血管を流れるのは、原初の本能。\n\n振り返ることもできない犠牲の中、幼いタイスに刻み込まれたそれは、意志、感情、人格さえも、本来の彼女ではない何者かへと塗り替えた。\n\n彼女に残されたのは、命が共有する唯一の衝動、死を恐れる本能だけ。"
  },
  Skill_4155_BattleDesc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]、<Posse:[Arg2]> 点のキーエネルギーを獲得する。選択：<B01AFKeyWord1:ホラーの血>、<B01AFKeyWord2:腐敗の血>、<B01AFKeyWord3:生殖の血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_BattleDesc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]、<Posse:[Arg2]> 点のキーエネルギーを獲得する。選択：<B01AFKeyWordQ1:ホラーの血>、<B01AFKeyWordQ2:腐敗の血>、<B01AFKeyWordQ3:生殖の血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]、タイスのキーチャージの2倍に等しいキーエネルギーを獲得する。選択：<B01AFKeyWord1:ホラーの血>、<B01AFKeyWord2:腐敗の血>、<B01AFKeyWord3:生殖の血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]、タイスのキーチャージの2倍に等しいキーエネルギーを獲得する。選択：<B01AFKeyWordQ1:ホラーの血>、<B01AFKeyWordQ2:腐敗の血>、<B01AFKeyWordQ3:生殖の血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Name = {
    Text = "聖血の本能"
  },
  Skill_4156_AwakerSkillBackgroundStory = {
    Text = "まだ付き添いの女官だった頃から、オルラは書斎の隅で詩集を読むのが好きだった。\nその哀しい詩句は、いつも彼女の心を動かした。"
  },
  Skill_4156_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。このカードは「防御」として扱う。<TransitionIconKeywords:跳躍>：情緒「哀」に切り替える。"
  },
  Skill_4156_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与。このカードは「防御」として扱う。<TransitionIconKeywords:跳躍>：情緒「哀」に切り替える。"
  },
  Skill_4156_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オルラは<Energy:[Energy:Arg2]>狂気を獲得。このカードは「防御」として扱う。<TransitionIconKeywords:跳躍>：情緒「哀」に切り替える。隠喩「哀」を1点消費するたび、ライフを<Heal:[Heal:Arg3]>回復。"
  },
  Skill_4156_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オルラは<Energy:[Energy:Arg2]>狂気を獲得。すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与。このカードは「防御」として扱う。<TransitionIconKeywords:跳躍>：情緒「哀」に切り替える。隠喩「哀」1点消費するたび、ライフを<Heal:[Heal:Arg3]>回復。"
  },
  Skill_4156_EffectNameList = {
    Text = "シールド,狂気,HP回復"
  },
  Skill_4156_Name = {
    Text = "哀悼の詩篇"
  },
  Skill_4156_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,体力×GrowValue3"
  },
  Skill_4157_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4158_Desc = {
    Text = "このカードが手札にある時、すべての覚醒体のクリティカル率が25%増加する。ターン終了時にランダムな「症状カード」を1枚山札に加える。"
  },
  Skill_4158_Name = {
    Text = "症状：盲従"
  },
  Skill_4160_AwakerSkillBackgroundStory = {
    Text = "ブザンソンの侍女の目に映る彼女のお嬢様は、どこか変わっていた。\n彼女は詩を読むのも好まず、ハープも弾かない。\n彼女は過ぎ去ったものに夢中だった。\n彼女は枯れた落ち葉をじっと見つめ……そして突然立ち上がり、部屋に駆け戻る。\n——ドン！ドン！ドン！\n「ほら、うちの小さな芸術家さまよ！」\n侍女はため息混じりに言う。\n「レンガ職人と、いったい何が違うっていうのかしらね……」"
  },
  Skill_4160_Desc_0 = {
    Text = "次のターン開始時、自身の<FragileIconKeywords:脆弱>状態を解除し、<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4160_Desc_1 = {
    Text = "<Block:[Block:Arg2]>点のシールドを獲得。次のターン開始時、自身の<FragileIconKeywords:脆弱>状態を解除し、<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4160_EffectNameList_0 = {
    Text = "遅延シールド"
  },
  Skill_4160_EffectNameList_1 = {
    Text = "遅延シールド,シールド"
  },
  Skill_4160_Name = {
    Text = "閉鎖空間での制作"
  },
  Skill_4160_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4160_PropertyNameList_1 = {
    Text = "防御力×GrowValue1,防御力×GrowValue2,"
  },
  Skill_4161_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4162_Desc = {
    Text = "石化中、行動不能。"
  },
  Skill_4163_AwakerSkillBackgroundStory = {
    Text = "この骨に刻まれた憎しみと病的な粘液を尖刺に凝結し、絶対的な一撃で敵の首を断つ。"
  },
  Skill_4163_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4163_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気と10%のクリティカルダメージを獲得。"
  },
  Skill_4163_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4163_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ヘロットは<Energy:[Energy:Arg2]>狂気と10%のクリティカルダメージを獲得。"
  },
  Skill_4163_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4163_Name = {Text = "攻撃"},
  Skill_4163_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4164_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4165_AwakerSkillBackgroundStory = {
    Text = "「攻撃指令完了。次の指令をどうぞ」"
  },
  Skill_4165_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4165_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。エリカは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4165_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4165_Name = {Text = "攻撃"},
  Skill_4165_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4166_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！"
  },
  Skill_4166_Name = {
    Text = "鎖を断つ一撃"
  },
  Skill_4167_AwakerSkillBackgroundStory = {
    Text = "サロンの開催は簡単ではない。\n酒の選定、料理の献立、さらには給仕の選抜に至るまで自ら行う必要がある。\n幸運にも、ソレールは彼女の支援者から十分な自由と特権を得ていた。"
  },
  Skill_4167_Desc_0 = {
    Text = "ソレールは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Power:Arg2]点の<PowerIconKeywords:力>を獲得。ソレールがダメージを1回与えるたび、[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_4167_Desc_15 = {
    Text = "ソレールが<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Power:Arg2]点の<PowerIconKeywords:力>を獲得。ソレールがダメージを1回与えるたび、[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得し、ソレールの一時的な最終ダメージが2%増加し、他の覚醒体は1%増加する。一時的な最終ダメージの増加効果は毎ターン最大[Arg4]回まで発動する。"
  },
  Skill_4167_EffectNameList = {
    Text = "狂気,パワー,一時パワー"
  },
  Skill_4167_Name = {
    Text = "出迎えの特権"
  },
  Skill_4167_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4168_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与し、2倍の<PowerIconKeywords:力>ボーナスを受ける。"
  },
  Skill_4168_Name = {
    Text = "巨刃の威-血"
  },
  Skill_4169_AwakerSkillBackgroundStory = {
    Text = "美味しいものは食べるべきだし、使える力は使わなくては。\n少女は祈りを捧げ、その身に眠る力を呼び覚ました。"
  },
  Skill_4169_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4169_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]。"
  },
  Skill_4169_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4169_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]。"
  },
  Skill_4169_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4169_EffectNameList_2 = {
    Text = "シールド,狂気,触腕ダメージ"
  },
  Skill_4169_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4169_PropertyNameList_2 = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4170_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与える。このダメージは2倍の<PowerIconKeywords:力>ボーナスを受ける。[Arg2]点の<VulnerabilityIconKeywords:軟化>を付与する。"
  },
  Skill_4170_Name = {
    Text = "巨刃の威-終"
  },
  Skill_4171_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg4]回与える。このダメージは2倍の<PowerIconKeywords:力>ボーナスを受ける。自身が[Arg2]点の<PowerIconKeywords:力>を獲得し、敵の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>状態を半分除去する。"
  },
  Skill_4171_Name = {
    Text = "巨刃の威-力"
  },
  Skill_4172_AwakerSkillBackgroundStory = {
    Text = "「彼女はアリ一匹すら傷つけたくないんだ」\n「じゃあ彼女を殺して、もう一人の『彼女』を呼び出せばいい」"
  },
  Skill_4172_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_4172_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「24」<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4172_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4172_Name = {Text = "攻撃"},
  Skill_4172_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4173_Desc = {
    Text = "眩暈中、行動不能。"
  },
  Skill_4173_Name = {Text = "眩暈"},
  Skill_4174_Desc = {
    Text = "自身の前後に「提灯」を1体ずつ召喚する。"
  },
  Skill_4174_Name = {
    Text = "聖礼儀式"
  },
  Skill_4175_AwakerSkillBackgroundStory = {
    Text = "「街頭ネズミ」と呼ばれる子供たちが鼠を受け入れたのか、本物の鼠がストリートチルドレンを受け入れたのか……生きるために生まれたこの絆は、年月とともに揺るぎないものとなった。\n\n動物こそ、人間にとって最良の友——そう言えない理由があるだろうか？"
  },
  Skill_4175_Desc = {
    Text = "少女は明らかに何の特殊能力も持っていない。"
  },
  Skill_4175_EffectNameList = {Text = "力"},
  Skill_4175_Name = {Text = "無"},
  Skill_4175_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4176_AwakerSkillBackgroundStory = {
    Text = "「来い——ふんっ！」"
  },
  Skill_4176_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4176_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オジールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4176_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4176_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4177_AwakerSkillBackgroundStory = {
    Text = "あの三角形のギザギザの歯が怖い？\nそれとも白ウサギ婦人が中に入ったまま出てこないのが気になる？\n\n大丈夫！シルクハット氏はカーシアが訓練したプロのマジック道具！\nよっぽどのことがない限り、人を噛んだりしないから。"
  },
  Skill_4177_Desc_0 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。手札の症状カードと状態カードを捨て、その他の手札を山札に加え、捨てた枚数と加えた枚数の合計と同数のカードを引く。<TransitionIconKeywords:跳躍>：「全部消えろ！」の行動力消費を返還する。"
  },
  Skill_4177_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。手札の症状カードと状態カードを捨て、その他の手札を山札に加え、捨てた枚数と加えた枚数の合計と同数のカードを引く。1枚引くごとに<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：「全部消えろ！」の行動力消費を返還する。"
  },
  Skill_4177_EffectNameList = {Text = "狂気"},
  Skill_4177_Name = {
    Text = "消失マジック"
  },
  Skill_4178_AwakerSkillBackgroundStory = {
    Text = "「わたくしに最もふさわしいのは、王を超え、政権を左右する力です」"
  },
  Skill_4178_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> のダメージを与える。<Energy:[Energy:Arg2]> の狂気を獲得する。"
  },
  Skill_4178_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。現在のライフが50%未満([Arg4])の場合、追加で1回ダメージを与える。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4178_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ソレールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4178_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。現在のライフが50%未満の場合、追加で1回ダメージを与える。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。ソレールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4178_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4178_Name = {Text = "攻撃"},
  Skill_4178_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4181_Desc = {
    Text = "自身が[Arg1]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4181_Name = {Text = "S&M"},
  Skill_4182_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4183_Desc = {
    Text = "「24」は<Energy:[Energy:Arg1]>狂気を獲得。蒼白で脆いが、非常に堅固。"
  },
  Skill_4183_Name = {
    Text = "彼女を助けて！"
  },
  Skill_4184_BattleDesc = {
    Text = "使用時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。引いた時、[Arg2]点の<PowerIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4184_Desc = {
    Text = "使用時、[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。引いた時、[Arg2]点の<PowerIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4184_Name = {
    Text = "症状：ショック"
  },
  Skill_4185_Desc = {
    Text = "すべての敵から[Arg1]点の<PowerIconKeywords:力>を一時的に減少させ、ターン中に獲得するシールドと<PowerIconKeywords:力>が50%減少する。"
  },
  Skill_4185_EffectNameList = {Text = "力減少"},
  Skill_4185_Name = {Text = "呪詛"},
  Skill_4185_PropertyNameList = {
    Text = "攻撃力＊GrowValue"
  },
  Skill_4186_Desc = {
    Text = "すべての味方が<Block:[Block:Arg1]>点のシールドを獲得する。"
  },
  Skill_4186_Name = {
    Text = "全体シールド"
  },
  Skill_4187_Desc = {
    Text = "[Arg1]層の空虚を付与する。"
  },
  Skill_4187_Name = {
    Text = "狂気吸収"
  },
  Skill_4188_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4188_Name = {
    Text = "噛みつく"
  },
  Skill_4189_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。<DerivativeCardKeywords_3:「痙攣」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_4190_Desc = {
    Text = "ライフを[Arg1]回復し、すべての敵から[Arg1]点の力を減少させる。引いた時、すべての覚醒体は<Energy:10>狂気を失う。"
  },
  Skill_4190_Name = {
    Text = "巨人の畏怖"
  },
  Skill_4191_Desc = {
    Text = "すべての覚醒体に<Energy:[Energy:Arg1]>狂気を獲得させる。"
  },
  Skill_4191_Name = {
    Text = "混沌チャージ"
  },
  Skill_4192_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4192_Name = {
    Text = "自我の葬儀"
  },
  Skill_4193_AwakerSkillBackgroundStory = {
    Text = "「触手……無数の触手が地の底から私を引きずり込もうとして……\n先生、私、ヒステリーになったんでしょうか……」\n\n女性は無力に泣き、極度に怯え、頼るものを求めていた。\nその向かいに座るのは、眼鏡をかけた長髪の医師。\n\n「いいえ、これはヒステリーではありません」\n医師は微笑み、蛇のように細い目を細める。\n\n「これは現実……この世界に巣食う、歪んだ現実です」"
  },
  Skill_4193_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。この戦闘中「歪んだ死体の宴」の基礎ダメージが20%増加する。"
  },
  Skill_4193_EffectNameList_0 = {
    Text = "ダメージ,キーエネルギー,混沌躁狂ダメージ増加,触腕ダメージ,触腕ダメージボーナス割合,胚胎融合,猩紅炉回復量,力,一時的な力減少,超次元躁狂ダメージ増加,超次元躁狂ダメージ上限"
  },
  Skill_4193_Name = {
    Text = "歪んだ死体の宴"
  },
  Skill_4193_OverLimitUtlSkillDesc = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与える。この戦闘中「歪んだ死体の宴」の基礎ダメージが20%増加する。24点の界域知識を獲得し、「24」の次の指令カードは3回発動する。"
  },
  Skill_4193_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,攻撃力×GrowValue3,攻撃力×GrowValue4,$GrowValue5,$GrowValue6,体力×GrowValue7,攻撃力×GrowValue8,防御力×GrowValue9,攻撃力×GrowValue10"
  },
  Skill_4194_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4194_Name = {
    Text = "噛みつき"
  },
  Skill_4195_AwakerSkillBackgroundStory = {
    Text = "覚醒体となった後、オジールは不定形の黒い物質と安定した共生関係を築いた。\n融蝕の惨状を目撃した者は、オジールの出現に非常に緊張することが多い。\n彼と共に戦った者だけが、その無形の物がどれほど堅固な壁となるかを知っている。"
  },
  Skill_4195_Desc_0 = {
    Text = "行動力をすべて消費し、<Block:[Block:Arg1]>点のシールドを、消費した行動力+1回獲得。行動力を1点消費するたび、<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4195_Desc_3 = {
    Text = "行動力をすべて消費し、<Block:[Block:Arg1]>点のシールドを、消費した行動力+1回獲得。行動力を1点消費するたび、<Energy:[Energy:Arg3]>狂気を獲得。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4195_EffectNameList_0 = {
    Text = "シールド"
  },
  Skill_4195_EffectNameList_3 = {
    Text = "シールド,力"
  },
  Skill_4195_Name = {
    Text = "不定の壁"
  },
  Skill_4195_PropertyNameList_0 = {
    Text = "防御力×GrowValue1"
  },
  Skill_4195_PropertyNameList_3 = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4196_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4196_Name = {
    Text = "歪んだ死体の宴"
  },
  Skill_4197_AwakerSkillBackgroundStory = {
    Text = "「船の錨を上げて。航海の時です」"
  },
  Skill_4197_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。触腕を1本発動させて敵を攻撃し、[Arg3]％の触腕ダメージを与える。"
  },
  Skill_4197_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。シレストは<Energy:[Energy:Arg2]>狂気を獲得。触腕を1本発動させて敵を攻撃し、[Arg3]％の触腕ダメージを与える。"
  },
  Skill_4197_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4197_Name = {Text = "攻撃"},
  Skill_4197_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4198_AwakerSkillBackgroundStory = {
    Text = "ナウティラの人生の信条は『溶接で直せないものはない。もしあるなら何度も溶接すればいい』\nただし、彼女が何度も溶接する理由はそれだけではないことが多い。"
  },
  Skill_4198_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4198_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ナウティラは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4198_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4198_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4199_Desc = {
    Text = "ランダムな覚醒体に一時的な封印を1点付与する。これを2回繰り返す。"
  },
  Skill_4200_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4201_Desc = {
    Text = "[Arg2]点の<PowerIconKeywords:力>を獲得し、「枷」を4枚プレイヤーの手札に追加する。"
  },
  Skill_4201_Name = {
    Text = "復讐宣言"
  },
  Skill_4202_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4203_AwakerSkillBackgroundStory = {
    Text = "「ふふ！驚いたかい！」"
  },
  Skill_4203_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4203_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4203_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4203_Name = {Text = "攻撃"},
  Skill_4203_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4203_tempBattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与える。<Energy:[Energy:Arg2]> 狂気を付与"
  },
  Skill_4203_tempBattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]> の<PunctureDamagewords:刺突ダメージ>を4回与える。<Energy:[Energy:Arg2]> の狂気を獲得する。"
  },
  Skill_4204_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4205_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4206_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>を付与し、山札と捨て札のすべてのカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_4206_Name = {
    Text = "真・永遠の瞳"
  },
  Skill_4207_Desc = {
    Text = "味方全体が<Block:[Block:Arg1]>点のシールドを獲得する。"
  },
  Skill_4208_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<DerivativeCardKeywords_36:「冒涜的な幻想」>3枚を手札に追加。"
  },
  Skill_4208_Name = {
    Text = "異次元の凝視"
  },
  Skill_4209_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与え、同量の出血を付与する。後退する。"
  },
  Skill_4209_Name = {
    Text = "裂く一撃"
  },
  Skill_4210_Desc = {
    Text = "「ごめんなさい」を2体召喚し、それらに1層の<ParcloseIconKeywords:バリア>を付与する。"
  },
  Skill_4210_Name = {
    Text = "悔恨の海"
  },
  Skill_4211_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4212_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_26:「症状：妄想」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4212_Name = {
    Text = "泣き叫ぶ"
  },
  Skill_4213_Desc = {
    Text = "敵に1ターンの<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4213_Name = {
    Text = "尖った木"
  },
  Skill_4214_AwakerSkillBackgroundStory = {
    Text = "ナウティラの作業エリアには、大小さまざまなメモが貼られている。これはシルヴィアさんが教えてくれた、重要なことを覚えておくための方法だ。\nでも、片面だけに書かれた日記のように、その全てのメモには、たったひとつの同じ言葉しか記されていなかった。\n「忘れないで」\n——数多の記憶は、ペンを走らせる瞬間にも、こぼれ落ち消えるのだ。"
  },
  Skill_4214_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。他の覚醒体を1体選択し、<Energy:[Energy:Arg2]>点の狂気を獲得。"
  },
  Skill_4214_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4214_Name = {
    Text = "短期記憶"
  },
  Skill_4214_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4215_Desc = {
    Text = "ターン終了時に手札にある場合、[Arg1]点の<IntoxicationIconKeywords:毒>を獲得する。「私と共に溺れましょう！」"
  },
  Skill_4216_Desc = {
    Text = "[Arg1]点の一時的な<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_4216_Name = {Text = "蜂蜜酒"},
  Skill_4217_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4217_Name = {
    Text = "翼を広げる"
  },
  Skill_4218_Desc = {
    Text = "[Arg2]点のシールドと「放血」状態を獲得する。「放血」：ガードされなかったダメージを1回与えるたび、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4218_Name = {
    Text = "海の料理"
  },
  Skill_4219_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4220_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4222_BattleDesc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、永続の力の25％([Arg3])分の一時的な<PowerIconKeywords:力>を追加で獲得する。"
  },
  Skill_4222_Desc = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を獲得し、永久パワーの25%に相当する一時的な<PowerIconKeywords:力>を追加で獲得する。"
  },
  Skill_4222_Name = {
    Text = "永遠の執念"
  },
  Skill_4223_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg4]回与える。カード[Arg2]枚に「水底の印」を付与する：「水底の印」：使用後、敵が一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4223_Name = {
    Text = "獲物の印"
  },
  Skill_4224_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4224_Name = {
    Text = "混沌の獣"
  },
  Skill_4225_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4226_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点失い、ターン終了時にすべて失う。"
  },
  Skill_4226_Name = {Text = "祈り"},
  Skill_4227_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。次の「連続噛み付き」の攻撃回数を増加。"
  },
  Skill_4227_Name = {
    Text = "連続噛み付き"
  },
  Skill_4228_Desc = {
    Text = "毎ターン[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4228_Name = {
    Text = "復讐の予行"
  },
  Skill_4229_AwakerSkillBackgroundStory = {
    Text = "ペリシテの現指導者は、強き戦士である。\nその巨大な刃にて、一振りで敵をなぎ倒すことができる。\n\nペリシテの現指導者は、冷酷な暴君でもある。\nその残忍さゆえに、目的のためならば同胞の犠牲すら厭わない。\n\nペリシテの前指導者は、欲望の奴隷であった。\n力を渇望し、そして最後には、その力に囚われてしまったのだ。"
  },
  Skill_4229_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>のダメージを与え、対象のライフが25%未満([Arg3])の場合、またはこのダメージで対象を撃破したした場合、行動力消費を返還する。[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得。"
  },
  Skill_4229_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。対象のライフが25%未満([Arg3])の場合、またはこのダメージで対象を撃破した場合、行動力消費を返還する。[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得する。触腕1本につき追加で1倍の力ボーナスを獲得する。"
  },
  Skill_4229_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与え、対象のライフが25%未満、または対象を撃破した場合、行動力消費が返還される。<PowerIconKeywords:力>は「斬首重創」において[Arg2]倍の効果を発揮する。"
  },
  Skill_4229_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与え、対象のライフが25%未満、または対象を撃破した場合、行動力消費が返還される。<PowerIconKeywords:力>は「斬首重創」において[Arg2]倍の効果を発揮し、触腕1本につき力がさらに1倍の効果を発揮する。"
  },
  Skill_4229_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4229_Name = {
    Text = "斬首一閃"
  },
  Skill_4229_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4230_Desc = {
    Text = "覚醒体を1体選択し、50狂気を獲得する。"
  },
  Skill_4230_Name = {
    Text = "影の残響"
  },
  Skill_4231_AwakerSkillBackgroundStory = {
    Text = "「見て！オレッタが魚みたいに泡を吐いてる！」"
  },
  Skill_4231_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4231_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4231_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。オレッタは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4231_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、カードを1枚引く。オレッタは<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_4231_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4231_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4232_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4232_Name = {
    Text = "歪んだ死体の宴"
  },
  Skill_4233_AwakerSkillBackgroundStory = {
    Text = "海水が、枯れかけた花びらを優しく運び去る。\n水面に広がる波紋は睡蓮のように開閉する。\n\nだが、油断すれば、その穏やかさに欺かれてしまうだろう。\n月下の穏やかなさざ波は、実はすべてを呑み込むほど力を秘めている。\n\nそれは彼女の愛憎に似ていた。\n決して表に出ることはないが、激しい波濤となって反響する。"
  },
  Skill_4233_Desc_0 = {
    Text = "ライフが最も高い敵に<Damage:[Damage:Arg1]>ダメージを与え、同量の<IntoxicationIconKeywords:毒>を付与する。<PowerIconKeywords:力>の効果が2倍になる。"
  },
  Skill_4233_Desc_2 = {
    Text = "ライフが最も高い敵に<Damage:[Damage:Arg1]>ダメージを与え、同量の<IntoxicationIconKeywords:毒>を付与する。<PowerIconKeywords:力>の効果が2倍になる。毎ターン最初に使用した3枚の症状カードにつき、「夜潮洶湧」が本戦闘中に与えるダメージが[Arg2]点増加する。"
  },
  Skill_4233_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4233_Name = {Text = "夜の波"},
  Skill_4233_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4234_AwakerSkillBackgroundStory = {
    Text = "「私は何をしていたの？」\nナウティラは調査が終わるといつもこう自問する。\n攻撃した融蝕生物への罪悪感からではなく、ただ本当に忘れてしまうのだ。"
  },
  Skill_4234_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4234_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4234_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ナウティラは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4234_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ナウティラは<Energy:[Energy:Arg2]>狂気を獲得。[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4234_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4234_EffectNameList_1 = {
    Text = "ダメージ,狂気,反撃"
  },
  Skill_4234_Name = {Text = "攻撃"},
  Skill_4234_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4234_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4235_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>を付与し、「鼠群の怒り」を獲得する：次のターン攻撃を1回受けるたびに[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4235_Name = {
    Text = "鼠たちの集結"
  },
  Skill_4238_AwakerSkillBackgroundStory = {
    Text = "かつての、運命に従うだけの彼なら、この防壁を張ることなどなかった。"
  },
  Skill_4238_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<RippleKeywords:余波>：1本の触腕が敵に攻撃する。"
  },
  Skill_4238_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。[TentaclePower:Arg3]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4238_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。トゥルーは<Energy:[Energy:Arg2]>狂気を獲得。<RippleKeywords:余波>：1本の触腕が敵に攻撃する。"
  },
  Skill_4238_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。トゥルーは<Energy:[Energy:Arg2]>狂気を獲得。 [TentaclePower:Arg3]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と [Power:Arg3] 点の一時的な<PowerIconKeywords:力>を獲得。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4238_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4238_EffectNameList_2 = {
    Text = "シールド,狂気,一時的な触腕ダメージ,一時的な力"
  },
  Skill_4238_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4238_PropertyNameList_2 = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3,攻撃力×GrowValue3"
  },
  Skill_4239_AwakerSkillBackgroundStory = {
    Text = "神の治める国で、人々がこの偉大な大祭司を愛しているのは間違いない。\n誰もが彼女の献身、勤勉、犠牲を目にしている。\nだからこそ、多くの人が彼女を母神と同一視している——もちろん、これは内密に話すだけで、決してミリアムに知られてはならない。"
  },
  Skill_4239_Desc_0 = {
    Text = "[Arg4]枚の<O07CardKeyWord2:「聖礼」>を手札に追加、すべての敵に[Poison:Arg5]点の<IntoxicationIconKeywords:毒>を付与。触腕モードに応じて効果を獲得：潮涌：[Power:Arg1]点の<PowerIconKeywords:力量>と[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得；静海：他の覚醒体が<Energy:[Energy:Arg2]>狂気を獲得；怒涛：すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%即時発動する。"
  },
  Skill_4239_Desc_3 = {
    Text = "[Arg4]枚の<O07CardKeyWord2:「聖礼」>を手札に追加、すべての敵に[Poison:Arg5]点の<IntoxicationIconKeywords:毒>を付与。触腕モードに応じて効果を獲得：潮涌：[Power:Arg1]点の<PowerIconKeywords:力量>と[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得；静海：他の覚醒体が<Energy:[Energy:Arg2]>狂気を獲得；怒涛：すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%即時発動する。"
  },
  Skill_4239_EffectNameList = {
    Text = "力と触腕ダメージ,狂気,毒発動割合,毒"
  },
  Skill_4239_Name = {
    Text = "深淵への祈祷"
  },
  Skill_4239_OverLimitUtlSkillDesc = {
    Text = "[Arg6]枚の<O07CardKeyWord2:「聖礼」>を手札に追加、すべての敵に[Poison:Arg5]点の<IntoxicationIconKeywords:毒>を付与。触腕上限と触腕数+1。触腕モードに応じた効果を獲得：潮涌：[Power:Arg1]点の<PowerIconKeywords:力量>と[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得；静海：他の覚醒体が<Energy:[Energy:Arg2]>狂気を獲得；怒涛：すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%即時発動する。"
  },
  Skill_4239_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,$GrowValue3,攻撃力×GrowValue4"
  },
  Skill_4240_AwakerSkillBackgroundStory = {
    Text = "この美しいトレー、彼女にぴったりじゃない？"
  },
  Skill_4240_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4240_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。カレンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4240_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4240_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4241_AwakerSkillBackgroundStory = {
    Text = "多くの人は、初めて美声歌手の発声練習を聴いたとき驚く。\n\nその繊細でか弱い体から、こんなに力強く響き渡る声を放つとは。\n\n滑らかな音は次第に膨らみ、宇宙の隅々にまで響き渡る。"
  },
  Skill_4241_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得し、次のターン中クリティカル率+[Arg2]％。<TransitionIconKeywords:ワープ>：<Block:[Block:Arg3]> 点のシールドを獲得するように変更し、次のターン中クリティカル率+[Arg4]％。"
  },
  Skill_4241_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、次のターンのクリティカル率とクリティカルダメージ+[Arg2]&。<TransitionIconKeywords:跳躍>：代わりに、<Block:[Block:Arg3]>点のシールドを獲得し、次のターンのクリティカル率とクリティカルダメージ+[Arg4]%。"
  },
  Skill_4241_EffectNameList = {
    Text = "シールド,ワープシールド"
  },
  Skill_4241_Name = {
    Text = "響き渡る音"
  },
  Skill_4241_PropertyNameList = {
    Text = "防御力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4242_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4243_AwakerSkillBackgroundStory = {
    Text = "ペンとインクは彼女の武器だが、バラの棘のように、いつも自らを傷つける。"
  },
  Skill_4243_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg3]>狂気を獲得。このカードは「攻撃」として扱う。<TransitionIconKeywords:跳躍>：情緒「怒」に切り替える。"
  },
  Skill_4243_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg3]>狂気を獲得。すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。このカードは「攻撃」として扱う。<TransitionIconKeywords:跳躍>：情緒「怒」に切り替える。"
  },
  Skill_4243_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オルラは<Energy:[Energy:Arg3]>狂気を獲得。このカードは「攻撃」として扱う。<TransitionIconKeywords:跳躍>：情緒「怒」に切り替える。隠喩「怒」を1点消費するたび、追加でダメージを2回与える。"
  },
  Skill_4243_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オルラは<Energy:[Energy:Arg3]>狂気を獲得。すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。このカードは「攻撃」として扱う。<TransitionIconKeywords:跳躍>：情緒「怒」に切り替える。隠喩「怒」を1点消費するたび、追加でダメージを2回与える。"
  },
  Skill_4243_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4243_Name = {
    Text = "狂想の詩篇"
  },
  Skill_4243_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4244_AwakerSkillBackgroundStory = {
    Text = "あまりにも頻繁な勝利は、華やかな場の裏にいる上流階級の敵意を生んだ。\nライカーは街中で襲われたが、弾丸は胸の財布の銀貨に当たった。"
  },
  Skill_4244_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4244_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。行動力が不足している場合、3黒章を消費して2回発動可能。（現在の黒章：[Arg3]）"
  },
  Skill_4244_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライカーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4244_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライカーは<Energy:[Energy:Arg2]>狂気を獲得。行動力が不足している場合、3黒章を消費して2回発動可能。"
  },
  Skill_4244_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4244_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4245_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後退する。"
  },
  Skill_4246_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4247_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4247_Name = {
    Text = "噛みつく"
  },
  Skill_4248_Desc = {
    Text = "発射後に [Arg1] 点の<FixedDamage:純粋ダメージ>を受け、カードを 2 枚引き、それらを<DepleteIconKeywords:消耗>する。ターン終了時に手札にある場合、[Arg2] 点のダメージを受ける。"
  },
  Skill_4248_Name = {
    Text = "冒涜的な幻想"
  },
  Skill_4249_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4249_Name = {
    Text = "混沌の獣"
  },
  Skill_4250_AwakerSkillBackgroundStory = {
    Text = "幼き王は常に神の呟きを聞き、夢から抜け出せぬ日々を送っていた。\nそれでも、目覚めの合間にこぼれ落ちた言葉で、国を治めるには足る。\nどれほど逃れようとしても、民から託された威厳は、いつしか彼の権威そのものとなった。"
  },
  Skill_4250_Desc_0 = {
    Text = "トゥルーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕の上限+1。トゥルーが行動力を1点消費する、またはトゥルーの指令カードを1枚捨てるたび、[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4250_Desc_15 = {
    Text = "トゥルーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕の上限+1、トゥルーが行動力を1点消費する、またはトゥルーの指令カードを1枚捨てるたび、[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の<PowerIconKeywords:力>を獲得する。トゥルーが狂気解放を発動後、すべての敵が受ける触腕ダメージが[Arg3]%増加し、最大[Arg4]回まで累積可能。"
  },
  Skill_4250_EffectNameList = {
    Text = "狂気,触腕ダメージ,力量"
  },
  Skill_4250_Name = {
    Text = "不朽の威厳"
  },
  Skill_4250_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue2"
  },
  Skill_4251_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4253_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4254_Desc = {
    Text = "「祈り」を4点獲得し、他の味方を犠牲にし、教徒を1体犠牲にするごとに「祈り」を[Arg1]点追加で獲得する。"
  },
  Skill_4254_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_4255_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4255_Name = {Text = "刺突"},
  Skill_4257_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4257_Name = {
    Text = "踏みつけ"
  },
  Skill_4258_Desc = {
    Text = "[Arg2]点の<IntoxicationIconKeywords:毒>と1ターンの溶解を付与する。使用したカードは除外され、指令カードは3倍のダメージとシールドを生成する。3点の行動力を獲得し、カードを3枚引く。"
  },
  Skill_4258_Name = {
    Text = "憎悪捕食"
  },
  Skill_4259_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、山札と捨て札の中からランダムに[Arg2]枚のカードに「<SlowIconKeywords:鈍化>」を付与する。"
  },
  Skill_4259_Name = {
    Text = "遅効性薬剤"
  },
  Skill_4260_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_4261_Desc = {
    Text = "「祈り」をすべて消費し、「祈り」を2点消費するごとに後列に「小さな提灯教会」を1体召喚する。"
  },
  Skill_4261_Name = {
    Text = "聖礼儀式"
  },
  Skill_4263_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4264_AwakerSkillBackgroundStory = {
    Text = "滑稽な道化師にナイフが刺さり、逆さまの空中ブランコ乗りが落下——ご心配なく！親愛なる観客の皆さん、ショーは始まったばかり！"
  },
  Skill_4264_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4264_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。カーシアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4264_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4264_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4265_Desc = {
    Text = "倒れるわけにはいかないみんなが待っている。致命傷を受けたとき、 1点のライフを回復。"
  },
  Skill_4265_Name = {
    Text = "蝋人形館の鍵"
  },
  Skill_4266_Desc = {
    Text = "<DerivativeCardKeywords_80:「窒息」>を[Arg1]枚相手の手札に追加する。"
  },
  Skill_4266_Name = {
    Text = "溺死の怨念"
  },
  Skill_4268_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与え、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4269_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の<DerivativeCardKeywords_3:「痙攣」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_4270_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4270_Name = {
    Text = "鎖を断つ一撃"
  },
  Skill_4271_Desc = {
    Text = "<PunctureDamagewords:刺突ダメージ>を与える。手札にある行動力が最も高いカード1枚の行動力消費を1減少させる。"
  },
  Skill_4271_Name = {Text = "刺突"},
  Skill_4272_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4273_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚<DerivativeCardKeywords_3:「痙攣」>を山札のランダムな位置に追加する。"
  },
  Skill_4274_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4275_AwakerSkillBackgroundStory = {
    Text = "「ストリートファイトにルールなんてない。使えるものは何でも使うさ」"
  },
  Skill_4275_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4275_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ジェンキンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4275_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4275_Name = {Text = "攻撃"},
  Skill_4275_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4277_AwakerSkillBackgroundStory = {
    Text = "無から有を生むことは科学の領域ではない。\nドールはずっとそう信じてきた。宇宙、人類、そして融蝕現象、万物には起源があり、すべてには代償が必要だ。\n「錬金術の研究について、ドール教授はどう思いますか……」\n「研究が成功する可能性は、あなたの卒業論文の価値と同じ。ゼロよ」"
  },
  Skill_4277_BattleDesc_0 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復し、すべての手札を捨てる。"
  },
  Skill_4277_BattleDesc_2 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。すべての手札を捨て、1枚捨てるごとに<Block:[Heal:Arg2]>点のシールドを獲得する。"
  },
  Skill_4277_Desc_0 = {
    Text = "<Heal:[Heal:Arg1]>ライフを回復。すべての手札を捨て、1枚捨てるごとに追加で<Heal:[Heal:Arg2]>ライフを回復。"
  },
  Skill_4277_Desc_2 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。すべての手札を捨て、1枚捨てるごとに追加でライフを<Heal:[Heal:Arg2]>回復し、同量のシールドを獲得する。"
  },
  Skill_4277_EffectNameList = {
    Text = "回復,回復増加"
  },
  Skill_4277_Name = {
    Text = "等価交換"
  },
  Skill_4277_PropertyNameList = {
    Text = "体力×GrowValue1,体力×GrowValue2"
  },
  Skill_4278_AwakerSkillBackgroundStory = {
    Text = "彼の頬を、温かな血がつたって流れ落ちる。\n彼は口を大きく開き、刃のように鋭い牙をむき出しにした。\n\n弱肉強食こそが、この世界の根本原理――そして彼は、永遠なる狩人だ。\n彼は屍の山を踏みしめ、勝利の咆哮を轟かせた。"
  },
  Skill_4278_Desc_0 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。すべての敵の<PowerIconKeywords:力>を一時的に除去する。"
  },
  Skill_4278_Desc_2 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。すべての敵から<PowerIconKeywords:力>を一時的に除去し、同量の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4278_EffectNameList = {Text = "力"},
  Skill_4278_Name = {
    Text = "力こそ正義"
  },
  Skill_4278_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4279_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4280_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4281_AwakerSkillBackgroundStory = {
    Text = "彼女はもう思い出せない――自分がいつからこんな姿になったのかを。\n知らぬ間に、かつて父の前で泣きながら許しを乞うていた少女は死に、その血に濡れて咲いたのは、滅びゆく王国の贅を尽くした一輪の花。\n「私の最も尊い小さなカラスよ、今日はどんなきらめく宝石を私に運んでくれたのかしら？」"
  },
  Skill_4281_BattleDesc = {
    Text = "現在のライフの[Arg1]％（[Arg4]）を失う。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg2]。このターン中の残り時間内、ダメージを1回与えるたび、ターン終了時にライフを[Arg3]回復。"
  },
  Skill_4281_Desc = {
    Text = "現在のライフの[Arg1]％を失う。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg2]。このターン中の残り時間内、ダメージを1回与えるたび、ターン終了時にライフを[Arg3]回復。"
  },
  Skill_4281_EffectNameList = {
    Text = "胚胎融合,回復"
  },
  Skill_4281_Name = {
    Text = "珠玉の卵"
  },
  Skill_4281_PropertyNameList = {
    Text = "$GrowValue1,体質×GrowValue2"
  },
  Skill_4282_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4283_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4283_Name = {
    Text = "傲慢の刃"
  },
  Skill_4284_AwakerSkillBackgroundStory = {
    Text = "彼女は新兵たちにいつも言っていた――疲れても、弱っても、武器を手放してはいけない。\nそれを最も身近な仲間、最も堅固な盾としろ。\n\n戦場では、警戒心が命を救う。"
  },
  Skill_4284_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを[Arg2]回獲得。ターン終了時に手札にある場合、次回使用時に追加で1回シールドを獲得する。すべての覚醒体の<CardKeyWord:封印>を解除。"
  },
  Skill_4284_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを[Arg2]回獲得。ターン終了時に手札にある場合、次回使用時に追加で1回シールドを獲得する。すべての覚醒体の<CardKeyWord:封印>を解除。このカードは「防御」として扱う。"
  },
  Skill_4284_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ターン終了時に手札にある場合、次に使用する時シールドを追加で1回発生させる。すべての覚醒体の<CardKeyWord:封印>状態を解除。"
  },
  Skill_4284_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ターン終了時に手札にある場合、次に使用する時シールドを追加で1回発生させる。すべての覚醒体の<CardKeyWord:封印>状態を解除。「防御」として扱う。"
  },
  Skill_4284_EffectNameList = {
    Text = "シールド"
  },
  Skill_4284_Name = {
    Text = "戦闘体勢"
  },
  Skill_4284_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_4285_AwakerSkillBackgroundStory = {
    Text = "彼は暴力の象徴として召喚され、闘技場のスターとなった。\n彼は暴力の象徴として唾棄され、地下室の囚人となった。\n流れる血が鎖で厳しく縛られ、\n千年の渇望を経て——\n怒り、叫び、\nもはや耐えられない。"
  },
  Skill_4285_BattleDesc_0 = {
    Text = "現在のライフの[Arg1]%([Arg4])を失う。すべての敵に<Damage:[Damage:Arg2]>ダメージを与える。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4285_Desc_0 = {
    Text = "現在のライフの[Arg1]%を失う。すべての敵に<Damage:[Damage:Arg2]>ダメージを与える。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4285_EffectNameList_0 = {
    Text = "ダメージ,力"
  },
  Skill_4285_Name = {
    Text = "叫べ、血よ！"
  },
  Skill_4285_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4286_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4287_AwakerSkillBackgroundStory = {
    Text = "剣闘士は目を閉じた。\n心臓の鼓動は静かで力強く、遠くの歓声をかき消す。\n暗闇の中で、殺戮の炎が蠢く。\n跳ね上がり、沸き立ち、無限の闇を舐め尽くすまで。\n剣闘士は目を開けた。彼はついに準備が整った。"
  },
  Skill_4287_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを3回与える。 <Energy:[Energy:Arg2]>狂気を獲得。ライフが25%未満([Arg3])の場合、獲得する狂気が2倍になる。"
  },
  Skill_4287_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを3回与える。<Energy:[Energy:Arg2]>狂気を獲得。ライフが25%未満([Arg3])の場合、追加でダメージを2回与え、獲得する狂気が2倍になる。"
  },
  Skill_4287_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを3回与える。ユウハシは<Energy:[Energy:Arg2]>点の狂気を獲得し、ライフが25%未満の場合、獲得する狂気が2倍になる。"
  },
  Skill_4287_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを3回与える。ユウハシュは<Energy:[Energy:Arg2]>狂気を獲得。ライフが25%未満の場合、追加でダメージを2回与え、獲得する狂気が2倍になる。"
  },
  Skill_4287_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4287_Name = {
    Text = "沸け、血よ！"
  },
  Skill_4287_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4288_AwakerSkillBackgroundStory = {
    Text = "「星辰正しき刻、神の国は星々に引かれて水面に浮かび、再び現れる。その時、余もまた戻り、山のように天地の間に座す……」"
  },
  Skill_4288_Desc_0 = {
    Text = "触腕を[Arg1]本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]%の一時的なクリティカル率を獲得。"
  },
  Skill_4288_EffectNameList_0 = {
    Text = "一時的触腕ダメージ,一時的力量,クリティカル率"
  },
  Skill_4288_Name = {
    Text = "星辰正しき刻"
  },
  Skill_4288_OverLimitUtlSkillDesc_0 = {
    Text = "触腕を[Arg1]本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]%の一時的なクリティカル率を獲得。ターン終了時、すべての触腕にすべての敵を2回攻撃させる。"
  },
  Skill_4288_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4288_tempBattleDesc_1 = {
    Text = "触腕を[Arg1]本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]%の一時的なクリティカル率を獲得。"
  },
  Skill_4288_tempBattleDesc_2 = {
    Text = "触腕を [Arg1] 本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と [Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]%の一時的なクリティカル率を獲得。すべての敵が受ける触腕ダメージが10%増加し、最大5回まで累積可能。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_1 = {
    Text = "触腕を[Arg1]本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]%の一時的なクリティカル率を獲得。ターン終了時、すべての触腕にすべての敵を2回攻撃させる。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_2 = {
    Text = "触腕を[Arg1]本獲得。[TentaclePower:Arg2]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。[Arg3]％の一時的なクリティカル率を獲得。すべての敵が受ける触腕ダメージが10%増加し、最大5回まで累積可能。ターン終了時、すべての触腕にすべての敵を2回攻撃させる。"
  },
  Skill_4289_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点のシールドを獲得する。プレイヤーのターン終了前に手札1枚につき追加で[Arg4]点のシールドを獲得する。"
  },
  Skill_4289_Name = {Text = "試み"},
  Skill_4290_AwakerSkillBackgroundStory = {
    Text = "凱旋式はローマ人の祝祭である。\n白い鳩、月桂樹の葉、そして舞い散る金箔……これらは戦士に関わりがあるようでいて、何の関係もない。\n\n彼はガリア、アレクサンドリア、パルティアからの捕虜と共に、重い十字架に縛られ、街を引き回された。\nこれは凱旋式の恒例行事である。\n\n戦士は嘲弄される。\n彼は、亡き皇帝の血塗られた共謀者だと認定されたから。\n\n屈辱、怒り、それとも憎しみ？いや、どれでもない。\n\n戦士には感情も思考もない。\n彼はただ血の匂いを感じるだけだ。"
  },
  Skill_4290_BattleDesc_0 = {
    Text = "ユウハシュは <Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ユウハシュは<CardKeyWord:封印>の効果を受けず、クリティカル率とクリティカルダメージが[Arg2]%増加する。ライフが25%未満の場合、効果が2倍になる。"
  },
  Skill_4290_BattleDesc_15 = {
    Text = "ユウハシュは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ユウハシュは<CardKeyWord:封印>の効果を受けず、クリティカル率とクリティカルダメージが[Arg2]%増加する。「血と砂の賛歌」の最終ダメージが[Arg5]%増加し、ライフが25%未満の場合、効果が2倍になる。"
  },
  Skill_4290_Desc_0 = {
    Text = "ユウハシュは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ユウハシュは<CardKeyWord:封印>の効果を受けず、クリティカル率とクリティカルダメージが[Arg2]%増加する。ライフが25%未満の場合、効果が2倍になる。"
  },
  Skill_4290_Desc_15 = {
    Text = "ユウハシュは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ユウハシュは<CardKeyWord:封印>の効果を受けず、クリティカル率とクリティカルダメージが[Arg2]%増加する。「血と砂の賛歌」の最終ダメージが[Arg5]%増加し、ライフが25%未満の場合、効果が2倍になる。"
  },
  Skill_4290_EffectNameList = {Text = "狂気"},
  Skill_4290_Name = {
    Text = "赤い儀式"
  },
  Skill_4291_AwakerSkillBackgroundStory = {
    Text = "彼女は気ままに行動するのが好きだった。\n人の首を切り落とし、縫い合わせ、また切り落とし、また縫い合わせ……動機も目的もなく、すべてが自然に進み、誰も彼女に疑問を呈することはない。"
  },
  Skill_4291_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1点の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4291_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ワンダは<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1点の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4291_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4291_Name = {Text = "攻撃"},
  Skill_4291_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_4292_Desc = {
    Text = "3点の行動力を獲得。"
  },
  Skill_4292_Name = {
    Text = "鼠の知恵"
  },
  Skill_4293_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4293_Name = {Text = "掃除"},
  Skill_4294_Desc = {
    Text = "双方それぞれに[Arg1]点の<VulnerabilityIconKeywords:軟化>を付与する。「利刃Ⅱ」を獲得する：ガードされなかったダメージを与えた場合、山札の上に<DerivativeCardKeywords_23:「傷口」>を2枚追加する。この効果は1ターン持続する。"
  },
  Skill_4294_Name = {
    Text = "最期のあがき"
  },
  Skill_4295_AwakerSkillBackgroundStory = {
    Text = "この双眸は、もはや正常に世界を映すことができない。\n\n彼女は時間と現実の嵐に直面し、荒れ狂う混沌に切り裂かれ、粉々にされ、やがてそれ自体が彼女の眼となった。\n\n「ラモンナ」に属するもう一つの痕跡が彼女の身から消え去ろうとしている。\n彼女は失われゆく自分自身を掴むことができない。\n\n――かつて指先から零れ落ちた生命を掴めなかったように。"
  },
  Skill_4295_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。山札のカードを1枚手札に追加し、行動力消費を1減少させる。<TimeBeacon:ループ>：山札または捨て札のカードを1枚手札に追加し、行動力消費を0にする。"
  },
  Skill_4295_EffectNameList = {Text = "力"},
  Skill_4295_Name = {
    Text = "超越の眼"
  },
  Skill_4295_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4296_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_36:「冒涜的な幻想」>を1枚手札に追加する。"
  },
  Skill_4296_Name = {
    Text = "精神噛み付き"
  },
  Skill_4297_AwakerSkillBackgroundStory = {
    Text = "注意せよ。この女のすべての行動は、たった一つの目的へと向かっている——それは他者に自らを傷つけさせること。いや、むしろ、容赦なく傷つけさせることだ。"
  },
  Skill_4297_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4297_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。レーアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4297_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4297_Name = {Text = "攻撃"},
  Skill_4297_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4298_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4298_Name = {Text = "遺恨"},
  Skill_4299_Desc = {
    Text = "1点の行動力を獲得。"
  },
  Skill_4299_Name = {Text = "算力"},
  Skill_4300_Desc = {
    Text = "すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_4300_Name = {Text = "易傷"},
  Skill_4301_Desc = {
    Text = "カードを1枚引く。"
  },
  Skill_4302_Desc = {
    Text = "他の覚醒体は<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_4302_Name = {Text = "触媒"},
  Skill_4303_Desc = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を1枚山札に追加する。"
  },
  Skill_4303_Name = {Text = "啓示"},
  Skill_4304_Desc = {
    Text = "すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与。"
  },
  Skill_4305_Desc = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_4305_Name = {Text = "狂気"},
  Skill_4306_AwakerSkillBackgroundStory = {
    Text = "彼女は地上で神の名において行動する。\n彼女は神が受けるにふさわしい名声を得る。\n彼女は滅びの時に、誰も耐えられない痛みを受ける。\nそれこそが代行者である。"
  },
  Skill_4306_Desc_0 = {
    Text = "ミリアムは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕の上限と触腕数+1。すべての敵に1点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与。ミリアムの「攻撃」と「至高の生贄」のクリティカル率が100%増加する。<O07CardKeyWord4:「信仰の岐路」>を1枚手札に追加する。"
  },
  Skill_4306_Desc_15 = {
    Text = "ミリアムは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕の上限と触腕数+1、すべての敵に1点の<WeaknessIconKeywords:脆弱>と<VulnerabilityIconKeywords:易傷>を付与。ミリアムの「攻撃」と「至高の生贄」のクリティカル率が100%増加する。<O07CardKeyWord4:「信仰の岐路」>を1枚手札に追加する。「聖礼」を2枚変換するたび、「神国の幻影」を1枚手札に追加する。"
  },
  Skill_4306_EffectNameList = {Text = "狂気"},
  Skill_4306_Name = {
    Text = "信仰の証明"
  },
  Skill_4307_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4308_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4309_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の症状<DerivativeCardKeywords_9:「憂鬱」>を山札のランダムな位置に追加する。"
  },
  Skill_4309_Name = {
    Text = "無声の叫び"
  },
  Skill_4310_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。相手はターン終了まで[Arg3]の<PowerIconKeywords:力>を失う。"
  },
  Skill_4311_AwakerSkillBackgroundStory = {
    Text = "柔らかな触れ合いで、愛を感じる？\n温かな吐息で、私に溺れる？\n珠玉と軽やかな布に包まれた愛撫は、あなたにとって贈り物？"
  },
  Skill_4311_Desc_0 = {
    Text = "他の覚醒体を1体選択し、自身とその覚醒体がそれぞれ<Energy:[Energy:Arg1]>狂気を獲得。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4311_EffectNameList = {Text = "狂気,力"},
  Skill_4311_Name = {
    Text = "古の愛撫"
  },
  Skill_4311_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4313_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4314_AwakerSkillBackgroundStory = {
    Text = "彼女の血は彼らのために熱くたぎり彼女の脳は彼らのために沸騰する——これら異形の子が彼女の願いを叶えようと叶えまいと、彼らが虚無の中で存続できようとできまいと。\n\nタイスは愛を込めて、すべての聖純の子の誕生を迎える。"
  },
  Skill_4314_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：他の覚醒体に<Energy:[Energy:Arg1]>狂気を付与。】すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、[Arg3]%の<BleedingIconKeywords:出血>を付与し、[Arg4]%の<IntoxicationIconKeywords:毒>を付与し、[Arg5]%の<RetaliateIconKeywords:反撃>を獲得。手札の非派生指令カードを1枚選び、その[Arg7]枚の未強化コピーを<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を付けて手札に追加し、行動力消費を-[Arg6]する。"
  },
  Skill_4314_EffectNameList = {
    Text = "狂気,ダメージ,出血パーセント,毒パーセント,反撃パーセント"
  },
  Skill_4314_Name = {
    Text = "豊穣の儀"
  },
  Skill_4314_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：他の覚醒体に <Energy:[Energy:Arg1]> 点の狂気を付与する。】全ての敵に <Damage:[Damage:Arg2]> 点のダメージを与え、ダメージの [Arg3]% の<BleedingIconKeywords:出血>を与え、ダメージの [Arg4]% の<IntoxicationIconKeywords:毒>を付与し、ダメージの [Arg5]% の<RetaliateIconKeywords:反撃>を獲得する。手札の非派生指令カードを1枚選び、<DepleteIconKeywords:消費>と<NothingnessIconKeywords:虚無>が付加された原始複製を [Arg7] 枚手札に加え、その行動力消費を -[Arg6] する。次の3ターン内、各ターン開始時に「胚胎」1枚を「聖純の子」に変換し、「胚胎」がない場合は<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg8]し、胚胎融合上昇効果の影響を受けない。"
  },
  Skill_4314_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,$GrowValue3,$GrowValue4,$GrowValue5"
  },
  Skill_4315_AwakerSkillBackgroundStory = {
    Text = "私を守る。\n私を守る。\n私を守る。\n臆病な怪物は彼女と同じように、命があるようで意識がない。\n\n黒い粘液が彼女の従者となり、昼夜を問わず命令に従う。"
  },
  Skill_4315_Desc_0 = {
    Text = "リリーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン開始時、最大ライフの10%の<PainWord:忍耐>を獲得する。リリーがシールドを獲得した後、ライフが最も高い敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4315_Desc_15 = {
    Text = "リリーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン開始時、最大ライフの10%の<PainWord:忍耐>を獲得する。リリーがシールドを付与した時、ライフが最も高い敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。狂気解放を発動後、このターンに攻撃を1回受けるたび、次に使用する「返しの一撃」の消費する<PainWord:忍耐>が40%増加する。最大5回まで累積可能。"
  },
  Skill_4315_EffectNameList = {Text = "狂気,毒"},
  Skill_4315_Name = {
    Text = "粘液の集まり"
  },
  Skill_4315_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4316_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を1枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4316_Name = {Text = "蝋涙"},
  Skill_4317_Desc = {
    Text = "自爆！<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4318_Desc = {
    Text = "戦闘終了後もデッキに残る。売却不可。"
  },
  Skill_4318_Name = {
    Text = "ネバネバする蝋涙"
  },
  Skill_4319_Desc = {
    Text = "すべての味方が<Block:[Block:Arg1]>点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4319_Name = {
    Text = "風のうなり"
  },
  Skill_4320_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4322_AwakerSkillBackgroundStory = {
    Text = "蛾には頭がなく、ただ本能のままに炎へと飛びこむ。\n\nならば見せてやればいい。\n蛾よりも劣るこの者たちに、彼らの欲したものを。\n\nそれは、幼い少女の無垢で夢見がちな幻だった。"
  },
  Skill_4322_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、<DepleteIconKeywords:除外>が付与された<DerivativeCardKeywords_18:「緑炎」>を1枚手札に追加。<TransitionIconKeywords:ワープ>：次のターン開始前まで、攻撃を1回受けるごとに、<DepleteIconKeywords:除外>が付与された<DerivativeCardKeywords_18:「緑炎」>を1枚手札に追加。"
  },
  Skill_4322_EffectNameList_0 = {
    Text = "シールド"
  },
  Skill_4322_Name = {
    Text = "誘蛾の炎"
  },
  Skill_4322_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4323_AwakerSkillBackgroundStory = {
    Text = "オジールの銃の構えは標準的ではないが、彼を指導できる者は皆、時と闇の中に消えてしまった。"
  },
  Skill_4323_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4323_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。オジールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4323_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4323_Name = {Text = "攻撃"},
  Skill_4323_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4324_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4325_AwakerSkillBackgroundStory = {
    Text = "彼が大剣を振り上げると、必ず血と死がもたらされる。"
  },
  Skill_4325_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4325_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ゴリアテは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4325_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4325_Name = {Text = "攻撃"},
  Skill_4325_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4326_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4328_Desc = {
    Text = "すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4328_Name = {
    Text = "毒性汚染"
  },
  Skill_4329_AwakerSkillBackgroundStory = {
    Text = "彼女は故郷の滅びを——知っているすべてが融蝕に飲み込まれて消え去さるのをその目で見届けた。\n\nそれでも探すことをあきらめなかった。\n\n測位システム装置は光を灯し、同じ故郷を持つ誰かを探し続ける。\nきっと、いるはずだ。きっと、いる——"
  },
  Skill_4329_BattleDesc_0 = {
    Text = "<Block:[Block:Arg3]>点のシールドを獲得。すべての手札を捨てる。<TransitionIconKeywords:跳躍>：手札を捨てる代わりに、<Block:[Block:Arg4]>点のシールドを獲得し、カードを1枚引く。"
  },
  Skill_4329_BattleDesc_2 = {
    Text = "<Block:[Block:Arg3]>点のシールドを獲得。すべての手札を捨て、捨てたカード1枚につき、<Block:[Block:Arg2]>点の遅延シールドを獲得。<TransitionIconKeywords:跳躍>：手札を捨てる代わりに、<Block:[Block:Arg4]>点のシールドを獲得し、カードを2枚引く。"
  },
  Skill_4329_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得。すべての手札を捨て、1枚捨てるごとに獲得するシールドが50%上昇。<TransitionIconKeywords:ワープ>：カードを捨てずに1枚引き、獲得するシールドが100%上昇。"
  },
  Skill_4329_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。すべての手札を捨て、捨てたカード1枚につき、獲得するシールドが50%増加する。<Block:[Block:Arg2]>点の遅延シールドを獲得。<TransitionIconKeywords:跳躍>：手札を捨てる代わりに、カードを2枚引く。獲得するシールドが100%増加する。"
  },
  Skill_4329_EffectNameList_0 = {
    Text = "シールド"
  },
  Skill_4329_EffectNameList_2 = {
    Text = "シールド,遅延シールド"
  },
  Skill_4329_Name = {
    Text = "精神再建"
  },
  Skill_4329_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4329_PropertyNameList_2 = {
    Text = "防御力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4332_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4333_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4334_AwakerSkillBackgroundStory = {
    Text = "黒い泥の中で咲く蕾。\nかつては庭師の愛情を受け、雨露の恵みにも包まれていた。\n\nだが今、それは孤独に咲き、烈風に肌を裂かれ、豪雨に身を打たれ、薄く鋭い刃に皮膚を切られ、長く尖った針に骨髄を貫かれる。\n\nどうせ、体内に宿る巨大な怪物が痛みを引き受けてくれるのだ。\n\nもしかすると今や、彼女のそばにいるのはその巨大な怪物だけ――\nこれからは怪物と共に生きるしかない……"
  },
  Skill_4334_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。1ターン持続。"
  },
  Skill_4334_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>の半分を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>付与。1ターン持続。"
  },
  Skill_4334_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%回復し、<PainWord:忍耐>を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。1ターン持続。"
  },
  Skill_4334_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%回復し、<PainWord:忍耐>の半分を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を1点付与する。1ターン持続。"
  },
  Skill_4334_EffectNameList_0 = {
    Text = "シールド, 毒"
  },
  Skill_4334_Name = {
    Text = "泥に咲く不滅の花"
  },
  Skill_4334_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを得る。<PainWord:忍耐>のスタック数の [Arg2]%([Arg3]) 分のライフを回復し、<PainWord:忍耐>を除去する。攻撃を1回受けるたびに、攻撃者に [Poison:Arg4] スタックの<IntoxicationIconKeywords:毒>を1ターン付与する。本戦闘内の忍耐上限が100%上昇し、最大ライフと同じ量の忍耐を得る。消耗付きの「返しの一撃」を2枚手札に加える。"
  },
  Skill_4334_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>の半分を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。この戦闘中、忍耐の上限が100%増加し、最大ライフと同量の忍耐を獲得。「除外」が付与された「返しの一撃」を2枚手札に追加。"
  },
  Skill_4334_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4334_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。1ターン持続。"
  },
  Skill_4334_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得。回復<PainWord:忍耐>層 [Arg2]%([Arg3]) のライフし、<PainWord:忍耐>の半分を解除する。1 回攻撃を受けるたびに、攻撃者に<IntoxicationIconKeywords:ポイズン>の [Poison:Arg4] 層を付与し、1 ターン持続。"
  },
  Skill_4334_tempBattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>を半分除去する。攻撃を1回受けるたび、攻撃者に [Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。1ターン持続。このターンに攻撃を1回受けるたび、次に使用する「返しの一撃」で消費する<PainWord:忍耐>が40%増加する。最大5回まで累積可能。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_1 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを得る。<PainWord:忍耐>のスタック数の [Arg2]%([Arg3]) 分のライフを回復し、<PainWord:忍耐>を除去する。攻撃を1回受けるたびに、攻撃者に [Poison:Arg4] スタックの<IntoxicationIconKeywords:毒>を1ターン付与する。本戦闘内の忍耐上限が100%上昇し、最大ライフと同じ量の忍耐を得る。消耗付きの「返しの一撃」を2枚手札に加える。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>の半分を除去する。攻撃を1回受けるたび、攻撃者に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。この戦闘中、忍耐の上限が100%増加し、最大ライフと同量の忍耐を獲得。「除外」が付与された「返しの一撃」を2枚手札に追加。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ライフを<PainWord:忍耐>の点数の[Arg2]%([Arg3])回復し、<PainWord:忍耐>を半分除去する。攻撃を1回受けるたび、攻撃者に [Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。1ターン持続。この戦闘中、忍耐の上限が100%増加し、最大ライフと同量の忍耐を獲得。「除外」が付与された「返しの一撃」を2枚手札に追加する。このターンに攻撃を1回受けるたび、次に使用する「返しの一撃」で消費する<PainWord:忍耐>が40%増加する。最大5回まで累積可能。"
  },
  Skill_4336_Desc = {
    Text = "すべての味方に[Arg1]点の<ParcloseIconKeywords:バリア>を付与する。"
  },
  Skill_4336_Name = {
    Text = "全体バリア"
  },
  Skill_4337_AwakerSkillBackgroundStory = {
    Text = "デクスター卿は、娘に古典的な剣術を習わせた当初、その技術によって娘の気質が改善されることを期待しただけだと断言したが——ラモンナ自身は、明らかにそれ以上のものを求めていた。"
  },
  Skill_4337_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4337_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ラモンナは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4337_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4337_Name = {Text = "攻撃"},
  Skill_4337_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4338_Desc = {
    Text = "味方全体が[Arg1]<PowerIconKeywords:力>を獲得し、前進する。"
  },
  Skill_4338_Name = {
    Text = "全体の力"
  },
  Skill_4339_AwakerSkillBackgroundStory = {
    Text = "誰かが冗談半分でアイギスにマフラーを編んでくれないかと尋ねたことがある。彼女には毛糸針から毛糸まで揃っていたから。\n\nアイギスは恥ずかしそうに頭を下げた。\n彼女は、頭の毛糸針が装飾ではなく、彼女の目の力を抑える特別な道具であることを誰にも言わなかった。\n\n数日後、彼女は借りた毛糸針でカラフルなマフラーを完成させた。"
  },
  Skill_4339_Desc_0 = {
    Text = "エイジスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：エイジスがカードを出した後、すべての敵に[Arg2]ターンの<VulnerabilityIconKeywords:易伤>を付与する。"
  },
  Skill_4339_Desc_15 = {
    Text = "アイギスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：アイギスの指令カードを使用した後、すべての敵に[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与。アイギスが狂気爆発を発動後、自身の次の「防御」を3回発動させ、さらに狂気爆発の基礎ダメージを50%増加させる。"
  },
  Skill_4339_EffectNameList = {Text = "狂気"},
  Skill_4339_Name = {
    Text = "停滞の呪い"
  },
  Skill_4340_Desc = {
    Text = "[Arg3]点の一時的な<PowerIconKeywords:力>を獲得し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ライフを失うと、一時的な<PowerIconKeywords:力>のボーナスを失う。"
  },
  Skill_4340_Name = {
    Text = "喉切り（弱点）"
  },
  Skill_4341_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4342_AwakerSkillBackgroundStory = {
    Text = "「街頭ネズミ」と呼ばれる子供たちが鼠を受け入れたのか、本物の鼠がストリートチルドレンを受け入れたのか……生きるために生まれたこの絆は、年月とともに揺るぎないものとなった。\n\n動物こそ、人間にとって最良の友——そう言えない理由があるだろうか？"
  },
  Skill_4342_Desc = {
    Text = "<DepleteIconKeywords:除外>が付与された、行動力消費が0の「ブラウン出撃！」を[Arg1]枚手札に追加。一時的なクリティカルダメージが+[Arg2]％増加。"
  },
  Skill_4342_EffectNameList = {
    Text = "一時的なクリティカルダメージ"
  },
  Skill_4342_Name = {
    Text = "霧都の街童"
  },
  Skill_4342_OverLimitUtlSkillDesc = {
    Text = "<DepleteIconKeywords:除外>が付与された、行動力消費が0の「ブラウン出撃！」を[Arg1]枚手札に追加。一時的なクリティカルダメージが+[Arg2]％増加。<DepleteIconKeywords:除外>が付与された「超大集結！」を1枚手札に追加する。"
  },
  Skill_4343_AwakerSkillBackgroundStory = {
    Text = "戦場で彼は無敵であり、大剣を振るうと敵は総崩れとなる。"
  },
  Skill_4343_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4343_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ゴリアテは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4343_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4343_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4344_AwakerSkillBackgroundStory = {
    Text = "歌声は彼女の盾。\nだがその盾は、怒鳴り声に潜む侮辱と軽蔑を防ぐことはできなかった。"
  },
  Skill_4344_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4344_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを2回獲得。<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：追加で狂気を1回獲得。"
  },
  Skill_4344_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ティンクトは<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_4344_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを2回獲得。ティンクトは<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：追加で狂気を1回獲得。"
  },
  Skill_4344_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4344_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4345_Desc = {
    Text = "レーアは一定量のライフを失うたび、最大ライフと同量のシールドを獲得する。"
  },
  Skill_4345_Name = {
    Text = "血を渇望する者"
  },
  Skill_4346_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後退する。"
  },
  Skill_4347_Desc = {
    Text = "毎ターン[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4347_Name = {
    Text = "古代の呼び声"
  },
  Skill_4348_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<ParcloseIconKeywords:バリア>を獲得する。プレイヤーのターン終了前に手札1枚につき追加で[Arg4]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_4348_Name = {Text = "試み"},
  Skill_4349_AwakerSkillBackgroundStory = {
    Text = "漆黒の粘液が彼女を深淵に引きずり込む。\n星々はここで生まれ、光はここで消える。\nここには時間も生命もない。\n\n遠くから声が近づいてきた——黒い光を放ちながら。\n\nそれは言った——\n「あなたは永遠に変わり果てる。妖精の通路を訪れてしまったから」\n彼女はここで長くさまようことになる。"
  },
  Skill_4349_Desc_0 = {
    Text = "ジェンキンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：クリティカル率が[Arg2]%増加。ジェンキンがダメージを1回与えるたび、一時的なクリティカルダメージ+[Arg3]%。毎ターン最大5回まで累積可能。"
  },
  Skill_4349_Desc_15 = {
    Text = "ジェンキンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：クリティカル率が[Arg2]%増加。ジェンキンがダメージを1回与えるたび、一時的なクリティカルダメージ+[Arg3]%。毎ターン最大5回まで重複可能。「空間歪曲」と「霧都の浮浪児」のクリティカルダメージ効果が2倍になる。"
  },
  Skill_4349_EffectNameList = {Text = "狂気"},
  Skill_4349_Name = {
    Text = "空間歪曲"
  },
  Skill_4350_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4351_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_27:「症状：意識障害」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4351_Name = {
    Text = "泣き叫ぶ！"
  },
  Skill_4352_Desc = {
    Text = "「干渉型融蝕生物」に進化する。現在のライフが高いほど進化後の敵はより強くなる。"
  },
  Skill_4352_Name = {
    Text = "融蝕の進化"
  },
  Skill_4353_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、ターン終了時に[Arg2]点の<PowerIconKeywords:力>が減少する。"
  },
  Skill_4353_Name = {
    Text = "枷：彷徨う刃"
  },
  Skill_4354_Desc = {
    Text = "すべての味方を吸収し同量のライフを回復する。[Arg1]<PowerIconKeywords:力>を獲得し、「お前のせいだ」を1体吸収するごとに<PowerIconKeywords:力>を[Arg2]追加で獲得する。"
  },
  Skill_4354_Name = {Text = "吸収"},
  Skill_4356_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4356_Name = {
    Text = "小さな希望"
  },
  Skill_4357_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4357_Name = {
    Text = "融蝕を抱く"
  },
  Skill_4358_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4359_Desc = {
    Text = "すべての敵に[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、対象の毒効果を誘発する。"
  },
  Skill_4359_Name = {
    Text = "毒性発作"
  },
  Skill_4360_AwakerSkillBackgroundStory = {
    Text = "あらあら、抵抗しちゃダメよ～"
  },
  Skill_4360_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4360_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4360_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。パンディアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4360_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。パンディアは<Energy:[Energy:Arg2]>狂気を獲得。[Counterattack:Arg3] 点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4360_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4360_EffectNameList_1 = {
    Text = "シールド,狂気,反撃"
  },
  Skill_4360_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4360_PropertyNameList_1 = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4361_AwakerSkillBackgroundStory = {
    Text = "揺籃の中の少女は、見たことのない花を夢見るのだろうか？\nそれはどんな花だろう？彼女のように、限られた空間で、掌ほどの鉢で芽吹くのだろうか？\nそれとも妹の歌のように、星の海に咲き、宇宙の塵と星の流れに乗って未知の遠方へと運ばれるのだろうか？"
  },
  Skill_4361_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：<DepleteIconKeywords:除外>が付与された行動力消費0の「幼芽萌生」を1枚手札に追加する。すべての敵に2点の<WeaknessIconKeywords:虚弱>を付与。】[Counterattack:Arg1]点の<RetaliateIconKeywords:反撃>を獲得。<DeathResistanceIconKeywords:死亡抵抗>が[Arg2]%未満の場合、死亡抵抗+[Arg3]%。自身の<FragileIconKeywords:脆弱>を解除。"
  },
  Skill_4361_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：<DepleteIconKeywords:除外>が付与された行動力消費0の「幼芽萌生」を1枚手札に追加する。すべての敵に2点の<WeaknessIconKeywords:虚弱>を付与。】[Counterattack:Arg1]点の<RetaliateIconKeywords:反撃>を獲得。<DeathResistanceIconKeywords:死亡抵抗>が[Arg2]%未満の場合、死亡抵抗+[Arg3]%。自身の<FragileIconKeywords:脆弱>を解除。"
  },
  Skill_4361_EffectNameList_0 = {
    Text = "反撃,死亡抵抗上限,死亡抵抗"
  },
  Skill_4361_Name = {
    Text = "星のゆりかご"
  },
  Skill_4361_OverLimitUtlSkillDesc = {
    Text = "[<DevouredIconKeywords:捕食>：行動力消費0の「幼芽萌生」を1枚手札に加え、<DepleteIconKeywords:消費>を付与する。全ての敵に<WeaknessIconKeywords:虚弱>を2ターン付与する。][Counterattack:Arg1]層の<RetaliateIconKeywords:カウンター>を獲得する。<DeathResistanceIconKeywords:デスレジスタンス>が[Arg2]％未満の場合、+[Arg3]％を得る。自身の<FragileIconKeywords:脆弱>を解除する。すべての敵に[Exhaustion:Arg5]点の<ExhaustionIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4361_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4362_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、山札と捨て札の中からランダムに[Arg2]枚のカードに「<SlowIconKeywords:鈍化>」を付与する。"
  },
  Skill_4362_Name = {
    Text = "遅効性薬剤"
  },
  Skill_4363_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身を生贄として献上する。狂気の影響を受けない。"
  },
  Skill_4363_Name = {Text = "献上"},
  Skill_4364_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！"
  },
  Skill_4365_AwakerSkillBackgroundStory = {
    Text = "ある者は身体と魂が永遠に一体であるべきだと固執し、またある者は肉体を失った後に彷徨う精神が滅びることを恐れる。\nドールにとって疑問に答えるのは面倒なことであり、彼女は次々と人形の体を入れ替えることで手術の成功を証明することを選んだ。"
  },
  Skill_4365_Desc = {
    Text = "<Heal:[Heal:Arg1]>ライフを回復。すべての敵に[Arg2]点の<WeaknessIconKeywords:倦怠>を与える。"
  },
  Skill_4365_EffectNameList = {Text = "回復"},
  Skill_4365_Name = {
    Text = "外界手術"
  },
  Skill_4365_PropertyNameList = {
    Text = "体力×GrowValue1,"
  },
  Skill_4366_AwakerSkillBackgroundStory = {
    Text = "歌声は彼女の武器。\nその武器は満天の星の下、孤独な放浪に寄り添い続けた。"
  },
  Skill_4366_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4366_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを 2 回与える。<Energy:[Energy:Arg2]> 点の狂気を獲得する。<TransitionIconKeywords:跳躍>：追加で 1 回ダメージを与える。"
  },
  Skill_4366_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ティンクトが<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4366_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを 2 回与える。ティンクトは <Energy:[Energy:Arg2]> 点の狂気を獲得する。<TransitionIconKeywords:跳躍>：追加で 1 回ダメージを与える。"
  },
  Skill_4366_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4366_Name = {Text = "攻撃"},
  Skill_4366_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4367_AwakerSkillBackgroundStory = {
    Text = "リッツは緑炎を得たあの日の情景をまだ覚えている。\n\n手の中で青い火種がで燃え上がり、長く抑え込んできた願いを果たせと彼女を駆り立てた。"
  },
  Skill_4367_Desc = {
    Text = "ランダムな敵に<Damage:[Damage:Arg2]><PunctureDamagewords:刺突ダメージ>を[Arg1]回与え、50%ダメージ分の<IntoxicationIconKeywords:毒>を付与。行動力不足時でも強制的に使用可能、効果は<Energy:[Energy:Arg3]>狂気を獲得し除外に変更。"
  },
  Skill_4367_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4367_Name = {
    Text = "死滅の緑炎"
  },
  Skill_4367_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4368_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4368_Name = {Text = "叩く"},
  Skill_4371_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージと同量のライフを回復する。<DerivativeCardKeywords_34:「満たされぬ痛み」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_4371_Name = {
    Text = "苦痛と血"
  },
  Skill_4372_Desc = {
    Text = "双方それぞれに[Arg1]点の<VulnerabilityIconKeywords:軟化>を付与する。「利刃Ⅱ」を獲得する：ガードされなかったダメージを与えた場合、山札の上に<DerivativeCardKeywords_23:「傷口」>を2枚追加する。この効果は1ターン持続する。"
  },
  Skill_4372_Name = {
    Text = "最期のあがき"
  },
  Skill_4373_AwakerSkillBackgroundStory = {
    Text = "彼女の胸鰭は航路を切り開き、尾鰭は港を打ち砕く。\n誰も戦えなくなった後、巨鯨は混沌の中で熟睡し、星を新たな生命に託した。"
  },
  Skill_4373_BattleDesc_0 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>状態を解除する。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。この戦闘中「打撃」を1枚使用するごとにダメージ+[Arg2]。"
  },
  Skill_4373_BattleDesc_3 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。この戦闘中、「攻撃」を1枚使用するたび、ダメージ+[Arg2]。<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「攻撃」を2枚手札に追加する。"
  },
  Skill_4373_Desc_0 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>状態を解除する。すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中「打撃」を1枚使用するごとにダメージ+[Arg2]。"
  },
  Skill_4373_Desc_15 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。この戦闘中、「攻撃」を1枚使用するたび、ダメージ+[Arg2]。<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「攻撃」を2枚手札に追加する。"
  },
  Skill_4373_Desc_3 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>を解除。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。この戦闘中、「攻撃」を1枚使用するたび、ダメージ+[Arg2]。<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与された「攻撃」を2枚手札に追加する。"
  },
  Skill_4373_EffectNameList = {
    Text = "ダメージ,ダメージ"
  },
  Skill_4373_Name = {
    Text = "混沌の獣"
  },
  Skill_4373_OverLimitUtlSkillDesc_0 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>ステータスを解除する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを与える。本戦闘中「打撃」を 1 枚発射するごとにダメージ+ [Arg2] 。全ての敵に追加で 1 回、対象の最大ライフの 15% の<FixedDamage:純粋ダメージ>を与える。本戦闘中「混沌の獣」の基礎ダメージが 100% 上昇する。"
  },
  Skill_4373_OverLimitUtlSkillDesc_3 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>ステータスを解除する。全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg3] 回与える。本戦闘中「打撃」を 1 枚発射するごとにダメージ+ [Arg2] 。<DepleteIconKeywords:消耗>と<NothingnessIconKeywords:虚無>が付加された「打撃」を 2 枚手札に加える。全ての敵に追加で 1 回、対象の最大ライフの 15% の<FixedDamage:純粋ダメージ>を与える。本戦闘中「混沌の獣」の基礎ダメージが 100% 上昇する。"
  },
  Skill_4373_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4374_Desc = {
    Text = "ちょっとした小傷、大したことはない。[Arg1] 点の<FixedDamage:純粋ダメージ>を受け、カードを [Arg3] 枚引く。"
  },
  Skill_4374_Name = {Text = "傷口"},
  Skill_4375_AwakerSkillBackgroundStory = {
    Text = "一歩一歩、彼女はゆっくりと海中へ足を踏み入れてゆく。\n夜の海は肌に触れると少し冷たさをおぼえていたのだが――今やまるで、人のぬくもりにも似た優しさに満ちていた。\n\n海は私を受け入れてくれた——\nそんな思いがニムフィーアの心に静かに浮かぶ。\nふと、両親の笑顔が目に映る。\n——あの海の奥底には、きっと家族の安らぎがあるのだろう。"
  },
  Skill_4375_Desc_0 = {
    Text = "ニムフィーアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ニムフィーアのカードを使用した後、<Energy:[Energy:Arg2]>狂気を獲得。ターン終了時、ニムフィーアの付与する毒が[Arg3]%増加する。"
  },
  Skill_4375_Desc_15 = {
    Text = "ニムフィーアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ニムフィーアがカードを使用した後、<Energy:[Energy:Arg2]>狂気を獲得。ターン終了時、ニムフィーアが付与する毒が[Arg4]%増加する。"
  },
  Skill_4375_EffectNameList = {
    Text = "狂気,カード使用時狂気獲得,毒成長"
  },
  Skill_4375_Name = {
    Text = "苦海に沈む"
  },
  Skill_4376_AwakerSkillBackgroundStory = {
    Text = "「来ないで、傷つけたくない！」"
  },
  Skill_4376_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4376_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。対象の<VulnerabilityIconKeywords:易傷>1点につき、<EmbryoFusionIconKeywords:胚胎融合>+[Arg3]。最大[Arg4]まで。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4376_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。アイギスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4376_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。対象の<VulnerabilityIconKeywords:易傷>1点につき、<EmbryoFusionIconKeywords:胚胎融合>+[Arg3]。最大[Arg4]まで。アイギスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4376_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4376_Name = {Text = "攻撃"},
  Skill_4376_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4377_AwakerSkillBackgroundStory = {
    Text = "不敬な者、無礼な者、冒涜する者は、永遠の国に行く資格がない。"
  },
  Skill_4377_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4377_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。触腕1本に2回攻撃させ、50%のダメージを与える。"
  },
  Skill_4377_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ファロスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4377_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ファロスは<Energy:[Energy:Arg2]>狂気を獲得。触腕1本に2回攻撃させ、50%のダメージを与える。"
  },
  Skill_4377_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4377_Name = {Text = "攻撃"},
  Skill_4377_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4378_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4379_AwakerSkillBackgroundStory = {
    Text = "宣告：\n芸術の美を感じ取れない凡庸なる者よ。\n舞い手の苦しみに歓喜する狂信者よ。\n名声と富を貪る哀れな者よ。\n\nこれがあなたたちの終焉だ。\n\n死告の舞いを捧げ、緑炎で魂を浄化し、優美な炎で穢れた心を洗い流そう。\n\n永遠の浄土で再会しよう。"
  },
  Skill_4379_Desc_0 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。手札にあるすべてのリッツのカードを捨て、それらの効果を発動。"
  },
  Skill_4379_Desc_3 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。手札にあるすべてのリッツのカードを捨て、それらの効果を発動。2枚捨てるごとに、カードを1枚引く。"
  },
  Skill_4379_EffectNameList = {Text = "力"},
  Skill_4379_Name = {
    Text = "死告の舞い"
  },
  Skill_4379_OverLimitUtlSkillDesc_0 = {
    Text = "手札の全ての「緑炎」と「腐敗の緑炎」を「死滅の緑炎」にアップグレードし、その後 [Arg2] ターンの間、毎ターン開始時にこの効果を1回繰り返す。[Arg1] 点の一時的な<PowerIconKeywords:力>を得る。手札の全てのリッツのカードを捨て、それらの効果を発動する。"
  },
  Skill_4379_OverLimitUtlSkillDesc_3 = {
    Text = "手札にあるすべての「緑炎」と「腐敗の緑炎」を「死滅の緑炎」にアップグレードし、[Arg2]ターンの間、ターン開始時にこの効果を1回繰り返す。[Arg1]点の一時的な<PowerIconKeywords:力>を獲得。手札にあるすべてのリッツのカードを捨て、それらの効果を発動。2枚捨てるごとに、カードを1枚引く。"
  },
  Skill_4379_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4380_Desc = {
    Text = "サラのライフを[Arg1]点回復する。"
  },
  Skill_4380_Name = {Text = "回復"},
  Skill_43819_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_43819_Name = {Text = "覚醒"},
  Skill_4381_AwakerSkillBackgroundStory = {
    Text = "変異の刻は、すでに訪れた。\n継承者とは、凡人よりもはるかに高貴なる存在。\n家族を捨て、\n友を捨て、\n痛みを捨て、\n過去のすべてを捨て去ることで——\n私は栄光の加護を得るのだ。\n彼の体は、びっしりと鱗と棘に覆われていた。"
  },
  Skill_4381_Desc_0 = {
    Text = "カエクスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。カエクスのカードを1枚使用するたび、ライフを<Heal:[Heal:Arg2]>回復し、[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4381_Desc_15 = {
    Text = "カエクスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。カエクスのカードを1枚使用するたび、ライフを<Heal:[Heal:Arg2]>回復し、[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得する。触腕1本に敵を攻撃させ、[Arg4]%の反撃を獲得。"
  },
  Skill_4381_EffectNameList = {
    Text = "狂気,回復,反撃"
  },
  Skill_4381_Name = {
    Text = "変身する体"
  },
  Skill_4381_PropertyNameList = {
    Text = "$GrowValue1,体力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4382_Desc = {
    Text = "1体の覚醒体を注視する。注視された覚醒体のカードを使用するとカードを2枚引く。"
  },
  Skill_4382_Name = {
    Text = "狩りの視線"
  },
  Skill_4383_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4383_Name = {Text = "明滅"},
  Skill_4384_AwakerSkillBackgroundStory = {
    Text = "禁欲と抑圧の地ほど、少女の支配力は驚異的。\n\n響く鞭は甘い愛の言葉、熱い蝋は熱いキスの代わり、\n緊縛は細やかな配慮、赤い傷跡は愛の証。\n\n蜜色の悲惨な幻影の中、少女の鈴のような笑い声が響く。"
  },
  Skill_4384_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを2回与え、<RetaliateIconKeywords:反撃>1層につきダメージが[Arg2]点増加する。[Power:Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4384_Desc_3 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを2回与える。<RetaliateIconKeywords:反撃>1点につき、ダメージが[Arg2]増加する。[Power:Arg3]点の<PowerIconKeywords:力>と[Counterattack:Arg4]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4384_EffectNameList_0 = {
    Text = "ダメージ,力"
  },
  Skill_4384_EffectNameList_3 = {
    Text = "ダメージ,力,反撃"
  },
  Skill_4384_Name = {
    Text = "蜂蜜色の幻想惨劇"
  },
  Skill_4384_OverLimitUtlSkillDesc = {
    Text = "すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与し、<Damage:[Damage:Arg1]>ダメージを2回与える。<RetaliateIconKeywords:反撃>1点につき、ダメージが[Arg2]増加する。[Arg3]点の<PowerIconKeywords:力>と[Counterattack:Arg5]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4384_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4384_PropertyNameList_3 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4385_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4386_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4387_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_4388_AwakerSkillBackgroundStory = {
    Text = "数え切れない輪廻の中で、彼女は原因を自らに結びつけ、因果の沼に深く沈んでいった。\nパラドックスが彼女の身体を引き裂き、混沌が彼女の魂を満たす中、無限の苦痛の中で彼女は「未知」から漏れた一筋の微光を掴んだ。"
  },
  Skill_4388_Desc_0 = {
    Text = "環行・ラモンナは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：環行・ラモンナの指令カードを使用し、<TimeBeacon:ループ>効果が発動しなかったとき、1点の<TimeBeacon2:ネゲントロピー>を獲得し、<Posse:[Arg2]>キーエネルギーを獲得する。毎ターン最大3回まで発動可能。"
  },
  Skill_4388_Desc_15 = {
    Text = "環行・ラモンナは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：環行・ラモンナが<TimeBeacon:ループ>未発動のカードを使用した後、1点の<TimeBeacon2:ネゲントロピー>を獲得し、<Posse:[Arg2]>点の銀鍵エネルギーを獲得する。<TimeBeacon:ループ>発動のカードを使用した後、50点の銀鍵エネルギーを獲得する。"
  },
  Skill_4388_EffectNameList = {Text = "狂気"},
  Skill_4388_Name = {
    Text = "エントロピー逆行"
  },
  Skill_4389_AwakerSkillBackgroundStory = {
    Text = "「私は暗闇なんて怖くない！このランプはただの照明ってだけ」"
  },
  Skill_4389_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4389_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4389_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4390_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身は[Arg3]点の「蝋質のコーティング」を獲得する：状態異常を無効化し、クリティカルを受けるたびに1点減少する。"
  },
  Skill_4390_Name = {
    Text = "蝋人形登場"
  },
  Skill_4391_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与える。[Arg2]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4392_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4392_Name = {Text = "重撃"},
  Skill_4393_AwakerSkillBackgroundStory = {
    Text = "詩集が初めて出版された日、庭師は喜びに満ちて一輪のバラを持ってきた。\n\n彼女はそのバラを大切にしまい込んだ。\n庭が衰退する前、それはこの幻想の最も美しいクライマックスだった。"
  },
  Skill_4393_BattleDesc = {
    Text = "選択した1名の他の覚醒体に<Energy:[Energy:Arg1]>狂気を与える。<TransitionIconKeywords:跳躍>：感情「喜」に切り替える。"
  },
  Skill_4393_Desc = {
    Text = "選択した1名の他の覚醒体に<Energy:[Energy:Arg1]>狂気を与える。<TransitionIconKeywords:跳躍>：感情「喜」に切り替える。隠喩「喜」を1点消費するごとに、追加で<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4393_EffectNameList = {Text = "狂気"},
  Skill_4393_Name = {
    Text = "幻夢の詩篇"
  },
  Skill_4394_Desc = {
    Text = "[Arg1]層の空虚を付与する。"
  },
  Skill_4394_Name = {
    Text = "狂気吸収"
  },
  Skill_4395_Desc = {
    Text = "味方全体のライフを[Arg1]点回復する。"
  },
  Skill_4395_Name = {Text = "回復"},
  Skill_4396_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4396_Name = {Text = "試み"},
  Skill_4397_AwakerSkillBackgroundStory = {
    Text = "我らは運命の三姉妹\n空を、地を、海を駆けるこだま\n決して分かたれぬ、連なる雨\n長き夜が明けるまで、何も我らを引き裂けない"
  },
  Skill_4397_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4397_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。「24」は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4397_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4397_Name = {
    Text = "異種共生"
  },
  Skill_4397_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4398_AwakerSkillBackgroundStory = {
    Text = "賭けて、賭けて、思い切り賭ける。\n\nタキシードの給仕が合図をし、対面のプレイヤーが額の汗を拭い、頭上の時計の針が0時を過ぎた。\n\n騒がしい群衆の中で、無数の細部が彼の目に入り、計算せずとも正しい結論に導かれる。\n\nその最終的な破滅が訪れるまでは、彼は無敗だった。"
  },
  Skill_4398_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。ランダムにカードを1〜[Arg3]枚引き、1枚引くごとに[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4398_EffectNameList_0 = {
    Text = "ダメージ,力"
  },
  Skill_4398_Name = {
    Text = "オールイン"
  },
  Skill_4398_OverLimitUtlSkillDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを3回与える。ランダムにカードを1〜[Arg3]枚引き、1枚引くごとに[Power:Arg2]点の<PowerIconKeywords:力>を獲得し、引いたカードの行動力消費を-1。"
  },
  Skill_4398_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4400_AwakerSkillBackgroundStory = {
    Text = "作品に没頭しよう。創作でも鑑賞でも、無限の慰めを与えてくれる。"
  },
  Skill_4400_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_4400_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。サンガーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4400_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4400_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4401_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、敵を捕食し、相手の次のターンのドローをスキップさせ抵抗不能の封印を付与するが、「次元の裂け目」のカードを手札に追加する。"
  },
  Skill_4401_Name = {
    Text = "現世の裂け目"
  },
  Skill_4402_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4403_AwakerSkillBackgroundStory = {
    Text = "無数の歯車が噛み合い、互いに駆動し、磁器のような外殻に生命を模倣する能力を与える。\n\nそれは彼女が最も誇る作品——複製不可能な精巧な装置。\n\nエリカは、この自分と同じ名を持つオートマタが、やがて自らの第二の命となるとは想像もしていなかった。"
  },
  Skill_4403_Desc_0 = {
    Text = "エリカは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：エリカがダメージを与えた後、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。エリカがシールドを獲得した後、[Arg3]点の一時的な<AlertIconKeywords:警戒>を獲得。"
  },
  Skill_4403_Desc_15 = {
    Text = "エリカは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：エリカがダメージを与えた後、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。エリカがシールドを獲得した後、[Arg3]点の一時的な<AlertIconKeywords:警戒>を獲得。狂気解放「電磁爆破」を発動するたび、獲得する力と警戒ボーナスが1倍増加する。"
  },
  Skill_4403_EffectNameList = {
    Text = "狂気,力,警戒"
  },
  Skill_4403_Name = {
    Text = "変数の最適化"
  },
  Skill_4403_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,防御力×GrowValue3"
  },
  Skill_4404_AwakerSkillBackgroundStory = {
    Text = "彼女の礼儀作法は、混ざり合った物だった。\n宮廷で少し学び、市井で見聞きし、最初の神殿で教え込まれた。"
  },
  Skill_4404_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4404_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4404_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。タイスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4404_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。タイスは<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4404_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4404_EffectNameList_3 = {
    Text = "シールド,狂気"
  },
  Skill_4404_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4404_PropertyNameList_3 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4405_AwakerSkillBackgroundStory = {
    Text = "「私は暗闇なんて怖くない！このランプはただの照明ってだけ」"
  },
  Skill_4405_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ジェンキンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4405_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4405_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4407_AwakerSkillBackgroundStory = {
    Text = "彼女の肌は緑がかり、腐敗した血管がねじれ、絡み合う。\n肩は何かを孕んでいるかのようで——漆黒の液体が腕を伝い、手術台へ広がる。\n\n生まれたばかりの血肉が傷口から花開く。\n争うように、しかし静かに、柔らかく——\n\n虚ろな少女が微笑む。\n「やっとまた会えたね、@2」"
  },
  Skill_4407_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。次のターン開始まで、ライフを2点失うごとに、次のターン開始時にシールドを1点獲得する。"
  },
  Skill_4407_Desc_1 = {
    Text = "ランダムに<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を[Arg2]回与える。次のターン開始まで、ライフを2失うごとに、次のターン開始時に1点のシールドを獲得する。"
  },
  Skill_4407_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4407_Name = {
    Text = "苦痛と歓喜"
  },
  Skill_4407_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4408_AwakerSkillBackgroundStory = {
    Text = "人類が知る光のスペクトルには存在しない光。\n\nオーロラのように彩り豊かで、オーロラのように手の届かない、そしてオーロラのように儚く消える。"
  },
  Skill_4408_Desc_0 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。一時的なクリティカル率+[Arg2]%。この戦闘中、ティンクトの「攻撃」の基礎ダメージが[Arg3]%増加する。ターン終了まで、ランダムな手札5枚の行動力消費を1減少させる。"
  },
  Skill_4408_Desc_3 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。一時的なクリティカル率とクリティカルダメージ+[Arg2]%。この戦闘中、ティンクトの「攻撃」の基礎ダメージが[Arg3]%増加する。ターン終了まで、ランダムな手札5枚の行動力消費を1減少させる。"
  },
  Skill_4408_EffectNameList_0 = {Text = "力"},
  Skill_4408_Name = {
    Text = "星の極光"
  },
  Skill_4408_OverLimitUtlSkillDesc_0 = {
    Text = "[Arg1] 点の<PowerIconKeywords:力>を得る。一時的なクリティカルレート +[Arg2]%。本戦闘内、ティンクトの「打撃」の基礎ダメージが [Arg3]% 上昇する。ランダムな5枚の手札の行動力消費をターン終了まで0にする。"
  },
  Skill_4408_OverLimitUtlSkillDesc_3 = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。一時的なクリティカル率とクリティカルダメージ+[Arg2]％。本戦闘中、ティンクトの「打撃」基礎ダメージが[Arg3]％上昇。ランダムな手札5枚の算力消費を回合終了まで0にする。"
  },
  Skill_4408_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4409_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4410_AwakerSkillBackgroundStory = {
    Text = "神の国、ユートピア、永遠の楽園、そしてファロスの故郷。\nその偉大な都市国家は失われ、泥、湿地、苔むした巨大な石塊以外には何も残されていない。"
  },
  Skill_4410_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。自身の<VulnerabilityIconKeywords:易傷>状態を解除。山札から最大3枚のカードを選んで手札に加える。"
  },
  Skill_4410_EffectNameList = {
    Text = "シールド"
  },
  Skill_4410_Name = {
    Text = "失われた古都"
  },
  Skill_4410_OverLimitUtlSkillDesc = {
    Text = "手札上限+2、ターン終了時、手札 1 枚を選択して保留し、その行動力消費 -1、3 ターン持続する。<Block:[Block:Arg1]> 点のシールドを獲得する。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。ドロー山から最大 3 枚のカードを選択して手札に加える。"
  },
  Skill_4410_PropertyNameList = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4411_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。この<WeaknessIconKeywords:虚弱>はダメージを50%減少させる。"
  },
  Skill_4412_AwakerSkillBackgroundStory = {
    Text = "狂気に満ちた「不屈の」鞭は、いつでもどこでもあなたが求める痛みを与えることができる。"
  },
  Skill_4412_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、50%の一時的な<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4412_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4412_Name = {
    Text = "狂気を操る鞭"
  },
  Skill_4412_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4413_AwakerSkillBackgroundStory = {
    Text = "入隊後、彼女は前線で奮闘し、傷を負っても退くことを拒んだ。\nそれは「より良い世界」が来ると信じていたからだ。\n\nしかし、嘘はいつか崩れる。\n今度は偽りの約束ではなく、自分の信じる正義のために武器を取った。"
  },
  Skill_4413_Desc_0 = {
    Text = "アルバは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Arg2]点の<AlertIconKeywords:警戒>を獲得。アルバの指令カードのダメージは現在のシールドに応じて増加し、シールド1点につき2増加する。"
  },
  Skill_4413_Desc_15 = {
    Text = "アルバは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Arg2]点の<AlertIconKeywords:警戒>を獲得。アルバの指令カードのダメージは現在のシールドに応じて増加し、シールド1点につき2増加する。毎ターン初めてダメージを与えた後、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4413_EffectNameList = {
    Text = "狂気,戒備"
  },
  Skill_4413_Name = {
    Text = "戦地の知恵"
  },
  Skill_4413_PropertyNameList = {
    Text = "$GrowValue1,防御力×GrowValue2"
  },
  Skill_4415_Desc = {
    Text = "1ターンの間、<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易傷>を無効化する。<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_4415_EffectNameList = {
    Text = "シールド"
  },
  Skill_4415_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_4416_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4417_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4418_Desc = {
    Text = "戦闘終了後もデッキに残る。"
  },
  Skill_4418_Name = {
    Text = "ネバネバする蝋涙"
  },
  Skill_4419_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4420_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4421_AwakerSkillBackgroundStory = {
    Text = "彼女は満月の下で踊る。\n\nドレスの裾が腕に絡み、雲のようにくるくると回り続ける。\n\n彼女の下で、果てしなく流れる大湖は次第に空と一体化する。\n\n踊れ。\n踊れ。\n闇の中の声が言う。\n\n眠れるあの方を目覚めさせ、千年の約束を果たすのだ。"
  },
  Skill_4421_Desc_0 = {
    Text = "カレンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：カレンがカードを使用した後、ライフを<Heal:[Heal:Arg2]>回復し、<Energy:[Energy:Arg3]>狂気を獲得する。<DerivativeCardKeywords_42:「不思議な料理」>を使用した後、すべての敵に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4421_Desc_15 = {
    Text = "カレンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：カレンのカードを使用した後、ライフを<Heal:[Heal:Arg2]>回復し、<Energy:[Energy:Arg3]>狂気を獲得する。ターン終了時にカレンの指令カードを保持していた場合、ライフ回復効果と狂気獲得効果が2回発動する。<DerivativeCardKeywords_42:「不思議な料理」>を使用した後、すべての敵に[Poison:Arg4]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4421_EffectNameList = {
    Text = "狂気,回復,毒"
  },
  Skill_4421_Name = {
    Text = "三日月の舞"
  },
  Skill_4421_PropertyNameList = {
    Text = "$GrowValue1,体力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4422_AwakerSkillBackgroundStory = {
    Text = "「ストリートファイトにルールなんてない。使えるものは何でも使うさ」"
  },
  Skill_4422_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ジェンキンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4422_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4422_Name = {Text = "攻撃"},
  Skill_4422_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4423_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4424_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身を生贄として献上する。狂気の影響を受けない。"
  },
  Skill_4424_Name = {Text = "献上"},
  Skill_4425_Desc = {
    Text = "自身が死亡し、ライフが自身と同等の「Ⅱ型融蝕生物」2体に分裂する。"
  },
  Skill_4426_Desc = {
    Text = "暗く、狭く、崩れ続ける、出口も敵もそこにあり、逃げ場がない。"
  },
  Skill_4426_Name = {Text = "逃走"},
  Skill_4427_AwakerSkillBackgroundStory = {
    Text = "ほうきでも武器でも、彼女は優雅に使いこなす。"
  },
  Skill_4427_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4427_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。カレンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4427_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4427_Name = {Text = "攻撃"},
  Skill_4427_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_44284_Desc = {
    Text = "「胎動・ヌビア幼体」を5体召喚し、自身は「隠密」状態になり攻撃対象にならず、すべての敵が死亡すると「隠密」は解除される。"
  },
  Skill_44284_Name = {Text = "繁殖"},
  Skill_44285_Desc = {
    Text = "[Arg1]ターンの<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords:脆弱>を付与する。覚醒体2体を封印し、[Arg2]点の<IntoxicationIconKeywords:中毒>を与え、山札の中のカード2枚に<AberrationKeywords:畸变>を発生させる。"
  },
  Skill_44285_Name = {Text = "授乳"},
  Skill_44286_Desc = {
    Text = "「豊穣母樹」は周囲の生命力を吸収した…最大ライフを増加させ、すべてのスキルが強化される！"
  },
  Skill_4428_AwakerSkillBackgroundStory = {
    Text = "この者は偽りの聖女。\nその言葉も、ふるまいも、聖女としての務めを何ひとつ果たしていない。\n\nしかし、その強硬な外面の奥に隠されている真実とは何か——\nもしかすると、自らの運命のために毅然と旗を掲げることこそ、ある種の「聖女らしさ」なのかもしれない。"
  },
  Skill_4428_BattleDesc_0 = {
    Text = "<Block:[Block:Arg6]>点のシールドと[Arg3]点の行動力を獲得。次のターン開始時、最大ライフの[Arg5]%の<SacrificeKeyWord:献上>を受ける。<RippleKeywords:余波>：<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg4]。"
  },
  Skill_4428_Desc_0 = {
    Text = "合計(最大ライフ <Block:[Block:Arg1]%>+<Block:[Block:Arg2]>)点のシールドと[Arg3]点の行動力を獲得。次のターン開始時、最大ライフ[Arg5]%分の<SacrificeKeyWord:献上>を受ける。<RippleKeywords:余波>：<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg4] 。"
  },
  Skill_4428_EffectNameList = {
    Text = "シールド,触腕ダメージ"
  },
  Skill_4428_Name = {
    Text = "聖女創造"
  },
  Skill_4428_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4429_AwakerSkillBackgroundStory = {
    Text = "ニニバーでの日々は、タイスの長い人生の中での取るに足らないひと時だった。\nただ、宮殿の前で贈られたドレスは確かに彼女の最愛の品だった。"
  },
  Skill_4429_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4429_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4429_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。タイスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4429_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。タイスは<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]<PowerIconKeywords:力>を獲得。"
  },
  Skill_4429_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4429_EffectNameList_3 = {
    Text = "ダメージ,狂気"
  },
  Skill_4429_Name = {Text = "攻撃"},
  Skill_4429_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4429_PropertyNameList_3 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4430_Desc = {
    Text = "「泣き叫ぶ」を3枚手札に追加し、相手を1ターン<VulnerabilityIconKeywords:易傷>にし、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4430_Name = {
    Text = "灼蝋の欲望"
  },
  Skill_4431_Desc = {
    Text = "<DerivativeCardKeywords_80:「窒息」>を[Arg1]枚相手の手札に追加する。"
  },
  Skill_4431_Name = {
    Text = "溺死の怨念"
  },
  Skill_4432_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与える。[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4432_Name = {
    Text = "恣意の波"
  },
  Skill_4433_Desc = {
    Text = "覚醒体を1体選択し、70狂気を獲得。"
  },
  Skill_4433_Name = {
    Text = "影の残響"
  },
  Skill_4434_AwakerSkillBackgroundStory = {
    Text = "彼女の戦いの目的は傷つけることではなく、守ることだ。"
  },
  Skill_4434_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4434_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。アルバは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4434_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4434_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4435_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を2枚相手の山札に追加し、味方全体が[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4435_Name = {
    Text = "盛大な歓迎"
  },
  Skill_4436_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4437_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg5]点のシールドを獲得し、このターンカードを1枚引くたび、追加で[Arg4]点のシールドを獲得する。"
  },
  Skill_4437_Name = {
    Text = "隠密奇襲"
  },
  Skill_4438_AwakerSkillBackgroundStory = {
    Text = "指令：防御。ブロック。"
  },
  Skill_4438_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4438_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。リリーの死亡抵抗1％につき、基礎シールドが0.25％増加する。リリーは<Energy:[Energy:Arg2]>点の狂気を獲得。"
  },
  Skill_4438_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4438_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4439_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_4440_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、敵を捕食し、相手の次のターンのドローをスキップさせ抵抗不能の封印を付与するが、「次元の裂け目」のカードを手札に追加する。"
  },
  Skill_4440_Name = {
    Text = "現世の裂け目"
  },
  Skill_44411_Desc = {
    Text = "「養育・ヌビア幼体」を7体召喚し、自身は「隠密」状態になり攻撃対象にならず、すべての敵が死亡すると「隠密」は解除される。"
  },
  Skill_44411_Name = {
    Text = "無数の子孫の母"
  },
  Skill_44412_Desc = {
    Text = "[Arg1]ターンの<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords:脆弱>を付与する。すべての覚醒体を1ターン封印し、[Arg2]点の<IntoxicationIconKeywords:中毒>を与え、山札の中のカード3枚に<AberrationKeywords:畸变>を発生させる。"
  },
  Skill_44412_Name = {
    Text = "毒腺授乳"
  },
  Skill_4441_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4442_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4442_Name = {Text = "叩く"},
  Skill_4443_AwakerSkillBackgroundStory = {
    Text = "彼女はかつて栄光の頂点から転落し、過去の栄光は今日の恥辱に変わった。\n\n政務官夫人の庭から追放された後、ヘロットは無数の奴隷の中で埋もれ、スパルタ人の看守に虐げられた。\nそんな絶望の中でも、彼女は沈黙も挫折も知らなかった。\n\n彼女の胸に燃え続けるのは、尽きることのない憎悪。\n首の棘の鎖は無情に引き裂かれ、その中に秘められた力が解き放たれた。\n真の姿が、今まさに露わとなる。\n\nこれより先――毎日首を洗い、私の復讐を待つがいい。"
  },
  Skill_4443_Desc = {
    Text = "【<DevouredIconKeywords:捕食>：「打撃」を[Arg1]枚引き、一時的な手札の上限+2。この戦闘中、ヘロットの「打撃」の基礎ダメージが[Arg3]%増加。】自身の<WeaknessIconKeywords:虚弱>と非永続的な<PowerIconKeywords:力>減少状態を解除。このターン中、「打撃」のダメージが[Arg2]%増加し、ヘロットの与えるダメージが[Arg4]%増加する。"
  },
  Skill_4443_EffectNameList = {
    Text = "打撃ダメージ増加"
  },
  Skill_4443_Name = {
    Text = "絶望からの生還"
  },
  Skill_4443_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食>：「打撃」を[Arg1]枚引き、一時的な手札の上限+2。この戦闘中、ヘロットの「打撃」の基礎ダメージが[Arg3]%増加。】自身の<WeaknessIconKeywords:虚弱>と非永続的な<PowerIconKeywords:力>低下状態を解除。このターン中、「打撃」のダメージが[Arg2]%増加し、ヘロットの与えるダメージが[Arg4]%増加する。一時的な手札の上限+2、「不規則形態」を2枚手札に追加し、ヘロットのクリティカルダメージが[Arg5]%増加する。"
  },
  Skill_4444_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「パンディアの奴隷」を3体召喚する。"
  },
  Skill_4444_Name = {
    Text = "蜂蜜色の幻想惨劇"
  },
  Skill_44452_Desc = {
    Text = "ライフを[Arg1]%([Arg2])回復し、同量のシールドを獲得し、ライフが低いほど、この効果は高くなり、最大でライフを20%回復する。"
  },
  Skill_44452_Name = {
    Text = "アランの祈り"
  },
  Skill_44453_Desc = {
    Text = "神聖な子孫を1枚獲得する：手札の非派生指令カードを1枚選択し、その行動力0の未強化コピーを獲得し、<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を付与する。"
  },
  Skill_44453_Name = {
    Text = "神聖な子孫"
  },
  Skill_44454_Desc = {
    Text = "覚醒体1体に100狂気を獲得させ、その封印状態を解除する。"
  },
  Skill_44454_Name = {
    Text = "溢れる樹液"
  },
  Skill_4445_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の<ParcloseIconKeywords:バリア>を獲得し、前進する。"
  },
  Skill_44462_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_44462_Name = {
    Text = "狂乱の咬みつき"
  },
  Skill_44463_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44463_Name = {
    Text = "血に飢えた爪"
  },
  Skill_44472_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての覚醒体は<Energy:[Energy:Arg2]>狂気を獲得し、残りライフが低いほど、シールドと狂気の効果も高くなる。"
  },
  Skill_44472_Name = {
    Text = "司教の献身"
  },
  Skill_4447_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4447_Name = {Text = "喉切り"},
  Skill_44486_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての覚醒体は<Energy:[Energy:Arg2]>狂気を獲得し、残りライフが低いほど、シールドと狂気の効果も高くなる。"
  },
  Skill_44486_Name = {
    Text = "司教の献身"
  },
  Skill_4448_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！！！"
  },
  Skill_4448_Name = {
    Text = "頭蓋骨猛撃"
  },
  Skill_4449_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を2枚山札のランダムな位置に追加する。"
  },
  Skill_4449_Name = {Text = "蝋涙"},
  Skill_4450_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_23:「傷口」>を[Arg3]枚山札のランダムな位置に追加する。"
  },
  Skill_4451_Desc = {
    Text = "最も狂気が高い覚醒体に一時的な封印を1点付与し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_4452_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4452_Name = {
    Text = "不良品の怨念"
  },
  Skill_4453_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、自身は[Arg2]点の「蝋質の鎧」を獲得する：1点につき受けるダメージを[Arg3]減少させ、クリティカルを受けるたびに1点減少する。"
  },
  Skill_4453_Name = {
    Text = "蝋人形登場"
  },
  Skill_4454_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与し、3倍の<PowerIconKeywords:力>ボーナスを受ける。"
  },
  Skill_4454_Name = {
    Text = "斬首一閃"
  },
  Skill_4455_AwakerSkillBackgroundStory = {
    Text = "彼女はもはや知ってしまった……あの整然とした制服と新しい兵器の下に隠された真実を。\n\nいわゆる援助とは、ただの抑圧の偽装であり、いわゆる征服とは、ただの侵略の旗印であった。\n\n彼女は武器を掲げる。光明の星の五角は正義、公正、守護、解放、そして真実によって輝き、不正義の影を完全に払拭する。"
  },
  Skill_4455_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。手札のすべてのステータスカードと症状カードを捨て、捨てた数量と同じ枚数のカードを引く。すべての敵を<VulnerabilityIconKeywords:易傷>にする（1ターン）。"
  },
  Skill_4455_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。手札にあるすべてのステータスカードと症状カードを捨て、同数+1のカードを引く。すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_4455_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。手札にあるすべてのステータスカードと症状カードを捨て、同数+1のカードを引く。すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。50%の一時的なクリティカル率とクリティカルダメージを獲得。"
  },
  Skill_4455_EffectNameList = {
    Text = "シールド"
  },
  Skill_4455_Name = {
    Text = "無限の正義"
  },
  Skill_4455_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを得る。手札の全てのステータスカードと症状カードを捨て、捨てた枚数と同じ枚数のカードをドローする。全ての敵に1ターン<VulnerabilityIconKeywords:易傷>を付与する。消耗付きの「戦闘体勢」と「心眼の刃」を1枚ずつ手札に加える。本戦闘のクリティカルダメージ +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]> 点のシールドを得る。手札の全てのステータスカードと症状カードを捨て、捨てた枚数+1枚のカードをドローする。全ての敵に1ターン<VulnerabilityIconKeywords:易傷>を付与する。消耗付きの「戦闘体勢」と「心眼の刃」を1枚ずつ手札に加える。本戦闘のクリティカルダメージ +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。手札のすべてのステータスカードと症状カードを捨て、捨てた数量＋1のカードを引く。すべての敵を<VulnerabilityIconKeywords:易傷>にする（1ターン）。追加消費付きの「臨戦体勢」と「心眼利刃」を各1枚手札に追加。アルバは50％の臨時クリティカル率とクリティカルダメージを獲得し、本戦闘のクリティカルダメージ+25%。"
  },
  Skill_4455_PropertyNameList = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4456_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。基礎攻撃10回、ターン終了前に手札1枚ごとに攻撃回数が1減少し、最低3回まで。"
  },
  Skill_4456_Name = {
    Text = "群蛇の裂き"
  },
  Skill_44573_Desc = {
    Text = "このカードの表面が光る！"
  },
  Skill_44573_Name = {
    Text = "禁止効果"
  },
  Skill_44574_Desc = {
    Text = "このカードの表面が光る！"
  },
  Skill_44574_Name = {
    Text = "変化効果"
  },
  Skill_4457_AwakerSkillBackgroundStory = {
    Text = "荒れ狂う風雨を恐れる必要はない。彼女があなたたちを守る。"
  },
  Skill_4457_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。触腕を1本発動させて敵を攻撃し、[Arg3]％の触腕ダメージを与える。"
  },
  Skill_4457_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。シレストは<Energy:[Energy:Arg2]>狂気を獲得。触腕を1本発動させて敵を攻撃し、[Arg3]％の触腕ダメージを与える。"
  },
  Skill_4457_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4457_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4458_AwakerSkillBackgroundStory = {
    Text = "彼は身体に刻まれた傷跡を誇らしげに見せる。\n深い傷は戦場での死闘の証、浅い傷は日々の鍛錬と修練の産物。\nそれらは英雄の証であり、彼の誇りだ。\n\n——だが、首筋の傷については聞いてはならない。\nそれは彼の力の始まりであり、最大の屈辱でもある。"
  },
  Skill_4458_Desc_0 = {
    Text = "ゴリアテは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。ゴリアテがダメージを与えた後、[Power:Arg2]点の<PowerIconKeywords:力>と[TentaclePower:Arg3]点の <TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_4458_Desc_15 = {
    Text = "ゴリアテは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。ゴリアテがダメージを与えた後、[Power:Arg2]点の<PowerIconKeywords:力>と [TentaclePower:Arg3]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。触腕姿勢が「怒涛」の場合、ゴリアテは追加で[Arg4]%の力ボーナスを獲得。"
  },
  Skill_4458_EffectNameList = {
    Text = "狂気,力,触腕ダメージ"
  },
  Skill_4458_Name = {
    Text = "復讐の予行"
  },
  Skill_4458_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4459_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1枚の<DerivativeCardKeywords_3:「痙攣」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_4459_Name = {Text = "痙攣"},
  Skill_4460_AwakerSkillBackgroundStory = {
    Text = "父なる神が彼の夢に現れ、啓示を授けた。\n\n「空が太陽と月によって分かたれる時、ただ一人で森へ向かい、東へ五百歩、さらに五百歩進め。\n闇の中の温もりある場所に、我が最後の骨が眠っている。\n持って行け、我が代行者よ。ただし忘れるな。\n肉を求むるには肉を、命を求むるには命をもって対価となる」\n\n彼は神秘的なルーンが刻まれた石板を掘り起こし、自らの骨と血を捧げた。\n苦しむ者たちに、一縷の希望をもたらすために。"
  },
  Skill_4460_Desc_0 = {
    Text = "すべての敵に1ターンの<WeaknessIconKeywords:虚弱>を付与。<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。<Heal:[Heal:Arg2]>点の猩紅炉回復量を蓄積。"
  },
  Skill_4460_Desc_2 = {
    Text = "すべての敵に1ターンの<WeaknessIconKeywords:虚弱>を付与。<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。<Heal:[Heal:Arg2]>点の猩紅炉回復量を蓄積し、戦闘中1ターン経過するごとに追加で[Arg3]点を蓄積。"
  },
  Skill_4460_EffectNameList_0 = {
    Text = "胚胎融合,猩紅炉蓄積量"
  },
  Skill_4460_EffectNameList_2 = {
    Text = "胚胎融合,猩紅炉蓄積量,猩紅炉追加蓄積量"
  },
  Skill_4460_Name = {
    Text = "祝福の骨肉"
  },
  Skill_4460_PropertyNameList_0 = {
    Text = "$GrowValue1,体質×GrowValue2"
  },
  Skill_4460_PropertyNameList_2 = {
    Text = "$GrowValue1,体力×GrowValue2,体力×GrowValue3"
  },
  Skill_44612_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_44612_Name = {
    Text = "噛みつく"
  },
  Skill_4461_Desc = {
    Text = "味方全体が[Arg1]<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4461_Name = {
    Text = "全体の力"
  },
  Skill_4462_Desc = {
    Text = "<DerivativeCardKeywords_9:「よろよろ」>を2枚、それぞれ相手の山札のランダムな位置と相手の捨て札に追加する。"
  },
  Skill_4462_Name = {Text = "明滅"},
  Skill_4463_AwakerSkillBackgroundStory = {
    Text = "融蝕現象はすべての人に平等に影響を与えた。覚醒体も例外ではない。消滅を遅らせるために、ドールはすべての知識、意識、感情を外部器官に保存した。\n「賢い頭脳」——ドールのために作られた賛辞だ。"
  },
  Skill_4463_Desc_0 = {
    Text = "ドールは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ドールがライフを回復した後、<Block:[Block:Arg2]>点のシールドを獲得。"
  },
  Skill_4463_Desc_15 = {
    Text = "ドールは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ドールがライフを回復した後、<Block:[Block:Arg2]>点のシールドを獲得。ドールの「攻撃」と「防御」も、同様のシールド効果を発動する。"
  },
  Skill_4463_EffectNameList = {
    Text = "狂気,防御"
  },
  Skill_4463_Name = {
    Text = "霊肉分離"
  },
  Skill_4463_PropertyNameList = {
    Text = "$GrowValue1,防御力×GrowValue2"
  },
  Skill_4464_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4465_Desc = {
    Text = "毎ターン[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4465_Name = {
    Text = "古代の呼び声"
  },
  Skill_4466_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44674_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの「引き裂き」「外傷」<BlindingKeywords:盲目>を付与する。"
  },
  Skill_44674_Name = {
    Text = "「狂乱の噛みつき」"
  },
  Skill_44675_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーがカードを1枚使用するたび、この行動の追加効果が変化する。追加効果は「重撃」「回復」「弱体化」の順番に変化する。"
  },
  Skill_44675_Name = {
    Text = "「混乱の噛みつき」"
  },
  Skill_44676_Desc = {
    Text = "[Arg2]点の<PowerIconKeywords:力>と[Arg1]点のシールドを獲得し、ランダムな症状カードを3枚山札のランダムな位置に追加する。"
  },
  Skill_44676_Name = {
    Text = "「鏡の判決」"
  },
  Skill_44677_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44677_Name = {Text = "爪撃"},
  Skill_44678_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「奔放」を1枚手札に追加する。"
  },
  Skill_44678_Name = {Text = "懲罰"},
  Skill_44679_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得する。プレイヤーがカードを1枚使用するたび、この行動の追加効果が変化する。追加効果は「反撃」「浄化」「移植」の順番に変化する。"
  },
  Skill_44679_Name = {
    Text = "「鏡中の凝視」"
  },
  Skill_4467_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4467_Name = {Text = "銛"},
  Skill_44680_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの「引き裂き」と「外傷」を付与する。"
  },
  Skill_44680_Name = {Text = "罰"},
  Skill_44681_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_44681_Name = {
    Text = "噛みつき"
  },
  Skill_44682_Desc = {
    Text = "[Arg1]点の一時的な力を獲得し、すべての敵は[Arg2]点の一時的な力を獲得し、このカードは消滅する。戦闘終了後もデッキに残る。"
  },
  Skill_44682_Name = {Text = "奔放"},
  Skill_44683_Desc = {
    Text = "発狂を1層獲得し、「豪放」を1枚手札の山に加える。豪放：行動力消費1。戦闘終了後もデッキに保存され、発射するとすべてのユニットが一時的な力を獲得し、それを破壊する。"
  },
  Skill_44683_Name = {
    Text = "目には目を"
  },
  Skill_4468_Desc = {
    Text = "「膿」を召喚する。"
  },
  Skill_4468_Name = {
    Text = "黒沼禁域"
  },
  Skill_44691_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44691_Name = {
    Text = "路地裏の強盗"
  },
  Skill_44692_Desc = {
    Text = "前列が3点の<ParcloseIconKeywords:バリア>を獲得し、[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_44692_Name = {
    Text = "暗闇に隠れる"
  },
  Skill_44693_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの「引き裂き」を付与する。「引き裂き」：「防御」使用時、山札の上に<DerivativeCardKeywords_23:「傷口」>を1枚追加する。"
  },
  Skill_44693_Name = {
    Text = "雨夜の虐殺"
  },
  Skill_44694_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_44694_Name = {
    Text = "犯罪予告"
  },
  Skill_44695_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1ターンの「外傷」を付与する。「外傷」：「攻撃」使用後、山札の上に<DerivativeCardKeywords_23:「傷口」>を1枚追加する。"
  },
  Skill_44695_Name = {Text = "逆ギレ"},
  Skill_44696_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<DerivativeCardKeywords_9:「蹒跚」>を1枚山札に加える。"
  },
  Skill_44696_Name = {Text = "誘拐"},
  Skill_44697_Desc = {
    Text = "1ターンの<BlindingKeywords:盲目>を付与する。"
  },
  Skill_44697_Name = {Text = "塵"},
  Skill_44698_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44698_Name = {Text = "掃除"},
  Skill_44699_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_44699_Name = {Text = "ゆすり"},
  Skill_4469_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4469_Name = {
    Text = "長き憎しみ"
  },
  Skill_4470_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4470_Name = {
    Text = "ブラウン出撃！"
  },
  Skill_4471_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4471_Name = {Text = "神の刃"},
  Skill_44722_AwakerSkillBackgroundStory = {
    Text = "父なる神の数多の神託の一つ、父なる神の原初の血がいかように命を守るかを語る。"
  },
  Skill_44722_BattleDesc = {
    Text = "血による救済。ダメージを与えた後、現在のライフの10%([Arg1])を失い、失ったライフと同量(<Heal:[Heal:Arg2]>)の猩紅炉を蓄積する。"
  },
  Skill_44722_Desc = {
    Text = "血による救済。ダメージを与えた後、現在のライフの10%を失い、失ったライフと同量の猩紅炉を蓄積する。"
  },
  Skill_44722_Name = {Text = "献身"},
  Skill_44723_AwakerSkillBackgroundStory = {
    Text = "父なる神の数多の神託の一つ、父なる神の原初の血がいかように命を守るかを語る。"
  },
  Skill_44723_BattleDesc = {
    Text = "苦により苦を消す。残りのすべての猩紅炉の回復量を消費し、1点消費するごとにダメージが3増加する。ボス戦の場合、1点消費するごとにダメージが9増加する。最大ライフの1％の猩紅炉を消費するごとに最終ダメージが[Arg5]%上昇する。合計で<Damage:[Damage:Arg4]>ダメージを与える。"
  },
  Skill_44723_Desc = {
    Text = "苦により苦を消す。残りのすべての猩紅炉の回復量を消費し、1点消費するごとにダメージが3増加する。ボス戦の場合、1点消費するごとにダメージが9増加する。最大ライフの1％の猩紅炉を消費するごとに最終ダメージが[Arg5]%上昇する。"
  },
  Skill_44723_EffectNameList = {
    Text = "ダメージ,ダメージ加算"
  },
  Skill_44723_Name = {Text = "浄化"},
  Skill_44723_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2%"
  },
  Skill_44723_tempBattleDesc_1 = {
    Text = "苦により苦を消す。残りのすべての猩紅炉の回復量を消費し、1点消費するごとにダメージが3増加する。ボス戦の場合、1点消費するごとにダメージが9増加する。最大ライフの1％の猩紅炉を消費するごとに最終ダメージが[Arg5]%上昇する。合計で<Damage:[Damage:Arg4]>ダメージを与える。"
  },
  Skill_4472_Desc = {
    Text = "4体の覚醒体の狂気解放を1ターン封印する。"
  },
  Skill_44735_Desc = {
    Text = "タヴィ復活効果テスト"
  },
  Skill_44735_Name = {
    Text = "タヴィ効果測定"
  },
  Skill_4473_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の寄生を付与する。"
  },
  Skill_4473_Name = {Text = "骨侵食"},
  Skill_4474_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4475_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_44765_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、自身のデバフ状態を解除する。カード使用後、追加効果は「移植」に変化する。"
  },
  Skill_44765_Name = {
    Text = "「鏡中の凝視」浄化"
  },
  Skill_44766_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、追加で[Arg3]点の一時的な反撃を獲得する。カード使用後、追加効果は「浄化」に変化する。"
  },
  Skill_44766_Name = {
    Text = "「鏡中の凝視」反撃"
  },
  Skill_44767_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、「奔放」を2枚山札のランダムな位置に追加する。カード使用後、追加効果は「反撃」に変化する。"
  },
  Skill_44767_Name = {
    Text = "「鏡中の凝視」移植"
  },
  Skill_4476_AwakerSkillBackgroundStory = {
    Text = "彼らは最初、彼女を「聖女」と呼び、帆柱に縛りつけた。\nその後、彼らは彼女を「無価値」と罵り、牢に放り込んだ。\n彼らはどうやら忘れてしまったようだ。\n彼女には、生と死を決める力などないことを。\nあるのは、ただ——船の行き先を指し示す力だけだったのに。"
  },
  Skill_4476_Desc_0 = {
    Text = "シレストは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。シレストのライフ回復効果が15%増加する。ライフ回復時、一時的な<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg2]。"
  },
  Skill_4476_Desc_15 = {
    Text = "シレストは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。シレストのライフ回復効果が15%増加する。ライフ回復時、一時的な<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg2]。「不死の極楽鳥」の復活効果が発動した後、一時的な<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]、ボス戦では効果が2倍になる。"
  },
  Skill_4476_EffectNameList = {
    Text = "狂気,一時的な触腕ダメージ"
  },
  Skill_4476_Name = {
    Text = "庇護の力"
  },
  Skill_4476_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4477_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4477_Name = {
    Text = "二重噛みつき"
  },
  Skill_44786_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。カード使用後、追加効果は「重撃」に切り替わる。"
  },
  Skill_44786_Name = {
    Text = "「混乱の噛みつき」弱体化"
  },
  Skill_44787_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ライフを[Arg3]回復する。カード使用後、追加効果は「弱体化」に変化する。"
  },
  Skill_44787_Name = {
    Text = "「混乱の噛みつき」回復"
  },
  Skill_44788_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、カード使用後、追加効果は「回復」に変化する。"
  },
  Skill_44788_Name = {
    Text = "「混乱の噛みつき」重撃"
  },
  Skill_4478_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4479_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_44817_AwakerSkillBackgroundStory = {
    Text = "「私は創造主の代行者であり、彼の力を借りて、彼の名において、あなたたちのすべての苦しみを取り除く」"
  },
  Skill_44817_Desc = {
    Text = "[Arg1]点の一時的な<ParcloseIconKeywords:バリア>を獲得し、<EmbryoFusionIconKeywords:胚胎融合>+[Arg2]。"
  },
  Skill_44817_Name = {
    Text = "仁愛の守護"
  },
  Skill_4481_AwakerSkillBackgroundStory = {
    Text = "彼らは美であり、喜びであり、柔らかなレンガの壁。\n\n若い肉体が信じられないような姿勢でねじれ、幾重にも重なり、天に届く。\n\n静かに――泣かないで、微笑んで。\n無数の夏の夜に女王にそうしたように。"
  },
  Skill_4481_Desc_0 = {
    Text = "ワンダは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：即座に5点の<DreamGuide:夢引き>を獲得。ターン開始時、1点の<DreamGuide:夢引き>を獲得。<DreamGuide:夢引き>が5点または10点に達するたび、<Block:[Block:Arg2]>点のシールドを獲得。"
  },
  Skill_4481_Desc_15 = {
    Text = "ワンダは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：即座に5点の<DreamGuide:夢引き>を獲得。ターン開始時、1点の<DreamGuide:夢引き>を獲得。<DreamGuide:夢引き>が5点または10点に達するたび、<Block:[Block:Arg2]>点のシールドを獲得。ワンダが狂気解放を発動後、自身の次の2枚の指令カードは追加で1回発動する。"
  },
  Skill_4481_EffectNameList = {
    Text = "狂気,シールド"
  },
  Skill_4481_Name = {
    Text = "不死者の夢"
  },
  Skill_4481_PropertyNameList = {
    Text = "$GrowValue1,防御力×GrowValue2"
  },
  Skill_4482_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を[Arg1]枚山札のランダムな位置に追加する。"
  },
  Skill_4482_Name = {Text = "蝋涙"},
  Skill_4483_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4483_Name = {
    Text = "噛みつく"
  },
  Skill_4484_Desc = {
    Text = "守護人形を召喚する。"
  },
  Skill_4484_Name = {
    Text = "召喚と強化"
  },
  Skill_4486_Desc = {
    Text = "[Arg1]点のシールドを獲得し、シールド消滅時、残りシールドが2倍のライフに変換される。"
  },
  Skill_4486_Name = {
    Text = "不滅の花"
  },
  Skill_4487_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4488_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:倦怠>を付与する。"
  },
  Skill_4489_Desc = {
    Text = "味方全体が<Block:[Block:Arg1]>点のシールドを獲得し、自身は[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4490_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与えます。<WeaknessIconKeywords:弱り> を [Arg3] ターン付与します。"
  },
  Skill_4491_Desc = {
    Text = "自身を犠牲にし、融蝕の祝福を祈る。"
  },
  Skill_4491_Name = {Text = "犠牲"},
  Skill_4492_AwakerSkillBackgroundStory = {
    Text = "夕風が故郷の鐘の音を運び、星明かりが帰郷の道を照らす。\n過去の任務が彼女の執念となった。\n彼女は命を薪にして、永遠の灯を灯すことを望む。"
  },
  Skill_4492_Desc_0 = {
    Text = "ファロスは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。ファロスのカードを1枚使用するたび、カードを[Arg2]枚引き、すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動する。毎ターン最大3回まで発動。"
  },
  Skill_4492_Desc_15 = {
    Text = "ファロスは <Energy:[Energy:Arg1]> 狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。ファロスのカードを1枚使用するたび、カードを[Arg2]枚引き、すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]％発動し、このターンに触腕がダメージを与えた時、追加でダメージの5％に相当する<IntoxicationIconKeywords:毒>を付与する。毎ターン最大3回まで発動。"
  },
  Skill_4492_EffectNameList = {Text = "狂気"},
  Skill_4492_Name = {
    Text = "崩壊の執念"
  },
  Skill_4493_Desc = {
    Text = "ある種の奇妙な精神体験。"
  },
  Skill_4493_Name = {Text = "幻覚"},
  Skill_4494_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手の手札をすべて捨てさせる。"
  },
  Skill_4494_Name = {Text = "離散"},
  Skill_4495_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4496_BattleDesc = {
    Text = "ライフを[Arg1]失い、カードを2枚引く。売却不可。"
  },
  Skill_4496_Desc = {
    Text = "最大ライフの10%を失い、カードを2枚引く。売却不可。"
  },
  Skill_4496_Name = {
    Text = "症状：意識障害"
  },
  Skill_4497_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4498_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4499_Desc = {
    Text = "すべての覚醒体の、行動力消費0の「攻撃」をそれぞれ1枚手札に追加し、<DepleteIconKeywords:除外>を付与する。手札のすべての覚醒体のカードを、行動力消費0の「攻撃」に交換し、これはターン終了時まで持続する。"
  },
  Skill_4499_Name = {
    Text = "美しい瞬間"
  },
  Skill_45007_AwakerSkillBackgroundStory = {
    Text = "父なる神の数多の神託の一つ、父なる神の原初の血がいかように命を守るかを語る。"
  },
  Skill_45007_BattleDesc = {
    Text = "信仰による救済。残りのすべての猩紅炉を消費し、消費量の150%のシールド([Arg1])を獲得。このシールドはシールドボーナスやデバフの影響を受けず、シールド上限を無視する。"
  },
  Skill_45007_Desc = {
    Text = "信仰による救済。残りのすべての猩紅炉を消費し、消費量の150%のシールドを獲得。このシールドはシールドボーナスやデバフの影響を受けず、シールド上限を無視する。"
  },
  Skill_45007_Name = {Text = "救済"},
  Skill_45019_Desc_1 = {
    Text = "対象1体に<DisarmKeywords:麻痺>を付与する。"
  },
  Skill_45019_Name_1 = {Text = "麻痺"},
  Skill_4501_AwakerSkillBackgroundStory = {
    Text = "壊れやすい外部器官を守るため、ドールはガラス缶に「力場発生器」を組み込んだ。\n彼女が学生たちに説明するときも、無表情を保つ為、学生たちはドール教授がまた冗談を言っているのかどうか分からなかった。\n本当に恐ろしいユーモアだ。"
  },
  Skill_4501_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4501_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ドールは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4501_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4501_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4502_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4502_Name = {
    Text = "石の分解"
  },
  Skill_4504_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45051_Desc_1 = {
    Text = "対象1体に[Arg1]点の<PVPProtectiveKeywords:バリア>を付与する。"
  },
  Skill_45051_Name_1 = {Text = "バリア"},
  Skill_4505_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<DerivativeCardKeywords_35:「巨人の畏怖」>を3枚山札のランダムな位置に追加する。"
  },
  Skill_4505_Name = {
    Text = "深海の力"
  },
  Skill_45063_Desc_1 = {
    Text = "すべての敵に負の<PVPWonderfulEffectKeywords:不思議な効果>を与える。"
  },
  Skill_45063_Name_1 = {
    Text = "華麗な光景"
  },
  Skill_4506_AwakerSkillBackgroundStory = {
    Text = "それは無限の根源の海。\n伝説によれば惑星上のすべての有機物はここから生まれた。\n\n灰色の大海には、笑みと慈悲を湛えた無数の顔が漂っている。"
  },
  Skill_4506_Desc_0 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> 点のダメージを与え、このダメージは [Arg4] 倍の力ボーナスを受ける。カスタマイズした「千変万化」を 1 枚作成して手札に加え、現在が超次元ターンでなく<DimensionalSpaceIconKeywords:超次元空間>に「千変万化」がない場合、それを複製して<DimensionalSpaceIconKeywords:超次元空間>に加え、<SingularityKeywords3:次元シャトル>を 1 回発動したとみなす。そうでない場合、<DerivativeCardKeywords_4:「啓示」>を 1 枚手札に加える。"
  },
  Skill_4506_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4506_Name = {
    Text = "根源の海"
  },
  Skill_4506_OverLimitUtlSkillDesc_0 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> 点のダメージを与え、このダメージは [Arg4] 倍の力ボーナスを受ける。カスタマイズした「千変万化」を 1 枚作成して手札に加え、現在が超次元ターンでなく<DimensionalSpaceIconKeywords:超次元空間>に「千変万化」がない場合、それを複製して<DimensionalSpaceIconKeywords:超次元空間>に加え、<SingularityKeywords3:次元シャトル>を 1 回発動したとみなす。そうでない場合、<DerivativeCardKeywords_4:「啓示」>を 1 枚手札に加える。さらに「千変万化」の複製を [Arg2] 枚手札に加え、「首切りの一撃」の本戦闘中の基礎ダメージが [Arg3]％ 上昇する。"
  },
  Skill_4506_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_45079_Desc_1 = {
    Text = "対象1体に<PVPSeriousInjuryKeywords:重傷>を付与する。"
  },
  Skill_45079_Name_1 = {Text = "重傷"},
  Skill_4507_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4507_Name = {
    Text = "噛みつく"
  },
  Skill_4508_Desc = {
    Text = "ターン開始時、山札の指令カード1枚のコピーにランダムに変形し、その行動力消費は3で固定され、ターン終了時に元に戻る。使用不可。"
  },
  Skill_4508_Name = {
    Text = "症状：錯乱"
  },
  Skill_4509_AwakerSkillBackgroundStory = {
    Text = "最古の混沌を除けば、海水と炎を融合させるものはない。\n探しに行って、確かめてみるといい。砂漠の尖塔を追い、海底の迷宮を探し、無限の山々を越えよ。\n保証するが、ロータンより古いものはない。"
  },
  Skill_4509_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与え、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4509_BattleDesc_2 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg3]回与え、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。このカードは「攻撃」として扱う。"
  },
  Skill_4509_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4509_Desc_2 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。このカードは「攻撃」として扱う。"
  },
  Skill_4509_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_4509_Name = {
    Text = "恣意の波"
  },
  Skill_4509_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4510_Desc = {
    Text = "引いた時、このターンすべての覚醒体が獲得する狂気が50%減少する。"
  },
  Skill_4510_Name = {Text = "虚無"},
  Skill_4511_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4512_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_4512_Name = {Text = "深淵"},
  Skill_4514_Desc = {
    Text = "敵に1ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4514_Name = {
    Text = "落とし穴"
  },
  Skill_4515_AwakerSkillBackgroundStory = {
    Text = "この一撃のみ。\n虐待者の命を奪い、裏切り者の命を奪い、無謀者の命を奪い、侵略者の命を奪う。\n多くを語る必要はない。この深い憎しみを込めた鋭い刺で、彼女の選択と覚悟を誓う。"
  },
  Skill_4515_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。手札に他の「攻撃」が1枚あるごとに、基礎ダメージが[Arg3]%増加し、1倍の力ボーナスを獲得する。すべての「攻撃」を捨てる。このカードは「攻撃」として扱う。"
  },
  Skill_4515_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。手札に他の「攻撃」が1枚あるごとに、基礎ダメージが[Arg3]%増加し、1倍の力ボーナスを獲得する。すべての「攻撃」を捨てる。このカードは「攻撃」として扱う。"
  },
  Skill_4515_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4515_Name = {
    Text = "鎖を断つ一撃"
  },
  Skill_4515_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4516_AwakerSkillBackgroundStory = {
    Text = "「恥辱……恥辱……」\n少女は厨房の隅に縮こまり、口元に残る血の痕を拭う間もない。\n最も身近な者からの非難を受けながら、反論する力もなかった。\n\nその日を境に、少女は自らの名前を失った。\n彼女は人々の前から消え去った――まるで流れ続ける噂の川に溶け込む一滴の水のように。"
  },
  Skill_4516_Desc_0 = {
    Text = "レーアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：レーアの指令カードを使用した後、 <EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。"
  },
  Skill_4516_Desc_15 = {
    Text = "レーアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：レーアの指令カードを使用した後、<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg2]。次に発動する狂気解放を強化：永続的な力の[Arg3]％に等しい一時的な力を獲得し、最大[Arg4]回まで累積可能。"
  },
  Skill_4516_EffectNameList = {
    Text = "狂気,胚胎融合"
  },
  Skill_4516_Name = {
    Text = "血を渇望する者"
  },
  Skill_4517_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4517_Name = {
    Text = "猟槍の突き"
  },
  Skill_4518_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4518_Name = {
    Text = "傷口の裂け目"
  },
  Skill_4519_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、すべての覚醒体を1ターン封印する。"
  },
  Skill_4519_Name = {
    Text = "「@1降臨のため@2準備」"
  },
  Skill_4520_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、ターン終了時にすべて失う。"
  },
  Skill_4520_Name = {Text = "祈り"},
  Skill_4521_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、手札のすべてのカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与し、「石ころ変化」を1枚相手の手札に追加する。"
  },
  Skill_4521_Name = {
    Text = "真・永遠の瞳"
  },
  Skill_4522_Desc = {
    Text = "[Arg2]点のシールドと[Arg1]点の再生力を獲得。再生力：ターン終了時に点数に等しいライフを回復し、ライフを5点失うごとに1点減少。"
  },
  Skill_4522_Name = {
    Text = "異端の継承"
  },
  Skill_4523_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4524_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45251_Desc_1 = {
    Text = "全体の味方のライフを前のターン開始時の状態に還元するが、還元後のライフは最大 [Arg1]% を超えない。<ReduceEffectKeywords:強力低下> [Arg2]、狂気を半減する。<PVPRaidKeywords:奇襲>：還元後のライフは最大 [Arg3]% を超えない。"
  },
  Skill_45251_Name_1 = {
    Text = "回帰の扉を越え"
  },
  Skill_45251_UnknownName = {
    Text = "回帰の扉を越え"
  },
  Skill_45252_Desc_1 = {
    Text = "[Arg1] 枚の他のランダムな「キーオーダー」をドロー山にシャッフルし、手札に引くまでその内容は不明となる。"
  },
  Skill_45252_Name_1 = {
    Text = "オレッタの宝物"
  },
  Skill_45252_UnknownName = {
    Text = "オレッタの宝物"
  },
  Skill_45253_Desc_1 = {
    Text = "敵1名を選択して<PVPEmptinessKeywords:虚無>を与え、対象の [Arg1] 狂気を同量の<DelayKeywords:レイテンシ>に変換する：<DelayKeywords:レイテンシ>：狂気。"
  },
  Skill_45253_Name_1 = {Text = "海の祭"},
  Skill_45253_UnknownName = {Text = "海の祭"},
  Skill_45254_Name_1 = {
    Text = "春の詩集"
  },
  Skill_45254_UnknownName = {
    Text = "春の詩集"
  },
  Skill_45255_Desc_1 = {
    Text = "合計<Damage:[Damage:Arg1]>ダメージを、すべての敵に均等に分配して与える。"
  },
  Skill_45255_Name_1 = {
    Text = "すべてが彼女"
  },
  Skill_45255_UnknownName = {
    Text = "すべてが彼女"
  },
  Skill_45256_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」はこのターンの次の「攻撃」をランダムな対象に変更し、追加でランダムな対象[Arg1]体を攻撃する。"
  },
  Skill_45256_Name_1 = {
    Text = "鏡の中の人"
  },
  Skill_45257_Desc_1 = {
    Text = "味方1体を<ReinforceKeywords:堅固>にし、カードを[Arg1]枚引く。"
  },
  Skill_45257_Name_1 = {
    Text = "最後の誓い"
  },
  Skill_45257_UnknownName = {
    Text = "最後の誓い"
  },
  Skill_45258_BattleDesc_1 = {
    Text = "行動力をすべて消費し、消費した行動力1点ごとおよび<PVPCapKeywords:行動力上限>1点ごとに [Arg1] <PVPBleedingKeywords:出血>を与え、合計 <Damage:[Damage:Arg2]> の<PVPBleedingKeywords:出血>ダメージを与える。"
  },
  Skill_45258_Desc_1 = {
    Text = "行動力をすべて消費し、消費した行動力1点ごとおよび<PVPCapKeywords:行動力上限>1点ごとに [Arg1] <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_45258_Name_1 = {
    Text = "咆哮する血と砂"
  },
  Skill_45258_UnknownName = {
    Text = "咆哮する血と砂"
  },
  Skill_45259_Desc_1 = {
    Text = "[Arg1]点の<PVPProtectiveKeywords:バリア>を獲得。毎ターン開始時に[Arg2]点の<PVPProtectiveKeywords:バリア>を<PVPPowerIconKeywords:力>に変換する。3ターン持続。"
  },
  Skill_45259_Name_1 = {
    Text = "薔薇の勝利"
  },
  Skill_45259_UnknownName = {
    Text = "薔薇の勝利"
  },
  Skill_4525_AwakerSkillBackgroundStory = {
    Text = "「パンッ！パンッ！パンッ！」\n小さな鞭を振り上げ、命令に従わない奴隷を叩く。"
  },
  Skill_4525_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4525_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]> のダメージを与え、50%の一時的な<RetaliateIconKeywords:反撃>を獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4525_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。パンディアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4525_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、50%の一時的な<RetaliateIconKeywords:反撃>を獲得。パンディアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4525_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4525_Name = {Text = "攻撃"},
  Skill_4525_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_45260_Desc_1 = {
    Text = "味方1体を選択し、<Block:[Block:Arg1]>のシールドを付与した上で、その現在のHPとシールドを他の味方に分配する。対象が唯一の生存味方の場合、代わりに<StrengthenKeywords:強化>と<ReinforceKeywords:加固>を獲得する。"
  },
  Skill_45260_Name_1 = {
    Text = "腐敗の饗宴"
  },
  Skill_45260_UnknownName = {
    Text = "腐敗の饗宴"
  },
  Skill_45261_Desc_1 = {
    Text = "目標に手札をすべて捨てさせる。手札を捨てなければ [Arg2] 行動力を得て [Arg2] 枚のカードを引く。"
  },
  Skill_45261_Name_1 = {
    Text = "巨人の覇道"
  },
  Skill_45261_UnknownName = {
    Text = "巨人の覇道"
  },
  Skill_45262_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「狂気解放」の後、自身は<TauntKeywords:挑発>と<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_45262_Name_1 = {
    Text = "35mmの魔法"
  },
  Skill_45263_Desc_1 = {
    Text = "カードを[Arg1]枚引く。"
  },
  Skill_45263_Name_1 = {
    Text = "真夏の夢"
  },
  Skill_45263_UnknownName = {
    Text = "真夏の夢"
  },
  Skill_45264_Desc_1 = {
    Text = "<DelayKeywords:遅延>：<StrengthenKeywords:強化>と<ReinforceKeywords:堅固>を自身に付与し、[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_45264_Name_1 = {
    Text = "神の御業"
  },
  Skill_45264_UnknownName = {
    Text = "神の御業"
  },
  Skill_45265_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は対象を選択できる。「攻撃」の前に、対象の持つ解除可能なすべてのバフを、その後ろの覚醒体に<PVPRepelKeywords:後退>する。"
  },
  Skill_45265_Name_1 = {
    Text = "深海の呼び声"
  },
  Skill_45266_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時および「打撃」の後、手札にある装備者の非派生「スキル」が、順番に装備者の他の「スキル」に変化する。<PVPFlowerKeywords:昔日の花と詩>"
  },
  Skill_45266_Name_1 = {
    Text = "昔日の花と詩"
  },
  Skill_45267_Desc_1 = {
    Text = "手中の全ての「スキル」に <PrepareKeywords:準備> を付与し、基礎行動力消費が [Arg2] の「スキル」は <PrepareKeywords:準備> [Arg3] を獲得する。"
  },
  Skill_45267_Name_1 = {
    Text = "ブラックスワン"
  },
  Skill_45267_UnknownName = {
    Text = "ブラックスワン"
  },
  Skill_45268_Desc_1 = {
    Text = "任意の対象にランダムな「運命の札」を装備させる。使用回数を使い切っていない場合、このカードを相手の山札のランダムな位置に追加する。"
  },
  Skill_45268_Name_1 = {
    Text = "一発の銃声"
  },
  Skill_45268_UnknownName = {
    Text = "一発の銃声"
  },
  Skill_45269_Desc_1 = {
    Text = "<PVPCapKeywords:行動力上限> +[Arg1]。"
  },
  Skill_45269_Name_1 = {
    Text = "骨を蝕む抱擁"
  },
  Skill_45269_UnknownName = {
    Text = "骨を蝕む抱擁"
  },
  Skill_4526_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与えます。<WeaknessIconKeywords:弱り> を [Arg3] ターン付与します。"
  },
  Skill_45270_Desc_1 = {
    Text = "<PVPHoldingKeywords:保有>：ターン終了時、最後に出した「スキル」カードに変化し、その行動力消費を-1にする。使用後、「灰霧の真容」を1枚山札のランダムな位置に追加する。"
  },
  Skill_45270_Name_1 = {
    Text = "灰霧の正体"
  },
  Skill_45270_UnknownName = {
    Text = "灰霧の正体"
  },
  Skill_45271_Desc_1 = {
    Text = "造成 [Arg1] ダメージ、<DisarmKeywords:麻痹>、<PVPMethysisKeywords:中毒>。"
  },
  Skill_45271_Name_1 = {
    Text = "儚き永遠"
  },
  Skill_45271_UnknownName = {
    Text = "儚き永遠"
  },
  Skill_45272_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPEntanglementKeywords:纏着>、<PVPPenetrateKeywords:刺突>。"
  },
  Skill_45272_Name_1 = {
    Text = "湖畔の回想"
  },
  Skill_45272_UnknownName = {
    Text = "湖畔の回想"
  },
  Skill_45273_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：主動ダメージを受けるたびに、他の味方が<Energy:[Energy:Arg1]> 狂気を獲得する。"
  },
  Skill_45273_Name_1 = {
    Text = "イサラウの眼差し"
  },
  Skill_45275_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：手札上限+[Arg1]。「狂気解放」の後、自身は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_45275_Name_1 = {
    Text = "熱い別れのキス"
  },
  Skill_4527_Desc = {
    Text = "1点の<MadnessIconKeywords:発狂>を獲得する。症状カード使用時、パンディアの状態が「焦燥」と「情欲」の間で変化する。「焦燥」：攻撃回数+1、<PowerIconKeywords:力>減少。「情欲」：攻撃回数-1、<PowerIconKeywords:力>増加。"
  },
  Skill_4527_Name = {Text = "覚醒"},
  Skill_4528_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。歪んだ死体の宴のダメージを<Damage:[Damage:Arg3]>増加させる。"
  },
  Skill_4528_Name = {
    Text = "乱れ切り"
  },
  Skill_4529_AwakerSkillBackgroundStory = {
    Text = "苦難は残酷で、無情だ。\n\nすべてを溶かす黒き死の前で、命尽きようとも彼は世のすべてを守ろうとする。"
  },
  Skill_4529_Desc_0 = {
    Text = "選択：<B02AFKeyWord2:献身>、<B02AFKeyWord3:浄化>または<B02AFKeyWord4:救済>。<Energy:[Energy:Arg5]>狂気を獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、猩紅炉を1点蓄積するごとにダメージが[Float:Arg2]増加。"
  },
  Skill_4529_Desc_2 = {
    Text = "選択：<B02AFKeyWord2:献身>、<B02AFKeyWord3:浄化>または<B02AFKeyWord4:救済>。<Energy:[Energy:Arg5]>狂気を獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、猩紅炉を1点蓄積するごとに、ダメージが[Float:Arg2]増加。このダメージのクリティカル率が[Arg4]%増加する。"
  },
  Skill_4529_EffectNameList = {
    Text = "ダメージ,ダメージ加算,狂気"
  },
  Skill_4529_Name = {
    Text = "苦痛の解消"
  },
  Skill_4529_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4530_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4530_Name = {Text = "刺突"},
  Skill_4531_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札の上の[Arg3]枚のカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_4531_Name = {
    Text = "停滞の呪い"
  },
  Skill_4532_Desc = {
    Text = "「降神の儀式」を完了し、自身のライフと最大ライフを2倍にする。[Arg1]点の<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>、<VulnerabilityIconKeywords:軟化>状態を付与し、「執念」を3枚山札のランダムな位置に追加する。"
  },
  Skill_4532_Name = {
    Text = "降神の儀式・降臨"
  },
  Skill_4533_AwakerSkillBackgroundStory = {
    Text = "ジェンキンも最初からブラウンを理解できたわけではない。\n\n「これじゃダメだな」と彼女は思った。\n\nこれではブラウンは街の自称紳士たちの注意を引けず、彼らのポケットから今夜の夕食を手に入れることができない。\n\nそこで彼女はランタンを使って訓練を始め、何日もの試行錯誤の末、ついに——\n「ブラウン、出動！」\n「チュ！」"
  },
  Skill_4533_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、「ブラウン出撃！」が与えるダメージが[Arg2]点増加する。<TransitionIconKeywords:跳躍>：このスキルは追加で1倍の力ボーナスを受ける。"
  },
  Skill_4533_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、「ブラウン出撃！」が与えるダメージが[Arg2]点増加し、「鼠群衝撃」が与えるダメージが[Arg3]点増加する。<TransitionIconKeywords:跳躍>：このスキルは追加で1倍の力ボーナスを受ける。"
  },
  Skill_4533_EffectNameList_0 = {
    Text = "ダメージ,ダメージ成長"
  },
  Skill_4533_EffectNameList_1 = {
    Text = "ダメージ,ダメージ増加,「鼠たちの突撃」ダメージ増加"
  },
  Skill_4533_Name = {
    Text = "ブラウン出撃！"
  },
  Skill_4533_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4533_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4534_Desc = {
    Text = "守護人形を召喚し、自身は[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4534_Name = {
    Text = "召喚と強化"
  },
  Skill_4535_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_45367_Desc_1 = {
    Text = "<DelayKeywords:遅延>：味方1体に「攻撃」を[Arg1]枚与える。"
  },
  Skill_45367_Name_1 = {
    Text = "不朽の葬儀"
  },
  Skill_45367_UnknownName = {
    Text = "不朽の葬儀"
  },
  Skill_4536_Desc = {
    Text = "あなたはもう次元間移動で脱出できない！……あなたはこのカードを除外できるが、それには何の意味もない。"
  },
  Skill_4536_Name = {
    Text = "見られている……！"
  },
  Skill_4537_Desc = {
    Text = "手札のすべての症状カードを除外する。1枚除外するごとにカードを1枚引く。あと1回しか使用できない……"
  },
  Skill_4537_Name = {
    Text = "次元間移動"
  },
  Skill_45383_Desc_1 = {
    Text = "対象1体に[Arg1]点の<PowerColourKeywords:力の減少>を一時的に付与する。"
  },
  Skill_45383_Name_1 = {
    Text = "一時的な力の減少"
  },
  Skill_45384_Desc_1 = {
    Text = "対象1体に[Arg1]点の一時的な<PowerColourKeywords:力>を付与する。"
  },
  Skill_45384_Name_1 = {
    Text = "一時的な力"
  },
  Skill_4538_Desc = {
    Text = "手札のすべての症状カードを除外する。1枚除外するごとにカードを1枚引く。2回使用できる。"
  },
  Skill_4538_Name = {
    Text = "次元間移動"
  },
  Skill_4539_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身は<Flaw:破綻>を獲得する：そのターン中必ずクリティカルを受ける。"
  },
  Skill_4539_Name = {
    Text = "鼠たちの突撃"
  },
  Skill_4540_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、すべて失うと「眩暈」状態になる。"
  },
  Skill_4540_Name = {Text = "祈り"},
  Skill_4541_AwakerSkillBackgroundStory = {
    Text = "真夜中、静かな水流が病弱な少女の導きで、優しく愛情に満ちた衝撃を届ける。"
  },
  Skill_4541_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4541_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ニムフィーアは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4541_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4541_Name = {Text = "攻撃"},
  Skill_4541_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4542_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後退する。"
  },
  Skill_4543_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4544_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45453_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>の傷害を与え、目標が持っている手札に基づいて追加で1回傷害を与え、一半の傷害でシールドを獲得し、<PVPPenetrateKeywords:刺突>。"
  },
  Skill_45454_Desc_1 = {
    Text = "味方1体のライフを<Heal:[Heal:Arg1]>回復し、<Energy:[Energy:Arg2]>狂気を付与、自身への使用時は効果半減。"
  },
  Skill_45454_Name_1 = {
    Text = "豊穣の儀"
  },
  Skill_45455_Desc_1 = {
    Text = "対象を<PVPVulnerabilityIconKeywords:軟化>にし、<Damage:[Damage:Arg1]>ダメージを与え、<PVPPenetrateKeywords:貫通>。"
  },
  Skill_45455_Name_1 = {
    Text = "無形の移動"
  },
  Skill_45456_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>の傷害を与え、傷害と同等のライフを回復します、<PVPSeriousInjuryKeywords:重傷>影響下の目標に使うと、回復するライフを倍にします。"
  },
  Skill_45456_Name_1 = {
    Text = "腺細胞再構築"
  },
  Skill_45457_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、その<PVPMethysisKeywords:毒>を2倍にする。"
  },
  Skill_45457_Name_1 = {
    Text = "自我の葬儀"
  },
  Skill_45458_Desc_1 = {
    Text = "他の任意の対象を<PVPVulnerabilityIconKeywords:軟化>にする。<DelayKeywords:遅延>：<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_45458_Name_1 = {
    Text = "疼痛の享受"
  },
  Skill_45459_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45459_Name_1 = {Text = "攻撃"},
  Skill_4545_AwakerSkillBackgroundStory = {
    Text = "「私は暗闇なんて怖くない！このランプはただの照明ってだけ」"
  },
  Skill_4545_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4545_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。カードを2枚引く。引いたカードがジェンキンのカードでない場合、それを捨てる。"
  },
  Skill_4545_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ジェンキンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4545_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ジェンキンは<Energy:[Energy:Arg2]>狂気を獲得。カードを2枚引く。引いたカードがジェンキンのカードでない場合、それを捨てる。"
  },
  Skill_4545_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4545_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_45460_Desc_1 = {
    Text = "他の任意の対象に<Damage:[Damage:Arg1]>ダメージを与え、<Energy:[Energy:Arg2]>狂気を獲得させる。"
  },
  Skill_45460_Name_1 = {
    Text = "至高の喜び"
  },
  Skill_45461_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、[Arg2] 層の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_45461_Name_1 = {Text = "怨恨"},
  Skill_45462_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与える。[Arg2] 層の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_45462_Name_1 = {
    Text = "宣戦布告"
  },
  Skill_45463_Desc_1 = {
    Text = "[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得し、自身に<PVPVulnerabilityIconKeywords:軟化>を付与。"
  },
  Skill_45463_Name_1 = {
    Text = "噴出する憎悪"
  },
  Skill_45464_Desc_1 = {
    Text = "ランダムで[Arg1]回<Damage:[Damage:Arg2]>ダメージを与え、同量の<PVPSacrificeKeyWords:献祭>を適用する。"
  },
  Skill_45464_Name_1 = {
    Text = "螺湮典儀"
  },
  Skill_45465_Desc_1 = {
    Text = "全ての味方に <Block:[Block:Arg1]> シールドを与え、全ての敵に<PVPSacrificeKeyWords:献祭>を発動させます。"
  },
  Skill_45465_Name_1 = {
    Text = "死の淵の輪廻"
  },
  Skill_45466_Desc_1 = {
    Text = "全体の敵の狂気を <Energy:[Energy:Arg1]> 減少させ、<PVPCapKeywords:行動力上限> - [Arg2]。"
  },
  Skill_45466_Name_1 = {
    Text = "虚妄の隆宠"
  },
  Skill_45467_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<DisarmKeywords:麻痺>、<PVPMethysisKeywords:中毒>、<PVPBleedingKeywords:出血>。"
  },
  Skill_45467_Name_1 = {
    Text = "三つ刃の棘"
  },
  Skill_45468_Desc_1 = {
    Text = "[Arg1] 一時的な <PVPRetaliateIconKeywords:反撃> を得る。このターン中に [Arg3] 回「スキル」を使用すると 1 層 <EnergyStorageKeywords:蓄力> を得る。ターン終了前に未使用の回数全てが、毎回 <Heal:[Heal:Arg4]> ライフを回復に変換される。"
  },
  Skill_45468_Name_1 = {
    Text = "異端の継承"
  },
  Skill_45469_Desc_1 = {
    Text = "<DelayKeywords:遅延>：<Energy:[Energy:Arg1]> 狂気。"
  },
  Skill_45469_Name_1 = {
    Text = "鼠たちの王"
  },
  Skill_4546_AwakerSkillBackgroundStory = {
    Text = "ジェンキンも最初からブラウンを理解できたわけではない。\n\n「これじゃダメだな」と彼女は思った。\n\nこれではブラウンは街の自称紳士たちの注意を引けず、彼らのポケットから今夜の夕食を手に入れることができない。\n\nそこで彼女はランタンを使って訓練を始め、何日もの試行錯誤の末、ついに——\n「ブラウン、出動！」\n「チュ！」"
  },
  Skill_4546_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、「ブラウン出撃！」が与えるダメージが[Arg2]増加。跳躍：代わりにすべての敵にダメージを与えるが、使用後<DepleteIconKeywords:除外>する。"
  },
  Skill_4546_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。この戦闘中、「ブラウン出撃！」が与えるダメージが[Arg2]点増加し、「鼠たちの突撃」が与えるダメージが[Arg3]点増加。跳躍：代わりにすべての敵にダメージを与えるが、使用後<DepleteIconKeywords:除外>する。"
  },
  Skill_4546_EffectNameList_0 = {
    Text = "ダメージ,ダメージ成長"
  },
  Skill_4546_EffectNameList_1 = {
    Text = "ダメージ,ダメージ成長,鼠たちの突撃ダメージ成長"
  },
  Skill_4546_Name = {
    Text = "ブラウン出撃！"
  },
  Skill_4546_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4546_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_45470_Desc_1 = {
    Text = "<PVPMouseKeywords:鼠のカード><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>を1種類選択し、そのコピーを[Arg1]枚手札に追加する。"
  },
  Skill_45470_Name_1 = {
    Text = "街頭の仲間"
  },
  Skill_45471_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45471_Name_1 = {Text = "攻撃"},
  Skill_45472_Desc_1 = {
    Text = "味方1体のデバフ状態か、または敵1体のバフ状態を解除する。"
  },
  Skill_45472_Name_1 = {
    Text = "生理解析"
  },
  Skill_45473_Desc_1 = {
    Text = "すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45473_Name_1 = {
    Text = "外域注入"
  },
  Skill_45474_Desc_1 = {
    Text = "味方1体のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45474_Name_1 = {
    Text = "集中治療"
  },
  Skill_45475_Desc_1 = {
    Text = "敵全体に本ターン中、能動ダメージを受けた後にダメージの[Arg1]％の<PVPSacrificeKeyWords:献祭>を付与、一時的に<StrongEffectKeywords:強効> +[Arg2]。"
  },
  Skill_45475_Name_1 = {
    Text = "虚妄の王女"
  },
  Skill_45476_Desc_1 = {
    Text = "敵1体に <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_45476_Name_1 = {
    Text = "美しい薔薇の棘"
  },
  Skill_45477_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPWeaknessKeywords:倦怠>にし、<PVPPenetrateKeywords:貫通>。"
  },
  Skill_45477_Name_1 = {
    Text = "失われた芸術"
  },
  Skill_45478_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45478_Name_1 = {Text = "攻撃"},
  Skill_45479_Desc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg1]>ダメージを与え、ダメージの半分のライフを失う。"
  },
  Skill_45479_Name_1 = {
    Text = "重撃の鉄球"
  },
  Skill_4547_Desc = {
    Text = "他の覚醒体は<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_4547_Name = {
    Text = "上位触媒"
  },
  Skill_45480_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、ダメージの半分のライフを失う。"
  },
  Skill_45480_Name_1 = {
    Text = "鉄鎖旋風"
  },
  Skill_45481_Desc_1 = {
    Text = "<TauntKeywords:挑発>を持つ敵を優先してランダムに<Damage:[Damage:Arg1]>ダメージを与え、ダメージの半分のライフを失う。"
  },
  Skill_45481_Name_1 = {
    Text = "形なき鎖"
  },
  Skill_45482_Desc_1 = {
    Text = "任意の他のターゲットから <Energy:[Energy:Arg2]> 狂気を盗み、ターゲットと自身に<PVPEmptinessKeywords:虚無>を付与し、<StrongEffectKeywords:強力> +[Arg1]、「蜂蜜色の幻想惨劇」に<StrongEffectKeywords:強力> +[Arg3]を付与。"
  },
  Skill_45482_Name_1 = {
    Text = "蜂蜜色の幻想惨劇"
  },
  Skill_45483_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45483_Name_1 = {Text = "攻撃"},
  Skill_45484_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45484_Name_1 = {Text = "攻撃"},
  Skill_45485_Desc_1 = {
    Text = "敵1体のバフを解除し、<Damage:[Damage:Arg1]> ダメージを与え、[Arg2]<PVPSlowKeywords:鈍化>。"
  },
  Skill_45485_Name_1 = {
    Text = "星の極光"
  },
  Skill_45486_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_45486_Name_1 = {
    Text = "硬化する石の皮膚"
  },
  Skill_45487_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPWeaknessKeywords:倦怠>にする。"
  },
  Skill_45487_Name_1 = {
    Text = "打ち留める凝視"
  },
  Skill_45488_Desc_1 = {
    Text = "すべての味方に<Block:[Block:Arg1]>点のシールドを与える。"
  },
  Skill_45488_Name_1 = {
    Text = "ルルイエの守護"
  },
  Skill_45489_Desc_1 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> ダメージ、<DisarmKeywords:麻痺> を与えます。"
  },
  Skill_45489_Name_1 = {
    Text = "王権の威"
  },
  Skill_4548_Desc = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_4548_Name = {
    Text = "上位狂気"
  },
  Skill_45490_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<DisarmKeywords:麻痺>。"
  },
  Skill_45490_Name_1 = {
    Text = "永遠の威圧"
  },
  Skill_45491_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与え、対象に<PVPSlowKeywords:鈍化>を付与。"
  },
  Skill_45492_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>の傷害を与え、目標を殺した場合、他の敵に同量の<PVPBleedingKeywords:出血>を与えます。"
  },
  Skill_45492_Name_1 = {
    Text = "消滅の予言"
  },
  Skill_45493_Desc_1 = {
    Text = "敵1体のポジティブステータスを駆散し、<Damage:[Damage:Arg1]> ダメージを与え、<PVPCapKeywords:行動力上限> - [Arg2]。"
  },
  Skill_45493_Name_1 = {
    Text = "深海の呪い"
  },
  Skill_45494_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>し、敵1名に<PVPSeriousInjuryKeywords:重傷>を負わせ、<Damage:[Arg1]>ライフを失わせます。"
  },
  Skill_45494_Name_1 = {
    Text = "揺蕩うクラゲの責苦"
  },
  Skill_45495_Desc_1 = {
    Text = "ランダムに[Arg1]回の<Damage:[Damage:Arg2]> ダメージを与え、<Damage:[Arg3]> のHPを失う。"
  },
  Skill_45495_Name_1 = {
    Text = "双方向刺突"
  },
  Skill_45496_Desc_1 = {
    Text = "すべての敵のバフを解除し、<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_45496_Name_1 = {
    Text = "深淵への祈祷"
  },
  Skill_45497_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45497_Name_1 = {Text = "攻撃"},
  Skill_45498_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45498_Name_1 = {Text = "攻撃"},
  Skill_45499_BattleDesc_1 = {
    Text = "<Heal:[Heal:Arg4]> ライフを回復し、[Arg2] ライフ失うごとに回復量 + [Arg3]。"
  },
  Skill_45499_Desc_1 = {
    Text = "<Heal:[Heal:Arg1]> HP回復。HP[Arg2]を失うごとに回復量+[Arg3]。"
  },
  Skill_45499_Name_1 = {
    Text = "改造治療"
  },
  Skill_4549_Desc = {
    Text = "すべての敵に2点の<WeaknessIconKeywords:虚弱>を付与。"
  },
  Skill_4549_Name = {
    Text = "上位虚弱"
  },
  Skill_45500_BattleDesc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg4]> ダメージを与え、[Arg2] ライフ失うごとにダメージ + [Arg3]、同時に「打撃」として扱う。"
  },
  Skill_45500_Desc_1 = {
    Text = "敵全体に<Damage:[Damage:Arg1]> ダメージを与え、HP[Arg2]を失うごとにダメージ+[Arg3]。同時に「打撃」として扱う。"
  },
  Skill_45500_Name_1 = {
    Text = "返しの一撃"
  },
  Skill_45501_Desc_1 = {
    Text = "<HPAndShieldMin:ライフとシールドが最も低い>敵に <Damage:[Damage:Arg1]> ダメージを与え、敵をキルした場合は他の味方に <Energy:[Energy:Arg2]> 狂気を付与する。"
  },
  Skill_45501_Name_1 = {
    Text = "根源の海"
  },
  Skill_45502_Desc_1 = {
    Text = "<TauntKeywords:挑発>し、自身を<PVPVulnerabilityIconKeywords:軟化>にする。次のターンまで、アクティブダメージを受けるたびに<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_45502_Name_1 = {
    Text = "痛くないよ"
  },
  Skill_45503_Desc_1 = {
    Text = "他の任意の対象に[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得させ、対象から<Energy:[Energy:Arg2]>狂気を奪い、<PVPEmptinessKeywords:虚無>を付与する。"
  },
  Skill_45503_Name_1 = {
    Text = "無限の空虚"
  },
  Skill_45504_BattleDesc_1 = {
    Text = "ランダムに <Damage:[Damage:Arg4]> ダメージを与え、[Arg2] ライフ不足するごとにダメージ + [Arg3]。"
  },
  Skill_45504_Desc_1 = {
    Text = "ランダムに <Damage:[Damage:Arg1]> ダメージを与え、生命が[Arg2]不足するごとにダメージ+[Arg3]。"
  },
  Skill_45504_Name_1 = {
    Text = "呪縛の鎖"
  },
  Skill_45505_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、ダメージの半分のライフを回復。"
  },
  Skill_45505_Name_1 = {
    Text = "深海の力"
  },
  Skill_45506_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>：味方1体を復活させ、対象のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45506_Name_1 = {
    Text = "理性、真理と現実"
  },
  Skill_4550_Desc = {
    Text = "すべての敵に2点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_4550_Name = {
    Text = "上位易傷"
  },
  Skill_45510_Desc_1 = {
    Text = "選択：すべての味方に<Energy:[Energy:Arg1]>狂気を与えるか、すべての味方に<Block:[Block:Arg2]>点のシールドを与える。"
  },
  Skill_45510_Name_1 = {
    Text = "特別製剤"
  },
  Skill_45511_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45511_Name_1 = {Text = "攻撃"},
  Skill_45512_BattleDesc_1 = {
    Text = "合計 <Damage:[Damage:Arg4]> ダメージを与え、全ての演算力を消費する。演算力を[Arg2]消費するごとにダメージ+[Arg3]。全ての敵に均等に分配し、各敵は <Damage:[Damage:Arg5]> ダメージを受ける。"
  },
  Skill_45512_Desc_1 = {
    Text = "合計<Damage:[Damage:Arg1]> ダメージを与え、全ての演算力を消費し、演算力[Arg2]消費ごとにダメージ+[Arg3]。ダメージは全ての敵に均等に分配される。"
  },
  Skill_45512_Name_1 = {
    Text = "死告の舞い"
  },
  Skill_45513_Desc_1 = {
    Text = "[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得。"
  },
  Skill_45513_Name_1 = {Text = "戦意"},
  Skill_45514_Desc_1 = {
    Text = "本ラウンドに「打撃」を使用した場合、「打撃」+ [Arg1]％ ダメージ<PVPPenetrateKeywords:貫通>；使用しなかった場合、ラウンド終了時 +[Arg2] <PVPProtectiveKeywords:バリア>。"
  },
  Skill_45514_Name_1 = {
    Text = "星獣の底力"
  },
  Skill_45515_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_45515_Name_1 = {
    Text = "穢悪の嵐"
  },
  Skill_45516_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> <PVPCardLockKeywords:カード封鎖>を引き起こす。"
  },
  Skill_45516_Name_1 = {
    Text = "次元の追跡"
  },
  Skill_45517_Desc_1 = {
    Text = "他の覚醒体の手札をすべて捨て、同数+[Arg1]枚のランダムな<PVPMouseKeywords:鼠のカード><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>を手札に追加する。<PVPPowerIconKeywords:力>+[Arg2]。"
  },
  Skill_45517_Name_1 = {
    Text = "霧都の街童"
  },
  Skill_45518_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_11:「不平等な交換」>を[Arg1]枚手札に追加する。"
  },
  Skill_45518_Name_1 = {
    Text = "失われた古都"
  },
  Skill_45519_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45519_Name_1 = {Text = "攻撃"},
  Skill_4551_Desc = {
    Text = "2点の行動力を獲得。"
  },
  Skill_4551_Name = {
    Text = "上位算力"
  },
  Skill_45520_Desc_1 = {
    Text = "すべての敵の<PVPMethysisKeywords:毒>を発動する。"
  },
  Skill_45520_Name_1 = {Text = "有毒"},
  Skill_45521_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<PVPMethysisKeywords:毒>。"
  },
  Skill_45522_Desc_1 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> ダメージ、<PVPMethysisKeywords:中毒> を与えます。"
  },
  Skill_45522_Name_1 = {
    Text = "毒の蔓延"
  },
  Skill_45523_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_45523_Name_1 = {
    Text = "黎明のフレア"
  },
  Skill_45524_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>の<PVPBleedingKeywords:出血>ダメージを与える。"
  },
  Skill_45524_Name_1 = {
    Text = "彗星の落下"
  },
  Skill_45525_Desc_1 = {
    Text = "<StrengthenKeywords:強化>と<PVPProtectiveKeywords:バリア>を獲得。"
  },
  Skill_45525_Name_1 = {
    Text = "守護の緑炎"
  },
  Skill_45526_BattleDesc_1 = {
    Text = "敵1体のポジティブステータスを1つ解除し、<Damage:[Damage:Arg3]> ダメージを与え、自身の<PVPProtectiveKeywords:バリア>を取り除き、1層ごとにダメージ + [Arg2]。"
  },
  Skill_45526_Desc_1 = {
    Text = "敵1体のバフを駆散し <Damage:[Damage:Arg1]> ダメージを与え、自身の<PVPProtectiveKeywords:障壁>を除去し、1層ごとにダメージ+[Arg2]。"
  },
  Skill_45526_Name_1 = {
    Text = "「審判」"
  },
  Skill_45527_Desc_1 = {
    Text = "ランダムに [Arg1] 回 <Damage:[Damage:Arg2]> ダメージを与え、<PVPProtectiveKeywords:屏障>を獲得します。"
  },
  Skill_45527_Name_1 = {
    Text = "聖なる骨肉"
  },
  Skill_45528_BattleDesc_1 = {
    Text = "ランダムに [Arg1] 回 <Damage:[Damage:Arg4]> ダメージを与え、自身の<PVPProtectiveKeywords:バリア>を取り除き、1層ごとにダメージ + [Arg3]。"
  },
  Skill_45528_Desc_1 = {
    Text = "ランダムに[Arg1]回 <Damage:[Damage:Arg2]> ダメージを与え、自身の<PVPProtectiveKeywords:障壁>を除去し、1層ごとにダメージ+[Arg3]。"
  },
  Skill_45528_Name_1 = {
    Text = "「懲悪」"
  },
  Skill_45529_Desc_1 = {
    Text = "敵1体に対して <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>、<PVPPenetrateKeywords:贯穿> を与えます。"
  },
  Skill_45529_Name_1 = {
    Text = "血と砂の賛歌"
  },
  Skill_4552_Desc = {
    Text = "カードを2枚引く。"
  },
  Skill_4552_Name = {
    Text = "上位妙手"
  },
  Skill_45530_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45530_Name_1 = {Text = "攻撃"},
  Skill_45531_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_45531_Name_1 = {
    Text = "歪んだ死体の宴"
  },
  Skill_45532_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45532_Name_1 = {Text = "攻撃"},
  Skill_45533_Desc_1 = {
    Text = "前のターンで最後に使用した[Arg1]枚の「スキル」を手札に戻し、行動力消費を0にする。同様の効果が複数回発動した場合、さらに前のターンを参照。"
  },
  Skill_45533_Name_1 = {
    Text = "背理収束"
  },
  Skill_45534_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージとデバフの<PVPWonderfulEffectKeywords:不思議な効果>を与える。"
  },
  Skill_45534_Name_1 = {
    Text = "ごゆっくりお楽しみくださ～い！"
  },
  Skill_45535_Desc_1 = {
    Text = "<PVPDerivativeCardKeywords_10:「沸き上がる血」>を[Arg1]枚獲得。"
  },
  Skill_45535_Name_1 = {
    Text = "血の宣告"
  },
  Skill_45536_BattleDesc_1 = {
    Text = "ランダムに [Arg1] 回 <Damage:[Damage:Arg3]> ダメージを与え、<PVPCapKeywords:行動力上限>1点ごとに [Arg2] ダメージ増加。"
  },
  Skill_45536_Desc_1 = {
    Text = "ランダムに [Arg1] 回ダメージを与え、<PVPCapKeywords:行動力上限>1点ごとに [Arg2] ダメージ増加。"
  },
  Skill_45536_Name_1 = {Text = "叫喚"},
  Skill_45537_Desc_1 = {
    Text = "一名の敵に <Damage:[Damage:Arg1]> の <PVPBleedingKeywords:出血> を与え、"
  },
  Skill_45537_Name_1 = {
    Text = "血の哀歌"
  },
  Skill_45538_Desc_1 = {
    Text = "味方に正の<PVPWonderfulEffectKeywords:奇妙效果>を施すか、敵に負の<PVPWonderfulEffectKeywords:奇妙效果>を施します。"
  },
  Skill_45538_Name_1 = {
    Text = "創作デザート"
  },
  Skill_45539_Desc_1 = {
    Text = "味方1体の<Heal:[Heal:Arg1]>ライフを回復し、自分に使用した効果を半減させ、ポジティブな<PVPWonderfulEffectKeywords:奇妙な効果>を付与する。"
  },
  Skill_45539_Name_1 = {
    Text = "滋養のシチュー"
  },
  Skill_4553_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後列に「請願者」を召喚する。"
  },
  Skill_4553_Name = {
    Text = "分裂攻撃"
  },
  Skill_45540_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>狂気、手札のすべてのカードの使用回数を[Arg2]回復。"
  },
  Skill_45540_Name_1 = {
    Text = "食材補充"
  },
  Skill_45541_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> または <Damage:[Damage:Arg2]> または <Damage:[Damage:Arg3]> ダメージを引き起こし、<PVPPenetrateKeywords:刺突>。"
  },
  Skill_45541_Name_1 = {
    Text = "オールイン"
  },
  Skill_45542_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPProtectiveKeywords:バリア>を獲得。これは「攻撃」として扱う。"
  },
  Skill_45542_Name_1 = {
    Text = "環行軌跡"
  },
  Skill_45543_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与え、[Arg3]点の<PVPProtectiveKeywords:バリア>を獲得。"
  },
  Skill_45543_Name_1 = {
    Text = "死せる夢の都"
  },
  Skill_45544_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<DisarmKeywords:麻痺>、<PVPPenetrateKeywords:刺突>。"
  },
  Skill_45544_Name_1 = {
    Text = "電磁爆破"
  },
  Skill_45545_Desc_1 = {
    Text = "自身に<PVPVulnerabilityIconKeywords:軟化>を付与し、<DelayKeywords:遅延>：カードを[Arg1]枚引く。"
  },
  Skill_45545_Name_1 = {
    Text = "偉大な犠牲"
  },
  Skill_45546_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、[Arg2] 回繰り返す。「聖血の導き」ステータスの対象が存在する場合は優先して攻撃する。"
  },
  Skill_45546_Name_1 = {
    Text = "連綿たる本能"
  },
  Skill_45547_Desc_1 = {
    Text = "このターン中、対象が攻撃されるたび、最もライフを失っている味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45547_Name_1 = {
    Text = "聖血の導き"
  },
  Skill_45548_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>：すべての味方を復活させる。<DelayKeywords:遅延>：すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45548_Name_1 = {
    Text = "不死の極楽鳥"
  },
  Skill_45549_BattleDesc_1 = {
    Text = "指定した敵に<Damage:[Damage:Arg2]> ダメージを与え、演算力上限1につきダメージが[Arg1]増加。"
  },
  Skill_45549_Desc_1 = {
    Text = "指定した敵にダメージを与え、<PVPCapKeywords:行動力上限>1点ごとに [Arg1] ダメージ増加。"
  },
  Skill_45549_Name_1 = {
    Text = "火を追う虫"
  },
  Skill_4554_Desc = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得する。"
  },
  Skill_4554_Name = {Text = "日傘"},
  Skill_45550_Desc_1 = {
    Text = "カードを[Arg1]枚引く。"
  },
  Skill_45550_Name_1 = {
    Text = "埋もれた宝"
  },
  Skill_45551_Desc_1 = {
    Text = "山札の上から[Arg1]枚のカードを見て、1枚を手札に追加し、残りのカードは山札のランダムな位置に戻す。"
  },
  Skill_45551_Name_1 = {
    Text = "暗流の微光"
  },
  Skill_45552_Desc_1 = {
    Text = "<StrengthenKeywords:強化>全ての味方に<PVPProtectiveKeywords:バリア>を付与。"
  },
  Skill_45552_Name_1 = {
    Text = "準備完了"
  },
  Skill_45553_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45553_Name_1 = {Text = "攻撃"},
  Skill_45554_Desc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg1]>ダメージを与え、同量のシールドを獲得。"
  },
  Skill_45554_Name_1 = {
    Text = "七つの技、継承した美徳"
  },
  Skill_45555_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<DisarmKeywords:麻痺>、<PVPMethysisKeywords:毒>。"
  },
  Skill_45555_Name_1 = {
    Text = "人格汚染"
  },
  Skill_45556_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、ダメージと同量のシールドを獲得し、<TauntKeywords:挑発>を獲得。"
  },
  Skill_45556_Name_1 = {
    Text = "防御光線"
  },
  Skill_45557_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、<Block:[Block:Arg2]>シールドを獲得し、<StrongEffectKeywords:強力>+[Arg3]。"
  },
  Skill_45557_Name_1 = {
    Text = "終わりなき彫刻"
  },
  Skill_45558_Desc_1 = {
    Text = "すべての味方に<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_45558_Name_1 = {
    Text = "量子触媒"
  },
  Skill_45559_Desc_1 = {
    Text = "味方に <Block:[Block:Arg1]> シールドを与える。"
  },
  Skill_45559_Name_1 = {
    Text = "光学防護"
  },
  Skill_4555_Desc = {
    Text = "束縛を破り孵化し、次のターゲットを探している…"
  },
  Skill_4555_Name = {
    Text = "孵化再生"
  },
  Skill_45560_Desc_1 = {
    Text = "<HPAndShieldMin:ライフとシールドが最も低い>敵に <Damage:[Damage:Arg1]> ダメージを与える。死亡した覚醒体が1体いるごとに、追加で1回ダメージを与える。"
  },
  Skill_45560_Name_1 = {
    Text = "血風来臨"
  },
  Skill_45561_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45561_Name_1 = {Text = "攻撃"},
  Skill_45562_Desc_1 = {
    Text = "3枚の  <PVPDerivativeCardKeywords_15:「液化虚無」>を獲得。"
  },
  Skill_45562_Name_1 = {
    Text = "終点、真理と深淵の門"
  },
  Skill_45563_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、いずれかの敵を撃破した場合、「廻環剣技」を[Arg2]枚手札に加え、そのダメージ+[Arg3]。"
  },
  Skill_45563_Name_1 = {
    Text = "連鎖する剣技"
  },
  Skill_45564_Desc_1 = {
    Text = "<ReinforceKeywords:堅固>：味方1体のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45564_Name_1 = {
    Text = "理想郷の祝福"
  },
  Skill_45565_BattleDesc_1 = {
    Text = "[Arg3]回の<Damage:[Damage:Arg1]> ダメージを与え、死亡した味方1体につき追加で1回ダメージを与える。"
  },
  Skill_45565_Desc_1 = {
    Text = "[Arg2]回の<Damage:[Damage:Arg1]> ダメージを与え、死亡した味方1体につき追加で1回ダメージを与える。"
  },
  Skill_45565_Name_1 = {
    Text = "純白の波紋"
  },
  Skill_45566_Desc_1 = {
    Text = "味方1体の<Heal:[Heal:Arg1]>ライフを回復し、<TauntKeywords:挑発>を付与する。"
  },
  Skill_45566_Name_1 = {
    Text = "彼岸の灯台"
  },
  Skill_45567_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<PVPMethysisKeywords:毒>、<PVPPenetrateKeywords:刺突>。華やかな篇章：追加で [Arg2] 回発動。"
  },
  Skill_45567_Name_1 = {Text = "死の詩"},
  Skill_45568_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<DisarmKeywords:麻痺>、<PVPPenetrateKeywords:刺突>。華やかな篇章：追加で敵全体に [Arg2] 回適用。"
  },
  Skill_45568_Name_1 = {
    Text = "霊魂の詩"
  },
  Skill_45569_Desc_1 = {
    Text = "味方1体の<Heal:[Heal:Arg1]> ライフを回復し、<PVPPenetrateKeywords:刺突>。華やかな篇章：ターゲットのネガティブステータスを駆散し、追加で [Arg2] 回適用。"
  },
  Skill_45569_Name_1 = {Text = "命の詩"},
  Skill_4556_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45570_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45570_Name_1 = {Text = "攻撃"},
  Skill_45571_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45571_Name_1 = {Text = "攻撃"},
  Skill_45572_Desc_1 = {
    Text = "すべての味方の<DelayKeywords:遅延>治癒をすべて発動させ、ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_45572_Name_1 = {
    Text = "林檎磨きの抱擁"
  },
  Skill_45573_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45573_Name_1 = {Text = "攻撃"},
  Skill_45574_Desc_1 = {
    Text = "<StrongEffectKeywords:強力>＋[Arg1]、次の詩篇を増幅し、それに追加効果を付与する。"
  },
  Skill_45574_Name_1 = {
    Text = "華やかな章"
  },
  Skill_45575_Desc_1 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> ダメージ、<DisarmKeywords:麻痺> を与えます。"
  },
  Skill_45575_Name_1 = {
    Text = "星辰正しき刻"
  },
  Skill_45576_Desc_1 = {
    Text = "[Arg1] 枚の「打撃」を獲得。"
  },
  Skill_45576_Name_1 = {
    Text = "混沌の獣"
  },
  Skill_45577_Desc_1 = {
    Text = "<PVPHoldingKeywords:保持>：相手が最後に使用した「スキル」に変化し、そのコストを–[Arg1]する。"
  },
  Skill_45577_Name_1 = {
    Text = "星の擬態"
  },
  Skill_45578_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂気、[Arg2]層の<EnergyStorageKeywords:チャージ>を獲得。"
  },
  Skill_45578_Name_1 = {
    Text = "異常成長"
  },
  Skill_45579_Desc_1 = {
    Text = "<TauntKeywords:挑発>，次のターン開始まで、自己がアクティブ攻撃を受けた際に[Arg1]層の<EnergyStorageKeywords:蓄力>を獲得し、攻撃者に[Arg1]層の<PVPSlowKeywords:遅延>を与える。"
  },
  Skill_45579_Name_1 = {
    Text = "異常重力"
  },
  Skill_4557_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「お前のせいだ」を2体召喚する。"
  },
  Skill_4557_Name = {
    Text = "呼びかけ"
  },
  Skill_45580_Desc_1 = {
    Text = "<PVPProtectiveKeywords:バリア>、[Arg2] 枚ドローする。"
  },
  Skill_45580_Name_1 = {
    Text = "不死者の壁"
  },
  Skill_45582_Desc_1 = {
    Text = "すべての味方のデバフ状態を解除し、[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得。"
  },
  Skill_45582_Name_1 = {
    Text = "復活の音"
  },
  Skill_45583_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、<PVPSlowKeywords:遅延>を付与する。"
  },
  Skill_45584_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPPenetrateKeywords:貫通>する。これは「攻撃」として扱う。"
  },
  Skill_45584_Name_1 = {
    Text = "天を衝く歌声"
  },
  Skill_45585_BattleDesc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg4]> ダメージを与え、<PVPSlowKeywords:遅延>を付与し、[Arg2] シールドを持つごとにダメージ + [Arg3]。"
  },
  Skill_45585_Desc_1 = {
    Text = "敵全体に<Damage:[Damage:Arg1]> ダメージを与え、<PVPSlowKeywords:鈍足>を付与。シールド[Arg2]につきダメージ+[Arg3]。"
  },
  Skill_45585_Name_1 = {
    Text = "無限の正義"
  },
  Skill_45586_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_45586_Name_1 = {
    Text = "創造主の庇護"
  },
  Skill_45587_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPPenetrateKeywords:貫通>。"
  },
  Skill_45587_Name_1 = {
    Text = "魂の追撃"
  },
  Skill_45588_Desc_1 = {
    Text = "敵に<PVPVulnerabilityIconKeywords:軟化>を付与し、<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_45588_Name_1 = {Text = "レイズ"},
  Skill_45589_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、<PVPSlowKeywords:鈍足>を付与。"
  },
  Skill_45589_Name_1 = {
    Text = "カードトリック"
  },
  Skill_4558_AwakerSkillBackgroundStory = {
    Text = "学生たちはラモンナと目を合わせるのを避けている。\n噂では、あの青い目は心を見透かし、ラモンナの前ではすべての嘘が隠しきれないという。\nさらには、彼女がモノクルを外す日は神が降臨する時だとも言われている。\n「先輩たちの憶測なんて聞かないで。眼鏡は読書のためのもの」\n「私は最新型の嘘発見器じゃないわ。これくらいの推理は簡単じゃない？」"
  },
  Skill_4558_Desc_0 = {
    Text = "すべての敵から[Exhaustion:Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させる。カードを1枚引く。"
  },
  Skill_4558_Desc_2 = {
    Text = "すべての敵から[Exhaustion:Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させる。カードを1枚引き、引いたカードの行動力消費1点につき<Posse:[Arg2]>点の銀鍵エネルギーを獲得。"
  },
  Skill_4558_EffectNameList = {
    Text = "力の減少"
  },
  Skill_4558_Name = {
    Text = "攻勢演習"
  },
  Skill_4558_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_45590_Desc_1 = {
    Text = "ランダムな敵に [Arg2] 回 <Damage:[Damage:Arg1]> ダメージを与え、"
  },
  Skill_45590_Name_1 = {
    Text = "最高の一手だ！"
  },
  Skill_45591_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg3]> ダメージを与え、このカードをドロー山にシャッフルし、すべての「千面重畳」のダメージ + [Arg2]。"
  },
  Skill_45591_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、このカードをドローパイルに戻す。全ての「千面重畳」のダメージ+[Arg2]。"
  },
  Skill_45591_Name_1 = {
    Text = "千面重畳"
  },
  Skill_45592_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<PVPRaidKeywords:奇襲>：代わりに<Damage:[Damage:Arg3]>ダメージを与える。"
  },
  Skill_45592_Name_1 = {
    Text = "狂戦奇襲"
  },
  Skill_45593_Desc_1 = {
    Text = "敵全体に<Damage:[Damage:Arg1]> ダメージを与える。<PVPRaidKeywords:奇襲>：代わりに<Damage:[Damage:Arg3]> ダメージを与える。"
  },
  Skill_45593_Name_1 = {
    Text = "部族仕込みの電撃戦"
  },
  Skill_45594_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。敵を撃破した場合、<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_45594_Name_1 = {
    Text = "巨刃の重殺"
  },
  Skill_45595_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。<PVPSeriousInjuryKeywords:重傷>の影響を受けている対象には2倍のダメージを与える。"
  },
  Skill_45595_Name_1 = {
    Text = "深淵爆血"
  },
  Skill_45596_Desc_1 = {
    Text = "ランダムに <Damage:[Damage:Arg1]> ダメージを与え、ダメージの半分の一時的な<PVPRetaliateIconKeywords:反撃>を獲得し、同時に「打撃」と見なされます。"
  },
  Skill_45596_Name_1 = {
    Text = "逆鱗反撃"
  },
  Skill_45597_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重傷>し、<Damage:[Damage:Arg1]>ダメージを与え、<PVPPenetrateKeywords:刺突>します。"
  },
  Skill_45597_Name_1 = {Text = "鱗撃"},
  Skill_45598_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45598_Name_1 = {Text = "攻撃"},
  Skill_45599_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得し、他の味方に<Energy:[Energy:Arg2]>狂気を付与。"
  },
  Skill_45599_Name_1 = {
    Text = "ネゲントロピー演算"
  },
  Skill_4559_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45600_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45600_Name_1 = {Text = "攻撃"},
  Skill_45601_Desc_1 = {
    Text = "すべての敵の[Arg1]枚のランダムな「スキル」を確認し、[Arg2]枚を手札に追加、行動力消費を0にする。"
  },
  Skill_45601_Name_1 = {
    Text = "現実模倣"
  },
  Skill_45602_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>の傷害を与え、<ComaKeywords:昏睡>。"
  },
  Skill_45602_Name_1 = {
    Text = "永遠の瞳"
  },
  Skill_45603_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45603_Name_1 = {Text = "攻撃"},
  Skill_45604_Desc_1 = {
    Text = "味方1体に<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_45604_Name_1 = {
    Text = "授けられた権能"
  },
  Skill_45605_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_45605_Name_1 = {
    Text = "不屈の宣言"
  },
  Skill_45606_Desc_1 = {
    Text = "<PVPCapKeywords:行動力上限> + [Arg1]。"
  },
  Skill_45606_Name_1 = {
    Text = "ルルイエの贈り物"
  },
  Skill_45607_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。これは「攻撃」として扱う。"
  },
  Skill_45607_Name_1 = {
    Text = "狂乱の裂傷"
  },
  Skill_45608_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与える。"
  },
  Skill_45608_Name_1 = {
    Text = "権欲の輪舞"
  },
  Skill_45609_Desc_1 = {
    Text = "対象の解除可能なバフ状態をすべて奪い、<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_45609_Name_1 = {
    Text = "星のゆりかご"
  },
  Skill_4560_BattleDesc = {
    Text = "ライフを[Arg1]失い、その値の2倍のシールドを獲得する。売却不可。"
  },
  Skill_4560_Desc = {
    Text = "最大ライフの5%を失い、その値の2倍のシールドを獲得する。売却不可。"
  },
  Skill_4560_Name = {
    Text = "症状：閉所恐怖"
  },
  Skill_45610_BattleDesc_1 = {
    Text = "<TauntKeywords:挑発>、[Arg4]の一時的な<PVPRetaliateIconKeywords:反撃>を獲得。<PVPProtectiveKeywords:障壁>が[Arg2]あるごとに追加で[Arg3]の一時的な<PVPRetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_45610_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>、[Arg1]の一時的<PVPRetaliateIconKeywords:反撃>を得て、[Arg2]の<PVPProtectiveKeywords:バリア>があるたびに[Arg3]の一時的<PVPRetaliateIconKeywords:反撃>を追加で得る。"
  },
  Skill_45610_Name_1 = {
    Text = "迷夢の導き"
  },
  Skill_45611_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、"
  },
  Skill_45611_Name_1 = {Text = "脊椎針"},
  Skill_45612_Desc_1 = {
    Text = "<TauntKeywords:挑発>、<Block:[Block:Arg1]> シールド。"
  },
  Skill_45612_Name_1 = {
    Text = "迷宮の罠"
  },
  Skill_45613_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与え、<PVPEntanglementKeywords:纏着>。"
  },
  Skill_45613_Name_1 = {
    Text = "網縛殺法"
  },
  Skill_45614_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<PVPEntanglementKeywords:纏着>。"
  },
  Skill_45614_Name_1 = {
    Text = "蜘蛛の糸"
  },
  Skill_45615_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、<PVPEntanglementKeywords:纏着>を付与する。"
  },
  Skill_45615_Name_1 = {
    Text = "蒼白の庇護"
  },
  Skill_45616_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、<ComaKeywords:昏睡>させる。"
  },
  Skill_45616_Name_1 = {
    Text = "泥に咲く不滅の花"
  },
  Skill_45617_Desc_1 = {
    Text = "カードを[Arg1]枚引く。「運命の札」の場合、その行動力消費を0にする。そうでない場合、そのカードのコピーを[Arg2]枚手札に追加する。"
  },
  Skill_45617_Name_1 = {
    Text = "運命の職人"
  },
  Skill_45618_Desc_1 = {
    Text = "味方1体に<Block:[Block:Arg1]>点のシールドを与え、その「攻撃」を[Arg2]枚手札に追加する。"
  },
  Skill_45618_Name_1 = {
    Text = "ツールキット"
  },
  Skill_45619_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージを与え、<PVPMethysisKeywords:中毒>。"
  },
  Skill_45619_Name_1 = {
    Text = "錆びたレンチ"
  },
  Skill_4561_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45620_Desc_1 = {
    Text = "<TauntKeywords:挑発>し、カードを[Arg1]枚引く。"
  },
  Skill_45620_Name_1 = {
    Text = "小さな守護者"
  },
  Skill_45621_Desc_1 = {
    Text = "<PVPWeaknessKeywords:倦怠>、<PVPVulnerabilityIconKeywords:軟化>。"
  },
  Skill_45621_Name_1 = {
    Text = "薔薇の腐臭"
  },
  Skill_45622_BattleDesc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg3]> ダメージを与え、すべての手札を捨て、すべての<EnergyStorageKeywords:蓄力>を除去する。手札1枚と<EnergyStorageKeywords:蓄力>1層ごとにダメージ + [Arg2]。"
  },
  Skill_45622_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与え、すべての手札を捨てすべての<EnergyStorageKeywords:チャージ>を除去する。手札1枚と<EnergyStorageKeywords:チャージ>1層ごとにダメージ+[Arg2]。"
  },
  Skill_45622_Name_1 = {
    Text = "絶望からの生還"
  },
  Skill_45623_Desc_1 = {
    Text = "選択： [Arg1]点の行動力を獲得するか、カードを[Arg2]枚引く。"
  },
  Skill_45623_Name_1 = {
    Text = "先見の明"
  },
  Skill_45624_Desc_1 = {
    Text = "味方全体に<Block:[Block:Arg1]> シールドを付与、一時的に<StrongEffectKeywords:強効> +[Arg2]。"
  },
  Skill_45624_Name_1 = {
    Text = "虚偽の継承者"
  },
  Skill_45625_Desc_1 = {
    Text = "選択：すべての味方のライフを<Heal:[Heal:Arg1]>回復するか、すべての敵に<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_45625_Name_1 = {
    Text = "人格傾向観察実験"
  },
  Skill_45626_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与え、ランダムな<PVPAmazingMagicKeywords:驚異の魔術><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>を1枚手札に加える。"
  },
  Skill_45626_Name_1 = {
    Text = "マジックカーニバル"
  },
  Skill_45627_Desc_1 = {
    Text = "<DelayKeywords:遅延>：すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45627_Name_1 = {
    Text = "渇血狂乱"
  },
  Skill_45629_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>狂気、<TauntKeywords:挑発>。"
  },
  Skill_45629_Name_1 = {
    Text = "芸術の狂熱"
  },
  Skill_4562_Desc = {
    Text = "[Arg2]点のシールドと「悪意の放血」状態を獲得する。「悪意の放血」：ガードされなかったダメージを1回与えるたび、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4562_Name = {
    Text = "海の料理"
  },
  Skill_45630_Desc_1 = {
    Text = "ランダムな<PVPAmazingMagicKeywords:驚きの魔術><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>を1枚手札に追加する。"
  },
  Skill_45630_Name_1 = {
    Text = "魔術師の隠し蔵"
  },
  Skill_45631_Desc_1 = {
    Text = "すべての手札を捨て、同数のカードを引く。手札が0枚の場合、追加でカードを1枚引く。"
  },
  Skill_45631_Name_1 = {
    Text = "シャッフル"
  },
  Skill_45632_Desc_1 = {
    Text = "味方1体を<StrengthenKeywords:強化>、<ReinforceKeywords:堅固>にする。"
  },
  Skill_45632_Name_1 = {
    Text = "祝福の魔法コイン"
  },
  Skill_45633_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45633_Name_1 = {Text = "攻撃"},
  Skill_45634_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_45634_Name_1 = {Text = "攻撃"},
  Skill_45635_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<TauntKeywords:嘲讽>の影響を受けているターゲットに三倍のダメージを与え、ターゲットが<TauntKeywords:嘲讽>を受けるように強いる。"
  },
  Skill_45635_Name_1 = {
    Text = "前線戦術"
  },
  Skill_45636_Desc_1 = {
    Text = "すべての味方が[Arg1]点の<EnergyStorageKeywords:蓄力>を獲得。"
  },
  Skill_45636_Name_1 = {
    Text = "戦闘の啓示"
  },
  Skill_45637_Desc_1 = {
    Text = "<TauntKeywords:挑発>し、デバフ状態を解除する。"
  },
  Skill_45637_Name_1 = {
    Text = "騎士の熱意"
  },
  Skill_45638_Desc_1 = {
    Text = "[Arg1]点の行動力を獲得。"
  },
  Skill_45638_Name_1 = {
    Text = "効率的思考"
  },
  Skill_45639_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_45639_Name_1 = {
    Text = "ミサゴの刃"
  },
  Skill_4563_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45640_Desc_1 = {
    Text = "<PVPHoldingKeywords:保有>：このターン中に最後に使用した「スキル」として扱う。"
  },
  Skill_45640_Name_1 = {
    Text = "模擬演繹"
  },
  Skill_45641_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、自身のシールドを倍増させ、「打撃」と見なされる。"
  },
  Skill_45641_Name_1 = {
    Text = "正義の裁き"
  },
  Skill_45642_Desc_1 = {
    Text = "<TauntKeywords:挑発>し、<PVPDerivativeCardKeywords_1:「心眼の一撃」>を[Arg1]枚獲得。"
  },
  Skill_45642_Name_1 = {
    Text = "戦地の守護"
  },
  Skill_45643_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、[Arg2]点の<EnergyStorageKeywords:蓄力>を獲得する。"
  },
  Skill_45643_Name_1 = {
    Text = "防御モード"
  },
  Skill_45644_Desc_1 = {
    Text = "<TauntKeywords:挑発>、<ReinforceKeywords:堅固>。"
  },
  Skill_45644_Name_1 = {
    Text = "機械障壁"
  },
  Skill_45645_Desc_1 = {
    Text = "すべての味方に<Block:[Block:Arg1]>点のシールドを与える。"
  },
  Skill_45645_Name_1 = {
    Text = "力場防護"
  },
  Skill_45646_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<DisarmKeywords:麻痺>。"
  },
  Skill_45646_Name_1 = {
    Text = "過負荷電流"
  },
  Skill_45647_Desc_1 = {
    Text = "<DelayKeywords:遅延>：味方1体のデバフ状態を解除し、その味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45647_Name_1 = {
    Text = "凝血治癒"
  },
  Skill_45648_Desc_1 = {
    Text = "行動力を全回復する。"
  },
  Skill_45648_Name_1 = {
    Text = "世界演繹法"
  },
  Skill_45649_Desc_1 = {
    Text = "<PVPCapKeywords:行動力上限> + [Arg1]，<Energy:[Energy:Arg2]> 狂気。"
  },
  Skill_45649_Name_1 = {
    Text = "歓喜の果実"
  },
  Skill_4564_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>を付与し、[Arg2]点の<PowerIconKeywords:力>を減少させる。"
  },
  Skill_4564_Name = {
    Text = "侵蝕の視線"
  },
  Skill_45650_Desc_1 = {
    Text = "すべての敵に<PVPSeriousInjuryKeywords:重傷>を付与し、<Damage:[Damage:Arg1]>ダメージを与える。対象がすでに<PVPSeriousInjuryKeywords:重傷>を受けている場合、ダメージは2倍になる。"
  },
  Skill_45650_Name_1 = {
    Text = "賑やかな海"
  },
  Skill_45651_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、与えたダメージと同量のシールドを獲得し、同時に「打撃」として扱う。"
  },
  Skill_45651_Name_1 = {
    Text = "心眼の一撃"
  },
  Skill_4565_Desc = {
    Text = "<DerivativeCardKeywords_23:「傷口」>を[Arg1]枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4566_Desc = {
    Text = "自身を生贄として献上し、自身のライフを「提灯教牧」のライフに変換する。"
  },
  Skill_4566_Name = {Text = "献上"},
  Skill_45676_Desc_1 = {
    Text = "すべての敵のバフ状態を解除する。"
  },
  Skill_45676_Name_1 = {
    Text = "狂言のマジックカード"
  },
  Skill_45677_Desc_1 = {
    Text = "すべての味方のデバフ状態を解除する。"
  },
  Skill_45677_Name_1 = {
    Text = "ウサギ帽子"
  },
  Skill_45678_Desc_1 = {
    Text = "<HPAndShieldMin:ライフとシールドが最も低い>敵に <Damage:[Damage:Arg1]> ダメージを与え、<DisarmKeywords:麻痺>させる。"
  },
  Skill_45678_Name_1 = {Text = "帯電鼠"},
  Skill_45679_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>：味方1体を復活させ、そのライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_45679_Name_1 = {
    Text = "反転分離の魔法箱"
  },
  Skill_4567_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45680_Desc_1 = {
    Text = "選択：すべての味方のデバフ状態を解除するか、またはすべての敵のバフ状態を解除する。"
  },
  Skill_45680_Name_1 = {
    Text = "白い鳩のハンカチ"
  },
  Skill_45681_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、<PVPMethysisKeywords:毒>状態にする。"
  },
  Skill_45681_Name_1 = {Text = "疫病鼠"},
  Skill_45682_Desc_1 = {
    Text = "すべての味方に<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_45682_Name_1 = {
    Text = "テレパシーマイク"
  },
  Skill_45683_Desc_1 = {
    Text = "ランダムに[Arg1]回<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_45683_Name_1 = {Text = "痴呆鼠"},
  Skill_45684_Desc_1 = {
    Text = "ランダムに [Arg1] 回 <Damage:[Damage:Arg2]> ダメージを与え、<Energy:[Energy:Arg3]> 点狂気を獲得します。"
  },
  Skill_45684_Name_1 = {
    Text = "沸き上がる血"
  },
  Skill_4568_Desc = {
    Text = "敵を気絶させ、その<RetaliateIconKeywords:反撃>点数をクリアする。"
  },
  Skill_4568_Name = {Text = "石ころ"},
  Skill_45692_Desc = {
    Text = "山札の指令カード1枚をランダムに凍結し、1点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_45692_Name = {
    Text = "氷霜の叫び"
  },
  Skill_4569_Desc = {
    Text = "ターン終了時に手札にある場合、自身が1ターンの<FragileIconKeywords:脆弱>になる。使用後、すべての敵を1ターンの<VulnerabilityIconKeywords:易傷>にする。売却不可。"
  },
  Skill_4569_Name = {
    Text = "症状：崩壊"
  },
  Skill_45704_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_45708_AwakerSkillBackgroundStory = {
    Text = "彼が巨大な剣を掲げれば、必ず血と死がもたらされる。"
  },
  Skill_45708_Desc_0 = {
    Text = "<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。この戦闘中「巨刃の威」と「斬首一閃」の基礎ダメージが25%増加する。"
  },
  Skill_45708_Desc_3 = {
    Text = "<DerivativeCardKeywords_17:「巨剣の威」>を3枚手札に追加する。この戦闘中「巨刃の威」と「斬首一閃」の基礎ダメージが25%増加する。ゴリアテは <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_45708_Name = {Text = "潜伏"},
  Skill_45709_AwakerSkillBackgroundStory = {
    Text = "彼が巨大な剣を掲げれば、必ず血と死がもたらされる。"
  },
  Skill_45709_Desc_0 = {
    Text = "<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。触腕ダメージの[Arg1]%の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_45709_Desc_3 = {
    Text = "<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。触腕ダメージの[Arg1]%の一時的な<PowerIconKeywords:力>を獲得する。ゴリアテは[Arg2]%の一時的なクリティカル率を獲得。"
  },
  Skill_45709_EffectNameList = {
    Text = "触腕ダメージ割合"
  },
  Skill_45709_Name = {Text = "簒奪"},
  Skill_4570_AwakerSkillBackgroundStory = {
    Text = "輝け、故郷の在り処へ向かって。"
  },
  Skill_4570_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4570_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。触腕1本に2回攻撃させ、50%のダメージを与える。"
  },
  Skill_4570_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ファロスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4570_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ファロスは<Energy:[Energy:Arg2]>狂気を獲得。触腕1本に2回攻撃させ、50%のダメージを与える。"
  },
  Skill_4570_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4570_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4571_Desc = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得。<Block:[Block:Arg2]>シールドを獲得。"
  },
  Skill_4571_EffectNameList = {
    Text = "シールド"
  },
  Skill_4571_Name = {
    Text = "シルバーキー"
  },
  Skill_4571_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_4572_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、味方全体が<Block:[Block:Arg3]>点のシールドを獲得し、後退する。"
  },
  Skill_4573_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4574_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4574_Name = {
    Text = "猟槍の突き"
  },
  Skill_4575_AwakerSkillBackgroundStory = {
    Text = "それは、珊瑚で築かれた古代の廃墟だった。\n最初に現れたのは、海水に漂う白い光の輪。\nやがて、高い階段、ねじれた浮彫、高くそびえる石柱が姿を現した……\n——ドン！\nすべてが突如として止まり、海底の失われた芸術がついにそのヴェールを脱いだ。\n彼女は行かなければならない——芸術の在処へと。"
  },
  Skill_4575_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得します。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、各シールドはダメージを[Arg3]ポイント増加させ、このスキルはさらに[Arg4]%のクリティカル率とクリティカルダメージのボーナスを受けます。ボスバトルでは、このスキルは追加で1回のダメージを与えます。"
  },
  Skill_4575_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、シールド1点ごとに与えるダメージが[Arg3]増加し、[Arg4]%のクリティカル率とクリティカルダメージボーナスを獲得する。ボス戦では、追加でダメージを1回与える。"
  },
  Skill_4575_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得します。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、各シールドはダメージを[Arg3]ポイント増加させ、このスキルはさらに[Arg4]%のクリティカル率とクリティカルダメージのボーナスを受けます。ボスバトルでは、このスキルは追加で1回のダメージを与えます。"
  },
  Skill_4575_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、シールド1点ごとに与えるダメージが[Arg3]増加し、[Arg4]%のクリティカル率とクリティカルダメージボーナスを獲得する。ボス戦では追加でダメージを1回与える。"
  },
  Skill_4575_EffectNameList_0 = {
    Text = "シールド,ダメージ"
  },
  Skill_4575_Name = {
    Text = "失われた芸術"
  },
  Skill_4575_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg5]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、シールド1点ごとにダメージが[Arg3]増加し、[Arg4]%のクリティカル率とクリティカルダメージボーナスを獲得する。ボス戦では追加でダメージを1回与える。この戦闘中、「失われた芸術」と「攻撃」が与えるダメージは追加で100%のシールドボーナスを獲得する。"
  },
  Skill_4575_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg5]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg2]>ダメージを与え、シールド1点ごとにダメージが[Arg3]増加し、[Arg4]%のクリティカル率とクリティカルダメージボーナスを獲得する。ボス戦では追加でダメージを1回与える。この戦闘中、「失われた芸術」と「攻撃」が与えるダメージは追加で100%のシールドボーナスを獲得する。"
  },
  Skill_4575_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4576_AwakerSkillBackgroundStory = {
    Text = "「あなたの頭を私に渡しなさい」\n\n「お気に入りのコレクションの一つにして、次元の海を漂わせてあげる」\n\n首狩りの魔女は口元を上げ、何気なく言う。\n\n「運が良ければ、いつでも私のそばにいられるかもね？」"
  },
  Skill_4576_BattleDesc_0 = {
    Text = "ライフが最も低い敵に<Damage:[Damage:Arg1]>ダメージを与える。力は「断頸の一撃」に5倍の効果を発揮する。ダフォダイルが任意の方法で敵を撃破した後、「断頸の一撃」の基礎ダメージがこのステージ中、永続的に25%増加する（現在[Arg3]回）。<TransitionIconKeywords:跳躍>：代わりにライフが最も高い敵に<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_4576_Desc_0 = {
    Text = "ライフが最も低い敵に<Damage:[Damage:Arg1]>ダメージを与える。力は「断頸の一撃」に5倍の効果を発揮する。ダフォダイルが任意の方法で敵を撃破した後、「断頸の一撃」の基礎ダメージがこのステージ中、永続的に25%増加する。<TransitionIconKeywords:跳躍>：代わりにライフが最も高い敵に<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_4576_EffectNameList = {
    Text = "ダメージ,跳躍ダメージ"
  },
  Skill_4576_Name = {
    Text = "首切りの一撃"
  },
  Skill_4576_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4577_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg4]回与える。カード[Arg2]枚に「水底の印」を付与する：「水底の印」：使用後、敵が一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4577_Name = {
    Text = "獲物の印"
  },
  Skill_4578_AwakerSkillBackgroundStory = {
    Text = "これは彼女が防いだ第∞+1回目の攻撃だ。"
  },
  Skill_4578_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<TimeBeacon:ループ>：すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg3]点減少させ、カードを1枚引き、環行・ラモンナが追加で<Energy:[Energy:Arg5]>狂気を獲得。"
  },
  Skill_4578_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。環行・ラモンナが<Energy:[Energy:Arg2]>狂気を獲得。<TimeBeacon:ループ>：すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg3]点減少させ、カードを1枚引き、環行・ラモンナが追加で<Energy:[Energy:Arg5]>狂気を獲得。"
  },
  Skill_4578_EffectNameList = {
    Text = "シールド,狂気,一時的な力減少"
  },
  Skill_4578_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,防御力×GrowValue3"
  },
  Skill_4579_AwakerSkillBackgroundStory = {
    Text = "魔術師は言った。\n「異教徒の数は多い。我らリヴァントは、孤立無援のようだ。\nユウハシュ兄弟よ、角笛を吹き鳴らせ。狂人のごとく戦い、斬り伏せよ」\n\n戦士は答えた。\n「ここに異教徒などいない。\n私はお前たち全てを屠る。死者に民族も信仰も関係ない。\nやがて屍が谷を埋め尽くし、山頂を覆い尽くす時——それこそが、私が血と砂へ捧げる賛歌だ」"
  },
  Skill_4579_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：この戦闘で以降に発動する「血と砂の賛歌」のダメージが[Arg4]増加し、獲得する力ボーナスが[Arg3]倍になる。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得。ユウハシュは<Energy:[Energy:Arg5]>狂気を獲得。"
  },
  Skill_4579_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：この戦闘で以降に発動する「血と砂の賛歌」のダメージが[Arg4]増加し、力倍率が[Arg3]倍になる。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。<PowerIconKeywords:力>は「血と砂の賛歌」で[Arg2]倍の効果を発揮。ユウハシュの狂気チャージの2倍に等しい狂気を獲得。"
  },
  Skill_4579_EffectNameList = {
    Text = "ダメージ,ダメージアップ"
  },
  Skill_4579_Name = {
    Text = "血と砂の賛歌"
  },
  Skill_4579_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食>：この戦闘で以降に発動する「血と砂の賛歌」のダメージが[Arg4]増加し、獲得する力ボーナス[Arg3]倍になる。】すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得。ユウハシュは<Energy:[Energy:Arg5]>狂気を獲得。「虚無」と「除外」が付与された「叫べ、血よ！」を、手札に上限まで追加する。このターン、ユウハシュのダメージ回数が1回増加。"
  },
  Skill_4579_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4580_Desc = {
    Text = "自身の後ろに「提灯」を1体召喚する。"
  },
  Skill_4580_Name = {
    Text = "聖礼儀式"
  },
  Skill_4581_AwakerSkillBackgroundStory = {
    Text = "聖堂の下に隠された空間がある。\n\n司教は石板の前に跪き、創生の初めに残された密語を吟唱する。\n\n時の流れに忘れ去られたルーンが光を放ち、司教の意志に応じて巨大な虚影を現し、その光の下にいる者に創造主の「祝福」を授ける。"
  },
  Skill_4581_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食> : [Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、一時的なクリティカル率+[Arg4]%。】 <Block:[Block:Arg2]>点のシールドを獲得。すべての敵に1点の<VulnerabilityIconKeywords:易傷>を付与。次のターン開始まで、受けたダメージの[Arg3]%を猩紅炉に蓄積する。"
  },
  Skill_4581_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、一時的なクリティカル率+[Arg4]%。】<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に1点の易傷を付与。次のターン開始まで、受けたダメージの[Arg3]%を猩紅炉に蓄積する。サルバドルは[Arg5]%の一時的なクリティカルダメージを獲得。"
  },
  Skill_4581_EffectNameList = {
    Text = "一時的な力,シールド,猩紅炉変換量"
  },
  Skill_4581_Name = {
    Text = "創造主の庇護"
  },
  Skill_4581_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：[Power:Arg1] 点の一時的な<PowerIconKeywords:力>と、一時的なクリティカルレート +[Arg4]% を得る。】<Block:[Block:Arg2]> 点のシールドを得る。全ての敵に1ターン<VulnerabilityIconKeywords:易傷>を付与する。次のターン開始まで、攻撃を受けた際にダメージの [Arg6]% を猩紅炉の回復量に変換する。サルバドルの「基礎打撃」と「苦痛の解消」が追加で100%の力ボーナスを享受する。本探索内の猩紅炉上限が最大ライフの2％上昇し、最大10％まで上昇する。"
  },
  Skill_4581_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:捕食>： [Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得し、一時的なクリティカル率が+[Arg4]％増加。]<Block:[Block:Arg2]>点のシールドを獲得。<VulnerabilityIconKeywords:易傷>すべての敵に1ターン。次のターン開始まで、攻撃を受けるとダメージの[Arg6]%を猩紅炉回復量に変換する。サルバドルは[Arg5]%の一時的なクリティカルダメージを獲得する。サルバドルの「基礎打撃」と「苦痛の解消」は追加で100%の力のボーナスを享受する。この探索内で猩紅炉の上限は最大ライフの2%まで増加し、最大で10%まで上昇する。"
  },
  Skill_4581_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2,$GrowValue3%"
  },
  Skill_4582_BattleDesc = {
    Text = "すべての覚醒体が <Energy:[Arg1]> 点の狂気を獲得し、次のターン開始時に最大ライフの5%（[Arg3]）の<SacrificeKeyWord:犠牲>を受ける。"
  },
  Skill_4582_Desc = {
    Text = "すべての覚醒体が <Energy:[Arg1]> 点の狂気を獲得し、次のターン開始時に最大ライフの5%の<SacrificeKeyWord:犠牲>を受ける。"
  },
  Skill_4582_Name = {
    Text = "不朽の葬儀"
  },
  Skill_4584_Desc = {
    Text = "恥ずかしいけど役に立つ、鍵を持ち帰ることが最優先だよね。"
  },
  Skill_4584_Name = {Text = "逃走"},
  Skill_4585_AwakerSkillBackgroundStory = {
    Text = "ナウティラは、つい周囲に人がいることを忘れてしまう。\nそのせいで、周りはたびたび巻き込まれて、騒ぎになることもしばしば。\n\n「ごめんなさい、わざとじゃないの。今すぐメモを貼って自分に注意するわ——えっと、何を書くんだっけ？」\n\nそんな彼女のために、キャンパスの一角には専用作業エリアが用意された。\nそこなら、彼女は思う存分に金属を加工できる。\nまさか、彼女が高熱レーザーを壁状に展開するなんて——"
  },
  Skill_4585_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]層の一時的な<RetaliateIconKeywords:反撃>を獲得。ボス戦では、3倍の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4585_EffectNameList_0 = {
    Text = "シールド,一時的な反撃"
  },
  Skill_4585_Name = {
    Text = "高温注意"
  },
  Skill_4585_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4586_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4587_AwakerSkillBackgroundStory = {
    Text = "これは彼女が振るう第∞+1回目の剣閃だ。"
  },
  Skill_4587_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。<TimeBeacon:ループ>：[Arg3]回ダメージを与え、環行・ラモンナのクリティカル率+[Arg5]%。"
  },
  Skill_4587_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「環行・ラモンナ」が<Energy:[Energy:Arg2]>狂気を獲得する。<TimeBeacon:ループ>：[Arg3]回ダメージを与え、環行・ラモンナのクリティカル率+[Arg5]%。"
  },
  Skill_4587_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4587_Name = {Text = "攻撃"},
  Skill_4587_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4588_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手に[Arg3]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4589_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4590_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4591_AwakerSkillBackgroundStory = {
    Text = "何度も闇に飲み込まれる痛みは、彼女の闇への恐怖を生んだ。\nまぶたを閉じる一瞬の暗がりすら、彼女には耐えがたい。\n\n「笑えばいい！あなた達は全然わかってない。あの黒い……黒いものが……がどれほど恐ろしいか」"
  },
  Skill_4591_Desc_0 = {
    Text = "ウインクルは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ウインクルが獲得するシールドと反撃が10％増加。カードを使用した後、<Energy:[Energy:Arg2]>狂気と[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4591_Desc_15 = {
    Text = "ウインクルは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ウインクルが獲得するシールドと反撃が10％増加。カード使用した後、<Energy:[Energy:Arg2]>狂気と[Counterattack:Arg3]層の<RetaliateIconKeywords:反撃>を獲得。狂気が最も低い他の覚醒体は80狂気を獲得。"
  },
  Skill_4591_EffectNameList = {
    Text = "狂気,反撃"
  },
  Skill_4591_Name = {
    Text = "自己の封鎖"
  },
  Skill_4591_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4592_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後列に「請願者」を召喚する。"
  },
  Skill_4592_Name = {
    Text = "分裂攻撃"
  },
  Skill_4594_Desc = {
    Text = "相手に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4597_Desc = {
    Text = "すべての味方が[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4597_Name = {
    Text = "全体強化"
  },
  Skill_4598_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4599_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4600_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4601_AwakerSkillBackgroundStory = {
    Text = "「星々とカダスはすでに備えを終えた。\n選ばれし眷属よ、汝はいま、輝きながらふたたび目覚めるのだ……」\n\nその時から、彼女の芸術にはただ一つの主題しか残されていなかった。\n彼女は狂想の中で我を忘れ、幻夢の中で静かに涙を流した。"
  },
  Skill_4601_Desc_0 = {
    Text = "シャンは <Energy:[Energy:Arg1]> 点の狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕数上限+1。シャンが与えるシールドが [Arg3]％上昇する。シャンがシールドを与えるたびに<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。"
  },
  Skill_4601_Desc_15 = {
    Text = "サンガーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕の上限+1。サンガーが獲得するシールドと最終ダメージが[Arg3]%増加し、永続的な触腕1本につき追加で3%増加する。サンガーがシールドを獲得するたび、<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg2]。"
  },
  Skill_4601_EffectNameList = {
    Text = "狂気,触腕ダメージ"
  },
  Skill_4601_Name = {
    Text = "忘我の境地"
  },
  Skill_4601_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4602_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、すべての教徒を吸収する。"
  },
  Skill_4602_Name = {
    Text = "苦痛の永続"
  },
  Skill_4603_AwakerSkillBackgroundStory = {
    Text = "この緑炎は、もはや彼女の一部となっている。\n彼女が指し示すところに、いかなる場所も燃え上がる。"
  },
  Skill_4603_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4603_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%ダメージの<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4603_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。リッツは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4603_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。リッツは<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%ダメージの<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4603_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4603_Name = {Text = "攻撃"},
  Skill_4603_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4604_AwakerSkillBackgroundStory = {
    Text = "「オジールは本当にいい子だね。大きくなったら娘の騎士になってくれないか？彼女も君が好きなんだ」\n「子爵家の子か？騎士団は年が幼いからといって訓練を軽くすることはないよ」\n「よくやった！どうやらオジールは将来、姫から直接任命されるだろうね」\n「退かないで、離宮を守れ！姫に誰も近づけさせるな！」\n「ありがとう、オジール……もういい、私が君を守るよ……」"
  },
  Skill_4604_Desc_0 = {
    Text = "オジールは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Power:Arg3]点の<PowerIconKeywords:力>を獲得。オジールのカードを使用した後、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4604_Desc_15 = {
    Text = "オジールは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>： [Power:Arg3]点の<PowerIconKeywords:力>を獲。オジールのカードを使用した後、 [Power:Arg2]点の<PowerIconKeywords:力>を獲得。この戦闘中に死亡抵抗が発動した場合、オジールの狂気解放で獲得する一時的な<PowerIconKeywords:力>が3倍になる。"
  },
  Skill_4604_EffectNameList = {
    Text = "狂気,力,カードの力の獲得"
  },
  Skill_4604_Name = {
    Text = "騎士の熱意"
  },
  Skill_4604_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue3,攻撃力×GrowValue2"
  },
  Skill_4605_Desc = {
    Text = "ランダムな覚醒体に一時的な封印を1点付与する。これを2回繰り返す。"
  },
  Skill_4606_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4607_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、このダメージは[Arg2]倍の力ボーナスを受け、[Arg3]％ダメージ分の<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4607_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4607_Name = {
    Text = "千変万化"
  },
  Skill_4607_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4608_Desc = {Text = "なし"},
  Skill_4609_Desc = {
    Text = "自身が[Arg1]点の<PowerIconKeywords:力>を獲得する。敵の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>状態を半分解除する。"
  },
  Skill_4609_Name = {
    Text = "力こそ正義"
  },
  Skill_4610_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4610_Name = {
    Text = "倦怠の一撃"
  },
  Skill_4611_Desc = {
    Text = "すべての覚醒体が20狂気を獲得する。「分裂症患者」を気絶させる。"
  },
  Skill_4611_Name = {
    Text = "鎮静の鈴"
  },
  Skill_46128_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後列に「多次元者」を召喚する。"
  },
  Skill_46128_Name = {
    Text = "次元フラクタル"
  },
  Skill_46129_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、後列に「多次元者」を召喚する。"
  },
  Skill_46129_Name = {
    Text = "次元フラクタル"
  },
  Skill_4612_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_46130_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>を獲得し、自身は<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_46130_Name = {
    Text = "全体強化"
  },
  Skill_46131_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_46135_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4613_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4614_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4615_AwakerSkillBackgroundStory = {
    Text = "ファイントは不完全だ。\n\nファイントは危険だ。\nファイントは呪われている。\nファイントは星々の彼方から来た、最も奇妙で華やかな色彩だ。"
  },
  Skill_4615_BattleDesc_15 = {
    Text = "ファイントが <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：即座に全ての敵から [Arg4] 点の<PowerIconKeywords:力量>を永続的に盗む。[Counterattack:Arg3] 層の<RetaliateIconKeywords:カウンター>を獲得する。本戦闘中デスレジスタンス発動の減衰率が 50% から 45% に低下する。ファイントがカードを発射した時、全ての敵から [Arg2] 点の<PowerIconKeywords:力量>を<TouquKeywords:盗む>。ターン終了時、前列の敵に 50% の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_4615_Desc_0 = {
    Text = "ファイントが <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：[Counterattack:Arg3] 層の<RetaliateIconKeywords:カウンター>を獲得する。本戦闘中デスレジスタンス発動の減衰率が 50% から 45% に低下する。ファイントがカードを発射した時、全ての敵から [Arg2] 点の<PowerIconKeywords:力量>を<TouquKeywords:盗む>。ターン終了時、前列の敵に 50% の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_4615_Desc_15 = {
    Text = "ファイントが <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：即座に全ての敵から [Arg4] 点の<PowerIconKeywords:力量>を永続的に盗む。[Counterattack:Arg3] 層の<RetaliateIconKeywords:カウンター>を獲得する。本戦闘中デスレジスタンス発動の減衰率が 50% から 45% に低下する。ファイントがカードを発射した時、全ての敵から [Arg2] 点の<PowerIconKeywords:力量>を<TouquKeywords:盗む>。ターン終了時、前列の敵に 50% の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_4615_EffectNameList = {
    Text = "狂気,カウンター,力奪取"
  },
  Skill_4615_Name = {
    Text = "無限の星空"
  },
  Skill_4615_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue3,攻撃力×GrowValue2"
  },
  Skill_4616_Desc = {
    Text = "[Arg1]点のシールドを獲得し、ガードされなかったダメージを与えた時にそのダメージの3倍のライフを回復し、この効果は[Arg2]ターン持続し、前進する。"
  },
  Skill_4616_Name = {
    Text = "手術準備"
  },
  Skill_4617_AwakerSkillBackgroundStory = {
    Text = "船員たちの絶望の叫びの中、彼女は静かに見守り、待っていた。\n穏やかな海面から泡が立ち上がり、現れたのは巨大な触腕。\nそれは素早くマストに絡みつき、海風に揺られて新たなる帆へと姿を変えた。\n「出航、出航！」\n水夫たちは歌う。\n「我らは幻の中を行く航海者！」"
  },
  Skill_4617_Desc = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。一時的な<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg2]。すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与する。触腕1本に敵を攻撃させ、[Arg3]%の触腕ダメージを与える。"
  },
  Skill_4617_EffectNameList = {
    Text = "回復,一時的な触腕ダメージ"
  },
  Skill_4617_Name = {
    Text = "永遠の幻影"
  },
  Skill_4617_PropertyNameList = {
    Text = "体力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4618_AwakerSkillBackgroundStory = {
    Text = "あなたはこれまで、自分がスポットライトの中心、宇宙の中心、神に愛された存在だと感じたことがあるだろうか？\n\nライカーにとってそれは、ふと手札を一瞥し、何の迷いもなくそれを開いたあの瞬間だった。"
  },
  Skill_4618_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを1～[Arg4]回与え、<Energy:[Energy:Arg2]>狂気を獲得する。もし6回以上ダメージを与えた場合、行動力消費0で「除外」が付与された「意外な収穫」を1枚獲得する。"
  },
  Skill_4618_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを1～[Arg4]回与え、<Energy:[Energy:Arg2]>狂気を獲得し、クリティカル発生ごとに、追加で<Energy:[Arg3]>狂気を獲得する。もし6回以上ダメージを与えた場合、行動力消費0で<DepleteIconKeywords:除外>が付与された「意外な収穫」を1枚獲得する。"
  },
  Skill_4618_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4618_Name = {
    Text = "決戦の瞬間"
  },
  Skill_4618_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4620_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4621_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与し、山札と捨て札の中からランダムに[Arg2]枚のカードに「<SlowIconKeywords:鈍化>」を付与する。"
  },
  Skill_4621_Name = {
    Text = "骨に染みる遅滞"
  },
  Skill_4622_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ブロックされなかったダメージを与えるたび、1層の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4622_Name = {
    Text = "永遠なる狂気の狩猟"
  },
  Skill_4624_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4625_Desc = {
    Text = "1点の行動力を獲得し、「症状：ヒステリー」を1枚捨て札に追加。売却不可。"
  },
  Skill_4625_Name = {
    Text = "症状：ヒステリー"
  },
  Skill_4626_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>を付与し、山札と捨て札のすべてのカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_4626_Name = {
    Text = "永遠の瞳"
  },
  Skill_4627_AwakerSkillBackgroundStory = {
    Text = "媚びる者が哀願するとき、誇るなかれ。\n媚びる者が見つめるとき、恥じるなかれ。\n媚びる者が抱くとき、逃れるなかれ。\n媚びる者の思考と行動は、ただ一つの終焉へと向かう。\nそこに君の居場所はない——ただ、波のように押し寄せる悲嘆と堕落があるのみ。"
  },
  Skill_4627_BattleDesc_0 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]% 失われたライフ(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの[Arg4]%(<Heal:[Arg3]>)を回復し、自身の<VulnerabilityIconKeywords:軟化>状態を解除。この「林檎磨きの抱擁」で獲得する力が2倍になる。】ライフを<Heal:[Heal:Arg1]>回復し、[Power:Arg2] 点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_Desc_0 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]％ 失われたライフ。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg2] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4627_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの[Arg4]%を回復し、自身の<VulnerabilityIconKeywords:易傷>を解除。この「林檎磨きの抱擁」で獲得する力が2倍になる。】ライフを<Heal:[Heal:Arg1]>回復し、[Power:Arg2] 点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_EffectNameList = {Text = "回復,力"},
  Skill_4627_Name = {
    Text = "林檎磨きの抱擁"
  },
  Skill_4627_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの [Arg4]% を回復する(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>状態を駆散する。】<Heal:[Heal:Arg1]> 点のライフを回復する。[Power:Arg5] 点の<PowerIconKeywords:力>を得る。全ての覚醒体のクリティカル率とクリティカルダメージ +[Arg6]%。"
  },
  Skill_4627_OverLimitUtlSkillDesc_3 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]% 失われたライフ(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。本次【林檎磨きの抱擁】による力が倍増する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg5]点の<PowerIconKeywords:力>を獲得。すべての覚醒体のクリティカル率とクリティカルダメージ +[Arg6]%。"
  },
  Skill_4627_PropertyNameList = {
    Text = "体力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4627_tempBattleDesc_1 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]% 失われたライフ(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_tempBattleDesc_2 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]％ 失われたライフ(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。今回の【林檎磨きの抱擁】で得られる力が倍増する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの[Arg4]%(<Heal:[Arg3]>)し、自身の<VulnerabilityIconKeywords:易傷>を解除。この「林檎磨きの抱擁」で獲得する力が2倍になる。】ライフを<Heal:[Heal:Arg1]>回復。[Power:Arg2]点の<PowerIconKeywords:力>と[Power:Arg7]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの [Arg4]% を回復する(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>状態を駆散する。】<Heal:[Heal:Arg1]> 点のライフを回復する。[Power:Arg5] 点の<PowerIconKeywords:力>を得る。全ての覚醒体のクリティカル率とクリティカルダメージ +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_2 = {
    Text = "[<DevouredIconKeywords:捕食>：回復 [Arg4]% 失われたライフ(<Heal:[Arg3]>)。自身の<VulnerabilityIconKeywords:易傷>ステータスを解除する。本次【林檎磨きの抱擁】による力が倍増する。]回復 <Heal:[Heal:Arg1]> 点ライフ。[Power:Arg5]点の<PowerIconKeywords:力>を獲得。すべての覚醒体のクリティカル率とクリティカルダメージ +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食>：失ったライフの[Arg4]%(<Heal:[Arg3]>)を回復し、自身の<VulnerabilityIconKeywords:易傷>を解除。この「林檎磨きの抱擁」で獲得する力が2倍になる。】ライフを<Heal:[Heal:Arg1]>回復。[Power:Arg5]点の<PowerIconKeywords:力>と[Power:Arg7]点の一時的な<PowerIconKeywords:力>を獲得。すべての覚醒体のクリティカル率とクリティカルダメージ+[Arg6]%。"
  },
  Skill_4628_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg3]回与え、1点の発狂を獲得する。"
  },
  Skill_4629_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ブロックされなかったダメージを与えるたび、1層の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4629_Name = {Text = "狩り"},
  Skill_4630_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4631_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4632_Desc = {
    Text = "[Arg1]点のシールドを獲得し、ガードされなかったダメージを与えた時にそのダメージの3倍のライフを回復し、この効果は[Arg2]ターン持続する。"
  },
  Skill_4632_Name = {
    Text = "手術準備"
  },
  Skill_4633_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_4633_Name = {
    Text = "手術準備"
  },
  Skill_4634_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4635_AwakerSkillBackgroundStory = {
    Text = "ある太古の力がマーフィーの体内で目覚めつつあった。\n植えられた種子は日々を重ねて虚ろな蕾へと育っていく。\n「こんな力を授けられたからには、見せてあげるわ——私の本気を！」"
  },
  Skill_4635_Desc = {
    Text = "すべての敵のダメージを[Arg1]%減少させるが、自身が攻撃を受けた時、ダメージの半分の<SacrificeKeyWord:献上>を受ける。1ターン持続。<Block:[Block:Arg2]>点のシールドを獲得し、すべての触腕に1回攻撃させる。"
  },
  Skill_4635_EffectNameList = {
    Text = "シールド"
  },
  Skill_4635_Name = {
    Text = "虚偽の継承者"
  },
  Skill_4635_OverLimitUtlSkillDesc = {
    Text = "すべての敵のダメージを[Arg1]%減少させるが、自身が攻撃を受けた時、ダメージの半分の<SacrificeKeyWord:献上>を受ける。1ターン持続。<Block:[Block:Arg2]>点のシールドを獲得し、すべての触腕に1回攻撃させる。ターン開始時、<Block:[Block:Arg3]>点のシールドと[Arg4]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、一時的な触腕を2本生成する。3ターン持続。"
  },
  Skill_4635_PropertyNameList = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4636_Desc = {
    Text = "引いた時、行動力を1点失い、カードを1枚引く。"
  },
  Skill_4636_Name = {Text = "惑わし"},
  Skill_4637_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4638_AwakerSkillBackgroundStory = {
    Text = "鋼鉄の塊から鍛え上げたその大剣は、大気を裂きその風圧すら岩を砕く。\n\n忠実なる相棒よ、頼れる巨刃よ――\n我らは闇の中で再誕し、無限の力を得た。\n\n今宵、我らは仇敵の血を飲み干す。\n今宵、我らは殺戮に酔いしれる。"
  },
  Skill_4638_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得する。このカードは「攻撃」として扱う。"
  },
  Skill_4638_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4638_Name = {
    Text = "巨刃の威"
  },
  Skill_4638_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4639_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4641_Desc_0 = {
    Text = "ランダムな敵に<Damage:[Damage:Arg2]>ダメージを[Arg1]回与える。"
  },
  Skill_4641_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4641_Name = {
    Text = "鼠たちの突撃"
  },
  Skill_4641_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_46420_Desc_1 = {
    Text = "対象1体に[Arg1]点の<PVPEntanglementKeywords:纏着>を付与する。"
  },
  Skill_46420_Name_1 = {Text = "纏着"},
  Skill_4642_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手の手札をすべて捨てさせる。"
  },
  Skill_4642_Name = {Text = "離散"},
  Skill_46431_Desc_1 = {
    Text = "対象1体に<Damage:[Damage:Arg1]>の<PVPBleedingKeywords:出血>ダメージを与える。"
  },
  Skill_46431_Name_1 = {
    Text = "遅延攻撃"
  },
  Skill_46432_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：<Block:[Block:Arg1]>点のシールドを獲得、を付与する。"
  },
  Skill_46432_Name_1 = {
    Text = "遅延シールド"
  },
  Skill_46433_Desc_1 = {
    Text = "対象に1点の<PVPEmptinessKeywords:虚無>を付与する。"
  },
  Skill_46433_Name_1 = {Text = "虚無"},
  Skill_4643_AwakerSkillBackgroundStory = {
    Text = "「違う、違う。これは創作の論理じゃない」\n彫刻家は低くそう呟いたが、若い弟子の目を直視できなかった。\n\nあの眼差しをなんと表せばいいのだろう——世界の果ての海のように静かで、そこに映るのは、命尽きようとする渡り鳥の最後のもがき。\n\n彼女はすべてを知っている。だが、言葉はひとつも発さなかった。"
  },
  Skill_4643_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。触腕を[Arg2]本獲得。<RippleKeywords:余波>：<Energy:[Energy:Arg4]>狂気を獲得。"
  },
  Skill_4643_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、触腕1本につき追加で[Arg3]点のシールドを獲得。触腕を[Arg2]本獲得。<RippleKeywords:余波>：<Energy:[Energy:Arg4]>狂気を獲得。"
  },
  Skill_4643_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。触腕を[Arg2]本獲得。<RippleKeywords:余波>：現在の触腕数と同量の狂気を獲得。"
  },
  Skill_4643_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得、触腕1本につき追加で[Arg3]点のシールドを獲得。触腕を[Arg2]本獲得。<RippleKeywords:余波>：現在の触腕数と同量の狂気を獲得。"
  },
  Skill_4643_EffectNameList_0 = {
    Text = "シールド"
  },
  Skill_4643_EffectNameList_2 = {
    Text = "シールド,触腕ごとのシールド"
  },
  Skill_4643_Name = {
    Text = "美の憐れみ"
  },
  Skill_4643_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,"
  },
  Skill_4643_PropertyNameList_2 = {
    Text = "防御力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4644_AwakerSkillBackgroundStory = {
    Text = "港を離れた船は風に迷い、群れを離れた獣は大波を起こす。\n彼女の狂熱は何度も人類文明の存続に影響を与えたが、彼女は気にしない。\n獣にとって、住処を取り戻すこと以上に重要なことはない。"
  },
  Skill_4644_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、同量の<IntoxicationIconKeywords:毒>を付与する。[Arg4]％の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。一時的な触腕を[Arg2]本生成。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]。"
  },
  Skill_4644_EffectNameList = {
    Text = "ダメージ,触腕ダメージ"
  },
  Skill_4644_Name = {
    Text = "狂熱の海"
  },
  Skill_4644_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4645_BattleDesc = {
    Text = "ライフを[Arg1]失い、すべての覚醒体が10狂気を獲得する。売却不可。"
  },
  Skill_4645_Desc = {
    Text = "最大ライフの10%を失い、すべての覚醒体が10狂気を獲得する。売却不可。"
  },
  Skill_4645_Name = {
    Text = "症状：発狂"
  },
  Skill_4646_AwakerSkillBackgroundStory = {
    Text = "決闘では防御は不要。攻撃こそが最良の防御だ。"
  },
  Skill_4646_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4646_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ロータンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4646_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4646_Name = {Text = "攻撃"},
  Skill_4646_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4647_Desc = {
    Text = "それはもう何の役にも立たない。捨てた時または使用した時にこれを<DepleteIconKeywords:除外>する。"
  },
  Skill_4647_Name = {Text = "石ころ"},
  Skill_4648_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4649_Desc = {
    Text = "自身が死亡し、ライフが自身の現在値と同等の「融蝕三角構造体蝋人形」2体に分裂する。"
  },
  Skill_4650_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4650_Name = {
    Text = "窒息の苦しみ"
  },
  Skill_4651_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の寄生を付与する。"
  },
  Skill_4651_Name = {Text = "骨侵食"},
  Skill_4652_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札の上の[Arg3]枚のカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_4652_Name = {
    Text = "停滞の呪い"
  },
  Skill_4653_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4653_Name = {
    Text = "切開手術"
  },
  Skill_4654_Desc = {
    Text = "[Arg1]点のシールドを獲得する。リリーが召喚した粘液のシールド、ケルベロスの引き裂きを一度だけ防げる。本当に……痛くないの？"
  },
  Skill_4654_Name = {
    Text = "泥に咲く不滅の花"
  },
  Skill_4655_AwakerSkillBackgroundStory = {
    Text = "海は深く静かで、生への渇望と死への恐怖を抱えている。\nしかし、誰かが笑いと遊びで海を満たそうとする——オレッタがそんな招待をすると、「一緒に騒いでもいいじゃないか」という気持ちが湧き上がり、シンプルな喜びが胸を満たす。"
  },
  Skill_4655_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。"
  },
  Skill_4655_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。山札と捨て札の中から最大10枚の「腺体分裂」を消費し、1枚につき追加でダメージを1回与える。「腺体分裂」を2枚手札に追加する。この戦闘中、「オレッタ」の与えるダメージが[Arg2]増加する。"
  },
  Skill_4655_EffectNameList = {
    Text = "ダメージ,以降ダメージ上昇"
  },
  Skill_4655_Name = {
    Text = "賑やかな海"
  },
  Skill_4655_OverLimitUtlSkillDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージを与える。ドロー山と捨て札の中から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「オレッタ」が本戦闘以降に与えるダメージを [Arg2] 点上昇させる。[Power:Arg2] 点の<PowerIconKeywords:力>と [TentaclePower:Arg2] 点の<TentacleInjurieIconKeywords:触腕ダメージ>を得て、その後5回「腺体分裂」を打ち出すたびに1枚ドローする。"
  },
  Skill_4655_OverLimitUtlSkillDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。山札と捨て札から最大10枚の「腺体分裂」を消費し、1枚につき追加で1回ダメージを与える。「腺体分裂」を2枚手札に加える。「奥瑞塔」の本戦闘における以降のダメージを[Arg2]点上昇させる。[Power:Arg2]点の<PowerIconKeywords:力量>と[TentaclePower:Arg2]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得し、以降5回「腺体分裂」を発動する際、1枚カードを引く。"
  },
  Skill_4655_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4656_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4657_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>と<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4657_Name = {
    Text = "全体強化"
  },
  Skill_4658_AwakerSkillBackgroundStory = {
    Text = "カーシアの手の中は空っぽ。\nカーシアの帽子の中は空っぽ。\nカーシアの胸の中も空っぽ。\n\n空っぽのカーシアは、空っぽの喜びを抱え、空っぽの狂騒の中で、空っぽのステージをする。"
  },
  Skill_4658_Desc_0 = {
    Text = "カーシアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：カーシアのカードを1枚使用するたび、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。"
  },
  Skill_4658_Desc_15 = {
    Text = "カーシアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：カーシアのカードを1枚使用するたび、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。すべての覚醒体の「攻撃」を使用した場合もこの効果が発動し、一時的な力を獲得する。"
  },
  Skill_4658_EffectNameList = {Text = "狂気,力"},
  Skill_4658_Name = {
    Text = "公演の序幕"
  },
  Skill_4658_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4659_AwakerSkillBackgroundStory = {
    Text = "——でもおまえはまだ弱いから、ちゃんと守らないとダメだ。"
  },
  Skill_4659_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4659_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ロータンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4659_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4659_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4659_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]> シールドを獲得。<Energy:[Energy:Arg2]> 狂気を獲得"
  },
  Skill_4659_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]> ポイントのシールドを獲得する。<Energy:[Energy:Arg2]> ポイントの狂気を獲得する。このターン、次の1枚の「傲慢なる刃」が2回発動する。"
  },
  Skill_4660_AwakerSkillBackgroundStory = {
    Text = "一、二、一、二……\n彼女はトレーを持ち、軽やかなリズムで人混みをすり抜ける。\n\n客たちは飲んで歌い続け、彼女は料理を運び、笑みを絶やさない。\n\nここはすべてが金色に輝いている。\n金色のホール、金色の葡萄酒、金色のドレスの裾。\n\nカレンは金色が好き。\n彼女は何度も練習した看板スマイルを浮かべる。\n\n「お客様、ごゆっくりどうぞ——！！」"
  },
  Skill_4660_Desc_0 = {
    Text = "すべての手札の<SlowIconKeywords:遅延>状態を解除。<Heal:[Heal:Arg1]>ライフを回復。<DerivativeCardKeywords_42:「不思議な料理」>を1枚手札に追加。すべての敵に[Poison:Arg2]層の<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4660_Desc_3 = {
    Text = "すべての手札の<SlowIconKeywords:遅延>を解除。ライフを<Heal:[Heal:Arg1]>回復。<DerivativeCardKeywords_43:「不思議な料理」>を1枚手札に追加。すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_4660_EffectNameList = {Text = "回復,毒"},
  Skill_4660_Name = {
    Text = "ごゆっくり！"
  },
  Skill_4660_OverLimitUtlSkillDesc_0 = {
    Text = "すべての手札の<SlowIconKeywords:遅延>ステータスを除去する。<Heal:[Heal:Arg1]>ポイントのライフを回復する。<DerivativeCardKeywords_43:「不思議な料理」>を1枚手札に加える。すべての敵に[Poison:Arg2]層の<IntoxicationIconKeywords:毒>を付与する。<DerivativeCardKeywords_42:「不思議な料理」>をドロー山と捨て札にそれぞれ1枚シャッフルする。"
  },
  Skill_4660_OverLimitUtlSkillDesc_3 = {
    Text = "すべての手札の<SlowIconKeywords:遅延>状態を解除。<Heal:[Heal:Arg1]>ライフを回復。<DerivativeCardKeywords_43:「不思議な料理」>を1枚手札に追加。すべての敵に[Poison:Arg2]層の<IntoxicationIconKeywords:毒>を付与。<DerivativeCardKeywords_43:「不思議な料理」>をドローパイルと捨て札にそれぞれ1枚ずつ混入する。"
  },
  Skill_4660_PropertyNameList = {
    Text = "体力×GrowValue1,攻撃×GrowValue2"
  },
  Skill_4661_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4661_Name = {
    Text = "蜂蜜色の幻想惨劇"
  },
  Skill_4662_AwakerSkillBackgroundStory = {
    Text = "人々は彼女の美しさを称賛し、その艶やかな風情を羨んだが、誰もその一輪の蕾など気にも留めなかった。\n\n田舎で揺れ動く蕾は、未来を左右され、その花を育てた者の昇進の駒とされた。\n\nそして彼女が冠の前で咲き誇ったその瞬間、人々は自らが棘に裂かれ、血まみれになっていたことにようやく気づいた。"
  },
  Skill_4662_BattleDesc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。ターン終了時に<Heal:[Heal:Arg2]>点のライフを回復。"
  },
  Skill_4662_BattleDesc_2 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg3]回を与える。ダメージを与えるたび、一時的なクリティカル率+5%。ターン終了時、ライフを<Heal:[Heal:Arg2]>回復。"
  },
  Skill_4662_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg3]回与える。ターン終了時に<Heal:[Heal:Arg2]>点のライフを回復。"
  },
  Skill_4662_Desc_2 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg3]回を与える。ダメージを与えるたび、一時的なクリティカル率+5%。ターン終了時、ライフを<Heal:[Heal:Arg2]>回復。"
  },
  Skill_4662_EffectNameList_0 = {
    Text = "ダメージ,回復"
  },
  Skill_4662_Name = {
    Text = "薔薇の美"
  },
  Skill_4662_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,体力×GrowValue2"
  },
  Skill_4663_AwakerSkillBackgroundStory = {
    Text = "冷たい機構が心臓の代わりとなり、油圧管の油が血液の役割を果たす。\n彼女は冷静に、論理的に、命令に従って動くはずだった。\n\nしかし、外から来た意志が彼女の体内で静かに動いていた。\nそれは血も温度も必要とせず、自ら非人間的な悪意を燃やす存在。\n\n「ひれ伏せ、哀れで弱き存在よ。そしてこの熱き雷球の中で滅びよ」\nと、その存在は囁いた。"
  },
  Skill_4663_BattleDesc_0 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。<Posse:[Arg2]>点の銀鍵エネルギーを獲得。自身の<WeaknessIconKeywords:虚弱>状態を解除。1枚のカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_14:「機械武装–斂」>に変形する。"
  },
  Skill_4663_BattleDesc_1 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。<Posse:[Arg2]>キーエネルギーを獲得。自身の<WeaknessIconKeywords:虚弱>を解除。<DepleteIconKeywords:除外>が付与されたエリカの「攻撃」を1枚手札に追加する。<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚置かれるたび、<DerivativeCardKeywords_14:「機械武装・収」>に切り替わる。"
  },
  Skill_4663_Desc_0 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。エリカの銀鍵チャージと同等の銀鍵エネルギーを獲得。自身の<WeaknessIconKeywords:虚弱>状態を解除。1枚のカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_14:「機械武装–斂」>に変形する。"
  },
  Skill_4663_Desc_1 = {
    Text = "[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。エリカのキーチャージに等しいキーエネルギーを獲得。自身の<WeaknessIconKeywords:虚弱>を解除。「<DepleteIconKeywords:除外>」が付与されたエリカの「攻撃」を1枚手札に追加する。<DimensionalSpaceIconKeywords:超次元空間>にカードが1枚置かれるたび、<DerivativeCardKeywords_14:「機械武装・収」>に切り替わる。"
  },
  Skill_4663_EffectNameList_0 = {
    Text = "パワー,警戒"
  },
  Skill_4663_EffectNameList_1 = {
    Text = "力,警戒,「攻撃」レベル"
  },
  Skill_4663_Name = {
    Text = "機械武装-放"
  },
  Skill_4663_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4663_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2,$GrowValue3"
  },
  Skill_4664_AwakerSkillBackgroundStory = {
    Text = "無形の疫病が静かに忍び寄り、無限の苦痛と狂気をもたらす。\n\n司教は夜も眠れず、人々の苦難を取り除けない自分に心を痛める。\n\n「慈悲深い創造主よ、彼らをお救いください。私が彼らのすべての苦痛と悲しみを引き受けます」\n\nそして父なる神は彼に「祝福」を授け、神言を刻んだ石板を持たせ、苦難を消し離れる使命を与えた。"
  },
  Skill_4664_Desc_0 = {
    Text = "サルバドルは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：<B02AFKeyWord:仁愛の守護>を1枚手札に追加する。ターン終了後、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4664_Desc_15 = {
    Text = "サルバドルは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：<B02AFKeyWord:仁愛の守護>を1枚手札に追加する。ターン終了後、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。「創造主の庇護」と「祝福の骨血」で蓄積する猩紅炉が25%増加し、「苦痛の解消」で「浄化」を選択した場合、最大ライフの1%の猩紅炉を消費するごとに最終ダメージが上昇する効果が2%から5%に増加する。"
  },
  Skill_4664_EffectNameList = {Text = "狂気,力"},
  Skill_4664_Name = {
    Text = "「祝福」"
  },
  Skill_4664_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4665_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4665_Name = {
    Text = "縫合品の狂気"
  },
  Skill_4666_AwakerSkillBackgroundStory = {
    Text = "「ふん、このお嬢様がしっかり教えてあげるわ」"
  },
  Skill_4666_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4666_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]。"
  },
  Skill_4666_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。マーフィーは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4666_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。マーフィーは <Energy:[Energy:Arg2]>狂気を獲得。<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg3]。"
  },
  Skill_4666_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4666_EffectNameList_2 = {
    Text = "ダメージ,狂気,触腕ダメージ"
  },
  Skill_4666_Name = {Text = "攻撃"},
  Skill_4666_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_4666_PropertyNameList_2 = {
    Text = "攻撃力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4667_AwakerSkillBackgroundStory = {
    Text = "それはすべての次元を超えた巨大迷宮。\n迷宮に迷い込んだ旅人は無礼な取引に直面せざるを得ない。\n「いいえ」と答えれば、旅人は永遠に迷宮に囚われる。\n「はい」と答えれば、旅人は冒涜の子を移植され、すべての記憶を消される。\n何だって？取引の具体的な内容は何かって？\n誰も取引の具体的な内容を知らない、蒼白の迷宮の主を含めて。\n取引、それはただの取引に過ぎない。"
  },
  Skill_4667_Desc_0 = {
    Text = "[<DevouredIconKeywords:捕食>：獲得 [Power:Arg1] 点<PowerIconKeywords:力> と [Arg4] 点<AlertIconKeywords:警戒>。]獲得 <Block:[Block:Arg2]> 点シールド。すべての敵に [Poison:Arg3] 層の<IntoxicationIconKeywords:ポイズン> を付与。"
  },
  Skill_4667_EffectNameList = {
    Text = "パワー,警戒,シールド,毒"
  },
  Skill_4667_Name = {
    Text = "蒼白の庇護"
  },
  Skill_4667_OverLimitUtlSkillDesc_0 = {
    Text = "[<DevouredIconKeywords:捕食>：[Power:Arg1]点の<PowerIconKeywords:力>と[Arg4]点の<AlertIconKeywords:警戒>を獲得する。]<Block:[Block:Arg2]>点のシールドを獲得する。すべての敵に[Poison:Arg3]点の<IntoxicationIconKeywords:毒>を付与する。アグリッパの非打撃防御指令カードを2枚引き、手札のアグリッパの非打撃防御指令カード2枚のこのターンの行動力消費を-1にする。"
  },
  Skill_4667_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue4,防御力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4668_AwakerSkillBackgroundStory = {
    Text = "彼は自分が死にかけたという事実を受け入れられない。\n彼は無敵であるべきで、金剛不壊であるべきだ。\n\nもし人間の身体が力の頂へ至る妨げとなるのなら——肉体など捨て去ろう。\nもし一族を棄てて強さが得られるのなら——過去など地中に葬り去ろう。\n\n彼は巨刃を深海に投げ入れ、人ならざる力を引き換えに手にし、すべての支配者になることを誓う。\nその力を与えた存在さえ——いずれは、彼の足元に跪くのだ。"
  },
  Skill_4668_Desc = {
    Text = "選択：<O06_AFKeyWord1:簒奪>または<O06_AFKeyWord2:潜伏>。<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。"
  },
  Skill_4668_EffectNameList = {
    Text = "一時的な力"
  },
  Skill_4668_Name = {
    Text = "深海の力"
  },
  Skill_4668_OverLimitUtlSkillDesc = {
    Text = "選択：<O06_AFKeyWord1:篡奪>または<O06_AFKeyWord2:蟄伏>。<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。「篡奪」を選択した場合、手札に追加される「巨刃の威」の基礎ダメージが400%増加し、行動力消費が0になる。「蟄伏」を選択した場合、「巨刃の威」は追加されず、代わりに「斬首重創」を2枚手札に追加し、「消耗」、「予備1」と「保留」を付与する。"
  },
  Skill_4669_AwakerSkillBackgroundStory = {
    Text = "彼女は感情の運び手であり、情念の延長線だった。\n\nこの濃墨を溢れさせるように、この詩才を惜しみなく注ごう。\n\nこの世で口にされなかった言葉は、彼女の詩集から始まる。"
  },
  Skill_4669_Desc_0 = {
    Text = "オルラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：即座に現在の情緒以外の情緒の<D06CardKeyWord1:隠喩>を1点獲得し、毎ターン開始時にも1点獲得する。それぞれ最大3点まで。<D06CardKeyWord1:隠喩>は詩篇カードの<TransitionIconKeywords:跳躍>が発動する時に消費し、追加のボーナスを獲得する。"
  },
  Skill_4669_Desc_15 = {
    Text = "オルラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：即座に現在の情緒以外の情緒の<D06CardKeyWord1:隠喩>を1点獲得し、毎ターン開始時にも1点獲得する。それぞれ最大3点まで。<D06CardKeyWord1:隠喩>は詩篇カードの<TransitionIconKeywords:跳躍>が発動する際に消費し、追加のボーナスを獲得する。「湮滅」を発動後、オルラがこのターン次に使用する指令カードは跳躍効果を発動する。オルラが隠喩を3点以上消費するたび、現在の情緒効果が一時的に[Arg2]%増加する。この効果は重複しない。"
  },
  Skill_4669_EffectNameList = {Text = "狂気"},
  Skill_4669_Name = {
    Text = "詩集序文"
  },
  Skill_4670_Desc = {
    Text = "自身が死亡し、ライフが自身と同等の「Ⅱ型融蝕生物」3体に分裂する。"
  },
  Skill_4672_Desc = {
    Text = "現在のライフとシールドが、前のターン終了時の状態に戻る。"
  },
  Skill_4672_Name = {
    Text = "過去の響き"
  },
  Skill_4673_Desc = {
    Text = "相手に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4674_Desc = {
    Text = "すべての症状カードを<DerivativeCardKeywords_37:「窒息」>に変化させる。<DerivativeCardKeywords_37:「窒息」>：行動力1。ターン終了時にまだ手札にある場合、自身に[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4674_Name = {
    Text = "苦海に沈む"
  },
  Skill_4675_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_24:「裂傷」>を2枚手札に追加する。"
  },
  Skill_4675_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_4676_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与えます。<WeaknessIconKeywords:弱り> を [Arg3] ターン付与します。"
  },
  Skill_4677_Desc = {
    Text = "1点の行動力を獲得し、カードを1枚引く。"
  },
  Skill_4677_Name = {Text = "啓示"},
  Skill_4678_AwakerSkillBackgroundStory = {
    Text = "彼は敵を粉砕する機会を逃さない。"
  },
  Skill_4678_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4678_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ユウハシュは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4678_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4678_Name = {Text = "攻撃"},
  Skill_4678_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4680_AwakerSkillBackgroundStory = {
    Text = "山の風が迷宮の骸骨の中でざわめき、嘆きの声を奏でる。\n彼女は遠くで迷える旅人の叫びを聞きながら、八千一回目のあくびをした。\n彼女は苦しみをすすり飲み、それらをひとつひとつ分類し、陳列していく。\nただ一つの問題は——彼女の傑作を知る者が誰もいないということ。\n彼女はこの場所の唯一の観客だった。\nはあ——\n迷宮の最奥で、彼女は再び、ひとつあくびをした。"
  },
  Skill_4680_Desc_0 = {
    Text = "アグリッパは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：アグリッパが付与する<IntoxicationIconKeywords:毒>が50%増加し、ターン終了後に<Block:[Block:Arg2]>点のシールドを獲得。"
  },
  Skill_4680_Desc_15 = {
    Text = "アグリッパは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：アグリッパが付与する<IntoxicationIconKeywords:毒>が100%増加する。ターン終了後、<Block:[Block:Arg2]>点のシールドを獲得し、ターン中、アグリッパが毒を1回付与する、または発動するたび、そのシールドが50％増加する。最大5回まで。"
  },
  Skill_4680_EffectNameList = {
    Text = "狂気,シールド"
  },
  Skill_4680_Name = {
    Text = "迷途の旅"
  },
  Skill_4680_PropertyNameList = {
    Text = "$GrowValue1,防御力×GrowValue2"
  },
  Skill_4681_Desc = {
    Text = "あなたの長期戦は既に密境の注目を引いた…症状カードを1枚あなたの山札に永久に加える。"
  },
  Skill_4681_Name = {Text = "凝視"},
  Skill_4682_Desc = {
    Text = "4体の覚醒体の狂気解放を1ターン封印する。"
  },
  Skill_4683_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4683_Name = {Text = "明滅"},
  Skill_4685_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後退する。"
  },
  Skill_4686_AwakerSkillBackgroundStory = {
    Text = "「悲しみと苦しみ以外、この残酷な暴虐は何の助けにもならない。いつか終わりを迎えるだろう」"
  },
  Skill_4686_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4686_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える、この戦闘で猩紅炉回復量を2点積み上げるごとに、ダメージが[Float:Arg3]増加する。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4686_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。サルバドルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4686_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える、この戦闘で猩紅炉回復量を2点積み上げるごとに、ダメージが[Float:Arg3]増加する。サルバドルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4686_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4686_Name = {Text = "攻撃"},
  Skill_4686_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4687_Desc = {
    Text = "ターン終了時に手札にある場合、まだ手札にあるカードを<DerivativeCardKeywords_25:「石ころ」>に変化させる。捨てる時にこれを<DepleteIconKeywords:除外>する。"
  },
  Skill_4687_Name = {
    Text = "石ころ変化"
  },
  Skill_4688_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_4688_Name = {Text = "発狂"},
  Skill_4689_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_4689_Name = {Text = "発狂"},
  Skill_4690_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4691_Desc = {
    Text = "カードを4枚引く。"
  },
  Skill_4691_Name = {
    Text = "不平等な交換"
  },
  Skill_4692_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4693_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4693_Name = {
    Text = "傲慢の刃"
  },
  Skill_4694_AwakerSkillBackgroundStory = {
    Text = "薄暗いニューゲート監獄では、ロンディニウムでよく見られる蝋でさえも貴重なもの。\n\n貴重であるからこそ、重要な場面で使われるべき。\n例えば、罰の時に、言うことを聞かない子供の肌に使う。\n\n特製の蝋涙ではないので、滴る時には悲惨な叫び声が伴うが、少女の耳には優雅な詩のように聞こえる。"
  },
  Skill_4694_BattleDesc_0 = {
    Text = "[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。すべての敵から[Exhaustion:Arg1]点の<ExhaustionIconKeywords:力>を一時的に減少させる。敵1体につき[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。すべての敵の<RetaliateIconKeywords:反撃>を除去する。"
  },
  Skill_4694_BattleDesc_2 = {
    Text = "[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。すべての敵から[Exhaustion:Arg1]点の一時的な<ExhaustionIconKeywords:力>を減少させる。敵1体につき[Power:Arg1]点の<PowerIconKeywords:一時的な力>を獲得する。すべての敵の<RetaliateIconKeywords:反撃>を除去する。<Energy:[Energy:Arg3]>狂気を獲得。"
  },
  Skill_4694_Desc_0 = {
    Text = "[Counterattack:Arg2]層の<RetaliateIconKeywords:反撃>を獲得。すべての敵から[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:奪い>、その<RetaliateIconKeywords:反撃>状態を解除する。"
  },
  Skill_4694_Desc_2 = {
    Text = "[Counterattack:Arg2]層の<RetaliateIconKeywords:反撃>を獲得。すべての敵から[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:奪い>、その<RetaliateIconKeywords:反撃>状態を解除する。<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_4694_EffectNameList = {
    Text = "力の吸収,反撃"
  },
  Skill_4694_Name = {
    Text = "灼蝋の欲望"
  },
  Skill_4694_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4695_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_33:「助けて」>を1枚手札に追加する。"
  },
  Skill_4695_Name = {Text = "助けて"},
  Skill_4697_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_4697_Name = {
    Text = "戦欲抑え難し"
  },
  Skill_4698_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得する。「祈り」：スキル強化に使用可能。ダメージを受けると1点失い、ターン終了時にすべて失う。"
  },
  Skill_4698_Name = {Text = "祈り"},
  Skill_4701_AwakerSkillBackgroundStory = {
    Text = "それは歪んだ胚胎であり、罪の種であった。\n鼓動する心臓、高鳴る脈動、骨と血が憎しみ合い、運命がもつれ絡む。\n造られしものには選択の自由はなく、彼女は倒錯したその成長に身を任せるしかなかった。"
  },
  Skill_4701_Desc_0 = {
    Text = "マーフィーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。マーフィーの指令カードを使用した後、触腕の上限を無視する一時的な触腕を1本獲得し、消費した行動力と同量のキーチャージを獲得する。毎ターン最大3回まで発動可能。"
  },
  Skill_4701_Desc_15 = {
    Text = "マーフィーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。マーフィーの指令カードを使用した後、触腕の上限を無視する一時的な触腕を1本獲得し、消費した行動力消費と同量のキーチャージを獲得する。毎ターン最大3回まで発動可能。マーフィーが毎ターン初めて使用する「ルルイエの逆流」のダメージ回数と「聖女創造」で獲得する行動力が2倍になる。"
  },
  Skill_4701_EffectNameList = {Text = "狂気"},
  Skill_4701_Name = {
    Text = "造られしもの"
  },
  Skill_4702_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4702_Name = {
    Text = "石の分解"
  },
  Skill_4703_AwakerSkillBackgroundStory = {
    Text = "主人を守る。\n主人を守る。\n主人を守る。\n\n傷だらけでも命令を遂行する。\n\n敵が強いのなら、より大きな禁域を展開すればいい。\n体が激しく痛んでも、命令の実行には何の支障もない。"
  },
  Skill_4703_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。次のターン開始まで、攻撃を1回受けるたび、[Arg3]点の<PainWord:忍耐>を獲得する。"
  },
  Skill_4703_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。次のターン開始まで、攻撃を1回受けるたび、[Arg3]点の<PainWord:忍耐>を獲得する。ライフが50%未満([Arg4])の場合、追加でシールドを1回獲得し、付与する毒が2倍になる。"
  },
  Skill_4703_Desc_0 = {
    Text = "<Block:[Block:Arg1]>のシールドを獲得し、すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。リリーの死亡抵抗率1%につき基礎シールドが0.25%増加する。次のターン開始まで、攻撃を1回受けるたび、[Arg3]点の<PainWord:忍耐>を獲得する。"
  },
  Skill_4703_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与する。リリーの死亡抵抗率1%につき基礎シールドが0.25%増加する。次のターン開始まで、攻撃を1回受けるたび、[Arg3]点の<PainWord:忍耐>を獲得する。ライフが50%未満の場合、追加でシールドを1回獲得し、付与する毒が2倍になる。"
  },
  Skill_4703_EffectNameList = {
    Text = "シールド,毒,忍耐"
  },
  Skill_4703_Name = {
    Text = "黒沼禁域"
  },
  Skill_4703_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,防御力×GrowValue3"
  },
  Skill_4704_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4705_Desc = {
    Text = "「降神の儀式」状態を獲得し、毎ターン力を増加させる。[Arg1]点の<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>、<VulnerabilityIconKeywords:軟化>状態を付与し、「執念」を3枚山札のランダムな位置に追加する。"
  },
  Skill_4705_Name = {
    Text = "降神の儀式・呼びかけ"
  },
  Skill_4706_Desc = {
    Text = "[Arg2]点のシールドと「悪意の放血」状態を獲得する。「悪意の放血」：ガードされなかったダメージを1回与えるたび、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4706_Name = {
    Text = "海の料理"
  },
  Skill_4707_Desc = {
    Text = "リリーはプレイヤーが毎ターン最初に使用する覚醒体カードを模倣する。"
  },
  Skill_4707_Name = {Text = "覚醒"},
  Skill_47090_Desc_1 = {
    Text = "このカードの表面には特別な効果がある！"
  },
  Skill_47090_Name_1 = {Text = "効果3"},
  Skill_47091_Desc_1 = {
    Text = "このカードの表面には特別な効果がある！"
  },
  Skill_47091_Name_1 = {Text = "効果2"},
  Skill_47092_Desc_1 = {
    Text = "このカードの表面には特別な効果がある！"
  },
  Skill_47092_Name_1 = {Text = "効果1"},
  Skill_4709_Desc = {
    Text = "覚醒体を1体選択し、その指令カードをそれぞれ1枚手札に追加する。守秘者とシルバーキーの共鳴は、覚醒体たちに継続戦闘の勇気をもたらした……"
  },
  Skill_4709_Name = {
    Text = "シルバーキー共鳴"
  },
  Skill_4710_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を一時的に減少させ、ターン終了時に解除される。"
  },
  Skill_4711_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4712_Desc = {
    Text = "<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を1枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4712_Name = {
    Text = "盛大な歓迎"
  },
  Skill_4713_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が[Arg2]点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_4714_AwakerSkillBackgroundStory = {
    Text = "懲戒——それは彼の星々の如く多彩な権能の内、最も取るに足らないもの。"
  },
  Skill_4714_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、追加で[Arg4]％の触腕ダメージと力量ボーナスを享受する。<Energy:[Energy:Arg2]>狂気を獲得。<RippleKeywords:余波>：1本の触腕が敵に攻撃する。"
  },
  Skill_4714_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg4]%の触腕ダメージボーナスと力ボーナスを獲得。[Energy:[Energy:Arg2]>狂気を獲得。[TentaclePower:Arg3]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4714_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与え、[Arg4]%の触腕ダメージと力のボーナスを追加で受ける。トゥルーは<Energy:[Energy:Arg2]>狂気を獲得。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4714_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg4]%の触腕ダメージボーナスと力ボーナスを獲得。トゥルーは<Energy:[Energy:Arg2]>狂気を獲得。[TentaclePower:Arg3]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4714_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4714_EffectNameList_2 = {
    Text = "ダメージ,狂気,一時的な触腕ダメージ,一時的な力"
  },
  Skill_4714_Name = {Text = "攻撃"},
  Skill_4714_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4714_PropertyNameList_2 = {
    Text = "攻撃力×GrowValue1,$GrowValue2,攻撃力×GrowValue3,攻撃力×GrowValue3"
  },
  Skill_4715_AwakerSkillBackgroundStory = {
    Text = "主な材料：ブルーチーズ、インドカレー、新鮮なカエルの脚少々。\n準備手順：材料を混ぜて7日間漬け込み、ピートウイスキーを1オンス。\n\nその他：盛り付けが重要、ローズマリーを笑顔の形に曲げること。\n忘れずに！絶対忘れずに！"
  },
  Skill_4715_Desc = {
    Text = "すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>と1点の<WeaknessIconKeywords:虚弱>を付与し、ライフを<Heal:[Heal:Arg2]>回復。"
  },
  Skill_4715_EffectNameList_0 = {Text = "毒,回復"},
  Skill_4715_Name = {
    Text = "ガマシチュー"
  },
  Skill_4715_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,体力×GrowValue2"
  },
  Skill_4716_AwakerSkillBackgroundStory = {
    Text = "アクセル、ブレーキ、正常。燃料タンク、正常。エンジン状態、良好。\n\n彼女は準備完了、出発準備完了、冒険準備完了、来るべき未知に準備完了。\n\n一輪車が彼女の下で轟音の響きを立て、漆黒のキャタピラが高速で回転し、超然たる速度で前進する。"
  },
  Skill_4716_Desc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドと [Counterattack:Arg2] スタックの<RetaliateIconKeywords:カウンター>を獲得する。現在のシールドを 50% 上昇させる。全ての敵に [Arg3]％ の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_4716_Desc_3 = {
    Text = "<Block:[Block:Arg1]> 点のシールドと [Counterattack:Arg2] スタックの<RetaliateIconKeywords:カウンター>を獲得する。現在のシールドを 50% 上昇させる。全ての敵に [Arg3]％ の<RetaliateIconKeywords:カウンター>を発動する。自身は<FragileIconKeywords:脆弱>・<WeaknessIconKeywords:虚弱>・<VulnerabilityIconKeywords:易傷>を 1 ターン免疫する。"
  },
  Skill_4716_EffectNameList_0 = {
    Text = "シールド,反撃"
  },
  Skill_4716_Name = {
    Text = "準備完了"
  },
  Skill_4716_OverLimitUtlSkillDesc_0 = {
    Text = "<Block:[Block:Arg1]> 点のシールドと [Counterattack:Arg2] スタックの<RetaliateIconKeywords:カウンター>を獲得する。シールド上限を無視して、現在のシールドを 50% 上昇させる。全ての敵に [Arg4]％ の<RetaliateIconKeywords:カウンター>を発動する。"
  },
  Skill_4716_OverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]> 点のシールドと [Counterattack:Arg2] スタックの<RetaliateIconKeywords:カウンター>を獲得する。シールド上限を無視して、現在のシールドを 50% 上昇させる。全ての敵に [Arg4]％ の<RetaliateIconKeywords:カウンター>を発動する。自身は<FragileIconKeywords:脆弱>・<WeaknessIconKeywords:虚弱>・<VulnerabilityIconKeywords:易傷>を 1 ターン免疫する。"
  },
  Skill_4716_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4718_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4718_Name = {Text = "事故死"},
  Skill_4719_AwakerSkillBackgroundStory = {
    Text = "人間の体で歩くことに慣れた後、ロータンは相応しい武器を見つけるのに長い時間を費やした。\n今日に至るまで、この大剣が自分にふさわしいとは思っていないが、仕方なく使っている。"
  },
  Skill_4719_Desc_0 = {
    Text = "ランダムな敵1体に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]回繰り返す。このターン中「攻撃」を1枚使用するごとに、行動力消費が1点減少。"
  },
  Skill_4719_Desc_1 = {
    Text = "ランダムな敵1体に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]回繰り返す。このターン中「攻撃」を1枚使用するごとに、行動力消費が1点減少。このカードは「攻撃」として扱う。"
  },
  Skill_4719_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4719_Name = {
    Text = "傲慢の刃"
  },
  Skill_4719_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4720_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_23:「傷口」>を[Arg3]枚相手の山札のランダムな位置に追加する。"
  },
  Skill_4720_Name = {
    Text = "傷を与える"
  },
  Skill_4721_AwakerSkillBackgroundStory = {
    Text = "祭司になったとき、ミリアムはこの短剣を授けられた。"
  },
  Skill_4721_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、このダメージは100%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得。<Energy:[Energy:Arg2]> 狂気を獲得。<O07CardKeyWord:祭儀>：最終ダメージが[Arg4]%/[Arg5]%/[Arg6]%増加。"
  },
  Skill_4721_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、このダメージは100%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得。ミリアムは <Energy:[Energy:Arg2]> 狂気を獲得。<O07CardKeyWord:祭儀>：最終ダメージが[Arg4]%/[Arg5]%/[Arg6]%増加。"
  },
  Skill_4721_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4721_Name = {Text = "攻撃"},
  Skill_4721_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4722_AwakerSkillBackgroundStory = {
    Text = "千年の孤独の中、その人の出現は深海に現れた幽光のようで、長く静寂だった海底を照らした。\n公平な対決のために、ロータンは人間の姿に甘んじ、密かに対人戦相手の成長を待った——彼女は長い間、激しい戦いを渇望していた。"
  },
  Skill_4722_Desc_0 = {
    Text = "ロータンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ロータンのダメージ回数を[Arg2]回増加。"
  },
  Skill_4722_Desc_15 = {
    Text = "ロータンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ロータンのダメージ回数を[Arg2]回増加。ロータンの「防御」は、このターン中、次に使用する「傲慢の刃」を2回発動させる。"
  },
  Skill_4722_EffectNameList = {Text = "狂気"},
  Skill_4722_Name = {
    Text = "戦欲抑え難し"
  },
  Skill_4723_Desc = {
    Text = "「狩猟の印」1点につき[Arg2]点のシールドを獲得する。"
  },
  Skill_4723_Name = {
    Text = "蓄力の残響"
  },
  Skill_4724_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_26:「症状：妄想」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4724_Name = {
    Text = "泣き叫ぶ"
  },
  Skill_4725_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4726_Desc = {
    Text = "最も狂気が高い覚醒体に一時的な封印を1点付与し、<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。"
  },
  Skill_4727_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4727_Name = {
    Text = "噛みつき"
  },
  Skill_4728_AwakerSkillBackgroundStory = {
    Text = "僕は人間としてのすべてを捨てた！深海の懐に戻るのだ！\nそれなのに——なぜ、変容は失敗したのか？\n運命の嘲弄か？それとも、自らの愚かさか？\n狂気に満ちたカエクスは壊れた槍を抱え、海底に沈もうとする。\nただ帰りたい——受け入れられたい——\n\nそのためなら、どれほどの障害があろうとも、彼はすべてを薙ぎ払うのだ。"
  },
  Skill_4728_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、同量の<RetaliateIconKeywords:反撃>を獲得し、50%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを受ける。"
  },
  Skill_4728_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、同量の<RetaliateIconKeywords:反撃>を獲得し、50%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを受ける。<Energy:[Energy:Arg2]>の狂気を獲得。"
  },
  Skill_4728_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4728_EffectNameList_1 = {
    Text = "ダメージ,狂気"
  },
  Skill_4728_Name = {
    Text = "破砕の沈戟"
  },
  Skill_4728_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4728_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_4729_AwakerSkillBackgroundStory = {
    Text = "「そう、確かに、余は彼女にそう約束した」\n故国が滅びた日を語るとき、幼き王の顔には疲れの色が濃く浮かぶ。\n\n「余はただ彼女の死の恐怖を和らげたかったのだ。\nまさか、彼女があれほどまでに、それを信条とするとは……」"
  },
  Skill_4729_Desc_0 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>状態を解除する。[TentaclePower:Arg1]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg1]点の一時的な<PowerIconKeywords:力量>を獲得する。現在の姿勢が「静海」の場合、追加ですべての敵の本ターン中の<ExhaustionIconKeywords:力量>を[Exhaustion:Arg3]点減少させる。<RippleKeywords:余波>：1本の触腕が敵に攻撃する。"
  },
  Skill_4729_Desc_3 = {
    Text = "自身の<WeaknessIconKeywords:虚弱>を解除。[TentaclePower:Arg1]点の一時的な<TentacleInjurieIconKeywords:触腕ダメージ>と[Power:Arg1]点の一時的な<PowerIconKeywords:力>を獲得。[Arg2]%の一時的なクリティカル率を獲得。現在の触腕姿勢が「静海」の場合、このターン中、すべての敵から[Exhaustion:Arg3]点の<ExhaustionIconKeywords:力>を減少させる。<RippleKeywords:余波>：触腕1本に敵を攻撃させる。"
  },
  Skill_4729_EffectNameList_0 = {
    Text = "一時的触腕ダメージ,一時的力量,力量減少"
  },
  Skill_4729_Name = {
    Text = "ルルイエ再臨"
  },
  Skill_4729_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4731_Desc = {
    Text = "[Arg1]点のシールドを獲得し、<TouquKeywords:永久的に>[Arg3]点の<PowerIconKeywords:力>を奪う。"
  },
  Skill_4731_Name = {
    Text = "蓄力の残響"
  },
  Skill_4732_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4733_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4734_Desc = {
    Text = "[Arg2]点の<IntoxicationIconKeywords:毒>を付与する。他に敵が存在する場合、自身を犠牲にして寄生し、「被寄生」状態を付与する。"
  },
  Skill_4735_Desc = {
    Text = "[Arg1]点の<WeaknessIconKeywords:倦怠>を付与し、山札と捨て札の上の[Arg3]枚のカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_4735_Name = {
    Text = "永遠の瞳"
  },
  Skill_4736_Desc = {
    Text = "「提灯」を2体召喚する。"
  },
  Skill_4736_Name = {Text = "召喚"},
  Skill_4737_Desc = {
    Text = "「祈り」をすべて消費し、1点につき[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4737_Name = {
    Text = "融蝕を抱く"
  },
  Skill_4738_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4739_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_4740_AwakerSkillBackgroundStory = {
    Text = "光を追う本能で虫は光を追いかけるが、その明るい灯火はあまりに眩しく、水面下の暗流の激しさを見逃しがちだ……"
  },
  Skill_4740_Desc = {
    Text = "このターンに触腕ダメージを与えた場合、すべての敵に[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_4740_EffectNameList = {Text = "毒層数"},
  Skill_4740_Name = {
    Text = "深淵の暗流"
  },
  Skill_4740_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4741_Desc = {
    Text = "ターン終了時、このカードがまだ手札にあり、このターンの残り行動力が2点以上の場合、次のターン追加でカードを2枚引く。"
  },
  Skill_4741_Name = {
    Text = "症状：興奮"
  },
  Skill_4742_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4742_Name = {Text = "強化"},
  Skill_4743_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4744_AwakerSkillBackgroundStory = {
    Text = "彼女は本当は屈したくなかったが、最も完璧な復讐には一時的な忍耐が必要だ。"
  },
  Skill_4744_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4744_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気と25%の一時的なクリティカル率を獲得。"
  },
  Skill_4744_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4744_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ヘロットは<Energy:[Energy:Arg2]>狂気と25%の一時的なクリティカル率を獲得。"
  },
  Skill_4744_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4744_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_47455_Desc_1 = {
    Text = "対象1体に<StrengthenKeywords:砂嚢>を付与する。"
  },
  Skill_47455_Name_1 = {Text = "砂嚢"},
  Skill_4745_AwakerSkillBackgroundStory = {
    Text = "機械の身体の中で、二つの意志が絶えず抗い、ぶつかり合う——\n一方は破壊を望み、もう一方は屈服を拒んでいた。\n\nだが小さき人間の意志が長く持ちこたえられるはずもない。\nやがて彼女は取り込まれ、破壊のためだけに存在する狂気の器と化す。\n\nだから彼女はすべての電流を解放した。\n\n巨大な電弧が身を包み、ショートした身体が火花を散らし炸裂音を上げる。\n蓄えたエネルギーを前方に放ち、そして機能を一時的に停止する。\n\n「動けなければ、破壊もできない」"
  },
  Skill_4745_Desc_0 = {
    Text = "エリカは[Arg4]％の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4745_Desc_2 = {
    Text = "[Arg4]%の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。追加で[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを獲得。"
  },
  Skill_4745_EffectNameList_0 = {
    Text = "ダメージ,シールド"
  },
  Skill_4745_Name = {
    Text = "電磁爆破"
  },
  Skill_4745_OverLimitUtlSkillDesc_0 = {
    Text = "エリカは [Arg4]% の一時的なクリティカル率とクリティカルダメージを得る。<Block:[Block:Arg6]> 点のシールドを得る。全ての敵に <Damage:[Damage:Arg5]> のダメージを与え、[Arg3] スタックの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。エリカの「基礎打撃」が追加で1回ダメージを与え、「基礎防御」が追加で1回シールドを得る効果が3ターン持続する。"
  },
  Skill_4745_OverLimitUtlSkillDesc_2 = {
    Text = "エリカは[Arg4]％の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg6]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg5]>ダメージを与え、[Arg3]層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。このスキルは[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを追加で受ける。エリカの「基礎打撃」が追加で1回ダメージを与え、「基礎防御」が追加で1回シールドを獲得する。3ターン持続。"
  },
  Skill_4745_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4745_tempBattleDesc_1 = {
    Text = "エリカは[Arg4]％の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4745_tempBattleDesc_2 = {
    Text = "[Arg4]%の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。追加で[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを獲得。"
  },
  Skill_4745_tempBattleDesc_3 = {
    Text = "[Arg4]% の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg2]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。追加で[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを獲得。以降に発動する狂気解放は、獲得する力と警戒ボーナスが1倍増加する。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_1 = {
    Text = "エリカは [Arg4]% の一時的なクリティカルレートとクリティカルダメージを獲得する。<Block:[Block:Arg6]> ポイントのシールドを獲得する。全ての敵に <Damage:[Damage:Arg5]> ダメージを与え、[Arg3] 層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。エリカの「基礎打撃」は追加で1回ダメージを与え、「基礎防御」は追加で1回シールドを獲得し、3ターン持続する。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_2 = {
    Text = "[Arg4]%の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg6]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg5]>ダメージを与え、[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。追加で[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを獲得。エリカの「攻撃」は追加でダメージを1回与え、「防御」は追加でシールドを1回獲得する。3ターン持続。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_3 = {
    Text = "[Arg4]%の一時的なクリティカル率とクリティカルダメージを獲得。<Block:[Block:Arg6]>点のシールドを獲得。すべての敵に<Damage:[Damage:Arg5]>ダメージを与え、[Arg3]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。追加で[Arg7]倍の<PowerIconKeywords:力>と<AlertIconKeywords:警戒>ボーナスを獲得。以降に発動する狂気解放は、獲得する力と警戒ボーナスが追加で1倍増加する。エリカの「攻撃」は追加でダメージを1回与え、「防御」は追加でシールドを1回獲得する。3ターン持続。"
  },
  Skill_4746_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_28:「症状：崩壊」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4746_Name = {
    Text = "泣き叫ぶ！！"
  },
  Skill_4747_Desc = {
    Text = "あなたの長期戦が密境の注目を集めた…<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「怒り」状態を獲得し、敵の力が持続的に増加する！"
  },
  Skill_4747_Name = {Text = "冒涜"},
  Skill_47484_Desc = {
    Text = "2点の行動力を獲得し、カードを2枚引く。"
  },
  Skill_47484_Name = {
    Text = "上位啓示"
  },
  Skill_4748_AwakerSkillBackgroundStory = {
    Text = "子供たちは徐々に童話の本質を見抜き、神話の背後にある寓話を理解するようになる。この過程は人間の言葉で「成長」と呼ばれる。\nしかし、寝る前の物語をますます信じる子供たちもいる。彼らは空に虹の橋が本当にあり、文明が深海に沈んでいると固く信じている。\nオレッタはこれらの物語が好きで、この喜びをもっと多くの仲間と分かち合いたいと思っている。"
  },
  Skill_4748_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ> +[TentaclePower:Arg1]。すべての手札を捨て、同数のカードを引く。「腺体分裂」を1枚捨て札に混ぜ入れる。"
  },
  Skill_4748_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕ダメージ>+[TentaclePower:Arg1]。すべての手札を捨て、同数+1のカードを引く。「腺体分裂」を1枚捨て札に追加する。"
  },
  Skill_4748_EffectNameList = {
    Text = "触腕ダメージ,「腺体分裂」レベル"
  },
  Skill_4748_Name = {
    Text = "仲間の力"
  },
  Skill_4748_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4749_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4750_AwakerSkillBackgroundStory = {
    Text = "育め、誕生せよ、繁栄せよ。\n溶けゆく現実の中で、暗闇に足を踏み入れ、新生する虚空の中で。\n\nあなたたちの存在は、母の犠牲の果実であり、母の存続の理由である。\n\n聖純の子よ、新世界で再生せよ——無垢で、すべての恐怖を消し去った新世界で再生せよ。"
  },
  Skill_4750_Desc_0 = {
    Text = "タイスは<Energy:[Energy:Arg1]>狂気を獲得。\n<ExaltIconKeywords:霊知覚醒>：即座に<DerivativeCardKeywords_10:聖純の子>を1枚獲得。キーオーダーを発動するたび、手札にある胚胎を1枚<DerivativeCardKeywords_10:聖純の子>に変換する。"
  },
  Skill_4750_Desc_15 = {
    Text = "タイスは <Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：即座に<DerivativeCardKeywords_10:聖純の子>を1枚獲得する。キーオーダーを発動するたび、手札にある胚胎を1枚<DerivativeCardKeywords_10:聖純の子>に変換する。「豊穣の儀」は追加でコピーを1枚手札に追加する。"
  },
  Skill_4750_EffectNameList = {Text = "狂気"},
  Skill_4750_Name = {
    Text = "慈母邂逅"
  },
  Skill_47516_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、他の覚醒体の[Arg1]枚のカードを捨てる。成功した場合、[Arg2]枚のカードを引きます。"
  },
  Skill_47516_Name_1 = {
    Text = "銀ダラの決意"
  },
  Skill_4751_AwakerSkillBackgroundStory = {
    Text = "「まばたき禁止よ？見逃さないでね、ここから魔法のクライマックス！」\n\n白い手袋、黒いシルクハット、七色のトランプが宙に舞う！\n\n「リボンみたいに華麗で、スパンコールのように輝く、ちょっぴりクレイジーで夢いっぱいのマジカルショー！きっとあなたには予測できない！」"
  },
  Skill_4751_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、カードを[Arg2]枚引く。カーシアの指令カードを1枚引くたび、ランダムな敵に<Damage:[Damage:Arg1]>ダメージを与える。カーシアの基礎ダメージが[Arg3]%増加。"
  },
  Skill_4751_Desc_2 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、カードを[Arg2]枚引く。症状カード、ステータスカード、またはカーシアの指令カードを1枚引くたび、ランダムな敵に<Damage:[Damage:Arg1]>ダメージを与える。カーシアの基礎ダメージが[Arg3]%増加。"
  },
  Skill_4751_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4751_Name = {
    Text = "マジックカーニバル"
  },
  Skill_4751_OverLimitUtlSkillDesc_0 = {
    Text = "全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg4] 回与え、[Arg2] 枚ドローし、カーシアの指令カードを1枚ドローするたびにランダムな敵に <Damage:[Damage:Arg1]> 点のダメージを  [Arg4]  回与える。カーシアの全ての基礎ダメージを [Arg3]% 上昇させる。その後 [Arg6] 回カーシアの指令カードを打ち出した後、[Power:Arg5] 点の力を得る。"
  },
  Skill_4751_OverLimitUtlSkillDesc_2 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg4]回与え、カードを[Arg2]枚引く。症状カード、ステータスカード、またはカーシアの指令カードを1枚引くたび、ランダムな敵に<Damage:[Damage:Arg1]>ダメージを[Arg4]回与える。カーシアのすべての基礎ダメージが[Arg3]％増加。その後カーシアの指令カードを[Arg6]回使用した後、[Power:Arg5]点の力を獲得。"
  },
  Skill_4751_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4752_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4753_AwakerSkillBackgroundStory = {
    Text = "棘は敵意、それは侵入者に振るわれる刃。"
  },
  Skill_4753_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]%の反撃ボーナスを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4753_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg3]%の反撃ボーナスを獲得。カエクスは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4753_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4753_Name = {Text = "攻撃"},
  Skill_4753_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4754_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4754_Name = {Text = "遺恨"},
  Skill_4755_AwakerSkillBackgroundStory = {
    Text = "ミリアムは深く信じている——この短剣には、無数の儀式の中で神の力が注ぎ込まれたのだと。"
  },
  Skill_4755_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<O07CardKeyWord:祭仪>：すべての敵の<ExhaustionIconKeywords:力量>を一時的に[Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5]点減少させる。"
  },
  Skill_4755_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ミリアムは<Energy:[Energy:Arg2]>狂気を獲得。<O07CardKeyWord:祭儀>：すべての敵から[Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5]点の<ExhaustionIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4755_EffectNameList = {
    Text = "シールド,狂気,力低下"
  },
  Skill_4755_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4756_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4756_Name = {Text = "試み"},
  Skill_4757_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4758_AwakerSkillBackgroundStory = {
    Text = "彼女は新しい名前でこの世に再び現れ、顔を隠し、輪郭を失った。\n世に残るのは、彼女の語り口で綴られた詩篇のみ。\n\nそれで十分だ。\n\n詩人に姿は不要……彼らは濃墨の中、書の裏側にこそ在るべきなのだから。"
  },
  Skill_4758_BattleDesc = {
    Text = "[Power:Arg1]点<PowerIconKeywords:力>を獲得し、すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg2]点減少させる。<TransitionIconKeywords:跳躍>：感情「惧」に切り替える。"
  },
  Skill_4758_Desc = {
    Text = "[Power:Arg1]点<PowerIconKeywords:力>を獲得し、すべての敵の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg2]点減少させる。<TransitionIconKeywords:跳躍>：感情「惧」に切り替える。隠喩「惧」を1層消費するごとに、追加で[Power:Arg3]点<PowerIconKeywords:力>を獲得。"
  },
  Skill_4758_EffectNameList = {
    Text = "力,力減少,力の追加"
  },
  Skill_4758_Name = {
    Text = "神秘の詩篇"
  },
  Skill_4758_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4759_AwakerSkillBackgroundStory = {
    Text = "世界には特別なクラゲが存在し、傷つくとその落ちた組織が再び完全なポリプ体に成長することができる。\n「オレッタもクラゲを生む！だからオレッタもクラゲだ！」\n子供が世界を認識するこの段階では、彼女の興を削がない方がいいだろう。"
  },
  Skill_4759_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_4759_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:貫通ダメージ>を与える。「腺体分裂」を[Arg2]枚捨て札に混ぜ入れる。<RippleKeywords:余波>：<Energy:[Energy:Arg3]>点の狂気を獲得。"
  },
  Skill_4759_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4759_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4760_AwakerSkillBackgroundStory = {
    Text = "アイギスのテディベアに長時間見つめられた物体は、視線の落ちた地点から色彩化、繊維化が始まる。\nしばらくすると、その領域はカラフルな毛糸のような物質に変わり、テディベアに吸収される。\n視線を遮らないと、見つめられた物体は完全に分解され、テディベアの一部となる可能性がある。\n\n観察によれば、アイギス本人だけはテディベアの視線の影響を受けない。"
  },
  Skill_4760_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、2倍の力ボーナスを享受する。ターゲットが<VulnerabilityIconKeywords:易傷>状態の場合、このカードの消費した算力を返還し、カードを1枚引く。"
  },
  Skill_4760_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを与え、2倍の力ボーナスを享受する。ターゲットが<VulnerabilityIconKeywords:易傷>状態の場合、このカードの消費した算力を返還し、カードを1枚引く。ターゲットが<VulnerabilityIconKeywords:易傷>を1層持つごとに、「石質分解」の最終ダメージが[Arg2]%追加で上昇する（最大500%）。"
  },
  Skill_4760_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4760_Name = {
    Text = "石の分解"
  },
  Skill_4760_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4761_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、相手の手札をすべて捨てさせる。"
  },
  Skill_4761_Name = {Text = "離散"},
  Skill_4762_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得し、前進する。"
  },
  Skill_4763_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、このダメージは[Arg2]倍の力ボーナスを受け、[Arg3]％ダメージ分の<RetaliateIconKeywords:一時的な反撃>を獲得。"
  },
  Skill_4763_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4763_Name = {
    Text = "千変万化"
  },
  Skill_4763_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4764_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、このダメージは[Arg2]倍の力ボーナスを受ける。"
  },
  Skill_4764_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4764_Name = {
    Text = "千変万化"
  },
  Skill_4764_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4765_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_29:「症状：夢の呟き」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4765_Name = {
    Text = "泣き叫ぶ！！！"
  },
  Skill_4766_Desc = {
    Text = "すべての敵から[Arg2]点の力を一時的に減少させ、<DerivativeCardKeywords_30:「症状：ショック」>を1枚手札に追加する。「とても痛い？本当にかわいそう……泣けば楽になるわ！」"
  },
  Skill_4766_Name = {
    Text = "泣き叫ぶ！！！！"
  },
  Skill_4767_AwakerSkillBackgroundStory = {
    Text = "防御は、この殺戮の宴を無限に延ばすためのものだ。結局、死者は何の楽しみも味わえないのだから、そうだろう？"
  },
  Skill_4767_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4767_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ユウハシュは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4767_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4767_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4768_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4768_Name = {
    Text = "遺恨の捕獲"
  },
  Skill_4769_AwakerSkillBackgroundStory = {
    Text = "彼女の都は膨張し続ける廃墟。\n\n夢はここで死に絶えたが、廃墟はそれを知らない。\nただ忠実に膨張するだけ。\n\n世界はすでにそれを忘れている。"
  },
  Skill_4769_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]層の<RetaliateIconKeywords:反撃>を獲得し、このターン次の跳躍効果が必ず発動する。<DreamGuide:夢引き>の層数を消費して<JingjinvwangKeywords1:深眠反撃>または<JingjinvwangKeywords2:呓語回音>を発動できる。<DreamGuide:夢引き>の層数が5層未満の場合、1層の<DreamGuide:夢引き>を獲得する。"
  },
  Skill_4769_EffectNameList = {
    Text = "シールド,反撃,深眠反撃で狂気獲得,一時的な反撃割合"
  },
  Skill_4769_Name = {
    Text = "死せる夢の都"
  },
  Skill_4769_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。夢引きを消費せず「<JingjinvwangKeywords3:眠りを誘う脈動>」、「<JingjinvwangKeywords1:深き眠りの反撃>」と「<JingjinvwangKeywords2:夢の呟きの反響>」を同時に発動する。"
  },
  Skill_4769_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,$GrowValue3,$GrowValue4％"
  },
  Skill_4769_tempBattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。<DreamGuide:夢引き>を消費して、<JingjinvwangKeywords1:深き眠りの反撃>または<JingjinvwangKeywords2:夢の呟きの反響>を発動する。<DreamGuide:夢引き>が5点未満の場合、1点の<DreamGuide:夢引き>を獲得する。"
  },
  Skill_4769_tempBattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。夢引きを消費せずに、「<JingjinvwangKeywords3:眠りを誘う脈動>」、「<JingjinvwangKeywords1:深き眠りの反撃>」、「<JingjinvwangKeywords2:夢の呟きの反響>」を同時に発動する。ワンダが次に出す2枚の指令カードは追加で1回発動する。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。夢引きを消費せず「<JingjinvwangKeywords3:眠りを誘う脈動>」、「<JingjinvwangKeywords1:深き眠りの反撃>」と「<JingjinvwangKeywords2:夢の呟きの反響>」を同時に発動する。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。夢引きを消費せず「<JingjinvwangKeywords3:眠りを誘う脈動>」、「<JingjinvwangKeywords1:深き眠りの反撃>」と「<JingjinvwangKeywords2:夢の呟きの反響>」を同時に発動する。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得。このターンの次の跳躍効果は必ず発動する。夢引きを消費せずに、「<JingjinvwangKeywords3:眠りを誘う脈動>」、「<JingjinvwangKeywords1:深き眠りの反撃>」、「<JingjinvwangKeywords2:夢の呟きの反響>」を同時に発動する。ワンダが次に出す2枚の指令カードは追加で1回発動する。"
  },
  Skill_4770_AwakerSkillBackgroundStory = {
    Text = "ソレールのサロンでは、終幕前のロンドが定番の演目だった。\n酒と欲望の誘いに抗えず、隣国の王子も、宮廷の重臣も、側仕えの侍女でさえも手を取り合い、舞踏会の渦へと飛び込んだ。\n音楽が弱まり、サロンが終わると、ソレールの傍には権力と地平線から昇る黎明の微光しか残らない。"
  },
  Skill_4770_Desc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:多重捕食>：今回の「権欲の輪舞」のダメージ回数+[Arg3]、ライフ回復+<Heal:[Heal:Arg6]>。】ランダムに<Damage:[Damage:Arg2]>ダメージを[Arg1]回与える。ターン終了時に<Heal:[Heal:Arg4]>点のライフを回復。"
  },
  Skill_4770_EffectNameList_0 = {
    Text = "ダメージ,回復,無限捕食回復"
  },
  Skill_4770_EffectNameList_7 = {
    Text = "ダメージ,回復,ダメージごとの回復,無限捕食の回復"
  },
  Skill_4770_Name = {
    Text = "権欲の輪舞"
  },
  Skill_4770_OverLimitUtlSkillDesc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:多重捕食>：今回の「権欲の輪舞」のダメージ回数+[Arg3]、ライフ回復+<Heal:[Heal:Arg6]>点】ランダムに<Damage:[Damage:Arg2]>ダメージを[Arg1]回与える。<Heal:[Heal:Arg4]>点のライフを回復。ソレールの次の3枚の指令カードを2回発動させる。今回の狂気爆発で1回ダメージを与えるごとに、ターン終了時に<Heal:[Heal:Arg5]>点のライフを回復。"
  },
  Skill_4770_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,体質×GrowValue2,体質×GrowValue4"
  },
  Skill_4770_PropertyNameList_7 = {
    Text = "攻撃力×GrowValue1,体力×GrowValue2,体力×GrowValue3,体力×GrowValue4"
  },
  Skill_4771_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。現在のライフが25％([Arg3])未満の場合、<Heal:[Heal:Arg2]>点のライフを回復する。"
  },
  Skill_4771_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得する。現在のライフが25％未満の場合、<Heal:[Heal:Arg2]>点のライフを回復する。"
  },
  Skill_4771_Name = {
    Text = "注射の加護"
  },
  Skill_4773_Desc = {
    Text = "ランダムな覚醒体に一時的な封印を1点付与する。これを2回繰り返す。"
  },
  Skill_4774_AwakerSkillBackgroundStory = {
    Text = "彼女は迷える旅人を引き寄せるために、湖の真ん中に堕落を植えた。\n\n吟遊詩人は歌う――\n贈り物の小箱の一角が開き、希少な宝物が輝く\n舞台カーテンの一角が開き、情熱の歌声が響く"
  },
  Skill_4774_Desc_0 = {
    Text = "[Counterattack:Arg1]点の<RetaliateIconKeywords:反撃>を獲得。すべての敵から[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。敵が1体の場合、力減少効果が50％増加する。<TransitionIconKeywords:跳躍>：5点の<DreamGuide:夢引き>を消費し、成功した場合は[Arg3]点の<RetaliateIconKeywords:反撃>を追加で獲得。失敗した場合は2点の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4774_EffectNameList_0 = {
    Text = "反撃,力減少,反撃追加"
  },
  Skill_4774_EffectNameList_2 = {
    Text = "反撃,力減少,反撃追加"
  },
  Skill_4774_Name = {
    Text = "迷い人の守護"
  },
  Skill_4774_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4774_PropertyNameList_2 = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4775_Desc = {
    Text = "覚醒体を1体選択し、<Energy:[Energy:Arg1]>狂気を獲得させる。"
  },
  Skill_4775_Name = {
    Text = "上位誘導性触媒"
  },
  Skill_4776_AwakerSkillBackgroundStory = {
    Text = "S&Mは主従関係の重要な部分。\n主人が奴隷に与えるものは、キスであれ鞭打ちであれ、奴隷は愛と感謝の涙で受け取らなければならない。\n\nなぜなら、あなたは本当の奴隷ではなく、快楽を追求する享楽者だから。"
  },
  Skill_4776_Desc_0 = {
    Text = "パンディアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。パンディアがダメージを1回与えるたび、[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_4776_Desc_15 = {
    Text = "パンディアは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。パンディアがダメージを1回与えるたび、[Counterattack:Arg2]点の<RetaliateIconKeywords:反撃>を獲得する。パンディアが永続的な<RetaliateIconKeywords:反撃>を獲得した場合、[Arg4]%の力を獲得する。"
  },
  Skill_4776_EffectNameList = {
    Text = "狂気,反撃,ダメージを与えると反撃獲得"
  },
  Skill_4776_Name = {Text = "S&M"},
  Skill_4776_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue3,攻撃力×GrowValue2"
  },
  Skill_4777_AwakerSkillBackgroundStory = {
    Text = "「殺さなきゃ、黒いものは全部、全部殺さなきゃ……！でないと死ぬのは私、死ぬのは私……」"
  },
  Skill_4777_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4777_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%のカウンターバフを獲得。"
  },
  Skill_4777_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ウインクルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4777_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ウインクルは<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%のカウンターバフを獲得。"
  },
  Skill_4777_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_4777_EffectNameList_1 = {
    Text = "ダメージ,狂気,カウンターバフ"
  },
  Skill_4777_Name = {Text = "攻撃"},
  Skill_4777_PropertyNameList_0 = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4777_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,$GrowValue2,$GrowValue3%"
  },
  Skill_4778_AwakerSkillBackgroundStory = {
    Text = "ファイントは揺りかごを離れたくないが、幸いにも、この揺りかごは彼女と一体である——ファイントの同族が孵化する前のように。"
  },
  Skill_4778_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4778_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与え、50%の一時的な<RetaliateIconKeywords:反撃>を獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4778_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ファイントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4778_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg3]回与え、50%の一時的な<RetaliateIconKeywords:反撃>を獲得。ファイントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4778_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_4778_Name = {Text = "攻撃"},
  Skill_4778_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_4780_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4780_Name = {
    Text = "ブラウン出撃！"
  },
  Skill_47818_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_47818_Name = {Text = "攻撃"},
  Skill_4781_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_47820_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_47820_Name = {Text = "攻撃"},
  Skill_4782_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4784_AwakerSkillBackgroundStory = {
    Text = "どんなに模倣しても、人類の技術では@2人特有の技術を完全に再現することはできない。\n\n精神を集めた装置は激しく震え、戦う仲間に力を与えるが、彼女を人工の肉体から解放することはできない。\n\nかつては呼吸のように自然だった能力は、いまやもう二度と使えない。"
  },
  Skill_4784_Desc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>を解除し、<Block:[Block:Arg1]>点のシールドを獲得。[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。他の覚醒体を1体選択し、<Energy:[Energy:Arg2]>狂気を獲得させる。"
  },
  Skill_4784_Desc_3 = {
    Text = "自身の<FragileIconKeywords:脆弱>を解除し、<Block:[Block:Arg1]>点のシールドを獲得。[Counterattack:Arg3]点の<RetaliateIconKeywords:反撃>を獲得。他の覚醒体を1体選択し、<Energy:[Energy:Arg2]>狂気を獲得させる。対応する覚醒体は、このターン狂気解放を2回発動可能。"
  },
  Skill_4784_EffectNameList = {
    Text = "シールド,狂気,反撃"
  },
  Skill_4784_Name = {
    Text = "無形の移動"
  },
  Skill_4784_OverLimitUtlSkillDesc_0 = {
    Text = "自身の<FragileIconKeywords:脆弱>状態を駆散し、<Block:[Block:Arg1]> 点のシールドを得る。[Counterattack:Arg3] スタックの<RetaliateIconKeywords:反撃>を得る。他の覚醒体を1体選択し、<Energy:[Energy:Arg2]> 点の狂気を得させる。選択した覚醒体のターン開始時に <Energy:[Energy:Arg4]> 点の狂気を得させ、3ターン持続する。"
  },
  Skill_4784_OverLimitUtlSkillDesc_3 = {
    Text = "自身の<FragileIconKeywords:脆弱>状態を解除し、<Block:[Block:Arg1]> 点のシールドを獲得。[Counterattack:Arg3] 層の<RetaliateIconKeywords:反撃>を獲得。他の覚醒体を1体選択し、<Energy:[Energy:Arg2]> 点の狂気を獲得させ、その覚醒体が本ターン中2回狂気爆発を発動した後にクールダウンに入るようにする。選択した覚醒体がターン開始時に<Energy:[Energy:Arg4]> 点の狂気を獲得、3ターン持続。"
  },
  Skill_4784_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_4785_AwakerSkillBackgroundStory = {
    Text = "「近づかないで……たとえ君たちの安全のためでも……近づかないで……」"
  },
  Skill_4785_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4785_BattleDesc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドと同量の<RetaliateIconKeywords:反撃>を獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4785_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ファイントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4785_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドと同量の<RetaliateIconKeywords:反撃>を獲得。ファイントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4785_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4785_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4786_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4786_Name = {Text = "事故死"},
  Skill_4787_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_4787_Name = {
    Text = "母体探索"
  },
  Skill_4788_Desc = {
    Text = "双方それぞれに[Arg1]点の<VulnerabilityIconKeywords:軟化>を付与する。「刃Ⅲ」を獲得する：ガードされなかったダメージを与えた場合、山札の上に<DerivativeCardKeywords_23:「傷口」>を3枚追加する。この効果は1ターン持続する。"
  },
  Skill_4788_Name = {
    Text = "最期のあがき"
  },
  Skill_4789_AwakerSkillBackgroundStory = {
    Text = "誰も、涙滴状のシルバーコアが埋め込まれたテディベアが、アイギスが召喚された後にこのような姿になった理由を説明できない。\nそれはアイギスの持つ上位者の力に関係しているかもしれないし、単に強大な精神力によって歪められた結果かもしれない。\n\nいずれにせよ、それは一定の自我を持っているようで、時折アイギスが注意を払っていないときに一部を剥がし、毛糸でできた花火のように散る。"
  },
  Skill_4789_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。<EmbryoFusionIconKeywords:胚胎融合>+[Arg3]。"
  },
  Skill_4789_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与する。<EmbryoFusionIconKeywords:胚胎融合>+[Arg3]。「捕食」発動後、「小さな希望」を捨て札から手札に戻し、その行動力消費を0にする。"
  },
  Skill_4789_EffectNameList = {
    Text = "ダメージ,胚胎融合"
  },
  Skill_4789_Name = {
    Text = "小さな希望"
  },
  Skill_4789_PropertyNameList = {
    Text = "攻撃力*GrowValue1,$GrowValue2"
  },
  Skill_4790_AwakerSkillBackgroundStory = {
    Text = "漆黒の粘液が彼女を深淵に引きずり込む。\n星々はここで生まれ、光はここで消える。\nここには時間も生命もない。\n\n遠くから声が近づいてきた——黒い光を放ちながら。\n\nそれは言った——\n「あなたは永遠に変わり果てる。妖精の通路を訪れてしまったから」\n彼女はここで長くさまようことになる。"
  },
  Skill_4790_Desc = {
    Text = "ジェンキンは<Energy:[Energy:Arg1]>狂気を獲得。\n<ExaltIconKeywords:霊知覚醒>：クリティカル率が[Arg2]%増加。ジェンキンが1回ダメージを与えるたび、このターン中にクリティカルダメージが[Arg3]%増加。"
  },
  Skill_4790_EffectNameList = {Text = "狂気"},
  Skill_4790_Name = {
    Text = "空間歪曲"
  },
  Skill_4791_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_4792_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4793_AwakerSkillBackgroundStory = {
    Text = "鋭い棘こそが最良の防御。"
  },
  Skill_4793_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1層の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4793_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ワンダは<Energy:[Energy:Arg2]>狂気を獲得。<TransitionIconKeywords:跳躍>：1層の<DreamGuide:夢引き>を獲得。"
  },
  Skill_4793_EffectNameList_0 = {
    Text = "シールド,狂気"
  },
  Skill_4793_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4794_Desc = {
    Text = "「鎖を断つ一撃」、「長き憎しみ」、「攻撃」、「防御」の中から1枚選択して手札に追加し、<DepleteIconKeywords:除外>を付与。"
  },
  Skill_4794_Name = {
    Text = "不規則形態"
  },
  Skill_4795_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_28:「症状：疑心」>を2枚山札のランダムな位置に追加する。"
  },
  Skill_4795_Name = {
    Text = "首狩りの呪い"
  },
  Skill_4796_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_4796_Name = {Text = "深淵"},
  Skill_4797_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4798_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_23:「傷口」>を[Arg3]枚山札のランダムな位置に追加する。"
  },
  Skill_47996_Desc = {
    Text = "解放済みの「キーオーダー」を1つ選択して発動し、その効果を2回発動させる。各解放済み「キーオーダー」はこの探索中1回しか選択できず、初期装備の「キーオーダー」は選択不可。"
  },
  Skill_47996_Name = {
    Text = "忘却に至らぬ黎明"
  },
  Skill_4800_AwakerSkillBackgroundStory = {
    Text = "ライカーは自分の勝利が幸運の女神の加護によるものだと信じていた。\n\nすべてを失うギャンブラーが皆そうであるように――\n彼もまた幸運の女神が目を離さないと信じていた。"
  },
  Skill_4800_Desc_0 = {
    Text = "ライカーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Power:Arg2]点の<PowerIconKeywords:力>を獲得。この戦闘中、<C05_zaowu:「混沌の遺志」>の遺物を1つ選択して獲得する、または既に所持している<C05_zaowu:「混沌の遺贈」>の遺物を1つアップグレードする。"
  },
  Skill_4800_Desc_15 = {
    Text = "ライカーは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：[Power:Arg2]点の<PowerIconKeywords:力>を獲得。この戦闘中、<C05_zaowu:「混沌の遺志」>の遺物を1つ選択して獲得する、または既に所持している<C05_zaowu:「混沌の遺志」>の遺物を1つアップグレードする。この効果を2回繰り返す。すべてのライカーの六面ダイスを八面ダイスにアップグレードする。"
  },
  Skill_4800_EffectNameList = {Text = "狂気,力"},
  Skill_4800_Name = {
    Text = "絶好の運"
  },
  Skill_4800_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_48018_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4802_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、<Block:[Block:Arg2]>点のシールドを獲得する。"
  },
  Skill_4803_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4804_AwakerSkillBackgroundStory = {
    Text = "炎が広がり、劇場の天蓋を翡翠の輝きに染める。\nそれは朝の澄んだ静かな湖水のよう。\n\nその翡翠の影を追い求めて来た者は数知れず。\nだが彼らの多くは流麗で力強い舞姿ではなく、ちらりと覗く白い腕や、想像上のスカートの中ばかりを見ていた。\n\n舞い手はただ緑炎に飲み込まれた瀕死の姿でそこに立ち尽くす。"
  },
  Skill_4804_Desc_0 = {
    Text = "リッツは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：リッツがダメージを[Arg2]回与えるたび、「<DepleteIconKeywords:除外>」が付与された<DerivativeCardKeywords_18:「緑炎」>を1枚手札に追加する。毎ターン最大3回まで発動可能。"
  },
  Skill_4804_Desc_15 = {
    Text = "リッツは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：リッツがダメージを[Arg2]回与えるたび、「<DepleteIconKeywords:除外>」が付与されたの<DerivativeCardKeywords_18:「緑炎」>を1枚手札に追加する。毎ターン最大3回まで発動可能。リッツがダメージを3回与えるたび、リッツがこの戦闘中に与えるダメージが[Arg3]増加する。"
  },
  Skill_4804_EffectNameList = {Text = "狂気"},
  Skill_4804_Name = {
    Text = "翡翠の映像"
  },
  Skill_4806_Desc = {
    Text = "[Arg1]点の<MadnessIconKeywords:発狂>を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を[Arg2]枚山札のランダムな位置に追加する。"
  },
  Skill_4806_Name = {Text = "発狂"},
  Skill_4807_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、他の覚醒体の「攻撃」を手札に追加する。ロータンの激励が皆の戦意を奮い立たせた……"
  },
  Skill_4807_Name = {
    Text = "不屈の戦意"
  },
  Skill_48084_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48085_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>と<Block:[Block:Arg2]>点のシールドを獲得し、<DerivativeCardKeywords_45:「次元閉鎖」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_48085_Name = {
    Text = "次元の防壁"
  },
  Skill_48086_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、直ちに2点の<ResentChainsKeywords:怨恨の鎖>状態を獲得する。"
  },
  Skill_48086_Name = {
    Text = "次元の鍵"
  },
  Skill_4808_AwakerSkillBackgroundStory = {
    Text = "両手は拳を握り、歯は噛みついて攻撃を与えることができる。\n\n孤立した兵士を侮ってはいけない。\n彼らの体のすべてが武器と見なせる。\n\n彼女はそう言いながら、脚の刃を展開した。"
  },
  Skill_4808_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。シールド1点につきダメージが2点増加する。このターン中「防御」を1枚使用するごとに、行動力消費–1。「打撃」として扱う。"
  },
  Skill_4808_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4808_Name = {
    Text = "心眼の刃"
  },
  Skill_4808_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4809_Desc = {
    Text = "クリティカル率が[Arg1]%増加し、クリティカルダメージが[Arg2]%増加。"
  },
  Skill_4809_Name = {
    Text = "クリティカル"
  },
  Skill_4810_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_4810_Name = {
    Text = "破砕の沈戟"
  },
  Skill_4811_AwakerSkillBackgroundStory = {
    Text = "ひとりぼっちの鼠が暗い隅を走り回る。\nそれは痩せ細り、小さく、ほうき一本で簡単に追い払える存在。\n\nストリートチルドレンもまた同じだった。\n\nしかし、小さき者にこそ宿る力がある。\n子どもと鼠が手を組んだとき、彼女たちは誰にも止められない存在になる。"
  },
  Skill_4811_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージをX+4回与える。<DerivativeCardKeywords_12:「鼠たちの突撃」>を1枚山札の一番上に追加する。<TransitionIconKeywords:跳躍>：追加で「ブラウン出撃！」を1枚山札の一番上に追加。"
  },
  Skill_4811_EffectNameList = {
    Text = "「鼠たちの突撃」ダメージ"
  },
  Skill_4811_Name = {
    Text = "鼠たちの集結"
  },
  Skill_4811_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4812_Desc = {
    Text = "追加で2倍の<PowerIconKeywords:力>ボーナスを獲得し、[Power:Arg1]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4812_EffectNameList = {Text = "力"},
  Skill_4812_Name = {Text = "怪力"},
  Skill_4812_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4813_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4813_Name = {
    Text = "至高の生贄"
  },
  Skill_4814_Desc = {
    Text = "覚醒体を1体選択し、<Energy:[Energy:Arg1]>狂気を獲得させる。"
  },
  Skill_4814_Name = {
    Text = "誘導性触媒"
  },
  Skill_48151_Desc_1 = {
    Text = "対象1体に<StrengthenKeywords:行動阻害>を付与する。"
  },
  Skill_48151_Name_1 = {
    Text = "行動阻害"
  },
  Skill_4815_Desc = {
    Text = "一時的なクリティカル率+[Arg1]%。この戦闘中「首切りの一撃」と「千変万化」の基礎ダメージが5%増加する。"
  },
  Skill_4815_Name = {
    Text = "クリティカル予測"
  },
  Skill_4816_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の再生力を獲得する。再生力：ターン終了時に点数と同量のライフを回復し、ライフを5点失うごとに1点減少する。"
  },
  Skill_4816_Name = {Text = "深淵"},
  Skill_4817_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得し、前進する。"
  },
  Skill_4818_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg4]回与える。カード[Arg2]枚に「水底の印」を付与する：「水底の印」：使用後、敵が一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4818_Name = {
    Text = "水底の印"
  },
  Skill_4819_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身は<Flaw:破綻>を獲得する：そのターン中必ずクリティカルを受ける。"
  },
  Skill_4819_Name = {
    Text = "鼠たちの突撃"
  },
  Skill_4820_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！！"
  },
  Skill_4821_AwakerSkillBackgroundStory = {
    Text = "彼女の迷宮は、世界のあらゆる場所へと通じている。\n深い森の中にも、図書館の地下にも、海の底にも入口がある。\n迷宮へ迷い込んだ不運な者たちのおかげで、彼女はかろうじて世界の輪郭をなぞることができた。\n旅人は絶えず巡る通路で迷い、彼女は絶えず変わる物語で迷っている。\n彼女はすべてを知っているが、もう迷宮から一歩も出ることはできない。"
  },
  Skill_4821_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージと同量の<IntoxicationIconKeywords:中毒>を与える。捕食が発動するたびに、「蒼白い回旋」を捨て札の山から手札に加える。"
  },
  Skill_4821_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、同量の<IntoxicationIconKeywords:毒>を付与する。<EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg2]。捕食が発動するたび、「蒼白の回旋」を捨て札から手札に戻す。"
  },
  Skill_4821_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_4821_EffectNameList_3 = {
    Text = "ダメージ"
  },
  Skill_4821_Name = {
    Text = "蒼白の旋回"
  },
  Skill_4821_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4821_PropertyNameList_3 = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_4822_AwakerSkillBackgroundStory = {
    Text = "果てしない放浪の中で、ティンクトは故郷の名を忘れた。\n永い年月のうちに、宇宙はその死んだ星の名を忘れた。\n\nそれは無数の融蝕により捨てられた星と同じく、「荒星」と呼ばれる。\n\n彼女の歌声は、その遠い惑星のおそらく最後の残響。"
  },
  Skill_4822_Desc_0 = {
    Text = "ティンクトは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ティンクトの「攻撃」の基礎ダメージが[Arg2]%増加する。すべてのティンクトのカードに、ランダムな効果を1つ付与する。この効果は戦闘終了時に解除される。"
  },
  Skill_4822_Desc_15 = {
    Text = "ティンクトは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ティンクトの「打撃」の基礎ダメージが[Arg2]%増加する。すべてのティンクトのカードに、ランダムな効果を1つ付与する。この効果は戦闘終了時に解除される。ティンクトが毎ターン初めて「スキル」を使用した時、算力消費0の一時的な「打撃」を1枚生成する。この「打撃」のランダム効果が2倍になる。"
  },
  Skill_4822_EffectNameList = {Text = "狂気"},
  Skill_4822_Name = {
    Text = "界外の音"
  },
  Skill_4823_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4824_AwakerSkillBackgroundStory = {
    Text = "リッツは緑炎を得たあの日の情景をまだ覚えている。\n\n手の中で青い火種がで燃え上がり、長く抑え込んできた願いを果たせと彼女を駆り立てた。"
  },
  Skill_4824_Desc_0 = {
    Text = "ランダムな敵に<Damage:[Damage:Arg2]><PunctureDamagewords:刺突ダメージ>を[Arg1]回与え、[Arg3]%ダメージ分の<IntoxicationIconKeywords:毒>を付与。行動力不足時でも強制的に使用可能、効果は<Energy:[Energy:Arg4]>狂気を獲得し除外に変更。"
  },
  Skill_4824_Desc_1 = {
    Text = "ランダムな敵に<Damage:[Damage:Arg2]><PunctureDamagewords:刺突ダメージ>を[Arg1]回与え、[Arg3]%ダメージ分の<IntoxicationIconKeywords:毒>を付与。ターン終了時に手札または<DimensionalSpaceIconKeywords:超次元空間>にある場合、「<DerivativeCardKeywords_20:死滅の緑炎>」にアップグレード。行動力不足時でも強制的に使用可能、効果は<Energy:[Energy:Arg4]>狂気を獲得し除外に変更。"
  },
  Skill_4824_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4824_Name = {
    Text = "腐敗の緑炎"
  },
  Skill_4824_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4825_AwakerSkillBackgroundStory = {
    Text = "灰色で粘つき、自ら蠢くかのような潮流。\nまるで生命をもつかのよう。\n\n一度粘りつかれれば、骨の髄まで侵されるだろう……\nそれを目にした者は皆、そう感じるのだった。"
  },
  Skill_4825_Desc_0 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得し、すべての敵に<VulnerabilityIconKeywords:易傷>を付与する。<TransitionIconKeywords:跳躍>：代わりに、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得し、すべての敵に<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4825_EffectNameList = {
    Text = "力,一時的な力"
  },
  Skill_4825_Name = {
    Text = "異質の潮汐"
  },
  Skill_4825_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4826_Desc = {
    Text = "ステータスカード。"
  },
  Skill_4826_Name = {Text = "痙攣"},
  Skill_4827_AwakerSkillBackgroundStory = {
    Text = "「私たちにとって養分を吸収することは、植物が陽光を追うように自然なことだ」\nファイントは同族が言う「陽光を追う」という本能を理解できない。\n彼女はただ、獲物の体に根を張ったら止まれない、止まれない、止まれないことだけを知っている……"
  },
  Skill_4827_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。すべての敵から[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。"
  },
  Skill_4827_EffectNameList = {
    Text = "力,一時的な力喪失"
  },
  Skill_4827_Name = {
    Text = "養分吸収"
  },
  Skill_4827_PropertyNameList = {
    Text = "攻撃力×GrowValue1,防御力×GrowValue2"
  },
  Skill_4833_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。3枚の<DerivativeCardKeywords_36:「冒涜的な幻想」>を手札に追加。"
  },
  Skill_4833_Name = {
    Text = "異次元の凝視"
  },
  Skill_4835_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4836_AwakerSkillBackgroundStory = {
    Text = "オジールが予備騎士になった時、彼の身長はまだ馬の背に届かなかった。守護のために犠牲になった時も、やっとのことで槍を持ち上げられる程度だった。\n幼い少年が敵の鎧を貫くことができたのは、どれほどの信念と意志があったのだろうか？"
  },
  Skill_4836_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を[Arg3] 回与え、[Arg2]点の<VulnerabilityIconKeywords:易傷>を付与し、2倍の<PowerIconKeywords:力>ボーナスを獲得。"
  },
  Skill_4836_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を[Arg3] 回与え、[Arg2]点の<VulnerabilityIconKeywords:易傷>を付与し、3倍の<PowerIconKeywords:力>ボーナスを獲得。"
  },
  Skill_4836_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、[Arg2]ターンの<VulnerabilityIconKeywords:易傷>を付与。2倍の<PowerIconKeywords:力>ボーナスを享受する。"
  },
  Skill_4836_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与え、[Arg2]点の<VulnerabilityIconKeywords:易傷>を付与し、3倍の<PowerIconKeywords:力>ボーナスを獲得。"
  },
  Skill_4836_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_4836_Name = {
    Text = "刺突の槍"
  },
  Skill_4836_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_4838_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4838_Name = {
    Text = "狂乱攻撃"
  },
  Skill_4839_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4840_AwakerSkillBackgroundStory = {
    Text = "これこそが、まさしく自らに属する真の力——\nそれはルルイエの支配者より受け継がれしもの。\n朽ち果てた存在よ、ルルイエの逆流がもたらす裁きに、身を委ねるがいい。"
  },
  Skill_4840_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、このダメージは[Arg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを受ける。[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。[Arg3]%の<SacrificeKeyWord:献上>層数を除去する。"
  },
  Skill_4840_BattleDesc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>のダメージを[Arg5]回与え、触腕2本につき追加で1回のダメージを与え、[Arg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。[Arg2]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。[Arg3]%の<SacrificeKeyWord:献上>を除去する。"
  },
  Skill_4840_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、このダメージは[Arg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを受ける。[Arg2]ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。[Arg3]%の<SacrificeKeyWord:献上>層数を除去する。"
  },
  Skill_4840_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>のダメージを与え、触腕2本につき追加で1回のダメージを与え、[Arg4]%の<TentacleInjurieIconKeywords:触腕ダメージ>ボーナスを獲得する。[Arg2]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。[Arg3]%の<SacrificeKeyWord:献上>を除去する。"
  },
  Skill_4840_EffectNameList = {
    Text = "ダメージ,触腕ダメージボーナス,「献祭」除去割合"
  },
  Skill_4840_Name = {
    Text = "ルルイエの逆流"
  },
  Skill_4840_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2％,$GrowValue3%"
  },
  Skill_4841_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4842_AwakerSkillBackgroundStory = {
    Text = "次元を渡る魔女は、次元内の屈折の法則を熟知している。\n\n彼女は次元のすべての道筋、すべての接続点を知っている。\n無限の通路が彼女の頭の中にある。\n\nゆえに、他の次元から投影された物質は、彼女にとっては手の内のも同然。"
  },
  Skill_4842_Desc_0 = {
    Text = "ダフォダイルは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ダフォダイルのカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_4:「啓示」>を1枚手札に追加する。毎ターン最大2回まで発動可能。"
  },
  Skill_4842_Desc_15 = {
    Text = "ダフォダイルは<Energy:[Energy:Arg1]> 狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ダフォダイルのカードが<DimensionalSpaceIconKeywords:超次元空間>に入るたび、<DerivativeCardKeywords_4:「啓示」>1枚を手札に追加する。毎ターン最大2回まで発動可能。行動力消費0の「首切りの一撃」を1枚超次元空間に置く。"
  },
  Skill_4842_EffectNameList = {Text = "狂気"},
  Skill_4842_Name = {
    Text = "次元の投影"
  },
  Skill_4843_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_31:「融蝕液」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_4844_AwakerSkillBackgroundStory = {
    Text = "選ばれるその時を待ち、深海へと潜りゆくその瞬間を待ち、一族のもとへ還るその日を待ち続けている。\n永遠の安寧を手にするために——無知な普通の人々は、もう二度とこの身を虐げることなどできない。\nそんな憧れを抱き、小さな少年は幻の夢の中へと沈んでいった。"
  },
  Skill_4844_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。次のターン開始まで、<RetaliateIconKeywords:反撃>と触腕反撃が追加で[Arg2]回発動し、50%のダメージを与える。[Power:Arg3]点の<PowerIconKeywords:力量>を獲得。"
  },
  Skill_4844_EffectNameList = {
    Text = "シールド,力"
  },
  Skill_4844_Name = {
    Text = "逆鱗の守り"
  },
  Skill_4844_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4845_AwakerSkillBackgroundStory = {
    Text = "鮮血こそが神との繋がりの帯紐となる。\n神の国土の再臨は、純粋で至高の生贄を基盤とすることは運命づけられている。"
  },
  Skill_4845_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、同量の<IntoxicationIconKeywords:毒>を付与する。<O07CardKeyWord:儀式>：[Power:Arg3]/[Power:Arg4]/[Power:Arg5]点の<PowerIconKeywords:力>と[TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_4845_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与え、同量の<IntoxicationIconKeywords:毒>を付与する。クリティカルダメージ+[Arg2]%。<O07CardKeyWord:祭儀>：[Power:Arg3]/[Power:Arg4]/[Power:Arg5]店の<PowerIconKeywords:力>と[TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_4845_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、同量の<IntoxicationIconKeywords:毒>を付与する。<O07CardKeyWord:儀式>：[Power:Arg3]/[Power:Arg4]/[Power:Arg5]点の<PowerIconKeywords:力>と[TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_4845_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与え、同量の<IntoxicationIconKeywords:毒>を付与する。ミリアムのクリティカルダメージの15%に等しい一時的なクリティカルダメージを獲得。<O07CardKeyWord:祭儀>：[Power:Arg3]/[Power:Arg4]/[Power:Arg5]点の<PowerIconKeywords:力>と[TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_4845_EffectNameList = {
    Text = "ダメージ,力と触腕ダメージ"
  },
  Skill_4845_Name = {
    Text = "至高の生贄"
  },
  Skill_4845_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4846_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4846_Name = {
    Text = "昏き海の浸蝕"
  },
  Skill_4847_AwakerSkillBackgroundStory = {
    Text = "回避は恥ずかしいことじゃない。むしろ、少しの余裕があるからこそ、彼女は相手の動きを予測できる。"
  },
  Skill_4847_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4847_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ラモンナは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4847_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4847_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_4848_AwakerSkillBackgroundStory = {
    Text = "スパルタ人にその行いの代償を払わせよう。\nあなたが与えるのは憐れみではなく、奪うのは恩恵ではない。\nそれは憧れを抱く少女の人生であり、無数の奴隷たちの熱い涙だ。\n復讐者が失うのは鎖だけ。"
  },
  Skill_4848_Desc_0 = {
    Text = "ヘロットは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ヘロットのカードは<RetainIconKeywords:保持>を獲得。ターン終了後、「鎖を断つ一撃」の攻撃ボーナスと「長き憎しみ」の基礎ダメージが10%増加する。"
  },
  Skill_4848_Desc_15 = {
    Text = "へロットは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：使用後、即座に「鎖を断つ一撃」の攻撃ボーナスと「長き憎しみ」の基礎ダメージが50%増加する。ターン終了後、「鎖を断つ一撃」の攻撃ボーナスと「長き憎しみ」の基礎ダメージが10%増加する。へロットのカードは<RetainIconKeywords:保持>を獲得。"
  },
  Skill_4848_EffectNameList = {Text = "狂気"},
  Skill_4848_Name = {
    Text = "復讐宣言"
  },
  Skill_4849_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<Block:[Block:Arg3]>点のシールドを獲得する。"
  },
  Skill_4850_BattleDesc = {
    Text = "このカードのクリティカル率とクリティカルダメージが50%増加し、刺突ダメージを与える。"
  },
  Skill_4850_Desc = {
    Text = "このカードのクリティカル率とクリティカルダメージが50%増加し、刺突ダメージを与える。"
  },
  Skill_4850_Name = {
    Text = "刺突クリティカル"
  },
  Skill_4851_Desc = {
    Text = "<DerivativeCardKeywords_4:「啓示」>を2枚山札に追加する。"
  },
  Skill_4851_Name = {
    Text = "上位啓示"
  },
  Skill_4852_Desc = {
    Text = "<Posse:[Arg1]>キーエネルギーを獲得。この戦闘中「首切り一撃」と「千変万化」の基礎ダメージが10%増加する。"
  },
  Skill_4852_Name = {
    Text = "上位キーエネルギー"
  },
  Skill_4853_Desc = {
    Text = "<DerivativeCardKeywords_80:「窒息」>を[Arg1]枚相手の手札に追加する。"
  },
  Skill_4853_Name = {
    Text = "溺死の怨念"
  },
  Skill_4854_Desc = {
    Text = "山札からカードを1枚選んで手札に追加し、その行動力消費を1減少させる。"
  },
  Skill_4854_Name = {
    Text = "精密検索"
  },
  Skill_4855_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、自身は[Arg2]点の「蝋質の鎧」を獲得する：1点につき受けるダメージを[Arg3]減少させ、クリティカルを受けるたびに1点減少する。"
  },
  Skill_4855_Name = {
    Text = "蝋人形登場"
  },
  Skill_4856_AwakerSkillBackgroundStory = {
    Text = "庭の青桐がサラサラと揺れ、鳥たちは春の賛歌をさえずる。\n薔薇の芳香が、小さな天窓の格子から彼女の鼻腔に染み込む。\n\n一人きりの花の温室の中では、咲き誇る花々すべてが詩となる。"
  },
  Skill_4856_Desc_0 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復し、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。他の覚醒体は<Energy:[Energy:Arg3]>狂気を獲得し、一時的なクリティカル率とクリティカルダメージ+[Arg4]%。現在の情緒に応じた「華やかな章」の効果が150%増加する。"
  },
  Skill_4856_Desc_3 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復し、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。他の覚醒体は<Energy:[Energy:Arg3]>狂気を獲得し、一時的なクリティカル率とクリティカルダメージ+[Arg4]%。現在の情緒に応じた「華やかな章」の効果が250%増加する。"
  },
  Skill_4856_EffectNameList = {Text = "回復,力"},
  Skill_4856_Name = {
    Text = "華やかな章"
  },
  Skill_4856_OverLimitUtlSkillDesc_0 = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復し、[Power:Arg2]点の<PowerIconKeywords:力>を獲得。他の覚醒体は<Energy:[Energy:Arg3]>狂気を獲得し、一時的なクリティカル率とクリティカルダメージ+[Arg4]%。現在の情緒に応じた「華やかな章」の効果が600%増加する。3点の万能「隠喩」を獲得：次に使用する「詩篇」の「跳躍」効果が発動した後、対応する情緒の「隠喩」として使用し、<DepleteIconKeywords:除外>する。"
  },
  Skill_4856_PropertyNameList = {
    Text = "体力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_4857_Desc = {
    Text = "追加で4倍の<PowerIconKeywords:力>ボーナスを獲得し、[Power:Arg1]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4857_EffectNameList = {Text = "力"},
  Skill_4857_Name = {
    Text = "上位怪力"
  },
  Skill_4857_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_48581_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48581_Name = {
    Text = "歪んだ死体の宴-混沌"
  },
  Skill_48582_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。追加で、ガードされなかったダメージの50%分の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_48582_Name = {
    Text = "歪んだ死体の宴-血肉"
  },
  Skill_48583_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。歪んだ死体の宴のダメージを<Damage:[Damage:Arg3]>増加させる。"
  },
  Skill_48583_Name = {
    Text = "乱れ切り-躁狂"
  },
  Skill_48584_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_48584_Name = {
    Text = "歪んだ死体の宴-超次元"
  },
  Skill_48585_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>を与える。"
  },
  Skill_48585_Name = {
    Text = "歪んだ死体の宴-深海"
  },
  Skill_4858_AwakerSkillBackgroundStory = {
    Text = "少女は名残惜しそうに破産した水族館を後にした。報酬として、彼女は数匹のクラゲを家に持ち帰ることを許された。\nそれは彼女の大好きな小さな生き物で、海を漂う精霊、生き生きとした花のような存在だった。\n心を込めて世話をすれば、水槽いっぱいに広がるはず！——彼女はそんな光景を期待していた。"
  },
  Skill_4858_Desc_0 = {
    Text = "オレッタは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた後、触腕[Arg2]本に1回攻撃させる。"
  },
  Skill_4858_Desc_15 = {
    Text = "オレッタは <Energy:[Energy:Arg1]> 狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得し、「腺体分裂」を2枚手札に追加する。オレッタがダメージを与えた時、触腕[Arg2]本に1回攻撃させる。オレッタの「打撃」は刺突ダメージになり、追加でダメージを3回与える。"
  },
  Skill_4858_EffectNameList = {Text = "狂気"},
  Skill_4858_Name = {
    Text = "自己増殖"
  },
  Skill_48592_Desc = {
    Text = "<DerivativeCardKeywords_33:「助けて」>を1枚手札に加える。影「24」が凶暴化。すべての行動が強化され暴走する。"
  },
  Skill_48592_Name = {
    Text = "狂躁的な人格"
  },
  Skill_48593_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。歪んだ死体の宴のダメージを<Damage:[Damage:Arg3]>増加させる。"
  },
  Skill_48593_Name = {
    Text = "乱れ切り"
  },
  Skill_48595_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48595_Name = {
    Text = "歪んだ死体の宴"
  },
  Skill_4859_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_4859_Name = {
    Text = "弔いの鐘の音"
  },
  Skill_48600_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48600_Name = {
    Text = "異種共生"
  },
  Skill_4860_Desc = {
    Text = "恐怖もまた、一種の野獣の本能だ。"
  },
  Skill_4860_Name = {Text = "驚愕"},
  Skill_4861_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_4861_Name = {
    Text = "抑圧攻撃"
  },
  Skill_4862_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_4863_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_4863_Name = {
    Text = "猟槍の突き"
  },
  Skill_4864_AwakerSkillBackgroundStory = {
    Text = "哲学は正解のない学問だ。\nそれは文明の始まりから流れる川であり、異なる区間で人類は異なる水を注ぎ込んできた。\n彼女は自分の流れを掘り起こしている。\nもしかしたら、いつか自分の存在の本質を理解するかもしれないし、その日が永遠に来ないかもしれない。"
  },
  Skill_4864_Desc_0 = {
    Text = "ラモンナは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ラモンナのカードを使用した後、1点の行動力を獲得する。毎ターン最大3回まで発動可能。"
  },
  Skill_4864_Desc_15 = {
    Text = "ラモンナは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：ラモンナのカードを使用した後、1点の行動力を獲得し、ラモンナの基礎ダメージが10％増加する。毎ターン最大3回まで発動可能。"
  },
  Skill_4864_EffectNameList = {Text = "狂気"},
  Skill_4865_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_3:「痙攣」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_4865_Name = {Text = "痙攣"},
  Skill_4866_Desc = {
    Text = "自身が死亡し、他の味方が最大ライフと同量の回復を行う。"
  },
  Skill_4866_Name = {Text = "犠牲"},
  Skill_4867_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_4868_Desc = {
    Text = "味方全体が[Arg1]<PowerIconKeywords:力>を獲得する。"
  },
  Skill_4868_Name = {
    Text = "全体の力"
  },
  Skill_4869_AwakerSkillBackgroundStory = {
    Text = "「やめて、やめて、やめて、来ないで——！」"
  },
  Skill_4869_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4869_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ウインクルは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_4869_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_4869_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_48812_Desc = {
    Text = "「胚胎」がない時、<DevouredIconKeywords:捕食>され効果が2回発動する。直接使用または自動転化時、「胚胎」の1.5倍の効果とみなす。"
  },
  Skill_48812_Name = {
    Text = "聖純の子"
  },
  Skill_48812_tempBattleDesc_1 = {
    Text = "「胚胎」がない場合、<DevouredIconKeywords:捕食>され、2 回の<DevouredIconKeywords:捕食>効果を発動する。直接使用または自動変換時は「胚胎」の 1.5 倍の効果として扱う。"
  },
  Skill_48812_tempBattleDesc_2 = {
    Text = "「胚胎」がない場合、<DevouredIconKeywords:捕食>され、2 回の<DevouredIconKeywords:捕食>効果を発動する。使用後、覚醒体を1体選択して <Energy:[Energy:Arg1]> ポイントの狂気を獲得する。覚醒体が毎ターン初めて「胚胎」または「聖純の子」を消費した時、[Arg3] 層の<BreedingKeywords1:繁殖祭典>を獲得する。"
  },
  Skill_48812_tempName_1 = {
    Text = "聖純の子"
  },
  Skill_48812_tempName_2 = {
    Text = "繁殖· 聖純の子"
  },
  Skill_48813_Desc = {
    Text = "すべての敵に[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_48813_Name = {
    Text = "腐敗の血"
  },
  Skill_48814_Desc = {
    Text = "すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>を付与。"
  },
  Skill_48814_Name = {
    Text = "恐怖の血"
  },
  Skill_48815_Name = {
    Text = "生殖の血"
  },
  Skill_48857_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48857_Name = {
    Text = "狂気の血に飢えた爪"
  },
  Skill_48858_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える！[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48858_Name = {
    Text = "狂乱の咬みつき"
  },
  Skill_48859_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48860_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48860_Name = {Text = "強化"},
  Skill_48882_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48883_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48884_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48884_Name = {Text = "強化"},
  Skill_48885_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48885_Name = {Text = "強化"},
  Skill_48893_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48894_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48894_Name = {Text = "強化"},
  Skill_48895_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48896_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48896_Name = {Text = "強化"},
  Skill_48897_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_48898_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_48898_Name = {Text = "強化"},
  Skill_49124_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_49124_Name = {
    Text = "鎧砕きの棘"
  },
  Skill_49125_Desc = {
    Text = "使用後、カードを1枚引く。ターン終了時にまだ手札にある場合、500キーエネルギーを失う。"
  },
  Skill_49125_Name = {
    Text = "変異・失語"
  },
  Skill_49126_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_49127_Desc = {
    Text = "使用後、カードを1枚引く。ターン終了時にまだ手札にある場合、ランダムな症状カードを2枚山札のランダムな位置に追加する。"
  },
  Skill_49127_Name = {
    Text = "変異・代謝"
  },
  Skill_49128_Desc = {
    Text = "使用後、カードを1枚引く。ターン終了時に手札にある場合、自身に1ターンの<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_49128_Name = {
    Text = "変異・劣悪"
  },
  Skill_49129_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49129_Name = {Text = "血の棘"},
  Skill_49130_Desc = {
    Text = "使用後、カードを1枚引く。ターン終了時にまだ手札にある場合、すべての覚醒体は10狂気を失う。"
  },
  Skill_49130_Name = {
    Text = "変異・愚鈍"
  },
  Skill_49131_Desc = {
    Text = "使用後、カードを1枚引く。ターン終了時にまだ手札にある場合、「傷口」を4枚山札のランダムな位置に追加する。"
  },
  Skill_49131_Name = {
    Text = "変異・断肢"
  },
  Skill_49133_Desc = {
    Text = "果てなき繁殖の中で生まれた正体不明の産物……使用後、すべての覚醒体は5狂気を獲得し、ターン終了時に手札にある場合、自己複製する。このカードの行動力消費は最低1。"
  },
  Skill_49133_Name = {
    Text = "穢れの子"
  },
  Skill_49215_Desc = {
    Text = "1点の行動力を獲得。[Arg1]回使用可能。"
  },
  Skill_49215_Name = {
    Text = "不思議な料理"
  },
  Skill_49216_Desc = {
    Text = "1点の行動力を獲得。[Arg1]回使用可能。 50%の確率で<MysterybuffKeywords:不思議なバフ効果>が発動する。"
  },
  Skill_49216_Name = {
    Text = "不思議な料理"
  },
  Skill_49233_Desc = {
    Text = "最前列の味方と位置を交換し、[Arg1]点のシールドを獲得する。"
  },
  Skill_49233_Name = {Text = "カバー"},
  Skill_49234_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身を1ターン<VulnerabilityIconKeywords:易伤>にする。"
  },
  Skill_49234_Name = {
    Text = "決死の一撃"
  },
  Skill_49235_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2ターンの<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_49235_Name = {
    Text = "心臓を貫く一撃"
  },
  Skill_49236_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後列の味方と位置を交換し、[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_49236_Name = {
    Text = "奇襲の準備"
  },
  Skill_49279_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札内の1枚のカードに<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49279_Name = {
    Text = "変異の拡散"
  },
  Skill_49280_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<BlindingKeywords:盲目>を付与。"
  },
  Skill_49280_Name = {Text = "塵"},
  Skill_49281_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_49281_Name = {Text = "針千本"},
  Skill_49282_Desc = {
    Text = "[Arg1]点のシールド及び[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_49282_Name = {
    Text = "祈りの言葉"
  },
  Skill_49288_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<HeavyInjuryKeywords:重傷>を付与。"
  },
  Skill_49288_Name = {Text = "衝撃"},
  Skill_49289_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。対象の<PowerIconKeywords:力>が4点あるごとに、<PowerIconKeywords:力>を1点減少させる。減少させる<PowerIconKeywords:力>は、その対象の力を超えることはできない。"
  },
  Skill_49289_Name = {Text = "暗蝕"},
  Skill_49290_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49290_Name = {
    Text = "血棘噴射"
  },
  Skill_49291_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札内の1枚のカードに<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49291_Name = {
    Text = "汚れの誕生"
  },
  Skill_49416_Desc = {
    Text = "手札の非派生指令カードを1枚選択し、<DepleteIconKeywords:除外>が付与された未強化コピーを1枚獲得し、その指令カードの所有者に <Energy:[Arg1]> 点の狂気を獲得させる。"
  },
  Skill_49416_Name = {
    Text = "唯一の種子"
  },
  Skill_49434_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<HeavyInjuryKeywords:重傷>を付与。"
  },
  Skill_49434_Name = {Text = "衝撃"},
  Skill_49435_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49435_Name = {
    Text = "血棘噴射"
  },
  Skill_49436_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。50点の<ConcealmentKeywords:隠匿>状態を獲得する。「養育・ヌビア幼体」を2体前列に召喚する。"
  },
  Skill_49436_Name = {
    Text = "ステルスコール"
  },
  Skill_49437_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札内の2枚のカードに<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49437_Name = {
    Text = "汚れの誕生"
  },
  Skill_49438_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。対象の<PowerIconKeywords:力>が3点あるごとに、<PowerIconKeywords:力>を1点減少させる。減少させる<PowerIconKeywords:力>は、その対象の力を超えることはできない。"
  },
  Skill_49438_Name = {Text = "暗蝕"},
  Skill_49439_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>と<HeavyInjuryKeywords:重傷>を付与する。他のモンスターがすべて死亡している場合、行動予測は直ちに「衝撃」に転換する。"
  },
  Skill_49439_Name = {
    Text = "隠密奇襲"
  },
  Skill_49454_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。75点の<ConcealmentKeywords:隠匿>状態を獲得する。「養育・ヌビア幼体」を2体前列に召喚する。"
  },
  Skill_49454_Name = {
    Text = "ステルスコール"
  },
  Skill_49455_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1枚の<DerivativeCardKeywords_44:「穢れの子」>を手札に追加し、山札の5枚のカードに<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49455_Name = {
    Text = "邪悪な奇形生物"
  },
  Skill_49456_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49456_Name = {
    Text = "血棘噴射"
  },
  Skill_49457_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<HeavyInjuryKeywords:重傷>を付与。"
  },
  Skill_49457_Name = {Text = "衝撃"},
  Skill_49458_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1枚の<DerivativeCardKeywords_44:「穢れの子」>を手札に追加し、山札の2枚のカードに<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49458_Name = {
    Text = "汚れの誕生"
  },
  Skill_49459_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>と<HeavyInjuryKeywords:重傷>を付与する。他のモンスターがすべて死亡している場合、行動予測は直ちに「衝撃」に転換する。"
  },
  Skill_49459_Name = {
    Text = "隠密奇襲"
  },
  Skill_49460_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]ターンの<WeaknessIconKeywords:虚弱>を付与する。対象の<PowerIconKeywords:力>が3点あるごとに、<PowerIconKeywords:力>を1点減少させる。減少させる<PowerIconKeywords:力>は、その対象の力を超えることはできない。"
  },
  Skill_49460_Name = {Text = "暗蝕"},
  Skill_49477_Desc_1 = {
    Text = "相手のすべての手札を捨てさせ、相手に「キーオーダー」を[Arg1]枚与える。"
  },
  Skill_49477_Name_1 = {
    Text = "相手にキーオーダーを渡す"
  },
  Skill_49490_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。"
  },
  Skill_49491_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、ターン終了時にすべて失う。"
  },
  Skill_49491_Name = {
    Text = "血の祈り"
  },
  Skill_49492_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札のカード2枚に<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49492_Name = {
    Text = "異形の針千本"
  },
  Skill_49493_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「祈り」1点につき1回増加する。ガードされなかったダメージを1回与えるたび、<DerivativeCardKeywords_23:「傷口」>を1枚山札のランダムな位置に追加する。最大5枚。"
  },
  Skill_49493_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_49515_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札のカード3枚に<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49515_Name = {
    Text = "異形の針千本"
  },
  Skill_49516_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札のカード3枚に<AberrationKeywords:変異>を発生させる。"
  },
  Skill_49516_Name = {
    Text = "異形の針千本"
  },
  Skill_49517_Desc = {
    Text = "2枚の<DerivativeCardKeywords_44:「穢れの子」>を手札に追加し、直ちに前列に「ヌビア」を1体、後列に「ヌビア幼体」を2体召喚する。"
  },
  Skill_49517_Name = {
    Text = "穢れの種まき"
  },
  Skill_49518_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。"
  },
  Skill_49519_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「祈り」1点につき1回増加する。ガードされなかったダメージを1回与えるたび、<DerivativeCardKeywords_23:「傷口」>を1枚山札のランダムな位置に追加する。最大5枚。"
  },
  Skill_49519_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_49520_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「祈り」1点につき1回増加する。ガードされなかったダメージを1回与えるたび、<DerivativeCardKeywords_23:「傷口」>を1枚山札のランダムな位置に追加する。最大5枚。"
  },
  Skill_49520_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_49521_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、ターン終了時にすべて失う。"
  },
  Skill_49521_Name = {
    Text = "血の祈り"
  },
  Skill_49522_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。"
  },
  Skill_49523_Desc = {
    Text = "[Arg1]点の「祈り」状態を獲得し、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。「祈り」：スキル強化に使用可能。ダメージを受けると1点減少し、ターン終了時にすべて失う。"
  },
  Skill_49523_Name = {
    Text = "血の祈り"
  },
  Skill_49530_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<DerivativeCardKeywords_9:「よろよろ」>を1枚山札の一番上に追加する。"
  },
  Skill_49530_Name = {
    Text = "心臓を貫く一撃"
  },
  Skill_49531_Desc = {
    Text = "最前列の味方と位置を交換し、[Arg1]点のシールドを獲得する。"
  },
  Skill_49531_Name = {
    Text = "無畏のカバー"
  },
  Skill_49532_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後列の味方と位置を交換する。"
  },
  Skill_49532_Name = {
    Text = "猛襲の準備"
  },
  Skill_49533_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身を1ターン<VulnerabilityIconKeywords:易伤>にする。"
  },
  Skill_49533_Name = {
    Text = "決死の一撃"
  },
  Skill_49543_Desc = {
    Text = "すべての味方が[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_49544_Desc = {
    Text = "「アランの衛兵隊長」に[Arg1]点のシールドを付与する。"
  },
  Skill_49544_Name = {Text = "護衛"},
  Skill_49551_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、<FragileIconKeywords:脆弱>を1ターン付与する。"
  },
  Skill_49551_Name = {
    Text = "狂乱の捕食"
  },
  Skill_49552_Desc = {
    Text = "プレイヤーに5層の<EmptinessKeywords: 虚無>状態を付与する。<DerivativeCardKeywords_25:「石ころ」>を3枚山札のランダムな位置に追加する。"
  },
  Skill_49552_Name = {
    Text = "砂塵飛舞"
  },
  Skill_49553_Desc = {
    Text = "[Arg3]点のシールドを獲得し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_49553_Name = {
    Text = "翼の鼓動"
  },
  Skill_49554_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_49554_Name = {Text = "啄む"},
  Skill_49555_Desc = {
    Text = "毎ターン[Arg1]点の<PowerIconKeywords:力>を獲得する。すべての覚醒体のすべての狂気を除去する。"
  },
  Skill_49555_Name = {
    Text = "砂海のささやき"
  },
  Skill_49556_Desc = {
    Text = "[Arg3]点のシールドを獲得し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<BlindingKeywords:盲目>を1点付与する。"
  },
  Skill_49556_Name = {
    Text = "狂気の鼓翼"
  },
  Skill_49576_Desc = {
    Text = "3ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。[Arg1]点のシールドと[Arg2]点の<AlertIconKeywords:警戒>を獲得。<DerivativeCardKeywords_25:「石ころ」>を3枚捨て札に追加する。"
  },
  Skill_49576_Name = {
    Text = "無限の正義"
  },
  Skill_49577_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_49577_Name = {Text = "刃"},
  Skill_49578_Desc = {
    Text = "毎ターン[Arg1]点の力を獲得。すぐに[Arg2]点の<AlertIconKeywords:警戒>を獲得。"
  },
  Skill_49578_Name = {
    Text = "戦地の知恵"
  },
  Skill_49579_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_49579_Name = {
    Text = "攻撃増幅"
  },
  Skill_49580_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ライフを失った場合、行動予測は直ちに低ダメージの「刃」に変化する。"
  },
  Skill_49580_Name = {
    Text = "心眼の刃"
  },
  Skill_49581_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<AlertIconKeywords:警戒>を獲得。"
  },
  Skill_49581_Name = {
    Text = "戦闘体勢"
  },
  Skill_49624_Desc = {
    Text = "1枚の<DerivativeCardKeywords_44:「穢れの子」>を手札に追加し、[Arg1]点の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_49624_Name = {Text = "呪毒"},
  Skill_49630_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_49630_Name = {Text = "胎動"},
  Skill_49631_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_49631_Name = {Text = "胎動"},
  Skill_49632_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49632_Name = {
    Text = "血棘噴射"
  },
  Skill_49633_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_49633_Name = {
    Text = "血棘噴射"
  },
  Skill_49743_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_49743_Name = {
    Text = "爆裂する深紅の茨"
  },
  Skill_49834_Desc_1 = {
    Text = "味方のランダムな「スキル」を[Arg1]枚見て、1枚を選択し、[Arg2]枚の行動力消費が-[Arg3]されたコピーを山札のランダムな位置に追加する。"
  },
  Skill_49834_Name_1 = {
    Text = "唯一の種子"
  },
  Skill_49834_UnknownName = {
    Text = "唯一の種子"
  },
  Skill_49882_Desc = {
    Text = "解放済みのランダムな「キーオーダー」3つの中から1つを選んで直ちに発動し、効果を2回発動させる。"
  },
  Skill_49882_Name = {
    Text = "シルバーキーの暁光"
  },
  Skill_50300_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：致死ダメージを1回無効化しこの「命輪」を破壊する。[Arg1]層の<PVPProtectiveKeywords:障壁>を獲得する。発動時に唯一の生存味方である場合、次のターン開始時にランダムな「鍵令」を[Arg2]枚獲得する。"
  },
  Skill_50300_Name_1 = {
    Text = "極夜と暁"
  },
  Skill_50327_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：ランダムな「キーオーダー」を[Arg1]枚獲得、を付与する。"
  },
  Skill_50327_Name_1 = {
    Text = "遅延ランダムキーオーダー"
  },
  Skill_50329_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_50329_Name = {Text = "重撃"},
  Skill_50330_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_50330_Name = {Text = "重撃"},
  Skill_50335_Desc = {
    Text = "[Arg3]点のシールドを獲得し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_50335_Name = {
    Text = "翼の鼓動"
  },
  Skill_50340_Desc = {
    Text = "果てなき繁殖の中で生まれた正体不明の産物……使用後、すべての覚醒体は5狂気を獲得し、ターン終了時に手札にある場合、自己複製する。このカードの行動力消費は最低1。"
  },
  Skill_50340_Name = {
    Text = "穢れの子"
  },
  Skill_50381_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_50381_Name = {Text = "茨"},
  Skill_50382_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_50382_Name = {Text = "棘"},
  Skill_50383_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_50383_Name = {
    Text = "深紅の茨"
  },
  Skill_50384_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_50384_Name = {
    Text = "血まみれの棘"
  },
  Skill_50388_Desc = {
    Text = "サイコロを1個振り、出目に応じて効果を獲得。1：すべての敵に1ターンの<WeaknessIconKeywords:虚弱>を付与。2：すべての敵に1ターンの<VulnerabilityIconKeywords:易傷>を付与。3：すべての敵に[Arg1]点の出血を付与する。4：2点の行動力を獲得する。5：カードを2枚引く。6+：これぞライカーの強運！上記のすべての効果を獲得！"
  },
  Skill_50388_Name = {
    Text = "ライカーのラッキーダイス"
  },
  Skill_50392_Desc = {
    Text = "選択：<DerivativeCardKeywords_50:「一方向」>または<DerivativeCardKeywords_51:「集結」>"
  },
  Skill_50392_Name = {
    Text = "貪り攻撃"
  },
  Skill_50393_Desc = {
    Text = "覚醒体1体の、行動力消費0の「攻撃」を3枚手札に追加し、それに10狂気を獲得させる。"
  },
  Skill_50393_Name = {Text = "一方向"},
  Skill_50394_Desc = {
    Text = "選択：<DerivativeCardKeywords_47:「吸着」>または<DerivativeCardKeywords_48:「固化」>"
  },
  Skill_50394_Name = {
    Text = "プリオン"
  },
  Skill_50395_Desc = {
    Text = "最大ライフの30%のシールドを獲得する。"
  },
  Skill_50395_Name = {Text = "繭化"},
  Skill_50396_Desc = {
    Text = "選択：<DerivativeCardKeywords_53:「繭化」>または<DerivativeCardKeywords_54:「蚕食」>"
  },
  Skill_50396_Name = {
    Text = "復活の繭"
  },
  Skill_50397_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]点の<IntoxicationIconKeywords:毒>を受ける。"
  },
  Skill_50398_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_50398_Name = {Text = "吸着"},
  Skill_50399_Desc = {
    Text = "すべての覚醒体の、行動力消費0の「攻撃」をそれぞれ1枚手札に追加し、彼らに5狂気を獲得させる"
  },
  Skill_50399_Name = {Text = "集結"},
  Skill_50492_Desc = {
    Text = "最大ライフの30％を回復し、自身を1ターンの易傷にする。"
  },
  Skill_50492_Name = {Text = "集結"},
  Skill_50699_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ランダムな「変異」カードを1枚手札に追加する。"
  },
  Skill_50699_Name = {Text = "懲罰"},
  Skill_50700_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得する。プレイヤーがカードを1枚使用するたび、この行動の追加効果が変化する。追加効果は「反撃」「浄化」「移植」の順番に変化する。"
  },
  Skill_50700_Name = {
    Text = "血統の継承"
  },
  Skill_50701_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、自身のデバフ状態を解除する。カード使用後、追加効果は「移植」に変化する。"
  },
  Skill_50701_Name = {
    Text = "血統の継承\n浄化"
  },
  Skill_50702_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、ランダムな「変異」カードを2枚手札に追加する。カード使用後、追加効果は反撃に切り替わる。"
  },
  Skill_50702_Name = {
    Text = "血統の継承\n移植"
  },
  Skill_50703_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーがカードを1枚使用するたび、この行動の追加効果が変化する。追加効果は「重撃」「回復」「弱体化」の順番に変化する。"
  },
  Skill_50703_Name = {
    Text = "「混乱の噛みつき」"
  },
  Skill_50704_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_50704_Name = {
    Text = "鋭い牙の噛みつき"
  },
  Skill_50706_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの<BlindingKeywords:盲目>を付与する。"
  },
  Skill_50706_Name = {
    Text = "哀しみを裂く"
  },
  Skill_50707_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、追加で[Arg3]点の一時的な反撃を獲得する。カード使用後、追加効果は「浄化」に変化する。"
  },
  Skill_50707_Name = {
    Text = "血統の継承\n反撃"
  },
  Skill_50739_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。カード使用後、追加効果は「重撃」に切り替わる。"
  },
  Skill_50739_Name = {
    Text = "「混乱の噛みつき」弱体化"
  },
  Skill_50740_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、カード使用後、追加効果は「回復」に変化する。"
  },
  Skill_50740_Name = {
    Text = "「混乱の噛みつき」重撃"
  },
  Skill_50741_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ライフを[Arg3]回復する。カード使用後、追加効果は「弱体化」に変化する。"
  },
  Skill_50741_Name = {
    Text = "「混乱の噛みつき」回復"
  },
  Skill_50845_Desc = {
    Text = "非派生指令カードを1枚選択し、行動力0の未強化コピーを獲得し、<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を付与する。"
  },
  Skill_50845_Name = {
    Text = "神聖な子孫"
  },
  Skill_50867_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_50867_Name = {
    Text = "爆裂する血まみれの棘"
  },
  Skill_51690_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]シールドを獲得し、「生出」1点につきシールドが[Arg4]増加。"
  },
  Skill_51690_Name = {Text = "試み"},
  Skill_51691_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。すべての覚醒体を封印し、2体の「リモリアの希望」を前に召喚。"
  },
  Skill_51691_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_51692_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚の<DerivativeCardKeywords_3:「痙攣」>を相手の山札のランダムな位置に追加する。"
  },
  Skill_51692_Name = {
    Text = "至高の生贄"
  },
  Skill_51693_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。最も狂気の多い覚醒体を1ターン封印。"
  },
  Skill_51693_Name = {Text = "神の刃"},
  Skill_51694_Desc = {
    Text = "「霊覚の子」を1体後ろに召喚する。「生出」1点につきその力は増す！"
  },
  Skill_51694_Name = {
    Text = "選ばれし者"
  },
  Skill_51699_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。全覚醒体を封印し、2体の「リモリアの希望」を前に召喚。"
  },
  Skill_51699_Name = {
    Text = "リモリアの栄光！"
  },
  Skill_51700_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]枚のランダムな症状を相手の山札のランダムな位置に追加する。"
  },
  Skill_51700_Name = {
    Text = "至高の生贄"
  },
  Skill_51701_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1ターンの<WeaknessIconKeywords:虚弱>を付与する。[Arg3]点のシールドを獲得し、「育む」1点につきシールドが[Arg4]点増加する。"
  },
  Skill_51701_Name = {Text = "試み"},
  Skill_51702_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。最も狂気が多い覚醒体を1ターン封印し、山札内のランダムな[Arg3]枚の指令カードに1点の<SlowIconKeywords:鈍化>を付与。"
  },
  Skill_51702_Name = {Text = "神の刃"},
  Skill_51703_Desc = {
    Text = "失ったライフの[Arg5]%を回復し、「霊覚の子」を1体後ろに召喚する。「育む」1点につき回復量と召喚される者の力が増す！"
  },
  Skill_51703_Name = {
    Text = "選ばれし者"
  },
  Skill_51721_Desc_1 = {
    Text = "[Arg1]ダメージを与え、<ComaKeywords:石化>させる。"
  },
  Skill_51733_AwakerSkillBackgroundStory = {
    Text = "彼女は地上で神の名において行動する。\n彼女は神が受けるにふさわしい名声を得る。\n彼女は滅びの時に、誰も耐えられない痛みを受ける。\nそれこそが代行者である。"
  },
  Skill_51733_Desc = {
    Text = "ミリアムは<Energy:[Energy:Arg3]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：触腕上限と触腕の数が+1、すべての敵に1層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。<O07CardKeyWord5:「信仰の終焉」>を1枚手札に追加する。選択：<CardKeyWord:我を貫く>または<CardKeyWord:啓示に捧ぐ>。"
  },
  Skill_51733_EffectNameList = {
    Text = "シールド,触腕ダメージ,狂気"
  },
  Skill_51733_Name = {
    Text = "信仰の岐路"
  },
  Skill_51733_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_51734_Desc = {
    Text = "ミリアムは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：すべての敵に1層の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。触腕上限と触腕数+1。ターン終了時にランダムで1枚「神国幻影」を手札に追加。"
  },
  Skill_51734_Name = {
    Text = "信仰の終焉"
  },
  Skill_51735_Desc = {
    Text = "毎ターン開始時[Power:Arg1]点の<PowerIconKeywords:力>と[TentaclePower:Arg1]点の<TentacleInjurieIconKeywords:触腕ダメージ>を獲得。"
  },
  Skill_51735_EffectNameList = {
    Text = "シールド,触腕ダメージ"
  },
  Skill_51735_Name = {
    Text = "啓示への献身"
  },
  Skill_51735_PropertyNameList = {
    Text = "防御力×GrowValue1,攻撃力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_51736_Desc = {
    Text = "各ターンの開始時に <Block:[Block:Arg1]> ptのシールドを獲得。"
  },
  Skill_51736_EffectNameList = {
    Text = "シールド"
  },
  Skill_51736_Name = {
    Text = "自己の堅持"
  },
  Skill_51736_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_51782_Desc = {
    Text = "覚醒体を1体選択し、[Arg1]狂気を獲得させる。カードを2枚引く。"
  },
  Skill_51782_Name = {
    Text = "神国の呼び声"
  },
  Skill_51783_Desc = {
    Text = "覚醒体を1体選択し、[Arg1]点の狂気を獲得させる。すべての敵に1ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_51783_Name = {
    Text = "神国への信仰"
  },
  Skill_51784_Desc = {
    Text = "覚醒体を1体選択し、[Arg1]狂気を獲得させる。2点の行動力を獲得。"
  },
  Skill_51784_Name = {
    Text = "神国の降臨"
  },
  Skill_51814_Desc = {
    Text = "[Arg4]点の<PowerIconKeywords:力>を獲得し、「睡夢の子」1体、「水の子」1体、「霊覚の子」1体を召喚する。「育む」の追加効果：5層に達すると、即座に「水の子」を1体召喚する。"
  },
  Skill_51814_Name = {Text = "覚醒"},
  Skill_51902_BattleDesc = {
    Text = "10%の失われたライフ([Arg1])を回復。祭儀効果で「妄執」に変換し、指令カード効果を強化可能。"
  },
  Skill_51902_Desc = {
    Text = "10%の失われたライフを回復。<O07CardKeyWord:祭儀>効果で<O07CardKeyWord3:「妄執」>に変換し、指令カード効果を強化可能。"
  },
  Skill_51902_Name = {Text = "聖礼"},
  Skill_52055_Desc = {
    Text = "ミリアムは[Arg1]狂気を獲得。ターン終了時に手札にある場合、次のターンのドロー枚数-1を代償に「聖礼」に変換。"
  },
  Skill_52055_Name = {Text = "妄執"},
  Skill_52076_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_52077_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_52077_Name = {Text = "強化"},
  Skill_52078_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_52079_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_52079_Name = {Text = "強化"},
  Skill_52094_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_52094_Name = {Text = "強化"},
  Skill_52095_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_52096_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_52096_Name = {Text = "強化"},
  Skill_52097_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_52317_Desc = {
    Text = "すべての敵に1ターンの<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_52317_Name = {
    Text = "誠実な友"
  },
  Skill_52318_Desc = {
    Text = "カードを2枚引く。"
  },
  Skill_52318_Name = {
    Text = "安定した生活"
  },
  Skill_52319_Desc = {
    Text = "2点の行動力を獲得。"
  },
  Skill_52319_Name = {
    Text = "温かい家庭"
  },
  Skill_52698_Desc = {
    Text = "カードを2枚引き、2点の演算力を獲得し、すべての覚醒体が5点の狂気を失う。現在「静海」姿態の場合、すべての敵に [Arg1] 層の<IntoxicationIconKeywords:毒>を付与し、ボス戦では3倍の効果を発揮する。"
  },
  Skill_52698_Name = {Text = "海の祭"},
  Skill_54041_Desc = {
    Text = "2倍のダメージを与え、さらに環行ラモンナのキーチャージと同等の 600% のキーエネルギーを獲得するが、発射後<DepleteIconKeywords:消費>される。"
  },
  Skill_54041_Name = {
    Text = "未来の讃歌"
  },
  Skill_54042_Desc = {
    Text = "3点の行動力を獲得。"
  },
  Skill_54042_Name = {
    Text = "輪廻の庭"
  },
  Skill_54377_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：敵の覚醒体が死亡した後、[Arg1]<StrongEffectKeywords:強効>を獲得し、その算力消費が最も高く<PVPVoidKeywords:虚無>が付与された「スキル」を手札に加える。"
  },
  Skill_54377_Name_1 = {
    Text = "百万の寵愛の眼"
  },
  Skill_54439_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。ランダムな覚醒体 1 名のすべてのカードに<ErosionColorInkKeywords:認知錯乱>を付与する。"
  },
  Skill_54439_Name = {
    Text = "融蝕墨染め"
  },
  Skill_54440_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_54441_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターンの<BlindingKeywords:盲目>を付与し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54442_Desc = {
    Text = "「致オルラ」の失ったライフを3%回復する。"
  },
  Skill_54442_Name = {Text = "灌水"},
  Skill_54443_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。ランダムな覚醒体 1 名のすべてのカードに<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54443_Name = {Text = "墨染め"},
  Skill_54444_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<WeaknessIconKeywords:衰弱>を付与し、ドローパイルのランダムな1枚のカードに<ColorInkKeywords:認知失調>を付加する。"
  },
  Skill_54445_Desc = {
    Text = "棘茨の従者を4体召喚する。すべてのカードに<ErosionColorInkKeywords:認知錯乱>を付与する。[Arg1]層の衰弱、[Arg2]層の毒、[Arg3]層の<BleedingIconKeywords:出血>を付与し、<BlindingKeywords:盲目>、<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重傷>を99ターン付与する。"
  },
  Skill_54445_Name = {
    Text = "詩の幻想楽園"
  },
  Skill_54446_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、プレイヤーの<PowerIconKeywords:力>と<RetaliateIconKeywords:反撃>を50%除去する。"
  },
  Skill_54446_Name = {
    Text = "縁の分断"
  },
  Skill_54447_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。山札のランダムな 3 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54448_Desc = {
    Text = "[Arg1]点のシールド、[Arg2]点の<RetaliateIconKeywords:反撃>、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_54448_Name = {
    Text = "貪欲断絶"
  },
  Skill_54449_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。山札のランダムな 3 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54450_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_54450_Name = {Text = "裁断"},
  Skill_54451_Desc = {
    Text = "[Arg1]点のシールド、及び[Arg2]点の一時的な<RetaliateIconKeywords:反撃>と[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_54451_Name = {Text = "貪欲"},
  Skill_54452_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>を付与し、ドローパイルのランダムな2枚のカードに<ColorInkKeywords:認知失調>を付加する。"
  },
  Skill_54453_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。[Arg3] 点の<PowerIconKeywords:力>を獲得し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54454_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。[Arg3] 点の<PowerIconKeywords:力>を獲得し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54455_Desc = {
    Text = "「致オルラ」の<PowerIconKeywords:力>を[Arg1]点増加させる。"
  },
  Skill_54455_Name = {Text = "供養"},
  Skill_54456_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「棘茨の従者」を召喚。「貪欲の歌」のダメージ回数を1増加。"
  },
  Skill_54456_Name = {
    Text = "貪欲の歌"
  },
  Skill_54457_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「棘茨の従者」を召喚。「貪欲の歌」のダメージ回数を1増加。"
  },
  Skill_54457_Name = {
    Text = "貪欲の歌"
  },
  Skill_54458_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与え、[Arg3] 点のシールドを獲得し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54459_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与え、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54460_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与え、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_54461_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>を付与し、ドローパイルのランダムな2枚のカードに<ColorInkKeywords:認知失調>を付加する。"
  },
  Skill_54566_Desc = {
    Text = "解放済みの「キーオーダー」から任意で1つを選んで発動する。"
  },
  Skill_54566_Name = {
    Text = "超越リンク"
  },
  Skill_55481_Desc = {
    Text = "超次元空間の一番左のカードを取り除き、即座に「啓示」を1枚手札に加える。「湮滅」は、毎ターン1回のみ使用可能。"
  },
  Skill_55481_Name = {Text = "消滅"},
  Skill_55481_tempBattleDesc_1 = {
    Text = "超次元空間の一番左のカードを取り除き、即座に「啓示」を1枚手札に加える。「湮滅」は、毎ターン1回のみ使用可能。"
  },
  Skill_55481_tempBattleDesc_2 = {
    Text = "超次元空間の最も左のカードを除去し、「霊感」1枚を即座に手札に加える。本ターン、オルラの次の指令カードが躍遷効果を発動する。「湮滅」は1ターンに1回のみ使用可能。"
  },
  Skill_55481_tempBattleDesc_3 = {
    Text = "超次元空間の一番左のカードを取り出す。クールダウン3ターン。"
  },
  Skill_55481_tempBattleDesc_4 = {
    Text = "超次元空間の指令カードを1枚選択して取り出し、「使用後に追加で1回効果を発動」を付与する。次に使用する指令カードは<SingularityKeywords3:次元転移>を発動する。クールダウン3ターン。"
  },
  Skill_55481_tempBattleDesc_5 = {
    Text = "超次元空間の一番左のカードを取り出す。このターン、オルラの次の指令カードは「跳躍」効果を発動する。クールダウン3ターン。"
  },
  Skill_55481_tempBattleDesc_6 = {
    Text = "超次元空間の指令カードを1枚選択して取り出し、「使用後に追加で1回効果を発動」を付与する。次に使用する指令カードは<SingularityKeywords3:次元転移>を発動する。このターン、オルラの次の指令カードは「跳躍」効果を発動する。クールダウン3ターン。"
  },
  Skill_55481_tempBattleDesc_7 = {
    Text = "超次元空間のカードを1枚選択して取り出し、「使用後に1回追加で発動」を付与する。次に使用する指令カードは<SingularityKeywords3:次元シャトル>を発動する。即座にすべての敵に「運命裁断」の50%に等しい<FixedDamage:純粋ダメージ>を与え、アラクネが次に発動する「狂気解放」のダメージ強化とシールド上昇が50%増加する。クールダウン3ターン。"
  },
  Skill_55481_tempBattleDesc_8 = {
    Text = "超次元空間のカードを1枚選択して取り出し、「使用後に1回追加で発動」を付与する。次に使用する指令カードは<SingularityKeywords3:次元シャトル>を発動する。即座にすべての敵に「運命裁断」の50%に等しい<FixedDamage:純粋ダメージ>を与え、アラクネが次に発動する「狂気解放」のダメージ強化とシールド上昇が50%増加する。このターン、オルラの次の指令カードは「跳躍」効果を発動する。クールダウン3ターン。"
  },
  Skill_55802_Name_1 = {
    Text = "雨の賛歌"
  },
  Skill_55803_Name_1 = {
    Text = "花の賛歌"
  },
  Skill_55804_Name_1 = {
    Text = "風の賛歌"
  },
  Skill_56035_Desc = {
    Text = "[Arg1]点のシールドを獲得する。"
  },
  Skill_56036_Desc = {
    Text = "失ったライフの[Arg1]%([Arg2])を回復する。"
  },
  Skill_56036_Name = {Text = "泉"},
  Skill_56037_Desc = {
    Text = "すべての敵に[Arg1]ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_56038_Desc = {
    Text = "すべての敵に[Arg1]ターンの<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_56039_Desc = {
    Text = "ランダムなデバフ状態を1つ解除する。"
  },
  Skill_56039_Name = {Text = "月"},
  Skill_56040_Desc = {
    Text = "[Arg1]点のシールドを獲得する。このターン中に「狂気解放」を3回発動した場合、このカードは追加で1回効果が発動する。"
  },
  Skill_56041_Desc = {
    Text = "失ったライフの[Arg1]%([Arg2])を回復する。現在のライフが25%([Arg3])未満の場合、このカードは追加で1回効果が発動する。"
  },
  Skill_56041_Name = {Text = "泉"},
  Skill_56042_Desc = {
    Text = "すべての敵に[Arg1]ターンの<WeaknessIconKeywords:虚弱>を付与し、<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>が付与されたランダムな「イメージ」を1枚捨て札に追加。"
  },
  Skill_56043_Desc = {
    Text = "すべての敵に[Arg1]ターンの<VulnerabilityIconKeywords:易傷>を付与する。敵が死亡するたび、このカードを山札から手札に追加。"
  },
  Skill_56044_Desc = {
    Text = "ランダムなデバフ状態を1つ解除する。このカードは追加で3回効果が発動し、除外される。"
  },
  Skill_56044_Name = {Text = "月"},
  Skill_56045_Desc = {
    Text = "[Arg1]点の行動力を獲得する。"
  },
  Skill_56045_Name = {Text = "太陽"},
  Skill_56046_Desc = {
    Text = "カードを[Arg1]枚引く。"
  },
  Skill_56046_Name = {Text = "星"},
  Skill_56047_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_56047_Name = {Text = "春"},
  Skill_56048_Desc = {
    Text = "界域知識+[Arg1]点、一時的な界域知識+[Arg2]点。"
  },
  Skill_56048_Name = {Text = "詩句"},
  Skill_56049_Desc = {
    Text = "山札と捨て札から指令カードを1枚選択して手札に追加し、その行動力消費-2。"
  },
  Skill_56049_Name = {Text = "蝶"},
  Skill_56050_Desc = {
    Text = "[Arg1]点の行動力を獲得する。"
  },
  Skill_56050_Name = {Text = "太陽"},
  Skill_56051_Desc = {
    Text = "カードを[Arg1]枚引く。"
  },
  Skill_56051_Name = {Text = "星"},
  Skill_56052_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_56052_Name = {Text = "春"},
  Skill_56053_Desc = {
    Text = "一時的な界域知識+[Arg1]点。"
  },
  Skill_56053_Name = {Text = "詩句"},
  Skill_56054_Desc = {
    Text = "山札から指令カードを1枚選択して手札に追加し、その行動力消費-1。"
  },
  Skill_56054_Name = {Text = "蝶"},
  Skill_56055_Desc = {
    Text = "[Arg1]キーエネルギーを獲得する。"
  },
  Skill_56055_Name = {Text = "雲"},
  Skill_56056_Desc = {
    Text = "自身の最大ライフの 100% に等しい<FixedDamage:純粋ダメージ>（[Arg1]）を与え、このダメージは<PowerIconKeywords:力量>の 5 倍のボーナスを受ける。"
  },
  Skill_56056_Name = {Text = "風"},
  Skill_56057_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_56057_Name = {Text = "森"},
  Skill_56058_Desc = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得する。"
  },
  Skill_56059_Desc = {
    Text = "自身の最大ライフの 150% に等しい<FixedDamage:純粋ダメージ>（[Arg1]）を与え、このダメージは<PowerIconKeywords:力量>の 10 倍のボーナスを受ける。"
  },
  Skill_56059_Name = {Text = "風"},
  Skill_56060_Desc = {
    Text = "次のキーオーダーは効果が2回発動する。"
  },
  Skill_56060_Name = {Text = "雲"},
  Skill_56061_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。使用後、このターン中にダメージを1回与えるたび、一時的なクリティカル率+[Arg2]%。"
  },
  Skill_56061_Name = {Text = "森"},
  Skill_56062_Desc = {
    Text = "[Arg1]点の一時的な<AlertIconKeywords:警戒>を獲得する。使用後、このターン中にすべての覚醒体が与えるシールドと回復が[Arg2]%増加する。"
  },
  Skill_56144_Desc = {Text = "無用"},
  Skill_56144_Name = {Text = "献詩"},
  Skill_56155_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージをX+10回与える。<DerivativeCardKeywords_12:「鼠たちの突撃」>を1枚山札の一番上に追加する。"
  },
  Skill_56155_EffectNameList = {
    Text = "「鼠たちの突撃」ダメージ"
  },
  Skill_56155_Name = {
    Text = "超大集結！"
  },
  Skill_56155_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_56199_Desc = {
    Text = "<Heal:[Arg1]> 点のライフを回復する。"
  },
  Skill_56199_Name = {
    Text = "雨の賛歌"
  },
  Skill_56200_Desc = {
    Text = "一時的なクリティカルレート +[Arg1]%。"
  },
  Skill_56200_Name = {
    Text = "月の賛歌"
  },
  Skill_56201_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_56201_Name = {
    Text = "風の賛歌"
  },
  Skill_56202_Desc = {
    Text = "4種類の<D06CardKeeperSkill:詩片>から1つを選択し、選択肢から除外する。すべての詩片が選択された後、リセットされる。"
  },
  Skill_56202_Name = {
    Text = "春の詩集"
  },
  Skill_56203_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する。"
  },
  Skill_56203_Name = {
    Text = "花の賛歌"
  },
  Skill_56370_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、直ちに2点の<ResentChainsKeywords:怨恨の鎖>状態を獲得する。"
  },
  Skill_56370_Name = {
    Text = "次元の鍵"
  },
  Skill_56371_Desc = {
    Text = "味方全体が[Arg1]点の<PowerIconKeywords:力>と<Block:[Block:Arg2]>点のシールドを獲得し、<DerivativeCardKeywords_45:「次元閉鎖」>を1枚山札のランダムな位置に追加する。"
  },
  Skill_56371_Name = {
    Text = "次元の防壁"
  },
  Skill_57140_Desc = {
    Text = "「氷雪の霊」を2体召喚し、すべての味方が[Arg1]点の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_57140_Name = {
    Text = "氷雪の霊"
  },
  Skill_57141_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札の一番上1枚の指令カードを凍結。"
  },
  Skill_57141_Name = {Text = "霜刃"},
  Skill_57338_AwakerSkillBackgroundStory = {
    Text = "彼が巨大な剣を掲げれば、必ず血と死がもたらされる。"
  },
  Skill_57338_Desc_0 = {
    Text = "基礎ダメージ400%アップ、行動力消費0の<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に加え、[Arg1]%の触腕ダメージに等しい一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_57338_Desc_3 = {
    Text = "基礎ダメージが400%増加し、行動力消費が0の<DerivativeCardKeywords_17:「巨刃の威」>を3枚手札に追加する。触腕ダメージの[Arg1]%の一時的な<PowerIconKeywords:力>を獲得する。ゴリアテは[Arg2]%の一時的なクリティカル率を獲得。"
  },
  Skill_57338_EffectNameList = {
    Text = "触腕ダメージ割合"
  },
  Skill_57338_Name = {Text = "簒奪"},
  Skill_57339_AwakerSkillBackgroundStory = {
    Text = "彼が巨大な剣を掲げれば、必ず血と死がもたらされる。"
  },
  Skill_57339_Desc_0 = {
    Text = "「斬首一閃」を2枚手札に加え、それらに<DepleteIconKeywords:消耗>、<PrepareKeypvewords:準備1>、<RetainIconKeywords:保留>を付与する。「巨刃の威」と「斬首一閃」の基礎ダメージを本戦闘中25%アップさせる。"
  },
  Skill_57339_Desc_3 = {
    Text = "「斬首一閃」を2枚手札に追加し、それらに<DepleteIconKeywords:除外>、<PrepareKeypvewords:準備1>、<RetainIconKeywords:保持>を付与する。この戦闘中「巨刃の威」と「斬首一閃」の基礎ダメージが25%増加する。ゴリアテは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_57339_Name = {Text = "潜伏"},
  Skill_57342_AwakerSkillBackgroundStory = {
    Text = "鋼鉄の塊から鍛え上げたその大剣は、大気を裂きその風圧すら岩を砕く。\n\n忠実なる相棒よ、頼れる巨刃よ――\n我らは闇の中で再誕し、無限の力を得た。\n\n今宵、我らは仇敵の血を飲み干す。\n今宵、我らは殺戮に酔いしれる。"
  },
  Skill_57342_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得する。このカードは「攻撃」として扱う。"
  },
  Skill_57342_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_57342_Name = {
    Text = "巨刃の威"
  },
  Skill_57342_PropertyNameList = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_57550_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「タヴィに答える」を手札に追加。"
  },
  Skill_57550_Name = {
    Text = "真理の問答"
  },
  Skill_57551_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの10%相当の<IntoxicationIconKeywords:毒>とダメージと同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_57551_Name = {
    Text = "深淵の視線"
  },
  Skill_57552_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_57552_Name = {
    Text = "粉砕の六翼"
  },
  Skill_57553_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身の負の状態をコピーし、対象に付与する。"
  },
  Skill_57553_Name = {
    Text = "同化の四翼"
  },
  Skill_57554_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<FragileIconKeywords:脆弱>を2ターン付与する。カード5枚に1ターンの「侵食」を付与する。"
  },
  Skill_57555_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<PowerIconKeywords:力>と<RetaliateIconKeywords:反撃>の15％を除去し、等量の一時的な<PowerIconKeywords:力>と一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_57555_Name = {
    Text = "略奪の双翼"
  },
  Skill_57556_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<VulnerabilityIconKeywords:易傷>を1ターン付与する。"
  },
  Skill_57556_Name = {
    Text = "「矛盾」暗翼"
  },
  Skill_57557_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。双子融合度+15%。"
  },
  Skill_57557_Name = {
    Text = "「矛盾」合体"
  },
  Skill_57558_Desc = {
    Text = "<WeaknessIconKeywords:虚弱>と<BlindingKeywords:盲目>を2ターン付与する。[Arg1]点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、自身のデバフ状態を解除する。"
  },
  Skill_57558_Name = {
    Text = "「矛盾」銀輝"
  },
  Skill_57568_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「徐々な忘却」を1枚手札に追加し、<WeaknessIconKeywords:虚弱>を2ターン付与する。"
  },
  Skill_57661_Desc = {
    Text = "神母の権能を1点回復する。神母の権能はマーフィーの他の能力を発動するために消費できる。最大3点。\n（神母の権能：[Arg1]点）"
  },
  Skill_57661_Name = {Text = "小休憩"},
  Skill_57662_Desc = {
    Text = "神母の権能を1点消費する。[Arg2]点の力を獲得し、すべての覚醒体は[Arg3]狂気を獲得する。\n（神母の権能：[Arg1]点）"
  },
  Skill_57662_Name = {
    Text = "威厳を示す斬首"
  },
  Skill_57663_Desc = {
    Text = "「神母の権能」を1点消費する。すべての敵を1ターン<WeaknessIconKeywords:虚弱>にし、[Arg2]点のシールドを獲得し同量のライフを回復する。この効果は失われたライフに応じて増加し、最大で2倍になる。\n（神母の権能：[Arg1]点）"
  },
  Skill_57663_Name = {
    Text = "自由を敬う犠牲"
  },
  Skill_57664_Desc = {
    Text = "「神母の権能」を1点消費する。すべての敵に1ターンの<VulnerabilityIconKeywords:易傷>を付与し、このターン、すべての覚醒体が与えるダメージが25％増加する。1点の行動力を獲得し、カードを1枚引く。（現在の神母の権能：[Arg1]点）"
  },
  Skill_57664_Name = {
    Text = "恩仇に報う叱責"
  },
  Skill_57668_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「融蝕の芯」を1枚山札に追加。"
  },
  Skill_57668_Name = {
    Text = "新生の始まり"
  },
  Skill_57669_Desc = {
    Text = "「融蝕の霧の盾」を付与し、「忘却の始まり」に変化する。"
  },
  Skill_57669_Name = {
    Text = "強制融合"
  },
  Skill_57670_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_57670_Name = {Text = "廃棄"},
  Skill_57671_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。「闇の子」と「光の子」に分裂し、融合度1%につき「光の子」のライフを0.5%減少させる。"
  },
  Skill_57671_Name = {
    Text = "巨体崩壊"
  },
  Skill_57699_Desc = {
    Text = "すべての対象が2点の<ParcloseIconKeywords:バリア>を獲得し、自身は追加で5点獲得する。"
  },
  Skill_57699_Name = {Text = "バリア"},
  Skill_57754_AwakerSkillBackgroundStory = {
    Text = "柔らかな海風の中で彼女は眠りに落ちたが、羽ばたく音に驚かされて目を覚ました。全身真っ白な小鳥が彼女の頭上を掠め、同じく真っ白な雲の中に消えていった。\nそれはきっと夢だろう、陸から遠く離れたこの大洋の深いところで、どうして一羽の飛鳥が孤独でいるのだろうか？\n彼女はそう考えながら、どうしようもなく希冀を感じ、一種の憧れを抱いていた。"
  },
  Skill_57754_Desc = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復。[Arg2]点の行動力を獲得し、手札の<SlowIconKeywords:遅延>を解除する。1ターン<RetainIconKeywords:保持>するごとに、回復するライフが<Heal:[Arg3]>増加する。触腕1本に敵を攻撃させ、[Arg4]%の触腕ダメージを与える。"
  },
  Skill_57754_EffectNameList_0 = {Text = "回復"},
  Skill_57754_EffectNameList_2 = {
    Text = "回復,追加回復"
  },
  Skill_57754_Name = {
    Text = "純白の夢"
  },
  Skill_57754_PropertyNameList_0 = {
    Text = "体力×GrowValue1,"
  },
  Skill_57754_PropertyNameList_2 = {
    Text = "体力×GrowValue1,体力×GrowValue2"
  },
  Skill_57760_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、<Energy:[Energy:Arg1]>狂気を消費して<PVPDerivativeCardKeywords_12:「小さな願い」>に変換する。変換に失敗した場合、<Energy:[Energy:Arg2]>狂気を獲得する。"
  },
  Skill_57760_Name_1 = {
    Text = "永劫の演奏"
  },
  Skill_57761_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：各ターンの最初の「狂気解放」の後、一時的に<StrongEffectKeywords:強度> +[Arg1]を得る。"
  },
  Skill_57761_Name_1 = {
    Text = "羊飼いの杖"
  },
  Skill_57762_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[Arg1]層の<PVPSleepKeywords:上質な睡眠>を得る。"
  },
  Skill_57762_Name_1 = {
    Text = "氷河の眠り"
  },
  Skill_57763_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「スキル」のダメージが[Arg1]%増加する。「狂気解放」の後、自身の失ったライフの[Arg2]%を回復する。"
  },
  Skill_57763_Name_1 = {
    Text = "雪山が溶けるまで"
  },
  Skill_57764_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」によるダメージ・回復・シールド効果が [Arg1]〜[Arg2]％ 上昇し、"
  },
  Skill_57764_Name_1 = {
    Text = "運命のルーレット"
  },
  Skill_57765_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者のスキルカードを初めて使用した後、装備者のスキルカードを1枚引く。毎ターン1回まで発動。"
  },
  Skill_57765_Name_1 = {
    Text = "真理の門"
  },
  Skill_57805_Desc = {
    Text = "毎ターン、極夜の微光を1つ獲得する。"
  },
  Skill_57805_Name = {
    Text = "ラモンナ支援"
  },
  Skill_57807_Desc = {
    Text = "ラモンナが残した遡行の力を使用し、戦闘開始時に戻る。"
  },
  Skill_57807_Name = {
    Text = "ラモンナ最終支援の追憶"
  },
  Skill_57808_Desc = {
    Text = "ハムリンは2ターン休息する。その後、すべての支援効果の使用回数+1。"
  },
  Skill_57809_Desc = {
    Text = "双子融合度を10%減少させる。このターン「狂気解放」を1回発動するたび、追加で双子融合度を3%減少させる。[Arg1]回使用できる。"
  },
  Skill_57809_Name = {Text = "鎮魂歌"},
  Skill_57810_Desc = {
    Text = "このターン与えるダメージ、毒、反撃が25%増加する。[Arg1]回使用できる。"
  },
  Skill_57811_Desc = {
    Text = "3点の行動力を獲得し、カードを3枚引く。このターン指令カードを1枚使用するたび、すべての覚醒体は1狂気を獲得する。[Arg1]回使用できる。"
  },
  Skill_57811_Name = {Text = "協奏曲"},
  Skill_57812_Desc = {
    Text = "万全の状態で復活し、すべてのカードと三大神子を思い出し、「極夜の微光」を5枚獲得する。"
  },
  Skill_57812_Name = {
    Text = "ラモンナ最終支援"
  },
  Skill_57859_Desc = {
    Text = "[Arg2]面サイコロを1個振り、サイコロの出目*[Arg1]に等しい一時的な<PowerIconKeywords:力>を獲得する。出目が4以上の場合、すべての敵を<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>にする（1ターン）。出目が6以上の場合、獲得する一時的な<PowerIconKeywords:力>は2倍になり、行動力を1点獲得する。"
  },
  Skill_57859_Name = {
    Text = "輝くイカサマダイス"
  },
  Skill_57860_Desc = {
    Text = "[Arg2]面サイコロを1個振り、サイコロの出目*[Arg1]に等しい一時的な<PowerIconKeywords:力>を獲得する。出目が4以上の場合、すべての敵を<VulnerabilityIconKeywords:易傷>にする（1ターン）。出目が6以上の場合、獲得する一時的な<PowerIconKeywords:力>は2倍になる。"
  },
  Skill_57860_Name = {
    Text = "イカサマダイス"
  },
  Skill_57887_Desc = {
    Text = "現在のライフとライフ上限を[Arg1]点増加させる。「融蝕の霧の盾」を付与し、「終焉の忘却の理」に変化する。"
  },
  Skill_57887_Name = {
    Text = "完璧な融合"
  },
  Skill_57888_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得する。「闇の子」と「光の子」に分裂し、「光の子」のライフを75%減少させ、永久に「眩暈」状態にする。"
  },
  Skill_57888_Name = {
    Text = "融蝕の分裂"
  },
  Skill_57892_Desc = {
    Text = "<DerivativeCardKeywords_1:「影の残響」>を3枚手札に追加し、選択後この選択肢を除去する。"
  },
  Skill_57892_Name = {
    Text = "道を探す"
  },
  Skill_57893_Desc = {
    Text = "前のターンで最後に使用した異なる指令カード3枚の、行動力消費0、除外が付与されたコピーを獲得する。<DerivativeCardKeywords_39:「過去の響き」>を手札に追加し、選択後この選択肢を除去する。"
  },
  Skill_57893_Name = {
    Text = "過去を思い出す"
  },
  Skill_57894_Desc = {
    Text = "<DerivativeCardKeywords_67:「シルバーキーの暁光」>と<DerivativeCardKeywords_41:「シルバーキー共鳴」>を手札に追加し、選択後この選択肢を除去する。"
  },
  Skill_57894_Name = {
    Text = "シルバーキーを握る"
  },
  Skill_57895_Desc = {
    Text = "「融蝕の芯」によって失った力、反撃、ライフ上限を返還する。5点の行動力を獲得し、すべての覚醒体は100狂気を獲得する。すべての<DerivativeCardKeywords_38:幻覚>を元に戻す。"
  },
  Skill_57895_Name = {
    Text = "最初のリンク"
  },
  Skill_57947_Desc = {
    Text = "敵のライフ上限を10%減少させる。触腕を1本生成し、[Arg1]点の一時的な触腕ダメージを獲得する。"
  },
  Skill_57947_Name = {
    Text = "王権の威"
  },
  Skill_57949_Desc = {
    Text = "自身の<WeaknessIconKeywords:倦怠>と力の減少状態を解除する。[Arg1]点の一時的な触腕ダメージを獲得する。"
  },
  Skill_57949_Name = {
    Text = "ルルイエ再臨"
  },
  Skill_57950_Desc = {
    Text = "合計[Arg1]点のダメージを1回与える。触腕1本につきダメージが[Arg3]点増加する。"
  },
  Skill_57950_Name = {
    Text = "深淵の号令"
  },
  Skill_57951_Desc = {
    Text = "「震怒」、12点の「眠気」、[Arg1]点の触腕ダメージを獲得する。"
  },
  Skill_57951_Name = {
    Text = "不朽の威厳"
  },
  Skill_57969_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「融蝕の芯」を2枚山札に追加。"
  },
  Skill_57969_Name = {
    Text = "忘却は新生の始まり"
  },
  Skill_57971_Desc = {
    Text = "双子融合度を30%増加させる。"
  },
  Skill_57971_Name = {
    Text = "融合度アップ"
  },
  Skill_57972_Desc = {
    Text = "双子融合度を30%減少させる。"
  },
  Skill_57972_Name = {
    Text = "融合度ダウン"
  },
  Skill_58044_Desc = {
    Text = "「オールイン」と「決戦の瞬間」の基礎ダメージが永久に25%増加する。"
  },
  Skill_58044_Name = {
    Text = "胴元の総取り"
  },
  Skill_58288_Desc = {
    Text = "<C05_yansheng2:閃耀偏方ダイス>を1枚手札に追加し、[Arg1]%の一時的クリティカル率を獲得する。"
  },
  Skill_58288_Name = {
    Text = "一発の銃声"
  },
  Skill_58494_Name = {Text = "熟睡"},
  Skill_58495_Desc = {
    Text = "触腕ダメージを[Arg1]点増加させる。"
  },
  Skill_58495_Name = {
    Text = "夢の呟き"
  },
  Skill_58933_AwakerSkillBackgroundStory = {
    Text = "降りよ、降りよ——疲れ果てた旅人よ、還る時が来た。\n音符が魂をそっと包む。痛みも執着も手放して、静かな夢へ。"
  },
  Skill_58933_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_58933_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。「楽音」効果が発動した場合、獲得する一時的な<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_58933_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ハムリンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_58933_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ハムリンは<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。「楽音」効果が発動した場合、獲得する一時的な<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_58933_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_58933_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_58939_AwakerSkillBackgroundStory = {
    Text = "帆を張れ、高く、高く——遠くへと旅立つのだ。\n号角が鳴り、鳥たちが共に翔ける。最も高き波を越えて。"
  },
  Skill_58939_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_58939_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。「楽音」効果が発動した場合、獲得する一時的な<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_58939_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ハムリンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_58939_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ハムリンは<Energy:[Energy:Arg2]>狂気を獲得。[Power:Arg3]点の一時的な<PowerIconKeywords:力>を獲得。「楽音」効果が発動した場合、獲得する一時的な<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_58939_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_58939_Name = {Text = "攻撃"},
  Skill_58939_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_59159_Desc_1 = {
    Text = "対象1体に<StrongEffectKeywords:特効>を付与する。"
  },
  Skill_59159_Name_1 = {Text = "特効"},
  Skill_59191_Name = {
    Text = "極夜の微光"
  },
  Skill_59428_Desc_1 = {
    Text = "対象1体に<ReduceEffectKeywords:特効減少>を付与する。"
  },
  Skill_59428_Name_1 = {
    Text = "特効減少"
  },
  Skill_59476_AwakerSkillBackgroundStory = {
    Text = "この曲に出会うまで、あなたの耳は眠っていた。\nこの曲を聴いたら、二度と同じ音には出会えない。\n\nだから——全神経を研ぎ澄まし、息を殺して、この生涯に一度の旋律を讃えよ。"
  },
  Skill_59476_Desc_0 = {
    Text = "ハムリンは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：ターン開始時、「<DerivativeCardKeywords_64:共鳴の交響曲>」を1枚手札に加える<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_Desc_15 = {
    Text = "ハムリンは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：ターン開始時、「<DerivativeCardKeywords_64:共鳴の交響曲>」を1枚手札に加える。ターン開始時、「メロディ」を持つ指令カードが1枚あるごとに、ハムリンは <Energy:[Energy:Arg2]> 点の狂気を獲得する。「元初の楽音」を放す時、楽音を持つ指令カードが2枚存在するごとに、ダメージ回数+1<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_EffectNameList = {Text = "狂気"},
  Skill_59476_Name = {
    Text = "至高の楽章"
  },
  Skill_59477_AwakerSkillBackgroundStory = {
    Text = "音楽はどこから生まれる？\n\n神への祭礼から、農夫の掛け声から、原始人の咆哮から、春のウグイスのさえずりから、松風と波の音から、大地の震えと山の崩れから……\n\nそれとも天地の混沌の彼方、神の夢の中の呟きから。"
  },
  Skill_59477_BattleDesc_0 = {
    Text = "ランダムに[Arg3]回<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、毎回ダメージを与えるたびに対象の[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に低下させ、[Power:Arg2]点の<PowerIconKeywords:一時的な力>を獲得する。手札の「音楽」を持たない非消耗かつ非派生の指令カード1枚を選び、「<HuihuanaKeywords:ループする音楽>」を追加する。手札に追加できるカードがない場合、代わりに追加で3回ダメージを与える。"
  },
  Skill_59477_BattleDesc_2 = {
    Text = "ランダムに[Arg3]回<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、毎回ダメージを与えるたびに対象の[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に低下させ、[Power:Arg2]点の<PowerIconKeywords:一時的な力>を獲得する。手札の「音楽」を持たない非消耗かつ非派生の指令カード1枚を選び、「<HuihuanbKeywords:ループする音楽>」を追加する。手札に追加できるカードがない場合、代わりに追加で3回ダメージを与える。"
  },
  Skill_59477_Desc_0 = {
    Text = "ランダムに3回<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、ダメージを与えるたびに<TouquKeywords:奪取>対象の[Arg2]点の<PowerIconKeywords:力>を奪う。手札から「音楽」を持たない非消耗かつ非派生の指令カードを1枚選び、「<HuihuanaKeywords:ループする音楽>」を追加する。追加できる手札がない場合、代わりに追加で3回ダメージを与える。"
  },
  Skill_59477_Desc_2 = {
    Text = "ランダムに3回<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与え、ダメージを与えるたびに<TouquKeywords:奪取>対象の[Arg2]点の<PowerIconKeywords:力>を奪う。手札から「音楽」を持たない非消耗かつ非派生の指令カードを1枚選び、「<HuihuanbKeywords:ループする音楽>」を追加する。追加できる手札がない場合、代わりに追加で3回ダメージを与える。"
  },
  Skill_59477_EffectNameList = {
    Text = "ダメージ,力の吸収"
  },
  Skill_59477_Name = {
    Text = "原初の奏響"
  },
  Skill_59477_OverLimitUtlSkillDesc = {
    Text = "ランダムに<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>[Arg3]回与える。ダメージを与えるたび、対象から[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させる。[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。対象にランダムな<MysterydebuffKeywords:不思議なデバフ効果>を1つ付与する。手札から「楽音」を持たない非除外かつ非派生の指令カードを2枚選び、「<HuihuanbKeywords:循環楽音>」を付与する。手札に付与するカードがない場合、代わりに追加でダメージを3回与える。"
  },
  Skill_59477_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_59478_AwakerSkillBackgroundStory = {
    Text = "もし魂が分割できるなら、それを構成するのは音符であろう。\n高音と低音、速さと緩やかさ、生の産声と死の慟哭が共に響く。\n\nさあ聴け。声高く唱和せよ。\nこれは君という存在の形を描く、魂の序章。"
  },
  Skill_59478_BattleDesc = {
    Text = "ランダムに<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を[Arg2]回与える。ダメージを与えるたび、50%の確率で対象にランダムな<MysterydebuffKeywords:不思議なデバフ効果>を1つ付与する。行動力消費が0の場合、追加でダメージを2回与える。"
  },
  Skill_59478_Desc = {
    Text = "ランダムに<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を3回与える。ダメージを与えるたび、50%の確率で対象にランダムな<MysterydebuffKeywords:不思議なデバフ効果>を1つ付与する。行動力消費が0の場合、追加でダメージを2回与える。"
  },
  Skill_59478_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_59478_Name = {
    Text = "魂の序曲"
  },
  Skill_59478_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_59479_AwakerSkillBackgroundStory = {
    Text = "この旋律を、聴いたことがあるか。\nどこか懐かしく、温かく、人生のすべてを揺さぶる音楽。\n\nいったい、どこで聴いたのだろうか。\n夢の中か、思い出の中か、あるいは死の間際——天国からの呼び声として、笛吹く天使が静かに奏でる旋律として。"
  },
  Skill_59479_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。<DerivativeCardKeywords_4:「啓示」>を2枚手札に追加する。行動力が不足している場合でも強制的に使用でき、その効果は「啓示」を2枚山札に追加に変更される。"
  },
  Skill_59479_EffectNameList = {Text = "力"},
  Skill_59479_Name = {
    Text = "追憶の輪舞曲"
  },
  Skill_59479_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_59490_Desc = {
    Text = "次に使用する非派生指令カードの行動力消費+2、効果が2回発動する。"
  },
  Skill_59490_Name = {
    Text = "上行音階"
  },
  Skill_59491_Desc = {
    Text = "次に使用する非派生指令カードの行動力消費-2。"
  },
  Skill_59491_Name = {
    Text = "下行音階"
  },
  Skill_59665_Desc = {
    Text = "警備に見つかった……戦闘終了後もデッキに残る。"
  },
  Skill_59665_Name = {Text = "警鐘"},
  Skill_59735_Desc = {
    Text = "すべての対象の失ったライフを15%回復する。"
  },
  Skill_59735_Name = {Text = "聖癒"},
  Skill_59736_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<FragileIconKeywords:脆弱>を2ターン付与する。すべてのカードに1ターンの「侵食」を付与する。"
  },
  Skill_59737_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「徐々な忘却」を1枚手札に追加する。<WeaknessIconKeywords:虚弱>を2ターン付与する。<DerivativeCardKeywords_38:幻覚>を2枚山札に追加。"
  },
  Skill_59737_Name = {
    Text = "永遠の忘却"
  },
  Skill_59738_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。「融蝕の芯」を1枚山札に加える。<HeavyInjuryKeywords:重傷>を2ターン付与する。"
  },
  Skill_59738_Name = {Text = "破壊"},
  Skill_59739_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。「融蝕の芯」を1枚山札に加える。<HeavyInjuryKeywords:重傷>を2ターン付与する。"
  },
  Skill_59739_Name = {Text = "滅亡"},
  Skill_59740_Desc = {
    Text = "すべての対象の<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>、<VulnerabilityIconKeywords:軟化>、<HeavyInjuryKeywords:重傷>状態を解除し、それらの<IntoxicationIconKeywords:毒>を25%減少させる。"
  },
  Skill_59740_Name = {Text = "浄化"},
  Skill_59866_Desc = {
    Text = "後方に移動し、「混沌到来」状態に入り、「混沌」のスタック数を上限まで回復する。戦場に「N」の分身が存在する場合、それに5点のバリアを付与し、その後分身を上限まで召喚する。既に「暗黒」を3点所有している場合、追加で自身が1点の発狂を獲得する。"
  },
  Skill_59866_Name = {
    Text = "混沌到来"
  },
  Skill_59867_Desc = {
    Text = "[Arg1]点のダメージを[Arg2]回与え、「痙攣」を1枚プレイヤーの捨て札に追加する。戦場に存在する「呟き」の分身1体につき、さらに1枚追加する。"
  },
  Skill_59867_Name = {
    Text = "言葉にできぬ恐怖"
  },
  Skill_60001_Desc = {
    Text = "1点の<MadnessIconKeywords:発狂>を獲得する。相手の<PowerIconKeywords:力>を[Arg1]点一時的に減少させる。"
  },
  Skill_60001_Name = {
    Text = "低く唸る"
  },
  Skill_60002_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。完全にガードされなかった分と同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_60002_Name = {
    Text = "出血の爪"
  },
  Skill_60003_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_60025_Desc = {
    Text = "山札のカード3枚の行動力消費を3にする。"
  },
  Skill_60025_Name = {Text = "鳴き声"},
  Skill_60026_Desc = {
    Text = "1ターンの<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_60026_Name = {
    Text = "羽ばたく"
  },
  Skill_60027_Desc = {
    Text = "自身が死亡し、<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、カード4枚に<AberrationKeywords:変異>を発生させる。"
  },
  Skill_60027_Name = {Text = "尾針！"},
  Skill_60039_Desc = {
    Text = "未装備の3つの「キーオーダー」から、1つを選んで発動する。1点の行動力を獲得し、自身の<IntoxicationIconKeywords:毒>、封印、<SlowIconKeywords:鈍化>状態を解除する。"
  },
  Skill_60039_Name = {
    Text = "理想郷の帳"
  },
  Skill_60040_Desc = {
    Text = "すべての手札を捨て、捨てた枚数+3枚のカードを引く。"
  },
  Skill_60040_Name = {
    Text = "異形の心臓"
  },
  Skill_60041_Desc = {
    Text = "覚醒体を1体選択し、それに[Arg1]狂気を獲得させる。"
  },
  Skill_60041_Name = {
    Text = "無邪気な贈り物"
  },
  Skill_60042_Desc = {
    Text = "[Arg1]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_60042_Name = {Text = "蜂蜜酒"},
  Skill_60047_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_60048_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、最も狂気が高い覚醒体の狂気が50%失われる。"
  },
  Skill_60048_Name = {
    Text = "狂気窃取"
  },
  Skill_60060_Desc = {
    Text = "ライフを[Arg1]%回復する。戦場に存在する「呟き」の分身1体につき、追加で失ったライフの[Arg2]%を回復する。"
  },
  Skill_60060_Name = {
    Text = "暗色の浸蝕"
  },
  Skill_60071_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「捜査猫」を[Arg3]体前に召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。"
  },
  Skill_60071_Name = {Text = "飼育"},
  Skill_60072_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「捜査猫」を[Arg3]体前に召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。"
  },
  Skill_60072_Name = {Text = "飼育"},
  Skill_60073_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「捜査猫」を[Arg3]体前に召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。"
  },
  Skill_60073_Name = {Text = "飼育"},
  Skill_60074_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_60074_Name = {
    Text = "「重傷」飛刃"
  },
  Skill_60075_Desc = {
    Text = "「蜜蜂さん」を[Arg1]体後ろに召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。"
  },
  Skill_60075_Name = {Text = "帰巣"},
  Skill_60076_Desc = {
    Text = "「蜜蜂さん」を[Arg1]体後ろに召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。味方全体に[Arg2]点のバリアを付与し、バリアの数はターン数に応じて増加する。"
  },
  Skill_60076_Name = {
    Text = "群鳥の帰巣"
  },
  Skill_60077_Desc = {
    Text = "「蜜蜂さん」を[Arg1]体後ろに召喚し、自身のライフが低いほど召喚する使い魔はより強くなる。"
  },
  Skill_60077_Name = {Text = "帰巣"},
  Skill_60078_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_60078_Name = {
    Text = "「重傷」飛刃"
  },
  Skill_60079_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターンの<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_60079_Name = {
    Text = "「重傷」飛刃"
  },
  Skill_60080_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_60081_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_60082_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_60131_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の警戒を獲得。"
  },
  Skill_60131_Name = {
    Text = "機械武装-収"
  },
  Skill_60132_Desc = {
    Text = "ターン終了時に、状態に応じて異なるバフを獲得。「放」：1点の一時的な<MadnessIconKeywords:発狂>を獲得。「収」：50点の一時的な<ReinforcePVEKeywords:堅固>を獲得。"
  },
  Skill_60132_Name = {
    Text = "変数の最適化"
  },
  Skill_60133_Desc = {
    Text = "[Arg1]点の力を獲得。"
  },
  Skill_60133_Name = {
    Text = "機械武装-放"
  },
  Skill_60134_Desc = {
    Text = "2ターンの<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点のシールドを獲得する。"
  },
  Skill_60134_Name = {
    Text = "電磁爆破"
  },
  Skill_60135_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg2]点のバリアを獲得。毎回「形態切換」でダメージ回数とバリア数が1増加。"
  },
  Skill_60135_Name = {
    Text = "機能過負荷"
  },
  Skill_60136_Desc = {
    Text = "[Arg1]点のシールドと[Arg2]点の一時的な<RetaliateIconKeywords:反撃>を獲得。"
  },
  Skill_60137_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_60137_Name = {Text = "攻撃"},
  Skill_60171_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>と[Arg2]点のシールドを付与する。この出血は力による増加ボーナスを受ける。"
  },
  Skill_60172_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージと同量の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_60172_Name = {
    Text = "試しの剣技"
  },
  Skill_60173_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_60173_Name = {Text = "重傷"},
  Skill_60174_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_60174_Name = {Text = "剣勢"},
  Skill_60175_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージの10倍のライフを回復する。"
  },
  Skill_60175_Name = {
    Text = "吸血の剣技"
  },
  Skill_60176_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_60176_Name = {
    Text = "幻影の剣"
  },
  Skill_60177_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_60177_Name = {Text = "鎧砕き"},
  Skill_60178_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>と[Arg2]点のシールドを付与する。この出血は力による増加ボーナスを受ける。"
  },
  Skill_60179_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_60179_Name = {Text = "剣意"},
  Skill_60180_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_60180_Name = {Text = "鎧砕き"},
  Skill_60181_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の一時的な<RetaliateIconKeywords:反撃>を獲得する。"
  },
  Skill_60181_Name = {Text = "剣勢"},
  Skill_60182_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_60182_Name = {
    Text = "幻影の剣"
  },
  Skill_60192_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、[Arg2]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_60192_Name = {Text = "剣意"},
  Skill_60193_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージと同量の一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_60193_Name = {
    Text = "試しの剣技"
  },
  Skill_60194_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_60194_Name = {Text = "重傷"},
  Skill_60195_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージの10倍のライフを回復する。"
  },
  Skill_60195_Name = {
    Text = "吸血の剣技"
  },
  Skill_60252_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_60252_Name = {
    Text = "裂け目の刃"
  },
  Skill_60253_Desc = {
    Text = "[Arg1]点の<BleedingIconKeywords:出血>と[Arg2]点のシールドを付与する。この出血は力による増加ボーナスを受ける。"
  },
  Skill_60253_Name = {Text = "敗血症"},
  Skill_60254_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>と[Arg2]点の一時的な<RetaliateIconKeywords:反撃>を獲得し、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_60254_Name = {Text = "剣勢"},
  Skill_60255_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<FragileIconKeywords:抑圧>を付与する。"
  },
  Skill_60255_Name = {
    Text = "鎧砕きの刃"
  },
  Skill_60256_Desc = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:穿刺>ダメージを与え、対象のライフが高いほどダメージも高くなる。[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_60256_Name = {
    Text = "影刃「<PunctureDamagewords:刺突>」"
  },
  Skill_60272_Desc = {
    Text = "ランダムな<AberrationKeywords:変異>3枚と「症状」1枚を山札に加える。"
  },
  Skill_60272_Name = {
    Text = "この世界のために"
  },
  Skill_60273_Desc = {
    Text = "教えてくれ、シークレットキーパー……何があなたを戦い続けさせているの？\nこのカードが手札にある間に他のカードを発射した場合、「タヴィ」は怒りを覚え、味方に[Arg1] 点の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_60273_Name = {
    Text = "タヴィに答える"
  },
  Skill_60274_Desc = {
    Text = "「タヴィ」は3点の<ExclamationPointColour:怨恨の鎖>を獲得する。"
  },
  Skill_60274_Name = {
    Text = "大切な人のために"
  },
  Skill_60275_Desc = {
    Text = "ランダムな 7 枚の指令カードに<ErosionColorInkKeywords:認知錯乱>を付与する。"
  },
  Skill_60275_Name = {
    Text = "ただ自分のためだけに"
  },
  Skill_60285_Desc = {
    Text = "覚醒体を1体選択し30狂気を獲得させ、他の覚醒体は10狂気を失う。このカードがターン終了時に手札にある場合、味方に[Arg1]ダメージを与える。"
  },
  Skill_60285_Name = {
    Text = "真・輪廻のパラドックス"
  },
  Skill_60286_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「真・輪廻のパラドックス」を2枚手札に追加する。"
  },
  Skill_60286_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_60287_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「真・輪廻のパラドックス」を6枚手札に追加する。"
  },
  Skill_60287_Name = {
    Text = "六翼の解放"
  },
  Skill_60288_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、「真・輪廻のパラドックス」を4枚手札に追加する。"
  },
  Skill_60288_Name = {
    Text = "四翼の芽生え"
  },
  Skill_60293_Desc = {
    Text = "ライフ上限を2倍に増加させる。毎ターン開始時に「タヴィに答える」を1枚手札に追加する。"
  },
  Skill_60293_Name = {Text = "復興"},
  Skill_60309_Desc = {
    Text = "融蝕の中で足掻き、融蝕の中で消え逝く。引いた時、現在の行動力と狂気の25%を失う。使用後、<PowerIconKeywords:力>と<RetaliateIconKeywords:反撃>を20%失う。ターン終了時に手札にある場合、ライフ上限が5%減少する。"
  },
  Skill_60309_Name = {
    Text = "融蝕の芯"
  },
  Skill_60310_Desc = {
    Text = "失ったライフの15%([Arg2])を回復し、このターン「狂気解放」を発動した時に失ったライフの5%を回復する。[Arg1]回使用できる。"
  },
  Skill_60310_Name = {Text = "子守歌"},
  Skill_60335_Desc = {
    Text = "あなたは世界を忘れ、世界もまたあなたを忘れていく。ターン終了前、他のすべての手札を<DerivativeCardKeywords_38:「幻覚」>に変化させ、捨てる。"
  },
  Skill_60335_Name = {
    Text = "記憶の消失"
  },
  Skill_60397_Desc = {
    Text = "20点の<ReinforcePVEKeywords:堅固>と[Arg1]点の<PowerIconKeywords:力>を獲得。以後ダメージを1回受けるたび、2点の一時的な<ReinforcePVEKeywords:堅固>を獲得。"
  },
  Skill_60397_Name = {
    Text = "終焉進化"
  },
  Skill_60398_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2ターンの<BlindingKeywords:致盲>と<HeavyInjuryKeywords:重创>を付与する。"
  },
  Skill_60398_Name = {
    Text = "「鬼面の噛みつき」"
  },
  Skill_60399_Desc = {
    Text = "[Block:Arg1]点のシールド、[Arg2]点の<PowerIconKeywords:力>、[Arg3]点の<RetaliateIconKeywords:反撃>を獲得し、自身のデバフ状態を解除する。"
  },
  Skill_60399_Name = {Text = "変身"},
  Skill_60424_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。1枚の<DerivativeCardKeywords_4:「啓示」>を手札に追加。このターンに「音符の律令」を発動すると、1枚の<DerivativeCardKeywords_4:「啓示」>を手札に追加。"
  },
  Skill_60424_Name = {
    Text = "追憶の輪舞曲\n行動力≥2"
  },
  Skill_60425_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージと同等の一時的な<PowerIconKeywords:力>を獲得し、ガードされなかったダメージの10倍に等しいライフを回復する。"
  },
  Skill_60425_Name = {
    Text = "原初の奏響\n行動力≤2"
  },
  Skill_60426_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、対象の<PowerIconKeywords:力量>を[Arg3]点減少させる。"
  },
  Skill_60426_Name = {
    Text = "下行音階\n行動力1"
  },
  Skill_60427_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の永続的な<ReinforcePVEKeywords:堅固>を獲得。"
  },
  Skill_60427_Name = {
    Text = "上行音階\n行動力3"
  },
  Skill_60428_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージごとにランダムな負の効果を1つ付与する。その後の「魂の序曲」のダメージ回数+1。"
  },
  Skill_60428_Name = {
    Text = "魂の序曲\n行動力0"
  },
  Skill_60475_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_60475_Name = {
    Text = "長き憎しみ"
  },
  Skill_60476_Desc = {
    Text = "すべての味方が[Arg1]点の<PowerIconKeywords:力>を獲得し、自身の<WeaknessIconKeywords:倦怠>と<VulnerabilityIconKeywords:軟化>を解除する。"
  },
  Skill_60476_Name = {
    Text = "絶望からの生還"
  },
  Skill_60477_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_60478_Desc = {
    Text = "すべての擬態覚醒体を除去する。擬態覚醒体を2体召喚する。この戦闘中、すべての覚醒体が生成する狂気が50%減少する。"
  },
  Skill_60478_Name = {
    Text = "慈母邂逅"
  },
  Skill_60479_Desc = {
    Text = "擬態覚醒体を1体召喚する。擬態覚醒体が上限に達している場合、行動予測は「攻撃」に変化する。"
  },
  Skill_60479_Name = {
    Text = "聖血の本能"
  },
  Skill_60480_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]ターン<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_60480_Name = {
    Text = "石の分解"
  },
  Skill_60481_Desc = {
    Text = "最も狂気が高い覚醒体に50狂気を失わせ、これを2回実行する。2ターンの<BlindingKeywords:盲目>と<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_60481_Name = {
    Text = "古の愛撫"
  },
  Skill_60482_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、山札の上の[Arg3]枚のカードに「<SlowIconKeywords:鈍化>」と「<RetainIconKeywords:保持>」を付与する。"
  },
  Skill_60482_Name = {
    Text = "停滞の呪い"
  },
  Skill_60483_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>、[Arg4]%の<BleedingIconKeywords:出血>、[Arg5]%の<RetaliateIconKeywords:反撃>を付与。"
  },
  Skill_60483_Name = {
    Text = "豊穣の儀"
  },
  Skill_60498_Desc = {
    Text = "すべての味方が毎ターン開始時、前のターンに受けたダメージの半分に等しいシールドを獲得する。"
  },
  Skill_60498_Name = {
    Text = "林檎磨きの抱擁"
  },
  Skill_60501_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2枚の<DerivativeCardKeywords_34:「満たされぬ痛み」>を山札に追加。"
  },
  Skill_60514_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_60514_Name = {Text = "飛刃"},
  Skill_60515_Desc = {
    Text = "<BloodOath:血の誓い>を10点獲得し、2ターンの<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_60515_Name = {
    Text = "紅血の誓い"
  },
  Skill_60516_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<BloodOath:血の誓い>1点につき、[Arg3]ダメージ増加。"
  },
  Skill_60516_Name = {
    Text = "罪の灯火"
  },
  Skill_60517_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_60517_Name = {Text = "汚染"},
  Skill_60535_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の<FragileIconKeywords:脆弱>を付与する。「血染めの灯芯」を1枚手札に追加。"
  },
  Skill_60535_Name = {Text = "汚染"},
  Skill_60536_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ランダムに2点の<FragileIconKeywords:脆弱>または<HeavyInjuryKeywords:重傷>を付与する。「血染めの灯芯」を1枚手札に追加。"
  },
  Skill_60537_Desc = {
    Text = "<BloodOath:血の誓い>を10点獲得し、2点の<HeavyInjuryKeywords:重傷>を付与する。「血染めの灯芯」を1枚手札に追加。"
  },
  Skill_60537_Name = {
    Text = "紅血の誓い"
  },
  Skill_60538_Desc = {
    Text = "[Arg3]点の<SacrificeKeyWord:献上>と[Arg4]点の<PowerIconKeywords:力>を獲得する。ターン終了時にこのカードがまだ手札にある場合、「ランプシェード」アイシャにライフを[Arg1]失わせ、[Arg2]点の<PowerIconKeywords:力>を獲得させる。"
  },
  Skill_60538_Name = {
    Text = "血染めの灯芯"
  },
  Skill_60539_Desc = {
    Text = "「堅固」を80点まで獲得し、ターン終了時に10点の<BloodOath:血の誓い>を獲得。"
  },
  Skill_60539_Name = {Text = "羽化"},
  Skill_60540_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<BloodOath:血の誓い>1点につき、[Arg3]ダメージ増加。"
  },
  Skill_60540_Name = {
    Text = "罪の灯火"
  },
  Skill_60541_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_60541_Name = {Text = "敗血症"},
  Skill_60542_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<BloodOath:血の誓い>2点につき、ダメージ回数が1増加。"
  },
  Skill_60542_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_60552_Desc = {
    Text = "選択：<DerivativeCardKeywords_61:「上行音階」>または<DerivativeCardKeywords_62:「下行音階」>。"
  },
  Skill_60552_Name = {
    Text = "調和する響き"
  },
  Skill_60590_BattleDesc = {
    Text = "このターンに次に発射するカードの行動力消費が3以上の場合、行動力を2点獲得し、そうでなければカードを2枚ドローする。本戦闘中4回目の発動であれば、代わりに<DerivativeCardKeywords_4:「灵感」>を4枚直接獲得する。([Arg1]/4)"
  },
  Skill_60590_Desc = {
    Text = "このターンに次に発射するカードの行動力消費が3以上の場合、行動力を2点獲得し、そうでなければカードを2枚ドローする。本戦闘中4回目の発動であれば、代わりに<DerivativeCardKeywords_4:「灵感」>を4枚直接獲得する。"
  },
  Skill_60590_Name = {
    Text = "第四楽章"
  },
  Skill_60837_Desc_1 = {
    Text = "[Arg1]点の<PVPSlowKeywords:鈍化>を付与し、<PVPPenetrateKeywords:貫通>。"
  },
  Skill_60837_Name_1 = {
    Text = "第四楽章"
  },
  Skill_60837_UnknownName = {
    Text = "第四楽章"
  },
  Skill_60845_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを与え、[Arg2]<PVPSlowKeywords:鈍化>、<PVPPenetrateKeywords:貫通>。"
  },
  Skill_60845_Name_1 = {
    Text = "悲壮な弱奏"
  },
  Skill_60846_Desc_1 = {
    Text = "敵全体に <Damage:[Damage:Arg1]> ダメージを与え、ダメージの [Arg2]% の<PVPBleedingKeywords:出血>を付加し、ターゲットが駆散可能なネガティブステータスを持つ場合は [Arg3]% に上昇。"
  },
  Skill_60846_Name_1 = {
    Text = "原初の奏響"
  },
  Skill_60848_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂気を獲得し、<DelayKeywords:レイテンシ>：[Arg2] 行動力を消費。"
  },
  Skill_60848_Name_1 = {
    Text = "田園の和声"
  },
  Skill_60849_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_60849_Name_1 = {
    Text = "驚愕の強奏"
  },
  Skill_60884_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_60884_Name_1 = {Text = "攻撃"},
  Skill_60927_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_60928_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_60929_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。「祈り」を5点獲得。最後列の味方と位置を交換する。"
  },
  Skill_60929_Name = {Text = "祈り"},
  Skill_60930_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。自身は2点のバリアを獲得し、最前方の味方と交換位置。"
  },
  Skill_60931_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_60931_Name = {
    Text = "蝋燭の灯芯"
  },
  Skill_60932_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、最前列の味方と位置を交換する。"
  },
  Skill_60932_Name = {
    Text = "蝋人形登場"
  },
  Skill_60933_Desc = {
    Text = "<DerivativeCardKeywords_9:「よろよろ」>と<DerivativeCardKeywords_32:「ネバネバする蝋涙」>を1枚ずつ山札のランダムな位置に加える。最後列の味方と位置を交換する。"
  },
  Skill_60933_Name = {
    Text = "盛大な歓迎"
  },
  Skill_60934_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_60934_Name = {
    Text = "蝋人形登場"
  },
  Skill_60937_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]点の<PowerIconKeywords:力>を獲得し、最前列の味方と位置を交換する。<DerivativeCardKeywords_9:「よろよろ」>と<DerivativeCardKeywords_32:「ネバネバする蝋油」>を1枚ずつ山札に追加する。"
  },
  Skill_60937_Name = {
    Text = "蝋人形登場"
  },
  Skill_60938_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_60939_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2点の<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_60939_Name = {
    Text = "蝋人形登場"
  },
  Skill_60952_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」の前に全体の敵に [Arg1] 層の<PVPSlowKeywords:遅延>を付与する。"
  },
  Skill_60952_Name_1 = {
    Text = "永遠の鎮魂歌"
  },
  Skill_61119_AwakerSkillBackgroundStory = {
    Text = "ラケシスは命の尺を手に、デロス人の生涯を歌う。\n\nスパルタを屠る刺客よ、汝は英雄となりえたのだ。\nだがティーシポネーが汝の目を覆い、その翼は枷となった。\n汝を憎悪の奴隷に変え、汝の目には赤しか映らぬ。"
  },
  Skill_61119_Desc_0 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> のダメージと同量の<BleedingIconKeywords:出血>を与え、[Power:Arg2] ptの<PowerIconKeywords:力>を得る。"
  },
  Skill_61119_Desc_2 = {
    Text = "すべての敵に <Damage:[Damage:Arg1]> のダメージと同等の<BleedingIconKeywords:出血>を与え、[Power:Arg2] の<PowerIconKeywords:力>を得る。ライフが50%未満の場合、得られる<PowerIconKeywords:力>が2倍になる。"
  },
  Skill_61119_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_61119_Name = {
    Text = "憎悪の奔流"
  },
  Skill_61119_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_61120_AwakerSkillBackgroundStory = {
    Text = "殺せ、殺せ。ただ、死だけが残るまで。"
  },
  Skill_61120_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_61120_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%の一時的なクリティカル率とクリティカルダメージを獲得。"
  },
  Skill_61120_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。血ノ鎖・ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_61120_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。血ノ鎖・ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。[Arg3]%の一時的なクリティカル率とクリティカルダメージを獲得。"
  },
  Skill_61120_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_61120_Name = {Text = "攻撃"},
  Skill_61120_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_61121_AwakerSkillBackgroundStory = {
    Text = "アトロポスが黒い糸を断ち、デロス人の運命は絶たれた。\n\n枷を武器に戦ったその刺客は、勇猛であった。\nだが最後には、槍の海に沈んだ。"
  },
  Skill_61121_BattleDesc = {
    Text = "現在のライフの10%([Arg2])を失い、ランダムに<Damage:[Damage:Arg1]>ダメージを2回与え、50%の<BleedingIconKeywords:出血>を付与する。3回使用した後、<DerivativeCardKeywords_66:「血に狂う鎖球」>([Arg3]/3)に変化する。"
  },
  Skill_61121_Desc = {
    Text = "現在のライフの10%を失い、ランダムに<Damage:[Damage:Arg1]>ダメージを2回与え、50%の<BleedingIconKeywords:出血>を付与する。3回使用した後、<DerivativeCardKeywords_66:「血に狂う鎖球」>に変化する。"
  },
  Skill_61121_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_61121_Name = {
    Text = "鮮血の鎖"
  },
  Skill_61121_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_61122_AwakerSkillBackgroundStory = {
    Text = "アトロポスが黒い糸を断ち、デロス人の運命は絶たれた。\n\n枷を武器に戦ったその刺客は、勇猛であった。\nだが最後には、槍の海に沈んだ。"
  },
  Skill_61122_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、5倍の力ボーナスを獲得する。対象の<BleedingIconKeywords:出血>を30%発動し、失ったライフの[Arg3]%(<Heal:[Arg2]>)を回復する。使用後、<DerivativeCardKeywords_65:「鮮血の鎖」>に変化する。このカードは「攻撃」として扱う。"
  },
  Skill_61122_Desc = {
    Text = "「打撃」と見なされる。<Damage:[Damage:Arg1]>ポイントのダメージを与え、そのダメージは5倍の力ボーナスを受け、ターゲットの30%の<BleedingIconKeywords:出血>を引き起こし、失ったライフの15%を回復する。発射後、「<DerivativeCardKeywords_65:鮮血の鎖>」に変化する。"
  },
  Skill_61122_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_61122_Name = {
    Text = "血に狂う鉄球"
  },
  Skill_61122_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_61123_AwakerSkillBackgroundStory = {
    Text = "歌え、運命の女神達よ。デロスの娘の運命を歌え。\n血と涙、怒りと絶望に満ちた、その生涯を。\n\nその憎しみは猛火となり、すべてを焼き尽くした。\nそして最後には、自らをも灰燼に帰した。"
  },
  Skill_61123_Desc_0 = {
    Text = "血ノ鎖・ヘロットは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：<DerivativeCardKeywords_65:「鮮血の鎖」>を1枚手札に追加する。血ノ鎖・ヘロットの指令カードは「<RetainIconKeywords:保持>」を獲得。この戦闘中、ターン開始時に血ノ鎖・ヘロットの基礎ダメージが[Arg2]%増加する。"
  },
  Skill_61123_Desc_15 = {
    Text = "血ノ鎖・ヘロットは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「<DerivativeCardKeywords_65:鮮血の鎖>」を1枚手札に追加する。血ノ鎖・ヘロットの指令カードは「<RetainIconKeywords:保持>」を獲得。この戦闘中、ターン開始時に血ノ鎖・ヘロットの基礎ダメージが[Arg2]%増加する。狂気爆発「呪縛の鎖」を発動後、手札にある「血ノ鎖・ヘロット」の異なる指令カードに50点の<TempPowerKeywords:一時的な強化>を付与する。"
  },
  Skill_61123_EffectNameList = {
    Text = "狂気,ダメージ増加"
  },
  Skill_61123_Name = {
    Text = "復讐の誓い"
  },
  Skill_61124_AwakerSkillBackgroundStory = {
    Text = "クロト、クロト、運命の糸を手繰る女神よ。\nその糸は、いずこより紡がれたのか。\n\nたとえ枷を砕こうとも、哀れなデロス人よ。\n運命の鎖からは逃れられぬ。"
  },
  Skill_61124_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食>：血ノ鎖・ヘロットの指令カードを1枚引き、手札にある血ノ鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血ノ鎖・ヘロットがアクティブダメージを与えた後、[Arg2]%の<BleedingIconKeywords:出血>を付与する。<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_61124_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。"
  },
  Skill_61124_EffectNameList = {
    Text = "ダメージ,出血割合"
  },
  Skill_61124_Name = {
    Text = "呪縛の鎖"
  },
  Skill_61124_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札の血鎖・ヘロットの指令カードの行動力消費を1減少させる。】本ターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。血鎖・ヘロットのクリティカルダメージが35%上昇し、一時的な手札上限+2、「恨意の発散」と「鮮血の鎖」を1枚ずつ手札に加え、それらの行動力消費を-1する。"
  },
  Skill_61124_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。血鎖・ヘロットのクリティカルダメージが35%アップし、一時的手札上限+2、「恨意の発散」と「鮮血の鎖」を1枚ずつ手札に加え、それらの行動力消費を-1する。"
  },
  Skill_61124_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2%"
  },
  Skill_61124_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:捕食>：血ノ鎖・ヘロットの指令カードを1枚引き、手札にある血ノ鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血ノ鎖・ヘロットがアクティブダメージを与えた後、[Arg2]%の<BleedingIconKeywords:出血>を付与する。<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_61124_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。"
  },
  Skill_61124_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。手札にある異なる自身の指令カード1枚ごとに「一時的強化」を50スタック付与し、ターン終了時または発射後に解除する。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札の血鎖・ヘロットの指令カードの行動力消費を1減少させる。】本ターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。血鎖・ヘロットのクリティカルダメージが35%上昇し、一時的な手札上限+2、「恨意の発散」と「鮮血の鎖」を1枚ずつ手札に加え、それらの行動力消費を-1する。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。血鎖・ヘロットのクリティカルダメージが35%アップし、一時的手札上限+2、「恨意の発散」と「鮮血の鎖」を1枚ずつ手札に加え、それらの行動力消費を-1する。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：血鎖・ヘロットの指令カードを1枚ドローし、手札にある血鎖・ヘロットの指令カードの行動力消費を1減少させる。】このターン、血鎖・ヘロットがアクティブダメージを与えた時、[Arg2]%の<BleedingIconKeywords:出血>を付与する。対象のシールドを破壊し、<Damage:[Damage:Arg1]>ポイントのダメージを与え、対象がシールドを獲得できない状態にする。この効果は1ターン持続する。血鎖・ヘロットのクリティカルダメージが35%アップし、一時的手札上限+2、「恨意の発散」と「鮮血の鎖」を1枚ずつ手札に加え、それらの行動力消費を-1する。手札にある異なる自身の指令カード1枚ごとに「一時的強化」を50スタック付与し、ターン終了時または発射後に解除する。"
  },
  Skill_61125_Desc = {
    Text = "血ノ鎖・ヘロットの基本指令カードを1枚選び、手札に追加。"
  },
  Skill_61125_Name = {
    Text = "不定形態・血ノ鎖"
  },
  Skill_61126_AwakerSkillBackgroundStory = {
    Text = "耐え忍べ。復讐の血が、すべての苦しみを洗い流す。"
  },
  Skill_61126_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_61126_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の<BleedingIconKeywords:出血>を[Arg3]%発動。"
  },
  Skill_61126_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。血ノ鎖・ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_61126_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。血ノ鎖・ヘロットは<Energy:[Energy:Arg2]>狂気を獲得。すべての敵の<BleedingIconKeywords:出血>を[Arg3]%発動。"
  },
  Skill_61126_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_61126_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_61535_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ランダムにカード1枚を凍結する。"
  },
  Skill_61535_Name = {Text = "氷の棘"},
  Skill_61536_Desc = {
    Text = "ターン終了時に<Block:[Block:Arg1]>点の<CardKeyWord:フロストシールド>と[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_61536_Name = {
    Text = "凍てつく冷気"
  },
  Skill_61537_Desc = {
    Text = "すべての覚醒体は10狂気を失う。"
  },
  Skill_61537_Name = {Text = "呪い"},
  Skill_62216_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_62216_Name = {
    Text = "終わり……"
  },
  Skill_62217_Desc = {
    Text = "[Arg1]点の<ReinforcePVEKeywords:堅固>を獲得。"
  },
  Skill_62217_Name = {
    Text = "深淵からの注視"
  },
  Skill_62218_Desc = {
    Text = "それはあなたを見ている。「症状」カードを1枚あなたの山札に永久に加える。"
  },
  Skill_62218_Name = {
    Text = "凝視-カウントダウン：1"
  },
  Skill_62221_Desc = {
    Text = "自身は「隠密」状態になり、数多の世界の眼差しを号令し戦闘に参加させる。"
  },
  Skill_62221_Name = {
    Text = "無数の世界の目"
  },
  Skill_62305_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[Arg1]点の<StrongEffectKeywords:特効>を獲得。ライフを失うたび、現在のライフが[Arg2]%未満の場合、<ReinforceKeywords:堅固>と<StrengthenKeywords:強化>を獲得。"
  },
  Skill_62305_Name_1 = {
    Text = "深紅に沈む"
  },
  Skill_62306_Desc_1 = {
    Text = "任意の対象に<TauntKeywords:挑発>と[Arg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  Skill_62306_Name_1 = {
    Text = "銀嶺の覚悟"
  },
  Skill_62306_UnknownName = {
    Text = "銀嶺の覚悟"
  },
  Skill_62311_Desc = {
    Text = "1点の<FragileIconKeywords:脆弱>を付与する。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札にある凍結したカード1枚につき追加でダメージを1回与え、凍結したカードを除外する。"
  },
  Skill_62311_Name = {
    Text = "氷の囁き"
  },
  Skill_62312_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札にある凍結したカード1枚につきダメージが[Arg3]増加する。1点の<WeaknessIconKeywords:虚弱>を付与。"
  },
  Skill_62312_Name = {Text = "霜炎"},
  Skill_62314_Desc = {
    Text = "「氷雪の霊」を2体召喚し、すべての味方が[Arg1]点の<CardKeyWord:フロストシールド>を獲得する。"
  },
  Skill_62314_Name = {
    Text = "氷雪の霊"
  },
  Skill_62315_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札にある凍結したカード1枚につきダメージが[Arg3]増加する。3点の<WeaknessIconKeywords:虚弱>を付与。"
  },
  Skill_62315_Name = {
    Text = "極寒の霜炎"
  },
  Skill_62316_Desc = {
    Text = "3点の<FragileIconKeywords:脆弱>を付与する。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札にある凍結したカード1枚につき追加でダメージを1回与え、凍結したカードを除外する。"
  },
  Skill_62316_Name = {
    Text = "氷の怒り"
  },
  Skill_65341_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札の一番上の2枚の指令カードを凍結。"
  },
  Skill_65341_Name = {Text = "霜刃"},
  Skill_65357_Desc = {
    Text = "覚醒体を1体選択し、その覚醒体の指令カードを2枚引く。"
  },
  Skill_65357_Name = {
    Text = "銀嶺の覚悟"
  },
  Skill_65369_Desc = {
    Text = "調査隊員を1名失い、カードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。最大ライフの10%([Arg1])を失う。"
  },
  Skill_65369_Name = {Text = "拘束"},
  Skill_65370_Desc = {
    Text = "調査隊員を2名失い、カードを[Arg1]枚引き、[Arg1]点の行動力を獲得する。すべての覚醒体が[Arg2]点の狂気を獲得する。"
  },
  Skill_65370_Name = {Text = "説得"},
  Skill_65371_Desc = {
    Text = "調査隊員を5名失い、すべての覚醒体は50点の狂気を獲得し、最大ライフの30%([Arg1])を回復する。カードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。"
  },
  Skill_65371_Name = {Text = "無視"},
  Skill_65372_Desc = {
    Text = "調査隊の人数が0の場合、このカードは<DerivativeCardKeywords_9:「よろよろ」>に変化する。ターン終了時にこのカードがまだ手札にある場合、次のターン開始時にすべての敵が[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_65372_Name = {Text = "疑念"},
  Skill_65393_Desc = {
    Text = "[Arg1]点の行動力を獲得し、覚醒体を1体選択し[Arg2]狂気を獲得する。"
  },
  Skill_65393_Name = {
    Text = "人間性の輝き"
  },
  Skill_65451_Desc = {
    Text = "[Arg1]点の行動力を獲得し、覚醒体を1体選択し[Arg2]狂気を獲得する。"
  },
  Skill_65451_Name = {
    Text = "微かな人間性の輝き"
  },
  Skill_65452_Desc = {
    Text = "[Arg1]点の行動力を獲得し、覚醒体を1体選択し[Arg2]狂気を獲得する。"
  },
  Skill_65452_Name = {
    Text = "きらめく人間性の輝き"
  },
  Skill_65453_Desc = {
    Text = "[Arg1]点の行動力を獲得し、覚醒体を1体選択し[Arg2]狂気を獲得する。"
  },
  Skill_65453_Name = {
    Text = "ほの暗い人間性の輝き"
  },
  Skill_65454_Desc = {
    Text = "[Arg1]点の行動力を獲得し、すべての覚醒体が[Arg2]狂気を獲得する。"
  },
  Skill_65454_Name = {
    Text = "まばゆい人間性の輝き"
  },
  Skill_65462_Desc = {
    Text = "カードを[Arg2]枚引き、[Arg2]点の行動力を獲得する。最大ライフの20%([Arg1])を失う。すべての覚醒体は20点の狂気を失う。"
  },
  Skill_65462_Name = {Text = "協力"},
  Skill_65545_Desc = {
    Text = "最大ライフを15％増加し、[Arg1]点の<ReinforcePVEKeywords:加固>と[Arg2]点の<PowerIconKeywords:力量>を獲得する。"
  },
  Skill_65545_Name = {
    Text = "急冷復活"
  },
  Skill_65546_Desc = {
    Text = "[Arg1]点のフロストシールドを獲得し、<DerivativeCardKeywords_74:「警鐘」>を1枚手札に追加する。"
  },
  Skill_65546_Name = {Text = "警備"},
  Skill_65547_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、手札の凍結されたカードをすべて除外する。"
  },
  Skill_65547_Name = {
    Text = "氷砕きの猛打"
  },
  Skill_65548_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_65548_Name = {
    Text = "骨を刺す一撃"
  },
  Skill_65549_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ガードされなかったダメージを1回与えるたび、山札の未凍結の指令カード1枚をランダムに凍結する。"
  },
  Skill_65549_Name = {
    Text = "吹雪の一撃"
  },
  Skill_65550_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<SlowIconKeywords:鈍化>を付与する。"
  },
  Skill_65550_Name = {Text = "霜の歌"},
  Skill_65551_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ターン終了前に手札1枚につき追加で1回ダメージを与える（最大10回）。"
  },
  Skill_65551_Name = {
    Text = "氷砕きの飛刃"
  },
  Skill_66041_Desc = {
    Text = "テスト用カード"
  },
  Skill_66041_Name = {
    Text = "スキル@テストカードA"
  },
  Skill_66042_Desc = {
    Text = "テスト用のカード"
  },
  Skill_66042_Name = {
    Text = "スキル@テストカードB"
  },
  Skill_66043_Desc = {
    Text = "テスト用のカード"
  },
  Skill_66043_Name = {
    Text = "スキル@テストカードC"
  },
  Skill_66282_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_66282_Name = {
    Text = "原初の混沌の核"
  },
  Skill_66283_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_66283_Name = {
    Text = "原初の混沌の核"
  },
  Skill_66284_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_66284_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_66285_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_66285_Name = {
    Text = "原初の混沌の種"
  },
  Skill_66286_Desc = {
    Text = "それは困惑している。[Arg1]点の一時的な「怨恨の鎖」を獲得する。"
  },
  Skill_66286_Name = {
    Text = "束縛-カウントダウン：4"
  },
  Skill_66287_Desc = {
    Text = "それは好奇心を抱いている。[Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_66287_Name = {
    Text = "強化-カウントダウン：2"
  },
  Skill_66288_Desc = {
    Text = "それは困惑している。[Arg1]点の一時的な「怨恨の鎖」を獲得する。"
  },
  Skill_66288_Name = {
    Text = "束縛-カウントダウン：3"
  },
  Skill_66289_Desc = {
    Text = "[Arg1]点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_66289_Name = {
    Text = "白痴盲目の壁"
  },
  Skill_66290_Desc = {
    Text = "敵に「至高の意志の威圧」を付与する：「至高の意志の威圧」：指令カードを1枚使用した時、その覚醒体の最も行動力が低い指令カード1枚を捨てる。"
  },
  Skill_66290_Name = {
    Text = "至高の意志の権限"
  },
  Skill_66291_Desc = {
    Text = "「融蝕の核」を山札のランダムな位置に追加する。"
  },
  Skill_66291_Name = {
    Text = "万物忘却の影"
  },
  Skill_66292_Desc = {
    Text = "「古今を貫く鎖」を獲得する：「古今を貫く鎖」：毎ターン終了時に1点の「怨恨の鎖」を獲得する。"
  },
  Skill_66292_Name = {
    Text = "古今を貫く鎖"
  },
  Skill_66296_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_66296_Name = {
    Text = "原初の混沌の種"
  },
  Skill_66298_Desc = {
    Text = "自身は「隠密」状態になり、数多の世界の眼差しを号令し戦闘に参加させる。"
  },
  Skill_66298_Name = {
    Text = "無数の世界の目"
  },
  Skill_66300_Desc = {
    Text = "[Arg1]点の<ReinforcePVEKeywords:堅固>を獲得し、すべての敵のバフ状態を解除し、自身のすべてのデバフ状態を解除する。"
  },
  Skill_66300_Name = {
    Text = "真・深淵からの注視"
  },
  Skill_66301_Desc = {
    Text = "すべての覚醒体が狂気を半分失い、相手は行動力上限5点と手札上限10点を失う。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。真の原初が…まもなく到来する！"
  },
  Skill_66301_Name = {
    Text = "「世界崩壊の融蝕」"
  },
  Skill_66302_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。全覚醒体が100%狂気を失う。守秘者の行動力上限-5、手札上限-10。"
  },
  Skill_66302_Name = {
    Text = "「世界崩壊の融蝕」"
  },
  Skill_66303_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_66303_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_66304_Desc = {
    Text = "自身の位置を移動させることで、「眼差し」の配列を変える。"
  },
  Skill_66304_Name = {
    Text = "幻影転身"
  },
  Skill_66349_AwakerSkillBackgroundStory = {
    Text = "彼女は過去、現在、未来を知っている。\nすべてがどのように生まれ、どのように消えていくかを知っている。\n彼女の耳元には「彼の神格」の呼吸が響く。"
  },
  Skill_66349_Desc_0 = {
    Text = "手札にあるとき、山札の一番上のカードが指令カードなら、そのコピーに変わる。使用後に元に戻り、<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_66349_Desc_1 = {
    Text = "手札にあるとき、山札の一番上のカードが指令カードなら、その行動力消費-1のコピーに変わる。使用後に元に戻り、<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_66349_EffectNameList = {Text = "狂気"},
  Skill_66349_Name = {
    Text = "万物の理を知る"
  },
  Skill_66350_AwakerSkillBackgroundStory = {
    Text = "シルバーキーの扉を越え、人類は「彼の神格」の玉座の前にひれ伏し、究極の答えを探求する。\n\n彼女は門番であり、踏みとどまらせ、注意喚起し、警告する役割を担う。\n伝えないことこそが彼女の慈悲。"
  },
  Skill_66350_BattleDesc_0 = {
    Text = "タヴィは <Energy:[Energy:Arg1]> 点の狂気を獲得する。「<DerivativeCardKeywords_67:シルバーキーの暁光>」を 1 枚手札に加える。タヴィは行動力を 1 点消費するたびに、キーチャージの 50% のキーエネルギーを獲得する。"
  },
  Skill_66350_BattleDesc_15 = {
    Text = "タヴィは <Energy:[Energy:Arg1]> 点の狂気を獲得する。「<DerivativeCardKeywords_67:シルバーキーの暁光>」を 1 枚手札に加える。タヴィは行動力を 1 点消費するたびに、キーチャージの 50% のキーエネルギーを獲得する。タヴィが狂気解放を発動した後、全ての覚醒体の今ターンの指令カードの最終ダメージが [Arg2]％ アップし、次に発射する他の覚醒体の指令カードも 1 回追加で発動できるようになる。"
  },
  Skill_66350_Desc_0 = {
    Text = "タヴィは <Energy:[Energy:Arg1]> 点の狂気を獲得する。「<DerivativeCardKeywords_67:シルバーキーの暁光>」を 1 枚手札に加える。タヴィは行動力を 1 点消費するたびに、キーチャージの 50% のキーエネルギーを獲得する。"
  },
  Skill_66350_Desc_15 = {
    Text = "タヴィは <Energy:[Energy:Arg1]> 点の狂気を獲得する。「<DerivativeCardKeywords_67:シルバーキーの暁光>」を 1 枚手札に加える。タヴィは行動力を 1 点消費するたびに、キーチャージの 50% のキーエネルギーを獲得する。タヴィが狂気解放を発動した後、全ての覚醒体の今ターンの指令カードの最終ダメージが [Arg2]％ アップし、次に発射する他の覚醒体の指令カードも 1 回追加で発動できるようになる。"
  },
  Skill_66350_EffectNameList = {Text = "狂気"},
  Skill_66350_Name = {
    Text = "銀の門を超えて"
  },
  Skill_66351_Desc = {
    Text = "行動力不足時は<Posse:500>キーエネルギーを消費して発動可能。2回<Damage:[Damage:Arg1]>ダメージを与え、タヴィが<Energy:[Energy:Arg2]>狂気を獲得。カードを1枚引く。<DerivativeCardKeywords_76:「四翼の芽生え」>を山札のランダムな位置に追加する。"
  },
  Skill_66351_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_66351_Name = {
    Text = "双翼の羽ばたき"
  },
  Skill_66351_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_66352_AwakerSkillBackgroundStory = {
    Text = "彼女に道を塞ぐつもりはなかった。\nしかし、次元の彼方へと越えた者は狂気に飲まれた。"
  },
  Skill_66352_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_66352_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気、[Arg3]%のクリティカル率とクリティカルダメージを獲得、最大10回まで重ね掛け可能([Arg4]/10)。"
  },
  Skill_66352_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。タヴィは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_66352_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。タヴィは<Energy:[Energy:Arg2]>狂気、[Arg3]%のクリティカル率とクリティカルダメージを獲得、最大10回まで重ね掛け可能。"
  },
  Skill_66352_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_66352_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_66353_Desc = {
    Text = "行動力不足時は<Posse:500>キーエネルギーを消費して発動可能。6回<Damage:[Damage:Arg1]>点の<PunctureDamagewords:刺突ダメージ>を与える。6種類の「追憶」から1つを選んでその効果を発動可能。この「追憶」は今回の探索中に再選択不可。"
  },
  Skill_66353_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_66353_Name = {
    Text = "六翼の解放"
  },
  Skill_66353_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_66354_AwakerSkillBackgroundStory = {
    Text = "彼女に害意はなかった。\nしかし、真理の門に亀裂が入った。"
  },
  Skill_66354_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_66354_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気、[Arg3]%のクリティカル率とクリティカルダメージを獲得し、最大10回まで重ねられる([Arg4]/10)。"
  },
  Skill_66354_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。タヴィは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_66354_Desc_3 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。タヴィは<Energy:[Energy:Arg2]>狂気、[Arg3]%のクリティカル率とクリティカルダメージを獲得し、最大10回まで重ねられる。"
  },
  Skill_66354_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_66354_Name = {Text = "攻撃"},
  Skill_66354_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_66355_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを4回与え、カードを1枚引く。ダメージを1回与えるたび、対象から[Exhaustion:Arg2]点の<ExhaustionIconKeywords:力>を一時的に減少させ、[Power:Arg2]点の一時的な<PowerIconKeywords:力>を獲得。<DerivativeCardKeywords_77:「六翼の解放」>を山札に追加する。行動力が不足している場合、<Posse:500>キーエネルギーを消費して発動可能。"
  },
  Skill_66355_Desc = {
    Text = "行動力不足時は<Posse:500>キーエネルギーを消費して発動可能。4回<Damage:[Damage:Arg1]>ダメージを与え、カードを1枚引く。1回のダメージごとに対象から[Arg2]点の一時的な<TouquKeywords:奪う><PowerIconKeywords:力>を奪う。<DerivativeCardKeywords_77:「六翼満開」>を山札のランダムな位置に追加する。"
  },
  Skill_66355_EffectNameList = {
    Text = "ダメージ,力の吸収"
  },
  Skill_66355_Name = {
    Text = "四翼の芽生え"
  },
  Skill_66355_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_66356_AwakerSkillBackgroundStory = {
    Text = "一から万物が生まれる。\n彼女は時間と空間を支配し、その指先からは秩序の世界が流れ出す。\n\n万物は一へと還る。\n無機物と有機物が混沌と一体となり、最期は「彼の神格」の吐息の中で虚無へと融ける。"
  },
  Skill_66356_Desc_0 = {
    Text = "このターン中、自身の指令カードの最終ダメージが15%増加する。<Posse:[Arg1]>キーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発現>5枚、最大3枚を選び手札に追加し、タヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を獲得する。次に使用するタヴィの指令カードは2回発動する。"
  },
  Skill_66356_Desc_2 = {
    Text = "このターン中、自身の指令カードの最終ダメージが15%増加する。<Posse:[Arg1]>キーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発現>5枚、最大3枚を選び、<DepleteIconKeywords:除外>、<PrepareKeypvewords1:準備1>、<RetainIconKeywords:保持>を付与して手札に追加する。これらはタヴィのカードとして扱う。次に使用するタヴィの指令カードは2回発動する。"
  },
  Skill_66356_EffectNameList = {
    Text = "キーエネルギー"
  },
  Skill_66356_Name = {
    Text = "万物は一つに"
  },
  Skill_66356_OverLimitUtlSkillDesc_0 = {
    Text = "タヴィが与えるダメージ、シールド、ライフ回復が一時的に [Arg2]% 上昇する。行動力を3点と <Posse:[Arg1]> 点のキーエネルギーを得る。現在の界域のスキルカードから<FaxianKeywords:発見> 10枚し、最大3枚を選んで手札に加え、タヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:消耗>と<RetainIconKeywords:保留>を得る。次に打ち出すタヴィの指令カードが2回発動する。"
  },
  Skill_66356_OverLimitUtlSkillDesc_2 = {
    Text = "タヴィが与えるダメージ・シールド・ライフ回復を一時的に[Arg2]%アップ。行動力を3点と<Posse:[Arg1]>点のキーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発見>10枚し、最大3枚を選んで手札に加えタヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:消耗>・<PrepareKeypvewords1:準備1>・<RetainIconKeywords:保留>を得る。次に発射するタヴィの指令カードが2回発動する。"
  },
  Skill_66356_tempBattleDesc_1 = {
    Text = "このターン中、自身の指令カードの最終ダメージが15%増加する。<Posse:[Arg1]>キーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発現>5枚、最大3枚を選び、<DepleteIconKeywords:除外>、<PrepareKeypvewords1:準備1>、<RetainIconKeywords:保持>を付与して手札に追加する。これらはタヴィのカードとして扱う。次に使用するタヴィの指令カードは2回発動する。"
  },
  Skill_66356_tempBattleDesc_2 = {
    Text = "このターン中、自身の指令カードの最終ダメージが15%増加する。<Posse:[Arg1]>キーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発現>5枚、最大3枚を選び手札に追加し、タヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を獲得する。次に使用するタヴィの指令カードは2回発動する。"
  },
  Skill_66356_tempBattleDesc_3 = {
    Text = "このターン、すべての覚醒体の指令カードの最終ダメージが15%増加する。<Posse:[Arg1]>キーエネルギーを獲得。<FaxianKeywords:発現>：現在の界域のスキルカード5枚から3枚を選び、<DepleteIconKeywords:除外>、<PrepareKeypvewords1:準備1>、<RetainIconKeywords:保持>を付与して手札に追加する。これらはタヴィのカードとして扱う。次に使用するタヴィの指令カードと他の覚醒体の指令カードはそれぞれ2回発動する。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_1 = {
    Text = "タヴィが与えるダメージ・シールド・ライフ回復を一時的に[Arg2]%アップ、このターン中の自身の指令カードの最終ダメージ+15%。行動力を3点と<Posse:[Arg1]>点のキーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発見>10枚し、最大3枚を選んで手札に加えタヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:消耗>・<RetainIconKeywords:保留>を得る。次に発射するタヴィの指令カードが2回発動する。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_2 = {
    Text = "タヴィが与えるダメージ・シールド・ライフ回復を一時的に[Arg2]%アップ、このターン中の自身の指令カードの最終ダメージ+15%。行動力を3点と<Posse:[Arg1]>点のキーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発見>10枚し、最大3枚を選んで手札に加えタヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:消耗>・<RetainIconKeywords:保留>を得る。次に発射するタヴィの指令カードが2回発動する。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_3 = {
    Text = "タヴィが与えるダメージ・シールド・ライフ回復を一時的に[Arg2]%アップ、すべての覚醒体のこのターンの指令カードの最終ダメージが15%アップ。行動力を3点と<Posse:[Arg1]>点のキーエネルギーを獲得。現在の界域のスキルカードから<FaxianKeywords:発見>10枚し、最大3枚を選んで手札に加えタヴィのカードとして扱う。これらのカードは<DepleteIconKeywords:消耗>・<PrepareKeypvewords1:準備1>・<RetainIconKeywords:保留>を得る。次に発射するタヴィの指令カードと他の覚醒体の指令カードがそれぞれ2回発動する。"
  },
  Skill_66357_AwakerSkillBackgroundStory = {
    Text = "それは空洞、無限の時空の中にある、唯一の小さな裂け目。\n\n「守秘者」と呼ばれる存在——\nそれは、すべての問の答えであり、すべての扉を開く鍵。\nタヴィは六翼を鳴らし、その唯一なるものへと飛翔した。"
  },
  Skill_66357_Desc_0 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。<DerivativeCardKeywords_75:「双翼の羽ばたき」>を山札に加える。"
  },
  Skill_66357_Desc_1 = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>と1枚の<DerivativeCardKeywords_4:「啓示」>を獲得。<DerivativeCardKeywords_75:「双翼の羽ばたき」>を山札に加える。"
  },
  Skill_66357_EffectNameList = {Text = "力"},
  Skill_66357_Name = {
    Text = "時を貫く翼"
  },
  Skill_66357_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_66402_Desc = {
    Text = "覚醒体を1体選択し、<Energy:[Energy:Arg1]>狂気を獲得する。"
  },
  Skill_66402_Name = {
    Text = "無邪気な贈り物"
  },
  Skill_66403_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。"
  },
  Skill_66403_Name = {
    Text = "極夜の微光"
  },
  Skill_66404_Desc = {
    Text = "すべての手札を捨て、捨てた枚数+3枚のカードを引く。"
  },
  Skill_66404_Name = {
    Text = "異形の心臓"
  },
  Skill_66405_Desc = {
    Text = "最後列の敵に対象の最大ライフの [Arg1]% の<FixedDamage:純粋ダメージ>を与え、このダメージは自身の最大ライフの 300% を下回らない。"
  },
  Skill_66405_Name = {
    Text = "代行者の裁き"
  },
  Skill_66406_Desc = {
    Text = "1点の一時的な<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_66406_Name = {Text = "蜂蜜酒"},
  Skill_66407_Desc = {
    Text = "3つの「キーオーダー」から、1つを選んで直ちに発動する。"
  },
  Skill_66407_Name = {
    Text = "理想郷の帳"
  },
  Skill_66444_Desc_1 = {
    Text = "覚醒体を1体選択し、そのライフを前回のターン開始時の状態に戻し、<PVPWeaknessKeywords:虚弱>と<PVPVulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_66444_Name_1 = {
    Text = "超越と回帰"
  },
  Skill_66445_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_66445_Name_1 = {Text = "攻撃"},
  Skill_66446_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージと [Arg2] <PVPfengsuoKeywords:バーストロック>を与える。"
  },
  Skill_66446_Name_1 = {
    Text = "万物は一つに"
  },
  Skill_66448_Desc_1 = {
    Text = "すべての味方に[Arg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  Skill_66448_Name_1 = {
    Text = "時の狭間への潜伏"
  },
  Skill_66449_Desc_1 = {
    Text = "<DelayKeywords:レイテンシ>：味方1体に <Energy:[Energy:Arg1]> 狂気を付与。"
  },
  Skill_66449_Name_1 = {
    Text = "全一継承"
  },
  Skill_66458_Desc = {
    Text = "現在のライフとシールドが、前のターン終了時の状態に戻る。"
  },
  Skill_66458_Name = {
    Text = "過去の響き"
  },
  Skill_66498_BattleDesc_1 = {
    Text = "味方1名を選択し、敵の手札の中で行動力消費が最も高いスキルカード [Arg1] 枚をコピーさせ、その行動力消費を -[Arg2] にする。相手の手札には現在 [Arg3] 枚のスキルがある。"
  },
  Skill_66498_Desc_1 = {
    Text = "味方1体を選択し、敵の手札から算力消費が最も高いスキルカードを[Arg1]枚複製させ、その算力消費を–[Arg2]する。"
  },
  Skill_66498_Name_1 = {
    Text = "扉の彼方の真実"
  },
  Skill_66498_UnknownName = {
    Text = "扉の彼方の真実"
  },
  Skill_66499_Desc = {
    Text = "ランダムな3つの「キーオーダー」を<FaxianKeywords:発見>し、その中から1つを選びその効果を発動し、<Posse:[Arg1]>点のキーエネルギーを獲得する。"
  },
  Skill_66499_Name = {
    Text = "扉の彼方の真実"
  },
  Skill_66520_Desc = {
    Text = "「<Qunxingzhijiu:星々の酒>」"
  },
  Skill_66520_Name = {
    Text = "星々の酒"
  },
  Skill_66525_Desc = {
    Text = "「<Zhanxindeqianbao:新品の財布>」"
  },
  Skill_66525_Name = {
    Text = "新品の財布"
  },
  Skill_66526_Desc = {
    Text = "「<Wushangrongchong:無上の栄誉>」"
  },
  Skill_66526_Name = {
    Text = "無上の栄誉"
  },
  Skill_66527_Desc = {
    Text = "「<Canquemiankong:欠けた顔>」"
  },
  Skill_66527_Name = {
    Text = "欠けた顔"
  },
  Skill_66528_Desc = {
    Text = "「<Xingdaozhihai:行道の骸>」"
  },
  Skill_66528_Name = {
    Text = "行道の骸"
  },
  Skill_66529_Desc = {
    Text = "「<Chunzhiji:春の祭り>」"
  },
  Skill_66529_Name = {
    Text = "春の祭り"
  },
  Skill_66531_Desc = {
    Text = "「<Jingmijishiqi:精密タイマー>」"
  },
  Skill_66531_Name = {
    Text = "精密タイマー"
  },
  Skill_66532_Desc = {
    Text = "「<Huaibiaojing:懐中時計鏡β>」"
  },
  Skill_66532_Name = {
    Text = "懐中時計鏡β"
  },
  Skill_66533_Desc = {
    Text = "「<Shiluozhimei:失われた美>」"
  },
  Skill_66533_Name = {
    Text = "失われた美"
  },
  Skill_66534_Desc = {
    Text = "「<Tongxunshebei:通信機β>」"
  },
  Skill_66534_Name = {
    Text = "通信機β"
  },
  Skill_66535_Desc = {
    Text = "「<Etong:悪童>」"
  },
  Skill_66535_Name = {Text = "悪童"},
  Skill_66536_Desc = {
    Text = "「<Biansejushufu:変色拘束服β>」"
  },
  Skill_66536_Name = {
    Text = "変色拘束服β"
  },
  Skill_66537_Desc = {
    Text = "「<Renyuleizhu:人魚の涙>」"
  },
  Skill_66537_Name = {
    Text = "人魚の涙"
  },
  Skill_66538_Desc = {
    Text = "「<Kuailechangpian:ハッピーレコード>」"
  },
  Skill_66538_Name = {
    Text = "ハッピーレコード"
  },
  Skill_66721_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身が<PVPProtectiveKeywords:バリア>を持っていない場合は[Arg1]点の<PVPProtectiveKeywords:バリア>を獲得し、そうでない場合は<StrengthenKeywords:強化>を獲得する。"
  },
  Skill_66721_Name_1 = {
    Text = "隠世の転輪"
  },
  Skill_66891_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：他の味方の覚醒体が死亡した後、<Block:[Block:Arg1]>点のシールドを獲得し、その行動力消費が最も低い「スキル」を手札に追加する。"
  },
  Skill_66891_Name_1 = {
    Text = "純銀の初心"
  },
  Skill_67110_Desc = {
    Text = "この蒼白の笛の音の中で、再び安らかに眠りなさい…"
  },
  Skill_67110_Name = {
    Text = "永遠の安眠"
  },
  Skill_67168_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、<HeavyInjuryKeywords:重傷>を2ターン付与する。"
  },
  Skill_67168_Name = {
    Text = "重傷の奔走"
  },
  Skill_67169_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。自身のライフ上限を[Arg3]%増加、守秘者のライフ上限を[Arg3]%減少。"
  },
  Skill_67169_Name = {
    Text = "等価交換"
  },
  Skill_67170_Desc = {
    Text = "「天才の脳缶の分体」が「知性の分離」を発動すると、<TouquKeywords:永久的に>5%の<PowerIconKeywords:力>を奪う。ターン終了時に「天才の脳缶の分体」を1体召喚。"
  },
  Skill_67170_Name = {
    Text = "霊魂と肉体@1離"
  },
  Skill_67171_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Power:Arg2]点の<PowerIconKeywords:力>を獲得し、状態「不定の壁」を獲得。「不定の壁」：行動力を消費すると<Block:[Block:Arg3]>点のシールドと、3点の一時的な<ReinforcePVEKeywords:堅固>を獲得。"
  },
  Skill_67171_Name = {
    Text = "不定の壁"
  },
  Skill_67172_Desc = {
    Text = "すべての終末を除去し、プレイヤーのライフ上限を1にする。"
  },
  Skill_67172_Name = {
    Text = "虚無終結"
  },
  Skill_67173_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:一時的な力>と<Block:[Block:Arg2]>点のシールドを獲得。"
  },
  Skill_67173_Name = {
    Text = "七つの技、継承した美徳"
  },
  Skill_67174_Desc = {
    Text = "ターン終了時、[Power:Arg1]点の<PowerIconKeywords:力>を獲得。シールドが破壊された場合、このターン中のみ獲得する<ReinforcePVEKeywords:堅固>が35点から75点に増加。"
  },
  Skill_67174_Name = {
    Text = "騎士の熱意"
  },
  Skill_67175_Desc = {
    Text = "[Arg1]ダメージを[Arg2]回与え、プレイヤーの保持カードを捨てる。"
  },
  Skill_67175_Name = {
    Text = "弱点攻撃"
  },
  Skill_67176_Desc = {
    Text = "「よろよろ」、「窒息」、「珊瑚寄生」、「冒涜的な幻想」、「奔放」から1枚選んで手札に追加、残りの4枚を捨て札に追加。"
  },
  Skill_67176_Name = {
    Text = "世界演繹法"
  },
  Skill_67177_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、<FragileIconKeywords:脆弱>を2ターン付与する。シールドが破壊された場合、「重傷の奔走」に変化：脆弱を付与しなくなり、代わりに重傷を付与する。"
  },
  Skill_67177_Name = {
    Text = "盾割りの突撃"
  },
  Skill_67178_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、同量の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_67178_Name = {
    Text = "終末狂想"
  },
  Skill_67180_Desc = {
    Text = "各ターン終了時に「天才の脳缶の分体」を召喚。[Arg1]ターン発動。"
  },
  Skill_67180_Name = {Text = "分離"},
  Skill_67181_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、その後の「女王の剣」のダメージ回数が1回増加。"
  },
  Skill_67181_Name = {
    Text = "女王の剣"
  },
  Skill_67182_Desc = {
    Text = "<Damage:[Damage:Arg1]>の<PunctureDamagewords:刺突ダメージ>を[Arg2]回与え、同量の<BleedingIconKeywords:出血>を付与し、<VulnerabilityIconKeywords:易傷>を1ターン付与する。シールドが破壊された場合、「激怒の槍」に変化：刺突ダメージと出血を与えなくなり、ダメージ回数が+1。"
  },
  Skill_67182_Name = {
    Text = "「刺突」の槍"
  },
  Skill_67183_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。"
  },
  Skill_67183_Name = {Text = "攻撃"},
  Skill_67184_Desc = {
    Text = "ドローフェイズ終了後、手札からランダムに3枚の指令カードを公開し、1枚を選んで「エコー」を刻印し、他のカードを捨てる。"
  },
  Skill_67185_Desc = {
    Text = "2ターンの<WeaknessIconKeywords:虚弱>を付与し、[Poison:Arg1]層の<IntoxicationIconKeywords:中毒>を付与する。"
  },
  Skill_67185_Name = {
    Text = "外界手術"
  },
  Skill_67186_Desc = {
    Text = "[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与する。ターン終了後、他の敵が[Power:Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_67186_Name = {
    Text = "宿命崩壊"
  },
  Skill_67187_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:永久的に盗み>、50％の<RetaliateIconKeywords:反撃>を除去し、5枚の「推演」を持たないカードに「推演」を付与。"
  },
  Skill_67187_Name = {
    Text = "攻勢演習"
  },
  Skill_67188_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。深淵の門を開き、毎ターン終了時に敵を最大2体まで補充する。"
  },
  Skill_67188_Name = {
    Text = "終点、真理と深淵の扉"
  },
  Skill_67189_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、自身に<VulnerabilityIconKeywords:易傷>を1ターン付与する。"
  },
  Skill_67189_Name = {
    Text = "「激怒」の槍"
  },
  Skill_67190_Desc = {
    Text = "2点の<WeaknessIconKeywords:虚弱>を付与し、[Arg2]点の<ReinforcePVEKeywords:堅固>を獲得する。"
  },
  Skill_67190_Name = {
    Text = "自滅改造"
  },
  Skill_67191_Desc = {
    Text = "ターン開始時、1点の終末を獲得する。プレイヤーがカードを使用するたび、[Arg1]点の<ReinforcePVEKeywords:堅固>を獲得する。致死ダメージを受けた後この状態を解除し、1ターンダメージを無効化し、ライフを15%回復し、行動予測は「虚無終結」に変化する。"
  },
  Skill_67191_Name = {
    Text = "魂の疫病"
  },
  Skill_67348_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の<PowerIconKeywords:力>と1点の終末を獲得する。他のすべての敵を撃破した場合、行動予測は「宿命崩壊」に変化する。"
  },
  Skill_67348_Name = {
    Text = "終末の呼び声"
  },
  Skill_67349_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の<PowerIconKeywords:力>と1点の終末を獲得する。他のすべての敵を撃破した場合、行動予測は「自滅改造」に変化する。"
  },
  Skill_67349_Name = {
    Text = "終末の呼び声"
  },
  Skill_67383_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。自身のライフ上限を[Arg3]%増加、守秘者のライフ上限を[Arg4]%減少。"
  },
  Skill_67383_Name = {
    Text = "等価交換"
  },
  Skill_67421_Desc = {
    Text = "<Damage:[Damage:Arg1]>の<PunctureDamagewords:刺突>ダメージを[AttackTimes:Arg2]回与える。このダメージは回避不可。"
  },
  Skill_67421_Name = {
    Text = "終わり……"
  },
  Skill_67431_Desc = {
    Text = "「<Heizhu:黒い蝋燭>」"
  },
  Skill_67431_Name = {
    Text = "黒い蝋燭"
  },
  Skill_67433_Desc = {
    Text = "「<Guishulimao:奇術のハット>」"
  },
  Skill_67433_Name = {
    Text = "奇術のハット"
  },
  Skill_67434_Desc = {
    Text = "「<Slbbujie:時の振り子・不潔>」"
  },
  Skill_67434_Name = {
    Text = "時の振り子・不潔"
  },
  Skill_67435_Desc = {
    Text = "「<Slbbumian:時の振り子・不眠>」"
  },
  Skill_67435_Name = {
    Text = "時の振り子・不眠"
  },
  Skill_67436_Desc = {
    Text = "「<Szeyunyishiniao:祝福・不運の儀式鳥>」"
  },
  Skill_67436_Name = {
    Text = "祝福・不運の儀式鳥"
  },
  Skill_67437_Desc = {
    Text = "「<Shishengchangji:声を失った蓄音機>」"
  },
  Skill_67437_Name = {
    Text = "声を失った蓄音機"
  },
  Skill_67438_Desc = {
    Text = "「<Yishengshoutixiang:医者のカバン>」"
  },
  Skill_67438_Name = {
    Text = "医者のカバン"
  },
  Skill_67441_Desc = {
    Text = "「<Slbyiyong:時の振り子・移涌>」"
  },
  Skill_67441_Name = {
    Text = "時の振り子・移涌"
  },
  Skill_67442_Desc = {
    Text = "「<Szxingdaozhihai:祝福・巡行道の骸>」"
  },
  Skill_67442_Name = {
    Text = "祝福・行道の骸"
  },
  Skill_67443_Desc = {
    Text = "「<Baiyahui:白いカラスのくちばし>」"
  },
  Skill_67443_Name = {
    Text = "白いカラスのくちばし"
  },
  Skill_67444_Desc = {
    Text = "「<Chansimanao:縞瑪瑙>」"
  },
  Skill_67444_Name = {Text = "縞瑪瑙"},
  Skill_67445_Desc = {
    Text = "「<Meilishunjian:美しい瞬間β>」"
  },
  Skill_67445_Name = {
    Text = "美しい瞬間β"
  },
  Skill_67446_Desc = {
    Text = "「<Yuanxingdianchi:原型電池>」"
  },
  Skill_67446_Name = {
    Text = "原型電池"
  },
  Skill_67447_Desc = {
    Text = "「<Guguaigouzhua:奇異な鉤爪>」"
  },
  Skill_67447_Name = {
    Text = "奇異な鉤爪"
  },
  Skill_67448_Desc = {
    Text = "「<Szemengbiaoxiang:祝福・悪夢の表象β>」"
  },
  Skill_67448_Name = {
    Text = "祝福・悪夢の表象β"
  },
  Skill_67449_Desc = {
    Text = "最大ライフの25%を回復し、ライフ上限を10%増加させる。"
  },
  Skill_67449_Name = {
    Text = "ドール・支援"
  },
  Skill_67451_Desc = {
    Text = "「<Chenzhonghuakuang:重い額縁>」"
  },
  Skill_67451_Name = {
    Text = "重い額縁"
  },
  Skill_67453_Desc = {
    Text = "「<Slbyuyi:時の振り子・羽翼>」"
  },
  Skill_67453_Name = {
    Text = "時の振り子・羽翼"
  },
  Skill_67454_Desc = {
    Text = "「<Dingxiangluopan:方位磁針>」"
  },
  Skill_67454_Name = {
    Text = "方位磁針"
  },
  Skill_67455_Desc = {
    Text = "「<Szguguaigouzhua:祝福・奇異な鉤爪>」"
  },
  Skill_67455_Name = {
    Text = "祝福・奇異な鉤爪"
  },
  Skill_67456_Desc = {
    Text = "「<Szyishimingke:祝福・意識の刻印β>」"
  },
  Skill_67456_Name = {
    Text = "祝福・意識の刻印β"
  },
  Skill_67457_Desc = {
    Text = "「<Jiajisiquanzhang:祭司の杖+>」"
  },
  Skill_67457_Name = {
    Text = "祭司の杖+"
  },
  Skill_67458_Desc = {
    Text = "「<Slbtoushe:時の振り子・投射>」"
  },
  Skill_67458_Name = {
    Text = "時の振り子・投射"
  },
  Skill_67462_Desc = {
    Text = "「<Qunmengzhige:群衆の歌>」"
  },
  Skill_67462_Name = {
    Text = "群衆の歌"
  },
  Skill_67463_Desc = {
    Text = "「<Jiaqunmengzhige:群衆の歌+>」"
  },
  Skill_67463_Name = {
    Text = "群衆の歌+"
  },
  Skill_67464_Desc = {
    Text = "「<Guaishecantui:怪蛇の抜け殻>」"
  },
  Skill_67464_Name = {
    Text = "怪蛇の抜け殻"
  },
  Skill_67466_Desc = {
    Text = "「<Aerkanajilu:アルカナ記録>」"
  },
  Skill_67466_Name = {
    Text = "アルカナ記録"
  },
  Skill_67467_Desc = {
    Text = "「<Xiushiliuyedao:錆びた柳葉刀>」"
  },
  Skill_67467_Name = {
    Text = "錆びた柳葉刀"
  },
  Skill_67468_Desc = {
    Text = "「<Jiaqunxingzhijiu:星々の酒+>」"
  },
  Skill_67468_Name = {
    Text = "星々の酒+"
  },
  Skill_67469_Desc = {
    Text = "「<Jiariyuelunpan:日月ルーレット+>」"
  },
  Skill_67469_Name = {
    Text = "日月ルーレット"
  },
  Skill_67470_Desc = {
    Text = "「不屈の戦意」を1枚手札に追加し、このターン「攻撃」の行動力消費が1減少する。"
  },
  Skill_67470_Name = {
    Text = "ロータン・支援"
  },
  Skill_67471_Desc = {
    Text = "「<Guhuofengling:惑わし風鈴>」"
  },
  Skill_67471_Name = {
    Text = "惑わし風鈴"
  },
  Skill_67472_Desc = {
    Text = "「<Shihengdetianping:不均衡な天秤>」"
  },
  Skill_67472_Name = {
    Text = "不均衡な天秤"
  },
  Skill_67473_Desc = {
    Text = "「<Szheizhu:祝福・黒い蝋燭>」"
  },
  Skill_67473_Name = {
    Text = "祝福・黒い蝋燭"
  },
  Skill_67474_Desc = {
    Text = "永続の力の50%に等しい一時的な力を獲得し、最大ライフの50%のシールドを獲得する。"
  },
  Skill_67474_Name = {
    Text = "オジール・支援"
  },
  Skill_67475_Desc = {
    Text = "「<Womendejia:我が家>」"
  },
  Skill_67475_Name = {Text = "我が家"},
  Skill_67476_Desc = {
    Text = "「<Eyunyishiniao:不運の儀式鳥>」"
  },
  Skill_67476_Name = {
    Text = "不運の儀式鳥"
  },
  Skill_67477_Desc = {
    Text = "「<Zaixiguangli:黄昏の中で>」"
  },
  Skill_67477_Name = {
    Text = "黄昏の中で"
  },
  Skill_67478_Desc = {
    Text = "「<Wwenmingzhiguang:文明の光>」"
  },
  Skill_67478_Name = {
    Text = "文明の光"
  },
  Skill_67479_Desc = {
    Text = "「<Szqisaimanzhiwen:祝福・ヤツメウナギのキス>」"
  },
  Skill_67479_Name = {
    Text = "祝福・ヤツメウナギのキス"
  },
  Skill_67480_Desc = {
    Text = "「<Jiatuisezhaopian:色褪せた写真+>」"
  },
  Skill_67480_Name = {
    Text = "色褪せた写真+"
  },
  Skill_67481_Desc = {
    Text = "「<Jierizhufu:祝祭の祝福>」"
  },
  Skill_67481_Name = {
    Text = "祝祭の祝福"
  },
  Skill_67482_Desc = {
    Text = "「<Slbyan:時の振り子・眼>」"
  },
  Skill_67482_Name = {
    Text = "時の振り子・眼"
  },
  Skill_67483_Desc = {
    Text = "「<Geyushan:鳩の羽扇>」"
  },
  Skill_67483_Name = {
    Text = "鳩の羽扇"
  },
  Skill_67484_Desc = {
    Text = "「<Slbyanhua:時の振り子・衍化>」"
  },
  Skill_67484_Name = {
    Text = "時の振り子・衍化"
  },
  Skill_67486_Desc = {
    Text = "「<Xiaoxiaoqiangbao:小さな産着>」"
  },
  Skill_67486_Name = {
    Text = "小さな産着"
  },
  Skill_67488_Desc = {
    Text = "「<Wanxianglingzhimiyi:万象霊知の秘儀>」"
  },
  Skill_67488_Name = {
    Text = "万象霊知の秘儀"
  },
  Skill_67490_Desc = {
    Text = "「<Slbshuangsheng:時の振り子・双生>」"
  },
  Skill_67490_Name = {
    Text = "時の振り子・双生"
  },
  Skill_67491_Desc = {
    Text = "「<Yixiangyoupiaojia:異国の切手帳>」"
  },
  Skill_67491_Name = {
    Text = "異国の切手帳"
  },
  Skill_67493_Desc = {
    Text = "「<Yinbaichaifenji:銀白の演算器>」"
  },
  Skill_67493_Name = {
    Text = "銀白の演算器"
  },
  Skill_67494_Desc = {
    Text = "「<Zhongsuo:重鎖>」"
  },
  Skill_67494_Name = {Text = "重鎖"},
  Skill_67495_Desc = {
    Text = "「<Beiyiwangzhezhixue:忘れられし者の血>」"
  },
  Skill_67495_Name = {
    Text = "忘れられし者の血"
  },
  Skill_67496_Desc = {
    Text = "「<Szchongqunyishi:祝福・虫群の意識>」"
  },
  Skill_67496_Name = {
    Text = "祝福・虫群の意識"
  },
  Skill_67497_Desc = {
    Text = "「<Qiuzhidushulun:知識の読書輪>」"
  },
  Skill_67497_Name = {
    Text = "知識の読書輪"
  },
  Skill_67498_Desc = {
    Text = "「<Jiatongxunshebei:通信機+β>」"
  },
  Skill_67498_Name = {
    Text = "通信機+β"
  },
  Skill_67499_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、それをコピーし、それらの行動力消費を0にする。"
  },
  Skill_67499_Name = {
    Text = "ラモンナ・支援"
  },
  Skill_67500_Desc = {
    Text = "「<Jisiquanzhang:祭司の杖>」"
  },
  Skill_67500_Name = {
    Text = "祭司の杖"
  },
  Skill_67501_Desc = {
    Text = "「<Meixueyuanli:美学の原理>」"
  },
  Skill_67501_Name = {
    Text = "美学の原理"
  },
  Skill_67502_Desc = {
    Text = "「<Riyuelunpan:日月ルーレット>」"
  },
  Skill_67502_Name = {
    Text = "日月ルーレット"
  },
  Skill_67699_Desc = {
    Text = "「<Misagehuizhang:ミサゴの校章>」"
  },
  Skill_67699_Name = {
    Text = "ミサゴの校章"
  },
  Skill_67700_Desc = {
    Text = "「<Wumingzhishenmiansha:無名の神のヴェール>」"
  },
  Skill_67700_Name = {
    Text = "無名の神のヴェール"
  },
  Skill_67759_Name = {
    Text = "ゴールデンテストパック"
  },
  Skill_67760_Name = {
    Text = "プリズムテストパック"
  },
  Skill_67761_Name = {
    Text = "白銀テストパック"
  },
  Skill_67780_Desc = {
    Text = "自爆。<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。「天才の脳缶」は自身の残りライフの2倍を回復。"
  },
  Skill_67780_Name = {
    Text = "自己破壊プログラム"
  },
  Skill_67855_AwakerSkillBackgroundStory = {
    Text = "この双眸は、もはや正常に世界を映すことができない。\n\n彼女は時間と現実の嵐に直面し、荒れ狂う混沌に切り裂かれ、粉々にされ、やがてそれ自体が彼女の眼となった。\n\n「ラモンナ」に属するもう一つの痕跡が彼女の身から消え去ろうとしている。\n彼女は失われゆく自分自身を掴むことができない。\n\n――かつて指先から零れ落ちた生命を掴めなかったように。"
  },
  Skill_67855_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>を獲得。山札から1枚のカードを引き、行動力消費を1減少させる。"
  },
  Skill_67855_EffectNameList = {Text = "力"},
  Skill_67855_Name = {
    Text = "超越の眼"
  },
  Skill_67855_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_67856_AwakerSkillBackgroundStory = {
    Text = "長い孤独の中で、彼女はなぜ剣を振るうのかを忘れてしまった。\nしかし、彼女はこの一撃を振るわねばならないことを知っている。"
  },
  Skill_67856_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、「運命の剣」で<PowerIconKeywords:力>が[Arg2]倍の効果を発揮。キーオーダーを使用するたび、力の倍率がこの戦闘中1倍ずつ増加する。"
  },
  Skill_67856_EffectNameList_0 = {
    Text = "ダメージ"
  },
  Skill_67856_Name = {
    Text = "運命の剣"
  },
  Skill_67856_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,"
  },
  Skill_67868_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_67868_Name = {Text = "更新"},
  Skill_67869_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_67869_Name = {Text = "更新"},
  Skill_67870_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_67870_Name = {Text = "更新"},
  Skill_67871_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_67871_Name = {Text = "更新"},
  Skill_68550_Desc = {
    Text = "彼はとても好奇心旺盛だ。<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「怒り」状態を獲得し、敵の力が持続的に増加する！"
  },
  Skill_68550_Name = {Text = "冒涜"},
  Skill_68551_Desc = {
    Text = "それはあなたを見ている。「症状」カードを1枚あなたの山札に永久に加える。"
  },
  Skill_68551_Name = {Text = "凝視"},
  Skill_68552_Desc = {
    Text = "それは困惑している。2ターンの<BlindingKeywords:盲目>と[Arg1]点の<BleedingIconKeywords:出血>を付与する。"
  },
  Skill_68552_Name = {Text = "侵略"},
  Skill_68659_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_95:「追憶-理想郷の帳」>を1枚山札と捨て札に追加。"
  },
  Skill_68659_Name = {
    Text = "追憶の微光-理想郷の帳"
  },
  Skill_68660_Desc = {
    Text = "2点の行動力を獲得する。3つの「キーオーダー」から、1つを選んで直ちに発動し、自身のデバフ状態を解除し失ったライフの25%を回復する。"
  },
  Skill_68660_Name = {
    Text = "追憶-理想郷の帳"
  },
  Skill_68661_Desc = {
    Text = "手札から非派生指令カードを1枚選択し、その行動力消費をこの戦闘中永久に1減少させ、このカードのコピーを1枚手札に追加する。"
  },
  Skill_68661_Name = {
    Text = "追憶-未完成の蝋人形"
  },
  Skill_68662_Desc = {
    Text = "すべての手札を捨て、捨てた枚数+3枚のカードを引き、それらの行動力消費を1減少させる。"
  },
  Skill_68662_Name = {
    Text = "追憶-異形の心臓"
  },
  Skill_68663_Desc = {
    Text = "2点の一時的な<ParcloseIconKeywords:バリア>を獲得する。次のターン開始時に追加でカードを3枚引き、3点の行動力を獲得する。"
  },
  Skill_68663_Name = {
    Text = "追憶-蜂蜜酒"
  },
  Skill_68664_Desc = {
    Text = "非派生指令カードを1枚選択し、未強化コピー10枚を山札のランダムな位置に追加する。これらのカードは次回使用するまで、行動力消費が2減少する。"
  },
  Skill_68664_Name = {
    Text = "追憶-豊穣の核"
  },
  Skill_68665_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_91:「追憶-未完成の蝋人形」>を1枚山札と捨て札に追加。"
  },
  Skill_68665_Name = {
    Text = "追憶の微光-未完成の蝋人形"
  },
  Skill_68666_Desc = {
    Text = "覚醒体を1体選択し[Arg1]狂気を獲得する。3回使用可能（現在[Arg2]回使用済み）。"
  },
  Skill_68666_Name = {
    Text = "追憶-無邪気な贈り物"
  },
  Skill_68667_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_90:「追憶-無邪気な贈り物」>を1枚山札と捨て札に追加。"
  },
  Skill_68667_Name = {
    Text = "追憶の微光-無邪気な贈り物"
  },
  Skill_68668_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_94:「追憶-代行者の裁決」>を1枚山札と捨て札に追加。"
  },
  Skill_68668_Name = {
    Text = "追憶の微光-代行者の裁決"
  },
  Skill_68669_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_96:「追憶-豊穣の核」>を1枚山札と捨て札に追加。"
  },
  Skill_68669_Name = {
    Text = "追憶の微光-豊穣の核"
  },
  Skill_68670_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_92:「追憶-異形の心臓」>を1枚山札と捨て札に追加。"
  },
  Skill_68670_Name = {
    Text = "追憶の微光-異形の心臓"
  },
  Skill_68671_Desc = {
    Text = "山札または捨て札からカードを1枚選択して手札に追加し、その行動力消費を0にする。<DerivativeCardKeywords_93:「追憶-蜂蜜酒」>を1枚山札と捨て札に追加。"
  },
  Skill_68671_Name = {
    Text = "追憶の微光-蜂蜜酒"
  },
  Skill_68672_Desc = {
    Text = "後列の敵に最大ライフの 25％の<FixedDamage:純粋ダメージ>を与え、最大ライフの 25％のシールドを獲得する。"
  },
  Skill_68672_Name = {
    Text = "追憶-代行者の裁決"
  },
  Skill_68699_Desc = {
    Text = "それは少し休憩するつもりのようだ。"
  },
  Skill_68844_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_68844_Name = {
    Text = "原初の混沌の核"
  },
  Skill_68873_Desc = {
    Text = "すべての覚醒体の「防御」を手札に追加し、それらの行動力消費を0にする。"
  },
  Skill_68873_Name = {
    Text = "隠れるβ"
  },
  Skill_68874_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得し、他の覚醒体の「攻撃」を手札に追加し、それらの行動力消費を0にする。"
  },
  Skill_68874_Name = {
    Text = "不屈の戦意β"
  },
  Skill_68950_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_68950_Name = {
    Text = "原初の混沌の種"
  },
  Skill_68951_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_68951_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_68952_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_68952_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69783_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69783_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69784_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69784_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69785_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69785_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69786_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69786_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69787_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69787_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69788_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69788_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69789_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69789_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69790_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69790_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69791_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69791_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69792_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69792_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69793_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69793_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69794_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69794_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69795_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69795_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69796_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69796_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69797_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69797_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69798_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69798_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69799_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69799_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_69800_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69800_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69801_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_69801_Name = {
    Text = "原初の混沌の種"
  },
  Skill_69802_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:軟化>、<WeaknessIconKeywords:倦怠>、<FragileIconKeywords:抑圧>を付与。"
  },
  Skill_69802_Name = {
    Text = "原初の混沌の核"
  },
  Skill_69803_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<IntoxicationIconKeywords:毒>と[Arg4]点の<BleedingIconKeywords:出血>を付与。"
  },
  Skill_69803_Name = {
    Text = "原初の混沌の霊"
  },
  Skill_70013_Desc = {
    Text = "「深淵の源泉エネルギー」を5点消費し、覚醒体を1体選択し、[Arg1]狂気を獲得させる。ターン開始時、すべての覚醒体は[Arg2]狂気を獲得し、この効果は戦闘終了まで持続する。"
  },
  Skill_70013_Name = {
    Text = "目覚めⅡ"
  },
  Skill_70014_Desc = {
    Text = "「深淵の源泉エネルギー」を10点消費し、<DerivativeCardKeywords_60:「王権」>を1枚手札に追加し、すべての覚醒体のクリティカル率とクリティカルダメージが25%増加する。"
  },
  Skill_70014_Name = {
    Text = "目覚めⅢ"
  },
  Skill_70015_Desc = {
    Text = "「深淵の源泉エネルギー」を1点消費し、<DerivativeCardKeywords_4:「啓示」>を1枚手札に追加し、[Arg1]点の一時的な力と一時的な触腕ダメージを獲得する。"
  },
  Skill_70015_Name = {
    Text = "目覚めⅠ"
  },
  Skill_70043_Desc = {
    Text = "それは少し休憩するつもりのようだ。"
  },
  Skill_70044_Desc = {
    Text = "後列の敵に最大ライフの 15％の<FixedDamage:純粋ダメージ>を与え、最大ライフの 25％のシールドを獲得する。"
  },
  Skill_70044_Name = {
    Text = "追憶-代行者の裁決"
  },
  Skill_70142_Desc = {
    Text = "[Arg1]点のシールドを獲得し、追加で「深淵の源泉エネルギー」を1点蓄積する。"
  },
  Skill_70142_Name = {Text = "熟睡"},
  Skill_70286_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、手札の装備者の全「スキル」によるダメージ、治療、シールドが [Arg1]% 増加します。"
  },
  Skill_70286_Name_1 = {
    Text = "青石の玉座"
  },
  Skill_70299_AwakerSkillBackgroundStory = {
    Text = "彼女が一生追い求めた終点が、今や目の前にある。\n漆黒の扉は致命的な魅力を放っている。\n扉を開ける前に、彼女は372通りの真実を思い描いた。\n扉を開けた後、彼女が認めたくない373番目だけが残った。\n選択肢はなく、彼女はただ堕ちるしかなかった。\n運が悪い、本当に。自分も世界も。"
  },
  Skill_70299_BattleDesc = {
    Text = "他の覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得し、全ての敵に [Poison:Arg2] 層の <IntoxicationIconKeywords:毒> を付与し、一時的ダメージ強化 +[Arg3]％。"
  },
  Skill_70299_Desc = {
    Text = "他の覚醒体が <Energy:[Energy:Arg1]> 点の狂気を獲得し、全ての敵に [Poison:Arg2] 層の <IntoxicationIconKeywords:毒> を付与し、一時的ダメージ強化 +[Arg3]％。「終末形態」：追加で3枚ドローし、3点の行動力を獲得し、全ての敵の <IntoxicationIconKeywords:毒> を50％発動し、「メルトダウン・ドル」の基礎狂気が50点上昇し、最大3回まで上昇する。"
  },
  Skill_70299_EffectNameList = {
    Text = "狂気,毒,ダメージ強化"
  },
  Skill_70299_Name = {
    Text = "終点、真理と深淵の扉"
  },
  Skill_70299_OverLimitUtlSkillDesc = {
    Text = "他の覚醒体が <Energy:[Energy:Arg4]> 点の狂気を獲得し、全ての敵に [Poison:Arg2] 層の <IntoxicationIconKeywords:毒> を付与し、一時的ダメージ強化 +[Arg3]％、全ての覚醒体が与える <IntoxicationIconKeywords:毒>・<RetaliateIconKeywords:カウンター>・基礎ダメージが10％上昇する。現在ボスバトルの場合、追加で「終末」を1層獲得する。"
  },
  Skill_70299_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2,$GrowValue3%"
  },
  Skill_70300_AwakerSkillBackgroundStory = {
    Text = "深紅の胞嚢が機械の甲殻の下で膨張する時、黄銅の共振器は蜂の巣状の防御マトリックスを編む。\n菌糸のパルスネットは空間を切り裂き、酸霧は警告の銘文を蝕み、記憶剥離ビームが予熱されている——境界に触れた肉体は結局、培養皿の中でうごめく標本になる運命だ。"
  },
  Skill_70300_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_70300_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。「溶壊・ドール」は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_70300_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_70300_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_70301_AwakerSkillBackgroundStory = {
    Text = "鋏脚類に似たハサミは彼女の過去、彼女の種族由来のもので、それは決して手放すことのない力の象徴だ。\nその鋏脚が敵の胸を貫くとき、彼女が浮かべる微笑みは一体何を意味するのだろうか？"
  },
  Skill_70301_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_70301_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。「溶壊・ドール」が<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_70301_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_70301_Name = {Text = "攻撃"},
  Skill_70301_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2"
  },
  Skill_70302_AwakerSkillBackgroundStory = {
    Text = "彼女は自分を犠牲にして、真実に触れる資格を得た。\n手を引いた時、彼女の魂は蝋のように溶けていた。"
  },
  Skill_70302_BattleDesc_0 = {
    Text = "「溶融・ドール」は<Energy:[Energy:Arg1]>狂気を獲得<ExaltIconKeywords:霊知覚醒>：ターン終了時、ライフを<Heal:[Heal:Arg2]>回復し、<Energy:[Energy:Arg4]> 狂気を獲得。「終末形態」：ライフを回復せず、すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動。"
  },
  Skill_70302_BattleDesc_15 = {
    Text = "「溶融・ドール」は<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：「終末」1点につき、ダメージ強化+8%。「虚無終結」を使用した後、すべての覚醒体は基礎狂気の30%を獲得。ターン終了時、ライフを<Heal:[Heal:Arg2]>回復し、<Energy:[Energy:Arg4]>狂気を獲得。「終末形態」：ライフを回復せず、すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動。"
  },
  Skill_70302_Desc_0 = {
    Text = "「溶融・ドール」は<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン終了時、ライフを<Heal:[Heal:Arg2]>回復し、自身の狂気増加と同量の狂気を獲得。「終末形態」：ライフを回復せず、すべての敵の<IntoxicationIconKeywords:毒>を[Arg3]%発動。"
  },
  Skill_70302_Desc_15 = {
    Text = "「熔毀·ドール」が<Energy:[Energy:Arg1]> ポイントの狂気を獲得する。<ExaltIconKeywords:霊知覚醒>：「終末」1層所持ごとにダメージ強化+8％。「虚無終結」で全覚醒体が30％の基礎狂気を獲得する。ターン終了時、<Heal:[Heal:Arg2]> ポイントのHPを回復し、自身の狂気リチャージと同等の狂気を獲得する。「終末形態」：HP回復を行わず、代わりに全敵の[Arg3]％の<IntoxicationIconKeywords:中毒>を発動する。"
  },
  Skill_70302_EffectNameList = {
    Text = "狂気,回復,毒発動割合"
  },
  Skill_70302_Name = {
    Text = "魂の疫病"
  },
  Skill_70302_PropertyNameList = {
    Text = "$GrowValue1,体力×GrowValue2,$GrowValue3%,"
  },
  Skill_70303_AwakerSkillBackgroundStory = {
    Text = "もし私たちが消滅の一本道を歩み続けるなら、速く進むことは慈悲なのかもしれない。\n終末が一瞬で訪れるなら、苦痛も一瞬で凝縮される。\n人々は愛する者と抱き合い、共に虚無の静寂を迎えるだけ。\n終点に苦痛がないなら、それもまた天国に到達したと言えるのだろうか？"
  },
  Skill_70303_BattleDesc_0 = {
    Text = "全ての敵にその最大ライフの 25％ の<FixedDamage:純粋ダメージ>（最低 [Arg2]）を与え、使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。"
  },
  Skill_70303_BattleDesc_3 = {
    Text = "全ての敵にその最大ライフの 30％ の<FixedDamage:純粋ダメージ>（最低 [Arg2]）を与え、失われたライフの 30％ を回復する（ <Heal:[Heal:Arg3]> ）使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。"
  },
  Skill_70303_Desc_0 = {
    Text = "全ての敵にその最大ライフの 25％ の<FixedDamage:純粋ダメージ>を与え、このダメージは自身の最大ライフの [Arg1]％ を下回らない。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。「虚無終結」の効果は 1 回のみ発動する。"
  },
  Skill_70303_Desc_3 = {
    Text = "全ての敵にその最大ライフの 30％ の<FixedDamage:純粋ダメージ>を与え、このダメージは自身の最大ライフの [Arg1]％ を下回らない。失われたライフの 30％ を回復する。使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。「虚無終結」の効果は 1 回のみ発動する。"
  },
  Skill_70303_Name = {
    Text = "虚無終結"
  },
  Skill_70303_tempBattleDesc_1 = {
    Text = "全ての敵にその最大ライフの 25％ の<FixedDamage:純粋ダメージ>（最低 [Arg2]）を与え、使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。"
  },
  Skill_70303_tempBattleDesc_2 = {
    Text = "全ての敵にその最大ライフの 30％ の<FixedDamage:純粋ダメージ>（最低 [Arg2]）を与え、失われたライフの 30％ を回復する（ <Heal:[Heal:Arg3]> ）使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。"
  },
  Skill_70303_tempBattleDesc_3 = {
    Text = "全ての敵にその最大ライフの 30％ の<FixedDamage:純粋ダメージ>（最低 [Arg2]）を与え、失われたライフの 30％ を回復する（ <Heal:[Heal:Arg3]> ）使用後「メルトダウン・ドル」の特定スキルが「終末形態」に変更される。全ての覚醒体が 30％ の基礎狂気を獲得する。"
  },
  Skill_70304_AwakerSkillBackgroundStory = {
    Text = "人形の両手は非常に器用で、魂の核心は彼女の手の中ではまるで素直なルービックキューブのよう。\n親切な天才は喜んで無料で改造してくれるが、改造後の副作用は少し大げさ。"
  },
  Skill_70304_Desc = {
    Text = "<DerivativeCardKeywords_103:「選択」>「興奮」または「呪い」。"
  },
  Skill_70304_EffectNameList = {
    Text = "興奮効果の増加,呪いによる力の減少"
  },
  Skill_70304_Name = {
    Text = "自滅改造"
  },
  Skill_70304_PropertyNameList = {
    Text = "$GrowValue1%,防御力×GrowValue2"
  },
  Skill_70305_AwakerSkillBackgroundStory = {
    Text = "アリのビルの運行原理に対する推測は、常に愚かで滑稽。\nすべての理想と信念は瞬時に崩れ去り、思い出と温情は奇点の外の虚影となる。\n宇宙誕生の原点には、何も存在しない。"
  },
  Skill_70305_Desc = {
    Text = "<Energy:[Energy:Arg1]> 狂気を<DerivativeCardKeywords_104:獲得> 。<Heal:[Heal:Arg2]> ライフを回復。自身の持つ狂気50ごとに追加で1ライフ回復。"
  },
  Skill_70305_EffectNameList = {
    Text = "狂気,回復,毒"
  },
  Skill_70305_Name = {
    Text = "宿命崩壊"
  },
  Skill_70305_PropertyNameList = {
    Text = "$GrowValue1,体力×GrowValue2,攻撃力×GrowValue3"
  },
  Skill_70332_Desc_0 = {
    Text = "すべての敵の<PowerIconKeywords:力>を一時的に[Exhaustion:Arg2]点減少させる。"
  },
  Skill_70332_Desc_1 = {
    Text = "すべての敵に[Arg1]ターンの<WeaknessIconKeywords:虚弱>を付与し、それらの<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg2]点減少させる。"
  },
  Skill_70332_Name = {Text = "呪い"},
  Skill_70333_Desc_0 = {
    Text = "1ターンの「興奮」ステータスを獲得する：ダメージ強化 +[Arg2]％。"
  },
  Skill_70333_Desc_1 = {
    Text = "1ターンの「興奮」ステータスを獲得する：ダメージ強化 +[Arg2]％。全ての敵に [Arg1] ターンの <VulnerabilityIconKeywords:易傷> を付与する。"
  },
  Skill_70333_Name = {Text = "興奮"},
  Skill_70355_Desc_1 = {
    Text = "すべての味方に<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_70355_Name_1 = {
    Text = "アドレナリン"
  },
  Skill_70356_Desc_1 = {
    Text = "カードを[Arg1]枚引く。"
  },
  Skill_70356_Name_1 = {Text = "奇襲"},
  Skill_70357_Desc_1 = {
    Text = "[Arg1]点の行動力を獲得。"
  },
  Skill_70358_Desc_1 = {
    Text = "味方1体のライフを<Heal:[Heal:Arg1]>回復、または敵1体に<Damage:[Damage:Arg2]>ダメージを与える。"
  },
  Skill_70358_Name_1 = {
    Text = "液化する虚無"
  },
  Skill_70359_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：装備者が各ターン最初の [Arg1] 回攻撃を受けた際、攻撃者に<PVPEmptinessKeywords:虚無>を与える。"
  },
  Skill_70359_Name_1 = {
    Text = "虚無に堕ちた人形"
  },
  Skill_70360_Desc_1 = {
    Text = "すべての味方のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_70360_Name_1 = {
    Text = "救済計画"
  },
  Skill_70361_Desc_1 = {
    Text = "すべての味方に<Block:[Block:Arg1]>点のシールドを与える。"
  },
  Skill_70361_Name_1 = {
    Text = "ダメージ抗体"
  },
  Skill_70362_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_70362_Name_1 = {
    Text = "破壊計画"
  },
  Skill_70376_Desc = {
    Text = "[Arg1]キーエネルギーを失い、「霊知覚醒」を1枚選んで手札に追加。（霊知覚醒を1枚獲得するごとに消費が100%増加し、消費後キーエネルギーは負の値になる可能性がある）"
  },
  Skill_70376_Name = {
    Text = "シルバーキー覚醒"
  },
  Skill_70383_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70383_Name = {Text = "更新"},
  Skill_70384_Desc = {
    Text = "同品質の遺物を1回再発見し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70384_Name = {Text = "更新"},
  Skill_70825_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得。「星辰の加護」をすべて消費し、消費した層数と同じ行動力を獲得。現在の界域が「深海」の場合、消費した層数と同じ数の臨時触腕を追加で生成する。"
  },
  Skill_70825_Name = {Text = "目覚め"},
  Skill_70826_Desc = {
    Text = "<Block:[Arg1]> 点のシールドを獲得し、「星辰の加護」を1層獲得する。最大5層まで蓄積でき、戦闘終了後も消去されない。"
  },
  Skill_70826_Name = {Text = "熟睡"},
  Skill_70827_Desc = {
    Text = "覚醒体を1体選択し、その指令カードのクリティカル率とクリティカルダメージを一時的に[Arg1]%増加させ、[Arg2]狂気を獲得させる。リズがチームにいる場合、「消耗」が付与された「腐化緑炎」を1枚手札に加える。"
  },
  Skill_70827_Name = {
    Text = "ブラックスワン"
  },
  Skill_70828_Desc = {
    Text = "覚醒体を1体選択し[Arg1]狂気を獲得させ、すべての敵に[Arg2]層の<IntoxicationIconKeywords:中毒>を付与する。対象がライフを1％失うごとに追加で1％の中毒を誘発し、最大50％の中毒を誘発する。"
  },
  Skill_70828_Name = {
    Text = "虚無の疫病"
  },
  Skill_70829_Desc = {
    Text = "<DerivativeCardKeywords_99:「熟睡」>または<DerivativeCardKeywords_100:「目覚め」>を選択する。"
  },
  Skill_70829_Name = {
    Text = "星々の加護"
  },
  Skill_70961_Desc = {
    Text = "2つの高級+遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70961_Name = {Text = "更新"},
  Skill_70962_Desc = {
    Text = "2つの低級遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70962_Name = {Text = "更新"},
  Skill_70963_Desc = {
    Text = "2つの時の振り子遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70963_Name = {Text = "更新"},
  Skill_70964_Desc = {
    Text = "2つの祝福された遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70964_Name = {Text = "更新"},
  Skill_70965_Desc = {
    Text = "2つの呪われた遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70965_Name = {Text = "更新"},
  Skill_70966_Desc = {
    Text = "2つの高級遺物から1つを選んで獲得し、各戦闘で1回の更新機会を共有する。"
  },
  Skill_70966_Name = {Text = "更新"},
  Skill_70994_Desc = {
    Text = "10点の終末"
  },
  Skill_71522_Desc = {
    Text = "ライフ上限が10%減少し、「興奮」と「呪い」効果を発動。"
  },
  Skill_71522_Name = {
    Text = "自滅改造・終末"
  },
  Skill_71523_Desc = {
    Text = "<Energy:[Energy:Arg1]> 狂気を獲得。すべての敵に[Poison:Arg2]点の<IntoxicationIconKeywords:毒>を付与。自身当前每拥有 50 狂気，额外付与する 1 次毒。"
  },
  Skill_71523_Name = {
    Text = "宿命崩壊・終末"
  },
  Skill_71636_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、<DerivativeCardKeywords_105:「無限の宝物庫」>を1枚手札に追加する。"
  },
  Skill_71636_Name = {
    Text = "シルバーコアを撒き散らす"
  },
  Skill_71637_Desc = {
    Text = "監禁されているようだ、行動不能。"
  },
  Skill_71637_Name = {
    Text = "監禁中……"
  },
  Skill_71638_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。双方に[Arg3]点の<VulnerabilityIconKeywords:軟化>を付与。"
  },
  Skill_71639_Desc = {
    Text = "[Arg1]点の一時的な<PowerIconKeywords:力>と[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_71639_Name = {
    Text = "爪を磨く"
  },
  Skill_71652_Desc = {
    Text = "シルバーコアの力を感じよ！現在の界域の覚醒体3体を呼び出し、その中から1体を選んでその支援カードを獲得する。"
  },
  Skill_71652_Name = {
    Text = "無限の宝物庫"
  },
  Skill_71691_BattleDesc = {
    Text = "現在の死の抵抗を2倍にして、敵全体の [Arg1] ポイント<PowerIconKeywords:力>を一時的に減少させ、敵が1体いるごとに [Arg1] ポイントの<PowerIconKeywords:一時的な力>を得る。"
  },
  Skill_71691_Desc = {
    Text = "現在の死亡抵抗が2倍になり、<TouquKeywords:永久的に>すべての敵から[Arg1]点の力を奪う。"
  },
  Skill_71691_Name = {
    Text = "ファイント・支援"
  },
  Skill_71692_Desc = {
    Text = "触腕ダメージの50%分に等しい一時的な力を獲得し、すべての敵の<PowerIconKeywords:力>を一時的に全て除去し、3ターン<VulnerabilityIconKeywords:易傷>にする。除去した量に等しい一時的な<PowerIconKeywords:力>を獲得する。"
  },
  Skill_71692_Name = {
    Text = "ゴリアテ・支援"
  },
  Skill_71693_Desc = {
    Text = "前のターン最後に使用した異なる非派生指令カード3枚の一時的なコピーを手札に追加し、それらの行動力消費を0にする。"
  },
  Skill_71693_Name = {
    Text = "環行・ラモンナ・支援"
  },
  Skill_71694_Desc = {
    Text = "次のターン開始時にこのターン失ったライフと同量のシールドを獲得し、この効果は1ターン持続する。「胚胎」を3枚手札に追加する。"
  },
  Skill_71694_Name = {
    Text = "レーア・支援"
  },
  Skill_71695_Desc = {
    Text = "手札が上限に達するまでカードを引く。ターン終了時に手札1枚につき、すべての覚醒体は5狂気を獲得する。"
  },
  Skill_71695_Name = {
    Text = "カーシア・支援"
  },
  Skill_71696_Desc = {
    Text = "覚醒体を1体選択し35狂気を獲得させ、ターン終了時にも1回繰り返し、この効果は5ターン持続する。"
  },
  Skill_71696_Name = {
    Text = "ウインクル・支援"
  },
  Skill_71697_Desc = {
    Text = "すべての敵を1ターン石化させる。敵が石化耐性を持っている場合、代わりにそれらに25層の易傷を与える。"
  },
  Skill_71697_Name = {
    Text = "アイギス・支援"
  },
  Skill_71698_Desc = {
    Text = "ランダムな手札5枚の行動力消費を1減少させ、最大ライフの50%のシールドを獲得する。"
  },
  Skill_71698_Name = {
    Text = "ティンクト・支援"
  },
  Skill_71699_Desc = {
    Text = "3点の行動力を獲得する。自身のデバフ状態を解除し失ったライフの25%を回復し、3つの「キーオーダー」から、1つを選んで直ちに発動する。"
  },
  Skill_71699_Name = {
    Text = "シレスト・支援"
  },
  Skill_71700_Desc = {
    Text = "覚醒体を1体選択し100狂気を獲得させ、そのクリティカル率とクリティカルダメージを永久に25%増加させる。"
  },
  Skill_71700_Name = {
    Text = "ユウハシュ・支援"
  },
  Skill_71701_Desc = {
    Text = "直ちに[Arg1]点の触腕ダメージと[Arg2]点の一時的な反撃を獲得する。攻撃を受けるたび、ライフを[Arg3]回復し、この効果は1ターン持続する。"
  },
  Skill_71701_Name = {
    Text = "カエクス・支援"
  },
  Skill_71702_Desc = {
    Text = "35%の一時的なクリティカル率と75%の一時的なクリティカルダメージを獲得し、このターン中、与える最終ダメージが25%増加する。"
  },
  Skill_71702_Name = {
    Text = "ジェンキン・支援"
  },
  Skill_71703_Desc = {
    Text = "直ちに触腕を3本生成し、次のターン開始時に最大ライフの25%のシールドを獲得する。"
  },
  Skill_71703_Name = {
    Text = "サンガー・支援"
  },
  Skill_71704_Desc = {
    Text = "覚醒体を1体選択し、そのすべての指令カードを捨て、捨てたカード1枚につき[Arg1]点の一時的な力を獲得し、捨てたカードのすべての効果を発動する。"
  },
  Skill_71704_Name = {
    Text = "リッツ・支援"
  },
  Skill_71705_Desc = {
    Text = "覚醒体を1体選択し、その覚醒体の指令カードを3枚引き、それらの行動力消費を1減少させる。その覚醒体はダメージを1回与えるたびに触腕1本に1回攻撃させ、この効果は1ターン持続する。"
  },
  Skill_71705_Name = {
    Text = "オレッタ・支援"
  },
  Skill_71706_Desc = {
    Text = "「攻撃」の最終ダメージが100%増加する。「捕食」を行うたび、「攻撃」を2枚引き、それらの行動力消費を1減少させ、この効果は1ターン持続する。"
  },
  Skill_71706_Name = {
    Text = "ヘロット・支援"
  },
  Skill_71834_Desc_1 = {
    Text = "1名の敵を選び、その敵に<WeaknessIconKeywords:虚弱>、<PVPVulnerabilityIconKeywords:易傷>、および1層の<PVPSlowKeywords:遅延>を与える。"
  },
  Skill_71834_Name_1 = {
    Text = "虚無の疫病"
  },
  Skill_71834_UnknownName = {
    Text = "虚無の疫病"
  },
  Skill_71835_Desc_1 = {
    Text = "対象1体に<DelayKeywords:遅延>：<PVPVulnerabilityIconKeywords:軟化>、を付与する。"
  },
  Skill_71835_Name_1 = {
    Text = "遅延易傷"
  },
  Skill_71836_Desc_1 = {
    Text = "相手の行動力が最も高い「スキルカード」[Arg1]枚を捨てさせ、等量の<PVPDerivativeCardKeywords_2:「幻影」>を獲得させる。"
  },
  Skill_71836_Name_1 = {
    Text = "星々の加護"
  },
  Skill_71836_UnknownName = {
    Text = "星々の加護"
  },
  Skill_71904_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_71904_Name_1 = {Text = "攻撃"},
  Skill_71905_Desc_1 = {
    Text = "相手に[Arg1]枚のカードを引かせる。全ての敵に<Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>を与える。"
  },
  Skill_71905_Name_1 = {
    Text = "狂乱触媒"
  },
  Skill_71906_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、相手に対象のすべての手札、および手札にあるすべての運命の札とキーオーダーを捨てさせる。<PVPPenetrateKeywords:貫通>"
  },
  Skill_71906_Name_1 = {
    Text = "ライフフォーム再構成治療"
  },
  Skill_71907_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、相手に対象のすべての手札を捨てさせる。"
  },
  Skill_71907_Name_1 = {
    Text = "心理的絞殺"
  },
  Skill_71908_Desc_1 = {
    Text = "全体の敵に <Damage:[Damage:Arg1]> ダメージを与える。対象の手札1枚につき追加で[Arg2]回ダメージを与える。"
  },
  Skill_72025_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_72107_Desc = {
    Text = "すべての敵がこの戦闘中に[Power:Arg1]点の<PowerIconKeywords:力>を獲得する。「灰燼の融蝕生物」を1体召喚する。"
  },
  Skill_72107_Name = {
    Text = "シルバーコア融合"
  },
  Skill_72108_Desc = {
    Text = "「暗殺者」状態と2点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_72108_Name = {
    Text = "灰燼に沈む"
  },
  Skill_72110_Desc = {
    Text = "「ダイヤル爆弾」を1枚山札に追加し、3点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_72110_Name = {Text = "喚起"},
  Skill_72112_Desc = {
    Text = "「灰燼の融蝕生物」を3体と「緊急連絡」を1体召喚し、自身は死亡する。"
  },
  Skill_72112_Name = {
    Text = "連結解除"
  },
  Skill_72113_Desc = {
    Text = "<Damage:[Damage:Arg2]>ダメージを[AttackTimes:Arg3]回与える。この戦闘中、すべての敵がターン終了後に<Block:[Block:Arg1]>点のシールドを獲得する。"
  },
  Skill_72113_Name = {
    Text = "融蝕の副産物"
  },
  Skill_72114_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_72115_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。"
  },
  Skill_72115_Desc = {
    Text = "高ダメージを1回与える。"
  },
  Skill_72115_Name = {
    Text = "物理修復"
  },
  Skill_72116_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<BlindingKeywords:盲目>を付与。"
  },
  Skill_72116_Name = {
    Text = "流れ離れる"
  },
  Skill_72117_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「暗殺者」状態を獲得。"
  },
  Skill_72117_Name = {
    Text = "無火の灰"
  },
  Skill_72118_Desc = {
    Text = "「ダイヤル爆弾」を1枚山札に追加し、3点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_72118_Name = {Text = "遮断"},
  Skill_72119_Desc = {
    Text = "「ダイヤル爆弾」を1枚山札に追加し、 2点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_72119_Name = {Text = "喚起"},
  Skill_72120_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後列に「灰燼の融蝕生物」を1体召喚する。"
  },
  Skill_72120_Name = {
    Text = "異体排除"
  },
  Skill_72122_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。後列に「灰燼の融蝕生物」を1体召喚する。"
  },
  Skill_72122_Name = {
    Text = "異体排除"
  },
  Skill_72123_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_72123_Name = {
    Text = "流れ逝く時"
  },
  Skill_72124_Desc = {
    Text = "すべての敵がこの戦闘中に[Power:Arg1]点の<PowerIconKeywords:力>を獲得する。「灰燼の融蝕生物」を1体召喚する。"
  },
  Skill_72124_Name = {
    Text = "シルバーコア融合"
  },
  Skill_72125_Desc = {
    Text = "「ダイヤル爆弾」を1枚山札に追加し、2点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_72125_Name = {Text = "遮断"},
  Skill_72177_BattleDesc = {
    Text = "研究要求：「キーオーダー」を2回発動する。研究成果：すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72177_Desc = {
    Text = "研究要求：「キーオーダー」を3回発動する。研究成果：すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72177_Name = {
    Text = "シルバーキー研究"
  },
  Skill_72178_BattleDesc = {
    Text = "研究要求：「狂気解放」を5回発動する。研究成果：手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72178_Desc = {
    Text = "研究要求：「狂気解放」を6回発動する。研究成果：手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72178_Name = {
    Text = "狂気研究"
  },
  Skill_72179_BattleDesc = {
    Text = "研究要求：ダメージを30回与える。研究成果：すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72179_Desc = {
    Text = "研究要求：ダメージを40回与える。研究成果：すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72179_Name = {
    Text = "連撃研究"
  },
  Skill_72180_BattleDesc = {
    Text = "100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72180_Desc = {
    Text = "100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72180_Name = {Text = "強心剤"},
  Skill_72181_BattleDesc = {
    Text = "[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72181_Desc = {
    Text = "[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72181_Name = {
    Text = "爆発的興奮"
  },
  Skill_72182_BattleDesc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72182_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72182_Name = {
    Text = "深淵からの狂乱"
  },
  Skill_72183_BattleDesc = {
    Text = "研究要求：シールド獲得またはライフ回復を10回行う。研究成果：[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72183_Desc = {
    Text = "研究要求：シールド獲得またはライフ回復を15回行う。研究成果：[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72184_BattleDesc = {
    Text = "研究要求：「キーオーダー」を2回発動する。研究成果：すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72184_Desc = {
    Text = "研究要求：「キーオーダー」を3回発動する。研究成果：すべての覚醒体が[Arg1]狂気を獲得し、毎ターン終了時に追加で[Arg2]狂気を獲得する。"
  },
  Skill_72184_Name = {
    Text = "シルバーキー研究"
  },
  Skill_72185_BattleDesc = {
    Text = "手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72185_Desc = {
    Text = "手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72185_Name = {
    Text = "瓶詰めされた虚無"
  },
  Skill_72186_BattleDesc = {
    Text = "研究要求：指令カードを15枚使用する。研究成果：100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72186_Desc = {
    Text = "研究要求：指令カードを20枚使用する。研究成果：100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72186_Name = {
    Text = "司令用デバイス研究"
  },
  Skill_72187_BattleDesc = {
    Text = "研究要求：シールド獲得またはライフ回復を15回行う。研究成果：[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72187_Desc = {
    Text = "研究要求：シールド獲得またはライフ回復を15回行う。研究成果：[Arg1]点の行動力を獲得し、カードを[Arg1]枚引く。行動力上限とドロー枚数+[Arg2]。"
  },
  Skill_72188_BattleDesc = {
    Text = "研究要求：指令カードを15枚使用する。研究成果：100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72188_Desc = {
    Text = "研究要求：指令カードを20枚使用する。研究成果：100%のダメージ強化と15%のクリティカル率を獲得し、このターン内は効果が2倍になる。"
  },
  Skill_72188_Name = {
    Text = "司令用デバイス研究"
  },
  Skill_72189_BattleDesc = {
    Text = "すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72189_Desc = {
    Text = "すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72189_Name = {
    Text = "衰弱の疫病"
  },
  Skill_72190_BattleDesc = {
    Text = "研究要求：「狂気解放」を5回発動する。研究成果：手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72190_Desc = {
    Text = "研究要求：「狂気解放」を6回発動する。研究成果：手札の指令カード3枚を選択し、「合奏」の刻印を付与する。"
  },
  Skill_72190_Name = {
    Text = "狂気研究"
  },
  Skill_72191_BattleDesc = {
    Text = "研究要求：ダメージを40回与える。研究成果：すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72191_Desc = {
    Text = "研究要求：ダメージを40回与える。研究成果：すべての敵に[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与し、[Arg2]点の力を減少させる。"
  },
  Skill_72191_Name = {
    Text = "連撃研究"
  },
  Skill_72827_BattleDesc = {
    Text = "全ての敵にその最大ライフの[Arg1]％の<FixedDamage:純粋ダメージ>を与える（最低[Arg3]）。"
  },
  Skill_72827_Desc = {
    Text = "全ての敵にその最大ライフの[Arg1]％の<FixedDamage:純粋ダメージ>を与える。このダメージは自身の最大ライフの[Arg2]％を下回らない。"
  },
  Skill_72827_Name = {
    Text = "虚無終結"
  },
  Skill_73475_Desc = {
    Text = "「奔放」を1枚山札に追加する。"
  },
  Skill_73476_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Power:Arg3]点の<PowerIconKeywords:力>を獲得する。霊知覚醒カードを使用した場合、行動予測は「心理的絞殺」に転換する。"
  },
  Skill_73476_Name = {
    Text = "苦痛の搾取"
  },
  Skill_73477_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が死亡する。"
  },
  Skill_73477_Name = {Text = "自爆"},
  Skill_73482_Desc = {
    Text = "2点の<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与。自身のの<MadnessIconKeywords:発狂>と<PowerIconKeywords:力>を半分除去し、失ったライフの10%を回復する。"
  },
  Skill_73482_Name = {
    Text = "心のケア"
  },
  Skill_73484_Desc = {
    Text = "手札にある間、行動力消費が 3 のカードを発射した後、[Arg1] 点の<FixedDamage:純粋ダメージ>を受け、行動力消費が 1 または 2 の「ダイヤルボム」1 枚に変形する。発射後、行動力消費と同じ枚数のカードを引く。"
  },
  Skill_73484_Name = {
    Text = "ダイヤル爆弾"
  },
  Skill_73485_Desc = {
    Text = "手札にある間、行動力消費が 2 のカードを発射した後、[Arg1] 点の<FixedDamage:純粋ダメージ>を受け、行動力消費が 1 または 3 の「ダイヤルボム」1 枚に変形する。発射後、行動力消費と同じ枚数のカードを引く。"
  },
  Skill_73485_Name = {
    Text = "ダイヤル爆弾"
  },
  Skill_73486_Desc = {
    Text = "手札にある間、行動力消費が 1 のカードを発射した後、[Arg1] 点の<FixedDamage:純粋ダメージ>を受け、行動力消費が 2 または 3 の「ダイヤルボム」1 枚に変形する。発射後、行動力消費と同じ枚数のカードを引く。"
  },
  Skill_73486_Name = {
    Text = "ダイヤル爆弾"
  },
  Skill_73525_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、2点の<BlindingKeywords:盲目>を付与する。"
  },
  Skill_73526_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、自身が[Arg2]点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_73527_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、1点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_73528_Desc = {
    Text = "「まさか…」を2体召喚し、すべての味方が3点の<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_73536_Desc = {
    Text = "解放済みのランダムな「キーオーダー」3つの中から1つを選んで直ちに発動する。"
  },
  Skill_73536_Name = {
    Text = "シルバーキーの微光"
  },
  Skill_74028_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。3点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_74029_Desc = {
    Text = "すべての敵がこの戦闘中に[Power:Arg1]点の永続的な<PowerIconKeywords:力>を獲得する。「緊急連絡」を1体と「灰燼の融蝕生物」を1体召喚する。"
  },
  Skill_74029_Name = {
    Text = "永続共生"
  },
  Skill_74030_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_74030_Desc = {
    Text = "高ダメージを1回与える。"
  },
  Skill_74030_Name = {
    Text = "物理修復"
  },
  Skill_74036_Desc = {
    Text = "ターン開始時、ランダムに「認知錯乱」が付与されていない指令2枚に「認知錯乱」を付与する。"
  },
  Skill_74036_Name = {
    Text = "霊知催眠"
  },
  Skill_74037_Desc = {
    Text = "ターン開始時、ランダムに「認知錯乱」が付与されていない指令2枚に「認知錯乱」を付与する。"
  },
  Skill_74037_Name = {
    Text = "霊知催眠"
  },
  Skill_74038_Desc = {
    Text = "ターン開始時、ランダムに「認知錯乱」が付与されていない指令2枚に「認知錯乱」を付与する。"
  },
  Skill_74038_Name = {
    Text = "霊知催眠"
  },
  Skill_74039_Desc = {
    Text = "ターン開始時、ランダムに「認知錯乱」が付与されていない指令2枚に「認知錯乱」を付与する。"
  },
  Skill_74040_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。保持している手札をすべて捨て、「啓示」3枚と異なる行動力の「ダイヤル爆弾」を3枚手札に追加する。"
  },
  Skill_74040_Name = {Text = "伝達"},
  Skill_74042_Desc = {
    Text = "非除外の指令カードを使用後、「予備の脳缶」にそのカードがない場合、「除外」が付与された未強化コピーを[Arg1]枚「予備の脳缶」に置く。毎ターン最大1回まで発動する。使用後、「予備の脳缶」の中のカードを最大3枚まで手札に追加する。"
  },
  Skill_74042_Name = {
    Text = "予備の脳缶"
  },
  Skill_74083_Desc = {
    Text = "すべての覚醒体は<Energy:[Arg1]>狂気を獲得し、すべての敵に2点の虚弱と易傷を付与する。"
  },
  Skill_74083_Name = {
    Text = "メルトダウン"
  },
  Skill_74300_Desc = {
    Text = "ターン終了後、自身が生存している場合、プレイヤーは探索失敗となる。この行動は変化できない。"
  },
  Skill_74300_Name = {Text = "終わり"},
  Skill_74792_Desc = {
    Text = "キーエネルギーとすべての覚醒体の狂気を最大値まで充填する。"
  },
  Skill_74792_Name = {
    Text = "光錐の境界"
  },
  Skill_74819_BattleDesc = {
    Text = "このターン、すべての覚醒体のクリティカルとクリティカルダメージが[Arg1]%増加する"
  },
  Skill_74819_Desc = {
    Text = "このターン、すべての覚醒体のクリティカルとクリティカルダメージが[Arg1]%増加する"
  },
  Skill_74819_Name = {
    Text = "取引完了"
  },
  Skill_74820_BattleDesc = {
    Text = "すべての敵に[Arg1]点の毒を付与する"
  },
  Skill_74820_Desc = {
    Text = "すべての敵に[Arg1]点の毒を付与する"
  },
  Skill_74820_Name = {
    Text = "原質の汚染"
  },
  Skill_74821_BattleDesc = {
    Text = "ランダムに[Arg1]ダメージを[Arg2]回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  Skill_74821_Desc = {
    Text = "ランダムに[Arg1]ダメージを[Arg2]回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  Skill_74821_Name = {
    Text = "物々交換"
  },
  Skill_74822_BattleDesc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する"
  },
  Skill_74822_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する"
  },
  Skill_74822_Name = {
    Text = "ご自由にお選びください"
  },
  Skill_74823_BattleDesc = {
    Text = "すべての敵に失ったライフの[Arg1]%のダメージを与える"
  },
  Skill_74823_Desc = {
    Text = "すべての敵に失ったライフの[Arg1]%のダメージを与える"
  },
  Skill_74823_Name = {
    Text = "次元を超越する囁き"
  },
  Skill_74824_BattleDesc = {
    Text = "[Arg1]点の力を獲得する"
  },
  Skill_74824_Desc = {
    Text = "[Arg1]点の力を獲得する"
  },
  Skill_74824_Name = {
    Text = "首コレクション鑑賞"
  },
  Skill_74834_Name = {
    Text = "禁忌の取引"
  },
  Skill_74893_BattleDesc = {
    Text = "[Arg1]点のシールドを獲得する"
  },
  Skill_74893_Desc = {
    Text = "[Arg1]点のシールドを獲得する"
  },
  Skill_74893_Name = {
    Text = "万千扉の守護"
  },
  Skill_74894_BattleDesc = {
    Text = "[Arg1]点の死亡抵抗を獲得する"
  },
  Skill_74894_Desc = {
    Text = "[Arg1]点の死亡抵抗を獲得する"
  },
  Skill_74894_Name = {
    Text = "死も販売可能"
  },
  Skill_74895_BattleDesc = {
    Text = "[Arg1]点の行動力を獲得する"
  },
  Skill_74895_Desc = {
    Text = "[Arg1]点の行動力を獲得する"
  },
  Skill_74895_Name = {
    Text = "蒐集品の入庫"
  },
  Skill_74896_BattleDesc = {
    Text = "ランダムに[Arg1]ダメージを[Arg2]回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  Skill_74896_Desc = {
    Text = "ランダムに[Arg1]ダメージを[Arg2]回与える（このダメージは1倍の力ボーナスを受ける）"
  },
  Skill_74896_Name = {
    Text = "銀貨の決済"
  },
  Skill_74897_BattleDesc = {
    Text = "[Arg1]点の反撃を獲得する"
  },
  Skill_74897_Desc = {
    Text = "[Arg1]点の反撃を獲得する"
  },
  Skill_74897_Name = {
    Text = "店はクレジット禁止"
  },
  Skill_74898_BattleDesc = {
    Text = "すべての敵の<PowerIconKeywords:力>を一時的に[Arg1]点低下させ、敵1体につき[Arg1]点の<PowerIconKeywords:一時的な力>を獲得する。"
  },
  Skill_74898_Desc = {
    Text = "すべての敵から[Arg1]点の力を<TouquKeywords:奪う>"
  },
  Skill_74898_Name = {
    Text = "あなたの首は予約済み"
  },
  Skill_74899_BattleDesc = {
    Text = "覚醒体を1体選択し[Arg1]狂気を獲得する"
  },
  Skill_74899_Desc = {
    Text = "覚醒体を1体選択し[Arg1]狂気を獲得する"
  },
  Skill_74899_Name = {
    Text = "あなたが待ち望むもの"
  },
  Skill_74900_BattleDesc = {
    Text = "[Arg1]点の界域知識を獲得する"
  },
  Skill_74900_Desc = {
    Text = "[Arg1]点の界域知識を獲得する"
  },
  Skill_74900_Name = {
    Text = "千年の知識"
  },
  Skill_74901_BattleDesc = {
    Text = "このターン与える毒、反撃、出血が[Arg1]%増加する"
  },
  Skill_74901_Desc = {
    Text = "このターン与える毒、反撃、出血が[Arg1]%増加する"
  },
  Skill_74901_Name = {
    Text = "貪欲にすべからず"
  },
  Skill_74902_BattleDesc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する"
  },
  Skill_74902_Desc = {
    Text = "すべての覚醒体が[Arg1]狂気を獲得する"
  },
  Skill_74902_Name = {
    Text = "今日はお店で割引"
  },
  Skill_74903_BattleDesc = {
    Text = "次に使用する[Arg1]枚の指令カードは追加で[Arg2]点のキーエネルギーを獲得する"
  },
  Skill_74903_Desc = {
    Text = "次に使用する[Arg1]枚の指令カードは追加で[Arg2]点のキーエネルギーを獲得する"
  },
  Skill_74903_Name = {
    Text = "価格は交渉可能"
  },
  Skill_74945_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気解放」の後、狂気が最も高い敵は[Arg1]の狂気を失い、<PVPEmptinessKeywords:空虚>を獲得します。"
  },
  Skill_74945_Name_1 = {
    Text = "催眠ペンデュラム"
  },
  Skill_74946_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン開始時、<HPAndShieldMin:ライフとシールドが最も低い>敵に [Arg1] の<PVPCardLockKeywords:カード封鎖>を与える。装備者がキルした後、即座にこの効果を一度発動する。"
  },
  Skill_74946_Name_1 = {
    Text = "魔女のつば広帽子"
  },
  Skill_76443_Desc = {
    Text = "10000点の毒を追加する"
  },
  Skill_76443_Name = {
    Text = "10000点の毒を追加する"
  },
  Skill_76444_Desc = {
    Text = "10000点の反撃を追加する"
  },
  Skill_76444_Name = {
    Text = "10000点の反撃を追加する"
  },
  Skill_76532_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン終了時、相手のランダムな手札[Arg1]枚に[Arg2]点の<PVPAcheKeywords:隠された痛み>を付与する。"
  },
  Skill_76532_Name_1 = {
    Text = "隠された痛み"
  },
  Skill_77673_Desc = {
    Text = "1枚の<DerivativeCardKeywords_133:「リアのコイン」>を捨て札に置く。"
  },
  Skill_77673_Name = {
    Text = "酒場の扉"
  },
  Skill_77678_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の「終末」を2点獲得。"
  },
  Skill_77678_Name = {
    Text = "機械パルス"
  },
  Skill_77680_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ランダムなカード3枚に「認知錯乱」を付与し、1ターンの<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<BlindingKeywords:盲目>状態を付与する。終末を2層失う。"
  },
  Skill_77680_Name = {
    Text = "意識干渉装置"
  },
  Skill_77681_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。2点の「終末」を獲得。"
  },
  Skill_77681_Name = {
    Text = "機械腕による攻撃"
  },
  Skill_77682_Desc = {
    Text = "深淵の門を閉じ、他の敵を除去する。半機械形態に転換し、すべてのライフを回復し、現在の「終末」の点数に応じて追加の最大ライフと15点の「融蝕の霧の盾」を獲得する。"
  },
  Skill_77682_Name = {
    Text = "機械昇華"
  },
  Skill_77683_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Poison:Arg3]点の<IntoxicationIconKeywords:毒>を付与する。「融蝕の核」を2枚山札に追加する。「終末」を3点失う。"
  },
  Skill_77683_Name = {
    Text = "融蝕発酵構造体"
  },
  Skill_77684_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。「終末」を3点獲得し、「深淵の門」を開き、毎ターン終了時に敵を補充する（最大2体）。"
  },
  Skill_77684_Name = {
    Text = "終点、真理と深淵の扉"
  },
  Skill_77685_Desc = {
    Text = "プレイヤーのライフ上限を[Arg1]にし、「終末」を3点失う。"
  },
  Skill_77685_Name = {
    Text = "トオワボ凝視装置"
  },
  Skill_77714_Desc = {
    Text = "「終末」を10点獲得し、[Arg1]点の<BleedingIconKeywords:出血>を付与する。終末が、まもなく到来する……！"
  },
  Skill_77714_Name = {
    Text = "システム再起動"
  },
  Skill_77846_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の<PowerIconKeywords:力>を獲得する。戦場に他の敵が1体生存しているごとに、「終末」を1点獲得する。他のすべての敵を撃破した場合、行動予測は「自滅改造」に転換する。"
  },
  Skill_77846_Name = {
    Text = "終末の呼び声"
  },
  Skill_77847_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Power:Arg3]点の<PowerIconKeywords:力>を獲得する。戦場に他の敵が1体生存しているごとに、「終末」を1点獲得する。他のすべての敵を撃破した場合、行動予測は「宿命崩壊」に変化する。"
  },
  Skill_77847_Name = {
    Text = "終末の呼び声"
  },
  Skill_77851_Desc = {
    Text = "2点の<WeaknessIconKeywords:虚弱>を付与し、[Arg2]点の<ReinforcePVEKeywords:堅固>を獲得する。"
  },
  Skill_77851_Name = {
    Text = "自滅改造"
  },
  Skill_77852_Desc = {
    Text = "[Poison:Arg1]点の<IntoxicationIconKeywords:毒>を付与する。ターン終了後、他の敵が[Power:Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_77852_Name = {
    Text = "宿命崩壊"
  },
  Skill_78648_Desc = {
    Text = "すべての人の最大ライフを1にする"
  },
  Skill_78648_Name = {
    Text = "トオワボ装置"
  },
  Skill_78782_AwakerSkillBackgroundStory = {
    Text = "揺れる振り子の中で、世界が消し去られていく。\nあなたの目に、あなたの心に、あなたの頭蓋の中に、残るのはただ一つの影。\nそれは救済であり、また行き止まりでもある。"
  },
  Skill_78782_BattleDesc = {
    Text = "<Heal:[Heal:Arg1]>ライフを[Arg2]回回復。すべての敵の<MadnessIconKeywords:発狂>状態を一時的に解除し、[Exhaustion:Arg3]点の<ExhaustionIconKeywords:力>を一時的に減少させる。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78782_Desc = {
    Text = "<Heal:[Heal:Arg1]>点のライフを回復し、敵のすべての<MadnessIconKeywords:狂気>状態を一時的に除去し、[Exhaustion:Arg3]点の<ExhaustionIconKeywords:力>を一時的に低下させる。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78782_EffectNameList = {
    Text = "回復,力低下,力"
  },
  Skill_78782_Name = {
    Text = "精神の慰め"
  },
  Skill_78782_PropertyNameList = {
    Text = "体質×$GrowValue1,防御力×$GrowValue2,攻撃力×$GrowValue3"
  },
  Skill_78783_AwakerSkillBackgroundStory = {
    Text = "彼女の声は優しく親しみに満ちている。あなたの見えない心の暗部で、絡みつき広がっていく。\n人は自分以外の存在に打ち負かされることはない。そしてあなた自身が、彼女の武器なのだ。"
  },
  Skill_78783_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。<Energy:[Energy:Arg5]>狂気を獲得。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78783_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを与える。クレメンタインは<Energy:[Energy:Arg3]>狂気を獲得。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78783_EffectNameList = {
    Text = "ダメージ,狂気,力"
  },
  Skill_78783_Name = {Text = "攻撃"},
  Skill_78783_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_78784_Desc = {
    Text = "自身の「共感」を1層除去するごとに、すべての敵に1層の「恐怖固着」を付与する。「恐怖固着」1層につき、対象が与えるダメージが3％低下する。"
  },
  Skill_78784_Name = {
    Text = "転化・恐怖固着"
  },
  Skill_78785_AwakerSkillBackgroundStory = {
    Text = "「教えてください、本当のあなたは誰ですか？」\nそう尋ねながら、彼女は笑い出した。\nあの哀れな患者はもちろん答えられない。記憶はすでに改竄され、追い求めるほど、植え付けられた記憶の中の恐ろしい存在に近づいていく――認知が完全に崩壊し、怪物と化すまで。"
  },
  Skill_78785_BattleDesc_0 = {
    Text = "自身のすべての<AnalysisKeywords0:共感>を除去し、<D13AFKeyWord2:心的外傷>または<D13AFKeyWord1:恐怖の固着>に変換する。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg6]回与え、<Posse:[Arg3]>キーエネルギーを獲得する。"
  },
  Skill_78785_BattleDesc_2 = {
    Text = "自身のすべての<AnalysisKeywords0:共感>を除去し、<D13AFKeyWord2:心的外傷>または<D13AFKeyWord1:恐怖の固着>に変換する。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg6]回与え、<Posse:[Arg3]>キーエネルギーを獲得する。"
  },
  Skill_78785_BattleDesc_3 = {
    Text = "自身のすべての<AnalysisKeywords3:共感>を除去し、<D13AFKeyWordQ2:心的外傷>または<D13AFKeyWordQ1:恐怖の固着>に変換する。1点除去するごとに、クレメンタインが与える基礎ダメージが3%増加する。すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg6]回与え、<Posse:[Arg3]>キーエネルギーを獲得する。"
  },
  Skill_78785_Desc_0 = {
    Text = "自身のすべての<AnalysisKeywords0:共感>を除去し、すべての敵の<D13AFKeyWord2:精神創傷>または<D13AFKeyWord1:恐怖固着>への転化を選択する。すべての敵に<Damage:[Damage:Arg1]>点のダメージを与え、[Arg2]％のクレメンタインのキーチャージ分のキーエネルギーを獲得。"
  },
  Skill_78785_Desc_2 = {
    Text = "自身のすべての<AnalysisKeywords0:共感>を除去し、<D13AFKeyWord2:心的外傷>または<D13AFKeyWord1:恐怖の固着>に変換する。1点除去するごとに、クレメンタインが与える基礎ダメージが3％増加する。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、クレメンタインのキーチャージ[Arg2]％分のキーエネルギーを獲得する。"
  },
  Skill_78785_Desc_3 = {
    Text = "自身のすべての<AnalysisKeywords3:共感>を除去し、<D13AFKeyWordQ2:心的外傷>または<D13AFKeyWordQ1:恐怖の固着>に変換する。1点除去するごとに、クレメンタインが与える基礎ダメージが3％増加する。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、クレメンタインのキーチャージ[Arg2]％分のキーエネルギーを獲得する。"
  },
  Skill_78785_EffectNameList = {
    Text = "ダメージ,キーエネルギー"
  },
  Skill_78785_Name = {
    Text = "生命再構築治療"
  },
  Skill_78785_OverLimitUtlSkillDesc_0 = {
    Text = "自身の全ての<AnalysisKeywords3:共感>を除去し、全ての敵の<D13AFKeyWordQ2:トラウマ>と<D13AFKeyWordQ1:恐怖の固着>に変換することを選択する。<Posse:[Arg4]> 点のキーエネルギーと [Power:Arg5] 点の<PowerIconKeywords:力>を得て、全ての敵に <Damage:[Damage:Arg1]> 点のダメージを [Arg6] 回与える。"
  },
  Skill_78785_OverLimitUtlSkillDesc_2 = {
    Text = "自身のすべての<AnalysisKeywords3:共感>を除去し、<D13AFKeyWordQ2:心的外傷>と<D13AFKeyWordQ1:恐怖の固着>に変換する。1点除去するごとに、クレメンタインが与える基礎ダメージが3%増加する。<Posse:[Arg4]>キーエネルギーと[Power:Arg5]点の<PowerIconKeywords:力>を獲得し、すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg6]回与える。"
  },
  Skill_78785_OverLimitUtlSkillDesc_3 = {
    Text = "自身のすべての<AnalysisKeywords3:共感>を除去し、<D13AFKeyWordQ2:心的外傷>と<D13AFKeyWordQ1:恐怖の固着>に変換する。1点除去するごとに、クレメンタインが与える基礎ダメージが3%増加する。<Posse:[Arg4]>キーエネルギーと[Power:Arg5]点の<PowerIconKeywords:力>を獲得し、すべての敵に<Damage:[Damage:Arg1]>ダメージを[Arg6]回与える。"
  },
  Skill_78785_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2％"
  },
  Skill_78786_AwakerSkillBackgroundStory = {
    Text = "血液が奔流し、魂が燃え上がる。肉と骨から搾り出された苦痛こそ、最高の美味。\nその美味は何度も味わわれる。最初の悲鳴から、絶望の喘ぎ、そして最後の沈黙した蒼白い死まで。"
  },
  Skill_78786_BattleDesc = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。 <Posse:[Arg6]>シルバーキーエネルギーを獲得。<WormholeKeywords:超距>：[Power:Arg5]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78786_Desc = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。クレメンタイン銀鍵チャージの[Arg3]％のキーエネルギーを獲得。<WormholeKeywords:超距>：[Power:Arg5]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78786_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_78786_Name = {
    Text = "苦痛の搾取"
  },
  Skill_78786_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_78787_AwakerSkillBackgroundStory = {
    Text = "カウンセリングはひとまず終わったが、彼女はあなたがいずれ戻ってくると知っている。\nこの世界は荒涼として残酷だ。ここだけが、わずかな救いがある場所。"
  },
  Skill_78787_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを[Arg2]回獲得。<Energy:[Energy:Arg5]>狂気を獲得。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78787_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。クレメンタインは<Energy:[Energy:Arg3]>狂気を獲得。<WormholeKeywords:超距>：[Power:Arg4]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_78787_EffectNameList = {
    Text = "シールド,狂気,力"
  },
  Skill_78787_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,攻撃力×GrowValue3"
  },
  Skill_78788_Desc = {
    Text = "自身の「共感」を1層除去するたびに、すべての敵に1層の「精神的トラウマ」を付与する。「精神的トラウマ」1層につき、対象が受けるダメージが3％増加する。"
  },
  Skill_78788_Name = {
    Text = "転化・精神創傷"
  },
  Skill_78789_AwakerSkillBackgroundStory = {
    Text = "見知らぬ嘶きが頭蓋に深く突き刺さり、記憶の中を駆け巡る。\nそれ以来、呼吸すら自分の意志ではなくなり、虫の匂いが漂う。\nこの呼びかけを感じ、受け入れ、そして脱皮し、新たに生まれ変わるのだ――\n我が友よ、我が同族よ。"
  },
  Skill_78789_Desc_0 = {
    Text = "クレメンタインは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：クレメンタインが毎ターン初めて使用する指令カードのダメージ、シールド、ライフ回復、狂気獲得、キーエネルギー獲得の回数が[Arg2]増加する。"
  },
  Skill_78789_Desc_15 = {
    Text = "クレメンタインは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：クレメンタインが与えるダメージ回数+1。毎ターン初めて使用する指令カードのダメージ、シールド、ライフ回復、狂気獲得、キーエネルギー獲得の回数が[Arg2]増加する。「共感」の上限が20まで増加する。"
  },
  Skill_78789_EffectNameList = {Text = "狂気"},
  Skill_78789_Name = {
    Text = "妖虫の呼び声"
  },
  Skill_78904_Desc_1 = {
    Text = "対象に最大ライフの[Arg1]%ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_78904_Desc_2 = {
    Text = "任意の対象の命輪を交換する。<Energy:[Energy:Arg2]> の狂気を獲得する。"
  },
  Skill_78904_Name_2 = {
    Text = "小さなアイデア"
  },
  Skill_78915_Desc_1 = {
    Text = "カードを[Arg1]枚引き、[Arg2]点の行動力を獲得。"
  },
  Skill_78915_Name_1 = {
    Text = "リアのコイン"
  },
  Skill_78936_Desc_1 = {
    Text = "[Arg1]枚の<PVPDerivativeCardKeywords_29:「リアのコイン」>を次のドローパイルに入れる。"
  },
  Skill_78936_Name_1 = {
    Text = "酒場の扉"
  },
  Skill_78936_UnknownName = {
    Text = "酒場の扉"
  },
  Skill_79252_Desc_1 = {
    Text = "テストリセット指令"
  },
  Skill_79252_Name_1 = {
    Text = "テストリセット指令"
  },
  Skill_79257_Desc_1 = {
    Text = "対象に最大ライフの[Arg1]%ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_79302_Name = {
    Text = "10000点の出血を追加する"
  },
  Skill_79478_Desc = {
    Text = "すべての手札を捨て、「虫族」のランダムな指令カードに置き換える。「虫族」は毎ターン狂気解放を2回発動可能。"
  },
  Skill_79478_Name = {
    Text = "巣の意志"
  },
  Skill_79758_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与えます。<WeaknessIconKeywords:弱り> を [Arg3] ターン付与します。"
  },
  Skill_79759_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。"
  },
  Skill_79760_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与える。"
  },
  Skill_79761_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターン<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_80035_BattleDesc = {
    Text = "「超次元超越」を行う"
  },
  Skill_80035_Desc = {
    Text = "「超次元超越」を行う"
  },
  Skill_80193_Desc_1 = {
    Text = "お互いに[Arg1]枚のカードを引く。"
  },
  Skill_80193_Name_1 = {
    Text = "特別治療"
  },
  Skill_80193_UnknownName = {
    Text = "特別治療"
  },
  Skill_80194_Desc = {
    Text = "ライフを<Heal:[Heal:Arg1]>回復し、[Arg2]点の力を獲得する。クレメンタインがチームにいる場合、彼女がこのターンで次に出す指令カードのダメージ、シールド、ライフ回復、狂気獲得、キーエネルギー獲得効果の回数が1増加する。"
  },
  Skill_80194_Name = {
    Text = "特殊な治療"
  },
  Skill_80355_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ターン開始時、ランダムに「認知錯乱」が付与されていない指令2枚に「認知錯乱」を付与する。"
  },
  Skill_80355_Name = {
    Text = "生命再構築治療"
  },
  Skill_80442_Desc = {
    Text = "ダメージ上昇 1 層"
  },
  Skill_80442_Name = {
    Text = "クレメンタインのダメージ増加"
  },
  Skill_80585_Desc = {
    Text = "「巣の捕食」を1枚手札に追加し、すべての覚醒体のクリティカル率が[Arg1]%減少する。"
  },
  Skill_80585_Name = {
    Text = "認知の抽出"
  },
  Skill_80586_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。このターンにクリティカルヒットを受けていた場合、行動予測は「認知の抽出」に転換する。"
  },
  Skill_80586_Name = {
    Text = "針を刺す"
  },
  Skill_80587_Desc = {
    Text = "デバフ状態を解除し、[Power:Arg1]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_80587_Name = {
    Text = "新たな人生へ"
  },
  Skill_80588_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_80588_Name = {
    Text = "突き刺す"
  },
  Skill_80589_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_80590_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<VulnerabilityIconKeywords:易傷>を付与。"
  },
  Skill_80590_Name = {Text = "齧る"},
  Skill_80591_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<MadnessIconKeywords:発狂>を獲得。"
  },
  Skill_80591_Name = {
    Text = "制御不能な追跡"
  },
  Skill_80605_Desc = {
    Text = "「巣の捕食」を[Arg1]枚手札に追加する。山札のランダムなカード[Arg2]枚に[Arg3]点の「遅延」を付与する。"
  },
  Skill_80605_Name = {
    Text = "神経毒素"
  },
  Skill_80606_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札に保持したカードに[Arg3]点の「遅延」を付与する。"
  },
  Skill_80606_Name = {
    Text = "精神寄生"
  },
  Skill_80607_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_80607_Name = {
    Text = "狩りの瞬間"
  },
  Skill_80608_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_80608_Name = {
    Text = "狩りの瞬間-破甲"
  },
  Skill_80609_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_80609_Name = {
    Text = "狩りの瞬間-重傷"
  },
  Skill_80749_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:力>と[Arg2]点の「古の残り火」を獲得する。"
  },
  Skill_80749_Name = {
    Text = "ヒステリー"
  },
  Skill_80750_Desc = {
    Text = "この行動予測に転換した後、このターンに受けるアクティブダメージが100%増加する。発動後、[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_80750_Name = {Text = "潜伏"},
  Skill_80751_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の毒を付与する。シールド1点につき、ダメージが1減少する。このダメージで「死亡抵抗」が発動した場合、残りの「死亡抵抗」は半減する。"
  },
  Skill_80751_Name = {
    Text = "毒針の散弾"
  },
  Skill_80752_Desc = {
    Text = "<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を[AttackTimes:Arg2]回与える。失ったライフの[Arg3]%を回復し、「宇宙のエーテル」1点につき、最大ライフが[Arg5]%増加する。[Arg4]点の「宇宙の輪廻」を獲得：致命的なダメージを受けた場合、すべてのライフを回復し、30点の一時的な堅固を獲得する。"
  },
  Skill_80752_Name = {
    Text = "変異の瞬間"
  },
  Skill_80753_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。手札に保持したカードに[Arg3]点の「遅延」を付与する。「巢群の捕食」を1枚手札に追加する。"
  },
  Skill_80753_Name = {
    Text = "精神寄生"
  },
  Skill_80754_Desc = {
    Text = "1点の「宇宙のエーテル」を除去し、「隠密」状態に移行する。[Arg1]体の「虫族」を召喚し、それらは毎ターン[Arg2]点の<MadnessIconKeywords:発狂>を獲得する。すべての敵が死亡すると「隠密」は解除される。"
  },
  Skill_80754_Name = {
    Text = "同族召喚"
  },
  Skill_80755_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「巢群の捕食」を[Arg3]枚手札に追加する。このターンに「古の残り火」がすべて除去された場合、ダメージのない「神経毒素」に変化する。"
  },
  Skill_80755_Name = {
    Text = "猛毒散布"
  },
  Skill_80756_Desc = {
    Text = "この行動予測に転換した後、このターンに受けるアクティブダメージが100％増加する。発動後、[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_80756_Name = {Text = "潜伏"},
  Skill_80757_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。対象の失ったライフ[Arg3]%ごとに、ダメージ回数が1回増加する。「宇宙のエーテル」がある場合、1点を除去し、1点の<MadnessIconKeywords:発狂>を獲得する。"
  },
  Skill_80757_Name = {
    Text = "痛烈な切り裂き"
  },
  Skill_80758_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。シールド1点につき、ダメージが1減少する。「宇宙のエーテル」がある場合、1点を除去し、[Power:Arg3]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_80758_Name = {
    Text = "次元の亀裂"
  },
  Skill_80759_Desc = {
    Text = "1点の「宇宙のエーテル」を除去し、「隠密」状態に移行する。[Arg1]体の「虫族」を召喚し、それらは毎ターン[Arg2]点の<MadnessIconKeywords:発狂>を獲得する。すべての敵が死亡すると「隠密」は解除される。"
  },
  Skill_80759_Name = {
    Text = "同族召喚"
  },
  Skill_80760_Desc = {
    Text = "この行動予測に転換した後、このターンに受けるダメージが100%増加する。発動後、[Arg1]点の<WeaknessIconKeywords:虚弱>と<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_80760_Name = {Text = "休眠"},
  Skill_80762_Desc = {
    Text = "「変質体」を[Arg1]体前列に召喚する。"
  },
  Skill_80762_Name = {
    Text = "幼虫の飼育"
  },
  Skill_80763_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。「巢群の捕食」を[Arg3]枚手札に追加する。このターンに「古の残り火」がすべて除去された場合、低ダメージの「精神寄生」に転換する。"
  },
  Skill_80763_Name = {
    Text = "苦痛の拡散"
  },
  Skill_80764_Desc = {
    Text = "[Arg1]点の「虚空のエーテル」を獲得し、すべての覚醒体のクリティカル率を[Arg4]%減少させる。次のターン開始時に覚醒体を[Arg2]体選択し、そのすべての指令カードと狂気解放を[Arg3]ターン封印する。"
  },
  Skill_80764_Name = {
    Text = "意識の幽閉"
  },
  Skill_80765_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の毒を付与する。シールド1点につき、ダメージが1減少する。このダメージで「死亡抵抗」が発動した場合、残りの「死亡抵抗」は半減する。"
  },
  Skill_80765_Name = {
    Text = "毒針の散弾"
  },
  Skill_80766_Desc = {
    Text = "「変質体」を[Arg1]体前列に召喚する。"
  },
  Skill_80766_Name = {
    Text = "幼虫の飼育"
  },
  Skill_80767_Desc = {
    Text = "「巣の捕食」を[Arg1]枚手札に追加する。山札のランダムなカード[Arg2]枚に[Arg3]点の「遅延」を付与する。"
  },
  Skill_80767_Name = {
    Text = "神経毒素"
  },
  Skill_80768_Desc = {
    Text = "「巣の捕食」を[Arg1]枚手札に追加する。山札のランダムなカード[Arg2]枚に[Arg3]点の「遅延」を付与する。"
  },
  Skill_80768_Name = {
    Text = "神経毒素"
  },
  Skill_80769_Desc = {
    Text = "「最初の変異体」を[Arg1]体前列に召喚する。1点の一時的な<MadnessIconKeywords:発狂>を獲得。"
  },
  Skill_80769_Name = {Text = "擬態"},
  Skill_80969_Desc = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを[AttackTimes:Arg2]回与え、<MadnessIconKeywords:狂気>を1層得る。覚醒カードを使用すると意図が「痛苦榨取」に変わる。"
  },
  Skill_80969_Name = {
    Text = "心理的絞殺"
  },
  Skill_81071_Desc = {
    Text = "「変質体」を[Arg1]体前列に召喚する。"
  },
  Skill_81071_Name = {
    Text = "幼虫の飼育"
  },
  Skill_81267_Desc = {
    Text = "超次元空間を満たす"
  },
  Skill_81267_Name = {
    Text = "超次元空間を満たす"
  },
  Skill_81296_Desc = {
    Text = "ターン終了時にこのカードが手札にある場合、ライフ上限を[Arg1]点失い、これを<DepleteIconKeywords:除去>する。使用後、前列の敵に[Arg2]点の「古の残り火」を付与し、このカードを山札の底に戻す。"
  },
  Skill_81296_Name = {
    Text = "巣の捕食"
  },
  Skill_81300_Desc = {
    Text = "「よろめく」、「息絶」、「サンゴの寄生」、「冒涜の幻想」、「豪放」から1枚を選んで手札に加え、残りの四枚を捨て札の山に置く。"
  },
  Skill_81300_Name = {
    Text = "世界演繹法"
  },
  Skill_81343_Desc = {
    Text = "1層の「宇宙幽能」を除去し、<WeaknessIconKeywords:虚弱>と<HeavyInjuryKeywords:重創>を[Arg1]ターン付与し、ドローデッキの[Arg2]枚の指令カードに「認知錯乱」を適用する。"
  },
  Skill_81343_Name = {
    Text = "虫巣の干渉"
  },
  Skill_81433_Desc = {
    Text = "すべての覚醒体の<CardKeyWord:封印>とクリティカル率低下効果を解除し、敵の「堅固」を除去する。前のターンで最後に使用した5枚の異なる非派生指令カードの未強化コピーを手札に追加し、それらの行動力消費を0にし、<DepleteIconKeywords:除外>と<NothingnessIconKeywords:虚無>を付与する。"
  },
  Skill_81433_Name = {
    Text = "遡行救援"
  },
  Skill_83574_BattleDesc = {
    Text = "全ての「帆を揚げる」（[Arg1]）を除去する。1 層除去するごとに最終ダメージが[Arg2]％上昇し、全ての覚醒体が[Arg3]点の狂気を獲得する。\n一度に 5 層以上の「帆を揚げる」を除去した場合、全ての敵を 1 ターン<VulnerabilityIconKeywords:易傷>にし、失われたライフの[Arg4]％の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_83574_Desc = {
    Text = "全ての「帆を揚げる」を除去する。1 層除去するごとに最終ダメージが 10％上昇し、全ての覚醒体が狂気を 5 点獲得する。\n一度に 5 層以上の「帆を揚げる」を除去した場合、全ての敵を 1 ターン<FixedDamage:易傷>にし、失われたライフの 35％の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_83574_Name = {
    Text = "荒波の出航"
  },
  Skill_83575_BattleDesc = {
    Text = "すべての「停泊」([Arg1])を解除する。1点解除するごとに、死亡抵抗+[Arg2]%、[Arg3]点の行動力を獲得し、カードを[Arg4]枚引く。\n一度に5点以上の「停泊」を解除した場合、[Arg5]点の一時的な<ParcloseIconKeywords:バリア>を獲得する。"
  },
  Skill_83575_Desc = {
    Text = "すべての「停泊」を解除する。1点解除するごとに、「死亡抵抗」+15%、1点の行動力を獲得し、カードを1枚引く。\n一度に5点以上の「停泊」を解除した場合、1点の「バリア」を獲得する。"
  },
  Skill_83575_Name = {
    Text = "休息の寄港"
  },
  Skill_83576_BattleDesc = {
    Text = "選択：「荒波の出航」( [Arg1] ) または「休息の寄港」( [Arg2] )。捨てた場合、それを<DepleteIconKeywords:除外>する。"
  },
  Skill_83576_Desc = {
    Text = "選択：「荒波の出航」 または 「休息の寄港」。捨てた場合、これを<DepleteIconKeywords:除外>する。"
  },
  Skill_83576_Name = {
    Text = "航海士の選択"
  },
  Skill_83779_AwakerSkillBackgroundStory = {
    Text = "果てなき塩水が彼女を飲み込み、同時に彼女を守った。\n息が詰まるような沈みゆく感覚の中で、彼女は深淵なる海を感じ、海と一体となった。\nやがて海は静まり返り、波上を行くすべての船に平穏がもたらされるだろう。\n彼女はその日を待っている——「神の国が降臨する日」を。"
  },
  Skill_83779_Desc_0 = {
    Text = "コーパサントは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：触腕を1本獲得。「<DerivativeCardKeywords_106:航行>」を2枚手札に追加。「静海」姿勢に切り替えた後、<Block:[Block:Arg2]>点のシールドを獲得する。クールダウン3ターン。"
  },
  Skill_83779_Desc_15 = {
    Text = "コーパサントは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：触腕を1本獲得。「<DerivativeCardKeywords_106:航行>」を2枚手札に追加。毎ターン初めて使用する「制裁の雷霆」と「混沌の手旗信号」は、「<DerivativeCardKeywords_106:航行>」を1枚を手札に追加する。「<DerivativeCardKeywords_106:航行>」の効果が50%増加する。「静海」姿態に切り替えた後、<Block:[Block:Arg2]>点のシールドを獲得する。クールダウン3ターン。"
  },
  Skill_83779_EffectNameList = {
    Text = "狂気,シールド"
  },
  Skill_83779_Name = {
    Text = "遠き海に沈む"
  },
  Skill_83779_PropertyNameList = {
    Text = "$GrowValue1,防御力×GrowValue2"
  },
  Skill_83780_AwakerSkillBackgroundStory = {
    Text = "雲は天候の変化を告げ、波は潮の流れを語る。だがひとたび嵐が来れば、いかに巨大な船であろうと、無力に流されるほかない。\nその瞬間、航法士の計算と指示は、すべての生存者にとって最後の活路となる。\nゆえに、自らの責務を果たすのだ。たとえ雷に打たれようとも、苦痛の中で一筋の光を放ち、陸への道を指し示せ。\nそれが、お前の果たすべき使命なのだ。"
  },
  Skill_83780_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]本の一時的な触腕を獲得。すべての手札を捨て、同数のカードを引く。"
  },
  Skill_83780_BattleDesc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]本の一時的な触腕を獲得。すべての敵に1点の<VulnerabilityIconKeywords:脆弱>を付与する。一時的なクリティカルダメージ+[Arg5]％。すべての手札を捨て、同数のカードを引く。"
  },
  Skill_83780_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]本の一時的な触腕を獲得。すべての手札を捨て、同数のカードを引く。"
  },
  Skill_83780_Desc_3 = {
    Text = "<Block:[Block:Arg1]>点のシールドと[Arg2]本の一時的な触腕を獲得。すべての敵に1点の<VulnerabilityIconKeywords:弱体>を付与する。一時的なクリティカルダメージが[Arg3]％増加し、この戦闘中、死亡抵抗が1回発動するごとに追加で[Arg4]％増加する。すべての手札を捨て、同数のカードを引く。"
  },
  Skill_83780_EffectNameList = {
    Text = "シールド"
  },
  Skill_83780_Name = {
    Text = "淵海を照らす導き"
  },
  Skill_83780_OverLimitUtlSkillDesc_0 = {
    Text = "手札をすべて捨て、同枚数のカードを引く。捨てたカードの「余波」効果を追加で1回発動する。<Block:[Block:Arg1]>点のシールド・[Arg2]本の一時的なタッチアーム・[Arg2]本の永久的なタッチアームを獲得。"
  },
  Skill_83780_OverLimitUtlSkillDesc_3 = {
    Text = "すべての敵に1点の<VulnerabilityIconKeywords:脆弱>を付与する一時的なクリティカルダメージ+[Arg5]％。すべての手札を捨て、同数のカードを引き、捨てたカードの「余波」効果をもう一度発動する。<Block:[Block:Arg1]>点のシールド、[Arg2]本の一時的な触腕、[Arg2]本の永久的な触腕を獲得。"
  },
  Skill_83780_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_83781_AwakerSkillBackgroundStory = {
    Text = "彼女は船の「言語」でもある。広い海において、旗を掲げて仲間たちを導く。"
  },
  Skill_83781_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点 のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_83781_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg4]>狂気を獲得。<RippleKeywords:余波>：次の使用時に獲得する狂気が[Arg3]増加、最大2回。"
  },
  Skill_83781_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。コーパサントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_83781_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。コーパサントは<Energy:[Energy:Arg4]>狂気を獲得。<RippleKeywords:余波>：次の使用時に獲得する狂気が[Arg3]増加、最大2回。"
  },
  Skill_83781_EffectNameList_0 = {
    Text = "シールド、狂気"
  },
  Skill_83781_EffectNameList_1 = {
    Text = "シールド、狂気"
  },
  Skill_83781_PropertyNameList_0 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_83781_PropertyNameList_1 = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_83782_AwakerSkillBackgroundStory = {
    Text = "彼女は船の「頭脳」である。停泊であれ出航であれ、常に最も合理的な判断を下す。"
  },
  Skill_83782_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_83782_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg4]>狂気を獲得。<RippleKeywords:余波>：次の使用時に獲得する狂気が[Arg3]増加、最大2回。"
  },
  Skill_83782_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。コーパサントは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_83782_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。コーパサントは <Energy:[Energy:Arg4]>狂気を獲得。<RippleKeywords:余波>：次の使用時に獲得する狂気が[Arg3]増加、最大2回。"
  },
  Skill_83782_EffectNameList_0 = {
    Text = "ダメージ,狂気"
  },
  Skill_83782_EffectNameList_1 = {
    Text = "ダメージ,狂気"
  },
  Skill_83782_Name = {Text = "攻撃"},
  Skill_83782_PropertyNameList_0 = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_83782_PropertyNameList_1 = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_83783_AwakerSkillBackgroundStory = {
    Text = "手旗信号は普遍的であると同時に、私的なものでもある。\n意識が次元の扉を越え、神を見たその瞬間、コーパサントは特別な手旗信号を授かった。\nその冒涜的な一振りはすべて、偉大なる存在の呼び声への応答なのだ。"
  },
  Skill_83783_Desc_0 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。「<DerivativeCardKeywords_106:航行>」を[Arg2]枚手札に追加する。"
  },
  Skill_83783_Desc_15 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。「<DerivativeCardKeywords_106:航海>」を[Arg2]枚手札に追加する。すべての敵に1ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_83783_Desc_2 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。「<DerivativeCardKeywords_106:航海>」を[Arg2]枚手札に追加する。すべての敵に1ターンの<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_83783_EffectNameList = {Text = "狂気"},
  Skill_83783_Name = {
    Text = "混沌の手旗信号"
  },
  Skill_83784_AwakerSkillBackgroundStory = {
    Text = "怒りに駆られたときでさえ、コーパサントは理性的だ。\n彼女はまず相手の過ちを評価し、その程度に応じて与えるべき罰を決定する。\n広大な海の上では、秩序がなければ、殺戮と裏切りがすべてを飲み込んでしまうのだ。"
  },
  Skill_83784_Desc_0 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Arg3]%の触腕ダメージボーナスを獲得する。ダメージを与えるたび、対象がこのターンに受ける触腕ダメージが[Arg4]%増加する。「<DerivativeCardKeywords_106:航行>」を[Arg5]枚手札に追加する。<RippleKeywords:余波>：このカードを山札の一番上に戻す。"
  },
  Skill_83784_Desc_15 = {
    Text = "ランダムに<Damage:[Damage:Arg1]>ダメージを[Arg2]回与え、[Arg3]%の触腕ダメージボーナスを獲得する。ダメージを与えるたび、対象がこのターンに受ける触腕ダメージが[Arg4]%増加する。「<DerivativeCardKeywords_106:航行>」を[Arg5]枚手札に追加する。<RippleKeywords:余波>：このカードを山札の一番上に戻す。"
  },
  Skill_83784_EffectNameList = {
    Text = "ダメージ,触腕ダメージボーナス"
  },
  Skill_83784_Name = {
    Text = "制裁の雷霆"
  },
  Skill_83784_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2％"
  },
  Skill_84228_BattleDesc_1 = {
    Text = "ランダムに[Arg3]回 <Damage:[Damage:Arg1]> ダメージを与える。[Arg2] <PVPProtectiveKeywords:障壁>を持つごとに追加で1回ダメージを与える。"
  },
  Skill_84228_Desc_1 = {
    Text = "ランダムに3回 <Damage:[Damage:Arg1]> ダメージを与える。[Arg2] <PVPProtectiveKeywords:バリア> を持つごとにさらに1回ダメージを与える。"
  },
  Skill_84228_Name_1 = {
    Text = "雷嵐の怒り"
  },
  Skill_84229_Desc_1 = {
    Text = "味方の一人に [Arg1] 層<PVPProtectiveKeywords:バリア>、<PVPPenetrateKeywords:刺突> を与えます。"
  },
  Skill_84229_Name_1 = {
    Text = "深海を照らす航路"
  },
  Skill_84230_Desc_1 = {
    Text = "味方1体のライフを<Heal:[Heal:Arg1]>回復。"
  },
  Skill_84230_Name_1 = {
    Text = "冥海の息吹"
  },
  Skill_84231_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_84231_Name_1 = {Text = "攻撃"},
  Skill_84232_Desc_1 = {
    Text = "<StrengthenKeywords:強化>：味方1体を強化し、<Energy:[Energy:Arg1]>狂気を与える。"
  },
  Skill_84232_Name_1 = {
    Text = "潮汐の鼓舞"
  },
  Skill_84261_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン開始時、自身に<PVPProtectiveKeywords:バリア>がない場合は[Arg1]点の<PVPProtectiveKeywords:バリア>を獲得し、ある場合は<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_84261_Name_1 = {
    Text = "聖なる炎の導き"
  },
  Skill_84262_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：ターン終了時、ライフが最も少ない味方を<Heal:[Heal:Arg1]>ライフ回復する。"
  },
  Skill_84262_Name_1 = {
    Text = "海上の航行者"
  },
  Skill_84263_Desc_1 = {
    Text = "すべての味方に[Arg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  Skill_84263_Name_1 = {
    Text = "不滅の雷光"
  },
  Skill_84263_UnknownName = {
    Text = "不滅の雷光"
  },
  Skill_84357_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<RippleKeywords:余波>： [Power:Arg2]点の<PowerIconKeywords:力>と [TentaclePower:Arg2]点の触腕ダメージを獲得。"
  },
  Skill_84357_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<RippleKeywords:余波>： [Power:Arg2]点の<PowerIconKeywords:力>と [TentaclePower:Arg2]点の触腕ダメージを獲得。"
  },
  Skill_84357_Name = {Text = "航行"},
  Skill_84378_Desc = {
    Text = "[Arg1]シールドを獲得し、[Arg2]枚のカードを引く。クーパーサンがチームにいる場合、「航行」を1枚手札に加える。"
  },
  Skill_84378_Name = {
    Text = "不滅の雷光"
  },
  Skill_84383_BattleDesc = {
    Text = "ダメージを[Arg2]回与え、「症状：発狂」を[Arg3]枚山札に追加する。"
  },
  Skill_84383_Desc = {
    Text = "制裁の雷霆：ダメージを3回与える。「症状：発狂」を1枚山札の一番上に追加する。"
  },
  Skill_84383_Name = {
    Text = "制裁の雷霆"
  },
  Skill_84384_BattleDesc = {
    Text = "自身の力が[Arg1]増加し、[Arg2]点の<ParcloseIconKeywords:バリア>を獲得する。5点の<ReinforcePVEKeywords:堅固>を獲得する。次のターンの開始時、バリア1点につき1点の<ReinforcePVEKeywords:堅固>に変換する。"
  },
  Skill_84384_Desc = {
    Text = "深淵を照らす導き：自身の力が攻撃力×0.05増加し、8点のバリアを獲得。次のターン開始時、バリア1点につき1点の堅固に変換する。"
  },
  Skill_84384_Name = {
    Text = "深淵を照らす導き"
  },
  Skill_84385_BattleDesc = {
    Text = "<WeaknessIconKeywords:虚弱>を解除する。自身の力が[Arg1]増加し、受けるダメージが[Arg2]%増加する。「制裁の雷霆」のダメージ回数が[Arg3]増加する。"
  },
  Skill_84385_Desc = {
    Text = "死へ赴く天の火：虚弱を解除する。自身の力が攻撃力×0.1増加し、受けるダメージが10%増加する。「制裁の雷霆」のダメージ回数が1回増加する。"
  },
  Skill_84385_Name = {
    Text = "死へ赴く天の火"
  },
  Skill_84387_BattleDesc = {
    Text = "ダメージを[Arg2]回与え、[Arg3]点の<VulnerabilityIconKeywords:易傷>を付与する。「症状：発狂」を[Arg4]毎山札に追加する。"
  },
  Skill_84387_Desc = {
    Text = "制裁の雷霆覚醒版：ダメージを4回与え、2点の易傷を付与する。「症状：発狂」を1枚山札の一番上に追加する。"
  },
  Skill_84387_Name = {
    Text = "制裁の雷霆"
  },
  Skill_84388_BattleDesc = {
    Text = "ダメージを[Arg2]回与え、[Arg3]点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_84388_Desc = {
    Text = "混沌の手旗信号：ダメージを1回与え、2点の虚弱を付与する。"
  },
  Skill_84388_Name = {
    Text = "混沌の手旗信号"
  },
  Skill_84404_BattleDesc = {
    Text = "「制裁の雷霆」のダメージ回数が[Arg2]回増加する。「遠き海に沈む」状態を獲得：毎ターン終了時に受けるダメージが[Arg3]%増加し 、[Arg4]点のバリアを獲得。"
  },
  Skill_84404_Desc = {
    Text = "遠き海に沈む：「制裁の雷霆」のダメージ回数が1回増加する。「遠き海に沈む」状態を獲得：毎ターン終了時に受けるダメージが5%増加し、2点のバリアを獲得。"
  },
  Skill_84404_Name = {
    Text = "遠き海に沈む"
  },
  Skill_89423_Desc_1 = {
    Text = "敵と味方の全ての他のキャラクターに <Damage:[Damage:Arg1]> ダメージを与え、同量のダメージのシールドを得る。"
  },
  Skill_89423_Name_1 = {
    Text = "死のハリケーン"
  },
  Skill_89424_Desc_1 = {
    Text = "仲間1名を選択し、1枚の<PVPDerivativeCardKeywords_16:「黒羽」>を得ます。"
  },
  Skill_89424_Name_1 = {
    Text = "漆黒の雨"
  },
  Skill_89425_Desc_1 = {
    Text = "<StrongEffectKeywords:強力>＋[Arg1]、全ての味方が1枚の<PVPDerivativeCardKeywords_16:「ブラックフェザー」>を獲得。"
  },
  Skill_89425_Name_1 = {
    Text = "不屈と孤高の鳥"
  },
  Skill_89426_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、HPとシールドが最も低い味方に[Arg1]枚の<PVPDerivativeCardKeywords_16:「黒羽」>を付与する。"
  },
  Skill_89426_Name_1 = {
    Text = "孤高の羽"
  },
  Skill_89427_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_89427_Name_1 = {Text = "攻撃"},
  Skill_89428_Desc_1 = {
    Text = "前列に <Damage:[Damage:Arg1]> ポイントのダメージを与え、同量の狂気を獲得し、[Arg2] 層の<PVPProtectiveKeywords:バリア>を得る。"
  },
  Skill_89428_Name_1 = {Text = "黒い羽"},
  Skill_89429_Desc_1 = {
    Text = "<TauntKeywords:挑発>、味方全体の<StrongEffectKeywords:強力> +[Arg1]。"
  },
  Skill_89429_Name_1 = {
    Text = "庇護の意志"
  },
  Skill_89430_Desc_1 = {
    Text = "<PVPWeaponKeywords:命カルマ>：手札上限 +[Arg2]。「狂気爆発」後、演算力を[Arg1]獲得する。"
  },
  Skill_89430_Name_1 = {
    Text = "耐え難き自由"
  },
  Skill_89532_Desc_1 = {
    Text = "1名の味方を選び、[Arg1] 枚の<PVPDerivativeCardKeywords_16:「黒羽」>を得る。"
  },
  Skill_89532_Name_1 = {
    Text = "ずれゆく運命"
  },
  Skill_89532_UnknownName = {
    Text = "ずれゆく運命"
  },
  Skill_89563_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備者が死亡した後、自身の行動力消費が-[Arg1]されたすべての「スキル」を山札のランダムな位置に追加し、所有者を残りライフが最も高い味方に変更する。"
  },
  Skill_89563_Name_1 = {
    Text = "滅土からの再生"
  },
  Skill_89659_Desc_1 = {
    Text = "カードを[Arg1]枚引き、[Arg2]点の行動力を獲得。"
  },
  Skill_89659_Name_1 = {Text = "啓示"},
  Skill_89750_Desc = {
    Text = "待機……"
  },
  Skill_89750_Name = {Text = "待つ"},
  Skill_89776_AwakerSkillBackgroundStory = {
    Text = "「兄さん、翼でずっと飛び続けたら、どこまで高く行けると思う？雲の上まで飛んで、月や星に触れることもできるかな？」\n「きっと……できるんじゃないか？そのためには、とても大きくて力強い翼が必要だがな」\n写本に描かれた深く幻想的な銀河と星座は、二人の子どもたちの夢の中に映り込み、願いの種となって、彼らの心の中に埋もれていった。"
  },
  Skill_89776_Desc_0 = {
    Text = "カストルは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：カストルが与えるダメージは必ずクリティカルになり、「<DerivativeCardKeywords_107:ブラックフェザー>」発射後に対象へ [Corrosion:Arg2] 層の<Corrosion:侵蝕>を付与し、保留のシールドが50％増加する。"
  },
  Skill_89776_Desc_15 = {
    Text = "カストルは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：カストルが与えるダメージは必ずクリティカルになり、「<DerivativeCardKeywords_107:ブラックフェザー>」発射後に対象へ [Corrosion:Arg2] 層の<Corrosion:侵蝕>を付与し、保留のシールドが 50％ 増加する。毎ターン初めてブラックフェザーを発射した際、前列の敵に天賦「罪を洗う聖なる羽」と同等の侵蝕を与え、侵蝕除去時に失うライフが 300％ から 500％ に増加する。"
  },
  Skill_89776_EffectNameList = {
    Text = "狂気,侵蝕"
  },
  Skill_89776_Name = {
    Text = "飛翔の願い"
  },
  Skill_89776_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_89777_AwakerSkillBackgroundStory = {
    Text = "彼が戦いの術を教わったことは一度もなかった。だが、抗う力はすでに彼の本能に根付いていた。"
  },
  Skill_89777_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黑羽>」1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89777_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。カストルは<Energy:[Energy:Arg2]>狂気を獲得。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89777_EffectNameList = {
    Text = "ダメージ、狂気、超距シールド"
  },
  Skill_89777_Name = {Text = "攻撃"},
  Skill_89777_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2,防御力×GrowValue3"
  },
  Skill_89778_AwakerSkillBackgroundStory = {
    Text = "彼は愚かで、頑固で、決して変わることはない。たとえ孤独な叫びしかあげられなくとも、いかなる鎖や刃にも屈することはない。彼は、すり減ることのない鋭い嘴で、牢獄のあらゆるひびを突き続けるだろう。黒い翼が夜の縁を突き破るとき、彼はその最後の羽をくわえ、自らの影とともに、嵐の向こうにある光へと飛び立つのだ。"
  },
  Skill_89778_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。「<DerivativeCardKeywords_107:黒羽>」を[Arg2] 枚山札に追加。"
  },
  Skill_89778_EffectNameList = {
    Text = "シールド"
  },
  Skill_89778_Name = {
    Text = "孤高なる不屈の鳥"
  },
  Skill_89778_OverLimitUtlSkillDesc = {
    Text = "<Block:[Block:Arg1]> 点のシールドを獲得し、本ターン「<DerivativeCardKeywords_107:ブラックフェザー>」保留のシールドの増加 <Block:[Block:Arg5]>、「<DerivativeCardKeywords_107:ブラックフェザー>」を発射するたびに追加でターゲットに [Corrosion:Arg4] スタックの<Corrosion:侵蝕>を付与する。[Arg2] 枚の「<DerivativeCardKeywords_107:ブラックフェザー>」をドロー山にシャッフルし、[Arg3] 枚の「<DerivativeCardKeywords_107:ブラックフェザー>」を手札に加える。"
  },
  Skill_89778_PropertyNameList = {
    Text = "防御力×GrowValue1"
  },
  Skill_89779_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg2]>ダメージを与え、[Arg1]枚のカードを引く。保持：<Block:[Block:Arg3]>点のシールドを獲得。除外。"
  },
  Skill_89779_BattleDesc_3 = {
    Text = "<Damage:[Damage:Arg2]>ダメージを与え、[Arg1]枚のカードを引く。3枚使用するごとに1点の行動力を獲得し、カストルが与える最終ダメージが10％増加する ([Arg4]/3)。保持：<Block:[Block:Arg3]>点のシールドを獲得。除外。"
  },
  Skill_89779_Desc_0 = {
    Text = "<Damage:[Damage:Arg2]>ダメージを与え、[Arg1]枚のカードを引く。保持：<Block:[Block:Arg3]>点のシールドを獲得。除外。"
  },
  Skill_89779_Desc_3 = {
    Text = "<Damage:[Damage:Arg2]>ダメージを与え、[Arg1]枚のカードを引く。3枚使用するごとに1点の計算力を獲得し、カストルが与える最終ダメージが10％増加する。保持：<Block:[Block:Arg3]>点のシールドを獲得。除外。"
  },
  Skill_89779_Name = {Text = "黒羽"},
  Skill_89780_AwakerSkillBackgroundStory = {
    Text = "残酷な搾取に抗い、繰り返される喪失に立ち向かうため、彼はその翼を常に弟の前で広げ続けるだろう。すべての羽が灰と化し、自らが死の扉をくぐる、その時まで。"
  },
  Skill_89780_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89780_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。カストルは<Energy:[Energy:Arg2]>狂気を獲得。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89780_EffectNameList = {
    Text = "シールド,狂気,超距シールド"
  },
  Skill_89780_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2,防御力×GrowValue3"
  },
  Skill_89781_AwakerSkillBackgroundStory = {
    Text = "彼の翼が大きく広がる。それはまるで巨大な盾のようで、一本一本の羽が頑丈な骨格に連なり、あなたの頭上でさらさらと揺れている。\nその黒い影はあなたを包み込み、あらゆる陽光や風雨、そして悪意さえも遮って、穏やかな空を作り出す。\n「それに触れるな。この闇の呪いはすべて、危害を加える者たちの胸へと返してやればいい」"
  },
  Skill_89781_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与する。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89781_Desc_2 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得し、すべての敵に1点の<WeaknessIconKeywords:虚弱>を付与する。手札に「<DerivativeCardKeywords_107:黒羽>」が1枚あるごとに、<Energy:[Energy:Arg2]>狂気を獲得。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg3]>点のシールドを獲得。"
  },
  Skill_89781_EffectNameList = {
    Text = "シールド、超距シールド"
  },
  Skill_89781_Name = {
    Text = "日を蔽う羽"
  },
  Skill_89781_PropertyNameList = {
    Text = "防御力×GrowValue1,防御力×GrowValue2"
  },
  Skill_89782_AwakerSkillBackgroundStory = {
    Text = "彼はただ耐え続ける者ではない。その双翼は、激しい怒りの渦を巻き起こすこともできる。吹き荒れる風の鋭い牙はすべてを切り刻み、滴る血もろとも死の喉奥へと放り込む。だが恐れることはない。あなたの名は、嵐の目——その最も中心にある静寂に置かれている。"
  },
  Skill_89782_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。他の味方の一時的なクリティカルダメージが[Arg3]％増加する。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:黒羽>」を1枚山札に追加し、<Block:[Block:Arg4]>点のシールドを獲得。"
  },
  Skill_89782_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [Arg2] 回与える。他の味方の一時的なクリティカルダメージが [Arg3]％ 増加する。このターン中、「<DerivativeCardKeywords_107:ブラックフェザー>」を使用するごとに、行動力消費が1減少する。<WormholeKeywords:超距>：「<DerivativeCardKeywords_107:ブラックフェザー>」を1枚ドロー山にシャッフルし、<Block:[Block:Arg4]> 点のシールドを獲得。"
  },
  Skill_89782_EffectNameList = {
    Text = "ダメージ、クリティカルダメージ比率、超距シールド"
  },
  Skill_89782_Name = {
    Text = "永夜を穿つ"
  },
  Skill_89782_PropertyNameList = {
    Text = "攻撃力×GrowValue1,$GrowValue2％,防御力×GrowValue3"
  },
  Skill_89949_Desc = {
    Text = "ランダムな3つの「キーオーダー」から1つを選んで発動する。各解放済み「キーオーダー」はこの探索中1回しか選択できず、初期装備の「キーオーダー」は選択不可。"
  },
  Skill_89949_Name = {
    Text = "封じられた記憶"
  },
  Skill_90212_Desc = {
    Text = "覚醒体を1名選択し、<Energy:[Energy:Arg3]>狂気を獲得させ、山札から最も行動力消費が低いカードを[Arg2]枚を引く。カストルがチームにいる場合、ダメージ強化が一時的に[Arg1]%増加する。"
  },
  Skill_90212_Name = {
    Text = "すれ違う運命"
  },
  Skill_90565_Desc = {
    Text = "「祭霊夜 特製ブレンド」に追加：[Arg1]キーエネルギーを獲得。"
  },
  Skill_90565_Name = {
    Text = "無垢の銀"
  },
  Skill_90566_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：[Arg1]点の一時的な力と[Arg2]点の一時的な警戒を獲得。"
  },
  Skill_90566_Name = {
    Text = "深森の緑"
  },
  Skill_90567_Desc = {
    Text = "「祭霊夜の特性ブレンド」に追加：すべての覚醒体は[Arg1]狂気を獲得。"
  },
  Skill_90567_Name = {
    Text = "蜂蜜の金"
  },
  Skill_90568_Desc = {
    Text = "すべての覚醒体のクリティカル率とクリティカルダメージが一時的に[Arg1]%増加する、"
  },
  Skill_90568_Name = {
    Text = "祭霊夜の特性ブレンド"
  },
  Skill_90569_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：「啓示」を1枚獲得。"
  },
  Skill_90569_Name = {
    Text = "啓示の青"
  },
  Skill_90570_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：ライフを[Arg1]回復。"
  },
  Skill_90570_Name = {
    Text = "紅血の赤"
  },
  Skill_91158_BattleDesc = {
    Text = "自身の<BleedingIconKeywords:出血>を除去する。失った生命の30%のシールド( [Arg1])を獲得し、カードを2枚引く。"
  },
  Skill_91158_Desc = {
    Text = "自身の<BleedingIconKeywords:出血>を除去する。失ったライフの30%のシールドを獲得し、カードを2枚引く。"
  },
  Skill_91158_Name = {
    Text = "子孫の庇護"
  },
  Skill_91159_BattleDesc = {
    Text = "4点の一時的な<Kuangre:狂熱>を獲得し、2点の行動力を獲得。"
  },
  Skill_91159_Desc = {
    Text = "4点の一時的な「狂熱」を獲得し、2点の行動力を獲得。"
  },
  Skill_91159_Name = {
    Text = "子孫の激励"
  },
  Skill_91218_Desc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_91218_Name_1 = {
    Text = "魂喰らい"
  },
  Skill_91219_Desc_1 = {
    Text = "前列の敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_91219_Name_1 = {
    Text = "生霊の饗宴"
  },
  Skill_91220_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_91220_Name_1 = {Text = "攻撃"},
  Skill_91221_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]>狂気を獲得。"
  },
  Skill_91221_Name_1 = {
    Text = "歓喜の飽食"
  },
  Skill_91222_Desc_1 = {
    Text = "味方1体に[Arg1]点の<PVPProtectiveKeywords:バリア>を与える。"
  },
  Skill_91222_Name_1 = {
    Text = "溟夢の帳"
  },
  Skill_91512_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時およびターン終了時、装備者が後列の敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_91512_Name_1 = {
    Text = "入学の日"
  },
  Skill_91513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：ターン終了時、[Arg1] 枚の<PVPDerivativeCardKeywords_17:「啓示」>を手札に加える。"
  },
  Skill_91513_Name_1 = {
    Text = "パートナーの特訓"
  },
  Skill_91741_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。1点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91741_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与える。1点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91741_Name = {Text = "攻撃"},
  Skill_91742_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg4]点の<Guaiwuheiyu:黒羽>を消費して、[Arg3]点の<BlindingKeywords:盲目>と<WeaknessIconKeywords:虚弱>を付与する。プレイヤーが「キーオーダー」を発動した場合、行動予測は低ダメージの「攻撃」に転換し、1点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91742_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与える。[Arg4]点の<Guaiwuheiyu:黒羽>を消費して、[Arg3]点の<BlindingKeywords:盲目>と<WeaknessIconKeywords:虚弱>を付与する。プレイヤーが「キーオーダー」を発動した場合、行動予測は低ダメージの「攻撃」に転換し、1点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91742_Name = {
    Text = "二枚の黒羽"
  },
  Skill_91743_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg4]点の<Guaiwuheiyu:黒羽>を消費して、[Arg3]点の<BlindingKeywords:盲目>と<WeaknessIconKeywords:虚弱>を付与する。プレイヤーが「キーオーダー」を発動した場合、、行動予測は低ダメージの「攻撃」に転換し、1点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91743_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2] 回与える。[Arg4]点の<Guaiwuheiyu:黒羽>を消費して、[Arg3]点の<BlindingKeywords:盲目>と<WeaknessIconKeywords:虚弱>を付与する。プレイヤーが「キーオーダー」を発動した場合、行動予測は低ダメージの「攻撃」に転換し、1点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91743_Name = {Text = "黒羽"},
  Skill_91744_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。黒羽1点ごとに最終ダメージが[Arg3]%増加し、<Guaiwuheiyu:黒羽>の半分を除去する。"
  },
  Skill_91744_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。黒羽1点ごとに最終ダメージが[Arg3]%増加し、<Guaiwuheiyu:黒羽>の半分を除去する。"
  },
  Skill_91744_Name = {
    Text = "永夜を穿つ"
  },
  Skill_91745_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[Arg2]点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91745_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[Arg2]点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91745_Name = {
    Text = "孤高なる不屈の鳥"
  },
  Skill_91746_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。黒羽[Arg2]点につき、防御力が[Arg3]%増加し、[Arg4]点の<PowerIconKeywords:力>を獲得する。[Arg5]点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91746_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。黒羽[Arg2]点につき、防御力が[Arg3]%増加し、[Arg4]点の<PowerIconKeywords:力>を獲得する。[Arg5]点の<Guaiwuheiyu:黒羽>を獲得。"
  },
  Skill_91746_Name = {
    Text = "日を蔽う羽"
  },
  Skill_91747_BattleDesc = {
    Text = "破壊されなかったシールドの[Arg1]%が次のターンまで保持される。ターン終了時に[Arg2]点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91747_Desc = {
    Text = "破壊されなかったシールドの[Arg1]%が次のターンまで保持される。ターン終了時に[Arg2]点の<Guaiwuheiyu:黒羽>を獲得する。"
  },
  Skill_91747_Name = {
    Text = "飛翔の願い"
  },
  Skill_94508_Desc_1 = {
    Text = "[Arg1]% の確率で味方一体に正面の<PVPWonderfulEffectKeywords:不思議な効果>を付与するか、敵一体に負面の<PVPWonderfulEffectKeywords:不思議な効果>を付与する。付与するたびに確率が半減し、この効果を無限に繰り返し、付与に失敗するまで続ける。<PVPPenetrateKeywords:刺突 1>。"
  },
  Skill_94508_Name_1 = {
    Text = "捕食の決意"
  },
  Skill_94508_UnknownName = {
    Text = "捕食の決意"
  },
  Skill_94560_Desc = {
    Text = "出場した覚醒体の指令カードの中から3枚を<FaxianKeywords:発見>し、1枚を選択して一時的にコピーして手札に追加し、行動力消費を1減少させる。現在の界域が「血肉」の場合、「食べつくせ！」を選択できる。"
  },
  Skill_94560_Name = {
    Text = "狩りの決意"
  },
  Skill_94561_BattleDesc = {
    Text = "すべての敵の<PowerIconKeywords:力>を一時的に[Arg1]点減少させる。敵1人につき[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。ドレセインがチームにいる場合、<CarcassKeywords:残骸>を1つ獲得する。"
  },
  Skill_94561_Desc = {
    Text = "すべての敵から[Arg1]点の<PowerIconKeywords:力>を<TouquKeywords:盗む>。ドレセインがチームにいる場合、<CarcassKeywords:残骸>を1つ獲得する。"
  },
  Skill_94561_Name = {
    Text = "残酷な敬意"
  },
  Skill_94565_Desc = {
    Text = "3枚のカードのコピーをすべて手札に追加できるが、行動力消費は減少しない。"
  },
  Skill_94565_Name = {
    Text = "食べ尽くせ！"
  },
  Skill_94683_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。1点の<WeaknessIconKeywords:虚弱>を付与する。"
  },
  Skill_94683_Name = {Text = "釘刺し"},
  Skill_94684_Desc = {
    Text = "[Arg1]点の<IntoxicationIconKeywords:毒>を付与。"
  },
  Skill_94684_Name = {Text = "呪い"},
  Skill_94685_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_94686_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、自身は死亡する。"
  },
  Skill_94703_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。完全にブロックされなかった場合、<DerivativeCardKeywords_80:「窒息」>を1枚山札に追加する。"
  },
  Skill_94703_Name = {
    Text = "海の儀式"
  },
  Skill_94704_Desc = {
    Text = "1点の<WeaknessIconKeywords:虚弱>と<FragileIconKeywords:脆弱>を付与する。"
  },
  Skill_94704_Name = {Text = "汚濁"},
  Skill_94709_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_94709_Name = {Text = "屍染"},
  Skill_94711_Desc = {
    Text = "すべての味方は、ライフをグールが失ったライフの10%回復し、[Arg2]点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_94711_Name = {Text = "宴席"},
  Skill_94722_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]点の<IntoxicationIconKeywords:毒>を付与する。「グールの増殖体」を1体前列に召喚する。"
  },
  Skill_94722_Name = {
    Text = "墓の召喚"
  },
  Skill_94723_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]点の<IntoxicationIconKeywords:毒>を付与する。「グールの増殖体」を2体召喚する。"
  },
  Skill_94723_Name = {
    Text = "満月の呼び声"
  },
  Skill_94725_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_94725_Name = {
    Text = "墓荒らし"
  },
  Skill_94726_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]点の<HeavyInjuryKeywords:重傷>を付与する。"
  },
  Skill_94726_Name = {
    Text = "墓荒らし"
  },
  Skill_94731_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_94731_Name = {Text = "屍染"},
  Skill_94732_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]点の<HeavyInjuryKeywords:重傷>を与える。"
  },
  Skill_94732_Name = {
    Text = "墓碑の叫び"
  },
  Skill_94952_Desc = {
    Text = "[Arg1]点の<Guaiwusiwangdikang:死亡抵抗>を獲得。「深海の増殖体」を2体召喚する。"
  },
  Skill_94952_Name = {
    Text = "海の召喚"
  },
  Skill_94953_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、2点の<VulnerabilityIconKeywords:脆弱>を付与する。"
  },
  Skill_94953_Name = {
    Text = "引き裂く爪"
  },
  Skill_94954_Desc = {
    Text = "[Arg1]点の<Guaiwusiwangdikang:死亡抵抗>を獲得し、 [Arg2]点の<PowerIconKeywords:力>を獲得。 [Arg3]点の<Kuangbao: 狂暴>を獲得。"
  },
  Skill_94954_Name = {
    Text = "不死の魂"
  },
  Skill_94955_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_94955_Name = {
    Text = "飢えた意思"
  },
  Skill_94956_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。 [Arg2] 点の<Kuangbao: 狂暴>を獲得。"
  },
  Skill_94956_Name = {
    Text = "飢えた意思"
  },
  Skill_94957_Desc = {
    Text = "自身は死亡し、ライフが最も多い味方が[Arg1]点の<PowerIconKeywords:力>を獲得する。その味方の最大ライフは自身の現在のライフの2倍（[Arg2]）増加する。"
  },
  Skill_94957_Name = {Text = "被喰"},
  Skill_94958_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、ダメージの[Arg2]%の<IntoxicationIconKeywords:毒>を付与する。対象から[Arg3]%の <PowerIconKeywords:力>を減少させる。"
  },
  Skill_94958_Name = {
    Text = "魂喰らい"
  },
  Skill_94959_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。クリティカルダメージを受けるたび、攻撃回数が1減少する。最低3回。"
  },
  Skill_94959_Name = {
    Text = "天を喰らう大波"
  },
  Skill_94960_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。[Arg2]点の<RetaliateIconKeywords:一時的な反撃>を獲得。"
  },
  Skill_94961_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、ダメージの[Arg2]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_94961_Name = {
    Text = "魂喰らい"
  },
  Skill_94962_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。クリティカルダメージを受けるたび、攻撃回数が1減少する。最低3回。"
  },
  Skill_94962_Name = {
    Text = "荒れ狂う海"
  },
  Skill_94963_Desc = {
    Text = "[Arg1]点の<Guaiwusiwangdikang:死亡抵抗>を獲得。[Arg2]ターンの間、デバフを無効化する。「深海の増殖体」を2体召喚する。"
  },
  Skill_94963_Name = {
    Text = "深海の呼び声"
  },
  Skill_94964_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、1点の<VulnerabilityIconKeywords:脆弱>を付与する。"
  },
  Skill_94964_Name = {
    Text = "引き裂く爪"
  },
  Skill_94965_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_94965_Name = {
    Text = "魂を蝕む"
  },
  Skill_94966_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。"
  },
  Skill_94966_Name = {Text = "貪欲"},
  Skill_94967_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、ダメージの[Arg2]%の<IntoxicationIconKeywords:毒>を付与する。対象から[Arg3]%の <PowerIconKeywords:力>を減少させる。"
  },
  Skill_94967_Name = {
    Text = "魂喰らい"
  },
  Skill_94968_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。[Arg2]点の<RetaliateIconKeywords:一時的な反撃>を獲得。[Arg3]%の<Baojidikang:一時的なクリティカル耐性>を獲得。"
  },
  Skill_95807_Desc = {
    Text = "[Arg1]ダメージを与え、[Arg2]倍の<PowerIconKeywords:力>ボーナスを獲得。"
  },
  Skill_95807_Name = {
    Text = "死者の儀式"
  },
  Skill_95808_Desc = {
    Text = "すべての敵が[Arg1]点の一時的な<PowerIconKeywords:力>を獲得する。「葬骸の主」は<Guaiwucanhai:残骸>を半分失う。"
  },
  Skill_95808_Name = {Text = "奇襲"},
  Skill_95809_AwakerSkillBackgroundStory = {
    Text = "しーっ……グールの王は、無礼な客を歓迎しません。"
  },
  Skill_95809_BattleDesc = {
    Text = "<Block:[Block:Arg3]>点のシールドを獲得。<Energy:[Energy:Arg4]>狂気を獲得。"
  },
  Skill_95809_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ドゥルセインは <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_95809_EffectNameList = {
    Text = "シールド、狂気"
  },
  Skill_95809_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_95810_Desc_1 = {
    Text = "味方1体を選択し、自身の [Arg1] 種類の異なる<PVPVoidKeywords:虚無>が付加された「スキル」を獲得させる。"
  },
  Skill_95810_Name_1 = {
    Text = "残忍なる敬意"
  },
  Skill_95810_UnknownName = {
    Text = "残忍なる敬意"
  },
  Skill_95811_AwakerSkillBackgroundStory = {
    Text = "招待状の紙は、柔らかな皮膚から。招待状の装飾は、滑らかな頭蓋から。招待状の文字は、新鮮な血から。招待状の署名は、王邸に住まう、あの情熱的な主から。\nドゥルセインより、心からの招待状をお送りします。さあ、あなたたちのための盛大な宴へ。"
  },
  Skill_95811_Desc_0 = {
    Text = "ドレセインは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：[Power:Arg2] 点の<PowerIconKeywords:力>を獲得し、ドレセインが与えるダメージは追加で [Arg3]％ の力ボーナスを受ける。ドレセインが各ターン初めてキルを達成した後、他の敵に溢れたダメージの 50% の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_95811_Desc_15 = {
    Text = "ドレセインは <Energy:[Energy:Arg1]> 点の狂気を獲得する。<ExaltIconKeywords:霊知啓発>：[Power:Arg2] 点の<PowerIconKeywords:力>を獲得し、ドレセインが与えるダメージは追加で [Arg3]％ の力ボーナスを受ける。全ての敵に現在ライフの [Arg4]％ の<FixedDamage:純粋ダメージ>を与える。ドレセインが各ターン初めてキルを達成した後、他の敵に溢れたダメージの 100% の<FixedDamage:純粋ダメージ>を与える。"
  },
  Skill_95811_EffectNameList = {Text = "狂気,力"},
  Skill_95811_Name = {
    Text = "王邸の招待状"
  },
  Skill_95811_PropertyNameList = {
    Text = "$GrowValue1,攻撃力×GrowValue2"
  },
  Skill_95812_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：装備時に[Arg1]点の<StrongEffectKeywords:特効>を獲得。敵を撃破した時の超過ダメージを後方の覚醒体に与える。"
  },
  Skill_95812_Name_1 = {
    Text = "安息の口づけ"
  },
  Skill_95813_AwakerSkillBackgroundStory = {
    Text = "素晴らしい宴に、ダンスは欠かせないでしょう？"
  },
  Skill_95813_BattleDesc = {
    Text = "<Damage:[Damage:Arg3]>ダメージを与える。<Energy:[Energy:Arg4]>狂気を獲得。"
  },
  Skill_95813_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ドゥルセインは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_95813_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_95813_Name = {Text = "攻撃"},
  Skill_95813_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_95814_AwakerSkillBackgroundStory = {
    Text = "暗闇の中、デュルセインは再び目を開けた。\n感傷も、憎しみもない。彼は人間としての肉体を心待ちにして、享受していた。\n彼は最初から、自分の道がどこに向かうのかを知っていた。"
  },
  Skill_95814_BattleDesc = {
    Text = "現在のライフの10%( [Arg2] )を失う。すべての敵に<Damage:[Damage:Arg3]>ダメージを与え、1点の<VulnerabilityIconKeywords:脆弱>を付与。"
  },
  Skill_95814_Desc = {
    Text = "現在のライフの10%を失う。すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、1点の<VulnerabilityIconKeywords:脆弱>を付与。"
  },
  Skill_95814_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_95814_Name = {
    Text = "冥府への道"
  },
  Skill_95814_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_95815_Desc = {
    Text = "[Arg1]点の<Guaiwusiwangdikang:死亡抵抗>と [Arg2]点の<Guaiwucanhai:残骸>を獲得。「グールの増殖体」と「グールの従者」を召喚する。"
  },
  Skill_95815_Name = {
    Text = "王邸の招待状"
  },
  Skill_95816_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札にある指令カード[Arg3]枚をランダムに「<Dongjie:凍結>」する。"
  },
  Skill_95816_Name = {
    Text = "冥府への道"
  },
  Skill_95817_AwakerSkillBackgroundStory = {
    Text = "料理そのものだけでなく、食事の作法もまた、美食という芸術の重要な一部だ。\n敵の亡骸で作られたフォークを、その魂へと深く突き立てる。\nすべての料理は、丹念に用意された再会の場なのだ。"
  },
  Skill_95817_BattleDesc = {
    Text = "ライフが最も低い敵に<Damage:[Damage:Arg4]>ダメージを与え、[Arg2]％の力ボーナス獲得する。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_95817_Desc = {
    Text = "ライフが最も低い敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]％の力ボーナスを獲得する。[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_95817_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_95817_Name = {
    Text = "死者の儀式"
  },
  Skill_95817_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_95818_Desc = {
    Text = "<Damage:[Damage:Arg1]>ポイントのダメージを造成し、敵の生命が低いほどダメージが高く、最大で<Damage:[Damage:Arg2]>ポイントのダメージ。全ての他の食屍鬼を吸収し、吸収するごとに[Arg3]具の<Guaiwucanhai:残骸>と[Arg4]層の<Guaiwusiwangdikang:死亡抵抗>を得る。"
  },
  Skill_95818_Name = {
    Text = "万霊の厭饗"
  },
  Skill_95819_BattleDesc = {
    Text = "すべての「満腹」を解除する。すべての手札を捨て、<DerivativeCardKeywords_111:「魂の捕食」>で除去したカードを手札に追加し、それらの行動力消費を0にする。ターン終了時にこのカードがまだ手札にある場合：ランダムな除去されたカードのコピーを1枚手札に追加し、その行動力消費を0にし、「除外」と「虚無」を付与する。"
  },
  Skill_95819_Desc = {
    Text = "すべての「満腹」を解除する。すべての手札を捨て、<DerivativeCardKeywords_111:「魂の捕食」>で除去したカードを手札に追加し、それらの行動力消費を0にする。ターン終了時にこのカードがまだ手札にある場合：ランダムな除去されたカードのコピーを1枚手札に追加し、その行動力消費を0にし、「除外」と「虚無」を付与する。"
  },
  Skill_95819_Name = {
    Text = "記憶の共鳴"
  },
  Skill_95820_AwakerSkillBackgroundStory = {
    Text = "仮面を剥ぎ取れ。偏見を捨てよ。ダンスフロアへ足を踏み入れ、長き眠りにあるパートナーを抱きしめよ。\n最後に美しき月の光を目にしたのは、いつのことだろう。最後に優しい愛の言葉を聞いたのは、いつのことだろう。\n聞け——それはあなたを欲している。あなたがそれを欲しているのと、同じように。\n噛みつけ。貪り尽くせ。この比類なき饗宴の中で、生者と死者は共に昇華を遂げるのだ。"
  },
  Skill_95820_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：<DerivativeCardKeywords_110:>今回の狂気解放のクリティカル率+[Arg2]％、[Power:Arg1] 点の<PowerIconKeywords:力>を獲得する。】ライフが最も低い敵に <Damage:[Damage:Arg3]> 点のダメージを与え、[Arg4]％ の力ボーナスを享受し、対象がライフを 1％ 失うごとに今回の狂気解放の最終ダメージが 3％ アップする。現在 3 体の<CarcassKeywords:残骸>を所持している場合、それを食べて <Heal:[Heal:Arg5]> 点のライフを回復し、今回の狂気解放が享受するクリティカルダメージボーナスを 2 倍にする（現在 [Arg6]/3 体の<CarcassKeywords:残骸>を所持）。"
  },
  Skill_95820_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：<DerivativeCardKeywords_114:>今回の狂気解放のクリティカル率+[Arg2]％、[Power:Arg1] 点の<PowerIconKeywords:力>を獲得する。】ライフが最も低い敵に <Damage:[Damage:Arg3]> 点のダメージを与え、[Arg4]％の力ボーナスを享受し、対象がライフを 1％ 失うごとに今回の狂気解放の最終ダメージが 3％ アップする。現在 3 体の<CarcassKeywords:残骸>を所持している場合、それを食べてライフを <Heal:[Heal:Arg5]> 点回復し、今回の狂気解放が享受するクリティカルダメージボーナスを 2 倍にする（現在 [Arg6]/3 体の<CarcassKeywords:残骸>を所持）。"
  },
  Skill_95820_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：<DerivativeCardKeywords_110:>今回の狂気解放のクリティカル率+[Arg2]％、[Power:Arg1] 点の<PowerIconKeywords:力>を獲得する。】ライフが最も低い敵に <Damage:[Damage:Arg3]> 点のダメージを与え、[Arg4]％の力ボーナスを享受し、対象のライフが 1％ 失われるごとに今回の狂気解放の最終ダメージが 3％ アップする。現在 3 体の<CarcassKeywords:残骸>を所持している場合、それを食べて <Heal:[Heal:Arg5]> 点のライフを回復し、今回の狂気解放が享受するクリティカルダメージボーナスを 2 倍にする。"
  },
  Skill_95820_Desc_3 = {
    Text = "【<DevouredIconKeywords:捕食> ：<DerivativeCardKeywords_114:>今回の狂気解放のクリティカル率+[Arg2]％、[Power:Arg1] 点の<PowerIconKeywords:力>を獲得する。】ライフが最も低い敵に <Damage:[Damage:Arg3]> 点のダメージを与え、[Arg4]％の力ボーナスを享受する。対象がライフを 1％ 失うごとに今回の狂気解放の最終ダメージが 3％ アップする。現在 3 体の<CarcassKeywords:残骸>を所持している場合、それを食らい、<Heal:[Heal:Arg5]> 点のライフを回復し、今回の狂気解放が享受するクリティカルダメージボーナスを 2 倍にする。"
  },
  Skill_95820_EffectNameList = {
    Text = "力,ダメージ,回復"
  },
  Skill_95820_Name = {
    Text = "生霊の饗宴"
  },
  Skill_95820_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食> ：<DerivativeCardKeywords_114:>この狂気解放のクリティカル率+[Arg2]％。[Power:Arg1]点の<PowerIconKeywords:力>を獲得。】この狂気解放のクリティカル率+25%、基礎ダメージが50%増加。ライフが最も低い敵に<Damage:[Damage:Arg7]>ダメージを与え、[Arg4]％の力ボーナスを獲得する。この狂気解放が与える最終ダメージが100％増加し、対象の失ったライフ1％ごとに追加で3％増加する。「残骸」が3個ある場合、それを食べてライフを<Heal:[Heal:Arg5]>回復し、この狂気解放のクリティカルダメージボーナスが2倍になる（現在[Arg6]/3個の残骸を所持）。"
  },
  Skill_95820_PropertyNameList = {
    Text = "攻撃力×GrowValue1、攻撃力×GrowValue2、体力×GrowValue3"
  },
  Skill_95821_Desc = {
    Text = "<Guaiwucanhai:残骸>を半分([Arg3])消費し、1点消費するごとに[Arg1]点の<PowerIconKeywords:力>を獲得し、ライフの上限が[Arg2]%増加する。「グールの増殖体」と「グールの従者」を召喚する。"
  },
  Skill_95821_Name = {
    Text = "残骸収集"
  },
  Skill_95822_Desc = {
    Text = "戦略を1つ選択する。「葬骸の主」が「残骸収集」を発動するたび、手札に追加する。"
  },
  Skill_95822_Name = {
    Text = "戦略を立てる"
  },
  Skill_95823_Desc = {
    Text = "<Guaiwucanhai:残骸>を半分([Arg3])を消費し、[Arg1]点の<PowerIconKeywords:力>を獲得。1点消費するごとに、[Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_95823_Name = {
    Text = "残骸収集"
  },
  Skill_95824_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気爆発」後、カードを[Arg1]枚引く。自身の「スキル」を優先的に引き、その演算力消費を–[Arg2]する。"
  },
  Skill_95824_Name_1 = {Text = "珍味"},
  Skill_95825_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。敵のライフが低いほどダメージが高くなり、最大<Damage:[Damage:Arg2]>ダメージ。ターン終了時にすべてのグールを吸収し、1体吸収するごとに[Arg3]点の「<Guaiwucanhai:残骸>」を獲得する。"
  },
  Skill_95825_Name = {
    Text = "生霊の饗宴"
  },
  Skill_95826_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]倍の「<PowerIconKeywords:力>」ボーナスを獲得。"
  },
  Skill_95826_Name = {
    Text = "死者の儀式"
  },
  Skill_95827_Desc = {
    Text = "<Damage:[Damage:Arg1]>ポイントの傷害を造成し、[AttackTimes:Arg2]回、ランダムに「<Dongjie:凍結>」[Arg3]枚の抽牌堆からカードを選択する。"
  },
  Skill_95827_Name = {
    Text = "冥府への道"
  },
  Skill_95828_BattleDesc = {
    Text = "味方の覚醒体を1体選択し、その手札からすべてのカードを除去し、各カードに「満足」1層を与え、他の覚醒体には <Energy:5> ポイントの狂気を与えます。"
  },
  Skill_95828_Desc = {
    Text = "味方の覚醒体を1体選択し、その手札からすべてのカードを除去し、各カードに「満足」1層を与え、他の覚醒体には <Energy:5> ポイントの狂気を与えます。"
  },
  Skill_95828_Name = {
    Text = "ソウルデボア"
  },
  Skill_95829_Desc = {
    Text = "すべての敵が与えるダメージを一時的に30%減少させる。"
  },
  Skill_95829_Name = {Text = "干渉"},
  Skill_95986_Desc = {
    Text = "100ダブルクリティカル"
  },
  Skill_95986_Name = {
    Text = "100ダブルクリティカル"
  },
  Skill_95988_Desc = {Text = "1000力"},
  Skill_95988_Name = {Text = "1000力"},
  Skill_95989_Desc = {Text = "100強度"},
  Skill_95989_Name = {Text = "100強度"},
  Skill_95990_Desc = {Text = "500力"},
  Skill_95990_Name = {Text = "500力"},
  Skill_96018_Desc = {
    Text = "この戦闘で与える最終ダメージが25%増加し、すべての覚醒体は30狂気を獲得する。すべての指令カードの「<Kuangluan:海踊人の狂乱>」を除去し、手札にある「症状」を最大2枚消費して同数のカードを引く。"
  },
  Skill_96018_Name = {
    Text = "砕けた印章"
  },
  Skill_96019_Desc = {
    Text = "この戦闘で与える最終ダメージが50%増加し、すべての覚醒体は50狂気を獲得する。すべての指令カードの「<Kuangluan:海踊人の狂乱>」を除去し、手札にある「症状」を最大3枚消費して同数のカードを引く。"
  },
  Skill_96019_Name = {
    Text = "壊れた印章"
  },
  Skill_96022_Desc = {
    Text = "この戦闘で与える最終ダメージが100%増加し、すべての覚醒体は100狂気を獲得する。すべての指令カードの「<Kuangluan:海踊人の狂乱>」を除去し、手札にある「症状」をすべて消費して同数のカードを引く。"
  },
  Skill_96022_Name = {
    Text = "完璧な印章"
  },
  Skill_96188_BattleDesc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg2]><PunctureDamagewords:刺突ダメージ>を与える。"
  },
  Skill_96188_BattleDesc_3 = {
    Text = "すべての敵に<Damage:[Damage:Arg2]><PunctureDamagewords:刺突ダメージ>を与える。このターン中に使用する「永遠の夜の宴」は、追加で100%の力ボーナスを獲得する。"
  },
  Skill_96188_Desc_0 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。"
  },
  Skill_96188_Desc_3 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。このターン中に使用する「永遠の夜の宴」は、追加で100%の力ボーナスを獲得する。"
  },
  Skill_96188_Name = {
    Text = "永遠の夜の宴"
  },
  Skill_96325_Desc = {
    Text = "<Damage:[Damage:Arg1]> ポイントのダメージを [AttackTimes:Arg2] 回与える。[Arg3]ターンの<FragileIconKeywords:脆弱>を付与し、ドローパイルのランダムな4枚のカードに<ColorInkKeywords:認知失調>を付加する。"
  },
  Skill_96326_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。[Arg3] 点の<PowerIconKeywords:力>を獲得し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_96327_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。山札のランダムな 3 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_96328_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを [AttackTimes:Arg2] 回与える。[Arg3] ターンの<BlindingKeywords:盲目>を付与し、山札のランダムな 1 枚に<ColorInkKeywords:認知失調>を付与する。"
  },
  Skill_96342_Desc = {
    Text = "[Arg1]%の<Baojidikang:クリティカル耐性>と[Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_96342_Name = {Text = "誓い"},
  Skill_96343_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、[Arg3]点の<HeavyInjuryKeywords:重傷>を与える。敵のライフが低いほどダメージが高くなり、最大<Damage:[Damage:Arg4]>ダメージ。"
  },
  Skill_96343_Name = {
    Text = "骨を喰らう刃"
  },
  Skill_96344_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札にある指令カードを上から[Arg3]枚「<Dongjie:凍結>」する。"
  },
  Skill_96344_Name = {
    Text = "魂の封印"
  },
  Skill_96345_Desc = {
    Text = "[Arg1]点の<PowerIconKeywords:力>を獲得。[Arg2]%の<Baojidikang:クリティカル耐性>と[Arg3]点の<Fennu:「怒り」>を獲得。"
  },
  Skill_96345_Name = {Text = "執念"},
  Skill_96590_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：すべての覚醒体が[Arg1]狂気を取得。"
  },
  Skill_96590_Name = {
    Text = "蜂蜜の金"
  },
  Skill_96591_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：[Arg1]キーエネルギーを獲得。"
  },
  Skill_96591_Name = {
    Text = "無垢の銀"
  },
  Skill_96592_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：ライフを[Arg1]回復。"
  },
  Skill_96592_Name = {
    Text = "紅血の赤"
  },
  Skill_96593_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：「啓示」を1枚獲得。"
  },
  Skill_96593_Name = {
    Text = "啓示の青"
  },
  Skill_96594_Desc = {
    Text = "「祭霊夜の特製ブレンド」に追加：[Arg1]点の一時的な力と[Arg2]点の一時的な警戒を獲得。"
  },
  Skill_96594_Name = {
    Text = "深森の緑"
  },
  Skill_96734_BattleDesc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg2]> ダメージを与え、行動力を1点消費するごとにダメージが [Arg3] アップする。"
  },
  Skill_96734_Desc_1 = {
    Text = "<HPAndShieldMax:ライフとシールドが最も高い>敵に <Damage:[Damage:Arg1]> ダメージを与え、行動力を1点消費するごとにダメージが [Arg3] アップする。"
  },
  Skill_96734_Name_1 = {
    Text = "死を告げる魔弾"
  },
  Skill_96735_BattleDesc_1 = {
    Text = "合計 <Damage:[Damage:Arg1]> ダメージを与え、全ての敵に均等に分配する。各敵は <Damage:[Damage:Arg2]> ダメージを受ける。"
  },
  Skill_96735_Desc_1 = {
    Text = "合計<Damage:[Damage:Arg1]>ダメージを、すべての敵に均等に分配して与える。"
  },
  Skill_96735_Name_1 = {
    Text = "世界を焼却する爆炎"
  },
  Skill_96736_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂気を獲得、<StrongEffectKeywords:強効>+[Arg2]。"
  },
  Skill_96736_Name_1 = {
    Text = "爆燃の火"
  },
  Skill_96737_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_96737_Name_1 = {Text = "攻撃"},
  Skill_96738_Desc_1 = {
    Text = "すべての敵に<DelayKeywords:遅延>：<PVPWeaknessesKeywords:弱点>を付与する。"
  },
  Skill_96738_Name_1 = {
    Text = "万物の終焉"
  },
  Skill_96755_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージの50%に等しい<BleedingIconKeywords:出血>を付与する。「<Chaos:混乱>」1点につき、攻撃回数が1減少する。"
  },
  Skill_96755_Name = {
    Text = "激流の刃"
  },
  Skill_96756_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。敵のライフが低いほどダメージが増加する。1点の「<Daohaizheyishi: 海踊人の祭儀>」を付与。"
  },
  Skill_96756_Name = {
    Text = "海踊人の審判"
  },
  Skill_96757_Desc = {
    Text = "<Damage:[Damage:Arg1]> 点のダメージ [AttackTimes:Arg2] 回与える。敵の生命が低いほどダメージが増加する。3枚のカードに「<Kuangluan:蹈海者狂乱>」を付与。"
  },
  Skill_96757_Name = {
    Text = "海踊人の呪い"
  },
  Skill_96758_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ランダムな「変異」を[Arg3] 枚山札に追加する。「<Chaos:混乱>」1点につき、枚数が1減少する。"
  },
  Skill_96758_Name = {
    Text = "深淵集爆"
  },
  Skill_96759_Desc = {
    Text = "最大ライフが[Arg1]%増加し、追加でライフを[Arg2]回獲得する。[Arg3]点の<RetaliateIconKeywords:反撃>、[Arg4]点の<Duren: 毒刃>、[Arg5]%の<Baojidikang:クリティカル耐性>を獲得。"
  },
  Skill_96759_Name = {
    Text = "骨肉の再構成"
  },
  Skill_96760_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。「<Chaos:混乱>」1点につき、獲得する力が[Arg4]点減少する。"
  },
  Skill_96760_Name = {Text = "奔流"},
  Skill_96761_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ランダムな「症状」を[Arg3]枚山札に追加する。「<Chaos:混乱>」1点につき、枚数が1減少する。"
  },
  Skill_96761_Name = {
    Text = "屍骸爆発"
  },
  Skill_96762_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。ブロックされなかったダメージの50%に等しい<BleedingIconKeywords:出血>を付与する。「<Chaos:混乱>」1点につき、攻撃回数が1減少する。"
  },
  Skill_96762_Name = {
    Text = "骸骨の刃"
  },
  Skill_96787_Desc = {
    Text = "ドゥルセインによる未完成の魔法陣。不完全ながらも、一定の防護効果を持つ。ブロックされなかったダメージは、魔法陣が肩代わりする。ライフを回復すると、安定度が33%回復する。永続保持。現在の安定度：[Arg2]/[Arg3]([Arg1]%)。「冥夢の帳」進行度：[Arg4]/3。"
  },
  Skill_96787_Name = {
    Text = "冥夢の帷"
  },
  Skill_97107_Desc_1 = {
    Text = "このターンの行動力は次のターンに持ち越す。<DelayKeywords:遅延>：[Arg1]点の上限を無視して行動力を獲得。"
  },
  Skill_97107_Name_1 = {
    Text = "沈まぬ太陽"
  },
  Skill_97107_UnknownName = {
    Text = "沈まぬ太陽"
  },
  Skill_97108_Desc_1 = {
    Text = "<PVPWeaponKeywords:運命の札>：「攻撃」は[Arg1]点の行動力を獲得し、「スキル」のダメージが[Arg2]%増加する。"
  },
  Skill_97108_Name_1 = {
    Text = "迫り来る太陽"
  },
  Skill_97109_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「スキル」は消費する行動力1につきダメージアップ [Arg1]%。キルを達成した後、「狂気解放」のダメージアップ [Arg2]%。"
  },
  Skill_97109_Name_1 = {
    Text = "琥珀色の死"
  },
  Skill_97159_Desc = {
    Text = "自身は死亡し、ライフが最も多い味方が[Arg1]点の<PowerIconKeywords:力>を獲得する。その味方の最大ライフは自身の現在のライフの2倍（[Arg2]）増加する。"
  },
  Skill_97159_Name = {Text = "被喰"},
  Skill_97318_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。"
  },
  Skill_97318_Name = {
    Text = "永遠の夜の宴"
  },
  Skill_97319_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を与える。このターン中に使用する「永遠の夜の宴」は、追加で100%の力ボーナスを獲得する。"
  },
  Skill_97319_Name = {
    Text = "永遠の夜の宴"
  },
  Skill_97911_AwakerSkillBackgroundStory = {
    Text = "彼女は無造作に引き金を引き、弾丸が命中するかどうかなど気にも留めなかった。\n「狩りの始まりだ。まずはウォーミングアップと行こうか」"
  },
  Skill_97911_BattleDesc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]> 狂気を獲得。"
  },
  Skill_97911_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。キャティグラは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_97911_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_97911_Name = {Text = "攻撃"},
  Skill_97911_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_97912_AwakerSkillBackgroundStory = {
    Text = "火と光が世界を塗り替え、あなたの瞳には果てのない輝きだけが残った。思考は停止し、理解も及ばず、なぜ世界が消え去ったのかもわからない。すべてが蒸発し、虚無へと帰すその最後の瞬間、あなたはようやく気づく——それは、太陽が爆発する際に放たれた、最も眩い色彩だったのだと。"
  },
  Skill_97912_BattleDesc_0 = {
    Text = "<DerivativeCardKeywords_117:>すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]％の力ボーナスを獲得する。"
  },
  Skill_97912_BattleDesc_2 = {
    Text = "<DerivativeCardKeywords_117:>すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]％の力ボーナスを獲得する。「<HuoyanKeywords4:火焔>」が3点ある場合、基礎ダメージが50％増加する。"
  },
  Skill_97912_Desc_0 = {
    Text = "<DerivativeCardKeywords_117:>すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]％の力ボーナスを獲得する。"
  },
  Skill_97912_Desc_2 = {
    Text = "<DerivativeCardKeywords_117:>すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、[Arg2]％の力ボーナスを獲得する。「<HuoyanKeywords:火焔>」が3点ある場合、基礎ダメージが50％増加する。"
  },
  Skill_97912_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_97912_Name = {
    Text = "ギガフレア"
  },
  Skill_97912_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_97913_AwakerSkillBackgroundStory = {
    Text = "これは、終末からの予告であり、あなたを死という結末へと導くものだ。死神の誘いを拒むのは自由だ。だがその時、あなたはこの世で最も燦然たる光を目にすることになるだろう。"
  },
  Skill_97913_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを2回与える。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_97913_BattleDesc_2 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを2回与える。[Power:Arg4]点の<PowerIconKeywords:力>を獲得。<HuoyanKeywords4:火焔>が3点ある場合、追加で[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_97913_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを2回与える。[Power:Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_97913_Desc_2 = {
    Text = "<Damage:[Damage:Arg1]>点のダメージを2回与える。[Power:Arg4]点の<PowerIconKeywords:力>を獲得。<HuoyanKeywords:火焔>が3点ある場合、追加で[Power:Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_97913_EffectNameList = {
    Text = "ダメージ,力"
  },
  Skill_97913_Name = {
    Text = "終末の銃声"
  },
  Skill_97913_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_97914_AwakerSkillBackgroundStory = {
    Text = "弾薬、刃、魔術……どこから攻撃が来ようと、届く前にその媒体ごと焼き尽くしてしまえばいい。それこそが、最善の防御だ。"
  },
  Skill_97914_BattleDesc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。 <Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_97914_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。キャティグラは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_97914_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_97914_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_97915_AwakerSkillBackgroundStory = {
    Text = "灼熱の炎が再び燃え上がり、全身を覆う瘢痕が目も眩むような白光を放ち始めた。\n「さあ、来い。お遊びはここまでだ。第二ラウンドといこうか」"
  },
  Skill_97915_BattleDesc_0 = {
    Text = "キャティグラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン開始時、手札にあるキャティグラの「指令カード」1枚に1点の<HuoyanKeywords4:火焔>を付与する。3点の<HuoyanKeywords4:火焔>が付与された指令カードを使用した後、それを手札に戻す。"
  },
  Skill_97915_BattleDesc_15 = {
    Text = "キャティグラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン開始時、手札にあるキャティグラの「指令カード」1枚に1点の<HuoyanKeywords:火焔>を付与する。3点の<HuoyanKeywords:火焔>が付与された指令カードを使用した後、それを手札に戻す。「火焔」1点につき、最終ダメージと力効果+30%。"
  },
  Skill_97915_Desc_0 = {
    Text = "キャティグラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知啓発>：ターン開始時、手札にあるキャティグラの「指令カード」1枚に1点の<HuoyanKeywords:火焔>を付与する。3点の<HuoyanKeywords:火焔>が付与された指令カードを使用した後、それを手札に戻す。"
  },
  Skill_97915_Desc_15 = {
    Text = "キャティグラは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：ターン開始時、手札にあるキャティグラの「指令カード」1枚に1点の<HuoyanKeywords:火焔>を付与する。3点の<HuoyanKeywords:火焔>が付与された指令カードを使用した後、それを手札に戻す。「火焔」1点につき最終ダメージと力効果+30%。"
  },
  Skill_97915_EffectNameList = {Text = "狂気"},
  Skill_97915_Name = {
    Text = "業火再燃"
  },
  Skill_97916_BattleDesc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、行動力を1点消費するごとに150%の力ボーナスを追加で獲得する。すべての「爆炎」を消費し、1点にごとに追加で50%の力ボーナスを獲得する（力ボーナス：[Arg2]%）。使用後、「ギガフレア」に戻る。"
  },
  Skill_97916_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与え、行動力を1点消費するごとに、150%の力ボーナスを追加で獲得する。すべての「爆炎」を消費し、1点ごとに追加で50%の力ボーナスを獲得する。使用後、「ギガフレア」に戻る。"
  },
  Skill_97916_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_97916_Name = {
    Text = "テラフレア"
  },
  Skill_97916_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_97917_Desc = {
    Text = "1点の行動力と[Arg1]%の一時的な強化を獲得する。キャティグラがチームにいる場合、その指令カードを1枚引き、1点の「<HuoyanKeywords:火焔>」を付与する。"
  },
  Skill_97917_Name = {
    Text = "沈まぬ太陽"
  },
  Skill_97918_AwakerSkillBackgroundStory = {
    Text = "彼の使者が次々と現れ、琥珀色の炎を舞わせる。これは彼の力、彼の意志、彼の権責、彼の炎が天地を覆い、世界を焼き尽くすのだ。"
  },
  Skill_97918_BattleDesc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>与え、[Arg2]％の力ボーナスを獲得する。キャティグラの「指令カード」を2枚引く。手札にあるキャティグラの「指令カード」に3枚に、1点の<HuoyanKeywords4:火焔>を付与。"
  },
  Skill_97918_Desc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>与え、[Arg2]％の力ボーナスを獲得する。キャティグラの「指令カード」を2枚引く。手札にあるキャティグラの「指令カード」に3枚に、1点の<HuoyanKeywords:火焔>を付与。"
  },
  Skill_97918_EffectNameList = {
    Text = "ダメージ"
  },
  Skill_97918_Name = {
    Text = "世界を焼却する爆炎"
  },
  Skill_97918_OverLimitUtlSkillDesc = {
    Text = "すべての敵に<Damage:[Damage:Arg1]><PunctureDamagewords:刺突ダメージ>を3回与え、[Arg2]％の力ボーナスを獲得する。キャティグラの「指令カード」を2枚引く。手札にあるキャティグラのランダムな指令カードに、5点の<HuoyanKeywords4:火焔を付与。"
  },
  Skill_97918_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_97919_BattleDesc = {
    Text = "覚醒体1体を選択し、行動力消費が0の一時的な「攻撃」を1枚手札に追加する。これが3回目の発動である場合、代わりに「美しき瞬間」を1枚を手札に追加し、すべての覚醒体のクリティカル率を一時的に[Arg1]%増加させる。(現在[Arg2]回発動済み)"
  },
  Skill_97919_Desc = {
    Text = "覚醒体1体を選択し、行動力消費が0の一時的な「攻撃」を1枚手札に追加する。これが3回目の発動である場合、代わりに「美しき瞬間」を1枚を手札に追加し、すべての覚醒体のクリティカル率を一時的に[Arg1]%増加させる。"
  },
  Skill_97919_Name = {
    Text = "浜辺の思い出"
  },
  Skill_98057_Desc = {
    Text = "「激怒」、12点の「眠気」、[Arg1]点の触腕ダメージを獲得する。"
  },
  Skill_98057_Name = {
    Text = "不朽の威厳"
  },
  Skill_98119_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[Arg2]回与える。[Arg3]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_98119_Name = {
    Text = "終末の銃声"
  },
  Skill_98120_Desc = {
    Text = "この行動予測に転換すると、残りの手札をすべて捨てさせ、<BurningKeywords:燃焼>を付与する。相手のターン開始後、手札にあるランダムなカード[Arg1]枚に<BurningKeywords:燃焼>を付与する。"
  },
  Skill_98120_Name = {
    Text = "業火再燃"
  },
  Skill_98121_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。山札または捨て札にあるランダムな指令カード[Arg3]枚に<BurningKeywords:燃焼>を付与する。[Arg4]点の<VulnerabilityIconKeywords:易傷>を付与する。"
  },
  Skill_98121_Name = {
    Text = "ギガフレア"
  },
  Skill_98126_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、追加で[Arg3]倍の<PowerIconKeywords:力>ボーナスと<ExhaustionIconKeywords:力減少>ボーナスを獲得する。すべての<MonsterExFlameKeywords:爆炎>を解除し、1点につき[Arg4] 点の<PowerIconKeywords:力>を獲得する。"
  },
  Skill_98126_Name = {
    Text = "テラフレア"
  },
  Skill_98127_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与える。プレイヤーが持つ残りの手札すべてに<BurningKeywords:燃焼>を付与し、1枚につき1点の<MonsterExFlameKeywords:爆炎>を獲得する。"
  },
  Skill_98127_Name = {
    Text = "世界を焼き尽くす爆炎"
  },
  Skill_98195_Desc_1 = {
    Text = "行動力消費が最も少ない「スキル」を2枚引く。"
  },
  Skill_98195_Name_1 = {
    Text = "コマ送りの真夏の記念"
  },
  Skill_98195_UnknownName = {
    Text = "コマ送りの真夏の記念"
  },
  Skill_98313_Desc = {
    Text = "80レイヤー減少"
  },
  Skill_98313_Name = {
    Text = "80レイヤー減少"
  },
  Skill_98315_Desc = {Text = "100死守"},
  Skill_98315_Name = {Text = "100死守"},
  Skill_98317_Desc = {
    Text = "2種類の異なる「<PrimaryColor:原色>」を記録すると、持続的なバフを獲得する。"
  },
  Skill_98317_Name = {
    Text = "異象のパレット"
  },
  Skill_98332_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。"
  },
  Skill_98332_Name = {
    Text = "<Blue:原色・青>"
  },
  Skill_98333_Desc = {
    Text = "すべての覚醒体は<Energy:8>狂気を獲得。"
  },
  Skill_98333_Name = {
    Text = "<Yellow:原色・黄>"
  },
  Skill_98334_Desc = {
    Text = "[Power:Arg1]点の<PowerIconKeywords:一時的な力>を獲得。このターンに与えるダメージが10%増加する。"
  },
  Skill_98334_Name = {
    Text = "<Red:原色・赤>"
  },
  Skill_98508_Desc = {
    Text = "3点の行動力を獲得し、手札のすべての指令カードに<BurningKeywords:燃焼>を付与する。このターンに<BurningKeywords:燃焼>が付与されたカードを使用した後、<Heat:深暗の炎>を1点消費して効果を2回発動する。<Heat:深暗の炎>はターン終了後にリセットされる。"
  },
  Skill_98508_Name = {
    Text = "無尽の爆炎"
  },
  Skill_98704_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_98704_Name = {
    Text = "蒼白の旋回"
  },
  Skill_98705_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、追加で敵に付与された毒の[Arg3]%のダメージを与える。"
  },
  Skill_98705_Name = {Text = "攻撃"},
  Skill_98706_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[Arg2]点の<PowerIconKeywords:力>を獲得。"
  },
  Skill_98706_Name = {
    Text = "蒼白の庇護"
  },
  Skill_98707_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[Arg2]点の<PowerIconKeywords:力>を獲得。山札の上にある指令カード[Arg3]枚に[Arg4]点の「遅延」を付与する。"
  },
  Skill_98707_Name = {
    Text = "耐え難い施し"
  },
  Skill_98729_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。山札の上にある指令カード[Arg2]に[Arg3]点の「遅延」を付与する。"
  },
  Skill_98729_Name = {
    Text = "耐え難い施し"
  },
  Skill_98730_Desc = {
    Text = "<Damage:[Damage:Arg1]>ダメージを[AttackTimes:Arg2]回与え、ダメージの[Arg3]%の<IntoxicationIconKeywords:毒>を付与する。"
  },
  Skill_98730_Name = {
    Text = "蒼白の旋回"
  },
  Skill_98731_Desc = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。[Arg2]点の<PowerIconKeywords:力>を獲得。[Arg3]点の<AlertIconKeywords:警戒>を獲得。"
  },
  Skill_98731_Name = {
    Text = "蒼白の庇護"
  },
  Skill_98744_Desc = {
    Text = "「僭越者」を獲得。付与する毒が100%増加し、毎ターン終了後に<Block:[Block:Arg1]>のシールドを獲得。"
  },
  Skill_98744_Name = {
    Text = "迷途の旅"
  },
  Skill_98984_AwakerSkillBackgroundStory = {
    Text = "俺の視線に怯えないで。さあ、こっちへ、もっと近くへ……\nこの筆が描き出す絢爛たる幻想の中で、君に至高の美を授けよう。"
  },
  Skill_98984_Desc_0 = {
    Text = "【<DevouredIconKeywords:捕食> ：このターンに使用する次の指令カード1枚の行動力消費-2。】[Power:Arg1]点の<PowerIconKeywords:力>を獲得。このターン、他の覚醒体の狂気解放の最終ダメージ、シールド、ライフ回復が[Arg2]%増加する。<FaxianKeywords:発見>： <Chuanggoukeyin:創造の刻印>が付与された出撃中の覚醒体の「スキル」3枚から1枚を選び、<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を付与し、手札に追加する。"
  },
  Skill_98984_Desc_2 = {
    Text = "【<DevouredIconKeywords:捕食> ：このターンに使用する次の指令カード1枚の計算力消費-2。】[Power:Arg1]点の<PowerIconKeywords:力>を獲得。このターン、他の覚醒体の狂気解放の最終ダメージ、シールド、ライフ回復が[Arg2]%増加する。<FaxianKeywords:発見>：<Chuanggoukeyin:創造の刻印>が付与された出陣中の覚醒体の「スキル」3枚から1枚を選び、<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を付与し、手札に追加する。"
  },
  Skill_98984_EffectNameList = {Text = "力"},
  Skill_98984_Name = {
    Text = "真実、あるいは幻想"
  },
  Skill_98984_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:捕食> ：このターンに使用する次の指令カード1枚の計算力消費-2。】[Power:Arg1]点の<PowerIconKeywords:力>を獲得。このターン、他の覚醒体の狂気解放の最終ダメージ、シールド、ライフ回復が[Arg2]%増加する。1点の<Kuangxiang:狂想>を獲得。<FaxianKeywords:発現>：<Chuanggoukeyin:創造の上位刻印>が付与された出撃中の覚醒体の「スキル」を3枚から1枚を2回選び、<DepleteIconKeywords:除外>と<RetainIconKeywords:保持>を付与し、手札に追加する。"
  },
  Skill_98984_PropertyNameList = {
    Text = "攻撃力×GrowValue1"
  },
  Skill_98985_AwakerSkillBackgroundStory = {
    Text = "死骸の残影がピックマンの指先にまとわりつき、抑えきれぬひらめきがキャンバスの上で踊り狂う。\n平凡な画家は現実の表層を描くだけだが、真の芸術家は狂気を解き放ち、人知れぬ喜びや痛み、渇望、そして醜さのすべてを描き出す。"
  },
  Skill_98985_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。<EmptinessKeywords:虚無>を解除。<FaxianKeywords:発現>：<Chuanggouzaowu:創造の白銀造物>3つから1つを選んで獲得する。この造物は[Arg2]ターン持続する。"
  },
  Skill_98985_Desc_2 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+[Arg1]。<EmptinessKeywords:虚無>を解除。<FaxianKeywords:発現>：<Chuanggouzaowu:創造の黄金造物>3つから1つを選んで獲得する。この造物は[Arg2]ターン持続する。"
  },
  Skill_98985_Name = {
    Text = "影を描き、形を写す"
  },
  Skill_98986_AwakerSkillBackgroundStory = {
    Text = "これは芸術への冒涜だ！その矮小な偏見で、俺の芸術を汚すことなど許さない。"
  },
  Skill_98986_BattleDesc_0 = {
    Text = "<Block:[Block:Arg1]>点 のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_98986_BattleDesc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。<Energy:[Energy:Arg2]>狂気を獲得。ランダムな「スキル」を1枚引く。毎ターン最大1回まで発動（[Arg3]/1）。"
  },
  Skill_98986_Desc_0 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ピックマンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_98986_Desc_1 = {
    Text = "<Block:[Block:Arg1]>点のシールドを獲得。ピックマンは<Energy:[Energy:Arg2]>狂気を獲得。ランダムな「スキル」を1枚引く。毎ターン最大1回まで発動。"
  },
  Skill_98986_EffectNameList = {
    Text = "シールド,狂気"
  },
  Skill_98986_PropertyNameList = {
    Text = "防御力×GrowValue1,$GrowValue2"
  },
  Skill_98987_Desc = {
    Text = "「<Kuangxiang:狂想>」を1点消費して、すべての<FaxianKeywords:発見>効果を選択できる。1点の<Chuangyi:創意>を獲得。"
  },
  Skill_98987_Name = {
    Text = "ひらめきが湧き上がる！"
  },
  Skill_98988_AwakerSkillBackgroundStory = {
    Text = "なぜ、そんなに美を拒むんだ？\nさあ、愛しいモデルよ。俺の作品を感じてくれ。"
  },
  Skill_98988_BattleDesc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_98988_BattleDesc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。<Energy:[Energy:Arg2]>狂気を獲得。ランダムな「スキル」を1枚引く。毎ターン最大1回まで発動（[Arg3]/1）。"
  },
  Skill_98988_Desc_0 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ピックマンは<Energy:[Energy:Arg2]>狂気を獲得。"
  },
  Skill_98988_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]>ダメージを与える。ピックマンは<Energy:[Energy:Arg2]>狂気を獲得。ランダムな「スキル」を1枚引く。毎ターン最大1回まで発動。"
  },
  Skill_98988_EffectNameList = {
    Text = "ダメージ,狂気"
  },
  Skill_98988_Name = {Text = "攻撃"},
  Skill_98988_PropertyNameList = {
    Text = "攻撃力×GrowValue1,#GrowValue2"
  },
  Skill_98989_AwakerSkillBackgroundStory = {
    Text = "静謐で森閑たる墓地において、彫像のように並べられた死体は異形のモデルとなり、死の沈黙と神秘を湛え、描く者の尽きぬ想像力を刺激する。\n硬直した姿勢、青白い肌、歪んだ表情……\nピックマンは死と腐敗の中に、美の可能性を探し求めている。"
  },
  Skill_98989_Desc_0 = {
    Text = "ピックマンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：1層の<Kuangxiang:狂想>を獲得。ピックマンが<Chuangyi:創意>を1層獲得するたび、<EmbryoFusionIconKeywords:胚胎融合>+[Arg2]。"
  },
  Skill_98989_Desc_15 = {
    Text = "ピックマンは<Energy:[Energy:Arg1]>狂気を獲得。<ExaltIconKeywords:霊知覚醒>：1層の<Kuangxiang:狂想>を獲得。ピックマンが<Chuangyi:創意>を1層獲得するたび、<EmbryoFusionIconKeywords:胚胎融合>+[Arg2]。「影を描き、形を写す」で創造した黄金造物の持続ターン数が1ターンから2ターンに増加する。"
  },
  Skill_98989_EffectNameList = {
    Text = "狂気,胚胎融合"
  },
  Skill_98989_Name = {
    Text = "墓地のアトリエ"
  },
  Skill_98990_AwakerSkillBackgroundStory = {
    Text = "君は、本物の色を見たことがあるか？\nそれは従順な絵の具ではなく、侵略的で骨の髄まで染み渡る狂気だ。\nひと筆ごとに骨を蝕むような戦慄と狂喜をもたらす——それこそが、画家の追い求める至高の美なのだ。"
  },
  Skill_98990_BattleDesc = {
    Text = "全体の敵に<Damage:[Damage:Arg1]>点の必ずクリティカルになるダメージを[Arg3]回与え、ダメージを与えるたびに対象の<ExhaustionIconKeywords:力>を一時的に[Exhaustion:Arg2]点減少させ、[Power:Arg2]点の<PowerIconKeywords:一時的な力>を獲得する。このターン中に<FaxianKeywords:発見>効果を1回発動するたびに、このカードの基礎行動力消費が1減少し、「インスピレーション発動！」を発動していた場合、追加で2回ダメージを与える。"
  },
  Skill_98990_Desc = {
    Text = "全体の敵に<Damage:[Damage:Arg1]>点の必ずクリティカルになるダメージを[Arg3]回与え、ダメージを与えるたびに対象から[Arg2]点の<PowerIconKeywords:力>を<TouquKeywords:盗む>。このターン中に<FaxianKeywords:発見>効果を1回発動するたびに、このカードの基礎行動力消費が1減少し、「インスピレーション発動！」を発動していた場合、追加で2回ダメージを与える。"
  },
  Skill_98990_EffectNameList = {
    Text = "ダメージ,力の吸収"
  },
  Skill_98990_Name = {
    Text = "骨を蝕む色彩"
  },
  Skill_98990_PropertyNameList = {
    Text = "攻撃力×GrowValue1,攻撃力×GrowValue2"
  },
  Skill_99016_Desc = {
    Text = "「<Kuangxiang:狂想>」を1点消費して、すべての<FaxianKeywords:発見>効果を選択できる。1点の<Chuangyi:創意>を獲得。"
  },
  Skill_99016_Name = {
    Text = "ひらめきが湧き上がる！"
  },
  Skill_99035_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<PVPMethysisKeywords:毒>。"
  },
  Skill_99035_Name_1 = {
    Text = "幻夢绘生"
  },
  Skill_99036_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂気爆発」後、ランダムに装備者の「スキル」1枚を手札に加え、その演算力消費を0にする。"
  },
  Skill_99036_Name_1 = {
    Text = "写実主義の逆説"
  },
  Skill_99037_Desc_1 = {
    Text = "ランダムに以下の効果を3回発動：ランダムな敵に[Arg1]のダメージを与え、<DisarmKeywords:まひ>、ランダムな敵に[Arg1]のダメージを与え、<PVPMethysisKeywords:毒>、全ての敵に[Arg1]のダメージを与える。"
  },
  Skill_99037_Name_1 = {
    Text = "虚空の色彩"
  },
  Skill_99037_UnknownName = {
    Text = "虚空の色彩"
  },
  Skill_99038_Desc_1 = {
    Text = "<Damage:[Damage:Arg1]> ダメージを引き起こし、<DisarmKeywords:麻痺>。"
  },
  Skill_99038_Name_1 = {
    Text = "実色浸染"
  },
  Skill_99039_Desc_1 = {
    Text = "すべての敵に<Damage:[Damage:Arg1]>ダメージを与える。"
  },
  Skill_99039_Name_1 = {
    Text = "大放異彩"
  },
  Skill_99040_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：他の味方は毎ターン初めて「狂気解放」を使用した後、1枚のカードを引く。"
  },
  Skill_99040_Name_1 = {
    Text = "渇望の筆"
  },
  Skill_99041_Desc_1 = {
    Text = "行動力消費が [Arg1] の「スキル」を自身の異なる3枚を手札に加え、<StrongEffectKeywords:強力> +[Arg2]。"
  },
  Skill_99041_Name_1 = {
    Text = "真実、あるいは幻想"
  },
  Skill_99042_Desc_1 = {
    Text = "前列の敵に <Damage:[Damage:Arg1]> ダメージ、<Energy:[Energy:Arg2]> 狂気を得る"
  },
  Skill_99042_Name_1 = {Text = "攻撃"},
  Skill_99115_Desc = {
    Text = "「絵者」が食屍鬼形態に変化し、[Arg1]の<PowerIconKeywords:力量>を獲得する。プレイヤーのドローパイルと捨て札の中の[Arg2]枚のカードに<ErosionColorInkKeywords:認知錯乱>を付与する。"
  },
  Skill_99115_Name = {
    Text = "墓地のアトリエ"
  },
  Skill_99116_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg4]の<PowerIconKeywords:力量>を獲得する。本ラウンドに<ErosionColorInkKeywords:認知錯乱>カードを1枚使用するごとに「絵者」の<PowerIconKeywords:臨時力量>を[Arg3]低下させる。"
  },
  Skill_99116_Name = {
    Text = "真実、あるいは幻想"
  },
  Skill_99117_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを [AttackTimes:Arg2] 回与え、[Arg5]の<PowerIconKeywords:力量>を獲得する。この意図に切り替えた時、プレイヤーが<ErosionColorInkKeywords:認知錯乱>カードを1枚持つごとに「絵者」が[Arg3]の<PowerIconKeywords:力量>を獲得する。本ラウンドに<ErosionColorInkKeywords:認知錯乱>カードを1枚使用するごとに「絵者」の<PowerIconKeywords:臨時力量>を[Arg4]低下させる。"
  },
  Skill_99117_Name = {
    Text = "芸術、すなわち狂気"
  },
  Skill_99118_Desc = {
    Text = "[Arg1]点の<VulnerabilityIconKeywords:易傷>を付与する。「融蝕-追随者」と「融蝕-渇望者」を1体ずつ召喚する。"
  },
  Skill_99118_Name = {
    Text = "影を描き、形を写す"
  },
  Skill_99119_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを与え、プレイヤーのドローパイルと捨て札の中の[Arg2]枚のカードに<ErosionColorInkKeywords:認知錯乱>を付与する。すべての<DecayDye:幻世染料>を消費し、1層消費するごとにダメージ回数と<ErosionColorInkKeywords:認知錯乱>数が1増加する。"
  },
  Skill_99119_Name = {
    Text = "腐蝕の色彩"
  },
  Skill_99120_Desc = {
    Text = "[Arg1]点<VulnerabilityIconKeywords:易傷>と<WeaknessIconKeywords:虚弱>を付与する。「融蝕-詩の中の人」を1体召喚する。"
  },
  Skill_99120_Name = {
    Text = "影を描き、形を写す"
  },
  Skill_99121_Desc = {
    Text = "<Damage:[Damage:Arg1]> のダメージを与え、プレイヤーのドローパイルと捨て札の中の[Arg2]枚のカードに<ErosionColorInkKeywords:認知錯乱>を付与する。すべての<DecayDye:幻世染料>を消費し、1層消費するごとにダメージ回数と<ErosionColorInkKeywords:認知錯乱>数が1増加する。"
  },
  Skill_99121_Name = {
    Text = "腐蝕の色彩"
  }
})
return Text_Skill
