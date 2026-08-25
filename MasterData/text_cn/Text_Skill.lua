__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Skill = readonly({
  Skill_100224_Desc = {
    Text = "回合结束时回复 [Arg1] 生命。"
  },
  Skill_100224_Name = {
    Text = "创构的「恩赐之血」"
  },
  Skill_100225_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  Skill_100225_Name = {
    Text = "创构的「春之祭」"
  },
  Skill_100226_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  Skill_100226_Name = {
    Text = "创构的「锈蚀钢锯」"
  },
  Skill_100227_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  Skill_100227_Name = {
    Text = "创构的「染血鹅卵石」"
  },
  Skill_100228_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  Skill_100228_Name = {
    Text = "创构的「缠丝玛瑙」"
  },
  Skill_100229_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  Skill_100229_Name = {
    Text = "创构的「重锁」"
  },
  Skill_100230_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  Skill_100230_Name = {
    Text = "创构的「重锁」"
  },
  Skill_100231_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 点狂气。"
  },
  Skill_100231_Name = {
    Text = "创构的「金色梦乡」"
  },
  Skill_100232_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  Skill_100232_Name = {
    Text = "创构的「春之祭」"
  },
  Skill_100233_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  Skill_100233_Name = {
    Text = "创构的「锈蚀钢锯」"
  },
  Skill_100234_Desc = {
    Text = "回合结束时回复 [Arg1] 生命。"
  },
  Skill_100234_Name = {
    Text = "创构的「恩赐之血」"
  },
  Skill_100235_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  Skill_100235_Name = {
    Text = "创构的「缠丝玛瑙」"
  },
  Skill_100236_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  Skill_100236_Name = {
    Text = "创构的「恶童」"
  },
  Skill_100237_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  Skill_100237_Name = {
    Text = "创构的「恶童」"
  },
  Skill_100238_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  Skill_100238_Name = {
    Text = "创构的「染血鹅卵石」"
  },
  Skill_100239_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 点狂气。"
  },
  Skill_100239_Name = {
    Text = "创构的「金色梦乡」"
  },
  Skill_100304_Desc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气，将 1 张 <DerivativeCardKeywords_4:「灵感」>洗入抽牌堆。若皮克曼在队伍中，使其获得 1 层「<Chuangyi:创意>」。"
  },
  Skill_100304_Name = {
    Text = "虚世之彩"
  },
  Skill_100467_Desc = {
    Text = "10层创意"
  },
  Skill_100467_Name = {
    Text = "10层创意"
  },
  Skill_100598_Desc = {
    Text = "获得 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>，[Arg2] 层<Undercurrent:暗流>， 2 条临时触腕。"
  },
  Skill_100598_Name = {
    Text = "深邃暗流"
  },
  Skill_100599_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，目标每有 1 层<IntoxicationIconKeywords:中毒>提高 1 点伤害。施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_100599_Name = {
    Text = "狂热之海"
  },
  Skill_100600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，目标每有 1 层<IntoxicationIconKeywords:中毒>提高 1 点伤害。施加 1 层 「<FlickeringCandle:微弱烛光>」。"
  },
  Skill_100600_Name = {
    Text = "狂热之海"
  },
  Skill_100601_Desc = {
    Text = "将敌方的「<FlickeringCandle:微弱烛光>」升级为等量「<LightOfTheLost:迷航之光>」，获得 3 条触腕上限。"
  },
  Skill_100601_Name = {
    Text = "湮塞的执念"
  },
  Skill_100602_Desc = {
    Text = "切换到该意图时生成 1 倍的临时触腕，<TentacleInjurieIconKeywords:触腕伤害>临时降低 50%。获得 <Block:[Block:Arg1]> 点护盾并免疫 1 回合负面状态。"
  },
  Skill_100602_Name = {
    Text = "遗失的久远之城"
  },
  Skill_100603_Desc = {
    Text = "切换到该意图时生成 1 倍的临时触腕，<TentacleInjurieIconKeywords:触腕伤害>临时降低 50%。获得 <Block:[Block:Arg1]> 点护盾并免疫 1 回合负面状态。"
  },
  Skill_100603_Name = {
    Text = "遗失的久远之城"
  },
  Skill_100604_Desc = {
    Text = "获得 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>，[Arg2] 层<Undercurrent:暗流>， 2 条临时触腕。"
  },
  Skill_100604_Name = {
    Text = "深邃暗流"
  },
  Skill_116332_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和等同于当前护盾 10％ 的临时<PowerIconKeywords:力量>。"
  },
  Skill_116332_Name = {
    Text = "美梦一刹"
  },
  Skill_116513_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> +[Arg1]。对方<PVPCapKeywords:算力上限> +[Arg2]。"
  },
  Skill_116513_Name_1 = {
    Text = "美梦一刹"
  },
  Skill_116513_UnknownName = {
    Text = "美梦一刹"
  },
  Skill_117171_Desc_1 = {
    Text = "触发全体敌方的<PVPCorrosionKeywords:罪印>，回复等量伤害的生命。"
  },
  Skill_117171_Name_1 = {
    Text = "光明之路"
  },
  Skill_117172_Desc_1 = {
    Text = "将 <PVPDerivativeCardKeywords_18:「苦痛根源·知」>、<PVPDerivativeCardKeywords_19:「灵魂枷锁·惑」>、<PVPDerivativeCardKeywords_20:「毁灭信仰·执」> 各 1 张置入手牌。"
  },
  Skill_117172_Name_1 = {
    Text = "无罪的圣裁"
  },
  Skill_117173_Desc_1 = {
    Text = "驱散一名敌方的正面状态，对其造成 <Damage:[Damage:Arg1]> 伤害，<PVPEntanglementKeywords:缠绕>。触发全体敌方的<PVPCorrosionKeywords:罪印>，损失 <Damage:[Arg2]> 生命。"
  },
  Skill_117173_Name_1 = {
    Text = "毁灭信仰·执"
  },
  Skill_117174_Desc_1 = {
    Text = "施加 <Damage:[Damage:Arg1]> <PVPCorrosionKeywords:罪印>，损失 <Damage:[Arg2]> 生命，"
  },
  Skill_117174_Name_1 = {
    Text = "亵渎圣心"
  },
  Skill_117175_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易伤>并<PVPWeaknessKeywords:虚弱>目标，对其造成 <Damage:[Damage:Arg1]> 伤害。触发全体敌方的<PVPCorrosionKeywords:罪印>，损失 <Damage:[Arg2]> 生命。"
  },
  Skill_117175_Name_1 = {
    Text = "灵魂枷锁·惑"
  },
  Skill_117176_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_117176_Name_1 = {Text = "打击"},
  Skill_117177_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方施加 [Arg1] <PVPCorrosionKeywords:罪印>并造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_117177_Name_1 = {
    Text = "无妄皈依"
  },
  Skill_117178_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>，<PVPMethysisKeywords:中毒>。触发全体敌方的<PVPCorrosionKeywords:罪印>，损失 <Damage:[Arg2]> 生命。"
  },
  Skill_117178_Name_1 = {
    Text = "苦痛根源·知"
  },
  Skill_117207_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」前和回合结束时，对<HPAndShieldMax:生命与护盾最高>的敌方施加 <Damage:[Damage:Arg1]> 层<PVPCorrosionKeywords:罪印>。"
  },
  Skill_117207_Name_1 = {
    Text = "扭曲的骑士诗"
  },
  Skill_117208_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，对狂气最高的敌方造成 [Arg1] <PVPfengsuoKeywords:爆发封锁>。"
  },
  Skill_117208_Name_1 = {
    Text = "圣子尊容"
  },
  Skill_117272_Desc = {
    Text = "弃掉所有手牌并抽 5 张牌，将「循环的倒影」置入手牌堆、抽牌堆、弃牌堆。"
  },
  Skill_117272_Name = {
    Text = "久远的幻梦"
  },
  Skill_117274_Desc = {
    Text = "<FaxianKeywords:发现> 3 张「追忆效果」，选择 1 张将其释放，获得 <Posse:[Arg1]> 点银钥能量，随机将 1 张被消耗的具有「渊海回声」刻印的卡牌洗入弃牌堆。<RippleKeywords:余波>：所有唤醒体获得 5 点狂气。"
  },
  Skill_117274_Name = {
    Text = "循环的倒影"
  },
  Skill_117275_Desc = {
    Text = "<FaxianKeywords:发现> 3 张「追忆效果」，选择 1 张将其释放。<RippleKeywords:余波>：所有唤醒体获得 5 点狂气。"
  },
  Skill_117275_Name = {
    Text = "循环的倒影"
  },
  Skill_117276_BattleDesc = {
    Text = "弃掉所有手牌并抽 5 张牌，将「循环的倒影」置入手牌堆、抽牌堆、弃牌堆。可使用 [Arg1] 次。"
  },
  Skill_117276_Desc = {
    Text = "弃掉所有手牌并抽 5 张牌，将「循环的倒影」置入手牌堆、抽牌堆、弃牌堆。可使用 3 次。"
  },
  Skill_117276_Name = {
    Text = "久远的幻梦"
  },
  Skill_117277_Desc = {
    Text = "从手牌中选择 1 张非衍生指令卡，使其本场战斗造成的伤害、护盾、生命回复提高 [Arg1]％，直到下次打出前算力消耗变为 0。"
  },
  Skill_117277_Name = {
    Text = "未完的蜡像"
  },
  Skill_117278_Desc = {
    Text = "<FaxianKeywords:发现> 3 张「追忆效果」，选择 1 张将其释放，获得 <Posse:[Arg1]> 点银钥能量。<RippleKeywords:余波>：所有唤醒体获得 5 点狂气。"
  },
  Skill_117278_Name = {
    Text = "循环的倒影"
  },
  Skill_117301_Desc = {
    Text = "从手牌中选择 1 张非衍生指令卡，将其 3 张具有<DepleteIconKeywords:消耗>的原始复制洗入抽牌堆。这些卡牌直到下次打出前，算力消耗降低 1。"
  },
  Skill_117301_Name = {
    Text = "丰穰之核"
  },
  Skill_117302_Desc_1 = {
    Text = "抽 [Arg1] 张算力消耗最高的「技能」，使其获得<PrepareKeywords:预备2>。"
  },
  Skill_117302_Name_1 = {
    Text = "泣血的圣心"
  },
  Skill_117302_UnknownName = {
    Text = "泣血的圣心"
  },
  Skill_117312_AwakerSkillBackgroundStory = {
    Text = "于丽埃特曾说，世界是污浊的，教会的使命就是将世间的罪孽洗净。\n他是神所选中的圣子，他已经过重重考验，拥有神圣的心灵。 \n只消几句无声的祷告，便可使虔诚的信徒感激涕零。 \n将那心灵如灯芯一般燃烧吧，赐下祂的恩惠，那光芒的照耀下，必将带来纯洁的福祉。"
  },
  Skill_117312_Desc = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，抽 2 张算力消耗最低的指令卡。"
  },
  Skill_117312_EffectNameList = {Text = "伤害"},
  Skill_117312_Name = {
    Text = "明灯灼魂"
  },
  Skill_117312_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_117313_AwakerSkillBackgroundStory = {
    Text = "他赐下的福祉，同样是漆黑的毒汁。"
  },
  Skill_117313_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_117313_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。波吕克斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_117313_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_117313_Name = {Text = "打击"},
  Skill_117313_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_117314_AwakerSkillBackgroundStory = {
    Text = "他们是有罪的，那流淌的黑色神血就是证明。\n他们应受审判，只有洗清罪孽才可得入净土。\n裁决吧，宣告他们的罪，放出他们的血，将判罚降临在他们的头上。\n这是圣子的权能与职责。"
  },
  Skill_117314_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，进入超维回合时会自动被抽出。"
  },
  Skill_117314_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，每打出 1 张「圣心」下次打出时算力消耗-1，进入超维回合时会自动被抽出。"
  },
  Skill_117314_EffectNameList = {Text = "伤害"},
  Skill_117314_Name = {
    Text = "离垢的审判"
  },
  Skill_117314_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_117315_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果 ([Arg2]/3)。"
  },
  Skill_117315_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果。"
  },
  Skill_117315_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次。"
  },
  Skill_117315_Name = {Text = "圣心"},
  Skill_117315_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg3]％ 出血，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_4 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg3]％ 出血，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117315_tempBattleDesc_5 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg3]％ 出血，获得 3 层<ZuiyinKeywords:罪印>。打出后将此卡牌洗入抽牌堆顶部，本回合算力消耗变为 0 且施加 100％ 伤害的<BleedingIconKeywords:出血>。第 3 次打出时<DepleteIconKeywords:消耗>并使自身下张指令卡享受「苦痛救赎」效果且生效 2 次([Arg2]/3)。"
  },
  Skill_117316_AwakerSkillBackgroundStory = {
    Text = "这颗光明的心将为他抵挡一切罪恶。"
  },
  Skill_117316_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_117316_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。波吕克斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_117316_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_117316_Name = {Text = "防御"},
  Skill_117316_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_117317_AwakerSkillBackgroundStory = {
    Text = "「波吕克斯，你的圣心代行着持灯者的光辉，你要如敬爱祂一样珍重这份荣耀。」 \n于是他将那份虚无的冠冕戴在头上，不敢懈怠。 \n「波吕克斯，不要害怕，你要去尝尝自由是什么味道……」 \n他因这荣耀获得了一切，又因这荣耀失去了一切，于是他发觉这冠冕不过是无形的镣铐。 \n他撕毁了冠冕，那颗空虚的心脏第一次发出了亮如白昼的光芒，只是那些愤怒的哀鸣再也无法传达到另一个人的耳畔。"
  },
  Skill_117317_Desc = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，使自身本回合下张指令卡享受「苦痛救赎」效果。将 1 张<DerivativeCardKeywords_118:「圣心」>置入手中。"
  },
  Skill_117317_EffectNameList = {Text = "伤害"},
  Skill_117317_Name = {
    Text = "无罪的圣裁"
  },
  Skill_117317_OverLimitUtlSkillDesc = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，使自身本回合下张指令卡享受「苦痛救赎」效果。将 2 张<DerivativeCardKeywords_118:「圣心」>置入手中。本回合内波吕克斯每张指令卡额外享受 50% 「苦痛救赎」效果，自身下一张指令卡额外生效 1 次。"
  },
  Skill_117317_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_117318_AwakerSkillBackgroundStory = {
    Text = "过去他的双眼被蒙上阴翳，于是他视那黑暗的如同白昼。 \n如今他已重见世界的真貌，于是他转身踏向相反的道路。 \n无论何时，他总在向光明前进。"
  },
  Skill_117318_Desc_0 = {
    Text = "波吕克斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：打出时和弃牌阶段后获得 3 层<ZuiyinKeywords:罪印>，每有 1 张手牌额外获得 1 层<ZuiyinKeywords:罪印>。「圣心」造成 100% 伤害的出血。"
  },
  Skill_117318_Desc_15 = {
    Text = "波吕克斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：打出时和弃牌阶段后获得 3 层<ZuiyinKeywords:罪印>，每有 1 张手牌额外获得 1 层<ZuiyinKeywords:罪印>。「圣心」造成 100% 伤害的出血，因打出而洗入抽牌堆后，该「圣心」本回合算力消耗变为 0 且施加 100％ 伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_117318_EffectNameList = {Text = "狂气"},
  Skill_117318_Name = {
    Text = "净世之路"
  },
  Skill_117318_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_117494_Desc_1 = {
    Text = "移除狂气"
  },
  Skill_117494_Name_1 = {
    Text = "移除狂气"
  },
  Skill_117740_Desc_1 = {
    Text = "施加 <Damage:[Damage:Arg1]> <PVPCorrosionKeywords:罪印>。"
  },
  Skill_117740_Name_1 = {
    Text = "罪印测试"
  },
  Skill_117757_Desc = {
    Text = "抽 1 张牌并使其算力消耗-1，若抽到指令卡则使其拥有者获得 [Arg1]％ 临时暴击伤害。若波吕克斯在队伍中，获得 [Arg2] 层<ZuiyinKeywords:罪印>。"
  },
  Skill_117757_Name = {
    Text = "泣血的圣心"
  },
  Skill_117861_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量<BleedingIconKeywords:出血>和伤害 10%的<IntoxicationColour:中毒>。"
  },
  Skill_117861_Name = {
    Text = "污秽血祭"
  },
  Skill_117862_Desc = {
    Text = "施加 [Arg1] 层<SacrificeKeyWord:献祭>和 1 层<EmptinessKeywords: 空虚>。"
  },
  Skill_117862_Name = {
    Text = "深渊祝告"
  },
  Skill_117863_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_117863_Name = {Text = "挥击"},
  Skill_118055_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，若造成了未被格挡的伤害则获得 [Arg3] 层「互助契约：深海分殖体」。"
  },
  Skill_118055_Name = {
    Text = "提灯明照"
  },
  Skill_118056_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 1 层<HeavyInjuryKeywords:重创>，玩家每拥有 1 点护盾使本次伤害降低 1 点。"
  },
  Skill_118056_Name = {
    Text = "灵智污染"
  },
  Skill_118057_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，重创 [Arg3] 回合，玩家每拥有 1 点护盾使本次伤害降低 1 点。"
  },
  Skill_118057_Name = {
    Text = "重创刺骨"
  },
  Skill_118058_Desc = {
    Text = "切换到该意图时获得 1 层<Flaw:破绽>。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对敌方施加 [Arg3] 层<BirthRitual:降生仪式>，每有 1 层<FatePact:命契>提高 1 层。"
  },
  Skill_118058_Name = {
    Text = "万劫轮回的天幕"
  },
  Skill_118059_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<RetaliateIconKeywords:临时反击>，玩家每剩余 1 张手牌，提高 [Arg4] 层<RetaliateIconKeywords:临时反击>。"
  },
  Skill_118059_Name = {
    Text = "怨毒复仇"
  },
  Skill_118060_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次（每 2 条触腕使伤害次数提高 1）。造成 [Arg3] 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，驱散自身负面状态。"
  },
  Skill_118060_Name = {
    Text = "螺湮逆流"
  },
  Skill_118061_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。直到回合结束前，玩家每拥有 1 张手牌，攻击次数就减少 1，最低为 3。"
  },
  Skill_118061_Name = {
    Text = "群蛇噬魂"
  },
  Skill_118062_Desc = {
    Text = "在前排召唤 1 个「利莫里亚唤醒体」。"
  },
  Skill_118062_Name = {
    Text = "应选之人"
  },
  Skill_118063_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张<DerivativeCardKeywords_3:「惊厥」>洗入抽牌堆。"
  },
  Skill_118063_Name = {
    Text = "无上生祭"
  },
  Skill_118064_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，立刻获得 [Arg3] 层「互助契约：深海分殖体」。"
  },
  Skill_118064_Name = {
    Text = "明照「信仰萃聚」"
  },
  Skill_118065_Desc = {
    Text = "切换至该意图时，获得等同于当前触腕条数的临时触腕。获得 <Block:[Block:Arg1]> 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_118065_Name = {
    Text = "自由誓愿"
  },
  Skill_118066_Desc = {
    Text = "使「呼唤」获得额外效果：达到 5 层后，立即封印所有唤醒体。"
  },
  Skill_118066_Name = {Text = "觉醒"},
  Skill_118068_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_118068_Name = {Text = "噬咬"},
  Skill_118070_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每次造成未被格挡的伤害时，依次施加 1 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<Decay:腐朽>。"
  },
  Skill_118070_Name = {
    Text = "乐园重启"
  },
  Skill_118071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加 1 层<Decay:腐朽>。在回合开始时，选择 1 枚「圣象赐福」，将其反转为「诅咒」。"
  },
  Skill_118071_Name = {
    Text = "「帷幕呈露」"
  },
  Skill_118072_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [TentaclePower:Arg3] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_118072_Name = {Text = "打击"},
  Skill_118074_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾、 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>和 [Arg3] 层<Undercurrent:暗流>。"
  },
  Skill_118074_Name = {
    Text = "触足壁垒"
  },
  Skill_118076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<Decay:腐朽>。"
  },
  Skill_118076_Name = {
    Text = "触腕捕食"
  },
  Skill_118077_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，若造成了未被格挡的伤害则获得 [Arg3] 层「互助契约：深海分殖体」。"
  },
  Skill_118077_Name = {
    Text = "提灯明照"
  },
  Skill_118078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，封印狂气最高的唤醒体 1 回合。"
  },
  Skill_118078_Name = {
    Text = "神眷之刃"
  },
  Skill_118080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，弃掉玩家所有保留的手牌，每次造成未被格挡的伤害时，将 [Arg3] 张<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆顶部。"
  },
  Skill_118080_Name = {Text = "绞杀"},
  Skill_118083_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg2] 次 ，额外造成玩家当前生命 50% 的伤害（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 层<Decay:腐朽>。"
  },
  Skill_118083_Name = {
    Text = "腐骨重击"
  },
  Skill_118084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾，每层「呼唤」使护盾提高 <Block:[Block:Arg4]> 点。"
  },
  Skill_118084_Name = {Text = "试探"},
  Skill_118086_Desc = {
    Text = "切换到该意图时获得 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>。若目标生命低于 50%，施加 [Arg2] 层<Decay:腐朽>，否则施加 [Arg3] 层 <WeaknessIconKeywords:虚弱>。"
  },
  Skill_118086_Name = {
    Text = "乞灵之咒"
  },
  Skill_118087_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾、 [Arg2] 层 <SacrificeKeyWord:献祭>和 [TentaclePower:Arg3] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_118087_Name = {
    Text = "圣女作成"
  },
  Skill_118090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每造成 1 次伤害，生成 1 条临时触腕。直到回合结束前，玩家每拥有 1 张手牌，攻击次数就减少 1，最低为 3。"
  },
  Skill_118090_Name = {
    Text = "狂蛇乱舞"
  },
  Skill_118091_Desc = {
    Text = "获得 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>，触腕上限提高 1。自身获得 [Arg2] 层<SacrificeKeyWord:献祭>。"
  },
  Skill_118091_Name = {
    Text = "深海圣咏"
  },
  Skill_118092_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<ResentChainsKeywords:怨恨锁链>。每失去 1 层<Abyssallock:梦境桎梏>使获得的<ResentChainsKeywords:怨恨锁链>提高 1 ，伤害提高  <Damage:[Damage:Arg4]>  点。"
  },
  Skill_118092_Name = {
    Text = "永世牢笼"
  },
  Skill_118093_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，为抽牌堆和弃牌堆 [Arg3] 张随机卡牌附加<SeastriderCurse:蹈海者咒怨>。"
  },
  Skill_118093_Name = {
    Text = "提灯明照"
  },
  Skill_118094_Desc = {
    Text = "获得 [Arg1] 层「血誓」和 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_118094_Name = {
    Text = "燃已灯芯"
  },
  Skill_118095_Desc = {
    Text = "切换至该意图时，获得等同于当前触腕条数的临时触腕。获得 <Block:[Block:Arg1]> 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_118095_Name = {
    Text = "虚妄继承者"
  },
  Skill_118096_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 [Arg3]  层<HeavyInjuryKeywords:重创>，玩家每拥有 1 点护盾使本次伤害降低 1 点。"
  },
  Skill_118096_Name = {
    Text = "罪孽鞭挞"
  },
  Skill_118097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。切换到该意图时获得 [Arg3] 层临时的<Abyssallock2:梦境桎梏>。回合结束时每有 1 张<SlowIconKeywords:迟缓>手牌在手中，额外造成 1 次伤害。"
  },
  Skill_118097_Name = {
    Text = "「无忧净土」"
  },
  Skill_118099_Desc = {
    Text = "获得 [Arg1] 层「血誓」和 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_118099_Name = {
    Text = "燃已灯芯"
  },
  Skill_118100_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<Decay:腐朽>。"
  },
  Skill_118100_Name = {
    Text = "触腕捕食"
  },
  Skill_118101_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg2] 次 ，额外造成玩家当前生命 25% 的伤害（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 层<Decay:腐朽>。"
  },
  Skill_118101_Name = {
    Text = "腐骨重击"
  },
  Skill_118102_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每有 2 层「血誓」，获得 1 条临时触腕。"
  },
  Skill_118102_Name = {
    Text = "深海助祭"
  },
  Skill_118103_Desc = {
    Text = "获得 [Arg1] 层「血誓」和 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_118103_Name = {
    Text = "燃已灯芯"
  },
  Skill_118104_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，「封印」所有唤醒体 1 回合。获得 2 层<MutualAid1:互助契约：利莫里亚>。"
  },
  Skill_118104_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_118105_Desc = {
    Text = "对敌方施加 [Arg1] 层<BirthRitual:降生仪式>，获得 [Arg2] 层<FatePact:命契>，对自身施加 1 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_118105_Name = {
    Text = "螺湮圆舞"
  },
  Skill_118106_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3]  条触腕上限并生成 [Arg3] 条触腕 、获得 [TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>。附加 [Arg5] 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>、<HeavyInjuryKeywords:重创>。"
  },
  Skill_118106_Name = {
    Text = "「神国幻象」"
  },
  Skill_118107_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每有 2 层「血誓」，获得 1 条临时触腕。"
  },
  Skill_118107_Name = {
    Text = "罪孽鞭挞"
  },
  Skill_118108_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<RetaliateIconKeywords:临时反击>，玩家每剩余 1 张手牌，提高 [Arg4] 层<RetaliateIconKeywords:临时反击>。"
  },
  Skill_118108_Name = {
    Text = "怨毒复仇"
  },
  Skill_118109_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<IntoxicationIconKeywords:中毒>，敌方生命越低伤害越高，最大为  <Damage:[Damage:Arg4]>  点伤害。"
  },
  Skill_118109_Name = {
    Text = "蓝环毒素"
  },
  Skill_118648_Desc = {
    Text = "施加 [Arg2] 层<IntoxicationIconKeywords:中毒>。若仍然有其他敌人存在，牺牲自身进行寄生，并附加「被寄生」状态。"
  },
  Skill_118648_Name = {Text = "寄生"},
  Skill_118767_Desc = {
    Text = "造成 <Damage:[Damage:Arg3]> 点<PunctureDamagewords:穿刺伤害> [AttackTimes:Arg2] 次 ，额外造成玩家当前生命 50% 的<PunctureDamagewords:穿刺伤害>（<Damage:[Damage:Arg4]> ）。施加等量<BleedingIconKeywords:出血>和 [Arg5] 层<Decay:腐朽>。"
  },
  Skill_118767_Name = {
    Text = "腐骨「<PunctureDamagewords:穿刺>」"
  },
  Skill_118929_Desc = {
    Text = "生成 2 条触腕，触腕上限提高 2。"
  },
  Skill_118929_Name = {
    Text = "受造之物"
  },
  Skill_118974_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次（每 2 条触腕使伤害次数提高 1）。造成 [Arg3] 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，驱散自身负面状态。"
  },
  Skill_118974_Name = {
    Text = "螺湮逆流"
  },
  Skill_118975_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾、 [Arg2] 层 <SacrificeKeyWord:献祭>和 [TentaclePower:Arg3] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_118975_Name = {
    Text = "圣女作成"
  },
  Skill_119040_Desc_1 = {
    Text = "将 [Arg1] 张随机友方的「打击」洗入抽牌堆，抽 [Arg2] 张「打击」。"
  },
  Skill_119040_Name_1 = {
    Text = "来自雾境"
  },
  Skill_119040_UnknownName = {
    Text = "来自雾境"
  },
  Skill_119041_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：全体友方「打击」伤害提高 [Arg1]%。"
  },
  Skill_119041_Name_1 = {
    Text = "理智明灯"
  },
  Skill_119042_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]%，任意友方打出「打击」后抽 [Arg3] 张牌，每回合最多触发 [Arg2] 次。"
  },
  Skill_119042_Name_1 = {
    Text = "狂戮至世界尽头"
  },
  Skill_119043_Desc_1 = {
    Text = "造成合计 [Arg1] <PVPSacrificeKeyWords:献祭>，平均分配给所有敌方。"
  },
  Skill_119043_Name_1 = {Text = "偏航船"},
  Skill_119043_UnknownName = {Text = "偏航船"},
  Skill_119044_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，对最少献祭的敌方施加 [Arg1] <PVPSacrificeKeyWords:献祭>，重复 [Arg2] 次。全体友方不再受到<PVPCapKeywords:算力上限>减少效果影响。"
  },
  Skill_119044_Name_1 = {
    Text = "黑暗中的安眠"
  },
  Skill_119045_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使全体敌方本回合受到主动伤害后获得伤害 [Arg1]% 的<PVPSacrificeKeyWords:献祭>。"
  },
  Skill_119045_Name_1 = {
    Text = "蓝环毒素"
  },
  Skill_119088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合 <WeaknessIconKeywords:虚弱>并获得 <Block:[Block:Arg3]>  点护盾。每层「呼唤」使护盾提高 <Block:[Block:Arg4]> 点。"
  },
  Skill_119088_Name = {Text = "试探"},
  Skill_119089_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，「封印」狂气最高的唤醒体 1 回合，并使其在牌堆中的随机 [Arg3] 张技能卡获得 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_119089_Name = {
    Text = "神眷之刃"
  },
  Skill_119090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机症状卡洗入抽牌堆。"
  },
  Skill_119090_Name = {
    Text = "无上生祭"
  },
  Skill_119091_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，「封印」所有唤醒体 1 回合。获得 2 层<MutualAid1:互助契约：利莫里亚>。"
  },
  Skill_119091_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_119092_Desc = {
    Text = "回复 10% 已损失生命，每层「呼唤」都会使回复量提高 20%。在前排召唤 1 个「利莫里亚唤醒体」。"
  },
  Skill_119092_Name = {
    Text = "应选之人"
  },
  Skill_119110_Desc = {
    Text = "施加 [Arg1] 层<SacrificeKeyWord:献祭>。回合开始时获得 [Arg2] 层<FatePact:命契>。"
  },
  Skill_119110_Name = {
    Text = "命运之槛"
  },
  Skill_119113_Desc_1 = {
    Text = "<StrengthenKeywords:强化>自身并获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_119113_Name_1 = {
    Text = "逆境狂意"
  },
  Skill_119114_BattleDesc_1 = {
    Text = "驱散自身的负面状态，对全体敌方造成 [Arg2] 次 <Damage:[Damage:Arg1]> 伤害，每有 1 个死亡友方额外造成 1 次伤害。"
  },
  Skill_119114_Desc_1 = {
    Text = "驱散自身的负面状态，对全体敌方造成 1 次 <Damage:[Damage:Arg1]> 伤害，每有 1 个死亡友方额外造成 1 次伤害。"
  },
  Skill_119114_Name_1 = {
    Text = "闪耀☆龙卷风"
  },
  Skill_119115_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。每打出 1 张「打击」算力消耗 -1。"
  },
  Skill_119115_Name_1 = {
    Text = "毁灭撕裂"
  },
  Skill_119116_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_119116_Name_1 = {Text = "打击"},
  Skill_119118_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，触发等量<PVPBleedingKeywords:出血>，同时视为「打击」。"
  },
  Skill_119118_Name_1 = {
    Text = "破雾强袭"
  },
  Skill_119313_Desc = {
    Text = "获得额外的 3 枚生命条，最大生命提高 250%，获得最大生命 10% 的「旧日余烬」。 获得 5 条触腕上限和「触腕集结」。"
  },
  Skill_119313_Name = {
    Text = "海域轮回"
  },
  Skill_119334_BattleDesc = {
    Text = "获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119334_Desc = {
    Text = "获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119334_Name = {
    Text = "幻想祭仪"
  },
  Skill_119335_BattleDesc = {
    Text = "仪式目标：打出 4 张防御。\n仪式奖励：回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119335_Desc = {
    Text = "仪式目标：打出 4 张防御。\n仪式奖励：回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119335_Name = {
    Text = "天真祭仪"
  },
  Skill_119336_BattleDesc = {
    Text = "仪式目标：释放 4 次狂气爆发([Arg1]/4)。\n仪式奖励：所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119336_Desc = {
    Text = "仪式目标：释放 4 次狂气爆发。\n仪式奖励：所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119336_Name = {
    Text = "自由祭仪"
  },
  Skill_119337_BattleDesc = {
    Text = "仪式目标：释放 4 次狂气爆发。\n仪式奖励：所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119337_Desc = {
    Text = "仪式目标：释放 4 次狂气爆发。\n仪式奖励：所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119337_Name = {
    Text = "自由祭仪"
  },
  Skill_119338_BattleDesc = {
    Text = "回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119338_Desc = {
    Text = "回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119338_Name = {
    Text = "天真祭仪"
  },
  Skill_119339_BattleDesc = {
    Text = "仪式目标：释放 3 次钥令([Arg1]/3)。\n仪式奖励：获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119339_Desc = {
    Text = "仪式目标：释放 3 次钥令。\n仪式奖励：获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119339_Name = {
    Text = "幻想祭仪"
  },
  Skill_119340_BattleDesc = {
    Text = "所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119340_Desc = {
    Text = "所有唤醒体获得 <Energy:30> 点狂气。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119340_Name = {
    Text = "自由祭仪"
  },
  Skill_119341_BattleDesc = {
    Text = "仪式目标：打出 4 张防御([Arg1]/4)。\n仪式奖励：回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119341_Desc = {
    Text = "仪式目标：打出 4 张防御。\n仪式奖励：回复 50% 已损失生命。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命的 <SacrificeKeyWord:献祭>。"
  },
  Skill_119341_Name = {
    Text = "天真祭仪"
  },
  Skill_119342_Desc = {
    Text = "选择一项献祭仪式，每种仪式限一次。"
  },
  Skill_119342_Name = {
    Text = "敬献神明"
  },
  Skill_119343_BattleDesc = {
    Text = "仪式目标：释放 3 次钥令。\n仪式奖励：获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119343_Desc = {
    Text = "仪式目标：释放 3 次钥令。\n仪式奖励：获得 2000 点银钥能量。清空自身所有 <SacrificeKeyWord:献祭>，并对全体敌方施加 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_119343_Name = {
    Text = "幻想祭仪"
  },
  Skill_119574_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」前、「技能」前、「狂气爆发」前临时<StrongEffectKeywords:强效> +[Arg1]，每回合各效果仅能触发一次。"
  },
  Skill_119574_Name_1 = {
    Text = "你我终将重逢"
  },
  Skill_119712_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_122:圣像赐福：智识之梦>」，所有唤醒体立刻失去 50% 狂气，所有唤醒体造成的狂气降低 50%。"
  },
  Skill_119712_Desc = {
    Text = "失去「<DerivativeCardKeywords_122:圣像赐福：智识之梦>」，所有唤醒体立刻失去 50% 狂气，所有唤醒体造成的狂气降低 50%。"
  },
  Skill_119712_Name = {
    Text = "圣像诅咒：痴愚之叹"
  },
  Skill_119713_BattleDesc = {
    Text = "打出后本回合不受「圣象诅咒」效果影响并免疫所有伤害，敌人的「旧日余烬」效果永久翻倍。"
  },
  Skill_119713_Desc = {
    Text = "打出后本回合不受「圣像诅咒」效果影响并免疫所有伤害，敌人的「旧日余烬」效果永久翻倍。"
  },
  Skill_119713_Name = {
    Text = "银钥，必会指引前路"
  },
  Skill_119714_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3]  条触腕上限并生成 [Arg3] 条触腕 、获得 [TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>。附加 [Arg5] 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>、<HeavyInjuryKeywords:重创>。"
  },
  Skill_119714_Name = {
    Text = "「神国幻象·终结」"
  },
  Skill_119715_BattleDesc = {
    Text = "每回合开始时获得最大生命的 5% 的<PowerIconKeywords:力量>，临时暴击率 +25%。"
  },
  Skill_119715_Desc = {
    Text = "每回合开始时获得最大生命的 5% 的<PowerIconKeywords:力量>，临时暴击率 +25%。"
  },
  Skill_119715_Name = {
    Text = "圣像赐福：威能之梦"
  },
  Skill_119716_BattleDesc = {
    Text = "每回合开始时回复已损失生命的 15%。"
  },
  Skill_119716_Desc = {
    Text = "每回合开始时回复已损失生命的 15%。"
  },
  Skill_119716_Name = {
    Text = "圣像赐福：永恒之梦"
  },
  Skill_119717_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_120:圣像赐福：永恒之梦>」，立刻失去 50% 当前生命，所有唤醒体生命回复降低 50%。"
  },
  Skill_119717_Desc = {
    Text = "失去「<DerivativeCardKeywords_120:圣像赐福：永恒之梦>」，立刻失去 50% 最大生命，所有唤醒体生命回复降低 50%。"
  },
  Skill_119717_Name = {
    Text = "圣像诅咒：破灭之恨"
  },
  Skill_119718_BattleDesc = {
    Text = "每回合开始时所有唤醒体获得 <Energy:10> 点狂气。"
  },
  Skill_119718_Desc = {
    Text = "每回合开始时所有唤醒体获得 <Energy:10> 点狂气。"
  },
  Skill_119718_Name = {
    Text = "圣像赐福：智识之梦"
  },
  Skill_119719_BattleDesc = {
    Text = "失去「<DerivativeCardKeywords_121:圣像赐福：威能之梦>」，立刻失去 50% 力量，所有唤醒体获得力量效果降低 50%。"
  },
  Skill_119719_Desc = {
    Text = "失去「<DerivativeCardKeywords_121:圣像赐福：威能之梦>」，立刻失去 50% 力量，所有唤醒体获得力量效果降低 50%。"
  },
  Skill_119719_Name = {
    Text = "圣像诅咒：衰亡之哀"
  },
  Skill_119762_AwakerSkillBackgroundStory = {
    Text = "神母的指示不容驳斥。"
  },
  Skill_119762_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_119762_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。抽 1 张「深海圣咏」，每回合最多生效 1 次( [Arg3]/1 )。"
  },
  Skill_119762_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。诞妄·墨菲获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_119762_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。诞妄·墨菲获得 <Energy:[Energy:Arg2]> 点狂气。抽 1 张「深海圣咏」，每回合最多生效 1 次。"
  },
  Skill_119762_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_119762_Name = {Text = "打击"},
  Skill_119762_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_119763_AwakerSkillBackgroundStory = {
    Text = "她是傲慢的。她用傲慢掩饰内心无法修补的空洞。\n她忘记了自己曾是什么人，她忘记了自己应该是什么人。\n万千蹈海信徒臣服于她的足下，而她则在声声尊崇中遗忘了最重要的事物——\n她已经臣服于这苍白的命运。"
  },
  Skill_119763_BattleDesc = {
    Text = "获得 2 点算力，抽 2 张牌。下回合开始时受到 [Arg3] 点<SacrificeKeyWord:献祭>。<RippleKeywords:余波>：移除 [Arg4] 点<SacrificeKeyWord:献祭>。"
  },
  Skill_119763_Desc = {
    Text = "获得 2 点算力，抽 2 张牌。下回合开始时受到最大生命 [Arg1]% 的<SacrificeKeyWord:献祭>。<RippleKeywords:余波>：移除最大生命 [Float:Arg2]％ 的<SacrificeKeyWord:献祭>。"
  },
  Skill_119763_EffectNameList = {
    Text = "移除献祭比例"
  },
  Skill_119763_Name = {
    Text = "深海圣咏"
  },
  Skill_119763_PropertyNameList = {
    Text = "$GrowValue1％"
  },
  Skill_119764_AwakerSkillBackgroundStory = {
    Text = "墨菲手中象牙雕像的来历众说纷纭。\n有人说那座雕像来源于墨菲指示下探索的深海遗址，也有人说那座雕像与圣婴一同自她胸口跃动的心脏降生。\n但毋庸置疑的是，这座象征着她与那座静默于无明海底的螺湮之城千丝万缕联系的雕像，是在墨菲成为「真正的神母」那天出现在蹈海者的视线中的。\n在那之后，信众们也见证了墨菲利用这座象牙雕像破开风浪，割开血海。\n绝对的权力，往往并非止于虚幻的象征。人性的膝盖，只会跪伏于绝对力量的权威下。"
  },
  Skill_119764_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，下回合开始时受到 [Arg7] 点<SacrificeKeyWord:献祭>。对所有敌人施加 [Arg3] 层<DwmofeiKeywords:降生仪式>，对生命最高敌方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 点伤害，享受 [Arg6]％ <TentacleInjurieIconKeywords:触腕伤害>加成。"
  },
  Skill_119764_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，下回合开始时受到最大生命 [Arg2]% 的<SacrificeKeyWord:献祭>。对所有敌人施加 [Arg3] 层<DwmofeiKeywords:降生仪式>，对生命最高敌方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 点伤害，享受 [Arg6]％ <TentacleInjurieIconKeywords:触腕伤害>加成。"
  },
  Skill_119764_EffectNameList = {
    Text = "护盾,降生仪式层数,伤害,触腕伤害加成"
  },
  Skill_119764_Name = {
    Text = "虚妄王女"
  },
  Skill_119764_OverLimitUtlSkillDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，下回合开始时受到 [Arg7] 点<SacrificeKeyWord:献祭>。对所有敌人施加 [Arg8] 层<DwmofeiKeywords:降生仪式>，对生命最高敌方造成 [Arg4] 次 <Damage:[Damage:Arg5]> 点伤害，享受 [Arg6]％ <TentacleInjurieIconKeywords:触腕伤害>加成。将 3 张算力消耗为 2 的「螺湮圆舞」置入手中并使其获得<DepleteIconKeywords:消耗>和<PrepareKeypvewords1:预备1>。"
  },
  Skill_119764_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3,$GrowValue4％"
  },
  Skill_119765_AwakerSkillBackgroundStory = {
    Text = "她是轻佻的。她用轻佻对抗残破不堪的现实。\n让我们跳舞吧，她说，跳一支敬献给神明的舞。\n感谢神明赐予我们倒错的因果，凌乱的过往，和不可捉摸的未来。\n聚光灯下，她是一切唯一的焦点。"
  },
  Skill_119765_BattleDesc = {
    Text = "获得 <Posse:[Arg7]> 点银钥能量。根据触腕姿态获得不同效果：「潮涌」：<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]，生成 1 条触腕。「静海」：获得 <Block:[Block:Arg2]> 点护盾，护盾保留 50％ 到下回合。「怒涛」：对生命最高敌方造成 [Arg3] 次 <Damage:[Damage:Arg4]> 点伤害，享受 [Arg5]％ <TentacleInjurieIconKeywords:触腕伤害>加成。"
  },
  Skill_119765_Desc = {
    Text = "获得 [Arg6]％ 银钥充能的银钥能量。根据触腕姿态获得不同效果：「潮涌」：<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg8]，生成 1 条触腕。「静海」：获得 <Block:[Block:Arg9]> 点护盾，护盾保留 50％ 到下回合。「怒涛」：对生命最高敌方造成 [Arg3] 次 <Damage:[Damage:Arg4]> 点伤害，享受 [Arg5]％ <TentacleInjurieIconKeywords:触腕伤害>加成。"
  },
  Skill_119765_EffectNameList = {
    Text = "触腕伤害,护盾,伤害,触腕伤害加成,银钥充能效率"
  },
  Skill_119765_Name = {
    Text = "螺湮圆舞"
  },
  Skill_119765_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,攻击力*GrowValue3,$GrowValue4％,$GrowValue5％"
  },
  Skill_119766_AwakerSkillBackgroundStory = {
    Text = "她将神的脐带血滴入海中。她向神祈求永不抵达终点的航路。\n只要梦的泡沫仍在延续，她就是唯一的神母。"
  },
  Skill_119766_Desc_0 = {
    Text = "诞妄·墨菲获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：诞妄·墨菲造成的伤害附加 [Arg2]％ <SacrificeKeyWord:献祭>。回合开始时，获得 1 层<MingqiKeywords:命契>。"
  },
  Skill_119766_Desc_15 = {
    Text = "诞妄·墨菲获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：诞妄·墨菲造成的伤害附加 [Arg2]％ <SacrificeKeyWord:献祭>。获得 2 层<MingqiKeywords:命契>。回合开始时，获得 1 层<MingqiKeywords:命契>。回合结束时，若处于「潮涌」姿态，额外获得 1 层<MingqiKeywords:命契>。"
  },
  Skill_119766_EffectNameList = {
    Text = "狂气,献祭比例"
  },
  Skill_119766_Name = {
    Text = "海祭典仪"
  },
  Skill_119766_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2%"
  },
  Skill_119767_AwakerSkillBackgroundStory = {
    Text = "神母的言行不容指摘。"
  },
  Skill_119767_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_119767_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。抽 1 张「深海圣咏」，每回合最多生效 1 次( [Arg3]/1 )。"
  },
  Skill_119767_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。诞妄·墨菲获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_119767_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。诞妄·墨菲获得 <Energy:[Energy:Arg2]> 点狂气。抽 1 张「深海圣咏」，每回合最多生效 1 次。"
  },
  Skill_119767_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_119767_Name = {Text = "防御"},
  Skill_119767_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_119835_Desc = {
    Text = "从弃牌堆中选择 1 张指令卡移回手中。若「拉蒙娜」在队伍中，使其本回合打出的下一张指令卡生效 [Arg1] 次。"
  },
  Skill_119835_Name = {
    Text = "重逢心愿"
  },
  Skill_119845_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：视为本回合内上次打出的「技能」，算力消耗 -[Arg1]。此卡牌在战斗开始后置于第二个抽牌堆的顶部。"
  },
  Skill_119845_Name_1 = {
    Text = "重逢心愿"
  },
  Skill_119845_UnknownName = {
    Text = "重逢心愿"
  },
  Skill_120314_Desc = {
    Text = "获得 1 点算力，对所有敌人施加 5 层<DwmofeiKeywords:降生仪式>。若「诞妄·墨菲」在队伍中，抽 1 张「螺湮圆舞」。"
  },
  Skill_120314_Name = {Text = "偏航船"},
  Skill_120896_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。全体友方获得 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_120896_Name = {
    Text = "破碎沉戟"
  },
  Skill_120942_Desc = {
    Text = "添加1000000生命"
  },
  Skill_120942_Name = {
    Text = "添加1000000生命"
  },
  Skill_121138_Desc = {
    Text = "切换到该意图时生成 1 倍的临时触腕，<TentacleInjurieIconKeywords:触腕伤害>临时降低 50%。全体友方获得 <Block:[Block:Arg1]> 点护盾并免疫 1 回合负面状态。"
  },
  Skill_121138_Name = {
    Text = "遗失的久远之城"
  },
  Skill_121342_Desc = {
    Text = "对前排怪物造成99999999伤害"
  },
  Skill_121342_Name = {
    Text = "秒杀前排怪物"
  },
  Skill_121354_Desc = {
    Text = "对全体怪物造成99999999伤害"
  },
  Skill_121354_Name = {
    Text = "秒杀全体怪物"
  },
  Skill_121360_Desc = {
    Text = "添加移除无敌"
  },
  Skill_121360_Name = {
    Text = "添加移除无敌"
  },
  Skill_121361_Desc = {
    Text = "添加无敌"
  },
  Skill_121361_Name = {
    Text = "添加无敌"
  },
  Skill_121366_Desc = {
    Text = "添加500生命"
  },
  Skill_121366_Name = {
    Text = "添加500生命"
  },
  Skill_121800_Desc = {
    Text = "将敌人的触腕伤害临时降低 80%，获得等量的临时<PowerIconKeywords:力量>。"
  },
  Skill_121800_Name = {
    Text = "颠覆天穹"
  },
  Skill_121801_Desc = {
    Text = "选择 1 名唤醒体获得 50 点狂气，重复 3 次。"
  },
  Skill_121801_Name = {
    Text = "不移的虔信"
  },
  Skill_121802_Desc = {
    Text = "立刻回复 25% 最大生命，获得最大生命 500% 的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_121802_Name = {
    Text = "崇拜与鼓舞"
  },
  Skill_121803_Desc = {
    Text = "抽 5 张牌。清除所有手牌的<SlowIconKeywords:迟缓>。"
  },
  Skill_121803_Name = {
    Text = "神选的辉光"
  },
  Skill_122118_Desc = {
    Text = "抽 1 张牌，并将<DerivativeCardKeywords_128:「倒数时刻: 0」>洗入弃牌堆。"
  },
  Skill_122118_Name = {
    Text = "倒数时刻: 1"
  },
  Skill_122119_Desc = {
    Text = "抽 3 张牌，获得 3 点算力，并有 [Arg1]% 的机会将<DerivativeCardKeywords_123:「倒数时刻: 5」>洗入弃牌堆。"
  },
  Skill_122119_Name = {
    Text = "倒数时刻: 0"
  },
  Skill_122120_Desc = {
    Text = "抽 1 张牌，并将<DerivativeCardKeywords_125:「倒数时刻: 3」>洗入弃牌堆。"
  },
  Skill_122120_Name = {
    Text = "倒数时刻: 4"
  },
  Skill_122121_Desc = {
    Text = "抽 1 张牌，并将<DerivativeCardKeywords_124:「倒数时刻: 4」>洗入弃牌堆。"
  },
  Skill_122121_Name = {
    Text = "倒数时刻: 5"
  },
  Skill_122122_Desc = {
    Text = "抽 1 张牌，并将<DerivativeCardKeywords_126:「倒数时刻: 2」>洗入弃牌堆。"
  },
  Skill_122122_Name = {
    Text = "倒数时刻: 3"
  },
  Skill_122123_Desc = {
    Text = "抽 1 张牌，并将<DerivativeCardKeywords_127:「倒数时刻: 1」>洗入弃牌堆。"
  },
  Skill_122123_Name = {
    Text = "倒数时刻: 2"
  },
  Skill_122413_Desc = {
    Text = "茉夏之后造成未被格挡的伤害时，获得 2 层<Monster_Fervor:临时狂热>。获得 80 层<ReinforcePVEKeywords:加固>，敌方回合开始时移除。"
  },
  Skill_122413_Name = {
    Text = "雾境遗脉"
  },
  Skill_122414_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，敌人每拥有 <Block:[Block:Arg3]> 点护盾，使造成的伤害提高 1 点。获得 [Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_122414_Name = {
    Text = "人间爆破"
  },
  Skill_122415_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_122415_Name = {
    Text = "闪耀龙卷风"
  },
  Skill_122416_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_122416_Name = {
    Text = "闪耀龙卷风"
  },
  Skill_122417_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每有 1 次伤害被格挡则获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_122417_Name = {
    Text = "风暴冲击"
  },
  Skill_122432_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 <Block:[Block:Arg1]> 护盾和 <Energy:[Energy:Arg1]> 狂气。回合结束时该命轮自动解除装备，并使下次装备「盒中童趣」时获得的狂气和护盾提高 [Arg2]。"
  },
  Skill_122432_Name_1 = {
    Text = "盒中童趣"
  },
  Skill_122433_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 3 层<PVPReciprocalKeywords:倒数时刻>。"
  },
  Skill_122433_Name_1 = {
    Text = "倒数时刻"
  },
  Skill_122483_AwakerSkillBackgroundStory = {
    Text = "战斗，如生命的最后一次。\n为了回到那充满迷雾的，属于「自己」的世界。"
  },
  Skill_122483_Desc_0 = {
    Text = "视为「打击」。对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，"
  },
  Skill_122483_Desc_2 = {
    Text = "视为「打击」。对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，生成 1 张上一次打出的其他「打击」的临时复制并使其算力消耗 -1。"
  },
  Skill_122483_EffectNameList = {Text = "伤害"},
  Skill_122483_Name = {
    Text = "人间爆破"
  },
  Skill_122483_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_122484_AwakerSkillBackgroundStory = {
    Text = "所有人都会死亡，她也是——她不抗拒死亡，也不拒绝死亡。\n但很抱歉，她的死期不能是今天，也不能是此刻。\n她还没有玩尽兴呢！"
  },
  Skill_122484_Desc = {
    Text = "视为「打击」。对随机敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_122484_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_122484_Name = {
    Text = "风暴冲击"
  },
  Skill_122484_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_122485_AwakerSkillBackgroundStory = {
    Text = "不要忘记过去，不要忘记雾境调查团。\n忘记，代表着背叛。\n而她，茉夏，绝不背叛。"
  },
  Skill_122485_Desc_0 = {
    Text = "茉夏获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「戏剧性邂逅」伤害次数 +2。每次触发「戏剧性邂逅」使茉夏「打击」临时最终伤害 +25%。立即生成 1 张临时「人间爆破」。"
  },
  Skill_122485_Desc_15 = {
    Text = "茉夏获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「戏剧性邂逅」伤害次数 +2。每回合触发次数上限提高为 5。每次触发「戏剧性邂逅」使茉夏「打击」临时最终伤害 +25%。立即生成 2 张算力消耗为 0 的临时「人间爆破」。"
  },
  Skill_122485_EffectNameList = {Text = "狂气"},
  Skill_122485_Name = {
    Text = "雾境遗脉"
  },
  Skill_122485_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_122486_AwakerSkillBackgroundStory = {
    Text = "「到异世界也要喊那个吗？」\n「行吧，那你听好了——」\n「来了！男女老少都爱看的！闪耀☆龙卷风——！！」"
  },
  Skill_122486_BattleDesc_0 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。本回合所有唤醒体「打击」伤害提高 [Arg3] 点。"
  },
  Skill_122486_BattleDesc_3 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。本回合茉夏造成的伤害次数 +1，所有唤醒体「打击」伤害提高 [Arg3] 点。"
  },
  Skill_122486_Desc_0 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害。本回合所有唤醒体「打击」伤害提高 [Arg3] 点。"
  },
  Skill_122486_Desc_3 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害。本回合茉夏造成的伤害次数 +1，所有唤醒体「打击」伤害提高 [Arg3] 点。"
  },
  Skill_122486_EffectNameList = {
    Text = "伤害,打击伤害增幅"
  },
  Skill_122486_Name = {
    Text = "闪耀☆龙卷风"
  },
  Skill_122486_OverLimitUtlSkillDesc_0 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg4] 次。所有唤醒体「打击」伤害提高 [Arg3] 点。使打出的下一张「风暴冲击」基础算力消耗变为 0。若为本场战斗首次释放，额外<HunmiKeywords:昏迷>所有敌方。"
  },
  Skill_122486_OverLimitUtlSkillDesc_3 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg4] 次。本回合茉夏造成的伤害次数 +1，所有唤醒体「打击」伤害提高 [Arg3] 点。使打出的下一张「风暴冲击」基础算力消耗变为 0。若为本场战斗首次释放，额外<HunmiKeywords:昏迷>所有敌方。"
  },
  Skill_122486_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_122487_AwakerSkillBackgroundStory = {
    Text = "「还敢反抗？我要生气了哦——乖乖等死吧你！」"
  },
  Skill_122487_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_122487_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。茉夏获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_122487_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_122487_Name = {Text = "防御"},
  Skill_122487_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_122488_AwakerSkillBackgroundStory = {
    Text = "「哈哈哈哈，这样才对嘛，事情变得有意思起来了！」\n「谢谢你们陪我玩，我真是太开心了……」"
  },
  Skill_122488_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_122488_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。茉夏获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_122488_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_122488_Name = {Text = "打击"},
  Skill_122488_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_122656_Desc_1 = {
    Text = "请一名敌方唤醒体离场，我方唤醒体平摊其最大生命、生命、护盾、狂气。"
  },
  Skill_122656_Name_1 = {
    Text = "茜尔维娅的红茶"
  },
  Skill_122836_Desc = {
    Text = "生命设定为500生命"
  },
  Skill_122836_Name = {
    Text = "生命设定为500生命"
  },
  Skill_123159_Desc_0 = {
    Text = "对随机敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。"
  },
  Skill_123159_Name = {
    Text = "戏剧性邂逅"
  },
  Skill_123270_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机<BurningKeywords:燃烧> [Arg3] 张抽牌堆或弃牌堆的卡牌，造成 [Arg4] 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_123270_Name = {
    Text = "千兆耀斑"
  },
  Skill_123509_Desc = {
    Text = "抽 2 张「打击」。若「茉夏」在队伍中，使它们算力消耗 -1。"
  },
  Skill_123509_Name = {
    Text = "来自雾境"
  },
  Skill_124013_Desc_1 = {
    Text = "生成按公式添加状态测试卡"
  },
  Skill_124013_Name_1 = {
    Text = "生成测试卡"
  },
  Skill_124014_Desc_1 = {
    Text = "按公式添加状态仅目标"
  },
  Skill_124014_Name_1 = {Text = "仅目标"},
  Skill_124015_Desc_1 = {
    Text = "按公式添加状态仅自身"
  },
  Skill_124015_Name_1 = {Text = "仅自身"},
  Skill_124025_Desc_1 = {
    Text = "按公式添加状态双方"
  },
  Skill_124025_Name_1 = {Text = "双方"},
  Skill_124069_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每造成 [Arg3] 次未被格挡的伤害对抽牌堆顶指令卡施加 [Arg4] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_124069_Name = {Text = "打击"},
  Skill_124070_Desc = {
    Text = "驱散所有负面状态，对方回合结束不会丢弃手牌。回合结束时依次施加 [Arg1] 层<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重创>、<VulnerabilityIconKeywords:易伤>状态。"
  },
  Skill_124070_Name = {
    Text = "界外之音"
  },
  Skill_124071_Desc = {
    Text = "全体友方获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_124071_Name = {
    Text = "绵音渐响"
  },
  Skill_124072_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，对手牌中随机 [Arg2] 张指令卡和抽牌堆随机 [Arg2] 张指令卡施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_124072_Name = {
    Text = "星彩极光"
  },
  Skill_124073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使全体友方获得 [Arg3] 点<PowerIconKeywords:力量>。若自身或其他友方存在<WeaknessIconKeywords:虚弱>或<VulnerabilityIconKeywords:易伤>状态，将其转移给敌方。"
  },
  Skill_124073_Name = {Text = "安魂曲"},
  Skill_124074_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，敌方手牌中每有 [Arg2] 张<SlowIconKeywords:迟缓>卡牌，获得 [Arg3] 层临时<MadnessIconKeywords:疯狂>。"
  },
  Skill_124074_Name = {
    Text = "绵音渐响"
  },
  Skill_124075_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_124075_Name = {Text = "打击"},
  Skill_124076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3]% 未被格挡伤害的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_124076_Name = {Text = "打击"},
  Skill_124077_Desc = {
    Text = "全体友方回复已损失生命的 [Arg1]% 。"
  },
  Skill_124077_Name = {
    Text = "幼芽萌生"
  },
  Skill_124078_Desc = {
    Text = "回复已损失生命的 [Arg1]% ，获得 [Arg2] 层<ReinforcePVEKeywords:加固>。"
  },
  Skill_124078_Name = {
    Text = "幼芽萌生"
  },
  Skill_124079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。若自身存在<WeaknessIconKeywords:虚弱>或<VulnerabilityIconKeywords:易伤>状态，将其转移给敌方。"
  },
  Skill_124079_Name = {Text = "安魂曲"},
  Skill_124080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3]% 未被格挡伤害的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_124080_Name = {Text = "打击"},
  Skill_124081_Desc = {
    Text = "获取 [Arg1] <RetaliateIconKeywords:反击>， <Block:[Block:Arg2]> 点护盾，前进。"
  },
  Skill_124081_Name = {
    Text = "星之摇篮"
  },
  Skill_124082_Desc = {
    Text = "获得 [Arg1] 层<Guaiwusiwangdikang:死亡抵抗>，<Guaiwusiwangdikang:死亡抵抗>回复生命提高为 [Arg2]%。敌方每打出 [Arg3] 张指令卡，临时偷取 [Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_124082_Name = {
    Text = "无边星彩"
  },
  Skill_124083_Desc = {
    Text = "获取 [Arg1] <RetaliateIconKeywords:反击>， <Block:[Block:Arg2]> 点护盾，[Arg3] 层<Guaiwusiwangdikang:死亡抵抗>。"
  },
  Skill_124083_Name = {
    Text = "星之摇篮"
  },
  Skill_124084_Desc = {
    Text = "最大生命 +[Arg1]%，偷取 [Arg2]% <PowerIconKeywords:力量>。敌方生命上限 -[Arg3]%。"
  },
  Skill_124084_Name = {
    Text = "养分汲取"
  },
  Skill_124085_Desc = {
    Text = "最大生命 +[Arg1]%，偷取 [Arg2]% 力量。若本回合未失去生命，敌方生命上限 -[Arg3]%。"
  },
  Skill_124085_Name = {
    Text = "养分汲取"
  },
  Skill_124086_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，对手牌中随机 [Arg2] 张指令卡和抽牌堆随机 [Arg2] 张指令卡施加 [Arg3] 层<SlowIconKeywords:迟缓>。后退。"
  },
  Skill_124086_Name = {
    Text = "星彩极光"
  },
  Skill_124182_Desc = {
    Text = "最大生命 +[Arg1]%，偷取 [Arg2]% <PowerIconKeywords:力量>。"
  },
  Skill_124182_Name = {
    Text = "养分汲取"
  },
  Skill_124205_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，敌人每拥有 <Block:[Block:Arg3]> 点护盾，使造成的伤害提高 1 点。获得 [Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_124205_Name = {
    Text = "人间爆破"
  },
  Skill_124218_Desc_1 = {
    Text = "随机获取存活唤醒体"
  },
  Skill_124218_Name_1 = {
    Text = "随机获取存活唤醒体"
  },
  Skill_124225_Desc_1 = {
    Text = "随机获取卡牌"
  },
  Skill_124225_Name_1 = {
    Text = "随机获取卡牌"
  },
  Skill_124420_Desc = {
    Text = "茉夏之后造成未被格挡的伤害时，获得 2 层<Monster_Fervor:临时狂热>。"
  },
  Skill_124420_Name = {
    Text = "雾境遗脉"
  },
  Skill_124422_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每有 1 次伤害被格挡则获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_124422_Name = {
    Text = "风暴冲击"
  },
  Skill_124423_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_124423_Name = {
    Text = "闪耀龙卷风"
  },
  Skill_124424_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 ，施加 [Arg3] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_124424_Name = {
    Text = "闪耀龙卷风"
  },
  Skill_124740_Desc = {
    Text = "四个唤醒体轮流打出大招。对黑名单监听保持静默。"
  },
  Skill_124740_Name = {
    Text = "追击测试"
  },
  Skill_124742_Desc = {
    Text = "四个唤醒体轮流打出打击。对黑名单监听保持静默。"
  },
  Skill_124742_Name = {
    Text = "追击测试"
  },
  Skill_124755_Desc = {
    Text = "玩家放出指名钥令。对黑名单监听保持静默。"
  },
  Skill_124755_Name = {
    Text = "追击测试"
  },
  Skill_124761_Desc = {
    Text = "玩家放出指名钥令。触发全部监听。"
  },
  Skill_124761_Name = {
    Text = "追击测试"
  },
  Skill_124762_Desc = {
    Text = "四个唤醒体轮流打出大招。触发全部监听。"
  },
  Skill_124762_Name = {
    Text = "追击测试"
  },
  Skill_124763_Desc = {
    Text = "四个唤醒体轮流打出打击。触发全部监听。"
  },
  Skill_124763_Name = {
    Text = "追击测试"
  },
  Skill_124814_Desc = {
    Text = "四个唤醒体轮流打出防御。触发全部监听。"
  },
  Skill_124814_Name = {
    Text = "追击测试"
  },
  Skill_124815_Desc = {
    Text = "四个唤醒体轮流打出技能1。对黑名单监听保持静默。"
  },
  Skill_124815_Name = {
    Text = "追击测试"
  },
  Skill_124816_Desc = {
    Text = "四个唤醒体轮流打出觉醒。触发全部监听。"
  },
  Skill_124816_Name = {
    Text = "追击测试"
  },
  Skill_124817_Desc = {
    Text = "四个唤醒体轮流打出觉醒。对黑名单监听保持静默。"
  },
  Skill_124817_Name = {
    Text = "追击测试"
  },
  Skill_124818_Desc = {
    Text = "四个唤醒体轮流打出技能1。触发全部监听。"
  },
  Skill_124818_Name = {
    Text = "追击测试"
  },
  Skill_124819_Desc = {
    Text = "四个唤醒体轮流打出防御。对黑名单监听保持静默。"
  },
  Skill_124819_Name = {
    Text = "追击测试"
  },
  Skill_124820_Desc = {
    Text = "空药水卡，获得 [Block:Arg1] 点护盾。"
  },
  Skill_124820_Name = {
    Text = "追击测试"
  },
  Skill_124821_Desc = {
    Text = "玩家打出指名卡牌。对黑名单监听保持静默。"
  },
  Skill_124821_Name = {
    Text = "追击测试"
  },
  Skill_124822_Desc = {
    Text = "玩家打出指名卡牌。触发全部监听。"
  },
  Skill_124822_Name = {
    Text = "追击测试"
  },
  Skill_124839_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，对手中随机 [Arg2] 张卡牌和抽牌堆随机 [Arg2] 张卡牌施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_124839_Name = {
    Text = "星彩极光"
  },
  Skill_124840_Desc = {
    Text = "获取 [Arg1] <RetaliateIconKeywords:反击>， <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_124840_Name = {
    Text = "星之摇篮"
  },
  Skill_124871_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：打出装备者的技能卡后，抽 [Arg1] 张牌，优先抽取其他唤醒体的牌，每回合至多生效 1 次。"
  },
  Skill_124871_Name_1 = {
    Text = "宿命纺轮"
  },
  Skill_124872_Desc_1 = {
    Text = "选择一名友方，使其下 1 张打出的「技能」生效 2 次。"
  },
  Skill_124872_Name_1 = {Text = "繁网"},
  Skill_124874_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身下 [Arg1] 张打出的「技能」生效 2 次。"
  },
  Skill_124874_Name_1 = {
    Text = "永世编织之网"
  },
  Skill_124875_Desc_1 = {
    Text = "抽 [Arg1] 张牌，获得 [Arg1] 点算力。选择任意唤醒体，直到自身下回合开始，其造成和受到的致命主动伤害改为施加等量<PVPDestinedDeathKeyWords:命定预兆>。"
  },
  Skill_124875_Name_1 = {
    Text = "命途，依此谕示"
  },
  Skill_124876_BattleDesc_1 = {
    Text = "随机造成 [Arg3] 次 <Damage:[Damage:Arg2]> 伤害，<PVPDestinedDeathKeyWords:命定预兆>，将这张牌洗入抽牌堆，使所有「纺织」伤害次数 +1。"
  },
  Skill_124876_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，<PVPDestinedDeathKeyWords:命定预兆>，将这张牌洗入抽牌堆，使所有「纺织」伤害次数 +1。"
  },
  Skill_124876_Name_1 = {Text = "纺织"},
  Skill_124877_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_124877_Name_1 = {Text = "打击"},
  Skill_124878_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：每次打出卡牌后变化为敌方手中的随机「技能」，并使其算力消耗 -[Arg1]。"
  },
  Skill_124878_Name_1 = {Text = "预言"},
  Skill_124900_Desc_1 = {
    Text = "给予一名友方 +[Arg1] <StrongEffectKeywords:强效>。此卡牌洗入下个抽牌堆，并且下次打出 +[Arg2] <StrongEffectKeywords:强效>，"
  },
  Skill_124900_Name_1 = {
    Text = "罗网轮转"
  },
  Skill_124900_UnknownName = {
    Text = "罗网轮转"
  },
  Skill_125370_Desc_1 = {
    Text = "选择一名友方，使其对其他友方和全体敌方施加 [Arg1] 层<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125370_Name_1 = {
    Text = "深宅往事"
  },
  Skill_125370_UnknownName = {
    Text = "深宅往事"
  },
  Skill_125371_AwakerSkillBackgroundStory = {
    Text = "祂们从不谈及她的源起，只谈及她降生时那无法名状的巨大欢愉。\n你的意识将在狂喜中融化，你的过往将在狂喜中融化，你的颅骨将在狂喜中融化……你的脑浆将在狂喜中融化。\n一味入口软嫩的点心——以「相思」作引。"
  },
  Skill_125371_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击伤害并触发 [Arg2]％ 中毒。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]( [Arg5]/3 )。"
  },
  Skill_125371_BattleDesc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击伤害并触发 [Arg2]％ 中毒，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]( [Arg5]/3 )。"
  },
  Skill_125371_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击伤害并触发 [Arg2]％ 中毒。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]。"
  },
  Skill_125371_Desc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击伤害并触发 [Arg2]％ 中毒，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg6]。<ResonanceKeywords:共振3>：<EmbryoFusionIconKeywords:胚胎融合> +[Arg4]。"
  },
  Skill_125371_EffectNameList = {Text = "伤害"},
  Skill_125371_Name = {
    Text = "入骨相思"
  },
  Skill_125371_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_125372_Desc_1 = {
    Text = "对目标和<HPAndShieldMax:生命与护盾最高>敌方造成 <Damage:[Damage:Arg1]> 伤害并施加 1 层<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125372_Name_1 = {
    Text = "藕丝难杀"
  },
  Skill_125373_AwakerSkillBackgroundStory = {
    Text = "为何要引诱祂们？祂们本来就无力反抗。\n为何要唆使祂们？直到更高，更广，权欲的漩涡将所有目及之处都圈进。\n因为仅困于情的庸人之髓难以下咽。因为未经野心腌制的凡俗之躯索然无趣。\n不梦乡是猎食者给猎物残渣的恩赏。\n那欢愉的中心没有任何事物，只有无尽的混乱，无尽的诡谲陆离。"
  },
  Skill_125373_Desc_0 = {
    Text = "徐获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：徐的每种指令卡每回合首次触发<ResonanceKeywords:共振>效果时，使其基础算力消耗变为 0。"
  },
  Skill_125373_Desc_15 = {
    Text = "徐获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：徐的每种指令卡每回合首次触发<ResonanceKeywords:共振>效果时，使其基础算力消耗变为 0。<WitherKeywords0:痴醉>的叠加上限提高为 15 层，徐每回合首次打出的指令卡额外生效 1 次。"
  },
  Skill_125373_EffectNameList = {Text = "狂气"},
  Skill_125373_Name = {
    Text = "不梦乡之主"
  },
  Skill_125373_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_125374_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_125374_Name_1 = {Text = "打击"},
  Skill_125375_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，施加 1 层<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125375_Name_1 = {
    Text = "暗通款曲"
  },
  Skill_125376_AwakerSkillBackgroundStory = {
    Text = "古往今来，情之一字。\n无非使人身向孽海，不肯回头。"
  },
  Skill_125376_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。】获得 [Arg2] 点算力，对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。选择：<WitherKeywords1:相许>或<WitherKeywords2:夺魄>。"
  },
  Skill_125376_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。】获得 [Arg2] 点算力，对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。自身下次触发的<ResonanceKeywords:共振>效果翻倍。选择：<WitherKeywords1:相许>或<WitherKeywords2:夺魄>。"
  },
  Skill_125376_EffectNameList = {
    Text = "中毒,力量降低"
  },
  Skill_125376_Name = {
    Text = "夜雾下的情誓"
  },
  Skill_125376_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。】获得 [Arg2] 点算力，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg4]，对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。选择：<WitherKeywords3:相许>或<WitherKeywords4:夺魄>。"
  },
  Skill_125376_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。】获得 [Arg2] 点算力，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg4]，对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。自身下次触发的<ResonanceKeywords:共振>效果翻倍。选择：<WitherKeywords3:相许>或<WitherKeywords4:夺魄>。"
  },
  Skill_125376_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_125377_Desc_1 = {
    Text = "<PVPSneakKeywords:潜行>，获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_125377_Name_1 = {
    Text = "缱绻夜雾"
  },
  Skill_125378_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对<HPAndShieldMax:生命与护盾最高>的敌方施加 [Arg1] 层<PVPLostSoulKeyWords:痴醉>。"
  },
  Skill_125378_Name_1 = {
    Text = "玉兰之饵"
  },
  Skill_125379_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方「狂气爆发」后，使手牌中装备者的所有「技能」算力消耗 -1。"
  },
  Skill_125379_Name_1 = {Text = "枉蹙眉"},
  Skill_125380_AwakerSkillBackgroundStory = {
    Text = "她的扇下有一个吻，她的扇下有无数个吻。\n丰沛的、多汁的、柔软的……包裹、消融、沉寂。"
  },
  Skill_125380_BattleDesc = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并使其临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共振3>：对所有敌人施加 1 层<WitherKeywords:痴醉>( [Arg3]/3 )。"
  },
  Skill_125380_Desc_0 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并使其临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共振3>：对所有敌人施加 1 层<WitherKeywords:痴醉>。"
  },
  Skill_125380_Desc_3 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并使其临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<ResonanceKeywords:共振3>：对所有敌人施加 1 层<WitherKeywords0:痴醉>。"
  },
  Skill_125380_EffectNameList_0 = {
    Text = "中毒,力量降低"
  },
  Skill_125380_Name = {
    Text = "寄吻于扇"
  },
  Skill_125380_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_125381_AwakerSkillBackgroundStory = {
    Text = "「古古怪，怪怪古，亡妻三更爬出土，浪子负心锅里煮。」"
  },
  Skill_125381_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_125381_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<ResonanceKeywords:共振3>：额外获得 <Energy:[Energy:Arg3]> 点狂气( [Arg4]/3 )。"
  },
  Skill_125381_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。徐获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_125381_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。徐获得 <Energy:[Energy:Arg2]> 点狂气。<ResonanceKeywords:共振3>：额外获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_125381_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_125381_Name = {Text = "打击"},
  Skill_125381_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_125382_Desc_1 = {
    Text = "移除目标所有<PVPLostSoulKeyWords:痴醉>并造成 <Damage:[Damage:Arg1]> 伤害。每移除 1 层对随机敌方造成 1 次 <Damage:[Damage:Arg2]> 伤害并<StrongEffectKeywords:强效> +[Arg3]。"
  },
  Skill_125382_Name_1 = {
    Text = "夜雾下的情誓"
  },
  Skill_125383_AwakerSkillBackgroundStory = {
    Text = "「无相的神女愿救苦，割面剖怀取郎骨，献我堂前无上主。」"
  },
  Skill_125383_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_125383_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<ResonanceKeywords:共振3>：额外获得 <Energy:[Energy:Arg3]> 点狂气( [Arg4]/3 )。"
  },
  Skill_125383_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。徐获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_125383_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。徐获得 <Energy:[Energy:Arg2]> 点狂气。<ResonanceKeywords:共振3>：额外获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_125383_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_125383_Name = {Text = "防御"},
  Skill_125383_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_125903_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，[Arg2] 点<PowerIconKeywords:力量>。 从抽牌堆和弃牌堆中发现 [Arg3] 张指令卡，选择 [Arg4] 张指令卡将其<DepleteIconKeywords:消耗>。"
  },
  Skill_125903_Name = {
    Text = "万物归一"
  },
  Skill_125904_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords: 脆弱>、<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_125904_Name = {
    Text = "六翼满开"
  },
  Skill_125905_Desc = {
    Text = "回合结束若在手中，使所有唤醒体失去 3 点狂气。弃置后将其<DepleteIconKeywords:消耗>。"
  },
  Skill_125905_Name = {Text = "沉默"},
  Skill_125906_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords: 脆弱>。 打出 [Arg4] 张指令卡后，将意图变化为造成 <Damage:[Damage:Arg5]> 点伤害 [AttackTimes:Arg6] 次，施加 [Arg7] 层<FragileIconKeywords: 脆弱>和<WeaknessIconKeywords:虚弱>的「四翼渐生」。"
  },
  Skill_125906_Name = {
    Text = "双翼初张"
  },
  Skill_125907_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。 <Seal:封印>下个打出指令卡牌的唤醒体 [Arg2] 回合。"
  },
  Skill_125907_Name = {
    Text = "纵贯时序之翼"
  },
  Skill_125908_Desc = {
    Text = "敌方消耗算力时，获得的银钥能量降低 [Arg1]%。 塔薇造成未被格挡的伤害后，将 [Arg2] 张「<DerivativeCardKeywords_131:真·轮回悖论>」置入手中。"
  },
  Skill_125908_Name = {
    Text = "穿越银钥之门"
  },
  Skill_125909_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords: 脆弱>和<WeaknessIconKeywords:虚弱>。 打出 [Arg4] 张指令卡后，将意图变化为造成 <Damage:[Damage:Arg5]> 点伤害 [AttackTimes:Arg6] 次，施加 [Arg7] 层<FragileIconKeywords: 脆弱>、<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>的「六翼满开」。"
  },
  Skill_125909_Name = {
    Text = "四翼渐生"
  },
  Skill_126008_Desc = {
    Text = "选择一名唤醒体获得 30 狂气，其他唤醒体失去 10 狂气。此卡回合结束若在手中，对我方造成伤害。"
  },
  Skill_126008_Name = {
    Text = "真·轮回悖论"
  },
  Skill_126350_Desc_1 = {
    Text = "使一名目标获得 <PVPSneakKeywords:潜行>。"
  },
  Skill_126350_Name_1 = {Text = "潜行"},
  Skill_126446_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害（[Arg4]）点<IntoxicationIconKeywords:中毒>。 对 [Arg5] 张手牌施加<BurningKeywords:燃烧>。"
  },
  Skill_126446_Name = {
    Text = "腐化绿炎"
  },
  Skill_126447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害（[Arg4]）点<IntoxicationIconKeywords:中毒>。 对 [Arg5] 张手牌施加<BurningKeywords:燃烧>。"
  },
  Skill_126447_Name = {
    Text = "死灭绿炎"
  },
  Skill_126448_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害（[Arg4]）点<IntoxicationIconKeywords:中毒>。 对 [Arg5] 张手牌施加<BurningKeywords:燃烧>。"
  },
  Skill_126448_Name = {Text = "绿炎"},
  Skill_126449_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 层<MonsterLizVerdantSpark:翠绿火种>。 切换到该意图时，本回合每受到 [Arg3] 次「攻击」获得 [Arg4] 层<MonsterLizVerdantSpark:翠绿火种>。"
  },
  Skill_126449_Name = {
    Text = "诱蛾之火"
  },
  Skill_126450_Desc = {
    Text = "获得 [Arg1] 层<MonsterLizVerdantSpark:翠绿火种>，每失去 [Arg2]% 生命获得 [Arg3] 层<MonsterLizVerdantSpark:翠绿火种>。 获得<ExhaustionCounter:以牙还牙>。"
  },
  Skill_126450_Name = {
    Text = "翡翠映像"
  },
  Skill_126451_Desc = {
    Text = "切换至该意图时解除负面状态。获得 [Arg1] 点<PowerIconKeywords:力量>，弃掉所有手牌。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。每弃掉 1 张手牌，额外造成 1 次伤害，获得 1 层<MonsterLizVerdantSpark:翠绿火种>。"
  },
  Skill_126451_Name = {
    Text = "告死之舞"
  },
  Skill_126452_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，弃掉所有手牌。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。每弃掉 [Arg4] 张手牌，额外造成 [Arg5] 次伤害，获得 [Arg6] 层<MonsterLizVerdantSpark:翠绿火种>。"
  },
  Skill_126452_Name = {
    Text = "告死之舞"
  },
  Skill_126484_AwakerSkillBackgroundStory = {
    Text = "在第一缕丝线垂下时，命运便已宣告了它的判决。"
  },
  Skill_126484_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126484_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。阿拉克涅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126484_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_126484_Name = {Text = "打击"},
  Skill_126484_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_126484_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126484_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。若为本回合首次打出，释放 1 次「无尽线缕」追击( [Arg3]/1 )。"
  },
  Skill_126485_AwakerSkillBackgroundStory = {
    Text = "命运亦会为木偶的鲁莽让步。\n如果，它们愿意承受那注定的代价。"
  },
  Skill_126485_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126485_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。阿拉克涅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126485_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_126485_Name = {Text = "防御"},
  Skill_126485_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_126485_tempBattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_126485_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。若为本回合首次打出，释放 1 次「无尽线缕」追击(  [Arg3]/1 )。"
  },
  Skill_126486_AwakerSkillBackgroundStory = {
    Text = "她以命运之名，于此宣告——\n一切错误的命数，将湮于时光的尘土。世界的命运，将归于命定之轨。\n错乱的丝线，于此裁断。那被遗弃的不幸者，将于此安息。"
  },
  Skill_126486_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，临时伤害强效 +[Arg2]％，移除所有手牌的<SlowIconKeywords:迟缓>状态。"
  },
  Skill_126486_EffectNameList = {
    Text = "护盾,伤害强效,无尽线缕命运裁断"
  },
  Skill_126486_Name = {
    Text = "命途，依此谕示"
  },
  Skill_126486_OverLimitUtlSkillDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，临时伤害强效 +[Arg2]％，移除所有手牌的<SlowIconKeywords:迟缓>状态。生成手中和超维空间最多 5 张具有<SingularityKeywords1:奇点信标>卡牌的临时原始复制，将其随机置入抽牌堆和弃牌堆并使其算力消耗变为 0。"
  },
  Skill_126486_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2％,攻击力*GrowValue3"
  },
  Skill_126488_BattleDesc_0 = {
    Text = "失去 [Float:Arg3]％ 最大生命( [Arg4] )，获得 1 层<SilkKeywords:织命>。本场战斗「<DerivativeCardKeywords_138:牵丝引命>」失去的生命和阿拉克涅造成的<CutKeywords:命运裁断>提高 [Arg2]％。虚无：阿拉克涅随机获得 15~30 点狂气。"
  },
  Skill_126488_Desc_0 = {
    Text = "失去 [Arg1]％ 最大生命，获得 1 层<SilkKeywords:织命>。本场战斗「<DerivativeCardKeywords_138:牵丝引命>」失去的生命和阿拉克涅造成的<CutKeywords:命运裁断>提高 [Arg2]％。虚无：阿拉克涅随机获得 15~30 点狂气。"
  },
  Skill_126488_Name = {
    Text = "牵丝引命"
  },
  Skill_126490_AwakerSkillBackgroundStory = {
    Text = "帷幕升起的那一刻， 木偶们仰起头颅，看见了纺轮后那张温柔的脸。\n丝线绷紧，在木偶们的欢歌与舞蹈中，她如母亲般微笑。 \n命运的戏场里，她是它们唯一的观众。"
  },
  Skill_126490_BattleDesc_0 = {
    Text = "阿拉克涅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「湮灭」改为选择 1 张超维空间的指令卡取出，赋予「下次打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。"
  },
  Skill_126490_BattleDesc_15 = {
    Text = "阿拉克涅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「湮灭」改为选择 1 张超维空间的指令卡取出，赋予「下次打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。释放「湮灭」后立刻对所有敌人造成等同于 50％「命运裁断」的<FixedDamage:纯粹伤害>，下次狂气爆发造成的伤害强效和护盾提高 50％。"
  },
  Skill_126490_Desc_0 = {
    Text = "阿拉克涅获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：「湮灭」改为选择 1 张超维空间的指令卡取出，赋予「下次打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。"
  },
  Skill_126490_Desc_15 = {
    Text = "阿拉克涅获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：「湮灭」改为选择 1 张超维空间的指令卡取出，赋予「下次打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。释放「湮灭」后立刻对所有敌人造成等同于 50％「命运裁断」的<FixedDamage:纯粹伤害>，下次狂气爆发造成的伤害强效和护盾提高 50％。"
  },
  Skill_126490_EffectNameList = {Text = "狂气"},
  Skill_126490_Name = {
    Text = "木偶戏场揭幕"
  },
  Skill_126490_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_126656_Desc = {
    Text = "令站位为1的唤醒体追加后置行动，打出其打击卡。"
  },
  Skill_126656_Name = {
    Text = "追击测试"
  },
  Skill_126657_Desc = {
    Text = "令前排敌方追加后置行动，打出其当前意图。"
  },
  Skill_126657_Name = {
    Text = "追击测试"
  },
  Skill_126658_Desc = {
    Text = "令守密人追加后置行动，打出 技能@主角技能@脑中之音。"
  },
  Skill_126658_Name = {
    Text = "追击测试"
  },
  Skill_126767_BattleDesc = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords:痴醉>。"
  },
  Skill_126767_Desc_0 = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords:痴醉>。"
  },
  Skill_126767_Desc_3 = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords0:痴醉>。"
  },
  Skill_126767_Name = {Text = "相许"},
  Skill_126768_BattleDesc = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>并触发其 [Arg2]％ 中毒。"
  },
  Skill_126768_Desc_0 = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>并触发其 [Arg2]％ 中毒。"
  },
  Skill_126768_Desc_3 = {
    Text = "移除所有敌人的<WitherKeywords0:痴醉>，每移除 1 层造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>并触发其 [Arg2]％ 中毒。"
  },
  Skill_126768_Name = {Text = "夺魄"},
  Skill_126793_Desc = {
    Text = "获得 1 点算力并临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。若「徐」在队伍中，对所有敌人施加 1 层<WitherKeywords:痴醉>。"
  },
  Skill_126793_Name = {
    Text = "深宅往事"
  },
  Skill_126880_BattleDesc = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords:痴醉>，施加的中毒量提高 200％。"
  },
  Skill_126880_Desc_0 = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords:痴醉>，施加的中毒量提高 200％。"
  },
  Skill_126880_Desc_3 = {
    Text = "对所有敌人施加 [Arg1] 层<WitherKeywords0:痴醉>，施加的中毒量提高 200％。"
  },
  Skill_126880_Name = {Text = "相许"},
  Skill_126881_BattleDesc = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层积攒 [Arg3] 点猩红熔炉、造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>、触发其 [Arg2]％ 中毒。"
  },
  Skill_126881_Desc_0 = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层积攒 [Arg3] 点猩红熔炉、造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>、触发其 [Arg2]％ 中毒。"
  },
  Skill_126881_Desc_3 = {
    Text = "移除所有敌人的<WitherKeywords0:痴醉>，每移除 1 层积攒 [Arg3] 点猩红熔炉、造成 [Arg1]％ 目标最大生命的<FixedDamage:纯粹伤害>、触发其 [Arg2]％ 中毒。"
  },
  Skill_126881_Name = {Text = "夺魄"},
  Skill_127246_Desc = {
    Text = "获得 [Arg1] 层<MonsterTimeBeacon:回环>。之后每个回合结束时，获得 [Arg2] 层<MonsterTimeBeacon:回环>。"
  },
  Skill_127246_Name = {
    Text = "熵增逆转"
  },
  Skill_127247_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，额外受到 [Arg3] 倍<PowerIconKeywords:力量>和<ExhaustionIconKeywords:力量降低>影响， 使用后提高 [Arg4] 倍。 <MonsterTimeBeacon:回环>：造成 [Arg5] 倍伤害"
  },
  Skill_127247_Name = {
    Text = "命定之剑"
  },
  Skill_127248_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。 将 [Arg2] 张抽牌堆或弃牌堆的牌置入手中并永久施加<MonsterSightUnbound:超越之目>和<RetainIconKeywords:保留>。<MonsterTimeBeacon:回环>：额外获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_127248_Name = {
    Text = "超越之目"
  },
  Skill_127249_Desc = {
    Text = "在敌人回合开始时将其上回合最后打出的 [Arg1] 张指令卡置入手中，施加<NothingnessIconKeywords:虚无>。若可置入手中的指令卡不足，则抽等量牌代替。获得 [Arg2] 层<MonsterTimeBeacon:回环>。"
  },
  Skill_127249_Name = {
    Text = "悖论收束"
  },
  Skill_127250_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<BlindingKeywords: 致盲>。 <MonsterTimeBeacon:回环>：额外造成 [Arg4] 次伤害和 [Arg5] 层<BlindingKeywords: 致盲>。"
  },
  Skill_127250_Name = {Text = "打击"},
  Skill_127251_Desc = {
    Text = "在敌人回合开始时将其上回合最后打出的 [Arg1] 张指令卡置入手中，施加<NothingnessIconKeywords:虚无>，<DepleteIconKeywords:消耗>。若可置入手中的指令卡不足，则抽等量牌代替。获得 [Arg2] 层<MonsterTimeBeacon:回环>。"
  },
  Skill_127251_Name = {
    Text = "悖论收束"
  },
  Skill_127252_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。 将 [Arg2] 张抽牌堆或弃牌堆的牌置入手中并永久施加<MonsterSightUnbound:超越之目>，<RetainIconKeywords:保留>和<SlowIconKeywords:迟缓>。<MonsterTimeBeacon:回环>：额外获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_127252_Name = {
    Text = "超越之目"
  },
  Skill_127698_Desc = {
    Text = "施加 [Arg1] 层 <FragileIconKeywords: 脆弱>，为 [Arg2] 张卡牌附加 [Arg3] 层<BrokenCard:暗中破坏>。"
  },
  Skill_127698_Name = {Text = "裂解"},
  Skill_127699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机症状洗入对方抽牌堆。"
  },
  Skill_127699_Name = {
    Text = "黑死之吻"
  },
  Skill_127700_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_127700_Name = {
    Text = "淬毒涎液"
  },
  Skill_128020_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，为 [Arg2] 张卡牌附加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_128020_Name = {
    Text = "暗影缠丝"
  },
  Skill_128021_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机唤醒体附带<DepleteIconKeywords:消耗>的「打击」洗入对方抽牌堆。"
  },
  Skill_128021_Name = {
    Text = "幻毒侵蚀"
  },
  Skill_128048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每造成 1 次未被格挡的伤害就使目标失去 [Arg3] <PowerIconKeywords:力量>。"
  },
  Skill_128048_Name = {Text = "衰朽"},
  Skill_128049_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，封印 [Arg2] 张手中或抽牌堆顶的指令卡 [Arg3] 回合。"
  },
  Skill_128049_Name = {
    Text = "束缚之网"
  },
  Skill_128052_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，封印 [Arg2] 张手中或抽牌堆顶的指令卡 [Arg3] 回合。移动至前排，并在后方召唤 [Arg4] 名冷蛛群。"
  },
  Skill_128052_Name = {
    Text = "束缚之网"
  },
  Skill_128053_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，封印 [Arg2] 张手中或抽牌堆顶的指令卡 [Arg3] 回合。移动至前排，并在后方召唤 [Arg4] 名小型冷蛛白群。"
  },
  Skill_128053_Name = {
    Text = "束缚之网"
  },
  Skill_128207_Desc = {
    Text = "每次行动结束后都会获得 [Arg1] 层<ParcloseIconKeywords:屏障>和 [Arg2] 层<Chapter5_Monster_Fervor1:临时狂热>。"
  },
  Skill_128207_Name = {
    Text = "织母的摇篮"
  },
  Skill_128227_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每造成 1 次未被格挡的伤害就使目标弃置 [Arg3] 张指令卡。"
  },
  Skill_128227_Name = {Text = "坏灭"},
  Skill_128229_Desc = {
    Text = "施加 [Arg1] 层<FragileIconKeywords: 脆弱>，并为 [Arg2] 张手中或抽牌堆顶的指令卡附加 [Arg3] 层<BrokenCard:暗中破坏>。移动至前排，并在后方召唤 [Arg4] 名渊狱蜘群。"
  },
  Skill_128229_Name = {
    Text = "崩解之丝"
  },
  Skill_128230_Desc = {
    Text = "施加 [Arg1] 层<FragileIconKeywords: 脆弱>，并为 [Arg2] 张手中或抽牌堆顶的指令卡附加 [Arg3] 层<BrokenCard:暗中破坏>。移动至前排，并在后方召唤 [Arg4] 名小型冷蛛黑群。"
  },
  Skill_128230_Name = {
    Text = "崩解之丝"
  },
  Skill_128233_Desc = {
    Text = "施加 [Arg1] 层<FragileIconKeywords: 脆弱>，并为 [Arg2] 张手中或抽牌堆顶的指令卡附加 [Arg3] 层<BrokenCard:暗中破坏>。"
  },
  Skill_128233_Name = {
    Text = "崩解之丝"
  },
  Skill_128254_Desc = {
    Text = "每次行动结束后都会获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层<Chapter5_Monster_Fervor2:临时狂热>。"
  },
  Skill_128254_Name = {
    Text = "织母的低语"
  },
  Skill_128474_Desc = {
    Text = "和前列友方交换位置，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。若本回合击破了「旧日余烬」，获得 [Arg3] 层临时<ReinforcePVEKeywords:加固>并转化为造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次，获得 [Arg6] 层<Chapter5_Monster_Fervor1:临时狂热>的「凿击」。"
  },
  Skill_128474_Name = {
    Text = "狂热凿击"
  },
  Skill_128475_Desc = {
    Text = "和前列友方交换位置，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<Chapter5_Monster_Fervor1:临时狂热>。"
  },
  Skill_128475_Name = {Text = "凿击"},
  Skill_128476_Desc = {
    Text = "和前列友方交换位置，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。若本回合击破了「旧日余烬」，获得 [Arg3] 层临时<ReinforcePVEKeywords:加固>并转化为造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次，获得 [Arg6] 层<Chapter5_Monster_Fervor2:临时狂热>的「凿击」。"
  },
  Skill_128476_Name = {
    Text = "狂热凿击"
  },
  Skill_128477_Desc = {
    Text = "和前列友方交换位置，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<Chapter5_Monster_Fervor2:临时狂热>。"
  },
  Skill_128477_Name = {Text = "凿击"},
  Skill_128624_Desc = {
    Text = "切换至该意图时，立刻获得 [Arg1] 层<Chapter5_Monster_Fervor3:狂热>。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次，每造成 [Arg4] 次未被格挡的伤害，获得 [Arg5] 层<Chapter5_Monster_Fervor3:狂热>。"
  },
  Skill_128624_Name = {
    Text = "狂喜之茧"
  },
  Skill_128625_Desc = {
    Text = "切换至该意图时，立刻施加 [Arg1] 层<EmptinessKeywords: 空虚>并使所有唤醒体失去 [Arg2] 点狂气。造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg4] 次，弃掉所有手牌。"
  },
  Skill_128625_Name = {
    Text = "惊惧之茧"
  },
  Skill_128627_Desc = {
    Text = "切换至该意图时，直到下回合开始时，每打出 [Arg1] 张指令卡就获得 [Arg2] 的临时<PowerIconKeywords:力量>。 造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg4] 次，对手生命越低伤害越高，最高为 <Damage:[Damage:Arg5]> 点伤害。"
  },
  Skill_128627_Name = {
    Text = "暴怒之茧"
  },
  Skill_128628_Desc = {
    Text = "切换至该意图时，将 [Arg1] 张随机症状洗入手中。造成<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重创> [Arg2] 回合和 [Arg3] 的<BleedingIconKeywords:出血>，本回合每打出 [Arg4] 张症状，<BleedingIconKeywords:出血>效果增加 [Arg5]。"
  },
  Skill_128628_Name = {
    Text = "哀悯之茧"
  },
  Skill_128689_Desc = {
    Text = "临时暴击率 +[Arg1]%，获得 1 点算力。本场战斗首次释放时对所有敌人造成 [Arg3] 点<AshesPastKeyWord:旧日余烬>。"
  },
  Skill_128689_Name = {
    Text = "岁末花火"
  },
  Skill_129565_BattleDesc_1 = {
    Text = "全体友方临时<StrongEffectKeywords:强效>+ [Arg3] ，每有 1 名阵亡友方额外获得 [Arg1] 临时<StrongEffectKeywords:强效>。"
  },
  Skill_129565_Desc_1 = {
    Text = "全体友方临时<StrongEffectKeywords:强效>+ [Arg1] ，每死亡一名友方体临时<StrongEffectKeywords:强效>+1 。"
  },
  Skill_129565_Name_1 = {
    Text = "岁末花火"
  },
  Skill_129565_UnknownName = {
    Text = "岁末花火"
  },
  Skill_129615_Desc = {
    Text = "切换至该意图时，立刻施加 [Arg1] 层<EmptinessKeywords: 空虚>并使所有唤醒体失去 [Arg2] 点狂气。造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg4] 次，弃掉所有手牌。"
  },
  Skill_129615_Name = {
    Text = "惊惧之茧"
  },
  Skill_129616_Desc = {
    Text = "切换至该意图时，直到下回合开始时，每打出 [Arg1] 张指令卡就获得 [Arg2] 的临时<PowerIconKeywords:力量>。 造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg4] 次，对手生命越低伤害越高，最高为 <Damage:[Damage:Arg5]> 点伤害。"
  },
  Skill_129616_Name = {
    Text = "暴怒之茧"
  },
  Skill_129617_Desc = {
    Text = "切换至该意图时，将 [Arg1] 张随机症状洗入手中。造成<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重创> [Arg2] 回合和 [Arg3] 的<BleedingIconKeywords:出血>，本回合每打出 [Arg4] 张症状，<BleedingIconKeywords:出血>效果增加 [Arg5]。"
  },
  Skill_129617_Name = {
    Text = "哀悯之茧"
  },
  Skill_129618_Desc = {
    Text = "切换至该意图时，立刻获得 [Arg1] 层<Chapter5_Monster_Fervor3:狂热>。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次，每造成 [Arg4] 次未被格挡的伤害，获得 [Arg5] 层<Chapter5_Monster_Fervor3:狂热>。"
  },
  Skill_129618_Name = {
    Text = "狂喜之茧"
  },
  Skill_129622_Desc = {
    Text = "切换至该意图时，立刻施加 [Arg1] 层<EmptinessKeywords: 空虚>并使所有唤醒体失去 [Arg2] 点狂气。造成 <Damage:[Damage:Arg3]> 点伤害 [AttackTimes:Arg4] 次，弃掉所有手牌。"
  },
  Skill_129622_Name = {
    Text = "惊惧之茧"
  },
  Skill_129638_Desc = {
    Text = "该意图无法被切换。切换至该意图时，立刻获得 [Arg1] 层临时<ReinforcePVEKeywords:加固>。\n造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。洗入 [Arg4] 张随机症状、获得 [Arg5] 层<Chapter5_Monster_Fervor3:狂热>、所有唤醒体失去 [Arg6] 点狂气。"
  },
  Skill_129638_Name = {
    Text = "破茧狂宴"
  },
  Skill_129811_Desc = {
    Text = "选择一个策略。每次「葬骸之主」释放「残骸收取」后，置入手中。"
  },
  Skill_129811_Name = {
    Text = "制定策略"
  },
  Skill_129812_Desc = {
    Text = "所有敌人的伤害临时降低 30%。"
  },
  Skill_129812_Name = {
    Text = "正面干扰"
  },
  Skill_129813_Desc = {
    Text = "所有敌人获得 [Arg1] 点临时<PowerIconKeywords:力量>。「葬骸之主」失去一半<Guaiwucanhai:残骸>。"
  },
  Skill_129813_Name = {
    Text = "偷袭储备"
  },
  Skill_129822_Desc = {
    Text = "造成 [Arg1] 层<EmptinessKeywords: 空虚>和 <WeaknessIconKeywords:虚弱>状态，回复 [Arg2]% 已损失生命。复制空间最左侧 [Arg3] 张卡牌置入抽牌堆顶部，复制 [Arg4] 张随机指令卡置入维度裂隙。"
  },
  Skill_129822_Name = {
    Text = "缚命罗网"
  },
  Skill_129823_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。「维度裂隙」中每有 1 张卡牌额外造成 1 次伤害。"
  },
  Skill_129823_Name = {
    Text = "无尽线缕"
  },
  Skill_129824_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>，「维度裂隙」中每有 1 张卡牌施加 1 层。"
  },
  Skill_129824_Name = {
    Text = "永恒织造"
  },
  Skill_129826_Desc = {
    Text = "获得 [Arg1] <PowerIconKeywords:力量>，将随机 [Arg2] 张指令卡的复制置入「维度裂隙」，将 [Arg3] 张<DerivativeCardKeywords_23:伤口>置入抽牌堆。"
  },
  Skill_129826_Name = {
    Text = "命途，依此谕示"
  },
  Skill_129827_Desc = {
    Text = "获得 [Arg1] <PowerIconKeywords:力量>，将随机 [Arg2] 张指令卡的复制置入「维度裂隙」，将 [Arg3] 张随机<AberrationKeywords:畸变>置入抽牌堆。"
  },
  Skill_129827_Name = {
    Text = "凌驾命运的悲歌"
  },
  Skill_129828_Desc = {
    Text = "变更「断丝震鸣」触发后的意图。将 [Arg1] 张随机指令卡的复制置入「维度裂隙」，每当 [Arg2] 张卡牌离开「维度裂隙」时为其赋予 [Arg3] 层<BrokenCard:暗中破坏>。"
  },
  Skill_129828_Name = {
    Text = "木偶戏场揭幕"
  },
  Skill_129856_Desc = {
    Text = "生成 1 条触腕，获得 [Arg1] 点临时触腕伤害。"
  },
  Skill_129856_Name = {
    Text = "王权之威"
  },
  Skill_129857_Desc = {
    Text = "获得「震怒」、12 层「困意」以及 [Arg1] 点触腕伤害。"
  },
  Skill_129857_Name = {
    Text = "不朽威仪"
  },
  Skill_129858_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。自身生命上限+[Arg3]％。"
  },
  Skill_129858_Name = {
    Text = "等价交换"
  },
  Skill_129869_Desc = {
    Text = "自定义执行指令"
  },
  Skill_129869_Name = {
    Text = "封装测试"
  },
  Skill_130234_Desc_1 = {
    Text = "查看 [Arg1] 张其他随机「钥令」，选择 1 张置入手中。"
  },
  Skill_130234_Name_1 = {
    Text = "不平等交换"
  },
  Skill_130234_UnknownName = {
    Text = "不平等交换"
  },
  Skill_130240_Desc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气，其他唤醒体获得 [Arg2] 点狂气。若「莫丝」在队伍中，立刻释放「涡！流！弹！」进行追击。"
  },
  Skill_130240_Name = {
    Text = "溺亡的纯真"
  },
  Skill_130351_Desc = {
    Text = "抽牌阶段后若在手中，「强制打出」 1 张随机指令卡并使其生效 2 次。\n打出后，下张打出的指令卡额外生效 2 次。打出 [Arg1] 次后消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130351_Name = {
    Text = "提线木偶"
  },
  Skill_130385_Desc = {
    Text = "抽牌阶段后若在手中，从手牌中的随机 2 张指令中选择 1 张强制打出,并使其生效 2 次。\n打出后，下张指令卡算力消耗降低 2 点，打出的指令卡额外生效 2 次。打出 [Arg1] 次后消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130385_Name = {
    Text = "提线木偶"
  },
  Skill_130386_Desc = {
    Text = "抽牌阶段后若在手中，从手牌中的随机 2 张指令中选择 1 张强制打出,并使其生效 2 次。\n打出后，下张打出的指令卡额外生效 2 次。打出 [Arg1] 次后消耗（[Arg2]/[Arg1]）。"
  },
  Skill_130386_Name = {
    Text = "提线木偶"
  },
  Skill_130471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，维度裂隙中每有 1 张卡牌，伤害提高 [Arg3] 点。每造成 1 次未被格挡的伤害获得 1 层<ResentChainsKeywords:怨恨锁链>。"
  },
  Skill_130471_Name = {
    Text = "万丝穿心"
  },
  Skill_130472_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并驱散自身负面状态，每造成 1 次未被格挡的伤害，自身最大生命提高 3%。"
  },
  Skill_130472_Name = {
    Text = "「当局者迷」"
  },
  Skill_130473_Desc = {
    Text = "其他友方获得 [Arg1] 点<PowerIconKeywords:力量>，自身获得 [Arg2] 点<PowerIconKeywords:力量>和 [Arg3]% 临时<Baojidikang:暴击抵抗>，召唤 2 名附加<Chapter5_Monster_Agitation:渊狱之门>的眷属。"
  },
  Skill_130473_Name = {
    Text = "孵化眷属"
  },
  Skill_130474_Desc = {
    Text = "切换至该意图时，造成 [Arg1] 层<BleedingIconKeywords:出血>。施加 [Arg2] 层<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_130474_Name = {
    Text = "收割命运的红线"
  },
  Skill_130475_Desc = {
    Text = "造成 [Arg1] 点<IntoxicationIconKeywords:中毒>，所有唤醒体基础狂气 +[Arg2] 。"
  },
  Skill_130475_Name = {
    Text = "「风雨如晦」"
  },
  Skill_130476_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] <PowerIconKeywords:力量>，移除维度裂隙。"
  },
  Skill_130476_Name = {
    Text = "凌驾命运的悲歌"
  },
  Skill_130477_Desc = {
    Text = "切换至该意图时，移除「缚誓契约」和<Chapter5_Monster_Fervor4:狂热>，清除其他友方。自身当前和最大生命提高 250%，「旧日余烬」总量翻倍，获得 50 层「融蚀雾盾」，打开「维度裂隙」。"
  },
  Skill_130477_Name = {
    Text = "绞缠暗夜的纺轮"
  },
  Skill_130478_Desc = {
    Text = "「封印」当前所有具有「命运残碎」的指令卡 [Arg1] 回合，对其他指令卡造成 [Arg2] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_130478_Name = {
    Text = "「覆水难收」"
  },
  Skill_130479_Desc = {
    Text = "切换至该意图时，造成 [Arg1] 层<BleedingIconKeywords:出血>。施加 [Arg2] 层<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>。若维度裂隙中卡牌数量大于  [Arg3]，额外施加 [Arg4] 层<FragileIconKeywords: 脆弱>、<BlindingKeywords: 致盲>、<Decay:腐朽>。"
  },
  Skill_130479_Name = {
    Text = "朽烂命运的红线"
  },
  Skill_130491_Desc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、[Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_130491_Name = {
    Text = "七彩大炮α"
  },
  Skill_130493_Desc = {
    Text = "获得 2 点算力，抽 2 张牌。"
  },
  Skill_130493_Name = {
    Text = "莉雅的硬币"
  },
  Skill_130506_Desc = {
    Text = "将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 25% 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。"
  },
  Skill_130506_Name = {
    Text = "豪赌的智慧"
  },
  Skill_130507_Desc = {
    Text = "将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 13% 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。"
  },
  Skill_130507_Name = {
    Text = "豪赌的智慧"
  },
  Skill_130508_Desc = {
    Text = "将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 17% 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。"
  },
  Skill_130508_Name = {
    Text = "豪赌的智慧"
  },
  Skill_130509_Desc = {
    Text = "将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 21% 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。"
  },
  Skill_130509_Name = {
    Text = "豪赌的智慧"
  },
  Skill_130513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，随机触发以下效果中的一个：获得 <Energy:[Energy:Arg1]> 狂气并<PVPSlowKeywords:迟缓>自身；获得 <Energy:[Energy:Arg3]> 狂气；获得 <Energy:[Energy:Arg4]> 和 [Arg5] 张<PVPDerivativeCardKeywords_17:「灵感」>。"
  },
  Skill_130513_Name_1 = {
    Text = "豪赌的智慧"
  },
  Skill_130928_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。若未造成击杀，获得 [Arg2] 层<PVPWaterPowerKeyWords:涡流>。"
  },
  Skill_130928_Name_1 = {
    Text = "深渊！漩涡！大轰炸！"
  },
  Skill_130929_AwakerSkillBackgroundStory = {
    Text = "活泼地挥动骇人巨炮，蹦蹦跳跳地进入战场。\n不在乎烦恼，不在乎危险，因为这些与朋友相比，是那么微不足道。\n「朋友，麻烦！莫丝，登场！」"
  },
  Skill_130929_BattleDesc_0 = {
    Text = "莫丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：抽 1 张「装填！」。莫丝释放追击后下次莫丝狂气爆发额外享受 [Arg2]％ 触腕伤害加成，最多叠加 [Arg3] 次。"
  },
  Skill_130929_BattleDesc_15 = {
    Text = "莫丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：抽 1 张「装填！」。莫丝释放追击后下次莫丝狂气爆发额外享受 [Arg2]％ 触腕伤害加成，并使下次狂气爆发对生命最高敌人造成 [Arg4]％ 最大生命的<FixedDamage:纯粹伤害>，最多叠加 [Arg3] 次。"
  },
  Skill_130929_Desc_0 = {
    Text = "莫丝获得 [Arg5]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：抽 1 张「装填！」。莫丝释放追击后下次莫丝狂气爆发额外享受 [Arg2]％ 触腕伤害加成，最多叠加 [Arg3] 次。"
  },
  Skill_130929_Desc_15 = {
    Text = "莫丝获得 [Arg5]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：抽 1 张「装填！」。莫丝释放追击后下次莫丝狂气爆发额外享受 [Arg2]％ 触腕伤害加成，并使下次狂气爆发对生命最高敌人造成 [Arg4]％ 最大生命的<FixedDamage:纯粹伤害>，最多叠加 [Arg3] 次。"
  },
  Skill_130929_EffectNameList = {
    Text = "狂气,触腕伤害加成"
  },
  Skill_130929_Name = {
    Text = "漩涡来了！"
  },
  Skill_130929_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2％"
  },
  Skill_130930_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Block:[Block:Arg1]> 护盾和<DelayKeywords:延迟 1>：<Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_130930_Name_1 = {
    Text = "渺远的伊甸园"
  },
  Skill_130931_AwakerSkillBackgroundStory = {
    Text = "漩涡带来破坏，深渊带来毁灭。\n向往友情与阳光的少女终究还是回归了永恒的孤寂。\n哭喊、哀嚎、扭曲、崩溃，是她身处默斯克斯时的往复循环。\n这是默斯克斯下的深渊吞噬一切的咆哮。\n亦是莫丝战胜祂的证明。"
  },
  Skill_130931_BattleDesc_0 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。"
  },
  Skill_130931_BattleDesc_1 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通。"
  },
  Skill_130931_BattleDesc_3 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。"
  },
  Skill_130931_Desc_0 = {
    Text = "驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。对所有敌人造成  [Arg7]％ <TentacleInjurieIconKeywords:触腕伤害>加成的伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕，每条使本次狂气爆发暴击伤害 +50％。"
  },
  Skill_130931_Desc_1 = {
    Text = "驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。对所有敌人造成 [Arg7]％ <TentacleInjurieIconKeywords:触腕伤害>加成的伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕，每条使本次狂气爆发暴击伤害 +50％。获得 [Arg6] 点界域精通。"
  },
  Skill_130931_Desc_3 = {
    Text = "驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。对所有敌人造成 [Arg7]％ <TentacleInjurieIconKeywords:触腕伤害>加成的伤害，对生命最高敌人造成三倍伤害。牺牲至多 3 条额外的永久触腕，每条使本次狂气爆发暴击伤害 +50％。获得 [Arg6] 点界域精通，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。"
  },
  Skill_130931_EffectNameList = {
    Text = "触腕伤害加成"
  },
  Skill_130931_Name = {
    Text = "深渊！漩涡！炮！"
  },
  Skill_130931_OverLimitUtlSkillDesc = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +100％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  Skill_130931_PropertyNameList = {
    Text = "$GrowValue1％"
  },
  Skill_130931_tempBattleDesc_1 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。"
  },
  Skill_130931_tempBattleDesc_2 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通。"
  },
  Skill_130931_tempBattleDesc_3 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。"
  },
  Skill_130931_tempBattleDesc_4 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害和 [Arg9]％ 最大生命的<FixedDamage:纯粹伤害>。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +50％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_1 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +100％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_2 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成双倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +100％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_3 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +100％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通，每消耗 20 点狂气就使其他唤醒体获得 1 点狂气。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  Skill_130931_tempOverLimitUtlSkillDesc_4 = {
    Text = "驱散所有手中卡牌的<BurningKeywords:燃烧>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，对生命最高敌人造成三倍伤害和 [Arg9]％ 最大生命的<FixedDamage:纯粹伤害>。牺牲至多 3 条额外的永久触腕( [Arg4] 条)，每条使本次狂气爆发暴击伤害 +100％(当前暴击率: [Arg5]％。触腕伤害加成: [Arg8]％ )。获得 [Arg6] 点界域精通。接下来释放的 5 次「涡！流！弹！」生效 2 次。"
  },
  Skill_130932_AwakerSkillBackgroundStory = {
    Text = "「嘎吱，嘎吱……」\n狰狞的巨炮不断吞下湛蓝的涡流，发出并不存在的声响。\n每吞下一枚，怪物瞳孔中的猩红便加重一分。\n它等待着，等待着……\n等待它天真活泼的主人，下达命令的那一刻。"
  },
  Skill_130932_BattleDesc = {
    Text = "<DerivativeCardKeywords_132:>获得 1 层<WhirlpoolKeywords:涡流装填>，可使用 [Arg1] 次。"
  },
  Skill_130932_Desc = {
    Text = "<DerivativeCardKeywords_132:>获得 1 层<WhirlpoolKeywords:涡流装填>，可使用 3 次。"
  },
  Skill_130932_EffectNameList = {
    Text = "「涡！流！弹！」等级"
  },
  Skill_130932_Name = {Text = "装填！"},
  Skill_130932_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_130933_Desc = {
    Text = "所有敌人获得 25 层<ReinforcePVEKeywords:加固>。每回合抽牌数 -1。所有唤醒体造成护盾和回复生命提高 20%。"
  },
  Skill_130933_Name = {
    Text = "捋顺毛发"
  },
  Skill_130934_Desc_0 = {
    Text = "对生命最高的敌人造成 [Arg1] 点<RealDamage:固定伤害>，<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Desc_1 = {
    Text = "对生命最高的敌人造成 [Arg1] 点<RealDamage:固定伤害>和目标最大生命 [Float:Arg3]％ 的<FixedDamage:纯粹伤害>。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_130934_Name = {
    Text = "涡！流！弹！"
  },
  Skill_130935_AwakerSkillBackgroundStory = {
    Text = "「啪塔啪塔~打倒坏人~」"
  },
  Skill_130935_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_130935_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。莫丝下次狂气爆发暴击率 +[Arg3]％，下次「装填！」基础算力消耗降低 1。"
  },
  Skill_130935_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莫丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_130935_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莫丝获得 <Energy:[Energy:Arg2]> 点狂气。莫丝下次狂气爆发暴击率 +[Arg3]％，下次「装填！」基础算力消耗降低 1。"
  },
  Skill_130935_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_130935_Name = {Text = "打击"},
  Skill_130935_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_130936_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：<Energy:[Energy:Arg1]> 狂气。直到下回合开始，失去生命后将等量的延迟狂气转化为护盾。"
  },
  Skill_130936_Name_1 = {
    Text = "漩流护身"
  },
  Skill_130937_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_130937_Name_1 = {Text = "打击"},
  Skill_130938_AwakerSkillBackgroundStory = {
    Text = "「唰啦唰啦~保护朋友~」"
  },
  Skill_130938_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_130938_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。莫丝下次狂气爆发暴击率 +[Arg3]％，下次「装填！」基础算力消耗降低 1。"
  },
  Skill_130938_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莫丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_130938_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莫丝获得 <Energy:[Energy:Arg2]> 点狂气。莫丝下次狂气爆发暴击率 +[Arg3]％，下次「装填！」基础算力消耗降低 1。"
  },
  Skill_130938_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_130938_Name = {Text = "防御"},
  Skill_130938_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_130939_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，升级为<PVPDerivativeCardKeywords_27:「深渊！漩涡！二式！」>。若未造成击杀，获得 [Arg2] 层<PVPWaterPowerKeyWords:涡流>。<PVPDerivativeCardKeywords_28:>"
  },
  Skill_130939_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>，升级为<PVPDerivativeCardKeywords_28:「深渊！漩涡！大轰炸！」>。若未造成击杀，获得 [Arg2] 层<PVPWaterPowerKeyWords:涡流>。"
  },
  Skill_130939_Desc_3 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。若未造成击杀，获得 [Arg2] 层<PVPWaterPowerKeyWords:涡流>。"
  },
  Skill_130939_Name_1 = {
    Text = "深渊！漩涡！炮！"
  },
  Skill_130939_Name_2 = {
    Text = "深渊！漩涡！二式！"
  },
  Skill_130939_Name_3 = {
    Text = "深渊！漩涡！大轰炸！"
  },
  Skill_130940_Desc = {
    Text = "移除所有敌人<ReinforcePVEKeywords:加固>。回复已损失生命值的 50% 的生命，将所有的唤醒体的狂气填充至最大值。本回合所有唤醒体能释放两次狂气爆发。"
  },
  Skill_130940_Name = {
    Text = "二世冲击！"
  },
  Skill_130941_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次打出「技能」后对<HPAndShieldMin:生命与护盾最低>的敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_130941_Name_1 = {
    Text = "被囚禁的疯狂"
  },
  Skill_130942_AwakerSkillBackgroundStory = {
    Text = "自从在一次实验中，莫丝学会了积蓄力量的方法后，其造成的破坏就开始成倍上升。\n因此，当莫丝身边开始出现不正常的湿潮时，请立刻与敌人拉开距离。\n用莫丝本人的话说就是——「先蓄力，再发射，威力大！」。"
  },
  Skill_130942_Desc = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气，下次莫丝狂气爆发暴击率 +[Arg2]％。<RippleKeywords:余波>：其他唤醒体获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_130942_EffectNameList = {
    Text = "狂气,暴击率"
  },
  Skill_130942_Name = {Text = "蓄力！"},
  Skill_130942_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2％"
  },
  Skill_130943_Desc = {
    Text = "所有敌人获得 25 层<ReinforcePVEKeywords:加固>。银钥能量上限及钥令消耗银钥能量 +350。每回合首次钥令生效 2 次。"
  },
  Skill_130943_Name = {
    Text = "投喂零食"
  },
  Skill_130944_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_130944_Name_1 = {Text = "波动弹"},
  Skill_130945_Desc = {
    Text = "所有敌人获得 25 层<ReinforcePVEKeywords:加固>。所有唤醒体基础狂气提高 10 点。释放狂气爆发后获得 1 算力，每个唤醒体 1 回合只能触发 1 次。"
  },
  Skill_130945_Name = {
    Text = "蹭蹭脸颊"
  },
  Skill_130946_Desc_1 = {
    Text = "全体友方获得 [Arg1] <PVPWaterPowerKeyWords:涡流> 和<DelayKeywords:延迟 1>：[Arg2] 狂气。"
  },
  Skill_130946_Name_1 = {
    Text = "溺亡的纯真"
  },
  Skill_130946_UnknownName = {
    Text = "溺亡的纯真"
  },
  Skill_130947_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>，升级为<PVPDerivativeCardKeywords_28:「深渊！漩涡！大轰炸！」>。若未造成击杀，获得 [Arg2] 层<PVPWaterPowerKeyWords:涡流>。"
  },
  Skill_130947_Name_1 = {
    Text = "深渊！漩涡！二式！"
  },
  Skill_130948_Desc_1 = {
    Text = "获得 [Arg1] 层<PVPWaterPowerKeyWords:涡流>并将 [Arg2] 张<PVPDerivativeCardKeywords_26:「波动弹」>置入手牌。"
  },
  Skill_130948_Name_1 = {
    Text = "潆洄波动"
  },
  Skill_131102_Desc = {
    Text = "为随机手中 2 张指令卡赋予「<Chapter5_Monster_Support1:繁育之理>」刻印。"
  },
  Skill_131102_Name = {
    Text = "繁育之理"
  },
  Skill_131114_Desc = {
    Text = "为随机手中 2 张指令卡赋予「<Chapter5_Monster_Support2:智识之理>」刻印。"
  },
  Skill_131114_Name = {
    Text = "智识之理"
  },
  Skill_131115_Desc = {
    Text = "为随机手中 2 张指令卡赋予「<Chapter5_Monster_Support3:欢愉之理>」刻印。"
  },
  Skill_131115_Name = {
    Text = "欢愉之理"
  },
  Skill_131192_Desc = {
    Text = "使手中所有带有<ErosionColorInkKeywords:认知错乱>的卡牌算力消耗 -1，每有 1 张使狂气最低的唤醒体获得 <Energy:5> 点狂气，之后还原各处带有<ErosionColorInkKeywords:认知错乱>的卡牌。本回合打出卡牌后不再为其他卡牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_131192_Name = {
    Text = "禁忌真相"
  },
  Skill_131241_Desc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、[Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_131241_Name = {
    Text = "七彩大炮β"
  },
  Skill_131365_Desc = {
    Text = "对敌人造成生命百分比伤害，并击碎其超维空间。"
  },
  Skill_131365_Name = {
    Text = "命缕各安其位"
  },
  Skill_131438_Desc = {
    Text = "抽牌阶段后若在手中，从手牌中的随机 2 张指令中选择 1 张强制打出,并使其生效 2 次。\n打出后，下张指令卡算力消耗降低为 0，打出的指令卡额外生效 2 次。打出 [Arg1] 次后消耗（[Arg2]/[Arg1]）。"
  },
  Skill_131438_Name = {
    Text = "提线木偶"
  },
  Skill_131654_Desc = {
    Text = "打出后，清除指定唤醒体的狂气值，然后使其获得1倍基础狂气的狂气值。"
  },
  Skill_131654_Name = {
    Text = "狂气重盈1倍"
  },
  Skill_131786_Desc = {
    Text = "打出后，对随机目标造成 [Damage:Arg1] 点伤害，其他敌方造成 [Damage:Arg2] 点伤害。"
  },
  Skill_131786_Name = {
    Text = "目标测试"
  },
  Skill_131856_AwakerSkillBackgroundStory = {
    Text = "眼睛、耳朵、舌头、皮肤、大脑，遍布全身的感觉。\n被分享的爱和温柔，会永远围绕着你，直到死为止——"
  },
  Skill_131856_BattleDesc_0 = {
    Text = "沙耶获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后为各处其他唤醒体不具有「<DestructionKeywords:销毁>」的指令卡附加<ErosionColorInkKeywords:认知错乱>。每回合前 3 次打出带有<ErosionColorInkKeywords:认知错乱>的指令卡使沙耶和该指令卡所属唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131856_BattleDesc_15 = {
    Text = "沙耶获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，沙耶获得 <Energy:[Energy:Arg4]> 点狂气和 1 层<KaiHuajishu:羽种>，为各处其他唤醒体不具有「<DestructionKeywords:销毁>」的指令卡附加<ErosionColorInkKeywords:认知错乱>。每回合前 3 次打出带有<ErosionColorInkKeywords:认知错乱>的指令卡使沙耶和该指令卡所属唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131856_Desc_0 = {
    Text = "沙耶获得 [Arg3]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后为各处其他唤醒体不具有「<DestructionKeywords:销毁>」的指令卡附加<ErosionColorInkKeywords:认知错乱>。每回合前 3 次打出带有<ErosionColorInkKeywords:认知错乱>的指令卡使沙耶和该指令卡所属唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131856_Desc_15 = {
    Text = "沙耶获得 [Arg3]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，沙耶获得 <Energy:[Energy:Arg4]> 点狂气和 1 层<KaiHuajishu:羽种>，为各处其他唤醒体不具有「<DestructionKeywords:销毁>」的指令卡附加<ErosionColorInkKeywords:认知错乱>。每回合前 3 次打出带有<ErosionColorInkKeywords:认知错乱>的指令卡使沙耶和该指令卡所属唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131856_EffectNameList = {
    Text = "狂气,额外狂气"
  },
  Skill_131856_Name = {
    Text = "认知改造"
  },
  Skill_131856_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2"
  },
  Skill_131857_AwakerSkillBackgroundStory = {
    Text = "在抵达那个一直追寻的世界，不用再东躲西藏的世界之前。\n所有挡在路途上的，都是应该打倒的「敌人」。"
  },
  Skill_131857_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131857_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131857_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。沙耶获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131857_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。沙耶获得 <Energy:[Energy:Arg2]> 点狂气。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]，当前生命越低效果越高，至多提高 100%"
  },
  Skill_131857_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_131857_Name = {Text = "打击"},
  Skill_131857_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_131858_AwakerSkillBackgroundStory = {
    Text = "恐怖的、美丽的、绝望的，在「爱」的侵染下，那闪耀的生命歌咏着盛开。\n这是宣告新世界揭幕、奏响旧世界灭亡的歌。"
  },
  Skill_131858_BattleDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：随机 2 张复制的「基础打击」或「基础防御」的算力消耗变为 0 并额外生效 1 次。】获得 <Block:[Block:Arg1]> 点护盾。选择一名其他唤醒体，生成其所有基础指令卡的各 1 份原始复制分别置入抽牌堆和弃牌堆，附加<NothingnessIconKeywords:虚无>和<DestructionKeywords:销毁>。消耗所有<KaiHuajishu:羽种>，每消耗 1 层使其中随机 1 张「技能」算力消耗变为 0。"
  },
  Skill_131858_Desc = {
    Text = "【<DevouredIconKeywords:吞噬> ：随机 2 张复制的「基础打击」或「基础防御」的算力消耗变为 0 并额外生效 1 次。】获得 <Block:[Block:Arg1]> 点护盾。选择一名其他唤醒体，生成其所有基础指令卡的各 1 份原始复制分别置入抽牌堆和弃牌堆，附加<NothingnessIconKeywords:虚无>和<DestructionKeywords:销毁>。消耗所有<KaiHuajishu:羽种>，每消耗 1 层使其中随机 1 张「技能」算力消耗变为 0。"
  },
  Skill_131858_EffectNameList = {Text = "护盾"},
  Skill_131858_Name = {
    Text = "沙耶之歌"
  },
  Skill_131858_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：随机 2 张复制的「基础打击」或「基础防御」的算力消耗变为 0 并额外生效 1 次。】获得 <Block:[Block:Arg1]> 点护盾。选择一名其他唤醒体，生成其所有基础指令卡的各 1 份原始复制分别置入抽牌堆和弃牌堆，附加<NothingnessIconKeywords:虚无>和<DestructionKeywords:销毁>，使复制的所有「技能」额外生效 1 次。消耗所有<KaiHuajishu:羽种>，每消耗 1 层使其中随机 1 张「技能」算力消耗变为 0。"
  },
  Skill_131858_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_131860_AwakerSkillBackgroundStory = {
    Text = "该唤醒体保留了包括网状肌肉组织在内的，部分原种族特征。\n在受到打击的瞬间，肌肉组织可全方位伸缩，物理手段很难对其造成实质伤害。"
  },
  Skill_131860_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131860_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。"
  },
  Skill_131860_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。沙耶获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_131860_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。沙耶获得 <Energy:[Energy:Arg2]> 点狂气。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]，当前生命越低效果越高，至多提高 100%"
  },
  Skill_131860_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_131860_Name = {Text = "防御"},
  Skill_131860_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_131902_Desc = {
    Text = "打出后，打印出莫丝的狂气上限。"
  },
  Skill_131902_Name = {
    Text = "功能属性"
  },
  Skill_132227_Desc = {
    Text = "如果队伍中有神国深海唤醒体则 +1000力量，否则+1000衰竭"
  },
  Skill_132227_Name = {
    Text = "技能@测试@新深海职业判定测试"
  },
  Skill_132357_AwakerSkillBackgroundStory = {
    Text = "「看！奥瑞塔像鱼一样吐泡泡！」"
  },
  Skill_132357_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，并分别给自身、玩家、前排敌方添加状态。打出值、实际值各1遍。"
  },
  Skill_132357_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_132357_Name = {
    Text = "测·防御"
  },
  Skill_132357_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_132358_AwakerSkillBackgroundStory = {
    Text = "女孩怀着不舍离开了破产的水族馆，作为工作酬劳，她被允许把几只水母带回家。\n这是她最喜欢的小小生灵，浮游幻海之灵，生生不息之花。\n只要悉心照料，它们会填满整个水缸！——她曾经期待着这样的景象。"
  },
  Skill_132358_Desc_0 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。"
  },
  Skill_132358_Desc_15 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。奥瑞塔的「打击」变为穿刺伤害，并且额外造成 2 次伤害。"
  },
  Skill_132358_EffectNameList = {Text = "狂气"},
  Skill_132358_Name = {
    Text = "测·觉醒"
  },
  Skill_132358_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_132359_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132359_Desc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、施加 [Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 层 <CutKeywords:命运裁断>。"
  },
  Skill_132359_Name = {
    Text = "炫彩大招"
  },
  Skill_132359_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。获得 [Power:Arg2] 点 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>，之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  Skill_132360_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132360_Desc = {
    Text = "对前排敌方造成 [Arg1] 点普通固定伤害 [Arg2] 次。"
  },
  Skill_132360_Name = {
    Text = "测·折光"
  },
  Skill_132361_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有没有吓你一跳！」"
  },
  Skill_132361_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132361_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132361_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132361_Name = {
    Text = "测·打击"
  },
  Skill_132361_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132361_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132361_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132362_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132362_Desc = {
    Text = "对前排敌方造成 [Arg1] 点穿刺固定伤害 [Arg2] 次。"
  },
  Skill_132362_Name = {
    Text = "测·镜返"
  },
  Skill_132363_Desc_1 = {
    Text = "当前行动卡牌目标测试"
  },
  Skill_132363_Name_1 = {
    Text = "当前行动卡牌目标测试"
  },
  Skill_132425_AwakerSkillBackgroundStory = {
    Text = "女孩怀着不舍离开了破产的水族馆，作为工作酬劳，她被允许把几只水母带回家。\n这是她最喜欢的小小生灵，浮游幻海之灵，生生不息之花。\n只要悉心照料，它们会填满整个水缸！——她曾经期待着这样的景象。"
  },
  Skill_132425_Desc_0 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。"
  },
  Skill_132425_Desc_15 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。奥瑞塔的「打击」变为穿刺伤害，并且额外造成 2 次伤害。"
  },
  Skill_132425_EffectNameList = {Text = "狂气"},
  Skill_132425_Name = {
    Text = "测·觉醒"
  },
  Skill_132425_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_132426_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有没有吓你一跳！」"
  },
  Skill_132426_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132426_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132426_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132426_Name = {
    Text = "测·打击"
  },
  Skill_132426_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132426_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132426_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132427_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132427_Desc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、施加 [Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 层 <CutKeywords:命运裁断>。"
  },
  Skill_132427_Name = {
    Text = "测·折光"
  },
  Skill_132428_AwakerSkillBackgroundStory = {
    Text = "女孩怀着不舍离开了破产的水族馆，作为工作酬劳，她被允许把几只水母带回家。\n这是她最喜欢的小小生灵，浮游幻海之灵，生生不息之花。\n只要悉心照料，它们会填满整个水缸！——她曾经期待着这样的景象。"
  },
  Skill_132428_Desc_0 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。"
  },
  Skill_132428_Desc_15 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。奥瑞塔的「打击」变为穿刺伤害，并且额外造成 2 次伤害。"
  },
  Skill_132428_EffectNameList = {Text = "狂气"},
  Skill_132428_Name = {
    Text = "测·觉醒"
  },
  Skill_132428_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_132429_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而静谧的，它承载着对生的渴望与对死的恐惧。\n但偏偏有人要用欢笑与玩弄填满海洋——在奥瑞塔发出如此邀请时，「陪她闹一场又何妨」的感觉总会涌上心头，顺势让简单的快乐填满胸腔。"
  },
  Skill_132429_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_132429_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_132429_EffectNameList = {
    Text = "伤害,后续伤害提升"
  },
  Skill_132429_Name = {
    Text = "测·狂爆"
  },
  Skill_132429_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。获得 [Power:Arg2] 点 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>，之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  Skill_132429_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_132430_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而静谧的，它承载着对生的渴望与对死的恐惧。\n但偏偏有人要用欢笑与玩弄填满海洋——在奥瑞塔发出如此邀请时，「陪她闹一场又何妨」的感觉总会涌上心头，顺势让简单的快乐填满胸腔。"
  },
  Skill_132430_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_132430_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_132430_EffectNameList = {
    Text = "伤害,后续伤害提升"
  },
  Skill_132430_Name = {
    Text = "测·狂爆"
  },
  Skill_132430_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。获得 [Power:Arg2] 点 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>，之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  Skill_132430_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_132431_AwakerSkillBackgroundStory = {
    Text = "「看！奥瑞塔像鱼一样吐泡泡！」"
  },
  Skill_132431_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132431_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132431_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132431_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132431_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_132431_Name = {
    Text = "测·防御"
  },
  Skill_132431_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_132432_AwakerSkillBackgroundStory = {
    Text = "孩子们会慢慢看穿童话的本质，理解神话背后的寓言。在人类的语言中，这个过程被称为「长大」。\n但也有孩子会愈发相信睡前故事，他们固执地认为天上真的有彩虹桥，真的有文明沉没深海。\n奥瑞塔喜欢这些故事，她要向更多的伙伴分享这份快乐。"
  },
  Skill_132432_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_132432_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量+1 的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_132432_EffectNameList = {
    Text = "触腕伤害,「腺体分裂」等级"
  },
  Skill_132432_Name = {
    Text = "测·二技"
  },
  Skill_132432_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132433_AwakerSkillBackgroundStory = {
    Text = "世界上存在着一种特殊的水母，在受伤后，其脱落的组织能再次发育为完整的水螅体。\n「奥瑞塔也会生水母！所以奥瑞塔也是水母！」\n在孩子认知世界的这个阶段，还是不要扫她的兴吧。"
  },
  Skill_132433_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_132433_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_132433_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132433_Name = {
    Text = "测·一技"
  },
  Skill_132433_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132434_AwakerSkillBackgroundStory = {
    Text = "孩子们会慢慢看穿童话的本质，理解神话背后的寓言。在人类的语言中，这个过程被称为「长大」。\n但也有孩子会愈发相信睡前故事，他们固执地认为天上真的有彩虹桥，真的有文明沉没深海。\n奥瑞塔喜欢这些故事，她要向更多的伙伴分享这份快乐。"
  },
  Skill_132434_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_132434_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量+1 的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_132434_EffectNameList = {
    Text = "触腕伤害,「腺体分裂」等级"
  },
  Skill_132434_Name = {
    Text = "测·二技"
  },
  Skill_132434_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132435_AwakerSkillBackgroundStory = {
    Text = "女孩怀着不舍离开了破产的水族馆，作为工作酬劳，她被允许把几只水母带回家。\n这是她最喜欢的小小生灵，浮游幻海之灵，生生不息之花。\n只要悉心照料，它们会填满整个水缸！——她曾经期待着这样的景象。"
  },
  Skill_132435_Desc_0 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。"
  },
  Skill_132435_Desc_15 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。奥瑞塔的「打击」变为穿刺伤害，并且额外造成 2 次伤害。"
  },
  Skill_132435_EffectNameList = {Text = "狂气"},
  Skill_132435_Name = {
    Text = "测·觉醒"
  },
  Skill_132435_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_132436_AwakerSkillBackgroundStory = {
    Text = "「看！奥瑞塔像鱼一样吐泡泡！」"
  },
  Skill_132436_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132436_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132436_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132436_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132436_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_132436_Name = {
    Text = "测·防御"
  },
  Skill_132436_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_132437_AwakerSkillBackgroundStory = {
    Text = "「看！奥瑞塔像鱼一样吐泡泡！」"
  },
  Skill_132437_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132437_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132437_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132437_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132437_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_132437_Name = {
    Text = "测·防御"
  },
  Skill_132437_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_132438_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132438_Desc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、施加 [Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>、施加 [FateCut:Arg10] 层 <CutKeywords:命运裁断>。"
  },
  Skill_132438_Name = {
    Text = "炫彩大招"
  },
  Skill_132438_OverLimitUtlSkillDesc = {
    Text = "玩家获得 [Power:Arg1] 点<PowerIconKeywords:力量>、<Block:[Block:Arg2]>  点护盾、[Heal:Arg3] 点治疗、[TentaclePower:Arg4] 点<TentacleInjurieIconKeywords:触腕伤害>、[Counterattack:Arg5] 层 <RetaliateIconKeywords:反击>，对前排敌方造成 <Damage:[Damage:Arg6]> 点伤害 [Arg7] 次、[Poison:Arg8] 层<IntoxicationIconKeywords:中毒>、施加 [Exhaustion:Arg9] 层 <ExhaustionIconKeywords:衰竭>。"
  },
  Skill_132439_AwakerSkillBackgroundStory = {
    Text = "光之七彩，绚烂迷离~"
  },
  Skill_132439_Desc = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，并施加等量<IntoxicationIconKeywords:中毒>、等量<CutKeywords:命运裁断>，获得等量 <RetaliateIconKeywords:反击>。"
  },
  Skill_132439_Name = {
    Text = "测·镜返"
  },
  Skill_132440_AwakerSkillBackgroundStory = {
    Text = "世界上存在着一种特殊的水母，在受伤后，其脱落的组织能再次发育为完整的水螅体。\n「奥瑞塔也会生水母！所以奥瑞塔也是水母！」\n在孩子认知世界的这个阶段，还是不要扫她的兴吧。"
  },
  Skill_132440_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_132440_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_132440_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132440_Name = {
    Text = "测·一技"
  },
  Skill_132440_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132441_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有没有吓你一跳！」"
  },
  Skill_132441_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132441_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132441_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132441_Name = {
    Text = "测·打击"
  },
  Skill_132441_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132441_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132441_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132442_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有没有吓你一跳！」"
  },
  Skill_132442_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132442_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132442_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_132442_Name = {
    Text = "测·打击"
  },
  Skill_132442_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_132442_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132442_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_132494_Desc = {
    Text = "弃掉所有手牌，创建[Arg1]张牌 集合测试，取前[Arg2]张和后[Arg3]张的差集，为其附加消耗。"
  },
  Skill_132494_Name = {Text = "差集"},
  Skill_132495_Desc = {
    Text = "弃掉所有手牌，创建[Arg1]张牌 集合测试，取前[Arg2]张和后[Arg3]张的对称差，为其附加消耗。"
  },
  Skill_132495_Name = {Text = "对称差"},
  Skill_132496_Name = {
    Text = "集合测试"
  },
  Skill_132497_Desc = {
    Text = "弃掉所有手牌，创建[Arg1]张牌 集合测试，取前[Arg2]张和后[Arg3]张的并集，为其附加消耗。"
  },
  Skill_132497_Name = {Text = "并集"},
  Skill_132498_Desc = {
    Text = "弃掉所有手牌，创建[Arg1]张牌 集合测试，取前[Arg2]张和后[Arg3]张的交集，为其附加消耗。"
  },
  Skill_132498_Name = {Text = "交集"},
  Skill_132884_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] <StrongEffectKeywords:强效> ，其他友方狂气爆发后使其获得<PVPOneMeetingKeywords:一期一会>。"
  },
  Skill_132884_Name_1 = {
    Text = "樱花下的迷思"
  },
  Skill_133319_Desc_1 = {
    Text = "使一名友方的下一个技能算力消耗 -[Arg1]，损失 <Damage:[Arg2]> 生命。"
  },
  Skill_133319_Name_1 = {Text = "改写"},
  Skill_133322_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_133322_Name_1 = {Text = "打击"},
  Skill_133323_BattleDesc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg4]> 伤害，每损失 [Arg2] 生命伤害 +[Arg3] ，自身回复等量生命。"
  },
  Skill_133323_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，每损失 [Arg2] 生命伤害 +[Arg3] ，自身回复等量生命。"
  },
  Skill_133323_Name_1 = {Text = "掠夺"},
  Skill_133324_Desc_1 = {
    Text = "对敌方全体造成 <Damage:[Damage:Arg1]> 伤害并施加<PVPCognitiveDissonanceKeyWords:认知错乱>。"
  },
  Skill_133324_Name_1 = {
    Text = "沙耶之歌"
  },
  Skill_133325_BattleDesc_1 = {
    Text = "选择一名友方，使其获得 <Heal:[Heal:Arg4]> <PVPFeatheredSeedsKeyWords:羽种>和等量生命，每消耗 [Arg2] 算力，<PVPFeatheredSeedsKeyWords:羽种>和等量生命增加 [Arg3]。"
  },
  Skill_133325_Desc_1 = {
    Text = "选择一名友方，使其获得 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:羽种>和等量生命，每消耗 [Arg2] 算力，<PVPFeatheredSeedsKeyWords:羽种>和等量生命增加 [Arg3]。"
  },
  Skill_133325_Name_1 = {Text = "散播"},
  Skill_133346_Desc_1 = {
    Text = "造成<PVPSeriousInjuryKeywords:重创>，<PVPPenetrateKeywords:贯穿 1>，<DelayKeywords:延迟 1>：回复全体友方 <Heal:[Heal:Arg1]> 生命，<PVPSeriousInjuryKeywords:重创>每驱散 [Arg2] 护盾或<DelayKeywords:延迟 1>治疗，回复生命 +[Arg3]。"
  },
  Skill_133346_Name_1 = {
    Text = "献给新世界"
  },
  Skill_133346_UnknownName = {
    Text = "献给新世界"
  },
  Skill_133347_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：该命轮死亡后保留。装备者死亡时和死亡状态下的后续 [Arg2] 回合结束后，其他友方获得 <Heal:[Heal:Arg1]> <PVPFeatheredSeedsKeyWords:羽种>和生命。"
  },
  Skill_133347_Name_1 = {
    Text = "愿世界化作芬芳"
  },
  Skill_133348_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备后，无法识别装备者的「打击」、「技能」、「狂气爆发」描述，但每次伤害、护盾、治疗随机提升[Arg1]%~[Arg2]%。"
  },
  Skill_133348_Name_1 = {
    Text = "淤泥里的童话"
  },
  Skill_133365_AwakerSkillBackgroundStory = {
    Text = "她曾听过无数次丝线断裂的声音。\n一场未曾发生的重逢。一句未曾说出的告白。一位未曾降生的孩童。\n一段未能面世的音乐。一场未能胜利的战争。一个未能幸存的文明。\n丝线编织。丝线断裂。丝线重新汇入那张巨网。\n命运的神明早已知晓，没有什么会真正消亡，没有什么曾真正存在。"
  },
  Skill_133365_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，下次「永恒织造」会生成额外的「<DerivativeCardKeywords_138:牵丝引命>」置入抽牌堆和弃牌堆。"
  },
  Skill_133365_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_133365_Name = {
    Text = "缚命罗网"
  },
  Skill_133365_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_133366_AwakerSkillBackgroundStory = {
    Text = "自她诞生的第一天起，她便看到命运的丝线蔓延。\n沿着丝线的轨迹，她踏入门扉，领受她无尽的、属于囚徒的命运。\n丝线穿过名为摩伊赖的纺轮，穿过城墙与海峡，穿过誓言与谎言，穿过每一个以为自己正在做出选择的灵魂。\n在这自由的幻境里，纺轮转动，亘古不息。"
  },
  Skill_133366_Desc_0 = {
    Text = "对所有敌人造成 [FateCut:Arg1] 点<CutKeywords:命运裁断>，生成 1 张「<DerivativeCardKeywords_138:牵丝引命>」置入手中<SilkKeywords1:>"
  },
  Skill_133366_EffectNameList = {
    Text = "命运裁断"
  },
  Skill_133366_Name = {
    Text = "永恒织造"
  },
  Skill_133366_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_133366_tempBattleDesc_1 = {
    Text = "对所有敌人造成 [FateCut:Arg1] 点<CutKeywords:命运裁断>，生成 1 张「<DerivativeCardKeywords_138:牵丝引命>」置入手中。"
  },
  Skill_133366_tempBattleDesc_2 = {
    Text = "对所有敌人造成 [FateCut:Arg1] 点<CutKeywords:命运裁断>，生成 1 张「<DerivativeCardKeywords_138:牵丝引命>」置入手中，抽牌堆、弃牌堆。"
  },
  Skill_133381_Desc_0 = {
    Text = "获得 5 层临时<SingularityKeywords2:奇点棱镜>，对生命最低敌人造成 [FateCut:Arg2] 点<CutKeywords:命运裁断>。"
  },
  Skill_133381_Desc_3 = {
    Text = "获得 10 层临时<SingularityKeywords2:奇点棱镜>，对生命最低敌人造成 [FateCut:Arg2] 点<CutKeywords:命运裁断>。"
  },
  Skill_133381_Name = {
    Text = "无尽线缕"
  },
  Skill_133473_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机症状洗入对方抽牌堆。"
  },
  Skill_133473_Name = {
    Text = "黑死之吻"
  },
  Skill_133474_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机唤醒体附带<DepleteIconKeywords:消耗>的「打击」洗入对方抽牌堆。"
  },
  Skill_133474_Name = {
    Text = "幻毒侵蚀"
  },
  Skill_133715_Desc = {
    Text = "选择1名唤醒体，添加卡牌属性，传播到其所有当前及未来的卡牌。"
  },
  Skill_133715_Name = {
    Text = "卡牌属性传播"
  },
  Skill_133950_Desc = {
    Text = "从已解锁的 3 个随机钥令中选择 1 个立刻释放并生效 2 次，打出后永久变化为「<DerivativeCardKeywords_140:春之信>」。"
  },
  Skill_133950_Name = {
    Text = "一期一会"
  },
  Skill_133951_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，打出后永久变化为「<DerivativeCardKeywords_141:樱满开>」。"
  },
  Skill_133951_Name = {Text = "春之信"},
  Skill_133952_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，打出后永久变化为「<DerivativeCardKeywords_142:花吹雪>」。"
  },
  Skill_133952_Name = {Text = "樱满开"},
  Skill_133953_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，打出后永久变化为「<DerivativeCardKeywords_143:一期一会>」。"
  },
  Skill_133953_Name = {Text = "花吹雪"},
  Skill_134007_Desc = {
    Text = "打出后，多次强制所选唤醒体释放大招。"
  },
  Skill_134007_Name = {
    Text = "强制打出大招"
  },
  Skill_134008_Desc = {
    Text = "打出后，强制怪物打出当前意图。"
  },
  Skill_134008_Name = {
    Text = "强制打出意图"
  },
  Skill_134009_Desc = {
    Text = "打出后，多次强制打出手牌堆顶部的1张卡牌。"
  },
  Skill_134009_Name = {
    Text = "强制打出卡牌"
  },
  Skill_134010_Desc = {
    Text = "打出后，多次强制玩家释放钥令。"
  },
  Skill_134010_Name = {
    Text = "强制打出钥令"
  },
  Skill_134203_Desc = {
    Text = "临时暴击伤害 +70%。"
  },
  Skill_134203_Name = {
    Text = "私密午歇时间"
  },
  Skill_134204_Desc = {
    Text = "临时暴击伤害 +60%。"
  },
  Skill_134204_Name = {
    Text = "私密午歇时间"
  },
  Skill_134205_Desc = {
    Text = "临时暴击伤害 +80%。"
  },
  Skill_134205_Name = {
    Text = "私密午歇时间"
  },
  Skill_134206_Desc = {
    Text = "临时暴击伤害 +50%。"
  },
  Skill_134206_Name = {
    Text = "私密午歇时间"
  },
  Skill_134210_Desc = {
    Text = "释放所有觉醒"
  },
  Skill_134210_Name = {
    Text = "释放所有觉醒"
  },
  Skill_134212_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2]％ 临时伤害强效。若「阿拉克涅」在队伍中，抽 1 张「永恒织造」并使其算力消耗 -1。"
  },
  Skill_134212_Name = {
    Text = "罗网轮转"
  },
  Skill_134252_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后自身下一次造成的伤害翻倍。"
  },
  Skill_134252_Name_1 = {
    Text = "私密午歇时间"
  },
  Skill_138603_Desc = {
    Text = "对所有敌人造成 1% 最大生命伤害 3 次，击碎其超维空间，清空其中卡牌。"
  },
  Skill_138603_Name = {
    Text = "命缕各安其位"
  },
  Skill_138768_Desc = {
    Text = "配置立绘的测试卡牌。"
  },
  Skill_138768_Name = {
    Text = "追击测试"
  },
  Skill_138769_Desc = {
    Text = "用特定卡牌进行追击，播放那张卡的卡面。"
  },
  Skill_138769_Name = {
    Text = "追击测试"
  },
  Skill_138810_AwakerSkillBackgroundStory = {
    Text = "外貌更重要，或灵魂更重要？有答案，没有答案？\n在爱中挣扎的人如此迷茫着，将被卷入的牺牲品们，用满怀珍惜的心情，吞噬殆尽。"
  },
  Skill_138810_BattleDesc_0 = {
    Text = "失去 10%([Arg4]) 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>。弃掉所有指令卡，抽取相同数量( [Arg3] )张牌。"
  },
  Skill_138810_BattleDesc_1 = {
    Text = "失去 10%([Arg4]) 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>。弃掉所有指令卡，抽取相同数量( [Arg3] )张牌。"
  },
  Skill_138810_BattleDesc_3 = {
    Text = "失去 10%([Arg4]) 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>，额外施加目标 0.5％ 最大生命的<Corrosion:侵蚀>。弃掉所有指令卡，抽取 [Arg3] 张牌。"
  },
  Skill_138810_Desc_0 = {
    Text = "失去 10% 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>。弃掉所有指令卡，抽取相同数量的牌。"
  },
  Skill_138810_Desc_1 = {
    Text = "失去 10% 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>。弃掉所有指令卡，抽取相同数量的牌。"
  },
  Skill_138810_Desc_3 = {
    Text = "失去 10% 当前生命，对所有敌人造成 [Corrosion:Arg1] 点<Corrosion:侵蚀>，额外施加目标 0.5％ 最大生命的<Corrosion:侵蚀>。弃掉所有指令卡，抽取相同数量的牌。"
  },
  Skill_138810_EffectNameList = {Text = "侵蚀"},
  Skill_138810_Name = {
    Text = "肉脂烂漫"
  },
  Skill_138810_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_139862_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 2 张「技能」并赋予<ErosionColorInkKeywords:认知错乱>。若沙耶在队伍中，获得 1 层<KaiHuajishu:羽种>。"
  },
  Skill_139862_Name = {
    Text = "献给新世界"
  },
  Skill_140120_Desc_1 = {
    Text = "使一名目标获得 命途，依此谕示。"
  },
  Skill_140120_Name_1 = {
    Text = "命途，依此谕示"
  },
  Skill_140144_Desc_1 = {
    Text = "使一名目标获得 <ReinforceKeywords:痴醉>。"
  },
  Skill_140144_Name_1 = {Text = "痴醉"},
  Skill_140457_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和任意唤醒体释放「狂气爆发」后，自身获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_140457_Name_1 = {Text = "致群星"},
  Skill_140566_Desc = {
    Text = "打出后，获得测试用圣女作成（带30奇点信标）、测试用同伴的力量。"
  },
  Skill_140566_Name = {Text = "BIAV-25578"},
  Skill_140567_Desc = {
    Text = "打出后，获得测试用圣女作成、测试用同伴的力量（带30奇点信标）。"
  },
  Skill_140567_Name = {Text = "BIAV-25578"},
  Skill_140592_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆随机 2 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140598_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使抽牌堆随机 1 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使抽牌堆随机 1 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140601_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使抽牌堆随机 3 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140604_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>，使抽牌堆随机 1 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使抽牌堆随机 1 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<WeaknessIconKeywords:虚弱>，使抽牌堆随机 1 张牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_140665_Desc = {
    Text = "获得临时<SingularityKeywords2:奇点棱镜>并对生命最低敌人造成<CutKeywords:命运裁断>。"
  },
  Skill_140665_Name = {
    Text = "无尽线缕"
  },
  Skill_140666_Desc_1 = {
    Text = "使一名目标获得 认知错乱。"
  },
  Skill_140666_Name_1 = {
    Text = "认知错乱"
  },
  Skill_140680_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] <MaxHPKeywords:最大生命>，回合结束时回复 <Heal:[Heal:Arg2]> 生命，回复生命随装备者生命降低而提高，最多提升 [Arg3]%。"
  },
  Skill_140680_Name_1 = {
    Text = "梦游仙境"
  },
  Skill_140714_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次，获得 1 层<HungerKeywords:饥饿>。每造成 1 次未被格挡的伤害额外获得 1 层<HungerKeywords:饥饿>。"
  },
  Skill_140714_Name = {
    Text = "觅ｦ人良ﾋ"
  },
  Skill_140714_tempName_1 = {
    Text = "觅ｦ人良ﾋ"
  },
  Skill_140714_tempName_2 = {Text = "觅食"},
  Skill_140716_Desc = {
    Text = "驱散自身负面状态并获得「护食」状态：每回合开始时获得 1 层饥饿，造成未被格挡的伤害时获得最大生命值 2% 点护盾，适应的最高层数提高为 75。"
  },
  Skill_140716_Name = {Text = "兑A変ﾑ"},
  Skill_140716_tempName_1 = {Text = "兑A変ﾑ"},
  Skill_140716_tempName_2 = {Text = "蜕变"},
  Skill_140717_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加等量<BleedingIconKeywords:出血>。自身最大生命提高 5%，吞食玩家手中随机 1 张「技能」将其消耗。"
  },
  Skill_140717_Name = {
    Text = "扌京ﾃ喰ｨ"
  },
  Skill_140717_tempName_1 = {
    Text = "扌京ﾃ喰ｨ"
  },
  Skill_140717_tempName_2 = {Text = "掠食"},
  Skill_140765_Desc = {
    Text = "切换至该意图时，将自身的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>转移给敌人。若成功转移，回复 10% 已损失生命（<Heal:[Heal:Arg3]>），获得 1 层<HungerKeywords:饥饿>，否则造成 <Damage:[Damage:Arg1]> 点伤害并获得 2 层<HungerKeywords:饥饿>。"
  },
  Skill_140765_Name = {Text = "応ｸkQ"},
  Skill_140765_tempName_1 = {Text = "応ｸkQ"},
  Skill_140765_tempName_2 = {Text = "应激"},
  Skill_140766_Desc = {
    Text = "切换至该意图时，将自身的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>转移给敌人。若成功转移，回复 10% 已损失生命（<Heal:[Heal:Arg3]>），获得 1 层<HungerKeywords:饥饿>，否则造成 <Damage:[Damage:Arg1]> 点伤害并获得 2 层<HungerKeywords:饥饿>。"
  },
  Skill_140766_Name = {Text = "応ｸkQ"},
  Skill_140766_tempName_1 = {Text = "応ｸkQ"},
  Skill_140766_tempName_2 = {Text = "应激"},
  Skill_140767_Desc = {
    Text = "切换至该意图时，将自身的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>转移给敌人。若成功转移，回复 10% 已损失生命（<Heal:[Heal:Arg3]>），获得 1 层<HungerKeywords:饥饿>，否则造成 <Damage:[Damage:Arg1]> 点伤害并获得 2 层<HungerKeywords:饥饿>。"
  },
  Skill_140767_Name = {Text = "応ｸkQ"},
  Skill_140767_tempName_1 = {Text = "応ｸkQ"},
  Skill_140767_tempName_2 = {Text = "应激"},
  Skill_140829_Desc = {
    Text = "临时最终伤害 +[Arg1]%，并对所有敌人造成 [Arg2]% 最大生命的侵蚀。"
  },
  Skill_140829_Name = {Text = "猎取"},
  Skill_140830_Desc = {
    Text = "选择<Pangtuosihuodong_Defend:「护卫」>或<Pangtuosihuodong_Attack:「猎取」>。"
  },
  Skill_140830_Name = {Text = "驭魇"},
  Skill_140831_Desc = {
    Text = "所有敌人本回合造成的伤害降低 [Arg1]%，获得 [Arg2] 点力量。"
  },
  Skill_140831_Name = {Text = "护卫"},
  Skill_140849_Desc = {
    Text = "装备者获得 <Energy:[Arg1]> 点狂气与<Yishiganshe:「意识干涉」>。"
  },
  Skill_140849_Name = {
    Text = "梦游仙境"
  },
  Skill_140850_Desc = {
    Text = "装备者获得 <Energy:[Arg1]> 点狂气与<Yishiganshe:「意识干涉」>。"
  },
  Skill_140850_Name = {
    Text = "梦游仙境"
  },
  Skill_140851_Desc = {
    Text = "装备者获得 <Energy:[Arg1]> 点狂气与<Yishiganshe:「意识干涉」>。"
  },
  Skill_140851_Name = {
    Text = "梦游仙境"
  },
  Skill_140852_Desc = {
    Text = "装备者获得 <Energy:[Arg1]> 点狂气与<Yishiganshe:「意识干涉」>。"
  },
  Skill_140852_Name = {
    Text = "梦游仙境"
  },
  Skill_141020_Desc_1 = {
    Text = "添加一个测试用的状态。"
  },
  Skill_141020_Name_1 = {
    Text = "添加状态"
  },
  Skill_141058_AwakerSkillBackgroundStory = {
    Text = "极致的好奇心和极强的学习能力，使沙耶在模仿人类的过程中，获得了与人类少女过于相似的灵魂。\n她因此变得更加孤独，也为此变得无比幸福。"
  },
  Skill_141058_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。获得 1 层<KaiHuajishu:羽种>。"
  },
  Skill_141058_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，当前生命越低效果越高，至多提高 100%。获得 1 层<KaiHuajishu:羽种>。"
  },
  Skill_141058_EffectNameList = {
    Text = "胚胎融合"
  },
  Skill_141058_Name = {
    Text = "生物拟态"
  },
  Skill_141058_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_141947_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备和回合结束时，<PVPDiscoveryKeyWords:发现> [Arg1] 张附加<PVPVoidKeywords:虚无>的「技能」并置入手中。"
  },
  Skill_141947_Name_1 = {
    Text = "向上坠落"
  },
  Skill_142022_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。移除自身负面状态，并获得「圣洁之翼」：永久使自身回合所受伤害降低 10%。"
  },
  Skill_142022_Name = {
    Text = "圣洁之翼"
  },
  Skill_142023_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142023_Name = {
    Text = "四翼渐生"
  },
  Skill_142024_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 3 层<ResentChainsKeywords:怨恨锁链>。切换至该意图时，封印一名狂气最高唤醒体的狂气爆发和所有指令卡 1 回合。"
  },
  Skill_142024_Name = {
    Text = "四翼渐生-封锁"
  },
  Skill_142025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。所有唤醒体当前狂气减半。"
  },
  Skill_142025_Name = {
    Text = "四翼渐生-冷寂"
  },
  Skill_142026_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_142026_Name = {Text = "展翼"},
  Skill_142027_Desc = {
    Text = "将 1 张「融蚀之芯」置入抽牌堆。使自身的技能获得强化。"
  },
  Skill_142027_Name = {
    Text = "门扉洞开"
  },
  Skill_142028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<HeavyInjuryKeywords:重创>。切换至该意图时，施加 1 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_142028_Name = {
    Text = "双翼初张-重创"
  },
  Skill_142029_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_142029_Name = {
    Text = "双翼初张-虚弱"
  },
  Skill_142030_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142030_Name = {
    Text = "双翼初张"
  },
  Skill_142031_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142031_Name = {
    Text = "六翼满开"
  },
  Skill_142032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_142032_Name = {
    Text = "双翼初张-重创"
  },
  Skill_142033_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。移除敌方 50% 的永久力量、永久反击、永久触腕伤害，并造成「诅咒之翼」：永久使造成的力量、反击、触腕伤害降低 10%。"
  },
  Skill_142033_Name = {
    Text = "诅咒之翼"
  },
  Skill_142034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142034_Name = {
    Text = "六翼满开"
  },
  Skill_142035_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对各处指令卡中的半数施加 1 层<SlowIconKeywords:迟缓>。切换至该意图时，对手牌中的半数指令卡施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_142035_Name = {
    Text = "四翼渐生-迟缓"
  },
  Skill_142036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<WeaknessIconKeywords:虚弱>。切换至该意图时，施加 1 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_142036_Name = {
    Text = "双翼初张-虚弱"
  },
  Skill_142037_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<FragileIconKeywords:脆弱>。"
  },
  Skill_142037_Name = {
    Text = "双翼初张-脆弱"
  },
  Skill_142038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对生命越低的敌人伤害越高，最多提升 100%。"
  },
  Skill_142038_Name = {
    Text = "六翼满开-弥留低语"
  },
  Skill_142039_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<FragileIconKeywords:脆弱>。切换至该意图时，施加 1 层<FragileIconKeywords:脆弱>。"
  },
  Skill_142039_Name = {
    Text = "双翼初张-脆弱"
  },
  Skill_142040_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。移除敌方 25% 的当前伤害强效，并造成「衰弱之翼」：永久使造成的基础伤害、中毒、反击降低 10%。"
  },
  Skill_142040_Name = {
    Text = "污秽之翼"
  },
  Skill_142041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 3 层<ResentChainsKeywords:怨恨锁链>。"
  },
  Skill_142041_Name = {
    Text = "四翼渐生-封锁"
  },
  Skill_142042_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每段额外造成目标当前生命 5% 伤害。"
  },
  Skill_142042_Name = {
    Text = "六翼满开-盈星之陨"
  },
  Skill_142043_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142043_Name = {
    Text = "双翼初张"
  },
  Skill_142044_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每段额外造成目标当前生命 5% 伤害。 切换至该意图时，本回合免疫负面状态。"
  },
  Skill_142044_Name = {
    Text = "六翼满开-盈星之陨"
  },
  Skill_142045_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对各处指令卡中的半数施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_142045_Name = {
    Text = "四翼渐生-迟缓"
  },
  Skill_142046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对生命越低的敌人伤害越高，最多提升 100%。切换至该意图时，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_142046_Name = {
    Text = "六翼满开-弥留低语"
  },
  Skill_142047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成伤害提高 100%，但本回合自身每受到 2% 最大生命的伤害该效果就降低 10%，最多降低 50%。"
  },
  Skill_142047_Name = {
    Text = "六翼满开-二重启示"
  },
  Skill_142048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。所有唤醒体当前狂气减半。切换至该意图时，所有唤醒体失去 25 点狂气。"
  },
  Skill_142048_Name = {
    Text = "四翼渐生-冷寂"
  },
  Skill_142049_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成伤害提高 100%，但本回合自身每受到 2% 最大生命的伤害该效果就降低 10%，最多降低 50%。  切换至该意图时，获得最大生命 10% 的护盾。"
  },
  Skill_142049_Name = {
    Text = "六翼满开-二重启示"
  },
  Skill_142050_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_142050_Name = {
    Text = "四翼渐生"
  },
  Skill_142449_Desc_1 = {
    Text = "是什么呢？"
  },
  Skill_142449_Name_1 = {Text = "宝藏"},
  Skill_142449_UnknownName = {Text = "宝藏"},
  Skill_142686_Desc_1 = {
    Text = "让目标命轮永久失效，再次使用解除。"
  },
  Skill_142686_Name_1 = {
    Text = "超级缠绕"
  },
  Skill_142689_Desc_1 = {
    Text = "给目标装备一个命轮。"
  },
  Skill_142689_Name_1 = {
    Text = "装备命轮"
  },
  Skill_142695_AwakerSkillBackgroundStory = {
    Text = "他留住了所有至亲至爱最鲜活有趣的部分，他给予所有敌人最惨烈漫长的折磨。\n每个觥筹交错的夜晚，他大笑着落入一片空躯壳组成的海洋。"
  },
  Skill_142695_BattleDesc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg2]％ 触腕伤害的<RealDamage:固定伤害>( [Arg3] )，若将其击杀生成 1 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。"
  },
  Skill_142695_Desc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg8] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg2]％ 触腕伤害的<RealDamage:固定伤害>，若将其击杀生成 1 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。"
  },
  Skill_142695_EffectNameList = {
    Text = "临时力量降低,触腕伤害加成,囚魇等级"
  },
  Skill_142695_Name = {
    Text = "无休猎宴"
  },
  Skill_142695_OverLimitUtlSkillDesc = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg6]％ 触腕伤害的<RealDamage:固定伤害>( [Arg7] )，若将其击杀生成 2 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。使各处「囚魇」算力消耗 -1。"
  },
  Skill_142695_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,$GrowValue3"
  },
  Skill_142695_tempBattleDesc_1 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg2]％ 触腕伤害的<RealDamage:固定伤害>( [Arg3] )，若将其击杀生成 1 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。"
  },
  Skill_142695_tempBattleDesc_2 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg2]％ 触腕伤害的<RealDamage:固定伤害>( [Arg3] )，若将其击杀生成 1 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。获得 [Arg5] 层<BattueKeywords:围猎>。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_1 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg6]％ 触腕伤害的<RealDamage:固定伤害>( [Arg7] )，若将其击杀生成 2 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。使各处「囚魇」算力消耗 -1。"
  },
  Skill_142695_tempOverLimitUtlSkillDesc_2 = {
    Text = "移除自身 <ExhaustionIconKeywords:力量降低>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。对生命最低的敌人造成等同于 [Arg6]％ 触腕伤害的<RealDamage:固定伤害>( [Arg7] )，若将其击杀生成 2 张永久「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中，每场战斗最多生成 3 张永久「囚魇」。使各处「囚魇」算力消耗 -1。获得 [Arg5] 层<BattueKeywords:围猎>。"
  },
  Skill_142696_AwakerSkillBackgroundStory = {
    Text = "「向我祈祷，我会给予你如愿的死亡。」"
  },
  Skill_142696_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_142696_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次使用时，抽 1 张「囚魇」( [Arg3]/1 )。"
  },
  Skill_142696_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。庞托斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_142696_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。庞托斯获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次使用时，抽 1 张「囚魇」。"
  },
  Skill_142696_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_142696_Name = {Text = "打击"},
  Skill_142696_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_142699_AwakerSkillBackgroundStory = {
    Text = "「在厄波扬斯酣睡，在厄波扬斯痛饮，在那亘久的、古老的，深渊之源。」"
  },
  Skill_142699_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_142699_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次使用时，抽 1 张「囚魇」( [Arg3]/1 )。"
  },
  Skill_142699_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。庞托斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_142699_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。庞托斯获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次使用时，抽 1 张「囚魇」。"
  },
  Skill_142699_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_142699_Name = {Text = "防御"},
  Skill_142699_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_142700_AwakerSkillBackgroundStory = {
    Text = "「你想要什么？」\n力量、秩序、失而复得、以血洗仇……\n他陷入长久而阴沉的缄默，可他其实早就有了答案，一个无解的答案。\n他想要太阳东升西落，他要一切如常。"
  },
  Skill_142700_BattleDesc_0 = {
    Text = "庞托斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：牌库中每有 3 张「囚魇」，「无休猎宴」就额外获得 1 层<BattueKeywords:围猎>。每打出 1 张庞托斯的卡牌，下次「无休猎宴」临时力量降低效果提高 [Arg3]％，每回合至多触发 3 次。"
  },
  Skill_142700_BattleDesc_15 = {
    Text = "庞托斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：牌库中每有 2 张「囚魇」，「无休猎宴」就额外获得 1 层<BattueKeywords:围猎>。每打出 1 张庞托斯的卡牌，下次「无休猎宴」临时力量降低效果提高 [Arg3]％，每回合至多触发 3 次。每回合首次「打击」和首次「防御」额外获得 <Energy:[Energy:Arg4]> 点狂气"
  },
  Skill_142700_Desc_0 = {
    Text = "庞托斯获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：牌库中每有 3 张「囚魇」，「无休猎宴」就获得 1 层<BattueKeywords:围猎>。每打出 1 张庞托斯的卡牌，下次「无休猎宴」临时力量降低效果提高 [Arg3]％，每回合至多触发 3 次。"
  },
  Skill_142700_Desc_15 = {
    Text = "庞托斯获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：牌库中每有 2 张「囚魇」，「无休猎宴」就获得 1 层<BattueKeywords:围猎>。每打出 1 张庞托斯的卡牌，下次「无休猎宴」临时力量降低效果提高 [Arg3]％，每回合至多触发 3 次。每回合首次「打击」和首次「防御」额外获得 <Energy:[Energy:Arg4]> 点狂气"
  },
  Skill_142700_EffectNameList = {Text = "狂气"},
  Skill_142700_Name = {
    Text = "囚渊的怒仇"
  },
  Skill_142700_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_142802_Desc = {
    Text = "装备者获得 <Yellow:[Arg1]> 点固定狂气并移除各处指令卡的<ErosionColorInkKeywords:认知错乱>效果。"
  },
  Skill_142802_Name = {
    Text = "向上坠落"
  },
  Skill_142803_BattleDesc = {
    Text = "对所有敌人造成 [Arg1] 点以及其最大生命 1% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace24:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142803_Desc = {
    Text = "对所有敌人造成装备者攻击力 3000% 以及其最大生命 1% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace24:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142803_Name = {
    Text = "涉足人间"
  },
  Skill_142804_Desc = {
    Text = "装备者获得 <Yellow:[Arg1]> 点固定狂气并移除各处指令卡的<ErosionColorInkKeywords:认知错乱>效果。"
  },
  Skill_142804_Name = {
    Text = "向上坠落"
  },
  Skill_142805_Desc = {
    Text = "装备者获得 <Yellow:[Arg1]> 点固定狂气并移除各处指令卡的<ErosionColorInkKeywords:认知错乱>效果。"
  },
  Skill_142805_Name = {
    Text = "向上坠落"
  },
  Skill_142806_BattleDesc = {
    Text = "对所有敌人造成 [Arg1] 点以及其最大生命 0.4% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace21:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142806_Desc = {
    Text = "对所有敌人造成装备者攻击力 1500% 以及其最大生命 0.4% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace21:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142806_Name = {
    Text = "涉足人间"
  },
  Skill_142807_Desc = {
    Text = "装备者获得 <Yellow:[Arg1]> 点固定狂气并移除各处指令卡的<ErosionColorInkKeywords:认知错乱>效果。"
  },
  Skill_142807_Name = {
    Text = "向上坠落"
  },
  Skill_142808_BattleDesc = {
    Text = "对所有敌人造成 [Arg1] 点以及其最大生命 0.8% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace23:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142808_Desc = {
    Text = "对所有敌人造成装备者攻击力 2500% 以及其最大生命 0.8% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace23:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142808_Name = {
    Text = "涉足人间"
  },
  Skill_142809_BattleDesc = {
    Text = "对所有敌人造成 [Arg1] 点以及其最大生命 0.6% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace22:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142809_Desc = {
    Text = "对所有敌人造成装备者攻击力 2000% 以及其最大生命 0.6% 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace22:「向上坠落」>洗入抽牌堆。"
  },
  Skill_142809_Name = {
    Text = "涉足人间"
  },
  Skill_142846_AwakerSkillBackgroundStory = {
    Text = "人耳与现有银芯科技，暂时都无法从庞托斯的猎哨中获取任何有效信息。\n但所有被厄波扬斯同化的个体，似乎都极快地适应了听从哨音的指令。"
  },
  Skill_142846_Desc = {
    Text = "若本场战斗首次释放，则生成 3 种不同的「囚魇」<DerivativeCardKeywords_145:><DerivativeCardKeywords_146:><DerivativeCardKeywords_147:>置入手中并获得 <Block:[Block:Arg1]> 点护盾，每拥有 4 张永久囚魇使其中 1 张升级为「双生囚魇」。否则抽 3 张「囚魇」。"
  },
  Skill_142846_EffectNameList = {
    Text = "护盾,囚魇等级"
  },
  Skill_142846_Name = {
    Text = "驭魇哨音"
  },
  Skill_142846_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_142847_AwakerSkillBackgroundStory = {
    Text = "厄波扬斯的出现频率并不规律，其全貌亦无法被观测。\n唯一已知的是，当那些无面生物成群结队地出没于天际时，一幢从窗内散射出不可名状珠光的房屋，会矗立在某处迷雾中的悬崖之上。"
  },
  Skill_142847_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害。获得 <Energy:[Energy:Arg2]> 点狂气。额外生效 X 次。"
  },
  Skill_142847_BattleDesc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害。获得 <Energy:[Energy:Arg2]> 点狂气。额外生效 X+1 次。"
  },
  Skill_142847_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害。获得 <Energy:[Energy:Arg2]> 点狂气。额外生效 X 次。"
  },
  Skill_142847_Desc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害。获得 <Energy:[Energy:Arg2]> 点狂气。额外生效 X+1 次。"
  },
  Skill_142847_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_142847_Name = {
    Text = "纵魇掠袭"
  },
  Skill_142847_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_142874_Desc_1 = {
    Text = "对敌方造成 <Damage:[Damage:Arg1]> 伤害，损失一半伤害量的生命 或 使友方获得 <Block:[Block:Arg2]> 护盾。抽 [Arg3] 张牌。"
  },
  Skill_142874_Name_1 = {Text = "猎魇"},
  Skill_142875_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_142875_Name_1 = {Text = "打击"},
  Skill_142876_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，每次受到攻击会将 [Arg1] 张<PVPDerivativeCardKeywords_30:「猎魇」>置入手牌。"
  },
  Skill_142876_Name_1 = {
    Text = "领主之仪"
  },
  Skill_142877_Desc_1 = {
    Text = "选择任意其他目标，若为友方，自身和友方获得 <Block:[Block:Arg1]> 护盾，下回合开始前，为其分担所受一半伤害；若为敌方，下回合开始前，转嫁所受一半伤害。"
  },
  Skill_142877_Name_1 = {
    Text = "无休猎宴"
  },
  Skill_142878_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，若目标狂气小于 [Arg2] ，则伤害翻倍，否则造成<PVPEmptinessKeywords:空虚>。"
  },
  Skill_142878_Name_1 = {
    Text = "追猎艺术"
  },
  Skill_142879_Desc_1 = {
    Text = "将 [Arg1] 张<PVPDerivativeCardKeywords_30:「猎魇」>置入抽牌堆，抽 [Arg2] 张牌。"
  },
  Skill_142879_Name_1 = {Text = "驭魇者"},
  Skill_142958_Desc_1 = {
    Text = "指定友方获得 <Block:[Block:Arg1]> 护盾，<PVPGrowthKeywords:成长> -[Arg2]，护盾效果归零后改为抽 [Arg3] 牌。"
  },
  Skill_142958_Desc_2 = {
    Text = "抽 [Arg3] 牌。"
  },
  Skill_142958_Name_1 = {Text = "空心人"},
  Skill_142958_UnknownName = {Text = "空心人"},
  Skill_142960_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142960_Name_1 = {
    Text = "兰提戈斯专武(临时文本)"
  },
  Skill_142961_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前损失 25% 当前生命；「狂气爆发」后对全体敌方造成 [Arg1] 伤害并汲取等量生命。"
  },
  Skill_142961_Name_1 = {
    Text = "蜜果的谎言"
  },
  Skill_142962_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142962_Name_1 = {
    Text = "撒托古亚SR(临时文本)"
  },
  Skill_142963_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142963_Name_1 = {
    Text = "秃鹫SR(临时文本)"
  },
  Skill_142964_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142964_Name_1 = {
    Text = "亚弗戈蒙SR(临时文本)"
  },
  Skill_142965_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142965_Name_1 = {
    Text = "夏塔克鸟专武(临时文本)"
  },
  Skill_142966_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，对随机的敌方施加 [Arg1] 层<PVPCompassKeywords:指向歧路的罗盘>。"
  },
  Skill_142966_Name_1 = {
    Text = "指向歧路的罗盘"
  },
  Skill_142967_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142967_Name_1 = {
    Text = "秃鹫专武(临时文本)"
  },
  Skill_142968_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142968_Name_1 = {
    Text = "黑法老SR(临时文本)"
  },
  Skill_142969_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142969_Name_1 = {
    Text = "本源奥吉尔专武(临时文本)"
  },
  Skill_142970_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142970_Name_1 = {
    Text = "黑法老专武(临时文本)"
  },
  Skill_142971_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限+ [Arg1] ，装备者或友方死亡时，其卡牌不再转换为<PVPDerivativeCardKeywords_2:「幻象」>，而是转换为<PVPDerivativeCardKeywords_30:「猎魇」>。"
  },
  Skill_142971_Name_1 = {Text = "活囚笼"},
  Skill_142972_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142972_Name_1 = {
    Text = "本源奥吉尔SR(临时文本)"
  },
  Skill_142973_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142973_Name_1 = {
    Text = "本源图鲁SR(临时文本)"
  },
  Skill_142975_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142975_Name_1 = {
    Text = "撒托古亚专武(临时文本)"
  },
  Skill_142977_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142977_Name_1 = {
    Text = "兰提戈斯SR(临时文本)"
  },
  Skill_142978_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使敌方全体施加 [Arg1] 层<PVPBless:赐福>。"
  },
  Skill_142978_Name_1 = {
    Text = "恬美的真相"
  },
  Skill_142980_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142980_Name_1 = {
    Text = "夏塔克鸟SR(临时文本)"
  },
  Skill_142981_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_142981_Name_1 = {
    Text = "亚弗戈蒙专武(临时文本)"
  },
  Skill_143024_Desc_1 = {
    Text = "选择友方位置1或位置2或敌方，不忽略机制。"
  },
  Skill_143024_Name_1 = {
    Text = "目标测试4"
  },
  Skill_143025_Desc_1 = {
    Text = "选择友方或敌方，忽略敌方的嘲讽。"
  },
  Skill_143025_Name_1 = {
    Text = "目标测试2"
  },
  Skill_143026_Desc_1 = {
    Text = "选择友方位置1或位置2或敌方，忽略敌方的潜行。"
  },
  Skill_143026_Name_1 = {
    Text = "目标测试3"
  },
  Skill_143027_Desc_1 = {
    Text = "选择友方或敌方，忽略敌方的潜行和嘲讽。"
  },
  Skill_143027_Name_1 = {
    Text = "目标测试1"
  },
  Skill_143028_Desc_1 = {
    Text = "获得目标测试所需的卡牌。"
  },
  Skill_143028_Name_1 = {
    Text = "目标测试"
  },
  Skill_143392_Desc_1 = {
    Text = "使一个唤醒体生命归零。"
  },
  Skill_143392_Name_1 = {
    Text = "生命归零"
  },
  Skill_143432_Desc = {
    Text = "增加1点算力消耗"
  },
  Skill_143432_Name = {
    Text = "增加1点算力消耗"
  },
  Skill_143433_Desc = {
    Text = "恒定算力1"
  },
  Skill_143433_Name = {
    Text = "恒定算力1"
  },
  Skill_143434_Desc = {
    Text = "恒定算力5"
  },
  Skill_143434_Name = {
    Text = "恒定算力5"
  },
  Skill_143443_Desc = {
    Text = "按条件选择唤醒体"
  },
  Skill_143443_Name = {
    Text = "接口测试"
  },
  Skill_143494_Desc_1 = {
    Text = "免疫纯粹伤害，二次释放解除。"
  },
  Skill_143494_Name_1 = {
    Text = "免疫纯粹伤害"
  },
  Skill_143495_Desc_1 = {
    Text = "免疫主动伤害，二次释放解除。"
  },
  Skill_143495_Name_1 = {
    Text = "免疫主动伤害"
  },
  Skill_143556_Desc = {
    Text = "囚魇测试"
  },
  Skill_143556_Name = {
    Text = "囚魇测试"
  },
  Skill_143557_Desc_0 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_143557_Desc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。<RippleKeywords:余波>：算力消耗 -1。"
  },
  Skill_143557_Name = {
    Text = "滋扰之魇"
  },
  Skill_143557_tempName_1 = {
    Text = "滋扰之魇"
  },
  Skill_143557_tempName_2 = {
    Text = "双生·滋扰之魇"
  },
  Skill_143558_BattleDesc_0 = {
    Text = "对生命最低敌人造成等同于 [Arg1]％ 触腕伤害的<RealDamage:固定伤害>( [Arg2] )。获得等同于庞托斯基础暴击伤害 [Arg3]% 的临时暴击伤害( [Arg4]％ )。"
  },
  Skill_143558_BattleDesc_3 = {
    Text = "对生命最低敌人造成等同于 [Arg1]％ 触腕伤害的<RealDamage:固定伤害>( [Arg2] )。获得等同于庞托斯基础暴击伤害 [Arg3]% 的临时暴击伤害( [Arg4]％ )。<RippleKeywords:余波>：算力消耗 -1。"
  },
  Skill_143558_Desc_0 = {
    Text = "对生命最低敌人造成等同于 [Arg5]％ 触腕伤害的<RealDamage:固定伤害>。获得等同于庞托斯基础暴击伤害 [Arg3]% 的临时暴击伤害。"
  },
  Skill_143558_Desc_3 = {
    Text = "对生命最低敌人造成等同于 [Arg5]％ 触腕伤害的<RealDamage:固定伤害>。获得等同于庞托斯基础暴击伤害 [Arg3]% 的临时暴击伤害。<RippleKeywords:余波>：算力消耗 -1。"
  },
  Skill_143558_Name = {
    Text = "猎杀之魇"
  },
  Skill_143558_tempName_1 = {
    Text = "猎杀之魇"
  },
  Skill_143558_tempName_2 = {
    Text = "双生·猎杀之魇"
  },
  Skill_143559_Desc_0 = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆，其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_143559_Desc_3 = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆，其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。<RippleKeywords:余波>：算力消耗 -1。"
  },
  Skill_143559_Name = {
    Text = "掳掠之魇"
  },
  Skill_143559_tempName_1 = {
    Text = "掳掠之魇"
  },
  Skill_143559_tempName_2 = {
    Text = "双生·掳掠之魇"
  },
  Skill_143604_Desc = {
    Text = "临时暴击伤害 +[Arg1]％，临时降低所有敌人 [Arg2] 点<ExhaustionIconKeywords:力量>。若庞托斯在队伍中，获得 1 层<BattueKeywords:围猎>。"
  },
  Skill_143604_Name = {Text = "空心人"},
  Skill_143686_Desc = {
    Text = "囚魇测试2"
  },
  Skill_143686_Name = {
    Text = "囚魇测试2"
  },
  Skill_143687_Desc = {
    Text = "玩家没虚弱则卡面为普通胚胎，有则圣胎"
  },
  Skill_143687_Name = {
    Text = "卡面条件表达式测试"
  },
  Skill_144438_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：友方死亡时，自身获得 <Energy:[Energy:Arg1]> 狂气。友方复活时，其获得 <Energy:[Energy:Arg2]> 狂气。获得狂气效果仅在目标狂气不满时生效，最多生效 [Arg8] 次，次数耗尽后销毁该命轮。"
  },
  Skill_144438_Name_1 = {
    Text = "魂灵同调"
  },
  Skill_144486_AwakerSkillBackgroundStory = {
    Text = "仙女和巫师是在乡镇一角的荒僻空地上相遇的。\n那时她在笑意盈盈地招徕衣着华美的异乡孩童，巫师则不动声色地盯上了母亲手腕上叮当的金镯。\n二人的目光在空中一碰，瞬间了悟彼此的意图。\n这场无声的角逐，最终巫师技高一筹，凭借老道经验险胜收尾。\n但一桩崭新的、坑蒙拐骗的美好事业，也就此拉开了序幕。"
  },
  Skill_144486_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 1 层<WormGrowth1:饱餐>。每次造成伤害对目标施加 [Corrosion:Arg10] 点<Corrosion:侵蚀>。】驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg8] 次。每有 1 层<WormGrowth1:饱餐>狂气爆发基础伤害与护盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每层使伤害次数 +1，并获得<WormGrowth1:饱餐>。当前<WormGrowth1:饱餐>层数：[Arg9]，本场战斗叠加层数：[Arg11]"
  },
  Skill_144486_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 1 层<WormGrowth2:饱餐>，每次造成伤害对目标施加 [Corrosion:Arg10] 点<Corrosion:侵蚀>。】驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg8] 次。每有 1 层<WormGrowth2:饱餐>狂气爆发基础伤害与护盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每层使伤害次数 +1，并获得<WormGrowth2:饱餐>。当前<WormGrowth2:饱餐>层数：[Arg9]，本场战斗叠加层数：[Arg11]"
  },
  Skill_144486_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 1 层<WormGrowth1:饱餐>。每次造成伤害对目标施加 [Corrosion:Arg10] 点<Corrosion:侵蚀>。】驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg8] 次。每有 1 层<WormGrowth1:饱餐>狂气爆发基础伤害与护盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每层使伤害次数 +1，并获得<WormGrowth1:饱餐>。"
  },
  Skill_144486_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 1 层<WormGrowth2:饱餐>，每次造成伤害对目标施加 [Corrosion:Arg10] 点<Corrosion:侵蚀>。】驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg8] 次。每有 1 层<WormGrowth2:饱餐>狂气爆发基础伤害与护盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每层使伤害次数 +1，并获得<WormGrowth2:饱餐>。"
  },
  Skill_144486_EffectNameList = {
    Text = "护盾,伤害,吞噬侵蚀"
  },
  Skill_144486_Name = {
    Text = "叮咚★仙女驾到"
  },
  Skill_144486_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 1 层<WormGrowth2:饱餐>。每次造成伤害对目标施加 [Corrosion:Arg10] 点<Corrosion:侵蚀>】驱散所有手中卡牌的<BurningKeywords2:燃烧>状态。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg8] 次。每有 1 层<WormGrowth2:饱餐>狂气爆发基础伤害与护盾提高 [Arg6]%。消耗所有<SacrificialMark1:供奉>，每层使伤害次数 +1，并获得<WormGrowth2:饱餐>。<FaxianKeywords:发现> 2 组<Blessing:礼物>不同的<DerivativeCardKeywords_152:「赐福」>，每组包含 2 张，选择 1 组置入手中。  使所有敌人永久降低 [Exhaustion:Arg12] 点<ExhaustionIconKeywords:力量>。当前<WormGrowth2:饱餐>层数：[Arg9]。本场战斗叠加层数：[Arg11]"
  },
  Skill_144486_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_144487_AwakerSkillBackgroundStory = {
    Text = "每逢降雪将至的清朗夜晚，卡拉布都会爬上烟囱旁，静静地仰望晦暗的天空。\n魔法棒指向天际，划出她自行创作的咒文。\n然后飘落的粉雪，又会将她带回曾经交付灵魂的雪夜。\n「看啊，这就是我的魔法。」"
  },
  Skill_144487_Desc_0 = {
    Text = "对生命最高敌人造成 [Arg1] 点<RealDamage:固定伤害>。施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_144487_Desc_1 = {
    Text = "对生命最高敌人造成 [Arg1] 点<RealDamage:固定伤害>。施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_144487_EffectNameList = {Text = "伤害"},
  Skill_144487_Name = {
    Text = "粉雪魔咒"
  },
  Skill_144487_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_144487_tempBattleDesc_1 = {
    Text = "对生命最高敌人造成 [Arg1] 点<RealDamage:固定伤害> [Arg4] 次。施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_144487_tempBattleDesc_2 = {
    Text = "对生命最高敌人造成 [Arg1] 点<RealDamage:固定伤害> [Arg4] 次。施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_144487_tempBattleDesc_3 = {
    Text = "对全体敌方造成 [Arg1] 点<RealDamage:固定伤害> [Arg4] 次并对其施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_144487_tempBattleDesc_4 = {
    Text = "对全体敌方造成 [Arg1] 点<RealDamage:固定伤害> [Arg4] 次并对其施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_144488_AwakerSkillBackgroundStory = {
    Text = "「本仙女来保护你！超级防御魔法可以抵御一切攻击！」"
  },
  Skill_144488_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144488_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。每第 [Arg3] / 7 次打出「打击」或「防御」时，获得 1 层<SacrificialMark1:供奉>，并<FaxianKeywords:发现> [Arg4] 张<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，选择 1 张置入手中。"
  },
  Skill_144488_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。卡拉布获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144488_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。卡拉布获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144488_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_144488_Name = {Text = "防御"},
  Skill_144488_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_144489_BattleDesc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_144489_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_144489_Name = {
    Text = "瞬发赐福·算力"
  },
  Skill_144490_AwakerSkillBackgroundStory = {
    Text = "「本仙女出手了哦！超级攻击魔法可以打破所有护盾！」"
  },
  Skill_144490_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144490_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。每第 [Arg3] / 7 次打出「打击」或「防御」时，获得 1 层<SacrificialMark1:供奉>，并<FaxianKeywords:发现> [Arg4] 张<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，选择 1 张置入手中。"
  },
  Skill_144490_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。卡拉布获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144490_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。卡拉布获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_144490_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_144490_Name = {Text = "打击"},
  Skill_144490_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_144491_AwakerSkillBackgroundStory = {
    Text = "贪婪是人性的本色。\n没有人能拒绝糖分的诱惑，即使是仙女教母本人也不例外。\n卡拉布咧开嘴笑起来，露出一口黑漆漆的尖牙。"
  },
  Skill_144491_BattleDesc_0 = {
    Text = "卡拉布获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，使下一次「奇迹赐福」算力消耗 -3，每个<FaxianKeywords:发现> 选项额外包含 1 张<DerivativeCardKeywords_152:「赐福」>，选择 1 组置入抽牌堆。"
  },
  Skill_144491_BattleDesc_15 = {
    Text = "卡拉布获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，使下一次「奇迹赐福」算力消耗 -3，每个<FaxianKeywords:发现> 选项额外包含 2 张<DerivativeCardKeywords_152:「赐福」>，选择 1 组置入抽牌堆。打出「赐福」后，胚胎融合 +10，当前生命越低则效果越高，至多提高 100%。"
  },
  Skill_144491_Desc_0 = {
    Text = "卡拉布获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，使下一次「奇迹赐福」算力消耗 -3，每个<FaxianKeywords:发现> 选项额外包含 1 张<DerivativeCardKeywords_152:「赐福」>，选择 1 组置入抽牌堆。"
  },
  Skill_144491_Desc_15 = {
    Text = "卡拉布获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：使用「猩红熔炉」后，使下一次「奇迹赐福」算力消耗 -3，每个<FaxianKeywords:发现> 选项额外包含 2 张<DerivativeCardKeywords_152:「赐福」>，选择 1 组置入抽牌堆。打出<Blessing:赐福>后，胚胎融合 +10，当前生命越低则效果越高，至多提高 100%。"
  },
  Skill_144491_EffectNameList = {Text = "狂气"},
  Skill_144491_Name = {
    Text = "诱人蜜果"
  },
  Skill_144491_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_144492_AwakerSkillBackgroundStory = {
    Text = "「想要无尽的财宝吗？」\n「想要无限的权力吗？」\n「想要起死回生的神药吗？」\n「想要洞悉人心的水晶球吗？」\n「想要让爱人回心转意的符咒吗？」\n「想要能回答一切问题的魔镜吗？」\n「想要让所有欲望即刻满足的蜜果吗？」\n只要你许下心愿，这里什么都有。\n现在，展示你的诚意，向仙女教母献上供奉吧！\n奇迹降至，请静候3秒！\n3、2、1——溜之大吉！"
  },
  Skill_144492_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> [Arg2] 张<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，选择 [Arg3] 张置入抽牌堆。"
  },
  Skill_144492_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> [Arg2] 张<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，选择 [Arg3] 张置入抽牌堆。"
  },
  Skill_144492_EffectNameList = {
    Text = "护盾,力量,临时力量降低,固定狂气,银钥能量,临时伤害强效"
  },
  Skill_144492_Name = {
    Text = "奇迹赐福"
  },
  Skill_144492_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,防御力*GrowValue3,$GrowValue4,$GrowValue5,$GrowValue6％"
  },
  Skill_144492_tempBattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> [Arg2] 张<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，选择 [Arg3] 张置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> 2 组<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，每组包含 2 张，选择 1 组置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> 3 组<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，每组包含 2 张，选择 1 组置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_4 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> 2 组<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，每组包含 3 张，选择 1 组置入抽牌堆。"
  },
  Skill_144492_tempBattleDesc_5 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<FaxianKeywords:发现> 3 组<BlessingNegativeEffect:代价>不同的<DerivativeCardKeywords_152:「赐福」>，每组包含 3 张，选择 1 组置入抽牌堆。"
  },
  Skill_144512_Name = {
    Text = "测试标题名2"
  },
  Skill_144513_Name = {
    Text = "测试标题名3"
  },
  Skill_144514_Desc = {
    Text = "打出后进行钥令包3选1, 每个包内含有3个钥令。选中后直接依次释放。"
  },
  Skill_144514_Name = {
    Text = "钥令包3选1"
  },
  Skill_144515_Name = {
    Text = "测试标题名1"
  },
  Skill_145386_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg2] 层<EnergyStorageKeywords:蓄力>，「打击」伤害提高 [Arg1]% 并改为<PVPPunctureDamagewords:穿刺伤害>。"
  },
  Skill_145386_Name_1 = {Text = "天之陨"},
  Skill_145387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]% ，每次「打击」后伤害额外提高 [Arg2]% ，最多提高至 [Arg3]% 。"
  },
  Skill_145387_Name_1 = {
    Text = "不灭的饥骨"
  },
  Skill_145439_BattleDesc = {
    Text = "获得 1 点算力。保留：积攒 <Green:[Arg1]> 点固定生命回复量与 <Yellow:[Arg2]> 点固定狂气(已积攒 <Green:[Arg3]> 生命回复量，<Yellow:[Arg4]> 点狂气)。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145439_Desc = {
    Text = "获得 1 点算力。保留：积攒装备者体质 5% 的固定生命回复量与 3 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145439_Name = {
    Text = "魂灵同调"
  },
  Skill_145440_BattleDesc = {
    Text = "获得 1 点算力。保留：积攒 <Green:[Arg1]> 点固定生命回复量与 <Yellow:[Arg2]> 点固定狂气(已积攒 <Green:[Arg3]> 生命回复量，<Yellow:[Arg4]> 点狂气)。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145440_Desc = {
    Text = "获得 1 点算力。保留：积攒装备者体质 6% 的固定生命回复量与 4 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145440_Name = {
    Text = "魂灵同调"
  },
  Skill_145441_BattleDesc = {
    Text = "获得 1 点算力。保留：积攒 <Green:[Arg1]> 点固定生命回复量与 <Yellow:[Arg2]> 点固定狂气(已积攒 <Green:[Arg3]> 生命回复量，<Yellow:[Arg4]> 点狂气)。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145441_Desc = {
    Text = "获得 1 点算力。保留：积攒装备者体质 4% 的固定生命回复量与 2 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145441_Name = {
    Text = "魂灵同调"
  },
  Skill_145442_BattleDesc = {
    Text = "获得 1 点算力。保留：积攒 <Green:[Arg1]> 点固定生命回复量与 <Yellow:[Arg2]> 点固定狂气(已积攒 <Green:[Arg3]> 生命回复量，<Yellow:[Arg4]> 点狂气)。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145442_Desc = {
    Text = "获得 1 点算力。保留：积攒装备者体质 3% 的固定生命回复量与 1 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后销毁此卡牌。"
  },
  Skill_145442_Name = {
    Text = "魂灵同调"
  },
  Skill_145536_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145536_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145536_Name = {
    Text = "瞬发赐福·银钥能量"
  },
  Skill_145537_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145537_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145537_Name = {
    Text = "瞬发赐福·狂气"
  },
  Skill_145538_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145538_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145538_Name = {
    Text = "瞬发赐福·伤害强效"
  },
  Skill_145539_BattleDesc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145539_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145539_Name = {
    Text = "瞬发赐福·抽牌"
  },
  Skill_145540_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145540_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145540_Name = {
    Text = "瞬发赐福·力量"
  },
  Skill_145541_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145541_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_145541_Name = {
    Text = "瞬发赐福·衰竭"
  },
  Skill_145557_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害并回复一半伤害的生命，同时视为「打击」。"
  },
  Skill_145557_Name_1 = {Text = "噬之刃"},
  Skill_145558_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_145558_Name_1 = {Text = "打击"},
  Skill_145559_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:穿刺伤害>，若击杀任何敌方，获得 [Arg2] <PVPPowerIconKeywords:力量>。"
  },
  Skill_145559_Name_1 = {
    Text = "鲸落归溟"
  },
  Skill_145560_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，并临时夺取 [Arg2] <PVPPowerIconKeywords:力量>，损失 [Arg3] 生命。"
  },
  Skill_145560_Name_1 = {Text = "陨之刃"},
  Skill_145561_Desc_1 = {
    Text = "对目标友方以外的所有其他唤醒体造成 <Damage:[Damage:Arg1]> <PVPPunctureDamagewords:穿刺伤害>，后续每次回合开始重复此效果。"
  },
  Skill_145561_Name_1 = {
    Text = "噬鲸的风暴"
  },
  Skill_145561_UnknownName = {
    Text = "噬鲸的风暴"
  },
  Skill_145562_Desc_1 = {
    Text = "选择一名敌方，双方互相<PVPLock:锁定>，并对目标造成 <Damage:[Damage:Arg1]> 伤害。目标在<PVPLock:锁定>下死亡则此卡回到手中。<PVPFusion:融合>：伤害+ [Arg2] 。"
  },
  Skill_145562_Name_1 = {
    Text = "决斗之契"
  },
  Skill_145612_Desc = {
    Text = "赐福是算力消耗 1、拥有<RetainIconKeywords:保留>、<PrepareKeypvewords:预备>、<DepleteIconKeywords:消耗>的增益卡。\n打出时获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。「赐福」共有 3 种：\n「瞬发赐福」：不会触发「错失良机」。\n「奢华赐福」：不会触发「夸大其词」。\n「暖心赐福」：不会触发「暗藏杀机」。"
  },
  Skill_145612_Name = {Text = "赐福"},
  Skill_145664_Desc = {
    Text = "按照公式添加 [Poison:Arg1] 中毒，[Counterattack:Arg2] 反击，[Power:Arg3] 力量，[Exhaustion:Arg4] 衰竭，[TentaclePower:Arg5] 触腕伤害，[FateCut:Arg6] 命运裁断，[Corrosion:Arg7] 侵蚀。"
  },
  Skill_145664_Name = {
    Text = "按公式加状态"
  },
  Skill_145673_AwakerSkillBackgroundStory = {
    Text = "「你看见了吗？他们的皮肉如何在你的刃下绽裂，涌出绚烂的血花。」\n「不要妄想闭上眼睛便不存在，亲爱的孩子。」\n「你明白的，你清楚的。」\n「你所练就的技艺，早已浸染死亡的色彩，只会为他人引来下一场劫难。」"
  },
  Skill_145673_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145673_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145673_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。负誓·奥吉尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145673_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次。负誓·奥吉尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145673_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_145673_Name = {Text = "打击"},
  Skill_145673_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_145674_AwakerSkillBackgroundStory = {
    Text = "「你听见了吗？他们的哀嚎如何响彻每个角落，却无人为其撑起半分庇护。」\n「不要以为捂住耳朵便可忽视，无能的骑士。」\n「你亲历过，你选择过。」\n「敌潮席卷而来之际，你丢盔弃甲，放任他们蹂躏了你最爱的土地。」"
  },
  Skill_145674_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145674_Desc = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾。负誓·奥吉尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_145674_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_145674_Name = {Text = "防御"},
  Skill_145674_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_145675_AwakerSkillBackgroundStory = {
    Text = "其实，奥吉尔早已忘却那座城堡的真实模样。\n但如今，他可以依靠心底的祈望，铸起新的壁垒。\n如果在他的守护之下，仍能听到人们的欢声笑语，熟悉的花朵也会重新开遍原野......\n那么，那颗早已异化的心脏，就还有留存于世的意义。"
  },
  Skill_145675_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Power:Arg2] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 层使造成的护盾和力量提高 33%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Power:Arg2] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 层使造成的护盾和力量提高 50%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_Desc_0 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，获得 [Power:Arg4] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 层使造成的护盾和力量提高 33%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_Desc_3 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，获得 [Power:Arg4] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 层使造成的护盾和力量提高 50%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_EffectNameList = {
    Text = "护盾,力量"
  },
  Skill_145675_Name = {
    Text = "未陨的骑士心"
  },
  Skill_145675_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Power:Arg5] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu:暗涌>，每消耗 1 层使造成的护盾和力量提高 33%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Power:Arg5] 点<PowerIconKeywords:力量> ，消耗所有<KuangNu2:暗涌>，每消耗 1 层使造成的护盾和力量提高 50%，获得 1 层<ShuZui:自罪>。"
  },
  Skill_145675_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_145676_AwakerSkillBackgroundStory = {
    Text = "每位骑士在受封宣誓之时，随身的兵刃便同样镀上了荣光。\n可属于他的那柄最初的，被赋予了神圣使命的银枪，早已消融在战火的余烬中。\n不过，既然已经是戴罪之身，不妨让这罪恶的淤黑成为新的武器。他想，这样，哪怕沾染更多的血，也不会再给故人蒙羞了。"
  },
  Skill_145676_BattleDesc_0 = {
    Text = "造成<Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]% 力量加成，获得 1 层<KuangNu:暗涌>。"
  },
  Skill_145676_BattleDesc_3 = {
    Text = "造成<Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]% 力量加成，获得 1 层<KuangNu2:暗涌>。"
  },
  Skill_145676_Desc_0 = {
    Text = "造成<Damage:[Damage:Arg1]> 点伤害，享受 300% 力量加成，获得 1 层<KuangNu:暗涌>。"
  },
  Skill_145676_Desc_3 = {
    Text = "造成<Damage:[Damage:Arg1]> 点伤害，享受 300% 力量加成，获得 1 层<KuangNu2:暗涌>。"
  },
  Skill_145676_EffectNameList = {Text = "伤害"},
  Skill_145676_Name = {
    Text = "染罪枪锋"
  },
  Skill_145676_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_145677_AwakerSkillBackgroundStory = {
    Text = "曾经，少年也试过将这邪恶的黑色污泥从自己身上剥离开，可无论他做什么——用手撕扯，用利器切割，用钝器击打......无形的噩梦总是挥之不去，甚至愈发得寸进尺。\n最后，他终于承认，他与祂早已彻底融为一体，不分彼此。\n祂化作了他的影子。"
  },
  Skill_145677_BattleDesc_0 = {
    Text = "负誓·奥吉尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：负誓·奥吉尔每回合首次「染罪枪锋」造成伤害时施加等量<Corrosion:侵蚀>。「防御」的护盾提高 50%，抽 1 张牌。"
  },
  Skill_145677_BattleDesc_15 = {
    Text = "负誓·奥吉尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：负誓·奥吉尔每回合首次「染罪枪锋」造成伤害时施加等量<Corrosion:侵蚀>。「染罪枪锋」的基础伤害提高 100%，额外享受 200% 力量加成。「防御」的护盾提高 100%，抽 1 张牌。"
  },
  Skill_145677_Desc_0 = {
    Text = "负誓·奥吉尔获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：负誓·奥吉尔每回合首次「染罪枪锋」造成伤害时施加等量<Corrosion:侵蚀>。「防御」的护盾提高 50%，抽 1 张牌。"
  },
  Skill_145677_Desc_15 = {
    Text = "负誓·奥吉尔获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：负誓·奥吉尔每回合首次「染罪枪锋」造成伤害时施加等量<Corrosion:侵蚀>。「染罪枪锋」的基础伤害提高 100%，额外享受 200% 力量加成。「防御」的护盾提高 100%，抽 1 张牌。"
  },
  Skill_145677_EffectNameList = {Text = "狂气"},
  Skill_145677_Name = {
    Text = "与黑沼共生"
  },
  Skill_145677_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_145678_AwakerSkillBackgroundStory = {
    Text = "在弥萨格的例行检查中， 科研人员曾专门对这团无定形的漆黑之物进行了研究。\n出人意料的是，他们竟真的从中提取到了一些物质成分，于是迫不及待地展开了第二次实验，得到的结果却又全然不同。\n仿佛与它展现出的无定形特征彼此呼应，构成它的成分也每时每刻都在变化，如同虚无缥缈的幻影。\n无形之物，根源即是无形。"
  },
  Skill_145678_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。额外生效 X 次。X 至多为 5。"
  },
  Skill_145678_EffectNameList = {
    Text = "临时力量降低,力量"
  },
  Skill_145678_Name = {
    Text = "无边荒影"
  },
  Skill_145678_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_145713_Desc = {
    Text = "打出后，读取玩家身上的基础钥能上限，最大积攒钥能并打印。"
  },
  Skill_145713_Name = {
    Text = "获取钥能属性"
  },
  Skill_145971_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，若其当前生命大于自身，双方交换当前生命。"
  },
  Skill_145971_Name_1 = {
    Text = "狂气爆发"
  },
  Skill_145972_Desc_1 = {
    Text = "任意目标回复 <Heal:[Heal:Arg1]> 生命，在下回合开始时移除未被损耗的生命。"
  },
  Skill_145972_Name_1 = {
    Text = "并非谎言之物"
  },
  Skill_145972_UnknownName = {
    Text = "并非谎言之物"
  },
  Skill_145973_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_145973_Name_1 = {Text = "打击"},
  Skill_145974_Desc_1 = {
    Text = "使一名敌方施加 [Arg1] 层<PVPBless:赐福>。自身损失 <Damage:[Arg2]> 生命。"
  },
  Skill_145974_Name_1 = {Text = "技能三"},
  Skill_145975_Desc_1 = {
    Text = "<PVPBluff:忽悠>一名敌方使其无心战斗。<PVPBluff:忽悠>结束对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_145975_Name_1 = {Text = "技能一"},
  Skill_145976_Desc_1 = {
    Text = "获得 <Energy:[Energy:Arg1]> 狂气，损失 <Damage:[Arg2]> 生命。<DelayKeywords:延迟 1>：扣除 [Arg1] 狂气。"
  },
  Skill_145976_Name_1 = {Text = "技能二"},
  Skill_145988_Desc = {
    Text = "临时降低全体敌方 [Arg1] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_145988_Name = {
    Text = "原初记忆·衰竭"
  },
  Skill_145989_Desc = {
    Text = "所有唤醒体获得 <Energy:[Arg1]> 点狂气。"
  },
  Skill_145989_Name = {
    Text = "原初记忆·催化"
  },
  Skill_145990_Desc = {
    Text = "回复 <Heal:[Arg1]> 点生命"
  },
  Skill_145990_Name = {
    Text = "原初记忆·回复"
  },
  Skill_145991_Desc = {
    Text = "对全体敌方施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_145991_Name = {
    Text = "原初记忆·毒素"
  },
  Skill_145992_Desc = {
    Text = "获得 [Arg1] 层<RetaliateIconKeywords:临时反击>。"
  },
  Skill_145992_Name = {
    Text = "原初记忆·尖刺"
  },
  Skill_145993_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_145993_Name = {
    Text = "原初记忆·蛮力"
  },
  Skill_145995_Desc = {
    Text = "获得 <Block:[Arg1]> 点护盾。"
  },
  Skill_145995_Name = {
    Text = "原初记忆·铁壁"
  },
  Skill_146011_AwakerSkillBackgroundStory = {
    Text = "骨剑划出的弧线永远从容而优雅。\n认真地挥出每一剑，是她对对手、对战斗本身，最大的尊重。"
  },
  Skill_146011_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_146011_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次打出时抽 1 张「短刃·噬」( [Arg4]/1 )。"
  },
  Skill_146011_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。蚀灭·萝坦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_146011_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。蚀灭·萝坦获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次打出时抽 1 张「短刃·噬」。"
  },
  Skill_146011_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_146011_Name = {Text = "打击"},
  Skill_146011_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_146012_Desc = {
    Text = "无法打出。持有此卡时所有敌人造成的伤害提高 25%，蚀灭·萝坦的指令卡全部变化为<DerivativeCardKeywords_154:「蚀灭」>，回合开始时抽 1 张<DerivativeCardKeywords_154:「蚀灭」>。"
  },
  Skill_146012_Name = {
    Text = "巨剑·鲸落"
  },
  Skill_146013_AwakerSkillBackgroundStory = {
    Text = "只有很少、很少的时候，萝坦会收回她的剑。\n那双异色的双瞳正冷静地审视着。收势，永远只是为了更好地出剑。"
  },
  Skill_146013_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_146013_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次打出时抽 1 张「长刃·陨」( [Arg4]/1 )。"
  },
  Skill_146013_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。蚀灭·萝坦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_146013_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。蚀灭·萝坦获得 <Energy:[Energy:Arg2]> 点狂气。每回合首次打出时抽 1 张「长刃·陨」。"
  },
  Skill_146013_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_146013_Name = {Text = "防御"},
  Skill_146013_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_146014_AwakerSkillBackgroundStory = {
    Text = "利维坦最沉重、坚硬的那块颅骨被磨成长刃，她称它为「陨」。\n重剑横扫而出，剑锋的弧线如同巨鲸摆动的尾鳍，沉重的白骨为她碾碎身前的一切。\n啜饮我的鲜血，啃食我的生命吧，萝坦说。\n然后，让所有的生灵，都陨落在你不可阻挡的轨迹里。"
  },
  Skill_146014_Desc = {
    Text = "对全体敌方造成 [Arg3] 次 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]% 力量加成，视为「打击」。本回合每打出 1 张「打击」，下次打出的「长刃·陨」算力消耗 -1。"
  },
  Skill_146014_EffectNameList = {Text = "伤害"},
  Skill_146014_Name = {
    Text = "长刃·陨"
  },
  Skill_146014_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_146015_AwakerSkillBackgroundStory = {
    Text = "利维坦永远记得她斩出那一剑时的样子。\n在祂的领域，那个不自量力的身影早已伤痕累累。属于人类的身躯如此羸弱，几乎一阵呼吸便能让她再也无力起来。愚蠢，狂妄，令人惋惜，这是利维坦对她的全部宣判。\n在审判落下之前，那个弱小的身影再次站了起来。她的笑声让祂感到一种从未有过的情绪。\n祂看见她带着那把破碎的武器与残败的身体，向祂高高跃起。祂看见那道似乎能够斩碎星海的剑意，来到祂的眼前。\n在那柄剑贯穿祂的那一刻，利维坦才明白，那种祂从未体验过的情绪，叫做恐惧。"
  },
  Skill_146015_Desc_0 = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨剑·鲸落」>才可释放。对伤害最高敌方造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害，享受 [Arg2]% 力量加成。目标每通过<DerivativeCardKeywords_153:「巨剑·鲸落」>提高 1 点伤害，就使「断界之剑」伤害 +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_Desc_3 = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨剑·鲸落」>才可释放。对伤害最高敌方造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害，享受 [Arg2]% 力量加成。目标每通过<DerivativeCardKeywords_153:「巨剑·鲸落」>提高 1 点伤害，就使「断界之剑」伤害 +[Arg4] 。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_EffectNameList = {
    Text = "伤害,力量加成"
  },
  Skill_146015_Name = {
    Text = "断界之剑"
  },
  Skill_146015_OverLimitUtlSkillDesc = {
    Text = "需消耗<DerivativeCardKeywords_153:「巨剑·鲸落」>才可释放。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。对伤害最高敌方造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害，享受 [Arg2]% 力量加成。目标每通过<DerivativeCardKeywords_153:「巨剑·鲸落」>提高 1 点伤害，就使「断界之剑」伤害 +[Arg4]。<DerivativeCardKeywords_154:>"
  },
  Skill_146015_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2％"
  },
  Skill_146016_AwakerSkillBackgroundStory = {
    Text = "神明将她的灵与肉撕裂，以为这便是对混沌的终极审判。\n但空荡的灵魂从未停止追寻，被剥离的力量也从未真正消散。\n当骨甲重新覆上她的身躯，当利维坦的脉动再次与她的意志共鸣——所有束缚在那一刻碎裂殆尽。\n灵与肉在星海深处重新交融。混沌之兽不再残缺。\n这片星海，将重新迎接完整的她。"
  },
  Skill_146016_BattleDesc_0 = {
    Text = "「蚀灭·萝坦」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「蚀灭·萝坦」指令卡伤害次数 +1。回合开始时若<DerivativeCardKeywords_153:「巨剑·鲸落」>在手中，本回合首次<DerivativeCardKeywords_154:「蚀灭」>每偷取 1 点狂气，使下次「断界之剑」最终伤害 +1％，最多叠加 90％。"
  },
  Skill_146016_BattleDesc_15 = {
    Text = "「蚀灭·萝坦」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：「蚀灭·萝坦」指令卡伤害次数 +1，<DerivativeCardKeywords_154:「蚀灭」>偷取的狂气提高 50％。回合开始时若<DerivativeCardKeywords_153:「巨剑·鲸落」>在手中，本回合首次<DerivativeCardKeywords_154:「蚀灭」>每偷取 1 点狂气，使下次「断界之剑」最终伤害 +1.5％，最多叠加 135％。"
  },
  Skill_146016_Desc_0 = {
    Text = "「蚀灭·萝坦」获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：「蚀灭·萝坦」指令卡伤害次数 +1。回合开始时若<DerivativeCardKeywords_153:「巨剑·鲸落」>在手中，本回合首次<DerivativeCardKeywords_154:「蚀灭」>每偷取 1 点狂气，使下次「断界之剑」最终伤害 +1％，最多叠加 90％。"
  },
  Skill_146016_Desc_15 = {
    Text = "「蚀灭·萝坦」获得 [Arg2]％ 基础狂气。<ExaltIconKeywords:灵知觉醒>：「蚀灭·萝坦」指令卡伤害次数 +1，<DerivativeCardKeywords_154:「蚀灭」>偷取的狂气提高 50％。回合开始时若<DerivativeCardKeywords_153:「巨剑·鲸落」>在手中，本回合首次<DerivativeCardKeywords_154:「蚀灭」>每偷取 1 点狂气，使下次「断界之剑」最终伤害 +1.5％，最多叠加 135％。"
  },
  Skill_146016_EffectNameList = {Text = "狂气"},
  Skill_146016_Name = {
    Text = "亘古归源"
  },
  Skill_146016_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_146017_AwakerSkillBackgroundStory = {
    Text = "利维坦最锋利的那颗利齿被磨成短刃，她称它为「噬」。\n它对弱者没有任何的兴趣，剑尖永远朝向最强大的那个敌人。利刃以极快的速度刺出，当残影消散之时，浩若星海的力量也将被吞噬殆尽。\n它的贪婪永无止境，那饥饿的目光从诞生之刻便紧盯着萝坦，每次出手都在萝坦的体内撕咬下一块血肉。\n萝坦从不在意。她用鲜血饲养它，用力量震慑它。她用它挥向最强的对手，力量的味道，她与它一同品尝。"
  },
  Skill_146017_BattleDesc = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>，视为「打击」。打出后洗回抽牌堆。此卡每第 3 次打出时额外生效 1 次并使本回合下次打出「长刃·陨」时合成<DerivativeCardKeywords_153:「巨剑·鲸落」>( [Arg4]/3 )<DerivativeCardKeywords_154:>"
  },
  Skill_146017_Desc = {
    Text = "视为「打击」。对随机敌方造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>，打出后洗回抽牌堆。此卡每第 3 次打出时额外生效 1 次并使本回合下次打出「长刃·陨」时合成<DerivativeCardKeywords_153:「巨剑·鲸落」><DerivativeCardKeywords_154:>"
  },
  Skill_146017_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_146017_Name = {
    Text = "短刃·噬"
  },
  Skill_146017_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_146018_Desc = {
    Text = "抽 1 张牌。偷取其他唤醒体至多 [Arg1] 点狂气。"
  },
  Skill_146018_Name = {Text = "蚀灭"},
  Skill_146018_tempBattleDesc_1 = {
    Text = "抽 1 张牌。偷取其他唤醒体至多 [Arg1] 点狂气。"
  },
  Skill_146018_tempBattleDesc_2 = {
    Text = "抽 1 张牌。偷取其他唤醒体至多 [Arg1] 点狂气，额外获得偷取值 50％ 的狂气。"
  },
  Skill_146067_Desc_1 = {
    Text = "找回卡牌并受到 <Damage:[Arg1]> 伤害。"
  },
  Skill_146067_Name_1 = {Text = "赐福?"},
  Skill_146069_Desc = {
    Text = "打出后清空手牌，并将空白钥令加入手牌。"
  },
  Skill_146069_Name = {
    Text = "获取空白钥令"
  },
  Skill_146097_Desc = {
    Text = "打出后清空手牌，并将编队钥令加入手牌。"
  },
  Skill_146097_Name = {
    Text = "获取编队钥令"
  },
  Skill_146112_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。积攒 [Arg2] 层<Shimieluotanhuodong1:战意>。打出后洗入抽牌堆。"
  },
  Skill_146112_Name = {Text = "狂之骨"},
  Skill_146113_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。获得 [Arg2] 点<PowerIconKeywords:力量>。消耗所有<Shimieluotanhuodong1:战意>，每消耗 1 层<Shimieluotanhuodong1:战意>使所有唤醒体最终伤害提高 3%。"
  },
  Skill_146113_Name = {Text = "剑之骨"},
  Skill_146114_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。打出后本回合内每受到 1 次伤害，积攒 [Arg2] 层<Shimieluotanhuodong1:战意>。"
  },
  Skill_146114_Name = {Text = "伤之骨"},
  Skill_146132_Desc = {
    Text = "新的仲夏之梦逻辑。抽 1 张牌，如果抽到指令卡或灵知觉醒，将其算力消耗变为 0，并使其拥有者获得 <Energy:[Arg1]> 点狂气。否则将这张牌弃掉并重复此条效果。"
  },
  Skill_146132_Name = {
    Text = "仲夏之梦"
  },
  Skill_146388_Desc = {
    Text = "允许释放狂气爆发"
  },
  Skill_146388_Name = {
    Text = "本源萝坦测试"
  },
  Skill_146461_Desc = {
    Text = "不需要文本，不需要翻译。"
  },
  Skill_146461_Name = {
    Text = "冥刃追灭"
  },
  Skill_146484_Desc = {
    Text = "获得 [Arg1]％ 临时伤害强效。"
  },
  Skill_146484_Name = {
    Text = "原初记忆·怒火"
  },
  Skill_146517_Desc = {
    Text = "从持有钥令中<FaxianKeywords:发现> [Arg1] 种钥令，选择 [Arg2] 个钥令使其生效 [Arg3] 次。"
  },
  Skill_146517_Name = {
    Text = "原初·双生复演"
  },
  Skill_146519_Desc = {
    Text = "从持有钥令中<FaxianKeywords:发现> [Arg1] 组钥令，每组钥令由 [Arg2] 个不同的钥令组成。选择  [Arg3] 组钥令使其中钥令依次生效  [Arg4] 次。"
  },
  Skill_146519_Name = {
    Text = "原初·三相天启"
  },
  Skill_146647_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，界域精通提高 [Arg2]。若卡拉布在队伍中，使下 1 次<DerivativeCardKeywords_152:「赐福」>不会触发「负面效果」。"
  },
  Skill_146647_Name = {
    Text = "并非谎言之物"
  },
  Skill_146648_Desc = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>，选择 1 名唤醒体偷取其他唤醒体至多 [Arg1] 点狂气。若蚀灭·萝坦在队伍中，下 1 张蚀灭·萝坦的「打击」额外生效 1 次。"
  },
  Skill_146648_Name = {
    Text = "噬鲸的风暴"
  },
  Skill_146658_Name = {Text = "第3组"},
  Skill_146659_Name = {Text = "第1组"},
  Skill_146660_Name = {Text = "第2组"},
  Skill_147427_Desc_0 = {
    Text = "在本回合中，偷取所有敌人 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_147427_Desc_4000 = {
    Text = "在本回合中，偷取所有敌人 [Arg1] 点<PowerIconKeywords:力量>。<TransitionIconKeywords:跃迁>：算力消耗变为 0 点。"
  },
  Skill_147427_EffectNameList_0 = {
    Text = "偷取力量"
  },
  Skill_147427_Name = {
    Text = "葬魂曲(未完成)"
  },
  Skill_147427_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_147428_Desc_1 = {Text = "-"},
  Skill_147428_Name_1 = {Text = "打击"},
  Skill_147429_Desc = {
    Text = "暮星·汀克特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：暮星·汀克特的所有牌获得 1 个随机效果，该刻印效果将在战斗结束时移除。"
  },
  Skill_147429_EffectNameList = {Text = "狂气"},
  Skill_147429_Name = {
    Text = "界外之音(未完成)"
  },
  Skill_147429_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_147430_Desc_1 = {Text = "-"},
  Skill_147430_Name_1 = {
    Text = "复苏之音"
  },
  Skill_147431_Desc_0 = {
    Text = "在本回合中获得 [Arg1] 点<PowerIconKeywords:力量>。所有手牌获得 1 个随机效果，该效果将在打出后或战斗结束时移除。<TransitionIconKeywords:跃迁>：随机效果获得升级。"
  },
  Skill_147431_Desc_6 = {
    Text = "在本回合中获得 [Arg1] 点<PowerIconKeywords:力量>。所有手牌获得 1 个随机效果，该效果将在打出后或战斗结束时移除。<TransitionIconKeywords:跃迁>：随机效果获得升级！"
  },
  Skill_147431_EffectNameList = {Text = "力量"},
  Skill_147431_Name = {
    Text = "棱彩幻想(未完成)"
  },
  Skill_147431_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_147432_Desc_1 = {Text = "-"},
  Skill_147432_Name_1 = {
    Text = "星彩极光"
  },
  Skill_147433_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。暮星·汀克特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_147433_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_147433_Name = {
    Text = "打击(未完成)"
  },
  Skill_147433_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_147434_Desc = {
    Text = "如果在上个回合中没有损失生命，在本回合中暴击率提高 [Arg2] %。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。"
  },
  Skill_147434_EffectNameList_0 = {Text = "伤害"},
  Skill_147434_EffectNameList_1000 = {
    Text = "伤害,额外伤害"
  },
  Skill_147434_Name = {
    Text = "深空回响(未完成)"
  },
  Skill_147434_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_147434_PropertyNameList_1000 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue1"
  },
  Skill_147435_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：占位描述"
  },
  Skill_147435_Name_1 = {
    Text = "暮星·汀克特SR(临时文本)"
  },
  Skill_147436_Desc_1 = {Text = "-"},
  Skill_147436_Name_1 = {Text = "安魂曲"},
  Skill_147437_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。暮星·汀克特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_147437_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_147437_Name = {
    Text = "防御(未完成)"
  },
  Skill_147437_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_147438_Desc_1 = {Text = "-"},
  Skill_147438_Name_1 = {
    Text = "穿云引吭"
  },
  Skill_147551_Desc = {
    Text = "临时文本"
  },
  Skill_147551_Name = {
    Text = "临时占位钥令"
  },
  Skill_147734_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] <MaxHPKeywords:最大生命>。回合开始时，对全体敌方造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_147734_Name_1 = {
    Text = "从黑暗到黑暗"
  },
  Skill_147742_BattleDesc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>或获得 [Arg1] 点临时<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_147742_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>或获得 [Arg1] 点临时<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_147742_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_147743_BattleDesc = {
    Text = "获得 1000 无视上限的银钥能量或失去 1000 点银钥能量。"
  },
  Skill_147743_Desc = {
    Text = "获得 1000 无视上限的银钥能量或失去 1000 点银钥能量。"
  },
  Skill_147743_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_147744_BattleDesc = {
    Text = "所有唤醒体获得 20 狂气或失去 20 狂气。"
  },
  Skill_147744_Desc = {
    Text = "所有唤醒体获得 20 狂气或失去 20 狂气。"
  },
  Skill_147744_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_147745_BattleDesc = {
    Text = "回复 5% 最大生命或失去 5% 最大生命。"
  },
  Skill_147745_Desc = {
    Text = "回复 5% 最大生命或失去 5% 最大生命。"
  },
  Skill_147745_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_147746_BattleDesc = {
    Text = "下回合开始时额外获得 1 张「<DerivativeCardKeywords_115:高级灵感>」，或失去 2 点算力并少抽 2 张牌。"
  },
  Skill_147746_Desc = {
    Text = "下回合开始时额外获得 1 张「<DerivativeCardKeywords_115:高级灵感>」，或失去 2 点算力并少抽 2 张牌。"
  },
  Skill_147746_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_147917_Name = {
    Text = "奢华赐福"
  },
  Skill_147918_Name = {
    Text = "暖心赐福"
  },
  Skill_147919_Name = {
    Text = "瞬发赐福"
  },
  Skill_147937_Desc = {
    Text = "获得 [Arg1] 层<MonsterPainKeywords:苦痛救赎>，此后玩家打出「<DerivativeCardKeywords_158:代罪>」时只驱散 50%<MonsterSinMarkKeywords:罪印>，并且每打出 1 张指令卡获得 1 <MonsterSinMarkKeywords:罪印>。回合结束后移除<InvincibleUntilRoused:银芯固化>。"
  },
  Skill_147937_Name = {
    Text = "净世之路"
  },
  Skill_147938_Desc = {
    Text = "每次释放钥令后使下次打出时的算力消耗降低 1 点。打出后驱散「圣子·白夜」一半<MonsterSinMarkKeywords:罪印>层数。"
  },
  Skill_147938_Name = {Text = "代罪"},
  Skill_147939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<PowerIconKeywords:力量>。"
  },
  Skill_147939_Name = {
    Text = "明灯灼魂"
  },
  Skill_147940_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<MonsterSinMarkKeywords:罪印>。"
  },
  Skill_147940_Name = {Text = "圣心"},
  Skill_147941_Desc = {
    Text = "每次释放钥令后使下次打出时的算力消耗降低 [Arg1] 点。打出后驱散「圣子·白夜」 [Arg2]%<MonsterSinMarkKeywords:罪印>层数。"
  },
  Skill_147941_Name = {Text = "代罪"},
  Skill_147942_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<MonsterPainKeywords:苦痛救赎>，施加 [Arg4] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_147942_Name = {
    Text = "无罪的圣裁"
  },
  Skill_147943_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。积攒 [Arg3] 层<MonsterPainKeywords:苦痛救赎>，施加 [Arg4] 层<FragileIconKeywords: 脆弱>。"
  },
  Skill_147943_Name = {
    Text = "照彻白夜之光"
  },
  Skill_147944_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_147944_Name = {
    Text = "离垢的审判"
  },
  Skill_148024_Desc = {
    Text = "选择 1 名唤醒体，本回合该唤醒体下次狂气爆发每消耗 1 点狂气就获得 [Arg1] 点银钥能量。"
  },
  Skill_148024_Name = {
    Text = "万化之果 - 恶魔之钥"
  },
  Skill_148025_Desc = {
    Text = "选择 1 名唤醒体，本回合该唤醒体下次狂气爆发获得的护盾和生命回复提高 [Arg1]％。"
  },
  Skill_148025_Name = {
    Text = "万化之果 - 公正之羽"
  },
  Skill_148026_Desc = {
    Text = "选择 1 名唤醒体，本回合该唤醒体指令卡造成的伤害附加 [Arg1]％ 出血。"
  },
  Skill_148026_Name = {
    Text = "万化之果 - 必灭之眼"
  },
  Skill_148027_Desc = {
    Text = "选择 1 名唤醒体，使该唤醒体算力最高的 [Arg1] 张指令卡算力消耗降低 [Arg2] 。"
  },
  Skill_148027_Name = {
    Text = "万化之果 - 预见之镜"
  },
  Skill_148028_BattleDesc = {
    Text = "选择 1 名唤醒体，本回合下 [Arg1] 次打出该唤醒体的指令卡，获得等同于 [Arg2]% 已损失生命的护盾( [Arg3] )  。消耗：下回合开始时，生成 1 张「万化之果」置入抽牌堆。"
  },
  Skill_148028_Desc = {
    Text = "选择 1 名唤醒体，本回合下 [Arg1] 次打出该唤醒体的指令卡，获得等同于 [Arg2]% 已损失生命的护盾。"
  },
  Skill_148028_Name = {
    Text = "万化之果 - 引诱之果"
  },
  Skill_148029_Desc = {
    Text = "选择 1 名唤醒体，本回合该唤醒体下次狂气爆发造成的伤害附加  [Arg1]% <CutKeywords:命运裁断>。"
  },
  Skill_148029_Name = {
    Text = "万化之果 - 命运之丝"
  },
  Skill_148042_BattleDesc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148042_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148042_Name = {
    Text = "奢华赐福·抽牌"
  },
  Skill_148043_BattleDesc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148043_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148043_Name = {
    Text = "奢华赐福·算力"
  },
  Skill_148044_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148044_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148044_Name = {
    Text = "暖心赐福·狂气"
  },
  Skill_148045_BattleDesc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148045_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148045_Name = {
    Text = "暖心赐福·算力"
  },
  Skill_148046_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148046_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148046_Name = {
    Text = "奢华赐福·狂气"
  },
  Skill_148047_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148047_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148047_Name = {
    Text = "暖心赐福·银钥能量"
  },
  Skill_148048_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148048_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148048_Name = {
    Text = "奢华赐福·伤害强效"
  },
  Skill_148049_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148049_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148049_Name = {
    Text = "奢华赐福·衰竭"
  },
  Skill_148050_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148050_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148050_Name = {
    Text = "奢华赐福·力量"
  },
  Skill_148051_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148051_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148051_Name = {
    Text = "暖心赐福·力量"
  },
  Skill_148052_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148052_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148052_Name = {
    Text = "暖心赐福·衰竭"
  },
  Skill_148053_BattleDesc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148053_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148053_Name = {
    Text = "暖心赐福·抽牌"
  },
  Skill_148054_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148054_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148054_Name = {
    Text = "奢华赐福·银钥能量"
  },
  Skill_148055_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148055_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_148055_Name = {
    Text = "暖心赐福·伤害强效"
  },
  Skill_148360_Desc = {
    Text = "切换到该意图时，破除敌方护盾并使其本回合无法获得护盾，立刻获得 [Arg3] 层<MonsterB05EXFever:狂热>。 直到回合结束，自身造成伤害附加 100%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_148360_Name = {
    Text = "桎梏仇怨"
  },
  Skill_148361_Desc = {
    Text = "切换到该意图时，破除敌方护盾并使其本回合无法获得护盾，立刻获得 [Arg3] 层<MonsterB05EXFever:狂热>。 直到回合结束，自身造成伤害附加 100%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_148361_Name = {
    Text = "缚身锁链"
  },
  Skill_148362_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并附加 [Arg3]%<BleedingIconKeywords:出血>，失去 [Arg4]%当前生命。 切换到该意图时若拥有 [Arg5] 层「恨意」，意图替换为造成 <Damage:[Damage:Arg6]> 点伤害 [AttackTimes:Arg7] 次的「嗜血链球」，否则获得 1 层「恨意」。"
  },
  Skill_148362_Name = {
    Text = "鲜血链条"
  },
  Skill_148364_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，敌方每有 3 层<BleedingIconKeywords:出血>伤害提高 1，回复 30% 已损失生命。"
  },
  Skill_148364_Name = {
    Text = "嗜血链球"
  },
  Skill_148365_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] <PowerIconKeywords:力量>。若自身生命低于 [Arg4]（50%），伤害和获得 <PowerIconKeywords:力量> 翻倍。"
  },
  Skill_148365_Name = {
    Text = "恨意宣泄"
  },
  Skill_148393_Desc = {
    Text = "回合开始时获得 [Arg1] 层<ResentChainsKeywords:怨恨锁链>。 意图切换至「嗜血链球」时，直到敌方回合结束后免疫一切伤害和生命损失效果。"
  },
  Skill_148393_Name = {
    Text = "索魂者宣言"
  },
  Skill_148499_Name = {
    Text = "魔法百宝箱"
  },
  Skill_148502_Name = {
    Text = "魔法百宝箱"
  },
  Skill_148506_Name = {
    Text = "魔法百宝箱"
  },
  Skill_148531_Desc = {
    Text = "选择 1 名唤醒体，抽 1 张该唤醒体的指令卡并使其算力消耗变为 0，该唤醒体下次狂气爆发视为超限爆发，若已为超限爆发则返还 100% 基础狂气。"
  },
  Skill_148531_Name = {
    Text = "万化之果 - 永恒之冠"
  },
  Skill_149049_Desc = {
    Text = "获得 [Arg1] 层<Guaiwusiwangdikang:死亡抵抗>。「冻结」所有<SlowIconKeywords:迟缓>的指令卡并移除其<SlowIconKeywords:迟缓>效果，移除所有唤醒体 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_149049_Name = {
    Text = "幸存者之歌"
  },
  Skill_149077_Desc = {
    Text = "切换至该意图时，吞食狂气最高唤醒体至多 <Energy:[Energy:Arg1]> 点狂气，死亡后返还。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次和等量<BleedingIconKeywords:出血>，对狂气最高的唤醒体施加 [Arg4] 层狂气封印。"
  },
  Skill_149077_Name = {Text = "吞食"},
  Skill_149078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_149078_Name = {Text = "撕咬"},
  Skill_149079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_149079_Name = {Text = "撕咬"},
  Skill_149080_Desc = {
    Text = "切换至该意图时，冻结狂气最低唤醒体 [Arg1] 张指令卡，死亡后解除该唤醒体的冻结。造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次和等量<BleedingIconKeywords:出血>，对抽牌堆或弃牌堆 [Arg4] 张卡牌施加 [Arg5] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_149080_Name = {Text = "吞食"},
  Skill_149081_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，消化吞食的狂气。"
  },
  Skill_149081_Name = {Text = "潜伏"},
  Skill_149082_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，碎裂撕咬目标唤醒体所有冻结的指令卡，将其<DepleteIconKeywords:消耗>。"
  },
  Skill_149082_Name = {Text = "潜伏"},
  Skill_149129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<WeaknessIconKeywords:虚弱>并弃置手中所有卡牌。"
  },
  Skill_149129_Name = {Text = "离散"},
  Skill_149130_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每有 [Arg3] 层<BloodOath_New:血誓>使造成的伤害提高 [Arg4] 点。"
  },
  Skill_149130_Name = {
    Text = "拥抱新生"
  },
  Skill_149131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2]次并附加等量<BleedingIconKeywords:出血>。"
  },
  Skill_149131_Name = {
    Text = "灯焰灼魂"
  },
  Skill_149132_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>。对抽牌堆或弃牌堆中 [Arg2] 张指令卡施加 [Arg3] 层<SlowIconKeywords:迟缓>，敌方各处卡牌每有 [Arg4] 层<SlowIconKeywords:迟缓>，自身获得 [Arg5] 层<BloodOath_New:血誓>。"
  },
  Skill_149132_Name = {
    Text = "倒映圣容"
  },
  Skill_149150_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<BoneHitKeywords:刺骨>，否则失去 [Arg2]% 当前生命并获得等量<CardKeyWord:霜盾>。"
  },
  Skill_149150_Name = {
    Text = "永冬意志"
  },
  Skill_149151_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BoneHitKeywords:刺骨>，若自身拥有护盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149151_Name = {Text = "冰刺"},
  Skill_149152_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<HeavyInjuryKeywords:重创>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149152_Name = {Text = "割喉"},
  Skill_149153_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复 [Arg3]% 已损失生命。"
  },
  Skill_149153_Name = {
    Text = "吸血噬咬"
  },
  Skill_149175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<BlindingKeywords:致盲>，并将 [Arg4] 张随机症状洗入对方抽牌堆。"
  },
  Skill_149175_Name = {
    Text = "灵魂布道"
  },
  Skill_149176_Desc = {
    Text = "弃置手中所有牌，并为弃牌堆所有指令卡施加 [Arg1] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_149176_Name = {
    Text = "罪火缠身"
  },
  Skill_149177_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>。对抽牌堆或弃牌堆中 [Arg2] 张指令卡施加 [Arg3] 层<SlowIconKeywords:迟缓>，敌方各处卡牌每有 [Arg4] 层<SlowIconKeywords:迟缓>，自身获得 [Arg5] 层<BloodOath_New:血誓>。"
  },
  Skill_149177_Name = {
    Text = "倒映圣容"
  },
  Skill_149178_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>。对抽牌堆或弃牌堆中 [Arg2] 张指令卡施加 [Arg3] 层<SlowIconKeywords:迟缓>，敌方各处卡牌每有 [Arg4] 层<SlowIconKeywords:迟缓>，自身获得 [Arg5] 层<BloodOath_New:血誓>。"
  },
  Skill_149178_Name = {
    Text = "倒映圣容"
  },
  Skill_149181_Desc = {
    Text = "对前排敌方造成 [Arg1] 点普通固定伤害 [Arg2] 次。"
  },
  Skill_149181_Name = {
    Text = "固定伤害测试"
  },
  Skill_149182_Desc = {
    Text = "对前排敌方造成 [Arg1] 点穿刺固定伤害 [Arg2] 次。"
  },
  Skill_149182_Name = {
    Text = "固定伤害测试"
  },
  Skill_149208_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BleedingIconKeywords:出血>，若自身拥有护盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149208_Name = {Text = "咒刺"},
  Skill_149209_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，否则失去 [Arg2]% 当前生命并获得等量<CardKeyWord:咒盾>。"
  },
  Skill_149209_Name = {
    Text = "燃灯意志"
  },
  Skill_149210_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<EmptinessKeywords: 空虚>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149210_Name = {Text = "封喉"},
  Skill_149236_Desc = {
    Text = "对前排敌方施加狂气爆发百分比修正-50"
  },
  Skill_149236_Name = {
    Text = "狂气爆发百分比修正测试"
  },
  Skill_149237_Desc = {
    Text = "对前排敌方施加狂气爆发百分比修正+50"
  },
  Skill_149237_Name = {
    Text = "狂气爆发百分比修正测试"
  },
  Skill_149239_Desc = {
    Text = "对前排敌方施加承受指令卡伤害百分比修正+50"
  },
  Skill_149239_Name = {
    Text = "承受指令卡伤害百分比修正测试"
  },
  Skill_149248_Desc = {
    Text = "对前排敌方施加承受指令卡伤害百分比修正-50"
  },
  Skill_149248_Name = {
    Text = "承受指令卡伤害百分比修正测试"
  },
  Skill_149255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每次未被格挡都会移除所有唤醒体 [Arg3] 狂气。"
  },
  Skill_149255_Name = {
    Text = "蓄势猎杀"
  },
  Skill_149256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 未被格挡伤害的<BoneHitKeywords:刺骨>。"
  },
  Skill_149256_Name = {Text = "雪灾"},
  Skill_149277_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<HeavyInjuryKeywords:重创>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149277_Name = {Text = "割喉"},
  Skill_149278_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<HeavyInjuryKeywords:重创>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149278_Name = {Text = "割喉"},
  Skill_149279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BleedingIconKeywords:出血>，若自身拥有护盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149279_Name = {Text = "咒刺"},
  Skill_149280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复 [Arg3]% 已损失生命。"
  },
  Skill_149280_Name = {
    Text = "吸血噬咬"
  },
  Skill_149281_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<EmptinessKeywords: 空虚>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149281_Name = {Text = "封喉"},
  Skill_149282_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<BoneHitKeywords:刺骨>，否则失去 [Arg2]% 当前生命并获得 [Arg2]% <CardKeyWord:霜盾>。"
  },
  Skill_149282_Name = {
    Text = "永冬意志"
  },
  Skill_149283_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<BoneHitKeywords:刺骨>，否则失去 [Arg2]% 当前生命并获得 [Arg3]% <CardKeyWord:霜盾>。"
  },
  Skill_149283_Name = {
    Text = "永冬意志"
  },
  Skill_149284_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BleedingIconKeywords:出血>，若自身拥有护盾施加的<BleedingIconKeywords:出血>翻倍。"
  },
  Skill_149284_Name = {Text = "咒刺"},
  Skill_149285_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，否则失去 [Arg2]% 当前生命并获得 [Arg4]% <CardKeyWord:咒盾>。"
  },
  Skill_149285_Name = {
    Text = "燃灯意志"
  },
  Skill_149286_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，拥有护盾时施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，否则失去 [Arg2]% 当前生命并获得 [Arg3]% <CardKeyWord:咒盾>。"
  },
  Skill_149286_Name = {
    Text = "燃灯意志"
  },
  Skill_149287_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BoneHitKeywords:刺骨>，若自身拥有护盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149287_Name = {Text = "冰刺"},
  Skill_149288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<EmptinessKeywords: 空虚>，若未被格挡则移除 [Arg4]% 死亡抵抗。"
  },
  Skill_149288_Name = {Text = "封喉"},
  Skill_149289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3]% 伤害的<BoneHitKeywords:刺骨>，若自身拥有护盾施加的<BoneHitKeywords:刺骨>翻倍。"
  },
  Skill_149289_Name = {Text = "冰刺"},
  Skill_149333_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 点<PowerIconKeywords:力量>。若负誓·奥吉尔在队伍中，负誓·奥吉尔获得 [Arg3] 点狂气，获得 1 层<KuangNu:暗涌>"
  },
  Skill_149333_Name = {
    Text = "永续新篇"
  },
  Skill_149334_Name_1 = {
    Text = "永续新篇"
  },
  Skill_149334_UnknownName = {
    Text = "永续新篇"
  },
  Skill_149345_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149345_Name = {
    Text = "暖心赐福·银钥能量"
  },
  Skill_149346_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149346_Name = {
    Text = "暖心赐福·力量"
  },
  Skill_149347_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<WeaknessIconKeywords:虚弱>，并对牌库中 [Arg4] 张指令卡施加 [Arg5] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_149347_Name = {
    Text = "粉雪魔咒"
  },
  Skill_149348_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149348_Name = {
    Text = "瞬发赐福·衰竭"
  },
  Skill_149349_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149349_Name = {
    Text = "暖心赐福·衰竭"
  },
  Skill_149350_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149350_Name = {
    Text = "暖心赐福·狂气"
  },
  Skill_149353_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149353_Name = {
    Text = "瞬发赐福·算力"
  },
  Skill_149354_Desc = {
    Text = "获得 <Block:[Block:Arg4]> 的霜盾，造成 [Arg5] 次<Bleesing_Negative:暗藏杀机>效果。发现 [Arg1] 组附带<Blessing:礼物>和<BlessingNegativeEffect:代价>的「<DerivativeCardKeywords_161:赐福>」，每组 [Arg2] 张，选择 [Arg3] 组置入手中。"
  },
  Skill_149354_Name = {
    Text = "奇迹赐福"
  },
  Skill_149355_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149355_Name = {
    Text = "瞬发赐福·银钥能量"
  },
  Skill_149356_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149356_Name = {
    Text = "瞬发赐福·狂气"
  },
  Skill_149357_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149357_Name = {
    Text = "奢华赐福·衰竭"
  },
  Skill_149358_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149358_Name = {
    Text = "奢华赐福·伤害强效"
  },
  Skill_149359_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149359_Name = {
    Text = "暖心赐福·抽牌"
  },
  Skill_149360_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149360_Name = {
    Text = "奢华赐福·狂气"
  },
  Skill_149361_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149361_Name = {
    Text = "奢华赐福·算力"
  },
  Skill_149362_Desc = {
    Text = "获得一种<MonsterBless:礼物>和一种<BlessingNegativeEffect:代价>。「赐福」共有 3 种：包括「瞬发赐福」、「奢华赐福」、「暖心赐福」。\n「瞬发赐福」：不会触发「错失良机」。\n「奢华赐福」：不会触发「夸大其词」。\n「暖心赐福」：不会触发「暗藏杀机」。"
  },
  Skill_149362_Name = {Text = "赐福"},
  Skill_149364_Desc = {
    Text = "「白雪仙女」释放「童话天衣无缝」后下 [Arg1] 个意图均为「粉雪魔咒」。 每回合将 [Arg2] 张具有 [Arg3] 层<SlowIconKeywords:迟缓>的随机「<DerivativeCardKeywords_161:赐福>」洗入牌库。"
  },
  Skill_149364_Name = {
    Text = "诱人蜜果"
  },
  Skill_149365_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149365_Name = {
    Text = "瞬发赐福·力量"
  },
  Skill_149366_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149366_Name = {
    Text = "奢华赐福·银钥能量"
  },
  Skill_149367_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149367_Name = {
    Text = "暖心赐福·算力"
  },
  Skill_149369_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149369_Name = {
    Text = "童话天衣无缝"
  },
  Skill_149372_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149372_Name = {
    Text = "暖心赐福·伤害强效"
  },
  Skill_149373_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149373_Name = {
    Text = "叮咚★仙女驾到"
  },
  Skill_149374_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149374_Name = {
    Text = "奢华赐福·抽牌"
  },
  Skill_149375_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149375_Name = {
    Text = "奢华赐福·力量"
  },
  Skill_149376_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149376_Name = {
    Text = "瞬发赐福·伤害强效"
  },
  Skill_149377_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149377_Name = {
    Text = "瞬发赐福·抽牌"
  },
  Skill_149378_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张具有 [Arg4] 层<SlowIconKeywords:迟缓>的随机「<DerivativeCardKeywords_161:赐福>」洗入牌库。"
  },
  Skill_149378_Name = {Text = "打击"},
  Skill_149636_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149636_Name = {
    Text = "叮咚★仙女驾到\n供奉算力"
  },
  Skill_149639_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149639_Name = {
    Text = "叮咚★仙女驾到\n供奉钥能"
  },
  Skill_149642_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149642_Name = {
    Text = "叮咚★仙女驾到\n供奉卡牌"
  },
  Skill_149643_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149643_Name = {
    Text = "叮咚★仙女驾到\n供奉狂气"
  },
  Skill_149644_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149644_Name = {
    Text = "童话天衣无缝\n供奉算力、卡牌"
  },
  Skill_149645_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149645_Name = {
    Text = "童话天衣无缝\n供奉钥能、狂气"
  },
  Skill_149646_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149646_Name = {
    Text = "童话天衣无缝\n供奉卡牌、狂气"
  },
  Skill_149647_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149647_Name = {
    Text = "童话天衣无缝\n供奉算力、钥能"
  },
  Skill_149648_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149648_Name = {
    Text = "童话天衣无缝\n供奉算力、狂气"
  },
  Skill_149649_Desc = {
    Text = "切换至该意图时随机向敌方索取 [Arg1] 种供奉。造成 <Damage:[Damage:Arg4]> 点伤害 [AttackTimes:Arg5] 次。成功供奉时 「白雪仙女」 生命上限提高 [Arg2]%，获得 1 层<MonsterB11_AFFull:饱餐>；否则其获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_149649_Name = {
    Text = "童话天衣无缝\n供奉钥能、卡牌"
  },
  Skill_149706_Desc_1 = {
    Text = "免疫PVP纯粹伤害，二次释放解除。"
  },
  Skill_149706_Name_1 = {
    Text = "免疫纯粹伤害"
  },
  Skill_149722_BattleDesc = {
    Text = "获得 1000 无视上限的银钥能量或失去 1000 点银钥能量。"
  },
  Skill_149722_Desc = {
    Text = "获得 1000 无视上限的银钥能量或失去 1000 点银钥能量。"
  },
  Skill_149722_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_149723_BattleDesc = {
    Text = "所有唤醒体获得 20 狂气或失去 20 狂气。"
  },
  Skill_149723_Desc = {
    Text = "所有唤醒体获得 20 狂气或失去 20 狂气。"
  },
  Skill_149723_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_149724_BattleDesc = {
    Text = "下回合开始时额外获得 1 张「<DerivativeCardKeywords_115:高级灵感>」，或失去 2 点算力并少抽 2 张牌。"
  },
  Skill_149724_Desc = {
    Text = "下回合开始时额外获得 1 张「<DerivativeCardKeywords_115:高级灵感>」，或失去 2 点算力并少抽 2 张牌。"
  },
  Skill_149724_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_149725_BattleDesc = {
    Text = "回复 5% 最大生命或失去 5% 最大生命。"
  },
  Skill_149725_Desc = {
    Text = "回复 5% 最大生命或失去 5% 最大生命。"
  },
  Skill_149725_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_149726_BattleDesc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>或获得 [Arg1] 点临时<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_149726_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>或获得 [Arg1] 点临时<ExhaustionIconKeywords:衰竭>。"
  },
  Skill_149726_Name = {
    Text = "皇家玛丽巧克力"
  },
  Skill_149842_Name = {
    Text = "刺骨寒风Skill1"
  },
  Skill_149843_Name = {
    Text = "血盆大口Attack1"
  },
  Skill_149844_Name = {
    Text = "七大「神器」之宝光ExSkill"
  },
  Skill_149845_Name = {
    Text = "刺骨寒风Skill2"
  },
  Skill_149846_Name = {
    Text = "深渊收割Attack2"
  },
  Skill_149847_Name = {
    Text = "永恒不灭之华彩Summon"
  },
  Skill_149901_Desc = {
    Text = "全部宝物特效关"
  },
  Skill_149901_Name = {
    Text = "全部宝物特效关"
  },
  Skill_149902_Name = {
    Text = "技能@巨噬蠕虫威廉支援卡3"
  },
  Skill_149903_Name = {
    Text = "技能@巨噬蠕虫N支援卡"
  },
  Skill_149904_Name = {
    Text = "技能@巨噬蠕虫威廉支援卡1"
  },
  Skill_149905_Name = {
    Text = "技能@巨噬蠕虫威廉支援卡2"
  },
  Skill_149906_Desc = {
    Text = "获取测试特效卡"
  },
  Skill_149906_Name = {
    Text = "获取测试特效卡"
  },
  Skill_149907_Desc = {
    Text = "全部宝物特效开"
  },
  Skill_149907_Name = {
    Text = "全部宝物特效开"
  },
  Skill_149959_BattleDesc = {
    Text = "抽 [Arg1] 张牌，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149959_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149959_Name = {
    Text = "奢华赐福·抽牌"
  },
  Skill_149959_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149959_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149959_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149960_BattleDesc = {
    Text = "抽 [Arg1] 张牌，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149960_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149960_Name = {
    Text = "瞬发赐福·抽牌"
  },
  Skill_149960_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149960_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149960_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149961_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149961_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149961_Name = {
    Text = "奢华赐福·银钥能量"
  },
  Skill_149961_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149961_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149961_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149962_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149962_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149962_Name = {
    Text = "奢华赐福·伤害强效"
  },
  Skill_149962_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149962_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149962_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149963_BattleDesc = {
    Text = "获得 [Arg1] 点算力，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149963_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149963_Name = {
    Text = "瞬发赐福·算力"
  },
  Skill_149963_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149963_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149963_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149964_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149964_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149964_Name = {
    Text = "奢华赐福·力量"
  },
  Skill_149964_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149964_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149964_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149965_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149965_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149965_Name = {
    Text = "瞬发赐福·狂气"
  },
  Skill_149965_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Yellow:[Arg2]> 点固定狂气。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149965_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149965_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149966_BattleDesc = {
    Text = "抽 [Arg1] 张牌，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149966_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149966_Name = {
    Text = "暖心赐福·抽牌"
  },
  Skill_149966_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149966_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149966_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149967_BattleDesc = {
    Text = "获得 [Arg1] 点算力，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149967_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149967_Name = {
    Text = "奢华赐福·算力"
  },
  Skill_149967_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149967_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149967_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149968_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149968_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149968_Name = {
    Text = "瞬发赐福·伤害强效"
  },
  Skill_149968_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149968_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149968_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149969_BattleDesc = {
    Text = "获得 [Arg1] 点算力，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149969_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149969_Name = {
    Text = "暖心赐福·算力"
  },
  Skill_149969_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149969_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149969_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149970_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149970_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149970_Name = {
    Text = "奢华赐福·狂气"
  },
  Skill_149970_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Yellow:[Arg2]> 点固定狂气。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149970_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149970_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149971_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149971_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149971_Name = {
    Text = "瞬发赐福·衰竭"
  },
  Skill_149971_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149971_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149971_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149972_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149972_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149972_Name = {
    Text = "暖心赐福·银钥能量"
  },
  Skill_149972_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149972_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149972_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149973_BattleDesc = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149973_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149973_Name = {
    Text = "暖心赐福·狂气"
  },
  Skill_149973_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Yellow:[Arg2]> 点固定狂气。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149973_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149973_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Yellow:[Arg1]> 点固定狂气。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149974_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149974_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149974_Name = {
    Text = "暖心赐福·力量"
  },
  Skill_149974_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149974_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149974_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149975_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149975_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149975_Name = {
    Text = "暖心赐福·衰竭"
  },
  Skill_149975_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149975_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149975_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149976_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149976_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149976_Name = {
    Text = "瞬发赐福·力量"
  },
  Skill_149976_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149976_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149976_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149977_BattleDesc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149977_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149977_Name = {
    Text = "奢华赐福·衰竭"
  },
  Skill_149977_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149977_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149977_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149978_BattleDesc = {
    Text = "临时伤害强效 +[Arg1]%，小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149978_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149978_Name = {
    Text = "暖心赐福·伤害强效"
  },
  Skill_149978_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149978_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149978_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149979_BattleDesc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。获得 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149979_Desc_0 = {
    Text = "获得一种具有<BlessingNegativeEffect:代价>的<Blessing:礼物>和 1 层<SacrificialMark1:供奉>。"
  },
  Skill_149979_Name = {
    Text = "瞬发赐福·银钥能量"
  },
  Skill_149979_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量。<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149979_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。<Bleesing_Delay:错失良机>：2 回合后生效。"
  },
  Skill_149979_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149995_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149995_Name = {
    Text = "奢华赐福·伤害强效"
  },
  Skill_149995_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149995_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_149995_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149996_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_149996_Name = {
    Text = "暖心赐福·抽牌"
  },
  Skill_149996_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149996_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_149996_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149997_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149997_Name = {
    Text = "瞬发赐福·抽牌"
  },
  Skill_149997_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149997_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_149997_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149998_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149998_Name = {
    Text = "瞬发赐福·算力"
  },
  Skill_149998_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149998_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_149998_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149999_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_149999_Name = {
    Text = "瞬发赐福·衰竭"
  },
  Skill_149999_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_149999_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_149999_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150000_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150000_Name = {
    Text = "暖心赐福·狂气"
  },
  Skill_150000_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150000_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150000_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150001_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150001_Name = {
    Text = "瞬发赐福·伤害强效"
  },
  Skill_150001_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150001_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150001_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150002_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150002_Name = {
    Text = "奢华赐福·狂气"
  },
  Skill_150002_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150002_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150002_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150003_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150003_Name = {
    Text = "暖心赐福·算力"
  },
  Skill_150003_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150003_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150003_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150004_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150004_Name = {
    Text = "奢华赐福·银钥能量"
  },
  Skill_150004_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150004_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150004_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150005_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150005_Name = {
    Text = "瞬发赐福·力量"
  },
  Skill_150005_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150005_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150005_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150006_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150006_Name = {
    Text = "奢华赐福·衰竭"
  },
  Skill_150006_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150006_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150006_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150007_Desc = {
    Text = "临时伤害强效 +[Arg1]%。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150007_Name = {
    Text = "暖心赐福·伤害强效"
  },
  Skill_150007_tempBattleDesc_1 = {
    Text = "临时伤害强效 +[Arg2]%，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150007_tempBattleDesc_2 = {
    Text = "临时伤害强效 +[Arg1]%，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150007_tempBattleDesc_3 = {
    Text = "临时伤害强效 +[Arg1]%，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150008_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150008_Name = {
    Text = "瞬发赐福·银钥能量"
  },
  Skill_150008_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150008_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150008_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150009_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150009_Name = {
    Text = "暖心赐福·力量"
  },
  Skill_150009_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150009_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150009_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150010_Desc = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150010_Name = {
    Text = "暖心赐福·衰竭"
  },
  Skill_150010_tempBattleDesc_1 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150010_tempBattleDesc_2 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150010_tempBattleDesc_3 = {
    Text = "临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150011_Desc = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。小心！包含<Bleesing_Exaggerate:夸大其词>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150011_Name = {
    Text = "瞬发赐福·狂气"
  },
  Skill_150011_tempBattleDesc_1 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150011_tempBattleDesc_2 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150011_tempBattleDesc_3 = {
    Text = "所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150012_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150012_Name = {
    Text = "奢华赐福·力量"
  },
  Skill_150012_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150012_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150012_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150013_Desc = {
    Text = "获得 [Arg1] 点算力。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150013_Name = {
    Text = "奢华赐福·算力"
  },
  Skill_150013_tempBattleDesc_1 = {
    Text = "获得 [Arg2] 点算力，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150013_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 点算力，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150013_tempBattleDesc_3 = {
    Text = "获得 [Arg1] 点算力，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150014_Desc = {
    Text = "抽 [Arg1] 张牌。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150014_Name = {
    Text = "奢华赐福·抽牌"
  },
  Skill_150014_tempBattleDesc_1 = {
    Text = "抽 [Arg2] 张牌，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150014_tempBattleDesc_2 = {
    Text = "抽 [Arg1] 张牌，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150014_tempBattleDesc_3 = {
    Text = "抽 [Arg1] 张牌，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_150015_Desc = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。小心！包含<Bleesing_Delay:错失良机>或<Bleesing_Exaggerate:夸大其词>效果。"
  },
  Skill_150015_Name = {
    Text = "暖心赐福·银钥能量"
  },
  Skill_150015_tempBattleDesc_1 = {
    Text = "获得 <Posse:[Arg2]> 点银钥能量，<Bleesing_Exaggerate:夸大其词>：效果减少 50％。"
  },
  Skill_150015_tempBattleDesc_2 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，<Bleesing_Delay:错失良机>：2 回合后生效 。"
  },
  Skill_150015_tempBattleDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量，给予自身随机 1 种<Bleesing_Negative:暗藏杀机>效果。"
  },
  Skill_19313_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 <Block:[Block:Arg1]> 护盾和 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19313_Name_1 = {
    Text = "冬夜追忆"
  },
  Skill_19314_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19314_Name_1 = {Text = "打击"},
  Skill_19315_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，获得正面<PVPWonderfulEffectKeywords:奇妙效果>，敌方每回合第一次使用「钥令」时将 [Arg1] 张<PVPDerivativeCardKeywords_3:「华丽光景」>置入手中。"
  },
  Skill_19315_Name_1 = {
    Text = "无声欢宴"
  },
  Skill_19316_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19316_Name_1 = {
    Text = "阿库特之春"
  },
  Skill_19320_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后回复自身 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19320_Name_1 = {
    Text = "超越死亡"
  },
  Skill_19321_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：死亡后，下回合开始时<PVPResurrectionKeywords:复活>自身并获得 <Heal:[Heal:Arg1]> 生命和<Block:[Block:Arg2]> 护盾并摧毁此「命轮」。"
  },
  Skill_19321_Name_1 = {Text = "活性"},
  Skill_19322_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19322_Name_1 = {Text = "打击"},
  Skill_19323_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 + [Arg2]。回合结束时，获得手牌中随机 [Arg1] 张「技能」的复制。"
  },
  Skill_19323_Name_1 = {
    Text = "聚首时刻"
  },
  Skill_19324_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合前 [Arg2] 张「技能」消耗的算力 - [Arg1] 。"
  },
  Skill_19324_Name_1 = {Text = "明悟"},
  Skill_19327_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，抽 [Arg1] 张牌。"
  },
  Skill_19327_Name_1 = {Text = "贪婪"},
  Skill_19328_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19328_Name_1 = {Text = "打击"},
  Skill_19329_Desc_1 = {
    Text = "<PVPResurrectionKeywords:复活>并<ComaKeywords:昏迷>一名友方，给予其 <Block:[Block:Arg1]> 护盾，若其在下回合开始时依旧死亡，则重新触发此钥令效果 1 次。"
  },
  Skill_19329_Name_1 = {
    Text = "永世执念"
  },
  Skill_19329_UnknownName = {
    Text = "永世执念"
  },
  Skill_19331_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19331_Name_1 = {Text = "打击"},
  Skill_19334_Desc_1 = {
    Text = "指定友方回复 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19334_Name_1 = {
    Text = "注射守护"
  },
  Skill_19334_UnknownName = {
    Text = "注射守护"
  },
  Skill_19337_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19337_Name_1 = {Text = "打击"},
  Skill_19339_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19339_Name_1 = {Text = "打击"},
  Skill_19340_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使双方弃掉所有手牌并抽取等量弃牌数 +1 张牌。"
  },
  Skill_19340_Name_1 = {
    Text = "快乐魔法秀"
  },
  Skill_19341_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时自身获得 <Energy:[Energy:Arg1]> 狂气，消耗所有剩余算力，每消耗 1 算力使获得狂气提高 [Arg3]。"
  },
  Skill_19341_Name_1 = {
    Text = "隐秘的诞生"
  },
  Skill_19342_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时<ComaKeywords:昏迷>自身。「狂气爆发」前驱散全体友方的负面状态。"
  },
  Skill_19342_Name_1 = {
    Text = "勋爵手杖"
  },
  Skill_19343_Desc_1 = {
    Text = "查看 [Arg1] 张其他随机「钥令」，选择 1 张置入手中。"
  },
  Skill_19343_Name_1 = {
    Text = "不平等交换"
  },
  Skill_19343_UnknownName = {
    Text = "不平等交换"
  },
  Skill_19346_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19346_Name_1 = {Text = "打击"},
  Skill_19349_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时<ComaKeywords:昏迷>自身。「狂气爆发」前驱散全体敌方的正面状态。"
  },
  Skill_19349_Name_1 = {Text = "谵妄"},
  Skill_19350_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，<PVPSeriousInjuryKeywords:重创>自身并获得 <Damage:[Damage:Arg1]> 层<PVPCorrosionKeywords:罪印>。回合结束时，<ReinforceKeywords:加固>自身。"
  },
  Skill_19350_Name_1 = {
    Text = "女王的戒律"
  },
  Skill_19353_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」回复自身 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19353_Name_1 = {Text = "吮吸"},
  Skill_19354_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」<PVPVulnerabilityIconKeywords:易伤>目标。装备和回合结束时获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19354_Name_1 = {Text = "临界点"},
  Skill_19355_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]%，「打击」可以选择目标。"
  },
  Skill_19355_Name_1 = {Text = "宠爱"},
  Skill_19356_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次「打击」额外造成<Damage:[Damage:Arg1]>伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_19356_Name_1 = {Text = "苦咒缚"},
  Skill_19358_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19358_Name_1 = {Text = "打击"},
  Skill_19360_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19360_Name_1 = {Text = "打击"},
  Skill_19361_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后抽 [Arg1] 张牌。"
  },
  Skill_19361_Name_1 = {Text = "涌现"},
  Skill_19363_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，其他友方获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_19363_Name_1 = {
    Text = "不存在之地"
  },
  Skill_19364_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」造成<PVPSeriousInjuryKeywords:重创>，伤害提高 [Arg1]%，但使自身损失一半伤害的生命。"
  },
  Skill_19364_Name_1 = {
    Text = "伤痛之鳍"
  },
  Skill_19370_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使全体友方获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_19370_Name_1 = {
    Text = "心之壁垒"
  },
  Skill_19372_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]% ，「狂气爆发」后使自身<PVPPowerIconKeywords:力量>+ [Arg2] 并使「打击」伤害额外提高 [Arg3]%，最大为 100%。"
  },
  Skill_19372_Name_1 = {
    Text = "星天之兽"
  },
  Skill_19374_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标并且扣除目标 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19374_Name_1 = {
    Text = "欲海浮沉"
  },
  Skill_19378_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19378_Name_1 = {Text = "打击"},
  Skill_19379_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使狂气最低友方获得 <Energy:[Energy:Arg1]> 狂气，并回复损失生命最多的友方 <Heal:[Heal:Arg2]> 生命。"
  },
  Skill_19379_Name_1 = {
    Text = "慈悲的哺育"
  },
  Skill_19380_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19380_Name_1 = {Text = "打击"},
  Skill_19381_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：打出卡牌后，此牌变成其他随机「命轮」，并使其算力消耗 -1 。"
  },
  Skill_19381_Name_1 = {
    Text = "灵魂诞生"
  },
  Skill_19383_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：我方唤醒体死亡时，对全体敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。装备者死亡时额外造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_19383_Name_1 = {
    Text = "珊瑚女之死"
  },
  Skill_19384_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后优先抽 [Arg1] 张「技能」，若抽出的是「技能」将其 [Arg2] 张复制置入手中。"
  },
  Skill_19384_Name_1 = {
    Text = "好运时间"
  },
  Skill_19387_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后获得 [Arg1] 算力，<DelayKeywords:延迟 1>：扣除 [Arg2] 算力。"
  },
  Skill_19387_Name_1 = {
    Text = "记忆症候"
  },
  Skill_19388_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 <Energy:[Energy:Arg1]> 狂气。友方唤醒体释放「狂气爆发」后，自身获得<DelayKeywords:延迟 1>：<Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19388_Name_1 = {
    Text = "神王的颂歌"
  },
  Skill_19389_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：将此卡变为目标装备的「命轮」 ，如果目标未装备「命轮」 则获得 [Arg1] 张「幻象」并返还消耗的算力。"
  },
  Skill_19389_Name_1 = {
    Text = "冒险的行囊"
  },
  Skill_19391_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19391_Name_1 = {Text = "打击"},
  Skill_19393_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]% ，并使自身获得<ReinforceKeywords:加固>。"
  },
  Skill_19393_Name_1 = {
    Text = "坚韧意志"
  },
  Skill_19394_Desc_1 = {
    Text = "抽 [Arg1] 张牌，获得 [Arg2] 算力。"
  },
  Skill_19394_Name_1 = {
    Text = "后发制人"
  },
  Skill_19400_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使<HPAndShieldMin:生命与护盾最低>的友方获得 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_19400_Name_1 = {Text = "致挚友"},
  Skill_19401_Desc_1 = {
    Text = "获得 [Arg1] 算力，<DelayKeywords:延迟 1>：扣除 [Arg2] 算力。"
  },
  Skill_19401_Name_1 = {
    Text = "鼠鼠的智慧"
  },
  Skill_19401_UnknownName = {
    Text = "鼠鼠的智慧"
  },
  Skill_19402_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [Arg1] 层<PVPProtectiveKeywords:屏障>，否则使手中自身算力消耗最高的 1 张「技能」算力消耗 -1。"
  },
  Skill_19402_Name_1 = {
    Text = "神言石板"
  },
  Skill_19403_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 +[Arg1]。"
  },
  Skill_19403_Name_1 = {
    Text = "记忆螺旋"
  },
  Skill_19406_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对全体敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。"
  },
  Skill_19406_Name_1 = {
    Text = "迷失的道路"
  },
  Skill_19409_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」每攻击一个目标获得 [Arg1] 算力。"
  },
  Skill_19409_Name_1 = {
    Text = "被缚的歌谣"
  },
  Skill_19411_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」造成的伤害、治疗与护盾效果提高 [Arg1]% ，使用「技能」后若没有<PVPProtectiveKeywords:屏障>则获得 1 层。"
  },
  Skill_19411_Name_1 = {
    Text = "诗笺的句尾"
  },
  Skill_19412_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」使自身获得<ReinforceKeywords:加固>。"
  },
  Skill_19412_Name_1 = {
    Text = "骑士之心"
  },
  Skill_19413_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19413_Name_1 = {Text = "打击"},
  Skill_19414_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：自身在驱散负面状态时若无可驱散的负面状态则回复 <Heal:[Heal:Arg1]> 生命。回合结束时，<DelayKeywords:延迟 1>：驱散自身负面状态。"
  },
  Skill_19414_Name_1 = {
    Text = "引舵之帆"
  },
  Skill_19415_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」造成的伤害、治疗与护盾效果提高 [Arg1]%。"
  },
  Skill_19415_Name_1 = {
    Text = "以蔷薇之名"
  },
  Skill_19418_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使全体友方获得<StrengthenKeywords:强化>。"
  },
  Skill_19418_Name_1 = {
    Text = "虔诚的伟力"
  },
  Skill_19419_Desc_1 = {
    Text = "使一名友方获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19419_Name_1 = {Text = "幻象"},
  Skill_19420_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，将 [Arg1] 张<PVPDerivativeCardKeywords_11:「不平等交换」>洗入抽牌堆。"
  },
  Skill_19420_Name_1 = {
    Text = "信息就是生命"
  },
  Skill_19421_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使自身获得<StrengthenKeywords:强化>和<ReinforceKeywords:加固>。"
  },
  Skill_19421_Name_1 = {
    Text = "跨越疼痛"
  },
  Skill_19422_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19422_Name_1 = {Text = "打击"},
  Skill_19424_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19424_Name_1 = {Text = "打击"},
  Skill_19425_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19425_Name_1 = {Text = "打击"},
  Skill_19426_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19426_Name_1 = {Text = "眷顾"},
  Skill_19430_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次受到敌方主动攻击后，对其造成 [Arg1] 伤害，<PVPEntanglementKeywords:缠绕>。"
  },
  Skill_19430_Name_1 = {
    Text = "苍白后裔"
  },
  Skill_19431_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，对全体敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，目标每有一张手牌额外造成 [Arg2] <PVPBleedingKeywords:出血>。"
  },
  Skill_19431_Name_1 = {
    Text = "血肉狂宴"
  },
  Skill_19432_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19432_Name_1 = {Text = "打击"},
  Skill_19433_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时对自身造成 [Arg2] 伤害，<PVPEntanglementKeywords:缠绕>。每有 1 个阵亡友方，<StrongEffectKeywords:强效>+[Arg1]。"
  },
  Skill_19433_Name_1 = {
    Text = "至为珍贵的藏品"
  },
  Skill_19437_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]%。每受到一次攻击，获得 [Arg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19437_Name_1 = {Text = "暴食"},
  Skill_19438_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 [Arg1] 临时<PVPRetaliateIconKeywords:反击>。"
  },
  Skill_19438_Name_1 = {
    Text = "核心熔解"
  },
  Skill_19439_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19439_Name_1 = {Text = "打击"},
  Skill_19444_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，装备者对<HPAndShieldMax:生命与护盾最高>敌方造成 [Arg1] 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_19444_Name_1 = {
    Text = "腐朽赠礼"
  },
  Skill_19446_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前驱散自身负面状态，并获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_19446_Name_1 = {
    Text = "挣脱锁链之日"
  },
  Skill_19448_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合对手打出第 [Arg1] 张「技能」时，将其一张算力消耗 - [Arg2] 的复制置入手牌。"
  },
  Skill_19448_Name_1 = {Text = "洞悉"},
  Skill_19449_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19449_Name_1 = {Text = "打击"},
  Skill_19451_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合打出的第一张装备者的「技能」伤害提高 [Arg1]%。"
  },
  Skill_19451_Name_1 = {
    Text = "巨人之刃"
  },
  Skill_19452_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19452_Name_1 = {Text = "打击"},
  Skill_19453_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得一张<PVPDerivativeCardKeywords_2:「幻象」> 。每当手牌上拥有两张<PVPDerivativeCardKeywords_2:「幻象」> 时，将它们合成为一张<PVPDerivativeCardKeywords_12:「小小心愿」>。"
  },
  Skill_19453_Name_1 = {Text = "熟成"},
  Skill_19455_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备者每回合第一次打出「技能」后，将其一张算力消耗 - [Arg1] 的复制洗入抽牌堆。"
  },
  Skill_19455_Name_1 = {
    Text = "旋转，旋转"
  },
  Skill_19456_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」「技能」「狂气爆发」造成的伤害、治疗与护盾提高 [Arg3]%，<PVPGrowthKeywords:成长> [Arg2]%。"
  },
  Skill_19456_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」「技能」「狂气爆发」造成的伤害、治疗与护盾提高 [Arg1]%，<PVPGrowthKeywords:成长> [Arg2]%。"
  },
  Skill_19456_Name_1 = {Text = "陨日"},
  Skill_19457_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」使自身获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19457_Name_1 = {Text = "狂乱"},
  Skill_19458_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」攻击<HPAndShieldMax:生命与护盾最高>的敌方，并额外造成伤害 [Arg1]% 的 <PVPBleedingKeywords:出血>。"
  },
  Skill_19458_Name_1 = {
    Text = "切割与伤害"
  },
  Skill_19460_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标并且造成 [Arg1] 层<PVPSlowKeywords:迟缓>，每回合对首个目标触发时效果翻倍。"
  },
  Skill_19460_Name_1 = {
    Text = "遗忘之手"
  },
  Skill_19463_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19463_Name_1 = {Text = "打击"},
  Skill_19465_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19465_Name_1 = {Text = "打击"},
  Skill_19466_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Block:[Block:Arg1]> 护盾，其他友方获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_19466_Name_1 = {
    Text = "无法完成的演算"
  },
  Skill_19467_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：因为失去生命而获得的狂气翻倍。"
  },
  Skill_19467_Name_1 = {Text = "海之梦"},
  Skill_19468_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使一张算力消耗最高的手牌消耗的算力 -[Arg1]。"
  },
  Skill_19468_Name_1 = {
    Text = "专注精神"
  },
  Skill_19470_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19470_Name_1 = {
    Text = "畸体回噬"
  },
  Skill_19471_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_19471_Name_1 = {Text = "放逐"},
  Skill_19473_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，回复损失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19473_Name_1 = {Text = "希冀"},
  Skill_19475_Desc_1 = {
    Text = "弃掉所有手牌，并抽取相应张数的牌，若手牌为空则获得随机 [Arg1] 张钥令。"
  },
  Skill_19475_Name_1 = {
    Text = "纯白初遇"
  },
  Skill_19475_UnknownName = {
    Text = "纯白初遇"
  },
  Skill_19477_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，自身获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19477_Name_1 = {Text = "呢喃"},
  Skill_19479_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后将上回合最后打出的「技能」置入手中，并使其算力消耗 -1，若多次触发该类效果则向前追溯。"
  },
  Skill_19479_Name_1 = {
    Text = "溯洄时计"
  },
  Skill_19483_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后将 [Arg1] 张<PVPDerivativeCardKeywords_11:「不平等交换」>置入手中。"
  },
  Skill_19483_Name_1 = {
    Text = "于暴雨之中"
  },
  Skill_19484_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使其他友方获得 <Energy:[Energy:Arg1]> 狂气，此效果溢出的狂气将折半返还给装备者。"
  },
  Skill_19484_Name_1 = {
    Text = "职责所在"
  },
  Skill_19486_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：死亡后给予其他友方 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_19486_Name_1 = {
    Text = "死亡的剖析"
  },
  Skill_19487_BattleDesc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，每点<PVPCapKeywords:算力上限>对<HPAndShieldMin:生命与护盾最低>敌方造成 [Arg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>伤害。"
  },
  Skill_19487_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，每点<PVPCapKeywords:算力上限>对<HPAndShieldMin:生命与护盾最低>敌方造成 [Arg1] <PVPBleedingKeywords:出血>。"
  },
  Skill_19487_Name_1 = {
    Text = "伏于夜色"
  },
  Skill_19489_Desc_1 = {
    Text = "给予一名友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_19489_Name_1 = {
    Text = "小小心愿"
  },
  Skill_19489_UnknownName = {
    Text = "小小心愿"
  },
  Skill_19493_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [Arg1]% ，「狂气爆发」后回复自身 <Heal:[Heal:Arg2]> 生命。"
  },
  Skill_19493_Name_1 = {
    Text = "吞噬摇篮曲"
  },
  Skill_19495_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后<DelayKeywords:延迟 1>：回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_19495_Name_1 = {
    Text = "饕餮寓言"
  },
  Skill_19497_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对全体敌方造成 [Arg1] 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_19497_Name_1 = {Text = "惩戒"},
  Skill_19499_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_19499_Name_1 = {
    Text = "脑中之音"
  },
  Skill_19499_UnknownName = {
    Text = "脑中之音"
  },
  Skill_20075_Desc = {
    Text = "击退前排敌方。"
  },
  Skill_20075_Name = {
    Text = "相位变换"
  },
  Skill_20841_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_20841_Name = {
    Text = "沸腾吧！血"
  },
  Skill_20842_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_20842_Name = {
    Text = "血与沙之歌"
  },
  Skill_20843_Desc = {
    Text = "获得[Arg1]点护盾，施加 [Arg2] 层<BleedingIconKeywords:出血>。"
  },
  Skill_20843_Name = {
    Text = "尖啸吧！血"
  },
  Skill_20844_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_20850_Desc = {
    Text = "将「猩红」的一次行动意图扭曲为低威胁的单次攻击。"
  },
  Skill_20850_Name = {
    Text = "契约回响"
  },
  Skill_20974_Desc = {
    Text = "该意图无法被誓约回响扭曲。获得 「血之狂暴·终结」 状态，失去一定生命后会释放极高伤害的狂气爆发。"
  },
  Skill_20974_Name = {Text = "觉醒"},
  Skill_20975_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。并将两张「融蚀」洗入抽牌堆。"
  },
  Skill_20975_Name = {
    Text = "血与沙之歌·狂"
  },
  Skill_21308_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每受到 1 次攻击减少 1 次攻击次数，至少 3 次。"
  },
  Skill_21308_Name = {
    Text = "血怒连击(破绽)"
  },
  Skill_21313_Desc_1 = {
    Text = "使一名目标获得 <PVPVulnerabilityIconKeywords:易伤>。"
  },
  Skill_21313_Name_1 = {Text = "易伤"},
  Skill_21314_Desc_1 = {
    Text = "使一名目标获得 <StrengthenKeywords:强化>。"
  },
  Skill_21314_Name_1 = {Text = "强化"},
  Skill_21315_Desc_1 = {
    Text = "使一名目标获得 <WeaknessIconKeywords:虚弱>。"
  },
  Skill_21315_Name_1 = {Text = "虚弱"},
  Skill_21316_Desc_1 = {
    Text = "使一名目标获得 <ReinforceKeywords:加固>。"
  },
  Skill_21316_Name_1 = {Text = "加固"},
  Skill_21320_Desc_1 = {
    Text = "丢掉所有牌。"
  },
  Skill_21320_Name_1 = {
    Text = "丢弃所有手牌"
  },
  Skill_21321_Desc_1 = {
    Text = "执行测试指令。"
  },
  Skill_21321_Name_1 = {
    Text = "测试指令"
  },
  Skill_21330_Desc_1 = {
    Text = "对一名目标造成 <Damage:[Damage:Arg1]> 伤害和等量<PVPMethysisKeywords:中毒>。"
  },
  Skill_21330_Name_1 = {Text = "中毒"},
  Skill_21332_Desc_1 = {
    Text = "造成[Arg1]伤害并 <ComaKeywords:昏迷>。"
  },
  Skill_21332_Name_1 = {Text = "昏迷"},
  Skill_21333_Desc_1 = {
    Text = "驱散一名目标的正面效果。"
  },
  Skill_21333_Name_1 = {
    Text = "驱散正面"
  },
  Skill_21334_Desc_1 = {
    Text = "使一名目标获得 <TauntKeywords:嘲讽>。"
  },
  Skill_21334_Name_1 = {Text = "嘲讽"},
  Skill_21336_Desc_1 = {
    Text = "使一名目标获得 <DelayKeywords:延迟 1>：<Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_21336_Name_1 = {
    Text = "延迟狂气"
  },
  Skill_21337_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 临时<StrengthenKeywords:反击>。"
  },
  Skill_21337_Name_1 = {Text = "反击"},
  Skill_21338_Desc_1 = {
    Text = "使一名目标获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_21338_Name_1 = {Text = "狂气"},
  Skill_21339_Desc_1 = {
    Text = "驱散一名目标的负面效果。"
  },
  Skill_21339_Name_1 = {
    Text = "驱散负面"
  },
  Skill_21341_Desc_1 = {
    Text = "使一名目标获得 <StrengthenKeywords:护盾>。"
  },
  Skill_21341_Name_1 = {Text = "护盾"},
  Skill_21355_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 层<StrengthenKeywords:迟缓>。"
  },
  Skill_21355_Name_1 = {Text = "迟缓"},
  Skill_21356_Desc_1 = {
    Text = "使一个目标获得 <DelayKeywords:延迟 1>：抽 [Arg1] 张牌。"
  },
  Skill_21356_Name_1 = {
    Text = "延迟抽牌"
  },
  Skill_21357_Desc_1 = {
    Text = "使一名目标失去 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_21357_Name_1 = {
    Text = "失去狂气"
  },
  Skill_21361_Desc_1 = {
    Text = "使一名目标获得 <DelayKeywords:延迟 1>： <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_21361_Name_1 = {
    Text = "延迟治疗"
  },
  Skill_21362_Desc_1 = {
    Text = "<PVPResurrectionKeywords:复活>一名目标使其获得 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_21362_Name_1 = {Text = "复活"},
  Skill_21379_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_21403_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_21582_BattleDesc_1 = {
    Text = "弃掉所有牌，生成目标套牌，算力加到50，获得一张狂气。"
  },
  Skill_21582_Desc_1 = {
    Text = "弃掉所有牌，生成目标套牌，算力加到50，获得一张狂气，可以使用100次。"
  },
  Skill_21582_Name_1 = {
    Text = "生成套牌"
  },
  Skill_21602_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 层<EnergyStorageColour:蓄力>。"
  },
  Skill_21602_Name_1 = {Text = "蓄力"},
  Skill_21603_Desc_1 = {
    Text = "使一名目标获得 [Arg1] <PowerColourKeywords:力量>。"
  },
  Skill_21603_Name_1 = {Text = "力量"},
  Skill_21615_AwakerSkillBackgroundStory = {
    Text = "奥吉尔的记忆因融蚀现象而支离破碎。\n他记得舞会上的欢笑，却忘记了舞会主角的姓名；他记得自己在骑士团受训，却不知道大公为何让年幼的他成为骑士；他记得自己葬身铁骑之下，却无法记起自己所守护的是怎样的笑容。\n没人能苛责他，他已经做到了骑士应尽的一切责任——包括为了守护的意志而献出生命。"
  },
  Skill_21615_Desc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态。获得 <Block:[Block:Arg1]> 点护盾。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_21615_Desc_2 = {
    Text = "若自身拥有<FragileIconKeywords:脆弱>状态，则驱散并获得 <Block:[Block:Arg3]> 点护盾。获得 <Block:[Block:Arg1]> 点护盾。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_21615_EffectNameList_0 = {
    Text = "护盾,力量"
  },
  Skill_21615_EffectNameList_2 = {
    Text = "驱散获得护盾,护盾,力量"
  },
  Skill_21615_Name = {
    Text = "七艺，传承美德"
  },
  Skill_21615_OverLimitUtlSkillDesc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态。获得 <Block:[Block:Arg1]> 点护盾。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得的护盾提高 200%。奥吉尔造成的伤害次数 +1，持续 3 回合。"
  },
  Skill_21615_OverLimitUtlSkillDesc_2 = {
    Text = "若自身拥有<FragileIconKeywords:脆弱>状态，则驱散并获得 <Block:[Block:Arg3]> 点护盾。获得 <Block:[Block:Arg1]> 点护盾。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得的护盾提高 200%。奥吉尔造成的伤害次数 +1，持续 3 回合。"
  },
  Skill_21615_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_21615_PropertyNameList_2 = {
    Text = "防御力*GrowValue3,防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_21620_AwakerSkillBackgroundStory = {
    Text = "理性决定了她的视物角度，真理构筑了她的思维广度，现实则束缚了她的道德尺度。\n对这名不世天才而言，科学，亦是一种哲学。"
  },
  Skill_21620_Desc_0 = {
    Text = "驱散自身<VulnerabilityIconKeywords:易伤>状态。回复 <Heal:[Heal:Arg1]> 点生命，其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_21620_Desc_3 = {
    Text = "驱散自身<VulnerabilityIconKeywords:易伤>状态。回复 <Heal:[Heal:Arg1]> 点生命，所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_21620_EffectNameList_0 = {
    Text = "回复,狂气"
  },
  Skill_21620_EffectNameList_7 = {
    Text = "回复,狂气,每回合回复"
  },
  Skill_21620_Name = {
    Text = "理性，真理与现实"
  },
  Skill_21620_OverLimitUtlSkillDesc_0 = {
    Text = "驱散自身<VulnerabilityIconKeywords:易伤>状态。回复 <Heal:[Heal:Arg1]> 点生命，其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。回合开始时回复 <Heal:[Heal:Arg3]> 点生命，持续 3 回合。"
  },
  Skill_21620_OverLimitUtlSkillDesc_3 = {
    Text = "驱散自身<VulnerabilityIconKeywords:易伤>状态。回复 <Heal:[Heal:Arg1]> 点生命，所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。回合开始时回复 <Heal:[Heal:Arg3]> 点生命，持续 3 回合。"
  },
  Skill_21620_PropertyNameList_0 = {
    Text = "体质*GrowValue1,$GrowValue2"
  },
  Skill_21620_PropertyNameList_7 = {
    Text = "体质*GrowValue1,$GrowValue2,体质*GrowValue3"
  },
  Skill_21663_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。觉醒后，每回合移除 3 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>状态。"
  },
  Skill_21663_Name = {
    Text = "战欲难平"
  },
  Skill_21668_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_21672_Desc_1 = {
    Text = "对敌方全体造成30伤害。"
  },
  Skill_21672_Name_1 = {
    Text = "造成范围伤害"
  },
  Skill_21721_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，全体获得 [Arg3] 点护盾，将 2 张<DerivativeCardKeywords_26:「症状：妄想」>洗入抽牌堆。"
  },
  Skill_21721_Name = {
    Text = "隐匿突袭"
  },
  Skill_21783_Desc_1 = {
    Text = "击杀一名目标。"
  },
  Skill_21783_Name_1 = {Text = "击杀"},
  Skill_21837_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_21837_Name = {Text = "撕咬"},
  Skill_21902_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_21939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_21939_Name = {Text = "出血"},
  Skill_21940_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害失去一层，回合结束失去全部。"
  },
  Skill_21940_Name = {Text = "祈祷"},
  Skill_21948_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害减少一层，回合结束失去全部。"
  },
  Skill_21948_Name = {Text = "祈祷"},
  Skill_21949_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量伤害<BleedingIconKeywords:出血>。"
  },
  Skill_21949_Name = {Text = "出血"},
  Skill_22056_Desc = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_22056_Name = {
    Text = "复仇宣言"
  },
  Skill_22152_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点<CardKeyWord:霜盾>，并对玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_22152_Name = {
    Text = "深海呼唤"
  },
  Skill_22153_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22154_Desc = {
    Text = "自身死亡，分裂为两个生命与自身相当的「海中之物」。"
  },
  Skill_22154_Name = {Text = "分裂"},
  Skill_22155_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。下回合开始时将 [Arg3] 张<DerivativeCardKeywords_80:「窒息」>置入手中。"
  },
  Skill_22156_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22162_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点<CardKeyWord:霜盾>，并对玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_22162_Name = {
    Text = "深海呼唤"
  },
  Skill_22196_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点<CardKeyWord:霜盾>，并对玩家施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_22196_Name = {
    Text = "深海呼唤"
  },
  Skill_22197_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22198_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。下回合获得 [Arg3] 张<DerivativeCardKeywords_80:「窒息」>。"
  },
  Skill_22199_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22209_Desc_1 = {
    Text = "让对手无法打出指令卡和打击。"
  },
  Skill_22209_Name_1 = {
    Text = "超级迟缓"
  },
  Skill_22212_Desc_1 = {
    Text = "使一名目标获得 [Arg1] <EnergyStorageColour:死斗>。"
  },
  Skill_22212_Name_1 = {Text = "死斗"},
  Skill_22218_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，对抽牌堆顶部的 [Arg3] 张卡牌造成 [Arg4] 层迟缓。"
  },
  Skill_22218_Name = {
    Text = "寒气打击"
  },
  Skill_22233_Desc = {
    Text = "进化为「维度干涉型融蚀体」。当前生命越高进化的怪物就越强。"
  },
  Skill_22233_Name = {
    Text = "融蚀进化"
  },
  Skill_22234_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将一张<DerivativeCardKeywords_45:「维度闭锁」>加入玩家手牌。"
  },
  Skill_22234_Name = {
    Text = "维度封锁"
  },
  Skill_22306_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点 <CardKeyWord:霜盾>。"
  },
  Skill_22306_Name = {
    Text = "冰盾打击"
  },
  Skill_22316_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。赋予玩家  [Arg3] 张随机卡牌<CardKeyWord:「怒涛印记」>：使用有该标记的卡牌后会让本回合怪物的攻击段数+1，怒涛印记打出后会移除。"
  },
  Skill_22316_Name = {
    Text = "怒涛牵引"
  },
  Skill_22317_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，本回合每受到一次攻击，获得 [Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_22317_Name = {
    Text = "巨刃斩击"
  },
  Skill_22318_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加 [Arg3] 层寄生。"
  },
  Skill_22318_Name = {
    Text = "附骨侵蚀"
  },
  Skill_22319_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_22319_Name = {Text = "深潜"},
  Skill_22320_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22320_Name = {Text = "挥砍"},
  Skill_22331_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_22332_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_22333_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<CardKeyWord:创伤>。创伤：打出「打击」后，在抽牌堆顶部添加 2  张「伤口」。"
  },
  Skill_22333_Name = {
    Text = "创伤重击"
  },
  Skill_22344_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_22345_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<CardKeyWord:创伤>。创伤：打出「打击」后，在抽牌堆顶部添加 2  张「伤口」。"
  },
  Skill_22345_Name = {
    Text = "创伤猛击"
  },
  Skill_22346_Desc = {
    Text = "获得[Arg1]点<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_22698_Desc_1 = {
    Text = "将随机 1~[Arg1] 张<PVPDerivativeCardKeywords_2:「幻象」> 塞入抽牌堆。"
  },
  Skill_22698_Name_1 = {
    Text = "塞幻象入抽牌堆"
  },
  Skill_22700_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_22700_Name = {
    Text = "维度雾气"
  },
  Skill_23407_Desc = {
    Text = "获得[Arg1]点护盾和等同于当前<RetaliateIconKeywords:反击>的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_23407_Name = {
    Text = "逆鳞之护"
  },
  Skill_23408_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23409_Desc = {
    Text = "获得等同于当前<RetaliateIconKeywords:反击>的<PowerIconKeywords:力量>。之后每回合还会获得 [Arg1] 层反击。"
  },
  Skill_23409_Name = {
    Text = "蜕变之躯"
  },
  Skill_23410_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_23410_Name = {
    Text = "破碎沉戟"
  },
  Skill_23411_Desc = {
    Text = "获得 [Arg2] 点护盾和 [Arg1] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_23411_Name = {
    Text = "承自异端之血"
  },
  Skill_23467_Desc = {
    Text = "从 3 个意图中选择 2 个附加至达芙黛尔的行动意图。"
  },
  Skill_23467_Name = {
    Text = "千面幻象·实"
  },
  Skill_23468_Desc = {
    Text = "从 3 个意图中选择 2 个附加至达芙黛尔的行动意图。"
  },
  Skill_23468_Name = {
    Text = "千面幻象·实"
  },
  Skill_23469_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将「症状：谵妄」与「症状：盲从」洗入抽牌堆。"
  },
  Skill_23469_Name = {
    Text = "连击+症状"
  },
  Skill_23470_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<BleedingIconKeywords:出血>。"
  },
  Skill_23470_Name = {
    Text = "连击+出血"
  },
  Skill_23471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。降低所有唤醒体 [Arg3] 点狂气。"
  },
  Skill_23471_Name = {
    Text = "连击+降狂气"
  },
  Skill_23472_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。降低敌人 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_23472_Name = {
    Text = "伤害+力量降低"
  },
  Skill_23473_Desc = {
    Text = "将「症状：谵妄」与「症状：盲从」洗入抽牌堆。"
  },
  Skill_23473_Name = {
    Text = "VL-13号胶卷"
  },
  Skill_23474_Desc = {
    Text = "降低所有唤醒体狂气 [Arg1] 点。"
  },
  Skill_23474_Name = {
    Text = "VL-9号胶卷"
  },
  Skill_23475_Desc = {
    Text = "攻击施加 [Arg1] 层<BleedingIconKeywords:出血>"
  },
  Skill_23475_Name = {
    Text = "VL-7号胶卷"
  },
  Skill_23476_Desc = {
    Text = "施加[Arg1]层力量降低。"
  },
  Skill_23476_Name = {
    Text = "亮晶晶的头颅"
  },
  Skill_23477_Desc = {
    Text = "增加1次攻击。"
  },
  Skill_23477_Name = {
    Text = "吵闹的头颅"
  },
  Skill_23478_Desc = {
    Text = "施加 2 层易伤。"
  },
  Skill_23478_Name = {
    Text = "咆哮的头颅"
  },
  Skill_23479_Desc = {
    Text = "获得 [Arg1] 点护盾。"
  },
  Skill_23480_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23481_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，分别将 1 张<DerivativeCardKeywords_45:「维度闭锁」>洗入玩家的抽牌堆和弃牌堆。"
  },
  Skill_23481_Name = {
    Text = "原质之海"
  },
  Skill_23482_Desc = {
    Text = "获得 [Arg1] 点护盾。"
  },
  Skill_23483_Desc = {
    Text = "强化「千面幻象」的效果：需要选择两次意图。若弃掉，则所有唤醒体失去 20 狂气，并将 5 张「症状」洗入玩家抽牌堆。"
  },
  Skill_23483_Name = {
    Text = "维度投射"
  },
  Skill_23484_Desc = {
    Text = "获得 [Arg1] 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_23484_Name = {
    Text = "护盾+伤害"
  },
  Skill_23485_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<BleedingIconKeywords:出血>，塞入2张「症状：谵妄」。"
  },
  Skill_23485_Name = {
    Text = "连击+出血+症状"
  },
  Skill_23486_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，降低所有唤醒体 [Arg3] 点狂气，塞入 2 张「症状：谵妄」。"
  },
  Skill_23486_Name = {
    Text = "连击+降低狂气+症状"
  },
  Skill_23487_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23488_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23489_Desc = {
    Text = "从 3 个意图中选择 2 个附加至达芙黛尔的行动意图。"
  },
  Skill_23489_Name = {
    Text = "千面幻象·实"
  },
  Skill_23490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_23490_Name = {
    Text = "断颈一击"
  },
  Skill_23491_Desc = {
    Text = "获得 [Arg1] 点护盾，提升 [Arg2] 点力量。"
  },
  Skill_23491_Name = {
    Text = "护盾+力量"
  },
  Skill_23492_Desc = {
    Text = "获得 [Arg1] 点护盾,并驱散达芙黛尔的所有负面状态。"
  },
  Skill_23492_Name = {Text = "护盾"},
  Skill_23493_Desc = {
    Text = "获得 [Arg1] 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_23493_Name = {
    Text = "护盾+伤害"
  },
  Skill_23494_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。降低所有唤醒体 [Arg3] 点狂气，施加 [Arg4] 层<BleedingIconKeywords:出血>，将「症状：谵妄」与「症状：盲从」洗入抽牌堆。"
  },
  Skill_23494_Name = {
    Text = "千面幻象"
  },
  Skill_23495_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_23495_Name = {
    Text = "伤害+易伤"
  },
  Skill_23496_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。降低敌人 [Arg3] 点<PowerIconKeywords:力量>。施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_23496_Name = {
    Text = "伤害+易伤+力量降低"
  },
  Skill_23497_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。"
  },
  Skill_23497_Name = {
    Text = "食脑水仙"
  },
  Skill_23498_Desc = {
    Text = "获得 [Arg1] 点护盾，并驱散达芙黛尔的所有负面状态。"
  },
  Skill_23498_Name = {
    Text = "食腐水仙"
  },
  Skill_23499_Desc = {
    Text = "提升 [Arg1] 点力量。"
  },
  Skill_23499_Name = {
    Text = "食肉水仙"
  },
  Skill_23500_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，降低敌人 [Arg3] 点<PowerIconKeywords:力量>，施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_23500_Name = {
    Text = "千面幻象"
  },
  Skill_23501_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23501_Name = {Text = "伤害"},
  Skill_23502_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，降低敌人 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_23502_Name = {
    Text = "伤害+力量降低"
  },
  Skill_23503_Desc = {
    Text = "获得 [Arg1] 点护盾，提升 [Arg2] 点力量。"
  },
  Skill_23503_Name = {
    Text = "护盾+力量"
  },
  Skill_23504_Desc = {
    Text = "获得 [Arg1] 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。获得 [Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_23504_Name = {
    Text = "护盾+伤害+力量"
  },
  Skill_23505_Desc = {
    Text = "从3个意图中选择1个附加至达芙黛尔的行动意图。"
  },
  Skill_23505_Name = {
    Text = "千面幻象·虚"
  },
  Skill_23506_Desc = {
    Text = "从 3 个意图中选择 1 个附加至达芙黛尔的行动意图。"
  },
  Skill_23506_Name = {
    Text = "千面幻象·虚"
  },
  Skill_23507_Desc = {
    Text = "从 3 个意图中选择 1 个附加至达芙黛尔的行动意图。"
  },
  Skill_23507_Name = {
    Text = "千面幻象·虚"
  },
  Skill_23508_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_23508_Name = {
    Text = "伤害+易伤"
  },
  Skill_23509_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_23509_Name = {
    Text = "断颈一击"
  },
  Skill_23510_Desc = {
    Text = "获得 [Arg1] 点护盾，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。获得 [Arg4] 点<PowerIconKeywords:力量>。驱散达芙黛尔的所有负面状态。"
  },
  Skill_23510_Name = {
    Text = "千面幻象"
  },
  Skill_23511_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<BleedingIconKeywords:出血>，降低所有唤醒体 [Arg4] 点狂气。"
  },
  Skill_23511_Name = {
    Text = "连击+出血+降低狂气"
  },
  Skill_23729_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每当造成未被格挡的伤害，就会造成 1 层<FragileIconKeywords:脆弱>。"
  },
  Skill_23729_Name = {Text = "追猎"},
  Skill_23756_Desc = {
    Text = "打出后受到 [Arg1] 点<FixedDamage:纯粹伤害>，抽 2 张牌。"
  },
  Skill_23756_Name = {Text = "鬼牌"},
  Skill_23758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将玩家本回合最后打出的指令卡移回牌库顶并使对方下回合抽牌数 -1 。"
  },
  Skill_23758_Name = {
    Text = "隔空取物"
  },
  Skill_23761_Desc = {
    Text = "卡茜亚获得「移形换影」。对方打出卡牌 10 次后立即在身前召唤 1 个少量生命的「分身」。"
  },
  Skill_23761_Name = {Text = "觉醒"},
  Skill_23810_Desc = {
    Text = "<TouquKeywords:永久偷取> [Arg1] 点<PowerIconKeywords:力量>，下回合开始时对方抽牌数-3，并展示牌库顶的三张牌，对方选择 1 张加入手牌。"
  },
  Skill_23810_Name = {
    Text = "统统消失！"
  },
  Skill_23811_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张算力消耗为 3 的「跳动的炸弹」立刻置入玩家手牌。霍迪妮每有 1 层「洋洋得意」，「跳动的炸弹」的算力消耗减少 1 点。"
  },
  Skill_23811_Name = {
    Text = "无中生有"
  },
  Skill_23812_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_23812_Name = {
    Text = "魔术牌：穿破"
  },
  Skill_23813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。同时将 5 张「亵渎假象」卡牌置入手牌，霍迪妮每有 1 层「洋洋得意」，会将其中 1 张「亵渎假象」替换为「灵感」。"
  },
  Skill_23813_Name = {
    Text = "特技飞牌"
  },
  Skill_23814_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 5 张「鬼牌」分别塞入对方的手牌堆，抽牌堆和弃牌堆。"
  },
  Skill_23814_Name = {
    Text = "魔术嘉年华"
  },
  Skill_23815_Desc = {
    Text = "在自身前方召唤 1 个「霍迪妮」的玩偶。每有 1 层「洋洋得意」会减降低其 20% 的最大生命值，最低降至 1 点。"
  },
  Skill_23815_Name = {
    Text = "大变活人"
  },
  Skill_23816_Desc = {
    Text = "将 1 张带有「消耗」和「保留」的「幸运观众」置入对方手牌。"
  },
  Skill_23816_Name = {
    Text = "幸运观众"
  },
  Skill_23817_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_23817_Name = {
    Text = "魔术牌：衰弱"
  },
  Skill_23818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_23818_Name = {
    Text = "魔术连打"
  },
  Skill_23819_Desc = {
    Text = "炸弹每在手牌中经过 1 回合计数会增加 1，计数到达 2 时且回合结束时若在手牌，对己方队伍造成 <Damage:[Damage:Arg1]> 点<FixedDamage:纯粹伤害>且销毁。当前计数：<RedQuality:[Arg2]>。"
  },
  Skill_23819_Name = {
    Text = "跳动的炸弹"
  },
  Skill_23820_Desc = {
    Text = "炸弹每在手牌中经过 1 回合计数会增加 1，计数到达 2 时且回合结束时若在手牌，对己方队伍造成 <Damage:[Damage:Arg1]> 点<FixedDamage:纯粹伤害>且销毁。当前计数：<RedQuality:[Arg2]>。"
  },
  Skill_23820_Name = {
    Text = "跳动的炸弹"
  },
  Skill_23821_Desc = {
    Text = "炸弹每在手牌中经过 1 回合计数会增加 1，计数到达 2 时且回合结束时若在手牌，对己方队伍造成 <Damage:[Damage:Arg1]> 点<FixedDamage:纯粹伤害>且销毁。当前计数：<RedQuality:[Arg2]>。"
  },
  Skill_23821_Name = {
    Text = "跳动的炸弹"
  },
  Skill_23822_Desc = {
    Text = "炸弹每在手牌中经过 1 回合计数会增加 1，计数到达 2 时且回合结束时若在手牌，对己方队伍造成 <Damage:[Damage:Arg1]> 点<FixedDamage:纯粹伤害>且销毁。当前计数：<RedQuality:[Arg2]>。"
  },
  Skill_23822_Name = {
    Text = "跳动的炸弹"
  },
  Skill_24173_Desc_1 = {
    Text = "指定的所有唤醒体将不再死亡。"
  },
  Skill_24173_Name_1 = {
    Text = "免疫死亡"
  },
  Skill_24209_Desc = {
    Text = "失去 [Arg1]% 当前生命([Arg2])，使「神国腕肢」对后排敌方造成 3 倍伤害([Arg3])，若在首领战中则造成 10 倍伤害([Arg4])。"
  },
  Skill_24209_Name = {
    Text = "代行者的裁决"
  },
  Skill_24243_Desc = {
    Text = "正在寻找它的下一个目标…"
  },
  Skill_24243_Name = {Text = "寻踪"},
  Skill_24244_Desc = {
    Text = "选择一名唤醒体，获得 50 狂气。但使「海德拉」获得 [Arg1] 点力量。"
  },
  Skill_24244_Name = {Text = "执念"},
  Skill_24417_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_24417_Name = {
    Text = "神眷之刃"
  },
  Skill_24418_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_24418_Name = {
    Text = "无上生祭"
  },
  Skill_24586_Desc = {
    Text = "造成 1 次 <Damage:[Damage:Arg1]> 点伤害，自身死亡。"
  },
  Skill_24586_Name = {
    Text = "临别赠礼"
  },
  Skill_24587_Desc = {
    Text = "对方本回合使用算力 3 及以上的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24587_Name = {
    Text = "「低语」\n算力 ≥3"
  },
  Skill_24604_Desc = {
    Text = "击晕所有「N」的分身。"
  },
  Skill_24604_Name = {
    Text = "蔷薇的愿望"
  },
  Skill_24605_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。自身施加 1 层「黑暗」和 4 层「混沌」状态，每有一层「黑暗」状态生成一个分身，最多生成 3 个。"
  },
  Skill_24605_Name = {
    Text = "黑色召唤"
  },
  Skill_24606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张「无上蒙宠」置入对方手牌。"
  },
  Skill_24606_Name = {
    Text = "盲目契约"
  },
  Skill_24607_Desc = {
    Text = "获得 2 点算力，将一张能够击晕分身的「蔷薇的愿望」加入手中，对抽牌堆中 4 张牌施加<SlowIconKeywords:迟缓>。"
  },
  Skill_24607_Name = {
    Text = "无上蒙宠"
  },
  Skill_24608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_24609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对全体友方施加 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_24609_Name = {
    Text = "伏行之雾"
  },
  Skill_24634_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 4 张「轮回悖论」加入手牌。"
  },
  Skill_24634_Name = {
    Text = "四翼渐生"
  },
  Skill_24635_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 6 张「轮回悖论」加入手牌。"
  },
  Skill_24635_Name = {
    Text = "六翼满开"
  },
  Skill_24636_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 2 张「轮回悖论」加入手牌。"
  },
  Skill_24636_Name = {
    Text = "双翼初张"
  },
  Skill_24637_Desc = {
    Text = "提升 2 倍生命上限。每回合开始时将 1 张「回答塔薇」置入手中。"
  },
  Skill_24637_Name = {Text = "复苏"},
  Skill_24638_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>并获得 <Block:[Block:Arg2]> 点护盾，并施加 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_24638_Name = {Text = "展翼"},
  Skill_24646_Desc = {
    Text = "对方在本回合使用症状卡后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24646_Name = {
    Text = "「低语」\n症状"
  },
  Skill_24647_Desc = {
    Text = "对方本回合出牌数量达到 5 张时，将行动意图切换为「临别赠礼」。"
  },
  Skill_24647_Name = {
    Text = "「低语」\n出牌 5"
  },
  Skill_24648_Desc = {
    Text = "对方本回合释放钥令后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24648_Name = {
    Text = "「低语」\n钥令"
  },
  Skill_24649_Desc = {
    Text = "对方本回合使用算力为 0 的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24649_Name = {
    Text = "「低语」\n算力 0"
  },
  Skill_24650_Desc = {
    Text = "对方本回合使用 2 次狂气爆发后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24650_Name = {
    Text = "「低语」\n狂气爆发2"
  },
  Skill_24695_Desc = {
    Text = "对方本回合出牌数量达到 5 张时，将行动意图切换为「临别赠礼」。"
  },
  Skill_24695_Name = {
    Text = "「低语」\n出牌 5"
  },
  Skill_24696_Desc = {
    Text = "对方在本回合使用症状卡后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24696_Name = {
    Text = "「低语」\n症状"
  },
  Skill_24697_Desc = {
    Text = "对方本回合释放钥令后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24697_Name = {
    Text = "「低语」\n钥令"
  },
  Skill_24698_Desc = {
    Text = "对方本回合释放钥令后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24698_Name = {
    Text = "「低语」\n钥令"
  },
  Skill_24699_Desc = {
    Text = "对方本回合使用算力 3 及以上的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24699_Name = {
    Text = "「低语」\n算力 ≥3"
  },
  Skill_24700_Desc = {
    Text = "对方本回合使用算力 3 及以上的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24700_Name = {
    Text = "「低语」\n算力 ≥3"
  },
  Skill_24701_Desc = {
    Text = "对方本回合使用算力为 0 的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24701_Name = {
    Text = "「低语」\n算力 0"
  },
  Skill_24702_Desc = {
    Text = "对方本回合使用算力为 0 的卡牌后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24702_Name = {
    Text = "「低语」\n算力 0"
  },
  Skill_24703_Desc = {
    Text = "对方本回合使用 2 次狂气爆发后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24703_Name = {
    Text = "「低语」\n狂气爆发2"
  },
  Skill_24704_Desc = {
    Text = "对方本回合出牌数量达到 5 张时，将行动意图切换为「临别赠礼」。"
  },
  Skill_24704_Name = {
    Text = "「低语」\n出牌 5"
  },
  Skill_24705_Desc = {
    Text = "对方本回合使用 2 次狂气爆发后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24705_Name = {
    Text = "「低语」\n狂气爆发2"
  },
  Skill_24706_Desc = {
    Text = "对方在本回合使用症状卡后，将行动意图切换为「临别赠礼」。"
  },
  Skill_24706_Name = {
    Text = "「低语」\n症状"
  },
  Skill_24713_Desc = {
    Text = "「环行·拉蒙娜」获得 15 狂气，其他唤醒体扣除 3 狂气。此卡回合结束若在手中，对我方造成 [Arg1] 点<FixedDamage:纯粹伤害>。"
  },
  Skill_24713_Name = {
    Text = "轮回悖论"
  },
  Skill_24714_Desc_1 = {
    Text = "使一名目标获得 [Arg1] <PowerColourKeywords:力量降低>。"
  },
  Skill_24714_Name_1 = {
    Text = "力量降低"
  },
  Skill_24982_Desc = {
    Text = "施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，回复珈伦 [Arg2]% 已损失生命并获得等量护盾。"
  },
  Skill_24982_Name = {
    Text = "静默守望"
  },
  Skill_24983_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_24983_Name = {
    Text = "女仆魔法"
  },
  Skill_24984_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。降低对方 [Arg3] 点最大生命。"
  },
  Skill_24984_Name = {
    Text = "食物中毒"
  },
  Skill_24986_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合的<WeaknessIconKeywords:虚弱>，将 1 张「黑暗料理」加入手中。"
  },
  Skill_24986_Name = {
    Text = "蟾蜍炖菜"
  },
  Skill_24987_Desc = {
    Text = "打出后获得 3 点算力并对自身造成 1 回合<WeaknessIconKeywords:虚弱>，<VulnerabilityIconKeywords:易伤>，<FragileIconKeywords:脆弱>和 [Arg1] 层<IntoxicationIconKeywords:中毒>。若回合结束时在手中，对抽牌堆或弃牌堆随机 2 张指令卡造成<SlowIconKeywords:迟缓>。"
  },
  Skill_24987_Name = {
    Text = "珈伦的特制料理"
  },
  Skill_24988_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 2 张「黑暗料理」置入对方手牌。获得「吃饱喝足」2 回合 ：己方队伍每次消耗算力，就使珈伦获得 [Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_24988_Name = {
    Text = "客官请慢用！"
  },
  Skill_24989_Desc = {
    Text = "打出后获得 2 点算力和 [Arg1] 点<IntoxicationIconKeywords:中毒>。若回合结束时在手中，对抽牌堆或弃牌堆随机 1 张指令卡造成<SlowIconKeywords:迟缓>。"
  },
  Skill_24989_Name = {
    Text = "黑暗料理"
  },
  Skill_25058_Desc = {
    Text = "将 2 张 「珈伦的特制料理」置入对方手牌堆。获得「吃饱喝足」3 回合 ：每次消耗算力，就使珈伦获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_25058_Name = {Text = "觉醒"},
  Skill_25127_Desc_1 = {
    Text = "丢弃所有卡牌，获得每个唤醒体 2 张打击。"
  },
  Skill_25127_Name_1 = {
    Text = "获得打击"
  },
  Skill_25173_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_25174_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_25174_Name = {
    Text = "黑色混沌"
  },
  Skill_25175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_25176_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对全体友方施加 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_25176_Name = {
    Text = "伏行之雾"
  },
  Skill_25182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 4 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_25182_Name = {
    Text = "四翼渐生"
  },
  Skill_25183_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 2 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_25183_Name = {
    Text = "双翼初张"
  },
  Skill_25184_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 6 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_25184_Name = {
    Text = "六翼满开"
  },
  Skill_25389_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_25389_Name = {
    Text = "惊奇表演"
  },
  Skill_25411_Desc = {
    Text = "每回合开始时默认的触腕基础姿态，触腕伤害为 100%。若回合结束时仍处于「潮涌」姿态，生成 1 条永久触腕。"
  },
  Skill_25411_Name = {Text = "潮涌"},
  Skill_25412_Desc = {
    Text = "·本回合触腕伤害降低 50％，获得 <Block:[Block:Arg1]> 点护盾，后续每次触腕攻击时获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_25412_Name = {Text = "静海"},
  Skill_25412_tempBattleDesc_1 = {
    Text = "·本回合触腕伤害降低 50％，获得 <Block:[Block:Arg1]> 点护盾，后续每次触腕攻击时获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_25412_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，回合结束时触腕不再攻击，3 回合冷却。"
  },
  Skill_25412_tempBattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，回合结束时触腕不再攻击，3 回合冷却。"
  },
  Skill_25413_Desc = {
    Text = "·本回合触腕伤害变为 [Arg1]%，造成主动伤害后，使 1 条触腕攻击目标敌方，造成 [Arg3]％ 触腕伤害，回合结束时失去 1 条触腕。当前永久触腕数量超过 1 条时，才可选择该姿态。"
  },
  Skill_25413_Name = {Text = "怒涛"},
  Skill_25413_tempBattleDesc_1 = {
    Text = "·本回合触腕伤害变为 [Arg1]%，造成主动伤害后，使 1 条触腕攻击目标敌方，造成 [Arg3]％ 触腕伤害，回合结束时失去 1 条触腕。当前永久触腕数量超过 1 条时，才可选择该姿态。"
  },
  Skill_25413_tempBattleDesc_2 = {
    Text = "本回合触腕伤害变为 [Arg2]％，造成主动伤害后，使 1 条触腕攻击敌方。回合结束时失去 1 条触腕。当前永久触腕数量超过 1 条时，才可选择该姿态，3 回合冷却。"
  },
  Skill_25413_tempBattleDesc_3 = {
    Text = "本回合触腕伤害变为 [Arg2]％，造成主动伤害后，使 1 条触腕攻击敌方。回合结束时失去 1 条触腕。当前永久触腕数量超过 1 条时，才可选择该姿态，3 回合冷却。"
  },
  Skill_30362_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张「鬼牌」塞入对方的抽牌堆顶。"
  },
  Skill_30362_Name = {Text = "惊喜！"},
  Skill_34668_Desc = {
    Text = "丢弃所有手牌，选择 1 名其他唤醒体获得 100 点狂气，获得其整副套牌并附加「回手」，算力重置到100，然后「生成套牌」回到手中。"
  },
  Skill_34668_Name = {
    Text = "生成套牌"
  },
  Skill_34674_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_34675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_34676_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。将 [Arg2] 张<DerivativeCardKeywords_45:<DerivativeCardKeywords_45:「维度闭锁」>>洗入抽牌堆。"
  },
  Skill_34677_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。将 [Arg2] 张<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆。"
  },
  Skill_34682_Desc = {
    Text = "让所有怪物血量+9999999。"
  },
  Skill_34682_Name = {
    Text = "无敌怪物"
  },
  Skill_35502_Desc = {
    Text = "消耗所有猩红熔炉回复量，回复 [Heal:Arg1] 点生命。至多可积攒 [Arg2] 点猩红熔炉。"
  },
  Skill_35502_Name = {
    Text = "猩红熔炉"
  },
  Skill_35502_tempBattleDesc_1 = {
    Text = "消耗所有猩红熔炉回复量，回复 [Heal:Arg1] 点生命。至多可积攒 [Arg2] 点猩红熔炉。对所有敌人造成目标最大生命 1％ 的侵蚀，消耗的猩红熔炉越多侵蚀效果就越强，至多提高 100%。对「空壳」敌人造成 5 倍侵蚀效果。3 回合冷却。"
  },
  Skill_35507_Desc = {
    Text = "选择一名唤醒体成为「幸运观众」，赋予其所有卡牌「保留」。打出「幸运观众」的卡牌会削弱「霍迪妮」的技能且降低其力量，但失去少量最大生命。"
  },
  Skill_35507_Name = {
    Text = "幸运观众"
  },
  Skill_35522_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_35522_Name = {
    Text = "颅骨猛击"
  },
  Skill_35523_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_35524_Desc = {
    Text = "获得[Arg1]点<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_35526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_35526_Name = {Text = "重击"},
  Skill_35528_Desc = {
    Text = "施加 [Arg1] 层出血。"
  },
  Skill_35528_Name = {Text = "出血"},
  Skill_35671_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_35671_Name = {Text = "强化"},
  Skill_35742_Desc = {
    Text = "回复 [Arg1]% 已损失生命([Arg2])并获得等量的护盾，获得 [Arg3] 银钥能量。"
  },
  Skill_35742_Name = {
    Text = "乌托邦帷幕"
  },
  Skill_35743_Desc = {
    Text = "查看 3 个未携带的钥令，选择 1 个立即释放。"
  },
  Skill_35743_Name = {
    Text = "乌托邦帷幕"
  },
  Skill_35960_Desc = {
    Text = "施加 1 回合<FragileIconKeywords:脆弱> 和 [Arg1] 点中毒。"
  },
  Skill_35960_Name = {
    Text = "脆弱毒素"
  },
  Skill_35961_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_35961_Name = {Text = "殉身"},
  Skill_35962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_35963_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_35963_Name = {Text = "殉身"},
  Skill_35964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_35965_Desc = {
    Text = "施加 1 回合<WeaknessIconKeywords:虚弱>，封印狂气最高唤醒体 1 回合。"
  },
  Skill_35965_Name = {
    Text = "初生之咒"
  },
  Skill_36003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36003_Name = {Text = "蛸吻"},
  Skill_36004_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_36005_Desc = {
    Text = "移除负面状态，获得  <Block:[Block:Arg1]> 点护盾并获得 1 层疯狂。"
  },
  Skill_36005_Name = {Text = "蜕变"},
  Skill_36025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36026_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36027_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，赋予玩家 4 张算力最低的卡牌「深潜印记」。"
  },
  Skill_36028_Name = {
    Text = "标记猎物"
  },
  Skill_36029_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36030_Desc = {
    Text = "带刺的珊瑚刺入了体内！"
  },
  Skill_36030_Name = {
    Text = "珊瑚赘生"
  },
  Skill_36031_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36033_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，赋予玩家 4 张算力最低的卡牌「深潜印记」。"
  },
  Skill_36034_Name = {
    Text = "标记猎物"
  },
  Skill_36035_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36037_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。召唤一个「睡梦之子」在身前和一个「水之子」在身后。"
  },
  Skill_36037_Name = {Text = "虔诚"},
  Skill_36038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36039_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张「寄生珊瑚」加入抽牌堆顶。"
  },
  Skill_36039_Name = {Text = "礁化"},
  Skill_36040_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_36040_Name = {Text = "虔诚"},
  Skill_36041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36042_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，赋予玩家 2 张算力最低的卡牌「深潜印记」。"
  },
  Skill_36042_Name = {
    Text = "标记猎物"
  },
  Skill_36043_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36044_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。召唤一个「睡梦之子」在身前。"
  },
  Skill_36044_Name = {Text = "虔诚"},
  Skill_36045_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。召唤一个「水之子」在身后。"
  },
  Skill_36045_Name = {Text = "虔诚"},
  Skill_36046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张「寄生珊瑚」加入抽牌堆顶和弃牌堆顶。"
  },
  Skill_36046_Name = {
    Text = "加速礁化"
  },
  Skill_36047_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_36047_Name = {Text = "虔诚"},
  Skill_36048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36049_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。回复其他友方等同于自身生命的值，自身死亡。"
  },
  Skill_36076_Name = {Text = "殉身"},
  Skill_36077_Desc = {
    Text = "获得 1 层疯狂，对 2 张卡牌施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_36077_Name = {Text = "疯狂"},
  Skill_36078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。弃掉玩家所有手牌。"
  },
  Skill_36078_Name = {Text = "离散"},
  Skill_36079_Desc = {
    Text = "获得 1 层疯狂，对 3 张卡牌施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_36079_Name = {Text = "疯狂"},
  Skill_36080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张「寄生珊瑚」加入抽牌堆顶。"
  },
  Skill_36080_Name = {Text = "礁化"},
  Skill_36081_Desc = {
    Text = "获得 1 层疯狂，对 2 张卡牌施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_36081_Name = {Text = "疯狂"},
  Skill_36082_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤 1 个「灵觉之子」。"
  },
  Skill_36082_Name = {Text = "恶诞"},
  Skill_36083_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_36083_Name = {
    Text = "深海洗礼"
  },
  Skill_36084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。弃掉玩家所有手牌。"
  },
  Skill_36084_Name = {Text = "离散"},
  Skill_36085_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>，每有 1 个其他友方自身就获得 1 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_36085_Name = {
    Text = "深海洗礼"
  },
  Skill_36086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_36086_Name = {
    Text = "深海洗礼"
  },
  Skill_36087_Desc = {
    Text = "将 3 张「裂伤」加入手中。"
  },
  Skill_36087_Name = {Text = "裂伤"},
  Skill_36088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。弃掉玩家所有手牌。"
  },
  Skill_36088_Name = {Text = "离散"},
  Skill_36089_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_36090_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤 1 个「水之子」。"
  },
  Skill_36090_Name = {Text = "恶诞"},
  Skill_36177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤「灵觉之子」、「睡梦之子」、「水之子」。"
  },
  Skill_36177_Name = {Text = "孽诞"},
  Skill_36179_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_36180_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_36255_Desc = {
    Text = "施加 [Arg1] 层<BleedingIconKeywords:出血>和 [Arg2] 点护盾。"
  },
  Skill_36255_Name = {
    Text = "旧日之梦"
  },
  Skill_36256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，对抽牌堆或弃牌堆随机 3 张指令卡施加 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_36256_Name = {
    Text = "梦魇编织"
  },
  Skill_36257_Desc = {
    Text = "生命上限增加至 300%，回复所有生命并获得 [Arg3] 点护盾。获得 7 条触腕上限。每回合结束时获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_36257_Name = {
    Text = "受诞之种"
  },
  Skill_36258_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 50% 等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_36258_Name = {
    Text = "万世之苦"
  },
  Skill_36259_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机封印 [Arg3] 个唤醒体。"
  },
  Skill_36259_Name = {Text = "长梦"},
  Skill_36260_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_36260_Name = {Text = "梦呓"},
  Skill_36261_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_36261_Name = {Text = "啼哭"},
  Skill_36326_Desc = {
    Text = "消耗 1 层神母权能，获得 [Arg3] 点<PowerIconKeywords:力量>，降低「圣婴」 [Arg2] 点触腕伤害。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_36326_Name = {
    Text = "呵斥，以报恩仇"
  },
  Skill_36327_Desc = {
    Text = "消耗 1 层神母权能，获得 3 点算力，抽 3 张牌。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_36327_Name = {
    Text = "牺牲，以敬自由"
  },
  Skill_36328_Desc = {
    Text = "消耗 1 层神母权能，所有唤醒体获得 20 点狂气，使「圣婴」的触腕立刻对「圣婴」造成 10 倍伤害，造成 [Arg2] 点触腕伤害 [Arg3] 次。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_36328_Name = {
    Text = "刎颈，以行威仪"
  },
  Skill_36329_Desc = {
    Text = "回复 1 层神母权能，神母权能可被消耗触发墨菲的其他能力，最多回复至 3 层。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_36329_Name = {Text = "小憩"},
  Skill_36330_Desc = {
    Text = "对前排敌人造成其 25% 最大生命([Arg1])的<FixedDamage:纯粹伤害>，使其昏迷 1 回合。"
  },
  Skill_36330_Name = {Text = "王权"},
  Skill_36331_Desc = {
    Text = "昏迷中，无法行动。"
  },
  Skill_36331_Name = {Text = "昏迷"},
  Skill_36356_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。自身死亡。"
  },
  Skill_36356_Name = {Text = "殉身"},
  Skill_36357_Desc = {
    Text = "<TouquKeywords:永久偷取>玩家 [Arg1] 点<PowerIconKeywords:力量>增益状态。"
  },
  Skill_36357_Name = {Text = "吮吸"},
  Skill_36358_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_36365_Desc = {
    Text = "召唤 1 个「海中之物」在身前。"
  },
  Skill_36365_Name = {Text = "眷族！"},
  Skill_36366_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>洗入对方抽牌堆。"
  },
  Skill_36367_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印狂气最高唤醒体。"
  },
  Skill_36368_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点护盾，玩家每拥有 1 张剩余手牌额外获得 [Arg4] 点护盾。"
  },
  Skill_36368_Name = {Text = "试探"},
  Skill_36648_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点护盾，每层「孕育」使护盾提高 [Arg4] 点。"
  },
  Skill_36648_Name = {Text = "试探"},
  Skill_36649_Desc = {
    Text = "召唤 1 个「灵觉之子」在身后，每层「孕育」都会使其更强！"
  },
  Skill_36649_Name = {
    Text = "应选之人"
  },
  Skill_36650_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点护盾，玩家每拥有 1 张剩余手牌额外获得 [Arg4] 点护盾。"
  },
  Skill_36650_Name = {Text = "试探"},
  Skill_36651_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_3:「惊厥」>洗入对方抽牌堆。"
  },
  Skill_36651_Name = {
    Text = "无上生祭"
  },
  Skill_36652_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印狂气最高唤醒体。"
  },
  Skill_36653_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤 2 个「睡梦之子」在身前。"
  },
  Skill_36653_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_36654_Desc = {
    Text = "召唤 1 个「海中之物」在身后。"
  },
  Skill_36654_Name = {Text = "眷族！"},
  Skill_36655_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印所有唤醒体，召唤 2 个「利莫里亚的希望」在身前。"
  },
  Skill_36655_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_36656_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印狂气最高的唤醒体 1 回合。"
  },
  Skill_36656_Name = {
    Text = "神眷之刃"
  },
  Skill_36657_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>洗入对方抽牌堆。"
  },
  Skill_36800_Desc = {
    Text = "从抽牌堆中抽 [Arg1] 张算力消耗最低的卡牌。若当前界域为「深海」，则额外使<TentacleInjurieIconKeywords:触腕伤害>提高 [Arg2] 点。"
  },
  Skill_36800_Name = {
    Text = "奥瑞塔的宝藏"
  },
  Skill_36807_BattleDesc = {
    Text = "选择 1 名唤醒体使其获得 <Energy:[Arg2]>  点狂气，获得 [Arg3] 点<PowerIconKeywords:力量>，若当前界域为「血肉」，额外使<EmbryoFusionIconKeywords:胚胎融合> + [Arg4]，但失去 10%([Arg1])当前生命。"
  },
  Skill_36807_Desc = {
    Text = "选择 1 名唤醒体使其获得 <Energy:[Arg2]>  点狂气，获得 [Arg3] 点<PowerIconKeywords:力量>，若当前界域为「血肉」，额外使<EmbryoFusionIconKeywords:胚胎融合> + [Arg4]，但失去 10%当前生命。"
  },
  Skill_36807_Name = {
    Text = "咆哮的血与沙"
  },
  Skill_36808_Desc = {
    Text = "获得 [Arg4] 点算力。选择 1 名唤醒体，将其 [Arg1] 张「打击」与 [Arg1] 张「防御」的原始复制置入手中，并使他们获得<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虚无>。若当前界域为「超维」，则额外获得 [Arg2] 点临时<PowerIconKeywords:力量>与 [Arg3] 点临时<AlertIconKeywords:戒备>。"
  },
  Skill_36808_Name = {
    Text = "短暂的永恒"
  },
  Skill_36809_Desc = {
    Text = "获得 [Arg1]% 临时暴击率和 [Arg2] 点临时<PowerIconKeywords:力量>。 若在首领战中且本回合尚未打出过任何牌，则尝试触发 [Arg3] 次死亡抵抗，若成功则获得 <Block:[Block:Arg4]> 点护盾，此效果只能触发 [Arg5] 次。"
  },
  Skill_36809_Name = {
    Text = "最后的誓言"
  },
  Skill_36843_Desc = {
    Text = "从抽牌堆中选择 [Arg1] 张牌加入手中，并使其算力消耗降低 [Arg2]。"
  },
  Skill_36843_Name = {
    Text = "跨越回溯之扉"
  },
  Skill_36844_Desc = {
    Text = "对生命最高敌人造成 [Arg2] 点<IntoxicationIconKeywords:中毒>，获得 <Block:[Block:Arg1]> 点护盾。若本回合触发过「吞噬」，不再获得护盾，触发该敌人 50％ <IntoxicationIconKeywords:中毒>。"
  },
  Skill_36844_Name = {
    Text = "湖畔回眸"
  },
  Skill_36845_Desc = {
    Text = "获得 [Arg1] 点算力，下回合开始时获得 <Block:[Block:Arg2]> 点护盾。若当前界域为「深海」且处于「潮涌」姿态，则效果变为生成 [Arg3] 条触腕。"
  },
  Skill_36845_Name = {
    Text = "蚀骨的拥抱"
  },
  Skill_36846_Desc = {
    Text = "获得 [Arg1] 点<RetaliateIconKeywords:反击>，临时降低所有敌人 [Arg2] 点<ExhaustionIconKeywords:力量>。若当前处于「超维回合」，不再降低临时<PowerIconKeywords:力量>，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  Skill_36846_Name = {
    Text = "腐烂盛筵"
  },
  Skill_36851_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，将 [Arg2] 张<DerivativeCardKeywords_4:「灵感」>置入手中。若当前为超维回合，效果变更为将 [Arg3] 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  Skill_36851_Name = {
    Text = "灰雾真容"
  },
  Skill_36852_Desc = {
    Text = "抽 1 张牌，如果抽到指令卡或灵知觉醒，将其算力消耗变为 0，并使其拥有者获得 <Energy:[Arg1]> 点狂气。否则将这张牌弃掉并重复此条效果。"
  },
  Skill_36852_Name = {
    Text = "仲夏之梦"
  },
  Skill_36853_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。受到攻击伤害时，下回合开始时获得 [Arg2]% 伤害的护盾。若当前界域为「血肉」，不再获得延迟护盾，而是积攒 10% 伤害的回复量到猩红熔炉。"
  },
  Skill_36853_Name = {
    Text = "神迹降临"
  },
  Skill_36854_Desc = {
    Text = "获得 1 点算力和 [Arg1] 点<PowerIconKeywords:力量>，选择一名唤醒体获得 [Arg2] 点狂气。若当前界域为「深海」且处于「怒涛」姿态，效果改为获得 [Arg3]% 临时暴击率和临时暴击伤害。"
  },
  Skill_36854_Name = {
    Text = "巨人的霸道"
  },
  Skill_36855_Desc = {
    Text = "界域精通提高 [Arg1]。选择 1 名唤醒体使其获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_36855_Name = {
    Text = "全部的她"
  },
  Skill_36856_BattleDesc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>，抽 2 张牌。若当前界域为「血肉」，损失 10% 当前生命([Arg3])，额外获得 [Arg2] 点临时<PowerIconKeywords:力量>，手中每有 1 张<DerivativeCardKeywords_2:「胚胎」>额外获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_36856_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>，抽 2 张牌。若当前界域为「血肉」，损失 10% 当前生命，额外获得 [Arg2] 点临时<PowerIconKeywords:力量>，手中每有 1 张<DerivativeCardKeywords_2:「胚胎」>额外获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_36856_Name = {
    Text = "玫瑰的胜利"
  },
  Skill_39273_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_3950_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<FragileIconKeywords:脆弱>。"
  },
  Skill_3951_AwakerSkillBackgroundStory = {
    Text = "白天鹅在如镜的湖面徘徊。"
  },
  Skill_3951_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3951_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气，触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3951_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莉兹获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3951_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莉兹获得 <Energy:[Energy:Arg2]> 点狂气，触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3951_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_3951_Name = {Text = "防御"},
  Skill_3951_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_3952_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。每回合对手牌中剩余卡牌施加「<SlowIconKeywords:迟缓>」。"
  },
  Skill_3952_Name = {Text = "觉醒"},
  Skill_3953_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3954_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次。获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_3954_Name = {
    Text = "恣睢之浪"
  },
  Skill_3955_Desc = {
    Text = "为前排友方施加 [Arg1] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_3955_Name = {Text = "屏障"},
  Skill_3956_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3957_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3958_Desc = {
    Text = "每回合开始时获得护盾，等同于上回合受到的伤害的一半。"
  },
  Skill_3958_Name = {
    Text = "献媚者之拥"
  },
  Skill_3960_Desc = {
    Text = "回合结束时若在手中，自身<WeaknessIconKeywords:虚弱> 1 回合。使用后<WeaknessIconKeywords:虚弱>所有敌人 1 回合。无法出售。"
  },
  Skill_3960_Name = {
    Text = "症状：衰弱"
  },
  Skill_3961_AwakerSkillBackgroundStory = {
    Text = "行家一出手，就知有没有。\n聪明人应该学会模仿莱克的押注。"
  },
  Skill_3961_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3961_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。若算力不足时可消耗 3 点黑印打出并生效 2 次。当前黑印：[Arg3]）"
  },
  Skill_3961_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莱克获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3961_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莱克获得 <Energy:[Energy:Arg2]> 点狂气。若算力不足时可消耗 3 点黑印打出并生效 2 次。"
  },
  Skill_3961_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_3961_Name = {Text = "打击"},
  Skill_3961_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_3962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，提高后续「连续撕咬」的攻击次数。"
  },
  Skill_3962_Name = {
    Text = "连续撕咬"
  },
  Skill_3963_Desc = {
    Text = "施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。后撤。"
  },
  Skill_3963_Name = {Text = "毒素"},
  Skill_3964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3965_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_3966_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_3966_Name = {
    Text = "维度空洞"
  },
  Skill_3967_AwakerSkillBackgroundStory = {
    Text = "谁曾经和女孩说过，\n\n「抱着你的小熊吧，他会守护你的梦。」\n\n这大概是为什么在唤醒之后，小熊成为了她的保护者吧。"
  },
  Skill_3967_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「万古之眸」对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>，每次释放使「万古之眸」基础伤害提高 [Arg3]%。"
  },
  Skill_3967_EffectNameList = {Text = "伤害"},
  Skill_3967_Name = {
    Text = "万古之眸"
  },
  Skill_3967_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则本次「万古之眸」最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>。每次释放使「万古之眸」基础伤害提高 50%。本回合所有唤醒体造成的最终伤害提高 25%。"
  },
  Skill_3967_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_3967_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「万古之眸」对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>，每次释放使「万古之眸」基础伤害提高 [Arg3]%。"
  },
  Skill_3967_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：本次「万古之眸」对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>，每次释放使「万古之眸」基础伤害提高 [Arg3]%。艾继丝打出的下一张「防御」生效 3 次。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则本次「万古之眸」最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>。每次释放使「万古之眸」基础伤害提高  [Arg3]%。本回合所有唤醒体造成的最终伤害提高 25%。"
  },
  Skill_3967_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：对所有敌人施加 1 回合的<PetrifactionIconKeywords:石化>，若目标拥有石化抗性则本次「万古之眸」最终伤害提高 200%。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>。每次释放使「万古之眸」基础伤害提高 [Arg3]%。本回合所有唤醒体造成的最终伤害提高 25%。艾继丝打出的下一张「防御」生效 3 次。"
  },
  Skill_3968_Desc = {
    Text = "回合结束时若在手中，获得 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_3968_Name = {Text = "窒息"},
  Skill_3969_Desc = {
    Text = "获得 [Arg1]点<PowerIconKeywords:力量>，驱散自身<WeaknessIconKeywords:虚弱>与<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_3969_Name = {
    Text = "绝境求生"
  },
  Skill_3970_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_3971_AwakerSkillBackgroundStory = {
    Text = "她手中的刀刃，只会为世间公义举起。"
  },
  Skill_3971_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3971_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。艾尔瓦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3971_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_3971_Name = {Text = "打击"},
  Skill_3971_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_3972_AwakerSkillBackgroundStory = {
    Text = "她从不畏惧维度中那些光怪陆离的追踪者。她自有她的秘法。"
  },
  Skill_3972_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3972_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。<TransitionIconKeywords:跃迁>：获得 1 点算力。"
  },
  Skill_3972_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。达芙黛尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_3972_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。达芙黛尔获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。<TransitionIconKeywords:跃迁>：获得 1 点算力。"
  },
  Skill_3972_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_3972_EffectNameList_1 = {
    Text = "护盾,狂气,力量"
  },
  Skill_3972_Name = {Text = "防御"},
  Skill_3972_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_3972_PropertyNameList_1 = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_3973_AwakerSkillBackgroundStory = {
    Text = "即将被寂静吞没时，她仿佛看到溺死的侍女。\n侍女的皮肤发白，像一朵腐烂的睡莲躺在湖泊里，脖颈上的伤痕正顺着青白色的脉络延伸至看不见的远方。\n「看看你的猫眼石项链吧，」尸体说，「全都变成灰啦。变成灰啦......」"
  },
  Skill_3973_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命并获得 <Block:[Block:Arg2]> 点护盾。回合结束时若在手中，算力消耗提高 1，回复生命和护盾翻倍。最多叠加 [Arg3] 次。"
  },
  Skill_3973_EffectNameList = {
    Text = "回复,护盾"
  },
  Skill_3973_Name = {
    Text = "静默守望"
  },
  Skill_3973_PropertyNameList = {
    Text = "体质*GrowValue1,防御力*GrowValue2"
  },
  Skill_3974_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3974_Name = {
    Text = "割喉挥砍"
  },
  Skill_3975_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3977_AwakerSkillBackgroundStory = {
    Text = "「靠近点，别害羞，让礼帽先生尝尝你的欢笑与快乐。」\n卡茜亚大师点点帽檐，砰地一声变出一大捧缎带和卡片。\n「在心里选好你的牌。嘘！不要告诉任何人。卡茜亚大师会告诉你哪张是你的唯一。」"
  },
  Skill_3977_Desc_0 = {
    Text = "视为「打击」。选择<DimensionalSpaceIconKeywords:超维空间>任意 1 张牌置入手牌并使其算力消耗 -2。随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_3977_Desc_3 = {
    Text = "视为「打击」。选择<DimensionalSpaceIconKeywords:超维空间>任意 1 张牌置入手牌并使其算力消耗 -2。随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>。<RippleKeywords:余波>：将 1 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆。"
  },
  Skill_3977_EffectNameList = {
    Text = "伤害,临时力量"
  },
  Skill_3977_Name = {
    Text = "隔空取物"
  },
  Skill_3977_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_3978_Desc = {
    Text = "造成<Block:[Block:Arg1]>护盾，获得 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_3978_Name = {Text = "警戒"},
  Skill_3979_AwakerSkillBackgroundStory = {
    Text = "Schizophrenia.\n早在这个词被发明以前，赫伯特在实验室里已经制造出无数病例了。\n24无疑是其中的集大成之作，她的人格以惊人的速度不断增殖，且互不干扰。\n某种意义而言，她的大脑就像一个拥挤的公寓，挤满了聒噪的房客。"
  },
  Skill_3979_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。"
  },
  Skill_3979_EffectNameList = {Text = "伤害"},
  Skill_3979_Name = {
    Text = "纷乱切割"
  },
  Skill_3979_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_3980_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_3981_AwakerSkillBackgroundStory = {
    Text = "传承自其他种族、被视为异端的血脉。\n唯有坚信其高贵、坚信其伟大，方能苟活于残酷世间。\n那本奥恩叔叔留下的手卷，与其中描绘的瑰丽深海古城，是他唯一的精神寄托。\n「血脉爆发之际，一定能获赐深海的无上力量吧。」"
  },
  Skill_3981_Desc = {
    Text = "回复 <Heal:[Heal:Arg3]> 点生命并驱散自身<WeaknessIconKeywords:虚弱>状态，对所有敌人施加 [Arg4] 层<VulnerabilityIconKeywords:易伤>。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。<RetaliateIconKeywords:反击> +[Counterattack:Arg2]。下回合开始前，每受到 1 次攻击，就使 1 条触腕反击攻击者。"
  },
  Skill_3981_EffectNameList = {
    Text = "回复,触腕伤害,反击"
  },
  Skill_3981_Name = {
    Text = "承自异端之血"
  },
  Skill_3981_OverLimitUtlSkillDesc = {
    Text = "回复 <Heal:[Heal:Arg3]> 点生命并驱散自身<WeaknessIconKeywords:虚弱>状态，对所有敌人施加 [Arg4] 层<VulnerabilityIconKeywords:易伤>。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。<RetaliateIconKeywords:反击> +[Counterattack:Arg2]。下回合开始前，每受到 1 次攻击，就使 1 条触腕反击攻击者。使 1 条触腕攻击 5 次，获得 25% 造成伤害的反击。"
  },
  Skill_3981_PropertyNameList = {
    Text = "体质*GrowValue2,攻击力*GrowValue1,攻击力*GrowValue3"
  },
  Skill_3982_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 4 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_3982_Name = {
    Text = "四翼渐生"
  },
  Skill_3983_AwakerSkillBackgroundStory = {
    Text = "实验后，24打烂了所有的镜子。\n「我的好姑娘」独眼的科学家抚摸着她的长发，「安静。」\n24在科学家的眼中看到一个陌生的怪物。她一定是发了昏，竟然试图戳瞎他的双眼——\n这便是她被遗弃在蜡像中的理由罢。"
  },
  Skill_3983_Desc = {
    Text = "「24」 获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>："
  },
  Skill_3983_EffectNameList = {
    Text = "狂气,狂气爆发最终伤害提高,触腕伤害加成百分比,力量,混沌暴击率和暴击伤害,反击伤害加成百分比"
  },
  Skill_3983_Name = {
    Text = "调停人格"
  },
  Skill_3983_PropertyNameList = {
    Text = "$GrowValue1,GrowValue2,$GrowValue3,攻击力*GrowValue4,$GrowValue5,$GrowValue6"
  },
  Skill_3984_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 6 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_3984_Name = {
    Text = "六翼满开"
  },
  Skill_3986_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_3987_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点护盾。玩家回合结束前每拥有一张手牌还会额外获得 [Arg4] 点护盾。"
  },
  Skill_3987_Name = {Text = "试探"},
  Skill_3988_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3989_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3989_Name = {Text = "刺击"},
  Skill_3991_Desc = {
    Text = "将 [Arg1] 张 <DerivativeCardKeywords_9:「蹒跚」> 加入对方抽牌堆。"
  },
  Skill_3991_Name = {Text = "蹒跚"},
  Skill_3992_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层<ParcloseIconKeywords:屏障>，前进。"
  },
  Skill_3993_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_3994_AwakerSkillBackgroundStory = {
    Text = "没有种子不渴望着发芽。\n植物沐浴阳光与雨露破土，幼童浸润爱与希望长大。\n菲茵特蜷缩摇篮中，怀抱着宝贵的养分，静静等待那个时刻的到来……"
  },
  Skill_3994_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，回复 <Heal:[Heal:Arg2]> 点生命。若在本场战斗中触发过<DeathResistanceIconKeywords:死亡抵抗>，额外生效 1 次。"
  },
  Skill_3994_EffectNameList = {
    Text = "护盾,回复"
  },
  Skill_3994_Name = {
    Text = "幼芽萌生"
  },
  Skill_3994_PropertyNameList = {
    Text = "防御力*GrowValue1,体质*GrowValue2"
  },
  Skill_3995_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_3996_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将一张<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_3996_Name = {Text = "救救我"},
  Skill_3997_AwakerSkillBackgroundStory = {
    Text = "「街头打斗可没那么多讲究，当然是什么趁手用什么了。」"
  },
  Skill_3997_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。"
  },
  Skill_3997_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_3997_Name = {Text = "打击"},
  Skill_3997_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_3999_Desc = {
    Text = "无法打出。释放狂气爆发后，封印所有唤醒体 1 回合。"
  },
  Skill_3999_Name = {
    Text = "维度闭锁"
  },
  Skill_4000_Desc = {
    Text = "凝滞中，无法行动。"
  },
  Skill_4000_Name = {Text = "凝滞"},
  Skill_4001_AwakerSkillBackgroundStory = {
    Text = "蛛丝将她一层一层紧紧裹住。她躺在温暖安全的茧内，朝外头扮起了鬼脸。"
  },
  Skill_4001_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。阿格里帕获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4001_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。阿格里帕获得 <Energy:[Energy:Arg2]> 点狂气。触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4001_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4001_Name = {Text = "防御"},
  Skill_4001_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4002_BattleDesc = {
    Text = "获得 [Arg1] 护盾。抽到时所有唤醒体失去 3 狂气。"
  },
  Skill_4002_Desc = {
    Text = "获得 10% 最大生命的护盾。抽到时所有唤醒体失去 3 狂气。"
  },
  Skill_4002_Name = {
    Text = "症状：颓丧"
  },
  Skill_4003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4004_Desc = {
    Text = "施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_4004_Name = {
    Text = "维度雾气"
  },
  Skill_4005_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4005_Name = {Text = "护盾"},
  Skill_4006_Desc = {
    Text = "状态卡。"
  },
  Skill_4006_Name = {Text = "蹒跚"},
  Skill_4007_Desc = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。获得 <Block:[Block:Arg1]> 护盾，回合结束时剩余护盾转换为2倍生命值。"
  },
  Skill_4008_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次，并获得 1 层疯狂。"
  },
  Skill_4009_AwakerSkillBackgroundStory = {
    Text = "她是脆弱却充满诱惑的雏鸟。面向天空，面向大地，面向汹涌的人潮，她卸下了全部的防备。"
  },
  Skill_4009_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4009_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。雷娅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4009_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4009_Name = {Text = "防御"},
  Skill_4009_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4010_AwakerSkillBackgroundStory = {
    Text = "希洛不记得自己是何时获得这股古怪力量的了。\n某个看不见星星的夜晚，希洛从监狱的泥地上醒来，突然发现身侧蠕动的黑色泥浆。那些黑色泥浆如同新生的双臂，替她破除了牢固的锁链。\n她想起被关押在隔壁的、她因为之求情而入狱的苍老农奴。她急忙奔去查看，但那里留下的只有濒临干涸的血痕。\n那曾是她的父亲。\n日夜不息的辛劳没有夺去他的性命，无情狠戾的鞭打没有夺去他的性命——夺去他的性命的是自己的告饶，是进献谗言者的污蔑，是掌权者的不分黑白……\n眼眶早已干涸，流淌的那些——不过是饱含恨意的黑色浆液而已。"
  },
  Skill_4010_BattleDesc = {
    Text = "失去 [Arg1]% 当前生命([Arg3])。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害和等量伤害的<BleedingIconKeywords:出血>。生成 2 张随机唤醒体的「打击」置入手牌并附加<DepleteIconKeywords:消耗>。视为「打击」。"
  },
  Skill_4010_Desc = {
    Text = "失去 [Arg1]% 当前生命。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害和等量伤害的<BleedingIconKeywords:出血>。生成 2 张随机唤醒体的「打击」置入手牌并附加<DepleteIconKeywords:消耗>。视为「打击」。"
  },
  Skill_4010_EffectNameList = {
    Text = "伤害,「打击」等级"
  },
  Skill_4010_Name = {
    Text = "绵长恨怨"
  },
  Skill_4010_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4011_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4011_Name = {Text = "护盾"},
  Skill_4012_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4013_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4014_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4014_Name = {
    Text = "丧钟遥鸣"
  },
  Skill_4015_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4016_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>加入对方抽牌堆。"
  },
  Skill_4016_Name = {
    Text = "致伤打击"
  },
  Skill_4017_AwakerSkillBackgroundStory = {
    Text = "在漫长的孤寂中，她早已忘记了为何而挥剑。\n但她清楚地知道，自己必须挥出这一剑。"
  },
  Skill_4017_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，<PowerIconKeywords:力量>在「命定之剑」上发挥 [Arg2] 倍效果。每次使用钥令时，力量倍率在本场战斗中提高 1 倍。<TimeBeacon:回环>：选择<C01EXCardKeyWord1:轮回之庭>或者<C01EXCardKeyWord2:未来讴歌>。"
  },
  Skill_4017_EffectNameList_0 = {Text = "伤害"},
  Skill_4017_Name = {
    Text = "命定之剑"
  },
  Skill_4017_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4018_AwakerSkillBackgroundStory = {
    Text = "疼痛，疼痛。\n漆黑冰冷的疼痛是她少有的留有印象的东西。\n如果她像那些真正的鹦鹉螺一样，有一个漂亮坚硬的外壳，是不是就不会那么痛了呢？"
  },
  Skill_4018_Desc_0 = {
    Text = "诺缔拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：诺缔拉施加的护盾和<RetaliateIconKeywords:反击>提高 [Arg2]%。"
  },
  Skill_4018_Desc_15 = {
    Text = "诺缔拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：诺缔拉施加的护盾和<RetaliateIconKeywords:反击>提高 [Arg2]%，所有唤醒体造成的固定<RetaliateIconKeywords:反击>提高 [Arg3]％。"
  },
  Skill_4018_EffectNameList = {Text = "狂气"},
  Skill_4018_Name = {
    Text = "维修大师"
  },
  Skill_4018_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4019_AwakerSkillBackgroundStory = {
    Text = "正如一生万物、万物归一的理论一般，她曾陷入悖论的陷阱。"
  },
  Skill_4019_Desc_0 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。将上回合最后打出的 3 张不同非衍生指令卡原始复制置入手中，使它们算力消耗降低 1 并获得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>。若可置入手中的指令卡不足，则抽等量牌代替。"
  },
  Skill_4019_Desc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。将上回合最后打出的 3 张不同非衍生指令卡原始复制置入手中，使它们算力消耗降低 1 并获得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>。若可置入手中的指令卡不足，则抽等量牌代替。选择 1 个任意已解锁钥令替换当前钥令，使用钥令或战斗结束后恢复。"
  },
  Skill_4019_EffectNameList = {
    Text = "银钥充能"
  },
  Skill_4019_Name = {
    Text = "悖论收束"
  },
  Skill_4019_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。将上回合最后打出的 3 张不同非衍生指令卡原始复制置入手中，使它们算力消耗变为 0 并获得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>。若可置入手中的指令卡不足，则抽等量牌代替。获得 3 层无视上限的<TimeBeacon2:负熵>。"
  },
  Skill_4019_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。将上回合最后打出的 3 张不同非衍生指令卡原始复制置入手中，使它们算力消耗变为 0 并获得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>。若可置入手中的指令卡不足，则抽等量牌代替。选择 1 个任意已解锁钥令替换当前钥令，使用钥令或战斗结束后恢复。获得 3 层无视上限的<TimeBeacon2:负熵>。"
  },
  Skill_4019_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4020_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4020_Name = {
    Text = "拥抱融蚀"
  },
  Skill_4021_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，提高后续「连续撕咬」的攻击次数。"
  },
  Skill_4021_Name = {
    Text = "连续撕咬"
  },
  Skill_4022_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，提高后续「连续撕咬」的攻击次数。"
  },
  Skill_4022_Name = {
    Text = "连续撕咬"
  },
  Skill_4023_AwakerSkillBackgroundStory = {
    Text = "莉兹还记得自己获得绿炎那天的景象。\n青色的火种在掌心升腾跃动，催促她去达成那压抑已久的愿望。"
  },
  Skill_4023_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，施加 [Arg2]% 伤害的<IntoxicationIconKeywords:中毒>。回合结束时若在手牌或<DimensionalSpaceIconKeywords:超维空间>，升级为「<DerivativeCardKeywords_19:腐化绿炎>」。算力不足时可以强行打出，效果改为获得 <Energy:[Energy:Arg3]> 点狂气并消耗。"
  },
  Skill_4023_EffectNameList = {Text = "伤害"},
  Skill_4023_Name = {Text = "绿炎"},
  Skill_4023_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4024_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4025_Desc = {
    Text = "造成 [Arg1] 层<WeaknessIconKeywords:虚弱>，获得「鼠群之怒」：下回合每受到 1 攻击会获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4025_Name = {
    Text = "集结鼠群"
  },
  Skill_4026_Desc = {
    Text = "<PowerIconKeywords:力量>翻倍。"
  },
  Skill_4026_Name = {
    Text = "绝境求生"
  },
  Skill_4027_AwakerSkillBackgroundStory = {
    Text = "菲茵特无法离开薄壳，汀克特便时常陪在她的身边，为她清唱这支安魂曲。\n「我会吸收你的生命力的。」菲茵特如是说。\n「没关系，我们的生命是一体的。」汀克特回应。"
  },
  Skill_4027_BattleDesc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>状态。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，每有 1 名敌人获得 [Power:Arg1] 点<PowerIconKeywords:临时力量>。本回合下一次跃迁效果必定发动。<TransitionIconKeywords:跃迁>：改为临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>，每有 1 名敌人获得 [Power:Arg2] 点<PowerIconKeywords:临时力量>。"
  },
  Skill_4027_Desc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>状态。<TouquKeywords:偷取>所有敌人 [Arg1] 点<PowerIconKeywords:力量>。本回合下一次跃迁效果必定发动。<TransitionIconKeywords:跃迁>：改为<TouquKeywords:偷取> [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4027_EffectNameList = {
    Text = "偷取力量,跃迁偷取力量"
  },
  Skill_4027_Name = {Text = "安魂曲"},
  Skill_4027_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_4028_Name = {
    Text = "自毁攻击"
  },
  Skill_4029_Desc = {
    Text = "施加 [Arg1] 层<BleedingIconKeywords:出血>，降低  [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4029_Name = {
    Text = "侵蚀之视"
  },
  Skill_4030_Desc = {
    Text = "每回合获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4030_Name = {
    Text = "远古的呼唤"
  },
  Skill_4031_Desc = {
    Text = "获得 [Arg1] 点护盾，失去 [Arg2] 点<AlertIconKeywords:戒备>。"
  },
  Skill_4031_Name = {
    Text = "枷锁：掌政官夫人"
  },
  Skill_4032_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4032_Name = {Text = "重击"},
  Skill_4033_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使扭曲死体狂宴伤害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_4033_Name = {
    Text = "纷乱切割"
  },
  Skill_4034_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4035_AwakerSkillBackgroundStory = {
    Text = "纷乱的灵魂只专注自身，它们注定疏于防备。"
  },
  Skill_4035_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4035_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。「24」获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4035_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4035_Name = {Text = "防御"},
  Skill_4035_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4036_AwakerSkillBackgroundStory = {
    Text = "进行精细操作时，朵尔的这双螯钳不太好用。\n但在完全将外域科技改造为人类可用的技术前，她还需要忍受「这双手」至少十年。"
  },
  Skill_4036_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4036_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。朵尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4036_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4036_Name = {Text = "打击"},
  Skill_4036_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4037_Desc = {
    Text = "解除所有手牌的<SlowIconKeywords:迟缓>效果。"
  },
  Skill_4037_Name = {
    Text = "我不是木偶"
  },
  Skill_4038_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，降低  [Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4041_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4042_Desc = {
    Text = "因寄生被打断，陷入了短暂的混乱…"
  },
  Skill_4042_Name = {Text = "混乱"},
  Skill_4043_BattleDesc = {
    Text = "对所有敌人造成 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，临时降低所有敌人 [Arg2] 点<ExhaustionIconKeywords:力量>，每有 1 名敌人获得 [Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4043_Desc = {
    Text = "对所有敌人造成 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，<TouquKeywords:偷取>所有敌人 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4043_Name = {
    Text = "脑中之音"
  },
  Skill_4044_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4045_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>，恢复等同于未被格挡伤害的生命。"
  },
  Skill_4045_Name = {
    Text = "欢愉与血"
  },
  Skill_4046_AwakerSkillBackgroundStory = {
    Text = "指令：攻击。撕咬。"
  },
  Skill_4046_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4046_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莉莉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4046_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4046_Name = {Text = "打击"},
  Skill_4046_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4048_Desc = {
    Text = "选择 1 名唤醒体使其获得 <Energy:[Arg1]> 点狂气。"
  },
  Skill_4048_Name = {
    Text = "小小心愿"
  },
  Skill_4049_Desc = {
    Text = "回复 [Arg1] 点生命，回合结束失去全部护盾。"
  },
  Skill_4049_Name = {
    Text = "枷锁：受刑的奴隶"
  },
  Skill_4050_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将2张<DerivativeCardKeywords_3:「惊厥」>洗入抽牌堆。"
  },
  Skill_4050_Name = {Text = "明灭"},
  Skill_4051_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，生命越低伤害越高。"
  },
  Skill_4051_Name = {
    Text = "报偿打击"
  },
  Skill_4052_Desc = {
    Text = "血肉界域唤醒体释放狂气爆发时可将其消耗，触发 1 次<DevouredIconKeywords:吞噬>效果。打出后选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，本回合暴击率提高 [Arg2]%。"
  },
  Skill_4052_Name = {Text = "胚胎"},
  Skill_4052_tempBattleDesc_1 = {
    Text = "血肉界域唤醒体释放狂气爆发时可将其消耗，触发 1 次<DevouredIconKeywords:吞噬>效果。打出后选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，本回合暴击率提高 [Arg2]%。"
  },
  Skill_4052_tempBattleDesc_2 = {
    Text = "血肉界域唤醒体释放狂气爆发时可将其消耗，触发 1 次<DevouredIconKeywords:吞噬>效果。打出后选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。唤醒体每回合首次消耗「胚胎」或「圣洁之子」时，获得 [Arg3] 层<BreedingKeywords1:繁育庆典>。"
  },
  Skill_4052_tempName_1 = {Text = "胚胎"},
  Skill_4052_tempName_2 = {
    Text = "繁育· 胚胎"
  },
  Skill_4053_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4054_Desc = {
    Text = "一种特殊的撕裂伤口。回合结束时若在手中，受到 [Arg1] 点<FixedDamage:纯粹伤害>。弃掉时将其<DepleteIconKeywords:消耗>。"
  },
  Skill_4054_Name = {Text = "裂伤"},
  Skill_4055_AwakerSkillBackgroundStory = {
    Text = "一望无际的大洋之中，孤独的航船随着海浪摇摆。\n他们祈求、恳求、哀求，希望白色的圣女能将他们带离大海，重新踏上故乡的土地。\n中心桅杆上，白裙的女孩抬起头，望见了一只白色的飞鸟。\n「予舵于我，我将带你们归家。」"
  },
  Skill_4055_BattleDesc_0 = {
    Text = "驱散自身<HeavyInjuryKeywords:重创>状态，回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力。本场战斗中受到致死伤害时复活并回复 [Arg2]%(<Heal:[Arg3]>) 生命，每场战斗只能触发 1 次。"
  },
  Skill_4055_BattleDesc_3 = {
    Text = "驱散自身<HeavyInjuryKeywords:重创>状态，回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力。本场战斗中受到致死伤害时复活，回复 [Arg2]%(<Heal:[Arg3]>) 生命并使所有唤醒体获得 <Energy:[Energy:Arg4]> 点狂气，触发后需要间隔 6 个回合才可再次施加可复活效果。"
  },
  Skill_4055_Desc_0 = {
    Text = "驱散自身<HeavyInjuryKeywords:重创>状态，回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力。本场战斗中受到致死伤害时复活并回复 [Arg2]% 生命，每场战斗只能触发 1 次。"
  },
  Skill_4055_Desc_3 = {
    Text = "驱散自身<HeavyInjuryKeywords:重创>状态，回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力。本场战斗中受到致死伤害时复活，回复 [Arg2]% 生命并使所有唤醒体获得 <Energy:[Energy:Arg4]> 点狂气，触发后需要间隔 6 个回合才可再次施加可复活效果。"
  },
  Skill_4055_EffectNameList = {
    Text = "回复,回复百分比生命"
  },
  Skill_4055_Name = {
    Text = "不死的极乐鸟"
  },
  Skill_4055_OverLimitUtlSkillDesc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力，驱散自身<HeavyInjuryKeywords:重创>状态。本场战斗中受到致死伤害时复活，回复 [Arg2]%(<Heal:[Arg3]>) 生命，每场战斗只能触发 1 次。将 3 张回复提高 50% 的「纯白梦境」置入手中并附加消耗。"
  },
  Skill_4055_OverLimitUtlSkillDesc_3 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命并获得 1 算力，驱散自身<HeavyInjuryKeywords:重创>状态。本场战斗中受到致死伤害时复活，回复 [Arg2]%(<Heal:[Arg3]>) 生命并使所有唤醒体获得 <Energy:[Energy:Arg4]> 点狂气，触发后需要间隔 6 个回合才可再次施加可复活效果。将 3 张回复提高 50% 的「纯白梦境」置入手中并附加消耗。"
  },
  Skill_4055_PropertyNameList = {
    Text = "体质*GrowValue1,$GrowValue2"
  },
  Skill_4056_AwakerSkillBackgroundStory = {
    Text = "「谢谢小熊——呜啊别生气，我说错了，应该是谢谢小眼睛。」"
  },
  Skill_4056_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4056_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。艾继丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4056_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4056_Name = {Text = "防御"},
  Skill_4056_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4057_Desc = {
    Text = "释放血之灯：每回合结束后，施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4057_Name = {Text = "血之灯"},
  Skill_4058_Desc = {
    Text = "击晕「分裂患者」，抽 3 张牌，获得 3 点算力。"
  },
  Skill_4058_Name = {Text = "救救我"},
  Skill_4059_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4059_Name = {
    Text = "灼燃蜡滴之欲"
  },
  Skill_4060_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4060_Name = {Text = "出血"},
  Skill_4061_AwakerSkillBackgroundStory = {
    Text = "一个人一生中必定会经历三件事：出生、死亡、得罪阿格里帕。"
  },
  Skill_4061_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。阿格里帕获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4061_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。阿格里帕获得 <Energy:[Energy:Arg2]> 点狂气。触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4061_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4061_Name = {Text = "打击"},
  Skill_4061_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4062_Desc = {
    Text = "造成 99 层<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。将 1 张<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_4062_Name = {
    Text = "恍然如我"
  },
  Skill_4063_Desc = {
    Text = "将五张症状卡塞入抽牌堆。"
  },
  Skill_4063_Name = {
    Text = "疾病缠身"
  },
  Skill_4064_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4064_Name = {Text = "出血"},
  Skill_4065_AwakerSkillBackgroundStory = {
    Text = "上位的恶意躁动不已，人类的意志却也不是毫无招架之力。\n溶解一切的黑色黏液削弱了祂的精神，成了人类唯一的帮助。\n造偶师短暂地占据上风，她张开双臂，将破坏的电流化作守护的弯弧。"
  },
  Skill_4065_BattleDesc_0 = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。获得 <Posse:[Arg2]> 点银钥能量。驱散自身<FragileIconKeywords:脆弱>状态。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_13:「机械武装-放」>。"
  },
  Skill_4065_BattleDesc_1 = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。获得 <Posse:[Arg2]> 点银钥能量。驱散自身<FragileIconKeywords:脆弱>状态。将 1 张艾瑞卡附加<DepleteIconKeywords:消耗>的「防御」置入手牌。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_13:「机械武装-放」>。"
  },
  Skill_4065_Desc_0 = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。获得等同于艾瑞卡银钥充能的银钥能量。驱散自身<FragileIconKeywords:脆弱>状态。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_13:「机械武装-放」>。"
  },
  Skill_4065_Desc_1 = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。获得等同于艾瑞卡银钥充能的银钥能量。驱散自身<FragileIconKeywords:脆弱>状态。将 1 张艾瑞卡附加<DepleteIconKeywords:消耗>的「防御」置入手牌。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_13:「机械武装-放」>。"
  },
  Skill_4065_EffectNameList = {
    Text = "力量,戒备"
  },
  Skill_4065_Name = {
    Text = "机械武装-敛"
  },
  Skill_4065_PropertyNameList = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4066_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4067_Desc = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4067_Name = {
    Text = "复仇宣言"
  },
  Skill_4068_AwakerSkillBackgroundStory = {
    Text = "女孩自幼接受严苛的贵族教育。\n这些繁复的教条总结起来只有一个词：克制。\n它们包括但不限于体态、食欲、说话的音量……\n女孩终日坐在鲜花盛开的庭院里读诗、唱歌与祈祷。\n她感到饥饿极了。"
  },
  Skill_4068_BattleDesc_0 = {
    Text = "失去 [Arg1]%([Arg4]) 当前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4068_BattleDesc_2 = {
    Text = "失去 [Arg1]%([Arg4]) 当前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 <Energy:[Energy:Arg5]> 点狂气。"
  },
  Skill_4068_Desc_0 = {
    Text = "失去 [Arg1]% 当前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4068_Desc_2 = {
    Text = "失去 [Arg1]% 当前生命。 <EmbryoFusionIconKeywords:胚胎融合>+[Blood:Arg3]。获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 <Energy:[Energy:Arg5]> 点狂气。"
  },
  Skill_4068_EffectNameList_0 = {
    Text = "力量,胚胎融合"
  },
  Skill_4068_Name = {
    Text = "未被满足之痛"
  },
  Skill_4068_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4069_AwakerSkillBackgroundStory = {
    Text = "「防护模式切换完毕，还请你躲在我身后。」"
  },
  Skill_4069_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4069_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。艾瑞卡获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4069_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4069_Name = {Text = "防御"},
  Skill_4069_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4070_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量伤害<BleedingIconKeywords:出血>。"
  },
  Skill_4071_Name = {Text = "出血"},
  Skill_4072_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量>，自身获得 <Block:[Block:Arg2]> 护盾 。"
  },
  Skill_4072_Name = {
    Text = "全体强化"
  },
  Skill_4073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4073_Name = {Text = "欢愉"},
  Skill_4074_Desc = {
    Text = "将所有唤醒体的「防御」置入手中。失控希洛似乎只关注莉莉……"
  },
  Skill_4074_Name = {Text = "躲藏"},
  Skill_4075_AwakerSkillBackgroundStory = {
    Text = "宁菲亚很喜欢花，除了文学小说外，这是唯一在病床前陪伴她的存在。\n只是，自父母逝世后，再无人定期送来安慰的捧花。\n那最后一捧百合花，也随着时日推移逐渐失去了鲜活。\n所以，在为自己准备的葬仪上，她毫不犹豫地携带上了它。\n游鱼随光影舞动，珊瑚似茎叶生发，随涌动的海浪袭向她目光所指的远方。"
  },
  Skill_4075_BattleDesc_0 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]% 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4075_BattleDesc_3 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]% 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。本场战斗后续释放「自我的葬仪」施加的<IntoxicationIconKeywords:中毒>层数提高 [Poison:Arg4] 层。"
  },
  Skill_4075_Desc_0 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]% 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4075_Desc_3 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]% 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。本场战斗后续释放「自我的葬仪」施加的<IntoxicationIconKeywords:中毒>层数提高 [Poison:Arg4] 层。"
  },
  Skill_4075_EffectNameList_0 = {
    Text = "中毒,力量"
  },
  Skill_4075_EffectNameList_3 = {
    Text = "中毒,力量,中毒层数加成"
  },
  Skill_4075_Name = {
    Text = "自我的葬仪"
  },
  Skill_4075_OverLimitUtlSkillDesc_0 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。宁菲亚造成的<IntoxicationIconKeywords:中毒>提高 50%，持续 3 回合。"
  },
  Skill_4075_OverLimitUtlSkillDesc_3 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>并触发 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。本场战斗后续释放「自我的葬仪」施加的<IntoxicationIconKeywords:中毒>层数提高 [Poison:Arg4] 层。宁菲亚造成的<IntoxicationIconKeywords:中毒>提高 50%，持续 3 回合。"
  },
  Skill_4075_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4075_PropertyNameList_3 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4076_AwakerSkillBackgroundStory = {
    Text = "穿裘皮的维纳斯，将你的脚踏在奴隶的背上吧！\n将锁链系在他们的脖子上，用脊刺刺穿他们伤痕累累的心。"
  },
  Skill_4076_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，该伤害享受 [Arg4]% 的<RetaliateIconKeywords:反击>加成，每次攻击使伤害目标临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:跃迁>：消耗 5 层<DreamGuide:梦引>，若成功则返还消耗的算力并额外造成 2 次伤害，否则获得 2 层<DreamGuide:梦引>。"
  },
  Skill_4076_Desc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，该伤害享受 [Arg4]% 的<RetaliateIconKeywords:反击>加成，每次攻击使伤害目标临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。此卡暴击率提高 25%。<TransitionIconKeywords:跃迁>：消耗 5 层<DreamGuide:梦引>，若成功则返还消耗的算力并额外造成 2 次伤害，否则获得 2 层<DreamGuide:梦引>。"
  },
  Skill_4076_EffectNameList = {
    Text = "伤害,力量降低,反击加成"
  },
  Skill_4076_Name = {
    Text = "脊刺锁链"
  },
  Skill_4076_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,$GrowValue3%"
  },
  Skill_4077_AwakerSkillBackgroundStory = {
    Text = "那些触肢属于哪位神明，业已无从知晓。\n祂们来自深渊，祂们盘踞深海，祂们肆意伸展——祂们将听从螺湮主宰的号令。"
  },
  Skill_4077_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，额外享受 [Arg3]% 触腕伤害和力量加成。使所有触腕攻击 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺伤害>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4077_BattleDesc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，额外享受 [Arg3]% 触腕伤害和力量加成。使所有触腕攻击所有敌人 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺伤害>。若当前姿态为「静海」，算力消耗降低 2 点。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4077_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，额外享受 [Arg3]% 触腕伤害和力量加成。使所有触腕攻击 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺伤害>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4077_Desc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，额外享受 [Arg3]% 触腕伤害和力量加成。使所有触腕攻击所有敌人 [Arg2] 次，造成  [Arg4]% 的<PunctureDamagewords:穿刺伤害>。若当前姿态为「静海」，算力消耗降低 2 点。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4077_EffectNameList = {
    Text = "伤害,所有触腕攻击伤害百分比"
  },
  Skill_4077_Name = {
    Text = "深渊号令"
  },
  Skill_4077_PropertyNameList = {
    Text = "攻击力*GrowValue1,GrowValue2"
  },
  Skill_4078_Desc = {
    Text = "回合结束时，若此卡牌仍在手中且本回合打出的卡牌不多于 3 张，下回合额外获得 2 点算力。"
  },
  Skill_4078_Name = {
    Text = "症状：多疑"
  },
  Skill_4080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每受到 1 次攻击伤害次数提高 1。"
  },
  Skill_4080_Name = {
    Text = "狂气使役之鞭"
  },
  Skill_4081_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4082_Desc = {
    Text = "获得 1 层临时<ParcloseIconKeywords:屏障>，算力永久减少 2。"
  },
  Skill_4082_Name = {
    Text = "枷锁：复苏的圣女"
  },
  Skill_4085_Desc = {
    Text = "施加 [Arg1] 层<BleedingIconKeywords:出血>，降低  [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4085_Name = {
    Text = "侵蚀之视"
  },
  Skill_4086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。后撤。"
  },
  Skill_4087_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。自身获得 [Arg3] 层「蜡质镀层」：免疫异常状态，每次被暴击后减少 1 层。"
  },
  Skill_4087_Name = {
    Text = "蜡像登场"
  },
  Skill_4088_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张<DerivativeCardKeywords_38:「幻觉」>洗入对方抽牌堆，"
  },
  Skill_4088_Name = {Text = "幻觉"},
  Skill_4089_Desc = {
    Text = "狂气最低唤醒体获得[Arg1]狂气。"
  },
  Skill_4089_Name = {
    Text = "天真的回礼"
  },
  Skill_4090_Desc = {
    Text = "目标唤醒体获得[Arg1]狂气。"
  },
  Skill_4090_Name = {
    Text = "天真的回礼"
  },
  Skill_4092_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4092_Name = {
    Text = "意外身故"
  },
  Skill_4093_AwakerSkillBackgroundStory = {
    Text = "明面上，那个与温柯尔形影不离的仪器被称为「定位仪-Y031」，据说能稳定精神，检测精神波动。\n至于它为什么还具备压缩精神力，将其如同炮弹一样射出的功能，温柯尔却避而不谈。"
  },
  Skill_4093_Desc_0 = {
    Text = "移除所有敌方<ParcloseIconKeywords:屏障>状态并造成 <Damage:[Damage:Arg1]> 点伤害和 1 回合的<WeaknessIconKeywords:虚弱>。获得 [Arg3] 点银钥能量。<TransitionIconKeywords:跃迁>：改为获得  <Energy:[Energy:Arg2]> 点狂气"
  },
  Skill_4093_Desc_1 = {
    Text = "移除所有敌方<ParcloseIconKeywords:屏障>状态并造成 <Damage:[Damage:Arg1]> 点伤害和 1 回合的<WeaknessIconKeywords:虚弱>。获得 [Arg3] 点银钥能量。<TransitionIconKeywords:跃迁>：改为获得  <Energy:[Energy:Arg2]> 点狂气。造成的伤害享受 [Arg4]% 反击加成。"
  },
  Skill_4093_EffectNameList_0 = {
    Text = "伤害,狂气,银钥能量"
  },
  Skill_4093_EffectNameList_1 = {
    Text = "伤害,狂气,银钥能量,反击加成"
  },
  Skill_4093_Name = {
    Text = "能量射线"
  },
  Skill_4093_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4093_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4094_Desc = {
    Text = "对一名唤醒体的卡牌添加「被狩猎」状态，自身施加2层「狩猎印记」。"
  },
  Skill_4094_Name = {
    Text = "狩猎仪式"
  },
  Skill_4095_AwakerSkillBackgroundStory = {
    Text = "落单的老鼠在阴暗的角落里窜行，它瘦弱、渺小，一把扫帚就能将它轻易驱逐。\n流浪儿也是如此。\n渺小之中亦有力量，当流浪儿与老鼠组成搭档，她们也可以势不可挡。"
  },
  Skill_4095_Desc_0 = {
    Text = "将 1 张随机造成 <Damage:[Damage:Arg1]> 点伤害 X+1 次的<DerivativeCardKeywords_12:「鼠群冲击」>洗入抽牌堆。"
  },
  Skill_4095_Desc_3 = {
    Text = "将 1 张随机造成 <Damage:[Damage:Arg1]> 点伤害 X+2 次的<DerivativeCardKeywords_12:「鼠群冲击」>洗入抽牌堆。"
  },
  Skill_4095_EffectNameList = {
    Text = "「鼠群冲击」伤害"
  },
  Skill_4095_Name = {
    Text = "集结鼠群"
  },
  Skill_4095_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，恢复等同于未被格挡伤害的生命。"
  },
  Skill_4097_Name = {Text = "血"},
  Skill_4098_Desc = {
    Text = "粘液重新汇集成了莉莉，获得状态：不灭之花，并切换攻击形态。召唤一个脓疱。"
  },
  Skill_4098_Name = {
    Text = "粘液汇集"
  },
  Skill_4099_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4100_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4102_AwakerSkillBackgroundStory = {
    Text = "饥肠辘辘的莱克揉着肚子走在街头。\n要是面前突然出现一只烧鸡就好了，莱克想。\n一个黑影从身边窜出，随后传来女人的尖叫。\n莱克眼明手快地逮住黑影，正准备将提包还给女人，却发现女人神色有异。\n一番纠缠后，巡警姗姗来迟。\n原来女人正是闻名遐迩的宝石怪盗。\n失主请莱克饱餐一顿，还额外加赠一枚金色宝石。\n「真是意外收获。」莱克揉着肚子说道。"
  },
  Skill_4102_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。选择 1 张抽牌堆的牌置入手中，若暴击则使选择的卡牌算力消耗降低 1 点。"
  },
  Skill_4102_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。选择 1 张抽牌堆的牌置入手中，若暴击则使选择的卡牌算力消耗降低 2 点。"
  },
  Skill_4102_EffectNameList = {Text = "伤害"},
  Skill_4102_Name = {
    Text = "意外收获"
  },
  Skill_4102_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4103_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4104_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每有 1 层「狩猎印记」降低 [Arg4] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4104_Name = {
    Text = "裂颅一击"
  },
  Skill_4105_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4105_Name = {Text = "试探"},
  Skill_4106_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。詹金每次造成未被格挡的伤害，都会在随机「指令卡」上留下永久伤痕。"
  },
  Skill_4106_Name = {
    Text = "空间折叠"
  },
  Skill_4107_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4108_Desc = {
    Text = "将所有症状卡变化为<DerivativeCardKeywords_37:「窒息」>，窒息：1算力，回合结束时若还在手中对自身施加[Arg1]点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4108_Name = {
    Text = "沉逝苦海"
  },
  Skill_4109_AwakerSkillBackgroundStory = {
    Text = "柔和的海风中她陷入沉睡，却被振翅的声音惊醒。一只通体雪白的小鸟掠过她的头顶，消失在同样雪白的云朵之中。\n那一定是梦吧，在这远离陆地的大洋深处，怎么会有落单的飞鸟呢？\n她这么想着，却无法自已地感到一种希冀，一种向往。"
  },
  Skill_4109_BattleDesc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。获得 [Arg2] 点算力并驱散手牌<SlowIconKeywords:迟缓>状态。激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4109_BattleDesc_2 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。获得 [Arg2] 点算力并驱散手牌<SlowIconKeywords:迟缓>状态。每<RetainIconKeywords:保留> 1 回合，下次打出时额外回复 <Heal:[Arg3]> 点生命。激发 1 条触腕攻击敌人，造成 [Arg4]％ 触腕伤害。"
  },
  Skill_4109_Desc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。获得 [Arg2] 点算力并驱散手牌<SlowIconKeywords:迟缓>状态。激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4109_Desc_2 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。获得 [Arg2] 点算力并驱散手牌<SlowIconKeywords:迟缓>状态。每<RetainIconKeywords:保留> 1 回合，下次打出时额外回复 <Heal:[Arg3]> 点生命。激发 1 条触腕攻击敌人，造成 [Arg4]％ 触腕伤害。"
  },
  Skill_4109_EffectNameList_0 = {Text = "回复"},
  Skill_4109_EffectNameList_2 = {
    Text = "回复,额外回复"
  },
  Skill_4109_Name = {
    Text = "纯白梦境"
  },
  Skill_4109_PropertyNameList_0 = {
    Text = "体质*GrowValue1,"
  },
  Skill_4109_PropertyNameList_2 = {
    Text = "体质*GrowValue1,体质*GrowValue2"
  },
  Skill_4110_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4110_Name = {
    Text = "蜡像登场"
  },
  Skill_4111_AwakerSkillBackgroundStory = {
    Text = "跨越维度的切割，令缺乏警惕之人身首分离。"
  },
  Skill_4111_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4111_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 2 倍力量加成。获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 点算力。"
  },
  Skill_4111_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。达芙黛尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4111_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 2 倍力量加成。达芙黛尔获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 点算力。"
  },
  Skill_4111_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4111_Name = {Text = "打击"},
  Skill_4111_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4112_Desc = {
    Text = "选择 1 张抽牌堆的卡牌置入手牌。"
  },
  Skill_4112_Name = {Text = "检索"},
  Skill_4113_AwakerSkillBackgroundStory = {
    Text = "宁菲亚是海的宠儿。无论何时，只要她开始祈祷，这些海的精灵就会环绕她左右，久久不肯离去。"
  },
  Skill_4113_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4113_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。宁菲亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4113_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4113_Name = {Text = "防御"},
  Skill_4113_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4114_AwakerSkillBackgroundStory = {
    Text = "「这样的简单把戏，您可看好了，我尊贵的客人。」"
  },
  Skill_4114_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4114_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。若当前生命低于 50%，额外获得 1 次护盾，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4114_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。索蕾尔获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4114_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。若当前生命低于 50%，额外获得 1 次护盾，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg4]。索蕾尔获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4114_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4114_Name = {Text = "防御"},
  Skill_4114_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4115_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4116_Desc = {
    Text = "抽到时使自身最大生命降低 20%。使用后使所有唤醒体本回合暴击伤害提高 100%。"
  },
  Skill_4116_Name = {Text = "融蚀"},
  Skill_4117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 2 张<DerivativeCardKeywords_34:「未被满足之痛」>置入抽牌堆。"
  },
  Skill_4117_Name = {Text = "苦痛"},
  Skill_4118_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4118_Name = {
    Text = "自我的葬仪"
  },
  Skill_4119_BattleDesc = {
    Text = "失去 [Arg1] 点生命，获得 2 点算力。无法出售。"
  },
  Skill_4119_Desc = {
    Text = "失去 10% 最大生命，获得 2 点算力。无法出售。"
  },
  Skill_4119_Name = {
    Text = "症状：妄想"
  },
  Skill_4120_AwakerSkillBackgroundStory = {
    Text = "她请求角斗士杀死自己。\n「马上，他们就会找到我，羞辱我，然后割下我的头，就像对我父母一样。\n我不愿死在那些低贱的虫子手上，不过你…...和他们不一样。\n这是我唯一的请求——杀了我。」\n角斗士哈哈大笑，声音震动胸腔，连带身上的枷锁哗啦啦作响。\n他并未被她的说辞打动，但他从不拒绝送上门的新鲜血液。"
  },
  Skill_4120_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。当前<EmbryoFusionIconKeywords:胚胎融合>翻倍。"
  },
  Skill_4120_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。当前<EmbryoFusionIconKeywords:胚胎融合>翻倍。使手牌中算力消耗最高的 1 张卡在本回合中算力消耗 -1。"
  },
  Skill_4120_EffectNameList_0 = {Text = "护盾"},
  Skill_4120_Name = {
    Text = "不耐的施舍"
  },
  Skill_4120_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4121_AwakerSkillBackgroundStory = {
    Text = "除了温和秀美，锐利而具有攻击性也是艺术的一部分。"
  },
  Skill_4121_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。珊获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4121_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4121_Name = {Text = "打击"},
  Skill_4121_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4122_AwakerSkillBackgroundStory = {
    Text = "护鳍是自卑，是被排挤者自我搭建的壁垒。"
  },
  Skill_4122_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4122_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。凯刻斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4122_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4122_Name = {Text = "防御"},
  Skill_4122_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4123_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4124_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4125_AwakerSkillBackgroundStory = {
    Text = "艾瑞卡腰侧的装置正是她的动力来源，那层叠交错的机械遵循着无法理解的原理，源源不断地为她提供必要的电流。\n如同它的主人一样，这个装置极不稳定，在她短路的瞬间会爆发出巨大的能量，可见的电流四下飞射，灼烧着周围的一切。"
  },
  Skill_4125_Desc_0 = {
    Text = "若消耗算力为偶数，造成 <Damage:[Damage:Arg2]> 点伤害 X+2 次。否则获得 <Block:[Block:Arg3]> 点护盾 X+1 次。"
  },
  Skill_4125_Desc_3 = {
    Text = "若消耗算力为偶数，造成 <Damage:[Damage:Arg2]> 点伤害 X+2 次。否则获得 <Block:[Block:Arg3]> 点护盾 X+1 次。<TransitionIconKeywords:跃迁>：同时拥有两种效果。"
  },
  Skill_4125_EffectNameList = {
    Text = "伤害,护盾"
  },
  Skill_4125_Name = {
    Text = "机能过载"
  },
  Skill_4125_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，在后排召唤「求告者」。"
  },
  Skill_4126_Name = {
    Text = "分裂打击"
  },
  Skill_4127_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入对方抽牌堆。"
  },
  Skill_4127_Name = {
    Text = "隆重的接待"
  },
  Skill_4128_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4129_Desc = {
    Text = "弃掉所有手牌，抽取弃掉数量 +2 的牌。"
  },
  Skill_4129_Name = {
    Text = "纯白初遇"
  },
  Skill_4130_AwakerSkillBackgroundStory = {
    Text = "「欢笑吧，尖叫吧，癫狂吧！只有这样才叫嘉年华！」"
  },
  Skill_4130_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4130_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。卡茜亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4130_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4130_Name = {Text = "打击"},
  Skill_4130_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4132_Desc = {
    Text = "无法打出。"
  },
  Skill_4132_Name = {Text = "幻觉"},
  Skill_4133_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4133_Name = {
    Text = "石质分解"
  },
  Skill_4134_AwakerSkillBackgroundStory = {
    Text = "主教虔诚地执行祝福的仪式。\n愿人们不再受伤、不再痛苦。愿那没有苦难的国降临于世。"
  },
  Skill_4134_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4134_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。积攒 <Heal:[Heal:Arg3]> 点猩红熔炉回复量。"
  },
  Skill_4134_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。萨尔瓦多获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4134_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。萨尔瓦多获得 <Energy:[Energy:Arg2]> 点狂气。积攒 <Heal:[Heal:Arg3]> 点猩红熔炉回复量。"
  },
  Skill_4134_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4134_EffectNameList_1 = {
    Text = "护盾,狂气,猩红熔炉积攒量"
  },
  Skill_4134_Name = {Text = "防御"},
  Skill_4134_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4134_PropertyNameList_1 = {
    Text = "防御力*GrowValue1,$GrowValue2,体质*GrowValue3"
  },
  Skill_41357_Desc = {
    Text = "消耗 10 层<DreamGuide:梦引>，使所有敌人本回合进入「呓语」状态：伤害减少 [Arg3]% ，但攻击次数翻倍。"
  },
  Skill_41357_Name = {
    Text = "呓语回音"
  },
  Skill_41358_Desc = {
    Text = "获得 1 层<DreamGuide:梦引>。"
  },
  Skill_41358_Name = {
    Text = "催眠脉络"
  },
  Skill_41359_Desc = {
    Text = "消耗 5 层<DreamGuide:梦引>，旺达获得 <Energy:[Energy:Arg1]> 点狂气，获得等同于 [Arg2]% 永久<RetaliateIconKeywords:反击>([Arg3])的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_41359_Name = {
    Text = "深眠反击"
  },
  Skill_4135_Desc = {Text = "废弃"},
  Skill_4135_Name = {Text = "废弃"},
  Skill_4136_Desc = {
    Text = "弃掉所有手牌，"
  },
  Skill_4136_Name = {
    Text = "畸变之心"
  },
  Skill_4137_AwakerSkillBackgroundStory = {
    Text = "演绎法是一种逻辑推理，只有掌握了正确的前提，才能得出准确的结论。\n在成为调查员前，拉蒙娜一直在使用演绎法来认知世界。\n进行了足够多的冒险后，也许她会开始考虑使用归纳法吧。"
  },
  Skill_4137_Desc_0 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。选择 1 张抽牌堆或弃牌堆的牌置入手牌，使其算力消耗变为 0 点。"
  },
  Skill_4137_Desc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。选择 1 张抽牌堆或弃牌堆的牌置入手牌，使其算力消耗变为 0 点。将 1 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆。"
  },
  Skill_4137_EffectNameList = {
    Text = "银钥充能"
  },
  Skill_4137_Name = {
    Text = "世界演绎法"
  },
  Skill_4137_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。选择 1 张抽牌堆或弃牌堆的牌置入手牌，使其算力消耗变为 0 点。<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，下个释放的钥令生效 2 次。"
  },
  Skill_4137_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Posse:[Arg1]> 点银钥能量。选择 1 张抽牌堆或弃牌堆的牌置入手牌，使其算力消耗变为 0 点。将 1 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆。<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，下个释放的钥令生效 2 次。"
  },
  Skill_4137_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4138_AwakerSkillBackgroundStory = {
    Text = "拉蒙娜在十岁那年，提出了希望接受战斗训练的请求。\n倒不是想玩什么骑士游戏，只是在目睹了养父的铺张与挥霍后，少女决定为可能到来的破产做准备。\n「当女王护卫的报酬，会比警局的薪水高吧？」"
  },
  Skill_4138_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。打出后使「女王之剑」伤害次数 +1，最多提高为 [Arg3] 次。获得 [Arg7] 点临时界域精通。"
  },
  Skill_4138_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg5] 次，每次造成伤害获得 [Power:Arg4] 点临时<PowerIconKeywords:力量>。打出后使「女王之剑」伤害次数 +1，最多提高为 [Arg6] 次。获得 [Arg7] 点临时界域精通。<RippleKeywords:余波>：获得 300% 等同于拉蒙娜银钥充能的银钥能量。"
  },
  Skill_4138_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg5] 次，每次造成伤害获得 [Power:Arg4] 点临时<PowerIconKeywords:力量>。打出后使「女王之剑」伤害次数 +1，最多提高为 [Arg6] 次。获得 [Arg7] 点临时界域精通。<RippleKeywords:余波>：获得 300% 等同于拉蒙娜银钥充能的银钥能量。"
  },
  Skill_4138_EffectNameList_0 = {Text = "伤害"},
  Skill_4138_EffectNameList_1 = {
    Text = "伤害,临时力量"
  },
  Skill_4138_Name = {
    Text = "女王之剑"
  },
  Skill_4138_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4138_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4139_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 点护盾和 [Arg3] 点<AlertIconKeywords:戒备>。"
  },
  Skill_4139_Name = {
    Text = "全体强化"
  },
  Skill_4140_Desc = {
    Text = "抽到时失去 1 点生命，打出后抽 1 张牌。身体似乎正在消散……"
  },
  Skill_4140_Name = {Text = "融蚀浆"},
  Skill_4141_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4142_Desc = {
    Text = "抽 2 张牌，将 1 张「症状：呓语」加入弃牌堆中。无法出售。"
  },
  Skill_4142_Name = {
    Text = "症状：呓语"
  },
  Skill_4143_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4144_AwakerSkillBackgroundStory = {
    Text = "如果是主人的命令的话，莉莉可以抛出那个大家伙。\n它不害怕疼痛。\n疼痛只是力量，疼痛驱使狂躁，莉莉不害怕疼痛，它也不害怕疼痛。\n所以，它一定可以帮主人消灭敌人。"
  },
  Skill_4144_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2，打出后移除<PainWord:忍耐>。"
  },
  Skill_4144_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2，打出后移除<PainWord:忍耐>。此卡暴击率提高 20%。"
  },
  Skill_4144_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2，打出后移除一半<PainWord:忍耐>。此卡暴击率提高 20%。"
  },
  Skill_4144_EffectNameList = {Text = "伤害"},
  Skill_4144_Name = {
    Text = "报偿打击"
  },
  Skill_4144_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4144_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2."
  },
  Skill_4144_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标 [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2，打出后移除<PainWord:忍耐>。此卡暴击率提高 20%。"
  },
  Skill_4144_tempBattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 2，打出后移除一半<PainWord:忍耐>。此卡暴击率提高 20%。"
  },
  Skill_4144_tempBattleDesc_4 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，触发目标  [Arg3]％ 的<IntoxicationIconKeywords:中毒>效果，若造成暴击触发比例提高至  [Arg4]％。视为「打击」。每有 1 层<PainWord:忍耐>就使伤害提高 [Float:Arg6] ，打出后移除一半<PainWord:忍耐>。此卡暴击率提高 20%。"
  },
  Skill_4145_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4146_Desc = {
    Text = "对自身造成 [Arg1] 点<FixedDamage:纯粹伤害>，获得 [Arg2] 点临时<PowerIconKeywords:力量>，抽 1 张牌。"
  },
  Skill_4146_Name = {
    Text = "未被满足之痛"
  },
  Skill_4147_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg2]> 伤害 [Arg1] 次。"
  },
  Skill_4147_EffectNameList = {
    Text = "「鼠群冲击」伤害"
  },
  Skill_4147_Name = {
    Text = "鼠群冲击"
  },
  Skill_4147_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4148_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4149_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾，前进。"
  },
  Skill_4150_Desc = {
    Text = "获得 [Arg1] 护盾，护盾消失时，剩余护盾转化为2倍生命值。"
  },
  Skill_4150_Name = {
    Text = "不灭之花"
  },
  Skill_4151_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_4152_AwakerSkillBackgroundStory = {
    Text = "血流满地也好，尸横遍野也好，承受穿心之痛也好。\n为了使神的国土再临于世，这都是微不足道的牺牲。\n她只恨自己不是那被选中之人，不是那个被囚于牢笼中的少女。"
  },
  Skill_4152_Desc_0 = {
    Text = "选择 1 名其他唤醒体，使其获得 <Energy:[Energy:Arg2]> 点狂气。<O07CardKeyWord:祭仪>：获得狂气提高 [Arg4]/[Arg5]/[Arg6] 点。"
  },
  Skill_4152_Desc_2 = {
    Text = "选择 1 名其他唤醒体，使其获得 <Energy:[Energy:Arg2]> 点狂气，界域精通+[Arg3]。<O07CardKeyWord:祭仪>：获得狂气提高 [Arg4]/[Arg5]/[Arg6] 点。"
  },
  Skill_4152_EffectNameList = {Text = "狂气"},
  Skill_4152_Name = {
    Text = "应选之人"
  },
  Skill_4152_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4154_AwakerSkillBackgroundStory = {
    Text = "听啊，那是为自己奏响的丧钟之声。\n并非疯狂的求索者，并非无措的迷失者，她只是静静地抉择了自己的末路。\n凋零的花瓣为她的祭仪献舞，狂乱的海风为她的葬歌哀哭。\n在那震彻心扉的钟声后，世界短暂陷入死一般的寂静。"
  },
  Skill_4154_Desc_0 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>，施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4154_Desc_1 = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>，施加[Arg2] 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4154_EffectNameList_0 = {Text = "中毒"},
  Skill_4154_EffectNameList_1 = {
    Text = "中毒,护盾"
  },
  Skill_4154_Name = {
    Text = "丧钟遥鸣"
  },
  Skill_4154_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4154_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4155_AwakerSkillBackgroundStory = {
    Text = "来自万古，发乎愚昧，源于恐惧。\n奔涌在泰旖丝血管中的，是一种原始的本能。\n在难以回首的献祭中，彼时尚为年幼的泰旖丝被植入了这种本能。\n意志、情绪、乃至人格都被不属于她的存在取代——\n她留下的，唯有这生命间共通的，恐惧死亡的本能。"
  },
  Skill_4155_BattleDesc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，获得 <Posse:[Arg2]> 点银钥能量。选择：<B01AFKeyWord1:恐惧之血>、<B01AFKeyWord2:溃烂之血>、<B01AFKeyWord3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_BattleDesc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，获得 <Posse:[Arg2]> 点银钥能量。选择：<B01AFKeyWordQ1:恐惧之血>、<B01AFKeyWordQ2:溃烂之血>、<B01AFKeyWordQ3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，获得等同于 2 倍泰旖丝银钥充能的银钥能量。选择：<B01AFKeyWord1:恐惧之血>、<B01AFKeyWord2:溃烂之血>、<B01AFKeyWord3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_Desc_1 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]，获得等同于 2 倍泰旖丝银钥充能的银钥能量。选择：<B01AFKeyWordQ1:恐惧之血>、<B01AFKeyWordQ2:溃烂之血>、<B01AFKeyWordQ3:生殖之血><DerivativeCardKeywords_149:><DerivativeCardKeywords_150:><DerivativeCardKeywords_151:>"
  },
  Skill_4155_EffectNameList = {
    Text = "胚胎融合"
  },
  Skill_4155_Name = {
    Text = "圣血的本能"
  },
  Skill_4155_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4156_AwakerSkillBackgroundStory = {
    Text = "还在担任陪读女眷时，奥尔拉便喜欢躲在书斋的一角阅读诗集。那些哀恸的诗句，总能让她动容。"
  },
  Skill_4156_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。视为「防御」。<TransitionIconKeywords:跃迁>：切换至情绪「哀」。"
  },
  Skill_4156_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<WeaknessIconKeywords:虚弱>全体敌方 1 回合。视为「防御」。<TransitionIconKeywords:跃迁>：切换至情绪「哀」。"
  },
  Skill_4156_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥尔拉获得 <Energy:[Energy:Arg2]> 点狂气。视为「防御」。<TransitionIconKeywords:跃迁>：切换至情绪「哀」。每消耗 1 层隐喻「哀」，回复 <Heal:[Heal:Arg3]> 点生命。"
  },
  Skill_4156_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥尔拉获得 <Energy:[Energy:Arg2]> 点狂气。<WeaknessIconKeywords:虚弱>全体敌方 1 回合。视为「防御」。<TransitionIconKeywords:跃迁>：切换至情绪「哀」。每消耗 1 层隐喻「哀」，回复 <Heal:[Heal:Arg3]> 点生命。"
  },
  Skill_4156_EffectNameList = {
    Text = "护盾,狂气,回复生命"
  },
  Skill_4156_Name = {
    Text = "哀恸诗篇"
  },
  Skill_4156_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,体质*GrowValue3"
  },
  Skill_4157_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4158_Desc = {
    Text = "若此卡位于手牌，所有唤醒体暴击率提高 25%。回合结束时，将 1 张随机「症状卡」加入抽牌堆中。"
  },
  Skill_4158_Name = {
    Text = "症状：盲从"
  },
  Skill_4160_AwakerSkillBackgroundStory = {
    Text = "在贝桑松的侍女眼里，她的小姐有些特别。\n她不喜读诗，也从不弹琴。\n她迷恋逝去之物。她会出神地盯着一片枯萎的落叶......然后一跃而起，跑回房间——砰！砰！砰！\n「喏，咱们的小小艺术家！」侍女哀叹，「和泥瓦匠有什么区别？」"
  },
  Skill_4160_Desc_0 = {
    Text = "下个回合开始时，驱散自身<FragileIconKeywords:脆弱>状态，获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4160_Desc_1 = {
    Text = "获得 <Block:[Block:Arg2]> 点护盾。下个回合开始时，驱散自身<FragileIconKeywords:脆弱>状态，获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4160_EffectNameList_0 = {
    Text = "延迟护盾"
  },
  Skill_4160_EffectNameList_1 = {
    Text = "延迟护盾,护盾"
  },
  Skill_4160_Name = {
    Text = "封闭创作"
  },
  Skill_4160_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4160_PropertyNameList_1 = {
    Text = "防御力*GrowValue1,防御力*GrowValue2,"
  },
  Skill_4161_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4161_Name = {Text = "毒素"},
  Skill_4162_Desc = {
    Text = "石化中，无法行动。"
  },
  Skill_4162_Name = {Text = "石化"},
  Skill_4163_AwakerSkillBackgroundStory = {
    Text = "将这刻骨的仇恨与病态的黏液凝结成尖刺，用绝对凌厉的一击斩断敌人的颈项。"
  },
  Skill_4163_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4163_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气和 10% 暴击伤害。"
  },
  Skill_4163_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。希洛获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4163_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。希洛获得 <Energy:[Energy:Arg2]> 点狂气和 10% 暴击伤害。"
  },
  Skill_4163_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4163_Name = {Text = "打击"},
  Skill_4163_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4164_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4165_AwakerSkillBackgroundStory = {
    Text = "「攻击指令执行完毕，请下达下一个指令。」"
  },
  Skill_4165_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4165_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。艾瑞卡获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4165_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4165_Name = {Text = "打击"},
  Skill_4165_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4166_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！"
  },
  Skill_4166_Name = {
    Text = "破链一击"
  },
  Skill_4167_AwakerSkillBackgroundStory = {
    Text = "筹办沙龙不是件简单的事。酒水的挑选，食谱的选择，乃至侍者的甄选都需要亲力亲为。\n幸运的是，索蕾尔从她的簇拥者手中获取了足够的自由与特权。"
  },
  Skill_4167_Desc_0 = {
    Text = "索蕾尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>，索蕾尔每造成 1 次伤害，获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4167_Desc_15 = {
    Text = "索蕾尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>，索蕾尔每造成 1 次伤害，获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>并使索蕾尔临时最终伤害提高 2％，其他唤醒体提高 1％，临时最终伤害提高效果每回合最多生效 [Arg4] 次。"
  },
  Skill_4167_EffectNameList = {
    Text = "狂气,力量,临时力量"
  },
  Skill_4167_Name = {
    Text = "迎客特权"
  },
  Skill_4167_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4168_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次和施加等量伤害的<BleedingIconKeywords:出血>，受到 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4168_Name = {
    Text = "巨刃之威-血"
  },
  Skill_4169_AwakerSkillBackgroundStory = {
    Text = "好吃的东西就要吃，好用的力量就要用。\n少女祈祷着，激发了体内蕴藏的力量。"
  },
  Skill_4169_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4169_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]。"
  },
  Skill_4169_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。墨菲获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4169_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。墨菲获得 <Energy:[Energy:Arg2]> 点狂气。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]。"
  },
  Skill_4169_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4169_EffectNameList_2 = {
    Text = "护盾,狂气,触腕伤害"
  },
  Skill_4169_Name = {Text = "防御"},
  Skill_4169_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4169_PropertyNameList_2 = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4170_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次，该伤害受到 2 倍<PowerIconKeywords:力量>加成。造成 [Arg2] 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4170_Name = {
    Text = "巨刃之威-终"
  },
  Skill_4171_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg4] 次。该伤害受到 2 倍<PowerIconKeywords:力量>加成。自身获得 [Arg2] 层<PowerIconKeywords:力量>，移除敌人一半的<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>状态。"
  },
  Skill_4171_Name = {
    Text = "巨刃之威-力"
  },
  Skill_4172_AwakerSkillBackgroundStory = {
    Text = "「她连一只蚂蚁都不愿意伤害。」\n「那就掐死她，让另一个‘她’来。」"
  },
  Skill_4172_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4172_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。「24」获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4172_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4172_Name = {Text = "打击"},
  Skill_4172_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4173_Desc = {
    Text = "眩晕中，无法行动。"
  },
  Skill_4173_Name = {Text = "眩晕"},
  Skill_4174_Desc = {
    Text = "在自身前后各召唤一个「提灯」。"
  },
  Skill_4174_Name = {
    Text = "圣礼仪式"
  },
  Skill_4175_AwakerSkillBackgroundStory = {
    Text = "很难说是别称为「街头老鼠」的孩子们接纳了老鼠，还是真正的老鼠接纳了街童，这段因生计所迫而诞生的情谊，却在多年的相处下变得坚不可破。\n谁能说动物不是人类最好的朋友呢？"
  },
  Skill_4175_Desc = {
    Text = " 少女显然并不具备任何特殊能力。"
  },
  Skill_4175_EffectNameList = {Text = "力量"},
  Skill_4175_Name = {Text = "无"},
  Skill_4175_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4176_AwakerSkillBackgroundStory = {
    Text = "「嘿——咻！」"
  },
  Skill_4176_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4176_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥吉尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4176_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4176_Name = {Text = "防御"},
  Skill_4176_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4177_AwakerSkillBackgroundStory = {
    Text = "不要害怕那两排时隐时现的三角形利齿，也不要担心进去后就再没出来的白兔女士——礼帽先生是由卡茜亚大师亲自训练出来的专业魔法道具，可从来不会随随便便咬人。"
  },
  Skill_4177_Desc_0 = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。弃掉手中的症状和状态卡，将其他手牌洗入抽牌堆，抽取等同于弃掉和洗入数量的牌。<TransitionIconKeywords:跃迁>：返还「统统消失！」的算力消耗。"
  },
  Skill_4177_Desc_1 = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。弃掉手中的症状和状态卡，将其他手牌洗入抽牌堆，抽取等同于弃掉和洗入数量的牌，每抽 1 张牌获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：返还「统统消失！」的算力消耗。"
  },
  Skill_4177_EffectNameList = {Text = "狂气"},
  Skill_4177_Name = {
    Text = "统统消失！"
  },
  Skill_4177_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4178_AwakerSkillBackgroundStory = {
    Text = "「最适合我的，自然是能越过国王、左右朝政的权力。」"
  },
  Skill_4178_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4178_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若当前生命低于 50%([Arg4])，额外造成 1 次伤害，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4178_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。索蕾尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4178_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若当前生命低于 50%，额外造成 1 次伤害，<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg3]。索蕾尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4178_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4178_Name = {Text = "打击"},
  Skill_4178_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4181_Desc = {
    Text = "自身获得 [Arg1] 层<RetaliateIconKeywords:反击>"
  },
  Skill_4181_Name = {Text = "施与受"},
  Skill_4182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4182_Name = {Text = "毒素"},
  Skill_4183_Desc = {
    Text = "「24」 获得 <Energy:[Energy:Arg1]> 点狂气。苍白、脆弱、却无比坚定。"
  },
  Skill_4183_Name = {
    Text = "救救她！"
  },
  Skill_4184_BattleDesc = {
    Text = "打出时获得 [Arg1] 层临时<PowerIconKeywords:力量>。抽到时降低  [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4184_Desc = {
    Text = "打出时获得 [Arg1] 层临时<PowerIconKeywords:力量>。抽到时降低  [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4184_Name = {
    Text = "症状：休克"
  },
  Skill_4185_Desc = {
    Text = "所有敌人<PowerIconKeywords:力量>临时降低 [Arg1] 点， 1 回合内获得的护盾和<PowerIconKeywords:力量>降低 50%。"
  },
  Skill_4185_EffectNameList = {
    Text = "力量减低"
  },
  Skill_4185_Name = {Text = "诅咒"},
  Skill_4185_PropertyNameList = {
    Text = "攻击力*GrowValue"
  },
  Skill_4186_Desc = {
    Text = "全体友方获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_4186_Name = {
    Text = "全体护盾"
  },
  Skill_4187_Desc = {
    Text = "施加 [Arg1] 层空虚。"
  },
  Skill_4187_Name = {
    Text = "狂气吸收"
  },
  Skill_4188_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4188_Name = {Text = "撕咬"},
  Skill_4189_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。将 [Arg2] 张<DerivativeCardKeywords_3:「惊厥」>洗入抽牌堆。"
  },
  Skill_4190_Desc = {
    Text = "回复 [Arg1] 点生命，使所有敌人降低 [Arg1] 点力量。抽到时所有唤醒体失去 <Energy:10> 狂气。"
  },
  Skill_4190_Name = {
    Text = "巨人之畏"
  },
  Skill_4191_Desc = {
    Text = "使所有唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4191_Name = {
    Text = "混沌充能"
  },
  Skill_4192_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4192_Name = {
    Text = "自我的葬仪"
  },
  Skill_4193_AwakerSkillBackgroundStory = {
    Text = "「触手，数不清的触手从地下拽着我……\n医生，我是不是得了癔症……」\n女子无助地哭着，她害怕极了。在她对面坐着一位戴眼镜的长发医生。\n「不，这不是什么癔症。」\n医生笑起来，双眼如蛇般狭长。\n「这是真实……有关这个世界的，扭曲的真实。」"
  },
  Skill_4193_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，使「扭曲的死体狂宴」基础伤害在本场战斗中提高 20%，"
  },
  Skill_4193_EffectNameList_0 = {
    Text = "伤害,银钥能量,混沌躁狂伤害提高,触腕伤害,触腕伤害加成百分比,胚胎融合,猩红熔炉回复量,力量,失去临时力量,超维躁狂伤害提高,超维躁狂伤害上限"
  },
  Skill_4193_Name = {
    Text = "扭曲的死体狂宴"
  },
  Skill_4193_OverLimitUtlSkillDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，使「扭曲的死体狂宴」基础伤害在本场战斗中提高 20%，获得 24 点界域精通，「24」的下一张指令卡生效 3 次。"
  },
  Skill_4193_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,攻击力*GrowValue3,攻击力*GrowValue4,$GrowValue5,$GrowValue6,体质*GrowValue7,攻击力*GrowValue8,防御力*GrowValue9,攻击力*GrowValue10"
  },
  Skill_4194_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4194_Name = {Text = "噬咬"},
  Skill_4195_AwakerSkillBackgroundStory = {
    Text = "成为唤醒体后，奥吉尔与无定形的黑色物质形成了稳定的共生关系。\n目睹过融蚀惨相的人，往往会对奥吉尔的出现而感到高度紧张。\n只有与他共同作战过的人才知道，那无形之物能凝结成何等坚实的壁垒。"
  },
  Skill_4195_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 X+1 次，每消耗 1 点算力，获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4195_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 X+1 次。每消耗 1 点算力，获得 <Energy:[Energy:Arg3]> 点狂气。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4195_EffectNameList_0 = {Text = "护盾"},
  Skill_4195_EffectNameList_3 = {
    Text = "护盾,力量"
  },
  Skill_4195_Name = {
    Text = "不定壁垒"
  },
  Skill_4195_PropertyNameList_0 = {
    Text = "防御力*GrowValue1"
  },
  Skill_4195_PropertyNameList_3 = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4196_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4196_Name = {
    Text = "扭曲的死体狂宴"
  },
  Skill_4197_AwakerSkillBackgroundStory = {
    Text = "「升起你的船锚，我们是时候远航。」"
  },
  Skill_4197_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。 激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4197_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。希莱斯特获得 <Energy:[Energy:Arg2]> 点狂气。 激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4197_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4197_Name = {Text = "打击"},
  Skill_4197_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4198_AwakerSkillBackgroundStory = {
    Text = "诺缔拉的人生信条：没有什么是焊接补不好的，如果有，那就多焊几次。\n虽然很多时候，她重复焊接的原因并非如此。"
  },
  Skill_4198_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4198_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。诺缔拉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4198_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4198_Name = {Text = "防御"},
  Skill_4198_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4199_Desc = {
    Text = "向随机唤醒体施加 1 层临时封印，重复 2 次。"
  },
  Skill_4199_Name = {Text = "封印"},
  Skill_4200_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4201_Desc = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>，将四张枷锁塞入玩家手牌。"
  },
  Skill_4201_Name = {
    Text = "复仇宣言"
  },
  Skill_4202_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4203_AwakerSkillBackgroundStory = {
    Text = "「呼呼！有没有吓你一跳！」"
  },
  Skill_4203_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4203_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4203_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4203_Name = {Text = "打击"},
  Skill_4203_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4203_tempBattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4203_tempBattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 4 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4204_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4205_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4205_Name = {Text = "狂怒"},
  Skill_4206_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，抽牌堆和弃牌堆的所有卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4206_Name = {
    Text = "真·万古之眸"
  },
  Skill_4207_Desc = {
    Text = "全体获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4208_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 3 张<DerivativeCardKeywords_36:「亵渎假象」>加入手中。"
  },
  Skill_4208_Name = {
    Text = "异维瞪视"
  },
  Skill_4209_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次并附加等量出血。后撤。"
  },
  Skill_4209_Name = {
    Text = "撕裂打击"
  },
  Skill_4210_Desc = {
    Text = "召唤两个「对不起」，赋予他们 1 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_4210_Name = {
    Text = "愧意之海"
  },
  Skill_4211_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4212_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_26:症状：「妄想」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4212_Name = {Text = "哭喊"},
  Skill_4213_Desc = {
    Text = "对敌人施加 1 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4213_Name = {Text = "尖木头"},
  Skill_4214_AwakerSkillBackgroundStory = {
    Text = "诺缔拉的工作区铁贴满了大大小小的便条。这是茜尔维娅女士交给她的方法，能够帮助她记住那些那些重要的事情。\n但就像那本只写了一面的日记一样，这些便条上也只有一模一样的一串字：不要忘记。\n有的记忆，在落笔的那一刻就已经悄悄溜走了。"
  },
  Skill_4214_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。选择 1 名其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4214_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4214_Name = {
    Text = "短期记忆"
  },
  Skill_4214_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4215_Desc = {
    Text = "回合结束时若在手中，获得 [Arg1] 层<IntoxicationIconKeywords:中毒>。“ 与我一同沉溺吧！”"
  },
  Skill_4215_Name = {Text = "窒息"},
  Skill_4216_Desc = {
    Text = "获得 [Arg1] 层临时<ParcloseIconKeywords:屏障>。"
  },
  Skill_4216_Name = {
    Text = "蜂蜜甜酒"
  },
  Skill_4217_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4217_Name = {Text = "展翼"},
  Skill_4218_Desc = {
    Text = "获得 [Arg2] 点护盾和状态「放血」: 每造成一次未被格挡的伤害，附加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4218_Name = {
    Text = "航海料理"
  },
  Skill_4219_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4220_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4222_BattleDesc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，额外获得等同于永久力量 25%([Arg2]) 的临时<PowerIconKeywords:力量>。"
  },
  Skill_4222_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，额外获得等同于永久力量 25% 的临时<PowerIconKeywords:力量>。"
  },
  Skill_4222_Name = {
    Text = "永世执念"
  },
  Skill_4223_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg4] 次，赋予  [Arg2] 张卡牌「深潜印记」：打出后敌人获得临时<PowerIconKeywords:力量>。"
  },
  Skill_4223_Name = {
    Text = "猎物标记"
  },
  Skill_4224_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4224_Name = {
    Text = "混沌之兽"
  },
  Skill_4225_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4226_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害失去一层，回合结束失去全部。"
  },
  Skill_4226_Name = {Text = "祈祷"},
  Skill_4227_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，提高后续「连续撕咬」的攻击次数。"
  },
  Skill_4227_Name = {
    Text = "连续撕咬"
  },
  Skill_4228_Desc = {
    Text = "每回合获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4228_Name = {
    Text = "复仇预行"
  },
  Skill_4229_AwakerSkillBackgroundStory = {
    Text = "非利士的领袖是个强大的勇士，他手持巨刃，仅需一挥便可将敌人击倒。\n非利士的领袖是个残酷的暴君，他残忍自私，为了达成目的，可以牺牲所有族人。\n非利士的前领袖是欲望的奴隶，他渴望力量，并终究为力量所困。"
  },
  Skill_4229_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若目标生命低于 25%([Arg3])或击杀了目标，则返还算力消耗。<PowerIconKeywords:力量>在「斩首重创」上发挥 [Arg2] 倍效果。"
  },
  Skill_4229_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若目标生命低于 25%([Arg3])或击杀了目标，则返还算力消耗。<PowerIconKeywords:力量>在「斩首重创」上发挥 [Arg2] 倍效果，每有 1 条触腕，力量额外发挥 1 倍效果。"
  },
  Skill_4229_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若目标生命低于 25%或击杀了目标，则返还算力消耗。<PowerIconKeywords:力量>在「斩首重创」上发挥 [Arg2] 倍效果。"
  },
  Skill_4229_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若目标生命低于 25%或击杀了目标，则返还算力消耗。<PowerIconKeywords:力量>在「斩首重创」上发挥 [Arg2] 倍效果，每有 1 条触腕，力量额外发挥 1 倍效果。"
  },
  Skill_4229_EffectNameList = {Text = "伤害"},
  Skill_4229_Name = {
    Text = "斩首重创"
  },
  Skill_4229_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4230_Desc = {
    Text = "选择一名唤醒体，获得 50 点狂气。"
  },
  Skill_4230_Name = {
    Text = "遗影回响"
  },
  Skill_4231_AwakerSkillBackgroundStory = {
    Text = "「看！奥瑞塔像鱼一样吐泡泡！」"
  },
  Skill_4231_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4231_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4231_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4231_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 1 张牌。奥瑞塔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4231_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4231_Name = {Text = "防御"},
  Skill_4231_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4232_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4232_Name = {
    Text = "扭曲的死体狂宴"
  },
  Skill_4233_AwakerSkillBackgroundStory = {
    Text = "温柔的海水送去垂朽的花瓣，绽放的水波如睡莲开合。\n若你掉以轻心，便会被那平静的外表欺骗。静谧月色下的沙沙潮水，实际暗含着吞没万物的力量。\n如同她的爱憎，从未形于色，却在汹涌波涛中激烈回荡。"
  },
  Skill_4233_Desc_0 = {
    Text = "对生命最高的敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加等量<IntoxicationIconKeywords:中毒>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4233_Desc_2 = {
    Text = "对生命最高的敌人造成 <Damage:[Damage:Arg1]> 点伤害并施加等量<IntoxicationIconKeywords:中毒>，享受 2 倍<PowerIconKeywords:力量>加成。每回合打出的前 3 张症状卡，使「夜潮汹涌」在本场战斗中造成的伤害提高 [Arg2] 点。"
  },
  Skill_4233_EffectNameList = {Text = "伤害"},
  Skill_4233_Name = {
    Text = "夜潮汹涌"
  },
  Skill_4233_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4234_AwakerSkillBackgroundStory = {
    Text = "「我都干了什么？」\n诺缔拉总会在调查结束后这么询问。倒不是出于对所攻击的融蚀体的愧疚——她只是真的忘了。"
  },
  Skill_4234_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4234_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4234_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。诺缔拉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4234_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。诺缔拉获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4234_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4234_EffectNameList_1 = {
    Text = "伤害,狂气,反击"
  },
  Skill_4234_Name = {Text = "打击"},
  Skill_4234_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4234_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4235_Desc = {
    Text = "造成 [Arg1] 层<WeaknessIconKeywords:虚弱>，获得「鼠群之怒」：下回合每受到 1 攻击会获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4235_Name = {
    Text = "集结鼠群"
  },
  Skill_4238_AwakerSkillBackgroundStory = {
    Text = "若是从前那个顺应命运的他，恐怕不会支起这道防御。"
  },
  Skill_4238_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4238_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [TentaclePower:Arg3] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg3] 点临时<PowerIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4238_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。图鲁获得 <Energy:[Energy:Arg2]> 点狂气。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4238_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。图鲁获得 <Energy:[Energy:Arg2]> 点狂气。获得 [TentaclePower:Arg3] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg3] 点临时<PowerIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4238_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4238_EffectNameList_2 = {
    Text = "护盾,狂气,临时触腕伤害,临时力量"
  },
  Skill_4238_Name = {Text = "防御"},
  Skill_4238_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4238_PropertyNameList_2 = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3,攻击力*GrowValue3"
  },
  Skill_4239_AwakerSkillBackgroundStory = {
    Text = "在神明治下的国土，人民无疑是爱着这位大主祭的。\n所有人都能看见她的虔诚，她的勤勉，她的牺牲。\n是以，不少人偷偷将她与母神划上了等号——当然，这件事只能私下聊聊，千万不能让弥利亚姆知道。"
  },
  Skill_4239_Desc_0 = {
    Text = "将 [Arg4] 张<O07CardKeyWord2:「圣礼」>置入手中，对所有敌人施加 [Poison:Arg5] 点<IntoxicationIconKeywords:中毒>。根据触腕姿态获得效果：潮涌：获得 [Power:Arg1] 点<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>；静海：其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气；怒涛：触发所有敌人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_Desc_3 = {
    Text = "将 [Arg4] 张<O07CardKeyWord2:「圣礼」>置入手中，对所有敌人施加 [Poison:Arg5] 点<IntoxicationIconKeywords:中毒>。根据触腕姿态获得效果：潮涌：获得 [Power:Arg1] 点<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>；静海：其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气；怒涛：触发所有敌人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_EffectNameList = {
    Text = "力量和触腕伤害,狂气,触发中毒比例,中毒"
  },
  Skill_4239_Name = {
    Text = "向深渊祝祷"
  },
  Skill_4239_OverLimitUtlSkillDesc = {
    Text = "将 [Arg6] 张<O07CardKeyWord2:「圣礼」>置入手中，对所有敌人施加 [Poison:Arg5] 点<IntoxicationIconKeywords:中毒>。触腕上限和触腕数量 +1。根据触腕姿态获得效果：潮涌：获得 [Power:Arg1] 点<PowerIconKeywords:力量> 和 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>；静海：其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气；怒涛：触发所有敌人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果。"
  },
  Skill_4239_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3,攻击力*GrowValue4"
  },
  Skill_4240_AwakerSkillBackgroundStory = {
    Text = "看看这美丽的托盘，难道不是正适合美丽可爱的她吗？"
  },
  Skill_4240_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4240_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。珈伦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4240_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4240_Name = {Text = "防御"},
  Skill_4240_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4241_AwakerSkillBackgroundStory = {
    Text = "多数人首次听到美声歌手练声时，都会感到惊诧。\n那娇巧纤弱的躯体，竟然能爆发出这样洪亮的声音和能量。\n绵音渐响，声贯寰宇。"
  },
  Skill_4241_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，在下回合中暴击率 +[Arg2]% 。<TransitionIconKeywords:跃迁>：改为获得 <Block:[Block:Arg3]> 点护盾，在下个回合中暴击率 +[Arg4]%。"
  },
  Skill_4241_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，在下回合中暴击率和暴击伤害 +[Arg2]% 。<TransitionIconKeywords:跃迁>：改为获得 <Block:[Block:Arg3]> 点护盾，在下回合中暴击率和暴击伤害 +[Arg4]% 。"
  },
  Skill_4241_EffectNameList = {
    Text = "护盾,跃迁护盾"
  },
  Skill_4241_Name = {
    Text = "绵音渐响"
  },
  Skill_4241_PropertyNameList = {
    Text = "防御力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4242_Desc = {
    Text = "造成<Block:[Block:Arg1]>护盾，获得[Arg2]<RetaliateIconKeywords:反击>。"
  },
  Skill_4242_Name = {Text = "警戒"},
  Skill_4243_AwakerSkillBackgroundStory = {
    Text = "笔墨是她的武器，却如玫瑰的刺，总是刺伤自己。"
  },
  Skill_4243_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg3]> 点狂气。视为「打击」。<TransitionIconKeywords:跃迁>：切换至情绪「怒」。"
  },
  Skill_4243_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg3]> 点狂气。<VulnerabilityIconKeywords:易伤>全体敌方 1 回合。视为「打击」。<TransitionIconKeywords:跃迁>：切换至情绪「怒」。"
  },
  Skill_4243_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥尔拉获得 <Energy:[Energy:Arg3]> 点狂气。视为「打击」。<TransitionIconKeywords:跃迁>：切换至情绪「怒」。每消耗 1 层隐喻「怒」，额外造成 2 次伤害。"
  },
  Skill_4243_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥尔拉获得 <Energy:[Energy:Arg3]> 点狂气。<VulnerabilityIconKeywords:易伤>全体敌方 1 回合。视为「打击」。<TransitionIconKeywords:跃迁>：切换至情绪「怒」。每消耗 1 层隐喻「怒」，额外造成 2 次伤害。"
  },
  Skill_4243_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4243_Name = {
    Text = "狂想诗篇"
  },
  Skill_4243_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4244_AwakerSkillBackgroundStory = {
    Text = "过于频繁的胜利让莱克与那些纸醉金迷场所背后的上流角色结下了未曾谋面的仇恨。\n他曾当街遇袭，子弹却精准命中了胸口钱夹里的银币。"
  },
  Skill_4244_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4244_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。若算力不足时可消耗 3 点黑印打出并生效 2 次。（当前黑印：[Arg3]）"
  },
  Skill_4244_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莱克获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4244_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。莱克获得 <Energy:[Energy:Arg2]> 点狂气。若算力不足时可消耗 3 点黑印打出并生效 2 次。"
  },
  Skill_4244_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4244_Name = {Text = "防御"},
  Skill_4244_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4245_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。后撤。"
  },
  Skill_4246_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4247_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4247_Name = {Text = "撕咬"},
  Skill_4248_Desc = {
    Text = "打出后受到 [Arg1] 点<FixedDamage:纯粹伤害>，抽 2 张牌，将其<DepleteIconKeywords:消耗>。回合结束时若在手中，受到 [Arg2] 点伤害。"
  },
  Skill_4248_Name = {
    Text = "亵渎假象"
  },
  Skill_4249_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4249_Name = {
    Text = "混沌之兽"
  },
  Skill_4250_AwakerSkillBackgroundStory = {
    Text = "年幼的王者无时无刻不倾听着神明的呓语，让他难以从梦境中脱身。\n即便如此，清醒时留下的只言片语也足以治理国家。\n无论他再如何消极地回避，被人民赋予的威仪也成了他的权柄。"
  },
  Skill_4250_Desc_0 = {
    Text = "图鲁获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕数量上限 +1，图鲁每消耗 1 点算力或弃掉 1 张图鲁的指令卡，获得 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点 <PowerIconKeywords:力量>。"
  },
  Skill_4250_Desc_15 = {
    Text = "图鲁获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕数量上限 +1，图鲁每消耗 1 点算力或弃掉 1 张图鲁的指令卡，获得 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点 <PowerIconKeywords:力量>。图鲁释放狂气爆发后，所有敌人受到的触腕伤害提高 [Arg3]％，最多叠加 [Arg4] 次。"
  },
  Skill_4250_EffectNameList = {
    Text = "狂气,触腕伤害,力量"
  },
  Skill_4250_Name = {
    Text = "不朽威仪"
  },
  Skill_4250_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,攻击力*GrowValue2"
  },
  Skill_4251_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得[Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4253_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4254_Desc = {
    Text = "获得4层祈祷，牺牲其他友方，每牺牲一个教众额外获得 [Arg1] 层祈祷。"
  },
  Skill_4254_Name = {
    Text = "灯芯长明"
  },
  Skill_4255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4255_Name = {Text = "刺击"},
  Skill_4257_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4257_Name = {Text = "践踏"},
  Skill_4258_Desc = {
    Text = "造成[Arg2] 层<IntoxicationIconKeywords:中毒>和 1 回合溶解。打出的牌被消耗，指令卡产生 3 倍伤害和护盾。获得 3 点算力，抽 3 张牌。"
  },
  Skill_4258_Name = {
    Text = "恨意吞噬"
  },
  Skill_4259_Desc = {
    Text = "造成 [Arg1] 层<IntoxicationIconKeywords:中毒>，对抽牌堆和弃牌堆中随机 [Arg2] 张卡牌施加「<SlowIconKeywords:迟缓>」"
  },
  Skill_4259_Name = {
    Text = "迟缓迷毒"
  },
  Skill_4260_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4261_Desc = {
    Text = "消耗全部祈祷，每消耗2层祈祷在后排召唤一个提灯教众小。"
  },
  Skill_4261_Name = {
    Text = "圣礼仪式"
  },
  Skill_4263_Desc = {
    Text = "获得[Arg1]点<PowerIconKeywords:力量>，施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4264_AwakerSkillBackgroundStory = {
    Text = "滑稽的小丑身上扎满飞刀，倒吊的空中飞人失手坠落——放轻松，亲爱的观众们，表演的序幕才刚刚拉开。"
  },
  Skill_4264_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4264_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。卡茜亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4264_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4264_Name = {Text = "防御"},
  Skill_4264_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4265_Desc = {
    Text = "不能倒下，大家还在等我。受到致命伤害时，回复 1 点生命。"
  },
  Skill_4265_Name = {
    Text = "蜡像馆钥匙"
  },
  Skill_4266_Desc = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_80:「窒息」>置入对方手牌。"
  },
  Skill_4266_Name = {
    Text = "溺毙之怨"
  },
  Skill_4268_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4269_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_3:「惊厥」>洗入对方抽牌堆。"
  },
  Skill_4270_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4270_Name = {
    Text = "破链一击"
  },
  Skill_4271_Desc = {
    Text = "造成的伤害为<PunctureDamagewords:穿刺伤害>。使手中算力最高的 1 张牌算力消耗降低 1。"
  },
  Skill_4271_Name = {Text = "穿刺"},
  Skill_4272_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4273_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_3:「惊厥」>洗入抽牌堆。"
  },
  Skill_4274_Desc = {
    Text = "造成<Block:[Block:Arg1]>护盾，获得 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4274_Name = {Text = "警戒"},
  Skill_4275_AwakerSkillBackgroundStory = {
    Text = "「街头打斗可没那么多讲究，当然是什么趁手用什么了。」"
  },
  Skill_4275_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4275_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。詹金获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4275_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4275_Name = {Text = "打击"},
  Skill_4275_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4277_AwakerSkillBackgroundStory = {
    Text = "无中生有并非科学的领域。\n朵尔一直是如此相信的，宇宙、人类、乃至融蚀现象，万物皆有起源，事事皆需代价。\n「所以关于点石成金技术的研发，朵尔小姐您看……」\n「研发成功的可能性和你毕业论文的含金量一样，都是零。」"
  },
  Skill_4277_BattleDesc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命并弃掉所有手牌。"
  },
  Skill_4277_BattleDesc_2 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。弃掉所有手牌，每弃 1 张手牌获得 <Block:[Heal:Arg2]> 点护盾。"
  },
  Skill_4277_Desc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。弃掉所有手牌，每弃 1 张手牌额外回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4277_Desc_2 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。弃掉所有手牌，每弃 1 张手牌额外回复 <Heal:[Heal:Arg2]> 点生命并获得等量护盾。"
  },
  Skill_4277_EffectNameList = {
    Text = "回复,回复提高"
  },
  Skill_4277_Name = {
    Text = "等价交换"
  },
  Skill_4277_PropertyNameList = {
    Text = "体质*GrowValue1,体质*GrowValue2"
  },
  Skill_4278_AwakerSkillBackgroundStory = {
    Text = "温热的血液从他的面颊滚落，他咧开嘴，露出一排锋利如刃的獠牙。\n弱肉强食的法则是世界的根本，而他将是永远的狩猎者。\n他踏着遍地的尸骸，发出胜利的咆哮。"
  },
  Skill_4278_Desc_0 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。临时移除所有敌人的<PowerIconKeywords:力量>。"
  },
  Skill_4278_Desc_2 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。临时移除所有敌人的<PowerIconKeywords:力量>，并获得等同于移除量的临时<PowerIconKeywords:力量>。"
  },
  Skill_4278_EffectNameList = {Text = "力量"},
  Skill_4278_Name = {
    Text = "强者为尊"
  },
  Skill_4278_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4281_AwakerSkillBackgroundStory = {
    Text = "她已经不记得，自己是何时成为如此模样的了。\n在不知不觉间，昔日跪在父亲面前悲泣求饶的少女已经死去，穷奢极侈的亡国之花浴其鲜血而生。\n「我最最尊贵的小渡鸦，今日，你又给我衔来了何等璀璨的珠宝呢？」"
  },
  Skill_4281_BattleDesc = {
    Text = "失去 [Arg1]%([Arg4]) 当前生命。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。在本回合中剩余时间内，每造成 1 次伤害，回合结束时回复 [Arg3] 点生命。"
  },
  Skill_4281_Desc = {
    Text = "失去 [Arg1]% 当前生命。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。在本回合中剩余时间内，每造成 1 次伤害，回合结束时回复 [Arg3] 点生命。"
  },
  Skill_4281_EffectNameList = {
    Text = "胚胎融合,回复"
  },
  Skill_4281_Name = {
    Text = "珠玉之卵"
  },
  Skill_4281_PropertyNameList = {
    Text = "$GrowValue1,体质*GrowValue2"
  },
  Skill_4282_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4283_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4283_Name = {
    Text = "桀骜之刃"
  },
  Skill_4284_AwakerSkillBackgroundStory = {
    Text = "她总是告诉新兵们：即使疲惫、即使虚弱，也绝不能放下武器。让它成为你最贴身的伙伴，最坚实的护盾。\n在战场上，唯有足够警惕的能够活命。"
  },
  Skill_4284_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 [Arg2] 次。回合结束时若在手中，下次打出时额外造成 1 次护盾。驱散所有唤醒体<CardKeyWord:封印>状态。"
  },
  Skill_4284_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 [Arg2] 次。回合结束时若在手中，下次打出时额外造成 1 次护盾。驱散所有唤醒体<CardKeyWord:封印>状态。视为「防御」。"
  },
  Skill_4284_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回合结束时若在手中，下次打出时额外造成 1 次护盾。驱散所有唤醒体<CardKeyWord:封印>状态。"
  },
  Skill_4284_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回合结束时若在手中，下次打出时额外造成 1 次护盾。驱散所有唤醒体<CardKeyWord:封印>状态。视为「防御」。"
  },
  Skill_4284_EffectNameList = {Text = "护盾"},
  Skill_4284_Name = {
    Text = "临战体势"
  },
  Skill_4284_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_4285_AwakerSkillBackgroundStory = {
    Text = "他被当做暴力的象征召唤，成为角斗场的明星。\n他被当做暴力的象征唾弃，成为地下室的囚徒。\n当奔涌的血液被铁链死死禁锢，\n历经千年的饥渴啊——\n怒吼着，尖啸着，\n再也无法忍受。"
  },
  Skill_4285_BattleDesc_0 = {
    Text = "失去 [Arg1]%([Arg4]) 当前生命。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4285_Desc_0 = {
    Text = "失去 [Arg1]% 当前生命。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4285_EffectNameList_0 = {
    Text = "伤害,力量"
  },
  Skill_4285_Name = {
    Text = "尖啸吧，血！"
  },
  Skill_4285_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4286_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4287_AwakerSkillBackgroundStory = {
    Text = "角斗士闭上双眼。\n心跳声平缓有力，掩盖远方震耳欲聋的欢呼。\n黑暗之下，名为杀戮的火苗蠢蠢欲动。\n跳动着，沸腾着，直至将无边的黑幕舔舐干净。\n角斗士睁开眼。他终于准备好了。"
  },
  Skill_4287_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 3 次。获得 <Energy:[Energy:Arg2]> 点狂气，生命低于 25%([Arg3]) 时获得的狂气翻倍。"
  },
  Skill_4287_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 3 次。获得 <Energy:[Energy:Arg2]> 点狂气，生命低于 25%([Arg3]) 时额外造成 2 次伤害并获得的狂气翻倍。"
  },
  Skill_4287_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 3 次。尤乌哈希获得 <Energy:[Energy:Arg2]> 点狂气，生命低于 25% 时获得的狂气翻倍。"
  },
  Skill_4287_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 3 次。尤乌哈希获得 <Energy:[Energy:Arg2]> 点狂气，生命低于 25% 时额外造成 2 次伤害并获得的狂气翻倍。"
  },
  Skill_4287_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4287_Name = {
    Text = "沸腾吧，血！"
  },
  Skill_4287_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4288_AwakerSkillBackgroundStory = {
    Text = "「群星行至正位之刻，神国在星辰牵引下浮出水面，重现于世。届时，余亦将重临，如山岭般坐镇天地之间……」"
  },
  Skill_4288_Desc_0 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。"
  },
  Skill_4288_EffectNameList_0 = {
    Text = "临时触腕伤害,临时力量,暴击率"
  },
  Skill_4288_Name = {
    Text = "星辰正位之刻"
  },
  Skill_4288_OverLimitUtlSkillDesc_0 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。回合结束时，号令所有触腕攻击所有敌人 2 次。"
  },
  Skill_4288_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4288_tempBattleDesc_1 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。"
  },
  Skill_4288_tempBattleDesc_2 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。所有敌人受到的触腕伤害提高 10%，最多叠加 5 次。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_1 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。回合结束时，号令所有触腕攻击所有敌人 2 次。"
  },
  Skill_4288_tempOverLimitUtlSkillDesc_2 = {
    Text = "获得 [Arg1] 条触腕。获得 [TentaclePower:Arg2] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg2] 点临时<PowerIconKeywords:力量>。获得 [Arg3]％ 临时暴击率。所有敌人受到的触腕伤害提高 10%，最多叠加 5 次。回合结束时，号令所有触腕攻击所有敌人 2 次。"
  },
  Skill_4289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点护盾。玩家回合结束前每拥有一张手牌还会额外获得 [Arg4] 点护盾。"
  },
  Skill_4289_Name = {Text = "试探"},
  Skill_4290_AwakerSkillBackgroundStory = {
    Text = "凯旋式历来是罗马人的盛宴。\n白鸽、月桂叶，以及漫天飞舞的金箔……这一切和战士有关，又无关。\n他和那些来自高卢、亚力山卓和帕提亚的战俘一起，被缚在沉重的十字架上游街示众。\n这是凯旋式的保留节目。战士被尽情嘲弄，只因他被认定是那位已故皇帝的血腥同谋。\n耻辱、愤怒，还是仇恨？不，都不是。\n战士没有情绪，也没有思考。\n他只闻到血。"
  },
  Skill_4290_BattleDesc_0 = {
    Text = "尤乌哈希获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：尤乌哈希不受<CardKeyWord:封印>影响，暴击率和暴击伤害提高 [Arg2]%，生命低于 25% 时效果翻倍。"
  },
  Skill_4290_BattleDesc_15 = {
    Text = "尤乌哈希获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：尤乌哈希不受<CardKeyWord:封印>影响，暴击率和暴击伤害提高 [Arg2]%，「血与沙的赞歌」最终伤害提高 [Arg5]%，生命低于 25% 时效果翻倍。"
  },
  Skill_4290_Desc_0 = {
    Text = "尤乌哈希获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：尤乌哈希不受<CardKeyWord:封印>影响，暴击率和暴击伤害提高 [Arg2]%，生命低于 25% 时效果翻倍。"
  },
  Skill_4290_Desc_15 = {
    Text = "尤乌哈希获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：尤乌哈希不受<CardKeyWord:封印>影响，暴击率和暴击伤害提高 [Arg2]%，「血与沙的赞歌」最终伤害提高 [Arg5]%，生命低于 25% 时效果翻倍。"
  },
  Skill_4290_EffectNameList = {Text = "狂气"},
  Skill_4290_Name = {Text = "红祭礼"},
  Skill_4290_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4291_AwakerSkillBackgroundStory = {
    Text = "她喜欢随心所欲。砍掉一个人的头，缝起来，再砍掉，再缝起来......没有动机，没有目的，一切水到渠成，没人敢质疑她一个字。"
  },
  Skill_4291_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4291_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。旺达获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4291_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4291_Name = {Text = "打击"},
  Skill_4291_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4292_Desc = {
    Text = "获得 3 点算力。"
  },
  Skill_4292_Name = {
    Text = "鼠鼠的智慧"
  },
  Skill_4293_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4293_Name = {Text = "清扫"},
  Skill_4294_Desc = {
    Text = "对双方各造成 [Arg1] 层<VulnerabilityIconKeywords:易伤>。获得「利刃Ⅱ」：若造成未被格挡的伤害，在抽牌堆顶添加 2 张<DerivativeCardKeywords_23:「伤口」>。持续 1 回合。"
  },
  Skill_4294_Name = {
    Text = "垂死之挣"
  },
  Skill_4295_AwakerSkillBackgroundStory = {
    Text = "这双眼睛已无法正常视物。\n她直面时间与现实的风暴，任由呼啸的混沌切割、搅碎，最后成为她的眼睛。\n属于「拉蒙娜」的又一个痕迹正从她的身上消失，她抓不住流失的自己，正如她未能抓住从指尖流失的生命。"
  },
  Skill_4295_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。选择 1 张抽牌堆的牌置入手中并使其算力消耗 -1。<TimeBeacon:回环>：改为选择 1 张抽牌堆或弃牌堆的牌置入手中，使其算力消耗变为 0。"
  },
  Skill_4295_EffectNameList = {Text = "力量"},
  Skill_4295_Name = {
    Text = "超越之目"
  },
  Skill_4295_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4296_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张 <DerivativeCardKeywords_36:「亵渎假象」> 加入手中。"
  },
  Skill_4296_Name = {
    Text = "精神啃噬"
  },
  Skill_4297_AwakerSkillBackgroundStory = {
    Text = "当心，此女的一切行为都指向一个最终目的：使人伤害她——不，是狠狠地伤害她。"
  },
  Skill_4297_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4297_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。雷娅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4297_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4297_Name = {Text = "打击"},
  Skill_4297_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4298_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4298_Name = {Text = "遗恨"},
  Skill_4299_Desc = {
    Text = "获得 1 点算力。"
  },
  Skill_4299_Name = {Text = "筹算"},
  Skill_4300_Desc = {
    Text = "对所有敌人施加 1 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4300_Name = {Text = "易伤"},
  Skill_4301_Desc = {
    Text = "抽 1 张牌。"
  },
  Skill_4301_Name = {Text = "妙手"},
  Skill_4302_Desc = {
    Text = "其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4302_Name = {Text = "催化"},
  Skill_4303_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆。"
  },
  Skill_4303_Name = {Text = "灵感"},
  Skill_4304_Desc = {
    Text = "对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4304_Name = {Text = "虚弱"},
  Skill_4305_Desc = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4305_Name = {Text = "狂气"},
  Skill_4306_AwakerSkillBackgroundStory = {
    Text = "她将在地上以祂的名行事。\n她将得祂应得的美名。\n她将于毁灭之时，承无人可受之痛。\n此即为代行者。"
  },
  Skill_4306_Desc_0 = {
    Text = "弥利亚姆获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕上限和触腕数量 +1，对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。弥利亚姆的「打击」和「无上生祭」暴击率提高 100%。将 1 张<O07CardKeyWord4:「信仰的歧路」>置入手中。"
  },
  Skill_4306_Desc_15 = {
    Text = "弥利亚姆获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕上限和触腕数量 +1，对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。弥利亚姆的「打击」和「无上生祭」暴击率提高 100%。将 1 张<O07CardKeyWord4:「信仰的歧路」>置入手中。每翻转 2 张「圣礼」将一张「神国幻影」置入手中。"
  },
  Skill_4306_EffectNameList = {Text = "狂气"},
  Skill_4306_Name = {
    Text = "信仰的见证"
  },
  Skill_4306_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4307_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量伤害<BleedingIconKeywords:出血>。"
  },
  Skill_4307_Name = {Text = "出血"},
  Skill_4308_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4309_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张症状<DerivativeCardKeywords_9:「颓丧」>洗入抽牌堆。"
  },
  Skill_4309_Name = {
    Text = "无声尖啸"
  },
  Skill_4310_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使对方直到回合结束，失去 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4311_AwakerSkillBackgroundStory = {
    Text = "柔软的轻触，会让你感觉到爱吗？\n温热的吐息，会让你沉湎于我吗？\n这珠玉与轻纱环绕的爱抚，对你而言，是礼物吗？"
  },
  Skill_4311_Desc_0 = {
    Text = "选择 1 名其他唤醒体，使自身和该唤醒体均获得 <Energy:[Energy:Arg1]> 点狂气。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4311_EffectNameList = {
    Text = "狂气,力量"
  },
  Skill_4311_Name = {
    Text = "古老的爱抚"
  },
  Skill_4311_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4313_Desc = {
    Text = "施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4313_Name = {Text = "毒素"},
  Skill_4314_AwakerSkillBackgroundStory = {
    Text = "她的血因祂们滚烫，她的大脑因祂们沸腾。\n无论这些异形之子能否实现她的夙愿，无论祂们是否能在虚无中存续。\n泰旖丝满怀爱意地迎接着每个圣洁之子的降生。"
  },
  Skill_4314_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：使其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。】对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，造成 [Arg3]% 伤害的<BleedingIconKeywords:出血>，并施加 [Arg4]% 伤害的<IntoxicationIconKeywords:中毒>并获得 [Arg5]% 伤害的<RetaliateIconKeywords:反击>。选择 1 张手中的非衍生指令卡，将其 [Arg7] 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的原始复制置入手中，使其算力消耗 -[Arg6]。"
  },
  Skill_4314_EffectNameList = {
    Text = "狂气,伤害,出血百分比,中毒百分比,反击百分比"
  },
  Skill_4314_Name = {
    Text = "丰穰之仪"
  },
  Skill_4314_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：使其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。】对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，造成 [Arg3]% 伤害的<BleedingIconKeywords:出血>，并施加 [Arg4]% 伤害的<IntoxicationIconKeywords:中毒>并获得 [Arg5]% 伤害的<RetaliateIconKeywords:反击>。选择 1 张手中的非衍生指令卡，将其 [Arg7] 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的原始复制置入手中，使其算力消耗 -[Arg6]。接下来 3 回合内，每回合开始时将 1 张「胚胎」转化为「圣洁之子」，若没有「胚胎」则<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg8]，不受胚胎融合提高效果影响。"
  },
  Skill_4314_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,$GrowValue3,$GrowValue4,$GrowValue5"
  },
  Skill_4315_AwakerSkillBackgroundStory = {
    Text = "保护我。保护我。保护我。\n懦弱的怪物，和她一样，似有生命，似无意识。\n漆黑黏液汇聚成她的使从，不分昼夜地被指令驱使。"
  },
  Skill_4315_Desc_0 = {
    Text = "莉莉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时获得 10% 最大生命的<PainWord:忍耐>。莉莉施加护盾时，对生命最高敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4315_Desc_15 = {
    Text = "莉莉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时获得 10% 最大生命的<PainWord:忍耐>。莉莉施加护盾时，对生命最高敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。狂气爆发使本回合每受到 1 次攻击就使下次「报偿打击」消耗<PainWord:忍耐>的效果提高 40%，最多叠加 5 层。"
  },
  Skill_4315_EffectNameList = {
    Text = "狂气,中毒"
  },
  Skill_4315_Name = {
    Text = "黏液汇集"
  },
  Skill_4315_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4316_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入对方抽牌堆。"
  },
  Skill_4316_Name = {Text = "蜡油"},
  Skill_4317_Desc = {
    Text = "自爆！造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4317_Name = {Text = "BOOM！"},
  Skill_4318_Desc = {
    Text = "战斗结束后仍会保存在牌库中。无法出售。"
  },
  Skill_4318_Name = {
    Text = "黏糊糊的蜡油"
  },
  Skill_4319_Desc = {
    Text = "所有友方获得 <Block:[Block:Arg1]> 点护盾与 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4319_Name = {Text = "呼啸"},
  Skill_4320_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4322_AwakerSkillBackgroundStory = {
    Text = "飞蛾没有头脑，只会依从本能乱撞。\n既然如此，那就让这帮头脑不比飞蛾发达的家伙们看看他们垂涎之物吧。\n那是年轻女孩充满稚气童真的梦。"
  },
  Skill_4322_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，将 1 张具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「绿炎」>置入手中。<TransitionIconKeywords:跃迁>：下个回合开始前，每受到 1 次攻击，便将 1 张具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「绿炎」>置入手中。"
  },
  Skill_4322_EffectNameList_0 = {Text = "护盾"},
  Skill_4322_Name = {
    Text = "诱蛾之火"
  },
  Skill_4322_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4323_AwakerSkillBackgroundStory = {
    Text = "奥吉尔的持枪姿势并不标准，但所有能指导他的人，都已经消失在了时间与黑暗中。"
  },
  Skill_4323_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4323_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。奥吉尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4323_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4323_Name = {Text = "打击"},
  Skill_4323_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4324_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<FragileIconKeywords:脆弱>。"
  },
  Skill_4325_AwakerSkillBackgroundStory = {
    Text = "当他举起巨剑，带来的必然是鲜血与死亡。"
  },
  Skill_4325_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4325_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。戈利亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4325_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4325_Name = {Text = "打击"},
  Skill_4325_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4326_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4328_Desc = {
    Text = "对全体敌方施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4328_Name = {
    Text = "毒性侵染"
  },
  Skill_4329_AwakerSkillBackgroundStory = {
    Text = "即使她亲眼目睹了故土的覆灭，即使她所知的一切都已经在融蚀的吞噬下消失殆尽，她也不愿意放弃寻找。定位仪亮起搜寻的光，试图找到与她有着共同故乡的人。\n一定会有的，一定会有的。"
  },
  Skill_4329_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，弃掉所有手牌。<TransitionIconKeywords:跃迁>：不再弃牌，改为获得 <Block:[Block:Arg4]> 点护盾并抽 1 张牌。"
  },
  Skill_4329_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾，弃掉所有手牌，每弃掉 1 张牌获得 <Block:[Block:Arg2]> 点延迟护盾。<TransitionIconKeywords:跃迁>：不再弃牌，改为获得 <Block:[Block:Arg4]> 点护盾并抽 2 张牌。"
  },
  Skill_4329_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，弃掉所有手牌，每弃掉 1 张牌获得的护盾提高 50%。<TransitionIconKeywords:跃迁>：不再弃牌并抽 1 张牌，获得的护盾提高 100%。"
  },
  Skill_4329_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，弃掉所有手牌，每弃掉 1 张牌获得的护盾提高 50%并获得 <Block:[Block:Arg2]> 点延迟护盾。<TransitionIconKeywords:跃迁>：不再弃牌并抽 2 张牌，获得的护盾提高 100%。"
  },
  Skill_4329_EffectNameList_0 = {Text = "护盾"},
  Skill_4329_EffectNameList_2 = {
    Text = "护盾,延迟护盾"
  },
  Skill_4329_Name = {
    Text = "精神重建"
  },
  Skill_4329_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4329_PropertyNameList_2 = {
    Text = "防御力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4332_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4333_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4334_AwakerSkillBackgroundStory = {
    Text = "于黑色淤泥中绽放的蓓蕾。也曾经感受过园丁的呵护，也曾沐浴过雨露的照拂。\n而此刻，它孤独地绽放，任凭狂风切割娇嫩的皮肤，任凭暴雨击打孱弱的身躯，任凭薄而锋利的刀刃切开表皮，长而尖锐的针头刺入骨髓。\n反正，身体里寄宿的那个巨大的怪物，会替她抵挡伤痛。\n或许陪伴在她身边的，已经只有那个巨大的怪物，从今往后，只能与怪物为伍……"
  },
  Skill_4334_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]% 的生命并移除<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]% 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_EffectNameList_0 = {
    Text = "护盾,中毒"
  },
  Skill_4334_Name = {
    Text = "淤泥上的不灭之花"
  },
  Skill_4334_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。"
  },
  Skill_4334_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。"
  },
  Skill_4334_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4334_tempBattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。"
  },
  Skill_4334_tempBattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本回合每受到 1 次攻击就使下次「报偿打击」消耗<PainWord:忍耐>的效果提高 40%，最多叠加 5 层。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。"
  },
  Skill_4334_tempOverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。回复<PainWord:忍耐>层数 [Arg2]%([Arg3]) 的生命并移除一半<PainWord:忍耐>。每受到 1 次攻击，对攻击者施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>，持续 1 回合。本场战斗内忍耐上限提高 100%，获得等同于最大生命的忍耐。将 2 张附加消耗的「报偿打击」置入手中。本回合每受到 1 次攻击就使下次「报偿打击」消耗<PainWord:忍耐>的效果提高 40%，最多叠加 5 层。"
  },
  Skill_4336_Desc = {
    Text = "为全体友方施加 [Arg1] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_4336_Name = {
    Text = "全体屏障"
  },
  Skill_4337_AwakerSkillBackgroundStory = {
    Text = "德克斯特勋爵发誓，最初让女儿学习古典刺剑时，他只希望这项技能能提升她的气质——显然，拉蒙娜的追求不止于此。"
  },
  Skill_4337_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4337_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。拉蒙娜获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4337_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4337_Name = {Text = "打击"},
  Skill_4337_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4338_Desc = {
    Text = "全体获得 [Arg1] <PowerIconKeywords:力量>。前进。"
  },
  Skill_4338_Name = {
    Text = "全体力量"
  },
  Skill_4339_AwakerSkillBackgroundStory = {
    Text = "曾有人半开玩笑地询问艾继丝能不能给自己织一条围巾，因为她身上从毛衣针到毛线一应俱全。\n艾继丝不好意思地低下头。她没有告诉别人，她头上的毛衣针并不是装饰，而是压制她眼睛的力量的特殊器具。\n几天后，她用借来的毛衣针完成了一条彩色围巾。"
  },
  Skill_4339_Desc_0 = {
    Text = "艾继丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：艾继丝打出卡牌后，对所有敌人施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4339_Desc_15 = {
    Text = "艾继丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：艾继丝打出卡牌后，对所有敌人施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>。艾继丝释放狂气爆发后使自身下一张「防御」生效 3 次，额外使狂气爆发基础伤害提高 50%。"
  },
  Skill_4339_EffectNameList = {Text = "狂气"},
  Skill_4339_Name = {
    Text = "凝滞诅咒"
  },
  Skill_4339_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4340_Desc = {
    Text = "获得 [Arg3] 点临时<PowerIconKeywords:力量>，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。如果失去生命，则失去临时<PowerIconKeywords:力量>加成。"
  },
  Skill_4340_Name = {
    Text = "割喉挥砍(破绽)"
  },
  Skill_4341_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4342_AwakerSkillBackgroundStory = {
    Text = "很难说是别称为「街头老鼠」的孩子们接纳了老鼠，还是真正的老鼠接纳了街童，这段因生计所迫而诞生的情谊，却在多年的相处下变得坚不可破。\n谁能说动物不是人类最好的朋友呢？"
  },
  Skill_4342_Desc = {
    Text = "将 [Arg1] 张附加<DepleteIconKeywords:消耗>、算力消耗为 0 的「布朗出动！」置入手牌。临时暴击伤害 +[Arg2]% 。"
  },
  Skill_4342_EffectNameList = {
    Text = "临时暴击伤害"
  },
  Skill_4342_Name = {
    Text = "雾都街童"
  },
  Skill_4342_OverLimitUtlSkillDesc = {
    Text = "将 [Arg1] 张附加<DepleteIconKeywords:消耗>、算力消耗为 0 的「布朗出动！」置入手牌。临时暴击伤害 +[Arg2]% 。将 1 张附加<DepleteIconKeywords:消耗>的「超级大集结！」置入手牌。"
  },
  Skill_4342_PropertyNameList = {
    Text = "$GrowValue1,"
  },
  Skill_4343_AwakerSkillBackgroundStory = {
    Text = "在战场上他所向披靡，重剑一杵，那些不敌之人便溃不成军。"
  },
  Skill_4343_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4343_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。戈利亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4343_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4343_Name = {Text = "防御"},
  Skill_4343_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4344_AwakerSkillBackgroundStory = {
    Text = "歌声是她的盾牌。\n这盾牌却不能抵挡那些呼来喝去中隐含的轻蔑与侮辱。"
  },
  Skill_4344_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4344_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 2 次。获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：额外获得 1 次狂气。"
  },
  Skill_4344_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。汀克特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4344_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 2 次。汀克特获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：额外获得 1 次狂气。"
  },
  Skill_4344_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4344_Name = {Text = "防御"},
  Skill_4344_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4345_Desc = {
    Text = "雷娅在每失去一定生命后，获得等同于最大生命的护盾。"
  },
  Skill_4345_Name = {Text = "渴血者"},
  Skill_4346_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，后撤。"
  },
  Skill_4347_Desc = {
    Text = "每回合获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4347_Name = {
    Text = "远古的呼唤"
  },
  Skill_4348_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<ParcloseIconKeywords:屏障>。玩家回合结束前每拥有一张手牌还会额外获得 [Arg4] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_4348_Name = {Text = "试探"},
  Skill_4349_AwakerSkillBackgroundStory = {
    Text = "漆黑的黏液将她拖入深渊。群星在这里诞生，光线在这里死去。这里没有时间，没有生命。\n一个声音从远处走来，散发着黑色的光。\n它说：你将永远变得不同，因为你已经造访妖精的通道。\n她将在这里漫长地游荡。"
  },
  Skill_4349_Desc_0 = {
    Text = "詹金获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：暴击率提高 [Arg2]% ，詹金每造成 1 次伤害，临时暴击伤害 +[Arg3]%，每回合最多叠加 5 次。"
  },
  Skill_4349_Desc_15 = {
    Text = "詹金获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：暴击率提高 [Arg2]% ，詹金每造成 1 次伤害，临时暴击伤害 +[Arg3]%，每回合最多叠加 5 次。詹金自身从「空间折叠」和「雾都街童」中获得 2 倍暴击伤害效果。"
  },
  Skill_4349_EffectNameList = {Text = "狂气"},
  Skill_4349_Name = {
    Text = "空间折叠"
  },
  Skill_4349_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4350_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4351_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_27:症状：「癫痫」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4351_Name = {Text = "哭喊！"},
  Skill_4352_Desc = {
    Text = "进化为「干涉型融蚀体」。当前生命越高进化的怪物就越强。"
  },
  Skill_4352_Name = {
    Text = "融蚀进化"
  },
  Skill_4353_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>，回合结束时<PowerIconKeywords:力量>降低 [Arg2] 点。"
  },
  Skill_4353_Name = {
    Text = "枷锁：彷徨的利刃"
  },
  Skill_4354_Desc = {
    Text = "吸收所有友方并回复等量生命。获得 [Arg1] <PowerIconKeywords:力量>，每吸收一个「都怪你」额外获得 [Arg2]<PowerIconKeywords:力量>。"
  },
  Skill_4354_Name = {Text = "吸收"},
  Skill_4356_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4356_Name = {
    Text = "小小愿望"
  },
  Skill_4357_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4357_Name = {
    Text = "拥抱融蚀"
  },
  Skill_4358_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4359_Desc = {
    Text = "对全体敌方施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，触发目标的中毒效果。"
  },
  Skill_4359_Name = {
    Text = "毒性发作"
  },
  Skill_4360_AwakerSkillBackgroundStory = {
    Text = "哎呀哎呀，不准反抗~"
  },
  Skill_4360_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4360_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4360_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。潘狄娅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4360_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。潘狄娅获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4360_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4360_EffectNameList_1 = {
    Text = "护盾,狂气,反击"
  },
  Skill_4360_Name = {Text = "防御"},
  Skill_4360_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4360_PropertyNameList_1 = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4361_AwakerSkillBackgroundStory = {
    Text = "摇篮中的少女，会梦到未曾得见的花吗？\n那会是怎样的花呢？会如她一般，被桎梏方寸间，于掌心大小的盆中破土吗？\n还是会像妹妹的歌谣中一般，盛放于星海，被宇宙尘埃与星流带向未知的远方？"
  },
  Skill_4361_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：将 1 张算力消耗为 0 的「幼芽萌生」置入手牌并附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虚弱>全体敌方 2 回合。】获得 [Counterattack:Arg1] 层<RetaliateIconKeywords:反击>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，则 +[Arg3]%。驱散自身<FragileIconKeywords:脆弱>。"
  },
  Skill_4361_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：将 1 张算力消耗为 0 的「幼芽萌生」置入手牌并附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虚弱>全体敌方 2 回合。】获得 [Counterattack:Arg1] 层<RetaliateIconKeywords:反击>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，则 +[Arg3]%。驱散自身<FragileIconKeywords:脆弱>。"
  },
  Skill_4361_EffectNameList_0 = {
    Text = "反击,死亡抵抗上限,死亡抵抗"
  },
  Skill_4361_Name = {
    Text = "星之摇篮"
  },
  Skill_4361_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：将 1 张算力消耗为 0 的「幼芽萌生」置入手牌并附加<DepleteIconKeywords:消耗>。<WeaknessIconKeywords:虚弱>全体敌方 2 回合。】获得 [Counterattack:Arg1] 层<RetaliateIconKeywords:反击>。若<DeathResistanceIconKeywords:死亡抵抗>不足 [Arg2]%，则 +[Arg3]%。驱散自身<FragileIconKeywords:脆弱>。使所有敌人临时降低 [Exhaustion:Arg5] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_4361_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4362_Desc = {
    Text = "造成 [Arg1] 层<IntoxicationIconKeywords:中毒>，对抽牌堆和弃牌堆中随机 [Arg2] 张卡牌施加「<SlowIconKeywords:迟缓>」"
  },
  Skill_4362_Name = {
    Text = "迟缓迷毒"
  },
  Skill_4363_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，献祭自身。不受疯狂影响。"
  },
  Skill_4363_Name = {Text = "献祭"},
  Skill_4364_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！"
  },
  Skill_4365_AwakerSkillBackgroundStory = {
    Text = "有人固执地认为，身体与灵魂应是永恒的一体；也有人害怕失去肉体后，彷徨不定的神智将走向毁灭。\n回应质疑在朵尔眼里是件麻烦事，她选择用一具又一具傀儡身体的更迭来证明手术的成功。"
  },
  Skill_4365_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。对所有敌人造成 [Arg2] 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4365_EffectNameList = {Text = "回复"},
  Skill_4365_Name = {
    Text = "外域手术"
  },
  Skill_4365_PropertyNameList = {
    Text = "体质*GrowValue1,"
  },
  Skill_4366_AwakerSkillBackgroundStory = {
    Text = "歌声是她的武器。\n这武器陪伴她在漫天星光中孤独流浪。"
  },
  Skill_4366_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4366_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次。获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：额外造成 1 次伤害。"
  },
  Skill_4366_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。汀克特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4366_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次。汀克特获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：额外造成 1 次伤害。"
  },
  Skill_4366_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4366_Name = {Text = "打击"},
  Skill_4366_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4367_AwakerSkillBackgroundStory = {
    Text = "莉兹还记得自己获得绿炎那天的景象。\n青色的火种在掌心升腾跃动，催促她去达成那压抑已久的愿望。"
  },
  Skill_4367_Desc = {
    Text = "对随机敌人造成 <Damage:[Damage:Arg2]> 点<PunctureDamagewords:穿刺伤害> [Arg1] 次，施加 50% 伤害的<IntoxicationIconKeywords:中毒>。算力不足时可以强行打出，效果改为获得 <Energy:[Energy:Arg3]> 点狂气并消耗。"
  },
  Skill_4367_EffectNameList = {Text = "伤害"},
  Skill_4367_Name = {
    Text = "死灭绿炎"
  },
  Skill_4367_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4368_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4368_Name = {Text = "捶打"},
  Skill_4371_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，恢复等同于未被格挡伤害的生命。将 1 张<DerivativeCardKeywords_34:「未被满足之痛」>置入抽牌堆。"
  },
  Skill_4371_Name = {
    Text = "苦痛与血"
  },
  Skill_4372_Desc = {
    Text = "对双方各造成 [Arg1] 层<VulnerabilityIconKeywords:易伤>。获得「利刃Ⅱ」：若造成未被格挡的伤害，在抽牌堆顶添加 2 张<DerivativeCardKeywords_23:「伤口」>。持续 1 回合。"
  },
  Skill_4372_Name = {
    Text = "垂死之挣"
  },
  Skill_4373_AwakerSkillBackgroundStory = {
    Text = "她的前鳍能够劈开航道，尾鳍足以砸出港湾。\n在无人可战后，巨鲸于混沌中沉眠，将星球托付给了新生的生灵。"
  },
  Skill_4373_BattleDesc_0 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。"
  },
  Skill_4373_BattleDesc_3 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。将 2 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的「打击」置入手中。"
  },
  Skill_4373_Desc_0 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。"
  },
  Skill_4373_Desc_15 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。将 2 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的「打击」置入手中。"
  },
  Skill_4373_Desc_3 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。将 2 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的「打击」置入手中。"
  },
  Skill_4373_EffectNameList = {
    Text = "伤害,伤害"
  },
  Skill_4373_Name = {
    Text = "混沌之兽"
  },
  Skill_4373_OverLimitUtlSkillDesc_0 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。对所有敌人额外造成 1 次 15% 目标最大生命的<FixedDamage:纯粹伤害>。本场战斗中「混沌之兽」的基础伤害提高 100%。"
  },
  Skill_4373_OverLimitUtlSkillDesc_3 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。在本场战斗中每打出 1 张「打击」便使伤害+ [Arg2] 。将 2 张附加<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>的「打击」置入手中。对所有敌人额外追加 1 次 15% 目标最大生命的<FixedDamage:纯粹伤害>。本场战斗中「混沌之兽」的基础伤害提高 100%。"
  },
  Skill_4373_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4374_Desc = {
    Text = "一点小伤，无伤大体。受到 [Arg1] 点<FixedDamage:纯粹伤害>，抽 [Arg3] 张牌。"
  },
  Skill_4374_Name = {Text = "伤口"},
  Skill_4375_AwakerSkillBackgroundStory = {
    Text = "一步一步，她缓缓迈入海水之中。\n刚触及皮肤还显得稍许寒凉的入夜之海，此刻竟如人类的拥抱一般温暖。\n海接纳了我，这样的思绪，悄然飘入了宁菲亚脑中。\n恍然间，见到了父母的笑容。在那海的深处，一定有着天伦的安乐吧。"
  },
  Skill_4375_Desc_0 = {
    Text = "宁菲亚获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：宁菲亚打出卡牌后，获得 <Energy:[Energy:Arg2]> 点狂气。回合结束时，使宁菲亚造成的中毒提高 [Arg3]%。"
  },
  Skill_4375_Desc_15 = {
    Text = "宁菲亚获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：宁菲亚打出卡牌后，获得 <Energy:[Energy:Arg2]> 点狂气。回合结束时，使宁菲亚造成的中毒提高 [Arg4]%。"
  },
  Skill_4375_EffectNameList = {
    Text = "狂气,打出卡牌获得狂气,中毒成长"
  },
  Skill_4375_Name = {
    Text = "沉逝苦海"
  },
  Skill_4375_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2,$GrowValue3%"
  },
  Skill_4376_AwakerSkillBackgroundStory = {
    Text = "「别、别过来，我不想伤害你！」"
  },
  Skill_4376_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4376_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，目标每有 1 层<VulnerabilityIconKeywords:易伤>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]，最多 [Arg4]。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4376_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。艾继丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4376_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，目标每有 1 层<VulnerabilityIconKeywords:易伤>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]，最多 [Arg4]。艾继丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4376_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4376_Name = {Text = "打击"},
  Skill_4376_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4377_AwakerSkillBackgroundStory = {
    Text = "不敬之人，无礼之人，亵渎之人，不配前往永恒的国。"
  },
  Skill_4377_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4377_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。使 1 条触腕攻击 2 次，但只造成 50％ 的伤害。"
  },
  Skill_4377_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。法洛思获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4377_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。法洛思获得 <Energy:[Energy:Arg2]> 点狂气。使 1 条触腕攻击 2 次，但只造成 50％ 的伤害。"
  },
  Skill_4377_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4377_Name = {Text = "打击"},
  Skill_4377_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4378_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4378_Name = {Text = "出血"},
  Skill_4379_AwakerSkillBackgroundStory = {
    Text = "宣告：\n无法感知艺术至美的庸俗之人啊，因舞者痛苦而雀跃的狂热之人啊，对功名利禄贪得无厌的可悲之人啊。\n此即你们的末路。\n为你们献上这支告死之舞，让绿炎净化你们的灵魂，让优美的火焰涤荡你们污浊蒙蔽的心。\n让我们于永恒的净土再会。"
  },
  Skill_4379_Desc_0 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。弃掉手牌中所有莉兹的牌，并触发他们的效果。"
  },
  Skill_4379_Desc_3 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。弃掉手牌中所有莉兹的牌，并触发他们的效果。每弃掉 2 张牌，便抽 1 张牌。"
  },
  Skill_4379_EffectNameList = {Text = "力量"},
  Skill_4379_Name = {
    Text = "告死之舞"
  },
  Skill_4379_OverLimitUtlSkillDesc_0 = {
    Text = "将手牌中所有的「绿炎」与「腐化绿炎」升级为「死灭绿炎」，之后 [Arg2] 个回合，每回合开始时重复 1 次该效果。获得 [Arg1] 点临时<PowerIconKeywords:力量>。弃掉手牌中所有莉兹的牌，并触发他们的效果。"
  },
  Skill_4379_OverLimitUtlSkillDesc_3 = {
    Text = "将手牌中所有的「绿炎」与「腐化绿炎」升级为「死灭绿炎」，之后 [Arg2] 个回合，每回合开始时重复 1 次该效果。获得 [Arg1] 点临时<PowerIconKeywords:力量>。弃掉手牌中所有莉兹的牌，并触发他们的效果。每弃掉 2 张牌，便抽 1 张牌。"
  },
  Skill_4379_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4380_Desc = {
    Text = "回复莎拉 [Arg1] 点生命。"
  },
  Skill_4380_Name = {Text = "回复"},
  Skill_43819_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_43819_Name = {Text = "觉醒"},
  Skill_4381_AwakerSkillBackgroundStory = {
    Text = "蜕变之时已至。\n传承者是比凡人更加高贵的存在。\n舍弃亲人、舍弃友人、舍弃苦痛、舍弃过往一切。\n我将获得荣光之加护。\n他的体表密生鳞刺。"
  },
  Skill_4381_Desc_0 = {
    Text = "凯刻斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，凯刻斯每打出 1 张牌，回复 <Heal:[Heal:Arg2]> 点生命并获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4381_Desc_15 = {
    Text = "凯刻斯获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，凯刻斯每打出 1 张牌，回复 <Heal:[Heal:Arg2]> 点生命并获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>，使 1 条触腕进行攻击，获得 [Arg4]％ 造成伤害的反击。"
  },
  Skill_4381_EffectNameList = {
    Text = "狂气,回复,反击"
  },
  Skill_4381_Name = {
    Text = "蜕变之躯"
  },
  Skill_4381_PropertyNameList = {
    Text = "$GrowValue1,体质*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4382_Desc = {
    Text = "注视一名唤醒体。使用被注视唤醒体的卡牌会再抽 2 张牌。"
  },
  Skill_4382_Name = {
    Text = "追猎注视"
  },
  Skill_4383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4383_Name = {Text = "明灭"},
  Skill_4384_AwakerSkillBackgroundStory = {
    Text = "越是禁欲与压抑之地，少女的掌控能力就越是惊人。\n响亮的皮鞭等同于甜美的爱语，灼热的滴蜡替代了滚烫的亲吻，紧绷的绳缚是无微不至的关怀，红肿的伤疤则是爱意的证明。\n在那蜜糖色的悲惨幻象中，传出少女银铃般的笑声。"
  },
  Skill_4384_Desc_0 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 2 次，每层<RetaliateIconKeywords:反击>使伤害提高 [Arg2] 点。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4384_Desc_3 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害 2 次，每层<RetaliateIconKeywords:反击>使伤害提高 [Arg2] 点。获得 [Power:Arg3] 点<PowerIconKeywords:力量>和 [Counterattack:Arg4] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4384_EffectNameList_0 = {
    Text = "伤害,力量"
  },
  Skill_4384_EffectNameList_3 = {
    Text = "伤害,力量,反击"
  },
  Skill_4384_Name = {
    Text = "蜜糖色悲惨幻象"
  },
  Skill_4384_OverLimitUtlSkillDesc = {
    Text = "对全体敌方施加 1 层<VulnerabilityIconKeywords:易伤>，造成 <Damage:[Damage:Arg1]> 点伤害 2 次，每层<RetaliateIconKeywords:反击>使伤害提高 [Arg2] 点。获得 [Arg3] 点<PowerIconKeywords:力量>和 [Counterattack:Arg5] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4384_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4384_PropertyNameList_3 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4385_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4386_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4387_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4388_AwakerSkillBackgroundStory = {
    Text = "在难以计数的轮回中，她将归因牢牢系于己身，一步步深陷因果的沼泽。\n悖论撕扯着她的身体，混沌填充着她的灵魂，而在无尽的痛苦中，她抓住了「未知」漏下的一缕微光。"
  },
  Skill_4388_Desc_0 = {
    Text = "环行·拉蒙娜获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：环行·拉蒙娜打出未触发<TimeBeacon:回环>的卡牌后，获得 1 层<TimeBeacon2:负熵>和获得 <Posse:[Arg2]> 点银钥能量，每回合最多触发 3 次。"
  },
  Skill_4388_Desc_15 = {
    Text = "环行·拉蒙娜获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：环行·拉蒙娜打出未触发<TimeBeacon:回环>的卡牌后，获得 1 层<TimeBeacon2:负熵>和获得 <Posse:[Arg2]> 点银钥能量，打出触发<TimeBeacon:回环>的卡牌后，获得 50 点银钥能量。"
  },
  Skill_4388_EffectNameList = {Text = "狂气"},
  Skill_4388_Name = {
    Text = "熵增逆转"
  },
  Skill_4388_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4389_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！这灯只是为了照明罢了。」"
  },
  Skill_4389_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4389_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4389_Name = {Text = "防御"},
  Skill_4389_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4390_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。自身获得 [Arg3] 层「蜡质镀层」：免疫异常状态，每次被暴击后减少 1 层。"
  },
  Skill_4390_Name = {
    Text = "蜡像登场"
  },
  Skill_4391_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次。施加 [Arg2] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4392_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4392_Name = {Text = "重击"},
  Skill_4393_AwakerSkillBackgroundStory = {
    Text = "诗歌首次出版的那天，花匠满怀雀跃地带来了一朵玫瑰。\n她小心翼翼地将玫瑰珍藏起来。在花园走向衰亡之前，那是这场幻梦最美好的高潮。"
  },
  Skill_4393_BattleDesc = {
    Text = "选择 1 名其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。 <TransitionIconKeywords:跃迁>：切换至情绪「喜」。"
  },
  Skill_4393_Desc = {
    Text = "选择 1 名其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。 <TransitionIconKeywords:跃迁>：切换至情绪「喜」。每消耗 1 层隐喻「喜」，额外获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4393_EffectNameList = {Text = "狂气"},
  Skill_4393_Name = {
    Text = "幻梦诗篇"
  },
  Skill_4393_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4394_Desc = {
    Text = "施加 [Arg1] 层空虚。"
  },
  Skill_4394_Name = {
    Text = "狂气吸收"
  },
  Skill_4395_Desc = {
    Text = "全体回复 [Arg1] 点生命。"
  },
  Skill_4395_Name = {Text = "回复"},
  Skill_4396_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4396_Name = {Text = "试探"},
  Skill_4397_AwakerSkillBackgroundStory = {
    Text = "我们是命运的三相姐妹 \n是奔跑在天空、大地与海洋的回音\n是永不分割的连绵雨水\n直到长夜将尽 没有什么能将我们分开"
  },
  Skill_4397_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4397_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 伤害。「24」获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4397_EffectNameList = {Text = "伤害"},
  Skill_4397_Name = {
    Text = "异种共生"
  },
  Skill_4397_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4398_AwakerSkillBackgroundStory = {
    Text = "加注、加注、肆无忌惮地加注。\n西装侍者比了个手势、对家牌手擦了一把额头的汗、头顶挂钟指针刚过0点。\n喧嚣拥挤的人群中，无数细节落入他眼底，不经演算便引向正确的结论。\n在那场终极的覆灭来临之前，他未尝败绩。"
  },
  Skill_4398_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。随机抽 1~ [Arg3] 张牌，每抽 1 张牌获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4398_EffectNameList_0 = {
    Text = "伤害,力量"
  },
  Skill_4398_Name = {
    Text = "肆意豪赌"
  },
  Skill_4398_OverLimitUtlSkillDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 3 次。随机抽 1~ [Arg3] 张牌，每抽 1 张牌获得 [Power:Arg2] 点<PowerIconKeywords:力量>，使抽到的卡牌算力消耗 -1。"
  },
  Skill_4398_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4400_AwakerSkillBackgroundStory = {
    Text = "沉浸于作品之中吧，不论是创作还是观赏，它都能给人带来无尽的慰藉。"
  },
  Skill_4400_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4400_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。珊获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4400_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4400_Name = {Text = "防御"},
  Skill_4400_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4401_Desc = {
    Text = "获得[Arg1] 点<PowerIconKeywords:力量>，吞噬敌人，跳过其下回合抽牌并造成无法抵抗的封印，但将维度裂隙的卡牌加入手中。"
  },
  Skill_4401_Name = {
    Text = "现世撕裂"
  },
  Skill_4402_Desc = {
    Text = "造成<Block:[Block:Arg1]>护盾，获得 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4402_Name = {Text = "警戒"},
  Skill_4403_AwakerSkillBackgroundStory = {
    Text = "无数齿轮彼此交叠，互相驱动，赋予瓷制的外壳以模仿生命的能力。\n这是她最得意的作品，是无法复制的精妙仪器。\n艾瑞卡无论如何也不可能想到，这个与自己同名的自动人偶，竟会成为自己的第二次生命。"
  },
  Skill_4403_Desc_0 = {
    Text = "艾瑞卡获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：艾瑞卡造成伤害时，获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>；艾瑞卡施加护盾时，获得 [Arg3] 点临时<AlertIconKeywords:戒备>。"
  },
  Skill_4403_Desc_15 = {
    Text = "艾瑞卡获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：艾瑞卡造成伤害时，获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>；艾瑞卡施加护盾时，获得 [Arg3] 点临时<AlertIconKeywords:戒备>。艾瑞卡每次释放狂气爆发后使狂气爆发享受的力量与戒备加成额外提高 1 倍。"
  },
  Skill_4403_EffectNameList = {
    Text = "狂气,力量,戒备"
  },
  Skill_4403_Name = {
    Text = "参数拟合"
  },
  Skill_4403_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,防御力*GrowValue3"
  },
  Skill_4404_AwakerSkillBackgroundStory = {
    Text = "她的礼仪是杂糅的，在宫廷中学了些，在市井中耳濡目染了些，在最初的神庙中被灌输了些。"
  },
  Skill_4404_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4404_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4404_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。泰旖丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4404_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。泰旖丝获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4404_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4404_EffectNameList_3 = {
    Text = "护盾,狂气"
  },
  Skill_4404_Name = {Text = "防御"},
  Skill_4404_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4404_PropertyNameList_3 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4405_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！这灯只是为了照明罢了。」"
  },
  Skill_4405_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。詹金获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4405_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4405_Name = {Text = "防御"},
  Skill_4405_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4407_AwakerSkillBackgroundStory = {
    Text = "她的皮肤发绿，腐烂的血管不断扭曲、盘旋。\n她的肩部仿佛正在孕育着某样东西——黑色的液体正顺着她的手臂，蔓延到手术台上。\n初生的血肉自创口中绽放，争先恐后，轻柔无声。\n虚弱的少女露出微笑。\n「终于又见面了，@2。」"
  },
  Skill_4407_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。直到下个回合开始前，每损失 2 点生命，下个回合开始时获得 1 点护盾。"
  },
  Skill_4407_Desc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg2] 次。直到下个回合开始前，每损失 2 点生命，下个回合开始时获得 1 点护盾。"
  },
  Skill_4407_EffectNameList_0 = {Text = "伤害"},
  Skill_4407_Name = {
    Text = "苦痛与欢愉"
  },
  Skill_4407_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4408_AwakerSkillBackgroundStory = {
    Text = "人类已知的光谱中不存在这种光线。\n像极光一样流光溢彩，像极光一样遥不可及，也像极光一样转瞬即逝。"
  },
  Skill_4408_Desc_0 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。临时暴击率 +[Arg2]%。本场战斗内，汀克特的「打击」基础伤害提高 [Arg3]%。使随机 5 张手牌直到回合结束时，算力消耗 -1。"
  },
  Skill_4408_Desc_3 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。临时暴击率和暴击伤害 +[Arg2]%。本场战斗内，汀克特的「打击」基础伤害提高 [Arg3]%。使随机 5 张手牌直到回合结束时，算力消耗 -1。"
  },
  Skill_4408_EffectNameList_0 = {Text = "力量"},
  Skill_4408_Name = {
    Text = "星彩极光"
  },
  Skill_4408_OverLimitUtlSkillDesc_0 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。临时暴击率 +[Arg2]%。本场战斗内，汀克特的「打击」基础伤害提高 [Arg3]%。使随机 5 张手牌直到回合结束时算力消耗变为 0。"
  },
  Skill_4408_OverLimitUtlSkillDesc_3 = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。临时暴击率和暴击伤害 +[Arg2]%。本场战斗内，汀克特的「打击」基础伤害提高 [Arg3]%。使随机 5 张手牌直到回合结束时算力消耗变为 0。"
  },
  Skill_4408_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4409_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4410_AwakerSkillBackgroundStory = {
    Text = "是神之国，是乌托邦，是永恒乐土，亦是法洛思的故乡。\n那座伟大的城国已然失落，除了淤泥、湿地、生满苔藓的巨大石块外，什么也没留下。"
  },
  Skill_4410_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。驱散自身<VulnerabilityIconKeywords:易伤>状态。从抽牌堆中选择至多 3 张牌置入手中。"
  },
  Skill_4410_EffectNameList = {Text = "护盾"},
  Skill_4410_Name = {
    Text = "遗失的久远之城"
  },
  Skill_4410_OverLimitUtlSkillDesc = {
    Text = "手牌上限+2，回合结束时，选择 1 张手牌获得保留并使其算力消耗 -1，持续 3 回合。获得 <Block:[Block:Arg1]> 点护盾。驱散自身<VulnerabilityIconKeywords:易伤>状态。从抽牌堆中选择至多 3 张牌置入手中。"
  },
  Skill_4410_PropertyNameList = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4411_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>，该<WeaknessIconKeywords:虚弱>减少50%伤害。"
  },
  Skill_4412_AwakerSkillBackgroundStory = {
    Text = "因狂气充盈而「百折不挠」的皮鞭，永远光鲜亮丽，无论何时何地，都能施以你渴求的疼痛。"
  },
  Skill_4412_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次并获得 50% 伤害的临时<RetaliateIconKeywords:反击>。"
  },
  Skill_4412_EffectNameList_0 = {Text = "伤害"},
  Skill_4412_Name = {
    Text = "狂气使役之鞭"
  },
  Skill_4412_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4413_AwakerSkillBackgroundStory = {
    Text = "应征入伍后，她在前线奋战，即便伤残也不愿退下战场，只因为她真心相信「更好的世界」即将到来。\n但谎言终将破灭。这次她举起武器，为的不再是那个虚假的承诺，而是自己心中的正确。"
  },
  Skill_4413_Desc_0 = {
    Text = "艾尔瓦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Arg2] 点<AlertIconKeywords:戒备>。艾尔瓦指令卡造成的伤害随当前护盾提高，每点护盾提高 2。"
  },
  Skill_4413_Desc_15 = {
    Text = "艾尔瓦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Arg2] 点<AlertIconKeywords:戒备>。艾尔瓦指令卡造成的伤害随当前护盾提高，每点护盾提高 2，每回合首次造成伤害时，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4413_EffectNameList = {
    Text = "狂气,戒备"
  },
  Skill_4413_Name = {
    Text = "战地卓识"
  },
  Skill_4413_PropertyNameList = {
    Text = "$GrowValue1,防御力*GrowValue2"
  },
  Skill_4415_Desc = {
    Text = "自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤> 1 回合。获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_4415_EffectNameList = {Text = "护盾"},
  Skill_4415_Name = {Text = "祝福"},
  Skill_4415_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_4416_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4417_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 护盾，获得 [Arg2] <PowerIconKeywords:力量>。"
  },
  Skill_4418_Desc = {
    Text = "战斗结束后仍会保存在牌库中。"
  },
  Skill_4418_Name = {
    Text = "黏糊糊的蜡油"
  },
  Skill_4419_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4420_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_4421_AwakerSkillBackgroundStory = {
    Text = "她在凸月之下跳舞。\n裙裾卷在手臂上，像一朵云似的不断旋转。\n在她之下，永无穷尽流动着的大湖逐渐与天空融为一体。\n跳吧。跳吧。黑暗中的声音说道。\n唤醒那位沉睡的大人，然后践行那千年的诺言吧。"
  },
  Skill_4421_Desc_0 = {
    Text = "珈伦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：珈伦打出卡牌后，回复 <Heal:[Heal:Arg2]> 点生命，获得 <Energy:[Energy:Arg3]> 点狂气。打出<DerivativeCardKeywords_42:「奇妙料理」>后,对所有敌人施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4421_Desc_15 = {
    Text = "珈伦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：珈伦打出卡牌后，回复 <Heal:[Heal:Arg2]> 点生命，获得 <Energy:[Energy:Arg3]> 点狂气。回合结束时若保留了珈伦的指令卡，触发 2 次回复生命和获得狂气效果。打出<DerivativeCardKeywords_42:「奇妙料理」>后,对所有敌人施加 [Poison:Arg4] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4421_EffectNameList = {
    Text = "狂气,回复,中毒"
  },
  Skill_4421_Name = {
    Text = "凸月之舞"
  },
  Skill_4421_PropertyNameList = {
    Text = "$GrowValue1,体质*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4422_AwakerSkillBackgroundStory = {
    Text = "「街头打斗可没那么多讲究，当然是什么趁手用什么了。」"
  },
  Skill_4422_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。詹金获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4422_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4422_Name = {Text = "打击"},
  Skill_4422_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4423_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4424_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，献祭自身。不受疯狂影响。"
  },
  Skill_4424_Name = {Text = "献祭"},
  Skill_4425_Desc = {
    Text = "自身死亡，分裂为两个生命与自身相当的「Ⅱ型融蚀体」。"
  },
  Skill_4425_Name = {Text = "分裂"},
  Skill_4426_Desc = {
    Text = "黑暗、狭窄、不断崩塌、出口和怪物都在那里，无处可逃。"
  },
  Skill_4426_Name = {Text = "逃跑"},
  Skill_4427_AwakerSkillBackgroundStory = {
    Text = "无论是扫帚还是武器，她都能使得十分优雅。"
  },
  Skill_4427_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4427_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。珈伦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4427_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4427_Name = {Text = "打击"},
  Skill_4427_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_44284_Desc = {
    Text = "召唤 5 个「胎动·努比亚幼崽」，隐匿自身，无法受到攻击，所有敌人死亡后隐匿解除。"
  },
  Skill_44284_Name = {Text = "繁育"},
  Skill_44285_Desc = {
    Text = "施加 [Arg1] 回合<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords:脆弱>。封印 2 名唤醒体，造成 [Arg2] 点<IntoxicationIconKeywords:中毒>，使卡组中 2 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_44285_Name = {Text = "哺乳"},
  Skill_44286_Desc = {
    Text = "「丰穰母树」吸收了周围的生机……提高最大生命，且所有技能均得到强化！"
  },
  Skill_44286_Name = {
    Text = "多重融合"
  },
  Skill_4428_AwakerSkillBackgroundStory = {
    Text = "此人乃是虚伪的圣女，其言行举止无一遵守圣女的本分。\n但那强硬的外表下，究竟掩藏着怎样的真实呢——或许为自身的命运毅然举起旗帜，也是圣女品格的一种。"
  },
  Skill_4428_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg6]> 点护盾和 [Arg3] 点算力，下回合开始时，受到最大生命 [Arg5]% 的<SacrificeKeyWord:献祭>。<RippleKeywords:余波>：<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg4]。"
  },
  Skill_4428_Desc_0 = {
    Text = "获得总计(最大生命 <Block:[Block:Arg1]%> + <Block:[Block:Arg2]> )点护盾和 [Arg3]  点算力。下回合开始时，受到最大生命 [Arg5]% 的<SacrificeKeyWord:献祭>。<RippleKeywords:余波>：<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg4] 。"
  },
  Skill_4428_EffectNameList = {
    Text = "护盾,触腕伤害"
  },
  Skill_4428_Name = {
    Text = "圣女作成"
  },
  Skill_4428_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4429_AwakerSkillBackgroundStory = {
    Text = "尼尼微是泰旖丝漫长生命中微不足道的一站，但在殿前得赠的衣裙，确实曾是她的最爱之物。"
  },
  Skill_4429_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4429_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4429_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。泰旖丝获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4429_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。泰旖丝获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4429_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4429_EffectNameList_3 = {
    Text = "伤害,狂气"
  },
  Skill_4429_Name = {Text = "打击"},
  Skill_4429_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4429_PropertyNameList_3 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4430_Desc = {
    Text = "将 3 张「哭喊」置入手中，<VulnerabilityIconKeywords:易伤>对方 1 回合，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4430_Name = {
    Text = "灼燃蜡滴之欲"
  },
  Skill_4431_Desc = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_80:「窒息」>置入对方手牌。"
  },
  Skill_4431_Name = {
    Text = "溺毙之怨"
  },
  Skill_4432_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次。获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4432_Name = {
    Text = "恣睢之浪"
  },
  Skill_4433_Desc = {
    Text = "选择一名唤醒体，获得 70 狂气。"
  },
  Skill_4433_Name = {
    Text = "遗影回响"
  },
  Skill_4434_AwakerSkillBackgroundStory = {
    Text = "她战斗的目的从来不是伤害，而是保护。"
  },
  Skill_4434_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4434_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。艾尔瓦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4434_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4434_Name = {Text = "防御"},
  Skill_4434_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4435_Desc = {
    Text = "将 2 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入对方抽牌堆，全体获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4435_Name = {
    Text = "隆重的接待"
  },
  Skill_4436_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4436_Name = {Text = "出血"},
  Skill_4437_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并获得 [Arg5] 点护盾，本回合每抽 1 张牌，额外再获得 [Arg4] 点护盾。"
  },
  Skill_4437_Name = {
    Text = "隐匿突袭"
  },
  Skill_4438_AwakerSkillBackgroundStory = {
    Text = "指令：防御。阻挡。"
  },
  Skill_4438_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4438_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，莉莉每有 1% 死亡抵抗，基础护盾提高 0.25%。莉莉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4438_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4438_Name = {Text = "防御"},
  Skill_4438_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层的<MadnessIconKeywords:疯狂>。"
  },
  Skill_4440_Desc = {
    Text = "获得[Arg1] 点<PowerIconKeywords:力量>，吞噬敌人，跳过其下回合抽牌并造成无法抵抗的封印，但将维度裂隙的卡牌加入手中。"
  },
  Skill_4440_Name = {
    Text = "现世撕裂"
  },
  Skill_44411_Desc = {
    Text = "召唤 7 个「孳乳·努比亚幼崽」，隐匿自身，无法受到攻击，所有敌人死亡后隐匿解除。"
  },
  Skill_44411_Name = {
    Text = "万千子嗣之母"
  },
  Skill_44412_Desc = {
    Text = "施加 [Arg1] 回合<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤>、<FragileIconKeywords:脆弱>。封印所有唤醒体 1 回合，造成 [Arg2] 点<IntoxicationIconKeywords:中毒>，使卡组中 3 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_44412_Name = {
    Text = "毒腺哺乳"
  },
  Skill_4441_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4442_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4442_Name = {Text = "捶打"},
  Skill_4443_AwakerSkillBackgroundStory = {
    Text = "她曾经从巅峰高高坠下，往日的荣耀化作今朝的耻辱。\n被驱逐出掌政官夫人的庭院后，希洛沦为无数希洛奴隶中的平凡无奇的一员，任凭斯巴达狱卒蹂躏。在那样的绝境中，她却从未陷入懊丧与萎靡。\n在她的胸腔中熊熊燃烧的，唯有绵延不息的仇恨。\n脖颈的尖刺锁链被无情撕碎，束缚其中的力量得以释放，真实的面貌即将展露。\n从今往后，请日日洗净颈项，静待我的复仇吧。"
  },
  Skill_4443_Desc = {
    Text = "【<DevouredIconKeywords:吞噬>：抽 [Arg1] 张「打击」，临时手牌上限 +2，使希洛的「打击」基础伤害在本场战斗中提高 [Arg3]%。】驱散自身<WeaknessIconKeywords:虚弱>和非永久<PowerIconKeywords:力量>降低状态，在本回合中「打击」造成的最终伤害提高 [Arg2]%，希洛造成的伤害提高 [Arg4]%。"
  },
  Skill_4443_EffectNameList = {
    Text = "打击伤害提高"
  },
  Skill_4443_Name = {
    Text = "绝境求生"
  },
  Skill_4443_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：抽 [Arg1] 张「打击」，临时手牌上限 +2，使希洛的「打击」基础伤害在本场战斗中提高 [Arg3]%。】驱散自身<WeaknessIconKeywords:虚弱>和非永久<PowerIconKeywords:力量>降低状态，在本回合中「打击」造成的最终伤害提高 [Arg2]%，希洛造成的伤害提高 [Arg4]%。临时手牌上限 +2，并将 2 张「不规则形态」置入手中，希洛暴击伤害 +[Arg5]%。"
  },
  Skill_4443_PropertyNameList = {
    Text = "$GrowValue1%"
  },
  Skill_4444_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，召唤三只潘狄娅的奴隶。"
  },
  Skill_4444_Name = {
    Text = "蜜糖色悲惨幻象"
  },
  Skill_44452_Desc = {
    Text = "回复 [Arg1]% 点生命([Arg2])并获得等量的护盾，生命越低，该效果越高，最多回复 20% 生命。"
  },
  Skill_44452_Name = {
    Text = "亚兰祷言"
  },
  Skill_44453_Desc = {
    Text = "获得一张「神圣子嗣」：选择手中 1 张非衍生指令卡，获得其算力为 0 的原始复制，附加<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_44453_Name = {
    Text = "神圣子嗣"
  },
  Skill_44454_Desc = {
    Text = "使一名唤醒体获得 100 点狂气，并解除其封印状态。"
  },
  Skill_44454_Name = {
    Text = "奔涌树汁"
  },
  Skill_4445_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层<ParcloseIconKeywords:屏障>，前进。"
  },
  Skill_44462_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_44462_Name = {
    Text = "狂乱之咬"
  },
  Skill_44463_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44463_Name = {
    Text = "嗜血之爪"
  },
  Skill_44472_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，剩余生命越低，护盾与狂气效果越高。"
  },
  Skill_44472_Name = {
    Text = "主教的奉献"
  },
  Skill_4447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4447_Name = {
    Text = "割喉挥砍"
  },
  Skill_44486_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，所有唤醒体获得 <Energy:[Energy:Arg2]> 点狂气，剩余生命越低，护盾与狂气效果越高。"
  },
  Skill_44486_Name = {
    Text = "主教的奉献"
  },
  Skill_4448_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！！！"
  },
  Skill_4448_Name = {
    Text = "颅骨猛击"
  },
  Skill_4449_Desc = {
    Text = "将 2 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入抽牌堆。"
  },
  Skill_4449_Name = {Text = "蜡油"},
  Skill_4450_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>洗入抽牌堆。"
  },
  Skill_4451_Desc = {
    Text = "向狂气最高唤醒体施加 1 层临时封印，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_4451_Name = {Text = "封印"},
  Skill_4452_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4452_Name = {
    Text = "残次品的怨念"
  },
  Skill_4453_Desc = {
    Text = "获得<Block:[Block:Arg1]> 点护盾，自身获得 [Arg2] 层「蜡质铠甲」：每层使受到的伤害降低 [Arg3]，每次被暴击后减少 1 层。"
  },
  Skill_4453_Name = {
    Text = "蜡像登场"
  },
  Skill_4454_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次和施加等量伤害的<BleedingIconKeywords:出血>，受到 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4454_Name = {
    Text = "斩首重创"
  },
  Skill_4455_AwakerSkillBackgroundStory = {
    Text = "她现在知晓了，那些笔挺的制服和崭新的兵器下的真相。\n所谓的帮助，不过是压迫的伪装；所谓的征服，不过是侵略的旗号。\n她高举武器，光明之星的五角由正义、公正、守护、解放和真实点亮，将不公的阴影彻底驱散。"
  },
  Skill_4455_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。"
  },
  Skill_4455_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量 +1 的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。"
  },
  Skill_4455_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量 +1 的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。艾尔瓦获得 50％ 临时暴击率和暴击伤害。"
  },
  Skill_4455_EffectNameList = {Text = "护盾"},
  Skill_4455_Name = {
    Text = "无止境的正义"
  },
  Skill_4455_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。将 1 张附加消耗的「临战体势」与「心眼利刃」置入手中。本场战斗的暴击伤害 +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量 +1 的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。将 1 张附加消耗的「临战体势」与「心眼利刃」置入手中。本场战斗的暴击伤害 +25%。"
  },
  Skill_4455_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弃掉手牌中所有的状态卡和症状卡，并抽取等同于弃掉数量 +1 的卡牌。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。将 1 张附加消耗的「临战体势」与「心眼利刃」置入手中。艾尔瓦获得 50％ 临时暴击率和暴击伤害，本场战斗的暴击伤害 +25%。"
  },
  Skill_4455_PropertyNameList = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。基础攻击 10 次，直到回合结束前，玩家每拥有 1 张手牌，攻击次数就减少 1，最低为 3。"
  },
  Skill_4456_Name = {
    Text = "群蛇撕裂"
  },
  Skill_44573_Desc = {
    Text = "这张卡的卡面会发光！"
  },
  Skill_44573_Name = {
    Text = "禁用效果"
  },
  Skill_44574_Desc = {
    Text = "这张卡的卡面会发光！"
  },
  Skill_44574_Name = {
    Text = "变化效果"
  },
  Skill_4457_AwakerSkillBackgroundStory = {
    Text = "不需要惧怕肆虐的风雨，她将会予以你们守护。"
  },
  Skill_4457_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4457_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。希莱斯特获得 <Energy:[Energy:Arg2]> 点狂气。激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4457_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4457_Name = {Text = "防御"},
  Skill_4457_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4458_AwakerSkillBackgroundStory = {
    Text = "他骄傲地展示身上的伤痕，深的来自战场上的厮杀，浅的来自平日的训练与切磋。\n这些是英雄的证明，是他的骄傲。\n但不要询问他颈部的疤痕，这是他力量的开始，也是他耻辱的源泉。"
  },
  Skill_4458_Desc_0 = {
    Text = "戈利亚获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，戈利亚造成伤害时，获得 [Power:Arg2] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3] 点 <TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_4458_Desc_15 = {
    Text = "戈利亚获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，戈利亚造成伤害时，获得 [Power:Arg2] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3] 点 <TentacleInjurieIconKeywords:触腕伤害>。戈利亚在怒涛姿态下额外享受 [Arg4]％ 力量加成。"
  },
  Skill_4458_EffectNameList = {
    Text = "狂气,力量,触腕伤害"
  },
  Skill_4458_Name = {
    Text = "复仇预行"
  },
  Skill_4458_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张<DerivativeCardKeywords_3:「惊厥」>洗入对方抽牌堆，"
  },
  Skill_4459_Name = {Text = "惊厥"},
  Skill_4460_AwakerSkillBackgroundStory = {
    Text = "父神降临在他的梦中，对他降下指引：\n\n「当天空被日月平分之时，独自前往森林，朝东边行进五百又五百步。黑暗中的温暖处，埋着我最后的骨。\n\n拿去吧，我的代行者，但需要牢记。血肉的需血肉偿还，生命的需生命填补。」\n\n他掘出了篆刻了神秘符文的石板，向它们献上自己的骨血，为那些受苦的换取一丝希望。"
  },
  Skill_4460_Desc_0 = {
    Text = "<WeaknessIconKeywords:虚弱>所有敌人 1 回合。<EmbryoFusionIconKeywords:胚胎融合> +[Arg1]。积攒 <Heal:[Heal:Arg2]> 点猩红熔炉回复量。"
  },
  Skill_4460_Desc_2 = {
    Text = "<WeaknessIconKeywords:虚弱>所有敌人 1 回合。<EmbryoFusionIconKeywords:胚胎融合> +[Arg1]。积攒 <Heal:[Heal:Arg2]> 点猩红熔炉回复量，战斗中每经过 1 回合，额外积攒 [Arg3] 点。"
  },
  Skill_4460_EffectNameList_0 = {
    Text = "胚胎融合,猩红熔炉积攒量"
  },
  Skill_4460_EffectNameList_2 = {
    Text = "胚胎融合,猩红熔炉积攒量,猩红熔炉增长"
  },
  Skill_4460_Name = {
    Text = "受祝骨血"
  },
  Skill_4460_PropertyNameList_0 = {
    Text = "$GrowValue1,体质*GrowValue2"
  },
  Skill_4460_PropertyNameList_2 = {
    Text = "$GrowValue1,体质*GrowValue2,体质*GrowValue3"
  },
  Skill_44612_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_44612_Name = {Text = "撕咬"},
  Skill_4461_Desc = {
    Text = "全体获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4461_Name = {
    Text = "全体力量"
  },
  Skill_4462_Desc = {
    Text = "将 2 张<DerivativeCardKeywords_9:「蹒跚」>分别洗入对方抽牌堆和弃牌堆，"
  },
  Skill_4462_Name = {Text = "明灭"},
  Skill_4463_AwakerSkillBackgroundStory = {
    Text = "融蚀现象平等地对待所有人，唤醒体也不例外。为了拖延消亡的时间，朵尔将所有知识、意识和情绪都存入了外置器官中。\n「聪明的大脑」——为朵尔量身打造的赞美之词。"
  },
  Skill_4463_Desc_0 = {
    Text = "朵尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：朵尔造成回复时，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4463_Desc_15 = {
    Text = "朵尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：朵尔造成回复时，获得 <Block:[Block:Arg2]> 点护盾，朵尔的「打击」和「防御」也能触发获得护盾效果。"
  },
  Skill_4463_EffectNameList = {
    Text = "狂气,防御"
  },
  Skill_4463_Name = {
    Text = "灵肉两分"
  },
  Skill_4463_PropertyNameList = {
    Text = "$GrowValue1,防御力*GrowValue2"
  },
  Skill_4464_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4464_Name = {Text = "出血"},
  Skill_4465_Desc = {
    Text = "每回合获得[Arg1]点<PowerIconKeywords:力量>。"
  },
  Skill_4465_Name = {
    Text = "远古的呼唤"
  },
  Skill_4466_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44674_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并施加 2 回合的「撕裂」、「创伤」、<BlindingKeywords:致盲> 。"
  },
  Skill_44674_Name = {
    Text = "「癫狂撕咬」"
  },
  Skill_44675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，玩家每打出 1 张牌都会切换该意图的追加效果。追加效果会在重击、回复、弱化之间按序切换。"
  },
  Skill_44675_Name = {
    Text = "「失序撕咬」"
  },
  Skill_44676_Desc = {
    Text = "获得 [Arg2] 点<PowerIconKeywords:力量>和 [Arg1] 点护盾，将 3 张随机症状洗入抽牌堆。"
  },
  Skill_44676_Name = {
    Text = "「镜中判决」"
  },
  Skill_44677_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44677_Name = {Text = "爪击"},
  Skill_44678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张「狂放」加入手牌堆。"
  },
  Skill_44678_Name = {Text = "惩戒"},
  Skill_44679_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>。玩家每打出 1 张牌都会切换该意图的追加效果。追加效果会在反击、净化、植入之间按序切换。"
  },
  Skill_44679_Name = {
    Text = "「镜中审视」"
  },
  Skill_4467_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4467_Name = {Text = "渔叉"},
  Skill_44680_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合「撕裂」与「创伤」。"
  },
  Skill_44680_Name = {Text = "罚罪"},
  Skill_44681_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_44681_Name = {Text = "撕咬"},
  Skill_44682_Desc = {
    Text = "获得 [Arg1] 点临时力量， 所有敌人获得 [Arg2] 点临时力量，将其销毁。战斗结束后仍会保存在牌库中。"
  },
  Skill_44682_Name = {Text = "狂放"},
  Skill_44683_Desc = {
    Text = "获得 1 层疯狂，将 1 张「狂放」加入手牌堆。狂放：算力消耗 1。战斗结束后仍会保存在牌库中，打出后所有单位均获得临时力量并将其销毁。"
  },
  Skill_44683_Name = {
    Text = "以牙还牙"
  },
  Skill_4468_Desc = {
    Text = "召唤「脓疱」。"
  },
  Skill_4468_Name = {
    Text = "黑沼禁域"
  },
  Skill_44691_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44691_Name = {
    Text = "暗巷劫道"
  },
  Skill_44692_Desc = {
    Text = "前排获得 3 层<ParcloseIconKeywords:屏障>，获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_44692_Name = {
    Text = "隐于黑暗"
  },
  Skill_44693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，造成「撕裂」1 回合。撕裂：打出「防御」时，在抽牌堆顶部添加  1 张<DerivativeCardKeywords_23:「伤口」>。"
  },
  Skill_44693_Name = {
    Text = "雨夜屠戮"
  },
  Skill_44694_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_44694_Name = {
    Text = "犯罪预告"
  },
  Skill_44695_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合「创伤」。创伤：打出「打击」后，在抽牌堆顶部添加 1  张<DerivativeCardKeywords_23:「伤口」>。"
  },
  Skill_44695_Name = {
    Text = "倒打一耙"
  },
  Skill_44696_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张 <DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆。"
  },
  Skill_44696_Name = {Text = "拐卖"},
  Skill_44697_Desc = {
    Text = "施加 1 回合<BlindingKeywords:致盲>。"
  },
  Skill_44697_Name = {Text = "扬尘"},
  Skill_44698_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44698_Name = {Text = "清扫"},
  Skill_44699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_44699_Name = {Text = "敲竹杠"},
  Skill_4469_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4469_Name = {
    Text = "绵长恨怨"
  },
  Skill_4470_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4470_Name = {
    Text = "布朗出动！"
  },
  Skill_4471_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4471_Name = {
    Text = "神眷之刃"
  },
  Skill_44722_AwakerSkillBackgroundStory = {
    Text = "父神万千神言中的一句，讲述了父神的原初之血对生命的守护。"
  },
  Skill_44722_BattleDesc = {
    Text = "以血施救。造成伤害后，失去 10% 当前生命([Arg1])，积攒与失去生命等量的猩红熔炉回复量(<Heal:[Heal:Arg2]>)。"
  },
  Skill_44722_Desc = {
    Text = "以血施救。造成伤害后，失去 10% 当前生命，积攒与失去生命等量的猩红熔炉回复量。"
  },
  Skill_44722_Name = {Text = "奉献"},
  Skill_44723_AwakerSkillBackgroundStory = {
    Text = "父神万千神言中的一句，讲述了父神原初的躯体对生命的滋养。"
  },
  Skill_44723_BattleDesc = {
    Text = "以苦消苦。消耗所有猩红熔炉剩余的回复量，每消耗 1 点就使伤害提高 3 点，若为首领战，则改为每消耗 1 点伤害提高 9 点。每消耗 1％ 最大生命的猩红熔炉就提高 [Arg5]% 最终伤害。总计造成 <Damage:[Damage:Arg4]> 点伤害。"
  },
  Skill_44723_Desc = {
    Text = "以苦消苦。消耗所有猩红熔炉剩余的回复量，每消耗 1 点就使伤害提高 3 点，若为首领战，则改为每消耗 1 点伤害提高 9 点。每消耗 1％ 最大生命的猩红熔炉就提高 [Arg5]% 最终伤害。"
  },
  Skill_44723_EffectNameList = {
    Text = "伤害,伤害加成"
  },
  Skill_44723_Name = {Text = "超度"},
  Skill_44723_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2%"
  },
  Skill_44723_tempBattleDesc_1 = {
    Text = "以苦消苦。消耗所有猩红熔炉剩余的回复量，每消耗 1 点就使伤害提高 3 点，若为首领战，则改为每消耗 1 点伤害提高 9 点。每消耗 1％ 最大生命的猩红熔炉就提高 [Arg5]% 最终伤害。总计造成 <Damage:[Damage:Arg4]> 点伤害。"
  },
  Skill_4472_Desc = {
    Text = "封印四个唤醒体的狂气爆发 1 回合。"
  },
  Skill_4472_Name = {Text = "封印"},
  Skill_44735_Desc = {
    Text = "塔薇复活效果测试"
  },
  Skill_44735_Name = {
    Text = "塔薇效果测试"
  },
  Skill_4473_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加 [Arg3] 层寄生。"
  },
  Skill_4473_Name = {
    Text = "附骨侵蚀"
  },
  Skill_4474_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4475_Desc = {
    Text = "施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4475_Name = {Text = "毒素"},
  Skill_44765_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，解除自身负面状态。打出卡牌后，追加效果将切换为植入。"
  },
  Skill_44765_Name = {
    Text = "「镜中审视」净化"
  },
  Skill_44766_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，额外获得 [Arg3] 点临时反击。打出卡牌后，追加效果将切换为净化。"
  },
  Skill_44766_Name = {
    Text = "「镜中审视」反击"
  },
  Skill_44767_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，洗入 2 张「狂放」到抽牌堆。打出卡牌后，追加效果将切换为反击。"
  },
  Skill_44767_Name = {
    Text = "「镜中审视」植入"
  },
  Skill_4476_AwakerSkillBackgroundStory = {
    Text = "他们先是叫她圣女，将她束缚在了桅杆之上；他们后来喊她废物，并将她扔进牢笼。\n他们似乎忘记了，她无法决定生死，只能指引航船的方向。"
  },
  Skill_4476_Desc_0 = {
    Text = "希莱斯特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，希莱斯特造成的生命回复提高 15%，回复生命时，临时<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_4476_Desc_15 = {
    Text = "希莱斯特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，希莱斯特造成的生命回复提高 15%，回复生命时，临时<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。触发「不死的极乐鸟」复活时，临时<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]，首领战效果翻倍。"
  },
  Skill_4476_EffectNameList = {
    Text = "狂气,临时触腕伤害"
  },
  Skill_4476_Name = {
    Text = "庇佑之力"
  },
  Skill_4476_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 2 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4477_Name = {
    Text = "双重啃咬"
  },
  Skill_44786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 2 回合的 <WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。打出卡牌后，追加效果将切换为重击。"
  },
  Skill_44786_Name = {
    Text = "「失序撕咬」弱化"
  },
  Skill_44787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复 [Arg3] 点生命。打出卡牌后，追加效果将切换为弱化。"
  },
  Skill_44787_Name = {
    Text = "「失序撕咬」回复"
  },
  Skill_44788_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，打出卡牌后，追加效果将切换为回复。"
  },
  Skill_44788_Name = {
    Text = "「失序撕咬」重击"
  },
  Skill_4478_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4479_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_44817_AwakerSkillBackgroundStory = {
    Text = "「我是造主的代行者，我借祂的力量，以祂的名义，要为你们消除一切苦楚。」"
  },
  Skill_44817_Desc = {
    Text = "获得 [Arg1] 层临时<ParcloseIconKeywords:屏障>，<EmbryoFusionIconKeywords:胚胎融合> +[Arg2]。"
  },
  Skill_44817_Name = {
    Text = "护以仁爱"
  },
  Skill_4481_AwakerSkillBackgroundStory = {
    Text = "他们是美，是欢愉，是柔软的砖墙。\n年轻的肉体以不可思议的姿势扭曲着，层层叠叠，直达天际。\n嘘——别哭，保持微笑。像无数个夏夜里你曾对女王做的那样。"
  },
  Skill_4481_Desc_0 = {
    Text = "旺达获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 5 层<DreamGuide:梦引>。回合开始后获得 1 层<DreamGuide:梦引>。每当获得<DreamGuide:梦引>使其达到 5 或 10 层时，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4481_Desc_15 = {
    Text = "旺达获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 5 层<DreamGuide:梦引>。回合开始后获得 1 层<DreamGuide:梦引>。每当获得<DreamGuide:梦引>使其达到 5 或 10 层时，获得 <Block:[Block:Arg2]> 点护盾。旺达释放狂气爆发后自身下 2 张指令卡额外生效 1 次。"
  },
  Skill_4481_EffectNameList = {
    Text = "狂气,护盾"
  },
  Skill_4481_Name = {
    Text = "活尸梦呓"
  },
  Skill_4481_PropertyNameList = {
    Text = "$GrowValue1,防御力*GrowValue2"
  },
  Skill_4482_Desc = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入抽牌堆。"
  },
  Skill_4482_Name = {Text = "蜡油"},
  Skill_4483_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4483_Name = {Text = "撕咬"},
  Skill_4484_Desc = {
    Text = "召唤守护娃娃。"
  },
  Skill_4484_Name = {
    Text = "召唤和强化"
  },
  Skill_4486_Desc = {
    Text = "获得 [Arg1] 护盾，护盾消失时，剩余护盾转化为2倍生命值。"
  },
  Skill_4486_Name = {
    Text = "不灭之花"
  },
  Skill_4487_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4488_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4489_Desc = {
    Text = "全体获得 <Block:[Block:Arg1]> 点护盾，自身获得[Arg2] 点<PowerIconKeywords:力量>."
  },
  Skill_4490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4491_Desc = {
    Text = "牺牲自身祈求融蚀的赐福。"
  },
  Skill_4491_Name = {Text = "牺牲"},
  Skill_4492_AwakerSkillBackgroundStory = {
    Text = "晚风会带来故土的钟鸣，星光会照亮归乡的道路。\n过往的职责，成为了她的执念。\n她愿以生命为薪柴，点燃永恒的灯火。"
  },
  Skill_4492_Desc_0 = {
    Text = "法洛思获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕。每打出法洛思的 1 张牌，抽 [Arg2] 张牌，触发所有敌人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果， 每回合最多生效 3 次。"
  },
  Skill_4492_Desc_15 = {
    Text = "法洛思获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕。每打出法洛思的 1 张牌，抽 [Arg2] 张牌，触发所有敌人 [Arg3]% 的<IntoxicationIconKeywords:中毒>效果，并使本回合触腕造成伤害时，额外造成等同于伤害 5％ 的<IntoxicationIconKeywords:中毒>，每回合最多生效 3 次。"
  },
  Skill_4492_EffectNameList = {Text = "狂气"},
  Skill_4492_Name = {
    Text = "湮塞的执念"
  },
  Skill_4492_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4493_Desc = {
    Text = "某种奇特的精神体验。"
  },
  Skill_4493_Name = {Text = "幻觉"},
  Skill_4494_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，弃掉对方所有的手牌。"
  },
  Skill_4494_Name = {Text = "离散"},
  Skill_4495_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4496_BattleDesc = {
    Text = "失去 [Arg1] 点生命，抽 2 张牌。无法出售。"
  },
  Skill_4496_Desc = {
    Text = "失去 10% 最大生命，抽 2 张牌。无法出售。"
  },
  Skill_4496_Name = {
    Text = "症状：癫痫"
  },
  Skill_4497_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4498_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4499_Desc = {
    Text = "将所有唤醒体各 1 张算力消耗为 0 的「打击」置入手中，并附加<DepleteIconKeywords:消耗>。将手中所有唤醒体的卡牌更换为算力消耗为 0 的「打击」，直到回合结束。"
  },
  Skill_4499_Name = {
    Text = "美丽瞬间"
  },
  Skill_45007_AwakerSkillBackgroundStory = {
    Text = "父神万千神言中的一句，讲述了父神原初的躯体对生命的滋养。"
  },
  Skill_45007_BattleDesc = {
    Text = "以信济世。消耗所有猩红熔炉剩余的回复量，获得 150% 消耗量的护盾([Arg1])，该护盾不受护盾加成和减益影响，但无视护盾上限。"
  },
  Skill_45007_Desc = {
    Text = "以信济世。消耗所有猩红熔炉剩余的回复量，获得 150% 消耗量的护盾，该护盾不受护盾加成和减益影响，但无视护盾上限。"
  },
  Skill_45007_Name = {Text = "救赎"},
  Skill_45019_Desc_1 = {
    Text = "使一名目标获得 <DisarmKeywords:麻痹>。"
  },
  Skill_45019_Name_1 = {Text = "麻痹"},
  Skill_4501_AwakerSkillBackgroundStory = {
    Text = "为了保护易碎的外置器官，朵尔在玻璃缸中集成了「力场发生器」。\n她向学生们解释时，仍保持着面无表情，大家也分不清朵尔教授是不是又在开玩笑了。\n真是可怕的幽默感。"
  },
  Skill_4501_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4501_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。朵尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4501_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4501_Name = {Text = "防御"},
  Skill_4501_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4502_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4502_Name = {
    Text = "石质分解"
  },
  Skill_4504_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45051_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45051_Name_1 = {Text = "屏障"},
  Skill_4505_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，将 3 张<DerivativeCardKeywords_35:「巨人之畏」>洗入抽牌堆。"
  },
  Skill_4505_Name = {
    Text = "海渊之力"
  },
  Skill_45063_Desc_1 = {
    Text = "给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45063_Name_1 = {
    Text = "华丽光景"
  },
  Skill_4506_AwakerSkillBackgroundStory = {
    Text = "那是无垠的原质之海，传说星球上一切有机物都由此诞生。\n灰色的汪洋中漂浮着无限的面庞，饱含欢笑或是悲悯。"
  },
  Skill_4506_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg4] 倍力量加成。创造 1 张自定义的「千面幻象」将其置入手牌，若当前非超维回合且<DimensionalSpaceIconKeywords:超维空间>没有「千面幻象」，将其复制置入<DimensionalSpaceIconKeywords:超维空间>并视为触发了 1 次<SingularityKeywords3:维度穿梭>，否则将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  Skill_4506_EffectNameList = {Text = "伤害"},
  Skill_4506_Name = {
    Text = "原质之海"
  },
  Skill_4506_OverLimitUtlSkillDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg4] 倍力量加成。创造 1 张自定义的「千面幻象」将其置入手牌，若当前非超维回合且<DimensionalSpaceIconKeywords:超维空间>没有「千面幻象」，将其复制置入<DimensionalSpaceIconKeywords:超维空间>并视为触发了 1 次<SingularityKeywords3:维度穿梭>，否则将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中。额外将「千面幻象」的 [Arg2] 张复制置入手中，「断颈一击」本场战斗中基础伤害提高 [Arg3]%。"
  },
  Skill_4506_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_45079_Desc_1 = {
    Text = "使一名目标获得 <PVPSeriousInjuryKeywords:重创>。"
  },
  Skill_45079_Name_1 = {Text = "重伤"},
  Skill_4507_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4507_Name = {Text = "撕咬"},
  Skill_4508_Desc = {
    Text = "回合开始时随机变形为抽牌堆中一张指令卡的复制，其算力消耗固定为 3，回合结束时变回。无法打出。"
  },
  Skill_4508_Name = {
    Text = "症状：谵妄"
  },
  Skill_4509_AwakerSkillBackgroundStory = {
    Text = "除了最古老的混沌外，没有东西能让海水与火焰融合交织。\n你大可去找，去印证。去追寻沙漠尖塔，去寻找海底迷城，去攀越无垠群山。\n我向你保证，没有东西比萝坦更加古老。"
  },
  Skill_4509_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4509_BattleDesc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。视为「打击」。"
  },
  Skill_4509_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4509_Desc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。视为「打击」。"
  },
  Skill_4509_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_4509_Name = {
    Text = "恣睢之浪"
  },
  Skill_4509_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4510_Desc = {
    Text = "抽到时，本回合内所有唤醒体获取狂气降低 50%。"
  },
  Skill_4510_Name = {Text = "空虚"},
  Skill_4511_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_4512_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_4512_Name = {Text = "深潜"},
  Skill_4514_Desc = {
    Text = "对敌人施加 1 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4514_Name = {Text = "深土坑"},
  Skill_4515_AwakerSkillBackgroundStory = {
    Text = "只此一击。\n夺去凌虐者的性命、夺去背叛者的性命、夺去妄为者的性命、夺去侵略者的性命。\n不必多言，以这蕴含着浓黑恨意的利刺，宣誓她的选择与觉悟。"
  },
  Skill_4515_BattleDesc = {
    Text = "视为「打击」。造成 <Damage:[Damage:Arg1]> 点伤害。手牌中每有 1 张其他「打击」，使基础伤害提高 [Arg3]%，额外享受 1 倍力量加成。弃掉所有「打击」。"
  },
  Skill_4515_Desc = {
    Text = "视为「打击」。造成 <Damage:[Damage:Arg1]> 点伤害。手牌中每有 1 张其他「打击」，使基础伤害提高 [Arg3]%，额外享受 1 倍力量加成。弃掉所有「打击」。"
  },
  Skill_4515_EffectNameList = {Text = "伤害"},
  Skill_4515_Name = {
    Text = "破链一击"
  },
  Skill_4515_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4516_AwakerSkillBackgroundStory = {
    Text = "「耻辱……耻辱……」\n女孩瑟缩在厨房角落，尚来不及擦干嘴角的一抹血渍。\n她承受着来自至亲的指控，却无力辩解。\n自那天起，女孩便丢失了自己的姓名。\n她消失在世人跟前，就像一滴水汇入不断奔涌的流言之河。"
  },
  Skill_4516_Desc_0 = {
    Text = "雷娅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：雷娅打出卡牌后， <EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。"
  },
  Skill_4516_Desc_15 = {
    Text = "雷娅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：雷娅打出卡牌后， <EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]，并使下次狂气爆发得到强化：获得等同于 [Arg3]％ 永久力量的临时力量，最多堆叠 [Arg4] 次。"
  },
  Skill_4516_EffectNameList = {
    Text = "狂气,胚胎融合"
  },
  Skill_4516_Name = {Text = "渴血者"},
  Skill_4516_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2"
  },
  Skill_4517_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4517_Name = {
    Text = "猎矛突刺"
  },
  Skill_4518_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4518_Name = {
    Text = "创口撕扯"
  },
  Skill_4519_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并封印所有唤醒体 1 回合。"
  },
  Skill_4519_Name = {
    Text = "「为▼▼降临扫除▼▼」"
  },
  Skill_4520_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害减少一层，回合结束失去全部。"
  },
  Skill_4520_Name = {Text = "祈祷"},
  Skill_4521_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，手牌堆所有卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」，并将 1 张「渐渐石化」加入对方手牌。"
  },
  Skill_4521_Name = {
    Text = "真·万古之眸"
  },
  Skill_4522_Desc = {
    Text = "获得 [Arg2] 点护盾和 [Arg1] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_4522_Name = {
    Text = "承自异端之血"
  },
  Skill_4523_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4524_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45251_Desc_1 = {
    Text = "还原全体友方的生命至上回合开始时，但还原后生命最多不超过 [Arg1]% ，<ReduceEffectKeywords:强效降低> [Arg2]，狂气减半。<PVPRaidKeywords:突袭>：还原后生命最多不超过 [Arg3]%。"
  },
  Skill_45251_Name_1 = {
    Text = "跨越回溯之扉"
  },
  Skill_45251_UnknownName = {
    Text = "跨越回溯之扉"
  },
  Skill_45252_Desc_1 = {
    Text = "将 [Arg1] 张其他随机「钥令」洗入抽牌堆，在抽到手牌以前你不知道它是什么。"
  },
  Skill_45252_Name_1 = {
    Text = "奥瑞塔的宝藏"
  },
  Skill_45252_UnknownName = {
    Text = "奥瑞塔的宝藏"
  },
  Skill_45253_Desc_1 = {
    Text = "选择一名敌方造成<PVPEmptinessKeywords:空虚>，将目标的 [Arg1] 狂气转换为等量<DelayKeywords:延迟 2>：狂气。"
  },
  Skill_45253_Name_1 = {Text = "海之祭"},
  Skill_45253_UnknownName = {Text = "海之祭"},
  Skill_45254_Name_1 = {
    Text = "春天的献诗"
  },
  Skill_45254_UnknownName = {
    Text = "春天的献诗"
  },
  Skill_45255_Desc_1 = {
    Text = "造成合计 <Damage:[Damage:Arg1]> 伤害，平均分配给所有敌方。"
  },
  Skill_45255_Name_1 = {
    Text = "全部的她"
  },
  Skill_45255_UnknownName = {
    Text = "全部的她"
  },
  Skill_45256_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」使本回合下一次「打击」改为随机目标并且额外攻击 [Arg1] 名随机目标。"
  },
  Skill_45256_Name_1 = {Text = "镜中人"},
  Skill_45257_Desc_1 = {
    Text = "<ReinforceKeywords:加固>一名友方，抽 [Arg1] 张牌。"
  },
  Skill_45257_Name_1 = {
    Text = "最后的誓言"
  },
  Skill_45257_UnknownName = {
    Text = "最后的誓言"
  },
  Skill_45258_BattleDesc_1 = {
    Text = "耗尽所有算力，每消耗算力和每拥有<PVPCapKeywords:算力上限>造成 [Arg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>伤害。"
  },
  Skill_45258_Desc_1 = {
    Text = "耗尽所有算力，每消耗算力和每拥有<PVPCapKeywords:算力上限>造成 [Arg1] <PVPBleedingKeywords:出血>。"
  },
  Skill_45258_Name_1 = {
    Text = "咆哮的血与沙"
  },
  Skill_45258_UnknownName = {
    Text = "咆哮的血与沙"
  },
  Skill_45259_Desc_1 = {
    Text = "选择一名友方获得 [Arg1] 层 <PVPProtectiveKeywords:屏障>，<PVPPowerIconKeywords:力量> +[Arg2]。"
  },
  Skill_45259_Name_1 = {
    Text = "玫瑰的胜利"
  },
  Skill_45259_UnknownName = {
    Text = "玫瑰的胜利"
  },
  Skill_4525_AwakerSkillBackgroundStory = {
    Text = "「啪！啪！啪！」挥起小皮鞭，抽打不服从命令的奴隶~"
  },
  Skill_4525_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4525_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并获得 50% 伤害的临时<RetaliateIconKeywords:反击>。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4525_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。潘狄娅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4525_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并获得 50% 伤害的临时<RetaliateIconKeywords:反击>。潘狄娅获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4525_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4525_Name = {Text = "打击"},
  Skill_4525_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_45260_Desc_1 = {
    Text = "选择一名友方，使其获得 <Block:[Block:Arg1]> 护盾并将其当前生命和护盾分摊给其他友方。若目标为唯一生存友方则改为获得<StrengthenKeywords:强化>和<ReinforceKeywords:加固>。"
  },
  Skill_45260_Name_1 = {
    Text = "腐烂盛筵"
  },
  Skill_45260_UnknownName = {
    Text = "腐烂盛筵"
  },
  Skill_45261_Desc_1 = {
    Text = "迫使目标弃掉所有手牌，若没有弃掉任何手牌，获得 [Arg2] 算力并抽 [Arg2] 张牌。"
  },
  Skill_45261_Name_1 = {
    Text = "巨人的霸道"
  },
  Skill_45261_UnknownName = {
    Text = "巨人的霸道"
  },
  Skill_45262_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得<TauntKeywords:嘲讽>与 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_45262_Name_1 = {
    Text = "35mm的魔法"
  },
  Skill_45263_Desc_1 = {
    Text = "抽 [Arg1] 张牌。"
  },
  Skill_45263_Name_1 = {
    Text = "仲夏之梦"
  },
  Skill_45263_UnknownName = {
    Text = "仲夏之梦"
  },
  Skill_45264_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：<StrengthenKeywords:强化>和<ReinforceKeywords:加固>自身并获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45264_Name_1 = {
    Text = "神迹降临"
  },
  Skill_45264_UnknownName = {
    Text = "神迹降临"
  },
  Skill_45265_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标，「打击」前<PVPRepelKeywords:击退>目标所有可驱散的正面状态到其身后唤醒体。"
  },
  Skill_45265_Name_1 = {
    Text = "深海的呼唤"
  },
  Skill_45266_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时以及「打击」后，将手牌中装备者的非衍生「技能」会按顺序变成装备者的其他「技能」。<PVPFlowerKeywords:往昔的花与诗>"
  },
  Skill_45266_Name_1 = {
    Text = "往昔的花与诗"
  },
  Skill_45267_Desc_1 = {
    Text = "使手中所有「技能」获得<PrepareKeywords:预备> ，基础算力消耗为 [Arg2] 的「技能」获得<PrepareKeywords:预备> [Arg3]。"
  },
  Skill_45267_Name_1 = {
    Text = "黑天鹅的舞步"
  },
  Skill_45267_UnknownName = {
    Text = "黑天鹅的舞步"
  },
  Skill_45268_Desc_1 = {
    Text = "为任意目标装备随机的「命轮」，若使用次数未耗尽则将此牌洗入对方抽牌堆"
  },
  Skill_45268_Name_1 = {
    Text = "一声枪响"
  },
  Skill_45268_UnknownName = {
    Text = "一声枪响"
  },
  Skill_45269_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> +[Arg1]。"
  },
  Skill_45269_Name_1 = {
    Text = "蚀骨的拥抱"
  },
  Skill_45269_UnknownName = {
    Text = "蚀骨的拥抱"
  },
  Skill_4526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_45270_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：回合结束时，变为打出的最后 1 张「技能」牌，使其算力消耗 -2，打出后将一张「灰雾真容」洗入抽牌堆。"
  },
  Skill_45270_Name_1 = {
    Text = "灰雾真容"
  },
  Skill_45270_UnknownName = {
    Text = "灰雾真容"
  },
  Skill_45271_Desc_1 = {
    Text = "造成 [Arg1] 伤害，<DisarmKeywords:麻痹>，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45271_Name_1 = {
    Text = "短暂的永恒"
  },
  Skill_45271_UnknownName = {
    Text = "短暂的永恒"
  },
  Skill_45272_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPEntanglementKeywords:缠绕>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45272_Name_1 = {
    Text = "湖畔回眸"
  },
  Skill_45272_UnknownName = {
    Text = "湖畔回眸"
  },
  Skill_45273_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每受到一次主动伤害使其他友方获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45273_Name_1 = {
    Text = "伊萨拉乌的目光"
  },
  Skill_45275_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 +[Arg1]，「狂气爆发」后使自身获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45275_Name_1 = {
    Text = "灼热的吻别"
  },
  Skill_4527_Desc = {
    Text = "获得 1 层<MadnessIconKeywords:疯狂>。使用症状卡时，潘迪娅的状态会在“焦躁”和“纵欲”之间变化。焦躁：攻击次数+1，<PowerIconKeywords:力量>减少。纵欲：攻击次数-1，<PowerIconKeywords:力量>增加"
  },
  Skill_4527_Name = {Text = "觉醒"},
  Skill_4528_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使扭曲死体狂宴伤害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_4528_Name = {
    Text = "纷乱切割"
  },
  Skill_4529_AwakerSkillBackgroundStory = {
    Text = "苦难是残酷的、是无情的。\n\n在消融一切的黑色死亡面前，哪怕耗尽生命，他也要保护世间的所有。"
  },
  Skill_4529_Desc_0 = {
    Text = "选择：<B02AFKeyWord2:奉献>、<B02AFKeyWord3:超度>或<B02AFKeyWord4:救赎>。获得 <Energy:[Energy:Arg5]> 点狂气。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，本场战斗中每积攒 1 点猩红熔炉的回复量，就使伤害提高 [Float:Arg2] 点。"
  },
  Skill_4529_Desc_2 = {
    Text = "选择：<B02AFKeyWord2:奉献>、<B02AFKeyWord3:超度>或<B02AFKeyWord4:救赎>。获得 <Energy:[Energy:Arg5]> 点狂气。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，本场战斗中每积攒 1 点猩红熔炉的回复量，就使伤害提高 [Float:Arg2] 点。本次伤害暴击率提高 [Arg4]%。"
  },
  Skill_4529_EffectNameList = {
    Text = "伤害,伤害加成,狂气"
  },
  Skill_4529_Name = {
    Text = "应消之苦"
  },
  Skill_4529_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3"
  },
  Skill_4530_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4530_Name = {Text = "刺击"},
  Skill_4531_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，抽牌堆顶的 [Arg3] 张卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4531_Name = {
    Text = "凝滞诅咒"
  },
  Skill_4532_Desc = {
    Text = "完成「神降仪式」，翻倍自身的生命和最大生命。造成 [Arg1] 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤> 状态，将 3 张「执念」洗入牌库。"
  },
  Skill_4532_Name = {
    Text = "神降仪式·降临"
  },
  Skill_4533_AwakerSkillBackgroundStory = {
    Text = "詹金也不是一开始就能理解布朗的。\n这样可不行，她想，这样布朗可没法吸引街上那些自命不凡的老爷们的注意，好让她从他们的口袋里搞来今天的晚餐。\n于是她借着提灯开始训练，并在多日的尝试后终于——\n「布朗，出动！」\n「吱！」"
  },
  Skill_4533_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中，「布朗出动！」造成的伤害提高 [Arg2] 点。<TransitionIconKeywords:跃迁>：该技能额外享受 1 倍力量加成。"
  },
  Skill_4533_Desc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中，「布朗出动！」造成的伤害提高 [Arg2] 点，「鼠群冲击」造成的伤害提高 [Arg3] 点。<TransitionIconKeywords:跃迁>：该技能额外享受 1 倍力量加成。"
  },
  Skill_4533_EffectNameList_0 = {
    Text = "伤害,伤害成长"
  },
  Skill_4533_EffectNameList_1 = {
    Text = "伤害,伤害成长,鼠群冲击伤害成长"
  },
  Skill_4533_Name = {
    Text = "布朗出动！"
  },
  Skill_4533_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4533_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4534_Desc = {
    Text = "召唤守护娃娃，自身获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4534_Name = {
    Text = "召唤和强化"
  },
  Skill_4535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_45367_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：给予一名友方 [Arg1] 张「打击」。"
  },
  Skill_45367_Name_1 = {
    Text = "不朽的葬仪"
  },
  Skill_45367_UnknownName = {
    Text = "不朽的葬仪"
  },
  Skill_4536_Desc = {
    Text = "你已经无法使用维度穿行逃脱了！……虽然你仍然能将此卡消耗，但这毫无意义。"
  },
  Skill_4536_Name = {
    Text = "被注视……！"
  },
  Skill_4537_Desc = {
    Text = "消耗手牌中所有的症状卡。每消耗 1 张就抽 1 张牌。仅能使用 1 次了……"
  },
  Skill_4537_Name = {
    Text = "维度穿行"
  },
  Skill_45383_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 临时<PowerColourKeywords:力量降低>。"
  },
  Skill_45383_Name_1 = {
    Text = "临时力量降低"
  },
  Skill_45384_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 临时<PowerColourKeywords:力量>。"
  },
  Skill_45384_Name_1 = {
    Text = "临时力量"
  },
  Skill_4538_Desc = {
    Text = "消耗手牌中所有的症状卡。每消耗 1 张就抽 1 张牌。还能使用 2 次。"
  },
  Skill_4538_Name = {
    Text = "维度穿行"
  },
  Skill_4539_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得<Flaw:破绽>：当回合内必定被暴击。"
  },
  Skill_4539_Name = {
    Text = "鼠群冲击"
  },
  Skill_4540_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害失去一层，失去全部时眩晕。"
  },
  Skill_4540_Name = {Text = "祈祷"},
  Skill_4541_AwakerSkillBackgroundStory = {
    Text = "午夜时分，静谧的流水，顺着病弱少女的指引，轻盈地送上充满柔情的冲击。"
  },
  Skill_4541_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4541_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。宁菲亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4541_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4541_Name = {Text = "打击"},
  Skill_4541_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4542_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，后撤。"
  },
  Skill_4543_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4544_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45453_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，目标每有 1 张手牌对其额外造成 1 次伤害，获得一半伤害的护盾，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45453_Name_1 = {
    Text = "珊瑚螺旋"
  },
  Skill_45454_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命，给予其 <Energy:[Energy:Arg2]> 狂气，对自身使用效果减半。"
  },
  Skill_45454_Name_1 = {
    Text = "丰穰之仪"
  },
  Skill_45455_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易伤>目标，并造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45455_Name_1 = {
    Text = "无形迁移"
  },
  Skill_45456_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，回复等同于伤害的生命，对受<PVPSeriousInjuryKeywords:重创>影响的目标使用时，回复翻倍生命。"
  },
  Skill_45456_Name_1 = {
    Text = "腺体重构"
  },
  Skill_45457_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，并使其<PVPMethysisKeywords:中毒>翻倍。"
  },
  Skill_45457_Name_1 = {
    Text = "自我的葬仪"
  },
  Skill_45458_Desc_1 = {
    Text = "使任意其他目标获得<PVPVulnerabilityIconKeywords:易伤>，<DelayKeywords:延迟 1>：获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45458_Name_1 = {
    Text = "享受疼痛"
  },
  Skill_45459_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45459_Name_1 = {Text = "打击"},
  Skill_4545_AwakerSkillBackgroundStory = {
    Text = "「我才不怕黑呢！这灯只是为了照明罢了。」"
  },
  Skill_4545_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4545_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。抽 2 张牌，若不是詹金的卡牌则将其丢弃。"
  },
  Skill_4545_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。詹金获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4545_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。詹金获得 <Energy:[Energy:Arg2]> 点狂气。抽 2 张牌，若不是詹金的卡牌则将其丢弃。"
  },
  Skill_4545_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4545_Name = {Text = "防御"},
  Skill_4545_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_45460_Desc_1 = {
    Text = "对任意其他目标造成 <Damage:[Damage:Arg1]> 伤害，使其获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45460_Name_1 = {
    Text = "无上的喜悦"
  },
  Skill_45461_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 [Arg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45461_Name_1 = {Text = "恨怨"},
  Skill_45462_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>敌方造成 <Damage:[Damage:Arg1]> 伤害。获得 [Arg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45462_Name_1 = {Text = "宣战"},
  Skill_45463_Desc_1 = {
    Text = "获得 [Arg1] 层<EnergyStorageKeywords:蓄力>，<PVPVulnerabilityIconKeywords:易伤>自身。"
  },
  Skill_45463_Name_1 = {
    Text = "恨意翻涌"
  },
  Skill_45464_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害并施加等量<PVPSacrificeKeyWords:献祭>。"
  },
  Skill_45464_Name_1 = {
    Text = "螺湮典仪"
  },
  Skill_45465_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾，触发全体敌方的<PVPSacrificeKeyWords:献祭>。"
  },
  Skill_45465_Name_1 = {
    Text = "死渊轮回"
  },
  Skill_45466_Desc_1 = {
    Text = "全体敌方扣除 <Energy:[Energy:Arg1]> 狂气，<PVPCapKeywords:算力上限> - [Arg2]。"
  },
  Skill_45466_Name_1 = {
    Text = "虚妄隆宠"
  },
  Skill_45467_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>，<PVPMethysisKeywords:中毒>，<PVPBleedingKeywords:出血>。"
  },
  Skill_45467_Name_1 = {
    Text = "三棱利刺"
  },
  Skill_45468_Desc_1 = {
    Text = "获得 [Arg1] 临时<PVPRetaliateIconKeywords:反击>，本回合下 [Arg3] 次「技能」后获得 1 层<EnergyStorageKeywords:蓄力>，回合结束前所有没用完的次数每次转换为回复 <Heal:[Heal:Arg4]> 生命。"
  },
  Skill_45468_Name_1 = {
    Text = "承自异端之血"
  },
  Skill_45469_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：<Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45469_Name_1 = {
    Text = "鼠群之王"
  },
  Skill_4546_AwakerSkillBackgroundStory = {
    Text = "詹金也不是一开始就能理解布朗的。\n这样可不行，她想，这样布朗可没法吸引街上那些自命不凡的老爷们的注意，好让她从他们的口袋里搞来今天的晚餐。\n于是她借着提灯开始训练，并在多日的尝试后终于——\n「布朗，出动！」\n「吱！」"
  },
  Skill_4546_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中，「布朗出动！」造成的伤害提高 [Arg2] 点。跃迁：改为对所有敌人造成伤害，但打出后<DepleteIconKeywords:消耗>。"
  },
  Skill_4546_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。在本场战斗中，「布朗出动！」造成的伤害提高 [Arg2] 点，「鼠群冲击」造成的伤害提高 [Arg3] 点。跃迁：改为对所有敌人造成伤害，但打出后<DepleteIconKeywords:消耗>。"
  },
  Skill_4546_EffectNameList_0 = {
    Text = "伤害,伤害成长"
  },
  Skill_4546_EffectNameList_1 = {
    Text = "伤害,伤害成长,鼠群冲击伤害成长"
  },
  Skill_4546_Name = {
    Text = "布朗出动！"
  },
  Skill_4546_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4546_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_45470_Desc_1 = {
    Text = "选择一种<PVPMouseKeywords:老鼠牌><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>，将其 [Arg1] 张复制置入手中。"
  },
  Skill_45470_Name_1 = {
    Text = "街头伙伴"
  },
  Skill_45471_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45471_Name_1 = {Text = "打击"},
  Skill_45472_Desc_1 = {
    Text = "驱散一名友方的负面状态，或驱散一名敌方的正面状态。"
  },
  Skill_45472_Name_1 = {
    Text = "生理剖析"
  },
  Skill_45473_Desc_1 = {
    Text = "回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45473_Name_1 = {
    Text = "外域灌注"
  },
  Skill_45474_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45474_Name_1 = {
    Text = "深度治疗"
  },
  Skill_45475_Desc_1 = {
    Text = "使全体敌方本回合受到主动伤害后获得伤害 [Arg1]% 的<PVPSacrificeKeyWords:献祭>，临时<StrongEffectKeywords:强效> +[Arg2]。"
  },
  Skill_45475_Name_1 = {
    Text = "虚妄王女"
  },
  Skill_45476_Desc_1 = {
    Text = "对一名敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>。"
  },
  Skill_45476_Name_1 = {
    Text = "隐秘的荆棘"
  },
  Skill_45477_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPWeaknessKeywords:虚弱>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45477_Name_1 = {
    Text = "失落的艺术"
  },
  Skill_45478_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45478_Name_1 = {Text = "打击"},
  Skill_45479_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，损失一半伤害量的生命。"
  },
  Skill_45479_Name_1 = {
    Text = "链锤重创"
  },
  Skill_4547_Desc = {
    Text = "其他唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4547_Name = {
    Text = "高维催化"
  },
  Skill_45480_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，损失一半伤害量的生命。"
  },
  Skill_45480_Name_1 = {
    Text = "旋动链条"
  },
  Skill_45481_Desc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 伤害，优先攻击拥有<TauntKeywords:嘲讽>的敌方目标，损失一半伤害量的生命。"
  },
  Skill_45481_Name_1 = {
    Text = "不定之链"
  },
  Skill_45482_Desc_1 = {
    Text = "偷取任意其他目标 <Energy:[Energy:Arg2]> 狂气，使目标与自身获得<PVPEmptinessKeywords:空虚>，<StrongEffectKeywords:强效> +[Arg1]，使「蜜糖色悲惨幻象」获得<StrongEffectKeywords:强效> +[Arg3]。"
  },
  Skill_45482_Name_1 = {
    Text = "蜜糖色悲惨幻象"
  },
  Skill_45483_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45483_Name_1 = {Text = "打击"},
  Skill_45484_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45484_Name_1 = {Text = "打击"},
  Skill_45485_Desc_1 = {
    Text = "驱散一名敌方的正面状态，对其造成 <Damage:[Damage:Arg1]> 伤害，[Arg2]<PVPSlowKeywords:迟缓>。"
  },
  Skill_45485_Name_1 = {
    Text = "星彩极光"
  },
  Skill_45486_Desc_1 = {
    Text = "<Block:[Block:Arg1]> 护盾。"
  },
  Skill_45486_Name_1 = {
    Text = "硬化石肤"
  },
  Skill_45487_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPWeaknessKeywords:虚弱>。"
  },
  Skill_45487_Name_1 = {
    Text = "虚弱凝视"
  },
  Skill_45488_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_45488_Name_1 = {
    Text = "螺湮守护"
  },
  Skill_45489_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_45489_Name_1 = {
    Text = "王权之威"
  },
  Skill_4548_Desc = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4548_Name = {
    Text = "高维狂气"
  },
  Skill_45490_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_45490_Name_1 = {
    Text = "万古震慑"
  },
  Skill_45491_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，<PVPSlowKeywords:迟缓>。"
  },
  Skill_45491_Name_1 = {Text = "泡影"},
  Skill_45492_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，若击杀目标则对其他敌方造成等量<PVPBleedingKeywords:出血>。"
  },
  Skill_45492_Name_1 = {
    Text = "湮灭预言"
  },
  Skill_45493_Desc_1 = {
    Text = "驱散一名敌方的正面状态，对其造成 <Damage:[Damage:Arg1]> 伤害，<PVPCapKeywords:算力上限> - [Arg2]。"
  },
  Skill_45493_Name_1 = {
    Text = "深海之咒"
  },
  Skill_45494_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易伤>并<PVPSeriousInjuryKeywords:重创>一名敌方，损失 <Damage:[Arg1]> 生命。"
  },
  Skill_45494_Name_1 = {
    Text = "海月赐苦"
  },
  Skill_45495_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，损失 <Damage:[Arg3]> 生命。"
  },
  Skill_45495_Name_1 = {
    Text = "双向触刺"
  },
  Skill_45496_Desc_1 = {
    Text = "驱散全体敌方的正面状态，对他们造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45496_Name_1 = {
    Text = "向深渊祝祷"
  },
  Skill_45497_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45497_Name_1 = {Text = "打击"},
  Skill_45498_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45498_Name_1 = {Text = "打击"},
  Skill_45499_BattleDesc_1 = {
    Text = "回复 <Heal:[Heal:Arg4]> 生命，每损失 [Arg2] 生命就使治疗 + [Arg3]。"
  },
  Skill_45499_Desc_1 = {
    Text = "回复 <Heal:[Heal:Arg1]> 生命，每损失 [Arg2] 生命就使治疗 + [Arg3]。"
  },
  Skill_45499_Name_1 = {
    Text = "重塑疗愈"
  },
  Skill_4549_Desc = {
    Text = "对所有敌人施加 2 层<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4549_Name = {
    Text = "高维虚弱"
  },
  Skill_45500_BattleDesc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg4]> 伤害，每损失 [Arg2] 生命就使伤害 + [Arg3]，同时视为「打击」。"
  },
  Skill_45500_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，每损失 [Arg2] 生命就使伤害 + [Arg3]，同时视为「打击」。"
  },
  Skill_45500_Name_1 = {
    Text = "报偿打击"
  },
  Skill_45501_Desc_1 = {
    Text = "对<HPAndShieldMin:生命与护盾最低>的敌方造成 <Damage:[Damage:Arg1]> 伤害，若击杀敌方则给予其他友方 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45501_Name_1 = {
    Text = "原质之海"
  },
  Skill_45502_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，<PVPVulnerabilityIconKeywords:易伤>自身，下回合之前，每当被主动攻击，就获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45502_Name_1 = {
    Text = "疼痛转化"
  },
  Skill_45503_Desc_1 = {
    Text = "使任意其他目标获得 [Arg1] 层<EnergyStorageKeywords:蓄力>，偷取目标 <Energy:[Energy:Arg2]> 狂气并造成<PVPEmptinessKeywords:空虚>。"
  },
  Skill_45503_Name_1 = {
    Text = "无尽的空虚"
  },
  Skill_45504_BattleDesc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg4]> 伤害，每缺少 [Arg2] 生命就使伤害 + [Arg3]。"
  },
  Skill_45504_Desc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 伤害，每缺少 [Arg2] 生命就使伤害 + [Arg3]。"
  },
  Skill_45504_Name_1 = {
    Text = "缚身锁链"
  },
  Skill_45505_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，回复一半伤害的生命。"
  },
  Skill_45505_Name_1 = {
    Text = "海渊之力"
  },
  Skill_45506_Desc_1 = {
    Text = "<PVPResurrectionKeywords:复活>一名友方并回复目标 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45506_Name_1 = {
    Text = "理性，真理与现实"
  },
  Skill_4550_Desc = {
    Text = "对所有敌人施加 2 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4550_Name = {
    Text = "高维易伤"
  },
  Skill_45510_Desc_1 = {
    Text = "选择：给予全体友方 <Energy:[Energy:Arg1]> 狂气，或给予全体友方 <Block:[Block:Arg2]> 护盾。"
  },
  Skill_45510_Name_1 = {
    Text = "特殊制剂"
  },
  Skill_45511_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45511_Name_1 = {Text = "打击"},
  Skill_45512_BattleDesc_1 = {
    Text = "造成合计 <Damage:[Damage:Arg4]> 伤害，耗尽所有算力，每消耗 [Arg2] 算力就使伤害 + [Arg3]，平均分配给所有敌人，每个敌方受到 <Damage:[Damage:Arg5]> 伤害。"
  },
  Skill_45512_Desc_1 = {
    Text = "造成合计 <Damage:[Damage:Arg1]> 伤害，耗尽所有算力，每消耗 [Arg2] 算力就使伤害 + [Arg3]，平均分配给所有敌人。"
  },
  Skill_45512_Name_1 = {
    Text = "告死之舞"
  },
  Skill_45513_Desc_1 = {
    Text = "获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45513_Name_1 = {Text = "战意"},
  Skill_45514_Desc_1 = {
    Text = "本回合若打出「打击」，则「打击」+ [Arg1]% 伤害<PVPPenetrateKeywords:贯穿 1>；否则回合结束 +[Arg2] <PVPProtectiveKeywords:屏障>。"
  },
  Skill_45514_Name_1 = {
    Text = "星兽余威"
  },
  Skill_45515_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45515_Name_1 = {
    Text = "污秽风暴"
  },
  Skill_45516_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> <PVPCardLockKeywords:卡牌封锁>。"
  },
  Skill_45516_Name_1 = {
    Text = "维度追猎"
  },
  Skill_45517_Desc_1 = {
    Text = "弃掉所有其他唤醒体的手牌，将等量 + [Arg1] 的随机<PVPMouseKeywords:老鼠牌><PVPDerivativeCardKeywords_7:><PVPDerivativeCardKeywords_8:><PVPDerivativeCardKeywords_9:>置入手中，<PVPPowerIconKeywords:力量> + [Arg2] 。"
  },
  Skill_45517_Name_1 = {
    Text = "雾都街童"
  },
  Skill_45518_Desc_1 = {
    Text = "将 [Arg1] 张<PVPDerivativeCardKeywords_11:「不平等交换」>置入手中。"
  },
  Skill_45518_Name_1 = {
    Text = "遗失的久远之城"
  },
  Skill_45519_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45519_Name_1 = {Text = "打击"},
  Skill_4551_Desc = {
    Text = "获得 2 点算力。"
  },
  Skill_4551_Name = {
    Text = "高维筹算"
  },
  Skill_45520_Desc_1 = {
    Text = "触发全体敌方的<PVPMethysisKeywords:中毒>。"
  },
  Skill_45520_Name_1 = {Text = "毒发"},
  Skill_45521_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45521_Name_1 = {
    Text = "海洋毒素"
  },
  Skill_45522_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45522_Name_1 = {
    Text = "溺毒弥漫"
  },
  Skill_45523_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45523_Name_1 = {
    Text = "黎明氦闪"
  },
  Skill_45524_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>伤害。"
  },
  Skill_45524_Name_1 = {
    Text = "翠星坠落"
  },
  Skill_45525_Desc_1 = {
    Text = "<StrengthenKeywords:强化>，<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45525_Name_1 = {
    Text = "护身绿炎"
  },
  Skill_45526_BattleDesc_1 = {
    Text = "驱散一名敌方的正面状态并造成 <Damage:[Damage:Arg3]> 伤害，移除自身<PVPProtectiveKeywords:屏障>，每层使伤害 + [Arg2]。"
  },
  Skill_45526_Desc_1 = {
    Text = "驱散一名敌方的正面状态并造成 <Damage:[Damage:Arg1]> 伤害，移除自身<PVPProtectiveKeywords:屏障>，每层使伤害 + [Arg2]。"
  },
  Skill_45526_Name_1 = {
    Text = "「审判」"
  },
  Skill_45527_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，获得<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45527_Name_1 = {
    Text = "神圣骨血"
  },
  Skill_45528_BattleDesc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg4]> 伤害，移除自身<PVPProtectiveKeywords:屏障>，每层使伤害 + [Arg3]。"
  },
  Skill_45528_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，移除自身<PVPProtectiveKeywords:屏障>，每层使伤害 + [Arg3]。"
  },
  Skill_45528_Name_1 = {
    Text = "「惩恶」"
  },
  Skill_45529_Desc_1 = {
    Text = "对一名敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45529_Name_1 = {
    Text = "血与沙的赞歌"
  },
  Skill_4552_Desc = {
    Text = "抽 2 张牌。"
  },
  Skill_4552_Name = {
    Text = "高维妙手"
  },
  Skill_45530_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45530_Name_1 = {Text = "打击"},
  Skill_45531_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45531_Name_1 = {
    Text = "扭曲的死体狂宴"
  },
  Skill_45532_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45532_Name_1 = {Text = "打击"},
  Skill_45533_Desc_1 = {
    Text = "将之前回合最后打出的 [Arg1] 张「技能」置入手中，将其费用变为 0，若多次触发该类效果则向前追溯。"
  },
  Skill_45533_Name_1 = {
    Text = "悖论收束"
  },
  Skill_45534_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害和负面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45534_Name_1 = {
    Text = "客官请慢用！"
  },
  Skill_45535_Desc_1 = {
    Text = "获得 [Arg1] 张<PVPDerivativeCardKeywords_10:「沸血」>。"
  },
  Skill_45535_Name_1 = {
    Text = "血之宣告"
  },
  Skill_45536_BattleDesc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg3]> 伤害，每点<PVPCapKeywords:算力上限>增加 [Arg2] 伤害。"
  },
  Skill_45536_Desc_1 = {
    Text = "随机造成 [Arg1] 次伤害，每点<PVPCapKeywords:算力上限>增加 [Arg2] 伤害。"
  },
  Skill_45536_Name_1 = {Text = "尖啸"},
  Skill_45537_Desc_1 = {
    Text = "对一名敌方造成 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>，"
  },
  Skill_45537_Name_1 = {
    Text = "血的悲歌"
  },
  Skill_45538_Desc_1 = {
    Text = "为一名友方施加正面<PVPWonderfulEffectKeywords:奇妙效果>，或为一名敌方施加负面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45538_Name_1 = {
    Text = "创意甜品"
  },
  Skill_45539_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命，对自身使用效果减半，施加正面<PVPWonderfulEffectKeywords:奇妙效果>。"
  },
  Skill_45539_Name_1 = {
    Text = "滋补炖菜"
  },
  Skill_4553_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，在后排召唤「求告者」。"
  },
  Skill_4553_Name = {
    Text = "分裂打击"
  },
  Skill_45540_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂气，为手中所有卡牌恢复 [Arg2] 使用次数。"
  },
  Skill_45540_Name_1 = {
    Text = "食材补充"
  },
  Skill_45541_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 或 <Damage:[Damage:Arg2]> 或 <Damage:[Damage:Arg3]> 伤害，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45541_Name_1 = {
    Text = "肆意豪赌"
  },
  Skill_45542_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，获得<PVPProtectiveKeywords:屏障>，同时视为「打击」。"
  },
  Skill_45542_Name_1 = {
    Text = "环行轨迹"
  },
  Skill_45543_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，获得 [Arg3] <PVPProtectiveKeywords:屏障>。"
  },
  Skill_45543_Name_1 = {
    Text = "死梦之都"
  },
  Skill_45544_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45544_Name_1 = {
    Text = "电磁爆破"
  },
  Skill_45545_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易伤>自身，<DelayKeywords:延迟 1>：抽 [Arg1] 张牌。"
  },
  Skill_45545_Name_1 = {
    Text = "伟大的牺牲"
  },
  Skill_45546_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>敌方造成 <Damage:[Damage:Arg1]> 伤害，重复 [Arg2] 次，若存在「圣血指引」状态的目标则优先攻击。"
  },
  Skill_45546_Name_1 = {
    Text = "连绵的本能"
  },
  Skill_45547_Desc_1 = {
    Text = "本回合内，每当目标被主动攻击，就回复损失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45547_Name_1 = {
    Text = "圣血指引"
  },
  Skill_45548_Desc_1 = {
    Text = "<PVPResurrectionKeywords:复活>全体友方，<DelayKeywords:延迟 1>：回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45548_Name_1 = {
    Text = "不死的极乐鸟"
  },
  Skill_45549_BattleDesc_1 = {
    Text = "对指定敌方造成 <Damage:[Damage:Arg2]> 伤害，每点算力上限增加 [Arg1] 伤害。"
  },
  Skill_45549_Desc_1 = {
    Text = "对指定敌方造成伤害，每点<PVPCapKeywords:算力上限>增加 [Arg1] 伤害。"
  },
  Skill_45549_Name_1 = {
    Text = "逐火飞虫"
  },
  Skill_4554_Desc = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。"
  },
  Skill_4554_Name = {Text = "阳伞"},
  Skill_45550_Desc_1 = {
    Text = "抽 [Arg1] 张牌。"
  },
  Skill_45550_Name_1 = {
    Text = "湮塞宝藏"
  },
  Skill_45551_Desc_1 = {
    Text = "查看下 [Arg1] 张牌，将 1 张置入手中，其他的牌洗回抽牌堆。"
  },
  Skill_45551_Name_1 = {
    Text = "暗流微光"
  },
  Skill_45552_Desc_1 = {
    Text = "<StrengthenKeywords:强化>全体友方并给予<PVPProtectiveKeywords:屏障>。"
  },
  Skill_45552_Name_1 = {
    Text = "整装待发"
  },
  Skill_45553_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45553_Name_1 = {Text = "打击"},
  Skill_45554_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得等量护盾。"
  },
  Skill_45554_Name_1 = {
    Text = "七艺，传承美德"
  },
  Skill_45555_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45555_Name_1 = {
    Text = "人格污染"
  },
  Skill_45556_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，获得与伤害等量的护盾，获得<TauntKeywords:嘲讽>。"
  },
  Skill_45556_Name_1 = {
    Text = "防御射线"
  },
  Skill_45557_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Block:[Block:Arg2]> 护盾，<StrongEffectKeywords:强效> +[Arg3]。"
  },
  Skill_45557_Name_1 = {
    Text = "无尽的雕琢"
  },
  Skill_45558_Desc_1 = {
    Text = "给予全体友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45558_Name_1 = {
    Text = "量子催化"
  },
  Skill_45559_Desc_1 = {
    Text = "给予一名友方 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_45559_Name_1 = {
    Text = "光学防护"
  },
  Skill_4555_Desc = {
    Text = "破除桎梏孵化而出，正在寻找它的下一个目标…"
  },
  Skill_4555_Name = {
    Text = "孵化重塑"
  },
  Skill_45560_Desc_1 = {
    Text = "对<HPAndShieldMin:生命与护盾最低>敌方造成 <Damage:[Damage:Arg1]> 伤害。每有 1 个死亡唤醒体，就额外造成 1 次伤害。"
  },
  Skill_45560_Name_1 = {
    Text = "踏血而来"
  },
  Skill_45561_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45561_Name_1 = {Text = "打击"},
  Skill_45562_Desc_1 = {
    Text = "获得 3 张 <PVPDerivativeCardKeywords_15:「液化虚无」>。"
  },
  Skill_45562_Name_1 = {
    Text = "终点、真理与深渊之门"
  },
  Skill_45563_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，若击杀任何敌方，将 [Arg2] 张「廻环剑技」置入手中，使其伤害 + [Arg3]。"
  },
  Skill_45563_Name_1 = {
    Text = "廻环剑技"
  },
  Skill_45564_Desc_1 = {
    Text = "<ReinforceKeywords:加固>一名友方，并回复其 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45564_Name_1 = {
    Text = "理想乡的祝福"
  },
  Skill_45565_BattleDesc_1 = {
    Text = "造成 [Arg3] 次 <Damage:[Damage:Arg1]> 伤害，每有 1 个死亡友方额外造成 1 次伤害。"
  },
  Skill_45565_Desc_1 = {
    Text = "造成 [Arg2] 次 <Damage:[Damage:Arg1]> 伤害，每有 1 个死亡友方额外造成 1 次伤害。"
  },
  Skill_45565_Name_1 = {
    Text = "纯白涟漪"
  },
  Skill_45566_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命，并给予<TauntKeywords:嘲讽>。"
  },
  Skill_45566_Name_1 = {
    Text = "彼岸信标"
  },
  Skill_45567_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>，<PVPPenetrateKeywords:贯穿 1>。纷华篇章：额外触发 [Arg2] 次。"
  },
  Skill_45567_Name_1 = {
    Text = "死亡诗篇"
  },
  Skill_45568_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>，<PVPPenetrateKeywords:贯穿 1>。纷华篇章：额外对全体敌方生效 [Arg2] 次。"
  },
  Skill_45568_Name_1 = {
    Text = "灵魂诗篇"
  },
  Skill_45569_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命，<PVPPenetrateKeywords:贯穿 1>。纷华篇章：驱散目标负面状态并额外生效 [Arg2] 次。"
  },
  Skill_45569_Name_1 = {
    Text = "生命诗篇"
  },
  Skill_4556_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45570_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45570_Name_1 = {Text = "打击"},
  Skill_45571_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45571_Name_1 = {Text = "打击"},
  Skill_45572_Desc_1 = {
    Text = "使全体友方所有<DelayKeywords:延迟 1>治疗立刻生效，随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_45572_Name_1 = {
    Text = "献媚者之拥"
  },
  Skill_45573_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45573_Name_1 = {Text = "打击"},
  Skill_45574_Desc_1 = {
    Text = "<StrongEffectKeywords:强效> +[Arg1]，增幅下一个诗篇，使其获得额外效果。"
  },
  Skill_45574_Name_1 = {
    Text = "纷华篇章"
  },
  Skill_45575_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_45575_Name_1 = {
    Text = "星辰正位之刻"
  },
  Skill_45576_Desc_1 = {
    Text = "获得 [Arg1] 张「打击」。"
  },
  Skill_45576_Name_1 = {
    Text = "混沌之兽"
  },
  Skill_45577_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：变为对手打出的上一张「技能」，且使其费用 - [Arg1]。"
  },
  Skill_45577_Name_1 = {
    Text = "星彩拟态"
  },
  Skill_45578_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂气，获得 [Arg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45578_Name_1 = {
    Text = "猛烈生长"
  },
  Skill_45579_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，直到下回合开始，自身被主动攻击时获得 [Arg1] 层<EnergyStorageKeywords:蓄力>并对攻击者造成 [Arg1] 层<PVPSlowKeywords:迟缓>。"
  },
  Skill_45579_Name_1 = {
    Text = "异常引力"
  },
  Skill_4557_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，召唤两个「都怪你」。"
  },
  Skill_4557_Name = {Text = "呼唤"},
  Skill_45580_Desc_1 = {
    Text = "<PVPProtectiveKeywords:屏障>，抽 [Arg2] 张牌。"
  },
  Skill_45580_Name_1 = {
    Text = "活尸之墙"
  },
  Skill_45582_Desc_1 = {
    Text = "驱散全体友方的负面状态，获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45582_Name_1 = {
    Text = "复苏之音"
  },
  Skill_45583_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPSlowKeywords:迟缓>。"
  },
  Skill_45583_Name_1 = {Text = "哀歌"},
  Skill_45584_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>，同时视为「打击」。"
  },
  Skill_45584_Name_1 = {
    Text = "穿云引吭"
  },
  Skill_45585_BattleDesc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg4]> 伤害，<PVPSlowKeywords:迟缓>，每拥有 [Arg2] 护盾就使伤害 + [Arg3]。"
  },
  Skill_45585_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPSlowKeywords:迟缓>，每拥有 [Arg2] 护盾就使伤害 + [Arg3]。"
  },
  Skill_45585_Name_1 = {
    Text = "无止境的正义"
  },
  Skill_45586_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_45586_Name_1 = {
    Text = "造主的庇佑"
  },
  Skill_45587_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45587_Name_1 = {
    Text = "魂灵追击"
  },
  Skill_45588_Desc_1 = {
    Text = "<PVPVulnerabilityIconKeywords:易伤>目标并造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45588_Name_1 = {
    Text = "杠杆投机"
  },
  Skill_45589_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPSlowKeywords:迟缓>。"
  },
  Skill_45589_Name_1 = {
    Text = "牌桌把戏"
  },
  Skill_4558_AwakerSkillBackgroundStory = {
    Text = "学生们回避着与拉蒙娜对视。\n坊间传言，那只青色的眼睛能够看穿内心，一切谎言在拉蒙娜眼前都无所遁形。甚至有人说，她取下单片眼镜之日，就是神明降临之时。\n「你别听那些学长瞎猜，戴眼镜只是为了方便阅读。」\n「我可不是什么最新款测谎仪，这种程度的推演，不是很简单吗？」"
  },
  Skill_4558_Desc_0 = {
    Text = "使所有敌人临时降低 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。抽 1 张牌。"
  },
  Skill_4558_Desc_2 = {
    Text = "使所有敌人临时降低 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>。抽 1 张牌，抽到的卡牌每有 1 点算力消耗，获得 <Posse:[Arg2]> 点银钥能量。"
  },
  Skill_4558_EffectNameList = {
    Text = "力量降低"
  },
  Skill_4558_Name = {
    Text = "攻势推演"
  },
  Skill_4558_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_45590_Desc_1 = {
    Text = "对随机敌方造成 [Arg2] 次 <Damage:[Damage:Arg1]> 伤害，"
  },
  Skill_45590_Name_1 = {
    Text = "十环出牌！"
  },
  Skill_45591_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg3]> 伤害，将这张牌洗入抽牌堆，使所有「千面重叠」伤害 + [Arg2]。"
  },
  Skill_45591_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，将这张牌洗入抽牌堆，使所有「千面重叠」伤害 + [Arg2]。"
  },
  Skill_45591_Name_1 = {
    Text = "千面重叠"
  },
  Skill_45592_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPRaidKeywords:突袭>：改为造成<Damage:[Damage:Arg3]> 伤害。"
  },
  Skill_45592_Name_1 = {
    Text = "狂战突袭"
  },
  Skill_45593_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPRaidKeywords:突袭>：改为造成<Damage:[Damage:Arg3]> 伤害。"
  },
  Skill_45593_Name_1 = {
    Text = "非利士式闪击"
  },
  Skill_45594_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，若击杀敌方则获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45594_Name_1 = {
    Text = "巨刃重杀"
  },
  Skill_45595_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，对受<PVPSeriousInjuryKeywords:重创>影响的目标造成翻倍伤害。"
  },
  Skill_45595_Name_1 = {
    Text = "渊血迸发"
  },
  Skill_45596_Desc_1 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 伤害，获得伤害一半的临时<PVPRetaliateIconKeywords:反击>，同时视为「打击」。"
  },
  Skill_45596_Name_1 = {
    Text = "逆鳞反制"
  },
  Skill_45597_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重创>并造成 <Damage:[Damage:Arg1]> 伤害，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_45597_Name_1 = {
    Text = "鳞刺打击"
  },
  Skill_45598_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45598_Name_1 = {Text = "打击"},
  Skill_45599_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂气，给予其他友方 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45599_Name_1 = {
    Text = "负熵演算"
  },
  Skill_4559_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45600_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45600_Name_1 = {Text = "打击"},
  Skill_45601_Desc_1 = {
    Text = "查看全体敌方的 [Arg1] 张随机「技能」，将 [Arg2] 张置入手中，使其费用变为 0。"
  },
  Skill_45601_Name_1 = {
    Text = "现实模仿"
  },
  Skill_45602_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<ComaKeywords:昏迷>。"
  },
  Skill_45602_Name_1 = {
    Text = "万古之眸"
  },
  Skill_45603_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45603_Name_1 = {Text = "打击"},
  Skill_45604_Desc_1 = {
    Text = "给予一名友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45604_Name_1 = {
    Text = "受赐者的权柄"
  },
  Skill_45605_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_45605_Name_1 = {
    Text = "不屈的宣告"
  },
  Skill_45606_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> + [Arg1]。"
  },
  Skill_45606_Name_1 = {
    Text = "螺湮的礼物"
  },
  Skill_45607_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，同时视为「打击」，<PVPPenetrateKeywords:贯穿 2>。"
  },
  Skill_45607_Name_1 = {
    Text = "狂乱撕裂"
  },
  Skill_45608_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45608_Name_1 = {
    Text = "权欲轮舞"
  },
  Skill_45609_Desc_1 = {
    Text = "偷取目标所有可驱散的正面状态，造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45609_Name_1 = {
    Text = "星之摇篮"
  },
  Skill_4560_BattleDesc = {
    Text = "失去 [Arg1] 点生命，获得双倍于该值的护盾。无法出售。"
  },
  Skill_4560_Desc = {
    Text = "失去 5% 最大生命，获得双倍于该值的护盾。无法出售。"
  },
  Skill_4560_Name = {
    Text = "症状：幽闭"
  },
  Skill_45610_BattleDesc_1 = {
    Text = "<TauntKeywords:嘲讽>，获得 [Arg4] 临时<PVPRetaliateIconKeywords:反击>，每有 [Arg2] <PVPProtectiveKeywords:屏障>额外获得 [Arg3] 临时<PVPRetaliateIconKeywords:反击>。"
  },
  Skill_45610_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，获得 [Arg1] 临时<PVPRetaliateIconKeywords:反击>，每有 [Arg2] <PVPProtectiveKeywords:屏障>额外获得 [Arg3] 临时<PVPRetaliateIconKeywords:反击>。"
  },
  Skill_45610_Name_1 = {
    Text = "迷途梦引"
  },
  Skill_45611_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，"
  },
  Skill_45611_Name_1 = {Text = "脊刺"},
  Skill_45612_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，<Block:[Block:Arg1]> 护盾。"
  },
  Skill_45612_Name_1 = {
    Text = "迷宫陷阱"
  },
  Skill_45613_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，<PVPEntanglementKeywords:缠绕>。"
  },
  Skill_45613_Name_1 = {
    Text = "缚网绞杀"
  },
  Skill_45614_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPEntanglementKeywords:缠绕>。"
  },
  Skill_45614_Name_1 = {
    Text = "蛛丝缠绕"
  },
  Skill_45615_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPEntanglementKeywords:缠绕>。"
  },
  Skill_45615_Name_1 = {
    Text = "苍白的庇佑"
  },
  Skill_45616_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方造成 <Damage:[Damage:Arg1]> 伤害，<ComaKeywords:昏迷>。"
  },
  Skill_45616_Name_1 = {
    Text = "淤泥上的不灭之花"
  },
  Skill_45617_Desc_1 = {
    Text = "抽 [Arg1] 张牌，若这是一张「命轮」，则使其变为 0 费，否则将其 [Arg2] 张复制置入手中。"
  },
  Skill_45617_Name_1 = {
    Text = "命运工匠"
  },
  Skill_45618_Desc_1 = {
    Text = "给予一名友方 <Block:[Block:Arg1]> 护盾，将其 [Arg2] 张「打击」置入手中。"
  },
  Skill_45618_Name_1 = {
    Text = "工具套组"
  },
  Skill_45619_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45619_Name_1 = {
    Text = "锈蚀扳手"
  },
  Skill_4561_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45620_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，抽 [Arg1] 张牌。"
  },
  Skill_45620_Name_1 = {
    Text = "小小守护者"
  },
  Skill_45621_Desc_1 = {
    Text = "<PVPWeaknessKeywords:虚弱>，<PVPVulnerabilityIconKeywords:易伤>。"
  },
  Skill_45621_Name_1 = {
    Text = "腐烂瑰香"
  },
  Skill_45622_BattleDesc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg3]> 伤害，弃掉所有手牌并移除所有<EnergyStorageKeywords:蓄力>，每张手牌和每层<EnergyStorageKeywords:蓄力>使伤害 + [Arg2]。"
  },
  Skill_45622_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，弃掉所有手牌并移除所有<EnergyStorageKeywords:蓄力>，每张手牌和每层<EnergyStorageKeywords:蓄力>使伤害 + [Arg2]。"
  },
  Skill_45622_Name_1 = {
    Text = "绝境求生"
  },
  Skill_45623_Desc_1 = {
    Text = "选择：获得 [Arg1] 算力，或抽 [Arg2] 张牌。"
  },
  Skill_45623_Name_1 = {
    Text = "天才的远见"
  },
  Skill_45624_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾，临时<StrongEffectKeywords:强效> +[Arg2]。"
  },
  Skill_45624_Name_1 = {
    Text = "虚妄继承者"
  },
  Skill_45625_Desc_1 = {
    Text = "选择：回复全体友方 <Heal:[Heal:Arg1]> 生命，或对全体敌方造成 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_45625_Name_1 = {
    Text = "人性观察实验"
  },
  Skill_45626_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，将一张随机的<PVPAmazingMagicKeywords:惊人魔术><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>置入手中。"
  },
  Skill_45626_Name_1 = {
    Text = "魔术嘉年华"
  },
  Skill_45627_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45627_Name_1 = {
    Text = "渴血狂欢"
  },
  Skill_45629_Desc_1 = {
    Text = "<Energy:[Energy:Arg1]> 狂气，<TauntKeywords:嘲讽>。"
  },
  Skill_45629_Name_1 = {
    Text = "艺术狂热"
  },
  Skill_4562_Desc = {
    Text = "获得 [Arg2] 点护盾和状态「恶意放血」: 每造成一次未被格挡的伤害，附加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4562_Name = {
    Text = "航海料理"
  },
  Skill_45630_Desc_1 = {
    Text = "将一张随机的<PVPAmazingMagicKeywords:惊人魔术><PVPDerivativeCardKeywords_4:><PVPDerivativeCardKeywords_5:><PVPDerivativeCardKeywords_6:>置入手中。"
  },
  Skill_45630_Name_1 = {
    Text = "魔术师的库藏"
  },
  Skill_45631_Desc_1 = {
    Text = "弃掉所有手牌，并重新抽取等量张数的牌，若手牌为 0 则额外抽 1 张牌。"
  },
  Skill_45631_Name_1 = {
    Text = "过手洗牌"
  },
  Skill_45632_Desc_1 = {
    Text = "<StrengthenKeywords:强化>并<ReinforceKeywords:加固>一名友方。"
  },
  Skill_45632_Name_1 = {
    Text = "祝福魔术币"
  },
  Skill_45633_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45633_Name_1 = {Text = "打击"},
  Skill_45634_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45634_Name_1 = {Text = "打击"},
  Skill_45635_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，对受<TauntKeywords:嘲讽>影响的目标造成三倍伤害，迫使目标获得<TauntKeywords:嘲讽>。"
  },
  Skill_45635_Name_1 = {
    Text = "前阵战术"
  },
  Skill_45636_Desc_1 = {
    Text = "全体友方获得 [Arg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45636_Name_1 = {
    Text = "战斗启示"
  },
  Skill_45637_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，驱散负面状态。"
  },
  Skill_45637_Name_1 = {
    Text = "骑士热诚"
  },
  Skill_45638_Desc_1 = {
    Text = "获得 [Arg1] 算力。"
  },
  Skill_45638_Name_1 = {
    Text = "高效思维"
  },
  Skill_45639_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_45639_Name_1 = {
    Text = "弥萨格利刃"
  },
  Skill_4563_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45640_Desc_1 = {
    Text = "<PVPHoldingKeywords:持有>：视为本回合内上次打出的「技能」。"
  },
  Skill_45640_Name_1 = {
    Text = "模拟演绎"
  },
  Skill_45641_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，使自身护盾翻倍，同时视为「打击」。"
  },
  Skill_45641_Name_1 = {
    Text = "正义裁决"
  },
  Skill_45642_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，获得 [Arg1] 张<PVPDerivativeCardKeywords_1:「心眼打击」>。"
  },
  Skill_45642_Name_1 = {
    Text = "战地守护"
  },
  Skill_45643_Desc_1 = {
    Text = "<Block:[Block:Arg1]> 护盾，获得 [Arg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  Skill_45643_Name_1 = {
    Text = "防御姿态"
  },
  Skill_45644_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，<ReinforceKeywords:加固>。"
  },
  Skill_45644_Name_1 = {
    Text = "机械壁垒"
  },
  Skill_45645_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_45645_Name_1 = {
    Text = "力场防护"
  },
  Skill_45646_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_45646_Name_1 = {
    Text = "超载电流"
  },
  Skill_45647_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：驱散一名友方的负面状态，并回复这名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45647_Name_1 = {
    Text = "凝血治疗"
  },
  Skill_45648_Desc_1 = {
    Text = "回满算力。"
  },
  Skill_45648_Name_1 = {
    Text = "世界演绎法"
  },
  Skill_45649_Desc_1 = {
    Text = "<PVPCapKeywords:算力上限> + [Arg1]，<Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_45649_Name_1 = {
    Text = "欢愉果实"
  },
  Skill_4564_Desc = {
    Text = "施加 [Arg1] 层<BleedingIconKeywords:出血>，降低  [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4564_Name = {
    Text = "侵蚀之视"
  },
  Skill_45650_Desc_1 = {
    Text = "<PVPSeriousInjuryKeywords:重创>全体敌方，并对他们造成 <Damage:[Damage:Arg1]> 伤害，如果目标此前已经受<PVPSeriousInjuryKeywords:重创>影响，则使伤害翻倍。"
  },
  Skill_45650_Name_1 = {
    Text = "喧嚣海洋"
  },
  Skill_45651_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>敌方造成 <Damage:[Damage:Arg1]> 伤害，获得等量伤害的护盾，同时视为「打击」。"
  },
  Skill_45651_Name_1 = {
    Text = "心眼打击"
  },
  Skill_4565_Desc = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_23:「伤口」>洗入对方抽牌堆。"
  },
  Skill_4566_Desc = {
    Text = "献祭自身，自身生命转为「提灯教牧」的生命。"
  },
  Skill_4566_Name = {Text = "献祭"},
  Skill_45676_Desc_1 = {
    Text = "全体敌方驱散正面状态。"
  },
  Skill_45676_Name_1 = {
    Text = "狂言魔术牌"
  },
  Skill_45677_Desc_1 = {
    Text = "驱散全体友方的负面状态。"
  },
  Skill_45677_Name_1 = {
    Text = "兔子礼帽"
  },
  Skill_45678_Desc_1 = {
    Text = "对<HPAndShieldMin:生命与护盾最低>的敌方造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_45678_Name_1 = {
    Text = "带电小鼠"
  },
  Skill_45679_Desc_1 = {
    Text = "<PVPResurrectionKeywords:复活>一名友方并回复其 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_45679_Name_1 = {
    Text = "反向分体魔术盒"
  },
  Skill_4567_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45680_Desc_1 = {
    Text = "选择：驱散全体友方的负面状态 或 驱散全体敌方的正面状态。"
  },
  Skill_45680_Name_1 = {
    Text = "白鸽手帕"
  },
  Skill_45681_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_45681_Name_1 = {
    Text = "染疫小鼠"
  },
  Skill_45682_Desc_1 = {
    Text = "给予全体友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_45682_Name_1 = {
    Text = "心灵感应话筒"
  },
  Skill_45683_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_45683_Name_1 = {
    Text = "失智小鼠"
  },
  Skill_45684_Desc_1 = {
    Text = "随机造成 [Arg1] 次 <Damage:[Damage:Arg2]> 伤害，获得 <Energy:[Energy:Arg3]> 狂气。"
  },
  Skill_45684_Name_1 = {Text = "沸血"},
  Skill_4568_Desc = {
    Text = "击晕敌人，并清除其<RetaliateIconKeywords:反击>层数。"
  },
  Skill_4568_Name = {Text = "大石头"},
  Skill_45692_Desc = {
    Text = "随机冻结抽牌堆中的 1 张指令卡，获得 1 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_45692_Name = {
    Text = "冰霜尖啸"
  },
  Skill_4569_Desc = {
    Text = "回合结束时若在手中，自身<FragileIconKeywords:脆弱> 1 回合。使用后<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。无法出售。"
  },
  Skill_4569_Name = {
    Text = "症状：崩溃"
  },
  Skill_45704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_45708_AwakerSkillBackgroundStory = {
    Text = "当他举起巨剑，带来的必然是鲜血与死亡。"
  },
  Skill_45708_Desc_0 = {
    Text = "将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。"
  },
  Skill_45708_Desc_3 = {
    Text = "将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。戈利亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_45708_Name = {Text = "蛰伏"},
  Skill_45709_AwakerSkillBackgroundStory = {
    Text = "当他举起巨剑，带来的必然是鲜血与死亡。"
  },
  Skill_45709_Desc_0 = {
    Text = "将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，获得等同于 [Arg1]% 触腕伤害的临时<PowerIconKeywords:力量>。"
  },
  Skill_45709_Desc_3 = {
    Text = "将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，获得等同于 [Arg1]% 触腕伤害的临时<PowerIconKeywords:力量>。戈利亚获得 [Arg2]% 临时暴击率。"
  },
  Skill_45709_EffectNameList = {
    Text = "触腕伤害百分比"
  },
  Skill_45709_Name = {Text = "篡夺"},
  Skill_45709_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4570_AwakerSkillBackgroundStory = {
    Text = "闪耀吧，向着故国所在的方向。"
  },
  Skill_4570_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4570_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。使 1 条触腕攻击 2 次，但只造成 50％ 的伤害。"
  },
  Skill_4570_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。法洛思获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4570_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。法洛思获得 <Energy:[Energy:Arg2]> 点狂气。使 1 条触腕攻击 2 次，但只造成 50％ 的伤害。"
  },
  Skill_4570_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4570_Name = {Text = "防御"},
  Skill_4570_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4571_Desc = {
    Text = "获得  <Posse:[Arg1]>  点银钥能量。获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4571_EffectNameList = {Text = "护盾"},
  Skill_4571_Name = {Text = "钥能"},
  Skill_4571_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_4572_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，全体获得<Block:[Block:Arg3]> 点护盾。后撤。"
  },
  Skill_4573_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4574_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4574_Name = {
    Text = "猎矛突刺"
  },
  Skill_4575_AwakerSkillBackgroundStory = {
    Text = "那是由珊瑚构成的远古废墟。\n最初，它只是一团荡漾在海水中的白色光晕。\n后来，它长出高高的台阶，扭曲的浮雕，高耸的石柱……\n砰！当一切戛然而止，失落的艺术终于在海底掀开面纱。\n她必须前往艺术的所在。"
  },
  Skill_4575_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。"
  },
  Skill_4575_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。"
  },
  Skill_4575_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。"
  },
  Skill_4575_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。"
  },
  Skill_4575_EffectNameList_0 = {
    Text = "护盾,伤害"
  },
  Skill_4575_Name = {
    Text = "失落的艺术"
  },
  Skill_4575_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Block:[Block:Arg5]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。本场战斗中「失落的艺术」和「基础打击」造成的伤害额外享受 100% 护盾加成。"
  },
  Skill_4575_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg5]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg2]> 点伤害，每点护盾使伤害提高 [Arg3] 点，该技能额外享受 [Arg4]% 暴击率和暴击伤害加成。在首领战中，该技能额外造成 1 次伤害。本场战斗中「失落的艺术」和「基础打击」造成的伤害额外享受 100% 护盾加成。"
  },
  Skill_4575_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4576_AwakerSkillBackgroundStory = {
    Text = "将你的头颅交予我吧。\n它必会成为我钟爱的藏品之一，在维度的海洋中浮沉。\n猎颅魔女勾起嘴角，漫不经心地说道。\n「要是运气够好的话，还可以和它们一样随时陪伴在我身侧哦？」"
  },
  Skill_4576_BattleDesc_0 = {
    Text = "对生命最低的敌人造成 <Damage:[Damage:Arg1]> 点伤害，力量在「断颈一击」上发挥 5 倍效果。达芙黛尔以任意方式击杀敌人后，「断颈一击」在本次关卡中基础伤害永久提高 25%（当前 [Arg3] 次）。<TransitionIconKeywords:跃迁>：改为对生命最高敌人造成 <Damage:[Damage:Arg2]> 点伤害。"
  },
  Skill_4576_Desc_0 = {
    Text = "对生命最低的敌人造成 <Damage:[Damage:Arg1]> 点伤害，力量在「断颈一击」上发挥 5 倍效果。达芙黛尔以任意方式击杀敌人后，「断颈一击」在本次关卡中基础伤害永久提高 25%。<TransitionIconKeywords:跃迁>：改为对生命最高敌人造成 <Damage:[Damage:Arg2]> 点伤害。"
  },
  Skill_4576_EffectNameList = {
    Text = "伤害,跃迁伤害"
  },
  Skill_4576_Name = {
    Text = "断颈一击"
  },
  Skill_4576_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4577_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg4] 次。赋予  [Arg2] 张卡牌「深潜印记」：打出后敌人获得临时<PowerIconKeywords:力量>。"
  },
  Skill_4577_Name = {
    Text = "猎物标记"
  },
  Skill_4578_AwakerSkillBackgroundStory = {
    Text = "这是她挡下的第∞+1次攻击。"
  },
  Skill_4578_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<TimeBeacon:回环>：使所有敌人临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>，抽 1 张牌，环行·拉蒙娜额外获得 <Energy:[Energy:Arg5]> 点狂气。"
  },
  Skill_4578_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。环行·拉蒙娜获得 <Energy:[Energy:Arg2]> 点狂气。<TimeBeacon:回环>：使所有敌人临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>，抽 1 张牌，环行·拉蒙娜额外获得 <Energy:[Energy:Arg5]> 点狂气。"
  },
  Skill_4578_EffectNameList = {
    Text = "护盾,狂气,临时力量"
  },
  Skill_4578_Name = {Text = "防御"},
  Skill_4578_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,防御力*GrowValue3"
  },
  Skill_4579_AwakerSkillBackgroundStory = {
    Text = "巫师说：「异教徒人数众多\n我们黎凡特似乎人单力薄。\n尤乌哈希兄弟，吹响你的号角，\n像疯子一般拼杀吧。」\n战士答道：「这里没有异教徒。\n你们都将被我杀死，逝者不分族群信仰。\n届时尸身盖满山谷，布满山顶，\n便是我献予血与沙的赞歌。」"
  },
  Skill_4579_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本场战斗后续释放的「血与沙的赞歌」伤害提高 [Arg4] 点，力量倍率提高 [Arg3] 倍。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。<PowerIconKeywords:力量>在「血与沙的赞歌」上发挥 [Arg2] 倍效果。尤乌哈希获得 <Energy:[Energy:Arg5]> 点狂气。"
  },
  Skill_4579_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：本场战斗后续释放的「血与沙的赞歌」伤害提高 [Arg4] 点，力量倍率提高 [Arg3] 倍。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。<PowerIconKeywords:力量>在「血与沙的赞歌」上发挥 [Arg2] 倍效果。获得等同于尤乌哈希狂气充能两倍的狂气。"
  },
  Skill_4579_EffectNameList = {
    Text = "伤害,伤害提高"
  },
  Skill_4579_Name = {
    Text = "血与沙的赞歌"
  },
  Skill_4579_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬>：本场战斗后续释放的「血与沙的赞歌」伤害提高 [Arg4] 点，力量倍率提高 [Arg3] 倍。】对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。<PowerIconKeywords:力量>在「血与沙的赞歌」上发挥 [Arg2] 倍效果。尤乌哈希获得 <Energy:[Energy:Arg5]> 点狂气。将附加虚无和消耗的「尖啸吧，血！」填满手牌。本回合尤乌哈希的伤害次数提高 1。"
  },
  Skill_4579_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4580_Desc = {
    Text = "在自身后召唤一个「提灯」。"
  },
  Skill_4580_Name = {
    Text = "圣礼仪式"
  },
  Skill_4581_AwakerSkillBackgroundStory = {
    Text = "圣堂之下有一个隐蔽空间。\n\n主教跪在石板之前，吟诵创生之初遗留下来的密语。\n\n被时光遗忘的符文发出回应的光芒，应主教的意志现出庞大的虚影，为笼罩在其光辉下的人降下造主的「赐福」。"
  },
  Skill_4581_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>，临时暴击率 +[Arg4]%。】获得 <Block:[Block:Arg2]> 点护盾。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。直到下回合开始，受到攻击时会将伤害的 [Arg3]% 转化为猩红熔炉回复量。"
  },
  Skill_4581_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>，临时暴击率 +[Arg4]%。】获得 <Block:[Block:Arg2]> 点护盾。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。直到下回合开始，受到攻击时会将伤害的 [Arg3]% 转化为猩红熔炉回复量。萨尔瓦多获得 [Arg5]% 临时暴击伤害。"
  },
  Skill_4581_EffectNameList = {
    Text = "临时力量,护盾,猩红熔炉转化量"
  },
  Skill_4581_Name = {
    Text = "造主的庇佑"
  },
  Skill_4581_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>，临时暴击率 +[Arg4]%。】获得 <Block:[Block:Arg2]> 点护盾。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。直到下回合开始，受到攻击时会将伤害的 [Arg6]% 转化为猩红熔炉回复量。使萨尔瓦多的「基础打击」和「应消之苦」额外享受 100% 力量加成。本次探索内猩红熔炉上限提高最大生命的 2％，至多提高 10％。"
  },
  Skill_4581_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>，临时暴击率 +[Arg4]%。】获得 <Block:[Block:Arg2]> 点护盾。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。直到下回合开始，受到攻击时会将伤害的 [Arg6]% 转化为猩红熔炉回复量。萨尔瓦多获得 [Arg5]% 临时暴击伤害。使萨尔瓦多的「基础打击」和「应消之苦」额外享受 100% 力量加成。本次探索内猩红熔炉上限提高最大生命的 2％，至多提高 10％。"
  },
  Skill_4581_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,$GrowValue3%"
  },
  Skill_4582_BattleDesc = {
    Text = "所有唤醒体获得 <Energy:[Arg1]> 点狂气，下回合开始时，受到最大生命 5%([Arg3]) 的<SacrificeKeyWord:献祭>。"
  },
  Skill_4582_Desc = {
    Text = "所有唤醒体获得 <Energy:[Arg1]> 点狂气，下回合开始时，获得 5% 最大生命 <SacrificeKeyWord:献祭>。"
  },
  Skill_4582_Name = {
    Text = "不朽的葬仪"
  },
  Skill_4584_Desc = {
    Text = "可耻但是有用，带回钥匙才是当务之急，不是吗。"
  },
  Skill_4584_Name = {Text = "逃跑"},
  Skill_4585_AwakerSkillBackgroundStory = {
    Text = "诺缔拉时常会忘记自己周围有人，这给大家带来了不少麻烦。\n「对不起，我不是故意的。我现在就贴一张纸条提醒自己——呃，我要写什么来着？」\n于是大家在校园一隅给她开辟了一个区域，在那里她可以随意加工钢材。\n没有谁能想到，她会干出将高热光束展开成墙这种事儿。"
  },
  Skill_4585_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层临时<RetaliateIconKeywords:反击>，在首领战中，获得 3 倍临时<RetaliateIconKeywords:反击>。"
  },
  Skill_4585_EffectNameList_0 = {
    Text = "护盾,临时反击"
  },
  Skill_4585_Name = {
    Text = "高热区禁入"
  },
  Skill_4585_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4586_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4587_AwakerSkillBackgroundStory = {
    Text = "这是她挥出的第∞+1剑。"
  },
  Skill_4587_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<TimeBeacon:回环>：造成 [Arg3] 次伤害，环行·拉蒙娜暴击率 +[Arg5]%。"
  },
  Skill_4587_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。环行·拉蒙娜获得 <Energy:[Energy:Arg2]> 点狂气。<TimeBeacon:回环>：造成 [Arg3] 次伤害，环行·拉蒙娜暴击率 +[Arg5]%。"
  },
  Skill_4587_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4587_Name = {Text = "打击"},
  Skill_4587_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4588_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，为对方添加 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4588_Name = {Text = "毒素"},
  Skill_4589_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4590_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4591_AwakerSkillBackgroundStory = {
    Text = "反复被黑暗吞噬的痛苦，造就了她对黑暗的恐惧。连闭眼休憩时的片刻黑暗都让她难以忍受。\n「尽管笑好了！你们根本就不懂，那个黑色的……黑色的……有多可怕。」"
  },
  Skill_4591_Desc_0 = {
    Text = "温柯尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：温柯尔造成的护盾和反击提高 10％，打出卡牌后获得 <Energy:[Energy:Arg2]> 点狂气和 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4591_Desc_15 = {
    Text = "温柯尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：温柯尔造成的护盾和反击提高 10％，打出卡牌后获得 <Energy:[Energy:Arg2]> 点狂气和 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。使狂气最低的其他唤醒体获得 80 狂气。"
  },
  Skill_4591_EffectNameList = {
    Text = "狂气,反击"
  },
  Skill_4591_Name = {
    Text = "自我封锁"
  },
  Skill_4591_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4592_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，在后排召唤「求告者」。"
  },
  Skill_4592_Name = {
    Text = "分裂打击"
  },
  Skill_4594_Desc = {
    Text = "为对方添加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4594_Name = {Text = "毒素"},
  Skill_4597_Desc = {
    Text = "全体友方获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4597_Name = {
    Text = "全体强化"
  },
  Skill_4598_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4599_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4601_AwakerSkillBackgroundStory = {
    Text = "「群星与卡达斯皆已做好准备。承蒙选召的眷族啊，你将辉耀返生……」\n从那时起，她的艺术只剩下唯一的母题。\n她在狂想中纵情忘我，她在幻梦中潸然泪下。"
  },
  Skill_4601_Desc_0 = {
    Text = "珊获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕数量上限 +1。珊造成的护盾提高 [Arg3]％。珊每次造成护盾 <TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_4601_Desc_15 = {
    Text = "珊获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕数量上限 +1。珊造成的护盾和最终伤害提高 [Arg3]％，每拥有 1 条永久触腕额外提高 3％。珊每次造成护盾 <TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。"
  },
  Skill_4601_EffectNameList = {
    Text = "狂气,触腕伤害"
  },
  Skill_4601_Name = {
    Text = "忘我之境"
  },
  Skill_4601_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4602_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，吸收所有教徒。"
  },
  Skill_4602_Name = {
    Text = "苦痛永存"
  },
  Skill_4603_AwakerSkillBackgroundStory = {
    Text = "这绿炎已是构成她的一部分。\n若她指引，随处皆可点燃。"
  },
  Skill_4603_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4603_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气，施加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4603_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莉兹获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4603_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。莉兹获得 <Energy:[Energy:Arg2]> 点狂气，施加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4603_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4603_Name = {Text = "打击"},
  Skill_4603_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4604_AwakerSkillBackgroundStory = {
    Text = "「奥吉尔真是好孩子，不如长大后你成为我女儿的骑士吧——她很喜欢你。」\n「子爵家的小孩啊？骑士团可不会因为年幼就减轻训练的哦。」\n「干得不错嘛！看样子，奥吉尔未来会由公主亲自册封吧。」\n「不要后退，守住行宫！不要让任何人靠近公主！」\n「谢谢你，奥吉尔……够了，让我来保护你吧……」"
  },
  Skill_4604_Desc_0 = {
    Text = "奥吉尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg3] 点<PowerIconKeywords:力量>，奥吉尔打出卡牌后，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4604_Desc_15 = {
    Text = "奥吉尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg3] 点<PowerIconKeywords:力量>，奥吉尔打出卡牌后，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。在本场战斗触发死亡抵抗后，奥吉尔的狂气爆发获得的临时<PowerIconKeywords:力量>提高为 3 倍。"
  },
  Skill_4604_EffectNameList = {
    Text = "狂气,力量,卡牌获得力量"
  },
  Skill_4604_Name = {
    Text = "骑士热诚"
  },
  Skill_4604_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue3,攻击力*GrowValue2"
  },
  Skill_4605_Desc = {
    Text = "向随机唤醒体施加 1 层临时封印，重复 2 次。"
  },
  Skill_4605_Name = {Text = "封印"},
  Skill_4606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4607_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg2] 倍力量加成，施加 [Arg3]％ 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4607_EffectNameList = {Text = "伤害"},
  Skill_4607_Name = {
    Text = "千面幻象"
  },
  Skill_4607_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4608_Desc = {Text = "无"},
  Skill_4609_Desc = {
    Text = "自身获得 [Arg1] 点<PowerIconKeywords:力量>。移除敌人一半的<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>状态。"
  },
  Skill_4609_Name = {
    Text = "强者为尊"
  },
  Skill_4610_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4610_Name = {
    Text = "虚弱一击"
  },
  Skill_4611_Desc = {
    Text = "所有唤醒体获得 20 狂气。击晕「分裂患者」。"
  },
  Skill_4611_Name = {
    Text = "镇定之铃"
  },
  Skill_46128_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，在后排召唤「多维者」。"
  },
  Skill_46128_Name = {
    Text = "维度分形"
  },
  Skill_46129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，在后排召唤「多维者」。"
  },
  Skill_46129_Name = {
    Text = "维度分形"
  },
  Skill_4612_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_46130_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量>，自身获得 <Block:[Block:Arg2]> 护盾 。"
  },
  Skill_46130_Name = {
    Text = "全体强化"
  },
  Skill_46131_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_46135_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 护盾。"
  },
  Skill_4613_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4614_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4615_AwakerSkillBackgroundStory = {
    Text = "菲茵特是残缺的。\n\n菲茵特是危险的。\n菲茵特是被诅咒的。\n菲茵特，是来自群星的，最诡谲而缤纷的一道色彩。"
  },
  Skill_4615_BattleDesc_15 = {
    Text = "菲茵特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻永久偷取所有敌人 [Arg4] 点<PowerIconKeywords:力量>。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。本场战斗死亡抵抗触发衰减率从 50% 降低为 45%。菲茵特打出卡牌时，<TouquKeywords:偷取>所有敌人 [Arg2] 点<PowerIconKeywords:力量>。回合结束时，对前排敌方触发 50% <RetaliateIconKeywords:反击>。"
  },
  Skill_4615_Desc_0 = {
    Text = "菲茵特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。本场战斗死亡抵抗触发衰减率从 50% 降低为 45%。菲茵特打出卡牌时，<TouquKeywords:偷取>所有敌人 [Arg2] 点<PowerIconKeywords:力量>。回合结束时，对前排敌方触发 50% <RetaliateIconKeywords:反击>。"
  },
  Skill_4615_Desc_15 = {
    Text = "菲茵特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻永久偷取所有敌人 [Arg4] 点<PowerIconKeywords:力量>。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。本场战斗死亡抵抗触发衰减率从 50% 降低为 45%。菲茵特打出卡牌时，<TouquKeywords:偷取>所有敌人 [Arg2] 点<PowerIconKeywords:力量>。回合结束时，对前排敌方触发 50% <RetaliateIconKeywords:反击>。"
  },
  Skill_4615_EffectNameList = {
    Text = "狂气,反击,偷取力量"
  },
  Skill_4615_Name = {
    Text = "无边星彩"
  },
  Skill_4615_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue3,攻击力*GrowValue2"
  },
  Skill_4616_Desc = {
    Text = "获得 [Arg1] 点护盾，造成未被格挡的伤害时回复 3 倍伤害的生命，持续 [Arg2] 回合，前进。"
  },
  Skill_4616_Name = {
    Text = "手术准备"
  },
  Skill_4617_AwakerSkillBackgroundStory = {
    Text = "在水手绝望的哭声中，她安静地注视着，等待着。\n平静的海面冒起气泡，巨大的触腕从中升起，迅速交缠于桅杆之上，并在海风中展开成崭新的船帆。\n「启航，启航！」海员们唱道，「我们于幻影中启航！」"
  },
  Skill_4617_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。临时<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg2]。所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>。激发 1 条触腕攻击敌人，造成 [Arg3]％ 触腕伤害。"
  },
  Skill_4617_EffectNameList = {
    Text = "回复,临时触腕伤害"
  },
  Skill_4617_Name = {
    Text = "永存的幻影"
  },
  Skill_4617_PropertyNameList = {
    Text = "体质*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4618_AwakerSkillBackgroundStory = {
    Text = "你曾在某个时刻觉得自己是聚光灯的焦点、宇宙的中心、上帝的宠儿么？\n对莱克来说，就是轻轻瞄了一眼底牌，然后坦然揭开的时刻。"
  },
  Skill_4618_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 1~[Arg4] 次，获得 <Energy:[Energy:Arg2]> 点狂气。若造成 6 次或以上伤害，获得 1 张算力消耗为 0 附加消耗的「意外收获」。"
  },
  Skill_4618_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 1~[Arg4] 次，获得 <Energy:[Energy:Arg2]> 点狂气，每次暴击，额外获得 <Energy:[Arg3]> 点狂气。若造成 6 次或以上伤害，获得 1 张算力消耗为 0 附加<DepleteIconKeywords:消耗>的「意外收获」。"
  },
  Skill_4618_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4618_Name = {
    Text = "摊牌时刻"
  },
  Skill_4618_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4620_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4621_Desc = {
    Text = "造成 [Arg1] 层<IntoxicationIconKeywords:中毒>，对抽牌堆和弃牌堆中随机 [Arg2] 张卡牌施加「<SlowIconKeywords:迟缓>」"
  },
  Skill_4621_Name = {
    Text = "迟滞入骨"
  },
  Skill_4622_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每当造成未被格挡的伤害，就会造成 1 层<FragileIconKeywords:脆弱>。"
  },
  Skill_4622_Name = {
    Text = "永恒狂猎"
  },
  Skill_4624_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4625_Desc = {
    Text = "获得 1 点算力，将 1 张「症状：癔想」加入弃牌堆中。无法出售。"
  },
  Skill_4625_Name = {
    Text = "症状：癔想"
  },
  Skill_4626_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，抽牌堆和弃牌堆的所有卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4626_Name = {
    Text = "万古之眸"
  },
  Skill_4627_AwakerSkillBackgroundStory = {
    Text = "当献媚者乞怜时，勿要得意。\n当献媚者凝望时，勿要羞涩。\n当献媚者拥抱时，勿要逃避。\n献媚者所思所为仅通向唯一的终点，那里没有你的位置，只有潮水一样汹涌的悲伤与堕落。"
  },
  Skill_4627_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命。驱散自身<VulnerabilityIconKeywords:易伤>状态。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命，驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_EffectNameList = {
    Text = "回复,力量"
  },
  Skill_4627_Name = {
    Text = "献媚者之拥"
  },
  Skill_4627_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg5] 点<PowerIconKeywords:力量>。所有唤醒体的暴击率与暴击伤害 +[Arg6]%。"
  },
  Skill_4627_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg5] 点<PowerIconKeywords:力量>。所有唤醒体的暴击率与暴击伤害 +[Arg6]%。"
  },
  Skill_4627_PropertyNameList = {
    Text = "体质*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4627_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4627_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg2] 点<PowerIconKeywords:力量>和 [Power:Arg7] 点<PowerIconKeywords:临时力量> 。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg5] 点<PowerIconKeywords:力量>。所有唤醒体的暴击率与暴击伤害 +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg5] 点<PowerIconKeywords:力量>。所有唤醒体的暴击率与暴击伤害 +[Arg6]%。"
  },
  Skill_4627_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬>：回复 [Arg4]% 已损失的生命(<Heal:[Arg3]>)。驱散自身<VulnerabilityIconKeywords:易伤>状态。本次「献媚者之拥」获得的力量翻倍。】回复 <Heal:[Heal:Arg1]> 点生命。获得 [Power:Arg5] 点<PowerIconKeywords:力量>和 [Power:Arg7] 点<PowerIconKeywords:临时力量> 。所有唤醒体的暴击率与暴击伤害 +[Arg6]%。"
  },
  Skill_4628_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg3] 次，并获得 1 层疯狂。"
  },
  Skill_4629_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每当造成未被格挡的伤害，就会造成 1 层<FragileIconKeywords:脆弱>。"
  },
  Skill_4629_Name = {Text = "追猎"},
  Skill_4630_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4631_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4632_Desc = {
    Text = "获得 [Arg1] 点护盾，造成未被格挡的伤害时回复 3 倍伤害的生命，持续 [Arg2] 回合。"
  },
  Skill_4632_Name = {
    Text = "手术准备"
  },
  Skill_4633_Desc = {
    Text = "获得 [Arg1] 点护盾，将 1 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入抽牌堆。"
  },
  Skill_4633_Name = {
    Text = "手术准备"
  },
  Skill_4634_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4635_AwakerSkillBackgroundStory = {
    Text = "有某种远古的力量，在墨菲的体内苏生。\n被植埋的种子，日复一日成长为虚妄的蓓蕾。\n「既然被授以这样的力量，就让你们好好看看我的本事吧！」"
  },
  Skill_4635_Desc = {
    Text = "所有敌人伤害降低 [Arg1]%，但自身受到攻击时被施加一半伤害的<SacrificeKeyWord:献祭>，持续 1 回合。获得 <Block:[Block:Arg2]> 点护盾，使所有触腕攻击 1 次。"
  },
  Skill_4635_EffectNameList = {Text = "护盾"},
  Skill_4635_Name = {
    Text = "虚妄继承者"
  },
  Skill_4635_OverLimitUtlSkillDesc = {
    Text = "所有敌人伤害降低 [Arg1]%，但自身受到攻击时被施加一半伤害的<SacrificeKeyWord:献祭>，持续 1 回合。获得 <Block:[Block:Arg2]> 点护盾，使所有触腕攻击 1 次。回合开始时，获得 <Block:[Block:Arg3]> 点护盾和 [Arg4] 点<TentacleInjurieIconKeywords:触腕伤害> ，生成 2 条临时触腕，持续 3 回合。"
  },
  Skill_4635_PropertyNameList = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4636_Desc = {
    Text = "抽到时失去 1 算力，抽 1 张牌。"
  },
  Skill_4636_Name = {Text = "迷惑"},
  Skill_4637_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4638_AwakerSkillBackgroundStory = {
    Text = "由整块精铁打造的利刃无比沉重，破空之时带起的气流甚至可以震碎岩石。\n我忠诚的伙伴，我可靠的巨刃啊，我们皆于黑暗中获得新生与无穷力量。今夜，我们将痛饮仇敌之血；今夜，我们将尽情杀戮。"
  },
  Skill_4638_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。<PowerIconKeywords:力量>在「巨刃之威」上发挥 [Arg2] 倍效果。此卡视为「打击」。"
  },
  Skill_4638_EffectNameList = {Text = "伤害"},
  Skill_4638_Name = {
    Text = "巨刃之威"
  },
  Skill_4638_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4639_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4641_Desc_0 = {
    Text = "对随机敌人造成 <Damage:[Damage:Arg2]> 伤害 [Arg1] 次。"
  },
  Skill_4641_EffectNameList = {Text = "伤害"},
  Skill_4641_Name = {
    Text = "鼠群冲击"
  },
  Skill_4641_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_46420_Desc_1 = {
    Text = "使一名目标获得 [Arg1] 层<PVPEntanglementKeywords:缠绕>。"
  },
  Skill_46420_Name_1 = {Text = "缠绕"},
  Skill_4642_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，弃掉对方所有的手牌。"
  },
  Skill_4642_Name = {Text = "离散"},
  Skill_46431_Desc_1 = {
    Text = "使一名目标获得 <Damage:[Damage:Arg1]> <PVPBleedingKeywords:出血>伤害。"
  },
  Skill_46431_Name_1 = {
    Text = "延迟伤害"
  },
  Skill_46432_Desc_1 = {
    Text = "使一名目标获得 <DelayKeywords:延迟 1>： <Block:[Block:Arg1]> 护盾。"
  },
  Skill_46432_Name_1 = {
    Text = "延迟护盾"
  },
  Skill_46433_Desc_1 = {
    Text = "让目标获得 1 层 <PVPEmptinessKeywords:空虚>。"
  },
  Skill_46433_Name_1 = {Text = "空虚"},
  Skill_4643_AwakerSkillBackgroundStory = {
    Text = "「不对，不对。这不是创作的逻辑。」\n雕塑家沉声说着，却不敢直视年轻徒弟的眼睛。\n那是怎样的一双眼呵——\n沉静如世界尽头的海洋，将垂死候鸟的挣扎尽收眼底。\n她知晓一切，却静默不语。"
  },
  Skill_4643_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 [Arg2] 条触腕。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg4]> 点狂气。"
  },
  Skill_4643_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，每有 1 条触腕，额外获得 [Arg3] 点护盾。获得 [Arg2] 条触腕。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg4]> 点狂气。"
  },
  Skill_4643_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 [Arg2] 条触腕。<RippleKeywords:余波>：获得等同于当前触腕数量的狂气。"
  },
  Skill_4643_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，每有 1 条触腕，额外获得 [Arg3] 点护盾。获得 [Arg2] 条触腕。<RippleKeywords:余波>：获得等同于当前触腕数量的狂气。"
  },
  Skill_4643_EffectNameList_0 = {Text = "护盾"},
  Skill_4643_EffectNameList_2 = {
    Text = "护盾,每条触腕护盾"
  },
  Skill_4643_Name = {
    Text = "美的怜悯"
  },
  Skill_4643_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,"
  },
  Skill_4643_PropertyNameList_2 = {
    Text = "防御力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4644_AwakerSkillBackgroundStory = {
    Text = "离港的船迷失在风中，离群的兽掀起巨浪。\n她的狂热几度影响了人类文明的存续，但她从不关心。\n对兽而言，没有比寻回栖息地更重要的事。"
  },
  Skill_4644_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害和等量的<IntoxicationIconKeywords:中毒>，享受 [Arg4]% <TentacleInjurieIconKeywords:触腕伤害>加成。生成 [Arg2] 条临时触腕。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]。"
  },
  Skill_4644_EffectNameList = {
    Text = "伤害,触腕伤害"
  },
  Skill_4644_Name = {
    Text = "狂热之海"
  },
  Skill_4644_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4645_BattleDesc = {
    Text = "失去 [Arg1] 点生命，所有唤醒体获得 10 狂气。无法出售。"
  },
  Skill_4645_Desc = {
    Text = "失去 10% 最大生命，所有唤醒体获得 10 狂气。无法出售。"
  },
  Skill_4645_Name = {
    Text = "症状：疯狂"
  },
  Skill_4646_AwakerSkillBackgroundStory = {
    Text = "在决斗中，通常是不需要防御姿态的，勇猛的进攻便是最好的防御。"
  },
  Skill_4646_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4646_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。萝坦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4646_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4646_Name = {Text = "打击"},
  Skill_4646_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4647_Desc = {
    Text = "它已经没有什么用了。弃掉或打出时将其<DepleteIconKeywords:消耗>。"
  },
  Skill_4647_Name = {Text = "石头"},
  Skill_4648_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4649_Desc = {
    Text = "自身死亡，分裂为 2 个生命与自身当前相等的「融蚀三角中蜡像」。"
  },
  Skill_4649_Name = {Text = "分裂"},
  Skill_4650_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4650_Name = {
    Text = "窒息之苦"
  },
  Skill_4651_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加 [Arg3] 层寄生。"
  },
  Skill_4651_Name = {
    Text = "附骨侵蚀"
  },
  Skill_4652_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，抽牌堆顶的 [Arg3] 张卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4652_Name = {
    Text = "凝滞诅咒"
  },
  Skill_4653_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4653_Name = {
    Text = "手术切割"
  },
  Skill_4654_Desc = {
    Text = "获得 [Arg1] 点护盾。莉莉召唤的黏液护盾，能且仅能抵御一次地狱犬的撕裂。真的……不会痛吗？"
  },
  Skill_4654_Name = {
    Text = "淤泥上的不灭之花"
  },
  Skill_4655_AwakerSkillBackgroundStory = {
    Text = "大海是深沉而静谧的，它承载着对生的渴望与对死的恐惧。\n但偏偏有人要用欢笑与玩弄填满海洋——在奥瑞塔发出如此邀请时，「陪她闹一场又何妨」的感觉总会涌上心头，顺势让简单的快乐填满胸腔。"
  },
  Skill_4655_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_4655_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。"
  },
  Skill_4655_EffectNameList = {
    Text = "伤害,后续伤害提升"
  },
  Skill_4655_Name = {
    Text = "喧嚣海洋"
  },
  Skill_4655_OverLimitUtlSkillDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。获得 [Power:Arg2] 点 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>，之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  Skill_4655_OverLimitUtlSkillDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。消耗抽牌堆和弃牌堆中最多 10 张「腺体分裂」，每张额外造成 1 次伤害。将 2 张「腺体分裂」置入手中。使「奥瑞塔」本场战斗后续造成的伤害提高 [Arg2] 点。获得 [Power:Arg2] 点 <PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点<TentacleInjurieIconKeywords:触腕伤害>，之后 5 次打出「腺体分裂」时，都会抽 1 张牌。"
  },
  Skill_4655_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4656_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4657_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量> 与 <Block:[Block:Arg2]> 护盾 。"
  },
  Skill_4657_Name = {
    Text = "全体强化"
  },
  Skill_4658_AwakerSkillBackgroundStory = {
    Text = "卡茜亚的双手空落落；\n卡茜亚的帽子空落落；\n卡茜亚的胸口空落落。\n空落落的卡茜亚装着空落落的快乐，在空落落的狂欢中进行空落落的表演。"
  },
  Skill_4658_Desc_0 = {
    Text = "卡茜亚获得 <Energy:[Energy:Arg1]> 点狂气，<ExaltIconKeywords:灵知觉醒>：卡茜亚每打出 1 张卡牌，获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_4658_Desc_15 = {
    Text = "卡茜亚获得 <Energy:[Energy:Arg1]> 点狂气，<ExaltIconKeywords:灵知觉醒>：卡茜亚每打出 1 张卡牌，获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>，所有唤醒体打出「打击」时都能触发该效果获得临时力量。"
  },
  Skill_4658_EffectNameList = {
    Text = "狂气,力量"
  },
  Skill_4658_Name = {
    Text = "演出序幕"
  },
  Skill_4658_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4659_AwakerSkillBackgroundStory = {
    Text = "——不过你还太弱了，不好好保护可不行啊。"
  },
  Skill_4659_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4659_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。萝坦获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4659_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4659_Name = {Text = "防御"},
  Skill_4659_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4659_tempBattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4659_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。本回合下 1 张「桀骜之刃」生效 2 次。"
  },
  Skill_4660_AwakerSkillBackgroundStory = {
    Text = "一二，一二……\n她手举托盘，踏着轻快的节奏穿梭在人潮中。\n宾客一刻不停地饮酒、唱歌，她一刻不停地上菜、微笑。\n这里一切都是金色的。金色的大厅、金色的葡萄酒、还有金色的裙摆。\n珈伦喜欢金色。她扬起练习过无数次的招牌微笑。\n「客官请慢用——！！」"
  },
  Skill_4660_Desc_0 = {
    Text = "移除所有手牌的<SlowIconKeywords:迟缓>状态。回复 <Heal:[Heal:Arg1]> 点生命。将 1 张<DerivativeCardKeywords_42:「奇妙料理」>置入手中。对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4660_Desc_3 = {
    Text = "移除所有手牌的<SlowIconKeywords:迟缓>状态。回复 <Heal:[Heal:Arg1]> 点生命。将 1 张<DerivativeCardKeywords_43:「奇妙料理」>置入手中。对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4660_EffectNameList = {
    Text = "回复,中毒"
  },
  Skill_4660_Name = {
    Text = "客官请慢用！"
  },
  Skill_4660_OverLimitUtlSkillDesc_0 = {
    Text = "移除所有手牌的<SlowIconKeywords:迟缓>状态。回复 <Heal:[Heal:Arg1]> 点生命。将 1 张<DerivativeCardKeywords_43:「奇妙料理」>置入手中。对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。将<DerivativeCardKeywords_42:「奇妙料理」>洗入抽牌堆和弃牌堆各 1 张。"
  },
  Skill_4660_OverLimitUtlSkillDesc_3 = {
    Text = "移除所有手牌的<SlowIconKeywords:迟缓>状态。回复 <Heal:[Heal:Arg1]> 点生命。将 1 张<DerivativeCardKeywords_43:「奇妙料理」>置入手中。对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。将<DerivativeCardKeywords_43:「奇妙料理」>洗入抽牌堆和弃牌堆各 1 张。"
  },
  Skill_4660_PropertyNameList = {
    Text = "体质*GrowValue1,攻击*GrowValue2"
  },
  Skill_4661_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层临时<RetaliateIconKeywords:反击>。"
  },
  Skill_4661_Name = {
    Text = "蜜糖色悲惨幻象"
  },
  Skill_4662_AwakerSkillBackgroundStory = {
    Text = "人们赞叹她的美貌，艳羡她的风情，但没有人会把一朵花苞当回事。\n在乡野间摇摆不定的骨朵，被人任意左右未来，被当做花农晋升的筹码。\n直到她于冠冕前绽放时，人们才惊觉自己已被钩刺划得鲜血淋漓。"
  },
  Skill_4662_BattleDesc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。回合结束时回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4662_BattleDesc_2 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，每造成 1 次伤害临时暴击率+5％。回合结束时回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4662_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次。回合结束时回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4662_Desc_2 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，每造成 1 次伤害临时暴击率+5％。回合结束时回复 <Heal:[Heal:Arg2]> 点生命"
  },
  Skill_4662_EffectNameList_0 = {
    Text = "伤害,回复"
  },
  Skill_4662_Name = {
    Text = "蔷薇之美"
  },
  Skill_4662_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,体质*GrowValue2"
  },
  Skill_4663_AwakerSkillBackgroundStory = {
    Text = "冰冷的机械取代了心脏，液压管内的油液取代了鲜血。她应该冰冷、理智、依照指令行事。\n但，一个外来的意志在她的躯壳内悄然而动。祂无需鲜血、无需温度，仅凭自己便能燃烧出非人的恶意。祂说：臣服吧，卑贱弱小的生物，然后毁灭在我的炙热电球中。"
  },
  Skill_4663_BattleDesc_0 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。获得 <Posse:[Arg2]> 点银钥能量。驱散自身<WeaknessIconKeywords:虚弱>状态。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_14:「机械武装-敛」>。"
  },
  Skill_4663_BattleDesc_1 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。获得 <Posse:[Arg2]> 点银钥能量。驱散自身<WeaknessIconKeywords:虚弱>状态。将 1 张艾瑞卡附加<DepleteIconKeywords:消耗>的「打击」置入手牌。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_14:「机械武装-敛」>。"
  },
  Skill_4663_Desc_0 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。获得等同于艾瑞卡银钥充能的银钥能量。驱散自身<WeaknessIconKeywords:虚弱>状态。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_14:「机械武装-敛」>。"
  },
  Skill_4663_Desc_1 = {
    Text = "获得 [Power:Arg1] 点临时<PowerIconKeywords:力量>。获得等同于艾瑞卡银钥充能的银钥能量。驱散自身<WeaknessIconKeywords:虚弱>状态。将 1 张艾瑞卡附加<DepleteIconKeywords:消耗>的「打击」置入手牌。每当有 1 张牌进入<DimensionalSpaceIconKeywords:超维空间>，变形为<DerivativeCardKeywords_14:「机械武装-敛」>。"
  },
  Skill_4663_EffectNameList_0 = {
    Text = "力量,戒备"
  },
  Skill_4663_EffectNameList_1 = {
    Text = "力量,戒备,打击卡等级"
  },
  Skill_4663_Name = {
    Text = "机械武装-放"
  },
  Skill_4663_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4663_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,$GrowValue3"
  },
  Skill_4664_AwakerSkillBackgroundStory = {
    Text = "无形的疫病悄无声息，带来无尽的痛苦与癫狂。\n\n主教夜不能寐，为自己无法带走人们的苦难而无比痛心。\n\n「仁慈的造主啊，拯救他们吧，我愿替他们承担一切苦痛与悲伤。」\n\n于是父神降「赐福」于他，让他执篆刻了神言的石板，行消苦消难之事。"
  },
  Skill_4664_Desc_0 = {
    Text = "萨尔瓦多获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：将 1 张<B02AFKeyWord:护以仁爱>置入手中。回合结束后，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_4664_Desc_15 = {
    Text = "萨尔瓦多获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：将 1 张<B02AFKeyWord:护以仁爱>置入手中。回合结束后，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。「造主的庇佑」和「受祝骨血」积攒的猩红熔炉提高 25%，「应消之苦」选择「超度」时每消耗 1% 最大生命的猩红熔炉所提高的最终伤害效果从 2% 提高为 5%。"
  },
  Skill_4664_EffectNameList = {
    Text = "狂气,力量"
  },
  Skill_4664_Name = {
    Text = "「赐福」"
  },
  Skill_4664_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_4665_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4665_Name = {
    Text = "缝合品的狂怒"
  },
  Skill_4666_AwakerSkillBackgroundStory = {
    Text = "「哼，让本大小姐好好教育教育你。」"
  },
  Skill_4666_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4666_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]。"
  },
  Skill_4666_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。墨菲获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4666_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。墨菲获得 <Energy:[Energy:Arg2]> 点狂气。<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg3]。"
  },
  Skill_4666_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4666_EffectNameList_2 = {
    Text = "伤害,狂气,触腕伤害"
  },
  Skill_4666_Name = {Text = "打击"},
  Skill_4666_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4666_PropertyNameList_2 = {
    Text = "攻击力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4667_AwakerSkillBackgroundStory = {
    Text = "那是超越一切维度的巨大迷宫。\n误入迷宫的旅者不得不面临一项无礼的交易。\n若回答「否」，旅人将永远困在迷宫里。\n若回答「是」，旅人将被植入亵渎的子嗣，并被抹除一切记忆。\n什么，你问交易的具体内容是什么？\n没人知道交易的具体内容，包括苍白的迷宫之主。\n交易，就只是交易而已。"
  },
  Skill_4667_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点<PowerIconKeywords:力量> 和 [Arg4] 点<AlertIconKeywords:戒备>。】获得 <Block:[Block:Arg2]> 点护盾。对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4667_EffectNameList = {
    Text = "力量,戒备,护盾,中毒"
  },
  Skill_4667_Name = {
    Text = "苍白的庇佑"
  },
  Skill_4667_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬>：获得 [Power:Arg1] 点<PowerIconKeywords:力量> 和 [Arg4] 点<AlertIconKeywords:戒备>。】获得 <Block:[Block:Arg2]> 点护盾。对所有敌人施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>。抽 2 张阿格里帕的非打击防御指令卡，使 2 张手中阿格里帕的非打击防御指令卡本回合算力消耗 -1。"
  },
  Skill_4667_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue4,防御力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4668_AwakerSkillBackgroundStory = {
    Text = "他不能接受自己竟差点死去。他应当无坚不摧，应当金刚不坏。如果人类的躯壳是他登上力量巅峰的阻碍，那就将躯体舍弃；如果抛弃族人可以换来他的强大，那就将过去埋葬。\n他将巨刃投入深海，借取非人的力量，誓要成为一切的主宰。\n就连那给予他力量的存在，未来都必将躺在他的脚下。"
  },
  Skill_4668_Desc = {
    Text = "选择：<O06_AFKeyWord1:篡夺>或<O06_AFKeyWord2:蛰伏>。将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。"
  },
  Skill_4668_EffectNameList = {
    Text = "临时力量"
  },
  Skill_4668_Name = {
    Text = "海渊之力"
  },
  Skill_4668_OverLimitUtlSkillDesc = {
    Text = "选择：<O06_AFKeyWord1:篡夺>或<O06_AFKeyWord2:蛰伏>。将 3 张<DerivativeCardKeywords_17:「巨刃之威」>置入手牌。选择「篡夺」时，置入手中的「巨刃之威」基础伤害提高 400%，算力消耗变为 0 。选择「蛰伏」时，不再置入「巨刃之威」，改为将 2 张「斩首重创」置入手中，并使其获得「消耗」、「预备 1」和「保留」。"
  },
  Skill_4668_PropertyNameList = {
    Text = "$GrowValue1%"
  },
  Skill_4669_AwakerSkillBackgroundStory = {
    Text = "她是心绪的载体，是情愫的延续。\n就放纵这浓墨流淌吧，就放纵这诗才挥霍吧。\n这世间未曾诉诸于口的话语，将从她的诗册开始。"
  },
  Skill_4669_Desc_0 = {
    Text = "奥尔拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 1 层当前情绪外其他情绪的<D06CardKeyWord1:隐喻>，每回合开始也会获得 1 层，每种<D06CardKeyWord1:隐喻>最多 3 层，每层<D06CardKeyWord1:隐喻>使诗篇<TransitionIconKeywords:跃迁>时消耗对应<D06CardKeyWord1:隐喻>并获得额外加成。"
  },
  Skill_4669_Desc_15 = {
    Text = "奥尔拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 1 层当前情绪外其他情绪的<D06CardKeyWord1:隐喻>，每回合开始也会获得 1 层，每种<D06CardKeyWord1:隐喻>最多 3 层，每层<D06CardKeyWord1:隐喻>使诗篇<TransitionIconKeywords:跃迁>时消耗对应<D06CardKeyWord1:隐喻>并获得额外加成。发动湮灭后奥尔拉本回合下一张指令卡触发跃迁效果。每当奥尔拉消耗 3 层或以上隐喻，使当前情绪光环效果临时提高 [Arg2]%，该效果无法叠加。"
  },
  Skill_4669_EffectNameList = {Text = "狂气"},
  Skill_4669_Name = {
    Text = "诗册序言"
  },
  Skill_4669_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4670_Desc = {
    Text = "自身死亡，分裂为三个生命与自身相当的「Ⅱ型融蚀体」。"
  },
  Skill_4670_Name = {Text = "分裂"},
  Skill_4672_Desc = {
    Text = "当前生命和护盾回到上回合结束时的状态。"
  },
  Skill_4672_Name = {
    Text = "过往回声"
  },
  Skill_4673_Desc = {
    Text = "为对方添加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4673_Name = {Text = "毒素"},
  Skill_4674_Desc = {
    Text = "将所有症状卡变化为<DerivativeCardKeywords_37:「窒息」>，窒息：1算力，回合结束时若还在手中对自身施加[Arg1]点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4674_Name = {
    Text = "沉逝苦海"
  },
  Skill_4675_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 2 张<DerivativeCardKeywords_24:「裂伤」>加入手牌。"
  },
  Skill_4675_Name = {
    Text = "双翼初张"
  },
  Skill_4676_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4677_Desc = {
    Text = "获得 1 点算力，抽 1 张牌。"
  },
  Skill_4677_Name = {Text = "灵感"},
  Skill_4678_AwakerSkillBackgroundStory = {
    Text = "他不放过任何一个捣碎敌人的机会。"
  },
  Skill_4678_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。尤乌哈希获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4678_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4678_Name = {Text = "打击"},
  Skill_4678_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4680_AwakerSkillBackgroundStory = {
    Text = "山风在迷宫的骸骨里窸窣作响，哀声叹息。\n她听着远方迷途旅人哀号的声音，打了第八千零一个哈欠。\n她啜饮痛苦，然后将它们一一归类、陈列。\n只有一个问题——无人知晓她的杰作，她是这里唯一的观众。\n唉——！\n她坐在迷宫的最深处，又打了一个哈欠。"
  },
  Skill_4680_Desc_0 = {
    Text = "阿格里帕获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：阿格里帕施加的<IntoxicationIconKeywords:中毒>提高 50%，回合结束后，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4680_Desc_15 = {
    Text = "阿格里帕获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：阿格里帕施加的<IntoxicationIconKeywords:中毒>提高 100%，回合结束后，获得 <Block:[Block:Arg2]> 点护盾，每回合中阿格里帕每造成或触发 1 次中毒，该护盾就提高 50%，最大 5 层。"
  },
  Skill_4680_EffectNameList = {
    Text = "狂气,护盾"
  },
  Skill_4680_Name = {
    Text = "迷途之旅"
  },
  Skill_4680_PropertyNameList = {
    Text = "$GrowValue1,防御力*GrowValue2"
  },
  Skill_4681_Desc = {
    Text = "你的长线作战已经引起了密境的注视…将一张症状卡永久置入你的牌库。"
  },
  Skill_4681_Name = {Text = "凝视"},
  Skill_4682_Desc = {
    Text = "封印四个唤醒体的狂气爆发 1 回合。"
  },
  Skill_4682_Name = {Text = "封印"},
  Skill_4683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4683_Name = {Text = "明灭"},
  Skill_4685_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。后撤。"
  },
  Skill_4686_AwakerSkillBackgroundStory = {
    Text = "「除了悲伤和苦难，这残酷的暴行无法带来任何帮助。终有一日，它必须终结。」"
  },
  Skill_4686_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4686_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，本场战斗每积攒 2 点猩红熔炉回复量，就使伤害提高 [Float:Arg3]。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4686_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。萨尔瓦多获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4686_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，本场战斗每积攒 2 点猩红熔炉回复量，就使伤害提高 [Float:Arg3]。萨尔瓦多获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4686_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4686_Name = {Text = "打击"},
  Skill_4686_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4687_Desc = {
    Text = "回合结束时若在手中，会将你尚在手中的牌变为<DerivativeCardKeywords_25:「石头」>。弃掉时将其<DepleteIconKeywords:消耗>。"
  },
  Skill_4687_Name = {
    Text = "渐渐石化"
  },
  Skill_4688_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。将 [Arg2] 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆。"
  },
  Skill_4688_Name = {Text = "疯狂"},
  Skill_4689_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。将 [Arg2] 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆。"
  },
  Skill_4689_Name = {Text = "疯狂"},
  Skill_4690_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4691_Desc = {
    Text = "抽 4 张牌。"
  },
  Skill_4691_Name = {
    Text = "不平等交换"
  },
  Skill_4692_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4693_Name = {
    Text = "桀骜之刃"
  },
  Skill_4694_AwakerSkillBackgroundStory = {
    Text = "在昏暗的新门监狱中，伦蒂尼恩随处可见的蜡油也是珍稀之物。\n既然珍稀，就要在用在关键之地，例如惩戒之时，用在不乖孩子的皮肤上。\n并非特制的蜡油，滴落时伴随悲惨的哀鸣啸叫，但在少女的耳中听来，却好似优雅的诗章。"
  },
  Skill_4694_BattleDesc_0 = {
    Text = "获得 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，每有 1 名敌人获得 [Power:Arg1] 点<PowerIconKeywords:临时力量>。移除所有敌人<RetaliateIconKeywords:反击>状态。"
  },
  Skill_4694_BattleDesc_2 = {
    Text = "获得 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。临时降低所有敌人 [Exhaustion:Arg1] 点<ExhaustionIconKeywords:力量>，每有 1 名敌人获得 [Power:Arg1] 点<PowerIconKeywords:临时力量>。移除所有敌人<RetaliateIconKeywords:反击>状态。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4694_Desc_0 = {
    Text = "获得 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。<TouquKeywords:偷取>所有敌人 [Arg1] 点<PowerIconKeywords:力量>并移除其<RetaliateIconKeywords:反击>状态。"
  },
  Skill_4694_Desc_2 = {
    Text = "获得 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。<TouquKeywords:偷取>所有敌人 [Arg1] 点<PowerIconKeywords:力量>并移除其<RetaliateIconKeywords:反击>状态。获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4694_EffectNameList = {
    Text = "偷取力量,反击"
  },
  Skill_4694_Name = {
    Text = "灼燃蜡滴之欲"
  },
  Skill_4694_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4695_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将一张<DerivativeCardKeywords_33:「救救我」>置入手牌。"
  },
  Skill_4695_Name = {Text = "救救我"},
  Skill_4697_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_4697_Name = {
    Text = "战欲难平"
  },
  Skill_4698_Desc = {
    Text = "获得 [Arg1] 层祈祷状态。祈祷：可用来强化技能，受到伤害失去一层，回合结束失去全部。"
  },
  Skill_4698_Name = {Text = "祈祷"},
  Skill_4701_AwakerSkillBackgroundStory = {
    Text = "那是扭曲的胚胎，是罪恶的种子。\n是鼓动的心跳，是澎湃的脉搏，是骨血相憎，命运倒缠。\n受造之物不具备选择的自由，她只能任由倒错的孕育发展。"
  },
  Skill_4701_Desc_0 = {
    Text = "墨菲获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，墨菲打出卡牌后，获得 1 条无视触腕上限的临时触腕，和等同于 1 算力消耗的银钥充能，每回合最多生效 3 次。"
  },
  Skill_4701_Desc_15 = {
    Text = "墨菲获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，墨菲打出卡牌后，获得 1 条无视触腕上限的临时触腕，和等同于 1 算力消耗的银钥充能，每回合最多生效 3 次。墨菲每回合首次打出的「螺湮逆流」伤害次数和「圣女作成」获得算力翻倍。"
  },
  Skill_4701_EffectNameList = {Text = "狂气"},
  Skill_4701_Name = {
    Text = "受造之物"
  },
  Skill_4701_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4702_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4702_Name = {
    Text = "石质分解"
  },
  Skill_4703_AwakerSkillBackgroundStory = {
    Text = "保护主人。保护主人。保护主人。\n即使满身伤痕，也要将命令执行到底。\n敌人很强大，那就展开更大的禁域，身体很疼痛，也不妨碍将命令贯彻到底。"
  },
  Skill_4703_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾并对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。直到下个回合开始，每受到 1 次攻击获得 [Arg3] 层<PainWord:忍耐>。"
  },
  Skill_4703_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾并对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。直到下个回合开始，每受到 1 次攻击获得 [Arg3] 层<PainWord:忍耐>。若生命低于 50%([Arg4])，额外获得 1 次护盾，施加的中毒翻倍。"
  },
  Skill_4703_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾并对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>，莉莉每有 1% 死亡抵抗，基础护盾提高 0.25%。直到下个回合开始，每受到 1 次攻击获得 [Arg3] 层<PainWord:忍耐>。"
  },
  Skill_4703_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾并对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>，莉莉每有 1% 死亡抵抗，基础护盾提高 0.25%。直到下个回合开始，每受到 1 次攻击获得 [Arg3] 层<PainWord:忍耐>。若生命低于 50% ，额外获得 1 次护盾，施加的中毒翻倍。"
  },
  Skill_4703_EffectNameList = {
    Text = "护盾,中毒,忍耐"
  },
  Skill_4703_Name = {
    Text = "黑沼禁域"
  },
  Skill_4703_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,防御力*GrowValue3"
  },
  Skill_4704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4705_Desc = {
    Text = "获得「神降仪式」状态，每回合提高力量。造成 [Arg1] 层<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤> 状态，将 3 张「执念」洗入牌库。"
  },
  Skill_4705_Name = {
    Text = "神降仪式·呼唤"
  },
  Skill_4706_Desc = {
    Text = "获得 [Arg2] 点护盾和获得状态「恶意放血」: 每造成一次未被格挡的伤害，附加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4706_Name = {
    Text = "航海料理"
  },
  Skill_4707_Desc = {
    Text = "莉莉会模仿玩家每回合打出的第一张唤醒体卡牌。"
  },
  Skill_4707_Name = {Text = "觉醒"},
  Skill_47090_Desc_1 = {
    Text = "这张卡的卡面会有特殊效果！"
  },
  Skill_47090_Name_1 = {Text = "效果3"},
  Skill_47091_Desc_1 = {
    Text = "这张卡的卡面会有特殊效果！"
  },
  Skill_47091_Name_1 = {Text = "效果2"},
  Skill_47092_Desc_1 = {
    Text = "这张卡的卡面会有特殊效果！"
  },
  Skill_47092_Name_1 = {Text = "效果1"},
  Skill_4709_Desc = {
    Text = "选择一名唤醒体，将其指令卡各 1 张置入手中。守密人和银钥的共鸣为唤醒体们带来了持续作战的勇气……"
  },
  Skill_4709_Name = {
    Text = "银钥共鸣"
  },
  Skill_4710_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，降低  [Arg3] 点临时<PowerIconKeywords:力量>，回合结束移除。"
  },
  Skill_4711_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4712_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_32:「黏糊糊的蜡油」>洗入对方抽牌堆。"
  },
  Skill_4712_Name = {
    Text = "隆重的接待"
  },
  Skill_4713_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得 [Arg2] 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_4714_AwakerSkillBackgroundStory = {
    Text = "惩戒，仅仅是他群星般纷繁的权能中，最微不足道的一个。"
  },
  Skill_4714_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，额外享受 [Arg4]% 触腕伤害和力量加成。获得 <Energy:[Energy:Arg2]> 点狂气。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4714_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，额外享受 [Arg4]% 触腕伤害和力量加成。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [TentaclePower:Arg3] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg3] 点临时<PowerIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4714_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，额外享受 [Arg4]% 触腕伤害和力量加成。图鲁获得 <Energy:[Energy:Arg2]> 点狂气。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4714_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，额外享受 [Arg4]% 触腕伤害和力量加成。图鲁获得 <Energy:[Energy:Arg2]> 点狂气。获得 [TentaclePower:Arg3] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg3] 点临时<PowerIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4714_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4714_EffectNameList_2 = {
    Text = "伤害,狂气,临时触腕伤害,临时力量"
  },
  Skill_4714_Name = {Text = "打击"},
  Skill_4714_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4714_PropertyNameList_2 = {
    Text = "攻击力*GrowValue1,$GrowValue2,攻击力*GrowValue3,攻击力*GrowValue3"
  },
  Skill_4715_AwakerSkillBackgroundStory = {
    Text = "主要用料：蓝纹奶酪 印度咖喱 新鲜蟾蜍腿若干\n准备步骤：将用料混合搅拌腌制七日，注入泥煤酒1盎司\n其他：摆盘是关键，将迷迭香拗成微笑的形状，切记，切记！"
  },
  Skill_4715_Desc = {
    Text = "对所有敌人施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>和 1 回合的<WeaknessIconKeywords:虚弱>，回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4715_EffectNameList_0 = {
    Text = "中毒,回复"
  },
  Skill_4715_Name = {
    Text = "蟾蜍炖菜"
  },
  Skill_4715_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,体质*GrowValue2"
  },
  Skill_4716_AwakerSkillBackgroundStory = {
    Text = "油门、刹车，正常；油箱，正常；发动机状态，良好。\n她准备好了，准备好出发，准备好冒险，准备好即将到来的所有未知。\n独轮车在她身下发出轰鸣，漆黑的履带高速旋转，以超然的速度向前奔去。"
  },
  Skill_4716_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。使当前的护盾提高 50%。对所有敌人触发 [Arg3]％ <RetaliateIconKeywords:反击>。"
  },
  Skill_4716_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。使当前的护盾提高 50%。对所有敌人触发 [Arg3]％ <RetaliateIconKeywords:反击>。自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤> 1 回合。"
  },
  Skill_4716_EffectNameList_0 = {
    Text = "护盾,反击"
  },
  Skill_4716_Name = {
    Text = "整装待发"
  },
  Skill_4716_OverLimitUtlSkillDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。无视护盾上限，使当前的护盾提高 50%。对所有敌人触发 [Arg4]％ <RetaliateIconKeywords:反击>。"
  },
  Skill_4716_OverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>。无视护盾上限，使当前的护盾提高 50%。对所有敌人触发 [Arg4]％ <RetaliateIconKeywords:反击>。自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤> 1 回合。"
  },
  Skill_4716_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4718_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4718_Name = {
    Text = "意外身故"
  },
  Skill_4719_AwakerSkillBackgroundStory = {
    Text = "习惯了以人类的身体行走后，萝坦花了很长时间寻找相称的武器。\n直到今日，她也不认为这对巨剑能配得上自己，凑合用用罢了。"
  },
  Skill_4719_Desc_0 = {
    Text = "对随机 1 名敌人造成 <Damage:[Damage:Arg1]> 点伤害，重复 [Arg3] 次。在本回合中每打出 1 张「打击」，算力消耗减少 1 点 。"
  },
  Skill_4719_Desc_1 = {
    Text = "对随机 1 名敌人造成 <Damage:[Damage:Arg1]> 点伤害，重复 [Arg3] 次。在本回合中每打出 1 张「打击」，算力消耗减少 1 点 。视为「打击」。"
  },
  Skill_4719_EffectNameList_0 = {Text = "伤害"},
  Skill_4719_Name = {
    Text = "桀骜之刃"
  },
  Skill_4719_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4720_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>加入对方抽牌堆。"
  },
  Skill_4720_Name = {
    Text = "致伤打击"
  },
  Skill_4721_AwakerSkillBackgroundStory = {
    Text = "在成为主祭时，弥利亚姆被赠予了这把匕首。"
  },
  Skill_4721_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 100% <TentacleInjurieIconKeywords:触腕伤害>加成。获得 <Energy:[Energy:Arg2]> 点狂气。<O07CardKeyWord:祭仪>：最终伤害提高 [Arg4]%/[Arg5]%/[Arg6]%。"
  },
  Skill_4721_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 100% <TentacleInjurieIconKeywords:触腕伤害>加成。弥利亚姆获得 <Energy:[Energy:Arg2]> 点狂气。<O07CardKeyWord:祭仪>：最终伤害提高 [Arg4]%/[Arg5]%/[Arg6]%。"
  },
  Skill_4721_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4721_Name = {Text = "打击"},
  Skill_4721_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4722_AwakerSkillBackgroundStory = {
    Text = "千万年的孤寂中，那人的出现犹如深海中乍现的幽光，点燃了沉寂已久的海床。\n为了一场公平的对决，萝坦甘愿屈居于人类的形体中，暗暗等待对手的成长——她渴望一场酣畅的战斗，已经太久太久了。"
  },
  Skill_4722_Desc_0 = {
    Text = "萝坦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：萝坦的伤害次数提高 [Arg2] 次。"
  },
  Skill_4722_Desc_15 = {
    Text = "萝坦获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：萝坦的伤害次数提高 [Arg2] 次。萝坦的「防御」使本回合下一张「桀骜之刃」生效 2 次。"
  },
  Skill_4722_EffectNameList = {Text = "狂气"},
  Skill_4722_Name = {
    Text = "战欲难平"
  },
  Skill_4722_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4723_Desc = {
    Text = "每有 1 层「狩猎印记」就获得 [Arg2] 点护盾。"
  },
  Skill_4723_Name = {
    Text = "蓄力回响"
  },
  Skill_4724_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_26:症状：「妄想」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4724_Name = {Text = "哭喊"},
  Skill_4725_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4726_Desc = {
    Text = "向狂气最高唤醒体施加 1 层临时封印，造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。"
  },
  Skill_4726_Name = {Text = "封印"},
  Skill_4727_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4727_Name = {Text = "噬咬"},
  Skill_4728_AwakerSkillBackgroundStory = {
    Text = "我已经舍弃作为人类的一切了！我将回归深海的怀抱！\n可是为什么，我的蜕变却失败了呢？\n是命运的嘲弄吗？还是我的愚蠢呢？\n疯狂的凯刻斯拥抱着破碎的戟刺，试图沉入海底。\n只要能回去，能被接纳，无论前方有多少障碍，他都会一一扫清。"
  },
  Skill_4728_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并获得等量的<RetaliateIconKeywords:反击>，享受 50% <TentacleInjurieIconKeywords:触腕伤害>加成。"
  },
  Skill_4728_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并获得等量的<RetaliateIconKeywords:反击>，享受 50% <TentacleInjurieIconKeywords:触腕伤害>加成。获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_4728_EffectNameList_0 = {Text = "伤害"},
  Skill_4728_EffectNameList_1 = {
    Text = "伤害,狂气"
  },
  Skill_4728_Name = {
    Text = "破碎沉戟"
  },
  Skill_4728_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4728_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4729_AwakerSkillBackgroundStory = {
    Text = "「是的，余曾如此向她许诺。」\n提及故国覆灭的那一日，幼王的神情愈发疲倦。\n「余只希望那番话能宽慰她死前的恐惧，未曾想过她会将此奉为圭臬……」"
  },
  Skill_4729_Desc_0 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。获得 [TentaclePower:Arg1] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg1] 点临时<PowerIconKeywords:力量>。若当前姿态为「静海」，额外使所有敌人在本回合中降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4729_Desc_3 = {
    Text = "驱散自身<WeaknessIconKeywords:虚弱>状态。获得 [TentaclePower:Arg1] 点临时<TentacleInjurieIconKeywords:触腕伤害>和 [Power:Arg1] 点临时<PowerIconKeywords:力量>。获得 [Arg2]％ 临时暴击率。若当前姿态为「静海」，额外使所有敌人在本回合中降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。<RippleKeywords:余波>：驱使 1 条触腕攻击敌方。"
  },
  Skill_4729_EffectNameList_0 = {
    Text = "临时触腕伤害,临时力量,力量降低"
  },
  Skill_4729_Name = {
    Text = "螺湮重临"
  },
  Skill_4729_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4731_Desc = {
    Text = "获得 [Arg1] 点护盾，<TouquKeywords:永久偷取> [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4731_Name = {
    Text = "蓄力回响"
  },
  Skill_4732_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4733_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4733_Name = {Text = "出血"},
  Skill_4734_Desc = {
    Text = "施加 [Arg2] 层<IntoxicationIconKeywords:中毒>。若仍然有其他敌人存在，牺牲自身进行寄生，并附加「被寄生」状态。"
  },
  Skill_4734_Name = {Text = "寄生"},
  Skill_4735_Desc = {
    Text = "施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，抽牌堆和弃牌堆顶的 [Arg3] 张卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_4735_Name = {
    Text = "万古之眸"
  },
  Skill_4736_Desc = {
    Text = "召唤两个「提灯」。"
  },
  Skill_4736_Name = {Text = "召唤"},
  Skill_4737_Desc = {
    Text = "消耗全部祈祷层数，每层施加 [Arg1] 的<BleedingIconKeywords:出血>"
  },
  Skill_4737_Name = {
    Text = "拥抱融蚀"
  },
  Skill_4738_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_4740_AwakerSkillBackgroundStory = {
    Text = "趋光本能让飞虫追逐着光亮，而那长明灯火又过于灼目，让人往往忽略了水面下暗流的汹涌……"
  },
  Skill_4740_Desc = {
    Text = "本回合内造成触腕伤害后，会对全体敌方施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_4740_EffectNameList = {
    Text = "中毒层数"
  },
  Skill_4740_Name = {
    Text = "深邃暗流"
  },
  Skill_4740_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4741_Desc = {
    Text = "回合结束时，若此卡牌仍在手中且本回合剩余的算力不少于 2 点，下回合额外抽 2 张牌。"
  },
  Skill_4741_Name = {
    Text = "症状：兴奋"
  },
  Skill_4742_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4742_Name = {Text = "强化"},
  Skill_4743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4744_AwakerSkillBackgroundStory = {
    Text = "她本不愿屈身，但最完美的复仇总是需要暂时的隐忍。"
  },
  Skill_4744_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4744_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气和 25% 临时暴击率。"
  },
  Skill_4744_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。希洛获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4744_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。希洛获得 <Energy:[Energy:Arg2]> 点狂气和 25% 临时暴击率。"
  },
  Skill_4744_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4744_Name = {Text = "防御"},
  Skill_4744_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_47455_Desc_1 = {
    Text = "使一名目标获得 <StrengthenKeywords:沙包>。"
  },
  Skill_47455_Name_1 = {Text = "沙包"},
  Skill_4745_AwakerSkillBackgroundStory = {
    Text = "两个意志在机械的躯壳内不断对抗挣扎：一个期望毁灭，一个不愿屈从。但渺小的人类不可能长久地胜利，她终将会被对方吞噬，成为一个只为毁坏存在的癫狂容器。\n于是她将所有电流全部释放。巨大的电弧笼罩在她的身上，短路的身躯响起电流的爆鸣，她向前抛出积蓄的能量，随即陷入短暂的失能。\n「无法动弹，就无法毁灭。」"
  },
  Skill_4745_Desc_0 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4745_Desc_2 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成。"
  },
  Skill_4745_EffectNameList_0 = {
    Text = "伤害,护盾"
  },
  Skill_4745_Name = {
    Text = "电磁爆破"
  },
  Skill_4745_OverLimitUtlSkillDesc_0 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg6]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg5]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。艾瑞卡的「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  Skill_4745_OverLimitUtlSkillDesc_2 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg6]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg5]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成。艾瑞卡的「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  Skill_4745_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4745_tempBattleDesc_1 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4745_tempBattleDesc_2 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成。"
  },
  Skill_4745_tempBattleDesc_3 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg2]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg1]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成，后续释放享受的力量与戒备加成额外提高 1 倍。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_1 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg6]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg5]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。艾瑞卡「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_2 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg6]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg5]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成。艾瑞卡「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  Skill_4745_tempOverLimitUtlSkillDesc_3 = {
    Text = "艾瑞卡获得 [Arg4]% 临时暴击率与暴击伤害。获得 <Block:[Block:Arg6]> 点护盾。对所有敌人造成 <Damage:[Damage:Arg5]> 伤害并施加 [Arg3] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。该技能额外享受 [Arg7] 倍<PowerIconKeywords:力量>和<AlertIconKeywords:戒备>加成，后续释放享受的力量与戒备加成额外提高 1 倍。艾瑞卡「基础打击」额外造成 1 次伤害，「基础防御」额外获得 1 次护盾，持续 3 回合。"
  },
  Skill_4746_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_28:症状：「崩溃」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4746_Name = {
    Text = "哭喊！！"
  },
  Skill_4747_Desc = {
    Text = "你的长线作战已经引起了密境的注视…造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得状态「愤怒」，敌方的力量将持续增长！"
  },
  Skill_4747_Name = {Text = "亵渎"},
  Skill_47484_Desc = {
    Text = "获得 2 点算力，抽 2 张牌。"
  },
  Skill_47484_Name = {
    Text = "高级灵感"
  },
  Skill_4748_AwakerSkillBackgroundStory = {
    Text = "孩子们会慢慢看穿童话的本质，理解神话背后的寓言。在人类的语言中，这个过程被称为「长大」。\n但也有孩子会愈发相信睡前故事，他们固执地认为天上真的有彩虹桥，真的有文明沉没深海。\n奥瑞塔喜欢这些故事，她要向更多的伙伴分享这份快乐。"
  },
  Skill_4748_Desc_0 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_4748_Desc_1 = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害> +[TentaclePower:Arg1]。弃掉所有手牌，抽取相同数量+1 的牌。将 1 张「腺体分裂」洗入弃牌堆。"
  },
  Skill_4748_EffectNameList = {
    Text = "触腕伤害,「腺体分裂」等级"
  },
  Skill_4748_Name = {
    Text = "同伴的力量"
  },
  Skill_4748_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4749_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4750_AwakerSkillBackgroundStory = {
    Text = "孕育吧，降生吧，繁衍吧。\n在日渐溶解的现实中，在步入昏暗的世界里，在即将新生的虚空中。\n你们的存在，是母亲牺牲的果，是母亲存续的因。\n圣洁之子啊，在新世界重生吧——在那无垢的，消弭了所有恐惧的新世界重生吧。"
  },
  Skill_4750_Desc_0 = {
    Text = "泰旖丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 1 张<DerivativeCardKeywords_10:圣洁之子> 。每当释放钥令时，将手中一个胚胎转化为<DerivativeCardKeywords_10:圣洁之子>。"
  },
  Skill_4750_Desc_15 = {
    Text = "泰旖丝获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：立刻获得 1 张<DerivativeCardKeywords_10:圣洁之子> 。每当释放钥令时，将手中一个胚胎转化为<DerivativeCardKeywords_10:圣洁之子>。「丰穰之仪」额外将 1 张复制置入手中。"
  },
  Skill_4750_EffectNameList = {Text = "狂气"},
  Skill_4750_Name = {
    Text = "目见母亲"
  },
  Skill_4750_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_47516_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，弃掉其他唤醒体的 [Arg1] 张卡牌，若成功弃牌则抽 [Arg2] 张牌。"
  },
  Skill_47516_Name_1 = {
    Text = "银鳕鱼的决心"
  },
  Skill_4751_AwakerSkillBackgroundStory = {
    Text = "别眨眼，仔细瞧，魔法的时刻已来到；\n白手套，黑礼帽，七彩扑克我凭空造。\n如彩带一般华丽，如亮片一般绚烂，\n这梦幻又疯狂的闪亮表演，保管你猜不透！"
  },
  Skill_4751_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，抽 [Arg2] 张牌，每抽到 1 张卡茜亚的指令卡就对随机敌人造成 <Damage:[Damage:Arg1]> 点伤害。使卡茜亚所有基础伤害提高 [Arg3]%。"
  },
  Skill_4751_Desc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，抽 [Arg2] 张牌，每抽到 1 张症状卡、状态卡或卡茜亚的指令卡就对随机敌人造成 <Damage:[Damage:Arg1]> 点伤害。使卡茜亚所有基础伤害提高 [Arg3]%。"
  },
  Skill_4751_EffectNameList_0 = {Text = "伤害"},
  Skill_4751_Name = {
    Text = "魔术嘉年华"
  },
  Skill_4751_OverLimitUtlSkillDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg4] 次，抽 [Arg2] 张牌，每抽到 1 张卡茜亚的指令卡就对随机敌人造成 <Damage:[Damage:Arg1]> 点伤害  [Arg4]  次。使卡茜亚所有基础伤害提高 [Arg3]%。之后 [Arg6] 次打出卡茜亚的指令卡后，获得 [Power:Arg5] 点力量。"
  },
  Skill_4751_OverLimitUtlSkillDesc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg4] 次，抽 [Arg2] 张牌，每抽到 1 张症状卡、状态卡或卡茜亚的指令卡就对随机敌人造成 <Damage:[Damage:Arg1]> 点伤害  [Arg4]  次。使卡茜亚所有基础伤害提高 [Arg3]%。之后 [Arg6] 次打出卡茜亚的指令卡后，获得 [Power:Arg5] 点力量。"
  },
  Skill_4751_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4752_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4753_AwakerSkillBackgroundStory = {
    Text = "尖刺是敌意，是挥向冒犯者的利刃。"
  },
  Skill_4753_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg3]% 反击加成。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4753_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg3]% 反击加成。凯刻斯获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4753_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4753_Name = {Text = "打击"},
  Skill_4753_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4754_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_4754_Name = {Text = "遗恨"},
  Skill_4755_AwakerSkillBackgroundStory = {
    Text = "弥利亚姆深深相信，这把匕首在无数的典仪中被倾注了神的力量。"
  },
  Skill_4755_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<O07CardKeyWord:祭仪>：使所有敌人临时降低 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_4755_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。弥利亚姆获得 <Energy:[Energy:Arg2]> 点狂气。<O07CardKeyWord:祭仪>：使所有敌人临时降低 [Exhaustion:Arg3]/[Exhaustion:Arg4]/[Exhaustion:Arg5] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_4755_EffectNameList = {
    Text = "护盾,狂气,力量降低"
  },
  Skill_4755_Name = {Text = "防御"},
  Skill_4755_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4756_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4756_Name = {Text = "试探"},
  Skill_4757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg2] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4758_AwakerSkillBackgroundStory = {
    Text = "她以新的姓名重生于世间，遮掩容貌，不复轮廓。\n流传于世间的，只有以她的口吻述说的诗篇。\n如此便已足够。\n诗人不必拥有形貌……他们本应隐形于浓墨之中，书页之后。"
  },
  Skill_4758_BattleDesc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>，临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:跃迁>：切换至情绪「惧」。"
  },
  Skill_4758_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>，临时降低所有敌人 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。<TransitionIconKeywords:跃迁>：切换至情绪「惧」。每消耗 1 层隐喻「惧」，额外获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4758_EffectNameList = {
    Text = "力量,力量降低,额外力量"
  },
  Skill_4758_Name = {
    Text = "诡谲诗篇"
  },
  Skill_4758_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4759_AwakerSkillBackgroundStory = {
    Text = "世界上存在着一种特殊的水母，在受伤后，其脱落的组织能再次发育为完整的水螅体。\n「奥瑞塔也会生水母！所以奥瑞塔也是水母！」\n在孩子认知世界的这个阶段，还是不要扫她的兴吧。"
  },
  Skill_4759_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4759_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。将 [Arg2] 张「腺体分裂」洗入弃牌堆。<RippleKeywords:余波>：获得 <Energy:[Energy:Arg3]> 点狂气。"
  },
  Skill_4759_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4759_Name = {
    Text = "腺体分裂"
  },
  Skill_4759_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4760_AwakerSkillBackgroundStory = {
    Text = "被艾继丝的玩偶长时间注视的事物，会出现从目光落点开始色彩化、纤维化的情况。一段时间后，该区域甚至会化作类似彩色毛线的物质，被玩偶所吸收。若不及时阻挡目光，被注视事物可能会完全解体，成为玩偶的一部分。\n\n据观察，仅艾继丝本人不会受到玩偶目光影响。"
  },
  Skill_4760_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 2 倍力量加成。若目标处于<VulnerabilityIconKeywords:易伤>，返还该牌消耗的算力并抽 1 张牌。"
  },
  Skill_4760_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 2 倍力量加成。若目标处于<VulnerabilityIconKeywords:易伤>，返还该牌消耗的算力并抽 1 张牌。目标每拥有 1 层<VulnerabilityIconKeywords:易伤>，额外使「石质分解」最终伤害提高 [Arg2]%，至多提高 500%。"
  },
  Skill_4760_EffectNameList = {Text = "伤害"},
  Skill_4760_Name = {
    Text = "石质分解"
  },
  Skill_4760_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，弃掉对方所有的手牌。"
  },
  Skill_4761_Name = {Text = "离散"},
  Skill_4762_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 点护盾。前进。"
  },
  Skill_4763_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg2] 倍力量加成，获得 [Arg3]％ 伤害的<RetaliateIconKeywords:临时反击>。"
  },
  Skill_4763_EffectNameList = {Text = "伤害"},
  Skill_4763_Name = {
    Text = "千面幻象"
  },
  Skill_4763_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4764_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg2] 倍力量加成。"
  },
  Skill_4764_EffectNameList = {Text = "伤害"},
  Skill_4764_Name = {
    Text = "千面幻象"
  },
  Skill_4764_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4765_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_29:症状：「呓语」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4765_Name = {
    Text = "哭喊！！！"
  },
  Skill_4766_Desc = {
    Text = "降低所有敌人 [Arg2] 点临时力量，将一张<DerivativeCardKeywords_30:症状：「休克」>置入手牌。“很痛吗？真可怜……哭出来就好啦！”"
  },
  Skill_4766_Name = {
    Text = "哭喊！！！！"
  },
  Skill_4767_AwakerSkillBackgroundStory = {
    Text = "防守，是为了将这场杀戮盛宴无限延长。毕竟，死人是无法享受任何欢愉的，不是么？"
  },
  Skill_4767_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4767_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。尤乌哈希获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4767_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4767_Name = {Text = "防御"},
  Skill_4767_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4768_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4768_Name = {
    Text = "遗恨围捕"
  },
  Skill_4769_AwakerSkillBackgroundStory = {
    Text = "她的都城是一个不断膨胀的废墟。\n梦想在这里彻底死去，废墟却对此一无所知。它只是尽职尽责地膨胀罢了。\n世界早已将它忘却。"
  },
  Skill_4769_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。可选择消耗<DreamGuide:梦引>层数触发<JingjinvwangKeywords1:深眠反击>或<JingjinvwangKeywords2:呓语回音>，若<DreamGuide:梦引>层数不足 5 层，则获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4769_EffectNameList = {
    Text = "护盾,反击,深眠反击获得狂气,临时反击百分比"
  },
  Skill_4769_Name = {
    Text = "死梦之都"
  },
  Skill_4769_OverLimitUtlSkillDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。无需消耗梦引，同时触发「<JingjinvwangKeywords3:催眠脉络>」、「<JingjinvwangKeywords1:深眠反击>」和「<JingjinvwangKeywords2:呓语回音>」。"
  },
  Skill_4769_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,$GrowValue3,$GrowValue4%"
  },
  Skill_4769_tempBattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。可选择消耗<DreamGuide:梦引>层数触发<JingjinvwangKeywords1:深眠反击>或<JingjinvwangKeywords2:呓语回音>，若<DreamGuide:梦引>层数不足 5 层，则获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4769_tempBattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。无需消耗梦引，同时触发「<JingjinvwangKeywords3:催眠脉络>」、「<JingjinvwangKeywords1:深眠反击>」和「<JingjinvwangKeywords2:呓语回音>」。旺达打出的下 2 张指令卡额外生效 1 次。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。无需消耗梦引，同时触发「<JingjinvwangKeywords3:催眠脉络>」、「<JingjinvwangKeywords1:深眠反击>」和「<JingjinvwangKeywords2:呓语回音>」。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。无需消耗梦引，同时触发「<JingjinvwangKeywords3:催眠脉络>」、「<JingjinvwangKeywords1:深眠反击>」和「<JingjinvwangKeywords2:呓语回音>」。"
  },
  Skill_4769_tempOverLimitUtlSkillDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Counterattack:Arg2] 层<RetaliateIconKeywords:反击>，本回合下次跃迁效果必定发动。无需消耗梦引，同时触发「<JingjinvwangKeywords3:催眠脉络>」、「<JingjinvwangKeywords1:深眠反击>」和「<JingjinvwangKeywords2:呓语回音>」。旺达打出的下 2 张指令卡额外生效 1 次。"
  },
  Skill_4770_AwakerSkillBackgroundStory = {
    Text = "在索蕾尔的沙龙中，散场前的轮舞是保留项目。\n在酒精与荷尔蒙的邀约下，无论是邻国王子、宫廷重臣还是近身女侍，都将牵手跳入舞池，纵情狂欢。\n琴声渐弱，沙龙散场，除了强权与跃出地平线的黎明微光，索蕾尔身边什么都没有留下。"
  },
  Skill_4770_Desc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:无限吞噬>：本次权欲轮舞的伤害次数+[Arg3] ，回复生命值+<Heal:[Heal:Arg6]>。】随机造成 <Damage:[Damage:Arg2]> 点伤害 [Arg1] 次。回合结束时回复 <Heal:[Heal:Arg4]> 点生命。"
  },
  Skill_4770_EffectNameList_0 = {
    Text = "伤害,回复,无限吞噬回复"
  },
  Skill_4770_EffectNameList_7 = {
    Text = "伤害,回复,每次伤害回复,无限吞噬回复"
  },
  Skill_4770_Name = {
    Text = "权欲轮舞"
  },
  Skill_4770_OverLimitUtlSkillDesc_0 = {
    Text = "【<UnlimitedDevouredIconKeywords:无限吞噬>：本次权欲轮舞的伤害次数 +[Arg3] ，回复生命值 +<Heal:[Heal:Arg6]> 点】随机造成 <Damage:[Damage:Arg2]> 点伤害 [Arg1] 次。回复 <Heal:[Heal:Arg4]> 点生命。使索蕾尔接下来 3 张指令卡生效 2 次。本次狂气爆发每造成 1 次伤害，回合结束时回复 <Heal:[Heal:Arg5]> 点生命。"
  },
  Skill_4770_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,体质*GrowValue2,体质*GrowValue4"
  },
  Skill_4770_PropertyNameList_7 = {
    Text = "攻击力*GrowValue1,体质*GrowValue2,体质*GrowValue3,体质*GrowValue4"
  },
  Skill_4771_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，当前生命若低于 25%([Arg3])，回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4771_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，当前生命若低于 25%，回复 <Heal:[Heal:Arg2]> 点生命。"
  },
  Skill_4771_Name = {
    Text = "注射守护"
  },
  Skill_4773_Desc = {
    Text = "向随机唤醒体施加 1 层临时封印，重复 2 次。"
  },
  Skill_4773_Name = {Text = "封印"},
  Skill_4774_AwakerSkillBackgroundStory = {
    Text = "她在湖水的中央种下腐败之物，吸引迷途旅人前往。\n吟游诗人说：\n就像礼盒掀开一角，奇珍异宝闪耀登场\n就像帷幕掀开一角，缠绵歌声纵情传唱"
  },
  Skill_4774_Desc_0 = {
    Text = "获得 [Counterattack:Arg1] 层<RetaliateIconKeywords:反击>。使所有敌人临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>，只有一个敌人时力量降低效果提高 50％。<TransitionIconKeywords:跃迁>：消耗 5 层<DreamGuide:梦引>，若成功则额外获得 [Arg3] 层<RetaliateIconKeywords:反击>，否则获得 2 层<DreamGuide:梦引>。"
  },
  Skill_4774_EffectNameList_0 = {
    Text = "反击,力量降低,额外反击"
  },
  Skill_4774_EffectNameList_2 = {
    Text = "反击,力量降低,额外反击"
  },
  Skill_4774_Name = {
    Text = "迷途之守"
  },
  Skill_4774_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4774_PropertyNameList_2 = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_4775_Desc = {
    Text = "选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4775_Name = {
    Text = "高维定向催化"
  },
  Skill_4776_AwakerSkillBackgroundStory = {
    Text = "施与受是主奴关系的关键部分。\n主人赏赐给奴隶的，无论是亲吻还是鞭笞，奴隶都要满怀爱意、感激涕零地收下。\n因为你并非真正的奴隶，而是追求快感的享乐者。"
  },
  Skill_4776_Desc_0 = {
    Text = "潘狄娅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>，潘狄娅每造成 1 次伤害，获得 [Counterattack:Arg2] 点<RetaliateIconKeywords:反击>。"
  },
  Skill_4776_Desc_15 = {
    Text = "潘狄娅获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>，潘狄娅每造成 1 次伤害，获得 [Counterattack:Arg2] 点<RetaliateIconKeywords:反击>。潘狄娅获得永久<RetaliateIconKeywords:反击>时，获得 [Arg4]％ 等量的力量。"
  },
  Skill_4776_EffectNameList = {
    Text = "狂气,反击,造成伤害获得反击"
  },
  Skill_4776_Name = {Text = "施与受"},
  Skill_4776_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue3,攻击力*GrowValue2"
  },
  Skill_4777_AwakerSkillBackgroundStory = {
    Text = "「要杀光，只要是黑色的，就要全部杀光……！不然死的就是我，死的就是我……」"
  },
  Skill_4777_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4777_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。造成的伤害享受 [Arg3]% 反击加成。"
  },
  Skill_4777_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。温柯尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4777_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。温柯尔获得 <Energy:[Energy:Arg2]> 点狂气。造成的伤害享受 [Arg3]% 反击加成。"
  },
  Skill_4777_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_4777_EffectNameList_1 = {
    Text = "伤害,狂气,反击加成"
  },
  Skill_4777_Name = {Text = "打击"},
  Skill_4777_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4777_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,$GrowValue2,$GrowValue3%"
  },
  Skill_4778_AwakerSkillBackgroundStory = {
    Text = "菲茵特不愿意离开摇篮，但好在，这摇篮本就和她是一体的——如菲茵特所有同族被孵化前那样。"
  },
  Skill_4778_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4778_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 50% 伤害的临时<RetaliateIconKeywords:反击>。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4778_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。菲茵特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4778_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg3] 次，获得 50% 伤害的临时<RetaliateIconKeywords:反击>。菲茵特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4778_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_4778_Name = {Text = "打击"},
  Skill_4778_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4780_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4780_Name = {
    Text = "布朗出动！"
  },
  Skill_47818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_47818_Name = {Text = "攻击"},
  Skill_4781_Desc = {
    Text = "施加 [Arg1] 层<BleedingIconKeywords:出血>。"
  },
  Skill_4781_Name = {Text = "出血"},
  Skill_47820_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_47820_Name = {Text = "攻击"},
  Skill_4782_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4784_AwakerSkillBackgroundStory = {
    Text = "再怎么模仿，人类的科技始终无法真正复刻独属于▼▼人的技术。汇聚了精神的仪器剧烈抖动，将力量赋予作战的伙伴，却不能让她摆脱这具人工的躯壳。\n曾经如呼吸一样自然的能力，如今却再也无法施展了。"
  },
  Skill_4784_Desc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态并获得 <Block:[Block:Arg1]> 点护盾。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。选择 1 名其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4784_Desc_3 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态并获得 <Block:[Block:Arg1]> 点护盾。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。选择 1 名其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气并使该唤醒体本回合释放 2 次狂气爆发后才会进入冷却。"
  },
  Skill_4784_EffectNameList = {
    Text = "护盾,狂气,反击"
  },
  Skill_4784_Name = {
    Text = "无形迁移"
  },
  Skill_4784_OverLimitUtlSkillDesc_0 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态并获得 <Block:[Block:Arg1]> 点护盾。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。选择 1 名其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气。使选择的唤醒体回合开始时获得 <Energy:[Energy:Arg4]> 点狂气，持续 3 回合。"
  },
  Skill_4784_OverLimitUtlSkillDesc_3 = {
    Text = "驱散自身<FragileIconKeywords:脆弱>状态并获得 <Block:[Block:Arg1]> 点护盾。获得 [Counterattack:Arg3] 层<RetaliateIconKeywords:反击>。选择 1 名其他唤醒体获得 <Energy:[Energy:Arg2]> 点狂气并使该唤醒体本回合释放 2 次狂气爆发后才会进入冷却。使选择的唤醒体回合开始时获得 <Energy:[Energy:Arg4]> 点狂气，持续 3 回合。"
  },
  Skill_4784_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_4785_AwakerSkillBackgroundStory = {
    Text = "「别靠近我……就算是为了你们的安全……别靠近我……」"
  },
  Skill_4785_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4785_BattleDesc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和等量的<RetaliateIconKeywords:反击>。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4785_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。菲茵特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4785_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和等量的<RetaliateIconKeywords:反击>。菲茵特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4785_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4785_Name = {Text = "防御"},
  Skill_4785_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4786_Name = {
    Text = "意外身故"
  },
  Skill_4787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4787_Name = {
    Text = "母体搜寻"
  },
  Skill_4788_Desc = {
    Text = "对双方各造成 [Arg1] 层<VulnerabilityIconKeywords:易伤>。获得「利刃Ⅲ」：若造成未被格挡的伤害，在抽牌堆顶添加 3 张<DerivativeCardKeywords_23:「伤口」>。持续 1 回合。"
  },
  Skill_4788_Name = {
    Text = "垂死之挣"
  },
  Skill_4789_AwakerSkillBackgroundStory = {
    Text = "没人说得清为什么那个镶嵌了泪滴状银芯的小熊玩偶，会在艾继丝被唤醒后变成这副样子。这或许与艾继丝身上的上位者力量有关，或许单纯是受到强大精神力量扭曲后产生的变形。\n\n无论如何，它似乎具有一定自我意识，时不时会在艾继丝不注意的时候剥离出一部分，散成一朵由毛线组成的烟花。"
  },
  Skill_4789_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>。<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]。"
  },
  Skill_4789_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害并施加 [Arg2] 回合的<VulnerabilityIconKeywords:易伤>。<EmbryoFusionIconKeywords:胚胎融合> +[Arg3]。当触发吞噬后，将「小小愿望」从弃牌堆置入手牌并使其算力消耗变为 0 点。"
  },
  Skill_4789_EffectNameList = {
    Text = "伤害,胚胎融合"
  },
  Skill_4789_Name = {
    Text = "小小愿望"
  },
  Skill_4789_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_4790_AwakerSkillBackgroundStory = {
    Text = "漆黑的黏液将她拖入深渊。群星在这里诞生，光线在这里死去。这里没有时间，没有生命。\n一个声音从远处走来，散发着黑色的光。\n它说：你将永远变得不同，因为你已经造访妖精的通道。\n她将在这里漫长地游荡。"
  },
  Skill_4790_Desc = {
    Text = "詹金获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：暴击率提高 [Arg2]% ，詹金每造成 1 次伤害，在本回合中暴击伤害便提高 [Arg3]%。"
  },
  Skill_4790_EffectNameList = {Text = "狂气"},
  Skill_4790_Name = {
    Text = "空间折叠"
  },
  Skill_4790_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4791_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_4791_Name = {Text = "出血"},
  Skill_4792_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4793_AwakerSkillBackgroundStory = {
    Text = "尖锐的荆刺即是最好的防御。"
  },
  Skill_4793_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4793_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。旺达获得 <Energy:[Energy:Arg2]> 点狂气。<TransitionIconKeywords:跃迁>：获得 1 层<DreamGuide:梦引>。"
  },
  Skill_4793_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_4793_Name = {Text = "防御"},
  Skill_4793_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4794_Desc = {
    Text = "从「破链一击」「绵长恨怨」「打击」「防御」中选择一张加入手牌并附加<DepleteIconKeywords:消耗>。"
  },
  Skill_4794_Name = {
    Text = "不规则形态"
  },
  Skill_4795_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 2 张<DerivativeCardKeywords_28:「症状:多疑」>洗入牌库。"
  },
  Skill_4795_Name = {
    Text = "猎颅诅咒"
  },
  Skill_4796_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_4796_Name = {Text = "深潜"},
  Skill_4797_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4798_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张<DerivativeCardKeywords_23:「伤口」>洗入抽牌堆。"
  },
  Skill_47996_Desc = {
    Text = "选择 1 个已解锁的钥令释放并使其生效 2 次，每个已解锁的钥令在本次探索中只能选择 1 次，不可选择初始携带的钥令。"
  },
  Skill_47996_Name = {
    Text = "未至遗忘的黎明"
  },
  Skill_4800_AwakerSkillBackgroundStory = {
    Text = "莱克坚信自己的胜利源于幸运女神的眷顾。\n就像每个最终倾家荡产的赌徒一样，他也坚信幸运女神不会移开目光。"
  },
  Skill_4800_Desc_0 = {
    Text = "莱克获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>。在本场战斗中，获得一个所选的<C05_zaowu:「混沌的遗赠」>造物，或是将一个已拥有的<C05_zaowu:「混沌的遗赠」>升级。"
  },
  Skill_4800_Desc_15 = {
    Text = "莱克获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>。在本场战斗中，获得一个所选的<C05_zaowu:「混沌的遗赠」>造物，或是将一个已拥有的<C05_zaowu:「混沌的遗赠」>升级，该效果连续执行 2 次。莱克的所有六面骰升级为八面骰。"
  },
  Skill_4800_EffectNameList = {
    Text = "狂气,力量"
  },
  Skill_4800_Name = {
    Text = "绝佳运气"
  },
  Skill_4800_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_48018_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4802_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_4803_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4804_AwakerSkillBackgroundStory = {
    Text = "火焰蔓延，将剧场的天穹映照成翡翠碧色，仿佛清晨里澄澈宁静的湖水。\n多少人曾为追逐这翡翠色的身影而来，又有多少人忽视那流畅而充满力量感的舞姿，只看见了隐约露出的白玉色胳膊和臆想中的裙下风光。\n而舞者只是如凝固般伫立在那里，以被绿炎吞噬的濒死身姿。"
  },
  Skill_4804_Desc_0 = {
    Text = "莉兹获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：莉兹每造成 [Arg2] 次伤害，便将 1 张具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「绿炎」>置入手牌，每回合最多触发 3 次。"
  },
  Skill_4804_Desc_15 = {
    Text = "莉兹获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：莉兹每造成 [Arg2] 次伤害，便将 1 张具有<DepleteIconKeywords:消耗>的<DerivativeCardKeywords_18:「绿炎」>置入手牌，每回合最多触发 3 次。莉兹每造成 3 次伤害还会使莉兹本场战斗造成的伤害提高 [Arg3] 点。"
  },
  Skill_4804_EffectNameList = {Text = "狂气"},
  Skill_4804_Name = {
    Text = "翡翠映像"
  },
  Skill_4804_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4806_Desc = {
    Text = "获得 [Arg1] 层<MadnessIconKeywords:疯狂>。将 [Arg2] 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆。"
  },
  Skill_4806_Name = {Text = "疯狂"},
  Skill_4807_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，并将其他唤醒体的「打击」置入手中。来自萝坦的鼓舞激发了大家的战意……"
  },
  Skill_4807_Name = {
    Text = "不竭战意"
  },
  Skill_48084_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48085_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 点护盾，洗入 1 张 <DerivativeCardKeywords_45:「维度闭锁」>到抽牌堆。"
  },
  Skill_48085_Name = {
    Text = "维度防壁"
  },
  Skill_48086_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，立刻获得 2 层<ResentChainsKeywords:怨恨锁链>状态。"
  },
  Skill_48086_Name = {
    Text = "维度之锁"
  },
  Skill_4808_AwakerSkillBackgroundStory = {
    Text = "双手可以握成拳头，牙齿可以在撕咬的时候造成伤害。\n不要小看落单的士兵，他们身上的每个部位都可以视作一个武器。\n她这么说着，展开了腿上的刀刃。"
  },
  Skill_4808_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。每点护盾使伤害提高 2 点。在本回合中每打出 1 张「防御」，算力消耗 -1。视为「打击」。"
  },
  Skill_4808_EffectNameList = {Text = "伤害"},
  Skill_4808_Name = {
    Text = "心眼利刃"
  },
  Skill_4808_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4809_Desc = {
    Text = "造成的伤害暴击率提高 [Arg1]%，暴击伤害提高 [Arg2]%。"
  },
  Skill_4809_Name = {Text = "暴击"},
  Skill_4810_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_4810_Name = {
    Text = "破碎沉戟"
  },
  Skill_4811_AwakerSkillBackgroundStory = {
    Text = "落单的老鼠在阴暗的角落里窜行，它瘦弱、渺小，一把扫帚就能将它轻易驱逐。\n流浪儿也是如此。\n渺小之中亦有力量，当流浪儿与老鼠组成搭档，她们也可以势不可挡。"
  },
  Skill_4811_Desc = {
    Text = "将 1 张造成 <Damage:[Damage:Arg1]> 点伤害 X+4 次的<DerivativeCardKeywords_12:「鼠群冲击」>洗入抽牌堆顶部。<TransitionIconKeywords:跃迁>：额外将 1 张「布朗出动」洗入抽牌堆顶部。"
  },
  Skill_4811_EffectNameList = {
    Text = "「鼠群冲击」伤害"
  },
  Skill_4811_Name = {
    Text = "集结鼠群"
  },
  Skill_4811_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4812_Desc = {
    Text = "额外享受 2 倍力量加成，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4812_EffectNameList = {Text = "力量"},
  Skill_4812_Name = {Text = "巨力"},
  Skill_4812_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4813_Name = {
    Text = "无上生祭"
  },
  Skill_4814_Desc = {
    Text = "选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_4814_Name = {
    Text = "定向催化"
  },
  Skill_48151_Desc_1 = {
    Text = "使一名目标获得 <StrengthenKeywords:行动封锁>。"
  },
  Skill_48151_Name_1 = {
    Text = "行动封锁"
  },
  Skill_4815_Desc = {
    Text = "临时暴击率 +[Arg1]%。在本场战斗中「断颈一击」和「千面幻象」的基础伤害提高 5%。"
  },
  Skill_4815_Name = {
    Text = "暴击推演"
  },
  Skill_4816_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层再生力：回合结束时回复等同于层数的生命，每失去 5 点生命减少 1 层。"
  },
  Skill_4816_Name = {Text = "深潜"},
  Skill_4817_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得<Block:[Block:Arg3]> 点护盾。前进。"
  },
  Skill_4818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg4] 次，赋予  [Arg2] 张卡牌「深潜印记」：打出后敌人获得临时<PowerIconKeywords:力量>。"
  },
  Skill_4818_Name = {
    Text = "深潜标记"
  },
  Skill_4819_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得<Flaw:破绽>：当回合内必定被暴击。"
  },
  Skill_4819_Name = {
    Text = "鼠群冲击"
  },
  Skill_4820_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！！"
  },
  Skill_4821_AwakerSkillBackgroundStory = {
    Text = "她的迷宫通往世界的每一个角落。\n密林里、图书馆地下、海底深处皆有入口。\n依靠那些误入迷宫的倒霉蛋，她才勉强勾勒出世界的面貌。\n旅人迷失在不断回旋的通道里，她迷失在不断变幻的故事里。\n她知晓一切，却再也无法离开迷宫半步。"
  },
  Skill_4821_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害和等量<IntoxicationIconKeywords:中毒>。每当触发吞噬时，将「苍白回旋」从弃牌堆置入手中。"
  },
  Skill_4821_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害和等量<IntoxicationIconKeywords:中毒>。<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg2]。每当触发吞噬时，将「苍白回旋」从弃牌堆置入手中。"
  },
  Skill_4821_EffectNameList_0 = {Text = "伤害"},
  Skill_4821_EffectNameList_3 = {Text = "伤害"},
  Skill_4821_Name = {
    Text = "苍白回旋"
  },
  Skill_4821_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4821_PropertyNameList_3 = {
    Text = "攻击力*GrowValue1"
  },
  Skill_4822_AwakerSkillBackgroundStory = {
    Text = "在无尽的流浪中，汀克特已经遗忘故乡的名字。\n在漫长的岁月中，宇宙已经遗忘那颗死去星球的名字。\n它和无数被融蚀被遗弃的星球一样，被统称为「荒星」。\n她的歌声，或许是那颗界外星球的最后一缕余音。"
  },
  Skill_4822_Desc_0 = {
    Text = "汀克特获得 <Energy:[Energy:Arg1]> 点狂气，<ExaltIconKeywords:灵知觉醒>：使汀克特的「打击」基础伤害提高 [Arg2]%，汀克特的所有牌获得 1 个随机效果，该效果将在战斗结束时移除。"
  },
  Skill_4822_Desc_15 = {
    Text = "汀克特获得 <Energy:[Energy:Arg1]> 点狂气，<ExaltIconKeywords:灵知觉醒>：使汀克特的「打击」基础伤害提高 [Arg2]%，汀克特的所有牌获得 1 个随机效果，该效果将在战斗结束时移除。汀克特每回合首次打出「技能」时生成 1 张算力消耗为 0 的临时「打击」，该「打击」的随机效果变为 2 倍。"
  },
  Skill_4822_EffectNameList = {Text = "狂气"},
  Skill_4822_Name = {
    Text = "界外之音"
  },
  Skill_4822_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4823_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4823_Name = {Text = "断念"},
  Skill_4824_AwakerSkillBackgroundStory = {
    Text = "莉兹还记得自己获得绿炎那天的景象。\n青色的火种在掌心升腾跃动，催促她去达成那压抑已久的愿望。"
  },
  Skill_4824_Desc_0 = {
    Text = "对随机敌人造成 <Damage:[Damage:Arg2]> 点<PunctureDamagewords:穿刺伤害> [Arg1] 次，施加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。算力不足时可以强行打出，效果改为获得 <Energy:[Energy:Arg4]> 点狂气并消耗。"
  },
  Skill_4824_Desc_1 = {
    Text = "对随机敌人造成 <Damage:[Damage:Arg2]> 点<PunctureDamagewords:穿刺伤害> [Arg1] 次，施加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。回合结束时若在手牌或<DimensionalSpaceIconKeywords:超维空间>，升级为「<DerivativeCardKeywords_20:死灭绿炎>」。算力不足时可以强行打出，效果改为获得 <Energy:[Energy:Arg4]> 点狂气并消耗。"
  },
  Skill_4824_EffectNameList = {Text = "伤害"},
  Skill_4824_Name = {
    Text = "腐化绿炎"
  },
  Skill_4824_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4825_AwakerSkillBackgroundStory = {
    Text = "灰色、粘稠、不驱而动、仿佛有生命力的潮水。\n只要被黏上，一定就会被侵染至骨髓吧……\n窥见此物之人，都会产生这样的感想。"
  },
  Skill_4825_Desc_0 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>并<VulnerabilityIconKeywords:易伤>所有敌人。<TransitionIconKeywords:跃迁>：改为：获得 [Power:Arg2] 点临时<PowerIconKeywords:力量>并<VulnerabilityIconKeywords:易伤>所有敌人。"
  },
  Skill_4825_EffectNameList = {
    Text = "力量,临时力量"
  },
  Skill_4825_Name = {
    Text = "异质潮汐"
  },
  Skill_4825_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4826_Desc = {
    Text = "状态卡。"
  },
  Skill_4826_Name = {Text = "惊厥"},
  Skill_4827_AwakerSkillBackgroundStory = {
    Text = "「对我们来说，汲取养分就如植物追逐阳光一般自然。」\n菲茵特无法理解同族口中的「追逐阳光」是怎样一种本能。\n她只知道，一旦将根扎入了猎物的身体，她就无法停下，无法停下，无法停下……"
  },
  Skill_4827_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。使所有敌人临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_4827_EffectNameList = {
    Text = "力量,失去临时力量"
  },
  Skill_4827_Name = {
    Text = "养分汲取"
  },
  Skill_4827_PropertyNameList = {
    Text = "攻击力*GrowValue1,防御力*GrowValue2"
  },
  Skill_4833_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 3 张<DerivativeCardKeywords_36:「亵渎假象」>加入手中。"
  },
  Skill_4833_Name = {
    Text = "异维瞪视"
  },
  Skill_4835_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4836_AwakerSkillBackgroundStory = {
    Text = "奥吉尔成为预备骑士时，身高尚不及马背；为了守护而牺牲时，也只勉强能举起长矛。\n能让幼小少年刺穿敌人盔甲的，是何等坚定的信念与意志呢？"
  },
  Skill_4836_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg3] 次，施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg3] 次，施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>，享受 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>，享受 2 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，施加 [Arg2] 回合<VulnerabilityIconKeywords:易伤>，享受 3 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_4836_EffectNameList = {Text = "伤害"},
  Skill_4836_Name = {
    Text = "穿刺之枪"
  },
  Skill_4836_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_4838_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4838_Name = {
    Text = "癫狂打击"
  },
  Skill_4839_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4840_AwakerSkillBackgroundStory = {
    Text = "这是本当属于自我之物，来自螺湮主宰的传承。\n腐朽之物，接受螺湮逆流的制裁吧。"
  },
  Skill_4840_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg4]% 的<TentacleInjurieIconKeywords:触腕伤害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。移除 [Arg3]%<SacrificeKeyWord:献祭>层数。"
  },
  Skill_4840_BattleDesc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg5] 次，每有 2 条触腕额外造成 1 次伤害，该伤害享受 [Arg4]% 的<TentacleInjurieIconKeywords:触腕伤害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。移除 [Arg3]% <SacrificeKeyWord:献祭>层数。"
  },
  Skill_4840_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 [Arg4]% 的<TentacleInjurieIconKeywords:触腕伤害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。移除 [Arg3]% <SacrificeKeyWord:献祭>层数。"
  },
  Skill_4840_Desc_1 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，每有 2 条触腕额外造成 1 次伤害，该伤害享受 [Arg4]% 的<TentacleInjurieIconKeywords:触腕伤害>加成。施加 [Arg2] 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。移除 [Arg3]% <SacrificeKeyWord:献祭>层数。"
  },
  Skill_4840_EffectNameList = {
    Text = "伤害,触腕伤害加成,移除「献祭」比例"
  },
  Skill_4840_Name = {
    Text = "螺湮逆流"
  },
  Skill_4840_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2％,$GrowValue3%"
  },
  Skill_4841_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4842_AwakerSkillBackgroundStory = {
    Text = "跨越维度的魔女，熟知维度中的折射规律。\n她清楚维度的每条路径，每个连接点。\n无限通道，都在她的脑海之中。\n既然如此，投射自其他维度的物质，对她而言自然是囊中之物。"
  },
  Skill_4842_Desc_0 = {
    Text = "达芙黛尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：每有 1 张达芙黛尔的牌进入<DimensionalSpaceIconKeywords:超维空间>后，将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中，每回合最多触发 2 次。"
  },
  Skill_4842_Desc_15 = {
    Text = "达芙黛尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：每有 1 张达芙黛尔的牌进入<DimensionalSpaceIconKeywords:超维空间>后，将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中，每回合最多触发 2 次。生成 1 张算力消耗为 0 的临时「断颈一击」置入超维空间。"
  },
  Skill_4842_EffectNameList = {Text = "狂气"},
  Skill_4842_Name = {
    Text = "维度投射"
  },
  Skill_4842_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4843_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将1张<DerivativeCardKeywords_31:「融蚀浆」>洗入抽牌堆。"
  },
  Skill_4844_AwakerSkillBackgroundStory = {
    Text = "等我受到召选，等我潜入深海，等我回归族群。\n我将享有永恒的安乐，你们这些无知的普通人，休想再欺凌我。\n怀着这样的憧憬，小小少年沉入幻想的梦乡。"
  },
  Skill_4844_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。直到下个回合开始，<RetaliateIconKeywords:反击>和触腕反击额外触发 [Arg2] 次，造成 50% 伤害。获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4844_EffectNameList = {
    Text = "护盾,力量"
  },
  Skill_4844_Name = {
    Text = "逆鳞之护"
  },
  Skill_4844_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4845_AwakerSkillBackgroundStory = {
    Text = "鲜血是与神灵联结的纽带。\n神之国土的再临，注定要以至纯至臻的生祭作为基石。"
  },
  Skill_4845_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>并施加等量<IntoxicationIconKeywords:中毒>。<O07CardKeyWord:祭仪>：获得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_4845_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>并施加等量<IntoxicationIconKeywords:中毒>。临时暴击伤害 +[Arg2]%。<O07CardKeyWord:祭仪>：获得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_4845_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>并施加等量<IntoxicationIconKeywords:中毒>。<O07CardKeyWord:祭仪>：获得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_4845_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>并施加等量<IntoxicationIconKeywords:中毒>。临时暴击伤害提高，数值等同于弥利亚姆原始暴击伤害的 15%。<O07CardKeyWord:祭仪>：获得 [Power:Arg3]/[Power:Arg4]/[Power:Arg5] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg3]/[TentaclePower:Arg4]/[TentaclePower:Arg5] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_4845_EffectNameList = {
    Text = "伤害,力量和触腕伤害"
  },
  Skill_4845_Name = {
    Text = "无上生祭"
  },
  Skill_4845_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_4846_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4846_Name = {
    Text = "黑泥冲蚀"
  },
  Skill_4847_AwakerSkillBackgroundStory = {
    Text = "回避不是什么丢人的事，不如说，正是有了一丝喘息的空间，她才得以推演出对手的行动。"
  },
  Skill_4847_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4847_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。拉蒙娜获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4847_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4847_Name = {Text = "防御"},
  Skill_4847_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_4848_AwakerSkillBackgroundStory = {
    Text = "让那些斯巴达人为自己的所作所为付出代价吧。\n你所赠予的并非怜悯，你所剥夺的并非恩赐。\n那是一名心怀憧憬的少女的人生，那是无数希洛人滚烫流淌的血泪。\n复仇者失去的唯有锁链。"
  },
  Skill_4848_Desc_0 = {
    Text = "希洛获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：希洛的卡牌获得<RetainIconKeywords:保留>，回合结束后，使「破链一击」的打击加成和「绵长恨怨」基础伤害提高 10% 。"
  },
  Skill_4848_Desc_15 = {
    Text = "希洛获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：打出时立刻使「破链一击」的打击加成和「绵长恨怨」的基础伤害提高 50%，回合结束后，使「破链一击」的打击加成和「绵长恨怨」基础伤害提高 10% 。希洛的卡牌获得<RetainIconKeywords:保留>。"
  },
  Skill_4848_EffectNameList = {Text = "狂气"},
  Skill_4848_Name = {
    Text = "复仇宣言"
  },
  Skill_4848_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4849_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 <Block:[Block:Arg3]> 护盾。"
  },
  Skill_4850_BattleDesc = {
    Text = "此卡牌暴击率和暴击伤害提高 50%，造成穿刺伤害。"
  },
  Skill_4850_Desc = {
    Text = "此卡牌暴击率和暴击伤害提高 50%，造成穿刺伤害。"
  },
  Skill_4850_Name = {
    Text = "穿刺暴击"
  },
  Skill_4851_Desc = {
    Text = "将 2 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆。"
  },
  Skill_4851_Name = {
    Text = "高维灵感"
  },
  Skill_4852_Desc = {
    Text = "获得  <Posse:[Arg1]>  点银钥能量。在本场战斗中「断颈一击」和「千面幻象」的基础伤害提高 10%。"
  },
  Skill_4852_Name = {
    Text = "高维钥能"
  },
  Skill_4853_Desc = {
    Text = "将 [Arg1] 张<DerivativeCardKeywords_80:「窒息」>置入对方手牌。"
  },
  Skill_4853_Name = {
    Text = "溺毙之怨"
  },
  Skill_4854_Desc = {
    Text = "选择 1 张抽牌堆的卡牌置入手牌并使其算力消耗 -1。"
  },
  Skill_4854_Name = {
    Text = "精算检索"
  },
  Skill_4855_Desc = {
    Text = "获得<Block:[Block:Arg1]> 点护盾，自身获得 [Arg2] 层「蜡质铠甲」：每层使受到的伤害降低 [Arg3]，每次被暴击后减少 1 层。"
  },
  Skill_4855_Name = {
    Text = "蜡像登场"
  },
  Skill_4856_AwakerSkillBackgroundStory = {
    Text = "庭院悬铃木沙沙摇晃，鸟雀啼鸣出春日的颂歌，玫瑰绽放时的芬芳自窄小的天窗栅栏沁入她的鼻腔。\n孤独的花房之中，繁花入眼，皆是诗篇。"
  },
  Skill_4856_Desc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。其他唤醒体获得 <Energy:[Energy:Arg3]> 点狂气，临时暴击率和暴击伤害 +[Arg4]%。在不同情绪下，纷华篇章的对应效果提高 150%。"
  },
  Skill_4856_Desc_3 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。其他唤醒体获得 <Energy:[Energy:Arg3]> 点狂气，临时暴击率和暴击伤害 +[Arg4]%。在不同情绪下，纷华篇章的对应效果提高 250%。"
  },
  Skill_4856_EffectNameList = {
    Text = "回复,力量"
  },
  Skill_4856_Name = {
    Text = "纷华篇章"
  },
  Skill_4856_OverLimitUtlSkillDesc_0 = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。其他唤醒体获得 <Energy:[Energy:Arg3]> 点狂气，临时暴击率和暴击伤害 +[Arg4]%。在不同情绪下，纷华篇章的对应效果提高 600%。获得 3 层万能「隐喻」：会在下次诗篇跃迁时被视为任意情绪的「隐喻」使用并<DepleteIconKeywords:消耗>。"
  },
  Skill_4856_PropertyNameList = {
    Text = "体质*GrowValue1, 攻击力*GrowValue2"
  },
  Skill_4857_Desc = {
    Text = "额外享受 4 倍力量加成，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_4857_EffectNameList = {Text = "力量"},
  Skill_4857_Name = {
    Text = "高维巨力"
  },
  Skill_4857_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_48581_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48581_Name = {
    Text = "扭曲的死体狂宴-混沌"
  },
  Skill_48582_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。额外造成 50% 未被完全格挡部分伤害的 <BleedingIconKeywords:出血>。"
  },
  Skill_48582_Name = {
    Text = "扭曲的死体狂宴-血肉"
  },
  Skill_48583_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使扭曲死体狂宴伤害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_48583_Name = {
    Text = "纷乱切割-躁狂"
  },
  Skill_48584_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 层<RetaliateIconKeywords:反击>。"
  },
  Skill_48584_Name = {
    Text = "扭曲的死体狂宴-超维"
  },
  Skill_48585_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。额外造成 [Arg3] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_48585_Name = {
    Text = "扭曲的死体狂宴-深海"
  },
  Skill_4858_AwakerSkillBackgroundStory = {
    Text = "女孩怀着不舍离开了破产的水族馆，作为工作酬劳，她被允许把几只水母带回家。\n这是她最喜欢的小小生灵，浮游幻海之灵，生生不息之花。\n只要悉心照料，它们会填满整个水缸！——她曾经期待着这样的景象。"
  },
  Skill_4858_Desc_0 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。"
  },
  Skill_4858_Desc_15 = {
    Text = "奥瑞塔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「腺体分裂」置入手中。奥瑞塔造成伤害时，使 [Arg2] 条触腕攻击 1 次。奥瑞塔的「打击」变为穿刺伤害，并且额外造成 3 次伤害。"
  },
  Skill_4858_EffectNameList = {Text = "狂气"},
  Skill_4858_Name = {
    Text = "自我增殖"
  },
  Skill_4858_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_48592_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_33:「救救我」>置入手牌。影子「24」 变得暴躁，所有行为都将得到强化，且会开始最猛烈的进攻。"
  },
  Skill_48592_Name = {
    Text = "狂躁人格"
  },
  Skill_48593_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使扭曲死体狂宴伤害增加 <Damage:[Damage:Arg3]> 。"
  },
  Skill_48593_Name = {
    Text = "纷乱切割"
  },
  Skill_48595_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48595_Name = {
    Text = "扭曲的死体狂宴"
  },
  Skill_4859_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_4859_Name = {
    Text = "丧钟遥鸣"
  },
  Skill_48600_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48600_Name = {
    Text = "异种共生"
  },
  Skill_4860_Desc = {
    Text = "恐惧，也是一种野兽的本能。"
  },
  Skill_4860_Name = {Text = "受惊"},
  Skill_4861_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_4861_Name = {
    Text = "脆弱打击"
  },
  Skill_4862_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_4863_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_4863_Name = {
    Text = "猎矛突刺"
  },
  Skill_4864_AwakerSkillBackgroundStory = {
    Text = "哲学是一个没有正确答案的学科。\n它是一条源自文明起点的河流，在不同的河段，人类向其中倾倒了不同的河水。\n而她正在挖掘属于自己的河道。\n也许，她在未来某日能够参透自己的存在本质；也许，这一天永远不会到来。"
  },
  Skill_4864_Desc_0 = {
    Text = "拉蒙娜获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：拉蒙娜打出卡牌后，获得 1 点算力，每回合最多触发 3 次。"
  },
  Skill_4864_Desc_15 = {
    Text = "拉蒙娜获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：拉蒙娜打出卡牌后，获得 1 点算力并使拉蒙娜造成的基础伤害提高 10%，每回合最多触发 3 次。"
  },
  Skill_4864_EffectNameList = {Text = "狂气"},
  Skill_4864_Name = {
    Text = "第一哲学"
  },
  Skill_4864_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_4865_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张<DerivativeCardKeywords_3:「惊厥」>洗入抽牌堆。"
  },
  Skill_4865_Name = {Text = "惊厥"},
  Skill_4866_Desc = {
    Text = "自身死亡，其他友方造成等同最大生命的回复。"
  },
  Skill_4866_Name = {Text = "牺牲"},
  Skill_4867_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_4868_Desc = {
    Text = "全体获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  Skill_4868_Name = {
    Text = "全体力量"
  },
  Skill_4869_AwakerSkillBackgroundStory = {
    Text = "「不要不要不要不要过来——」"
  },
  Skill_4869_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4869_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。温柯尔获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_4869_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_4869_Name = {Text = "防御"},
  Skill_4869_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_48812_Desc = {
    Text = "当没有「胚胎」时，可被<DevouredIconKeywords:吞噬>并触发 2 次效果。直接打出或自动转化时视为「胚胎」的 1.5 倍效果。"
  },
  Skill_48812_Name = {
    Text = "圣洁之子"
  },
  Skill_48812_tempBattleDesc_1 = {
    Text = "当没有「胚胎」时，可被<DevouredIconKeywords:吞噬>并触发 2 次<DevouredIconKeywords:吞噬>效果。直接打出或自动转化时视为「胚胎」的 1.5 倍效果。"
  },
  Skill_48812_tempBattleDesc_2 = {
    Text = "当没有「胚胎」时，可被<DevouredIconKeywords:吞噬>并触发 2 次<DevouredIconKeywords:吞噬>效果。打出后选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。唤醒体每回合首次消耗「胚胎」或「圣洁之子」时，获得 [Arg3] 层<BreedingKeywords1:繁育庆典>。"
  },
  Skill_48812_tempName_1 = {
    Text = "圣洁之子"
  },
  Skill_48812_tempName_2 = {
    Text = "繁育· 圣洁之子"
  },
  Skill_48813_Desc = {
    Text = "<VulnerabilityIconKeywords:易伤>所有敌人 [Arg1] 回合。"
  },
  Skill_48813_Name = {
    Text = "溃烂之血"
  },
  Skill_48814_Desc = {
    Text = "<WeaknessIconKeywords:虚弱>所有敌人 [Arg1] 回合。"
  },
  Skill_48814_Name = {
    Text = "恐惧之血"
  },
  Skill_48815_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合> +[Blood:Arg1]。"
  },
  Skill_48815_Name = {
    Text = "生殖之血"
  },
  Skill_48857_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48857_Name = {
    Text = "疯狂嗜血之爪"
  },
  Skill_48858_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次！获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_48858_Name = {
    Text = "疯狂狂乱之咬"
  },
  Skill_48859_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48860_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48860_Name = {Text = "强化"},
  Skill_48882_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48883_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48884_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48884_Name = {Text = "强化"},
  Skill_48885_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48885_Name = {Text = "强化"},
  Skill_48893_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48894_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48894_Name = {Text = "强化"},
  Skill_48895_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48896_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48896_Name = {Text = "强化"},
  Skill_48897_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_48898_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_48898_Name = {Text = "强化"},
  Skill_49124_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_49124_Name = {
    Text = "破甲针刺"
  },
  Skill_49125_Desc = {
    Text = "打出后抽 1 张牌。回合结束时若仍在手中，失去 500 点银钥能量。"
  },
  Skill_49125_Name = {
    Text = "失语畸变"
  },
  Skill_49126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_49127_Desc = {
    Text = "打出后抽 1 张牌。回合结束时若仍在手中，将 2 张随机症状洗入抽牌堆。"
  },
  Skill_49127_Name = {
    Text = "代谢畸变"
  },
  Skill_49128_Desc = {
    Text = "打出后抽 1 张牌。回合结束时若在手中，<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重创>自身 1 回合。"
  },
  Skill_49128_Name = {
    Text = "衰竭畸变"
  },
  Skill_49129_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49129_Name = {Text = "血之棘"},
  Skill_49130_Desc = {
    Text = "打出后抽 1 张牌。回合结束时若仍在手中，所有唤醒体失去 10 点狂气。"
  },
  Skill_49130_Name = {
    Text = "痴愚畸变"
  },
  Skill_49131_Desc = {
    Text = "打出后抽 1 张牌。回合结束时若仍在手中，将 4 张「伤口」洗入抽牌堆。"
  },
  Skill_49131_Name = {
    Text = "断肢畸变"
  },
  Skill_49133_Desc = {
    Text = "无止尽繁衍中孼生的不明产物……打出后所有唤醒体获得 5 狂气，回合结束后若在手中，自我复制。该卡牌算力消耗最低为1。"
  },
  Skill_49133_Name = {
    Text = "秽乱之子"
  },
  Skill_49215_Desc = {
    Text = "获得 1 点算力，可以使用 [Arg1] 次。"
  },
  Skill_49215_Name = {
    Text = "奇妙料理"
  },
  Skill_49216_Desc = {
    Text = "获得 1 点算力，可以使用 [Arg1] 次。有 50% 概率触发一个<MysterybuffKeywords:奇妙正面效果>。"
  },
  Skill_49216_Name = {
    Text = "奇妙料理"
  },
  Skill_49233_Desc = {
    Text = "与最前排的友方交换位置，获得 [Arg1] 点护盾。"
  },
  Skill_49233_Name = {Text = "掩护"},
  Skill_49234_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易伤>自身 1 回合。"
  },
  Skill_49234_Name = {
    Text = "殊死一搏"
  },
  Skill_49235_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_49235_Name = {
    Text = "穿心一击"
  },
  Skill_49236_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。与后排的友方交换位置，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_49236_Name = {
    Text = "蓄势突袭"
  },
  Skill_49279_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使卡组中 1 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49279_Name = {
    Text = "畸变扩散"
  },
  Skill_49280_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<BlindingKeywords:致盲>。"
  },
  Skill_49280_Name = {Text = "扬尘"},
  Skill_49281_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_49281_Name = {Text = "千针"},
  Skill_49282_Desc = {
    Text = "获得 [Arg1] 点护盾及 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_49282_Name = {Text = "祷言"},
  Skill_49288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_49288_Name = {Text = "冲击"},
  Skill_49289_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。目标每有 4 点<PowerIconKeywords:力量>，降低 1 点<PowerIconKeywords:力量>，降低的力量无法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49289_Name = {Text = "黯蚀"},
  Skill_49290_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49290_Name = {
    Text = "血棘喷射"
  },
  Skill_49291_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使卡组中 1 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49291_Name = {
    Text = "污秽降生"
  },
  Skill_49416_Desc = {
    Text = "选择 1 张手中的非衍生指令卡，获得一张附加<DepleteIconKeywords:消耗>的原始复制，并使指令卡的所有者获得 <Energy:[Arg1]> 点狂气。"
  },
  Skill_49416_Name = {
    Text = "唯一的种子"
  },
  Skill_49434_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_49434_Name = {Text = "冲击"},
  Skill_49435_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49435_Name = {
    Text = "血棘喷射"
  },
  Skill_49436_Desc = {
    Text = "获得 [Arg1] 点力量。获得 50 层<ConcealmentKeywords:隐匿>状态。召唤 2 只「孳乳·努比亚幼崽」在前排。"
  },
  Skill_49436_Name = {
    Text = "匿踪呼唤"
  },
  Skill_49437_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使卡组中 2 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49437_Name = {
    Text = "污秽降生"
  },
  Skill_49438_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。目标每有 3 点<PowerIconKeywords:力量>，降低 1 点<PowerIconKeywords:力量>，降低的力量无法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49438_Name = {Text = "黯蚀"},
  Skill_49439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>和<HeavyInjuryKeywords:重创>。若其它怪物均已死亡，意图立刻切换为「冲击」。"
  },
  Skill_49439_Name = {
    Text = "匿踪突袭"
  },
  Skill_49454_Desc = {
    Text = "获得 [Arg1] 点力量。获得 75 层<ConcealmentKeywords:隐匿>状态。召唤 2 只「孳乳·努比亚幼崽」在前排。"
  },
  Skill_49454_Name = {
    Text = "匿踪呼唤"
  },
  Skill_49455_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将  1 张<DerivativeCardKeywords_44:秽乱之子>加入手中，使卡组中 5 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49455_Name = {
    Text = "邪秽畸生"
  },
  Skill_49456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49456_Name = {
    Text = "血棘喷射"
  },
  Skill_49457_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_49457_Name = {Text = "冲击"},
  Skill_49458_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将  1 张<DerivativeCardKeywords_44:秽乱之子>加入手中，使卡组中 2 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49458_Name = {
    Text = "污秽降生"
  },
  Skill_49459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>和<HeavyInjuryKeywords:重创>。若其它怪物均已死亡，意图立刻切换为「冲击」。"
  },
  Skill_49459_Name = {
    Text = "匿踪突袭"
  },
  Skill_49460_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合的<WeaknessIconKeywords:虚弱>。目标每有 3 点<PowerIconKeywords:力量>，降低 1 点<PowerIconKeywords:力量>，降低的力量无法超出其<PowerIconKeywords:力量>。"
  },
  Skill_49460_Name = {Text = "黯蚀"},
  Skill_49477_Desc_1 = {
    Text = "弃掉对手所有手牌，给对手 [Arg1] 张钥令。"
  },
  Skill_49477_Name_1 = {
    Text = "给对手钥令"
  },
  Skill_49490_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。"
  },
  Skill_49491_Desc = {
    Text = "获得 [Arg1] 层祈祷状态，将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。祈祷：可用来强化技能，受到伤害减少一层，回合结束失去全部。"
  },
  Skill_49491_Name = {
    Text = "鲜血祈祷"
  },
  Skill_49492_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使卡组中 2 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49492_Name = {
    Text = "畸生千针"
  },
  Skill_49493_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每点「祈祷」提高 1 次。每造成 1 次未被格挡的伤害，还会将 1 张<DerivativeCardKeywords_23:「伤口」>洗入抽牌堆，最大为 5 张。"
  },
  Skill_49493_Name = {
    Text = "灯芯长明"
  },
  Skill_49515_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使卡组中 3 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49515_Name = {
    Text = "畸生千针"
  },
  Skill_49516_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使卡组中 3 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_49516_Name = {
    Text = "畸生千针"
  },
  Skill_49517_Desc = {
    Text = "将 2 张<DerivativeCardKeywords_44:秽乱之子>加入手中，立刻在前排召唤 1 只「努比亚」和在后排召唤 2 只「努比亚幼崽」。"
  },
  Skill_49517_Name = {
    Text = "秽乱播撒"
  },
  Skill_49518_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张<DerivativeCardKeywords_9:「蹒跚」> 洗入抽牌堆顶。"
  },
  Skill_49519_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每点「祈祷」提高 1 次。每造成 1 次未被格挡的伤害，还会将 1 张<DerivativeCardKeywords_23:「伤口」>洗入抽牌堆，最大为 5 张。"
  },
  Skill_49519_Name = {
    Text = "灯芯长明"
  },
  Skill_49520_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每点「祈祷」提高 1 次。每造成 1 次未被格挡的伤害，还会将 1 张<DerivativeCardKeywords_23:「伤口」>洗入抽牌堆，最大为 5 张。"
  },
  Skill_49520_Name = {
    Text = "灯芯长明"
  },
  Skill_49521_Desc = {
    Text = "获得 [Arg1] 层祈祷状态，将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。祈祷：可用来强化技能，受到伤害减少一层，回合结束失去全部。"
  },
  Skill_49521_Name = {
    Text = "鲜血祈祷"
  },
  Skill_49522_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。"
  },
  Skill_49523_Desc = {
    Text = "获得 [Arg1] 层祈祷状态，将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。祈祷：可用来强化技能，受到伤害减少一层，回合结束失去全部。"
  },
  Skill_49523_Name = {
    Text = "鲜血祈祷"
  },
  Skill_49530_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张<DerivativeCardKeywords_9:「蹒跚」>洗入抽牌堆顶。"
  },
  Skill_49530_Name = {
    Text = "穿心一击"
  },
  Skill_49531_Desc = {
    Text = "与最前排的友方交换位置，获得 [Arg1] 点护盾。"
  },
  Skill_49531_Name = {
    Text = "无畏掩护"
  },
  Skill_49532_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。与后排的友方交换位置。"
  },
  Skill_49532_Name = {
    Text = "蓄势猛袭"
  },
  Skill_49533_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易伤>自身 1 回合。"
  },
  Skill_49533_Name = {
    Text = "殊死一搏"
  },
  Skill_49543_Desc = {
    Text = "所有友方获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_49543_Name = {Text = "鼓舞"},
  Skill_49544_Desc = {
    Text = "使亚兰卫队长获得 [Arg1] 护盾。"
  },
  Skill_49544_Name = {Text = "护卫"},
  Skill_49551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，附加<FragileIconKeywords:脆弱> 1 回合。"
  },
  Skill_49551_Name = {
    Text = "癫狂啄食"
  },
  Skill_49552_Desc = {
    Text = "使玩家获得 5 层<EmptinessKeywords: 空虚>状态。将 3 张<DerivativeCardKeywords_25:「石头」>洗入抽牌堆。"
  },
  Skill_49552_Name = {
    Text = "飞沙走石"
  },
  Skill_49553_Desc = {
    Text = "获得 [Arg3] 点护盾，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_49553_Name = {Text = "鼓翼"},
  Skill_49554_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_49554_Name = {Text = "啄食"},
  Skill_49555_Desc = {
    Text = "每回合获得 [Arg1] 点<PowerIconKeywords:力量>。移除所有唤醒体的所有狂气。"
  },
  Skill_49555_Name = {
    Text = "沙海的呢喃"
  },
  Skill_49556_Desc = {
    Text = "获得 [Arg3] 点护盾，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加<BlindingKeywords:致盲> 1 回合。"
  },
  Skill_49556_Name = {
    Text = "癫狂鼓翼"
  },
  Skill_49576_Desc = {
    Text = "施加 3 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。获得 [Arg1] 点护盾和 [Arg2] 点<AlertIconKeywords:戒备>。将 3 张<DerivativeCardKeywords_25:「石头」>洗入弃牌堆。"
  },
  Skill_49576_Name = {
    Text = "无止境的正义"
  },
  Skill_49577_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_49577_Name = {Text = "利刃"},
  Skill_49578_Desc = {
    Text = "每回合获得 [Arg1] 点力量。立刻获得 [Arg2] 点<AlertIconKeywords:戒备>。"
  },
  Skill_49578_Name = {
    Text = "战地卓识"
  },
  Skill_49579_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_49579_Name = {
    Text = "增幅打击"
  },
  Skill_49580_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，若失去过生命，意图立刻变为低伤害的「利刃」。"
  },
  Skill_49580_Name = {
    Text = "心眼利刃"
  },
  Skill_49581_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<AlertIconKeywords:戒备>。"
  },
  Skill_49581_Name = {
    Text = "临战体势"
  },
  Skill_49624_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_44:秽乱之子>加入手中，造成 [Arg1] 点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_49624_Name = {Text = "咒毒"},
  Skill_49630_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_49630_Name = {Text = "胎动"},
  Skill_49631_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_49631_Name = {Text = "胎动"},
  Skill_49632_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49632_Name = {
    Text = "血棘喷射"
  },
  Skill_49633_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_49633_Name = {
    Text = "血棘喷射"
  },
  Skill_49743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_49743_Name = {
    Text = "爆裂猩红荆棘"
  },
  Skill_49834_Desc_1 = {
    Text = "查看 [Arg1] 张友方随机「技能」 ，选择 1 张，将其 [Arg2] 张费用 - [Arg3] 的复制洗入抽牌堆。"
  },
  Skill_49834_Name_1 = {
    Text = "唯一的种子"
  },
  Skill_49834_UnknownName = {
    Text = "唯一的种子"
  },
  Skill_49882_Desc = {
    Text = "从已解锁的 3 个随机钥令中选择 1 个立刻释放，并生效 2 次。"
  },
  Skill_49882_Name = {
    Text = "银钥曦光"
  },
  Skill_50300_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：抵抗 1 次致死伤害并摧毁此「命轮」，获得 [Arg1] 层<PVPProtectiveKeywords:屏障>，生效时若为唯一生存友方，使下回合开始时获得 [Arg2] 张随机「钥令」。"
  },
  Skill_50300_Name_1 = {
    Text = "极夜与破晓"
  },
  Skill_50327_Desc_1 = {
    Text = "使一名目标获得 <DelayKeywords:延迟 1>：获得 [Arg1] 随机钥令。"
  },
  Skill_50327_Name_1 = {
    Text = "延迟随机钥令"
  },
  Skill_50329_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_50329_Name = {Text = "重击"},
  Skill_50330_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_50330_Name = {Text = "重击"},
  Skill_50335_Desc = {
    Text = "获得 [Arg3] 点护盾，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_50335_Name = {Text = "鼓翼"},
  Skill_50340_Desc = {
    Text = "无止尽繁衍中孼生的不明产物……打出后所有唤醒体获得 5 狂气，回合结束后若在手中，自我复制。该卡牌算力消耗最低为1。"
  },
  Skill_50340_Name = {
    Text = "秽乱之子"
  },
  Skill_50381_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_50381_Name = {Text = "荆棘"},
  Skill_50382_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_50382_Name = {Text = "棘刺"},
  Skill_50383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_50383_Name = {
    Text = "猩红荆棘"
  },
  Skill_50384_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_50384_Name = {
    Text = "血腥棘刺"
  },
  Skill_50388_Desc = {
    Text = "投一颗骰子，根据点数获得效果。1：<WeaknessIconKeywords:虚弱>所有敌人 1 回合。2：<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。3：对所有敌人造成 [Arg1] 点出血。4：获得 2 点算力。5：抽 2 张牌。6+：这就是莱克的强运！获得以上全部效果！"
  },
  Skill_50388_Name = {
    Text = "莱克的幸运骰子"
  },
  Skill_50392_Desc = {
    Text = "抉择：<DerivativeCardKeywords_50:「单向」> 或  <DerivativeCardKeywords_51:「集结」>"
  },
  Skill_50392_Name = {
    Text = "无餍打击"
  },
  Skill_50393_Desc = {
    Text = "将 1 名唤醒体的 3 张算力消耗为 0 的「打击」置入手中，并使其获得 10 点狂气。"
  },
  Skill_50393_Name = {Text = "单向"},
  Skill_50394_Desc = {
    Text = "抉择：<DerivativeCardKeywords_47:「吸附」> 或 <DerivativeCardKeywords_48:「固化」>"
  },
  Skill_50394_Name = {
    Text = "朊朊病毒"
  },
  Skill_50395_Desc = {
    Text = "获得 30% 最大生命的护盾。"
  },
  Skill_50395_Name = {Text = "蛹化"},
  Skill_50396_Desc = {
    Text = "抉择：<DerivativeCardKeywords_53:「蛹化」>或 <DerivativeCardKeywords_54:「蚕食」>"
  },
  Skill_50396_Name = {
    Text = "复苏之茧"
  },
  Skill_50397_Desc = {
    Text = "获得 [Arg1] 层<PowerIconKeywords:力量>，受到 [Arg2] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_50397_Name = {Text = "固化"},
  Skill_50398_Desc = {
    Text = "获得 [Arg1] 层临时<PowerIconKeywords:力量>。"
  },
  Skill_50398_Name = {Text = "吸附"},
  Skill_50399_Desc = {
    Text = "将所有唤醒体各 1 张算力消耗为 0 的「打击」置入手中，并使他们获得 5 点狂气。"
  },
  Skill_50399_Name = {Text = "集结"},
  Skill_50492_Desc = {
    Text = "回复 30％ 最大生命，易伤自身 1 回合。"
  },
  Skill_50492_Name = {Text = "集结"},
  Skill_50699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 1 张随机畸变卡牌加入手中。"
  },
  Skill_50699_Name = {Text = "惩戒"},
  Skill_50700_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>。玩家每打出 1 张牌都会切换该意图的追加效果。追加效果会在反击、净化、植入之间按序切换。"
  },
  Skill_50700_Name = {
    Text = "延续血缘"
  },
  Skill_50701_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，解除自身负面状态。打出卡牌后，追加效果将切换为植入。"
  },
  Skill_50701_Name = {
    Text = "延续血缘\n净化"
  },
  Skill_50702_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，将 2 张随机畸变卡牌加入手中。打出卡牌后，追加效果将切换为反击。"
  },
  Skill_50702_Name = {
    Text = "延续血缘\n植入"
  },
  Skill_50703_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，玩家每打出 1 张牌都会切换该意图的追加效果。追加效果会在重击、回复、弱化之间按序切换。"
  },
  Skill_50703_Name = {
    Text = "「失序撕咬」"
  },
  Skill_50704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_50704_Name = {
    Text = "利齿撕咬"
  },
  Skill_50706_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并施加 2 回合的<BlindingKeywords:致盲> 。"
  },
  Skill_50706_Name = {
    Text = "撕裂哀恸"
  },
  Skill_50707_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，额外获得 [Arg3] 点临时反击。打出卡牌后，追加效果将切换为净化。"
  },
  Skill_50707_Name = {
    Text = "延续血缘\n反击"
  },
  Skill_50739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 2 回合的 <WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。打出卡牌后，追加效果将切换为重击。"
  },
  Skill_50739_Name = {
    Text = "「失序撕咬」弱化"
  },
  Skill_50740_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，打出卡牌后，追加效果将切换为回复。"
  },
  Skill_50740_Name = {
    Text = "「失序撕咬」重击"
  },
  Skill_50741_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复 [Arg3] 点生命。打出卡牌后，追加效果将切换为弱化。"
  },
  Skill_50741_Name = {
    Text = "「失序撕咬」回复"
  },
  Skill_50845_Desc = {
    Text = "选择 1 张非衍生指令卡，获得其算力为 0 的原始复制，附加<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_50845_Name = {
    Text = "神圣子嗣"
  },
  Skill_50867_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_50867_Name = {
    Text = "爆裂血腥棘刺"
  },
  Skill_51690_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点护盾，每层「孕育」使护盾提高 [Arg4] 点。"
  },
  Skill_51690_Name = {Text = "试探"},
  Skill_51691_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印所有唤醒体，召唤 2 个「利莫里亚的希望」在身前。"
  },
  Skill_51691_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_51692_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张<DerivativeCardKeywords_3:「惊厥」>洗入对方抽牌堆。"
  },
  Skill_51692_Name = {
    Text = "无上生祭"
  },
  Skill_51693_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印狂气最高的唤醒体 1 回合。"
  },
  Skill_51693_Name = {
    Text = "神眷之刃"
  },
  Skill_51694_Desc = {
    Text = "召唤 1 个「灵觉之子」在身后，每层「孕育」都会使其更强！"
  },
  Skill_51694_Name = {
    Text = "应选之人"
  },
  Skill_51699_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印所有唤醒体，召唤 2 个「利莫里亚的希望」在身前。"
  },
  Skill_51699_Name = {
    Text = "利莫里亚的荣光！"
  },
  Skill_51700_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张随机症状洗入对方抽牌堆。"
  },
  Skill_51700_Name = {
    Text = "无上生祭"
  },
  Skill_51701_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 1 回合<WeaknessIconKeywords:虚弱>。获得 [Arg3] 点护盾，每层「孕育」使护盾提高 [Arg4] 点。"
  },
  Skill_51701_Name = {Text = "试探"},
  Skill_51702_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。封印狂气最高的唤醒体 1 回合。并使其在牌堆中的随机 [Arg3] 张指令卡获得 1 层<SlowIconKeywords:迟缓>。"
  },
  Skill_51702_Name = {
    Text = "神眷之刃"
  },
  Skill_51703_Desc = {
    Text = "回复[Arg5]% 已损失生命，召唤 1 个「灵觉之子」在身后，每层「孕育」都会使回复量和被召唤者更强！"
  },
  Skill_51703_Name = {
    Text = "应选之人"
  },
  Skill_51721_Desc_1 = {
    Text = "造成[Arg1]伤害并 <ComaKeywords:石化>。"
  },
  Skill_51721_Name_1 = {Text = "石化"},
  Skill_51733_AwakerSkillBackgroundStory = {
    Text = "她将在地上以祂的名行事。\n她将得祂应得的美名。\n她将于毁灭之时，承无人可受之痛。\n此即为代行者。"
  },
  Skill_51733_Desc = {
    Text = "弥利亚姆获得 <Energy:[Energy:Arg3]> 点狂气。<ExaltIconKeywords:灵知觉醒>：触腕上限和触腕数量 +1，对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。将 1 张<O07CardKeyWord5:「信仰的终结」>置入手中。选择：<CardKeyWord:坚守自我>或<CardKeyWord:投身启示>。"
  },
  Skill_51733_EffectNameList = {
    Text = "护盾,触腕伤害,狂气"
  },
  Skill_51733_Name = {
    Text = "信仰的歧路"
  },
  Skill_51733_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_51734_Desc = {
    Text = "弥利亚姆获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。触腕上限和触腕数量 +1。回合结束时将随机 1 张「神国幻影」置入手中。"
  },
  Skill_51734_Name = {
    Text = "信仰的终结"
  },
  Skill_51735_Desc = {
    Text = "每个回合开始时获得 [Power:Arg1] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg1] 点<TentacleInjurieIconKeywords:触腕伤害>。"
  },
  Skill_51735_EffectNameList = {
    Text = "护盾,触腕伤害"
  },
  Skill_51735_Name = {
    Text = "投身启示"
  },
  Skill_51735_PropertyNameList = {
    Text = "防御力*GrowValue1,攻击力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_51736_Desc = {
    Text = "每个回合开始时获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_51736_EffectNameList = {Text = "护盾"},
  Skill_51736_Name = {
    Text = "坚守自我"
  },
  Skill_51736_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_51782_Desc = {
    Text = "选择一名唤醒体使其获得 [Arg1] 点狂气。抽 2 张牌。"
  },
  Skill_51782_Name = {
    Text = "神国的呼唤"
  },
  Skill_51783_Desc = {
    Text = "选择一名唤醒体使其获得 [Arg1] 点狂气。<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。"
  },
  Skill_51783_Name = {
    Text = "神国的虔信"
  },
  Skill_51784_Desc = {
    Text = "选择一名唤醒体使其获得 [Arg1] 点狂气。获得 2 点算力。"
  },
  Skill_51784_Name = {
    Text = "神国的降临"
  },
  Skill_51814_Desc = {
    Text = "获得[Arg4] 点<PowerIconKeywords:力量>，召唤一个「睡梦之子」、一个「水之子」、一个「灵觉之子」。「孕育」获得额外效果：达到 5 层后，立刻召唤 1 个「水之子」。"
  },
  Skill_51814_Name = {Text = "觉醒"},
  Skill_51902_BattleDesc = {
    Text = "回复 10% 已损失生命([Arg1])。可以通过祭仪效果转化为「执妄」，强化指令卡效果。"
  },
  Skill_51902_Desc = {
    Text = "回复 10% 已损失生命。可以通过<O07CardKeyWord:祭仪>效果转化为<O07CardKeyWord3:「执妄」>，强化指令卡效果。"
  },
  Skill_51902_Name = {Text = "圣礼"},
  Skill_52055_Desc = {
    Text = "弥利亚姆获得 [Arg1] 点狂气。回合结束时若在手中，此卡以下回合抽牌数量 -1 为代价转化为「圣礼」。"
  },
  Skill_52055_Name = {Text = "执妄"},
  Skill_52076_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_52077_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_52077_Name = {Text = "强化"},
  Skill_52078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_52079_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_52079_Name = {Text = "强化"},
  Skill_52094_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_52094_Name = {Text = "强化"},
  Skill_52095_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_52096_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_52096_Name = {Text = "强化"},
  Skill_52097_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_52317_Desc = {
    Text = "<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。"
  },
  Skill_52317_Name = {
    Text = "诚挚的朋友"
  },
  Skill_52318_Desc = {
    Text = "抽 2 张牌。"
  },
  Skill_52318_Name = {
    Text = "安定的生活"
  },
  Skill_52319_Desc = {
    Text = "获得 2 点算力。"
  },
  Skill_52319_Name = {
    Text = "温暖的家庭"
  },
  Skill_52698_Desc = {
    Text = "抽 2 张牌，获得 2 点算力，所有唤醒体失去 5 点狂气。若当前处于「静海」姿态，对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，在首领战中发挥 3 倍效果。"
  },
  Skill_52698_Name = {Text = "海之祭"},
  Skill_54041_Desc = {
    Text = "造成双倍伤害并额外获得 600% 等同于环行拉蒙娜银钥充能的银钥能量，但打出后<DepleteIconKeywords:消耗>。"
  },
  Skill_54041_Name = {
    Text = "未来讴歌"
  },
  Skill_54042_Desc = {
    Text = "获得 3 点算力。"
  },
  Skill_54042_Name = {
    Text = "轮回之庭"
  },
  Skill_54377_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：敌方唤醒体死亡后，获得 [Arg1] <StrongEffectKeywords:强效>，将其算力消耗最高并附带<PVPVoidKeywords:虚无>的「技能」置入手中。"
  },
  Skill_54377_Name_1 = {
    Text = "百万蒙宠之眼"
  },
  Skill_54439_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。随机对 1 名唤醒体对其所有卡牌附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_54439_Name = {
    Text = "融蚀墨染"
  },
  Skill_54440_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_54441_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<BlindingKeywords:致盲>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54442_Desc = {
    Text = "使「致奥尔拉」回复 已损失生命的 3%。"
  },
  Skill_54442_Name = {Text = "浇灌"},
  Skill_54443_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。随机对 1 名唤醒体其所有卡牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54443_Name = {Text = "墨染"},
  Skill_54444_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<WeaknessIconKeywords:虚弱>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54445_Desc = {
    Text = "召唤 4 名荆棘侍从。对所有卡牌附加<ErosionColorInkKeywords:认知错乱>。施加 [Arg1] 层衰竭、[Arg2] 层中毒、[Arg3] 层<BleedingIconKeywords:出血>。并<BlindingKeywords:致盲>、<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>、<HeavyInjuryKeywords:重创> 99 回合。"
  },
  Skill_54445_Name = {
    Text = "诗中的幻惑乐园"
  },
  Skill_54446_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，移除玩家 50% 的<PowerIconKeywords:力量> 和<RetaliateIconKeywords:反击>。"
  },
  Skill_54446_Name = {
    Text = "分断之缘"
  },
  Skill_54447_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使抽牌堆随机 3 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54448_Desc = {
    Text = "获得 [Arg1] 点护盾， [Arg2] 点<RetaliateIconKeywords:反击>和 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_54448_Name = {
    Text = "禁绝贪念"
  },
  Skill_54449_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使抽牌堆随机 3 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54450_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_54450_Name = {Text = "裁剪"},
  Skill_54451_Desc = {
    Text = "获得 [Arg1] 点护盾，以及 [Arg2] 点临时<RetaliateIconKeywords:反击>和 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_54451_Name = {Text = "贪念"},
  Skill_54452_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆随机 2 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54453_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54454_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54455_Desc = {
    Text = "使「致奥尔拉」提高 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_54455_Name = {Text = "供养"},
  Skill_54456_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤荆棘侍从。使之后贪欲之歌伤害次数提高 1。"
  },
  Skill_54456_Name = {
    Text = "贪欲之歌"
  },
  Skill_54457_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。召唤荆棘侍从。使之后贪欲之歌伤害次数提高 1。"
  },
  Skill_54457_Name = {
    Text = "贪欲之歌"
  },
  Skill_54458_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，并获得 [Arg3]点护盾，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54459_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54460_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54461_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆随机 2 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_54566_Desc = {
    Text = "选择任意 1 个已解锁钥令释放。"
  },
  Skill_54566_Name = {
    Text = "超限链接"
  },
  Skill_55481_Desc = {
    Text = "移除超维空间最左侧的卡牌，立刻将 1 张「灵感」置入手中。「湮灭」 1 回合只能使用 1 次。"
  },
  Skill_55481_Name = {Text = "湮灭"},
  Skill_55481_tempBattleDesc_1 = {
    Text = "移除超维空间最左侧的卡牌，立刻将 1 张「灵感」置入手中。「湮灭」 1 回合只能使用 1 次。"
  },
  Skill_55481_tempBattleDesc_2 = {
    Text = "移除超维空间最左侧的卡牌，立刻将 1 张「灵感」置入手中。本回合奥尔拉下一张指令卡触发跃迁效果。「湮灭」 1 回合只能使用 1 次。"
  },
  Skill_55481_tempBattleDesc_3 = {
    Text = "取出超维空间最左侧的卡牌。3 回合冷却。"
  },
  Skill_55481_tempBattleDesc_4 = {
    Text = "选择 1 张超维空间的指令卡取出，赋予「打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。3 回合冷却。"
  },
  Skill_55481_tempBattleDesc_5 = {
    Text = "取出超维空间最左侧的卡牌。本回合奥尔拉下一张指令卡触发跃迁效果。3 回合冷却。"
  },
  Skill_55481_tempBattleDesc_6 = {
    Text = "选择 1 张超维空间的指令卡取出，赋予「打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。本回合奥尔拉下一张指令卡触发跃迁效果。3 回合冷却。"
  },
  Skill_55481_tempBattleDesc_7 = {
    Text = "选择 1 张超维空间的指令卡取出，赋予「打出后额外生效 1 次」，使下 1 张打出的指令卡触发<SingularityKeywords3:维度穿梭>。立刻对所有敌人造成等同于 50％「命运裁断」的<FixedDamage:纯粹伤害>，下次阿拉克涅狂气爆发造成的伤害强效和护盾提高 50％。3 回合冷却。"
  },
  Skill_55481_tempBattleDesc_8 = {
    Text = "选择 1 张超维空间的指令卡取出，赋予「打出后额外生效 1 次」，使下 1 张打出的的指令卡触发<SingularityKeywords3:维度穿梭>。立刻对所有敌人造成等同于 50％「命运裁断」的<FixedDamage:纯粹伤害>，下次阿拉克涅狂气爆发造成的伤害强效和护盾提高 50％。本回合奥尔拉下一张指令卡触发跃迁效果。3 回合冷却。"
  },
  Skill_55802_Name_1 = {Text = "雨颂"},
  Skill_55803_Name_1 = {Text = "花颂"},
  Skill_55804_Name_1 = {Text = "风颂"},
  Skill_56035_Desc = {
    Text = "获得 [Arg1] 点护盾。"
  },
  Skill_56035_Name = {Text = "大地"},
  Skill_56036_Desc = {
    Text = "回复 [Arg1]% 已损失生命([Arg2])。"
  },
  Skill_56036_Name = {Text = "泉水"},
  Skill_56037_Desc = {
    Text = "对所有敌人施加 [Arg1] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_56037_Name = {Text = "花束"},
  Skill_56038_Desc = {
    Text = "对所有敌人施加 [Arg1] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_56038_Name = {Text = "猫"},
  Skill_56039_Desc = {
    Text = "驱散随机 1 个负面状态。"
  },
  Skill_56039_Name = {Text = "月亮"},
  Skill_56040_Desc = {
    Text = "获得 [Arg1] 点护盾，若本回合内释放过 3 次狂气爆发，此卡额外生效 1 次。"
  },
  Skill_56040_Name = {Text = "大地"},
  Skill_56041_Desc = {
    Text = "回复 [Arg1]% 已损失生命([Arg2])。若当前生命低于 25%([Arg3])，此卡额外生效 1 次。"
  },
  Skill_56041_Name = {Text = "泉水"},
  Skill_56042_Desc = {
    Text = "对所有敌人施加 [Arg1] 回合<WeaknessIconKeywords:虚弱>，将一张附加<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虚无>的随机意象置入弃牌堆。"
  },
  Skill_56042_Name = {Text = "花束"},
  Skill_56043_Desc = {
    Text = "对所有敌人施加 [Arg1] 回合<VulnerabilityIconKeywords:易伤>。每当有敌人死亡时，将此卡从牌堆置入手中。"
  },
  Skill_56043_Name = {Text = "猫"},
  Skill_56044_Desc = {
    Text = "驱散随机 1 个负面状态。此卡额外生效 3 次，消耗。"
  },
  Skill_56044_Name = {Text = "月亮"},
  Skill_56045_Desc = {
    Text = "获得 [Arg1] 点算力。"
  },
  Skill_56045_Name = {Text = "太阳"},
  Skill_56046_Desc = {
    Text = "抽 [Arg1] 张牌。"
  },
  Skill_56046_Name = {Text = "星星"},
  Skill_56047_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气。"
  },
  Skill_56047_Name = {Text = "春天"},
  Skill_56048_Desc = {
    Text = "界域精通 +[Arg1] 点，临时界域精通 +[Arg2] 点。"
  },
  Skill_56048_Name = {Text = "诗句"},
  Skill_56049_Desc = {
    Text = "从抽牌堆和弃牌堆选择 1 张指令卡置入手中，并使其算力消耗 -2。"
  },
  Skill_56049_Name = {Text = "蝴蝶"},
  Skill_56050_Desc = {
    Text = "获得 [Arg1] 点算力。"
  },
  Skill_56050_Name = {Text = "太阳"},
  Skill_56051_Desc = {
    Text = "抽 [Arg1] 张牌。"
  },
  Skill_56051_Name = {Text = "星星"},
  Skill_56052_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气。"
  },
  Skill_56052_Name = {Text = "春天"},
  Skill_56053_Desc = {
    Text = "临时界域精通 +[Arg1] 点。"
  },
  Skill_56053_Name = {Text = "诗句"},
  Skill_56054_Desc = {
    Text = "从抽牌堆选择 1 张指令卡置入手中，并使其算力消耗 -1。"
  },
  Skill_56054_Name = {Text = "蝴蝶"},
  Skill_56055_Desc = {
    Text = "获得 [Arg1] 点银钥能量。"
  },
  Skill_56055_Name = {Text = "云朵"},
  Skill_56056_Desc = {
    Text = "造成等同于自身最大生命 100% 的<FixedDamage:纯粹伤害>([Arg1])，该伤害享受 5 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_56056_Name = {Text = "风"},
  Skill_56057_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_56057_Name = {Text = "森林"},
  Skill_56058_Desc = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。"
  },
  Skill_56058_Name = {Text = "雪"},
  Skill_56059_Desc = {
    Text = "造成等同于自身最大生命 150% 的<FixedDamage:纯粹伤害>([Arg1])，该伤害享受 10 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_56059_Name = {Text = "风"},
  Skill_56060_Desc = {
    Text = "下一个钥令生效 2 次。"
  },
  Skill_56060_Name = {Text = "云朵"},
  Skill_56061_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>。打出后本回合每造成 1 次伤害，临时暴击率 +[Arg2]%。"
  },
  Skill_56061_Name = {Text = "森林"},
  Skill_56062_Desc = {
    Text = "获得 [Arg1] 点临时<AlertIconKeywords:戒备>。打出后本回合所有唤醒体造成的护盾和回复提高 [Arg2]%。"
  },
  Skill_56062_Name = {Text = "雪"},
  Skill_56144_Desc = {Text = "无用"},
  Skill_56144_Name = {Text = "献诗"},
  Skill_56155_Desc = {
    Text = "将 1 张造成 <Damage:[Damage:Arg1]> 点伤害 X+10 次的<DerivativeCardKeywords_12:「鼠群冲击」>洗入抽牌堆顶部。"
  },
  Skill_56155_EffectNameList = {
    Text = "「鼠群冲击」伤害"
  },
  Skill_56155_Name = {
    Text = "超级大集结！"
  },
  Skill_56155_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_56199_Desc = {
    Text = "回复 <Heal:[Arg1]> 点生命。"
  },
  Skill_56199_Name = {Text = "雨颂"},
  Skill_56200_Desc = {
    Text = "临时暴击率 +[Arg1]%。"
  },
  Skill_56200_Name = {Text = "月颂"},
  Skill_56201_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_56201_Name = {Text = "风颂"},
  Skill_56202_Desc = {
    Text = "从四种<D06CardKeeperSkill:诗页>中选择一项，并将其从选项中移除。所有诗页都被选择后，重置。"
  },
  Skill_56202_Name = {
    Text = "春天的献诗"
  },
  Skill_56203_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气。"
  },
  Skill_56203_Name = {Text = "花颂"},
  Skill_56370_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，立刻获得 2 层<ResentChainsKeywords:怨恨锁链>状态。"
  },
  Skill_56370_Name = {
    Text = "维度之锁"
  },
  Skill_56371_Desc = {
    Text = "全体获得[Arg1] 点<PowerIconKeywords:力量>，<Block:[Block:Arg2]> 点护盾，洗入 1 张 <DerivativeCardKeywords_45:「维度闭锁」>到抽牌堆。"
  },
  Skill_56371_Name = {
    Text = "维度防壁"
  },
  Skill_57140_Desc = {
    Text = "召唤两名「冷冽之灵」，所有友方获得 [Arg1] 点 <CardKeyWord:霜盾>。"
  },
  Skill_57140_Name = {
    Text = "冷冽之灵"
  },
  Skill_57141_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。冻结抽牌堆顶部 1 张指令卡。"
  },
  Skill_57141_Name = {Text = "霜棱"},
  Skill_57338_AwakerSkillBackgroundStory = {
    Text = "当他举起巨剑，带来的必然是鲜血与死亡。"
  },
  Skill_57338_Desc_0 = {
    Text = "将 3 张基础伤害提高 400%，算力消耗为 0 的<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，获得等同于 [Arg1]% 触腕伤害的临时<PowerIconKeywords:力量>。"
  },
  Skill_57338_Desc_3 = {
    Text = "将 3 张基础伤害提高 400%，算力消耗为 0 的<DerivativeCardKeywords_17:「巨刃之威」>置入手牌，获得等同于 [Arg1]% 触腕伤害的临时<PowerIconKeywords:力量>。戈利亚获得 [Arg2]% 临时暴击率。"
  },
  Skill_57338_EffectNameList = {
    Text = "触腕伤害百分比"
  },
  Skill_57338_Name = {Text = "篡夺"},
  Skill_57338_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_57339_AwakerSkillBackgroundStory = {
    Text = "当他举起巨剑，带来的必然是鲜血与死亡。"
  },
  Skill_57339_Desc_0 = {
    Text = "将 2 张「斩首重创」置入手牌，并使它们获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords:预备1>和<RetainIconKeywords:保留>。使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。"
  },
  Skill_57339_Desc_3 = {
    Text = "将 2 张「斩首重创」置入手牌，并使它们获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords:预备1>和<RetainIconKeywords:保留>。使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。戈利亚获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_57339_Name = {Text = "蛰伏"},
  Skill_57342_AwakerSkillBackgroundStory = {
    Text = "由整块精铁打造的利刃无比沉重，破空之时带起的气流甚至可以震碎岩石。\n我忠诚的伙伴，我可靠的巨刃啊，我们皆于黑暗中获得新生与无穷力量。今夜，我们将痛饮仇敌之血；今夜，我们将尽情杀戮。"
  },
  Skill_57342_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害。<PowerIconKeywords:力量>在「巨刃之威」上发挥 [Arg2] 倍效果。此卡视为「打击」。"
  },
  Skill_57342_EffectNameList = {Text = "伤害"},
  Skill_57342_Name = {
    Text = "巨刃之威"
  },
  Skill_57342_PropertyNameList = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_57550_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将「回答塔薇」置入手中。"
  },
  Skill_57550_Name = {
    Text = "真理问询"
  },
  Skill_57551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并施加 10% 伤害的<IntoxicationIconKeywords:中毒>和等量伤害的<BleedingIconKeywords:出血>。"
  },
  Skill_57551_Name = {
    Text = "深渊之视"
  },
  Skill_57552_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_57552_Name = {
    Text = "粉碎之六翼"
  },
  Skill_57553_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。复制自身的负面状态，将其添加给目标。"
  },
  Skill_57553_Name = {
    Text = "同化之四翼"
  },
  Skill_57554_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> 2 回合。使 5 张卡牌附加「侵食」1 回合。"
  },
  Skill_57554_Name = {Text = "侵食"},
  Skill_57555_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，移除 15％ 的<PowerIconKeywords:力量>和<RetaliateIconKeywords:反击>并获得等量的临时<PowerIconKeywords:力量>和临时<RetaliateIconKeywords:反击>。"
  },
  Skill_57555_Name = {
    Text = "掠夺之双翼"
  },
  Skill_57556_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易伤> 1 回合。"
  },
  Skill_57556_Name = {
    Text = "「矛盾」黯翼"
  },
  Skill_57557_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。双子融合度 +15%。"
  },
  Skill_57557_Name = {
    Text = "「矛盾」合形"
  },
  Skill_57558_Desc = {
    Text = "<WeaknessIconKeywords:虚弱>和<BlindingKeywords:致盲> 2 回合。获得 [Arg1] 点护盾和 [Arg2] 点<PowerIconKeywords:力量>，并清除自身负面状态。"
  },
  Skill_57558_Name = {
    Text = "「矛盾」银辉"
  },
  Skill_57568_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张「逐渐遗忘」置入手中。<WeaknessIconKeywords:虚弱> 2 回合。"
  },
  Skill_57568_Name = {Text = "忘却"},
  Skill_57661_Desc = {
    Text = "回复 1 层神母权能，神母权能可被消耗触发墨菲的其他能力，最多回复至 3 层。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_57661_Name = {Text = "小憩"},
  Skill_57662_Desc = {
    Text = "消耗 1 层神母权能，获得 [Arg2] 点力量，所有唤醒体获得 [Arg3] 点狂气。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_57662_Name = {
    Text = "刎颈，以行威仪"
  },
  Skill_57663_Desc = {
    Text = "消耗 1 层神母权能，<WeaknessIconKeywords:虚弱>全体敌人 1 回合，获得 [Arg2] 点护盾并回复等量生命，随损失生命提高，最高为 2 倍。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_57663_Name = {
    Text = "牺牲，以敬自由"
  },
  Skill_57664_Desc = {
    Text = "消耗 1 层神母权能，<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，本回合所有唤醒体造成的伤害提高 25%。获得 1 点算力和抽 1 张牌。（当前还剩 [Arg1] 层神母权能）"
  },
  Skill_57664_Name = {
    Text = "呵斥，以报恩仇"
  },
  Skill_57668_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张「融蚀之芯」置入抽牌堆。"
  },
  Skill_57668_Name = {
    Text = "新生之始"
  },
  Skill_57669_Desc = {
    Text = "添加「雾盾」，转化为「遗忘的伊始」。"
  },
  Skill_57669_Name = {
    Text = "强行融合"
  },
  Skill_57670_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_57670_Name = {Text = "弃用"},
  Skill_57671_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。分裂为「暗之子」和「光之子」，每 1% 融合度就使「光之子」生命减少 0.5%。"
  },
  Skill_57671_Name = {
    Text = "巨物崩解"
  },
  Skill_57699_Desc = {
    Text = "全体目标获得 2 层<ParcloseIconKeywords:屏障>，自身额外获得 5 层。"
  },
  Skill_57699_Name = {Text = "屏障"},
  Skill_57754_AwakerSkillBackgroundStory = {
    Text = "柔和的海风中她陷入沉睡，却被振翅的声音惊醒。一只通体雪白的小鸟掠过她的头顶，消失在同样雪白的云朵之中。\n那一定是梦吧，在这远离陆地的大洋深处，怎么会有落单的飞鸟呢？\n她这么想着，却无法自已地感到一种希冀，一种向往。"
  },
  Skill_57754_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命。获得 [Arg2] 点算力并驱散手牌<SlowIconKeywords:迟缓>状态。每<RetainIconKeywords:保留> 1 回合，下次打出时额外回复 <Heal:[Arg3]> 点生命。激发 1 条触腕攻击敌人，造成 [Arg4]％ 触腕伤害。"
  },
  Skill_57754_EffectNameList_0 = {Text = "回复"},
  Skill_57754_EffectNameList_2 = {
    Text = "回复,额外回复"
  },
  Skill_57754_Name = {
    Text = "纯白梦境"
  },
  Skill_57754_PropertyNameList_0 = {
    Text = "体质*GrowValue1,"
  },
  Skill_57754_PropertyNameList_2 = {
    Text = "体质*GrowValue1,体质*GrowValue2"
  },
  Skill_57760_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，扣除 <Energy:[Energy:Arg1]> 狂气转换为<PVPDerivativeCardKeywords_12:「小小心愿」>，若转换失败则获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_57760_Name_1 = {
    Text = "永不停歇的演奏"
  },
  Skill_57761_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次「狂气爆发」后临时<StrongEffectKeywords:强效> +[Arg1]。"
  },
  Skill_57761_Name_1 = {
    Text = "牧羊人的手杖"
  },
  Skill_57762_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] 层<PVPSleepKeywords:精致睡眠>。"
  },
  Skill_57762_Name_1 = {
    Text = "冰川下的沉眠"
  },
  Skill_57763_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」伤害提高 [Arg1]%。「狂气爆发」后恢复自身已损生命的 [Arg2]%。"
  },
  Skill_57763_Name_1 = {
    Text = "待到雪山消融"
  },
  Skill_57764_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」造成的伤害、治疗与护盾效果提高 [Arg1]~[Arg2]%，"
  },
  Skill_57764_Name_1 = {
    Text = "命运轮盘赌"
  },
  Skill_57765_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：打出装备者的技能卡后，抽 1 张装备者的技能卡，每回合至多生效 1 次。"
  },
  Skill_57765_Name_1 = {
    Text = "真理之门"
  },
  Skill_57805_Desc = {
    Text = "每回合获得一个极夜微光。"
  },
  Skill_57805_Name = {
    Text = "拉蒙娜支援"
  },
  Skill_57807_Desc = {
    Text = "使用拉蒙娜留下的溯洄之力，回到战斗开始。"
  },
  Skill_57807_Name = {
    Text = "拉蒙娜最终支援回溯"
  },
  Skill_57808_Desc = {
    Text = "哈姆林休息 2 回合。之后所有支援效果的使用次数 +1。"
  },
  Skill_57808_Name = {Text = "休息"},
  Skill_57809_Desc = {
    Text = "降低双子融合度 10%。本回合每释放 1 次狂气爆发，额外降低双子融合度 3%。还可使用 [Arg1] 次。"
  },
  Skill_57809_Name = {Text = "安魂曲"},
  Skill_57810_Desc = {
    Text = "本回合造成的伤害、中毒、反击提高 25%。还可使用 [Arg1] 次。"
  },
  Skill_57810_Name = {Text = "狂想曲"},
  Skill_57811_Desc = {
    Text = "获得 3 点算力，抽 3 张牌。本回合每打出 1 张指令卡，所有唤醒体获得 1 点狂气。还可使用 [Arg1] 次。"
  },
  Skill_57811_Name = {Text = "协奏曲"},
  Skill_57812_Desc = {
    Text = "满状态复活，回忆起一切卡牌和三大质体，并获得 5 张「极夜微光」。"
  },
  Skill_57812_Name = {
    Text = "拉蒙娜最终支援"
  },
  Skill_57859_Desc = {
    Text = "投一颗 [Arg2] 面骰子，获得等同于骰子点数*[Arg1] 的临时<PowerIconKeywords:力量>，若点数为 4 或更高，<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。若点数为 6 或更高，则获得的临时<PowerIconKeywords:力量>翻倍并获得 1 点算力。"
  },
  Skill_57859_Name = {
    Text = "闪耀偏方骰子"
  },
  Skill_57860_Desc = {
    Text = "投一颗 [Arg2] 面骰子，获得等同于骰子点数*[Arg1] 的临时<PowerIconKeywords:力量>，若点数为 4 或更高，<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。若点数为 6 或更高，则获得的临时<PowerIconKeywords:力量>翻倍。"
  },
  Skill_57860_Name = {
    Text = "偏方骰子"
  },
  Skill_57887_Desc = {
    Text = "当前生命和生命上限提高 [Arg1] 点。添加「雾盾」，转化为「完全的遗忘之理」。"
  },
  Skill_57887_Name = {
    Text = "完美融合"
  },
  Skill_57888_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。分裂为「暗之子」和「光之子」，「光之子」生命减少 75%，并永久眩晕。"
  },
  Skill_57888_Name = {
    Text = "融蚀分形"
  },
  Skill_57892_Desc = {
    Text = "将 3 张「<DerivativeCardKeywords_1:遗影回响>」置入手中，选择后移除该选项。"
  },
  Skill_57892_Name = {
    Text = "寻找前路"
  },
  Skill_57893_Desc = {
    Text = "获得上回合最后打出 3 张不同指令卡的原始消耗复制，其算力消耗为 0，将「<DerivativeCardKeywords_39:过往回声>」置入手中，选择后移除该选项。"
  },
  Skill_57893_Name = {
    Text = "回忆过往"
  },
  Skill_57894_Desc = {
    Text = "将「<DerivativeCardKeywords_67:银钥曦光>」和「<DerivativeCardKeywords_41:银钥共鸣>」置入手中，选择后移除该选项。"
  },
  Skill_57894_Name = {
    Text = "握紧银钥"
  },
  Skill_57895_Desc = {
    Text = "返还因「融蚀之芯」失去的力量、反击、生命上限。获得 5 点算力，所有唤醒体获得 100 狂气。将所有的<DerivativeCardKeywords_38:幻觉>还原。"
  },
  Skill_57895_Name = {
    Text = "最初的链接"
  },
  Skill_57947_Desc = {
    Text = "降低敌人 10% 生命上限。生成 1 条触腕，获得 [Arg1] 点临时触腕伤害。"
  },
  Skill_57947_Name = {
    Text = "王权之威"
  },
  Skill_57949_Desc = {
    Text = "驱散自身 <WeaknessIconKeywords:虚弱> 和力量降低状态。获得 [Arg1] 点临时触腕伤害。"
  },
  Skill_57949_Name = {
    Text = "螺湮重临"
  },
  Skill_57950_Desc = {
    Text = "造成合计 [Arg1] 点伤害 1 次。每有 1 条触腕就使得伤害提高 [Arg3] 点。"
  },
  Skill_57950_Name = {
    Text = "深渊号令"
  },
  Skill_57951_Desc = {
    Text = "获得「震怒」、12 层「困意」以及 [Arg1] 点触腕伤害。"
  },
  Skill_57951_Name = {
    Text = "不朽威仪"
  },
  Skill_57969_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 2 张「融蚀之芯」置入抽牌堆。"
  },
  Skill_57969_Name = {
    Text = "遗忘乃新生之始"
  },
  Skill_57971_Desc = {
    Text = "增加双子融合度 30%。"
  },
  Skill_57971_Name = {
    Text = "融合度up"
  },
  Skill_57972_Desc = {
    Text = "降低双子融合度 30%。"
  },
  Skill_57972_Name = {
    Text = "融合度down"
  },
  Skill_58044_Desc = {
    Text = "使「肆意豪赌」和「摊牌时刻」的基础伤害永久提高 25%。"
  },
  Skill_58044_Name = {
    Text = "庄家通吃"
  },
  Skill_58288_Desc = {
    Text = "将 1 枚<C05_yansheng2:闪耀偏方骰子>置入手中，获得 [Arg1]% 临时暴击率。"
  },
  Skill_58288_Name = {
    Text = "一声枪响"
  },
  Skill_58494_Desc = {
    Text = "zzzzzzzzzzZZZZZZZZZZZZZZ……"
  },
  Skill_58494_Name = {Text = "沉眠"},
  Skill_58495_Desc = {
    Text = "提高 [Arg1] 点触腕伤害。"
  },
  Skill_58495_Name = {Text = "呓语"},
  Skill_58933_AwakerSkillBackgroundStory = {
    Text = "下降，下降，疲惫的旅人将要返航。 让音符轻抚你的灵魂，放下一切痛苦与执念，安然进入宁静梦乡。"
  },
  Skill_58933_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_58933_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>，若其触发「乐音」效果，获得的临时<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58933_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。哈姆林获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_58933_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。哈姆林获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>，若其触发「乐音」效果，获得的临时<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58933_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_58933_Name = {Text = "防御"},
  Skill_58933_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_58939_AwakerSkillBackgroundStory = {
    Text = "升高，升高，绷紧你的船帆，我们要向着远方启航。 号角为你吹响，群鸟随你飞翔，要越过那最高的浪涛。"
  },
  Skill_58939_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_58939_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>。若其触发「乐音」效果，获得的临时<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58939_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。哈姆林获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_58939_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。哈姆林获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Power:Arg3] 点临时<PowerIconKeywords:力量>。若其触发「乐音」效果，获得的临时<PowerIconKeywords:力量>翻倍。"
  },
  Skill_58939_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_58939_Name = {Text = "打击"},
  Skill_58939_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_59159_Desc_1 = {
    Text = "使一名目标获得 <StrongEffectKeywords:强效> 。"
  },
  Skill_59159_Name_1 = {Text = "强效"},
  Skill_59191_Name = {
    Text = "极夜微光"
  },
  Skill_59428_Desc_1 = {
    Text = "使一名目标获得 <ReduceEffectKeywords:强效降低> 。"
  },
  Skill_59428_Name_1 = {
    Text = "强效降低"
  },
  Skill_59476_AwakerSkillBackgroundStory = {
    Text = "在听闻此曲前，你从未真正拥有耳朵。 在听闻此曲后，你再也找不到这样的声音。 所以请全神贯注、屏息凝神，尽情称颂这一生难得的乐曲吧！"
  },
  Skill_59476_Desc_0 = {
    Text = "哈姆林获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时，将一张「<DerivativeCardKeywords_64:协乐的交响>」置入手中<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_Desc_15 = {
    Text = "哈姆林获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时，将一张「<DerivativeCardKeywords_64:协乐的交响>」置入手中。回合开始时，每有 1 张拥有「乐音」的指令卡，哈姆林获得 <Energy:[Energy:Arg2]> 点狂气。释放「原初的乐音」时，每存在 2 张指令卡拥有乐音，伤害次数+1<DerivativeCardKeywords_61:><DerivativeCardKeywords_62:>"
  },
  Skill_59476_EffectNameList = {Text = "狂气"},
  Skill_59476_Name = {
    Text = "此曲应得称颂"
  },
  Skill_59476_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_59477_AwakerSkillBackgroundStory = {
    Text = "音乐从哪里诞生？ 从悦神的祭礼，从农夫的号子，从原始人的嚎叫，从春日的莺啼，从松风与海浪，从大地的震颤和山峰的崩落…… 还是从天地混沌中，神明梦中的呓语。"
  },
  Skill_59477_BattleDesc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg3] 次，每造成 1 次伤害临时降低目标 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>并获得 [Power:Arg2] 点<PowerIconKeywords:临时力量>。选择手中 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「<HuihuanaKeywords:回环乐音>」。每次若没有手牌可被添加，改为额外造成 3 次伤害。"
  },
  Skill_59477_BattleDesc_2 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg3] 次，每造成 1 次伤害临时降低目标 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>并获得 [Power:Arg2] 点<PowerIconKeywords:临时力量>。选择手中 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回环乐音>」。每次若没有手牌可被添加，改为额外造成 3 次伤害。"
  },
  Skill_59477_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次，每造成 1 次伤害<TouquKeywords:偷取>目标 [Arg2] 点<PowerIconKeywords:力量>。选择手中 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「<HuihuanaKeywords:回环乐音>」。每次若没有手牌可被添加，改为额外造成 3 次伤害。"
  },
  Skill_59477_Desc_2 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次，每造成 1 次伤害<TouquKeywords:偷取>目标 [Arg2] 点<PowerIconKeywords:力量>。选择手中 1 张不具有「乐音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回环乐音>」。每次若没有手牌可被添加，改为额外造成 3 次伤害。"
  },
  Skill_59477_EffectNameList = {
    Text = "伤害,偷取力量"
  },
  Skill_59477_Name = {
    Text = "原初的乐音"
  },
  Skill_59477_OverLimitUtlSkillDesc = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg3] 次，每造成 1 次伤害临时降低目标 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>、获得 [Power:Arg2] 点<PowerIconKeywords:临时力量>、对目标随机施加 1 种<MysterydebuffKeywords:奇妙负面效果>。选择手中 2 张不具有「乐音」的非消耗且非衍生的指令卡添加「<HuihuanbKeywords:回环乐音>」。每次若没有手牌可被添加，改为额外造成 3 次伤害。"
  },
  Skill_59477_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_59478_AwakerSkillBackgroundStory = {
    Text = "如果灵魂能够拆分，构成它的是否将是音符。 高与低、快与慢，新生的啼哭与死亡的哀嚎一同奏响。 请听吧，请高声和唱，这描摹你灵魂样貌的序章。"
  },
  Skill_59478_BattleDesc = {
    Text = "随机造成 [Arg2] 次 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，每次造成伤害都有 50% 概率对目标随机施加 1 种<MysterydebuffKeywords:奇妙负面效果>。若打出时算力消耗为 0，额外造成 2 次伤害。"
  },
  Skill_59478_Desc = {
    Text = "随机造成 3 次 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，每次造成伤害都有 50% 概率对目标随机施加 1 种<MysterydebuffKeywords:奇妙负面效果>。若打出时算力消耗为 0，额外造成 2 次伤害。"
  },
  Skill_59478_EffectNameList = {Text = "伤害"},
  Skill_59478_Name = {
    Text = "灵魂序曲"
  },
  Skill_59478_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_59479_AwakerSkillBackgroundStory = {
    Text = "你听过这样的乐音吗？ 它是那样熟悉、亲切，让你回想起一生的余韵。 到底在哪里曾听过呢？ 在你的梦中，在你的回忆中，或是在临死前天国的召唤中，由那吹笛的天使轻柔奏响。"
  },
  Skill_59479_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。将 2 张<DerivativeCardKeywords_4:「灵感」>置入手中。算力不足时仍可强行打出，效果改为将 2 张「灵感」洗入抽牌堆。"
  },
  Skill_59479_EffectNameList = {Text = "力量"},
  Skill_59479_Name = {
    Text = "追忆回旋曲"
  },
  Skill_59479_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_59490_Desc = {
    Text = "你打出的下一张非衍生指令卡算力消耗 +2，生效 2 次。"
  },
  Skill_59490_Name = {Text = "上行音"},
  Skill_59491_Desc = {
    Text = "你打出的下一张非衍生指令卡算力消耗 -2。"
  },
  Skill_59491_Name = {Text = "下行音"},
  Skill_59665_Desc = {
    Text = "战斗结束后仍会保存在牌库中。你已经被警卫发现了……"
  },
  Skill_59665_Name = {Text = "警觉"},
  Skill_59735_Desc = {
    Text = "全体目标回复 15% 已损失生命。"
  },
  Skill_59735_Name = {Text = "圣愈"},
  Skill_59736_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> 2 回合。使所有卡牌附加「侵食」1 回合。"
  },
  Skill_59736_Name = {
    Text = "万物侵食"
  },
  Skill_59737_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 1 张「逐渐遗忘」置入手中。<WeaknessIconKeywords:虚弱> 2 回合。将 2 张<DerivativeCardKeywords_38:幻觉>塞入抽牌堆。"
  },
  Skill_59737_Name = {
    Text = "永恒忘却"
  },
  Skill_59738_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。将 1 张「融蚀之芯」置入抽牌堆。<HeavyInjuryKeywords:重创> 2 回合。"
  },
  Skill_59738_Name = {Text = "毁灭"},
  Skill_59739_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。将 1 张「融蚀之芯」置入抽牌堆。<HeavyInjuryKeywords:重创> 2 回合。"
  },
  Skill_59739_Name = {
    Text = "覆亡毁灭"
  },
  Skill_59740_Desc = {
    Text = "全体目标移除<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>、<HeavyInjuryKeywords:重创>状态，降低它们 25% <IntoxicationIconKeywords:中毒>。"
  },
  Skill_59740_Name = {Text = "净化"},
  Skill_59866_Desc = {
    Text = "移动至后方，进入「混沌降临」状态并使「混沌」层数恢复至上限。若场上存在「N」的分身，为其添加 5 层屏障，之后将分身召唤至上限。若已拥有 3 层「黑暗」，额外使自身获得 1 层疯狂。"
  },
  Skill_59866_Name = {
    Text = "混沌降临"
  },
  Skill_59867_Desc = {
    Text = "造成 [Arg1] 点伤害 [Arg2] 次，将 1 张「惊厥」洗入玩家弃牌堆。场上每存在一个「呢喃」的分身，额外洗入 1 张。"
  },
  Skill_59867_Name = {
    Text = "无言恐惧"
  },
  Skill_60001_Desc = {
    Text = "获得 1 层<MadnessIconKeywords:疯狂>。对手失去 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  Skill_60001_Name = {Text = "低吼"},
  Skill_60002_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，未被完全格挡的部分会造成等量<BleedingIconKeywords:出血>。"
  },
  Skill_60002_Name = {Text = "出血爪"},
  Skill_60003_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_60025_Desc = {
    Text = "将牌堆中 3 张卡牌算力消耗变为 3。"
  },
  Skill_60025_Name = {Text = "啼鸣"},
  Skill_60026_Desc = {
    Text = "造成 1 回合的 <WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱> 和 <HeavyInjuryKeywords:重创>。"
  },
  Skill_60026_Name = {Text = "振翅"},
  Skill_60027_Desc = {
    Text = "自身死亡，造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，使 4 张卡牌产生<AberrationKeywords:畸变>。"
  },
  Skill_60027_Name = {Text = "尾针！"},
  Skill_60039_Desc = {
    Text = "查看 3 个未携带的钥令，选择 1 个立即释放。获得 1 点算力，驱散自身<IntoxicationIconKeywords:中毒>、封印、<SlowIconKeywords:迟缓>状态。"
  },
  Skill_60039_Name = {
    Text = "乌托邦帷幕"
  },
  Skill_60040_Desc = {
    Text = "弃掉所有手牌，抽取弃牌数 +3 张牌。"
  },
  Skill_60040_Name = {
    Text = "畸变之心"
  },
  Skill_60041_Desc = {
    Text = "选择一名唤醒体使其获得 [Arg1] 点狂气。"
  },
  Skill_60041_Name = {
    Text = "天真的回礼"
  },
  Skill_60042_Desc = {
    Text = "获得 [Arg1] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_60042_Name = {
    Text = "蜂蜜甜酒"
  },
  Skill_60047_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_60048_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，狂气最高的唤醒体失去 50% 狂气。"
  },
  Skill_60048_Name = {
    Text = "狂气窃取"
  },
  Skill_60060_Desc = {
    Text = "回复 [Arg1]% 生命。场上每存在一个正在「低语」的分身，额外回复 [Arg2]% 已损生命。"
  },
  Skill_60060_Name = {
    Text = "暗色侵蚀"
  },
  Skill_60071_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，召唤 [Arg3] 只「搜查猫」在前方，自身生命越低召唤的宠物越强大。"
  },
  Skill_60071_Name = {Text = "豢养"},
  Skill_60072_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，召唤 [Arg3] 只「搜查猫」在前方，自身生命越低召唤的宠物越强大。"
  },
  Skill_60072_Name = {Text = "豢养"},
  Skill_60073_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，召唤 [Arg3] 只「搜查猫」在前方，自身生命越低召唤的宠物越强大。"
  },
  Skill_60073_Name = {Text = "豢养"},
  Skill_60074_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重创>  [Arg3] 回合。"
  },
  Skill_60074_Name = {
    Text = "「重创」飞刃"
  },
  Skill_60075_Desc = {
    Text = "召唤 [Arg1] 只「小蜜蜂」在后方，自身生命越低召唤的宠物越强大。"
  },
  Skill_60075_Name = {Text = "归巢"},
  Skill_60076_Desc = {
    Text = "召唤 [Arg1] 只「小蜜蜂」在后方，自身生命越低召唤的宠物越强大。使所有友方获得 [Arg2] 层屏障，屏障数量随着回合数提高。"
  },
  Skill_60076_Name = {
    Text = "群鸟归巢"
  },
  Skill_60077_Desc = {
    Text = "召唤 [Arg1] 只「小蜜蜂」在后方，自身生命越低召唤的宠物越强大。"
  },
  Skill_60077_Name = {Text = "归巢"},
  Skill_60078_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重创>  [Arg3] 回合。"
  },
  Skill_60078_Name = {
    Text = "「重创」飞刃"
  },
  Skill_60079_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，<HeavyInjuryKeywords:重创>  [Arg3] 回合。"
  },
  Skill_60079_Name = {
    Text = "「重创」飞刃"
  },
  Skill_60080_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60080_Name = {Text = "制裁"},
  Skill_60081_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60081_Name = {Text = "制裁"},
  Skill_60082_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60082_Name = {Text = "制裁"},
  Skill_60131_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点戒备。"
  },
  Skill_60131_Name = {
    Text = "机械武装-敛"
  },
  Skill_60132_Desc = {
    Text = "回合结束时根据不同状态获得不同强化：放-获得 1 层临时<MadnessIconKeywords:疯狂>。敛-获得 50 层临时<ReinforcePVEKeywords:加固>。"
  },
  Skill_60132_Name = {
    Text = "参数拟合"
  },
  Skill_60133_Desc = {
    Text = "获得 [Arg1] 点力量。"
  },
  Skill_60133_Name = {
    Text = "机械武装-放"
  },
  Skill_60134_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并获得 [Arg3] 点护盾。"
  },
  Skill_60134_Name = {
    Text = "电磁爆破"
  },
  Skill_60135_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg2] 层屏障。每次「形态切换」会使伤害次数和屏障数提高 1。"
  },
  Skill_60135_Name = {
    Text = "机能过载"
  },
  Skill_60136_Desc = {
    Text = "获得 [Arg1] 点护盾和 [Arg2] 点临时<RetaliateIconKeywords:反击>。"
  },
  Skill_60136_Name = {Text = "防御"},
  Skill_60137_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60137_Name = {Text = "打击"},
  Skill_60171_Desc = {
    Text = "造成 [Arg1] 点<BleedingIconKeywords:出血>和 [Arg2] 点护盾。该出血受力量提高加成。"
  },
  Skill_60171_Name = {Text = "出血"},
  Skill_60172_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得等同于未被格挡伤害的临时<PowerIconKeywords:力量>。"
  },
  Skill_60172_Name = {
    Text = "试探剑招"
  },
  Skill_60173_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_60173_Name = {Text = "重创"},
  Skill_60174_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 点临时<RetaliateIconKeywords:反击>。"
  },
  Skill_60174_Name = {Text = "剑势"},
  Skill_60175_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复等同于未被格挡伤害 10 倍的生命。"
  },
  Skill_60175_Name = {
    Text = "蚀血剑招"
  },
  Skill_60176_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60176_Name = {Text = "幻影剑"},
  Skill_60177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_60177_Name = {Text = "破甲"},
  Skill_60178_Desc = {
    Text = "造成 [Arg1] 点<BleedingIconKeywords:出血>和 [Arg2] 点护盾。该出血受力量提高加成。"
  },
  Skill_60178_Name = {Text = "出血"},
  Skill_60179_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，施加 [Arg2] 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_60179_Name = {Text = "剑意"},
  Skill_60180_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_60180_Name = {Text = "破甲"},
  Skill_60181_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 点临时<RetaliateIconKeywords:反击>。"
  },
  Skill_60181_Name = {Text = "剑势"},
  Skill_60182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60182_Name = {Text = "幻影剑"},
  Skill_60192_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，施加 [Arg2] 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_60192_Name = {Text = "剑意"},
  Skill_60193_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得等同于未被格挡伤害的临时<PowerIconKeywords:力量>。"
  },
  Skill_60193_Name = {
    Text = "试探剑招"
  },
  Skill_60194_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<HeavyInjuryKeywords:重创>。"
  },
  Skill_60194_Name = {Text = "重创"},
  Skill_60195_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回复等同于未被格挡伤害 10 倍的生命。"
  },
  Skill_60195_Name = {
    Text = "蚀血剑招"
  },
  Skill_60252_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次和等量 <BleedingIconKeywords:出血>。"
  },
  Skill_60252_Name = {
    Text = "割裂之刃"
  },
  Skill_60253_Desc = {
    Text = "造成 [Arg1] 点<BleedingIconKeywords:出血>和 [Arg2] 点护盾。该出血受力量提高加成。"
  },
  Skill_60253_Name = {Text = "败血"},
  Skill_60254_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 点临时<RetaliateIconKeywords:反击>。施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_60254_Name = {Text = "剑势"},
  Skill_60255_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_60255_Name = {
    Text = "破甲之刃"
  },
  Skill_60256_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺>伤害，目标生命越高伤害越高。施加 [Arg3] 层<FragileIconKeywords:脆弱>。"
  },
  Skill_60256_Name = {
    Text = "影刃「<PunctureDamagewords:穿刺>」"
  },
  Skill_60272_Desc = {
    Text = "将 3 张随机<AberrationKeywords:畸变>和 1 张「症状」置入抽牌堆。"
  },
  Skill_60272_Name = {
    Text = "为了这个世界"
  },
  Skill_60273_Desc = {
    Text = "告诉我，守密人…是什么让你仍旧坚持战斗？\n若此卡仍在手中时打出了其他卡牌，「塔薇」将会愤怒，对我方造成 [Arg1] 点<FixedDamage:纯粹伤害>。"
  },
  Skill_60273_Name = {
    Text = "回答塔薇"
  },
  Skill_60274_Desc = {
    Text = "「塔薇」获得 3 层 <ExclamationPointColour:怨恨锁链>。"
  },
  Skill_60274_Name = {
    Text = "为了在意的人"
  },
  Skill_60275_Desc = {
    Text = "将随机 7 张指令卡附加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_60275_Name = {
    Text = "只是为了自己而已"
  },
  Skill_60285_Desc = {
    Text = "选择一名唤醒体获得 30 狂气，其他唤醒体失去 10 狂气。此卡回合结束若在手中，对我方造成 [Arg1] 点伤害。"
  },
  Skill_60285_Name = {
    Text = "真·轮回悖论"
  },
  Skill_60286_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 2 张「真·轮回悖论」加入手牌。"
  },
  Skill_60286_Name = {
    Text = "双翼初张"
  },
  Skill_60287_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 6 张「真·轮回悖论」加入手牌。"
  },
  Skill_60287_Name = {
    Text = "六翼满开"
  },
  Skill_60288_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 4 张「真·轮回悖论」加入手牌。"
  },
  Skill_60288_Name = {
    Text = "四翼渐生"
  },
  Skill_60293_Desc = {
    Text = "提升 2 倍生命上限。每回合开始时将 1 张「回答塔薇」置入手中。"
  },
  Skill_60293_Name = {Text = "复苏"},
  Skill_60309_Desc = {
    Text = "于融蚀中挣扎，于融蚀中消亡。抽到时失去 25% 的当前算力和狂气。打出后失去 20% <PowerIconKeywords:力量>和<RetaliateIconKeywords:反击>。回合结束时若在手中，生命上限降低 5%。"
  },
  Skill_60309_Name = {
    Text = "融蚀之芯"
  },
  Skill_60310_Desc = {
    Text = "回复 15% 已损失生命([Arg2])，本回合释放狂气爆发时回复 5% 已损失生命。还可使用 [Arg1] 次。"
  },
  Skill_60310_Name = {Text = "沉眠曲"},
  Skill_60335_Desc = {
    Text = "你正在遗忘世界，世界也正在遗忘你。回合结束前，将所有其他手牌变为<DerivativeCardKeywords_38:幻觉>并弃掉。"
  },
  Skill_60335_Name = {
    Text = "记忆消解"
  },
  Skill_60397_Desc = {
    Text = "获得 20 层<ReinforcePVEKeywords:加固>和 [Arg1] 点<PowerIconKeywords:力量>。后续每受到 1 次伤害就获得 2 层临时<ReinforcePVEKeywords:加固>。"
  },
  Skill_60397_Name = {
    Text = "终焉进化"
  },
  Skill_60398_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 2 回合的<BlindingKeywords:致盲> 和 <HeavyInjuryKeywords:重创>。"
  },
  Skill_60398_Name = {
    Text = "「鬼面撕咬」"
  },
  Skill_60399_Desc = {
    Text = "获得 [Block:Arg1] 点护盾，[Arg2] 点<PowerIconKeywords:力量>，[Arg3] 点<RetaliateIconKeywords:反击>，解除自身负面状态。"
  },
  Skill_60399_Name = {Text = "蜕变"},
  Skill_60424_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中。本回合触发「音符律令」时,将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  Skill_60424_Name = {
    Text = "追忆回旋曲\n算力 ≥2"
  },
  Skill_60425_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得等同于未被格挡伤害的临时<PowerIconKeywords:力量>，回复等同于未被格挡伤害 10 倍的生命。"
  },
  Skill_60425_Name = {
    Text = "原初的乐音\n算力 ≤2"
  },
  Skill_60426_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并降低目标 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60426_Name = {
    Text = "下行音\n算力 1"
  },
  Skill_60427_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次并获得 [Arg3] 层永久<ReinforcePVEKeywords:加固>。"
  },
  Skill_60427_Name = {
    Text = "上行音\n算力 3"
  },
  Skill_60428_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每次未被格挡的伤害都会附加 1 个随机负面效果。之后的「灵魂序曲」伤害次数 +1。"
  },
  Skill_60428_Name = {
    Text = "灵魂序曲\n算力 0"
  },
  Skill_60475_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_60475_Name = {
    Text = "绵长恨怨"
  },
  Skill_60476_Desc = {
    Text = "全体友方获得 [Arg1]点<PowerIconKeywords:力量>，驱散自身<WeaknessIconKeywords:虚弱>与<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_60476_Name = {
    Text = "绝境求生"
  },
  Skill_60477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_60478_Desc = {
    Text = "移除所有拟态唤醒体。召唤 2 名拟态唤醒体。本场战斗中所有唤醒体造成的狂气降低 50%。"
  },
  Skill_60478_Name = {
    Text = "目见母亲"
  },
  Skill_60479_Desc = {
    Text = "召唤 1 名拟态唤醒体。若拟态唤醒体已满，意图变为「打击」。"
  },
  Skill_60479_Name = {
    Text = "圣血的本能"
  },
  Skill_60480_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_60480_Name = {
    Text = "石质分解"
  },
  Skill_60481_Desc = {
    Text = "使狂气最高的唤醒体失去 50 点狂气，执行 2 次。施加 2 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虚弱>。"
  },
  Skill_60481_Name = {
    Text = "古老的爱抚"
  },
  Skill_60482_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，抽牌堆顶的 [Arg3] 张卡牌施加「<SlowIconKeywords:迟缓>」和「<RetainIconKeywords:保留>」。"
  },
  Skill_60482_Name = {
    Text = "凝滞诅咒"
  },
  Skill_60483_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加等同于伤害 [Arg3]% 的<IntoxicationIconKeywords:中毒>，[Arg4]% 的<BleedingIconKeywords:出血>，[Arg5]% 的<RetaliateIconKeywords:反击>。"
  },
  Skill_60483_Name = {
    Text = "丰穰之仪"
  },
  Skill_60498_Desc = {
    Text = "全体友方每回合开始时获得护盾，等同于上回合受到的伤害的一半。"
  },
  Skill_60498_Name = {
    Text = "献媚者之拥"
  },
  Skill_60501_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 2 张<DerivativeCardKeywords_34:「未被满足之痛」>置入抽牌堆。"
  },
  Skill_60501_Name = {Text = "苦痛"},
  Skill_60514_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<BleedingIconKeywords:出血>。"
  },
  Skill_60514_Name = {Text = "飞刃"},
  Skill_60515_Desc = {
    Text = "获得 10 层<BloodOath:血誓>，施加 2 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_60515_Name = {
    Text = "血红誓言"
  },
  Skill_60516_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每层<BloodOath:血誓>使伤害提高 [Arg3] 点。"
  },
  Skill_60516_Name = {
    Text = "降罪灯火"
  },
  Skill_60517_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_60517_Name = {Text = "污染"},
  Skill_60535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 2 回合<FragileIconKeywords:脆弱>。将 1 张「血污灯芯」置入手中。"
  },
  Skill_60535_Name = {Text = "污染"},
  Skill_60536_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。随机施加<FragileIconKeywords:脆弱>或<HeavyInjuryKeywords:重创> 2 回合。将 1 张「血污灯芯」置入手中。"
  },
  Skill_60537_Desc = {
    Text = "获得 10 层<BloodOath:血誓>，施加 2 回合<HeavyInjuryKeywords:重创>。将 1 张「血污灯芯」置入手中。"
  },
  Skill_60537_Name = {
    Text = "血红誓言"
  },
  Skill_60538_Desc = {
    Text = "获得 [Arg3] 点 <SacrificeKeyWord:献祭>和 [Arg4] 点<PowerIconKeywords:力量>。回合结束时若此卡仍然在手中，则使「灯罩」阿依莎失去 [Arg1] 点生命并获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_60538_Name = {
    Text = "血污灯芯"
  },
  Skill_60539_Desc = {
    Text = "获得加固至 80 层，回合结束时获得 10 层<BloodOath:血誓>。"
  },
  Skill_60539_Name = {Text = "破蛹"},
  Skill_60540_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每层<BloodOath:血誓>使伤害提高 [Arg3] 点。"
  },
  Skill_60540_Name = {
    Text = "降罪灯火"
  },
  Skill_60541_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<BleedingIconKeywords:出血>。"
  },
  Skill_60541_Name = {Text = "败血"},
  Skill_60542_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每 2 层<BloodOath:血誓>使伤害次数提高 1。"
  },
  Skill_60542_Name = {
    Text = "灯芯长明"
  },
  Skill_60552_Desc = {
    Text = "选择：「<DerivativeCardKeywords_61:上行音>」或「<DerivativeCardKeywords_62:下行音>」。"
  },
  Skill_60552_Name = {
    Text = "协乐的交响"
  },
  Skill_60590_BattleDesc = {
    Text = "本回合下一张打出的卡牌若算力消耗大于等于 3，获得 2 点算力，否则抽 2 张牌。若为本场战斗中第 4 次生效，改为直接获得 4 张<DerivativeCardKeywords_4:「灵感」>。([Arg1]/4)"
  },
  Skill_60590_Desc = {
    Text = "本回合下一张打出的卡牌若算力消耗大于等于 3，获得 2 点算力，否则抽 2 张牌。若为本场战斗中第 4 次生效，改为直接获得 4 张<DerivativeCardKeywords_4:「灵感」>。"
  },
  Skill_60590_Name = {
    Text = "第四乐章"
  },
  Skill_60837_Desc_1 = {
    Text = "造成 [Arg1] 层<PVPSlowKeywords:迟缓>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_60837_Name_1 = {
    Text = "第四乐章"
  },
  Skill_60837_UnknownName = {
    Text = "第四乐章"
  },
  Skill_60845_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，[Arg2]<PVPSlowKeywords:迟缓>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_60845_Name_1 = {
    Text = "悲怆弱音"
  },
  Skill_60846_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，附加伤害 [Arg2]% 的<PVPBleedingKeywords:出血>，若目标拥有可驱散的负面状态则提升到 [Arg3]%。"
  },
  Skill_60846_Name_1 = {
    Text = "原初的乐音"
  },
  Skill_60848_Desc_1 = {
    Text = "获得 <Energy:[Energy:Arg1]> 狂气，<DelayKeywords:延迟 1>：扣除 [Arg2] 算力。"
  },
  Skill_60848_Name_1 = {
    Text = "田园和声"
  },
  Skill_60849_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_60849_Name_1 = {
    Text = "惊愕强音"
  },
  Skill_60884_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_60884_Name_1 = {Text = "打击"},
  Skill_60927_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_60928_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_60929_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，获得 5 层祈祷，和最后的友方交换位置。"
  },
  Skill_60929_Name = {Text = "祈祷"},
  Skill_60930_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。自身获得 2 层屏障，和最前方友方交换位置。"
  },
  Skill_60931_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_60931_Name = {
    Text = "灯芯长明"
  },
  Skill_60932_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 点力量，和最前方友方交换位置。"
  },
  Skill_60932_Name = {
    Text = "蜡像登场"
  },
  Skill_60933_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_9:蹒跚>和<DerivativeCardKeywords_32:黏糊糊的蜡油>洗入抽牌堆。和最后方友方交换位置。"
  },
  Skill_60933_Name = {
    Text = "隆重的接待"
  },
  Skill_60934_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_60934_Name = {
    Text = "蜡像登场"
  },
  Skill_60937_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 点力量，和最前方友方交换位置。将 1 张<DerivativeCardKeywords_9:蹒跚>和<DerivativeCardKeywords_32:黏糊糊的蜡油>洗入抽牌堆。"
  },
  Skill_60937_Name = {
    Text = "蜡像登场"
  },
  Skill_60938_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_60939_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱> 2 回合。"
  },
  Skill_60939_Name = {
    Text = "蜡像登场"
  },
  Skill_60952_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前对全体敌方造成 [Arg1] 层<PVPSlowKeywords:迟缓>。"
  },
  Skill_60952_Name_1 = {
    Text = "永恒安魂曲"
  },
  Skill_61119_AwakerSkillBackgroundStory = {
    Text = "拉克西斯手执长尺，歌唱提洛人的一生：\n屠戮斯巴达的杀手，你本可以成为英雄，\n提希丰蒙蔽了你的双眼，她的羽翼成了捆绳，\n她让你成为仇恨的奴隶，眼里只有鲜红。"
  },
  Skill_61119_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害和等量<BleedingIconKeywords:出血>，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_61119_Desc_2 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害和等量<BleedingIconKeywords:出血>，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。若生命低于 50%，获得的<PowerIconKeywords:力量>翻倍。"
  },
  Skill_61119_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_61119_Name = {
    Text = "恨意宣泄"
  },
  Skill_61119_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_61120_AwakerSkillBackgroundStory = {
    Text = "杀戮，杀戮，直到仅剩死亡。"
  },
  Skill_61120_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_61120_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。获得 [Arg3] %临时暴击率和暴击伤害。"
  },
  Skill_61120_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。血链·希洛获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_61120_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。血链·希洛获得 <Energy:[Energy:Arg2]> 点狂气。血链·希洛获得 [Arg3] %临时暴击率和暴击伤害。"
  },
  Skill_61120_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_61120_Name = {Text = "打击"},
  Skill_61120_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_61121_AwakerSkillBackgroundStory = {
    Text = "阿特洛波斯剪断了黑色的线，提洛人的命运断绝。\n那将枷锁当做武器的杀手，曾如此骁勇，\n最终也在无数长枪前倒下。"
  },
  Skill_61121_BattleDesc = {
    Text = "失去 10%( [Arg2] ) 当前生命，随机造成 <Damage:[Damage:Arg1]> 点伤害 2 次并附加 50% 伤害的<BleedingIconKeywords:出血>。打出 3 次后，变为「<DerivativeCardKeywords_66:嗜血链球>」( [Arg3]/3 )。"
  },
  Skill_61121_Desc = {
    Text = "失去 10% 当前生命，随机造成 <Damage:[Damage:Arg1]> 点伤害 2 次并附加 50% 伤害的<BleedingIconKeywords:出血>。打出 3 次后，变为「<DerivativeCardKeywords_66:嗜血链球>」。"
  },
  Skill_61121_EffectNameList = {Text = "伤害"},
  Skill_61121_Name = {
    Text = "鲜血链条"
  },
  Skill_61121_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_61122_AwakerSkillBackgroundStory = {
    Text = "阿特洛波斯剪断了黑色的线，提洛人的命运断绝。\n那将枷锁当做武器的杀手，曾如此骁勇，\n最终也在无数长枪前倒下。"
  },
  Skill_61122_BattleDesc = {
    Text = "视为「打击」。造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 5 倍力量加成并触发目标 30% 的<BleedingIconKeywords:出血>，回复 [Arg3]% 已损失的生命(<Heal:[Arg2]>)。打出后变为「<DerivativeCardKeywords_65:鲜血链条>」。"
  },
  Skill_61122_Desc = {
    Text = "视为「打击」。造成 <Damage:[Damage:Arg1]> 点伤害，该伤害享受 5 倍力量加成并触发目标 30% 的<BleedingIconKeywords:出血>，回复已损失生命的 15%。打出后变为「<DerivativeCardKeywords_65:鲜血链条>」。"
  },
  Skill_61122_EffectNameList = {Text = "伤害"},
  Skill_61122_Name = {
    Text = "嗜血链球"
  },
  Skill_61122_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_61123_AwakerSkillBackgroundStory = {
    Text = "歌唱吧，女神！歌唱提洛之女的命运：\n充满了鲜血与泪水，愤怒与绝望。\n她的仇恨如同烈火，燃尽周围的一切，而最终，\n带来了她自己的死亡。"
  },
  Skill_61123_Desc_0 = {
    Text = "血链·希洛获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：将一张「<DerivativeCardKeywords_65:鲜血链条>」置入手中，血链·希洛的指令卡获得「<RetainIconKeywords:保留>」。回合开始时，血链·希洛基础伤害在本场战斗中提高 [Arg2]%。"
  },
  Skill_61123_Desc_15 = {
    Text = "血链·希洛获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：将一张「<DerivativeCardKeywords_65:鲜血链条>」置入手中，血链·希洛的指令卡获得「<RetainIconKeywords:保留>」。回合开始时，血链·希洛基础伤害在本场战斗中提高 [Arg2]%。释放狂气爆发「缚身锁链」后，赋予手中每张不同的「血链·希洛」指令卡 50 层<TempPowerKeywords:临时强化>。"
  },
  Skill_61123_EffectNameList = {
    Text = "狂气,伤害提高"
  },
  Skill_61123_Name = {
    Text = "索魂者宣言"
  },
  Skill_61123_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2%"
  },
  Skill_61124_AwakerSkillBackgroundStory = {
    Text = "克洛托，克洛托，手执纺锤的女神，\n你从何处取了这线？\n即便打破镣铐，那可怜的提洛人，\n也无法逃离命运的锁链。"
  },
  Skill_61124_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 点伤害。"
  },
  Skill_61124_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。"
  },
  Skill_61124_EffectNameList = {
    Text = "伤害,出血比例"
  },
  Skill_61124_Name = {
    Text = "缚身锁链"
  },
  Skill_61124_OverLimitUtlSkillDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。血链·希洛暴击伤害提高 35%，临时手牌上限+2，将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。"
  },
  Skill_61124_OverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。血链·希洛暴击伤害提高 35%，临时手牌上限+2，将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。"
  },
  Skill_61124_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2%"
  },
  Skill_61124_tempBattleDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。造成 <Damage:[Damage:Arg1]> 点伤害。"
  },
  Skill_61124_tempBattleDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。"
  },
  Skill_61124_tempBattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。赋予手中每张不同的自身指令卡 50 层「临时强化」，回合结束或打出后移除。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_1 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。血链·希洛暴击伤害提高 35%，临时手牌上限+2，将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。血链·希洛暴击伤害提高 35%，临时手牌上限+2，将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。"
  },
  Skill_61124_tempOverLimitUtlSkillDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：抽 1 张血链·希洛的指令卡，使手中血链·希洛的指令卡算力消耗降低 1。】本回合血链·希洛造成主动伤害时，附加 [Arg2]%<BleedingIconKeywords:出血>。破除目标护盾，造成 <Damage:[Damage:Arg1]> 点伤害并使目标无法获得护盾，持续 1 回合。血链·希洛暴击伤害提高 35%，临时手牌上限+2，将 1 张「恨意宣泄」和「鲜血链条」置入手中，并使它们算力消耗-1。赋予手中每张不同的自身指令卡 50 层「临时强化」，回合结束或打出后移除。"
  },
  Skill_61125_Desc = {
    Text = "选择血链·希洛的一张基础指令卡置入手牌。"
  },
  Skill_61125_Name = {
    Text = "不规则形态 · 血链"
  },
  Skill_61126_AwakerSkillBackgroundStory = {
    Text = "忍耐，等待。所有的苦难，都将被复仇的鲜血浇灌。"
  },
  Skill_61126_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_61126_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。触发所有敌人 [Arg3]% 的<BleedingIconKeywords:出血>。"
  },
  Skill_61126_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。血链·希洛获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_61126_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。血链·希洛获得 <Energy:[Energy:Arg2]> 点狂气。触发所有敌人 [Arg3]% 的<BleedingIconKeywords:出血>。"
  },
  Skill_61126_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_61126_Name = {Text = "防御"},
  Skill_61126_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_61535_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机冻结一张卡牌。"
  },
  Skill_61535_Name = {Text = "冰刺"},
  Skill_61536_Desc = {
    Text = "回合结束时获得 <Block:[Block:Arg1]> 点 <CardKeyWord:霜盾> 和  [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_61536_Name = {
    Text = "霜寒彻骨"
  },
  Skill_61537_Desc = {
    Text = "所有唤醒体失去 10 点狂气。"
  },
  Skill_61537_Name = {Text = "诅咒"},
  Skill_62216_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_62216_Name = {
    Text = "终结……"
  },
  Skill_62217_Desc = {
    Text = "获得 [Arg1] 层<ReinforcePVEKeywords:加固>。"
  },
  Skill_62217_Name = {
    Text = "深空注目"
  },
  Skill_62218_Desc = {
    Text = "祂看着你。将一张「症状」永久置入你的牌库。"
  },
  Skill_62218_Name = {
    Text = "凝视-倒计时：1"
  },
  Skill_62221_Desc = {
    Text = "自身隐匿，号令万千世界的目光前来战斗。"
  },
  Skill_62221_Name = {
    Text = "万千世界之眼"
  },
  Skill_62305_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] <StrongEffectKeywords:强效>。每当失去生命后，若当前生命低于 [Arg2]%，获得<ReinforceKeywords:加固>和<StrengthenKeywords:强化>。"
  },
  Skill_62305_Name_1 = {
    Text = "沉入殷红"
  },
  Skill_62306_Desc_1 = {
    Text = "给予任意目标 <TauntKeywords:嘲讽>和 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_62306_Name_1 = {
    Text = "群山的觉悟"
  },
  Skill_62306_UnknownName = {
    Text = "群山的觉悟"
  },
  Skill_62311_Desc = {
    Text = "造成 <FragileIconKeywords:脆弱> 1 回合。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，手牌中每有 1 张冻结的卡牌额外造成 1 次伤害，将那些被冻结的卡牌消耗。"
  },
  Skill_62311_Name = {Text = "冰之语"},
  Skill_62312_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。手牌中每有 1 张冻结的卡牌伤害提高 [Arg3] 点。<WeaknessIconKeywords:虚弱> 1 回合。"
  },
  Skill_62312_Name = {Text = "寒焰"},
  Skill_62314_Desc = {
    Text = "召唤两名「冷冽之灵」，所有友方获得 [Arg1] 点 <CardKeyWord:霜盾>。"
  },
  Skill_62314_Name = {
    Text = "冷冽之灵"
  },
  Skill_62315_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。手牌中每有 1 张冻结的卡牌则伤害提高 [Arg3] 点。<WeaknessIconKeywords:虚弱> 3 回合。"
  },
  Skill_62315_Name = {
    Text = "凛冽寒焰"
  },
  Skill_62316_Desc = {
    Text = "造成 <FragileIconKeywords:脆弱> 3 回合。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，手牌中每有 1 张冻结的卡牌额外造成 1 次伤害，将那些被冻结的卡牌消耗。"
  },
  Skill_62316_Name = {Text = "冰之怒"},
  Skill_65341_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。冻结牌库顶的 2 张指令卡。"
  },
  Skill_65341_Name = {Text = "霜棱"},
  Skill_65357_Desc = {
    Text = "选择一名唤醒体，抽 2 张该唤醒体的指令卡。"
  },
  Skill_65357_Name = {
    Text = "群山的觉悟"
  },
  Skill_65369_Desc = {
    Text = "损失 1 名科考团人员，抽 [Arg2] 张牌，获得 [Arg2] 算力。失去 10% 最大生命([Arg1])。"
  },
  Skill_65369_Name = {
    Text = "主动约束"
  },
  Skill_65370_Desc = {
    Text = "损失 2 名科考团人员，抽 [Arg1] 张牌，获得 [Arg1] 算力。所有唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65370_Name = {
    Text = "理性交涉"
  },
  Skill_65371_Desc = {
    Text = "损失 5 名科考团人员，所有唤醒体获得 50 狂气，回复 30% 最大生命([Arg1])。抽 [Arg2] 张牌，获得 [Arg2] 算力。"
  },
  Skill_65371_Name = {
    Text = "置之不理"
  },
  Skill_65372_Desc = {
    Text = "若科考团人数为 0，此卡变为<DerivativeCardKeywords_9:「蹒跚」>。若回合结束后此卡仍在手中，下回合开始时所有敌人获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_65372_Name = {Text = "猜疑"},
  Skill_65393_Desc = {
    Text = "获得 [Arg1] 点算力，选择 1 名唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65393_Name = {
    Text = "人性光辉"
  },
  Skill_65451_Desc = {
    Text = "获得 [Arg1] 点算力，选择 1 名唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65451_Name = {
    Text = "微明的人性光辉"
  },
  Skill_65452_Desc = {
    Text = "获得 [Arg1] 点算力，选择 1 名唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65452_Name = {
    Text = "闪耀的人性光辉"
  },
  Skill_65453_Desc = {
    Text = "获得 [Arg1] 点算力，选择 1 名唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65453_Name = {
    Text = "暗淡的人性光辉"
  },
  Skill_65454_Desc = {
    Text = "获得 [Arg1] 点算力，所有唤醒体获得 [Arg2] 点狂气。"
  },
  Skill_65454_Name = {
    Text = "璀璨的人性光辉"
  },
  Skill_65462_Desc = {
    Text = "抽 [Arg2] 张牌，获得 [Arg2] 算力。失去 20% 最大生命([Arg1])。所有唤醒体失去 20 点狂气。"
  },
  Skill_65462_Name = {
    Text = "全力配合"
  },
  Skill_65545_Desc = {
    Text = "提高 15% 最大生命，并获得 [Arg1] 层<ReinforcePVEKeywords:加固> 和 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_65545_Name = {
    Text = "急冻复苏"
  },
  Skill_65546_Desc = {
    Text = "获得 [Arg1] 点霜盾，将 1 张<DerivativeCardKeywords_74:警觉>置入手中。"
  },
  Skill_65546_Name = {Text = "警备"},
  Skill_65547_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，消耗所有手中被冻结的卡牌。"
  },
  Skill_65547_Name = {
    Text = "碎冰猛凿"
  },
  Skill_65548_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_65548_Name = {
    Text = "刺骨挥击"
  },
  Skill_65549_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每造成一次未被完全格挡的伤害，随机冻结牌库中 1 张未被冻结的指令卡。"
  },
  Skill_65549_Name = {
    Text = "风雪挥击"
  },
  Skill_65550_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 层<SlowIconKeywords:迟缓>。"
  },
  Skill_65550_Name = {
    Text = "霜冻之咏"
  },
  Skill_65551_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，回合结束前每有 1 张手牌额外造成 1 次伤害，最大 10 次。"
  },
  Skill_65551_Name = {
    Text = "碎冰飞刃"
  },
  Skill_66041_Desc = {
    Text = "测试用的卡牌"
  },
  Skill_66041_Name = {
    Text = "技能@测试卡牌A"
  },
  Skill_66042_Desc = {
    Text = "测试用的卡牌"
  },
  Skill_66042_Name = {
    Text = "技能@测试卡牌B"
  },
  Skill_66043_Desc = {
    Text = "测试用的卡牌"
  },
  Skill_66043_Name = {
    Text = "技能@测试卡牌C"
  },
  Skill_66282_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_66282_Name = {
    Text = "原初混沌之核"
  },
  Skill_66283_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_66283_Name = {
    Text = "原初混沌之核"
  },
  Skill_66284_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_66284_Name = {
    Text = "原初混沌之灵"
  },
  Skill_66285_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_66285_Name = {
    Text = "原初混沌之种"
  },
  Skill_66286_Desc = {
    Text = "祂在疑惑。获得 [Arg1] 层临时「怨恨锁链」。"
  },
  Skill_66286_Name = {
    Text = "锁缚-倒计时：4"
  },
  Skill_66287_Desc = {
    Text = "祂很好奇。获得 [Arg1] 点 <PowerIconKeywords:力量>。"
  },
  Skill_66287_Name = {
    Text = "强化-倒计时：2"
  },
  Skill_66288_Desc = {
    Text = "祂在疑惑。获得 [Arg1] 层临时「怨恨锁链」。"
  },
  Skill_66288_Name = {
    Text = "锁缚-倒计时：3"
  },
  Skill_66289_Desc = {
    Text = "获得 [Arg1] 层 <ParcloseIconKeywords:屏障>。"
  },
  Skill_66289_Name = {
    Text = "盲目痴愚之壁"
  },
  Skill_66290_Desc = {
    Text = "对敌人添加「无上意志之威压」：在打出 1 张指令卡时，弃掉 1 张该唤醒体最低算力的指令卡。"
  },
  Skill_66290_Name = {
    Text = "无上意志之权"
  },
  Skill_66291_Desc = {
    Text = "将「融蚀之芯」洗入抽牌堆。"
  },
  Skill_66291_Name = {
    Text = "遗忘万物之影"
  },
  Skill_66292_Desc = {
    Text = "获得「亘古穿今之锁」：每回合结束时获得 1 层「怨恨锁链」。"
  },
  Skill_66292_Name = {
    Text = "亘古穿今之锁"
  },
  Skill_66296_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_66296_Name = {
    Text = "原初混沌之种"
  },
  Skill_66298_Desc = {
    Text = "自身隐匿，号令万千世界的目光前来战斗。"
  },
  Skill_66298_Name = {
    Text = "万千世界之眼"
  },
  Skill_66300_Desc = {
    Text = "获得 [Arg1] 层<ReinforcePVEKeywords:加固>，驱散所有敌人正面状态，驱散自身所有负面状态。"
  },
  Skill_66300_Name = {
    Text = "真·深空注目"
  },
  Skill_66301_Desc = {
    Text = "所有唤醒体失去一半狂气，对手失去 5 点算力上限和 10 点手牌上限。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，真正的原初…即将降临！"
  },
  Skill_66301_Name = {
    Text = "「世界崩析之融蚀」"
  },
  Skill_66302_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。所有唤醒体失去 100% 狂气。守密人算力上限 -5，手牌上限 -10。"
  },
  Skill_66302_Name = {
    Text = "「世界崩析之融蚀」"
  },
  Skill_66303_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_66303_Name = {
    Text = "原初混沌之灵"
  },
  Skill_66304_Desc = {
    Text = "通过移动自身的位置，改变「目光」的排列。"
  },
  Skill_66304_Name = {
    Text = "移形换影"
  },
  Skill_66349_AwakerSkillBackgroundStory = {
    Text = "她知晓过去、现在和未来。\n她知晓一切如何产生，又将如何消散。\n她的耳畔回荡那位「祂」的呼吸。"
  },
  Skill_66349_Desc_0 = {
    Text = "在手牌中时，若抽牌堆顶部的卡牌为指令卡，变为其复制。打出后还原，获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_66349_Desc_1 = {
    Text = "在手牌中时，若抽牌堆顶部的卡牌为指令卡，变为其算力消耗-1 的复制。打出后还原，获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_66349_EffectNameList = {Text = "狂气"},
  Skill_66349_Name = {
    Text = "通晓万物之理"
  },
  Skill_66349_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_66350_AwakerSkillBackgroundStory = {
    Text = "跨越银钥之扉，人类伏身于祂的王座前，探求终极的答案。\n而她是看门者，她负责劝阻、提醒、警示。\n不告知才是她的慈悲。"
  },
  Skill_66350_BattleDesc_0 = {
    Text = "塔薇获得 <Energy:[Energy:Arg1]> 点狂气。将 1 张「<DerivativeCardKeywords_67:银钥曦光>」置入手中。塔薇每消耗 1 点算力，获得 50% 银钥充能的银钥能量。"
  },
  Skill_66350_BattleDesc_15 = {
    Text = "塔薇获得 <Energy:[Energy:Arg1]> 点狂气。将 1 张「<DerivativeCardKeywords_67:银钥曦光>」置入手中。塔薇每消耗 1 点算力，获得 50% 银钥充能的银钥能量。塔薇释放狂气爆发后，所有唤醒体本回合指令卡最终伤害提高 [Arg2]％ 并使打出的下一张其它唤醒体的指令卡也能够额外生效 1 次。"
  },
  Skill_66350_Desc_0 = {
    Text = "塔薇获得 <Energy:[Energy:Arg1]> 点狂气。将 1 张「<DerivativeCardKeywords_67:银钥曦光>」置入手中。塔薇每消耗 1 点算力，获得 50% 银钥充能的银钥能量。"
  },
  Skill_66350_Desc_15 = {
    Text = "塔薇获得 <Energy:[Energy:Arg1]> 点狂气。将 1 张「<DerivativeCardKeywords_67:银钥曦光>」置入手中。塔薇每消耗 1 点算力，获得 50% 银钥充能的银钥能量。塔薇释放狂气爆发后，所有唤醒体本回合指令卡最终伤害提高 [Arg2]％ 并使打出的下一张其它唤醒体的指令卡也能够额外生效 1 次。"
  },
  Skill_66350_EffectNameList = {Text = "狂气"},
  Skill_66350_Name = {
    Text = "穿越银钥之门"
  },
  Skill_66350_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_66351_Desc = {
    Text = "算力不足时能消耗 <Posse:500> 银钥能量打出。造成 2 次 <Damage:[Damage:Arg1]> 点伤害，塔薇获得 <Energy:[Energy:Arg2]> 点狂气。抽 1 张牌。将<DerivativeCardKeywords_76:「四翼渐生」>洗入抽牌堆。"
  },
  Skill_66351_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_66351_Name = {
    Text = "双翼初张"
  },
  Skill_66351_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_66352_AwakerSkillBackgroundStory = {
    Text = "她无意阻碍。\n但超越之人陷入癫狂。"
  },
  Skill_66352_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_66352_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气、[Arg3]% 暴击率和暴击伤害，至多叠加 10 次([Arg4]/10 ) 。"
  },
  Skill_66352_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。塔薇获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_66352_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。塔薇获得 <Energy:[Energy:Arg2]> 点狂气、[Arg3]% 暴击率和暴击伤害，至多叠加 10 次。"
  },
  Skill_66352_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_66352_Name = {Text = "防御"},
  Skill_66352_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_66353_Desc = {
    Text = "算力不足时能消耗 <Posse:500> 银钥能量打出。造成 6 次 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。可以从 6 种「追忆」中选择一个触发其效果，该「追忆」在本次探索中无法被再次选择。"
  },
  Skill_66353_EffectNameList = {Text = "伤害"},
  Skill_66353_Name = {
    Text = "六翼满开"
  },
  Skill_66353_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_66354_AwakerSkillBackgroundStory = {
    Text = "她无意伤害。\n但真理之门出现裂隙。"
  },
  Skill_66354_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_66354_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气、[Arg3]% 暴击率和暴击伤害，至多叠加 10 次([Arg4]/10 ) 。"
  },
  Skill_66354_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。塔薇获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_66354_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。塔薇获得 <Energy:[Energy:Arg2]> 点狂气、[Arg3]% 暴击率和暴击伤害，至多叠加 10 次。"
  },
  Skill_66354_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_66354_Name = {Text = "打击"},
  Skill_66354_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_66355_BattleDesc = {
    Text = "算力不足时能消耗 <Posse:500> 银钥能量打出。造成 4 次 <Damage:[Damage:Arg1]> 点伤害，抽 1 张牌。每造成 1 次伤害临时降低目标 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>并获得 [Power:Arg2] 点<PowerIconKeywords:临时力量> 。将<DerivativeCardKeywords_77:「六翼满开」>洗入抽牌堆。"
  },
  Skill_66355_Desc = {
    Text = "算力不足时能消耗 <Posse:500> 银钥能量打出。造成 4 次 <Damage:[Damage:Arg1]> 点伤害，抽 1 张牌。每造成 1 次伤害<TouquKeywords:偷取>目标 [Arg2] 点临时<PowerIconKeywords:力量>。将<DerivativeCardKeywords_77:「六翼满开」>洗入抽牌堆。"
  },
  Skill_66355_EffectNameList = {
    Text = "伤害,偷取力量"
  },
  Skill_66355_Name = {
    Text = "四翼渐生"
  },
  Skill_66355_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_66356_AwakerSkillBackgroundStory = {
    Text = "一生万物。\n她支配时间和空间，自她的指尖流淌出秩序的世界。\n万物归一。\n无机物与有机物混沌一体，终将在那位「祂」的吐息中归于虚无。"
  },
  Skill_66356_Desc_0 = {
    Text = "本回合内自身指令卡最终伤害提高 15%。获得 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 5 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_Desc_2 = {
    Text = "本回合内自身指令卡最终伤害提高 15%。获得 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 5 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:预备1>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_EffectNameList = {
    Text = "银钥能量"
  },
  Skill_66356_Name = {
    Text = "万物归一"
  },
  Skill_66356_OverLimitUtlSkillDesc_0 = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [Arg2]%。获得 3 点算力和 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 10 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_OverLimitUtlSkillDesc_2 = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [Arg2]%。获得 3 点算力和 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 10 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:预备1>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_66356_tempBattleDesc_1 = {
    Text = "本回合内自身指令卡最终伤害提高 15%。获得 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 5 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:预备1>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempBattleDesc_2 = {
    Text = "本回合内自身指令卡最终伤害提高 15%。获得 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 5 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempBattleDesc_3 = {
    Text = "所有唤醒体本回合指令卡最终伤害提高 15%。获得 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 5 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:预备1>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡和其它唤醒体的指令卡各生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_1 = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [Arg2]%，本回合内自身指令卡最终伤害 +15%。获得 3 点算力和 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 10 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_2 = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [Arg2]%，本回合内自身指令卡最终伤害 +15%。获得 3 点算力和 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 10 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡生效 2 次。"
  },
  Skill_66356_tempOverLimitUtlSkillDesc_3 = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [Arg2]%，所有唤醒体本回合指令卡最终伤害提高 15%。获得 3 点算力和 <Posse:[Arg1]> 点银钥能量。从当前界域的技能卡中<FaxianKeywords:发现> 10 张，选择至多 3 张置入手中并使其视为塔薇的卡牌，这些卡牌获得<DepleteIconKeywords:消耗>、<PrepareKeypvewords1:预备1>和<RetainIconKeywords:保留>。下一张打出的塔薇的指令卡和其它唤醒体的指令卡各生效 2 次。"
  },
  Skill_66357_AwakerSkillBackgroundStory = {
    Text = "那是空洞，无限时空中唯一的、狭小的孔隙。\n那个名为「守密人」的存在，是解答一切问题的答案，是开启一切门扉的钥匙。\n塔薇振响六翼，扑向那唯一的唯一。"
  },
  Skill_66357_Desc_0 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。将<DerivativeCardKeywords_75:「双翼初张」>洗入抽牌堆。"
  },
  Skill_66357_Desc_1 = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>和 1 张<DerivativeCardKeywords_4:「灵感」>。将<DerivativeCardKeywords_75:「双翼初张」>洗入抽牌堆。"
  },
  Skill_66357_EffectNameList = {Text = "力量"},
  Skill_66357_Name = {
    Text = "纵贯时序之翼"
  },
  Skill_66357_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_66402_Desc = {
    Text = "选择一名唤醒体获得 <Energy:[Energy:Arg1]> 点狂气。"
  },
  Skill_66402_Name = {
    Text = "天真的回礼"
  },
  Skill_66403_Desc = {
    Text = "选择抽牌堆或弃牌堆 1 张卡置入手中，使其算力消耗变为 0。"
  },
  Skill_66403_Name = {
    Text = "极夜微光"
  },
  Skill_66404_Desc = {
    Text = "弃掉所有手牌并抽弃掉数量 +3 的卡牌。"
  },
  Skill_66404_Name = {
    Text = "畸变之心"
  },
  Skill_66405_Desc = {
    Text = "对最后排的敌人造成目标最大生命 [Arg1]% 的<FixedDamage:纯粹伤害>，该伤害不会低于自身最大生命的 300%。"
  },
  Skill_66405_Name = {
    Text = "代行者之裁"
  },
  Skill_66406_Desc = {
    Text = "获得 1 层临时<ParcloseIconKeywords:屏障>。"
  },
  Skill_66406_Name = {
    Text = "蜂蜜甜酒"
  },
  Skill_66407_Desc = {
    Text = "查看 3 个钥令并选择 1 个立即释放。"
  },
  Skill_66407_Name = {
    Text = "乌托邦帷幕"
  },
  Skill_66444_Desc_1 = {
    Text = "选择一名唤醒体，将其生命还原至上回合开始时，并使其获得<PVPWeaknessKeywords:虚弱>和<PVPVulnerabilityIconKeywords:易伤>。"
  },
  Skill_66444_Name_1 = {
    Text = "超脱与回溯"
  },
  Skill_66445_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_66445_Name_1 = {Text = "打击"},
  Skill_66446_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害和 [Arg2] <PVPfengsuoKeywords:爆发封锁>。"
  },
  Skill_66446_Name_1 = {
    Text = "万物归一"
  },
  Skill_66448_Desc_1 = {
    Text = "给予全体友方 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_66448_Name_1 = {
    Text = "隐于时隙"
  },
  Skill_66449_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：给予一名友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_66449_Name_1 = {
    Text = "全一传承"
  },
  Skill_66458_Desc = {
    Text = "当前生命和护盾回到上回合结束时的状态。"
  },
  Skill_66458_Name = {
    Text = "过往回声"
  },
  Skill_66498_BattleDesc_1 = {
    Text = "选择一名友方，使其复制 [Arg1] 张敌方手中算力消耗最高的技能卡，并使其算力消耗 -[Arg2] 。对方手中目前有 [Arg3] 张技能。"
  },
  Skill_66498_Desc_1 = {
    Text = "选择一名友方，使其复制 [Arg1] 张敌方手中算力消耗最高的技能卡，并使其算力消耗 -[Arg2] 。"
  },
  Skill_66498_Name_1 = {
    Text = "门扉的答案"
  },
  Skill_66498_UnknownName = {
    Text = "门扉的答案"
  },
  Skill_66499_Desc = {
    Text = "<FaxianKeywords:发现> 3 个随机的钥令，选择其中 1 个触发其效果并获得 <Posse:[Arg1]> 点银钥能量。"
  },
  Skill_66499_Name = {
    Text = "门扉的答案"
  },
  Skill_66520_Desc = {
    Text = "「<Qunxingzhijiu:群星之酒>」"
  },
  Skill_66520_Name = {
    Text = "群星之酒"
  },
  Skill_66525_Desc = {
    Text = "「<Zhanxindeqianbao:崭新的钱包>」"
  },
  Skill_66525_Name = {
    Text = "崭新的钱包"
  },
  Skill_66526_Desc = {
    Text = "「<Wushangrongchong:无上荣宠>」"
  },
  Skill_66526_Name = {
    Text = "无上荣宠"
  },
  Skill_66527_Desc = {
    Text = "「<Canquemiankong:残缺面孔>」"
  },
  Skill_66527_Name = {
    Text = "残缺面孔"
  },
  Skill_66528_Desc = {
    Text = "「<Xingdaozhihai:行道之骸>」"
  },
  Skill_66528_Name = {
    Text = "行道之骸"
  },
  Skill_66529_Desc = {
    Text = "「<Chunzhiji:春之祭>」"
  },
  Skill_66529_Name = {Text = "春之祭"},
  Skill_66530_Desc = {
    Text = "「<Huoxingzhusheqi:活性注射器>」"
  },
  Skill_66530_Name = {
    Text = "活性注射器"
  },
  Skill_66531_Desc = {
    Text = "「<Jingmijishiqi:精密计时器>」"
  },
  Skill_66531_Name = {
    Text = "精密计时器"
  },
  Skill_66532_Desc = {
    Text = "「<Huaibiaojing:怀表镜β>」"
  },
  Skill_66532_Name = {
    Text = "怀表镜β"
  },
  Skill_66533_Desc = {
    Text = "「<Shiluozhimei:失落之美>」"
  },
  Skill_66533_Name = {
    Text = "失落之美"
  },
  Skill_66534_Desc = {
    Text = "「<Tongxunshebei:通讯设备β>」"
  },
  Skill_66534_Name = {
    Text = "通讯设备β"
  },
  Skill_66535_Desc = {
    Text = "「<Etong:恶童>」"
  },
  Skill_66535_Name = {Text = "恶童"},
  Skill_66536_Desc = {
    Text = "「<Biansejushufu:变色拘束服β>」"
  },
  Skill_66536_Name = {
    Text = "变色拘束服β"
  },
  Skill_66537_Desc = {
    Text = "「<Renyuleizhu:人鱼泪珠>」"
  },
  Skill_66537_Name = {
    Text = "人鱼泪珠"
  },
  Skill_66538_Desc = {
    Text = "「<Kuailechangpian:快乐唱片>」"
  },
  Skill_66538_Name = {
    Text = "快乐唱片"
  },
  Skill_66721_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [Arg1] 层<PVPProtectiveKeywords:屏障>，否则获得<StrengthenKeywords:强化>。"
  },
  Skill_66721_Name_1 = {
    Text = "隐世的转轮"
  },
  Skill_66891_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方唤醒体死亡后，获得 <Block:[Block:Arg1]> 护盾，将其算力消耗最低的「技能」置入手中。"
  },
  Skill_66891_Name_1 = {
    Text = "纯银的初心"
  },
  Skill_67110_Desc = {
    Text = "在这苍白的笛声中，再度安睡吧…"
  },
  Skill_67110_Name = {
    Text = "永恒的安眠"
  },
  Skill_67168_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，施加 2 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_67168_Name = {
    Text = "重创奔袭"
  },
  Skill_67169_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。自身生命上限+[Arg3]％，玩家生命上限-[Arg3]％。"
  },
  Skill_67169_Name = {
    Text = "等价交换"
  },
  Skill_67170_Desc = {
    Text = "「缸中之脑分体」触发「灵质分离」时，<TouquKeywords:永久偷取> 5% <PowerIconKeywords:力量>。回合结束时，召唤 1 名「缸中之脑分体」。"
  },
  Skill_67170_Name = {
    Text = "灵肉@1分"
  },
  Skill_67171_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Power:Arg2] 点<PowerIconKeywords:力量> ，获得状态「不定壁垒」：消耗算力后获得 <Block:[Block:Arg3]> 点护盾和 3 层临时加固。"
  },
  Skill_67171_Name = {
    Text = "不定壁垒"
  },
  Skill_67172_Desc = {
    Text = "移除所有「终末」，将玩家的生命上限变更为 1。"
  },
  Skill_67172_Name = {
    Text = "虚无终结"
  },
  Skill_67173_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:临时力量>和 <Block:[Block:Arg2]> 点护盾。"
  },
  Skill_67173_Name = {
    Text = "七艺，传承美德"
  },
  Skill_67174_Desc = {
    Text = "回合结束时，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。护盾被击破时，获得的临时<ReinforcePVEKeywords:加固>由 35 层提高至 75 层。"
  },
  Skill_67174_Name = {
    Text = "骑士热诚"
  },
  Skill_67175_Desc = {
    Text = "造成 [Arg1] 点伤害 [Arg2] 次，弃掉玩家保留的卡牌。"
  },
  Skill_67175_Name = {
    Text = "弱点打击"
  },
  Skill_67176_Desc = {
    Text = "从「蹒跚」、「窒息」、「珊瑚赘生」、「亵渎假象」、「狂放」中选择一张加入手中，其余四张置入弃牌堆。"
  },
  Skill_67176_Name = {
    Text = "世界演绎法"
  },
  Skill_67177_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，施加 2 回合<FragileIconKeywords:脆弱>。若护盾被击破，变为「重创奔袭」：不再施加脆弱，改为施加重创。"
  },
  Skill_67177_Name = {
    Text = "盾裂冲击"
  },
  Skill_67178_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次并施加等量<BleedingIconKeywords:出血>。"
  },
  Skill_67178_Name = {
    Text = "终末狂想"
  },
  Skill_67180_Desc = {
    Text = "接下来 [Arg1] 回合内，每回合结束时，召唤一名「缸中之脑分体」。"
  },
  Skill_67180_Name = {Text = "分离"},
  Skill_67181_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害 [Arg2] 次，后续释放的「女王之剑」伤害次数提高 1。"
  },
  Skill_67181_Name = {
    Text = "女王之剑"
  },
  Skill_67182_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> [Arg2] 次并施加等量<BleedingIconKeywords:出血>，施加 1 回合<VulnerabilityIconKeywords:易伤>。若护盾被击破，变为「暴怒之枪」：不再造成穿刺伤害和出血，但伤害次数提高 1。"
  },
  Skill_67182_Name = {
    Text = "「穿刺」之枪"
  },
  Skill_67183_Desc = {
    Text = "造成  <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。"
  },
  Skill_67183_Name = {Text = "打击"},
  Skill_67184_Desc = {
    Text = "抽牌阶段结束后从手中随机展示 3 张指令卡，选择一张赋予「回声」刻印，弃掉其它卡牌。"
  },
  Skill_67184_Name = {
    Text = "第一哲学"
  },
  Skill_67185_Desc = {
    Text = "<WeaknessIconKeywords:虚弱> 2 回合，施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  Skill_67185_Name = {
    Text = "外域手术"
  },
  Skill_67186_Desc = {
    Text = "施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>。回合结束后，其它敌人获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_67186_Name = {
    Text = "宿命坍缩"
  },
  Skill_67187_Desc = {
    Text = "<TouquKeywords:永久偷取> [Arg1] 点<PowerIconKeywords:力量> 并移除 50% <RetaliateIconKeywords:反击>，对 5 张不具有「推演」的卡牌附加「推演」。"
  },
  Skill_67187_Name = {
    Text = "攻势推演"
  },
  Skill_67188_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。打开「深渊之门」，每回合结束时都会补充敌人，最多 2 名。"
  },
  Skill_67188_Name = {
    Text = "终点，真理与深渊之门"
  },
  Skill_67189_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，<VulnerabilityIconKeywords:易伤>自身 1 回合。"
  },
  Skill_67189_Name = {
    Text = "「暴怒」之枪"
  },
  Skill_67190_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虚弱>，获得 [Arg2] 层<ReinforcePVEKeywords:加固>。"
  },
  Skill_67190_Name = {
    Text = "自毁改造"
  },
  Skill_67191_Desc = {
    Text = "回合开始时，获得 1 层「终末」。每当玩家打出卡牌后，获得 [Arg1] 层<ReinforcePVEKeywords:加固>。受到致死伤害后移除该状态并免疫 1 回合伤害，回复 15% 生命并将意图切换为「虚无终结」。"
  },
  Skill_67191_Name = {
    Text = "灵魂瘟疫"
  },
  Skill_67348_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点<PowerIconKeywords:力量>和 1 层「终末」。如果击破了所有其他敌人，意图变为「宿命坍缩」。"
  },
  Skill_67348_Name = {
    Text = "呼唤终末"
  },
  Skill_67349_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点<PowerIconKeywords:力量>和 1 层「终末」。如果击破了所有其他敌人，意图变为「自毁改造」。"
  },
  Skill_67349_Name = {
    Text = "呼唤终末"
  },
  Skill_67383_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。自身生命上限+[Arg3]％，玩家生命上限-[Arg4]％。"
  },
  Skill_67383_Name = {
    Text = "等价交换"
  },
  Skill_67421_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺>伤害 [AttackTimes:Arg2] 次，该伤害无法规避。"
  },
  Skill_67421_Name = {
    Text = "终结……"
  },
  Skill_67431_Desc = {
    Text = "「<Heizhu:黑烛>」"
  },
  Skill_67431_Name = {Text = "黑烛"},
  Skill_67433_Desc = {
    Text = "「<Guishulimao:诡术礼帽>」"
  },
  Skill_67433_Name = {
    Text = "诡术礼帽"
  },
  Skill_67434_Desc = {
    Text = "「<Slbbujie:时灵摆·不洁>」"
  },
  Skill_67434_Name = {
    Text = "时灵摆·不洁"
  },
  Skill_67435_Desc = {
    Text = "「<Slbbumian:时灵摆·不眠>」"
  },
  Skill_67435_Name = {
    Text = "时灵摆·不眠"
  },
  Skill_67436_Desc = {
    Text = "「<Szeyunyishiniao:受祝·厄运仪式鸟>」"
  },
  Skill_67436_Name = {
    Text = "受祝·厄运仪式鸟"
  },
  Skill_67437_Desc = {
    Text = "「<Shishengchangji:失声唱机>」"
  },
  Skill_67437_Name = {
    Text = "失声唱机"
  },
  Skill_67438_Desc = {
    Text = "「<Yishengshoutixiang:医生手提箱>」"
  },
  Skill_67438_Name = {
    Text = "医生手提箱"
  },
  Skill_67441_Desc = {
    Text = "「<Slbyiyong:时灵摆·移涌>」"
  },
  Skill_67441_Name = {
    Text = "时灵摆·移涌"
  },
  Skill_67442_Desc = {
    Text = "「<Szxingdaozhihai:受祝·行道之骸>」"
  },
  Skill_67442_Name = {
    Text = "受祝·行道之骸"
  },
  Skill_67443_Desc = {
    Text = "「<Baiyahui:白鸦喙>」"
  },
  Skill_67443_Name = {Text = "白鸦喙"},
  Skill_67444_Desc = {
    Text = "「<Chansimanao:缠丝玛瑙>」"
  },
  Skill_67444_Name = {
    Text = "缠丝玛瑙"
  },
  Skill_67445_Desc = {
    Text = "「<Meilishunjian:美丽瞬间β>」"
  },
  Skill_67445_Name = {
    Text = "美丽瞬间β"
  },
  Skill_67446_Desc = {
    Text = "「<Yuanxingdianchi:原型电池>」"
  },
  Skill_67446_Name = {
    Text = "原型电池"
  },
  Skill_67447_Desc = {
    Text = "「<Guguaigouzhua:古怪钩爪>」"
  },
  Skill_67447_Name = {
    Text = "古怪钩爪"
  },
  Skill_67448_Desc = {
    Text = "「<Szemengbiaoxiang:受祝·噩梦表象β>」"
  },
  Skill_67448_Name = {
    Text = "受祝·噩梦表象β"
  },
  Skill_67449_Desc = {
    Text = "回复 25% 最大生命，并提高 10% 生命上限。"
  },
  Skill_67449_Name = {
    Text = "朵尔 · 支援"
  },
  Skill_67451_Desc = {
    Text = "「<Chenzhonghuakuang:沉重画框>」"
  },
  Skill_67451_Name = {
    Text = "沉重画框"
  },
  Skill_67453_Desc = {
    Text = "「<Slbyuyi:时灵摆·羽翼>」"
  },
  Skill_67453_Name = {
    Text = "时灵摆·羽翼"
  },
  Skill_67454_Desc = {
    Text = "「<Dingxiangluopan:定向罗盘>」"
  },
  Skill_67454_Name = {
    Text = "定向罗盘"
  },
  Skill_67455_Desc = {
    Text = "「<Szguguaigouzhua:受祝·古怪钩爪>」"
  },
  Skill_67455_Name = {
    Text = "受祝·古怪钩爪"
  },
  Skill_67456_Desc = {
    Text = "「<Szyishimingke:受祝·意识铭刻β>」"
  },
  Skill_67456_Name = {
    Text = "受祝·意识铭刻β"
  },
  Skill_67457_Desc = {
    Text = "「<Jiajisiquanzhang:祭司权杖+>」"
  },
  Skill_67457_Name = {
    Text = "祭司权杖+"
  },
  Skill_67458_Desc = {
    Text = "「<Slbtoushe:时灵摆·投射>」"
  },
  Skill_67458_Name = {
    Text = "时灵摆·投射"
  },
  Skill_67462_Desc = {
    Text = "「<Qunmengzhige:群氓之歌>」"
  },
  Skill_67462_Name = {
    Text = "群氓之歌"
  },
  Skill_67463_Desc = {
    Text = "「<Jiaqunmengzhige:群氓之歌+>」"
  },
  Skill_67463_Name = {
    Text = "群氓之歌+"
  },
  Skill_67464_Desc = {
    Text = "「<Guaishecantui:怪蛇残蜕>」"
  },
  Skill_67464_Name = {
    Text = "怪蛇残蜕"
  },
  Skill_67466_Desc = {
    Text = "「<Aerkanajilu:阿尔卡纳记录>」"
  },
  Skill_67466_Name = {
    Text = "阿尔卡纳记录"
  },
  Skill_67467_Desc = {
    Text = "「<Xiushiliuyedao:锈蚀柳叶刀>」"
  },
  Skill_67467_Name = {
    Text = "锈蚀柳叶刀"
  },
  Skill_67468_Desc = {
    Text = "「<Jiaqunxingzhijiu:群星之酒+>」"
  },
  Skill_67468_Name = {
    Text = "群星之酒+"
  },
  Skill_67469_Desc = {
    Text = "「<Jiariyuelunpan:日月轮盘+>」"
  },
  Skill_67469_Name = {
    Text = "日月轮盘+"
  },
  Skill_67470_Desc = {
    Text = "将 1 张「不竭战意」置入手中，本回合内「打击」算力消耗降低 1。"
  },
  Skill_67470_Name = {
    Text = "萝坦 · 支援"
  },
  Skill_67471_Desc = {
    Text = "「<Guhuofengling:蛊惑风铃>」"
  },
  Skill_67471_Name = {
    Text = "蛊惑风铃"
  },
  Skill_67472_Desc = {
    Text = "「<Shihengdetianping:失衡的天平>」"
  },
  Skill_67472_Name = {
    Text = "失衡的天平"
  },
  Skill_67473_Desc = {
    Text = "「<Szheizhu:受祝·黑烛>」"
  },
  Skill_67473_Name = {
    Text = "受祝·黑烛"
  },
  Skill_67474_Desc = {
    Text = "获得等同于永久力量 50% 的临时力量，获得最大生命 50% 的护盾。"
  },
  Skill_67474_Name = {
    Text = "奥吉尔 · 支援"
  },
  Skill_67475_Desc = {
    Text = "「<Womendejia:我们的家>」"
  },
  Skill_67475_Name = {
    Text = "我们的家"
  },
  Skill_67476_Desc = {
    Text = "「<Eyunyishiniao:厄运仪式鸟>」"
  },
  Skill_67476_Name = {
    Text = "厄运仪式鸟"
  },
  Skill_67477_Desc = {
    Text = "「<Zaixiguangli:在夕光里>」"
  },
  Skill_67477_Name = {
    Text = "在夕光里"
  },
  Skill_67478_Desc = {
    Text = "「<Wwenmingzhiguang:文明之光>」"
  },
  Skill_67478_Name = {
    Text = "文明之光"
  },
  Skill_67479_Desc = {
    Text = "「<Szqisaimanzhiwen:受祝·七鳃鳗之吻>」"
  },
  Skill_67479_Name = {
    Text = "受祝·七鳃鳗之吻"
  },
  Skill_67480_Desc = {
    Text = "「<Jiatuisezhaopian:褪色照片+>」"
  },
  Skill_67480_Name = {
    Text = "褪色照片+"
  },
  Skill_67481_Desc = {
    Text = "「<Jierizhufu:节日祝福>」"
  },
  Skill_67481_Name = {
    Text = "节日祝福"
  },
  Skill_67482_Desc = {
    Text = "「<Slbyan:时灵摆·眼>」"
  },
  Skill_67482_Name = {
    Text = "时灵摆·眼"
  },
  Skill_67483_Desc = {
    Text = "「<Geyushan:鸽羽扇>」"
  },
  Skill_67483_Name = {Text = "鸽羽扇"},
  Skill_67484_Desc = {
    Text = "「<Slbyanhua:时灵摆·衍化>」"
  },
  Skill_67484_Name = {
    Text = "时灵摆·衍化"
  },
  Skill_67486_Desc = {
    Text = "「<Xiaoxiaoqiangbao:小小襁褓>」"
  },
  Skill_67486_Name = {
    Text = "小小襁褓"
  },
  Skill_67488_Desc = {
    Text = "「<Wanxianglingzhimiyi:万象灵知秘仪>」"
  },
  Skill_67488_Name = {
    Text = "万象灵知秘仪"
  },
  Skill_67490_Desc = {
    Text = "「<Slbshuangsheng:时灵摆·双生>」"
  },
  Skill_67490_Name = {
    Text = "时灵摆·双生"
  },
  Skill_67491_Desc = {
    Text = "「<Yixiangyoupiaojia:异乡邮票夹>」"
  },
  Skill_67491_Name = {
    Text = "异乡邮票夹"
  },
  Skill_67493_Desc = {
    Text = "「<Yinbaichaifenji:银白差分机>」"
  },
  Skill_67493_Name = {
    Text = "银白差分机"
  },
  Skill_67494_Desc = {
    Text = "「<Zhongsuo:重锁>」"
  },
  Skill_67494_Name = {Text = "重锁"},
  Skill_67495_Desc = {
    Text = "「<Beiyiwangzhezhixue:被遗忘者之血>」"
  },
  Skill_67495_Name = {
    Text = "被遗忘者之血"
  },
  Skill_67496_Desc = {
    Text = "「<Szchongqunyishi:受祝·虫群意识>」"
  },
  Skill_67496_Name = {
    Text = "受祝·虫群意识"
  },
  Skill_67497_Desc = {
    Text = "「<Qiuzhidushulun:求知读书轮>」"
  },
  Skill_67497_Name = {
    Text = "求知读书轮"
  },
  Skill_67498_Desc = {
    Text = "「<Jiatongxunshebei:通讯设备+β>」"
  },
  Skill_67498_Name = {
    Text = "通讯设备+β"
  },
  Skill_67499_Desc = {
    Text = "选择 1 张抽牌堆或弃牌堆的牌置入手牌，复制一张并使它们算力消耗变为 0。"
  },
  Skill_67499_Name = {
    Text = "拉蒙娜 · 支援"
  },
  Skill_67500_Desc = {
    Text = "「<Jisiquanzhang:祭司权杖>」"
  },
  Skill_67500_Name = {
    Text = "祭司权杖"
  },
  Skill_67501_Desc = {
    Text = "「<Meixueyuanli:美学原理>」"
  },
  Skill_67501_Name = {
    Text = "美学原理"
  },
  Skill_67502_Desc = {
    Text = "「<Riyuelunpan:日月轮盘>」"
  },
  Skill_67502_Name = {
    Text = "日月轮盘"
  },
  Skill_67699_Desc = {
    Text = "「<Misagehuizhang:弥萨格徽章>」"
  },
  Skill_67699_Name = {
    Text = "弥萨格徽章"
  },
  Skill_67700_Desc = {
    Text = "「<Wumingzhishenmiansha:无名之神的面纱>」"
  },
  Skill_67700_Name = {
    Text = "无名之神的面纱"
  },
  Skill_67759_Name = {
    Text = "黄金测试包"
  },
  Skill_67760_Name = {
    Text = "棱彩测试包"
  },
  Skill_67761_Name = {
    Text = "白银测试包"
  },
  Skill_67780_Desc = {
    Text = "自爆。造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。「缸中之脑」回复自身剩余生命 2 倍的生命。"
  },
  Skill_67780_Name = {
    Text = "自毁程序"
  },
  Skill_67855_AwakerSkillBackgroundStory = {
    Text = "这双眼睛已无法正常视物。\n她直面时间与现实的风暴，任由呼啸的混沌切割、搅碎，最后成为她的眼睛。\n属于「拉蒙娜」的又一个痕迹正从她的身上消失，她抓不住流失的自己，正如她未能抓住从指尖流失的生命。"
  },
  Skill_67855_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>。选择 1 张抽牌堆的牌置入手中并使其算力消耗 -1。"
  },
  Skill_67855_EffectNameList = {Text = "力量"},
  Skill_67855_Name = {
    Text = "超越之目"
  },
  Skill_67855_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_67856_AwakerSkillBackgroundStory = {
    Text = "在漫长的孤寂中，她早已忘记了为何而挥剑。\n但她清楚地知道，自己必须挥出这一剑。"
  },
  Skill_67856_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，<PowerIconKeywords:力量>在「命定之剑」上发挥 [Arg2] 倍效果。每次使用钥令时，力量倍率在本场战斗中提高 1 倍。"
  },
  Skill_67856_EffectNameList_0 = {Text = "伤害"},
  Skill_67856_Name = {
    Text = "命定之剑"
  },
  Skill_67856_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,"
  },
  Skill_67868_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_67868_Name = {Text = "刷新"},
  Skill_67869_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_67869_Name = {Text = "刷新"},
  Skill_67870_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_67870_Name = {Text = "刷新"},
  Skill_67871_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_67871_Name = {Text = "刷新"},
  Skill_68550_Desc = {
    Text = "祂很好奇。造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得状态「愤怒」，敌方的力量将持续增长！"
  },
  Skill_68550_Name = {Text = "亵渎"},
  Skill_68551_Desc = {
    Text = "祂看着你。将一张「症状」永久置入你的牌库。"
  },
  Skill_68551_Name = {Text = "凝视"},
  Skill_68552_Desc = {
    Text = "祂在疑惑。造成 <BlindingKeywords:致盲> 2 回合和 [Arg1] 点<BleedingIconKeywords:出血>。"
  },
  Skill_68552_Name = {Text = "侵扰"},
  Skill_68659_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_95:「追忆-乌托邦帷幕」>置入抽牌堆和弃牌堆。"
  },
  Skill_68659_Name = {
    Text = "追忆微光-乌托邦帷幕"
  },
  Skill_68660_Desc = {
    Text = "获得 2 点算力。查看 3 个钥令，选择 1 个立即释放，驱散自身负面状态并回复 25% 已损失生命。"
  },
  Skill_68660_Name = {
    Text = "追忆-乌托邦帷幕"
  },
  Skill_68661_Desc = {
    Text = "从手牌中选择一张非衍生指令卡，其算力消耗在本场战斗中永久降低 1，并将 1 张此卡牌的复制置入手中。"
  },
  Skill_68661_Name = {
    Text = "追忆-未完的蜡像"
  },
  Skill_68662_Desc = {
    Text = "弃掉所有手牌，抽取弃牌数 +3 的卡牌并使它们算力消耗降低 1。"
  },
  Skill_68662_Name = {
    Text = "追忆-畸变之心"
  },
  Skill_68663_Desc = {
    Text = "获得 2 层临时<ParcloseIconKeywords:屏障>。下回合开始时额外抽 3 张牌，获得 3 点算力。"
  },
  Skill_68663_Name = {
    Text = "追忆-蜂蜜甜酒"
  },
  Skill_68664_Desc = {
    Text = "选择 1 张非衍生指令卡，将其 10 张原始复制洗入抽牌堆。这些卡牌直到下次打出前，算力消耗降低 2。"
  },
  Skill_68664_Name = {
    Text = "追忆-丰穰之核"
  },
  Skill_68665_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_91:「追忆-未完的蜡像」>置入抽牌堆和弃牌堆。"
  },
  Skill_68665_Name = {
    Text = "追忆微光-未完的蜡像"
  },
  Skill_68666_Desc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气，可使用 3 次(当前已使用 [Arg2] 次)。"
  },
  Skill_68666_Name = {
    Text = "追忆-天真的回礼"
  },
  Skill_68667_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_90:「追忆-天真的回礼」>置入抽牌堆和弃牌堆。"
  },
  Skill_68667_Name = {
    Text = "追忆微光-天真的回礼"
  },
  Skill_68668_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_94:「追忆-代行者的裁决」>置入抽牌堆和弃牌堆。"
  },
  Skill_68668_Name = {
    Text = "追忆微光-代行者的裁决"
  },
  Skill_68669_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_96:「追忆-丰穰之核」>置入抽牌堆和弃牌堆。"
  },
  Skill_68669_Name = {
    Text = "追忆微光-丰穰之核"
  },
  Skill_68670_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_92:「追忆-畸变之心」>置入抽牌堆和弃牌堆。"
  },
  Skill_68670_Name = {
    Text = "追忆微光-畸变之心"
  },
  Skill_68671_Desc = {
    Text = "从抽牌堆或弃牌堆中选择 1 张卡牌置入手中，使其算力消耗变为 0。 将 1 张<DerivativeCardKeywords_93:「追忆-蜂蜜甜酒」>置入抽牌堆和弃牌堆。"
  },
  Skill_68671_Name = {
    Text = "追忆微光-蜂蜜甜酒"
  },
  Skill_68672_Desc = {
    Text = "对后排敌人造成最大生命 25% 的<FixedDamage:纯粹伤害>，获得最大生命 25% 的护盾。"
  },
  Skill_68672_Name = {
    Text = "追忆-代行者的裁决"
  },
  Skill_68699_Desc = {
    Text = "祂似乎打算小憩一下。"
  },
  Skill_68699_Name = {Text = "zzZZ…"},
  Skill_68844_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_68844_Name = {
    Text = "原初混沌之核"
  },
  Skill_68873_Desc = {
    Text = "将所有唤醒体的「防御」置入手中，并使它们算力消耗变为 0。"
  },
  Skill_68873_Name = {Text = "躲藏β"},
  Skill_68874_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，并将其他唤醒体的「打击」置入手中，并使它们算力消耗变为 0。"
  },
  Skill_68874_Name = {
    Text = "不竭战意β"
  },
  Skill_68950_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_68950_Name = {
    Text = "原初混沌之种"
  },
  Skill_68951_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_68951_Name = {
    Text = "原初混沌之灵"
  },
  Skill_68952_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_68952_Name = {
    Text = "原初混沌之核"
  },
  Skill_69783_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69783_Name = {
    Text = "原初混沌之核"
  },
  Skill_69784_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69784_Name = {
    Text = "原初混沌之核"
  },
  Skill_69785_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69785_Name = {
    Text = "原初混沌之种"
  },
  Skill_69786_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69786_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69787_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69787_Name = {
    Text = "原初混沌之核"
  },
  Skill_69788_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69788_Name = {
    Text = "原初混沌之种"
  },
  Skill_69789_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69789_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69790_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69790_Name = {
    Text = "原初混沌之种"
  },
  Skill_69791_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69791_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69792_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69792_Name = {
    Text = "原初混沌之核"
  },
  Skill_69793_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69793_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69794_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69794_Name = {
    Text = "原初混沌之核"
  },
  Skill_69795_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69795_Name = {
    Text = "原初混沌之种"
  },
  Skill_69796_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69796_Name = {
    Text = "原初混沌之核"
  },
  Skill_69797_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69797_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69798_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69798_Name = {
    Text = "原初混沌之种"
  },
  Skill_69799_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69799_Name = {
    Text = "原初混沌之灵"
  },
  Skill_69800_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69800_Name = {
    Text = "原初混沌之种"
  },
  Skill_69801_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_69801_Name = {
    Text = "原初混沌之种"
  },
  Skill_69802_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。"
  },
  Skill_69802_Name = {
    Text = "原初混沌之核"
  },
  Skill_69803_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 层<IntoxicationIconKeywords:中毒>和 [Arg4] 层<BleedingIconKeywords:出血>。"
  },
  Skill_69803_Name = {
    Text = "原初混沌之灵"
  },
  Skill_70013_Desc = {
    Text = "消耗 5 点「深渊源能」，选择一名唤醒体，使其获得 [Arg1] 点狂气。回合开始时，所有唤醒体获得 [Arg2] 点狂气，持续至战斗结束。"
  },
  Skill_70013_Name = {Text = "苏醒Ⅱ"},
  Skill_70014_Desc = {
    Text = "消耗 10 点「深渊源能」，将 1 张<DerivativeCardKeywords_60:「王权」>置入手中，所有唤醒体暴击率和暴击伤害提高 25％。"
  },
  Skill_70014_Name = {Text = "苏醒Ⅲ"},
  Skill_70015_Desc = {
    Text = "消耗 1 点「深渊源能」，将 1 张<DerivativeCardKeywords_4:「灵感」>置入手中，获得 [Arg1] 点临时力量和临时触腕伤害。"
  },
  Skill_70015_Name = {Text = "苏醒Ⅰ"},
  Skill_70043_Desc = {
    Text = "祂似乎打算小憩一下。"
  },
  Skill_70043_Name = {Text = "zzZZ…"},
  Skill_70044_Desc = {
    Text = "对后排敌人造成最大生命 15% 的<FixedDamage:纯粹伤害>，获得最大生命 25% 的护盾。"
  },
  Skill_70044_Name = {
    Text = "追忆-代行者的裁决"
  },
  Skill_70142_Desc = {
    Text = "获得 [Arg1] 点护盾，额外积攒 1 点「深渊源能」。"
  },
  Skill_70142_Name = {Text = "沉眠"},
  Skill_70286_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使手牌中装备者所有「技能」造成的伤害、治疗与护盾提高 [Arg1]%。"
  },
  Skill_70286_Name_1 = {
    Text = "青石王座"
  },
  Skill_70299_AwakerSkillBackgroundStory = {
    Text = "她一生追寻的终点，如今摆在近在咫尺的眼前。\n漆黑的大门散发着致命的吸引。\n在推开门之前，她构想了372种真理的可能性。\n在推开门之后，只剩下她不愿承认的第373种。\n没有选择，她只能坠落。\n运气真是差啊，自己和整个世界。"
  },
  Skill_70299_BattleDesc = {
    Text = "其它唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>，临时伤害强效 +[Arg3]％。"
  },
  Skill_70299_Desc = {
    Text = "其它唤醒体获得 <Energy:[Energy:Arg1]> 点狂气，对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>，临时伤害强效 +[Arg3]％。「终末形态」：额外抽 3 张牌，获得 3 点算力，触发所有敌人 50％ 的<IntoxicationIconKeywords:中毒>，「熔毁·朵尔」的基础狂气提高 50 点，至多提高 3 次。"
  },
  Skill_70299_EffectNameList = {
    Text = "狂气,中毒,伤害强效"
  },
  Skill_70299_Name = {
    Text = "终点，真理与深渊之门"
  },
  Skill_70299_OverLimitUtlSkillDesc = {
    Text = "其它唤醒体获得 <Energy:[Energy:Arg4]> 点狂气，对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>，临时伤害强效 +[Arg3]％，所有唤醒体造成的<IntoxicationIconKeywords:中毒>、<RetaliateIconKeywords:反击>、基础伤害提高 10％。若当前为首领战，额外获得 1 层「终末」。"
  },
  Skill_70299_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2,$GrowValue3％"
  },
  Skill_70300_AwakerSkillBackgroundStory = {
    Text = "猩红的孢囊在机械甲壳下膨胀时，黄铜共振器编织出蜂巢状的防御矩阵。\n菌丝脉冲网割裂空间，酸雾蚀刻出警告铭文，而记忆剥离光束正在预热——凡触碰边界的血肉，终将成为培养皿里抽搐的标本。"
  },
  Skill_70300_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_70300_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。「熔毁·朵尔」获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_70300_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_70300_Name = {Text = "防御"},
  Skill_70300_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_70301_AwakerSkillBackgroundStory = {
    Text = "螯足来自她的过去，她的种族，是她未曾舍弃的力量。\n当那双螯足刺穿敌人的胸膛时，绽放的笑意究竟是何含义呢？"
  },
  Skill_70301_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_70301_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。「熔毁·朵尔」获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_70301_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_70301_Name = {Text = "打击"},
  Skill_70301_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_70302_AwakerSkillBackgroundStory = {
    Text = "她献祭了自我，换来触碰真实的资格。\n当她收回手时，她的灵魂已融化如蜡。"
  },
  Skill_70302_BattleDesc_0 = {
    Text = "「熔毁·朵尔」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合结束时，回复 <Heal:[Heal:Arg2]> 点生命并获得 <Energy:[Energy:Arg4]> 点狂气。「终末形态」：不再回复生命，改为触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_BattleDesc_15 = {
    Text = "「熔毁·朵尔」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：每拥有 1 层「终末」伤害强效 +8％。「虚无终结」使所有唤醒体获得 30％ 基础狂气。回合结束时，回复 <Heal:[Heal:Arg2]> 点生命并获得 <Energy:[Energy:Arg4]> 点狂气。「终末形态」：不再回复生命，改为触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_Desc_0 = {
    Text = "「熔毁·朵尔」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合结束时，回复 <Heal:[Heal:Arg2]> 点生命并获得等同于自身狂气回充的狂气。「终末形态」：不再回复生命，改为触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_Desc_15 = {
    Text = "「熔毁·朵尔」获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：每拥有 1 层「终末」伤害强效 +8％。「虚无终结」使所有唤醒体获得 30％ 基础狂气。回合结束时，回复 <Heal:[Heal:Arg2]> 点生命并获得等同于自身狂气回充的狂气。「终末形态」：不再回复生命，改为触发所有敌人 [Arg3]％ 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_70302_EffectNameList = {
    Text = "狂气,回复,触发中毒比例"
  },
  Skill_70302_Name = {
    Text = "灵魂瘟疫"
  },
  Skill_70302_PropertyNameList = {
    Text = "$GrowValue1,体质*GrowValue2,$GrowValue3％,"
  },
  Skill_70303_AwakerSkillBackgroundStory = {
    Text = "如果我们一直走在湮灭的单向道上，那么走得快一些是否是一种仁慈。\n当末日一瞬间发生，痛苦也将凝结在一瞬。\n人们只需与爱的人拥抱，然后共同迎接寂灭的虚无。\n若终点不再有痛苦，是否也算到达天堂？"
  },
  Skill_70303_BattleDesc_0 = {
    Text = "对所有敌人造成其最大生命 25％ 的<FixedDamage:纯粹伤害>(最低为[Arg2])，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  Skill_70303_BattleDesc_3 = {
    Text = "对所有敌人造成其最大生命 30％ 的<FixedDamage:纯粹伤害>(最低为[Arg2])，恢复 30％ 已损生命( <Heal:[Heal:Arg3]> )使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  Skill_70303_Desc_0 = {
    Text = "对所有敌人造成其最大生命 25％ 的<FixedDamage:纯粹伤害>，该伤害不会低于自身最大生命的 [Arg1]％，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。「虚无终结」的效果仅生效 1 次。"
  },
  Skill_70303_Desc_3 = {
    Text = "对所有敌人造成其最大生命 30％ 的<FixedDamage:纯粹伤害>，该伤害不会低于自身最大生命的 [Arg1]％，恢复 30％ 已损生命。使用后「熔毁·朵尔」的特定技能变更为「终末形态」。「虚无终结」的效果仅生效 1 次。"
  },
  Skill_70303_Name = {
    Text = "虚无终结"
  },
  Skill_70303_tempBattleDesc_1 = {
    Text = "对所有敌人造成其最大生命 25％ 的<FixedDamage:纯粹伤害>(最低为[Arg2])，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  Skill_70303_tempBattleDesc_2 = {
    Text = "对所有敌人造成其最大生命 30％ 的<FixedDamage:纯粹伤害>(最低为[Arg2])，恢复 30％ 已损生命( <Heal:[Heal:Arg3]> )使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  Skill_70303_tempBattleDesc_3 = {
    Text = "对所有敌人造成其最大生命 30％ 的<FixedDamage:纯粹伤害>(最低为[Arg2])，恢复 30％ 已损生命( <Heal:[Heal:Arg3]> )使用后「熔毁·朵尔」的特定技能变更为「终末形态」。所有唤醒体获得 30％ 基础狂气。"
  },
  Skill_70304_AwakerSkillBackgroundStory = {
    Text = "人偶的双手灵巧非常，灵魂的核心在她手中如同乖巧的魔方。\n善良的天才非常愿意为你进行免费改造，只是改造后的副作用稍显夸张。"
  },
  Skill_70304_Desc = {
    Text = "<DerivativeCardKeywords_103:选择>「兴奋」或「诅咒」。"
  },
  Skill_70304_EffectNameList = {
    Text = "兴奋强效提高,诅咒力量降低"
  },
  Skill_70304_Name = {
    Text = "自毁改造"
  },
  Skill_70304_PropertyNameList = {
    Text = "$GrowValue1％,防御力*GrowValue2"
  },
  Skill_70305_AwakerSkillBackgroundStory = {
    Text = "蝼蚁对大厦运行原理的猜想，一直愚蠢而可笑。\n所有的理想与信念霎时坍塌倒退，回忆与温情化为奇点外的虚影。\n在宇宙诞生的原点，那里空无一物。"
  },
  Skill_70305_Desc = {
    Text = "<DerivativeCardKeywords_104:获得> <Energy:[Energy:Arg1]> 点狂气。回复 <Heal:[Heal:Arg2]> 点生命，自身当前每拥有 50 点狂气，额外回复 1 次生命。"
  },
  Skill_70305_EffectNameList = {
    Text = "狂气,回复,中毒"
  },
  Skill_70305_Name = {
    Text = "宿命坍缩"
  },
  Skill_70305_PropertyNameList = {
    Text = "$GrowValue1,体质*GrowValue2,攻击力*GrowValue3"
  },
  Skill_70332_Desc_0 = {
    Text = "使所有敌人临时降低 [Exhaustion:Arg2] 点<PowerIconKeywords:力量> 。"
  },
  Skill_70332_Desc_1 = {
    Text = "对所有敌人施加 [Arg1] 回合 <WeaknessIconKeywords:虚弱>，并使它们临时降低 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_70332_Name = {Text = "诅咒"},
  Skill_70333_Desc_0 = {
    Text = "获得 1 回合「兴奋」状态：伤害强效 +[Arg2]％。"
  },
  Skill_70333_Desc_1 = {
    Text = "获得 1 回合「兴奋」状态：伤害强效 +[Arg2]％。对所有敌人施加 [Arg1] 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_70333_Name = {Text = "兴奋"},
  Skill_70355_Desc_1 = {
    Text = "给予全体友方 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_70355_Name_1 = {
    Text = "肾上腺素"
  },
  Skill_70356_Desc_1 = {
    Text = "抽 [Arg1] 张牌。"
  },
  Skill_70356_Name_1 = {Text = "奇袭"},
  Skill_70357_Desc_1 = {
    Text = "获得 [Arg1] 算力。"
  },
  Skill_70357_Name_1 = {Text = "推算"},
  Skill_70358_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命，或对一名敌方造成 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_70358_Name_1 = {
    Text = "液化虚无"
  },
  Skill_70359_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备者每回合前 [Arg1] 次受到攻击时，对攻击者造成<PVPEmptinessKeywords:空虚>。"
  },
  Skill_70359_Name_1 = {
    Text = "坠入虚无的人偶"
  },
  Skill_70360_Desc_1 = {
    Text = "回复全体友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_70360_Name_1 = {
    Text = "拯救计划"
  },
  Skill_70361_Desc_1 = {
    Text = "给予全体友方 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_70361_Name_1 = {
    Text = "伤害抗体"
  },
  Skill_70362_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_70362_Name_1 = {
    Text = "毁灭计划"
  },
  Skill_70376_Desc = {
    Text = "失去 [Arg1] 点钥能，选择一张「灵知觉醒」置入手中。（每获得 1 张灵知觉醒使消耗提高 100%，消耗后钥能可为负值）"
  },
  Skill_70376_Name = {
    Text = "银钥觉醒"
  },
  Skill_70383_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_70383_Name = {Text = "刷新"},
  Skill_70384_Desc = {
    Text = "重新发现 1 次同品质造物，每场战斗共享 1 次刷新机会。"
  },
  Skill_70384_Name = {Text = "刷新"},
  Skill_70825_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气。消耗所有「星辰庇佑」并获得与消耗层数相同的算力，若当前界域为「深海」，额外生成与消耗层数相同的临时触腕。"
  },
  Skill_70825_Name = {Text = "苏醒"},
  Skill_70826_Desc = {
    Text = "获得 <Block:[Arg1]> 点护盾，获得 1 层「星辰庇佑」，最大积攒 5 层，战斗结束后不清除。"
  },
  Skill_70826_Name = {Text = "沉眠"},
  Skill_70827_Desc = {
    Text = "选择一名唤醒体，使其指令卡暴击率和暴击伤害临时提高 [Arg1]% 并获得 [Arg2] 点狂气。若莉兹在队伍中，还会将 1 张附加「消耗」的「腐化绿炎」置入手中。"
  },
  Skill_70827_Name = {
    Text = "黑天鹅的舞步"
  },
  Skill_70828_Desc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气，对所有敌人施加 [Arg2] 层<IntoxicationIconKeywords:中毒>，目标每损失 1％ 生命额外触发 1％ 中毒，至多触发 50％中毒。"
  },
  Skill_70828_Name = {
    Text = "虚无瘟疫"
  },
  Skill_70829_Desc = {
    Text = "选择「<DerivativeCardKeywords_99:沉眠>」或「<DerivativeCardKeywords_100:苏醒>」。"
  },
  Skill_70829_Name = {
    Text = "群星的庇佑"
  },
  Skill_70961_Desc = {
    Text = "从 2 个黄金+造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70961_Name = {Text = "刷新"},
  Skill_70962_Desc = {
    Text = "从 2 个白银造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70962_Name = {Text = "刷新"},
  Skill_70963_Desc = {
    Text = "从 2 个时灵摆造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70963_Name = {Text = "刷新"},
  Skill_70964_Desc = {
    Text = "从 2 个受祝造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70964_Name = {Text = "刷新"},
  Skill_70965_Desc = {
    Text = "从 2 个诅咒造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70965_Name = {Text = "刷新"},
  Skill_70966_Desc = {
    Text = "从 2 个黄金造物中选择 1 个获得，每场战斗共享 1 次刷新机会。"
  },
  Skill_70966_Name = {Text = "刷新"},
  Skill_70994_Desc = {
    Text = "10层终末"
  },
  Skill_71522_Desc = {
    Text = "生命上限降低 10％，同时触发「兴奋」和「诅咒」效果。"
  },
  Skill_71522_Name = {
    Text = "自毁改造·终末"
  },
  Skill_71523_Desc = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。对所有敌人施加 [Poison:Arg2] 层<IntoxicationIconKeywords:中毒>。自身当前每拥有 50 点狂气，额外施加 1 次中毒。"
  },
  Skill_71523_Name = {
    Text = "宿命坍缩·终末"
  },
  Skill_71636_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，将 1 张 <DerivativeCardKeywords_105:「无尽银芯宝库」>置入手牌堆中。"
  },
  Skill_71636_Name = {
    Text = "抛洒银芯"
  },
  Skill_71637_Desc = {
    Text = "似乎被关禁闭了，无法行动。"
  },
  Skill_71637_Name = {
    Text = "禁闭中…"
  },
  Skill_71638_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。对双方均施加 [Arg3] 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_71638_Name = {Text = "猫猫拳"},
  Skill_71639_Desc = {
    Text = "获得 [Arg1] 点临时<PowerIconKeywords:力量>和 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_71639_Name = {Text = "磨磨爪"},
  Skill_71652_Desc = {
    Text = "感受银芯的力量！呼唤当前界域的三名唤醒体，从中选择 1 个获得其支援卡牌。"
  },
  Skill_71652_Name = {
    Text = "无尽银芯宝库"
  },
  Skill_71691_BattleDesc = {
    Text = "当前死亡抵抗翻倍，临时降低所有敌人 [Arg1] 点<PowerIconKeywords:力量>，每有 1 名敌人获得 [Arg1] 点<PowerIconKeywords:临时力量>。"
  },
  Skill_71691_Desc = {
    Text = "当前死亡抵抗翻倍，<TouquKeywords:永久偷取>所有敌人 [Arg1] 点力量。"
  },
  Skill_71691_Name = {
    Text = "菲茵特·支援"
  },
  Skill_71692_Desc = {
    Text = "获得等同于触腕伤害 50% 的临时力量，临时移除所有敌人的<PowerIconKeywords:力量>并<VulnerabilityIconKeywords:易伤>三回合，获得等同于移除量的临时<PowerIconKeywords:力量>。"
  },
  Skill_71692_Name = {
    Text = "戈利亚·支援"
  },
  Skill_71693_Desc = {
    Text = "将 3 张上回合最后打出的非衍生指令卡的临时复制置入手中，使它们算力消耗变为 0。"
  },
  Skill_71693_Name = {
    Text = "环行·拉蒙娜·支援"
  },
  Skill_71694_Desc = {
    Text = "下回合开始时获得等同于本回合损失生命的护盾，持续 1 回合。将 3 张「胚胎」置入手中。"
  },
  Skill_71694_Name = {
    Text = "雷娅·支援"
  },
  Skill_71695_Desc = {
    Text = "抽牌直至手牌达到上限。回合结束时每有 1 张手牌在手中，所有唤醒体获得 5 点狂气。"
  },
  Skill_71695_Name = {
    Text = "卡茜亚·支援"
  },
  Skill_71696_Desc = {
    Text = "选择一名唤醒体获得 35 点狂气，回合结束时也会重复 1 次，持续 5 回合。"
  },
  Skill_71696_Name = {
    Text = "温柯尔·支援"
  },
  Skill_71697_Desc = {
    Text = "石化所有敌人 1 回合。若敌人拥有石化抗性，改为对它们造成 25 层易伤。"
  },
  Skill_71697_Name = {
    Text = "艾继丝·支援"
  },
  Skill_71698_Desc = {
    Text = "使随机 5 张手牌算力消耗降低 1 点，并获得最大生命 50% 的护盾。"
  },
  Skill_71698_Name = {
    Text = "汀克特·支援"
  },
  Skill_71699_Desc = {
    Text = "获得 3 点算力。驱散自身负面状态并回复 25% 已损失生命，查看 3 个钥令并选择 1 个立即释放。"
  },
  Skill_71699_Name = {
    Text = "希莱斯特·支援"
  },
  Skill_71700_Desc = {
    Text = "选择一名唤醒体获得 100 点狂气，并使其暴击率和暴击伤害永久提高 25%。"
  },
  Skill_71700_Name = {
    Text = "尤乌哈希·支援"
  },
  Skill_71701_Desc = {
    Text = "立刻获得 [Arg1] 点触腕伤害和 [Arg2] 点临时反击。每次受到攻击后，治疗 [Arg3] 点生命，持续 1 回合。"
  },
  Skill_71701_Name = {
    Text = "凯刻斯·支援"
  },
  Skill_71702_Desc = {
    Text = "获得 35% 临时暴击率、75% 临时暴击伤害，本回合中造成的最终伤害提高 25%。"
  },
  Skill_71702_Name = {
    Text = "詹金·支援"
  },
  Skill_71703_Desc = {
    Text = "立刻生成 3 条触腕，下回合开始时获得 25% 最大生命的护盾。"
  },
  Skill_71703_Name = {
    Text = "珊·支援"
  },
  Skill_71704_Desc = {
    Text = "选择一名唤醒体，丢弃其所有指令卡，每丢弃 1 张牌就获得 [Arg1] 点临时力量，并触发丢弃卡牌的所有效果。"
  },
  Skill_71704_Name = {
    Text = "莉兹·支援"
  },
  Skill_71705_Desc = {
    Text = "选择一名唤醒体，抽 3 张该唤醒体的指令卡并使它们算力消耗降低 1。该唤醒体每造成 1 次伤害就使 1 条触腕攻击 1 次，持续 1 回合。"
  },
  Skill_71705_Name = {
    Text = "奥瑞塔·支援"
  },
  Skill_71706_Desc = {
    Text = "「打击」最终伤害提高 100%，每次进行「吞噬」，都会抽 2 张「打击」并使它们算力消耗降低 1，持续 1 回合。"
  },
  Skill_71706_Name = {
    Text = "希洛·支援"
  },
  Skill_71834_Desc_1 = {
    Text = "选择一名敌方，对其造成 <WeaknessIconKeywords:虚弱> 、 <PVPVulnerabilityIconKeywords:易伤>和 1 层<PVPSlowKeywords:迟缓>。"
  },
  Skill_71834_Name_1 = {
    Text = "虚无瘟疫"
  },
  Skill_71834_UnknownName = {
    Text = "虚无瘟疫"
  },
  Skill_71835_Desc_1 = {
    Text = "使一名目标获得 <DelayKeywords:延迟 1>：<PVPVulnerabilityIconKeywords:易伤>。"
  },
  Skill_71835_Name_1 = {
    Text = "延迟易伤"
  },
  Skill_71836_Desc_1 = {
    Text = "弃掉对方算力最高的 [Arg1] 张「技能卡」，并使其获得等量<PVPDerivativeCardKeywords_2:「幻象」>。"
  },
  Skill_71836_Name_1 = {
    Text = "群星的庇佑"
  },
  Skill_71836_UnknownName = {
    Text = "群星的庇佑"
  },
  Skill_71904_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_71904_Name_1 = {Text = "打击"},
  Skill_71905_Desc_1 = {
    Text = "迫使对手抽 [Arg1] 张牌，对全体敌方造成 <Damage:[Damage:Arg2]> <PVPBleedingKeywords:出血>。"
  },
  Skill_71905_Name_1 = {
    Text = "癫狂催化"
  },
  Skill_71906_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，迫使对手弃掉目标的所有手牌以及手中所有命轮卡和钥令卡，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_71906_Name_1 = {
    Text = "生命重构治疗"
  },
  Skill_71907_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，迫使对手弃掉目标的所有手牌。"
  },
  Skill_71907_Name_1 = {
    Text = "心理绞杀"
  },
  Skill_71908_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害，目标每有 1 张手牌对其额外造成 [Arg2] 次伤害。"
  },
  Skill_71908_Name_1 = {
    Text = "多重投射"
  },
  Skill_72025_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_72025_Name = {Text = "猫拳"},
  Skill_72107_Desc = {
    Text = "所有敌人在本场战斗中获得 [Power:Arg1] 点<PowerIconKeywords:力量>（无论它们在哪）。召唤 1 名「灰烬融蚀体」。"
  },
  Skill_72107_Name = {
    Text = "银芯交融"
  },
  Skill_72108_Desc = {
    Text = "获得「暗杀者」状态和 2 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_72108_Name = {
    Text = "没入火烬"
  },
  Skill_72110_Desc = {
    Text = "将 1 张「拨号炸弹」洗入牌库，造成 3 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_72110_Name = {Text = "呼唤"},
  Skill_72112_Desc = {
    Text = "召唤 3 个「灰烬融蚀体」和 1 个「紧急联络」，自身死亡。"
  },
  Skill_72112_Name = {
    Text = "连结解除"
  },
  Skill_72113_Desc = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害 [AttackTimes:Arg3] 次。所有敌人在本场战斗中回合结束时获得 <Block:[Block:Arg1]> 点护盾（无论它们在哪）。"
  },
  Skill_72113_Name = {
    Text = "融蚀赘生"
  },
  Skill_72114_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 2 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_72114_Name = {Text = "双螺旋"},
  Skill_72115_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_72115_Desc = {
    Text = "造成 1 次高额伤害。"
  },
  Skill_72115_Name = {
    Text = "物理修复"
  },
  Skill_72116_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 1 回合<BlindingKeywords:致盲>。"
  },
  Skill_72116_Name = {Text = "流逝"},
  Skill_72117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得「暗杀者」状态。"
  },
  Skill_72117_Name = {
    Text = "无火之灰"
  },
  Skill_72118_Desc = {
    Text = "将 1 张「拨号炸弹」洗入牌库，造成 3 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_72118_Name = {Text = "屏蔽"},
  Skill_72119_Desc = {
    Text = "将 1 张「拨号炸弹」洗入抽牌堆，造成 2 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_72119_Name = {Text = "呼唤"},
  Skill_72120_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。后排召唤 1 名「灰烬融蚀体」。"
  },
  Skill_72120_Name = {
    Text = "异体排斥"
  },
  Skill_72122_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。后排召唤 1 名「灰烬融蚀体」。"
  },
  Skill_72122_Name = {
    Text = "异体排斥"
  },
  Skill_72123_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_72123_Name = {Text = "再流逝"},
  Skill_72124_Desc = {
    Text = "所有敌人在本场战斗中获得 [Power:Arg1] 点<PowerIconKeywords:力量>（无论它们在哪）。召唤 1 名「灰烬融蚀体」。"
  },
  Skill_72124_Name = {
    Text = "银芯交融"
  },
  Skill_72125_Desc = {
    Text = "将 1 张「拨号炸弹」洗入抽牌堆，造成 2 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_72125_Name = {Text = "屏蔽"},
  Skill_72177_BattleDesc = {
    Text = "研究要求：释放 2 次钥令。研究成果：所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72177_Desc = {
    Text = "研究要求：释放 3 次钥令。研究成果：所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72177_Name = {
    Text = "银钥匙研究"
  },
  Skill_72178_BattleDesc = {
    Text = "研究要求：释放 5 次狂气爆发。研究成果：选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72178_Desc = {
    Text = "研究要求：释放 6 次狂气爆发。研究成果：选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72178_Name = {
    Text = "狂气研究"
  },
  Skill_72179_BattleDesc = {
    Text = "研究要求：造成 30 次伤害。研究成果：对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72179_Desc = {
    Text = "研究要求：造成 40 次伤害。研究成果：对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72179_Name = {
    Text = "连击研究"
  },
  Skill_72180_BattleDesc = {
    Text = "获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72180_Desc = {
    Text = "获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72180_Name = {Text = "强心针"},
  Skill_72181_BattleDesc = {
    Text = "获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72181_Desc = {
    Text = "获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72181_Name = {
    Text = "爆发式兴奋"
  },
  Skill_72182_BattleDesc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72182_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72182_Name = {
    Text = "来自深渊的癫狂"
  },
  Skill_72183_BattleDesc = {
    Text = "研究要求：造成 10 次护盾或治疗。研究成果：获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72183_Desc = {
    Text = "研究要求：造成 15 次护盾或治疗。研究成果：获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72183_Name = {
    Text = "生存研究"
  },
  Skill_72184_BattleDesc = {
    Text = "研究要求：释放 2 次钥令。研究成果：所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72184_Desc = {
    Text = "研究要求：释放 3 次钥令。研究成果：所有唤醒体获得 [Arg1] 点狂气，每回合结束时额外获得 [Arg2] 狂气。"
  },
  Skill_72184_Name = {
    Text = "银钥匙研究"
  },
  Skill_72185_BattleDesc = {
    Text = "选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72185_Desc = {
    Text = "选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72185_Name = {
    Text = "瓶装虚无"
  },
  Skill_72186_BattleDesc = {
    Text = "研究要求：使用 15 张指令卡。研究成果：获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72186_Desc = {
    Text = "研究要求：使用 20 张指令卡。研究成果：获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72186_Name = {
    Text = "指令仪研究"
  },
  Skill_72187_BattleDesc = {
    Text = "研究要求：造成 10 次护盾或治疗。研究成果：获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72187_Desc = {
    Text = "研究要求：造成 15 次护盾或治疗。研究成果：获得 [Arg1] 点算力，抽 [Arg1] 张牌。算力上限和抽牌数 + [Arg2]。"
  },
  Skill_72187_Name = {
    Text = "生存研究"
  },
  Skill_72188_BattleDesc = {
    Text = "研究要求：使用 15 张指令卡。研究成果：获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72188_Desc = {
    Text = "研究要求：使用 20 张指令卡。研究成果：获得 100% 伤害强效和 15% 暴击率，本回合内效果翻倍。"
  },
  Skill_72188_Name = {
    Text = "指令仪研究"
  },
  Skill_72189_BattleDesc = {
    Text = "对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72189_Desc = {
    Text = "对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72189_Name = {
    Text = "衰弱瘟疫"
  },
  Skill_72190_BattleDesc = {
    Text = "研究要求：释放 5 次狂气爆发。研究成果：选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72190_Desc = {
    Text = "研究要求：释放 6 次狂气爆发。研究成果：选择手中的 3 张指令卡赋予「合奏」刻印。"
  },
  Skill_72190_Name = {
    Text = "狂气研究"
  },
  Skill_72191_BattleDesc = {
    Text = "研究要求：造成 30 次伤害。研究成果：对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72191_Desc = {
    Text = "研究要求：造成 40 次伤害。研究成果：对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，使他们失去 [Arg2] 点<ExhaustionIconKeywords:力量>。"
  },
  Skill_72191_Name = {
    Text = "连击研究"
  },
  Skill_72827_BattleDesc = {
    Text = "对所有敌人造成其最大生命 [Arg1]％ 的<FixedDamage:纯粹伤害>(最低为[Arg3])。"
  },
  Skill_72827_Desc = {
    Text = "对所有敌人造成其最大生命 [Arg1]％ 的<FixedDamage:纯粹伤害>，该伤害不会低于自身最大生命的 [Arg2]％。"
  },
  Skill_72827_Name = {
    Text = "虚无终结"
  },
  Skill_73475_Desc = {
    Text = "将 1 张「狂放」洗入抽牌堆。"
  },
  Skill_73475_Name = {Text = "狂宴"},
  Skill_73476_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Power:Arg3] 点<PowerIconKeywords:力量>。打出觉醒卡后意图更改为「心理绞杀」。"
  },
  Skill_73476_Name = {
    Text = "痛苦榨取"
  },
  Skill_73477_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身死亡。"
  },
  Skill_73477_Name = {Text = "自毁"},
  Skill_73482_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>。移除自身一半层数的<MadnessIconKeywords:疯狂>和<PowerIconKeywords:力量>，回复已损失生命的 10%。"
  },
  Skill_73482_Name = {
    Text = "精神抚慰"
  },
  Skill_73484_Desc = {
    Text = "在手中时，打出算力消耗为 3 的卡牌后，受到 [Arg1] 点<FixedDamage:纯粹伤害>，变形为 1 张算力消耗为 1 或 2 的「拨号炸弹」。打出后抽等同于算力消耗的牌。"
  },
  Skill_73484_Name = {
    Text = "拨号炸弹"
  },
  Skill_73485_Desc = {
    Text = "在手中时，打出算力消耗为 2 的卡牌后，受到 [Arg1] 点<FixedDamage:纯粹伤害>，变形为 1 张算力消耗为 1 或 3 的「拨号炸弹」。打出后抽等同于算力消耗的牌。"
  },
  Skill_73485_Name = {
    Text = "拨号炸弹"
  },
  Skill_73486_Desc = {
    Text = "在手中时，打出算力消耗为 1 的卡牌后，受到 [Arg1] 点<FixedDamage:纯粹伤害>，变形为 1 张算力消耗为 2 或 3 的「拨号炸弹」。打出后抽等同于算力消耗的牌。"
  },
  Skill_73486_Name = {
    Text = "拨号炸弹"
  },
  Skill_73525_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 2 回合<BlindingKeywords:致盲>。"
  },
  Skill_73526_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，自身获得 [Arg2] 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_73527_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 1 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_73528_Desc = {
    Text = "召唤两个「不会吧…」，全体友方获得 3 层<ParcloseIconKeywords:屏障>。"
  },
  Skill_73536_Desc = {
    Text = "从已解锁的 3 个随机钥令中选择 1 个立刻释放。"
  },
  Skill_73536_Name = {
    Text = "银钥微光"
  },
  Skill_74028_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 3 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_74028_Name = {Text = "双螺旋"},
  Skill_74029_Desc = {
    Text = "所有敌人在本场战斗中永久获得 [Power:Arg1] 点<PowerIconKeywords:力量>（无论它们在哪）。召唤 1 名「紧急联络」和 1 名「灰烬融蚀体」。"
  },
  Skill_74029_Name = {
    Text = "永恒共生"
  },
  Skill_74030_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_74030_Desc = {
    Text = "造成 1 次高额伤害。"
  },
  Skill_74030_Name = {
    Text = "物理修复"
  },
  Skill_74036_Desc = {
    Text = "回合开始时，随机对 2 张没有「认知错乱」的指令施加「认知错乱」。"
  },
  Skill_74036_Name = {
    Text = "灵智催眠"
  },
  Skill_74037_Desc = {
    Text = "回合开始时，随机对 2 张没有「认知错乱」的指令施加「认知错乱」。"
  },
  Skill_74037_Name = {
    Text = "灵智催眠"
  },
  Skill_74038_Desc = {
    Text = "回合开始时，随机对 2 张没有「认知错乱」的指令施加「认知错乱」。"
  },
  Skill_74038_Name = {
    Text = "灵智催眠"
  },
  Skill_74039_Desc = {
    Text = "回合开始时，随机对 2 张没有「认知错乱」的指令施加「认知错乱」。"
  },
  Skill_74040_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。清空保留的手牌，将 3 张「灵感」和 3 种不同算力的「拨号炸弹」置入手中。"
  },
  Skill_74040_Name = {Text = "触达"},
  Skill_74042_Desc = {
    Text = "打出非消耗指令卡时若「备用脑缸」中无该卡牌，将其 [Arg1] 张消耗复制填入「备用脑缸」，每回合最多生效 1 次。打出后将最多 3 张「备用脑缸」中的牌置入手中。"
  },
  Skill_74042_Name = {
    Text = "备用脑缸"
  },
  Skill_74083_Desc = {
    Text = "所有唤醒体获得 <Energy:[Arg1]> 点狂气，虚弱和易伤所有敌人 2 回合。"
  },
  Skill_74083_Name = {
    Text = "狂乱熔毁"
  },
  Skill_74300_Desc = {
    Text = "回合结束后，若自身存活，玩家探索失败。该意图无法被切换。"
  },
  Skill_74300_Name = {
    Text = "终结……"
  },
  Skill_74792_Desc = {
    Text = "将银钥能量和所有唤醒体的狂气填充至最大值。"
  },
  Skill_74792_Name = {
    Text = "光锥界限"
  },
  Skill_74819_BattleDesc = {
    Text = "本回合所有唤醒体暴击和暴击伤害提高 [Arg1]%"
  },
  Skill_74819_Desc = {
    Text = "本回合所有唤醒体暴击和暴击伤害提高 [Arg1]%"
  },
  Skill_74819_Name = {
    Text = "交易完成"
  },
  Skill_74820_BattleDesc = {
    Text = "对全体敌方造成 [Arg1] 点中毒"
  },
  Skill_74820_Desc = {
    Text = "对全体敌方造成 [Arg1] 点中毒"
  },
  Skill_74820_Name = {
    Text = "原质的污染"
  },
  Skill_74821_BattleDesc = {
    Text = "随机造成 [Arg1] 点伤害 [Arg2] 次（该伤害受到1倍力量加成）"
  },
  Skill_74821_Desc = {
    Text = "随机造成 [Arg1] 点伤害 [Arg2] 次（该伤害受到1倍力量加成）"
  },
  Skill_74821_Name = {
    Text = "以物易物"
  },
  Skill_74822_BattleDesc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74822_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74822_Name = {
    Text = "请尽情挑选"
  },
  Skill_74823_BattleDesc = {
    Text = "对全体敌方造成已损失生命  [Arg1]% 的伤害"
  },
  Skill_74823_Desc = {
    Text = "对全体敌方造成已损失生命  [Arg1]% 的伤害"
  },
  Skill_74823_Name = {
    Text = "跨越维度的低喃"
  },
  Skill_74824_BattleDesc = {
    Text = "获得 [Arg1] 点力量"
  },
  Skill_74824_Desc = {
    Text = "获得 [Arg1] 点力量"
  },
  Skill_74824_Name = {
    Text = "欣赏头颅藏品"
  },
  Skill_74834_Name = {
    Text = "禁忌的交易"
  },
  Skill_74893_BattleDesc = {
    Text = "获得 [Arg1] 点护盾"
  },
  Skill_74893_Desc = {
    Text = "获得 [Arg1] 点护盾"
  },
  Skill_74893_Name = {
    Text = "万千门扉的守护"
  },
  Skill_74894_BattleDesc = {
    Text = "获得 [Arg1] 点死亡抵抗"
  },
  Skill_74894_Desc = {
    Text = "获得 [Arg1] 点死亡抵抗"
  },
  Skill_74894_Name = {
    Text = "死亡亦可被贩售"
  },
  Skill_74895_BattleDesc = {
    Text = "获得 [Arg1] 点算力"
  },
  Skill_74895_Desc = {
    Text = "获得 [Arg1] 点算力"
  },
  Skill_74895_Name = {
    Text = "新的藏品已入库"
  },
  Skill_74896_BattleDesc = {
    Text = "随机造成 [Arg1] 点伤害 [Arg2] 次（该伤害受到1倍力量加成）"
  },
  Skill_74896_Desc = {
    Text = "随机造成 [Arg1] 点伤害 [Arg2] 次（该伤害受到1倍力量加成）"
  },
  Skill_74896_Name = {
    Text = "银货两讫"
  },
  Skill_74897_BattleDesc = {
    Text = "获得 [Arg1] 层反击"
  },
  Skill_74897_Desc = {
    Text = "获得 [Arg1] 层反击"
  },
  Skill_74897_Name = {
    Text = "小店杜绝赊欠"
  },
  Skill_74898_BattleDesc = {
    Text = "临时降低所有敌人 [Arg1] 点<PowerIconKeywords:力量>，每有 1 名敌人获得 [Arg1] 点<PowerIconKeywords:临时力量>。"
  },
  Skill_74898_Desc = {
    Text = "<TouquKeywords:偷取>所有敌人 [Arg1] 点力量"
  },
  Skill_74898_Name = {
    Text = "你的头颅已预订"
  },
  Skill_74899_BattleDesc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74899_Desc = {
    Text = "选择一名唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74899_Name = {
    Text = "您所期待之物"
  },
  Skill_74900_BattleDesc = {
    Text = "获得 [Arg1] 点界域精通"
  },
  Skill_74900_Desc = {
    Text = "获得 [Arg1] 点界域精通"
  },
  Skill_74900_Name = {
    Text = "千年的学识"
  },
  Skill_74901_BattleDesc = {
    Text = "本回合造成的中毒、反击、出血提高 [Arg1]%"
  },
  Skill_74901_Desc = {
    Text = "本回合造成的中毒、反击、出血提高 [Arg1]%"
  },
  Skill_74901_Name = {
    Text = "请勿贪得无厌"
  },
  Skill_74902_BattleDesc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74902_Desc = {
    Text = "所有唤醒体获得 [Arg1] 点狂气"
  },
  Skill_74902_Name = {
    Text = "小店今日打折"
  },
  Skill_74903_BattleDesc = {
    Text = "下 [Arg1] 张打出的指令卡额外获得 [Arg2] 点钥能"
  },
  Skill_74903_Desc = {
    Text = "下 [Arg1] 张打出的指令卡额外获得 [Arg2] 点钥能"
  },
  Skill_74903_Name = {
    Text = "价格好商量"
  },
  Skill_74945_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使狂气最高的敌方失去 [Arg1] 狂气并获得<PVPEmptinessKeywords:空虚>。"
  },
  Skill_74945_Name_1 = {
    Text = "催眠灵摆"
  },
  Skill_74946_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，对<HPAndShieldMin:生命与护盾最低>敌方造成 [Arg1] <PVPCardLockKeywords:卡牌封锁>。装备者造成击杀后，立刻触发一次该效果。"
  },
  Skill_74946_Name_1 = {
    Text = "魔女宽檐帽"
  },
  Skill_76443_Desc = {
    Text = "添加10000中毒"
  },
  Skill_76443_Name = {
    Text = "添加10000中毒"
  },
  Skill_76444_Desc = {
    Text = "添加10000反击"
  },
  Skill_76444_Name = {
    Text = "添加10000反击"
  },
  Skill_76532_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合结束时，赋予对手的随机 [Arg1] 张手牌 [Arg2] 层<PVPAcheKeywords:隐没的痛楚>。"
  },
  Skill_76532_Name_1 = {
    Text = "隐没的痛楚"
  },
  Skill_77673_Desc = {
    Text = "将 1 张<DerivativeCardKeywords_133:「莉雅的硬币」>置入弃牌堆。"
  },
  Skill_77673_Name = {
    Text = "酒馆之门"
  },
  Skill_77678_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 2 层「终末」。"
  },
  Skill_77678_Name = {
    Text = "机械脉冲"
  },
  Skill_77680_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，为随机三张卡牌添加「认知错乱」，并施加 1 回合<WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<VulnerabilityIconKeywords:易伤>、<BlindingKeywords:致盲> 状态。失去 2 层终末。"
  },
  Skill_77680_Name = {
    Text = "意识干扰装置"
  },
  Skill_77681_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 2 层「终末」。"
  },
  Skill_77681_Name = {
    Text = "机械臂挥击"
  },
  Skill_77682_Desc = {
    Text = "关闭深渊之门并移除其他敌人。转化为半机械形态，恢复所有生命并根据当前终末层数获得额外的最大生命和 15 层「融蚀雾盾」。"
  },
  Skill_77682_Name = {
    Text = "机械飞升"
  },
  Skill_77683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Poison:Arg3] 层<IntoxicationIconKeywords:中毒>，将 2 张「融蚀之芯」洗入抽牌堆。失去 3 层「终末」。"
  },
  Skill_77683_Name = {
    Text = "融蚀发酵框体"
  },
  Skill_77684_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。获得 3 层「终末」并打开「深渊之门」，每回合结束时都会补充敌人，最多 2 名。"
  },
  Skill_77684_Name = {
    Text = "终点，真理与深渊之门"
  },
  Skill_77685_Desc = {
    Text = "将玩家生命上限变为 [Arg1] ，失去 3 层「终末」。"
  },
  Skill_77685_Name = {
    Text = "托乎瓦波凝视装置"
  },
  Skill_77714_Desc = {
    Text = "获得 10 层终末，施加 [Arg1] 层<BleedingIconKeywords:出血>。终末，即将降临…！"
  },
  Skill_77714_Name = {
    Text = "系统重启"
  },
  Skill_77846_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点<PowerIconKeywords:力量>。场上每有 1 名其它敌人存活，获得 1 层「终末」。如果击破了所有其他敌人，意图变为「自毁改造」。"
  },
  Skill_77846_Name = {
    Text = "呼唤终末"
  },
  Skill_77847_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 [Power:Arg3] 点<PowerIconKeywords:力量>。场上每有 1 名其它敌人存活，获得 1 层「终末」。如果击破了所有其他敌人，意图变为「宿命坍缩」。"
  },
  Skill_77847_Name = {
    Text = "呼唤终末"
  },
  Skill_77851_Desc = {
    Text = "施加 2 回合<WeaknessIconKeywords:虚弱>，获得 [Arg2] 层<ReinforcePVEKeywords:加固>。"
  },
  Skill_77851_Name = {
    Text = "自毁改造"
  },
  Skill_77852_Desc = {
    Text = "施加 [Poison:Arg1] 层<IntoxicationIconKeywords:中毒>。回合结束后，其它敌人获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_77852_Name = {
    Text = "宿命坍缩"
  },
  Skill_78648_Desc = {
    Text = "所有人最大生命都变成1"
  },
  Skill_78648_Name = {
    Text = "托乎瓦波装置"
  },
  Skill_78782_AwakerSkillBackgroundStory = {
    Text = "摇动的灵摆里，世界开始被抹消。\n你的眼中，你的心里，你的头颅内，只剩下一个身影。\n那是救赎，亦是绝路。"
  },
  Skill_78782_BattleDesc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命 [Arg2] 次，临时移除敌人所有<MadnessIconKeywords:疯狂>状态并使其临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78782_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命，临时移除敌人所有<MadnessIconKeywords:疯狂>状态并使其临时降低 [Exhaustion:Arg3] 点<ExhaustionIconKeywords:力量>。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78782_EffectNameList = {
    Text = "回复,力量降低,力量"
  },
  Skill_78782_Name = {
    Text = "精神抚慰"
  },
  Skill_78782_PropertyNameList = {
    Text = "体质*GrowValue1,防御力*GrowValue2,攻击力*GrowValue3"
  },
  Skill_78783_AwakerSkillBackgroundStory = {
    Text = "她的声音温柔而亲切，在你看不见的心灵暗面，纠缠蔓延。\n一个人无法被自己之外的存在打败，而你自己，就是她的武器。"
  },
  Skill_78783_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，获得 <Energy:[Energy:Arg5]> 点狂气。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78783_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，克莱门汀获得 <Energy:[Energy:Arg3]> 点狂气。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78783_EffectNameList = {
    Text = "伤害,狂气,力量"
  },
  Skill_78783_Name = {Text = "打击"},
  Skill_78783_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_78784_Desc = {
    Text = "每移除自身 1 层「共感」，就对所有敌人施加 1 层「恐惧固着」，每层「恐惧固着」使目标造成的伤害降低 3％。"
  },
  Skill_78784_Name = {
    Text = "转化·恐惧固着"
  },
  Skill_78785_AwakerSkillBackgroundStory = {
    Text = "「请告诉我，真正的你是谁？」\n这么问着，她笑了起来。\n那可怜的患者当然无法回答，因为他的记忆已被篡改，越是追寻，便越会靠近植入记忆里的恐怖存在——直到认知彻底崩溃，变为怪物。"
  },
  Skill_78785_BattleDesc_0 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，选择转化为所有敌人的<D13AFKeyWord2:精神创伤>或<D13AFKeyWord1:恐惧固着>。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次，获得 <Posse:[Arg3]> 点银钥能量。"
  },
  Skill_78785_BattleDesc_2 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，选择转化为所有敌人的<D13AFKeyWord2:精神创伤>或<D13AFKeyWord1:恐惧固着>，每移除 1 层克莱门汀造成的基础伤害提高 3％。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次，获得 <Posse:[Arg3]> 点银钥能量。"
  },
  Skill_78785_BattleDesc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，选择转化为所有敌人的<D13AFKeyWordQ2:精神创伤>或<D13AFKeyWordQ1:恐惧固着>，每移除 1 层克莱门汀造成的基础伤害提高 3％。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次，获得 <Posse:[Arg3]> 点银钥能量。"
  },
  Skill_78785_Desc_0 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，选择转化为所有敌人的<D13AFKeyWord2:精神创伤>或<D13AFKeyWord1:恐惧固着>。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Arg2]％ 克莱门汀银钥充能的银钥能量。"
  },
  Skill_78785_Desc_2 = {
    Text = "移除自身所有<AnalysisKeywords0:共感>，选择转化为所有敌人的<D13AFKeyWord2:精神创伤>或<D13AFKeyWord1:恐惧固着>，每移除 1 层使克莱门汀造成的基础伤害提高 3％。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Arg2]％ 克莱门汀银钥充能的银钥能量。"
  },
  Skill_78785_Desc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，选择转化为所有敌人的<D13AFKeyWordQ2:精神创伤>或<D13AFKeyWordQ1:恐惧固着>，每移除 1 层使克莱门汀造成的基础伤害提高 3％。对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Arg2]％ 克莱门汀银钥充能的银钥能量。"
  },
  Skill_78785_EffectNameList = {
    Text = "伤害,银钥能量"
  },
  Skill_78785_Name = {
    Text = "生命重构治疗"
  },
  Skill_78785_OverLimitUtlSkillDesc_0 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，选择转化为所有敌人的<D13AFKeyWordQ2:精神创伤>和<D13AFKeyWordQ1:恐惧固着>。获得 <Posse:[Arg4]> 点银钥能量和 [Power:Arg5] 点<PowerIconKeywords:力量>，对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次。"
  },
  Skill_78785_OverLimitUtlSkillDesc_2 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，选择转化为所有敌人的<D13AFKeyWordQ2:精神创伤>和<D13AFKeyWordQ1:恐惧固着>，每移除 1 层克莱门汀造成的基础伤害提高 3％。获得 <Posse:[Arg4]> 点银钥能量和 [Power:Arg5] 点<PowerIconKeywords:力量>，对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次。"
  },
  Skill_78785_OverLimitUtlSkillDesc_3 = {
    Text = "移除自身所有<AnalysisKeywords3:共感>，选择转化为所有敌人的<D13AFKeyWordQ2:精神创伤>和<D13AFKeyWordQ1:恐惧固着>，每移除 1 层克莱门汀造成的基础伤害提高 3％。获得 <Posse:[Arg4]> 点银钥能量和 [Power:Arg5] 点<PowerIconKeywords:力量>，对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害 [Arg6] 次。"
  },
  Skill_78785_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2％"
  },
  Skill_78786_AwakerSkillBackgroundStory = {
    Text = "血液奔涌，灵魂燃烧，肉与骨榨出的痛苦，是最好的美味。\n这些美味会被反复品味，从最开始的尖叫，到绝望的喘息，以及最后缄默的苍白死亡。"
  },
  Skill_78786_BattleDesc = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 <Posse:[Arg6]> 点银钥能量。<WormholeKeywords:超距>：获得 [Power:Arg5] 点<PowerIconKeywords:力量>。"
  },
  Skill_78786_Desc = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3]％ 克莱门汀银钥充能的银钥能量。<WormholeKeywords:超距>：获得 [Power:Arg5] 点<PowerIconKeywords:力量>。"
  },
  Skill_78786_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_78786_Name = {
    Text = "痛苦榨取"
  },
  Skill_78786_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_78787_AwakerSkillBackgroundStory = {
    Text = "心理咨询告一段落，但她知道你终会归来。\n这世界荒芜而残酷，唯有这里，稍有救赎。"
  },
  Skill_78787_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾 [Arg2] 次。获得 <Energy:[Energy:Arg5]> 点狂气。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78787_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，克莱门汀获得 <Energy:[Energy:Arg3]> 点狂气。<WormholeKeywords:超距>：获得 [Power:Arg4] 点<PowerIconKeywords:力量>。"
  },
  Skill_78787_EffectNameList = {
    Text = "护盾,狂气,力量"
  },
  Skill_78787_Name = {Text = "防御"},
  Skill_78787_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,攻击力*GrowValue3"
  },
  Skill_78788_Desc = {
    Text = "每移除自身 1 层「共感」，就对所有敌人施加 1 层「精神创伤」，每层「精神创伤」使目标承受的伤害增加 3％。"
  },
  Skill_78788_Name = {
    Text = "转化·精神创伤"
  },
  Skill_78789_AwakerSkillBackgroundStory = {
    Text = "陌生的嘶鸣深深扎入你的头颅，随着你的记忆流窜。\n从此，你的呼吸都开始不由自主，带着昆虫的味道。\n感受这呼唤，悦纳这呼唤，然后蜕化、新生——\n我的朋友，我的同族。"
  },
  Skill_78789_Desc_0 = {
    Text = "克莱门汀获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：克莱门汀每回合打出的首张指令卡伤害、护盾、生命回复、获得狂气、获得银钥能量的效果次数提高 [Arg2]。"
  },
  Skill_78789_Desc_15 = {
    Text = "克莱门汀获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：克莱门汀造成的伤害次数 +1，每回合打出的首张指令卡伤害、护盾、生命回复、获得狂气、获得银钥能量的效果次数提高 [Arg2]。「共感」上限提高为 20。"
  },
  Skill_78789_EffectNameList = {Text = "狂气"},
  Skill_78789_Name = {
    Text = "妖虫的呼唤"
  },
  Skill_78789_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_78904_Desc_1 = {
    Text = "对目标造成 [Arg1]%最大生命的伤害。获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_78904_Desc_2 = {
    Text = "为任意目标更换命轮。获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_78904_Name_1 = {Text = "猫猫拳"},
  Skill_78904_Name_2 = {Text = "小巧思"},
  Skill_78915_Desc_1 = {
    Text = "抽 [Arg1] 张牌，获得 [Arg2] 算力。"
  },
  Skill_78915_Name_1 = {
    Text = "莉雅的硬币"
  },
  Skill_78936_Desc_1 = {
    Text = "将 [Arg1] 张<PVPDerivativeCardKeywords_29:「莉雅的硬币」>置入下一个抽牌堆。"
  },
  Skill_78936_Name_1 = {
    Text = "酒馆之门"
  },
  Skill_78936_UnknownName = {
    Text = "酒馆之门"
  },
  Skill_79252_Desc_1 = {
    Text = "测试重置指令"
  },
  Skill_79252_Name_1 = {
    Text = "测试重置指令"
  },
  Skill_79257_Desc_1 = {
    Text = "对目标造成 [Arg1]%最大生命的伤害。获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_79257_Name_1 = {Text = "猫猫拳"},
  Skill_79302_Name = {
    Text = "添加10000出血"
  },
  Skill_79478_Desc = {
    Text = "将所有手牌弃掉，更换为「虫族」的随机指令卡。「虫族」每回合能够释放 2 次狂气爆发。"
  },
  Skill_79478_Name = {
    Text = "巢群意志"
  },
  Skill_79758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_79759_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_79760_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_79761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<FragileIconKeywords:脆弱>。"
  },
  Skill_80035_BattleDesc = {
    Text = "进行「超维超越」"
  },
  Skill_80035_Desc = {
    Text = "进行「超维超越」"
  },
  Skill_80035_Name = {Text = "超越"},
  Skill_80193_Desc_1 = {
    Text = "抽 [Arg1] 张牌，对方抽 [Arg2] 张牌。"
  },
  Skill_80193_Name_1 = {
    Text = "特殊治疗"
  },
  Skill_80193_UnknownName = {
    Text = "特殊治疗"
  },
  Skill_80194_Desc = {
    Text = "回复 <Heal:[Heal:Arg1]> 点生命，获得 [Arg2] 点力量。若克莱门汀在队伍中，使她本回合下次打出的指令卡伤害、护盾、生命回复、获得狂气、获得银钥能量的效果次数提高 1。"
  },
  Skill_80194_Name = {
    Text = "特殊治疗"
  },
  Skill_80355_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。回合开始时，随机对 2 张没有「认知错乱」的指令施加「认知错乱」。"
  },
  Skill_80355_Name = {
    Text = "生命重构治疗"
  },
  Skill_80442_Desc = {Text = "增伤1层"},
  Skill_80442_Name = {
    Text = "克莱门汀增伤"
  },
  Skill_80585_Desc = {
    Text = "将 1 张「巢群捕食」置入手中，所有唤醒体暴击率下降 [Arg1]％。"
  },
  Skill_80585_Name = {
    Text = "认知汲取"
  },
  Skill_80586_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。若本回合受到过暴击，意图变为「认知汲取」。"
  },
  Skill_80586_Name = {Text = "螫针"},
  Skill_80587_Desc = {
    Text = "清除负面状态，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_80587_Name = {
    Text = "迈向新生"
  },
  Skill_80588_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_80588_Name = {Text = "戳刺"},
  Skill_80589_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<WeaknessIconKeywords:虚弱> [Arg3] 回合。"
  },
  Skill_80589_Name = {Text = "毒牙"},
  Skill_80590_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<VulnerabilityIconKeywords:易伤> [Arg3] 回合。"
  },
  Skill_80590_Name = {Text = "咬噬"},
  Skill_80591_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 1 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_80591_Name = {
    Text = "失控追击"
  },
  Skill_80605_Desc = {
    Text = "将 [Arg1] 张「巢群捕食」置入手中。赋予抽牌堆随机 [Arg2] 张卡牌 [Arg3] 层「迟缓」。"
  },
  Skill_80605_Name = {
    Text = "神经毒素"
  },
  Skill_80606_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。赋予仍在手中保留的卡牌 [Arg3] 层「迟缓」。"
  },
  Skill_80606_Name = {
    Text = "心智寄生"
  },
  Skill_80607_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_80607_Name = {
    Text = "狩猎时刻"
  },
  Skill_80608_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<FragileIconKeywords:脆弱> [Arg3] 回合。"
  },
  Skill_80608_Name = {
    Text = "狩猎时刻·破甲"
  },
  Skill_80609_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。<HeavyInjuryKeywords:重创> [Arg3] 回合。"
  },
  Skill_80609_Name = {
    Text = "狩猎时刻·重创"
  },
  Skill_80749_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:力量>和 [Arg2] 层「旧日余烬」。"
  },
  Skill_80749_Name = {
    Text = "歇斯底里"
  },
  Skill_80750_Desc = {
    Text = "切换到该意图后，本回合承受的主动伤害提高 100％。释放后造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_80750_Name = {Text = "蛰伏"},
  Skill_80751_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加  [Arg3]％ 造成伤害的中毒，每有 1 点护盾该伤害降低 1。若该伤害触发了「死亡抵抗」，将剩余的「死亡抵抗」减半。"
  },
  Skill_80751_Name = {
    Text = "毒刺散射"
  },
  Skill_80752_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺>伤害 [AttackTimes:Arg2] 次。 回复 [Arg3]％ 已损失生命，每层「宇宙幽能」使最大生命提高 [Arg5]%。获得 [Arg4] 层「宇宙轮回」：受到致命伤害后，回复所有生命并获得 30 层临时加固。"
  },
  Skill_80752_Name = {
    Text = "蜕变之刻"
  },
  Skill_80753_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。赋予仍在手中保留的卡牌 [Arg3] 层「迟缓」，将 1 张「巢群捕食」置入手中。"
  },
  Skill_80753_Name = {
    Text = "心智寄生"
  },
  Skill_80754_Desc = {
    Text = "移除 1 层「宇宙幽能」进入「隐匿」状态，召唤 [Arg1] 个「虫族」，它们每回合获得 [Arg2] 层<MadnessIconKeywords:疯狂>。其它敌人全部死亡时，解除「隐匿」。"
  },
  Skill_80754_Name = {
    Text = "呼唤同族"
  },
  Skill_80755_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张「巢群捕食」置入手中。若本回合击碎了「旧日余烬」，变为无伤害的「神经毒素」。"
  },
  Skill_80755_Name = {
    Text = "散播剧毒"
  },
  Skill_80756_Desc = {
    Text = "切换到该意图后，本回合承受的主动伤害提高 100％。释放后造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_80756_Name = {Text = "蛰伏"},
  Skill_80757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，目标每损失 [Arg3]％ 生命伤害次数提高 1。若存在「宇宙幽能」，移除 1 层并获得 1 层<MadnessIconKeywords:疯狂>。"
  },
  Skill_80757_Name = {
    Text = "痛楚切割"
  },
  Skill_80758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。每点护盾使该伤害降低 1 点。若存在「宇宙幽能」，移除 1 层并获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_80758_Name = {
    Text = "维度撕裂"
  },
  Skill_80759_Desc = {
    Text = "移除 1 层「宇宙幽能」进入「隐匿」状态，召唤 [Arg1] 个「虫族」，它们每回合获得 [Arg2] 层<MadnessIconKeywords:疯狂>。其它敌人全部死亡时，解除「隐匿」。"
  },
  Skill_80759_Name = {
    Text = "呼唤同族"
  },
  Skill_80760_Desc = {
    Text = "切换到该意图后，本回合承受的伤害提高 100％。释放后造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_80760_Name = {Text = "蛰伏"},
  Skill_80762_Desc = {
    Text = "召唤 [Arg1] 名「蜕化者」在前方。"
  },
  Skill_80762_Name = {
    Text = "幼虫繁育"
  },
  Skill_80763_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。将 [Arg3] 张「巢群捕食」置入手中。若本回合击碎了「旧日余烬」，变为低伤害的「心智寄生」。"
  },
  Skill_80763_Name = {
    Text = "散播痛楚"
  },
  Skill_80764_Desc = {
    Text = "获得 [Arg1] 层「虚空幽能」，降低所有唤醒体 [Arg4]％暴击率。下回合开始时，选择 [Arg2] 名唤醒体，封印其所有卡牌和狂气爆发 [Arg3] 回合。"
  },
  Skill_80764_Name = {
    Text = "意识幽禁"
  },
  Skill_80765_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加  [Arg3]％ 造成伤害的中毒，每有 1 点护盾该伤害降低 1。若该伤害触发了「死亡抵抗」，将剩余的「死亡抵抗」减半。"
  },
  Skill_80765_Name = {
    Text = "毒刺散射"
  },
  Skill_80766_Desc = {
    Text = "召唤 [Arg1] 名「蜕化者」在前方。"
  },
  Skill_80766_Name = {
    Text = "幼虫繁育"
  },
  Skill_80767_Desc = {
    Text = "将 [Arg1] 张「巢群捕食」置入手中。赋予抽牌堆随机 [Arg2] 张卡牌 [Arg3] 层「迟缓」。"
  },
  Skill_80767_Name = {
    Text = "神经毒素"
  },
  Skill_80768_Desc = {
    Text = "将 [Arg1] 张「巢群捕食」置入手中。赋予抽牌堆随机 [Arg2] 张卡牌 [Arg3] 层「迟缓」。"
  },
  Skill_80768_Name = {
    Text = "神经毒素"
  },
  Skill_80769_Desc = {
    Text = "召唤 [Arg1] 名「初变者」在前方，获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  Skill_80769_Name = {Text = "拟态"},
  Skill_80969_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 1 层<MadnessIconKeywords:疯狂>。打出觉醒卡后意图更改为「痛苦榨取」。"
  },
  Skill_80969_Name = {
    Text = "心理绞杀"
  },
  Skill_81071_Desc = {
    Text = "召唤 [Arg1] 名「蜕化者」在前方。"
  },
  Skill_81071_Name = {
    Text = "幼虫繁育"
  },
  Skill_81267_Desc = {
    Text = "填满超维空间"
  },
  Skill_81267_Name = {
    Text = "填满超维空间"
  },
  Skill_81296_Desc = {
    Text = "回合结束时，若仍在手牌堆中，失去 [Arg1] 点生命上限，将其<DepleteIconKeywords:消耗>。打出后，使前排敌人获得 [Arg2] 层「旧日余烬」，将此卡洗入抽牌堆底部。"
  },
  Skill_81296_Name = {
    Text = "巢群捕食"
  },
  Skill_81300_Desc = {
    Text = "从「蹒跚」、「窒息」、「珊瑚赘生」、「亵渎假象」、「狂放」中选择一张加入手中，其余四张置入弃牌堆。"
  },
  Skill_81300_Name = {
    Text = "世界演绎法"
  },
  Skill_81343_Desc = {
    Text = "移除 1 层「宇宙幽能」，<WeaknessIconKeywords:虚弱>和<HeavyInjuryKeywords:重创> [Arg1] 回合，对抽牌堆 [Arg2] 张指令卡施加「认知错乱」。"
  },
  Skill_81343_Name = {
    Text = "虫巢干涉"
  },
  Skill_81433_Desc = {
    Text = "驱散所有唤醒体的<CardKeyWord:封印>状态和暴击率下降效果，移除敌方「加固」状态。将上回合最后打出的 5 张不同非衍生指令卡原始复制置入手中，使它们算力消耗变为 0 并获得<DepleteIconKeywords:消耗>和<NothingnessIconKeywords:虚无>。"
  },
  Skill_81433_Name = {
    Text = "回溯救援"
  },
  Skill_83574_BattleDesc = {
    Text = "清除所有「扬帆」([Arg1])。每清除 1 层，最终伤害提高 [Arg2]% ，所有唤醒体获得 [Arg3] 点狂气。\n若一次性清除了 5 层或以上 「扬帆」，<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，对它们造成已损失生命值 [Arg4]% 的<FixedDamage:纯粹伤害>。"
  },
  Skill_83574_Desc = {
    Text = "清除所有「扬帆」。每清除 1 层，最终伤害提高 10%，所有唤醒体获得 5 点狂气。\n若一次性清除了 5 层或以上 「扬帆」， 「易伤」所有敌人 1 回合，对它们造成已损失生命值 35% 的<FixedDamage:纯粹伤害>。"
  },
  Skill_83574_Name = {
    Text = "破浪启航"
  },
  Skill_83575_BattleDesc = {
    Text = "清除所有「泊锚」([Arg1])。每清除 1 层，死亡抵抗+ [Arg2]% ，获得 [Arg3] 算力，抽 [Arg4] 张牌。\n若一次性清除了 5 层或以上 「泊锚」，获得 [Arg5] 层临时<ParcloseIconKeywords:屏障>。"
  },
  Skill_83575_Desc = {
    Text = "清除所有「泊锚」。每清除 1 层，「死亡抵抗」+15%，获得 1 算力，抽 1 张牌。\n若一次性清除了 5 层或以上 「泊锚」，获得 1 层「屏障」。"
  },
  Skill_83575_Name = {
    Text = "拢岸暂息"
  },
  Skill_83576_BattleDesc = {
    Text = "选择：「破浪启航」( [Arg1] ) 或 「拢岸暂息」( [Arg2] ) 。弃掉时将其<DepleteIconKeywords:消耗>。"
  },
  Skill_83576_Desc = {
    Text = "选择：「破浪启航」 或 「拢岸暂息」。弃掉时将其<DepleteIconKeywords:消耗>。"
  },
  Skill_83576_Name = {
    Text = "引航员的抉择"
  },
  Skill_83779_AwakerSkillBackgroundStory = {
    Text = "无垠的咸水吞噬了她，同时也庇护了她。\n在那令人窒息的沉沦感里，她感知着幽邃的大海，融入着幽邃的大海。\n终有一日，海洋将彻底平静，每个航行于海面的船只，都会被赐予安宁。\n她等待着那日，那「神国降临之日」。"
  },
  Skill_83779_Desc_0 = {
    Text = "克珀珊特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「<DerivativeCardKeywords_106:领航>」置入手中。切换至「静海」姿态后获得 <Block:[Block:Arg2]> 点护盾，3 回合冷却。"
  },
  Skill_83779_Desc_15 = {
    Text = "克珀珊特获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 条触腕，将 2 张「<DerivativeCardKeywords_106:领航>」置入手中，每回合首张「惩戒雷霆」和「混沌旗语」额外置入 1 张「<DerivativeCardKeywords_106:领航>」到手中，「<DerivativeCardKeywords_106:领航>」效果提高 50％。切换至「静海」姿态后获得 <Block:[Block:Arg2]> 点护盾，3 回合冷却。"
  },
  Skill_83779_EffectNameList = {
    Text = "狂气,护盾"
  },
  Skill_83779_Name = {
    Text = "沉没于远海"
  },
  Skill_83779_PropertyNameList = {
    Text = "$GrowValue1,防御力*GrowValue2"
  },
  Skill_83780_AwakerSkillBackgroundStory = {
    Text = "云层会告知气候的变化，波浪会诉说洋流的变迁，但当风暴真正来临时，再庞大的巨轮，都只能无助地随波逐流。\n此时，领航员的测算、指引，是所有幸存者最后的退路。\n因此履行自己的职责吧，哪怕雷电劈身，也要于痛苦中，绽放出一丝光明，指引海岸的方向。\n那是你必须完成的使命。"
  },
  Skill_83780_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 条临时触腕。弃掉所有手牌并抽等量的牌。"
  },
  Skill_83780_BattleDesc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 条临时触腕。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，临时暴击伤害+ [Arg5]％。弃掉所有手牌并抽等量的牌。"
  },
  Skill_83780_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 条临时触腕。弃掉所有手牌并抽等量的牌。"
  },
  Skill_83780_Desc_3 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾和 [Arg2] 条临时触腕。<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，临时暴击伤害+ [Arg3]％，本场战斗每触发 1 次死亡抵抗额外提高 [Arg4]％。弃掉所有手牌并抽等量的牌。"
  },
  Skill_83780_EffectNameList = {Text = " 护盾"},
  Skill_83780_Name = {
    Text = "照彻渊海的引航"
  },
  Skill_83780_OverLimitUtlSkillDesc_0 = {
    Text = "弃掉所有手牌并抽取等量卡牌，额外触发 1 次弃置卡牌的「余波」效果。获得 <Block:[Block:Arg1]> 点护盾、[Arg2] 条临时触腕、 [Arg2] 条永久触腕。"
  },
  Skill_83780_OverLimitUtlSkillDesc_3 = {
    Text = "<VulnerabilityIconKeywords:易伤>所有敌人 1 回合，临时暴击伤害+ [Arg5]％。弃掉所有手牌并抽取等量卡牌，额外触发 1 次弃置卡牌的「余波」效果。获得 <Block:[Block:Arg1]> 点护盾、[Arg2] 条临时触腕、 [Arg2] 条永久触腕。"
  },
  Skill_83780_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_83781_AwakerSkillBackgroundStory = {
    Text = "她亦是船只的「语言」，在苍茫的大海上，以旗帜指引着同伴。"
  },
  Skill_83781_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_83781_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg4]> 点狂气。<RippleKeywords:余波>：下次打出获得的狂气提高 [Arg3] ，至多叠加 2 次。"
  },
  Skill_83781_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。克珀珊特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_83781_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。克珀珊特获得 <Energy:[Energy:Arg4]> 点狂气。<RippleKeywords:余波>：下次打出获得的狂气提高 [Arg3] ，至多叠加 2 次。"
  },
  Skill_83781_EffectNameList_0 = {
    Text = "护盾,狂气"
  },
  Skill_83781_EffectNameList_1 = {
    Text = "护盾,狂气"
  },
  Skill_83781_Name = {Text = "防御"},
  Skill_83781_PropertyNameList_0 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_83781_PropertyNameList_1 = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_83782_AwakerSkillBackgroundStory = {
    Text = "她是船只的「头脑」，停泊还是航行，都有最理智的计算。"
  },
  Skill_83782_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_83782_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg4]> 点狂气。<RippleKeywords:余波>：下次打出获得的狂气提高 [Arg3] ，至多叠加 2 次。"
  },
  Skill_83782_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。克珀珊特获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_83782_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。克珀珊特获得 <Energy:[Energy:Arg4]> 点狂气。<RippleKeywords:余波>：下次打出获得的狂气提高 [Arg3] ，至多叠加 2 次。"
  },
  Skill_83782_EffectNameList_0 = {
    Text = "伤害,狂气"
  },
  Skill_83782_EffectNameList_1 = {
    Text = "伤害,狂气"
  },
  Skill_83782_Name = {Text = "打击"},
  Skill_83782_PropertyNameList_0 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_83782_PropertyNameList_1 = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_83783_AwakerSkillBackgroundStory = {
    Text = "旗语是通用的，同时，旗语也是私密的。\n在意识跨越维度门扉，得见「祂」之时，克珀珊特就被赐予了特殊的旗语。\n每一次亵渎地挥舞，都是在响应那伟大存在的呼唤。"
  },
  Skill_83783_Desc_0 = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。将 [Arg2] 张「<DerivativeCardKeywords_106:领航>」置入手中。"
  },
  Skill_83783_Desc_15 = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。将 [Arg2] 张「<DerivativeCardKeywords_106:领航>」置入手中。<WeaknessIconKeywords:虚弱>所有敌人 1 回合。"
  },
  Skill_83783_Desc_2 = {
    Text = "获得 <Energy:[Energy:Arg1]> 点狂气。将 [Arg2] 张「<DerivativeCardKeywords_106:领航>」置入手中。<WeaknessIconKeywords:虚弱>所有敌人 1 回合。"
  },
  Skill_83783_EffectNameList = {Text = "狂气"},
  Skill_83783_Name = {
    Text = "混沌旗语"
  },
  Skill_83783_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_83784_AwakerSkillBackgroundStory = {
    Text = "就连愤怒的时候，克珀珊特也是理智的。\n她会先评判对方所犯的错误，再根据其程度来计算该给出何种等级的惩罚。\n因为在茫茫大海上，若是没有秩序，杀戮和背叛将吞噬一切。"
  },
  Skill_83784_Desc_0 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，享受 [Arg3]％ 触腕伤害加成，每次造成伤害使目标本回合承受的触腕伤害提高 [Arg4]％。将 [Arg5] 张「<DerivativeCardKeywords_106:领航>」置入手中。<RippleKeywords:余波>：此卡牌返回抽牌堆顶部。"
  },
  Skill_83784_Desc_15 = {
    Text = "随机造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，享受 [Arg3]％ 触腕伤害加成，每次造成伤害使目标本回合承受的触腕伤害提高 [Arg4]％。将 [Arg5] 张「<DerivativeCardKeywords_106:领航>」置入手中。<RippleKeywords:余波>：此卡牌返回抽牌堆顶部。"
  },
  Skill_83784_EffectNameList = {
    Text = "伤害,触腕伤害加成"
  },
  Skill_83784_Name = {
    Text = "惩戒雷霆"
  },
  Skill_83784_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2％"
  },
  Skill_84228_BattleDesc_1 = {
    Text = "随机造成 [Arg3] 次 <Damage:[Damage:Arg1]> 伤害。每拥有 [Arg2] <PVPProtectiveKeywords:屏障>额外造成 1 次伤害。"
  },
  Skill_84228_Desc_1 = {
    Text = "随机造成 3 次 <Damage:[Damage:Arg1]> 伤害。每拥有 [Arg2] <PVPProtectiveKeywords:屏障>额外造成 1 次伤害。"
  },
  Skill_84228_Name_1 = {
    Text = "雷暴之怒"
  },
  Skill_84229_Desc_1 = {
    Text = "给予一名友方 [Arg1] 层<PVPProtectiveKeywords:屏障>，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_84229_Name_1 = {
    Text = "照彻渊海的引航"
  },
  Skill_84230_Desc_1 = {
    Text = "回复一名友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_84230_Name_1 = {
    Text = "冥海之息"
  },
  Skill_84231_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_84231_Name_1 = {Text = "打击"},
  Skill_84232_Desc_1 = {
    Text = "<StrengthenKeywords:强化>一名友方并给予其 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_84232_Name_1 = {
    Text = "潮汐鼓舞"
  },
  Skill_84261_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [Arg1] 层<PVPProtectiveKeywords:屏障>，否则获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_84261_Name_1 = {
    Text = "圣火中的指引"
  },
  Skill_84262_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，回复损失生命最多的友方 <Heal:[Heal:Arg1]> 生命。"
  },
  Skill_84262_Name_1 = {
    Text = "海上领航者"
  },
  Skill_84263_Desc_1 = {
    Text = "给予全体友方 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_84263_Name_1 = {
    Text = "不灭的雷光"
  },
  Skill_84263_UnknownName = {
    Text = "不灭的雷光"
  },
  Skill_84357_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<RippleKeywords:余波>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点触腕伤害。"
  },
  Skill_84357_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。<RippleKeywords:余波>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>和 [TentaclePower:Arg2] 点触腕伤害。"
  },
  Skill_84357_Name = {Text = "领航"},
  Skill_84378_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，抽 [Arg2] 张牌。若克珀珊特在队伍中，还会将 1 张「领航」置入手中。"
  },
  Skill_84378_Name = {
    Text = "不灭的雷光"
  },
  Skill_84383_BattleDesc = {
    Text = "造成 [Arg2] 次伤害。将 [Arg3] 张症状「疯狂」洗入抽牌堆。"
  },
  Skill_84383_Desc = {
    Text = "惩戒雷霆：造成 3 次伤害。将1张「症状：疯狂」洗入抽牌堆顶。"
  },
  Skill_84383_Name = {
    Text = "惩戒雷霆"
  },
  Skill_84384_BattleDesc = {
    Text = "自身力量提高 [Arg1] ，获得 [Arg2] 层<ParcloseIconKeywords:屏障>，获得 5 层<ReinforcePVEKeywords:加固>。下回合开始时每层屏障转化为 1 层<ReinforcePVEKeywords:加固>。"
  },
  Skill_84384_Desc = {
    Text = "照彻渊海的引航：自身力量提高 0.05*ATK，获得 8 层屏障。下回合开始时每层屏障转化为 1 点加固。"
  },
  Skill_84384_Name = {
    Text = "照彻渊海的引航"
  },
  Skill_84385_BattleDesc = {
    Text = "驱散<WeaknessIconKeywords:虚弱>。自身力量提高 [Arg1]，承受伤害提高 [Arg2]% ，惩戒雷霆伤害次数提高 [Arg3] 。"
  },
  Skill_84385_Desc = {
    Text = "赴死如归的天火：驱散虚弱。自身力量提高0.1ATK，承受伤害提高 10% ，惩戒雷霆伤害次数额外提高 1 。"
  },
  Skill_84385_Name = {
    Text = "赴死如归的天火"
  },
  Skill_84387_BattleDesc = {
    Text = "造成 [Arg2] 次伤害并施加 [Arg3] 回合<VulnerabilityIconKeywords:易伤>。将 [Arg4] 张症状「疯狂」洗入抽牌堆。"
  },
  Skill_84387_Desc = {
    Text = "惩戒雷霆觉醒版：造成4次伤害+易伤2回合。将1张「症状：疯狂」洗入抽牌堆顶。"
  },
  Skill_84387_Name = {
    Text = "惩戒雷霆"
  },
  Skill_84388_BattleDesc = {
    Text = "造成 [Arg2] 次伤害并施加 [Arg3] 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_84388_Desc = {
    Text = "混沌旗语：造成1次伤害+虚弱2回合。"
  },
  Skill_84388_Name = {
    Text = "混沌旗语"
  },
  Skill_84404_BattleDesc = {
    Text = "惩戒雷霆伤害次数提高 [Arg2] 。获得「沉没于远海」：每回合结束时承受伤害提高 [Arg3]% ，自身获得 [Arg4] 层屏障。"
  },
  Skill_84404_Desc = {
    Text = "沉没于远海：惩戒雷霆伤害次数提高 1。获得状态「沉没于远海」：每回合结束时承受伤害提高 5% ，自身获得 2 层屏障。"
  },
  Skill_84404_Name = {
    Text = "沉没于远海"
  },
  Skill_89423_Desc_1 = {
    Text = "对敌我所有其他角色造成 <Damage:[Damage:Arg1]> 伤害，获得等量伤害的护盾。"
  },
  Skill_89423_Name_1 = {
    Text = "死亡飓风"
  },
  Skill_89424_Desc_1 = {
    Text = "选择一名友方获得 1 张<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89424_Name_1 = {
    Text = "漆黑之雨"
  },
  Skill_89425_Desc_1 = {
    Text = "<StrongEffectKeywords:强效> +[Arg1]，所有友方获得 1 张<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89425_Name_1 = {
    Text = "不屈的孤嚎鸟"
  },
  Skill_89426_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时使生命和护盾最低的友方获得 [Arg1] 张<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89426_Name_1 = {Text = "孤羽"},
  Skill_89427_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_89427_Name_1 = {Text = "打击"},
  Skill_89428_Desc_1 = {
    Text = "对前排造成 <Damage:[Damage:Arg1]> 点伤害并获得等量狂气，获得 [Arg2] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_89428_Name_1 = {Text = "黑羽"},
  Skill_89429_Desc_1 = {
    Text = "<TauntKeywords:嘲讽>，全体友方<StrongEffectKeywords:强效> +[Arg1]。"
  },
  Skill_89429_Name_1 = {
    Text = "庇护意志"
  },
  Skill_89430_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 + [Arg3]。「狂气爆发」后手中基础算力消耗为 [Arg1] 的「技能」算力消耗减少 [Arg2]。"
  },
  Skill_89430_Name_1 = {
    Text = "不可承受的自由"
  },
  Skill_89532_Desc_1 = {
    Text = "选择一名友方获得  [Arg1]  张<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  Skill_89532_Name_1 = {
    Text = "错位命运"
  },
  Skill_89532_UnknownName = {
    Text = "错位命运"
  },
  Skill_89563_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备者死亡后，将自身算力消耗 -[Arg1] 的所有「技能」洗入抽牌堆，所属者改为剩余生命最高友方。"
  },
  Skill_89563_Name_1 = {
    Text = "重生于湮土"
  },
  Skill_89659_Desc_1 = {
    Text = "抽 [Arg1] 张牌，获得 [Arg2] 算力。"
  },
  Skill_89659_Name_1 = {Text = "灵感"},
  Skill_89750_Desc = {
    Text = "等待……"
  },
  Skill_89750_Name = {Text = "等待"},
  Skill_89776_AwakerSkillBackgroundStory = {
    Text = "“哥哥，你说靠翅膀一直飞、一直飞，到底能飞到多高？能飞到云层上面，去摸摸月亮和星星吗？”\n“也许……可以吧？那我们要有一双很大、很有力气的翅膀才行。”\n手抄本上深邃梦幻的银河与星座倒映进两个孩子沉沉的梦乡，化作一颗愿望的种子，埋藏入他们的心间。"
  },
  Skill_89776_Desc_0 = {
    Text = "卡斯托尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：卡斯托尔造成的伤害必定暴击，「<DerivativeCardKeywords_107:黑羽>」打出后对目标施加 [Corrosion:Arg2] 层<Corrosion:侵蚀>，保留的护盾提高 50％。"
  },
  Skill_89776_Desc_15 = {
    Text = "卡斯托尔获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：卡斯托尔造成的伤害必定暴击，「<DerivativeCardKeywords_107:黑羽>」打出后对目标施加 [Corrosion:Arg2] 层<Corrosion:侵蚀>，保留的护盾提高 50％。每回合首次打出黑羽时对前排敌人造成等同于天赋「圣羽洗罪」的侵蚀，侵蚀移除时失去的生命由 300％ 提高为 500％。"
  },
  Skill_89776_EffectNameList = {
    Text = "狂气,侵蚀"
  },
  Skill_89776_Name = {
    Text = "翱翔夙愿"
  },
  Skill_89776_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_89777_AwakerSkillBackgroundStory = {
    Text = "他不曾被教授任何战斗的技巧，但抗争的力量早已根植于他生命的本能。"
  },
  Skill_89777_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89777_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。卡斯托尔获得 <Energy:[Energy:Arg2]> 点狂气。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89777_EffectNameList = {
    Text = "伤害,狂气,超距护盾"
  },
  Skill_89777_Name = {Text = "打击"},
  Skill_89777_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2,防御力*GrowValue3"
  },
  Skill_89778_AwakerSkillBackgroundStory = {
    Text = "他愚笨、倔强、不曾改变。 哪怕只能发出孤单的啼叫，也不会屈服于任何锁链与刀刃。 他要用那不曾磨损的尖喙，去啄击牢笼的每一处裂痕。 当黑色的羽翼刺破夜的边缘，他要衔着那片最后的羽毛，带上他的影子，飞向风暴另一头的天光。"
  },
  Skill_89778_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，将 [Arg2] 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆。"
  },
  Skill_89778_EffectNameList = {Text = " 护盾"},
  Skill_89778_Name = {
    Text = "不屈的孤嚎鸟"
  },
  Skill_89778_OverLimitUtlSkillDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，本回合「<DerivativeCardKeywords_107:黑羽>」保留的护盾提高 <Block:[Block:Arg5]>，每次打出「<DerivativeCardKeywords_107:黑羽>」额外对目标施加 [Corrosion:Arg4] 层<Corrosion:侵蚀>。将 [Arg2] 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆并将 [Arg3] 张「<DerivativeCardKeywords_107:黑羽>」置入手中。"
  },
  Skill_89778_PropertyNameList = {
    Text = "防御力*GrowValue1"
  },
  Skill_89779_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害，抽 [Arg1] 张牌。保留：获得 <Block:[Block:Arg3]> 点护盾。消耗。"
  },
  Skill_89779_BattleDesc_3 = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害，抽 [Arg1] 张牌。每打出 3 张获得 1 点算力，卡斯托尔造成的最终伤害提高 10％ ([Arg4]/3)。保留：获得 <Block:[Block:Arg3]> 点护盾。消耗。"
  },
  Skill_89779_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害，抽 [Arg1] 张牌。保留：获得 <Block:[Block:Arg3]> 点护盾。消耗。"
  },
  Skill_89779_Desc_3 = {
    Text = "造成 <Damage:[Damage:Arg2]> 点伤害，抽 [Arg1] 张牌。每打出 3 张获得 1 点算力，卡斯托尔造成的最终伤害提高 10％。保留：获得 <Block:[Block:Arg3]> 点护盾。消耗。"
  },
  Skill_89779_Name = {Text = "黑羽"},
  Skill_89780_AwakerSkillBackgroundStory = {
    Text = "为了对抗残忍的剥削，对抗那些一次又一次的失去，他会将这双翅膀永远挡在弟弟的身前。直到每一根羽毛都化为灰烬，直到他先一步走入死亡的大门。"
  },
  Skill_89780_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89780_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。卡斯托尔获得 <Energy:[Energy:Arg2]> 点狂气。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89780_EffectNameList = {
    Text = "护盾,狂气,超距护盾"
  },
  Skill_89780_Name = {Text = "防御"},
  Skill_89780_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2,防御力*GrowValue3"
  },
  Skill_89781_AwakerSkillBackgroundStory = {
    Text = "他的羽翼张开，如一柄宽阔的盾，每一根羽毛都连接着坚韧的骨骼，在你头顶簌簌抖动。\n那片黑色的阴影将你包裹，将一切日光、风雨与伤害都遮蔽在外，支撑起一片安全的天空。\n“不要触碰它，就让这些黑暗的诅咒，尽数归还加害者的胸膛。”"
  },
  Skill_89781_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，<WeaknessIconKeywords:虚弱>所有敌人 1 回合。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89781_Desc_2 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，<WeaknessIconKeywords:虚弱>所有敌人 1 回合，手牌中每有 1 张「<DerivativeCardKeywords_107:黑羽>」获得 <Energy:[Energy:Arg2]> 点狂气。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg3]> 点护盾。"
  },
  Skill_89781_EffectNameList = {
    Text = "护盾,超距护盾"
  },
  Skill_89781_Name = {
    Text = "蔽日之羽"
  },
  Skill_89781_PropertyNameList = {
    Text = "防御力*GrowValue1,防御力*GrowValue2"
  },
  Skill_89782_AwakerSkillBackgroundStory = {
    Text = "他不是惯会忍受，那双羽翼亦能扇起暴怒的漩涡。\n一切血肉都将被风的利齿撕碎，淋漓地卷入死亡的腹中。\n但不必害怕，他会将你的名字安置于飓风之眼，那最中央的宁静。"
  },
  Skill_89782_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，其他友方临时暴击伤害提高 [Arg3]％。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg4]> 点护盾。"
  },
  Skill_89782_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次，其他友方临时暴击伤害提高 [Arg3]％。本回合每打出 1 张「<DerivativeCardKeywords_107:黑羽>」算力消耗降低 1。<WormholeKeywords:超距>：将 1 张「<DerivativeCardKeywords_107:黑羽>」洗入抽牌堆，获得 <Block:[Block:Arg4]> 点护盾。"
  },
  Skill_89782_EffectNameList = {
    Text = "伤害,暴击伤害,超距护盾"
  },
  Skill_89782_Name = {
    Text = "穿行永夜"
  },
  Skill_89782_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2％,防御力*GrowValue3"
  },
  Skill_89949_Desc = {
    Text = "从随机 3 个钥令中选择 1 个钥令释放，每个已解锁的钥令在本次探索中只能选择 1 次，不可选择初始携带的钥令。"
  },
  Skill_89949_Name = {
    Text = "尘封旧忆"
  },
  Skill_90212_Desc = {
    Text = "选择一名唤醒体使其获得 <Energy:[Energy:Arg3]> 点狂气，从抽牌堆中抽 [Arg2] 张算力消耗最低的卡牌。若卡斯托尔在队伍中，使其伤害强效临时提高 [Arg1]％。"
  },
  Skill_90212_Name = {
    Text = "错位命运"
  },
  Skill_90565_Desc = {
    Text = "「祭灵夜特调」追加「获得 [Arg1] 点银钥能量。」"
  },
  Skill_90565_Name = {
    Text = "无垢之银"
  },
  Skill_90566_Desc = {
    Text = "「祭灵夜特调」追加「获得 [Arg1] 点临时力量和 [Arg2] 点临时戒备。」"
  },
  Skill_90566_Name = {
    Text = "森然之绿"
  },
  Skill_90567_Desc = {
    Text = "「祭灵夜特调」追加「使所有唤醒体获得 [Arg1] 点狂气。」"
  },
  Skill_90567_Name = {
    Text = "蜂糖之金"
  },
  Skill_90568_Desc = {
    Text = "所有唤醒体暴击率和暴击伤害临时提高 [Arg1]％，"
  },
  Skill_90568_Name = {
    Text = "祭灵夜特调"
  },
  Skill_90569_Desc = {
    Text = "「祭灵夜特调」追加「将 1 张「灵感」置入手中。」"
  },
  Skill_90569_Name = {
    Text = "灵感之蓝"
  },
  Skill_90570_Desc = {
    Text = "「祭灵夜特调」追加「回复 [Arg1] 点生命。」"
  },
  Skill_90570_Name = {
    Text = "血腥之红"
  },
  Skill_91158_BattleDesc = {
    Text = "移除自身<BleedingIconKeywords:出血>，获得等同于已损失生命 30% 的护盾( [Arg1])，抽 2 张牌。"
  },
  Skill_91158_Desc = {
    Text = "移除自身<BleedingIconKeywords:出血>，获得等同于已损失生命 30% 的护盾，抽 2 张牌。"
  },
  Skill_91158_Name = {
    Text = "子嗣庇佑"
  },
  Skill_91159_BattleDesc = {
    Text = "获得 4 层临时<Kuangre:狂热>和 2 点算力。"
  },
  Skill_91159_Desc = {
    Text = "获得 4 层临时狂热和 2 点算力。"
  },
  Skill_91159_Name = {
    Text = "子嗣激励"
  },
  Skill_91218_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_91218_Name_1 = {
    Text = "魂灵之噬"
  },
  Skill_91219_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_91219_Name_1 = {
    Text = "生灵的盛筵"
  },
  Skill_91220_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_91220_Name_1 = {Text = "打击"},
  Skill_91221_Desc_1 = {
    Text = "获得 <Energy:[Energy:Arg1]> 狂气。"
  },
  Skill_91221_Name_1 = {
    Text = "欢愉餍飨"
  },
  Skill_91222_Desc_1 = {
    Text = "给予一名友方 [Arg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  Skill_91222_Name_1 = {
    Text = "溟梦之帷"
  },
  Skill_91512_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合结束时，装备者对后排敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_91512_Name_1 = {Text = "开学日"},
  Skill_91513_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，将 [Arg1] 张<PVPDerivativeCardKeywords_17:「灵感」>置入手牌。"
  },
  Skill_91513_Name_1 = {
    Text = "搭档特训"
  },
  Skill_91741_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91741_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91741_Name = {Text = "打击"},
  Skill_91742_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虚弱>，消耗 [Arg4] 层<Guaiwuheiyu:黑羽>。当玩家释放钥令后，意图立刻变为低伤害的「打击」并获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91742_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虚弱>，消耗 [Arg4] 层<Guaiwuheiyu:黑羽>。当玩家释放钥令后，意图立刻变为低伤害的「打击」并获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91742_Name = {
    Text = "双重黑羽"
  },
  Skill_91743_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虚弱>，消耗 [Arg4] 层<Guaiwuheiyu:黑羽>。当玩家释放钥令后，意图立刻变为低伤害的「打击」并获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91743_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。施加 [Arg3] 回合<BlindingKeywords:致盲> 和 <WeaknessIconKeywords:虚弱>，消耗 [Arg4] 层<Guaiwuheiyu:黑羽>。当玩家释放钥令后，意图立刻变为低伤害的「打击」并获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91743_Name = {Text = "黑羽"},
  Skill_91744_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每层黑羽使造成的最终伤害提高 [Arg3] %，清除一半<Guaiwuheiyu:黑羽>。"
  },
  Skill_91744_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每层黑羽使造成的最终伤害提高 [Arg3] %，清除一半<Guaiwuheiyu:黑羽>。"
  },
  Skill_91744_Name = {
    Text = "穿行永夜"
  },
  Skill_91745_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91745_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91745_Name = {
    Text = "不屈的孤嚎鸟"
  },
  Skill_91746_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，每有 [Arg2] 层黑羽使获得的防御提高 [Arg3]%，获得 [Arg4] 点<PowerIconKeywords:力量>。获得 [Arg5] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91746_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，每有 [Arg2] 层黑羽使获得的防御提高 [Arg3]%，获得 [Arg4] 点<PowerIconKeywords:力量>。获得 [Arg5] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91746_Name = {
    Text = "蔽日之羽"
  },
  Skill_91747_BattleDesc = {
    Text = "未被击破护盾的 [Arg1]% 会保留至下回合，回合结束时获得 [Arg2] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91747_Desc = {
    Text = "未被击破护盾的 [Arg1]% 会保留至下回合，回合结束时获得 [Arg2] 层<Guaiwuheiyu:黑羽>。"
  },
  Skill_91747_Name = {
    Text = "翱翔夙愿"
  },
  Skill_94508_Desc_1 = {
    Text = "有 [Arg1]% 概率为一名友方施加正面<PVPWonderfulEffectKeywords:奇妙效果>，或为一名敌方施加负面<PVPWonderfulEffectKeywords:奇妙效果>，每次施加后概率折半，无限重复此效果，直至施加失败，<PVPPenetrateKeywords:贯穿 1>。"
  },
  Skill_94508_Name_1 = {
    Text = "猎食决心"
  },
  Skill_94508_UnknownName = {
    Text = "猎食决心"
  },
  Skill_94560_Desc = {
    Text = "从出战唤醒体的技能卡中<FaxianKeywords:发现> 3 张，选择 1 张将其临时复制置入手中，并使其算力消耗降低 1。若当前界域为「血肉」，可以选择「一扫而光！」。"
  },
  Skill_94560_Name = {
    Text = "猎食决心"
  },
  Skill_94561_BattleDesc = {
    Text = "临时降低所有敌人 [Arg2] 点<PowerIconKeywords:力量>，每有 1 名敌人获得 [Arg3] 点临时<PowerIconKeywords:力量>。若杜勒赛因在队伍中，获得 1 个<CarcassKeywords:残骸>。"
  },
  Skill_94561_Desc = {
    Text = "<TouquKeywords:偷取>所有敌人 [Arg1] 点 <PowerIconKeywords:力量>。若杜勒赛因在队伍中，获得 1 个<CarcassKeywords:残骸>。"
  },
  Skill_94561_Name = {
    Text = "残忍的致意"
  },
  Skill_94565_Desc = {
    Text = "将全部卡牌置入手中，但不再降低算力消耗。"
  },
  Skill_94565_Name = {
    Text = "一扫而光！"
  },
  Skill_94683_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 1 回合<WeaknessIconKeywords:虚弱>。"
  },
  Skill_94683_Name = {Text = "钉刺"},
  Skill_94684_Desc = {
    Text = "施加 [Arg1] 点<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94684_Name = {Text = "诅咒"},
  Skill_94685_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_94686_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害,自身死亡。"
  },
  Skill_94686_Name = {Text = "自爆"},
  Skill_94703_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，若未被完全格挡将 1 张<DerivativeCardKeywords_80:「窒息」>洗入抽牌堆。"
  },
  Skill_94703_Name = {Text = "海祭"},
  Skill_94704_Desc = {
    Text = "施加 1 回合的 <WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱> 。"
  },
  Skill_94704_Name = {Text = "污浊"},
  Skill_94709_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次, 并附加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94709_Name = {Text = "尸染"},
  Skill_94711_Desc = {
    Text = "所有友方回复食尸鬼自身已损失生命值的10%，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_94711_Name = {Text = "盛宴"},
  Skill_94722_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 [Arg2] 点<IntoxicationIconKeywords:中毒>，并在前方召唤 1 个「腐尸分殖体」。"
  },
  Skill_94722_Name = {
    Text = "墓群的召唤"
  },
  Skill_94723_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 [Arg2] 点<IntoxicationIconKeywords:中毒>，并召唤 2 个「腐尸分殖体」。"
  },
  Skill_94723_Name = {
    Text = "满月的呼唤"
  },
  Skill_94725_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 [Arg2] 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_94725_Name = {Text = "掘墓"},
  Skill_94726_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 [Arg2] 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_94726_Name = {Text = "掘墓"},
  Skill_94731_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 , 并附加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94731_Name = {Text = "尸染"},
  Skill_94732_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 [Arg2] 回合<HeavyInjuryKeywords:重创>。"
  },
  Skill_94732_Name = {
    Text = "墓碑之嚎"
  },
  Skill_94952_Desc = {
    Text = "获得 [Arg1] 层<Guaiwusiwangdikang:死亡抵抗>，召唤 2 个「深海分殖体」。"
  },
  Skill_94952_Name = {
    Text = "海洋的召唤"
  },
  Skill_94953_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 2 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_94953_Name = {
    Text = "撕裂之爪"
  },
  Skill_94954_Desc = {
    Text = "获得 [Arg1] 层<Guaiwusiwangdikang:死亡抵抗>，[Arg2] 点<PowerIconKeywords:力量>，[Arg3] 点<Kuangbao: 狂暴>。"
  },
  Skill_94954_Name = {
    Text = "不灭之魂"
  },
  Skill_94955_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  Skill_94955_Name = {
    Text = "饥饿意志"
  },
  Skill_94956_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，[Arg2] 点<Kuangbao: 狂暴>。"
  },
  Skill_94956_Name = {
    Text = "饥饿意志"
  },
  Skill_94957_Desc = {
    Text = "自身死亡，为生命最高友方提高 [Arg1] 点<PowerIconKeywords:力量>，并使其提高等同于自身当前生命值两倍的最大生命（[Arg2] ）。"
  },
  Skill_94957_Name = {Text = "被吞食"},
  Skill_94958_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加伤害量 [Arg2]%<IntoxicationIconKeywords:中毒>，移除目标 [Arg3]% <PowerIconKeywords:力量>。"
  },
  Skill_94958_Name = {
    Text = "灵魂侵吞"
  },
  Skill_94959_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每次受到暴击伤害降低 1 次攻击次数，最多降低至 3 次。"
  },
  Skill_94959_Name = {
    Text = "噬天巨浪"
  },
  Skill_94960_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Arg2] 点<RetaliateIconKeywords:临时反击>。"
  },
  Skill_94960_Name = {Text = "刺骨"},
  Skill_94961_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加伤害量 [Arg2]%<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94961_Name = {
    Text = "灵魂侵吞"
  },
  Skill_94962_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，每次受到暴击伤害降低 1 次攻击次数，最低 3 次。"
  },
  Skill_94962_Name = {
    Text = "怒海狂涛"
  },
  Skill_94963_Desc = {
    Text = "获得 [Arg1] 层<Guaiwusiwangdikang:死亡抵抗>，免疫 [Arg2] 回合负面状态，召唤 2 个「深海分殖体」。"
  },
  Skill_94963_Name = {
    Text = "深海的呼唤"
  },
  Skill_94964_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加 1 回合<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_94964_Name = {
    Text = "撕裂之爪"
  },
  Skill_94965_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次 , 并附加 [Arg3]% 伤害的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_94965_Name = {Text = "蚀灵"},
  Skill_94966_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。"
  },
  Skill_94966_Name = {Text = "贪欲"},
  Skill_94967_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，施加伤害量 [Arg2]%<IntoxicationIconKeywords:中毒>，移除目标 [Arg3]% <PowerIconKeywords:力量>。"
  },
  Skill_94967_Name = {
    Text = "灵魂侵吞"
  },
  Skill_94968_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，获得 [Arg2] 点<RetaliateIconKeywords:临时反击>，[Arg3]%<Baojidikang:临时暴击抵抗>。"
  },
  Skill_94968_Name = {Text = "刺骨"},
  Skill_95807_Desc = {
    Text = "造成 [Arg1] 点伤害，享受 [Arg2] 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_95807_Name = {
    Text = "亡骸祭礼"
  },
  Skill_95808_Desc = {
    Text = "所有敌人获得 [Arg1] 点临时<PowerIconKeywords:力量>。「葬骸之主」失去一半<Guaiwucanhai:残骸>。"
  },
  Skill_95808_Name = {
    Text = "偷袭储备"
  },
  Skill_95809_AwakerSkillBackgroundStory = {
    Text = "嘘……食尸鬼之王不欢迎无礼的宾客。"
  },
  Skill_95809_BattleDesc = {
    Text = "获得 <Block:[Block:Arg3]> 点护盾。获得 <Energy:[Energy:Arg4]> 点狂气。"
  },
  Skill_95809_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。杜勒赛因获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_95809_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_95809_Name = {Text = "防御"},
  Skill_95809_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_95810_Desc_1 = {
    Text = "选择一名友方，使其获得自身 [Arg1] 张不同且附加<PVPVoidKeywords:虚无>和算力消耗 +[Arg2] 的「技能」。"
  },
  Skill_95810_Name_1 = {
    Text = "残忍的致意"
  },
  Skill_95810_UnknownName = {
    Text = "残忍的致意"
  },
  Skill_95811_AwakerSkillBackgroundStory = {
    Text = "请柬的纸张用来自柔软的肌肤。请柬的装饰来自光滑的颅骨。请柬的文字来自新鲜的血液。请柬的签名来自王邸那位热情的主人。\n杜勒赛因向您发来诚挚的邀请，邀请您来到这场属于你们的盛宴。"
  },
  Skill_95811_Desc_0 = {
    Text = "杜勒赛因获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>，杜勒赛因造成的伤害额外享受 [Arg3]％ 力量加成。杜勒赛因每回合首次造成击杀后，对其他敌人造成 50%溢出伤害的<FixedDamage:纯粹伤害>。"
  },
  Skill_95811_Desc_15 = {
    Text = "杜勒赛因获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 [Power:Arg2] 点<PowerIconKeywords:力量>，杜勒赛因造成的伤害额外享受 [Arg3]％ 力量加成。对所有敌人造成当前生命 [Arg4]％ 的<FixedDamage:纯粹伤害>。杜勒赛因每回合首次造成击杀后，对其他敌人造成 100%溢出伤害的<FixedDamage:纯粹伤害>。"
  },
  Skill_95811_EffectNameList = {
    Text = "狂气,力量"
  },
  Skill_95811_Name = {
    Text = "王邸的请柬"
  },
  Skill_95811_PropertyNameList = {
    Text = "$GrowValue1,攻击力*GrowValue2"
  },
  Skill_95812_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [Arg1] <StrongEffectKeywords:强效>。击杀敌方时溢出的伤害将向后方唤醒体传递。"
  },
  Skill_95812_Name_1 = {
    Text = "安息之吻"
  },
  Skill_95813_AwakerSkillBackgroundStory = {
    Text = "一场精彩的宴会，怎么能够少了舞蹈？"
  },
  Skill_95813_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg3]> 点伤害。获得 <Energy:[Energy:Arg4]> 点狂气。"
  },
  Skill_95813_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。杜勒赛因获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_95813_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_95813_Name = {Text = "打击"},
  Skill_95813_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_95814_AwakerSkillBackgroundStory = {
    Text = "在黑暗中，杜勒赛因重新睁开了眼。\n没有感伤，没有仇恨。他满怀期待地享用，享用自己作为人类的躯体。\n他从一开始就知道，自己的道路将通往何方。"
  },
  Skill_95814_BattleDesc = {
    Text = "失去 10%( [Arg2] ) 当前生命，对所有敌人造成 <Damage:[Damage:Arg3]> 点伤害并使其<VulnerabilityIconKeywords:易伤> 1 回合。"
  },
  Skill_95814_Desc = {
    Text = "失去 10％当前生命，对所有敌人造成 <Damage:[Damage:Arg1]> 点伤害并使其<VulnerabilityIconKeywords:易伤> 1 回合。"
  },
  Skill_95814_EffectNameList = {Text = "伤害"},
  Skill_95814_Name = {
    Text = "冥府之路"
  },
  Skill_95814_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_95815_Desc = {
    Text = "获得 [Arg1]  层<Guaiwusiwangdikang:死亡抵抗>和 [Arg2]  层<Guaiwucanhai:残骸>，召唤「腐尸分殖体」与「食尸鬼侍从」。"
  },
  Skill_95815_Name = {
    Text = "王邸的请柬"
  },
  Skill_95816_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机「<Dongjie:冻结>」 [Arg3]  张抽牌堆中的卡牌。"
  },
  Skill_95816_Name = {
    Text = "冥府之路"
  },
  Skill_95817_AwakerSkillBackgroundStory = {
    Text = "除了菜品本身，用餐的方式也是美食艺术重要的一环。\n用敌人的尸骨制成的餐叉，深切地刺入敌人的灵魂。\n每一道菜肴，都是一场精心准备的重逢。"
  },
  Skill_95817_BattleDesc = {
    Text = "对生命最低的敌人造成 <Damage:[Damage:Arg4]> 点伤害，享受 [Arg2]％ 力量加成，获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_95817_Desc = {
    Text = "对生命最低的敌人造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]％ 力量加成，获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_95817_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_95817_Name = {
    Text = "亡骸祭礼"
  },
  Skill_95817_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_95818_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，敌方生命越低伤害越高，最大为 <Damage:[Damage:Arg2]> 点伤害。吸收所有其他食尸鬼，每吸收 1 名获得 [Arg3] 具<Guaiwucanhai:残骸>和 [Arg4] 层<Guaiwusiwangdikang:死亡抵抗>。"
  },
  Skill_95818_Name = {
    Text = "万灵的餍飨"
  },
  Skill_95819_BattleDesc = {
    Text = "清除所有「餍足」，弃掉所有手牌，将通过<DerivativeCardKeywords_111:「灵魂吞噬」>移除的卡牌置入手中，使它们算力消耗变为 0。回合结束时若在手中：随机将一张被移除卡牌的复制置入手中，使其算力消耗变为0，并获得消耗、虚无。"
  },
  Skill_95819_Desc = {
    Text = "清除所有「餍足」，弃掉所有手牌，将通过<DerivativeCardKeywords_111:「灵魂吞噬」>移除的卡牌置入手中，使它们算力消耗变为 0。回合结束时若在手中：随机将一张被移除卡牌的复制置入手中，使其算力消耗变为0，并获得消耗、虚无。"
  },
  Skill_95819_Name = {
    Text = "记忆共鸣"
  },
  Skill_95820_AwakerSkillBackgroundStory = {
    Text = "撕下你的伪装。放下你的偏见。踏入舞池，拥抱你沉睡多年的舞伴。\n它已经多久没有见过美丽的月光？它已经多久没有听过温柔的情话？\n听呐，它正在渴望着你，一如你正在渴望着它。\n撕咬吧，吞噬吧。在这无与伦比的盛筵里，生灵与死者完成他们共同的升华。"
  },
  Skill_95820_BattleDesc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_110:>本次狂气爆发暴击率+[Arg2]％，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。】对生命最低的敌人造成 <Damage:[Damage:Arg3]> 点伤害，享受 [Arg4]％ 力量加成，目标每损失 1％ 生命本次狂气爆发最终伤害提高 3％。若当前拥有 3 具<CarcassKeywords:残骸>则将其食用，回复 <Heal:[Heal:Arg5]> 点生命并使本次狂气爆发享受的暴击伤害加成翻倍（当前拥有 [Arg6]/3 具<CarcassKeywords:残骸>）。"
  },
  Skill_95820_BattleDesc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂气爆发暴击率+[Arg2]％，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。】对生命最低的敌人造成 <Damage:[Damage:Arg3]> 点伤害，享受 [Arg4]％ 力量加成，目标每损失 1％ 生命本次狂气爆发最终伤害提高 3％。若当前拥有 3 具<CarcassKeywords:残骸>则将其食用，回复 <Heal:[Heal:Arg5]> 点生命并使本次狂气爆发享受的暴击伤害加成翻倍（当前拥有 [Arg6]/3 具<CarcassKeywords:残骸>）。"
  },
  Skill_95820_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_110:>本次狂气爆发暴击率+[Arg2]％，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。】对生命最低的敌人造成 <Damage:[Damage:Arg3]> 点伤害，享受 [Arg4]％ 力量加成，目标每损失 1％ 生命本次狂气爆发最终伤害提高 3％。若当前拥有 3 具<CarcassKeywords:残骸>则将其食用，回复 <Heal:[Heal:Arg5]> 点生命并使本次狂气爆发享受的暴击伤害加成翻倍。"
  },
  Skill_95820_Desc_3 = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂气爆发暴击率+[Arg2]％，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。】对生命最低的敌人造成 <Damage:[Damage:Arg3]> 点伤害，享受 [Arg4]％ 力量加成，目标每损失 1％ 生命本次狂气爆发最终伤害提高 3％。若当前拥有 3 具<CarcassKeywords:残骸>则将其食用，回复 <Heal:[Heal:Arg5]> 点生命并使本次狂气爆发享受的暴击伤害加成翻倍。"
  },
  Skill_95820_EffectNameList = {
    Text = "力量,伤害,治疗"
  },
  Skill_95820_Name = {
    Text = "生灵的盛筵"
  },
  Skill_95820_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：<DerivativeCardKeywords_114:>本次狂气爆发暴击率+[Arg2]％，获得 [Power:Arg1] 点<PowerIconKeywords:力量>。】本次狂气爆发的暴击率+ 25%，基础伤害提高 50%。对生命最低的敌人造成 <Damage:[Damage:Arg7]> 点伤害，享受 [Arg4]％ 力量加成，本次狂气爆发造成的最终伤害提高 100％，目标每损失 1％ 生命额外提高 3％。若当前拥有 3 具「残骸」则将其食用，回复 <Heal:[Heal:Arg5]> 点生命并使本次狂气爆发享受的暴击伤害加成翻倍（当前拥有 [Arg6]/3 具残骸）。"
  },
  Skill_95820_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2,体质*GrowValue3"
  },
  Skill_95821_Desc = {
    Text = "消耗一半 <Guaiwucanhai:残骸> ( [Arg3] ) ，每消耗 1 层获得 [Arg1] <PowerIconKeywords:力量>，并提高 [Arg2]% 生命上限。召唤「腐尸分殖体」与「食尸鬼侍从」。"
  },
  Skill_95821_Name = {
    Text = "残骸收取"
  },
  Skill_95822_Desc = {
    Text = "选择一个策略。每次「葬骸之主」释放「残骸收取」后，置入手中。"
  },
  Skill_95822_Name = {
    Text = "制定策略"
  },
  Skill_95823_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，消耗一半<Guaiwucanhai:残骸>( [Arg3] )，每消耗 1 层，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_95823_Name = {
    Text = "残骸收取"
  },
  Skill_95824_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后抽 [Arg1] 张牌，优先抽取自身「技能」，并使其算力消耗 - [Arg2] 。"
  },
  Skill_95824_Name_1 = {Text = "珍馐"},
  Skill_95825_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，敌方生命越低伤害越高，最大为 <Damage:[Damage:Arg2]> 点伤害。回合结束时吸收所有其他食尸鬼，每吸收 1 名获得 [Arg3] 具<Guaiwucanhai:残骸>。"
  },
  Skill_95825_Name = {
    Text = "生灵的盛筵"
  },
  Skill_95826_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2] 倍<PowerIconKeywords:力量>加成。"
  },
  Skill_95826_Name = {
    Text = "亡骸祭礼"
  },
  Skill_95827_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机「<Dongjie:冻结>」[Arg3] 张抽牌堆中的卡牌。"
  },
  Skill_95827_Name = {
    Text = "冥府之路"
  },
  Skill_95828_BattleDesc = {
    Text = "选择一个友方唤醒体，移除手中其所有卡牌，每张获得一层「餍足」并使其他唤醒体获得 <Energy:5> 点狂气。"
  },
  Skill_95828_Desc = {
    Text = "选择一个友方唤醒体，移除手中其所有卡牌，每张获得一层「餍足」并使其他唤醒体获得 <Energy:5> 点狂气。"
  },
  Skill_95828_Name = {
    Text = "灵魂吞噬"
  },
  Skill_95829_Desc = {
    Text = "所有敌人的伤害临时降低 30%。"
  },
  Skill_95829_Name = {
    Text = "正面干扰"
  },
  Skill_95986_Desc = {Text = "100双暴"},
  Skill_95986_Name = {Text = "100双暴"},
  Skill_95988_Desc = {Text = "1000力量"},
  Skill_95988_Name = {Text = "1000力量"},
  Skill_95989_Desc = {Text = "100强效"},
  Skill_95989_Name = {Text = "100强效"},
  Skill_95990_Desc = {Text = "500力量"},
  Skill_95990_Name = {Text = "500力量"},
  Skill_96018_Desc = {
    Text = "本场战斗造成的最终伤害提高 25%，所有唤醒体获得 30 点狂气。清除所有卡牌的「<Kuangluan:蹈海者狂乱>」状态，消耗手中至多 2 张症状并抽等量卡牌。"
  },
  Skill_96018_Name = {
    Text = "碎裂的符印"
  },
  Skill_96019_Desc = {
    Text = "本场战斗造成的最终伤害提高 50%，所有唤醒体获得 50 点狂气。清除所有卡牌的「<Kuangluan:蹈海者狂乱>」状态，消耗手中至多 3 张症状并抽等量卡牌。"
  },
  Skill_96019_Name = {
    Text = "受损的符印"
  },
  Skill_96022_Desc = {
    Text = "本场战斗造成的最终伤害提高 100%，所有唤醒体获得 100 点狂气。清除所有卡牌的「<Kuangluan:蹈海者狂乱>」状态，消耗手中所有症状并抽等量卡牌。"
  },
  Skill_96022_Name = {
    Text = "完美的符印"
  },
  Skill_96188_BattleDesc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg2]> 点<PunctureDamagewords:穿刺伤害>。"
  },
  Skill_96188_BattleDesc_3 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg2]> 点<PunctureDamagewords:穿刺伤害>，打出后会使本回合后续打出的「永夜欢宴」额外享受 100% 力量加成。"
  },
  Skill_96188_Desc_0 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。"
  },
  Skill_96188_Desc_3 = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，打出后会使本回合后续打出的「永夜欢宴」额外享受 100% 力量加成。"
  },
  Skill_96188_Name = {
    Text = "永夜欢宴"
  },
  Skill_96325_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<FragileIconKeywords:脆弱>，使抽牌堆随机 4 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_96326_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_96327_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。使抽牌堆随机 3 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_96328_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次。造成 [Arg3] 回合<BlindingKeywords:致盲>，使抽牌堆随机 1 张牌附加<ColorInkKeywords:认知失调>。"
  },
  Skill_96342_Desc = {
    Text = "获得 [Arg1]%<Baojidikang:暴击抵抗>和 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_96342_Name = {Text = "誓言"},
  Skill_96343_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加 [Arg3] 回合<HeavyInjuryKeywords:重创>，敌方生命越低伤害越高，最大为 <Damage:[Damage:Arg4]> 点伤害。"
  },
  Skill_96343_Name = {
    Text = "噬骨之刃"
  },
  Skill_96344_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，「<Dongjie:冻结>」[Arg3]  张抽牌堆顶部的卡牌。"
  },
  Skill_96344_Name = {
    Text = "灵魂封存"
  },
  Skill_96345_Desc = {
    Text = "获得 [Arg1] 点<PowerIconKeywords:力量>，[Arg2]%<Baojidikang:暴击抵抗>和 [Arg3] 层<Fennu:「愤怒」>。"
  },
  Skill_96345_Name = {Text = "执念"},
  Skill_96590_Desc = {
    Text = "「祭灵夜特调」追加「使所有唤醒体获得 [Arg1] 点狂气。」"
  },
  Skill_96590_Name = {
    Text = "蜂糖之金"
  },
  Skill_96591_Desc = {
    Text = "「祭灵夜特调」追加「获得 [Arg1] 点银钥能量。」"
  },
  Skill_96591_Name = {
    Text = "无垢之银"
  },
  Skill_96592_Desc = {
    Text = "「祭灵夜特调」追加「回复 [Arg1] 点生命。」"
  },
  Skill_96592_Name = {
    Text = "血腥之红"
  },
  Skill_96593_Desc = {
    Text = "「祭灵夜特调」追加「将 1 张「灵感」置入手中。」"
  },
  Skill_96593_Name = {
    Text = "灵感之蓝"
  },
  Skill_96594_Desc = {
    Text = "「祭灵夜特调」追加「获得 [Arg1] 点临时力量和 [Arg2] 点临时戒备。」"
  },
  Skill_96594_Name = {
    Text = "森然之绿"
  },
  Skill_96734_BattleDesc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方造成 <Damage:[Damage:Arg2]> 伤害，每消耗 1 点算力使伤害提高 [Arg3]。"
  },
  Skill_96734_Desc_1 = {
    Text = "对<HPAndShieldMax:生命与护盾最高>的敌方造成 <Damage:[Damage:Arg1]> 伤害，每消耗 1 点算力使伤害提高 [Arg3]。"
  },
  Skill_96734_Name_1 = {
    Text = "告死魔弹"
  },
  Skill_96735_BattleDesc_1 = {
    Text = "造成合计 <Damage:[Damage:Arg1]> 伤害，平均分配给所有敌方，每个敌方受到 <Damage:[Damage:Arg2]> 伤害。"
  },
  Skill_96735_Desc_1 = {
    Text = "造成合计 <Damage:[Damage:Arg1]> 伤害，平均分配给所有敌方。"
  },
  Skill_96735_Name_1 = {
    Text = "焚却世界的爆炎"
  },
  Skill_96736_Desc_1 = {
    Text = "获得 <Energy:[Energy:Arg1]> 狂气，<StrongEffectKeywords:强效> +[Arg2]。"
  },
  Skill_96736_Name_1 = {
    Text = "爆燃之火"
  },
  Skill_96737_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_96737_Name_1 = {Text = "打击"},
  Skill_96738_Desc_1 = {
    Text = "对全体敌方施加<DelayKeywords:延迟 1>：<PVPWeaknessesKeywords:破绽>。"
  },
  Skill_96738_Name_1 = {
    Text = "万物终结"
  },
  Skill_96755_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，造成等同于未被格挡伤害 50% 的<BleedingIconKeywords:出血>，每层「<Chaos:混乱>」攻击次数降低 1 。"
  },
  Skill_96755_Name = {
    Text = "湍流利刃"
  },
  Skill_96756_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，敌方生命越低伤害越高，施加 1 层「<Daohaizheyishi: 蹈海者祭仪>」。"
  },
  Skill_96756_Name = {
    Text = "蹈海者的审判"
  },
  Skill_96757_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，敌方生命越低伤害越高，为 3 张卡牌附加「<Kuangluan:蹈海者狂乱>」。"
  },
  Skill_96757_Name = {
    Text = "蹈海者的咒怨"
  },
  Skill_96758_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机「畸变」洗入抽牌堆，每层「<Chaos:混乱>」减少 1 张。"
  },
  Skill_96758_Name = {
    Text = "深渊聚爆"
  },
  Skill_96759_Desc = {
    Text = "使自身最大生命提高 [Arg1]%，额外获得 [Arg2] 次生命，获得 [Arg3] 点<RetaliateIconKeywords:反击>、[Arg4] 点<Duren: 毒刃>、[Arg5]% <Baojidikang:暴击抵抗>。"
  },
  Skill_96759_Name = {
    Text = "骨血重组"
  },
  Skill_96760_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg3] 点<PowerIconKeywords:力量>。每层「<Chaos:混乱>」使获得的力量降低  [Arg4] 点。"
  },
  Skill_96760_Name = {
    Text = "奔腾涌流"
  },
  Skill_96761_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，将 [Arg3] 张随机「症状」洗入抽牌堆，每层「<Chaos:混乱>」减少 1 张。"
  },
  Skill_96761_Name = {
    Text = "尸群聚爆"
  },
  Skill_96762_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，造成等同于未被格挡伤害 50% 的<BleedingIconKeywords:出血>，每层「<Chaos:混乱>」攻击次数降低 1 。"
  },
  Skill_96762_Name = {
    Text = "骸骨利刃"
  },
  Skill_96787_Desc = {
    Text = "杜勒赛因张开的暂未完成的法阵，能够为你提供一定的防护，但未格挡的伤害会同等传导到法阵之上，回复生命时会回复 33% 的完好度。永久保留。当前完好度：[Arg2]/[Arg3]（[Arg1]%）。「溟梦之帷」完成回合数： [Arg4]/3。"
  },
  Skill_96787_Name = {
    Text = "溟梦之帷"
  },
  Skill_97107_Desc_1 = {
    Text = "<DelayKeywords:延迟 1>：获得 [Arg1] 点无视上限的算力。"
  },
  Skill_97107_Name_1 = {
    Text = "不落的太阳"
  },
  Skill_97107_UnknownName = {
    Text = "不落的太阳"
  },
  Skill_97108_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」获得 [Arg1] 算力，「技能」伤害提高 [Arg2]%。"
  },
  Skill_97108_Name_1 = {
    Text = "迫近的太阳"
  },
  Skill_97109_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」每需要消耗 1 算力伤害提高 [Arg1]%。造成击杀后「狂气爆发」造成伤害提高 [Arg2]%。"
  },
  Skill_97109_Name_1 = {
    Text = "琥珀色的死亡"
  },
  Skill_97159_Desc = {
    Text = "自身死亡，为生命最高友方提高 [Arg1] 点<PowerIconKeywords:力量>，并使其提高等同于自身当前生命值两倍的最大生命（[Arg2] ）。"
  },
  Skill_97159_Name = {Text = "被吞食"},
  Skill_97318_Desc = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>。"
  },
  Skill_97318_Name = {
    Text = "永夜欢宴"
  },
  Skill_97319_Desc = {
    Text = "对所有敌人造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，打出后会使本回合后续打出的「永夜欢宴」额外享受 100% 力量加成。"
  },
  Skill_97319_Name = {
    Text = "永夜欢宴"
  },
  Skill_97911_AwakerSkillBackgroundStory = {
    Text = "她十分随意的开枪射击，并不在意弹药是否命中。\n「狩猎开始，先热热身吧。」"
  },
  Skill_97911_BattleDesc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_97911_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。凯蒂古拉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_97911_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_97911_Name = {Text = "打击"},
  Skill_97911_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_97912_AwakerSkillBackgroundStory = {
    Text = "火与光置换了世界，你的眼中只剩下无尽耀光。你无法思考，无法理解，你不明白世界为何消失了。直至一切被蒸发至虚无的最后一刻，你才意识到，那是太阳爆发时，最闪耀的色彩。"
  },
  Skill_97912_BattleDesc_0 = {
    Text = "<DerivativeCardKeywords_117:>对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]％ 力量加成。"
  },
  Skill_97912_BattleDesc_2 = {
    Text = "<DerivativeCardKeywords_117:>对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]％ 力量加成，拥有 3 层「<HuoyanKeywords4:活焰>」时造成的基础伤害提高 50％。"
  },
  Skill_97912_Desc_0 = {
    Text = "<DerivativeCardKeywords_117:>对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]％ 力量加成。"
  },
  Skill_97912_Desc_2 = {
    Text = "<DerivativeCardKeywords_117:>对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，享受 [Arg2]％ 力量加成，拥有 3 层「<HuoyanKeywords:活焰>」时造成的基础伤害提高 50％。"
  },
  Skill_97912_EffectNameList = {Text = "伤害"},
  Skill_97912_Name = {
    Text = "千兆耀斑"
  },
  Skill_97912_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_97913_AwakerSkillBackgroundStory = {
    Text = "这是来自末路的预告，它会带你迎接死亡的终末。你自可以拒绝死神的邀请，但在这之后，你将看到世上最璀璨的耀光。"
  },
  Skill_97913_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_97913_BattleDesc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次，获得 [Power:Arg4] 点<PowerIconKeywords:力量>，拥有 3 层<HuoyanKeywords4:活焰>时额外获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_97913_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次，获得 [Power:Arg2] 点<PowerIconKeywords:力量>。"
  },
  Skill_97913_Desc_2 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 2 次，获得 [Power:Arg4] 点<PowerIconKeywords:力量>，拥有 3 层<HuoyanKeywords:活焰>时额外获得 [Power:Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_97913_EffectNameList = {
    Text = "伤害,力量"
  },
  Skill_97913_Name = {
    Text = "末路枪声"
  },
  Skill_97913_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_97914_AwakerSkillBackgroundStory = {
    Text = "弹药、刀剑、邪法……无论是从何处发出的攻击，只要在到来前将其载体烧毁，就是最好的防御。"
  },
  Skill_97914_BattleDesc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_97914_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。凯蒂古拉获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_97914_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_97914_Name = {Text = "防御"},
  Skill_97914_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_97915_AwakerSkillBackgroundStory = {
    Text = "灼热的火焰再次燃起，覆盖全身的瘢痕开始闪烁耀眼的白光。\n「来吧，玩闹时间结束了，该开始第二回合了。」"
  },
  Skill_97915_BattleDesc_0 = {
    Text = "凯蒂古拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时额外为手中 1 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords4:活焰>。打出赋予 3 层<HuoyanKeywords4:活焰>的指令卡后使其返回手中。"
  },
  Skill_97915_BattleDesc_15 = {
    Text = "凯蒂古拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时额外为手中 1 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords4:活焰>。打出赋予 3 层<HuoyanKeywords4:活焰>的指令卡后使其返回手中。凯蒂古拉每层「活焰」的最终伤害和力量效果 +30%。"
  },
  Skill_97915_Desc_0 = {
    Text = "凯蒂古拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时额外为手中 1 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords:活焰>。打出赋予 3 层<HuoyanKeywords:活焰>的指令卡后使其返回手中。"
  },
  Skill_97915_Desc_15 = {
    Text = "凯蒂古拉获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：回合开始时额外为手中 1 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords:活焰>。打出赋予 3 层<HuoyanKeywords:活焰>的指令卡后使其返回手中。凯蒂古拉每层「活焰」的最终伤害和力量效果 +30%。"
  },
  Skill_97915_EffectNameList = {Text = "狂气"},
  Skill_97915_Name = {
    Text = "业火重燃"
  },
  Skill_97915_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_97916_BattleDesc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，每消耗 1 点算力额外享受 150% 力量加成。消耗所有「爆炎」，每层额外享受 50％ 力量加成(当前共享受 [Arg2]％ 力量加成)。打出后将所有「亿兆耀斑」还原为「千兆耀斑」。"
  },
  Skill_97916_Desc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点伤害，每消耗 1 点算力额外享受 150% 力量加成。消耗所有「爆炎」，每层额外享受 50％ 力量加成。打出后将所有「亿兆耀斑」还原为「千兆耀斑」。"
  },
  Skill_97916_EffectNameList = {Text = "伤害"},
  Skill_97916_Name = {
    Text = "亿兆耀斑"
  },
  Skill_97916_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_97917_Desc = {
    Text = "获得 1 点算力和 [Arg1]％ 临时强效。若凯蒂古拉在队伍中，抽 1 张其「指令卡」并赋予 1 层「<HuoyanKeywords:活焰>」"
  },
  Skill_97917_Name = {
    Text = "不落的太阳"
  },
  Skill_97918_AwakerSkillBackgroundStory = {
    Text = "祂的使者鱼贯而出，狂舞着挥洒琥珀色的火焰。这是祂的力量，祂的意志，祂的权责，祂的火将覆盖天地，将世界焚烧殆尽。"
  },
  Skill_97918_BattleDesc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，享受 [Arg2]％ 力量加成。抽 2 张凯蒂古拉的「指令卡」，为手中 3 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords4:活焰>。"
  },
  Skill_97918_Desc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害>，享受 [Arg2]％ 力量加成。抽 2 张凯蒂古拉的「指令卡」，为手中 3 张凯蒂古拉的「指令卡」赋予 1 层<HuoyanKeywords:活焰>。"
  },
  Skill_97918_EffectNameList = {Text = "伤害"},
  Skill_97918_Name = {
    Text = "焚却世界的爆炎"
  },
  Skill_97918_OverLimitUtlSkillDesc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点<PunctureDamagewords:穿刺伤害> 3 次，享受 [Arg2]％ 力量加成。抽 2 张凯蒂古拉的「指令卡」，随机为手中凯蒂古拉的指令卡分配 5 层<HuoyanKeywords4:活焰>。"
  },
  Skill_97918_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_97919_BattleDesc = {
    Text = "选择 1 名唤醒体，将 1 张算力消耗为 0 的临时「打击」置入手中。每第 3 次释放，改为将 1 张「美丽瞬间」置入手中，并使所有唤醒体临时暴击率提高 [Arg1]％(当前已释放 [Arg2] 次)。"
  },
  Skill_97919_Desc = {
    Text = "选择 1 名唤醒体，将 1 张算力消耗为 0 的临时「打击」置入手中。每第 3 次释放，改为将 1 张「美丽瞬间」置入手中，并使所有唤醒体临时暴击率提高 [Arg1]％。"
  },
  Skill_97919_Name = {
    Text = "定格的仲夏留念"
  },
  Skill_98057_Desc = {
    Text = "获得「震怒」、12 层「困意」以及 [Arg1] 点触腕伤害。"
  },
  Skill_98057_Name = {
    Text = "不朽威仪"
  },
  Skill_98119_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [Arg2] 次。获得 [Arg3] 点<PowerIconKeywords:力量>。"
  },
  Skill_98119_Name = {
    Text = "末路枪声"
  },
  Skill_98120_Desc = {
    Text = "切换到该意图时弃置所有剩余手牌并赋予<BurningKeywords:燃烧>。对方回合开始后随机<BurningKeywords:燃烧> [Arg1] 张手牌。"
  },
  Skill_98120_Name = {
    Text = "业火重燃"
  },
  Skill_98121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，随机<BurningKeywords:燃烧> [Arg3] 张抽牌堆或弃牌堆的卡牌，造成 [Arg4] 层<VulnerabilityIconKeywords:易伤>。"
  },
  Skill_98121_Name = {
    Text = "千兆耀斑"
  },
  Skill_98126_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，额外受到 [Arg3] 倍<PowerIconKeywords:力量>和<ExhaustionIconKeywords:力量降低>影响。清除所有<MonsterExFlameKeywords:爆炎>，每层提高 [Arg4] <PowerIconKeywords:力量>。"
  },
  Skill_98126_Name = {
    Text = "亿兆耀斑"
  },
  Skill_98127_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，<BurningKeywords:燃烧>对方所有剩余手牌，每有 1 张获得 1 层<MonsterExFlameKeywords:爆炎>。"
  },
  Skill_98127_Name = {
    Text = "焚却世界的爆炎"
  },
  Skill_98195_Desc_1 = {
    Text = "抽 2 张算力消耗最低的「技能」。"
  },
  Skill_98195_Name_1 = {
    Text = "定格的仲夏留念"
  },
  Skill_98195_UnknownName = {
    Text = "定格的仲夏留念"
  },
  Skill_98313_Desc = {
    Text = "减少80层"
  },
  Skill_98313_Name = {
    Text = "减少80层"
  },
  Skill_98315_Desc = {Text = "100死抗"},
  Skill_98315_Name = {Text = "100死抗"},
  Skill_98317_Desc = {
    Text = "若记录了 2 种不同的「<PrimaryColor:原色>」，会带来持续增益效果。"
  },
  Skill_98317_Name = {
    Text = "异象调色盘"
  },
  Skill_98332_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。"
  },
  Skill_98332_Name = {
    Text = "<Blue:原色·蓝>"
  },
  Skill_98333_Desc = {
    Text = "使所有唤醒体获得 <Energy:8> 点狂气。"
  },
  Skill_98333_Name = {
    Text = "<Yellow:原色·黄>"
  },
  Skill_98334_Desc = {
    Text = "获得 [Power:Arg1] 点<PowerIconKeywords:临时力量>，本回合中造成的最终伤害提高 10%。"
  },
  Skill_98334_Name = {
    Text = "<Red:原色·红>"
  },
  Skill_98508_Desc = {
    Text = "获得 3 点算力，使手中的所有指令卡获得<BurningKeywords:燃烧>，本回合打出<BurningKeywords:燃烧>的卡牌后消耗 1 层<Heat:深暗之焰>使其生效 2 次，回合结束后清空<Heat:深暗之焰>。"
  },
  Skill_98508_Name = {
    Text = "无尽的爆炎"
  },
  Skill_98704_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等同于伤害 [Arg3]% 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_98704_Name = {
    Text = "苍白回旋"
  },
  Skill_98705_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，额外造成敌方中毒层数 [Arg3]%的伤害。"
  },
  Skill_98705_Name = {Text = "打击"},
  Skill_98706_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 点 <PowerIconKeywords:力量>。"
  },
  Skill_98706_Name = {
    Text = "苍白的庇佑"
  },
  Skill_98707_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 点 <PowerIconKeywords:力量>，对抽牌堆顶部的 [Arg3] 张卡牌施加 [Arg4] 层迟缓。"
  },
  Skill_98707_Name = {
    Text = "不耐的施舍"
  },
  Skill_98729_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，对抽牌堆顶部的 [Arg2] 张卡牌施加 [Arg3] 层迟缓。"
  },
  Skill_98729_Name = {
    Text = "不耐的施舍"
  },
  Skill_98730_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，施加等同于伤害 [Arg3]% 的<IntoxicationIconKeywords:中毒>。"
  },
  Skill_98730_Name = {
    Text = "苍白回旋"
  },
  Skill_98731_Desc = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾，获得 [Arg2] 点 <PowerIconKeywords:力量>，获得 [Arg3] 点<AlertIconKeywords:戒备>。"
  },
  Skill_98731_Name = {
    Text = "苍白的庇佑"
  },
  Skill_98744_Desc = {
    Text = "获得「僭越者」，施加的中毒提高 100%，每个回合结束后获得 <Block:[Block:Arg1]> 护盾。"
  },
  Skill_98744_Name = {
    Text = "迷途之旅"
  },
  Skill_98984_AwakerSkillBackgroundStory = {
    Text = "别畏惧我的凝视，走向我吧，靠近我吧……\n在画笔创造出的瑰丽幻境中，让我赋予你至高无上的美。"
  },
  Skill_98984_Desc_0 = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 张指令卡算力消耗- 2。】获得 [Power:Arg1] 点<PowerIconKeywords:力量> 。本回合其他唤醒体狂气爆发造成的最终伤害、护盾、生命回复提高 [Arg2]％。<FaxianKeywords:发现> 3 张具有<Chuanggoukeyin:创构的刻印>的出战唤醒体的「技能」，选择 1 张置入手中并为其赋予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_Desc_2 = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 张指令卡算力消耗 -2。】获得 [Power:Arg1] 点<PowerIconKeywords:力量> 。本回合其他唤醒体狂气爆发造成的最终伤害、护盾、生命回复提高 [Arg2]％。<FaxianKeywords:发现> 3 张具有<Chuanggoukeyin:创构的刻印>的出战唤醒体的「技能」，选择 1 张置入手中并为其赋予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_EffectNameList = {Text = "力量"},
  Skill_98984_Name = {
    Text = "真实，亦是幻想"
  },
  Skill_98984_OverLimitUtlSkillDesc = {
    Text = "【<DevouredIconKeywords:吞噬> ：本回合打出的下 1 张指令卡算力消耗- 2。】获得 [Power:Arg1] 点<PowerIconKeywords:力量> 。本回合其他唤醒体狂气爆发造成的最终伤害、护盾、生命回复提高 [Arg2]％。获得 1 层<Kuangxiang:狂想>，<FaxianKeywords:发现> 3 张具有<Chuanggoukeyin:创构的高级刻印>的出战唤醒体的「技能」2 次，选择 1 张置入手中并为其赋予<DepleteIconKeywords:消耗>和<RetainIconKeywords:保留>。"
  },
  Skill_98984_PropertyNameList = {
    Text = "攻击力*GrowValue1"
  },
  Skill_98985_AwakerSkillBackgroundStory = {
    Text = "尸骸的残影在皮克曼的指尖游走，不愿受驯服灵感在画布上狂舞。\n平凡的画家将现实的表象描摹，而真正的艺术家挥洒着癫狂，将一切不为人知的喜悦、痛苦、渴望与丑陋勾勒。"
  },
  Skill_98985_Desc_0 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+ [Arg1]，移除<EmptinessKeywords: 空虚>状态。<FaxianKeywords:发现> 3 个<Chuanggouzaowu:创构的白银造物>并选择一个获得，该造物持续 [Arg2] 回合。"
  },
  Skill_98985_Desc_2 = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>+ [Arg1]，移除<EmptinessKeywords: 空虚>状态。<FaxianKeywords:发现> 3 个<Chuanggouzaowu:创构的黄金造物>并选择一个获得，该造物持续 [Arg2] 回合。"
  },
  Skill_98985_EffectNameList = {
    Text = "胚胎融合"
  },
  Skill_98985_Name = {
    Text = "绘影摹形"
  },
  Skill_98985_PropertyNameList = {
    Text = "$GrowValue1"
  },
  Skill_98986_AwakerSkillBackgroundStory = {
    Text = "这是对艺术的亵渎！休想以狭隘的偏见玷污我的艺术。"
  },
  Skill_98986_BattleDesc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_98986_BattleDesc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。获得 <Energy:[Energy:Arg2]> 点狂气。随机抽取 1 张「技能」，每回合至多生效 1 次(当前生效 [Arg3] /1 次)。"
  },
  Skill_98986_Desc_0 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。皮克曼获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_98986_Desc_1 = {
    Text = "获得 <Block:[Block:Arg1]> 点护盾。皮克曼获得 <Energy:[Energy:Arg2]> 点狂气。随机抽取 1 张「技能」，每回合至多生效 1 次。"
  },
  Skill_98986_EffectNameList = {
    Text = "护盾,狂气"
  },
  Skill_98986_Name = {Text = "防御"},
  Skill_98986_PropertyNameList = {
    Text = "防御力*GrowValue1,$GrowValue2"
  },
  Skill_98987_Desc = {
    Text = "消耗 1 层「<Kuangxiang:狂想>」，选择所有<FaxianKeywords:发现>效果。获得 1 层<Chuangyi:创意>。"
  },
  Skill_98987_Name = {
    Text = "灵感迸发！"
  },
  Skill_98988_AwakerSkillBackgroundStory = {
    Text = "你为何如此抗拒美？\n来吧，亲爱的模特，感受我的创作。"
  },
  Skill_98988_BattleDesc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_98988_BattleDesc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。获得 <Energy:[Energy:Arg2]> 点狂气。随机抽取 1 张「技能」，每回合至多生效 1 次(当前生效 [Arg3] /1 次)。"
  },
  Skill_98988_Desc_0 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。皮克曼获得 <Energy:[Energy:Arg2]> 点狂气。"
  },
  Skill_98988_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害。皮克曼获得 <Energy:[Energy:Arg2]> 点狂气。随机抽取 1 张「技能」，每回合至多生效 1 次。"
  },
  Skill_98988_EffectNameList = {
    Text = "伤害,狂气"
  },
  Skill_98988_Name = {Text = "打击"},
  Skill_98988_PropertyNameList = {
    Text = "攻击力*GrowValue1,$GrowValue2"
  },
  Skill_98989_AwakerSkillBackgroundStory = {
    Text = "静谧幽深的墓园，尸体如雕塑般被陈列于其间，成为别样的模特，带着死亡的沉默与神秘，激发了绘者无尽的灵感。\n僵硬的姿态、苍白的肌肤、扭曲的表情……皮克曼在阴影与腐朽中寻觅美的可能。"
  },
  Skill_98989_Desc_0 = {
    Text = "皮克曼获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 层<Kuangxiang:狂想>。皮克曼每获得 1 层<Chuangyi:创意>，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg2]。"
  },
  Skill_98989_Desc_15 = {
    Text = "皮克曼获得 <Energy:[Energy:Arg1]> 点狂气。<ExaltIconKeywords:灵知觉醒>：获得 1 层<Kuangxiang:狂想>。皮克曼每获得 1 层<Chuangyi:创意>，<EmbryoFusionIconKeywords:胚胎融合>+ [Arg2]。「绘影摹形」创构的黄金造物持续回合数由 1 回合提高为 2 回合。"
  },
  Skill_98989_EffectNameList = {
    Text = "狂气,胚胎融合"
  },
  Skill_98989_Name = {
    Text = "墓园画室"
  },
  Skill_98989_PropertyNameList = {
    Text = "$GrowValue1,$GrowValue2"
  },
  Skill_98990_AwakerSkillBackgroundStory = {
    Text = "你可曾见过真正的色彩？\n不是温顺的颜料，而是侵略性的、渗透骨髓的疯狂。\n每一抹色泽都带来蚀骨的颤栗与狂喜，那才是绘者所寻求的至美。"
  },
  Skill_98990_BattleDesc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害 [Arg3] 次，每造成 1 次伤害临时降低目标 [Exhaustion:Arg2] 点<ExhaustionIconKeywords:力量>并获得 [Power:Arg2] 点<PowerIconKeywords:临时力量>。本回合每触发过 1 次<FaxianKeywords:发现>效果，此卡牌基础算力消耗降低 1，若触发过「灵感迸发！」额外造成 2 次伤害。"
  },
  Skill_98990_Desc = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 点必定暴击的伤害 [Arg3] 次，每造成 1 次伤害<TouquKeywords:偷取>目标 [Arg2] 点<PowerIconKeywords:力量>。本回合每触发过 1 次<FaxianKeywords:发现>效果，此卡牌基础算力消耗降低 1，若触发过「灵感迸发！」额外造成 2 次伤害。"
  },
  Skill_98990_EffectNameList = {
    Text = "伤害,偷取力量"
  },
  Skill_98990_Name = {
    Text = "蚀骨色彩"
  },
  Skill_98990_PropertyNameList = {
    Text = "攻击力*GrowValue1,攻击力*GrowValue2"
  },
  Skill_99016_Desc = {
    Text = "消耗 1 层「<Kuangxiang:狂想>」，选择所有<FaxianKeywords:发现>效果。获得 1 层<Chuangyi:创意>。"
  },
  Skill_99016_Name = {
    Text = "灵感迸发！"
  },
  Skill_99035_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<PVPMethysisKeywords:中毒>。"
  },
  Skill_99035_Name_1 = {
    Text = "幻梦绘生"
  },
  Skill_99036_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后随机将 1 张装备者的「技能」置入手牌并使其算力消耗变为 0。"
  },
  Skill_99036_Name_1 = {
    Text = "写实主义悖谬"
  },
  Skill_99037_Desc_1 = {
    Text = "随机触发以下效果 3 次：对随机敌人造成 [Arg1] 伤害，<DisarmKeywords:麻痹>、对随机敌人造成 [Arg1] 伤害，<PVPMethysisKeywords:中毒>、对所有敌人造成 [Arg1] 伤害。"
  },
  Skill_99037_Name_1 = {
    Text = "虚世之彩"
  },
  Skill_99037_UnknownName = {
    Text = "虚世之彩"
  },
  Skill_99038_Desc_1 = {
    Text = "造成 <Damage:[Damage:Arg1]> 伤害，<DisarmKeywords:麻痹>。"
  },
  Skill_99038_Name_1 = {
    Text = "实色侵染"
  },
  Skill_99039_Desc_1 = {
    Text = "对全体敌方造成 <Damage:[Damage:Arg1]> 伤害。"
  },
  Skill_99039_Name_1 = {
    Text = "大放异彩"
  },
  Skill_99040_Desc_1 = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方每回合首次「狂气爆发」后抽 1 张牌。"
  },
  Skill_99040_Name_1 = {
    Text = "渴求的画笔"
  },
  Skill_99041_Desc_1 = {
    Text = "将自身三张不同的算力消耗为 [Arg1] 的「技能」置入手牌，<StrongEffectKeywords:强效> +[Arg2]。"
  },
  Skill_99041_Name_1 = {
    Text = "真实，亦是幻想"
  },
  Skill_99042_Desc_1 = {
    Text = "对前排敌方造成 <Damage:[Damage:Arg1]> 伤害，获得 <Energy:[Energy:Arg2]> 狂气。"
  },
  Skill_99042_Name_1 = {Text = "打击"},
  Skill_99115_Desc = {
    Text = "「绘者」转换成食尸鬼形态，获得 [Arg1] 点<PowerIconKeywords:力量>，对玩家抽牌堆和弃牌堆中 [Arg2] 张牌施加<ErosionColorInkKeywords:认知错乱>。"
  },
  Skill_99115_Name = {
    Text = "墓园画室"
  },
  Skill_99116_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg4] 点<PowerIconKeywords:力量>。本回合每打出 1 张<ErosionColorInkKeywords:认知错乱>卡牌就使「绘者」降低 [Arg3] 点<PowerIconKeywords:临时力量>。"
  },
  Skill_99116_Name = {
    Text = "真实，亦是幻想"
  },
  Skill_99117_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害 [AttackTimes:Arg2] 次，获得 [Arg5] 点<PowerIconKeywords:力量>。切换到该意图时，玩家每持有 1 张<ErosionColorInkKeywords:认知错乱>卡牌就使「绘者」获得 [Arg3] 点<PowerIconKeywords:力量>。本回合每打出 1 张<ErosionColorInkKeywords:认知错乱>卡牌就使「绘者」降低 [Arg4] 点<PowerIconKeywords:临时力量>。"
  },
  Skill_99117_Name = {
    Text = "艺术，即为疯狂"
  },
  Skill_99118_Desc = {
    Text = "施加 [Arg1] 回合<VulnerabilityIconKeywords:易伤>，召唤 1 个「融蚀-追随者」与「融蚀-渴求者」。"
  },
  Skill_99118_Name = {
    Text = "绘影摹形"
  },
  Skill_99119_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，对玩家抽牌堆和弃牌堆中 [Arg2] 张牌施加<ErosionColorInkKeywords:认知错乱>。消耗所有<DecayDye:幻世染料>，每消耗 1 层伤害次数和<ErosionColorInkKeywords:认知错乱> 数提高 1。"
  },
  Skill_99119_Name = {
    Text = "蚀骨色彩"
  },
  Skill_99120_Desc = {
    Text = "施加 [Arg1] 回合<VulnerabilityIconKeywords:易伤>和<WeaknessIconKeywords:虚弱>，召唤 1 个「融蚀-诗中人」。"
  },
  Skill_99120_Name = {
    Text = "绘影摹形"
  },
  Skill_99121_Desc = {
    Text = "造成 <Damage:[Damage:Arg1]> 点伤害，对玩家抽牌堆和弃牌堆中 [Arg2] 张牌施加<ErosionColorInkKeywords:认知错乱>。消耗所有<DecayDye:幻世染料>，每消耗 1 层伤害次数和<ErosionColorInkKeywords:认知错乱> 数提高 1。"
  },
  Skill_99121_Name = {
    Text = "蚀骨色彩"
  }
})
return Text_Skill
