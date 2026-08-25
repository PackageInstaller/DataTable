__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_RelicConfig = readonly({
  RelicConfig_100300_BattleDesc = {
    Text = "战斗开始后获得 1 层「<MindWall:心灵壁垒>」，3 回合后将其转化为「<BarrierCrash:壁垒崩解>」。"
  },
  RelicConfig_100300_Desc = {
    Text = "战斗开始后获得 1 层「<MindWall:心灵壁垒>」，3 回合后将其转化为「<BarrierCrash:壁垒崩解>」。"
  },
  RelicConfig_100300_Name = {
    Text = "心灵剖析"
  },
  RelicConfig_100300_StoryDesc = {
    Text = "仔细看清楚你的心，不要做出错误的选择。"
  },
  RelicConfig_100399_BattleDesc = {
    Text = "触发 <DevouredIconKeywords:吞噬>效果后，其他唤醒体获得 [Arg1] 点狂气，每回合仅能生效 1 次。"
  },
  RelicConfig_100399_Desc = {
    Text = "触发 <DevouredIconKeywords:吞噬>效果后，其他唤醒体获得 [Arg1] 点狂气，每回合仅能生效 1 次。"
  },
  RelicConfig_100399_Name = {
    Text = "<OrangeQuality:创构的金色梦乡+>"
  },
  RelicConfig_100399_StoryDesc = {
    Text = "蜕变之日即是你的死期。"
  },
  RelicConfig_100400_BattleDesc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_100400_Desc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_100400_Name = {
    Text = "<OrangeQuality:创构的恩赐之血+>"
  },
  RelicConfig_100400_StoryDesc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  RelicConfig_100401_BattleDesc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_100401_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_100401_Name = {
    Text = "<OrangeQuality:创构的锈蚀钢锯+>"
  },
  RelicConfig_100401_StoryDesc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  RelicConfig_100402_BattleDesc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100402_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100402_Name = {
    Text = "<WhiteQuality:创构的春之祭>"
  },
  RelicConfig_100402_StoryDesc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  RelicConfig_100404_BattleDesc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_100404_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_100404_Name = {
    Text = "<WhiteQuality:创构的重锁>"
  },
  RelicConfig_100404_StoryDesc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  RelicConfig_100405_BattleDesc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100405_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100405_Name = {
    Text = "<WhiteQuality:创构的恶童>"
  },
  RelicConfig_100405_StoryDesc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  RelicConfig_100406_BattleDesc = {
    Text = "触发 <DevouredIconKeywords:吞噬>效果后，其他唤醒体获得 [Arg1] 点狂气，每回合仅能生效 1 次。"
  },
  RelicConfig_100406_Desc = {
    Text = "触发 <DevouredIconKeywords:吞噬>效果后，其他唤醒体获得 [Arg1] 点狂气，每回合仅能生效 1 次。"
  },
  RelicConfig_100406_Name = {
    Text = "<WhiteQuality:创构的金色梦乡>"
  },
  RelicConfig_100406_StoryDesc = {
    Text = "蜕变之日即是你的死期。"
  },
  RelicConfig_100407_BattleDesc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_100407_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_100407_Name = {
    Text = "<WhiteQuality:创构的缠丝玛瑙>"
  },
  RelicConfig_100407_StoryDesc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  RelicConfig_100408_BattleDesc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_100408_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_100408_Name = {
    Text = "<OrangeQuality:创构的重锁+>"
  },
  RelicConfig_100408_StoryDesc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  RelicConfig_100409_BattleDesc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100409_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100409_Name = {
    Text = "<OrangeQuality:创构的恶童+>"
  },
  RelicConfig_100409_StoryDesc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  RelicConfig_100410_BattleDesc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_100410_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_100410_Name = {
    Text = "<OrangeQuality:创构的缠丝玛瑙+>"
  },
  RelicConfig_100410_StoryDesc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  RelicConfig_100411_BattleDesc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100411_Desc = {
    Text = "拾取时对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_100411_Name = {
    Text = "<OrangeQuality:创构的春之祭+>"
  },
  RelicConfig_100411_StoryDesc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  RelicConfig_100412_BattleDesc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_100412_Desc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_100412_Name = {
    Text = "<WhiteQuality:创构的恩赐之血>"
  },
  RelicConfig_100412_StoryDesc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  RelicConfig_100413_BattleDesc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_100413_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_100413_Name = {
    Text = "<WhiteQuality:创构的锈蚀钢锯>"
  },
  RelicConfig_100413_StoryDesc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  RelicConfig_100539_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100539_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100539_Name = {
    Text = "<WhiteQuality:创构的染血鹅卵石>"
  },
  RelicConfig_100539_StoryDesc = {
    Text = "一、二、三、四、五。"
  },
  RelicConfig_100540_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100540_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_100540_Name = {
    Text = "<OrangeQuality:创构的染血鹅卵石+>"
  },
  RelicConfig_100540_StoryDesc = {
    Text = "一、二、三、四、五。"
  },
  RelicConfig_116382_BattleDesc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116382_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116382_Name = {
    Text = "锈蚀钥匙"
  },
  RelicConfig_116383_BattleDesc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116383_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116383_Name = {
    Text = "锈蚀钥匙"
  },
  RelicConfig_116384_BattleDesc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116384_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_116384_Name = {
    Text = "锈蚀钥匙"
  },
  RelicConfig_119371_BattleDesc = {
    Text = "手牌上限 +1 。\n回合开始时，若未完成所有仪式，获得最大生命 10% 的 <SacrificeKeyWord:献祭>。将 1 张「<DerivativeCardKeywords_119:敬献神明>」置入手中，至多持有 1 张。"
  },
  RelicConfig_119371_Desc = {
    Text = "手牌上限 +1 。\n回合开始时，若未完成所有仪式，获得最大生命 10% 的 <SacrificeKeyWord:献祭>。将 1 张「<DerivativeCardKeywords_119:敬献神明>」置入手中，至多持有 1 张。"
  },
  RelicConfig_119371_Name = {
    Text = "黄铜香炉"
  },
  RelicConfig_119371_StoryDesc = {
    Text = "「仿照利莫里亚工艺打造了这枚香炉，愿它能助您夜夜安寝。弥利亚姆留。」"
  },
  RelicConfig_120372_BattleDesc = {
    Text = "手牌上限+[Arg1]。回合开始时，将 [Arg2] 张「<PVPDerivativeCardKeywords_11:不平等交换>」置入手牌。"
  },
  RelicConfig_120372_Desc = {
    Text = "手牌上限+[Arg1]。回合开始时，将 [Arg2] 张「<PVPDerivativeCardKeywords_11:不平等交换>」置入手牌。"
  },
  RelicConfig_120372_Name = {
    Text = "<OrangeQuality:万花筒>"
  },
  RelicConfig_120373_BattleDesc = {
    Text = "打出的前 [Arg1] 张「<PVPWeaponKeywords:命轮>」算力消耗-5/-3/-1/+1，抽 1 张牌。"
  },
  RelicConfig_120373_Desc = {
    Text = "打出的前 [Arg1] 张「<PVPWeaponKeywords:命轮>」算力消耗-5/-3/-1/+1，抽 1 张牌。"
  },
  RelicConfig_120373_Name = {
    Text = "<OrangeQuality:弥萨格徽章>"
  },
  RelicConfig_121214_BattleDesc = {
    Text = "免疫伤害"
  },
  RelicConfig_121214_Desc = {
    Text = "免疫伤害"
  },
  RelicConfig_121214_Name = {
    Text = "无敌测试造物"
  },
  RelicConfig_121689_BattleDesc = {
    Text = "造成的最终伤害提高 250%，每造成 1 次伤害降低 50%， 并使造成的护盾提高 10%，至多触发 5 次，每回合开始后重置。"
  },
  RelicConfig_121689_Desc = {
    Text = "造成的最终伤害提高 250%，每造成 1 次伤害降低 50%， 并使造成的护盾提高 10%，至多触发 5 次，每回合开始后重置。"
  },
  RelicConfig_121689_Name = {
    Text = "<OrangeQuality:「纯银的归途· 诞临」>"
  },
  RelicConfig_121690_BattleDesc = {
    Text = "战斗开始，选择 3 张卡牌使它们获得「<RippleKeywords:余波>：抽一张牌，获得 [Arg3] 点临时<PowerIconKeywords:力量>」。回合开始时抽取 2 张附带<RippleKeywords:余波>的卡牌，所有<RippleKeywords:余波>效果额外触发一次，在触发 10 次<RippleKeywords:余波>后，将 1 张<DerivativeCardKeywords_1:遗影回响>置入手中。"
  },
  RelicConfig_121690_Desc = {
    Text = "战斗开始，选择 3 张卡牌使它们获得「<RippleKeywords:余波>：抽一张牌，获得 [Arg3] 点临时<PowerIconKeywords:力量>」。回合开始时抽取 2 张附带<RippleKeywords:余波>的卡牌，所有<RippleKeywords:余波>效果额外触发一次，在触发 10 次<RippleKeywords:余波>后，将 1 张<DerivativeCardKeywords_1:遗影回响>置入手中。"
  },
  RelicConfig_121690_Name = {
    Text = "<OrangeQuality:「纯银的归途· 疯狂」>"
  },
  RelicConfig_121691_BattleDesc = {
    Text = "所有唤醒体狂气爆发最终伤害提高 100%，每次唤醒体当释放狂气爆发后，获得其 500% 基础狂气的银钥能量，所有唤醒体基础狂气降低 20点，最多降低 5 次。"
  },
  RelicConfig_121691_Desc = {
    Text = "所有唤醒体狂气爆发最终伤害提高 100%，每次唤醒体当释放狂气爆发后，获得其 500% 基础狂气的银钥能量，所有唤醒体基础狂气降低 20点，最多降低 5 次。"
  },
  RelicConfig_121691_Name = {
    Text = "<OrangeQuality:「纯银的归途· 恐惧」>"
  },
  RelicConfig_121692_BattleDesc = {
    Text = "所有唤醒体造成的<RetaliateIconKeywords:反击>、<IntoxicationIconKeywords: 中毒>、护盾和生命回复提高 50%。回合结束时，获得当前护盾 500%的临时<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_121692_Desc = {
    Text = "所有唤醒体造成的<RetaliateIconKeywords:反击>、<IntoxicationIconKeywords: 中毒>、护盾和生命回复提高 50%。回合结束时，获得当前护盾 500%的临时<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_121692_Name = {
    Text = "<OrangeQuality:「纯银的归途· 邪信」>"
  },
  RelicConfig_121693_BattleDesc = {
    Text = "手牌上限 +5 。回合开始时抽 2 张牌，获取 2 点算力。每次重置牌库时，获得 [Arg3] 点<PowerIconKeywords:力量>与 [Arg4] 点临时<AlertIconKeywords:戒备>，生成狂气最高唤醒体每种非衍生指令卡各 1 张并置入抽牌堆，使它们的算力消耗降低 1 点。"
  },
  RelicConfig_121693_Desc = {
    Text = "手牌上限 +5 。回合开始时抽 2 张牌，获取 2 点算力。每次重置牌库时，获得 [Arg3] 点<PowerIconKeywords:力量>与 [Arg4] 点临时<AlertIconKeywords:戒备>，生成狂气最高唤醒体每种非衍生指令卡各 1 张并置入抽牌堆，使它们的算力消耗降低 1 点。"
  },
  RelicConfig_121693_Name = {
    Text = "<OrangeQuality:「纯银的归途· 刺骨」>"
  },
  RelicConfig_121694_BattleDesc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 25 点狂气并将一张<DerivativeCardKeywords_4:灵感>置入手牌。每释放 4 次「狂气爆发」后，解除所有唤醒体的<Seal:封印>状态，并使所有唤醒体获得 50 点狂气。"
  },
  RelicConfig_121694_Desc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 25 点狂气并将一张<DerivativeCardKeywords_4:灵感>置入手牌。每释放 4 次「狂气爆发」后，解除所有唤醒体的<Seal:封印>状态，并使所有唤醒体获得 50 点狂气。"
  },
  RelicConfig_121694_Name = {
    Text = "<OrangeQuality:「纯银的归途· 诡谲」>"
  },
  RelicConfig_121695_BattleDesc = {
    Text = "战斗开始时，获得 [Arg4] 点<PowerIconKeywords:力量>，银钥能量存储上限+100％。每点算力消耗时获得的银钥能量提高 100%，使用银钥觉醒或释放钥令后，获得等同于当前<PowerIconKeywords:力量> 20%的临时<PowerIconKeywords:力量>并使所有唤醒体获得 20 点狂气。"
  },
  RelicConfig_121695_Desc = {
    Text = "战斗开始时，获得 [Arg4] 点<PowerIconKeywords:力量>，银钥能量存储上限+100％。每点算力消耗时获得的银钥能量提高 100%，使用银钥觉醒或释放钥令后，获得等同于当前<PowerIconKeywords:力量> 20%的临时<PowerIconKeywords:力量>并使所有唤醒体获得 20 点狂气。"
  },
  RelicConfig_121695_Name = {
    Text = "<OrangeQuality:「纯银的归途· 悲泣」>"
  },
  RelicConfig_122625_BattleDesc = {
    Text = "战斗开始后，将 [Arg1] 张「<PVPDerivativeCardKeywords_25:茜尔维娅的红茶>」置入手牌。"
  },
  RelicConfig_122625_Desc = {
    Text = "战斗开始后，将 [Arg1] 张「<PVPDerivativeCardKeywords_25:茜尔维娅的红茶>」置入手牌。"
  },
  RelicConfig_122625_Name = {
    Text = "<OrangeQuality:锡兰红茶>"
  },
  RelicConfig_122626_BattleDesc = {
    Text = "在每轮抽牌堆内置入 [Arg1] 张「<PVPDerivativeCardKeywords_14:现实模仿>」，所属者为随机唤醒体。"
  },
  RelicConfig_122626_Desc = {
    Text = "在每轮抽牌堆内置入 [Arg1] 张「<PVPDerivativeCardKeywords_14:现实模仿>」，所属者为随机唤醒体。"
  },
  RelicConfig_122626_Name = {
    Text = "<OrangeQuality:魔术手套>"
  },
  RelicConfig_122627_BattleDesc = {
    Text = "每回合首个打出的「技能」伤害、治疗与护盾提高 [Arg1]% 。"
  },
  RelicConfig_122627_Desc = {
    Text = "每回合首个打出的「技能」伤害、治疗与护盾提高 [Arg1]% 。"
  },
  RelicConfig_122627_Name = {
    Text = "<OrangeQuality:红宝石胸针>"
  },
  RelicConfig_122628_BattleDesc = {
    Text = "回合结束后，额外获得 <Energy:[Arg1]> 狂气。"
  },
  RelicConfig_122628_Desc = {
    Text = "回合结束后，额外获得 <Energy:[Arg1]> 狂气。"
  },
  RelicConfig_122628_Name = {
    Text = "<OrangeQuality:噩梦表象>"
  },
  RelicConfig_122629_BattleDesc = {
    Text = "抽牌堆里会有双倍的唤醒体卡牌。打出卡牌后，手牌数在本回合首次小于 [Arg1] 则抽 [Arg2] 牌。"
  },
  RelicConfig_122629_Desc = {
    Text = "抽牌堆里会有双倍的唤醒体卡牌。打出卡牌后，手牌数在本回合首次小于 [Arg1] 则抽 [Arg2] 牌。"
  },
  RelicConfig_122629_Name = {
    Text = "<OrangeQuality:快乐唱片>"
  },
  RelicConfig_122630_BattleDesc = {
    Text = "手牌上限+[Arg1]。在每轮抽牌堆内置入 [Arg2] 张「<PVPDerivativeCardKeywords_13:不朽的葬仪>」。"
  },
  RelicConfig_122630_Desc = {
    Text = "手牌上限+[Arg1]。在每轮抽牌堆内置入 [Arg2] 张「<PVPDerivativeCardKeywords_13:不朽的葬仪>」。"
  },
  RelicConfig_122630_Name = {
    Text = "<OrangeQuality:遗落的祭祀刀>"
  },
  RelicConfig_122768_BattleDesc = {
    Text = "回合开始时抽 [Arg1] 张算力消耗 -1 的「打击」。释放狂气爆发后生成 [Arg2] 张具有<DepleteIconKeywords:消耗>、<PrepareKeypvewords:预备1>和<RetainIconKeywords:保留>的对应唤醒体的「打击」。\n在 1 回合内每打出 [Arg3] 张「打击」，获得 [Arg4] 点临时<PowerIconKeywords:力量>；打出 [Arg5] 张「打击」后抽 [Arg6] 张牌并获得 [Arg7] 点算力；打出 [Arg8] 张「打击」后所有唤醒体获得 [Arg9] 点狂气。"
  },
  RelicConfig_122768_Desc = {
    Text = "回合开始时抽 [Arg1] 张算力消耗 -1 的「打击」。释放狂气爆发后生成 [Arg2] 张具有<DepleteIconKeywords:消耗>、<PrepareKeypvewords:预备1>和<RetainIconKeywords:保留>的对应唤醒体的「打击」。\n在 1 回合内每打出 [Arg3] 张「打击」，获得 [Arg4] 点临时<PowerIconKeywords:力量>；打出 [Arg5] 张「打击」后抽 [Arg6] 张牌并获得 [Arg7] 点算力；打出 [Arg8] 张「打击」后所有唤醒体获得 [Arg9] 点狂气。"
  },
  RelicConfig_122768_Name = {
    Text = "彼世回声"
  },
  RelicConfig_122768_StoryDesc = {
    Text = "异世迷雾中夹杂的回音，通往扭曲、癫狂和不可质疑的真实。"
  },
  RelicConfig_123724_BattleDesc = {
    Text = "回合开始时茉夏获得 [Arg1] 点狂气，生成 1 张茉夏算力消耗为 0 的临时「打击」。每次触发「戏剧性邂逅」使「闪耀☆龙卷风」本场战斗造成的基础伤害和打击伤害提高效果提高 [Arg2]％。"
  },
  RelicConfig_123724_Desc = {
    Text = "回合开始时茉夏获得 [Arg1] 点狂气，生成 1 张茉夏算力消耗为 0 的临时「打击」。每次触发「戏剧性邂逅」使「闪耀☆龙卷风」本场战斗造成的基础伤害和打击伤害提高效果提高 [Arg2]％。"
  },
  RelicConfig_123724_Name = {
    Text = "<OrangeQuality:维度影像·茉夏>"
  },
  RelicConfig_125488_BattleDesc = {
    Text = "所有唤醒体每回合首次打出指令卡时，获得 [Arg1] 点狂气。1 回合内累计打出 4 张归属于不同唤醒体的指令卡后，向所有敌人施加 [Arg2]% 我方最大生命值的<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_125488_Desc = {
    Text = "所有唤醒体每回合首次打出指令卡时，获得 [Arg1] 点狂气。1 回合内累计打出 4 张归属于不同唤醒体的指令卡后，向所有敌人施加 [Arg2]% 我方最大生命值的<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_125488_Name = {
    Text = "姨娘的派头"
  },
  RelicConfig_125489_BattleDesc = {
    Text = "回合开始时徐获得 [Arg1] 狂气并对所有敌人施加 1 层<WitherKeywords:痴醉>。每回合打出的第一张徐的指令卡必定触发「共振」效果。"
  },
  RelicConfig_125489_Desc = {
    Text = "回合开始时徐获得 [Arg1] 狂气并对所有敌人施加 1 层<WitherKeywords:痴醉>。每回合打出的第一张徐的指令卡必定触发「共振」效果。"
  },
  RelicConfig_125489_Name = {
    Text = "<OrangeQuality:维度影像·徐>"
  },
  RelicConfig_126673_BattleDesc = {
    Text = "手牌上限 +3。记录每回合打出的前 3 张非衍生指令卡，并在 3 回合后的回合开始时将其算力消耗 -1 并具有<DepleteIconKeywords:消耗>的复制加入手牌。"
  },
  RelicConfig_126673_Desc = {
    Text = "手牌上限 +3。记录每回合打出的前 3 张非衍生指令卡，并在 3 回合后的回合开始时将其算力消耗 -1 并具有<DepleteIconKeywords:消耗>的复制加入手牌。"
  },
  RelicConfig_126673_Name = {
    Text = "命运纺轮"
  },
  RelicConfig_126673_StoryDesc = {
    Text = "命运流转，亘古不息。"
  },
  RelicConfig_129304_BattleDesc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。\n<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  RelicConfig_129304_Desc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 2 。\n<OrangeQuality:受祝仪式>：战胜第一、第二阶段的首领奖励变更为随机受祝造物 3 选 1。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。\n<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。\n<RedQuality:永夜长廊>：探索开始时，所有唤醒体的基础狂气与银钥能量上限提高 50%"
  },
  RelicConfig_129304_Name = {
    Text = "<OrangeQuality:小「N」的混乱相机>"
  },
  RelicConfig_129304_StoryDesc = {
    Text = "完蛋啦！相机彻底坏了！咦？怎么还能工作？等等！这些限制都是什么啊？！"
  },
  RelicConfig_129305_BattleDesc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。"
  },
  RelicConfig_129305_Desc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。"
  },
  RelicConfig_129305_Name = {
    Text = "<OrangeQuality:小「N」的完整相机>"
  },
  RelicConfig_129305_StoryDesc = {
    Text = "别看了，这就是相机！崭新出厂，童叟无欺。"
  },
  RelicConfig_129306_BattleDesc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 1 。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。\n<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。"
  },
  RelicConfig_129306_Desc = {
    Text = "<OrangeQuality:黄金调和>：「算力调和」带来的算力提高效果最大为 1 点，每拥有 1% 伤害强效则使得灵识研究深度效果提高 1%。\n<OrangeQuality:维度赠礼>：探索开始时，随机获得 1 个维度影像造物，手牌上限提高 1 。\n<RedQuality:长途倦意>：战斗中所有生命回复效果降低 50%，「褪色遗骨」选择「安葬」时变更为回复 25％ 最大生命。\n<RedQuality:眩晕征兆>：战斗开始时，所有唤醒体当前狂气与银钥能量降低 50%。"
  },
  RelicConfig_129306_Name = {
    Text = "<OrangeQuality:小「N」的破旧相机>"
  },
  RelicConfig_129306_StoryDesc = {
    Text = "完了！相机被打坏了！让我修一下看看……开机了！但是怎么感觉怪怪的……"
  },
  RelicConfig_131079_BattleDesc = {
    Text = "回合开始时莫丝获得 [Arg1] 狂气。每回合首次打出的「蓄力！」或「装填！」生效 2 次。"
  },
  RelicConfig_131079_Desc = {
    Text = "回合开始时莫丝获得 [Arg1] 狂气。每回合首次打出的「蓄力！」或「装填！」生效 2 次。"
  },
  RelicConfig_131079_Name = {
    Text = "<OrangeQuality:维度影像·莫丝>"
  },
  RelicConfig_131080_BattleDesc = {
    Text = "前 3 回合开始时，每回合触发 1 次「海獭困境」。第 5 回合开始时移除所有「海獭困境」的负面效果并获得「<DerivativeCardKeywords_135:二世冲击！>」。"
  },
  RelicConfig_131080_Desc = {
    Text = "前 3 回合开始时，每回合触发 1 次「海獭困境」。第 5 回合开始时移除所有「海獭困境」的负面效果并获得「<DerivativeCardKeywords_135:二世冲击！>」。"
  },
  RelicConfig_131080_Name = {
    Text = "小煤球二世"
  },
  RelicConfig_131080_StoryDesc = {
    Text = "莫丝女士强硬地说这就是造物。\n「坏人，咬他！」"
  },
  RelicConfig_131178_BattleDesc = {
    Text = "战斗开始时将一张「<DerivativeCardKeywords_134:禁忌真相>」洗入牌库。每回合抽牌数 +[Arg1]。打出指令卡后分别对手牌、抽牌堆和弃牌堆中的随机 [Arg2] 张不带有<ErosionColorInkKeywords:认知错乱>的指令卡附加<ErosionColorInkKeywords:认知错乱>。"
  },
  RelicConfig_131178_Desc = {
    Text = "战斗开始时将一张「<DerivativeCardKeywords_134:禁忌真相>」洗入牌库。每回合抽牌数 +[Arg1]。打出指令卡后分别对手牌、抽牌堆和弃牌堆中的随机 [Arg2] 张不带有<ErosionColorInkKeywords:认知错乱>的指令卡附加<ErosionColorInkKeywords:认知错乱>。"
  },
  RelicConfig_131178_Name = {
    Text = "奥涯手记"
  },
  RelicConfig_131178_StoryDesc = {
    Text = "记载内容包含七十个梅森质数。"
  },
  RelicConfig_132540_BattleDesc = {
    Text = "免疫伤害"
  },
  RelicConfig_132540_Name = {
    Text = "集合测试造物"
  },
  RelicConfig_13740_BattleDesc = {
    Text = "暴击率提高 15%。回合开始时若生命低于 25%([Arg1])，当回合内暴击率额外提高 30%。"
  },
  RelicConfig_13740_Desc = {
    Text = "暴击率提高 15%。回合开始时若生命低于 25%，当回合内暴击率额外提高 30%。"
  },
  RelicConfig_13740_Name = {
    Text = "<OrangeQuality:秘典星象仪>"
  },
  RelicConfig_13740_StoryDesc = {
    Text = "宇宙的奥妙。"
  },
  RelicConfig_13741_BattleDesc = {
    Text = "暴击伤害提高 15%。对有护盾的敌方造成的伤害必然暴击。"
  },
  RelicConfig_13741_Desc = {
    Text = "暴击伤害提高 15%。对有护盾的敌方造成的伤害必然暴击。"
  },
  RelicConfig_13741_Name = {
    Text = "<WhiteQuality:美学原理>"
  },
  RelicConfig_13741_StoryDesc = {
    Text = "蜡像师：医生的帮手，殡仪业者的恩客，墓虫的供养者。"
  },
  RelicConfig_13742_BattleDesc = {
    Text = "暴击伤害+50%。每造成的第三次攻击必然暴击。"
  },
  RelicConfig_13742_Desc = {
    Text = "暴击伤害+50%。每造成的第三次攻击必然暴击。"
  },
  RelicConfig_13742_Name = {
    Text = "<OrangeQuality:时灵摆「冥想」>"
  },
  RelicConfig_13743_BattleDesc = {
    Text = "回合开始时狂气最低的唤醒体获得 15 狂气。连续 2 次打出比上一张算力消耗更低的卡牌时，狂气最低的唤醒体获得 15 狂气。"
  },
  RelicConfig_13743_Desc = {
    Text = "回合开始时狂气最低的唤醒体获得 15 狂气。连续 2 次打出比上一张算力消耗更低的卡牌时，狂气最低的唤醒体获得 15 狂气。"
  },
  RelicConfig_13743_Name = {
    Text = "<OrangeQuality:阿尔卡纳遗物>"
  },
  RelicConfig_13743_StoryDesc = {
    Text = "命运的终焉。"
  },
  RelicConfig_13744_BattleDesc = {
    Text = "回合开始后，狂气最低的唤醒体获得 15 狂气。"
  },
  RelicConfig_13744_Desc = {
    Text = "回合开始后，狂气最低的唤醒体获得 15 狂气。"
  },
  RelicConfig_13744_Name = {
    Text = "<WhiteQuality:桂叶袖扣>"
  },
  RelicConfig_13744_StoryDesc = {
    Text = "印刻了桂叶花纹的银质袖扣。\n它做工精致，闪闪发亮，曾经承载了两个孩子的友谊。"
  },
  RelicConfig_13745_BattleDesc = {
    Text = "界域推荐加成效果提升为 50%，关卡开始时你的幸运刻印率翻倍。"
  },
  RelicConfig_13745_Desc = {
    Text = "界域推荐加成效果提升为 50%，关卡开始时你的幸运刻印率翻倍。"
  },
  RelicConfig_13745_Name = {
    Text = "<OrangeQuality:时灵摆「酣眠」>"
  },
  RelicConfig_13747_BattleDesc = {
    Text = "免疫 1 次死亡，触发后立刻回复 10% 生命，触发 3 次后永久失效。"
  },
  RelicConfig_13747_Desc = {
    Text = "免疫 1 次死亡，触发后立刻回复 10% 生命，触发 3 次后永久失效。"
  },
  RelicConfig_13747_Name = {
    Text = "<WhiteQuality:☆应急食品☆>"
  },
  RelicConfig_13747_StoryDesc = {
    Text = "万不得已之下，也还是别吃这个。"
  },
  RelicConfig_13748_BattleDesc = {
    Text = "战斗开始时，使你所有当前算力消耗为 1 的卡牌在本场战斗内伤害提高 [Arg1] 点，护盾提高 [Arg2] 点。"
  },
  RelicConfig_13748_Desc = {
    Text = "战斗开始时，使你所有当前算力消耗为 1 的卡牌在本场战斗内伤害提高 [Arg1] 点，护盾提高 [Arg2] 点。"
  },
  RelicConfig_13748_Name = {
    Text = "<OrangeQuality:纯真玛丽>"
  },
  RelicConfig_13748_StoryDesc = {
    Text = "逻辑就像鸡尾酒，摄入太多就失去它的益处了。"
  },
  RelicConfig_13749_BattleDesc = {
    Text = "每 4 回合使所有敌人本回合受到的主动和触腕伤害翻倍，但在该回合中释放狂气爆发后，封印所有唤醒体 1 回合。"
  },
  RelicConfig_13749_Desc = {
    Text = "每 4 回合使所有敌人本回合受到的主动和触腕伤害翻倍，但在该回合中释放狂气爆发后，封印所有唤醒体 1 回合。"
  },
  RelicConfig_13749_Name = {
    Text = "<RedQuality:行道之骸>"
  },
  RelicConfig_13749_StoryDesc = {
    Text = "神圣的一部分。\n纵然与躯干分离，其足迹也已遍布四海。"
  },
  RelicConfig_13750_BattleDesc = {
    Text = "回合结束时，若没有护盾，获得 1 层免疫一次伤害的<ParcloseIconKeywords:屏障>。每场战斗只生效 1 次。"
  },
  RelicConfig_13750_Desc = {
    Text = "回合结束时，若没有护盾，获得 1 层免疫一次伤害的<ParcloseIconKeywords:屏障>。每场战斗只生效 1 次。"
  },
  RelicConfig_13750_Name = {
    Text = "<WhiteQuality:☆镇痛药片☆>"
  },
  RelicConfig_13750_StoryDesc = {
    Text = "效果没有那么一劳永逸。"
  },
  RelicConfig_13751_BattleDesc = {
    Text = "暴击率提高 25%，每回合首次造成的伤害翻倍。"
  },
  RelicConfig_13751_Desc = {
    Text = "暴击率提高 25%，每回合首次造成的伤害翻倍。"
  },
  RelicConfig_13751_Name = {
    Text = "<OrangeQuality:时灵摆「深化」>"
  },
  RelicConfig_13752_BattleDesc = {
    Text = "回合开始时回复 [Arg1] 生命。如果生命低于 50% ，回复生命变为 [Arg2]。"
  },
  RelicConfig_13752_Desc = {
    Text = "回合开始时回复 [Arg1] 生命。如果生命低于 50% ，回复生命变为 [Arg2]。"
  },
  RelicConfig_13752_Name = {
    Text = "<WhiteQuality:恩赐之血>"
  },
  RelicConfig_13752_StoryDesc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  RelicConfig_13753_BattleDesc = {
    Text = "这是个没有效果的任务造物"
  },
  RelicConfig_13753_Desc = {
    Text = "这是个没有效果的任务造物"
  },
  RelicConfig_13753_Name = {
    Text = "任务造物测试"
  },
  RelicConfig_13753_StoryDesc = {
    Text = "需要补充内容的造物"
  },
  RelicConfig_13754_BattleDesc = {
    Text = "你每造成的第 5 次伤害必定暴击。"
  },
  RelicConfig_13754_Desc = {
    Text = "你每造成的第 5 次伤害必定暴击。"
  },
  RelicConfig_13754_Name = {
    Text = "<WhiteQuality:视力矫正器>"
  },
  RelicConfig_13754_StoryDesc = {
    Text = "曾有人透过它，找到了真相。"
  },
  RelicConfig_13755_BattleDesc = {
    Text = "回合开始时，<DimensionalSpaceIconKeywords:超维空间>每有 1 张卡牌，获得 [Arg1] 点临时<PowerIconKeywords:力量>，若本回合为超维回合，则获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13755_Desc = {
    Text = "回合开始时，<DimensionalSpaceIconKeywords:超维空间>每有 1 张卡牌，获得 [Arg1] 点临时<PowerIconKeywords:力量>，若本回合为超维回合，则获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13755_Name = {
    Text = "<WhiteQuality:三棱镜>"
  },
  RelicConfig_13755_StoryDesc = {
    Text = "「光由七种色彩构成。」"
  },
  RelicConfig_13756_BattleDesc = {
    Text = "拾取时失去所有其他造物，随机获得 2 个黄金造物。"
  },
  RelicConfig_13756_Desc = {
    Text = "拾取时失去所有其他造物，随机获得 2 个黄金造物。"
  },
  RelicConfig_13756_Name = {
    Text = "<RedQuality:☆逆向观赏☆>"
  },
  RelicConfig_13756_StoryDesc = {
    Text = "在奇异的纪元中，花朵才是人类的第一观赏者。\n不要动弹，祂们更偏爱安静的展品。"
  },
  RelicConfig_13757_BattleDesc = {
    Text = "你每打出的第 8 张指令卡会生效 2 次。"
  },
  RelicConfig_13757_Desc = {
    Text = "你每打出的第 8 张指令卡会生效 2 次。"
  },
  RelicConfig_13757_Name = {
    Text = "<OrangeQuality:群星之酒>"
  },
  RelicConfig_13757_StoryDesc = {
    Text = "游走于繁星之间。"
  },
  RelicConfig_13758_BattleDesc = {
    Text = "拾取后使最大生命提高 [Arg1] 点，受到攻击时获得的狂气提高 2 点。"
  },
  RelicConfig_13758_Desc = {
    Text = "拾取后使最大生命提高 [Arg1] 点，受到攻击时获得的狂气提高 2 点。"
  },
  RelicConfig_13758_Name = {
    Text = "<WhiteQuality:甜蜜墨水>"
  },
  RelicConfig_13758_StoryDesc = {
    Text = "有人说这是魔鬼的血，但是，嘿，先试试看吧！"
  },
  RelicConfig_13759_BattleDesc = {
    Text = "释放狂气爆发时，敌人每将要造成 1 次伤害，就对其施加 [Arg1] 层<IntoxicationIconKeywords:中毒>"
  },
  RelicConfig_13759_Desc = {
    Text = "释放狂气爆发时，敌人每将要造成 1 次伤害，就对其施加 [Arg1] 层<IntoxicationIconKeywords:中毒>"
  },
  RelicConfig_13759_Name = {
    Text = "<WhiteQuality:☆镭射颌骨☆>"
  },
  RelicConfig_13759_StoryDesc = {
    Text = "陈列在某个收藏家私人展厅内的遗骨。\n收藏家醉心于那美丽的荧光，日夜欣赏，最终枯死，最终成为了它的同类。"
  },
  RelicConfig_13760_BattleDesc = {
    Text = "最大算力提高 1 。连续 2 次打出比上一张算力消耗更高的卡牌时，获得 1 算力。"
  },
  RelicConfig_13760_Desc = {
    Text = "最大算力提高 1 。连续 2 次打出比上一张算力消耗更高的卡牌时，获得 1 算力。"
  },
  RelicConfig_13760_Name = {
    Text = "<OrangeQuality:阿尔卡纳记录>"
  },
  RelicConfig_13760_StoryDesc = {
    Text = "命运的走势。"
  },
  RelicConfig_13761_BattleDesc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 3 张，获得 2 算力。"
  },
  RelicConfig_13761_Desc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 3 张，获得 2 算力。"
  },
  RelicConfig_13761_Name = {
    Text = "<WhiteQuality:弥萨格徽章>"
  },
  RelicConfig_13761_StoryDesc = {
    Text = "弥萨格大学分发给调查员的徽章。它不仅象征了佩戴者的身份，还是一个可以进行远程通讯的工具。"
  },
  RelicConfig_13762_BattleDesc = {
    Text = "打出「防御」时，获得[Arg1]点<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13762_Desc = {
    Text = "打出「防御」时，获得[Arg1]点<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13762_Name = {
    Text = "异化刺荨麻背心"
  },
  RelicConfig_13762_StoryDesc = {
    Text = "无法分辨沾染的液体。"
  },
  RelicConfig_13763_BattleDesc = {
    Text = "战斗开始时，获得 [Arg1] 点护盾。回合开始时如果拥有护盾，该回合中护盾和治疗强效+ 50%。"
  },
  RelicConfig_13763_Desc = {
    Text = "战斗开始时，获得 [Arg1] 点护盾。回合开始时如果拥有护盾，该回合中护盾和治疗强效+ 50%。"
  },
  RelicConfig_13763_Name = {
    Text = "异化花园守护者"
  },
  RelicConfig_13764_BattleDesc = {
    Text = "拾取时永久获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13764_Desc = {
    Text = "拾取时永久获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13764_Name = {
    Text = "<WhiteQuality:红宝石胸针>"
  },
  RelicConfig_13764_StoryDesc = {
    Text = "隐约渗出鲜红。"
  },
  RelicConfig_13766_BattleDesc = {
    Text = "拾取时选择一张卡牌，将两个三选一强化效果赋予其上。（注：类似千面幻象捏卡）"
  },
  RelicConfig_13766_Desc = {
    Text = "拾取时选择一张卡牌，将两个三选一强化效果赋予其上。（注：类似千面幻象捏卡）"
  },
  RelicConfig_13766_Name = {
    Text = "<OrangeQuality:☆名家打字机☆>"
  },
  RelicConfig_13766_StoryDesc = {
    Text = "有传言，真正写出传世之作的，其实是打字机。"
  },
  RelicConfig_13767_BattleDesc = {
    Text = "拾取时获得 3 选 1 随机高级刻印，将其赋予对应卡牌。"
  },
  RelicConfig_13767_Desc = {
    Text = "拾取时获得 3 选 1 随机高级刻印，将其赋予对应卡牌。"
  },
  RelicConfig_13767_Name = {
    Text = "<WhiteQuality:莱茵德纸草书>"
  },
  RelicConfig_13767_StoryDesc = {
    Text = "下面请听题：10个僧侣分6只面包，请问他们各得多少？"
  },
  RelicConfig_13768_BattleDesc = {
    Text = "最大算力提高 2。打出「打击」或「防御」后，对应唤醒体获得 5 狂气。释放狂气爆发后，获得 1 张对应唤醒体附带消耗虚无的「打击」，释放钥令后，随机获得 1 张附带消耗虚无的「防御」。"
  },
  RelicConfig_13768_Desc = {
    Text = "最大算力提高 2。打出「打击」或「防御」后，对应唤醒体获得 5 狂气。释放狂气爆发后，获得 1 张对应唤醒体附带消耗虚无的「打击」，释放钥令后，随机获得 1 张附带消耗虚无的「防御」。"
  },
  RelicConfig_13768_Name = {
    Text = "<OrangeQuality:时灵摆「羽翼」>"
  },
  RelicConfig_13769_BattleDesc = {
    Text = "回合开始时<EmbryoFusionIconKeywords:胚胎融合>+30。你的所有<DevouredIconKeywords:吞噬>效果均变为<UnlimitedDevouredIconKeywords:无限吞噬>。"
  },
  RelicConfig_13769_Desc = {
    Text = "回合开始时<EmbryoFusionIconKeywords:胚胎融合>+30。你的所有<DevouredIconKeywords:吞噬>效果均变为<UnlimitedDevouredIconKeywords:无限吞噬>。"
  },
  RelicConfig_13769_Name = {
    Text = "<RedQuality:蠕动的脐带>"
  },
  RelicConfig_13769_StoryDesc = {
    Text = "缠绕脖颈。"
  },
  RelicConfig_13770_BattleDesc = {
    Text = "回合开始时获得 [Arg1] 护盾，每经过 1 回合就使该护盾值提高 [Arg2]。"
  },
  RelicConfig_13770_Desc = {
    Text = "回合开始时获得 [Arg1] 护盾，每经过 1 回合就使该护盾值提高 [Arg2]。"
  },
  RelicConfig_13770_Name = {
    Text = "<WhiteQuality:守护之手>"
  },
  RelicConfig_13770_StoryDesc = {
    Text = "祈福的手，坚定的拳。"
  },
  RelicConfig_13771_BattleDesc = {
    Text = "所有唤醒体银钥充能提高 30。释放钥令后，将 3 张<DerivativeCardKeywords_4:「灵感」>洗入你的牌库。"
  },
  RelicConfig_13771_Desc = {
    Text = "所有唤醒体银钥充能提高 30。释放钥令后，将 3 张<DerivativeCardKeywords_4:「灵感」>洗入你的牌库。"
  },
  RelicConfig_13771_Name = {
    Text = "<OrangeQuality:时灵摆「浅眠」>"
  },
  RelicConfig_13772_BattleDesc = {
    Text = "战斗结束后，额外获得 75 黑印和 1 张症状卡。"
  },
  RelicConfig_13772_Desc = {
    Text = "战斗结束后，额外获得 75 黑印和 1 张症状卡。"
  },
  RelicConfig_13772_Name = {
    Text = "<RedQuality:翠玉拓印>"
  },
  RelicConfig_13772_StoryDesc = {
    Text = "此拓印千年不朽。"
  },
  RelicConfig_13773_BattleDesc = {
    Text = "每造成 1 次主动伤害，对自身施加 [Arg1] 层<BleedingIconKeywords:出血>，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。每击杀 1 次敌人，驱散自身<BleedingIconKeywords:出血>状态。"
  },
  RelicConfig_13773_Desc = {
    Text = "每造成 1 次主动伤害，对自身施加 [Arg1] 层<BleedingIconKeywords:出血>，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。每击杀 1 次敌人，驱散自身<BleedingIconKeywords:出血>状态。"
  },
  RelicConfig_13773_Name = {
    Text = "<RedQuality:虫群意识>"
  },
  RelicConfig_13773_StoryDesc = {
    Text = "缠绕、共生、集群；恐惧、未知、控制。"
  },
  RelicConfig_13774_BattleDesc = {
    Text = "打出 1 张实际算力消耗为 3 的卡牌时，抽 1 张牌并获得 2 算力；打出 1 张实际算力消耗为 4 或以上的卡牌时，其他手牌算力消耗降低 1。"
  },
  RelicConfig_13774_Desc = {
    Text = "打出 1 张实际算力消耗为 3 的卡牌时，抽 1 张牌并获得 2 算力；打出 1 张实际算力消耗为 4 或以上的卡牌时，其他手牌算力消耗降低 1。"
  },
  RelicConfig_13774_Name = {
    Text = "<OrangeQuality:时灵摆「眼」>"
  },
  RelicConfig_13775_BattleDesc = {
    Text = "拾取时选择一张指令卡，使其获得「固有」、「保留」和「打出后抽 1 张牌」。"
  },
  RelicConfig_13775_Desc = {
    Text = "拾取时选择一张指令卡，使其获得「固有」、「保留」和「打出后抽 1 张牌」。"
  },
  RelicConfig_13775_Name = {
    Text = "<WhiteQuality:档案夹>"
  },
  RelicConfig_13775_StoryDesc = {
    Text = "嘘，这是只属于你我的秘密交易。"
  },
  RelicConfig_13776_BattleDesc = {
    Text = "战斗开始后，获得 1 条触腕。"
  },
  RelicConfig_13776_Desc = {
    Text = "战斗开始后，获得 1 条触腕。"
  },
  RelicConfig_13776_Name = {
    Text = "<WhiteQuality:小黄螺>"
  },
  RelicConfig_13776_StoryDesc = {
    Text = "这只小黄螺出身高贵，有着完美的、无可挑剔的来源。"
  },
  RelicConfig_13777_BattleDesc = {
    Text = "奇数回合结束时，若有剩余算力，下回合额外抽 2 张牌；偶数回合结束时，若有剩余手牌，下回合额外获得 2 算力。"
  },
  RelicConfig_13777_Desc = {
    Text = "奇数回合结束时，若有剩余算力，下回合额外抽 2 张牌；偶数回合结束时，若有剩余手牌，下回合额外获得 2 算力。"
  },
  RelicConfig_13777_Name = {
    Text = "<OrangeQuality:日月轮盘>"
  },
  RelicConfig_13777_StoryDesc = {
    Text = "猜一猜，是黑还是白？"
  },
  RelicConfig_13778_BattleDesc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，<TentacleInjurieIconKeywords:触腕伤害>提高 [Arg1] 。"
  },
  RelicConfig_13778_Desc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，<TentacleInjurieIconKeywords:触腕伤害> 提高 [Arg1] 。"
  },
  RelicConfig_13778_Name = {
    Text = "<OrangeQuality:海眷歌谣>"
  },
  RelicConfig_13778_StoryDesc = {
    Text = "据说织纹螺等不可食用动物吸收了海洋大约80%的营养。"
  },
  RelicConfig_13779_BattleDesc = {
    Text = "回合开始时抽 1 张牌，回合结束时可以选择保留 1 张手牌。"
  },
  RelicConfig_13779_Desc = {
    Text = "回合开始时抽 1 张牌，回合结束时可以选择保留 1 张手牌。"
  },
  RelicConfig_13779_Name = {
    Text = "<OrangeQuality:先知的许愿灯>"
  },
  RelicConfig_13779_StoryDesc = {
    Text = "回应你的愿望。"
  },
  RelicConfig_13780_BattleDesc = {
    Text = "每次释放狂气爆发，获得 1 张<DerivativeCardKeywords_7:「毒性侵染」>，若手牌中拥有 3 张<DerivativeCardKeywords_7:「毒性侵染」>则合成一张触发<IntoxicationIconKeywords:中毒>的 <DerivativeCardKeywords_8:「毒性发作」>。"
  },
  RelicConfig_13780_Desc = {
    Text = "每次释放狂气爆发，获得 1 张<DerivativeCardKeywords_7:「毒性侵染」>，若手牌中拥有 3 张<DerivativeCardKeywords_7:「毒性侵染」>则合成一张触发<IntoxicationIconKeywords:中毒>的 <DerivativeCardKeywords_8:「毒性发作」>。"
  },
  RelicConfig_13780_Name = {
    Text = "<OrangeQuality:异种喉舌>"
  },
  RelicConfig_13780_StoryDesc = {
    Text = "祂不是恶魔，但祂确实会传递人世之外的低语。"
  },
  RelicConfig_13781_BattleDesc = {
    Text = "每消耗 1 个黑印，所有唤醒体获得 1 点狂气。"
  },
  RelicConfig_13781_Desc = {
    Text = "每消耗 1 个黑印，所有唤醒体获得 1 点狂气。"
  },
  RelicConfig_13781_Name = {Text = "逆生花"},
  RelicConfig_13782_BattleDesc = {
    Text = "免疫伤害"
  },
  RelicConfig_13782_Desc = {
    Text = "免疫伤害"
  },
  RelicConfig_13782_Name = {
    Text = "测试造物"
  },
  RelicConfig_13783_BattleDesc = {
    Text = "每回合打出第 3 张卡牌后，将 1 张<DerivativeCardKeywords_4:「灵感」>置入弃牌堆。每回合打出第 6 张卡牌后，从弃牌堆中将 1 张<DerivativeCardKeywords_4:「灵感」>置入手牌。"
  },
  RelicConfig_13783_Desc = {
    Text = "每回合打出第 3 张卡牌后，将 1 张<DerivativeCardKeywords_4:「灵感」>置入弃牌堆。每回合打出第 6 张卡牌后，从弃牌堆中将 1 张<DerivativeCardKeywords_4:「灵感」>置入手牌。"
  },
  RelicConfig_13783_Name = {
    Text = "<WhiteQuality:文明之光>"
  },
  RelicConfig_13783_StoryDesc = {
    Text = "划破黑夜的流星。"
  },
  RelicConfig_13784_BattleDesc = {
    Text = "回合开始时每有 1 名敌人就获得 1 算力。主动伤害击杀敌人时，对其他敌人造成等同于过量伤害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_13784_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 1 算力。主动伤害击杀敌人时，对其他敌人造成等同于过量伤害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_13784_Name = {
    Text = "<OrangeQuality:群氓之歌>"
  },
  RelicConfig_13784_StoryDesc = {
    Text = "专为折磨你的耳朵而生。"
  },
  RelicConfig_13785_BattleDesc = {
    Text = "回合结束时<EmbryoFusionIconKeywords:胚胎融合> +15，若手牌中有<DerivativeCardKeywords_2:「胚胎」>，回复 [Arg1] 生命。"
  },
  RelicConfig_13785_Desc = {
    Text = "回合结束时<EmbryoFusionIconKeywords:胚胎融合> +15，若手牌中有<DerivativeCardKeywords_2:「胚胎」>，回复 [Arg1] 生命。"
  },
  RelicConfig_13785_Name = {
    Text = "<WhiteQuality:瘟疫诊断书>"
  },
  RelicConfig_13785_StoryDesc = {
    Text = "瘟疫——大自然无意识烦躁的偶然表现。"
  },
  RelicConfig_13786_BattleDesc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13786_Desc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13786_Name = {
    Text = "<WhiteQuality:重锁>"
  },
  RelicConfig_13786_StoryDesc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  RelicConfig_13787_BattleDesc = {
    Text = "回合开始时对随机一名敌人造成 [Arg1] 点<FixedDamage:纯粹伤害>。在本场战斗内打出 7 次「打击」后，伤害值变为 [Arg2]，打出 21 次「打击」后，立刻对全体敌人造成 [Arg3] 点<FixedDamage:纯粹伤害>。"
  },
  RelicConfig_13787_Desc = {
    Text = "回合开始时对随机一名敌人造成 [Arg1] 点<FixedDamage:纯粹伤害>。在本场战斗内打出 7 次「打击」后，伤害值变为 [Arg2]，打出 21 次「打击」后，立刻对全体敌人造成 [Arg3] 点<FixedDamage:纯粹伤害>。"
  },
  RelicConfig_13787_Name = {
    Text = "<OrangeQuality:老旧拼图>"
  },
  RelicConfig_13787_StoryDesc = {
    Text = "曾经镶嵌在沉重画框中的艺术品，从展出的那天起便缺了一块。"
  },
  RelicConfig_13788_BattleDesc = {
    Text = "触腕上限减少 2 条。回合结束时额外使所有触腕攻击 1 次。"
  },
  RelicConfig_13788_Desc = {
    Text = "触腕上限减少 2 条。回合结束时额外使所有触腕攻击 1 次。"
  },
  RelicConfig_13788_Name = {
    Text = "<RedQuality:苦痛圣腕>"
  },
  RelicConfig_13788_StoryDesc = {
    Text = "享受苦痛。"
  },
  RelicConfig_13789_BattleDesc = {
    Text = "每次牌库重置，获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13789_Desc = {
    Text = "每次牌库重置，获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13789_Name = {
    Text = "<WhiteQuality:哭泣烟斗>"
  },
  RelicConfig_13789_StoryDesc = {
    Text = "这究竟是仇恨的产物，还是复仇的结果？"
  },
  RelicConfig_13790_BattleDesc = {
    Text = "每次地图移动会获得 10 个黑印，但地图移动带来的精神压力将提高 10 点。"
  },
  RelicConfig_13790_Desc = {
    Text = "每次地图移动会获得 10 个黑印，但地图移动带来的精神压力将提高 10 点。"
  },
  RelicConfig_13790_Name = {Text = "无底袋"},
  RelicConfig_13791_BattleDesc = {
    Text = "拾取该造物时选择一张指令卡，将一张它的复制加入牌库。"
  },
  RelicConfig_13791_Desc = {
    Text = "拾取该造物时选择一张指令卡，将一张它的复制加入牌库。"
  },
  RelicConfig_13791_Name = {
    Text = "<WhiteQuality:须臾的火>"
  },
  RelicConfig_13791_StoryDesc = {
    Text = "摇曳的光，微弱的希望。"
  },
  RelicConfig_13792_BattleDesc = {
    Text = "每当你损失生命，<EmbryoFusionIconKeywords:胚胎融合>+10。若生命低于 50% 时效果翻倍。"
  },
  RelicConfig_13792_Desc = {
    Text = "每当你损失生命，<EmbryoFusionIconKeywords:胚胎融合>+10。若生命低于 50% 时效果翻倍。"
  },
  RelicConfig_13792_Name = {
    Text = "<WhiteQuality:锈蚀钢锯>"
  },
  RelicConfig_13792_StoryDesc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  RelicConfig_13793_BattleDesc = {
    Text = "拾取时队伍黑印掉落变为原始值的 150%。回复生命后，所有唤醒体获得 3 点狂气；失去生命后，获得 [Arg1] 点<PowerIconKeywords:力量>和触腕伤害，每回合合计最多生效 5 次。"
  },
  RelicConfig_13793_Desc = {
    Text = "拾取时队伍黑印掉落变为原始值的 150%。回复生命后，所有唤醒体获得 3 点狂气；失去生命后，获得 [Arg1] 点<PowerIconKeywords:力量>和触腕伤害，每回合合计最多生效 5 次。"
  },
  RelicConfig_13793_Name = {
    Text = "<OrangeQuality:时灵摆「月亮」>"
  },
  RelicConfig_13794_BattleDesc = {
    Text = "回合结束后所有唤醒体获得 5 狂气。每剩余 1 点算力，所有唤醒体就额外获得 3 狂气。"
  },
  RelicConfig_13794_Desc = {
    Text = "回合结束后所有唤醒体获得 5 狂气。每剩余 1 点算力，所有唤醒体就额外获得 3 狂气。"
  },
  RelicConfig_13794_Name = {
    Text = "<OrangeQuality:原型电池>"
  },
  RelicConfig_13794_StoryDesc = {
    Text = "便携式的希望。"
  },
  RelicConfig_13795_BattleDesc = {
    Text = "最大算力提高 1 。"
  },
  RelicConfig_13795_Desc = {
    Text = "最大算力提高 1 。"
  },
  RelicConfig_13795_Name = {
    Text = "<WhiteQuality:活性注射器>"
  },
  RelicConfig_13795_StoryDesc = {
    Text = "抽搐也是活性的一种。"
  },
  RelicConfig_13796_BattleDesc = {
    Text = "战斗结束时，生命值剩余50%以下时，升级为一个白银造物"
  },
  RelicConfig_13796_Desc = {
    Text = "战斗结束时，生命值剩余50%以下时，升级为一个白银造物。"
  },
  RelicConfig_13796_Name = {
    Text = "破旧的笔记本2"
  },
  RelicConfig_13796_StoryDesc = {
    Text = "一本破旧的日记本，内页中塞满了夹页，粗看至少包含艾尔沃斯地图、实验记录、布满三角融蚀痕的信笺。\n笔记前段的内容字迹工整端正，后续却逐步潦草凌乱。"
  },
  RelicConfig_13797_BattleDesc = {
    Text = "打出3张打击卡后，升级为一个黄金造物"
  },
  RelicConfig_13797_Desc = {
    Text = "打出3张打击卡后，升级为一个黄金造物。"
  },
  RelicConfig_13797_Name = {
    Text = "破旧的笔记本1"
  },
  RelicConfig_13797_StoryDesc = {
    Text = "一本破旧的日记本，内页中塞满了夹页，粗看至少包含艾尔沃斯地图、实验记录、布满三角融蚀痕的信笺。\n笔记前段的内容字迹工整端正，后续却逐步潦草凌乱。"
  },
  RelicConfig_13798_BattleDesc = {
    Text = "战斗开始时，你的所有症状卡获得<NothingnessIconKeywords:虚无>，卡组中每有 1 张症状卡就获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13798_Desc = {
    Text = "战斗开始时，你的所有症状卡获得<NothingnessIconKeywords:虚无>，卡组中每有 1 张症状卡就获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13798_Name = {
    Text = "<WhiteQuality:哈福德灵药>"
  },
  RelicConfig_13798_StoryDesc = {
    Text = "成分不明的药物。\n据说著名提琴家埃里克对其青睐有加。"
  },
  RelicConfig_13799_BattleDesc = {
    Text = "战斗首回合开始时，将<DerivativeCardKeywords_1:「遗影回响」>加入手中；第 2 回合将<DerivativeCardKeywords_41:「银钥共鸣」>加入手中；第 3 回合将<DerivativeCardKeywords_39:「过往回声」>加入手中。"
  },
  RelicConfig_13799_Desc = {
    Text = "战斗首回合开始时，将<DerivativeCardKeywords_1:「遗影回响」>加入手中；第 2 回合将<DerivativeCardKeywords_41:「银钥共鸣」>加入手中；第 3 回合将<DerivativeCardKeywords_39:「过往回声」>加入手中。"
  },
  RelicConfig_13799_Name = {
    Text = "<OrangeQuality:时灵摆「群星」>"
  },
  RelicConfig_13800_BattleDesc = {
    Text = "回合开始时，将 1 张<DerivativeCardKeywords_6:「阳伞」>加入手中，打出 6 张卡牌后，使手牌中所有的<DerivativeCardKeywords_6:「阳伞」><AlertIconKeywords:戒备>提高 [Arg2]。"
  },
  RelicConfig_13800_Desc = {
    Text = "回合开始时，将 1 张<DerivativeCardKeywords_6:「阳伞」>加入手中，打出 6 张卡牌后，使手牌中所有的<DerivativeCardKeywords_6:「阳伞」><AlertIconKeywords:戒备>提高 [Arg2]。"
  },
  RelicConfig_13800_Name = {
    Text = "<WhiteQuality:旅行阳伞>"
  },
  RelicConfig_13800_StoryDesc = {
    Text = "在无光之地绽放。"
  },
  RelicConfig_13801_BattleDesc = {
    Text = "常规战斗中所有敌人的生命提升 30%，战斗胜利时额外获得 25 个黑印。"
  },
  RelicConfig_13801_Desc = {
    Text = "常规战斗中所有敌人的生命提升 30%，战斗胜利时额外获得 25 个黑印。"
  },
  RelicConfig_13801_Name = {
    Text = "残破战旗"
  },
  RelicConfig_13802_BattleDesc = {
    Text = "拾取时最大生命提高 [Arg1] 点。若拾取时生命低于 25%，最大生命提高变为 [Arg2] 点。"
  },
  RelicConfig_13802_Desc = {
    Text = "拾取时最大生命提高 [Arg1] 点。若拾取时生命低于 25%，最大生命提高变为 [Arg2] 点。"
  },
  RelicConfig_13802_Name = {
    Text = "<WhiteQuality:锡兰红茶>"
  },
  RelicConfig_13802_StoryDesc = {
    Text = "健康饮食，从你我做起。"
  },
  RelicConfig_13803_BattleDesc = {
    Text = "每 3 个回合获得 3 条临时触腕。"
  },
  RelicConfig_13803_Desc = {
    Text = "每 3 个回合获得 3 条临时触腕。"
  },
  RelicConfig_13803_Name = {
    Text = "<WhiteQuality:潜水头盔>"
  },
  RelicConfig_13803_StoryDesc = {
    Text = "梦想是星辰大海！"
  },
  RelicConfig_13804_BattleDesc = {
    Text = "回合结束时获得 [Arg1] 点护盾。若你的护盾为 0 或 3 的倍数，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13804_Desc = {
    Text = "回合结束时获得 [Arg1] 点护盾。若你的护盾为 0 或 3 的倍数，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13804_Name = {
    Text = "<OrangeQuality:求救信号>"
  },
  RelicConfig_13804_StoryDesc = {
    Text = "他没有等到救援。"
  },
  RelicConfig_13806_BattleDesc = {
    Text = "抽到症状卡时获得 [Arg1] 点临时<PowerIconKeywords:力量>。你每拥有 1 个诅咒造物，暴击率和暴击伤害就提高 10%。"
  },
  RelicConfig_13806_Desc = {
    Text = "抽到症状卡时获得 [Arg1] 点临时<PowerIconKeywords:力量>。你每拥有 1 个诅咒造物，暴击率和暴击伤害就提高 10%。"
  },
  RelicConfig_13806_Name = {
    Text = "<OrangeQuality:深渊通信>"
  },
  RelicConfig_13806_StoryDesc = {
    Text = "荒无人烟的郊外，孤独的电话亭中铃声响起。\n「暗……嘶……无边的……嘶嘶……黑暗……」"
  },
  RelicConfig_13807_BattleDesc = {
    Text = "战斗开始时<EmbryoFusionIconKeywords:胚胎融合> +50。每存在一名至少拥有 50 点狂气的唤醒体，额外生效 1 次"
  },
  RelicConfig_13807_Desc = {
    Text = "战斗开始时<EmbryoFusionIconKeywords:胚胎融合> +50。每存在一名至少拥有 50 点狂气的唤醒体，额外生效 1 次。"
  },
  RelicConfig_13807_Name = {
    Text = "<WhiteQuality:亲爱的宝贝>"
  },
  RelicConfig_13807_StoryDesc = {
    Text = "木匠为妻子做了个栩栩如生的木偶，它将代替他们的儿子，在她腹中沉睡。"
  },
  RelicConfig_13808_BattleDesc = {
    Text = "释放狂气爆发后，将一张对应唤醒体的随机卡牌置入手中，该卡牌获得<DepleteIconKeywords:消耗>与<NothingnessIconKeywords:虚无>。战斗结束后，回复 [Arg1] 点生命。"
  },
  RelicConfig_13808_Desc = {
    Text = "释放狂气爆发后，将一张对应唤醒体的随机卡牌置入手中，该卡牌获得<DepleteIconKeywords:消耗>与<NothingnessIconKeywords:虚无>。战斗结束后，回复 [Arg1] 点生命。"
  },
  RelicConfig_13808_Name = {
    Text = "<WhiteQuality:医生手提箱>"
  },
  RelicConfig_13808_StoryDesc = {
    Text = "象征医生身份的手提箱，十分沉重。\n打开它的，未必是真的医生。"
  },
  RelicConfig_13809_BattleDesc = {
    Text = "所有造物价格降低 20。"
  },
  RelicConfig_13809_Desc = {
    Text = "所有造物价格降低 20。"
  },
  RelicConfig_13809_Name = {
    Text = "<WhiteQuality:伶牙俐齿>"
  },
  RelicConfig_13809_StoryDesc = {
    Text = "能说会道的不止商人，亦有虔信者。"
  },
  RelicConfig_13811_BattleDesc = {
    Text = "每第 3 次打出「打击」后，对全体敌方造成 [Arg1] 点<FixedDamage:纯粹伤害>，对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13811_Desc = {
    Text = "每第 3 次打出「打击」后，对全体敌方造成 [Arg1] 点<FixedDamage:纯粹伤害>，对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13811_Name = {
    Text = "<WhiteQuality:锈蚀柳叶刀>"
  },
  RelicConfig_13811_StoryDesc = {
    Text = "不适宜用于割开活体。"
  },
  RelicConfig_13812_BattleDesc = {
    Text = "拾取时最大生命提高 100%，回合开始时，失去 [Arg1] 点生命。"
  },
  RelicConfig_13812_Desc = {
    Text = "拾取时最大生命提高 100%，回合开始时，失去 [Arg1] 点生命。"
  },
  RelicConfig_13812_Name = {
    Text = "<RedQuality:☆长生者血肉☆>"
  },
  RelicConfig_13812_StoryDesc = {
    Text = "「海洋生物惯于断臂求生。」"
  },
  RelicConfig_13813_BattleDesc = {
    Text = "战斗开始后精英敌人和首领敌人的当前生命降低 20%。"
  },
  RelicConfig_13813_Desc = {
    Text = "战斗开始后精英敌人和首领敌人的当前生命降低 20%。"
  },
  RelicConfig_13813_Name = {
    Text = "<WhiteQuality:☆旧船锚☆>"
  },
  RelicConfig_13813_StoryDesc = {
    Text = "快回家吧，我的老水手。"
  },
  RelicConfig_13814_BattleDesc = {
    Text = "回合结束时手中每有 1 张未打出的卡牌，就使所有唤醒体获得 2 狂气。"
  },
  RelicConfig_13814_Desc = {
    Text = "回合结束时手中每有 1 张未打出的卡牌，就使所有唤醒体获得 2 狂气。"
  },
  RelicConfig_13814_Name = {
    Text = "<WhiteQuality:失衡的天平>"
  },
  RelicConfig_13814_StoryDesc = {
    Text = "不再象征公正。"
  },
  RelicConfig_13815_BattleDesc = {
    Text = "拾取后选择一张卡牌，使其算力消耗永久变为 1。"
  },
  RelicConfig_13815_Desc = {
    Text = "拾取后选择一张卡牌，使其算力消耗永久变为 1。"
  },
  RelicConfig_13815_Name = {
    Text = "<WhiteQuality:☆精制义眼☆>"
  },
  RelicConfig_13815_StoryDesc = {
    Text = "一只不再纯洁的眼球。"
  },
  RelicConfig_13816_BattleDesc = {
    Text = "战斗开始时，所有敌人获得 [Arg1] 点<RetaliateIconKeywords:反击>。每当造成伤害时，狂气最低的唤醒体获得 6 点狂气。"
  },
  RelicConfig_13816_Desc = {
    Text = "战斗开始时，所有敌人获得 [Arg1] 点<RetaliateIconKeywords:反击>。每当造成伤害时，狂气最低的唤醒体获得 6 点狂气。"
  },
  RelicConfig_13816_Name = {
    Text = "<RedQuality:☆哀嚎摇铃☆>"
  },
  RelicConfig_13816_StoryDesc = {
    Text = "叮铃，叮铃，孩子在哭闹；\n叮铃，叮铃，孩子在尖叫。\n叮铃，叮铃，孩子在哀嚎；\n叮铃，叮铃，它饿了，你知道。"
  },
  RelicConfig_13817_BattleDesc = {
    Text = "每打出 6 张指令卡后，<TentacleInjurieIconKeywords:触腕伤害> +[Arg1]。"
  },
  RelicConfig_13817_Desc = {
    Text = "每打出 6 张指令卡后，<TentacleInjurieIconKeywords:触腕伤害> +[Arg1]。"
  },
  RelicConfig_13817_Name = {
    Text = "<WhiteQuality:裂头蚴>"
  },
  RelicConfig_13817_StoryDesc = {
    Text = "只要我们的大脑仍是个谜，那么里面长满触腕也没什么好大惊小怪的。"
  },
  RelicConfig_13818_BattleDesc = {
    Text = "暴击率提高 50%，但战斗开始时<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  RelicConfig_13818_Desc = {
    Text = "暴击率提高 50%，但战斗开始时<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  RelicConfig_13818_Name = {
    Text = "<RedQuality:古怪钩爪>"
  },
  RelicConfig_13818_StoryDesc = {
    Text = "难以辨识的物种。"
  },
  RelicConfig_13819_BattleDesc = {
    Text = "打出 1 张算力消耗为 3 或以上的卡牌时，抽 1 张牌并获得 1 点算力。"
  },
  RelicConfig_13819_Desc = {
    Text = "打出 1 张算力消耗为 3 或以上的卡牌时，抽 1 张牌并获得 1 点算力。"
  },
  RelicConfig_13819_Name = {
    Text = "<OrangeQuality:☆失落之美☆>"
  },
  RelicConfig_13819_StoryDesc = {
    Text = "已无人记得她的美。"
  },
  RelicConfig_13820_BattleDesc = {
    Text = "每当获得症状卡后，使最大生命提高 [Arg1] 点。"
  },
  RelicConfig_13820_Desc = {
    Text = "每当获得症状卡后，使最大生命提高 [Arg1] 点。"
  },
  RelicConfig_13820_Name = {
    Text = "<WhiteQuality:☆乳香制剂☆>"
  },
  RelicConfig_13820_StoryDesc = {
    Text = "「甜美诱人的香气。」"
  },
  RelicConfig_13821_BattleDesc = {
    Text = "释放狂气爆发后，抽 1 张牌。若生命低于 25%，额外抽 1 张牌。"
  },
  RelicConfig_13821_Desc = {
    Text = "释放狂气爆发后，抽 1 张牌。若生命低于 25%，额外抽 1 张牌。"
  },
  RelicConfig_13821_Name = {
    Text = "<OrangeQuality:求知读书轮>"
  },
  RelicConfig_13821_StoryDesc = {
    Text = "阅读时请注意安全。"
  },
  RelicConfig_13822_BattleDesc = {
    Text = "每回合造成主动伤害时，提高 [Arg1] 点临时<TentacleInjurieIconKeywords:触腕伤害>，最多堆叠 3 次。层数满时生成 1 条无视触腕上限的临时触腕。"
  },
  RelicConfig_13822_Desc = {
    Text = "每回合造成主动伤害时，提高 [Arg1] 点临时<TentacleInjurieIconKeywords:触腕伤害> ，最多堆叠 3 次。层数满时生成 1 条无视触腕上限的临时触腕。"
  },
  RelicConfig_13822_Name = {
    Text = "<OrangeQuality:螺湮的欢愉>"
  },
  RelicConfig_13822_StoryDesc = {
    Text = "长眠之主，候汝入梦。"
  },
  RelicConfig_13823_BattleDesc = {
    Text = "你每打出的第 [Arg1] 张指令卡会生效 2 次，打出后回到手中。"
  },
  RelicConfig_13823_Desc = {
    Text = "你每打出的第 [Arg1] 张指令卡会生效 2 次，打出后回到手中。"
  },
  RelicConfig_13823_Name = {
    Text = "<OrangeQuality:群星之酒+>"
  },
  RelicConfig_13823_StoryDesc = {
    Text = "游走于繁星之间。"
  },
  RelicConfig_13824_BattleDesc = {
    Text = "每回合开始时<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上时，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  RelicConfig_13824_Desc = {
    Text = "每回合开始时<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上时，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  RelicConfig_13824_Name = {
    Text = "<WhiteQuality:人鱼泪珠>"
  },
  RelicConfig_13824_StoryDesc = {
    Text = "不要将它放入水中。"
  },
  RelicConfig_13825_BattleDesc = {
    Text = "每消耗 10 个黑印，回复 [Arg1] 点生命。"
  },
  RelicConfig_13825_Desc = {
    Text = "每消耗 10 个黑印，回复 1% 生命。"
  },
  RelicConfig_13825_Name = {Text = "逆生根"},
  RelicConfig_13826_BattleDesc = {
    Text = "每使用一张「增益卡」/ 「症状卡」/「状态卡」，狂气最低的唤醒体获得 10 狂气。"
  },
  RelicConfig_13826_Desc = {
    Text = "每使用一张「增益卡」/ 「症状卡」/「状态卡」，狂气最低的唤醒体获得 10 狂气。"
  },
  RelicConfig_13826_Name = {
    Text = "<WhiteQuality:异乡邮票夹>"
  },
  RelicConfig_13826_StoryDesc = {
    Text = "被量化的思念。"
  },
  RelicConfig_13827_BattleDesc = {
    Text = "拾取后获得 75 黑印。选择 1 个造物，使其变化为 1 个随机诅咒造物。"
  },
  RelicConfig_13827_Desc = {
    Text = "拾取后获得 75 黑印。选择 1 个造物，使其变化为 1 个随机诅咒造物。"
  },
  RelicConfig_13827_Name = {
    Text = "<RedQuality:诅咒石碑>"
  },
  RelicConfig_13827_StoryDesc = {
    Text = "抚摸时听见了深海的呼唤。"
  },
  RelicConfig_13828_BattleDesc = {
    Text = "每回合首次打出指令卡进入弃牌堆后，将算力消耗降低 1 的该卡牌临时复制洗入抽牌堆。"
  },
  RelicConfig_13828_Desc = {
    Text = "每回合首次打出指令卡进入弃牌堆后，将算力消耗降低 1 的该卡牌临时复制洗入抽牌堆。"
  },
  RelicConfig_13828_Name = {
    Text = "<WhiteQuality:失声唱机>"
  },
  RelicConfig_13828_StoryDesc = {
    Text = "他的声音消失在了风中。"
  },
  RelicConfig_13829_BattleDesc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_13829_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  RelicConfig_13829_Name = {
    Text = "锈蚀钥匙"
  },
  RelicConfig_13830_BattleDesc = {
    Text = "造成生命回复时也会获得 [Arg1] 点护盾。第 3 回合开始后获得 [Arg2] 点<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13830_Desc = {
    Text = "造成生命回复时也会获得 [Arg1] 点护盾。第 3 回合开始后获得 [Arg2] 点<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13830_Name = {
    Text = "<WhiteQuality:蝴蝶标本>"
  },
  RelicConfig_13830_StoryDesc = {
    Text = "至今，他也被谁深深地喜爱着。"
  },
  RelicConfig_13831_BattleDesc = {
    Text = "每当一张指令卡进入<DimensionalSpaceIconKeywords:超维空间>后，使对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13831_Desc = {
    Text = "每当一张指令卡进入<DimensionalSpaceIconKeywords:超维空间>后，使对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13831_Name = {
    Text = "<WhiteQuality:时间之虫>"
  },
  RelicConfig_13831_StoryDesc = {
    Text = "一块同时存在于钟表店与昆虫博物馆的怀表。\n洪积元年开始后，被纳入大学馆藏。"
  },
  RelicConfig_13832_BattleDesc = {
    Text = "进入超维回合后解除自身<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>状态，并<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 3 回合，本回合所有唤醒体最终伤害提高 15%。"
  },
  RelicConfig_13832_Desc = {
    Text = "进入超维回合后解除自身<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>状态，并<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 3 回合，本回合所有唤醒体最终伤害提高 15%。"
  },
  RelicConfig_13832_Name = {
    Text = "<WhiteQuality:超弦怀表>"
  },
  RelicConfig_13832_StoryDesc = {
    Text = "「哎呀，怀表停了。」"
  },
  RelicConfig_13833_BattleDesc = {
    Text = "每造成 1 次伤害，对目标施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13833_Desc = {
    Text = "每造成 1 次伤害，对目标施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13833_Name = {
    Text = "<OrangeQuality:☆蒙尘缝纫机☆>"
  },
  RelicConfig_13833_StoryDesc = {
    Text = "一位慈祥的母亲，缝补心脏上的伤。"
  },
  RelicConfig_13834_BattleDesc = {
    Text = "每第 5 次获得护盾时，同时获得<RetaliateIconKeywords:反击>，反击值等于获得护盾的 [Arg1]%。"
  },
  RelicConfig_13834_Desc = {
    Text = "每第 5 次获得护盾时，同时获得<RetaliateIconKeywords:反击>，反击值等于获得护盾的 [Arg1]%。"
  },
  RelicConfig_13834_Name = {
    Text = "<OrangeQuality:先贤断章>"
  },
  RelicConfig_13834_StoryDesc = {
    Text = "「人类何其愚蠢，只因陈腐，便会盲信。」"
  },
  RelicConfig_13835_BattleDesc = {
    Text = "回合开始时抽 1 张牌。"
  },
  RelicConfig_13835_Desc = {
    Text = "回合开始时抽 1 张牌。"
  },
  RelicConfig_13835_Name = {
    Text = "<WhiteQuality:定向罗盘>"
  },
  RelicConfig_13835_StoryDesc = {
    Text = "指示的并非方向，仅是磁场。"
  },
  RelicConfig_13836_BattleDesc = {
    Text = "战斗开始时，随机将<DerivativeCardKeywords_3:「惊厥」>和<DerivativeCardKeywords_4:「灵感」>置入<DimensionalSpaceIconKeywords:超维空间>直至达到上限。进入超维回合后，获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13836_Desc = {
    Text = "战斗开始时，随机将<DerivativeCardKeywords_3:「惊厥」>和<DerivativeCardKeywords_4:「灵感」>置入<DimensionalSpaceIconKeywords:超维空间>直至达到上限。进入超维回合后，获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13836_Name = {
    Text = "<RedQuality:阿方索之器>"
  },
  RelicConfig_13836_StoryDesc = {
    Text = "不同于无常的命运，群星自有运行法则。"
  },
  RelicConfig_13837_BattleDesc = {
    Text = "拾取时获得 100% <DeathResistanceIconKeywords:死亡抵抗>（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。触发<DeathResistanceIconKeywords:死亡抵抗>后，本场战斗每回合开始时回复 [Arg1] 点生命。"
  },
  RelicConfig_13837_Desc = {
    Text = "拾取时获得 100% <DeathResistanceIconKeywords:死亡抵抗>（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。触发<DeathResistanceIconKeywords:死亡抵抗>后，本场战斗每回合开始时回复 [Arg1] 点生命。"
  },
  RelicConfig_13837_Name = {
    Text = "<WhiteQuality:人工呼吸>"
  },
  RelicConfig_13837_StoryDesc = {
    Text = "探险者必备的好东西。过度依赖它的话，它就会成为你的一部分。"
  },
  RelicConfig_13838_BattleDesc = {
    Text = "这是个没有效果的任务造物2"
  },
  RelicConfig_13838_Desc = {
    Text = "这是个没有效果的任务造物2"
  },
  RelicConfig_13838_Name = {
    Text = "任务造物测试2"
  },
  RelicConfig_13838_StoryDesc = {
    Text = "需要补充内容的造物"
  },
  RelicConfig_13839_BattleDesc = {
    Text = "打出手牌中最后 1 张牌时，抽 2 张牌。每回合最多触发 2 次。"
  },
  RelicConfig_13839_Desc = {
    Text = "打出手牌中最后 1 张牌时，抽 2 张牌。每回合最多触发 2 次。"
  },
  RelicConfig_13839_Name = {
    Text = "<WhiteQuality:☆魔术手套☆>"
  },
  RelicConfig_13839_StoryDesc = {
    Text = "「别害怕，这只是魔术。」"
  },
  RelicConfig_13840_BattleDesc = {
    Text = "每 3 回合对所有敌人添加 1 层<WeaknessIconKeywords:虚弱>。对<WeaknessIconKeywords:虚弱>敌人造成伤害后获得  [Arg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  RelicConfig_13840_Desc = {
    Text = "每 3 回合对所有敌人添加 1 层<WeaknessIconKeywords:虚弱>。对<WeaknessIconKeywords:虚弱>敌人造成伤害后获得 [Arg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  RelicConfig_13840_Name = {
    Text = "<WhiteQuality:恶童>"
  },
  RelicConfig_13840_StoryDesc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  RelicConfig_13841_BattleDesc = {
    Text = "所有「打击」造成的暴击伤害提高 20%。战斗开始时，将 1 张<DerivativeCardKeywords_40:「美丽瞬间 」>加入手中。"
  },
  RelicConfig_13841_Desc = {
    Text = "所有「打击」造成的暴击伤害提高 20%。战斗开始时，将 1 张<DerivativeCardKeywords_40:「美丽瞬间 」>加入手中。"
  },
  RelicConfig_13841_Name = {
    Text = "<WhiteQuality:美丽瞬间>"
  },
  RelicConfig_13841_StoryDesc = {
    Text = "将须臾的美保存至永远。"
  },
  RelicConfig_13842_BattleDesc = {
    Text = "免疫一次未触发死亡抵抗的致命伤害，回复 [Arg1] 生命并使该造物永久失效。"
  },
  RelicConfig_13842_Desc = {
    Text = "免疫一次未触发死亡抵抗的致命伤害，回复 [Arg1] 生命并使该造物永久失效。"
  },
  RelicConfig_13842_Name = {
    Text = "<OrangeQuality:替身玩偶>"
  },
  RelicConfig_13842_StoryDesc = {
    Text = "嘻嘻嘻，嘻嘻嘻。是你欠我的哦？"
  },
  RelicConfig_13844_BattleDesc = {
    Text = "你造成<WeaknessIconKeywords:虚弱>时，获得 [Arg1] 点护盾；造成<VulnerabilityIconKeywords:易伤>时，获得 [Arg2] 点临时<PowerIconKeywords:力量>。若在 1 回合内触发了这两个效果，额外获得 [Arg1] 点护盾和 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13844_Desc = {
    Text = "你造成<WeaknessIconKeywords:虚弱>时，获得 [Arg1] 点护盾；造成<VulnerabilityIconKeywords:易伤>时，获得 [Arg2] 点临时<PowerIconKeywords:力量>。若在 1 回合内触发了这两个效果，额外获得 [Arg1] 点护盾和 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13844_Name = {
    Text = "<OrangeQuality:沉重画框>"
  },
  RelicConfig_13844_StoryDesc = {
    Text = "一位精神错乱的艺术家留下的最后作品，据说能从其中看到他惊恐的面容。"
  },
  RelicConfig_13845_BattleDesc = {
    Text = "耗尽最后 1 点算力时，获得 2 算力。每回合最多触发 2 次。"
  },
  RelicConfig_13845_Desc = {
    Text = "耗尽最后 1 点算力时，获得 2 算力。每回合最多触发 2 次。"
  },
  RelicConfig_13845_Name = {
    Text = "<OrangeQuality:☆银白差分机☆>"
  },
  RelicConfig_13845_StoryDesc = {
    Text = "「它改变了历史。」"
  },
  RelicConfig_13846_BattleDesc = {
    Text = "每当你失去生命，就获得 [Arg1] 点<PowerIconKeywords:力量>，每场战斗最多堆叠 10 次。层数满时，回复已损失生命值 25% 的生命。"
  },
  RelicConfig_13846_Desc = {
    Text = "每当你失去生命，就获得 [Arg1] 点<PowerIconKeywords:力量>，每场战斗最多堆叠 10 次。层数满时，回复已损失生命值 25% 的生命。"
  },
  RelicConfig_13846_Name = {
    Text = "<OrangeQuality:无上荣宠>"
  },
  RelicConfig_13846_StoryDesc = {
    Text = "优雅、神秘的黑色短毛猫，据说在某个远方的沙漠国度被视作神明的化身。可那位神祇的名讳，如今已无人知晓。\n被崇拜，被敬仰，被遗忘，或许是为神明的宿命。"
  },
  RelicConfig_13847_BattleDesc = {
    Text = "对处于负面状态的敌人造成的伤害提高 20%，击杀敌人后击杀者获得 20 狂气。"
  },
  RelicConfig_13847_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 20%，击杀敌人后击杀者获得 20 狂气。"
  },
  RelicConfig_13847_Name = {
    Text = "<OrangeQuality:祭司权杖>"
  },
  RelicConfig_13847_StoryDesc = {
    Text = "不被许可的虔诚。"
  },
  RelicConfig_13848_BattleDesc = {
    Text = "拾取时队伍界域精通变为原始值的 150%。每回合打出第 5 张指令卡后，所有唤醒体获得 20 狂气。"
  },
  RelicConfig_13848_Desc = {
    Text = "拾取时队伍界域精通变为原始值的 150%。每回合打出第 5 张指令卡后，所有唤醒体获得 20 狂气。"
  },
  RelicConfig_13848_Name = {
    Text = "<OrangeQuality:时灵摆「不洁」>"
  },
  RelicConfig_13849_BattleDesc = {
    Text = "每回合造成第 3 次伤害后，获得 [Arg1] 点护盾。每回合造成第 6 次伤害后，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13849_Desc = {
    Text = "每回合造成第 3 次伤害后，获得 [Arg1] 点护盾。每回合造成第 6 次伤害后，获得 [Arg2] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13849_Name = {
    Text = "<WhiteQuality:安全出口>"
  },
  RelicConfig_13849_StoryDesc = {
    Text = "看来，他也没能逃出去。"
  },
  RelicConfig_13851_BattleDesc = {
    Text = "每进行 1 次<DevouredIconKeywords:吞噬>，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13851_Desc = {
    Text = "每进行 1 次<DevouredIconKeywords:吞噬>，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13851_Name = {
    Text = "<OrangeQuality:妙手空空>"
  },
  RelicConfig_13851_StoryDesc = {
    Text = "杀人越货挠痒痒的绝佳工具。"
  },
  RelicConfig_13852_BattleDesc = {
    Text = "拾取时选择一名唤醒体将其觉醒，其觉醒卡算力消耗永久降低 1。"
  },
  RelicConfig_13852_Desc = {
    Text = "拾取时选择一名唤醒体将其觉醒，其觉醒卡算力消耗永久降低 1。"
  },
  RelicConfig_13852_Name = {
    Text = "<WhiteQuality:彩蛋时间>"
  },
  RelicConfig_13852_StoryDesc = {
    Text = "纵享欢乐，但不可食用。"
  },
  RelicConfig_13853_BattleDesc = {
    Text = "每当造成伤害时获得 [Arg1] 点临时<RetaliateIconKeywords:反击>，每回合最多触发 5 次，第 5 次触发时将一张 <DerivativeCardKeywords_4:「灵感」> 置入抽牌堆。"
  },
  RelicConfig_13853_Desc = {
    Text = "每当造成伤害时获得 [Arg1] 点临时<RetaliateIconKeywords:反击>，每回合最多触发 5 次，第 5 次触发时将一张 <DerivativeCardKeywords_4:「灵感」> 置入抽牌堆。"
  },
  RelicConfig_13853_Name = {
    Text = "<WhiteQuality:遗落的祭祀刀>"
  },
  RelicConfig_13853_StoryDesc = {
    Text = "刃面弯曲的匕首，常用于祭祀仪式。"
  },
  RelicConfig_13854_BattleDesc = {
    Text = "回合开始时抽 2 张牌，获得 2 点算力。每当你抽到 1 张指令卡或灵知觉醒时，随机变化其算力消耗。（0-4）"
  },
  RelicConfig_13854_Desc = {
    Text = "回合开始时抽 2 张牌，获得 2 点算力。每当你抽到 1 张指令卡或灵知觉醒时，随机变化其算力消耗。（0-4）"
  },
  RelicConfig_13854_Name = {
    Text = "<RedQuality:诡术礼帽>"
  },
  RelicConfig_13854_StoryDesc = {
    Text = "欢迎来到卡茜亚小姐的仙境马戏团！小心些，不要随便触碰魔术道具哦。要是一不小心被咬伤，那可就糟糕了。\n毕竟，它上一次尝到血的滋味，造成的后果可是很恐怖的。\n\n礼帽眨了眨眼睛，仿佛随时会破茧而出。"
  },
  RelicConfig_13855_BattleDesc = {
    Text = "回合开始和每回合回复生命时获得 [Arg1] 点<RetaliateIconKeywords:反击>，每回合最多获得 3 次反击。达到上限时，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13855_Desc = {
    Text = "回合开始和每回合回复生命时获得 [Arg1] 点<RetaliateIconKeywords:反击>，每回合最多获得 3 次反击。达到上限时，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13855_Name = {
    Text = "<OrangeQuality:小八音盒>"
  },
  RelicConfig_13855_StoryDesc = {
    Text = "德克斯特的宅邸中有许多藏品，在被摔坏前，小八音盒曾是德克斯特小小姐最喜欢的玩具。\n时光荏苒，当德克斯特小姐再次找到她时，她齿轮松弛、音乐变调，却仍未停止旋转。"
  },
  RelicConfig_13856_BattleDesc = {
    Text = "暴击伤害提高 15%。「打击」暴击率提高 40%。"
  },
  RelicConfig_13856_Desc = {
    Text = "暴击伤害提高 15%。「打击」暴击率提高 40%。"
  },
  RelicConfig_13856_Name = {
    Text = "<WhiteQuality:白鸦喙>"
  },
  RelicConfig_13856_StoryDesc = {
    Text = "在它面前没有秘密。"
  },
  RelicConfig_13857_BattleDesc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点<RetaliateIconKeywords:反击>。若本场战斗内第 6 次触发，则使你的<RetaliateIconKeywords:反击>翻倍。"
  },
  RelicConfig_13857_Desc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点<RetaliateIconKeywords:反击>。若本场战斗内第 6 次触发，则使你的<RetaliateIconKeywords:反击>翻倍。"
  },
  RelicConfig_13857_Name = {
    Text = "<OrangeQuality:☆六分仪☆>"
  },
  RelicConfig_13857_StoryDesc = {
    Text = "为你指引的，仅有歧途。"
  },
  RelicConfig_13858_BattleDesc = {
    Text = "每回合额外抽 1 张牌，获得 1 点算力。"
  },
  RelicConfig_13858_Desc = {
    Text = "每回合额外抽 1 张牌，获得 1 点算力。"
  },
  RelicConfig_13858_Name = {
    Text = "<OrangeQuality:☆美好回忆☆>"
  },
  RelicConfig_13858_StoryDesc = {
    Text = "有人永远留在了那个夏天。"
  },
  RelicConfig_13859_BattleDesc = {
    Text = "回合开始时抽 1 张牌。战斗开始时，将 1 张<DerivativeCardKeywords_4:「灵感」>洗入你的牌库。每通过 1 场战斗都会使洗入的<DerivativeCardKeywords_4:「灵感」>提高 1，最多 3 次。"
  },
  RelicConfig_13859_Desc = {
    Text = "回合开始时抽 1 张牌。战斗开始时，将 1 张<DerivativeCardKeywords_4:「灵感」>洗入你的牌库。每通过 1 场战斗都会使洗入的<DerivativeCardKeywords_4:「灵感」>提高 1，最多 3 次。"
  },
  RelicConfig_13859_Name = {
    Text = "<OrangeQuality:普拉斯诺镜>"
  },
  RelicConfig_13859_StoryDesc = {
    Text = "光与影的戏法。"
  },
  RelicConfig_13860_BattleDesc = {
    Text = "每当连续打出同一个唤醒体的牌，该唤醒体获得 8 狂气。"
  },
  RelicConfig_13860_Desc = {
    Text = "每当连续打出同一个唤醒体的牌，该唤醒体获得 8 狂气。"
  },
  RelicConfig_13860_Name = {
    Text = "<WhiteQuality:精密计时器>"
  },
  RelicConfig_13860_StoryDesc = {
    Text = "人类有史以来最邪恶的发明之一。"
  },
  RelicConfig_13861_BattleDesc = {
    Text = "拾取时选择一张唤醒体的卡牌，使其算力消耗降低 1，并将其视为「打击」。"
  },
  RelicConfig_13861_Desc = {
    Text = "拾取时选择一张唤醒体的卡牌，使其算力消耗降低 1，并将其视为「打击」。"
  },
  RelicConfig_13861_Name = {
    Text = "<OrangeQuality:偶然谬误>"
  },
  RelicConfig_13861_StoryDesc = {
    Text = "笑个痛快！"
  },
  RelicConfig_13862_BattleDesc = {
    Text = "拾取后永久失去 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_13862_Desc = {
    Text = "拾取后永久失去 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_13862_Name = {
    Text = "<RedQuality:七鳃鳗之吻>"
  },
  RelicConfig_13862_StoryDesc = {
    Text = "想要一个深深的吻吗？要你命的那种。"
  },
  RelicConfig_13863_BattleDesc = {
    Text = "每场战斗的首个回合，获得 3 点算力。"
  },
  RelicConfig_13863_Desc = {
    Text = "每场战斗的首个回合，获得 3 点算力。"
  },
  RelicConfig_13863_Name = {
    Text = "<WhiteQuality:怀表镜>"
  },
  RelicConfig_13863_StoryDesc = {
    Text = "记忆凝固在往昔的时间，深埋于黑色之底。"
  },
  RelicConfig_13864_BattleDesc = {
    Text = "每回合第一次打出指令卡后，将对应唤醒体的一张「打击」置入手中，赋予其<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13864_Desc = {
    Text = "每回合第一次打出指令卡后，将对应唤醒体的一张「打击」置入手中，赋予其<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13864_Name = {
    Text = "<WhiteQuality:新式轮轴>"
  },
  RelicConfig_13864_StoryDesc = {
    Text = "从乡村骑向都市，从灾难走向复兴。"
  },
  RelicConfig_13865_BattleDesc = {
    Text = "每回合第一次打出指令卡后，将对应唤醒体的一张「防御」置入手中并附加<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13865_Desc = {
    Text = "每回合第一次打出指令卡后，将对应唤醒体的一张「防御」置入手中并附加<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_13865_Name = {
    Text = "<WhiteQuality:寂静序曲>"
  },
  RelicConfig_13865_StoryDesc = {
    Text = "著名小提琴家埃里克·艾克施坦因的提琴。\n如今，它已不可再奏响。"
  },
  RelicConfig_13866_BattleDesc = {
    Text = "每 3 回合对所有敌人添加 1 层<VulnerabilityIconKeywords:易伤>。对<VulnerabilityIconKeywords:易伤>敌人造成伤害后，使其失去 [Arg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  RelicConfig_13866_Desc = {
    Text = "每 3 回合对所有敌人添加 1 层<VulnerabilityIconKeywords:易伤>。对<VulnerabilityIconKeywords:易伤>敌人造成伤害后，使其失去 [Arg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  RelicConfig_13866_Name = {
    Text = "<WhiteQuality:春之祭>"
  },
  RelicConfig_13866_StoryDesc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  RelicConfig_13867_BattleDesc = {
    Text = "手牌上限提高 3，但每回合抽牌数降低 1。回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_13867_Desc = {
    Text = "手牌上限提高 3，但每回合抽牌数降低 1。回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_13867_Name = {
    Text = "<RedQuality:意识铭刻>"
  },
  RelicConfig_13867_StoryDesc = {
    Text = "古老的部落坚信，在死者的头颅上篆刻特殊符号，能够将他的灵魂留下，获得永远的陪伴。"
  },
  RelicConfig_13868_BattleDesc = {
    Text = "每释放 4 次狂气爆发后，所有手牌算力消耗降低 1。"
  },
  RelicConfig_13868_Desc = {
    Text = "每释放 4 次狂气爆发后，所有手牌算力消耗降低 1。"
  },
  RelicConfig_13868_Name = {
    Text = "<WhiteQuality:☆逃生平面图☆>"
  },
  RelicConfig_13868_StoryDesc = {
    Text = "「登船后，请首先找到离舱室最近的安全出口。」"
  },
  RelicConfig_13869_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每造成 1 次主动伤害，临时触腕伤害 + [Arg1] ，每造成 1 次触腕伤害，获得 [Arg2] 点护盾。每回合最多生效 6 次。"
  },
  RelicConfig_13869_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每造成 1 次主动伤害，临时触腕伤害 + [Arg1] ，每造成 1 次触腕伤害，获得 [Arg2] 点护盾。每回合最多生效 6 次。"
  },
  RelicConfig_13869_Name = {
    Text = "<OrangeQuality:时灵摆「梦魇」>"
  },
  RelicConfig_13870_BattleDesc = {
    Text = "每消耗 1 点算力，使对应的唤醒体获得 2 点狂气。"
  },
  RelicConfig_13870_Desc = {
    Text = "每消耗 1 点算力，使对应的唤醒体获得 2 点狂气。"
  },
  RelicConfig_13870_Name = {
    Text = "<WhiteQuality:银色方扣缎带>"
  },
  RelicConfig_13870_StoryDesc = {
    Text = "曾经出现在案发现场的缎带，被外力撕扯成了两截。\n其中一截曾从高空中飘下，落在女孩的掌心。"
  },
  RelicConfig_13871_BattleDesc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。拾取时最大生命降低 30%。"
  },
  RelicConfig_13871_Desc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。拾取时最大生命降低 30%。"
  },
  RelicConfig_13871_Name = {
    Text = "<RedQuality:噩梦表象>"
  },
  RelicConfig_13871_StoryDesc = {
    Text = "小心，放纵的深眠会在你不知道的时候吞噬一切。"
  },
  RelicConfig_13873_BattleDesc = {
    Text = "打出「<ExaltIconKeywords:灵知觉醒>」后，移除所有敌人的护盾。"
  },
  RelicConfig_13873_Desc = {
    Text = "打出「<ExaltIconKeywords:灵知觉醒>」后，移除所有敌人的护盾。"
  },
  RelicConfig_13873_Name = {
    Text = "黑色镜面"
  },
  RelicConfig_13874_BattleDesc = {
    Text = "奇数回合中，剩余手牌数量为 0 时，抽 2 张牌；偶数回合中，剩余算力为 0 时，获得 2 点算力。"
  },
  RelicConfig_13874_Desc = {
    Text = "奇数回合中，剩余手牌数量为 0 时，抽 2 张牌；偶数回合中，剩余算力为 0 时，获得 2 点算力。"
  },
  RelicConfig_13874_Name = {
    Text = "异化黄金向导"
  },
  RelicConfig_13875_BattleDesc = {
    Text = "打出「打击」与「防御」后，对应唤醒体获得 35 狂气。但是它们的算力消耗+1。"
  },
  RelicConfig_13875_Desc = {
    Text = "打出「打击」与「防御」后，对应唤醒体获得 35 狂气。但是它们的算力消耗+1。"
  },
  RelicConfig_13875_Name = {
    Text = "<RedQuality:残缺面孔>"
  },
  RelicConfig_13875_StoryDesc = {
    Text = "谁的面容，充满惊恐，被凝固在时光之中。"
  },
  RelicConfig_13877_BattleDesc = {
    Text = "每回合获得第 2 次护盾后，获得 [Arg1] 层<RetaliateIconKeywords:反击>。每回合获得第 4 次护盾后，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13877_Desc = {
    Text = "每回合获得第 2 次护盾后，获得 [Arg1] 层<RetaliateIconKeywords:反击>。每回合获得第 4 次护盾后，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13877_Name = {
    Text = "<WhiteQuality:知无不言>"
  },
  RelicConfig_13877_StoryDesc = {
    Text = "它传递了无数主动或被动说出的秘密。"
  },
  RelicConfig_13878_BattleDesc = {
    Text = "每打出的第 6 张指令卡使其从弃牌堆回到手中。"
  },
  RelicConfig_13878_Desc = {
    Text = "每打出的第 6 张指令卡使其从弃牌堆回到手中。"
  },
  RelicConfig_13878_Name = {
    Text = "<OrangeQuality:在夕光里>"
  },
  RelicConfig_13878_StoryDesc = {
    Text = "一起来拍照吧！体验一把面对真实的痛感。"
  },
  RelicConfig_13879_BattleDesc = {
    Text = "每释放 5 次狂气爆发后，使释放狂气爆发的唤醒体获得 100 狂气。"
  },
  RelicConfig_13879_Desc = {
    Text = "每释放 5 次狂气爆发后，使释放狂气爆发的唤醒体获得 100 狂气。"
  },
  RelicConfig_13879_Name = {
    Text = "<OrangeQuality:小小襁褓>"
  },
  RelicConfig_13879_StoryDesc = {
    Text = "承载着希望、祝福与爱。"
  },
  RelicConfig_13880_BattleDesc = {
    Text = "造成主动伤害时获得 [Arg1] 点护盾。回复生命时，获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13880_Desc = {
    Text = "造成主动伤害时获得 [Arg1] 点护盾。回复生命时，获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13880_Name = {
    Text = "<OrangeQuality:我们的家>"
  },
  RelicConfig_13880_StoryDesc = {
    Text = "他们之前在一起，之后也会永远在一起。他们是相亲相爱的一家人。"
  },
  RelicConfig_13881_BattleDesc = {
    Text = "奇数回合开始时，获得 [Arg1] 点临时<PowerIconKeywords:力量>。偶数回合开始时，获得 [Arg2] 点临时<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13881_Desc = {
    Text = "奇数回合开始时，获得 [Arg1] 点临时<PowerIconKeywords:力量>。偶数回合开始时，获得 [Arg2] 点临时<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13881_Name = {
    Text = "<WhiteQuality:双生人偶>"
  },
  RelicConfig_13881_StoryDesc = {
    Text = "双生是旧时代的礼物，是留给未来的寓言。"
  },
  RelicConfig_13882_BattleDesc = {
    Text = "每回合打出第一张指令卡的对应唤醒体，在回合结束时获得 20 狂气，若同时拥有造物「奉献精神」，使其他唤醒体也获得 5 狂气。"
  },
  RelicConfig_13882_Desc = {
    Text = "每回合打出第一张指令卡的对应唤醒体，在回合结束时获得 20 狂气，若同时拥有造物「奉献精神」，使其他唤醒体也获得 5 狂气。"
  },
  RelicConfig_13882_Name = {
    Text = "<WhiteQuality:母亲造像>"
  },
  RelicConfig_13882_StoryDesc = {
    Text = "「给你，什么都可以给你，求求你，放过他。」"
  },
  RelicConfig_13883_BattleDesc = {
    Text = "每当一名唤醒体进行过 1 次<DevouredIconKeywords:吞噬>，其他唤醒体获得 10 狂气。"
  },
  RelicConfig_13883_Desc = {
    Text = "每当一名唤醒体进行过 1 次<DevouredIconKeywords:吞噬>，其他唤醒体获得 10 狂气。"
  },
  RelicConfig_13883_Name = {
    Text = "<OrangeQuality:金色梦乡>"
  },
  RelicConfig_13883_StoryDesc = {
    Text = "蜕变之日即是你的死期。"
  },
  RelicConfig_13884_BattleDesc = {
    Text = "「打击」对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13884_Desc = {
    Text = "「打击」对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13884_Name = {
    Text = "<WhiteQuality:神经毒素>"
  },
  RelicConfig_13884_StoryDesc = {
    Text = "提取，淬炼。"
  },
  RelicConfig_13885_BattleDesc = {
    Text = "战斗开始时，将 1 张<DerivativeCardKeywords_1:「遗影回响」>置入手中，若为首领战，额外获得 1 张<DerivativeCardKeywords_1:「遗影回响」>。"
  },
  RelicConfig_13885_Desc = {
    Text = "战斗开始时，将 1 张<DerivativeCardKeywords_1:「遗影回响」>置入手中，若为首领战，额外获得 1 张<DerivativeCardKeywords_1:「遗影回响」>。"
  },
  RelicConfig_13885_Name = {
    Text = "<WhiteQuality:通讯设备>"
  },
  RelicConfig_13885_StoryDesc = {
    Text = "期待或恐惧它发出清脆铃声的瞬间。"
  },
  RelicConfig_13886_BattleDesc = {
    Text = "每次重置牌库时，将 2 张<DerivativeCardKeywords_5:「渔叉」>和 1 张<DerivativeCardKeywords_6:「阳伞」>加入手牌。"
  },
  RelicConfig_13886_Desc = {
    Text = "每次重置牌库时，将 2 张<DerivativeCardKeywords_5:「渔叉」>和 1 张<DerivativeCardKeywords_6:「阳伞」>加入手牌。"
  },
  RelicConfig_13886_Name = {
    Text = "<WhiteQuality:☆淑女小包☆>"
  },
  RelicConfig_13886_StoryDesc = {
    Text = "它本应装载精致，而不是死亡。"
  },
  RelicConfig_13887_BattleDesc = {
    Text = "回合开始时，将 1 张<DerivativeCardKeywords_5:「渔叉」>加入手中。释放狂气爆发后，使手牌中所有的<DerivativeCardKeywords_5:「渔叉」><PowerIconKeywords:力量>提高 [Arg2]。"
  },
  RelicConfig_13887_Desc = {
    Text = "回合开始时，将 1 张<DerivativeCardKeywords_5:「渔叉」>加入手中。释放狂气爆发后，使手牌中所有的<DerivativeCardKeywords_5:「渔叉」><PowerIconKeywords:力量>提高 [Arg2]。"
  },
  RelicConfig_13887_Name = {
    Text = "<WhiteQuality:渔叉>"
  },
  RelicConfig_13887_StoryDesc = {
    Text = "无论怎么看都很普通。"
  },
  RelicConfig_13888_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] 点护盾。在本场战斗内打出 7 次「防御」后，立刻获得 [Arg2] 点护盾。在本场战斗内打出 21 次「防御」后，获得 1 层临时屏障。"
  },
  RelicConfig_13888_Desc = {
    Text = "战斗开始时获得 [Arg1] 点护盾。在本场战斗内打出 7 次「防御」后，立刻获得 [Arg2] 点护盾。在本场战斗内打出 21 次「防御」后，获得 1 层临时屏障。"
  },
  RelicConfig_13888_Name = {
    Text = "<WhiteQuality:普特尼晨报>"
  },
  RelicConfig_13888_StoryDesc = {
    Text = "您最贴心的马桶伴侣。"
  },
  RelicConfig_13889_BattleDesc = {
    Text = "进入超维回合后，获得 3 点算力。"
  },
  RelicConfig_13889_Desc = {
    Text = "进入超维回合后，获得 3 点算力。"
  },
  RelicConfig_13889_Name = {
    Text = "<WhiteQuality:辉光沙漏>"
  },
  RelicConfig_13889_StoryDesc = {
    Text = "一份可计量的时间。"
  },
  RelicConfig_13890_BattleDesc = {
    Text = "战斗开始时，对所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，若为首领战，额外施加 2 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  RelicConfig_13890_Desc = {
    Text = "战斗开始时，对所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>，若为首领战，额外施加 2 回合的<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  RelicConfig_13890_Name = {
    Text = "<WhiteQuality:变色拘束服>"
  },
  RelicConfig_13890_StoryDesc = {
    Text = "不止有时间能使织物变色，恐惧与痛苦亦能。"
  },
  RelicConfig_13891_BattleDesc = {
    Text = "每回合打出的第 1 张指令卡若触发了跃迁效果，抽 1 张牌，否则获得 1 点算力。若为超维回合，同时具有以上 2 个效果。"
  },
  RelicConfig_13891_Desc = {
    Text = "每回合打出的第 1 张指令卡若触发了跃迁效果，抽 1 张牌，否则获得 1 点算力。若为超维回合，同时具有以上 2 个效果。"
  },
  RelicConfig_13891_Name = {
    Text = "<OrangeQuality:跃迁装置>"
  },
  RelicConfig_13891_StoryDesc = {
    Text = "折射出扭曲的影子。"
  },
  RelicConfig_13892_BattleDesc = {
    Text = "获得一个任务。完成任务后，获得奖励。【任务事件占位】"
  },
  RelicConfig_13892_Desc = {
    Text = "获得一个任务。完成任务后，获得奖励。【任务事件占位】"
  },
  RelicConfig_13892_Name = {
    Text = "<WhiteQuality:破旧的日记本>"
  },
  RelicConfig_13892_StoryDesc = {
    Text = "一本破旧的日记本，内页中塞满了夹页，粗看至少包含艾尔沃斯地图、实验记录、布满三角融蚀痕的信笺。\n笔记前段的内容字迹工整端正，后续却逐步潦草凌乱。"
  },
  RelicConfig_13893_BattleDesc = {
    Text = "每第 4 次获得护盾值时，回复等同于该次护盾值 50%的生命。"
  },
  RelicConfig_13893_Desc = {
    Text = "每第 4 次获得护盾值时，回复等同于该次护盾值 50%的生命。"
  },
  RelicConfig_13893_Name = {
    Text = "<WhiteQuality:水手哨>"
  },
  RelicConfig_13893_StoryDesc = {
    Text = "除开美人鱼，哨声还能吹来飓风、臭皮靴和一百天没洗澡的老水手。"
  },
  RelicConfig_13894_BattleDesc = {
    Text = "若上回合打出的卡牌数量小于等于 4，本回合打出的第一张卡牌生效 2 次。"
  },
  RelicConfig_13894_Desc = {
    Text = "若上回合打出的卡牌数量小于等于 4，本回合打出的第一张卡牌生效 2 次。"
  },
  RelicConfig_13894_Name = {
    Text = "<OrangeQuality:☆噩梦魂灯☆>"
  },
  RelicConfig_13894_StoryDesc = {
    Text = "引入幻梦。"
  },
  RelicConfig_13895_BattleDesc = {
    Text = "每当你失去生命时，狂气最低的唤醒体获得 10 狂气。每当你失去 5 次生命时，回复 20% 已损失生命。"
  },
  RelicConfig_13895_Desc = {
    Text = "每当你失去生命时，狂气最低的唤醒体获得 10 狂气。每当你失去 5 次生命时，回复 20% 已损失生命。"
  },
  RelicConfig_13895_Name = {
    Text = "<OrangeQuality:时灵摆「解析」>"
  },
  RelicConfig_13896_BattleDesc = {
    Text = "最大算力提高 2。每次重置牌库时将 1 张<DerivativeCardKeywords_9:「蹒跚」>加入抽牌堆。"
  },
  RelicConfig_13896_Desc = {
    Text = "最大算力提高 2。每次重置牌库时将 1 张<DerivativeCardKeywords_9:「蹒跚」>加入抽牌堆。"
  },
  RelicConfig_13896_Name = {
    Text = "<RedQuality:黑烛>"
  },
  RelicConfig_13896_StoryDesc = {
    Text = "燃烧清醒，堕入虚妄。"
  },
  RelicConfig_13897_BattleDesc = {
    Text = "「<ExaltIconKeywords:灵知觉醒>」在回合结束时保留。"
  },
  RelicConfig_13897_Desc = {
    Text = "「<ExaltIconKeywords:灵知觉醒>」在回合结束时保留。"
  },
  RelicConfig_13897_Name = {
    Text = "白色镜面"
  },
  RelicConfig_13898_BattleDesc = {
    Text = "每有 1 个唤醒体已觉醒就使<ProficientInRealmsIconKeywords:界域精通>提高 35。打出「<ExaltIconKeywords:灵知觉醒>」后，随机获得 2 张该唤醒体的指令卡并附加「消耗」。"
  },
  RelicConfig_13898_Desc = {
    Text = "每有 1 个唤醒体已觉醒就使<ProficientInRealmsIconKeywords:界域精通>提高 35。打出「<ExaltIconKeywords:灵知觉醒>」后，随机获得 2 张该唤醒体的指令卡并附加「消耗」。"
  },
  RelicConfig_13898_Name = {
    Text = "<OrangeQuality:祂的神谕>"
  },
  RelicConfig_13898_StoryDesc = {
    Text = "祂说，不要惧怕。"
  },
  RelicConfig_13899_BattleDesc = {
    Text = "回合开始时<ProficientInRealmsIconKeywords:界域精通>提高 50。当不处于负面状态时，<ProficientInRealmsIconKeywords:界域精通>提高变为 150。"
  },
  RelicConfig_13899_Desc = {
    Text = "回合开始时<ProficientInRealmsIconKeywords:界域精通>提高 50。当不处于负面状态时，<ProficientInRealmsIconKeywords:界域精通>提高变为 150。"
  },
  RelicConfig_13899_Name = {
    Text = "<WhiteQuality:☆「敬自由」☆>"
  },
  RelicConfig_13899_StoryDesc = {
    Text = "一捧令人感到些许怀念的银芯。"
  },
  RelicConfig_13900_BattleDesc = {
    Text = "使用「狂气爆发」后，所有手牌算力消耗 -1。"
  },
  RelicConfig_13900_Desc = {
    Text = "使用「狂气爆发」后，所有手牌的算力消耗 -1。"
  },
  RelicConfig_13900_Name = {
    Text = "异化文明之光"
  },
  RelicConfig_13901_BattleDesc = {
    Text = "每打出 1 张指令卡就获得 [Arg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。若你<DeathResistanceIconKeywords:死亡抵抗>大于等于 100%，改为获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13901_Desc = {
    Text = "每打出 1 张指令卡就获得 [Arg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。若你<DeathResistanceIconKeywords:死亡抵抗>大于等于 100%，改为获得 [Arg1] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13901_Name = {
    Text = "<OrangeQuality:怪蛇残蜕>"
  },
  RelicConfig_13901_StoryDesc = {
    Text = "自残蜕中重生。"
  },
  RelicConfig_13902_BattleDesc = {
    Text = "回合开始后，获得 [Arg2] 点护盾。回合结束后，对随机敌人造成等同于当前护盾值 [Arg1]% 的<FixedDamage:纯粹伤害>，首领战伤害效果翻倍。"
  },
  RelicConfig_13902_Desc = {
    Text = "回合开始后，获得 [Arg2] 点护盾。回合结束后，对随机敌人造成等同于当前护盾值 [Arg1]% 的<FixedDamage:纯粹伤害>，首领战伤害效果翻倍。"
  },
  RelicConfig_13902_Name = {
    Text = "<WhiteQuality:黄金向导>"
  },
  RelicConfig_13902_StoryDesc = {
    Text = "迷失方向的时候打开它吧，但要小心——它的日冕不可见到日光。"
  },
  RelicConfig_13904_BattleDesc = {
    Text = "隐藏怪物意图。每回合获得 1 点算力，抽 1 张牌。"
  },
  RelicConfig_13904_Desc = {
    Text = "隐藏怪物意图。每回合获得 1 点算力，抽 1 张牌。"
  },
  RelicConfig_13904_Name = {
    Text = "<RedQuality:蛊惑风铃>"
  },
  RelicConfig_13904_StoryDesc = {
    Text = "叮铃铃，叮铃铃。"
  },
  RelicConfig_13905_BattleDesc = {
    Text = "战斗开始后，获得 [Arg2] 层<RetaliateIconKeywords:反击>，打出「防御」获得 [Arg1] 层<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13905_Desc = {
    Text = "战斗开始后，获得 [Arg2] 层<RetaliateIconKeywords:反击>，打出「防御」获得 [Arg1] 层<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13905_Name = {
    Text = "<WhiteQuality:刺荨麻背心>"
  },
  RelicConfig_13905_StoryDesc = {
    Text = "无法分辨沾染的液体。"
  },
  RelicConfig_13906_BattleDesc = {
    Text = "这是个没有效果的周替造物4"
  },
  RelicConfig_13906_Desc = {
    Text = "这是个没有效果的周替造物4"
  },
  RelicConfig_13906_Name = {
    Text = "日常挑战周替造物4"
  },
  RelicConfig_13907_BattleDesc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 3 张，抽 2 张牌。"
  },
  RelicConfig_13907_Desc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 3 张，抽 2 张牌。"
  },
  RelicConfig_13907_Name = {
    Text = "<WhiteQuality:崭新的钱包>"
  },
  RelicConfig_13907_StoryDesc = {
    Text = "印刻了弥萨格大学校徽的皮质钱包。\n里面现在空空如也，什么也没有。"
  },
  RelicConfig_13908_BattleDesc = {
    Text = "使用「狂气爆发」后，所属唤醒体获得[Arg1]点狂气。"
  },
  RelicConfig_13908_Desc = {
    Text = "使用「狂气爆发」后，所属唤醒体获得[Arg1]点狂气。"
  },
  RelicConfig_13908_Name = {
    Text = "异化无名之神的面纱"
  },
  RelicConfig_13909_BattleDesc = {
    Text = "释放狂气爆发后，失去 8% 当前生命，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13909_Desc = {
    Text = "释放狂气爆发后，失去 8% 当前生命，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13909_Name = {
    Text = "<RedQuality:厄运仪式鸟>"
  },
  RelicConfig_13909_StoryDesc = {
    Text = "干瘪的尸体发出了鸣叫声。"
  },
  RelicConfig_13910_BattleDesc = {
    Text = "释放狂气爆发后，对应唤醒体获得 10 狂气，获得 [Arg1] 点护盾。"
  },
  RelicConfig_13910_Desc = {
    Text = "释放狂气爆发后，对应唤醒体获得 10 狂气，获得 [Arg1] 点护盾。"
  },
  RelicConfig_13910_Name = {
    Text = "<OrangeQuality:无名之神的面纱>"
  },
  RelicConfig_13910_StoryDesc = {
    Text = "不可直视神。"
  },
  RelicConfig_13911_BattleDesc = {
    Text = "每回合打出最后一张指令卡的对应唤醒体，在回合结束时获得 20 狂气，若同时拥有造物「母亲造像」，使其他唤醒体也获得 5 狂气。"
  },
  RelicConfig_13911_Desc = {
    Text = "每回合打出最后一张指令卡的对应唤醒体，在回合结束时获得 20 狂气，若同时拥有造物「母亲造像」，使其他唤醒体也获得 5 狂气。"
  },
  RelicConfig_13911_Name = {
    Text = "<WhiteQuality:奉献精神>"
  },
  RelicConfig_13911_StoryDesc = {
    Text = "「给你，什么都可以给你，求求你，饶过我。」"
  },
  RelicConfig_13912_BattleDesc = {
    Text = "回合结束时，每有 1 张剩余手牌，下回合开始时获得 1 点算力。"
  },
  RelicConfig_13912_Desc = {
    Text = "回合结束时，每有 1 张剩余手牌，下回合开始时获得 1 点算力。"
  },
  RelicConfig_13912_Name = {
    Text = "<OrangeQuality:时灵摆「演绎」>"
  },
  RelicConfig_13913_BattleDesc = {
    Text = "回合开始时若生命大于 [Arg1]，失去 [Arg1] 点生命，当回合内获得 [Arg2] 点<PowerIconKeywords:力量>和 [Arg3] 点<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13913_Desc = {
    Text = "回合开始时若生命大于 [Arg1]，失去 [Arg1] 点生命，当回合内获得 [Arg2] 点<PowerIconKeywords:力量>和 [Arg3] 点<AlertIconKeywords:戒备>。"
  },
  RelicConfig_13913_Name = {
    Text = "<RedQuality:救济之肢>"
  },
  RelicConfig_13913_StoryDesc = {
    Text = "神圣的一部分。\n纵然与躯干分离，仍能感受到其上的温暖。"
  },
  RelicConfig_13914_BattleDesc = {
    Text = "「打击」获得 2 点算力，随机弃 1 张牌；「防御」抽 2 张牌，失去 1 点算力。每回合最多触发 3 次。"
  },
  RelicConfig_13914_Desc = {
    Text = "「打击」获得 2 点算力，随机弃 1 张牌；「防御」抽 2 张牌，失去 1 点算力。每回合最多触发 3 次。"
  },
  RelicConfig_13914_Name = {
    Text = "<RedQuality:快乐唱片>"
  },
  RelicConfig_13914_StoryDesc = {
    Text = "录下了著名小提琴家最后的演出的唱片。\n自那以后，它能带来火焰。"
  },
  RelicConfig_13915_BattleDesc = {
    Text = "界域推荐加成效果提升为 50%，关卡开始时你的<ProficientInRealmsIconKeywords:界域精通>翻倍。"
  },
  RelicConfig_13915_Desc = {
    Text = "界域推荐加成效果提升为 50%，关卡开始时你的<ProficientInRealmsIconKeywords:界域精通>翻倍。"
  },
  RelicConfig_13915_Name = {
    Text = "<OrangeQuality:时灵摆「入梦」>"
  },
  RelicConfig_13916_BattleDesc = {
    Text = "释放狂气爆发后，下一张打出的指令卡生效 2 次。"
  },
  RelicConfig_13916_Desc = {
    Text = "释放狂气爆发后，下一张打出的指令卡生效 2 次。"
  },
  RelicConfig_13916_Name = {
    Text = "<OrangeQuality:时灵摆「潜游」>"
  },
  RelicConfig_13917_BattleDesc = {
    Text = "若敌人的意图为攻击，造成伤害后使其 <PowerIconKeywords:力量>临时降低 [Arg1] 点，否则附加等同于 25% 伤害的<BleedingIconKeywords:出血>，每回合最多触发 6 次。"
  },
  RelicConfig_13917_Desc = {
    Text = "若敌人的意图为攻击，造成伤害后使其 <PowerIconKeywords:力量>临时降低 [Arg1] 点，否则附加等同于 25% 伤害的<BleedingIconKeywords:出血>，每回合最多触发 6 次。"
  },
  RelicConfig_13917_Name = {
    Text = "<WhiteQuality:异形之心>"
  },
  RelicConfig_13917_StoryDesc = {
    Text = "两颗相依相偎的「心脏」。"
  },
  RelicConfig_13918_BattleDesc = {
    Text = "每次造成伤害时，获得 [Arg1] 点临时<PowerIconKeywords:力量>，最多堆叠 3 次。层数满时效果翻倍。"
  },
  RelicConfig_13918_Desc = {
    Text = "每次造成伤害时，获得 [Arg1] 点临时<PowerIconKeywords:力量>，最多堆叠 3 次。层数满时效果翻倍。"
  },
  RelicConfig_13918_Name = {
    Text = "<WhiteQuality:缠丝玛瑙>"
  },
  RelicConfig_13918_StoryDesc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  RelicConfig_13919_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 50。拾取时选择一个造物，将其更换为随机造物。"
  },
  RelicConfig_13919_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 50。拾取时选择一个造物，将其更换为随机造物。"
  },
  RelicConfig_13919_Name = {
    Text = "<WhiteQuality:万花筒>"
  },
  RelicConfig_13919_StoryDesc = {
    Text = "所思所见皆为幻象。"
  },
  RelicConfig_13920_BattleDesc = {
    Text = "造成的虛弱效果提高 5%。施加<WeaknessIconKeywords:虚弱>时，临时偷取目标 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13920_Desc = {
    Text = "造成的虚弱效果提高 5%。施加<WeaknessIconKeywords:虚弱>时，临时偷取目标 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_13920_Name = {
    Text = "<WhiteQuality:褪色照片>"
  },
  RelicConfig_13920_StoryDesc = {
    Text = "模糊的照片承载了模糊的记忆，亦或者——正是记忆的残缺，才造就了照片的褪色。"
  },
  RelicConfig_13921_BattleDesc = {
    Text = "拾取时选择 2 张指令卡牌删除，获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13921_Desc = {
    Text = "拾取时选择 2 张指令卡牌删除，获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_13921_Name = {
    Text = "<RedQuality:黑星燃烧之烬>"
  },
  RelicConfig_13921_StoryDesc = {
    Text = "余火未熄。"
  },
  RelicConfig_13922_BattleDesc = {
    Text = "每回合释放狂气爆发 2 次后，所有唤醒体获得 8 点狂气，释放 3 次后，所有唤醒体再获得 8 点狂气。"
  },
  RelicConfig_13922_Desc = {
    Text = "每回合释放狂气爆发 2 次后，所有唤醒体获得 8 点狂气，释放 3 次后，所有唤醒体再获得 8 点狂气。"
  },
  RelicConfig_13922_Name = {
    Text = "<OrangeQuality:被遗忘者之血>"
  },
  RelicConfig_13922_StoryDesc = {
    Text = "日渐消融。"
  },
  RelicConfig_13923_BattleDesc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点护盾。回合开始时每有 3 点剩余护盾，获得 1 点临时<PowerIconKeywords:力量>和触腕伤害。"
  },
  RelicConfig_13923_Desc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点护盾。回合开始时每有 3 点剩余护盾，获得 1 点临时<PowerIconKeywords:力量>和触腕伤害。"
  },
  RelicConfig_13923_Name = {
    Text = "<OrangeQuality:时灵摆「隐秘」>"
  },
  RelicConfig_13924_BattleDesc = {
    Text = "每当触发<TransitionIconKeywords:跃迁>效果时，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13924_Desc = {
    Text = "每当触发<TransitionIconKeywords:跃迁>效果时，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13924_Name = {
    Text = "<OrangeQuality:空间偏折仪>"
  },
  RelicConfig_13924_StoryDesc = {
    Text = "跃入虚空。"
  },
  RelicConfig_13925_BattleDesc = {
    Text = "回合开始时抽 1 张牌。连续 2 次打出和上一张卡牌算力相同的牌时，额外抽 1 张牌，每回合最多生效 3 次。"
  },
  RelicConfig_13925_Desc = {
    Text = "回合开始时抽 1 张牌。连续 2 次打出和上一张卡牌算力相同的牌时，额外抽 1 张牌，每回合最多生效 3 次。"
  },
  RelicConfig_13925_Name = {
    Text = "<OrangeQuality:万象灵知秘仪>"
  },
  RelicConfig_13925_StoryDesc = {
    Text = "全知全能。"
  },
  RelicConfig_13926_BattleDesc = {
    Text = "战斗开始时，卡组中每拥有 1 个刻印，获得 [Arg1] 点<PowerIconKeywords:力量>，每拥有 1 个造物，回复 [Arg2] 点生命。"
  },
  RelicConfig_13926_Desc = {
    Text = "战斗开始时，卡组中每拥有 1 个刻印，获得 [Arg1] 点<PowerIconKeywords:力量>，每拥有 1 个造物，回复 [Arg2] 点生命。"
  },
  RelicConfig_13926_Name = {
    Text = "<OrangeQuality:☆商会勋章☆>"
  },
  RelicConfig_13926_StoryDesc = {
    Text = "「戴上它，你就是伦蒂尼恩商会的成员之一了。」"
  },
  RelicConfig_13927_BattleDesc = {
    Text = "拾取时删除 1 张症状卡。将 1 个随机刻印升级为高级刻印。"
  },
  RelicConfig_13927_Desc = {
    Text = "拾取时删除 1 张症状卡。将 1 个随机刻印升级为高级刻印。"
  },
  RelicConfig_13927_Name = {
    Text = "<WhiteQuality:幸运兔脚>"
  },
  RelicConfig_13927_StoryDesc = {
    Text = "对兔子来说，可就不那么幸运了。"
  },
  RelicConfig_13928_BattleDesc = {
    Text = "暴击率提高 15%。每打出 1 张牌，临时暴击率提高 5%。"
  },
  RelicConfig_13928_Desc = {
    Text = "暴击率提高 15%。每打出 1 张牌，临时暴击率提高 5%。"
  },
  RelicConfig_13928_Name = {
    Text = "<OrangeQuality:孟菲斯仪式镜>"
  },
  RelicConfig_13928_StoryDesc = {
    Text = "「你在其中窥见了什么？」"
  },
  RelicConfig_13929_BattleDesc = {
    Text = "每当你失去生命，就获得 [Arg1] 层<RetaliateIconKeywords:反击>。若为单个回合内的第 3 次触发，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13929_Desc = {
    Text = "每当你失去生命，就获得 [Arg1] 层<RetaliateIconKeywords:反击>。若为单个回合内的第 3 次触发，对所有敌人触发 100％ <RetaliateIconKeywords:反击>。"
  },
  RelicConfig_13929_Name = {
    Text = "<WhiteQuality:故人的怀表>"
  },
  RelicConfig_13929_StoryDesc = {
    Text = "肩负着怀念与感伤，向未知前进。"
  },
  RelicConfig_13930_BattleDesc = {
    Text = "回合结束时每有 1 张手牌，对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13930_Desc = {
    Text = "回合结束时每有 1 张手牌，对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13930_Name = {
    Text = "<WhiteQuality:可疑的药膏>"
  },
  RelicConfig_13930_StoryDesc = {
    Text = "某种自制的外伤药膏，请不要在没有医生指导的情况下使用。"
  },
  RelicConfig_13931_BattleDesc = {
    Text = "拾取时获得 [Arg1] <PowerIconKeywords:力量>。每当有<DerivativeCardKeywords_2:「胚胎」>被融合，获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13931_Desc = {
    Text = "拾取时获得 [Arg1] <PowerIconKeywords:力量>。每当有<DerivativeCardKeywords_2:「胚胎」>被融合，获得 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13931_Name = {
    Text = "<WhiteQuality:染血鹅卵石>"
  },
  RelicConfig_13931_StoryDesc = {
    Text = "一、二、三、四、五。"
  },
  RelicConfig_13932_BattleDesc = {
    Text = "每第 3 次打出「防御」后，获得 [Arg1] 点护盾，对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13932_Desc = {
    Text = "每第 3 次打出「防御」后，获得 [Arg1] 点护盾，对应唤醒体获得 15 狂气。"
  },
  RelicConfig_13932_Name = {
    Text = "<WhiteQuality:缄默手套>"
  },
  RelicConfig_13932_StoryDesc = {
    Text = "它们曾沾染无数鲜血、眼泪和霉菌。"
  },
  RelicConfig_13933_BattleDesc = {
    Text = "这是个没有效果的周替造物6"
  },
  RelicConfig_13933_Desc = {
    Text = "这是个没有效果的周替造物6"
  },
  RelicConfig_13933_Name = {
    Text = "日常挑战周替造物6"
  },
  RelicConfig_13934_BattleDesc = {
    Text = "这是个没有效果的周替造物5"
  },
  RelicConfig_13934_Desc = {
    Text = "这是个没有效果的周替造物5"
  },
  RelicConfig_13934_Name = {
    Text = "日常挑战周替造物5"
  },
  RelicConfig_13935_BattleDesc = {
    Text = "暴击率提高 10%。每回合首次暴击后使暴击率额外提高 20%，每回合造成第 3 次暴击后使暴击伤害额外提高 50%。"
  },
  RelicConfig_13935_Desc = {
    Text = "暴击率提高 10%。每回合首次暴击后使暴击率额外提高 20%，每回合造成第 3 次暴击后使暴击伤害额外提高 50%。"
  },
  RelicConfig_13935_Name = {
    Text = "<WhiteQuality:节日祝福>"
  },
  RelicConfig_13935_StoryDesc = {
    Text = "它理应为相爱之人带来祝福。"
  },
  RelicConfig_13936_BattleDesc = {
    Text = "这是个没有效果的周替造物3"
  },
  RelicConfig_13936_Desc = {
    Text = "这是个没有效果的周替造物3"
  },
  RelicConfig_13936_Name = {
    Text = "日常挑战周替造物3"
  },
  RelicConfig_13937_BattleDesc = {
    Text = "这是个没有效果的周替造物2"
  },
  RelicConfig_13937_Desc = {
    Text = "这是个没有效果的周替造物2"
  },
  RelicConfig_13937_Name = {
    Text = "日常挑战周替造物2"
  },
  RelicConfig_13938_BattleDesc = {
    Text = "这是个没有效果的周替造物1"
  },
  RelicConfig_13938_Desc = {
    Text = "这是个没有效果的周替造物1"
  },
  RelicConfig_13938_Name = {
    Text = "日常挑战周替造物1"
  },
  RelicConfig_13939_BattleDesc = {
    Text = "第 3 回合开始时，本场战斗暴击率 +15%，将 1 张<DerivativeCardKeywords_39:「过往回声」>加入手中。"
  },
  RelicConfig_13939_Desc = {
    Text = "第 3 回合开始时，本场战斗暴击率 +15%，将 1 张<DerivativeCardKeywords_39:「过往回声」>加入手中。"
  },
  RelicConfig_13939_Name = {
    Text = "<OrangeQuality:过往的贡物>"
  },
  RelicConfig_13939_StoryDesc = {
    Text = "曾被进献之物。"
  },
  RelicConfig_13940_BattleDesc = {
    Text = "当你拥有护盾时，该造物提供 [Arg1] 点临时<PowerIconKeywords:力量>。在你的护盾高于当前生命时，额外提供 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13940_Desc = {
    Text = "当你拥有护盾时，该造物提供 [Arg1] 点临时<PowerIconKeywords:力量>。在你的护盾高于当前生命时，额外提供 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_13940_Name = {
    Text = "<WhiteQuality:鸽羽扇>"
  },
  RelicConfig_13940_StoryDesc = {
    Text = "精致、昂贵，只是不那么实用。"
  },
  RelicConfig_13941_BattleDesc = {
    Text = "「打击」回复 [Arg1] 点生命，减少自身 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13941_Desc = {
    Text = "「打击」回复 [Arg1] 点生命，减少自身 [Arg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_13941_Name = {
    Text = "<WhiteQuality:止血钳>"
  },
  RelicConfig_13941_StoryDesc = {
    Text = "「快、快把它给我！」"
  },
  RelicConfig_13942_BattleDesc = {
    Text = "每有 1 条触腕，回合结束时获得 [Arg1] 点护盾，若触腕处于静海姿态，该效果额外获得 50% 护盾。"
  },
  RelicConfig_13942_Desc = {
    Text = "每有 1 条触腕，回合结束时获得 [Arg1] 点护盾，若触腕处于静海姿态，该效果额外获得 50% 护盾。"
  },
  RelicConfig_13942_Name = {
    Text = "<WhiteQuality:无名附肢>"
  },
  RelicConfig_13942_StoryDesc = {
    Text = "小心扎手。"
  },
  RelicConfig_139929_BattleDesc = {
    Text = "回合开始时沙耶获得 [Arg1] 狂气。沙耶狂气爆发每消耗 100 点狂气，使随机 1 张生成的「技能」额外生效 1 次。"
  },
  RelicConfig_139929_Desc = {
    Text = "回合开始时沙耶获得 [Arg1] 狂气。沙耶狂气爆发每消耗 100 点狂气，使随机 1 张生成的「技能」额外生效 1 次。"
  },
  RelicConfig_139929_Name = {
    Text = "<OrangeQuality:维度影像·沙耶>"
  },
  RelicConfig_140276_BattleDesc = {
    Text = "<OrangeQuality:背水>：回合开始时每损失 1% 最大生命，临时最终伤害提高 5%，若上回合触发过死亡抵抗，该效果翻倍。 \n<RedQuality:至高>：所有敌人最大生命提高 300%。"
  },
  RelicConfig_140276_Desc = {
    Text = "<OrangeQuality:背水>：回合开始时每损失 1% 最大生命，临时最终伤害提高 5%，若上回合触发过死亡抵抗，该效果翻倍。 \n<RedQuality:至高>：所有敌人最大生命提高 300%。"
  },
  RelicConfig_140276_Name = {
    Text = "<RedQuality:维度灵摆-死战>"
  },
  RelicConfig_140277_BattleDesc = {
    Text = "<OrangeQuality:增殖>：每回合每名唤醒体首次打出「技能」时，生成其 2 张临时原始复制。打出算力消耗为 0 或 1 的指令卡时所有唤醒体获得 5 点狂气。\n<RedQuality:堡垒>：打出原始算力消耗大于等于 3 的卡牌时，所有敌人获得 20% 最大生命的护盾。"
  },
  RelicConfig_140277_Desc = {
    Text = "<OrangeQuality:增殖>：每回合每名唤醒体首次打出「技能」时，生成其 2 张临时原始复制。打出算力消耗为 0 或 1 的指令卡时所有唤醒体获得 5 点狂气。\n<RedQuality:堡垒>：打出原始算力消耗大于等于 3 的卡牌时，所有敌人获得 20% 最大生命的护盾。"
  },
  RelicConfig_140277_Name = {
    Text = "<RedQuality:维度灵摆-警戒>"
  },
  RelicConfig_140278_BattleDesc = {
    Text = "<OrangeQuality:回生>：获得的护盾和回复效果提高 25%。回复生命或获得护盾时，每造成 1% 最大生命的回复或护盾效果，获得 10% 临时伤害强效。\n<RedQuality:低语>：每回合获得等同于最大生命 10% 的力量降低效果。"
  },
  RelicConfig_140278_Desc = {
    Text = "<OrangeQuality:回生>：获得的护盾和回复效果提高 25%。回复生命或获得护盾时，每造成 1% 最大生命的回复或护盾效果，获得 10% 临时伤害强效。\n<RedQuality:低语>：每回合获得等同于最大生命 10% 的力量降低效果。"
  },
  RelicConfig_140278_Name = {
    Text = "<RedQuality:维度灵摆-威吓>"
  },
  RelicConfig_140279_BattleDesc = {
    Text = "<OrangeQuality:破晓>：所有唤醒体基础狂气降低30点。每回合首次释放的狂气爆发最终伤害提高200%，护盾、生命回复提高 100%。每释放 5 次狂气爆发后，选择 1 名唤醒体觉醒，并刷新狂气爆发增幅效果。\n<RedQuality:枯竭>：基础银钥能量提高200%"
  },
  RelicConfig_140279_Desc = {
    Text = "<OrangeQuality:破晓>：所有唤醒体基础狂气降低30点。每回合首次释放的狂气爆发最终伤害提高200%，护盾、生命回复提高 100%。每释放 5 次狂气爆发后，选择 1 名唤醒体觉醒，并刷新狂气爆发增幅效果。\n<RedQuality:枯竭>：基础银钥能量提高200%"
  },
  RelicConfig_140279_Name = {
    Text = "<RedQuality:维度灵摆-诡咒>"
  },
  RelicConfig_140280_BattleDesc = {
    Text = "<OrangeQuality:觉醒>：每回合首次释放狂气爆发后，重置该唤醒体狂气爆发冷却并使其获得 50 狂气，生成其算力消耗为 0 的所有「技能」的临时复制。\n<RedQuality:封印>：每回合首次释放狂气爆发后，封印其他唤醒体。"
  },
  RelicConfig_140280_Desc = {
    Text = "<OrangeQuality:觉醒>：每回合首次释放狂气爆发后，重置该唤醒体狂气爆发冷却并使其获得 50 狂气，生成其算力消耗为 0 的所有「技能」的临时复制。\n<RedQuality:封印>：每回合首次释放狂气爆发后，封印其他唤醒体。"
  },
  RelicConfig_140280_Name = {
    Text = "<RedQuality:维度灵摆-决斗>"
  },
  RelicConfig_140281_BattleDesc = {
    Text = "<OrangeQuality:回响>：回合开始后抽 3 张抽牌堆中算力最高的指令卡，每回合首次打出的指令卡生效 2 次。\n<RedQuality:晕眩>：打出指令卡后弃掉所有算力消耗不低于它的其他指令卡。"
  },
  RelicConfig_140281_Desc = {
    Text = "<OrangeQuality:回响>：回合开始后抽 3 张抽牌堆中算力最高的指令卡，每回合首次打出的指令卡生效 2 次。\n<RedQuality:晕眩>：打出指令卡后弃掉所有算力消耗不低于它的其他指令卡。"
  },
  RelicConfig_140281_Name = {
    Text = "<RedQuality:维度灵摆-惑乱>"
  },
  RelicConfig_140282_BattleDesc = {
    Text = "<OrangeQuality:伟力>：所有唤醒体造成的<PowerIconKeywords:力量>提高 50%，每造成 1 次伤害获得 [Arg2] 点临时<PowerIconKeywords:力量>。\n<RedQuality:无形>：战斗开始时，所有敌人获得 50 层<ParcloseIconKeywords:屏障>。"
  },
  RelicConfig_140282_Desc = {
    Text = "<OrangeQuality:伟力>：所有唤醒体造成的<PowerIconKeywords:力量>提高 50%，每造成 1 次伤害获得 [Arg2] 点临时<PowerIconKeywords:力量>。\n<RedQuality:无形>：战斗开始时，所有敌人获得 50 层<ParcloseIconKeywords:屏障>。"
  },
  RelicConfig_140282_Name = {
    Text = "<RedQuality:维度灵摆-潜匿>"
  },
  RelicConfig_140840_BattleDesc = {
    Text = "手牌上限 +1。战斗开始时生成 1 张「<DerivativeCardKeywords_148:驭魇>」置入手中。打出唤醒体的「基础打击」时，「<DerivativeCardKeywords_148:驭魇>」算力消耗 -1，对所有敌人造成 [Arg1] 点侵蚀。打出唤醒体的「基础防御」时 ，获得  [Arg2] 点力量，下次打出「<DerivativeCardKeywords_148:驭魇>」的最终伤害效果和力量提高 [Arg3]%。"
  },
  RelicConfig_140840_Desc = {
    Text = "手牌上限 +1。战斗开始时生成 1 张「<DerivativeCardKeywords_148:驭魇>」置入手中。打出唤醒体的「基础打击」时，「<DerivativeCardKeywords_148:驭魇>」算力消耗 -1，对所有敌人造成 [Arg1] 点侵蚀。打出唤醒体的「基础防御」时 ，获得  [Arg2] 点力量，下次打出「<DerivativeCardKeywords_148:驭魇>」的最终伤害效果和力量提高 [Arg3]%。"
  },
  RelicConfig_140840_Name = {
    Text = "徒劳者的挣扎"
  },
  RelicConfig_140840_StoryDesc = {
    Text = "徒劳者恐惧变化，恐惧事物超出掌控，在最深层的地方，他歇斯底里地恐惧着失去。\n 他一次次地吹响哨子，想要通过哨音控制所有，但他没能留住任何东西。"
  },
  RelicConfig_143665_BattleDesc = {
    Text = "回合开始时庞托斯获得 [Arg1] 狂气。拾取后下场战斗开始时，生成 3 张永久「囚魇」。打出「囚魇」时庞托斯获得 3 点狂气。"
  },
  RelicConfig_143665_Desc = {
    Text = "回合开始时庞托斯获得 [Arg1] 狂气。拾取后下场战斗开始时，生成 3 张永久「囚魇」。打出「囚魇」时庞托斯获得 3 点狂气。"
  },
  RelicConfig_143665_Name = {
    Text = "<OrangeQuality:维度影像·庞托斯>"
  },
  RelicConfig_145438_BattleDesc = {
    Text = "回合开始时蚀灭·萝坦获得 [Arg1] 点狂气，「断界之剑」使下回合开始时释放「冥刃追灭」追击：对所有敌人造成 400％ 蚀灭·萝坦攻击力的伤害，该伤害享受本次「断界之剑」通过「巨剑·鲸落」获得的伤害加成，视为「打击」。"
  },
  RelicConfig_145438_Desc = {
    Text = "回合开始时蚀灭·萝坦获得 [Arg1] 点狂气，「断界之剑」使下回合开始时释放「冥刃追灭」追击：对所有敌人造成 400％ 蚀灭·萝坦攻击力的伤害，该伤害享受本次「断界之剑」通过「巨剑·鲸落」获得的伤害加成，视为「打击」。"
  },
  RelicConfig_145438_Name = {
    Text = "<OrangeQuality:维度影像·蚀灭·萝坦>"
  },
  RelicConfig_146128_BattleDesc = {
    Text = "手牌上限 +1。战斗开始时或打出「<DerivativeCardKeywords_157:剑之骨>」后将 1 张「<DerivativeCardKeywords_155:狂之骨>」置入手中，将1 张「<DerivativeCardKeywords_156:伤之骨>」洗入抽牌堆。若一回合中同时打出「<DerivativeCardKeywords_155:狂之骨>」和「<DerivativeCardKeywords_156:伤之骨>」，将这两张牌合成为「<DerivativeCardKeywords_157:剑之骨>」置入手中。"
  },
  RelicConfig_146128_Desc = {
    Text = "手牌上限 +1。战斗开始时或打出「<DerivativeCardKeywords_157:剑之骨>」后将 1 张「<DerivativeCardKeywords_155:狂之骨>」置入手中，将1 张「<DerivativeCardKeywords_156:伤之骨>」洗入抽牌堆。若一回合中同时打出「<DerivativeCardKeywords_155:狂之骨>」和「<DerivativeCardKeywords_156:伤之骨>」，将这两张牌合成为「<DerivativeCardKeywords_157:剑之骨>」置入手中。"
  },
  RelicConfig_146128_Name = {
    Text = "鲸骸之铠"
  },
  RelicConfig_146128_StoryDesc = {
    Text = "利维坦的骸骨庇佑着祂所选定之人，所向披靡，不死不灭。"
  },
  RelicConfig_147547_BattleDesc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_147547_Desc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_147547_Name = {
    Text = "<OrangeQuality:维度影像·卡茜亚>"
  },
  RelicConfig_147665_BattleDesc = {
    Text = "算力上限和每回合抽牌数 +1。回合开始时<FaxianKeywords:发现> 3 个「<Caroboo_Tips:皇家玛丽巧克力>」并选择其一。其中只有 1 个为真实：选中真实则获得其正面效果并驱散自身随机 1 种负面状态；选中虚假则承受其负面效果并使下一次<FaxianKeywords:发现>时真实选项 +1、效果翻倍，选中真实后重置。"
  },
  RelicConfig_147665_Desc = {
    Text = "算力上限和每回合抽牌数 +1。回合开始时<FaxianKeywords:发现> 3 个「<Caroboo_Tips:皇家玛丽巧克力>」并选择其一。其中只有 1 个为真实：选中真实则获得其正面效果并驱散自身随机 1 种负面状态；选中虚假则承受其负面效果并使下一次<FaxianKeywords:发现>时真实选项 +1、效果翻倍，选中真实后重置。"
  },
  RelicConfig_147665_Name = {
    Text = "皇家玛丽巧克力"
  },
  RelicConfig_147665_StoryDesc = {
    Text = "甜美而贵重……吗？"
  },
  RelicConfig_148525_BattleDesc = {
    Text = "回合开始时负誓·奥吉尔获得 [Arg1] 点狂气，「暗涌」不再减少抽牌数。"
  },
  RelicConfig_148525_Desc = {
    Text = "回合开始时负誓·奥吉尔获得 [Arg1] 点狂气，「暗涌」不再减少抽牌数。"
  },
  RelicConfig_148525_Name = {
    Text = "<OrangeQuality:维度影像·负誓·奥吉尔>"
  },
  RelicConfig_149665_BattleDesc = {
    Text = "当前环境视为「冰域」。\n终北大陆：抽牌阶段后对手中算力最高的 2 张未冻结的指令卡施加 1 层<SlowIconKeywords:迟缓>、<RetainIconKeywords:保留>。当任意指令卡拥有至少 3 层<SlowIconKeywords:迟缓>时，移除其<SlowIconKeywords:迟缓>和本场战斗施加的<RetainIconKeywords:保留>并将其「冻结」，附加 25 层<TempPowerKeywords2:强化>。"
  },
  RelicConfig_149665_Desc = {
    Text = "当前环境视为「冰域」。\n终北大陆：抽牌阶段后对手中算力最高的 2 张未冻结的指令卡施加 1 层<SlowIconKeywords:迟缓>、<RetainIconKeywords:保留>。当任意指令卡拥有至少 3 层<SlowIconKeywords:迟缓>时，移除其<SlowIconKeywords:迟缓>和本场战斗施加的<RetainIconKeywords:保留>并将其「冻结」，附加 25 层<TempPowerKeywords2:强化>。"
  },
  RelicConfig_149665_Name = {
    Text = "<OrangeQuality:冰域晶核>"
  },
  RelicConfig_149665_StoryDesc = {
    Text = "它并非带来寒冷。\n它只是提醒大地，冬天从未离去。"
  },
  RelicConfig_20164_BattleDesc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点临时<PowerIconKeywords:力量>，最多 5 层，层数满时获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_20164_Desc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点临时<PowerIconKeywords:力量>，最多 5 层，层数满时获得 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_20164_Name = {
    Text = "<OrangeQuality:时灵摆「未眠」>"
  },
  RelicConfig_20165_BattleDesc = {
    Text = "拾取时觉醒所有唤醒体。打出<ExaltIconKeywords:灵知觉醒>后，随机获得 2 张该唤醒体的指令卡并附加「消耗」和「虚无」。"
  },
  RelicConfig_20165_Desc = {
    Text = "拾取时觉醒所有唤醒体。打出<ExaltIconKeywords:灵知觉醒>后，随机获得 2 张该唤醒体的指令卡并附加「消耗」和「虚无」。"
  },
  RelicConfig_20165_Name = {
    Text = "<OrangeQuality:祂的神谕+>"
  },
  RelicConfig_20165_StoryDesc = {
    Text = "祂说，不要惧怕。"
  },
  RelicConfig_20166_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。将每回合打出的第 1 张牌重新置入手中。超维回合开始时，当回合手牌上限 +5 并复制你的手牌。"
  },
  RelicConfig_20166_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。将每回合打出的第 1 张牌从弃牌堆重新置入手中。超维回合开始时，当回合手牌上限 +5 并复制你的手牌，复制的牌添加<NothingnessIconKeywords:虚无>和<DepleteIconKeywords:消耗>。"
  },
  RelicConfig_20166_Name = {
    Text = "<OrangeQuality:时灵摆「窃梦」>"
  },
  RelicConfig_20167_BattleDesc = {
    Text = "回合结束时若有剩余算力，下回合额外抽 2 张牌；若有剩余手牌，下回合额外获得 2 点算力。"
  },
  RelicConfig_20167_Desc = {
    Text = "回合结束时若有剩余算力，下回合额外抽 2 张牌；若有剩余手牌，下回合额外获得 2 点算力。"
  },
  RelicConfig_20167_Name = {
    Text = "<OrangeQuality:日月轮盘+>"
  },
  RelicConfig_20167_StoryDesc = {
    Text = "猜一猜，是黑还是白？"
  },
  RelicConfig_20168_BattleDesc = {
    Text = "触腕上限 +2。释放狂气爆发后，触腕伤害 +[Arg1]。若一回合中释放过 3 次狂气爆发，则激发所有触腕一次。"
  },
  RelicConfig_20168_Desc = {
    Text = "触腕上限 +2。释放狂气爆发后，触腕伤害 +[Arg1]。若一回合中释放过 3 次狂气爆发，则激发所有触腕一次。"
  },
  RelicConfig_20168_Name = {
    Text = "<OrangeQuality:时灵摆「浅眠」>"
  },
  RelicConfig_20169_BattleDesc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 张牌<EmbryoFusionIconKeywords:胚胎融合> +10，生命低于 25% 时提高为 20，每回合最多生效 10 次。"
  },
  RelicConfig_20169_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 张牌<EmbryoFusionIconKeywords:胚胎融合> +10，生命低于 25% 时提高为 20，每回合最多生效 10 次。"
  },
  RelicConfig_20169_Name = {
    Text = "<OrangeQuality:时灵摆「涌动」>"
  },
  RelicConfig_20170_BattleDesc = {
    Text = "战斗开始时，所有唤醒体获得 50 点狂气。将 2 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_20170_Desc = {
    Text = "战斗开始时，所有唤醒体获得 50 点狂气。将 2 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_20170_Name = {
    Text = "<OrangeQuality:通讯设备+>"
  },
  RelicConfig_20170_StoryDesc = {
    Text = "期待或恐惧它发出清脆铃声的瞬间。"
  },
  RelicConfig_20171_BattleDesc = {
    Text = "拾取时随机获得 1 个白银造物、1 个黄金造物、1 个诅咒造物。"
  },
  RelicConfig_20171_Desc = {
    Text = "拾取时随机获得 1 个白银造物、1 个黄金造物、1 个诅咒造物。"
  },
  RelicConfig_20171_Name = {
    Text = "<OrangeQuality:逆向观赏+>"
  },
  RelicConfig_20171_StoryDesc = {
    Text = "在奇异的纪元中，花朵才是人类的第一观赏者。\n不要动弹，祂们更偏爱安静的展品。"
  },
  RelicConfig_20172_BattleDesc = {
    Text = "每回合打出的指令卡达到 3 张时获得 1 张<DerivativeCardKeywords_4:「灵感」>，达到 6 张时再获得 1 张<DerivativeCardKeywords_4:「灵感」>，达到 10 张后，下个回合开始时可从牌库中任选 2 张卡置入手牌。"
  },
  RelicConfig_20172_Desc = {
    Text = "每回合打出的指令卡达到 3 张时获得 1 张<DerivativeCardKeywords_4:「灵感」>，达到 6 张时再获得 1 张<DerivativeCardKeywords_4:「灵感」>，达到 10 张后，下个回合开始时可从牌库中任选 2 张卡置入手牌。"
  },
  RelicConfig_20172_Name = {
    Text = "<OrangeQuality:时灵摆「回响」>"
  },
  RelicConfig_20173_BattleDesc = {
    Text = "对处于负面状态的敌人造成的伤害提高 50%，击杀敌人后击杀者获得 100 狂气。"
  },
  RelicConfig_20173_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 50%，击杀敌人后击杀者获得 100 狂气。"
  },
  RelicConfig_20173_Name = {
    Text = "<OrangeQuality:祭司权杖+>"
  },
  RelicConfig_20173_StoryDesc = {
    Text = "不被许可的虔诚。"
  },
  RelicConfig_20174_BattleDesc = {
    Text = "拾取后队伍伤害强效变为原始值的 150%。回合开始后，对随机敌人造成 [Arg1] 点<FixedDamage:纯粹伤害>，本场战斗中每释放 1 次钥令，伤害 +[Arg2] ，该伤害提高享受队伍伤害强效加成。"
  },
  RelicConfig_20174_Desc = {
    Text = "拾取后队伍伤害强效变为原始值的 150%。回合开始后，对随机敌人造成 [Arg1] 点<FixedDamage:纯粹伤害>，本场战斗中每释放 1 次钥令，伤害 +[Arg2] ，该伤害提高享受队伍伤害强效加成。"
  },
  RelicConfig_20174_Name = {
    Text = "<OrangeQuality:时灵摆「迷失」>"
  },
  RelicConfig_20175_BattleDesc = {
    Text = "造成的<WeaknessIconKeywords:虚弱>效果提高 8%，<VulnerabilityIconKeywords:易伤>效果提高 25%。施加<WeaknessIconKeywords:虚弱>或<VulnerabilityIconKeywords:易伤>时，临时偷取目标 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_20175_Desc = {
    Text = "造成的<WeaknessIconKeywords:虚弱>效果提高 8%，<VulnerabilityIconKeywords:易伤>效果提高 25%。施加<WeaknessIconKeywords:虚弱>或<VulnerabilityIconKeywords:易伤>时，临时偷取目标 [Arg1] 点<PowerIconKeywords:力量>。"
  },
  RelicConfig_20175_Name = {
    Text = "<OrangeQuality:褪色照片+>"
  },
  RelicConfig_20175_StoryDesc = {
    Text = "模糊的照片承载了模糊的记忆，亦或者——正是记忆的残缺，才造就了照片的褪色。"
  },
  RelicConfig_20176_BattleDesc = {
    Text = "回合开始时每有 1 名敌人就获得 2 算力。主动伤害击杀敌人时，对其他敌人造成双倍过量伤害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_20176_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 2 算力。主动伤害击杀敌人时，对其他敌人造成双倍过量伤害的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_20176_Name = {
    Text = "<OrangeQuality:群氓之歌+>"
  },
  RelicConfig_20176_StoryDesc = {
    Text = "专为折磨你的耳朵而生。"
  },
  RelicConfig_20177_BattleDesc = {
    Text = "拾取后死亡抵抗翻倍。造成伤害后，还会对目标施加等同于伤害 50% 的<BleedingIconKeywords:出血>。每触发 1 次死亡抵抗，全体敌人的出血立刻触发 1 次。"
  },
  RelicConfig_20177_Desc = {
    Text = "拾取后死亡抵抗翻倍。造成伤害后，还会对目标施加等同于伤害 50% 的<BleedingIconKeywords:出血>。每触发 1 次死亡抵抗，全体敌人的出血立刻触发 1 次。"
  },
  RelicConfig_20177_Name = {
    Text = "<OrangeQuality:时灵摆「复苏」>"
  },
  RelicConfig_20178_BattleDesc = {
    Text = "每造成 1 次主动伤害就获得 3 点狂气，并对目标施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_20178_Desc = {
    Text = "每造成 1 次主动伤害就获得 3 点狂气，并对目标施加 [Arg1] 层<IntoxicationIconKeywords:中毒>。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方<IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_20178_Name = {
    Text = "<OrangeQuality:蒙尘缝纫机+>"
  },
  RelicConfig_20178_StoryDesc = {
    Text = "一位慈祥的母亲，缝补心脏上的伤。"
  },
  RelicConfig_21906_BattleDesc = {
    Text = "「打击」获得 3 点算力，随机弃 1 张牌；「防御」抽 3 张牌，失去 1 点算力。"
  },
  RelicConfig_21906_Desc = {
    Text = "「打击」获得 3 点算力，随机弃 1 张牌；「防御」抽 3 张牌，失去 1 点算力。"
  },
  RelicConfig_21906_Name = {
    Text = "<RedQuality:快乐唱片+>"
  },
  RelicConfig_21906_StoryDesc = {
    Text = "录下了著名小提琴家最后的演出的唱片。\n自那以后，它能带来火焰。"
  },
  RelicConfig_23688_BattleDesc = {
    Text = "每触发 1 次吞噬，获得 30 点<EmbryoFusionIconKeywords:胚胎融合>和 [Arg1] 点<PowerIconKeywords:力量>。若 1 回合中第 2 次触发，获得 1 点算力，抽 1 张牌，若 1 回合中第 3 次触发，获得 2 点算力，抽 2 张牌。"
  },
  RelicConfig_23688_Desc = {
    Text = "每触发 1 次吞噬，获得 30 点<EmbryoFusionIconKeywords:胚胎融合>和 [Arg1] 点<PowerIconKeywords:力量>。若 1 回合中第 2 次触发，获得 1 点算力，抽 1 张牌，若 1 回合中第 3 次触发，获得 2 点算力，抽 2 张牌。"
  },
  RelicConfig_23688_Name = {
    Text = "<OrangeQuality:时灵摆「回噬」>"
  },
  RelicConfig_23689_BattleDesc = {
    Text = "拾取后所有唤醒体获得 30 点狂气。每释放 1 次狂气爆发增加 1 点计数。释放钥令后，获得  [Arg1] 点临时戒备、 [Arg2] 点临时<PowerIconKeywords:力量>和所有唤醒体获得 6 点狂气，消耗所有计数，每点计数额外生效 1 次。"
  },
  RelicConfig_23689_Desc = {
    Text = "拾取后所有唤醒体获得 30 点狂气。每释放 1 次狂气爆发增加 1 点计数。释放钥令后，获得  [Arg1] 点临时戒备、 [Arg2] 点临时<PowerIconKeywords:力量>和所有唤醒体获得 6 点狂气，消耗所有计数，每点计数额外生效 1 次。"
  },
  RelicConfig_23689_Name = {
    Text = "<OrangeQuality:时灵摆「蓄力」>"
  },
  RelicConfig_23690_BattleDesc = {
    Text = "每额外获得的 1 点算力或额外抽的 1 张牌，偷取所有敌人 [Arg1] 点<PowerIconKeywords:力量>，获得 4% 临时暴击率，精英或首领战效果翻倍。超维回合开始后，获得 [Arg2] 点<PowerIconKeywords:力量>，暴击伤害 +15%。"
  },
  RelicConfig_23690_Desc = {
    Text = "每额外获得的 1 点算力或额外抽的 1 张牌，偷取所有敌人 [Arg1] 点<PowerIconKeywords:力量>，获得 4% 临时暴击率，精英或首领战效果翻倍。超维回合开始后，获得 [Arg2] 点<PowerIconKeywords:力量>，暴击伤害 +15%。"
  },
  RelicConfig_23690_Name = {
    Text = "<OrangeQuality:时灵摆「间隙」>"
  },
  RelicConfig_23691_BattleDesc = {
    Text = "每造成 5 次伤害，回复 [Arg1] 点生命。每失去 1 次生命 ，触腕伤害 +[Arg2]，若失去生命超过 [Arg3] 点，激发所有触腕 1 次。"
  },
  RelicConfig_23691_Desc = {
    Text = "每造成 5 次伤害，回复 [Arg1] 点生命。每失去 1 次生命 ，触腕伤害 +[Arg2]，若失去生命超过 10% 最大生命，激发所有触腕 1 次。"
  },
  RelicConfig_23691_Name = {
    Text = "<OrangeQuality:时灵摆「潮涌」>"
  },
  RelicConfig_35135_BattleDesc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点临时<PowerIconKeywords:力量>和 [Arg2] 点临时触腕伤害，每回合最多触发 12 次。若 1 回合内造成了 4 次伤害，对全体敌人施加 1 层易伤并获得 [Arg3] 点护盾，若造成了 8 次伤害，对全体敌人施加 1 层虚弱并回复 [Arg3] 点生命。"
  },
  RelicConfig_35135_Desc = {
    Text = "每造成 1 次伤害，获得 [Arg1] 点临时<PowerIconKeywords:力量>和 [Arg2] 点临时触腕伤害，每回合最多触发 12 次。若 1 回合内造成了 4 次伤害，对全体敌人施加 1 层易伤并获得 [Arg3] 点护盾，若造成了 8 次伤害，对全体敌人施加 1 层虚弱并回复 [Arg3] 点生命。"
  },
  RelicConfig_35135_Name = {
    Text = "<OrangeQuality:时灵摆「入迷」>"
  },
  RelicConfig_35136_BattleDesc = {
    Text = "「打击」的伤害和「防御」获得的护盾提高 30%，若 1 回合中打出了 4 张或以上的「打击」和「防御」，下个回合开始时，抽 2 张牌，获得 1 点算力。"
  },
  RelicConfig_35136_Desc = {
    Text = "「打击」的伤害和「防御」获得的护盾提高 30%，若 1 回合中打出了 4 张或以上的「打击」和「防御」，下个回合开始时，抽 2 张牌，获得 1 点算力。"
  },
  RelicConfig_35136_Name = {
    Text = "<OrangeQuality:时灵摆「执拗」>"
  },
  RelicConfig_35137_BattleDesc = {
    Text = "每打出 1 张卡牌，获得 [Arg1] 点临时<PowerIconKeywords:力量>并回复 [Arg2] 点生命，造成主动伤害后移除 [Arg2] 点该造物获得的<PowerIconKeywords:力量>。唤醒体每击杀一个敌人，获得 30 点狂气。"
  },
  RelicConfig_35137_Desc = {
    Text = "每打出 1 张卡牌，获得 [Arg1] 点临时<PowerIconKeywords:力量>并回复 [Arg2] 点生命，造成主动伤害后移除 [Arg2] 点该造物获得的<PowerIconKeywords:力量>。唤醒体每击杀一个敌人，获得 30 点狂气。"
  },
  RelicConfig_35137_Name = {
    Text = "<OrangeQuality:时灵摆「积蓄」>"
  },
  RelicConfig_35138_BattleDesc = {
    Text = "释放狂气爆发后，对随机敌人施加 [Arg1] 点中毒，每打出 1 张指令卡，获得 [Arg2] 点临时反击。每 4 个回合结束时，对所有敌人造成等同于敌人中毒层数和自身反击层数总和的伤害。"
  },
  RelicConfig_35138_Desc = {
    Text = "释放狂气爆发后，对随机敌人施加 [Arg1] 点中毒，每打出 1 张指令卡，获得 [Arg2] 点临时反击。每 4 个回合结束时，对所有敌人造成等同于敌人中毒层数和自身反击层数总和的伤害。"
  },
  RelicConfig_35138_Name = {
    Text = "<OrangeQuality:时灵摆「蔓延」>"
  },
  RelicConfig_35139_BattleDesc = {
    Text = "拾取后队伍伤害强效增加 30%。每造成的第 4 次伤害必定暴击，且暴击伤害提高 50%，若该次伤害造成了击杀，获得 5 点黑印。"
  },
  RelicConfig_35139_Desc = {
    Text = "拾取后队伍伤害强效增加 30%。每造成的第 4 次伤害必定暴击，且暴击伤害提高 50%，若该次伤害造成了击杀，获得 5 点黑印。"
  },
  RelicConfig_35139_Name = {
    Text = "<OrangeQuality:时灵摆「终结」>"
  },
  RelicConfig_36823_BattleDesc = {
    Text = "释放狂气爆发后抽 1 张牌。每弃掉 1 张卡牌，所有唤醒体获得 3 点狂气，每回合最多 15 点。"
  },
  RelicConfig_36823_Desc = {
    Text = "释放狂气爆发后抽 1 张牌。每弃掉 1 张卡牌，所有唤醒体获得 3 点狂气，每回合最多 15 点。"
  },
  RelicConfig_36823_Name = {
    Text = "<OrangeQuality:时灵摆「往来」>"
  },
  RelicConfig_36824_BattleDesc = {
    Text = "每次消耗算力时，抽 1 张牌，每回合至多生效 5 次。每当牌库重置时，获得 2 点算力。"
  },
  RelicConfig_36824_Desc = {
    Text = "每次消耗算力时，抽 1 张牌，每回合至多生效 5 次。每当牌库重置时，获得 2 点算力。"
  },
  RelicConfig_36824_Name = {
    Text = "<OrangeQuality:时灵摆「不眠」>"
  },
  RelicConfig_39302_BattleDesc = {
    Text = "每造成 4 次伤害，将 1 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆，每回合最多触发 3 次。释放狂气爆发后，打出并消耗牌库中所有的<DerivativeCardKeywords_4:「灵感」>。"
  },
  RelicConfig_39302_Desc = {
    Text = "每造成 4 次伤害，将 1 张<DerivativeCardKeywords_4:「灵感」>洗入抽牌堆，每回合最多触发 3 次。释放狂气爆发后，打出并消耗牌库中所有的<DerivativeCardKeywords_4:「灵感」>。"
  },
  RelicConfig_39302_Name = {
    Text = "<OrangeQuality:时灵摆「迷梦」>"
  },
  RelicConfig_39303_BattleDesc = {
    Text = "当前算力为奇数时，视为额外拥有 [Arg2] 点临时戒备。当前算力为偶数时，视为额外拥有 [Arg1] 点临时<PowerIconKeywords:力量>和 [Arg3] 点临时触腕伤害。每拥有 1 个黄金造物，该造物效果提高 50%，每拥有 1 个诅咒造物，提高 80%。"
  },
  RelicConfig_39303_Desc = {
    Text = "当前算力为奇数时，视为额外拥有 [Arg2] 点临时戒备。当前算力为偶数时，视为额外拥有 [Arg1] 点临时<PowerIconKeywords:力量>和 [Arg3] 点临时触腕伤害。每拥有 1 个黄金造物，该造物效果提高 50%，每拥有 1 个诅咒造物，提高 80%。"
  },
  RelicConfig_39303_Name = {
    Text = "<OrangeQuality:时灵摆「惊梦」>"
  },
  RelicConfig_44192_BattleDesc = {
    Text = "每回合开始时所有唤醒体获得 20 狂气。拾取时最大生命降低 50%。"
  },
  RelicConfig_44192_Desc = {
    Text = "每回合开始时所有唤醒体获得 20 狂气。拾取时最大生命降低 50%。"
  },
  RelicConfig_44192_Name = {
    Text = "<RedQuality:负罪·噩梦表象>"
  },
  RelicConfig_44192_StoryDesc = {
    Text = "放纵的深眠即是欲望，会在你不知道的时候吞噬一切。"
  },
  RelicConfig_44300_BattleDesc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 3 倍。"
  },
  RelicConfig_44300_Desc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 3 倍。"
  },
  RelicConfig_44300_Name = {
    Text = "<OrangeQuality:受祝·噩梦表象>"
  },
  RelicConfig_44300_StoryDesc = {
    Text = "无需恐惧，无需彷徨。这不过是转瞬即逝的梦，父神的光依旧照耀在你身上。"
  },
  RelicConfig_44592_BattleDesc = {
    Text = "战斗结束后，获得 100 黑印和 2 张症状卡。"
  },
  RelicConfig_44592_Desc = {
    Text = "战斗结束后，获得 100 黑印和 2 张症状卡。"
  },
  RelicConfig_44592_Name = {
    Text = "<RedQuality:负罪·翠玉拓印>"
  },
  RelicConfig_44592_StoryDesc = {
    Text = "远古的罪孽镌刻于此。"
  },
  RelicConfig_44593_BattleDesc = {
    Text = "拾取时变形为 1 个除自身以外的随机负罪造物，获得 75 黑印。"
  },
  RelicConfig_44593_Desc = {
    Text = "拾取时变形为 1 个除自身以外的随机负罪造物，获得 75 黑印。"
  },
  RelicConfig_44593_Name = {
    Text = "<RedQuality:负罪·诅咒石碑>"
  },
  RelicConfig_44593_StoryDesc = {
    Text = "听，有谁在里面呼唤。"
  },
  RelicConfig_44594_BattleDesc = {
    Text = "每 2 回合使所有敌人受到的主动和触腕伤害翻倍，但在该回合中每释放 1 次狂气爆发，封印所有唤醒体 1 回合，自身易伤。"
  },
  RelicConfig_44594_Desc = {
    Text = "每 2 回合使所有敌人受到的主动和触腕伤害翻倍，但在该回合中每释放 1 次狂气爆发，封印所有唤醒体 1 回合，自身易伤。"
  },
  RelicConfig_44594_Name = {
    Text = "<RedQuality:负罪·行道之骸>"
  },
  RelicConfig_44594_StoryDesc = {
    Text = "神圣的一部分。\n与躯干分离后，它已经被罪孽渗透。"
  },
  RelicConfig_44597_BattleDesc = {
    Text = "每造成 1 次主动伤害，对自身施加 [Arg1] 层<BleedingIconKeywords:出血>，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44597_Desc = {
    Text = "每造成 1 次主动伤害，对自身施加 [Arg1] 层<BleedingIconKeywords:出血>，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44597_Name = {
    Text = "<RedQuality:负罪·虫群意识>"
  },
  RelicConfig_44597_StoryDesc = {
    Text = "缠绕、共生、集群；恐惧、未知、控制。"
  },
  RelicConfig_44598_BattleDesc = {
    Text = "释放狂气爆发后，失去 12% 当前生命，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_44598_Desc = {
    Text = "释放狂气爆发后，失去 12% 当前生命，偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_44598_Name = {
    Text = "<RedQuality:负罪·厄运仪式鸟>"
  },
  RelicConfig_44598_StoryDesc = {
    Text = "因贪婪而死的可怜生灵，用干瘪的胸腔发出刺耳的控诉。"
  },
  RelicConfig_44603_BattleDesc = {
    Text = "手牌上限提高 5，战斗开始时抽 6 张牌。回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌，但每回合抽牌数降低 2。"
  },
  RelicConfig_44603_Desc = {
    Text = "手牌上限提高 5，战斗开始时抽 6 张牌。回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌，但每回合抽牌数降低 2。"
  },
  RelicConfig_44603_Name = {
    Text = "<RedQuality:负罪·意识铭刻>"
  },
  RelicConfig_44603_StoryDesc = {
    Text = "贪婪者以他人为物，在他人的痛苦中攫取自己的享乐。"
  },
  RelicConfig_44608_BattleDesc = {
    Text = "拾取后永久失去 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_44608_Desc = {
    Text = "拾取后永久失去 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_44608_Name = {
    Text = "<RedQuality:负罪·七鳃鳗之吻>"
  },
  RelicConfig_44608_StoryDesc = {
    Text = "它的吻会让你沉沦——当然，沉沦的也可能是你自身。"
  },
  RelicConfig_44609_BattleDesc = {
    Text = "最大算力提高 3。每次重置牌库时将 2 张<DerivativeCardKeywords_9:「蹒跚」>加入抽牌堆。"
  },
  RelicConfig_44609_Desc = {
    Text = "最大算力提高 3。每次重置牌库时将 2 张<DerivativeCardKeywords_9:「蹒跚」>加入抽牌堆。"
  },
  RelicConfig_44609_Name = {
    Text = "<RedQuality:负罪·黑烛>"
  },
  RelicConfig_44609_StoryDesc = {
    Text = "燃烧理智，堕入癫狂。"
  },
  RelicConfig_44610_BattleDesc = {
    Text = "暴击率和暴击伤害提高 50%，每回合开始时，<FragileIconKeywords:脆弱>自身 1 回合。"
  },
  RelicConfig_44610_Desc = {
    Text = "暴击率和暴击伤害提高 50%，每回合开始时，<FragileIconKeywords:脆弱>自身 1 回合。"
  },
  RelicConfig_44610_Name = {
    Text = "<RedQuality:负罪·古怪钩爪>"
  },
  RelicConfig_44610_StoryDesc = {
    Text = "被欲望扭曲的手爪。"
  },
  RelicConfig_44654_BattleDesc = {
    Text = "最大算力提高 4，每次重置牌库时将 4 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆。"
  },
  RelicConfig_44654_Desc = {
    Text = "最大算力提高 4，每次重置牌库时将 4 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆。"
  },
  RelicConfig_44654_Name = {
    Text = "<OrangeQuality:受祝·黑烛>"
  },
  RelicConfig_44654_StoryDesc = {
    Text = "燃烧欲望，获得救赎。"
  },
  RelicConfig_44656_BattleDesc = {
    Text = "造物上限+[Arg1]，「融痕」中刷新次数+1。战斗结束后，获得 125 黑印，拾取时可以选择最多 6 张症状卡删除。"
  },
  RelicConfig_44656_Desc = {
    Text = "造物上限+[Arg1]，「融痕」中刷新次数+1。战斗结束后，获得 125 黑印，拾取时可以选择最多 6 张症状卡删除。"
  },
  RelicConfig_44656_Name = {
    Text = "<OrangeQuality:受祝·翠玉拓印>"
  },
  RelicConfig_44656_StoryDesc = {
    Text = "父神的救赎抹去了伤痛。"
  },
  RelicConfig_44658_BattleDesc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点临时力量，并偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_44658_Desc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点临时力量，并偷取所有敌人 [Arg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [Arg2] 点临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_44658_Name = {
    Text = "<OrangeQuality:受祝·厄运仪式鸟>"
  },
  RelicConfig_44658_StoryDesc = {
    Text = "宽恕的光笼罩在贪婪的残骸上，死去的飞鸟得以唱出最后的歌谣。"
  },
  RelicConfig_44659_BattleDesc = {
    Text = "每造成 1 次主动伤害，回复 [Arg1] 生命，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44659_Desc = {
    Text = "每造成 1 次主动伤害，回复 [Arg1] 生命，对伤害目标施加 [Arg2] 层<BleedingIconKeywords:出血>。"
  },
  RelicConfig_44659_Name = {
    Text = "<OrangeQuality:受祝·虫群意识>"
  },
  RelicConfig_44659_StoryDesc = {
    Text = "缠绕、共生、集群；团结、并存、庇护。"
  },
  RelicConfig_44660_BattleDesc = {
    Text = "手牌上限提高 5，战斗开始时补充手牌至上限。回合开始时额外抽 1 张牌，回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_44660_Desc = {
    Text = "手牌上限提高 5，战斗开始时补充手牌至上限。回合开始时额外抽 1 张牌，回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_44660_Name = {
    Text = "<OrangeQuality:受祝·意识铭刻>"
  },
  RelicConfig_44660_StoryDesc = {
    Text = "贪婪者将自己的过错铭刻在心，并潜心为自己的过去赎罪。"
  },
  RelicConfig_44662_BattleDesc = {
    Text = "每 2 回合使所有敌人受到的主动和触腕伤害翻倍，在本回合每释放 1 次狂气爆发，随机驱散 1 种负面状态。"
  },
  RelicConfig_44662_Desc = {
    Text = "每 2 回合使所有敌人受到的主动和触腕伤害翻倍，在本回合每释放 1 次狂气爆发，随机驱散 1 种负面状态。"
  },
  RelicConfig_44662_Name = {
    Text = "<OrangeQuality:受祝·行道之骸>"
  },
  RelicConfig_44662_StoryDesc = {
    Text = "神圣的一部分。\n纵然与躯干分离，其足迹也已遍布四海。"
  },
  RelicConfig_44663_BattleDesc = {
    Text = "暴击率提高 50%，暴击伤害提高 100%。"
  },
  RelicConfig_44663_Desc = {
    Text = "暴击率提高 50%，暴击伤害提高 100%。"
  },
  RelicConfig_44663_Name = {
    Text = "<OrangeQuality:受祝·古怪钩爪>"
  },
  RelicConfig_44663_StoryDesc = {
    Text = "一切欲望已经放下。"
  },
  RelicConfig_44664_BattleDesc = {
    Text = "拾取后永久获得 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_44664_Desc = {
    Text = "拾取后永久获得 [Arg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  RelicConfig_44664_Name = {
    Text = "<OrangeQuality:受祝·七鳃鳗之吻>"
  },
  RelicConfig_44664_StoryDesc = {
    Text = "拒绝这沉沦的吻吧，父神的怀抱比一切黑暗温暖。"
  },
  RelicConfig_47444_BattleDesc = {
    Text = "「打击」和 「防御」额外获得 50 点银钥能量。每当你打出 1 张算力消耗为 2 或以上的卡牌，抽 1 张算力消耗为 1 的牌并使其算力消耗变为 0，每回合最多生效 3 次。"
  },
  RelicConfig_47444_Desc = {
    Text = "「打击」和 「防御」额外获得 50 点银钥能量。每当你打出 1 张算力消耗为 2 或以上的卡牌，抽 1 张算力消耗为 1 的牌并使其算力消耗变为 0，每回合最多生效 3 次。"
  },
  RelicConfig_47444_Name = {
    Text = "<OrangeQuality:时灵摆「双生」>"
  },
  RelicConfig_50338_BattleDesc = {
    Text = "战斗开始时将所有唤醒体的<ExaltIconKeywords:灵知觉醒>洗入牌库。第 6 回合开始后，泰旖丝会每回合提供战斗支援。"
  },
  RelicConfig_50338_Desc = {
    Text = "战斗开始时将所有唤醒体的<ExaltIconKeywords:灵知觉醒>洗入牌库。第 6 回合开始后，泰旖丝会每回合提供战斗支援。"
  },
  RelicConfig_50338_Name = {
    Text = "<OrangeQuality:时灵摆「情迷」>"
  },
  RelicConfig_50338_StoryDesc = {
    Text = "祂说，不要惧怕。"
  },
  RelicConfig_50385_BattleDesc = {
    Text = "拾取后选择一张卡牌，使其算力消耗永久变为 1。"
  },
  RelicConfig_50385_Desc = {
    Text = "拾取后选择一张卡牌，使其算力消耗永久变为 1。"
  },
  RelicConfig_50385_Name = {
    Text = "<WhiteQuality:☆枯竭的瞳孔☆>"
  },
  RelicConfig_50385_StoryDesc = {
    Text = "失去了沙漠中最珍贵的水，她的眼瞳已然枯竭。"
  },
  RelicConfig_50487_BattleDesc = {
    Text = "战斗首回合开始时，将<DerivativeCardKeywords_46:「朊朊病毒」>加入手中；第 3 回合将<DerivativeCardKeywords_49:「无餍打击」>加入手中；触发死亡抵抗后，将<DerivativeCardKeywords_52:「复苏之茧」>加入手中。"
  },
  RelicConfig_50487_Desc = {
    Text = "战斗首回合开始时，将<DerivativeCardKeywords_46:「朊朊病毒」>加入手中；第 3 回合将<DerivativeCardKeywords_49:「无餍打击」>加入手中；触发死亡抵抗后，将<DerivativeCardKeywords_52:「复苏之茧」>加入手中。"
  },
  RelicConfig_50487_Name = {
    Text = "<OrangeQuality:时灵摆「赐福」>"
  },
  RelicConfig_50488_BattleDesc = {
    Text = "回合结束时：狂气最低的唤醒体获得 35 点狂气。若剩余生命≥50％，获得 [Arg1] 点<PowerIconKeywords:力量>。若剩余生命＜50％，恢复 [Arg2] 点生命。"
  },
  RelicConfig_50488_Desc = {
    Text = "回合结束时：狂气最低的唤醒体获得 35 点狂气。若当前生命不低于 50%，获得 [Arg1] 点<PowerIconKeywords:力量>。若当前生命低于 50%，恢复 [Arg2] 点生命。"
  },
  RelicConfig_50488_Name = {
    Text = "<OrangeQuality:时灵摆「均衡」>"
  },
  RelicConfig_50489_BattleDesc = {
    Text = "暴击率、暴伤提高100%。每造成 1 次伤害，所有唤醒体暴击、暴伤降低 10%，至多降低 50%。每造成 1 次伤害，本回合造成的中毒和反击提高 10%，最大提高至 50%。"
  },
  RelicConfig_50489_Desc = {
    Text = "暴击率、暴击伤害提高100%。每造成 1 次伤害/触腕伤害，本回合：所有唤醒体暴击暴伤降低 10%，至多降低 50%。造成的中毒和反击提高 10%，至多提高 50%。"
  },
  RelicConfig_50489_Name = {
    Text = "<OrangeQuality:时灵摆「移涌」>"
  },
  RelicConfig_51686_BattleDesc = {
    Text = "每打出一张与上一张所属唤醒体不同的指令卡，其所属唤醒体获得 3 点狂气，并积攒 1 层「活性」。积攒 10 层时将所有「活性」清空，将所有唤醒体各一张算力消耗减1且具备「消耗」的随机指令卡置入手中，每回合最多生效 1 次。"
  },
  RelicConfig_51686_Desc = {
    Text = "每打出一张与上一张所属唤醒体不同的指令卡，其所属唤醒体获得 3 点狂气，并积攒 1 层「活性」。积攒 10 层时将所有「活性」清空，将所有唤醒体各一张算力消耗减1且具备「消耗」的随机指令卡置入手中，每回合最多生效 1 次。"
  },
  RelicConfig_51686_Name = {
    Text = "<OrangeQuality:时灵摆「衍化」>"
  },
  RelicConfig_51687_BattleDesc = {
    Text = "非「打击」「防御」的指令卡打出后，若此卡牌不为衍生卡，对应唤醒体获得 15 点狂气，每回合最多触发 5 次。每回合第 1 次触发时，还会将打出的卡牌其移回手中。"
  },
  RelicConfig_51687_Desc = {
    Text = "非「打击」「防御」的指令卡打出后，若此卡牌不为衍生卡，对应唤醒体获得 15 点狂气，每回合最多触发 5 次。每回合第 1 次触发时，还会将打出的卡牌移回手中。"
  },
  RelicConfig_51687_Name = {
    Text = "<OrangeQuality:时灵摆「投射」>"
  },
  RelicConfig_51688_BattleDesc = {
    Text = "拾取时，对所有指令卡添加「保留」。回合结束时，若手牌数大于等于5，随机3张手牌算力消耗降低1，否则抽3张牌。"
  },
  RelicConfig_51688_Desc = {
    Text = "拾取时，对所有指令卡添加「保留」。回合结束时，若手牌数大于等于5，随机3张手牌算力消耗降低1，否则抽3张牌。"
  },
  RelicConfig_51688_Name = {
    Text = "<OrangeQuality:时灵摆「温床」>"
  },
  RelicConfig_51689_BattleDesc = {
    Text = "战斗开始时，将 3 张随机症状卡置入牌库。回合开始时，抽 1 张牌。每打出 1 张症状卡，获得 2 点算力。每弃掉 1 张症状卡，所有唤醒体获得 5 点狂气，每回合最多累计触发 5 次。"
  },
  RelicConfig_51689_Desc = {
    Text = "战斗开始时，将 3 张随机症状卡置入牌库。回合开始时，抽 1 张牌。每打出 1 张症状卡，获得 2 点算力。每弃掉 1 张症状卡，所有唤醒体获得 5 点狂气，每回合最多累计触发 5 次。"
  },
  RelicConfig_51689_Name = {
    Text = "<OrangeQuality:时灵摆「疫症」>"
  },
  RelicConfig_55847_BattleDesc = {
    Text = "模拟战标准造物7件套"
  },
  RelicConfig_55847_Desc = {
    Text = "模拟战标准造物7件套"
  },
  RelicConfig_55847_Name = {
    Text = "<RedQuality:☆模拟战造物☆>"
  },
  RelicConfig_55847_StoryDesc = {
    Text = "在奇异的纪元中，花朵才是人类的第一观赏者。\n不要动弹，祂们更偏爱安静的展品。"
  },
  RelicConfig_55874_BattleDesc = {
    Text = "战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，随机将 1 张「意象」置入牌库。"
  },
  RelicConfig_55874_Desc = {
    Text = "战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，随机将 1 张「意象」置入牌库。"
  },
  RelicConfig_55874_Name = {
    Text = "<OrangeQuality:奥尔拉的笔与墨>"
  },
  RelicConfig_55874_StoryDesc = {
    Text = "远古的罪孽镌刻于此。"
  },
  RelicConfig_56355_BattleDesc = {
    Text = "手牌上限 +2，回合开始时，抽 1 张牌。战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，选择将 1 张「意象」置入牌库。"
  },
  RelicConfig_56355_Desc = {
    Text = "手牌上限 +2，回合开始时，抽 1 张牌。战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，选择将 1 张「意象」置入牌库。"
  },
  RelicConfig_56355_Name = {
    Text = "<OrangeQuality:奥尔拉的笔与墨>"
  },
  RelicConfig_56355_StoryDesc = {
    Text = "远古的罪孽镌刻于此。"
  },
  RelicConfig_56356_BattleDesc = {
    Text = "战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，选择将 1 张「意象」置入牌库。"
  },
  RelicConfig_56356_Desc = {
    Text = "战斗结束后获得 [Arg1] 层「笔墨」，「笔墨」达到 2 层后消耗，选择将 1 张「意象」置入牌库。"
  },
  RelicConfig_56356_Name = {
    Text = "<OrangeQuality:奥尔拉的笔与墨>"
  },
  RelicConfig_56356_StoryDesc = {
    Text = "远古的罪孽镌刻于此。"
  },
  RelicConfig_57667_BattleDesc = {
    Text = "初始拥有 2 层神母权能，第三个回合后，每个回合开始时可选择消耗神母权能获得不同效果或者回复神母权能。若受到致死伤害，则复活并消耗所有神母权能，每层回复 10% 生命，仅可生效 1 次。"
  },
  RelicConfig_57667_Desc = {
    Text = "初始拥有 2 层神母权能，第三个回合后，每个回合开始时可选择消耗神母权能获得不同效果或者回复神母权能。若受到致死伤害，则复活并消耗所有神母权能，每层回复 10% 生命，仅可生效 1 次。"
  },
  RelicConfig_57667_Name = {
    Text = "<OrangeQuality:神母的庇护>"
  },
  RelicConfig_57732_BattleDesc = {
    Text = "所有唤醒体的暴击率提高 15%。莱克和骰子的随机效果最终结果提高 1。"
  },
  RelicConfig_57732_Desc = {
    Text = "所有唤醒体的暴击率提高 15%。莱克和骰子的随机效果最终结果提高 1。"
  },
  RelicConfig_57732_Name = {
    Text = "<OrangeQuality:高档幸运风衣>"
  },
  RelicConfig_57732_StoryDesc = {
    Text = "它将竖起一道厚厚的障壁，将风雨和霉运挡在外面。"
  },
  RelicConfig_57733_BattleDesc = {
    Text = "回合开始以及触发莱克或骰子的随机效果时，获得 100 点银钥能量和 4% 暴击伤害，最多获得 50% 暴击伤害，战斗结束时移除。"
  },
  RelicConfig_57733_Desc = {
    Text = "回合开始以及触发莱克或骰子的随机效果时，获得 100 点银钥能量和 4% 暴击伤害，最多获得 50% 暴击伤害，战斗结束时移除。"
  },
  RelicConfig_57733_Name = {
    Text = "<OrangeQuality:精致大嘴纽扣>"
  },
  RelicConfig_57733_StoryDesc = {
    Text = "大嘴纽扣喜爱一切圆圆的事物，例如月亮、筹码和新鲜的眼球。\n会在月圆之夜口吐黑雾，原因不明。"
  },
  RelicConfig_57734_BattleDesc = {
    Text = "每当释放钥令，将 1 张「闪耀偏方骰子」置入手中。"
  },
  RelicConfig_57734_Desc = {
    Text = "每当释放钥令，将 1 张「闪耀偏方骰子」置入手中。"
  },
  RelicConfig_57734_Name = {
    Text = "<OrangeQuality:闪耀偏方骰子>"
  },
  RelicConfig_57734_StoryDesc = {
    Text = "闪闪发光的不仅是外表，还有坚韧不拔的内心。\n凝视它超过五秒钟，你将招来@2。"
  },
  RelicConfig_57735_BattleDesc = {
    Text = "回合开始以及触发莱克或骰子的随机效果时，获得 50 点银钥能量和 2% 暴击伤害，最多获得 30% 暴击伤害，战斗结束时移除。"
  },
  RelicConfig_57735_Desc = {
    Text = "回合开始以及触发莱克或骰子的随机效果时，获得 50 点银钥能量和 2% 暴击伤害，最多获得 30% 暴击伤害，战斗结束时移除。"
  },
  RelicConfig_57735_Name = {
    Text = "<OrangeQuality:大嘴纽扣>"
  },
  RelicConfig_57735_StoryDesc = {
    Text = "大嘴纽扣喜爱一切圆圆的事物，例如月亮、筹码和新鲜的眼球。\n会在月圆之夜口吐黑雾，原因不明。"
  },
  RelicConfig_57736_BattleDesc = {
    Text = "每当释放钥令，将 1 张「偏方骰子」置入手中。"
  },
  RelicConfig_57736_Desc = {
    Text = "每当释放钥令，将 1 张「偏方骰子」置入手中。"
  },
  RelicConfig_57736_Name = {
    Text = "<OrangeQuality:偏方骰子>"
  },
  RelicConfig_57736_StoryDesc = {
    Text = "闪闪发光的不仅是外表，还有坚韧不拔的内心。\n凝视它超过五秒钟，你将招来@2。"
  },
  RelicConfig_57737_BattleDesc = {
    Text = "所有唤醒体的暴击率提高 10%。所有莱克和骰子的随机效果不会出现最低值。"
  },
  RelicConfig_57737_Desc = {
    Text = "所有唤醒体的暴击率提高 10%。所有莱克和骰子的随机效果不会出现最低值。"
  },
  RelicConfig_57737_Name = {
    Text = "<OrangeQuality:幸运风衣>"
  },
  RelicConfig_57737_StoryDesc = {
    Text = "它将竖起一道厚厚的障壁，将风雨和霉运挡在外面。"
  },
  RelicConfig_57791_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「红宝石胸针、缠丝玛瑙、求救信号、厄运仪式鸟、时灵摆·入迷」。"
  },
  RelicConfig_57791_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「红宝石胸针、缠丝玛瑙、求救信号、厄运仪式鸟、时灵摆·入迷」。"
  },
  RelicConfig_57791_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57791_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57792_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「渔叉、异乡邮票夹、阿尔卡纳记录、意识铭刻、时灵摆·积蓄」。"
  },
  RelicConfig_57792_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「渔叉、异乡邮票夹、阿尔卡纳记录、意识铭刻、时灵摆·积蓄」。"
  },
  RelicConfig_57792_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57792_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57793_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「镭射颌骨、可疑的药膏、蒙尘缝纫机、异种喉舌、时灵摆·移涌」。"
  },
  RelicConfig_57793_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「镭射颌骨、可疑的药膏、蒙尘缝纫机、异种喉舌、时灵摆·移涌」。"
  },
  RelicConfig_57793_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57793_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57794_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「刺荨麻背心、故人的怀表、先贤断章、救济之肢、时灵摆·蔓延」。"
  },
  RelicConfig_57794_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「刺荨麻背心、故人的怀表、先贤断章、救济之肢、时灵摆·蔓延」。"
  },
  RelicConfig_57794_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57794_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57795_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「锈蚀柳叶刀、止血钳、老旧拼图、虫群意识、时灵摆·双生」。"
  },
  RelicConfig_57795_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「锈蚀柳叶刀、止血钳、老旧拼图、虫群意识、时灵摆·双生」。"
  },
  RelicConfig_57795_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57795_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57796_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「精密计时器、桂叶袖扣、无名之神的面纱、噩梦表象、时灵摆·均衡」。"
  },
  RelicConfig_57796_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「精密计时器、桂叶袖扣、无名之神的面纱、噩梦表象、时灵摆·均衡」。"
  },
  RelicConfig_57796_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57796_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_57797_BattleDesc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「崭新的钱包、弥萨格徽章、群星之酒、七鳃鳗之吻、时灵摆·眼」。"
  },
  RelicConfig_57797_Desc = {
    Text = "造物上限 +1。战斗开始后的前五个回合，每个回合开始时将获得一个造物，有「崭新的钱包、弥萨格徽章、群星之酒、七鳃鳗之吻、时灵摆·眼」。"
  },
  RelicConfig_57797_Name = {
    Text = "<OrangeQuality:时灵摆「沉船秘宝」>"
  },
  RelicConfig_57797_StoryDesc = {
    Text = "传说利莫里亚陷落于这片海域。 谁能忍住不去探寻沉船宝藏的秘密？"
  },
  RelicConfig_58872_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「锈蚀柳叶刀、新式轮轴、我们的家、古怪钩爪、时灵摆·入迷」。"
  },
  RelicConfig_58872_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「锈蚀柳叶刀、新式轮轴、我们的家、古怪钩爪、时灵摆·入迷」。"
  },
  RelicConfig_58872_Name = {
    Text = "<OrangeQuality:时灵摆「秘宝α」>"
  },
  RelicConfig_58873_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「甜蜜墨水、失声唱机、群星之酒、诡术礼帽、时灵摆·移涌」。"
  },
  RelicConfig_58873_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「甜蜜墨水、失声唱机、群星之酒、诡术礼帽、时灵摆·移涌」。"
  },
  RelicConfig_58873_Name = {
    Text = "<OrangeQuality:时灵摆「秘宝β」>"
  },
  RelicConfig_59118_BattleDesc = {
    Text = "回合开始后获得 1 张「莱克的幸运骰子」，骰子投出的点数 +1。回合开始时与每次投骰子后所有唤醒体获得 4% 暴击伤害，最多获得 100%。"
  },
  RelicConfig_59118_Desc = {
    Text = "回合开始后获得 1 张「莱克的幸运骰子」，骰子投出的点数 +1。回合开始时与每次投骰子后所有唤醒体获得 4% 暴击伤害，最多获得 100%。"
  },
  RelicConfig_59118_Name = {
    Text = "<OrangeQuality:时灵摆「混沌馈赠」>"
  },
  RelicConfig_59118_StoryDesc = {
    Text = "远古的罪孽镌刻于此。"
  },
  RelicConfig_59687_BattleDesc = {
    Text = "模拟战标准造物7件套"
  },
  RelicConfig_59687_Desc = {
    Text = "模拟战标准造物7件套"
  },
  RelicConfig_59687_Name = {
    Text = "<RedQuality:☆模拟战造物☆>"
  },
  RelicConfig_59687_StoryDesc = {
    Text = "在奇异的纪元中，花朵才是人类的第一观赏者。\n不要动弹，祂们更偏爱安静的展品。"
  },
  RelicConfig_60723_BattleDesc = {
    Text = "最大算力提高 1，回合开始时额外抽 1 张牌，将获得 1 张「协乐的交响」。连续 3 次打出的指令卡算力相同时，所有唤醒体获得 20 点狂气，回合开始时和触发后重置次数。"
  },
  RelicConfig_60723_Desc = {
    Text = "最大算力提高 1，回合开始时额外抽 1 张牌，将获得 1 张「协乐的交响」。连续 3 次打出的指令卡算力相同时，所有唤醒体获得 20 点狂气，回合开始时和触发后重置次数。"
  },
  RelicConfig_60723_Name = {
    Text = "<OrangeQuality:乐团指挥棒>"
  },
  RelicConfig_60723_StoryDesc = {
    Text = "纤细的指挥棒，却拥有比撬棍更强大的力量。\n\n指挥音符、指挥灵魂、指挥命运。"
  },
  RelicConfig_60724_BattleDesc = {
    Text = "战斗开始时，将获得「易伤」刻印和「爆发」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60724_Desc = {
    Text = "战斗开始时，将获得「易伤」刻印和「爆发」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60724_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60724_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60725_BattleDesc = {
    Text = "战斗开始时，将获得「狂气」刻印和「催化」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60725_Desc = {
    Text = "战斗开始时，将获得「狂气」刻印和「催化」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60725_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60725_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60726_BattleDesc = {
    Text = "战斗开始时，将获得「虚弱」刻印和「筹算」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60726_Desc = {
    Text = "战斗开始时，将获得「虚弱」刻印和「筹算」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60726_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60726_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60727_BattleDesc = {
    Text = "战斗开始时，将获得「铁壁」刻印和「妙手」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60727_Desc = {
    Text = "战斗开始时，将获得「铁壁」刻印和「妙手」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60727_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60727_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60728_BattleDesc = {
    Text = "战斗开始时，将获得「孕育」刻印和「回声」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60728_Desc = {
    Text = "战斗开始时，将获得「孕育」刻印和「回声」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60728_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60728_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60729_BattleDesc = {
    Text = "战斗开始时，将获得「妙手」刻印和「灵感」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60729_Desc = {
    Text = "战斗开始时，将获得「妙手」刻印和「灵感」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60729_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60729_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60730_BattleDesc = {
    Text = "战斗开始时，将获得「蛮力」刻印和「衰竭」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60730_Desc = {
    Text = "战斗开始时，将获得「蛮力」刻印和「衰竭」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60730_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60730_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60731_BattleDesc = {
    Text = "战斗开始时，将获得 2 个「合奏」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60731_Desc = {
    Text = "战斗开始时，将获得 2 个「合奏」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60731_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60731_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_60732_BattleDesc = {
    Text = "战斗开始时，将获得「筹算」刻印和「镜像」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60732_Desc = {
    Text = "战斗开始时，将获得「筹算」刻印和「镜像」刻印以及其高级刻印，选择刻印在卡牌上。"
  },
  RelicConfig_60732_Name = {
    Text = "<OrangeQuality:时灵摆「校长寄语」>"
  },
  RelicConfig_60732_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_65376_BattleDesc = {
    Text = "初始拥有 [Arg1] 科考团人数。战斗开始时，将 5 张<DerivativeCardKeywords_73:猜疑>置入牌库中中。"
  },
  RelicConfig_65376_Desc = {
    Text = "初始拥有 [Arg1] 科考团人数。战斗开始时，将 5 张<DerivativeCardKeywords_73:猜疑>置入牌库中。"
  },
  RelicConfig_65376_Name = {
    Text = "<OrangeQuality:科考团>"
  },
  RelicConfig_65376_StoryDesc = {
    Text = "弥萨格创始人的寄语萦绕在你的耳边。\n\n愿银钥指引前路，弥萨格的守密人。"
  },
  RelicConfig_65406_BattleDesc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_71:「闪耀的人性光辉」>。\n<D05EX_Relic:你的一切努力都是值得的，你几乎保全了科考队伍，幸存的人们真心实意地感激着你。>"
  },
  RelicConfig_65406_Desc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_71:「闪耀的人性光辉」>。\n<D05EX_Relic:你的一切努力都是值得的，你几乎保全了科考队伍，幸存的人们真心实意地感激着你。>"
  },
  RelicConfig_65406_Name = {
    Text = "<OrangeQuality:救难勋章·铂金>"
  },
  RelicConfig_65406_StoryDesc = {
    Text = "你的一切努力都是值得的，你几乎保全了科考队伍，幸存的人们真心实意地感激着你。"
  },
  RelicConfig_65407_BattleDesc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_72:「璀璨的人性光辉」>。\n<D05EX_Relic:你创造了不可思议的奇迹，所有人在灾难过后全部存活，你是人们心中伟大的英雄，关于你的传说或许就要流传在雪山四周。>"
  },
  RelicConfig_65407_Desc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_72:「璀璨的人性光辉」>。\n<D05EX_Relic:你创造了不可思议的奇迹，所有人在灾难过后全部存活，你是人们心中伟大的英雄，关于你的传说或许就要流传在雪山四周。>"
  },
  RelicConfig_65407_Name = {
    Text = "<OrangeQuality:救难勋章·钻石>"
  },
  RelicConfig_65407_StoryDesc = {
    Text = "你创造了不可思议的奇迹，所有人在灾难过后全部存活，你是人们心中伟大的英雄，关于你的传说或许就要流传在雪山四周。"
  },
  RelicConfig_65408_BattleDesc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_68:「暗淡的人性光辉」>。\n<D05EX_Relic:为了走出雪山，你选择了效益优先的策略，并注视着人们一个个死去，幸存者看待你的目光中恐惧大于感激。>"
  },
  RelicConfig_65408_Desc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_68:「暗淡的人性光辉」>。\n<D05EX_Relic:为了走出雪山，你选择了效益优先的策略，并注视着人们一个个死去，幸存者看待你的目光中恐惧大于感激。>"
  },
  RelicConfig_65408_Name = {
    Text = "<OrangeQuality:救难勋章·青铜>"
  },
  RelicConfig_65408_StoryDesc = {
    Text = "为了走出雪山，你选择了效益优先的策略，并注视着人们一个个死去，幸存者看待你的目光中恐惧大于感激。"
  },
  RelicConfig_65409_BattleDesc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_69:「微明的人性光辉」>。\n<D05EX_Relic:你或许努力过了，虽然有一半的人死去，你至少救下了另一半，毕竟牺牲总是难免的。>"
  },
  RelicConfig_65409_Desc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_69:「微明的人性光辉」>。\n<D05EX_Relic:你或许努力过了，虽然有一半的人死去，你至少救下了另一半，毕竟牺牲总是难免的。>"
  },
  RelicConfig_65409_Name = {
    Text = "<OrangeQuality:救难勋章·白银>"
  },
  RelicConfig_65409_StoryDesc = {
    Text = "你或许努力过了，虽然有一半的人死去，你至少救下了另一半，毕竟牺牲总是难免的。"
  },
  RelicConfig_65410_BattleDesc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_70:「人性光辉」>。\n<D05EX_Relic:你拯救了大半的人，将人们原本悲剧的命运改写，你已经尽力了，不是吗？>"
  },
  RelicConfig_65410_Desc = {
    Text = "回合开始时，获得 [Arg1] 张<DerivativeCardKeywords_70:「人性光辉」>。\n<D05EX_Relic:你拯救了大半的人，将人们原本悲剧的命运改写，你已经尽力了，不是吗？>"
  },
  RelicConfig_65410_Name = {
    Text = "<OrangeQuality:救难勋章·黄金>"
  },
  RelicConfig_65410_StoryDesc = {
    Text = "你拯救了大半的人，将人们原本悲剧的命运改写，你已经尽力了，不是吗？"
  },
  RelicConfig_65456_BattleDesc = {
    Text = "战斗开始时洗入 3 张随机「症状」，打出「症状」时获得 [Arg1] 点力量。\n<D05EX_Relic:在你的帮助下，科考团无人生还，你冷漠地为自己谋取到了最大的利益，但这一切真的值得吗？>"
  },
  RelicConfig_65456_Desc = {
    Text = "战斗开始时洗入 3 张随机「症状」，打出「症状」时获得 [Arg1] 点力量。\n<D05EX_Relic:在你的帮助下，科考团无人生还，你冷漠地为自己谋取到了最大的利益，但这一切真的值得吗？>"
  },
  RelicConfig_65456_Name = {
    Text = "<OrangeQuality:独行者之徽>"
  },
  RelicConfig_65456_StoryDesc = {
    Text = "在你的帮助下，科考团无人生还，你为自己谋取到了最大的利益，但这一切真的值得吗？"
  },
  RelicConfig_65569_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「通讯设备、春之祭、祭司权杖、厄运仪式鸟、时灵摆·投射」。"
  },
  RelicConfig_65569_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「通讯设备、春之祭、祭司权杖、厄运仪式鸟、时灵摆·投射」。"
  },
  RelicConfig_65569_Name = {
    Text = "<OrangeQuality:时灵摆「秘宝δ」>"
  },
  RelicConfig_65570_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「弥萨格徽章、医生手提箱、原型电池、意识铭刻、时灵摆·衍化」。"
  },
  RelicConfig_65570_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「弥萨格徽章、医生手提箱、原型电池、意识铭刻、时灵摆·衍化」。"
  },
  RelicConfig_65570_Name = {
    Text = "<OrangeQuality:时灵摆「秘宝γ」>"
  },
  RelicConfig_66515_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「普特尼晨报、美学原理、群氓之歌、残缺面孔、时灵摆·往来」。"
  },
  RelicConfig_66515_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。接下来 5 个回合，每回合开始时将获得一个造物，有「普特尼晨报、美学原理、群氓之歌、残缺面孔、时灵摆·往来」。"
  },
  RelicConfig_66515_Name = {
    Text = "<OrangeQuality:时灵摆「秘宝ε」>"
  },
  RelicConfig_66518_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_66518_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_66518_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿β」>"
  },
  RelicConfig_66519_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_66519_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_66519_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿α」>"
  },
  RelicConfig_67690_BattleDesc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 1.5 倍。"
  },
  RelicConfig_67690_Desc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 1.5 倍。"
  },
  RelicConfig_67690_Name = {
    Text = "<OrangeQuality:受祝·噩梦表象β>"
  },
  RelicConfig_67690_StoryDesc = {
    Text = "无需恐惧，无需彷徨。这不过是转瞬即逝的梦，父神的光依旧照耀在你身上。"
  },
  RelicConfig_67788_BattleDesc = {
    Text = "拾取时，获得 3 点算力。"
  },
  RelicConfig_67788_Desc = {
    Text = "拾取时，获得 3 点算力。"
  },
  RelicConfig_67788_Name = {
    Text = "<WhiteQuality:怀表镜>"
  },
  RelicConfig_67788_StoryDesc = {
    Text = "记忆凝固在往昔的时间，深埋于黑色之底。"
  },
  RelicConfig_67789_BattleDesc = {
    Text = "拾取时，将 1 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_67789_Desc = {
    Text = "拾取时，将 1 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_67789_Name = {
    Text = "<WhiteQuality:通讯设备>"
  },
  RelicConfig_67789_StoryDesc = {
    Text = "期待或恐惧它发出清脆铃声的瞬间。"
  },
  RelicConfig_67790_BattleDesc = {
    Text = "所有「打击」造成的暴击伤害提高 20%。拾取时，将 1 张<DerivativeCardKeywords_40:「美丽瞬间 」>加入手中。"
  },
  RelicConfig_67790_Desc = {
    Text = "所有「打击」造成的暴击伤害提高 20%。拾取时，将 1 张<DerivativeCardKeywords_40:「美丽瞬间 」>加入手中。"
  },
  RelicConfig_67790_Name = {
    Text = "<WhiteQuality:美丽瞬间>"
  },
  RelicConfig_67790_StoryDesc = {
    Text = "将须臾的美保存至永远。"
  },
  RelicConfig_67791_BattleDesc = {
    Text = "拾取时，对所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  RelicConfig_67791_Desc = {
    Text = "拾取时，对所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  RelicConfig_67791_Name = {
    Text = "<WhiteQuality:变色拘束服>"
  },
  RelicConfig_67791_StoryDesc = {
    Text = "不止有时间能使织物变色，恐惧与痛苦亦能。"
  },
  RelicConfig_67793_BattleDesc = {
    Text = "战斗开始时，所有唤醒体获得 50 点狂气。将 2 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_67793_Desc = {
    Text = "拾取时，所有唤醒体获得 50 点狂气，将 2 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  RelicConfig_67793_Name = {
    Text = "<OrangeQuality:通讯设备+β>"
  },
  RelicConfig_67793_StoryDesc = {
    Text = "期待或恐惧它发出清脆铃声的瞬间。"
  },
  RelicConfig_67794_BattleDesc = {
    Text = "手牌上限提高 5，战斗开始时补充手牌至上限。回合开始时额外抽 1 张牌，回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_67794_Desc = {
    Text = "手牌上限提高 5，战斗开始时补充手牌至上限。回合开始时额外抽 1 张牌，回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  RelicConfig_67794_Name = {
    Text = "<OrangeQuality:受祝·意识铭刻β>"
  },
  RelicConfig_67794_StoryDesc = {
    Text = "贪婪者将自己的过错铭刻在心，并潜心为自己的过去赎罪。"
  },
  RelicConfig_67818_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67818_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67818_Name = {
    Text = "<OrangeQuality:「万象门扉ε」>"
  },
  RelicConfig_67819_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67819_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67819_Name = {
    Text = "<OrangeQuality:「万象门扉ζ」>"
  },
  RelicConfig_67820_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67820_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67820_Name = {
    Text = "<OrangeQuality:「万象门扉θ」>"
  },
  RelicConfig_67821_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67821_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67821_Name = {
    Text = "<OrangeQuality:「万象门扉γ」>"
  },
  RelicConfig_67822_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67822_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67822_Name = {
    Text = "<OrangeQuality:「万象门扉α」>"
  },
  RelicConfig_67823_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67823_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67823_Name = {
    Text = "<OrangeQuality:「万象门扉η」>"
  },
  RelicConfig_67824_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67824_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67824_Name = {
    Text = "<OrangeQuality:「万象门扉δ」>"
  },
  RelicConfig_67825_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67825_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67825_Name = {
    Text = "<OrangeQuality:「万象门扉β」>"
  },
  RelicConfig_67826_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67826_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。回合开始时，随机发现一个「造物」或「支援」，共发现五次。"
  },
  RelicConfig_67826_Name = {
    Text = "<OrangeQuality:「万象门扉ι」>"
  },
  RelicConfig_68651_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_84:「追忆微光-未完的蜡像」>置入手中，复制所有抽牌堆的卡牌。每回合额外抽 5 张牌，获得 5 点算力。打出「打击」或「防御」后，获得 [Arg1] 点护盾。"
  },
  RelicConfig_68651_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_84:「追忆微光-未完的蜡像」>置入手中，复制所有抽牌堆的卡牌。每回合额外抽 5 张牌，获得 5 点算力。打出「打击」或「防御」后，获得 [Arg1] 点护盾。"
  },
  RelicConfig_68651_Name = {
    Text = "<OrangeQuality:「纯银之芯· 恐惧」>"
  },
  RelicConfig_68652_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_85:「追忆微光-畸变之心」>置入手中。回合开始时，能够选择任意张手牌丢弃，抽等量的牌。奇数回合获得 [Arg1] 点临时力量，将「<DerivativeCardKeywords_97:不竭战意β」>置入手中。偶数回合获得 [Arg2] 点临时戒备，将<DerivativeCardKeywords_98:「躲藏β」>置入手中。"
  },
  RelicConfig_68652_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_85:「追忆微光-畸变之心」>置入手中。回合开始时，能够选择任意张手牌丢弃，抽等量的牌。奇数回合获得 [Arg1] 点临时力量，将「<DerivativeCardKeywords_97:不竭战意β」>置入手中。偶数回合获得 [Arg2] 点临时戒备，将<DerivativeCardKeywords_98:「躲藏β」>置入手中。"
  },
  RelicConfig_68652_Name = {
    Text = "<OrangeQuality:「纯银之芯· 刺骨」>"
  },
  RelicConfig_68653_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_83:「追忆微光-天真的回礼」>置入手中。所有唤醒体每回合能额外释放 1 次狂气爆发，释放狂气爆发后降低敌方 [Arg2] 点力量。回合开始时，所有唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_68653_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_83:「追忆微光-天真的回礼」>置入手中。所有唤醒体每回合能额外释放 1 次狂气爆发，释放狂气爆发后降低敌方 [Arg2] 点力量。回合开始时，所有唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_68653_Name = {
    Text = "<OrangeQuality:「纯银之芯· 悲泣」>"
  },
  RelicConfig_68654_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_88:「追忆微光-乌托邦帷幕」>置入手中，队伍手牌上限+2，银钥能量存储上限+100％。释放钥令后，所有唤醒体临时暴击率和暴击伤害+ [Arg1] %，获得 20％ 最大生命的护盾，抽牌直到手牌达到上限。"
  },
  RelicConfig_68654_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_88:「追忆微光-乌托邦帷幕」>置入手中，队伍手牌上限+2，银钥能量存储上限+100％。释放钥令后，所有唤醒体临时暴击率和暴击伤害+ [Arg1] %，获得 20％ 最大生命的护盾，抽牌直到手牌达到上限。"
  },
  RelicConfig_68654_Name = {
    Text = "<OrangeQuality:「纯银之芯· 疯狂」>"
  },
  RelicConfig_68655_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_89:「追忆微光-丰穰之核」>置入手中。回合结束时，保留剩余算力且不再弃置手牌。每造成 1 次主动伤害，就获得 [Arg1] 点临时力量和 [Arg2] 点护盾。"
  },
  RelicConfig_68655_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_89:「追忆微光-丰穰之核」>置入手中。回合结束时，保留剩余算力且不再弃置手牌。每造成 1 次主动伤害，就获得 [Arg1] 点临时力量和 [Arg2] 点护盾。"
  },
  RelicConfig_68655_Name = {
    Text = "<OrangeQuality:「纯银之芯· 诞临」>"
  },
  RelicConfig_68656_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_86:「追忆微光-蜂蜜甜酒」>置入手中，所有唤醒体暴击伤害变为 1.5 倍。回合结束时未释放狂气爆发的唤醒体获得 [Arg1] 点狂气。若打出卡牌数小于 [Arg2] ，下回合抽 2 张牌，获得 2 点算力。"
  },
  RelicConfig_68656_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_86:「追忆微光-蜂蜜甜酒」>置入手中，所有唤醒体暴击伤害变为 1.5 倍。回合结束时未释放狂气爆发的唤醒体获得 [Arg1] 点狂气。若打出卡牌数小于 [Arg2] ，下回合抽 2 张牌，获得 2 点算力。"
  },
  RelicConfig_68656_Name = {
    Text = "<OrangeQuality:「纯银之芯· 诡谲」>"
  },
  RelicConfig_68657_BattleDesc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_87:「追忆微光-代行者的裁决」>置入手中，队伍伤害强效翻倍。玩家造成的虚弱效果由 25% 提高为 50%，每回合结束时获得最大生命 [Arg1]％ 的护盾并对所有敌人造成等同于自身 [Arg2] 倍护盾的<FixedDamage:纯粹伤害>。"
  },
  RelicConfig_68657_Desc = {
    Text = "战斗开始时觉醒所有唤醒体，将<DerivativeCardKeywords_87:「追忆微光-代行者的裁决」>置入手中，队伍伤害强效翻倍。玩家造成的虚弱效果由 25% 提高为 50%，每回合结束时获得最大生命 [Arg1]％ 的护盾并对所有敌人造成等同于自身 [Arg2] 倍护盾的<FixedDamage:纯粹伤害>。"
  },
  RelicConfig_68657_Name = {
    Text = "<OrangeQuality:「纯银之芯· 邪信」>"
  },
  RelicConfig_68886_BattleDesc = {
    Text = "塔薇造成的伤害、治疗、护盾提高 50％。战斗开始时塔薇获得 120 点狂气。"
  },
  RelicConfig_68886_Desc = {
    Text = "塔薇造成的伤害、护盾、生命回复提高 50％。战斗开始时塔薇获得 120 点狂气。"
  },
  RelicConfig_68886_Name = {
    Text = "<OrangeQuality:「全知之眼」>"
  },
  RelicConfig_68886_StoryDesc = {
    Text = "自门扉而出，祂踏上唯一正确的道路。"
  },
  RelicConfig_69319_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69319_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69319_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿ε」>"
  },
  RelicConfig_69320_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69320_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69320_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿γ」>"
  },
  RelicConfig_69321_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69321_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，发现一个造物，共发现五次。"
  },
  RelicConfig_69321_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿δ」>"
  },
  RelicConfig_70042_BattleDesc = {
    Text = "回合开始时，积攒 1 点「深渊源能」，选择「沉眠」或「苏醒」。沉眠：额外积攒 1 点「深渊源能」。苏醒：消耗 1/5/10 点「深渊源能」，获得图鲁的援助。消耗的「深渊源能」越多，图鲁的援助效果越强。"
  },
  RelicConfig_70042_Desc = {
    Text = "回合开始时，积攒 1 点「深渊源能」，选择「沉眠」或「苏醒」。沉眠：额外积攒 1 点「深渊源能」。苏醒：消耗 1/5/10 点「深渊源能」，获得图鲁的援助。消耗的「深渊源能」越多，图鲁的援助效果越强。"
  },
  RelicConfig_70042_Name = {
    Text = "<OrangeQuality:神王的权能>"
  },
  RelicConfig_70084_BattleDesc = {
    Text = "战斗开始时，将所有唤醒体的「灵知觉醒」洗入抽牌堆。"
  },
  RelicConfig_70084_Desc = {
    Text = "战斗开始时，将所有唤醒体的「灵知觉醒」洗入抽牌堆。"
  },
  RelicConfig_70084_Name = {
    Text = "<OrangeQuality:灵知觉醒>"
  },
  RelicConfig_70700_BattleDesc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。"
  },
  RelicConfig_70700_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。"
  },
  RelicConfig_70700_Name = {
    Text = "<WhiteQuality:哭泣烟斗>"
  },
  RelicConfig_70700_StoryDesc = {
    Text = "这究竟是仇恨的产物，还是复仇的结果？"
  },
  RelicConfig_70701_BattleDesc = {
    Text = "回合开始时所有唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70701_Desc = {
    Text = "回合开始时所有唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70701_Name = {
    Text = "<WhiteQuality:原型电池>"
  },
  RelicConfig_70701_StoryDesc = {
    Text = "便携式的希望。"
  },
  RelicConfig_70702_BattleDesc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70702_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70702_Name = {
    Text = "<OrangeQuality:重锁+>"
  },
  RelicConfig_70702_StoryDesc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  RelicConfig_70703_BattleDesc = {
    Text = "「打击」额外造成 1 次 [Arg1]% 唤醒体攻击力的伤害，每回合至多触发 3 次。"
  },
  RelicConfig_70703_Desc = {
    Text = "「打击」额外造成 1 次 [Arg1]% 唤醒体攻击力的伤害，每回合至多触发 3 次。"
  },
  RelicConfig_70703_Name = {
    Text = "<WhiteQuality:锈蚀柳叶刀>"
  },
  RelicConfig_70703_StoryDesc = {
    Text = "不适宜用于割开活体。"
  },
  RelicConfig_70704_BattleDesc = {
    Text = "使用银钥觉醒后对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70704_Desc = {
    Text = "使用银钥觉醒后对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70704_Name = {
    Text = "<OrangeQuality:可疑的药膏+>"
  },
  RelicConfig_70704_StoryDesc = {
    Text = "某种自制的外伤药膏，请不要在没有医生指导的情况下使用。"
  },
  RelicConfig_70705_BattleDesc = {
    Text = "「打击」施加造成伤害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 点。"
  },
  RelicConfig_70705_Desc = {
    Text = "「打击」施加造成伤害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 点。"
  },
  RelicConfig_70705_Name = {
    Text = "<OrangeQuality:异种喉舌+>"
  },
  RelicConfig_70705_StoryDesc = {
    Text = "祂不是恶魔，但祂确实会传递人世之外的低语。"
  },
  RelicConfig_70706_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自动获得量提高 [Arg1]%。"
  },
  RelicConfig_70706_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自动获得量提高 [Arg1]%。"
  },
  RelicConfig_70706_Name = {
    Text = "<WhiteQuality:瘟疫诊断书>"
  },
  RelicConfig_70706_StoryDesc = {
    Text = "瘟疫——大自然无意识烦躁的偶然表现。"
  },
  RelicConfig_70707_BattleDesc = {
    Text = "使用银钥觉醒后所有唤醒体获得 [Arg1] 狂气和 [Arg2] 银钥能量。"
  },
  RelicConfig_70707_Desc = {
    Text = "使用银钥觉醒后所有唤醒体获得 [Arg1] 狂气和 [Arg2] 银钥能量。"
  },
  RelicConfig_70707_Name = {
    Text = "<OrangeQuality:桂叶袖扣+>"
  },
  RelicConfig_70707_StoryDesc = {
    Text = "印刻了桂叶花纹的银质袖扣。\n它做工精致，闪闪发亮，曾经承载了两个孩子的友谊。"
  },
  RelicConfig_70708_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<IntoxicationIconKeywords:中毒>与造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70708_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<IntoxicationIconKeywords:中毒>与造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70708_Name = {
    Text = "<OrangeQuality:蒙尘缝纫机+>"
  },
  RelicConfig_70708_StoryDesc = {
    Text = "一位慈祥的母亲，缝补心脏上的伤。"
  },
  RelicConfig_70709_BattleDesc = {
    Text = "进入超维回合后，第一张打出的非衍生指令卡额外生效 [Arg1] 次。"
  },
  RelicConfig_70709_Desc = {
    Text = "进入超维回合后，第一张打出的非衍生指令卡额外生效 [Arg1] 次。"
  },
  RelicConfig_70709_Name = {
    Text = "<WhiteQuality:辉光沙漏>"
  },
  RelicConfig_70709_StoryDesc = {
    Text = "一份可计量的时间。"
  },
  RelicConfig_70711_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] <RetaliateIconKeywords:反击>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70711_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] <RetaliateIconKeywords:反击>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70711_Name = {
    Text = "<OrangeQuality:先贤断章+>"
  },
  RelicConfig_70711_StoryDesc = {
    Text = "「人类何其愚蠢，只因陈腐，便会盲信。」"
  },
  RelicConfig_70712_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70712_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70712_Name = {
    Text = "<WhiteQuality:我们的家>"
  },
  RelicConfig_70712_StoryDesc = {
    Text = "他们之前在一起，之后也会永远在一起。他们是相亲相爱的一家人。"
  },
  RelicConfig_70713_BattleDesc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_70713_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_70713_Name = {
    Text = "<WhiteQuality:锈蚀钢锯>"
  },
  RelicConfig_70713_StoryDesc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  RelicConfig_70714_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<RetaliateIconKeywords:反击>与造物造成的<RetaliateIconKeywords:反击>提高 [Arg2]%。"
  },
  RelicConfig_70714_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<RetaliateIconKeywords:反击>与造物造成的<RetaliateIconKeywords:反击>提高 [Arg2]%。"
  },
  RelicConfig_70714_Name = {
    Text = "<WhiteQuality:知无不言>"
  },
  RelicConfig_70714_StoryDesc = {
    Text = "它传递了无数主动或被动说出的秘密。"
  },
  RelicConfig_70715_BattleDesc = {
    Text = "使用银钥觉醒后抽 [Arg1] 张牌并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70715_Desc = {
    Text = "使用银钥觉醒后抽 [Arg1] 张牌并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70715_Name = {
    Text = "<OrangeQuality:崭新的钱包+>"
  },
  RelicConfig_70715_StoryDesc = {
    Text = "印刻了弥萨格大学校徽的皮质钱包。\n里面现在空空如也，什么也没有。"
  },
  RelicConfig_70717_BattleDesc = {
    Text = "回合开始时抽 [Arg1] 张牌。"
  },
  RelicConfig_70717_Desc = {
    Text = "回合开始时抽 [Arg1] 张牌。"
  },
  RelicConfig_70717_Name = {
    Text = "<OrangeQuality:定向罗盘+>"
  },
  RelicConfig_70717_StoryDesc = {
    Text = "指示的并非方向，仅是磁场。"
  },
  RelicConfig_70718_BattleDesc = {
    Text = "释放「狂气爆发」后，使所有敌人受到 [Arg1] 点<FixedDamage:纯粹伤害>，并触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70718_Desc = {
    Text = "释放「狂气爆发」后，使所有敌人受到 1 次 [Arg2]% 我方最大生命值的<FixedDamage:纯粹伤害>，并触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70718_Name = {
    Text = "<WhiteQuality:镭射颌骨>"
  },
  RelicConfig_70718_StoryDesc = {
    Text = "陈列在某个收藏家私人展厅内的遗骨。\n收藏家醉心于那美丽的荧光，日夜欣赏，最终枯死，最终成为了它的同类。"
  },
  RelicConfig_70719_BattleDesc = {
    Text = "回合开始时所有唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70719_Desc = {
    Text = "回合开始时所有唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70719_Name = {
    Text = "<OrangeQuality:原型电池+>"
  },
  RelicConfig_70719_StoryDesc = {
    Text = "便携式的希望。"
  },
  RelicConfig_70720_BattleDesc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70720_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70720_Name = {
    Text = "<WhiteQuality:无上荣宠>"
  },
  RelicConfig_70720_StoryDesc = {
    Text = "优雅、神秘的黑色短毛猫，据说在某个远方的沙漠国度被视作神明的化身。可那位神祇的名讳，如今已无人知晓。\n被崇拜，被敬仰，被遗忘，或许是为神明的宿命。"
  },
  RelicConfig_70721_BattleDesc = {
    Text = "在一回合释放 4 次「狂气爆发」后，获得 [Arg1] 算力，3 回合冷却。"
  },
  RelicConfig_70721_Desc = {
    Text = "在一回合释放 4 次「狂气爆发」后，获得 [Arg1] 算力，3 回合冷却。"
  },
  RelicConfig_70721_Name = {
    Text = "<WhiteQuality:银白差分机>"
  },
  RelicConfig_70721_StoryDesc = {
    Text = "「它改变了历史。」"
  },
  RelicConfig_70722_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70722_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] <PowerIconKeywords:力量>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70722_Name = {
    Text = "<OrangeQuality:我们的家+>"
  },
  RelicConfig_70722_StoryDesc = {
    Text = "他们之前在一起，之后也会永远在一起。他们是相亲相爱的一家人。"
  },
  RelicConfig_70723_BattleDesc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 [Arg1] <RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70723_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 [Arg1] <RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70723_Name = {
    Text = "<OrangeQuality:阿尔卡纳记录+>"
  },
  RelicConfig_70723_StoryDesc = {
    Text = "命运的走势。"
  },
  RelicConfig_70724_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70724_Desc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70724_Name = {
    Text = "<OrangeQuality:红宝石胸针+>"
  },
  RelicConfig_70724_StoryDesc = {
    Text = "隐约渗出鲜红。"
  },
  RelicConfig_70725_BattleDesc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70725_Desc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70725_Name = {
    Text = "<OrangeQuality:恶童+>"
  },
  RelicConfig_70725_StoryDesc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  RelicConfig_70726_BattleDesc = {
    Text = "湮灭获得 [Arg1] 护盾，3 回合冷却。"
  },
  RelicConfig_70726_Desc = {
    Text = "湮灭获得 [Arg1] 护盾，3 回合冷却。"
  },
  RelicConfig_70726_Name = {
    Text = "<WhiteQuality:超弦怀表>"
  },
  RelicConfig_70726_StoryDesc = {
    Text = "「哎呀，怀表停了。」"
  },
  RelicConfig_70727_BattleDesc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_70727_Desc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_70727_Name = {
    Text = "<OrangeQuality:恩赐之血+>"
  },
  RelicConfig_70727_StoryDesc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  RelicConfig_70728_BattleDesc = {
    Text = "使用静海姿态令所有敌人失去 [Arg1] 点临时<ExhaustionIconKeywords:力量>，3 回合冷却。"
  },
  RelicConfig_70728_Desc = {
    Text = "使用静海姿态令所有敌人失去 [Arg1] 点临时<ExhaustionIconKeywords:力量>，3 回合冷却。"
  },
  RelicConfig_70728_Name = {
    Text = "<OrangeQuality:无名附肢+>"
  },
  RelicConfig_70728_StoryDesc = {
    Text = "小心扎手。"
  },
  RelicConfig_70730_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70730_Desc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。"
  },
  RelicConfig_70730_Name = {
    Text = "<WhiteQuality:红宝石胸针>"
  },
  RelicConfig_70730_StoryDesc = {
    Text = "隐约渗出鲜红。"
  },
  RelicConfig_70731_BattleDesc = {
    Text = "受到敌人攻击时使其受到 [Arg1] 点<FixedDamage:纯粹伤害>，这个伤害享受 [Arg2]%<RetaliateIconKeywords:反击>加成，每个敌人每回合最多触发 1 次。"
  },
  RelicConfig_70731_Desc = {
    Text = "受到敌人攻击时使其受到 [Arg3]% 我方最大生命值的<FixedDamage:纯粹伤害>，这个伤害享受 [Arg2]%<RetaliateIconKeywords:反击>加成，每个敌人每回合最多触发 1 次。"
  },
  RelicConfig_70731_Name = {
    Text = "<OrangeQuality:遗落的祭祀刀+>"
  },
  RelicConfig_70731_StoryDesc = {
    Text = "刃面弯曲的匕首，常用于祭祀仪式。"
  },
  RelicConfig_70732_BattleDesc = {
    Text = "进入超维回合后，第一张打出的非衍生指令卡额外生效 [Arg1] 次。"
  },
  RelicConfig_70732_Desc = {
    Text = "进入超维回合后，第一张打出的非衍生指令卡额外生效 [Arg1] 次。"
  },
  RelicConfig_70732_Name = {
    Text = "<OrangeQuality:辉光沙漏+>"
  },
  RelicConfig_70732_StoryDesc = {
    Text = "一份可计量的时间。"
  },
  RelicConfig_70733_BattleDesc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自动获得量提高 [Arg1]%。"
  },
  RelicConfig_70733_Desc = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>自动获得量提高 [Arg1]%。"
  },
  RelicConfig_70733_Name = {
    Text = "<OrangeQuality:瘟疫诊断书+>"
  },
  RelicConfig_70733_StoryDesc = {
    Text = "瘟疫——大自然无意识烦躁的偶然表现。"
  },
  RelicConfig_70734_BattleDesc = {
    Text = "使用银钥觉醒后使所有唤醒体造成的基础伤害提高 [Arg1]%并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70734_Desc = {
    Text = "使用银钥觉醒后使所有唤醒体造成的基础伤害提高 [Arg1]%并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70734_Name = {
    Text = "<WhiteQuality:秘典星象仪>"
  },
  RelicConfig_70734_StoryDesc = {
    Text = "宇宙的奥妙。"
  },
  RelicConfig_70735_BattleDesc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多触发 3 次。"
  },
  RelicConfig_70735_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多触发 3 次。"
  },
  RelicConfig_70735_Name = {
    Text = "<OrangeQuality:阿尔卡纳遗物+>"
  },
  RelicConfig_70735_StoryDesc = {
    Text = "命运的终焉。"
  },
  RelicConfig_70736_BattleDesc = {
    Text = "使用静海姿态令所有敌人失去 [Arg1] 点临时<ExhaustionIconKeywords:力量>，3 回合冷却。"
  },
  RelicConfig_70736_Desc = {
    Text = "使用静海姿态令所有敌人失去 [Arg1] 点临时<ExhaustionIconKeywords:力量>，3 回合冷却。"
  },
  RelicConfig_70736_Name = {
    Text = "<WhiteQuality:无名附肢>"
  },
  RelicConfig_70736_StoryDesc = {
    Text = "小心扎手。"
  },
  RelicConfig_70737_BattleDesc = {
    Text = "打出卡牌后，若手牌数小于等于 [Arg1] ，抽 [Arg2] 张牌，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_70737_Desc = {
    Text = "打出卡牌后，若手牌数小于等于 [Arg1] ，抽 [Arg2] 张牌，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_70737_Name = {
    Text = "<WhiteQuality:魔术手套>"
  },
  RelicConfig_70737_StoryDesc = {
    Text = "「别害怕，这只是魔术。」"
  },
  RelicConfig_70738_BattleDesc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_70738_Desc = {
    Text = "回合结束时回复 [Heal:Arg1] 生命。"
  },
  RelicConfig_70738_Name = {
    Text = "<WhiteQuality:恩赐之血>"
  },
  RelicConfig_70738_StoryDesc = {
    Text = "它甘甜醇美，散发着蔷薇花香。"
  },
  RelicConfig_70739_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] 护盾和 [Arg2] 银钥能量。"
  },
  RelicConfig_70739_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] 护盾和 [Arg2] 银钥能量。"
  },
  RelicConfig_70739_Name = {
    Text = "<WhiteQuality:蝴蝶标本>"
  },
  RelicConfig_70739_StoryDesc = {
    Text = "至今，他也被谁深深地喜爱着。"
  },
  RelicConfig_70740_BattleDesc = {
    Text = "使用银钥觉醒后使所有唤醒体造成的基础伤害提高 [Arg1]%并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70740_Desc = {
    Text = "使用银钥觉醒后使所有唤醒体造成的基础伤害提高 [Arg1]%并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70740_Name = {
    Text = "<OrangeQuality:秘典星象仪+>"
  },
  RelicConfig_70740_StoryDesc = {
    Text = "宇宙的奥妙。"
  },
  RelicConfig_70741_BattleDesc = {
    Text = "最大算力提高 [Arg1] 。"
  },
  RelicConfig_70741_Desc = {
    Text = "最大算力提高 [Arg1] 。"
  },
  RelicConfig_70741_Name = {
    Text = "<OrangeQuality:活性注射器+>"
  },
  RelicConfig_70741_StoryDesc = {
    Text = "抽搐也是活性的一种。"
  },
  RelicConfig_70742_BattleDesc = {
    Text = "战斗开始时，触腕上限+[Arg1]，获得 [Arg2] 条触腕。"
  },
  RelicConfig_70742_Desc = {
    Text = "战斗开始时，触腕上限+[Arg1]，获得 [Arg2] 条触腕。"
  },
  RelicConfig_70742_Name = {
    Text = "<WhiteQuality:海眷歌谣>"
  },
  RelicConfig_70742_StoryDesc = {
    Text = "据说织纹螺等不可食用动物吸收了海洋大约80%的营养。"
  },
  RelicConfig_70743_BattleDesc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70743_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70743_Name = {
    Text = "<WhiteQuality:金色梦乡>"
  },
  RelicConfig_70743_StoryDesc = {
    Text = "蜕变之日即是你的死期。"
  },
  RelicConfig_70744_BattleDesc = {
    Text = "打出非衍生指令卡后，将算力消耗降低 2 的该卡牌 [Arg1]  张临时复制洗入抽牌堆，3 回合冷却。"
  },
  RelicConfig_70744_Desc = {
    Text = "打出非衍生指令卡后，将算力消耗降低 2 的该卡牌 [Arg1]  张临时复制洗入抽牌堆，3 回合冷却。"
  },
  RelicConfig_70744_Name = {
    Text = "<OrangeQuality:失声唱机+>"
  },
  RelicConfig_70744_StoryDesc = {
    Text = "他的声音消失在了风中。"
  },
  RelicConfig_70745_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] <RetaliateIconKeywords:反击>，首领战效果翻倍。"
  },
  RelicConfig_70745_Desc = {
    Text = "战斗开始时获得 [Arg1] <RetaliateIconKeywords:反击>，首领战效果翻倍。"
  },
  RelicConfig_70745_Name = {
    Text = "<OrangeQuality:刺荨麻背心+>"
  },
  RelicConfig_70745_StoryDesc = {
    Text = "无法分辨沾染的液体。"
  },
  RelicConfig_70746_BattleDesc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70746_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70746_Name = {
    Text = "<OrangeQuality:无上荣宠+>"
  },
  RelicConfig_70746_StoryDesc = {
    Text = "优雅、神秘的黑色短毛猫，据说在某个远方的沙漠国度被视作神明的化身。可那位神祇的名讳，如今已无人知晓。\n被崇拜，被敬仰，被遗忘，或许是为神明的宿命。"
  },
  RelicConfig_70747_BattleDesc = {
    Text = "打出卡牌后，若手牌数小于等于 [Arg1] ，抽 [Arg2] 张牌，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_70747_Desc = {
    Text = "打出卡牌后，若手牌数小于等于 [Arg1] ，抽 [Arg2] 张牌，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_70747_Name = {
    Text = "<OrangeQuality:魔术手套+>"
  },
  RelicConfig_70747_StoryDesc = {
    Text = "「别害怕，这只是魔术。」"
  },
  RelicConfig_70748_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] 护盾和 [Arg2] 银钥能量。"
  },
  RelicConfig_70748_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] 护盾和 [Arg2] 银钥能量。"
  },
  RelicConfig_70748_Name = {
    Text = "<OrangeQuality:蝴蝶标本+>"
  },
  RelicConfig_70748_StoryDesc = {
    Text = "至今，他也被谁深深地喜爱着。"
  },
  RelicConfig_70749_BattleDesc = {
    Text = "每当一张卡进入超维空间时，若这张卡与其他超维空间的卡牌归属者不同，则将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  RelicConfig_70749_Desc = {
    Text = "每当一张卡进入超维空间时，若这张卡与其他超维空间的卡牌归属者不同，则将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  RelicConfig_70749_Name = {
    Text = "<OrangeQuality:阿方索之器+>"
  },
  RelicConfig_70749_StoryDesc = {
    Text = "不同于无常的命运，群星自有运行法则。"
  },
  RelicConfig_70750_BattleDesc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 [Arg1] <RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70750_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 [Arg1] <RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70750_Name = {
    Text = "<WhiteQuality:阿尔卡纳记录>"
  },
  RelicConfig_70750_StoryDesc = {
    Text = "命运的走势。"
  },
  RelicConfig_70751_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] 算力和 [Arg2] 银钥能量。"
  },
  RelicConfig_70751_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] 算力和 [Arg2] 银钥能量。"
  },
  RelicConfig_70751_Name = {
    Text = "<WhiteQuality:弥萨格徽章>"
  },
  RelicConfig_70751_StoryDesc = {
    Text = "弥萨格大学分发给调查员的徽章。它不仅象征了佩戴者的身份，还是一个可以进行远程通讯的工具。"
  },
  RelicConfig_70752_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] <RetaliateIconKeywords:反击>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70752_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] <RetaliateIconKeywords:反击>和 [Arg2] 银钥能量。"
  },
  RelicConfig_70752_Name = {
    Text = "<WhiteQuality:先贤断章>"
  },
  RelicConfig_70752_StoryDesc = {
    Text = "「人类何其愚蠢，只因陈腐，便会盲信。」"
  },
  RelicConfig_70753_BattleDesc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70753_Desc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70753_Name = {
    Text = "<OrangeQuality:春之祭+>"
  },
  RelicConfig_70753_StoryDesc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  RelicConfig_70754_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70754_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70754_Name = {
    Text = "<WhiteQuality:染血鹅卵石>"
  },
  RelicConfig_70754_StoryDesc = {
    Text = "一、二、三、四、五。"
  },
  RelicConfig_70755_BattleDesc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_70755_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_70755_Name = {
    Text = "<OrangeQuality:缠丝玛瑙+>"
  },
  RelicConfig_70755_StoryDesc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  RelicConfig_70756_BattleDesc = {
    Text = "使用银钥觉醒后获得 [Arg1] 算力和 [Arg2] 银钥能量。"
  },
  RelicConfig_70756_Desc = {
    Text = "使用银钥觉醒后获得 [Arg1] 算力和 [Arg2] 银钥能量。"
  },
  RelicConfig_70756_Name = {
    Text = "<OrangeQuality:弥萨格徽章+>"
  },
  RelicConfig_70756_StoryDesc = {
    Text = "弥萨格大学分发给调查员的徽章。它不仅象征了佩戴者的身份，还是一个可以进行远程通讯的工具。"
  },
  RelicConfig_70757_BattleDesc = {
    Text = "使用怒涛姿态立即激发所有触腕攻击敌人 [Arg1] 次，3 回合冷却。"
  },
  RelicConfig_70757_Desc = {
    Text = "使用怒涛姿态立即激发所有触腕攻击敌人 [Arg1] 次，3 回合冷却。"
  },
  RelicConfig_70757_Name = {
    Text = "<WhiteQuality:螺湮的欢愉>"
  },
  RelicConfig_70757_StoryDesc = {
    Text = "长眠之主，候汝入梦。"
  },
  RelicConfig_70758_BattleDesc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多触发 3 次。"
  },
  RelicConfig_70758_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，每回合至多触发 3 次。"
  },
  RelicConfig_70758_Name = {
    Text = "<WhiteQuality:阿尔卡纳遗物>"
  },
  RelicConfig_70758_StoryDesc = {
    Text = "命运的终焉。"
  },
  RelicConfig_70759_BattleDesc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70759_Desc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<WeaknessIconKeywords:虚弱>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70759_Name = {
    Text = "<WhiteQuality:恶童>"
  },
  RelicConfig_70759_StoryDesc = {
    Text = "脱胎于纯粹的恶，即使这并非它所愿。"
  },
  RelicConfig_70760_BattleDesc = {
    Text = "战斗开始时对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首领战效果翻倍。"
  },
  RelicConfig_70760_Desc = {
    Text = "战斗开始时对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首领战效果翻倍。"
  },
  RelicConfig_70760_Name = {
    Text = "<WhiteQuality:神经毒素>"
  },
  RelicConfig_70760_StoryDesc = {
    Text = "提取，淬炼。"
  },
  RelicConfig_70761_BattleDesc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70761_Desc = {
    Text = "战斗开始后，对所有敌人施加 [Arg1] 层<VulnerabilityIconKeywords:易伤>，首领战效果翻倍。所有唤醒体造成的基础伤害提高 [Arg2]%。"
  },
  RelicConfig_70761_Name = {
    Text = "<WhiteQuality:春之祭>"
  },
  RelicConfig_70761_StoryDesc = {
    Text = "在夜的欢笑声中，独木舟的剪影在湖面上自如地滑动。"
  },
  RelicConfig_70762_BattleDesc = {
    Text = "在一回合释放 4 次「狂气爆发」后，获得 [Arg1] 算力，3 回合冷却。"
  },
  RelicConfig_70762_Desc = {
    Text = "在一回合释放 4 次「狂气爆发」后，获得 [Arg1] 算力，3 回合冷却。"
  },
  RelicConfig_70762_Name = {
    Text = "<OrangeQuality:银白差分机+>"
  },
  RelicConfig_70762_StoryDesc = {
    Text = "「它改变了历史。」"
  },
  RelicConfig_70763_BattleDesc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70763_Desc = {
    Text = "释放「狂气爆发」后，获得 [Arg1] 临时<PowerIconKeywords:力量>。"
  },
  RelicConfig_70763_Name = {
    Text = "<WhiteQuality:重锁>"
  },
  RelicConfig_70763_StoryDesc = {
    Text = "厚实而且坚固的锁，如果没有钥匙，想必很难开启。\n当然，这对某个神偷来说不值一提。"
  },
  RelicConfig_70764_BattleDesc = {
    Text = "受到敌人攻击时使其受到 [Arg1] 点<FixedDamage:纯粹伤害>，这个伤害享受 [Arg2]%<RetaliateIconKeywords:反击>加成，每个敌人每回合最多触发 1 次。"
  },
  RelicConfig_70764_Desc = {
    Text = "受到敌人攻击时使其受到 [Arg3]% 我方最大生命值的<FixedDamage:纯粹伤害>，这个伤害享受 [Arg2]%<RetaliateIconKeywords:反击>加成，每个敌人每回合最多触发 1 次。"
  },
  RelicConfig_70764_Name = {
    Text = "<WhiteQuality:遗落的祭祀刀>"
  },
  RelicConfig_70764_StoryDesc = {
    Text = "刃面弯曲的匕首，常用于祭祀仪式。"
  },
  RelicConfig_70765_BattleDesc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_70765_Desc = {
    Text = "每次造成伤害时获得 [Arg1] 临时<PowerIconKeywords:力量>，每回合至多触发 15 次。"
  },
  RelicConfig_70765_Name = {
    Text = "<WhiteQuality:缠丝玛瑙>"
  },
  RelicConfig_70765_StoryDesc = {
    Text = "应该只是普通的玛瑙纹路。大概。"
  },
  RelicConfig_70766_BattleDesc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1]  护盾。"
  },
  RelicConfig_70766_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1]  护盾。"
  },
  RelicConfig_70766_Name = {
    Text = "<WhiteQuality:守护之手>"
  },
  RelicConfig_70766_StoryDesc = {
    Text = "祈福的手，坚定的拳。"
  },
  RelicConfig_70767_BattleDesc = {
    Text = "湮灭使狂气最低的唤醒体获得 [Arg1] 狂气，3 回合冷却。"
  },
  RelicConfig_70767_Desc = {
    Text = "湮灭使狂气最低的唤醒体获得 [Arg1] 狂气，3 回合冷却。"
  },
  RelicConfig_70767_Name = {
    Text = "<WhiteQuality:时间之虫>"
  },
  RelicConfig_70767_StoryDesc = {
    Text = "一块同时存在于钟表店与昆虫博物馆的怀表。\n洪积元年开始后，被纳入大学馆藏。"
  },
  RelicConfig_70768_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<RetaliateIconKeywords:反击>与造物造成的<RetaliateIconKeywords:反击>提高 [Arg2]%。"
  },
  RelicConfig_70768_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<RetaliateIconKeywords:反击>与造物造成的<RetaliateIconKeywords:反击>提高 [Arg2]%。"
  },
  RelicConfig_70768_Name = {
    Text = "<OrangeQuality:知无不言+>"
  },
  RelicConfig_70768_StoryDesc = {
    Text = "它传递了无数主动或被动说出的秘密。"
  },
  RelicConfig_70769_BattleDesc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70769_Desc = {
    Text = "每回合首次直接使用「胚胎」后，本回合内主动伤害会造成 [Arg1]% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  RelicConfig_70769_Name = {
    Text = "<OrangeQuality:染血鹅卵石+>"
  },
  RelicConfig_70769_StoryDesc = {
    Text = "一、二、三、四、五。"
  },
  RelicConfig_70770_BattleDesc = {
    Text = "回合开始时抽 [Arg1] 张牌。"
  },
  RelicConfig_70770_Desc = {
    Text = "回合开始时抽 [Arg1] 张牌。"
  },
  RelicConfig_70770_Name = {
    Text = "<WhiteQuality:定向罗盘>"
  },
  RelicConfig_70770_StoryDesc = {
    Text = "指示的并非方向，仅是磁场。"
  },
  RelicConfig_70771_BattleDesc = {
    Text = "「打击」额外造成 2 次 [Arg1]% 唤醒体攻击力的伤害，每回合至多触发 3 次。"
  },
  RelicConfig_70771_Desc = {
    Text = "「打击」额外造成 2 次 [Arg1]% 唤醒体攻击力的伤害，每回合至多触发 3 次。"
  },
  RelicConfig_70771_Name = {
    Text = "<OrangeQuality:锈蚀柳叶刀+>"
  },
  RelicConfig_70771_StoryDesc = {
    Text = "不适宜用于割开活体。"
  },
  RelicConfig_70772_BattleDesc = {
    Text = "使用银钥觉醒后抽 [Arg1] 张牌并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70772_Desc = {
    Text = "使用银钥觉醒后抽 [Arg1] 张牌并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70772_Name = {
    Text = "<WhiteQuality:崭新的钱包>"
  },
  RelicConfig_70772_StoryDesc = {
    Text = "印刻了弥萨格大学校徽的皮质钱包。\n里面现在空空如也，什么也没有。"
  },
  RelicConfig_70774_BattleDesc = {
    Text = "每回合前五次造成的伤害提高 [Arg1]%。"
  },
  RelicConfig_70774_Desc = {
    Text = "每回合前五次造成的伤害提高 [Arg1]%。"
  },
  RelicConfig_70774_Name = {
    Text = "<WhiteQuality:视力矫正器>"
  },
  RelicConfig_70774_StoryDesc = {
    Text = "曾有人透过它，找到了真相。"
  },
  RelicConfig_70776_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] <RetaliateIconKeywords:反击>，首领战效果翻倍。"
  },
  RelicConfig_70776_Desc = {
    Text = "战斗开始时获得 [Arg1] <RetaliateIconKeywords:反击>，首领战效果翻倍。"
  },
  RelicConfig_70776_Name = {
    Text = "<WhiteQuality:刺荨麻背心>"
  },
  RelicConfig_70776_StoryDesc = {
    Text = "无法分辨沾染的液体。"
  },
  RelicConfig_70777_BattleDesc = {
    Text = "在一回合内打出 4 张归属于不同唤醒体的指令卡后，所有唤醒体获得 [Arg1]  狂气，3 回合冷却。"
  },
  RelicConfig_70777_Desc = {
    Text = "在一回合内打出 4 张归属于不同唤醒体的指令卡后，所有唤醒体获得 [Arg1]  狂气，3 回合冷却。"
  },
  RelicConfig_70777_Name = {
    Text = "<WhiteQuality:无名之神的面纱>"
  },
  RelicConfig_70777_StoryDesc = {
    Text = "不可直视神。"
  },
  RelicConfig_70778_BattleDesc = {
    Text = "战斗开始时对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首领战效果翻倍。"
  },
  RelicConfig_70778_Desc = {
    Text = "战斗开始时对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>，首领战效果翻倍。"
  },
  RelicConfig_70778_Name = {
    Text = "<OrangeQuality:神经毒素+>"
  },
  RelicConfig_70778_StoryDesc = {
    Text = "提取，淬炼。"
  },
  RelicConfig_70779_BattleDesc = {
    Text = "使用银钥觉醒后对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70779_Desc = {
    Text = "使用银钥觉醒后对所有敌人施加 [Arg1] <IntoxicationIconKeywords:中毒>并获得 [Arg2] 银钥能量。"
  },
  RelicConfig_70779_Name = {
    Text = "<WhiteQuality:可疑的药膏>"
  },
  RelicConfig_70779_StoryDesc = {
    Text = "某种自制的外伤药膏，请不要在没有医生指导的情况下使用。"
  },
  RelicConfig_70780_BattleDesc = {
    Text = "「打击」施加造成伤害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 点。"
  },
  RelicConfig_70780_Desc = {
    Text = "「打击」施加造成伤害 [Arg1]% 的<IntoxicationIconKeywords:中毒>，每回合至多造成 [Arg2] 点。"
  },
  RelicConfig_70780_Name = {
    Text = "<WhiteQuality:异种喉舌>"
  },
  RelicConfig_70780_StoryDesc = {
    Text = "祂不是恶魔，但祂确实会传递人世之外的低语。"
  },
  RelicConfig_70781_BattleDesc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1]  护盾。"
  },
  RelicConfig_70781_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 [Arg1]  护盾。"
  },
  RelicConfig_70781_Name = {
    Text = "<OrangeQuality:守护之手+>"
  },
  RelicConfig_70781_StoryDesc = {
    Text = "祈福的手，坚定的拳。"
  },
  RelicConfig_70782_BattleDesc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_70782_Desc = {
    Text = "失去生命时获得 [Arg1]% 生命损失量的猩红熔炉。"
  },
  RelicConfig_70782_Name = {
    Text = "<OrangeQuality:锈蚀钢锯+>"
  },
  RelicConfig_70782_StoryDesc = {
    Text = "解剖医生一生都看不到美丽的女人，只有一麻袋骨头、因疾病发炎的神经、肌肉和组织。"
  },
  RelicConfig_70783_BattleDesc = {
    Text = "每回合前五次造成的伤害提高 [Arg1]%。"
  },
  RelicConfig_70783_Desc = {
    Text = "每回合前五次造成的伤害提高 [Arg1]%。"
  },
  RelicConfig_70783_Name = {
    Text = "<OrangeQuality:视力矫正器+>"
  },
  RelicConfig_70783_StoryDesc = {
    Text = "曾有人透过它，找到了真相。"
  },
  RelicConfig_70784_BattleDesc = {
    Text = "每当一张卡进入超维空间时，若这张卡与其他超维空间的卡牌归属者不同，则将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  RelicConfig_70784_Desc = {
    Text = "每当一张卡进入超维空间时，若这张卡与其他超维空间的卡牌归属者不同，则将 [Arg1] 张<DerivativeCardKeywords_4:「灵感」>置入手中。"
  },
  RelicConfig_70784_Name = {
    Text = "<WhiteQuality:阿方索之器>"
  },
  RelicConfig_70784_StoryDesc = {
    Text = "不同于无常的命运，群星自有运行法则。"
  },
  RelicConfig_70785_BattleDesc = {
    Text = "在一回合内打出 4 张归属于不同唤醒体的指令卡后，所有唤醒体获得 [Arg1]  狂气，3 回合冷却。"
  },
  RelicConfig_70785_Desc = {
    Text = "在一回合内打出 4 张归属于不同唤醒体的指令卡后，所有唤醒体获得 [Arg1]  狂气，3 回合冷却。"
  },
  RelicConfig_70785_Name = {
    Text = "<OrangeQuality:无名之神的面纱+>"
  },
  RelicConfig_70785_StoryDesc = {
    Text = "不可直视神。"
  },
  RelicConfig_70786_BattleDesc = {
    Text = "回合结束时，如果处于潮涌姿态，获得 [Arg1] <TentacleInjurieIconKeywords:触腕伤害>，3 回合冷却。"
  },
  RelicConfig_70786_Desc = {
    Text = "回合结束时，如果处于潮涌姿态，获得 [Arg1] <TentacleInjurieIconKeywords:触腕伤害>，3 回合冷却。"
  },
  RelicConfig_70786_Name = {
    Text = "<WhiteQuality:裂头蚴>"
  },
  RelicConfig_70786_StoryDesc = {
    Text = "只要我们的大脑仍是个谜，那么里面长满触腕也没什么好大惊小怪的。"
  },
  RelicConfig_70787_BattleDesc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。"
  },
  RelicConfig_70787_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。"
  },
  RelicConfig_70787_Name = {
    Text = "<OrangeQuality:哭泣烟斗+>"
  },
  RelicConfig_70787_StoryDesc = {
    Text = "这究竟是仇恨的产物，还是复仇的结果？"
  },
  RelicConfig_70788_BattleDesc = {
    Text = "使用银钥觉醒后所有唤醒体获得 [Arg1] 狂气和 [Arg2] 银钥能量。"
  },
  RelicConfig_70788_Desc = {
    Text = "使用银钥觉醒后所有唤醒体获得 [Arg1] 狂气和 [Arg2] 银钥能量。"
  },
  RelicConfig_70788_Name = {
    Text = "<WhiteQuality:桂叶袖扣>"
  },
  RelicConfig_70788_StoryDesc = {
    Text = "印刻了桂叶花纹的银质袖扣。\n它做工精致，闪闪发亮，曾经承载了两个孩子的友谊。"
  },
  RelicConfig_70789_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<IntoxicationIconKeywords:中毒>与造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70789_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。所有唤醒体造成的<IntoxicationIconKeywords:中毒>与造物造成的<IntoxicationIconKeywords:中毒>提高 [Arg2]%。"
  },
  RelicConfig_70789_Name = {
    Text = "<WhiteQuality:蒙尘缝纫机>"
  },
  RelicConfig_70789_StoryDesc = {
    Text = "一位慈祥的母亲，缝补心脏上的伤。"
  },
  RelicConfig_70790_BattleDesc = {
    Text = "湮灭使狂气最低的唤醒体获得 [Arg1] 狂气，3 回合冷却。"
  },
  RelicConfig_70790_Desc = {
    Text = "湮灭使狂气最低的唤醒体获得 [Arg1] 狂气，3 回合冷却。"
  },
  RelicConfig_70790_Name = {
    Text = "<OrangeQuality:时间之虫+>"
  },
  RelicConfig_70790_StoryDesc = {
    Text = "一块同时存在于钟表店与昆虫博物馆的怀表。\n洪积元年开始后，被纳入大学馆藏。"
  },
  RelicConfig_70791_BattleDesc = {
    Text = "战斗开始时，触腕上限+[Arg1]，获得 [Arg2] 条触腕。"
  },
  RelicConfig_70791_Desc = {
    Text = "战斗开始时，触腕上限+[Arg1]，获得 [Arg2] 条触腕。"
  },
  RelicConfig_70791_Name = {
    Text = "<OrangeQuality:海眷歌谣+>"
  },
  RelicConfig_70791_StoryDesc = {
    Text = "据说织纹螺等不可食用动物吸收了海洋大约80%的营养。"
  },
  RelicConfig_70792_BattleDesc = {
    Text = "回合结束时，如果处于潮涌姿态，获得 [Arg1] <TentacleInjurieIconKeywords:触腕伤害>，3 回合冷却。"
  },
  RelicConfig_70792_Desc = {
    Text = "回合结束时，如果处于潮涌姿态，获得 [Arg1] <TentacleInjurieIconKeywords:触腕伤害>，3 回合冷却。"
  },
  RelicConfig_70792_Name = {
    Text = "<OrangeQuality:裂头蚴+>"
  },
  RelicConfig_70792_StoryDesc = {
    Text = "只要我们的大脑仍是个谜，那么里面长满触腕也没什么好大惊小怪的。"
  },
  RelicConfig_70793_BattleDesc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70793_Desc = {
    Text = "每回合首次<DevouredIconKeywords:吞噬>时，其他唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_70793_Name = {
    Text = "<OrangeQuality:金色梦乡+>"
  },
  RelicConfig_70793_StoryDesc = {
    Text = "蜕变之日即是你的死期。"
  },
  RelicConfig_70794_BattleDesc = {
    Text = "湮灭获得 [Arg1] 护盾，3 回合冷却。"
  },
  RelicConfig_70794_Desc = {
    Text = "湮灭获得 [Arg1] 护盾，3 回合冷却。"
  },
  RelicConfig_70794_Name = {
    Text = "<OrangeQuality:超弦怀表+>"
  },
  RelicConfig_70794_StoryDesc = {
    Text = "「哎呀，怀表停了。」"
  },
  RelicConfig_70795_BattleDesc = {
    Text = "打出非衍生指令卡后，将算力消耗降低 2 的该卡牌 [Arg1]  张临时复制洗入抽牌堆，3 回合冷却。"
  },
  RelicConfig_70795_Desc = {
    Text = "打出非衍生指令卡后，将算力消耗降低 2 的该卡牌 [Arg1]  张临时复制洗入抽牌堆，3 回合冷却。"
  },
  RelicConfig_70795_Name = {
    Text = "<WhiteQuality:失声唱机>"
  },
  RelicConfig_70795_StoryDesc = {
    Text = "他的声音消失在了风中。"
  },
  RelicConfig_70796_BattleDesc = {
    Text = "释放「狂气爆发」后，使所有敌人受到 [Arg1] 点<FixedDamage:纯粹伤害>，并触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70796_Desc = {
    Text = "释放「狂气爆发」后，使所有敌人受到 1 次 [Arg2]% 我方最大生命值的<FixedDamage:纯粹伤害>，并触发 [Arg2]% <IntoxicationIconKeywords:中毒>。"
  },
  RelicConfig_70796_Name = {
    Text = "<OrangeQuality:镭射颌骨+>"
  },
  RelicConfig_70796_StoryDesc = {
    Text = "陈列在某个收藏家私人展厅内的遗骨。\n收藏家醉心于那美丽的荧光，日夜欣赏，最终枯死，最终成为了它的同类。"
  },
  RelicConfig_70797_BattleDesc = {
    Text = "最大算力提高 [Arg1] 。"
  },
  RelicConfig_70797_Desc = {
    Text = "最大算力提高 [Arg1] 。"
  },
  RelicConfig_70797_Name = {
    Text = "<WhiteQuality:活性注射器>"
  },
  RelicConfig_70797_StoryDesc = {
    Text = "抽搐也是活性的一种。"
  },
  RelicConfig_70798_BattleDesc = {
    Text = "使用怒涛姿态立即激发所有触腕攻击敌人 [Arg1] 次，3 回合冷却。"
  },
  RelicConfig_70798_Desc = {
    Text = "使用怒涛姿态立即激发所有触腕攻击敌人 [Arg1] 次，3 回合冷却。"
  },
  RelicConfig_70798_Name = {
    Text = "<OrangeQuality:螺湮的欢愉+>"
  },
  RelicConfig_70798_StoryDesc = {
    Text = "长眠之主，候汝入梦。"
  },
  RelicConfig_70799_BattleDesc = {
    Text = "防御获得 [Arg1] 临时<RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70799_Desc = {
    Text = "防御获得 [Arg1] 临时<RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70799_Name = {
    Text = "<OrangeQuality:故人的怀表+>"
  },
  RelicConfig_70799_StoryDesc = {
    Text = "肩负着怀念与感伤，向未知前进。"
  },
  RelicConfig_70800_BattleDesc = {
    Text = "防御获得 [Arg1] 临时<RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70800_Desc = {
    Text = "防御获得 [Arg1] 临时<RetaliateIconKeywords:反击>，每回合至多触发 3 次。"
  },
  RelicConfig_70800_Name = {
    Text = "<WhiteQuality:故人的怀表>"
  },
  RelicConfig_70800_StoryDesc = {
    Text = "肩负着怀念与感伤，向未知前进。"
  },
  RelicConfig_70986_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，从 2 个造物中选择 1 个获得，持续 5 个奇数回合。"
  },
  RelicConfig_70986_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，从 2 个造物中选择 1 个获得，持续 5 个奇数回合。"
  },
  RelicConfig_70986_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿η」>"
  },
  RelicConfig_70987_BattleDesc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，从 2 个造物中选择 1 个获得，持续 5 个奇数回合。"
  },
  RelicConfig_70987_Desc = {
    Text = "战斗开始时，算力上限+1，觉醒所有唤醒体。奇数回合开始时，从 2 个造物中选择 1 个获得，持续 5 个奇数回合。"
  },
  RelicConfig_70987_Name = {
    Text = "<OrangeQuality:时灵摆「祈愿ζ」>"
  },
  RelicConfig_71195_BattleDesc = {
    Text = "回合开始时环行·拉蒙娜获得 [Arg1] 狂气。每回合首次触发「回环」时，获得 [Arg2] 点银钥能量和 [Arg3] 层「负熵」。"
  },
  RelicConfig_71195_Desc = {
    Text = "回合开始时环行·拉蒙娜获得 [Arg1] 狂气。每回合首次触发「回环」时，获得 [Arg2] 点银钥能量和 [Arg3] 层「负熵」。"
  },
  RelicConfig_71195_Name = {
    Text = "<OrangeQuality:维度影像·环行·拉蒙娜>"
  },
  RelicConfig_71196_BattleDesc = {
    Text = "回合开始时萝坦获得 [Arg1] 狂气。每回合首次打出萝坦的「防御」后，将 [Arg2] 张附加消耗与虚无的「桀骜之刃」置入手中。"
  },
  RelicConfig_71196_Desc = {
    Text = "回合开始时萝坦获得 [Arg1] 狂气。每回合首次打出萝坦的「防御」后，将 [Arg2] 张附加消耗与虚无的「桀骜之刃」置入手中。"
  },
  RelicConfig_71196_Name = {
    Text = "<OrangeQuality:维度影像·萝坦>"
  },
  RelicConfig_71197_BattleDesc = {
    Text = "回合开始时拉蒙娜获得 [Arg1] 狂气。每第 [Arg2] 张打出拉蒙娜的指令卡时，该指令卡额外生效 1 次并获得 [Arg3] 点银钥能量。"
  },
  RelicConfig_71197_Desc = {
    Text = "回合开始时拉蒙娜获得 [Arg1] 狂气。每第 [Arg2] 张打出拉蒙娜的指令卡时，该指令卡额外生效 1 次并获得 [Arg3] 点银钥能量。"
  },
  RelicConfig_71197_Name = {
    Text = "<OrangeQuality:维度影像·拉蒙娜>"
  },
  RelicConfig_71230_BattleDesc = {
    Text = "回合开始时雷娅获得 [Arg1] 狂气。每当失去生命后获得 [Arg2] 点力量，每场战斗最多叠加 [Arg3] 次。叠加 [Arg3] 次后，「苦痛与欢愉」基础算力消耗降低 2，伤害次数提高 1。"
  },
  RelicConfig_71230_Desc = {
    Text = "回合开始时雷娅获得 [Arg1] 狂气。每当失去生命后获得 [Arg2] 点力量，每场战斗最多叠加 [Arg3] 次。叠加 [Arg3] 次后，「苦痛与欢愉」基础算力消耗降低 2，伤害次数提高 1。"
  },
  RelicConfig_71230_Name = {
    Text = "<OrangeQuality:维度影像·雷娅>"
  },
  RelicConfig_71231_BattleDesc = {
    Text = "回合开始时奥瑞塔获得 [Arg1] 狂气。「腺体分裂」伤害次数提高 [Arg2]，打出奥瑞塔的「防御」后将 1 张「腺体分裂」置入手中。"
  },
  RelicConfig_71231_Desc = {
    Text = "回合开始时奥瑞塔获得 [Arg1] 狂气。「腺体分裂」伤害次数提高 [Arg2]，打出奥瑞塔的「防御」后将 1 张「腺体分裂」置入手中。"
  },
  RelicConfig_71231_Name = {
    Text = "<OrangeQuality:维度影像·奥瑞塔>"
  },
  RelicConfig_71232_BattleDesc = {
    Text = "回合开始时汀克特获得 [Arg1] 狂气。汀克特的指令卡触发跃迁后将其返回手中并使其打出前算力消耗 -1，每回合最多生效 [Arg2] 次。"
  },
  RelicConfig_71232_Desc = {
    Text = "回合开始时汀克特获得 [Arg1] 狂气。汀克特的指令卡触发跃迁后将其返回手中并使其打出前算力消耗 -1，每回合最多生效 [Arg2] 次。"
  },
  RelicConfig_71232_Name = {
    Text = "<OrangeQuality:维度影像·汀克特>"
  },
  RelicConfig_71233_BattleDesc = {
    Text = "回合开始时诺缔拉获得 [Arg1] 狂气。释放诺谛拉的「狂气爆发」后获得等同于当前护盾 [Arg2]% 的反击和延迟护盾，每回合最多触发 1 次。"
  },
  RelicConfig_71233_Desc = {
    Text = "回合开始时诺缔拉获得 [Arg1] 狂气。释放诺缔拉的「狂气爆发」后获得等同于当前护盾 [Arg2]% 的反击和延迟护盾，每回合最多触发 1 次。"
  },
  RelicConfig_71233_Name = {
    Text = "<OrangeQuality:维度影像·诺缔拉>"
  },
  RelicConfig_71234_BattleDesc = {
    Text = "回合开始时熔毁·朵尔获得 [Arg1] 狂气。熔毁朵尔释放狂气爆发后，每消耗 [Arg2] 点狂气其他唤醒体就获得 1 点狂气。"
  },
  RelicConfig_71234_Desc = {
    Text = "回合开始时熔毁·朵尔获得 [Arg1] 狂气。熔毁·朵尔释放狂气爆发后，每消耗 [Arg2] 点狂气其他唤醒体就获得 1 点狂气。"
  },
  RelicConfig_71234_Name = {
    Text = "<OrangeQuality:维度影像·熔毁·朵尔>"
  },
  RelicConfig_71235_BattleDesc = {
    Text = "回合开始时希洛获得 [Arg1] 狂气。每当有 1 张牌被弃掉，都会使希洛获得 [Arg2] 点狂气。"
  },
  RelicConfig_71235_Desc = {
    Text = "回合开始时希洛获得 [Arg1] 狂气。每当有 1 张牌被弃掉，都会使希洛获得 [Arg2] 点狂气。"
  },
  RelicConfig_71235_Name = {
    Text = "<OrangeQuality:维度影像·希洛>"
  },
  RelicConfig_71236_BattleDesc = {
    Text = "回合开始时达芙黛尔获得 [Arg1] 狂气和 1 张「灵感」。「异质潮汐」获得的力量提高 [Arg2]%，每次打出在本场探索中额外永久提高 [Arg3]%，最大提高 [Arg4]%。"
  },
  RelicConfig_71236_Desc = {
    Text = "回合开始时达芙黛尔获得 [Arg1] 狂气和 1 张「灵感」。「异质潮汐」获得的力量提高 [Arg2]%，每次打出在本场探索中额外永久提高 [Arg3]%，最大提高 [Arg4]%。"
  },
  RelicConfig_71236_Name = {
    Text = "<OrangeQuality:维度影像·达芙黛尔>"
  },
  RelicConfig_71237_BattleDesc = {
    Text = "回合开始时旺达获得 [Arg1] 狂气并获得 [Arg2] 层「梦引」。若当前为超维回合额外将 1 张临时的「脊刺锁链」和「迷途之守」置入手中，并使旺达下一张指令卡生效 2 次。"
  },
  RelicConfig_71237_Desc = {
    Text = "回合开始时旺达获得 [Arg1] 狂气并获得 [Arg2] 层「梦引」。若当前为超维回合额外将 1 张临时的「脊刺锁链」和「迷途之守」置入手中，并使旺达下一张指令卡生效 2 次。"
  },
  RelicConfig_71237_Name = {
    Text = "<OrangeQuality:维度影像·旺达>"
  },
  RelicConfig_71238_BattleDesc = {
    Text = "回合开始时阿格里帕获得 [Arg1] 狂气。「不耐的施舍」还会使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_71238_Desc = {
    Text = "回合开始时阿格里帕获得 [Arg1] 狂气。「不耐的施舍」还会使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_71238_Name = {
    Text = "<OrangeQuality:维度影像·阿格里帕>"
  },
  RelicConfig_71239_BattleDesc = {
    Text = "回合开始时「24」获得 [Arg1] 狂气。回合开始时「24」若处于「抑郁人格」则额外获得 [Arg2] 狂气，若处于「躁狂人格」则使「24」临时暴击率和临时暴击伤害提高 [Arg2]%。"
  },
  RelicConfig_71239_Desc = {
    Text = "回合开始时「24」获得 [Arg1] 狂气。回合开始时「24」若处于「抑郁人格」则额外获得 [Arg2] 狂气，若处于「躁狂人格」则使「24」临时暴击率和临时暴击伤害提高 [Arg2]%。"
  },
  RelicConfig_71239_Name = {
    Text = "<OrangeQuality:维度影像·「24」>"
  },
  RelicConfig_71240_BattleDesc = {
    Text = "回合开始时莉兹获得 [Arg1] 狂气。「告死之舞」弃掉的卡牌额外生效 1 次，3 回合冷却。"
  },
  RelicConfig_71240_Desc = {
    Text = "回合开始时莉兹获得 [Arg1] 狂气。「告死之舞」弃掉的卡牌额外生效 1 次，3 回合冷却。"
  },
  RelicConfig_71240_Name = {
    Text = "<OrangeQuality:维度影像·莉兹>"
  },
  RelicConfig_71241_BattleDesc = {
    Text = "回合开始时血链希洛获得 [Arg1] 狂气。血链·希洛主动伤害附加 [Arg2]% 出血，击杀敌人后对其他敌人造成等同于过量伤害的出血。"
  },
  RelicConfig_71241_Desc = {
    Text = "回合开始时血链·希洛获得 [Arg1] 狂气。血链·希洛主动伤害附加 [Arg2]% 出血，击杀敌人后对其他敌人造成等同于过量伤害的出血。"
  },
  RelicConfig_71241_Name = {
    Text = "<OrangeQuality:维度影像·血链·希洛>"
  },
  RelicConfig_71242_BattleDesc = {
    Text = "回合开始时希莱斯特获得 [Arg1] 狂气。回合结束前手牌中每有 1 张希莱斯特的指令卡就使 1 条触腕攻击敌人并回复 [Heal:Arg2] 点生命。"
  },
  RelicConfig_71242_Desc = {
    Text = "回合开始时希莱斯特获得 [Arg1] 狂气。回合结束前手牌中每有 1 张希莱斯特的指令卡就使 1 条触腕攻击敌人并回复 [Heal:Arg2] 点生命。"
  },
  RelicConfig_71242_Name = {
    Text = "<OrangeQuality:维度影像·希莱斯特>"
  },
  RelicConfig_71243_BattleDesc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_71243_Desc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_71243_Name = {
    Text = "<OrangeQuality:维度影像·卡茜亚>"
  },
  RelicConfig_71244_BattleDesc = {
    Text = "回合开始时索蕾尔获得 [Arg1] 狂气。索蕾尔每造成 1 次伤害胚胎融合 +[Arg2]，每回合最多生效 [Arg3] 次。生效 10 次后使索蕾尔本场战斗最终伤害 + [Arg4]%。"
  },
  RelicConfig_71244_Desc = {
    Text = "回合开始时索蕾尔获得 [Arg1] 狂气。索蕾尔每造成 1 次伤害胚胎融合 +[Arg2]，每回合最多生效 [Arg3] 次。生效 10 次后使索蕾尔本场战斗最终伤害 + [Arg4]%。"
  },
  RelicConfig_71244_Name = {
    Text = "<OrangeQuality:维度影像·索蕾尔>"
  },
  RelicConfig_71245_BattleDesc = {
    Text = "回合开始时奥吉尔获得 [Arg1] 狂气。每回合首次打出奥吉尔的「穿刺之枪」或「打击」后，使奥吉尔本回合内造成的护盾和力量提高 [Arg2]%。"
  },
  RelicConfig_71245_Desc = {
    Text = "回合开始时奥吉尔获得 [Arg1] 狂气。每回合首次打出奥吉尔的「穿刺之枪」或「打击」后，使奥吉尔本回合内造成的护盾和力量提高 [Arg2]%。"
  },
  RelicConfig_71245_Name = {
    Text = "<OrangeQuality:维度影像·奥吉尔>"
  },
  RelicConfig_71246_BattleDesc = {
    Text = "回合开始时艾尔瓦获得 [Arg1] 狂气。艾尔瓦在 1 回合内打出第 [Arg2] 张「防御」时，将一张消耗的「心眼利刃」置入手中；打出第 [Arg3] 张「打击」时，将 1 张消耗的「临战体势」置入手中。"
  },
  RelicConfig_71246_Desc = {
    Text = "回合开始时艾尔瓦获得 [Arg1] 狂气。艾尔瓦在 1 回合内打出第 [Arg2] 张「防御」时，将一张消耗的「心眼利刃」置入手中；打出第 [Arg3] 张「打击」时，将 1 张消耗的「临战体势」置入手中。"
  },
  RelicConfig_71246_Name = {
    Text = "<OrangeQuality:维度影像·艾尔瓦>"
  },
  RelicConfig_71247_BattleDesc = {
    Text = "回合开始时詹金获得 [Arg1] 狂气，最终伤害+ [Arg2]%。「布朗出动」的基础伤害和造成的伤害成长提高 [Arg3]%。"
  },
  RelicConfig_71247_Desc = {
    Text = "回合开始时詹金获得 [Arg1] 狂气，最终伤害+ [Arg2]%。「布朗出动」的基础伤害和造成的伤害成长提高 [Arg3]%。"
  },
  RelicConfig_71247_Name = {
    Text = "<OrangeQuality:维度影像·詹金>"
  },
  RelicConfig_71248_BattleDesc = {
    Text = "回合开始时朵尔获得 [Arg1] 狂气。战斗开始后使朵尔的「等价交换」算力消耗变为 0，打出后下回合额外抽 [Arg2] 张牌。"
  },
  RelicConfig_71248_Desc = {
    Text = "回合开始时朵尔获得 [Arg1] 狂气。战斗开始后使朵尔的「等价交换」算力消耗变为 0，打出后下回合额外抽 [Arg2] 张牌。"
  },
  RelicConfig_71248_Name = {
    Text = "<OrangeQuality:维度影像·朵尔>"
  },
  RelicConfig_71249_BattleDesc = {
    Text = "回合开始时莱克获得 [Arg1] 狂气。每回合首次骰子必定投出最大值。"
  },
  RelicConfig_71249_Desc = {
    Text = "回合开始时莱克获得 [Arg1] 狂气。每回合首次骰子必定投出最大值。"
  },
  RelicConfig_71249_Name = {
    Text = "<OrangeQuality:维度影像·莱克>"
  },
  RelicConfig_71250_BattleDesc = {
    Text = "回合开始时弥利亚姆获得 [Arg1] 狂气，并将 1 张「圣礼」置入手中。"
  },
  RelicConfig_71250_Desc = {
    Text = "回合开始时弥利亚姆获得 [Arg1] 狂气，并将 1 张「圣礼」置入手中。"
  },
  RelicConfig_71250_Name = {
    Text = "<OrangeQuality:维度影像·弥利亚姆>"
  },
  RelicConfig_71251_BattleDesc = {
    Text = "回合开始时温柯尔获得 [Arg1] 狂气。每当其他唤醒体释放狂气爆发就会使温柯尔获得 [Arg2] 点狂气，并使手中的「精神重建」算力消耗降低 [Arg3]。"
  },
  RelicConfig_71251_Desc = {
    Text = "回合开始时温柯尔获得 [Arg1] 狂气。每当其他唤醒体释放狂气爆发就会使温柯尔获得 [Arg2] 点狂气，并使手中的「精神重建」算力消耗降低 [Arg3]。"
  },
  RelicConfig_71251_Name = {
    Text = "<OrangeQuality:维度影像·温柯尔>"
  },
  RelicConfig_71252_BattleDesc = {
    Text = "回合开始时图鲁获得 [Arg1] 狂气。图鲁的基础狂气降低 [Arg2] 点，释放狂气爆发后立刻生成 [Arg3] 条临时触腕。"
  },
  RelicConfig_71252_Desc = {
    Text = "回合开始时图鲁获得 [Arg1] 狂气。图鲁的基础狂气降低 [Arg2] 点，释放狂气爆发后立刻生成 [Arg3] 条临时触腕。"
  },
  RelicConfig_71252_Name = {
    Text = "<OrangeQuality:维度影像·图鲁>"
  },
  RelicConfig_71253_BattleDesc = {
    Text = "回合开始时菲茵特获得 [Arg1] 狂气。菲茵特造成的护盾、反击、生命回复提高 [Arg2]%，每当触发死亡抵抗使这个效果在本场探索中提高 [Arg3]%，最多生效 [Arg4] 次。"
  },
  RelicConfig_71253_Desc = {
    Text = "回合开始时菲茵特获得 [Arg1] 狂气。菲茵特造成的护盾、反击、生命回复提高 [Arg2]%，每当触发死亡抵抗使这个效果在本场探索中提高 [Arg3]%，最多生效 [Arg4] 次。"
  },
  RelicConfig_71253_Name = {
    Text = "<OrangeQuality:维度影像·菲茵特>"
  },
  RelicConfig_71254_BattleDesc = {
    Text = "回合开始时塔薇获得 [Arg1] 狂气。若一回合内打出了 [Arg2] 张塔薇的指令卡，将 1 张<DerivativeCardKeywords_67:「银钥曦光」>置入手中，冷却 [Arg3] 回合。"
  },
  RelicConfig_71254_Desc = {
    Text = "回合开始时塔薇获得 [Arg1] 狂气。若一回合内打出了 [Arg2] 张塔薇的指令卡，将 1 张<DerivativeCardKeywords_67:「银钥曦光」>置入手中，冷却 [Arg3] 回合。"
  },
  RelicConfig_71254_Name = {
    Text = "<OrangeQuality:维度影像·塔薇>"
  },
  RelicConfig_71255_BattleDesc = {
    Text = "回合开始时哈姆林获得 [Arg1] 狂气。「灵魂序曲」基础算力消耗降低 [Arg2]，基础伤害次数提高 [Arg3]。"
  },
  RelicConfig_71255_Desc = {
    Text = "回合开始时哈姆林获得 [Arg1] 狂气。「灵魂序曲」基础算力消耗降低 [Arg2]，基础伤害次数提高 [Arg3]。"
  },
  RelicConfig_71255_Name = {
    Text = "<OrangeQuality:维度影像·哈姆林>"
  },
  RelicConfig_71256_BattleDesc = {
    Text = "回合开始时奥尔拉获得 [Arg1] 狂气。战斗开始时获得所有情绪的隐喻各 [Arg2] 层，「隐喻」效果提高 50%。"
  },
  RelicConfig_71256_Desc = {
    Text = "回合开始时奥尔拉获得 [Arg1] 狂气。战斗开始时获得所有情绪的隐喻各 [Arg2] 层，「隐喻」效果提高 50%。"
  },
  RelicConfig_71256_Name = {
    Text = "<OrangeQuality:维度影像·奥尔拉>"
  },
  RelicConfig_71257_BattleDesc = {
    Text = "回合开始时墨菲获得 [Arg1] 狂气。墨菲的「打击」和「防御」能够将 [Arg2]% 的「献祭」转化为临时触腕伤害，但每回合最多生效 1 次。"
  },
  RelicConfig_71257_Desc = {
    Text = "回合开始时墨菲获得 [Arg1] 狂气。墨菲的「打击」和「防御」能够将 [Arg2]% 的「献祭」转化为临时触腕伤害，但每回合最多生效 1 次。"
  },
  RelicConfig_71257_Name = {
    Text = "<OrangeQuality:维度影像·墨菲>"
  },
  RelicConfig_71258_BattleDesc = {
    Text = "回合开始时尤乌哈希获得 [Arg1] 狂气。尤乌哈希的基础狂气降低 [Arg2] 点，每次释放狂气爆发额外降低 5 点，每回合能够释放 [Arg3] 次狂气爆发。"
  },
  RelicConfig_71258_Desc = {
    Text = "回合开始时尤乌哈希获得 [Arg1] 狂气。尤乌哈希的基础狂气降低 [Arg2] 点，每次释放狂气爆发额外降低 5 点，每回合能够释放 [Arg3] 次狂气爆发。"
  },
  RelicConfig_71258_Name = {
    Text = "<OrangeQuality:维度影像·尤乌哈希>"
  },
  RelicConfig_71259_BattleDesc = {
    Text = "回合开始时艾继丝获得 [Arg1] 狂气。艾继丝对具有易伤的敌人造成伤害时还会偷取其 [Arg2] 点临时力量，每回合最多生效 [Arg3] 次。"
  },
  RelicConfig_71259_Desc = {
    Text = "回合开始时艾继丝获得 [Arg1] 狂气。艾继丝对具有易伤的敌人造成伤害时还会偷取其 [Arg2] 点临时力量，每回合最多生效 [Arg3] 次。"
  },
  RelicConfig_71259_Name = {
    Text = "<OrangeQuality:维度影像·艾继丝>"
  },
  RelicConfig_71260_BattleDesc = {
    Text = "回合开始时泰旖丝获得 [Arg1] 狂气。泰旖丝在 1 回合内打出 [Arg2] 张指令卡后，获得一张「圣洁之子」和 [Arg3] 点临时力量，[Arg4] 回合冷却。"
  },
  RelicConfig_71260_Desc = {
    Text = "回合开始时泰旖丝获得 [Arg1] 狂气。泰旖丝在 1 回合内打出 [Arg2] 张指令卡后，获得一张「圣洁之子」和 [Arg3] 点临时力量，[Arg4] 回合冷却。"
  },
  RelicConfig_71260_Name = {
    Text = "<OrangeQuality:维度影像·泰旖丝>"
  },
  RelicConfig_71261_BattleDesc = {
    Text = "回合开始时法洛思获得 [Arg1] 狂气。每造成 2 次触腕伤害，就使法洛思本场战斗造成的中毒和护盾提高 [Arg2]%，最大为 50%。"
  },
  RelicConfig_71261_Desc = {
    Text = "回合开始时法洛思获得 [Arg1] 狂气。每造成 2 次触腕伤害，就使法洛思本场战斗造成的中毒和护盾提高 [Arg2]%，最大为 50%。"
  },
  RelicConfig_71261_Name = {
    Text = "<OrangeQuality:维度影像·法洛思>"
  },
  RelicConfig_71262_BattleDesc = {
    Text = "回合开始时潘狄娅获得 [Arg1] 狂气。潘狄娅释放狂气爆发后，获得等同于 [Arg2]% 临时反击的永久反击。"
  },
  RelicConfig_71262_Desc = {
    Text = "回合开始时潘狄娅获得 [Arg1] 狂气。潘狄娅释放狂气爆发后，获得等同于 [Arg2]% 临时反击的永久反击。"
  },
  RelicConfig_71262_Name = {
    Text = "<OrangeQuality:维度影像·潘狄娅>"
  },
  RelicConfig_71263_BattleDesc = {
    Text = "回合开始时莉莉获得 [Arg1] 狂气。莉莉忍耐上限提高 100%，释放「淤泥上的不灭之花」或「报偿打击」时，回复「忍耐」层数 8% 的生命。"
  },
  RelicConfig_71263_Desc = {
    Text = "回合开始时莉莉获得 [Arg1] 狂气。莉莉忍耐上限提高 100%，释放「淤泥上的不灭之花」或「报偿打击」时，回复「忍耐」层数 8% 的生命。"
  },
  RelicConfig_71263_Name = {
    Text = "<OrangeQuality:维度影像·莉莉>"
  },
  RelicConfig_71264_BattleDesc = {
    Text = "回合开始时珈伦获得 [Arg1] 狂气。打出「静默守望」会返还双倍消耗的算力，冷却 [Arg2] 回合。"
  },
  RelicConfig_71264_Desc = {
    Text = "回合开始时珈伦获得 [Arg1] 狂气。打出「静默守望」会返还双倍消耗的算力，冷却 [Arg2] 回合。"
  },
  RelicConfig_71264_Name = {
    Text = "<OrangeQuality:维度影像·珈伦>"
  },
  RelicConfig_71265_BattleDesc = {
    Text = "回合开始时萨尔瓦多获得 [Arg1] 狂气。每次积攒猩红熔炉时还会获得积攒量 [Arg2]% 的力量。萨尔瓦多的「打击」与「应消之苦」额外享受 [Arg3] 倍力量加成。"
  },
  RelicConfig_71265_Desc = {
    Text = "回合开始时萨尔瓦多获得 [Arg1] 狂气。每次积攒猩红熔炉时还会获得积攒量 [Arg2]% 的力量。萨尔瓦多的「打击」与「应消之苦」额外享受 [Arg3] 倍力量加成。"
  },
  RelicConfig_71265_Name = {
    Text = "<OrangeQuality:维度影像·萨尔瓦多>"
  },
  RelicConfig_71266_BattleDesc = {
    Text = "回合开始时凯刻斯获得 [Arg1] 狂气。凯刻斯获得护盾时回复 [Arg2]% 护盾量的生命。"
  },
  RelicConfig_71266_Desc = {
    Text = "回合开始时凯刻斯获得 [Arg1] 狂气。凯刻斯获得护盾时回复 [Arg2]% 护盾量的生命。"
  },
  RelicConfig_71266_Name = {
    Text = "<OrangeQuality:维度影像·凯刻斯>"
  },
  RelicConfig_71267_BattleDesc = {
    Text = "回合开始时宁菲亚获得 [Arg1] 狂气。打出宁菲亚的 「打击」后使「宁菲亚」本场战斗造成的中毒提高 [Arg2]%，打出宁菲亚的 「防御」后触发所有敌人 [Arg3]% 中毒。每回合最多各生效 1 次。"
  },
  RelicConfig_71267_Desc = {
    Text = "回合开始时宁菲亚获得 [Arg1] 狂气。打出宁菲亚的 「打击」后使「宁菲亚」本场战斗造成的中毒提高 [Arg2]%，打出宁菲亚的 「防御」后触发所有敌人 [Arg3]% 中毒。每回合最多各生效 1 次。"
  },
  RelicConfig_71267_Name = {
    Text = "<OrangeQuality:维度影像·宁菲亚>"
  },
  RelicConfig_71268_BattleDesc = {
    Text = "回合开始时艾瑞卡获得 [Arg1] 狂气。艾瑞卡在 1 回合内打出 [Arg2] 张指令卡后，获得 2 点算力并使本场战斗「电磁爆破」享受的力量和戒备加成提高 1 倍。"
  },
  RelicConfig_71268_Desc = {
    Text = "回合开始时艾瑞卡获得 [Arg1] 狂气。艾瑞卡在 1 回合内打出 [Arg2] 张指令卡后，获得 2 点算力并使本场战斗「电磁爆破」享受的力量和戒备加成提高 1 倍。"
  },
  RelicConfig_71268_Name = {
    Text = "<OrangeQuality:维度影像·艾瑞卡>"
  },
  RelicConfig_71269_BattleDesc = {
    Text = "回合开始时戈利亚获得 [Arg1] 狂气。若戈利亚 1 回合内造成了 [Arg2] 次伤害，戈利亚造成的伤害本场战斗中额外享受 1 倍力量加成，3 回合冷却。"
  },
  RelicConfig_71269_Desc = {
    Text = "回合开始时戈利亚获得 [Arg1] 狂气。若戈利亚 1 回合内造成了 [Arg2] 次伤害，戈利亚造成的伤害本场战斗中额外享受 1 倍力量加成，3 回合冷却。"
  },
  RelicConfig_71269_Name = {
    Text = "<OrangeQuality:维度影像·戈利亚>"
  },
  RelicConfig_71270_BattleDesc = {
    Text = "回合开始时珊获得 [Arg1] 狂气。战斗开始时对珊的所有指令卡赋予保留、预备 1、获得 [Arg2] 点护盾。"
  },
  RelicConfig_71270_Desc = {
    Text = "回合开始时珊获得 [Arg1] 狂气。战斗开始时对珊的所有指令卡赋予保留、预备 1、获得 [Arg2] 点护盾。"
  },
  RelicConfig_71270_Name = {
    Text = "<OrangeQuality:维度影像·珊>"
  },
  RelicConfig_71662_BattleDesc = {
    Text = "偶数回合开始时，将 1 张<DerivativeCardKeywords_105:「无尽银芯宝库」>置入手中。"
  },
  RelicConfig_71662_Desc = {
    Text = "偶数回合开始时，将 1 张<DerivativeCardKeywords_105:「无尽银芯宝库」>置入手中。"
  },
  RelicConfig_71662_Name = {
    Text = "<OrangeQuality:猫的宝藏>"
  },
  RelicConfig_72226_BattleDesc = {
    Text = "手牌上限+1。回合开始时若当前未进行研究，选择一项未进行过的研究，完成研究后获得熔毁·朵尔的对应研究成果。完成 3 个研究时，将「虚无终结」置入手中，该造物失效。"
  },
  RelicConfig_72226_Desc = {
    Text = "手牌上限+1。回合开始时若当前未进行研究，选择一项未进行过的研究，完成研究后获得熔毁·朵尔的对应研究成果。完成 3 个研究时，将「虚无终结」置入手中，该造物失效。"
  },
  RelicConfig_72226_Name = {
    Text = "终末科研手稿"
  },
  RelicConfig_74832_BattleDesc = {
    Text = "手牌上限+1。 回合开始时获得一张自定义的「禁忌的交易」，打出「禁忌的交易」后下回合可再次触发。 持有「禁忌的交易」时打出不同类型的「指令卡」会升级其中的对应效果。"
  },
  RelicConfig_74832_Desc = {
    Text = "手牌上限+1。 回合开始时获得一张自定义的「禁忌的交易」，打出「禁忌的交易」后下回合可再次触发。 持有「禁忌的交易」时打出不同类型的「指令卡」会升级其中的对应效果。"
  },
  RelicConfig_74832_Name = {
    Text = "千面邀请函"
  },
  RelicConfig_74832_StoryDesc = {
    Text = "信函上文字不断变化，始终化为无法拒绝的渴求。"
  },
  RelicConfig_78664_BattleDesc = {
    Text = "在单回合内打出 4 张归属于不同唤醒体的指令卡后，使所有唤醒体本回合造成的最终伤害提高 [Arg1]%，并失去 [Arg2] 点狂气，每回合最多生效 1 次。"
  },
  RelicConfig_78664_Desc = {
    Text = "在单回合内打出 4 张归属于不同唤醒体的指令卡后，使所有唤醒体本回合造成的最终伤害提高 [Arg1]%，并失去 [Arg2] 点狂气，每回合最多生效 1 次。"
  },
  RelicConfig_78664_Name = {
    Text = "<RedQuality:古怪钩爪>"
  },
  RelicConfig_78664_StoryDesc = {
    Text = "难以辨识的物种。"
  },
  RelicConfig_78665_BattleDesc = {
    Text = "回合开始时少抽 [Arg1] 张牌 。每打出 1 张实际算力消耗大于等于 [Arg2] 的牌获得 1 点算力，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_78665_Desc = {
    Text = "回合开始时少抽 [Arg1] 张牌 。每打出 1 张实际算力消耗大于等于 [Arg2] 的牌获得 1 点算力，每回合最多触发 [Arg3] 次。"
  },
  RelicConfig_78665_Name = {
    Text = "<RedQuality:哀嚎摇铃>"
  },
  RelicConfig_78665_StoryDesc = {
    Text = "叮铃，叮铃，孩子在哭闹；\n叮铃，叮铃，孩子在尖叫。\n叮铃，叮铃，孩子在哀嚎；\n叮铃，叮铃，它饿了，你知道。"
  },
  RelicConfig_78666_BattleDesc = {
    Text = "回合开始时获得 [Arg1] 点反击。在一回合内释放 [Arg2] 次狂气爆发后，移除自身 [Arg3]% 永久反击，获得 [Arg4]% 移除量的临时反击，[Arg5] 回合冷却。"
  },
  RelicConfig_78666_Desc = {
    Text = "回合开始时获得 [Arg1] 点反击。在一回合内释放 [Arg2] 次狂气爆发后，移除自身 [Arg3]% 永久反击，获得 [Arg4]% 移除量的临时反击，[Arg5] 回合冷却。"
  },
  RelicConfig_78666_Name = {
    Text = "<RedQuality:行道之骸>"
  },
  RelicConfig_78666_StoryDesc = {
    Text = "神圣的一部分。\n纵然与躯干分离，其足迹也已遍布四海。"
  },
  RelicConfig_78667_BattleDesc = {
    Text = "抽牌阶段后额外抽 [Arg1] 张牌，并选择 [Arg2] 张手牌弃掉。"
  },
  RelicConfig_78667_Desc = {
    Text = "抽牌阶段后额外抽 [Arg1] 张牌，并选择 [Arg2] 张手牌弃掉。"
  },
  RelicConfig_78667_Name = {
    Text = "<RedQuality:诡术礼帽>"
  },
  RelicConfig_78667_StoryDesc = {
    Text = "欢迎来到卡茜亚小姐的仙境马戏团！小心些，不要随便触碰魔术道具哦。要是一不小心被咬伤，那可就糟糕了。\n毕竟，它上一次尝到血的滋味，造成的后果可是很恐怖的。\n\n礼帽眨了眨眼睛，仿佛随时会破茧而出。"
  },
  RelicConfig_78668_BattleDesc = {
    Text = "使用银钥觉醒后，选择对应唤醒体的 [Arg1] 张非衍生指令卡将其消耗，并把 [Arg2] 张附加消耗的原始复制分别置入抽牌堆、手牌堆和弃牌堆。"
  },
  RelicConfig_78668_Desc = {
    Text = "使用银钥觉醒后，选择对应唤醒体的 [Arg1] 张非衍生指令卡将其消耗，并把 [Arg2] 张附加消耗的原始复制分别置入抽牌堆、手牌堆和弃牌堆。"
  },
  RelicConfig_78668_Name = {
    Text = "<RedQuality:翠玉拓印>"
  },
  RelicConfig_78668_StoryDesc = {
    Text = "此拓印千年不朽。"
  },
  RelicConfig_78669_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] 点力量。回合开始每有 [Arg2] 点永久力量获得 [Arg3] 点临时力量，最多获得 [Arg4] 点临时力量，并在回合结束时失去由该造物获得临时力量一半的护盾。"
  },
  RelicConfig_78669_Desc = {
    Text = "战斗开始时获得 [Arg1] 点力量。回合开始每有 [Arg2] 点永久力量获得 [Arg3] 点临时力量，最多获得 [Arg4] 点临时力量，并在回合结束时失去由该造物获得临时力量一半的护盾。"
  },
  RelicConfig_78669_Name = {
    Text = "<RedQuality:厄运仪式鸟>"
  },
  RelicConfig_78669_StoryDesc = {
    Text = "干瘪的尸体发出了鸣叫声。"
  },
  RelicConfig_78670_BattleDesc = {
    Text = "所有唤醒体的基础伤害提高 [Arg1]%，每次重置牌库额外提高 [Arg2]%，但将 1 张「蹒跚」置入手中，提高值最多为 [Arg3]%。"
  },
  RelicConfig_78670_Desc = {
    Text = "所有唤醒体的基础伤害提高 [Arg1]%，每次重置牌库额外提高 [Arg2]%，但将 1 张「蹒跚」置入手中，提高值最多为 [Arg3]%。"
  },
  RelicConfig_78670_Name = {
    Text = "<RedQuality:黑烛>"
  },
  RelicConfig_78670_StoryDesc = {
    Text = "燃烧清醒，堕入虚妄。"
  },
  RelicConfig_78671_BattleDesc = {
    Text = "回合开始时胚胎融合+ [Arg1]，你的「胚胎」会在回合结束时被弃掉。"
  },
  RelicConfig_78671_Desc = {
    Text = "回合开始时胚胎融合+ [Arg1]，你的「胚胎」会在回合结束时被弃掉。"
  },
  RelicConfig_78671_Name = {
    Text = "<RedQuality:蠕动的脐带>"
  },
  RelicConfig_78671_StoryDesc = {
    Text = "缠绕脖颈。"
  },
  RelicConfig_78672_BattleDesc = {
    Text = "回合开始时，受到 [Arg2] 层中毒，超维空间每有 1 个空位获得 [Arg1] 点力量。"
  },
  RelicConfig_78672_Desc = {
    Text = "回合开始时，受到 [Arg2] 层中毒，超维空间每有 1 个空位获得 [Arg1] 点力量。"
  },
  RelicConfig_78672_Name = {
    Text = "<RedQuality:虫群意识>"
  },
  RelicConfig_78672_StoryDesc = {
    Text = "缠绕、共生、集群；恐惧、未知、控制。"
  },
  RelicConfig_78673_BattleDesc = {
    Text = "银钥觉醒后额外消耗 [Arg1] 点银钥能量，使获得的灵知觉醒卡算力消耗变为 0，打出后使对应唤醒体额外获得 [Arg2] 点狂气。"
  },
  RelicConfig_78673_Desc = {
    Text = "银钥觉醒后额外消耗 [Arg1] 点银钥能量，使获得的灵知觉醒卡算力消耗变为 0，打出后使对应唤醒体额外获得 [Arg2] 点狂气。"
  },
  RelicConfig_78673_Name = {
    Text = "<RedQuality:意识铭刻>"
  },
  RelicConfig_78673_StoryDesc = {
    Text = "古老的部落坚信，在死者的头颅上篆刻特殊符号，能够将他的灵魂留下，获得永远的陪伴。"
  },
  RelicConfig_78674_BattleDesc = {
    Text = "战斗开始时对所有敌人造成 [Arg1] 点中毒。回合开始时移除敌人 [Arg2]% 的中毒，对其施加 [Arg3]% 移除量的出血。"
  },
  RelicConfig_78674_Desc = {
    Text = "战斗开始时对所有敌人造成 [Arg1] 点中毒。回合开始时移除敌人 [Arg2]% 的中毒，对其施加 [Arg3]% 移除量的出血。"
  },
  RelicConfig_78674_Name = {
    Text = "<RedQuality:救济之肢>"
  },
  RelicConfig_78674_StoryDesc = {
    Text = "神圣的一部分。\n纵然与躯干分离，仍能感受到其上的温暖。"
  },
  RelicConfig_78675_BattleDesc = {
    Text = "回合开始时若有超过 [Arg1] 条的永久触腕，失去 [Arg2] 条触腕获得 [Arg3] 条临时触腕，否则获得 [Arg4] 条永久触腕。"
  },
  RelicConfig_78675_Desc = {
    Text = "回合开始时若有超过 [Arg1] 条的永久触腕，失去 [Arg2] 条触腕获得 [Arg3] 条临时触腕，否则获得 [Arg4] 条永久触腕。"
  },
  RelicConfig_78675_Name = {
    Text = "<RedQuality:苦痛圣腕>"
  },
  RelicConfig_78675_StoryDesc = {
    Text = "享受苦痛。"
  },
  RelicConfig_79408_BattleDesc = {
    Text = "手牌上限+ 2，抽牌数 +2。「清明之忆」起始为 5 层，打出带有标记的卡牌会使「清明之忆」发生变化。「清明之忆」低于 5 时每低 1 点最终伤害 +10%，护盾和生命回复降低 5%；「清明之忆」高于 5 时每高 1 点护盾和生命回复提高 5%，最终伤害 -10%。"
  },
  RelicConfig_79408_Desc = {
    Text = "手牌上限+ 2，抽牌数 +2。「清明之忆」起始为 5 层，打出带有标记的卡牌会使「清明之忆」发生变化。「清明之忆」低于 5 时每低 1 点最终伤害 +10%，护盾和生命回复降低 5%；「清明之忆」高于 5 时每高 1 点护盾和生命回复提高 5%，最终伤害 -10%。"
  },
  RelicConfig_79408_Name = {
    Text = "「记忆」与「梦」"
  },
  RelicConfig_79408_StoryDesc = {
    Text = "「来，听我说。」\n「让我将你的记忆与梦。」\n「制作成无比美味的甜点。」"
  },
  RelicConfig_80340_BattleDesc = {
    Text = "回合开始时克莱门汀获得 [Arg1] 狂气。克莱门汀所有指令卡伤害、护盾、生命回复、获得狂气、获得银钥能量的效果次数提高 1。"
  },
  RelicConfig_80340_Desc = {
    Text = "回合开始时克莱门汀获得 [Arg1] 狂气。克莱门汀所有指令卡伤害、护盾、生命回复、获得狂气、获得银钥能量的效果次数提高 1。"
  },
  RelicConfig_80340_Name = {
    Text = "<OrangeQuality:维度影像·克莱门汀>"
  },
  RelicConfig_83509_BattleDesc = {
    Text = "探索开始时造物上限+1，「深海」界域唤醒体获得其「维度影像」。队伍中每有 1 名「深海」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83509_Desc = {
    Text = "探索开始时造物上限+1，「深海」界域唤醒体获得其「维度影像」。队伍中每有 1 名「深海」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83509_Name = {
    Text = "<OrangeQuality:「深海指轮」>"
  },
  RelicConfig_83509_StoryDesc = {
    Text = "深渊溟海中的沉睡者，开始向世界展示被遗忘的权威。"
  },
  RelicConfig_83510_BattleDesc = {
    Text = "探索开始时造物上限+1，「血肉」界域唤醒体获得其「维度影像」。队伍中每有 1 名「血肉」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83510_Desc = {
    Text = "探索开始时造物上限+1，「血肉」界域唤醒体获得其「维度影像」。队伍中每有 1 名「血肉」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83510_Name = {
    Text = "<OrangeQuality:「血肉指轮」>"
  },
  RelicConfig_83510_StoryDesc = {
    Text = "从未苦弱，已然飞升。"
  },
  RelicConfig_83511_BattleDesc = {
    Text = "探索开始时造物上限+1，「超维」界域唤醒体获得其「维度影像」。队伍中每有 1 名「超维」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83511_Desc = {
    Text = "探索开始时造物上限+1，「超维」界域唤醒体获得其「维度影像」。队伍中每有 1 名「超维」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83511_Name = {
    Text = "<OrangeQuality:「超维指轮」>"
  },
  RelicConfig_83511_StoryDesc = {
    Text = "无尽维度叠加而至，此刻「我」已无限完整。"
  },
  RelicConfig_83512_BattleDesc = {
    Text = "探索开始时造物上限+1，「混沌」界域唤醒体获得其「维度影像」。队伍中每有 1 名「混沌」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83512_Desc = {
    Text = "探索开始时造物上限+1，「混沌」界域唤醒体获得其「维度影像」。队伍中每有 1 名「混沌」界域唤醒体，造物上限+1。"
  },
  RelicConfig_83512_Name = {
    Text = "<OrangeQuality:「混沌指轮」>"
  },
  RelicConfig_83512_StoryDesc = {
    Text = "混沌无形，混沌无质，混沌已融于万物之中。"
  },
  RelicConfig_83606_BattleDesc = {
    Text = "手牌上限+ 1 。回合开始时若没有「引航者的抉择」，将其置入手中。\n每当首领失去初始最大生命的 10% 时，获得 1 层「扬帆」，上限 10 层，「扬帆」能够提升「破浪启航」的效果。\n每当自身失去初始最大生命的 10% 时，获得 1 层「泊锚」，上限 10 层，「泊锚」能够提升「拢岸暂息」的效果。"
  },
  RelicConfig_83606_Desc = {
    Text = "手牌上限+ 1 。回合开始时若没有「引航者的抉择」，将其置入手中。\n每当首领失去初始最大生命的 10% 时，获得 1 层「扬帆」，上限 10 层，「扬帆」能够提升「破浪启航」的效果。\n每当自身失去初始最大生命的 10% 时，获得 1 层「泊锚」，上限 10 层，「泊锚」能够提升「拢岸暂息」的效果。"
  },
  RelicConfig_83606_Name = {
    Text = "伊拉斯莫的指引"
  },
  RelicConfig_83606_StoryDesc = {
    Text = "闪烁的雷光将指引前进的方向。"
  },
  RelicConfig_84112_BattleDesc = {
    Text = "回合开始时阿格里帕获得 [Arg1] 狂气。「不耐的施舍」还会使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_84112_Desc = {
    Text = "回合开始时阿格里帕获得 [Arg1] 狂气。「不耐的施舍」还会使阿格里帕在本回合中算力消耗降低 [Arg2]，每回合最多生效 1 次。"
  },
  RelicConfig_84112_Name = {
    Text = "<OrangeQuality:维度影像·阿格里帕>"
  },
  RelicConfig_84113_BattleDesc = {
    Text = "回合开始时卡拉布获得 [Arg1] 狂气。卡拉布每次<FaxianKeywords:发现> <DerivativeCardKeywords_152:「赐福」>时出现 1 个额外选项，狂气爆发造成等量伤害的<Corrosion:侵蚀>。"
  },
  RelicConfig_84113_Desc = {
    Text = "回合开始时卡拉布获得 [Arg1] 狂气。卡拉布每次<FaxianKeywords:发现> <DerivativeCardKeywords_152:「赐福」>时出现 1 个额外选项，狂气爆发造成等量伤害的<Corrosion:侵蚀>。"
  },
  RelicConfig_84113_Name = {
    Text = "<OrangeQuality:维度影像·卡拉布>"
  },
  RelicConfig_84114_BattleDesc = {
    Text = "回合开始时皮克曼获得 [Arg1] 狂气。每获得 1 层「创意」，随机使 1 张手牌本回合算力消耗降低 1，皮克曼消耗「创意」时额外使所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_84114_Desc = {
    Text = "回合开始时皮克曼获得 [Arg1] 狂气。每获得 1 层「创意」，随机使 1 张手牌本回合算力消耗降低 1，皮克曼消耗「创意」时额外使所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_84114_Name = {
    Text = "<OrangeQuality:维度影像·皮克曼>"
  },
  RelicConfig_84116_BattleDesc = {
    Text = "回合开始时艾瑞卡获得 [Arg1] 狂气。艾瑞卡在 1 回合内打出 [Arg2] 张指令卡后，获得 2 点算力并使本场战斗「电磁爆破」享受的力量和戒备加成提高 1 倍。"
  },
  RelicConfig_84116_Desc = {
    Text = "回合开始时艾瑞卡获得 [Arg1] 狂气。艾瑞卡在 1 回合内打出 [Arg2] 张指令卡后，获得 2 点算力并使本场战斗「电磁爆破」享受的力量和戒备加成提高 1 倍。"
  },
  RelicConfig_84116_Name = {
    Text = "<OrangeQuality:维度影像·艾瑞卡>"
  },
  RelicConfig_84117_BattleDesc = {
    Text = "回合开始时诞妄·墨菲获得 [Arg1] 狂气。「螺湮圆舞」每第 3 次释放生效 3 次。"
  },
  RelicConfig_84117_Desc = {
    Text = "回合开始时诞妄·墨菲获得 [Arg1] 狂气。「螺湮圆舞」每第 3 次释放生效 3 次。"
  },
  RelicConfig_84117_Name = {
    Text = "<OrangeQuality:维度影像·诞妄·墨菲>"
  },
  RelicConfig_84118_BattleDesc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_84118_Desc = {
    Text = "回合开始时卡茜亚获得 [Arg1] 狂气。每抽 1 张牌就使卡茜亚获得 [Arg2] 点狂气。卡茜亚释放狂气爆发时所有敌人失去 [Arg3] 点力量。"
  },
  RelicConfig_84118_Name = {
    Text = "<OrangeQuality:维度影像·卡茜亚>"
  },
  RelicConfig_84119_BattleDesc = {
    Text = "回合开始时墨菲获得 [Arg1] 狂气。墨菲的「打击」和「防御」能够将 [Arg2]% 的「献祭」转化为临时触腕伤害，但每回合最多生效 1 次。"
  },
  RelicConfig_84119_Desc = {
    Text = "回合开始时墨菲获得 [Arg1] 狂气。墨菲的「打击」和「防御」能够将 [Arg2]% 的「献祭」转化为临时触腕伤害，但每回合最多生效 1 次。"
  },
  RelicConfig_84119_Name = {
    Text = "<OrangeQuality:维度影像·墨菲>"
  },
  RelicConfig_84121_BattleDesc = {
    Text = "回合开始时阿拉克涅获得 [Arg1] 狂气。「打击」和「防御」立即释放 1 次「无尽线缕」追击，每回合最多各生效 1 次。"
  },
  RelicConfig_84121_Desc = {
    Text = "回合开始时阿拉克涅获得 [Arg1] 狂气。「打击」和「防御」立即释放 1 次「无尽线缕」追击，每回合最多各生效 1 次。"
  },
  RelicConfig_84121_Name = {
    Text = "<OrangeQuality:维度影像·阿拉克涅>"
  },
  RelicConfig_84122_BattleDesc = {
    Text = "回合开始时图鲁获得 [Arg1] 狂气。图鲁的狂气消耗降低 [Arg2] 点，释放狂气爆发后立刻生成 [Arg3] 条临时触腕。"
  },
  RelicConfig_84122_Desc = {
    Text = "回合开始时图鲁获得 [Arg1] 狂气。图鲁的狂气消耗降低 [Arg2] 点，释放狂气爆发后立刻生成 [Arg3] 条临时触腕。"
  },
  RelicConfig_84122_Name = {
    Text = "<OrangeQuality:维度影像·图鲁>"
  },
  RelicConfig_84123_BattleDesc = {
    Text = "回合开始时波吕克斯获得 [Arg1] 狂气。战斗开始时获得 1 张「圣心」，「圣心」因第 3 次打出消耗时易伤所有敌人，并造成 2 次伤害。"
  },
  RelicConfig_84123_Desc = {
    Text = "回合开始时波吕克斯获得 [Arg1] 狂气。战斗开始时获得 1 张「圣心」，「圣心」因第 3 次打出消耗时易伤所有敌人，并造成 2 次伤害。"
  },
  RelicConfig_84123_Name = {
    Text = "<OrangeQuality:维度影像·波吕克斯>"
  },
  RelicConfig_84124_BattleDesc = {
    Text = "回合开始时哈姆林获得 [Arg1] 狂气。「灵魂序曲」算力消耗降低 [Arg2]，基础伤害次数提高 [Arg3]。"
  },
  RelicConfig_84124_Desc = {
    Text = "回合开始时哈姆林获得 [Arg1] 狂气。「灵魂序曲」算力消耗降低 [Arg2]，基础伤害次数提高 [Arg3]。"
  },
  RelicConfig_84124_Name = {
    Text = "<OrangeQuality:维度影像·哈姆林>"
  },
  RelicConfig_84125_BattleDesc = {
    Text = "回合开始时凯蒂古拉获得 [Arg1] 点狂气。累计消耗 10 层「活焰」后，立刻抽 1 张凯蒂古拉的指令卡并为其赋予 3 层「活焰」，本回合不再累计层数。"
  },
  RelicConfig_84125_Desc = {
    Text = "回合开始时凯蒂古拉获得 [Arg1] 点狂气。累计消耗 10 层「活焰」后，立刻抽 1 张凯蒂古拉的指令卡并为其赋予 3 层「活焰」，本回合不再累计层数。"
  },
  RelicConfig_84125_Name = {
    Text = "<OrangeQuality:维度影像·凯蒂古拉>"
  },
  RelicConfig_84126_BattleDesc = {
    Text = "回合开始时卡斯托尔获得 [Arg1] 狂气。战斗开始时将 2 张「黑羽」置入手中，每回合首次打出「黑羽」后获得 [Arg2] 点临时力量。"
  },
  RelicConfig_84126_Desc = {
    Text = "回合开始时卡斯托尔获得 [Arg1] 狂气。战斗开始时将 2 张「黑羽」置入手中，每回合首次打出「黑羽」后获得 [Arg2] 点临时力量。"
  },
  RelicConfig_84126_Name = {
    Text = "<OrangeQuality:维度影像·卡斯托尔>"
  },
  RelicConfig_84127_BattleDesc = {
    Text = "回合开始时克珀珊特获得 [Arg1] 狂气，获得 1 条临时触腕。每当触发死亡抵抗时克珀珊特获得 [Arg2] 点狂气，将 1 张算力消耗为 0 且附加消耗的「惩戒雷霆」置入手中。"
  },
  RelicConfig_84127_Desc = {
    Text = "回合开始时克珀珊特获得 [Arg1] 狂气，获得 1 条临时触腕。每当触发死亡抵抗时克珀珊特获得 [Arg2] 点狂气，将 1 张算力消耗为 0 且附加消耗的「惩戒雷霆」置入手中。"
  },
  RelicConfig_84127_Name = {
    Text = "<OrangeQuality:维度影像·克珀珊特>"
  },
  RelicConfig_89252_BattleDesc = {
    Text = "算力上限提高 1 ，每回合抽牌数提高 1 ，战斗开始时获得 [Arg1] 层「宿命牢笼」计数。\n每层「宿命牢笼」使所有唤醒体产生的狂气降低 [Arg2]% ，每次释放狂气爆发时，减少 1 层「宿命牢笼」。所有「宿命牢笼」被移除之后，所有唤醒体获得 [Arg3] 点狂气，获得「不屈之心」：所有唤醒体产生的狂气提高 [Arg4]%，每回合能够释放 2 次狂气爆发。"
  },
  RelicConfig_89252_Desc = {
    Text = "算力上限提高 1 ，每回合抽牌数提高 1 ，战斗开始时获得 [Arg1] 层「宿命牢笼」计数。\n每层「宿命牢笼」使所有唤醒体产生的狂气降低 [Arg2]% ，每次释放狂气爆发时，减少 1 层「宿命牢笼」。所有「宿命牢笼」被移除之后，所有唤醒体获得 [Arg3] 点狂气，获得「不屈之心」：所有唤醒体产生的狂气提高 [Arg4]%，每回合能够释放 2 次狂气爆发。"
  },
  RelicConfig_89252_Name = {
    Text = "受诅的羽毛"
  },
  RelicConfig_89252_StoryDesc = {
    Text = "如今，这片羽毛再也不能于天空上翱翔。"
  },
  RelicConfig_89645_BattleDesc = {
    Text = "手牌上限 +2 ，释放狂气爆发后临时最终伤害提高 10% 。\n卡牌进入超维空间后，手中 1 个「胚胎」转化为「圣洁之子」。\n每生成 1 个「胚胎」，超维空间一张随机卡牌算力消耗降低 1。"
  },
  RelicConfig_89645_Desc = {
    Text = "手牌上限 +2 ，释放狂气爆发后临时最终伤害提高 10% 。\n卡牌进入超维空间后，手中 1 个「胚胎」转化为「圣洁之子」。\n每生成 1 个「胚胎」，超维空间一张随机卡牌算力消耗降低 1。"
  },
  RelicConfig_89645_Name = {
    Text = "超弦腐血制剂"
  },
  RelicConfig_89646_BattleDesc = {
    Text = "回合开始时获得 250 点银钥能量。\n使用银钥觉醒后，将 1 张<DerivativeCardKeywords_129:「银钥微光」>置入手中。\n每回合开始时发现 1 张唤醒体的支援。"
  },
  RelicConfig_89646_Desc = {
    Text = "回合开始时获得 250 点银钥能量。\n使用银钥觉醒后，将 1 张<DerivativeCardKeywords_129:「银钥微光」>置入手中。\n每回合开始时发现 1 张唤醒体的支援。"
  },
  RelicConfig_89646_Name = {
    Text = "统合衍化制剂"
  },
  RelicConfig_89647_BattleDesc = {
    Text = "每回合第 1 张指令卡额外生效 1 次。\n湮灭时生成 1 条触腕。\n切换触腕为「怒涛」姿态后，本回合下 1 张指令卡的跃迁效果必定发动并将其 2 张原始复制置入超维空间，3 回合冷却。"
  },
  RelicConfig_89647_Desc = {
    Text = "每回合第 1 张指令卡额外生效 1 次。\n湮灭时生成 1 条触腕。\n切换触腕为「怒涛」姿态后，本回合下 1 张指令卡的跃迁效果必定发动并将其 2 张原始复制置入超维空间，3 回合冷却。"
  },
  RelicConfig_89647_Name = {
    Text = "超弦海渊制剂"
  },
  RelicConfig_89648_BattleDesc = {
    Text = "界域精通提高 200 点。\n消耗猩红熔炉时，提高消耗量 15% 的触腕伤害。\n每次触腕攻击时，积累 [Arg3] 点猩红熔炉。"
  },
  RelicConfig_89648_Desc = {
    Text = "界域精通提高 200 点。\n消耗猩红熔炉时，提高消耗量 15% 的触腕伤害。\n每次触腕攻击时，积累 [Arg3] 点猩红熔炉。"
  },
  RelicConfig_89648_Name = {
    Text = "腐血海渊制剂"
  },
  RelicConfig_91096_BattleDesc = {
    Text = "回合开始时，双方获得一层<Kuangre:狂热>，每层<Kuangre:狂热>使造成的主动和触腕伤害附带 10% 伤害等量的<BleedingIconKeywords:出血>。\n每造成首领生命 20% 的伤害就使所有唤醒体获得 10 狂气。\n战斗开始时将<DerivativeCardKeywords_108:「子嗣激励」>与<DerivativeCardKeywords_109:「子嗣庇佑」>洗入抽牌堆。"
  },
  RelicConfig_91096_Desc = {
    Text = "回合开始时，双方获得一层<Kuangre:狂热>，每层<Kuangre:狂热>使造成的主动和触腕伤害附带 10% 伤害等量的<BleedingIconKeywords:出血>。\n每造成首领生命 20% 的伤害就使所有唤醒体获得 10 狂气。\n战斗开始时将<DerivativeCardKeywords_108:「子嗣激励」>与<DerivativeCardKeywords_109:「子嗣庇佑」>洗入抽牌堆。"
  },
  RelicConfig_91096_Name = {
    Text = "苍白之卵"
  },
  RelicConfig_91096_StoryDesc = {
    Text = "苍白之子即将诞生时的鼓动。\n小心，它们马上就要来了。"
  },
  RelicConfig_94695_BattleDesc = {
    Text = "唤醒体被击杀后，其他友方获得 [Arg1] <StrongEffectKeywords:强效>，该效果每个唤醒体仅能触发一次。"
  },
  RelicConfig_94695_Desc = {
    Text = "唤醒体被击杀后，其他友方获得 [Arg1] <StrongEffectKeywords:强效>，该效果每个唤醒体仅能触发一次。"
  },
  RelicConfig_94695_Name = {
    Text = "<OrangeQuality:黑星燃烧之烬>"
  },
  RelicConfig_94696_BattleDesc = {
    Text = "战斗开始后，将 [Arg1] 张「<PVPDerivativeCardKeywords_21:蚀骨的拥抱>」置入手牌。"
  },
  RelicConfig_94696_Desc = {
    Text = "战斗开始后，将 [Arg1] 张「<PVPDerivativeCardKeywords_21:蚀骨的拥抱>」置入手牌。"
  },
  RelicConfig_94696_Name = {
    Text = "<OrangeQuality:活性注射器>"
  },
  RelicConfig_94697_BattleDesc = {
    Text = "回合结束时，丢弃所有手牌，并抽取相应数量的牌。"
  },
  RelicConfig_94697_Desc = {
    Text = "回合结束时，丢弃所有手牌，并抽取相应数量的牌。"
  },
  RelicConfig_94697_Name = {
    Text = "<OrangeQuality:蛊惑风铃>"
  },
  RelicConfig_94698_BattleDesc = {
    Text = "战斗开始后，在抽牌堆内置入 [Arg1] 张「<PVPDerivativeCardKeywords_22:后发制人>」和「<PVPDerivativeCardKeywords_23:脑中之音>」。"
  },
  RelicConfig_94698_Desc = {
    Text = "战斗开始后，在抽牌堆内置入 [Arg1] 张「<PVPDerivativeCardKeywords_22:后发制人>」和「<PVPDerivativeCardKeywords_23:脑中之音>」。"
  },
  RelicConfig_94698_Name = {
    Text = "<OrangeQuality:阿方索之器>"
  },
  RelicConfig_95975_BattleDesc = {
    Text = "手牌上限+1。\n回合开始时若没有<DerivativeCardKeywords_111:「灵魂吞噬」>将其置入手中。若「餍足」达到 10 则将其转化为<DerivativeCardKeywords_112:「记忆共鸣」>。"
  },
  RelicConfig_95975_Desc = {
    Text = "手牌上限+1。\n回合开始时若没有「灵魂吞噬」将其置入手中。若「餍足」达到 10 则将其转化为「记忆共鸣」。"
  },
  RelicConfig_95975_Name = {
    Text = "骸骨杯盏"
  },
  RelicConfig_95975_StoryDesc = {
    Text = "「血月高升，群骸当举杯共饮。」"
  },
  RelicConfig_95976_BattleDesc = {
    Text = "回合开始时杜勒赛因获得 [Arg1] 狂气和 [Arg2] 点力量。杜勒赛因食用「残骸」时，获得 20％ 永久力量的临时力量。"
  },
  RelicConfig_95976_Desc = {
    Text = "回合开始时杜勒赛因获得 [Arg1] 狂气和 [Arg2] 点力量。杜勒赛因食用「残骸」时，获得 20％ 永久力量的临时力量。"
  },
  RelicConfig_95976_Name = {
    Text = "<OrangeQuality:维度影像·杜勒赛因>"
  },
  RelicConfig_96652_BattleDesc = {
    Text = "回合开始时使手中 1 张指令卡获得「<BurningKeywords2:燃烧>」并积攒 1 层「<Heat:深暗之焰>」。「<Heat:深暗之焰>」达到 3 层后，将一张「<Overload:无尽的爆炎>」置入手中。"
  },
  RelicConfig_96652_Desc = {
    Text = "回合开始时使手中 1 张指令卡获得「<BurningKeywords2:燃烧>」并积攒 1 层「<Heat:深暗之焰>」。「<Heat:深暗之焰>」达到 3 层后，将一张「<Overload:无尽的爆炎>」置入手中。"
  },
  RelicConfig_96652_Name = {
    Text = "深暗之焰"
  },
  RelicConfig_96652_StoryDesc = {
    Text = "漆黑的火焰将贯彻她的意志，将一切焚烧殆尽。"
  },
  RelicConfig_97344_BattleDesc = {
    Text = "失去最后 1 张手牌时抽 2 张牌并获得 [Arg1] 点银钥能量。每次重置牌库后触腕伤害提高 [Arg2] 点。"
  },
  RelicConfig_97344_Desc = {
    Text = "失去最后 1 张手牌时抽 2 张牌并获得 [Arg1] 点银钥能量。每次重置牌库后触腕伤害提高 [Arg2] 点。"
  },
  RelicConfig_97344_Name = {
    Text = "弥萨格夺冠金杯"
  },
  RelicConfig_97344_StoryDesc = {
    Text = "今日，我们将忘记恐惧，忘记沉痛，只享受狂欢。"
  },
  RelicConfig_97345_BattleDesc = {
    Text = "每打出 3 张指令卡，获得 1 点算力并抽 1 张牌。每造成 1 次主动伤害就使临时最终伤害提高 2%，最大为 50%。"
  },
  RelicConfig_97345_Desc = {
    Text = "每打出 3 张指令卡，获得 1 点算力并抽 1 张牌。每造成 1 次主动伤害就使临时最终伤害提高 2%，最大为 50%。"
  },
  RelicConfig_97345_Name = {
    Text = "弥萨格夺冠金杯"
  },
  RelicConfig_97345_StoryDesc = {
    Text = "今日，我们将忘记恐惧，忘记沉痛，只享受狂欢。"
  },
  RelicConfig_97346_BattleDesc = {
    Text = "所有唤醒体暴击率提高 30%，奇数回合开始时，所有敌人失去 25% 当前生命。自身生命值比例低于敌人时，造成的最终伤害提高 50%；自身生命值比例高于敌人时，释放狂气爆发后获得 35 点狂气。"
  },
  RelicConfig_97346_Desc = {
    Text = "所有唤醒体暴击率提高 30%，奇数回合开始时，所有敌人失去 25% 当前生命。自身生命值比例低于敌人时，造成的最终伤害提高 50%；自身生命值比例高于敌人时，释放狂气爆发后获得 35 点狂气。"
  },
  RelicConfig_97346_Name = {
    Text = "弥萨格夺冠金杯"
  },
  RelicConfig_97346_StoryDesc = {
    Text = "今日，我们将忘记恐惧，忘记沉痛，只享受狂欢。"
  },
  RelicConfig_97347_BattleDesc = {
    Text = "最大算力提高 2 点，未消耗的算力可保留至下回合，若保留超过 2 点算力，下回合开始时所有唤醒体获得 20 点狂气；若保留超过 4 点算力，下回合造成的基础伤害提高 100%。"
  },
  RelicConfig_97347_Desc = {
    Text = "最大算力提高 2 点，未消耗的算力可保留至下回合，若保留超过 2 点算力，下回合开始时所有唤醒体获得 20 点狂气；若保留超过 4 点算力，下回合造成的基础伤害提高 100%。"
  },
  RelicConfig_97347_Name = {
    Text = "弥萨格夺冠金杯"
  },
  RelicConfig_97347_StoryDesc = {
    Text = "今日，我们将忘记恐惧，忘记沉痛，只享受狂欢。"
  },
  RelicConfig_98274_BattleDesc = {
    Text = "手牌上限 +1，战斗开始时获得「<DerivativeCardKeywords_116:调色盘>」。\n回合开始时获得 1 个「<PrimaryColor:原色>」并随机使 2 张指令卡获得「<ColorInkKeywords:认知失调>」，打出「<ColorInkKeywords:认知失调>」牌后按顺序获得 1 个「<PrimaryColor:原色>」。\n「<PrimaryColor:原色>」 打出后会被记录到「<DerivativeCardKeywords_116:调色盘>」上，若「<DerivativeCardKeywords_116:调色盘>」上存在 2 种不同的「<PrimaryColor:原色>」，会带来持续增益效果。\n若调色盘上存在 3 种不同的「<PrimaryColor:原色>」，立刻使所有敌人失去 5% 最大生命，并清空「<DerivativeCardKeywords_116:调色盘>」。"
  },
  RelicConfig_98274_Desc = {
    Text = "手牌上限 +1，战斗开始时获得「<DerivativeCardKeywords_116:调色盘>」。\n回合开始时获得 1 个「<PrimaryColor:原色>」并随机使 2 张指令卡获得「<ColorInkKeywords:认知失调>」，打出「<ColorInkKeywords:认知失调>」牌后按顺序获得 1 个「<PrimaryColor:原色>」。\n「<PrimaryColor:原色>」 打出后会被记录到「<DerivativeCardKeywords_116:调色盘>」上，若「<DerivativeCardKeywords_116:调色盘>」上存在 2 种不同的「<PrimaryColor:原色>」，会带来持续增益效果。\n若调色盘上存在 3 种不同的「<PrimaryColor:原色>」，立刻使所有敌人失去 5% 最大生命，并清空「<DerivativeCardKeywords_116:调色盘>」。"
  },
  RelicConfig_98274_Name = {
    Text = "异象调色盘"
  },
  RelicConfig_98274_StoryDesc = {
    Text = "在异象中，我们将见证「艺术」的诞生。"
  },
  RelicConfig_98367_BattleDesc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  RelicConfig_98367_Desc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  RelicConfig_98367_Name = {
    Text = "<WhiteQuality:怪蛇残蜕>"
  },
  RelicConfig_98367_StoryDesc = {
    Text = "自残蜕中重生。"
  },
  RelicConfig_98368_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 [Arg1]% 临时伤害强效。"
  },
  RelicConfig_98368_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 [Arg1]% 临时伤害强效。"
  },
  RelicConfig_98368_Name = {
    Text = "<OrangeQuality:万花筒+>"
  },
  RelicConfig_98368_StoryDesc = {
    Text = "所思所见皆为幻象。"
  },
  RelicConfig_98369_BattleDesc = {
    Text = "使用银钥觉醒后使手中算力最高的 [Arg1] 张卡牌在下次打出前获得保留和预备，获得 [Arg2] 点银钥能量。"
  },
  RelicConfig_98369_Desc = {
    Text = "使用银钥觉醒后使手中算力最高的 [Arg1] 张卡牌在下次打出前获得保留和预备，获得 [Arg2] 点银钥能量。"
  },
  RelicConfig_98369_Name = {
    Text = "<WhiteQuality:异乡邮票夹>"
  },
  RelicConfig_98369_StoryDesc = {
    Text = "被量化的思念。"
  },
  RelicConfig_98370_BattleDesc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层虚弱和易伤。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98370_Desc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98370_Name = {
    Text = "<WhiteQuality:空间偏折仪>"
  },
  RelicConfig_98370_StoryDesc = {
    Text = "跃入虚空。"
  },
  RelicConfig_98371_BattleDesc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_98371_Desc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_98371_Name = {
    Text = "<WhiteQuality:失衡的天平>"
  },
  RelicConfig_98371_StoryDesc = {
    Text = "不再象征公正。"
  },
  RelicConfig_98372_BattleDesc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张<DerivativeCardKeywords_129:「银钥微光」>置入手牌。"
  },
  RelicConfig_98372_Desc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张<DerivativeCardKeywords_129:「银钥微光」>置入手牌。"
  },
  RelicConfig_98372_Name = {
    Text = "<WhiteQuality:在夕光里>"
  },
  RelicConfig_98372_StoryDesc = {
    Text = "一起来拍照吧！体验一把面对真实的痛感。"
  },
  RelicConfig_98373_BattleDesc = {
    Text = "释放「狂气爆发」获得 [Arg1] 银钥能量。"
  },
  RelicConfig_98373_Desc = {
    Text = "释放「狂气爆发」获得 [Arg1] 银钥能量。"
  },
  RelicConfig_98373_Name = {
    Text = "<OrangeQuality:美丽瞬间+>"
  },
  RelicConfig_98373_StoryDesc = {
    Text = "将须臾的美保存至永远。"
  },
  RelicConfig_98374_BattleDesc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层中毒，并获得 [Arg2] 层反击。"
  },
  RelicConfig_98374_Desc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，并获得 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_98374_Name = {
    Text = "<OrangeQuality:先知的许愿灯+>"
  },
  RelicConfig_98374_StoryDesc = {
    Text = "回应你的愿望。"
  },
  RelicConfig_98375_BattleDesc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张<DerivativeCardKeywords_67:「银钥曦光」>置入手牌。"
  },
  RelicConfig_98375_Desc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张<DerivativeCardKeywords_67:「银钥曦光」>置入手牌。"
  },
  RelicConfig_98375_Name = {
    Text = "<OrangeQuality:在夕光里+>"
  },
  RelicConfig_98375_StoryDesc = {
    Text = "一起来拍照吧！体验一把面对真实的痛感。"
  },
  RelicConfig_98376_BattleDesc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  RelicConfig_98376_Desc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  RelicConfig_98376_Name = {
    Text = "<OrangeQuality:怪蛇残蜕+>"
  },
  RelicConfig_98376_StoryDesc = {
    Text = "自残蜕中重生。"
  },
  RelicConfig_98377_BattleDesc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98377_Desc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98377_Name = {
    Text = "<WhiteQuality:三棱镜>"
  },
  RelicConfig_98377_StoryDesc = {
    Text = "「光由七种色彩构成。」"
  },
  RelicConfig_98378_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。受到伤害后获得 [Arg2] 反击，每回合最多触发 3 次。"
  },
  RelicConfig_98378_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。受到伤害后获得 [Arg2] <RetaliateIconKeywords:反击>，每回合最多触发 3 次。"
  },
  RelicConfig_98378_Name = {
    Text = "<OrangeQuality:安全出口+>"
  },
  RelicConfig_98378_StoryDesc = {
    Text = "看来，他也没能逃出去。"
  },
  RelicConfig_98379_BattleDesc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  RelicConfig_98379_Desc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  RelicConfig_98379_Name = {
    Text = "<WhiteQuality:潜水头盔>"
  },
  RelicConfig_98379_StoryDesc = {
    Text = "梦想是星辰大海！"
  },
  RelicConfig_98380_BattleDesc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98380_Desc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98380_Name = {
    Text = "<WhiteQuality:过往的贡物>"
  },
  RelicConfig_98380_StoryDesc = {
    Text = "曾被进献之物。"
  },
  RelicConfig_98381_BattleDesc = {
    Text = "使用银钥觉醒后回复 [Heal:Arg1] 生命，获得 [Arg2] 银钥能量。"
  },
  RelicConfig_98381_Desc = {
    Text = "使用银钥觉醒后回复 [Heal:Arg1] 生命，获得 [Arg2] 银钥能量。"
  },
  RelicConfig_98381_Name = {
    Text = "<WhiteQuality:旅行阳伞>"
  },
  RelicConfig_98381_StoryDesc = {
    Text = "在无光之地绽放。"
  },
  RelicConfig_98382_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇数回合开始时抽 [Arg2] 张牌，偶数回合开始时获得 [Arg2] 点算力。"
  },
  RelicConfig_98382_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇数回合开始时抽 [Arg2] 张牌，偶数回合开始时获得 [Arg2] 点算力。"
  },
  RelicConfig_98382_Name = {
    Text = "<OrangeQuality:日月轮盘+>"
  },
  RelicConfig_98382_StoryDesc = {
    Text = "猜一猜，是黑还是白？"
  },
  RelicConfig_98383_BattleDesc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  RelicConfig_98383_Desc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  RelicConfig_98383_Name = {
    Text = "<OrangeQuality:小黄螺+>"
  },
  RelicConfig_98383_StoryDesc = {
    Text = "这只小黄螺出身高贵，有着完美的、无可挑剔的来源。"
  },
  RelicConfig_98384_BattleDesc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  RelicConfig_98384_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  RelicConfig_98384_Name = {
    Text = "<WhiteQuality:被遗忘者之血>"
  },
  RelicConfig_98384_StoryDesc = {
    Text = "日渐消融。"
  },
  RelicConfig_98385_BattleDesc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层中毒，并获得 [Arg2] 层反击。"
  },
  RelicConfig_98385_Desc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层<IntoxicationIconKeywords:中毒>，并获得 [Arg2] 层<RetaliateIconKeywords:反击>。"
  },
  RelicConfig_98385_Name = {
    Text = "<WhiteQuality:先知的许愿灯>"
  },
  RelicConfig_98385_StoryDesc = {
    Text = "回应你的愿望。"
  },
  RelicConfig_98386_BattleDesc = {
    Text = "回合开始时若生命低于 50%，临时伤害强效 +[Arg1]%，若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  RelicConfig_98386_Desc = {
    Text = "回合开始时若生命低于 50%，临时伤害强效 +[Arg1]%，若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  RelicConfig_98386_Name = {
    Text = "<WhiteQuality:医生手提箱>"
  },
  RelicConfig_98386_StoryDesc = {
    Text = "象征医生身份的手提箱，十分沉重。\n打开它的，未必是真的医生。"
  },
  RelicConfig_98387_BattleDesc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层虚弱和易伤。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98387_Desc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98387_Name = {
    Text = "<OrangeQuality:空间偏折仪+>"
  },
  RelicConfig_98387_StoryDesc = {
    Text = "跃入虚空。"
  },
  RelicConfig_98388_BattleDesc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98388_Desc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98388_Name = {
    Text = "<OrangeQuality:过往的贡物+>"
  },
  RelicConfig_98388_StoryDesc = {
    Text = "曾被进献之物。"
  },
  RelicConfig_98389_BattleDesc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇数回合开始时抽 [Arg2] 张牌，偶数回合开始时获得 [Arg2] 点算力。"
  },
  RelicConfig_98389_Desc = {
    Text = "战斗开始后，获得 [Arg1] <ProficientInRealmsIconKeywords:界域精通>。奇数回合开始时抽 [Arg2] 张牌，偶数回合开始时获得 [Arg2] 点算力。"
  },
  RelicConfig_98389_Name = {
    Text = "<WhiteQuality:日月轮盘>"
  },
  RelicConfig_98389_StoryDesc = {
    Text = "猜一猜，是黑还是白？"
  },
  RelicConfig_98390_BattleDesc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时力量 ，每回合最多触发 15 次。"
  },
  RelicConfig_98390_Desc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时<PowerIconKeywords:力量> ，每回合最多触发 15 次。"
  },
  RelicConfig_98390_Name = {
    Text = "<WhiteQuality:寂静序曲>"
  },
  RelicConfig_98390_StoryDesc = {
    Text = "著名小提琴家埃里克·艾克施坦因的提琴。\n如今，它已不可再奏响。"
  },
  RelicConfig_98391_BattleDesc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg2]%，生命越低则效果越强。"
  },
  RelicConfig_98391_Desc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg1]%，生命越低则效果越强。"
  },
  RelicConfig_98391_Name = {
    Text = "<WhiteQuality:哈福德灵药>"
  },
  RelicConfig_98391_StoryDesc = {
    Text = "成分不明的药物。\n据说著名提琴家埃里克对其青睐有加。"
  },
  RelicConfig_98392_BattleDesc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg2]%，生命越低则效果越强。"
  },
  RelicConfig_98392_Desc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg1]%，生命越低则效果越强。"
  },
  RelicConfig_98392_Name = {
    Text = "<OrangeQuality:哈福德灵药+>"
  },
  RelicConfig_98392_StoryDesc = {
    Text = "成分不明的药物。\n据说著名提琴家埃里克对其青睐有加。"
  },
  RelicConfig_98393_BattleDesc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98393_Desc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98393_Name = {
    Text = "<WhiteQuality:伶牙俐齿>"
  },
  RelicConfig_98393_StoryDesc = {
    Text = "能说会道的不止商人，亦有虔信者。"
  },
  RelicConfig_98394_BattleDesc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  RelicConfig_98394_Desc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  RelicConfig_98394_Name = {
    Text = "<WhiteQuality:幸运兔脚>"
  },
  RelicConfig_98394_StoryDesc = {
    Text = "对兔子来说，可就不那么幸运了。"
  },
  RelicConfig_98395_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。造成主动伤害后对所有敌人造成 [Arg2] 中毒，每回合最多触发 5 次。"
  },
  RelicConfig_98395_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。造成主动伤害后对所有敌人造成 [Arg2] <IntoxicationIconKeywords:中毒>，每回合最多触发 5 次。"
  },
  RelicConfig_98395_Name = {
    Text = "<OrangeQuality:祭司权杖+>"
  },
  RelicConfig_98395_StoryDesc = {
    Text = "不被许可的虔诚。"
  },
  RelicConfig_98396_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 [Arg1]% 临时伤害强效。"
  },
  RelicConfig_98396_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 [Arg1]% 临时伤害强效。"
  },
  RelicConfig_98396_Name = {
    Text = "<WhiteQuality:万花筒>"
  },
  RelicConfig_98396_StoryDesc = {
    Text = "所思所见皆为幻象。"
  },
  RelicConfig_98397_BattleDesc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_98397_Desc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_98397_Name = {
    Text = "<OrangeQuality:精密计时器+>"
  },
  RelicConfig_98397_StoryDesc = {
    Text = "人类有史以来最邪恶的发明之一。"
  },
  RelicConfig_98398_BattleDesc = {
    Text = "战斗开始时使所有敌人失去 [Arg1] 临时<ExhaustionIconKeywords:力量>。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98398_Desc = {
    Text = "战斗开始时使所有敌人失去 [Arg1] 临时<ExhaustionIconKeywords:力量>。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98398_Name = {
    Text = "<OrangeQuality:妙手空空+>"
  },
  RelicConfig_98398_StoryDesc = {
    Text = "杀人越货挠痒痒的绝佳工具。"
  },
  RelicConfig_98399_BattleDesc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_98399_Desc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  RelicConfig_98399_Name = {
    Text = "<WhiteQuality:精密计时器>"
  },
  RelicConfig_98399_StoryDesc = {
    Text = "人类有史以来最邪恶的发明之一。"
  },
  RelicConfig_98400_BattleDesc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时力量 ，每回合最多触发 15 次。"
  },
  RelicConfig_98400_Desc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时<PowerIconKeywords:力量> ，每回合最多触发 15 次。"
  },
  RelicConfig_98400_Name = {
    Text = "<OrangeQuality:寂静序曲+>"
  },
  RelicConfig_98400_StoryDesc = {
    Text = "著名小提琴家埃里克·艾克施坦因的提琴。\n如今，它已不可再奏响。"
  },
  RelicConfig_98401_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每回合首次获得反击后，获得 [Arg2] 算力。"
  },
  RelicConfig_98401_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每回合首次获得<RetaliateIconKeywords:反击>后，获得 [Arg2] 算力。"
  },
  RelicConfig_98401_Name = {
    Text = "<OrangeQuality:普特尼晨报+>"
  },
  RelicConfig_98401_StoryDesc = {
    Text = "您最贴心的马桶伴侣。"
  },
  RelicConfig_98402_BattleDesc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  RelicConfig_98402_Desc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  RelicConfig_98402_Name = {
    Text = "<OrangeQuality:潜水头盔+>"
  },
  RelicConfig_98402_StoryDesc = {
    Text = "梦想是星辰大海！"
  },
  RelicConfig_98403_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] 力量。每打出一张带有 「消耗」 的牌就获得 [Arg2] 临时力量，每回合最多触发 10 次。"
  },
  RelicConfig_98403_Desc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。每打出一张带有 「消耗」 的牌就获得 [Arg2] 临时<PowerIconKeywords:力量>，每回合最多触发 10 次。"
  },
  RelicConfig_98403_Name = {
    Text = "<OrangeQuality:小八音盒+>"
  },
  RelicConfig_98403_StoryDesc = {
    Text = "德克斯特的宅邸中有许多藏品，在被摔坏前，小八音盒曾是德克斯特小小姐最喜欢的玩具。\n时光荏苒，当德克斯特小姐再次找到她时，她齿轮松弛、音乐变调，却仍未停止旋转。"
  },
  RelicConfig_98404_BattleDesc = {
    Text = "释放「狂气爆发」获得 [Arg1] 银钥能量。"
  },
  RelicConfig_98404_Desc = {
    Text = "释放「狂气爆发」获得 [Arg1] 银钥能量。"
  },
  RelicConfig_98404_Name = {
    Text = "<WhiteQuality:美丽瞬间>"
  },
  RelicConfig_98404_StoryDesc = {
    Text = "将须臾的美保存至永远。"
  },
  RelicConfig_98405_BattleDesc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98405_Desc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  RelicConfig_98405_Name = {
    Text = "<OrangeQuality:伶牙俐齿+>"
  },
  RelicConfig_98405_StoryDesc = {
    Text = "能说会道的不止商人，亦有虔信者。"
  },
  RelicConfig_98406_BattleDesc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  RelicConfig_98406_Desc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  RelicConfig_98406_Name = {
    Text = "<OrangeQuality:亲爱的宝贝+>"
  },
  RelicConfig_98406_StoryDesc = {
    Text = "木匠为妻子做了个栩栩如生的木偶，它将代替他们的儿子，在她腹中沉睡。"
  },
  RelicConfig_98407_BattleDesc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  RelicConfig_98407_Desc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  RelicConfig_98407_Name = {
    Text = "<OrangeQuality:幸运兔脚+>"
  },
  RelicConfig_98407_StoryDesc = {
    Text = "对兔子来说，可就不那么幸运了。"
  },
  RelicConfig_98408_BattleDesc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_98408_Desc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_98408_Name = {
    Text = "<WhiteQuality:彩蛋时间>"
  },
  RelicConfig_98408_StoryDesc = {
    Text = "纵享欢乐，但不可食用。"
  },
  RelicConfig_98409_BattleDesc = {
    Text = "战斗开始时使所有敌人失去 [Arg1] 临时<ExhaustionIconKeywords:力量>。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98409_Desc = {
    Text = "战斗开始时使所有敌人失去 [Arg1] 临时<ExhaustionIconKeywords:力量>。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  RelicConfig_98409_Name = {
    Text = "<WhiteQuality:妙手空空>"
  },
  RelicConfig_98409_StoryDesc = {
    Text = "杀人越货挠痒痒的绝佳工具。"
  },
  RelicConfig_98410_BattleDesc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  RelicConfig_98410_Desc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  RelicConfig_98410_Name = {
    Text = "<WhiteQuality:亲爱的宝贝>"
  },
  RelicConfig_98410_StoryDesc = {
    Text = "木匠为妻子做了个栩栩如生的木偶，它将代替他们的儿子，在她腹中沉睡。"
  },
  RelicConfig_98411_BattleDesc = {
    Text = "回合开始时，若银钥能量大于 [Arg1] ，则消耗 [Arg1] 点银钥能量将 1 张<DerivativeCardKeywords_115:「高级灵感」>置入手中。"
  },
  RelicConfig_98411_Desc = {
    Text = "回合开始时，若银钥能量大于 [Arg1] ，则消耗 [Arg1] 点银钥能量将 1 张<DerivativeCardKeywords_115:「高级灵感」>置入手中。"
  },
  RelicConfig_98411_Name = {
    Text = "<RedQuality:噩梦表象>"
  },
  RelicConfig_98411_StoryDesc = {
    Text = "小心，放纵的深眠会在你不知道的时候吞噬一切。"
  },
  RelicConfig_98412_BattleDesc = {
    Text = "每释放 5 次「狂气爆发」，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  RelicConfig_98412_Desc = {
    Text = "每释放 5 次「狂气爆发」，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  RelicConfig_98412_Name = {
    Text = "<OrangeQuality:群星之酒+>"
  },
  RelicConfig_98412_StoryDesc = {
    Text = "游走于繁星之间。"
  },
  RelicConfig_98413_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。受到伤害后获得 [Arg2] 反击，每回合最多触发 3 次。"
  },
  RelicConfig_98413_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。受到伤害后获得 [Arg2] <RetaliateIconKeywords:反击>，每回合最多触发 3 次。"
  },
  RelicConfig_98413_Name = {
    Text = "<WhiteQuality:安全出口>"
  },
  RelicConfig_98413_StoryDesc = {
    Text = "看来，他也没能逃出去。"
  },
  RelicConfig_98414_BattleDesc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  RelicConfig_98414_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  RelicConfig_98414_Name = {
    Text = "<OrangeQuality:被遗忘者之血+>"
  },
  RelicConfig_98414_StoryDesc = {
    Text = "日渐消融。"
  },
  RelicConfig_98415_BattleDesc = {
    Text = "使用银钥觉醒后回复 [Heal:Arg1] 生命，获得 [Arg2] 银钥能量。"
  },
  RelicConfig_98415_Desc = {
    Text = "使用银钥觉醒后回复 [Heal:Arg1] 生命，获得 [Arg2] 银钥能量。"
  },
  RelicConfig_98415_Name = {
    Text = "<OrangeQuality:旅行阳伞+>"
  },
  RelicConfig_98415_StoryDesc = {
    Text = "在无光之地绽放。"
  },
  RelicConfig_98416_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每回合首次获得反击后，获得 [Arg2] 算力。"
  },
  RelicConfig_98416_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每回合首次获得<RetaliateIconKeywords:反击>后，获得 [Arg2] 算力。"
  },
  RelicConfig_98416_Name = {
    Text = "<WhiteQuality:普特尼晨报>"
  },
  RelicConfig_98416_StoryDesc = {
    Text = "您最贴心的马桶伴侣。"
  },
  RelicConfig_98417_BattleDesc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_98417_Desc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  RelicConfig_98417_Name = {
    Text = "<OrangeQuality:彩蛋时间+>"
  },
  RelicConfig_98417_StoryDesc = {
    Text = "纵享欢乐，但不可食用。"
  },
  RelicConfig_98418_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次施加中毒后，抽 [Arg2] 张牌。"
  },
  RelicConfig_98418_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次施加<IntoxicationIconKeywords:中毒>后，抽 [Arg2] 张牌。"
  },
  RelicConfig_98418_Name = {
    Text = "<OrangeQuality:莱茵德纸草书+>"
  },
  RelicConfig_98418_StoryDesc = {
    Text = "下面请听题：10个僧侣分6只面包，请问他们各得多少？"
  },
  RelicConfig_98419_BattleDesc = {
    Text = "每释放 5 次「狂气爆发」，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  RelicConfig_98419_Desc = {
    Text = "每释放 5 次「狂气爆发」，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  RelicConfig_98419_Name = {
    Text = "<WhiteQuality:群星之酒>"
  },
  RelicConfig_98419_StoryDesc = {
    Text = "游走于繁星之间。"
  },
  RelicConfig_98420_BattleDesc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98420_Desc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  RelicConfig_98420_Name = {
    Text = "<OrangeQuality:三棱镜+>"
  },
  RelicConfig_98420_StoryDesc = {
    Text = "「光由七种色彩构成。」"
  },
  RelicConfig_98421_BattleDesc = {
    Text = "使用银钥觉醒后使手中算力最高的 [Arg1] 张卡牌在下次打出前获得保留和预备，获得 [Arg2] 点银钥能量。"
  },
  RelicConfig_98421_Desc = {
    Text = "使用银钥觉醒后使手中算力最高的 [Arg1] 张卡牌在下次打出前获得保留和预备，获得 [Arg2] 点银钥能量。"
  },
  RelicConfig_98421_Name = {
    Text = "<OrangeQuality:异乡邮票夹+>"
  },
  RelicConfig_98421_StoryDesc = {
    Text = "被量化的思念。"
  },
  RelicConfig_98422_BattleDesc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_98422_Desc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  RelicConfig_98422_Name = {
    Text = "<OrangeQuality:失衡的天平+>"
  },
  RelicConfig_98422_StoryDesc = {
    Text = "不再象征公正。"
  },
  RelicConfig_98423_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。造成主动伤害后对所有敌人造成 [Arg2] 中毒，每回合最多触发 5 次。"
  },
  RelicConfig_98423_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。造成主动伤害后对所有敌人造成 [Arg2] <IntoxicationIconKeywords:中毒>，每回合最多触发 5 次。"
  },
  RelicConfig_98423_Name = {
    Text = "<WhiteQuality:祭司权杖>"
  },
  RelicConfig_98423_StoryDesc = {
    Text = "不被许可的虔诚。"
  },
  RelicConfig_98424_BattleDesc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次施加中毒后，抽 [Arg2] 张牌。"
  },
  RelicConfig_98424_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次施加<IntoxicationIconKeywords:中毒>后，抽 [Arg2] 张牌。"
  },
  RelicConfig_98424_Name = {
    Text = "<WhiteQuality:莱茵德纸草书>"
  },
  RelicConfig_98424_StoryDesc = {
    Text = "下面请听题：10个僧侣分6只面包，请问他们各得多少？"
  },
  RelicConfig_98425_BattleDesc = {
    Text = "战斗开始时获得 [Arg1] 力量。每打出一张带有 「消耗」 的牌就获得 [Arg2] 临时力量，每回合最多触发 10 次。"
  },
  RelicConfig_98425_Desc = {
    Text = "战斗开始时获得 [Arg1] <PowerIconKeywords:力量>。每打出一张带有 「消耗」 的牌就获得 [Arg2] 临时<PowerIconKeywords:力量>，每回合最多触发 10 次。"
  },
  RelicConfig_98425_Name = {
    Text = "<WhiteQuality:小八音盒>"
  },
  RelicConfig_98425_StoryDesc = {
    Text = "德克斯特的宅邸中有许多藏品，在被摔坏前，小八音盒曾是德克斯特小小姐最喜欢的玩具。\n时光荏苒，当德克斯特小姐再次找到她时，她齿轮松弛、音乐变调，却仍未停止旋转。"
  },
  RelicConfig_98426_BattleDesc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  RelicConfig_98426_Desc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  RelicConfig_98426_Name = {
    Text = "<WhiteQuality:小黄螺>"
  },
  RelicConfig_98426_StoryDesc = {
    Text = "这只小黄螺出身高贵，有着完美的、无可挑剔的来源。"
  },
  RelicConfig_98427_BattleDesc = {
    Text = "回合开始时若生命低于 50%，临时伤害强效 +[Arg1]%，若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  RelicConfig_98427_Desc = {
    Text = "回合开始时若生命低于 50%，临时伤害强效 +[Arg1]%，若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  RelicConfig_98427_Name = {
    Text = "<OrangeQuality:医生手提箱+>"
  },
  RelicConfig_98427_StoryDesc = {
    Text = "象征医生身份的手提箱，十分沉重。\n打开它的，未必是真的医生。"
  },
  RelicConfig_98891_BattleDesc = {
    Text = "战斗开始后，获得 5 层「<LostWay:迷失>」，每打出 3 张指令卡后减少 1 层。\n所有「<LostWay:迷失>」被移除后，所有唤醒体获得 100 点狂气，每打出 3 张指令卡后回复 [Arg1] 点生命，对前排敌方施加敌方最大生命 1% 的<Corrosion:侵蚀>。"
  },
  RelicConfig_98891_Desc = {
    Text = "战斗开始后，获得 5 层「<LostWay:迷失>」，每打出 3 张指令卡后减少 1 层。\n所有「<LostWay:迷失>」被移除后，所有唤醒体获得 100 点狂气，每打出 3 张指令卡后回复 [Arg1] 点生命，对前排敌方施加敌方最大生命 1% 的<Corrosion:侵蚀>。"
  },
  RelicConfig_98891_Name = {
    Text = "救世圣灯"
  },
  RelicConfig_98891_StoryDesc = {
    Text = "纵使经历暗淡，救世的提灯终将于死亡中再度长明。"
  }
})
return Text_RelicConfig
