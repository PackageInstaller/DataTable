__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Skill = readonly({
  Skill_100224_Desc = {
    Text = "回合結束時回復 [Arg1] 生命。"
  },
  Skill_100224_Name = {
    Text = "創構的「恩賜之血」"
  },
  Skill_100225_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  Skill_100225_Name = {
    Text = "創構的「春之祭」"
  },
  Skill_100226_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  Skill_100226_Name = {
    Text = "創構的「銹蝕鋼鋸」"
  },
  Skill_100227_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  Skill_100227_Name = {
    Text = "創構的「染血鵝卵石」"
  },
  Skill_100228_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  Skill_100228_Name = {
    Text = "創構的「纏絲瑪瑙」"
  },
  Skill_100229_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  Skill_100229_Name = {
    Text = "創構的「重鎖」"
  },
  Skill_100230_Desc = {
    Text = "釋放「狂氣爆發」後，獲得 [Arg1] 臨時<PowerIconKeywords:力量>。"
  },
  Skill_100230_Name = {
    Text = "創構的「重鎖」"
  },
  Skill_100231_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 點狂氣。"
  },
  Skill_100231_Name = {
    Text = "創構的「金色夢鄉」"
  },
  Skill_100232_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<VulnerabilityIconKeywords:易傷>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  Skill_100232_Name = {
    Text = "創構的「春之祭」"
  },
  Skill_100233_Desc = {
    Text = "失去生命時獲得 [Arg1]% 生命損失量的猩紅熔爐。"
  },
  Skill_100233_Name = {
    Text = "創構的「銹蝕鋼鋸」"
  },
  Skill_100234_Desc = {
    Text = "回合結束時回復 [Arg1] 生命。"
  },
  Skill_100234_Name = {
    Text = "創構的「恩賜之血」"
  },
  Skill_100235_Desc = {
    Text = "每次造成傷害時獲得 [Arg1] 臨時<PowerIconKeywords:力量>，每回合至多觸發 15 次。"
  },
  Skill_100235_Name = {
    Text = "創構的「纏絲瑪瑙」"
  },
  Skill_100236_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  Skill_100236_Name = {
    Text = "創構的「惡童」"
  },
  Skill_100237_Desc = {
    Text = "拾取時對所有敵人施加 [Arg1] 層<WeaknessIconKeywords:虛弱>。所有喚醒體造成的基礎傷害提高 [Arg2]%。"
  },
  Skill_100237_Name = {
    Text = "創構的「惡童」"
  },
  Skill_100238_Desc = {
    Text = "每回合首次直接使用「胚胎」後，本回合內主動傷害會造成 [Arg1]% 傷害等量的<BleedingIconKeywords:出血>。"
  },
  Skill_100238_Name = {
    Text = "創構的「染血鵝卵石」"
  },
  Skill_100239_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>時，其他喚醒體獲得 [Arg1] 點狂氣。"
  },
  Skill_100239_Name = {
    Text = "創構的「金色夢鄉」"
  },
  Skill_100304_Desc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣，將 1 張 <DerivativeCardKeywords_4:「靈感」>洗入抽牌堆。若皮克曼在隊伍中，使其獲得 1 層「<Chuangyi:創意>」。"
  },
  Skill_100304_Name = {
    Text = "虛世之彩"
  },
  Skill_100467_Desc = {
    Text = "10層創意"
  },
  Skill_100467_Name = {
    Text = "10層創意"
  },
  Skill_100598_Desc = {
    Text = "獲得 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>，[Arg2] 層<Undercurrent:暗流>， 2 條臨時觸腕。"
  },
  Skill_100599_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，目標每有 1 層<IntoxicationIconKeywords:中毒>提高 1 點傷害。施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_100599_Name = {
    Text = "狂熱之海"
  },
  Skill_100600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，目標每有 1 層<IntoxicationIconKeywords:中毒>提高 1 點傷害。施加 1 層 「<FlickeringCandle:微弱燭光>」。"
  },
  Skill_100600_Name = {
    Text = "狂熱之海"
  },
  Skill_100601_Desc = {
    Text = "將敵方的「<FlickeringCandle:微弱燭光>」升級為等量「<LightOfTheLost:迷航之光>」，獲得 3 條觸腕上限。"
  },
  Skill_100601_Name = {
    Text = "湮塞的執念"
  },
  Skill_100602_Desc = {
    Text = "切換到該意圖時生成 1 倍的臨時觸腕，<TentacleInjurieIconKeywords:觸腕傷害>臨時降低 50%。獲得 <Block:[Block:Arg1]> 點護盾並免疫 1 回合負面狀態。"
  },
  Skill_100602_Name = {
    Text = "遺失的久遠之城"
  },
  Skill_100603_Desc = {
    Text = "切換到該意圖時生成 1 倍的臨時觸腕，<TentacleInjurieIconKeywords:觸腕傷害>臨時降低 50%。獲得 <Block:[Block:Arg1]> 點護盾並免疫 1 回合負面狀態。"
  },
  Skill_100603_Name = {
    Text = "遺失的久遠之城"
  },
  Skill_100604_Desc = {
    Text = "獲得 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>，[Arg2] 層<Undercurrent:暗流>， 2 條臨時觸腕。"
  },
  Skill_116332_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和等同於當前護盾 10％ 的臨時<PowerIconKeywords:力量>。"
  },
  Skill_116332_Name = {
    Text = "美夢一刹"
  },
  Skill_116513_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> +[Arg1]。對方<PVPCapKeywords:算力上限> +[Arg2]。"
  },
  Skill_116513_Name_1 = {
    Text = "美夢一刹"
  },
  Skill_116513_UnknownName = {
    Text = "美夢一刹"
  },
  Skill_117171_Desc_1 = {
    Text = "觸發全體敵方的<PVPCorrosionKeywords:罪印>，回復等量傷害的生命。"
  },
  Skill_117172_Desc_1 = {
    Text = "將 <PVPDerivativeCardKeywords_18:「苦痛根源·知」>、<PVPDerivativeCardKeywords_19:「靈魂枷鎖·惑」>、<PVPDerivativeCardKeywords_20:「毀滅信仰·執」> 各 1 張置入手牌。"
  },
  Skill_117172_Name_1 = {
    Text = "無罪的聖裁"
  },
  Skill_117173_Desc_1 = {
    Text = "驅散一名敵方的正面狀態，對其造成 <Damage:[Damage:Arg1]> 傷害，<PVPEntanglementKeywords:纏繞>。觸發全體敵方的<PVPCorrosionKeywords:罪印>，損失 <Damage:[Arg2]> 生命。"
  },
  Skill_117173_Name_1 = {
    Text = "毀滅信仰·執"
  },
  Skill_117174_Desc_1 = {
    Text = "施加 <Damage:[Damage:Arg1]> <PVPCorrosionKeywords:罪印>，損失 <Damage:[Arg2]> 生命，"
  },
  Skill_117174_Name_1 = {
    Text = "褻瀆聖心"
  },
  Skill_117175_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>並<PVPWeaknessKeywords:虛弱>目標，對其造成 <Damage:[Damage:Arg1]> 傷害。觸發全體敵方的<PVPCorrosionKeywords:罪印>，損失 <Damage:[Arg2]> 生命。"
  },
  Skill_117175_Name_1 = {
    Text = "靈魂枷鎖·惑"
  },
  Skill_117176_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_117176_Name_1 = {Text = "打擊"},
  Skill_117177_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方施加 [Arg1] <PVPCorrosionKeywords:罪印>並造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_117177_Name_1 = {
    Text = "無妄皈依"
  },
  Skill_117178_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>，<PVPMethysisKeywords:中毒>。觸發全體敵方的<PVPCorrosionKeywords:罪印>，損失 <Damage:[Arg2]> 生命。"
  },
  Skill_117207_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」前和回合結束時，對<HPAndShieldMax:生命與護盾最高>的敵方施加 <Damage:[Damage:Arg1]> 層<PVPCorrosionKeywords:罪印>。"
  },
  Skill_117207_Name_1 = {
    Text = "扭曲的騎士詩"
  },
  Skill_117208_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，對狂氣最高的敵方造成 [Arg1] <PVPfengsuoKeywords:爆發封鎖>。"
  },
  Skill_117208_Name_1 = {
    Text = "聖子尊容"
  },
  Skill_117272_Desc = {
    Text = "棄掉所有手牌並抽 5 張牌，將「循環的倒影」置入手牌堆、抽牌堆、棄牌堆。"
  },
  Skill_117272_Name = {
    Text = "久遠的幻夢"
  },
  Skill_117274_Desc = {
    Text = "<FaxianKeywords:發現> 3 張「追憶效果」，選擇 1 張將其釋放，獲得 <Posse:[Arg1]> 點銀鑰能量，隨機將 1 張被消耗的具有「淵海回聲」刻印的卡牌洗入棄牌堆。<RippleKeywords:餘波>：所有喚醒體獲得 5 點狂氣。"
  },
  Skill_117274_Name = {
    Text = "循環的倒影"
  },
  Skill_117275_Desc = {
    Text = "<FaxianKeywords:發現> 3 張「追憶效果」，選擇 1 張將其釋放。<RippleKeywords:餘波>：所有喚醒體獲得 5 點狂氣。"
  },
  Skill_117275_Name = {
    Text = "循環的倒影"
  },
  Skill_117276_BattleDesc = {
    Text = "棄掉所有手牌並抽 5 張牌，將「循環的倒影」置入手牌堆、抽牌堆、棄牌堆。可使用 [Arg1] 次。"
  },
  Skill_117276_Desc = {
    Text = "棄掉所有手牌並抽 5 張牌，將「循環的倒影」置入手牌堆、抽牌堆、棄牌堆。可使用 3 次。"
  },
  Skill_117276_Name = {
    Text = "久遠的幻夢"
  },
  Skill_117277_Desc = {
    Text = "從手牌中選擇 1 張非衍生指令卡，使其本場戰鬥造成的傷害、護盾、生命回復提高 [Arg1]％，直到下次打出前算力消耗變為 0。"
  },
  Skill_117277_Name = {
    Text = "未完的蠟像"
  },
  Skill_117278_Desc = {
    Text = "<FaxianKeywords:發現> 3 張「追憶效果」，選擇 1 張將其釋放，獲得 <Posse:[Arg1]> 點銀鑰能量。<RippleKeywords:餘波>：所有喚醒體獲得 5 點狂氣。"
  },
  Skill_117278_Name = {
    Text = "循環的倒影"
  },
  Skill_117301_Desc = {
    Text = "從手牌中選擇 1 張非衍生指令卡，將其 3 張具有<DepleteIconKeywords:消耗>的原始複製洗入抽牌堆。這些卡牌直到下次打出前，算力消耗降低 1。"
  },
  Skill_117301_Name = {
    Text = "豐穰之核"
  },
  Skill_117302_Desc_1 = {
    Text = "抽 [Arg1] 張算力消耗最高的「技能」，使其獲得<PrepareKeywords:預備2>。"
  },
  Skill_117302_Name_1 = {
    Text = "泣血的聖心"
  },
  Skill_117302_UnknownName = {
    Text = "泣血的聖心"
  },
  Skill_117312_AwakerSkillBackgroundStory = {
    Text = "於麗埃特曾說，世界是污濁的，教會的使命就是將世間的罪孽洗淨。\n他是神所選中的聖子，他已經過重重考驗，擁有神聖的心靈。 \n只消幾句無聲的禱告，便可使虔誠的信徒感激涕零。 \n將那心靈如燈芯一般燃燒吧，賜下祂的恩惠，那光芒的照耀下，必將帶來純潔的福祉。"
  },
  Skill_117312_Desc = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，抽 2 張算力消耗最低的指令卡。"
  },
  Skill_117312_EffectNameList = {Text = "傷害"},
  Skill_117312_Name = {
    Text = "明燈灼魂"
  },
  Skill_117312_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_117313_AwakerSkillBackgroundStory = {
    Text = "他賜下的福祉，同樣是漆黑的毒汁。"
  },
  Skill_117313_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_117313_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。波呂克斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_117313_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_117313_Name = {Text = "打擊"},
  Skill_117313_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_117314_AwakerSkillBackgroundStory = {
    Text = "他們是有罪的，那流淌的黑色神血就是證明。\n他們應受審判，只有洗清罪孽才可得入淨土。\n裁決吧，宣告他們的罪，放出他們的血，將判罰降臨在他們的頭上。\n這是聖子的權能與職責。"
  },
  Skill_117314_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，進入超維回合時會自動被抽出。"
  },
  Skill_117314_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，每打出 1 張「聖心」下次打出時算力消耗-1，進入超維回合時會自動被抽出。"
  },
  Skill_117314_EffectNameList = {Text = "傷害"},
  Skill_117314_Name = {
    Text = "離垢的審判"
  },
  Skill_117314_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_117315_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果 ([Arg2]/3)。"
  },
  Skill_117315_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果。"
  },
  Skill_117315_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果且生效 2 次。"
  },
  Skill_117315_Name = {Text = "聖心"},
  Skill_117315_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg3]％ 出血，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_4 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg3]％ 出血，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_5 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg3]％ 出血，獲得 3 層<ZuiyinKeywords:罪印>。打出後將此卡牌洗入抽牌堆頂部，本回合算力消耗變為 0 且施加 100％ 傷害的<BleedingIconKeywords:出血>。第 3 次打出時<DepleteIconKeywords:消耗>並使自身下張指令卡享受「苦痛救贖」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117316_AwakerSkillBackgroundStory = {
    Text = "這顆光明的心將為他抵擋一切罪惡。"
  },
  Skill_117316_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_117316_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。波呂克斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_117316_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_117316_Name = {Text = "防禦"},
  Skill_117316_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_117317_AwakerSkillBackgroundStory = {
    Text = "「波呂克斯，你的聖心代行著持燈者的光輝，你要如敬愛祂一樣珍重這份榮耀。」 \n於是他將那份虛無的冠冕戴在頭上，不敢懈怠。 \n「波呂克斯，不要害怕，你要去嚐嚐自由是什麼味道……」 \n他因這榮耀獲得了一切，又因這榮耀失去了一切，於是他發覺這冠冕不過是無形的鐐銬。 \n他撕毀了冠冕，那顆空虛的心臟第一次發出了亮如白晝的光芒，只是那些憤怒的哀鳴再也無法傳達到另一個人的耳畔。"
  },
  Skill_117317_Desc = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，使自身本回合下張指令卡享受「苦痛救贖」效果。將 1 張<DerivativeCardKeywords_118:「聖心」>置入手中。"
  },
  Skill_117317_EffectNameList = {Text = "傷害"},
  Skill_117317_Name = {
    Text = "無罪的聖裁"
  },
  Skill_117317_OverLimitUtlSkillDesc = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，使自身本回合下張指令卡享受「苦痛救贖」效果。將 2 張<DerivativeCardKeywords_118:「聖心」>置入手中。本回合內波呂克斯每張指令卡額外享受 50% 「苦痛救贖」效果，自身下一張指令卡額外生效 1 次。"
  },
  Skill_117317_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_117318_AwakerSkillBackgroundStory = {
    Text = "過去他的雙眼被蒙上陰翳，於是他視那黑暗的如同白晝。 \n如今他已重見世界的真貌，於是他轉身踏向相反的道路。 \n無論何時，他總在向光明前進。"
  },
  Skill_117318_Desc_0 = {
    Text = "波呂克斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：打出時和棄牌階段後獲得 3 層<ZuiyinKeywords:罪印>，每有 1 張手牌額外獲得 1 層<ZuiyinKeywords:罪印>。「聖心」造成 100% 傷害的出血。"
  },
  Skill_117318_Desc_15 = {
    Text = "波呂克斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：打出時和棄牌階段後獲得 3 層<ZuiyinKeywords:罪印>，每有 1 張手牌額外獲得 1 層<ZuiyinKeywords:罪印>。「聖心」造成 100% 傷害的出血，因打出而洗入抽牌堆後，該「聖心」本回合算力消耗變為 0 且施加 100％ 傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_117318_EffectNameList = {Text = "狂氣"},
  Skill_117318_Name = {
    Text = "淨世之路"
  },
  Skill_117494_Desc_1 = {
    Text = "移除狂氣"
  },
  Skill_117494_Name_1 = {
    Text = "移除狂氣"
  },
  Skill_117740_Name_1 = {
    Text = "罪印測試"
  },
  Skill_117757_Desc = {
    Text = "抽 1 張牌並使其算力消耗-1，若抽到指令卡則使其擁有者獲得 [Arg1]％ 臨時暴擊傷害。若波呂克斯在隊伍中，獲得 [Arg2] 層<ZuiyinKeywords:罪印>。"
  },
  Skill_117757_Name = {
    Text = "泣血的聖心"
  },
  Skill_117861_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量<BleedingIconKeywords:出血>和傷害 10%的<IntoxicationColour:中毒>。"
  },
  Skill_117861_Name = {
    Text = "污穢血祭"
  },
  Skill_117862_Desc = {
    Text = "施加 [Arg1] 層<SacrificeKeyWord:獻祭>和 1 層<EmptinessKeywords: 空虛>。"
  },
  Skill_117862_Name = {
    Text = "深淵祝告"
  },
  Skill_117863_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_117863_Name = {Text = "揮擊"},
  Skill_118055_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，若造成了未被格擋的傷害則獲得 [Arg3] 層「互助契約：深海分殖體」。"
  },
  Skill_118055_Name = {
    Text = "提燈明照"
  },
  Skill_118056_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 1 層<HeavyInjuryKeywords:重創>，玩家每擁有 1 點護盾使本次傷害降低 1 點。"
  },
  Skill_118056_Name = {
    Text = "靈智污染"
  },
  Skill_118057_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，重創 [Arg3] 回合，玩家每擁有 1 點護盾使本次傷害降低 1 點。"
  },
  Skill_118057_Name = {
    Text = "重創刺骨"
  },
  Skill_118058_Desc = {
    Text = "切換到該意圖時獲得 1 層<Flaw:破綻>。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對敵方施加 [Arg3] 層<BirthRitual:降生儀式>，每有 1 層<FatePact:命契>提高 1 層。"
  },
  Skill_118058_Name = {
    Text = "萬劫輪回的天幕"
  },
  Skill_118059_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<RetaliateIconKeywords:臨時反擊>，玩家每剩餘 1 張手牌，提高 [Arg4] 層<RetaliateIconKeywords:臨時反擊>。"
  },
  Skill_118059_Name = {
    Text = "怨毒復仇"
  },
  Skill_118060_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次（每 2 條觸腕使傷害次數提高 1）。造成 [Arg3] 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，驅散自身負面狀態。"
  },
  Skill_118061_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。直到回合結束前，玩家每擁有 1 張手牌，攻擊次數就減少 1，最低為 3。"
  },
  Skill_118062_Desc = {
    Text = "在前排召喚 1 個「利莫里亞喚醒體」。"
  },
  Skill_118062_Name = {
    Text = "應選之人"
  },
  Skill_118063_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張<DerivativeCardKeywords_3:「驚厥」>洗入抽牌堆。"
  },
  Skill_118063_Name = {
    Text = "無上生祭"
  },
  Skill_118064_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，立刻獲得 [Arg3] 層「互助契約：深海分殖體」。"
  },
  Skill_118065_Desc = {
    Text = "切換至該意圖時，獲得等同於當前觸腕條數的臨時觸腕。獲得 <Block:[Block:Arg1]> 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_118065_Name = {
    Text = "自由誓願"
  },
  Skill_118066_Desc = {
    Text = "使「呼喚」獲得額外效果：達到 5 層後，立即封印所有喚醒體。"
  },
  Skill_118066_Name = {Text = "覺醒"},
  Skill_118068_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_118070_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每次造成未被格擋的傷害時，依次施加 1 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<Decay:腐朽>。"
  },
  Skill_118070_Name = {
    Text = "樂園重啟"
  },
  Skill_118071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加 1 層<Decay:腐朽>。在回合開始時，選擇 1 枚「聖象賜福」，將其反轉為「詛咒」。"
  },
  Skill_118072_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [TentaclePower:Arg3] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_118072_Name = {Text = "打擊"},
  Skill_118074_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾、 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>和 [Arg3] 層<Undercurrent:暗流>。"
  },
  Skill_118074_Name = {
    Text = "觸足壁壘"
  },
  Skill_118076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<Decay:腐朽>。"
  },
  Skill_118076_Name = {
    Text = "觸腕捕食"
  },
  Skill_118077_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，若造成了未被格擋的傷害則獲得 [Arg3] 層「互助契約：深海分殖體」。"
  },
  Skill_118077_Name = {
    Text = "提燈明照"
  },
  Skill_118078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，封印狂氣最高的喚醒體 1 回合。"
  },
  Skill_118080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，棄掉玩家所有保留的手牌，每次造成未被格擋的傷害時，將 [Arg3] 張<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆頂部。"
  },
  Skill_118080_Name = {Text = "絞殺"},
  Skill_118083_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg2] 次 ，額外造成玩家當前生命 50% 的傷害（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 層<Decay:腐朽>。"
  },
  Skill_118083_Name = {
    Text = "腐骨重擊"
  },
  Skill_118084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾，每層「呼喚」使護盾提高 <Block:[Block:Arg4]> 點。"
  },
  Skill_118084_Name = {Text = "試探"},
  Skill_118086_Desc = {
    Text = "切換到該意圖時獲得 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>。若目標生命低於 50%，施加 [Arg2] 層<Decay:腐朽>，否則施加 [Arg3] 層 <WeaknessIconKeywords:虛弱>。"
  },
  Skill_118086_Name = {
    Text = "乞靈之咒"
  },
  Skill_118087_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾、 [Arg2] 層 <SacrificeKeyWord:獻祭>和 [TentaclePower:Arg3] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_118087_Name = {
    Text = "聖女作成"
  },
  Skill_118090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每造成 1 次傷害，生成 1 條臨時觸腕。直到回合結束前，玩家每擁有 1 張手牌，攻擊次數就減少 1，最低為 3。"
  },
  Skill_118090_Name = {
    Text = "狂蛇亂舞"
  },
  Skill_118091_Desc = {
    Text = "獲得 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>，觸腕上限提高 1。自身獲得 [Arg2] 層<SacrificeKeyWord:獻祭>。"
  },
  Skill_118091_Name = {
    Text = "深海聖詠"
  },
  Skill_118092_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<ResentChainsKeywords:怨恨鎖鏈>。每失去 1 層<Abyssallock:夢境桎梏>使獲得的<ResentChainsKeywords:怨恨鎖鏈>提高 1 ，傷害提高  <Damage:[Damage:Arg4]>  點。"
  },
  Skill_118092_Name = {
    Text = "永世牢籠"
  },
  Skill_118093_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，為抽牌堆和棄牌堆 [Arg3] 張隨機卡牌附加<SeastriderCurse:蹈海者咒怨>。"
  },
  Skill_118093_Name = {
    Text = "提燈明照"
  },
  Skill_118094_Desc = {
    Text = "獲得 [Arg1] 層「血誓」和 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_118094_Name = {
    Text = "燃已燈芯"
  },
  Skill_118095_Desc = {
    Text = "切換至該意圖時，獲得等同於當前觸腕條數的臨時觸腕。獲得 <Block:[Block:Arg1]> 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_118095_Name = {
    Text = "虛妄繼承者"
  },
  Skill_118096_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 [Arg3]  層<HeavyInjuryKeywords:重創>，玩家每擁有 1 點護盾使本次傷害降低 1 點。"
  },
  Skill_118096_Name = {
    Text = "罪孽鞭撻"
  },
  Skill_118097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。切換到該意圖時獲得 [Arg3] 層臨時的<Abyssallock2:夢境桎梏>。回合結束時每有 1 張<SlowIconKeywords:遲緩>手牌在手中，額外造成 1 次傷害。"
  },
  Skill_118097_Name = {
    Text = "「無憂淨土」"
  },
  Skill_118099_Desc = {
    Text = "獲得 [Arg1] 層「血誓」和 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_118099_Name = {
    Text = "燃已燈芯"
  },
  Skill_118100_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<Decay:腐朽>。"
  },
  Skill_118100_Name = {
    Text = "觸腕捕食"
  },
  Skill_118101_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg2] 次 ，額外造成玩家當前生命 25% 的傷害（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 層<Decay:腐朽>。"
  },
  Skill_118101_Name = {
    Text = "腐骨重擊"
  },
  Skill_118102_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每有 2 層「血誓」，獲得 1 條臨時觸腕。"
  },
  Skill_118103_Desc = {
    Text = "獲得 [Arg1] 層「血誓」和 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_118103_Name = {
    Text = "燃已燈芯"
  },
  Skill_118104_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，「封印」所有喚醒體 1 回合。獲得 2 層<MutualAid1:互助契約：利莫里亞>。"
  },
  Skill_118104_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_118105_Desc = {
    Text = "對敵方施加 [Arg1] 層<BirthRitual:降生儀式>，獲得 [Arg2] 層<FatePact:命契>，對自身施加 1 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_118105_Name = {
    Text = "螺湮圓舞"
  },
  Skill_118106_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3]  條觸腕上限並生成 [Arg3] 條觸腕 、獲得 [TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>。附加 [Arg5] 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重創>。"
  },
  Skill_118106_Name = {
    Text = "「神國幻象」"
  },
  Skill_118107_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每有 2 層「血誓」，獲得 1 條臨時觸腕。"
  },
  Skill_118107_Name = {
    Text = "罪孽鞭撻"
  },
  Skill_118108_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<RetaliateIconKeywords:臨時反擊>，玩家每剩餘 1 張手牌，提高 [Arg4] 層<RetaliateIconKeywords:臨時反擊>。"
  },
  Skill_118108_Name = {
    Text = "怨毒復仇"
  },
  Skill_118109_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<IntoxicationIconKeywords:中毒>，敵方生命越低傷害越高，最大為  <Damage:[Damage:Arg4]>  點傷害。"
  },
  Skill_118109_Name = {
    Text = "藍環毒素"
  },
  Skill_118648_Desc = {
    Text = "施加 [Arg2] 層<IntoxicationIconKeywords:中毒>。若仍然有其他敵人存在，犧牲自身進行寄生，並附加「被寄生」狀態。"
  },
  Skill_118767_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 點<PunctureDamagewords:穿刺傷害> [AttackTimes:Arg2] 次 ，額外造成玩家當前生命 50% 的<PunctureDamagewords:穿刺傷害>（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 層<Decay:腐朽>。"
  },
  Skill_118929_Desc = {
    Text = "生成 2 條觸腕，觸腕上限提高 2。"
  },
  Skill_118974_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次（每 2 條觸腕使傷害次數提高 1）。造成 [Arg3] 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，驅散自身負面狀態。"
  },
  Skill_118975_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾、 [Arg2] 層 <SacrificeKeyWord:獻祭>和 [TentaclePower:Arg3] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_118975_Name = {
    Text = "聖女作成"
  },
  Skill_119040_Desc_1 = {
    Text = "將 [Arg1] 張隨機友方的「打擊」洗入抽牌堆，抽 [Arg2] 張「打擊」。"
  },
  Skill_119040_Name_1 = {
    Text = "來自霧境"
  },
  Skill_119040_UnknownName = {
    Text = "來自霧境"
  },
  Skill_119041_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：全體友方「打擊」傷害提高 [Arg1]%。"
  },
  Skill_119041_Name_1 = {
    Text = "理智明燈"
  },
  Skill_119042_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [Arg1]%，任意友方打出「打擊」後抽 [Arg3] 張牌，每回合最多觸發 [Arg2] 次。"
  },
  Skill_119042_Name_1 = {
    Text = "狂戮至世界盡頭"
  },
  Skill_119043_Desc_1 = {
    Text = "造成合計 [Arg1] <PVPSacrificeKeyWords:獻祭>，平均分配給所有敵方。"
  },
  Skill_119044_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，對最少獻祭的敵方施加 [Arg1] <PVPSacrificeKeyWords:獻祭>，重複 [Arg2] 次。全體友方不再受到<PVPCapKeywords:算力上限>減少效果影響。"
  },
  Skill_119045_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使全體敵方本回合受到主動傷害後獲得傷害 [Arg1]% 的<PVPSacrificeKeyWords:獻祭>。"
  },
  Skill_119045_Name_1 = {
    Text = "藍環毒素"
  },
  Skill_119088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合 <WeaknessIconKeywords:虛弱>並獲得 <Block:[Block:Arg3]>  點護盾。每層「呼喚」使護盾提高 <Block:[Block:Arg4]> 點。"
  },
  Skill_119088_Name = {Text = "試探"},
  Skill_119089_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，「封印」狂氣最高的喚醒體 1 回合，並使其在牌堆中的隨機 [Arg3] 張技能卡獲得 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_119090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張隨機症狀卡洗入抽牌堆。"
  },
  Skill_119090_Name = {
    Text = "無上生祭"
  },
  Skill_119091_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，「封印」所有喚醒體 1 回合。獲得 2 層<MutualAid1:互助契約：利莫里亞>。"
  },
  Skill_119091_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_119092_Desc = {
    Text = "回復 10% 已損失生命，每層「呼喚」都會使回復量提高 20%。在前排召喚 1 個「利莫里亞喚醒體」。"
  },
  Skill_119092_Name = {
    Text = "應選之人"
  },
  Skill_119110_Desc = {
    Text = "施加 [Arg1] 層<SacrificeKeyWord:獻祭>。回合開始時獲得 [Arg2] 層<FatePact:命契>。"
  },
  Skill_119110_Name = {
    Text = "命運之檻"
  },
  Skill_119113_Desc_1 = {
    Text = "<StrengthenKeywords:強化>自身並獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_119114_BattleDesc_1 = {
    Text = "驅散自身的負面狀態，對全體敵方造成 [Arg2] 次 <Damage:[Damage:Arg1]> 傷害，每有 1 個死亡友方額外造成 1 次傷害。"
  },
  Skill_119114_Desc_1 = {
    Text = "驅散自身的負面狀態，對全體敵方造成 1 次 <Damage:[Damage:Arg1]> 傷害，每有 1 個死亡友方額外造成 1 次傷害。"
  },
  Skill_119114_Name_1 = {
    Text = "閃耀☆龍捲風"
  },
  Skill_119115_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。每打出 1 張「打擊」算力消耗 -1。"
  },
  Skill_119115_Name_1 = {
    Text = "毀滅撕裂"
  },
  Skill_119116_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_119116_Name_1 = {Text = "打擊"},
  Skill_119118_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，觸發等量<PVPBleedingKeywords:出血>，同時視為「打擊」。"
  },
  Skill_119118_Name_1 = {
    Text = "破霧強襲"
  },
  Skill_119313_Desc = {
    Text = "獲得額外的 3 枚生命條，最大生命提高 250%，獲得最大生命 10% 的「舊日餘燼」。 獲得 5 條觸腕上限和「觸腕集結」。"
  },
  Skill_119313_Name = {
    Text = "海域輪回"
  },
  Skill_119334_BattleDesc = {
    Text = "獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119334_Desc = {
    Text = "獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119334_Name = {
    Text = "幻想祭儀"
  },
  Skill_119335_BattleDesc = {
    Text = "儀式目標：打出 4 張防禦。\n儀式獎勵：回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119335_Desc = {
    Text = "儀式目標：打出 4 張防禦。\n儀式獎勵：回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119335_Name = {
    Text = "天真祭儀"
  },
  Skill_119336_BattleDesc = {
    Text = "儀式目標：釋放 4 次狂氣爆發([Arg1]/4)。\n儀式獎勵：所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119336_Desc = {
    Text = "儀式目標：釋放 4 次狂氣爆發。\n儀式獎勵：所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119336_Name = {
    Text = "自由祭儀"
  },
  Skill_119337_BattleDesc = {
    Text = "儀式目標：釋放 4 次狂氣爆發。\n儀式獎勵：所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119337_Desc = {
    Text = "儀式目標：釋放 4 次狂氣爆發。\n儀式獎勵：所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119337_Name = {
    Text = "自由祭儀"
  },
  Skill_119338_BattleDesc = {
    Text = "回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119338_Desc = {
    Text = "回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119338_Name = {
    Text = "天真祭儀"
  },
  Skill_119339_BattleDesc = {
    Text = "儀式目標：釋放 3 次鑰令([Arg1]/3)。\n儀式獎勵：獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119339_Desc = {
    Text = "儀式目標：釋放 3 次鑰令。\n儀式獎勵：獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119339_Name = {
    Text = "幻想祭儀"
  },
  Skill_119340_BattleDesc = {
    Text = "所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119340_Desc = {
    Text = "所有喚醒體獲得 <Energy:30> 點狂氣。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119340_Name = {
    Text = "自由祭儀"
  },
  Skill_119341_BattleDesc = {
    Text = "儀式目標：打出 4 張防禦([Arg1]/4)。\n儀式獎勵：回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119341_Desc = {
    Text = "儀式目標：打出 4 張防禦。\n儀式獎勵：回復 50% 已損失生命。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命的 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119341_Name = {
    Text = "天真祭儀"
  },
  Skill_119342_Desc = {
    Text = "選擇一項獻祭儀式，每種儀式限一次。"
  },
  Skill_119342_Name = {
    Text = "敬獻神明"
  },
  Skill_119343_BattleDesc = {
    Text = "儀式目標：釋放 3 次鑰令。\n儀式獎勵：獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119343_Desc = {
    Text = "儀式目標：釋放 3 次鑰令。\n儀式獎勵：獲得 2000 點銀鑰能量。清空自身所有 <SacrificeKeyWord:獻祭>，並對全體敵方施加 5% 最大生命 <SacrificeKeyWord:獻祭>。"
  },
  Skill_119343_Name = {
    Text = "幻想祭儀"
  },
  Skill_119574_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」前、「技能」前、「狂氣爆發」前臨時<StrongEffectKeywords:強效> +[Arg1]，每回合各效果僅能觸發一次。"
  },
  Skill_119574_Name_1 = {
    Text = "你我終將重逢"
  },
  Skill_119712_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_122:聖像賜福：智識之夢>」，所有喚醒體立刻失去 50% 狂氣，所有喚醒體造成的狂氣降低 50%。"
  },
  Skill_119712_Desc = {
    Text = "失去「<DerivativeCardKeywords_122:聖像賜福：智識之夢>」，所有喚醒體立刻失去 50% 狂氣，所有喚醒體造成的狂氣降低 50%。"
  },
  Skill_119712_Name = {
    Text = "聖像詛咒：癡愚之歎"
  },
  Skill_119713_BattleDesc = {
    Text = "打出後本回合不受「聖象詛咒」效果影響並免疫所有傷害，敵人的「舊日餘燼」效果永久翻倍。"
  },
  Skill_119713_Desc = {
    Text = "打出後本回合不受「聖像詛咒」效果影響並免疫所有傷害，敵人的「舊日餘燼」效果永久翻倍。"
  },
  Skill_119713_Name = {
    Text = "銀鑰，必會指引前路"
  },
  Skill_119714_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3]  條觸腕上限並生成 [Arg3] 條觸腕 、獲得 [TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>。附加 [Arg5] 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重創>。"
  },
  Skill_119714_Name = {
    Text = "「神國幻象·終結」"
  },
  Skill_119715_BattleDesc = {
    Text = "每回合開始時獲得最大生命的 5% 的<PowerIconKeywords:力量>，臨時暴擊率 +25%。"
  },
  Skill_119715_Desc = {
    Text = "每回合開始時獲得最大生命的 5% 的<PowerIconKeywords:力量>，臨時暴擊率 +25%。"
  },
  Skill_119715_Name = {
    Text = "聖像賜福：威能之夢"
  },
  Skill_119716_BattleDesc = {
    Text = "每回合開始時回復已損失生命的 15%。"
  },
  Skill_119716_Desc = {
    Text = "每回合開始時回復已損失生命的 15%。"
  },
  Skill_119716_Name = {
    Text = "聖像賜福：永恆之夢"
  },
  Skill_119717_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_120:聖像賜福：永恆之夢>」，立刻失去 50% 當前生命，所有喚醒體生命回復降低 50%。"
  },
  Skill_119717_Desc = {
    Text = "失去「<DerivativeCardKeywords_120:聖像賜福：永恆之夢>」，立刻失去 50% 最大生命，所有喚醒體生命回復降低 50%。"
  },
  Skill_119717_Name = {
    Text = "聖像詛咒：破滅之恨"
  },
  Skill_119718_BattleDesc = {
    Text = "每回合開始時所有喚醒體獲得 <Energy:10> 點狂氣。"
  },
  Skill_119718_Desc = {
    Text = "每回合開始時所有喚醒體獲得 <Energy:10> 點狂氣。"
  },
  Skill_119718_Name = {
    Text = "聖像賜福：智識之夢"
  },
  Skill_119719_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_121:聖像賜福：威能之夢>」，立刻失去 50% 力量，所有喚醒體獲得力量效果降低 50%。"
  },
  Skill_119719_Desc = {
    Text = "失去「<DerivativeCardKeywords_121:聖像賜福：威能之夢>」，立刻失去 50% 力量，所有喚醒體獲得力量效果降低 50%。"
  },
  Skill_119719_Name = {
    Text = "聖像詛咒：衰亡之哀"
  },
  Skill_119762_AwakerSkillBackgroundStory = {
    Text = "神母的指示不容駁斥。"
  },
  Skill_119762_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_119762_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 1 張「深海聖詠」，每回合最多生效 1 次( [Arg3]/1 )。"
  },
  Skill_119762_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。誕妄·墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_119762_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。誕妄·墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 1 張「深海聖詠」，每回合最多生效 1 次。"
  },
  Skill_119762_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_119762_Name = {Text = "打擊"},
  Skill_119762_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_119763_AwakerSkillBackgroundStory = {
    Text = "她是傲慢的。她用傲慢掩飾內心無法修補的空洞。\n她忘記了自己曾是什麼人，她忘記了自己應該是什麼人。\n萬千蹈海信徒臣服於她的足下，而她則在聲聲尊崇中遺忘了最重要的事物——\n她已經臣服於這蒼白的命運。"
  },
  Skill_119763_BattleDesc = {
    Text = "獲得 2 點算力，抽 2 張牌。下回合開始時受到 [Arg3] 點<SacrificeKeyWord:獻祭>。<RippleKeywords:餘波>：移除 [Arg4] 點<SacrificeKeyWord:獻祭>。"
  },
  Skill_119763_Desc = {
    Text = "獲得 2 點算力，抽 2 張牌。下回合開始時受到最大生命 [Arg1]% 的<SacrificeKeyWord:獻祭>。<RippleKeywords:餘波>：移除最大生命 [Float:Arg2]％ 的<SacrificeKeyWord:獻祭>。"
  },
  Skill_119763_EffectNameList = {
    Text = "移除獻祭比例"
  },
  Skill_119763_Name = {
    Text = "深海聖詠"
  },
  Skill_119764_AwakerSkillBackgroundStory = {
    Text = "墨菲手中象牙雕像的來歷眾說紛紜。\n有人說那座雕像來源於墨菲指示下探索的深海遺址，也有人說那座雕像與聖嬰一同自她胸口躍動的心臟降生。\n但毋庸置疑的是，這座象徵著她與那座靜默於無明海底的螺湮之城千絲萬縷聯繫的雕像，是在墨菲成為「真正的神母」那天出現在蹈海者的視線中的。\n在那之後，信眾們也見證了墨菲利用這座象牙雕像破開風浪，割開血海。\n絕對的權力，往往並非止於虛幻的象徵。人性的膝蓋，只會跪伏於絕對力量的權威下。"
  },
  Skill_119764_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，下回合開始時受到 [Arg7] 點<SacrificeKeyWord:獻祭>。對所有敵人施加 [Arg3] 層<DwmofeiKeywords:降生儀式>，對生命最高敵方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 點傷害，享受 [Arg6]％ <TentacleInjurieIconKeywords:觸腕傷害>加成。"
  },
  Skill_119764_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，下回合開始時受到最大生命 [Arg2]% 的<SacrificeKeyWord:獻祭>。對所有敵人施加 [Arg3] 層<DwmofeiKeywords:降生儀式>，對生命最高敵方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 點傷害，享受 [Arg6]％ <TentacleInjurieIconKeywords:觸腕傷害>加成。"
  },
  Skill_119764_EffectNameList = {
    Text = "護盾,降生儀式層數,傷害,觸腕傷害加成"
  },
  Skill_119764_Name = {
    Text = "虛妄王女"
  },
  Skill_119764_OverLimitUtlSkillDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，下回合開始時受到 [Arg7] 點<SacrificeKeyWord:獻祭>。對所有敵人施加 [Arg8] 層<DwmofeiKeywords:降生儀式>，對生命最高敵方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 點傷害，享受 [Arg6]％ <TentacleInjurieIconKeywords:觸腕傷害>加成。將 3 張算力消耗為 2 的「螺湮圓舞」置入手中並使其獲得<DepleteIconKeywords:消耗>和<PrepareKeypvewords1:預備1>。"
  },
  Skill_119764_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3,$GrowValue4％"
  },
  Skill_119765_AwakerSkillBackgroundStory = {
    Text = "她是輕佻的。她用輕佻對抗殘破不堪的現實。\n讓我們跳舞吧，她說，跳一支敬獻給神明的舞。\n感謝神明賜予我們倒錯的因果，凌亂的過往，和不可捉摸的未來。\n聚光燈下，她是一切唯一的焦點。"
  },
  Skill_119765_BattleDesc = {
    Text = "獲得 <Posse:[Arg7]> 點銀鑰能量。根據觸腕姿態獲得不同效果：「潮湧」：<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]，生成 1 條觸腕。「靜海」：獲得 <Block:[Block:Arg2]> 點護盾，護盾保留 50％ 到下回合。「怒濤」：對生命最高敵方造成 [Arg3] 次 <Damage:[Damage:Arg4]> 點傷害，享受 [Arg5]％ <TentacleInjurieIconKeywords:觸腕傷害>加成。"
  },
  Skill_119765_Desc = {
    Text = "獲得 [Arg6]％ 銀鑰充能的銀鑰能量。根據觸腕姿態獲得不同效果：「潮湧」：<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg8]，生成 1 條觸腕。「靜海」：獲得 <Block:[Block:Arg9]> 點護盾，護盾保留 50％ 到下回合。「怒濤」：對生命最高敵方造成 [Arg3] 次 <Damage:[Damage:Arg4]> 點傷害，享受 [Arg5]％ <TentacleInjurieIconKeywords:觸腕傷害>加成。"
  },
  Skill_119765_EffectNameList = {
    Text = "觸腕傷害,護盾,傷害,觸腕傷害加成,銀鑰充能效率"
  },
  Skill_119765_Name = {
    Text = "螺湮圓舞"
  },
  Skill_119765_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,攻擊力*GrowValue3,$GrowValue4％,$GrowValue5％"
  },
  Skill_119766_AwakerSkillBackgroundStory = {
    Text = "她將神的臍帶血滴入海中。她向神祈求永不抵達終點的航路。\n只要夢的泡沫仍在延續，她就是唯一的神母。"
  },
  Skill_119766_Desc_0 = {
    Text = "誕妄·墨菲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：誕妄·墨菲造成的傷害附加 [Arg2]％ <SacrificeKeyWord:獻祭>。回合開始時，獲得 1 層<MingqiKeywords:命契>。"
  },
  Skill_119766_Desc_15 = {
    Text = "誕妄·墨菲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：誕妄·墨菲造成的傷害附加 [Arg2]％ <SacrificeKeyWord:獻祭>。獲得 2 層<MingqiKeywords:命契>。回合開始時，獲得 1 層<MingqiKeywords:命契>。回合結束時，若處於「潮湧」姿態，額外獲得 1 層<MingqiKeywords:命契>。"
  },
  Skill_119766_EffectNameList = {
    Text = "狂氣,獻祭比例"
  },
  Skill_119766_Name = {
    Text = "海祭典儀"
  },
  Skill_119767_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_119767_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 1 張「深海聖詠」，每回合最多生效 1 次( [Arg3]/1 )。"
  },
  Skill_119767_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。誕妄·墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_119767_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。誕妄·墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 1 張「深海聖詠」，每回合最多生效 1 次。"
  },
  Skill_119767_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_119767_Name = {Text = "防禦"},
  Skill_119767_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_119835_Desc = {
    Text = "從棄牌堆中選擇 1 張指令卡移回手中。若「拉蒙娜」在隊伍中，使其本回合打出的下一張指令卡生效 [Arg1] 次。"
  },
  Skill_119835_Name = {
    Text = "重逢心願"
  },
  Skill_119845_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：視為本回合內上次打出的「技能」，算力消耗 -[Arg1]。此卡牌在戰鬥開始後置於第二個抽牌堆的頂部。"
  },
  Skill_119845_Name_1 = {
    Text = "重逢心願"
  },
  Skill_119845_UnknownName = {
    Text = "重逢心願"
  },
  Skill_120314_Desc = {
    Text = "獲得 1 點算力，對所有敵人施加 5 層<DwmofeiKeywords:降生儀式>。若「誕妄·墨菲」在隊伍中，抽 1 張「螺湮圓舞」。"
  },
  Skill_120896_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。全體友方獲得 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_121138_Desc = {
    Text = "切換到該意圖時生成 1 倍的臨時觸腕，<TentacleInjurieIconKeywords:觸腕傷害>臨時降低 50%。全體友方獲得 <Block:[Block:Arg1]> 點護盾並免疫 1 回合負面狀態。"
  },
  Skill_121138_Name = {
    Text = "遺失的久遠之城"
  },
  Skill_121342_Desc = {
    Text = "對前排怪物造成99999999傷害"
  },
  Skill_121342_Name = {
    Text = "秒殺前排怪物"
  },
  Skill_121354_Desc = {
    Text = "對全體怪物造成99999999傷害"
  },
  Skill_121354_Name = {
    Text = "秒殺全體怪物"
  },
  Skill_121360_Desc = {
    Text = "添加移除無敵"
  },
  Skill_121360_Name = {
    Text = "添加移除無敵"
  },
  Skill_121361_Desc = {
    Text = "添加無敵"
  },
  Skill_121361_Name = {
    Text = "添加無敵"
  },
  Skill_121800_Desc = {
    Text = "將敵人的觸腕傷害臨時降低 80%，獲得等量的臨時<PowerIconKeywords:力量>。"
  },
  Skill_121800_Name = {
    Text = "顛覆天穹"
  },
  Skill_121801_Desc = {
    Text = "選擇 1 名喚醒體獲得 50 點狂氣，重複 3 次。"
  },
  Skill_121802_Desc = {
    Text = "立刻回復 25% 最大生命，獲得最大生命 500% 的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_121802_Name = {
    Text = "崇拜與鼓舞"
  },
  Skill_121803_Desc = {
    Text = "抽 5 張牌。清除所有手牌的<SlowIconKeywords:遲緩>。"
  },
  Skill_121803_Name = {
    Text = "神選的輝光"
  },
  Skill_122118_Desc = {
    Text = "抽 1 張牌，並將<DerivativeCardKeywords_128:「倒數時刻: 0」>洗入棄牌堆。"
  },
  Skill_122118_Name = {
    Text = "倒數時刻： 1"
  },
  Skill_122119_Desc = {
    Text = "抽 3 張牌，獲得 3 點算力，並有 [Arg1]% 的機會將<DerivativeCardKeywords_123:「倒數時刻: 5」>洗入棄牌堆。"
  },
  Skill_122119_Name = {
    Text = "倒數時刻： 0"
  },
  Skill_122120_Desc = {
    Text = "抽 1 張牌，並將<DerivativeCardKeywords_125:「倒數時刻: 3」>洗入棄牌堆。"
  },
  Skill_122120_Name = {
    Text = "倒數時刻： 4"
  },
  Skill_122121_Desc = {
    Text = "抽 1 張牌，並將<DerivativeCardKeywords_124:「倒數時刻: 4」>洗入棄牌堆。"
  },
  Skill_122121_Name = {
    Text = "倒數時刻： 5"
  },
  Skill_122122_Desc = {
    Text = "抽 1 張牌，並將<DerivativeCardKeywords_126:「倒數時刻: 2」>洗入棄牌堆。"
  },
  Skill_122122_Name = {
    Text = "倒數時刻： 3"
  },
  Skill_122123_Desc = {
    Text = "抽 1 張牌，並將<DerivativeCardKeywords_127:「倒數時刻: 1」>洗入棄牌堆。"
  },
  Skill_122123_Name = {
    Text = "倒數時刻： 2"
  },
  Skill_122413_Desc = {
    Text = "茉夏之後造成未被格擋的傷害時、獲得 2 層<Monster_Fervor:臨時狂熱>。獲得 80 層<ReinforcePVEKeywords:加固>、敵方回合開始時移除。"
  },
  Skill_122413_Name = {
    Text = "霧境遺脈"
  },
  Skill_122414_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，敵人每擁有 <Block:[Block:Arg3]> 點護盾，使造成的傷害提高 1 點。獲得 [Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_122414_Name = {
    Text = "人間爆破"
  },
  Skill_122415_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_122415_Name = {
    Text = "閃耀龍捲風"
  },
  Skill_122416_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_122416_Name = {
    Text = "閃耀龍捲風"
  },
  Skill_122417_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每有 1 次傷害被格擋則獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_122417_Name = {
    Text = "風暴衝擊"
  },
  Skill_122432_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 <Block:[Block:Arg1]> 護盾和 <Energy:[Energy:Arg1]> 狂氣。回合結束時該命輪自動解除裝備，並使下次裝備「盒中童趣」時獲得的狂氣和護盾提高 [Arg2]。"
  },
  Skill_122433_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 3 層<PVPReciprocalKeywords:倒數時刻>。"
  },
  Skill_122433_Name_1 = {
    Text = "倒數時刻"
  },
  Skill_122483_AwakerSkillBackgroundStory = {
    Text = "戰鬥，如生命的最後一次。\n為了回到那充滿迷霧的，屬於「自己」的世界。"
  },
  Skill_122483_Desc_0 = {
    Text = "視為「打擊」。對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，"
  },
  Skill_122483_Desc_2 = {
    Text = "視為「打擊」。對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，生成 1 張上一次打出的其他「打擊」的臨時複製並使其算力消耗 -1。"
  },
  Skill_122483_EffectNameList = {Text = "傷害"},
  Skill_122483_Name = {
    Text = "人間爆破"
  },
  Skill_122483_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_122484_AwakerSkillBackgroundStory = {
    Text = "所有人都會死亡，她也是——她不抗拒死亡，也不拒絕死亡。\n但很抱歉，她的死期不能是今天，也不能是此刻。\n她還沒有玩盡興呢！"
  },
  Skill_122484_Desc = {
    Text = "視為「打擊」。對隨機敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_122484_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_122484_Name = {
    Text = "風暴衝擊"
  },
  Skill_122484_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_122485_AwakerSkillBackgroundStory = {
    Text = "不要忘記過去，不要忘記霧境調查團。\n忘記，代表著背叛。\n而她，茉夏，絕不背叛。"
  },
  Skill_122485_Desc_0 = {
    Text = "茉夏獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「戲劇性邂逅」傷害次數 +2。每次觸發「戲劇性邂逅」使茉夏「打擊」臨時最終傷害 +25%。立即生成 1 張臨時「人間爆破」。"
  },
  Skill_122485_Desc_15 = {
    Text = "茉夏獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「戲劇性邂逅」傷害次數 +2。每回合觸發次數上限提高為 5。每次觸發「戲劇性邂逅」使茉夏「打擊」臨時最終傷害 +25%。立即生成 2 張算力消耗為 0 的臨時「人間爆破」。"
  },
  Skill_122485_EffectNameList = {Text = "狂氣"},
  Skill_122485_Name = {
    Text = "霧境遺脈"
  },
  Skill_122486_AwakerSkillBackgroundStory = {
    Text = "「到異世界也要喊那個嗎？」\n「行吧，那你聽好了——」\n「來了！男女老少都愛看的！閃耀☆龍捲風——！！」"
  },
  Skill_122486_BattleDesc_0 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。本回合所有喚醒體「打擊」傷害提高 [Arg3] 點。"
  },
  Skill_122486_BattleDesc_3 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。本回合茉夏造成的傷害次數 +1，所有喚醒體「打擊」傷害提高 [Arg3] 點。"
  },
  Skill_122486_Desc_0 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害。本回合所有喚醒體「打擊」傷害提高 [Arg3] 點。"
  },
  Skill_122486_Desc_3 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害。本回合茉夏造成的傷害次數 +1，所有喚醒體「打擊」傷害提高 [Arg3] 點。"
  },
  Skill_122486_EffectNameList = {
    Text = "傷害,打擊傷害增幅"
  },
  Skill_122486_Name = {
    Text = "閃耀☆龍捲風"
  },
  Skill_122486_OverLimitUtlSkillDesc_0 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg4] 次。所有喚醒體「打擊」傷害提升 [Arg3] 點。使打出的下一張「風暴衝擊」基礎算力消耗變為 0。若為本場戰鬥首次釋放，額外<HunmiKeywords:昏迷>所有敵方。"
  },
  Skill_122486_OverLimitUtlSkillDesc_3 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg4] 次。本回合茉夏造成的傷害次數 +1，所有喚醒體「打擊」傷害提升 [Arg3] 點。使打出的下一張「風暴衝擊」基礎算力消耗變為 0。若為本場戰鬥首次釋放，額外<HunmiKeywords:昏迷>所有敵方。"
  },
  Skill_122486_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_122487_AwakerSkillBackgroundStory = {
    Text = "「還敢反抗？我要生氣了哦——乖乖等死吧你！」"
  },
  Skill_122487_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_122487_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。茉夏獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_122487_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_122487_Name = {Text = "防禦"},
  Skill_122487_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_122488_AwakerSkillBackgroundStory = {
    Text = "「哈哈哈哈，這樣才對嘛，事情變得有意思起來了！」\n「謝謝你們陪我玩，我真是太開心了……」"
  },
  Skill_122488_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_122488_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。茉夏獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_122488_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_122488_Name = {Text = "打擊"},
  Skill_122488_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_122656_Desc_1 = {
    Text = "請一名敵方喚醒體離場，我方喚醒體平攤其最大生命、生命、護盾、狂氣。"
  },
  Skill_122656_Name_1 = {
    Text = "茜爾維婭的紅茶"
  },
  Skill_122836_Desc = {
    Text = "生命設定為500生命"
  },
  Skill_122836_Name = {
    Text = "生命設定為500生命"
  },
  Skill_123159_Desc_0 = {
    Text = "對隨機敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。"
  },
  Skill_123159_Name = {
    Text = "戲劇性邂逅"
  },
  Skill_123270_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機<BurningKeywords:燃燒> [Arg3] 張抽牌堆或棄牌堆的卡牌，造成 [Arg4] 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_123509_Desc = {
    Text = "抽 2 張「打擊」。若「茉夏」在隊伍中，使它們算力消耗 -1。"
  },
  Skill_123509_Name = {
    Text = "來自霧境"
  },
  Skill_124013_Desc_1 = {
    Text = "生成按公式添加狀態測試卡"
  },
  Skill_124013_Name_1 = {
    Text = "生成測試卡"
  },
  Skill_124014_Desc_1 = {
    Text = "按公式添加狀態僅目標"
  },
  Skill_124014_Name_1 = {Text = "僅目標"},
  Skill_124015_Desc_1 = {
    Text = "按公式添加狀態僅自身"
  },
  Skill_124015_Name_1 = {Text = "僅自身"},
  Skill_124025_Desc_1 = {
    Text = "按公式添加狀態雙方"
  },
  Skill_124025_Name_1 = {Text = "雙方"},
  Skill_124069_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每造成 [Arg3] 次未被格擋的傷害對抽牌堆頂指令卡施加 [Arg4] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_124069_Name = {Text = "打擊"},
  Skill_124070_Desc = {
    Text = "驅散所有負面狀態，對方回合結束不會丟棄手牌。回合結束時依次施加 [Arg1] 層<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虛弱>、<HeavyInjuryKeywords:重創>、<VulnerabilityIconKeywords:易傷>狀態。"
  },
  Skill_124071_Desc = {
    Text = "全體友方獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_124071_Name = {
    Text = "綿音漸響"
  },
  Skill_124072_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，對手牌中隨機 [Arg2] 張指令卡和抽牌堆隨機 [Arg2] 張指令卡施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_124072_Name = {
    Text = "星彩極光"
  },
  Skill_124073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使全體友方獲得 [Arg3] 點<PowerIconKeywords:力量>。若自身或其他友方存在<WeaknessIconKeywords:虛弱>或<VulnerabilityIconKeywords:易傷>狀態，將其轉移給敵方。"
  },
  Skill_124074_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，敵方手牌中每有 [Arg2] 張<SlowIconKeywords:遲緩>卡牌，獲得 [Arg3] 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  Skill_124074_Name = {
    Text = "綿音漸響"
  },
  Skill_124075_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_124075_Name = {Text = "打擊"},
  Skill_124076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3]% 未被格擋傷害的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_124076_Name = {Text = "打擊"},
  Skill_124077_Desc = {
    Text = "全體友方回復已損失生命的 [Arg1]% 。"
  },
  Skill_124078_Desc = {
    Text = "回復已損失生命的 [Arg1]% ，獲得 [Arg2] 層<ReinforcePVEKeywords:加固>。"
  },
  Skill_124079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。若自身存在<WeaknessIconKeywords:虛弱>或<VulnerabilityIconKeywords:易傷>狀態，將其轉移給敵方。"
  },
  Skill_124080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3]% 未被格擋傷害的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_124080_Name = {Text = "打擊"},
  Skill_124081_Desc = {
    Text = "獲取 [Arg1] <RetaliateIconKeywords:反擊>， <Block:[Block:Arg2]> 點護盾，前進。"
  },
  Skill_124081_Name = {
    Text = "星之搖籃"
  },
  Skill_124082_Desc = {
    Text = "獲得 [Arg1] 層<Guaiwusiwangdikang:死亡抵抗>，<Guaiwusiwangdikang:死亡抵抗>回復生命提高為 [Arg2]%。敵方每打出 [Arg3] 張指令卡，臨時偷取 [Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_124082_Name = {
    Text = "無邊星彩"
  },
  Skill_124083_Desc = {
    Text = "獲取 [Arg1] <RetaliateIconKeywords:反擊>， <Block:[Block:Arg2]> 點護盾，[Arg3] 層<Guaiwusiwangdikang:死亡抵抗>。"
  },
  Skill_124083_Name = {
    Text = "星之搖籃"
  },
  Skill_124084_Desc = {
    Text = "最大生命 +[Arg1]%，偷取 [Arg2]% <PowerIconKeywords:力量>。敵方生命上限 -[Arg3]%。"
  },
  Skill_124084_Name = {
    Text = "養分汲取"
  },
  Skill_124085_Desc = {
    Text = "最大生命 +[Arg1]%，偷取 [Arg2]% 力量。若本回合未失去生命，敵方生命上限 -[Arg3]%。"
  },
  Skill_124085_Name = {
    Text = "養分汲取"
  },
  Skill_124086_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，對手牌中隨機 [Arg2] 張指令卡和抽牌堆隨機 [Arg2] 張指令卡施加 [Arg3] 層<SlowIconKeywords:遲緩>。後退。"
  },
  Skill_124086_Name = {
    Text = "星彩極光"
  },
  Skill_124182_Name = {
    Text = "養分汲取"
  },
  Skill_124205_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，敵人每擁有 <Block:[Block:Arg3]> 點護盾，使造成的傷害提高 1 點。獲得 [Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_124205_Name = {
    Text = "人間爆破"
  },
  Skill_124218_Desc_1 = {
    Text = "隨機獲取存活喚醒體"
  },
  Skill_124218_Name_1 = {
    Text = "隨機獲取存活喚醒體"
  },
  Skill_124225_Desc_1 = {
    Text = "隨機獲取卡牌"
  },
  Skill_124225_Name_1 = {
    Text = "隨機獲取卡牌"
  },
  Skill_124420_Desc = {
    Text = "茉夏之後造成未被格擋的傷害時、獲得 2 層<Monster_Fervor:臨時狂熱>。"
  },
  Skill_124420_Name = {
    Text = "霧境遺脈"
  },
  Skill_124422_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每有 1 次傷害被格擋則獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_124422_Name = {
    Text = "風暴衝擊"
  },
  Skill_124423_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_124423_Name = {
    Text = "閃耀龍捲風"
  },
  Skill_124424_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_124424_Name = {
    Text = "閃耀龍捲風"
  },
  Skill_124740_Desc = {
    Text = "四個喚醒體輪流打出大招。對黑名單監聽保持靜默。"
  },
  Skill_124740_Name = {
    Text = "追擊測試"
  },
  Skill_124742_Desc = {
    Text = "四個喚醒體輪流打出打擊。對黑名單監聽保持靜默。"
  },
  Skill_124742_Name = {
    Text = "追擊測試"
  },
  Skill_124755_Desc = {
    Text = "玩家放出指名鑰令。對黑名單監聽保持靜默。"
  },
  Skill_124755_Name = {
    Text = "追擊測試"
  },
  Skill_124761_Desc = {
    Text = "玩家放出指名鑰令。觸發全部監聽。"
  },
  Skill_124761_Name = {
    Text = "追擊測試"
  },
  Skill_124762_Desc = {
    Text = "四個喚醒體輪流打出大招。觸發全部監聽。"
  },
  Skill_124762_Name = {
    Text = "追擊測試"
  },
  Skill_124763_Desc = {
    Text = "四個喚醒體輪流打出打擊。觸發全部監聽。"
  },
  Skill_124763_Name = {
    Text = "追擊測試"
  },
  Skill_124814_Desc = {
    Text = "四個喚醒體輪流打出防禦。觸發全部監聽。"
  },
  Skill_124814_Name = {
    Text = "追擊測試"
  },
  Skill_124815_Desc = {
    Text = "四個喚醒體輪流打出技能1。對黑名單監聽保持靜默。"
  },
  Skill_124815_Name = {
    Text = "追擊測試"
  },
  Skill_124816_Desc = {
    Text = "四個喚醒體輪流打出覺醒。觸發全部監聽。"
  },
  Skill_124816_Name = {
    Text = "追擊測試"
  },
  Skill_124817_Desc = {
    Text = "四個喚醒體輪流打出覺醒。對黑名單監聽保持靜默。"
  },
  Skill_124817_Name = {
    Text = "追擊測試"
  },
  Skill_124818_Desc = {
    Text = "四個喚醒體輪流打出技能1。觸發全部監聽。"
  },
  Skill_124818_Name = {
    Text = "追擊測試"
  },
  Skill_124819_Desc = {
    Text = "四個喚醒體輪流打出防禦。對黑名單監聽保持靜默。"
  },
  Skill_124819_Name = {
    Text = "追擊測試"
  },
  Skill_124820_Desc = {
    Text = "空藥水卡，獲得 [Block:Arg1] 點護盾。"
  },
  Skill_124820_Name = {
    Text = "追擊測試"
  },
  Skill_124821_Desc = {
    Text = "玩家打出指名卡牌。對黑名單監聽保持靜默。"
  },
  Skill_124821_Name = {
    Text = "追擊測試"
  },
  Skill_124822_Desc = {
    Text = "玩家打出指名卡牌。觸發全部監聽。"
  },
  Skill_124822_Name = {
    Text = "追擊測試"
  },
  Skill_124839_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，對手中隨機 [Arg2] 張卡牌和抽牌堆隨機 [Arg2] 張卡牌施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_124839_Name = {
    Text = "星彩極光"
  },
  Skill_124840_Desc = {
    Text = "獲取 [Arg1] <RetaliateIconKeywords:反擊>， <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_124840_Name = {
    Text = "星之搖籃"
  },
  Skill_124871_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：打出裝備者的技能卡後，抽 [Arg1] 張牌，優先抽取其他喚醒體的牌，每回合至多生效 1 次。"
  },
  Skill_124871_Name_1 = {
    Text = "宿命紡輪"
  },
  Skill_124872_Desc_1 = {
    Text = "選擇一名友方，使其下 1 張打出的「技能」生效 2 次。"
  },
  Skill_124872_Name_1 = {Text = "繁網"},
  Skill_124874_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身下 [Arg1] 張打出的「技能」生效 2 次。"
  },
  Skill_124874_Name_1 = {
    Text = "永世編織之網"
  },
  Skill_124875_Desc_1 = {
    Text = "抽 [Arg1] 張牌，獲得 [Arg1] 點算力。選擇任意喚醒體，直到自身下回合開始，其造成和受到的致命主動傷害改為施加等量<PVPDestinedDeathKeyWords:命定預兆>。"
  },
  Skill_124875_Name_1 = {
    Text = "命途，依此諭示"
  },
  Skill_124876_BattleDesc_1 = {
    Text = "隨機造成 [Arg3] 次 <Damage:[Damage:Arg2]> 傷害，<PVPDestinedDeathKeyWords:命定預兆>，將這張牌洗入抽牌堆，使所有「紡織」傷害次數 +1。"
  },
  Skill_124876_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，<PVPDestinedDeathKeyWords:命定預兆>，將這張牌洗入抽牌堆，使所有「紡織」傷害次數 +1。"
  },
  Skill_124876_Name_1 = {Text = "紡織"},
  Skill_124877_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_124877_Name_1 = {Text = "打擊"},
  Skill_124878_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：每次打出卡牌後變化為敵方手中的隨機「技能」，並使其算力消耗 -[Arg1]。"
  },
  Skill_124878_Name_1 = {Text = "預言"},
  Skill_124900_Desc_1 = {
    Text = "給予一名友方 +[Arg1] <StrongEffectKeywords:強效>。此卡牌洗入下個抽牌堆，並且下次打出 +[Arg2] <StrongEffectKeywords:強效>，"
  },
  Skill_124900_Name_1 = {
    Text = "羅網轉輪"
  },
  Skill_124900_UnknownName = {
    Text = "羅網轉輪"
  },
  Skill_125370_Desc_1 = {
    Text = "選擇一名友方，使其對其他友方和全體敵方施加 [Arg1] 層<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125371_AwakerSkillBackgroundStory = {
    Text = "祂們從不談及她的源起、只談及她降生時那無法名狀的巨大歡愉。\n你的意識將在狂喜中融化、你的過往將在狂喜中融化、你的顱骨將在狂喜中融化……你的腦漿將在狂喜中融化。\n一味入口軟嫩的點心——以「相思」作引。"
  },
  Skill_125371_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊傷害並觸發 [Arg2]％ 中毒。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]（ [Arg5]/3 ）。"
  },
  Skill_125371_BattleDesc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊傷害並觸發 [Arg2]％ 中毒，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]（ [Arg5]/3 ）。"
  },
  Skill_125371_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊傷害並觸發 [Arg2]％ 中毒。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]。"
  },
  Skill_125371_Desc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊傷害並觸發 [Arg2]％ 中毒，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]。"
  },
  Skill_125371_EffectNameList = {Text = "傷害"},
  Skill_125371_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_125372_Desc_1 = {
    Text = "對目標和<HPAndShieldMax:生命與護盾最高>敵方造成 <Damage:[Damage:Arg1]> 傷害並施加 1 層<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125372_Name_1 = {
    Text = "藕絲難殺"
  },
  Skill_125373_AwakerSkillBackgroundStory = {
    Text = "為何要引誘祂們？祂們本來就無力反抗。\n為何要唆使祂們？直到更高、更廣、權欲的漩渦將所有目及之處都圈進。\n因為僅困於情的庸人之髓難以下嚥。因為未經野心醃製的凡俗之軀索然無趣。\n不夢鄉是獵食者給獵物殘渣的恩賞。\n那歡愉的中心沒有任何事物、只有無盡的混亂、無盡的詭譎陸離。"
  },
  Skill_125373_Desc_0 = {
    Text = "徐獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：徐的每種指令卡每回合首次觸發<ResonanceKeywords:共鳴>效果時，使其基礎算力消耗變為 0。"
  },
  Skill_125373_Desc_15 = {
    Text = "徐獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：徐的每種指令卡每回合首次觸發<ResonanceKeywords:共鳴>效果時，使其基礎算力消耗變為 0。<WitherKeywords0:痴醉>的疊加上限提升為 15 層，徐每回合首次打出的指令卡額外生效 1 次。"
  },
  Skill_125373_EffectNameList = {Text = "狂氣"},
  Skill_125373_Name = {
    Text = "不夢鄉之主"
  },
  Skill_125374_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_125374_Name_1 = {Text = "打擊"},
  Skill_125375_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害、施加 1 層<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125376_AwakerSkillBackgroundStory = {
    Text = "古往今來、情之一字。\n無非使人身向孽海、不肯回頭。"
  },
  Skill_125376_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。】獲得 [Arg2] 點算力、對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。選擇：<WitherKeywords1:相許>或<WitherKeywords2:奪魄>。"
  },
  Skill_125376_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。】獲得 [Arg2] 點算力、對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。自身下次觸發的<ResonanceKeywords:共鳴>效果翻倍。選擇：<WitherKeywords1:相許>或<WitherKeywords2:奪魄>。"
  },
  Skill_125376_EffectNameList = {
    Text = "中毒、力量降低"
  },
  Skill_125376_Name = {
    Text = "夜霧下的情誓"
  },
  Skill_125376_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。】獲得 [Arg2] 點算力，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg4]，對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。選擇：<WitherKeywords3:相許>或<WitherKeywords4:奪魄>。"
  },
  Skill_125376_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。】獲得 [Arg2] 點算力，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg4]，對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。自身下次觸發的<ResonanceKeywords:共振>效果翻倍。選擇：<WitherKeywords3:相許>或<WitherKeywords4:奪魄>。"
  },
  Skill_125376_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_125377_Desc_1 = {
    Text = "<PVPSneakKeywords:潛行>，獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_125377_Name_1 = {
    Text = "繾綣夜霧"
  },
  Skill_125378_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對<HPAndShieldMax:生命與護盾最高>的敵方施加 [Arg1] 層<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125378_Name_1 = {
    Text = "玉蘭之餌"
  },
  Skill_125379_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方「狂氣爆發」後，使手牌中裝備者的所有「技能」算力消耗 –1。"
  },
  Skill_125380_AwakerSkillBackgroundStory = {
    Text = "她的扇下有一個吻、她的扇下有無數個吻。\n豐沛的、多汁的、柔軟的……包裹、消融、沉寂。"
  },
  Skill_125380_BattleDesc = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並使其臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共鳴3>：對所有敵人施加 1 層<WitherKeywords:痴醉>( [Arg3]/3 )。"
  },
  Skill_125380_Desc_0 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並使其臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共鳴3>：對所有敵人施加 1 層<WitherKeywords:痴醉>。"
  },
  Skill_125380_Desc_3 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並使其臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共鳴3>：對所有敵人施加 1 層<WitherKeywords0:痴醉>。"
  },
  Skill_125380_EffectNameList_0 = {
    Text = "中毒、力量降低"
  },
  Skill_125380_Name = {
    Text = "寄吻於扇"
  },
  Skill_125380_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_125381_AwakerSkillBackgroundStory = {
    Text = "「古古怪、怪怪古、亡妻三更爬出土、浪子負心鍋裡煮。」"
  },
  Skill_125381_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_125381_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<ResonanceKeywords:共鳴3>：額外獲得 <Energy:[Energy:Arg3]> 點狂氣( [Arg4]/3 )。"
  },
  Skill_125381_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。徐獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_125381_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。徐獲得 <Energy:[Energy:Arg2]> 點狂氣。<ResonanceKeywords:共鳴3>：額外獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_125381_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_125381_Name = {Text = "打擊"},
  Skill_125381_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_125382_Desc_1 = {
    Text = "移除目標所有<PVPLostSoulKeyWords:癡醉>並造成 <Damage:[Damage:Arg1]> 傷害。每移除 1 層對隨機敵方造成 1 次 <Damage:[Damage:Arg2]> 傷害並<StrongEffectKeywords:強效> +[Arg3]。"
  },
  Skill_125382_Name_1 = {
    Text = "夜霧下的情誓"
  },
  Skill_125383_AwakerSkillBackgroundStory = {
    Text = "「無相的神女願救苦、割面剖懷取郎骨、獻我堂前無上主。」"
  },
  Skill_125383_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_125383_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<ResonanceKeywords:共鳴3>：額外獲得 <Energy:[Energy:Arg3]> 點狂氣( [Arg4]/3 )。"
  },
  Skill_125383_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。徐獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_125383_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。徐獲得 <Energy:[Energy:Arg2]> 點狂氣。<ResonanceKeywords:共鳴3>：額外獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_125383_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_125383_Name = {Text = "防禦"},
  Skill_125383_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_125903_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，[Arg2] 點<PowerIconKeywords:力量>。 從抽牌堆和棄牌堆中發現 [Arg3] 張指令卡，選擇 [Arg4] 張指令卡將其<DepleteIconKeywords:消耗>。"
  },
  Skill_125903_Name = {
    Text = "萬物歸一"
  },
  Skill_125904_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords: 脆弱>、<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_125904_Name = {
    Text = "六翼滿開"
  },
  Skill_125905_Desc = {
    Text = "回合結束若在手中，使所有喚醒體失去 3 點狂氣。棄置後將其<DepleteIconKeywords:消耗>。"
  },
  Skill_125906_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords: 脆弱>。 打出 [Arg4] 張指令卡後，將意圖變化為造成 <Damage:[Damage:Arg5]> 點傷害 [AttackTimes:Arg6] 次，施加 [Arg7] 層<FragileIconKeywords: 脆弱>和<WeaknessIconKeywords:虛弱>的「四翼漸生」。"
  },
  Skill_125906_Name = {
    Text = "雙翼初張"
  },
  Skill_125907_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。 <Seal:封印>下個打出指令卡牌的喚醒體 [Arg2] 回合。"
  },
  Skill_125907_Name = {
    Text = "縱貫時序之翼"
  },
  Skill_125908_Desc = {
    Text = "敵方消耗算力時，獲得的銀鑰能量降低 [Arg1]%。 塔薇造成未被格擋的傷害後，將 [Arg2] 張「<DerivativeCardKeywords_131:真·輪迴悖論>」置入手中。"
  },
  Skill_125908_Name = {
    Text = "穿越銀鑰之門"
  },
  Skill_125909_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords: 脆弱>和<WeaknessIconKeywords:虛弱>。 打出 [Arg4] 張指令卡後，將意圖變化為造成 <Damage:[Damage:Arg5]> 點傷害 [AttackTimes:Arg6] 次，施加 [Arg7] 層<FragileIconKeywords: 脆弱>、<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>的「六翼滿開」。"
  },
  Skill_125909_Name = {
    Text = "四翼漸生"
  },
  Skill_126008_Desc = {
    Text = "選擇一名喚醒體獲得 30 狂氣，其他喚醒體失去 10 狂氣。此卡回合結束若在手中，對我方造成傷害。"
  },
  Skill_126008_Name = {
    Text = "真·輪回悖論"
  },
  Skill_126350_Desc_1 = {
    Text = "使一名目標獲得 <PVPSneakKeywords:潛行>。"
  },
  Skill_126350_Name_1 = {Text = "潛行"},
  Skill_126446_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害（[Arg4]）點<IntoxicationIconKeywords:中毒>。 對 [Arg5] 張手牌施加<BurningKeywords:燃燒>。"
  },
  Skill_126446_Name = {
    Text = "腐化綠炎"
  },
  Skill_126447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害（[Arg4]）點<IntoxicationIconKeywords:中毒>。 對 [Arg5] 張手牌施加<BurningKeywords:燃燒>。"
  },
  Skill_126447_Name = {
    Text = "死滅綠炎"
  },
  Skill_126448_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害（[Arg4]）點<IntoxicationIconKeywords:中毒>。 對 [Arg5] 張手牌施加<BurningKeywords:燃燒>。"
  },
  Skill_126448_Name = {Text = "綠炎"},
  Skill_126449_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 層<MonsterLizVerdantSpark:翠綠火種>。 切換到該意圖時，本回合每受到 [Arg3] 次「攻擊」獲得 [Arg4] 層<MonsterLizVerdantSpark:翠綠火種>。"
  },
  Skill_126449_Name = {
    Text = "誘蛾之火"
  },
  Skill_126450_Desc = {
    Text = "獲得 [Arg1] 層<MonsterLizVerdantSpark:翠綠火種>，每失去 [Arg2]% 生命獲得 [Arg3] 層<MonsterLizVerdantSpark:翠綠火種>。 獲得<ExhaustionCounter:以牙還牙>。"
  },
  Skill_126450_Name = {
    Text = "翡翠映射"
  },
  Skill_126451_Desc = {
    Text = "切換至該意圖時解除負面狀態。獲得 [Arg1] 點<PowerIconKeywords:力量>，棄掉所有手牌。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。每棄掉 1 張手牌，額外造成 1 次傷害，獲得 1 層<MonsterLizVerdantSpark:翠綠火種>。"
  },
  Skill_126452_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，棄掉所有手牌。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。每棄掉 [Arg4] 張手牌，額外造成 [Arg5] 次傷害，獲得 [Arg6] 層<MonsterLizVerdantSpark:翠綠火種>。"
  },
  Skill_126484_AwakerSkillBackgroundStory = {
    Text = "在第一縷絲線垂下時，命運便已宣告了它的判決。"
  },
  Skill_126484_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126484_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。阿拉克涅獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126484_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_126484_Name = {Text = "打擊"},
  Skill_126484_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_126484_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126484_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。若為本回合首次打出，釋放 1 次「無盡線縷」追擊( [Arg3]/1 )。"
  },
  Skill_126485_AwakerSkillBackgroundStory = {
    Text = "命運亦會為木偶的魯莽讓步。\n如果，它們願意承受那注定的代價。"
  },
  Skill_126485_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126485_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。阿拉克涅獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126485_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_126485_Name = {Text = "防禦"},
  Skill_126485_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_126485_tempBattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_126485_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。若為本回合首次打出，釋放 1 次「無盡線縷」追擊(  [Arg3]/1 )。"
  },
  Skill_126486_AwakerSkillBackgroundStory = {
    Text = "她以命運之名，於此宣告——\n一切錯誤的命數，將湮於時光的塵土。世界的命運，將歸於命定之軌。\n錯亂的絲線，於此裁斷。那被遺棄的不幸者，將於此安息。"
  },
  Skill_126486_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，臨時傷害強效 +[Arg2]％，移除所有手牌的<SlowIconKeywords:遲緩>狀態。"
  },
  Skill_126486_EffectNameList = {
    Text = "護盾,傷害強效,無盡線縷命運裁斷"
  },
  Skill_126486_Name = {
    Text = "命途，依此諭示"
  },
  Skill_126486_OverLimitUtlSkillDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，臨時傷害強效 +[Arg2]％，移除所有手牌的<SlowIconKeywords:遲緩>狀態。生成手中和超維空間最多 5 張具有<SingularityKeywords1:奇點信標>卡牌的臨時原始複製，將其隨機置入抽牌堆和棄牌堆並使其算力消耗變為 0。"
  },
  Skill_126486_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2％,攻擊力*GrowValue3"
  },
  Skill_126488_BattleDesc_0 = {
    Text = "失去 [Float:Arg3]％ 最大生命( [Arg4] )，獲得 1 層<SilkKeywords:織命>。本場戰鬥「<DerivativeCardKeywords_138:牽絲引命>」失去的生命和阿拉克涅造成的<CutKeywords:命運裁斷>提高 [Arg2]％。虛無：阿拉克涅隨機獲得 15~30 點狂氣。"
  },
  Skill_126488_Desc_0 = {
    Text = "失去 [Arg1]％ 最大生命，獲得 1 層<SilkKeywords:織命>。本場戰鬥「<DerivativeCardKeywords_138:牽絲引命>」失去的生命和阿拉克涅造成的<CutKeywords:命運裁斷>提高 [Arg2]％。虛無：阿拉克涅隨機獲得 15~30 點狂氣。"
  },
  Skill_126488_Name = {
    Text = "牽絲引命"
  },
  Skill_126490_AwakerSkillBackgroundStory = {
    Text = "帷幕升起的那一刻，木偶們仰起頭顱，看見了紡輪後那張溫柔的臉。\n絲線繃緊，在木偶們的歡歌與舞蹈中，她如母親般微笑。\n命運的戲場裡，她是它們唯一的觀眾。"
  },
  Skill_126490_BattleDesc_0 = {
    Text = "阿拉克涅獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「湮滅」改為選擇 1 張超維空間的指令卡取出，賦予「下次打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。"
  },
  Skill_126490_BattleDesc_15 = {
    Text = "阿拉克涅獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「湮滅」改為選擇 1 張超維空間的指令卡取出，賦予「下次打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。釋放「湮滅」後立刻對所有敵人造成等同於 50％「命運裁斷」的<FixedDamage:純粹傷害>，下次狂氣爆發造成的傷害強效和護盾提高 50％。"
  },
  Skill_126490_Desc_0 = {
    Text = "阿拉克涅獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：「湮滅」改為選擇 1 張超維空間的指令卡取出，賦予「下次打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。"
  },
  Skill_126490_Desc_15 = {
    Text = "阿拉克涅獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：「湮滅」改為選擇 1 張超維空間的指令卡取出，賦予「下次打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。釋放「湮滅」後立刻對所有敵人造成等同於 50％「命運裁斷」的<FixedDamage:純粹傷害>，下次狂氣爆發造成的傷害強效和護盾提高 50％。"
  },
  Skill_126490_EffectNameList = {Text = "狂氣"},
  Skill_126490_Name = {
    Text = "木偶戲場揭幕"
  },
  Skill_126656_Desc = {
    Text = "令站位為1的喚醒體追加後置行動，打出其打擊卡。"
  },
  Skill_126656_Name = {
    Text = "追擊測試"
  },
  Skill_126657_Desc = {
    Text = "令前排敵方追加後置行動，打出其當前意圖。"
  },
  Skill_126657_Name = {
    Text = "追擊測試"
  },
  Skill_126658_Desc = {
    Text = "令守密人追加後置行動，打出 技能@主角技能@腦中之音。"
  },
  Skill_126658_Name = {
    Text = "追擊測試"
  },
  Skill_126767_BattleDesc = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords:痴醉>。"
  },
  Skill_126767_Desc_0 = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords:痴醉>。"
  },
  Skill_126767_Desc_3 = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords0:痴醉>。"
  },
  Skill_126767_Name = {Text = "相許"},
  Skill_126768_BattleDesc = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>並觸發其 [Arg2]％ 中毒。"
  },
  Skill_126768_Desc_0 = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>並觸發其 [Arg2]％ 中毒。"
  },
  Skill_126768_Desc_3 = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>並觸發其 [Arg2]％ 中毒。"
  },
  Skill_126768_Name = {Text = "奪魄"},
  Skill_126793_Desc = {
    Text = "獲得 1 點算力並臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。若「徐」在隊伍中、對所有敵人施加 1 層<WitherKeywords:痴醉>。"
  },
  Skill_126880_BattleDesc = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords:痴醉>、施加的中毒量提高 200％。"
  },
  Skill_126880_Desc_0 = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords:痴醉>、施加的中毒量提高 200％。"
  },
  Skill_126880_Desc_3 = {
    Text = "對所有敵人施加 [Arg1] 層<WitherKeywords0:痴醉>、施加的中毒量提高 200％。"
  },
  Skill_126880_Name = {Text = "相許"},
  Skill_126881_BattleDesc = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層積攢 [Arg3] 點猩紅熔爐、造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>、觸發其 [Arg2]％ 中毒。"
  },
  Skill_126881_Desc_0 = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層積攢 [Arg3] 點猩紅熔爐、造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>、觸發其 [Arg2]％ 中毒。"
  },
  Skill_126881_Desc_3 = {
    Text = "移除所有敵人的<WitherKeywords:痴醉>，每移除 1 層積攢 [Arg3] 點猩紅熔爐、造成 [Arg1]％ 目標最大生命值的<FixedDamage:純粹傷害>、觸發其 [Arg2]％ 中毒。"
  },
  Skill_126881_Name = {Text = "奪魄"},
  Skill_127246_Desc = {
    Text = "獲得 [Arg1] 層<MonsterTimeBeacon:回環>。之後每個回合結束時、獲得 [Arg2] 層<MonsterTimeBeacon:回環>。"
  },
  Skill_127246_Name = {
    Text = "熵增逆轉"
  },
  Skill_127247_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、額外受到 [Arg3] 倍<PowerIconKeywords:力量>和<ExhaustionIconKeywords:力量降低>影響、使用後提高 [Arg4] 倍。 <MonsterTimeBeacon:回環>：造成 [Arg5] 倍傷害"
  },
  Skill_127247_Name = {
    Text = "命定之劍"
  },
  Skill_127248_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。 將 [Arg2] 張抽牌堆或棄牌堆的牌置入手中並永久施加<MonsterSightUnbound:超越之目>和<RetainIconKeywords:保留>。<MonsterTimeBeacon:回環>：額外獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_127249_Desc = {
    Text = "在敵人回合開始時將其上回合最後打出的 [Arg1] 張指令卡置入手中、施加<NothingnessIconKeywords:虛無>。若可置入手中的指令卡不足、則抽等量牌代替。獲得 [Arg2] 層<MonsterTimeBeacon:回環>。"
  },
  Skill_127249_Name = {
    Text = "悖論收束"
  },
  Skill_127250_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、施加 [Arg3] 層<BlindingKeywords: 致盲>。 <MonsterTimeBeacon:回環>：額外造成 [Arg4] 次傷害和 [Arg5] 層<BlindingKeywords: 致盲>。"
  },
  Skill_127250_Name = {Text = "打擊"},
  Skill_127251_Desc = {
    Text = "在敵人回合開始時將其上回合最後打出的 [Arg1] 張指令卡置入手中、施加<NothingnessIconKeywords:虛無>、<DepleteIconKeywords:消耗>。若可置入手中的指令卡不足、則抽等量牌代替。獲得 [Arg2] 層<MonsterTimeBeacon:回環>。"
  },
  Skill_127251_Name = {
    Text = "悖論收束"
  },
  Skill_127252_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。 將 [Arg2] 張抽牌堆或棄牌堆的牌置入手中並永久施加<MonsterSightUnbound:超越之目>、<RetainIconKeywords:保留>和<SlowIconKeywords:遲緩>。<MonsterTimeBeacon:回環>：額外獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_127698_Desc = {
    Text = "施加 [Arg1] 層 <FragileIconKeywords: 脆弱>、為 [Arg2] 張卡牌附加 [Arg3] 層<BrokenCard:暗中破壞>。"
  },
  Skill_127699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、將 [Arg3] 張隨機症狀洗入對方抽牌堆。"
  },
  Skill_127700_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、施加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_128020_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>、為 [Arg2] 張卡牌附加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_128020_Name = {
    Text = "暗影纏絲"
  },
  Skill_128021_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、將 [Arg3] 張隨機喚醒體附帶<DepleteIconKeywords:消耗>的「打擊」洗入對方抽牌堆。"
  },
  Skill_128021_Name = {
    Text = "幻毒侵蝕"
  },
  Skill_128048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、每造成 1 次未被格擋的傷害就使目標失去 [Arg3] <PowerIconKeywords:力量>。"
  },
  Skill_128049_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>、封印 [Arg2] 張手中或抽牌堆頂的指令卡 [Arg3] 回合。"
  },
  Skill_128049_Name = {
    Text = "束縛之網"
  },
  Skill_128052_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，封印 [Arg2] 張手中或抽牌堆頂的指令卡 [Arg3] 回合。移動至前排，並在後方召喚 [Arg4] 名冷蛛群。"
  },
  Skill_128052_Name = {
    Text = "束縛之網"
  },
  Skill_128053_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>、封印 [Arg2] 張手中或抽牌堆頂的指令卡 [Arg3] 回合。移至前排、並在後方召喚 [Arg4] 名小型冷蛛白群。"
  },
  Skill_128053_Name = {
    Text = "束縛之網"
  },
  Skill_128207_Desc = {
    Text = "每次行動結束後都會獲得 [Arg1] 層<ParcloseIconKeywords:屏障>和 [Arg2] 層<Chapter5_Monster_Fervor1:臨時狂熱>。"
  },
  Skill_128207_Name = {
    Text = "織母的搖籃"
  },
  Skill_128227_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、每造成 1 次未被格擋的傷害就使目標棄置 [Arg3] 張指令卡。"
  },
  Skill_128227_Name = {Text = "壞滅"},
  Skill_128229_Desc = {
    Text = "施加 [Arg1] 層<FragileIconKeywords: 脆弱>，並為 [Arg2] 張手中或抽牌堆頂的指令卡附加 [Arg3] 層<BrokenCard:暗中破壞>。移動至前排，並在後方召喚 [Arg4] 名淵獄蛛群。"
  },
  Skill_128229_Name = {
    Text = "崩解之絲"
  },
  Skill_128230_Desc = {
    Text = "施加 [Arg1] 層<FragileIconKeywords: 脆弱>、並為 [Arg2] 張手中或抽牌堆頂的指令卡附加 [Arg3] 層<BrokenCard:暗中破壞>。移動至前排、並在後方召喚 [Arg4] 名小型冷蛛黑群。"
  },
  Skill_128230_Name = {
    Text = "崩解之絲"
  },
  Skill_128233_Desc = {
    Text = "施加 [Arg1] 層<FragileIconKeywords: 脆弱>、並為 [Arg2] 張手中或抽牌堆頂的指令卡附加 [Arg3] 層<BrokenCard:暗中破壞>。"
  },
  Skill_128233_Name = {
    Text = "崩解之絲"
  },
  Skill_128254_Desc = {
    Text = "每次行動結束後都會獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層<Chapter5_Monster_Fervor2:臨時狂熱>。"
  },
  Skill_128254_Name = {
    Text = "織母的低語"
  },
  Skill_128474_Desc = {
    Text = "和前列友方交換位置，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。若本回合擊破了「舊日餘燼」，獲得 [Arg3] 層臨時<ReinforcePVEKeywords:加固>並轉化為造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次，獲得 [Arg6] 層<Chapter5_Monster_Fervor1:臨時狂熱>的「鑿擊」。"
  },
  Skill_128474_Name = {
    Text = "狂熱鑿擊"
  },
  Skill_128475_Desc = {
    Text = "和前列友方交換位置，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<Chapter5_Monster_Fervor1:臨時狂熱>。"
  },
  Skill_128475_Name = {Text = "鑿擊"},
  Skill_128476_Desc = {
    Text = "和前列友方交換位置，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。若本回合擊破了「舊日餘燼」，獲得 [Arg3] 層臨時<ReinforcePVEKeywords:加固>並轉化為造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次，獲得 [Arg6] 層<Chapter5_Monster_Fervor2:臨時狂熱>的「鑿擊」。"
  },
  Skill_128476_Name = {
    Text = "狂熱鑿擊"
  },
  Skill_128477_Desc = {
    Text = "和前列友方交換位置，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<Chapter5_Monster_Fervor2:臨時狂熱>。"
  },
  Skill_128477_Name = {Text = "鑿擊"},
  Skill_128624_Desc = {
    Text = "切換至該意圖時、立刻獲得 [Arg1] 層<Chapter5_Monster_Fervor3:狂熱>。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次、每造成 [Arg4] 次未被格擋的傷害、獲得 [Arg5] 層<Chapter5_Monster_Fervor3:狂熱>。"
  },
  Skill_128624_Name = {
    Text = "狂喜之繭"
  },
  Skill_128625_Desc = {
    Text = "切換至該意圖時、立刻施加 [Arg1] 層<EmptinessKeywords: 虛無>並使所有喚醒體失去 [Arg2] 點狂氣。造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg4] 次、棄掉所有手牌。"
  },
  Skill_128625_Name = {
    Text = "驚懼之繭"
  },
  Skill_128627_Desc = {
    Text = "切換至該意圖時、直到下回合開始時、每打出 [Arg1] 張指令卡就獲得 [Arg2] 的臨時<PowerIconKeywords:力量>。 造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg4] 次、對手生命越低傷害越高、最高為 <Damage:[Damage:Arg5]> 點傷害。"
  },
  Skill_128627_Name = {
    Text = "暴怒之繭"
  },
  Skill_128628_Desc = {
    Text = "切換至該意圖時、將 [Arg1] 張隨機症狀洗入手中。造成<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重創> [Arg2] 回合和 [Arg3] 的<BleedingIconKeywords:出血>、本回合每打出 [Arg4] 張症狀、<BleedingIconKeywords:出血>效果增加 [Arg5]。"
  },
  Skill_128628_Name = {
    Text = "哀憫之繭"
  },
  Skill_128689_Desc = {
    Text = "臨時暴擊率 +[Arg1]%，獲得 1 點算力。本場戰鬥首次釋放時對所有敵人造成 [Arg3] 點<AshesPastKeyWord:舊日餘燼>。"
  },
  Skill_128689_Name = {
    Text = "歲末花火"
  },
  Skill_129565_BattleDesc_1 = {
    Text = "全體友方臨時<StrongEffectKeywords:強效>+ [Arg3] ，每有 1 名陣亡友方額外獲得 [Arg1] 臨時<StrongEffectKeywords:強效>。"
  },
  Skill_129565_Desc_1 = {
    Text = "全體友方臨時<StrongEffectKeywords:強效>+ [Arg1] ，每死亡一名友方體臨時<StrongEffectKeywords:強效>+1 。"
  },
  Skill_129565_Name_1 = {
    Text = "歲末花火"
  },
  Skill_129565_UnknownName = {
    Text = "歲末花火"
  },
  Skill_129615_Desc = {
    Text = "切換至該意圖時、立刻施加 [Arg1] 層<EmptinessKeywords: 虛無>並使所有喚醒體失去 [Arg2] 點狂氣。造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg4] 次、棄掉所有手牌。"
  },
  Skill_129615_Name = {
    Text = "驚懼之繭"
  },
  Skill_129616_Desc = {
    Text = "切換至該意圖時、直到下回合開始時、每打出 [Arg1] 張指令卡就獲得 [Arg2] 的臨時<PowerIconKeywords:力量>。 造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg4] 次、對手生命越低傷害越高、最高為 <Damage:[Damage:Arg5]> 點傷害。"
  },
  Skill_129616_Name = {
    Text = "暴怒之繭"
  },
  Skill_129617_Desc = {
    Text = "切換至該意圖時、將 [Arg1] 張隨機症狀洗入手中。造成<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重創> [Arg2] 回合和 [Arg3] 的<BleedingIconKeywords:出血>、本回合每打出 [Arg4] 張症狀、<BleedingIconKeywords:出血>效果增加 [Arg5]。"
  },
  Skill_129617_Name = {
    Text = "哀憫之繭"
  },
  Skill_129618_Desc = {
    Text = "切換至該意圖時、立刻獲得 [Arg1] 層<Chapter5_Monster_Fervor3:狂熱>。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次、每造成 [Arg4] 次未被格擋的傷害、獲得 [Arg5] 層<Chapter5_Monster_Fervor3:狂熱>。"
  },
  Skill_129618_Name = {
    Text = "狂喜之繭"
  },
  Skill_129622_Desc = {
    Text = "切換至該意圖時、立刻施加 [Arg1] 層<EmptinessKeywords: 虛無>並使所有喚醒體失去 [Arg2] 點狂氣。造成 <Damage:[Damage:Arg3]> 點傷害 [AttackTimes:Arg4] 次、棄掉所有手牌。"
  },
  Skill_129622_Name = {
    Text = "驚懼之繭"
  },
  Skill_129638_Desc = {
    Text = "該意圖無法被切換。切換至該意圖時、立刻獲得 [Arg1] 層臨時<ReinforcePVEKeywords:加固>。\n造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。洗入 [Arg4] 張隨機症狀、獲得 [Arg5] 層<Chapter5_Monster_Fervor3:狂熱>、所有喚醒體失去 [Arg6] 點狂氣。"
  },
  Skill_129638_Name = {
    Text = "破繭狂宴"
  },
  Skill_129811_Desc = {
    Text = "選擇一個策略。每次「葬骸之主」釋放「殘骸收取」後，置入手中。"
  },
  Skill_129812_Desc = {
    Text = "所有敵人的傷害臨時降低 30%。"
  },
  Skill_129812_Name = {
    Text = "正面干擾"
  },
  Skill_129813_Desc = {
    Text = "所有敵人獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。「葬骸之主」失去一半<Guaiwucanhai:殘骸>。"
  },
  Skill_129813_Name = {
    Text = "偷襲儲備"
  },
  Skill_129822_Desc = {
    Text = "造成 [Arg1] 層<EmptinessKeywords: 虛無>和 <WeaknessIconKeywords: 虛弱> 狀態、回覆 [Arg2]% 已損失生命。複製空間最左側 [Arg3] 張卡牌置入抽牌堆頂部、複製 [Arg4] 張隨機指令卡置入維度裂隙。"
  },
  Skill_129822_Name = {
    Text = "縛命羅網"
  },
  Skill_129823_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。「維度裂隙」中每有 1 張卡牌額外造成 1 次傷害。"
  },
  Skill_129823_Name = {
    Text = "無盡線縷"
  },
  Skill_129824_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>，「維度裂隙」中每有 1 張卡牌施加 1 層。"
  },
  Skill_129824_Name = {
    Text = "永恆織造"
  },
  Skill_129826_Desc = {
    Text = "獲得 [Arg1] <PowerIconKeywords:力量>，將隨機 [Arg2] 張指令卡的複製置入「維度裂隙」，將 [Arg3] 張<DerivativeCardKeywords_23:傷口>置入抽牌堆。"
  },
  Skill_129826_Name = {
    Text = "命途，依此諭示"
  },
  Skill_129827_Desc = {
    Text = "獲得 [Arg1] <PowerIconKeywords:力量>，將隨機 [Arg2] 張指令卡的複製置入「維度裂隙」，將 [Arg3] 張隨機<AberrationKeywords:畸變>置入抽牌堆。"
  },
  Skill_129827_Name = {
    Text = "凌駕命運的悲歌"
  },
  Skill_129828_Desc = {
    Text = "變更「斷絲震鳴」觸發後的意圖。將 [Arg1] 張隨機指令卡的複製置入「維度裂隙」，每當 [Arg2] 張卡牌離開「維度裂隙」時為其賦予 [Arg3] 層<BrokenCard:暗中破壞>。"
  },
  Skill_129828_Name = {
    Text = "木偶戲場揭幕"
  },
  Skill_129856_Desc = {
    Text = "生成 1 條觸腕、獲得 [Arg1] 點臨時觸腕傷害。"
  },
  Skill_129856_Name = {
    Text = "王權之威"
  },
  Skill_129857_Desc = {
    Text = "獲得「震怒」、12 層「困意」以及 [Arg1] 點觸腕傷害。"
  },
  Skill_129857_Name = {
    Text = "不朽威儀"
  },
  Skill_129858_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。自身生命上限 +[Arg3]％。"
  },
  Skill_129858_Name = {
    Text = "等價交換"
  },
  Skill_129869_Desc = {
    Text = "自定義執行指令"
  },
  Skill_129869_Name = {
    Text = "封裝測試"
  },
  Skill_130234_Desc_1 = {
    Text = "查看 [Arg1] 張其他隨機「鑰令」，選擇 1 張置入手中。"
  },
  Skill_130234_Name_1 = {
    Text = "不平等交換"
  },
  Skill_130234_UnknownName = {
    Text = "不平等交換"
  },
  Skill_130240_Desc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣、其他喚醒體獲得 [Arg2] 點狂氣。若「莫絲」在隊伍中、立刻釋放「漩！流！彈！」進行追擊。"
  },
  Skill_130240_Name = {
    Text = "溺亡的純真"
  },
  Skill_130351_Desc = {
    Text = "抽牌階段後若在手中、「強制打出」 1 張隨機指令卡並使其生效 2 次。\n打出後、下張打出的指令卡額外生效 2 次。打出 [Arg1] 次後消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130351_Name = {
    Text = "提線木偶"
  },
  Skill_130385_Desc = {
    Text = "抽牌階段後若在手中、從手牌中的隨機 2 張指令中選擇 1 張強制打出、並使其生效 2 次。\n打出後、下張指令卡算力消耗降低 2 點、打出的指令卡額外生效 2 次。打出 [Arg1] 次後消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130385_Name = {
    Text = "提線木偶"
  },
  Skill_130386_Desc = {
    Text = "抽牌階段後若在手中、從手牌中的隨機 2 張指令中選擇 1 張強制打出、並使其生效 2 次。\n打出後、下張打出的指令卡額外生效 2 次。打出 [Arg1] 次後消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130386_Name = {
    Text = "提線木偶"
  },
  Skill_130471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，維度裂隙中每有 1 張卡牌，傷害提高 [Arg3] 點。每造成 1 次未被格擋的傷害獲得 1 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  Skill_130471_Name = {
    Text = "萬絲穿心"
  },
  Skill_130472_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並驅散自身負面狀態，每造成 1 次未被格擋的傷害，自身最大生命提高 3%。"
  },
  Skill_130472_Name = {
    Text = "「當局者迷」"
  },
  Skill_130473_Desc = {
    Text = "其他友方獲得 [Arg1] 點<PowerIconKeywords:力量>，自身獲得 [Arg2] 點<PowerIconKeywords:力量>和 [Arg3]% 臨時<Baojidikang:暴擊抵抗>，召喚 2 名附加<Chapter5_Monster_Agitation:淵獄之門>的眷屬。"
  },
  Skill_130473_Name = {
    Text = "孵化眷屬"
  },
  Skill_130474_Desc = {
    Text = "切換至該意圖時、造成 [Arg1] 層<BleedingIconKeywords:出血>。施加 [Arg2] 層<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_130474_Name = {
    Text = "收割命運的紅線"
  },
  Skill_130475_Desc = {
    Text = "造成 [Arg1] 點<IntoxicationIconKeywords:中毒>，所有喚醒體基礎狂氣 +[Arg2] 。"
  },
  Skill_130475_Name = {
    Text = "「風雨如晦」"
  },
  Skill_130476_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、獲得 [Arg3] <PowerIconKeywords:力量>、移除維度裂隙。"
  },
  Skill_130476_Name = {
    Text = "凌駕命運的悲歌"
  },
  Skill_130477_Desc = {
    Text = "切換至該意圖時，移除「縛誓契約」和<Chapter5_Monster_Fervor4:狂熱>，清除其他友方。自身當前和最大生命提高 250%，「舊日餘燼」總量翻倍，獲得 50 層「融蝕霧盾」，打開「維度裂隙」。"
  },
  Skill_130477_Name = {
    Text = "絞纏暗夜的紡輪"
  },
  Skill_130478_Desc = {
    Text = "「封印」當前所有具有「命運殘碎」的指令卡 [Arg1] 回合，對其他指令卡造成 [Arg2] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_130478_Name = {
    Text = "「覆水難收」"
  },
  Skill_130479_Desc = {
    Text = "切換至該意圖時、造成 [Arg1] 層<BleedingIconKeywords:出血>。施加 [Arg2] 層<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>。若維度裂隙中卡牌數量大於 [Arg3]、額外施加 [Arg4] 層<FragileIconKeywords: 脆弱>、<BlindingKeywords: 致盲>、<Decay:腐壞>。"
  },
  Skill_130479_Name = {
    Text = "朽爛命運的紅線"
  },
  Skill_130491_Desc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]> 點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>、對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、[Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_130491_Name = {
    Text = "七彩大砲α"
  },
  Skill_130493_Desc = {
    Text = "獲得 2 點算力，抽 2 張牌。"
  },
  Skill_130493_Name = {
    Text = "莉雅的硬幣"
  },
  Skill_130506_Desc = {
    Text = "將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 25% 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。"
  },
  Skill_130506_Name = {
    Text = "豪賭的智慧"
  },
  Skill_130507_Desc = {
    Text = "將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 13% 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。"
  },
  Skill_130507_Name = {
    Text = "豪賭的智慧"
  },
  Skill_130508_Desc = {
    Text = "將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 17% 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。"
  },
  Skill_130508_Name = {
    Text = "豪賭的智慧"
  },
  Skill_130509_Desc = {
    Text = "將手中所有指令卡隨機洗入抽牌堆、洗入的指令卡在下次打出時有 21% 機率額外生效 1 次、並且每洗入 1 張指令卡就使所有喚醒體獲得 2 點狂氣。"
  },
  Skill_130509_Name = {
    Text = "豪賭的智慧"
  },
  Skill_130513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，隨機觸發以下效果中的一個：獲得 <Energy:[Energy:Arg1]> 狂氣並<PVPSlowKeywords:遲緩>自身；獲得 <Energy:[Energy:Arg3]> 狂氣；獲得 <Energy:[Energy:Arg4]> 和 [Arg5] 張<PVPDerivativeCardKeywords_17:「靈感」>。"
  },
  Skill_130513_Name_1 = {
    Text = "豪賭的智慧"
  },
  Skill_130928_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。若未造成擊殺，獲得 [Arg2] 層<PVPWaterPowerKeyWords:渦流>。"
  },
  Skill_130928_Name_1 = {
    Text = "深淵！漩渦！大轟炸"
  },
  Skill_130929_AwakerSkillBackgroundStory = {
    Text = "活潑地揮動駭人巨砲、蹦蹦跳跳地進入戰場。\n不在乎煩惱、不在乎危險、因為這些與朋友相比、是那麼微不足道。\n「朋友、麻煩！莫絲、登場！」"
  },
  Skill_130929_BattleDesc_0 = {
    Text = "莫絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：抽 1 張「裝填！」。莫絲釋放追擊後下次莫絲狂氣爆發額外享受 [Arg2]％ 觸腕傷害加成、最多疊加 [Arg3] 次。"
  },
  Skill_130929_BattleDesc_15 = {
    Text = "莫絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：抽 1 張「裝填」。莫絲釋放追擊後下次莫絲狂氣爆發額外享受 [Arg2]％ 觸腕傷害加成，並使下次狂氣爆發對生命最高敵人造成 [Arg4]％ 最大生命值的<FixedDamage:純粹傷害>，最多疊加 [Arg3] 次。"
  },
  Skill_130929_Desc_0 = {
    Text = "莫絲獲得 [Arg5]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：抽 1 張「裝填！」。莫絲釋放追擊後下次莫絲狂氣爆發額外享受 [Arg2]％ 觸腕傷害加成，最多疊加 [Arg3] 次。"
  },
  Skill_130929_Desc_15 = {
    Text = "莫絲獲得 [Arg5]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：抽 1 張「裝填」。莫絲釋放追擊後下次莫絲狂氣爆發額外享受 [Arg2]％ 觸腕傷害加成，並使下次狂氣爆發對生命最高敵人造成 [Arg4]％ 最大生命值的<FixedDamage:純粹傷害>，最多疊加 [Arg3] 次。"
  },
  Skill_130929_EffectNameList = {
    Text = "狂氣，觸腕傷害加成"
  },
  Skill_130929_Name = {
    Text = "漩渦來了！"
  },
  Skill_130930_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Block:[Block:Arg1]> 護盾和<DelayKeywords:延遲>：<Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_130930_Name_1 = {
    Text = "渺遠的伊甸園"
  },
  Skill_130931_AwakerSkillBackgroundStory = {
    Text = "漩渦帶來破壞、深淵帶來毀滅。\n向往友情與陽光的少女終究還是回歸了永恆的孤寂。\n哭喊、哀嚎、扭曲、崩潰、是她身處默斯克斯時的往復循環。\n這是默斯克斯下的深淵吞噬一切的咆哮。\n亦是莫絲戰勝祂的證明。"
  },
  Skill_130931_BattleDesc_0 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。"
  },
  Skill_130931_BattleDesc_1 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通。"
  },
  Skill_130931_BattleDesc_3 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成三倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通、每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。"
  },
  Skill_130931_Desc_0 = {
    Text = "驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。對所有敵人造成 [Arg7]％ <TentacleInjurieIconKeywords:觸腕傷害>加成的傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕、每條使本次狂氣爆發暴擊傷害 +50％。"
  },
  Skill_130931_Desc_1 = {
    Text = "驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。對所有敵人造成 [Arg7]％ <TentacleInjurieIconKeywords:觸腕傷害>加成的傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕、每條使本次狂氣爆發暴擊傷害 +50％。獲得 [Arg6] 點界域精通。"
  },
  Skill_130931_Desc_3 = {
    Text = "驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。對所有敵人造成 [Arg7]％ <TentacleInjurieIconKeywords:觸腕傷害>加成的傷害、對生命最高的敵人造成三倍傷害。犧牲至多 3 條額外的永久觸腕、每條使本次狂氣爆發暴擊傷害 +50％。獲得 [Arg6] 點界域精通、每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。"
  },
  Skill_130931_EffectNameList = {
    Text = "觸腕傷害加成"
  },
  Skill_130931_Name = {
    Text = "深淵！漩渦！炮！"
  },
  Skill_130931_OverLimitUtlSkillDesc = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成三倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)，每條使本次狂氣爆發暴擊傷害 +100％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通。接下來釋放的 5 次「渦！流！彈！」生效 2 次。"
  },
  Skill_130931_tempBattleDesc_1 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。"
  },
  Skill_130931_tempBattleDesc_2 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通。"
  },
  Skill_130931_tempBattleDesc_3 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害、對生命最高的敵人造成三倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)、每條使本次狂氣爆發暴擊傷害 +50％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通、每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。"
  },
  Skill_130931_tempBattleDesc_4 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成三倍傷害和 [Arg9]％ 最大生命值的<FixedDamage:純粹傷害>。犧牲至多 3 條額外的永久觸腕（ [Arg4] 條），每條使本次狂氣爆發暴擊傷害 +50％（當前暴擊率：[Arg5]％。觸腕傷害加成：[Arg8]％ ）。獲得 [Arg6] 點界域精通，每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_1 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)，每條使本次狂氣爆發暴擊傷害 +100％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。接下來釋放的 5 次「渦！流！彈！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_2 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成雙倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)，每條使本次狂氣爆發暴擊傷害 +100％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通。接下來釋放的 5 次「渦！流！彈！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_3 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成三倍傷害。犧牲至多 3 條額外的永久觸腕([Arg4] 條)，每條使本次狂氣爆發暴擊傷害 +100％(當前暴擊率： [Arg5]％。觸腕傷害加成： [Arg8]％)。獲得 [Arg6] 點界域精通，每消耗 20 點狂氣就使其他喚醒體獲得 1 點狂氣。接下來釋放的 5 次「渦！流！彈！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_4 = {
    Text = "驅散所有手中卡牌的<BurningKeywords:燃燒>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，對生命最高敵人造成三倍傷害和 [Arg9]％ 最大生命值的<FixedDamage:純粹傷害>。犧牲至多 3 條額外的永久觸腕（ [Arg4] 條），每條使本次狂氣爆發暴擊傷害 +100％（當前暴擊率：[Arg5]％。觸腕傷害加成：[Arg8]％ ）。獲得 [Arg6] 點界域精通。接下來釋放的 5 次「渦！流！彈！」生效 2 次。"
  },
  Skill_130932_AwakerSkillBackgroundStory = {
    Text = "「嘎吱、嘎吱……」\n狰狞的巨炮不斷吞下湛藍的漩渦、發出並不存在的聲響。\n每吞下一枚、怪物瞳孔中的猩紅便加重一分。\n它等待著、等待著……\n等待它天真活潑的主人、下達命令的那一刻。"
  },
  Skill_130932_BattleDesc = {
    Text = "<DerivativeCardKeywords_132:>獲得 1 層<WhirlpoolKeywords:漩渦裝填>、可使用 [Arg1] 次。"
  },
  Skill_130932_Desc = {
    Text = "<DerivativeCardKeywords_132:>獲得 1 層<WhirlpoolKeywords:漩渦裝填>、可使用 3 次。"
  },
  Skill_130932_EffectNameList = {
    Text = "「漩！流！彈！」等級"
  },
  Skill_130932_Name = {Text = "裝填"},
  Skill_130933_Desc = {
    Text = "所有敵人獲得 25 層<ReinforcePVEKeywords:加固>。每回合抽牌數 -1。所有喚醒體造成護盾和回復生命提高 20%。"
  },
  Skill_130933_Name = {
    Text = "理順毛髮"
  },
  Skill_130934_Desc_0 = {
    Text = "對生命最高的敵人造成 [Arg1] 點<RealDamage:固定傷害>，<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Desc_1 = {
    Text = "對生命最高的敵人造成 [Arg1] 點<RealDamage:固定傷害>和目標最大生命值 [Float:Arg3]％ 的<FixedDamage:純粹傷害>。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Name = {
    Text = "渦！流！彈！"
  },
  Skill_130935_AwakerSkillBackgroundStory = {
    Text = "「啪塔啪塔～打倒壞人～」"
  },
  Skill_130935_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_130935_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。莫絲下次狂氣爆發暴擊率 +[Arg3]％，下次「裝填」基礎算力消耗降低 1。"
  },
  Skill_130935_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。莫絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_130935_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。莫絲獲得 <Energy:[Energy:Arg2]> 點狂氣。莫絲下次狂氣爆發暴擊率 +[Arg3]％，下次「裝填」基礎算力消耗降低 1。"
  },
  Skill_130935_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_130935_Name = {Text = "打擊"},
  Skill_130935_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_130936_Desc_1 = {
    Text = "<DelayKeywords:延遲>：<Energy:[Energy:Arg1]> 狂氣。直到下回合開始，失去生命後將等量的延遲狂氣轉化為護盾。"
  },
  Skill_130936_Name_1 = {
    Text = "漩渦護身"
  },
  Skill_130937_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_130937_Name_1 = {Text = "打擊"},
  Skill_130938_AwakerSkillBackgroundStory = {
    Text = "「刷啦刷啦～保護朋友～」"
  },
  Skill_130938_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_130938_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。莫絲下次狂氣爆發暴擊率 +[Arg3]％，下次「裝填」基礎算力消耗降低 1。"
  },
  Skill_130938_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。莫絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_130938_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。莫絲獲得 <Energy:[Energy:Arg2]> 點狂氣。莫絲下次狂氣爆發暴擊率 +[Arg3]％，下次「裝填」基礎算力消耗降低 1。"
  },
  Skill_130938_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_130938_Name = {Text = "防禦"},
  Skill_130938_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_130939_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，升級為<PVPDerivativeCardKeywords_27:「深淵！漩渦！二式！」>。若未造成擊殺，獲得 [Arg2] 層<PVPWaterPowerKeyWords:渦流>。<PVPDerivativeCardKeywords_28:>"
  },
  Skill_130939_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>，升級為<PVPDerivativeCardKeywords_28:「深淵！漩渦！大轟炸！」>。若未造成擊殺，獲得 [Arg2] 層<PVPWaterPowerKeyWords:渦流>。"
  },
  Skill_130939_Desc_3 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。若未造成擊殺，獲得 [Arg2] 層<PVPWaterPowerKeyWords:渦流>。"
  },
  Skill_130939_Name_1 = {
    Text = "深淵！漩渦！炮！"
  },
  Skill_130939_Name_2 = {
    Text = "深淵！漩渦！二式"
  },
  Skill_130939_Name_3 = {
    Text = "深淵！漩渦！大轟炸"
  },
  Skill_130940_Desc = {
    Text = "移除所有敵人<ReinforcePVEKeywords:加固>。回覆已損失生命值的 50% 的生命、將所有的喚醒體的狂氣填充至最大值。本回合所有喚醒體能釋放兩次狂氣爆發。"
  },
  Skill_130940_Name = {
    Text = "二世衝擊"
  },
  Skill_130941_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次打出「技能」後對<HPAndShieldMin:生命與護盾最低>的敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_130941_Name_1 = {
    Text = "被囚禁的瘋狂"
  },
  Skill_130942_AwakerSkillBackgroundStory = {
    Text = "自從在一次實驗中、莫絲學會了積蓄力量的方法後、其造成的破壞就開始成倍上升。\n因此、當莫絲身邊開始出現不正常的濕潮時、請立刻與敵人拉開距離。\n用莫絲本人的話說就是——「先蓄力、再發射、威力大！」。"
  },
  Skill_130942_Desc = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣、下次莫絲狂氣爆發暴擊率 +[Arg2]％。<RippleKeywords:餘波>：其他喚醒體獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_130942_EffectNameList = {
    Text = "狂氣、暴擊率"
  },
  Skill_130943_Desc = {
    Text = "所有敵人獲得 25 層<ReinforcePVEKeywords:加固>。銀鑰能量上限及鑰令消耗銀鑰能量 +350。每回合首次鑰令生效 2 次。"
  },
  Skill_130943_Name = {
    Text = "投餵零食"
  },
  Skill_130944_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_130944_Name_1 = {Text = "波動彈"},
  Skill_130945_Desc = {
    Text = "所有敵人獲得 25 層<ReinforcePVEKeywords:加固>。所有喚醒體基礎狂氣提高 10 點。釋放狂氣爆發後獲得 1 算力、每個喚醒體 1 回合只能觸發 1 次。"
  },
  Skill_130945_Name = {
    Text = "蹭蹭臉頰"
  },
  Skill_130946_Desc_1 = {
    Text = "全體友方獲得 [Arg1] <PVPWaterPowerKeyWords:漩渦> 和<DelayKeywords:延遲 1>：[Arg2] 狂氣。"
  },
  Skill_130946_Name_1 = {
    Text = "溺亡的純真"
  },
  Skill_130946_UnknownName = {
    Text = "溺亡的純真"
  },
  Skill_130947_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>，升級為<PVPDerivativeCardKeywords_28:「深淵！漩渦！大轟炸！」>。若未造成擊殺，獲得 [Arg2] 層<PVPWaterPowerKeyWords:渦流>。"
  },
  Skill_130947_Name_1 = {
    Text = "深淵！漩渦！二式"
  },
  Skill_130948_Desc_1 = {
    Text = "獲得 [Arg1] 層<PVPWaterPowerKeyWords:漩渦>並將 [Arg2] 張<PVPDerivativeCardKeywords_26:「波動彈」>置入手牌。"
  },
  Skill_130948_Name_1 = {
    Text = "潆洄波動"
  },
  Skill_131102_Desc = {
    Text = "為隨機手中2張指令卡賦予「<Chapter5_Monster_Support1:繁育之理>」刻印。"
  },
  Skill_131114_Desc = {
    Text = "為隨機手中2張指令卡賦予「<Chapter5_Monster_Support2:智識之理>」刻印。"
  },
  Skill_131114_Name = {
    Text = "智識之理"
  },
  Skill_131115_Desc = {
    Text = "為隨機手中2張指令卡賦予「<Chapter5_Monster_Support3:歡愉之理>」刻印。"
  },
  Skill_131115_Name = {
    Text = "歡愉之理"
  },
  Skill_131192_Desc = {
    Text = "使手中所有帶有<ErosionColorInkKeywords:認知錯亂>的卡牌算力消耗 -1，每有 1 張使狂氣最低的喚醒體獲得 <Energy:5> 點狂氣，之後還原各處帶有<ErosionColorInkKeywords:認知錯亂>的卡牌。本回合打出卡牌後不再為其他卡牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_131241_Desc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]> 點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>、對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、[Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_131241_Name = {
    Text = "七彩大砲β"
  },
  Skill_131365_Desc = {
    Text = "對敵人造成生命百分比傷害，並擊碎其超維空間。"
  },
  Skill_131365_Name = {
    Text = "命縷各安其位"
  },
  Skill_131438_Desc = {
    Text = "抽牌階段後若在手中、從手牌中的隨機 2 張指令中選擇 1 張強制打出、並使其生效 2 次。\n打出後、下張指令卡算力消耗降低為 0、打出的指令卡額外生效 2 次。打出 [Arg1] 次後消耗（[Arg2]/[Arg1]）。"
  },
  Skill_131438_Name = {
    Text = "提線木偶"
  },
  Skill_131654_Desc = {
    Text = "打出後、清除指定喚醒體的狂氣值、然後使其獲得1倍基礎狂氣的狂氣值。"
  },
  Skill_131654_Name = {
    Text = "狂氣重盈1倍"
  },
  Skill_131786_Desc = {
    Text = "打出後、對隨機目標造成 [Damage:Arg1] 點傷害、其他敵方造成 [Damage:Arg2] 點傷害。"
  },
  Skill_131786_Name = {
    Text = "目標測試"
  },
  Skill_131856_AwakerSkillBackgroundStory = {
    Text = "眼睛、耳朵、舌頭、皮膚、大腦，遍布全身的感覺。\n被分享的愛和溫柔，會永遠圍繞著你，直到死為止——"
  },
  Skill_131856_BattleDesc_0 = {
    Text = "沙耶獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後為各處其他喚醒體不具有「<DestructionKeywords:銷毀>」的指令卡附加<ErosionColorInkKeywords:認知錯亂>。每回合前 3 次打出帶有<ErosionColorInkKeywords:認知錯亂>的指令卡使沙耶和該指令卡所屬喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131856_BattleDesc_15 = {
    Text = "沙耶獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，沙耶獲得 <Energy:[Energy:Arg4]> 點狂氣和 1 層<KaiHuajishu:羽種>，為各處其他喚醒體不具有「<DestructionKeywords:銷毀>」的指令卡附加<ErosionColorInkKeywords:認知錯亂>。每回合前 3 次打出帶有<ErosionColorInkKeywords:認知錯亂>的指令卡使沙耶和該指令卡所屬喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131856_Desc_0 = {
    Text = "沙耶獲得 [Arg3]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後為各處其他喚醒體不具有「<DestructionKeywords:銷毀>」的指令卡附加<ErosionColorInkKeywords:認知錯亂>。每回合前 3 次打出帶有<ErosionColorInkKeywords:認知錯亂>的指令卡使沙耶和該指令卡所屬喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131856_Desc_15 = {
    Text = "沙耶獲得 [Arg3]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，沙耶獲得 <Energy:[Energy:Arg4]> 點狂氣和 1 層<KaiHuajishu:羽種>，為各處其他喚醒體不具有「<DestructionKeywords:銷毀>」的指令卡附加<ErosionColorInkKeywords:認知錯亂>。每回合前 3 次打出帶有<ErosionColorInkKeywords:認知錯亂>的指令卡使沙耶和該指令卡所屬喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131856_EffectNameList = {
    Text = "狂氣,額外狂氣"
  },
  Skill_131856_Name = {
    Text = "認知改造"
  },
  Skill_131857_AwakerSkillBackgroundStory = {
    Text = "在抵達那個一直追尋的世界，不用再東躲西藏的世界之前。\n所有擋在路途上的，都是應該打倒的「敵人」。"
  },
  Skill_131857_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131857_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131857_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。沙耶獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131857_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。沙耶獲得 <Energy:[Energy:Arg2]> 點狂氣。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]，當前生命越低效果越高，至多提高 100%"
  },
  Skill_131857_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_131857_Name = {Text = "打擊"},
  Skill_131857_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_131858_AwakerSkillBackgroundStory = {
    Text = "恐怖的、美麗的、絕望的，在「愛」的侵染下，那閃耀的生命歌詠著盛開。\n這是宣告新世界揭幕、奏響舊世界滅亡的歌。"
  },
  Skill_131858_BattleDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：隨機 2 張複製的「基礎打擊」或「基礎防禦」的算力消耗變為 0 並額外生效 1 次。】獲得 <Block:[Block:Arg1]> 點護盾。選擇一名其他喚醒體，生成其所有基礎指令卡的各 1 份原始複製分別置入抽牌堆和棄牌堆，附加<NothingnessIconKeywords:虛無>和<DestructionKeywords:銷毀>。消耗所有<KaiHuajishu:羽種>，每消耗 1 層使其中隨機 1 張「技能」算力消耗變為 0。"
  },
  Skill_131858_Desc = {
    Text = "【<DevouredIconKeywords:吞噬> ：隨機 2 張複製的「基礎打擊」或「基礎防禦」的算力消耗變為 0 並額外生效 1 次。】獲得 <Block:[Block:Arg1]> 點護盾。選擇一名其他喚醒體，生成其所有基礎指令卡的各 1 份原始複製分別置入抽牌堆和棄牌堆，附加<NothingnessIconKeywords:虛無>和<DestructionKeywords:銷毀>。消耗所有<KaiHuajishu:羽種>，每消耗 1 層使其中隨機 1 張「技能」算力消耗變為 0。"
  },
  Skill_131858_EffectNameList = {Text = "護盾"},
  Skill_131858_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：隨機 2 張複製的「基礎打擊」或「基礎防禦」的算力消耗變為 0 並額外生效 1 次。】獲得 <Block:[Block:Arg1]> 點護盾。選擇一名其他喚醒體，生成其所有基礎指令卡的各 1 份原始複製分別置入抽牌堆和棄牌堆，附加<NothingnessIconKeywords:虛無>和<DestructionKeywords:銷毀>，使複製的所有「技能」額外生效 1 次。消耗所有<KaiHuajishu:羽種>，每消耗 1 層使其中隨機 1 張「技能」算力消耗變為 0。"
  },
  Skill_131858_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_131860_AwakerSkillBackgroundStory = {
    Text = "該喚醒體保留了包括網狀肌肉組織在內的，部分原種族特徵。\n在受到打擊的瞬間，肌肉組織可全方位伸縮，物理手段很難對其造成實質傷害。"
  },
  Skill_131860_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131860_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131860_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。沙耶獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_131860_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。沙耶獲得 <Energy:[Energy:Arg2]> 點狂氣。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]，當前生命越低效果越高，至多提高 100%"
  },
  Skill_131860_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_131860_Name = {Text = "防禦"},
  Skill_131860_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_131902_Desc = {
    Text = "打出後、打印出莫絲的狂氣上限。"
  },
  Skill_131902_Name = {
    Text = "功能特性"
  },
  Skill_132227_Desc = {
    Text = "如果隊伍中有神國深海喚醒體則 +1000力量，否則+1000衰竭"
  },
  Skill_132227_Name = {
    Text = "技能@測試@新深海職業判定測試"
  },
  Skill_132357_AwakerSkillBackgroundStory = {
    Text = "「看！奧瑞塔像魚一樣吐泡泡！」"
  },
  Skill_132357_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，並分別給自身、玩家、前排敵方添加狀態。打出值、實際值各1遍。"
  },
  Skill_132357_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_132357_Name = {
    Text = "測·防禦"
  },
  Skill_132357_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_132358_AwakerSkillBackgroundStory = {
    Text = "女孩懷著不舍離開了破產的水族館，作為工作酬勞，她被允許把幾隻水母帶回家。\n這是她最喜歡的小小生靈，浮遊幻海之靈，生生不息之花。\n只要悉心照料，它們會填滿整個水缸！——她曾經期待著這樣的景象。"
  },
  Skill_132358_Desc_0 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。"
  },
  Skill_132358_Desc_15 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 2 次傷害。"
  },
  Skill_132358_EffectNameList = {Text = "狂氣"},
  Skill_132358_Name = {
    Text = "測·覺醒"
  },
  Skill_132359_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132359_Desc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>，對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、施加 [Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 層 <CutKeywords:命運裁斷>。"
  },
  Skill_132359_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。獲得 [Power:Arg2] 點 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>，之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  Skill_132360_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132360_Desc = {
    Text = "對前排敵方造成 [Arg1] 點普通固定傷害 [Arg2] 次。"
  },
  Skill_132360_Name = {
    Text = "測·折光"
  },
  Skill_132361_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有沒有嚇你一跳！」"
  },
  Skill_132361_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132361_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132361_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132361_Name = {
    Text = "測·打擊"
  },
  Skill_132361_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132361_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132361_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132362_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132362_Desc = {
    Text = "對前排敵方造成 [Arg1] 點穿刺固定傷害 [Arg2] 次。"
  },
  Skill_132362_Name = {
    Text = "測·鏡返"
  },
  Skill_132363_Desc_1 = {
    Text = "當前行動卡牌目標測試"
  },
  Skill_132363_Name_1 = {
    Text = "當前行動卡牌目標測試"
  },
  Skill_132425_AwakerSkillBackgroundStory = {
    Text = "女孩懷著不舍離開了破產的水族館，作為工作酬勞，她被允許把幾隻水母帶回家。\n這是她最喜歡的小小生靈，浮遊幻海之靈，生生不息之花。\n只要悉心照料，它們會填滿整個水缸！——她曾經期待著這樣的景象。"
  },
  Skill_132425_Desc_0 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。"
  },
  Skill_132425_Desc_15 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 2 次傷害。"
  },
  Skill_132425_EffectNameList = {Text = "狂氣"},
  Skill_132425_Name = {
    Text = "測·覺醒"
  },
  Skill_132426_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有沒有嚇你一跳！」"
  },
  Skill_132426_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132426_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132426_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132426_Name = {
    Text = "測·打擊"
  },
  Skill_132426_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132426_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132426_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132427_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132427_Desc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>，對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、施加 [Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 層 <CutKeywords:命運裁斷>。"
  },
  Skill_132427_Name = {
    Text = "測·折光"
  },
  Skill_132428_AwakerSkillBackgroundStory = {
    Text = "女孩懷著不舍離開了破產的水族館，作為工作酬勞，她被允許把幾隻水母帶回家。\n這是她最喜歡的小小生靈，浮遊幻海之靈，生生不息之花。\n只要悉心照料，它們會填滿整個水缸！——她曾經期待著這樣的景象。"
  },
  Skill_132428_Desc_0 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。"
  },
  Skill_132428_Desc_15 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 2 次傷害。"
  },
  Skill_132428_EffectNameList = {Text = "狂氣"},
  Skill_132428_Name = {
    Text = "測·覺醒"
  },
  Skill_132429_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而靜謐的，它承載著對生的渴望與對死的恐懼。\n但偏偏有人要用歡笑與玩弄填滿海洋——在奧瑞塔發出如此邀請時，「陪她鬧一場又何妨」的感覺總會湧上心頭，順勢讓簡單的快樂填滿胸腔。"
  },
  Skill_132429_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_132429_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_132429_EffectNameList = {
    Text = "傷害,後續傷害提升"
  },
  Skill_132429_Name = {
    Text = "測·狂爆"
  },
  Skill_132429_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。獲得 [Power:Arg2] 點 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>，之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  Skill_132429_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_132430_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而靜謐的，它承載著對生的渴望與對死的恐懼。\n但偏偏有人要用歡笑與玩弄填滿海洋——在奧瑞塔發出如此邀請時，「陪她鬧一場又何妨」的感覺總會湧上心頭，順勢讓簡單的快樂填滿胸腔。"
  },
  Skill_132430_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_132430_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_132430_EffectNameList = {
    Text = "傷害,後續傷害提升"
  },
  Skill_132430_Name = {
    Text = "測·狂爆"
  },
  Skill_132430_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。獲得 [Power:Arg2] 點 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>，之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  Skill_132430_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_132431_AwakerSkillBackgroundStory = {
    Text = "「看！奧瑞塔像魚一樣吐泡泡！」"
  },
  Skill_132431_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132431_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132431_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132431_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132431_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_132431_Name = {
    Text = "測·防禦"
  },
  Skill_132431_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_132432_AwakerSkillBackgroundStory = {
    Text = "孩子們會慢慢看穿童話的本質，理解神話背後的寓言。在人類的語言中，這個過程被稱為「長大」。\n但也有孩子會愈發相信睡前故事，他們固執地認為天上真的有彩虹橋，真的有文明沉沒深海。\n奧瑞塔喜歡這些故事，她要向更多的夥伴分享這份快樂。"
  },
  Skill_132432_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_132432_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量+1 的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_132432_EffectNameList = {
    Text = "觸腕傷害,「腺體分裂」等級"
  },
  Skill_132432_Name = {
    Text = "測·二技"
  },
  Skill_132432_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132433_AwakerSkillBackgroundStory = {
    Text = "世界上存在著一種特殊的水母，在受傷後，其脫落的組織能再次發育為完整的水螅體。\n「奧瑞塔也會生水母！所以奧瑞塔也是水母！」\n在孩子認知世界的這個階段，還是不要掃她的興吧。"
  },
  Skill_132433_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_132433_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_132433_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132433_Name = {
    Text = "測·一技"
  },
  Skill_132433_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132434_AwakerSkillBackgroundStory = {
    Text = "孩子們會慢慢看穿童話的本質，理解神話背後的寓言。在人類的語言中，這個過程被稱為「長大」。\n但也有孩子會愈發相信睡前故事，他們固執地認為天上真的有彩虹橋，真的有文明沉沒深海。\n奧瑞塔喜歡這些故事，她要向更多的夥伴分享這份快樂。"
  },
  Skill_132434_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_132434_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量+1 的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_132434_EffectNameList = {
    Text = "觸腕傷害,「腺體分裂」等級"
  },
  Skill_132434_Name = {
    Text = "測·二技"
  },
  Skill_132434_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132435_AwakerSkillBackgroundStory = {
    Text = "女孩懷著不舍離開了破產的水族館，作為工作酬勞，她被允許把幾隻水母帶回家。\n這是她最喜歡的小小生靈，浮遊幻海之靈，生生不息之花。\n只要悉心照料，它們會填滿整個水缸！——她曾經期待著這樣的景象。"
  },
  Skill_132435_Desc_0 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。"
  },
  Skill_132435_Desc_15 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 2 次傷害。"
  },
  Skill_132435_EffectNameList = {Text = "狂氣"},
  Skill_132435_Name = {
    Text = "測·覺醒"
  },
  Skill_132436_AwakerSkillBackgroundStory = {
    Text = "「看！奧瑞塔像魚一樣吐泡泡！」"
  },
  Skill_132436_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132436_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132436_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132436_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132436_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_132436_Name = {
    Text = "測·防禦"
  },
  Skill_132436_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_132437_AwakerSkillBackgroundStory = {
    Text = "「看！奧瑞塔像魚一樣吐泡泡！」"
  },
  Skill_132437_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132437_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132437_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132437_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132437_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_132437_Name = {
    Text = "測·防禦"
  },
  Skill_132437_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_132438_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132438_Desc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>，對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、施加 [Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 層 <CutKeywords:命運裁斷>。"
  },
  Skill_132438_OverLimitUtlSkillDesc = {
    Text = "玩家獲得 [Power:Arg1] 點<PowerIconKeywords:力量>、<Block:[Block:Arg2]> 點護盾、[Heal:Arg3] 點治療、[TentaclePower:Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害>、[Counterattack:Arg5] 層 <RetaliateIconKeywords:反擊>、對前排敵方造成 <Damage:[Damage:Arg6]> 點傷害 [Arg7] 次、[Poison:Arg8] 層<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 層 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_132439_AwakerSkillBackgroundStory = {
    Text = "光之七彩，絢爛迷離~"
  },
  Skill_132439_Desc = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，並施加等量<IntoxicationIconKeywords:中毒>、等量<CutKeywords:命運裁斷>，獲得等量 <RetaliateIconKeywords:反擊>。"
  },
  Skill_132439_Name = {
    Text = "測·鏡返"
  },
  Skill_132440_AwakerSkillBackgroundStory = {
    Text = "世界上存在著一種特殊的水母，在受傷後，其脫落的組織能再次發育為完整的水螅體。\n「奧瑞塔也會生水母！所以奧瑞塔也是水母！」\n在孩子認知世界的這個階段，還是不要掃她的興吧。"
  },
  Skill_132440_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_132440_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_132440_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132440_Name = {
    Text = "測·一技"
  },
  Skill_132440_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132441_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有沒有嚇你一跳！」"
  },
  Skill_132441_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132441_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132441_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132441_Name = {
    Text = "測·打擊"
  },
  Skill_132441_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132441_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132441_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132442_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有沒有嚇你一跳！」"
  },
  Skill_132442_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132442_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132442_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_132442_Name = {
    Text = "測·打擊"
  },
  Skill_132442_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_132442_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132442_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_132494_Desc = {
    Text = "棄掉所有手牌，創建[Arg1]張牌 集合測試，取前[Arg2]張和後[Arg3]張的差集，為其附加消耗。"
  },
  Skill_132495_Desc = {
    Text = "棄掉所有手牌，創建[Arg1]張牌 集合測試，取前[Arg2]張和後[Arg3]張的對稱差，為其附加消耗。"
  },
  Skill_132495_Name = {Text = "對稱差"},
  Skill_132496_Name = {
    Text = "集合測試"
  },
  Skill_132497_Desc = {
    Text = "棄掉所有手牌，創建[Arg1]張牌 集合測試，取前[Arg2]張和後[Arg3]張的並集，為其附加消耗。"
  },
  Skill_132497_Name = {Text = "並集"},
  Skill_132498_Desc = {
    Text = "棄掉所有手牌，創建[Arg1]張牌 集合測試，取前[Arg2]張和後[Arg3]張的交集，為其附加消耗。"
  },
  Skill_132884_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] <StrongEffectKeywords:強效> ，其他友方狂氣爆發後使其獲得<PVPOneMeetingKeywords:一期一會>。"
  },
  Skill_132884_Name_1 = {
    Text = "櫻花下的迷思"
  },
  Skill_133319_Desc_1 = {
    Text = "使一名友方的下一個技能算力消耗 –[Arg1]，損失 <Damage:[Arg2]> 生命。"
  },
  Skill_133319_Name_1 = {Text = "改寫"},
  Skill_133322_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_133322_Name_1 = {Text = "打擊"},
  Skill_133323_BattleDesc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg4]> 傷害，每損失 [Arg2] 生命傷害 +[Arg3] ，自身回復等量生命。"
  },
  Skill_133323_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，每損失 [Arg2] 生命傷害 +[Arg3] ，自身回復等量生命。"
  },
  Skill_133323_Name_1 = {Text = "掠奪"},
  Skill_133324_Desc_1 = {
    Text = "對敵方全體造成 <Damage:[Damage:Arg1]> 傷害並施加<PVPCognitiveDissonanceKeyWords:認知錯亂>。"
  },
  Skill_133325_BattleDesc_1 = {
    Text = "選擇一名友方，使其獲得 <Heal:[Heal:Arg4]> <PVPFeatheredSeedsKeyWords:羽種>和等量生命，每消耗 [Arg2] 算力，<PVPFeatheredSeedsKeyWords:羽種>和等量生命增加 [Arg3]。"
  },
  Skill_133325_Desc_1 = {
    Text = "選擇一名友方，使其獲得 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:羽種>和等量生命，每消耗 [Arg2] 算力，<PVPFeatheredSeedsKeyWords:羽種>和等量生命增加 [Arg3]。"
  },
  Skill_133346_Desc_1 = {
    Text = "造成<PVPSeriousInjuryKeywords:重創>，<PVPPenetrateKeywords:貫穿>，<DelayKeywords:延遲>：回復全體友方 <Heal:[Heal:Arg1]> 生命，<PVPSeriousInjuryKeywords:重創>每驅散 [Arg2] 護盾或<DelayKeywords:延遲>治療，回復生命 +[Arg3]。"
  },
  Skill_133346_Name_1 = {
    Text = "獻給新世界"
  },
  Skill_133346_UnknownName = {
    Text = "獻給新世界"
  },
  Skill_133347_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：該命輪死亡後保留。裝備者死亡時和死亡狀態下的後續 [Arg2] 回合結束後，其他友方獲得 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:羽種>和生命。"
  },
  Skill_133347_Name_1 = {
    Text = "願世界化作芬芳"
  },
  Skill_133348_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備後，無法識別裝備者的「打擊」、「技能」、「狂氣爆發」描述，但每次傷害、護盾、治療隨機提升[Arg1]%～[Arg2]%。"
  },
  Skill_133348_Name_1 = {
    Text = "淤泥裡的童話"
  },
  Skill_133365_AwakerSkillBackgroundStory = {
    Text = "她曾聽過無數次絲線斷裂的聲音。\n一場未曾發生的重逢。一句未曾說出的告白。一位未曾降生的孩童。\n一段未能面世的音樂。一場未能勝利的戰爭。一個未能倖存的文明。\n絲線編織。絲線斷裂。絲線重新匯入那張巨網。\n命運的神明早已知曉，沒有什麼會真正消亡，沒有什麼曾真正存在。"
  },
  Skill_133365_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，下次「永恆織造」會生成額外的「<DerivativeCardKeywords_138:牽絲引命>」置入抽牌堆和棄牌堆。"
  },
  Skill_133365_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_133365_Name = {
    Text = "縛命羅網"
  },
  Skill_133365_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_133366_AwakerSkillBackgroundStory = {
    Text = "自她誕生的第一天起，她便看到命運的絲線蔓延。\n沿著絲線的軌跡，她踏入門扉，領受她無盡的、屬於囚徒的命運。\n絲線穿過名為摩伊賴的紡輪，穿過城牆與海峽，穿過誓言與謊言，穿過每一個以為自己正在做出選擇的靈魂。\n在這自由的幻境裡，紡輪轉動，亙古不息。"
  },
  Skill_133366_Desc_0 = {
    Text = "對所有敵人造成 [FateCut:Arg1] 點<CutKeywords:命運裁斷>，生成 1 張「<DerivativeCardKeywords_138:牽絲引命>」置入手中<SilkKeywords1:>"
  },
  Skill_133366_EffectNameList = {
    Text = "命運裁斷"
  },
  Skill_133366_Name = {
    Text = "永恆織造"
  },
  Skill_133366_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_133366_tempBattleDesc_1 = {
    Text = "對所有敵人造成 [FateCut:Arg1] 點<CutKeywords:命運裁斷>，生成 1 張「<DerivativeCardKeywords_138:牽絲引命>」置入手中。"
  },
  Skill_133366_tempBattleDesc_2 = {
    Text = "對所有敵人造成 [FateCut:Arg1] 點<CutKeywords:命運裁斷>，生成 1 張「<DerivativeCardKeywords_138:牽絲引命>」置入手中，抽牌堆、棄牌堆。"
  },
  Skill_133381_Desc_0 = {
    Text = "獲得 5 層臨時<SingularityKeywords2:奇點稜鏡>，對生命最低敵人造成 [FateCut:Arg2] 點<CutKeywords:命運裁斷>。"
  },
  Skill_133381_Desc_3 = {
    Text = "獲得 10 層臨時<SingularityKeywords2:奇點稜鏡>，對生命最低敵人造成 [FateCut:Arg2] 點<CutKeywords:命運裁斷>。"
  },
  Skill_133381_Name = {
    Text = "無盡線縷"
  },
  Skill_133473_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、將 [Arg3] 張隨機症狀洗入對方抽牌堆。"
  },
  Skill_133474_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次、將 [Arg3] 張隨機喚醒體附帶<DepleteIconKeywords:消耗>的「打擊」洗入對方抽牌堆。"
  },
  Skill_133474_Name = {
    Text = "幻毒侵蝕"
  },
  Skill_133715_Desc = {
    Text = "選擇1名喚醒體，添加卡牌屬性，傳播到其所有當前及未來的卡牌。"
  },
  Skill_133715_Name = {
    Text = "卡牌屬性傳播"
  },
  Skill_133950_Desc = {
    Text = "從已解鎖的 3 個隨機鑰令中選擇 1 個立刻釋放並生效 2 次，打出後永久變化為「<DerivativeCardKeywords_140:春之信>」。"
  },
  Skill_133950_Name = {
    Text = "一期一會"
  },
  Skill_133951_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，打出後永久變化為「<DerivativeCardKeywords_141:櫻滿開>」。"
  },
  Skill_133952_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，打出後永久變化為「<DerivativeCardKeywords_142:花吹雪>」。"
  },
  Skill_133952_Name = {Text = "櫻滿開"},
  Skill_133953_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，打出後永久變化為「<DerivativeCardKeywords_143:一期一會>」。"
  },
  Skill_134007_Desc = {
    Text = "打出後，多次強制所選喚醒體釋放大招。"
  },
  Skill_134007_Name = {
    Text = "強制打出大招"
  },
  Skill_134008_Desc = {
    Text = "打出後，強制怪物打出當前意圖。"
  },
  Skill_134008_Name = {
    Text = "強制打出意圖"
  },
  Skill_134009_Desc = {
    Text = "打出後，多次強制打出手牌堆頂部的1張卡牌。"
  },
  Skill_134009_Name = {
    Text = "強制打出卡牌"
  },
  Skill_134010_Desc = {
    Text = "打出後，多次強制玩家釋放鑰令。"
  },
  Skill_134010_Name = {
    Text = "強制打出鑰令"
  },
  Skill_134203_Desc = {
    Text = "臨時暴擊傷害 +70%。"
  },
  Skill_134203_Name = {
    Text = "私密午歇時間"
  },
  Skill_134204_Desc = {
    Text = "臨時暴擊傷害 +60%。"
  },
  Skill_134204_Name = {
    Text = "私密午歇時間"
  },
  Skill_134205_Desc = {
    Text = "臨時暴擊傷害 +80%。"
  },
  Skill_134205_Name = {
    Text = "私密午歇時間"
  },
  Skill_134206_Desc = {
    Text = "臨時暴擊傷害 +50%。"
  },
  Skill_134206_Name = {
    Text = "私密午歇時間"
  },
  Skill_134210_Desc = {
    Text = "釋放所有覺醒"
  },
  Skill_134210_Name = {
    Text = "釋放所有覺醒"
  },
  Skill_134212_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2]％ 臨時傷害強效。若「阿拉克涅」在隊伍中，抽 1 張「永恆織造」並使其算力消耗 -1。"
  },
  Skill_134212_Name = {
    Text = "羅網轉輪"
  },
  Skill_134252_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後自身下一次造成的傷害翻倍。"
  },
  Skill_134252_Name_1 = {
    Text = "私密午歇時間"
  },
  Skill_138603_Desc = {
    Text = "對所有敵人造成 1% 最大生命傷害 3 次，擊碎其超維空間，清空其中卡牌。"
  },
  Skill_138603_Name = {
    Text = "命縷各安其位"
  },
  Skill_138768_Desc = {
    Text = "配置立繪的測試卡牌。"
  },
  Skill_138768_Name = {
    Text = "追擊測試"
  },
  Skill_138769_Desc = {
    Text = "用特定卡牌進行追擊，播放那張卡的卡面。"
  },
  Skill_138769_Name = {
    Text = "追擊測試"
  },
  Skill_138810_AwakerSkillBackgroundStory = {
    Text = "外貌更重要，或靈魂更重要？有答案，沒有答案？\n在愛中掙扎的人如此迷茫著，將被捲入的犧牲品們，用滿懷珍惜的心情，吞噬殆盡。"
  },
  Skill_138810_BattleDesc_0 = {
    Text = "失去 10%([Arg4]) 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>。棄掉所有指令卡，抽取相同數量( [Arg3] )張牌。"
  },
  Skill_138810_BattleDesc_1 = {
    Text = "失去 10%([Arg4]) 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>。棄掉所有指令卡，抽取相同數量( [Arg3] )張牌。"
  },
  Skill_138810_BattleDesc_3 = {
    Text = "失去 10%([Arg4]) 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>，額外施加目標 0.5％ 最大生命值的<Corrosion:侵蝕>。棄掉所有指令卡，抽取 [Arg3] 張牌。"
  },
  Skill_138810_Desc_0 = {
    Text = "失去 10% 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>。棄掉所有指令卡，抽取相同數量的牌。"
  },
  Skill_138810_Desc_1 = {
    Text = "失去 10% 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>。棄掉所有指令卡，抽取相同數量的牌。"
  },
  Skill_138810_Desc_3 = {
    Text = "失去 10% 當前生命，對所有敵人造成 [Corrosion:Arg1] 點<Corrosion:侵蝕>，額外施加目標 0.5％ 最大生命的<Corrosion:侵蝕>。棄掉所有指令卡，抽取相同數量的牌。"
  },
  Skill_138810_EffectNameList = {Text = "侵蝕"},
  Skill_138810_Name = {
    Text = "肉脂爛漫"
  },
  Skill_138810_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_139862_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 2 張「技能」並賦予<ErosionColorInkKeywords:認知錯亂>。若沙耶在隊伍中，獲得 1 層<KaiHuajishu:羽種>。"
  },
  Skill_139862_Name = {
    Text = "獻給新世界"
  },
  Skill_140120_Desc_1 = {
    Text = "使一名目標獲得 命途，依此諭示。"
  },
  Skill_140120_Name_1 = {
    Text = "命途，依此諭示"
  },
  Skill_140144_Desc_1 = {
    Text = "使一名目標獲得 <ReinforceKeywords:痴醉>。"
  },
  Skill_140144_Name_1 = {Text = "癡醉"},
  Skill_140457_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和任意喚醒體釋放「狂氣爆發」後，自身獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_140566_Desc = {
    Text = "打出後，獲得測試用聖女作成（帶30奇點信標）、測試用同伴的力量。"
  },
  Skill_140567_Desc = {
    Text = "打出後，獲得測試用聖女作成、測試用同伴的力量（帶30奇點信標）。"
  },
  Skill_140592_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆隨機 2 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140598_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使抽牌堆隨機 1 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使抽牌堆隨機 1 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140601_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使抽牌堆隨機 3 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140604_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>，使抽牌堆隨機 1 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使抽牌堆隨機 1 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<WeaknessIconKeywords:虛弱>，使抽牌堆隨機 1 張牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_140665_Desc = {
    Text = "獲得臨時<SingularityKeywords2:奇點稜鏡>並對生命最低敵人造成<CutKeywords:命運裁斷>。"
  },
  Skill_140665_Name = {
    Text = "無盡線縷"
  },
  Skill_140666_Desc_1 = {
    Text = "使一名目標獲得 認知錯亂。"
  },
  Skill_140666_Name_1 = {
    Text = "認知錯亂"
  },
  Skill_140680_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] <MaxHPKeywords:最大生命值>，回合結束時回復 <Heal:[Heal:Arg2]> 生命，回復生命隨裝備者生命降低而提高，最多提升 [Arg3]%。"
  },
  Skill_140680_Name_1 = {
    Text = "夢遊仙境"
  },
  Skill_140714_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次，獲得 1 層<HungerKeywords:飢餓>。每造成 1 次未被格擋的傷害額外獲得 1 層<HungerKeywords:飢餓>。"
  },
  Skill_140714_Name = {
    Text = "覓ｦ人良ﾋ"
  },
  Skill_140714_tempName_1 = {
    Text = "覓ｦ人良ﾋ"
  },
  Skill_140714_tempName_2 = {Text = "覓食"},
  Skill_140716_Desc = {
    Text = "驅散自身負面狀態並獲得「護食」狀態：每回合開始時獲得 1 層飢餓，造成未被格擋的傷害時獲得最大生命值 2% 點護盾，適應的最高層數提高為 75。"
  },
  Skill_140716_tempName_2 = {Text = "蛻變"},
  Skill_140717_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加等量<BleedingIconKeywords:出血>。自身最大生命值提升 5%，吞食玩家手中隨機 1 張「技能」將其消耗。"
  },
  Skill_140765_Desc = {
    Text = "切換至該意圖時，將自身的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>轉移給敵人。若成功轉移，回覆 10% 已損失生命（<Heal:[Heal:Arg3]>），獲得 1 層<HungerKeywords:飢餓>，否則造成 <Damage:[Damage:Arg1]> 點傷害並獲得 2 層<HungerKeywords:飢餓>。"
  },
  Skill_140765_Name = {Text = "應ｸkQ"},
  Skill_140765_tempName_1 = {Text = "應ｸkQ"},
  Skill_140765_tempName_2 = {Text = "應激"},
  Skill_140766_Desc = {
    Text = "切換至該意圖時，將自身的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>轉移給敵人。若成功轉移，回覆 10% 已損失生命（<Heal:[Heal:Arg3]>），獲得 1 層<HungerKeywords:飢餓>，否則造成 <Damage:[Damage:Arg1]> 點傷害並獲得 2 層<HungerKeywords:飢餓>。"
  },
  Skill_140766_Name = {Text = "應ｸkQ"},
  Skill_140766_tempName_1 = {Text = "應ｸkQ"},
  Skill_140766_tempName_2 = {Text = "應激"},
  Skill_140767_Desc = {
    Text = "切換至該意圖時，將自身的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>轉移給敵人。若成功轉移，回覆 10% 已損失生命（<Heal:[Heal:Arg3]>），獲得 1 層<HungerKeywords:飢餓>，否則造成 <Damage:[Damage:Arg1]> 點傷害並獲得 2 層<HungerKeywords:飢餓>。"
  },
  Skill_140767_Name = {Text = "應ｸkQ"},
  Skill_140767_tempName_1 = {Text = "應ｸkQ"},
  Skill_140767_tempName_2 = {Text = "應激"},
  Skill_140829_Desc = {
    Text = "臨時最終傷害 +[Arg1]%，並對所有敵人造成 [Arg2]% 最大生命值的侵蝕。"
  },
  Skill_140829_Name = {Text = "獵取"},
  Skill_140830_Desc = {
    Text = "選擇<Pangtuosihuodong_Defend:「護衛」>或<Pangtuosihuodong_Attack:「獵取」>。"
  },
  Skill_140830_Name = {Text = "馭魘"},
  Skill_140831_Desc = {
    Text = "所有敵人本回合造成的傷害降低 [Arg1]%，獲得 [Arg2] 點力量。"
  },
  Skill_140831_Name = {Text = "護衛"},
  Skill_140849_Desc = {
    Text = "裝備者獲得 <Energy:[Arg1]> 點狂氣與<Yishiganshe:「意識干涉」>。"
  },
  Skill_140849_Name = {
    Text = "夢遊仙境"
  },
  Skill_140850_Desc = {
    Text = "裝備者獲得 <Energy:[Arg1]> 點狂氣與<Yishiganshe:「意識干涉」>。"
  },
  Skill_140850_Name = {
    Text = "夢遊仙境"
  },
  Skill_140851_Desc = {
    Text = "裝備者獲得 <Energy:[Arg1]> 點狂氣與<Yishiganshe:「意識干涉」>。"
  },
  Skill_140851_Name = {
    Text = "夢遊仙境"
  },
  Skill_140852_Desc = {
    Text = "裝備者獲得 <Energy:[Arg1]> 點狂氣與<Yishiganshe:「意識干涉」>。"
  },
  Skill_140852_Name = {
    Text = "夢遊仙境"
  },
  Skill_141020_Desc_1 = {
    Text = "添加一個測試用的狀態。"
  },
  Skill_141020_Name_1 = {
    Text = "添加狀態"
  },
  Skill_141058_AwakerSkillBackgroundStory = {
    Text = "極致的好奇心和極強的學習能力，使沙耶在模仿人類的過程中，獲得了與人類少女過於相似的靈魂。\n她因此變得更加孤獨，也為此變得無比幸福。"
  },
  Skill_141058_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。獲得 1 層<KaiHuajishu:羽種>。"
  },
  Skill_141058_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，當前生命越低效果越高，至多提高 100%。獲得 1 層<KaiHuajishu:羽種>。"
  },
  Skill_141058_Name = {
    Text = "生物擬態"
  },
  Skill_141947_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備和回合結束時，<PVPDiscoveryKeyWords:發現> [Arg1] 張附加<PVPVoidKeywords:虛無>的「技能」並置入手中。"
  },
  Skill_141947_Name_1 = {
    Text = "向上墜落"
  },
  Skill_142022_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。移除自身負面狀態，並獲得「聖潔之翼」：永久使自身回合所受傷害降低 10%。"
  },
  Skill_142022_Name = {
    Text = "聖潔之翼"
  },
  Skill_142023_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142023_Name = {
    Text = "四翼漸生"
  },
  Skill_142024_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 3 層<ResentChainsKeywords:怨恨鎖鏈>。切換至該意圖時，封印一名狂氣最高喚醒體的狂氣爆發和所有指令卡 1 回合。"
  },
  Skill_142024_Name = {
    Text = "四翼漸生-封鎖"
  },
  Skill_142025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。所有喚醒體當前狂氣減半。"
  },
  Skill_142025_Name = {
    Text = "四翼漸生-冷寂"
  },
  Skill_142026_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_142027_Desc = {
    Text = "將 1 張「融蝕之芯」置入抽牌堆。使自身的技能獲得強化。"
  },
  Skill_142027_Name = {
    Text = "門扉洞開"
  },
  Skill_142028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<HeavyInjuryKeywords:重創>。切換至該意圖時，施加 1 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_142028_Name = {
    Text = "雙翼初展-重創"
  },
  Skill_142029_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_142029_Name = {
    Text = "雙翼初展-虛弱"
  },
  Skill_142030_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142030_Name = {
    Text = "雙翼初張"
  },
  Skill_142031_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142031_Name = {
    Text = "六翼滿開"
  },
  Skill_142032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_142032_Name = {
    Text = "雙翼初展-重創"
  },
  Skill_142033_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。移除敵方 50% 的永久力量、永久反擊、永久觸腕傷害，並造成「詛咒之翼」：永久使造成的力量、反擊、觸腕傷害降低 10%。"
  },
  Skill_142033_Name = {
    Text = "詛咒之翼"
  },
  Skill_142034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142034_Name = {
    Text = "六翼滿開"
  },
  Skill_142035_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對各處指令卡中的半數施加 1 層<SlowIconKeywords:遲緩>。切換至該意圖時，對手牌中的半數指令卡施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_142035_Name = {
    Text = "四翼漸生-遲緩"
  },
  Skill_142036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<WeaknessIconKeywords:虛弱>。切換至該意圖時，施加 1 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_142036_Name = {
    Text = "雙翼初展-虛弱"
  },
  Skill_142037_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<FragileIconKeywords:脆弱>。"
  },
  Skill_142037_Name = {
    Text = "雙翼初展-脆弱"
  },
  Skill_142038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對生命越低的敵人傷害越高，最多提升 100%。"
  },
  Skill_142038_Name = {
    Text = "六翼全開-彌留低語"
  },
  Skill_142039_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<FragileIconKeywords:脆弱>。切換至該意圖時，施加 1 層<FragileIconKeywords:脆弱>。"
  },
  Skill_142039_Name = {
    Text = "雙翼初展-脆弱"
  },
  Skill_142040_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。移除敵方 25% 的當前傷害強效，並造成「衰弱之翼」：永久使造成的基礎傷害、中毒、反擊降低 10%。"
  },
  Skill_142040_Name = {
    Text = "污穢之翼"
  },
  Skill_142041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 3 層<ResentChainsKeywords:怨恨鎖鏈>。"
  },
  Skill_142041_Name = {
    Text = "四翼漸生-封鎖"
  },
  Skill_142042_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每段額外造成目標當前生命 5% 傷害。"
  },
  Skill_142042_Name = {
    Text = "六翼全開-盈星之隕"
  },
  Skill_142043_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142043_Name = {
    Text = "雙翼初張"
  },
  Skill_142044_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每段額外造成目標當前生命 5% 傷害。 切換至該意圖時，本回合免疫負面狀態。"
  },
  Skill_142044_Name = {
    Text = "六翼全開-盈星之隕"
  },
  Skill_142045_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對各處指令卡中的半數施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_142045_Name = {
    Text = "四翼漸生-遲緩"
  },
  Skill_142046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對生命值越低的敵人傷害越高，最多提升 100%。切換至該意圖時，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_142046_Name = {
    Text = "六翼全開-彌留低語"
  },
  Skill_142047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。傷害提升 100%，但本回合自身每受到 2% 最大生命值的傷害該效果就降低 10%，最多降低 50%。"
  },
  Skill_142047_Name = {
    Text = "六翼全開-二重啟示"
  },
  Skill_142048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。所有喚醒體當前狂氣減半。切換至該意圖時，所有喚醒體失去 25 點狂氣。"
  },
  Skill_142048_Name = {
    Text = "四翼漸生-冷寂"
  },
  Skill_142049_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。傷害提升 100%，但本回合自身每受到 2% 最大生命值的傷害該效果就降低 10%，最多降低 50%。  切換至該意圖時，獲得最大生命值 10% 的護盾。"
  },
  Skill_142049_Name = {
    Text = "六翼全開-二重啟示"
  },
  Skill_142050_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_142050_Name = {
    Text = "四翼漸生"
  },
  Skill_142449_Desc_1 = {
    Text = "是什麼呢？"
  },
  Skill_142449_Name_1 = {Text = "寶藏"},
  Skill_142449_UnknownName = {Text = "寶藏"},
  Skill_142686_Desc_1 = {
    Text = "讓目標命輪永久失效，再次使用解除。"
  },
  Skill_142686_Name_1 = {
    Text = "超級纏繞"
  },
  Skill_142689_Desc_1 = {
    Text = "給目標裝備一個命輪。"
  },
  Skill_142689_Name_1 = {
    Text = "裝備命輪"
  },
  Skill_142695_AwakerSkillBackgroundStory = {
    Text = "他留住了所有至親至愛最鮮活有趣的部分，他給予所有敵人最慘烈漫長的折磨。\n每個觥籌交錯的夜晚，他大笑著落入一片空軀殼組成的海洋。"
  },
  Skill_142695_BattleDesc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg2]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg3] )，若將其擊殺生成 1 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。"
  },
  Skill_142695_Desc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg8] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg2]％ 觸腕傷害的<RealDamage:固定傷害>，若將其擊殺生成 1 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。"
  },
  Skill_142695_EffectNameList = {
    Text = "臨時力量降低,觸腕傷害加成,囚魘等級"
  },
  Skill_142695_Name = {
    Text = "無休獵宴"
  },
  Skill_142695_OverLimitUtlSkillDesc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg6]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg7] )，若將其擊殺生成 2 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。使各處「囚魘」算力消耗 -1。"
  },
  Skill_142695_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,$GrowValue3"
  },
  Skill_142695_tempBattleDesc_1 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg2]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg3] )，若將其擊殺生成 1 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。"
  },
  Skill_142695_tempBattleDesc_2 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg2]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg3] )，若將其擊殺生成 1 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。獲得 [Arg5] 層<BattueKeywords:圍獵>。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_1 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg6]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg7] )，若將其擊殺生成 2 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。使各處「囚魘」算力消耗 -1。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_2 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。對生命最低的敵人造成等同於 [Arg6]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg7] )，若將其擊殺生成 2 張永久「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每場戰鬥最多生成 3 張永久「囚魘」。使各處「囚魘」算力消耗 -1。獲得 [Arg5] 層<BattueKeywords:圍獵>。"
  },
  Skill_142696_AwakerSkillBackgroundStory = {
    Text = "「向我祈禱，我會給予你如願的死亡。」"
  },
  Skill_142696_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_142696_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次使用時，抽 1 張「囚魘」( [Arg3]/1 )。"
  },
  Skill_142696_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。龐托斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_142696_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。龐托斯獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次使用時，抽 1 張「囚魘」。"
  },
  Skill_142696_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_142696_Name = {Text = "打擊"},
  Skill_142696_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_142699_AwakerSkillBackgroundStory = {
    Text = "「在厄波揚斯酣睡，在厄波揚斯痛飲，在那亙久的、古老的，深淵之源。」"
  },
  Skill_142699_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_142699_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次使用時，抽 1 張「囚魘」( [Arg3]/1 )。"
  },
  Skill_142699_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。龐托斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_142699_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。龐托斯獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次使用時，抽 1 張「囚魘」。"
  },
  Skill_142699_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_142699_Name = {Text = "防禦"},
  Skill_142699_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_142700_AwakerSkillBackgroundStory = {
    Text = "「你想要什麼？」\n力量、秩序、失而復得、以血洗仇……\n他陷入長久而陰沉的緘默，可他其實早就有了答案，一個無解的答案。\n他想要太陽東升西落，他要一切如常。"
  },
  Skill_142700_BattleDesc_0 = {
    Text = "龐托斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：牌庫中每有 3 張「囚魘」，「無休獵宴」就額外獲得 1 層<BattueKeywords:圍獵>。每打出 1 張龐托斯的卡牌，下次「無休獵宴」臨時力量降低效果提高 [Arg3]％，每回合至多觸發 3 次。"
  },
  Skill_142700_BattleDesc_15 = {
    Text = "龐托斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：牌庫中每有 2 張「囚魘」，「無休獵宴」就額外獲得 1 層<BattueKeywords:圍獵>。每打出 1 張龐托斯的卡牌，下次「無休獵宴」臨時力量降低效果提高 [Arg3]％，每回合至多觸發 3 次。每回合首次「打擊」和首次「防禦」額外獲得 <Energy:[Energy:Arg4]> 點狂氣"
  },
  Skill_142700_Desc_0 = {
    Text = "龐托斯獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：牌庫中每有 3 張「囚魘」，「無休獵宴」就獲得 1 層<BattueKeywords:圍獵>。每打出 1 張龐托斯的卡牌，下次「無休獵宴」臨時力量降低效果提高 [Arg3]％，每回合至多觸發 3 次。"
  },
  Skill_142700_Desc_15 = {
    Text = "龐托斯獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：牌庫中每有 2 張「囚魘」，「無休獵宴」就獲得 1 層<BattueKeywords:圍獵>。每打出 1 張龐托斯的卡牌，下次「無休獵宴」臨時力量降低效果提高 [Arg3]％，每回合至多觸發 3 次。每回合首次「打擊」和首次「防禦」額外獲得 <Energy:[Energy:Arg4]> 點狂氣"
  },
  Skill_142700_EffectNameList = {Text = "狂氣"},
  Skill_142700_Name = {
    Text = "沉淵的怒仇"
  },
  Skill_142802_Desc = {
    Text = "裝備者獲得 <Yellow:[Arg1]> 點固定狂氣並移除各處指令卡的<ErosionColorInkKeywords:認知錯亂>效果。"
  },
  Skill_142802_Name = {
    Text = "向上墜落"
  },
  Skill_142803_BattleDesc = {
    Text = "對所有敵人造成 [Arg1] 點以及其最大生命值 1% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace24:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142803_Desc = {
    Text = "對所有敵人造成裝備者攻擊力 3000% 以及其最大生命值 1% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace24:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142803_Name = {
    Text = "涉足人間"
  },
  Skill_142804_Desc = {
    Text = "裝備者獲得 <Yellow:[Arg1]> 點固定狂氣並移除各處指令卡的<ErosionColorInkKeywords:認知錯亂>效果。"
  },
  Skill_142804_Name = {
    Text = "向上墜落"
  },
  Skill_142805_Desc = {
    Text = "裝備者獲得 <Yellow:[Arg1]> 點固定狂氣並移除各處指令卡的<ErosionColorInkKeywords:認知錯亂>效果。"
  },
  Skill_142805_Name = {
    Text = "向上墜落"
  },
  Skill_142806_BattleDesc = {
    Text = "對所有敵人造成 [Arg1] 點以及其最大生命值 0.4% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace21:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142806_Desc = {
    Text = "對所有敵人造成裝備者攻擊力 1500% 以及其最大生命值 0.4% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace21:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142806_Name = {
    Text = "涉足人間"
  },
  Skill_142807_Desc = {
    Text = "裝備者獲得 <Yellow:[Arg1]> 點固定狂氣並移除各處指令卡的<ErosionColorInkKeywords:認知錯亂>效果。"
  },
  Skill_142807_Name = {
    Text = "向上墜落"
  },
  Skill_142808_BattleDesc = {
    Text = "對所有敵人造成 [Arg1] 點以及其最大生命值 0.8% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace23:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142808_Desc = {
    Text = "對所有敵人造成裝備者攻擊力 2500% 以及其最大生命值 0.8% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace23:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142808_Name = {
    Text = "涉足人間"
  },
  Skill_142809_BattleDesc = {
    Text = "對所有敵人造成 [Arg1] 點以及其最大生命值 0.6% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace22:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142809_Desc = {
    Text = "對所有敵人造成裝備者攻擊力 2000% 以及其最大生命值 0.6% 的固定<Corrosion:侵蝕>，使各處其他喚醒體的指令卡附加<ErosionColorInkKeywords:認知錯亂>並將 1 張<Falltospace22:「向上墜落」>洗入抽牌堆。"
  },
  Skill_142809_Name = {
    Text = "涉足人間"
  },
  Skill_142846_AwakerSkillBackgroundStory = {
    Text = "人耳與現有銀芯科技，暫時都無法從龐托斯的獵哨中獲取任何有效信息。\n但所有被厄波揚斯同化的個體，似乎都極快地適應了聽從哨音的指令。"
  },
  Skill_142846_Desc = {
    Text = "若本場戰鬥首次釋放，則生成 3 種不同的「囚魘」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中並獲得 <Block:[Block:Arg1]> 點護盾，每擁有 4 張永久囚魘使其中 1 張升級為「雙生囚魘」。否則抽 3 張「囚魘」。"
  },
  Skill_142846_EffectNameList = {
    Text = "護盾、囚魘等級"
  },
  Skill_142846_Name = {
    Text = "馭魘哨音"
  },
  Skill_142846_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_142847_AwakerSkillBackgroundStory = {
    Text = "厄波揚斯的出現頻率並不規律，其全貌亦無法被觀測。\n唯一已知的是，當那些無面生物成群結隊地出沒於天際時，一幢從窗內散射出不可名狀珠光的房屋，會矗立在某處迷霧中的懸崖之上。"
  },
  Skill_142847_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。額外生效 X 次。"
  },
  Skill_142847_BattleDesc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。額外生效 X+1 次。"
  },
  Skill_142847_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。額外生效 X 次。"
  },
  Skill_142847_Desc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。額外生效 X+1 次。"
  },
  Skill_142847_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_142847_Name = {
    Text = "縱魘掠襲"
  },
  Skill_142847_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_142874_Desc_1 = {
    Text = "對敵方造成 <Damage:[Damage:Arg1]> 傷害，損失一半傷害量的生命 或 使友方獲得 <Block:[Block:Arg2]> 護盾。抽 [Arg3] 張牌。"
  },
  Skill_142874_Name_1 = {Text = "獵魘"},
  Skill_142875_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_142875_Name_1 = {Text = "打擊"},
  Skill_142876_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，每次受到攻擊會將 [Arg1] 張<PVPDerivativeCardKeywords_30:「獵魘」>置入手牌。"
  },
  Skill_142876_Name_1 = {
    Text = "領主之儀"
  },
  Skill_142877_Desc_1 = {
    Text = "選擇任意其他目標，若為友方，自身和友方獲得 <Block:[Block:Arg1]> 護盾，下回合開始前，為其分擔所受一半傷害；若為敵方，下回合開始前，轉嫁所受一半傷害。"
  },
  Skill_142877_Name_1 = {
    Text = "無休獵宴"
  },
  Skill_142878_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，若目標狂氣小於 [Arg2] ，則傷害翻倍，否則造成<PVPEmptinessKeywords:空虛>。"
  },
  Skill_142878_Name_1 = {
    Text = "追獵藝術"
  },
  Skill_142879_Desc_1 = {
    Text = "將 [Arg1] 張<PVPDerivativeCardKeywords_30:「獵魘」>置入抽牌堆，抽 [Arg2] 張牌。"
  },
  Skill_142879_Name_1 = {Text = "馭魘者"},
  Skill_142958_Desc_1 = {
    Text = "指定友方獲得 <Block:[Block:Arg1]> 護盾，<PVPGrowthKeywords:成長> -[Arg2]，護盾效果歸零後改為抽 [Arg3] 牌。"
  },
  Skill_142960_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142960_Name_1 = {
    Text = "蘭提戈斯專武(臨時文本)"
  },
  Skill_142961_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前損失 25% 當前生命；「狂氣爆發」後對全體敵方造成 [Arg1] 傷害並汲取等量生命。"
  },
  Skill_142961_Name_1 = {
    Text = "蜜果的謊言"
  },
  Skill_142962_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142962_Name_1 = {
    Text = "撒托古亞SR(臨時文本)"
  },
  Skill_142963_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142963_Name_1 = {
    Text = "禿鷲SR(臨時文本)"
  },
  Skill_142964_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142964_Name_1 = {
    Text = "亞弗戈蒙SR(臨時文本)"
  },
  Skill_142965_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142965_Name_1 = {
    Text = "夏塔克鳥專武(臨時文本)"
  },
  Skill_142966_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，對隨機的敵方施加 [Arg1] 層<PVPCompassKeywords:指向歧路的羅盤>。"
  },
  Skill_142966_Name_1 = {
    Text = "指向歧路的羅盤"
  },
  Skill_142967_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142967_Name_1 = {
    Text = "禿鷲專武(臨時文本)"
  },
  Skill_142968_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142968_Name_1 = {
    Text = "黑法老SR(臨時文本)"
  },
  Skill_142969_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142969_Name_1 = {
    Text = "本源奧吉爾專武(臨時文本)"
  },
  Skill_142970_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142970_Name_1 = {
    Text = "黑法老專武(臨時文本)"
  },
  Skill_142971_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限+ [Arg1] ，裝備者或友方死亡時，其卡牌不再轉換為<PVPDerivativeCardKeywords_2:「幻象」>，而是轉換為<PVPDerivativeCardKeywords_30:「獵魘」>。"
  },
  Skill_142971_Name_1 = {Text = "活囚籠"},
  Skill_142972_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142972_Name_1 = {
    Text = "本源奧吉爾SR(臨時文本)"
  },
  Skill_142973_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142973_Name_1 = {
    Text = "本源圖魯SR(臨時文本)"
  },
  Skill_142975_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142975_Name_1 = {
    Text = "撒托古亞專武(臨時文本)"
  },
  Skill_142977_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142977_Name_1 = {
    Text = "蘭提戈斯SR(臨時文本)"
  },
  Skill_142978_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使敵方全體施加 [Arg1] 層<PVPBless:賜福>。"
  },
  Skill_142980_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142980_Name_1 = {
    Text = "夏塔克鳥SR(臨時文本)"
  },
  Skill_142981_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_142981_Name_1 = {
    Text = "亞弗戈蒙專武(臨時文本)"
  },
  Skill_143024_Desc_1 = {
    Text = "選擇友方位置1或位置2或敵方，不忽略機制。"
  },
  Skill_143024_Name_1 = {
    Text = "目標測試4"
  },
  Skill_143025_Desc_1 = {
    Text = "選擇友方或敵方，忽略敵方的嘲諷。"
  },
  Skill_143025_Name_1 = {
    Text = "目標測試2"
  },
  Skill_143026_Desc_1 = {
    Text = "選擇友方位置1或位置2或敵方，忽略敵方的潛行。"
  },
  Skill_143026_Name_1 = {
    Text = "目標測試3"
  },
  Skill_143027_Desc_1 = {
    Text = "選擇友方或敵方，忽略敵方的潛行和嘲諷。"
  },
  Skill_143027_Name_1 = {
    Text = "目標測試1"
  },
  Skill_143028_Desc_1 = {
    Text = "獲得目標測試所需的卡牌。"
  },
  Skill_143028_Name_1 = {
    Text = "目標測試"
  },
  Skill_143392_Desc_1 = {
    Text = "使一個喚醒體生命歸零。"
  },
  Skill_143392_Name_1 = {
    Text = "生命歸零"
  },
  Skill_143432_Desc = {
    Text = "增加1點算力消耗"
  },
  Skill_143432_Name = {
    Text = "增加1點算力消耗"
  },
  Skill_143433_Desc = {
    Text = "恆定算力1"
  },
  Skill_143433_Name = {
    Text = "恆定算力1"
  },
  Skill_143434_Desc = {
    Text = "恆定算力5"
  },
  Skill_143434_Name = {
    Text = "恆定算力5"
  },
  Skill_143443_Desc = {
    Text = "按條件選擇喚醒體"
  },
  Skill_143443_Name = {
    Text = "接口測試"
  },
  Skill_143494_Desc_1 = {
    Text = "免疫純粹傷害，二次釋放解除。"
  },
  Skill_143494_Name_1 = {
    Text = "免疫純粹傷害"
  },
  Skill_143495_Desc_1 = {
    Text = "免疫主動傷害，二次釋放解除。"
  },
  Skill_143495_Name_1 = {
    Text = "免疫主動傷害"
  },
  Skill_143556_Desc = {
    Text = "囚魘測試"
  },
  Skill_143556_Name = {
    Text = "囚魘測試"
  },
  Skill_143557_Desc_0 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_143557_Desc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。<RippleKeywords:餘波>：算力消耗 -1。"
  },
  Skill_143557_Name = {
    Text = "滋擾之魘"
  },
  Skill_143557_tempName_1 = {
    Text = "滋擾之魘"
  },
  Skill_143557_tempName_2 = {
    Text = "雙生·滋擾之魘"
  },
  Skill_143558_BattleDesc_0 = {
    Text = "對生命最低敵人造成等同於 [Arg1]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg2] )。獲得等同於龐托斯基礎暴擊傷害 [Arg3]% 的臨時暴擊傷害( [Arg4]％ )。"
  },
  Skill_143558_BattleDesc_3 = {
    Text = "對生命最低敵人造成等同於 [Arg1]％ 觸腕傷害的<RealDamage:固定傷害>( [Arg2] )。獲得等同於龐托斯基礎暴擊傷害 [Arg3]% 的臨時暴擊傷害( [Arg4]％ )。<RippleKeywords:餘波>：算力消耗 -1。"
  },
  Skill_143558_Desc_0 = {
    Text = "對生命最低敵人造成等同於 [Arg5]％ 觸腕傷害的<RealDamage:固定傷害>。獲得等同於龐托斯基礎暴擊傷害 [Arg3]% 的臨時暴擊傷害。"
  },
  Skill_143558_Desc_3 = {
    Text = "對生命最低敵人造成等同於 [Arg5]％ 觸腕傷害的<RealDamage:固定傷害>。獲得等同於龐托斯基礎暴擊傷害 [Arg3]% 的臨時暴擊傷害。<RippleKeywords:餘波>：算力消耗 -1。"
  },
  Skill_143558_Name = {
    Text = "獵殺之魘"
  },
  Skill_143558_tempName_1 = {
    Text = "獵殺之魘"
  },
  Skill_143558_tempName_2 = {
    Text = "雙生·獵殺之魘"
  },
  Skill_143559_Desc_0 = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆，其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_143559_Desc_3 = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆，其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。<RippleKeywords:餘波>：算力消耗 -1。"
  },
  Skill_143559_Name = {
    Text = "擄掠之魘"
  },
  Skill_143559_tempName_1 = {
    Text = "擄掠之魘"
  },
  Skill_143559_tempName_2 = {
    Text = "雙生·擄掠之魘"
  },
  Skill_143604_Desc = {
    Text = "臨時暴擊傷害 +[Arg1]％，臨時降低所有敵人 [Arg2] 點<ExhaustionIconKeywords:力量>。若龐托斯在隊伍中，獲得 1 層<BattueKeywords:圍獵>。"
  },
  Skill_143686_Desc = {
    Text = "囚魘測試2"
  },
  Skill_143686_Name = {
    Text = "囚魘測試2"
  },
  Skill_143687_Desc = {
    Text = "玩家沒虛弱則卡面為普通胚胎，有則聖胎"
  },
  Skill_143687_Name = {
    Text = "卡面條件表達式測試"
  },
  Skill_144438_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：友方死亡時，自身獲得 <Energy:[Energy:Arg1]> 狂氣。友方復活時，其獲得 <Energy:[Energy:Arg2]> 狂氣。獲得狂氣效果僅在目標狂氣不滿時生效，最多生效 [Arg8] 次，次數耗盡後銷毀該命輪。"
  },
  Skill_144438_Name_1 = {
    Text = "魂靈同調"
  },
  Skill_144486_AwakerSkillBackgroundStory = {
    Text = "仙女和巫師是在鄉鎮一角的荒僻空地上相遇的。\n那時她在笑意盈盈地招徠衣著華美的異鄉孩童，巫師則不動聲色地盯上了母親手腕上叮噹的金鐲。\n二人的目光在空中一碰，瞬間了悟彼此的意圖。\n這場無聲的角逐，最終巫師技高一籌，憑藉老道經驗險勝收尾。\n但一樁嶄新的、坑蒙拐騙的美好事業，也就此拉開了序幕。"
  },
  Skill_144486_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 1 層<WormGrowth1:飽餐>。每次造成傷害對目標施加 [Corrosion:Arg10] 點<Corrosion:侵蝕>。】驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg8] 次。每有 1 層<WormGrowth1:飽餐>狂氣爆發基礎傷害與護盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每層使傷害次數 +1，並獲得<WormGrowth1:飽餐>。當前<WormGrowth1:飽餐>層數：[Arg9]，本場戰鬥疊加層數：[Arg11]"
  },
  Skill_144486_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 1 層<WormGrowth2:飽餐>，每次造成傷害對目標施加 [Corrosion:Arg10] 點<Corrosion:侵蝕>。】驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg8] 次。每有 1 層<WormGrowth2:飽餐>狂氣爆發基礎傷害與護盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每層使傷害次數 +1，並獲得<WormGrowth2:飽餐>。當前<WormGrowth2:飽餐>層數：[Arg9]，本場戰鬥疊加層數：[Arg11]"
  },
  Skill_144486_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 1 層<WormGrowth1:飽餐>。每次造成傷害對目標施加 [Corrosion:Arg10] 點<Corrosion:侵蝕>。】驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg8] 次。每有 1 層<WormGrowth1:飽餐>狂氣爆發基礎傷害與護盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每層使傷害次數 +1，並獲得<WormGrowth1:飽餐>。"
  },
  Skill_144486_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 1 層<WormGrowth2:飽餐>，每次造成傷害對目標施加 [Corrosion:Arg10] 點<Corrosion:侵蝕>。】驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg8] 次。每有 1 層<WormGrowth2:飽餐>狂氣爆發基礎傷害與護盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每層使傷害次數 +1，並獲得<WormGrowth2:飽餐>。"
  },
  Skill_144486_EffectNameList = {
    Text = "護盾、傷害、吞噬侵蝕"
  },
  Skill_144486_Name = {
    Text = "叮咚★仙女駕到"
  },
  Skill_144486_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 1 層<WormGrowth2:飽餐>。每次造成傷害對目標施加 [Corrosion:Arg10] 點<Corrosion:侵蝕>】驅散所有手中卡牌的<BurningKeywords2:燃燒>狀態。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg8] 次。每有 1 層<WormGrowth2:飽餐>狂氣爆發基礎傷害與護盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每層使傷害次數 +1，並獲得<WormGrowth2:飽餐>。<FaxianKeywords:發現> 2 組<Blessing:禮物>不同的<DerivativeCardKeywords_152:「賜福」>，每組包含 2 張，選擇 1 組置入手中。  使所有敵人永久降低 [Exhaustion:Arg12] 點<ExhaustionIconKeywords:力量>。當前<WormGrowth2:飽餐>層數：[Arg9]。本場戰鬥疊加層數：[Arg11]"
  },
  Skill_144486_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_144487_AwakerSkillBackgroundStory = {
    Text = "每逢降雪將至的清朗夜晚，卡拉布都會爬上煙囪旁，靜靜地仰望晦暗的天空。\n魔法棒指向天際，劃出她自行創作的咒文。\n然後飄落的粉雪，又會將她帶回曾經交付靈魂的雪夜。\n「看啊，這就是我的魔法。」"
  },
  Skill_144487_Desc_0 = {
    Text = "對生命最高敵人造成 [Arg1] 點<RealDamage:固定傷害>。施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_144487_Desc_1 = {
    Text = "對生命最高敵人造成 [Arg1] 點<RealDamage:固定傷害>。施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_144487_EffectNameList = {Text = "傷害"},
  Skill_144487_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_144487_tempBattleDesc_1 = {
    Text = "對生命最高敵人造成 [Arg1] 點<RealDamage:固定傷害> [Arg4] 次。施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_144487_tempBattleDesc_2 = {
    Text = "對生命最高敵人造成 [Arg1] 點<RealDamage:固定傷害> [Arg4] 次。施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_144487_tempBattleDesc_3 = {
    Text = "對全體敵方造成 [Arg1] 點<RealDamage:固定傷害> [Arg4] 次並對其施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_144487_tempBattleDesc_4 = {
    Text = "對全體敵方造成 [Arg1] 點<RealDamage:固定傷害> [Arg4] 次並對其施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_144488_AwakerSkillBackgroundStory = {
    Text = "「本仙女來保護你！超級防禦魔法可以抵禦一切攻擊！」"
  },
  Skill_144488_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144488_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。每第 [Arg3] / 7 次打出「打擊」或「防禦」時，獲得 1 層<SacrificialMark1:供奉>，並<FaxianKeywords:發現> [Arg4] 張<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，選擇 1 張置入手中。"
  },
  Skill_144488_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。卡拉布獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144488_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。卡拉布獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144488_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_144488_Name = {Text = "防禦"},
  Skill_144488_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_144489_BattleDesc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_144489_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_144489_Name = {
    Text = "瞬發賜福·算力"
  },
  Skill_144490_AwakerSkillBackgroundStory = {
    Text = "「本仙女出手了哦！超級攻擊魔法可以打破所有護盾！」"
  },
  Skill_144490_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144490_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。每第 [Arg3] / 7 次打出「打擊」或「防禦」時，獲得 1 層<SacrificialMark1:供奉>，並<FaxianKeywords:發現> [Arg4] 張<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，選擇 1 張置入手中。"
  },
  Skill_144490_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。卡拉布獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144490_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。卡拉布獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_144490_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_144490_Name = {Text = "打擊"},
  Skill_144490_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_144491_AwakerSkillBackgroundStory = {
    Text = "貪婪是人性的本色。\n沒有人能拒絕糖分的誘惑，即使是仙女教母本人也不例外。\n卡拉布咧開嘴笑起來，露出一口黑漆漆的尖牙。"
  },
  Skill_144491_BattleDesc_0 = {
    Text = "卡拉布獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，使下一次「奇蹟賜福」算力消耗 -3，每個<FaxianKeywords:發現> 選項額外包含 1 張<DerivativeCardKeywords_152:「賜福」>，選擇 1 組置入抽牌堆。"
  },
  Skill_144491_BattleDesc_15 = {
    Text = "卡拉布獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，使下一次「奇蹟賜福」算力消耗 -3，每個<FaxianKeywords:發現> 選項額外包含 2 張<DerivativeCardKeywords_152:「賜福」>，選擇 1 組置入抽牌堆。打出「賜福」後，胚胎融合 +10，當前生命越低則效果越高，至多提高 100%。"
  },
  Skill_144491_Desc_0 = {
    Text = "卡拉布獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，使下一次「奇蹟賜福」算力消耗 -3，每個<FaxianKeywords:發現> 選項額外包含 1 張<DerivativeCardKeywords_152:「賜福」>，選擇 1 組置入抽牌堆。"
  },
  Skill_144491_Desc_15 = {
    Text = "卡拉布獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：使用「猩紅熔爐」後，使下一次「奇蹟賜福」算力消耗 -3，每個<FaxianKeywords:發現> 選項額外包含 2 張<DerivativeCardKeywords_152:「賜福」>，選擇 1 組置入抽牌堆。打出<Blessing:賜福>後，胚胎融合 +10，當前生命越低則效果越高，至多提高 100%。"
  },
  Skill_144491_EffectNameList = {Text = "狂氣"},
  Skill_144491_Name = {
    Text = "誘人蜜果"
  },
  Skill_144492_AwakerSkillBackgroundStory = {
    Text = "「想要無盡的財寶嗎？」\n「想要無限的權力嗎？」\n「想要起死回生的神藥嗎？」\n「想要洞悉人心的水晶球嗎？」\n「想要讓愛人回心轉意的符咒嗎？」\n「想要能回答一切問題的魔鏡嗎？」\n「想要讓所有慾望即刻滿足的蜜果嗎？」\n只要你許下心願，這裡什麼都有。\n現在，展示你的誠意，向仙女教母獻上供奉吧！\n奇蹟降至，請靜候3秒！\n3、2、1——溜之大吉！"
  },
  Skill_144492_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> [Arg2] 張<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，選擇 [Arg3] 張置入抽牌堆。"
  },
  Skill_144492_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> [Arg2] 張<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，選擇 [Arg3] 張置入抽牌堆。"
  },
  Skill_144492_EffectNameList = {
    Text = "護盾、力量、臨時力量降低、固定狂氣、銀鑰能量、臨時傷害強效"
  },
  Skill_144492_Name = {
    Text = "奇蹟賜福"
  },
  Skill_144492_PropertyNameList = {
    Text = "防禦力*GrowValue1、攻擊力*GrowValue2、防禦力*GrowValue3、$GrowValue4、$GrowValue5、$GrowValue6％"
  },
  Skill_144492_tempBattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> [Arg2] 張<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，選擇 [Arg3] 張置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> 2 組<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，每組包含 2 張，選擇 1 組置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> 3 組<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，每組包含 2 張，選擇 1 組置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_4 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> 2 組<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，每組包含 3 張，選擇 1 組置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_5 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<FaxianKeywords:發現> 3 組<BlessingNegativeEffect:代價>不同的<DerivativeCardKeywords_152:「賜福」>，每組包含 3 張，選擇 1 組置入抽牌堆。"
  },
  Skill_144512_Name = {
    Text = "測試標題名2"
  },
  Skill_144513_Name = {
    Text = "測試標題名3"
  },
  Skill_144514_Desc = {
    Text = "打出後進行鑰令包3選1、每個包內含有3個鑰令。選中後直接依次釋放。"
  },
  Skill_144514_Name = {
    Text = "鑰令包3選1"
  },
  Skill_144515_Name = {
    Text = "測試標題名1"
  },
  Skill_145386_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>，「打擊」傷害提升 [Arg1]% 並改為<PVPPunctureDamagewords:穿刺傷害>。"
  },
  Skill_145386_Name_1 = {Text = "天之隕"},
  Skill_145387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提升 [Arg1]% ，每次「打擊」後傷害額外提升 [Arg2]% ，最多提升至 [Arg3]% 。"
  },
  Skill_145387_Name_1 = {
    Text = "不滅的飢骨"
  },
  Skill_145439_BattleDesc = {
    Text = "獲得 1 點算力。保留：積攢 <Green:[Arg1]> 點固定生命回覆量與 <Yellow:[Arg2]> 點固定狂氣(已積攢 <Green:[Arg3]> 生命回覆量，<Yellow:[Arg4]> 點狂氣)。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145439_Desc = {
    Text = "獲得 1 點算力。保留：積攢裝備者體質 5% 的固定生命回覆量與 3 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145439_Name = {
    Text = "魂靈同調"
  },
  Skill_145440_BattleDesc = {
    Text = "獲得 1 點算力。保留：積攢 <Green:[Arg1]> 點固定生命回覆量與 <Yellow:[Arg2]> 點固定狂氣(已積攢 <Green:[Arg3]> 生命回覆量，<Yellow:[Arg4]> 點狂氣)。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145440_Desc = {
    Text = "獲得 1 點算力。保留：積攢裝備者體質 6% 的固定生命回覆量與 4 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145440_Name = {
    Text = "魂靈同調"
  },
  Skill_145441_BattleDesc = {
    Text = "獲得 1 點算力。保留：積攢 <Green:[Arg1]> 點固定生命回覆量與 <Yellow:[Arg2]> 點固定狂氣(已積攢 <Green:[Arg3]> 生命回覆量，<Yellow:[Arg4]> 點狂氣)。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145441_Desc = {
    Text = "獲得 1 點算力。保留：積攢裝備者體質 4% 的固定生命回覆量與 2 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145441_Name = {
    Text = "魂靈同調"
  },
  Skill_145442_BattleDesc = {
    Text = "獲得 1 點算力。保留：積攢 <Green:[Arg1]> 點固定生命回覆量與 <Yellow:[Arg2]> 點固定狂氣(已積攢 <Green:[Arg3]> 生命回覆量，<Yellow:[Arg4]> 點狂氣)。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145442_Desc = {
    Text = "獲得 1 點算力。保留：積攢裝備者體質 3% 的固定生命回覆量與 1 點固定狂氣在此卡牌中。若此卡未被銷毀，可免疫一次死亡並釋放所有積攢的生命回覆量和狂氣，之後銷毀此卡牌。"
  },
  Skill_145442_Name = {
    Text = "魂靈同調"
  },
  Skill_145536_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145536_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145536_Name = {
    Text = "瞬發賜福·銀鑰能量"
  },
  Skill_145537_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145537_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145537_Name = {
    Text = "瞬發賜福·狂氣"
  },
  Skill_145538_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145538_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145538_Name = {
    Text = "瞬發賜福·傷害強效"
  },
  Skill_145539_BattleDesc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145539_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145539_Name = {
    Text = "瞬發賜福·抽牌"
  },
  Skill_145540_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145540_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145540_Name = {
    Text = "瞬發賜福·力量"
  },
  Skill_145541_BattleDesc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145541_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_145541_Name = {
    Text = "瞬發賜福·衰竭"
  },
  Skill_145557_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害並回覆一半傷害的生命，同時視為「打擊」。"
  },
  Skill_145558_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_145558_Name_1 = {Text = "打擊"},
  Skill_145559_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:穿刺傷害>，若擊殺任何敵方，獲得 [Arg2] <PVPPowerIconKeywords:力量>。"
  },
  Skill_145559_Name_1 = {
    Text = "鯨落歸溟"
  },
  Skill_145560_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，並臨時奪取 [Arg2] <PVPPowerIconKeywords:力量>，損失 [Arg3] 生命。"
  },
  Skill_145560_Name_1 = {Text = "隕之刃"},
  Skill_145561_Desc_1 = {
    Text = "對目標友方以外的所有其他喚醒體造成 <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:穿刺傷害>，後續每次回合開始重複此效果。"
  },
  Skill_145561_Name_1 = {
    Text = "噬鯨的風暴"
  },
  Skill_145561_UnknownName = {
    Text = "噬鯨的風暴"
  },
  Skill_145562_Desc_1 = {
    Text = "選擇一名敵方，雙方互相<PVPLock:鎖定>，並對目標造成 <Damage:[Damage:Arg1]> 傷害。目標在<PVPLock:鎖定>下死亡則此卡回到手中。<PVPFusion:融合>：傷害+ [Arg2] 。"
  },
  Skill_145562_Name_1 = {
    Text = "決鬥之契"
  },
  Skill_145612_Desc = {
    Text = "賜福是算力消耗 1、擁有<RetainIconKeywords:保留>、<PrepareKeypvewords:預備>、<DepleteIconKeywords:消耗>的增益卡。\n打出時獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。「賜福」共有 3 種：\n「瞬發賜福」：不會觸發「錯失良機」。\n「奢華賜福」：不會觸發「誇大其詞」。\n「暖心賜福」：不會觸發「暗藏殺機」。"
  },
  Skill_145612_Name = {Text = "賜福"},
  Skill_145664_Desc = {
    Text = "按照公式添加 [Poison:Arg1] 中毒，[Counterattack:Arg2] 反擊，[Power:Arg3] 力量，[Exhaustion:Arg4] 衰竭，[TentaclePower:Arg5] 觸腕傷害，[FateCut:Arg6] 命運裁斷，[Corrosion:Arg7] 侵蝕。"
  },
  Skill_145664_Name = {
    Text = "按公式加狀態"
  },
  Skill_145673_AwakerSkillBackgroundStory = {
    Text = "「你看見了嗎？他們的皮肉如何在你的刃下綻裂，湧出絢爛的血花。」\n「不要妄想閉上眼睛便不存在，親愛的孩子。」\n「你明白的，你清楚的。」\n「你所練就的技藝，早已浸染死亡的色彩，只會為他人引來下一場劫難。」"
  },
  Skill_145673_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145673_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145673_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。負誓·奧吉爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145673_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次。負誓·奧吉爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145673_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_145673_Name = {Text = "打擊"},
  Skill_145673_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_145674_AwakerSkillBackgroundStory = {
    Text = "「你聽見了嗎？他們的哀嚎如何響徹每個角落，卻無人為其撐起半分庇護。」\n「不要以為捂住耳朵便可忽視，無能的騎士。」\n「你親歷過，你選擇過。」\n「敵潮席捲而來之際，你丟盔棄甲，放任他們蹂躪了你最愛的土地。」"
  },
  Skill_145674_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145674_Desc = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾。負誓·奧吉爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_145674_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_145674_Name = {Text = "防禦"},
  Skill_145674_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_145675_AwakerSkillBackgroundStory = {
    Text = "其實，奧吉爾早已忘卻那座城堡的真實模樣。\n但如今，他可以依靠心底的祈望，鑄起新的壁壘。\n如果在他的守護之下，仍能聽到人們的歡聲笑語，熟悉的花朵也會重新開遍原野......\n那麼，那顆早已異化的心臟，就還有留存於世的意義。"
  },
  Skill_145675_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Power:Arg2] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 層使造成的護盾和力量提高 33%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Power:Arg2] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 層使造成的護盾和力量提高 50%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，獲得 [Power:Arg4] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 層使造成的護盾和力量提高 33%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，獲得 [Power:Arg4] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 層使造成的護盾和力量提高 50%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_EffectNameList = {
    Text = "護盾,力量"
  },
  Skill_145675_Name = {
    Text = "未隕的騎士心"
  },
  Skill_145675_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Power:Arg5] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 層使造成的護盾和力量提高 33%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Power:Arg5] 點<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 層使造成的護盾和力量提高 50%，獲得 1 層<ShuZui:自罪>。"
  },
  Skill_145675_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_145676_AwakerSkillBackgroundStory = {
    Text = "每位騎士在受封宣誓之時，隨身的兵刃便同樣鍍上了榮光。\n可屬於他的那柄最初的，被賦予了神聖使命的銀槍，早已消融在戰火的餘燼中。\n不過，既然已經是戴罪之身，不妨讓這罪惡的淤黑成為新的武器。他想，這樣，哪怕沾染更多的血，也不會再給故人蒙羞了。"
  },
  Skill_145676_BattleDesc_0 = {
    Text = "造成<Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成，獲得 1 層<KuangNu:暗涌>。"
  },
  Skill_145676_BattleDesc_3 = {
    Text = "造成<Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]% 力量加成，獲得 1 層<KuangNu2:暗涌>。"
  },
  Skill_145676_Desc_0 = {
    Text = "造成<Damage:[Damage:Arg1]> 點傷害，享受 300％ 力量加成，獲得 1 層<KuangNu:暗涌>。"
  },
  Skill_145676_Desc_3 = {
    Text = "造成<Damage:[Damage:Arg1]> 點傷害，享受 300% 力量加成，獲得 1 層<KuangNu2:暗涌>。"
  },
  Skill_145676_EffectNameList = {Text = "傷害"},
  Skill_145676_Name = {
    Text = "染罪槍鋒"
  },
  Skill_145676_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_145677_AwakerSkillBackgroundStory = {
    Text = "曾經，少年也試過將這邪惡的黑色污泥從自己身上剝離開，可無論他做什麼——用手撕扯，用利器切割，用鈍器擊打......無形的噩夢總是揮之不去，甚至愈發得寸進尺。\n最後，他終於承認，他與祂早已徹底融合為一，不分彼此。\n祂化作了他的影子。"
  },
  Skill_145677_BattleDesc_0 = {
    Text = "負誓·奧吉爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：負誓·奧吉爾每回合首次「染罪槍鋒」造成傷害時施加等量<Corrosion:侵蝕>。「防禦」的護盾提高 50%，抽 1 張牌。"
  },
  Skill_145677_BattleDesc_15 = {
    Text = "負誓·奧吉爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：負誓·奧吉爾每回合首次「染罪槍鋒」造成傷害時施加等量<Corrosion:侵蝕>。「染罪槍鋒」的基礎傷害提高 100%，額外享受 200% 力量加成。「防禦」的護盾提高 100%，抽 1 張牌。"
  },
  Skill_145677_Desc_0 = {
    Text = "負誓·奧吉爾獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：負誓·奧吉爾每回合首次「染罪槍鋒」造成傷害時施加等量<Corrosion:侵蝕>。「防禦」的護盾提高 50%，抽 1 張牌。"
  },
  Skill_145677_Desc_15 = {
    Text = "負誓·奧吉爾獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：負誓·奧吉爾每回合首次「染罪槍鋒」造成傷害時施加等量<Corrosion:侵蝕>。「染罪槍鋒」的基礎傷害提高 100%，額外享受 200% 力量加成。「防禦」的護盾提高 100%，抽 1 張牌。"
  },
  Skill_145677_EffectNameList = {Text = "狂氣"},
  Skill_145677_Name = {
    Text = "與黑沼共生"
  },
  Skill_145678_AwakerSkillBackgroundStory = {
    Text = "在彌薩格的例行檢查中，科研人員曾專門對這團無定形的漆黑之物進行了研究。\n出人意料的是，他們竟真的從中提取到了一些物質成分，於是迫不及待地展開了第二次實驗，得到的結果卻又全然不同。\n彷彿與它展現出的無定形特徵彼此呼應，構成它的成分也每時每刻都在變化，如同虛無縹緲的幻影。\n無形之物，根源即是無形。"
  },
  Skill_145678_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。額外生效 Ⅹ 次。Ⅹ 至多為 5。"
  },
  Skill_145678_EffectNameList = {
    Text = "臨時力量降低、力量"
  },
  Skill_145678_Name = {
    Text = "無邊荒影"
  },
  Skill_145678_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_145713_Desc = {
    Text = "打出後，讀取玩家身上的基礎鑰能上限，最大積攢鑰能並打印。"
  },
  Skill_145713_Name = {
    Text = "獲取鑰能屬性"
  },
  Skill_145971_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，若其當前生命大於自身，雙方交換當前生命。"
  },
  Skill_145971_Name_1 = {
    Text = "狂氣爆發"
  },
  Skill_145972_Desc_1 = {
    Text = "任意目標回覆 <Heal:[Heal:Arg1]> 生命，在下回合開始時移除未被損耗的生命。"
  },
  Skill_145972_Name_1 = {
    Text = "並非謊言之物"
  },
  Skill_145972_UnknownName = {
    Text = "並非謊言之物"
  },
  Skill_145973_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_145973_Name_1 = {Text = "打擊"},
  Skill_145974_Desc_1 = {
    Text = "使一名敵方施加 [Arg1] 層<PVPBless:賜福>。自身損失 <Damage:[Arg2]> 生命。"
  },
  Skill_145975_Desc_1 = {
    Text = "<PVPBluff:忽悠>一名敵方使其無心戰鬥。<PVPBluff:忽悠>結束對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_145976_Desc_1 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 狂氣，損失 <Damage:[Arg2]> 生命。<DelayKeywords:延遲 1>：扣除 [Arg1] 狂氣。"
  },
  Skill_145988_Desc = {
    Text = "臨時降低全體敵方 [Arg1] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_145988_Name = {
    Text = "原初記憶·衰竭"
  },
  Skill_145989_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Arg1]> 點狂氣。"
  },
  Skill_145989_Name = {
    Text = "原初記憶·催化"
  },
  Skill_145990_Desc = {
    Text = "回覆 <Heal:[Arg1]> 點生命"
  },
  Skill_145990_Name = {
    Text = "原初記憶·回覆"
  },
  Skill_145991_Desc = {
    Text = "對全體敵方施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_145991_Name = {
    Text = "原初記憶·毒素"
  },
  Skill_145992_Desc = {
    Text = "獲得 [Arg1] 層<RetaliateIconKeywords:臨時反擊>。"
  },
  Skill_145992_Name = {
    Text = "原初記憶·尖刺"
  },
  Skill_145993_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_145993_Name = {
    Text = "原初記憶·蠻力"
  },
  Skill_145995_Desc = {
    Text = "獲得 <Block:[Arg1]> 點護盾。"
  },
  Skill_145995_Name = {
    Text = "原初記憶·鐵壁"
  },
  Skill_146011_AwakerSkillBackgroundStory = {
    Text = "骨劍劃出的弧線永遠從容而優雅。\n認真地揮出每一劍，是她對對手、對戰鬥本身，最大的尊重。"
  },
  Skill_146011_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_146011_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次打出時抽 1 張「短刃·噬」（ [Arg4]/1 ）。"
  },
  Skill_146011_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。蝕滅·蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_146011_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。蝕滅·蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次打出時抽 1 張「短刃·噬」。"
  },
  Skill_146011_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_146011_Name = {Text = "打擊"},
  Skill_146011_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_146012_Desc = {
    Text = "無法打出。持有此卡時所有敵人造成的傷害提升 25%，蝕滅·蘿坦的指令卡全部變化為<DerivativeCardKeywords_154:「蝕滅」>，回合開始時抽 1 張<DerivativeCardKeywords_154:「蝕滅」>。"
  },
  Skill_146012_Name = {
    Text = "巨劍·鯨落"
  },
  Skill_146013_AwakerSkillBackgroundStory = {
    Text = "只有很少、很少的時候，蘿坦會收回她的劍。\n那雙異色的雙瞳正冷靜地審視著。收勢，永遠只是為了更好地出劍。"
  },
  Skill_146013_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_146013_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次打出時抽 1 張「長刃·隕」( [Arg4]/1 )。"
  },
  Skill_146013_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。蝕滅·蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_146013_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。蝕滅·蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。每回合首次打出時抽 1 張「長刃·隕」。"
  },
  Skill_146013_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_146013_Name = {Text = "防禦"},
  Skill_146013_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_146014_AwakerSkillBackgroundStory = {
    Text = "利維坦最沉重、堅硬的那塊顱骨被磨成長刃，她稱它為「隕」。\n重劍橫掃而出，劍鋒的弧線如同巨鯨擺動的尾鰭，沉重的白骨為她碾碎身前的一切。\n啜飲我的鮮血，啃食我的生命吧，蘿坦說。\n然後，讓所有的生靈，都隕落在你不可阻擋的軌跡裡。"
  },
  Skill_146014_Desc = {
    Text = "對全體敵方造成 [Arg3] 次 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]% 力量加成，視為「打擊」。本回合每打出 1 張「打擊」，下次打出的「長刃·隕」算力消耗 -1。"
  },
  Skill_146014_EffectNameList = {Text = "傷害"},
  Skill_146014_Name = {
    Text = "長刃·隕"
  },
  Skill_146014_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_146015_AwakerSkillBackgroundStory = {
    Text = "利維坦永遠記得她斬出那一劍時的樣子。\n在祂的領域，那個不自量力的身影早已傷痕累累。屬於人類的身軀如此羸弱，幾乎一陣呼吸便能讓她再也無力起來。愚蠢、狂妄、令人惋惜，這是利維坦對她的全部審判。\n在審判落下之前，那個弱小的身影再次站了起來。她的笑聲讓祂感到一種從未有過的情緒。\n祂看見她帶著那把破碎的武器與殘敗的身體，向祂高高躍起。祂看見那道似乎能夠斬碎星海的劍意，來到祂的眼前。\n在那柄劍貫穿祂的那一刻，利維坦才明白，那種祂從未體驗過的情緒，叫做恐懼。"
  },
  Skill_146015_Desc_0 = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨劍·鯨落」>才可釋放。對傷害最高敵方造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害，享受 [Arg2]% 力量加成。目標每通過<DerivativeCardKeywords_153:「巨劍·鯨落」>提高 1 點傷害，就使「斷界之劍」傷害 +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_Desc_3 = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨劍·鯨落」>才可釋放。對傷害最高敵方造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害，享受 [Arg2]% 力量加成。目標每通過<DerivativeCardKeywords_153:「巨劍·鯨落」>提高 1 點傷害，就使「斷界之劍」傷害 +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_EffectNameList = {
    Text = "傷害,力量加成"
  },
  Skill_146015_Name = {
    Text = "斷界之劍"
  },
  Skill_146015_OverLimitUtlSkillDesc = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨劍·鯨落」>才可釋放。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。對傷害最高敵方造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害，享受 [Arg2]% 力量加成。目標每通過<DerivativeCardKeywords_153:「巨劍·鯨落」>提高 1 點傷害，就使「斷界之劍」傷害 +[Arg4]。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2％"
  },
  Skill_146016_AwakerSkillBackgroundStory = {
    Text = "神明將她的靈與肉撕裂，以為這便是對混沌的終極審判。\n但空蕩的靈魂從未停止追尋，被剝離的力量也從未真正消散。\n當骨甲重新覆上她的身軀，當利維坦的脈動再次與她的意志共鳴——所有束縛在那一刻碎裂殆盡。\n靈與肉在星海深處重新交融。混沌之獸不再殘缺。\n這片星海，將重新迎接完整的她。"
  },
  Skill_146016_BattleDesc_0 = {
    Text = "「蝕滅·蘿坦」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「蝕滅·蘿坦」指令卡傷害次數 +1。回合開始時若<DerivativeCardKeywords_153:「巨劍·鯨落」>在手中，本回合首次<DerivativeCardKeywords_154:「蝕滅」>每竊取 1 點狂氣，使下次「斷界之劍」最終傷害 +1％，最多疊加 90％。"
  },
  Skill_146016_BattleDesc_15 = {
    Text = "「蝕滅·蘿坦」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：「蝕滅·蘿坦」指令卡傷害次數 +1，<DerivativeCardKeywords_154:「蝕滅」>竊取的狂氣提高 50％。回合開始時若<DerivativeCardKeywords_153:「巨劍·鯨落」>在手中，本回合首次<DerivativeCardKeywords_154:「蝕滅」>每竊取 1 點狂氣，使下次「斷界之劍」最終傷害 +1.5％，最多疊加 135％。"
  },
  Skill_146016_Desc_0 = {
    Text = "「蝕滅·蘿坦」獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：「蝕滅·蘿坦」指令卡傷害次數 +1。回合開始時若<DerivativeCardKeywords_153:「巨劍·鯨落」>在手中，本回合首次<DerivativeCardKeywords_154:「蝕滅」>每竊取 1 點狂氣，使下次「斷界之劍」最終傷害 +1％，最多疊加 90％。"
  },
  Skill_146016_Desc_15 = {
    Text = "「蝕滅·蘿坦」獲得 [Arg2]％ 基礎狂氣。<ExaltIconKeywords:靈知覺醒>：「蝕滅·蘿坦」指令卡傷害次數 +1，<DerivativeCardKeywords_154:「蝕滅」>竊取的狂氣提高 50％。回合開始時若<DerivativeCardKeywords_153:「巨劍·鯨落」>在手中，本回合首次<DerivativeCardKeywords_154:「蝕滅」>每竊取 1 點狂氣，使下次「斷界之劍」最終傷害 +1.5％，最多疊加 135％。"
  },
  Skill_146016_EffectNameList = {Text = "狂氣"},
  Skill_146016_Name = {
    Text = "亙古歸源"
  },
  Skill_146017_AwakerSkillBackgroundStory = {
    Text = "利維坦最鋒利的那顆利齒被磨成短刃，她稱它為「噬」。\n它對弱者沒有任何的興趣，劍尖永遠朝向最強大的那個敵人。利刃以極快的速度刺出，當殘影消散之時，浩若星海的力量也將被吞噬殆盡。\n它的貪婪永無止境，那飢餓的目光從誕生之刻便緊盯著蘿坦，每次出手都在蘿坦的體內撕咬下一塊血肉。\n蘿坦從不在意。她用鮮血飼養它，用力量震懾它。她用它揮向最強的對手，力量的味道，她與它一同品嚐。"
  },
  Skill_146017_BattleDesc = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，視為「打擊」。打出後洗回抽牌堆。此卡每第 3 次打出時額外生效 1 次並使本回合下次打出「長刃·隕」時合成<DerivativeCardKeywords_153:「巨劍·鯨落」>（ [Arg4]/3 ）<DerivativeCardKeywords_154:>"
  },
  Skill_146017_Desc = {
    Text = "視為「打擊」。對隨機敵方造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，打出後洗回抽牌堆。此卡每第 3 次打出時額外生效 1 次並使本回合下次打出「長刃·隕」時合成<DerivativeCardKeywords_153:「巨劍·鯨落」><DerivativeCardKeywords_154:>"
  },
  Skill_146017_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_146017_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_146018_Desc = {
    Text = "抽 1 張牌。竊取其他喚醒體至多 [Arg1] 點狂氣。"
  },
  Skill_146018_Name = {Text = "蝕滅"},
  Skill_146018_tempBattleDesc_1 = {
    Text = "抽 1 張牌。竊取其他喚醒體至多 [Arg1] 點狂氣。"
  },
  Skill_146018_tempBattleDesc_2 = {
    Text = "抽 1 張牌。竊取其他喚醒體至多 [Arg1] 點狂氣，額外獲得竊取值 50％ 的狂氣。"
  },
  Skill_146067_Desc_1 = {
    Text = "找回卡牌並受到 <Damage:[Arg1]> 傷害。"
  },
  Skill_146067_Name_1 = {Text = "賜福？"},
  Skill_146069_Desc = {
    Text = "打出後清空手牌，並將空白鑰令加入手牌。"
  },
  Skill_146069_Name = {
    Text = "獲取空白鑰令"
  },
  Skill_146097_Desc = {
    Text = "打出後清空手牌，並將編隊鑰令加入手牌。"
  },
  Skill_146097_Name = {
    Text = "獲取編隊鑰令"
  },
  Skill_146112_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。積攢 [Arg2] 層<Shimieluotanhuodong1:戰意>。打出後洗入抽牌堆。"
  },
  Skill_146113_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。獲得 [Arg2] 點<PowerIconKeywords:力量>。消耗所有<Shimieluotanhuodong1:戰意>，每消耗 1 層<Shimieluotanhuodong1:戰意>使所有喚醒體最終傷害提高 3％。"
  },
  Skill_146113_Name = {Text = "劍之骨"},
  Skill_146114_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。打出後本回合內每受到 1 次傷害，積攢 [Arg2] 層<Shimieluotanhuodong1:戰意>。"
  },
  Skill_146114_Name = {Text = "傷之骨"},
  Skill_146132_Desc = {
    Text = "新的仲夏夜之夢邏輯。抽 1 張牌，如果抽到指令卡或靈知覺醒，將其算力消耗變為 0，並使其擁有者獲得 <Energy:[Arg1]> 點狂氣。否則將這張牌棄掉並重複此條效果。"
  },
  Skill_146132_Name = {
    Text = "仲夏之夢"
  },
  Skill_146388_Desc = {
    Text = "允許釋放狂氣爆發"
  },
  Skill_146388_Name = {
    Text = "本源蘿坦測試"
  },
  Skill_146461_Desc = {
    Text = "不需要文本，不需要翻譯。"
  },
  Skill_146461_Name = {
    Text = "冥刃追滅"
  },
  Skill_146484_Desc = {
    Text = "獲得 [Arg1]％ 臨時傷害強效。"
  },
  Skill_146484_Name = {
    Text = "原初記憶·怒火"
  },
  Skill_146517_Desc = {
    Text = "從持有鑰令中<FaxianKeywords:發現> [Arg1] 種鑰令，選擇 [Arg2] 個鑰令使其生效 [Arg3] 次。"
  },
  Skill_146517_Name = {
    Text = "原初·雙生復演"
  },
  Skill_146519_Desc = {
    Text = "從持有鑰令中<FaxianKeywords:發現> [Arg1] 組鑰令，每組鑰令由 [Arg2] 個不同的鑰令組成。選擇  [Arg3] 組鑰令使其中鑰令依次生效  [Arg4] 次。"
  },
  Skill_146519_Name = {
    Text = "原初·三相天啟"
  },
  Skill_146647_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，界域精通提高 [Arg2]。若卡拉布在隊伍中，使下 1 次<DerivativeCardKeywords_152:「賜福」>不會觸發「負面效果」。"
  },
  Skill_146647_Name = {
    Text = "並非謊言之物"
  },
  Skill_146648_Desc = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>，選擇 1 名喚醒體竊取其他喚醒體至多 [Arg1] 點狂氣。若蝕滅·蘿坦在隊伍中，下 1 張蝕滅·蘿坦的「打擊」額外生效 1 次。"
  },
  Skill_146648_Name = {
    Text = "噬鯨的風暴"
  },
  Skill_146658_Name = {Text = "第3組"},
  Skill_146659_Name = {Text = "第1組"},
  Skill_146660_Name = {Text = "第2組"},
  Skill_147427_Desc_0 = {
    Text = "在本回合中，偷取所有敵人 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_147427_Desc_4000 = {
    Text = "在本回合中，偷取所有敵人 [Arg1] 點<PowerIconKeywords:力量>。<TransitionIconKeywords:躍遷>：算力消耗變為 0 點。"
  },
  Skill_147427_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_147428_Name_1 = {Text = "打擊"},
  Skill_147429_Desc = {
    Text = "暮星·汀克特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：暮星·汀克特的所有牌獲得 1 個隨機效果，該刻印效果將在戰鬥結束時移除。"
  },
  Skill_147429_EffectNameList = {Text = "狂氣"},
  Skill_147430_Name_1 = {
    Text = "復甦之音"
  },
  Skill_147431_Desc_0 = {
    Text = "在本回合中獲得 [Arg1] 點<PowerIconKeywords:力量>。所有手牌獲得 1 個隨機效果，該效果將在打出後或戰鬥結束時移除。<TransitionIconKeywords:躍遷>：隨機效果獲得升級。"
  },
  Skill_147431_Desc_6 = {
    Text = "在本回合中獲得 [Arg1] 點<PowerIconKeywords:力量>。所有手牌獲得 1 個隨機效果，該效果將在打出後或戰鬥結束時移除。<TransitionIconKeywords:躍遷>：隨機效果獲得升級！"
  },
  Skill_147431_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_147432_Name_1 = {
    Text = "星彩極光"
  },
  Skill_147433_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。暮星·汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_147433_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_147433_Name = {
    Text = "打擊(未完成)"
  },
  Skill_147433_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_147434_Desc = {
    Text = "如果在上個回合中沒有損失生命，在本回合中暴擊率提高 [Arg2] %。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。"
  },
  Skill_147434_EffectNameList_0 = {Text = "傷害"},
  Skill_147434_EffectNameList_1000 = {
    Text = "傷害,額外傷害"
  },
  Skill_147434_Name = {
    Text = "深空迴響(未完成)"
  },
  Skill_147434_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_147434_PropertyNameList_1000 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue1"
  },
  Skill_147435_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：佔位描述"
  },
  Skill_147435_Name_1 = {
    Text = "暮星·汀克特SR（臨時文本）"
  },
  Skill_147437_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。暮星·汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_147437_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_147437_Name = {
    Text = "防禦(未完成)"
  },
  Skill_147437_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_147438_Name_1 = {
    Text = "穿雲引吭"
  },
  Skill_147551_Desc = {
    Text = "臨時文本"
  },
  Skill_147551_Name = {
    Text = "臨時佔位鑰令"
  },
  Skill_147734_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] <MaxHPKeywords:最大生命值>。回合開始時，對全體敵方造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_147734_Name_1 = {
    Text = "從黑暗到黑暗"
  },
  Skill_147742_BattleDesc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>或獲得 [Arg1] 點臨時<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_147742_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>或獲得 [Arg1] 點臨時<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_147742_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_147743_BattleDesc = {
    Text = "獲得 1000 無視上限的銀鑰能量或失去 1000 點銀鑰能量。"
  },
  Skill_147743_Desc = {
    Text = "獲得 1000 無視上限的銀鑰能量或失去 1000 點銀鑰能量。"
  },
  Skill_147743_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_147744_BattleDesc = {
    Text = "所有喚醒體獲得 20 狂氣或失去 20 狂氣。"
  },
  Skill_147744_Desc = {
    Text = "所有喚醒體獲得 20 狂氣或失去 20 狂氣。"
  },
  Skill_147744_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_147745_BattleDesc = {
    Text = "回覆 5% 最大生命值或失去 5% 最大生命值。"
  },
  Skill_147745_Desc = {
    Text = "回覆 5% 最大生命值或失去 5% 最大生命值。"
  },
  Skill_147745_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_147746_BattleDesc = {
    Text = "下回合開始時額外獲得 1 張「<DerivativeCardKeywords_115:高級靈感>」，或失去 2 點算力並少抽 2 張牌。"
  },
  Skill_147746_Desc = {
    Text = "下回合開始時額外獲得 1 張「<DerivativeCardKeywords_115:高級靈感>」，或失去 2 點算力並少抽 2 張牌。"
  },
  Skill_147746_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_147917_Name = {
    Text = "奢華賜福"
  },
  Skill_147918_Name = {
    Text = "暖心賜福"
  },
  Skill_147919_Name = {
    Text = "瞬發賜福"
  },
  Skill_147937_Desc = {
    Text = "獲得 [Arg1] 層<MonsterPainKeywords:苦痛救贖>，此後玩家打出「<DerivativeCardKeywords_158:代罪>」時只驅散 50%<MonsterSinMarkKeywords:罪印>，並且每打出 1 張指令卡獲得 1 <MonsterSinMarkKeywords:罪印>。回合結束後移除<InvincibleUntilRoused:銀芯固化>。"
  },
  Skill_147937_Name = {
    Text = "淨世之路"
  },
  Skill_147938_Desc = {
    Text = "每次釋放鑰令後使下次打出時的算力消耗降低 1 點。打出後驅散「聖子·白夜」一半<MonsterSinMarkKeywords:罪印>層數。"
  },
  Skill_147939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<PowerIconKeywords:力量>。"
  },
  Skill_147939_Name = {
    Text = "明燈灼魂"
  },
  Skill_147940_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<MonsterSinMarkKeywords:罪印>。"
  },
  Skill_147940_Name = {Text = "聖心"},
  Skill_147941_Desc = {
    Text = "每次釋放鑰令後使下次打出時的算力消耗降低 [Arg1] 點。打出後驅散「聖子·白夜」 [Arg2]%<MonsterSinMarkKeywords:罪印>層數。"
  },
  Skill_147942_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<MonsterPainKeywords:苦痛救贖>，施加 [Arg4] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_147942_Name = {
    Text = "無罪的聖裁"
  },
  Skill_147943_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。積攢 [Arg3] 層<MonsterPainKeywords:苦痛救贖>，施加 [Arg4] 層<FragileIconKeywords: 脆弱>。"
  },
  Skill_147943_Name = {
    Text = "照徹白夜之光"
  },
  Skill_147944_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_147944_Name = {
    Text = "離垢的審判"
  },
  Skill_148024_Desc = {
    Text = "選擇 1 名喚醒體，本回合該喚醒體下次狂氣爆發每消耗 1 點狂氣就獲得 [Arg1] 點銀鑰能量。"
  },
  Skill_148024_Name = {
    Text = "萬化之果 - 惡魔之鑰"
  },
  Skill_148025_Desc = {
    Text = "選擇 1 名喚醒體，本回合該喚醒體下次狂氣爆發獲得的護盾和生命回復提高 [Arg1]％。"
  },
  Skill_148025_Name = {
    Text = "萬化之果 - 公正之羽"
  },
  Skill_148026_Desc = {
    Text = "選擇 1 名喚醒體，本回合該喚醒體指令卡造成的傷害附加 [Arg1]％ 出血。"
  },
  Skill_148026_Name = {
    Text = "萬化之果 - 必滅之眼"
  },
  Skill_148027_Desc = {
    Text = "選擇 1 名喚醒體，使該喚醒體算力最高的 [Arg1] 張指令卡算力消耗降低 [Arg2] 。"
  },
  Skill_148027_Name = {
    Text = "萬化之果 - 預見之鏡"
  },
  Skill_148028_BattleDesc = {
    Text = "選擇 1 名喚醒體，本回合下 [Arg1] 次打出該喚醒體的指令卡，獲得等同於 [Arg2]％ 已損失生命的護盾（ [Arg3] ）  。消耗：下回合開始時，生成 1 張「萬化之果」置入抽牌堆。"
  },
  Skill_148028_Desc = {
    Text = "選擇 1 名喚醒體，本回合下 [Arg1] 次打出該喚醒體的指令卡，獲得等同於 [Arg2]% 已損失生命的護盾。"
  },
  Skill_148028_Name = {
    Text = "萬化之果 – 引誘之果"
  },
  Skill_148029_Desc = {
    Text = "選擇 1 名喚醒體，本回合該喚醒體下次狂氣爆發造成的傷害附加  [Arg1]% <CutKeywords:命運裁斷>。"
  },
  Skill_148029_Name = {
    Text = "萬化之果 - 命運之絲"
  },
  Skill_148042_BattleDesc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148042_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148042_Name = {
    Text = "奢華賜福·抽牌"
  },
  Skill_148043_BattleDesc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148043_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148043_Name = {
    Text = "奢華賜福·算力"
  },
  Skill_148044_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148044_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148044_Name = {
    Text = "暖心賜福·狂氣"
  },
  Skill_148045_BattleDesc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148045_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148045_Name = {
    Text = "暖心賜福·算力"
  },
  Skill_148046_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148046_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148046_Name = {
    Text = "奢華賜福·狂氣"
  },
  Skill_148047_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148047_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148047_Name = {
    Text = "暖心賜福·銀鑰能量"
  },
  Skill_148048_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148048_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148048_Name = {
    Text = "奢華賜福·傷害強效"
  },
  Skill_148049_BattleDesc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148049_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148049_Name = {
    Text = "奢華賜福·衰竭"
  },
  Skill_148050_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148050_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148050_Name = {
    Text = "奢華賜福·力量"
  },
  Skill_148051_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148051_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148051_Name = {
    Text = "暖心賜福·力量"
  },
  Skill_148052_BattleDesc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148052_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148052_Name = {
    Text = "暖心賜福·衰竭"
  },
  Skill_148053_BattleDesc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148053_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148053_Name = {
    Text = "暖心賜福·抽牌"
  },
  Skill_148054_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148054_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148054_Name = {
    Text = "奢華賜福·銀鑰能量"
  },
  Skill_148055_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148055_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_148055_Name = {
    Text = "暖心賜福·傷害強效"
  },
  Skill_148360_Desc = {
    Text = "切換到該意圖時，破除敵方護盾並使其本回合無法獲得護盾，立刻獲得 [Arg3] 層<MonsterB05EXFever:狂熱>。 直到回合結束，自身造成傷害附加 100%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_148361_Desc = {
    Text = "切換到該意圖時，破除敵方護盾並使其本回合無法獲得護盾，立刻獲得 [Arg3] 層<MonsterB05EXFever:狂熱>。 直到回合結束，自身造成傷害附加 100%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_148361_Name = {
    Text = "縛身鎖鏈"
  },
  Skill_148362_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並附加 [Arg3]%<BleedingIconKeywords:出血>，失去 [Arg4]%當前生命。 切換到該意圖時若擁有 [Arg5] 層「恨意」，意圖替換為造成 <Damage:[Damage:Arg6]> 點傷害 [AttackTimes:Arg7] 次的「嗜血鏈球」，否則獲得 1 層「恨意」。"
  },
  Skill_148362_Name = {
    Text = "鮮血鏈條"
  },
  Skill_148364_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，敵方每有 3 層<BleedingIconKeywords:出血>傷害提高 1，回覆 30% 已損失生命。"
  },
  Skill_148364_Name = {
    Text = "嗜血鏈球"
  },
  Skill_148365_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] <PowerIconKeywords:力量>。若自身生命低於 [Arg4]（50%），傷害和獲得 <PowerIconKeywords:力量> 翻倍。"
  },
  Skill_148365_Name = {
    Text = "恨意宣洩"
  },
  Skill_148393_Desc = {
    Text = "回合開始時獲得 [Arg1] 層<ResentChainsKeywords:怨恨鎖鏈>。 意圖切換至「嗜血鏈球」時，直到敵方回合結束後免疫一切傷害和生命損失效果。"
  },
  Skill_148499_Name = {
    Text = "魔法百寶箱"
  },
  Skill_148502_Name = {
    Text = "魔法百寶箱"
  },
  Skill_148506_Name = {
    Text = "魔法百寶箱"
  },
  Skill_148531_Desc = {
    Text = "選擇 1 名喚醒體，抽 1 張該喚醒體的指令卡並使其算力消耗變為 0，該喚醒體下次狂氣爆發視為超限爆發，若已為超限爆發則返還 100% 基礎狂氣。"
  },
  Skill_148531_Name = {
    Text = "萬化之果 - 永恆之冠"
  },
  Skill_149049_Desc = {
    Text = "獲得 [Arg1] 層<Guaiwusiwangdikang:死亡抵抗>。「凍結」所有<SlowIconKeywords:遲緩>的指令卡並移除其<SlowIconKeywords:遲緩>效果，移除所有喚醒體 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_149049_Name = {
    Text = "倖存者之歌"
  },
  Skill_149077_Desc = {
    Text = "切換至該意圖時，吞食狂氣最高喚醒體至多 <Energy:[Energy:Arg1]> 點狂氣，死亡後返還。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次和等量<BleedingIconKeywords:出血>，對狂氣最高的喚醒體施加 [Arg4] 層狂氣封印。"
  },
  Skill_149078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_149079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_149080_Desc = {
    Text = "切換至該意圖時，凍結狂氣最低喚醒體 [Arg1] 張指令卡，死亡後解除該喚醒體的凍結。造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次和等量<BleedingIconKeywords:出血>，對抽牌堆或棄牌堆 [Arg4] 張卡牌施加 [Arg5] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_149081_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，消化吞食的狂氣。"
  },
  Skill_149081_Name = {Text = "潛伏"},
  Skill_149082_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，碎裂撕咬目標喚醒體所有凍結的指令卡，將其<DepleteIconKeywords:消耗>。"
  },
  Skill_149082_Name = {Text = "潛伏"},
  Skill_149129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<WeaknessIconKeywords:虛弱>並棄置手中所有卡牌。"
  },
  Skill_149129_Name = {Text = "離散"},
  Skill_149130_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每有 [Arg3] 層<BloodOath_New:血誓>使造成的傷害提高 [Arg4] 點。"
  },
  Skill_149130_Name = {
    Text = "擁抱新生"
  },
  Skill_149131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2]次並附加等量<BleedingIconKeywords:出血>。"
  },
  Skill_149131_Name = {
    Text = "燈焰灼魂"
  },
  Skill_149132_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>。對抽牌堆或棄牌堆中 [Arg2] 張指令卡施加 [Arg3] 層<SlowIconKeywords:遲緩>，敵方各處卡牌每有 [Arg4] 層<SlowIconKeywords:遲緩>，自身獲得 [Arg5] 層<BloodOath_New:血誓>。"
  },
  Skill_149132_Name = {
    Text = "倒映聖容"
  },
  Skill_149150_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<BoneHitKeywords:刺骨>，否則失去 [Arg2]% 當前生命並獲得等量<CardKeyWord:霜盾>。"
  },
  Skill_149151_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BoneHitKeywords:刺骨>，若自身擁有護盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149152_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<HeavyInjuryKeywords:重創>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149153_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回覆 [Arg3]% 已損失生命。"
  },
  Skill_149175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<BlindingKeywords:致盲>，並將 [Arg4] 張隨機症狀洗入對方抽牌堆。"
  },
  Skill_149175_Name = {
    Text = "靈魂布道"
  },
  Skill_149176_Desc = {
    Text = "棄置手中所有牌，並為棄牌堆所有指令卡施加 [Arg1] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_149176_Name = {
    Text = "罪火纏身"
  },
  Skill_149177_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>。對抽牌堆或棄牌堆中 [Arg2] 張指令卡施加 [Arg3] 層<SlowIconKeywords:遲緩>，敵方各處卡牌每有 [Arg4] 層<SlowIconKeywords:遲緩>，自身獲得 [Arg5] 層<BloodOath_New:血誓>。"
  },
  Skill_149177_Name = {
    Text = "倒映聖容"
  },
  Skill_149178_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>。對抽牌堆或棄牌堆中 [Arg2] 張指令卡施加 [Arg3] 層<SlowIconKeywords:遲緩>，敵方各處卡牌每有 [Arg4] 層<SlowIconKeywords:遲緩>，自身獲得 [Arg5] 層<BloodOath_New:血誓>。"
  },
  Skill_149178_Name = {
    Text = "倒映聖容"
  },
  Skill_149181_Desc = {
    Text = "對前排敵方造成 [Arg1] 點普通固定傷害 [Arg2] 次。"
  },
  Skill_149181_Name = {
    Text = "固定傷害測試"
  },
  Skill_149182_Desc = {
    Text = "對前排敵方造成 [Arg1] 點穿刺固定傷害 [Arg2] 次。"
  },
  Skill_149182_Name = {
    Text = "固定傷害測試"
  },
  Skill_149208_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BleedingIconKeywords:出血>，若自身擁有護盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149209_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，否則失去 [Arg2]% 當前生命並獲得等量<CardKeyWord:咒盾>。"
  },
  Skill_149209_Name = {
    Text = "燃燈意志"
  },
  Skill_149210_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<EmptinessKeywords: 空虛>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149236_Desc = {
    Text = "對前排敵方施加狂氣爆發百分比修正–50"
  },
  Skill_149236_Name = {
    Text = "狂氣爆發百分比修正測試"
  },
  Skill_149237_Desc = {
    Text = "對前排敵方施加狂氣爆發百分比修正+50"
  },
  Skill_149237_Name = {
    Text = "狂氣爆發百分比修正測試"
  },
  Skill_149239_Desc = {
    Text = "對前排敵方施加承受指令卡傷害百分比修正+50"
  },
  Skill_149239_Name = {
    Text = "承受指令卡傷害百分比修正測試"
  },
  Skill_149248_Desc = {
    Text = "對前排敵方施加承受指令卡傷害百分比修正–50"
  },
  Skill_149248_Name = {
    Text = "承受指令卡傷害百分比修正測試"
  },
  Skill_149255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每次未被格擋都會移除所有喚醒體 [Arg3] 狂氣。"
  },
  Skill_149255_Name = {
    Text = "蓄勢獵殺"
  },
  Skill_149256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 未被格擋傷害的<BoneHitKeywords:刺骨>。"
  },
  Skill_149256_Name = {Text = "雪災"},
  Skill_149277_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<HeavyInjuryKeywords:重創>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149278_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<HeavyInjuryKeywords:重創>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BleedingIconKeywords:出血>，若自身擁有護盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回覆 [Arg3]% 已損失生命。"
  },
  Skill_149281_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<EmptinessKeywords: 空虛>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149282_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<BoneHitKeywords:刺骨>，否則失去 [Arg2]% 當前生命並獲得 [Arg3]% <CardKeyWord:霜盾>。"
  },
  Skill_149283_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<BoneHitKeywords:刺骨>，否則失去 [Arg2]% 當前生命並獲得 [Arg3]% <CardKeyWord:霜盾>。"
  },
  Skill_149284_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BleedingIconKeywords:出血>，若自身擁有護盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149285_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，否則失去 [Arg2]% 當前生命並獲得 [Arg3]% <CardKeyWord:咒盾>。"
  },
  Skill_149285_Name = {
    Text = "燃燈意志"
  },
  Skill_149286_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，擁有護盾時施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，否則失去 [Arg2]% 當前生命並獲得 [Arg3]% <CardKeyWord:咒盾>。"
  },
  Skill_149286_Name = {
    Text = "燃燈意志"
  },
  Skill_149287_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BoneHitKeywords:刺骨>，若自身擁有護盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<EmptinessKeywords: 空虛>，若未被格擋則移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3]% 傷害的<BoneHitKeywords:刺骨>，若自身擁有護盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149333_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 點<PowerIconKeywords:力量>。若負誓·奧吉爾在隊伍中，負誓·奧吉爾獲得 [Arg3] 點狂氣，獲得 1 層<KuangNu:暗湧>"
  },
  Skill_149333_Name = {
    Text = "永續新篇"
  },
  Skill_149334_Name_1 = {
    Text = "永續新篇"
  },
  Skill_149334_UnknownName = {
    Text = "永續新篇"
  },
  Skill_149345_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149345_Name = {
    Text = "暖心賜福·銀鑰能量"
  },
  Skill_149346_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149346_Name = {
    Text = "暖心賜福·力量"
  },
  Skill_149347_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<WeaknessIconKeywords:虛弱>，並對牌庫中 [Arg4] 張指令卡施加 [Arg5] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_149348_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149348_Name = {
    Text = "瞬發賜福·衰竭"
  },
  Skill_149349_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149349_Name = {
    Text = "暖心賜福·衰竭"
  },
  Skill_149350_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149350_Name = {
    Text = "暖心賜福·狂氣"
  },
  Skill_149353_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149353_Name = {
    Text = "瞬發賜福·算力"
  },
  Skill_149354_Desc = {
    Text = "獲得 <Block:[Block:Arg4]> 的霜盾，造成 [Arg5] 次<Bleesing_Negative:暗藏殺機>效果。發現 [Arg1] 組附帶<Blessing:禮物>和<BlessingNegativeEffect:代價>的「<DerivativeCardKeywords_161:賜福>」，每組 [Arg2] 張，選擇 [Arg3] 組置入手中。"
  },
  Skill_149354_Name = {
    Text = "奇蹟賜福"
  },
  Skill_149355_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149355_Name = {
    Text = "瞬發賜福·銀鑰能量"
  },
  Skill_149356_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149356_Name = {
    Text = "瞬發賜福·狂氣"
  },
  Skill_149357_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149357_Name = {
    Text = "奢華賜福·衰竭"
  },
  Skill_149358_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149358_Name = {
    Text = "奢華賜福·傷害強效"
  },
  Skill_149359_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149359_Name = {
    Text = "暖心賜福·抽牌"
  },
  Skill_149360_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149360_Name = {
    Text = "奢華賜福·狂氣"
  },
  Skill_149361_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149361_Name = {
    Text = "奢華賜福·算力"
  },
  Skill_149362_Desc = {
    Text = "獲得一種<MonsterBless:禮物>和一種<BlessingNegativeEffect:代價>。「賜福」共有 3 種：包括「瞬發賜福」、「奢華賜福」、「暖心賜福」。\n「瞬發賜福」：不會觸發「錯失良機」。\n「奢華賜福」：不會觸發「誇大其詞」。\n「暖心賜福」：不會觸發「暗藏殺機」。"
  },
  Skill_149362_Name = {Text = "賜福"},
  Skill_149364_Desc = {
    Text = "「白雪仙女」釋放「童話天衣無縫」後下 [Arg1] 個意圖均為「粉雪魔咒」。 每回合將 [Arg2] 張具有 [Arg3] 層<SlowIconKeywords:遲緩>的隨機「<DerivativeCardKeywords_161:賜福>」洗入牌庫。"
  },
  Skill_149364_Name = {
    Text = "誘人蜜果"
  },
  Skill_149365_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149365_Name = {
    Text = "瞬發賜福·力量"
  },
  Skill_149366_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149366_Name = {
    Text = "奢華賜福·銀鑰能量"
  },
  Skill_149367_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149367_Name = {
    Text = "暖心賜福·算力"
  },
  Skill_149369_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149369_Name = {
    Text = "童話天衣無縫"
  },
  Skill_149372_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149372_Name = {
    Text = "暖心賜福·傷害強效"
  },
  Skill_149373_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149373_Name = {
    Text = "叮咚★仙女駕到"
  },
  Skill_149374_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149374_Name = {
    Text = "奢華賜福·抽牌"
  },
  Skill_149375_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149375_Name = {
    Text = "奢華賜福·力量"
  },
  Skill_149376_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149376_Name = {
    Text = "瞬發賜福·傷害強效"
  },
  Skill_149377_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149377_Name = {
    Text = "瞬發賜福·抽牌"
  },
  Skill_149378_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張具有 [Arg4] 層<SlowIconKeywords:遲緩>的隨機「<DerivativeCardKeywords_161:賜福>」洗入牌庫。"
  },
  Skill_149378_Name = {Text = "打擊"},
  Skill_149636_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149636_Name = {
    Text = "叮咚★仙女駕到\n供奉算力"
  },
  Skill_149639_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149639_Name = {
    Text = "叮咚★仙女駕到\n供奉鑰能"
  },
  Skill_149642_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149642_Name = {
    Text = "叮咚★仙女駕到\n供奉卡牌"
  },
  Skill_149643_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149643_Name = {
    Text = "叮咚★仙女駕到\n供奉狂氣"
  },
  Skill_149644_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149644_Name = {
    Text = "童話天衣無縫\n供奉算力、卡牌"
  },
  Skill_149645_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149645_Name = {
    Text = "童話天衣無縫\n供奉鑰能、狂氣"
  },
  Skill_149646_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149646_Name = {
    Text = "童話天衣無縫\n供奉卡牌、狂氣"
  },
  Skill_149647_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149647_Name = {
    Text = "童話天衣無縫\n供奉算力、鑰能"
  },
  Skill_149648_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149648_Name = {
    Text = "童話天衣無縫\n供奉算力、狂氣"
  },
  Skill_149649_Desc = {
    Text = "切換至該意圖時隨機向敵方索取 [Arg1] 種供奉。造成 <Damage:[Damage:Arg4]> 點傷害 [AttackTimes:Arg5] 次。成功供奉時 「白雪仙女」 生命上限提高 [Arg2]%，獲得 1 層<MonsterB11_AFFull:飽餐>；否則其獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_149649_Name = {
    Text = "童話天衣無縫\n供奉鑰能、卡牌"
  },
  Skill_149706_Desc_1 = {
    Text = "免疫PVP純粹傷害，二次釋放解除。"
  },
  Skill_149706_Name_1 = {
    Text = "免疫純粹傷害"
  },
  Skill_149722_BattleDesc = {
    Text = "獲得 1000 無視上限的銀鑰能量或失去 1000 點銀鑰能量。"
  },
  Skill_149722_Desc = {
    Text = "獲得 1000 無視上限的銀鑰能量或失去 1000 點銀鑰能量。"
  },
  Skill_149722_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_149723_BattleDesc = {
    Text = "所有喚醒體獲得 20 狂氣或失去 20 狂氣。"
  },
  Skill_149723_Desc = {
    Text = "所有喚醒體獲得 20 狂氣或失去 20 狂氣。"
  },
  Skill_149723_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_149724_BattleDesc = {
    Text = "下回合開始時額外獲得 1 張「<DerivativeCardKeywords_115:高級靈感>」，或失去 2 點算力並少抽 2 張牌。"
  },
  Skill_149724_Desc = {
    Text = "下回合開始時額外獲得 1 張「<DerivativeCardKeywords_115:高級靈感>」，或失去 2 點算力並少抽 2 張牌。"
  },
  Skill_149724_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_149725_BattleDesc = {
    Text = "回覆 5% 最大生命值或失去 5% 最大生命值。"
  },
  Skill_149725_Desc = {
    Text = "回覆 5% 最大生命值或失去 5% 最大生命值。"
  },
  Skill_149725_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_149726_BattleDesc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>或獲得 [Arg1] 點臨時<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_149726_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>或獲得 [Arg1] 點臨時<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_149726_Name = {
    Text = "皇家瑪麗巧克力"
  },
  Skill_149842_Name = {
    Text = "刺骨寒風Skill1"
  },
  Skill_149844_Name = {
    Text = "七大「神器」之寶光ExSkill"
  },
  Skill_149845_Name = {
    Text = "刺骨寒風Skill2"
  },
  Skill_149846_Name = {
    Text = "深淵收割Attack2"
  },
  Skill_149847_Name = {
    Text = "永恆不滅之華彩Summon"
  },
  Skill_149901_Desc = {
    Text = "全部寶物特效關"
  },
  Skill_149901_Name = {
    Text = "全部寶物特效關"
  },
  Skill_149902_Name = {
    Text = "技能@巨噬蠕蟲威廉支援卡3"
  },
  Skill_149903_Name = {
    Text = "技能@巨噬蠕蟲N支援卡"
  },
  Skill_149904_Name = {
    Text = "技能@巨噬蠕蟲威廉支援卡1"
  },
  Skill_149905_Name = {
    Text = "技能@巨噬蠕蟲威廉支援卡2"
  },
  Skill_149906_Desc = {
    Text = "獲取測試特效卡"
  },
  Skill_149906_Name = {
    Text = "獲取測試特效卡"
  },
  Skill_149907_Desc = {
    Text = "全部寶物特效開"
  },
  Skill_149907_Name = {
    Text = "全部寶物特效開"
  },
  Skill_149959_BattleDesc = {
    Text = "抽 [Arg1] 張牌，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149959_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149959_Name = {
    Text = "奢華賜福·抽牌"
  },
  Skill_149959_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149959_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149959_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149960_BattleDesc = {
    Text = "抽 [Arg1] 張牌，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149960_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149960_Name = {
    Text = "瞬發賜福·抽牌"
  },
  Skill_149960_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149960_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149960_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149961_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149961_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149961_Name = {
    Text = "奢華賜福·銀鑰能量"
  },
  Skill_149961_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149961_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149961_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149962_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]％，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149962_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149962_Name = {
    Text = "奢華賜福·傷害強效"
  },
  Skill_149962_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]％。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149962_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]％。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149962_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]％。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149963_BattleDesc = {
    Text = "獲得 [Arg1] 點算力，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149963_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149963_Name = {
    Text = "瞬發賜福·算力"
  },
  Skill_149963_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149963_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149963_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149964_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149964_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149964_Name = {
    Text = "奢華賜福·力量"
  },
  Skill_149964_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149964_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149964_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149965_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149965_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149965_Name = {
    Text = "瞬發賜福·狂氣"
  },
  Skill_149965_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg2]> 點固定狂氣。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149965_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149965_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149966_BattleDesc = {
    Text = "抽 [Arg1] 張牌，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149966_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149966_Name = {
    Text = "暖心賜福·抽牌"
  },
  Skill_149966_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149966_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149966_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149967_BattleDesc = {
    Text = "獲得 [Arg1] 點算力，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149967_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149967_Name = {
    Text = "奢華賜福·算力"
  },
  Skill_149967_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149967_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149967_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149968_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]％，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149968_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149968_Name = {
    Text = "瞬發賜福·傷害強效"
  },
  Skill_149968_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]％。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149968_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]％。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149968_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]％。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149969_BattleDesc = {
    Text = "獲得 [Arg1] 點算力，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149969_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149969_Name = {
    Text = "暖心賜福·算力"
  },
  Skill_149969_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149969_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149969_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149970_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149970_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149970_Name = {
    Text = "奢華賜福·狂氣"
  },
  Skill_149970_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg2]> 點固定狂氣。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149970_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149970_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149971_BattleDesc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149971_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149971_Name = {
    Text = "瞬發賜福·衰竭"
  },
  Skill_149971_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149971_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149971_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149972_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149972_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149972_Name = {
    Text = "暖心賜福·銀鑰能量"
  },
  Skill_149972_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149972_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149972_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149973_BattleDesc = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149973_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149973_Name = {
    Text = "暖心賜福·狂氣"
  },
  Skill_149973_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg2]> 點固定狂氣。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149973_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149973_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Yellow:[Arg1]> 點固定狂氣。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149974_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149974_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149974_Name = {
    Text = "暖心賜福·力量"
  },
  Skill_149974_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149974_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149974_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149975_BattleDesc = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg1】 點<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149975_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149975_Name = {
    Text = "暖心賜福·衰竭"
  },
  Skill_149975_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149975_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149975_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149976_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149976_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149976_Name = {
    Text = "瞬發賜福·力量"
  },
  Skill_149976_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149976_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149976_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149977_BattleDesc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149977_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149977_Name = {
    Text = "奢華賜福·衰竭"
  },
  Skill_149977_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149977_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149977_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149978_BattleDesc = {
    Text = "臨時傷害強效 +[Arg1]%，小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149978_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149978_Name = {
    Text = "暖心賜福·傷害強效"
  },
  Skill_149978_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]％。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149978_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]％。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149978_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]％。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149979_BattleDesc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。獲得 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149979_Desc_0 = {
    Text = "獲得一種具有<BlessingNegativeEffect:代價>的<Blessing:禮物>和 1 層<SacrificialMark1:供奉>。"
  },
  Skill_149979_Name = {
    Text = "瞬發賜福·銀鑰能量"
  },
  Skill_149979_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量。<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149979_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。<Bleesing_Delay:錯失良機>：2 回合後生效。"
  },
  Skill_149979_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149995_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149995_Name = {
    Text = "奢華賜福·傷害強效"
  },
  Skill_149995_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]%，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149995_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]%，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_149995_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]%，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149996_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_149996_Name = {
    Text = "暖心賜福·抽牌"
  },
  Skill_149996_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149996_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_149996_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149997_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149997_Name = {
    Text = "瞬發賜福·抽牌"
  },
  Skill_149997_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149997_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_149997_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149998_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149998_Name = {
    Text = "瞬發賜福·算力"
  },
  Skill_149998_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149998_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_149998_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149999_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_149999_Name = {
    Text = "瞬發賜福·衰竭"
  },
  Skill_149999_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg2】 點<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_149999_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg1】 點<ExhaustionIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_149999_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150000_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150000_Name = {
    Text = "暖心賜福·狂氣"
  },
  Skill_150000_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150000_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150000_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150001_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150001_Name = {
    Text = "瞬發賜福·傷害強效"
  },
  Skill_150001_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]%，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150001_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]%，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150001_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]%，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150002_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150002_Name = {
    Text = "奢華賜福·狂氣"
  },
  Skill_150002_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150002_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150002_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150003_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150003_Name = {
    Text = "暖心賜福·算力"
  },
  Skill_150003_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150003_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150003_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150004_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150004_Name = {
    Text = "奢華賜福·銀鑰能量"
  },
  Skill_150004_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150004_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150004_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150005_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150005_Name = {
    Text = "瞬發賜福·力量"
  },
  Skill_150005_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150005_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150005_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150006_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150006_Name = {
    Text = "奢華賜福·衰竭"
  },
  Skill_150006_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg2】 點<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150006_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg1】 點<ExhaustionIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150006_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150007_Desc = {
    Text = "臨時傷害強效 +[Arg1]%。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150007_Name = {
    Text = "暖心賜福·傷害強效"
  },
  Skill_150007_tempBattleDesc_1 = {
    Text = "臨時傷害強效 +[Arg2]%，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150007_tempBattleDesc_2 = {
    Text = "臨時傷害強效 +[Arg1]%，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150007_tempBattleDesc_3 = {
    Text = "臨時傷害強效 +[Arg1]%，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150008_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150008_Name = {
    Text = "瞬發賜福·銀鑰能量"
  },
  Skill_150008_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150008_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150008_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150009_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150009_Name = {
    Text = "暖心賜福·力量"
  },
  Skill_150009_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150009_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150009_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150010_Desc = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150010_Name = {
    Text = "暖心賜福·衰竭"
  },
  Skill_150010_tempBattleDesc_1 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg2】 點<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150010_tempBattleDesc_2 = {
    Text = "臨時降低所有敵人 【Exhaustion:Arg1】 點<ExhaustionIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150010_tempBattleDesc_3 = {
    Text = "臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150011_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。小心！包含<Bleesing_Exaggerate:誇大其詞>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150011_Name = {
    Text = "瞬發賜福·狂氣"
  },
  Skill_150011_tempBattleDesc_1 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150011_tempBattleDesc_2 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150011_tempBattleDesc_3 = {
    Text = "所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150012_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150012_Name = {
    Text = "奢華賜福·力量"
  },
  Skill_150012_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150012_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150012_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150013_Desc = {
    Text = "獲得 [Arg1] 點算力。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150013_Name = {
    Text = "奢華賜福·算力"
  },
  Skill_150013_tempBattleDesc_1 = {
    Text = "獲得 [Arg2] 點算力，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150013_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 點算力，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150013_tempBattleDesc_3 = {
    Text = "獲得 [Arg1] 點算力，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150014_Desc = {
    Text = "抽 [Arg1] 張牌。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150014_Name = {
    Text = "奢華賜福·抽牌"
  },
  Skill_150014_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 張牌，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150014_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 張牌，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150014_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 張牌，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_150015_Desc = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。小心！包含<Bleesing_Delay:錯失良機>或<Bleesing_Exaggerate:誇大其詞>效果。"
  },
  Skill_150015_Name = {
    Text = "暖心賜福·銀鑰能量"
  },
  Skill_150015_tempBattleDesc_1 = {
    Text = "獲得 <Posse:[Arg2]> 點銀鑰能量，<Bleesing_Exaggerate:誇大其詞>：效果減少 50％。"
  },
  Skill_150015_tempBattleDesc_2 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，<Bleesing_Delay:錯失良機>：2 回合後生效 。"
  },
  Skill_150015_tempBattleDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量，給予自身隨機 1 種<Bleesing_Negative:暗藏殺機>效果。"
  },
  Skill_19313_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 <Block:[Block:Arg1]> 護盾和 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19313_Name_1 = {
    Text = "冬夜追憶"
  },
  Skill_19314_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19314_Name_1 = {Text = "打擊"},
  Skill_19315_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，獲得正面<PVPWonderfulEffectKeywords:奇妙效果>，敵方每回合第一次使用「鑰令」時將 [Arg1] 張<PVPDerivativeCardKeywords_3:「華麗光景」>置入手中。"
  },
  Skill_19315_Name_1 = {
    Text = "無聲歡宴"
  },
  Skill_19316_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19316_Name_1 = {
    Text = "阿庫特之春"
  },
  Skill_19320_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後回復自身 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19321_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：死亡後，下回合開始時<PVPResurrectionKeywords:復活>自身並獲得 <Heal:[Heal:Arg1]> 生命和<Block:[Block:Arg2]> 護盾並摧毀此「命輪」。"
  },
  Skill_19322_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19322_Name_1 = {Text = "打擊"},
  Skill_19323_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 + [Arg2]。回合結束時，獲得手牌中隨機 [Arg1] 張「技能」的複製。"
  },
  Skill_19323_Name_1 = {
    Text = "聚首時刻"
  },
  Skill_19324_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合前 [Arg2] 張「技能」消耗的算力 – [Arg1]。"
  },
  Skill_19327_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，抽 [Arg1] 張牌。"
  },
  Skill_19327_Name_1 = {Text = "貪婪"},
  Skill_19328_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19328_Name_1 = {Text = "打擊"},
  Skill_19329_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>並<ComaKeywords:昏迷>一名友方，給予其 <Block:[Block:Arg1]> 護盾，若其在下回合開始時依舊死亡，則重新觸發此鑰令效果 1 次。"
  },
  Skill_19329_Name_1 = {
    Text = "永世執念"
  },
  Skill_19329_UnknownName = {
    Text = "永世執念"
  },
  Skill_19331_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19331_Name_1 = {Text = "打擊"},
  Skill_19334_Desc_1 = {
    Text = "指定友方回復 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19334_Name_1 = {
    Text = "注射守護"
  },
  Skill_19334_UnknownName = {
    Text = "注射守護"
  },
  Skill_19337_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19337_Name_1 = {Text = "打擊"},
  Skill_19339_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19339_Name_1 = {Text = "打擊"},
  Skill_19340_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使雙方棄掉所有手牌並抽取等量棄牌數 +1 張牌。"
  },
  Skill_19340_Name_1 = {
    Text = "快樂魔法秀"
  },
  Skill_19341_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時自身獲得 <Energy:[Energy:Arg1]> 狂氣，消耗所有剩餘算力，每消耗 1 算力使獲得狂氣提高 [Arg3]。"
  },
  Skill_19341_Name_1 = {
    Text = "隱秘的誕生"
  },
  Skill_19342_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時<ComaKeywords:昏迷>自身。「狂氣爆發」前驅散全體友方的負面狀態。"
  },
  Skill_19342_Name_1 = {
    Text = "勳爵手杖"
  },
  Skill_19343_Desc_1 = {
    Text = "查看 [Arg1] 張其他隨機「鑰令」，選擇 1 張置入手中。"
  },
  Skill_19343_Name_1 = {
    Text = "不平等交換"
  },
  Skill_19343_UnknownName = {
    Text = "不平等交換"
  },
  Skill_19346_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19346_Name_1 = {Text = "打擊"},
  Skill_19349_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時<ComaKeywords:昏迷>自身。「狂氣爆發」前驅散全體敵方的正面狀態。"
  },
  Skill_19349_Name_1 = {Text = "譫妄"},
  Skill_19350_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，<PVPSeriousInjuryKeywords:重創>自身並獲得 <Damage:[Damage:Arg1]> 層<PVPCorrosionKeywords:罪印>。回合結束時，<ReinforceKeywords:加固>自身。"
  },
  Skill_19353_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」回復自身 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19354_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」<PVPVulnerabilityIconKeywords:易傷>目標。裝備和回合結束時獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19354_Name_1 = {Text = "臨界點"},
  Skill_19355_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [Arg1]%，「打擊」可以選擇目標。"
  },
  Skill_19355_Name_1 = {Text = "寵愛"},
  Skill_19356_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次「打擊」額外造成<Damage:[Damage:Arg1]>傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_19356_Name_1 = {Text = "苦咒縛"},
  Skill_19358_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19358_Name_1 = {Text = "打擊"},
  Skill_19360_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19360_Name_1 = {Text = "打擊"},
  Skill_19361_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [Arg1] 張牌。"
  },
  Skill_19361_Name_1 = {Text = "湧現"},
  Skill_19363_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，其他友方獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_19364_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」造成<PVPSeriousInjuryKeywords:重創>，傷害提高 [Arg1]％，但使自身損失一半傷害的生命。"
  },
  Skill_19364_Name_1 = {
    Text = "傷痛之鰭"
  },
  Skill_19370_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使全體友方獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_19370_Name_1 = {
    Text = "心之壁壘"
  },
  Skill_19372_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提升 [Arg1]% ，「狂氣爆發」後使自身<PVPPowerIconKeywords:力量>+ [Arg2] 並使「打擊」傷害額外提升 [Arg3]%，最大為 100%。"
  },
  Skill_19372_Name_1 = {
    Text = "星天之獸"
  },
  Skill_19374_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標並且扣除目標 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19378_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19378_Name_1 = {Text = "打擊"},
  Skill_19379_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使狂氣最低友方獲得 <Energy:[Energy:Arg1]> 狂氣，並回復損失生命最多的友方 <Heal:[Heal:Arg2]> 生命。"
  },
  Skill_19380_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19380_Name_1 = {Text = "打擊"},
  Skill_19381_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：打出卡牌後，此牌變成其他隨機「命輪」，並使其算力消耗 -1 。"
  },
  Skill_19381_Name_1 = {
    Text = "靈魂誕生"
  },
  Skill_19383_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：我方喚醒體死亡時，對全體敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。裝備者死亡時額外造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_19384_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [Arg1] 張「技能」，將其 [Arg2] 張複製置入手中。"
  },
  Skill_19384_Name_1 = {
    Text = "好運時間"
  },
  Skill_19387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後獲得 [Arg1] 算力，<DelayKeywords:延遲>：扣除 [Arg2] 算力。"
  },
  Skill_19387_Name_1 = {
    Text = "記憶症候"
  },
  Skill_19388_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 <Energy:[Energy:Arg1]> 狂氣。友方喚醒體釋放「狂氣爆發」後，自身獲得<DelayKeywords:延遲>：<Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19388_Name_1 = {
    Text = "神王的頌歌"
  },
  Skill_19389_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：將此卡變為目標裝備的「命輪」 ，如果目標未裝備「命輪」 則獲得 [Arg1] 張「幻象」並返還消耗的算力。"
  },
  Skill_19389_Name_1 = {
    Text = "冒險的行囊"
  },
  Skill_19391_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19391_Name_1 = {Text = "打擊"},
  Skill_19393_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [Arg1]% ，並使自身獲得<ReinforceKeywords:加固>。"
  },
  Skill_19393_Name_1 = {
    Text = "堅韌意志"
  },
  Skill_19394_Desc_1 = {
    Text = "抽 [Arg1] 張牌，獲得 [Arg2] 算力。"
  },
  Skill_19394_Name_1 = {
    Text = "後發制人"
  },
  Skill_19400_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使<HPAndShieldMin:生命與護盾最低>的友方獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_19400_Name_1 = {Text = "致摯友"},
  Skill_19401_Desc_1 = {
    Text = "獲得 [Arg1] 算力，<DelayKeywords:延遲>：扣除 [Arg2] 算力。"
  },
  Skill_19402_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>，否則使手中自身算力消耗最高的 1 張「技能」算力消耗 -1。"
  },
  Skill_19403_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 +[Arg1]。"
  },
  Skill_19403_Name_1 = {
    Text = "記憶螺旋"
  },
  Skill_19406_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對全體敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。"
  },
  Skill_19409_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」每攻擊一個目標獲得 [Arg1] 算力。"
  },
  Skill_19409_Name_1 = {
    Text = "被縛的歌謠"
  },
  Skill_19411_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」造成的傷害、治療與護盾效果提高 [Arg1]% ，使用「技能」後若沒有<PVPProtectiveKeywords:屏障>則獲得 1 層。"
  },
  Skill_19411_Name_1 = {
    Text = "詩箋的句尾"
  },
  Skill_19412_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」使自身獲得<ReinforceKeywords:加固>。"
  },
  Skill_19412_Name_1 = {
    Text = "騎士之心"
  },
  Skill_19413_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19413_Name_1 = {Text = "打擊"},
  Skill_19414_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：自身在驅散負面狀態時若無可驅散的負面狀態則回覆 <Heal:[Heal:Arg1]> 生命。回合結束時、<DelayKeywords:延遲>：驅散自身負面狀態。"
  },
  Skill_19415_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」造成的傷害、治療與護盾效果提高 [Arg1]％。"
  },
  Skill_19415_Name_1 = {
    Text = "以薔薇之名"
  },
  Skill_19418_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使全體友方獲得<StrengthenKeywords:強化>。"
  },
  Skill_19418_Name_1 = {
    Text = "虔誠的偉力"
  },
  Skill_19419_Desc_1 = {
    Text = "使一名友方獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19420_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，將 [Arg1] 張<PVPDerivativeCardKeywords_11:「不平等交換」>洗入抽牌堆。"
  },
  Skill_19420_Name_1 = {
    Text = "資訊就是生命"
  },
  Skill_19421_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前使自身獲得<StrengthenKeywords:強化>和<ReinforceKeywords:加固>。"
  },
  Skill_19422_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19422_Name_1 = {Text = "打擊"},
  Skill_19424_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19424_Name_1 = {Text = "打擊"},
  Skill_19425_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19425_Name_1 = {Text = "打擊"},
  Skill_19426_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19426_Name_1 = {Text = "眷顧"},
  Skill_19430_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次受到敵方主動攻擊後，對其造成 [Arg1] 傷害，<PVPEntanglementKeywords:纏繞>。"
  },
  Skill_19430_Name_1 = {
    Text = "蒼白後裔"
  },
  Skill_19431_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，對全體敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，目標每有一張手牌額外造成 [Arg2] <PVPBleedingKeywords:出血>。"
  },
  Skill_19432_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19432_Name_1 = {Text = "打擊"},
  Skill_19433_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時對自身造成 [Arg2] 傷害，<PVPEntanglementKeywords:纏繞>。每有 1 個陣亡友方，<StrongEffectKeywords:強效>+[Arg1]。"
  },
  Skill_19433_Name_1 = {
    Text = "至為珍貴的藏品"
  },
  Skill_19437_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [Arg1]%。每受到一次攻擊，獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19438_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 [Arg1] 臨時<PVPRetaliateIconKeywords:反擊>。"
  },
  Skill_19439_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19439_Name_1 = {Text = "打擊"},
  Skill_19444_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，裝備者對<HPAndShieldMax:生命與護盾最高>敵方造成 [Arg1] 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_19444_Name_1 = {
    Text = "腐朽贈禮"
  },
  Skill_19446_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前驅散自身負面狀態，並獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19446_Name_1 = {
    Text = "掙脫鎖鏈之日"
  },
  Skill_19448_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合對手打出第 [Arg1] 張「技能」時，將其一張算力消耗 - [Arg2] 的複製置入手牌。"
  },
  Skill_19449_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19449_Name_1 = {Text = "打擊"},
  Skill_19451_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合打出的第一張裝備者的「技能」傷害提高 [Arg1]%。"
  },
  Skill_19452_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19452_Name_1 = {Text = "打擊"},
  Skill_19453_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得一張<PVPDerivativeCardKeywords_2:「幻象」> 。每當手牌上擁有兩張<PVPDerivativeCardKeywords_2:「幻象」> 時，將它們合成為一張<PVPDerivativeCardKeywords_12:「小小心願」>。"
  },
  Skill_19455_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者每回合第一次打出「技能」後，將其一張算力消耗 - [Arg1] 的複製洗入抽牌堆。"
  },
  Skill_19455_Name_1 = {
    Text = "旋轉，旋轉"
  },
  Skill_19456_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」「技能」「狂氣爆發」造成的傷害、治療與護盾提高 [Arg3]%，<PVPGrowthKeywords:成長> [Arg2]%。"
  },
  Skill_19456_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」「技能」「狂氣爆發」造成的傷害、治療與護盾提升 [Arg1]%，<PVPGrowthKeywords:成長> [Arg2]%。"
  },
  Skill_19456_Name_1 = {Text = "隕日"},
  Skill_19457_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」使自身獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19457_Name_1 = {Text = "狂亂"},
  Skill_19458_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」攻擊<HPAndShieldMax:生命與護盾最高>的敵方，並額外造成傷害 [Arg1]% 的 <PVPBleedingKeywords:出血>。"
  },
  Skill_19458_Name_1 = {
    Text = "切割與傷害"
  },
  Skill_19460_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標並且造成 [Arg1] 層<PVPSlowKeywords:遲緩>，每回合對首個目標觸發時效果翻倍。"
  },
  Skill_19460_Name_1 = {
    Text = "遺忘之手"
  },
  Skill_19463_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19463_Name_1 = {Text = "打擊"},
  Skill_19465_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19465_Name_1 = {Text = "打擊"},
  Skill_19466_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Block:[Block:Arg1]> 護盾，其他友方獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_19466_Name_1 = {
    Text = "無法完成的演算"
  },
  Skill_19467_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：因為失去生命而獲得的狂氣翻倍。"
  },
  Skill_19467_Name_1 = {Text = "海之夢"},
  Skill_19468_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使一張算力消耗最高的手牌消耗的算力 -[Arg1]。"
  },
  Skill_19468_Name_1 = {
    Text = "專注精神"
  },
  Skill_19470_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19470_Name_1 = {
    Text = "畸體回噬"
  },
  Skill_19471_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_19473_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，回復損失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19475_Desc_1 = {
    Text = "棄掉所有手牌，並抽取相應張數的牌，若手牌為空則獲得隨機 [Arg1] 張鑰令。"
  },
  Skill_19475_Name_1 = {
    Text = "純白初遇"
  },
  Skill_19475_UnknownName = {
    Text = "純白初遇"
  },
  Skill_19477_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」和回合結束時，自身獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19479_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後將上回合最後打出的「技能」置入手中，並使其算力消耗 -1，若多次觸發該類效果則向前追溯。"
  },
  Skill_19479_Name_1 = {
    Text = "溯洄時計"
  },
  Skill_19483_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後將 [Arg1] 張<PVPDerivativeCardKeywords_11:「不平等交換」>置入手中。"
  },
  Skill_19483_Name_1 = {
    Text = "於暴雨之中"
  },
  Skill_19484_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使其他友方獲得 <Energy:[Energy:Arg1]> 狂氣，此效果溢出的狂氣將折半返還給裝備者。"
  },
  Skill_19484_Name_1 = {
    Text = "職責所在"
  },
  Skill_19486_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：死亡後給予其他友方 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_19487_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，每點<PVPCapKeywords:算力上限>對<HPAndShieldMin:生命與護盾最低>敵方造成 [Arg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>傷害。"
  },
  Skill_19487_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，每點<PVPCapKeywords:算力上限>對<HPAndShieldMin:生命與護盾最低>敵方造成 [Arg1] <PVPBleedingKeywords:出血>。"
  },
  Skill_19487_Name_1 = {
    Text = "伏於夜色"
  },
  Skill_19489_Desc_1 = {
    Text = "給予一名友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_19489_Name_1 = {
    Text = "小小心願"
  },
  Skill_19489_UnknownName = {
    Text = "小小心願"
  },
  Skill_19493_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」傷害提高 [Arg1]% ，「狂氣爆發」後回復自身 <Heal:[Heal:Arg2]> 生命。"
  },
  Skill_19493_Name_1 = {
    Text = "吞噬搖籃曲"
  },
  Skill_19495_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後<DelayKeywords:延遲>：回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19497_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後對全體敵方造成 [Arg1] 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_19497_Name_1 = {Text = "懲戒"},
  Skill_19499_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_19499_Name_1 = {
    Text = "腦中之音"
  },
  Skill_19499_UnknownName = {
    Text = "腦中之音"
  },
  Skill_20075_Desc = {
    Text = "擊退前排敵方。"
  },
  Skill_20075_Name = {
    Text = "相位變換"
  },
  Skill_20841_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_20841_Name = {
    Text = "沸騰吧！血"
  },
  Skill_20842_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_20842_Name = {
    Text = "血與沙之歌"
  },
  Skill_20843_Desc = {
    Text = "獲得[Arg1]點護盾，施加 [Arg2] 層<BleedingIconKeywords:出血>。"
  },
  Skill_20843_Name = {
    Text = "尖嘯吧！血"
  },
  Skill_20844_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_20850_Desc = {
    Text = "將「猩紅」的一次行動意圖扭曲為低威脅的單次攻擊。"
  },
  Skill_20850_Name = {
    Text = "契約迴響"
  },
  Skill_20974_Desc = {
    Text = "該意圖無法被誓約迴響扭曲。獲得 「血之狂暴·終結」 狀態，失去一定生命後會釋放極高傷害的狂氣爆發。"
  },
  Skill_20974_Name = {Text = "覺醒"},
  Skill_20975_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。並將兩張「融蝕」洗入抽牌堆。"
  },
  Skill_20975_Name = {
    Text = "血與沙之歌·狂"
  },
  Skill_21308_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每受到 1 次攻擊減少 1 次攻擊次數，至少 3 次。"
  },
  Skill_21308_Name = {
    Text = "血怒連擊(破綻)"
  },
  Skill_21313_Desc_1 = {
    Text = "使一名目標獲得 <PVPVulnerabilityIconKeywords:易傷>。"
  },
  Skill_21313_Name_1 = {Text = "易傷"},
  Skill_21314_Desc_1 = {
    Text = "使一名目標獲得 <StrengthenKeywords:強化>。"
  },
  Skill_21314_Name_1 = {Text = "強化"},
  Skill_21315_Desc_1 = {
    Text = "使一名目標獲得 <WeaknessIconKeywords:虛弱>。"
  },
  Skill_21315_Name_1 = {Text = "虛弱"},
  Skill_21316_Desc_1 = {
    Text = "使一名目標獲得 <ReinforceKeywords:加固>。"
  },
  Skill_21320_Desc_1 = {
    Text = "丟掉所有牌。"
  },
  Skill_21320_Name_1 = {
    Text = "丟棄所有手牌"
  },
  Skill_21321_Desc_1 = {
    Text = "執行測試指令。"
  },
  Skill_21321_Name_1 = {
    Text = "測試指令"
  },
  Skill_21330_Desc_1 = {
    Text = "對一名目標造成 <Damage:[Damage:Arg1]> 傷害和等量<PVPMethysisKeywords:中毒>。"
  },
  Skill_21332_Desc_1 = {
    Text = "造成[Arg1]傷害並 <ComaKeywords:昏迷>。"
  },
  Skill_21333_Desc_1 = {
    Text = "驅散一名目標的正面效果。"
  },
  Skill_21333_Name_1 = {
    Text = "驅散正面"
  },
  Skill_21334_Desc_1 = {
    Text = "使一名目標獲得 <TauntKeywords:嘲諷>。"
  },
  Skill_21334_Name_1 = {Text = "嘲諷"},
  Skill_21336_Desc_1 = {
    Text = "使一名目標獲得 <DelayKeywords:延遲>：<Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_21336_Name_1 = {
    Text = "延遲狂氣"
  },
  Skill_21337_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 臨時<StrengthenKeywords:反擊>。"
  },
  Skill_21337_Name_1 = {Text = "反擊"},
  Skill_21338_Desc_1 = {
    Text = "使一名目標獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_21338_Name_1 = {Text = "狂氣"},
  Skill_21339_Desc_1 = {
    Text = "驅散一名目標的負面效果。"
  },
  Skill_21339_Name_1 = {
    Text = "驅散負面"
  },
  Skill_21341_Desc_1 = {
    Text = "使一名目標獲得 <StrengthenKeywords:護盾>。"
  },
  Skill_21341_Name_1 = {Text = "護盾"},
  Skill_21355_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 層<StrengthenKeywords:遲緩>。"
  },
  Skill_21355_Name_1 = {Text = "遲緩"},
  Skill_21356_Desc_1 = {
    Text = "使一個目標獲得 <DelayKeywords:延遲>：抽 [Arg1] 張牌。"
  },
  Skill_21356_Name_1 = {
    Text = "延遲抽牌"
  },
  Skill_21357_Desc_1 = {
    Text = "使一名目標失去 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_21357_Name_1 = {
    Text = "失去狂氣"
  },
  Skill_21361_Desc_1 = {
    Text = "使一名目標獲得 <DelayKeywords:延遲>： <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_21361_Name_1 = {
    Text = "延遲治療"
  },
  Skill_21362_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>一名目標使其獲得 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_21362_Name_1 = {Text = "復活"},
  Skill_21379_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_21403_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_21582_BattleDesc_1 = {
    Text = "棄掉所有牌，生成目標套牌，算力加到50，獲得一張狂氣。"
  },
  Skill_21582_Desc_1 = {
    Text = "棄掉所有牌，生成目標套牌，算力加到50，獲得一張狂氣，可以使用100次。"
  },
  Skill_21602_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 層<EnergyStorageColour:蓄力>。"
  },
  Skill_21603_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] <PowerColourKeywords:力量>。"
  },
  Skill_21615_AwakerSkillBackgroundStory = {
    Text = "奧吉爾的記憶因融蝕現象而支離破碎。\n他記得舞會上的歡笑，卻忘記了舞會主角的姓名；他記得自己在騎士團受訓，卻不知道大公為何讓年幼的他成為騎士；他記得自己葬身鐵騎之下，卻無法記起自己所守護的是怎樣的笑容。\n沒人能苛責他，他已經做到了騎士應盡的一切責任——包括為了守護的意志而獻出生命。"
  },
  Skill_21615_Desc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態。獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_21615_Desc_2 = {
    Text = "若自身擁有<FragileIconKeywords:脆弱>狀態，則驅散並獲得 <Block:[Block:Arg3]> 點護盾。獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_21615_EffectNameList_0 = {
    Text = "護盾,力量"
  },
  Skill_21615_EffectNameList_2 = {
    Text = "驅散獲得護盾,護盾,力量"
  },
  Skill_21615_Name = {
    Text = "七藝，傳承美德"
  },
  Skill_21615_OverLimitUtlSkillDesc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態。獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得的護盾提升 200%。奧吉爾造成的傷害次數 +1，持續 3 回合。"
  },
  Skill_21615_OverLimitUtlSkillDesc_2 = {
    Text = "若自身擁有<FragileIconKeywords:脆弱>狀態，則驅散並獲得 <Block:[Block:Arg3]> 點護盾。獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得的護盾提升 200%。奧吉爾造成的傷害次數 +1，持續 3 回合。"
  },
  Skill_21615_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_21615_PropertyNameList_2 = {
    Text = "防禦力*GrowValue3,防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_21620_AwakerSkillBackgroundStory = {
    Text = "理性決定了她的視物角度，真理構築了她的思維廣度，現實則束縛了她的道德尺度。\n對這名不世天才而言，科學，亦是一種哲學。"
  },
  Skill_21620_Desc_0 = {
    Text = "驅散自身<VulnerabilityIconKeywords:易傷>狀態。回復 <Heal:[Heal:Arg1]> 點生命，其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_21620_Desc_3 = {
    Text = "驅散自身<VulnerabilityIconKeywords:易傷>狀態。回復 <Heal:[Heal:Arg1]> 點生命，所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_21620_EffectNameList_0 = {
    Text = "回復,狂氣"
  },
  Skill_21620_EffectNameList_7 = {
    Text = "回復,狂氣,每回合回復"
  },
  Skill_21620_Name = {
    Text = "理性，真理與現實"
  },
  Skill_21620_OverLimitUtlSkillDesc_0 = {
    Text = "驅散自身<VulnerabilityIconKeywords:易傷>狀態。回覆 <Heal:[Heal:Arg1]> 點生命，其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。回合開始時回覆 <Heal:[Heal:Arg3]> 點生命，持續 3 回合。"
  },
  Skill_21620_OverLimitUtlSkillDesc_3 = {
    Text = "驅散自身<VulnerabilityIconKeywords:易傷>狀態。回復 <Heal:[Heal:Arg1]> 點生命，所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。回合開始時回復 <Heal:[Heal:Arg3]> 點生命，持續 3 回合。"
  },
  Skill_21620_PropertyNameList_0 = {
    Text = "體質*GrowValue1,$GrowValue2"
  },
  Skill_21620_PropertyNameList_7 = {
    Text = "體質*GrowValue1,$GrowValue2,體質*GrowValue3"
  },
  Skill_21663_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。覺醒後，每回合移除 3 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>狀態。"
  },
  Skill_21663_Name = {
    Text = "戰欲難平"
  },
  Skill_21668_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_21672_Desc_1 = {
    Text = "對敵方全體造成30傷害。"
  },
  Skill_21672_Name_1 = {
    Text = "造成範圍傷害"
  },
  Skill_21721_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，全體獲得 [Arg3] 點護盾，將 2 張<DerivativeCardKeywords_26:「症狀：妄想」>洗入抽牌堆。"
  },
  Skill_21721_Name = {
    Text = "隱匿突襲"
  },
  Skill_21783_Desc_1 = {
    Text = "擊殺一名目標。"
  },
  Skill_21783_Name_1 = {Text = "擊殺"},
  Skill_21837_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_21902_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_21939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_21940_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害失去一層，回合結束失去全部。"
  },
  Skill_21940_Name = {Text = "祈禱"},
  Skill_21948_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害減少一層，回合結束失去全部。"
  },
  Skill_21948_Name = {Text = "祈禱"},
  Skill_21949_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量傷害<BleedingIconKeywords:出血>。"
  },
  Skill_22056_Desc = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_22056_Name = {
    Text = "復仇宣言"
  },
  Skill_22152_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點<CardKeyWord:霜盾>，並對玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_22152_Name = {
    Text = "深海呼喚"
  },
  Skill_22153_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22154_Desc = {
    Text = "自身死亡，分裂為兩個生命與自身相當的「海中之物」。"
  },
  Skill_22155_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。下回合開始時將 [Arg3] 張<DerivativeCardKeywords_80:「窒息」>置入手中。"
  },
  Skill_22156_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22162_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點<CardKeyWord:霜盾>，並對玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_22162_Name = {
    Text = "深海呼喚"
  },
  Skill_22196_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點<CardKeyWord:霜盾>，並對玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_22196_Name = {
    Text = "深海呼喚"
  },
  Skill_22197_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22198_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。下回合獲得 [Arg3] 張<DerivativeCardKeywords_80:「窒息」>。"
  },
  Skill_22199_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22209_Desc_1 = {
    Text = "讓對手無法打出指令卡和打擊。"
  },
  Skill_22209_Name_1 = {
    Text = "超級遲緩"
  },
  Skill_22212_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] <EnergyStorageColour:死鬥>。"
  },
  Skill_22212_Name_1 = {Text = "死鬥"},
  Skill_22218_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，對抽牌堆頂部的 [Arg3] 張卡牌造成 [Arg4] 層遲緩。"
  },
  Skill_22218_Name = {
    Text = "寒氣打擊"
  },
  Skill_22233_Desc = {
    Text = "進化為「維度干涉型融蝕體」。當前生命越高進化的怪物就越強。"
  },
  Skill_22233_Name = {
    Text = "融蝕進化"
  },
  Skill_22234_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將一張<DerivativeCardKeywords_45:「維度閉鎖」>加入玩家手牌。"
  },
  Skill_22234_Name = {
    Text = "維度封鎖"
  },
  Skill_22306_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點 <CardKeyWord:霜盾>。"
  },
  Skill_22306_Name = {
    Text = "冰盾打擊"
  },
  Skill_22316_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。賦予玩家  [Arg3] 張隨機卡牌<CardKeyWord:「怒濤印記」>：使用有該標記的卡牌後會讓本回合怪物的攻擊段數+1，怒濤印記打出後會移除。"
  },
  Skill_22316_Name = {
    Text = "怒濤牽引"
  },
  Skill_22317_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，本回合每受到一次攻擊，獲得 [Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_22317_Name = {
    Text = "巨刃斬擊"
  },
  Skill_22318_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加 [Arg3] 層寄生。"
  },
  Skill_22318_Name = {
    Text = "附骨侵蝕"
  },
  Skill_22319_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_22319_Name = {Text = "深潛"},
  Skill_22320_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22320_Name = {Text = "揮砍"},
  Skill_22331_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_22332_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_22333_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<CardKeyWord:創傷>。創傷：打出「打擊」後，在抽牌堆頂部添加 2  張「傷口」。"
  },
  Skill_22333_Name = {
    Text = "創傷重擊"
  },
  Skill_22344_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_22345_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<CardKeyWord:創傷>。創傷：打出「打擊」後，在抽牌堆頂部添加 2  張「傷口」。"
  },
  Skill_22345_Name = {
    Text = "創傷猛擊"
  },
  Skill_22346_Desc = {
    Text = "獲得[Arg1]點<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_22698_Desc_1 = {
    Text = "將隨機 1~[Arg1] 張<PVPDerivativeCardKeywords_2:「幻象」> 塞入抽牌堆。"
  },
  Skill_22700_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_22700_Name = {
    Text = "維度霧氣"
  },
  Skill_23407_Desc = {
    Text = "獲得[Arg1]點護盾和等同於當前<RetaliateIconKeywords:反擊>的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_23407_Name = {
    Text = "逆鱗之護"
  },
  Skill_23408_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23409_Desc = {
    Text = "獲得等同於當前<RetaliateIconKeywords:反擊>的<PowerIconKeywords:力量>。之後每回合還會獲得 [Arg1] 層反擊。"
  },
  Skill_23409_Name = {
    Text = "蛻變之軀"
  },
  Skill_23410_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_23411_Desc = {
    Text = "獲得 [Arg2] 點護盾和 [Arg1] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_23411_Name = {
    Text = "承自異端之血"
  },
  Skill_23467_Desc = {
    Text = "從 3 個意圖中選擇 2 個附加至達芙黛爾的行動意圖。"
  },
  Skill_23467_Name = {
    Text = "千面幻象·實"
  },
  Skill_23468_Desc = {
    Text = "從 3 個意圖中選擇 2 個附加至達芙黛爾的行動意圖。"
  },
  Skill_23468_Name = {
    Text = "千面幻象·實"
  },
  Skill_23469_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將「症狀：譫妄」與「症狀：盲從」洗入抽牌堆。"
  },
  Skill_23469_Name = {
    Text = "連擊+症狀"
  },
  Skill_23470_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<BleedingIconKeywords:出血>。"
  },
  Skill_23470_Name = {
    Text = "連擊+出血"
  },
  Skill_23471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。降低所有喚醒體 [Arg3] 點狂氣。"
  },
  Skill_23471_Name = {
    Text = "連擊+降狂氣"
  },
  Skill_23472_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。降低敵人 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_23472_Name = {
    Text = "傷害+力量降低"
  },
  Skill_23473_Desc = {
    Text = "將「症狀：譫妄」與「症狀：盲從」洗入抽牌堆。"
  },
  Skill_23473_Name = {
    Text = "VL-13號膠捲"
  },
  Skill_23474_Desc = {
    Text = "降低所有喚醒體狂氣 [Arg1] 點。"
  },
  Skill_23474_Name = {
    Text = "VL-9號膠捲"
  },
  Skill_23475_Desc = {
    Text = "攻擊施加 [Arg1] 層<BleedingIconKeywords:出血>"
  },
  Skill_23475_Name = {
    Text = "VL-7號膠捲"
  },
  Skill_23476_Desc = {
    Text = "施加[Arg1]層力量降低。"
  },
  Skill_23476_Name = {
    Text = "亮晶晶的頭顱"
  },
  Skill_23477_Desc = {
    Text = "增加1次攻擊。"
  },
  Skill_23477_Name = {
    Text = "吵鬧的頭顱"
  },
  Skill_23478_Desc = {
    Text = "施加 2 層易傷。"
  },
  Skill_23478_Name = {
    Text = "咆哮的頭顱"
  },
  Skill_23479_Desc = {
    Text = "獲得 [Arg1] 點護盾。"
  },
  Skill_23480_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23481_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，分別將 1 張<DerivativeCardKeywords_45:「維度閉鎖」>洗入玩家的抽牌堆和棄牌堆。"
  },
  Skill_23481_Name = {
    Text = "原質之海"
  },
  Skill_23482_Desc = {
    Text = "獲得 [Arg1] 點護盾。"
  },
  Skill_23483_Desc = {
    Text = "強化「千面幻象」的效果：需要選擇兩次意圖。若棄掉，則所有喚醒體失去 20 狂氣，並將 5 張「症狀」洗入玩家抽牌堆。"
  },
  Skill_23483_Name = {
    Text = "維度投射"
  },
  Skill_23484_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_23484_Name = {
    Text = "護盾+傷害"
  },
  Skill_23485_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<BleedingIconKeywords:出血>，塞入2張「症狀：譫妄」。"
  },
  Skill_23485_Name = {
    Text = "連擊+出血+症狀"
  },
  Skill_23486_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，降低所有喚醒體 [Arg3] 點狂氣，塞入 2 張「症狀：譫妄」。"
  },
  Skill_23486_Name = {
    Text = "連擊+降低狂氣+症狀"
  },
  Skill_23487_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23488_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23489_Desc = {
    Text = "從 3 個意圖中選擇 2 個附加至達芙黛爾的行動意圖。"
  },
  Skill_23489_Name = {
    Text = "千面幻象·實"
  },
  Skill_23490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_23490_Name = {
    Text = "斷頸一擊"
  },
  Skill_23491_Desc = {
    Text = "獲得 [Arg1] 點護盾，提升 [Arg2] 點力量。"
  },
  Skill_23491_Name = {
    Text = "護盾+力量"
  },
  Skill_23492_Desc = {
    Text = "獲得 [Arg1] 點護盾,並驅散達芙黛爾的所有負面狀態。"
  },
  Skill_23492_Name = {Text = "護盾"},
  Skill_23493_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_23493_Name = {
    Text = "護盾+傷害"
  },
  Skill_23494_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。降低所有喚醒體 [Arg3] 點狂氣，施加 [Arg4] 層<BleedingIconKeywords:出血>，將「症狀：譫妄」與「症狀：盲從」洗入抽牌堆。"
  },
  Skill_23495_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_23495_Name = {
    Text = "傷害+易傷"
  },
  Skill_23496_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。降低敵人 [Arg3] 點<PowerIconKeywords:力量>。施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_23496_Name = {
    Text = "傷害+易傷+力量降低"
  },
  Skill_23497_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。"
  },
  Skill_23497_Name = {
    Text = "食腦水仙"
  },
  Skill_23498_Desc = {
    Text = "獲得 [Arg1] 點護盾，並驅散達芙黛爾的所有負面狀態。"
  },
  Skill_23499_Desc = {
    Text = "提升 [Arg1] 點力量。"
  },
  Skill_23500_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，降低敵人 [Arg3] 點<PowerIconKeywords:力量>，施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_23501_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23501_Name = {Text = "傷害"},
  Skill_23502_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，降低敵人 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_23502_Name = {
    Text = "傷害+力量降低"
  },
  Skill_23503_Desc = {
    Text = "獲得 [Arg1] 點護盾，提升 [Arg2] 點力量。"
  },
  Skill_23503_Name = {
    Text = "護盾+力量"
  },
  Skill_23504_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。獲得 [Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_23504_Name = {
    Text = "護盾+傷害+力量"
  },
  Skill_23505_Desc = {
    Text = "從3個意圖中選擇1個附加至達芙黛爾的行動意圖。"
  },
  Skill_23505_Name = {
    Text = "千面幻象·虛"
  },
  Skill_23506_Desc = {
    Text = "從 3 個意圖中選擇 1 個附加至達芙黛爾的行動意圖。"
  },
  Skill_23506_Name = {
    Text = "千面幻象·虛"
  },
  Skill_23507_Desc = {
    Text = "從 3 個意圖中選擇 1 個附加至達芙黛爾的行動意圖。"
  },
  Skill_23507_Name = {
    Text = "千面幻象·虛"
  },
  Skill_23508_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_23508_Name = {
    Text = "傷害+易傷"
  },
  Skill_23509_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_23509_Name = {
    Text = "斷頸一擊"
  },
  Skill_23510_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。獲得 [Arg4] 點<PowerIconKeywords:力量>。驅散達芙黛爾的所有負面狀態。"
  },
  Skill_23511_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<BleedingIconKeywords:出血>，降低所有喚醒體 [Arg4] 點狂氣。"
  },
  Skill_23511_Name = {
    Text = "連擊+出血+降低狂氣"
  },
  Skill_23729_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每當造成未被格擋的傷害，就會造成 1 層<FragileIconKeywords:脆弱>。"
  },
  Skill_23729_Name = {Text = "追獵"},
  Skill_23756_Desc = {
    Text = "打出後受到 [Arg1] 點<FixedDamage:純粹傷害>，抽 2 張牌。"
  },
  Skill_23758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將玩家本回合最後打出的指令卡移回牌庫頂並使對方下回合抽牌數 -1 。"
  },
  Skill_23761_Desc = {
    Text = "卡茜亞獲得「移形換影」。對方打出卡牌 10 次後立即在身前召喚 1 個少量生命的「分身」。"
  },
  Skill_23761_Name = {Text = "覺醒"},
  Skill_23810_Desc = {
    Text = "<TouquKeywords:永久偷取> [Arg1] 點<PowerIconKeywords:力量>，下回合開始時對方抽牌數-3，並展示牌庫頂的三張牌，對方選擇 1 張加入手牌。"
  },
  Skill_23810_Name = {
    Text = "通通消失！"
  },
  Skill_23811_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張算力消耗為 3 的「跳動的炸彈」立刻置入玩家手牌。霍迪妮每有 1 層「洋洋得意」，「跳動的炸彈」的算力消耗減少 1 點。"
  },
  Skill_23811_Name = {
    Text = "無中生有"
  },
  Skill_23812_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_23812_Name = {
    Text = "魔術牌：穿破"
  },
  Skill_23813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。同時將 5 張「褻瀆假像」卡牌置入手牌，霍迪妮每有 1 層「洋洋得意」，會將其中 1 張「褻瀆假像」替換為「靈感」。"
  },
  Skill_23813_Name = {
    Text = "特技飛牌"
  },
  Skill_23814_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 5 張「鬼牌」分別塞入對方的手牌堆，抽牌堆和棄牌堆。"
  },
  Skill_23814_Name = {
    Text = "魔術嘉年華"
  },
  Skill_23815_Desc = {
    Text = "在自身前方召喚 1 個「霍迪妮」的玩偶。每有 1 層「洋洋得意」會減降低其 20% 的最大生命值，最低降至 1 點。"
  },
  Skill_23815_Name = {
    Text = "大變活人"
  },
  Skill_23816_Desc = {
    Text = "將 1 張帶有「消耗」和「保留」的「幸運觀眾」置入對方手牌。"
  },
  Skill_23816_Name = {
    Text = "幸運觀眾"
  },
  Skill_23817_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_23817_Name = {
    Text = "魔術牌：衰弱"
  },
  Skill_23818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_23818_Name = {
    Text = "魔術連打"
  },
  Skill_23819_Desc = {
    Text = "炸彈每在手牌中經過 1 回合計數會增加 1，計數到達 2 時且回合結束時若在手牌，對己方隊伍造成 <Damage:[Damage:Arg1]> 點<FixedDamage:純粹傷害>且銷毀。當前計數：<RedQuality:[Arg2]>。"
  },
  Skill_23819_Name = {
    Text = "跳動的炸彈"
  },
  Skill_23820_Desc = {
    Text = "炸彈每在手牌中經過 1 回合計數會增加 1，計數到達 2 時且回合結束時若在手牌，對己方隊伍造成 <Damage:[Damage:Arg1]> 點<FixedDamage:純粹傷害>且銷毀。當前計數：<RedQuality:[Arg2]>。"
  },
  Skill_23820_Name = {
    Text = "跳動的炸彈"
  },
  Skill_23821_Desc = {
    Text = "炸彈每在手牌中經過 1 回合計數會增加 1，計數到達 2 時且回合結束時若在手牌，對己方隊伍造成 <Damage:[Damage:Arg1]> 點<FixedDamage:純粹傷害>且銷毀。當前計數：<RedQuality:[Arg2]>。"
  },
  Skill_23821_Name = {
    Text = "跳動的炸彈"
  },
  Skill_23822_Desc = {
    Text = "炸彈每在手牌中經過 1 回合計數會增加 1，計數到達 2 時且回合結束時若在手牌，對己方隊伍造成 <Damage:[Damage:Arg1]> 點<FixedDamage:純粹傷害>且銷毀。當前計數：<RedQuality:[Arg2]>。"
  },
  Skill_23822_Name = {
    Text = "跳動的炸彈"
  },
  Skill_24173_Desc_1 = {
    Text = "指定的所有喚醒體將不再死亡。"
  },
  Skill_24209_Desc = {
    Text = "失去 [Arg1]% 當前生命([Arg2])，使「神國腕肢」對後排敵方造成 3 倍傷害([Arg3])，若在首領戰中則造成 10 倍傷害([Arg4])。"
  },
  Skill_24209_Name = {
    Text = "代行者的裁決"
  },
  Skill_24243_Desc = {
    Text = "正在尋找它的下一個目標…"
  },
  Skill_24243_Name = {Text = "尋蹤"},
  Skill_24244_Desc = {
    Text = "選擇一名喚醒體，獲得 50 狂氣。但使「海德拉」獲得 [Arg1] 點力量。"
  },
  Skill_24244_Name = {Text = "執念"},
  Skill_24417_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_24418_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_24418_Name = {
    Text = "無上生祭"
  },
  Skill_24586_Desc = {
    Text = "造成 1 次 <Damage:[Damage:Arg1]> 點傷害，自身死亡。"
  },
  Skill_24586_Name = {
    Text = "臨別贈禮"
  },
  Skill_24587_Desc = {
    Text = "對方本回合使用算力 3 及以上的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24587_Name = {
    Text = "「低語」\n算力 ≥3"
  },
  Skill_24604_Desc = {
    Text = "擊暈所有「N」的分身。"
  },
  Skill_24604_Name = {
    Text = "薔薇的願望"
  },
  Skill_24605_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。自身施加 1 層「黑暗」和 4 層「混沌」狀態，每有一層「黑暗」狀態生成一個分身，最多生成 3 個。"
  },
  Skill_24605_Name = {
    Text = "黑色召喚"
  },
  Skill_24606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張「無上蒙寵」置入對方手牌。"
  },
  Skill_24606_Name = {
    Text = "盲目契約"
  },
  Skill_24607_Desc = {
    Text = "獲得 2 點算力，將一張能夠擊暈分身的「薔薇的願望」加入手中，對抽牌堆中 4 張牌施加<SlowIconKeywords:遲緩>。"
  },
  Skill_24607_Name = {
    Text = "無上蒙寵"
  },
  Skill_24608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_24609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對全體友方施加 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_24609_Name = {
    Text = "伏行之霧"
  },
  Skill_24634_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 4 張「輪回悖論」加入手牌。"
  },
  Skill_24634_Name = {
    Text = "四翼漸生"
  },
  Skill_24635_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 6 張「輪回悖論」加入手牌。"
  },
  Skill_24635_Name = {
    Text = "六翼滿開"
  },
  Skill_24636_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 2 張「輪回悖論」加入手牌。"
  },
  Skill_24636_Name = {
    Text = "雙翼初張"
  },
  Skill_24637_Desc = {
    Text = "提升 2 倍生命上限。每回合開始時將 1 張「回答塔薇」置入手中。"
  },
  Skill_24637_Name = {Text = "復甦"},
  Skill_24638_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>並獲得 <Block:[Block:Arg2]> 點護盾，並施加 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_24646_Desc = {
    Text = "對方在本回合使用症狀卡後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24646_Name = {
    Text = "「低語」\n症狀"
  },
  Skill_24647_Desc = {
    Text = "對方本回合出牌數量達到 5 張時，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24647_Name = {
    Text = "「低語」\n出牌 5"
  },
  Skill_24648_Desc = {
    Text = "對方本回合釋放鑰令後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24648_Name = {
    Text = "「低語」\n鑰令"
  },
  Skill_24649_Desc = {
    Text = "對方本回合使用算力為 0 的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24649_Name = {
    Text = "「低語」\n算力 0"
  },
  Skill_24650_Desc = {
    Text = "對方本回合使用 2 次狂氣爆發後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24650_Name = {
    Text = "「低語」\n狂氣爆發2"
  },
  Skill_24695_Desc = {
    Text = "對方本回合出牌數量達到 5 張時，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24695_Name = {
    Text = "「低語」\n出牌 5"
  },
  Skill_24696_Desc = {
    Text = "對方在本回合使用症狀卡後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24696_Name = {
    Text = "「低語」\n症狀"
  },
  Skill_24697_Desc = {
    Text = "對方本回合釋放鑰令後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24697_Name = {
    Text = "「低語」\n鑰令"
  },
  Skill_24698_Desc = {
    Text = "對方本回合釋放鑰令後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24698_Name = {
    Text = "「低語」\n鑰令"
  },
  Skill_24699_Desc = {
    Text = "對方本回合使用算力 3 及以上的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24699_Name = {
    Text = "「低語」\n算力 ≥3"
  },
  Skill_24700_Desc = {
    Text = "對方本回合使用算力 3 及以上的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24700_Name = {
    Text = "「低語」\n算力 ≥3"
  },
  Skill_24701_Desc = {
    Text = "對方本回合使用算力為 0 的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24701_Name = {
    Text = "「低語」\n算力 0"
  },
  Skill_24702_Desc = {
    Text = "對方本回合使用算力為 0 的卡牌後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24702_Name = {
    Text = "「低語」\n算力 0"
  },
  Skill_24703_Desc = {
    Text = "對方本回合使用 2 次狂氣爆發後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24703_Name = {
    Text = "「低語」\n狂氣爆發2"
  },
  Skill_24704_Desc = {
    Text = "對方本回合出牌數量達到 5 張時，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24704_Name = {
    Text = "「低語」\n出牌 5"
  },
  Skill_24705_Desc = {
    Text = "對方本回合使用 2 次狂氣爆發後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24705_Name = {
    Text = "「低語」\n狂氣爆發2"
  },
  Skill_24706_Desc = {
    Text = "對方在本回合使用症狀卡後，將行動意圖切換為「臨別贈禮」。"
  },
  Skill_24706_Name = {
    Text = "「低語」\n症狀"
  },
  Skill_24713_Desc = {
    Text = "「環行・拉蒙娜」獲得 15 狂氣，其他喚醒體扣除 3 狂氣。此卡回合結束若在手中，對我方造成 [Arg1] 點<FixedDamage:純粹傷害>。"
  },
  Skill_24713_Name = {
    Text = "輪回悖論"
  },
  Skill_24714_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] <PowerColourKeywords:力量降低>。"
  },
  Skill_24982_Desc = {
    Text = "施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，回復珈倫 [Arg2]% 已損失生命並獲得等量護盾。"
  },
  Skill_24982_Name = {
    Text = "靜默守望"
  },
  Skill_24983_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_24983_Name = {
    Text = "女僕魔法"
  },
  Skill_24984_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。降低對方 [Arg3] 點最大生命。"
  },
  Skill_24986_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合的<WeaknessIconKeywords:虛弱>，將 1 張「黑暗料理」加入手中。"
  },
  Skill_24986_Name = {
    Text = "蟾蜍燉菜"
  },
  Skill_24987_Desc = {
    Text = "打出後獲得 3 點算力並對自身造成 1 回合<WeaknessIconKeywords:虛弱>，<VulnerabilityIconKeywords:易傷>，<FragileIconKeywords:脆弱>和 [Arg1] 層<IntoxicationIconKeywords:中毒>。若回合結束時在手中，對抽牌堆或棄牌堆隨機 2 張指令卡造成<SlowIconKeywords:遲緩>。"
  },
  Skill_24987_Name = {
    Text = "珈倫的特製料理"
  },
  Skill_24988_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 2 張「黑暗料理」置入對方手牌。獲得「吃飽喝足」2 回合：己方隊伍每次消耗算力，就使珈倫獲得 [Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_24988_Name = {
    Text = "客官請慢用！"
  },
  Skill_24989_Desc = {
    Text = "打出後獲得 2 點算力和 [Arg1] 點<IntoxicationIconKeywords:中毒>。若回合結束時在手中，對抽牌堆或棄牌堆隨機 1 張指令卡造成<SlowIconKeywords:遲緩>。"
  },
  Skill_25058_Desc = {
    Text = "將 2 張 「珈倫的特製料理」置入對方手牌堆。獲得「吃飽喝足」3 回合 ：每次消耗算力，就使珈倫獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_25058_Name = {Text = "覺醒"},
  Skill_25127_Desc_1 = {
    Text = "丟棄所有卡牌，獲得每個喚醒體 2 張打擊。"
  },
  Skill_25127_Name_1 = {
    Text = "獲得打擊"
  },
  Skill_25173_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_25174_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_25175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_25176_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對全體友方施加 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_25176_Name = {
    Text = "伏行之霧"
  },
  Skill_25182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 4 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_25182_Name = {
    Text = "四翼漸生"
  },
  Skill_25183_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 2 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_25183_Name = {
    Text = "雙翼初張"
  },
  Skill_25184_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 6 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_25184_Name = {
    Text = "六翼滿開"
  },
  Skill_25389_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_25389_Name = {
    Text = "驚奇表演"
  },
  Skill_25411_Desc = {
    Text = "每回合開始時默認的觸腕基礎姿態，觸腕傷害為 100%。若回合結束時仍處於「潮湧」姿態，生成 1 條永久觸腕。"
  },
  Skill_25411_Name = {Text = "潮湧"},
  Skill_25412_Desc = {
    Text = "·本回合觸腕傷害降低 50％，獲得 <Block:[Block:Arg1]> 點護盾，後續每次觸腕攻擊時獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_25412_Name = {Text = "靜海"},
  Skill_25412_tempBattleDesc_1 = {
    Text = "·本回合觸腕傷害降低 50％，獲得 <Block:[Block:Arg1]> 點護盾，後續每次觸腕攻擊時獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_25412_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，回合結束時觸腕不再攻擊，3 回合冷卻。"
  },
  Skill_25412_tempBattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，回合結束時觸腕不再攻擊，3 回合冷卻。"
  },
  Skill_25413_Desc = {
    Text = "·本回合觸腕傷害變為 [Arg1]%，造成主動傷害後，使 1 條觸腕攻擊目標敵方，造成 [Arg3]％ 觸腕傷害，回合結束時失去 1 條觸腕。當前永久觸腕數量超過 1 條時，才可選擇該姿態。"
  },
  Skill_25413_Name = {Text = "怒濤"},
  Skill_25413_tempBattleDesc_1 = {
    Text = "·本回合觸腕傷害變為 [Arg1]%，造成主動傷害後，使 1 條觸腕攻擊目標敵方，造成 [Arg3]％ 觸腕傷害，回合結束時失去 1 條觸腕。當前永久觸腕數量超過 1 條時，才可選擇該姿態。"
  },
  Skill_25413_tempBattleDesc_2 = {
    Text = "本回合觸腕傷害變為 [Arg2]％，造成主動傷害後，使 1 條觸腕攻擊敵方。回合結束時失去 1 條觸腕。當前永久觸腕數量超過 1 條時，才可選擇該姿態，3 回合冷卻。"
  },
  Skill_25413_tempBattleDesc_3 = {
    Text = "本回合觸腕傷害變為 [Arg2]％，造成主動傷害後，使 1 條觸腕攻擊敵方。回合結束時失去 1 條觸腕。當前永久觸腕數量超過 1 條時，才可選擇該姿態，3 回合冷卻。"
  },
  Skill_30362_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張「鬼牌」塞入對方的抽牌堆頂。"
  },
  Skill_30362_Name = {Text = "驚喜！"},
  Skill_34668_Desc = {
    Text = "丟棄所有手牌，選擇 1 名其他喚醒體獲得 100 點狂氣，獲得其整副套牌並附加「回手」，算力重置到100，然後「生成套牌」回到手中。"
  },
  Skill_34674_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_34675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_34676_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。將 [Arg2] 張<DerivativeCardKeywords_45:<DerivativeCardKeywords_45:「維度閉鎖」>>洗入抽牌堆。"
  },
  Skill_34677_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。將 [Arg2] 張<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆。"
  },
  Skill_34682_Desc = {
    Text = "讓所有怪物血量+9999999。"
  },
  Skill_34682_Name = {
    Text = "無敵怪物"
  },
  Skill_35502_Desc = {
    Text = "消耗所有猩紅熔爐回復量，回復 [Heal:Arg1] 點生命。至多可積攢 [Arg2] 點猩紅熔爐。"
  },
  Skill_35502_Name = {
    Text = "猩紅熔爐"
  },
  Skill_35502_tempBattleDesc_1 = {
    Text = "消耗所有猩紅熔爐回覆量，回覆 [Heal:Arg1] 點生命。至多可積攢 [Arg2] 點猩紅熔爐。對所有敵人造成目標最大生命值 1％ 的侵蝕，消耗的猩紅熔爐越多侵蝕效果就越強，至多提高 100%。對「空殼」敵人造成 5 倍侵蝕效果。3 回合冷卻。"
  },
  Skill_35507_Desc = {
    Text = "選擇一名喚醒體成為「幸運觀眾」，賦予其所有卡牌「保留」。打出「幸運觀眾」的卡牌會削弱「霍迪妮」的技能且降低其力量，但失去少量最大生命。"
  },
  Skill_35507_Name = {
    Text = "幸運觀眾"
  },
  Skill_35522_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_35522_Name = {
    Text = "顱骨猛擊"
  },
  Skill_35523_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_35524_Desc = {
    Text = "獲得[Arg1]點<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_35526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_35526_Name = {Text = "重擊"},
  Skill_35528_Desc = {
    Text = "施加 [Arg1] 層出血。"
  },
  Skill_35671_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_35671_Name = {Text = "強化"},
  Skill_35742_Desc = {
    Text = "回復 [Arg1]% 已損失生命([Arg2])並獲得等量的護盾，獲得 [Arg3] 銀鑰能量。"
  },
  Skill_35742_Name = {
    Text = "烏托邦帷幕"
  },
  Skill_35743_Desc = {
    Text = "查看 3 個未攜帶的鑰令，選擇 1 個立即釋放。"
  },
  Skill_35743_Name = {
    Text = "烏托邦帷幕"
  },
  Skill_35960_Desc = {
    Text = "施加 1 回合<FragileIconKeywords:脆弱> 和 [Arg1] 點中毒。"
  },
  Skill_35961_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_35962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_35963_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_35964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_35965_Desc = {
    Text = "施加 1 回合<WeaknessIconKeywords:虛弱>，封印狂氣最高喚醒體 1 回合。"
  },
  Skill_36003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36004_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_36005_Desc = {
    Text = "移除負面狀態，獲得  <Block:[Block:Arg1]> 點護盾並獲得 1 層瘋狂。"
  },
  Skill_36005_Name = {Text = "蛻變"},
  Skill_36025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36026_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36027_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，賦予玩家 4 張算力最低的卡牌「深潛印記」。"
  },
  Skill_36028_Name = {
    Text = "標記獵物"
  },
  Skill_36029_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36030_Desc = {
    Text = "帶刺的珊瑚刺入了體內！"
  },
  Skill_36030_Name = {
    Text = "珊瑚贅生"
  },
  Skill_36031_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36033_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，賦予玩家 4 張算力最低的卡牌「深潛印記」。"
  },
  Skill_36034_Name = {
    Text = "標記獵物"
  },
  Skill_36035_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36037_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。召喚一個「睡夢之子」在身前和一個「水之子」在身後。"
  },
  Skill_36037_Name = {Text = "虔誠"},
  Skill_36038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36039_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張「寄生珊瑚」加入抽牌堆頂。"
  },
  Skill_36040_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_36040_Name = {Text = "虔誠"},
  Skill_36041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36042_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，賦予玩家 2 張算力最低的卡牌「深潛印記」。"
  },
  Skill_36042_Name = {
    Text = "標記獵物"
  },
  Skill_36043_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36044_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。召喚一個「睡夢之子」在身前。"
  },
  Skill_36044_Name = {Text = "虔誠"},
  Skill_36045_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。召喚一個「水之子」在身後。"
  },
  Skill_36045_Name = {Text = "虔誠"},
  Skill_36046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張「寄生珊瑚」加入抽牌堆頂和棄牌堆頂。"
  },
  Skill_36047_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_36047_Name = {Text = "虔誠"},
  Skill_36048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36049_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。回復其他友方等同於自身生命的值，自身死亡。"
  },
  Skill_36077_Desc = {
    Text = "獲得 1 層瘋狂，對 2 張卡牌施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_36077_Name = {Text = "瘋狂"},
  Skill_36078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。棄掉玩家所有手牌。"
  },
  Skill_36078_Name = {Text = "離散"},
  Skill_36079_Desc = {
    Text = "獲得 1 層瘋狂，對 3 張卡牌施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_36079_Name = {Text = "瘋狂"},
  Skill_36080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張「寄生珊瑚」加入抽牌堆頂。"
  },
  Skill_36081_Desc = {
    Text = "獲得 1 層瘋狂，對 2 張卡牌施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_36081_Name = {Text = "瘋狂"},
  Skill_36082_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚 1 個「靈覺之子」。"
  },
  Skill_36082_Name = {Text = "惡誕"},
  Skill_36083_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_36083_Name = {
    Text = "深海洗禮"
  },
  Skill_36084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。棄掉玩家所有手牌。"
  },
  Skill_36084_Name = {Text = "離散"},
  Skill_36085_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>，每有 1 個其他友方自身就獲得 1 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_36085_Name = {
    Text = "深海洗禮"
  },
  Skill_36086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_36086_Name = {
    Text = "深海洗禮"
  },
  Skill_36087_Desc = {
    Text = "將 3 張「裂傷」加入手中。"
  },
  Skill_36087_Name = {Text = "裂傷"},
  Skill_36088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。棄掉玩家所有手牌。"
  },
  Skill_36088_Name = {Text = "離散"},
  Skill_36089_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_36090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚 1 個「水之子」。"
  },
  Skill_36090_Name = {Text = "惡誕"},
  Skill_36177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚「靈覺之子」、「睡夢之子」、「水之子」。"
  },
  Skill_36177_Name = {Text = "孽誕"},
  Skill_36179_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_36180_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_36255_Desc = {
    Text = "施加 [Arg1] 層<BleedingIconKeywords:出血>和 [Arg2] 點護盾。"
  },
  Skill_36255_Name = {
    Text = "舊日之夢"
  },
  Skill_36256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，對抽牌堆或棄牌堆隨機 3 張指令卡施加 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_36256_Name = {
    Text = "夢魘編織"
  },
  Skill_36257_Desc = {
    Text = "生命上限增加至 300%，回復所有生命並獲得 [Arg3] 點護盾。獲得 7 條觸腕上限。每回合結束時獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_36257_Name = {
    Text = "受誕之種"
  },
  Skill_36258_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 50% 等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_36258_Name = {
    Text = "萬世之苦"
  },
  Skill_36259_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機封印 [Arg3] 個喚醒體。"
  },
  Skill_36259_Name = {Text = "長夢"},
  Skill_36260_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_36260_Name = {Text = "夢囈"},
  Skill_36261_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_36326_Desc = {
    Text = "消耗 1 層神母權能，獲得 [Arg3] 點<PowerIconKeywords:力量>，降低「聖嬰」 [Arg2] 點觸腕傷害。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_36326_Name = {
    Text = "呵斥，以報恩仇"
  },
  Skill_36327_Desc = {
    Text = "消耗 1 層神母權能，獲得 3 點算力，抽 3 張牌。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_36327_Name = {
    Text = "犧牲，以敬自由"
  },
  Skill_36328_Desc = {
    Text = "消耗 1 層神母權能，所有喚醒體獲得 20 點狂氣，使「聖嬰」的觸腕立刻對「聖嬰」造成 10 倍傷害，造成 [Arg2] 點觸腕傷害 [Arg3] 次。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_36328_Name = {
    Text = "刎頸，以行威儀"
  },
  Skill_36329_Desc = {
    Text = "回復 1 層神母權能，神母權能可被消耗觸發墨菲的其他能力，最多回復至 3 層。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_36330_Desc = {
    Text = "對前排敵人造成其 25％ 最大生命值（[Arg1]）的<FixedDamage:純粹傷害>，使其昏迷 1 回合。"
  },
  Skill_36330_Name = {Text = "王權"},
  Skill_36331_Desc = {
    Text = "昏迷中，無法行動。"
  },
  Skill_36356_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。自身死亡。"
  },
  Skill_36357_Desc = {
    Text = "<TouquKeywords:永久偷取>玩家 [Arg1] 點<PowerIconKeywords:力量>增益狀態。"
  },
  Skill_36358_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_36365_Desc = {
    Text = "召喚 1 個「海中之物」在身前。"
  },
  Skill_36366_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>洗入對方抽牌堆。"
  },
  Skill_36367_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印狂氣最高喚醒體。"
  },
  Skill_36368_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點護盾，玩家每擁有 1 張剩餘手牌額外獲得 [Arg4] 點護盾。"
  },
  Skill_36368_Name = {Text = "試探"},
  Skill_36648_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點護盾，每層「孕育」使護盾提高 [Arg4] 點。"
  },
  Skill_36648_Name = {Text = "試探"},
  Skill_36649_Desc = {
    Text = "召喚 1 個「靈覺之子」在身後，每層「孕育」都會使其更強！"
  },
  Skill_36649_Name = {
    Text = "應選之人"
  },
  Skill_36650_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點護盾，玩家每擁有 1 張剩餘手牌額外獲得 [Arg4] 點護盾。"
  },
  Skill_36650_Name = {Text = "試探"},
  Skill_36651_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_3:「驚厥」>洗入對方抽牌堆。"
  },
  Skill_36651_Name = {
    Text = "無上生祭"
  },
  Skill_36652_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印狂氣最高喚醒體。"
  },
  Skill_36653_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚 2 個「睡夢之子」在身前。"
  },
  Skill_36653_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_36654_Desc = {
    Text = "召喚 1 個「海中之物」在身後。"
  },
  Skill_36655_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印所有喚醒體，召喚 2 個「利莫里亞的希望」在身前。"
  },
  Skill_36655_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_36656_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印狂氣最高的喚醒體 1 回合。"
  },
  Skill_36657_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>洗入對方抽牌堆。"
  },
  Skill_36800_Desc = {
    Text = "從抽牌堆中抽 [Arg1] 張算力消耗最低的卡牌。若當前界域為「深海」，則額外使<TentacleInjurieIconKeywords:觸腕傷害>提高 [Arg2] 點。"
  },
  Skill_36800_Name = {
    Text = "奧瑞塔的寶藏"
  },
  Skill_36807_BattleDesc = {
    Text = "選擇 1 名喚醒體使其獲得 <Energy:[Arg2]>  點狂氣，獲得 [Arg3] 點<PowerIconKeywords:力量>，若當前界域為「血肉」，額外使<EmbryoFusionIconKeywords:胚胎融合> + [Arg4]，但失去 10%([Arg1])當前生命。"
  },
  Skill_36807_Desc = {
    Text = "選擇 1 名喚醒體使其獲得 <Energy:[Arg2]>  點狂氣，獲得 [Arg3] 點<PowerIconKeywords:力量>，若當前界域為「血肉」，額外使<EmbryoFusionIconKeywords:胚胎融合> + [Arg4]，但失去 10%當前生命。"
  },
  Skill_36807_Name = {
    Text = "咆哮的血與沙"
  },
  Skill_36808_Desc = {
    Text = "獲得 [Arg4] 點算力。選擇 1 名喚醒體，將其 [Arg1] 張「打擊」與 [Arg1] 張「防禦」的原始複製置入手中，並使他們獲得<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虛無>。若當前界域為「超維」，則額外獲得 [Arg2] 點臨時<PowerIconKeywords:力量>與 [Arg3] 點臨時<AlertIconKeywords:戒備>。"
  },
  Skill_36808_Name = {
    Text = "短暫的永恆"
  },
  Skill_36809_Desc = {
    Text = "獲得 [Arg1]% 臨時暴擊率和 [Arg2] 點臨時<PowerIconKeywords:力量>。 若在首領戰中且本回合尚未打出過任何牌，則嘗試觸發 [Arg3] 次死亡抵抗，若成功則獲得 <Block:[Block:Arg4]> 點護盾，此效果只能觸發 [Arg5] 次。"
  },
  Skill_36809_Name = {
    Text = "最後的誓言"
  },
  Skill_36843_Desc = {
    Text = "從抽牌堆中選擇 [Arg1] 張牌加入手中，並使其算力消耗降低 [Arg2]。"
  },
  Skill_36844_Desc = {
    Text = "對生命最高敵人造成 [Arg2] 點<IntoxicationIconKeywords:中毒>，獲得 <Block:[Block:Arg1]> 點護盾。若本回合觸發過「吞噬」，不再獲得護盾，觸發該敵人 50％ <IntoxicationIconKeywords:中毒>。"
  },
  Skill_36845_Desc = {
    Text = "獲得 [Arg1] 點算力，下回合開始時獲得 <Block:[Block:Arg2]> 點護盾。若當前界域為「深海」且處於「潮湧」姿態，則效果變為生成 [Arg3] 條觸腕。"
  },
  Skill_36845_Name = {
    Text = "蝕骨的擁抱"
  },
  Skill_36846_Desc = {
    Text = "獲得 [Arg1] 點<RetaliateIconKeywords:反擊>，臨時降低所有敵人 [Arg2] 點<ExhaustionIconKeywords:力量>。若當前處於「超維回合」，不再降低臨時<PowerIconKeywords:力量>，對所有敵人觸發 100％ <RetaliateIconKeywords:反擊>。"
  },
  Skill_36846_Name = {
    Text = "腐爛盛筵"
  },
  Skill_36851_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，將 [Arg2] 張<DerivativeCardKeywords_4:「靈感」>置入手中。若當前為超維回合，效果變更為將 [Arg3] 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  Skill_36851_Name = {
    Text = "灰霧真容"
  },
  Skill_36852_Desc = {
    Text = "抽 1 張牌，如果抽到指令卡或靈知覺醒，將其算力消耗變為 0，並使其擁有者獲得 <Energy:[Arg1]> 點狂氣。否則將這張牌棄掉並重複此條效果。"
  },
  Skill_36852_Name = {
    Text = "仲夏之夢"
  },
  Skill_36853_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。受到攻擊傷害時，下回合開始時獲得 [Arg2]% 傷害的護盾。若當前界域為「血肉」，不再獲得延遲護盾，而是積攢 10% 傷害的回復量到猩紅熔爐。"
  },
  Skill_36853_Name = {
    Text = "神跡降臨"
  },
  Skill_36854_Desc = {
    Text = "獲得 1 點算力和 [Arg1] 點<PowerIconKeywords:力量>，選擇一名喚醒體獲得 [Arg2] 點狂氣。若當前界域為「深海」且處於「怒濤」姿態，效果改為獲得 [Arg3]% 臨時暴擊率和臨時暴擊傷害。"
  },
  Skill_36855_Desc = {
    Text = "界域精通提高 [Arg1]。選擇 1 名喚醒體使其獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_36856_BattleDesc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，抽 2 張牌。若當前界域為「血肉」，損失 10% 當前生命([Arg3])，額外獲得 [Arg2] 點臨時<PowerIconKeywords:力量>，手中每有 1 張<DerivativeCardKeywords_2:「胚胎」>額外獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_36856_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，抽 2 張牌。若當前界域為「血肉」，損失 10% 當前生命，額外獲得 [Arg2] 點臨時<PowerIconKeywords:力量>，手中每有 1 張<DerivativeCardKeywords_2:「胚胎」>額外獲得 [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_36856_Name = {
    Text = "玫瑰的勝利"
  },
  Skill_39273_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_3950_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<FragileIconKeywords:脆弱>。"
  },
  Skill_3951_AwakerSkillBackgroundStory = {
    Text = "白天鵝在如鏡的湖面徘徊。"
  },
  Skill_3951_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3951_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣，觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3951_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。莉茲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3951_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。莉茲獲得 <Energy:[Energy:Arg2]> 點狂氣，觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3951_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_3951_Name = {Text = "防禦"},
  Skill_3951_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_3952_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。每回合對手牌中剩餘卡牌施加「<SlowIconKeywords:遲緩>」。"
  },
  Skill_3952_Name = {Text = "覺醒"},
  Skill_3953_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3954_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次。獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_3955_Desc = {
    Text = "為前排友方施加 [Arg1] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_3956_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3957_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3958_Desc = {
    Text = "每回合開始時獲得護盾，等同於上回合受到的傷害的一半。"
  },
  Skill_3958_Name = {
    Text = "獻媚者之擁"
  },
  Skill_3960_Desc = {
    Text = "回合結束時若在手中，自身<WeaknessIconKeywords:虛弱> 1 回合。使用後<WeaknessIconKeywords:虛弱>所有敵人 1 回合。無法出售。"
  },
  Skill_3960_Name = {
    Text = "症狀：衰弱"
  },
  Skill_3961_AwakerSkillBackgroundStory = {
    Text = "行家一出手，就知有沒有。\n聰明人應該學會模仿萊克的押注。"
  },
  Skill_3961_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3961_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。若算力不足時可消耗 3 點黑印打出並生效 2 次。當前黑印：[Arg3]）"
  },
  Skill_3961_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。萊克獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3961_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。萊克獲得 <Energy:[Energy:Arg2]> 點狂氣。若算力不足時可消耗 3 點黑印打出並生效 2 次。"
  },
  Skill_3961_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_3961_Name = {Text = "打擊"},
  Skill_3961_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_3962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，提高後續「連續撕咬」的攻擊次數。"
  },
  Skill_3962_Name = {
    Text = "連續撕咬"
  },
  Skill_3963_Desc = {
    Text = "施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。後撤。"
  },
  Skill_3964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3965_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_3966_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_3966_Name = {
    Text = "維度空洞"
  },
  Skill_3967_AwakerSkillBackgroundStory = {
    Text = "誰曾經和女孩說過，\n\n「抱著你的小熊吧，他會守護你的夢。」\n\n這大概是為什麼在喚醒之後，小熊成為了她的保護者吧。"
  },
  Skill_3967_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「萬古之眸」對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>，每次釋放使「萬古之眸」基礎傷害提高 [Arg3]%。"
  },
  Skill_3967_EffectNameList = {Text = "傷害"},
  Skill_3967_Name = {
    Text = "萬古之眸"
  },
  Skill_3967_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則本次「萬古之眸」最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>。每次釋放使「萬古之眸」基礎傷害提高 50%。本回合所有喚醒體造成的最終傷害提高 25%。"
  },
  Skill_3967_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_3967_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「萬古之眸」對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>，每次釋放使「萬古之眸」基礎傷害提高 [Arg3]%。"
  },
  Skill_3967_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「萬古之眸」對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>，每次釋放使「萬古之眸」基礎傷害提高 [Arg3]%。艾繼絲打出的下一張「防禦」生效 3 次。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則本次「萬古之眸」最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>。每次釋放使「萬古之眸」基礎傷害提高  [Arg3]%。本回合所有喚醒體造成的最終傷害提高 25%。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：對所有敵人施加 1 回合的<PetrifactionIconKeywords:石化>，若目標擁有石化抗性則本次「萬古之眸」最終傷害提高 200%。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>。每次釋放使「萬古之眸」基礎傷害提高 [Arg3]%。本回合所有喚醒體造成的最終傷害提高 25%。艾繼絲打出的下一張「防禦」生效 3 次。"
  },
  Skill_3968_Desc = {
    Text = "回合結束時若在手中，獲得 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3969_Desc = {
    Text = "獲得 [Arg1]點<PowerIconKeywords:力量>，驅散自身<WeaknessIconKeywords:虛弱>與<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_3969_Name = {
    Text = "絕境求生"
  },
  Skill_3970_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_3971_AwakerSkillBackgroundStory = {
    Text = "她手中的刀刃，只會為世間公義舉起。"
  },
  Skill_3971_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3971_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。艾爾瓦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3971_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_3971_Name = {Text = "打擊"},
  Skill_3971_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_3972_AwakerSkillBackgroundStory = {
    Text = "她從不畏懼維度中那些光怪陸離的追蹤者。她自有她的秘法。"
  },
  Skill_3972_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3972_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。<TransitionIconKeywords:躍遷>：獲得 1 點算力。"
  },
  Skill_3972_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。達芙黛爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_3972_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。達芙黛爾獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。<TransitionIconKeywords:躍遷>：獲得 1 點算力。"
  },
  Skill_3972_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_3972_EffectNameList_1 = {
    Text = "護盾,狂氣,力量"
  },
  Skill_3972_Name = {Text = "防禦"},
  Skill_3972_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_3972_PropertyNameList_1 = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_3973_AwakerSkillBackgroundStory = {
    Text = "即將被寂靜吞沒時，她彷彿看到溺死的侍女。\n侍女的皮膚發白，像一朵腐爛的睡蓮躺在湖泊裡，脖頸上的傷痕正順著青白色的脈絡延伸至看不見的遠方。\n「看看你的貓眼石項鍊吧，」屍體說，「全都變成灰啦。變成灰啦......」"
  },
  Skill_3973_Desc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命並獲得 <Block:[Block:Arg2]> 點護盾。回合結束時若在手中，算力消耗提高 1，回復生命和護盾翻倍。最多疊加 [Arg3] 次。"
  },
  Skill_3973_EffectNameList = {
    Text = "回復,護盾"
  },
  Skill_3973_Name = {
    Text = "靜默守望"
  },
  Skill_3973_PropertyNameList = {
    Text = "體質*GrowValue1,防禦力*GrowValue2"
  },
  Skill_3974_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3974_Name = {
    Text = "割喉揮砍"
  },
  Skill_3975_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3977_AwakerSkillBackgroundStory = {
    Text = "「靠近點，別害羞，讓禮帽先生嚐嚐你的歡笑與快樂。」\n卡茜亞大師點點帽檐，砰地一聲變出一大捧緞帶和卡片。\n「在心裡選好你的牌。噓！不要告訴任何人。卡茜亞大師會告訴你哪張是你的唯一。」"
  },
  Skill_3977_Desc_0 = {
    Text = "視為「打擊」。選擇<DimensionalSpaceIconKeywords:超維空間>任意 1 張牌置入手牌並使其算力消耗 -2。隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_3977_Desc_3 = {
    Text = "視為「打擊」。選擇<DimensionalSpaceIconKeywords:超維空間>任意 1 張牌置入手牌並使其算力消耗 -2。隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。<RippleKeywords:餘波>：將 1 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆。"
  },
  Skill_3977_EffectNameList = {
    Text = "傷害,臨時力量"
  },
  Skill_3977_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_3978_Desc = {
    Text = "造成<Block:[Block:Arg1]>護盾，獲得 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_3979_AwakerSkillBackgroundStory = {
    Text = "Schizophrenia.\n早在這個詞被發明以前，赫伯特在實驗室裡已經製造出無數病例了。\n24無疑是其中的集大成之作，她的人格以驚人的速度不斷增殖，且互不干擾。\n某種意義而言，她的大腦就像一個擁擠的公寓，擠滿了聒噪的房客。"
  },
  Skill_3979_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。"
  },
  Skill_3979_EffectNameList = {Text = "傷害"},
  Skill_3979_Name = {
    Text = "紛亂切割"
  },
  Skill_3979_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_3980_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_3981_AwakerSkillBackgroundStory = {
    Text = "傳承自其他種族、被視為異端的血脈。\n唯有堅信其高貴、堅信其偉大，方能苟活於殘酷世間。\n那本奧恩叔叔留下的手卷，與其中描繪的瑰麗深海古城，是他唯一的精神寄託。\n「血脈爆發之際，一定能獲賜深海的無上力量吧。」"
  },
  Skill_3981_Desc = {
    Text = "回復 <Heal:[Heal:Arg3]> 點生命並驅散自身<WeaknessIconKeywords:虛弱>狀態，對所有敵人施加 [Arg4] 層<VulnerabilityIconKeywords:易傷>。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。<RetaliateIconKeywords:反擊> +[Counterattack:Arg2]。下回合開始前，每受到 1 次攻擊，就使 1 條觸腕反擊攻擊者。"
  },
  Skill_3981_EffectNameList = {
    Text = "回復,觸腕傷害,反擊"
  },
  Skill_3981_Name = {
    Text = "承自異端之血"
  },
  Skill_3981_OverLimitUtlSkillDesc = {
    Text = "回復 <Heal:[Heal:Arg3]> 點生命並驅散自身<WeaknessIconKeywords:虛弱>狀態，對所有敵人施加 [Arg4] 層<VulnerabilityIconKeywords:易傷>。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。<RetaliateIconKeywords:反擊> +[Counterattack:Arg2]。下回合開始前，每受到 1 次攻擊，就使 1 條觸腕反擊攻擊者。使 1 條觸腕攻擊 5 次，獲得 25% 造成傷害的反擊。"
  },
  Skill_3981_PropertyNameList = {
    Text = "體質*GrowValue2,攻擊力*GrowValue1,攻擊力*GrowValue3"
  },
  Skill_3982_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 4 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_3982_Name = {
    Text = "四翼漸生"
  },
  Skill_3983_AwakerSkillBackgroundStory = {
    Text = "實驗後，24打爛了所有的鏡子。\n「我的好姑娘」獨眼的科學家撫摸著她的長髮，「安靜。」\n24在科學家的眼中看到一個陌生的怪物。她一定是發了昏，竟然試圖戳瞎他的雙眼——\n這便是她被遺棄在蠟像中的理由罷。"
  },
  Skill_3983_Desc = {
    Text = "「24」 獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>："
  },
  Skill_3983_EffectNameList = {
    Text = "狂氣、狂氣爆發最終傷害提高、觸腕傷害加成百分比、力量、混沌暴擊率與暴擊傷害、反擊傷害加成百分比"
  },
  Skill_3983_Name = {
    Text = "調停人格"
  },
  Skill_3983_PropertyNameList = {
    Text = "$GrowValue1,GrowValue2,$GrowValue3,攻擊力*GrowValue4,$GrowValue5,$GrowValue6"
  },
  Skill_3984_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 6 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_3984_Name = {
    Text = "六翼滿開"
  },
  Skill_3986_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_3987_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點護盾。玩家回合結束前每擁有一張手牌還會額外獲得 [Arg4] 點護盾。"
  },
  Skill_3987_Name = {Text = "試探"},
  Skill_3988_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3989_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3989_Name = {Text = "刺擊"},
  Skill_3991_Desc = {
    Text = "將 [Arg1] 張 <DerivativeCardKeywords_9:「蹣跚」> 加入對方抽牌堆。"
  },
  Skill_3991_Name = {Text = "蹣跚"},
  Skill_3992_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層<ParcloseIconKeywords:屏障>，前進。"
  },
  Skill_3993_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_3994_AwakerSkillBackgroundStory = {
    Text = "沒有種子不渴望著發芽。\n植物沐浴陽光與雨露破土，幼童浸潤愛與希望長大。\n菲茵特蜷縮搖籃中，懷抱著寶貴的養分，靜靜等待那個時刻的到來……"
  },
  Skill_3994_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，回復 <Heal:[Heal:Arg2]> 點生命。若在本場戰鬥中觸發過<DeathResistanceIconKeywords:死亡抵抗>，額外生效 1 次。"
  },
  Skill_3994_EffectNameList = {
    Text = "護盾,回復"
  },
  Skill_3994_PropertyNameList = {
    Text = "防禦力*GrowValue1,體質*GrowValue2"
  },
  Skill_3995_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3996_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將一張<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_3997_AwakerSkillBackgroundStory = {
    Text = "「街頭打鬥可沒那麼多講究，當然是什麼趁手用什麼了。」"
  },
  Skill_3997_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。"
  },
  Skill_3997_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_3997_Name = {Text = "打擊"},
  Skill_3997_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_3999_Desc = {
    Text = "無法打出。釋放狂氣爆發後，封印所有喚醒體 1 回合。"
  },
  Skill_3999_Name = {
    Text = "維度閉鎖"
  },
  Skill_4000_Desc = {
    Text = "凝滯中，無法行動。"
  },
  Skill_4000_Name = {Text = "凝滯"},
  Skill_4001_AwakerSkillBackgroundStory = {
    Text = "蛛絲將她一層一層緊緊裹住。她躺在溫暖安全的繭內，朝外頭扮起了鬼臉。"
  },
  Skill_4001_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。阿格里帕獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4001_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。阿格里帕獲得 <Energy:[Energy:Arg2]> 點狂氣。觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4001_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4001_Name = {Text = "防禦"},
  Skill_4001_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4002_BattleDesc = {
    Text = "獲得 [Arg1] 護盾。抽到時所有喚醒體失去 3 狂氣。"
  },
  Skill_4002_Desc = {
    Text = "獲得 10% 最大生命的護盾。抽到時所有喚醒體失去 3 狂氣。"
  },
  Skill_4002_Name = {
    Text = "症狀：頹喪"
  },
  Skill_4003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4004_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_4004_Name = {
    Text = "維度霧氣"
  },
  Skill_4005_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4005_Name = {Text = "護盾"},
  Skill_4006_Desc = {
    Text = "狀態卡。"
  },
  Skill_4006_Name = {Text = "蹣跚"},
  Skill_4007_Desc = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。獲得 <Block:[Block:Arg1]> 護盾，回合結束時剩餘護盾轉換為2倍生命值。"
  },
  Skill_4008_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次、並獲得 1 層瘋狂。"
  },
  Skill_4009_AwakerSkillBackgroundStory = {
    Text = "她是脆弱卻充滿誘惑的雛鳥。面向天空，面向大地，面向洶湧的人潮，她卸下了全部的防備。"
  },
  Skill_4009_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4009_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。雷婭獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4009_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4009_Name = {Text = "防禦"},
  Skill_4009_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4010_AwakerSkillBackgroundStory = {
    Text = "希洛不記得自己是何時獲得這股古怪力量的了。\n某個看不見星星的夜晚，希洛從監獄的泥地上醒來，突然發現身側蠕動的黑色泥漿。那些黑色泥漿如同新生的雙臂，替她破除了牢固的鎖鏈。\n她想起被關押在隔壁的、她因為之求情而入獄的蒼老農奴。她急忙奔去查看，但那裡留下的只有瀕臨乾涸的血痕。\n那曾是她的父親。\n日夜不息的辛勞沒有奪去他的性命，無情狠戾的鞭打沒有奪去他的性命——奪去他的性命的是自己的告饒，是進獻讒言者的污衊，是掌權者的不分黑白……\n眼眶早已乾涸，流淌的那些——不過是飽含恨意的黑色漿液而已。"
  },
  Skill_4010_BattleDesc = {
    Text = "失去 [Arg1]% 當前生命([Arg3])。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害和等量傷害的<BleedingIconKeywords:出血>。生成 2 張隨機喚醒體的「打擊」置入手牌並附加<DepleteIconKeywords:消耗>。視為「打擊」。"
  },
  Skill_4010_Desc = {
    Text = "失去 [Arg1]% 當前生命。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害和等量傷害的<BleedingIconKeywords:出血>。生成 2 張隨機喚醒體的「打擊」置入手牌並附加<DepleteIconKeywords:消耗>。視為「打擊」。"
  },
  Skill_4010_EffectNameList = {
    Text = "傷害,「打擊」等級"
  },
  Skill_4010_Name = {
    Text = "綿長恨怨"
  },
  Skill_4010_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4011_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4011_Name = {Text = "護盾"},
  Skill_4012_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4013_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4014_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4014_Name = {
    Text = "喪鐘遙鳴"
  },
  Skill_4015_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4016_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>加入對方抽牌堆。"
  },
  Skill_4016_Name = {
    Text = "致傷打擊"
  },
  Skill_4017_AwakerSkillBackgroundStory = {
    Text = "在漫長的孤寂中，她早已忘記了為何而揮劍。\n但她清楚地知道，自己必須揮出這一劍。"
  },
  Skill_4017_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，<PowerIconKeywords:力量>在「命定之劍」上發揮 [Arg2] 倍效果。每次使用鑰令時，力量倍率在本場戰鬥中提高 1 倍。<TimeBeacon:回環>：選擇<C01EXCardKeyWord1:輪回之庭>或者<C01EXCardKeyWord2:未來謳歌>。"
  },
  Skill_4017_EffectNameList_0 = {Text = "傷害"},
  Skill_4017_Name = {
    Text = "命定之劍"
  },
  Skill_4017_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4018_AwakerSkillBackgroundStory = {
    Text = "疼痛，疼痛。\n漆黑冰冷的疼痛是她少有的留有印象的東西。\n如果她像那些真正的鸚鵡螺一樣，有一個漂亮堅硬的外殼，是不是就不會那麼痛了呢？"
  },
  Skill_4018_Desc_0 = {
    Text = "諾締拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：諾締拉施加的護盾和<RetaliateIconKeywords:反擊>提高 [Arg2]%。"
  },
  Skill_4018_Desc_15 = {
    Text = "諾締拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：諾締拉施加的護盾和<RetaliateIconKeywords:反擊>提高 [Arg2]%，所有喚醒體造成的固定<RetaliateIconKeywords:反擊>提高 [Arg3]％。"
  },
  Skill_4018_EffectNameList = {Text = "狂氣"},
  Skill_4018_Name = {
    Text = "維修大師"
  },
  Skill_4019_AwakerSkillBackgroundStory = {
    Text = "正如一生萬物、萬物歸一的理論一般，她曾陷入悖論的陷阱。"
  },
  Skill_4019_Desc_0 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。將上回合最後打出的 3 張不同非衍生指令卡原始複製置入手中，使它們算力消耗降低 1 並獲得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>。若可置入手中的指令卡不足，則抽等量牌代替。"
  },
  Skill_4019_Desc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。將上回合最後打出的 3 張不同非衍生指令卡原始複製置入手中，使它們算力消耗降低 1 並獲得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>。若可置入手中的指令卡不足，則抽等量牌代替。選擇 1 個任意已解鎖鑰令替換當前鑰令，使用鑰令或戰鬥結束後恢復。"
  },
  Skill_4019_EffectNameList = {
    Text = "銀鑰充能"
  },
  Skill_4019_Name = {
    Text = "悖論收束"
  },
  Skill_4019_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。將上回合最後打出的 3 張不同非衍生指令卡原始複製置入手中，使它們算力消耗變為 0 並獲得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>。若可置入手中的指令卡不足，則抽等量牌代替。獲得 3 層無視上限的<TimeBeacon2:負熵>。"
  },
  Skill_4019_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。將上回合最後打出的 3 張不同非衍生指令卡原始複製置入手中，使它們算力消耗變為 0 並獲得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>。若可置入手中的指令卡不足，則抽等量牌代替。選擇 1 個任意已解鎖鑰令替換當前鑰令，使用鑰令或戰鬥結束後恢復。獲得 3 層無視上限的<TimeBeacon2:負熵>。"
  },
  Skill_4020_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4020_Name = {
    Text = "擁抱融蝕"
  },
  Skill_4021_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，提高後續「連續撕咬」的攻擊次數。"
  },
  Skill_4021_Name = {
    Text = "連續撕咬"
  },
  Skill_4022_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，提高後續「連續撕咬」的攻擊次數。"
  },
  Skill_4022_Name = {
    Text = "連續撕咬"
  },
  Skill_4023_AwakerSkillBackgroundStory = {
    Text = "莉茲還記得自己獲得綠炎那天的景象。\n青色的火種在掌心升騰躍動，催促她去達成那壓抑已久的願望。"
  },
  Skill_4023_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，施加 [Arg2]% 傷害的<IntoxicationIconKeywords:中毒>。回合結束時若在手牌或<DimensionalSpaceIconKeywords:超維空間>，升級為「<DerivativeCardKeywords_19:腐化綠炎>」。算力不足時可以強行打出，效果改為獲得 <Energy:[Energy:Arg3]> 點狂氣並消耗。"
  },
  Skill_4023_EffectNameList = {Text = "傷害"},
  Skill_4023_Name = {Text = "綠炎"},
  Skill_4023_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4024_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4025_Desc = {
    Text = "造成 [Arg1] 層<WeaknessIconKeywords:虛弱>，獲得「鼠群之怒」：下回合每受到 1 攻擊會獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4025_Name = {
    Text = "集結鼠群"
  },
  Skill_4026_Name = {
    Text = "絕境求生"
  },
  Skill_4027_AwakerSkillBackgroundStory = {
    Text = "菲茵特無法離開薄殼，汀克特便時常陪在她的身邊，為她清唱這支安魂曲。\n「我會吸收你的生命力的。」菲茵特如是說。\n「沒關係，我們的生命是一體的。」汀克特回應。"
  },
  Skill_4027_BattleDesc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>狀態。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，每有 1 名敵人獲得 [Power:Arg1] 點<PowerIconKeywords:臨時力量>。本回合下一次躍遷效果必定發動。<TransitionIconKeywords:躍遷>：改為臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>，每有 1 名敵人獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量>。"
  },
  Skill_4027_Desc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>狀態。<TouquKeywords:偷取>所有敵人 [Arg1] 點<PowerIconKeywords:力量>。本回合下一次躍遷效果必定發動。<TransitionIconKeywords:躍遷>：改為<TouquKeywords:偷取> [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4027_EffectNameList = {
    Text = "偷取力量,躍遷偷取力量"
  },
  Skill_4027_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_4028_Name = {
    Text = "自毀攻擊"
  },
  Skill_4029_Desc = {
    Text = "施加 [Arg1] 層<BleedingIconKeywords:出血>，降低  [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4029_Name = {
    Text = "侵蝕之視"
  },
  Skill_4030_Desc = {
    Text = "每回合獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4030_Name = {
    Text = "遠古的呼喚"
  },
  Skill_4031_Desc = {
    Text = "獲得 [Arg1] 點護盾，失去 [Arg2] 點<AlertIconKeywords:戒備>。"
  },
  Skill_4031_Name = {
    Text = "枷鎖：掌政官夫人"
  },
  Skill_4032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4032_Name = {Text = "重擊"},
  Skill_4033_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使扭曲死體狂宴傷害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_4033_Name = {
    Text = "紛亂切割"
  },
  Skill_4034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4035_AwakerSkillBackgroundStory = {
    Text = "紛亂的靈魂只專注自身，它們註定疏於防備。"
  },
  Skill_4035_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4035_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。「24」獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4035_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4035_Name = {Text = "防禦"},
  Skill_4035_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4036_AwakerSkillBackgroundStory = {
    Text = "進行精細操作時，朵爾的這雙螯鉗不太好用。\n但在完全將外域科技改造為人類可用的技術前，她還需要忍受「這雙手」至少十年。"
  },
  Skill_4036_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。朵爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4036_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4036_Name = {Text = "打擊"},
  Skill_4036_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4037_Desc = {
    Text = "解除所有手牌的<SlowIconKeywords:遲緩>效果。"
  },
  Skill_4038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，降低  [Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4042_Desc = {
    Text = "因寄生被打斷，陷入了短暫的混亂…"
  },
  Skill_4042_Name = {Text = "混亂"},
  Skill_4043_BattleDesc = {
    Text = "對所有敵人造成 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，臨時降低所有敵人 [Arg2] 點<ExhaustionIconKeywords:力量>，每有 1 名敵人獲得 [Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4043_Desc = {
    Text = "對所有敵人造成 1 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，<TouquKeywords:偷取>所有敵人 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4043_Name = {
    Text = "腦中之音"
  },
  Skill_4044_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4045_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>，恢復等同於未被格擋傷害的生命。"
  },
  Skill_4045_Name = {
    Text = "歡愉與血"
  },
  Skill_4046_AwakerSkillBackgroundStory = {
    Text = "指令：攻擊。撕咬。"
  },
  Skill_4046_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。莉莉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4046_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4046_Name = {Text = "打擊"},
  Skill_4046_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4048_Desc = {
    Text = "選擇 1 名喚醒體使其獲得 <Energy:[Arg1]> 點狂氣。"
  },
  Skill_4048_Name = {
    Text = "小小心願"
  },
  Skill_4049_Desc = {
    Text = "回復 [Arg1] 點生命，回合結束失去全部護盾。"
  },
  Skill_4049_Name = {
    Text = "枷鎖：受刑的奴隸"
  },
  Skill_4050_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將2張<DerivativeCardKeywords_3:「驚厥」>洗入抽牌堆。"
  },
  Skill_4050_Name = {Text = "明滅"},
  Skill_4051_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，生命越低傷害越高。"
  },
  Skill_4051_Name = {
    Text = "報償打擊"
  },
  Skill_4052_Desc = {
    Text = "血肉界域喚醒體釋放狂氣爆發時可將其消耗、觸發 1 次<DevouredIconKeywords:吞噬>效果。打出後選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣、本回合暴擊率提高 [Arg2]%。"
  },
  Skill_4052_tempBattleDesc_1 = {
    Text = "血肉界域喚醒體釋放狂氣爆發時可將其消耗、觸發 1 次<DevouredIconKeywords:吞噬>效果。打出後選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣、本回合暴擊率提高 [Arg2]%。"
  },
  Skill_4052_tempBattleDesc_2 = {
    Text = "血肉界域喚醒體釋放狂氣爆發時可將其消耗，觸發 1 次<DevouredIconKeywords:吞噬>效果。打出後選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。喚醒體每回合首次消耗「胚胎」或「聖潔之子」時，獲得 [Arg3] 層<BreedingKeywords1:繁育庆典>。"
  },
  Skill_4053_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4054_Desc = {
    Text = "一種特殊的撕裂傷口。回合結束時若在手中，受到 [Arg1] 點<FixedDamage:純粹傷害>。棄掉時將其<DepleteIconKeywords:消耗>。"
  },
  Skill_4054_Name = {Text = "裂傷"},
  Skill_4055_AwakerSkillBackgroundStory = {
    Text = "一望無際的大洋之中，孤獨的航船隨著海浪搖擺。\n他們祈求、懇求、哀求，希望白色的聖女能將他們帶離大海，重新踏上故鄉的土地。\n中心桅杆上，白裙的女孩抬起頭，望見了一隻白色的飛鳥。\n「予舵於我，我將帶你們歸家。」"
  },
  Skill_4055_BattleDesc_0 = {
    Text = "驅散自身<HeavyInjuryKeywords:重創>狀態，回復 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力。本場戰鬥中受到致死傷害時復活並回復 [Arg2]%(<Heal:[Arg3]>) 生命，每場戰鬥只能觸發 1 次。"
  },
  Skill_4055_BattleDesc_3 = {
    Text = "驅散自身<HeavyInjuryKeywords:重創>狀態，回復 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力。本場戰鬥中受到致死傷害時復活，回復 [Arg2]%(<Heal:[Arg3]>) 生命並使所有喚醒體獲得 <Energy:[Energy:Arg4]> 點狂氣，觸發後需要間隔 6 個回合才可再次施加可復活效果。"
  },
  Skill_4055_Desc_0 = {
    Text = "驅散自身<HeavyInjuryKeywords:重創>狀態，回復 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力。本場戰鬥中受到致死傷害時復活並回復 [Arg2]% 生命，每場戰鬥只能觸發 1 次。"
  },
  Skill_4055_Desc_3 = {
    Text = "驅散自身<HeavyInjuryKeywords:重創>狀態，回復 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力。本場戰鬥中受到致死傷害時復活，回復 [Arg2]% 生命並使所有喚醒體獲得 <Energy:[Energy:Arg4]> 點狂氣，觸發後需要間隔 6 個回合才可再次施加可復活效果。"
  },
  Skill_4055_EffectNameList = {
    Text = "回復,回復百分比生命"
  },
  Skill_4055_Name = {
    Text = "不死的極樂鳥"
  },
  Skill_4055_OverLimitUtlSkillDesc_0 = {
    Text = "回覆 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力，驅散自身<HeavyInjuryKeywords:重創>狀態。本場戰鬥中受到致死傷害時復活，回覆 [Arg2]%(<Heal:[Arg3]>) 生命，每場戰鬥只能觸發 1 次。將 3 張回覆提高 50% 的「純白夢境」置入手中並附加消耗。"
  },
  Skill_4055_OverLimitUtlSkillDesc_3 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命並獲得 1 算力，驅散自身<HeavyInjuryKeywords:重創>狀態。本場戰鬥中受到致死傷害時復活，回復 [Arg2]%(<Heal:[Arg3]>) 生命並使所有喚醒體獲得 <Energy:[Energy:Arg4]> 點狂氣，觸發後需要間隔 6 個回合才可再次施加可復活效果。將 3 張回復提高 50% 的「純白夢境」置入手中並附加消耗。"
  },
  Skill_4055_PropertyNameList = {
    Text = "體質*GrowValue1,$GrowValue2"
  },
  Skill_4056_AwakerSkillBackgroundStory = {
    Text = "「謝謝小熊——嗚啊別生氣，我說錯了，應該是謝謝小眼睛。」"
  },
  Skill_4056_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4056_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。艾繼絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4056_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4056_Name = {Text = "防禦"},
  Skill_4056_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4057_Desc = {
    Text = "釋放血之燈：每回合結束後，施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4057_Name = {Text = "血之燈"},
  Skill_4058_Desc = {
    Text = "擊暈「分裂患者」，抽 3 張牌，獲得 3 點算力。"
  },
  Skill_4059_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4059_Name = {
    Text = "灼燃蠟滴之欲"
  },
  Skill_4060_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4061_AwakerSkillBackgroundStory = {
    Text = "一個人一生中必定會經歷三件事：出生、死亡、得罪阿格里帕。"
  },
  Skill_4061_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。阿格里帕獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4061_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。阿格里帕獲得 <Energy:[Energy:Arg2]> 點狂氣。觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4061_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4061_Name = {Text = "打擊"},
  Skill_4061_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4062_Desc = {
    Text = "造成 99 層<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。將 1 張<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_4063_Desc = {
    Text = "將五張症狀卡塞入抽牌堆。"
  },
  Skill_4063_Name = {
    Text = "疾病纏身"
  },
  Skill_4064_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4065_AwakerSkillBackgroundStory = {
    Text = "上位的惡意躁動不已，人類的意志卻也不是毫無招架之力。\n溶解一切的黑色黏液削弱了祂的精神，成了人類唯一的幫助。\n造偶師短暫地佔據上風，她張開雙臂，將破壞的電流化作守護的彎弧。"
  },
  Skill_4065_BattleDesc_0 = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。獲得 <Posse:[Arg2]> 點銀鑰能量。驅散自身<FragileIconKeywords:脆弱>狀態。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_13:「機械武裝-放」>。"
  },
  Skill_4065_BattleDesc_1 = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。獲得 <Posse:[Arg2]> 點銀鑰能量。驅散自身<FragileIconKeywords:脆弱>狀態。將 1 張艾瑞卡附加<DepleteIconKeywords:消耗>的「防禦」置入手牌。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_13:「機械武裝-放」>。"
  },
  Skill_4065_Desc_0 = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。獲得等同於艾瑞卡銀鑰充能的銀鑰能量。驅散自身<FragileIconKeywords:脆弱>狀態。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_13:「機械武裝-放」>。"
  },
  Skill_4065_Desc_1 = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。獲得等同於艾瑞卡銀鑰充能的銀鑰能量。驅散自身<FragileIconKeywords:脆弱>狀態。將 1 張艾瑞卡附加<DepleteIconKeywords:消耗>的「防禦」置入手牌。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_13:「機械武裝-放」>。"
  },
  Skill_4065_EffectNameList = {
    Text = "力量,戒備"
  },
  Skill_4065_Name = {
    Text = "機械武裝-斂"
  },
  Skill_4065_PropertyNameList = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4066_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4067_Desc = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4067_Name = {
    Text = "復仇宣言"
  },
  Skill_4068_AwakerSkillBackgroundStory = {
    Text = "女孩自幼接受嚴苛的貴族教育。\n這些繁複的教條總結起來只有一個詞：剋制。\n它們包括但不限於體態、食欲、說話的音量……\n女孩終日坐在鮮花盛開的庭院裡讀詩、唱歌與祈禱。\n她感到饑餓極了。"
  },
  Skill_4068_BattleDesc_0 = {
    Text = "失去 [Arg1]%([Arg4]) 當前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4068_BattleDesc_2 = {
    Text = "失去 [Arg1]%([Arg4]) 當前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 <Energy:[Energy:Arg5]> 點狂氣。"
  },
  Skill_4068_Desc_0 = {
    Text = "失去 [Arg1]% 當前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4068_Desc_2 = {
    Text = "失去 [Arg1]% 當前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 <Energy:[Energy:Arg5]> 點狂氣。"
  },
  Skill_4068_Name = {
    Text = "未被滿足之痛"
  },
  Skill_4068_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4069_AwakerSkillBackgroundStory = {
    Text = "「防護模式切換完畢，還請你躲在我身後。」"
  },
  Skill_4069_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4069_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。艾瑞卡獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4069_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4069_Name = {Text = "防禦"},
  Skill_4069_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4070_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量傷害<BleedingIconKeywords:出血>。"
  },
  Skill_4072_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量>，自身獲得 <Block:[Block:Arg2]> 護盾 。"
  },
  Skill_4072_Name = {
    Text = "全體強化"
  },
  Skill_4073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4073_Name = {Text = "歡愉"},
  Skill_4074_Desc = {
    Text = "將所有喚醒體的「防禦」置入手中。失控希洛似乎只關注莉莉……"
  },
  Skill_4075_AwakerSkillBackgroundStory = {
    Text = "寧菲亞很喜歡花，除了文學小說外，這是唯一在病床前陪伴她的存在。\n只是，自父母逝世後，再無人定期送來安慰的捧花。\n那最後一捧百合花，也隨著時日推移逐漸失去了鮮活。\n所以，在為自己準備的葬儀上，她毫不猶豫地攜帶上了它。\n遊魚隨光影舞動，珊瑚似莖葉生髮，隨湧動的海浪襲向她目光所指的遠方。"
  },
  Skill_4075_BattleDesc_0 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒> 並觸發其 [Arg3]% 的<IntoxicationIconKeywords:中毒> 效果。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4075_BattleDesc_3 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並觸發 [Arg3]% 的<IntoxicationIconKeywords:中毒>。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。本場戰鬥後續釋放「自我的葬儀」施加的<IntoxicationIconKeywords:中毒>層數提高 [Poison:Arg4] 層。"
  },
  Skill_4075_Desc_0 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒> 並觸發其 [Arg3]% 的<IntoxicationIconKeywords:中毒> 效果。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4075_Desc_3 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並觸發 [Arg3]% 的<IntoxicationIconKeywords:中毒>。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。本場戰鬥後續釋放「自我的葬儀」施加的<IntoxicationIconKeywords:中毒>層數提高 [Poison:Arg4] 層。"
  },
  Skill_4075_EffectNameList_3 = {
    Text = "中毒,力量,中毒層數加成"
  },
  Skill_4075_Name = {
    Text = "自我的葬儀"
  },
  Skill_4075_OverLimitUtlSkillDesc_0 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並觸發 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。寧菲亞造成的<IntoxicationIconKeywords:中毒>提高 50%，持續 3 回合。"
  },
  Skill_4075_OverLimitUtlSkillDesc_3 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>並觸發 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。本場戰鬥後續釋放「自我的葬儀」施加的<IntoxicationIconKeywords:中毒>層數提高 [Poison:Arg4] 層。寧菲亞造成的<IntoxicationIconKeywords:中毒>提高 50％、持續 3 回合。"
  },
  Skill_4075_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4075_PropertyNameList_3 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4076_AwakerSkillBackgroundStory = {
    Text = "穿裘皮的維納斯，將你的腳踏在奴隸的背上吧！\n將鎖鏈系在他們的脖子上，用脊刺刺穿他們傷痕累累的心。"
  },
  Skill_4076_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，該傷害享受 [Arg4]% 的<RetaliateIconKeywords:反擊>加成，每次攻擊使傷害目標臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:躍遷>：消耗 5 層<DreamGuide:夢引>，若成功則返還消耗的算力並額外造成 2 次傷害，否則獲得 2 層<DreamGuide:夢引>。"
  },
  Skill_4076_Desc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，該傷害享受 [Arg4]% 的<RetaliateIconKeywords:反擊>加成，每次攻擊使傷害目標臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。此卡暴擊率提高 25%。<TransitionIconKeywords:躍遷>：消耗 5 層<DreamGuide:夢引>，若成功則返還消耗的算力並額外造成 2 次傷害，否則獲得 2 層<DreamGuide:夢引>。"
  },
  Skill_4076_EffectNameList = {
    Text = "傷害,力量降低,反擊加成"
  },
  Skill_4076_Name = {
    Text = "脊刺鎖鏈"
  },
  Skill_4076_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,$GrowValue3%"
  },
  Skill_4077_AwakerSkillBackgroundStory = {
    Text = "那些觸肢屬於哪位神明，業已無從知曉。\n祂們來自深淵，祂們盤踞深海，祂們肆意伸展——祂們將聽從螺湮主宰的號令。"
  },
  Skill_4077_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，額外享受 [Arg3]% 觸腕傷害和力量加成。使所有觸腕攻擊 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺傷害>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4077_BattleDesc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，額外享受 [Arg3]% 觸腕傷害和力量加成。使所有觸腕攻擊所有敵人 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺傷害>。若當前姿態為「靜海」，算力消耗降低 2 點。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4077_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，額外享受 [Arg3]% 觸腕傷害和力量加成。使所有觸腕攻擊 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺傷害>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4077_Desc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，額外享受 [Arg3]% 觸腕傷害和力量加成。使所有觸腕攻擊所有敵人 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺傷害>。若當前姿態為「靜海」，算力消耗降低 2 點。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4077_EffectNameList = {
    Text = "傷害,所有觸腕攻擊傷害百分比"
  },
  Skill_4077_Name = {
    Text = "深淵號令"
  },
  Skill_4077_PropertyNameList = {
    Text = "攻擊力*GrowValue1,GrowValue2"
  },
  Skill_4078_Desc = {
    Text = "回合結束時、若此卡牌仍在手中且本回合打出的卡牌不多於 3 張、下回合額外獲得 2 點算力。"
  },
  Skill_4078_Name = {
    Text = "症狀：多疑"
  },
  Skill_4080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每受到 1 次攻擊傷害次數提高 1。"
  },
  Skill_4080_Name = {
    Text = "狂氣使役之鞭"
  },
  Skill_4081_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4082_Desc = {
    Text = "獲得 1 層臨時<ParcloseIconKeywords:屏障>，算力永久減少 2。"
  },
  Skill_4082_Name = {
    Text = "枷鎖：復甦的聖女"
  },
  Skill_4085_Desc = {
    Text = "施加 [Arg1] 層<BleedingIconKeywords:出血>，降低  [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4085_Name = {
    Text = "侵蝕之視"
  },
  Skill_4086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。後撤。"
  },
  Skill_4087_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。自身獲得 [Arg3] 層「蠟質鍍層」：免疫異常狀態，每次被暴擊後減少 1 層。"
  },
  Skill_4087_Name = {
    Text = "蠟像登場"
  },
  Skill_4088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張<DerivativeCardKeywords_38:「幻覺」>洗入對方抽牌堆，"
  },
  Skill_4088_Name = {Text = "幻覺"},
  Skill_4089_Desc = {
    Text = "狂氣最低喚醒體獲得[Arg1]狂氣。"
  },
  Skill_4089_Name = {
    Text = "天真的回禮"
  },
  Skill_4090_Desc = {
    Text = "目標喚醒體獲得[Arg1]狂氣。"
  },
  Skill_4090_Name = {
    Text = "天真的回禮"
  },
  Skill_4092_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4093_AwakerSkillBackgroundStory = {
    Text = "明面上，那個與溫柯爾形影不離的儀器被稱為「定位儀-Y031」，據說能穩定精神，檢測精神波動。\n至於它為什麼還具備壓縮精神力，將其如同炮彈一樣射出的功能，溫柯爾卻避而不談。"
  },
  Skill_4093_Desc_0 = {
    Text = "移除所有敵方<ParcloseIconKeywords:屏障>狀態並造成 <Damage:[Damage:Arg1]> 點傷害和 1 回合的<WeaknessIconKeywords:虛弱>。獲得 [Arg3] 點銀鑰能量。<TransitionIconKeywords:躍遷>：改為獲得  <Energy:[Energy:Arg2]> 點狂氣"
  },
  Skill_4093_Desc_1 = {
    Text = "移除所有敵方<ParcloseIconKeywords:屏障>狀態並造成 <Damage:[Damage:Arg1]> 點傷害和 1 回合的<WeaknessIconKeywords:虛弱>。獲得 [Arg3] 點銀鑰能量。<TransitionIconKeywords:躍遷>：改為獲得  <Energy:[Energy:Arg2]> 點狂氣。造成的傷害享受 [Arg4]% 反擊加成。"
  },
  Skill_4093_EffectNameList_0 = {
    Text = "傷害,狂氣,銀鑰能量"
  },
  Skill_4093_EffectNameList_1 = {
    Text = "傷害,狂氣,銀鑰能量,反擊加成"
  },
  Skill_4093_Name = {
    Text = "能量射線"
  },
  Skill_4093_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4093_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4094_Desc = {
    Text = "對一名喚醒體的卡牌添加「被狩獵」狀態，自身施加2層「狩獵印記」。"
  },
  Skill_4094_Name = {
    Text = "狩獵儀式"
  },
  Skill_4095_AwakerSkillBackgroundStory = {
    Text = "落單的老鼠在陰暗的角落裡竄行，它瘦弱、渺小，一把掃帚就能將它輕易驅逐。\n流浪兒也是如此。\n渺小之中亦有力量，當流浪兒與老鼠組成搭檔，她們也可以勢不可擋。"
  },
  Skill_4095_Desc_0 = {
    Text = "將 1 張隨機造成 <Damage:[Damage:Arg1]> 點傷害 X+1 次的<DerivativeCardKeywords_12:「鼠群衝擊」>洗入抽牌堆。"
  },
  Skill_4095_Desc_3 = {
    Text = "將 1 張隨機造成 <Damage:[Damage:Arg1]> 點傷害 X+2 次的<DerivativeCardKeywords_12:「鼠群衝擊」>洗入抽牌堆。"
  },
  Skill_4095_EffectNameList = {
    Text = "「鼠群衝擊」傷害"
  },
  Skill_4095_Name = {
    Text = "集結鼠群"
  },
  Skill_4095_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，恢復等同於未被格擋傷害的生命。"
  },
  Skill_4098_Desc = {
    Text = "粘液重新彙集成了莉莉，獲得狀態：不滅之花，並切換攻擊形態。召喚一個膿皰。"
  },
  Skill_4098_Name = {
    Text = "粘液彙集"
  },
  Skill_4099_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4100_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4102_AwakerSkillBackgroundStory = {
    Text = "饑腸轆轆的萊克揉著肚子走在街頭。\n要是面前突然出現一隻燒雞就好了，萊克想。\n一個黑影從身邊竄出，隨後傳來女人的尖叫。\n萊克眼明手快地逮住黑影，正準備將提包還給女人，卻發現女人神色有異。\n一番糾纏後，巡警姍姍來遲。\n原來女人正是聞名遐邇的寶石怪盜。\n失主請萊克飽餐一頓，還額外加贈一枚金色寶石。\n「真是意外收穫。」萊克揉著肚子說道。"
  },
  Skill_4102_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。選擇 1 張抽牌堆的牌置入手中，若暴擊則使選擇的卡牌算力消耗降低 1 點。"
  },
  Skill_4102_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。選擇 1 張抽牌堆的牌置入手中，若暴擊則使選擇的卡牌算力消耗降低 2 點。"
  },
  Skill_4102_EffectNameList = {Text = "傷害"},
  Skill_4102_Name = {
    Text = "意外收穫"
  },
  Skill_4102_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4103_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4104_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每有 1 層「狩獵印記」降低 [Arg4] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4104_Name = {
    Text = "裂顱一擊"
  },
  Skill_4105_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4105_Name = {Text = "試探"},
  Skill_4106_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。詹金每次造成未被格擋的傷害，都會在隨機「指令卡」上留下永久傷痕。"
  },
  Skill_4106_Name = {
    Text = "空間折疊"
  },
  Skill_4107_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4108_Desc = {
    Text = "將所有症狀卡變化為<DerivativeCardKeywords_37:「窒息」>，窒息：1算力，回合結束時若還在手中對自身施加[Arg1]點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4109_AwakerSkillBackgroundStory = {
    Text = "柔和的海風中她陷入沉睡，卻被振翅的聲音驚醒。一隻通體雪白的小鳥掠過她的頭頂，消失在同樣雪白的雲朵之中。\n那一定是夢吧，在這遠離陸地的大洋深處，怎麼會有落單的飛鳥呢？\n她這麼想著，卻無法自已地感到一種希冀，一種嚮往。"
  },
  Skill_4109_BattleDesc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Arg2] 點算力並驅散手牌<SlowIconKeywords:遲緩>狀態。激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4109_BattleDesc_2 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Arg2] 點算力並驅散手牌<SlowIconKeywords:遲緩>狀態。每<RetainIconKeywords:保留> 1 回合，下次打出時額外回復 <Heal:[Arg3]> 點生命。激發 1 條觸腕攻擊敵人，造成 [Arg4]％ 觸腕傷害。"
  },
  Skill_4109_Desc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Arg2] 點算力並驅散手牌<SlowIconKeywords:遲緩>狀態。激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4109_Desc_2 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Arg2] 點算力並驅散手牌<SlowIconKeywords:遲緩>狀態。每<RetainIconKeywords:保留> 1 回合，下次打出時額外回復 <Heal:[Arg3]> 點生命。激發 1 條觸腕攻擊敵人，造成 [Arg4]％ 觸腕傷害。"
  },
  Skill_4109_EffectNameList_0 = {Text = "回復"},
  Skill_4109_EffectNameList_2 = {
    Text = "回復,額外回復"
  },
  Skill_4109_Name = {
    Text = "純白夢境"
  },
  Skill_4109_PropertyNameList_0 = {
    Text = "體質*GrowValue1,"
  },
  Skill_4109_PropertyNameList_2 = {
    Text = "體質*GrowValue1,體質*GrowValue2"
  },
  Skill_4110_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4110_Name = {
    Text = "蠟像登場"
  },
  Skill_4111_AwakerSkillBackgroundStory = {
    Text = "跨越維度的切割，令缺乏警惕之人身首分離。"
  },
  Skill_4111_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4111_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 2 倍力量加成。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 點算力。"
  },
  Skill_4111_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。達芙黛爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4111_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 2 倍力量加成。達芙黛爾獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 點算力。"
  },
  Skill_4111_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4111_Name = {Text = "打擊"},
  Skill_4111_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4112_Desc = {
    Text = "選擇 1 張抽牌堆的卡牌置入手牌。"
  },
  Skill_4112_Name = {Text = "檢索"},
  Skill_4113_AwakerSkillBackgroundStory = {
    Text = "寧菲亞是海的寵兒。無論何時，只要她開始祈禱，這些海的精靈就會環繞她左右，久久不肯離去。"
  },
  Skill_4113_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4113_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。寧菲亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4113_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4113_Name = {Text = "防禦"},
  Skill_4113_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4114_AwakerSkillBackgroundStory = {
    Text = "「這樣的簡單把戲，您可看好了，我尊貴的客人。」"
  },
  Skill_4114_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4114_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。若當前生命低於 50%，額外獲得 1 次護盾，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4114_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。索蕾爾獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4114_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。若當前生命低於 50%，額外獲得 1 次護盾，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]。索蕾爾獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4114_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4114_Name = {Text = "防禦"},
  Skill_4114_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4115_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4116_Desc = {
    Text = "抽到時使自身最大生命降低 20%。使用後使所有喚醒體本回合暴擊傷害提高 100%。"
  },
  Skill_4116_Name = {Text = "融蝕"},
  Skill_4117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 2 張<DerivativeCardKeywords_34:「未被滿足之痛」>置入抽牌堆。"
  },
  Skill_4118_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4118_Name = {
    Text = "自我的葬儀"
  },
  Skill_4119_BattleDesc = {
    Text = "失去 [Arg1] 點生命，獲得 2 點算力。無法出售。"
  },
  Skill_4119_Desc = {
    Text = "失去 10% 最大生命，獲得 2 點算力。無法出售。"
  },
  Skill_4119_Name = {
    Text = "症狀：妄想"
  },
  Skill_4120_AwakerSkillBackgroundStory = {
    Text = "她請求角鬥士殺死自己。\n「馬上，他們就會找到我，羞辱我，然後割下我的頭，就像對我父母一樣。\n我不願死在那些低賤的蟲子手上，不過你…...和他們不一樣。\n這是我唯一的請求——殺了我。」\n角鬥士哈哈大笑，聲音震動胸腔，連帶身上的枷鎖嘩啦啦作響。\n他並未被她的說辭打動，但他從不拒絕送上門的新鮮血液。"
  },
  Skill_4120_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。當前<EmbryoFusionIconKeywords:胚胎融合>翻倍。"
  },
  Skill_4120_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。當前<EmbryoFusionIconKeywords:胚胎融合>翻倍。使手牌中算力消耗最高的 1 張卡在本回合中算力消耗 -1。"
  },
  Skill_4120_EffectNameList_0 = {Text = "護盾"},
  Skill_4120_Name = {
    Text = "不耐的施捨"
  },
  Skill_4120_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4121_AwakerSkillBackgroundStory = {
    Text = "除了溫和秀美，銳利而具有攻擊性也是藝術的一部分。"
  },
  Skill_4121_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。珊獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4121_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4121_Name = {Text = "打擊"},
  Skill_4121_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4122_AwakerSkillBackgroundStory = {
    Text = "護鰭是自卑，是被排擠者自我搭建的壁壘。"
  },
  Skill_4122_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4122_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。凱刻斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4122_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4122_Name = {Text = "防禦"},
  Skill_4122_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4123_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4124_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4125_AwakerSkillBackgroundStory = {
    Text = "艾瑞卡腰側的裝置正是她的動力來源，那層疊交錯的機械遵循著無法理解的原理，源源不斷地為她提供必要的電流。\n如同它的主人一樣，這個裝置極不穩定，在她短路的瞬間會爆發出巨大的能量，可見的電流四下飛射，灼燒著周圍的一切。"
  },
  Skill_4125_Desc_0 = {
    Text = "若消耗算力為偶數，造成 <Damage:[Damage:Arg2]> 點傷害 X+2 次。否則獲得 <Block:[Block:Arg3]> 點護盾 X+1 次。"
  },
  Skill_4125_Desc_3 = {
    Text = "若消耗算力為偶數，造成 <Damage:[Damage:Arg2]> 點傷害 X+2 次。否則獲得 <Block:[Block:Arg3]> 點護盾 X+1 次。<TransitionIconKeywords:躍遷>：同時擁有兩種效果。"
  },
  Skill_4125_EffectNameList = {
    Text = "傷害,護盾"
  },
  Skill_4125_Name = {
    Text = "機能超載"
  },
  Skill_4125_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，在後排召喚「求告者」。"
  },
  Skill_4126_Name = {
    Text = "分裂打擊"
  },
  Skill_4127_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入對方抽牌堆。"
  },
  Skill_4128_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4129_Desc = {
    Text = "棄掉所有手牌，抽取棄掉數量 +2 的牌。"
  },
  Skill_4129_Name = {
    Text = "純白初遇"
  },
  Skill_4130_AwakerSkillBackgroundStory = {
    Text = "「歡笑吧，尖叫吧，癲狂吧！只有這樣才叫嘉年華！」"
  },
  Skill_4130_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4130_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。卡茜亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4130_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4130_Name = {Text = "打擊"},
  Skill_4130_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4132_Desc = {
    Text = "無法打出。"
  },
  Skill_4132_Name = {Text = "幻覺"},
  Skill_4133_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4133_Name = {
    Text = "石質分解"
  },
  Skill_4134_AwakerSkillBackgroundStory = {
    Text = "主教虔誠地執行祝福的儀式。\n願人們不再受傷、不再痛苦。願那沒有苦難的國降臨於世。"
  },
  Skill_4134_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4134_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。積攢 <Heal:[Heal:Arg3]> 點猩紅熔爐回復量。"
  },
  Skill_4134_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。薩爾瓦多獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4134_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。薩爾瓦多獲得 <Energy:[Energy:Arg2]> 點狂氣。積攢 <Heal:[Heal:Arg3]> 點猩紅熔爐回復量。"
  },
  Skill_4134_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4134_EffectNameList_1 = {
    Text = "護盾,狂氣,猩紅熔爐積攢量"
  },
  Skill_4134_Name = {Text = "防禦"},
  Skill_4134_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4134_PropertyNameList_1 = {
    Text = "防禦力*GrowValue1,$GrowValue2,體質*GrowValue3"
  },
  Skill_41357_Desc = {
    Text = "消耗 10 層<DreamGuide:夢引>，使所有敵人本回合進入「囈語」狀態：傷害減少 [Arg3]% ，但攻擊次數翻倍。"
  },
  Skill_41357_Name = {
    Text = "囈語回音"
  },
  Skill_41358_Desc = {
    Text = "獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_41358_Name = {
    Text = "催眠脈絡"
  },
  Skill_41359_Desc = {
    Text = "消耗 5 層<DreamGuide:夢引>，旺達獲得 <Energy:[Energy:Arg1]> 點狂氣，獲得等同於 [Arg2]% 永久<RetaliateIconKeywords:反擊>([Arg3])的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_41359_Name = {
    Text = "深眠反擊"
  },
  Skill_4135_Desc = {Text = "廢棄"},
  Skill_4135_Name = {Text = "廢棄"},
  Skill_4136_Desc = {
    Text = "棄掉所有手牌，"
  },
  Skill_4136_Name = {
    Text = "畸變之心"
  },
  Skill_4137_AwakerSkillBackgroundStory = {
    Text = "演繹法是一種邏輯推理，只有掌握了正確的前提，才能得出準確的結論。\n在成為調查員前，拉蒙娜一直在使用演繹法來認知世界。\n進行了足夠多的冒險後，也許她會開始考慮使用歸納法吧。"
  },
  Skill_4137_Desc_0 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。選擇 1 張抽牌堆或棄牌堆的牌置入手牌，使其算力消耗變為 0 點。"
  },
  Skill_4137_Desc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。選擇 1 張抽牌堆或棄牌堆的牌置入手牌，使其算力消耗變為 0 點。將 1 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆。"
  },
  Skill_4137_EffectNameList = {
    Text = "銀鑰充能"
  },
  Skill_4137_Name = {
    Text = "世界演繹法"
  },
  Skill_4137_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。選擇 1 張抽牌堆或棄牌堆的牌置入手牌，使其算力消耗變為 0 點。<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，下個釋放的鑰令生效 2 次。"
  },
  Skill_4137_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Posse:[Arg1]> 點銀鑰能量。選擇 1 張抽牌堆或棄牌堆的牌置入手牌，使其算力消耗變為 0 點。將 1 張<DerivativeCardKeywords_4:「靈感」>洗入抽牌堆。<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，下個釋放的鑰令生效 2 次。"
  },
  Skill_4138_AwakerSkillBackgroundStory = {
    Text = "拉蒙娜在十歲那年，提出了希望接受戰鬥訓練的請求。\n倒不是想玩什麼騎士遊戲，只是在目睹了養父的鋪張與揮霍後，少女決定為可能到來的破產做準備。\n「當女王護衛的報酬，會比警局的薪水高吧？」"
  },
  Skill_4138_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。打出後使「女王之劍」傷害次數 +1，最多提高為 [Arg3] 次。獲得 [Arg7] 點臨時界域精通。"
  },
  Skill_4138_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg5] 次，每次造成傷害獲得 [Power:Arg4] 點臨時<PowerIconKeywords:力量>。打出後使「女王之劍」傷害次數 +1，最多提高為 [Arg6] 次。獲得 [Arg7] 點臨時界域精通。<RippleKeywords:餘波>：獲得 300% 等同於拉蒙娜銀鑰充能的銀鑰能量。"
  },
  Skill_4138_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg5] 次，每次造成傷害獲得 [Power:Arg4] 點臨時<PowerIconKeywords:力量>。打出後使「女王之劍」傷害次數 +1，最多提高為 [Arg6] 次。獲得 [Arg7] 點臨時界域精通。<RippleKeywords:餘波>：獲得 300% 等同於拉蒙娜銀鑰充能的銀鑰能量。"
  },
  Skill_4138_EffectNameList_0 = {Text = "傷害"},
  Skill_4138_EffectNameList_1 = {
    Text = "傷害,臨時力量"
  },
  Skill_4138_Name = {
    Text = "女王之劍"
  },
  Skill_4138_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4138_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4139_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 點護盾和 [Arg3] 點<AlertIconKeywords:戒備>。"
  },
  Skill_4139_Name = {
    Text = "全體強化"
  },
  Skill_4140_Desc = {
    Text = "抽到時失去 1 點生命，打出後抽 1 張牌。身體似乎正在消散……"
  },
  Skill_4140_Name = {Text = "融蝕漿"},
  Skill_4141_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4142_Desc = {
    Text = "抽 2 張牌，將 1 張「症狀：囈語」加入棄牌堆中。無法出售。"
  },
  Skill_4142_Name = {
    Text = "症狀：囈語"
  },
  Skill_4143_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4144_AwakerSkillBackgroundStory = {
    Text = "如果是主人的命令的話，莉莉可以拋出那個大傢伙。\n它不害怕疼痛。\n疼痛只是力量，疼痛驅使狂躁，莉莉不害怕疼痛，它也不害怕疼痛。\n所以，它一定可以幫主人消滅敵人。"
  },
  Skill_4144_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，觸發目標 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴擊觸發比例提高至  [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提高 2，打出後移除<PainWord:忍耐>。"
  },
  Skill_4144_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，觸發目標  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴擊觸發比例提高至  [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提高 2，打出後移除<PainWord:忍耐>。此卡暴擊率提高 20%。"
  },
  Skill_4144_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害、觸發目標 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果、若造成暴擊則觸發比例提升至 [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提升 2、打出後移除一半<PainWord:忍耐>。此卡暴擊率提升 20％。"
  },
  Skill_4144_EffectNameList = {Text = "傷害"},
  Skill_4144_Name = {
    Text = "報償打擊"
  },
  Skill_4144_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4144_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，觸發目標 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴擊觸發比例提高至  [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提高 2."
  },
  Skill_4144_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，觸發目標 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴擊觸發比例提高至  [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提高 2，打出後移除<PainWord:忍耐>。此卡暴擊率提高 20%。"
  },
  Skill_4144_tempBattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害、觸發目標 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果、若造成暴擊則觸發比例提升至 [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提升 2、打出後移除一半<PainWord:忍耐>。此卡暴擊率提升 20％。"
  },
  Skill_4144_tempBattleDesc_4 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，觸發目標  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴擊觸發比例提高至  [Arg4]％。視為「打擊」。每有 1 層<PainWord:忍耐>就使傷害提高 [Float:Arg6] ，打出後移除一半<PainWord:忍耐>。此卡暴擊率提高 20%。"
  },
  Skill_4145_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4146_Desc = {
    Text = "對自身造成 [Arg1] 點<FixedDamage:純粹傷害>，獲得 [Arg2] 點臨時<PowerIconKeywords:力量>，抽 1 張牌。"
  },
  Skill_4146_Name = {
    Text = "未被滿足之痛"
  },
  Skill_4147_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg2]> 傷害 [Arg1] 次。"
  },
  Skill_4147_EffectNameList = {
    Text = "「鼠群衝擊」傷害"
  },
  Skill_4147_Name = {
    Text = "鼠群衝擊"
  },
  Skill_4147_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4148_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4149_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾，前進。"
  },
  Skill_4150_Desc = {
    Text = "獲得 [Arg1] 護盾，護盾消失時，剩餘護盾轉化為2倍生命值。"
  },
  Skill_4150_Name = {
    Text = "不滅之花"
  },
  Skill_4151_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_4152_AwakerSkillBackgroundStory = {
    Text = "血流滿地也好，屍橫遍野也好，承受穿心之痛也好。\n為了使神的國土再臨於世，這都是微不足道的犧牲。\n她只恨自己不是那被選中之人，不是那個被囚於牢籠中的少女。"
  },
  Skill_4152_Desc_0 = {
    Text = "選擇 1 名其他喚醒體，使其獲得 <Energy:[Energy:Arg2]> 點狂氣。<O07CardKeyWord:祭儀>：獲得狂氣提高 [Arg4]/[Arg5]/[Arg6] 點。"
  },
  Skill_4152_Desc_2 = {
    Text = "選擇 1 名其他喚醒體，使其獲得 <Energy:[Energy:Arg2]> 點狂氣，界域精通+[Arg3]。<O07CardKeyWord:祭儀>：獲得狂氣提高 [Arg4]/[Arg5]/[Arg6] 點。"
  },
  Skill_4152_EffectNameList = {Text = "狂氣"},
  Skill_4152_Name = {
    Text = "應選之人"
  },
  Skill_4154_AwakerSkillBackgroundStory = {
    Text = "聽啊，那是為自己奏響的喪鐘之聲。\n並非瘋狂的求索者，並非無措的迷失者，她只是靜靜地抉擇了自己的末路。\n凋零的花瓣為她的祭儀獻舞，狂亂的海風為她的葬歌哀哭。\n在那震徹心扉的鐘聲後，世界短暫陷入死一般的寂靜。"
  },
  Skill_4154_Desc_0 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>，施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4154_Desc_1 = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>，施加[Arg2] 回合<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4154_EffectNameList_1 = {
    Text = "中毒,護盾"
  },
  Skill_4154_Name = {
    Text = "喪鐘遙鳴"
  },
  Skill_4154_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4154_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4155_AwakerSkillBackgroundStory = {
    Text = "來自萬古，發乎愚昧，源於恐懼。\n奔湧在泰旖絲血管中的，是一種原始的本能。\n在難以回首的獻祭中，彼時尚為年幼的泰旖絲被植入了這種本能。\n意志、情緒、乃至人格都被不屬於她的存在取代——\n她留下的，唯有這生命間共通的，恐懼死亡的本能。"
  },
  Skill_4155_BattleDesc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，獲得 <Posse:[Arg2]> 點銀鑰能量。選擇：<B01AFKeyWord1:恐懼之血>、<B01AFKeyWord2:腐壞之血>、<B01AFKeyWord3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_BattleDesc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，獲得 <Posse:[Arg2]> 點銀鑰能量。選擇：<B01AFKeyWordQ1:恐懼之血>、<B01AFKeyWordQ2:腐壞之血>、<B01AFKeyWordQ3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，獲得等同於 2 倍泰旖絲銀鑰充能的銀鑰能量。選擇：<B01AFKeyWord1:恐懼之血>、<B01AFKeyWord2:腐壞之血>、<B01AFKeyWord3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，獲得等同於 2 倍泰旖絲銀鑰充能的銀鑰能量。選擇：<B01AFKeyWordQ1:恐懼之血>、<B01AFKeyWordQ2:腐壞之血>、<B01AFKeyWordQ3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Name = {
    Text = "聖血的本能"
  },
  Skill_4156_AwakerSkillBackgroundStory = {
    Text = "還在擔任陪讀女眷時，奧爾拉便喜歡躲在書齋的一角閱讀詩集。那些哀慟的詩句，總能讓她動容。"
  },
  Skill_4156_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。視為「防禦」。<TransitionIconKeywords:躍遷>：切換至情緒「哀」。"
  },
  Skill_4156_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<WeaknessIconKeywords:虛弱>全體敵方 1 回合。視為「防禦」。<TransitionIconKeywords:躍遷>：切換至情緒「哀」。"
  },
  Skill_4156_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧爾拉獲得 <Energy:[Energy:Arg2]> 點狂氣。視為「防禦」。<TransitionIconKeywords:躍遷>：切換至情緒「哀」。每消耗 1 層隱喻「哀」、回覆 <Heal:[Heal:Arg3]> 點生命。"
  },
  Skill_4156_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧爾拉獲得 <Energy:[Energy:Arg2]> 點狂氣。<WeaknessIconKeywords:虛弱>全體敵方 1 回合。視為「防禦」。<TransitionIconKeywords:躍遷>：切換至情緒「哀」。每消耗 1 層隱喻「哀」、回覆 <Heal:[Heal:Arg3]> 點生命。"
  },
  Skill_4156_EffectNameList = {
    Text = "護盾,狂氣,回復生命"
  },
  Skill_4156_Name = {
    Text = "哀慟詩篇"
  },
  Skill_4156_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,體質*GrowValue3"
  },
  Skill_4157_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4158_Desc = {
    Text = "保留：暴擊率提高 25%，回合結束時將 1 張隨機「症狀卡」加入抽牌堆中。"
  },
  Skill_4158_Name = {
    Text = "症狀：盲從"
  },
  Skill_4160_AwakerSkillBackgroundStory = {
    Text = "在貝桑松的侍女眼裡，她的小姐有些特別。\n她不喜讀詩，也從不彈琴。\n她迷戀逝去之物。她會出神地盯著一片枯萎的落葉......然後一躍而起，跑回房間——砰！砰！砰！\n「喏，咱們的小小藝術家！」侍女哀歎，「和泥瓦匠有什麼區別？」"
  },
  Skill_4160_Desc_0 = {
    Text = "下個回合開始時，驅散自身<FragileIconKeywords:脆弱>狀態，獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4160_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg2]> 點護盾。下個回合開始時，驅散自身<FragileIconKeywords:脆弱>狀態，獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4160_EffectNameList_0 = {
    Text = "延遲護盾"
  },
  Skill_4160_EffectNameList_1 = {
    Text = "延遲護盾,護盾"
  },
  Skill_4160_Name = {
    Text = "封閉創作"
  },
  Skill_4160_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4160_PropertyNameList_1 = {
    Text = "防禦力*GrowValue1,防禦力*GrowValue2,"
  },
  Skill_4161_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4162_Desc = {
    Text = "石化中，無法行動。"
  },
  Skill_4163_AwakerSkillBackgroundStory = {
    Text = "將這刻骨的仇恨與病態的黏液凝結成尖刺，用絕對淩厲的一擊斬斷敵人的頸項。"
  },
  Skill_4163_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4163_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣和 10% 暴擊傷害。"
  },
  Skill_4163_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4163_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。希洛獲得 <Energy:[Energy:Arg2]> 點狂氣和 10% 暴擊傷害。"
  },
  Skill_4163_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4163_Name = {Text = "打擊"},
  Skill_4163_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4164_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4165_AwakerSkillBackgroundStory = {
    Text = "「攻擊指令執行完畢，請下達下一個指令。」"
  },
  Skill_4165_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4165_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。艾瑞卡獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4165_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4165_Name = {Text = "打擊"},
  Skill_4165_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4166_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！"
  },
  Skill_4166_Name = {
    Text = "破鏈一擊"
  },
  Skill_4167_AwakerSkillBackgroundStory = {
    Text = "籌辦沙龍不是件簡單的事。酒水的挑選，食譜的選擇，乃至侍者的甄選都需要親力親為。\n幸運的是，索蕾爾從她的簇擁者手中獲取了足夠的自由與特權。"
  },
  Skill_4167_Desc_0 = {
    Text = "索蕾爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，索蕾爾每造成 1 次傷害，獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4167_Desc_15 = {
    Text = "索蕾爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，索蕾爾每造成 1 次傷害，獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>並使索蕾爾臨時最終傷害提高 2％，其他喚醒體提高 1％，臨時最終傷害提高效果每回合最多生效 [Arg4] 次。"
  },
  Skill_4167_EffectNameList = {
    Text = "狂氣,力量,臨時力量"
  },
  Skill_4167_Name = {
    Text = "迎客特權"
  },
  Skill_4167_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4168_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次和施加等量傷害的<BleedingIconKeywords:出血>，受到 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4169_AwakerSkillBackgroundStory = {
    Text = "好吃的東西就要吃，好用的力量就要用。\n少女祈禱著，激發了體內蘊藏的力量。"
  },
  Skill_4169_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4169_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]。"
  },
  Skill_4169_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4169_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]。"
  },
  Skill_4169_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4169_EffectNameList_2 = {
    Text = "護盾,狂氣,觸腕傷害"
  },
  Skill_4169_Name = {Text = "防禦"},
  Skill_4169_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4169_PropertyNameList_2 = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4170_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次，該傷害受到 2 倍<PowerIconKeywords:力量>加成。造成 [Arg2] 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4170_Name = {
    Text = "巨刃之威-終"
  },
  Skill_4171_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg4] 次。該傷害受到 2 倍<PowerIconKeywords:力量>加成。自身獲得 [Arg2] 層<PowerIconKeywords:力量>，移除敵人一半的<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>狀態。"
  },
  Skill_4172_AwakerSkillBackgroundStory = {
    Text = "「她連一隻螞蟻都不願意傷害。」\n「那就掐死她，讓另一個‘她’來。」"
  },
  Skill_4172_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4172_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。「24」獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4172_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4172_Name = {Text = "打擊"},
  Skill_4172_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4173_Desc = {
    Text = "眩暈中，無法行動。"
  },
  Skill_4173_Name = {Text = "眩暈"},
  Skill_4174_Desc = {
    Text = "在自身前後各召喚一個「提燈」。"
  },
  Skill_4174_Name = {
    Text = "聖禮儀式"
  },
  Skill_4175_AwakerSkillBackgroundStory = {
    Text = "很難說是別稱為「街頭老鼠」的孩子們接納了老鼠，還是真正的老鼠接納了街童，這段因生計所迫而誕生的情誼，卻在多年的相處下變得堅不可破。\n誰能說動物不是人類最好的朋友呢？"
  },
  Skill_4175_Desc = {
    Text = "少女顯然並不具備任何特殊能力。"
  },
  Skill_4175_Name = {Text = "無"},
  Skill_4175_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4176_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4176_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧吉爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4176_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4176_Name = {Text = "防禦"},
  Skill_4176_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4177_AwakerSkillBackgroundStory = {
    Text = "不要害怕那兩排時隱時現的三角形利齒，也不要擔心進去後就再沒出來的白兔女士——禮帽先生是由卡茜亞大師親自訓練出來的專業魔法道具，可從來不會隨隨便便咬人。"
  },
  Skill_4177_Desc_0 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。棄掉手中的症狀和狀態卡，將其他手牌洗入抽牌堆，抽取等同於棄掉和洗入數量的牌。<TransitionIconKeywords:躍遷>：返還「通通消失！」的算力消耗。"
  },
  Skill_4177_Desc_1 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。棄掉手中的症狀和狀態卡，將其他手牌洗入抽牌堆，抽取等同於棄掉和洗入數量的牌，每抽 1 張牌獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：返還「通通消失！」的算力消耗。"
  },
  Skill_4177_EffectNameList = {Text = "狂氣"},
  Skill_4177_Name = {
    Text = "通通消失！"
  },
  Skill_4178_AwakerSkillBackgroundStory = {
    Text = "「最適合我的，自然是能越過國王、左右朝政的權力。」"
  },
  Skill_4178_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4178_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若當前生命低於 50%([Arg4])，額外造成 1 次傷害，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4178_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。索蕾爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4178_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若當前生命低於 50%，額外造成 1 次傷害，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。索蕾爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4178_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4178_Name = {Text = "打擊"},
  Skill_4178_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4181_Desc = {
    Text = "自身獲得 [Arg1] 層<RetaliateIconKeywords:反擊>"
  },
  Skill_4181_Name = {Text = "施與受"},
  Skill_4182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4183_Desc = {
    Text = "「24」 獲得 <Energy:[Energy:Arg1]> 點狂氣。蒼白、脆弱、卻無比堅定。"
  },
  Skill_4184_BattleDesc = {
    Text = "打出時獲得 [Arg1] 層臨時<PowerIconKeywords:力量>。抽到時降低  [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4184_Desc = {
    Text = "打出時獲得 [Arg1] 層臨時<PowerIconKeywords:力量>。抽到時降低  [Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4184_Name = {
    Text = "症狀：休克"
  },
  Skill_4185_Desc = {
    Text = "所有敵人<PowerIconKeywords:力量>臨時降低 [Arg1] 點， 1 回合內獲得的護盾和<PowerIconKeywords:力量>降低 50%。"
  },
  Skill_4185_EffectNameList = {
    Text = "力量減低"
  },
  Skill_4185_Name = {Text = "詛咒"},
  Skill_4185_PropertyNameList = {
    Text = "攻擊力*GrowValue"
  },
  Skill_4186_Desc = {
    Text = "全體友方獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_4186_Name = {
    Text = "全體護盾"
  },
  Skill_4187_Desc = {
    Text = "施加 [Arg1] 層空虛。"
  },
  Skill_4187_Name = {
    Text = "狂氣吸收"
  },
  Skill_4188_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4189_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。將 [Arg2] 張<DerivativeCardKeywords_3:「驚厥」>洗入抽牌堆。"
  },
  Skill_4190_Desc = {
    Text = "回復 [Arg1] 點生命，使所有敵人降低 [Arg1] 點力量。抽到時所有喚醒體失去 <Energy:10> 狂氣。"
  },
  Skill_4191_Desc = {
    Text = "使所有喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4192_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4192_Name = {
    Text = "自我的葬儀"
  },
  Skill_4193_AwakerSkillBackgroundStory = {
    Text = "「觸手，數不清的觸手從地下拽著我……\n醫生，我是不是得了癔症……」\n女子無助地哭著，她害怕極了。在她對面坐著一位戴眼鏡的長髮醫生。\n「不，這不是什麼癔症。」\n醫生笑起來，雙眼如蛇般狹長。\n「這是真實……有關這個世界的，扭曲的真實。」"
  },
  Skill_4193_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，使「扭曲的死體狂宴」基礎傷害在本場戰鬥中提高 20%，"
  },
  Skill_4193_EffectNameList_0 = {
    Text = "傷害,銀鑰能量,混沌躁狂傷害提高,觸腕傷害,觸腕傷害加成百分比,胚胎融合,猩紅熔爐回復量,力量,失去臨時力量,超維躁狂傷害提高,超維躁狂傷害上限"
  },
  Skill_4193_Name = {
    Text = "扭曲的死體狂宴"
  },
  Skill_4193_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，使「扭曲的死體狂宴」基礎傷害在本場戰鬥中提高 20%，獲得 24 點界域精通，「24」的下一張指令卡生效 3 次。"
  },
  Skill_4193_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,攻擊力*GrowValue3,攻擊力*GrowValue4,$GrowValue5,$GrowValue6,體質*GrowValue7,攻擊力*GrowValue8,防禦力*GrowValue9,攻擊力*GrowValue10"
  },
  Skill_4194_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4195_AwakerSkillBackgroundStory = {
    Text = "成為喚醒體後，奧吉爾與無定形的黑色物質形成了穩定的共生關係。\n目睹過融蝕慘相的人，往往會對奧吉爾的出現而感到高度緊張。\n只有與他共同作戰過的人才知道，那無形之物能凝結成何等堅實的壁壘。"
  },
  Skill_4195_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 X+1 次，每消耗 1 點算力，獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4195_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 X+1 次。每消耗 1 點算力，獲得 <Energy:[Energy:Arg3]> 點狂氣。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4195_EffectNameList_0 = {Text = "護盾"},
  Skill_4195_EffectNameList_3 = {
    Text = "護盾,力量"
  },
  Skill_4195_Name = {
    Text = "不定壁壘"
  },
  Skill_4195_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1"
  },
  Skill_4195_PropertyNameList_3 = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4196_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4196_Name = {
    Text = "扭曲的死體狂宴"
  },
  Skill_4197_AwakerSkillBackgroundStory = {
    Text = "「升起你的船錨，我們是時候遠航。」"
  },
  Skill_4197_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。 激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4197_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。希萊斯特獲得 <Energy:[Energy:Arg2]> 點狂氣。 激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4197_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4197_Name = {Text = "打擊"},
  Skill_4197_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4198_AwakerSkillBackgroundStory = {
    Text = "諾締拉的人生信條：沒有什麼是焊接補不好的，如果有，那就多焊幾次。\n雖然很多時候，她重複焊接的原因並非如此。"
  },
  Skill_4198_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4198_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。諾締拉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4198_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4198_Name = {Text = "防禦"},
  Skill_4198_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4199_Desc = {
    Text = "向隨機喚醒體施加 1 層臨時封印，重複 2 次。"
  },
  Skill_4200_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4201_Desc = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>，將四張枷鎖塞入玩家手牌。"
  },
  Skill_4201_Name = {
    Text = "復仇宣言"
  },
  Skill_4202_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4203_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有沒有嚇你一跳！」"
  },
  Skill_4203_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4203_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4203_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4203_Name = {Text = "打擊"},
  Skill_4203_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4203_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4203_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 4 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4204_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4205_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4206_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，抽牌堆和棄牌堆的所有卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4206_Name = {
    Text = "真·萬古之眸"
  },
  Skill_4207_Desc = {
    Text = "全體獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4208_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 3 張<DerivativeCardKeywords_36:「褻瀆假像」>加入手中。"
  },
  Skill_4208_Name = {
    Text = "異維瞪視"
  },
  Skill_4209_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次並附加等量出血。後撤。"
  },
  Skill_4209_Name = {
    Text = "撕裂打擊"
  },
  Skill_4210_Desc = {
    Text = "召喚兩個「對不起」，賦予他們 1 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_4211_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4212_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_26:症狀：「妄想」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4213_Desc = {
    Text = "對敵人施加 1 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4213_Name = {Text = "尖木頭"},
  Skill_4214_AwakerSkillBackgroundStory = {
    Text = "諾締拉的工作區鐵貼滿了大大小小的便條。這是茜爾維婭女士交給她的方法，能夠幫助她記住那些那些重要的事情。\n但就像那本只寫了一面的日記一樣，這些便條上也只有一模一樣的一串字：不要忘記。\n有的記憶，在落筆的那一刻就已經悄悄溜走了。"
  },
  Skill_4214_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4214_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4214_Name = {
    Text = "短期記憶"
  },
  Skill_4214_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4215_Desc = {
    Text = "回合結束時若在手中，獲得 [Arg1] 層<IntoxicationIconKeywords:中毒>。“ 與我一同沉溺吧！”"
  },
  Skill_4216_Desc = {
    Text = "獲得 [Arg1] 層臨時<ParcloseIconKeywords:屏障>。"
  },
  Skill_4217_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4218_Desc = {
    Text = "獲得 [Arg2] 點護盾和狀態「放血」： 每造成一次未被格擋的傷害，附加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4219_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4220_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4222_BattleDesc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，額外獲得等同於永久力量 25%([Arg2]) 的臨時<PowerIconKeywords:力量>。"
  },
  Skill_4222_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，額外獲得等同於永久力量 25% 的臨時<PowerIconKeywords:力量>。"
  },
  Skill_4222_Name = {
    Text = "永世執念"
  },
  Skill_4223_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg4] 次，賦予  [Arg2] 張卡牌「深潛印記」：打出後敵人獲得臨時<PowerIconKeywords:力量>。"
  },
  Skill_4223_Name = {
    Text = "獵物標記"
  },
  Skill_4224_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4224_Name = {
    Text = "混沌之獸"
  },
  Skill_4225_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4226_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害失去一層，回合結束失去全部。"
  },
  Skill_4226_Name = {Text = "祈禱"},
  Skill_4227_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，提高後續「連續撕咬」的攻擊次數。"
  },
  Skill_4227_Name = {
    Text = "連續撕咬"
  },
  Skill_4228_Desc = {
    Text = "每回合獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4228_Name = {
    Text = "復仇預行"
  },
  Skill_4229_AwakerSkillBackgroundStory = {
    Text = "非利士的領袖是個強大的勇士，他手持巨刃，僅需一揮便可將敵人擊倒。\n非利士的領袖是個殘酷的暴君，他殘忍自私，為了達成目的，可以犧牲所有族人。\n非利士的前領袖是欲望的奴隸，他渴望力量，並終究為力量所困。"
  },
  Skill_4229_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若目標生命低於 25%([Arg3])或擊殺了目標，則返還算力消耗。<PowerIconKeywords:力量>在「斬首重創」上發揮 [Arg2] 倍效果。"
  },
  Skill_4229_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若目標生命低於 25%([Arg3])或擊殺了目標，則返還算力消耗。<PowerIconKeywords:力量>在「斬首重創」上發揮 [Arg2] 倍效果，每有 1 條觸腕，力量額外發揮 1 倍效果。"
  },
  Skill_4229_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若目標生命低於 25%或擊殺了目標，則返還算力消耗。<PowerIconKeywords:力量>在「斬首重創」上發揮 [Arg2] 倍效果。"
  },
  Skill_4229_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若目標生命低於 25%或擊殺了目標，則返還算力消耗。<PowerIconKeywords:力量>在「斬首重創」上發揮 [Arg2] 倍效果，每有 1 條觸腕，力量額外發揮 1 倍效果。"
  },
  Skill_4229_EffectNameList = {Text = "傷害"},
  Skill_4229_Name = {
    Text = "斬首重創"
  },
  Skill_4229_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4230_Desc = {
    Text = "選擇一名喚醒體，獲得 50 點狂氣。"
  },
  Skill_4230_Name = {
    Text = "遺影迴響"
  },
  Skill_4231_AwakerSkillBackgroundStory = {
    Text = "「看！奧瑞塔像魚一樣吐泡泡！」"
  },
  Skill_4231_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4231_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4231_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4231_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 1 張牌。奧瑞塔獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4231_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4231_Name = {Text = "防禦"},
  Skill_4231_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4232_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4232_Name = {
    Text = "扭曲的死體狂宴"
  },
  Skill_4233_AwakerSkillBackgroundStory = {
    Text = "溫柔的海水送去垂朽的花瓣，綻放的水波如睡蓮開合。\n若你掉以輕心，便會被那平靜的外表欺騙。靜謐月色下的沙沙潮水，實際暗含著吞沒萬物的力量。\n如同她的愛憎，從未形於色，卻在洶湧波濤中激烈迴蕩。"
  },
  Skill_4233_Desc_0 = {
    Text = "對生命最高的敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加等量<IntoxicationIconKeywords:中毒>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4233_Desc_2 = {
    Text = "對生命最高的敵人造成 <Damage:[Damage:Arg1]> 點傷害並施加等量<IntoxicationIconKeywords:中毒>，享受 2 倍<PowerIconKeywords:力量>加成。每回合打出的前 3 張症狀卡，使「夜潮洶湧」在本場戰鬥中造成的傷害提高 [Arg2] 點。"
  },
  Skill_4233_EffectNameList = {Text = "傷害"},
  Skill_4233_Name = {
    Text = "夜潮洶湧"
  },
  Skill_4233_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4234_AwakerSkillBackgroundStory = {
    Text = "「我都幹了什麼？」\n諾締拉總會在調查結束後這麼詢問。倒不是出於對所攻擊的融蝕體的愧疚——她只是真的忘了。"
  },
  Skill_4234_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4234_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4234_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。諾締拉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4234_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。諾締拉獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4234_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4234_EffectNameList_1 = {
    Text = "傷害,狂氣,反擊"
  },
  Skill_4234_Name = {Text = "打擊"},
  Skill_4234_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4234_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4235_Desc = {
    Text = "造成 [Arg1] 層<WeaknessIconKeywords:虛弱>，獲得「鼠群之怒」：下回合每受到 1 攻擊會獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4235_Name = {
    Text = "集結鼠群"
  },
  Skill_4238_AwakerSkillBackgroundStory = {
    Text = "若是從前那個順應命運的他，恐怕不會支起這道防禦。"
  },
  Skill_4238_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4238_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [TentaclePower:Arg3] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4238_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。圖魯獲得 <Energy:[Energy:Arg2]> 點狂氣。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4238_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。圖魯獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [TentaclePower:Arg3] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4238_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4238_EffectNameList_2 = {
    Text = "護盾,狂氣,臨時觸腕傷害,臨時力量"
  },
  Skill_4238_Name = {Text = "防禦"},
  Skill_4238_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4238_PropertyNameList_2 = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3,攻擊力*GrowValue3"
  },
  Skill_4239_AwakerSkillBackgroundStory = {
    Text = "在神明治下的國土，人民無疑是愛著這位大主祭的。\n所有人都能看見她的虔誠，她的勤勉，她的犧牲。\n是以，不少人偷偷將她與母神劃上了等號——當然，這件事只能私下聊聊，千萬不能讓彌利亞姆知道。"
  },
  Skill_4239_Desc_0 = {
    Text = "將 [Arg4] 張<O07CardKeyWord2:「聖禮」>置入手中，對所有敵人施加 [Poison:Arg5] 點<IntoxicationIconKeywords:中毒>。根據觸腕姿態獲得效果：潮湧：獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>；靜海：其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣；怒濤：觸發所有敵人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_Desc_3 = {
    Text = "將 [Arg4] 張<O07CardKeyWord2:「聖禮」>置入手中，對所有敵人施加 [Poison:Arg5] 點<IntoxicationIconKeywords:中毒>。根據觸腕姿態獲得效果：潮湧：獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>；靜海：其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣；怒濤：觸發所有敵人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_EffectNameList = {
    Text = "力量和觸腕傷害,狂氣,觸發中毒比例,中毒"
  },
  Skill_4239_Name = {
    Text = "向深淵祝禱"
  },
  Skill_4239_OverLimitUtlSkillDesc = {
    Text = "將 [Arg6] 張<O07CardKeyWord2:「聖禮」>置入手中，對所有敵人施加 [Poison:Arg5] 點<IntoxicationIconKeywords:中毒>。觸腕上限和觸腕數量 +1。根據觸腕姿態獲得效果：潮湧：獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>；靜海：其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣；怒濤：觸發所有敵人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3,攻擊力*GrowValue4"
  },
  Skill_4240_AwakerSkillBackgroundStory = {
    Text = "看看這美麗的託盤，難道不是正適合美麗可愛的她嗎？"
  },
  Skill_4240_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4240_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。珈倫獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4240_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4240_Name = {Text = "防禦"},
  Skill_4240_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4241_AwakerSkillBackgroundStory = {
    Text = "多數人首次聽到美聲歌手練聲時，都會感到驚詫。\n那嬌巧纖弱的軀體，竟然能爆發出這樣洪亮的聲音和能量。\n綿音漸響，聲貫寰宇。"
  },
  Skill_4241_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，在下回合中暴擊率 +[Arg2]% 。<TransitionIconKeywords:躍遷>：改為獲得 <Block:[Block:Arg3]> 點護盾，在下個回合中暴擊率 +[Arg4]%。"
  },
  Skill_4241_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，在下回合中暴擊率和暴擊傷害 +[Arg2]% 。<TransitionIconKeywords:躍遷>：改為獲得 <Block:[Block:Arg3]> 點護盾，在下回合中暴擊率和暴擊傷害 +[Arg4]% 。"
  },
  Skill_4241_EffectNameList = {
    Text = "護盾,躍遷護盾"
  },
  Skill_4241_Name = {
    Text = "綿音漸響"
  },
  Skill_4241_PropertyNameList = {
    Text = "防禦力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4242_Desc = {
    Text = "造成<Block:[Block:Arg1]>護盾，獲得[Arg2]<RetaliateIconKeywords:反擊>。"
  },
  Skill_4243_AwakerSkillBackgroundStory = {
    Text = "筆墨是她的武器，卻如玫瑰的刺，總是刺傷自己。"
  },
  Skill_4243_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg3]> 點狂氣。視為「打擊」。<TransitionIconKeywords:躍遷>：切換至情緒「怒」。"
  },
  Skill_4243_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg3]> 點狂氣。<VulnerabilityIconKeywords:易傷>全體敵方 1 回合。視為「打擊」。<TransitionIconKeywords:躍遷>：切換至情緒「怒」。"
  },
  Skill_4243_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧爾拉獲得 <Energy:[Energy:Arg3]> 點狂氣。視為「打擊」。<TransitionIconKeywords:躍遷>：切換至情緒「怒」。每消耗 1 層隱喻「怒」、額外造成 2 次傷害。"
  },
  Skill_4243_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧爾拉獲得 <Energy:[Energy:Arg3]> 點狂氣。<VulnerabilityIconKeywords:易傷>全體敵方 1 回合。視為「打擊」。<TransitionIconKeywords:躍遷>：切換至情緒「怒」。每消耗 1 層隱喻「怒」、額外造成 2 次傷害。"
  },
  Skill_4243_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4243_Name = {
    Text = "狂想詩篇"
  },
  Skill_4243_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4244_AwakerSkillBackgroundStory = {
    Text = "過於頻繁的勝利讓萊克與那些紙醉金迷場所背後的上流角色結下了未曾謀面的仇恨。\n他曾當街遇襲，子彈卻精准命中了胸口錢夾裡的銀幣。"
  },
  Skill_4244_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4244_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。若算力不足時可消耗 3 點黑印打出並生效 2 次。（當前黑印：[Arg3]）"
  },
  Skill_4244_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。萊克獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4244_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。萊克獲得 <Energy:[Energy:Arg2]> 點狂氣。若算力不足時可消耗 3 點黑印打出並生效 2 次。"
  },
  Skill_4244_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4244_Name = {Text = "防禦"},
  Skill_4244_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4245_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。後撤。"
  },
  Skill_4246_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4247_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4248_Desc = {
    Text = "打出後受到 [Arg1] 點<FixedDamage:純粹傷害>，抽 2 張牌，將其<DepleteIconKeywords:消耗>。回合結束時若在手中，受到 [Arg2] 點傷害。"
  },
  Skill_4248_Name = {
    Text = "褻瀆假像"
  },
  Skill_4249_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4249_Name = {
    Text = "混沌之獸"
  },
  Skill_4250_AwakerSkillBackgroundStory = {
    Text = "年幼的王者無時無刻不傾聽著神明的囈語，讓他難以從夢境中脫身。\n即便如此，清醒時留下的隻言片語也足以治理國家。\n無論他再如何消極地迴避，被人民賦予的威儀也成了他的權柄。"
  },
  Skill_4250_Desc_0 = {
    Text = "圖魯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕數量上限 +1，圖魯每消耗 1 點算力或棄掉 1 張圖魯的指令卡，獲得 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點 <PowerIconKeywords:力量>。"
  },
  Skill_4250_Desc_15 = {
    Text = "圖魯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕數量上限 +1，圖魯每消耗 1 點算力或棄掉 1 張圖魯的指令卡，獲得 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點 <PowerIconKeywords:力量>。圖魯釋放狂氣爆發後，所有敵人受到的觸腕傷害提高 [Arg3]％，最多疊加 [Arg4] 次。"
  },
  Skill_4250_EffectNameList = {
    Text = "狂氣,觸腕傷害,力量"
  },
  Skill_4250_Name = {
    Text = "不朽威儀"
  },
  Skill_4250_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue2"
  },
  Skill_4251_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得[Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4253_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4254_Desc = {
    Text = "獲得4層祈禱，犧牲其他友方，每犧牲一個教眾額外獲得 [Arg1] 層祈禱。"
  },
  Skill_4254_Name = {
    Text = "燈芯長明"
  },
  Skill_4255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4255_Name = {Text = "刺擊"},
  Skill_4257_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4257_Name = {Text = "踐踏"},
  Skill_4258_Desc = {
    Text = "造成[Arg2] 層<IntoxicationIconKeywords:中毒>和 1 回合溶解。打出的牌被消耗，指令卡產生 3 倍傷害和護盾。獲得 3 點算力，抽 3 張牌。"
  },
  Skill_4259_Desc = {
    Text = "造成 [Arg1] 層<IntoxicationIconKeywords:中毒>，對抽牌堆和棄牌堆中隨機 [Arg2] 張卡牌施加「<SlowIconKeywords:遲緩>」"
  },
  Skill_4259_Name = {
    Text = "遲緩迷毒"
  },
  Skill_4260_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4261_Desc = {
    Text = "消耗全部祈禱，每消耗2層祈禱在後排召喚一個提燈教眾小。"
  },
  Skill_4261_Name = {
    Text = "聖禮儀式"
  },
  Skill_4263_Desc = {
    Text = "獲得[Arg1]點<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4264_AwakerSkillBackgroundStory = {
    Text = "滑稽的小丑身上紮滿飛刀，倒吊的空中飛人失手墜落——放輕鬆，親愛的觀眾們，表演的序幕才剛剛拉開。"
  },
  Skill_4264_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4264_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。卡茜亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4264_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4264_Name = {Text = "防禦"},
  Skill_4264_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4265_Desc = {
    Text = "不能倒下，大家還在等我。受到致命傷害時，回復 1 點生命。"
  },
  Skill_4265_Name = {
    Text = "蠟像館鑰匙"
  },
  Skill_4266_Desc = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_80:「窒息」>置入對方手牌。"
  },
  Skill_4266_Name = {
    Text = "溺斃之怨"
  },
  Skill_4268_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4269_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_3:「驚厥」>洗入對方抽牌堆。"
  },
  Skill_4270_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4270_Name = {
    Text = "破鏈一擊"
  },
  Skill_4271_Desc = {
    Text = "造成的傷害為<PunctureDamagewords:穿刺傷害>。使手中算力最高的 1 張牌算力消耗降低 1。"
  },
  Skill_4272_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4273_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_3:「驚厥」>洗入抽牌堆。"
  },
  Skill_4274_Desc = {
    Text = "造成<Block:[Block:Arg1]>護盾，獲得 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4275_AwakerSkillBackgroundStory = {
    Text = "「街頭打鬥可沒那麼多講究，當然是什麼趁手用什麼了。」"
  },
  Skill_4275_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4275_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。詹金獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4275_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4275_Name = {Text = "打擊"},
  Skill_4275_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4277_AwakerSkillBackgroundStory = {
    Text = "無中生有並非科學的領域。\n朵爾一直是如此相信的，宇宙、人類、乃至融蝕現象，萬物皆有起源，事事皆需代價。\n「所以關於點石成金技術的研發，朵爾小姐您看……」\n「研發成功的可能性和你畢業論文的含金量一樣，都是零。」"
  },
  Skill_4277_BattleDesc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命並棄掉所有手牌。"
  },
  Skill_4277_BattleDesc_2 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。棄掉所有手牌，每棄 1 張手牌獲得 <Block:[Heal:Arg2]> 點護盾。"
  },
  Skill_4277_Desc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。棄掉所有手牌，每棄 1 張手牌額外回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4277_Desc_2 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。棄掉所有手牌，每棄 1 張手牌額外回復 <Heal:[Heal:Arg2]> 點生命並獲得等量護盾。"
  },
  Skill_4277_EffectNameList = {
    Text = "回復,回復提高"
  },
  Skill_4277_Name = {
    Text = "等價交換"
  },
  Skill_4277_PropertyNameList = {
    Text = "體質*GrowValue1,體質*GrowValue2"
  },
  Skill_4278_AwakerSkillBackgroundStory = {
    Text = "溫熱的血液從他的面頰滾落，他咧開嘴，露出一排鋒利如刃的獠牙。\n弱肉強食的法則是世界的根本，而他將是永遠的狩獵者。\n他踏著遍地的屍骸，發出勝利的咆哮。"
  },
  Skill_4278_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。臨時移除所有敵人的<PowerIconKeywords:力量>。"
  },
  Skill_4278_Desc_2 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。臨時移除所有敵人的<PowerIconKeywords:力量>，並獲得等同於移除量的臨時<PowerIconKeywords:力量>。"
  },
  Skill_4278_Name = {
    Text = "強者為尊"
  },
  Skill_4278_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4281_AwakerSkillBackgroundStory = {
    Text = "她已經不記得，自己是何時成為如此模樣的了。\n在不知不覺間，昔日跪在父親面前悲泣求饒的少女已經死去，窮奢極侈的亡國之花浴其鮮血而生。\n「我最最尊貴的小渡鴉，今日，你又給我銜來了何等璀璨的珠寶呢？」"
  },
  Skill_4281_BattleDesc = {
    Text = "失去 [Arg1]%([Arg4]) 當前生命。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。在本回合中剩餘時間內，每造成 1 次傷害，回合結束時回復 [Arg3] 點生命。"
  },
  Skill_4281_Desc = {
    Text = "失去 [Arg1]% 當前生命。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。在本回合中剩餘時間內，每造成 1 次傷害，回合結束時回復 [Arg3] 點生命。"
  },
  Skill_4281_EffectNameList = {
    Text = "胚胎融合,回復"
  },
  Skill_4281_PropertyNameList = {
    Text = "$GrowValue1,體質*GrowValue2"
  },
  Skill_4282_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4283_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4283_Name = {
    Text = "桀驁之刃"
  },
  Skill_4284_AwakerSkillBackgroundStory = {
    Text = "她總是告訴新兵們：即使疲憊、即使虛弱，也絕不能放下武器。讓它成為你最貼身的夥伴，最堅實的護盾。\n在戰場上，唯有足夠警惕的能夠活命。"
  },
  Skill_4284_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 [Arg2] 次。回合結束時若在手中，下次打出時額外造成 1 次護盾。驅散所有喚醒體<CardKeyWord:封印>狀態。"
  },
  Skill_4284_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 [Arg2] 次。回合結束時若在手中，下次打出時額外造成 1 次護盾。驅散所有喚醒體<CardKeyWord:封印>狀態。視為「防禦」。"
  },
  Skill_4284_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回合結束時若在手中，下次打出時額外造成 1 次護盾。驅散所有喚醒體<CardKeyWord:封印>狀態。"
  },
  Skill_4284_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回合結束時若在手中，下次打出時額外造成 1 次護盾。驅散所有喚醒體<CardKeyWord:封印>狀態。視為「防禦」。"
  },
  Skill_4284_EffectNameList = {Text = "護盾"},
  Skill_4284_Name = {
    Text = "臨戰體勢"
  },
  Skill_4284_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_4285_AwakerSkillBackgroundStory = {
    Text = "他被當做暴力的象徵召喚，成為角鬥場的明星。\n他被當做暴力的象徵唾棄，成為地下室的囚徒。\n當奔湧的血液被鐵鍊死死禁錮，\n歷經千年的饑渴啊——\n怒吼著，尖嘯著，\n再也無法忍受。"
  },
  Skill_4285_BattleDesc_0 = {
    Text = "失去 [Arg1]%([Arg4]) 當前生命。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4285_Desc_0 = {
    Text = "失去 [Arg1]% 當前生命。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4285_EffectNameList_0 = {
    Text = "傷害,力量"
  },
  Skill_4285_Name = {
    Text = "尖嘯吧，血！"
  },
  Skill_4285_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4286_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4287_AwakerSkillBackgroundStory = {
    Text = "角鬥士閉上雙眼。\n心跳聲平緩有力，掩蓋遠方震耳欲聾的歡呼。\n黑暗之下，名為殺戮的火苗蠢蠢欲動。\n跳動著，沸騰著，直至將無邊的黑幕舔舐乾淨。\n角鬥士睜開眼。他終於準備好了。"
  },
  Skill_4287_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣，生命低於 25%([Arg3]) 時獲得的狂氣翻倍。"
  },
  Skill_4287_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 3 次。獲得 <Energy:[Energy:Arg2]> 點狂氣，生命低於 25%([Arg3]) 時額外造成 2 次傷害並獲得的狂氣翻倍。"
  },
  Skill_4287_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 3 次。尤烏哈希獲得 <Energy:[Energy:Arg2]> 點狂氣，生命低於 25% 時獲得的狂氣翻倍。"
  },
  Skill_4287_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 3 次。尤烏哈希獲得 <Energy:[Energy:Arg2]> 點狂氣，生命低於 25% 時額外造成 2 次傷害並獲得的狂氣翻倍。"
  },
  Skill_4287_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4287_Name = {
    Text = "沸騰吧，血！"
  },
  Skill_4287_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4288_AwakerSkillBackgroundStory = {
    Text = "「群星行至正位之刻，神國在星辰牽引下浮出水面，重現於世。屆時，余亦將重臨，如山嶺般坐鎮天地之間……」"
  },
  Skill_4288_Desc_0 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。"
  },
  Skill_4288_EffectNameList_0 = {
    Text = "臨時觸腕傷害,臨時力量,暴擊率"
  },
  Skill_4288_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。回合結束時，號令所有觸腕攻擊所有敵人 2 次。"
  },
  Skill_4288_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4288_tempBattleDesc_1 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。"
  },
  Skill_4288_tempBattleDesc_2 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。所有敵人受到的觸腕傷害提高 10%，最多疊加 5 次。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_1 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。回合結束時，號令所有觸腕攻擊所有敵人 2 次。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_2 = {
    Text = "獲得 [Arg1] 條觸腕。獲得 [TentaclePower:Arg2] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。獲得 [Arg3]％ 臨時暴擊率。所有敵人受到的觸腕傷害提高 10%，最多疊加 5 次。回合結束時，號令所有觸腕攻擊所有敵人 2 次。"
  },
  Skill_4289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點護盾。玩家回合結束前每擁有一張手牌還會額外獲得 [Arg4] 點護盾。"
  },
  Skill_4289_Name = {Text = "試探"},
  Skill_4290_AwakerSkillBackgroundStory = {
    Text = "凱旋式歷來是羅馬人的盛宴。\n白鴿、月桂葉，以及漫天飛舞的金箔……這一切和戰士有關，又無關。\n他和那些來自高盧、亞力山卓和帕提亞的戰俘一起，被縛在沉重的十字架上遊街示眾。\n這是凱旋式的保留節目。戰士被盡情嘲弄，只因他被認定是那位已故皇帝的血腥同謀。\n恥辱、憤怒，還是仇恨？不，都不是。\n戰士沒有情緒，也沒有思考。\n他只聞到血。"
  },
  Skill_4290_BattleDesc_0 = {
    Text = "尤烏哈希獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：尤烏哈希不受<CardKeyWord:封印>影響，暴擊率和暴擊傷害提高 [Arg2]%，生命低於 25% 時效果翻倍。"
  },
  Skill_4290_BattleDesc_15 = {
    Text = "尤烏哈希獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：尤烏哈希不受<CardKeyWord:封印>影響，暴擊率和暴擊傷害提高 [Arg2]%，「血與沙的讚歌」最終傷害提高 [Arg5]%，生命低於 25% 時效果翻倍。"
  },
  Skill_4290_Desc_0 = {
    Text = "尤烏哈希獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：尤烏哈希不受<CardKeyWord:封印>影響，暴擊率和暴擊傷害提高 [Arg2]%，生命低於 25% 時效果翻倍。"
  },
  Skill_4290_Desc_15 = {
    Text = "尤烏哈希獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：尤烏哈希不受<CardKeyWord:封印>影響，暴擊率和暴擊傷害提高 [Arg2]%，「血與沙的讚歌」最終傷害提高 [Arg5]%，生命低於 25% 時效果翻倍。"
  },
  Skill_4290_EffectNameList = {Text = "狂氣"},
  Skill_4290_Name = {Text = "紅祭禮"},
  Skill_4291_AwakerSkillBackgroundStory = {
    Text = "她喜歡隨心所欲。砍掉一個人的頭，縫起來，再砍掉，再縫起來......沒有動機，沒有目的，一切水到渠成，沒人敢質疑她一個字。"
  },
  Skill_4291_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4291_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。旺達獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4291_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4291_Name = {Text = "打擊"},
  Skill_4291_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4292_Desc = {
    Text = "獲得 3 點算力。"
  },
  Skill_4293_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4293_Name = {Text = "清掃"},
  Skill_4294_Desc = {
    Text = "對雙方各造成 [Arg1] 層<VulnerabilityIconKeywords:易傷>。獲得「利刃Ⅱ」：若造成未被格擋的傷害，在抽牌堆頂添加 2 張<DerivativeCardKeywords_23:「傷口」>。持續 1 回合。"
  },
  Skill_4294_Name = {
    Text = "垂死之掙"
  },
  Skill_4295_AwakerSkillBackgroundStory = {
    Text = "這雙眼睛已無法正常視物。\n她直面時間與現實的風暴，任由呼嘯的混沌切割、攪碎，最後成為她的眼睛。\n屬於「拉蒙娜」的又一個痕跡正從她的身上消失，她抓不住流失的自己，正如她未能抓住從指尖流失的生命。"
  },
  Skill_4295_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。選擇 1 張抽牌堆的牌置入手中並使其算力消耗 -1。<TimeBeacon:回環>：改為選擇 1 張抽牌堆或棄牌堆的牌置入手中，使其算力消耗變為 0。"
  },
  Skill_4295_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4296_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張 <DerivativeCardKeywords_36:「褻瀆假像」> 加入手中。"
  },
  Skill_4297_AwakerSkillBackgroundStory = {
    Text = "當心，此女的一切行為都指向一個最終目的：使人傷害她——不，是狠狠地傷害她。"
  },
  Skill_4297_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4297_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。雷婭獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4297_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4297_Name = {Text = "打擊"},
  Skill_4297_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4298_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4298_Name = {Text = "遺恨"},
  Skill_4299_Desc = {
    Text = "獲得 1 點算力。"
  },
  Skill_4299_Name = {Text = "籌算"},
  Skill_4300_Desc = {
    Text = "對所有敵人施加 1 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4300_Name = {Text = "易傷"},
  Skill_4301_Desc = {
    Text = "抽 1 張牌。"
  },
  Skill_4302_Desc = {
    Text = "其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4303_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆。"
  },
  Skill_4303_Name = {Text = "靈感"},
  Skill_4304_Desc = {
    Text = "對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4304_Name = {Text = "虛弱"},
  Skill_4305_Desc = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4305_Name = {Text = "狂氣"},
  Skill_4306_AwakerSkillBackgroundStory = {
    Text = "她將在地上以祂的名行事。\n她將得祂應得的美名。\n她將於毀滅之時，承無人可受之痛。\n此即為代行者。"
  },
  Skill_4306_Desc_0 = {
    Text = "彌利亞姆獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕上限和觸腕數量 +1，對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。彌利亞姆的「打擊」和「無上生祭」暴擊率提高 100%。將 1 張<O07CardKeyWord4:「信仰的歧路」>置入手中。"
  },
  Skill_4306_Desc_15 = {
    Text = "彌利亞姆獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕上限和觸腕數量 +1，對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。彌利亞姆的「打擊」和「無上生祭」暴擊率提高 100%。將 1 張<O07CardKeyWord4:「信仰的歧路」>置入手中。每翻轉 2 張「聖禮」將一張「神國幻影」置入手中。"
  },
  Skill_4306_EffectNameList = {Text = "狂氣"},
  Skill_4306_Name = {
    Text = "信仰的見證"
  },
  Skill_4307_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量傷害<BleedingIconKeywords:出血>。"
  },
  Skill_4308_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4309_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張症狀<DerivativeCardKeywords_9:「頹喪」>洗入抽牌堆。"
  },
  Skill_4309_Name = {
    Text = "無聲尖嘯"
  },
  Skill_4310_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使對方直到回合結束，失去 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4311_AwakerSkillBackgroundStory = {
    Text = "柔軟的輕觸，會讓你感覺到愛嗎？\n溫熱的吐息，會讓你沉湎於我嗎？\n這珠玉與輕紗環繞的愛撫，對你而言，是禮物嗎？"
  },
  Skill_4311_Desc_0 = {
    Text = "選擇 1 名其他喚醒體，使自身和該喚醒體均獲得 <Energy:[Energy:Arg1]> 點狂氣。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4311_EffectNameList = {
    Text = "狂氣,力量"
  },
  Skill_4311_Name = {
    Text = "古老的愛撫"
  },
  Skill_4311_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4313_Desc = {
    Text = "施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4314_AwakerSkillBackgroundStory = {
    Text = "她的血因祂們滾燙，她的大腦因祂們沸騰。\n無論這些異形之子能否實現她的夙願，無論祂們是否能在虛無中存續。\n泰旖絲滿懷愛意地迎接著每個聖潔之子的降生。"
  },
  Skill_4314_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：使其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。】對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，造成 [Arg3]% 傷害的<BleedingIconKeywords:出血>，並施加 [Arg4]% 傷害的<IntoxicationIconKeywords:中毒>並獲得 [Arg5]% 傷害的<RetaliateIconKeywords:反擊>。選擇 1 張手中的非衍生指令卡，將其 [Arg7] 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的原始複製置入手中，使其算力消耗 -[Arg6]。"
  },
  Skill_4314_EffectNameList = {
    Text = "狂氣,傷害,出血百分比,中毒百分比,反擊百分比"
  },
  Skill_4314_Name = {
    Text = "豐穰之儀"
  },
  Skill_4314_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：使其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。】對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，造成 [Arg3]% 傷害的<BleedingIconKeywords:出血>，並施加 [Arg4]% 傷害的<IntoxicationIconKeywords:中毒>並獲得 [Arg5]% 傷害的<RetaliateIconKeywords:反擊>。選擇 1 張手中的非衍生指令卡，將其 [Arg7] 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的原始複製置入手中，使其算力消耗 -[Arg6]。接下來 3 回合內，每回合開始時將 1 張「胚胎」轉化為「聖潔之子」，若沒有「胚胎」則<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg8]，不受胚胎融合提高效果影響。"
  },
  Skill_4314_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,$GrowValue3,$GrowValue4,$GrowValue5"
  },
  Skill_4315_AwakerSkillBackgroundStory = {
    Text = "保護我。保護我。保護我。\n懦弱的怪物，和她一樣，似有生命，似無意識。\n漆黑黏液彙聚成她的使從，不分晝夜地被指令驅使。"
  },
  Skill_4315_Desc_0 = {
    Text = "莉莉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時獲得 10% 最大生命的<PainWord:忍耐>。莉莉施加護盾時，對生命最高敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4315_Desc_15 = {
    Text = "莉莉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時獲得 10% 最大生命的<PainWord:忍耐>。莉莉施加護盾時，對生命最高敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。狂氣爆發使本回合每受到 1 次攻擊就使下次「報償打擊」消耗<PainWord:忍耐>的效果提高 40%，最多疊加 5 層。"
  },
  Skill_4315_EffectNameList = {
    Text = "狂氣,中毒"
  },
  Skill_4315_Name = {
    Text = "黏液彙集"
  },
  Skill_4315_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4316_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入對方抽牌堆。"
  },
  Skill_4316_Name = {Text = "蠟油"},
  Skill_4317_Desc = {
    Text = "自爆！造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4318_Desc = {
    Text = "戰鬥結束後仍會保存在牌庫中。無法出售。"
  },
  Skill_4318_Name = {
    Text = "黏糊糊的蠟油"
  },
  Skill_4319_Desc = {
    Text = "所有友方獲得 <Block:[Block:Arg1]> 點護盾與 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4319_Name = {Text = "呼嘯"},
  Skill_4320_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4322_AwakerSkillBackgroundStory = {
    Text = "飛蛾沒有頭腦，只會依從本能亂撞。\n既然如此，那就讓這幫頭腦不比飛蛾發達的傢伙們看看他們垂涎之物吧。\n那是年輕女孩充滿稚氣童真的夢。"
  },
  Skill_4322_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，將 1 張具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「綠炎」>置入手中。<TransitionIconKeywords:躍遷>：下個回合開始前，每受到 1 次攻擊，便將 1 張具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「綠炎」>置入手中。"
  },
  Skill_4322_EffectNameList_0 = {Text = "護盾"},
  Skill_4322_Name = {
    Text = "誘蛾之火"
  },
  Skill_4322_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4323_AwakerSkillBackgroundStory = {
    Text = "奧吉爾的持槍姿勢並不標準，但所有能指導他的人，都已經消失在了時間與黑暗中。"
  },
  Skill_4323_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4323_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。奧吉爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4323_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4323_Name = {Text = "打擊"},
  Skill_4323_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4324_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<FragileIconKeywords:脆弱>。"
  },
  Skill_4325_AwakerSkillBackgroundStory = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  Skill_4325_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4325_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。戈利亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4325_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4325_Name = {Text = "打擊"},
  Skill_4325_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4326_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4328_Desc = {
    Text = "對全體敵方施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4329_AwakerSkillBackgroundStory = {
    Text = "即使她親眼目睹了故土的覆滅，即使她所知的一切都已經在融蝕的吞噬下消失殆盡，她也不願意放棄尋找。定位儀亮起搜尋的光，試圖找到與她有著共同故鄉的人。\n一定會有的，一定會有的。"
  },
  Skill_4329_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，棄掉所有手牌。<TransitionIconKeywords:躍遷>：不再棄牌，改為獲得 <Block:[Block:Arg4]> 點護盾並抽 1 張牌。"
  },
  Skill_4329_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾，棄掉所有手牌，每棄掉 1 張牌獲得 <Block:[Block:Arg2]> 點延遲護盾。<TransitionIconKeywords:躍遷>：不再棄牌，改為獲得 <Block:[Block:Arg4]> 點護盾並抽 2 張牌。"
  },
  Skill_4329_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，棄掉所有手牌，每棄掉 1 張牌獲得的護盾提高 50%。<TransitionIconKeywords:躍遷>：不再棄牌並抽 1 張牌，獲得的護盾提高 100%。"
  },
  Skill_4329_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，棄掉所有手牌，每棄掉 1 張牌獲得的護盾提高 50%並獲得 <Block:[Block:Arg2]> 點延遲護盾。<TransitionIconKeywords:躍遷>：不再棄牌並抽 2 張牌，獲得的護盾提高 100%。"
  },
  Skill_4329_EffectNameList_0 = {Text = "護盾"},
  Skill_4329_EffectNameList_2 = {
    Text = "護盾,延遲護盾"
  },
  Skill_4329_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4329_PropertyNameList_2 = {
    Text = "防禦力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4332_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4333_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4334_AwakerSkillBackgroundStory = {
    Text = "於黑色淤泥中綻放的蓓蕾。也曾經感受過園丁的呵護，也曾沐浴過雨露的照拂。\n而此刻，它孤獨地綻放，任憑狂風切割嬌嫩的皮膚，任憑暴雨擊打孱弱的身軀，任憑薄而鋒利的刀刃切開表皮，長而尖銳的針頭刺入骨髓。\n反正，身體裡寄宿的那個巨大的怪物，會替她抵擋傷痛。\n或許陪伴在她身邊的，已經只有那個巨大的怪物，從今往後，只能與怪物為伍……"
  },
  Skill_4334_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]% 的生命並移除<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]% 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_EffectNameList_0 = {
    Text = "護盾,中毒"
  },
  Skill_4334_Name = {
    Text = "淤泥上的不滅之花"
  },
  Skill_4334_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回覆<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本場戰鬥內忍耐上限提高 100%，獲得等同於最大生命的忍耐。將 2 張附加消耗的「報償打擊」置入手中。"
  },
  Skill_4334_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本場戰鬥內忍耐上限提高 100%，獲得等同於最大生命的忍耐。將 2 張附加消耗的「報償打擊」置入手中。"
  },
  Skill_4334_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4334_tempBattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。"
  },
  Skill_4334_tempBattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本回合每受到 1 次攻擊就使下次「報償打擊」消耗<PainWord:忍耐>的效果提高 40%，最多疊加 5 層。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回覆<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本場戰鬥內忍耐上限提高 100%，獲得等同於最大生命的忍耐。將 2 張附加消耗的「報償打擊」置入手中。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本場戰鬥內忍耐上限提高 100%，獲得等同於最大生命的忍耐。將 2 張附加消耗的「報償打擊」置入手中。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。回復<PainWord:忍耐>層數 [Arg2]%([Arg3]) 的生命並移除一半<PainWord:忍耐>。每受到 1 次攻擊，對攻擊者施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>，持續 1 回合。本場戰鬥內忍耐上限提高 100%，獲得等同於最大生命的忍耐。將 2 張附加消耗的「報償打擊」置入手中。本回合每受到 1 次攻擊就使下次「報償打擊」消耗<PainWord:忍耐>的效果提高 40%，最多疊加 5 層。"
  },
  Skill_4336_Desc = {
    Text = "為全體友方施加 [Arg1] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_4336_Name = {
    Text = "全體屏障"
  },
  Skill_4337_AwakerSkillBackgroundStory = {
    Text = "德克斯特勳爵發誓，最初讓女兒學習古典刺劍時，他只希望這項技能能提升她的氣質——顯然，拉蒙娜的追求不止於此。"
  },
  Skill_4337_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4337_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。拉蒙娜獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4337_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4337_Name = {Text = "打擊"},
  Skill_4337_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4338_Desc = {
    Text = "全體獲得 [Arg1] <PowerIconKeywords:力量>。前進。"
  },
  Skill_4338_Name = {
    Text = "全體力量"
  },
  Skill_4339_AwakerSkillBackgroundStory = {
    Text = "曾有人半開玩笑地詢問艾繼絲能不能給自己織一條圍巾，因為她身上從毛衣針到毛線一應俱全。\n艾繼絲不好意思地低下頭。她沒有告訴別人，她頭上的毛衣針並不是裝飾，而是壓制她眼睛的力量的特殊器具。\n幾天后，她用借來的毛衣針完成了一條彩色圍巾。"
  },
  Skill_4339_Desc_0 = {
    Text = "艾繼絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：艾繼絲打出卡牌後，對所有敵人施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4339_Desc_15 = {
    Text = "艾繼絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：艾繼絲打出卡牌後，對所有敵人施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>。艾繼絲釋放狂氣爆發後使自身下一張「防禦」生效 3 次，額外使狂氣爆發基礎傷害提高 50%。"
  },
  Skill_4339_EffectNameList = {Text = "狂氣"},
  Skill_4339_Name = {
    Text = "凝滯詛咒"
  },
  Skill_4340_Desc = {
    Text = "獲得 [Arg3] 點臨時<PowerIconKeywords:力量>，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。如果失去生命，則失去臨時<PowerIconKeywords:力量>加成。"
  },
  Skill_4340_Name = {
    Text = "割喉揮砍(破綻)"
  },
  Skill_4341_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4342_AwakerSkillBackgroundStory = {
    Text = "很難說是別稱為「街頭老鼠」的孩子們接納了老鼠，還是真正的老鼠接納了街童，這段因生計所迫而誕生的情誼，卻在多年的相處下變得堅不可破。\n誰能說動物不是人類最好的朋友呢？"
  },
  Skill_4342_Desc = {
    Text = "將 [Arg1] 張附加<DepleteIconKeywords:消耗>、算力消耗為 0 的「布朗出動！」置入手牌。臨時暴擊傷害 +[Arg2]% 。"
  },
  Skill_4342_EffectNameList = {
    Text = "臨時暴擊傷害"
  },
  Skill_4342_Name = {
    Text = "霧都街童"
  },
  Skill_4342_OverLimitUtlSkillDesc = {
    Text = "將 [Arg1] 張附加<DepleteIconKeywords:消耗>、算力消耗為 0 的「布朗出動！」置入手牌。臨時暴擊傷害 +[Arg2]% 。將 1 張附加<DepleteIconKeywords:消耗>的「超級大集結！」置入手牌。"
  },
  Skill_4343_AwakerSkillBackgroundStory = {
    Text = "在戰場上他所向披靡，重劍一杵，那些不敵之人便潰不成軍。"
  },
  Skill_4343_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4343_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。戈利亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4343_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4343_Name = {Text = "防禦"},
  Skill_4343_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4344_AwakerSkillBackgroundStory = {
    Text = "歌聲是她的盾牌。\n這盾牌卻不能抵擋那些呼來喝去中隱含的輕蔑與侮辱。"
  },
  Skill_4344_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4344_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 2 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：額外獲得 1 次狂氣。"
  },
  Skill_4344_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4344_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 2 次。汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：額外獲得 1 次狂氣。"
  },
  Skill_4344_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4344_Name = {Text = "防禦"},
  Skill_4344_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4345_Desc = {
    Text = "雷婭在每失去一定生命後，獲得等同於最大生命的護盾。"
  },
  Skill_4346_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，後撤。"
  },
  Skill_4347_Desc = {
    Text = "每回合獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4347_Name = {
    Text = "遠古的呼喚"
  },
  Skill_4348_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<ParcloseIconKeywords:屏障>。玩家回合結束前每擁有一張手牌還會額外獲得 [Arg4] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_4348_Name = {Text = "試探"},
  Skill_4349_AwakerSkillBackgroundStory = {
    Text = "漆黑的黏液將她拖入深淵。群星在這裡誕生，光線在這裡死去。這裡沒有時間，沒有生命。\n一個聲音從遠處走來，散發著黑色的光。\n它說：你將永遠變得不同，因為你已經造訪妖精的通道。\n她將在這裡漫長地遊蕩。"
  },
  Skill_4349_Desc_0 = {
    Text = "詹金獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：暴擊率提高 [Arg2]% ，詹金每造成 1 次傷害，臨時暴擊傷害 +[Arg3]%，每回合最多疊加 5 次。"
  },
  Skill_4349_Desc_15 = {
    Text = "詹金獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：暴擊率提高 [Arg2]% ，詹金每造成 1 次傷害，臨時暴擊傷害 +[Arg3]%，每回合最多疊加 5 次。詹金自身從「空間折疊」和「霧都街童」中獲得 2 倍暴擊傷害效果。"
  },
  Skill_4349_EffectNameList = {Text = "狂氣"},
  Skill_4349_Name = {
    Text = "空間折疊"
  },
  Skill_4350_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4351_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_27:症狀：「癲癇」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4352_Desc = {
    Text = "進化為「干涉型融蝕體」。當前生命越高進化的怪物就越強。"
  },
  Skill_4352_Name = {
    Text = "融蝕進化"
  },
  Skill_4353_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>，回合結束時<PowerIconKeywords:力量>降低 [Arg2] 點。"
  },
  Skill_4353_Name = {
    Text = "枷鎖：彷徨的利刃"
  },
  Skill_4354_Desc = {
    Text = "吸收所有友方並回復等量生命。獲得 [Arg1] <PowerIconKeywords:力量>，每吸收一個「都怪你」額外獲得 [Arg2]<PowerIconKeywords:力量>。"
  },
  Skill_4356_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4356_Name = {
    Text = "小小願望"
  },
  Skill_4357_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4357_Name = {
    Text = "擁抱融蝕"
  },
  Skill_4358_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4359_Desc = {
    Text = "對全體敵方施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，觸發目標的中毒效果。"
  },
  Skill_4359_Name = {
    Text = "毒性發作"
  },
  Skill_4360_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4360_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4360_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。潘狄婭獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4360_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。潘狄婭獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4360_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4360_EffectNameList_1 = {
    Text = "護盾,狂氣,反擊"
  },
  Skill_4360_Name = {Text = "防禦"},
  Skill_4360_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4360_PropertyNameList_1 = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4361_AwakerSkillBackgroundStory = {
    Text = "搖籃中的少女，會夢到未曾得見的花嗎？\n那會是怎樣的花呢？會如她一般，被桎梏方寸間，於掌心大小的盆中破土嗎？\n還是會像妹妹的歌謠中一般，盛放於星海，被宇宙塵埃與星流帶向未知的遠方？"
  },
  Skill_4361_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：將 1 張算力消耗為 0 的「幼芽萌生」置入手牌並附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虛弱>全體敵方 2 回合。】獲得 [Counterattack:Arg1] 層<RetaliateIconKeywords:反擊>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，則 +[Arg3]%。驅散自身<FragileIconKeywords:脆弱>。"
  },
  Skill_4361_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：將 1 張算力消耗為 0 的「幼芽萌生」置入手牌並附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虛弱>全體敵方 2 回合。】獲得 [Counterattack:Arg1] 層<RetaliateIconKeywords:反擊>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，則 +[Arg3]%。驅散自身<FragileIconKeywords:脆弱>。"
  },
  Skill_4361_EffectNameList_0 = {
    Text = "反擊,死亡抵抗上限,死亡抵抗"
  },
  Skill_4361_Name = {
    Text = "星之搖籃"
  },
  Skill_4361_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：將 1 張算力消耗為 0 的「幼芽萌生」置入手牌並附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虛弱>全體敵方 2 回合。】獲得 [Counterattack:Arg1] 層<RetaliateIconKeywords:反擊>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，則 +[Arg3]%。驅散自身<FragileIconKeywords:脆弱>。使所有敵人臨時降低 [Exhaustion:Arg5] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_4361_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4362_Desc = {
    Text = "造成 [Arg1] 層<IntoxicationIconKeywords:中毒>，對抽牌堆和棄牌堆中隨機 [Arg2] 張卡牌施加「<SlowIconKeywords:遲緩>」"
  },
  Skill_4362_Name = {
    Text = "遲緩迷毒"
  },
  Skill_4363_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獻祭自身。不受瘋狂影響。"
  },
  Skill_4363_Name = {Text = "獻祭"},
  Skill_4364_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！"
  },
  Skill_4365_AwakerSkillBackgroundStory = {
    Text = "有人固執地認為，身體與靈魂應是永恆的一體；也有人害怕失去肉體後，彷徨不定的神智將走向毀滅。\n回應質疑在朵爾眼裡是件麻煩事，她選擇用一具又一具傀儡身體的更迭來證明手術的成功。"
  },
  Skill_4365_Desc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。對所有敵人造成 [Arg2] 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4365_EffectNameList = {Text = "回復"},
  Skill_4365_Name = {
    Text = "外域手術"
  },
  Skill_4365_PropertyNameList = {
    Text = "體質*GrowValue1,"
  },
  Skill_4366_AwakerSkillBackgroundStory = {
    Text = "歌聲是她的武器。\n這武器陪伴她在漫天星光中孤獨流浪。"
  },
  Skill_4366_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4366_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：額外造成 1 次傷害。"
  },
  Skill_4366_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4366_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次。汀克特獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：額外造成 1 次傷害。"
  },
  Skill_4366_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4366_Name = {Text = "打擊"},
  Skill_4366_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4367_AwakerSkillBackgroundStory = {
    Text = "莉茲還記得自己獲得綠炎那天的景象。\n青色的火種在掌心升騰躍動，催促她去達成那壓抑已久的願望。"
  },
  Skill_4367_Desc = {
    Text = "對隨機敵人造成 <Damage:[Damage:Arg2]> 點<PunctureDamagewords:穿刺傷害> [Arg1] 次，施加 50% 傷害的<IntoxicationIconKeywords:中毒>。算力不足時可以強行打出，效果改為獲得 <Energy:[Energy:Arg3]> 點狂氣並消耗。"
  },
  Skill_4367_EffectNameList = {Text = "傷害"},
  Skill_4367_Name = {
    Text = "死滅綠炎"
  },
  Skill_4367_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4368_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4371_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，恢復等同於未被格擋傷害的生命。將 1 張<DerivativeCardKeywords_34:「未被滿足之痛」>置入抽牌堆。"
  },
  Skill_4371_Name = {
    Text = "苦痛與血"
  },
  Skill_4372_Desc = {
    Text = "對雙方各造成 [Arg1] 層<VulnerabilityIconKeywords:易傷>。獲得「利刃Ⅱ」：若造成未被格擋的傷害，在抽牌堆頂添加 2 張<DerivativeCardKeywords_23:「傷口」>。持續 1 回合。"
  },
  Skill_4372_Name = {
    Text = "垂死之掙"
  },
  Skill_4373_AwakerSkillBackgroundStory = {
    Text = "她的前鰭能夠劈開航道，尾鰭足以砸出港灣。\n在無人可戰後，巨鯨於混沌中沉眠，將星球託付給了新生的生靈。"
  },
  Skill_4373_BattleDesc_0 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。"
  },
  Skill_4373_BattleDesc_3 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。將 2 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的「打擊」置入手中。"
  },
  Skill_4373_Desc_0 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。"
  },
  Skill_4373_Desc_15 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。將 2 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的「打擊」置入手中。"
  },
  Skill_4373_Desc_3 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。將 2 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的「打擊」置入手中。"
  },
  Skill_4373_EffectNameList = {
    Text = "傷害,傷害"
  },
  Skill_4373_Name = {
    Text = "混沌之獸"
  },
  Skill_4373_OverLimitUtlSkillDesc_0 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。對所有敵人額外造成 1 次 15% 目標最大生命值的<FixedDamage:純粹傷害>。本場戰鬥中「混沌之獸」的基礎傷害提高 100%。"
  },
  Skill_4373_OverLimitUtlSkillDesc_3 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。在本場戰鬥中每打出 1 張「打擊」便使傷害+ [Arg2] 。將 2 張附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>的「打擊」置入手中。對所有敵人額外追加 1 次 15% 目標最大生命值的<FixedDamage:純粹傷害>。本場戰鬥中「混沌之獸」的基礎傷害提高 100%。"
  },
  Skill_4373_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4374_Desc = {
    Text = "一點小傷，無傷大體。受到 [Arg1] 點<FixedDamage:純粹傷害>，抽 [Arg3] 張牌。"
  },
  Skill_4374_Name = {Text = "傷口"},
  Skill_4375_AwakerSkillBackgroundStory = {
    Text = "一步一步，她緩緩邁入海水之中。\n剛觸及皮膚還顯得稍許寒涼的入夜之海，此刻竟如人類的擁抱一般溫暖。\n海接納了我，這樣的思緒，悄然飄入了寧菲亞腦中。\n恍然間，見到了父母的笑容。在那海的深處，一定有著天倫的安樂吧。"
  },
  Skill_4375_Desc_0 = {
    Text = "寧菲亞獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：寧菲亞打出卡牌後，獲得 <Energy:[Energy:Arg2]> 點狂氣。回合結束時，使寧菲亞造成的中毒提高 [Arg3]%。"
  },
  Skill_4375_Desc_15 = {
    Text = "寧菲亞獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：寧菲亞打出卡牌後，獲得 <Energy:[Energy:Arg2]> 點狂氣。回合結束時，使寧菲亞造成的中毒提高 [Arg4]%。"
  },
  Skill_4375_EffectNameList = {
    Text = "狂氣,打出卡牌獲得狂氣,中毒成長"
  },
  Skill_4376_AwakerSkillBackgroundStory = {
    Text = "「別、別過來，我不想傷害你！」"
  },
  Skill_4376_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4376_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，目標每有 1 層<VulnerabilityIconKeywords:易傷>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]，最多 [Arg4]。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4376_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。艾繼絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4376_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，目標每有 1 層<VulnerabilityIconKeywords:易傷>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]，最多 [Arg4]。艾繼絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4376_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4376_Name = {Text = "打擊"},
  Skill_4376_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4377_AwakerSkillBackgroundStory = {
    Text = "不敬之人，無禮之人，褻瀆之人，不配前往永恆的國。"
  },
  Skill_4377_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4377_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。使 1 條觸腕攻擊 2 次，但只造成 50％ 的傷害。"
  },
  Skill_4377_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。法洛思獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4377_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。法洛思獲得 <Energy:[Energy:Arg2]> 點狂氣。使 1 條觸腕攻擊 2 次，但只造成 50％ 的傷害。"
  },
  Skill_4377_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4377_Name = {Text = "打擊"},
  Skill_4377_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4378_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4379_AwakerSkillBackgroundStory = {
    Text = "宣告：\n無法感知藝術至美的庸俗之人啊，因舞者痛苦而雀躍的狂熱之人啊，對功名利祿貪得無厭的可悲之人啊。\n此即你們的末路。\n為你們獻上這支告死之舞，讓綠炎淨化你們的靈魂，讓優美的火焰滌盪你們污濁蒙蔽的心。\n讓我們於永恆的淨土再會。"
  },
  Skill_4379_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。棄掉手牌中所有莉茲的牌，並觸發他們的效果。"
  },
  Skill_4379_Desc_3 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。棄掉手牌中所有莉茲的牌，並觸發他們的效果。每棄掉 2 張牌，便抽 1 張牌。"
  },
  Skill_4379_OverLimitUtlSkillDesc_0 = {
    Text = "將手牌中所有的「綠炎」與「腐化綠炎」升級為「死滅綠炎」，之後 [Arg2] 個回合，每回合開始時重複 1 次該效果。獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。棄掉手牌中所有莉茲的牌，並觸發他們的效果。"
  },
  Skill_4379_OverLimitUtlSkillDesc_3 = {
    Text = "將手牌中所有的「綠炎」與「腐化綠炎」升級為「死滅綠炎」，之後 [Arg2] 個回合，每回合開始時重複 1 次該效果。獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。棄掉手牌中所有莉茲的牌，並觸發他們的效果。每棄掉 2 張牌，便抽 1 張牌。"
  },
  Skill_4379_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4380_Desc = {
    Text = "回復莎拉 [Arg1] 點生命。"
  },
  Skill_4380_Name = {Text = "回復"},
  Skill_43819_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_43819_Name = {Text = "覺醒"},
  Skill_4381_AwakerSkillBackgroundStory = {
    Text = "蛻變之時已至。\n傳承者是比凡人更加高貴的存在。\n捨棄親人、捨棄友人、捨棄苦痛、捨棄過往一切。\n我將獲得榮光之加護。\n他的體表密生鱗刺。"
  },
  Skill_4381_Desc_0 = {
    Text = "凱刻斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，凱刻斯每打出 1 張牌，回復 <Heal:[Heal:Arg2]> 點生命並獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4381_Desc_15 = {
    Text = "凱刻斯獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，凱刻斯每打出 1 張牌，回復 <Heal:[Heal:Arg2]> 點生命並獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>，使 1 條觸腕進行攻擊，獲得 [Arg4]％ 造成傷害的反擊。"
  },
  Skill_4381_EffectNameList = {
    Text = "狂氣,回復,反擊"
  },
  Skill_4381_Name = {
    Text = "蛻變之軀"
  },
  Skill_4381_PropertyNameList = {
    Text = "$GrowValue1,體質*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4382_Desc = {
    Text = "注視一名喚醒體。使用被注視喚醒體的卡牌會再抽 2 張牌。"
  },
  Skill_4382_Name = {
    Text = "追獵注視"
  },
  Skill_4383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4383_Name = {Text = "明滅"},
  Skill_4384_AwakerSkillBackgroundStory = {
    Text = "越是禁欲與壓抑之地，少女的掌控能力就越是驚人。\n響亮的皮鞭等同於甜美的愛語，灼熱的滴蠟替代了滾燙的親吻，緊繃的繩縛是無微不至的關懷，紅腫的傷疤則是愛意的證明。\n在那蜜糖色的悲慘幻象中，傳出少女銀鈴般的笑聲。"
  },
  Skill_4384_Desc_0 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 2 次，每層<RetaliateIconKeywords:反擊>使傷害提高 [Arg2] 點。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4384_Desc_3 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害 2 次，每層<RetaliateIconKeywords:反擊>使傷害提高 [Arg2] 點。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>和 [Counterattack:Arg4] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4384_EffectNameList_0 = {
    Text = "傷害,力量"
  },
  Skill_4384_EffectNameList_3 = {
    Text = "傷害,力量,反擊"
  },
  Skill_4384_Name = {
    Text = "蜜糖色悲慘幻象"
  },
  Skill_4384_OverLimitUtlSkillDesc = {
    Text = "對全體敵方施加 1 層<VulnerabilityIconKeywords:易傷>，造成 <Damage:[Damage:Arg1]> 點傷害 2 次，每層<RetaliateIconKeywords:反擊>使傷害提高 [Arg2] 點。獲得 [Arg3] 點<PowerIconKeywords:力量>和 [Counterattack:Arg5] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4384_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4384_PropertyNameList_3 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4385_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4386_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4387_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4388_AwakerSkillBackgroundStory = {
    Text = "在難以計數的輪回中，她將歸因牢牢繫於己身，一步步深陷因果的沼澤。\n悖論撕扯著她的身體，混沌填充著她的靈魂，而在無盡的痛苦中，她抓住了「未知」漏下的一縷微光。"
  },
  Skill_4388_Desc_0 = {
    Text = "環行·拉蒙娜獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：環行·拉蒙娜打出未觸發<TimeBeacon:回環>的卡牌後，獲得 1 層<TimeBeacon2:負熵>和獲得 <Posse:[Arg2]> 點銀鑰能量，每回合最多觸發 3 次。"
  },
  Skill_4388_Desc_15 = {
    Text = "環行·拉蒙娜獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：環行·拉蒙娜打出未觸發<TimeBeacon:回環>的卡牌後，獲得 1 層<TimeBeacon2:負熵>和獲得 <Posse:[Arg2]> 點銀鑰能量，打出觸發<TimeBeacon:回環>的卡牌後，獲得 50 點銀鑰能量。"
  },
  Skill_4388_EffectNameList = {Text = "狂氣"},
  Skill_4388_Name = {
    Text = "熵增逆轉"
  },
  Skill_4389_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！這燈只是為了照明罷了。」"
  },
  Skill_4389_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4389_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4389_Name = {Text = "防禦"},
  Skill_4389_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4390_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。自身獲得 [Arg3] 層「蠟質鍍層」：免疫異常狀態，每次被暴擊後減少 1 層。"
  },
  Skill_4390_Name = {
    Text = "蠟像登場"
  },
  Skill_4391_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次。施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4392_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4392_Name = {Text = "重擊"},
  Skill_4393_AwakerSkillBackgroundStory = {
    Text = "詩歌首次出版的那天，花匠滿懷雀躍地帶來了一朵玫瑰。\n她小心翼翼地將玫瑰珍藏起來。在花園走向衰亡之前，那是這場幻夢最美好的高潮。"
  },
  Skill_4393_BattleDesc = {
    Text = "選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。 <TransitionIconKeywords:躍遷>：切換至情緒「喜」。"
  },
  Skill_4393_Desc = {
    Text = "選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。 <TransitionIconKeywords:躍遷>：切換至情緒「喜」。每消耗 1 層隱喻「喜」，額外獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4393_EffectNameList = {Text = "狂氣"},
  Skill_4393_Name = {
    Text = "幻夢詩篇"
  },
  Skill_4394_Desc = {
    Text = "施加 [Arg1] 層空虛。"
  },
  Skill_4394_Name = {
    Text = "狂氣吸收"
  },
  Skill_4395_Desc = {
    Text = "全體回復 [Arg1] 點生命。"
  },
  Skill_4395_Name = {Text = "回復"},
  Skill_4396_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4396_Name = {Text = "試探"},
  Skill_4397_AwakerSkillBackgroundStory = {
    Text = "我們是命運的三相姐妹 \n是奔跑在天空、大地與海洋的回音\n是永不分割的連綿雨水\n直到長夜將盡 沒有什麼能將我們分開"
  },
  Skill_4397_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4397_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 傷害。「24」獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4397_EffectNameList = {Text = "傷害"},
  Skill_4397_Name = {
    Text = "異種共生"
  },
  Skill_4397_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4398_AwakerSkillBackgroundStory = {
    Text = "加注、加注、肆無忌憚地加注。\n西裝侍者比了個手勢、對家牌手擦了一把額頭的汗、頭頂掛鐘指針剛過0點。\n喧囂擁擠的人群中，無數細節落入他眼底，不經演算便引向正確的結論。\n在那場終極的覆滅來臨之前，他未嘗敗績。"
  },
  Skill_4398_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。隨機抽 1~ [Arg3] 張牌，每抽 1 張牌獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4398_EffectNameList_0 = {
    Text = "傷害,力量"
  },
  Skill_4398_Name = {
    Text = "肆意豪賭"
  },
  Skill_4398_OverLimitUtlSkillDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 3 次。隨機抽 1~ [Arg3] 張牌，每抽 1 張牌獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，使抽到的卡牌算力消耗 -1。"
  },
  Skill_4398_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4400_AwakerSkillBackgroundStory = {
    Text = "沉浸於作品之中吧，不論是創作還是觀賞，它都能給人帶來無盡的慰藉。"
  },
  Skill_4400_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4400_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。珊獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4400_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4400_Name = {Text = "防禦"},
  Skill_4400_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4401_Desc = {
    Text = "獲得[Arg1] 點<PowerIconKeywords:力量>，吞噬敵人，跳過其下回合抽牌並造成無法抵抗的封印，但將維度裂隙的卡牌加入手中。"
  },
  Skill_4401_Name = {
    Text = "現世撕裂"
  },
  Skill_4402_Desc = {
    Text = "造成<Block:[Block:Arg1]>護盾，獲得 [Arg2] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4403_AwakerSkillBackgroundStory = {
    Text = "無數齒輪彼此交疊，互相驅動，賦予瓷制的外殼以模仿生命的能力。\n這是她最得意的作品，是無法複製的精妙儀器。\n艾瑞卡無論如何也不可能想到，這個與自己同名的自動人偶，竟會成為自己的第二次生命。"
  },
  Skill_4403_Desc_0 = {
    Text = "艾瑞卡獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：艾瑞卡造成傷害時，獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>；艾瑞卡施加護盾時，獲得 [Arg3] 點臨時<AlertIconKeywords:戒備>。"
  },
  Skill_4403_Desc_15 = {
    Text = "艾瑞卡獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：艾瑞卡造成傷害時，獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>；艾瑞卡施加護盾時，獲得 [Arg3] 點臨時<AlertIconKeywords:戒備>。艾瑞卡每次釋放狂氣爆發後使狂氣爆發享受的力量與戒備加成額外提高 1 倍。"
  },
  Skill_4403_EffectNameList = {
    Text = "狂氣,力量,戒備"
  },
  Skill_4403_Name = {
    Text = "參數擬合"
  },
  Skill_4403_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,防禦力*GrowValue3"
  },
  Skill_4404_AwakerSkillBackgroundStory = {
    Text = "她的禮儀是雜糅的，在宮廷中學了些，在市井中耳濡目染了些，在最初的神廟中被灌輸了些。"
  },
  Skill_4404_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4404_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4404_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。泰旖絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4404_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。泰旖絲獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4404_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4404_EffectNameList_3 = {
    Text = "護盾,狂氣"
  },
  Skill_4404_Name = {Text = "防禦"},
  Skill_4404_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4404_PropertyNameList_3 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4405_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！這燈只是為了照明罷了。」"
  },
  Skill_4405_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。詹金獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4405_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4405_Name = {Text = "防禦"},
  Skill_4405_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4407_AwakerSkillBackgroundStory = {
    Text = "她的皮膚發綠，腐爛的血管不斷扭曲、盤旋。\n她的肩部彷彿正在孕育著某樣東西——黑色的液體正順著她的手臂，蔓延到手術臺上。\n初生的血肉自創口中綻放，爭先恐後，輕柔無聲。\n虛弱的少女露出微笑。\n「終於又見面了，@2。」"
  },
  Skill_4407_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。直到下個回合開始前，每損失 2 點生命，下個回合開始時獲得 1 點護盾。"
  },
  Skill_4407_Desc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg2] 次。直到下個回合開始前，每損失 2 點生命，下個回合開始時獲得 1 點護盾。"
  },
  Skill_4407_EffectNameList_0 = {Text = "傷害"},
  Skill_4407_Name = {
    Text = "苦痛與歡愉"
  },
  Skill_4407_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4408_AwakerSkillBackgroundStory = {
    Text = "人類已知的光譜中不存在這種光線。\n像極光一樣流光溢彩，像極光一樣遙不可及，也像極光一樣轉瞬即逝。"
  },
  Skill_4408_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。臨時暴擊率 +[Arg2]%。本場戰鬥內，汀克特的「打擊」基礎傷害提高 [Arg3]%。使隨機 5 張手牌直到回合結束時，算力消耗 -1。"
  },
  Skill_4408_Desc_3 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。臨時暴擊率和暴擊傷害 +[Arg2]%。本場戰鬥內，汀克特的「打擊」基礎傷害提高 [Arg3]%。使隨機 5 張手牌直到回合結束時，算力消耗 -1。"
  },
  Skill_4408_Name = {
    Text = "星彩極光"
  },
  Skill_4408_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。臨時暴擊率 +[Arg2]%。本場戰鬥內，汀克特的「打擊」基礎傷害提升 [Arg3]%。使隨機 5 張手牌直到回合結束時算力消耗變為 0。"
  },
  Skill_4408_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。臨時暴擊率和暴擊傷害 +[Arg2]%。本場戰鬥內，汀克特的「打擊」基礎傷害提高 [Arg3]%。使隨機 5 張手牌直到回合結束時算力消耗變為 0。"
  },
  Skill_4408_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4409_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4410_AwakerSkillBackgroundStory = {
    Text = "是神之國，是烏托邦，是永恆樂土，亦是法洛思的故鄉。\n那座偉大的城國已然失落，除了淤泥、濕地、生滿苔蘚的巨大石塊外，什麼也沒留下。"
  },
  Skill_4410_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。驅散自身<VulnerabilityIconKeywords:易傷>狀態。從抽牌堆中選擇至多 3 張牌置入手中。"
  },
  Skill_4410_EffectNameList = {Text = "護盾"},
  Skill_4410_Name = {
    Text = "遺失的久遠之城"
  },
  Skill_4410_OverLimitUtlSkillDesc = {
    Text = "手牌上限+2，回合結束時，選擇 1 張手牌獲得保留並使其算力消耗 -1，持續 3 回合。獲得 <Block:[Block:Arg1]> 點護盾。驅散自身<VulnerabilityIconKeywords:易傷>狀態。從抽牌堆中選擇至多 3 張牌置入手中。"
  },
  Skill_4410_PropertyNameList = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4411_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>，該<WeaknessIconKeywords:虛弱>減少50%傷害。"
  },
  Skill_4412_AwakerSkillBackgroundStory = {
    Text = "因狂氣充盈而「百折不撓」的皮鞭，永遠光鮮亮麗，無論何時何地，都能施以你渴求的疼痛。"
  },
  Skill_4412_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次並獲得 50% 傷害的臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_4412_EffectNameList_0 = {Text = "傷害"},
  Skill_4412_Name = {
    Text = "狂氣使役之鞭"
  },
  Skill_4412_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4413_AwakerSkillBackgroundStory = {
    Text = "應徵入伍後，她在前線奮戰，即便傷殘也不願退下戰場，只因為她真心相信「更好的世界」即將到來。\n但謊言終將破滅。這次她舉起武器，為的不再是那個虛假的承諾，而是自己心中的正確。"
  },
  Skill_4413_Desc_0 = {
    Text = "艾爾瓦獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Arg2] 點<AlertIconKeywords:戒備>。艾爾瓦指令卡造成的傷害隨當前護盾提高，每點護盾提高 2。"
  },
  Skill_4413_Desc_15 = {
    Text = "艾爾瓦獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Arg2] 點<AlertIconKeywords:戒備>。艾爾瓦指令卡造成的傷害隨當前護盾提高，每點護盾提高 2，每回合首次造成傷害時，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4413_EffectNameList = {
    Text = "狂氣,戒備"
  },
  Skill_4413_Name = {
    Text = "戰地卓識"
  },
  Skill_4413_PropertyNameList = {
    Text = "$GrowValue1,防禦力*GrowValue2"
  },
  Skill_4415_Desc = {
    Text = "自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷> 1 回合。獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_4415_EffectNameList = {Text = "護盾"},
  Skill_4415_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_4416_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4417_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 護盾，獲得 [Arg2] <PowerIconKeywords:力量>。"
  },
  Skill_4418_Desc = {
    Text = "戰鬥結束後仍會保存在牌庫中。"
  },
  Skill_4418_Name = {
    Text = "黏糊糊的蠟油"
  },
  Skill_4419_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4420_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_4421_AwakerSkillBackgroundStory = {
    Text = "她在凸月之下跳舞。\n裙裾卷在手臂上，像一朵雲似的不斷旋轉。\n在她之下，永無窮盡流動著的大湖逐漸與天空融為一體。\n跳吧。跳吧。黑暗中的聲音說道。\n喚醒那位沉睡的大人，然後踐行那千年的諾言吧。"
  },
  Skill_4421_Desc_0 = {
    Text = "珈倫獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：珈倫打出卡牌後，回復 <Heal:[Heal:Arg2]> 點生命，獲得 <Energy:[Energy:Arg3]> 點狂氣。打出<DerivativeCardKeywords_42:「奇妙料理」>後,對所有敵人施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4421_Desc_15 = {
    Text = "珈倫獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：珈倫打出卡牌後，回復 <Heal:[Heal:Arg2]> 點生命，獲得 <Energy:[Energy:Arg3]> 點狂氣。回合結束時若保留了珈倫的指令卡，觸發 2 次回復生命和獲得狂氣效果。打出<DerivativeCardKeywords_42:「奇妙料理」>後,對所有敵人施加 [Poison:Arg4] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4421_EffectNameList = {
    Text = "狂氣,回復,中毒"
  },
  Skill_4421_PropertyNameList = {
    Text = "$GrowValue1,體質*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4422_AwakerSkillBackgroundStory = {
    Text = "「街頭打鬥可沒那麼多講究，當然是什麼趁手用什麼了。」"
  },
  Skill_4422_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。詹金獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4422_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4422_Name = {Text = "打擊"},
  Skill_4422_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4423_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4424_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獻祭自身。不受瘋狂影響。"
  },
  Skill_4424_Name = {Text = "獻祭"},
  Skill_4425_Desc = {
    Text = "自身死亡，分裂為兩個生命與自身相當的「Ⅱ型融蝕體」。"
  },
  Skill_4426_Desc = {
    Text = "黑暗、狹窄、不斷崩塌、出口和怪物都在那裡，無處可逃。"
  },
  Skill_4427_AwakerSkillBackgroundStory = {
    Text = "無論是掃帚還是武器，她都能使得十分優雅。"
  },
  Skill_4427_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4427_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。珈倫獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4427_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4427_Name = {Text = "打擊"},
  Skill_4427_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_44284_Desc = {
    Text = "召喚 5 個「胎動·努比亞幼崽」，隱匿自身，無法受到攻擊，所有敵人死亡後隱匿解除。"
  },
  Skill_44285_Desc = {
    Text = "施加 [Arg1] 回合<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>。封印 2 名喚醒體，造成 [Arg2] 點<IntoxicationIconKeywords:中毒>，使卡組中 2 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_44286_Desc = {
    Text = "「豐穰母樹」吸收了周圍的生機……提高最大生命，且所有技能均得到強化！"
  },
  Skill_4428_AwakerSkillBackgroundStory = {
    Text = "此人乃是虛偽的聖女，其言行舉止無一遵守聖女的本分。\n但那強硬的外表下，究竟掩藏著怎樣的真實呢——或許為自身的命運毅然舉起旗幟，也是聖女品格的一種。"
  },
  Skill_4428_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg6]> 點護盾和 [Arg3] 點算力，下回合開始時，受到最大生命 [Arg5]% 的<SacrificeKeyWord:獻祭>。<RippleKeywords:餘波>：<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg4]。"
  },
  Skill_4428_Desc_0 = {
    Text = "獲得總計(最大生命 <Block:[Block:Arg1]%> + <Block:[Block:Arg2]> )點護盾和 [Arg3]  點算力。下回合開始時，受到最大生命 [Arg5]% 的<SacrificeKeyWord:獻祭>。<RippleKeywords:餘波>：<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg4] 。"
  },
  Skill_4428_EffectNameList = {
    Text = "護盾,觸腕傷害"
  },
  Skill_4428_Name = {
    Text = "聖女作成"
  },
  Skill_4428_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4429_AwakerSkillBackgroundStory = {
    Text = "尼尼微是泰旖絲漫長生命中微不足道的一站，但在殿前得贈的衣裙，確實曾是她的最愛之物。"
  },
  Skill_4429_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4429_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4429_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。泰旖絲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4429_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。泰旖絲獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4429_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4429_EffectNameList_3 = {
    Text = "傷害,狂氣"
  },
  Skill_4429_Name = {Text = "打擊"},
  Skill_4429_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4429_PropertyNameList_3 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4430_Desc = {
    Text = "將 3 張「哭喊」置入手中，<VulnerabilityIconKeywords:易傷>對方 1 回合，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4430_Name = {
    Text = "灼燃蠟滴之欲"
  },
  Skill_4431_Desc = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_80:「窒息」>置入對方手牌。"
  },
  Skill_4431_Name = {
    Text = "溺斃之怨"
  },
  Skill_4432_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次。獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4433_Desc = {
    Text = "選擇一名喚醒體，獲得 70 狂氣。"
  },
  Skill_4433_Name = {
    Text = "遺影迴響"
  },
  Skill_4434_AwakerSkillBackgroundStory = {
    Text = "她戰鬥的目的從來不是傷害，而是保護。"
  },
  Skill_4434_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4434_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。艾爾瓦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4434_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4434_Name = {Text = "防禦"},
  Skill_4434_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4435_Desc = {
    Text = "將 2 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入對方抽牌堆，全體獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4436_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4437_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並獲得 [Arg5] 點護盾，本回合每抽 1 張牌，額外再獲得 [Arg4] 點護盾。"
  },
  Skill_4437_Name = {
    Text = "隱匿突襲"
  },
  Skill_4438_AwakerSkillBackgroundStory = {
    Text = "指令：防禦。阻擋。"
  },
  Skill_4438_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4438_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，莉莉每有 1% 死亡抵抗，基礎護盾提高 0.25%。莉莉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4438_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4438_Name = {Text = "防禦"},
  Skill_4438_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層的<MadnessIconKeywords:瘋狂>。"
  },
  Skill_4440_Desc = {
    Text = "獲得[Arg1] 點<PowerIconKeywords:力量>，吞噬敵人，跳過其下回合抽牌並造成無法抵抗的封印，但將維度裂隙的卡牌加入手中。"
  },
  Skill_4440_Name = {
    Text = "現世撕裂"
  },
  Skill_44411_Desc = {
    Text = "召喚 7 個「孳乳·努比亞幼崽」，隱匿自身，無法受到攻擊，所有敵人死亡後隱匿解除。"
  },
  Skill_44411_Name = {
    Text = "萬千子嗣之母"
  },
  Skill_44412_Desc = {
    Text = "施加 [Arg1] 回合<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷>、<FragileIconKeywords:脆弱>。封印所有喚醒體 1 回合，造成 [Arg2] 點<IntoxicationIconKeywords:中毒>，使卡組中 3 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_4441_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4442_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4443_AwakerSkillBackgroundStory = {
    Text = "她曾經從巔峰高高墜下，往日的榮耀化作今朝的恥辱。\n被驅逐出掌政官夫人的庭院後，希洛淪為無數希洛奴隸中的平凡無奇的一員，任憑斯巴達獄卒蹂躪。在那樣的絕境中，她卻從未陷入懊喪與萎靡。\n在她的胸腔中熊熊燃燒的，唯有綿延不息的仇恨。\n脖頸的尖刺鎖鏈被無情撕碎，束縛其中的力量得以釋放，真實的面貌即將展露。\n從今往後，請日日洗淨頸項，靜待我的復仇吧。"
  },
  Skill_4443_Desc = {
    Text = "【<DevouredIconKeywords:吞噬>：抽 [Arg1] 張「打擊」，臨時手牌上限 +2，使希洛的「打擊」基礎傷害在本場戰鬥中提高 [Arg3]%。】驅散自身<WeaknessIconKeywords:虛弱>和非永久<PowerIconKeywords:力量>降低狀態，在本回合中「打擊」造成的最終傷害提高 [Arg2]%，希洛造成的傷害提高 [Arg4]%。"
  },
  Skill_4443_EffectNameList = {
    Text = "打擊傷害提高"
  },
  Skill_4443_Name = {
    Text = "絕境求生"
  },
  Skill_4443_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：抽 [Arg1] 張「打擊」，臨時手牌上限 +2，使希洛的「打擊」基礎傷害在本場戰鬥中提高 [Arg3]%。】驅散自身<WeaknessIconKeywords:虛弱>和非永久<PowerIconKeywords:力量>降低狀態，在本回合中「打擊」造成的最終傷害提高 [Arg2]%，希洛造成的傷害提高 [Arg4]%。臨時手牌上限 +2，並將 2 張「不規則形態」置入手中，希洛暴擊傷害 +[Arg5]%。"
  },
  Skill_4444_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，召喚三隻潘狄婭的奴隸。"
  },
  Skill_4444_Name = {
    Text = "蜜糖色悲慘幻象"
  },
  Skill_44452_Desc = {
    Text = "回復 [Arg1]% 點生命([Arg2])並獲得等量的護盾，生命越低，該效果越高，最多回復 20% 生命。"
  },
  Skill_44452_Name = {
    Text = "亞蘭禱言"
  },
  Skill_44453_Desc = {
    Text = "獲得一張「神聖子嗣」：選擇手中 1 張非衍生指令卡，獲得其算力為 0 的原始複製，附加<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_44453_Name = {
    Text = "神聖子嗣"
  },
  Skill_44454_Desc = {
    Text = "使一名喚醒體獲得 100 點狂氣，並解除其封印狀態。"
  },
  Skill_44454_Name = {
    Text = "奔湧樹汁"
  },
  Skill_4445_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層<ParcloseIconKeywords:屏障>，前進。"
  },
  Skill_44462_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_44462_Name = {
    Text = "狂亂之咬"
  },
  Skill_44463_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44472_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，剩餘生命越低，護盾與狂氣效果越高。"
  },
  Skill_44472_Name = {
    Text = "主教的奉獻"
  },
  Skill_4447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4447_Name = {
    Text = "割喉揮砍"
  },
  Skill_44486_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，所有喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣，剩餘生命越低，護盾與狂氣效果越高。"
  },
  Skill_44486_Name = {
    Text = "主教的奉獻"
  },
  Skill_4448_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_4448_Name = {
    Text = "顱骨猛擊"
  },
  Skill_4449_Desc = {
    Text = "將 2 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入抽牌堆。"
  },
  Skill_4449_Name = {Text = "蠟油"},
  Skill_4450_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>洗入抽牌堆。"
  },
  Skill_4451_Desc = {
    Text = "向狂氣最高喚醒體施加 1 層臨時封印，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_4452_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4452_Name = {
    Text = "殘次品的怨念"
  },
  Skill_4453_Desc = {
    Text = "獲得<Block:[Block:Arg1]> 點護盾，自身獲得 [Arg2] 層「蠟質鎧甲」：每層使受到的傷害降低 [Arg3]，每次被暴擊後減少 1 層。"
  },
  Skill_4453_Name = {
    Text = "蠟像登場"
  },
  Skill_4454_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次和施加等量傷害的<BleedingIconKeywords:出血>，受到 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4454_Name = {
    Text = "斬首重創"
  },
  Skill_4455_AwakerSkillBackgroundStory = {
    Text = "她現在知曉了，那些筆挺的制服和嶄新的兵器下的真相。\n所謂的幫助，不過是壓迫的偽裝；所謂的征服，不過是侵略的旗號。\n她高舉武器，光明之星的五角由正義、公正、守護、解放和真實點亮，將不公的陰影徹底驅散。"
  },
  Skill_4455_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。"
  },
  Skill_4455_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量 +1 的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。"
  },
  Skill_4455_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量 +1 的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。艾爾瓦獲得 50％ 臨時暴擊率和暴擊傷害。"
  },
  Skill_4455_EffectNameList = {Text = "護盾"},
  Skill_4455_Name = {
    Text = "無止境的正義"
  },
  Skill_4455_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。將 1 張附加消耗的「臨戰體勢」與「心眼利刃」置入手中。本場戰鬥的暴擊傷害 +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量 +1 的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。將 1 張附加消耗的「臨戰體勢」與「心眼利刃」置入手中。本場戰鬥的暴擊傷害 +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。棄掉手牌中所有的狀態卡和症狀卡，並抽取等同於棄掉數量 +1 的卡牌。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。將 1 張附加消耗的「臨戰體勢」與「心眼利刃」置入手中。艾爾瓦獲得 50％ 臨時暴擊率和暴擊傷害，本場戰鬥的暴擊傷害 +25%。"
  },
  Skill_4455_PropertyNameList = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。基礎攻擊 10 次，直到回合結束前，玩家每擁有 1 張手牌，攻擊次數就減少 1，最低為 3。"
  },
  Skill_44573_Desc = {
    Text = "這張卡的卡面會發光！"
  },
  Skill_44574_Desc = {
    Text = "這張卡的卡面會發光！"
  },
  Skill_44574_Name = {
    Text = "變化效果"
  },
  Skill_4457_AwakerSkillBackgroundStory = {
    Text = "不需要懼怕肆虐的風雨，她將會予以你們守護。"
  },
  Skill_4457_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4457_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。希萊斯特獲得 <Energy:[Energy:Arg2]> 點狂氣。激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4457_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4457_Name = {Text = "防禦"},
  Skill_4457_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4458_AwakerSkillBackgroundStory = {
    Text = "他驕傲地展示身上的傷痕，深的來自戰場上的廝殺，淺的來自平日的訓練與切磋。\n這些是英雄的證明，是他的驕傲。\n但不要詢問他頸部的疤痕，這是他力量的開始，也是他恥辱的源泉。"
  },
  Skill_4458_Desc_0 = {
    Text = "戈利亞獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，戈利亞造成傷害時，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3] 點 <TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_4458_Desc_15 = {
    Text = "戈利亞獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，戈利亞造成傷害時，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3] 點 <TentacleInjurieIconKeywords:觸腕傷害>。戈利亞在怒濤姿態下額外享受 [Arg4]％ 力量加成。"
  },
  Skill_4458_EffectNameList = {
    Text = "狂氣,力量,觸腕傷害"
  },
  Skill_4458_Name = {
    Text = "復仇預行"
  },
  Skill_4458_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張<DerivativeCardKeywords_3:「驚厥」>洗入對方抽牌堆，"
  },
  Skill_4459_Name = {Text = "驚厥"},
  Skill_4460_AwakerSkillBackgroundStory = {
    Text = "父神降臨在他的夢中，對他降下指引：\n\n「當天空被日月平分之時，獨自前往森林，朝東邊行進五百又五百步。黑暗中的溫暖處，埋著我最後的骨。\n\n拿去吧，我的代行者，但需要牢記。血肉的需血肉償還，生命的需生命填補。」\n\n他掘出了篆刻了神秘符文的石板，向它們獻上自己的骨血，為那些受苦的換取一絲希望。"
  },
  Skill_4460_Desc_0 = {
    Text = "<WeaknessIconKeywords:虛弱>所有敵人 1 回合。<EmbryoFusionIconKeywords:胚胎融合> +[Arg1]。積攢 <Heal:[Heal:Arg2]> 點猩紅熔爐回復量。"
  },
  Skill_4460_Desc_2 = {
    Text = "<WeaknessIconKeywords:虛弱>所有敵人 1 回合。<EmbryoFusionIconKeywords:胚胎融合> +[Arg1]。積攢 <Heal:[Heal:Arg2]> 點猩紅熔爐回復量，戰鬥中每經過 1 回合，額外積攢 [Arg3] 點。"
  },
  Skill_4460_EffectNameList_0 = {
    Text = "胚胎融合,猩紅熔爐積攢量"
  },
  Skill_4460_EffectNameList_2 = {
    Text = "胚胎融合,猩紅熔爐積攢量,猩紅熔爐增長"
  },
  Skill_4460_PropertyNameList_0 = {
    Text = "$GrowValue1,體質*GrowValue2"
  },
  Skill_4460_PropertyNameList_2 = {
    Text = "$GrowValue1,體質*GrowValue2,體質*GrowValue3"
  },
  Skill_44612_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_4461_Desc = {
    Text = "全體獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4461_Name = {
    Text = "全體力量"
  },
  Skill_4462_Desc = {
    Text = "將 2 張<DerivativeCardKeywords_9:「蹣跚」>分別洗入對方抽牌堆和棄牌堆，"
  },
  Skill_4462_Name = {Text = "明滅"},
  Skill_4463_AwakerSkillBackgroundStory = {
    Text = "融蝕現象平等地對待所有人，喚醒體也不例外。為了拖延消亡的時間，朵爾將所有知識、意識和情緒都存入了外置器官中。\n「聰明的大腦」——為朵爾量身打造的讚美之詞。"
  },
  Skill_4463_Desc_0 = {
    Text = "朵爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：朵爾造成回復時，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4463_Desc_15 = {
    Text = "朵爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：朵爾造成回復時，獲得 <Block:[Block:Arg2]> 點護盾，朵爾的「打擊」和「防禦」也能觸發獲得護盾效果。"
  },
  Skill_4463_EffectNameList = {
    Text = "狂氣,防禦"
  },
  Skill_4463_Name = {
    Text = "靈肉兩分"
  },
  Skill_4463_PropertyNameList = {
    Text = "$GrowValue1,防禦力*GrowValue2"
  },
  Skill_4464_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4465_Desc = {
    Text = "每回合獲得[Arg1]點<PowerIconKeywords:力量>。"
  },
  Skill_4465_Name = {
    Text = "遠古的呼喚"
  },
  Skill_4466_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44674_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並施加 2 回合的「撕裂」、「創傷」、<BlindingKeywords:致盲> 。"
  },
  Skill_44674_Name = {
    Text = "「癲狂撕咬」"
  },
  Skill_44675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，玩家每打出 1 張牌都會切換該意圖的追加效果。追加效果會在重擊、回復、弱化之間按序切換。"
  },
  Skill_44676_Desc = {
    Text = "獲得 [Arg2] 點<PowerIconKeywords:力量>和 [Arg1] 點護盾，將 3 張隨機症狀洗入抽牌堆。"
  },
  Skill_44676_Name = {
    Text = "「鏡中判決」"
  },
  Skill_44677_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44677_Name = {Text = "爪擊"},
  Skill_44678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張「狂放」加入手牌堆。"
  },
  Skill_44678_Name = {Text = "懲戒"},
  Skill_44679_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>。玩家每打出 1 張牌都會切換該意圖的追加效果。追加效果會在反擊、淨化、植入之間按序切換。"
  },
  Skill_44679_Name = {
    Text = "「鏡中審視」"
  },
  Skill_4467_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4467_Name = {Text = "漁叉"},
  Skill_44680_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合「撕裂」與「創傷」。"
  },
  Skill_44680_Name = {Text = "罰罪"},
  Skill_44681_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_44682_Desc = {
    Text = "獲得 [Arg1] 點臨時力量， 所有敵人獲得 [Arg2] 點臨時力量，將其銷毀。戰鬥結束後仍會保存在牌庫中。"
  },
  Skill_44683_Desc = {
    Text = "獲得 1 層瘋狂，將 1 張「狂放」加入手牌堆。狂放：算力消耗 1。戰鬥結束後仍會保存在牌庫中，打出後所有單位均獲得臨時力量並將其銷毀。"
  },
  Skill_44683_Name = {
    Text = "以牙還牙"
  },
  Skill_4468_Desc = {
    Text = "召喚「膿皰」。"
  },
  Skill_44691_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44692_Desc = {
    Text = "前排獲得 3 層<ParcloseIconKeywords:屏障>，獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_44692_Name = {
    Text = "隱於黑暗"
  },
  Skill_44693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，造成「撕裂」1 回合。撕裂：打出「防禦」時，在抽牌堆頂部添加  1 張<DerivativeCardKeywords_23:「傷口」>。"
  },
  Skill_44694_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_44694_Name = {
    Text = "犯罪預告"
  },
  Skill_44695_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合「創傷」。創傷：打出「打擊」後，在抽牌堆頂部添加 1  張<DerivativeCardKeywords_23:「傷口」>。"
  },
  Skill_44696_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張 <DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆。"
  },
  Skill_44696_Name = {Text = "拐賣"},
  Skill_44697_Name = {Text = "揚塵"},
  Skill_44698_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44698_Name = {Text = "清掃"},
  Skill_44699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_44699_Name = {Text = "敲竹槓"},
  Skill_4469_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4469_Name = {
    Text = "綿長恨怨"
  },
  Skill_4470_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4470_Name = {
    Text = "布朗出動！"
  },
  Skill_4471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44722_AwakerSkillBackgroundStory = {
    Text = "父神萬千神言中的一句，講述了父神的原初之血對生命的守護。"
  },
  Skill_44722_BattleDesc = {
    Text = "以血施救。造成傷害後，失去 10% 當前生命([Arg1])，積攢與失去生命等量的猩紅熔爐回復量(<Heal:[Heal:Arg2]>)。"
  },
  Skill_44722_Desc = {
    Text = "以血施救。造成傷害後，失去 10% 當前生命，積攢與失去生命等量的猩紅熔爐回復量。"
  },
  Skill_44722_Name = {Text = "奉獻"},
  Skill_44723_AwakerSkillBackgroundStory = {
    Text = "父神萬千神言中的一句，講述了父神原初的軀體對生命的滋養。"
  },
  Skill_44723_BattleDesc = {
    Text = "以苦消苦。消耗所有猩紅熔爐剩餘的回復量，每消耗 1 點就使傷害提高 3 點，若為首領戰，則改為每消耗 1 點傷害提高 9 點。每消耗 1％ 最大生命的猩紅熔爐就提高 [Arg5]% 最終傷害。總計造成 <Damage:[Damage:Arg4]> 點傷害。"
  },
  Skill_44723_Desc = {
    Text = "以苦消苦。消耗所有猩紅熔爐剩餘的回復量，每消耗 1 點就使傷害提高 3 點，若為首領戰，則改為每消耗 1 點傷害提高 9 點。每消耗 1％ 最大生命的猩紅熔爐就提高 [Arg5]% 最終傷害。"
  },
  Skill_44723_EffectNameList = {
    Text = "傷害,傷害加成"
  },
  Skill_44723_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2%"
  },
  Skill_44723_tempBattleDesc_1 = {
    Text = "以苦消苦。消耗所有猩紅熔爐剩餘的回復量，每消耗 1 點就使傷害提高 3 點，若為首領戰，則改為每消耗 1 點傷害提高 9 點。每消耗 1％ 最大生命的猩紅熔爐就提高 [Arg5]% 最終傷害。總計造成 <Damage:[Damage:Arg4]> 點傷害。"
  },
  Skill_4472_Desc = {
    Text = "封印四個喚醒體的狂氣爆發 1 回合。"
  },
  Skill_44735_Desc = {
    Text = "塔薇復活效果測試"
  },
  Skill_44735_Name = {
    Text = "塔薇效果測試"
  },
  Skill_4473_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加 [Arg3] 層寄生。"
  },
  Skill_4473_Name = {
    Text = "附骨侵蝕"
  },
  Skill_4474_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4475_Desc = {
    Text = "施加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_44765_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，解除自身負面狀態。打出卡牌後，追加效果將切換為植入。"
  },
  Skill_44765_Name = {
    Text = "「鏡中審視」淨化"
  },
  Skill_44766_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，額外獲得 [Arg3] 點臨時反擊。打出卡牌後，追加效果將切換為淨化。"
  },
  Skill_44766_Name = {
    Text = "「鏡中審視」反擊"
  },
  Skill_44767_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，洗入 2 張「狂放」到抽牌堆。打出卡牌後，追加效果將切換為反擊。"
  },
  Skill_44767_Name = {
    Text = "「鏡中審視」植入"
  },
  Skill_4476_AwakerSkillBackgroundStory = {
    Text = "他們先是叫她聖女，將她束縛在了桅杆之上；他們後來喊她廢物，並將她扔進牢籠。\n他們似乎忘記了，她無法決定生死，只能指引航船的方向。"
  },
  Skill_4476_Desc_0 = {
    Text = "希萊斯特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，希萊斯特造成的生命回復提高 15%，回復生命時，臨時<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_4476_Desc_15 = {
    Text = "希萊斯特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，希萊斯特造成的生命回復提高 15%，回復生命時，臨時<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。觸發「不死的極樂鳥」復活時，臨時<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]，首領戰效果翻倍。"
  },
  Skill_4476_EffectNameList = {
    Text = "狂氣,臨時觸腕傷害"
  },
  Skill_4476_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 2 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4477_Name = {
    Text = "雙重啃咬"
  },
  Skill_44786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 2 回合的 <WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。打出卡牌後，追加效果將切換為重擊。"
  },
  Skill_44787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回復 [Arg3] 點生命。打出卡牌後，追加效果將切換為弱化。"
  },
  Skill_44787_Name = {
    Text = "「失序撕咬」回復"
  },
  Skill_44788_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，打出卡牌後，追加效果將切換為回復。"
  },
  Skill_44788_Name = {
    Text = "「失序撕咬」重擊"
  },
  Skill_4478_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4479_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_44817_AwakerSkillBackgroundStory = {
    Text = "「我是造主的代行者，我借祂的力量，以祂的名義，要為你們消除一切苦楚。」"
  },
  Skill_44817_Desc = {
    Text = "獲得 [Arg1] 層臨時<ParcloseIconKeywords:屏障>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg2]。"
  },
  Skill_44817_Name = {
    Text = "護以仁愛"
  },
  Skill_4481_AwakerSkillBackgroundStory = {
    Text = "他們是美，是歡愉，是柔軟的磚牆。\n年輕的肉體以不可思議的姿勢扭曲著，層層疊疊，直達天際。\n噓——別哭，保持微笑。像無數個夏夜裡你曾對女王做的那樣。"
  },
  Skill_4481_Desc_0 = {
    Text = "旺達獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 5 層<DreamGuide:夢引>。回合開始後獲得 1 層<DreamGuide:夢引>。每當獲得<DreamGuide:夢引>使其達到 5 或 10 層時，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4481_Desc_15 = {
    Text = "旺達獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 5 層<DreamGuide:夢引>。回合開始後獲得 1 層<DreamGuide:夢引>。每當獲得<DreamGuide:夢引>使其達到 5 或 10 層時，獲得 <Block:[Block:Arg2]> 點護盾。旺達釋放狂氣爆發後自身下 2 張指令卡額外生效 1 次。"
  },
  Skill_4481_EffectNameList = {
    Text = "狂氣,護盾"
  },
  Skill_4481_Name = {
    Text = "活屍夢囈"
  },
  Skill_4481_PropertyNameList = {
    Text = "$GrowValue1,防禦力*GrowValue2"
  },
  Skill_4482_Desc = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入抽牌堆。"
  },
  Skill_4482_Name = {Text = "蠟油"},
  Skill_4483_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4484_Desc = {
    Text = "召喚守護娃娃。"
  },
  Skill_4484_Name = {
    Text = "召喚和強化"
  },
  Skill_4486_Desc = {
    Text = "獲得 [Arg1] 護盾，護盾消失時，剩餘護盾轉化為2倍生命值。"
  },
  Skill_4486_Name = {
    Text = "不滅之花"
  },
  Skill_4487_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4488_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4489_Desc = {
    Text = "全體獲得 <Block:[Block:Arg1]> 點護盾，自身獲得[Arg2] 點<PowerIconKeywords:力量>."
  },
  Skill_4490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4491_Desc = {
    Text = "犧牲自身祈求融蝕的賜福。"
  },
  Skill_4491_Name = {Text = "犧牲"},
  Skill_4492_AwakerSkillBackgroundStory = {
    Text = "晚風會帶來故土的鐘鳴，星光會照亮歸鄉的道路。\n過往的職責，成為了她的執念。\n她願以生命為薪柴，點燃永恆的燈火。"
  },
  Skill_4492_Desc_0 = {
    Text = "法洛思獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕。每打出法洛思的 1 張牌，抽 [Arg2] 張牌，觸發所有敵人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果， 每回合最多生效 3 次。"
  },
  Skill_4492_Desc_15 = {
    Text = "法洛思獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕。每打出法洛思的 1 張牌，抽 [Arg2] 張牌，觸發所有敵人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果，並使本回合觸腕造成傷害時，額外造成等同於傷害 5％ 的<IntoxicationIconKeywords:中毒>，每回合最多生效 3 次。"
  },
  Skill_4492_EffectNameList = {Text = "狂氣"},
  Skill_4492_Name = {
    Text = "湮塞的執念"
  },
  Skill_4493_Desc = {
    Text = "某種奇特的精神體驗。"
  },
  Skill_4493_Name = {Text = "幻覺"},
  Skill_4494_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，棄掉對方所有的手牌。"
  },
  Skill_4494_Name = {Text = "離散"},
  Skill_4495_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4496_BattleDesc = {
    Text = "失去 [Arg1] 點生命，抽 2 張牌。無法出售。"
  },
  Skill_4496_Desc = {
    Text = "失去 10% 最大生命，抽 2 張牌。無法出售。"
  },
  Skill_4496_Name = {
    Text = "症狀：癲癇"
  },
  Skill_4497_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4498_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4499_Desc = {
    Text = "將所有喚醒體各 1 張算力消耗為 0 的「打擊」置入手中，並附加<DepleteIconKeywords:消耗>。將手中所有喚醒體的卡牌更換為算力消耗為 0 的「打擊」，直到回合結束。"
  },
  Skill_4499_Name = {
    Text = "美麗瞬間"
  },
  Skill_45007_AwakerSkillBackgroundStory = {
    Text = "父神萬千神言中的一句，講述了父神原初的軀體對生命的滋養。"
  },
  Skill_45007_BattleDesc = {
    Text = "以信濟世。消耗所有猩紅熔爐剩餘的回復量，獲得 150% 消耗量的護盾([Arg1])，該護盾不受護盾加成和減益影響，但無視護盾上限。"
  },
  Skill_45007_Desc = {
    Text = "以信濟世。消耗所有猩紅熔爐剩餘的回復量，獲得 150% 消耗量的護盾，該護盾不受護盾加成和減益影響，但無視護盾上限。"
  },
  Skill_45007_Name = {Text = "救贖"},
  Skill_45019_Desc_1 = {
    Text = "使一名目標獲得 <DisarmKeywords:麻痺>。"
  },
  Skill_45019_Name_1 = {Text = "麻痺"},
  Skill_4501_AwakerSkillBackgroundStory = {
    Text = "為了保護易碎的外置器官，朵爾在玻璃缸中集成了「力場發生器」。\n她向學生們解釋時，仍保持著面無表情，大家也分不清朵爾教授是不是又在開玩笑了。\n真是可怕的幽默感。"
  },
  Skill_4501_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4501_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。朵爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4501_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4501_Name = {Text = "防禦"},
  Skill_4501_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4502_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4502_Name = {
    Text = "石質分解"
  },
  Skill_4504_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45051_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_4505_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，將 3 張<DerivativeCardKeywords_35:「巨人之畏」>洗入抽牌堆。"
  },
  Skill_4505_Name = {
    Text = "海淵之力"
  },
  Skill_45063_Desc_1 = {
    Text = "給予全體敵方負面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45063_Name_1 = {
    Text = "華麗光景"
  },
  Skill_4506_AwakerSkillBackgroundStory = {
    Text = "那是無垠的原質之海，傳說星球上一切有機物都由此誕生。\n灰色的汪洋中漂浮著無限的面龐，飽含歡笑或是悲憫。"
  },
  Skill_4506_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg4] 倍力量加成。創造 1 張自定義的「千面幻象」將其置入手牌，若當前非超維回合且<DimensionalSpaceIconKeywords:超維空間>沒有「千面幻象」，將其複製置入<DimensionalSpaceIconKeywords:超維空間>並視為觸發了 1 次<SingularityKeywords3:維度穿梭>，否則將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  Skill_4506_EffectNameList = {Text = "傷害"},
  Skill_4506_Name = {
    Text = "原質之海"
  },
  Skill_4506_OverLimitUtlSkillDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg4] 倍力量加成。創造 1 張自定義的「千面幻象」將其置入手牌，若當前非超維回合且<DimensionalSpaceIconKeywords:超維空間>沒有「千面幻象」，將其複製置入<DimensionalSpaceIconKeywords:超維空間>並視為觸發了 1 次<SingularityKeywords3:維度穿梭>，否則將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中。額外將「千面幻象」的 [Arg2] 張複製置入手中，「斷頸一擊」本場戰鬥中基礎傷害提高 [Arg3]%。"
  },
  Skill_4506_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_45079_Desc_1 = {
    Text = "使一名目標獲得 <PVPSeriousInjuryKeywords:重創>。"
  },
  Skill_45079_Name_1 = {Text = "重傷"},
  Skill_4507_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4508_Desc = {
    Text = "回合開始時隨機變形為抽牌堆中一張指令卡的複製，其算力消耗固定為 3，回合結束時變回。無法打出。"
  },
  Skill_4508_Name = {
    Text = "症狀：譫妄"
  },
  Skill_4509_AwakerSkillBackgroundStory = {
    Text = "除了最古老的混沌外，沒有東西能讓海水與火焰融合交織。\n你大可去找，去印證。去追尋沙漠尖塔，去尋找海底迷城，去攀越無垠群山。\n我向你保證，沒有東西比蘿坦更加古老。"
  },
  Skill_4509_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4509_BattleDesc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。視為「打擊」。"
  },
  Skill_4509_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4509_Desc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。視為「打擊」。"
  },
  Skill_4509_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_4509_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4510_Desc = {
    Text = "抽到時，本回合內所有喚醒體獲取狂氣降低 50%。"
  },
  Skill_4510_Name = {Text = "空虛"},
  Skill_4511_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_4512_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_4512_Name = {Text = "深潛"},
  Skill_4514_Desc = {
    Text = "對敵人施加 1 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4515_AwakerSkillBackgroundStory = {
    Text = "只此一擊。\n奪去淩虐者的性命、奪去背叛者的性命、奪去妄為者的性命、奪去侵略者的性命。\n不必多言，以這蘊含著濃黑恨意的利刺，宣誓她的選擇與覺悟。"
  },
  Skill_4515_BattleDesc = {
    Text = "視為「打擊」。造成 <Damage:[Damage:Arg1]> 點傷害。手牌中每有 1 張其他「打擊」，使基礎傷害提高 [Arg3]%，額外享受 1 倍力量加成。棄掉所有「打擊」。"
  },
  Skill_4515_Desc = {
    Text = "視為「打擊」。造成 <Damage:[Damage:Arg1]> 點傷害。手牌中每有 1 張其他「打擊」，使基礎傷害提高 [Arg3]%，額外享受 1 倍力量加成。棄掉所有「打擊」。"
  },
  Skill_4515_EffectNameList = {Text = "傷害"},
  Skill_4515_Name = {
    Text = "破鏈一擊"
  },
  Skill_4515_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4516_AwakerSkillBackgroundStory = {
    Text = "「恥辱……恥辱……」\n女孩瑟縮在廚房角落，尚來不及擦乾嘴角的一抹血漬。\n她承受著來自至親的指控，卻無力辯解。\n自那天起，女孩便丟失了自己的姓名。\n她消失在世人跟前，就像一滴水匯入不斷奔湧的流言之河。"
  },
  Skill_4516_Desc_0 = {
    Text = "雷婭獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：雷婭打出卡牌後， <EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。"
  },
  Skill_4516_Desc_15 = {
    Text = "雷婭獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：雷婭打出卡牌後， <EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]，並使下次狂氣爆發得到強化：獲得等同於 [Arg3]％ 永久力量的臨時力量，最多堆疊 [Arg4] 次。"
  },
  Skill_4516_EffectNameList = {
    Text = "狂氣,胚胎融合"
  },
  Skill_4517_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4517_Name = {
    Text = "獵矛突刺"
  },
  Skill_4518_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4518_Name = {
    Text = "創口撕扯"
  },
  Skill_4519_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並封印所有喚醒體 1 回合。"
  },
  Skill_4519_Name = {
    Text = "「為▼▼降臨掃除▼▼」"
  },
  Skill_4520_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害減少一層，回合結束失去全部。"
  },
  Skill_4520_Name = {Text = "祈禱"},
  Skill_4521_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，手牌堆所有卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」，並將 1 張「漸漸石化」加入對方手牌。"
  },
  Skill_4521_Name = {
    Text = "真·萬古之眸"
  },
  Skill_4522_Desc = {
    Text = "獲得 [Arg2] 點護盾和 [Arg1] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_4522_Name = {
    Text = "承自異端之血"
  },
  Skill_4523_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4524_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45251_Desc_1 = {
    Text = "還原全體友方的生命至上回合開始時，但還原後生命最多不超過 [Arg1]% ，<ReduceEffectKeywords:強效降低> [Arg2]，狂氣減半。<PVPRaidKeywords:突襲>：還原後生命最多不超過 [Arg3]%。"
  },
  Skill_45252_Desc_1 = {
    Text = "將 [Arg1] 張其他隨機「鑰令」洗入抽牌堆，在抽到手牌以前你不知道它是什麼。"
  },
  Skill_45252_Name_1 = {
    Text = "奧瑞塔的寶藏"
  },
  Skill_45252_UnknownName = {
    Text = "奧瑞塔的寶藏"
  },
  Skill_45253_Desc_1 = {
    Text = "選擇一名敵方造成<PVPEmptinessKeywords:空虛>，將目標的 [Arg1] 狂氣轉換為等量<DelayKeywords:延遲 2>：狂氣。"
  },
  Skill_45254_Name_1 = {
    Text = "春天的獻詩"
  },
  Skill_45254_UnknownName = {
    Text = "春天的獻詩"
  },
  Skill_45255_Desc_1 = {
    Text = "造成合計 <Damage:[Damage:Arg1]> 傷害，平均分配給所有敵方。"
  },
  Skill_45256_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」使本回合下一次「打擊」改為隨機目標並且額外攻擊 [Arg1] 名隨機目標。"
  },
  Skill_45256_Name_1 = {Text = "鏡中人"},
  Skill_45257_Desc_1 = {
    Text = "<ReinforceKeywords:加固>一名友方，抽 [Arg1] 張牌。"
  },
  Skill_45257_Name_1 = {
    Text = "最後的誓言"
  },
  Skill_45257_UnknownName = {
    Text = "最後的誓言"
  },
  Skill_45258_BattleDesc_1 = {
    Text = "耗盡所有算力，每消耗算力和每擁有<PVPCapKeywords:算力上限>造成 [Arg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>傷害。"
  },
  Skill_45258_Desc_1 = {
    Text = "耗盡所有算力，每消耗算力和每擁有<PVPCapKeywords:算力上限>造成 [Arg1] <PVPBleedingKeywords:出血>。"
  },
  Skill_45258_Name_1 = {
    Text = "咆哮的血與沙"
  },
  Skill_45258_UnknownName = {
    Text = "咆哮的血與沙"
  },
  Skill_45259_Desc_1 = {
    Text = "選擇一名友方獲得 [Arg1] 層 <PVPProtectiveKeywords:屏障>，<PVPPowerIconKeywords:力量> +[Arg2]。"
  },
  Skill_45259_Name_1 = {
    Text = "玫瑰的勝利"
  },
  Skill_45259_UnknownName = {
    Text = "玫瑰的勝利"
  },
  Skill_4525_AwakerSkillBackgroundStory = {
    Text = "「啪！啪！啪！」揮起小皮鞭，抽打不服從命令的奴隸~"
  },
  Skill_4525_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4525_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並獲得 50% 傷害的臨時<RetaliateIconKeywords:反擊>。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4525_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。潘狄婭獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4525_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並獲得 50% 傷害的臨時<RetaliateIconKeywords:反擊>。潘狄婭獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4525_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4525_Name = {Text = "打擊"},
  Skill_4525_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_45260_Desc_1 = {
    Text = "選擇一名友方，使其獲得 <Block:[Block:Arg1]> 護盾並將其當前生命和護盾分攤給其他友方。若目標為唯一生存友方則改為獲得<StrengthenKeywords:強化>和<ReinforceKeywords:加固>。"
  },
  Skill_45260_Name_1 = {
    Text = "腐爛盛筵"
  },
  Skill_45260_UnknownName = {
    Text = "腐爛盛筵"
  },
  Skill_45261_Desc_1 = {
    Text = "迫使目標棄掉所有手牌，若沒有棄掉任何手牌，獲得 [Arg2] 算力並抽 [Arg2] 張牌。"
  },
  Skill_45262_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使自身獲得<TauntKeywords:嘲諷>與 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_45263_Desc_1 = {
    Text = "抽 [Arg1] 張牌。"
  },
  Skill_45263_Name_1 = {
    Text = "仲夏之夢"
  },
  Skill_45263_UnknownName = {
    Text = "仲夏之夢"
  },
  Skill_45264_Desc_1 = {
    Text = "<DelayKeywords:延遲>：<StrengthenKeywords:強化>和<ReinforceKeywords:加固>自身並獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45264_Name_1 = {
    Text = "神跡降臨"
  },
  Skill_45264_UnknownName = {
    Text = "神跡降臨"
  },
  Skill_45265_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」可以選擇目標，「打擊」前<PVPRepelKeywords:擊退>目標所有可驅散的正面狀態到其身後喚醒體。"
  },
  Skill_45265_Name_1 = {
    Text = "深海的呼喚"
  },
  Skill_45266_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時以及「打擊」後、將手牌中裝備者的非衍生「技能」按順序變成裝備者的其他「技能」。<PVPFlowerKeywords:往昔的花與詩>"
  },
  Skill_45266_Name_1 = {
    Text = "往昔的花與詩"
  },
  Skill_45267_Desc_1 = {
    Text = "使手中所有「技能」獲得<PrepareKeywords:預備> ，基礎算力消耗為 [Arg2] 的「技能」獲得<PrepareKeywords:預備> [Arg3]。"
  },
  Skill_45267_Name_1 = {
    Text = "黑天鵝的舞步"
  },
  Skill_45267_UnknownName = {
    Text = "黑天鵝的舞步"
  },
  Skill_45268_Desc_1 = {
    Text = "為任意目標裝備隨機的「命輪」，若使用次數未耗盡則將此牌洗入對方抽牌堆"
  },
  Skill_45268_Name_1 = {
    Text = "一聲槍響"
  },
  Skill_45268_UnknownName = {
    Text = "一聲槍響"
  },
  Skill_45269_Name_1 = {
    Text = "蝕骨的擁抱"
  },
  Skill_45269_UnknownName = {
    Text = "蝕骨的擁抱"
  },
  Skill_4526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_45270_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：回合結束時，變為打出的最後 1 張「技能」牌，使其算力消耗 -2，打出後將一張「灰霧真容」洗入抽牌堆。"
  },
  Skill_45270_Name_1 = {
    Text = "灰霧真容"
  },
  Skill_45270_UnknownName = {
    Text = "灰霧真容"
  },
  Skill_45271_Desc_1 = {
    Text = "造成 [Arg1] 傷害，<DisarmKeywords:麻痺>，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45271_Name_1 = {
    Text = "短暫的永恆"
  },
  Skill_45271_UnknownName = {
    Text = "短暫的永恆"
  },
  Skill_45272_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPEntanglementKeywords:纏繞>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45273_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每受到一次主動傷害使其他友方獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45273_Name_1 = {
    Text = "伊薩拉烏的目光"
  },
  Skill_45275_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 +[Arg1]，「狂氣爆發」後使自身獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45275_Name_1 = {
    Text = "灼熱的吻別"
  },
  Skill_4527_Desc = {
    Text = "獲得 1 層<MadnessIconKeywords:瘋狂>。使用症狀卡時，潘迪婭的狀態會在“焦躁”和“縱欲”之間變化。焦躁：攻擊次數+1，<PowerIconKeywords:力量>減少。縱欲：攻擊次數-1，<PowerIconKeywords:力量>增加"
  },
  Skill_4527_Name = {Text = "覺醒"},
  Skill_4528_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使扭曲死體狂宴傷害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_4528_Name = {
    Text = "紛亂切割"
  },
  Skill_4529_AwakerSkillBackgroundStory = {
    Text = "苦難是殘酷的、是無情的。\n\n在消融一切的黑色死亡面前，哪怕耗盡生命，他也要保護世間的所有。"
  },
  Skill_4529_Desc_0 = {
    Text = "選擇：<B02AFKeyWord2:奉獻>、<B02AFKeyWord3:超度>或<B02AFKeyWord4:救贖>。獲得 <Energy:[Energy:Arg5]> 點狂氣。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，本場戰鬥中每積攢 1 點猩紅熔爐的回復量，就使傷害提高 [Float:Arg2] 點。"
  },
  Skill_4529_Desc_2 = {
    Text = "選擇：<B02AFKeyWord2:奉獻>、<B02AFKeyWord3:超度>或<B02AFKeyWord4:救贖>。獲得 <Energy:[Energy:Arg5]> 點狂氣。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，本場戰鬥中每積攢 1 點猩紅熔爐的回復量，就使傷害提高 [Float:Arg2] 點。本次傷害暴擊率提高 [Arg4]%。"
  },
  Skill_4529_EffectNameList = {
    Text = "傷害,傷害加成,狂氣"
  },
  Skill_4529_Name = {
    Text = "應消之苦"
  },
  Skill_4529_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4530_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4530_Name = {Text = "刺擊"},
  Skill_4531_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，抽牌堆頂的 [Arg3] 張卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4531_Name = {
    Text = "凝滯詛咒"
  },
  Skill_4532_Desc = {
    Text = "完成「神降儀式」，翻倍自身的生命和最大生命。造成 [Arg1] 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷> 狀態，將 3 張「執念」洗入牌庫。"
  },
  Skill_4532_Name = {
    Text = "神降儀式·降臨"
  },
  Skill_4533_AwakerSkillBackgroundStory = {
    Text = "詹金也不是一開始就能理解布朗的。\n這樣可不行，她想，這樣布朗可沒法吸引街上那些自命不凡的老爺們的注意，好讓她從他們的口袋裡搞來今天的晚餐。\n於是她借著提燈開始訓練，並在多日的嘗試後終於——\n「布朗，出動！」\n「吱！」"
  },
  Skill_4533_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中，「布朗出動！」造成的傷害提高 [Arg2] 點。<TransitionIconKeywords:躍遷>：該技能額外享受 1 倍力量加成。"
  },
  Skill_4533_Desc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中，「布朗出動！」造成的傷害提高 [Arg2] 點，「鼠群衝擊」造成的傷害提高 [Arg3] 點。<TransitionIconKeywords:躍遷>：該技能額外享受 1 倍力量加成。"
  },
  Skill_4533_EffectNameList_0 = {
    Text = "傷害,傷害成長"
  },
  Skill_4533_EffectNameList_1 = {
    Text = "傷害,傷害成長,鼠群衝擊傷害成長"
  },
  Skill_4533_Name = {
    Text = "布朗出動！"
  },
  Skill_4533_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4533_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4534_Desc = {
    Text = "召喚守護娃娃，自身獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4534_Name = {
    Text = "召喚和強化"
  },
  Skill_4535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_45367_Desc_1 = {
    Text = "<DelayKeywords:延遲>：給予一名友方 [Arg1] 張「打擊」。"
  },
  Skill_45367_Name_1 = {
    Text = "不朽的葬儀"
  },
  Skill_45367_UnknownName = {
    Text = "不朽的葬儀"
  },
  Skill_4536_Desc = {
    Text = "你已經無法使用維度穿行逃脫了！……雖然你仍然能將此卡消耗，但這毫無意義。"
  },
  Skill_4536_Name = {
    Text = "被注視……！"
  },
  Skill_4537_Desc = {
    Text = "消耗手牌中所有的症狀卡。每消耗 1 張就抽 1 張牌。僅能使用 1 次了……"
  },
  Skill_4537_Name = {
    Text = "維度穿行"
  },
  Skill_45383_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 臨時<PowerColourKeywords:力量降低>。"
  },
  Skill_45383_Name_1 = {
    Text = "臨時力量降低"
  },
  Skill_45384_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 臨時<PowerColourKeywords:力量>。"
  },
  Skill_45384_Name_1 = {
    Text = "臨時力量"
  },
  Skill_4538_Desc = {
    Text = "消耗手牌中所有的症狀卡。每消耗 1 張就抽 1 張牌。還能使用 2 次。"
  },
  Skill_4538_Name = {
    Text = "維度穿行"
  },
  Skill_4539_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得<Flaw:破綻>：當回合內必定被暴擊。"
  },
  Skill_4539_Name = {
    Text = "鼠群衝擊"
  },
  Skill_4540_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害失去一層，失去全部時眩暈。"
  },
  Skill_4540_Name = {Text = "祈禱"},
  Skill_4541_AwakerSkillBackgroundStory = {
    Text = "午夜時分，靜謐的流水，順著病弱少女的指引，輕盈地送上充滿柔情的衝擊。"
  },
  Skill_4541_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4541_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。寧菲亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4541_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4541_Name = {Text = "打擊"},
  Skill_4541_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4542_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，後撤。"
  },
  Skill_4543_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4544_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45453_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，目標每有 1 張手牌對其額外造成 1 次傷害，獲得一半傷害的護盾，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45454_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命，給予其 <Energy:[Energy:Arg2]> 狂氣，對自身使用效果減半。"
  },
  Skill_45454_Name_1 = {
    Text = "豐穰之儀"
  },
  Skill_45455_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>目標，並造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45455_Name_1 = {
    Text = "無形遷移"
  },
  Skill_45456_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，回復等同於傷害的生命，對受<PVPSeriousInjuryKeywords:重創>影響的目標使用時，回復翻倍生命。"
  },
  Skill_45456_Name_1 = {
    Text = "腺體重構"
  },
  Skill_45457_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，並使其<PVPMethysisKeywords:中毒>翻倍。"
  },
  Skill_45457_Name_1 = {
    Text = "自我的葬儀"
  },
  Skill_45458_Desc_1 = {
    Text = "使任意其他目標獲得<PVPVulnerabilityIconKeywords:易傷>，<DelayKeywords:延遲>：獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45459_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45459_Name_1 = {Text = "打擊"},
  Skill_4545_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！這燈只是為了照明罷了。」"
  },
  Skill_4545_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4545_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 2 張牌，若不是詹金的卡牌則將其丟棄。"
  },
  Skill_4545_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。詹金獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4545_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。詹金獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 2 張牌，若不是詹金的卡牌則將其丟棄。"
  },
  Skill_4545_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4545_Name = {Text = "防禦"},
  Skill_4545_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_45460_Desc_1 = {
    Text = "對任意其他目標造成 <Damage:[Damage:Arg1]> 傷害，使其獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45460_Name_1 = {
    Text = "無上的喜悅"
  },
  Skill_45461_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45462_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>敵方造成 <Damage:[Damage:Arg1]> 傷害。獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45462_Name_1 = {Text = "宣戰"},
  Skill_45463_Desc_1 = {
    Text = "獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>，<PVPVulnerabilityIconKeywords:易傷>自身。"
  },
  Skill_45463_Name_1 = {
    Text = "恨意翻湧"
  },
  Skill_45464_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害並施加等量<PVPSacrificeKeyWords:獻祭>。"
  },
  Skill_45464_Name_1 = {
    Text = "螺湮典儀"
  },
  Skill_45465_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾，觸發全體敵方的<PVPSacrificeKeyWords:獻祭>。"
  },
  Skill_45465_Name_1 = {
    Text = "死淵輪回"
  },
  Skill_45466_Desc_1 = {
    Text = "全體敵方扣除 <Energy:[Energy:Arg1]> 狂氣，<PVPCapKeywords:算力上限> - [Arg2]。"
  },
  Skill_45466_Name_1 = {
    Text = "虛妄隆寵"
  },
  Skill_45467_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>，<PVPMethysisKeywords:中毒>，<PVPBleedingKeywords:出血>。"
  },
  Skill_45468_Desc_1 = {
    Text = "獲得 [Arg1] 臨時<PVPRetaliateIconKeywords:反擊>，本回合下 [Arg3] 次「技能」後獲得 1 層<EnergyStorageKeywords:蓄力>，回合結束前所有沒用完的次數每次轉換為回復 <Heal:[Heal:Arg4]> 生命。"
  },
  Skill_45468_Name_1 = {
    Text = "承自異端之血"
  },
  Skill_45469_Desc_1 = {
    Text = "<DelayKeywords:延遲>：<Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_4546_AwakerSkillBackgroundStory = {
    Text = "詹金也不是一開始就能理解布朗的。\n這樣可不行，她想，這樣布朗可沒法吸引街上那些自命不凡的老爺們的注意，好讓她從他們的口袋裡搞來今天的晚餐。\n於是她借著提燈開始訓練，並在多日的嘗試後終於——\n「布朗，出動！」\n「吱！」"
  },
  Skill_4546_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中，「布朗出動！」造成的傷害提高 [Arg2] 點。躍遷：改為對所有敵人造成傷害，但打出後<DepleteIconKeywords:消耗>。"
  },
  Skill_4546_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。在本場戰鬥中，「布朗出動！」造成的傷害提高 [Arg2] 點，「鼠群衝擊」造成的傷害提高 [Arg3] 點。躍遷：改為對所有敵人造成傷害，但打出後<DepleteIconKeywords:消耗>。"
  },
  Skill_4546_EffectNameList_0 = {
    Text = "傷害,傷害成長"
  },
  Skill_4546_EffectNameList_1 = {
    Text = "傷害,傷害成長,鼠群衝擊傷害成長"
  },
  Skill_4546_Name = {
    Text = "布朗出動！"
  },
  Skill_4546_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4546_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_45470_Desc_1 = {
    Text = "選擇一種<PVPMouseKeywords:老鼠牌><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>，將其 [Arg1] 張複製置入手中。"
  },
  Skill_45470_Name_1 = {
    Text = "街頭夥伴"
  },
  Skill_45471_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45471_Name_1 = {Text = "打擊"},
  Skill_45472_Desc_1 = {
    Text = "驅散一名友方的負面狀態，或驅散一名敵方的正面狀態。"
  },
  Skill_45473_Desc_1 = {
    Text = "回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45474_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45474_Name_1 = {
    Text = "深度治療"
  },
  Skill_45475_Desc_1 = {
    Text = "使全體敵方本回合受到主動傷害後獲得傷害 [Arg1]％的<PVPSacrificeKeyWords:獻祭>，臨時<StrongEffectKeywords:強效> +[Arg2]。"
  },
  Skill_45475_Name_1 = {
    Text = "虛妄王女"
  },
  Skill_45476_Desc_1 = {
    Text = "對一名敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。"
  },
  Skill_45476_Name_1 = {
    Text = "隱秘的荊棘"
  },
  Skill_45477_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPWeaknessKeywords:虛弱>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45477_Name_1 = {
    Text = "失落的藝術"
  },
  Skill_45478_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45478_Name_1 = {Text = "打擊"},
  Skill_45479_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，損失一半傷害量的生命。"
  },
  Skill_45479_Name_1 = {
    Text = "鏈錘重創"
  },
  Skill_4547_Desc = {
    Text = "其他喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4547_Name = {
    Text = "高維催化"
  },
  Skill_45480_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，損失一半傷害量的生命。"
  },
  Skill_45480_Name_1 = {
    Text = "旋動鏈條"
  },
  Skill_45481_Desc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 傷害，優先攻擊擁有<TauntKeywords:嘲諷>的敵方目標，損失一半傷害量的生命。"
  },
  Skill_45481_Name_1 = {
    Text = "不定之鏈"
  },
  Skill_45482_Desc_1 = {
    Text = "竊取任意其他目標 <Energy:[Energy:Arg2]> 狂氣，使目標與自身獲得<PVPEmptinessKeywords:空虛>，<StrongEffectKeywords:強效> +[Arg1]，使「蜜糖色悲慘幻象」獲得<StrongEffectKeywords:強效> +[Arg3]。"
  },
  Skill_45482_Name_1 = {
    Text = "蜜糖色悲慘幻象"
  },
  Skill_45483_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45483_Name_1 = {Text = "打擊"},
  Skill_45484_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45484_Name_1 = {Text = "打擊"},
  Skill_45485_Desc_1 = {
    Text = "驅散一名敵方的正面狀態，對其造成 <Damage:[Damage:Arg1]> 傷害，[Arg2]<PVPSlowKeywords:遲緩>。"
  },
  Skill_45485_Name_1 = {
    Text = "星彩極光"
  },
  Skill_45486_Desc_1 = {
    Text = "<Block:[Block:Arg1]> 護盾。"
  },
  Skill_45486_Name_1 = {
    Text = "硬化石膚"
  },
  Skill_45487_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPWeaknessKeywords:虛弱>。"
  },
  Skill_45487_Name_1 = {
    Text = "虛弱凝視"
  },
  Skill_45488_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_45488_Name_1 = {
    Text = "螺湮守護"
  },
  Skill_45489_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_45489_Name_1 = {
    Text = "王權之威"
  },
  Skill_4548_Desc = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4548_Name = {
    Text = "高維狂氣"
  },
  Skill_45490_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_45490_Name_1 = {
    Text = "萬古震懾"
  },
  Skill_45491_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，<PVPSlowKeywords:遲緩>。"
  },
  Skill_45492_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，若擊殺目標則對其他敵方造成等量<PVPBleedingKeywords:出血>。"
  },
  Skill_45492_Name_1 = {
    Text = "湮滅預言"
  },
  Skill_45493_Desc_1 = {
    Text = "驅散一名敵方的正面狀態，對其造成 <Damage:[Damage:Arg1]> 傷害，<PVPCapKeywords:算力上限> - [Arg2]。"
  },
  Skill_45494_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>並<PVPSeriousInjuryKeywords:重創>一名敵方，損失 <Damage:[Arg1]> 生命。"
  },
  Skill_45494_Name_1 = {
    Text = "海月賜苦"
  },
  Skill_45495_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，損失 <Damage:[Arg3]> 生命。"
  },
  Skill_45495_Name_1 = {
    Text = "雙向觸刺"
  },
  Skill_45496_Desc_1 = {
    Text = "驅散全體敵方的正面狀態，對他們造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45496_Name_1 = {
    Text = "向深淵祝禱"
  },
  Skill_45497_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45497_Name_1 = {Text = "打擊"},
  Skill_45498_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45498_Name_1 = {Text = "打擊"},
  Skill_45499_BattleDesc_1 = {
    Text = "回覆 <Heal:[Heal:Arg4]> 生命，每損失 [Arg2] 生命就使治療 + [Arg3]。"
  },
  Skill_45499_Desc_1 = {
    Text = "回復 <Heal:[Heal:Arg1]> 生命，每損失 [Arg2] 生命就使治療 + [Arg3]。"
  },
  Skill_45499_Name_1 = {
    Text = "重塑療癒"
  },
  Skill_4549_Desc = {
    Text = "對所有敵人施加 2 層<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4549_Name = {
    Text = "高維虛弱"
  },
  Skill_45500_BattleDesc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg4]> 傷害，每損失 [Arg2] 生命就使傷害 + [Arg3]，同時視為「打擊」。"
  },
  Skill_45500_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，每損失 [Arg2] 生命就使傷害 + [Arg3]，同時視為「打擊」。"
  },
  Skill_45500_Name_1 = {
    Text = "報償打擊"
  },
  Skill_45501_Desc_1 = {
    Text = "對<HPAndShieldMin:生命與護盾最低>的敵方造成 <Damage:[Damage:Arg1]> 傷害，若擊殺敵方則給予其他友方 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45501_Name_1 = {
    Text = "原質之海"
  },
  Skill_45502_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，<PVPVulnerabilityIconKeywords:易傷>自身，下回合之前，每當被主動攻擊，就獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45502_Name_1 = {
    Text = "疼痛轉化"
  },
  Skill_45503_Desc_1 = {
    Text = "使任意其他目標獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>，偷取目標 <Energy:[Energy:Arg2]> 狂氣並造成<PVPEmptinessKeywords:空虛>。"
  },
  Skill_45503_Name_1 = {
    Text = "無盡的空虛"
  },
  Skill_45504_BattleDesc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg4]> 傷害，每缺少 [Arg2] 生命就使傷害 + [Arg3]。"
  },
  Skill_45504_Desc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 傷害，每缺少 [Arg2] 生命就使傷害 + [Arg3]。"
  },
  Skill_45504_Name_1 = {
    Text = "縛身鎖鏈"
  },
  Skill_45505_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，回復一半傷害的生命。"
  },
  Skill_45505_Name_1 = {
    Text = "海淵之力"
  },
  Skill_45506_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>一名友方並回複目標 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45506_Name_1 = {
    Text = "理性，真理與現實"
  },
  Skill_4550_Desc = {
    Text = "對所有敵人施加 2 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4550_Name = {
    Text = "高維易傷"
  },
  Skill_45510_Desc_1 = {
    Text = "選擇：給予全體友方 <Energy:[Energy:Arg1]> 狂氣，或給予全體友方 <Block:[Block:Arg2]> 護盾。"
  },
  Skill_45510_Name_1 = {
    Text = "特殊製劑"
  },
  Skill_45511_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45511_Name_1 = {Text = "打擊"},
  Skill_45512_BattleDesc_1 = {
    Text = "造成合計 <Damage:[Damage:Arg4]> 傷害，耗盡所有算力，每消耗 [Arg2] 算力就使傷害 + [Arg3]，平均分配給所有敵人，每個敵方受到 <Damage:[Damage:Arg5]> 傷害。"
  },
  Skill_45512_Desc_1 = {
    Text = "造成合計 <Damage:[Damage:Arg1]> 傷害，耗盡所有算力，每消耗 [Arg2] 算力就使傷害 + [Arg3]，平均分配給所有敵人。"
  },
  Skill_45513_Desc_1 = {
    Text = "獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45513_Name_1 = {Text = "戰意"},
  Skill_45514_Desc_1 = {
    Text = "本回合若打出「打擊」，則「打擊」+ [Arg1]% 傷害<PVPPenetrateKeywords:貫穿>；否則回合結束 +[Arg2] <PVPProtectiveKeywords:屏障>。"
  },
  Skill_45514_Name_1 = {
    Text = "星獸餘威"
  },
  Skill_45515_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45515_Name_1 = {
    Text = "污穢風暴"
  },
  Skill_45516_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> <PVPCardLockKeywords:卡牌封鎖>。"
  },
  Skill_45516_Name_1 = {
    Text = "維度追獵"
  },
  Skill_45517_Desc_1 = {
    Text = "棄掉所有其他喚醒體的手牌，將等量 + [Arg1] 的隨機<PVPMouseKeywords:老鼠牌><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>置入手中，<PVPPowerIconKeywords:力量> + [Arg2] 。"
  },
  Skill_45517_Name_1 = {
    Text = "霧都街童"
  },
  Skill_45518_Desc_1 = {
    Text = "將 [Arg1] 張<PVPDerivativeCardKeywords_11:「不平等交換」>置入手中。"
  },
  Skill_45518_Name_1 = {
    Text = "遺失的久遠之城"
  },
  Skill_45519_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45519_Name_1 = {Text = "打擊"},
  Skill_4551_Desc = {
    Text = "獲得 2 點算力。"
  },
  Skill_4551_Name = {
    Text = "高維籌算"
  },
  Skill_45520_Desc_1 = {
    Text = "觸發全體敵方的<PVPMethysisKeywords:中毒>。"
  },
  Skill_45520_Name_1 = {Text = "毒發"},
  Skill_45521_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45522_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45522_Name_1 = {
    Text = "溺毒彌漫"
  },
  Skill_45523_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45523_Name_1 = {
    Text = "黎明氦閃"
  },
  Skill_45524_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>傷害。"
  },
  Skill_45524_Name_1 = {
    Text = "翠星墜落"
  },
  Skill_45525_Desc_1 = {
    Text = "<StrengthenKeywords:強化>，<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45525_Name_1 = {
    Text = "護身綠炎"
  },
  Skill_45526_BattleDesc_1 = {
    Text = "驅散一名敵方的正面狀態並造成 <Damage:[Damage:Arg3]> 傷害，移除自身<PVPProtectiveKeywords:屏障>，每層使傷害 + [Arg2]。"
  },
  Skill_45526_Desc_1 = {
    Text = "驅散一名敵方的正面狀態並造成 <Damage:[Damage:Arg1]> 傷害，移除自身<PVPProtectiveKeywords:屏障>，每層使傷害 + [Arg2]。"
  },
  Skill_45526_Name_1 = {
    Text = "「審判」"
  },
  Skill_45527_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，獲得<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45527_Name_1 = {
    Text = "神聖骨血"
  },
  Skill_45528_BattleDesc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg4]> 傷害，移除自身<PVPProtectiveKeywords:屏障>，每層使傷害 + [Arg3]。"
  },
  Skill_45528_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，移除自身<PVPProtectiveKeywords:屏障>，每層使傷害 + [Arg3]。"
  },
  Skill_45528_Name_1 = {
    Text = "「懲惡」"
  },
  Skill_45529_Desc_1 = {
    Text = "對一名敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45529_Name_1 = {
    Text = "血與沙的讚歌"
  },
  Skill_4552_Desc = {
    Text = "抽 2 張牌。"
  },
  Skill_4552_Name = {
    Text = "高維妙手"
  },
  Skill_45530_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45530_Name_1 = {Text = "打擊"},
  Skill_45531_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45531_Name_1 = {
    Text = "扭曲的死體狂宴"
  },
  Skill_45532_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45532_Name_1 = {Text = "打擊"},
  Skill_45533_Desc_1 = {
    Text = "將之前回合最後打出的 [Arg1] 張「技能」置入手中，將其費用變為 0，若多次觸發該類效果則向前追溯。"
  },
  Skill_45533_Name_1 = {
    Text = "悖論收束"
  },
  Skill_45534_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害和負面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45534_Name_1 = {
    Text = "客官請慢用！"
  },
  Skill_45535_Desc_1 = {
    Text = "獲得 [Arg1] 張<PVPDerivativeCardKeywords_10:「沸血」>。"
  },
  Skill_45536_BattleDesc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg3]> 傷害，每點<PVPCapKeywords:算力上限>增加 [Arg2] 傷害。"
  },
  Skill_45536_Desc_1 = {
    Text = "隨機造成 [Arg1] 次傷害，每點<PVPCapKeywords:算力上限>增加 [Arg2] 傷害。"
  },
  Skill_45536_Name_1 = {Text = "尖嘯"},
  Skill_45537_Desc_1 = {
    Text = "對一名敵方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，"
  },
  Skill_45538_Desc_1 = {
    Text = "為一名友方施加正面<PVPWonderfulEffectKeywords:奇妙效果>，或為一名敵方施加負面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45538_Name_1 = {
    Text = "創意甜品"
  },
  Skill_45539_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命，對自身使用效果減半，施加正面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45539_Name_1 = {
    Text = "滋補燉菜"
  },
  Skill_4553_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，在後排召喚「求告者」。"
  },
  Skill_4553_Name = {
    Text = "分裂打擊"
  },
  Skill_45540_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂氣、為手中所有卡牌恢復 [Arg2] 使用次數。"
  },
  Skill_45540_Name_1 = {
    Text = "食材補充"
  },
  Skill_45541_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 或 <Damage:[Damage:Arg2]> 或 <Damage:[Damage:Arg3]> 傷害，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45541_Name_1 = {
    Text = "肆意豪賭"
  },
  Skill_45542_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，獲得<PVPProtectiveKeywords:屏障>，同時視為「打擊」。"
  },
  Skill_45542_Name_1 = {
    Text = "環行軌跡"
  },
  Skill_45543_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，獲得 [Arg3] <PVPProtectiveKeywords:屏障>。"
  },
  Skill_45543_Name_1 = {
    Text = "死夢之都"
  },
  Skill_45544_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45544_Name_1 = {
    Text = "電磁爆破"
  },
  Skill_45545_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>自身，<DelayKeywords:延遲>：抽 [Arg1] 張牌。"
  },
  Skill_45545_Name_1 = {
    Text = "偉大的犧牲"
  },
  Skill_45546_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>敵方造成 <Damage:[Damage:Arg1]> 傷害，重複 [Arg2] 次，若存在「聖血指引」狀態的目標則優先攻擊。"
  },
  Skill_45546_Name_1 = {
    Text = "連綿的本能"
  },
  Skill_45547_Desc_1 = {
    Text = "本回合內，每當目標被主動攻擊，就回復損失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45547_Name_1 = {
    Text = "聖血指引"
  },
  Skill_45548_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>全體友方，<DelayKeywords:延遲>：回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45548_Name_1 = {
    Text = "不死的極樂鳥"
  },
  Skill_45549_BattleDesc_1 = {
    Text = "對指定敵方造成 <Damage:[Damage:Arg2]> 傷害，每點算力上限增加 [Arg1] 傷害。"
  },
  Skill_45549_Desc_1 = {
    Text = "對指定敵方造成傷害，每點<PVPCapKeywords:算力上限>增加 [Arg1] 傷害。"
  },
  Skill_45549_Name_1 = {
    Text = "逐火飛蟲"
  },
  Skill_4554_Desc = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。"
  },
  Skill_4554_Name = {Text = "陽傘"},
  Skill_45550_Desc_1 = {
    Text = "抽 [Arg1] 張牌。"
  },
  Skill_45550_Name_1 = {
    Text = "湮塞寶藏"
  },
  Skill_45551_Desc_1 = {
    Text = "查看下 [Arg1] 張牌，將 1 張置入手中，其他的牌洗回抽牌堆。"
  },
  Skill_45552_Desc_1 = {
    Text = "<StrengthenKeywords:強化>全體友方並給予<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45552_Name_1 = {
    Text = "整裝待發"
  },
  Skill_45553_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45553_Name_1 = {Text = "打擊"},
  Skill_45554_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得等量護盾。"
  },
  Skill_45554_Name_1 = {
    Text = "七藝，傳承美德"
  },
  Skill_45555_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45556_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，獲得與傷害等量的護盾，獲得<TauntKeywords:嘲諷>。"
  },
  Skill_45556_Name_1 = {
    Text = "防禦射線"
  },
  Skill_45557_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Block:[Block:Arg2]> 護盾，<StrongEffectKeywords:強效> +[Arg3]。"
  },
  Skill_45557_Name_1 = {
    Text = "無盡的雕琢"
  },
  Skill_45558_Desc_1 = {
    Text = "給予全體友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45559_Desc_1 = {
    Text = "給予一名友方 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_45559_Name_1 = {
    Text = "光學防護"
  },
  Skill_4555_Desc = {
    Text = "破除桎梏孵化而出，正在尋找它的下一個目標…"
  },
  Skill_45560_Desc_1 = {
    Text = "對<HPAndShieldMin:生命與護盾最低>敵方造成 <Damage:[Damage:Arg1]> 傷害。每有 1 個死亡喚醒體，就額外造成 1 次傷害。"
  },
  Skill_45560_Name_1 = {
    Text = "踏血而來"
  },
  Skill_45561_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45561_Name_1 = {Text = "打擊"},
  Skill_45562_Desc_1 = {
    Text = "獲得 3 張 <PVPDerivativeCardKeywords_15:「液化虛無」>。"
  },
  Skill_45562_Name_1 = {
    Text = "終點、真理與深淵之門"
  },
  Skill_45563_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，若擊殺任何敵方，將 [Arg2] 張「迴環劍技」置入手中，使其傷害 + [Arg3]。"
  },
  Skill_45563_Name_1 = {
    Text = "廻環劍技"
  },
  Skill_45564_Desc_1 = {
    Text = "<ReinforceKeywords:加固>一名友方，並回復其 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45564_Name_1 = {
    Text = "理想鄉的祝福"
  },
  Skill_45565_BattleDesc_1 = {
    Text = "造成 [Arg3] 次 <Damage:[Damage:Arg1]> 傷害，每有 1 個死亡友方額外造成 1 次傷害。"
  },
  Skill_45565_Desc_1 = {
    Text = "造成 [Arg2] 次 <Damage:[Damage:Arg1]> 傷害，每有 1 個死亡友方額外造成 1 次傷害。"
  },
  Skill_45565_Name_1 = {
    Text = "純白漣漪"
  },
  Skill_45566_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命，並給予<TauntKeywords:嘲諷>。"
  },
  Skill_45566_Name_1 = {
    Text = "彼岸信標"
  },
  Skill_45567_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>，<PVPPenetrateKeywords:貫穿>。紛華篇章：額外觸發 [Arg2] 次。"
  },
  Skill_45567_Name_1 = {
    Text = "死亡詩篇"
  },
  Skill_45568_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>，<PVPPenetrateKeywords:貫穿>。紛華篇章：額外對全體敵方生效 [Arg2] 次。"
  },
  Skill_45568_Name_1 = {
    Text = "靈魂詩篇"
  },
  Skill_45569_Desc_1 = {
    Text = "回覆一名友方 <Heal:[Heal:Arg1]> 生命，<PVPPenetrateKeywords:貫穿>。紛華篇章：驅散目標負面狀態並額外生效 [Arg2] 次。"
  },
  Skill_45569_Name_1 = {
    Text = "生命詩篇"
  },
  Skill_4556_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45570_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45570_Name_1 = {Text = "打擊"},
  Skill_45571_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45571_Name_1 = {Text = "打擊"},
  Skill_45572_Desc_1 = {
    Text = "使全體友方所有<DelayKeywords:延遲>治療立刻生效，隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_45572_Name_1 = {
    Text = "獻媚者之擁"
  },
  Skill_45573_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45573_Name_1 = {Text = "打擊"},
  Skill_45574_Desc_1 = {
    Text = "<StrongEffectKeywords:強效> +[Arg1]，增幅下一個詩篇，使其獲得額外效果。"
  },
  Skill_45574_Name_1 = {
    Text = "紛華篇章"
  },
  Skill_45575_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_45576_Desc_1 = {
    Text = "獲得 [Arg1] 張「打擊」。"
  },
  Skill_45576_Name_1 = {
    Text = "混沌之獸"
  },
  Skill_45577_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：變為對手打出的上一張「技能」，且使其費用 – [Arg1]。"
  },
  Skill_45577_Name_1 = {
    Text = "星彩擬態"
  },
  Skill_45578_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂氣，獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45578_Name_1 = {
    Text = "猛烈生長"
  },
  Skill_45579_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，直到下回合開始，自身被主動攻擊時獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>並對攻擊者造成 [Arg1] 層<PVPSlowKeywords:遲緩>。"
  },
  Skill_45579_Name_1 = {
    Text = "異常引力"
  },
  Skill_4557_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，召喚兩個「都怪你」。"
  },
  Skill_4557_Name = {Text = "呼喚"},
  Skill_45580_Desc_1 = {
    Text = "<PVPProtectiveKeywords:屏障>，抽 [Arg2] 張牌。"
  },
  Skill_45580_Name_1 = {
    Text = "活屍之牆"
  },
  Skill_45582_Desc_1 = {
    Text = "驅散全體友方的負面狀態，獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45582_Name_1 = {
    Text = "復甦之音"
  },
  Skill_45583_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPSlowKeywords:遲緩>。"
  },
  Skill_45584_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>，同時視為「打擊」。"
  },
  Skill_45584_Name_1 = {
    Text = "穿雲引吭"
  },
  Skill_45585_BattleDesc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg4]> 傷害，<PVPSlowKeywords:遲緩>，每擁有 [Arg2] 護盾就使傷害 + [Arg3]。"
  },
  Skill_45585_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPSlowKeywords:遲緩>，每擁有 [Arg2] 護盾就使傷害 + [Arg3]。"
  },
  Skill_45585_Name_1 = {
    Text = "無止境的正義"
  },
  Skill_45586_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_45587_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45587_Name_1 = {
    Text = "魂靈追擊"
  },
  Skill_45588_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易傷>目標並造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45588_Name_1 = {
    Text = "槓桿投機"
  },
  Skill_45589_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPSlowKeywords:遲緩>。"
  },
  Skill_45589_Name_1 = {
    Text = "牌桌把戲"
  },
  Skill_4558_AwakerSkillBackgroundStory = {
    Text = "學生們迴避著與拉蒙娜對視。\n坊間傳言，那只青色的眼睛能夠看穿內心，一切謊言在拉蒙娜眼前都無所遁形。甚至有人說，她取下單片眼鏡之日，就是神明降臨之時。\n「你別聽那些學長瞎猜，戴眼鏡只是為了方便閱讀。」\n「我可不是什麼最新款測謊儀，這種程度的推演，不是很簡單嗎？」"
  },
  Skill_4558_Desc_0 = {
    Text = "使所有敵人臨時降低 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。抽 1 張牌。"
  },
  Skill_4558_Desc_2 = {
    Text = "使所有敵人臨時降低 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>。抽 1 張牌，抽到的卡牌每有 1 點算力消耗，獲得 <Posse:[Arg2]> 點銀鑰能量。"
  },
  Skill_4558_Name = {
    Text = "攻勢推演"
  },
  Skill_4558_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_45590_Desc_1 = {
    Text = "對隨機敵方造成 [Arg2] 次 <Damage:[Damage:Arg1]> 傷害，"
  },
  Skill_45590_Name_1 = {
    Text = "十環出牌！"
  },
  Skill_45591_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg3]> 傷害，將這張牌洗入抽牌堆，使所有「千面重疊」傷害 + [Arg2]。"
  },
  Skill_45591_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，將這張牌洗入抽牌堆，使所有「千面重疊」傷害 + [Arg2]。"
  },
  Skill_45591_Name_1 = {
    Text = "千面重疊"
  },
  Skill_45592_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPRaidKeywords:突襲>：改為造成<Damage:[Damage:Arg3]> 傷害。"
  },
  Skill_45592_Name_1 = {
    Text = "狂戰突襲"
  },
  Skill_45593_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPRaidKeywords:突襲>：改為造成<Damage:[Damage:Arg3]> 傷害。"
  },
  Skill_45593_Name_1 = {
    Text = "非利士式閃擊"
  },
  Skill_45594_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，若擊殺敵方則獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45594_Name_1 = {
    Text = "巨刃重殺"
  },
  Skill_45595_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，對受<PVPSeriousInjuryKeywords:重創>影響的目標造成翻倍傷害。"
  },
  Skill_45595_Name_1 = {
    Text = "淵血迸發"
  },
  Skill_45596_Desc_1 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 傷害，獲得傷害一半的臨時<PVPRetaliateIconKeywords:反擊>，同時視為「打擊」。"
  },
  Skill_45596_Name_1 = {
    Text = "逆鱗反制"
  },
  Skill_45597_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重創>並造成 <Damage:[Damage:Arg1]> 傷害，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_45597_Name_1 = {
    Text = "鱗刺打擊"
  },
  Skill_45598_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45598_Name_1 = {Text = "打擊"},
  Skill_45599_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂氣、給予其他友方 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45599_Name_1 = {
    Text = "負熵演算"
  },
  Skill_4559_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45600_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45600_Name_1 = {Text = "打擊"},
  Skill_45601_Desc_1 = {
    Text = "查看全體敵方的 [Arg1] 張隨機「技能」，將 [Arg2] 張置入手中，使其費用變為 0。"
  },
  Skill_45601_Name_1 = {
    Text = "現實模仿"
  },
  Skill_45602_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<ComaKeywords:昏迷>。"
  },
  Skill_45602_Name_1 = {
    Text = "萬古之眸"
  },
  Skill_45603_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45603_Name_1 = {Text = "打擊"},
  Skill_45604_Desc_1 = {
    Text = "給予一名友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45604_Name_1 = {
    Text = "受賜者的權柄"
  },
  Skill_45605_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_45606_Name_1 = {
    Text = "螺湮的禮物"
  },
  Skill_45607_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，同時視為「打擊」，<PVPPenetrateKeywords:貫穿 2>。"
  },
  Skill_45607_Name_1 = {
    Text = "狂亂撕裂"
  },
  Skill_45608_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45608_Name_1 = {
    Text = "權欲輪舞"
  },
  Skill_45609_Desc_1 = {
    Text = "偷取目標所有可驅散的正面狀態，造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45609_Name_1 = {
    Text = "星之搖籃"
  },
  Skill_4560_BattleDesc = {
    Text = "失去 [Arg1] 點生命，獲得雙倍於該值的護盾。無法出售。"
  },
  Skill_4560_Desc = {
    Text = "失去 5% 最大生命，獲得雙倍於該值的護盾。無法出售。"
  },
  Skill_4560_Name = {
    Text = "症狀：幽閉"
  },
  Skill_45610_BattleDesc_1 = {
    Text = "<TauntKeywords:嘲諷>，獲得 [Arg4] 臨時<PVPRetaliateIconKeywords:反擊>，每有 [Arg2] <PVPProtectiveKeywords:屏障>額外獲得 [Arg3] 臨時<PVPRetaliateIconKeywords:反擊>。"
  },
  Skill_45610_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，獲得 [Arg1] 臨時<PVPRetaliateIconKeywords:反擊>，每有 [Arg2] <PVPProtectiveKeywords:屏障>額外獲得 [Arg3] 臨時<PVPRetaliateIconKeywords:反擊>。"
  },
  Skill_45610_Name_1 = {
    Text = "迷途夢引"
  },
  Skill_45611_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，"
  },
  Skill_45612_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，<Block:[Block:Arg1]> 護盾。"
  },
  Skill_45612_Name_1 = {
    Text = "迷宮陷阱"
  },
  Skill_45613_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，<PVPEntanglementKeywords:纏繞>。"
  },
  Skill_45613_Name_1 = {
    Text = "縛網絞殺"
  },
  Skill_45614_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPEntanglementKeywords:纏繞>。"
  },
  Skill_45614_Name_1 = {
    Text = "蛛絲纏繞"
  },
  Skill_45615_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPEntanglementKeywords:纏繞>。"
  },
  Skill_45615_Name_1 = {
    Text = "蒼白的庇佑"
  },
  Skill_45616_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方造成 <Damage:[Damage:Arg1]> 傷害，<ComaKeywords:昏迷>。"
  },
  Skill_45616_Name_1 = {
    Text = "淤泥上的不滅之花"
  },
  Skill_45617_Desc_1 = {
    Text = "抽 [Arg1] 張牌，若這是一張「命輪」，則使其變為 0 費，否則將其 [Arg2] 張複製置入手中。"
  },
  Skill_45617_Name_1 = {
    Text = "命運工匠"
  },
  Skill_45618_Desc_1 = {
    Text = "給予一名友方 <Block:[Block:Arg1]> 護盾，將其 [Arg2] 張「打擊」置入手中。"
  },
  Skill_45618_Name_1 = {
    Text = "工具套組"
  },
  Skill_45619_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45619_Name_1 = {
    Text = "銹蝕扳手"
  },
  Skill_4561_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45620_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，抽 [Arg1] 張牌。"
  },
  Skill_45620_Name_1 = {
    Text = "小小守護者"
  },
  Skill_45621_Desc_1 = {
    Text = "<PVPWeaknessKeywords:虛弱>，<PVPVulnerabilityIconKeywords:易傷>。"
  },
  Skill_45621_Name_1 = {
    Text = "腐爛瑰香"
  },
  Skill_45622_BattleDesc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg3]> 傷害，棄掉所有手牌並移除所有<EnergyStorageKeywords:蓄力>，每張手牌和每層<EnergyStorageKeywords:蓄力>使傷害 + [Arg2]。"
  },
  Skill_45622_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，棄掉所有手牌並移除所有<EnergyStorageKeywords:蓄力>，每張手牌和每層<EnergyStorageKeywords:蓄力>使傷害 + [Arg2]。"
  },
  Skill_45622_Name_1 = {
    Text = "絕境求生"
  },
  Skill_45623_Desc_1 = {
    Text = "選擇：獲得 [Arg1] 算力，或抽 [Arg2] 張牌。"
  },
  Skill_45623_Name_1 = {
    Text = "天才的遠見"
  },
  Skill_45624_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾，臨時<StrongEffectKeywords:強效> +[Arg2]。"
  },
  Skill_45624_Name_1 = {
    Text = "虛妄繼承者"
  },
  Skill_45625_Desc_1 = {
    Text = "選擇：回復全體友方 <Heal:[Heal:Arg1]> 生命，或對全體敵方造成 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_45625_Name_1 = {
    Text = "人性觀察實驗"
  },
  Skill_45626_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，將一張隨機的<PVPAmazingMagicKeywords:驚人魔術><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>置入手中。"
  },
  Skill_45626_Name_1 = {
    Text = "魔術嘉年華"
  },
  Skill_45627_Desc_1 = {
    Text = "<DelayKeywords:延遲>：回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45627_Name_1 = {
    Text = "渴血狂歡"
  },
  Skill_45629_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂氣、<TauntKeywords:嘲諷>。"
  },
  Skill_45629_Name_1 = {
    Text = "藝術狂熱"
  },
  Skill_4562_Desc = {
    Text = "獲得 [Arg2] 點護盾和狀態「惡意放血」： 每造成一次未被格擋的傷害，附加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_45630_Desc_1 = {
    Text = "將一張隨機的<PVPAmazingMagicKeywords:驚人魔術><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>置入手中。"
  },
  Skill_45630_Name_1 = {
    Text = "魔術師的庫藏"
  },
  Skill_45631_Desc_1 = {
    Text = "棄掉所有手牌，並重新抽取等量張數的牌，若手牌為 0 則額外抽 1 張牌。"
  },
  Skill_45631_Name_1 = {
    Text = "過手洗牌"
  },
  Skill_45632_Desc_1 = {
    Text = "<StrengthenKeywords:強化>並<ReinforceKeywords:加固>一名友方。"
  },
  Skill_45632_Name_1 = {
    Text = "祝福魔術幣"
  },
  Skill_45633_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45633_Name_1 = {Text = "打擊"},
  Skill_45634_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45634_Name_1 = {Text = "打擊"},
  Skill_45635_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，對受<TauntKeywords:嘲諷>影響的目標造成三倍傷害，迫使目標獲得<TauntKeywords:嘲諷>。"
  },
  Skill_45635_Name_1 = {
    Text = "前陣戰術"
  },
  Skill_45636_Desc_1 = {
    Text = "全體友方獲得 [Arg1] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45636_Name_1 = {
    Text = "戰鬥啟示"
  },
  Skill_45637_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，驅散負面狀態。"
  },
  Skill_45637_Name_1 = {
    Text = "騎士熱誠"
  },
  Skill_45638_Desc_1 = {
    Text = "獲得 [Arg1] 算力。"
  },
  Skill_45638_Name_1 = {
    Text = "高效思維"
  },
  Skill_45639_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_45639_Name_1 = {
    Text = "彌薩格利刃"
  },
  Skill_4563_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45640_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：視為本回合內上次打出的「技能」。"
  },
  Skill_45640_Name_1 = {
    Text = "模擬演繹"
  },
  Skill_45641_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，使自身護盾翻倍，同時視為「打擊」。"
  },
  Skill_45641_Name_1 = {
    Text = "正義裁決"
  },
  Skill_45642_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，獲得 [Arg1] 張<PVPDerivativeCardKeywords_1:「心眼打擊」>。"
  },
  Skill_45642_Name_1 = {
    Text = "戰地守護"
  },
  Skill_45643_Desc_1 = {
    Text = "<Block:[Block:Arg1]> 護盾、獲得 [Arg2] 層<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45643_Name_1 = {
    Text = "防禦姿態"
  },
  Skill_45644_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，<ReinforceKeywords:加固>。"
  },
  Skill_45644_Name_1 = {
    Text = "機械壁壘"
  },
  Skill_45645_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_45645_Name_1 = {
    Text = "力場防護"
  },
  Skill_45646_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_45646_Name_1 = {
    Text = "超載電流"
  },
  Skill_45647_Desc_1 = {
    Text = "<DelayKeywords:延遲>：驅散一名友方的負面狀態，並回復這名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45647_Name_1 = {
    Text = "凝血治療"
  },
  Skill_45648_Desc_1 = {
    Text = "回滿算力。"
  },
  Skill_45648_Name_1 = {
    Text = "世界演繹法"
  },
  Skill_45649_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> + [Arg1]，<Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_45649_Name_1 = {
    Text = "歡愉果實"
  },
  Skill_4564_Desc = {
    Text = "施加 [Arg1] 層<BleedingIconKeywords:出血>，降低  [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4564_Name = {
    Text = "侵蝕之視"
  },
  Skill_45650_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重創>全體敵方，並對他們造成 <Damage:[Damage:Arg1]> 傷害，如果目標此前已經受<PVPSeriousInjuryKeywords:重創>影響，則使傷害翻倍。"
  },
  Skill_45650_Name_1 = {
    Text = "喧囂海洋"
  },
  Skill_45651_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得等量傷害的護盾，同時視為「打擊」。"
  },
  Skill_45651_Name_1 = {
    Text = "心眼打擊"
  },
  Skill_4565_Desc = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_23:「傷口」>洗入對方抽牌堆。"
  },
  Skill_4566_Desc = {
    Text = "獻祭自身，自身生命轉為「提燈教牧」的生命。"
  },
  Skill_4566_Name = {Text = "獻祭"},
  Skill_45676_Desc_1 = {
    Text = "全體敵方驅散正面狀態。"
  },
  Skill_45676_Name_1 = {
    Text = "狂言魔術牌"
  },
  Skill_45677_Desc_1 = {
    Text = "驅散全體友方的負面狀態。"
  },
  Skill_45677_Name_1 = {
    Text = "兔子禮帽"
  },
  Skill_45678_Desc_1 = {
    Text = "對<HPAndShieldMin:生命與護盾最低>的敵方造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_45678_Name_1 = {
    Text = "帶電小鼠"
  },
  Skill_45679_Desc_1 = {
    Text = "<PVPResurrectionKeywords:復活>一名友方並回復其 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45679_Name_1 = {
    Text = "反向分體魔術盒"
  },
  Skill_4567_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45680_Desc_1 = {
    Text = "選擇：驅散全體友方的負面狀態 或 驅散全體敵方的正面狀態。"
  },
  Skill_45680_Name_1 = {
    Text = "白鴿手帕"
  },
  Skill_45681_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45682_Desc_1 = {
    Text = "給予全體友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_45682_Name_1 = {
    Text = "心靈感應話筒"
  },
  Skill_45683_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_45684_Desc_1 = {
    Text = "隨機造成 [Arg1] 次 <Damage:[Damage:Arg2]> 傷害，獲得 <Energy:[Energy:Arg3]> 狂氣。"
  },
  Skill_4568_Desc = {
    Text = "擊暈敵人，並清除其<RetaliateIconKeywords:反擊>層數。"
  },
  Skill_4568_Name = {Text = "大石頭"},
  Skill_45692_Desc = {
    Text = "隨機凍結抽牌堆中的 1 張指令卡，獲得 1 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_45692_Name = {
    Text = "冰霜尖嘯"
  },
  Skill_4569_Desc = {
    Text = "回合結束時若在手中，自身<FragileIconKeywords:脆弱> 1 回合。使用後<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。無法出售。"
  },
  Skill_4569_Name = {
    Text = "症狀：崩潰"
  },
  Skill_45704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_45708_AwakerSkillBackgroundStory = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  Skill_45708_Desc_0 = {
    Text = "將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提高 25%。"
  },
  Skill_45708_Desc_3 = {
    Text = "將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提高 25%。戈利亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_45708_Name = {Text = "蟄伏"},
  Skill_45709_AwakerSkillBackgroundStory = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  Skill_45709_Desc_0 = {
    Text = "將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，獲得等同於 [Arg1]% 觸腕傷害的臨時<PowerIconKeywords:力量>。"
  },
  Skill_45709_Desc_3 = {
    Text = "將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，獲得等同於 [Arg1]% 觸腕傷害的臨時<PowerIconKeywords:力量>。戈利亞獲得 [Arg2]% 臨時暴擊率。"
  },
  Skill_45709_EffectNameList = {
    Text = "觸腕傷害百分比"
  },
  Skill_45709_Name = {Text = "篡奪"},
  Skill_4570_AwakerSkillBackgroundStory = {
    Text = "閃耀吧，向著故國所在的方向。"
  },
  Skill_4570_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4570_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。使 1 條觸腕攻擊 2 次，但只造成 50％ 的傷害。"
  },
  Skill_4570_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。法洛思獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4570_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。法洛思獲得 <Energy:[Energy:Arg2]> 點狂氣。使 1 條觸腕攻擊 2 次，但只造成 50％ 的傷害。"
  },
  Skill_4570_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4570_Name = {Text = "防禦"},
  Skill_4570_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4571_Desc = {
    Text = "獲得  <Posse:[Arg1]>  點銀鑰能量。獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4571_EffectNameList = {Text = "護盾"},
  Skill_4571_Name = {Text = "鑰能"},
  Skill_4571_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_4572_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，全體獲得<Block:[Block:Arg3]> 點護盾。後撤。"
  },
  Skill_4573_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4574_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4574_Name = {
    Text = "獵矛突刺"
  },
  Skill_4575_AwakerSkillBackgroundStory = {
    Text = "那是由珊瑚構成的遠古廢墟。\n最初，它只是一團蕩漾在海水中的白色光暈。\n後來，它長出高高的臺階，扭曲的浮雕，高聳的石柱……\n砰！當一切戛然而止，失落的藝術終於在海底掀開面紗。\n她必須前往藝術的所在。"
  },
  Skill_4575_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。"
  },
  Skill_4575_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。"
  },
  Skill_4575_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。"
  },
  Skill_4575_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。"
  },
  Skill_4575_EffectNameList_0 = {
    Text = "護盾,傷害"
  },
  Skill_4575_Name = {
    Text = "失落的藝術"
  },
  Skill_4575_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Block:[Block:Arg5]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。本場戰鬥中「失落的藝術」和「基礎打擊」造成的傷害額外享受 100% 護盾加成。"
  },
  Skill_4575_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg5]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg2]> 點傷害，每點護盾使傷害提高 [Arg3] 點，該技能額外享受 [Arg4]% 暴擊率和暴擊傷害加成。在首領戰中，該技能額外造成 1 次傷害。本場戰鬥中「失落的藝術」和「基礎打擊」造成的傷害額外享受 100% 護盾加成。"
  },
  Skill_4575_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4576_AwakerSkillBackgroundStory = {
    Text = "將你的頭顱交予我吧。\n它必會成為我鍾愛的藏品之一，在維度的海洋中浮沉。\n獵顱魔女勾起嘴角，漫不經心地說道。\n「要是運氣夠好的話，還可以和它們一樣隨時陪伴在我身側哦？」"
  },
  Skill_4576_BattleDesc_0 = {
    Text = "對生命最低的敵人造成 <Damage:[Damage:Arg1]> 點傷害，力量在「斷頸一擊」上發揮 5 倍效果。達芙黛爾以任意方式擊殺敵人後，「斷頸一擊」在本次關卡中基礎傷害永久提高 25%（當前 [Arg3] 次）。<TransitionIconKeywords:躍遷>：改為對生命最高敵人造成 <Damage:[Damage:Arg2]> 點傷害。"
  },
  Skill_4576_Desc_0 = {
    Text = "對生命最低的敵人造成 <Damage:[Damage:Arg1]> 點傷害，力量在「斷頸一擊」上發揮 5 倍效果。達芙黛爾以任意方式擊殺敵人後，「斷頸一擊」在本次關卡中基礎傷害永久提高 25%。<TransitionIconKeywords:躍遷>：改為對生命最高敵人造成 <Damage:[Damage:Arg2]> 點傷害。"
  },
  Skill_4576_EffectNameList = {
    Text = "傷害,躍遷傷害"
  },
  Skill_4576_Name = {
    Text = "斷頸一擊"
  },
  Skill_4576_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4577_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg4] 次。賦予  [Arg2] 張卡牌「深潛印記」：打出後敵人獲得臨時<PowerIconKeywords:力量>。"
  },
  Skill_4577_Name = {
    Text = "獵物標記"
  },
  Skill_4578_AwakerSkillBackgroundStory = {
    Text = "這是她擋下的第∞+1次攻擊。"
  },
  Skill_4578_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TimeBeacon:回環>：使所有敵人臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>，抽 1 張牌，環行·拉蒙娜額外獲得 <Energy:[Energy:Arg5]> 點狂氣。"
  },
  Skill_4578_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。環行·拉蒙娜獲得 <Energy:[Energy:Arg2]> 點狂氣。<TimeBeacon:回環>：使所有敵人臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>，抽 1 張牌，環行·拉蒙娜額外獲得 <Energy:[Energy:Arg5]> 點狂氣。"
  },
  Skill_4578_EffectNameList = {
    Text = "護盾,狂氣,臨時力量"
  },
  Skill_4578_Name = {Text = "防禦"},
  Skill_4578_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,防禦力*GrowValue3"
  },
  Skill_4579_AwakerSkillBackgroundStory = {
    Text = "巫師說：「異教徒人數眾多\n我們黎凡特似乎人單力薄。\n尤烏哈希兄弟，吹響你的號角，\n像瘋子一般拼殺吧。」\n戰士答道：「這裡沒有異教徒。\n你們都將被我殺死，逝者不分族群信仰。\n屆時屍身蓋滿山谷，佈滿山頂，\n便是我獻予血與沙的讚歌。」"
  },
  Skill_4579_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本場戰鬥後續釋放的「血與沙的讚歌」傷害提高 [Arg4] 點，力量倍率提高 [Arg3] 倍。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。<PowerIconKeywords:力量>在「血與沙的讚歌」上發揮 [Arg2] 倍效果。尤烏哈希獲得 <Energy:[Energy:Arg5]> 點狂氣。"
  },
  Skill_4579_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本場戰鬥後續釋放的「血與沙的讚歌」傷害提高 [Arg4] 點，力量倍率提高 [Arg3] 倍。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。<PowerIconKeywords:力量>在「血與沙的讚歌」上發揮 [Arg2] 倍效果。獲得等同於尤烏哈希狂氣充能兩倍的狂氣。"
  },
  Skill_4579_EffectNameList = {
    Text = "傷害,傷害提高"
  },
  Skill_4579_Name = {
    Text = "血與沙的讚歌"
  },
  Skill_4579_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：本場戰鬥後續釋放的「血與沙的讚歌」傷害提高 [Arg4] 點，力量倍率提高 [Arg3] 倍。】對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。<PowerIconKeywords:力量>在「血與沙的讚歌」上發揮 [Arg2] 倍效果。尤烏哈希獲得 <Energy:[Energy:Arg5]> 點狂氣。將附加虛無和消耗的「尖嘯吧，血！」填滿手牌。本回合尤烏哈希的傷害次數提高 1。"
  },
  Skill_4579_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4580_Desc = {
    Text = "在自身後召喚一個「提燈」。"
  },
  Skill_4580_Name = {
    Text = "聖禮儀式"
  },
  Skill_4581_AwakerSkillBackgroundStory = {
    Text = "聖堂之下有一個隱蔽空間。\n\n主教跪在石板之前，吟誦創生之初遺留下來的密語。\n\n被時光遺忘的符文發出回應的光芒，應主教的意志現出龐大的虛影，為籠罩在其光輝下的人降下造主的「賜福」。"
  },
  Skill_4581_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>，臨時暴擊率 +[Arg4]%。】獲得 <Block:[Block:Arg2]> 點護盾。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。直到下回合開始，受到攻擊時會將傷害的 [Arg3]% 轉化為猩紅熔爐回復量。"
  },
  Skill_4581_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>，臨時暴擊率 +[Arg4]%。】獲得 <Block:[Block:Arg2]> 點護盾。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。直到下回合開始，受到攻擊時會將傷害的 [Arg3]% 轉化為猩紅熔爐回復量。薩爾瓦多獲得 [Arg5]% 臨時暴擊傷害。"
  },
  Skill_4581_EffectNameList = {
    Text = "臨時力量,護盾,猩紅熔爐轉化量"
  },
  Skill_4581_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>，臨時暴擊率 +[Arg4]%。】獲得 <Block:[Block:Arg2]> 點護盾。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。直到下回合開始，受到攻擊時會將傷害的 [Arg6]% 轉化為猩紅熔爐回覆量。使薩爾瓦多的「基礎打擊」和「應消之苦」額外享受 100% 力量加成。本次探索內猩紅熔爐上限提高最大生命的 2％，至多提高 10％。"
  },
  Skill_4581_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>，臨時暴擊率 +[Arg4]%。】獲得 <Block:[Block:Arg2]> 點護盾。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。直到下回合開始，受到攻擊時會將傷害的 [Arg6]% 轉化為猩紅熔爐回復量。薩爾瓦多獲得 [Arg5]% 臨時暴擊傷害。使薩爾瓦多的「基礎打擊」和「應消之苦」額外享受 100% 力量加成。本次探索內猩紅熔爐上限提高最大生命的 2％，至多提高 10％。"
  },
  Skill_4581_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,$GrowValue3%"
  },
  Skill_4582_BattleDesc = {
    Text = "所有喚醒體獲得 <Energy:[Arg1]> 點狂氣，下回合開始時，受到最大生命值 5%（[Arg3]）的<SacrificeKeyWord:獻祭>。"
  },
  Skill_4582_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Arg1]> 點狂氣，下回合開始時，獲得 5% 最大生命值 <SacrificeKeyWord:獻祭>。"
  },
  Skill_4582_Name = {
    Text = "不朽的葬儀"
  },
  Skill_4584_Desc = {
    Text = "可恥但是有用，帶回鑰匙才是當務之急，不是嗎。"
  },
  Skill_4585_AwakerSkillBackgroundStory = {
    Text = "諾締拉時常會忘記自己周圍有人，這給大家帶來了不少麻煩。\n「對不起，我不是故意的。我現在就貼一張紙條提醒自己——呃，我要寫什麼來著？」\n於是大家在校園一隅給她開闢了一個區域，在那裡她可以隨意加工鋼材。\n沒有誰能想到，她會幹出將高熱光束展開成牆這種事兒。"
  },
  Skill_4585_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層臨時<RetaliateIconKeywords:反擊>，在首領戰中，獲得 3 倍臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_4585_EffectNameList_0 = {
    Text = "護盾,臨時反擊"
  },
  Skill_4585_Name = {
    Text = "高熱區禁入"
  },
  Skill_4585_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4586_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4587_AwakerSkillBackgroundStory = {
    Text = "這是她揮出的第∞+1劍。"
  },
  Skill_4587_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TimeBeacon:回環>：造成 [Arg3] 次傷害，環行·拉蒙娜暴擊率 +[Arg5]%。"
  },
  Skill_4587_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。環行·拉蒙娜獲得 <Energy:[Energy:Arg2]> 點狂氣。<TimeBeacon:回環>：造成 [Arg3] 次傷害，環行·拉蒙娜暴擊率 +[Arg5]%。"
  },
  Skill_4587_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4587_Name = {Text = "打擊"},
  Skill_4587_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4588_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，為對方添加 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4589_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4590_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4591_AwakerSkillBackgroundStory = {
    Text = "反復被黑暗吞噬的痛苦，造就了她對黑暗的恐懼。連閉眼休憩時的片刻黑暗都讓她難以忍受。\n「儘管笑好了！你們根本就不懂，那個黑色的……黑色的……有多可怕。」"
  },
  Skill_4591_Desc_0 = {
    Text = "溫柯爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：溫柯爾造成的護盾和反擊提高 10％，打出卡牌後獲得 <Energy:[Energy:Arg2]> 點狂氣和 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4591_Desc_15 = {
    Text = "溫柯爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：溫柯爾造成的護盾和反擊提高 10％，打出卡牌後獲得 <Energy:[Energy:Arg2]> 點狂氣和 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。使狂氣最低的其他喚醒體獲得 80 狂氣。"
  },
  Skill_4591_EffectNameList = {
    Text = "狂氣,反擊"
  },
  Skill_4591_Name = {
    Text = "自我封鎖"
  },
  Skill_4591_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4592_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，在後排召喚「求告者」。"
  },
  Skill_4592_Name = {
    Text = "分裂打擊"
  },
  Skill_4594_Desc = {
    Text = "為對方添加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4597_Desc = {
    Text = "全體友方獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4597_Name = {
    Text = "全體強化"
  },
  Skill_4598_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4599_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4601_AwakerSkillBackgroundStory = {
    Text = "「群星與卡達斯皆已做好準備。承蒙選召的眷族啊，你將輝耀返生……」\n從那時起，她的藝術只剩下唯一的母題。\n她在狂想中縱情忘我，她在幻夢中潸然淚下。"
  },
  Skill_4601_Desc_0 = {
    Text = "珊獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕數量上限 +1。珊造成的護盾提高 [Arg3]％。珊每次造成護盾 <TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_4601_Desc_15 = {
    Text = "珊獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕數量上限 +1。珊造成的護盾和最終傷害提高 [Arg3]％，每擁有 1 條永久觸腕額外提高 3％。珊每次造成護盾 <TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。"
  },
  Skill_4601_EffectNameList = {
    Text = "狂氣,觸腕傷害"
  },
  Skill_4601_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4602_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，吸收所有教徒。"
  },
  Skill_4603_AwakerSkillBackgroundStory = {
    Text = "這綠炎已是構成她的一部分。\n若她指引，隨處皆可點燃。"
  },
  Skill_4603_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4603_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣，施加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4603_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。莉茲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4603_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。莉茲獲得 <Energy:[Energy:Arg2]> 點狂氣，施加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4603_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4603_Name = {Text = "打擊"},
  Skill_4603_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4604_AwakerSkillBackgroundStory = {
    Text = "「奧吉爾真是好孩子，不如長大後你成為我女兒的騎士吧——她很喜歡你。」\n「子爵家的小孩啊？騎士團可不會因為年幼就減輕訓練的哦。」\n「幹得不錯嘛！看樣子，奧吉爾未來會由公主親自冊封吧。」\n「不要後退，守住行宮！不要讓任何人靠近公主！」\n「謝謝你，奧吉爾……夠了，讓我來保護你吧……」"
  },
  Skill_4604_Desc_0 = {
    Text = "奧吉爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg3] 點<PowerIconKeywords:力量>，奧吉爾打出卡牌後，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4604_Desc_15 = {
    Text = "奧吉爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg3] 點<PowerIconKeywords:力量>，奧吉爾打出卡牌後，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。在本場戰鬥觸發死亡抵抗後，奧吉爾的狂氣爆發獲得的臨時<PowerIconKeywords:力量>提高為 3 倍。"
  },
  Skill_4604_EffectNameList = {
    Text = "狂氣,力量,卡牌獲得力量"
  },
  Skill_4604_Name = {
    Text = "騎士熱誠"
  },
  Skill_4604_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue3,攻擊力*GrowValue2"
  },
  Skill_4605_Desc = {
    Text = "向隨機喚醒體施加 1 層臨時封印，重複 2 次。"
  },
  Skill_4606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4607_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg2] 倍力量加成，施加 [Arg3]％ 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4607_EffectNameList = {Text = "傷害"},
  Skill_4607_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4608_Desc = {Text = "無"},
  Skill_4609_Desc = {
    Text = "自身獲得 [Arg1] 點<PowerIconKeywords:力量>。移除敵人一半的<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>狀態。"
  },
  Skill_4609_Name = {
    Text = "強者為尊"
  },
  Skill_4610_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4610_Name = {
    Text = "虛弱一擊"
  },
  Skill_4611_Desc = {
    Text = "所有喚醒體獲得 20 狂氣。擊暈「分裂患者」。"
  },
  Skill_4611_Name = {
    Text = "鎮定之鈴"
  },
  Skill_46128_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，在後排召喚「多維者」。"
  },
  Skill_46128_Name = {
    Text = "維度分形"
  },
  Skill_46129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，在後排召喚「多維者」。"
  },
  Skill_46129_Name = {
    Text = "維度分形"
  },
  Skill_4612_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_46130_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量>，自身獲得 <Block:[Block:Arg2]> 護盾 。"
  },
  Skill_46130_Name = {
    Text = "全體強化"
  },
  Skill_46131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_46135_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 護盾。"
  },
  Skill_4613_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4614_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4615_AwakerSkillBackgroundStory = {
    Text = "菲茵特是殘缺的。\n\n菲茵特是危險的。\n菲茵特是被詛咒的。\n菲茵特，是來自群星的，最詭譎而繽紛的一道色彩。"
  },
  Skill_4615_BattleDesc_15 = {
    Text = "菲茵特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻永久竊取所有敵人 [Arg4] 點<PowerIconKeywords:力量>。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。本場戰鬥死亡抵抗觸發衰減率從 50% 降低為 45%。菲茵特打出卡牌時，<TouquKeywords:竊取>所有敵人 [Arg2] 點<PowerIconKeywords:力量>。回合結束時，對前排敵方觸發 50% <RetaliateIconKeywords:反擊>。"
  },
  Skill_4615_Desc_0 = {
    Text = "菲茵特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。本場戰鬥死亡抵抗觸發衰減率從 50% 降低為 45%。菲茵特打出卡牌時，<TouquKeywords:竊取>所有敵人 [Arg2] 點<PowerIconKeywords:力量>。回合結束時，對前排敵方觸發 50% <RetaliateIconKeywords:反擊>。"
  },
  Skill_4615_Desc_15 = {
    Text = "菲茵特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻永久竊取所有敵人 [Arg4] 點<PowerIconKeywords:力量>。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。本場戰鬥死亡抵抗觸發衰減率從 50% 降低為 45%。菲茵特打出卡牌時，<TouquKeywords:竊取>所有敵人 [Arg2] 點<PowerIconKeywords:力量>。回合結束時，對前排敵方觸發 50% <RetaliateIconKeywords:反擊>。"
  },
  Skill_4615_EffectNameList = {
    Text = "狂氣,反擊,偷取力量"
  },
  Skill_4615_Name = {
    Text = "無邊星彩"
  },
  Skill_4615_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue3,攻擊力*GrowValue2"
  },
  Skill_4616_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成未被格擋的傷害時回復 3 倍傷害的生命，持續 [Arg2] 回合，前進。"
  },
  Skill_4616_Name = {
    Text = "手術準備"
  },
  Skill_4617_AwakerSkillBackgroundStory = {
    Text = "在水手絕望的哭聲中，她安靜地注視著，等待著。\n平靜的海面冒起氣泡，巨大的觸腕從中升起，迅速交纏於桅杆之上，並在海風中展開成嶄新的船帆。\n「啟航，啟航！」海員們唱道，「我們於幻影中啟航！」"
  },
  Skill_4617_Desc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。臨時<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg2]。所有敵人施加 1 回合<WeaknessIconKeywords:虛弱>。激發 1 條觸腕攻擊敵人，造成 [Arg3]％ 觸腕傷害。"
  },
  Skill_4617_EffectNameList = {
    Text = "回復,臨時觸腕傷害"
  },
  Skill_4617_PropertyNameList = {
    Text = "體質*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4618_AwakerSkillBackgroundStory = {
    Text = "你曾在某個時刻覺得自己是聚光燈的焦點、宇宙的中心、上帝的寵兒麼？\n對萊克來說，就是輕輕瞄了一眼底牌，然後坦然揭開的時刻。"
  },
  Skill_4618_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 1~[Arg4] 次，獲得 <Energy:[Energy:Arg2]> 點狂氣。若造成 6 次或以上傷害，獲得 1 張算力消耗為 0 附加消耗的「意外收穫」。"
  },
  Skill_4618_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 1~[Arg4] 次，獲得 <Energy:[Energy:Arg2]> 點狂氣，每次暴擊，額外獲得 <Energy:[Arg3]> 點狂氣。若造成 6 次或以上傷害，獲得 1 張算力消耗為 0 附加<DepleteIconKeywords:消耗>的「意外收穫」。"
  },
  Skill_4618_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4618_Name = {
    Text = "攤牌時刻"
  },
  Skill_4618_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4620_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4621_Desc = {
    Text = "造成 [Arg1] 層<IntoxicationIconKeywords:中毒>，對抽牌堆和棄牌堆中隨機 [Arg2] 張卡牌施加「<SlowIconKeywords:遲緩>」"
  },
  Skill_4621_Name = {
    Text = "遲滯入骨"
  },
  Skill_4622_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每當造成未被格擋的傷害，就會造成 1 層<FragileIconKeywords:脆弱>。"
  },
  Skill_4622_Name = {
    Text = "永恆狂獵"
  },
  Skill_4624_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4625_Desc = {
    Text = "獲得 1 點算力，將 1 張「症狀：癔想」加入棄牌堆中。無法出售。"
  },
  Skill_4625_Name = {
    Text = "症狀：癔想"
  },
  Skill_4626_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，抽牌堆和棄牌堆的所有卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4626_Name = {
    Text = "萬古之眸"
  },
  Skill_4627_AwakerSkillBackgroundStory = {
    Text = "當獻媚者乞憐時，勿要得意。\n當獻媚者凝望時，勿要羞澀。\n當獻媚者擁抱時，勿要逃避。\n獻媚者所思所為僅通向唯一的終點，那裡沒有你的位置，只有潮水一樣洶湧的悲傷與墮落。"
  },
  Skill_4627_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命。驅散自身<VulnerabilityIconKeywords:易傷>狀態。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命，驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_EffectNameList = {
    Text = "回復,力量"
  },
  Skill_4627_Name = {
    Text = "獻媚者之擁"
  },
  Skill_4627_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回覆 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。】回覆 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。所有喚醒體的暴擊率與暴擊傷害 +[Arg6]%。"
  },
  Skill_4627_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。所有喚醒體的暴擊率與暴擊傷害 +[Arg6]%。"
  },
  Skill_4627_PropertyNameList = {
    Text = "體質*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4627_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4627_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg2] 點<PowerIconKeywords:力量>和 [Power:Arg7] 點<PowerIconKeywords:臨時力量> 。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：回覆 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。】回覆 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。所有喚醒體的暴擊率與暴擊傷害 +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。所有喚醒體的暴擊率與暴擊傷害 +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回復 [Arg4]% 已損失的生命(<Heal:[Arg3]>)。驅散自身<VulnerabilityIconKeywords:易傷>狀態。本次「獻媚者之擁」獲得的力量翻倍。】回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Power:Arg5] 點<PowerIconKeywords:力量>和 [Power:Arg7] 點<PowerIconKeywords:臨時力量> 。所有喚醒體的暴擊率與暴擊傷害 +[Arg6]%。"
  },
  Skill_4628_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg3] 次、並獲得 1 層瘋狂。"
  },
  Skill_4629_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每當造成未被格擋的傷害，就會造成 1 層<FragileIconKeywords:脆弱>。"
  },
  Skill_4629_Name = {Text = "追獵"},
  Skill_4630_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4631_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4632_Desc = {
    Text = "獲得 [Arg1] 點護盾，造成未被格擋的傷害時回復 3 倍傷害的生命，持續 [Arg2] 回合。"
  },
  Skill_4632_Name = {
    Text = "手術準備"
  },
  Skill_4633_Desc = {
    Text = "獲得 [Arg1] 點護盾，將 1 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入抽牌堆。"
  },
  Skill_4633_Name = {
    Text = "手術準備"
  },
  Skill_4634_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4635_AwakerSkillBackgroundStory = {
    Text = "有某種遠古的力量，在墨菲的體內蘇生。\n被植埋的種子，日復一日成長為虛妄的蓓蕾。\n「既然被授以這樣的力量，就讓你們好好看看我的本事吧！」"
  },
  Skill_4635_Desc = {
    Text = "所有敵人傷害降低 [Arg1]%，但自身受到攻擊時被施加一半傷害的<SacrificeKeyWord:獻祭>，持續 1 回合。獲得 <Block:[Block:Arg2]> 點護盾，使所有觸腕攻擊 1 次。"
  },
  Skill_4635_EffectNameList = {Text = "護盾"},
  Skill_4635_Name = {
    Text = "虛妄繼承者"
  },
  Skill_4635_OverLimitUtlSkillDesc = {
    Text = "所有敵人傷害降低 [Arg1]%，但自身受到攻擊時被施加一半傷害的<SacrificeKeyWord:獻祭>，持續 1 回合。獲得 <Block:[Block:Arg2]> 點護盾，使所有觸腕攻擊 1 次。回合開始時，獲得 <Block:[Block:Arg3]> 點護盾和 [Arg4] 點<TentacleInjurieIconKeywords:觸腕傷害> ，生成 2 條臨時觸腕，持續 3 回合。"
  },
  Skill_4635_PropertyNameList = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4636_Desc = {
    Text = "抽到時失去 1 算力，抽 1 張牌。"
  },
  Skill_4637_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4638_AwakerSkillBackgroundStory = {
    Text = "由整塊精鐵打造的利刃無比沉重，破空之時帶起的氣流甚至可以震碎岩石。\n我忠誠的夥伴，我可靠的巨刃啊，我們皆於黑暗中獲得新生與無窮力量。今夜，我們將痛飲仇敵之血；今夜，我們將盡情殺戮。"
  },
  Skill_4638_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。<PowerIconKeywords:力量>在「巨刃之威」上發揮 [Arg2] 倍效果。此卡視為「打擊」。"
  },
  Skill_4638_EffectNameList = {Text = "傷害"},
  Skill_4638_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4639_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4641_Desc_0 = {
    Text = "對隨機敵人造成 <Damage:[Damage:Arg2]> 傷害 [Arg1] 次。"
  },
  Skill_4641_EffectNameList = {Text = "傷害"},
  Skill_4641_Name = {
    Text = "鼠群衝擊"
  },
  Skill_4641_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_46420_Desc_1 = {
    Text = "使一名目標獲得 [Arg1] 層<PVPEntanglementKeywords:纏繞>。"
  },
  Skill_46420_Name_1 = {Text = "纏繞"},
  Skill_4642_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，棄掉對方所有的手牌。"
  },
  Skill_4642_Name = {Text = "離散"},
  Skill_46431_Desc_1 = {
    Text = "使一名目標獲得 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>傷害。"
  },
  Skill_46431_Name_1 = {
    Text = "延遲傷害"
  },
  Skill_46432_Desc_1 = {
    Text = "使一名目標獲得 <DelayKeywords:延遲>： <Block:[Block:Arg1]> 護盾。"
  },
  Skill_46432_Name_1 = {
    Text = "延遲護盾"
  },
  Skill_46433_Desc_1 = {
    Text = "讓目標獲得 1 層 <PVPEmptinessKeywords:空虛>。"
  },
  Skill_46433_Name_1 = {Text = "空虛"},
  Skill_4643_AwakerSkillBackgroundStory = {
    Text = "「不對，不對。這不是創作的邏輯。」\n雕塑家沉聲說著，卻不敢直視年輕徒弟的眼睛。\n那是怎樣的一雙眼呵——\n沉靜如世界盡頭的海洋，將垂死候鳥的掙扎盡收眼底。\n她知曉一切，卻靜默不語。"
  },
  Skill_4643_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Arg2] 條觸腕。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg4]> 點狂氣。"
  },
  Skill_4643_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，每有 1 條觸腕，額外獲得 [Arg3] 點護盾。獲得 [Arg2] 條觸腕。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg4]> 點狂氣。"
  },
  Skill_4643_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Arg2] 條觸腕。<RippleKeywords:餘波>：獲得等同於當前觸腕數量的狂氣。"
  },
  Skill_4643_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，每有 1 條觸腕，額外獲得 [Arg3] 點護盾。獲得 [Arg2] 條觸腕。<RippleKeywords:餘波>：獲得等同於當前觸腕數量的狂氣。"
  },
  Skill_4643_EffectNameList_0 = {Text = "護盾"},
  Skill_4643_EffectNameList_2 = {
    Text = "護盾,每條觸腕護盾"
  },
  Skill_4643_Name = {
    Text = "美的憐憫"
  },
  Skill_4643_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,"
  },
  Skill_4643_PropertyNameList_2 = {
    Text = "防禦力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4644_AwakerSkillBackgroundStory = {
    Text = "離港的船迷失在風中，離群的獸掀起巨浪。\n她的狂熱幾度影響了人類文明的存續，但她從不關心。\n對獸而言，沒有比尋回棲息地更重要的事。"
  },
  Skill_4644_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害和等量的<IntoxicationIconKeywords:中毒>，享受 [Arg4]% <TentacleInjurieIconKeywords:觸腕傷害>加成。生成 [Arg2] 條無視觸腕上限的臨時觸腕。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]。"
  },
  Skill_4644_EffectNameList = {
    Text = "傷害,觸腕傷害"
  },
  Skill_4644_Name = {
    Text = "狂熱之海"
  },
  Skill_4644_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4645_BattleDesc = {
    Text = "失去 [Arg1] 點生命，所有喚醒體獲得 10 狂氣。無法出售。"
  },
  Skill_4645_Desc = {
    Text = "失去 10% 最大生命，所有喚醒體獲得 10 狂氣。無法出售。"
  },
  Skill_4645_Name = {
    Text = "症狀：瘋狂"
  },
  Skill_4646_AwakerSkillBackgroundStory = {
    Text = "在決鬥中，通常是不需要防禦姿態的，勇猛的進攻便是最好的防禦。"
  },
  Skill_4646_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4646_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4646_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4646_Name = {Text = "打擊"},
  Skill_4646_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4647_Desc = {
    Text = "它已經沒有什麼用了。棄掉或打出時將其<DepleteIconKeywords:消耗>。"
  },
  Skill_4647_Name = {Text = "石頭"},
  Skill_4648_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4649_Desc = {
    Text = "自身死亡，分裂為 2 個生命與自身當前相等的「融蝕三角中蠟像」。"
  },
  Skill_4650_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4651_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加 [Arg3] 層寄生。"
  },
  Skill_4651_Name = {
    Text = "附骨侵蝕"
  },
  Skill_4652_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，抽牌堆頂的 [Arg3] 張卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4652_Name = {
    Text = "凝滯詛咒"
  },
  Skill_4653_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4653_Name = {
    Text = "手術切割"
  },
  Skill_4654_Desc = {
    Text = "獲得 [Arg1] 點護盾。莉莉召喚的黏液護盾，能且僅能抵禦一次地獄犬的撕裂。真的……不會痛嗎？"
  },
  Skill_4654_Name = {
    Text = "淤泥上的不滅之花"
  },
  Skill_4655_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而靜謐的，它承載著對生的渴望與對死的恐懼。\n但偏偏有人要用歡笑與玩弄填滿海洋——在奧瑞塔發出如此邀請時，「陪她鬧一場又何妨」的感覺總會湧上心頭，順勢讓簡單的快樂填滿胸腔。"
  },
  Skill_4655_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_4655_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。"
  },
  Skill_4655_EffectNameList = {
    Text = "傷害,後續傷害提升"
  },
  Skill_4655_Name = {
    Text = "喧囂海洋"
  },
  Skill_4655_OverLimitUtlSkillDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提升 [Arg2] 點。獲得 [Power:Arg2] 點 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>，之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  Skill_4655_OverLimitUtlSkillDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。消耗抽牌堆和棄牌堆中最多 10 張「腺體分裂」，每張額外造成 1 次傷害。將 2 張「腺體分裂」置入手中。使「奧瑞塔」本場戰鬥後續造成的傷害提高 [Arg2] 點。獲得 [Power:Arg2] 點 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點<TentacleInjurieIconKeywords:觸腕傷害>，之後 5 次打出「腺體分裂」時，都會抽 1 張牌。"
  },
  Skill_4655_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4656_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4657_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量> 與 <Block:[Block:Arg2]> 護盾 。"
  },
  Skill_4657_Name = {
    Text = "全體強化"
  },
  Skill_4658_AwakerSkillBackgroundStory = {
    Text = "卡茜亞的雙手空落落；\n卡茜亞的帽子空落落；\n卡茜亞的胸口空落落。\n空落落的卡茜亞裝著空落落的快樂，在空落落的狂歡中進行空落落的表演。"
  },
  Skill_4658_Desc_0 = {
    Text = "卡茜亞獲得 <Energy:[Energy:Arg1]> 點狂氣，<ExaltIconKeywords:靈知覺醒>：卡茜亞每打出 1 張卡牌，獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_4658_Desc_15 = {
    Text = "卡茜亞獲得 <Energy:[Energy:Arg1]> 點狂氣，<ExaltIconKeywords:靈知覺醒>：卡茜亞每打出 1 張卡牌，獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>，所有喚醒體打出「打擊」時都能觸發該效果獲得臨時力量。"
  },
  Skill_4658_EffectNameList = {
    Text = "狂氣,力量"
  },
  Skill_4658_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4659_AwakerSkillBackgroundStory = {
    Text = "——不過你還太弱了，不好好保護可不行啊。"
  },
  Skill_4659_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4659_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。蘿坦獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4659_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4659_Name = {Text = "防禦"},
  Skill_4659_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4659_tempBattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4659_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。本回合下 1 張「桀驁之刃」生效 2 次。"
  },
  Skill_4660_AwakerSkillBackgroundStory = {
    Text = "一二，一二……\n她手舉託盤，踏著輕快的節奏穿梭在人潮中。\n賓客一刻不停地飲酒、唱歌，她一刻不停地上菜、微笑。\n這裡一切都是金色的。金色的大廳、金色的葡萄酒、還有金色的裙擺。\n珈倫喜歡金色。她揚起練習過無數次的招牌微笑。\n「客官請慢用——！！」"
  },
  Skill_4660_Desc_0 = {
    Text = "移除所有手牌的<SlowIconKeywords:遲緩>狀態。回復 <Heal:[Heal:Arg1]> 點生命。將 1 張<DerivativeCardKeywords_42:「奇妙料理」>置入手中。對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4660_Desc_3 = {
    Text = "移除所有手牌的<SlowIconKeywords:遲緩>狀態。回復 <Heal:[Heal:Arg1]> 點生命。將 1 張<DerivativeCardKeywords_43:「奇妙料理」>置入手中。對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4660_EffectNameList = {
    Text = "回復,中毒"
  },
  Skill_4660_Name = {
    Text = "客官請慢用！"
  },
  Skill_4660_OverLimitUtlSkillDesc_0 = {
    Text = "移除所有手牌的<SlowIconKeywords:遲緩>狀態。回覆 <Heal:[Heal:Arg1]> 點生命。將 1 張<DerivativeCardKeywords_43:「奇妙料理」>置入手中。對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。將<DerivativeCardKeywords_42:「奇妙料理」>洗入抽牌堆和棄牌堆各 1 張。"
  },
  Skill_4660_OverLimitUtlSkillDesc_3 = {
    Text = "移除所有手牌的<SlowIconKeywords:遲緩>狀態。回復 <Heal:[Heal:Arg1]> 點生命。將 1 張<DerivativeCardKeywords_43:「奇妙料理」>置入手中。對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。將<DerivativeCardKeywords_43:「奇妙料理」>洗入抽牌堆和棄牌堆各 1 張。"
  },
  Skill_4660_PropertyNameList = {
    Text = "體質*GrowValue1,攻擊*GrowValue2"
  },
  Skill_4661_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_4661_Name = {
    Text = "蜜糖色悲慘幻象"
  },
  Skill_4662_AwakerSkillBackgroundStory = {
    Text = "人們讚歎她的美貌，豔羨她的風情，但沒有人會把一朵花苞當回事。\n在鄉野間搖擺不定的骨朵，被人任意左右未來，被當做花農晉升的籌碼。\n直到她於冠冕前綻放時，人們才驚覺自己已被鉤刺劃得鮮血淋漓。"
  },
  Skill_4662_BattleDesc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。回合結束時回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4662_BattleDesc_2 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，每造成 1 次傷害臨時暴擊率+5％。回合結束時回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4662_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次。回合結束時回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4662_Desc_2 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，每造成 1 次傷害臨時暴擊率+5％。回合結束時回復 <Heal:[Heal:Arg2]> 點生命"
  },
  Skill_4662_EffectNameList_0 = {
    Text = "傷害,回復"
  },
  Skill_4662_Name = {
    Text = "薔薇之美"
  },
  Skill_4662_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,體質*GrowValue2"
  },
  Skill_4663_AwakerSkillBackgroundStory = {
    Text = "冰冷的機械取代了心臟，液壓管內的油液取代了鮮血。她應該冰冷、理智、依照指令行事。\n但，一個外來的意志在她的軀殼內悄然而動。祂無需鮮血、無需溫度，僅憑自己便能燃燒出非人的惡意。祂說：臣服吧，卑賤弱小的生物，然後毀滅在我的炙熱電球中。"
  },
  Skill_4663_BattleDesc_0 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。獲得 <Posse:[Arg2]> 點銀鑰能量。驅散自身<WeaknessIconKeywords:虛弱>狀態。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_14:「機械武裝-斂」>。"
  },
  Skill_4663_BattleDesc_1 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。獲得 <Posse:[Arg2]> 點銀鑰能量。驅散自身<WeaknessIconKeywords:虛弱>狀態。將 1 張艾瑞卡附加<DepleteIconKeywords:消耗>的「打擊」置入手牌。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_14:「機械武裝-斂」>。"
  },
  Skill_4663_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。獲得等同於艾瑞卡銀鑰充能的銀鑰能量。驅散自身<WeaknessIconKeywords:虛弱>狀態。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_14:「機械武裝-斂」>。"
  },
  Skill_4663_Desc_1 = {
    Text = "獲得 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。獲得等同於艾瑞卡銀鑰充能的銀鑰能量。驅散自身<WeaknessIconKeywords:虛弱>狀態。將 1 張艾瑞卡附加<DepleteIconKeywords:消耗>的「打擊」置入手牌。每當有 1 張牌進入<DimensionalSpaceIconKeywords:超維空間>，變形為<DerivativeCardKeywords_14:「機械武裝-斂」>。"
  },
  Skill_4663_EffectNameList_0 = {
    Text = "力量,戒備"
  },
  Skill_4663_EffectNameList_1 = {
    Text = "力量,戒備,打擊卡等級"
  },
  Skill_4663_Name = {
    Text = "機械武裝-放"
  },
  Skill_4663_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4663_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,$GrowValue3"
  },
  Skill_4664_AwakerSkillBackgroundStory = {
    Text = "無形的疫病悄無聲息，帶來無盡的痛苦與癲狂。\n\n主教夜不能寐，為自己無法帶走人們的苦難而無比痛心。\n\n「仁慈的造主啊，拯救他們吧，我願替他們承擔一切苦痛與悲傷。」\n\n於是父神降「賜福」於他，讓他執篆刻了神言的石板，行消苦消難之事。"
  },
  Skill_4664_Desc_0 = {
    Text = "薩爾瓦多獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：將 1 張<B02AFKeyWord:護以仁愛>置入手中。回合結束後，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_4664_Desc_15 = {
    Text = "薩爾瓦多獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：將 1 張<B02AFKeyWord:護以仁愛>置入手中。回合結束後，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。「造主的庇佑」和「受祝骨血」積攢的猩紅熔爐提高 25%，「應消之苦」選擇「超度」時每消耗 1% 最大生命的猩紅熔爐所提高的最終傷害效果從 2% 提高為 5%。"
  },
  Skill_4664_EffectNameList = {
    Text = "狂氣,力量"
  },
  Skill_4664_Name = {
    Text = "「賜福」"
  },
  Skill_4664_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4665_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4665_Name = {
    Text = "縫合品的狂怒"
  },
  Skill_4666_AwakerSkillBackgroundStory = {
    Text = "「哼，讓本大小姐好好教育教育你。」"
  },
  Skill_4666_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4666_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]。"
  },
  Skill_4666_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4666_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。墨菲獲得 <Energy:[Energy:Arg2]> 點狂氣。<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg3]。"
  },
  Skill_4666_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4666_EffectNameList_2 = {
    Text = "傷害,狂氣,觸腕傷害"
  },
  Skill_4666_Name = {Text = "打擊"},
  Skill_4666_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4666_PropertyNameList_2 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4667_AwakerSkillBackgroundStory = {
    Text = "那是超越一切維度的巨大迷宮。\n誤入迷宮的旅者不得不面臨一項無禮的交易。\n若回答「否」，旅人將永遠困在迷宮裡。\n若回答「是」，旅人將被植入褻瀆的子嗣，並被抹除一切記憶。\n什麼，你問交易的具體內容是什麼？\n沒人知道交易的具體內容，包括蒼白的迷宮之主。\n交易，就只是交易而已。"
  },
  Skill_4667_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 和 [Arg4] 點<AlertIconKeywords:戒備>。】獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4667_EffectNameList = {
    Text = "力量,戒備,護盾,中毒"
  },
  Skill_4667_Name = {
    Text = "蒼白的庇佑"
  },
  Skill_4667_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 和 [Arg4] 點<AlertIconKeywords:戒備>。】獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>。抽 2 張阿格里帕的非打擊防禦指令卡，使 2 張手中阿格里帕的非打擊防禦指令卡本回合算力消耗 -1。"
  },
  Skill_4667_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue4,防禦力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4668_AwakerSkillBackgroundStory = {
    Text = "他不能接受自己竟差點死去。他應當無堅不摧，應當金剛不壞。如果人類的軀殼是他登上力量巔峰的阻礙，那就將軀體捨棄；如果拋棄族人可以換來他的強大，那就將過去埋葬。\n他將巨刃投入深海，借取非人的力量，誓要成為一切的主宰。\n就連那給予他力量的存在，未來都必將躺在他的腳下。"
  },
  Skill_4668_Desc = {
    Text = "選擇：<O06_AFKeyWord1:篡奪>或<O06_AFKeyWord2:蟄伏>。將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。"
  },
  Skill_4668_EffectNameList = {
    Text = "臨時力量"
  },
  Skill_4668_Name = {
    Text = "海淵之力"
  },
  Skill_4668_OverLimitUtlSkillDesc = {
    Text = "選擇：<O06_AFKeyWord1:篡奪>或<O06_AFKeyWord2:蟄伏>。將 3 張<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。選擇「篡奪」時，置入手中的「巨刃之威」基礎傷害提高 400%，算力消耗變為 0 。選擇「蟄伏」時，不再置入「巨刃之威」，改為將 2 張「斬首重創」置入手中，並使其獲得「消耗」、「預備 1」和「保留」。"
  },
  Skill_4669_AwakerSkillBackgroundStory = {
    Text = "她是心緒的載體，是情愫的延續。\n就放縱這濃墨流淌吧，就放縱這詩才揮霍吧。\n這世間未曾訴諸於口的話語，將從她的詩冊開始。"
  },
  Skill_4669_Desc_0 = {
    Text = "奧爾拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 1 層當前情緒外其他情緒的<D06CardKeyWord1:隱喻>，每回合開始也會獲得 1 層，每種<D06CardKeyWord1:隱喻>最多 3 層，每層<D06CardKeyWord1:隱喻>使詩篇<TransitionIconKeywords:躍遷>時消耗對應<D06CardKeyWord1:隱喻>並獲得額外加成。"
  },
  Skill_4669_Desc_15 = {
    Text = "奧爾拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 1 層當前情緒外其他情緒的<D06CardKeyWord1:隱喻>，每回合開始也會獲得 1 層，每種<D06CardKeyWord1:隱喻>最多 3 層，每層<D06CardKeyWord1:隱喻>使詩篇<TransitionIconKeywords:躍遷>時消耗對應<D06CardKeyWord1:隱喻>並獲得額外加成。發動湮滅後奧爾拉本回合下一張指令卡觸發躍遷效果。每當奧爾拉消耗 3 層或以上隱喻，使當前情緒光環效果臨時提高 [Arg2]%，該效果無法疊加。"
  },
  Skill_4669_EffectNameList = {Text = "狂氣"},
  Skill_4669_Name = {
    Text = "詩冊序言"
  },
  Skill_4670_Desc = {
    Text = "自身死亡，分裂為三個生命與自身相當的「Ⅱ型融蝕體」。"
  },
  Skill_4672_Desc = {
    Text = "當前生命和護盾回到上回合結束時的狀態。"
  },
  Skill_4672_Name = {
    Text = "過往回聲"
  },
  Skill_4673_Desc = {
    Text = "為對方添加 [Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4674_Desc = {
    Text = "將所有症狀卡變化為<DerivativeCardKeywords_37:「窒息」>，窒息：1算力，回合結束時若還在手中對自身施加[Arg1]點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 2 張<DerivativeCardKeywords_24:「裂傷」>加入手牌。"
  },
  Skill_4675_Name = {
    Text = "雙翼初張"
  },
  Skill_4676_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4677_Desc = {
    Text = "獲得 1 點算力，抽 1 張牌。"
  },
  Skill_4677_Name = {Text = "靈感"},
  Skill_4678_AwakerSkillBackgroundStory = {
    Text = "他不放過任何一個搗碎敵人的機會。"
  },
  Skill_4678_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。尤烏哈希獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4678_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4678_Name = {Text = "打擊"},
  Skill_4678_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4680_AwakerSkillBackgroundStory = {
    Text = "山風在迷宮的骸骨裡窸窣作響，哀聲歎息。\n她聽著遠方迷途旅人哀號的聲音，打了第八千零一個哈欠。\n她啜飲痛苦，然後將它們一一歸類、陳列。\n只有一個問題——無人知曉她的傑作，她是這裡唯一的觀眾。\n唉——！\n她坐在迷宮的最深處，又打了一個哈欠。"
  },
  Skill_4680_Desc_0 = {
    Text = "阿格里帕獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：阿格里帕施加的<IntoxicationIconKeywords:中毒>提高 50%，回合結束後，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4680_Desc_15 = {
    Text = "阿格里帕獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：阿格里帕施加的<IntoxicationIconKeywords:中毒>提高 100%，回合結束後，獲得 <Block:[Block:Arg2]> 點護盾，每回合中阿格里帕每造成或觸發 1 次中毒，該護盾就提高 50%，最大 5 層。"
  },
  Skill_4680_EffectNameList = {
    Text = "狂氣,護盾"
  },
  Skill_4680_PropertyNameList = {
    Text = "$GrowValue1,防禦力*GrowValue2"
  },
  Skill_4681_Desc = {
    Text = "你的長線作戰已經引起了密境的注視…將一張症狀卡永久置入你的牌庫。"
  },
  Skill_4681_Name = {Text = "凝視"},
  Skill_4682_Desc = {
    Text = "封印四個喚醒體的狂氣爆發 1 回合。"
  },
  Skill_4683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4683_Name = {Text = "明滅"},
  Skill_4685_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。後撤。"
  },
  Skill_4686_AwakerSkillBackgroundStory = {
    Text = "「除了悲傷和苦難，這殘酷的暴行無法帶來任何幫助。終有一日，它必須終結。」"
  },
  Skill_4686_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4686_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，本場戰鬥每積攢 2 點猩紅熔爐回復量，就使傷害提高 [Float:Arg3]。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4686_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。薩爾瓦多獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4686_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，本場戰鬥每積攢 2 點猩紅熔爐回復量，就使傷害提高 [Float:Arg3]。薩爾瓦多獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4686_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4686_Name = {Text = "打擊"},
  Skill_4686_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4687_Desc = {
    Text = "回合結束時若在手中，會將你尚在手中的牌變為<DerivativeCardKeywords_25:「石頭」>。棄掉時將其<DepleteIconKeywords:消耗>。"
  },
  Skill_4687_Name = {
    Text = "漸漸石化"
  },
  Skill_4688_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。將 [Arg2] 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆。"
  },
  Skill_4688_Name = {Text = "瘋狂"},
  Skill_4689_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。將 [Arg2] 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆。"
  },
  Skill_4689_Name = {Text = "瘋狂"},
  Skill_4690_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4691_Desc = {
    Text = "抽 4 張牌。"
  },
  Skill_4691_Name = {
    Text = "不平等交換"
  },
  Skill_4692_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4693_Name = {
    Text = "桀驁之刃"
  },
  Skill_4694_AwakerSkillBackgroundStory = {
    Text = "在昏暗的新門監獄中，倫蒂尼恩隨處可見的蠟油也是珍稀之物。\n既然珍稀，就要在用在關鍵之地，例如懲戒之時，用在不乖孩子的皮膚上。\n並非特製的蠟油，滴落時伴隨悲慘的哀鳴嘯叫，但在少女的耳中聽來，卻好似優雅的詩章。"
  },
  Skill_4694_BattleDesc_0 = {
    Text = "獲得 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，每有 1 名敵人獲得 [Power:Arg1] 點<PowerIconKeywords:臨時力量>。移除所有敵人<RetaliateIconKeywords:反擊>狀態。"
  },
  Skill_4694_BattleDesc_2 = {
    Text = "獲得 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。臨時降低所有敵人 [Exhaustion:Arg1] 點<ExhaustionIconKeywords:力量>，每有 1 名敵人獲得 [Power:Arg1] 點<PowerIconKeywords:臨時力量>。移除所有敵人<RetaliateIconKeywords:反擊>狀態。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4694_Desc_0 = {
    Text = "獲得 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。<TouquKeywords:偷取>所有敵人 [Arg1] 點<PowerIconKeywords:力量>並移除其<RetaliateIconKeywords:反擊>狀態。"
  },
  Skill_4694_Desc_2 = {
    Text = "獲得 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。<TouquKeywords:偷取>所有敵人 [Arg1] 點<PowerIconKeywords:力量>並移除其<RetaliateIconKeywords:反擊>狀態。獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4694_EffectNameList = {
    Text = "偷取力量,反擊"
  },
  Skill_4694_Name = {
    Text = "灼燃蠟滴之欲"
  },
  Skill_4694_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4695_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將一張<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_4697_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_4697_Name = {
    Text = "戰欲難平"
  },
  Skill_4698_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態。祈禱：可用來強化技能，受到傷害失去一層，回合結束失去全部。"
  },
  Skill_4698_Name = {Text = "祈禱"},
  Skill_4701_AwakerSkillBackgroundStory = {
    Text = "那是扭曲的胚胎，是罪惡的種子。\n是鼓動的心跳，是澎湃的脈搏，是骨血相憎，命運倒纏。\n受造之物不具備選擇的自由，她只能任由倒錯的孕育發展。"
  },
  Skill_4701_Desc_0 = {
    Text = "墨菲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，墨菲打出卡牌後，獲得 1 條無視觸腕上限的臨時觸腕，和等同於 1 算力消耗的銀鑰充能，每回合最多生效 3 次。"
  },
  Skill_4701_Desc_15 = {
    Text = "墨菲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，墨菲打出卡牌後，獲得 1 條無視觸腕上限的臨時觸腕，和等同於 1 算力消耗的銀鑰充能，每回合最多生效 3 次。墨菲每回合首次打出的「螺湮逆流」傷害次數和「聖女作成」獲得算力翻倍。"
  },
  Skill_4701_EffectNameList = {Text = "狂氣"},
  Skill_4702_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4702_Name = {
    Text = "石質分解"
  },
  Skill_4703_AwakerSkillBackgroundStory = {
    Text = "保護主人。保護主人。保護主人。\n即使滿身傷痕，也要將命令執行到底。\n敵人很強大，那就展開更大的禁域，身體很疼痛，也不妨礙將命令貫徹到底。"
  },
  Skill_4703_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾並對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。直到下個回合開始，每受到 1 次攻擊獲得 [Arg3] 層<PainWord:忍耐>。"
  },
  Skill_4703_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾並對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。直到下個回合開始，每受到 1 次攻擊獲得 [Arg3] 層<PainWord:忍耐>。若生命低於 50%([Arg4])，額外獲得 1 次護盾，施加的中毒翻倍。"
  },
  Skill_4703_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾並對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>，莉莉每有 1% 死亡抵抗，基礎護盾提高 0.25%。直到下個回合開始，每受到 1 次攻擊獲得 [Arg3] 層<PainWord:忍耐>。"
  },
  Skill_4703_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾並對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>，莉莉每有 1% 死亡抵抗，基礎護盾提高 0.25%。直到下個回合開始，每受到 1 次攻擊獲得 [Arg3] 層<PainWord:忍耐>。若生命低於 50% ，額外獲得 1 次護盾，施加的中毒翻倍。"
  },
  Skill_4703_EffectNameList = {
    Text = "護盾,中毒,忍耐"
  },
  Skill_4703_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,防禦力*GrowValue3"
  },
  Skill_4704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4705_Desc = {
    Text = "獲得「神降儀式」狀態，每回合提高力量。造成 [Arg1] 層<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷> 狀態，將 3 張「執念」洗入牌庫。"
  },
  Skill_4705_Name = {
    Text = "神降儀式·呼喚"
  },
  Skill_4706_Desc = {
    Text = "獲得 [Arg2] 點護盾和獲得狀態「惡意放血」： 每造成一次未被格擋的傷害，附加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4707_Desc = {
    Text = "莉莉會模仿玩家每回合打出的第一張喚醒體卡牌。"
  },
  Skill_4707_Name = {Text = "覺醒"},
  Skill_47090_Desc_1 = {
    Text = "這張卡的卡面會有特殊效果！"
  },
  Skill_47091_Desc_1 = {
    Text = "這張卡的卡面會有特殊效果！"
  },
  Skill_47092_Desc_1 = {
    Text = "這張卡的卡面會有特殊效果！"
  },
  Skill_4709_Desc = {
    Text = "選擇一名喚醒體，將其指令卡各 1 張置入手中。守密人和銀鑰的共鳴為喚醒體們帶來了持續作戰的勇氣……"
  },
  Skill_4709_Name = {
    Text = "銀鑰共鳴"
  },
  Skill_4710_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，降低  [Arg3] 點臨時<PowerIconKeywords:力量>，回合結束移除。"
  },
  Skill_4711_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4712_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_32:「黏糊糊的蠟油」>洗入對方抽牌堆。"
  },
  Skill_4713_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得 [Arg2] 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_4714_AwakerSkillBackgroundStory = {
    Text = "懲戒，僅僅是他群星般紛繁的權能中，最微不足道的一個。"
  },
  Skill_4714_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，額外享受 [Arg4]% 觸腕傷害和力量加成。獲得 <Energy:[Energy:Arg2]> 點狂氣。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4714_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，額外享受 [Arg4]% 觸腕傷害和力量加成。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [TentaclePower:Arg3] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4714_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，額外享受 [Arg4]% 觸腕傷害和力量加成。圖魯獲得 <Energy:[Energy:Arg2]> 點狂氣。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4714_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，額外享受 [Arg4]% 觸腕傷害和力量加成。圖魯獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [TentaclePower:Arg3] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4714_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4714_EffectNameList_2 = {
    Text = "傷害,狂氣,臨時觸腕傷害,臨時力量"
  },
  Skill_4714_Name = {Text = "打擊"},
  Skill_4714_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4714_PropertyNameList_2 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,攻擊力*GrowValue3,攻擊力*GrowValue3"
  },
  Skill_4715_AwakerSkillBackgroundStory = {
    Text = "主要用料：藍紋乳酪 印度咖喱 新鮮蟾蜍腿若干\n準備步驟：將用料混合攪拌醃制七日，注入泥煤酒1盎司\n其他：擺盤是關鍵，將迷迭香拗成微笑的形狀，切記，切記！"
  },
  Skill_4715_Desc = {
    Text = "對所有敵人施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>和 1 回合的<WeaknessIconKeywords:虛弱>，回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4715_EffectNameList_0 = {
    Text = "中毒,回復"
  },
  Skill_4715_Name = {
    Text = "蟾蜍燉菜"
  },
  Skill_4715_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,體質*GrowValue2"
  },
  Skill_4716_AwakerSkillBackgroundStory = {
    Text = "油門、刹車，正常；油箱，正常；發動機狀態，良好。\n她準備好了，準備好出發，準備好冒險，準備好即將到來的所有未知。\n獨輪車在她身下發出轟鳴，漆黑的履帶高速旋轉，以超然的速度向前奔去。"
  },
  Skill_4716_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。使當前的護盾提高 50%。對所有敵人觸發 [Arg3]％ <RetaliateIconKeywords:反擊>。"
  },
  Skill_4716_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。使當前的護盾提高 50%。對所有敵人觸發 [Arg3]％ <RetaliateIconKeywords:反擊>。自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷> 1 回合。"
  },
  Skill_4716_EffectNameList_0 = {
    Text = "護盾,反擊"
  },
  Skill_4716_Name = {
    Text = "整裝待發"
  },
  Skill_4716_OverLimitUtlSkillDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。無視護盾上限，使當前的護盾提高 50%。對所有敵人觸發 [Arg4]％ <RetaliateIconKeywords:反擊>。"
  },
  Skill_4716_OverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>。無視護盾上限，使當前的護盾提高 50%。對所有敵人觸發 [Arg4]％ <RetaliateIconKeywords:反擊>。自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虛弱>、<VulnerabilityIconKeywords:易傷> 1 回合。"
  },
  Skill_4716_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4718_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4719_AwakerSkillBackgroundStory = {
    Text = "習慣了以人類的身體行走後，蘿坦花了很長時間尋找相稱的武器。\n直到今日，她也不認為這對巨劍能配得上自己，湊合用用罷了。"
  },
  Skill_4719_Desc_0 = {
    Text = "對隨機 1 名敵人造成 <Damage:[Damage:Arg1]> 點傷害，重複 [Arg3] 次。在本回合中每打出 1 張「打擊」，算力消耗減少 1 點 。"
  },
  Skill_4719_Desc_1 = {
    Text = "對隨機 1 名敵人造成 <Damage:[Damage:Arg1]> 點傷害，重複 [Arg3] 次。在本回合中每打出 1 張「打擊」，算力消耗減少 1 點 。視為「打擊」。"
  },
  Skill_4719_EffectNameList_0 = {Text = "傷害"},
  Skill_4719_Name = {
    Text = "桀驁之刃"
  },
  Skill_4719_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4720_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>加入對方抽牌堆。"
  },
  Skill_4720_Name = {
    Text = "致傷打擊"
  },
  Skill_4721_AwakerSkillBackgroundStory = {
    Text = "在成為主祭時，彌利亞姆被贈予了這把匕首。"
  },
  Skill_4721_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 100% <TentacleInjurieIconKeywords:觸腕傷害>加成。獲得 <Energy:[Energy:Arg2]> 點狂氣。<O07CardKeyWord:祭儀>：最終傷害提高 [Arg4]%/[Arg5]%/[Arg6]%。"
  },
  Skill_4721_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 100% <TentacleInjurieIconKeywords:觸腕傷害>加成。彌利亞姆獲得 <Energy:[Energy:Arg2]> 點狂氣。<O07CardKeyWord:祭儀>：最終傷害提高 [Arg4]%/[Arg5]%/[Arg6]%。"
  },
  Skill_4721_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4721_Name = {Text = "打擊"},
  Skill_4721_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4722_AwakerSkillBackgroundStory = {
    Text = "千萬年的孤寂中，那人的出現猶如深海中乍現的幽光，點燃了沉寂已久的海床。\n為了一場公平的對決，蘿坦甘願屈居於人類的形體中，暗暗等待對手的成長——她渴望一場酣暢的戰鬥，已經太久太久了。"
  },
  Skill_4722_Desc_0 = {
    Text = "蘿坦獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：蘿坦的傷害次數提高 [Arg2] 次。"
  },
  Skill_4722_Desc_15 = {
    Text = "蘿坦獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：蘿坦的傷害次數提高 [Arg2] 次。蘿坦的「防禦」使本回合下一張「桀驁之刃」生效 2 次。"
  },
  Skill_4722_EffectNameList = {Text = "狂氣"},
  Skill_4722_Name = {
    Text = "戰欲難平"
  },
  Skill_4723_Desc = {
    Text = "每有 1 層「狩獵印記」就獲得 [Arg2] 點護盾。"
  },
  Skill_4723_Name = {
    Text = "蓄力迴響"
  },
  Skill_4724_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_26:症狀：「妄想」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4725_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4726_Desc = {
    Text = "向狂氣最高喚醒體施加 1 層臨時封印，造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。"
  },
  Skill_4727_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4728_AwakerSkillBackgroundStory = {
    Text = "我已經捨棄作為人類的一切了！我將回歸深海的懷抱！\n可是為什麼，我的蛻變卻失敗了呢？\n是命運的嘲弄嗎？還是我的愚蠢呢？\n瘋狂的凱刻斯擁抱著破碎的戟刺，試圖沉入海底。\n只要能回去，能被接納，無論前方有多少障礙，他都會一一掃清。"
  },
  Skill_4728_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並獲得等量的<RetaliateIconKeywords:反擊>，享受 50% <TentacleInjurieIconKeywords:觸腕傷害>加成。"
  },
  Skill_4728_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並獲得等量的<RetaliateIconKeywords:反擊>，享受 50% <TentacleInjurieIconKeywords:觸腕傷害>加成。獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_4728_EffectNameList_0 = {Text = "傷害"},
  Skill_4728_EffectNameList_1 = {
    Text = "傷害,狂氣"
  },
  Skill_4728_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4728_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4729_AwakerSkillBackgroundStory = {
    Text = "「是的，余曾如此向她許諾。」\n提及故國覆滅的那一日，幼王的神情愈發疲倦。\n「余隻希望那番話能寬慰她死前的恐懼，未曾想過她會將此奉為圭臬……」"
  },
  Skill_4729_Desc_0 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。獲得 [TentaclePower:Arg1] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。若當前姿態為「靜海」，額外使所有敵人在本回合中降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。<RippleKeywords:余波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4729_Desc_3 = {
    Text = "驅散自身<WeaknessIconKeywords:虛弱>狀態。獲得 [TentaclePower:Arg1] 點臨時<TentacleInjurieIconKeywords:觸腕傷害>和 [Power:Arg1] 點臨時<PowerIconKeywords:力量>。獲得 [Arg2]％ 臨時暴擊率。若當前姿態為「靜海」、額外使所有敵人在本回合中降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。<RippleKeywords:餘波>：驅使 1 條觸腕攻擊敵方。"
  },
  Skill_4729_EffectNameList_0 = {
    Text = "臨時觸腕傷害,臨時力量,力量降低"
  },
  Skill_4729_Name = {
    Text = "螺湮重臨"
  },
  Skill_4729_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4731_Desc = {
    Text = "獲得 [Arg1] 點護盾，<TouquKeywords:永久偷取> [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4731_Name = {
    Text = "蓄力迴響"
  },
  Skill_4732_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4733_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_4734_Desc = {
    Text = "施加 [Arg2] 層<IntoxicationIconKeywords:中毒>。若仍然有其他敵人存在，犧牲自身進行寄生，並附加「被寄生」狀態。"
  },
  Skill_4735_Desc = {
    Text = "施加 [Arg1] 層<WeaknessIconKeywords:虛弱>，抽牌堆和棄牌堆頂的 [Arg3] 張卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4735_Name = {
    Text = "萬古之眸"
  },
  Skill_4736_Desc = {
    Text = "召喚兩個「提燈」。"
  },
  Skill_4736_Name = {Text = "召喚"},
  Skill_4737_Desc = {
    Text = "消耗全部祈禱層數，每層施加 [Arg1] 的<BleedingIconKeywords:出血>"
  },
  Skill_4737_Name = {
    Text = "擁抱融蝕"
  },
  Skill_4738_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4740_AwakerSkillBackgroundStory = {
    Text = "趨光本能讓飛蟲追逐著光亮，而那長明燈火又過於灼目，讓人往往忽略了水面下暗流的洶湧……"
  },
  Skill_4740_Desc = {
    Text = "本回合內造成觸腕傷害後，會對全體敵方施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4740_EffectNameList = {
    Text = "中毒層數"
  },
  Skill_4740_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4741_Desc = {
    Text = "回合結束時、若此卡牌仍在手中且本回合剩餘的算力不少於 2 點、下回合額外抽 2 張牌。"
  },
  Skill_4741_Name = {
    Text = "症狀：興奮"
  },
  Skill_4742_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4742_Name = {Text = "強化"},
  Skill_4743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4744_AwakerSkillBackgroundStory = {
    Text = "她本不願屈身，但最完美的復仇總是需要暫時的隱忍。"
  },
  Skill_4744_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4744_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣和 25% 臨時暴擊率。"
  },
  Skill_4744_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4744_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。希洛獲得 <Energy:[Energy:Arg2]> 點狂氣和 25% 臨時暴擊率。"
  },
  Skill_4744_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4744_Name = {Text = "防禦"},
  Skill_4744_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_47455_Desc_1 = {
    Text = "使一名目標獲得 <StrengthenKeywords:沙包>。"
  },
  Skill_4745_AwakerSkillBackgroundStory = {
    Text = "兩個意志在機械的軀殼內不斷對抗掙扎：一個期望毀滅，一個不願屈從。但渺小的人類不可能長久地勝利，她終將會被對方吞噬，成為一個隻為毀壞存在的癲狂容器。\n於是她將所有電流全部釋放。巨大的電弧籠罩在她的身上，短路的身軀響起電流的爆鳴，她向前拋出積蓄的能量，隨即陷入短暫的失能。\n「無法動彈，就無法毀滅。」"
  },
  Skill_4745_Desc_0 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4745_Desc_2 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成。"
  },
  Skill_4745_EffectNameList_0 = {
    Text = "傷害,護盾"
  },
  Skill_4745_Name = {
    Text = "電磁爆破"
  },
  Skill_4745_OverLimitUtlSkillDesc_0 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg6]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg5]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。艾瑞卡的「基礎打擊」額外造成 1 次傷害，「基礎防禦」額外獲得 1 次護盾，持續 3 回合。"
  },
  Skill_4745_OverLimitUtlSkillDesc_2 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg6]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg5]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成。艾瑞卡的「基礎打擊」額外造成 1 次傷害、「基礎防禦」額外獲得 1 次護盾、持續 3 回合。"
  },
  Skill_4745_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4745_tempBattleDesc_1 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4745_tempBattleDesc_2 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成。"
  },
  Skill_4745_tempBattleDesc_3 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg2]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg1]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成，後續釋放享受的力量與戒備加成額外提高 1 倍。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_1 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg6]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg5]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。艾瑞卡「基礎打擊」額外造成 1 次傷害，「基礎防禦」額外獲得 1 次護盾，持續 3 回合。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_2 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg6]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg5]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成。艾瑞卡「基礎打擊」額外造成 1 次傷害，「基礎防禦」額外獲得 1 次護盾，持續 3 回合。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_3 = {
    Text = "艾瑞卡獲得 [Arg4]% 臨時暴擊率與暴擊傷害。獲得 <Block:[Block:Arg6]> 點護盾。對所有敵人造成 <Damage:[Damage:Arg5]> 傷害並施加 [Arg3] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。該技能額外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒備>加成，後續釋放享受的力量與戒備加成額外提高 1 倍。艾瑞卡「基礎打擊」額外造成 1 次傷害，「基礎防禦」額外獲得 1 次護盾，持續 3 回合。"
  },
  Skill_4746_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_28:症狀：「崩潰」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4747_Desc = {
    Text = "你的長線作戰已經引起了密境的注視…造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得狀態「憤怒」，敵方的力量將持續增長！"
  },
  Skill_4747_Name = {Text = "褻瀆"},
  Skill_47484_Desc = {
    Text = "獲得 2 點算力，抽 2 張牌。"
  },
  Skill_47484_Name = {
    Text = "高級靈感"
  },
  Skill_4748_AwakerSkillBackgroundStory = {
    Text = "孩子們會慢慢看穿童話的本質，理解神話背後的寓言。在人類的語言中，這個過程被稱為「長大」。\n但也有孩子會愈發相信睡前故事，他們固執地認為天上真的有彩虹橋，真的有文明沉沒深海。\n奧瑞塔喜歡這些故事，她要向更多的夥伴分享這份快樂。"
  },
  Skill_4748_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_4748_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:觸腕傷害> +[TentaclePower:Arg1]。棄掉所有手牌，抽取相同數量+1 的牌。將 1 張「腺體分裂」洗入棄牌堆。"
  },
  Skill_4748_EffectNameList = {
    Text = "觸腕傷害,「腺體分裂」等級"
  },
  Skill_4748_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4749_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4750_AwakerSkillBackgroundStory = {
    Text = "孕育吧，降生吧，繁衍吧。\n在日漸溶解的現實中，在步入昏暗的世界裡，在即將新生的虛空中。\n你們的存在，是母親犧牲的果，是母親存續的因。\n聖潔之子啊，在新世界重生吧——在那無垢的，消弭了所有恐懼的新世界重生吧。"
  },
  Skill_4750_Desc_0 = {
    Text = "泰旖絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 1 張<DerivativeCardKeywords_10:聖潔之子> 。每當釋放鑰令時，將手中一個胚胎轉化為<DerivativeCardKeywords_10:聖潔之子>。"
  },
  Skill_4750_Desc_15 = {
    Text = "泰旖絲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：立刻獲得 1 張<DerivativeCardKeywords_10:聖潔之子> 。每當釋放鑰令時，將手中一個胚胎轉化為<DerivativeCardKeywords_10:聖潔之子>。「豐穰之儀」額外將 1 張複製置入手中。"
  },
  Skill_4750_EffectNameList = {Text = "狂氣"},
  Skill_4750_Name = {
    Text = "目見母親"
  },
  Skill_47516_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，棄掉其他喚醒體的 [Arg1] 張卡牌，若成功棄牌則抽 [Arg2] 張牌。"
  },
  Skill_47516_Name_1 = {
    Text = "銀鱈魚的決心"
  },
  Skill_4751_AwakerSkillBackgroundStory = {
    Text = "別眨眼，仔細瞧，魔法的時刻已來到；\n白手套，黑禮帽，七彩撲克我憑空造。\n如彩帶一般華麗，如亮片一般絢爛，\n這夢幻又瘋狂的閃亮表演，保管你猜不透！"
  },
  Skill_4751_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，抽 [Arg2] 張牌，每抽到 1 張卡茜亞的指令卡就對隨機敵人造成 <Damage:[Damage:Arg1]> 點傷害。使卡茜亞所有基礎傷害提高 [Arg3]%。"
  },
  Skill_4751_Desc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，抽 [Arg2] 張牌，每抽到 1 張症狀卡、狀態卡或卡茜亞的指令卡就對隨機敵人造成 <Damage:[Damage:Arg1]> 點傷害。使卡茜亞所有基礎傷害提高 [Arg3]%。"
  },
  Skill_4751_EffectNameList_0 = {Text = "傷害"},
  Skill_4751_Name = {
    Text = "魔術嘉年華"
  },
  Skill_4751_OverLimitUtlSkillDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg4] 次，抽 [Arg2] 張牌，每抽到 1 張卡西亞的指令卡就對隨機敵人造成 <Damage:[Damage:Arg1]> 點傷害  [Arg4]  次。使卡西亞所有基礎傷害提升 [Arg3]%。之後 [Arg6] 次打出卡西亞的指令卡後，獲得 [Power:Arg5] 點力量。"
  },
  Skill_4751_OverLimitUtlSkillDesc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg4] 次，抽 [Arg2] 張牌，每抽到 1 張症狀卡、狀態卡或卡茜亞的指令卡就對隨機敵人造成 <Damage:[Damage:Arg1]> 點傷害  [Arg4]  次。使卡茜亞所有基礎傷害提高 [Arg3]%。之後 [Arg6] 次打出卡茜亞的指令卡後，獲得 [Power:Arg5] 點力量。"
  },
  Skill_4751_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4752_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4753_AwakerSkillBackgroundStory = {
    Text = "尖刺是敵意，是揮向冒犯者的利刃。"
  },
  Skill_4753_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg3]% 反擊加成。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4753_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg3]% 反擊加成。凱刻斯獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4753_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4753_Name = {Text = "打擊"},
  Skill_4753_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4754_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_4754_Name = {Text = "遺恨"},
  Skill_4755_AwakerSkillBackgroundStory = {
    Text = "彌利亞姆深深相信，這把匕首在無數的典儀中被傾注了神的力量。"
  },
  Skill_4755_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<O07CardKeyWord:祭儀>：使所有敵人臨時降低 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_4755_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。彌利亞姆獲得 <Energy:[Energy:Arg2]> 點狂氣。<O07CardKeyWord:祭儀>：使所有敵人臨時降低 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_4755_EffectNameList = {
    Text = "護盾,狂氣,力量降低"
  },
  Skill_4755_Name = {Text = "防禦"},
  Skill_4755_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4756_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4756_Name = {Text = "試探"},
  Skill_4757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg2] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4758_AwakerSkillBackgroundStory = {
    Text = "她以新的姓名重生於世間，遮掩容貌，不復輪廓。\n流傳於世間的，只有以她的口吻述說的詩篇。\n如此便已足夠。\n詩人不必擁有形貌……他們本應隱形於濃墨之中，書頁之後。"
  },
  Skill_4758_BattleDesc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>，臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:躍遷>：切換至情緒「懼」。"
  },
  Skill_4758_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>，臨時降低所有敵人 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:躍遷>：切換至情緒「懼」。每消耗 1 層隱喻「懼」，額外獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4758_EffectNameList = {
    Text = "力量,力量降低,額外力量"
  },
  Skill_4758_Name = {
    Text = "詭譎詩篇"
  },
  Skill_4758_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4759_AwakerSkillBackgroundStory = {
    Text = "世界上存在著一種特殊的水母，在受傷後，其脫落的組織能再次發育為完整的水螅體。\n「奧瑞塔也會生水母！所以奧瑞塔也是水母！」\n在孩子認知世界的這個階段，還是不要掃她的興吧。"
  },
  Skill_4759_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4759_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。將 [Arg2] 張「腺體分裂」洗入棄牌堆。<RippleKeywords:餘波>：獲得 <Energy:[Energy:Arg3]> 點狂氣。"
  },
  Skill_4759_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4759_Name = {
    Text = "腺體分裂"
  },
  Skill_4759_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4760_AwakerSkillBackgroundStory = {
    Text = "被艾繼絲的玩偶長時間注視的事物，會出現從目光落點開始色彩化、纖維化的情況。一段時間後，該區域甚至會化作類似彩色毛線的物質，被玩偶所吸收。若不及時阻擋目光，被注視事物可能會完全解體，成為玩偶的一部分。\n\n據觀察，僅艾繼絲本人不會受到玩偶目光影響。"
  },
  Skill_4760_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 2 倍力量加成。若目標處於<VulnerabilityIconKeywords:易傷>，返還該牌消耗的算力並抽 1 張牌。"
  },
  Skill_4760_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 2 倍力量加成。若目標處於<VulnerabilityIconKeywords:易傷>，返還該牌消耗的算力並抽 1 張牌。目標每擁有 1 層<VulnerabilityIconKeywords:易傷>，額外使「石質分解」最終傷害提高 [Arg2]%，至多提高 500%。"
  },
  Skill_4760_EffectNameList = {Text = "傷害"},
  Skill_4760_Name = {
    Text = "石質分解"
  },
  Skill_4760_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，棄掉對方所有的手牌。"
  },
  Skill_4761_Name = {Text = "離散"},
  Skill_4762_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 點護盾。前進。"
  },
  Skill_4763_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg2] 倍力量加成，獲得 [Arg3]％ 傷害的<RetaliateIconKeywords:臨時反擊>。"
  },
  Skill_4763_EffectNameList = {Text = "傷害"},
  Skill_4763_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4764_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg2] 倍力量加成。"
  },
  Skill_4764_EffectNameList = {Text = "傷害"},
  Skill_4764_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4765_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_29:症狀：「囈語」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4766_Desc = {
    Text = "降低所有敵人 [Arg2] 點臨時力量，將一張<DerivativeCardKeywords_30:症狀：「休克」>置入手牌。“很痛嗎？真可憐……哭出來就好啦！”"
  },
  Skill_4767_AwakerSkillBackgroundStory = {
    Text = "防守，是為了將這場殺戮盛宴無限延長。畢竟，死人是無法享受任何歡愉的，不是麼？"
  },
  Skill_4767_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4767_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。尤烏哈希獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4767_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4767_Name = {Text = "防禦"},
  Skill_4767_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4768_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4768_Name = {
    Text = "遺恨圍捕"
  },
  Skill_4769_AwakerSkillBackgroundStory = {
    Text = "她的都城是一個不斷膨脹的廢墟。\n夢想在這裡徹底死去，廢墟卻對此一無所知。它只是盡職盡責地膨脹罷了。\n世界早已將它忘卻。"
  },
  Skill_4769_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。可選擇消耗<DreamGuide:夢引>層數觸發<JingjinvwangKeywords1:深眠反擊>或<JingjinvwangKeywords2:囈語回音>，若<DreamGuide:夢引>層數不足 5 層，則獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4769_EffectNameList = {
    Text = "護盾,反擊,深眠反擊獲得狂氣,臨時反擊百分比"
  },
  Skill_4769_Name = {
    Text = "死夢之都"
  },
  Skill_4769_OverLimitUtlSkillDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。無需消耗夢引，同時觸發「<JingjinvwangKeywords3:催眠脈絡>」、「<JingjinvwangKeywords1:深眠反擊>」和「<JingjinvwangKeywords2:囈語回音>」。"
  },
  Skill_4769_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4769_tempBattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。可選擇消耗<DreamGuide:夢引>層數觸發<JingjinvwangKeywords1:深眠反擊>或<JingjinvwangKeywords2:囈語回音>，若<DreamGuide:夢引>層數不足 5 層，則獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4769_tempBattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。無需消耗夢引，同時觸發「<JingjinvwangKeywords3:催眠脈絡>」、「<JingjinvwangKeywords1:深眠反擊>」和「<JingjinvwangKeywords2:囈語回音>」。旺達打出的下 2 張指令卡額外生效 1 次。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。無需消耗夢引，同時觸發「<JingjinvwangKeywords3:催眠脈絡>」、「<JingjinvwangKeywords1:深眠反擊>」和「<JingjinvwangKeywords2:囈語回音>」。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。無需消耗夢引，同時觸發「<JingjinvwangKeywords3:催眠脈絡>」、「<JingjinvwangKeywords1:深眠反擊>」和「<JingjinvwangKeywords2:囈語回音>」。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Counterattack:Arg2] 層<RetaliateIconKeywords:反擊>，本回合下次躍遷效果必定發動。無需消耗夢引，同時觸發「<JingjinvwangKeywords3:催眠脈絡>」、「<JingjinvwangKeywords1:深眠反擊>」和「<JingjinvwangKeywords2:囈語回音>」。旺達打出的下 2 張指令卡額外生效 1 次。"
  },
  Skill_4770_AwakerSkillBackgroundStory = {
    Text = "在索蕾爾的沙龍中，散場前的輪舞是保留項目。\n在酒精與荷爾蒙的邀約下，無論是鄰國王子、宮廷重臣還是近身女侍，都將牽手跳入舞池，縱情狂歡。\n琴聲漸弱，沙龍散場，除了強權與躍出地平線的黎明微光，索蕾爾身邊什麼都沒有留下。"
  },
  Skill_4770_Desc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:無限吞噬>：本次權欲輪舞的傷害次數+[Arg3] ，回復生命值+<Heal:[Heal:Arg6]>。】隨機造成 <Damage:[Damage:Arg2]> 點傷害 [Arg1] 次。回合結束時回復 <Heal:[Heal:Arg4]> 點生命。"
  },
  Skill_4770_EffectNameList_0 = {
    Text = "傷害,回復,無限吞噬回復"
  },
  Skill_4770_EffectNameList_7 = {
    Text = "傷害,回復,每次傷害回復,無限吞噬回復"
  },
  Skill_4770_Name = {
    Text = "權欲輪舞"
  },
  Skill_4770_OverLimitUtlSkillDesc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:無限吞噬>：本次權欲輪舞的傷害次數 +[Arg3] ，回復生命值 +<Heal:[Heal:Arg6]> 點】隨機造成 <Damage:[Damage:Arg2]> 點傷害 [Arg1] 次。回復 <Heal:[Heal:Arg4]> 點生命。使索蕾爾接下來 3 張指令卡生效 2 次。本次狂氣爆發每造成 1 次傷害，回合結束時回復 <Heal:[Heal:Arg5]> 點生命。"
  },
  Skill_4770_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,體質*GrowValue2,體質*GrowValue4"
  },
  Skill_4770_PropertyNameList_7 = {
    Text = "攻擊力*GrowValue1,體質*GrowValue2,體質*GrowValue3,體質*GrowValue4"
  },
  Skill_4771_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，當前生命若低於 25%([Arg3])，回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4771_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，當前生命若低於 25%，回復 <Heal:[Heal:Arg2]> 點生命。"
  },
  Skill_4771_Name = {
    Text = "注射守護"
  },
  Skill_4773_Desc = {
    Text = "向隨機喚醒體施加 1 層臨時封印，重複 2 次。"
  },
  Skill_4774_AwakerSkillBackgroundStory = {
    Text = "她在湖水的中央種下腐敗之物，吸引迷途旅人前往。\n吟遊詩人說：\n就像禮盒掀開一角，奇珍異寶閃耀登場\n就像帷幕掀開一角，纏綿歌聲縱情傳唱"
  },
  Skill_4774_Desc_0 = {
    Text = "獲得 [Counterattack:Arg1] 層<RetaliateIconKeywords:反擊>。使所有敵人臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>，只有一個敵人時力量降低效果提高 50％。<TransitionIconKeywords:躍遷>：消耗 5 層<DreamGuide:夢引>，若成功則額外獲得 [Arg3] 層<RetaliateIconKeywords:反擊>，否則獲得 2 層<DreamGuide:夢引>。"
  },
  Skill_4774_EffectNameList_0 = {
    Text = "反擊,力量降低,額外反擊"
  },
  Skill_4774_EffectNameList_2 = {
    Text = "反擊,力量降低,額外反擊"
  },
  Skill_4774_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4774_PropertyNameList_2 = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4775_Desc = {
    Text = "選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_4775_Name = {
    Text = "高維定向催化"
  },
  Skill_4776_AwakerSkillBackgroundStory = {
    Text = "施與受是主奴關係的關鍵部分。\n主人賞賜給奴隸的，無論是親吻還是鞭笞，奴隸都要滿懷愛意、感激涕零地收下。\n因為你並非真正的奴隸，而是追求快感的享樂者。"
  },
  Skill_4776_Desc_0 = {
    Text = "潘狄婭獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>，潘狄婭每造成 1 次傷害，獲得 [Counterattack:Arg2] 點<RetaliateIconKeywords:反擊>。"
  },
  Skill_4776_Desc_15 = {
    Text = "潘狄娅獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>，潘狄娅每造成 1 次傷害，獲得 [Counterattack:Arg2] 點<RetaliateIconKeywords:反擊>。潘狄娅獲得永久<RetaliateIconKeywords:反擊>時，獲得 [Arg4]％ 等量的力量。"
  },
  Skill_4776_EffectNameList = {
    Text = "狂氣,反擊,造成傷害獲得反擊"
  },
  Skill_4776_Name = {Text = "施與受"},
  Skill_4776_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue3,攻擊力*GrowValue2"
  },
  Skill_4777_AwakerSkillBackgroundStory = {
    Text = "「要殺光，只要是黑色的，就要全部殺光……！不然死的就是我，死的就是我……」"
  },
  Skill_4777_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4777_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。造成的傷害享受 [Arg3]% 反擊加成。"
  },
  Skill_4777_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。溫柯爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4777_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。溫柯爾獲得 <Energy:[Energy:Arg2]> 點狂氣。造成的傷害享受 [Arg3]% 反擊加成。"
  },
  Skill_4777_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_4777_EffectNameList_1 = {
    Text = "傷害,狂氣,反擊加成"
  },
  Skill_4777_Name = {Text = "打擊"},
  Skill_4777_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4777_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,$GrowValue2,$GrowValue3%"
  },
  Skill_4778_AwakerSkillBackgroundStory = {
    Text = "菲茵特不願意離開搖籃，但好在，這搖籃本就和她是一體的——如菲茵特所有同族被孵化前那樣。"
  },
  Skill_4778_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4778_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 50% 傷害的臨時<RetaliateIconKeywords:反擊>。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4778_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。菲茵特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4778_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg3] 次，獲得 50% 傷害的臨時<RetaliateIconKeywords:反擊>。菲茵特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4778_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_4778_Name = {Text = "打擊"},
  Skill_4778_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4780_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4780_Name = {
    Text = "布朗出動！"
  },
  Skill_47818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_47818_Name = {Text = "攻擊"},
  Skill_4781_Desc = {
    Text = "施加 [Arg1] 層<BleedingIconKeywords:出血>。"
  },
  Skill_47820_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_47820_Name = {Text = "攻擊"},
  Skill_4782_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4784_AwakerSkillBackgroundStory = {
    Text = "再怎麼模仿，人類的科技始終無法真正復刻獨屬於▼▼人的技術。彙聚了精神的儀器劇烈抖動，將力量賦予作戰的夥伴，卻不能讓她擺脫這具人工的軀殼。\n曾經如呼吸一樣自然的能力，如今卻再也無法施展了。"
  },
  Skill_4784_Desc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態並獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4784_Desc_3 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態並獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣並使該喚醒體本回合釋放 2 次狂氣爆發後才會進入冷卻。"
  },
  Skill_4784_EffectNameList = {
    Text = "護盾,狂氣,反擊"
  },
  Skill_4784_Name = {
    Text = "無形遷移"
  },
  Skill_4784_OverLimitUtlSkillDesc_0 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態並獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣。使選擇的喚醒體回合開始時獲得 <Energy:[Energy:Arg4]> 點狂氣，持續 3 回合。"
  },
  Skill_4784_OverLimitUtlSkillDesc_3 = {
    Text = "驅散自身<FragileIconKeywords:脆弱>狀態並獲得 <Block:[Block:Arg1]> 點護盾。獲得 [Counterattack:Arg3] 層<RetaliateIconKeywords:反擊>。選擇 1 名其他喚醒體獲得 <Energy:[Energy:Arg2]> 點狂氣並使該喚醒體本回合釋放 2 次狂氣爆發後才會進入冷卻。使選擇的喚醒體回合開始時獲得 <Energy:[Energy:Arg4]> 點狂氣，持續 3 回合。"
  },
  Skill_4784_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_4785_AwakerSkillBackgroundStory = {
    Text = "「別靠近我……就算是為了你們的安全……別靠近我……」"
  },
  Skill_4785_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4785_BattleDesc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和等量的<RetaliateIconKeywords:反擊>。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4785_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。菲茵特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4785_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和等量的<RetaliateIconKeywords:反擊>。菲茵特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4785_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4785_Name = {Text = "防禦"},
  Skill_4785_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4787_Name = {
    Text = "母體搜尋"
  },
  Skill_4788_Desc = {
    Text = "對雙方各造成 [Arg1] 層<VulnerabilityIconKeywords:易傷>。獲得「利刃Ⅲ」：若造成未被格擋的傷害，在抽牌堆頂添加 3 張<DerivativeCardKeywords_23:「傷口」>。持續 1 回合。"
  },
  Skill_4788_Name = {
    Text = "垂死之掙"
  },
  Skill_4789_AwakerSkillBackgroundStory = {
    Text = "沒人說得清為什麼那個鑲嵌了淚滴狀銀芯的小熊玩偶，會在艾繼絲被喚醒後變成這副樣子。這或許與艾繼絲身上的上位者力量有關，或許單純是受到強大精神力量扭曲後產生的變形。\n\n無論如何，它似乎具有一定自我意識，時不時會在艾繼絲不注意的時候剝離出一部分，散成一朵由毛線組成的煙花。"
  },
  Skill_4789_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>。<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]。"
  },
  Skill_4789_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害並施加 [Arg2] 回合的<VulnerabilityIconKeywords:易傷>。<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]。當觸發吞噬後，將「小小願望」從棄牌堆置入手牌並使其算力消耗變為 0 點。"
  },
  Skill_4789_EffectNameList = {
    Text = "傷害,胚胎融合"
  },
  Skill_4789_Name = {
    Text = "小小願望"
  },
  Skill_4789_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_4790_AwakerSkillBackgroundStory = {
    Text = "漆黑的黏液將她拖入深淵。群星在這裡誕生，光線在這裡死去。這裡沒有時間，沒有生命。\n一個聲音從遠處走來，散發著黑色的光。\n它說：你將永遠變得不同，因為你已經造訪妖精的通道。\n她將在這裡漫長地遊蕩。"
  },
  Skill_4790_Desc = {
    Text = "詹金獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：暴擊率提高 [Arg2]% ，詹金每造成 1 次傷害，在本回合中暴擊傷害便提高 [Arg3]%。"
  },
  Skill_4790_EffectNameList = {Text = "狂氣"},
  Skill_4790_Name = {
    Text = "空間折疊"
  },
  Skill_4791_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4792_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4793_AwakerSkillBackgroundStory = {
    Text = "尖銳的荊刺即是最好的防禦。"
  },
  Skill_4793_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4793_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。旺達獲得 <Energy:[Energy:Arg2]> 點狂氣。<TransitionIconKeywords:躍遷>：獲得 1 層<DreamGuide:夢引>。"
  },
  Skill_4793_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_4793_Name = {Text = "防禦"},
  Skill_4793_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4794_Desc = {
    Text = "從「破鏈一擊」「綿長恨怨」「打擊」「防禦」中選擇一張加入手牌並附加<DepleteIconKeywords:消耗>。"
  },
  Skill_4794_Name = {
    Text = "不規則形態"
  },
  Skill_4795_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 2 張<DerivativeCardKeywords_28:「症狀:多疑」>洗入牌庫。"
  },
  Skill_4795_Name = {
    Text = "獵顱詛咒"
  },
  Skill_4796_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_4796_Name = {Text = "深潛"},
  Skill_4797_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4798_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張<DerivativeCardKeywords_23:「傷口」>洗入抽牌堆。"
  },
  Skill_47996_Desc = {
    Text = "選擇 1 個已解鎖的鑰令釋放並使其生效 2 次，每個已解鎖的鑰令在本次探索中只能選擇 1 次，不可選擇初始攜帶的鑰令。"
  },
  Skill_47996_Name = {
    Text = "未至遺忘的黎明"
  },
  Skill_4800_AwakerSkillBackgroundStory = {
    Text = "萊克堅信自己的勝利源於幸運女神的眷顧。\n就像每個最終傾家蕩產的賭徒一樣，他也堅信幸運女神不會移開目光。"
  },
  Skill_4800_Desc_0 = {
    Text = "萊克獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。在本場戰鬥中，獲得一個所選的<C05_zaowu:「混沌的遺贈」>造物，或是將一個已擁有的<C05_zaowu:「混沌的遺贈」>升級。"
  },
  Skill_4800_Desc_15 = {
    Text = "萊克獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。在本場戰鬥中，獲得一個所選的<C05_zaowu:「混沌的遺贈」>造物，或是將一個已擁有的<C05_zaowu:「混沌的遺贈」>升級，該效果連續執行 2 次。萊克的所有六面骰升級為八面骰。"
  },
  Skill_4800_EffectNameList = {
    Text = "狂氣,力量"
  },
  Skill_4800_Name = {
    Text = "絕佳運氣"
  },
  Skill_4800_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_48018_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4802_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_4803_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4804_AwakerSkillBackgroundStory = {
    Text = "火焰蔓延，將劇場的天穹映照成翡翠碧色，彷彿清晨裡澄澈寧靜的湖水。\n多少人曾為追逐這翡翠色的身影而來，又有多少人忽視那流暢而充滿力量感的舞姿，只看見了隱約露出的白玉色胳膊和臆想中的裙下風光。\n而舞者只是如凝固般佇立在那裡，以被綠炎吞噬的瀕死身姿。"
  },
  Skill_4804_Desc_0 = {
    Text = "莉茲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：莉茲每造成 [Arg2] 次傷害，便將 1 張具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「綠炎」>置入手牌，每回合最多觸發 3 次。"
  },
  Skill_4804_Desc_15 = {
    Text = "莉茲獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：莉茲每造成 [Arg2] 次傷害，便將 1 張具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「綠炎」>置入手牌，每回合最多觸發 3 次。莉茲每造成 3 次傷害還會使莉茲本場戰鬥造成的傷害提高 [Arg3] 點。"
  },
  Skill_4804_EffectNameList = {Text = "狂氣"},
  Skill_4804_Name = {
    Text = "翡翠映射"
  },
  Skill_4806_Desc = {
    Text = "獲得 [Arg1] 層<MadnessIconKeywords:瘋狂>。將 [Arg2] 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆。"
  },
  Skill_4806_Name = {Text = "瘋狂"},
  Skill_4807_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，並將其他喚醒體的「打擊」置入手中。來自蘿坦的鼓舞激發了大家的戰意……"
  },
  Skill_4807_Name = {
    Text = "不竭戰意"
  },
  Skill_48084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48085_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 點護盾，洗入 1 張 <DerivativeCardKeywords_45:「維度閉鎖」>到抽牌堆。"
  },
  Skill_48085_Name = {
    Text = "維度防壁"
  },
  Skill_48086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，立刻獲得 2 層<ResentChainsKeywords:怨恨鎖鏈>狀態。"
  },
  Skill_48086_Name = {
    Text = "維度之鎖"
  },
  Skill_4808_AwakerSkillBackgroundStory = {
    Text = "雙手可以握成拳頭，牙齒可以在撕咬的時候造成傷害。\n不要小看落單的士兵，他們身上的每個部位都可以視作一個武器。\n她這麼說著，展開了腿上的刀刃。"
  },
  Skill_4808_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。每點護盾使傷害提高 2 點。在本回合中每打出 1 張「防禦」，算力消耗 -1。視為「打擊」。"
  },
  Skill_4808_EffectNameList = {Text = "傷害"},
  Skill_4808_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4809_Desc = {
    Text = "造成的傷害暴擊率提高 [Arg1]%，暴擊傷害提高 [Arg2]%。"
  },
  Skill_4809_Name = {Text = "暴擊"},
  Skill_4810_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_4811_AwakerSkillBackgroundStory = {
    Text = "落單的老鼠在陰暗的角落裡竄行，它瘦弱、渺小，一把掃帚就能將它輕易驅逐。\n流浪兒也是如此。\n渺小之中亦有力量，當流浪兒與老鼠組成搭檔，她們也可以勢不可擋。"
  },
  Skill_4811_Desc = {
    Text = "將 1 張造成 <Damage:[Damage:Arg1]> 點傷害 X+4 次的<DerivativeCardKeywords_12:「鼠群衝擊」>洗入抽牌堆頂部。<TransitionIconKeywords:躍遷>：額外將 1 張「布朗出動」洗入抽牌堆頂部。"
  },
  Skill_4811_EffectNameList = {
    Text = "「鼠群衝擊」傷害"
  },
  Skill_4811_Name = {
    Text = "集結鼠群"
  },
  Skill_4811_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4812_Desc = {
    Text = "額外享受 2 倍力量加成，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4812_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4813_Name = {
    Text = "無上生祭"
  },
  Skill_4814_Desc = {
    Text = "選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_48151_Desc_1 = {
    Text = "使一名目標獲得 <StrengthenKeywords:行動封鎖>。"
  },
  Skill_48151_Name_1 = {
    Text = "行動封鎖"
  },
  Skill_4815_Desc = {
    Text = "臨時暴擊率 +[Arg1]%。在本場戰鬥中「斷頸一擊」和「千面幻象」的基礎傷害提高 5%。"
  },
  Skill_4815_Name = {
    Text = "暴擊推演"
  },
  Skill_4816_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層再生力：回合結束時回復等同於層數的生命，每失去 5 點生命減少 1 層。"
  },
  Skill_4816_Name = {Text = "深潛"},
  Skill_4817_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得<Block:[Block:Arg3]> 點護盾。前進。"
  },
  Skill_4818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg4] 次，賦予  [Arg2] 張卡牌「深潛印記」：打出後敵人獲得臨時<PowerIconKeywords:力量>。"
  },
  Skill_4818_Name = {
    Text = "深潛標記"
  },
  Skill_4819_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得<Flaw:破綻>：當回合內必定被暴擊。"
  },
  Skill_4819_Name = {
    Text = "鼠群衝擊"
  },
  Skill_4820_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！！"
  },
  Skill_4821_AwakerSkillBackgroundStory = {
    Text = "她的迷宮通往世界的每一個角落。\n密林裡、圖書館地下、海底深處皆有入口。\n依靠那些誤入迷宮的倒楣蛋，她才勉強勾勒出世界的面貌。\n旅人迷失在不斷迴旋的通道裡，她迷失在不斷變幻的故事裡。\n她知曉一切，卻再也無法離開迷宮半步。"
  },
  Skill_4821_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害和等量<IntoxicationIconKeywords:中毒>。每當觸發吞噬時，將「蒼白迴旋」從棄牌堆置入手中。"
  },
  Skill_4821_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害和等量<IntoxicationIconKeywords:中毒>。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。每當觸發吞噬時，將「蒼白迴旋」從棄牌堆置入手中。"
  },
  Skill_4821_EffectNameList_0 = {Text = "傷害"},
  Skill_4821_EffectNameList_3 = {Text = "傷害"},
  Skill_4821_Name = {
    Text = "蒼白迴旋"
  },
  Skill_4821_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4821_PropertyNameList_3 = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_4822_AwakerSkillBackgroundStory = {
    Text = "在無盡的流浪中，汀克特已經遺忘故鄉的名字。\n在漫長的歲月中，宇宙已經遺忘那顆死去星球的名字。\n它和無數被融蝕被遺棄的星球一樣，被統稱為「荒星」。\n她的歌聲，或許是那顆界外星球的最後一縷餘音。"
  },
  Skill_4822_Desc_0 = {
    Text = "汀克特獲得 <Energy:[Energy:Arg1]> 點狂氣，<ExaltIconKeywords:靈知覺醒>：使汀克特的「打擊」基礎傷害提高 [Arg2]%，汀克特的所有牌獲得 1 個隨機效果，該效果將在戰鬥結束時移除。"
  },
  Skill_4822_Desc_15 = {
    Text = "汀克特獲得 <Energy:[Energy:Arg1]> 點狂氣，<ExaltIconKeywords:靈知覺醒>：使汀克特的「打擊」基礎傷害提高 [Arg2]%，汀克特的所有牌獲得 1 個隨機效果，該效果將在戰鬥結束時移除。汀克特每回合首次打出「技能」時生成 1 張算力消耗為 0 的臨時「打擊」，該「打擊」的隨機效果變為 2 倍。"
  },
  Skill_4822_EffectNameList = {Text = "狂氣"},
  Skill_4823_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4823_Name = {Text = "斷念"},
  Skill_4824_AwakerSkillBackgroundStory = {
    Text = "莉茲還記得自己獲得綠炎那天的景象。\n青色的火種在掌心升騰躍動，催促她去達成那壓抑已久的願望。"
  },
  Skill_4824_Desc_0 = {
    Text = "對隨機敵人造成 <Damage:[Damage:Arg2]> 點<PunctureDamagewords:穿刺傷害> [Arg1] 次，施加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。算力不足時可以強行打出，效果改為獲得 <Energy:[Energy:Arg4]> 點狂氣並消耗。"
  },
  Skill_4824_Desc_1 = {
    Text = "對隨機敵人造成 <Damage:[Damage:Arg2]> 點<PunctureDamagewords:穿刺傷害> [Arg1] 次，施加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。回合結束時若在手牌或<DimensionalSpaceIconKeywords:超維空間>，升級為「<DerivativeCardKeywords_20:死滅綠炎>」。算力不足時可以強行打出，效果改為獲得 <Energy:[Energy:Arg4]> 點狂氣並消耗。"
  },
  Skill_4824_EffectNameList = {Text = "傷害"},
  Skill_4824_Name = {
    Text = "腐化綠炎"
  },
  Skill_4824_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4825_AwakerSkillBackgroundStory = {
    Text = "灰色、粘稠、不驅而動、彷彿有生命力的潮水。\n只要被黏上，一定就會被侵染至骨髓吧……\n窺見此物之人，都會產生這樣的感想。"
  },
  Skill_4825_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>並<VulnerabilityIconKeywords:易傷>所有敵人。<TransitionIconKeywords:躍遷>：改為：獲得 [Power:Arg2] 點臨時<PowerIconKeywords:力量>並<VulnerabilityIconKeywords:易傷>所有敵人。"
  },
  Skill_4825_EffectNameList = {
    Text = "力量,臨時力量"
  },
  Skill_4825_Name = {
    Text = "異質潮汐"
  },
  Skill_4825_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4826_Desc = {
    Text = "狀態卡。"
  },
  Skill_4826_Name = {Text = "驚厥"},
  Skill_4827_AwakerSkillBackgroundStory = {
    Text = "「對我們來說，汲取養分就如植物追逐陽光一般自然。」\n菲茵特無法理解同族口中的「追逐陽光」是怎樣一種本能。\n她只知道，一旦將根紮入了獵物的身體，她就無法停下，無法停下，無法停下……"
  },
  Skill_4827_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。使所有敵人臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_4827_EffectNameList = {
    Text = "力量,失去臨時力量"
  },
  Skill_4827_Name = {
    Text = "養分汲取"
  },
  Skill_4827_PropertyNameList = {
    Text = "攻擊力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_4833_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 3 張<DerivativeCardKeywords_36:「褻瀆假像」>加入手中。"
  },
  Skill_4833_Name = {
    Text = "異維瞪視"
  },
  Skill_4835_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4836_AwakerSkillBackgroundStory = {
    Text = "奧吉爾成為預備騎士時，身高尚不及馬背；為了守護而犧牲時，也只勉強能舉起長矛。\n能讓幼小少年刺穿敵人盔甲的，是何等堅定的信念與意志呢？"
  },
  Skill_4836_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg3] 次，施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg3] 次，施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>，享受 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，施加 [Arg2] 回合<VulnerabilityIconKeywords:易傷>，享受 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_EffectNameList = {Text = "傷害"},
  Skill_4836_Name = {
    Text = "穿刺之槍"
  },
  Skill_4836_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_4838_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4838_Name = {
    Text = "癲狂打擊"
  },
  Skill_4839_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4840_AwakerSkillBackgroundStory = {
    Text = "這是本當屬於自我之物，來自螺湮主宰的傳承。\n腐朽之物，接受螺湮逆流的制裁吧。"
  },
  Skill_4840_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg4]% 的<TentacleInjurieIconKeywords:觸腕傷害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。移除 [Arg3]%<SacrificeKeyWord:獻祭>層數。"
  },
  Skill_4840_BattleDesc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg5] 次，每有 2 條觸腕額外造成 1 次傷害，該傷害享受 [Arg4]% 的<TentacleInjurieIconKeywords:觸腕傷害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。移除 [Arg3]% <SacrificeKeyWord:獻祭>層數。"
  },
  Skill_4840_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 [Arg4]% 的<TentacleInjurieIconKeywords:觸腕傷害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。移除 [Arg3]% <SacrificeKeyWord:獻祭>層數。"
  },
  Skill_4840_Desc_1 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，每有 2 條觸腕額外造成 1 次傷害，該傷害享受 [Arg4]% 的<TentacleInjurieIconKeywords:觸腕傷害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。移除 [Arg3]% <SacrificeKeyWord:獻祭>層數。"
  },
  Skill_4840_EffectNameList = {
    Text = "傷害,觸腕傷害加成,移除「獻祭」比例"
  },
  Skill_4840_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2％,$GrowValue3%"
  },
  Skill_4841_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4842_AwakerSkillBackgroundStory = {
    Text = "跨越維度的魔女，熟知維度中的折射規律。\n她清楚維度的每條路徑，每個連接點。\n無限通道，都在她的腦海之中。\n既然如此，投射自其他維度的物質，對她而言自然是囊中之物。"
  },
  Skill_4842_Desc_0 = {
    Text = "達芙黛爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：每有 1 張達芙黛爾的牌進入<DimensionalSpaceIconKeywords:超維空間>後，將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中，每回合最多觸發 2 次。"
  },
  Skill_4842_Desc_15 = {
    Text = "達芙黛爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：每有 1 張達芙黛爾的牌進入<DimensionalSpaceIconKeywords:超維空間>後，將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中，每回合最多觸發 2 次。生成 1 張算力消耗為 0 的臨時「斷頸一擊」置入超維空間。"
  },
  Skill_4842_EffectNameList = {Text = "狂氣"},
  Skill_4842_Name = {
    Text = "維度投射"
  },
  Skill_4843_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將1張<DerivativeCardKeywords_31:「融蝕漿」>洗入抽牌堆。"
  },
  Skill_4844_AwakerSkillBackgroundStory = {
    Text = "等我受到召選，等我潛入深海，等我回歸族群。\n我將享有永恆的安樂，你們這些無知的普通人，休想再欺凌我。\n懷著這樣的憧憬，小小少年沉入幻想的夢鄉。"
  },
  Skill_4844_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。直到下個回合開始，<RetaliateIconKeywords:反擊>和觸腕反擊額外觸發 [Arg2] 次，造成 50% 傷害。獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4844_EffectNameList = {
    Text = "護盾,力量"
  },
  Skill_4844_Name = {
    Text = "逆鱗之護"
  },
  Skill_4844_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4845_AwakerSkillBackgroundStory = {
    Text = "鮮血是與神靈聯結的紐帶。\n神之國土的再臨，註定要以至純至臻的生祭作為基石。"
  },
  Skill_4845_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>並施加等量<IntoxicationIconKeywords:中毒>。<O07CardKeyWord:祭儀>：獲得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_4845_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>並施加等量<IntoxicationIconKeywords:中毒>。臨時暴擊傷害 +[Arg2]%。<O07CardKeyWord:祭儀>：獲得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_4845_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>並施加等量<IntoxicationIconKeywords:中毒>。<O07CardKeyWord:祭儀>：獲得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_4845_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>並施加等量<IntoxicationIconKeywords:中毒>。臨時暴擊傷害提高，數值等同於彌利亞姆原始暴擊傷害的 15%。<O07CardKeyWord:祭儀>：獲得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_4845_EffectNameList = {
    Text = "傷害,力量和觸腕傷害"
  },
  Skill_4845_Name = {
    Text = "無上生祭"
  },
  Skill_4845_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_4846_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4846_Name = {
    Text = "黑泥沖蝕"
  },
  Skill_4847_AwakerSkillBackgroundStory = {
    Text = "迴避不是什麼丟人的事，不如說，正是有了一絲喘息的空間，她才得以推演出對手的行動。"
  },
  Skill_4847_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4847_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。拉蒙娜獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4847_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4847_Name = {Text = "防禦"},
  Skill_4847_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_4848_AwakerSkillBackgroundStory = {
    Text = "讓那些斯巴達人為自己的所作所為付出代價吧。\n你所贈予的並非憐憫，你所剝奪的並非恩賜。\n那是一名心懷憧憬的少女的人生，那是無數希洛人滾燙流淌的血淚。\n復仇者失去的唯有鎖鏈。"
  },
  Skill_4848_Desc_0 = {
    Text = "希洛獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：希洛的卡牌獲得<RetainIconKeywords:保留>，回合結束後，使「破鏈一擊」的打擊加成和「綿長恨怨」基礎傷害提高 10% 。"
  },
  Skill_4848_Desc_15 = {
    Text = "希洛獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：打出時立刻使「破鏈一擊」的打擊加成和「綿長恨怨」的基礎傷害提高 50%，回合結束後，使「破鏈一擊」的打擊加成和「綿長恨怨」基礎傷害提高 10% 。希洛的卡牌獲得<RetainIconKeywords:保留>。"
  },
  Skill_4848_EffectNameList = {Text = "狂氣"},
  Skill_4848_Name = {
    Text = "復仇宣言"
  },
  Skill_4849_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 <Block:[Block:Arg3]> 護盾。"
  },
  Skill_4850_BattleDesc = {
    Text = "此卡牌暴擊率和暴擊傷害提高 50%，造成穿刺傷害。"
  },
  Skill_4850_Desc = {
    Text = "此卡牌暴擊率和暴擊傷害提高 50%，造成穿刺傷害。"
  },
  Skill_4850_Name = {
    Text = "穿刺暴擊"
  },
  Skill_4851_Desc = {
    Text = "將 2 張<DerivativeCardKeywords_4:「靈感」>加入抽牌堆。"
  },
  Skill_4851_Name = {
    Text = "高維靈感"
  },
  Skill_4852_Desc = {
    Text = "獲得  <Posse:[Arg1]>  點銀鑰能量。在本場戰鬥中「斷頸一擊」和「千面幻象」的基礎傷害提高 10%。"
  },
  Skill_4852_Name = {
    Text = "高維鑰能"
  },
  Skill_4853_Desc = {
    Text = "將 [Arg1] 張<DerivativeCardKeywords_80:「窒息」>置入對方手牌。"
  },
  Skill_4853_Name = {
    Text = "溺斃之怨"
  },
  Skill_4854_Desc = {
    Text = "選擇 1 張抽牌堆的卡牌置入手牌並使其算力消耗 -1。"
  },
  Skill_4854_Name = {
    Text = "精算檢索"
  },
  Skill_4855_Desc = {
    Text = "獲得<Block:[Block:Arg1]> 點護盾，自身獲得 [Arg2] 層「蠟質鎧甲」：每層使受到的傷害降低 [Arg3]，每次被暴擊後減少 1 層。"
  },
  Skill_4855_Name = {
    Text = "蠟像登場"
  },
  Skill_4856_AwakerSkillBackgroundStory = {
    Text = "庭院懸鈴木沙沙搖晃，鳥雀啼鳴出春日的頌歌，玫瑰綻放時的芬芳自窄小的天窗柵欄沁入她的鼻腔。\n孤獨的花房之中，繁花入眼，皆是詩篇。"
  },
  Skill_4856_Desc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。其他喚醒體獲得 <Energy:[Energy:Arg3]> 點狂氣，臨時暴擊率和暴擊傷害 +[Arg4]%。在不同情緒下，紛華篇章的對應效果提高 150%。"
  },
  Skill_4856_Desc_3 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。其他喚醒體獲得 <Energy:[Energy:Arg3]> 點狂氣，臨時暴擊率和暴擊傷害 +[Arg4]%。在不同情緒下，紛華篇章的對應效果提高 250%。"
  },
  Skill_4856_EffectNameList = {
    Text = "回復,力量"
  },
  Skill_4856_Name = {
    Text = "紛華篇章"
  },
  Skill_4856_OverLimitUtlSkillDesc_0 = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。其他喚醒體獲得 <Energy:[Energy:Arg3]> 點狂氣，臨時暴擊率和暴擊傷害 +[Arg4]%。在不同情緒下，紛華篇章的對應效果提高 600%。獲得 3 層萬能「隱喻」：會在下次詩篇躍遷時被視為任意情緒的「隱喻」使用並<DepleteIconKeywords:消耗>。"
  },
  Skill_4856_PropertyNameList = {
    Text = "體質*GrowValue1, 攻擊力*GrowValue2"
  },
  Skill_4857_Desc = {
    Text = "額外享受 4 倍力量加成，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_4857_Name = {
    Text = "高維巨力"
  },
  Skill_4857_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_48581_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48581_Name = {
    Text = "扭曲的死體狂宴-混沌"
  },
  Skill_48582_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。額外造成 50% 未被完全格擋部分傷害的 <BleedingIconKeywords:出血>。"
  },
  Skill_48582_Name = {
    Text = "扭曲的死體狂宴-血肉"
  },
  Skill_48583_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使扭曲死體狂宴傷害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_48583_Name = {
    Text = "紛亂切割-躁狂"
  },
  Skill_48584_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 層<RetaliateIconKeywords:反擊>。"
  },
  Skill_48584_Name = {
    Text = "扭曲的死體狂宴-超維"
  },
  Skill_48585_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。額外造成 [Arg3] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_48585_Name = {
    Text = "扭曲的死體狂宴-深海"
  },
  Skill_4858_AwakerSkillBackgroundStory = {
    Text = "女孩懷著不舍離開了破產的水族館，作為工作酬勞，她被允許把幾隻水母帶回家。\n這是她最喜歡的小小生靈，浮遊幻海之靈，生生不息之花。\n只要悉心照料，它們會填滿整個水缸！——她曾經期待著這樣的景象。"
  },
  Skill_4858_Desc_0 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。"
  },
  Skill_4858_Desc_15 = {
    Text = "奧瑞塔獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「腺體分裂」置入手中。奧瑞塔造成傷害時，使 [Arg2] 條觸腕攻擊 1 次。奧瑞塔的「打擊」變為穿刺傷害，並且額外造成 3 次傷害。"
  },
  Skill_4858_EffectNameList = {Text = "狂氣"},
  Skill_48592_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_33:「救救我」>置入手牌。影子「24」 變得暴躁，所有行為都將得到強化，且會開始最猛烈的進攻。"
  },
  Skill_48593_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使扭曲死體狂宴傷害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_48593_Name = {
    Text = "紛亂切割"
  },
  Skill_48595_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48595_Name = {
    Text = "扭曲的死體狂宴"
  },
  Skill_4859_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_4859_Name = {
    Text = "喪鐘遙鳴"
  },
  Skill_48600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48600_Name = {
    Text = "異種共生"
  },
  Skill_4860_Desc = {
    Text = "恐懼，也是一種野獸的本能。"
  },
  Skill_4860_Name = {Text = "受驚"},
  Skill_4861_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_4861_Name = {
    Text = "脆弱打擊"
  },
  Skill_4862_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_4863_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_4863_Name = {
    Text = "獵矛突刺"
  },
  Skill_4864_AwakerSkillBackgroundStory = {
    Text = "哲學是一個沒有正確答案的學科。\n它是一條源自文明起點的河流，在不同的河段，人類向其中傾倒了不同的河水。\n而她正在挖掘屬於自己的河道。\n也許，她在未來某日能夠參透自己的存在本質；也許，這一天永遠不會到來。"
  },
  Skill_4864_Desc_0 = {
    Text = "拉蒙娜獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：拉蒙娜打出卡牌後，獲得 1 點算力，每回合最多觸發 3 次。"
  },
  Skill_4864_Desc_15 = {
    Text = "拉蒙娜獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：拉蒙娜打出卡牌後，獲得 1 點算力並使拉蒙娜造成的基礎傷害提高 10%，每回合最多觸發 3 次。"
  },
  Skill_4864_EffectNameList = {Text = "狂氣"},
  Skill_4864_Name = {
    Text = "第一哲學"
  },
  Skill_4865_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張<DerivativeCardKeywords_3:「驚厥」>洗入抽牌堆。"
  },
  Skill_4865_Name = {Text = "驚厥"},
  Skill_4866_Desc = {
    Text = "自身死亡，其他友方造成等同最大生命的回復。"
  },
  Skill_4866_Name = {Text = "犧牲"},
  Skill_4867_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_4868_Desc = {
    Text = "全體獲得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4868_Name = {
    Text = "全體力量"
  },
  Skill_4869_AwakerSkillBackgroundStory = {
    Text = "「不要不要不要不要過來——」"
  },
  Skill_4869_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4869_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。溫柯爾獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_4869_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_4869_Name = {Text = "防禦"},
  Skill_4869_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_48812_Desc = {
    Text = "當沒有「胚胎」時，可被<DevouredIconKeywords:吞噬>並觸發 2 次效果。直接打出或自動轉化時視為「胚胎」的 1.5 倍效果。"
  },
  Skill_48812_Name = {
    Text = "聖潔之子"
  },
  Skill_48812_tempBattleDesc_1 = {
    Text = "當沒有「胚胎」時，可被<DevouredIconKeywords:吞噬>並觸發 2 次<DevouredIconKeywords:吞噬>效果。直接打出或自動轉化時視為「胚胎」的 1.5 倍效果。"
  },
  Skill_48812_tempBattleDesc_2 = {
    Text = "當沒有「胚胎」時，可被<DevouredIconKeywords:吞噬>並觸發 2 次<DevouredIconKeywords:吞噬>效果。打出後選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。喚醒體每回合首次消耗「胚胎」或「聖潔之子」時，獲得 [Arg3] 層<BreedingKeywords1:繁育庆典>。"
  },
  Skill_48812_tempName_1 = {
    Text = "聖潔之子"
  },
  Skill_48812_tempName_2 = {
    Text = "繁育· 聖潔之子"
  },
  Skill_48813_Desc = {
    Text = "<VulnerabilityIconKeywords:易傷>所有敵人 [Arg1] 回合。"
  },
  Skill_48813_Name = {
    Text = "潰爛之血"
  },
  Skill_48814_Desc = {
    Text = "<WeaknessIconKeywords:虛弱>所有敵人 [Arg1] 回合。"
  },
  Skill_48814_Name = {
    Text = "恐懼之血"
  },
  Skill_48857_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48857_Name = {
    Text = "瘋狂嗜血之爪"
  },
  Skill_48858_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次！獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_48858_Name = {
    Text = "瘋狂狂亂之咬"
  },
  Skill_48859_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48860_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48860_Name = {Text = "強化"},
  Skill_48882_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48883_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48884_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48884_Name = {Text = "強化"},
  Skill_48885_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48885_Name = {Text = "強化"},
  Skill_48893_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48894_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48894_Name = {Text = "強化"},
  Skill_48895_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48896_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48896_Name = {Text = "強化"},
  Skill_48897_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_48898_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_48898_Name = {Text = "強化"},
  Skill_49124_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_49124_Name = {
    Text = "破甲針刺"
  },
  Skill_49125_Desc = {
    Text = "打出後抽 1 張牌。回合結束時若仍在手中，失去 500 點銀鑰能量。"
  },
  Skill_49125_Name = {
    Text = "失語畸變"
  },
  Skill_49126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_49127_Desc = {
    Text = "打出後抽 1 張牌。回合結束時若仍在手中，將 2 張隨機症狀洗入抽牌堆。"
  },
  Skill_49127_Name = {
    Text = "代謝畸變"
  },
  Skill_49128_Desc = {
    Text = "打出後抽 1 張牌。回合結束時若在手中，<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重創>自身 1 回合。"
  },
  Skill_49128_Name = {
    Text = "衰竭畸變"
  },
  Skill_49129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49130_Desc = {
    Text = "打出後抽 1 張牌。回合結束時若仍在手中，所有喚醒體失去 10 點狂氣。"
  },
  Skill_49130_Name = {
    Text = "癡愚畸變"
  },
  Skill_49131_Desc = {
    Text = "打出後抽 1 張牌。回合結束時若仍在手中，將 4 張「傷口」洗入抽牌堆。"
  },
  Skill_49131_Name = {
    Text = "斷肢畸變"
  },
  Skill_49133_Desc = {
    Text = "無止盡繁衍中孼生的不明產物……打出後所有喚醒體獲得 5 狂氣，回合結束後若在手中，自我複製。該卡牌算力消耗最低為1。"
  },
  Skill_49133_Name = {
    Text = "穢亂之子"
  },
  Skill_49215_Desc = {
    Text = "獲得 1 點算力，可以使用 [Arg1] 次。"
  },
  Skill_49216_Desc = {
    Text = "獲得 1 點算力，可以使用 [Arg1] 次。有 50% 機率觸發一個<MysterybuffKeywords:奇妙正面效果>。"
  },
  Skill_49233_Desc = {
    Text = "與最前排的友方交換位置，獲得 [Arg1] 點護盾。"
  },
  Skill_49233_Name = {Text = "掩護"},
  Skill_49234_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易傷>自身 1 回合。"
  },
  Skill_49235_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_49235_Name = {
    Text = "穿心一擊"
  },
  Skill_49236_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。與後排的友方交換位置，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_49236_Name = {
    Text = "蓄勢突襲"
  },
  Skill_49279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使卡組中 1 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49279_Name = {
    Text = "畸變擴散"
  },
  Skill_49280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<BlindingKeywords:致盲>。"
  },
  Skill_49280_Name = {Text = "揚塵"},
  Skill_49281_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_49281_Name = {Text = "千針"},
  Skill_49282_Desc = {
    Text = "獲得 [Arg1] 點護盾及 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_49282_Name = {Text = "禱言"},
  Skill_49288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_49288_Name = {Text = "衝擊"},
  Skill_49289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。目標每有 4 點<PowerIconKeywords:力量>，降低 1 點<PowerIconKeywords:力量>，降低的力量無法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49289_Name = {Text = "黯蝕"},
  Skill_49290_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49290_Name = {
    Text = "血棘噴射"
  },
  Skill_49291_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使卡組中 1 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49291_Name = {
    Text = "污穢降生"
  },
  Skill_49416_Desc = {
    Text = "選擇 1 張手中的非衍生指令卡，獲得一張附加<DepleteIconKeywords:消耗>的原始複製，並使指令卡的所有者獲得 <Energy:[Arg1]> 點狂氣。"
  },
  Skill_49416_Name = {
    Text = "唯一的種子"
  },
  Skill_49434_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_49434_Name = {Text = "衝擊"},
  Skill_49435_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49435_Name = {
    Text = "血棘噴射"
  },
  Skill_49436_Desc = {
    Text = "獲得 [Arg1] 點力量。獲得 50 層<ConcealmentKeywords:隱匿>狀態。召喚 2 只「孳乳·努比亞幼崽」在前排。"
  },
  Skill_49436_Name = {
    Text = "匿蹤呼喚"
  },
  Skill_49437_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使卡組中 2 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49437_Name = {
    Text = "污穢降生"
  },
  Skill_49438_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。目標每有 3 點<PowerIconKeywords:力量>，降低 1 點<PowerIconKeywords:力量>，降低的力量無法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49438_Name = {Text = "黯蝕"},
  Skill_49439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>和<HeavyInjuryKeywords:重創>。若其它怪物均已死亡，意圖立刻切換為「衝擊」。"
  },
  Skill_49439_Name = {
    Text = "匿蹤突襲"
  },
  Skill_49454_Desc = {
    Text = "獲得 [Arg1] 點力量。獲得 75 層<ConcealmentKeywords:隱匿>狀態。召喚 2 只「孳乳·努比亞幼崽」在前排。"
  },
  Skill_49454_Name = {
    Text = "匿蹤呼喚"
  },
  Skill_49455_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將  1 張<DerivativeCardKeywords_44:穢亂之子>加入手中，使卡組中 5 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49455_Name = {
    Text = "邪穢畸生"
  },
  Skill_49456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49456_Name = {
    Text = "血棘噴射"
  },
  Skill_49457_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_49457_Name = {Text = "衝擊"},
  Skill_49458_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將  1 張<DerivativeCardKeywords_44:穢亂之子>加入手中，使卡組中 2 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49458_Name = {
    Text = "污穢降生"
  },
  Skill_49459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>和<HeavyInjuryKeywords:重創>。若其它怪物均已死亡，意圖立刻切換為「衝擊」。"
  },
  Skill_49459_Name = {
    Text = "匿蹤突襲"
  },
  Skill_49460_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虛弱>。目標每有 3 點<PowerIconKeywords:力量>，降低 1 點<PowerIconKeywords:力量>，降低的力量無法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49460_Name = {Text = "黯蝕"},
  Skill_49477_Desc_1 = {
    Text = "棄掉對手所有手牌，給對手 [Arg1] 張鑰令。"
  },
  Skill_49477_Name_1 = {
    Text = "給對手鑰令"
  },
  Skill_49490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。"
  },
  Skill_49491_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態，將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。祈禱：可用來強化技能，受到傷害減少一層，回合結束失去全部。"
  },
  Skill_49491_Name = {
    Text = "鮮血祈禱"
  },
  Skill_49492_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使卡組中 2 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49492_Name = {
    Text = "畸生千針"
  },
  Skill_49493_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每點「祈禱」提高 1 次。每造成 1 次未被格擋的傷害，還會將 1 張<DerivativeCardKeywords_23:「傷口」>洗入抽牌堆，最大為 5 張。"
  },
  Skill_49493_Name = {
    Text = "燈芯長明"
  },
  Skill_49515_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使卡組中 3 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49515_Name = {
    Text = "畸生千針"
  },
  Skill_49516_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使卡組中 3 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_49516_Name = {
    Text = "畸生千針"
  },
  Skill_49517_Desc = {
    Text = "將 2 張<DerivativeCardKeywords_44:穢亂之子>加入手中，立刻在前排召喚 1 只「努比亞」和在後排召喚 2 只「努比亞幼崽」。"
  },
  Skill_49517_Name = {
    Text = "穢亂播撒"
  },
  Skill_49518_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張<DerivativeCardKeywords_9:「蹣跚」> 洗入抽牌堆頂。"
  },
  Skill_49519_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每點「祈禱」提高 1 次。每造成 1 次未被格擋的傷害，還會將 1 張<DerivativeCardKeywords_23:「傷口」>洗入抽牌堆，最大為 5 張。"
  },
  Skill_49519_Name = {
    Text = "燈芯長明"
  },
  Skill_49520_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每點「祈禱」提高 1 次。每造成 1 次未被格擋的傷害，還會將 1 張<DerivativeCardKeywords_23:「傷口」>洗入抽牌堆，最大為 5 張。"
  },
  Skill_49520_Name = {
    Text = "燈芯長明"
  },
  Skill_49521_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態，將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。祈禱：可用來強化技能，受到傷害減少一層，回合結束失去全部。"
  },
  Skill_49521_Name = {
    Text = "鮮血祈禱"
  },
  Skill_49522_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。"
  },
  Skill_49523_Desc = {
    Text = "獲得 [Arg1] 層祈禱狀態，將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。祈禱：可用來強化技能，受到傷害減少一層，回合結束失去全部。"
  },
  Skill_49523_Name = {
    Text = "鮮血祈禱"
  },
  Skill_49530_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張<DerivativeCardKeywords_9:「蹣跚」>洗入抽牌堆頂。"
  },
  Skill_49530_Name = {
    Text = "穿心一擊"
  },
  Skill_49531_Desc = {
    Text = "與最前排的友方交換位置，獲得 [Arg1] 點護盾。"
  },
  Skill_49531_Name = {
    Text = "無畏掩護"
  },
  Skill_49532_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。與後排的友方交換位置。"
  },
  Skill_49532_Name = {
    Text = "蓄勢猛襲"
  },
  Skill_49533_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易傷>自身 1 回合。"
  },
  Skill_49543_Desc = {
    Text = "所有友方獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_49544_Desc = {
    Text = "使亞蘭衛隊長獲得 [Arg1] 護盾。"
  },
  Skill_49544_Name = {Text = "護衛"},
  Skill_49551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，附加<FragileIconKeywords:脆弱> 1 回合。"
  },
  Skill_49551_Name = {
    Text = "癲狂啄食"
  },
  Skill_49552_Desc = {
    Text = "使玩家獲得 5 層<EmptinessKeywords: 空虛>狀態。將 3 張<DerivativeCardKeywords_25:「石頭」>洗入抽牌堆。"
  },
  Skill_49552_Name = {
    Text = "飛沙走石"
  },
  Skill_49553_Desc = {
    Text = "獲得 [Arg3] 點護盾，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_49554_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_49555_Desc = {
    Text = "每回合獲得 [Arg1] 點<PowerIconKeywords:力量>。移除所有喚醒體的所有狂氣。"
  },
  Skill_49556_Desc = {
    Text = "獲得 [Arg3] 點護盾，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加<BlindingKeywords:致盲> 1 回合。"
  },
  Skill_49556_Name = {
    Text = "癲狂鼓翼"
  },
  Skill_49576_Desc = {
    Text = "施加 3 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。獲得 [Arg1] 點護盾和 [Arg2] 點<AlertIconKeywords:戒備>。將 3 張<DerivativeCardKeywords_25:「石頭」>洗入棄牌堆。"
  },
  Skill_49576_Name = {
    Text = "無止境的正義"
  },
  Skill_49577_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_49578_Desc = {
    Text = "每回合獲得 [Arg1] 點力量。立刻獲得 [Arg2] 點<AlertIconKeywords:戒備>。"
  },
  Skill_49578_Name = {
    Text = "戰地卓識"
  },
  Skill_49579_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_49579_Name = {
    Text = "增幅打擊"
  },
  Skill_49580_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，若失去過生命，意圖立刻變為低傷害的「利刃」。"
  },
  Skill_49581_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<AlertIconKeywords:戒備>。"
  },
  Skill_49581_Name = {
    Text = "臨戰體勢"
  },
  Skill_49624_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_44:穢亂之子>加入手中，造成 [Arg1] 點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_49630_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_49630_Name = {Text = "胎動"},
  Skill_49631_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_49631_Name = {Text = "胎動"},
  Skill_49632_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49632_Name = {
    Text = "血棘噴射"
  },
  Skill_49633_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49633_Name = {
    Text = "血棘噴射"
  },
  Skill_49743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_49743_Name = {
    Text = "爆裂猩紅荊棘"
  },
  Skill_49834_Desc_1 = {
    Text = "查看 [Arg1] 張友方隨機「技能」 ，選擇 1 張，將其 [Arg2] 張費用 - [Arg3] 的複製洗入抽牌堆。"
  },
  Skill_49834_Name_1 = {
    Text = "唯一的種子"
  },
  Skill_49834_UnknownName = {
    Text = "唯一的種子"
  },
  Skill_49882_Desc = {
    Text = "從已解鎖的 3 個隨機鑰令中選擇 1 個立刻釋放，並生效 2 次。"
  },
  Skill_49882_Name = {
    Text = "銀鑰曦光"
  },
  Skill_50300_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：抵抗 1 次致死傷害並摧毀此「命輪」，獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>，生效時若為唯一生存友方，使下回合開始時獲得 [Arg2] 張隨機「鑰令」。"
  },
  Skill_50300_Name_1 = {
    Text = "極夜與破曉"
  },
  Skill_50327_Desc_1 = {
    Text = "使一名目標獲得 <DelayKeywords:延遲>：獲得 [Arg1] 隨機鑰令。"
  },
  Skill_50327_Name_1 = {
    Text = "延遲隨機鑰令"
  },
  Skill_50329_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_50329_Name = {Text = "重擊"},
  Skill_50330_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_50330_Name = {Text = "重擊"},
  Skill_50335_Desc = {
    Text = "獲得 [Arg3] 點護盾，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_50340_Desc = {
    Text = "無止盡繁衍中孼生的不明產物……打出後所有喚醒體獲得 5 狂氣，回合結束後若在手中，自我複製。該卡牌算力消耗最低為1。"
  },
  Skill_50340_Name = {
    Text = "穢亂之子"
  },
  Skill_50381_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_50381_Name = {Text = "荊棘"},
  Skill_50382_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_50383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_50383_Name = {
    Text = "猩紅荊棘"
  },
  Skill_50384_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_50388_Desc = {
    Text = "投一顆骰子，根據點數獲得效果。1：<WeaknessIconKeywords:虛弱>所有敵人 1 回合。2：<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。3：對所有敵人造成 [Arg1] 點出血。4：獲得 2 點算力。5：抽 2 張牌。6+：這就是萊克的強運！獲得以上全部效果！"
  },
  Skill_50388_Name = {
    Text = "萊克的幸運骰子"
  },
  Skill_50392_Desc = {
    Text = "抉擇：<DerivativeCardKeywords_50:「單向」> 或  <DerivativeCardKeywords_51:「集結」>"
  },
  Skill_50392_Name = {
    Text = "無饜打擊"
  },
  Skill_50393_Desc = {
    Text = "將 1 名喚醒體的 3 張算力消耗為 0 的「打擊」置入手中，並使其獲得 10 點狂氣。"
  },
  Skill_50393_Name = {Text = "單向"},
  Skill_50394_Desc = {
    Text = "抉擇：<DerivativeCardKeywords_47:「吸附」> 或 <DerivativeCardKeywords_48:「固化」>"
  },
  Skill_50395_Desc = {
    Text = "獲得 30% 最大生命的護盾。"
  },
  Skill_50396_Desc = {
    Text = "抉擇：<DerivativeCardKeywords_53:「蛹化」>或 <DerivativeCardKeywords_54:「蠶食」>"
  },
  Skill_50396_Name = {
    Text = "復甦之繭"
  },
  Skill_50397_Desc = {
    Text = "獲得 [Arg1] 層<PowerIconKeywords:力量>，受到 [Arg2] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_50398_Desc = {
    Text = "獲得 [Arg1] 層臨時<PowerIconKeywords:力量>。"
  },
  Skill_50399_Desc = {
    Text = "將所有喚醒體各 1 張算力消耗為 0 的「打擊」置入手中，並使他們獲得 5 點狂氣。"
  },
  Skill_50399_Name = {Text = "集結"},
  Skill_50492_Desc = {
    Text = "回復 30％ 最大生命，易傷自身 1 回合。"
  },
  Skill_50492_Name = {Text = "集結"},
  Skill_50699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 1 張隨機畸變卡牌加入手中。"
  },
  Skill_50699_Name = {Text = "懲戒"},
  Skill_50700_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>。玩家每打出 1 張牌都會切換該意圖的追加效果。追加效果會在反擊、淨化、植入之間按序切換。"
  },
  Skill_50700_Name = {
    Text = "延續血緣"
  },
  Skill_50701_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，解除自身負面狀態。打出卡牌後，追加效果將切換為植入。"
  },
  Skill_50701_Name = {
    Text = "延續血緣\n淨化"
  },
  Skill_50702_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，將 2 張隨機畸變卡牌加入手中。打出卡牌後，追加效果將切換為反擊。"
  },
  Skill_50702_Name = {
    Text = "延續血緣\n植入"
  },
  Skill_50703_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，玩家每打出 1 張牌都會切換該意圖的追加效果。追加效果會在重擊、回復、弱化之間按序切換。"
  },
  Skill_50704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_50704_Name = {
    Text = "利齒撕咬"
  },
  Skill_50706_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並施加 2 回合的<BlindingKeywords:致盲> 。"
  },
  Skill_50706_Name = {
    Text = "撕裂哀慟"
  },
  Skill_50707_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，額外獲得 [Arg3] 點臨時反擊。打出卡牌後，追加效果將切換為淨化。"
  },
  Skill_50707_Name = {
    Text = "延續血緣\n反擊"
  },
  Skill_50739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 2 回合的 <WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。打出卡牌後，追加效果將切換為重擊。"
  },
  Skill_50740_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，打出卡牌後，追加效果將切換為回復。"
  },
  Skill_50740_Name = {
    Text = "「失序撕咬」重擊"
  },
  Skill_50741_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回復 [Arg3] 點生命。打出卡牌後，追加效果將切換為弱化。"
  },
  Skill_50741_Name = {
    Text = "「失序撕咬」回復"
  },
  Skill_50845_Desc = {
    Text = "選擇 1 張非衍生指令卡，獲得其算力為 0 的原始複製，附加<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_50845_Name = {
    Text = "神聖子嗣"
  },
  Skill_50867_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_51690_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點護盾，每層「孕育」使護盾提高 [Arg4] 點。"
  },
  Skill_51690_Name = {Text = "試探"},
  Skill_51691_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印所有喚醒體，召喚 2 個「利莫里亞的希望」在身前。"
  },
  Skill_51691_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_51692_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張<DerivativeCardKeywords_3:「驚厥」>洗入對方抽牌堆。"
  },
  Skill_51692_Name = {
    Text = "無上生祭"
  },
  Skill_51693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印狂氣最高的喚醒體 1 回合。"
  },
  Skill_51694_Desc = {
    Text = "召喚 1 個「靈覺之子」在身後，每層「孕育」都會使其更強！"
  },
  Skill_51694_Name = {
    Text = "應選之人"
  },
  Skill_51699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印所有喚醒體，召喚 2 個「利莫里亞的希望」在身前。"
  },
  Skill_51699_Name = {
    Text = "利莫里亞的榮光！"
  },
  Skill_51700_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張隨機症狀洗入對方抽牌堆。"
  },
  Skill_51700_Name = {
    Text = "無上生祭"
  },
  Skill_51701_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 1 回合<WeaknessIconKeywords:虛弱>。獲得 [Arg3] 點護盾，每層「孕育」使護盾提高 [Arg4] 點。"
  },
  Skill_51701_Name = {Text = "試探"},
  Skill_51702_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。封印狂氣最高的喚醒體 1 回合。並使其在牌堆中的隨機 [Arg3] 張指令卡獲得 1 層<SlowIconKeywords:遲緩>。"
  },
  Skill_51703_Desc = {
    Text = "回復[Arg5]% 已損失生命，召喚 1 個「靈覺之子」在身後，每層「孕育」都會使回復量和被召喚者更強！"
  },
  Skill_51703_Name = {
    Text = "應選之人"
  },
  Skill_51721_Desc_1 = {
    Text = "造成[Arg1]傷害並 <ComaKeywords:石化>。"
  },
  Skill_51733_AwakerSkillBackgroundStory = {
    Text = "她將在地上以祂的名行事。\n她將得祂應得的美名。\n她將於毀滅之時，承無人可受之痛。\n此即為代行者。"
  },
  Skill_51733_Desc = {
    Text = "彌利亞姆獲得 <Energy:[Energy:Arg3]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：觸腕上限和觸腕數量 +1，對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。將 1 張<O07CardKeyWord5:「信仰的終結」>置入手中。選擇：<CardKeyWord:堅守自我>或<CardKeyWord:投身啟示>。"
  },
  Skill_51733_EffectNameList = {
    Text = "護盾,觸腕傷害,狂氣"
  },
  Skill_51733_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_51734_Desc = {
    Text = "彌利亞姆獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：對所有敵人施加 1 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。觸腕上限和觸腕數量 +1。回合結束時將隨機 1 張「神國幻影」置入手中。"
  },
  Skill_51734_Name = {
    Text = "信仰的終結"
  },
  Skill_51735_Desc = {
    Text = "每個回合開始時獲得 [Power:Arg1] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg1] 點<TentacleInjurieIconKeywords:觸腕傷害>。"
  },
  Skill_51735_EffectNameList = {
    Text = "護盾,觸腕傷害"
  },
  Skill_51735_Name = {
    Text = "投身啟示"
  },
  Skill_51735_PropertyNameList = {
    Text = "防禦力*GrowValue1,攻擊力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_51736_Desc = {
    Text = "每個回合開始時獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_51736_EffectNameList = {Text = "護盾"},
  Skill_51736_Name = {
    Text = "堅守自我"
  },
  Skill_51736_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_51782_Desc = {
    Text = "選擇一名喚醒體使其獲得 [Arg1] 點狂氣。抽 2 張牌。"
  },
  Skill_51782_Name = {
    Text = "神國的呼喚"
  },
  Skill_51783_Desc = {
    Text = "選擇一名喚醒體使其獲得 [Arg1] 點狂氣。<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。"
  },
  Skill_51783_Name = {
    Text = "神國的虔信"
  },
  Skill_51784_Desc = {
    Text = "選擇一名喚醒體使其獲得 [Arg1] 點狂氣。獲得 2 點算力。"
  },
  Skill_51784_Name = {
    Text = "神國的降臨"
  },
  Skill_51814_Desc = {
    Text = "獲得[Arg4] 點<PowerIconKeywords:力量>，召喚一個「睡夢之子」、一個「水之子」、一個「靈覺之子」。「孕育」獲得額外效果：達到 5 層後，立刻召喚 1 個「水之子」。"
  },
  Skill_51814_Name = {Text = "覺醒"},
  Skill_51902_BattleDesc = {
    Text = "回復 10% 已損失生命([Arg1])。可以通過祭儀效果轉化為「執妄」，強化指令卡效果。"
  },
  Skill_51902_Desc = {
    Text = "回復 10% 已損失生命。可以通過<O07CardKeyWord:祭儀>效果轉化為<O07CardKeyWord3:「執妄」>，強化指令卡效果。"
  },
  Skill_51902_Name = {Text = "聖禮"},
  Skill_52055_Desc = {
    Text = "彌利亞姆獲得 [Arg1] 點狂氣。回合結束時若在手中，此卡以下回合抽牌數量 -1 為代價轉化為「聖禮」。"
  },
  Skill_52055_Name = {Text = "執妄"},
  Skill_52076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_52077_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_52077_Name = {Text = "強化"},
  Skill_52078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_52079_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_52079_Name = {Text = "強化"},
  Skill_52094_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_52094_Name = {Text = "強化"},
  Skill_52095_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_52096_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_52096_Name = {Text = "強化"},
  Skill_52097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_52317_Desc = {
    Text = "<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。"
  },
  Skill_52317_Name = {
    Text = "誠摯的朋友"
  },
  Skill_52318_Desc = {
    Text = "抽 2 張牌。"
  },
  Skill_52319_Desc = {
    Text = "獲得 2 點算力。"
  },
  Skill_52319_Name = {
    Text = "溫暖的家庭"
  },
  Skill_52698_Desc = {
    Text = "抽 2 張牌，獲得 2 點算力，所有喚醒體失去 5 點狂氣。若當前處於「靜海」姿態，對所有敵人施加 [Arg1] 層<IntoxicationIconKeywords:中毒>，在首領戰中發揮 3 倍效果。"
  },
  Skill_54041_Desc = {
    Text = "造成雙倍傷害並額外獲得 600% 等同於環行拉蒙娜銀鑰充能的銀鑰能量，但打出後<DepleteIconKeywords:消耗>。"
  },
  Skill_54041_Name = {
    Text = "未來謳歌"
  },
  Skill_54042_Desc = {
    Text = "獲得 3 點算力。"
  },
  Skill_54042_Name = {
    Text = "輪回之庭"
  },
  Skill_54377_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：敵方喚醒體死亡後，獲得 [Arg1] <StrongEffectKeywords:強效>，將其算力消耗最高並附帶<PVPVoidKeywords:虛無>的「技能」置入手中。"
  },
  Skill_54377_Name_1 = {
    Text = "百萬蒙寵之眼"
  },
  Skill_54439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。隨機對 1 名喚醒體對其所有卡牌附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_54439_Name = {
    Text = "融蝕墨染"
  },
  Skill_54440_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_54441_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<BlindingKeywords:致盲>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54442_Desc = {
    Text = "使「致奧爾拉」回覆 已損失生命的 3%。"
  },
  Skill_54442_Name = {Text = "澆灌"},
  Skill_54443_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。隨機對 1 名喚醒體其所有卡牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54444_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<WeaknessIconKeywords:虛弱>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54445_Desc = {
    Text = "召喚 4 名荊棘侍從。對所有卡牌附加<ErosionColorInkKeywords:認知錯亂>。施加 [Arg1] 層衰竭、[Arg2] 層中毒、[Arg3] 層<BleedingIconKeywords:出血>。並<BlindingKeywords:致盲>、<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重創> 99 回合。"
  },
  Skill_54445_Name = {
    Text = "詩中的幻惑樂園"
  },
  Skill_54446_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，移除玩家 50% 的<PowerIconKeywords:力量> 和<RetaliateIconKeywords:反擊>。"
  },
  Skill_54446_Name = {
    Text = "分斷之緣"
  },
  Skill_54447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使抽牌堆隨機 3 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54448_Desc = {
    Text = "獲得 [Arg1] 點護盾， [Arg2] 點<RetaliateIconKeywords:反擊>和 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_54448_Name = {
    Text = "禁絕貪念"
  },
  Skill_54449_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使抽牌堆隨機 3 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54450_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_54451_Desc = {
    Text = "獲得 [Arg1] 點護盾，以及 [Arg2] 點臨時<RetaliateIconKeywords:反擊>和 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_54451_Name = {Text = "貪念"},
  Skill_54452_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆隨機 2 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54453_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54454_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54455_Desc = {
    Text = "使「致奧爾拉」提高 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_54455_Name = {Text = "供養"},
  Skill_54456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚荊棘侍從。使之後貪慾之歌傷害次數提高 1。"
  },
  Skill_54456_Name = {
    Text = "貪慾之歌"
  },
  Skill_54457_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。召喚荊棘侍從。使之後貪慾之歌傷害次數提高 1。"
  },
  Skill_54457_Name = {
    Text = "貪慾之歌"
  },
  Skill_54458_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，並獲得 [Arg3]點護盾，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54460_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54461_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆隨機 2 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_54566_Desc = {
    Text = "選擇任意 1 個已解鎖鑰令釋放。"
  },
  Skill_54566_Name = {
    Text = "超限連結"
  },
  Skill_55481_Desc = {
    Text = "移除超維空間最左側的卡牌，立刻將 1 張「靈感」置入手中。「湮滅」 1 回合只能使用 1 次。"
  },
  Skill_55481_Name = {Text = "湮滅"},
  Skill_55481_tempBattleDesc_1 = {
    Text = "移除超維空間最左側的卡牌，立刻將 1 張「靈感」置入手中。「湮滅」 1 回合只能使用 1 次。"
  },
  Skill_55481_tempBattleDesc_2 = {
    Text = "移除超維空間最左側的卡牌，立刻將 1 張「靈感」置入手中。本回合奧爾拉下一張指令卡觸發躍遷效果。「湮滅」 1 回合只能使用 1 次。"
  },
  Skill_55481_tempBattleDesc_3 = {
    Text = "取出超維空間最左側的卡牌。3 回合冷卻。"
  },
  Skill_55481_tempBattleDesc_4 = {
    Text = "選擇 1 張超維空間的指令卡取出，賦予「打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。3 回合冷卻。"
  },
  Skill_55481_tempBattleDesc_5 = {
    Text = "取出超維空間最左側的卡牌。本回合奧爾拉下一張指令卡觸發躍遷效果。3 回合冷卻。"
  },
  Skill_55481_tempBattleDesc_6 = {
    Text = "選擇 1 張超維空間的指令卡取出，賦予「打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。本回合奧爾拉下一張指令卡觸發躍遷效果。3 回合冷卻。"
  },
  Skill_55481_tempBattleDesc_7 = {
    Text = "選擇 1 張超維空間的指令卡取出，賦予「打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。立刻對所有敵人造成等同於 50％「命運裁斷」的<FixedDamage:純粹傷害>，下次阿拉克涅狂氣爆發造成的傷害強效和護盾提高 50％。3 回合冷卻。"
  },
  Skill_55481_tempBattleDesc_8 = {
    Text = "選擇 1 張超維空間的指令卡取出，賦予「打出後額外生效 1 次」，使下 1 張打出的指令卡觸發<SingularityKeywords3:維度穿梭>。立刻對所有敵人造成等同於 50％「命運裁斷」的<FixedDamage:純粹傷害>，下次阿拉克涅狂氣爆發造成的傷害強效和護盾提高 50％。本回合奧爾拉下一張指令卡觸發躍遷效果。3 回合冷卻。"
  },
  Skill_55802_Name_1 = {Text = "雨頌"},
  Skill_55803_Name_1 = {Text = "花頌"},
  Skill_55804_Name_1 = {Text = "風頌"},
  Skill_56035_Desc = {
    Text = "獲得 [Arg1] 點護盾。"
  },
  Skill_56036_Desc = {
    Text = "回復 [Arg1]% 已損失生命([Arg2])。"
  },
  Skill_56037_Desc = {
    Text = "對所有敵人施加 [Arg1] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_56038_Desc = {
    Text = "對所有敵人施加 [Arg1] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_56038_Name = {Text = "貓"},
  Skill_56039_Desc = {
    Text = "驅散隨機 1 個負面狀態。"
  },
  Skill_56040_Desc = {
    Text = "獲得 [Arg1] 點護盾，若本回合內釋放過 3 次狂氣爆發，此卡額外生效 1 次。"
  },
  Skill_56041_Desc = {
    Text = "回復 [Arg1]% 已損失生命([Arg2])。若當前生命低於 25%([Arg3])，此卡額外生效 1 次。"
  },
  Skill_56042_Desc = {
    Text = "對所有敵人施加 [Arg1] 回合<WeaknessIconKeywords:虛弱>，將一張附加<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虛無>的隨機意象置入棄牌堆。"
  },
  Skill_56043_Desc = {
    Text = "對所有敵人施加 [Arg1] 回合<VulnerabilityIconKeywords:易傷>。每當有敵人死亡時，將此卡從牌堆置入手中。"
  },
  Skill_56043_Name = {Text = "貓"},
  Skill_56044_Desc = {
    Text = "驅散隨機 1 個負面狀態。此卡額外生效 3 次，消耗。"
  },
  Skill_56045_Desc = {
    Text = "獲得 [Arg1] 點算力。"
  },
  Skill_56045_Name = {Text = "太陽"},
  Skill_56046_Desc = {
    Text = "抽 [Arg1] 張牌。"
  },
  Skill_56047_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣。"
  },
  Skill_56048_Desc = {
    Text = "界域精通 +[Arg1] 點，臨時界域精通 +[Arg2] 點。"
  },
  Skill_56048_Name = {Text = "詩句"},
  Skill_56049_Desc = {
    Text = "從抽牌堆和棄牌堆選擇 1 張指令卡置入手中，並使其算力消耗 -2。"
  },
  Skill_56050_Desc = {
    Text = "獲得 [Arg1] 點算力。"
  },
  Skill_56050_Name = {Text = "太陽"},
  Skill_56051_Desc = {
    Text = "抽 [Arg1] 張牌。"
  },
  Skill_56052_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣。"
  },
  Skill_56053_Desc = {
    Text = "臨時界域精通 +[Arg1] 點。"
  },
  Skill_56053_Name = {Text = "詩句"},
  Skill_56054_Desc = {
    Text = "從抽牌堆選擇 1 張指令卡置入手中，並使其算力消耗 -1。"
  },
  Skill_56055_Desc = {
    Text = "獲得 [Arg1] 點銀鑰能量。"
  },
  Skill_56055_Name = {Text = "雲朵"},
  Skill_56056_Desc = {
    Text = "造成等同於自身最大生命值 100% 的<FixedDamage:純粹傷害>（[Arg1]），該傷害享受 5 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_56056_Name = {Text = "風"},
  Skill_56057_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_56058_Desc = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。"
  },
  Skill_56059_Desc = {
    Text = "造成等同於自身最大生命值 150% 的<FixedDamage:純粹傷害>（[Arg1]），該傷害享受 10 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_56059_Name = {Text = "風"},
  Skill_56060_Desc = {
    Text = "下一個鑰令生效 2 次。"
  },
  Skill_56060_Name = {Text = "雲朵"},
  Skill_56061_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。打出後本回合每造成 1 次傷害，臨時暴擊率 +[Arg2]%。"
  },
  Skill_56062_Desc = {
    Text = "獲得 [Arg1] 點臨時<AlertIconKeywords:戒備>。打出後本回合所有喚醒體造成的護盾和回復提高 [Arg2]%。"
  },
  Skill_56144_Desc = {Text = "無用"},
  Skill_56144_Name = {Text = "獻詩"},
  Skill_56155_Desc = {
    Text = "將 1 張造成 <Damage:[Damage:Arg1]> 點傷害 X+10 次的<DerivativeCardKeywords_12:「鼠群衝擊」>洗入抽牌堆頂部。"
  },
  Skill_56155_EffectNameList = {
    Text = "「鼠群衝擊」傷害"
  },
  Skill_56155_Name = {
    Text = "超級大集結！"
  },
  Skill_56155_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_56199_Desc = {
    Text = "回復 <Heal:[Arg1]> 點生命。"
  },
  Skill_56199_Name = {Text = "雨頌"},
  Skill_56200_Desc = {
    Text = "臨時暴擊率 +[Arg1]%。"
  },
  Skill_56200_Name = {Text = "月頌"},
  Skill_56201_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_56201_Name = {Text = "風頌"},
  Skill_56202_Desc = {
    Text = "從四種<D06CardKeeperSkill:詩頁>中選擇一項，並將其從選項中移除。所有詩頁都被選擇後，重置。"
  },
  Skill_56202_Name = {
    Text = "春天的獻詩"
  },
  Skill_56203_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣。"
  },
  Skill_56203_Name = {Text = "花頌"},
  Skill_56370_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，立刻獲得 2 層<ResentChainsKeywords:怨恨鎖鏈>狀態。"
  },
  Skill_56370_Name = {
    Text = "維度之鎖"
  },
  Skill_56371_Desc = {
    Text = "全體獲得[Arg1] 點<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 點護盾，洗入 1 張 <DerivativeCardKeywords_45:「維度閉鎖」>到抽牌堆。"
  },
  Skill_56371_Name = {
    Text = "維度防壁"
  },
  Skill_57140_Desc = {
    Text = "召喚兩名「冷冽之靈」，所有友方獲得 [Arg1] 點 <CardKeyWord:霜盾>。"
  },
  Skill_57140_Name = {
    Text = "冷冽之靈"
  },
  Skill_57141_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。凍結抽牌堆頂部 1 張指令卡。"
  },
  Skill_57338_AwakerSkillBackgroundStory = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  Skill_57338_Desc_0 = {
    Text = "將 3 張基礎傷害提升 400%，算力消耗為 0 的<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，獲得等同於 [Arg1]% 觸腕傷害的臨時<PowerIconKeywords:力量>。"
  },
  Skill_57338_Desc_3 = {
    Text = "將 3 張基礎傷害提高 400%，算力消耗為 0 的<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，獲得等同於 [Arg1]% 觸腕傷害的臨時<PowerIconKeywords:力量>。戈利亞獲得 [Arg2]% 臨時暴擊率。"
  },
  Skill_57338_EffectNameList = {
    Text = "觸腕傷害百分比"
  },
  Skill_57338_Name = {Text = "篡奪"},
  Skill_57339_AwakerSkillBackgroundStory = {
    Text = "當他舉起巨劍，帶來的必然是鮮血與死亡。"
  },
  Skill_57339_Desc_0 = {
    Text = "將 2 張「斬首重創」置入手牌，並使它們獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords:預備1>和<RetainIconKeywords:保留>。使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提升 25%。"
  },
  Skill_57339_Desc_3 = {
    Text = "將 2 張「斬首重創」置入手牌，並使它們獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords:預備1>和<RetainIconKeywords:保留>。使「巨刃之威」和「斬首重創」基礎傷害在本場戰鬥中提高 25%。戈利亞獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_57339_Name = {Text = "蟄伏"},
  Skill_57342_AwakerSkillBackgroundStory = {
    Text = "由整塊精鐵打造的利刃無比沉重，破空之時帶起的氣流甚至可以震碎岩石。\n我忠誠的夥伴，我可靠的巨刃啊，我們皆於黑暗中獲得新生與無窮力量。今夜，我們將痛飲仇敵之血；今夜，我們將盡情殺戮。"
  },
  Skill_57342_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害。<PowerIconKeywords:力量>在「巨刃之威」上發揮 [Arg2] 倍效果。此卡視為「打擊」。"
  },
  Skill_57342_EffectNameList = {Text = "傷害"},
  Skill_57342_PropertyNameList = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_57550_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將「回答塔薇」置入手中。"
  },
  Skill_57550_Name = {
    Text = "真理問詢"
  },
  Skill_57551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並施加 10% 傷害的<IntoxicationIconKeywords:中毒>和等量傷害的<BleedingIconKeywords:出血>。"
  },
  Skill_57551_Name = {
    Text = "深淵之視"
  },
  Skill_57552_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_57553_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。複製自身的負面狀態，將其添加給目標。"
  },
  Skill_57554_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> 2 回合。使 5 張卡牌附加「侵蝕」1 回合。"
  },
  Skill_57554_Name = {Text = "侵蝕"},
  Skill_57555_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，移除 15％ 的<PowerIconKeywords:力量>和<RetaliateIconKeywords:反擊>並獲得等量的臨時<PowerIconKeywords:力量>和臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_57555_Name = {
    Text = "掠奪之雙翼"
  },
  Skill_57556_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易傷> 1 回合。"
  },
  Skill_57557_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。雙子融合度 +15%。"
  },
  Skill_57558_Desc = {
    Text = "<WeaknessIconKeywords:虛弱>和<BlindingKeywords:致盲> 2 回合。獲得 [Arg1] 點護盾和 [Arg2] 點<PowerIconKeywords:力量>，並清除自身負面狀態。"
  },
  Skill_57558_Name = {
    Text = "「矛盾」銀輝"
  },
  Skill_57568_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張「逐漸遺忘」置入手中。<WeaknessIconKeywords:虛弱> 2 回合。"
  },
  Skill_57568_Name = {Text = "忘卻"},
  Skill_57661_Desc = {
    Text = "回復 1 層神母權能，神母權能可被消耗觸發墨菲的其他能力，最多回復至 3 層。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_57662_Desc = {
    Text = "消耗 1 層神母權能，獲得 [Arg2] 點力量，所有喚醒體獲得 [Arg3] 點狂氣。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_57662_Name = {
    Text = "刎頸，以行威儀"
  },
  Skill_57663_Desc = {
    Text = "消耗 1 層神母權能，<WeaknessIconKeywords:虛弱>全體敵人 1 回合，獲得 [Arg2] 點護盾並回復等量生命，隨損失生命提高，最高為 2 倍。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_57663_Name = {
    Text = "犧牲，以敬自由"
  },
  Skill_57664_Desc = {
    Text = "消耗 1 層神母權能，<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，本回合所有喚醒體造成的傷害提高 25%。獲得 1 點算力和抽 1 張牌。（當前還剩 [Arg1] 層神母權能）"
  },
  Skill_57664_Name = {
    Text = "呵斥，以報恩仇"
  },
  Skill_57668_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張「融蝕之芯」置入抽牌堆。"
  },
  Skill_57669_Desc = {
    Text = "添加「霧盾」，轉化為「遺忘的伊始」。"
  },
  Skill_57669_Name = {
    Text = "強行融合"
  },
  Skill_57670_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_57670_Name = {Text = "棄用"},
  Skill_57671_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。分裂為「暗之子」和「光之子」，每 1% 融合度就使「光之子」生命減少 0.5%。"
  },
  Skill_57699_Desc = {
    Text = "全體目標獲得 2 層<ParcloseIconKeywords:屏障>，自身額外獲得 5 層。"
  },
  Skill_57754_AwakerSkillBackgroundStory = {
    Text = "柔和的海風中她陷入沉睡，卻被振翅的聲音驚醒。一隻通體雪白的小鳥掠過她的頭頂，消失在同樣雪白的雲朵之中。\n那一定是夢吧，在這遠離陸地的大洋深處，怎麼會有落單的飛鳥呢？\n她這麼想著，卻無法自已地感到一種希冀，一種嚮往。"
  },
  Skill_57754_Desc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命。獲得 [Arg2] 點算力並驅散手牌<SlowIconKeywords:遲緩>狀態。每<RetainIconKeywords:保留> 1 回合，下次打出時額外回復 <Heal:[Arg3]> 點生命。激發 1 條觸腕攻擊敵人，造成 [Arg4]％ 觸腕傷害。"
  },
  Skill_57754_EffectNameList_0 = {Text = "回復"},
  Skill_57754_EffectNameList_2 = {
    Text = "回復,額外回復"
  },
  Skill_57754_Name = {
    Text = "純白夢境"
  },
  Skill_57754_PropertyNameList_0 = {
    Text = "體質*GrowValue1,"
  },
  Skill_57754_PropertyNameList_2 = {
    Text = "體質*GrowValue1,體質*GrowValue2"
  },
  Skill_57760_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，扣除 <Energy:[Energy:Arg1]> 狂氣轉換為<PVPDerivativeCardKeywords_12:「小小心願」>，若轉換失敗則獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_57761_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：每回合首次「狂氣爆發」後臨時<StrongEffectKeywords:強效> +[Arg1]。"
  },
  Skill_57762_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] 層<PVPSleepKeywords:精緻睡眠>。"
  },
  Skill_57763_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」傷害提高 [Arg1]%。「狂氣爆發」後恢復自身已損生命的 [Arg2]%。"
  },
  Skill_57764_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」造成的傷害、治療與護盾效果提升 [Arg1]~[Arg2]％，"
  },
  Skill_57764_Name_1 = {
    Text = "命運輪盤賭"
  },
  Skill_57765_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：打出裝備者的技能卡後，抽 1 張裝備者的技能卡，每回合至多生效 1 次。"
  },
  Skill_57765_Name_1 = {
    Text = "真理之門"
  },
  Skill_57805_Desc = {
    Text = "每回合獲得一個極夜微光。"
  },
  Skill_57807_Desc = {
    Text = "使用拉蒙娜留下的溯洄之力，回到戰鬥開始。"
  },
  Skill_57807_Name = {
    Text = "拉蒙娜最終支援回溯"
  },
  Skill_57808_Desc = {
    Text = "哈姆林休息 2 回合。之後所有支援效果的使用次數 +1。"
  },
  Skill_57809_Desc = {
    Text = "降低雙子融合度 10%。本回合每釋放 1 次狂氣爆發，額外降低雙子融合度 3%。還可使用 [Arg1] 次。"
  },
  Skill_57810_Desc = {
    Text = "本回合造成的傷害、中毒、反擊提高 25%。還可使用 [Arg1] 次。"
  },
  Skill_57811_Desc = {
    Text = "獲得 3 點算力，抽 3 張牌。本回合每打出 1 張指令卡，所有喚醒體獲得 1 點狂氣。還可使用 [Arg1] 次。"
  },
  Skill_57811_Name = {Text = "協奏曲"},
  Skill_57812_Desc = {
    Text = "滿狀態復活，回憶起一切卡牌和三大質體，並獲得 5 張「極夜微光」。"
  },
  Skill_57812_Name = {
    Text = "拉蒙娜最終支援"
  },
  Skill_57859_Desc = {
    Text = "投一顆 [Arg2] 面骰子，獲得等同於骰子點數*[Arg1] 的臨時<PowerIconKeywords:力量>，若點數為 4 或更高，<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。若點數為 6 或更高，則獲得的臨時<PowerIconKeywords:力量>翻倍並獲得 1 點算力。"
  },
  Skill_57859_Name = {
    Text = "閃耀偏方骰子"
  },
  Skill_57860_Desc = {
    Text = "投一顆 [Arg2] 面骰子，獲得等同於骰子點數*[Arg1] 的臨時<PowerIconKeywords:力量>，若點數為 4 或更高，<VulnerabilityIconKeywords:易傷>所有敵人 1 回合。若點數為 6 或更高，則獲得的臨時<PowerIconKeywords:力量>翻倍。"
  },
  Skill_57887_Desc = {
    Text = "當前生命和生命上限提高 [Arg1] 點。添加「霧盾」，轉化為「完全的遺忘之理」。"
  },
  Skill_57888_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。分裂為「暗之子」和「光之子」，「光之子」生命減少 75%，並永久眩暈。"
  },
  Skill_57888_Name = {
    Text = "融蝕分形"
  },
  Skill_57892_Desc = {
    Text = "將 3 張「<DerivativeCardKeywords_1:遺影迴響>」置入手中，選擇後移除該選項。"
  },
  Skill_57892_Name = {
    Text = "尋找前路"
  },
  Skill_57893_Desc = {
    Text = "獲得上回合最後打出 3 張不同指令卡的原始消耗複製，其算力消耗為 0，將「<DerivativeCardKeywords_39:過往回聲>」置入手中，選擇後移除該選項。"
  },
  Skill_57893_Name = {
    Text = "回憶過往"
  },
  Skill_57894_Desc = {
    Text = "將「<DerivativeCardKeywords_67:銀鑰曦光>」和「<DerivativeCardKeywords_41:銀鑰共鳴>」置入手中，選擇後移除該選項。"
  },
  Skill_57894_Name = {
    Text = "握緊銀鑰"
  },
  Skill_57895_Desc = {
    Text = "返還因「融蝕之芯」失去的力量、反擊、生命上限。獲得 5 點算力，所有喚醒體獲得 100 狂氣。將所有的<DerivativeCardKeywords_38:幻覺>還原。"
  },
  Skill_57895_Name = {
    Text = "最初的連結"
  },
  Skill_57947_Desc = {
    Text = "降低敵人 10% 生命上限。生成 1 條觸腕，獲得 [Arg1] 點臨時觸腕傷害。"
  },
  Skill_57947_Name = {
    Text = "王權之威"
  },
  Skill_57949_Desc = {
    Text = "驅散自身 <WeaknessIconKeywords:虛弱> 和力量降低狀態。獲得 [Arg1] 點臨時觸腕傷害。"
  },
  Skill_57949_Name = {
    Text = "螺湮重臨"
  },
  Skill_57950_Desc = {
    Text = "造成合計 [Arg1] 點傷害 1 次。每有 1 條觸腕就使得傷害提高 [Arg3] 點。"
  },
  Skill_57950_Name = {
    Text = "深淵號令"
  },
  Skill_57951_Desc = {
    Text = "獲得「震怒」、12 層「困意」以及 [Arg1] 點觸腕傷害。"
  },
  Skill_57951_Name = {
    Text = "不朽威儀"
  },
  Skill_57969_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 2 張「融蝕之芯」置入抽牌堆。"
  },
  Skill_57969_Name = {
    Text = "遺忘乃新生之始"
  },
  Skill_57971_Desc = {
    Text = "增加雙子融合度 30%。"
  },
  Skill_57972_Desc = {
    Text = "降低雙子融合度 30%。"
  },
  Skill_58044_Desc = {
    Text = "使「肆意豪賭」和「攤牌時刻」的基礎傷害永久提高 25%。"
  },
  Skill_58044_Name = {
    Text = "莊家通吃"
  },
  Skill_58288_Desc = {
    Text = "將 1 枚<C05_yansheng2:閃耀偏方骰子>置入手中，獲得 [Arg1]% 臨時暴擊率。"
  },
  Skill_58288_Name = {
    Text = "一聲槍響"
  },
  Skill_58494_Desc = {
    Text = "ZzzzzzzzzzZZZZZZZZZZZZZZ……"
  },
  Skill_58495_Desc = {
    Text = "提高 [Arg1] 點觸腕傷害。"
  },
  Skill_58495_Name = {Text = "囈語"},
  Skill_58933_AwakerSkillBackgroundStory = {
    Text = "下降，下降，疲憊的旅人將要返航。 讓音符輕撫你的靈魂，放下一切痛苦與執念，安然進入寧靜夢鄉。"
  },
  Skill_58933_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_58933_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>，若其觸發「樂音」效果，獲得的臨時<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58933_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。哈姆林獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_58933_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。哈姆林獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>，若其觸發「樂音」效果，獲得的臨時<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58933_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_58933_Name = {Text = "防禦"},
  Skill_58933_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_58939_AwakerSkillBackgroundStory = {
    Text = "升高，升高，繃緊你的船帆，我們要向著遠方啟航。 號角為你吹響，群鳥隨你飛翔，要越過那最高的浪濤。"
  },
  Skill_58939_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_58939_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。若其觸發「樂音」效果，獲得的臨時<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58939_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。哈姆林獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_58939_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。哈姆林獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Power:Arg3] 點臨時<PowerIconKeywords:力量>。若其觸發「樂音」效果，獲得的臨時<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58939_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_58939_Name = {Text = "打擊"},
  Skill_58939_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_59159_Desc_1 = {
    Text = "使一名目標獲得 <StrongEffectKeywords:強效> 。"
  },
  Skill_59159_Name_1 = {Text = "強效"},
  Skill_59191_Name = {
    Text = "極夜微光"
  },
  Skill_59428_Desc_1 = {
    Text = "使一名目標獲得 <ReduceEffectKeywords:強效降低> 。"
  },
  Skill_59428_Name_1 = {
    Text = "強效降低"
  },
  Skill_59476_AwakerSkillBackgroundStory = {
    Text = "在聽聞此曲前，你從未真正擁有耳朵。 在聽聞此曲後，你再也找不到這樣的聲音。 所以請全神貫注、屏息凝神，盡情稱頌這一生難得的樂曲吧！"
  },
  Skill_59476_Desc_0 = {
    Text = "哈姆林獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時，將一張「<DerivativeCardKeywords_64:協樂的交響>」置入手中<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_Desc_15 = {
    Text = "哈姆林獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時，將一張「<DerivativeCardKeywords_64:協樂的交響>」置入手中。回合開始時，每有 1 張擁有「樂音」的指令卡，哈姆林獲得 <Energy:[Energy:Arg2]> 點狂氣。釋放「原初的樂音」時，每存在 2 張指令卡擁有樂音，傷害次數+1<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_EffectNameList = {Text = "狂氣"},
  Skill_59476_Name = {
    Text = "此曲應得稱頌"
  },
  Skill_59477_AwakerSkillBackgroundStory = {
    Text = "音樂從哪裡誕生？ 從悅神的祭禮，從農夫的號子，從原始人的嚎叫，從春日的鶯啼，從松風與海浪，從大地的震顫和山峰的崩落…… 還是從天地混沌中，神明夢中的囈語。"
  },
  Skill_59477_BattleDesc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg3] 次、每造成 1 次傷害臨時降低目標 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>並獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量>。選擇手中 1 張不具有「樂音」的非消耗且非衍生的指令卡添加「<HuihuanaKeywords:回環樂音>」。每次若沒有手牌可被添加、改為額外造成 3 次傷害。"
  },
  Skill_59477_BattleDesc_2 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg3] 次、每造成 1 次傷害臨時降低目標 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>並獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量>。選擇手中 1 張不具有「樂音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回環樂音>」。每次若沒有手牌可被添加、改為額外造成 3 次傷害。"
  },
  Skill_59477_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次、每造成 1 次傷害<TouquKeywords:竊取>目標 [Arg2] 點<PowerIconKeywords:力量>。選擇手中 1 張不具有「樂音」的非消耗且非衍生的指令卡添加「<HuihuanaKeywords:回環樂音>」。每次若沒有手牌可被添加、改為額外造成 3 次傷害。"
  },
  Skill_59477_Desc_2 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次、每造成 1 次傷害<TouquKeywords:竊取>目標 [Arg2] 點<PowerIconKeywords:力量>。選擇手中 1 張不具有「樂音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回環樂音>」。每次若沒有手牌可被添加、改為額外造成 3 次傷害。"
  },
  Skill_59477_EffectNameList = {
    Text = "傷害,偷取力量"
  },
  Skill_59477_Name = {
    Text = "原初的樂音"
  },
  Skill_59477_OverLimitUtlSkillDesc = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg3] 次、每造成 1 次傷害臨時降低目標 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>、獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量>、對目標隨機施加 1 種<MysterydebuffKeywords:奇妙負面效果>。選擇手中 2 張不具有「樂音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回環樂音>」。每次若沒有手牌可被添加、改為額外造成 3 次傷害。"
  },
  Skill_59477_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_59478_AwakerSkillBackgroundStory = {
    Text = "如果靈魂能夠拆分，構成它的是否將是音符。 高與低、快與慢，新生的啼哭與死亡的哀嚎一同奏響。 請聽吧，請高聲和唱，這描摹你靈魂樣貌的序章。"
  },
  Skill_59478_BattleDesc = {
    Text = "隨機造成 [Arg2] 次 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，每次造成傷害都有 50% 機率對目標隨機施加 1 種<MysterydebuffKeywords:奇妙負面效果>。若打出時算力消耗為 0，額外造成 2 次傷害。"
  },
  Skill_59478_Desc = {
    Text = "隨機造成 3 次 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，每次造成傷害都有 50% 機率對目標隨機施加 1 種<MysterydebuffKeywords:奇妙負面效果>。若打出時算力消耗為 0，額外造成 2 次傷害。"
  },
  Skill_59478_EffectNameList = {Text = "傷害"},
  Skill_59478_Name = {
    Text = "靈魂序曲"
  },
  Skill_59478_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_59479_AwakerSkillBackgroundStory = {
    Text = "你聽過這樣的樂音嗎？ 它是那樣熟悉、親切，讓你回想起一生的餘韻。 到底在哪裡曾聽過呢？ 在你的夢中，在你的回憶中，或是在臨死前天國的召喚中，由那吹笛的天使輕柔奏響。"
  },
  Skill_59479_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。將 2 張<DerivativeCardKeywords_4:「靈感」>置入手中。算力不足時仍可強行打出，效果改為將 2 張「靈感」洗入抽牌堆。"
  },
  Skill_59479_Name = {
    Text = "追憶迴旋曲"
  },
  Skill_59479_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_59490_Desc = {
    Text = "你打出的下一張非衍生指令卡算力消耗 +2，生效 2 次。"
  },
  Skill_59491_Desc = {
    Text = "你打出的下一張非衍生指令卡算力消耗 -2。"
  },
  Skill_59665_Desc = {
    Text = "戰鬥結束後仍會保存在牌庫中。你已經被警衛發現了……"
  },
  Skill_59665_Name = {Text = "警覺"},
  Skill_59735_Desc = {
    Text = "全體目標回復 15% 已損失生命。"
  },
  Skill_59735_Name = {Text = "聖愈"},
  Skill_59736_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> 2 回合。使所有卡牌附加「侵蝕」1 回合。"
  },
  Skill_59736_Name = {
    Text = "萬物侵蝕"
  },
  Skill_59737_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 1 張「逐漸遺忘」置入手中。<WeaknessIconKeywords:虛弱> 2 回合。將 2 張<DerivativeCardKeywords_38:幻覺>塞入抽牌堆。"
  },
  Skill_59737_Name = {
    Text = "永恆忘卻"
  },
  Skill_59738_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。將 1 張「融蝕之芯」置入抽牌堆。<HeavyInjuryKeywords:重創> 2 回合。"
  },
  Skill_59738_Name = {Text = "毀滅"},
  Skill_59739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。將 1 張「融蝕之芯」置入抽牌堆。<HeavyInjuryKeywords:重創> 2 回合。"
  },
  Skill_59739_Name = {
    Text = "覆亡毀滅"
  },
  Skill_59740_Desc = {
    Text = "全體目標移除<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<HeavyInjuryKeywords:重創>狀態，降低它們 25% <IntoxicationIconKeywords:中毒>。"
  },
  Skill_59740_Name = {Text = "淨化"},
  Skill_59866_Desc = {
    Text = "移動至後方，進入「混沌降臨」狀態並使「混沌」層數恢復至上限。若場上存在「N」的分身，為其添加 5 層屏障，之後將分身召喚至上限。若已擁有 3 層「黑暗」，額外使自身獲得 1 層瘋狂。"
  },
  Skill_59866_Name = {
    Text = "混沌降臨"
  },
  Skill_59867_Desc = {
    Text = "造成 [Arg1] 點傷害 [Arg2] 次，將 1 張「驚厥」洗入玩家棄牌堆。場上每存在一個「呢喃」的分身，額外洗入 1 張。"
  },
  Skill_59867_Name = {
    Text = "無言恐懼"
  },
  Skill_60001_Desc = {
    Text = "獲得 1 層<MadnessIconKeywords:瘋狂>。對手失去 [Arg1] 點臨時<PowerIconKeywords:力量>。"
  },
  Skill_60002_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，未被完全格擋的部分會造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_60003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_60025_Desc = {
    Text = "將牌堆中 3 張卡牌算力消耗變為 3。"
  },
  Skill_60025_Name = {Text = "啼鳴"},
  Skill_60026_Desc = {
    Text = "造成 1 回合的 <WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱> 和 <HeavyInjuryKeywords:重創>。"
  },
  Skill_60027_Desc = {
    Text = "自身死亡，造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，使 4 張卡牌產生<AberrationKeywords:畸變>。"
  },
  Skill_60027_Name = {Text = "尾針！"},
  Skill_60039_Desc = {
    Text = "查看 3 個未攜帶的鑰令，選擇 1 個立即釋放。獲得 1 點算力，驅散自身<IntoxicationIconKeywords:中毒>、封印、<SlowIconKeywords:遲緩>狀態。"
  },
  Skill_60039_Name = {
    Text = "烏托邦帷幕"
  },
  Skill_60040_Desc = {
    Text = "棄掉所有手牌，抽取棄牌數 +3 張牌。"
  },
  Skill_60040_Name = {
    Text = "畸變之心"
  },
  Skill_60041_Desc = {
    Text = "選擇一名喚醒體使其獲得 [Arg1] 點狂氣。"
  },
  Skill_60041_Name = {
    Text = "天真的回禮"
  },
  Skill_60042_Desc = {
    Text = "獲得 [Arg1] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_60047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_60048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，狂氣最高的喚醒體失去 50% 狂氣。"
  },
  Skill_60048_Name = {
    Text = "狂氣竊取"
  },
  Skill_60060_Desc = {
    Text = "回復 [Arg1]% 生命。場上每存在一個正在「低語」的分身，額外回復 [Arg2]% 已損生命。"
  },
  Skill_60060_Name = {
    Text = "暗色侵蝕"
  },
  Skill_60071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，召喚 [Arg3] 只「搜查貓」在前方，自身生命越低召喚的寵物越強大。"
  },
  Skill_60071_Name = {Text = "豢養"},
  Skill_60072_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，召喚 [Arg3] 只「搜查貓」在前方，自身生命越低召喚的寵物越強大。"
  },
  Skill_60072_Name = {Text = "豢養"},
  Skill_60073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，召喚 [Arg3] 只「搜查貓」在前方，自身生命越低召喚的寵物越強大。"
  },
  Skill_60073_Name = {Text = "豢養"},
  Skill_60074_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重創>  [Arg3] 回合。"
  },
  Skill_60074_Name = {
    Text = "「重創」飛刃"
  },
  Skill_60075_Desc = {
    Text = "召喚 [Arg1] 只「小蜜蜂」在後方，自身生命越低召喚的寵物越強大。"
  },
  Skill_60075_Name = {Text = "歸巢"},
  Skill_60076_Desc = {
    Text = "召喚 [Arg1] 只「小蜜蜂」在後方，自身生命越低召喚的寵物越強大。使所有友方獲得 [Arg2] 層屏障，屏障數量隨著回合數提高。"
  },
  Skill_60076_Name = {
    Text = "群鳥歸巢"
  },
  Skill_60077_Desc = {
    Text = "召喚 [Arg1] 只「小蜜蜂」在後方，自身生命越低召喚的寵物越強大。"
  },
  Skill_60077_Name = {Text = "歸巢"},
  Skill_60078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重創>  [Arg3] 回合。"
  },
  Skill_60078_Name = {
    Text = "「重創」飛刃"
  },
  Skill_60079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重創>  [Arg3] 回合。"
  },
  Skill_60079_Name = {
    Text = "「重創」飛刃"
  },
  Skill_60080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60081_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60082_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60131_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點戒備。"
  },
  Skill_60131_Name = {
    Text = "機械武裝-斂"
  },
  Skill_60132_Desc = {
    Text = "回合結束時根據不同狀態獲得不同強化：放-獲得 1 層臨時<MadnessIconKeywords:瘋狂>。斂-獲得 50 層臨時<ReinforcePVEKeywords:加固>。"
  },
  Skill_60132_Name = {
    Text = "參數擬合"
  },
  Skill_60133_Desc = {
    Text = "獲得 [Arg1] 點力量。"
  },
  Skill_60133_Name = {
    Text = "機械武裝-放"
  },
  Skill_60134_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並獲得 [Arg3] 點護盾。"
  },
  Skill_60134_Name = {
    Text = "電磁爆破"
  },
  Skill_60135_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg2] 層屏障。每次「形態切換」會使傷害次數和屏障數提高 1。"
  },
  Skill_60135_Name = {
    Text = "機能超載"
  },
  Skill_60136_Desc = {
    Text = "獲得 [Arg1] 點護盾和 [Arg2] 點臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_60136_Name = {Text = "防禦"},
  Skill_60137_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60137_Name = {Text = "打擊"},
  Skill_60171_Desc = {
    Text = "造成 [Arg1] 點<BleedingIconKeywords:出血>和 [Arg2] 點護盾。該出血受力量提高加成。"
  },
  Skill_60172_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得等同於未被格擋傷害的臨時<PowerIconKeywords:力量>。"
  },
  Skill_60172_Name = {
    Text = "試探劍招"
  },
  Skill_60173_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_60173_Name = {Text = "重創"},
  Skill_60174_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 點臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_60174_Name = {Text = "劍勢"},
  Skill_60175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回復等同於未被格擋傷害 10 倍的生命。"
  },
  Skill_60175_Name = {
    Text = "蝕血劍招"
  },
  Skill_60176_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60176_Name = {Text = "幻影劍"},
  Skill_60177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_60178_Desc = {
    Text = "造成 [Arg1] 點<BleedingIconKeywords:出血>和 [Arg2] 點護盾。該出血受力量提高加成。"
  },
  Skill_60179_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，施加 [Arg2] 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_60179_Name = {Text = "劍意"},
  Skill_60180_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_60181_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 點臨時<RetaliateIconKeywords:反擊>。"
  },
  Skill_60181_Name = {Text = "劍勢"},
  Skill_60182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60182_Name = {Text = "幻影劍"},
  Skill_60192_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，施加 [Arg2] 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_60192_Name = {Text = "劍意"},
  Skill_60193_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得等同於未被格擋傷害的臨時<PowerIconKeywords:力量>。"
  },
  Skill_60193_Name = {
    Text = "試探劍招"
  },
  Skill_60194_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<HeavyInjuryKeywords:重創>。"
  },
  Skill_60194_Name = {Text = "重創"},
  Skill_60195_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回復等同於未被格擋傷害 10 倍的生命。"
  },
  Skill_60195_Name = {
    Text = "蝕血劍招"
  },
  Skill_60252_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60253_Desc = {
    Text = "造成 [Arg1] 點<BleedingIconKeywords:出血>和 [Arg2] 點護盾。該出血受力量提高加成。"
  },
  Skill_60253_Name = {Text = "敗血"},
  Skill_60254_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 點臨時<RetaliateIconKeywords:反擊>。施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_60254_Name = {Text = "劍勢"},
  Skill_60255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_60256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺>傷害，目標生命越高傷害越高。施加 [Arg3] 層<FragileIconKeywords:脆弱>。"
  },
  Skill_60272_Desc = {
    Text = "將 3 張隨機<AberrationKeywords:畸變>和 1 張「症狀」置入抽牌堆。"
  },
  Skill_60272_Name = {
    Text = "為了這個世界"
  },
  Skill_60273_Desc = {
    Text = "告訴我，守密人…是什麼讓你仍舊堅持戰鬥？\n若此卡仍在手中時打出了其他卡牌，「塔薇」將會憤怒，對我方造成 [Arg1] 點<FixedDamage:純粹傷害>。"
  },
  Skill_60274_Desc = {
    Text = "「塔薇」獲得 3 層 <ExclamationPointColour:怨恨鎖鏈>。"
  },
  Skill_60274_Name = {
    Text = "為了在意的人"
  },
  Skill_60275_Desc = {
    Text = "將隨機 7 張指令卡附加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_60275_Name = {
    Text = "只是為了自己而已"
  },
  Skill_60285_Desc = {
    Text = "選擇一名喚醒體獲得 30 狂氣，其他喚醒體失去 10 狂氣。此卡回合結束若在手中，對我方造成 [Arg1] 點傷害。"
  },
  Skill_60285_Name = {
    Text = "真·輪回悖論"
  },
  Skill_60286_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 2 張「真·輪回悖論」加入手牌。"
  },
  Skill_60286_Name = {
    Text = "雙翼初張"
  },
  Skill_60287_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 6 張「真·輪回悖論」加入手牌。"
  },
  Skill_60287_Name = {
    Text = "六翼滿開"
  },
  Skill_60288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 4 張「真·輪回悖論」加入手牌。"
  },
  Skill_60288_Name = {
    Text = "四翼漸生"
  },
  Skill_60293_Desc = {
    Text = "提升 2 倍生命上限。每回合開始時將 1 張「回答塔薇」置入手中。"
  },
  Skill_60293_Name = {Text = "復甦"},
  Skill_60309_Desc = {
    Text = "於融蝕中掙扎，於融蝕中消亡。抽到時失去 25% 的當前算力和狂氣。打出後失去 20% <PowerIconKeywords:力量>和<RetaliateIconKeywords:反擊>。回合結束時若在手中，生命上限降低 5%。"
  },
  Skill_60309_Name = {
    Text = "融蝕之芯"
  },
  Skill_60310_Desc = {
    Text = "回復 15% 已損失生命([Arg2])，本回合釋放狂氣爆發時回復 5% 已損失生命。還可使用 [Arg1] 次。"
  },
  Skill_60335_Desc = {
    Text = "你正在遺忘世界，世界也正在遺忘你。回合結束前，將所有其他手牌變為<DerivativeCardKeywords_38:幻覺>並棄掉。"
  },
  Skill_60335_Name = {
    Text = "記憶消解"
  },
  Skill_60397_Desc = {
    Text = "獲得 20 層<ReinforcePVEKeywords:加固>和 [Arg1] 點<PowerIconKeywords:力量>。後續每受到 1 次傷害就獲得 2 層臨時<ReinforcePVEKeywords:加固>。"
  },
  Skill_60397_Name = {
    Text = "終焉進化"
  },
  Skill_60398_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 2 回合的<BlindingKeywords:致盲> 和 <HeavyInjuryKeywords:重創>。"
  },
  Skill_60399_Desc = {
    Text = "獲得 [Block:Arg1] 點護盾，[Arg2] 點<PowerIconKeywords:力量>，[Arg3] 點<RetaliateIconKeywords:反擊>，解除自身負面狀態。"
  },
  Skill_60399_Name = {Text = "蛻變"},
  Skill_60424_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中。本回合觸發「音符律令」時,將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中。"
  },
  Skill_60424_Name = {
    Text = "追憶迴旋曲\n算力 ≥2"
  },
  Skill_60425_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得等同於未被格擋傷害的臨時<PowerIconKeywords:力量>，回復等同於未被格擋傷害 10 倍的生命。"
  },
  Skill_60425_Name = {
    Text = "原初的樂音\n算力 ≤2"
  },
  Skill_60426_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並降低目標 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60427_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次並獲得 [Arg3] 層永久<ReinforcePVEKeywords:加固>。"
  },
  Skill_60428_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每次未被格擋的傷害都會附加 1 個隨機負面效果。之後的「靈魂序曲」傷害次數 +1。"
  },
  Skill_60428_Name = {
    Text = "靈魂序曲\n算力 0"
  },
  Skill_60475_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_60475_Name = {
    Text = "綿長恨怨"
  },
  Skill_60476_Desc = {
    Text = "全體友方獲得 [Arg1]點<PowerIconKeywords:力量>，驅散自身<WeaknessIconKeywords:虛弱>與<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_60476_Name = {
    Text = "絕境求生"
  },
  Skill_60477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_60478_Desc = {
    Text = "移除所有擬態喚醒體。召喚 2 名擬態喚醒體。本場戰鬥中所有喚醒體造成的狂氣降低 50%。"
  },
  Skill_60478_Name = {
    Text = "目見母親"
  },
  Skill_60479_Desc = {
    Text = "召喚 1 名擬態喚醒體。若擬態喚醒體已滿，意圖變為「打擊」。"
  },
  Skill_60479_Name = {
    Text = "聖血的本能"
  },
  Skill_60480_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_60480_Name = {
    Text = "石質分解"
  },
  Skill_60481_Desc = {
    Text = "使狂氣最高的喚醒體失去 50 點狂氣，執行 2 次。施加 2 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虛弱>。"
  },
  Skill_60481_Name = {
    Text = "古老的愛撫"
  },
  Skill_60482_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，抽牌堆頂的 [Arg3] 張卡牌施加「<SlowIconKeywords:遲緩>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_60482_Name = {
    Text = "凝滯詛咒"
  },
  Skill_60483_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加等同於傷害 [Arg3]% 的<IntoxicationIconKeywords:中毒>，[Arg4]% 的<BleedingIconKeywords:出血>，[Arg5]% 的<RetaliateIconKeywords:反擊>。"
  },
  Skill_60483_Name = {
    Text = "豐穰之儀"
  },
  Skill_60498_Desc = {
    Text = "全體友方每回合開始時獲得護盾，等同於上回合受到的傷害的一半。"
  },
  Skill_60498_Name = {
    Text = "獻媚者之擁"
  },
  Skill_60501_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 2 張<DerivativeCardKeywords_34:「未被滿足之痛」>置入抽牌堆。"
  },
  Skill_60514_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<BleedingIconKeywords:出血>。"
  },
  Skill_60514_Name = {Text = "飛刃"},
  Skill_60515_Desc = {
    Text = "獲得 10 層<BloodOath:血誓>，施加 2 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_60515_Name = {
    Text = "血紅誓言"
  },
  Skill_60516_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每層<BloodOath:血誓>使傷害提高 [Arg3] 點。"
  },
  Skill_60516_Name = {
    Text = "降罪燈火"
  },
  Skill_60517_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_60535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 2 回合<FragileIconKeywords:脆弱>。將 1 張「血污燈芯」置入手中。"
  },
  Skill_60536_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。隨機施加<FragileIconKeywords:脆弱>或<HeavyInjuryKeywords:重創> 2 回合。將 1 張「血污燈芯」置入手中。"
  },
  Skill_60537_Desc = {
    Text = "獲得 10 層<BloodOath:血誓>，施加 2 回合<HeavyInjuryKeywords:重創>。將 1 張「血污燈芯」置入手中。"
  },
  Skill_60537_Name = {
    Text = "血紅誓言"
  },
  Skill_60538_Desc = {
    Text = "獲得 [Arg3] 點 <SacrificeKeyWord:獻祭>和 [Arg4] 點<PowerIconKeywords:力量>。回合結束時若此卡仍然在手中，則使「燈罩」阿依莎失去 [Arg1] 點生命並獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_60538_Name = {
    Text = "血污燈芯"
  },
  Skill_60539_Desc = {
    Text = "獲得加固至 80 層，回合結束時獲得 10 層<BloodOath:血誓>。"
  },
  Skill_60540_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每層<BloodOath:血誓>使傷害提高 [Arg3] 點。"
  },
  Skill_60540_Name = {
    Text = "降罪燈火"
  },
  Skill_60541_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<BleedingIconKeywords:出血>。"
  },
  Skill_60541_Name = {Text = "敗血"},
  Skill_60542_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每 2 層<BloodOath:血誓>使傷害次數提高 1。"
  },
  Skill_60542_Name = {
    Text = "燈芯長明"
  },
  Skill_60552_Desc = {
    Text = "選擇：「<DerivativeCardKeywords_61:上行音>」或「<DerivativeCardKeywords_62:下行音>」。"
  },
  Skill_60552_Name = {
    Text = "協樂的交響"
  },
  Skill_60590_BattleDesc = {
    Text = "本回合下一張打出的卡牌若算力消耗大於等於 3，獲得 2 點算力，否則抽 2 張牌。若為本場戰鬥中第 4 次生效，改為直接獲得 4 張<DerivativeCardKeywords_4:「靈感」>。([Arg1]/4)"
  },
  Skill_60590_Desc = {
    Text = "本回合下一張打出的卡牌若算力消耗大於等於 3，獲得 2 點算力，否則抽 2 張牌。若為本場戰鬥中第 4 次生效，改為直接獲得 4 張<DerivativeCardKeywords_4:「靈感」>。"
  },
  Skill_60590_Name = {
    Text = "第四樂章"
  },
  Skill_60837_Desc_1 = {
    Text = "造成 [Arg1] 層<PVPSlowKeywords:遲緩>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_60837_Name_1 = {
    Text = "第四樂章"
  },
  Skill_60837_UnknownName = {
    Text = "第四樂章"
  },
  Skill_60845_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，[Arg2]<PVPSlowKeywords:遲緩>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_60845_Name_1 = {
    Text = "悲愴弱音"
  },
  Skill_60846_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，附加傷害 [Arg2]% 的<PVPBleedingKeywords:出血>，若目標擁有可驅散的負面狀態則提升到 [Arg3]%。"
  },
  Skill_60846_Name_1 = {
    Text = "原初的樂音"
  },
  Skill_60848_Desc_1 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 狂氣，<DelayKeywords:延遲>：扣除 [Arg2] 算力。"
  },
  Skill_60848_Name_1 = {
    Text = "田園和聲"
  },
  Skill_60849_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_60849_Name_1 = {
    Text = "驚愕強音"
  },
  Skill_60884_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_60884_Name_1 = {Text = "打擊"},
  Skill_60927_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_60928_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_60929_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，獲得 5 層祈禱，和最後的友方交換位置。"
  },
  Skill_60929_Name = {Text = "祈禱"},
  Skill_60930_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。自身獲得 2 層屏障，和最前方友方交換位置。"
  },
  Skill_60931_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_60931_Name = {
    Text = "燈芯長明"
  },
  Skill_60932_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 點力量，和最前方友方交換位置。"
  },
  Skill_60932_Name = {
    Text = "蠟像登場"
  },
  Skill_60933_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_9:蹣跚>和<DerivativeCardKeywords_32:黏糊糊的蠟油>洗入抽牌堆。和最後方友方交換位置。"
  },
  Skill_60934_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_60934_Name = {
    Text = "蠟像登場"
  },
  Skill_60937_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 點力量，和最前方友方交換位置。將 1 張<DerivativeCardKeywords_9:蹣跚>和<DerivativeCardKeywords_32:黏糊糊的蠟油>洗入抽牌堆。"
  },
  Skill_60937_Name = {
    Text = "蠟像登場"
  },
  Skill_60938_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_60939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱> 2 回合。"
  },
  Skill_60939_Name = {
    Text = "蠟像登場"
  },
  Skill_60952_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」前對全體敵方造成 [Arg1] 層<PVPSlowKeywords:遲緩>。"
  },
  Skill_60952_Name_1 = {
    Text = "永恆安魂曲"
  },
  Skill_61119_AwakerSkillBackgroundStory = {
    Text = "拉克西斯手執長尺，歌唱提洛人的一生：\n屠戮斯巴達的殺手，你本可以成為英雄，\n提希豐蒙蔽了你的雙眼，她的羽翼成了捆繩，\n她讓你成為仇恨的奴隸，眼裡只有鮮紅。"
  },
  Skill_61119_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害和等量<BleedingIconKeywords:出血>，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_61119_Desc_2 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害和等量<BleedingIconKeywords:出血>，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。若生命低於 50%，獲得的<PowerIconKeywords:力量>翻倍。"
  },
  Skill_61119_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_61119_Name = {
    Text = "恨意宣洩"
  },
  Skill_61119_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_61120_AwakerSkillBackgroundStory = {
    Text = "殺戮，殺戮，直到僅剩死亡。"
  },
  Skill_61120_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_61120_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。獲得 [Arg3] %臨時暴擊率和暴擊傷害。"
  },
  Skill_61120_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。血鏈·希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_61120_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。血鏈·希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。血鏈·希洛獲得 [Arg3] %臨時暴擊率和暴擊傷害。"
  },
  Skill_61120_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_61120_Name = {Text = "打擊"},
  Skill_61120_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_61121_AwakerSkillBackgroundStory = {
    Text = "阿特洛波斯剪斷了黑色的線，提洛人的命運斷絕。\n那將枷鎖當做武器的殺手，曾如此驍勇，\n最終也在無數長槍前倒下。"
  },
  Skill_61121_BattleDesc = {
    Text = "失去 10%( [Arg2] ) 當前生命，隨機造成 <Damage:[Damage:Arg1]> 點傷害 2 次並附加 50% 傷害的<BleedingIconKeywords:出血>。打出 3 次後，變為「<DerivativeCardKeywords_66:嗜血鏈球>」( [Arg3]/3 )。"
  },
  Skill_61121_Desc = {
    Text = "失去 10% 當前生命，隨機造成 <Damage:[Damage:Arg1]> 點傷害 2 次並附加 50% 傷害的<BleedingIconKeywords:出血>。打出 3 次後，變為「<DerivativeCardKeywords_66:嗜血鏈球>」。"
  },
  Skill_61121_EffectNameList = {Text = "傷害"},
  Skill_61121_Name = {
    Text = "鮮血鏈條"
  },
  Skill_61121_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_61122_AwakerSkillBackgroundStory = {
    Text = "阿特洛波斯剪斷了黑色的線，提洛人的命運斷絕。\n那將枷鎖當做武器的殺手，曾如此驍勇，\n最終也在無數長槍前倒下。"
  },
  Skill_61122_BattleDesc = {
    Text = "視為「打擊」。造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 5 倍力量加成並觸發目標 30% 的<BleedingIconKeywords:出血>，回復 [Arg3]% 已損失的生命(<Heal:[Arg2]>)。打出後變為「<DerivativeCardKeywords_65:鮮血鏈條>」。"
  },
  Skill_61122_Desc = {
    Text = "視為「打擊」。造成 <Damage:[Damage:Arg1]> 點傷害，該傷害享受 5 倍力量加成並觸發目標 30% 的<BleedingIconKeywords:出血>，回復已損失生命的 15%。打出後變為「<DerivativeCardKeywords_65:鮮血鏈條>」。"
  },
  Skill_61122_EffectNameList = {Text = "傷害"},
  Skill_61122_Name = {
    Text = "嗜血鏈球"
  },
  Skill_61122_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_61123_AwakerSkillBackgroundStory = {
    Text = "歌唱吧，女神！歌唱提洛之女的命運：\n充滿了鮮血與淚水，憤怒與絕望。\n她的仇恨如同烈火，燃盡周圍的一切，而最終，\n帶來了她自己的死亡。"
  },
  Skill_61123_Desc_0 = {
    Text = "血鏈·希洛獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：將一張「<DerivativeCardKeywords_65:鮮血鏈條>」置入手中，血鏈·希洛的指令卡獲得「<RetainIconKeywords:保留>」。回合開始時，血鏈·希洛基礎傷害在本場戰鬥中提高 [Arg2]%。"
  },
  Skill_61123_Desc_15 = {
    Text = "血鏈·希洛獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：將一張「<DerivativeCardKeywords_65:鮮血鏈條>」置入手中，血鏈·希洛的指令卡獲得「<RetainIconKeywords:保留>」。回合開始時，血鏈·希洛基礎傷害在本場戰鬥中提高 [Arg2]%。釋放狂氣爆發「縛身鎖鏈」後，賦予手中每張不同的「血鏈·希洛」指令卡 50 層<TempPowerKeywords:臨時強化>。"
  },
  Skill_61123_EffectNameList = {
    Text = "狂氣,傷害提高"
  },
  Skill_61124_AwakerSkillBackgroundStory = {
    Text = "克洛託，克洛託，手執紡錘的女神，\n你從何處取了這線？\n即便打破鐐銬，那可憐的提洛人，\n也無法逃離命運的鎖鏈。"
  },
  Skill_61124_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 點傷害。"
  },
  Skill_61124_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。"
  },
  Skill_61124_EffectNameList = {
    Text = "傷害,出血比例"
  },
  Skill_61124_Name = {
    Text = "縛身鎖鏈"
  },
  Skill_61124_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。血鏈·希洛暴擊傷害提升 35%，臨時手牌上限+2，將 1 張「恨意宣洩」和「鮮血鏈條」置入手中，並使它們算力消耗-1。"
  },
  Skill_61124_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。血鏈·希洛暴擊傷害提升 35%，臨時手牌上限+2，將 1 張「恨意宣洩」和「鮮血鏈條」置入手中，並使它們算力消耗-1。"
  },
  Skill_61124_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2%"
  },
  Skill_61124_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 點傷害。"
  },
  Skill_61124_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。"
  },
  Skill_61124_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。賦予手中每張不同的自身指令卡 50 層「臨時強化」，回合結束或打出後移除。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。血鏈·希洛暴擊傷害提升 35%，臨時手牌上限+2，將 1 張「恨意宣洩」和「鮮血鏈條」置入手中，並使它們算力消耗-1。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。血鏈·希洛暴擊傷害提升 35%，臨時手牌上限+2，將 1 張「恨意宣洩」和「鮮血鏈條」置入手中，並使它們算力消耗-1。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 張血鏈·希洛的指令卡，使手中血鏈·希洛的指令卡算力消耗降低 1。】本回合血鏈·希洛造成主動傷害時，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目標護盾，造成 <Damage:[Damage:Arg1]> 點傷害並使目標無法獲得護盾，持續 1 回合。血鏈·希洛暴擊傷害提升 35%，臨時手牌上限+2，將 1 張「恨意宣洩」和「鮮血鏈條」置入手中，並使它們算力消耗-1。賦予手中每張不同的自身指令卡 50 層「臨時強化」，回合結束或打出後移除。"
  },
  Skill_61125_Desc = {
    Text = "選擇血鏈·希洛的一張基礎指令卡置入手牌。"
  },
  Skill_61125_Name = {
    Text = "不規則形態 · 血鏈"
  },
  Skill_61126_AwakerSkillBackgroundStory = {
    Text = "忍耐，等待。所有的苦難，都將被複仇的鮮血澆灌。"
  },
  Skill_61126_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_61126_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。觸發所有敵人 [Arg3]% 的<BleedingIconKeywords:出血>。"
  },
  Skill_61126_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。血鏈·希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_61126_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。血鏈·希洛獲得 <Energy:[Energy:Arg2]> 點狂氣。觸發所有敵人 [Arg3]% 的<BleedingIconKeywords:出血>。"
  },
  Skill_61126_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_61126_Name = {Text = "防禦"},
  Skill_61126_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_61535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機凍結一張卡牌。"
  },
  Skill_61536_Desc = {
    Text = "回合結束時獲得 <Block:[Block:Arg1]> 點 <CardKeyWord:霜盾> 和  [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_61536_Name = {
    Text = "霜寒徹骨"
  },
  Skill_61537_Desc = {
    Text = "所有喚醒體失去 10 點狂氣。"
  },
  Skill_61537_Name = {Text = "詛咒"},
  Skill_62216_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_62216_Name = {
    Text = "終結……"
  },
  Skill_62217_Desc = {
    Text = "獲得 [Arg1] 層<ReinforcePVEKeywords:加固>。"
  },
  Skill_62218_Desc = {
    Text = "祂看著你。將一張「症狀」永久置入你的牌庫。"
  },
  Skill_62218_Name = {
    Text = "凝視-倒計時：1"
  },
  Skill_62221_Desc = {
    Text = "自身隱匿，號令萬千世界的目光前來戰鬥。"
  },
  Skill_62221_Name = {
    Text = "萬千世界之眼"
  },
  Skill_62305_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] <StrongEffectKeywords:強效>。每當失去生命後，若當前生命低於 [Arg2]%，獲得<ReinforceKeywords:加固>和<StrengthenKeywords:強化>。"
  },
  Skill_62305_Name_1 = {
    Text = "沉入殷紅"
  },
  Skill_62306_Desc_1 = {
    Text = "給予任意目標 <TauntKeywords:嘲諷>和 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_62306_Name_1 = {
    Text = "群山的覺悟"
  },
  Skill_62306_UnknownName = {
    Text = "群山的覺悟"
  },
  Skill_62311_Desc = {
    Text = "造成 <FragileIconKeywords:脆弱> 1 回合。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，手牌中每有 1 張凍結的卡牌額外造成 1 次傷害，將那些被凍結的卡牌消耗。"
  },
  Skill_62311_Name = {Text = "冰之語"},
  Skill_62312_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。手牌中每有 1 張凍結的卡牌傷害提高 [Arg3] 點。<WeaknessIconKeywords:虛弱> 1 回合。"
  },
  Skill_62314_Desc = {
    Text = "召喚兩名「冷冽之靈」，所有友方獲得 [Arg1] 點 <CardKeyWord:霜盾>。"
  },
  Skill_62314_Name = {
    Text = "冷冽之靈"
  },
  Skill_62315_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。手牌中每有 1 張凍結的卡牌則傷害提高 [Arg3] 點。<WeaknessIconKeywords:虛弱> 3 回合。"
  },
  Skill_62315_Name = {
    Text = "凜冽寒焰"
  },
  Skill_62316_Desc = {
    Text = "造成 <FragileIconKeywords:脆弱> 3 回合。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，手牌中每有 1 張凍結的卡牌額外造成 1 次傷害，將那些被凍結的卡牌消耗。"
  },
  Skill_65341_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。凍結牌庫頂的 2 張指令卡。"
  },
  Skill_65357_Desc = {
    Text = "選擇一名喚醒體，抽 2 張該喚醒體的指令卡。"
  },
  Skill_65357_Name = {
    Text = "群山的覺悟"
  },
  Skill_65369_Desc = {
    Text = "損失 1 名科考團人員，抽 [Arg2] 張牌，獲得 [Arg2] 算力。失去 10% 最大生命([Arg1])。"
  },
  Skill_65369_Name = {
    Text = "主動約束"
  },
  Skill_65370_Desc = {
    Text = "損失 2 名科考團人員，抽 [Arg1] 張牌，獲得 [Arg1] 算力。所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65371_Desc = {
    Text = "損失 5 名科考團人員，所有喚醒體獲得 50 狂氣，回復 30% 最大生命([Arg1])。抽 [Arg2] 張牌，獲得 [Arg2] 算力。"
  },
  Skill_65372_Desc = {
    Text = "若科考團人數為 0，此卡變為<DerivativeCardKeywords_9:「蹣跚」>。若回合結束後此卡仍在手中，下回合開始時所有敵人獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_65393_Desc = {
    Text = "獲得 [Arg1] 點算力，選擇 1 名喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65393_Name = {
    Text = "人性光輝"
  },
  Skill_65451_Desc = {
    Text = "獲得 [Arg1] 點算力，選擇 1 名喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65451_Name = {
    Text = "微明的人性光輝"
  },
  Skill_65452_Desc = {
    Text = "獲得 [Arg1] 點算力，選擇 1 名喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65452_Name = {
    Text = "閃耀的人性光輝"
  },
  Skill_65453_Desc = {
    Text = "獲得 [Arg1] 點算力，選擇 1 名喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65453_Name = {
    Text = "暗淡的人性光輝"
  },
  Skill_65454_Desc = {
    Text = "獲得 [Arg1] 點算力，所有喚醒體獲得 [Arg2] 點狂氣。"
  },
  Skill_65454_Name = {
    Text = "璀璨的人性光輝"
  },
  Skill_65462_Desc = {
    Text = "抽 [Arg2] 張牌，獲得 [Arg2] 算力。失去 20% 最大生命([Arg1])。所有喚醒體失去 20 點狂氣。"
  },
  Skill_65545_Desc = {
    Text = "提高 15% 最大生命，並獲得 [Arg1] 層<ReinforcePVEKeywords:加固> 和 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_65545_Name = {
    Text = "急凍復甦"
  },
  Skill_65546_Desc = {
    Text = "獲得 [Arg1] 點霜盾，將 1 張<DerivativeCardKeywords_74:警覺>置入手中。"
  },
  Skill_65546_Name = {Text = "警備"},
  Skill_65547_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，消耗所有手中被凍結的卡牌。"
  },
  Skill_65547_Name = {
    Text = "碎冰猛鑿"
  },
  Skill_65548_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_65548_Name = {
    Text = "刺骨揮擊"
  },
  Skill_65549_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每造成一次未被完全格擋的傷害，隨機凍結牌庫中 1 張未被凍結的指令卡。"
  },
  Skill_65549_Name = {
    Text = "風雪揮擊"
  },
  Skill_65550_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 層<SlowIconKeywords:遲緩>。"
  },
  Skill_65550_Name = {
    Text = "霜凍之詠"
  },
  Skill_65551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，回合結束前每有 1 張手牌額外造成 1 次傷害，最大 10 次。"
  },
  Skill_65551_Name = {
    Text = "碎冰飛刃"
  },
  Skill_66041_Desc = {
    Text = "測試用的卡牌"
  },
  Skill_66041_Name = {
    Text = "技能@測試卡牌A"
  },
  Skill_66042_Desc = {
    Text = "測試用的卡牌"
  },
  Skill_66042_Name = {
    Text = "技能@測試卡牌B"
  },
  Skill_66043_Desc = {
    Text = "測試用的卡牌"
  },
  Skill_66043_Name = {
    Text = "技能@測試卡牌C"
  },
  Skill_66282_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_66283_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_66284_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_66284_Name = {
    Text = "原初混沌之靈"
  },
  Skill_66285_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_66285_Name = {
    Text = "原初混沌之種"
  },
  Skill_66286_Desc = {
    Text = "祂在疑惑。獲得 [Arg1] 層臨時「怨恨鎖鏈」。"
  },
  Skill_66286_Name = {
    Text = "鎖縛-倒計時：4"
  },
  Skill_66287_Desc = {
    Text = "祂很好奇。獲得 [Arg1] 點 <PowerIconKeywords:力量>。"
  },
  Skill_66287_Name = {
    Text = "強化-倒計時：2"
  },
  Skill_66288_Desc = {
    Text = "祂在疑惑。獲得 [Arg1] 層臨時「怨恨鎖鏈」。"
  },
  Skill_66288_Name = {
    Text = "鎖縛-倒計時：3"
  },
  Skill_66289_Desc = {
    Text = "獲得 [Arg1] 層 <ParcloseIconKeywords:屏障>。"
  },
  Skill_66289_Name = {
    Text = "盲目癡愚之壁"
  },
  Skill_66290_Desc = {
    Text = "對敵人添加「無上意志之威壓」：在打出 1 張指令卡時，棄掉 1 張該喚醒體最低算力的指令卡。"
  },
  Skill_66290_Name = {
    Text = "無上意志之權"
  },
  Skill_66291_Desc = {
    Text = "將「融蝕之芯」洗入抽牌堆。"
  },
  Skill_66291_Name = {
    Text = "遺忘萬物之影"
  },
  Skill_66292_Desc = {
    Text = "獲得「亙古穿今之鎖」：每回合結束時獲得 1 層「怨恨鎖鏈」。"
  },
  Skill_66292_Name = {
    Text = "亙古穿今之鎖"
  },
  Skill_66296_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_66296_Name = {
    Text = "原初混沌之種"
  },
  Skill_66298_Desc = {
    Text = "自身隱匿，號令萬千世界的目光前來戰鬥。"
  },
  Skill_66298_Name = {
    Text = "萬千世界之眼"
  },
  Skill_66300_Desc = {
    Text = "獲得 [Arg1] 層<ReinforcePVEKeywords:加固>，驅散所有敵人正面狀態，驅散自身所有負面狀態。"
  },
  Skill_66301_Desc = {
    Text = "所有喚醒體失去一半狂氣，對手失去 5 點算力上限和 10 點手牌上限。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，真正的原初…即將降臨！"
  },
  Skill_66301_Name = {
    Text = "「世界崩析之融蝕」"
  },
  Skill_66302_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。所有喚醒體失去 100% 狂氣。守密人算力上限 -5，手牌上限 -10。"
  },
  Skill_66302_Name = {
    Text = "「世界崩析之融蝕」"
  },
  Skill_66303_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_66303_Name = {
    Text = "原初混沌之靈"
  },
  Skill_66304_Desc = {
    Text = "通過移動自身的位置，改變「目光」的排列。"
  },
  Skill_66304_Name = {
    Text = "移形換影"
  },
  Skill_66349_AwakerSkillBackgroundStory = {
    Text = "她知曉過去、現在和未來。\n她知曉一切如何產生，又將如何消散。\n她的耳畔迴蕩那位「祂」的呼吸。"
  },
  Skill_66349_Desc_0 = {
    Text = "在手牌中時，若抽牌堆頂部的卡牌為指令卡，變為其複製。打出後還原，獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_66349_Desc_1 = {
    Text = "在手牌中時，若抽牌堆頂部的卡牌為指令卡，變為其算力消耗-1 的複製。打出後還原，獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_66349_EffectNameList = {Text = "狂氣"},
  Skill_66349_Name = {
    Text = "通曉萬物之理"
  },
  Skill_66350_AwakerSkillBackgroundStory = {
    Text = "跨越銀鑰之扉，人類伏身於祂的王座前，探求終極的答案。\n而她是看門者，她負責勸阻、提醒、警示。\n不告知才是她的慈悲。"
  },
  Skill_66350_BattleDesc_0 = {
    Text = "塔薇獲得 <Energy:[Energy:Arg1]> 點狂氣。將 1 張「<DerivativeCardKeywords_67:銀鑰曦光>」置入手中。塔薇每消耗 1 點算力，獲得 50% 銀鑰充能的銀鑰能量。"
  },
  Skill_66350_BattleDesc_15 = {
    Text = "塔薇獲得 <Energy:[Energy:Arg1]> 點狂氣。將 1 張「<DerivativeCardKeywords_67:銀鑰曦光>」置入手中。塔薇每消耗 1 點算力，獲得 50% 銀鑰充能的銀鑰能量。塔薇釋放狂氣爆發後，所有喚醒體本回合指令卡最終傷害提升 [Arg2]％ 並使打出的下一張其它喚醒體的指令卡也能夠額外生效 1 次。"
  },
  Skill_66350_Desc_0 = {
    Text = "塔薇獲得 <Energy:[Energy:Arg1]> 點狂氣。將 1 張「<DerivativeCardKeywords_67:銀鑰曦光>」置入手中。塔薇每消耗 1 點算力，獲得 50% 銀鑰充能的銀鑰能量。"
  },
  Skill_66350_Desc_15 = {
    Text = "塔薇獲得 <Energy:[Energy:Arg1]> 點狂氣。將 1 張「<DerivativeCardKeywords_67:銀鑰曦光>」置入手中。塔薇每消耗 1 點算力，獲得 50% 銀鑰充能的銀鑰能量。塔薇釋放狂氣爆發後，所有喚醒體本回合指令卡最終傷害提升 [Arg2]％ 並使打出的下一張其它喚醒體的指令卡也能夠額外生效 1 次。"
  },
  Skill_66350_EffectNameList = {Text = "狂氣"},
  Skill_66350_Name = {
    Text = "穿越銀鑰之門"
  },
  Skill_66351_Desc = {
    Text = "算力不足時能消耗 <Posse:500> 銀鑰能量打出。造成 2 次 <Damage:[Damage:Arg1]> 點傷害，塔薇獲得 <Energy:[Energy:Arg2]> 點狂氣。抽 1 張牌。將<DerivativeCardKeywords_76:「四翼漸生」>洗入抽牌堆。"
  },
  Skill_66351_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_66351_Name = {
    Text = "雙翼初張"
  },
  Skill_66351_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_66352_AwakerSkillBackgroundStory = {
    Text = "她無意阻礙。\n但超越之人陷入癲狂。"
  },
  Skill_66352_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_66352_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣、[Arg3]% 暴擊率和暴擊傷害，至多疊加 10 次([Arg4]/10 ) 。"
  },
  Skill_66352_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。塔薇獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_66352_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。塔薇獲得 <Energy:[Energy:Arg2]> 點狂氣、[Arg3]% 暴擊率和暴擊傷害，至多疊加 10 次。"
  },
  Skill_66352_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_66352_Name = {Text = "防禦"},
  Skill_66352_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_66353_Desc = {
    Text = "算力不足時能消耗 <Posse:500> 銀鑰能量打出。造成 6 次 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。可以從 6 種「追憶」中選擇一個觸發其效果，該「追憶」在本次探索中無法被再次選擇。"
  },
  Skill_66353_EffectNameList = {Text = "傷害"},
  Skill_66353_Name = {
    Text = "六翼滿開"
  },
  Skill_66353_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_66354_AwakerSkillBackgroundStory = {
    Text = "她無意傷害。\n但真理之門出現裂隙。"
  },
  Skill_66354_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_66354_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣、[Arg3]% 暴擊率和暴擊傷害，至多疊加 10 次([Arg4]/10 ) 。"
  },
  Skill_66354_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。塔薇獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_66354_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。塔薇獲得 <Energy:[Energy:Arg2]> 點狂氣、[Arg3]% 暴擊率和暴擊傷害，至多疊加 10 次。"
  },
  Skill_66354_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_66354_Name = {Text = "打擊"},
  Skill_66354_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_66355_BattleDesc = {
    Text = "算力不足時能消耗 <Posse:500> 銀鑰能量打出。造成 4 次 <Damage:[Damage:Arg1]> 點傷害，抽 1 張牌。每造成 1 次傷害臨時降低目標 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>並獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量> 。將<DerivativeCardKeywords_77:「六翼滿開」>洗入抽牌堆。"
  },
  Skill_66355_Desc = {
    Text = "算力不足時能消耗 <Posse:500> 銀鑰能量打出。造成 4 次 <Damage:[Damage:Arg1]> 點傷害，抽 1 張牌。每造成 1 次傷害<TouquKeywords:偷取>目標 [Arg2] 點臨時<PowerIconKeywords:力量>。將<DerivativeCardKeywords_77:「六翼滿開」>洗入抽牌堆。"
  },
  Skill_66355_EffectNameList = {
    Text = "傷害,偷取力量"
  },
  Skill_66355_Name = {
    Text = "四翼漸生"
  },
  Skill_66355_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_66356_AwakerSkillBackgroundStory = {
    Text = "一生萬物。\n她支配時間和空間，自她的指尖流淌出秩序的世界。\n萬物歸一。\n無機物與有機物混沌一體，終將在那位「祂」的吐息中歸於虛無。"
  },
  Skill_66356_Desc_0 = {
    Text = "本回合內自身指令卡最終傷害提高 15%。獲得 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 5 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_Desc_2 = {
    Text = "本回合內自身指令卡最終傷害提高 15%。獲得 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 5 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:預備1>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_EffectNameList = {
    Text = "銀鑰能量"
  },
  Skill_66356_Name = {
    Text = "萬物歸一"
  },
  Skill_66356_OverLimitUtlSkillDesc_0 = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提升 [Arg2]%。獲得 3 點算力和 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 10 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_OverLimitUtlSkillDesc_2 = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提升 [Arg2]%。獲得 3 點算力和 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 10 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:預備1>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempBattleDesc_1 = {
    Text = "本回合內自身指令卡最終傷害提高 15%。獲得 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 5 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:預備1>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempBattleDesc_2 = {
    Text = "本回合內自身指令卡最終傷害提高 15%。獲得 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 5 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempBattleDesc_3 = {
    Text = "所有喚醒體本回合指令卡最終傷害提高 15%。獲得 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 5 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:預備1>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡和其它喚醒體的指令卡各生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_1 = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提升 [Arg2]%，本回合內自身指令卡最終傷害 +15%。獲得 3 點算力和 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 10 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_2 = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提升 [Arg2]%，本回合內自身指令卡最終傷害 +15%。獲得 3 點算力和 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 10 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_3 = {
    Text = "塔薇造成的傷害、護盾、生命回覆臨時提升 [Arg2]%，所有喚醒體本回合指令卡最終傷害提升 15%。獲得 3 點算力和 <Posse:[Arg1]> 點銀鑰能量。從當前界域的技能卡中<FaxianKeywords:發現> 10 張，選擇至多 3 張置入手中並使其視為塔薇的卡牌，這些卡牌獲得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:預備1>和<RetainIconKeywords:保留>。下一張打出的塔薇的指令卡和其它喚醒體的指令卡各生效 2 次。"
  },
  Skill_66357_AwakerSkillBackgroundStory = {
    Text = "那是空洞，無限時空中唯一的、狹小的孔隙。\n那個名為「守密人」的存在，是解答一切問題的答案，是開啟一切門扉的鑰匙。\n塔薇振響六翼，撲向那唯一的唯一。"
  },
  Skill_66357_Desc_0 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。將<DerivativeCardKeywords_75:「雙翼初張」>洗入抽牌堆。"
  },
  Skill_66357_Desc_1 = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>和 1 張<DerivativeCardKeywords_4:「靈感」>。將<DerivativeCardKeywords_75:「雙翼初張」>洗入抽牌堆。"
  },
  Skill_66357_Name = {
    Text = "縱貫時序之翼"
  },
  Skill_66357_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_66402_Desc = {
    Text = "選擇一名喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣。"
  },
  Skill_66402_Name = {
    Text = "天真的回禮"
  },
  Skill_66403_Desc = {
    Text = "選擇抽牌堆或棄牌堆 1 張卡置入手中，使其算力消耗變為 0。"
  },
  Skill_66403_Name = {
    Text = "極夜微光"
  },
  Skill_66404_Desc = {
    Text = "棄掉所有手牌並抽棄掉數量 +3 的卡牌。"
  },
  Skill_66404_Name = {
    Text = "畸變之心"
  },
  Skill_66405_Desc = {
    Text = "對最後排的敵人造成目標最大生命值 [Arg1]% 的<FixedDamage:純粹傷害>，該傷害不會低於自身最大生命值的 300%。"
  },
  Skill_66406_Desc = {
    Text = "獲得 1 層臨時<ParcloseIconKeywords:屏障>。"
  },
  Skill_66407_Desc = {
    Text = "查看 3 個鑰令並選擇 1 個立即釋放。"
  },
  Skill_66407_Name = {
    Text = "烏托邦帷幕"
  },
  Skill_66444_Desc_1 = {
    Text = "選擇一名喚醒體，將其生命還原至上回合開始時，並使其獲得<PVPWeaknessKeywords:虛弱>和<PVPVulnerabilityIconKeywords:易傷>。"
  },
  Skill_66444_Name_1 = {
    Text = "超脫與回溯"
  },
  Skill_66445_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_66445_Name_1 = {Text = "打擊"},
  Skill_66446_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害和 [Arg2] <PVPfengsuoKeywords:爆發封鎖>。"
  },
  Skill_66446_Name_1 = {
    Text = "萬物歸一"
  },
  Skill_66448_Desc_1 = {
    Text = "給予全體友方 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_66448_Name_1 = {
    Text = "隱於時隙"
  },
  Skill_66449_Desc_1 = {
    Text = "<DelayKeywords:延遲>：給予一名友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_66449_Name_1 = {
    Text = "全一傳承"
  },
  Skill_66458_Desc = {
    Text = "當前生命和護盾回到上回合結束時的狀態。"
  },
  Skill_66458_Name = {
    Text = "過往回聲"
  },
  Skill_66498_BattleDesc_1 = {
    Text = "選擇一名友方，使其複製 [Arg1] 張敵方手中算力消耗最高的技能卡，並使其算力消耗 -[Arg2] 。對方手中目前有 [Arg3] 張技能。"
  },
  Skill_66498_Desc_1 = {
    Text = "選擇一名友方，使其複製 [Arg1] 張敵方手中算力消耗最高的技能卡，並使其算力消耗 –[Arg2]。"
  },
  Skill_66498_Name_1 = {
    Text = "門扉的答案"
  },
  Skill_66498_UnknownName = {
    Text = "門扉的答案"
  },
  Skill_66499_Desc = {
    Text = "<FaxianKeywords:發現> 3 個隨機的鑰令，選擇其中 1 個觸發其效果並獲得 <Posse:[Arg1]> 點銀鑰能量。"
  },
  Skill_66499_Name = {
    Text = "門扉的答案"
  },
  Skill_66525_Desc = {
    Text = "「<Zhanxindeqianbao:嶄新的錢包>」"
  },
  Skill_66525_Name = {
    Text = "嶄新的錢包"
  },
  Skill_66526_Desc = {
    Text = "「<Wushangrongchong:無上榮寵>」"
  },
  Skill_66526_Name = {
    Text = "無上榮寵"
  },
  Skill_66527_Desc = {
    Text = "「<Canquemiankong:殘缺面孔>」"
  },
  Skill_66527_Name = {
    Text = "殘缺面孔"
  },
  Skill_66531_Desc = {
    Text = "「<Jingmijishiqi:精密計時器>」"
  },
  Skill_66531_Name = {
    Text = "精密計時器"
  },
  Skill_66532_Desc = {
    Text = "「<Huaibiaojing:懷錶鏡β>」"
  },
  Skill_66532_Name = {
    Text = "懷錶鏡β"
  },
  Skill_66534_Desc = {
    Text = "「<Tongxunshebei:通訊設備β>」"
  },
  Skill_66534_Name = {
    Text = "通訊設備β"
  },
  Skill_66535_Desc = {
    Text = "「<Etong:惡童>」"
  },
  Skill_66535_Name = {Text = "惡童"},
  Skill_66536_Desc = {
    Text = "「<Biansejushufu:變色拘束服β>」"
  },
  Skill_66536_Name = {
    Text = "變色拘束服β"
  },
  Skill_66537_Desc = {
    Text = "「<Renyuleizhu:人魚淚珠>」"
  },
  Skill_66537_Name = {
    Text = "人魚淚珠"
  },
  Skill_66538_Desc = {
    Text = "「<Kuailechangpian:快樂唱片>」"
  },
  Skill_66538_Name = {
    Text = "快樂唱片"
  },
  Skill_66721_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>，否則獲得<StrengthenKeywords:強化>。"
  },
  Skill_66721_Name_1 = {
    Text = "隱世的轉輪"
  },
  Skill_66891_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方喚醒體死亡後，獲得 <Block:[Block:Arg1]> 護盾，將其算力消耗最低的「技能」置入手中。"
  },
  Skill_66891_Name_1 = {
    Text = "純銀的初心"
  },
  Skill_67110_Desc = {
    Text = "在這蒼白的笛聲中，再度安睡吧…"
  },
  Skill_67110_Name = {
    Text = "永恆的安眠"
  },
  Skill_67168_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，施加 2 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_67168_Name = {
    Text = "重創奔襲"
  },
  Skill_67169_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。自身生命上限+[Arg3]％，玩家生命上限-[Arg3]％。"
  },
  Skill_67169_Name = {
    Text = "等價交換"
  },
  Skill_67170_Desc = {
    Text = "「缸中之腦分體」觸發「靈質分離」時，<TouquKeywords:永久偷取> 5% <PowerIconKeywords:力量>。回合結束時，召喚 1 名「缸中之腦分體」。"
  },
  Skill_67170_Name = {
    Text = "靈肉@1分"
  },
  Skill_67171_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Power:Arg2] 點<PowerIconKeywords:力量> ，獲得狀態「不定壁壘」：消耗算力後獲得 <Block:[Block:Arg3]> 點護盾和 3 層臨時加固。"
  },
  Skill_67171_Name = {
    Text = "不定壁壘"
  },
  Skill_67172_Desc = {
    Text = "移除所有「終末」，將玩家的生命上限變更為 1。"
  },
  Skill_67172_Name = {
    Text = "虛無終結"
  },
  Skill_67173_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:臨時力量>和 <Block:[Block:Arg2]> 點護盾。"
  },
  Skill_67173_Name = {
    Text = "七藝，傳承美德"
  },
  Skill_67174_Desc = {
    Text = "回合結束時，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。護盾被擊破時，獲得的臨時<ReinforcePVEKeywords:加固>由 35 層提高至 75 層。"
  },
  Skill_67174_Name = {
    Text = "騎士熱誠"
  },
  Skill_67175_Desc = {
    Text = "造成 [Arg1] 點傷害 [Arg2] 次，棄掉玩家保留的卡牌。"
  },
  Skill_67175_Name = {
    Text = "弱點打擊"
  },
  Skill_67176_Desc = {
    Text = "從「蹣跚」、「窒息」、「珊瑚贅生」、「褻瀆假像」、「狂放」中選擇一張加入手中，其餘四張置入棄牌堆。"
  },
  Skill_67176_Name = {
    Text = "世界演繹法"
  },
  Skill_67177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，施加 2 回合<FragileIconKeywords:脆弱>。若護盾被擊破，變為「重創奔襲」：不再施加脆弱，改為施加重創。"
  },
  Skill_67177_Name = {
    Text = "盾裂衝擊"
  },
  Skill_67178_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次並施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_67178_Name = {
    Text = "終末狂想"
  },
  Skill_67180_Desc = {
    Text = "接下來 [Arg1] 回合內，每回合結束時，召喚一名「缸中之腦分體」。"
  },
  Skill_67180_Name = {Text = "分離"},
  Skill_67181_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害 [Arg2] 次，後續釋放的「女王之劍」傷害次數提高 1。"
  },
  Skill_67181_Name = {
    Text = "女王之劍"
  },
  Skill_67182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> [Arg2] 次並施加等量<BleedingIconKeywords:出血>，施加 1 回合<VulnerabilityIconKeywords:易傷>。若護盾被擊破，變為「暴怒之槍」：不再造成穿刺傷害和出血，但傷害次數提高 1。"
  },
  Skill_67182_Name = {
    Text = "「穿刺」之槍"
  },
  Skill_67183_Desc = {
    Text = "造成  <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。"
  },
  Skill_67183_Name = {Text = "打擊"},
  Skill_67184_Desc = {
    Text = "抽牌階段結束後從手中隨機展示 3 張指令卡，選擇一張賦予「回聲」刻印，棄掉其它卡牌。"
  },
  Skill_67184_Name = {
    Text = "第一哲學"
  },
  Skill_67185_Desc = {
    Text = "<WeaknessIconKeywords:虛弱> 2 回合，施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>。"
  },
  Skill_67185_Name = {
    Text = "外域手術"
  },
  Skill_67186_Desc = {
    Text = "施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>。回合結束後，其它敵人獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_67186_Name = {
    Text = "宿命坍縮"
  },
  Skill_67187_Desc = {
    Text = "<TouquKeywords:永久偷取> [Arg1] 點<PowerIconKeywords:力量> 並移除 50% <RetaliateIconKeywords:反擊>，對 5 張不具有「推演」的卡牌附加「推演」。"
  },
  Skill_67187_Name = {
    Text = "攻勢推演"
  },
  Skill_67188_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。打開「深淵之門」，每回合結束時都會補充敵人，最多 2 名。"
  },
  Skill_67188_Name = {
    Text = "終點，真理與深淵之門"
  },
  Skill_67189_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，<VulnerabilityIconKeywords:易傷>自身 1 回合。"
  },
  Skill_67189_Name = {
    Text = "「暴怒」之槍"
  },
  Skill_67190_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虛弱>，獲得 [Arg2] 層<ReinforcePVEKeywords:加固>。"
  },
  Skill_67190_Name = {
    Text = "自毀改造"
  },
  Skill_67191_Desc = {
    Text = "回合開始時，獲得 1 層「終末」。每當玩家打出卡牌後，獲得 [Arg1] 層<ReinforcePVEKeywords:加固>。受到致死傷害後移除該狀態並免疫 1 回合傷害，回復 15% 生命並將意圖切換為「虛無終結」。"
  },
  Skill_67191_Name = {
    Text = "靈魂瘟疫"
  },
  Skill_67348_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>和 1 層「終末」。如果擊破了所有其他敵人，意圖變為「宿命坍縮」。"
  },
  Skill_67348_Name = {
    Text = "呼喚終末"
  },
  Skill_67349_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>和 1 層「終末」。如果擊破了所有其他敵人，意圖變為「自毀改造」。"
  },
  Skill_67349_Name = {
    Text = "呼喚終末"
  },
  Skill_67383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。自身生命上限+[Arg3]％，玩家生命上限-[Arg4]％。"
  },
  Skill_67383_Name = {
    Text = "等價交換"
  },
  Skill_67421_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺>傷害 [AttackTimes:Arg2] 次，該傷害無法規避。"
  },
  Skill_67421_Name = {
    Text = "終結……"
  },
  Skill_67431_Desc = {
    Text = "「<Heizhu:黑燭>」"
  },
  Skill_67431_Name = {Text = "黑燭"},
  Skill_67433_Desc = {
    Text = "「<Guishulimao:詭術禮帽>」"
  },
  Skill_67433_Name = {
    Text = "詭術禮帽"
  },
  Skill_67434_Desc = {
    Text = "「<Slbbujie:時靈擺·不潔>」"
  },
  Skill_67434_Name = {
    Text = "時靈擺·不潔"
  },
  Skill_67435_Desc = {
    Text = "「<Slbbumian:時靈擺·不眠>」"
  },
  Skill_67435_Name = {
    Text = "時靈擺·不眠"
  },
  Skill_67436_Desc = {
    Text = "「<Szeyunyishiniao:受祝·厄運儀式鳥>」"
  },
  Skill_67436_Name = {
    Text = "受祝·厄運儀式鳥"
  },
  Skill_67437_Desc = {
    Text = "「<Shishengchangji:失聲唱機>」"
  },
  Skill_67437_Name = {
    Text = "失聲唱機"
  },
  Skill_67438_Desc = {
    Text = "「<Yishengshoutixiang:醫生手提箱>」"
  },
  Skill_67438_Name = {
    Text = "醫生手提箱"
  },
  Skill_67441_Desc = {
    Text = "「<Slbyiyong:時靈擺·移湧>」"
  },
  Skill_67441_Name = {
    Text = "時靈擺·移湧"
  },
  Skill_67443_Desc = {
    Text = "「<Baiyahui:白鴉喙>」"
  },
  Skill_67443_Name = {Text = "白鴉喙"},
  Skill_67444_Desc = {
    Text = "「<Chansimanao:纏絲瑪瑙>」"
  },
  Skill_67444_Name = {
    Text = "纏絲瑪瑙"
  },
  Skill_67445_Desc = {
    Text = "「<Meilishunjian:美麗瞬間β>」"
  },
  Skill_67445_Name = {
    Text = "美麗瞬間β"
  },
  Skill_67446_Desc = {
    Text = "「<Yuanxingdianchi:原型電池>」"
  },
  Skill_67446_Name = {
    Text = "原型電池"
  },
  Skill_67447_Desc = {
    Text = "「<Guguaigouzhua:古怪鉤爪>」"
  },
  Skill_67447_Name = {
    Text = "古怪鉤爪"
  },
  Skill_67448_Desc = {
    Text = "「<Szemengbiaoxiang:受祝·噩夢表像β>」"
  },
  Skill_67448_Name = {
    Text = "受祝·噩夢表像β"
  },
  Skill_67449_Desc = {
    Text = "回復 25% 最大生命，並提高 10% 生命上限。"
  },
  Skill_67449_Name = {
    Text = "朵爾 · 支援"
  },
  Skill_67451_Desc = {
    Text = "「<Chenzhonghuakuang:沉重畫框>」"
  },
  Skill_67451_Name = {
    Text = "沉重畫框"
  },
  Skill_67453_Desc = {
    Text = "「<Slbyuyi:時靈擺·羽翼>」"
  },
  Skill_67453_Name = {
    Text = "時靈擺·羽翼"
  },
  Skill_67454_Desc = {
    Text = "「<Dingxiangluopan:定向羅盤>」"
  },
  Skill_67454_Name = {
    Text = "定向羅盤"
  },
  Skill_67455_Desc = {
    Text = "「<Szguguaigouzhua:受祝·古怪鉤爪>」"
  },
  Skill_67455_Name = {
    Text = "受祝·古怪鉤爪"
  },
  Skill_67456_Desc = {
    Text = "「<Szyishimingke:受祝·意識銘刻β>」"
  },
  Skill_67456_Name = {
    Text = "受祝·意識銘刻β"
  },
  Skill_67457_Desc = {
    Text = "「<Jiajisiquanzhang:祭司權杖+>」"
  },
  Skill_67457_Name = {
    Text = "祭司權杖+"
  },
  Skill_67458_Desc = {
    Text = "「<Slbtoushe:時靈擺·投射>」"
  },
  Skill_67458_Name = {
    Text = "時靈擺·投射"
  },
  Skill_67464_Desc = {
    Text = "「<Guaishecantui:怪蛇殘蛻>」"
  },
  Skill_67464_Name = {
    Text = "怪蛇殘蛻"
  },
  Skill_67466_Desc = {
    Text = "「<Aerkanajilu:阿爾卡納記錄>」"
  },
  Skill_67466_Name = {
    Text = "阿爾卡納記錄"
  },
  Skill_67467_Desc = {
    Text = "「<Xiushiliuyedao:銹蝕柳葉刀>」"
  },
  Skill_67467_Name = {
    Text = "銹蝕柳葉刀"
  },
  Skill_67469_Desc = {
    Text = "「<Jiariyuelunpan:日月輪盤+>」"
  },
  Skill_67469_Name = {
    Text = "日月輪盤+"
  },
  Skill_67470_Desc = {
    Text = "將 1 張「不竭戰意」置入手中，本回合內「打擊」算力消耗降低 1。"
  },
  Skill_67470_Name = {
    Text = "蘿坦 · 支援"
  },
  Skill_67471_Desc = {
    Text = "「<Guhuofengling:蠱惑風鈴>」"
  },
  Skill_67471_Name = {
    Text = "蠱惑風鈴"
  },
  Skill_67473_Desc = {
    Text = "「<Szheizhu:受祝·黑燭>」"
  },
  Skill_67473_Name = {
    Text = "受祝·黑燭"
  },
  Skill_67474_Desc = {
    Text = "獲得等同於永久力量 50% 的臨時力量，獲得最大生命 50% 的護盾。"
  },
  Skill_67474_Name = {
    Text = "奧吉爾 · 支援"
  },
  Skill_67475_Desc = {
    Text = "「<Womendejia:我們的家>」"
  },
  Skill_67475_Name = {
    Text = "我們的家"
  },
  Skill_67476_Desc = {
    Text = "「<Eyunyishiniao:厄運儀式鳥>」"
  },
  Skill_67476_Name = {
    Text = "厄運儀式鳥"
  },
  Skill_67477_Desc = {
    Text = "「<Zaixiguangli:在夕光裡>」"
  },
  Skill_67477_Name = {
    Text = "在夕光裡"
  },
  Skill_67479_Desc = {
    Text = "「<Szqisaimanzhiwen:受祝·七鰓鰻之吻>」"
  },
  Skill_67479_Name = {
    Text = "受祝·七鰓鰻之吻"
  },
  Skill_67481_Desc = {
    Text = "「<Jierizhufu:節日祝福>」"
  },
  Skill_67481_Name = {
    Text = "節日祝福"
  },
  Skill_67482_Desc = {
    Text = "「<Slbyan:時靈擺·眼>」"
  },
  Skill_67482_Name = {
    Text = "時靈擺·眼"
  },
  Skill_67483_Desc = {
    Text = "「<Geyushan:鴿羽扇>」"
  },
  Skill_67483_Name = {Text = "鴿羽扇"},
  Skill_67484_Desc = {
    Text = "「<Slbyanhua:時靈擺·衍化>」"
  },
  Skill_67484_Name = {
    Text = "時靈擺·衍化"
  },
  Skill_67488_Desc = {
    Text = "「<Wanxianglingzhimiyi:萬象靈知秘儀>」"
  },
  Skill_67488_Name = {
    Text = "萬象靈知秘儀"
  },
  Skill_67490_Desc = {
    Text = "「<Slbshuangsheng:時靈擺·雙生>」"
  },
  Skill_67490_Name = {
    Text = "時靈擺·雙生"
  },
  Skill_67491_Desc = {
    Text = "「<Yixiangyoupiaojia:異鄉郵票夾>」"
  },
  Skill_67491_Name = {
    Text = "異鄉郵票夾"
  },
  Skill_67493_Desc = {
    Text = "「<Yinbaichaifenji:銀白差分機>」"
  },
  Skill_67493_Name = {
    Text = "銀白差分機"
  },
  Skill_67494_Desc = {
    Text = "「<Zhongsuo:重鎖>」"
  },
  Skill_67494_Name = {Text = "重鎖"},
  Skill_67495_Desc = {
    Text = "「<Beiyiwangzhezhixue:被遺忘者之血>」"
  },
  Skill_67495_Name = {
    Text = "被遺忘者之血"
  },
  Skill_67496_Desc = {
    Text = "「<Szchongqunyishi:受祝·蟲群意識>」"
  },
  Skill_67496_Name = {
    Text = "受祝·蟲群意識"
  },
  Skill_67497_Desc = {
    Text = "「<Qiuzhidushulun:求知讀書輪>」"
  },
  Skill_67497_Name = {
    Text = "求知讀書輪"
  },
  Skill_67498_Desc = {
    Text = "「<Jiatongxunshebei:通訊設備+β>」"
  },
  Skill_67498_Name = {
    Text = "通訊設備+β"
  },
  Skill_67499_Desc = {
    Text = "選擇 1 張抽牌堆或棄牌堆的牌置入手牌，複製一張並使它們算力消耗變為 0。"
  },
  Skill_67500_Desc = {
    Text = "「<Jisiquanzhang:祭司權杖>」"
  },
  Skill_67500_Name = {
    Text = "祭司權杖"
  },
  Skill_67501_Desc = {
    Text = "「<Meixueyuanli:美學原理>」"
  },
  Skill_67501_Name = {
    Text = "美學原理"
  },
  Skill_67502_Desc = {
    Text = "「<Riyuelunpan:日月輪盤>」"
  },
  Skill_67502_Name = {
    Text = "日月輪盤"
  },
  Skill_67699_Desc = {
    Text = "「<Misagehuizhang:彌薩格徽章>」"
  },
  Skill_67699_Name = {
    Text = "彌薩格徽章"
  },
  Skill_67700_Desc = {
    Text = "「<Wumingzhishenmiansha:無名之神的面紗>」"
  },
  Skill_67700_Name = {
    Text = "無名之神的面紗"
  },
  Skill_67759_Name = {
    Text = "黃金測試包"
  },
  Skill_67760_Name = {
    Text = "棱彩測試包"
  },
  Skill_67761_Name = {
    Text = "白銀測試包"
  },
  Skill_67780_Desc = {
    Text = "自爆。造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。「缸中之腦」回復自身剩餘生命 2 倍的生命。"
  },
  Skill_67780_Name = {
    Text = "自毀程序"
  },
  Skill_67855_AwakerSkillBackgroundStory = {
    Text = "這雙眼睛已無法正常視物。\n她直面時間與現實的風暴，任由呼嘯的混沌切割、攪碎，最後成為她的眼睛。\n屬於「拉蒙娜」的又一個痕跡正從她的身上消失，她抓不住流失的自己，正如她未能抓住從指尖流失的生命。"
  },
  Skill_67855_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。選擇 1 張抽牌堆的牌置入手中並使其算力消耗 -1。"
  },
  Skill_67855_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_67856_AwakerSkillBackgroundStory = {
    Text = "在漫長的孤寂中，她早已忘記了為何而揮劍。\n但她清楚地知道，自己必須揮出這一劍。"
  },
  Skill_67856_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，<PowerIconKeywords:力量>在「命定之劍」上發揮 [Arg2] 倍效果。每次使用鑰令時，力量倍率在本場戰鬥中提高 1 倍。"
  },
  Skill_67856_EffectNameList_0 = {Text = "傷害"},
  Skill_67856_Name = {
    Text = "命定之劍"
  },
  Skill_67856_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,"
  },
  Skill_67868_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_67869_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_67870_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_67871_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_68550_Desc = {
    Text = "祂很好奇。造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得狀態「憤怒」，敵方的力量將持續增長！"
  },
  Skill_68550_Name = {Text = "褻瀆"},
  Skill_68551_Desc = {
    Text = "祂看著你。將一張「症狀」永久置入你的牌庫。"
  },
  Skill_68551_Name = {Text = "凝視"},
  Skill_68552_Desc = {
    Text = "祂在疑惑。造成 <BlindingKeywords:致盲> 2 回合和 [Arg1] 點<BleedingIconKeywords:出血>。"
  },
  Skill_68552_Name = {Text = "侵擾"},
  Skill_68659_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_95:「追憶-烏托邦帷幕」>置入抽牌堆和棄牌堆。"
  },
  Skill_68659_Name = {
    Text = "追憶微光-烏托邦帷幕"
  },
  Skill_68660_Desc = {
    Text = "獲得 2 點算力。查看 3 個鑰令，選擇 1 個立即釋放，驅散自身負面狀態並回復 25% 已損失生命。"
  },
  Skill_68660_Name = {
    Text = "追憶-烏托邦帷幕"
  },
  Skill_68661_Desc = {
    Text = "從手牌中選擇一張非衍生指令卡，其算力消耗在本場戰鬥中永久降低 1，並將 1 張此卡牌的複製置入手中。"
  },
  Skill_68661_Name = {
    Text = "追憶-未完的蠟像"
  },
  Skill_68662_Desc = {
    Text = "棄掉所有手牌，抽取棄牌數 +3 的卡牌並使它們算力消耗降低 1。"
  },
  Skill_68662_Name = {
    Text = "追憶-畸變之心"
  },
  Skill_68663_Desc = {
    Text = "獲得 2 層臨時<ParcloseIconKeywords:屏障>。下回合開始時額外抽 3 張牌，獲得 3 點算力。"
  },
  Skill_68663_Name = {
    Text = "追憶-蜂蜜甜酒"
  },
  Skill_68664_Desc = {
    Text = "選擇 1 張非衍生指令卡，將其 10 張原始複製洗入抽牌堆。這些卡牌直到下次打出前，算力消耗降低 2。"
  },
  Skill_68664_Name = {
    Text = "追憶-豐穰之核"
  },
  Skill_68665_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_91:「追憶-未完的蠟像」>置入抽牌堆和棄牌堆。"
  },
  Skill_68665_Name = {
    Text = "追憶微光-未完的蠟像"
  },
  Skill_68666_Desc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣，可使用 3 次(當前已使用 [Arg2] 次)。"
  },
  Skill_68666_Name = {
    Text = "追憶-天真的回禮"
  },
  Skill_68667_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_90:「追憶-天真的回禮」>置入抽牌堆和棄牌堆。"
  },
  Skill_68667_Name = {
    Text = "追憶微光-天真的回禮"
  },
  Skill_68668_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_94:「追憶-代行者的裁決」>置入抽牌堆和棄牌堆。"
  },
  Skill_68668_Name = {
    Text = "追憶微光-代行者的裁決"
  },
  Skill_68669_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_96:「追憶-豐穰之核」>置入抽牌堆和棄牌堆。"
  },
  Skill_68669_Name = {
    Text = "追憶微光-豐穰之核"
  },
  Skill_68670_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_92:「追憶-畸變之心」>置入抽牌堆和棄牌堆。"
  },
  Skill_68670_Name = {
    Text = "追憶微光-畸變之心"
  },
  Skill_68671_Desc = {
    Text = "從抽牌堆或棄牌堆中選擇 1 張卡牌置入手中，使其算力消耗變為 0。 將 1 張<DerivativeCardKeywords_93:「追憶-蜂蜜甜酒」>置入抽牌堆和棄牌堆。"
  },
  Skill_68671_Name = {
    Text = "追憶微光-蜂蜜甜酒"
  },
  Skill_68672_Desc = {
    Text = "對後排敵人造成最大生命值 25％ 的<FixedDamage:純粹傷害>，獲得最大生命值 25％ 的護盾。"
  },
  Skill_68672_Name = {
    Text = "追憶-代行者的裁決"
  },
  Skill_68699_Name = {Text = "ZzZZ…"},
  Skill_68844_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_68873_Desc = {
    Text = "將所有喚醒體的「防禦」置入手中，並使它們算力消耗變為 0。"
  },
  Skill_68874_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，並將其他喚醒體的「打擊」置入手中，並使它們算力消耗變為 0。"
  },
  Skill_68874_Name = {
    Text = "不竭戰意β"
  },
  Skill_68950_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_68950_Name = {
    Text = "原初混沌之種"
  },
  Skill_68951_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_68951_Name = {
    Text = "原初混沌之靈"
  },
  Skill_68952_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69783_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69784_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69785_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69785_Name = {
    Text = "原初混沌之種"
  },
  Skill_69786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69786_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69788_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69788_Name = {
    Text = "原初混沌之種"
  },
  Skill_69789_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69789_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69790_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69790_Name = {
    Text = "原初混沌之種"
  },
  Skill_69791_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69791_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69792_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69793_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69793_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69794_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69795_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69795_Name = {
    Text = "原初混沌之種"
  },
  Skill_69796_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69797_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69797_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69798_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69798_Name = {
    Text = "原初混沌之種"
  },
  Skill_69799_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69799_Name = {
    Text = "原初混沌之靈"
  },
  Skill_69800_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69800_Name = {
    Text = "原初混沌之種"
  },
  Skill_69801_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_69801_Name = {
    Text = "原初混沌之種"
  },
  Skill_69802_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>、<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69803_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 層<IntoxicationIconKeywords:中毒>和 [Arg4] 層<BleedingIconKeywords:出血>。"
  },
  Skill_69803_Name = {
    Text = "原初混沌之靈"
  },
  Skill_70013_Desc = {
    Text = "消耗 5 點「深淵源能」，選擇一名喚醒體，使其獲得 [Arg1] 點狂氣。回合開始時，所有喚醒體獲得 [Arg2] 點狂氣，持續至戰鬥結束。"
  },
  Skill_70013_Name = {Text = "甦醒Ⅱ"},
  Skill_70014_Desc = {
    Text = "消耗 10 點「深淵源能」，將 1 張<DerivativeCardKeywords_60:「王權」>置入手中，所有喚醒體暴擊率和暴擊傷害提高 25％。"
  },
  Skill_70014_Name = {Text = "甦醒Ⅲ"},
  Skill_70015_Desc = {
    Text = "消耗 1 點「深淵源能」，將 1 張<DerivativeCardKeywords_4:「靈感」>置入手中，獲得 [Arg1] 點臨時力量和臨時觸腕傷害。"
  },
  Skill_70015_Name = {Text = "甦醒Ⅰ"},
  Skill_70043_Name = {Text = "ZzZZ…"},
  Skill_70044_Desc = {
    Text = "對後排敵人造成最大生命值 15％ 的<FixedDamage:純粹傷害>，獲得最大生命值 25％ 的護盾。"
  },
  Skill_70044_Name = {
    Text = "追憶-代行者的裁決"
  },
  Skill_70142_Desc = {
    Text = "獲得 [Arg1] 點護盾，額外積攢 1 點「深淵源能」。"
  },
  Skill_70286_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，使手牌中裝備者所有「技能」造成的傷害、治療與護盾提高 [Arg1]%。"
  },
  Skill_70299_AwakerSkillBackgroundStory = {
    Text = "她一生追尋的終點，如今擺在近在咫尺的眼前。\n漆黑的大門散發著致命的吸引。\n在推開門之前，她構想了372種真理的可能性。\n在推開門之後，只剩下她不願承認的第373種。\n沒有選擇，她只能墜落。\n運氣真是差啊，自己和整個世界。"
  },
  Skill_70299_BattleDesc = {
    Text = "其它喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>，臨時傷害強效 +[Arg3]％。"
  },
  Skill_70299_Desc = {
    Text = "其它喚醒體獲得 <Energy:[Energy:Arg1]> 點狂氣，對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>，臨時傷害強效 +[Arg3]％。「終末形態」：額外抽 3 張牌，獲得 3 點算力，觸發所有敵人 50％ 的<IntoxicationIconKeywords:中毒>，「熔毀·朵爾」的基礎狂氣提升 50 點，至多提升 3 次。"
  },
  Skill_70299_EffectNameList = {
    Text = "狂氣,中毒,傷害強效"
  },
  Skill_70299_Name = {
    Text = "終點，真理與深淵之門"
  },
  Skill_70299_OverLimitUtlSkillDesc = {
    Text = "其它喚醒體獲得 <Energy:[Energy:Arg4]> 點狂氣，對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>，臨時傷害強效 +[Arg3]％，所有喚醒體造成的<IntoxicationIconKeywords:中毒>、<RetaliateIconKeywords:反擊>、基礎傷害提升 10％。若當前為首領戰，額外獲得 1 層「終末」。"
  },
  Skill_70299_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2,$GrowValue3％"
  },
  Skill_70300_AwakerSkillBackgroundStory = {
    Text = "猩紅的孢囊在機械甲殼下膨脹時，黃銅共振器編織出蜂巢狀的防禦矩陣。\n菌絲脈衝網割裂空間，酸霧蝕刻出警告銘文，而記憶剝離光束正在預熱——凡觸碰邊界的血肉，終將成為培養皿裡抽搐的標本。"
  },
  Skill_70300_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_70300_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。「熔燬·朵爾」獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_70300_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_70300_Name = {Text = "防禦"},
  Skill_70300_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_70301_AwakerSkillBackgroundStory = {
    Text = "螯足來自她的過去，她的種族，是她未曾捨棄的力量。\n當那雙螯足刺穿敵人的胸膛時，綻放的笑意究竟是何含義呢？"
  },
  Skill_70301_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_70301_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。「熔燬·朵爾」獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_70301_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_70301_Name = {Text = "打擊"},
  Skill_70301_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_70302_AwakerSkillBackgroundStory = {
    Text = "她獻祭了自我，換來觸碰真實的資格。\n當她收回手時，她的靈魂已融化如蠟。"
  },
  Skill_70302_BattleDesc_0 = {
    Text = "「熔毀·朵爾」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合結束時，回復 <Heal:[Heal:Arg2]> 點生命並獲得 <Energy:[Energy:Arg4]> 點狂氣。「終末形態」：不再回復生命，改為觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_BattleDesc_15 = {
    Text = "「熔毀·朵爾」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：每擁有 1 層「終末」傷害強效 +8％。「虛無終結」使所有喚醒體獲得 30％ 基礎狂氣。回合結束時，回復 <Heal:[Heal:Arg2]> 點生命並獲得 <Energy:[Energy:Arg4]> 點狂氣。「終末形態」：不再回復生命，改為觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_Desc_0 = {
    Text = "「熔燬·朵爾」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合結束時，回復 <Heal:[Heal:Arg2]> 點生命並獲得等同於自身狂氣回充的狂氣。「終末形態」：不再回復生命，改為觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_Desc_15 = {
    Text = "「熔毀·朵爾」獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：每擁有 1 層「終末」傷害強效 +8％。「虛無終結」使所有喚醒體獲得 30％ 基礎狂氣。回合結束時，回復 <Heal:[Heal:Arg2]> 點生命並獲得等同於自身狂氣回充的狂氣。「終末形態」：不再回復生命，改為觸發所有敵人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_EffectNameList = {
    Text = "狂氣,回復,觸發中毒比例"
  },
  Skill_70302_Name = {
    Text = "靈魂瘟疫"
  },
  Skill_70302_PropertyNameList = {
    Text = "$GrowValue1,體質*GrowValue2,$GrowValue3％,"
  },
  Skill_70303_AwakerSkillBackgroundStory = {
    Text = "如果我們一直走在湮滅的單向道上，那麼走得快一些是否是一種仁慈。\n當末日一瞬間發生，痛苦也將凝結在一瞬。\n人們只需與愛的人擁抱，然後共同迎接寂滅的虛無。\n若終點不再有痛苦，是否也算到達天堂？"
  },
  Skill_70303_BattleDesc_0 = {
    Text = "對所有敵人造成其最大生命值 25％ 的<FixedDamage:純粹傷害>（最低為[Arg2]），使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  Skill_70303_BattleDesc_3 = {
    Text = "對所有敵人造成其最大生命值 30％ 的<FixedDamage:純粹傷害>（最低為[Arg2]），恢復 30％ 已損生命（ <Heal:[Heal:Arg3]> ）使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  Skill_70303_Desc_0 = {
    Text = "對所有敵人造成其最大生命值 25％ 的<FixedDamage:純粹傷害>，該傷害不會低於自身最大生命值的 [Arg1]％，使用後「熔毀·朵爾」的特定技能變更為「終末形態」。「虛無終結」的效果僅生效 1 次。"
  },
  Skill_70303_Desc_3 = {
    Text = "對所有敵人造成其最大生命值 30％ 的<FixedDamage:純粹傷害>，該傷害不會低於自身最大生命值的 [Arg1]％，恢復 30％ 已損生命。使用後「熔毀·朵爾」的特定技能變更為「終末形態」。「虛無終結」的效果僅生效 1 次。"
  },
  Skill_70303_Name = {
    Text = "虛無終結"
  },
  Skill_70303_tempBattleDesc_1 = {
    Text = "對所有敵人造成其最大生命值 25％ 的<FixedDamage:純粹傷害>（最低為[Arg2]），使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  Skill_70303_tempBattleDesc_2 = {
    Text = "對所有敵人造成其最大生命值 30％ 的<FixedDamage:純粹傷害>（最低為[Arg2]），恢復 30％ 已損生命（ <Heal:[Heal:Arg3]> ）使用後「熔毀·朵爾」的特定技能變更為「終末形態」。"
  },
  Skill_70303_tempBattleDesc_3 = {
    Text = "對所有敵人造成其最大生命值 30％ 的<FixedDamage:純粹傷害>（最低為[Arg2]），恢復 30％ 已損生命（ <Heal:[Heal:Arg3]> ）使用後「熔毀·朵爾」的特定技能變更為「終末形態」。所有喚醒體獲得 30％ 基礎狂氣。"
  },
  Skill_70304_AwakerSkillBackgroundStory = {
    Text = "人偶的雙手靈巧非常，靈魂的核心在她手中如同乖巧的魔方。\n善良的天才非常願意為你進行免費改造，只是改造後的副作用稍顯誇張。"
  },
  Skill_70304_Desc = {
    Text = "<DerivativeCardKeywords_103:選擇>「興奮」或「詛咒」。"
  },
  Skill_70304_EffectNameList = {
    Text = "興奮強效提高,詛咒力量降低"
  },
  Skill_70304_Name = {
    Text = "自毀改造"
  },
  Skill_70304_PropertyNameList = {
    Text = "$GrowValue1％,防禦力*GrowValue2"
  },
  Skill_70305_AwakerSkillBackgroundStory = {
    Text = "螻蟻對大廈運行原理的猜想，一直愚蠢而可笑。\n所有的理想與信念霎時坍塌倒退，回憶與溫情化為奇點外的虛影。\n在宇宙誕生的原點，那裡空無一物。"
  },
  Skill_70305_Desc = {
    Text = "<DerivativeCardKeywords_104:獲得> <Energy:[Energy:Arg1]> 點狂氣。回復 <Heal:[Heal:Arg2]> 點生命，自身當前每擁有 50 點狂氣，額外回復 1 次生命。"
  },
  Skill_70305_EffectNameList = {
    Text = "狂氣,回復,中毒"
  },
  Skill_70305_Name = {
    Text = "宿命坍縮"
  },
  Skill_70305_PropertyNameList = {
    Text = "$GrowValue1,體質*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_70332_Desc_0 = {
    Text = "使所有敵人臨時降低 [Exhaustion:Arg2] 點<PowerIconKeywords:力量> 。"
  },
  Skill_70332_Desc_1 = {
    Text = "對所有敵人施加 [Arg1] 回合 <WeaknessIconKeywords:虛弱>，並使它們臨時降低 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_70332_Name = {Text = "詛咒"},
  Skill_70333_Desc_0 = {
    Text = "獲得 1 回合「興奮」狀態：傷害強效 +[Arg2]％。"
  },
  Skill_70333_Desc_1 = {
    Text = "獲得 1 回合「興奮」狀態：傷害強效 +[Arg2]％。對所有敵人施加 [Arg1] 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_70333_Name = {Text = "興奮"},
  Skill_70355_Desc_1 = {
    Text = "給予全體友方 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_70355_Name_1 = {
    Text = "腎上腺素"
  },
  Skill_70356_Desc_1 = {
    Text = "抽 [Arg1] 張牌。"
  },
  Skill_70356_Name_1 = {Text = "奇襲"},
  Skill_70357_Desc_1 = {
    Text = "獲得 [Arg1] 算力。"
  },
  Skill_70358_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命，或對一名敵方造成 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_70358_Name_1 = {
    Text = "液化虛無"
  },
  Skill_70359_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者每回合前 [Arg1] 次受到攻擊時，對攻擊者造成<PVPEmptinessKeywords:空虛>。"
  },
  Skill_70359_Name_1 = {
    Text = "墜入虛無的人偶"
  },
  Skill_70360_Desc_1 = {
    Text = "回復全體友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_70360_Name_1 = {
    Text = "拯救計劃"
  },
  Skill_70361_Desc_1 = {
    Text = "給予全體友方 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_70361_Name_1 = {
    Text = "傷害抗體"
  },
  Skill_70362_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_70362_Name_1 = {
    Text = "毀滅計劃"
  },
  Skill_70376_Desc = {
    Text = "失去 [Arg1] 點鑰能，選擇一張「靈知覺醒」置入手中。（每獲得 1 張靈知覺醒使消耗提高 100%，消耗後鑰能可為負值）"
  },
  Skill_70376_Name = {
    Text = "銀鑰覺醒"
  },
  Skill_70383_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70384_Desc = {
    Text = "重新發現 1 次同品質造物，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70825_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣。消耗所有「星辰庇佑」並獲得與消耗層數相同的算力，若當前界域為「深海」，額外生成與消耗層數相同的臨時觸腕。"
  },
  Skill_70825_Name = {Text = "甦醒"},
  Skill_70826_Desc = {
    Text = "獲得 <Block:[Arg1]> 點護盾，獲得 1 層「星辰庇佑」，最大積攢 5 層，戰鬥結束後不清除。"
  },
  Skill_70827_Desc = {
    Text = "選擇一名喚醒體，使其指令卡暴擊率和暴擊傷害臨時提高 [Arg1]% 並獲得 [Arg2] 點狂氣。若莉茲在隊伍中，還會將 1 張附加「消耗」的「腐化綠炎」置入手中。"
  },
  Skill_70827_Name = {
    Text = "黑天鵝的舞步"
  },
  Skill_70828_Desc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣，對所有敵人施加 [Arg2] 層<IntoxicationIconKeywords:中毒>，目標每損失 1％ 生命額外觸發 1％ 中毒，至多觸發 50％中毒。"
  },
  Skill_70828_Name = {
    Text = "虛無瘟疫"
  },
  Skill_70829_Desc = {
    Text = "選擇「<DerivativeCardKeywords_99:沉眠>」或「<DerivativeCardKeywords_100:甦醒>」。"
  },
  Skill_70961_Desc = {
    Text = "從 2 個黃金+造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70962_Desc = {
    Text = "從 2 個白銀造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70963_Desc = {
    Text = "從 2 個時靈擺造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70964_Desc = {
    Text = "從 2 個受祝造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70965_Desc = {
    Text = "從 2 個詛咒造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70966_Desc = {
    Text = "從 2 個黃金造物中選擇 1 個獲得，每場戰鬥共用 1 次刷新機會。"
  },
  Skill_70994_Desc = {
    Text = "10層終末"
  },
  Skill_71522_Desc = {
    Text = "生命上限降低 10％，同時觸發「興奮」和「詛咒」效果。"
  },
  Skill_71522_Name = {
    Text = "自毀改造·終末"
  },
  Skill_71523_Desc = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。對所有敵人施加 [Poison:Arg2] 層<IntoxicationIconKeywords:中毒>。自身當前每擁有 50 點狂氣，額外施加 1 次中毒。"
  },
  Skill_71523_Name = {
    Text = "宿命坍縮·終末"
  },
  Skill_71636_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，將 1 張 <DerivativeCardKeywords_105:「無盡銀芯寶庫」>置入手牌堆中。"
  },
  Skill_71636_Name = {
    Text = "拋灑銀芯"
  },
  Skill_71637_Desc = {
    Text = "似乎被關禁閉了，無法行動。"
  },
  Skill_71637_Name = {
    Text = "禁閉中…"
  },
  Skill_71638_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。對雙方均施加 [Arg3] 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_71638_Name = {Text = "貓貓拳"},
  Skill_71639_Desc = {
    Text = "獲得 [Arg1] 點臨時<PowerIconKeywords:力量>和 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_71652_Desc = {
    Text = "感受銀芯的力量！呼喚當前界域的三名喚醒體，從中選擇 1 個獲得其支援卡牌。"
  },
  Skill_71652_Name = {
    Text = "無盡銀芯寶庫"
  },
  Skill_71691_BattleDesc = {
    Text = "當前死亡抵抗翻倍，臨時降低所有敵人 [Arg1] 點<PowerIconKeywords:力量>，每有 1 名敵人獲得 [Arg1] 點<PowerIconKeywords:臨時力量>。"
  },
  Skill_71691_Desc = {
    Text = "當前死亡抵抗翻倍，<TouquKeywords:永久偷取>所有敵人 [Arg1] 點力量。"
  },
  Skill_71692_Desc = {
    Text = "獲得等同於觸腕傷害 50% 的臨時力量，臨時移除所有敵人的<PowerIconKeywords:力量>並<VulnerabilityIconKeywords:易傷>三回合，獲得等同於移除量的臨時<PowerIconKeywords:力量>。"
  },
  Skill_71692_Name = {
    Text = "戈利亞·支援"
  },
  Skill_71693_Desc = {
    Text = "將 3 張上回合最後打出的非衍生指令卡的臨時複製置入手中，使它們算力消耗變為 0。"
  },
  Skill_71693_Name = {
    Text = "環行·拉蒙娜·支援"
  },
  Skill_71694_Desc = {
    Text = "下回合開始時獲得等同於本回合損失生命的護盾，持續 1 回合。將 3 張「胚胎」置入手中。"
  },
  Skill_71694_Name = {
    Text = "雷婭·支援"
  },
  Skill_71695_Desc = {
    Text = "抽牌直至手牌達到上限。回合結束時每有 1 張手牌在手中，所有喚醒體獲得 5 點狂氣。"
  },
  Skill_71695_Name = {
    Text = "卡茜亞·支援"
  },
  Skill_71696_Desc = {
    Text = "選擇一名喚醒體獲得 35 點狂氣，回合結束時也會重複 1 次，持續 5 回合。"
  },
  Skill_71696_Name = {
    Text = "溫柯爾·支援"
  },
  Skill_71697_Desc = {
    Text = "石化所有敵人 1 回合。若敵人擁有石化抗性，改為對它們造成 25 層易傷。"
  },
  Skill_71697_Name = {
    Text = "艾繼絲·支援"
  },
  Skill_71698_Desc = {
    Text = "使隨機 5 張手牌算力消耗降低 1 點，並獲得最大生命 50% 的護盾。"
  },
  Skill_71699_Desc = {
    Text = "獲得 3 點算力。驅散自身負面狀態並回復 25% 已損失生命，查看 3 個鑰令並選擇 1 個立即釋放。"
  },
  Skill_71699_Name = {
    Text = "希萊斯特·支援"
  },
  Skill_71700_Desc = {
    Text = "選擇一名喚醒體獲得 100 點狂氣，並使其暴擊率和暴擊傷害永久提高 25%。"
  },
  Skill_71700_Name = {
    Text = "尤烏哈希·支援"
  },
  Skill_71701_Desc = {
    Text = "立刻獲得 [Arg1] 點觸腕傷害和 [Arg2] 點臨時反擊。每次受到攻擊後，治療 [Arg3] 點生命，持續 1 回合。"
  },
  Skill_71701_Name = {
    Text = "凱刻斯·支援"
  },
  Skill_71702_Desc = {
    Text = "獲得 35% 臨時暴擊率、75% 臨時暴擊傷害，本回合中造成的最終傷害提高 25%。"
  },
  Skill_71703_Desc = {
    Text = "立刻生成 3 條觸腕，下回合開始時獲得 25% 最大生命的護盾。"
  },
  Skill_71704_Desc = {
    Text = "選擇一名喚醒體，丟棄其所有指令卡，每丟棄 1 張牌就獲得 [Arg1] 點臨時力量，並觸發丟棄卡牌的所有效果。"
  },
  Skill_71704_Name = {
    Text = "莉茲·支援"
  },
  Skill_71705_Desc = {
    Text = "選擇一名喚醒體，抽 3 張該喚醒體的指令卡並使它們算力消耗降低 1。該喚醒體每造成 1 次傷害就使 1 條觸腕攻擊 1 次，持續 1 回合。"
  },
  Skill_71705_Name = {
    Text = "奧瑞塔·支援"
  },
  Skill_71706_Desc = {
    Text = "「打擊」最終傷害提高 100%，每次進行「吞噬」，都會抽 2 張「打擊」並使它們算力消耗降低 1，持續 1 回合。"
  },
  Skill_71834_Desc_1 = {
    Text = "選擇一名敵方，對其造成 <WeaknessIconKeywords:虛弱> 、 <PVPVulnerabilityIconKeywords:易傷>和 1 層<PVPSlowKeywords:遲緩>。"
  },
  Skill_71834_Name_1 = {
    Text = "虛無瘟疫"
  },
  Skill_71834_UnknownName = {
    Text = "虛無瘟疫"
  },
  Skill_71835_Desc_1 = {
    Text = "使一名目標獲得 <DelayKeywords:延遲>：<PVPVulnerabilityIconKeywords:易傷>。"
  },
  Skill_71835_Name_1 = {
    Text = "延遲易傷"
  },
  Skill_71836_Desc_1 = {
    Text = "棄掉對方算力最高的 [Arg1] 張「技能卡」，並使其獲得等量<PVPDerivativeCardKeywords_2:「幻象」>。"
  },
  Skill_71904_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_71904_Name_1 = {Text = "打擊"},
  Skill_71905_Desc_1 = {
    Text = "迫使對手抽 [Arg1] 張牌，對全體敵方造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_71905_Name_1 = {
    Text = "癲狂催化"
  },
  Skill_71906_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，迫使對手棄掉目標的所有手牌以及手中所有命輪卡和鑰令卡，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_71906_Name_1 = {
    Text = "生命重構治療"
  },
  Skill_71907_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，迫使對手棄掉目標的所有手牌。"
  },
  Skill_71907_Name_1 = {
    Text = "心理絞殺"
  },
  Skill_71908_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害，目標每有 1 張手牌對其額外造成 [Arg2] 次傷害。"
  },
  Skill_72025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_72025_Name = {Text = "貓拳"},
  Skill_72107_Desc = {
    Text = "所有敵人在本場戰鬥中獲得 [Power:Arg1] 點<PowerIconKeywords:力量>（無論它們在哪）。召喚 1 名「灰燼融蝕體」。"
  },
  Skill_72107_Name = {
    Text = "銀芯交融"
  },
  Skill_72108_Desc = {
    Text = "獲得「暗殺者」狀態和 2 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_72108_Name = {
    Text = "沒入火燼"
  },
  Skill_72110_Desc = {
    Text = "將 1 張「撥號炸彈」洗入牌庫，造成 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_72110_Name = {Text = "呼喚"},
  Skill_72112_Desc = {
    Text = "召喚 3 個「灰燼融蝕體」和 1 個「緊急聯絡」，自身死亡。"
  },
  Skill_72112_Name = {
    Text = "連結解除"
  },
  Skill_72113_Desc = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害 [AttackTimes:Arg3] 次。所有敵人在本場戰鬥中回合結束時獲得 <Block:[Block:Arg1]> 點護盾（無論它們在哪）。"
  },
  Skill_72113_Name = {
    Text = "融蝕贅生"
  },
  Skill_72114_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 2 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_72114_Name = {Text = "雙螺旋"},
  Skill_72115_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_72115_Desc = {
    Text = "造成 1 次高額傷害。"
  },
  Skill_72115_Name = {
    Text = "物理修復"
  },
  Skill_72116_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 1 回合<BlindingKeywords:致盲>。"
  },
  Skill_72117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得「暗殺者」狀態。"
  },
  Skill_72117_Name = {
    Text = "無火之灰"
  },
  Skill_72118_Desc = {
    Text = "將 1 張「撥號炸彈」洗入牌庫，造成 3 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_72119_Desc = {
    Text = "將 1 張「撥號炸彈」洗入抽牌堆，造成 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_72119_Name = {Text = "呼喚"},
  Skill_72120_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。後排召喚 1 名「灰燼融蝕體」。"
  },
  Skill_72120_Name = {
    Text = "異體排斥"
  },
  Skill_72122_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。後排召喚 1 名「灰燼融蝕體」。"
  },
  Skill_72122_Name = {
    Text = "異體排斥"
  },
  Skill_72123_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_72124_Desc = {
    Text = "所有敵人在本場戰鬥中獲得 [Power:Arg1] 點<PowerIconKeywords:力量>（無論它們在哪）。召喚 1 名「灰燼融蝕體」。"
  },
  Skill_72124_Name = {
    Text = "銀芯交融"
  },
  Skill_72125_Desc = {
    Text = "將 1 張「撥號炸彈」洗入抽牌堆，造成 2 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_72177_BattleDesc = {
    Text = "研究要求：釋放 2 次鑰令。研究成果：所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72177_Desc = {
    Text = "研究要求：釋放 3 次鑰令。研究成果：所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72177_Name = {
    Text = "銀鑰匙研究"
  },
  Skill_72178_BattleDesc = {
    Text = "研究要求：釋放 5 次狂氣爆發。研究成果：選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72178_Desc = {
    Text = "研究要求：釋放 6 次狂氣爆發。研究成果：選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72178_Name = {
    Text = "狂氣研究"
  },
  Skill_72179_BattleDesc = {
    Text = "研究要求：造成 30 次傷害。研究成果：對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72179_Desc = {
    Text = "研究要求：造成 40 次傷害。研究成果：對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72179_Name = {
    Text = "連擊研究"
  },
  Skill_72180_BattleDesc = {
    Text = "獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72180_Desc = {
    Text = "獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72180_Name = {Text = "強心針"},
  Skill_72181_BattleDesc = {
    Text = "獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72181_Desc = {
    Text = "獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72181_Name = {
    Text = "爆發式興奮"
  },
  Skill_72182_BattleDesc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72182_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72182_Name = {
    Text = "來自深淵的癲狂"
  },
  Skill_72183_BattleDesc = {
    Text = "研究要求：造成 10 次護盾或治療。研究成果：獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72183_Desc = {
    Text = "研究要求：造成 15 次護盾或治療。研究成果：獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72184_BattleDesc = {
    Text = "研究要求：釋放 2 次鑰令。研究成果：所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72184_Desc = {
    Text = "研究要求：釋放 3 次鑰令。研究成果：所有喚醒體獲得 [Arg1] 點狂氣，每回合結束時額外獲得 [Arg2] 狂氣。"
  },
  Skill_72184_Name = {
    Text = "銀鑰匙研究"
  },
  Skill_72185_BattleDesc = {
    Text = "選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72185_Desc = {
    Text = "選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72185_Name = {
    Text = "瓶裝虛無"
  },
  Skill_72186_BattleDesc = {
    Text = "研究要求：使用 15 張指令卡。研究成果：獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72186_Desc = {
    Text = "研究要求：使用 20 張指令卡。研究成果：獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72186_Name = {
    Text = "指令儀研究"
  },
  Skill_72187_BattleDesc = {
    Text = "研究要求：造成 10 次護盾或治療。研究成果：獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72187_Desc = {
    Text = "研究要求：造成 15 次護盾或治療。研究成果：獲得 [Arg1] 點算力，抽 [Arg1] 張牌。算力上限和抽牌數 + [Arg2]。"
  },
  Skill_72188_BattleDesc = {
    Text = "研究要求：使用 15 張指令卡。研究成果：獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72188_Desc = {
    Text = "研究要求：使用 20 張指令卡。研究成果：獲得 100% 傷害強效和 15% 暴擊率，本回合內效果翻倍。"
  },
  Skill_72188_Name = {
    Text = "指令儀研究"
  },
  Skill_72189_BattleDesc = {
    Text = "對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72189_Desc = {
    Text = "對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72190_BattleDesc = {
    Text = "研究要求：釋放 5 次狂氣爆發。研究成果：選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72190_Desc = {
    Text = "研究要求：釋放 6 次狂氣爆發。研究成果：選擇手中的 3 張指令卡賦予「合奏」刻印。"
  },
  Skill_72190_Name = {
    Text = "狂氣研究"
  },
  Skill_72191_BattleDesc = {
    Text = "研究要求：造成 30 次傷害。研究成果：對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72191_Desc = {
    Text = "研究要求：造成 40 次傷害。研究成果：對所有敵人造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>，使他們失去 [Arg2] 點<ExhaustionIconKeywords:力量>。"
  },
  Skill_72191_Name = {
    Text = "連擊研究"
  },
  Skill_72827_BattleDesc = {
    Text = "對所有敵人造成其最大生命值 [Arg1]％ 的<FixedDamage:純粹傷害>（最低為[Arg3]）。"
  },
  Skill_72827_Desc = {
    Text = "對所有敵人造成其最大生命值 [Arg1]％ 的<FixedDamage:純粹傷害>，該傷害不會低於自身最大生命值的 [Arg2]％。"
  },
  Skill_72827_Name = {
    Text = "虛無終結"
  },
  Skill_73475_Desc = {
    Text = "將 1 張「狂放」洗入抽牌堆。"
  },
  Skill_73476_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。打出覺醒卡後意圖更改為「心理絞殺」。"
  },
  Skill_73477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_73477_Name = {Text = "自毀"},
  Skill_73482_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱>。移除自身一半層數的<MadnessIconKeywords:瘋狂>和<PowerIconKeywords:力量>，回復已損失生命的 10%。"
  },
  Skill_73482_Name = {
    Text = "精神撫慰"
  },
  Skill_73484_Desc = {
    Text = "在手中時，打出算力消耗為 3 的卡牌後，受到 [Arg1] 點<FixedDamage:純粹傷害>，變形為 1 張算力消耗為 1 或 2 的「撥號炸彈」。打出後抽等同於算力消耗的牌。"
  },
  Skill_73484_Name = {
    Text = "撥號炸彈"
  },
  Skill_73485_Desc = {
    Text = "在手中時，打出算力消耗為 2 的卡牌後，受到 [Arg1] 點<FixedDamage:純粹傷害>，變形為 1 張算力消耗為 1 或 3 的「撥號炸彈」。打出後抽等同於算力消耗的牌。"
  },
  Skill_73485_Name = {
    Text = "撥號炸彈"
  },
  Skill_73486_Desc = {
    Text = "在手中時，打出算力消耗為 1 的卡牌後，受到 [Arg1] 點<FixedDamage:純粹傷害>，變形為 1 張算力消耗為 2 或 3 的「撥號炸彈」。打出後抽等同於算力消耗的牌。"
  },
  Skill_73486_Name = {
    Text = "撥號炸彈"
  },
  Skill_73525_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 2 回合<BlindingKeywords:致盲>。"
  },
  Skill_73526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，自身獲得 [Arg2] 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_73527_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_73528_Desc = {
    Text = "召喚兩個「不會吧…」，全體友方獲得 3 層<ParcloseIconKeywords:屏障>。"
  },
  Skill_73536_Desc = {
    Text = "從已解鎖的 3 個隨機鑰令中選擇 1 個立刻釋放。"
  },
  Skill_73536_Name = {
    Text = "銀鑰微光"
  },
  Skill_74028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 3 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_74028_Name = {Text = "雙螺旋"},
  Skill_74029_Desc = {
    Text = "所有敵人在本場戰鬥中永久獲得 [Power:Arg1] 點<PowerIconKeywords:力量>（無論它們在哪）。召喚 1 名「緊急聯絡」和 1 名「灰燼融蝕體」。"
  },
  Skill_74029_Name = {
    Text = "永恆共生"
  },
  Skill_74030_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_74030_Desc = {
    Text = "造成 1 次高額傷害。"
  },
  Skill_74030_Name = {
    Text = "物理修復"
  },
  Skill_74036_Desc = {
    Text = "回合開始時，隨機對 2 張沒有「認知錯亂」的指令施加「認知錯亂」。"
  },
  Skill_74036_Name = {
    Text = "靈智催眠"
  },
  Skill_74037_Desc = {
    Text = "回合開始時，隨機對 2 張沒有「認知錯亂」的指令施加「認知錯亂」。"
  },
  Skill_74037_Name = {
    Text = "靈智催眠"
  },
  Skill_74038_Desc = {
    Text = "回合開始時，隨機對 2 張沒有「認知錯亂」的指令施加「認知錯亂」。"
  },
  Skill_74038_Name = {
    Text = "靈智催眠"
  },
  Skill_74039_Desc = {
    Text = "回合開始時，隨機對 2 張沒有「認知錯亂」的指令施加「認知錯亂」。"
  },
  Skill_74040_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。清空保留的手牌，將 3 張「靈感」和 3 種不同算力的「撥號炸彈」置入手中。"
  },
  Skill_74040_Name = {Text = "觸達"},
  Skill_74042_Desc = {
    Text = "打出非消耗指令卡時若「備用腦缸」中無該卡牌，將其 [Arg1] 張消耗複製填入「備用腦缸」，每回合最多生效 1 次。打出後將最多 3 張「備用腦缸」中的牌置入手中。"
  },
  Skill_74042_Name = {
    Text = "備用腦缸"
  },
  Skill_74083_Desc = {
    Text = "所有喚醒體獲得 <Energy:[Arg1]> 點狂氣，虛弱和易傷所有敵人 2 回合。"
  },
  Skill_74083_Name = {
    Text = "狂亂熔燬"
  },
  Skill_74300_Desc = {
    Text = "回合結束後，若自身存活，玩家探索失敗。該意圖無法被切換。"
  },
  Skill_74300_Name = {
    Text = "終結……"
  },
  Skill_74792_Desc = {
    Text = "將銀鑰能量和所有喚醒體的狂氣填充至最大值。"
  },
  Skill_74792_Name = {
    Text = "光錐界限"
  },
  Skill_74819_BattleDesc = {
    Text = "本回合所有喚醒體暴擊和暴擊傷害提高 [Arg1]%"
  },
  Skill_74819_Desc = {
    Text = "本回合所有喚醒體暴擊和暴擊傷害提高 [Arg1]%"
  },
  Skill_74820_BattleDesc = {
    Text = "對全體敵方造成 [Arg1] 點中毒"
  },
  Skill_74820_Desc = {
    Text = "對全體敵方造成 [Arg1] 點中毒"
  },
  Skill_74820_Name = {
    Text = "原質的污染"
  },
  Skill_74821_BattleDesc = {
    Text = "隨機造成 [Arg1] 點傷害 [Arg2] 次（該傷害受到1倍力量加成）"
  },
  Skill_74821_Desc = {
    Text = "隨機造成 [Arg1] 點傷害 [Arg2] 次（該傷害受到1倍力量加成）"
  },
  Skill_74822_BattleDesc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74822_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74822_Name = {
    Text = "請盡情挑選"
  },
  Skill_74823_BattleDesc = {
    Text = "對全體敵方造成已損失生命  [Arg1]% 的傷害"
  },
  Skill_74823_Desc = {
    Text = "對全體敵方造成已損失生命  [Arg1]% 的傷害"
  },
  Skill_74823_Name = {
    Text = "跨越維度的低喃"
  },
  Skill_74824_BattleDesc = {
    Text = "獲得 [Arg1] 點力量"
  },
  Skill_74824_Desc = {
    Text = "獲得 [Arg1] 點力量"
  },
  Skill_74824_Name = {
    Text = "欣賞頭顱藏品"
  },
  Skill_74893_BattleDesc = {
    Text = "獲得 [Arg1] 點護盾"
  },
  Skill_74893_Desc = {
    Text = "獲得 [Arg1] 點護盾"
  },
  Skill_74893_Name = {
    Text = "萬千門扉的守護"
  },
  Skill_74894_BattleDesc = {
    Text = "獲得 [Arg1] 點死亡抵抗"
  },
  Skill_74894_Desc = {
    Text = "獲得 [Arg1] 點死亡抵抗"
  },
  Skill_74894_Name = {
    Text = "死亡亦可被販售"
  },
  Skill_74895_BattleDesc = {
    Text = "獲得 [Arg1] 點算力"
  },
  Skill_74895_Desc = {
    Text = "獲得 [Arg1] 點算力"
  },
  Skill_74895_Name = {
    Text = "新的藏品已入庫"
  },
  Skill_74896_BattleDesc = {
    Text = "隨機造成 [Arg1] 點傷害 [Arg2] 次（該傷害受到1倍力量加成）"
  },
  Skill_74896_Desc = {
    Text = "隨機造成 [Arg1] 點傷害 [Arg2] 次（該傷害受到1倍力量加成）"
  },
  Skill_74896_Name = {
    Text = "銀貨兩訖"
  },
  Skill_74897_BattleDesc = {
    Text = "獲得 [Arg1] 層反擊"
  },
  Skill_74897_Desc = {
    Text = "獲得 [Arg1] 層反擊"
  },
  Skill_74897_Name = {
    Text = "小店杜絕賒欠"
  },
  Skill_74898_BattleDesc = {
    Text = "臨時降低所有敵人 [Arg1] 點<PowerIconKeywords:力量>，每有 1 名敵人獲得 [Arg1] 點<PowerIconKeywords:臨時力量>。"
  },
  Skill_74898_Desc = {
    Text = "<TouquKeywords:偷取>所有敵人 [Arg1] 點力量"
  },
  Skill_74898_Name = {
    Text = "你的頭顱已預訂"
  },
  Skill_74899_BattleDesc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74899_Desc = {
    Text = "選擇一名喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74900_BattleDesc = {
    Text = "獲得 [Arg1] 點界域精通"
  },
  Skill_74900_Desc = {
    Text = "獲得 [Arg1] 點界域精通"
  },
  Skill_74900_Name = {
    Text = "千年的學識"
  },
  Skill_74901_BattleDesc = {
    Text = "本回合造成的中毒、反擊、出血提高 [Arg1]%"
  },
  Skill_74901_Desc = {
    Text = "本回合造成的中毒、反擊、出血提高 [Arg1]%"
  },
  Skill_74901_Name = {
    Text = "請勿貪得無厭"
  },
  Skill_74902_BattleDesc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74902_Desc = {
    Text = "所有喚醒體獲得 [Arg1] 點狂氣"
  },
  Skill_74903_BattleDesc = {
    Text = "下 [Arg1] 張打出的指令卡額外獲得 [Arg2] 點鑰能"
  },
  Skill_74903_Desc = {
    Text = "下 [Arg1] 張打出的指令卡額外獲得 [Arg2] 點鑰能"
  },
  Skill_74903_Name = {
    Text = "價格好商量"
  },
  Skill_74945_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後使狂氣最高的敵方失去 [Arg1] 狂氣並獲得<PVPEmptinessKeywords:空虛>。"
  },
  Skill_74945_Name_1 = {
    Text = "催眠靈擺"
  },
  Skill_74946_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合開始時，對<HPAndShieldMin:生命與護盾最低>敵方造成 [Arg1] <PVPCardLockKeywords:卡牌封鎖>。裝備者造成擊殺後，立刻觸發一次該效果。"
  },
  Skill_74946_Name_1 = {
    Text = "魔女寬簷帽"
  },
  Skill_76444_Desc = {
    Text = "添加10000反擊"
  },
  Skill_76444_Name = {
    Text = "添加10000反擊"
  },
  Skill_76532_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合結束時，賦予對手的隨機 [Arg1] 張手牌 [Arg2] 層<PVPAcheKeywords:隱沒的痛楚>。"
  },
  Skill_76532_Name_1 = {
    Text = "隱沒的痛楚"
  },
  Skill_77673_Desc = {
    Text = "將 1 張<DerivativeCardKeywords_133:「莉雅的硬幣」>置入棄牌堆。"
  },
  Skill_77673_Name = {
    Text = "酒館之門"
  },
  Skill_77678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 2 層「終末」。"
  },
  Skill_77678_Name = {
    Text = "機械脈衝"
  },
  Skill_77680_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，為隨機三張卡牌添加「認知錯亂」，並施加 1 回合<WeaknessIconKeywords:虛弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易傷>、<BlindingKeywords:致盲> 狀態。失去 2 層終末。"
  },
  Skill_77680_Name = {
    Text = "意識干擾裝置"
  },
  Skill_77681_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 2 層「終末」。"
  },
  Skill_77681_Name = {
    Text = "機械臂揮擊"
  },
  Skill_77682_Desc = {
    Text = "關閉深淵之門並移除其他敵人。轉化為半機械形態，恢復所有生命並根據當前終末層數獲得額外的最大生命和 15 層「融蝕霧盾」。"
  },
  Skill_77682_Name = {
    Text = "機械飛昇"
  },
  Skill_77683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Poison:Arg3] 層<IntoxicationIconKeywords:中毒>，將 2 張「融蝕之芯」洗入抽牌堆。失去 3 層「終末」。"
  },
  Skill_77683_Name = {
    Text = "融蝕發酵框體"
  },
  Skill_77684_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。獲得 3 層「終末」並打開「深淵之門」，每回合結束時都會補充敵人，最多 2 名。"
  },
  Skill_77684_Name = {
    Text = "終點，真理與深淵之門"
  },
  Skill_77685_Desc = {
    Text = "將玩家生命上限變為 [Arg1] ，失去 3 層「終末」。"
  },
  Skill_77685_Name = {
    Text = "託乎瓦波凝視裝置"
  },
  Skill_77714_Desc = {
    Text = "獲得 10 層終末，施加 [Arg1] 層<BleedingIconKeywords:出血>。終末，即將降臨…！"
  },
  Skill_77714_Name = {
    Text = "系統重啟"
  },
  Skill_77846_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。場上每有 1 名其它敵人存活，獲得 1 層「終末」。如果擊破了所有其他敵人，意圖變為「自毀改造」。"
  },
  Skill_77846_Name = {
    Text = "呼喚終末"
  },
  Skill_77847_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。場上每有 1 名其它敵人存活，獲得 1 層「終末」。如果擊破了所有其他敵人，意圖變為「宿命坍縮」。"
  },
  Skill_77847_Name = {
    Text = "呼喚終末"
  },
  Skill_77851_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虛弱>，獲得 [Arg2] 層<ReinforcePVEKeywords:加固>。"
  },
  Skill_77851_Name = {
    Text = "自毀改造"
  },
  Skill_77852_Desc = {
    Text = "施加 [Poison:Arg1] 層<IntoxicationIconKeywords:中毒>。回合結束後，其它敵人獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_77852_Name = {
    Text = "宿命坍縮"
  },
  Skill_78648_Desc = {
    Text = "所有人最大生命都變成1"
  },
  Skill_78648_Name = {
    Text = "託乎瓦波裝置"
  },
  Skill_78782_AwakerSkillBackgroundStory = {
    Text = "搖動的靈擺裡，世界開始被抹消。\n你的眼中，你的心裡，你的頭顱內，只剩下一個身影。\n那是救贖，亦是絕路。"
  },
  Skill_78782_BattleDesc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命 [Arg2] 次，臨時移除敵人所有<MadnessIconKeywords:瘋狂>狀態並使其臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78782_Desc = {
    Text = "回復 <Heal:[Heal:Arg1]> 點生命，臨時移除敵人所有<MadnessIconKeywords:瘋狂>狀態並使其臨時降低 [Exhaustion:Arg3] 點<ExhaustionIconKeywords:力量>。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78782_EffectNameList = {
    Text = "回復,力量降低,力量"
  },
  Skill_78782_Name = {
    Text = "精神撫慰"
  },
  Skill_78782_PropertyNameList = {
    Text = "體質*GrowValue1,防禦力*GrowValue2,攻擊力*GrowValue3"
  },
  Skill_78783_AwakerSkillBackgroundStory = {
    Text = "她的聲音溫柔而親切，在你看不見的心靈暗面，糾纏蔓延。\n一個人無法被自己之外的存在打敗，而你自己，就是她的武器。"
  },
  Skill_78783_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，獲得 <Energy:[Energy:Arg5]> 點狂氣。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78783_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，克萊門汀獲得 <Energy:[Energy:Arg3]> 點狂氣。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78783_EffectNameList = {
    Text = "傷害,狂氣,力量"
  },
  Skill_78783_Name = {Text = "打擊"},
  Skill_78783_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_78784_Desc = {
    Text = "每移除自身 1 層「共感」，就對所有敵人施加 1 層「恐懼固著」，每層「恐懼固著」使目標造成的傷害降低 3％。"
  },
  Skill_78784_Name = {
    Text = "轉化·恐懼固著"
  },
  Skill_78785_AwakerSkillBackgroundStory = {
    Text = "「請告訴我，真正的你是誰？」\n這麼問著，她笑了起來。\n那可憐的患者當然無法回答，因為他的記憶已被篡改，越是追尋，便越會靠近植入記憶裡的恐怖存在——直到認知徹底崩潰，變為怪物。"
  },
  Skill_78785_BattleDesc_0 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，選擇轉化為所有敵人的<D13AFKeyWord2:精神創傷>或<D13AFKeyWord1:恐懼固著>。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次，獲得 <Posse:[Arg3]> 點銀鑰能量。"
  },
  Skill_78785_BattleDesc_2 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，選擇轉化為所有敵人的<D13AFKeyWord2:精神創傷>或<D13AFKeyWord1:恐懼固著>，每移除 1 層克萊門汀造成的基礎傷害提高 3％。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次，獲得 <Posse:[Arg3]> 點銀鑰能量。"
  },
  Skill_78785_BattleDesc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，選擇轉化為所有敵人的<D13AFKeyWordQ2:精神創傷>或<D13AFKeyWordQ1:恐懼固著>，每移除 1 層克萊門汀造成的基礎傷害提高 3％。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次，獲得 <Posse:[Arg3]> 點銀鑰能量。"
  },
  Skill_78785_Desc_0 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，選擇轉化為所有敵人的<D13AFKeyWord2:精神創傷>或<D13AFKeyWord1:恐懼固著>。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Arg2]％ 克萊門汀銀鑰充能的銀鑰能量。"
  },
  Skill_78785_Desc_2 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，選擇轉化為所有敵人的<D13AFKeyWord2:精神創傷>或<D13AFKeyWord1:恐懼固著>，每移除 1 層使克萊門汀造成的基礎傷害提高 3％。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Arg2]％ 克萊門汀銀鑰充能的銀鑰能量。"
  },
  Skill_78785_Desc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，選擇轉化為所有敵人的<D13AFKeyWordQ2:精神創傷>或<D13AFKeyWordQ1:恐懼固著>，每移除 1 層使克萊門汀造成的基礎傷害提高 3％。對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Arg2]％ 克萊門汀銀鑰充能的銀鑰能量。"
  },
  Skill_78785_EffectNameList = {
    Text = "傷害,銀鑰能量"
  },
  Skill_78785_Name = {
    Text = "生命重構治療"
  },
  Skill_78785_OverLimitUtlSkillDesc_0 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，選擇轉化為所有敵人的<D13AFKeyWordQ2:精神創傷>和<D13AFKeyWordQ1:恐懼固著>。獲得 <Posse:[Arg4]> 點銀鑰能量和 [Power:Arg5] 點<PowerIconKeywords:力量>，對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次。"
  },
  Skill_78785_OverLimitUtlSkillDesc_2 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，選擇轉化為所有敵人的<D13AFKeyWordQ2:精神創傷>和<D13AFKeyWordQ1:恐懼固著>，每移除 1 層克萊門汀造成的基礎傷害提高 3％。獲得 <Posse:[Arg4]> 點銀鑰能量和 [Power:Arg5] 點<PowerIconKeywords:力量>，對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次。"
  },
  Skill_78785_OverLimitUtlSkillDesc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，選擇轉化為所有敵人的<D13AFKeyWordQ2:精神創傷>和<D13AFKeyWordQ1:恐懼固著>，每移除 1 層克萊門汀造成的基礎傷害提高 3％。獲得 <Posse:[Arg4]> 點銀鑰能量和 [Power:Arg5] 點<PowerIconKeywords:力量>，對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害 [Arg6] 次。"
  },
  Skill_78785_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2％"
  },
  Skill_78786_AwakerSkillBackgroundStory = {
    Text = "血液奔湧，靈魂燃燒，肉與骨榨出的痛苦，是最好的美味。\n這些美味會被反復品味，從最開始的尖叫，到絕望的喘息，以及最後緘默的蒼白死亡。"
  },
  Skill_78786_BattleDesc = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 <Posse:[Arg6]> 點銀鑰能量。<WormholeKeywords:超距>：獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。"
  },
  Skill_78786_Desc = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3]％ 克萊門汀銀鑰充能的銀鑰能量。<WormholeKeywords:超距>：獲得 [Power:Arg5] 點<PowerIconKeywords:力量>。"
  },
  Skill_78786_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_78786_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_78787_AwakerSkillBackgroundStory = {
    Text = "心理諮詢告一段落，但她知道你終會歸來。\n這世界荒蕪而殘酷，唯有這裡，稍有救贖。"
  },
  Skill_78787_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾 [Arg2] 次。獲得 <Energy:[Energy:Arg5]> 點狂氣。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78787_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，克萊門汀獲得 <Energy:[Energy:Arg3]> 點狂氣。<WormholeKeywords:超距>：獲得 [Power:Arg4] 點<PowerIconKeywords:力量>。"
  },
  Skill_78787_EffectNameList = {
    Text = "護盾,狂氣,力量"
  },
  Skill_78787_Name = {Text = "防禦"},
  Skill_78787_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,攻擊力*GrowValue3"
  },
  Skill_78788_Desc = {
    Text = "每移除自身 1 層「共感」，就對所有敵人施加 1 層「精神創傷」，每層「精神創傷」使目標承受的傷害增加 3％。"
  },
  Skill_78788_Name = {
    Text = "轉化·精神創傷"
  },
  Skill_78789_AwakerSkillBackgroundStory = {
    Text = "陌生的嘶鳴深深紮入你的頭顱，隨著你的記憶流竄。\n從此，你的呼吸都開始不由自主，帶著昆蟲的味道。\n感受這呼喚，悅納這呼喚，然後蛻化、新生——\n我的朋友，我的同族。"
  },
  Skill_78789_Desc_0 = {
    Text = "克萊門汀獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：克萊門汀每回合打出的首張指令卡傷害、護盾、生命回復、獲得狂氣、獲得銀鑰能量的效果次數提高 [Arg2]。"
  },
  Skill_78789_Desc_15 = {
    Text = "克萊門汀獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：克萊門汀造成的傷害次數 +1，每回合打出的首張指令卡傷害、護盾、生命回復、獲得狂氣、獲得銀鑰能量的效果次數提高 [Arg2]。「共感」上限提高為 20。"
  },
  Skill_78789_EffectNameList = {Text = "狂氣"},
  Skill_78789_Name = {
    Text = "妖蟲的呼喚"
  },
  Skill_78904_Desc_1 = {
    Text = "對目標造成 [Arg1]%最大生命的傷害。獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_78904_Desc_2 = {
    Text = "為任意目標更換命輪。獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_78904_Name_1 = {Text = "貓貓拳"},
  Skill_78915_Desc_1 = {
    Text = "抽 [Arg1] 張牌，獲得 [Arg2] 算力。"
  },
  Skill_78915_Name_1 = {
    Text = "莉雅的硬幣"
  },
  Skill_78936_Desc_1 = {
    Text = "將 [Arg1] 張<PVPDerivativeCardKeywords_29:「莉雅的硬幣」>置入下一個抽牌堆。"
  },
  Skill_78936_Name_1 = {
    Text = "酒館之門"
  },
  Skill_78936_UnknownName = {
    Text = "酒館之門"
  },
  Skill_79252_Desc_1 = {
    Text = "測試重置指令"
  },
  Skill_79252_Name_1 = {
    Text = "測試重置指令"
  },
  Skill_79257_Desc_1 = {
    Text = "對目標造成 [Arg1]%最大生命的傷害。獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_79257_Name_1 = {Text = "貓貓拳"},
  Skill_79478_Desc = {
    Text = "將所有手牌棄掉，更換為「蟲族」的隨機指令卡。「蟲族」每回合能夠釋放 2 次狂氣爆發。"
  },
  Skill_79758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_79759_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_79760_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_79761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_80035_BattleDesc = {
    Text = "進行「超維超越」"
  },
  Skill_80035_Desc = {
    Text = "進行「超維超越」"
  },
  Skill_80193_Desc_1 = {
    Text = "抽 [Arg1] 張牌，對方抽 [Arg2] 張牌。"
  },
  Skill_80193_Name_1 = {
    Text = "特殊治療"
  },
  Skill_80193_UnknownName = {
    Text = "特殊治療"
  },
  Skill_80194_Desc = {
    Text = "回覆 <Heal:[Heal:Arg1]> 點生命、獲得 [Arg2] 點力量。若克萊門汀在隊伍中、使她於本回合中下次打出的指令卡傷害、護盾、生命回覆、獲得狂氣、獲得銀鑰能量的效果次數提升 1。"
  },
  Skill_80194_Name = {
    Text = "特殊治療"
  },
  Skill_80355_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。回合開始時，隨機對 2 張沒有「認知錯亂」的指令施加「認知錯亂」。"
  },
  Skill_80355_Name = {
    Text = "生命重構治療"
  },
  Skill_80442_Desc = {Text = "增傷1層"},
  Skill_80442_Name = {
    Text = "克萊門汀增傷"
  },
  Skill_80585_Desc = {
    Text = "將 1 張「巢群捕食」置入手中，所有喚醒體暴擊率下降 [Arg1]％。"
  },
  Skill_80585_Name = {
    Text = "認知汲取"
  },
  Skill_80586_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。若本回合受到過暴擊，意圖變為「認知汲取」。"
  },
  Skill_80586_Name = {Text = "螫針"},
  Skill_80587_Desc = {
    Text = "清除負面狀態，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_80587_Name = {
    Text = "邁向新生"
  },
  Skill_80588_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_80589_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<WeaknessIconKeywords:虛弱> [Arg3] 回合。"
  },
  Skill_80590_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易傷> [Arg3] 回合。"
  },
  Skill_80591_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 1 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_80591_Name = {
    Text = "失控追擊"
  },
  Skill_80605_Desc = {
    Text = "將 [Arg1] 張「巢群捕食」置入手中。賦予抽牌堆隨機 [Arg2] 張卡牌 [Arg3] 層「遲緩」。"
  },
  Skill_80605_Name = {
    Text = "神經毒素"
  },
  Skill_80606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。賦予仍在手中保留的卡牌 [Arg3] 層「遲緩」。"
  },
  Skill_80607_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_80607_Name = {
    Text = "狩獵時刻"
  },
  Skill_80608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> [Arg3] 回合。"
  },
  Skill_80608_Name = {
    Text = "狩獵時刻·破甲"
  },
  Skill_80609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。<HeavyInjuryKeywords:重創> [Arg3] 回合。"
  },
  Skill_80609_Name = {
    Text = "狩獵時刻·重創"
  },
  Skill_80749_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:力量>和 [Arg2] 層「舊日餘燼」。"
  },
  Skill_80750_Desc = {
    Text = "切換到該意圖後，本回合承受的主動傷害提高 100％。釋放後造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_80750_Name = {Text = "蟄伏"},
  Skill_80751_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加  [Arg3]％ 造成傷害的中毒，每有 1 點護盾該傷害降低 1。若該傷害觸發了「死亡抵抗」，將剩餘的「死亡抵抗」減半。"
  },
  Skill_80752_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺>傷害 [AttackTimes:Arg2] 次。 回復 [Arg3]％ 已損失生命，每層「宇宙幽能」使最大生命提高 [Arg5]%。獲得 [Arg4] 層「宇宙輪回」：受到致命傷害後，回復所有生命並獲得 30 層臨時加固。"
  },
  Skill_80752_Name = {
    Text = "蛻變之刻"
  },
  Skill_80753_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。賦予仍在手中保留的卡牌 [Arg3] 層「遲緩」，將 1 張「巢群捕食」置入手中。"
  },
  Skill_80754_Desc = {
    Text = "移除 1 層「宇宙幽能」進入「隱匿」狀態，召喚 [Arg1] 個「蟲族」，它們每回合獲得 [Arg2] 層<MadnessIconKeywords:瘋狂>。其它敵人全部死亡時，解除「隱匿」。"
  },
  Skill_80754_Name = {
    Text = "呼喚同族"
  },
  Skill_80755_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張「巢群捕食」置入手中。若本回合擊碎了「舊日餘燼」，變為無傷害的「神經毒素」。"
  },
  Skill_80755_Name = {
    Text = "散播劇毒"
  },
  Skill_80756_Desc = {
    Text = "切換到該意圖後，本回合承受的主動傷害提高 100％。釋放後造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_80756_Name = {Text = "蟄伏"},
  Skill_80757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，目標每損失 [Arg3]％ 生命傷害次數提高 1。若存在「宇宙幽能」，移除 1 層並獲得 1 層<MadnessIconKeywords:瘋狂>。"
  },
  Skill_80758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。每點護盾使該傷害降低 1 點。若存在「宇宙幽能」，移除 1 層並獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_80758_Name = {
    Text = "維度撕裂"
  },
  Skill_80759_Desc = {
    Text = "移除 1 層「宇宙幽能」進入「隱匿」狀態，召喚 [Arg1] 個「蟲族」，它們每回合獲得 [Arg2] 層<MadnessIconKeywords:瘋狂>。其它敵人全部死亡時，解除「隱匿」。"
  },
  Skill_80759_Name = {
    Text = "呼喚同族"
  },
  Skill_80760_Desc = {
    Text = "切換到該意圖後，本回合承受的傷害提高 100％。釋放後造成 [Arg1] 層<WeaknessIconKeywords:虛弱>和<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_80760_Name = {Text = "蟄伏"},
  Skill_80762_Desc = {
    Text = "召喚 [Arg1] 名「蛻化者」在前方。"
  },
  Skill_80762_Name = {
    Text = "幼蟲繁育"
  },
  Skill_80763_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。將 [Arg3] 張「巢群捕食」置入手中。若本回合擊碎了「舊日餘燼」，變為低傷害的「心智寄生」。"
  },
  Skill_80764_Desc = {
    Text = "獲得 [Arg1] 層「虛空幽能」，降低所有喚醒體 [Arg4]％暴擊率。下回合開始時，選擇 [Arg2] 名喚醒體，封印其所有卡牌和狂氣爆發 [Arg3] 回合。"
  },
  Skill_80764_Name = {
    Text = "意識幽禁"
  },
  Skill_80765_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加  [Arg3]％ 造成傷害的中毒，每有 1 點護盾該傷害降低 1。若該傷害觸發了「死亡抵抗」，將剩餘的「死亡抵抗」減半。"
  },
  Skill_80766_Desc = {
    Text = "召喚 [Arg1] 名「蛻化者」在前方。"
  },
  Skill_80766_Name = {
    Text = "幼蟲繁育"
  },
  Skill_80767_Desc = {
    Text = "將 [Arg1] 張「巢群捕食」置入手中。賦予抽牌堆隨機 [Arg2] 張卡牌 [Arg3] 層「遲緩」。"
  },
  Skill_80767_Name = {
    Text = "神經毒素"
  },
  Skill_80768_Desc = {
    Text = "將 [Arg1] 張「巢群捕食」置入手中。賦予抽牌堆隨機 [Arg2] 張卡牌 [Arg3] 層「遲緩」。"
  },
  Skill_80768_Name = {
    Text = "神經毒素"
  },
  Skill_80769_Desc = {
    Text = "召喚 [Arg1] 名「初變者」在前方，獲得 1 層臨時<MadnessIconKeywords:瘋狂>。"
  },
  Skill_80769_Name = {Text = "擬態"},
  Skill_80969_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 1 層<MadnessIconKeywords:瘋狂>。打出覺醒卡後意圖更改為「痛苦榨取」。"
  },
  Skill_80969_Name = {
    Text = "心理絞殺"
  },
  Skill_81071_Desc = {
    Text = "召喚 [Arg1] 名「蛻化者」在前方。"
  },
  Skill_81071_Name = {
    Text = "幼蟲繁育"
  },
  Skill_81267_Desc = {
    Text = "填滿超維空間"
  },
  Skill_81267_Name = {
    Text = "填滿超維空間"
  },
  Skill_81296_Desc = {
    Text = "回合結束時，若仍在手牌堆中，失去 [Arg1] 點生命上限，將其<DepleteIconKeywords:消耗>。打出後，使前排敵人獲得 [Arg2] 層「舊日餘燼」，將此卡洗入抽牌堆底部。"
  },
  Skill_81300_Desc = {
    Text = "從「蹣跚」、「窒息」、「珊瑚贅生」、「褻瀆假像」、「狂放」中選擇一張加入手中，其餘四張置入棄牌堆。"
  },
  Skill_81300_Name = {
    Text = "世界演繹法"
  },
  Skill_81343_Desc = {
    Text = "移除 1 層「宇宙幽能」，<WeaknessIconKeywords:虛弱>和<HeavyInjuryKeywords:重創> [Arg1] 回合，對抽牌堆 [Arg2] 張指令卡施加「認知錯亂」。"
  },
  Skill_81343_Name = {
    Text = "蟲巢干涉"
  },
  Skill_81433_Desc = {
    Text = "驅散所有喚醒體的<CardKeyWord:封印>狀態和暴擊率下降效果，移除敵方「加固」狀態。將上回合最後打出的 5 張不同非衍生指令卡原始複製置入手中，使它們算力消耗變為 0 並獲得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虛無>。"
  },
  Skill_83574_BattleDesc = {
    Text = "清除所有「揚帆」（[Arg1]）。每清除 1 層，最終傷害提高 [Arg2]％ ，所有喚醒體獲得 [Arg3] 點狂氣。\n若一次性清除了 5 層或以上「揚帆」，<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，對它們造成已損失生命值 [Arg4]％ 的<FixedDamage:純粹傷害>。"
  },
  Skill_83574_Desc = {
    Text = "清除所有「揚帆」。每清除 1 層，最終傷害提高 10％，所有喚醒體獲得 5 點狂氣。\n若一次性清除了 5 層或以上「揚帆」，「易傷」所有敵人 1 回合，對它們造成已損失生命值 35％ 的<FixedDamage:純粹傷害>。"
  },
  Skill_83574_Name = {
    Text = "破浪啟航"
  },
  Skill_83575_BattleDesc = {
    Text = "清除所有「泊錨」([Arg1])。每清除 1 層，死亡抵抗+ [Arg2]% ，獲得 [Arg3] 算力，抽 [Arg4] 張牌。\n若一次性清除了 5 層或以上 「泊錨」，獲得 [Arg5] 層臨時<ParcloseIconKeywords:屏障>。"
  },
  Skill_83575_Desc = {
    Text = "清除所有「泊錨」。每清除 1 層，「死亡抵抗」+15%，獲得 1 算力，抽 1 張牌。\n若一次性清除了 5 層或以上 「泊錨」，獲得 1 層「屏障」。"
  },
  Skill_83575_Name = {
    Text = "攏岸暫息"
  },
  Skill_83576_BattleDesc = {
    Text = "選擇：「破浪啟航」( [Arg1] ) 或 「攏岸暫息」( [Arg2] ) 。棄掉時將其<DepleteIconKeywords:消耗>。"
  },
  Skill_83576_Desc = {
    Text = "選擇：「破浪啟航」 或 「攏岸暫息」。棄掉時將其<DepleteIconKeywords:消耗>。"
  },
  Skill_83576_Name = {
    Text = "引航員的抉擇"
  },
  Skill_83779_AwakerSkillBackgroundStory = {
    Text = "無垠的鹹水吞噬了她，同時也庇護了她。\n在那令人窒息的沉淪感裡，她感知著幽邃的大海，融入著幽邃的大海。\n終有一日，海洋將徹底平靜，每個航行於海面的船隻，都會被賜予安寧。\n她等待著那日，那「神國降臨之日」。"
  },
  Skill_83779_Desc_0 = {
    Text = "克珀珊特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「<DerivativeCardKeywords_106:領航>」置入手中。切換至「靜海」姿態後獲得 <Block:[Block:Arg2]> 點護盾，3 回合冷卻。"
  },
  Skill_83779_Desc_15 = {
    Text = "克珀珊特獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 條觸腕，將 2 張「<DerivativeCardKeywords_106:領航>」置入手中，每回合首張「懲戒雷霆」和「混沌旗語」額外置入 1 張「<DerivativeCardKeywords_106:領航>」到手中，「<DerivativeCardKeywords_106:領航>」效果提高 50％。切換至「靜海」姿態後獲得 <Block:[Block:Arg2]> 點護盾，3 回合冷卻。"
  },
  Skill_83779_EffectNameList = {
    Text = "狂氣,護盾"
  },
  Skill_83779_Name = {
    Text = "沉沒於遠海"
  },
  Skill_83779_PropertyNameList = {
    Text = "$GrowValue1,防禦力*GrowValue2"
  },
  Skill_83780_AwakerSkillBackgroundStory = {
    Text = "雲層會告知氣候的變化，波浪會訴說洋流的變遷，但當風暴真正來臨時，再龐大的巨輪，都只能無助地隨波逐流。\n此時，領航員的測算、指引，是所有幸存者最後的退路。\n因此履行自己的職責吧，哪怕雷電劈身，也要於痛苦中，綻放出一絲光明，指引海岸的方向。\n那是你必須完成的使命。"
  },
  Skill_83780_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 條臨時觸腕。棄掉所有手牌並抽等量的牌。"
  },
  Skill_83780_BattleDesc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 條臨時觸腕。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，臨時暴擊傷害+ [Arg5]％。棄掉所有手牌並抽等量的牌。"
  },
  Skill_83780_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 條臨時觸腕。棄掉所有手牌並抽等量的牌。"
  },
  Skill_83780_Desc_3 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾和 [Arg2] 條臨時觸腕。<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，臨時暴擊傷害+ [Arg3]％，本場戰鬥每觸發 1 次死亡抵抗額外提高 [Arg4]％。棄掉所有手牌並抽等量的牌。"
  },
  Skill_83780_EffectNameList = {Text = "護盾"},
  Skill_83780_Name = {
    Text = "照徹淵海的引航"
  },
  Skill_83780_OverLimitUtlSkillDesc_0 = {
    Text = "棄掉所有手牌並抽取等量卡牌，額外觸發 1 次棄置卡牌的「餘波」效果。獲得 <Block:[Block:Arg1]> 點護盾、[Arg2] 條臨時觸腕、 [Arg2] 條永久觸腕。"
  },
  Skill_83780_OverLimitUtlSkillDesc_3 = {
    Text = "<VulnerabilityIconKeywords:易傷>所有敵人 1 回合，臨時暴擊傷害+ [Arg5]％。棄掉所有手牌並抽取等量卡牌，額外觸發 1 次棄置卡牌的「餘波」效果。獲得 <Block:[Block:Arg1]> 點護盾、[Arg2] 條臨時觸腕、 [Arg2] 條永久觸腕。"
  },
  Skill_83780_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_83781_AwakerSkillBackgroundStory = {
    Text = "她亦是船隻的「語言」，在蒼茫的大海上，以旗幟指引著同伴。"
  },
  Skill_83781_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_83781_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg4]> 點狂氣。<RippleKeywords:餘波>：下次打出獲得的狂氣提高 [Arg3] ，至多疊加 2 次。"
  },
  Skill_83781_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。克珀珊特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_83781_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。克珀珊特獲得 <Energy:[Energy:Arg4]> 點狂氣。<RippleKeywords:餘波>：下次打出獲得的狂氣提高 [Arg3] ，至多疊加 2 次。"
  },
  Skill_83781_EffectNameList_0 = {
    Text = "護盾,狂氣"
  },
  Skill_83781_EffectNameList_1 = {
    Text = "護盾,狂氣"
  },
  Skill_83781_Name = {Text = "防禦"},
  Skill_83781_PropertyNameList_0 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_83781_PropertyNameList_1 = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_83782_AwakerSkillBackgroundStory = {
    Text = "她是船隻的「頭腦」，停泊還是航行，都有最理智的計算。"
  },
  Skill_83782_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_83782_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg4]> 點狂氣。<RippleKeywords:餘波>：下次打出獲得的狂氣提高 [Arg3] ，至多疊加 2 次。"
  },
  Skill_83782_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。克珀珊特獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_83782_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。克珀珊特獲得 <Energy:[Energy:Arg4]> 點狂氣。<RippleKeywords:餘波>：下次打出獲得的狂氣提高 [Arg3] ，至多疊加 2 次。"
  },
  Skill_83782_EffectNameList_0 = {
    Text = "傷害,狂氣"
  },
  Skill_83782_EffectNameList_1 = {
    Text = "傷害,狂氣"
  },
  Skill_83782_Name = {Text = "打擊"},
  Skill_83782_PropertyNameList_0 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_83782_PropertyNameList_1 = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_83783_AwakerSkillBackgroundStory = {
    Text = "旗語是通用的，同時，旗語也是私密的。\n在意識跨越維度門扉，得見「祂」之時，克珀珊特就被賜予了特殊的旗語。\n每一次褻瀆地揮舞，都是在回應那偉大存在的呼喚。"
  },
  Skill_83783_Desc_0 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。將 [Arg2] 張「<DerivativeCardKeywords_106:領航>」置入手中。"
  },
  Skill_83783_Desc_15 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。將 [Arg2] 張「<DerivativeCardKeywords_106:領航>」置入手中。<WeaknessIconKeywords:虛弱>所有敵人 1 回合。"
  },
  Skill_83783_Desc_2 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 點狂氣。將 [Arg2] 張「<DerivativeCardKeywords_106:領航>」置入手中。<WeaknessIconKeywords:虛弱>所有敵人 1 回合。"
  },
  Skill_83783_EffectNameList = {Text = "狂氣"},
  Skill_83783_Name = {
    Text = "混沌旗語"
  },
  Skill_83784_AwakerSkillBackgroundStory = {
    Text = "就連憤怒的時候，克珀珊特也是理智的。\n她會先評判對方所犯的錯誤，再根據其程度來計算該給出何種等級的懲罰。\n因為在茫茫大海上，若是沒有秩序，殺戮和背叛將吞噬一切。"
  },
  Skill_83784_Desc_0 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，享受 [Arg3]％ 觸腕傷害加成，每次造成傷害使目標本回合承受的觸腕傷害提高 [Arg4]％。將 [Arg5] 張「<DerivativeCardKeywords_106:領航>」置入手中。<RippleKeywords:餘波>：此卡牌返回抽牌堆頂部。"
  },
  Skill_83784_Desc_15 = {
    Text = "隨機造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，享受 [Arg3]％ 觸腕傷害加成，每次造成傷害使目標本回合承受的觸腕傷害提高 [Arg4]％。將 [Arg5] 張「<DerivativeCardKeywords_106:領航>」置入手中。<RippleKeywords:餘波>：此卡牌返回抽牌堆頂部。"
  },
  Skill_83784_EffectNameList = {
    Text = "傷害,觸腕傷害加成"
  },
  Skill_83784_Name = {
    Text = "懲戒雷霆"
  },
  Skill_83784_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2％"
  },
  Skill_84228_BattleDesc_1 = {
    Text = "隨機造成 [Arg3] 次 <Damage:[Damage:Arg1]> 傷害。每擁有 [Arg2] <PVPProtectiveKeywords:屏障>額外造成 1 次傷害。"
  },
  Skill_84228_Desc_1 = {
    Text = "隨機造成 3 次 <Damage:[Damage:Arg1]> 傷害。每擁有 [Arg2] <PVPProtectiveKeywords:屏障>額外造成 1 次傷害。"
  },
  Skill_84229_Desc_1 = {
    Text = "給予一名友方 [Arg1] 層<PVPProtectiveKeywords:屏障>，<PVPPenetrateKeywords:貫穿>。"
  },
  Skill_84229_Name_1 = {
    Text = "照徹淵海的引航"
  },
  Skill_84230_Desc_1 = {
    Text = "回復一名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_84231_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_84231_Name_1 = {Text = "打擊"},
  Skill_84232_Desc_1 = {
    Text = "<StrengthenKeywords:強化>一名友方並給予其 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_84261_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合開始時，若自身沒有<PVPProtectiveKeywords:屏障>獲得 [Arg1] 層<PVPProtectiveKeywords:屏障>，否則獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_84261_Name_1 = {
    Text = "聖火中的指引"
  },
  Skill_84262_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，回復損失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_84262_Name_1 = {
    Text = "海上領航者"
  },
  Skill_84263_Desc_1 = {
    Text = "給予全體友方 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_84263_Name_1 = {
    Text = "不滅的雷光"
  },
  Skill_84263_UnknownName = {
    Text = "不滅的雷光"
  },
  Skill_84357_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<RippleKeywords:餘波>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點觸腕傷害。"
  },
  Skill_84357_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。<RippleKeywords:餘波>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>和 [TentaclePower:Arg2] 點觸腕傷害。"
  },
  Skill_84357_Name = {Text = "領航"},
  Skill_84378_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，抽 [Arg2] 張牌。若克珀珊特在隊伍中，還會將 1 張「領航」置入手中。"
  },
  Skill_84378_Name = {
    Text = "不滅的雷光"
  },
  Skill_84383_BattleDesc = {
    Text = "造成 [Arg2] 次傷害。將 [Arg3] 張症狀「瘋狂」洗入抽牌堆。"
  },
  Skill_84383_Desc = {
    Text = "懲戒雷霆：造成 3 次傷害。將1張「症狀：瘋狂」洗入抽牌堆頂。"
  },
  Skill_84383_Name = {
    Text = "懲戒雷霆"
  },
  Skill_84384_BattleDesc = {
    Text = "自身力量提高 [Arg1] ，獲得 [Arg2] 層<ParcloseIconKeywords:屏障>，獲得 5 層<ReinforcePVEKeywords:加固>。下回合開始時每層屏障轉化為 1 層<ReinforcePVEKeywords:加固>。"
  },
  Skill_84384_Desc = {
    Text = "照徹淵海的引航：自身力量提高 0.05*ATK，獲得 8 層屏障。下回合開始時每層屏障轉化為 1 點加固。"
  },
  Skill_84384_Name = {
    Text = "照徹淵海的引航"
  },
  Skill_84385_BattleDesc = {
    Text = "驅散<WeaknessIconKeywords:虛弱>。自身力量提高 [Arg1]，承受傷害提高 [Arg2]% ，懲戒雷霆傷害次數提高 [Arg3] 。"
  },
  Skill_84385_Desc = {
    Text = "赴死如歸的天火：驅散虛弱。自身力量提高0.1ATK，承受傷害提高 10% ，懲戒雷霆傷害次數額外提高 1 。"
  },
  Skill_84385_Name = {
    Text = "赴死如歸的天火"
  },
  Skill_84387_BattleDesc = {
    Text = "造成 [Arg2] 次傷害並施加 [Arg3] 回合<VulnerabilityIconKeywords:易傷>。將 [Arg4] 張症狀「瘋狂」洗入抽牌堆。"
  },
  Skill_84387_Desc = {
    Text = "懲戒雷霆覺醒版：造成4次傷害+易傷2回合。將1張「症狀：瘋狂」洗入抽牌堆頂。"
  },
  Skill_84387_Name = {
    Text = "懲戒雷霆"
  },
  Skill_84388_BattleDesc = {
    Text = "造成 [Arg2] 次傷害並施加 [Arg3] 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_84388_Desc = {
    Text = "混沌旗語：造成1次傷害+虛弱2回合。"
  },
  Skill_84388_Name = {
    Text = "混沌旗語"
  },
  Skill_84404_BattleDesc = {
    Text = "懲戒雷霆傷害次數提高 [Arg2] 。獲得「沉沒於遠海」：每回合結束時承受傷害提高 [Arg3]% ，自身獲得 [Arg4] 層屏障。"
  },
  Skill_84404_Desc = {
    Text = "沉沒於遠海：懲戒雷霆傷害次數提高 1。獲得狀態「沉沒於遠海」：每回合結束時承受傷害提高 5% ，自身獲得 2 層屏障。"
  },
  Skill_84404_Name = {
    Text = "沉沒於遠海"
  },
  Skill_89423_Desc_1 = {
    Text = "對敵我所有其他角色造成 <Damage:[Damage:Arg1]> 傷害，獲得等量傷害的護盾。"
  },
  Skill_89423_Name_1 = {
    Text = "死亡颶風"
  },
  Skill_89424_Desc_1 = {
    Text = "選擇一名友方獲得 1 張<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89425_Desc_1 = {
    Text = "<StrongEffectKeywords:強效> +[Arg1]，所有友方獲得 1 張<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89425_Name_1 = {
    Text = "不屈的孤嚎鳥"
  },
  Skill_89426_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時使生命和護盾最低的友方獲得 [Arg1] 張<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89427_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_89427_Name_1 = {Text = "打擊"},
  Skill_89428_Desc_1 = {
    Text = "對前排造成 <Damage:[Damage:Arg1]> 點傷害並獲得等量狂氣，獲得 [Arg2] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_89429_Desc_1 = {
    Text = "<TauntKeywords:嘲諷>，全體友方<StrongEffectKeywords:強效> +[Arg1]。"
  },
  Skill_89429_Name_1 = {
    Text = "庇護意志"
  },
  Skill_89430_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：手牌上限 + [Arg3]。「狂氣爆發」後手中基礎算力消耗為 [Arg1] 的「技能」算力消耗減少 [Arg2]。"
  },
  Skill_89532_Desc_1 = {
    Text = "選擇一名友方獲得  [Arg1]  張<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89532_Name_1 = {
    Text = "錯位命運"
  },
  Skill_89532_UnknownName = {
    Text = "錯位命運"
  },
  Skill_89563_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備者死亡後，將自身算力消耗 -[Arg1] 的所有「技能」洗入抽牌堆，所屬者改為剩餘生命最高友方。"
  },
  Skill_89563_Name_1 = {
    Text = "重生於湮土"
  },
  Skill_89659_Desc_1 = {
    Text = "抽 [Arg1] 張牌，獲得 [Arg2] 算力。"
  },
  Skill_89659_Name_1 = {Text = "靈感"},
  Skill_89776_AwakerSkillBackgroundStory = {
    Text = "“哥哥，你說靠翅膀一直飛、一直飛，到底能飛到多高？能飛到雲層上面，去摸摸月亮和星星嗎？”\n“也許……可以吧？那我們要有一雙很大、很有力氣的翅膀才行。”\n手抄本上深邃夢幻的銀河與星座倒映進兩個孩子沉沉的夢鄉，化作一顆願望的種子，埋藏入他們的心間。"
  },
  Skill_89776_Desc_0 = {
    Text = "卡斯托爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：卡斯托爾造成的傷害必定暴擊，「<DerivativeCardKeywords_107:黑羽>」打出後對目標施加 [Corrosion:Arg2] 層<Corrosion:侵蝕>，保留的護盾提高 50％。"
  },
  Skill_89776_Desc_15 = {
    Text = "卡斯托爾獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：卡斯托爾造成的傷害必定暴擊，「<DerivativeCardKeywords_107:黑羽>」打出後對目標施加 [Corrosion:Arg2] 層<Corrosion:侵蝕>，保留的護盾提高 50％。每回合首次打出黑羽時對前排敵人造成等同於天賦「聖羽洗罪」的侵蝕，侵蝕移除時失去的生命由 300％ 提高為 500％。"
  },
  Skill_89776_EffectNameList = {
    Text = "狂氣,侵蝕"
  },
  Skill_89776_Name = {
    Text = "翱翔夙願"
  },
  Skill_89776_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_89777_AwakerSkillBackgroundStory = {
    Text = "他不曾被教授任何戰鬥的技巧，但抗爭的力量早已根植於他生命的本能。"
  },
  Skill_89777_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89777_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。卡斯托爾獲得 <Energy:[Energy:Arg2]> 點狂氣。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89777_EffectNameList = {
    Text = "傷害,狂氣,超距護盾"
  },
  Skill_89777_Name = {Text = "打擊"},
  Skill_89777_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2,防禦力*GrowValue3"
  },
  Skill_89778_AwakerSkillBackgroundStory = {
    Text = "他愚笨、倔強、不曾改變。 哪怕只能發出孤單的啼叫，也不會屈服於任何鎖鏈與刀刃。 他要用那不曾磨損的尖喙，去啄擊牢籠的每一處裂痕。 當黑色的羽翼刺破夜的邊緣，他要銜著那片最後的羽毛，帶上他的影子，飛向風暴另一頭的天光。"
  },
  Skill_89778_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，將 [Arg2] 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆。"
  },
  Skill_89778_EffectNameList = {Text = "護盾"},
  Skill_89778_Name = {
    Text = "不屈的孤嚎鳥"
  },
  Skill_89778_OverLimitUtlSkillDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，本回合「<DerivativeCardKeywords_107:黑羽>」保留的護盾提高 <Block:[Block:Arg5]>，每次打出「<DerivativeCardKeywords_107:黑羽>」額外對目標施加 [Corrosion:Arg4] 層<Corrosion:侵蝕>。將 [Arg2] 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆並將 [Arg3] 張「<DerivativeCardKeywords_107:黑羽>」置入手中。"
  },
  Skill_89778_PropertyNameList = {
    Text = "防禦力*GrowValue1"
  },
  Skill_89779_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害，抽 [Arg1] 張牌。保留：獲得 <Block:[Block:Arg3]> 點護盾。消耗。"
  },
  Skill_89779_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害，抽 [Arg1] 張牌。每打出 3 張獲得 1 點算力，卡斯托爾造成的最終傷害提高 10％ ([Arg4]/3)。保留：獲得 <Block:[Block:Arg3]> 點護盾。消耗。"
  },
  Skill_89779_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害，抽 [Arg1] 張牌。保留：獲得 <Block:[Block:Arg3]> 點護盾。消耗。"
  },
  Skill_89779_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg2]> 點傷害，抽 [Arg1] 張牌。每打出 3 張獲得 1 點算力，卡斯托爾造成的最終傷害提高 10％。保留：獲得 <Block:[Block:Arg3]> 點護盾。消耗。"
  },
  Skill_89780_AwakerSkillBackgroundStory = {
    Text = "為了對抗殘忍的剝削，對抗那些一次又一次的失去，他會將這雙翅膀永遠擋在弟弟的身前。直到每一根羽毛都化為灰燼，直到他先一步走入死亡的大門。"
  },
  Skill_89780_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89780_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。卡斯托爾獲得 <Energy:[Energy:Arg2]> 點狂氣。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89780_EffectNameList = {
    Text = "護盾,狂氣,超距護盾"
  },
  Skill_89780_Name = {Text = "防禦"},
  Skill_89780_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2,防禦力*GrowValue3"
  },
  Skill_89781_AwakerSkillBackgroundStory = {
    Text = "他的羽翼張開，如一柄寬闊的盾，每一根羽毛都連接著堅韌的骨骼，在你頭頂簌簌抖動。\n那片黑色的陰影將你包裹，將一切日光、風雨與傷害都遮蔽在外，支撐起一片安全的天空。\n“不要觸碰它，就讓這些黑暗的詛咒，盡數歸還加害者的胸膛。”"
  },
  Skill_89781_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，<WeaknessIconKeywords:虛弱>所有敵人 1 回合。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89781_Desc_2 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，<WeaknessIconKeywords:虛弱>所有敵人 1 回合，手牌中每有 1 張「<DerivativeCardKeywords_107:黑羽>」獲得 <Energy:[Energy:Arg2]> 點狂氣。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg3]> 點護盾。"
  },
  Skill_89781_EffectNameList = {
    Text = "護盾,超距護盾"
  },
  Skill_89781_PropertyNameList = {
    Text = "防禦力*GrowValue1,防禦力*GrowValue2"
  },
  Skill_89782_AwakerSkillBackgroundStory = {
    Text = "他不是慣會忍受，那雙羽翼亦能扇起暴怒的漩渦。\n一切血肉都將被風的利齒撕碎，淋漓地捲入死亡的腹中。\n但不必害怕，他會將你的名字安置於颶風之眼，那最中央的寧靜。"
  },
  Skill_89782_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，其他友方臨時暴擊傷害提高 [Arg3]％。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg4]> 點護盾。"
  },
  Skill_89782_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次，其他友方臨時暴擊傷害提高 [Arg3]％。本回合每打出 1 張「<DerivativeCardKeywords_107:黑羽>」算力消耗降低 1。<WormholeKeywords:超距>：將 1 張「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，獲得 <Block:[Block:Arg4]> 點護盾。"
  },
  Skill_89782_EffectNameList = {
    Text = "傷害,暴擊傷害,超距護盾"
  },
  Skill_89782_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2％,防禦力*GrowValue3"
  },
  Skill_89949_Desc = {
    Text = "從隨機 3 個鑰令中選擇 1 個鑰令釋放，每個已解鎖的鑰令在本次探索中只能選擇 1 次，不可選擇初始攜帶的鑰令。"
  },
  Skill_89949_Name = {
    Text = "塵封舊憶"
  },
  Skill_90212_Desc = {
    Text = "選擇一名喚醒體使其獲得 <Energy:[Energy:Arg3]> 點狂氣，從抽牌堆中抽 [Arg2] 張算力消耗最低的卡牌。若卡斯托爾在隊伍中，使其傷害強效臨時提高 [Arg1]％。"
  },
  Skill_90212_Name = {
    Text = "錯位命運"
  },
  Skill_90565_Desc = {
    Text = "「祭靈夜特調」追加「獲得 [Arg1] 點銀鑰能量。」"
  },
  Skill_90565_Name = {
    Text = "無垢之銀"
  },
  Skill_90566_Desc = {
    Text = "「祭靈夜特調」追加「獲得 [Arg1] 點臨時力量和 [Arg2] 點臨時戒備。」"
  },
  Skill_90566_Name = {
    Text = "森然之綠"
  },
  Skill_90567_Desc = {
    Text = "「祭靈夜特調」追加「使所有喚醒體獲得 [Arg1] 點狂氣。」"
  },
  Skill_90568_Desc = {
    Text = "所有喚醒體暴擊率和暴擊傷害臨時提高 [Arg1]％，"
  },
  Skill_90568_Name = {
    Text = "祭靈夜特調"
  },
  Skill_90569_Desc = {
    Text = "「祭靈夜特調」追加「將 1 張」靈感「置入手中。」"
  },
  Skill_90569_Name = {
    Text = "靈感之藍"
  },
  Skill_90570_Desc = {
    Text = "「祭靈夜特調」追加「回復 [Arg1] 點生命。」"
  },
  Skill_90570_Name = {
    Text = "血腥之紅"
  },
  Skill_91158_BattleDesc = {
    Text = "移除自身<BleedingIconKeywords:出血>，獲得等同於已損失生命 30% 的護盾( [Arg1])，抽 2 張牌。"
  },
  Skill_91158_Desc = {
    Text = "移除自身<BleedingIconKeywords:出血>，獲得等同於已損失生命 30% 的護盾，抽 2 張牌。"
  },
  Skill_91159_BattleDesc = {
    Text = "獲得 4 層臨時<Kuangre:狂熱>和 2 點算力。"
  },
  Skill_91159_Desc = {
    Text = "獲得 4 層臨時狂熱和 2 點算力。"
  },
  Skill_91159_Name = {
    Text = "子嗣激勵"
  },
  Skill_91218_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_91218_Name_1 = {
    Text = "魂靈之噬"
  },
  Skill_91219_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_91219_Name_1 = {
    Text = "生靈的盛筵"
  },
  Skill_91220_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_91220_Name_1 = {Text = "打擊"},
  Skill_91221_Desc_1 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 狂氣。"
  },
  Skill_91221_Name_1 = {
    Text = "歡愉饜饗"
  },
  Skill_91222_Desc_1 = {
    Text = "給予一名友方 [Arg1] 層<PVPProtectiveKeywords:屏障>。"
  },
  Skill_91222_Name_1 = {
    Text = "溟夢之帷"
  },
  Skill_91512_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時和回合結束時、裝備者對後排敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_91512_Name_1 = {Text = "開學日"},
  Skill_91513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：回合結束時，將 [Arg1] 張<PVPDerivativeCardKeywords_17:「靈感」>置入手牌。"
  },
  Skill_91513_Name_1 = {
    Text = "搭檔特訓"
  },
  Skill_91741_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91741_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91741_Name = {Text = "打擊"},
  Skill_91742_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虛弱>，消耗 [Arg4] 層<Guaiwuheiyu:黑羽>。當玩家釋放鑰令後，意圖立刻變為低傷害的「打擊」並獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91742_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虛弱>，消耗 [Arg4] 層<Guaiwuheiyu:黑羽>。當玩家釋放鑰令後，意圖立刻變為低傷害的「打擊」並獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91742_Name = {
    Text = "雙重黑羽"
  },
  Skill_91743_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虛弱>，消耗 [Arg4] 層<Guaiwuheiyu:黑羽>。當玩家釋放鑰令後，意圖立刻變為低傷害的「打擊」並獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虛弱>，消耗 [Arg4] 層<Guaiwuheiyu:黑羽>。當玩家釋放鑰令後，意圖立刻變為低傷害的「打擊」並獲得 1 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91744_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每層黑羽使造成的最終傷害提高 [Arg3] %，清除一半<Guaiwuheiyu:黑羽>。"
  },
  Skill_91744_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每層黑羽使造成的最終傷害提高 [Arg3] %，清除一半<Guaiwuheiyu:黑羽>。"
  },
  Skill_91745_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91745_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91745_Name = {
    Text = "不屈的孤嚎鳥"
  },
  Skill_91746_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，每有 [Arg2] 層黑羽使獲得的防禦提高 [Arg3]%，獲得 [Arg4] 點<PowerIconKeywords:力量>。獲得 [Arg5] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91746_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，每有 [Arg2] 層黑羽使獲得的防禦提高 [Arg3]%，獲得 [Arg4] 點<PowerIconKeywords:力量>。獲得 [Arg5] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91747_BattleDesc = {
    Text = "未被擊破護盾的 [Arg1]% 會保留至下回合，回合結束時獲得 [Arg2] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91747_Desc = {
    Text = "未被擊破護盾的 [Arg1]% 會保留至下回合，回合結束時獲得 [Arg2] 層<Guaiwuheiyu:黑羽>。"
  },
  Skill_91747_Name = {
    Text = "翱翔夙願"
  },
  Skill_94508_Desc_1 = {
    Text = "有 [Arg1]% 機率為一名友方施加正面<PVPWonderfulEffectKeywords:奇妙效果>，或為一名敵方施加負面<PVPWonderfulEffectKeywords:奇妙效果>，每次施加後機率折半，無限重複此效果，直至施加失敗，<PVPPenetrateKeywords:貫穿 1>。"
  },
  Skill_94508_Name_1 = {
    Text = "獵食決心"
  },
  Skill_94508_UnknownName = {
    Text = "獵食決心"
  },
  Skill_94560_Desc = {
    Text = "從出戰喚醒體的技能卡中<FaxianKeywords:發現> 3 張，選擇 1 張將其臨時複製置入手中，並使其算力消耗降低 1。若當前界域為「血肉」，可以選擇「一掃而光！」。"
  },
  Skill_94560_Name = {
    Text = "獵食決心"
  },
  Skill_94561_BattleDesc = {
    Text = "臨時降低所有敵人 [Arg2] 點<PowerIconKeywords:力量>，每有 1 名敵人獲得 [Arg3] 點臨時<PowerIconKeywords:力量>。若杜勒賽因在隊伍中，獲得 1 個<CarcassKeywords:殘骸>。"
  },
  Skill_94561_Desc = {
    Text = "<TouquKeywords:竊取>所有敵人 [Arg1] 點 <PowerIconKeywords:力量>。若杜勒賽因在隊伍中，獲得 1 個<CarcassKeywords:殘骸>。"
  },
  Skill_94561_Name = {
    Text = "殘忍的致意"
  },
  Skill_94565_Desc = {
    Text = "將全部卡牌置入手中，但不再降低算力消耗。"
  },
  Skill_94565_Name = {
    Text = "一掃而光！"
  },
  Skill_94683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 1 回合<WeaknessIconKeywords:虛弱>。"
  },
  Skill_94683_Name = {Text = "釘刺"},
  Skill_94684_Desc = {
    Text = "施加 [Arg1] 點<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94684_Name = {Text = "詛咒"},
  Skill_94685_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_94686_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害,自身死亡。"
  },
  Skill_94703_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，若未被完全格擋將 1 張<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆。"
  },
  Skill_94704_Desc = {
    Text = "施加 1 回合的 <WeaknessIconKeywords:虛弱>和<FragileIconKeywords:脆弱> 。"
  },
  Skill_94704_Name = {Text = "污濁"},
  Skill_94709_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次, 並附加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94709_Name = {Text = "屍染"},
  Skill_94711_Desc = {
    Text = "所有友方回復食屍鬼自身已損失生命值的10%，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_94722_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 [Arg2] 點<IntoxicationIconKeywords:中毒>，並在前方召喚 1 個「腐屍分殖體」。"
  },
  Skill_94722_Name = {
    Text = "墓群的召喚"
  },
  Skill_94723_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 [Arg2] 點<IntoxicationIconKeywords:中毒>，並召喚 2 個「腐屍分殖體」。"
  },
  Skill_94723_Name = {
    Text = "滿月的呼喚"
  },
  Skill_94725_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 [Arg2] 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_94726_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 [Arg2] 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_94731_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 , 並附加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94731_Name = {Text = "屍染"},
  Skill_94732_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 [Arg2] 回合<HeavyInjuryKeywords:重創>。"
  },
  Skill_94952_Desc = {
    Text = "獲得 [Arg1] 層<Guaiwusiwangdikang:死亡抵抗>，召喚 2 個「深海分殖體」。"
  },
  Skill_94952_Name = {
    Text = "海洋的召喚"
  },
  Skill_94953_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 2 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_94954_Desc = {
    Text = "獲得 [Arg1] 層<Guaiwusiwangdikang:死亡抵抗>，[Arg2] 點<PowerIconKeywords:力量>，[Arg3] 點<Kuangbao: 狂暴>。"
  },
  Skill_94954_Name = {
    Text = "不滅之魂"
  },
  Skill_94955_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>。"
  },
  Skill_94955_Name = {
    Text = "饑餓意志"
  },
  Skill_94956_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，[Arg2] 點<Kuangbao: 狂暴>。"
  },
  Skill_94956_Name = {
    Text = "饑餓意志"
  },
  Skill_94957_Desc = {
    Text = "自身死亡，為生命最高友方提高 [Arg1] 點<PowerIconKeywords:力量>，並使其提高等同於自身當前生命值兩倍的最大生命（[Arg2] ）。"
  },
  Skill_94958_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加傷害量 [Arg2]%<IntoxicationIconKeywords:中毒>，移除目標 [Arg3]% <PowerIconKeywords:力量>。"
  },
  Skill_94958_Name = {
    Text = "靈魂侵吞"
  },
  Skill_94959_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每次受到暴擊傷害降低 1 次攻擊次數，最多降低至 3 次。"
  },
  Skill_94960_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Arg2] 點<RetaliateIconKeywords:臨時反擊>。"
  },
  Skill_94961_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加傷害量 [Arg2]%<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94961_Name = {
    Text = "靈魂侵吞"
  },
  Skill_94962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，每次受到暴擊傷害降低 1 次攻擊次數，最低 3 次。"
  },
  Skill_94962_Name = {
    Text = "怒海狂濤"
  },
  Skill_94963_Desc = {
    Text = "獲得 [Arg1] 層<Guaiwusiwangdikang:死亡抵抗>，免疫 [Arg2] 回合負面狀態，召喚 2 個「深海分殖體」。"
  },
  Skill_94963_Name = {
    Text = "深海的呼喚"
  },
  Skill_94964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加 1 回合<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_94965_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次 , 並附加 [Arg3]% 傷害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94965_Name = {Text = "蝕靈"},
  Skill_94966_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。"
  },
  Skill_94966_Name = {Text = "貪慾"},
  Skill_94967_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，施加傷害量 [Arg2]%<IntoxicationIconKeywords:中毒>，移除目標 [Arg3]% <PowerIconKeywords:力量>。"
  },
  Skill_94967_Name = {
    Text = "靈魂侵吞"
  },
  Skill_94968_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，獲得 [Arg2] 點<RetaliateIconKeywords:臨時反擊>，[Arg3]%<Baojidikang:臨時暴擊抵抗>。"
  },
  Skill_95807_Desc = {
    Text = "造成 [Arg1] 點傷害，享受 [Arg2] 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_95807_Name = {
    Text = "亡骸祭禮"
  },
  Skill_95808_Desc = {
    Text = "所有敵人獲得 [Arg1] 點臨時<PowerIconKeywords:力量>。「葬骸之主」失去一半<Guaiwucanhai:殘骸>。"
  },
  Skill_95808_Name = {
    Text = "偷襲儲備"
  },
  Skill_95809_AwakerSkillBackgroundStory = {
    Text = "噓……食屍鬼之王不歡迎無禮的賓客。"
  },
  Skill_95809_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg3]> 點護盾。獲得 <Energy:[Energy:Arg4]> 點狂氣。"
  },
  Skill_95809_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。杜勒賽因獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_95809_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_95809_Name = {Text = "防禦"},
  Skill_95809_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_95810_Desc_1 = {
    Text = "選擇一名友方，使其獲得自身 [Arg1] 張不同且附加<PVPVoidKeywords:虛無>和算力消耗 +[Arg2] 的「技能」。"
  },
  Skill_95810_Name_1 = {
    Text = "殘忍的致意"
  },
  Skill_95810_UnknownName = {
    Text = "殘忍的致意"
  },
  Skill_95811_AwakerSkillBackgroundStory = {
    Text = "請柬的紙張用來自柔軟的肌膚。請柬的裝飾來自光滑的顱骨。請柬的文字來自新鮮的血液。請柬的簽名來自王邸那位熱情的主人。\n杜勒賽因向您發來誠摯的邀請，邀請您來到這場屬於你們的盛宴。"
  },
  Skill_95811_Desc_0 = {
    Text = "杜勒賽因獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，杜勒賽因造成的傷害額外享受 [Arg3]％ 力量加成。杜勒賽因每回合首次造成擊殺後，對其他敵人造成 50%溢出傷害的<FixedDamage:純粹傷害>。"
  },
  Skill_95811_Desc_15 = {
    Text = "杜勒賽因獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 [Power:Arg2] 點<PowerIconKeywords:力量>，杜勒賽因造成的傷害額外享受 [Arg3]％ 力量加成。對所有敵人造成當前生命 [Arg4]％ 的<FixedDamage:純粹傷害>。杜勒賽因每回合首次造成擊殺後，對其他敵人造成 100%溢出傷害的<FixedDamage:純粹傷害>。"
  },
  Skill_95811_EffectNameList = {
    Text = "狂氣,力量"
  },
  Skill_95811_Name = {
    Text = "王邸的請柬"
  },
  Skill_95811_PropertyNameList = {
    Text = "$GrowValue1,攻擊力*GrowValue2"
  },
  Skill_95812_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：裝備時獲得 [Arg1] <StrongEffectKeywords:強效>。擊殺敵方時溢出的傷害將向後方喚醒體傳遞。"
  },
  Skill_95813_AwakerSkillBackgroundStory = {
    Text = "一場精彩的宴會，怎麼能夠少了舞蹈？"
  },
  Skill_95813_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg3]> 點傷害。獲得 <Energy:[Energy:Arg4]> 點狂氣。"
  },
  Skill_95813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。杜勒賽因獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_95813_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_95813_Name = {Text = "打擊"},
  Skill_95813_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_95814_AwakerSkillBackgroundStory = {
    Text = "在黑暗中，杜勒賽因重新睜開了眼。\n沒有感傷，沒有仇恨。他滿懷期待地享用，享用自己作為人類的軀體。\n他從一開始就知道，自己的道路將通往何方。"
  },
  Skill_95814_BattleDesc = {
    Text = "失去 10%( [Arg2] ) 當前生命，對所有敵人造成 <Damage:[Damage:Arg3]> 點傷害並使其<VulnerabilityIconKeywords:易傷> 1 回合。"
  },
  Skill_95814_Desc = {
    Text = "失去 10％當前生命，對所有敵人造成 <Damage:[Damage:Arg1]> 點傷害並使其<VulnerabilityIconKeywords:易傷> 1 回合。"
  },
  Skill_95814_EffectNameList = {Text = "傷害"},
  Skill_95814_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_95815_Desc = {
    Text = "獲得 [Arg1]  層<Guaiwusiwangdikang:死亡抵抗>和 [Arg2]  層<Guaiwucanhai:殘骸>，召喚「腐屍分殖體」與「食屍鬼侍從」。"
  },
  Skill_95815_Name = {
    Text = "王邸的請柬"
  },
  Skill_95816_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機「<Dongjie:凍結>」 [Arg3]  張抽牌堆中的卡牌。"
  },
  Skill_95817_AwakerSkillBackgroundStory = {
    Text = "除了菜品本身，用餐的方式也是美食藝術重要的一環。\n用敵人的屍骨製成的餐叉，深切地刺入敵人的靈魂。\n每一道菜餚，都是一場精心準備的重逢。"
  },
  Skill_95817_BattleDesc = {
    Text = "對生命最低的敵人造成 <Damage:[Damage:Arg4]> 點傷害，享受 [Arg2]％ 力量加成，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_95817_Desc = {
    Text = "對生命最低的敵人造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成，獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_95817_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_95817_Name = {
    Text = "亡骸祭禮"
  },
  Skill_95817_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_95818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，敵方生命越低傷害越高，最大為 <Damage:[Damage:Arg2]> 點傷害。吸收所有其他食屍鬼，每吸收 1 名獲得 [Arg3] 具<Guaiwucanhai:殘骸>和 [Arg4] 層<Guaiwusiwangdikang:死亡抵抗>。"
  },
  Skill_95818_Name = {
    Text = "萬靈的饜饗"
  },
  Skill_95819_BattleDesc = {
    Text = "清除所有「饜足」，棄掉所有手牌，將透過<DerivativeCardKeywords_111:「靈魂吞噬」>移除的卡牌置入手中，使它們算力消耗變為 0。回合結束時若在手中：隨機將一張被移除卡牌的複製置入手中，使其算力消耗變為0，並獲得消耗、虛無。"
  },
  Skill_95819_Desc = {
    Text = "清除所有「饜足」，棄掉所有手牌，將透過<DerivativeCardKeywords_111:「靈魂吞噬」>移除的卡牌置入手中，使它們算力消耗變為 0。回合結束時若在手中：隨機將一張被移除卡牌的複製置入手中，使其算力消耗變為0，並獲得消耗、虛無。"
  },
  Skill_95819_Name = {
    Text = "記憶共鳴"
  },
  Skill_95820_AwakerSkillBackgroundStory = {
    Text = "撕下你的偽裝。放下你的偏見。踏入舞池，擁抱你沉睡多年的舞伴。\n它已經多久沒有見過美麗的月光？它已經多久沒有聽過溫柔的情話？\n聽吶，它正在渴望著你，一如你正在渴望著它。\n撕咬吧，吞噬吧。在這無與倫比的盛筵裡，生靈與死者完成他們共同的昇華。"
  },
  Skill_95820_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_110:>本次狂氣爆發暴擊率+[Arg2]％，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。】對生命最低的敵人造成 <Damage:[Damage:Arg3]> 點傷害，享受 [Arg4]％ 力量加成，目標每損失 1％ 生命本次狂氣爆發最終傷害提高 3％。若當前擁有 3 具<CarcassKeywords:殘骸>則將其食用，回覆 <Heal:[Heal:Arg5]> 點生命並使本次狂氣爆發享受的暴擊傷害加成翻倍（當前擁有 [Arg6]/3 具<CarcassKeywords:殘骸>）。"
  },
  Skill_95820_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂氣爆發暴擊率+[Arg2]％，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。】對生命最低的敵人造成 <Damage:[Damage:Arg3]> 點傷害，享受 [Arg4]％ 力量提升，目標每損失 1％ 生命本次狂氣爆發最終傷害提高 3％。若當前擁有 3 具<CarcassKeywords:殘骸>則將其食用，回覆 <Heal:[Heal:Arg5]> 點生命並使本次狂氣爆發享受的暴擊傷害提升翻倍（當前擁有 [Arg6]/3 具<CarcassKeywords:殘骸>）。"
  },
  Skill_95820_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_110:>本次狂氣爆發暴擊率+[Arg2]％，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。】對生命最低的敵人造成 <Damage:[Damage:Arg3]> 點傷害，享受 [Arg4]％ 力量加成，目標每損失 1％ 生命本次狂氣爆發最終傷害提高 3％。若當前擁有 3 具<CarcassKeywords:殘骸>則將其食用，回覆 <Heal:[Heal:Arg5]> 點生命並使本次狂氣爆發享受的暴擊傷害加成翻倍。"
  },
  Skill_95820_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂氣爆發暴擊率+[Arg2]％，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。】對生命最低的敵人造成 <Damage:[Damage:Arg3]> 點傷害，享受 [Arg4]％ 力量提升，目標每損失 1％ 生命本次狂氣爆發最終傷害提高 3％。若當前擁有 3 具<CarcassKeywords:殘骸>則將其食用，回覆 <Heal:[Heal:Arg5]> 點生命並使本次狂氣爆發享受的暴擊傷害加成翻倍。"
  },
  Skill_95820_EffectNameList = {
    Text = "力量,傷害,治療"
  },
  Skill_95820_Name = {
    Text = "生靈的盛筵"
  },
  Skill_95820_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂氣爆發暴擊率+[Arg2]％，獲得 [Power:Arg1] 點<PowerIconKeywords:力量>。】本次狂氣爆發的暴擊率+ 25%，基礎傷害提高 50%。對生命最低的敵人造成 <Damage:[Damage:Arg7]> 點傷害，享受 [Arg4]％ 力量加成，本次狂氣爆發造成的最終傷害提高 100％，目標每損失 1％ 生命額外提高 3％。若當前擁有 3 具「殘骸」則將其食用，回復 <Heal:[Heal:Arg5]> 點生命並使本次狂氣爆發享受的暴擊傷害加成翻倍（當前擁有 [Arg6]/3 具殘骸）。"
  },
  Skill_95820_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2,體質*GrowValue3"
  },
  Skill_95821_Desc = {
    Text = "消耗一半 <Guaiwucanhai:殘骸> ( [Arg3] ) ，每消耗 1 層獲得 [Arg1] <PowerIconKeywords:力量>，並提高 [Arg2]% 生命上限。召喚「腐屍分殖體」與「食屍鬼侍從」。"
  },
  Skill_95821_Name = {
    Text = "殘骸收取"
  },
  Skill_95822_Desc = {
    Text = "選擇一個策略。每次「葬骸之主」釋放「殘骸收取」後，置入手中。"
  },
  Skill_95823_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，消耗一半<Guaiwucanhai:殘骸>( [Arg3] )，每消耗 1 層，獲得 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_95823_Name = {
    Text = "殘骸收取"
  },
  Skill_95824_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後抽 [Arg1] 張牌，優先抽取自身「技能」，並使其算力消耗 - [Arg2] 。"
  },
  Skill_95824_Name_1 = {Text = "珍饈"},
  Skill_95825_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，敵方生命越低傷害越高，最大為 <Damage:[Damage:Arg2]> 點傷害。回合結束時吸收所有其他食屍鬼，每吸收 1 名獲得 [Arg3] 具<Guaiwucanhai:殘骸>。"
  },
  Skill_95825_Name = {
    Text = "生靈的盛筵"
  },
  Skill_95826_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2] 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_95826_Name = {
    Text = "亡骸祭禮"
  },
  Skill_95827_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機「<Dongjie:凍結>」[Arg3] 張抽牌堆中的卡牌。"
  },
  Skill_95828_BattleDesc = {
    Text = "選擇一個友方喚醒體，移除手中其所有卡牌，每張獲得一層「饜足」並使其他喚醒體獲得 <Energy:5> 點狂氣。"
  },
  Skill_95828_Desc = {
    Text = "選擇一個友方喚醒體，移除手中其所有卡牌，每張獲得一層「饜足」並使其他喚醒體獲得 <Energy:5> 點狂氣。"
  },
  Skill_95828_Name = {
    Text = "靈魂吞噬"
  },
  Skill_95829_Desc = {
    Text = "所有敵人的傷害臨時降低 30%。"
  },
  Skill_95829_Name = {
    Text = "正面干擾"
  },
  Skill_95986_Desc = {Text = "100雙暴"},
  Skill_95986_Name = {Text = "100雙暴"},
  Skill_95989_Desc = {Text = "100強效"},
  Skill_95989_Name = {Text = "100強效"},
  Skill_96018_Desc = {
    Text = "本場戰鬥造成的最終傷害提高 25%，所有喚醒體獲得 30 點狂氣。清除所有卡牌的「<Kuangluan:蹈海者狂亂>」狀態，消耗手中至多 2 張症狀並抽等量卡牌。"
  },
  Skill_96019_Desc = {
    Text = "本場戰鬥造成的最終傷害提高 50%，所有喚醒體獲得 50 點狂氣。清除所有卡牌的「<Kuangluan:蹈海者狂亂>」狀態，消耗手中至多 3 張症狀並抽等量卡牌。"
  },
  Skill_96019_Name = {
    Text = "受損的符印"
  },
  Skill_96022_Desc = {
    Text = "本場戰鬥造成的最終傷害提高 100%，所有喚醒體獲得 100 點狂氣。清除所有卡牌的「<Kuangluan:蹈海者狂亂>」狀態，消耗手中所有症狀並抽等量卡牌。"
  },
  Skill_96188_BattleDesc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg2]> 點<PunctureDamagewords:穿刺傷害>。"
  },
  Skill_96188_BattleDesc_3 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg2]> 點<PunctureDamagewords:穿刺傷害>，打出後會使本回合後續打出的「永夜歡宴」額外享受 100% 力量加成。"
  },
  Skill_96188_Desc_0 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。"
  },
  Skill_96188_Desc_3 = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，打出後會使本回合後續打出的「永夜歡宴」額外享受 100% 力量加成。"
  },
  Skill_96188_Name = {
    Text = "永夜歡宴"
  },
  Skill_96325_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆隨機 4 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_96326_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_96327_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。使抽牌堆隨機 3 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_96328_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<BlindingKeywords:致盲>，使抽牌堆隨機 1 張牌附加<ColorInkKeywords:認知失調>。"
  },
  Skill_96342_Desc = {
    Text = "獲得 [Arg1]%<Baojidikang:暴擊抵抗>和 [Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_96343_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<HeavyInjuryKeywords:重創>，敵方生命越低傷害越高，最大為 <Damage:[Damage:Arg4]> 點傷害。"
  },
  Skill_96344_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，「<Dongjie:凍結>」[Arg3]  張抽牌堆頂部的卡牌。"
  },
  Skill_96344_Name = {
    Text = "靈魂封存"
  },
  Skill_96345_Desc = {
    Text = "獲得 [Arg1] 點<PowerIconKeywords:力量>，[Arg2]%<Baojidikang:暴擊抵抗>和 [Arg3] 層<Fennu:「憤怒」>。"
  },
  Skill_96345_Name = {Text = "執念"},
  Skill_96590_Desc = {
    Text = "「祭靈夜特調」追加「使所有喚醒體獲得 [Arg1] 點狂氣。」"
  },
  Skill_96591_Desc = {
    Text = "「祭靈夜特調」追加「獲得 [Arg1] 點銀鑰能量。」"
  },
  Skill_96591_Name = {
    Text = "無垢之銀"
  },
  Skill_96592_Desc = {
    Text = "「祭靈夜特調」追加「回復 [Arg1] 點生命。」"
  },
  Skill_96592_Name = {
    Text = "血腥之紅"
  },
  Skill_96593_Desc = {
    Text = "「祭靈夜特調」追加「將 1 張」靈感「置入手中。」"
  },
  Skill_96593_Name = {
    Text = "靈感之藍"
  },
  Skill_96594_Desc = {
    Text = "「祭靈夜特調」追加「獲得 [Arg1] 點臨時力量和 [Arg2] 點臨時戒備。」"
  },
  Skill_96594_Name = {
    Text = "森然之綠"
  },
  Skill_96734_BattleDesc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方造成 <Damage:[Damage:Arg2]> 傷害，每消耗 1 點算力使傷害提升 [Arg3]。"
  },
  Skill_96734_Desc_1 = {
    Text = "對<HPAndShieldMax:生命與護盾最高>的敵方造成 <Damage:[Damage:Arg1]> 傷害，每消耗 1 點算力使傷害提升 [Arg3]。"
  },
  Skill_96734_Name_1 = {
    Text = "告死魔彈"
  },
  Skill_96735_BattleDesc_1 = {
    Text = "造成合計 <Damage:[Damage:Arg1]> 傷害，平均分配給所有敵方，每個敵方受到 <Damage:[Damage:Arg2]> 傷害。"
  },
  Skill_96735_Desc_1 = {
    Text = "造成合計 <Damage:[Damage:Arg1]> 傷害，平均分配給所有敵方。"
  },
  Skill_96735_Name_1 = {
    Text = "焚卻世界的爆炎"
  },
  Skill_96736_Desc_1 = {
    Text = "獲得 <Energy:[Energy:Arg1]> 狂氣，<StrongEffectKeywords:強效> +[Arg2]。"
  },
  Skill_96737_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_96737_Name_1 = {Text = "打擊"},
  Skill_96738_Desc_1 = {
    Text = "對全體敵方施加<DelayKeywords:延遲>：<PVPWeaknessesKeywords:破綻>。"
  },
  Skill_96738_Name_1 = {
    Text = "萬物終結"
  },
  Skill_96755_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，造成等同於未被格擋傷害 50% 的<BleedingIconKeywords:出血>，每層「<Chaos:混亂>」攻擊次數降低 1 。"
  },
  Skill_96756_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，敵方生命越低傷害越高，施加 1 層「<Daohaizheyishi: 蹈海者祭儀>」。"
  },
  Skill_96756_Name = {
    Text = "蹈海者的審判"
  },
  Skill_96757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，敵方生命越低傷害越高，為 3 張卡牌附加「<Kuangluan:蹈海者狂亂>」。"
  },
  Skill_96758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張隨機「畸變」洗入抽牌堆，每層「<Chaos:混亂>」減少 1 張。"
  },
  Skill_96758_Name = {
    Text = "深淵聚爆"
  },
  Skill_96759_Desc = {
    Text = "使自身最大生命提高 [Arg1]%，額外獲得 [Arg2] 次生命，獲得 [Arg3] 點<RetaliateIconKeywords:反擊>、[Arg4] 點<Duren: 毒刃>、[Arg5]% <Baojidikang:暴擊抵抗>。"
  },
  Skill_96759_Name = {
    Text = "骨血重組"
  },
  Skill_96760_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg3] 點<PowerIconKeywords:力量>。每層「<Chaos:混亂>」使獲得的力量降低  [Arg4] 點。"
  },
  Skill_96760_Name = {
    Text = "奔騰湧流"
  },
  Skill_96761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，將 [Arg3] 張隨機「症狀」洗入抽牌堆，每層「<Chaos:混亂>」減少 1 張。"
  },
  Skill_96761_Name = {
    Text = "屍群聚爆"
  },
  Skill_96762_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，造成等同於未被格擋傷害 50% 的<BleedingIconKeywords:出血>，每層「<Chaos:混亂>」攻擊次數降低 1 。"
  },
  Skill_96787_Desc = {
    Text = "杜勒賽因張開的暫未完成的法陣，能夠為你提供一定的防護，但未格擋的傷害會同等傳導到法陣之上，回復生命時會回復 33% 的完好度。永久保留。當前完好度：[Arg2]/[Arg3]（[Arg1]%）。「溟夢之帷」完成回合數： [Arg4]/3。"
  },
  Skill_96787_Name = {
    Text = "溟夢之帷"
  },
  Skill_97107_Desc_1 = {
    Text = "<DelayKeywords:延遲>：獲得 [Arg1] 點無視上限的算力。"
  },
  Skill_97107_Name_1 = {
    Text = "不落的太陽"
  },
  Skill_97107_UnknownName = {
    Text = "不落的太陽"
  },
  Skill_97108_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「打擊」獲得 [Arg1] 算力，「技能」傷害提高 [Arg2]%。"
  },
  Skill_97108_Name_1 = {
    Text = "迫近的太陽"
  },
  Skill_97109_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「技能」每需要消耗 1 算力傷害提升 [Arg1]%。造成擊殺後「狂氣爆發」造成傷害提升 [Arg2]%。"
  },
  Skill_97159_Desc = {
    Text = "自身死亡，為生命最高友方提高 [Arg1] 點<PowerIconKeywords:力量>，並使其提高等同於自身當前生命值兩倍的最大生命（[Arg2] ）。"
  },
  Skill_97318_Desc = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>。"
  },
  Skill_97318_Name = {
    Text = "永夜歡宴"
  },
  Skill_97319_Desc = {
    Text = "對所有敵人造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，打出後會使本回合後續打出的「永夜歡宴」額外享受 100% 力量加成。"
  },
  Skill_97319_Name = {
    Text = "永夜歡宴"
  },
  Skill_97911_AwakerSkillBackgroundStory = {
    Text = "她十分隨意的開槍射擊，並不在意彈藥是否命中。\n「狩獵開始，先熱熱身吧。」"
  },
  Skill_97911_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_97911_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。凱蒂古拉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_97911_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_97911_Name = {Text = "打擊"},
  Skill_97911_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_97912_AwakerSkillBackgroundStory = {
    Text = "火與光置換了世界，你的眼中只剩下無盡耀光。你無法思考，無法理解，你不明白世界為何消失了。直至一切被蒸發至虛無的最後一刻，你才意識到，那是太陽爆發時，最閃耀的色彩。"
  },
  Skill_97912_BattleDesc_0 = {
    Text = "<DerivativeCardKeywords_117:>對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成。"
  },
  Skill_97912_BattleDesc_2 = {
    Text = "<DerivativeCardKeywords_117:>對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成，擁有 3 層「<HuoyanKeywords4:活焰>」時造成的基礎傷害提高 50％。"
  },
  Skill_97912_Desc_0 = {
    Text = "<DerivativeCardKeywords_117:>對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成。"
  },
  Skill_97912_Desc_2 = {
    Text = "<DerivativeCardKeywords_117:>對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，享受 [Arg2]％ 力量加成，擁有 3 層「<HuoyanKeywords:活焰>」時造成的基礎傷害提高 50％。"
  },
  Skill_97912_EffectNameList = {Text = "傷害"},
  Skill_97912_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_97913_AwakerSkillBackgroundStory = {
    Text = "這是來自末路的預告，它會帶你迎接死亡的終末。你自可以拒絕死神的邀請，但在這之後，你將看到世上最璀璨的耀光。"
  },
  Skill_97913_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_97913_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次，獲得 [Power:Arg4] 點<PowerIconKeywords:力量>，擁有 3 層<HuoyanKeywords4:活焰>時額外獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_97913_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次，獲得 [Power:Arg2] 點<PowerIconKeywords:力量>。"
  },
  Skill_97913_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 2 次，獲得 [Power:Arg4] 點<PowerIconKeywords:力量>，擁有 3 層<HuoyanKeywords:活焰>時額外獲得 [Power:Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_97913_EffectNameList = {
    Text = "傷害,力量"
  },
  Skill_97913_Name = {
    Text = "末路槍聲"
  },
  Skill_97913_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_97914_AwakerSkillBackgroundStory = {
    Text = "彈藥、刀劍、邪法……無論是從何處發出的攻擊，只要在到來前將其載體燒毀，就是最好的防禦。"
  },
  Skill_97914_BattleDesc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_97914_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。凱蒂古拉獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_97914_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_97914_Name = {Text = "防禦"},
  Skill_97914_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_97915_AwakerSkillBackgroundStory = {
    Text = "灼熱的火焰再次燃起，覆蓋全身的瘢痕開始閃爍耀眼的白光。\n「來吧，玩鬧時間結束了，該開始第二回合了。」"
  },
  Skill_97915_BattleDesc_0 = {
    Text = "凱蒂古拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時額外為手中 1 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords4:活焰>。打出賦予 3 層<HuoyanKeywords4:活焰>的指令卡後使其返回手中。"
  },
  Skill_97915_BattleDesc_15 = {
    Text = "凱蒂古拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時額外為手中 1 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords4:活焰>。打出賦予 3 層<HuoyanKeywords4:活焰>的指令卡後使其返回手中。凱蒂古拉每層「活焰」的最終傷害和力量效果 +30%。"
  },
  Skill_97915_Desc_0 = {
    Text = "凱蒂古拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時額外為手中 1 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords:活焰>。打出賦予 3 層<HuoyanKeywords:活焰>的指令卡後使其返回手中。"
  },
  Skill_97915_Desc_15 = {
    Text = "凱蒂古拉獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：回合開始時額外為手中 1 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords:活焰>。打出賦予 3 層<HuoyanKeywords:活焰>的指令卡後使其返回手中。凱蒂古拉每層「活焰」的最終傷害和力量效果 +30%。"
  },
  Skill_97915_EffectNameList = {Text = "狂氣"},
  Skill_97915_Name = {
    Text = "業火重燃"
  },
  Skill_97916_BattleDesc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，每消耗 1 點算力額外享受 150% 力量加成。消耗所有「爆炎」，每層額外享受 50％ 力量加成(當前共用受 [Arg2]％ 力量加成)。打出後將所有「億兆耀斑」還原為「千兆耀斑」。"
  },
  Skill_97916_Desc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點傷害，每消耗 1 點算力額外享受 150% 力量加成。消耗所有「爆炎」，每層額外享受 50％ 力量加成。打出後將所有「億兆耀斑」還原為「千兆耀斑」。"
  },
  Skill_97916_EffectNameList = {Text = "傷害"},
  Skill_97916_Name = {
    Text = "億兆耀斑"
  },
  Skill_97916_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_97917_Desc = {
    Text = "獲得 1 點算力和 [Arg1]％ 臨時強效。若凱蒂古拉在隊伍中，抽 1 張其「指令卡」並賦予 1 層「<HuoyanKeywords:活焰>」"
  },
  Skill_97917_Name = {
    Text = "不落的太陽"
  },
  Skill_97918_AwakerSkillBackgroundStory = {
    Text = "祂的使者魚貫而出，狂舞著揮灑琥珀色的火焰。這是祂的力量，祂的意志，祂的權責，祂的火將覆蓋天地，將世界焚燒殆盡。"
  },
  Skill_97918_BattleDesc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，享受 [Arg2]％ 力量加成。抽 2 張凱蒂古拉的「指令卡」，為手中 3 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords4:活焰>。"
  },
  Skill_97918_Desc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害>，享受 [Arg2]％ 力量加成。抽 2 張凱蒂古拉的「指令卡」，為手中 3 張凱蒂古拉的「指令卡」賦予 1 層<HuoyanKeywords:活焰>。"
  },
  Skill_97918_EffectNameList = {Text = "傷害"},
  Skill_97918_Name = {
    Text = "焚卻世界的爆炎"
  },
  Skill_97918_OverLimitUtlSkillDesc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點<PunctureDamagewords:穿刺傷害> 3 次，享受 [Arg2]％ 力量加成。抽 2 張凱蒂古拉的「指令卡」，隨機為手中凱蒂古拉的指令卡分配 5 層<HuoyanKeywords4:活焰>。"
  },
  Skill_97918_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_97919_BattleDesc = {
    Text = "選擇 1 名喚醒體，將 1 張算力消耗為 0 的臨時「打擊」置入手中。每第 3 次釋放，改為將 1 張「美麗瞬間」置入手中，並使所有喚醒體臨時暴擊率提高 [Arg1]％(當前已釋放 [Arg2] 次)。"
  },
  Skill_97919_Desc = {
    Text = "選擇 1 名喚醒體，將 1 張算力消耗為 0 的臨時「打擊」置入手中。每第 3 次釋放，改為將 1 張「美麗瞬間」置入手中，並使所有喚醒體臨時暴擊率提高 [Arg1]％。"
  },
  Skill_98057_Desc = {
    Text = "獲得「震怒」、12 層「困意」以及 [Arg1] 點觸腕傷害。"
  },
  Skill_98057_Name = {
    Text = "不朽威儀"
  },
  Skill_98119_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [Arg2] 次。獲得 [Arg3] 點<PowerIconKeywords:力量>。"
  },
  Skill_98119_Name = {
    Text = "末路槍聲"
  },
  Skill_98120_Desc = {
    Text = "切換到該意圖時棄置所有剩餘手牌並賦予<BurningKeywords:燃燒>。對方回合開始後隨機<BurningKeywords:燃燒> [Arg1] 張手牌。"
  },
  Skill_98120_Name = {
    Text = "業火重燃"
  },
  Skill_98121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，隨機<BurningKeywords:燃燒> [Arg3] 張抽牌堆或棄牌堆的卡牌，造成 [Arg4] 層<VulnerabilityIconKeywords:易傷>。"
  },
  Skill_98126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，額外受到 [Arg3] 倍<PowerIconKeywords:力量>和<ExhaustionIconKeywords:力量降低>影響。清除所有<MonsterExFlameKeywords:爆炎>，每層提高 [Arg4] <PowerIconKeywords:力量>。"
  },
  Skill_98126_Name = {
    Text = "億兆耀斑"
  },
  Skill_98127_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，<BurningKeywords:燃燒>對方所有剩餘手牌，每有 1 張獲得 1 層<MonsterExFlameKeywords:爆炎>。"
  },
  Skill_98127_Name = {
    Text = "焚卻世界的爆炎"
  },
  Skill_98195_Desc_1 = {
    Text = "抽 2 張算力消耗最低的「技能」。"
  },
  Skill_98313_Desc = {
    Text = "減少80層"
  },
  Skill_98313_Name = {
    Text = "減少80層"
  },
  Skill_98317_Desc = {
    Text = "若記錄了 2 種不同的「<PrimaryColor:原色>」，會帶來持續增益效果。"
  },
  Skill_98317_Name = {
    Text = "異象調色盤"
  },
  Skill_98332_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。"
  },
  Skill_98332_Name = {
    Text = "<Blue:原色·藍>"
  },
  Skill_98333_Desc = {
    Text = "使所有喚醒體獲得 <Energy:8> 點狂氣。"
  },
  Skill_98333_Name = {
    Text = "<Yellow:原色·黃>"
  },
  Skill_98334_Desc = {
    Text = "獲得 [Power:Arg1] 點<PowerIconKeywords:臨時力量>，本回合中造成的最終傷害提高 10%。"
  },
  Skill_98334_Name = {
    Text = "<Red:原色·紅>"
  },
  Skill_98508_Desc = {
    Text = "獲得 3 點算力，使手中的所有指令卡獲得<BurningKeywords:燃燒>，本回合打出<BurningKeywords:燃燒>的卡牌後消耗 1 層<Heat:深暗之焰>使其生效 2 次，回合結束後清空<Heat:深暗之焰>。"
  },
  Skill_98508_Name = {
    Text = "無盡的爆炎"
  },
  Skill_98704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等同於傷害 [Arg3]% 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_98704_Name = {
    Text = "蒼白迴旋"
  },
  Skill_98705_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，額外造成敵方中毒層數 [Arg3]%的傷害。"
  },
  Skill_98705_Name = {Text = "打擊"},
  Skill_98706_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 點 <PowerIconKeywords:力量>。"
  },
  Skill_98706_Name = {
    Text = "蒼白的庇佑"
  },
  Skill_98707_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 點 <PowerIconKeywords:力量>，對抽牌堆頂部的 [Arg3] 張卡牌施加 [Arg4] 層遲緩。"
  },
  Skill_98707_Name = {
    Text = "不耐的施捨"
  },
  Skill_98729_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，對抽牌堆頂部的 [Arg2] 張卡牌施加 [Arg3] 層遲緩。"
  },
  Skill_98729_Name = {
    Text = "不耐的施捨"
  },
  Skill_98730_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，施加等同於傷害 [Arg3]% 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_98730_Name = {
    Text = "蒼白迴旋"
  },
  Skill_98731_Desc = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾，獲得 [Arg2] 點 <PowerIconKeywords:力量>，獲得 [Arg3] 點<AlertIconKeywords:戒備>。"
  },
  Skill_98731_Name = {
    Text = "蒼白的庇佑"
  },
  Skill_98744_Desc = {
    Text = "獲得「僭越者」，施加的中毒提高 100%，每個回合結束後獲得 <Block:[Block:Arg1]> 護盾。"
  },
  Skill_98984_AwakerSkillBackgroundStory = {
    Text = "別畏懼我的凝視，走向我吧，靠近我吧……\n在畫筆創造出的瑰麗幻境中，讓我賦予你至高無上的美。"
  },
  Skill_98984_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 張指令卡算力消耗- 2。】獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 。本回合其他喚醒體狂氣爆發造成的最終傷害、護盾、生命回復提高 [Arg2]％。<FaxianKeywords:發現> 3 張具有<Chuanggoukeyin:創構的刻印>的出戰喚醒體的「技能」，選擇 1 張置入手中併為其賦予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_Desc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 張指令卡算力消耗 -2。】獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 。本回合其他喚醒體狂氣爆發造成的最終傷害、護盾、生命回復提高 [Arg2]％。<FaxianKeywords:發現> 3 張具有<Chuanggoukeyin:創構的刻印>的出戰喚醒體的「技能」，選擇 1 張置入手中併為其賦予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_Name = {
    Text = "真實，亦是幻想"
  },
  Skill_98984_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 張指令卡算力消耗- 2。】獲得 [Power:Arg1] 點<PowerIconKeywords:力量> 。本回合其他喚醒體狂氣爆發造成的最終傷害、護盾、生命回復提高 [Arg2]％。獲得 1 層<Kuangxiang:狂想>，<FaxianKeywords:發現> 3 張具有<Chuanggoukeyin:創構的高級刻印>的出戰喚醒體的「技能」2 次，選擇 1 張置入手中併為其賦予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_PropertyNameList = {
    Text = "攻擊力*GrowValue1"
  },
  Skill_98985_AwakerSkillBackgroundStory = {
    Text = "屍骸的殘影在皮克曼的指尖遊走，不願受馴服靈感在畫布上狂舞。\n平凡的畫家將現實的表像描摹，而真正的藝術家揮灑著癲狂，將一切不為人知的喜悅、痛苦、渴望與醜陋勾勒。"
  },
  Skill_98985_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+ [Arg1]，移除<EmptinessKeywords: 空虛>狀態。<FaxianKeywords:發現> 3 個<Chuanggouzaowu:創構的白銀造物>並選擇一個獲得，該造物持續 [Arg2] 回合。"
  },
  Skill_98985_Desc_2 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+ [Arg1]，移除<EmptinessKeywords: 空虛>狀態。<FaxianKeywords:發現> 3 個<Chuanggouzaowu:創構的黃金造物>並選擇一個獲得，該造物持續 [Arg2] 回合。"
  },
  Skill_98985_Name = {
    Text = "繪影摹形"
  },
  Skill_98986_AwakerSkillBackgroundStory = {
    Text = "這是對藝術的褻瀆！休想以狹隘的偏見玷污我的藝術。"
  },
  Skill_98986_BattleDesc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_98986_BattleDesc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。獲得 <Energy:[Energy:Arg2]> 點狂氣。隨機抽取 1 張「技能」，每回合至多生效 1 次(當前生效 [Arg3] /1 次)。"
  },
  Skill_98986_Desc_0 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。皮克曼獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_98986_Desc_1 = {
    Text = "獲得 <Block:[Block:Arg1]> 點護盾。皮克曼獲得 <Energy:[Energy:Arg2]> 點狂氣。隨機抽取 1 張「技能」，每回合至多生效 1 次。"
  },
  Skill_98986_EffectNameList = {
    Text = "護盾,狂氣"
  },
  Skill_98986_Name = {Text = "防禦"},
  Skill_98986_PropertyNameList = {
    Text = "防禦力*GrowValue1,$GrowValue2"
  },
  Skill_98987_Desc = {
    Text = "消耗 1 層「<Kuangxiang:狂想>」，選擇所有<FaxianKeywords:發現>效果。獲得 1 層<Chuangyi:創意>。"
  },
  Skill_98987_Name = {
    Text = "靈感迸發！"
  },
  Skill_98988_AwakerSkillBackgroundStory = {
    Text = "你為何如此抗拒美？\n來吧，親愛的模特，感受我的創作。"
  },
  Skill_98988_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_98988_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。獲得 <Energy:[Energy:Arg2]> 點狂氣。隨機抽取 1 張「技能」，每回合至多生效 1 次(當前生效 [Arg3] /1 次)。"
  },
  Skill_98988_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。皮克曼獲得 <Energy:[Energy:Arg2]> 點狂氣。"
  },
  Skill_98988_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害。皮克曼獲得 <Energy:[Energy:Arg2]> 點狂氣。隨機抽取 1 張「技能」，每回合至多生效 1 次。"
  },
  Skill_98988_EffectNameList = {
    Text = "傷害,狂氣"
  },
  Skill_98988_Name = {Text = "打擊"},
  Skill_98988_PropertyNameList = {
    Text = "攻擊力*GrowValue1,$GrowValue2"
  },
  Skill_98989_AwakerSkillBackgroundStory = {
    Text = "靜謐幽深的墓園，屍體如雕塑般被陳列於其間，成為別樣的模特，帶著死亡的沉默與神秘，激發了繪者無盡的靈感。\n僵硬的姿態、蒼白的肌膚、扭曲的表情……皮克曼在陰影與腐朽中尋覓美的可能。"
  },
  Skill_98989_Desc_0 = {
    Text = "皮克曼獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 層<Kuangxiang:狂想>。皮克曼每獲得 1 層<Chuangyi:創意>，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg2]。"
  },
  Skill_98989_Desc_15 = {
    Text = "皮克曼獲得 <Energy:[Energy:Arg1]> 點狂氣。<ExaltIconKeywords:靈知覺醒>：獲得 1 層<Kuangxiang:狂想>。皮克曼每獲得 1 層<Chuangyi:創意>，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg2]。「繪影摹形」創構的黃金造物持續回合數由 1 回合提高為 2 回合。"
  },
  Skill_98989_EffectNameList = {
    Text = "狂氣,胚胎融合"
  },
  Skill_98989_Name = {
    Text = "墓園畫室"
  },
  Skill_98990_AwakerSkillBackgroundStory = {
    Text = "你可曾見過真正的色彩？\n不是溫順的顏料，而是侵略性的、滲透骨髓的瘋狂。\n每一抹色澤都帶來蝕骨的顫慄與狂喜，那才是繪者所尋求的至美。"
  },
  Skill_98990_BattleDesc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害 [Arg3] 次，每造成 1 次傷害臨時降低目標 [Exhaustion:Arg2] 點<ExhaustionIconKeywords:力量>並獲得 [Power:Arg2] 點<PowerIconKeywords:臨時力量>。本回合每觸發過 1 次<FaxianKeywords:發現>效果，此卡牌基礎算力消耗降低 1，若觸發過「靈感迸發！」額外造成 2 次傷害。"
  },
  Skill_98990_Desc = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 點必定暴擊的傷害 [Arg3] 次，每造成 1 次傷害<TouquKeywords:竊取>目標 [Arg2] 點<PowerIconKeywords:力量>。本回合每觸發過 1 次<FaxianKeywords:發現>效果，此卡牌基礎算力消耗降低 1，若觸發過「靈感迸發！」額外造成 2 次傷害。"
  },
  Skill_98990_EffectNameList = {
    Text = "傷害,偷取力量"
  },
  Skill_98990_Name = {
    Text = "蝕骨色彩"
  },
  Skill_98990_PropertyNameList = {
    Text = "攻擊力*GrowValue1,攻擊力*GrowValue2"
  },
  Skill_99016_Desc = {
    Text = "消耗 1 層「<Kuangxiang:狂想>」，選擇所有<FaxianKeywords:發現>效果。獲得 1 層<Chuangyi:創意>。"
  },
  Skill_99016_Name = {
    Text = "靈感迸發！"
  },
  Skill_99035_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_99035_Name_1 = {
    Text = "幻夢繪生"
  },
  Skill_99036_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：「狂氣爆發」後隨機將 1 張裝備者的「技能」置入手牌並使其算力消耗變為 0。"
  },
  Skill_99036_Name_1 = {
    Text = "寫實主義悖謬"
  },
  Skill_99037_Desc_1 = {
    Text = "隨機觸發以下效果 3 次：對隨機敵人造成 [Arg1] 傷害，<DisarmKeywords:麻痺>、對隨機敵人造成 [Arg1] 傷害，<PVPMethysisKeywords:中毒>、對所有敵人造成 [Arg1] 傷害。"
  },
  Skill_99037_Name_1 = {
    Text = "虛世之彩"
  },
  Skill_99037_UnknownName = {
    Text = "虛世之彩"
  },
  Skill_99038_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 傷害，<DisarmKeywords:麻痺>。"
  },
  Skill_99038_Name_1 = {
    Text = "實色侵染"
  },
  Skill_99039_Desc_1 = {
    Text = "對全體敵方造成 <Damage:[Damage:Arg1]> 傷害。"
  },
  Skill_99039_Name_1 = {
    Text = "大放異彩"
  },
  Skill_99040_Desc_1 = {
    Text = "<PVPWeaponKeywords:命輪>：其他友方每回合首次「狂氣爆發」後抽 1 張牌。"
  },
  Skill_99040_Name_1 = {
    Text = "渴求的畫筆"
  },
  Skill_99041_Desc_1 = {
    Text = "將自身三張不同的算力消耗為 [Arg1] 的「技能」置入手牌，<StrongEffectKeywords:強效> +[Arg2]。"
  },
  Skill_99041_Name_1 = {
    Text = "真實，亦是幻想"
  },
  Skill_99042_Desc_1 = {
    Text = "對前排敵方造成 <Damage:[Damage:Arg1]> 傷害，獲得 <Energy:[Energy:Arg2]> 狂氣。"
  },
  Skill_99042_Name_1 = {Text = "打擊"},
  Skill_99115_Desc = {
    Text = "「繪者」轉換成食屍鬼形態，獲得 [Arg1] 點<PowerIconKeywords:力量>，對玩家抽牌堆和棄牌堆中 [Arg2] 張牌施加<ErosionColorInkKeywords:認知錯亂>。"
  },
  Skill_99115_Name = {
    Text = "墓園畫室"
  },
  Skill_99116_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg4] 點<PowerIconKeywords:力量>。本回合每打出 1 張<ErosionColorInkKeywords:認知錯亂>卡牌就使「繪者」降低 [Arg3] 點<PowerIconKeywords:臨時力量>。"
  },
  Skill_99116_Name = {
    Text = "真實，亦是幻想"
  },
  Skill_99117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害 [AttackTimes:Arg2] 次，獲得 [Arg5] 點<PowerIconKeywords:力量>。切換到該意圖時，玩家每持有 1 張<ErosionColorInkKeywords:認知錯亂>卡牌就使「繪者」獲得 [Arg3] 點<PowerIconKeywords:力量>。本回合每打出 1 張<ErosionColorInkKeywords:認知錯亂>卡牌就使「繪者」降低 [Arg4] 點<PowerIconKeywords:臨時力量>。"
  },
  Skill_99117_Name = {
    Text = "藝術，即為瘋狂"
  },
  Skill_99118_Desc = {
    Text = "施加 [Arg1] 回合<VulnerabilityIconKeywords:易傷>，召喚 1 個「融蝕-追隨者」與「融蝕-渴求者」。"
  },
  Skill_99118_Name = {
    Text = "繪影摹形"
  },
  Skill_99119_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，對玩家抽牌堆和棄牌堆中 [Arg2] 張牌施加<ErosionColorInkKeywords:認知錯亂>。消耗所有<DecayDye:幻世染料>，每消耗 1 層傷害次數和<ErosionColorInkKeywords:認知錯亂> 數提高 1。"
  },
  Skill_99119_Name = {
    Text = "蝕骨色彩"
  },
  Skill_99120_Desc = {
    Text = "施加 [Arg1] 回合<VulnerabilityIconKeywords:易傷>和<WeaknessIconKeywords:虛弱>，召喚 1 個「融蝕-詩中人」。"
  },
  Skill_99120_Name = {
    Text = "繪影摹形"
  },
  Skill_99121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 點傷害，對玩家抽牌堆和棄牌堆中 [Arg2] 張牌施加<ErosionColorInkKeywords:認知錯亂>。消耗所有<DecayDye:幻世染料>，每消耗 1 層傷害次數和<ErosionColorInkKeywords:認知錯亂> 數提高 1。"
  },
  Skill_99121_Name = {
    Text = "蝕骨色彩"
  }
})
return Text_Skill
