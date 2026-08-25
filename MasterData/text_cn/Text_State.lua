__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_State = readonly({
  State_100291_Desc = {
    Text = "所有唤醒体造成的狂气提高 50%。"
  },
  State_100291_Name = {Text = "剖白"},
  State_100292_Name = {
    Text = "回合开始"
  },
  State_100293_Desc = {
    Text = "所有唤醒体造成的狂气降低 50%。"
  },
  State_100293_Name = {
    Text = "人格阴影"
  },
  State_100295_Name = {
    Text = "伤害监听"
  },
  State_100296_Desc = {
    Text = "每有 1 层，回合开始后所有唤醒体获得 <Energy:5> 狂气。"
  },
  State_100296_Name = {
    Text = "自我暗面"
  },
  State_100297_Desc = {
    Text = "所有唤醒体造成的狂气提高 50%，回合结束时获得 20% 最大生命的护盾。"
  },
  State_100297_Name = {
    Text = "心灵壁垒"
  },
  State_100298_Desc = {
    Text = "回合开始后失去 10% 当前生命，获得 [DescArg1] 点<PowerIconKeywords:力量>。所有唤醒体造成的狂气降低 50%。"
  },
  State_100298_Name = {
    Text = "壁垒崩解"
  },
  State_100299_Desc = {
    Text = "狂气爆发计数"
  },
  State_100299_Name = {
    Text = "狂气爆发计数"
  },
  State_100302_Name = {
    Text = "狂气爆发监听"
  },
  State_100307_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后获得 1 层「共创」，本回合内下次其他唤醒体的狂气爆发能够消耗「共创」，使该次狂气爆发暴击率提高 <WeaponEffect_Num:[StateArg1]%>，并使消耗「共创」的唤醒体获得装备者狂气回充 <WeaponEffect_Num:[StateArg1]%> 的狂气。"
  },
  State_100307_WeaponDesc = {
    Text = "装备者释放狂气爆发后获得 1 层「共创」，本回合内下次其他唤醒体的狂气爆发能够消耗「共创」，使该次狂气爆发暴击率提高 <WeaponEffect_Num:[StateArg1]%>，并使消耗「共创」的唤醒体获得 <WeaponEffect_Num:[DescArg1]> 点狂气。"
  },
  State_100326_Desc = {
    Text = "每有 1 层，回合开始后所有唤醒体获得 <Energy:3> 狂气。"
  },
  State_100326_Name = {
    Text = "<DarkEgo:自我暗面>"
  },
  State_100327_Desc = {
    Text = "所有唤醒体造成的狂气提高 50%，回合结束时获得 20% 最大生命的护盾。"
  },
  State_100327_Name = {
    Text = "<MindWall:心灵壁垒>"
  },
  State_100328_Desc = {
    Text = "所有唤醒体造成的狂气提高 50%。"
  },
  State_100328_Name = {
    Text = "<TrueConfess:剖白>"
  },
  State_100329_Desc = {
    Text = "所有唤醒体造成的狂气降低 50%，回合结束后获得 1 层「<DarkEgo:自我暗面>」：回合开始后，所有唤醒体获得 3 狂气。"
  },
  State_100329_Name = {
    Text = "<ShadowSelf:人格阴影>"
  },
  State_100330_Desc = {
    Text = "回合开始后失去 10% 当前生命，获得 [DescArg1] 点<PowerIconKeywords:力量>。所有唤醒体造成的狂气降低 50%。"
  },
  State_100330_Name = {
    Text = "<BarrierCrash:壁垒崩解>"
  },
  State_100395_Name = {
    Text = "创构的恩赐之血+"
  },
  State_100396_Name = {
    Text = "创构的恩赐之血"
  },
  State_100527_Desc = {
    Text = "皮克曼触发「发现」效果时额外增加「灵感迸发！」选项：消耗 1 层「狂想」，选择所有效果并获得 1 层「创意」。"
  },
  State_100527_Name = {Text = "狂想"},
  State_100541_Desc = {
    Text = "若当前拥有 10 层「创意」，皮克曼释放狂气爆发后消耗所有「创意」，获得 1 层狂想并使所有唤醒体获得 15 点狂气。创意上限为 10 层，能够继承至下场战斗。"
  },
  State_100541_Name = {
    Text = "<Chuangyi:创意>"
  },
  State_100542_Desc = {
    Text = "皮克曼触发「发现」效果时额外增加「灵感迸发！」选项：消耗 1 层「狂想」，选择所有「发现」效果并获得 1 层「创意」。"
  },
  State_100542_Name = {
    Text = "<Kuangxiang:狂想>"
  },
  State_100544_Name = {
    Text = "甜蜜蛞蝓"
  },
  State_100544_WeaponDesc = {
    Text = "装备者造成的护盾与生命回复提高 6%。若装备者界域精通大于 50，护盾与生命回复额外提高 6%。"
  },
  State_100545_Name = {
    Text = "甜蜜蛞蝓"
  },
  State_100545_WeaponDesc = {
    Text = "装备者造成的护盾与生命回复提高 6%。若装备者界域精通大于 50，护盾与生命回复额外提高 6%。"
  },
  State_100558_Desc = {
    Text = "本回合下次其他唤醒体狂气爆发暴击率提高 [StateArg1]％，使用后获得 [DescArg1] 点狂气。"
  },
  State_100558_Name = {Text = "共创"},
  State_100559_Desc = {
    Text = "包含以下「星辰篇造物」：恶童、春之祭、重锁、缠丝玛瑙、恩赐之血、锈蚀钢锯、金色梦乡、染血鹅卵石。"
  },
  State_100559_Name = {
    Text = "<Chuanggouzaowu:创构的造物>"
  },
  State_100562_Desc = {
    Text = "本回合打出的下 [Layer] 张指令卡算力消耗降低 2。"
  },
  State_100562_Name = {
    Text = "真实,亦是幻想"
  },
  State_100564_Desc = {
    Text = "包含以下「刻印」：筹算、妙手、狂化、催化、蛮力、铁壁、衰竭、灵感。"
  },
  State_100564_Name = {
    Text = "<Chuanggoukeyin:创构的刻印>"
  },
  State_100566_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_100617_Desc = {
    Text = "回合结束时，获得 1 条触腕上限。"
  },
  State_100617_Name = {
    Text = "湮塞的执念"
  },
  State_100619_Desc = {
    Text = "力量被降低时，仅会降低 50% 的力量层数。"
  },
  State_100619_Name = {
    Text = "衰竭抵抗"
  },
  State_100621_Desc = {
    Text = "每有 1 层使玩家造成的基础伤害降低 15%，能在之后指引航行的方向。"
  },
  State_100621_Name = {
    Text = "微弱烛光"
  },
  State_100623_Desc = {
    Text = "每有 1 层使玩家造成的基础伤害降低 30%，造成主动或触腕伤害后，减少自身 [DescArg1] 中毒。"
  },
  State_100623_Name = {
    Text = "迷航之光"
  },
  State_100639_Desc = {
    Text = "造成的触腕伤害临时降低 50%。"
  },
  State_100639_Name = {
    Text = "遗失的久远之城"
  },
  State_100644_Desc = {
    Text = "永久降低目标力量，获得等量力量。"
  },
  State_100644_Name = {
    Text = "<TouquKeywords: 永久偷取>"
  },
  State_100647_Desc = {
    Text = "免疫一切伤害。"
  },
  State_100647_Name = {
    Text = "免疫一切伤害。"
  },
  State_100694_Desc = {
    Text = "每有 1 层使玩家造成的基础伤害降低 30%，造成主动或触腕伤害后，减少自身中毒。"
  },
  State_100694_Name = {
    Text = "迷航之光"
  },
  State_116342_Desc = {
    Text = "打出<ErosionColorInkKeywords:认知错乱>卡牌后使「绘者」获得 1 层<DecayDye:幻世染料>。"
  },
  State_116342_Name = {
    Text = "异象调色盘"
  },
  State_116406_Name = {Text = "进阶"},
  State_116407_Name = {Text = "空状态"},
  State_116858_Desc = {
    Text = "此状态用的是易伤乘区，假装是个独立乘区。__「仅开发用」"
  },
  State_116858_Name = {
    Text = "若拥有某状态则受到伤害翻倍__「仅开发用」"
  },
  State_116859_Desc = {
    Text = "下回合开始时，获得破绽。"
  },
  State_116859_Name = {
    Text = "延迟破绽"
  },
  State_116958_Desc = {
    Text = "打出卡牌后，受到对应层数的伤害。"
  },
  State_116958_Name = {
    Text = "<PVPCardLockColour:卡牌封锁>"
  },
  State_117154_Desc = {
    Text = "该效果在队伍的所有唤醒体上仅会生效 1 次，无法重复触发。"
  },
  State_117154_Name = {
    Text = "<TeamUnique: 队伍唯一>"
  },
  State_117212_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」前和回合结束时，对<HPAndShieldMax:生命与护盾最高>的敌方施加 <Damage:[Damage:StateArg1]> 层<PVPCorrosionKeywords:罪印>。"
  },
  State_117212_Name = {
    Text = "扭曲的骑士诗"
  },
  State_117213_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，对狂气最高的敌方造成 [StateArg1] <PVPfengsuoKeywords:爆发封锁>。"
  },
  State_117213_Name = {
    Text = "圣子尊容"
  },
  State_117346_Desc = {
    Text = "波吕克斯造成的伤害附加 [Layer]％ 出血。"
  },
  State_117346_Name = {Text = "罪印"},
  State_117355_Desc = {
    Text = "波吕克斯打出的下一张指令卡生效 2 次。"
  },
  State_117355_Name = {
    Text = "神启新约"
  },
  State_117357_Desc = {
    Text = "队伍唯一:「融痕」和「灰烬遗迹」刷新后使装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气。"
  },
  State_117357_WeaponDesc = {
    Text = "「融痕」和「灰烬遗迹」刷新后使装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气。"
  },
  State_117358_Desc = {
    Text = "每层使波吕克斯造成的伤害附加 1% 出血。"
  },
  State_117358_Name = {
    Text = "<ZuiyinKeywords:罪印>"
  },
  State_117744_Desc = {
    Text = "失去 [Layer] <MaxHPKeywords:最大生命>，被驱散时不会返还失去的最大生命，触发时受到 [Layer] 点纯粹伤害，永续。"
  },
  State_117744_Name = {Text = "罪印"},
  State_117745_Desc = {
    Text = "施加时失去等量层数的<MaxHPKeywords:最大生命>，被驱散时不会返还失去的最大生命，触发时受到等量层数的纯粹伤害，永续。"
  },
  State_117745_Name = {
    Text = "<PVPCorrosionKeywords:罪印>"
  },
  State_117755_Desc = {
    Text = "回合结束之前无法进行任何行动。"
  },
  State_117755_Name = {Text = "昏迷"},
  State_117756_Desc = {
    Text = "回合结束之前无法进行任何行动。"
  },
  State_117756_Name = {Text = "昏迷"},
  State_117776_Desc = {
    Text = "本回合下 [Layer] 张指令卡最终伤害和护盾提高 [StateArg1]％。"
  },
  State_117776_Name = {Text = "神焰"},
  State_117777_Desc = {
    Text = "队伍唯一：装备者卡牌造成的基础伤害与暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时和装备者释放狂气爆发后获得 1 层心火，装备者本回合打出指令卡时消耗 1 层「心火」，使其最终伤害和护盾提高 <WeaponEffect_Num:[StateArg2]%>。超维回合中改为获得「神焰」，效果翻倍。"
  },
  State_117777_WeaponDesc = {
    Text = "装备者卡牌造成的基础伤害与暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时和装备者释放狂气爆发后获得 1 层心火，装备者本回合打出指令卡时消耗 1 层「心火」，使其最终伤害和护盾提高 <WeaponEffect_Num:[StateArg2]%>。超维回合中改为获得「神焰」，效果翻倍。"
  },
  State_117778_Desc = {
    Text = "本回合下 [Layer] 张指令卡最终伤害和护盾提高 [StateArg1]％。"
  },
  State_117778_Name = {Text = "心火"},
  State_117779_Desc = {
    Text = "队伍唯一：超维回合装备者获得 3 层「心火」，装备者本回合打出指令卡时消耗 1 层，使其最终伤害和护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_117779_WeaponDesc = {
    Text = "超维回合装备者获得 3 层「心火」，装备者本回合打出指令卡时消耗 1 层，使其最终伤害和护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_117851_Desc = {
    Text = "波吕克斯每张指令卡额外享受 50% 「苦痛救赎」效果，持续 [Layer] 回合。"
  },
  State_117851_Name = {
    Text = "照彻白夜之光"
  },
  State_117853_Desc = {
    Text = "波吕克斯本回合打出的下 [Layer] 张指令卡伤害提高 [DescArg1]，护盾提高 [DescArg2] ，获得 10 点狂气。"
  },
  State_117853_Name = {
    Text = "苦痛救赎"
  },
  State_117869_Desc = {
    Text = "每次释放狂气爆发增加 1 层「呼唤」，每有 1 层「呼唤」获得 [DescArg1] 点力量，上限为 5 层。"
  },
  State_117869_Name = {
    Text = "深海主祭"
  },
  State_117870_Desc = {
    Text = "死亡后，击杀者回复 20% 已损失生命。"
  },
  State_117870_Name = {
    Text = "美味鱼生"
  },
  State_117875_Desc = {
    Text = "若后方有空余位置，则在行动后失去 1 层，召唤 1 个附加「美味鱼生」的「幼鱼」。"
  },
  State_117875_Name = {
    Text = "互助契约：鱼群"
  },
  State_117876_Desc = {
    Text = "造成的 <WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重创>效果提高为 50%。"
  },
  State_117876_Name = {
    Text = "虚弱&脆弱&重创加深"
  },
  State_117880_Desc = {
    Text = "本场战斗中之后的「鱼群飞跃」额外触发 1 次。"
  },
  State_117880_Name = {
    Text = "鱼群飞跃额外触发"
  },
  State_117883_Desc = {
    Text = "达到 5 层后，立即封印全体唤醒体，将意图更换为：「利莫里亚的荣光！+」。"
  },
  State_117883_Name = {Text = "呼唤"},
  State_117885_Desc = {
    Text = "受到力量降低效果时也会对施加者产生等量力量降低效果。"
  },
  State_117885_Name = {
    Text = "以牙还牙"
  },
  State_117889_Desc = {
    Text = "登场时自身最大生命提高 10% 并为其他友方增加 [DescArg1] 的<PowerIconKeywords:力量>，使本场战斗中<FishLeapWords:群序之力>的生命提高和获取力量效果额外触发 1 次。"
  },
  State_117889_Name = {
    Text = "群序之力"
  },
  State_118112_Desc = {
    Text = "受到的单次伤害上限为 [DescArg1] 点，生命低于 50% 后移除。"
  },
  State_118112_Name = {
    Text = "承痛阈值 I"
  },
  State_118113_Desc = {
    Text = "受到主动伤害并失去生命后，获得等同于失去生命 15% 的护盾和失去生命 5% 的<AlertIconKeywords: 临时戒备>。"
  },
  State_118113_Name = {
    Text = "软体特性I"
  },
  State_118114_Desc = {
    Text = "受到主动伤害并失去生命后，获得等同于失去生命 35% 的护盾和失去生命 10% 的<AlertIconKeywords: 临时戒备>。"
  },
  State_118114_Name = {
    Text = "软体特性III"
  },
  State_118115_Desc = {
    Text = "若前排有空余位置，则在行动后失去 1 层，召唤 1 个「深海分殖体」。"
  },
  State_118115_Name = {
    Text = "互助契约：深海分殖体"
  },
  State_118116_Desc = {
    Text = "受到的单次伤害上限为 [DescArg1] 点，生命低于 50% 后移除。"
  },
  State_118116_Name = {
    Text = "承痛阈值 II"
  },
  State_118117_Desc = {
    Text = "受到的单次伤害上限为 [DescArg1] 点，生命低于 50% 后移除。"
  },
  State_118117_Name = {
    Text = "承痛阈值III"
  },
  State_118118_Desc = {
    Text = "获得 1 条<TentacleInjurieIconKeywords:触腕伤害>为 [TentaclePower:DescArg1] 的触腕和 5 条触腕上限。回合结束后获得 1 条触腕。受到的力量降低效果缩减 50%。"
  },
  State_118118_Name = {
    Text = "触腕集结"
  },
  State_118119_Desc = {
    Text = "受到主动伤害并失去生命后，获得等同于失去生命 25% 的护盾和失去生命 5% 的<AlertIconKeywords: 临时戒备>。"
  },
  State_118119_Name = {
    Text = "软体特性II"
  },
  State_118319_Desc = {
    Text = "受到的单次伤害上限为 [DescArg1] 点，生命低于 50% 后移除。"
  },
  State_118319_Name = {
    Text = "海渊之盾伤害限制"
  },
  State_118320_Name = {
    Text = "临时衰竭反制计数"
  },
  State_118321_Name = {
    Text = "衰竭反制计数"
  },
  State_118322_Name = {
    Text = "预备召唤标记"
  },
  State_118323_Desc = {
    Text = "触发过鱼群飞跃"
  },
  State_118323_Name = {
    Text = "鱼群飞跃出场标记"
  },
  State_118324_Desc = {
    Text = "每造成 1 次伤害，生成 1 条临时触腕。"
  },
  State_118324_Name = {Text = "神恩"},
  State_118325_Desc = {
    Text = "造成未被格挡的伤害时将 [DescArg1] 张窒息洗入抽牌堆顶部"
  },
  State_118325_Name = {
    Text = "新世界蛇头人震颤"
  },
  State_118656_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_118656_Name = {
    Text = "被多次寄生"
  },
  State_118657_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_118657_Name = {
    Text = "被再次寄生"
  },
  State_118659_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_118659_Name = {Text = "被寄生"},
  State_118663_Name = {
    Text = "新世界蛇头人意图监听"
  },
  State_118669_Name = {
    Text = "新世界蛇头人初始化"
  },
  State_118670_Desc = {
    Text = "检测是否有衰竭反制"
  },
  State_118670_Name = {
    Text = "衰竭反制检测"
  },
  State_118671_Desc = {
    Text = "检测玩家上衰竭的行为"
  },
  State_118671_Name = {
    Text = "衰竭反制监听"
  },
  State_118672_Name = {
    Text = "新世界蛇头人意图监听冷却"
  },
  State_118741_Name = {
    Text = "清除临时触腕"
  },
  State_118743_Name = {
    Text = "预备召唤前置位需要召唤标记"
  },
  State_118759_Name = {
    Text = "怪物当前永久触腕数量"
  },
  State_118760_Name = {
    Text = "怪物永久触腕上限"
  },
  State_118762_Name = {
    Text = "首次腐朽提示语"
  },
  State_118763_Name = {
    Text = "首次神经毒素穿血提示语"
  },
  State_118764_Name = {
    Text = "首次咒怨吹息提示语"
  },
  State_118766_Name = {
    Text = "蓝环章鱼BOSS意图监听"
  },
  State_118769_Name = {
    Text = "银芯提灯提示语"
  },
  State_118771_Name = {
    Text = "首次试探提示语"
  },
  State_118772_Name = {
    Text = "首次群蛇撕裂提示语"
  },
  State_118935_Name = {
    Text = "怪物墨菲意图监听"
  },
  State_118938_Desc = {
    Text = "「深海淑女」已经觉醒，造成的护盾量大大提高！"
  },
  State_118938_Name = {
    Text = "受造之物"
  },
  State_118943_Desc = {
    Text = "自身回合受到的伤害翻倍。自身失去生命时，失去等量层数。层数为 0 时使触腕条数永久降低 1 条并重置层数，最低为 1 条。"
  },
  State_118943_Name = {
    Text = "神母的牺牲"
  },
  State_118973_Name = {
    Text = "隐忍的叛逆管理"
  },
  State_119051_Desc = {
    Text = "回合结束时触发，触发时受到等量层数的纯粹伤害并移除一半层数，无法驱散。"
  },
  State_119051_Name = {
    Text = "<PVPSacrificeKeyWords:献祭>"
  },
  State_119052_Desc = {
    Text = "受到主动伤害后获得伤害 [Layer]% 的献祭。"
  },
  State_119052_Name = {
    Text = "降生仪式"
  },
  State_119053_Desc = {
    Text = "回合结束时触发，触发时受到 [Layer] 点纯粹伤害并移除一半层数，无法驱散。"
  },
  State_119053_Name = {Text = "献祭"},
  State_119058_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，对最少献祭的敌方施加 [StateArg1] <PVPSacrificeKeyWords:献祭>，重复 [StateArg2] 次。全体友方不再受到<PVPCapKeywords:算力上限>减少效果影响。"
  },
  State_119058_Name = {
    Text = "黑暗中的安眠"
  },
  State_119059_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使全体敌方本回合受到主动伤害后获得伤害 [StateArg1]% 的献祭。"
  },
  State_119059_Name = {
    Text = "蓝环毒素"
  },
  State_119060_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [StateArg1]%，任意友方打出「打击」后抽 [StateArg3] 张牌，每回合最多触发 [StateArg2] 次（当前已触发 [DescArg1] 次）。"
  },
  State_119060_Name = {
    Text = "狂戮至世界尽头"
  },
  State_119061_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：全体友方「打击」伤害提高 [StateArg1]%。"
  },
  State_119061_Name = {
    Text = "理智明灯"
  },
  State_119063_Desc = {
    Text = "达到 5 层后，将意图更换为：「利莫里亚的荣光！」。"
  },
  State_119063_Name = {Text = "呼唤"},
  State_119075_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_119075_Name = {
    Text = "尚未觉醒"
  },
  State_119076_Desc = {
    Text = "若前排有空余位置，则在行动后失去 1 层，随机召唤 1 个「利莫里亚唤醒体」。"
  },
  State_119076_Name = {
    Text = "互助契约：利莫里亚"
  },
  State_119077_Desc = {
    Text = "「呼唤」达到 5 层后，立即封印所有唤醒体。"
  },
  State_119077_Name = {
    Text = "弥利亚姆觉醒！"
  },
  State_119077_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_119080_Desc = {
    Text = "释放「混沌记忆」或「未至遗忘的黎明」时，选择的钥令额外生效 1 次。"
  },
  State_119080_Name = {
    Text = "来自遗忘"
  },
  State_119082_Desc = {
    Text = "每次唤醒体释放狂气爆发后，其基础狂气提高 10 点。"
  },
  State_119082_Name = {
    Text = "狂气衰竭"
  },
  State_119083_Desc = {
    Text = "指令卡从超维空间取出时，算力消耗-1。"
  },
  State_119083_Name = {
    Text = "彼界终途"
  },
  State_119084_Desc = {
    Text = "每次释放钥令，使所需银钥能量提高 100 点。"
  },
  State_119084_Name = {
    Text = "银钥震荡"
  },
  State_119085_Desc = {
    Text = "使用猩红熔炉后，将 1 个胚胎变为圣洁之子，3 回合冷却。"
  },
  State_119085_Name = {
    Text = "猩红哺育"
  },
  State_119086_Desc = {
    Text = "繁育之力冷却中，剩余 [Layer] 回合。"
  },
  State_119086_Name = {
    Text = "繁育之力-冷却"
  },
  State_119104_Desc = {
    Text = "回合开始时获得 [DescArg1] 层「命契」。"
  },
  State_119104_Name = {
    Text = "海祭典仪"
  },
  State_119105_Desc = {
    Text = "死亡后失去所有「命契」。每层回复 1% 最大生命并使触腕伤害提高 1%。"
  },
  State_119105_Name = {Text = "命契"},
  State_119106_Name = {
    Text = "怪物诞妄墨菲意图监听"
  },
  State_119107_Name = {
    Text = "神国秩序管理"
  },
  State_119108_Desc = {
    Text = "失去生命时，每有 1 层获得失去生命 1% 的<SacrificeKeyWord:献祭>。"
  },
  State_119108_Name = {
    Text = "降生仪式"
  },
  State_119109_Desc = {
    Text = "受到来自<SacrificeKeyWord:献祭>以外的伤害时，失去等量「神国秩序」，并获得伤害 50% 的<SacrificeKeyWord:献祭>。层数为 0 时获得 1 层「命契」并重置层数。"
  },
  State_119109_Name = {
    Text = "神国秩序"
  },
  State_119132_Desc = {
    Text = "本回合「打击」伤害提高 [Layer]%。"
  },
  State_119132_Name = {
    Text = "打击强化"
  },
  State_119134_Name = {
    Text = "首次虚妄开创者提示语"
  },
  State_119359_Name = {
    Text = "银钥仪式计数"
  },
  State_119362_Name = {
    Text = "进行仪式"
  },
  State_119363_Name = {
    Text = "拥有卡牌"
  },
  State_119364_Name = {
    Text = "狂气仪式计数"
  },
  State_119365_Desc = {
    Text = "所有唤醒体造成的生命回复和护盾提高 40%。"
  },
  State_119365_Name = {
    Text = "镇定自若"
  },
  State_119366_Desc = {
    Text = "弃置后回到手中"
  },
  State_119366_Name = {
    Text = "弃置后回到手中"
  },
  State_119367_Name = {
    Text = "生命仪式计数"
  },
  State_119368_Desc = {
    Text = "每回合开始时获得 500 点银钥能量。"
  },
  State_119368_Name = {
    Text = "洞若观火"
  },
  State_119369_Desc = {
    Text = "所有唤醒体造成狂气提高 50%。"
  },
  State_119369_Name = {
    Text = "威重令行"
  },
  State_119370_Name = {Text = "造物"},
  State_119373_Name = {
    Text = "敌方施加献祭"
  },
  State_119567_Name = {
    Text = "完成仪式"
  },
  State_119568_Desc = {
    Text = "受到的打击伤害提高 [Layer] 点。"
  },
  State_119568_Name = {
    Text = "打击加深"
  },
  State_119583_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」前、「技能」前、「狂气爆发」前临时<StrongEffectKeywords:强效> +[StateArg1]，每回合各效果仅能触发一次。"
  },
  State_119583_Name = {
    Text = "你我终将重逢"
  },
  State_119588_Name = {Text = "血肉cd"},
  State_119589_Name = {Text = "超维cd"},
  State_119590_Desc = {
    Text = "队伍唯一：主动切换触腕姿态、使用猩红熔炉、释放「湮灭」后，抽 1 张装备者的指令卡，每个效果各 3 回合冷却。所有唤醒体探索所获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_119590_WeaponDesc = {
    Text = "主动切换触腕姿态(当前剩余 [DescArg1] 回合冷却)、使用猩红熔炉(当前剩余 [DescArg2] 回合冷却)、释放「湮灭」后(当前剩余 [DescArg3] 回合冷却)，抽 1 张装备者的指令卡，每个效果各 3 回合冷却。完成探索后，所有唤醒体获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_119591_Name = {Text = "深海cd"},
  State_119741_Desc = {
    Text = "所有唤醒体获得力量效果降低 50%。"
  },
  State_119741_Name = {
    Text = "圣像诅咒：衰亡之哀"
  },
  State_119742_Desc = {
    Text = "每回合开始时回复已损失生命的 15%。"
  },
  State_119742_Name = {
    Text = "圣像赐福：永恒之梦"
  },
  State_119743_Desc = {
    Text = "所有唤醒体生命回复降低 50%。"
  },
  State_119743_Name = {
    Text = "圣像诅咒：破灭之恨"
  },
  State_119744_Desc = {
    Text = "「圣像诅咒：破灭之恨」失效 1 回合。"
  },
  State_119744_Name = {
    Text = "免疫圣像诅咒：破灭之恨"
  },
  State_119746_Name = {
    Text = "深渊之锁失去次数"
  },
  State_119747_Desc = {
    Text = "不会受到伤害，持续 1 回合。"
  },
  State_119747_Name = {
    Text = "银钥，指引前路"
  },
  State_119748_Desc = {
    Text = "「圣像诅咒：衰亡之哀」失效 1 回合。"
  },
  State_119748_Name = {
    Text = "免疫圣像诅咒：衰亡之哀"
  },
  State_119749_Desc = {
    Text = "在守密人回合开始时对其等同于「<Abyssallock:梦境桎梏>」层数的手牌施加 1 层<SlowIconKeywords:迟缓>。"
  },
  State_119749_Name = {
    Text = "梦境桎梏"
  },
  State_119750_Name = {
    Text = "天之帷幕意图监听"
  },
  State_119751_Name = {
    Text = "帷幕重现释放标志"
  },
  State_119752_Desc = {
    Text = "每回合开始时获得最大生命的 5% 的<PowerIconKeywords:力量>，临时暴击率 +25%。"
  },
  State_119752_Name = {
    Text = "圣像赐福：威能之梦"
  },
  State_119753_Name = {
    Text = "黯淡海渊之潮计数"
  },
  State_119754_Desc = {
    Text = "所有唤醒体造成的狂气降低 50%。"
  },
  State_119754_Name = {
    Text = "圣像诅咒：痴愚之叹"
  },
  State_119755_Name = {
    Text = "死亡计数"
  },
  State_119756_Desc = {
    Text = "「圣像诅咒：痴愚之叹」失效 1 回合。"
  },
  State_119756_Name = {
    Text = "免疫圣像诅咒：痴愚之叹"
  },
  State_119757_Desc = {
    Text = "在守密人回合开始时对其等同于「<Abyssallock:梦境桎梏>」层数的手牌施加 1 层<SlowIconKeywords:迟缓>。每次「乐园帷幕」被主动伤害击破都会降低 1 层，并使击破的唤醒体「完全封印」 1 回合。"
  },
  State_119757_Name = {
    Text = "梦境桎梏"
  },
  State_119758_Desc = {
    Text = "每回合开始时所有唤醒体获得 10 点狂气。"
  },
  State_119758_Name = {
    Text = "圣像赐福：智识之梦"
  },
  State_119760_Name = {
    Text = "死亡监听"
  },
  State_119789_Desc = {
    Text = "回合开始时，回复 [Layer] 点生命。"
  },
  State_119789_Name = {
    Text = "淤泥之花"
  },
  State_119837_Desc = {
    Text = "拉蒙娜本回合打出的下一张指令卡生效 2 次。"
  },
  State_119837_Name = {
    Text = "再次牵手"
  },
  State_119847_Desc = {
    Text = "打出前改变卡牌算力。__「仅开发用」"
  },
  State_119847_Name = {
    Text = "打出前改变卡牌算力__「仅开发用」"
  },
  State_119928_Desc = {
    Text = "打出后额外生效 [StateArg1] 次，<DepleteIconKeywords:消耗>。<RippleKeywords:余波>：抽 2 张牌。"
  },
  State_119928_Name = {
    Text = "<Rune_20:渊海回声>"
  },
  State_119958_Desc = {
    Text = "死亡后立刻召唤一名随机的「鱼群」 ，使其「鱼潮洄游」降低 1 层。"
  },
  State_119958_Name = {
    Text = "鱼潮洄游"
  },
  State_119959_Desc = {
    Text = "死亡后立刻召唤一名随机的「胎群」 ，使其「生生不息」降低 1 层。"
  },
  State_119959_Name = {
    Text = "生生不息"
  },
  State_119960_Desc = {
    Text = "造成的主动和触腕伤害降低 35%，玩家当前生命高于 50%时清除。"
  },
  State_119960_Name = {
    Text = "<PurpleKeyWord:腐朽>"
  },
  State_120215_Desc = {
    Text = "在守密人回合开始时对其等同于「<Abyssallock:梦境桎梏>」层数的手牌施加 1 层<SlowIconKeywords:迟缓>。每次「乐园帷幕」被主动伤害击破都会降低 1 层，并使击破的唤醒体「完全封印」 1 回合。"
  },
  State_120215_Name = {
    Text = "深渊之锁"
  },
  State_120216_Desc = {
    Text = "在守密人回合开始时对其等同于「<Abyssallock:深渊之锁>」层数的手牌施加 1 层<SlowIconKeywords:迟缓>。"
  },
  State_120216_Name = {
    Text = "深渊之锁"
  },
  State_120218_Name = {
    Text = "回合结束选择墨菲支援"
  },
  State_120222_Name = {
    Text = "回合开始选择反转诅咒"
  },
  State_120292_Name = {
    Text = "不被接纳之痛"
  },
  State_120293_Desc = {
    Text = "回合结束时回复 [Layer] 点生命。"
  },
  State_120293_Name = {
    Text = "不被接纳之痛"
  },
  State_120312_Desc = {
    Text = "死亡后立刻召唤一名随机的「鱼王」 ，使其「鱼潮洄游」降低 1 层。"
  },
  State_120312_Name = {
    Text = "鱼潮洄游"
  },
  State_120320_Desc = {
    Text = "每层使下次「虚妄王女」施加的「降生仪式」提高 20％，最多叠加 5 层，叠加满 5 层后下次「虚妄王女」伤害次数翻倍。"
  },
  State_120320_Name = {Text = "命契"},
  State_120321_Desc = {
    Text = "每层使承受主动或触腕伤害时附加 1% 伤害的献祭，回合结束时移除，上限 75 层。"
  },
  State_120321_Name = {
    Text = "<DwmofeiKeywords:降生仪式>"
  },
  State_120322_Desc = {
    Text = "队伍唯一：手牌上限+2，无法和其他命轮提供的手牌上限叠加。装备者银钥充能、狂气爆发造成的最终伤害、护盾提高 <WeaponEffect_Num:[StateArg1]%>。切换「静海」姿态时，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气，3 回合冷却。切换「怒涛」姿态时，对所有敌人施加 <WeaponEffect_Num:[StateArg3]> 层<DwmofeiKeywords:降生仪式>，3 回合冷却。"
  },
  State_120322_WeaponDesc = {
    Text = "手牌上限+2，无法和其他命轮提供的手牌上限叠加。装备者银钥充能、狂气爆发造成的最终伤害、护盾提高 <WeaponEffect_Num:[StateArg1]%>。切换「静海」姿态时，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气，3 回合冷却。切换「怒涛」姿态时，对所有敌人施加 <WeaponEffect_Num:[StateArg3]> 层<DwmofeiKeywords:降生仪式>，3 回合冷却。"
  },
  State_120324_Desc = {
    Text = "承受主动或触腕伤害时附加 [Layer]% 伤害的献祭，回合结束时移除，至多叠加 75 层。"
  },
  State_120324_Name = {
    Text = "降生仪式"
  },
  State_120350_Desc = {Text = "——"},
  State_120350_WeaponDesc = {Text = "——"},
  State_120351_Desc = {
    Text = " [Layer] 回合后能够再次切换「神国·静海」。"
  },
  State_120351_Name = {
    Text = "神国·静海冷却"
  },
  State_120352_Desc = {Text = "——"},
  State_120352_WeaponDesc = {Text = "——"},
  State_120353_Desc = {Text = "——"},
  State_120354_Desc = {
    Text = " [Layer] 回合后能够再次切换「神国·怒涛」。"
  },
  State_120354_Name = {
    Text = "神国·怒涛冷却"
  },
  State_120357_Desc = {Text = "——"},
  State_120357_Name = {Text = "触腕"},
  State_120357_WeaponDesc = {Text = "——"},
  State_120362_Desc = {
    Text = "受到来自<SacrificeKeyWord:献祭>以外的伤害时，获得伤害 50% 的<SacrificeKeyWord:献祭>。"
  },
  State_120362_Name = {
    Text = "通用怪物献祭管理"
  },
  State_120363_Desc = {
    Text = "回合结束后受到 [Layer] 点伤害并减少 50%<SacrificeKeyWord:献祭>层数。"
  },
  State_120363_Name = {
    Text = "<BlueKeyWord:献祭>"
  },
  State_120364_Desc = {
    Text = "自身死亡后召唤「蹈海者近卫」。"
  },
  State_120364_Name = {
    Text = "信念长存"
  },
  State_120401_Desc = {
    Text = "此卡牌算力消耗 -[StateArg5]，打出后抽 [StateArg4] 牌。"
  },
  State_120401_Name = {
    Text = "<OrangeQuality:弥萨格徽章>"
  },
  State_120450_Name = {
    Text = "蓝环章鱼记录玩家生命"
  },
  State_120462_Desc = {
    Text = "战斗结束后仍然保留在牌库中，但打出或被消耗后将永久移除。"
  },
  State_120462_Name = {
    Text = "<DestructionKeywords:销毁>"
  },
  State_120900_Name = {
    Text = "预备召唤「利莫里亚唤醒体」计数"
  },
  State_120907_Desc = {
    Text = "触腕攻击时若被格挡，则造成 [DescArg1] 层<IntoxicationIconKeywords:中毒>。"
  },
  State_120907_Name = {Text = "暗流"},
  State_120908_Desc = {
    Text = "触腕攻击时若被格挡，则造成等量层数的<IntoxicationIconKeywords:中毒>。"
  },
  State_120908_Name = {Text = "暗流"},
  State_120910_Desc = {
    Text = "此卡牌算力消耗 +[StateArg5]，打出后抽 [StateArg4] 牌。"
  },
  State_120910_Name = {
    Text = "<OrangeQuality:弥萨格徽章>"
  },
  State_120924_Desc = {
    Text = "下回合开始时，获得加固。"
  },
  State_120924_Name = {
    Text = "延迟加固"
  },
  State_120929_Desc = {
    Text = "卡牌获得保留，但打出后会移除污染并召唤 1 个「深海分殖体」。若无位置召唤则会获得 1 层「预备召唤：深海分殖体」。"
  },
  State_120929_Name = {
    Text = "<SeastriderCurse:蹈海者咒怨>"
  },
  State_120930_Desc = {
    Text = "若有空余位置，则在行动后失去 1 层，召唤 1 个「深海分殖体」。"
  },
  State_120930_Name = {
    Text = "互助契约：深海分殖体"
  },
  State_120934_Desc = {
    Text = "每次受到暴击伤害，获得 3% 的<Baojidikang:临时暴击抵抗>。每回合开始时为 2 张卡牌附加「<SeastriderCurse:蹈海者咒怨>」。"
  },
  State_120934_Name = {
    Text = "深海祭礼"
  },
  State_120941_Desc = {
    Text = "会使敌人的技能得到增幅。每当受到伤害时失去一层。"
  },
  State_120941_Name = {Text = "血誓"},
  State_121006_Desc = {
    Text = "队伍唯一：装备者银钥充能、狂气爆发造成的最终伤害、护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_121006_WeaponDesc = {
    Text = "装备者银钥充能、狂气爆发造成的最终伤害、护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_121014_Name = {
    Text = "圣胎的回护"
  },
  State_121015_Desc = {
    Text = "回合开始时护盾不会清除。拥有护盾时拥有 50 层<ReinforcePVEKeywords:加固>，护盾被破除时移除<ReinforcePVEKeywords:加固>。"
  },
  State_121015_Name = {
    Text = "圣胎的回护"
  },
  State_121151_Desc = {
    Text = "卡牌获得保留，但打出后会移除污染并召唤 1 个「深海分殖体」。若无位置召唤则会获得 1 层「预备召唤：深海分殖体」。"
  },
  State_121151_Name = {
    Text = "<SeastriderCurse:蹈海者咒怨>"
  },
  State_121210_Name = {
    Text = "给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果>，生效 2 次"
  },
  State_121211_Name = {
    Text = "抽 2 张牌，获得 2 算力"
  },
  State_121212_Name = {
    Text = "给予全体友方正面<PVPWonderfulEffectKeywords:奇妙效果>，生效 2 次"
  },
  State_121213_Desc = {
    Text = "免疫一切伤害。"
  },
  State_121213_Name = {
    Text = "免疫一切伤害。"
  },
  State_121231_Desc = {
    Text = "每层使下次「虚妄王女」施加的「降生仪式」提高 20%，最多叠加 5 层，叠满 5 层后下次「虚妄王女」伤害次数翻倍。"
  },
  State_121231_Name = {
    Text = "<MingqiKeywords:命契>"
  },
  State_121365_Desc = {
    Text = "额外承受 [Layer]％ 触腕伤害。"
  },
  State_121377_Name = {
    Text = "<RetainIconKeywords:保留>：每回合开始时获得 500点银钥能量"
  },
  State_121378_Name = {
    Text = "<RetainIconKeywords:保留>：所有唤醒体造成的生命回复和护盾提高40%"
  },
  State_121380_Name = {
    Text = "<RetainIconKeywords:保留>：所有唤醒体造成狂气提高 50%"
  },
  State_121719_Name = {
    Text = "<RippleKeywords:余波>：抽 1 张牌，获得 [DescArg1] 点临时<PowerIconKeywords:力量>"
  },
  State_121734_Desc = {
    Text = "每打出 1 张指令卡，弃掉 1 张该唤醒体算力消耗最低的卡牌。"
  },
  State_121734_Name = {
    Text = "疯狂之奔流"
  },
  State_121735_Desc = {
    Text = "所有指令卡算力消耗提高 1。每 3 个回合，回合结束时将 1 张「渐渐石化」置入手中。"
  },
  State_121735_Name = {
    Text = "悲泣之奔流"
  },
  State_121736_Desc = {
    Text = "回合结束时，恢复 10% 已损生命值，解除自身负面状态和玩家的正面状态。"
  },
  State_121736_Name = {
    Text = "诞临之奔流"
  },
  State_121737_Desc = {
    Text = "战斗开始时，获得 15 层「临时屏障」。回合结束时，获得 15 层「临时屏障」，对随机 10 张卡牌附加「临时溶解」。"
  },
  State_121737_Name = {
    Text = "刺骨之奔流"
  },
  State_121738_Desc = {
    Text = "唤醒体施加的力量效果降低 75%。每当失去生命，获得 [DescArg1] 点护盾和 1 层临时加固。"
  },
  State_121738_Name = {
    Text = "邪信之奔流"
  },
  State_121739_Desc = {
    Text = "所有唤醒体的狂气上限提高 50%。每回合结束时，扣除所有唤醒体 10 点狂气，恢复自身 3％最大生命。"
  },
  State_121739_Name = {
    Text = "恐惧之奔流"
  },
  State_121740_Desc = {
    Text = "战斗开始及每回合结束时，获得 2 层临时<ResentChainsKeywords:怨恨锁链>。"
  },
  State_121740_Name = {
    Text = "诡谲之奔流"
  },
  State_121797_Desc = {
    Text = "造成的所有伤害、治疗与护盾效果降低 10%，上限 2 层，无法驱散，痴醉最后的施加者死亡后会移除被施加者的所有痴醉。"
  },
  State_121797_Name = {
    Text = "<PVPLostSoulKeyWords:痴醉>"
  },
  State_121798_Desc = {
    Text = "造成的伤害、治疗与护盾效果降低 [DescArg1]%，无法驱散。上限 2 层。\n击杀<StatusApplier:>后移除。"
  },
  State_121798_Name = {Text = "痴醉"},
  State_121799_Name = {
    Text = "第四章利莫里亚支援卡"
  },
  State_121850_Desc = {
    Text = "触腕伤害降低 80%"
  },
  State_121850_Name = {
    Text = "戈利亚·支援"
  },
  State_121863_Name = {
    Text = "<RippleKeywords:余波>：抽 2 张牌"
  },
  State_121878_Name = {
    Text = "首次选择反转诅咒剧情"
  },
  State_122428_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_122428_Name = {
    Text = "尚未觉醒"
  },
  State_122431_Desc = {
    Text = "茉夏造成未被格挡的伤害时，获得 2 层<Monster_Fervor:临时狂热>。"
  },
  State_122431_Name = {
    Text = "雾境遗脉"
  },
  State_122441_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 3 层<PVPReciprocalKeywords:倒数时刻>。"
  },
  State_122441_Name = {
    Text = "倒数时刻"
  },
  State_122442_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 <Block:[Block:StateArg1]> 护盾和 <Energy:[Energy:StateArg1]> 狂气。回合结束时该命轮自动解除装备，并使下次装备「盒中童趣」时获得的狂气和护盾提高 [StateArg2]。"
  },
  State_122442_Name = {
    Text = "盒中童趣"
  },
  State_122443_Desc = {
    Text = "回合开始时层数 - 1，层数耗尽后驱散自身负面状态并获得 100 狂气，然后重新获得 3 层倒数时刻。更换命轮将失去倒数时刻状态。"
  },
  State_122443_Name = {
    Text = "<PVPFlowerKeywords:倒数时刻>"
  },
  State_122596_Desc = {
    Text = "无法打出卡牌，无法释放狂气爆发。"
  },
  State_122596_Name = {
    Text = "<Seal1:封印>"
  },
  State_122636_Desc = {
    Text = "每回合首个打出的「技能」伤害、治疗与护盾提高 [StateArg1]% 。"
  },
  State_122636_Name = {
    Text = "红宝石胸针"
  },
  State_122650_Desc = {
    Text = "造物 <OrangeQuality:魔术手套> 添加了此卡。"
  },
  State_122650_Name = {
    Text = "奇怪的卡牌"
  },
  State_122654_Name = {
    Text = "每次回合开始和行动结束后会试图重置空的玩家牌库，若不为空则不重置。__「仅开发用」"
  },
  State_122706_Name = {
    Text = "<CardKeyWord:重逢心愿>"
  },
  State_122707_Desc = {
    Text = "视为本回合内上次打出的「技能」，算力消耗 -2，置于第二个抽牌堆的顶部。"
  },
  State_122707_Name = {
    Text = "<CardKeyWord:重逢心愿>"
  },
  State_123109_Desc = {
    Text = "队伍唯一：在「融痕」中首次购买「刻印」，或在「灰烬遗迹」中首次购买打折商品需要的黑印有 <WeaponEffect_Num:[StateArg1]%> 的机会变为 0，每场探索最多生效 1 次。"
  },
  State_123109_WeaponDesc = {
    Text = "在「融痕」中首次购买「刻印」，或在「灰烬遗迹」中首次购买打折商品需要的黑印有 <WeaponEffect_Num:[StateArg1]%> 的机会变为 0，每场探索最多生效 1 次。"
  },
  State_123177_Desc = {
    Text = "回合开始时清除。达到 10 层后，下次打出卡牌后，茉夏立刻行动，移除「临时狂热」并追加意图「人间爆破」。"
  },
  State_123177_Name = {
    Text = "临时狂热"
  },
  State_123178_Desc = {
    Text = "<Guaiwusiwangdikang: 死亡抵抗>的回复生命效果提高为 5 倍。敌方每使用 1 张卡牌，使自身获得 1 层<Monster_Fervor:临时狂热>。"
  },
  State_123178_Name = {Text = "起床气"},
  State_123243_Desc = {
    Text = "击杀敌方时移除全部层数并获得等量狂气。"
  },
  State_123243_Name = {Text = "涡流"},
  State_123246_Desc = {
    Text = "击杀敌方时移除所有层数并获得等量狂气。"
  },
  State_123246_Name = {
    Text = "<PVPWaterPowerKeyWords:涡流>"
  },
  State_123294_Desc = {
    Text = "本回合已通过「打击」抽 [DescArg1]张牌。"
  },
  State_123294_Name = {Text = "狂戮"},
  State_123507_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张「倒数时刻：5」加入牌库：打出后抽 1 张牌，并将下一张「倒数时刻」洗入弃牌堆。「<DestructionKeywords:销毁>」。「倒数时刻：0」：抽 3 张牌，获得 3 点算力，并有 <WeaponEffect_Num:[StateArg1]%> 概率将「倒数时刻：5」洗入弃牌堆。保留。「<DestructionKeywords:销毁>」。"
  },
  State_123507_WeaponDesc = {
    Text = "探索开始后，将 1 张「倒数时刻：5」加入牌库：打出后抽 1 张牌，并将下一张「倒数时刻」洗入弃牌堆。「<DestructionKeywords:销毁>」。「倒数时刻：0」：抽 3 张牌，获得 3 点算力，并有 <WeaponEffect_Num:[StateArg1]%> 概率将「倒数时刻：5」洗入弃牌堆。保留。「<DestructionKeywords:销毁>」。"
  },
  State_123520_Desc = {
    Text = "队伍唯一：每回合首次释放钥令后 <WeaponEffect_Num:[StateArg1]>% 概率抽 1 张装备者的「打击」。"
  },
  State_123520_WeaponDesc = {
    Text = "每回合首次释放钥令后 <WeaponEffect_Num:[StateArg1]>% 概率抽 1 张装备者的「打击」。"
  },
  State_123521_Desc = {
    Text = "队伍唯一：装备者狂气爆发和追击基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。 本回合打出任意唤醒体的「打击」后，装备者「打击」伤害临时提高装备者攻击力的 <WeaponEffect_Num:[StateArg2]%>，每回合最多生效 8 次。"
  },
  State_123521_WeaponDesc = {
    Text = "装备者狂气爆发和追击基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。 本回合打出任意唤醒体的「打击」后，装备者「打击」伤害临时提高 <WeaponEffect_Num:[DescArg2]>，每回合最多生效 8 次。"
  },
  State_123810_Desc = {
    Text = "将敌人当前意图替换为「无法行动」。"
  },
  State_123810_Name = {
    Text = "<HunmiKeywords:昏迷>"
  },
  State_123812_Desc = {
    Text = "回合结束时，算力消耗降低。"
  },
  State_123812_Name = {
    Text = "<PrepareKeywords:预备>"
  },
  State_123994_Desc = {
    Text = "无法进行任何行动。"
  },
  State_123994_Name = {
    Text = "精致睡眠"
  },
  State_124010_Desc = {
    Text = "下回合开始时，获得 [Layer] 算力。"
  },
  State_124010_Name = {
    Text = "延迟算力"
  },
  State_124024_Desc = {
    Text = "本回合已打出 [Layer] 张打击，触发过 [DescArg1] 次「戏剧性邂逅」。"
  },
  State_124024_Name = {
    Text = "戏剧性邂逅"
  },
  State_124034_Desc = {
    Text = "所有唤醒体「打击」伤害提高 [StateArg1]，持续 [Layer] 回合。"
  },
  State_124034_Name = {
    Text = "闪耀☆龙卷风"
  },
  State_124037_Desc = {
    Text = "茉夏伤害次数 +1，所有唤醒体「打击」伤害提高 [StateArg1]，持续 [Layer] 回合。"
  },
  State_124037_Name = {
    Text = "闪耀☆龙卷风"
  },
  State_124107_Desc = {
    Text = "「星之芽」死亡后，免疫所有伤害并觉醒，最大生命翻倍并获得等同于剩余生命的最大生命。觉醒后驱散所有负面状态。"
  },
  State_124107_Name = {
    Text = "尚未觉醒"
  },
  State_124108_Name = {
    Text = "界外之音计数"
  },
  State_124109_Desc = {
    Text = "自身获得的<RetaliateIconKeywords:反击>额外享受 5% <PowerIconKeywords:力量> 加成。 在单回合内失去 [DescArg1] 点生命后，和「歌者」交换位置"
  },
  State_124109_Name = {
    Text = "次生襁褓"
  },
  State_124111_Desc = {
    Text = "死亡抵抗回复生命提高为 25%。 敌方每打出 1 张指令卡，临时<TouquKeywords:偷取> [DescArg1] 点<PowerIconKeywords:力量> 。"
  },
  State_124111_Name = {
    Text = "无边星彩"
  },
  State_124112_Desc = {
    Text = "「歌者」死亡后，免疫所有伤害并觉醒，最大生命翻倍并获得等同于剩余生命的最大生命。"
  },
  State_124112_Name = {
    Text = "尚未觉醒"
  },
  State_124113_Desc = {
    Text = "对方回合结束不会丢弃手牌。 回合结束时依次施加 2 层<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重创>、<VulnerabilityIconKeywords:易伤>状态。"
  },
  State_124113_Name = {
    Text = "界外之音"
  },
  State_124115_Desc = {
    Text = "造成的<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重创>和 <WeaknessIconKeywords:虚弱>加深为 50%。 再打出 [DescArg1] 张<SlowIconKeywords:迟缓>卡牌后，和「星之芽」交换位置。"
  },
  State_124115_Name = {
    Text = "行星旅者"
  },
  State_124121_Name = {
    Text = "行星旅者计数"
  },
  State_124122_Name = {
    Text = "行星旅者玩家监听"
  },
  State_124190_Desc = {
    Text = "自身获得的<RetaliateIconKeywords:反击>额外享受 5% <PowerIconKeywords:力量> 加成。"
  },
  State_124190_Name = {
    Text = "次生襁褓"
  },
  State_124193_Name = {
    Text = "死亡抵抗回复生命提高为 25%。"
  },
  State_124198_Desc = {
    Text = "造成的<FragileIconKeywords: 脆弱>、<HeavyInjuryKeywords:重创>和 <WeaknessIconKeywords:虚弱>加深为 50%。"
  },
  State_124198_Name = {
    Text = "行星旅者"
  },
  State_124277_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124277_Name = {Text = "打印值2"},
  State_124278_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124278_Name = {Text = "打印值4"},
  State_124279_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124279_Name = {Text = "打印值5"},
  State_124280_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124280_Name = {Text = "打印值1"},
  State_124282_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124282_Name = {Text = "打印值7"},
  State_124283_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124283_Name = {Text = "打印值8"},
  State_124284_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124284_Name = {Text = "打印值9"},
  State_124285_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124285_Name = {
    Text = "打印值10"
  },
  State_124286_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124286_Name = {Text = "打印值6"},
  State_124287_Desc = {
    Text = "执行过程的中间值显化。"
  },
  State_124287_Name = {Text = "打印值3"},
  State_124736_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124736_Name = {
    Text = "监听测试1"
  },
  State_124747_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124747_Name = {
    Text = "监听测试2"
  },
  State_124748_Desc = {
    Text = "敌人打出<BurningKeywords:燃烧>卡牌时，使自身获得 1 层<MonsterExFlameKeywords:爆炎>，但临时降低 [DescArg1] <PowerIconKeywords:力量>。"
  },
  State_124748_Name = {
    Text = "不熄之焰"
  },
  State_124752_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124752_Name = {
    Text = "监听测试3"
  },
  State_124753_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124753_Name = {
    Text = "监听测试4"
  },
  State_124754_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124754_Name = {
    Text = "监听测试5"
  },
  State_124765_Desc = {
    Text = "暴击率提高 [Layer] % 。"
  },
  State_124765_Name = {Text = "暴击率"},
  State_124766_Desc = {
    Text = "本场战斗内暴击率提高 [Layer] %。"
  },
  State_124766_Name = {Text = "暴击率"},
  State_124766_WeaponDesc = {
    Text = "本场战斗内暴击率提高 [Layer] %。"
  },
  State_124767_Desc = {
    Text = "暴击伤害提高 [Layer] %。"
  },
  State_124767_Name = {
    Text = "暴击伤害"
  },
  State_124811_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124811_Name = {
    Text = "监听测试8"
  },
  State_124812_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124812_Name = {
    Text = "监听测试7"
  },
  State_124813_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124813_Name = {
    Text = "监听测试6"
  },
  State_124826_Desc = {
    Text = "验证 BEAttachPostAction 接口的参数3是否正确过滤或触发对应的触发器。"
  },
  State_124826_Name = {
    Text = "监听测试9"
  },
  State_124843_Desc = {
    Text = "验证触发器 BSTAfterAttachPostAction 和 BSTAfterDoActiveDamage.AttachPostAction 的监听"
  },
  State_124843_Name = {
    Text = "监听测试9"
  },
  State_124886_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：打出装备者的技能卡后，抽 [StateArg1] 张牌，优先抽取其他唤醒体的牌，每回合至多生效 1 次。"
  },
  State_124886_Name = {
    Text = "宿命纺轮"
  },
  State_124887_Desc = {
    Text = "该唤醒体的「纺织」伤害次数提升 [Layer]。"
  },
  State_124887_Name = {Text = "纺织"},
  State_124888_Desc = {
    Text = "每次打出卡牌后变化为敌方手中的随机「技能」，并使其算力消耗 -2。"
  },
  State_124888_Name = {
    Text = "<CardKeyWord:预言>"
  },
  State_124890_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身下 [StateArg1] 张打出的「技能」生效 2 次。"
  },
  State_124890_Name = {
    Text = "永世编织之网"
  },
  State_124892_Name = {
    Text = "<CardKeyWord:预言>"
  },
  State_124916_Desc = {
    Text = "回合结束移除所有层数并造成 [DescArg1] 纯粹伤害，无法驱散。"
  },
  State_124916_Name = {
    Text = "命定预兆"
  },
  State_124917_Desc = {
    Text = "回合结束移除所有层数并造成纯粹伤害，无法驱散。"
  },
  State_124917_Name = {
    Text = "<PVPDestinedDeathKeyWords:命定预兆>"
  },
  State_124992_Desc = {
    Text = "下 [DescArg1] 张「技能」打出 2 次。"
  },
  State_124992_Name = {Text = "双发"},
  State_124993_Desc = {
    Text = "造成和受到的致命主动伤害改为施加等量<PVPDestinedDeathKeyWords:命定预兆>，无法驱散。"
  },
  State_124993_Name = {
    Text = "命途，依此谕示"
  },
  State_124997_Desc = {
    Text = "造成和受到的致命主动伤害改为施加等量<PVPDestinedDeathKeyWords:命定预兆>。无法驱散。"
  },
  State_124997_Name = {
    Text = "<PVPEternalDimensionKeyWords:命途，依此谕示>"
  },
  State_125002_Name = {
    Text = "状态@通用玩家弃牌阶段后护盾值监听"
  },
  State_125003_Name = {Text = "护盾值"},
  State_125004_Name = {
    Text = "状态@通用施加玩家护盾计数"
  },
  State_125472_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对<HPAndShieldMax:生命与护盾最高>的敌方施加 [StateArg1] 层<PVPLostSoulKeyWords:痴醉>。"
  },
  State_125472_Name = {
    Text = "玉兰之饵"
  },
  State_125486_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方「狂气爆发」后，使手牌中装备者的所有「技能」算力消耗 - [StateArg1]。"
  },
  State_125486_Name = {Text = "枉蹙眉"},
  State_125925_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_125925_Name = {
    Text = "尚未觉醒"
  },
  State_125926_Name = {
    Text = "状态@怪物塔薇切换意图玩家监听"
  },
  State_125927_Desc = {
    Text = "再打出 [DescArg1] 张指令卡后，将意图切换为「六翼满开」。"
  },
  State_125927_Name = {
    Text = "四翼渐生"
  },
  State_125928_Desc = {
    Text = "打出指令卡后，封印对应唤醒体的狂气爆发和所有指令卡 2 回合。"
  },
  State_125928_Name = {
    Text = "纵贯时序之翼"
  },
  State_125929_Desc = {
    Text = "单回合内受到 [DescArg1] 点伤害后，获得 70 层临时<ReinforceColour:加固>和 1 层<ResentChainsKeywords: 怨恨锁链>。"
  },
  State_125929_Name = {
    Text = "不存在的存在"
  },
  State_125933_Desc = {
    Text = "再打出 [DescArg1] 张指令卡后，将意图切换为「四翼渐生」。"
  },
  State_125933_Name = {
    Text = "双翼初张"
  },
  State_125934_Desc = {
    Text = "消耗算力时，获得的银钥能量降低 50%。 塔微造成未被格挡的伤害后，将 1 张「<DerivativeCardKeywords_131:真·轮回悖论>」置入手中。"
  },
  State_125934_Name = {
    Text = "穿越银钥之门"
  },
  State_125935_Name = {Text = "沉默"},
  State_125935_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_125937_Desc = {
    Text = "打出指令卡后，封印对应唤醒体的狂气爆发和所有指令卡 2 回合。"
  },
  State_125937_Name = {
    Text = "纵贯时序之翼"
  },
  State_125964_Desc = {
    Text = "消耗算力时，获得的银钥能量降低 50%。 塔薇造成未被格挡的伤害后，将 1 张「<DerivativeCardKeywords_131:真·轮回悖论>」置入手中。"
  },
  State_125964_Name = {
    Text = "穿越银钥之门"
  },
  State_126010_Desc = {
    Text = "队伍唯一：装备者造成的固定中毒和触发中毒效果提高 <WeaponEffect_Num:[StateArg1]%>，血肉界域自动回复的<EmbryoFusionIconKeywords:胚胎融合>提高 <WeaponEffect_Num:[StateArg2]%>。装备者每回合首次触发「共振」时其他唤醒体获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_126010_WeaponDesc = {
    Text = "装备者造成的固定中毒和触发中毒效果提高 <WeaponEffect_Num:[StateArg1]%>，血肉界域自动回复的<EmbryoFusionIconKeywords:胚胎融合>提高 <WeaponEffect_Num:[StateArg2]%>。装备者每回合首次触发「共振」时其他唤醒体获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_126463_Name = {
    Text = "状态@怪物莉兹诱蛾之火受伤监听"
  },
  State_126464_Desc = {
    Text = "上限 10 层，每层使莉兹造成的伤害提高 [DescArg1] 点。"
  },
  State_126464_Name = {
    Text = "<GreenWord:翠绿火种>"
  },
  State_126465_Name = {
    Text = "怪物莉兹意图监听"
  },
  State_126466_Desc = {
    Text = "对方回合结束不会丢弃手牌。当意图切换为绿炎时，若拥有至少 6 层<MonsterLizVerdantSpark:翠绿火种>，消耗 6 层，将意图升级为造成 <Damage:[Damage:DescArg1]> 伤害 [AttackTimes:DescArg2] 次的「死灭绿炎」；若拥有至少 3 层，消耗 3 层，将意图升级为造成 <Damage:[Damage:DescArg3]> 伤害 [AttackTimes:DescArg4] 次的「腐化绿炎」。"
  },
  State_126466_Name = {
    Text = "不朽绿炎"
  },
  State_126467_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗，并为「告死之舞」赋予解除负面状态的能力。"
  },
  State_126467_Name = {
    Text = "尚未觉醒"
  },
  State_126468_Name = {
    Text = "状态@怪物莉兹翡翠映像管理"
  },
  State_126469_Desc = {
    Text = "每失去 [DescArg1] 点生命获得 [DescArg2] 层<MonsterLizVerdantSpark:翠绿火种>。"
  },
  State_126469_Name = {
    Text = "翡翠映像"
  },
  State_126470_Name = {
    Text = "状态@怪物莉兹提示语计数"
  },
  State_126479_Desc = {
    Text = "上限 10 层，使莉兹造成的伤害提高。"
  },
  State_126479_Name = {
    Text = "<GreenWord:翠绿火种>"
  },
  State_126540_Desc = {
    Text = "徐下 [Layer] 次触发「共振」时「共振」效果翻倍。"
  },
  State_126540_Name = {
    Text = "夜雾下的情誓"
  },
  State_126568_Desc = {
    Text = "唤醒体每次造成主动伤害，号令 1 条触腕攻击目标造成 [Layer]％ 触腕伤害。"
  },
  State_126568_Name = {
    Text = "怒海狂澜"
  },
  State_126569_Desc = {
    Text = "唤醒体每次造成主动伤害，号令 1 条触腕攻击目标造成 50％ 触腕伤害。"
  },
  State_126569_Name = {
    Text = "怒海狂澜"
  },
  State_126643_Desc = {
    Text = "本状态 MaxLayer=1。来源唤醒体：[DescArg1]"
  },
  State_126643_Name = {Text = "限额1层"},
  State_126644_Desc = {
    Text = "获得后，清除并重新添加 [Layer] 层演示状态。\n演示状态的最大层数为1层。"
  },
  State_126644_Name = {
    Text = "突破最大层数"
  },
  State_126645_Desc = {
    Text = "拉蒙娜造成的基础伤害提高 [DescArg1]%"
  },
  State_126645_Name = {
    Text = "至臻的淬炼"
  },
  State_126651_Desc = {
    Text = "释放追击后的监听已满足 [Layer] 次。"
  },
  State_126651_Name = {Text = "计数器"},
  State_126652_Desc = {
    Text = "获得后，令前排敌方追加后置行动，打出其当前意图。"
  },
  State_126652_Name = {
    Text = "令怪物追击"
  },
  State_126653_Desc = {
    Text = "获得后，令站位为1的唤醒体追加后置行动，打出其打击卡。"
  },
  State_126653_Name = {
    Text = "令唤醒体追击"
  },
  State_126654_Desc = {
    Text = "指名监听被触发时，打印1次计数。"
  },
  State_126654_Name = {
    Text = "指名监听"
  },
  State_126655_Desc = {
    Text = "获得后，令守密人追加后置行动，打出 技能@主角技能@脑中之音。"
  },
  State_126655_Name = {
    Text = "令守密人追击"
  },
  State_126677_Desc = {
    Text = "本回合下 [Layer] 张「桀骜之刃」生效 2 次。"
  },
  State_126677_Name = {
    Text = "亘古的鲸鸣"
  },
  State_126678_WeaponDesc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_126714_Desc = {
    Text = "艾继丝的下 [Layer] 张「防御」生效 3 次。"
  },
  State_126714_Name = {
    Text = "凝刻的眼泪"
  },
  State_126714_WeaponDesc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_126715_WeaponDesc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_126776_Desc = {
    Text = "每拥有 1 层承受的固定中毒提高 5％，造成伤害降低 [DescArg1]％，最大 [DescArg2] 层。"
  },
  State_126776_Name = {
    Text = "<WitherKeywords:痴醉>"
  },
  State_126783_Name = {
    Text = "暂时废弃了"
  },
  State_126784_Desc = {
    Text = "承受的固定中毒提高 [DescArg1]％，造成伤害降低 [DescArg2]％，最大 [DescArg3] 层。"
  },
  State_126784_Name = {Text = "痴醉"},
  State_126785_Desc = {
    Text = "若其他唤醒体已累积打出 X 张指令卡，打出后触发后续效果。打出自身指令卡或回合结束后重置自身共振计数。"
  },
  State_126785_Name = {
    Text = "<ResonanceKeywords:共振X>"
  },
  State_126789_Desc = {
    Text = "对所有敌人施加 2 层<WitherKeywords:痴醉>。"
  },
  State_126789_Name = {
    Text = "<WitherKeywords1:相许>"
  },
  State_126790_Desc = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层造成 [DescArg1]％ 目标最大生命的<FixedDamage:纯粹伤害>并触发其 40% 中毒。"
  },
  State_126790_Name = {
    Text = "<WitherKeywords2:夺魄>"
  },
  State_126803_Desc = {
    Text = "接下来打出的 [DescArg1] 张指令卡会被送往 3 回合后的未来。"
  },
  State_126803_Name = {
    Text = "命运纺轮"
  },
  State_126893_Name = {
    Text = "状态@命运超维至纯标识"
  },
  State_126895_Desc = {
    Text = "此卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击的最终效果提高 [DescArg1]%，造成的固定护盾、固定生命回复、力量降低效果提高 [DescArg2]％。拥有「奇点信标」的卡牌无法再复制进「超维空间」。"
  },
  State_126895_Name = {
    Text = "<SingularityKeywords:奇点信标 [DescArg2]>"
  },
  State_126896_Name = {
    Text = "状态@超越之光卡牌减少算力调和层数"
  },
  State_126900_Name = {
    Text = "状态@命运超维职业初始化2"
  },
  State_126901_Name = {
    Text = "状态@命运超维职业初始化1"
  },
  State_126903_Name = {
    Text = "状态@超维空间超距标记"
  },
  State_126927_Desc = {
    Text = "队伍唯一：装备者造成的固定中毒和触发中毒效果提高 <WeaponEffect_Num:[StateArg1]%>。装备者每回合首次触发「共振」时获得 <WeaponEffect_Num:[StateArg2]> 点狂气。"
  },
  State_126927_WeaponDesc = {
    Text = "装备者造成的固定中毒和触发中毒效果提高 <WeaponEffect_Num:[StateArg1]%>。装备者每回合首次触发「共振」时获得 <WeaponEffect_Num:[StateArg2]> 点狂气。"
  },
  State_126990_Name = {
    Text = "<IntoxicationColour:中毒>"
  },
  State_127108_Desc = {
    Text = "对所有敌人施加 5 层<WitherKeywords:痴醉>。"
  },
  State_127108_Name = {
    Text = "<WitherKeywords3:相许>"
  },
  State_127109_Desc = {
    Text = "移除所有敌人的<WitherKeywords:痴醉>，每移除 1 层积攒 20％ 体质的猩红熔炉、造成 [DescArg1]％ 目标最大生命的<FixedDamage:纯粹伤害>并触发其 40% 中毒。"
  },
  State_127109_Name = {
    Text = "<WitherKeywords4:夺魄>"
  },
  State_127176_Desc = {
    Text = "每拥有 1 层承受的固定中毒提高 5％，造成伤害降低 [DescArg1]％，最大 [DescArg2] 层。"
  },
  State_127176_Name = {
    Text = "<WitherKeywords0:痴醉>"
  },
  State_127264_Desc = {
    Text = "打出此卡牌时，「觉者」获得 1 层 <MonsterTimeBeacon:回环>。若弃置此卡牌，「觉者」失去 1 层 <MonsterTimeBeacon:回环>。"
  },
  State_127264_Name = {
    Text = "<MonsterSightUnbound:超越之目>"
  },
  State_127266_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_127266_Name = {
    Text = "尚未觉醒"
  },
  State_127267_Desc = {
    Text = "回合结束后，获得 1 层 <MonsterTimeBeacon:回环>。"
  },
  State_127267_Name = {
    Text = "熵增逆转"
  },
  State_127271_Desc = {
    Text = "释放钥令后，自身获得 1 层 <MonsterTimeBeacon:回环>。"
  },
  State_127271_Name = {
    Text = "莫比乌斯囚徒"
  },
  State_127272_Desc = {
    Text = "上限 3 层。「觉者」释放意图时若拥有 3 层 <MonsterTimeBeacon:回环>，触发 <MonsterTimeBeacon:回环>效果，清空 <MonsterTimeBeacon:回环>并清除负面状态。"
  },
  State_127272_Name = {
    Text = "<WhiteWord:回环>"
  },
  State_127275_Desc = {
    Text = "每拥有 1 层承受的固定中毒提高 5％，造成伤害降低 [DescArg1]％，最大 [DescArg2] 层。"
  },
  State_127275_Name = {
    Text = "<WitherKeywords:痴醉>"
  },
  State_127276_Desc = {
    Text = "打出此卡牌时，「觉者」获得 1 层 <MonsterTimeBeacon:回环>。若弃置此卡牌，「觉者」失去 1 层 <MonsterTimeBeacon:回环>。"
  },
  State_127276_Name = {
    Text = "<MonsterSightUnbound:超越之目>"
  },
  State_127312_Desc = {
    Text = "唤醒体人格深化达到 +12 时会激活「最终法则」，激活后可获得一些独特的效果。"
  },
  State_127312_Name = {
    Text = "<UltraPotencyKeywords:最终法则>"
  },
  State_127705_Desc = {
    Text = "卡牌被做了手脚！打出后受到 [Layer] 点伤害，并使<CardKeyWord:暗中破坏>层数减半。"
  },
  State_127705_Name = {
    Text = "<CardKeyWord:暗中破坏>"
  },
  State_127705_WeaponDesc = {
    Text = "卡牌打出后受到 [StateArg1] 点伤害。"
  },
  State_127708_Desc = {
    Text = "敌方打出非指令卡后，所有友方获得 [DescArg1] 层<PowerIconKeywords:力量>。旧日余烬被击破后失效。"
  },
  State_127708_Name = {Text = "乱之丝"},
  State_127709_Name = {
    Text = "黑之丝玩家状态"
  },
  State_127710_Name = {
    Text = "黑之丝触发"
  },
  State_128026_Name = {
    Text = "白之丝玩家状态"
  },
  State_128027_Desc = {
    Text = "敌方打出指令卡后，所有友方获得 [DescArg1] 层临时<ReinforcePVEKeywords:加固>。旧日余烬被击破后失效。"
  },
  State_128027_Name = {Text = "律之丝"},
  State_128028_Desc = {
    Text = "卡牌被做了手脚！打出后受到<FixedDamage:纯粹伤害>，并使<BrokenCard:暗中破坏>层数减半。"
  },
  State_128028_Name = {
    Text = "<CardKeyWord:暗中破坏>"
  },
  State_128028_WeaponDesc = {
    Text = "卡牌打出后受到 [StateArg1] 点伤害。"
  },
  State_128029_Name = {
    Text = "白之丝触发"
  },
  State_128067_Name = {
    Text = "状态@冷蛛侍女余烬监听"
  },
  State_128069_Name = {
    Text = "状态@冷蛛侍女缠绕命中检测"
  },
  State_128071_Name = {
    Text = "状态@冷蛛侍女前置位需要召唤标记"
  },
  State_128073_Desc = {
    Text = "每次行动结束后都会获得 [DescArg1] 层<ParcloseIconKeywords:屏障>和 [DescArg2] 层<Chapter5_Monster_Fervor1:狂热>。"
  },
  State_128073_Name = {
    Text = "织母的摇篮"
  },
  State_128082_Desc = {
    Text = "打出后哈姆林获得 3 点狂气。"
  },
  State_128082_Name = {
    Text = "<XushiBKeywords:蓄势乐音>"
  },
  State_128086_Desc = {
    Text = "敌方打出指令卡后，自身获得 [DescArg1] 层<Chapter5_Monster_Fervor1:狂热>，击破「旧日余烬」后与后列友方交换位置。"
  },
  State_128086_Name = {
    Text = "宿命轮转"
  },
  State_128087_Name = {
    Text = "状态@冷蛛侍女白之轮回触发标记"
  },
  State_128089_Name = {
    Text = "白之轮回触发"
  },
  State_128216_Name = {
    Text = "白之轮回玩家状态"
  },
  State_128245_Desc = {
    Text = "回合开始后清除，达到 10 层后，下次打出卡牌后立刻行动，移除<Chapter5_Monster_Fervor2:狂热>并将意图切换为施加<FragileIconKeywords: 脆弱>并随机附加<BrokenCard:暗中破坏>的「崩解之丝」。"
  },
  State_128245_Name = {
    Text = "临时狂热"
  },
  State_128246_Name = {
    Text = "黑之轮回玩家状态"
  },
  State_128247_Desc = {
    Text = "死亡后复活，免疫伤害并拥有 100% 生命。将意图切换为「命定的狂热」：每次行动结束后都会获得 [DescArg1] 点<PowerIconKeywords:力量>和 [DescArg2] 层<Chapter5_Monster_Fervor2:狂热>。"
  },
  State_128247_Name = {
    Text = "破茧新生"
  },
  State_128248_Desc = {
    Text = "回合开始后清除，达到 10 层后，下次打出卡牌后立刻行动，移除<Chapter5_Monster_Fervor1:狂热>并将意图切换为施加<WeaknessIconKeywords:虚弱>并随机封印指令卡的「束缚之网」。"
  },
  State_128248_Name = {
    Text = "临时狂热"
  },
  State_128250_Name = {
    Text = "黑之轮回触发"
  },
  State_128251_Desc = {
    Text = "敌方打出非指令卡后，自身获得 [DescArg1] 层<Chapter5_Monster_Fervor2:狂热>，击破「旧日余烬」后与后列友方交换位置。"
  },
  State_128251_Name = {
    Text = "渊狱轮转"
  },
  State_128253_Desc = {
    Text = "死亡后复活，免疫伤害并拥有 100% 生命。将意图切换为「命定的狂热」：每次行动结束后都会获得 [DescArg1] 层<ParcloseIconKeywords:屏障>和 [DescArg2] 层<Chapter5_Monster_Fervor1:狂热>。"
  },
  State_128253_Name = {
    Text = "破茧新生"
  },
  State_128257_Desc = {
    Text = "每次行动结束后都会获得 [DescArg1] 点<PowerIconKeywords:力量>和 [DescArg2] 层<Chapter5_Monster_Fervor2:狂热>。"
  },
  State_128257_Name = {
    Text = "织母的低语"
  },
  State_128643_Name = {
    Text = "状态@玩家本回合打出症状计数"
  },
  State_128644_Desc = {
    Text = "回合开始时清除。达到 10 层后，下次打出卡牌后立刻行动，移除<Chapter5_Monster_Fervor3:狂热>并随机切换意图。"
  },
  State_128644_Name = {
    Text = "临时狂热"
  },
  State_128645_Desc = {
    Text = "意图会从四种意图中随机，但不会重复。释放狂气爆发后立刻切换意图。打出指令卡后获得 1 层<Chapter5_Monster_Fervor3:狂热>。"
  },
  State_128645_Name = {
    Text = "万面同调"
  },
  State_128646_Name = {
    Text = "状态@错乱的命运失格重击出牌检测"
  },
  State_128648_Desc = {
    Text = "直到下回合开始时，每打出 1 张指令卡就获得 [DescArg1] 的临时<PowerIconKeywords:力量>。"
  },
  State_128648_Name = {
    Text = "暴怒之茧"
  },
  State_128692_Desc = {
    Text = "承受主动伤害或触腕伤害后，移除等量的「旧日余烬」并失去 300% 移除量的生命，承受其它伤害时移除一半。「旧日余烬」层数每回合重置。"
  },
  State_128692_Name = {
    Text = "<AshesPastKeyWord:旧日余烬>"
  },
  State_128695_Name = {
    Text = "状态@错乱的命运意图标记"
  },
  State_129297_Desc = {
    Text = "下 [Layer] 场战斗开始时使所有敌人生命为 1。"
  },
  State_129297_Name = {
    Text = "小「N」的协助"
  },
  State_129569_Name = {
    Text = "状态@错乱的命运欢愉剧场触发标记"
  },
  State_129570_Name = {
    Text = "状态@错乱的命运宿命低语触发标记"
  },
  State_129571_Name = {
    Text = "状态@错乱的命运无尽虚无触发标记"
  },
  State_129612_Desc = {
    Text = "意图会从四种意图中随机，但不会重复。释放狂气爆发后立刻切换意图。打出指令卡后获得 1 层<Chapter5_Monster_Fervor3:狂热>。"
  },
  State_129612_Name = {
    Text = "万面同调"
  },
  State_129625_Desc = {
    Text = "意图会从四种意图中随机，但不会重复。释放狂气爆发后立刻切换意图。打出指令卡后获得 1 层<Chapter5_Monster_Fervor3:狂热>。每次切换意图获得 1 层「错乱命途」。"
  },
  State_129625_Name = {
    Text = "万面同调"
  },
  State_129643_Desc = {
    Text = "每次切换意图时获得 1 层，当拥有 10 层「错乱命途」时，意图调整为无法切换并造成大量伤害与削弱的「破茧狂宴」。"
  },
  State_129643_Name = {
    Text = "错乱命途"
  },
  State_129644_Name = {
    Text = "扭曲融合锁定意图"
  },
  State_129650_Desc = {
    Text = "队伍唯一：若装备者为唤醒体「环行·拉蒙娜」，其他唤醒体探索关卡所获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>，但自身不获得同调率。"
  },
  State_129650_WeaponDesc = {
    Text = "若装备者为唤醒体「环行·拉蒙娜」，完成关卡时其他唤醒体获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>，但自身不获得同调率。"
  },
  State_129761_Desc = {
    Text = "修改接口 玩家局内成长强度 的返回值，每 1 层提高 1%。"
  },
  State_129761_Name = {
    Text = "局内成长强度修正"
  },
  State_129845_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_129845_Name = {
    Text = "尚未觉醒"
  },
  State_129846_Name = {
    Text = "断丝震鸣计数"
  },
  State_129848_Desc = {
    Text = "每当 [DescArg1] 张卡牌离开维度裂隙时为其赋予 [DescArg2] 层<BrokenCard:暗中破坏>。"
  },
  State_129848_Name = {
    Text = "木偶戏场揭幕"
  },
  State_129849_Desc = {
    Text = "生成每回合敌方打出的首张指令卡的复制置入维度裂隙。当卡牌进入维度裂隙时，为其赋予<DepleteIconKeywords:消耗>。 每回合首次释放钥令会将最左侧的卡牌取出并置入抽牌堆顶部。"
  },
  State_129849_Name = {
    Text = "拨弄命运之丝"
  },
  State_129850_Desc = {
    Text = "维度裂隙中每有一张指令卡，玩家手牌上限减少 1。 若其中已满，下次打出卡牌时，「永恒之网」立刻行动，行动后清空维度裂隙，将意图调整为「凌驾命运的悲歌」。"
  },
  State_129850_Name = {
    Text = "断丝震鸣"
  },
  State_129854_Desc = {
    Text = "维度裂隙中每有一张指令卡，玩家手牌上限减少 1。 若其中已满，下次打出卡牌时，「永恒之网」立刻行动，行动后清空维度裂隙，将意图调整为「命途，依此谕示」。"
  },
  State_129854_Name = {
    Text = "断丝震鸣"
  },
  State_129864_Desc = {
    Text = "每当打出卡牌后移除 1 层「困意」。回合开始时回复到 12 层「困意」。"
  },
  State_129864_Name = {Text = "震怒"},
  State_129865_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_129865_Name = {
    Text = "尚未觉醒"
  },
  State_129872_Desc = {
    Text = "临时变量。"
  },
  State_129872_Name = {Text = "计数器1"},
  State_129873_Desc = {
    Text = "获得 [Layer] 层计数状态 _封装计数器1_。"
  },
  State_129873_Name = {
    Text = "封装测试1"
  },
  State_129874_Desc = {
    Text = "临时变量。"
  },
  State_129874_Name = {Text = "放大器1"},
  State_130358_Desc = {
    Text = "下张打出的指令卡额外生效 2 次。"
  },
  State_130358_Name = {
    Text = "提线木偶"
  },
  State_130387_Desc = {
    Text = "「提线木偶」被消耗后，之后每回合打出的第一张指令卡额外生效 2 次。若为首领战，所有唤醒体获得 50 点狂气，获得 1000 点银钥能量。"
  },
  State_130387_Name = {
    Text = "命运的葬礼"
  },
  State_130388_Name = {
    Text = "<RetainIconKeywords:保留>：获得 [DescArg1] 银钥能量"
  },
  State_130389_Desc = {
    Text = "打出后使所有唤醒体获得 [DescArg1] 点狂气"
  },
  State_130389_Name = {
    Text = "打出后使所有唤醒体获得 [DescArg1] 点狂气"
  },
  State_130390_Desc = {
    Text = "算力上限和手牌上限提高 1。"
  },
  State_130390_Name = {
    Text = "冗余的侧写"
  },
  State_130391_Desc = {
    Text = "每打出 1 张「症状卡」，「提线木偶」算力消耗降低 1。"
  },
  State_130391_Name = {
    Text = "污秽的余响"
  },
  State_130490_Desc = {
    Text = "本卡牌造成的伤害、护盾、治疗、力量、衰竭、触腕伤害、固定中毒、固定反击提高，独立乘算 1+[Layer]%。"
  },
  State_130490_Name = {
    Text = "奇点信标α"
  },
  State_130498_Desc = {
    Text = "下张打出的指令卡额外生效 2 次。"
  },
  State_130498_Name = {
    Text = "命运的葬礼"
  },
  State_130500_Desc = {
    Text = "首领战中死亡抵抗 +100%。触发「死亡抵抗」后下回合「提线木偶」不再强制打出指令卡，改为选择一张手中指令卡。"
  },
  State_130500_Name = {
    Text = "殉难者的回眸"
  },
  State_130501_Desc = {
    Text = "下张指令卡算力消耗降低为 0。"
  },
  State_130501_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_130512_Desc = {
    Text = "下张打出的指令卡额外生效 2 次且算力消耗降低 2 点。"
  },
  State_130512_Name = {
    Text = "提线木偶"
  },
  State_130517_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，随机触发以下效果中的一个：获得 <Energy:[Energy:StateArg1]> 狂气并<PVPSlowKeywords:迟缓>自身；获得 <Energy:[Energy:StateArg3]> 狂气；获得 <Energy:[Energy:StateArg4]> 和 [StateArg5] 张<PVPDerivativeCardKeywords_17:「灵感」>。"
  },
  State_130517_Name = {
    Text = "豪赌的智慧"
  },
  State_131046_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Block:[Block:StateArg1]> 护盾和<DelayKeywords:延迟 1>：<Energy:[Energy:StateArg2]> 狂气。"
  },
  State_131046_Name = {
    Text = "渺远的伊甸园"
  },
  State_131047_Desc = {
    Text = "本回合中下 [Layer] 次使用钥令将生效 2 次。"
  },
  State_131047_Name = {
    Text = "双发钥令"
  },
  State_131048_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次打出「技能」后对<HPAndShieldMin:生命与护盾最低>的敌方造成 <Damage:[Damage:StateArg1]> 伤害。"
  },
  State_131048_Name = {
    Text = "被囚禁的疯狂"
  },
  State_131055_Desc = {
    Text = "每回合抽牌数 -1。所有唤醒体造成护盾和回复生命提高 20%。"
  },
  State_131055_Name = {
    Text = "捋顺毛发"
  },
  State_131056_Desc = {
    Text = "失去生命后将等量延迟狂气转化为护盾。"
  },
  State_131056_Name = {
    Text = "漩流护身"
  },
  State_131058_Desc = {
    Text = "所有唤醒体基础狂气提高 10 点。释放狂气爆发后获得 1 算力，每个唤醒体 1 回合只能触发 1 次。"
  },
  State_131058_Name = {
    Text = "蹭蹭脸颊"
  },
  State_131059_Name = {
    Text = "莫丝大招升级标记"
  },
  State_131061_Desc = {
    Text = "银钥能量上限及钥令消耗银钥能量 +350。每回合首次钥令生效 2 次。"
  },
  State_131061_Name = {
    Text = "投喂零食"
  },
  State_131064_Desc = {
    Text = "释放狂气爆发后获得 1 算力，每个唤醒体 1 回合只能触发 1 次。"
  },
  State_131064_Name = {
    Text = "蹭蹭脸颊"
  },
  State_131069_Desc = {
    Text = "所有唤醒体造成护盾和回复生命提高 20%。"
  },
  State_131069_Name = {
    Text = "捋顺毛发"
  },
  State_131073_Desc = {
    Text = "队伍唯一：战斗开始时获得等同于 <WeaponEffect_Num:[StateArg1]%> 基础狂气的狂气。装备者狂气爆发最终伤害提高，其百分比为基础狂气的 <WeaponEffect_Num:[StateArg2]%>。切换至「怒涛」姿态时，获得等同于当前界域精通 <WeaponEffect_Num:[StateArg3]%> 的临时界域精通，3 回合冷却。"
  },
  State_131073_WeaponDesc = {
    Text = "战斗开始时获得 [DescArg1] 点狂气。装备者狂气爆发最终伤害提高 [DescArg2]％。切换至「怒涛」姿态时，获得 [DescArg3] 点临时界域精通，3 回合冷却(当前剩余 [DescArg4] 回合)。"
  },
  State_131078_Desc = {
    Text = "每回合首次钥令生效 2 次。"
  },
  State_131078_Name = {
    Text = "投喂零食"
  },
  State_131118_Desc = {
    Text = "每次受到伤害或失去生命时，无法超过最大生命的 3%。"
  },
  State_131118_Name = {
    Text = "千丝之茧"
  },
  State_131123_Desc = {
    Text = "回合开始时清除。达到 10 层后，下次打出卡牌后立刻行动并切换至下一个意图，移除<Chapter5_Monster_Fervor4:狂热>。"
  },
  State_131123_Name = {
    Text = "临时狂热"
  },
  State_131127_Desc = {
    Text = "受到命运束缚的姿态。对手每打出 1 张「指令卡」，自身获得 1 层「临时狂热」。"
  },
  State_131127_Name = {
    Text = "缚誓契约"
  },
  State_131134_Desc = {
    Text = "死亡后，涅芙蕾亚获得 [DescArg1] 层临时狂热，但失去 3% 最大生命。"
  },
  State_131134_Name = {
    Text = "渊狱之门"
  },
  State_131186_Desc = {
    Text = "打出后额外生效 1 次，但受到 [DescArg1] 点伤害。"
  },
  State_131186_Name = {
    Text = "<ExclamationPointColour:命运残碎>"
  },
  State_131188_Desc = {
    Text = "打出的「技能」进入「维度裂隙」并为所有同名的技能附加「命运残碎」，离开维度裂隙后清除。维度裂隙满时，「背弃之网」涅芙蕾亚行动后清空维度裂隙，将下个意图转变为强力的狂气爆发。"
  },
  State_131188_Name = {
    Text = "维度裂隙"
  },
  State_131191_Name = {
    Text = "认知障碍"
  },
  State_131242_Desc = {
    Text = "本卡牌造成的伤害、护盾、治疗、力量、衰竭、触腕伤害、固定中毒、固定反击提高，独立乘算 1+[Layer]%。"
  },
  State_131242_Name = {
    Text = "奇点信标β"
  },
  State_131258_Desc = {
    Text = "转动纺轮的丝线，扰动错误的命运。释放钥令或打出「命运残碎」卡牌后移除 1 层，全部移除后阿拉克涅释放「命缕各安其位」追击，造成高额伤害。释放 3 次后将使敌方的「千丝之茧」彻底破碎！"
  },
  State_131258_Name = {
    Text = "命网扰动"
  },
  State_131261_Name = {
    Text = "破灭戏场"
  },
  State_131351_Desc = {
    Text = "其他唤醒体释放狂气爆发后消耗 1 层，莫丝释放「涡！流！弹！」进行追击。"
  },
  State_131351_Name = {
    Text = "涡流装填"
  },
  State_131439_Desc = {
    Text = "下张打出的指令卡额外生效 2 次且算力消耗降低为 0。"
  },
  State_131439_Name = {
    Text = "提线木偶"
  },
  State_131637_Desc = {
    Text = "死亡后立刻召唤一名随机的「渊狱蜘群」或「冷蛛群」，使其「集群效应」降低 1 层。"
  },
  State_131637_Name = {
    Text = "集群效应"
  },
  State_131638_Desc = {
    Text = "死亡后立刻召唤一名随机的「碎相母体」或「缠丝母体」，使其「集群效应」降低 1 层。"
  },
  State_131638_Name = {
    Text = "集群效应"
  },
  State_131645_Desc = {
    Text = "队伍唯一：切换至「怒涛」姿态时，获得等同于当前界域精通 <WeaponEffect_Num:[StateArg1]%> 的临时界域精通，3 回合冷却。"
  },
  State_131645_WeaponDesc = {
    Text = "切换至「怒涛」姿态时，获得 [DescArg2] 点临时界域精通，3 回合冷却(当前剩余 [DescArg1] 回合)。"
  },
  State_131657_Desc = {
    Text = "其他唤醒体释放狂气爆发后消耗 1 层，莫丝释放「涡！流！弹！」进行追击。"
  },
  State_131657_Name = {
    Text = "<WhirlpoolKeywords:涡流装填>"
  },
  State_131660_Desc = {
    Text = "每有 1 层提高 1 点释放狂气爆发的狂气需求。"
  },
  State_131660_Name = {
    Text = "狂气消耗固定值修正"
  },
  State_131675_Desc = {
    Text = "此卡牌在下次打出时有 [StateArg1]% 的概率额外生效 1 次。"
  },
  State_131675_Name = {
    Text = "<CardKeyWord:豪赌>"
  },
  State_131684_Desc = {
    Text = "接下来 [Layer] 次「涡！流！弹！」生效 2 次。"
  },
  State_131684_Name = {
    Text = "默斯克斯！大！轰！炸！"
  },
  State_131749_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张「豪赌的智慧」洗入抽牌堆。「豪赌的智慧」：消耗 1 算力。将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 <WeaponEffect_Num:[StateArg1]%> 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。<GuyouKeywords:固有>。"
  },
  State_131749_WeaponDesc = {
    Text = "探索开始后，将 1 张「豪赌的智慧」洗入抽牌堆。「豪赌的智慧」：消耗 1 算力。将手中所有指令卡随机洗入抽牌堆，洗入的指令卡在下次打出时有 <WeaponEffect_Num:[StateArg1]%> 概率额外生效 1 次，并且每洗入 1 张指令卡就使所有唤醒体获得 2 点狂气。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。<GuyouKeywords:固有>。"
  },
  State_131769_Name = {
    Text = "状态@繁育血肉职业初始化1"
  },
  State_131779_Desc = {
    Text = "使用 [Layer] 次后才会进入弃牌堆并重置次数，但「刻印」仅在首次使用时生效。"
  },
  State_131779_Name = {
    Text = "可使用 [Layer] 次"
  },
  State_131789_Desc = {
    Text = "备选手段。将1张tid是[Layer]的卡牌加入手中。"
  },
  State_131789_Name = {
    Text = "添加指定卡牌"
  },
  State_131807_Name = {
    Text = "状态@繁育血肉至纯标识"
  },
  State_131824_Name = {
    Text = "状态@怪物塔薇切换意图玩家监听"
  },
  State_131846_Desc = {
    Text = "死亡后立刻召唤一名随机的「渊狱蜘群」或「冷蛛群」，使其「集群效应」降低 1 层。"
  },
  State_131846_Name = {
    Text = "集群效应"
  },
  State_131908_Desc = {
    Text = "分摊目标的血量护盾狂气，但不产生战斗统计。"
  },
  State_131908_Name = {
    Text = "腐烂盛筵跳板"
  },
  State_131909_Desc = {
    Text = "拥有该状态则法使用狂气爆发。"
  },
  State_131909_Name = {
    Text = "永久封印"
  },
  State_132366_Desc = {
    Text = "其他唤醒体使用打击卡后进行追击"
  },
  State_132366_Name = {Text = "追击"},
  State_132465_Desc = {
    Text = "本唤醒体造成的伤害、护盾、治疗、力量、衰竭、触腕伤害、固定中毒、固定反击提高，独立乘算 1+[Layer]%。"
  },
  State_132465_Name = {
    Text = "强化吞噬α"
  },
  State_132469_Desc = {
    Text = "本唤醒体造成的伤害、护盾、治疗、力量、衰竭、触腕伤害、固定中毒、固定反击提高，独立乘算 1+[Layer]%。"
  },
  State_132469_Name = {
    Text = "强化吞噬β"
  },
  State_132539_Desc = {
    Text = "集合测试造物"
  },
  State_132539_Name = {
    Text = "集合测试造物"
  },
  State_132539_WeaponDesc = {Text = "测试"},
  State_132560_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次伤害，就获得一张消耗【绿炎】。"
  },
  State_132564_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次伤害，就获得一张消耗【绿炎】。"
  },
  State_132565_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次伤害，就获得一张消耗【绿炎】。"
  },
  State_132598_Desc = {
    Text = "本回合造成触腕伤害时，额外造成 [Layer]％ 伤害值的中毒。"
  },
  State_132598_Name = {
    Text = "湮塞的执念"
  },
  State_132609_Desc = {
    Text = "雕砌者施加护盾时，提高 [StateArg1] 触腕伤害。"
  },
  State_132609_Name = {
    Text = "忘我之境"
  },
  State_132609_WeaponDesc = {
    Text = "雕砌者施加护盾时，提高 [StateArg1] 触腕伤害。"
  },
  State_132669_Desc = {
    Text = "本唤醒体的卡牌造成的伤害、护盾、治疗、力量、衰竭、触腕伤害、固定中毒、固定反击提高，独立乘算 1+[Layer]%。"
  },
  State_132669_Name = {
    Text = "命定超维α"
  },
  State_132840_Name = {
    Text = "「24」的指令卡人格效果加成翻倍。释放狂气爆发后，人格加成翻倍效果本回合失效"
  },
  State_132891_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] <StrongEffectKeywords:强效> ，其他友方狂气爆发后使其获得<PVPOneMeetingKeywords:一期一会>。"
  },
  State_132891_Name = {
    Text = "樱花下的迷思"
  },
  State_132892_Desc = {
    Text = "·获得时移除其他友方的「一期一会」状态，获得等同于装备「樱花下的迷思」友方的强效效果，最多 3 层。\n·装备「樱花下的迷思」的角色无法获得「一期一会」。"
  },
  State_132892_Name = {
    Text = "一期一会"
  },
  State_133294_Name = {
    Text = "王邸的请柬"
  },
  State_133353_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备后，无法识别装备者的「打击」、「技能」、「狂气爆发」描述，但每次伤害、护盾、治疗随机提升[StateArg1]%~[StateArg2]%。"
  },
  State_133353_Name = {
    Text = "淤泥里的童话"
  },
  State_133354_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：该命轮死亡后保留。装备者死亡时和死亡状态下的后续 [Layer] 回合结束后，其他友方获得 <Heal:[Heal:StateArg1]> <PVPFeatheredSeedsKeyWords:羽种>和生命。"
  },
  State_133354_Name = {
    Text = "愿世界化作芬芳"
  },
  State_133369_Desc = {
    Text = "下 [DescArg1] 张打出的非塔薇的指令卡生效 2 次。"
  },
  State_133369_Name = {
    Text = "穿越银钥之门"
  },
  State_133372_Desc = {
    Text = "若当前处于超维回合，触发奇点折跃效果。「奇点湮灭」也可使本回合下次奇点折跃必定发动。"
  },
  State_133372_Name = {
    Text = "<SingularityKeywords:奇点折跃>"
  },
  State_133391_Desc = {
    Text = "若该状态层数大于等于目标生命，移除所有命运裁断并直接击杀目标。施加的固定命运裁断受伤害强效加成。"
  },
  State_133391_Name = {
    Text = "<CutKeywords:命运裁断>"
  },
  State_133395_Desc = {
    Text = "接下来打出的下 [Layer] 张指令卡触发「维度穿梭」。"
  },
  State_133395_Name = {
    Text = "维度穿梭"
  },
  State_133717_Desc = {
    Text = "当前拥有者为 [Layer]，其所有当前及未来的卡牌将获得对应属性（当前：卡牌封印）。"
  },
  State_133717_Name = {
    Text = "卡牌属性传播"
  },
  State_133774_Desc = {
    Text = "每拥有 1 层使该卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%；固定护盾、固定生命回复、力量降低的最终效果提高 1%。拥有奇点信标的卡牌无法触发「维度穿梭」。"
  },
  State_133774_Name = {
    Text = "<SingularityKeywords1:奇点信标>"
  },
  State_133775_Desc = {
    Text = "每拥有 1 层使所有唤醒体卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%；固定护盾、固定生命回复、力量降低的最终效果提高 1%。"
  },
  State_133775_Name = {
    Text = "<SingularityKeywords2:奇点棱镜>"
  },
  State_133961_Desc = {
    Text = "队伍唯一：探索开始后生成一张「春之信」置入牌库：算力消耗 1，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量，打出后永久变化为「樱满开」：算力消耗 1，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量，打出后永久变化为「花吹雪」：算力消耗 1，获得 <WeaponEffect_Num:[StateArg3]> 点银钥能量，打出后永久变化为「一期一会」：算力消耗 1，从已解锁的 3 个随机钥令中选择 1 个立刻释放并生效 2 次，打出后永久变化为「春之信」。这些卡牌均拥有「保留」。"
  },
  State_133961_WeaponDesc = {
    Text = "探索开始后生成一张「春之信」置入牌库：算力消耗 1，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量，打出后永久变化为「樱满开」：算力消耗 1，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量，打出后永久变化为「花吹雪」：算力消耗 1，获得 <WeaponEffect_Num:[StateArg3]> 点银钥能量，打出后永久变化为「一期一会」：算力消耗 1，从已解锁的 3 个随机钥令中选择 1 个立刻释放并生效 2 次，打出后永久变化为「春之信」。这些卡牌均拥有「保留」。"
  },
  State_133994_Desc = {
    Text = "所有唤醒体指令卡造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击的最终效果提高 [DescArg1]%，造成的固定护盾、固定生命回复、力量降低效果提高 [DescArg2]％。"
  },
  State_133994_Name = {
    Text = "奇点棱镜"
  },
  State_133998_Desc = {
    Text = "此卡牌造成的伤害、护盾、力量变化提高 [DescArg2]％，触腕伤害、生命回复、固定中毒、固定反击的最终效果提高 [DescArg1]%，回合结束或打出后移除。"
  },
  State_133998_Name = {
    Text = "<TempPowerKeywords1:临时强化 [DescArg1]>"
  },
  State_133999_Desc = {
    Text = "每拥有 1 层使该卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%；固定护盾、固定生命回复、力量降低的最终效果提高 1%，回合结束或打出后移除。"
  },
  State_133999_Name = {
    Text = "<TempPowerKeywords:临时强化>"
  },
  State_134100_Desc = {
    Text = "本场战斗受到致死伤害时，复活，回复 [Layer] 点生命并使所有唤醒体获得 [StateArg1] 点狂气和 [DescArg1] 点临时触腕伤害，无法驱散。"
  },
  State_134100_Name = {
    Text = "不死的极乐鸟"
  },
  State_134191_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张「私密午歇时间」洗入抽牌堆。「私密午歇时间」：消耗 1 算力。临时暴击伤害 +<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_134191_WeaponDesc = {
    Text = "探索开始后，将 1 张「私密午歇时间」洗入抽牌堆。「私密午歇时间」：消耗 1 算力。临时暴击伤害 +<WeaponEffect_Num:[StateArg1]%>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_134195_Desc = {
    Text = "本卡牌造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[Layer]%。"
  },
  State_134195_Name = {
    Text = "三相之力α1"
  },
  State_134196_Desc = {
    Text = "本唤醒体指令卡造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[StateArg1]%。"
  },
  State_134196_Name = {
    Text = "三相之力β3"
  },
  State_134197_Desc = {
    Text = "本卡牌造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[StateArg1]%。"
  },
  State_134197_Name = {
    Text = "三相之力β1"
  },
  State_134198_Desc = {
    Text = "本唤醒体指令卡造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[Layer]%。"
  },
  State_134198_Name = {
    Text = "三相之力α3"
  },
  State_134199_Desc = {
    Text = "本唤醒体狂气爆发造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[StateArg1]%。"
  },
  State_134199_Name = {
    Text = "三相之力β2"
  },
  State_134200_Desc = {
    Text = "本唤醒体狂气爆发造成的固定中毒、固定反击、固定命运裁断层数提高，独立乘算 1+[Layer]%。"
  },
  State_134200_Name = {
    Text = "三相之力α2"
  },
  State_134227_Desc = {
    Text = "阿拉克涅编织命运引出的线缕。最大 [DescArg1] 层，能被狂气爆发消耗释放「无尽丝缕」追击，「织命」会继承至下场战斗。"
  },
  State_134227_Name = {
    Text = "<SilkKeywords:织命>"
  },
  State_134231_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，装备者造成「追击」时 + <WeaponEffect_Num:[StateArg2]%> 临时强效，每回合最多生效 5 次。每当触发「维度穿梭」时，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_134231_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，装备者造成「追击」时 + <WeaponEffect_Num:[StateArg2]%> 临时强效，每回合最多生效 5 次。每当触发「维度穿梭」时，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_134237_Desc = {
    Text = "阿拉克涅编织命运引出的线缕，最大 [DescArg1] 层，能被狂气爆发消耗释放「<DerivativeCardKeywords_144:无尽线缕>」追击。「织命」会继承至下场战斗。"
  },
  State_134237_Name = {Text = "织命"},
  State_134240_Desc = {
    Text = "接下来 [Layer] 次「永恒织造」生成额外的「牵丝引命」置入抽牌堆和弃牌堆。"
  },
  State_134240_Name = {
    Text = "缚命罗网"
  },
  State_134261_Desc = {
    Text = "下 [Layer] 次造成的伤害翻倍。"
  },
  State_134261_Name = {
    Text = "私密午歇时间"
  },
  State_134262_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后自身下一次造成的伤害翻倍。"
  },
  State_134262_Name = {
    Text = "私密午歇时间"
  },
  State_134285_Desc = {
    Text = "若该状态层数大于等于目标生命，移除所有命运裁断并直接击杀目标。施加的固定命运裁断受伤害强效加成。"
  },
  State_134285_Name = {
    Text = "命运裁断"
  },
  State_134313_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，装备者造成「追击」时 + <WeaponEffect_Num:[StateArg2]%> 临时强效，每回合最多生效 5 次。"
  },
  State_134313_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，装备者造成「追击」时 + <WeaponEffect_Num:[StateArg2]%> 临时强效，每回合最多生效 5 次。"
  },
  State_134384_Desc = {
    Text = "接下来打出的下 [Layer] 张指令卡触发「维度穿梭」。"
  },
  State_134384_Name = {
    Text = "维度穿梭"
  },
  State_134389_Desc = {
    Text = "此卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击的最终效果提高 [DescArg1]%，造成的固定护盾、固定生命回复、力量降低效果提高 [DescArg2]％。拥有「奇点信标」的卡牌无法再复制进「超维空间」。"
  },
  State_134389_Name = {
    Text = "<SingularityKeywords:奇点信标 [DescArg2]>"
  },
  State_134391_Desc = {
    Text = "每回合首次打出指令卡后触发该效果，打出指令卡后将其临时原始复制置入超维空间，超维回合无法发动该效果。"
  },
  State_134391_Name = {
    Text = "<SingularityKeywords3:维度穿梭>"
  },
  State_135232_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:奇点折跃>：本回合剩余时间内其他唤醒体打出指令卡后，消耗 1 层<SilkKeywords:织命>释放「<DerivativeCardKeywords_144:无尽线缕>」追击>"
  },
  State_135233_Name = {
    Text = "<SingularityKeywords:奇点折跃>：本回合剩余时间内其他唤醒体打出指令卡后，消耗 1 层<SilkKeywords:织命>释放「<DerivativeCardKeywords_144:无尽线缕>」追击"
  },
  State_135919_Name = {
    Text = "<AwakerCard_24Lost:<SingularityKeywords:奇点折跃>：本回合剩余时间内其他唤醒体打出指令卡后，消耗 1 层<SilkKeywords:织命>释放「<DerivativeCardKeywords_144:无尽线缕>」追击>"
  },
  State_135920_Name = {
    Text = "<SingularityKeywords:奇点折跃>：本回合剩余时间内其他唤醒体打出指令卡后，消耗 1 层<SilkKeywords:织命>释放「<DerivativeCardKeywords_144:无尽线缕>」追击"
  },
  State_135921_Desc = {
    Text = "唤醒体造成的伤害提高 25%。"
  },
  State_135921_Name = {
    Text = "<CardKeyWord:呵斥，以报恩仇>"
  },
  State_138824_Desc = {
    Text = "闪耀的生命正赞颂自由，高奏凯歌，可被沙耶狂气爆发消耗强化其效果。该状态至多积攒 4 层，战斗结束后会保留。"
  },
  State_138824_Name = {
    Text = "<KaiHuajishu1:羽种>"
  },
  State_139039_Desc = {
    Text = "该唤醒体本回合下次狂气爆发造成的伤害、固定护盾、固定生命回复、固定力量、力量降低、触腕伤害提高、固定中毒、固定反击的最终效果提高 [Layer]％。"
  },
  State_139039_Name = {
    Text = "<BreedingKeywords2:繁育庆典>"
  },
  State_139687_Desc = {
    Text = "闪耀的生命正赞颂自由，高奏凯歌，可被沙耶狂气爆发消耗强化其效果。该状态至多积攒 4 层，战斗结束后会保留。"
  },
  State_139687_Name = {
    Text = "<KaiHuajishu:羽种>"
  },
  State_139688_Desc = {
    Text = "队伍唯一：算力上限 +1，同类效果无法叠加。装备者每有 10 点基础狂气，造成的固定<Corrosion:侵蚀>效果提高 <WeaponEffect_Num:[StateArg1]%>，造成的胚胎融合提高 <WeaponEffect_Num:[Float:StateArg2]％>。"
  },
  State_139688_WeaponDesc = {
    Text = "算力上限 +1，同类效果无法叠加。装备者每有 10 点基础狂气，造成的固定<Corrosion:侵蚀>效果提高 <WeaponEffect_Num:[StateArg1]%>，造成的胚胎融合提高 <WeaponEffect_Num:[Float:StateArg2]％>。"
  },
  State_139689_Desc = {
    Text = "队伍唯一：使用「猩红熔炉」后，装备者获得 <WeaponEffect_Num:[StateArg1]%> 基础狂气的狂气，3 回合冷却。"
  },
  State_139689_WeaponDesc = {
    Text = "使用「猩红熔炉」后，装备者获得 <WeaponEffect_Num:[StateArg1]%> 基础狂气的狂气，3 回合冷却。"
  },
  State_139977_Desc = {
    Text = "本回合若打出「打击」，则「打击」+ [DescArg1]% 伤害贯穿；否则回合结束 +[Layer] 屏障。"
  },
  State_139977_Name = {Text = "星兽"},
  State_140063_Desc = {
    Text = "这是向下回合借算力打下的“欠条”，会在下回合开始后扣除 [Layer] 算力，无法驱散。"
  },
  State_140063_Name = {
    Text = "欠条傍身"
  },
  State_140068_Desc = {
    Text = "下 [DescArg1] 张「技能」消耗的算力 - [StateArg1] 。"
  },
  State_140068_Name = {Text = "明悟"},
  State_140135_Desc = {
    Text = "每拥有 1 层，该唤醒体本回合下次狂气爆发造成的伤害、固定护盾、固定生命回复、固定力量、力量降低、触腕伤害提高、固定中毒、固定反击的最终效果提高 1％。"
  },
  State_140135_Name = {
    Text = "<BreedingKeywords1:繁育庆典>"
  },
  State_140186_WeaponDesc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_140454_Desc = {
    Text = "队伍唯一：装备者自身、命轮、密契每有 1% 黑印掉落，战斗结束后回复 <WeaponEffect_Num:[StateArg1]%> 最大生命，每回合结束就使该回复效果衰减 30%，多次独立计算。在「灰烬遗迹」中释放「感应」后，本次「灰烬遗迹」刷新无需消耗黑印。"
  },
  State_140454_WeaponDesc = {
    Text = "队伍唯一：战斗结束后回复 <WeaponEffect_Num:[DescArg2]%> 最大生命([DescArg1])，每回合结束就使该回复效果降低 30%。在「灰烬遗迹」中释放「感应」后，本次「灰烬遗迹」刷新无需消耗黑印。"
  },
  State_140456_WeaponDesc = {
    Text = "打出后将其永久移除。"
  },
  State_140458_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和任意唤醒体释放「狂气爆发」后，自身获得 <Block:[Block:StateArg1]> 护盾。"
  },
  State_140458_Name = {Text = "致群星"},
  State_140489_Desc = {
    Text = "获得等量最大生命，层数不会超过唤醒体的初始最大生命。"
  },
  State_140489_Name = {Text = "羽种"},
  State_140490_Desc = {
    Text = "获得等量最大生命，层数不会超过该唤醒体的初始最大生命 [DescArg1]。"
  },
  State_140490_Name = {Text = "羽种"},
  State_140495_Desc = {
    Text = "下一张「技能」消耗的算力 - [Layer] 。"
  },
  State_140495_Name = {Text = "改写"},
  State_140517_Desc = {
    Text = "下一张「技能」消耗的算力 - [DescArg1] 。"
  },
  State_140517_Name = {Text = "改写"},
  State_140547_Desc = {
    Text = "该效果至多使胚胎融合+ 100，不受胚胎融合提高效果加成。"
  },
  State_140547_Name = {
    Text = "胚胎融合翻倍"
  },
  State_140645_Desc = {
    Text = "待机特效"
  },
  State_140645_Name = {
    Text = "待机特效"
  },
  State_140647_Name = {
    Text = "打出认知失调监听"
  },
  State_140648_Name = {
    Text = "玩家持有认知失调计数"
  },
  State_140650_Desc = {
    Text = "每回合前 3 次打出带有「认知错乱」的指令卡使沙耶获得 [Layer] 点狂气。"
  },
  State_140650_Name = {
    Text = "认知改造"
  },
  State_140651_Desc = {
    Text = "待机特效"
  },
  State_140651_Name = {
    Text = "待机特效"
  },
  State_140653_Desc = {
    Text = "本卡牌算力消耗有 10% 的几率 -2，25% 的几率 -1、30% 的几率不变、25% 的几率 +1、10% 的几率 +2。打出或弃置后移除该状态"
  },
  State_140653_Name = {
    Text = "<ExclamationPointColour:认知失调>"
  },
  State_140654_Desc = {
    Text = "待机特效"
  },
  State_140654_Name = {
    Text = "待机特效"
  },
  State_140655_Desc = {
    Text = "本卡牌被融蚀遮盖无法查看其文字，算力消耗有 10% 的几率 -2，25% 的几率 -1、30% 的几率不变、25% 的几率 +1、10% 的几率 +2。打出或弃置后移除该状态。"
  },
  State_140655_Name = {
    Text = "<ErosionColorInkKeywords:认知错乱>"
  },
  State_140656_Desc = {
    Text = "本卡牌算力消耗有 10% 的几率 -2，25% 的几率 -1、30% 的几率不变、25% 的几率 +1、10% 的几率 +2。打出或弃置后移除该状态"
  },
  State_140656_Name = {
    Text = "<ColorInkKeywords:认知失调>"
  },
  State_140657_Desc = {
    Text = "本卡牌被融蚀遮盖无法查看其文字，算力消耗有 10% 的几率 -2，25% 的几率 -1、30% 的几率不变、25% 的几率 +1、10% 的几率 +2。打出或弃置后移除该状态。"
  },
  State_140657_Name = {
    Text = "<ExclamationPointColour:认知错乱>"
  },
  State_140658_Name = {
    Text = "玩家持有认知失调监听"
  },
  State_140659_Desc = {
    Text = "待机特效"
  },
  State_140659_Name = {
    Text = "待机特效"
  },
  State_140662_Desc = {
    Text = "每回合开始时，都会随机对 2 张没有「认知错乱」的指令卡施加「认知错乱」。"
  },
  State_140662_Name = {
    Text = "生命重构治疗"
  },
  State_140672_Desc = {
    Text = "本回合结束之前，每次造成的伤害、治疗、护盾随机降低15%~35%，无法驱散。"
  },
  State_140672_Name = {
    Text = "<PVPCognitiveDissonanceKeyWords:认知错乱>"
  },
  State_140673_Desc = {
    Text = "本回合结束之前，每次造成的伤害、治疗、护盾随机降低15%~35%，无法驱散。"
  },
  State_140673_Name = {
    Text = "认知错乱"
  },
  State_140683_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] <MaxHPKeywords:最大生命>，回合结束时回复 <Heal:[Heal:DescArg1]> 生命，回复生命随装备者生命降低而提高，最多提升 [StateArg3]%。"
  },
  State_140683_Name = {
    Text = "梦游仙境"
  },
  State_140724_Name = {Text = "进食"},
  State_140726_Desc = {
    Text = "此卡牌造成的伤害、力量、触腕伤害、固定中毒、固定反击、护盾、生命回复、力量降低的最终效果降低 [DescArg1]%。"
  },
  State_140726_Name = {
    Text = "<AdaptKeywords1:适应 [DescArg1]>"
  },
  State_140727_Desc = {
    Text = "饥饿达到 5 层时，回合结束后消耗所有饥饿，将意图切换为强力攻击并获得 [DescArg1] 点力量。"
  },
  State_140727_Name = {Text = "饥饿"},
  State_140728_Desc = {
    Text = "每回合开始时获得 1 层饥饿，造成未被格挡的伤害时获得最大生命值 2%([DescArg1]) 点护盾，适应的最高层数提高为 75。"
  },
  State_140728_Name = {Text = "护食"},
  State_140730_Desc = {
    Text = "打出指令卡后，对所属唤醒体在各处的卡牌施加 10 层<AdaptKeywords:适应>，其他唤醒体的卡牌移除 5 层<AdaptKeywords:适应>。每层<AdaptKeywords:适应>使卡牌造成的伤害、力量、触腕伤害、固定中毒、固定反击、护盾、生命回复、力量降低的最终效果降低 1%，最高 [DescArg1] 层。"
  },
  State_140730_Name = {Text = "拟态"},
  State_140838_Desc = {
    Text = "本回合造成的伤害降低 [Layer]%。"
  },
  State_140838_Name = {
    Text = "蔽日魇墙"
  },
  State_140839_Desc = {
    Text = "本回合所有唤醒体最终伤害提高 [Layer]%。"
  },
  State_140839_Name = {
    Text = "随行猎从"
  },
  State_140856_Desc = {
    Text = "无法行动，回合结束时移除 1 层意识干涉，全部移除后该唤醒体下 1 次释放狂气爆发时视为释放超限爆发，若释放时已经为超限爆发则改为返还 100% 基础狂气。"
  },
  State_140856_Name = {
    Text = "<Yishiganshe:意识干涉>"
  },
  State_140860_Desc = {
    Text = "无法行动，回合结束时移除 1 层意识干涉，全部移除后该唤醒体下 1 次释放狂气爆发时视为释放超限爆发，若释放时已经为超限爆发则改为返还 100% 基础狂气。"
  },
  State_140860_Name = {
    Text = "<Yishiganshe:意识干涉>"
  },
  State_140861_Desc = {
    Text = "下 1 次释放狂气爆发时视为释放超限爆发，若释放时已经为超限爆发则改为返还 100% 基础狂气。"
  },
  State_140861_Name = {
    Text = "梦游仙境"
  },
  State_140873_Desc = {
    Text = "每 1 层使此卡牌造成的伤害、力量、触腕伤害、固定中毒、固定反击、护盾、生命回复、力量降低的最终效果降低 1%，最高 [DescArg1] 层。"
  },
  State_140873_Name = {
    Text = "<AdaptKeywords:适应>"
  },
  State_140877_Name = {
    Text = "额外生效 [DescArg1] 次"
  },
  State_141468_Desc = {
    Text = "饥饿达到 5 层时，回合结束后消耗所有饥饿，将意图切换为强力攻击并获得力量。"
  },
  State_141468_Name = {
    Text = "<HungerKeywords:饥饿>"
  },
  State_141504_Desc = {
    Text = "至多积攒 3 具，达到上限后下次「生灵的盛筵」能够将其食用并强化其效果。残骸会继承至下场战斗。"
  },
  State_141504_Name = {Text = "残骸"},
  State_141950_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备和回合结束时，<PVPDiscoveryKeyWords:发现> [StateArg1] 张附加<PVPVoidKeywords:虚无>的「技能」并置入手中。"
  },
  State_141950_Name = {
    Text = "向上坠落"
  },
  State_141988_Desc = {
    Text = "本卡牌造成的伤害、护盾、治疗，施加的力量、衰竭、触腕伤害、中毒、反击、命运裁断、固定中毒、固定反击、固定命运裁断，效果提高 [Layer]%。"
  },
  State_141988_Name = {
    Text = "本卡牌炫彩"
  },
  State_141989_Desc = {
    Text = "创造出随机的卡牌。"
  },
  State_141989_Name = {
    Text = "<CardKeyWord:发现>"
  },
  State_141991_Desc = {
    Text = "本唤醒体狂气爆发造成的伤害、护盾、治疗，施加的力量、衰竭、触腕伤害、中毒、反击、命运裁断、固定中毒、固定反击、固定命运裁断，效果提高 [Layer]%。"
  },
  State_141991_Name = {
    Text = "狂气爆发炫彩"
  },
  State_141992_Desc = {
    Text = "本唤醒体的卡牌造成的伤害、护盾、治疗，施加的力量、衰竭、触腕伤害、中毒、反击、命运裁断、固定中毒、固定反击、固定命运裁断，效果提高 [Layer]%。"
  },
  State_141992_Name = {
    Text = "本卡牌炫彩"
  },
  State_141993_Desc = {
    Text = "本唤醒体指令卡造成的伤害、护盾、治疗，施加的力量、衰竭、触腕伤害、中毒、反击、命运裁断、固定中毒、固定反击、固定命运裁断，效果提高 [Layer]%。"
  },
  State_141993_Name = {
    Text = "指令卡炫彩"
  },
  State_141994_Desc = {
    Text = "打出卡牌后、释放狂气爆发后造成的伤害，获得护盾、治疗，施加力量、衰竭、触腕伤害、中毒、反击、命运裁断、固定中毒、固定反击、固定命运裁断。"
  },
  State_141994_Name = {
    Text = "炫彩触发指令"
  },
  State_142018_Desc = {
    Text = "回合开始时，获得1层<Guaiwucanhai:残骸>"
  },
  State_142018_Name = {
    Text = "王邸的请柬"
  },
  State_142057_Desc = {
    Text = "使用钥令后切换自身意图，战斗开始后所有唤醒体银钥充能等级提高 25%。"
  },
  State_142057_Name = {
    Text = "明悟因果"
  },
  State_142058_Desc = {
    Text = "造成的基础伤害、中毒、反击降低 [DescArg1]%"
  },
  State_142058_Name = {
    Text = "污秽之翼"
  },
  State_142060_Desc = {
    Text = "敌方每次使用指令卡后，自身获得 1 层临时狂热。临时狂热达到 10 层时，下次打出指令卡后，自身立刻行动并移除所有临时狂热。"
  },
  State_142060_Name = {
    Text = "深渊回声"
  },
  State_142062_Desc = {
    Text = "每次0246初始效果随机"
  },
  State_142062_Name = {
    Text = "意图随机"
  },
  State_142063_Desc = {
    Text = "自身回合内，受到的伤害降低 [DescArg1]%。"
  },
  State_142063_Name = {
    Text = "圣洁之翼"
  },
  State_142065_Desc = {
    Text = "回合开始时清除。达到 10 层时，下次打出指令卡后，自身立刻行动并移除所有临时狂热。"
  },
  State_142065_Name = {
    Text = "临时狂热"
  },
  State_142066_Desc = {
    Text = "造成的 <WeaknessIconKeywords:虚弱>、<FragileIconKeywords:脆弱>、<HeavyInjuryKeywords:重创>效果提高为 50%。"
  },
  State_142066_Name = {
    Text = "本质洞悉"
  },
  State_142067_Desc = {
    Text = "造成的力量、反击、触腕伤害降低 [DescArg1]%"
  },
  State_142067_Name = {
    Text = "诅咒之翼"
  },
  State_142072_Desc = {
    Text = "每次受到伤害或失去生命时，无法超过最大生命的 5%。"
  },
  State_142072_Name = {
    Text = "承痛阈值"
  },
  State_142091_Desc = {
    Text = "六翼翻倍计数"
  },
  State_142091_Name = {
    Text = "六翼翻倍计数"
  },
  State_142092_Desc = {
    Text = "所有唤醒体银钥充能等级提高 25%。"
  },
  State_142092_Name = {
    Text = "明悟因果"
  },
  State_142093_Desc = {
    Text = "六翼翻倍消耗进度：[DescArg1]，当前所需受伤值：[DescArg2]。"
  },
  State_142093_Name = {
    Text = "六翼翻倍"
  },
  State_142095_Desc = {
    Text = "六翼翻倍标识"
  },
  State_142095_Name = {
    Text = "六翼翻倍标识"
  },
  State_142166_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_142213_Name = {
    Text = "降低算力上限"
  },
  State_142215_Desc = {
    Text = "若其在下回合开始依旧死亡，则复活并获得 [StateArg1] 护盾，无法驱散。"
  },
  State_142215_Name = {
    Text = "永世执念"
  },
  State_142228_Desc = {
    Text = "此卡牌由命轮「向上坠落」创造。"
  },
  State_142228_Name = {
    Text = "向上坠落"
  },
  State_142229_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张「梦游仙境」加入牌库。「梦游仙境」：消耗 2 点算力，使装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气与 3 层<Yishiganshe:「意识干涉」>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142229_Name = {
    Text = "梦游仙境"
  },
  State_142229_WeaponDesc = {
    Text = "探索开始后，将 1 张「梦游仙境」加入牌库。「梦游仙境」：消耗 2 点算力，使装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气与 3 层<Yishiganshe:「意识干涉」>。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_142452_Desc = {
    Text = "受到的力量降低效果缩减 50%。"
  },
  State_142452_Name = {
    Text = "不朽存在"
  },
  State_142663_Desc = {
    Text = "下回合开始时，获得<DelayKeywords:延迟 1>： [Layer] 狂气。"
  },
  State_142663_Name = {
    Text = "延迟延迟狂气"
  },
  State_142688_Desc = {
    Text = "目标所装备的命轮失效，无法驱散。"
  },
  State_142688_Name = {
    Text = "超级缠绕"
  },
  State_142692_Desc = {
    Text = "正在冒出新的小巧思。"
  },
  State_142692_Name = {
    Text = "灵机一动"
  },
  State_142715_Desc = {
    Text = "该「技能」伤害提升 [DescArg1]% ,该技能每需要消耗 1 点算力增加 [StateArg1]%。"
  },
  State_142715_Name = {
    Text = "琥珀色的死亡"
  },
  State_142887_Desc = {
    Text = "若本回合再次受到「麻痹」，其所有「打击」变为「幻象」，无法驱散，持续到回合结束。"
  },
  State_142887_Name = {
    Text = "有点麻了"
  },
  State_142954_Desc = {
    Text = "算力上限最小为 0 ，每回合开始时若小于 10 会增长 1  。在到达 10 后再获得算力上限将转换为抽等量卡牌。"
  },
  State_142954_Name = {
    Text = "算力上限"
  },
  State_143002_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143002_Name = {
    Text = "撒托古亚SR(临时文本)"
  },
  State_143004_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143004_Name = {
    Text = "撒托古亚专武(临时文本)"
  },
  State_143005_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143005_Name = {
    Text = "兰提戈斯SR(临时文本)"
  },
  State_143006_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143006_Name = {
    Text = "黑法老专武(临时文本)"
  },
  State_143007_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，对随机的敌方施加 [StateArg1] 层<PVPCompassKeywords:指向歧路的罗盘>。"
  },
  State_143007_Name = {
    Text = "指向歧路的罗盘"
  },
  State_143008_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143008_Name = {
    Text = "夏塔克鸟专武(临时文本)"
  },
  State_143009_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143009_Name = {
    Text = "亚弗戈蒙专武(临时文本)"
  },
  State_143010_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限+ [StateArg1] ，装备者或友方死亡时，其卡牌不再转换为<PVPDerivativeCardKeywords_2:「幻象」>，而是转换为<PVPDerivativeCardKeywords_30:「猎魇」>。"
  },
  State_143010_Name = {Text = "活囚笼"},
  State_143011_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143011_Name = {
    Text = "秃鹫SR(临时文本)"
  },
  State_143012_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143012_Name = {
    Text = "夏塔克鸟SR(临时文本)"
  },
  State_143013_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143013_Name = {
    Text = "本源奥吉尔SR(临时文本)"
  },
  State_143014_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前损失 25% 当前生命；「狂气爆发」后对全体敌方造成 [StateArg1] 伤害并汲取等量生命。"
  },
  State_143014_Name = {
    Text = "蜜果的谎言"
  },
  State_143016_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143016_Name = {
    Text = "黑法老SR(临时文本)"
  },
  State_143017_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143017_Name = {
    Text = "兰提戈斯专武(临时文本)"
  },
  State_143018_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143018_Name = {
    Text = "本源图鲁SR(临时文本)"
  },
  State_143019_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使敌方全体施加 [StateArg1] 层<PVPBless:赐福>。"
  },
  State_143019_Name = {
    Text = "恬美的真相"
  },
  State_143020_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143020_Name = {
    Text = "本源奥吉尔专武(临时文本)"
  },
  State_143022_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143022_Name = {
    Text = "秃鹫专武(临时文本)"
  },
  State_143023_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_143023_Name = {
    Text = "亚弗戈蒙SR(临时文本)"
  },
  State_143326_Desc = {
    Text = "银钥充能提高 [DescArg1]。"
  },
  State_143326_Name = {
    Text = "明悟因果"
  },
  State_143331_Desc = {
    Text = "下回合结束前为<StatusApplier:>承受一半伤害的生命损失，此状态每个队伍唯一，绑定双方任意一人死亡时移除该效果，无法驱散。"
  },
  State_143331_Name = {
    Text = "承受伤害"
  },
  State_143333_Desc = {
    Text = "下回合开始前<StatusApplier:>为其承受一半伤害的生命损失，此状态每个队伍唯一，绑定双方任意一人死亡时移除该效果，无法驱散。"
  },
  State_143333_Name = {
    Text = "伤害转移"
  },
  State_143336_Desc = {
    Text = "为「囚魇」赋予额外生效 1 次。打出「囚魇」时消耗 1 层，上限为 9 层，战斗结束时不清除。"
  },
  State_143336_Name = {
    Text = "<BattueKeywords:围猎>"
  },
  State_143340_Desc = {
    Text = "为「囚魇」赋予额外生效 1 次。打出「囚魇」时消耗 1 层，上限为 9 层，战斗结束时不清除。"
  },
  State_143340_Name = {
    Text = "<BattueKeywords1:围猎>"
  },
  State_143386_Desc = {
    Text = "为<StatusApplier:>承受一半伤害的生命损失，无法驱散。"
  },
  State_143386_Name = {
    Text = "承受伤害"
  },
  State_143387_Desc = {
    Text = "<StatusApplier:>为其承受一半伤害的生命损失，无法驱散。"
  },
  State_143387_Name = {
    Text = "伤害转移"
  },
  State_143406_Name = {
    Text = "此卡牌额外生效 [DescArg1] 次"
  },
  State_143408_Desc = {
    Text = "受到敌方唤醒体攻击时将转换为攻击者的 [Layer] 狂气。"
  },
  State_143408_Name = {
    Text = "指向歧路的罗盘"
  },
  State_143409_Desc = {
    Text = "受到敌方唤醒体攻击时将层数等量转换为攻击者的狂气。"
  },
  State_143409_Name = {
    Text = "<CardKeyWord:指向歧路的罗盘>"
  },
  State_143419_Desc = {
    Text = "这张牌来自<PVPDerivativeCardKeywords_31:「奥瑞塔的宝藏」>。"
  },
  State_143419_Name = {
    Text = "奥瑞塔的宝藏"
  },
  State_143426_Desc = {
    Text = "回合开始后，扣除 [Layer] 算力，无法驱散。"
  },
  State_143426_Name = {
    Text = "延迟扣除算力"
  },
  State_143441_Desc = {
    Text = "第[StateArg1]轮操作时被选中的唤醒体。"
  },
  State_143441_Name = {
    Text = "测试标记1"
  },
  State_143442_Desc = {
    Text = "第[StateArg1]轮操作时被选中的唤醒体。"
  },
  State_143442_Name = {
    Text = "测试标记2"
  },
  State_143444_Desc = {
    Text = "第[StateArg1]轮操作时被选中的唤醒体。"
  },
  State_143444_Name = {
    Text = "测试标记4"
  },
  State_143445_Desc = {
    Text = "第[StateArg1]轮操作时被选中的唤醒体。"
  },
  State_143445_Name = {
    Text = "测试标记3"
  },
  State_143499_Name = {
    Text = "免疫主动伤害__「仅开发用」"
  },
  State_143500_Name = {
    Text = "免疫纯粹伤害__「仅开发用」"
  },
  State_143541_Desc = {
    Text = "所有敌人本回合造成的伤害降低 [DescArg1]%，获得 [DescArg2] 点力量。"
  },
  State_143541_Name = {Text = "护卫"},
  State_143542_Desc = {
    Text = "临时最终伤害 +[DescArg1]%，并对所有敌人造成 [DescArg2]% 最大生命的侵蚀。"
  },
  State_143542_Name = {Text = "猎取"},
  State_143548_Desc = {
    Text = "造成护盾并添加状态，怪物，分支1。"
  },
  State_143548_Name = {
    Text = "怪物盾转1"
  },
  State_143549_Desc = {
    Text = "造成护盾并添加状态，唤醒体，分支2。"
  },
  State_143549_Name = {
    Text = "角色盾转2"
  },
  State_143550_Desc = {
    Text = "造成护盾并添加状态，唤醒体，分支1。"
  },
  State_143550_Name = {
    Text = "角色盾转1"
  },
  State_143551_Desc = {
    Text = "造成护盾并添加状态，怪物，分支2。"
  },
  State_143551_Name = {
    Text = "怪物盾转2"
  },
  State_143552_Desc = {
    Text = "造成护盾并添加状态，玩家，分支1。"
  },
  State_143552_Name = {
    Text = "玩家盾转1"
  },
  State_143553_Desc = {
    Text = "造成护盾并添加状态，玩家，分支2。"
  },
  State_143553_Name = {
    Text = "玩家盾转2"
  },
  State_143573_Desc = {
    Text = "囚魇是庞托斯的增益卡，共有 3 种：「掳掠之魇」「滋扰之魇」「猎杀之魇」。生成永久「囚魇」时若永久「囚魇」超出 6 张，将随机永久「囚魇」升级为算力消耗 +1 但额外生效 1 次的「双生囚魇」，「双生囚魇」在牌库中视为 2 张「囚魇」。若所有「囚魇」均已升级则将 1 张具有<DestructionKeywords:销毁>的「高级灵感」置入手中。"
  },
  State_143573_Name = {Text = "囚魇"},
  State_143578_Desc = {
    Text = "本回合内，每当受到主动伤害，将 [Layer] 张<PVPDerivativeCardKeywords_30:「猎魇」>置入手牌。"
  },
  State_143578_Name = {
    Text = "领主之仪"
  },
  State_143595_Desc = {
    Text = "该卡牌被添加了<PrepareKeywords:预备> [StateArg1]。"
  },
  State_143595_Name = {
    Text = "黑天鹅的舞步"
  },
  State_143597_Desc = {
    Text = "队伍唯一：装备者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>。切换至「怒涛」姿态时 ，临时暴击伤害提高，提高量等同于自身基础暴击伤害的 <WeaponEffect_Num:[StateArg1]%> ，3 回合冷却。"
  },
  State_143597_WeaponDesc = {
    Text = "装备者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>。切换至「怒涛」姿态后临时暴击伤害提高 <WeaponEffect_Num:[DescArg1]%> ，3 回合冷却。"
  },
  State_143598_Desc = {
    Text = "队伍唯一：装备者造成的力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>，每击杀 1 个敌人使装备者本场探索回合结束固定回复的狂气提高 2 点，最多堆叠 <WeaponEffect_Num:[StateArg2]> 次。切换至「怒涛」姿态后临时暴击伤害提高，提高量等同于自身基础暴击伤害的 <WeaponEffect_Num:[StateArg1]%> ，3 回合冷却。"
  },
  State_143598_WeaponDesc = {
    Text = "装备者造成力量降低效果提高 <WeaponEffect_Num:[StateArg1]%>，每击杀 1 个敌人使装备者本场探索回合结束固定回复的狂气提高 2 点，最多堆叠 <WeaponEffect_Num:[StateArg2]> 次。切换至「怒涛」姿态后临时暴击伤害提高 <WeaponEffect_Num:[DescArg1]%> ，3 回合冷却。"
  },
  State_143683_Desc = {
    Text = "此唤醒体追击被封印无法使用， [Layer] 回合后封印解除。"
  },
  State_143683_Name = {
    Text = "<Seal1:追击封印>"
  },
  State_144381_Desc = {
    Text = "无法行动，剩余 [DescArg1] 回合。"
  },
  State_144381_Name = {
    Text = "<Yishiganshe:意识干涉>"
  },
  State_144441_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：友方死亡时，自身获得 <Energy:[Energy:StateArg1]> 狂气。友方复活时，其获得 <Energy:[Energy:StateArg2]> 狂气。获得狂气效果仅在目标狂气不满时生效，剩余生效 [Layer] 次，次数耗尽后销毁该命轮。"
  },
  State_144441_Name = {
    Text = "魂灵同调"
  },
  State_144494_Desc = {
    Text = "共有 7 种效果，包括：抽 8 张牌、获得 6 点算力、获得银钥能量、所有唤醒体获得固定狂气、获得力量、临时降低所有敌人力量、临时伤害强效提高。"
  },
  State_144494_Name = {
    Text = "<Blessing:礼物>"
  },
  State_144508_Desc = {
    Text = "「代价」共有 3 种，包括「错失良机」、「夸大其词」、「暗藏杀机」。\n「错失良机」：2 回合后获得「礼物」效果。\n「夸大其词」：「礼物」效果减少 50％。\n「暗藏杀机」：给予自身随机 1 种不同效果：2 回合虚弱 、2 回合脆弱 、2 回合重创、等同于自身最大生命值 1% 的中毒、2 层空虚、手中随机 2 张卡牌施加 1 层迟缓、生成 2 张临时症状卡（不跨战斗继承）置入抽牌堆顶部。"
  },
  State_144508_Name = {
    Text = "<BlessingNegativeEffect:代价>"
  },
  State_144519_Desc = {
    Text = "测试过程量，回合开始后或打出卡牌后刷新。当前拥有 [Layer] 界精。"
  },
  State_144519_Name = {
    Text = "新混沌界精"
  },
  State_145228_Name = {
    Text = "<WormGrowth:饱餐>"
  },
  State_145229_Desc = {
    Text = "你也是赐福的一部分哦~。可被卡拉布狂气爆发消耗获得增益，该状态至多积攒 5 层。战斗结束后不清除"
  },
  State_145229_Name = {
    Text = "<SacrificialMark:供奉>"
  },
  State_145436_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [DescArg1]% ，每次「打击」后伤害额外提高 [StateArg2]% ，最多提高至 [StateArg3]% 。"
  },
  State_145436_Name = {
    Text = "不灭的饥骨"
  },
  State_145437_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg2] 层<EnergyStorageKeywords:蓄力>，「打击」伤害提高 [StateArg1]% 并改为<PVPPunctureDamagewords:穿刺伤害>。"
  },
  State_145437_Name = {Text = "天之陨"},
  State_145456_Desc = {
    Text = "在选择目标时会忽略嘲讽、潜行、锁定。若多名目标条件相等，优先选中靠前唤醒体。"
  },
  State_145456_Name = {
    Text = "生命与护盾最低"
  },
  State_145457_Desc = {
    Text = "在选择目标时会忽略嘲讽、潜行、锁定。若多名目标条件相等，优先选中靠前唤醒体。"
  },
  State_145457_Name = {
    Text = "生命与护盾最高"
  },
  State_145495_Desc = {
    Text = "此卡牌由双发打出。"
  },
  State_145495_Name = {
    Text = "<CardKeyWord:双发>"
  },
  State_145554_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张<Falltospace1[StateArg3]:「涉足人间」>加入牌库。「涉足人间」：消耗 0 算力。对所有敌人造成装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 以及其最大生命 <WeaponEffect_Num:[Float:StateArg4]%> 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace2[StateArg3]:「向上坠落」>洗入抽牌堆。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>。"
  },
  State_145554_Name = {
    Text = "向上坠落"
  },
  State_145554_WeaponDesc = {
    Text = "探索开始后，将 1 张<Falltospace1[StateArg3]:「涉足人间」>加入牌库。「涉足人间」：消耗 0 算力。对所有敌人造成装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 以及其最大生命 <WeaponEffect_Num:[Float:StateArg4]%> 的固定<Corrosion:侵蚀>，使各处其他唤醒体的指令卡附加<ErosionColorInkKeywords:认知错乱>并将 1 张<Falltospace2[StateArg3]:「向上坠落」>洗入抽牌堆。<RetainIconKeywords:保留>。<DepleteIconKeywords:消耗>"
  },
  State_145572_Desc = {
    Text = "每次回合开始，所有其他唤醒体造成 <Damage:[Damage:Layer]> 穿刺伤害。"
  },
  State_145572_Name = {
    Text = "噬鲸的风暴"
  },
  State_145590_Desc = {
    Text = "相同归属的相同卡牌置入到手中时会触发融合效果并消耗该卡牌。"
  },
  State_145590_Name = {
    Text = "<CardKeyWord:融合>"
  },
  State_145592_Desc = {
    Text = "锁定一个敌方，将其作为优先攻击目标，选择单体目标时仅能选择锁定目标，忽略嘲讽和隐匿。"
  },
  State_145592_Name = {
    Text = "<CardKeyWord:锁定>"
  },
  State_145619_Name = {Text = "重创"},
  State_145620_Name = {Text = "空虚"},
  State_145621_Desc = {
    Text = "「礼物」效果减少 50％。"
  },
  State_145621_Name = {
    Text = "<Bleesing_Exaggerate:夸大其词>"
  },
  State_145622_Name = {Text = "迟缓"},
  State_145623_Desc = {
    Text = "给予自身随机 1 种不同效果：2 回合虚弱 、2 回合脆弱 、2 回合重创、施加等同于最大生命值 1% 的中毒、2 层空虚、手中随机 2 张卡牌施加 1 层迟缓、生成 2 张临时症状卡（不跨战斗继承）置入抽牌堆顶部。"
  },
  State_145623_Name = {
    Text = "<Bleesing_Negative:暗藏杀机>"
  },
  State_145624_Name = {Text = "虚弱"},
  State_145625_Name = {
    Text = "2 张相同临时「症状卡」"
  },
  State_145626_Name = {Text = "脆弱"},
  State_145627_Name = {Text = "中毒"},
  State_145628_Desc = {
    Text = "2 回合后获得「礼物」效果。"
  },
  State_145628_Name = {
    Text = "<Bleesing_Delay:错失良机>"
  },
  State_145631_Desc = {
    Text = "「打击」伤害提高 [StateArg1]% 并改为<PVPPunctureDamagewords:穿刺伤害>。"
  },
  State_145631_Name = {Text = "天之陨"},
  State_145632_Desc = {
    Text = "这张牌来自命轮「好运时间」。"
  },
  State_145632_Name = {
    Text = "好运时间"
  },
  State_145638_Desc = {
    Text = "此卡牌算力消耗提高 [Layer]。"
  },
  State_145638_Name = {
    Text = "残忍的致意"
  },
  State_145642_Desc = {
    Text = "2 回合后所有唤醒体获得 [StateArg1] 点狂气 [Layer] 次。"
  },
  State_145642_Name = {
    Text = "延迟狂气"
  },
  State_145644_Desc = {
    Text = "2 回合后获得 <Posse:[StateArg1]> 点银钥能量 [Layer] 次。"
  },
  State_145644_Name = {
    Text = "延迟银钥能量"
  },
  State_145645_Desc = {
    Text = "2 回合后临时降低所有敌人 [StateArg1] 点<ExhaustionIconKeywords:力量> [Layer] 次"
  },
  State_145645_Name = {
    Text = "延迟衰竭"
  },
  State_145646_Desc = {
    Text = "2 回合后获得 [StateArg1] 点算力 [Layer] 次。"
  },
  State_145646_Name = {
    Text = "延迟算力"
  },
  State_145647_Desc = {
    Text = "2 回合后获得 [StateArg1] 点<PowerIconKeywords:力量> [Layer] 次。"
  },
  State_145647_Name = {
    Text = "延迟力量"
  },
  State_145648_Desc = {
    Text = "2 回合后抽 [StateArg1] 张牌 [Layer] 次。"
  },
  State_145648_Name = {
    Text = "延迟抽牌"
  },
  State_145649_Desc = {
    Text = "2 回合后临时伤害强效 [StateArg1]% [Layer] 次。"
  },
  State_145649_Name = {
    Text = "延迟临时伤害强效"
  },
  State_145652_Desc = {
    Text = "此卡牌算力消耗 -[Layer]。"
  },
  State_145652_Name = {
    Text = "不可承受的自由"
  },
  State_145654_Desc = {
    Text = "测试。打出后，或脱离手牌后，销毁。"
  },
  State_145654_Name = {
    Text = "测试。须臾"
  },
  State_145660_Desc = {
    Text = "我方\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]\n敌方\n1.<EnemyPosAwaker1Name:> [DescArg5]\n2.<EnemyPosAwaker2Name:> [DescArg6]\n3.<EnemyPosAwaker3Name:> [DescArg7]\n4.<EnemyPosAwaker4Name:> [DescArg8]"
  },
  State_145660_Name = {
    Text = "回溯后生命变化"
  },
  State_145693_Desc = {
    Text = "回合结束后，算力消耗-[Layer]，被弃掉后也会触发该效果。"
  },
  State_145693_Name = {
    Text = "<PrepareKeypvewordscolour:预备[Layer]>"
  },
  State_145693_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_145694_Desc = {Text = "——"},
  State_145694_Name = {
    Text = "与黑沼共生"
  },
  State_145694_WeaponDesc = {Text = "——"},
  State_145698_Desc = {
    Text = "优先攻击锁定的<StatusApplier:>，选择单体目标时仅能选择锁定目标，忽略嘲讽和隐匿。"
  },
  State_145698_Name = {Text = "锁定"},
  State_145699_Desc = {
    Text = "·优先攻击锁定的<StatusApplier:>，选择单体目标时仅能选择锁定目标，忽略嘲讽和隐匿。\n·自身死亡后<StatusApplier:>获得「<PVPDerivativeCardKeywords_32:来战!>」。"
  },
  State_145699_Name = {Text = "锁定"},
  State_145709_Desc = {
    Text = "每层提高等同于卡拉布 10% 体质的生命上限，「饱餐」至多积攒 50 层。获得该状态时若已到达上限，每超出 1 层则改为回复 3 倍等量的生命。每场非首领战至多获得 10 层「饱餐」。战斗结束时不清除。"
  },
  State_145709_Name = {
    Text = "<WormGrowth1:饱餐>"
  },
  State_145710_Desc = {
    Text = "你也是赐福的一部分哦~。可被卡拉布狂气爆发消耗获得增益，该状态至多积攒 5 层。战斗结束后不清除"
  },
  State_145710_Name = {
    Text = "<SacrificialMark1:供奉>"
  },
  State_145901_Desc = {
    Text = "我方\n1.<AllyPosAwaker1Name:> [DescArg1]\n2.<AllyPosAwaker2Name:> [DescArg2]\n3.<AllyPosAwaker3Name:> [DescArg3]\n4.<AllyPosAwaker4Name:> [DescArg4]"
  },
  State_145901_Name = {
    Text = "回溯后生命变化"
  },
  State_146041_Desc = {
    Text = "该唤醒体感觉脱离了尘世的喧嚣。\n·回合结束之前无法进行任何行动，减免99%伤害，若目标没有抗性则会使目标获得抗性。\n·效果结束对全体友方其造成 <Damage:[Layer]> 纯粹伤害。\n·若施加时目标拥有抗性，则立即结束忽悠且对目标伤害翻倍。"
  },
  State_146041_Name = {Text = "忽悠"},
  State_146043_Desc = {
    Text = "下回合开始时，扣除 [Layer] 狂气。"
  },
  State_146043_Name = {
    Text = "延迟扣除狂气"
  },
  State_146058_Desc = {
    Text = "测试过程量，回合开始后或打出卡牌后刷新。当前应有 [Layer]% 攻效。"
  },
  State_146058_Name = {
    Text = "钥令攻效"
  },
  State_146059_Desc = {
    Text = "测试过程量，回合开始后或打出卡牌后刷新。当前应有 [Layer]% 防效。"
  },
  State_146059_Name = {
    Text = "钥令防效"
  },
  State_146079_Desc = {
    Text = "此卡牌离开手牌后回到手中"
  },
  State_146079_Name = {
    Text = "<Recycle:回收>"
  },
  State_146085_Desc = {
    Text = "本回合打出前改变卡牌算力"
  },
  State_146085_Name = {
    Text = "本回合打出前改变卡牌算力"
  },
  State_146085_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_146086_Desc = {
    Text = "本回合打出前改变卡牌算力"
  },
  State_146086_Name = {
    Text = "本回合打出前改变卡牌算力"
  },
  State_146086_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_146117_Desc = {
    Text = "可被「<DerivativeCardKeywords_157:剑之骨>」消耗获得增益。该状态至多积攒 15 层。"
  },
  State_146117_Name = {
    Text = "<Shimieluotanhuodong2:战意>"
  },
  State_146129_Desc = {
    Text = "所有唤醒体最终伤害 +[Layer]%。"
  },
  State_146129_Name = {
    Text = "鲸天杀意"
  },
  State_146147_Desc = {
    Text = "可被「<DerivativeCardKeywords_157:剑之骨>」消耗获得增益。该状态至多积攒 15 层。"
  },
  State_146147_Name = {
    Text = "<Shimieluotanhuodong1:战意>"
  },
  State_146154_Desc = {
    Text = "让该唤醒体感觉良好，其会有「技能」被被变化为「赐福?」，变化后消耗等量层数。"
  },
  State_146154_Name = {
    Text = "<PVPBlessColour:赐福>"
  },
  State_146155_Desc = {
    Text = "该唤醒体感觉良好。\n·接下来会有 [Layer] 张「技能」被被变化为「赐福?」，变化后消耗等量层数。"
  },
  State_146155_Name = {Text = "赐福"},
  State_146155_WeaponDesc = {Text = "否"},
  State_146202_Desc = {
    Text = "让该唤醒体感觉脱离了尘世的喧嚣。\n·回合结束之前无法进行任何行动，减免99%伤害，若目标没有抗性则会使目标获得抗性。\n·效果结束对全体友方其造成等量层数纯粹伤害。\n·若施加时目标拥有抗性，则立即结束忽悠且对目标伤害翻倍。"
  },
  State_146202_Name = {
    Text = "<CardKeyWord:忽悠>"
  },
  State_146352_Desc = {
    Text = "每受到 1 次伤害，积攒 [StateArg1] 层<Shimieluotanhuodong1:战意>"
  },
  State_146352_Name = {
    Text = "愈战愈勇"
  },
  State_146363_Desc = {
    Text = "下回合开始时，移除 [Layer] 生命。损失生命时减少等量此状态层数。"
  },
  State_146363_Name = {
    Text = "并非谎言之物"
  },
  State_146383_Desc = {
    Text = "添加状态后，打出卡牌后，刷新并打印各唤醒体的银钥充能等级。"
  },
  State_146383_Name = {
    Text = "效率入口"
  },
  State_146384_Desc = {
    Text = "P1值 [StateArg1]，P2值 [StateArg2]，P3值 [StateArg3]，P4值 [StateArg4]。"
  },
  State_146384_Name = {Text = "效率值"},
  State_146385_Desc = {
    Text = "添加状态后，打出卡牌后，刷新并打印各唤醒体的银钥充能等级。"
  },
  State_146385_Name = {
    Text = "等级入口"
  },
  State_146386_Desc = {
    Text = "P1值 [StateArg1]，P2值 [StateArg2]，P3值 [StateArg3]，P4值 [StateArg4]。"
  },
  State_146386_Name = {Text = "等级值"},
  State_146446_Desc = {
    Text = "唤醒体防御力，P1：[StateArg1]，P2：[StateArg2]，P3：[StateArg3]，P4：[StateArg4]。"
  },
  State_146446_Name = {
    Text = "防御属性清单"
  },
  State_146448_Desc = {
    Text = "唤醒体攻击力，P1：力[StateArg1]强度[StateArg2]，P2：力[StateArg3]强度[StateArg4]，P3：力[StateArg5]强度[StateArg6]，P4：力[StateArg7]强度[StateArg8]。"
  },
  State_146448_Name = {
    Text = "攻击属性清单"
  },
  State_146452_Desc = {
    Text = "队伍唯一：装备者「打击」暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合结束时装备者下次狂气爆发暴击伤害提高，提高百分比等同于其基础狂气的 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 次。"
  },
  State_146452_WeaponDesc = {
    Text = "装备者「打击」暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合结束时装备者下次狂气爆发暴击伤害提高 <WeaponEffect_Num:[DescArg1]%>，至多叠加 5 次(当前享受 [DescArg2]％)。"
  },
  State_146456_Desc = {
    Text = "队伍唯一：装备者「打击」暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_146456_WeaponDesc = {
    Text = "装备者「打击」暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_146534_Desc = {
    Text = "关卡开始后，将原初混沌各机制的容器添加给守密人。"
  },
  State_146534_Name = {
    Text = "原初混沌初始化"
  },
  State_146535_Desc = {
    Text = "属性容器。"
  },
  State_146535_Name = {
    Text = "原初混沌标识"
  },
  State_146536_Desc = {
    Text = "机制容器。"
  },
  State_146536_Name = {
    Text = "原初混沌机制"
  },
  State_146644_Desc = {
    Text = "灵知觉醒获得预备1，每回合首次打出时自动释放携带钥令。"
  },
  State_146644_Name = {
    Text = "原初回响"
  },
  State_146645_Desc = {
    Text = "新混沌界域每回合首次打出灵知觉醒时自动释放携带钥令。当前可用。"
  },
  State_146645_Name = {
    Text = "可用标识"
  },
  State_146646_Desc = {
    Text = "基础银钥能量上限改为 2000。获得银钥能量的规则替换为：唤醒体每回合首次打出指令卡时，获得 3 倍银钥充能+ 100 的银钥能量。"
  },
  State_146646_Name = {
    Text = "新混沌钥能规则"
  },
  State_146651_Desc = {
    Text = "提高本唤醒体的攻击力属性 [Layer]%。"
  },
  State_146651_Name = {
    Text = "混沌·攻击"
  },
  State_146652_Desc = {
    Text = "战斗开始后仅1次，将各唤醒体的银钥充能效率改为银钥充能等级的均值。"
  },
  State_146652_Name = {
    Text = "原初均衡"
  },
  State_146653_Desc = {
    Text = "提高本唤醒体的防御力属性 [Layer]%。"
  },
  State_146653_Name = {
    Text = "混沌·防御"
  },
  State_146663_Desc = {
    Text = "下 [Layer] 张蚀灭·萝坦的「打击」额外生效 1 次。"
  },
  State_146663_Name = {
    Text = "噬鲸的风暴"
  },
  State_147058_Name = {
    Text = "饰品36室之环"
  },
  State_147079_Desc = {
    Text = "此卡无法弃置、无法变化。"
  },
  State_147079_Name = {
    Text = "<RetainIconKeywordsColour:强制保留>"
  },
  State_147545_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：未配置"
  },
  State_147545_Name = {
    Text = "暮星·汀克特SR(临时文本)"
  },
  State_147546_Name = {Text = "废弃"},
  State_147546_WeaponDesc = {
    Text = "界外之音"
  },
  State_147584_Desc = {
    Text = "下一张打出的<DerivativeCardKeywords_152:「仙女恩赐」>的<Blessing:恩赐>效果提高 50%"
  },
  State_147737_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] <MaxHPKeywords:最大生命>。回合开始时，对全体敌方造成 <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:出血>伤害，"
  },
  State_147737_Name = {
    Text = "从黑暗到黑暗"
  },
  State_147764_Name = {
    Text = "状态@卡拉布活动选错计数"
  },
  State_147765_Desc = {
    Text = "下回合开始时失去 2 点算力并少抽2张牌。"
  },
  State_147765_Name = {
    Text = "皇家玛丽巧克力"
  },
  State_147768_Desc = {
    Text = "下回合开始时获得 [DescArg1] 张高级灵感。"
  },
  State_147768_Name = {
    Text = "皇家玛丽金币"
  },
  State_147769_Desc = {
    Text = "本场战斗「饱餐」当前已叠加 [Layer] 层。"
  },
  State_147769_Name = {
    Text = "叠层限制"
  },
  State_147772_Name = {
    Text = "状态@卡拉布活动添加临时钥能上限"
  },
  State_147773_Name = {
    Text = "状态@卡拉布活动添加临时钥能上限"
  },
  State_147774_Name = {
    Text = "状态@卡拉布活动添加临时钥能上限_普通混沌"
  },
  State_147797_Desc = {
    Text = "可能获得或失去狂气、<PowerIconKeywords:力量>、生命值、银钥能量和算力与抽牌。"
  },
  State_147797_Name = {
    Text = "皇家玛丽巧克力"
  },
  State_147800_Desc = {
    Text = "下回合开始时失去 2 点算力并少抽2张牌。"
  },
  State_147800_Name = {
    Text = "皇家玛丽巧克力"
  },
  State_147869_Name = {
    Text = "抽 [Layer] 张牌"
  },
  State_147870_Name = {
    Text = "对所有敌人造成 [Layer] 回合虚弱"
  },
  State_147871_Name = {
    Text = "获得 [Energy:DescArg1] 点狂气"
  },
  State_147872_Name = {
    Text = "对所有敌人造成 [Layer] 回合易伤"
  },
  State_147873_Name = {
    Text = "获得 [Layer] 算力"
  },
  State_147874_Name = {
    Text = "获得 [Block:DescArg1] 护盾"
  },
  State_147962_Desc = {
    Text = "此后玩家打出「<DerivativeCardKeywords_158:代罪>」时只驱散 50%<MonsterSinMarkKeywords:罪印>层数，并且每打出 1 张指令卡「圣子·白夜」获得 1 层<MonsterSinMarkKeywords:罪印>。"
  },
  State_147962_Name = {
    Text = "净世之路"
  },
  State_147967_Desc = {
    Text = "「圣子·白夜」造成的伤害附加 [DescArg1]% 的<BleedingIconKeywords:出血>。"
  },
  State_147967_Name = {Text = "罪印"},
  State_147968_Desc = {
    Text = "上限 3 层，当切换至攻击意图时，使「圣子·白夜」造成的伤害提高 25%并消耗 1 层。"
  },
  State_147968_Name = {
    Text = "苦痛救赎"
  },
  State_147969_Desc = {
    Text = "当「圣子·白夜」处于「圣心」意图时，每打出 1 张指令卡积攒 2 层<MonsterPolluxFever:狂热>。"
  },
  State_147969_Name = {
    Text = "神启新约"
  },
  State_147971_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会回复生命并获得 1 层<InvincibleUntilRoused:银芯固化>，觉醒后清除<InvincibleUntilRoused:银芯固化>并以真正的形态开始战斗。"
  },
  State_147971_Name = {
    Text = "尚未觉醒"
  },
  State_147972_Desc = {
    Text = "每层使「圣子·白夜」造成的伤害附加 1% <BleedingIconKeywords:出血>。"
  },
  State_147972_Name = {
    Text = "<MonsterSinMarkKeywords:罪印>"
  },
  State_147974_Desc = {
    Text = "回合开始后清除。达到 10 层后，下次打出卡牌后立刻行动，移除狂热并将意图切换为「圣心」。"
  },
  State_147974_Name = {
    Text = "临时狂热"
  },
  State_147975_Desc = {
    Text = "战斗开始时，将一张「<DerivativeCardKeywords_158:代罪>」置入手牌，回合结束后，获得 5 层<MonsterSinMarkKeywords:罪印>。"
  },
  State_147975_Name = {
    Text = "持灯神使"
  },
  State_147993_Desc = {
    Text = "上限 3 层，当切换至攻击意图时，使「圣子·白夜」造成的伤害提高 25%并消耗 1 层。"
  },
  State_147993_Name = {
    Text = "苦痛救赎"
  },
  State_148020_Desc = {
    Text = "免疫一切伤害且无法失去生命，觉醒后移除。"
  },
  State_148020_Name = {
    Text = "银芯固化"
  },
  State_148021_Name = {
    Text = "状态@怪物通用复活觉醒前免疫清除标识"
  },
  State_148073_Name = {
    Text = "抽 1 张牌"
  },
  State_148074_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_148074_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_148074_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_148076_Name = {
    Text = "净世之路出牌监听"
  },
  State_148116_Desc = {
    Text = "1 回合后抽 [StateArg1] 张牌 [Layer] 次。"
  },
  State_148116_Name = {
    Text = "延迟抽牌1"
  },
  State_148381_Desc = {
    Text = "直到回合结束，自身造成伤害附加 100%<BleedingIconKeywords:出血>。"
  },
  State_148381_Name = {
    Text = "桎梏仇怨"
  },
  State_148383_Desc = {
    Text = "上限 3 层。若拥有 3 层「恨意」，下一次意图切换至「鲜血链条」时，将意图切换为「嗜血链球」并清除「恨意」。"
  },
  State_148383_Name = {
    Text = "「恨意」"
  },
  State_148385_Desc = {
    Text = "每当敌方打出指令卡时获得 2 层<MonsterB05EXFever:临时狂热>。"
  },
  State_148385_Name = {
    Text = "不规则形态"
  },
  State_148386_Desc = {
    Text = "无法获得护盾，直到回合结束。"
  },
  State_148386_Name = {
    Text = "缚身锁链"
  },
  State_148387_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会回复生命并获得 1 层<InvincibleUntilRoused:银芯固化>，觉醒后清除<InvincibleUntilRoused:银芯固化>并以真正的形态开始战斗。"
  },
  State_148387_Name = {
    Text = "尚未觉醒"
  },
  State_148391_Desc = {
    Text = "直到回合结束，自身造成伤害附加 100%<BleedingIconKeywords:出血>。"
  },
  State_148391_Name = {
    Text = "缚身锁链"
  },
  State_148392_Desc = {
    Text = "回合开始后清除。达到 10 层后，下次打出卡牌后立刻行动，移除狂热并将意图切换为「鲜血链条」。"
  },
  State_148392_Name = {
    Text = "临时狂热"
  },
  State_148394_Desc = {
    Text = "回合开始时获得 1 层<ResentChainsKeywords: 怨恨锁链>。 意图切换至「嗜血链球」时，直到敌方回合结束后免疫一切伤害和生命损失效果。"
  },
  State_148394_Name = {
    Text = "索魂者宣言"
  },
  State_148395_Desc = {
    Text = "免疫一切伤害(包括穿刺伤害)且无法失去生命，敌方回合结束后移除。"
  },
  State_148395_Name = {
    Text = "索魂者宣言-嗜血链球"
  },
  State_148421_Desc = {
    Text = "1 回合后临时降低所有敌人 [StateArg1] 点<ExhaustionIconKeywords:力量> [Layer] 次"
  },
  State_148421_Name = {
    Text = "延迟衰竭1"
  },
  State_148422_Desc = {
    Text = "1 回合后临时伤害强效 [StateArg1]% [Layer] 次。"
  },
  State_148422_Name = {
    Text = "延迟临时伤害强效1"
  },
  State_148423_Desc = {
    Text = "1 回合后获得 <Posse:[StateArg1]> 点银钥能量 [Layer] 次。"
  },
  State_148423_Name = {
    Text = "延迟银钥能量1"
  },
  State_148426_Desc = {
    Text = "1 回合后获得 [StateArg1] 点算力 [Layer] 次。"
  },
  State_148426_Name = {
    Text = "延迟算力1"
  },
  State_148427_Desc = {
    Text = "1 回合后所有唤醒体获得 [StateArg1] 点狂气 [Layer] 次。"
  },
  State_148427_Name = {
    Text = "延迟狂气1"
  },
  State_148428_Desc = {
    Text = "1 回合后获得 [StateArg1] 点<PowerIconKeywords:力量> [Layer] 次。"
  },
  State_148428_Name = {
    Text = "延迟力量1"
  },
  State_148511_Desc = {
    Text = "队伍唯一：探索开始后，将 1 张<Backupbody[StateArg3]:「魂灵同调」>加入牌库。「魂灵同调」：算力消耗 0，打出后获得 1 点算力。<RetainIconKeywords:保留>：积攒装备者体质 <WeaponEffect_Num:[StateArg1]%> 的固定生命回复量与 <WeaponEffect_Num:[StateArg2]> 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后<DestructionKeywords:销毁>此卡牌。"
  },
  State_148511_Name = {
    Text = "魂灵同调"
  },
  State_148511_WeaponDesc = {
    Text = "探索开始后，将 1 张<Backupbody[StateArg3]:「魂灵同调」>加入牌库。「魂灵同调」：算力消耗 0，打出后获得 1 点算力。<RetainIconKeywords:保留>：积攒装备者体质 <WeaponEffect_Num:[StateArg1]%> 的固定生命回复量与 <WeaponEffect_Num:[StateArg2]> 点固定狂气在此卡牌中。若此卡未被销毁，可免疫一次死亡并释放所有积攒的生命回复量和狂气，之后<DestructionKeywords:销毁>此卡牌。"
  },
  State_148513_Desc = {
    Text = "对方回合结束不会丢弃手牌。 回合结束时依次施加 2 层<FragileIconKeywords: 脆弱>、 <WeaknessIconKeywords:虚弱>、<HeavyInjuryKeywords:重创>、<VulnerabilityIconKeywords:易伤>状态。"
  },
  State_148513_Name = {
    Text = "界外之音"
  },
  State_148520_Desc = {
    Text = "无法获得护盾，直到回合结束。"
  },
  State_148520_Name = {
    Text = "桎梏仇怨"
  },
  State_148522_Desc = {
    Text = "队伍唯一：装备者「狂气爆发」造成的护盾和力量提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_148524_Desc = {
    Text = "队伍唯一：装备者「狂气爆发」造成的护盾和力量提高 <WeaponEffect_Num:[StateArg1]%>。装备者「防御」造成的护盾提高<WeaponEffect_Num:[StateArg2]%>。装备者打出「防御」后获得装备者攻击力 <WeaponEffect_Num:[StateArg3]%> 的力量。"
  },
  State_148540_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 算力最高的 [StateArg1] 张指令卡算力消耗降低 [StateArg2]。"
  },
  State_148540_Name = {
    Text = "预见之镜 - 延迟[Layer]"
  },
  State_148541_Name = {
    Text = "移除手中选择唤醒体卡牌的「迟缓」效果"
  },
  State_148544_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 下次狂气爆发每消耗 1 点狂气就获得 [StateArg1] 点银钥能量。"
  },
  State_148544_Name = {
    Text = "恶魔之钥 - 延迟[Layer]"
  },
  State_148547_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂气爆发视为超限爆发，若已为超限爆发则返还 100% 基础狂气。"
  },
  State_148547_Name = {
    Text = "永恒之冠"
  },
  State_148548_Desc = {
    Text = "保留：所有唤醒体获得 5 点狂气。"
  },
  State_148548_Name = {
    Text = "敛入倒影"
  },
  State_148549_Name = {
    Text = "触发手中所有「预备」效果"
  },
  State_148553_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 打出的下 [Layer] 张指令卡获得等同于 [StateArg2]％ 已损失生命的护盾。"
  },
  State_148553_Name = {
    Text = "引诱之果 - 延迟[Layer]"
  },
  State_148554_Desc = {
    Text = "<AwakerName:[DescArg1]> 指令卡造成的伤害附加 [Layer]％ 出血。"
  },
  State_148554_Name = {
    Text = "必灭之眼"
  },
  State_148556_Desc = {
    Text = "位于手中时，所有唤醒体造成主动伤害时附加 10％ 出血。"
  },
  State_148556_Name = {
    Text = "噩梦如期而至"
  },
  State_148557_Desc = {
    Text = "<AwakerName:[DescArg1]> 打出的下 [Layer] 张指令卡获得等同于 [StateArg1]％ 已损失生命的护盾。"
  },
  State_148557_Name = {
    Text = "引诱之果"
  },
  State_148559_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂气爆发每消耗 1 点狂气就获得 [Layer] 点银钥能量。"
  },
  State_148559_Name = {
    Text = "恶魔之钥"
  },
  State_148561_Desc = {
    Text = "此卡打出时，从以下三个负面效果中随机触发一个：效果降低 50％/延迟 2 回合生效/随机获得 1 个负面效果。"
  },
  State_148561_Name = {
    Text = "<ExclamationPointColour:扭曲心愿>"
  },
  State_148562_Name = {
    Text = "选择的唤醒体获得 10 点狂气"
  },
  State_148563_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 下次狂气爆发获得的护盾和生命回复提高 [StateArg1]％。"
  },
  State_148563_Name = {
    Text = "公正之羽 - 延迟[Layer]"
  },
  State_148566_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂气爆发造成的伤害附加 [Layer]％ 命运裁断。"
  },
  State_148566_Name = {
    Text = "命运之丝"
  },
  State_148569_Desc = {
    Text = "<AwakerName:[DescArg1]> 下次狂气爆发获得的护盾和生命回复提高 [Layer]％。"
  },
  State_148569_Name = {
    Text = "公正之羽"
  },
  State_148571_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 指令卡造成的伤害附加 [StateArg1]％ 出血。"
  },
  State_148571_Name = {
    Text = "必灭之眼 - 延迟[Layer]"
  },
  State_148574_Desc = {
    Text = "延迟[Layer] ：<AwakerName:[DescArg1]> 下次狂气爆发造成的伤害附加 [StateArg1]％ 命运裁断。"
  },
  State_148574_Name = {
    Text = "命运之丝 - 延迟[Layer]"
  },
  State_148575_Name = {
    Text = "选择的唤醒体获得 20 点狂气"
  },
  State_149089_Name = {
    Text = "状态@提灯犬小吞食狂气标识"
  },
  State_149092_Desc = {
    Text = "吞食了「<AwakerName:[DescArg1]>」 <Energy:[Energy:DescArg2]> 点狂气，死亡后返还。"
  },
  State_149092_Name = {Text = "吞食"},
  State_149094_Desc = {
    Text = "队伍唯一：装备者狂气爆发造成基础的护盾提高 <WeaponEffect_Num:[StateArg1]%>。装备者打出造成<WeaknessIconKeywords:虚弱>的指令卡后，使下一张装备者指令卡造成的基础护盾提高 <WeaponEffect_Num:[StateArg1]%>。使用「猩红熔炉」时抽一张装备者算力消耗最高的技能卡，<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num: [StateArg1]>，3 回合冷却。"
  },
  State_149094_WeaponDesc = {
    Text = "装备者狂气爆发造成基础的护盾提高 <WeaponEffect_Num:[StateArg1]%>。装备者打出造成<WeaknessIconKeywords:虚弱>的指令卡后，使下一张装备者指令卡造成的基础护盾提高 <WeaponEffect_Num:[StateArg1]%>。使用「猩红熔炉」时抽一张装备者算力消耗最高的技能卡，<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num: [StateArg1]>，3 回合冷却。"
  },
  State_149122_Desc = {
    Text = "死亡后立刻召唤一名随机的「哈提猎群」或「斯库尔猎群」，使其「集群效应」降低 1 层。"
  },
  State_149122_Name = {
    Text = "集群效应"
  },
  State_149123_Desc = {
    Text = "受到狂气爆发的伤害降低 50%。"
  },
  State_149123_Name = {
    Text = "灯芯化·熔"
  },
  State_149124_Desc = {
    Text = "受到指令卡的伤害降低 50%。"
  },
  State_149124_Name = {
    Text = "灯芯化·影"
  },
  State_149125_Desc = {
    Text = "冻结了「<AwakerName:[DescArg1]>」的指令卡，死亡后解除该唤醒体的冻结。"
  },
  State_149125_Name = {Text = "吞食"},
  State_149126_Desc = {
    Text = "死亡后立刻召唤一名随机的「斯库尔猎群」，使其「集群效应」降低 1 层。"
  },
  State_149126_Name = {
    Text = "集群效应"
  },
  State_149128_Name = {
    Text = "状态@冰雪提灯犬小冻结卡牌标识"
  },
  State_149140_Desc = {
    Text = "会使敌人的技能得到增幅。每当受到伤害时失去一层。"
  },
  State_149140_Name = {Text = "血誓"},
  State_149143_Desc = {
    Text = "抽牌阶段结束后，敌方手中每有 [DescArg1] 张<SlowIconKeywords:迟缓>指令卡，就使自身获得 [DescArg2] 层<BloodOath_New:血誓>。自身造成未被格挡的伤害后随机为手牌或抽牌堆中 [DescArg3] 张未被<SlowIconKeywords:迟缓>的指令卡施加 [DescArg4] 层<SlowIconKeywords:迟缓>。"
  },
  State_149143_Name = {
    Text = "凝滞血誓"
  },
  State_149162_Desc = {
    Text = "造成未被格挡的伤害时，移除死亡抵抗"
  },
  State_149162_Name = {
    Text = "极东巫术"
  },
  State_149163_Desc = {
    Text = "最大生命降低等量层数，战斗结束后减半。"
  },
  State_149163_Name = {
    Text = "<BoneHitKeywords:刺骨>"
  },
  State_149164_Desc = {
    Text = "造成伤害施加刺骨"
  },
  State_149164_Name = {
    Text = "刺骨寒霜"
  },
  State_149167_Desc = {
    Text = "最大生命降低 [Layer] ，战斗结束后减半。"
  },
  State_149167_Name = {
    Text = "<BlueKeyWord:刺骨>"
  },
  State_149169_Desc = {
    Text = "每层提高等同于卡拉布 15% 体质的生命上限，「饱餐」至多积攒 50 层。获得该状态时若已到达上限，每超出 1 层则改为回复 3 倍等量的生命。每场非首领战至多获得 10 层「饱餐」。战斗结束时不清除。"
  },
  State_149169_Name = {
    Text = "<WormGrowth2:饱餐>"
  },
  State_149172_Desc = {
    Text = "队伍唯一：装备者打出造成<WeaknessIconKeywords:虚弱>的指令卡后，使下一张装备者的指令卡造成的基础护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_149172_WeaponDesc = {
    Text = "装备者打出造成<WeaknessIconKeywords:虚弱>的指令卡后，使下一张装备者的指令卡造成的基础护盾提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_149187_Desc = {
    Text = "测试｜监听受到固定伤害后、固定伤害造成击杀后，并打印触发值、关联者。"
  },
  State_149187_Name = {
    Text = "测试固定伤害"
  },
  State_149188_Desc = {
    Text = "测试｜固定伤害造成击杀后，触发值1，击杀实际伤害:[Layer]"
  },
  State_149188_Name = {
    Text = "测试固杀触发值2"
  },
  State_149189_Desc = {
    Text = "测试｜固定伤害造成击杀后，关联者2， 造成击杀的来源:[Layer]"
  },
  State_149189_Name = {
    Text = "测试固杀关联者2"
  },
  State_149190_Desc = {
    Text = "测试｜固定伤害造成击杀后，触发值1，击杀溢出伤害:[Layer]"
  },
  State_149190_Name = {
    Text = "测试固杀触发值3"
  },
  State_149191_Desc = {
    Text = "测试｜受到固定伤害后，触发值1，总伤害:[Layer]"
  },
  State_149191_Name = {
    Text = "测试固伤触发值1"
  },
  State_149192_Desc = {
    Text = "测试｜固定伤害造成击杀后，关联者1，被击杀者:[Layer]"
  },
  State_149192_Name = {
    Text = "测试固杀关联者1"
  },
  State_149193_Desc = {
    Text = "测试｜受到固定伤害后，关联者2， 受击者:[Layer]"
  },
  State_149193_Name = {
    Text = "测试固伤关联者2"
  },
  State_149194_Desc = {
    Text = "测试｜受到固定伤害后，触发值1，总伤害:[Layer]"
  },
  State_149194_Name = {
    Text = "测试固伤触发值2"
  },
  State_149195_Desc = {
    Text = "测试｜固定伤害造成击杀后，触发值1，击杀总伤害:[Layer]"
  },
  State_149195_Name = {
    Text = "测试固杀触发值1"
  },
  State_149196_Desc = {
    Text = "测试｜受到固定伤害后，关联者1，伤害来源:[Layer]"
  },
  State_149196_Name = {
    Text = "测试固伤关联者1"
  },
  State_149227_Desc = {
    Text = "回合结束时护盾不会消失。拥有护盾时受到狂气爆发伤害提高 50%，受到指令卡的伤害降低 50%。"
  },
  State_149227_Name = {
    Text = "雪幕隐踪"
  },
  State_149228_Desc = {
    Text = "造成伤害施加出血"
  },
  State_149228_Name = {Text = "穿血"},
  State_149229_Desc = {
    Text = "出场时失去 25% 最大生命，转化为 [DescArg1]% 失去值的「霜盾」。"
  },
  State_149229_Name = {
    Text = "霜盾转化"
  },
  State_149230_Desc = {
    Text = "受到指令卡伤害提高 50%，受到狂气爆发伤害降低 50%。"
  },
  State_149230_Name = {
    Text = "状态@黯色外衣增减伤"
  },
  State_149232_Desc = {
    Text = "回合结束时护盾不会消失。拥有护盾时受到指令卡伤害提高 50%，受到狂气爆发伤害降低 50%。"
  },
  State_149232_Name = {
    Text = "黯影隐踪"
  },
  State_149233_Desc = {
    Text = "受到狂气爆发伤害提高 50%，受到指令卡伤害降低 50%。"
  },
  State_149233_Name = {
    Text = "状态@雪色外衣增减伤"
  },
  State_149234_Desc = {
    Text = "出场时失去 25% 最大生命，转化为 [DescArg1]% 失去值的「咒盾」。"
  },
  State_149234_Name = {
    Text = "咒盾转化"
  },
  State_149235_Desc = {
    Text = "造成未被格挡的伤害时，移除死亡抵抗"
  },
  State_149235_Name = {
    Text = "提灯巫术"
  },
  State_149250_Desc = {
    Text = "承受指令卡伤害+50%"
  },
  State_149250_Name = {
    Text = "承受指令卡伤害+50%"
  },
  State_149251_Desc = {
    Text = "承受指令卡伤害-50%"
  },
  State_149251_Name = {
    Text = "承受指令卡伤害-50%"
  },
  State_149252_Desc = {
    Text = "受到的狂气爆发伤害-50%"
  },
  State_149252_Name = {
    Text = "受到的狂气爆发伤害-50%"
  },
  State_149253_Desc = {
    Text = "受到的狂气爆发伤害+50%"
  },
  State_149253_Name = {
    Text = "受到的狂气爆发伤害+50%"
  },
  State_149265_Desc = {
    Text = "死亡后立刻召唤一名随机的「温迪戈」 ，使其「集群效应」降低 1 层。"
  },
  State_149265_Name = {
    Text = "集群效应"
  },
  State_149268_Desc = {
    Text = "失去所有护盾时，获得 75 层临时加固并移除 1 层「没入风雪」，将意图替换为会施加<BoneHitKeywords:刺骨>的强力攻击。"
  },
  State_149268_Name = {
    Text = "没入风雪"
  },
  State_149269_Desc = {
    Text = "失去所有护盾时，获得 75 层临时加固并移除 1 层「没入暗影」，将意图替换为会夺取狂气的强力攻击。"
  },
  State_149269_Name = {
    Text = "没入暗影"
  },
  State_149270_Desc = {
    Text = "死亡后立刻召唤一名随机的「温迪戈」 ，使其「集群效应」降低 1 层。"
  },
  State_149270_Name = {
    Text = "集群效应"
  },
  State_149308_Name = {
    Text = "状态@提灯祈祷者迟缓层数记录"
  },
  State_149391_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会回复生命并获得 1 层<InvincibleUntilRoused:银芯固化>，觉醒后清除<InvincibleUntilRoused:银芯固化>并以真正的形态开始战斗。"
  },
  State_149391_Name = {
    Text = "尚未觉醒"
  },
  State_149398_Desc = {
    Text = "「白雪仙女」意图切换至「粉雪魔咒」时消耗 1 层，将意图变化为「奇迹赐福」。"
  },
  State_149398_Name = {Text = "饱餐"},
  State_149399_Desc = {
    Text = "「白雪仙女」释放「童话天衣无缝」后下 [DescArg1] 个意图均为「粉雪魔咒」。每回合将 [DescArg2] 张具有 [DescArg3] 层<SlowIconKeywords:迟缓>的随机<Blessing:赐福>洗入牌库。"
  },
  State_149399_Name = {
    Text = "诱人蜜果"
  },
  State_149418_Desc = {
    Text = "无法暴击，不视为基础伤害，且不受最终伤害等加成影响。"
  },
  State_149418_Name = {
    Text = "<RealDamage:固定伤害>"
  },
  State_149419_Name = {
    Text = "<Rune_6:铁壁>"
  },
  State_149420_Name = {
    Text = "<Rune_3:妙手>"
  },
  State_149421_Name = {
    Text = "<Rune_15:爆发>"
  },
  State_149422_Name = {
    Text = "<Rune_4:筹算>"
  },
  State_149423_Name = {
    Text = "<Rune_11:统御>"
  },
  State_149424_Name = {
    Text = "<Rune_12:嗜血>"
  },
  State_149425_Name = {
    Text = "<Rune_1:易伤>"
  },
  State_149426_Name = {
    Text = "<Rune_14:蛮力>"
  },
  State_149427_Name = {
    Text = "<Rune_2:虚弱>"
  },
  State_149428_Name = {
    Text = "<Rune_9:尖刺>"
  },
  State_149429_Name = {
    Text = "<Rune_10:毒素>"
  },
  State_149430_Name = {
    Text = "<Rune_18:衰竭>"
  },
  State_149576_Desc = {
    Text = "「白雪仙女」意图切换至「粉雪魔咒」时消耗 1 层，将意图变化为「奇迹赐福」。"
  },
  State_149576_Name = {Text = "饱餐"},
  State_149618_Desc = {
    Text = "2 回合后，触发以下效果：\n获得 [DescArg1] 点算力。 \n获得 [DescArg2] 点力量。 \n获得 [DescArg3] 点银钥能量。 \n获得 [DescArg5] 点狂气。 \n抽 [DescArg6] 张牌。\n获得 [DescArg7] 点临时伤害强效。\n使所有敌人临时降低 [DescArg4] 点力量。"
  },
  State_149618_Name = {
    Text = "错失良机2"
  },
  State_149619_Desc = {
    Text = "1 回合后，触发以下效果：\n获得 [DescArg1] 点算力。 \n获得 [DescArg2] 点力量。 \n获得 [DescArg3] 点银钥能量。 \n获得 [DescArg5] 点狂气。 \n抽 [DescArg6] 张牌。\n获得 [DescArg7] 点临时伤害强效。\n使所有敌人临时降低 [DescArg4] 点力量。"
  },
  State_149619_Name = {
    Text = "错失良机1"
  },
  State_149628_Desc = {
    Text = "若回合结束前敌方拥有至少 1000 点银钥能量，吞噬 1000 银钥能量。"
  },
  State_149628_Name = {
    Text = "供奉钥能"
  },
  State_149629_Desc = {
    Text = "若回合结束前狂气最高唤醒体拥有至少 100 点狂气，吞噬其 50 点狂气。"
  },
  State_149629_Name = {
    Text = "供奉狂气"
  },
  State_149630_Desc = {
    Text = "若回合结束前敌方拥有至少 1000 点银钥能量，吞噬 1000 银钥能量。"
  },
  State_149630_Name = {
    Text = "供奉钥能"
  },
  State_149631_Desc = {
    Text = "若回合结束前敌方拥有至少 3 点算力，吞噬 3 点算力。"
  },
  State_149631_Name = {
    Text = "供奉算力"
  },
  State_149632_Desc = {
    Text = "若回合结束前敌方拥有至少 3 点算力，吞噬 3 点算力。"
  },
  State_149632_Name = {
    Text = "供奉算力"
  },
  State_149633_Desc = {
    Text = "若弃牌阶段前敌方手牌中剩余至少 4 张指令卡，吞噬随机 2 张指令卡。"
  },
  State_149633_Name = {
    Text = "供奉卡牌"
  },
  State_149634_Desc = {
    Text = "若弃牌阶段前敌方手牌中剩余至少 4 张指令卡，吞噬随机 2 张指令卡。"
  },
  State_149634_Name = {
    Text = "供奉卡牌"
  },
  State_149635_Desc = {
    Text = "若回合结束前狂气最高唤醒体拥有至少 100 点狂气，吞噬其 50 点狂气。"
  },
  State_149635_Name = {
    Text = "供奉狂气"
  },
  State_149652_Desc = {
    Text = "无法暴击，不视为对应唤醒体造成的伤害。"
  },
  State_149652_Name = {
    Text = "<FixedDamage:纯粹伤害>"
  },
  State_149660_Desc = {
    Text = "此卡牌造成的伤害、护盾、力量变化提高 [DescArg2]％，触腕伤害、生命回复、固定中毒、固定反击的最终效果提高 [DescArg1]%，打出后移除。"
  },
  State_149660_Name = {
    Text = "强化 [DescArg1]"
  },
  State_149664_Desc = {
    Text = "每拥有 1 层使该卡牌造成的伤害、固定力量和触腕伤害提高、固定中毒、固定反击最终效果提高 2%；固定护盾、固定生命回复、力量降低的最终效果提高 1%，打出后移除。"
  },
  State_149664_Name = {Text = "强化"},
  State_149719_Name = {
    Text = "免疫PVP纯粹伤害__「仅开发用」"
  },
  State_149736_Desc = {
    Text = "下 [Layer] 张<AwakerName:[DescArg1]>指令卡造成的基础护盾提高 [StateArg1]%。"
  },
  State_149736_Name = {
    Text = "蜜果的谎言"
  },
  State_149744_Desc = {
    Text = "下 [Layer] 张打出的赐福不会触发负面效果"
  },
  State_149744_Name = {
    Text = "仙女护佑"
  },
  State_149772_Desc = {
    Text = "每次受到主动伤害就使所有唤醒体失去 3 狂气，每回合最多生效 5 次。击破护盾后移除「咒盾」状态。"
  },
  State_149772_Name = {Text = "咒盾"},
  State_149773_Desc = {
    Text = "每次受到主动伤害就给予手牌中随机卡牌一层临时「迟缓」，每回合最多生效 5 次。击破护盾后移除「霜盾」状态。"
  },
  State_149773_Name = {Text = "霜盾"},
  State_149782_Desc = {
    Text = "消耗：下回合抽牌后，将 1 张「万化之果」洗入抽牌堆。"
  },
  State_149782_Name = {
    Text = "万化之果"
  },
  State_149787_Desc = {
    Text = "每拥有 1 层，负誓·奥吉尔的指令卡最终伤害提高  [DescArg2]%，回合开始时抽牌数-1，暴击伤害提高 [DescArg3]%，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149787_Name = {
    Text = "<KuangNu1:暗涌>"
  },
  State_149788_Desc = {
    Text = "打出负誓·奥吉尔的「技能」时，消耗 1 层抽 1 张「防御」，在下次打出前获得保留，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149788_Name = {
    Text = "<ShuZui1:自罪>"
  },
  State_149789_Desc = {
    Text = "每拥有 1 层，负誓·奥吉尔的指令卡最终伤害提高 33%，回合开始时抽牌数-1，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149789_Name = {
    Text = "<KuangNu:暗涌>"
  },
  State_149790_Desc = {
    Text = "每拥有 1 层，负誓·奥吉尔的指令卡最终伤害提高  [DescArg2]%，回合开始时抽牌数-1，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149790_Name = {
    Text = "<KuangNu1:暗涌>"
  },
  State_149791_Desc = {
    Text = "打出负誓·奥吉尔的「技能」时，消耗 1 层抽 1 张「防御」，在下次打出前获得保留，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149791_Name = {
    Text = "<ShuZui:自罪>"
  },
  State_149814_Desc = {
    Text = "临时伤害强效 +[Layer]%。"
  },
  State_149814_Name = {
    Text = "临时伤害强效"
  },
  State_149819_Desc = {
    Text = "免疫一切伤害"
  },
  State_149819_Name = {Text = "免疫"},
  State_149892_Desc = {
    Text = "下 [Layer] 张<AwakerName:[DescArg1]>指令卡造成的基础护盾提高 [StateArg1]%。"
  },
  State_149892_Name = {
    Text = "恬美真相"
  },
  State_149913_Name = {
    Text = "状态@巨噬蠕虫宝物特效_汀克特破损"
  },
  State_149914_Name = {
    Text = "状态@巨噬蠕虫宝物特效_威廉破损"
  },
  State_149915_Name = {
    Text = "状态@巨噬蠕虫宝物特效_威廉"
  },
  State_149916_Name = {
    Text = "状态@巨噬蠕虫宝物特效_卡斯托尔破损"
  },
  State_149917_Name = {
    Text = "状态@巨噬蠕虫宝物特效_血链希洛破损"
  },
  State_149918_Name = {
    Text = "状态@巨噬蠕虫回合开始测试"
  },
  State_149919_Name = {
    Text = "状态@巨噬蠕虫宝物特效_汀克特"
  },
  State_149920_Name = {
    Text = "状态@巨噬蠕虫宝物特效_阿拉克涅"
  },
  State_149921_Name = {
    Text = "状态@巨噬蠕虫宝物特效_阿拉克涅破损"
  },
  State_149922_Name = {
    Text = "状态@巨噬蠕虫宝物特效_卡斯托尔"
  },
  State_149923_Name = {
    Text = "状态@巨噬蠕虫宝物特效_血链希洛"
  },
  State_149930_Desc = {
    Text = "每拥有 1 层，负誓·奥吉尔的指令卡最终伤害提高 50%，回合开始时抽牌数-1，上限 [DescArg1] 层，战斗结束时不清除。"
  },
  State_149930_Name = {
    Text = "<KuangNu2:暗涌>"
  },
  State_149931_Desc = {
    Text = "共有 7 种效果，包括：获得力量、抽牌、获得算力、获得银钥能量、临时伤害强效提高、所有唤醒体获得狂气、临时降低所有敌人力量。"
  },
  State_149931_Name = {
    Text = "<Blessing:礼物>"
  },
  State_149933_Name = {
    Text = "状态@怪物卡拉布供奉气泡"
  },
  State_149934_Name = {
    Text = "状态@怪物卡拉布供奉气泡"
  },
  State_149939_Desc = {
    Text = "无法获得护盾，直到回合结束。"
  },
  State_149939_Name = {
    Text = "缚身锁链"
  },
  State_19507_Desc = {
    Text = "下回合开始之前承受的主动攻击伤害和出血层数提高 25 %，施加时与加固抵消。"
  },
  State_19507_Name = {
    Text = "<PVPVulnerabilityIconColour:易伤>"
  },
  State_19508_Desc = {
    Text = "回合结束时，丢弃此牌。"
  },
  State_19508_Name = {
    Text = "<PVPVoidKeyColour:虚无>"
  },
  State_19509_Desc = {
    Text = "临时改变卡牌算力。__「仅开发用」"
  },
  State_19509_Name = {
    Text = "永久改变卡牌算力__「仅开发用」"
  },
  State_19511_Desc = {
    Text = "死亡后将手牌替换为幻象__「仅开发用」"
  },
  State_19511_Name = {
    Text = "死亡手牌替换幻象触发器__「仅开发用」"
  },
  State_19513_Name = {
    Text = "施加死斗__「仅开发用」"
  },
  State_19516_Name = {
    Text = "临时改变卡牌算力__「仅开发用」"
  },
  State_19517_Desc = {
    Text = "每损失2%生命，获得1点狂气__「仅开发用」"
  },
  State_19517_Name = {
    Text = "受到伤害获得狂气__「仅开发用」"
  },
  State_19519_Desc = {
    Text = "使用「打击」后消耗所有层数，每层使本次「打击」造成的伤害提高 50%，最多可堆叠 5 层。（当前共提高 [DescArg1]% ）"
  },
  State_19519_Name = {Text = "蓄力"},
  State_19521_Desc = {
    Text = "每层使本场战斗内造成的所有伤害提高 1 点，无法驱散。"
  },
  State_19521_Name = {
    Text = "<PowerColourKeywords:力量>"
  },
  State_19522_Name = {
    Text = "临时改变卡牌算力__「仅开发用」"
  },
  State_19523_Name = {
    Text = "永久改变卡牌算力__「仅开发用」"
  },
  State_19524_Desc = {
    Text = "下回合开始之前，每次受到攻击对攻击者造成 [Layer] 点纯粹伤害。"
  },
  State_19524_Name = {Text = "反击"},
  State_19525_Desc = {
    Text = "回合开始前移除唤醒体护盾__「仅开发用」"
  },
  State_19525_Name = {
    Text = "回合开始前移除角色护盾__「仅开发用」"
  },
  State_19527_Desc = {
    Text = "每层使「技能」本回合算力消耗+1，最多3层，打出后若层数大于 1 则层数-1。"
  },
  State_19527_Name = {
    Text = "<SlowColour:迟缓>"
  },
  State_19528_Desc = {
    Text = "拥有强大效果的卡牌。"
  },
  State_19528_Name = {
    Text = "<SilverKeyColour:钥令>"
  },
  State_19529_Desc = {
    Text = "可以打出 [Layer] 次，每次打出其他牌使此牌下次打出时算力消耗 -1。"
  },
  State_19529_Name = {
    Text = "<CardKeyWord:幻影 [Layer]>"
  },
  State_19530_Desc = {
    Text = "·被对手优先攻击，并且对手在选择单体目标时仅能选择嘲讽唤醒体\n·在获得嘲讽时解除自身的潜行和其他友方的嘲讽，同时驱散敌方的潜行。"
  },
  State_19530_Name = {
    Text = "<TauntColour:嘲讽>"
  },
  State_19532_Desc = {
    Text = "本回合结束之前造成的伤害降低 [DescArg1] %，施加时与强化抵消。"
  },
  State_19532_Name = {Text = "虚弱"},
  State_19533_Desc = {
    Text = "本回合结束之前造成的伤害降低 50 %，施加时与强化抵消。"
  },
  State_19533_Name = {
    Text = "<WeaknessColour:虚弱>"
  },
  State_19534_Desc = {
    Text = "下回合开始之前承受的主动攻击伤害和出血层数提高 [DescArg1] %，施加时与加固抵消。"
  },
  State_19534_Name = {Text = "易伤"},
  State_19535_Desc = {
    Text = "·被对手优先攻击，并且对手在选择单体目标时仅能选择嘲讽唤醒体\n·在获得嘲讽时解除自身的潜行和其他友方的嘲讽，同时驱散敌方的潜行。"
  },
  State_19535_Name = {Text = "嘲讽"},
  State_19536_Desc = {
    Text = "回合结束时获得 10 狂气__「仅开发用」"
  },
  State_19536_Name = {
    Text = "回合结束获得狂气触发器__「仅开发用」"
  },
  State_19537_Desc = {
    Text = "本回合结束之前造成的伤害提高 [DescArg1] %，施加时与虚弱抵消。"
  },
  State_19537_Name = {Text = "强化"},
  State_19538_Desc = {
    Text = "·在第 8 和 9 回合开始时各获得 1 层\n·每层死斗使受到的护盾和生命回复降低50%同时屏障的可堆叠层数 - 1 \n·死斗无法驱散且对死亡唤醒体也有效。"
  },
  State_19538_Name = {Text = "死斗"},
  State_19540_Name = {
    Text = "算力上限"
  },
  State_19541_Desc = {
    Text = "回合结束之前无法进行任何行动。"
  },
  State_19541_Name = {Text = "昏迷"},
  State_19544_Desc = {
    Text = "使用「打击」后消耗所有层数，每消耗一层使本次「打击」造成的伤害提高 50%，最多可堆叠 5 层。"
  },
  State_19544_Name = {
    Text = "<EnergyStorageColour:蓄力>"
  },
  State_19545_Name = {
    Text = "此卡视为「打击」__「仅开发用」"
  },
  State_19546_Desc = {
    Text = "打出前改变卡牌算力。__「仅开发用」"
  },
  State_19546_Name = {
    Text = "打出前改变卡牌算力__「仅开发用」"
  },
  State_19547_Desc = {
    Text = "回合结束时受到 [Layer] 点纯粹伤害，永续。"
  },
  State_19547_Name = {Text = "中毒"},
  State_19549_Desc = {
    Text = "下回合开始之前承受的主动攻击伤害降低 50 %，施加时与易伤抵消。"
  },
  State_19549_Name = {
    Text = "<ReinforceColour:加固>"
  },
  State_19552_Desc = {
    Text = "当前拥有 [Layer] 点护盾，护盾不会大于最大生命，持续 1 回合。"
  },
  State_19552_Name = {Text = "护盾"},
  State_19553_Desc = {
    Text = "抽牌阶段后获得后发制人__「仅开发用」"
  },
  State_19553_Name = {
    Text = "后发制人触发器__「仅开发用」"
  },
  State_19554_Name = {
    Text = "空状态__「仅开发用」"
  },
  State_19555_Desc = {
    Text = "·本回合「技能」算力消耗+[Layer]，最多 3 层。\n·打出「技能」后若层数大于 1 ，层数-1 。"
  },
  State_19555_Name = {Text = "迟缓"},
  State_19556_Desc = {
    Text = "回合结束时，此牌算力消耗 -[Layer]。"
  },
  State_19556_Name = {
    Text = "<PrepareKeywords:预备 [Layer] >"
  },
  State_19557_Desc = {
    Text = "下回合开始之前承受的主动攻击伤害降低 [DescArg1] %，施加时与易伤抵消。"
  },
  State_19557_Name = {Text = "加固"},
  State_19558_Name = {
    Text = "复活牌库加牌触发器__「仅开发用」"
  },
  State_19560_Desc = {
    Text = "回合结束之前无法使用狂气爆发。"
  },
  State_19560_Name = {Text = "封印"},
  State_19561_Name = {
    Text = "可以使用 3 次"
  },
  State_19990_Desc = {
    Text = "下回合开始时，获得 [Layer] 狂气。"
  },
  State_19990_Name = {
    Text = "延迟狂气"
  },
  State_19992_Desc = {
    Text = "回合结束之前无法进行任何行动，在受到昏迷伤害后会使目标获得抗性。拥有抗性时再次受到昏迷伤害时抵消昏迷效果并使伤害翻倍。"
  },
  State_19992_Name = {
    Text = "<ComaColour:昏迷>"
  },
  State_19995_Desc = {
    Text = "回合结束时造成等量于层数的纯粹伤害，永续。"
  },
  State_19995_Name = {
    Text = "<IntoxicationColour:中毒>"
  },
  State_19996_Desc = {
    Text = "本回合结束之前造成的伤害提高25 %，施加时与虚弱抵消。"
  },
  State_19996_Name = {
    Text = "<StrengthenColour:强化>"
  },
  State_19998_Desc = {
    Text = "下回合开始之前，每次受到攻击对攻击者造成等量层数的纯粹伤害。"
  },
  State_19998_Name = {
    Text = "<RetaliateColour:反击>"
  },
  State_20012_Desc = {
    Text = "每点剩余算力使你下回合开始抽 1 张牌；每张剩余手牌使你下回合开始获得 1 算力。"
  },
  State_20012_Name = {
    Text = "异化先贤断章"
  },
  State_20012_WeaponDesc = {
    Text = "每点剩余算力使你下回合开始抽 1 张牌；每张剩余手牌使你下回合开始获得 1 算力。"
  },
  State_20013_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。将每回合打出的第 1 张牌重新置入手中。超维回合开始时，当回合手牌上限 +5 并复制你的手牌。"
  },
  State_20013_Name = {
    Text = "状态@时灵摆镜"
  },
  State_20014_Name = {
    Text = "时灵摆「迷失」"
  },
  State_20016_Name = {
    Text = "造物魔术手套"
  },
  State_20017_Desc = {
    Text = "下一次跃迁效果必定触发。"
  },
  State_20017_Name = {Text = "跃迁"},
  State_20021_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。将每回合打出的第 1 张牌重新置入手中。超维回合开始时，当回合手牌上限 +5 并复制你的手牌。"
  },
  State_20021_Name = {
    Text = "状态@时灵摆镜"
  },
  State_20023_Desc = {
    Text = "战斗开始后，将两张狂气充能塞入牌库。"
  },
  State_20023_Name = {
    Text = "混沌缝合体"
  },
  State_20023_WeaponDesc = {
    Text = "战斗开始后，将两张狂气充能塞入牌库。"
  },
  State_20024_Desc = {
    Text = "每次释放狂气爆发，获得一张能够施加 [Arg1] 点中毒的「毒性侵染」。回合结束时若手中每 3 张「毒性侵染」可以合成一张触发中毒的 「毒性发作」。"
  },
  State_20024_Name = {
    Text = "状态@造物异化异种喉舌"
  },
  State_20026_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中并触发后续效果。"
  },
  State_20026_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_20026_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_20028_Desc = {
    Text = "<ProficientInRealmsIconKeywords:界域精通>提高 100。每打出 1 张牌胚胎融合 +10，生命低于 25% 时提高为 20，每回合最多生效 10 次。"
  },
  State_20028_Name = {
    Text = "状态@时灵摆侵食"
  },
  State_20029_Desc = {
    Text = "每次释放狂气爆发，获得一张能够施加 [Arg1] 点中毒的「毒性侵染」。回合结束时若手中每 3 张「毒性侵染」可以合成一张触发中毒的 「毒性发作」。"
  },
  State_20029_Name = {
    Text = "状态@造物异化异种喉舌"
  },
  State_20035_Name = {
    Text = "状态@时灵摆未眠"
  },
  State_20038_Name = {
    Text = "混沌共生体"
  },
  State_20038_WeaponDesc = {
    Text = "当队伍由混沌与其他职业组成时，回合开始所有唤醒体获得 20 狂气。"
  },
  State_20039_Desc = {
    Text = "若弃牌阶段仍在手牌中，卡牌将被消耗，本场战斗中不再出现。"
  },
  State_20039_Name = {
    Text = "<NothingnessIconKeywords:虚无>"
  },
  State_20039_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_20040_Name = {
    Text = "状态@时灵摆未眠计数"
  },
  State_20041_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 1 算力，抽 1 张牌。主动伤害击杀敌人时，对其他敌人造成等同于双倍过量伤害的出血。"
  },
  State_20041_Name = {
    Text = "异化群氓之歌"
  },
  State_20042_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 25%，击杀敌人后击杀者获得 20 狂气。"
  },
  State_20044_Desc = {
    Text = "造成的虚弱效果提高 10%。每 3 回合对所有敌人添加 1 层虚弱。"
  },
  State_20045_Desc = {
    Text = "下个回合开始后，从牌库中任选 3 张卡置入手牌。"
  },
  State_20045_Name = {
    Text = "时灵摆飞舞"
  },
  State_20306_Name = {
    Text = "造物魔术手套"
  },
  State_20419_Desc = {
    Text = "每造成 1 次伤害，对目标施加 [Arg1] 层中毒。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方中毒。"
  },
  State_20425_Desc = {
    Text = "回合开始时，获得[Layer]点临时<PowerIconKeywords:力量>和护盾。"
  },
  State_20425_Name = {
    Text = "渴血饕餮"
  },
  State_20600_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合前 [StateArg2] 张「技能」消耗的算力 - [StateArg1] 。"
  },
  State_20600_Name = {Text = "明悟"},
  State_20601_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [StateArg1]%。每受到一次攻击，获得 [StateArg2] 层<EnergyStorageKeywords:蓄力>。"
  },
  State_20601_Name = {Text = "暴食"},
  State_20602_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标并且造成 [StateArg1] 层<PVPSlowKeywords:迟缓>，每回合对首个目标触发时效果翻倍。"
  },
  State_20602_Name = {
    Text = "遗忘之手"
  },
  State_20603_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Energy:[Energy:StateArg1]> 狂气。"
  },
  State_20603_Name = {
    Text = "畸体回噬"
  },
  State_20604_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」回复自身 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20604_Name = {Text = "吮吸"},
  State_20605_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时<ComaKeywords:昏迷>自身。「狂气爆发」前驱散全体友方的负面状态。"
  },
  State_20605_Name = {
    Text = "勋爵手杖"
  },
  State_20606_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」使自身获得 <Energy:[Energy:StateArg1]> 狂气。"
  },
  State_20606_Name = {Text = "狂乱"},
  State_20607_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」攻击<HPAndShieldMax:生命与护盾最高>的敌方，并额外造成伤害 [StateArg1]% 的 <PVPBleedingKeywords:出血>。"
  },
  State_20607_Name = {
    Text = "切割与伤害"
  },
  State_20608_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，自身获得 <Energy:[Energy:StateArg1]> 狂气。"
  },
  State_20608_Name = {Text = "呢喃"},
  State_20609_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：因为失去生命而获得的狂气翻倍。"
  },
  State_20609_Name = {Text = "海之梦"},
  State_20610_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [DescArg1]% ，「狂气爆发」后使自身<PVPPowerIconKeywords:力量>+ [StateArg2] 并使「打击」伤害额外提高  [StateArg3]%，最大为 100%。"
  },
  State_20610_Name = {
    Text = "星天之兽"
  },
  State_20611_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」和回合结束时，回复损失生命最多的友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20611_Name = {Text = "希冀"},
  State_20612_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使狂气最低友方获得 <Energy:[Energy:StateArg1]> 狂气并回复损失生命最多的友方 <Heal:[Heal:StateArg2]> 生命。"
  },
  State_20612_Name = {
    Text = "慈悲的哺育"
  },
  State_20613_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，其他友方获得 <Block:[Block:StateArg1]> 护盾。"
  },
  State_20613_Name = {
    Text = "不存在之地"
  },
  State_20614_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 [StateArg1] 临时<PVPRetaliateIconKeywords:反击>。"
  },
  State_20614_Name = {
    Text = "核心熔解"
  },
  State_20615_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次「打击」额外造成 [StateArg1] 伤害，<PVPMethysisKeywords:中毒>。"
  },
  State_20615_Name = {Text = "苦咒缚"},
  State_20616_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时获得 <Energy:[Energy:StateArg1]> 狂气。"
  },
  State_20616_Name = {
    Text = "阿库特之春"
  },
  State_20617_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 <Block:[Block:StateArg1]> 护盾。"
  },
  State_20617_Name = {Text = "放逐"},
  State_20618_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使双方弃掉所有手牌并抽取等量弃牌数 +1 张牌。"
  },
  State_20618_Name = {
    Text = "快乐魔法秀"
  },
  State_20619_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 <Energy:[Energy:StateArg1]> 狂气。友方唤醒体释放「狂气爆发」后，自身获得<DelayKeywords:延迟 1>:  <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_20619_Name = {
    Text = "神王的颂歌"
  },
  State_20620_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 + [StateArg2] 。回合结束时，获得手牌中随机 [StateArg1] 张「技能」的复制。"
  },
  State_20620_Name = {
    Text = "聚首时刻"
  },
  State_20621_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使自身获得<StrengthenKeywords:强化>和<ReinforceKeywords:加固>。"
  },
  State_20621_Name = {
    Text = "跨越疼痛"
  },
  State_20622_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时自身获得 <Energy:[Energy:StateArg1]> 狂气，消耗所有剩余算力，每消耗 1 算力使获得狂气提高 [StateArg3]。"
  },
  State_20622_Name = {
    Text = "隐秘的诞生"
  },
  State_20623_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后抽 [StateArg1] 张牌。"
  },
  State_20623_Name = {Text = "涌现"},
  State_20624_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后优先抽 [StateArg1] 张「技能」，若抽出的是「技能」将其 [StateArg2] 张复制置入手中。"
  },
  State_20624_Name = {
    Text = "好运时间"
  },
  State_20625_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后<DelayKeywords:延迟 1>：回复全体友方  <Heal:[Heal:StateArg1]>  生命。"
  },
  State_20625_Name = {
    Text = "饕餮寓言"
  },
  State_20626_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [StateArg1]% ，并使自身获得<ReinforceKeywords:加固>。"
  },
  State_20626_Name = {
    Text = "坚韧意志"
  },
  State_20627_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，回复全体友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20627_Name = {Text = "眷顾"},
  State_20628_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使其他友方获得 <Energy:[Energy:StateArg1]> 狂气，此效果溢出的狂气将折半返还给装备者。"
  },
  State_20628_Name = {
    Text = "职责所在"
  },
  State_20629_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」造成的伤害、治疗与护盾效果提高[StateArg1]%。"
  },
  State_20629_Name = {
    Text = "以蔷薇之名"
  },
  State_20630_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得 <Block:[Block:StateArg1]> 护盾和 <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_20630_Name = {
    Text = "冬夜追忆"
  },
  State_20631_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」<PVPVulnerabilityIconKeywords:易伤>目标。装备和回合结束时获得 [StateArg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  State_20631_Name = {Text = "临界点"},
  State_20632_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 +[StateArg1]。"
  },
  State_20632_Name = {
    Text = "记忆螺旋"
  },
  State_20633_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次受到敌方主动攻击后，对其造成 [StateArg1] 伤害，<PVPEntanglementKeywords:缠绕>。"
  },
  State_20633_Name = {
    Text = "苍白后裔"
  },
  State_20634_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」「技能」「狂气爆发」造成的伤害、治疗与护盾提高 [DescArg1]%，<PVPGrowthKeywords:成长> [StateArg2]%。"
  },
  State_20634_Name = {Text = "陨日"},
  State_20635_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前使全体友方获得<StrengthenKeywords:强化>。"
  },
  State_20635_Name = {
    Text = "虔诚的伟力"
  },
  State_20636_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，获得一张<PVPDerivativeCardKeywords_2:「幻象」> 。每当手牌上拥有两张<PVPDerivativeCardKeywords_2:「幻象」> 时，将他们合成为一张<PVPDerivativeCardKeywords_12:「小小心愿」>。"
  },
  State_20636_Name = {Text = "熟成"},
  State_20637_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，将 [StateArg1] 张<PVPDerivativeCardKeywords_11:「不平等交换」>洗入抽牌堆。"
  },
  State_20637_Name = {
    Text = "信息就是生命"
  },
  State_20639_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，装备者对<HPAndShieldMax:生命与护盾最高>敌方造成 [StateArg1] 伤害，<PVPMethysisKeywords:中毒>。"
  },
  State_20639_Name = {
    Text = "腐朽赠礼"
  },
  State_20640_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时以及回合开始时，对全体敌方造成 <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:出血>伤害，目标每有一张手牌<PVPBleedingKeywords:出血>伤害 +[StateArg2]。"
  },
  State_20640_Name = {
    Text = "血肉狂宴"
  },
  State_20641_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：死亡后给予其他友方 [StateArg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  State_20641_Name = {
    Text = "死亡的剖析"
  },
  State_20642_Desc = {
    Text = "<PVPHoldingKeywords:持有>：打出卡牌后，此牌变成其他随机「命轮」，并使其算力消耗 -1 。"
  },
  State_20642_Name = {
    Text = "灵魂诞生"
  },
  State_20643_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后获得 [StateArg1] 算力，<DelayKeywords:延迟 1>：扣除 [StateArg2] 算力。"
  },
  State_20643_Name = {
    Text = "记忆症候"
  },
  State_20644_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时对自身造成 [StateArg2] 伤害，<PVPEntanglementKeywords:缠绕>。每有 1 个阵亡友方，<StrongEffectKeywords:强效>+[StateArg1]。"
  },
  State_20644_Name = {
    Text = "至为珍贵的藏品"
  },
  State_20645_Name = {
    Text = "冒险的行囊"
  },
  State_20646_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [StateArg1]% ，「狂气爆发」后回复自身 <Heal:[Heal:StateArg2]> 生命。"
  },
  State_20646_Name = {
    Text = "吞噬摇篮曲"
  },
  State_20647_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后将 [StateArg1] 张<PVPDerivativeCardKeywords_11:「不平等交换」>置入手中。"
  },
  State_20647_Name = {
    Text = "于暴雨之中"
  },
  State_20648_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，获得正面<PVPWonderfulEffectKeywords:奇妙效果>，敌方每回合第一次使用「钥令」时将 [StateArg1] 张「华丽光景」置入手中。"
  },
  State_20648_Name = {
    Text = "无声欢宴"
  },
  State_20649_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后将上回合最后打出的「技能」置入手中，并使其算力消耗 -1，若多次触发该类效果则向前追溯。"
  },
  State_20649_Name = {
    Text = "溯洄时计"
  },
  State_20650_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时<ComaKeywords:昏迷>自身。「狂气爆发」前驱散全体敌方的正面状态。"
  },
  State_20650_Name = {Text = "谵妄"},
  State_20651_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，抽 [StateArg1] 张牌。"
  },
  State_20651_Name = {Text = "贪婪"},
  State_20652_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对全体敌方造成 [StateArg1] 伤害，<DisarmKeywords:麻痹>。"
  },
  State_20652_Name = {Text = "惩戒"},
  State_20653_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标并且扣除目标 <Energy:[Energy:StateArg1]> 狂气。"
  },
  State_20653_Name = {
    Text = "欲海浮沉"
  },
  State_20654_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，<PVPSeriousInjuryKeywords:重创>自身并获得 <Damage:[Damage:StateArg1]> 层<PVPCorrosionKeywords:罪印>。回合结束时，<ReinforceKeywords:加固>自身。"
  },
  State_20654_Name = {
    Text = "女王的戒律"
  },
  State_20655_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」伤害提高 [StateArg1]%，「打击」可以选择目标。"
  },
  State_20655_Name = {Text = "宠爱"},
  State_20656_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」造成的伤害、治疗与护盾效果提高 [StateArg1]% ，使用「技能」后若没有<PVPProtectiveKeywords:屏障>则获得 1 层。"
  },
  State_20656_Name = {
    Text = "诗笺的句尾"
  },
  State_20657_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合对手打出第 [StateArg1] 张「技能」时，将其一张算力消耗 - [StateArg2] 的复制置入你的手中。"
  },
  State_20657_Name = {Text = "洞悉"},
  State_20658_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」每攻击一个目标获得 [StateArg1] 算力。"
  },
  State_20658_Name = {
    Text = "被缚的歌谣"
  },
  State_20659_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：死亡后，下回合开始时<PVPResurrectionKeywords:复活>自身并获得 <Heal:[Heal:StateArg1]> 生命和<Block:[Block:StateArg2]> 护盾并摧毁此「命轮」 。"
  },
  State_20659_Name = {Text = "活性"},
  State_20660_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使全体友方获得 <Block:[Block:StateArg1]> 护盾。"
  },
  State_20660_Name = {
    Text = "心之壁垒"
  },
  State_20661_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后对全体敌方造成 <Damage:[Damage:StateArg1]>  <PVPBleedingKeywords:出血>伤害。"
  },
  State_20661_Name = {
    Text = "迷失的道路"
  },
  State_20662_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，每点<PVPCapKeywords:算力上限>对<HPAndShieldMin:生命与护盾最低>敌方造成 [StateArg1] <PVPBleedingKeywords:出血>，一共造成 <Damage:[Damage:DescArg1]> <PVPBleedingKeywords:出血>伤害。"
  },
  State_20662_Name = {
    Text = "伏于夜色"
  },
  State_20663_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前驱散自身负面状态，并获得 [StateArg1] 层<EnergyStorageKeywords:蓄力>。"
  },
  State_20663_Name = {
    Text = "挣脱锁链之日"
  },
  State_20664_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」使自身获得<ReinforceKeywords:加固>。"
  },
  State_20664_Name = {
    Text = "骑士之心"
  },
  State_20665_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：自身在驱散负面状态时若无可驱散的负面状态则回复 <Heal:[Heal:StateArg1]> 生命。回合结束时，<DelayKeywords:延迟 1>:  驱散自身负面状态。"
  },
  State_20665_Name = {
    Text = "引舵之帆"
  },
  State_20666_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使<HPAndShieldMin:生命与护盾最低>的友方获得 [StateArg1] 层<PVPProtectiveKeywords:屏障>。"
  },
  State_20666_Name = {Text = "致挚友"},
  State_20667_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合打出的第一张装备者的「技能」伤害提高 [StateArg1]%。"
  },
  State_20667_Name = {
    Text = "巨人之刃"
  },
  State_20668_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：我方唤醒体死亡时，对全体敌方造成 <Damage:[Damage:StateArg1]> <PVPBleedingKeywords:出血>伤害。装备者死亡时额外造成 <Damage:[Damage:StateArg2]> <PVPBleedingKeywords:出血>伤害。"
  },
  State_20668_Name = {
    Text = "珊瑚女之死"
  },
  State_20669_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [StateArg1] 层<PVPProtectiveKeywords:屏障>，否则使手中自身算力消耗最高的 1 张「技能」算力消耗 -1。"
  },
  State_20669_Name = {
    Text = "神言石板"
  },
  State_20670_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」造成<PVPSeriousInjuryKeywords:重创>，伤害提高 [StateArg1]%  ，但使自身损失一半伤害的生命。"
  },
  State_20670_Name = {
    Text = "伤痛之鳍"
  },
  State_20671_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后回复自身 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_20671_Name = {
    Text = "超越死亡"
  },
  State_20672_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使一张算力消耗最高的手牌消耗的算力 -[StateArg1]。<PrepareKeywords:预备>。"
  },
  State_20672_Name = {
    Text = "专注精神"
  },
  State_20673_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得 <Block:[Block:StateArg1]> 护盾，其他友方获得 <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_20673_Name = {
    Text = "无法完成的演算"
  },
  State_20696_Name = {
    Text = "状态@巨人之畏"
  },
  State_20723_Desc = {
    Text = "打击卡的伤害提高 [Layer]。__「仅开发用」"
  },
  State_20723_Name = {
    Text = "打击卡固定伤害提高__「仅开发用」"
  },
  State_20724_Desc = {
    Text = "打击卡的伤害减少 [Layer]。__「仅开发用」"
  },
  State_20724_Name = {
    Text = "打击卡固定伤害减少__「仅开发用」"
  },
  State_20749_Desc = {
    Text = "通用追溯计数。__「仅开发用」"
  },
  State_20758_Desc = {
    Text = "下回合开始时，抽 [Layer] 张牌。"
  },
  State_20758_Name = {
    Text = "延迟抽卡"
  },
  State_20766_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_20802_Desc = {
    Text = "该卡牌无法被打出。__「仅开发用」"
  },
  State_20802_Name = {
    Text = "无法打出__「仅开发用」"
  },
  State_20803_Desc = {
    Text = "此牌 -1 算力消耗使用其他卡牌后，此牌会变化为其他随机命轮卡。"
  },
  State_20803_Name = {
    Text = "<CardKeyWord:灵魂诞生>"
  },
  State_20805_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_20805_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_20806_Desc = {
    Text = "打出后不会进入弃牌堆，而是从牌库中移除。"
  },
  State_20806_Name = {
    Text = "<DepleteIconKeywords:消耗>"
  },
  State_20820_Desc = {
    Text = "下回合开始时复活并获得 [Layer] 生命和[Layer] 护盾。"
  },
  State_20820_Name = {
    Text = "延迟复活"
  },
  State_20851_Name = {
    Text = "给与卡牌"
  },
  State_20981_Desc = {
    Text = "「猩红」已经觉醒，造成的伤害会大幅提高。"
  },
  State_20981_Name = {
    Text = "尤乌哈希觉醒！"
  },
  State_20981_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_20982_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_20982_Name = {
    Text = "尚未觉醒"
  },
  State_20988_Desc = {
    Text = "初始狂气 +80。每回合获得 20 点狂气。"
  },
  State_20988_Name = {
    Text = "达芙黛尔·初见"
  },
  State_20989_Desc = {
    Text = "初始狂气 +80。每回合获得 2 点算力，20 点狂气。"
  },
  State_20989_Name = {
    Text = "图鲁·初见"
  },
  State_21306_Desc = {
    Text = "每回合重置连击"
  },
  State_21306_Name = {
    Text = "连击重置"
  },
  State_21307_Desc = {
    Text = "每层使攻击次数加1，受到伤害失去 1 层，最低为 1 层，在回合结束时失去全部。"
  },
  State_21307_Name = {Text = "连击"},
  State_21342_Desc = {
    Text = "下回合开始时，获得 [Layer] 治疗。"
  },
  State_21342_Name = {
    Text = "延迟治疗"
  },
  State_21345_Desc = {
    Text = "在神降仪式开始前，死亡后会复活，解除负面状态，免疫伤害并恢复 30% 生命。在神降仪式开始后，死亡后会完全复活，解除负面状态和仪式执念，并呼唤两名眷族。"
  },
  State_21345_Name = {
    Text = "仪式执念"
  },
  State_21358_Desc = {
    Text = "该玩家手牌没有上限。__「仅开发用」"
  },
  State_21381_Name = {
    Text = "封印使用次数计数"
  },
  State_21385_Desc = {
    Text = "每失去 1 点生命降低 1 层。层数降低为 0 时，将意图转换为高额伤害的狂气爆发并会解除石化效果。"
  },
  State_21385_Name = {
    Text = "血之狂暴"
  },
  State_21450_Desc = {
    Text = "下回合开始时，驱散自身的负面状态。"
  },
  State_21450_Name = {
    Text = "延迟净化"
  },
  State_21488_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_21492_Desc = {
    Text = "伤害在暴击时会提高50%。"
  },
  State_21492_Name = {
    Text = "<CardKeyWord:暴击>"
  },
  State_21546_Desc = {
    Text = "下回合开始时，获得 [Layer] 护盾。"
  },
  State_21546_Name = {
    Text = "延迟护盾"
  },
  State_21547_Desc = {
    Text = "回合开始时，保留一半护盾。"
  },
  State_21547_Name = {Text = "坚毅"},
  State_21548_Desc = {
    Text = "下回合开始时，获得强化。"
  },
  State_21548_Name = {
    Text = "延迟强化"
  },
  State_21580_Desc = {
    Text = "猎颅者正在追踪你行动的痕迹，每抽 1 张牌，猎颅者获得 [StateArg1] 临时力量。"
  },
  State_21580_Name = {Text = "寻踪"},
  State_21587_Name = {
    Text = "本回合已找到新的随机唤醒体"
  },
  State_21590_Name = {
    Text = "尝试寻找新唤醒体次数"
  },
  State_21601_Name = {
    Text = "已找到新唤醒体"
  },
  State_21616_Desc = {
    Text = "使用狂气爆发后封印所有唤醒体一回合。"
  },
  State_21616_Name = {
    Text = "行道之骸"
  },
  State_21671_Name = {
    Text = "造成范围伤害__「仅开发用」"
  },
  State_21688_Name = {
    Text = "可以使用 1 次"
  },
  State_21689_Name = {
    Text = "可以使用 2 次"
  },
  State_21720_Desc = {
    Text = "目标身后的数个唤醒体也承受相同效果。"
  },
  State_21720_Name = {
    Text = "<CardKeyWord:贯穿>"
  },
  State_21726_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备者每回合第一次打出「技能」后，将其一张算力消耗 - [StateArg1] 的复制洗入抽牌堆。"
  },
  State_21726_Name = {
    Text = "旋转，旋转"
  },
  State_21744_Name = {
    Text = "尝试寻找新唤醒体次数"
  },
  State_21745_Name = {
    Text = "已找到新唤醒体"
  },
  State_21746_Name = {
    Text = "本回合已找到新的随机唤醒体"
  },
  State_21747_Desc = {
    Text = "有[Layer]名唤醒体正在被狩猎，被狩猎唤醒体每使用一张卡牌，「暴走猎颅者」叠加1层狩猎印记。"
  },
  State_21747_Name = {
    Text = "狩猎仪式"
  },
  State_21751_Desc = {
    Text = "抽狩猎印记层数一半的牌([DescArg1])，「暴走猎颅者」的狩猎印记层数+1。"
  },
  State_21751_Name = {
    Text = "<CardKeyWord:被狩猎>"
  },
  State_21754_Desc = {
    Text = "死亡后，驱散「暴走猎颅者」的全部临时力量并将其「狩猎印记」层数减半。"
  },
  State_21754_Name = {
    Text = "短暂解脱"
  },
  State_21765_Desc = {
    Text = "·可以给一名友方唤醒体装备「命轮」，使其发挥「命轮」效果。\n·为一名唤醒体重复装备「命轮」时，会摧毁旧的「命轮」保留新的「命轮」。\n·唤醒体死亡后其装备的「命轮」会被摧毁。\n·若给死亡的唤醒体装备「命轮」则会摧毁该「命轮」，并获得一张幻象和返还消耗算力。"
  },
  State_21765_Name = {
    Text = "<PVPWeaponKeywords:命轮>"
  },
  State_21785_Name = {
    Text = "战斗喊话"
  },
  State_21787_Name = {
    Text = "添加战斗喊话"
  },
  State_21826_Name = {
    Text = "孩子王开场喊话"
  },
  State_21829_Name = {
    Text = "亡语效果"
  },
  State_21838_Name = {
    Text = "开场介绍"
  },
  State_21843_Name = {
    Text = "开场加状态"
  },
  State_21895_Name = {
    Text = "开场喊话"
  },
  State_21905_Desc = {
    Text = "「打击」获得 2 点算力，随机弃 1 张牌；「防御」抽 2 张牌，失去 1 点算力。"
  },
  State_21928_Name = {Text = "提示"},
  State_22054_Name = {
    Text = "开场喊话"
  },
  State_22055_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_22055_Name = {
    Text = "尚未觉醒"
  },
  State_22067_Desc = {
    Text = "回合结束后，使 1 条触腕攻击 [Layer] 次。"
  },
  State_22067_Name = {
    Text = "触腕集结"
  },
  State_22074_Desc = {
    Text = "存活第七回合转变意图为凝视，八回合及以上转变意图为亵渎。"
  },
  State_22134_Desc = {
    Text = "穿刺伤害会同时损伤目标的生命、护盾、屏障。"
  },
  State_22134_Name = {
    Text = "<CardKeyWord:穿刺伤害>"
  },
  State_22157_Desc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为等量生命的「洋流」和「潮汐」。"
  },
  State_22157_Name = {Text = "分裂"},
  State_22204_Desc = {
    Text = "回合开始后获得 [Layer]% 临时暴击率和临时暴击伤害。"
  },
  State_22204_Name = {
    Text = "绵音渐响"
  },
  State_22204_WeaponDesc = {
    Text = "直到下回合开始前未损失生命，下回合暴击率 +[StateArg1]%。"
  },
  State_22210_Desc = {
    Text = "算力消耗 + 100，并且无法使用打击、无法获得狂气。"
  },
  State_22210_Name = {
    Text = "超级迟缓"
  },
  State_22238_Name = {
    Text = "玩家死斗__「仅开发用」"
  },
  State_22239_Name = {
    Text = "施加玩家死斗__「仅开发用」"
  },
  State_22249_Desc = {
    Text = "下个回合开始后，少抽 [Layer] 张牌。"
  },
  State_22249_Name = {
    Text = "不平等交换"
  },
  State_22300_Desc = {
    Text = "该打击卡无法打出卡牌。__「仅开发用」"
  },
  State_22300_Name = {
    Text = "打击卡缴械无法打出__「仅开发用」"
  },
  State_22303_Desc = {
    Text = "每次受到伤害就给予手牌中随机卡牌一层临时「迟缓」，击破护盾后移除「霜盾」状态。"
  },
  State_22303_Name = {Text = "霜盾"},
  State_22324_Desc = {
    Text = "每有1层，本回合增加1段攻击"
  },
  State_22324_Name = {
    Text = "怒涛回响"
  },
  State_22325_Desc = {
    Text = "每次受到攻击后 , 获得 [StateArg1] 点临时力量。"
  },
  State_22325_Name = {
    Text = "巨人血脉"
  },
  State_22326_Desc = {
    Text = "你被锁定了！打出后蹈海者近卫获得 1 层临时疯狂，移除该指令卡的怒涛印记。"
  },
  State_22326_Name = {
    Text = "<CardKeyWord:怒涛印记>"
  },
  State_22328_Desc = {
    Text = "每使用一次带有「怒涛印记」的指令卡，本回合攻击次数+1。"
  },
  State_22328_Name = {
    Text = "怒涛回响"
  },
  State_22334_Desc = {
    Text = "每打出 1 张「打击」卡，将 [StateArg1] 张「伤口」放到抽牌堆顶。"
  },
  State_22334_Name = {Text = "创伤"},
  State_22404_Desc = {
    Text = "本场战斗内产生的护盾提高 [Layer] 点。"
  },
  State_22404_Name = {Text = "戒备"},
  State_22405_Desc = {
    Text = "本场战斗内产生的护盾提高。"
  },
  State_22405_Name = {
    Text = "<PVPAlertKeywords:戒备>"
  },
  State_22702_Desc = {
    Text = "每回合打出的第一张「卡牌」会触发额外效果。"
  },
  State_22702_Name = {
    Text = "<CardKeyWord:突袭>"
  },
  State_22706_Name = {
    Text = "突袭标记__「仅开发用」"
  },
  State_22707_Desc = {
    Text = "每回合打牌以后给玩家上个突袭状态进行标记__「仅开发用」"
  },
  State_22707_Name = {
    Text = "突袭触发器__「仅开发用」"
  },
  State_22721_Name = {
    Text = "时灵摆「迷失」"
  },
  State_23405_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，获得等同于当前反击层数的力量，回复生命并以真正的形态开始战斗。"
  },
  State_23405_Name = {
    Text = "尚未觉醒"
  },
  State_23406_Desc = {
    Text = "「沉渊者」每个回合结束时都会获得 [StateArg1] 层反击。"
  },
  State_23406_Name = {
    Text = "凯刻斯觉醒！"
  },
  State_23512_Name = {
    Text = "给与千面幻象"
  },
  State_23514_Name = {
    Text = "给与千面幻象"
  },
  State_23515_Name = {
    Text = "给与千面幻象"
  },
  State_23516_Name = {
    Text = "给与千面幻象"
  },
  State_23517_Name = {
    Text = "给与玩家BUFF"
  },
  State_23518_Desc = {
    Text = "施加2回合易伤 / 增加1次攻击 / 施加力量降低。"
  },
  State_23518_Name = {
    Text = "<CardKeyWord:意图选择>"
  },
  State_23519_Name = {Text = "意图2b"},
  State_23520_Name = {Text = "意图2c"},
  State_23521_Name = {
    Text = "弃掉时消耗，扣除所有唤醒体[StateArg1]狂气，并将 5 张「症状」洗入玩家抽牌堆"
  },
  State_23522_Name = {
    Text = "弃掉时消耗，扣除所有唤醒体[StateArg1]狂气"
  },
  State_23524_Name = {Text = "意图3a"},
  State_23525_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_23525_Name = {
    Text = "尚未觉醒"
  },
  State_23526_Name = {Text = "意图2a"},
  State_23527_Name = {Text = "意图3c"},
  State_23528_Name = {Text = "意图3b"},
  State_23529_Desc = {
    Text = "提升力量 / 造成额外伤害 / 获得护盾"
  },
  State_23529_Name = {
    Text = "<CardKeyWord:意图选择>"
  },
  State_23530_Desc = {
    Text = "使用「千面幻象」时需要进行两次意图选择。若弃掉，则所有唤醒体失去 20 狂气，并将 5 张「症状」洗入玩家抽牌堆。"
  },
  State_23530_Name = {
    Text = "达芙黛尔觉醒！"
  },
  State_23531_Name = {
    Text = "给与千面幻象"
  },
  State_23532_Name = {
    Text = "给与千面幻象"
  },
  State_23533_Desc = {
    Text = "洗入症状卡 / 施加出血 / 降低狂气"
  },
  State_23533_Name = {
    Text = "<CardKeyWord:意图选择>"
  },
  State_23534_Name = {Text = "意图1a"},
  State_23535_Name = {Text = "意图1c"},
  State_23536_Name = {Text = "意图1b"},
  State_23612_Desc = {
    Text = "每失去 1 点生命降低 1 层。层数降低为 0 时，将意图转换为高额伤害的狂气爆发并会解除石化效果。"
  },
  State_23612_Name = {
    Text = "血之狂暴·终结"
  },
  State_23687_Name = {
    Text = "时灵摆「潮涌」"
  },
  State_23726_Desc = {
    Text = "下回合之前会阻止唤醒体死亡 1 次，最多 1 层。"
  },
  State_23726_Name = {
    Text = "死亡抵抗"
  },
  State_23732_Desc = {
    Text = "直到下个回合开始前，每受到 1 次主动伤害获得 [Layer] 层<PainWord:忍耐>。"
  },
  State_23732_Name = {
    Text = "黑沼禁域"
  },
  State_23736_Name = {
    Text = "本回合抽牌数"
  },
  State_23737_Name = {
    Text = "抽牌数记录"
  },
  State_23741_Name = {
    Text = "施加抽牌记录"
  },
  State_23744_Desc = {
    Text = "如果场上没有「死者」，回合开始时召唤 1 名「死者」，每次召唤生命都会提高。"
  },
  State_23744_Name = {
    Text = "死者召唤"
  },
  State_23747_Name = {
    Text = "强化生命"
  },
  State_23748_Name = {
    Text = "召唤计数"
  },
  State_23769_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_23769_Name = {
    Text = "尚未觉醒"
  },
  State_23771_Desc = {
    Text = "「奇术师」已经觉醒，小心她使用「幻影」制造的分身。觉醒后对方每打出 1 张卡牌，卡茜亚获得 1 层「幻影」。"
  },
  State_23771_Name = {
    Text = "卡茜亚觉醒！"
  },
  State_23771_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_23782_Desc = {
    Text = "获得 10 层幻影后，清空「幻影」层数并在前方召唤 1 个分身，最多存在 2 个分身。分身在被召唤时会携带 3 层<ParcloseIconKeywords:屏障>。"
  },
  State_23782_Name = {Text = "幻影"},
  State_23786_Name = {
    Text = "状态@唤醒体卡茜亚隔空取物"
  },
  State_23787_Name = {
    Text = "状态@唤醒体卡茜亚@隔空取物@抽牌减少"
  },
  State_23788_Desc = {
    Text = "第 3 回合开始时，将 1 张「过往回声—弃掉所有手牌，当前生命和护盾回到上回合结束时的状态。保留，消耗。」加入手中。"
  },
  State_23791_Name = {
    Text = "开场提示"
  },
  State_23823_Name = {Text = "炸弹1"},
  State_23825_Name = {
    Text = "状态@唤醒体卡茜亚@统统消失"
  },
  State_23827_Desc = {
    Text = "打出后，失去 [DescArg1] 点最大生命值，大魔术师在本回合获得 1 层「洋洋得意」。"
  },
  State_23827_Name = {
    Text = "<CardCheerKeywords:喝彩>"
  },
  State_23828_Desc = {
    Text = "大魔术师现在非常享受他的表演，每有 1 层「洋洋得意」，其技能效果将被削弱且力量降低 [DescArg1]，最多可获得 5 层。"
  },
  State_23828_Name = {
    Text = "洋洋得意"
  },
  State_23871_Desc = {
    Text = "增加最大生命时不会同时增加当前生命，减少最大生命时会移除多余的当前生命，最大生命最少为 1 ，死亡后不重置。"
  },
  State_23871_Name = {
    Text = "<MaxHPColour:最大生命>"
  },
  State_23934_Name = {
    Text = "状态@隔空取物手牌监听"
  },
  State_23935_Name = {
    Text = "状态@唤醒体卡茜亚@隔空取物生效"
  },
  State_2393_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_2393_Name = {
    Text = "尚未觉醒"
  },
  State_2394_Name = {
    Text = "猩红力量启灵加成"
  },
  State_2395_Name = {
    Text = "饰品远方的欢宴"
  },
  State_2395_WeaponDesc = {
    Text = "「防御」造成护盾提高 30%。若装备者黑印掉落大于 15%，「防御」造成护盾额外提高 30%。"
  },
  State_2396_Desc = {
    Text = "暴击伤害提高 20%。对有护盾的敌方造成的伤害必然暴击。"
  },
  State_2398_Desc = {
    Text = "受到伤害时，获得 [Layer]护盾，每次受到伤害护盾会不断增加，回合结束时恢复。"
  },
  State_2398_Name = {
    Text = "维度壁垒"
  },
  State_2398_WeaponDesc = {
    Text = "受到的主动伤害提高[Layer]。每次受到伤害融蚀伤口都会扩大，回合开始时恢复。"
  },
  State_2399_Desc = {
    Text = "造成生命回复后，所有唤醒体获得 3 点狂气。每第 5 次造成生命回复后，本场战斗狂气爆发伤害提高 [Arg1]。"
  },
  State_2400_Desc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，触腕伤害提高 [StateArg1]点 。"
  },
  State_2400_Name = {
    Text = "造物过往的贡物"
  },
  State_2400_WeaponDesc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，触腕伤害提高 [StateArg1]点 。"
  },
  State_2401_Desc = {
    Text = "回合开始时，将弃牌堆顶部的卡牌加入手牌。"
  },
  State_2402_Desc = {
    Text = "回合开始时，超维空间每有 1 张卡牌，本回合就获得 [Arg1] 点临时力量。"
  },
  State_2403_Desc = {
    Text = "本场战斗内造成的护盾提高 [Layer] 点。"
  },
  State_2403_Name = {Text = "戒备"},
  State_2403_WeaponDesc = {
    Text = "本场战斗内造成的护盾提高 [Layer] 点。"
  },
  State_2404_Desc = {
    Text = "拾取时删除 1 张症状卡。幸运刻印率提高 50%。"
  },
  State_2405_Desc = {
    Text = "临时改变卡牌算力"
  },
  State_2405_Name = {
    Text = "临时改变卡牌算力"
  },
  State_2405_WeaponDesc = {
    Text = "临时改变卡牌算力"
  },
  State_2406_Desc = {
    Text = "耗尽最后 1 点算力时，获得 2 算力。每回合最多触发 2 次。"
  },
  State_2407_Name = {Text = "观测值"},
  State_2408_Name = {Text = "水手哨"},
  State_2409_Desc = {
    Text = "本回合每打出 1 张【打击】算力消耗 -1 。"
  },
  State_2409_Name = {
    Text = "桀骜之刃"
  },
  State_2409_WeaponDesc = {
    Text = "本回合每打出 1 张【打击】算力消耗 -1 。"
  },
  State_2410_Desc = {
    Text = "无法行动 1 回合。被石化过的敌人无法再次被施加石化效果。"
  },
  State_2410_Name = {
    Text = "<PetrifactionIconKeywords: 石化>"
  },
  State_2410_WeaponDesc = {
    Text = "使怪物眩晕一回合。"
  },
  State_2411_Desc = {
    Text = "回合结束时，对我方队伍施加 [Layer] 层出血。"
  },
  State_2411_Name = {Text = "血之灯"},
  State_2411_WeaponDesc = {
    Text = "回合结束时，对我方队伍施加 [Layer] 层出血。"
  },
  State_2412_Desc = {
    Text = "下一回合造成的伤害翻倍。"
  },
  State_2412_Name = {
    Text = "绝境求生"
  },
  State_2412_WeaponDesc = {
    Text = "下一回合造成的伤害翻倍。"
  },
  State_2413_Desc = {
    Text = "打击和防御获取的狂气减少 [Layer] %。"
  },
  State_2413_Name = {Text = "空虚"},
  State_2413_WeaponDesc = {
    Text = "打击和防御获取的狂气[StateArg1]%。"
  },
  State_2415_Desc = {
    Text = "若上回合受到了伤害，回合开始时获得 1 回合免疫。"
  },
  State_2415_Name = {Text = "适应"},
  State_2415_WeaponDesc = {
    Text = "若上回合受到了伤害，回合开始时获得 1 回合免疫。"
  },
  State_2416_Desc = {
    Text = "其召唤的怪物生命和伤害翻倍。"
  },
  State_2416_Name = {
    Text = "「蜡像世界」"
  },
  State_2416_WeaponDesc = {
    Text = "其召唤的怪物生命和伤害翻倍。"
  },
  State_24174_Desc = {
    Text = "该唤醒体不再会因为伤害导致生命低于1。"
  },
  State_24174_Name = {
    Text = "免疫死亡"
  },
  State_2418_Desc = {
    Text = "[狂气爆发]使自身获得 30 狂气。"
  },
  State_2418_Name = {
    Text = "异化之神的面纱"
  },
  State_2418_WeaponDesc = {
    Text = "[狂气爆发]使自身获得 30 狂气。"
  },
  State_2419_Name = {
    Text = "造物白色镜面"
  },
  State_2420_Desc = {
    Text = "本回合每打出 1 张【防御】算力消耗 -1 。"
  },
  State_2420_Name = {
    Text = "心眼利刃"
  },
  State_2420_WeaponDesc = {
    Text = "本回合每打出 1 张【防御】算力消耗 -1 。"
  },
  State_24210_Desc = {
    Text = "本回合神王的触腕攻击目标变为全体敌人"
  },
  State_24210_Name = {
    Text = "神国腕肢-钥令"
  },
  State_24211_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg4] 次 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg6] 次)。\n·每当唤醒体使用狂气爆发，本回合额外发动 1 次攻击。\n·守密人使用钥令后，使本回合发动的攻击目标变为全体敌人，若在首领战中，「神国腕肢」造成的伤害还会提高 [DescArg5] 点。"
  },
  State_24211_Name = {
    Text = "神国腕肢"
  },
  State_24213_Name = {
    Text = "若此卡在手牌中，回合结束时获得 150 点银钥能量"
  },
  State_24214_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg2] 点伤害。"
  },
  State_24214_Name = {
    Text = "神国腕肢"
  },
  State_24215_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg4] 次)。"
  },
  State_24215_Name = {
    Text = "神国腕肢"
  },
  State_24217_Name = {
    Text = "清除自身<VulnerabilityIconKeywords:易伤>、<WeaknessIconKeywords:虚弱>和<FragileIconKeywords:脆弱>状态"
  },
  State_24220_Name = {
    Text = "获得 [DescArg1] 点护盾"
  },
  State_24222_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg4] 次 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg5] 次)。\n·每当唤醒体使用狂气爆发，本回合额外发动 1 次攻击。\n·每当守密人使用钥令，使本回合发动的攻击目标变为全体敌人。"
  },
  State_24222_Name = {
    Text = "神国腕肢"
  },
  State_24223_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg4] 次)。\n·每当守密人使用钥令，使本回合发动的攻击目标变为全体敌人。"
  },
  State_24223_Name = {
    Text = "神国腕肢"
  },
  State_24224_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg4] 次 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg5] 次)。\n·每当唤醒体使用狂气爆发，本回合额外发动 1 次攻击。"
  },
  State_24224_Name = {
    Text = "神国腕肢"
  },
  State_24226_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg4] 次 [DescArg2] 点伤害，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg6] 次)。\n·每当唤醒体使用狂气爆发，本回合额外发动 1 次攻击。\n·在首领战中，每当守密人使用钥令，「神国腕肢」伤害提高 [DescArg5] 点。"
  },
  State_24226_Name = {
    Text = "神国腕肢"
  },
  State_24227_Desc = {
    Text = "·回合结束后，对前排敌人造成 [DescArg2] 点，若击杀敌人，该伤害提高 [DescArg3] 点，最多提高 5 次(当前 [DescArg5] 次)。\n·守密人使用钥令后，使本回合发动的攻击目标变为全体敌人，若在首领战中，「神国腕肢」造成的伤害还会提高 [DescArg4] 点。"
  },
  State_24227_Name = {
    Text = "神国腕肢"
  },
  State_2422_Desc = {
    Text = "打出后获得 [StateArg1] 点护盾。"
  },
  State_2422_Name = {
    Text = "<Rune_6:铁壁>"
  },
  State_24245_Desc = {
    Text = "回合结束时，复苏所有「海德拉」的眷族。每次有眷族死亡后降低 1 层，若层数为 0，「海德拉」将转换形态进行最终的战斗。"
  },
  State_24245_Name = {
    Text = "万蛇操使"
  },
  State_24247_Desc = {
    Text = "受到的伤害降低 90%。若回合开始时没有「万蛇操使」层数，移除此状态。"
  },
  State_24247_Name = {
    Text = "蛇形壁障"
  },
  State_2425_Desc = {
    Text = "打出后被消耗。若为指令卡，其伤害和防护会被提高 2 倍。"
  },
  State_2425_Name = {
    Text = "<CardKeyWord:溶解>"
  },
  State_2426_Desc = {
    Text = "你每回合打出的第一张卡牌额外生效 1 次，但每回合最多打出 4 张卡牌。"
  },
  State_2427_Name = {
    Text = "状态@幻梦银钥：血渊之心计数"
  },
  State_2428_Desc = {
    Text = "恶之华的<ParcloseIconKeywords:屏障>数量增加 [Layer] 层。"
  },
  State_2428_Name = {
    Text = "怨念屏障"
  },
  State_2428_WeaponDesc = {
    Text = "恶之华的屏障数量增加 [Layer] 层"
  },
  State_24292_Name = {
    Text = "后排前移"
  },
  State_24293_Name = {
    Text = "前排后移"
  },
  State_2429_Desc = {
    Text = "造成的所有伤害降低 [Layer] %。"
  },
  State_2429_Name = {
    Text = "临时伤害降低"
  },
  State_2429_WeaponDesc = {
    Text = "造成的所有伤害降低 [Layer] %。"
  },
  State_2430_Desc = {
    Text = "战斗开始时，全体友方获得 3 层【蜡质铠甲】。回合结束时，对我方队伍造成[Arg1]层出血。"
  },
  State_2430_Name = {
    Text = "「蜡之绅士」"
  },
  State_2430_WeaponDesc = {
    Text = "战斗开始时，全体友方获得 3 层【蜡质铠甲】。回合结束时，对我方队伍造成[Arg1]层出血。"
  },
  State_2431_Desc = {
    Text = "队伍唯一：装备者造成的护盾和生命回复提高，提高量为 <WeaponEffect_Num:[StateArg1]%> 装备者的体质，装备者造成的反击提高 <WeaponEffect_Num:[StateArg3]%>，打出「防御」时还会获得装备者防御力 <WeaponEffect_Num:[StateArg4]%> 的<RetaliateIconKeywords:反击>。战斗开始后，获得等同于装备者体质 <WeaponEffect_Num:[StateArg2]%> 的<PowerIconKeywords:力量> 。若当前界域为「深海」，额外获得等量的触腕伤害。"
  },
  State_2431_WeaponDesc = {
    Text = "装备者造成的护盾和生命回复提高 <WeaponEffect_Num:[DescArg1]> 点，装备者造成的反击提高 <WeaponEffect_Num:[StateArg3]%>，打出「防御」时，还会获得 <WeaponEffect_Num:[Counterattack:DescArg3]> 层<RetaliateIconKeywords:反击>。战斗开始后，获得 <WeaponEffect_Num:[Power:DescArg2]> 点<PowerIconKeywords:力量>。若当前界域为「深海」，额外获得等量的触腕伤害。"
  },
  State_2432_Desc = {
    Text = "承受的主动和触腕伤害提高 50 %，回合结束时移除 1 层。"
  },
  State_2432_Name = {
    Text = "<VulnerabilityIconKeywords: 易伤>"
  },
  State_2432_WeaponDesc = {
    Text = "承受的所有伤害提高 50 %。"
  },
  State_2433_Desc = {
    Text = "每个回合结束时获得[Layer]点力量。"
  },
  State_2433_Name = {Text = "愤怒"},
  State_2434_Name = {
    Text = "饰品36室之环"
  },
  State_2434_WeaponDesc = {
    Text = "抽到装备者的卡牌时，其算力会在 0-3 间随机变化。"
  },
  State_2435_Desc = {Text = "事件19_2"},
  State_2435_Name = {Text = "事件19_2"},
  State_2435_WeaponDesc = {Text = "事件19_2"},
  State_2436_Desc = {
    Text = "获得的力量和护盾降低 50%，持续 [Layer] 回合。"
  },
  State_2436_Name = {
    Text = "临时诅咒"
  },
  State_2436_WeaponDesc = {
    Text = "回合结束前，免疫对自身施加正面状态。"
  },
  State_2437_Desc = {Text = "——"},
  State_2437_WeaponDesc = {Text = "——"},
  State_2438_Desc = {
    Text = "状态@造物银白差分机计数"
  },
  State_2438_Name = {
    Text = "状态@造物银白差分机计数"
  },
  State_2438_WeaponDesc = {
    Text = "状态@造物银白差分机计数"
  },
  State_2440_Name = {
    Text = "抽 1 张牌"
  },
  State_2441_Name = {
    Text = "获得 1 点算力"
  },
  State_2442_Name = {
    Text = "对所有敌人施加 1 层<VulnerabilityIconKeywords:易伤>"
  },
  State_2443_Name = {
    Text = "对所有敌人施加 1 层<WeaknessIconKeywords:虚弱>"
  },
  State_2444_Name = {
    Text = "获得 <Energy:[DescArg1]> 点狂气"
  },
  State_2445_Name = {
    Text = "其他唤醒体获得 <Energy:[DescArg1]> 点狂气"
  },
  State_2446_Name = {
    Text = "将 1 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆"
  },
  State_2447_Desc = {
    Text = "队伍唯一：装备者指令卡暴击率和暴击伤害、指令卡造成的护盾、生命回复、狂气和力量提高 <WeaponEffect_Num:[StateArg1]%>。若当前界域为「超维」，释放「湮灭」后获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。进入超维回合后，本回合下一个钥令释放 2 次。"
  },
  State_2447_WeaponDesc = {
    Text = "装备者指令卡暴击率和暴击伤害、指令卡造成的护盾、生命回复、狂气和力量提高 <WeaponEffect_Num:[StateArg1]%>。若当前界域为「超维」，释放「湮灭」后获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。进入超维回合后，本回合下一个钥令释放 2 次。"
  },
  State_2448_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_2448_Name = {
    Text = "<CardKeyWord:保留>"
  },
  State_2449_Desc = {
    Text = "受到实际伤害后，获得[Layer]护盾。"
  },
  State_2449_Name = {Text = "缓冲"},
  State_2449_WeaponDesc = {
    Text = "受到实际伤害后，获得[Layer]护盾。"
  },
  State_2450_Desc = {
    Text = "「打击」必定暴击。暴击伤害提高 50%。"
  },
  State_2451_Desc = {
    Text = "回合结束时，其他友方获得 [Layer] 力量。"
  },
  State_2451_Name = {
    Text = "「启明之火」"
  },
  State_2452_Desc = {
    Text = "打出后获得 [StateArg1] 点力量。"
  },
  State_2452_Name = {
    Text = "<Rune_14_High:高级蛮力>"
  },
  State_2453_Name = {
    Text = "饰品光合祭礼"
  },
  State_2453_WeaponDesc = {
    Text = "战斗开始后，装备者所有的卡牌获得保留。"
  },
  State_2454_Desc = {
    Text = "打出后不会进入弃牌堆，而是从牌库中移除。"
  },
  State_2454_Name = {
    Text = "<DepleteIconKeywords:消耗>"
  },
  State_2454_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_24556_Name = {
    Text = "状态@大魔术师胡迪尼@幸运观众添加喝彩"
  },
  State_2455_Name = {
    Text = "状态@青炎舞者启灵7"
  },
  State_24560_Desc = {
    Text = "每当使用钥令后，环行·拉蒙娜临时暴击率和临时暴击伤害 +25%。"
  },
  State_24560_Name = {
    Text = "克莱因旅人"
  },
  State_24562_Desc = {
    Text = "回合结束后，获得 1 层负熵。"
  },
  State_24562_Name = {
    Text = "彭罗斯行者"
  },
  State_24564_Desc = {
    Text = "每当拥有 3 层负熵时，打出环行·拉蒙娜的指令卡将消耗所有负熵并触发回环额外效果，负熵最多堆叠 3 层。"
  },
  State_24564_Name = {Text = "负熵"},
  State_2456_Name = {
    Text = "状态@青炎舞者启灵15"
  },
  State_2457_Name = {
    Text = "抽 1 张牌"
  },
  State_24584_Name = {
    Text = "状态@N的分身@呢喃1状态切换"
  },
  State_2458_Name = {
    Text = "状态@饰品猩红之拥效果计数"
  },
  State_24593_Desc = {
    Text = "层数为 0 时，将意图变更为「黑色召唤」，回合结束时会减少 1 层，至多拥有4层。"
  },
  State_24593_Name = {Text = "混沌"},
  State_24595_Desc = {
    Text = "死亡后立即减少「N」的 1 层 「混沌」。"
  },
  State_24595_Name = {Text = "弥散"},
  State_24596_Desc = {
    Text = "召唤「N」的分身时，每有 1 层「黑暗」召唤 1 个分身。"
  },
  State_24596_Name = {Text = "黑暗"},
  State_2460_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害、<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg1]%>，暴击率和暴击伤害提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_2460_WeaponDesc = {
    Text = "装备者造成的基础伤害、<IntoxicationIconKeywords:中毒>和<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg1]%>，暴击率和暴击伤害提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_2461_Desc = {
    Text = "本场战斗受到致死伤害时，复活，回复 [Layer] 点生命并使所有唤醒体获得 [StateArg1] 点狂气，无法驱散。"
  },
  State_2461_Name = {
    Text = "不死的极乐鸟"
  },
  State_2463_Desc = {
    Text = "战斗开始时胚胎融合+20%。每有一名唤醒体狂气已满，胚胎融合额外+20%。"
  },
  State_24640_Desc = {
    Text = "战斗开始后，胚胎融合 +[Blood:DescArg1]，每次触发死亡抵抗，胚胎融合 +[Blood:DescArg1]。索蕾尔每次造成伤害，使本回合内自身造成伤害提高等同于攻击力 4% 点。"
  },
  State_24640_Name = {Text = "明珠"},
  State_2464_Desc = {
    Text = "卡牌算力增加"
  },
  State_2464_Name = {
    Text = "永久卡牌算力增加"
  },
  State_2464_WeaponDesc = {
    Text = "卡牌算力增加"
  },
  State_24654_Desc = {
    Text = "达芙黛尔以任何方式击杀敌人后使队伍在本次关卡中暴击率永久提高 5%，最多堆叠 5 次。（当前堆叠 [DescArg1] 次）"
  },
  State_24654_Name = {
    Text = "贪婪灰雾"
  },
  State_2466_Desc = {
    Text = "直到下个回合开始，每承受 1 次攻击伤害，使触腕反击攻击者 1 次，临时触腕伤害 +[Layer]。"
  },
  State_2466_Name = {
    Text = "〔已废弃〕承自异端之血"
  },
  State_24678_Name = {
    Text = "状态@N的分身@呢喃2状态切换"
  },
  State_24679_Name = {
    Text = "状态@N的分身3@呢喃6状态切换"
  },
  State_2467_Desc = {
    Text = "状态@序章攻势推演"
  },
  State_2467_Name = {
    Text = "状态@序章攻势推演"
  },
  State_2467_WeaponDesc = {
    Text = "状态@序章攻势推演"
  },
  State_24680_Name = {
    Text = "状态@N的分身2@呢喃1状态切换"
  },
  State_24681_Name = {
    Text = "状态@N的分身@呢喃6状态切换"
  },
  State_24682_Name = {
    Text = "状态@N的分身3@呢喃3状态切换"
  },
  State_24683_Name = {
    Text = "状态@N的分身2@呢喃2状态切换"
  },
  State_24684_Name = {
    Text = "状态@N的分身@呢喃4状态切换"
  },
  State_24685_Name = {
    Text = "状态@N的分身@呢喃5状态切换"
  },
  State_24686_Name = {
    Text = "状态@N的分身3@呢喃5状态切换"
  },
  State_24687_Name = {
    Text = "状态@N的分身3@呢喃2状态切换"
  },
  State_24688_Name = {
    Text = "状态@N的分身2@呢喃6状态切换"
  },
  State_24689_Name = {
    Text = "状态@N的分身3@呢喃4状态切换"
  },
  State_24690_Name = {
    Text = "状态@N的分身3@呢喃1状态切换"
  },
  State_24691_Name = {
    Text = "状态@N的分身2@呢喃4状态切换"
  },
  State_24692_Name = {
    Text = "状态@N的分身2@呢喃3状态切换"
  },
  State_24693_Name = {
    Text = "状态@N的分身@呢喃3状态切换"
  },
  State_24694_Name = {
    Text = "状态@N的分身2@呢喃5状态切换"
  },
  State_2470_Desc = {
    Text = "拾取时永久失去 [Arg1] 点戒备，造成的主动伤害额外享受 1 倍力量加成。"
  },
  State_24719_Desc = {
    Text = "「@2」已以解放之姿现世，生命变为原来的 3 倍。"
  },
  State_24719_Name = {
    Text = "命运复苏"
  },
  State_24719_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_2471_Desc = {
    Text = "回合开始时，我方队伍降低 1 戒备。"
  },
  State_2471_Name = {Text = "腐蚀"},
  State_2471_WeaponDesc = {
    Text = "回合开始时，我方队伍降低 1 戒备。"
  },
  State_24720_Desc = {
    Text = "未知存在的力量仍蛰伏黑池之下，即将被击败前将彻底复苏，回复生命并以解放之姿开始战斗。"
  },
  State_24720_Name = {Text = "蛰伏"},
  State_2472_Desc = {
    Text = "同时对护盾和生命造成伤害，且无法被免疫。"
  },
  State_2472_Name = {
    Text = "<PunctureDamagewords:穿刺伤害>"
  },
  State_2472_WeaponDesc = {
    Text = "穿刺伤害无视目标护盾、减伤阻挡，直接造成伤害。"
  },
  State_24730_Desc = {
    Text = "临时增加超维空间，上限为 10。下次进入超维回合后，临时超维空间中的卡牌将会置入手中，移除临时超维空间。"
  },
  State_24730_Name = {
    Text = "<CardKeyWord:临时超维空间>"
  },
  State_24737_Desc = {
    Text = "回合开始时，对对方造成出血，每 1 层命运会造成 [StateArg1] 点出血"
  },
  State_24737_Name = {Text = "命运"},
  State_24738_Desc = {
    Text = "每 1 层命运在生效时会造成 [StateArg1] 点出血，每打出 1 张卡牌会减少 1 层命运"
  },
  State_24738_Name = {Text = "命运"},
  State_24739_Name = {Text = "命运"},
  State_2473_Desc = {
    Text = "[防御]失去 1 条触腕，回复 [StateArg1] 生命。[打击]失去 [StateArg2] 生命，生成 1 条触腕。"
  },
  State_2473_Name = {
    Text = "造物长生者血肉"
  },
  State_2473_WeaponDesc = {
    Text = "[防御]失去 1 条触腕，回复 [StateArg1] 生命。[打击]失去 [StateArg2] 生命，生成 1 条触腕。"
  },
  State_2474_Desc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_2474_Name = {
    Text = "通用攻击力百分比提高"
  },
  State_2474_WeaponDesc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_2475_Desc = {
    Text = "队伍唯一：装备者造成的主动伤害提高等同于装备者攻击力 <WeaponEffect_Num:[StateArg3]%> 。每打出或弃掉装备者的 1 张指令卡后，对随机敌人造成等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的<IntoxicationIconKeywords:中毒>。超维回合结束后，有 <WeaponEffect_Num:[StateArg2]%> 概率触发所有敌人 100％ 中毒。"
  },
  State_2475_WeaponDesc = {
    Text = "装备者造成的主动伤害提高 <WeaponEffect_Num:[DescArg2]> 点。每打出或弃掉装备者的 1 张指令卡后，对随机敌人造成 <WeaponEffect_Num:[DescArg1]> 层<IntoxicationIconKeywords:中毒>。超维回合结束后，有 <WeaponEffect_Num:[StateArg2]%> 概率触发所有敌人 [DescArg3]％ 中毒。"
  },
  State_2476_Name = {
    Text = "状态@本源知者启灵1"
  },
  State_2478_Desc = {
    Text = "鹦鹉螺施加的护盾翻倍。"
  },
  State_2478_Name = {
    Text = "维修大师"
  },
  State_2478_WeaponDesc = {
    Text = "鹦鹉螺施加的护盾翻倍。"
  },
  State_2479_Desc = {
    Text = "翠火每次造成伤害，层数+1"
  },
  State_2479_Name = {
    Text = "翡翠映像计数"
  },
  State_2479_WeaponDesc = {
    Text = "翠火每次造成伤害，层数+1"
  },
  State_2480_Desc = {
    Text = "回复生命时获得 [StateArg1] 反击。沉渊者每出 1 张牌，回复 1 点生命。"
  },
  State_2480_Name = {
    Text = "蜕变之躯"
  },
  State_2481_Desc = {
    Text = "状态@序章重置牌库0_2_3_1"
  },
  State_2481_Name = {
    Text = "状态@序章重置牌库0_2_3_1"
  },
  State_2481_WeaponDesc = {
    Text = "状态@序章重置牌库0_2_3_1"
  },
  State_2482_Desc = {
    Text = "生命低于50%召唤1个等量生命的融蚀三角中"
  },
  State_2482_Name = {Text = "召唤"},
  State_2482_WeaponDesc = {
    Text = "生命低于50%召唤1个等量生命的融蚀三角中"
  },
  State_2486_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 1 算力。主动伤害击杀敌人时，对其他敌人造成等同于过量伤害的出血。"
  },
  State_24879_Desc = {
    Text = "一千年过去，一万年过去，它们在永暗的废墟中静待蒙宠。死亡后立即减少「N」的 1 层 「混沌」，并使「N」获得 [DescArg1] 点护盾和 [DescArg2] 点力量。"
  },
  State_24879_Name = {
    Text = "虚妄分身"
  },
  State_2488_Desc = {
    Text = "每使用一张「增益卡」/ 「症状卡」/「状态卡」，狂气最低的唤醒体获得 10 狂气。"
  },
  State_2489_Desc = {
    Text = "暴击率提高 10%。每回合首次暴击后使暴击率额外提高 20%，每回合造成第 3 次暴击后使暴击伤害额外提高 50%。"
  },
  State_2490_Desc = {
    Text = "每层使攻击次数加1，受到伤害失去一层，回合结束时失去全部。"
  },
  State_2490_Name = {Text = "祈祷"},
  State_2491_Desc = {
    Text = "回复生命时获得等量护盾。"
  },
  State_2491_Name = {
    Text = "临时硬化"
  },
  State_2492_Desc = {
    Text = "每回合免疫首次主动伤害。"
  },
  State_2492_Name = {Text = "坚定"},
  State_2492_WeaponDesc = {
    Text = "每回合免疫首次主动伤害。"
  },
  State_2493_Desc = {
    Text = "造成的主动伤害降低 [Layer] 点。"
  },
  State_2493_Name = {
    Text = "力量降低"
  },
  State_2494_Desc = {
    Text = "状态@序章狂气0_1_4_1"
  },
  State_2494_Name = {
    Text = "状态@序章狂气0_1_4_1"
  },
  State_2494_WeaponDesc = {
    Text = "状态@序章狂气0_1_4_1"
  },
  State_2495_Desc = {
    Text = "状态@序章狂气0_1_4_2"
  },
  State_2495_Name = {
    Text = "状态@序章狂气0_1_4_2"
  },
  State_2495_WeaponDesc = {
    Text = "状态@序章狂气0_1_4_2"
  },
  State_24968_Desc = {
    Text = "战斗开始后，胚胎融合 +[Blood:DescArg2]，每次触发死亡抵抗，胚胎融合 +[Blood:DescArg2]。索蕾尔每次造成伤害，使本回合内自身造成伤害提高 [DescArg1] 点。"
  },
  State_24968_Name = {Text = "明珠"},
  State_2496_Desc = {
    Text = "回合开始时回复 [Arg1] 生命。如果生命低于 50% ，回复生命变为 [Arg2]。"
  },
  State_2496_Name = {
    Text = "恩赐之血"
  },
  State_24976_Desc = {
    Text = "「凸月侍女」已经觉醒，小心特制料理带来的危害！"
  },
  State_24976_Name = {
    Text = "珈伦觉醒！"
  },
  State_24976_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_24977_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_24977_Name = {
    Text = "尚未觉醒"
  },
  State_2497_Desc = {
    Text = "莉莉会模仿玩家每回合打出的第一张指令卡。若是打击卡莉莉攻击次数+1，若是防御卡莉莉获得10%生命的护盾，若是其他指令卡，莉莉也不知道发生了什么会先放一只脓疱在这里。"
  },
  State_2497_Name = {
    Text = "莉莉觉醒！"
  },
  State_2497_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_2498_Name = {
    Text = "饰品诅咒兔"
  },
  State_2498_WeaponDesc = {
    Text = "装备者造成的护盾与生命回复提高 6%。若装备者界域精通大于 50，护盾与生命回复额外提高 6%。"
  },
  State_2499_Name = {
    Text = "凝滞诅咒"
  },
  State_2500_Desc = {
    Text = "每次造成实际伤害时，附加中毒。"
  },
  State_2500_Name = {Text = "毒素"},
  State_2501_Desc = {
    Text = "队伍唯一：队伍生命上限提高 10%。装备者造成的治疗和护盾提高 <WeaponEffect_Num:[StateArg3]%>。打出装备者的「打击」后，回复 <WeaponEffect_Num:[StateArg1]%> 已损失生命。打出装备者的「防御」后，获得 <WeaponEffect_Num:[StateArg2]%> 当前生命的护盾。该效果每回合最多各触发 1 次。"
  },
  State_2501_Name = {
    Text = "灵魂诞生"
  },
  State_2501_WeaponDesc = {
    Text = "队伍生命上限提高 10%。装备者造成的治疗和护盾提高 <WeaponEffect_Num:[StateArg3]%>。打出装备者的「打击」后，回复 [StateArg1]%(<WeaponEffect_Num:[Heal:DescArg1]>) 已损失生命。打出装备者的「防御」后，获得[StateArg1]%(<WeaponEffect_Num:[Block:DescArg2]>) 当前生命的护盾。该效果每回合最多各触发 1 次。"
  },
  State_2502_Desc = {
    Text = "造成的主动和触腕伤害降低 50 %。"
  },
  State_2502_Name = {
    Text = "寂灭虚弱"
  },
  State_2502_WeaponDesc = {
    Text = "造成的所有伤害降低 50 %。"
  },
  State_2503_Desc = {
    Text = "队伍唯一：装备者卡牌造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时，有 <WeaponEffect_Num:[StateArg2]%> 的几率生成一张装备者的随机卡牌到手牌中，附加消耗。若当前界域为「血肉」，对装备者使用「胚胎」时，使装备者本回合下次打击卡造成伤害的暴击率 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_2503_WeaponDesc = {
    Text = "装备者卡牌造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时，有 <WeaponEffect_Num:[StateArg2]%> 的几率生成一张装备者的随机卡牌到手牌中，附加消耗。若当前界域为「血肉」，对装备者使用「胚胎」时，使装备者本回合下次打击卡造成伤害的暴击率 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_2504_Desc = {
    Text = "「打击」获得 2 点算力，随机弃 1 张牌；「防御」抽 2 张牌，失去 1 点算力。"
  },
  State_25056_Desc = {
    Text = "每次消耗算力，就使珈伦获得 [Layer] 点临时力量"
  },
  State_25056_Name = {
    Text = "吃饱喝足"
  },
  State_25057_Desc = {
    Text = "每次消耗算力，就使珈伦获得 [StateArg1] 点临时力量，回合结束时移除 1 层。"
  },
  State_25057_Name = {
    Text = "吃饱喝足"
  },
  State_2505_Name = {
    Text = "饰品四月礼赞"
  },
  State_2505_WeaponDesc = {
    Text = "战斗开始后，若装备者职业为超维，攻击力提高 25%。"
  },
  State_2507_Desc = {
    Text = "拾取时最大生命提高 100%，回合开始时，失去 [Arg1] 点生命。"
  },
  State_2509_Name = {
    Text = "状态@通用界域精通"
  },
  State_2511_Desc = {
    Text = "状态@序章钥能教学"
  },
  State_2511_Name = {
    Text = "状态@序章钥能教学"
  },
  State_2511_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_2"
  },
  State_2512_Desc = {
    Text = "打出 1 张算力消耗为 3 或以上的卡牌时，抽 1 张牌并获得 1 点算力。"
  },
  State_2514_Desc = {
    Text = "本场战斗内造成的护盾降低 [Layer] 点。"
  },
  State_2514_Name = {
    Text = "戒备降低"
  },
  State_2514_WeaponDesc = {
    Text = "本场战斗内造成的护盾降低 [Layer] 点。"
  },
  State_2515_Desc = {
    Text = "[打击]对所有敌人施加 [StateArg1] 层中毒。"
  },
  State_2515_Name = {
    Text = "造物神经毒素"
  },
  State_25163_Desc = {
    Text = "祂像雾一般令人难以捉摸。"
  },
  State_25163_Name = {
    Text = "往日之影"
  },
  State_25165_Desc = {
    Text = "环行·拉蒙娜指令卡独有的额外效果，拥有 3 层负熵时触发。回环会继承至下场战斗。"
  },
  State_25165_Name = {
    Text = "<TimeBeacon:回环>"
  },
  State_25166_Desc = {
    Text = "每当拥有 3 层负熵时，打出环行·拉蒙娜的指令卡将消耗所有负熵并触发回环额外效果，负熵最多堆叠 3 层。"
  },
  State_25166_Name = {
    Text = "<TimeBeacon2:负熵>"
  },
  State_2516_Desc = {
    Text = "无法被打出。"
  },
  State_2516_Name = {
    Text = "无法打出"
  },
  State_2516_WeaponDesc = {
    Text = "卡牌无法打出。"
  },
  State_25179_Name = {
    Text = "狂气判断"
  },
  State_2517_Desc = {
    Text = "我方队伍释放狂气爆发后，自身当回合失去力量。一回合一次。"
  },
  State_2517_Name = {
    Text = "畏惧狂气"
  },
  State_25181_Name = {
    Text = "轮回保留效果"
  },
  State_2518_Desc = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_2518_Name = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_2518_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_25194_Desc = {
    Text = "死亡后为「N」增加 [DescArg1] 点护盾和 [DescArg2] 点永久力量"
  },
  State_2519_Desc = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_2519_Name = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_2519_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_1_3"
  },
  State_25204_Name = {
    Text = "状态@N的分身2@意图判定"
  },
  State_25205_Name = {
    Text = "状态@N的分身3@意图判定"
  },
  State_25206_Name = {
    Text = "状态@N@添加N的分身判定"
  },
  State_25207_Name = {
    Text = "状态@N的分身@意图判定"
  },
  State_2520_Desc = {
    Text = "状态@序章重置牌库0_1_1_2"
  },
  State_2520_Name = {
    Text = "状态@序章重置牌库0_1_1_2"
  },
  State_2520_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_1_2"
  },
  State_2522_Desc = {
    Text = "希洛已经觉醒，攻击强度和欲望都会得到提升。"
  },
  State_2522_Name = {
    Text = "希洛觉醒"
  },
  State_2523_Desc = {
    Text = "奇数回合开始时，本回合内获得 [Arg1] 力量。偶数回合开始时，本回合内获得 [Arg2] 点戒备。"
  },
  State_2524_Desc = {
    Text = "战斗开始时，获得 1 力量"
  },
  State_2524_Name = {
    Text = "威名远扬"
  },
  State_2525_Desc = {
    Text = "攻击次数-1，获得[Layer]点力量"
  },
  State_2525_Name = {Text = "纵欲"},
  State_2527_Name = {
    Text = "猩红力量加成"
  },
  State_2528_Desc = {
    Text = "打出 1 张实际算力消耗为 3 的卡牌时，抽 1 张牌并获得 2 算力"
  },
  State_2529_Desc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_2529_Name = {
    Text = "临时暴击伤害"
  },
  State_2529_WeaponDesc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_2531_Desc = {
    Text = "翠火每造成 [Damage:StateArg2] 次伤害，就获得一张消耗【绿炎】。"
  },
  State_2531_Name = {
    Text = "翡翠映像"
  },
  State_2531_WeaponDesc = {
    Text = "翠火每造成 [Damage:StateArg2] 次伤害，就获得一张消耗【绿炎】。"
  },
  State_2532_Name = {
    Text = "饰品猩红之悸"
  },
  State_2534_Desc = {
    Text = "状态@序章重置牌库0_1_3_3"
  },
  State_2534_Name = {
    Text = "状态@序章重置牌库0_1_3_3"
  },
  State_2534_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_3_3"
  },
  State_2535_Desc = {
    Text = "状态@序章重置牌库0_1_3_2"
  },
  State_2535_Name = {
    Text = "状态@序章重置牌库0_1_3_2"
  },
  State_2535_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_3_2"
  },
  State_2536_Name = {
    Text = "状态@临时打击卡暴击伤害提高"
  },
  State_2537_Desc = {
    Text = "空想利刃施加护盾时，获得 [StateArg2] 点临时戒备。"
  },
  State_2537_Name = {
    Text = "战场的卓识"
  },
  State_2537_WeaponDesc = {
    Text = "空想利刃施加护盾时，获得 [StateArg2] 点临时戒备。"
  },
  State_2538_Desc = {
    Text = "打出后获得 [StateArg1] 层反击，对所有敌人造成 [StateArg2]% 反击的<FixedDamage:纯粹伤害>。"
  },
  State_2538_Name = {
    Text = "<Rune_9_High:高级尖刺>"
  },
  State_25391_Desc = {
    Text = "队伍中已有一名唤醒体被选为了「幸运观众」，该唤醒体的所有卡牌具有「喝彩」效果。"
  },
  State_25391_Name = {
    Text = "幸运观众"
  },
  State_25392_Desc = {
    Text = "打出后，失去 2% 最大生命值，大魔术师在本回合获得 1 层「洋洋得意」。"
  },
  State_25392_Name = {
    Text = "<CardCheerKeywords:喝彩>"
  },
  State_25401_Desc = {
    Text = "此卡牌在手牌中时会使手牌上限 +1。"
  },
  State_25401_Name = {
    Text = "无视手牌上限"
  },
  State_25403_Desc = {
    Text = "触腕伤害降低 50%，每造成 1 次触腕伤害获得 [Layer] 点护盾。"
  },
  State_25403_Name = {Text = "静海"},
  State_25405_Desc = {
    Text = "此卡牌任何情况下都会在手牌中。"
  },
  State_25405_Name = {
    Text = "永久保留"
  },
  State_25406_Desc = {
    Text = "本回合内无法再切换触腕形态"
  },
  State_25406_Name = {
    Text = "深海疯狂·限制"
  },
  State_25407_Desc = {
    Text = "触腕伤害提高 25%，回合结束时触腕数量 -1。"
  },
  State_25407_Name = {
    Text = "深海疯狂"
  },
  State_25415_Desc = {
    Text = "释放钥令后，获得 [Layer] 点钥能。"
  },
  State_25415_Name = {
    Text = "混沌临时钥能满溢"
  },
  State_25417_Name = {Text = "炸弹3"},
  State_25418_Name = {Text = "炸弹2"},
  State_2542_Name = {
    Text = "造物无名附肢计数"
  },
  State_2543_Name = {
    Text = "状态@关卡2_14战斗8气泡1"
  },
  State_2544_Desc = {
    Text = "状态@序章怪物被动"
  },
  State_2544_Name = {
    Text = "状态@序章怪物被动"
  },
  State_2544_WeaponDesc = {
    Text = "状态@序章怪物被动"
  },
  State_2545_Desc = {
    Text = "战斗开始时胚胎融合+20%。每有一名唤醒体狂气已满，胚胎融合额外+20%。"
  },
  State_2547_Desc = {
    Text = "回合开始时，将一张本回合内获得 [Arg1] 力量「渔叉」加入手中。释放狂气爆发后，使手牌中所有的「渔叉」力量提高 [Arg2]。"
  },
  State_2548_Desc = {
    Text = "免疫一次死亡，触发后回复 50 生命并使该造物永久失效。"
  },
  State_2548_Name = {
    Text = "造物替身玩偶"
  },
  State_2548_WeaponDesc = {
    Text = "免疫一次死亡，触发后回复 50 生命并使该造物永久失效。"
  },
  State_2549_Desc = {
    Text = "降低造成的主动和触腕伤害。"
  },
  State_2549_Name = {
    Text = "<ExhaustionIconKeywords: 力量降低>"
  },
  State_2549_WeaponDesc = {
    Text = "每层衰竭使造成的伤害和触腕伤害降低 1 点。"
  },
  State_2550_Desc = {
    Text = "抽到时使自身脆弱 1 回合。使用后易伤所有敌人 1 回合。无法出售。"
  },
  State_2550_Name = {
    Text = "状态诅咒崩溃"
  },
  State_2550_WeaponDesc = {
    Text = "抽到时使自身脆弱 1 回合。使用后易伤所有敌人 1 回合。无法出售。"
  },
  State_2552_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_2552_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_2552_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_2553_Desc = {
    Text = "回合开始时，获得一点算力"
  },
  State_2553_Name = {
    Text = "造物阿尔卡纳算力"
  },
  State_2553_WeaponDesc = {
    Text = "回合开始时，获得一点算力"
  },
  State_2554_Name = {
    Text = "普特尼晨报"
  },
  State_2556_Desc = {
    Text = "血量降低后，获得护盾，等同于降低值的 [Layer] %。"
  },
  State_2556_Name = {
    Text = "鲜血护盾"
  },
  State_2556_WeaponDesc = {
    Text = "血量降低后，获得护盾，等同于降低值的 [Layer] %"
  },
  State_2557_Desc = {
    Text = "下个回合开始时，获得 [Layer] 点护盾。"
  },
  State_2557_Name = {
    Text = "苦痛与欢愉护盾"
  },
  State_2558_Desc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为 2 只等量生命的「干涉型融蚀体」。"
  },
  State_2558_Name = {Text = "分裂"},
  State_2558_WeaponDesc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为2只等量生命的「II型融蚀体」。"
  },
  State_2559_Desc = {
    Text = "每次受到攻击后，失去 [Layer] 点临时力量。"
  },
  State_2559_Name = {
    Text = "冲动的代价"
  },
  State_2560_Desc = {
    Text = "下回合开始后获得 [Layer] 护盾。"
  },
  State_2560_Name = {
    Text = "封闭创作"
  },
  State_2560_WeaponDesc = {
    Text = "下回合开始后获得 [Layer] 护盾。"
  },
  State_2561_Desc = {
    Text = "忧郁才华"
  },
  State_2561_Name = {
    Text = "忧郁才华"
  },
  State_2561_WeaponDesc = {
    Text = "忧郁才华"
  },
  State_2562_Name = {
    Text = "状态@章三_共鸣1_标志"
  },
  State_2563_Desc = {
    Text = "每打出第 10 张牌时，提高 2 触腕伤害，使所有触腕攻击 1 次。"
  },
  State_2563_Name = {
    Text = "造物渔叉"
  },
  State_2563_WeaponDesc = {
    Text = "每打出第 10 张牌时，提高 2 触腕伤害，使所有触腕攻击 1 次。"
  },
  State_2564_Desc = {
    Text = "获得的所有护盾降低 [DescArg1] %。"
  },
  State_2564_Name = {
    Text = "<FragileColour:脆弱>"
  },
  State_2564_WeaponDesc = {
    Text = "获得的所有护盾降低 33 %。"
  },
  State_2565_Name = {
    Text = "饰品猩红之拥"
  },
  State_2565_WeaponDesc = {
    Text = "装备者造成伤害时获得 20 点银钥能量，若造成暴击伤害，改为获得 50 点银钥能量，每回合最多触发 3 次。"
  },
  State_2566_Desc = {
    Text = "一回合内受到 3 次攻击后，获得 1 层临时<MadnessColour:疯狂>。"
  },
  State_2566_Name = {
    Text = "「甜蜜痛楚」"
  },
  State_2567_Desc = {
    Text = "已受到 [Layer] 次伤害，达到 3 次后 「甜蜜恶鬼」本回合内获得 1 层<MadnessColour:疯狂>。"
  },
  State_2567_Name = {
    Text = "「甜蜜痛楚」次数"
  },
  State_2567_WeaponDesc = {
    Text = "已受到 [Layer] 次伤害，达到 3 次后 「甜蜜恶鬼」本回合内获得 1 层疯狂。"
  },
  State_2569_Desc = {
    Text = "界域推荐加成效果提升为 50%，关卡开始时你的界域精通提高 100。"
  },
  State_2569_Name = {
    Text = "状态@幻梦银钥：适性分离"
  },
  State_2570_Desc = {
    Text = "打出后抽 [StateArg1] 张牌。"
  },
  State_2570_Name = {
    Text = "<Rune_3:妙手>"
  },
  State_2571_Desc = {
    Text = "队伍中每有一名【混沌】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_2571_Name = {
    Text = "混沌加成"
  },
  State_2571_WeaponDesc = {
    Text = "队伍中每有一名【混沌】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_2572_Desc = {
    Text = "打出后胚胎融合 +[StateArg1]。"
  },
  State_2572_Name = {
    Text = "<Rune_12:嗜血>"
  },
  State_2573_Desc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_2573_Name = {Text = "爆弹"},
  State_2573_WeaponDesc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_2574_Desc = {
    Text = "暴击伤害+50%。如果某回合没有进行攻击，下回合必定暴击。"
  },
  State_2574_Name = {
    Text = "状态@幻梦银钥：轮舞"
  },
  State_2575_Desc = {
    Text = "队伍唯一：战斗开始时，每拥有一个造物就使装备者指令卡暴击率提高 [StateArg1]%。装备者释放狂气爆发后投一颗 4 面骰子，装备者获得 <WeaponEffect_Num:[StateArg2]> 倍骰子点数的狂气和临时暴击伤害，若其投出 4 或以上，其他唤醒体也获得一半。"
  },
  State_2575_WeaponDesc = {
    Text = "战斗开始时，每拥有一个造物就使装备者指令卡暴击率提高 [StateArg1]%。装备者释放狂气爆发后投一颗 4 面骰子，装备者获得 <WeaponEffect_Num:[StateArg2]> 倍骰子点数的狂气和临时暴击伤害，若其投出 4 或以上，其他唤醒体也获得一半。"
  },
  State_2576_Desc = {
    Text = "每当一张卡牌进入超维空间，使其算力消耗 -1。"
  },
  State_2579_Desc = {
    Text = "本回合内造成的主动伤害次数提高[Layer] 。"
  },
  State_2579_Name = {
    Text = "<MadnessColour:临时疯狂>"
  },
  State_2580_Desc = {
    Text = "每当猎颅魔女的卡牌进入或离开超维空间，获得 1算力。"
  },
  State_2580_Name = {
    Text = "维度投射"
  },
  State_2581_Desc = {
    Text = "所有唤醒体银钥充能提高 30。释放钥令后，将 3 张<DerivativeCardKeywords_4:「灵感」>洗入你的牌库。"
  },
  State_2581_Name = {
    Text = "状态@时灵摆洞悉"
  },
  State_2582_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_2582_Name = {
    Text = "状态@试作激光炮狂气"
  },
  State_2583_Desc = {
    Text = "每次收到主动伤害给我方队伍增加一层计数"
  },
  State_2583_Name = {
    Text = "状态@复仇巨刃斩首重创计数"
  },
  State_2583_WeaponDesc = {
    Text = "每次收到主动伤害给我方队伍增加一层计数"
  },
  State_2584_Desc = {
    Text = "每次牌库重置，获得 [Arg1] 力量。"
  },
  State_2586_Desc = {
    Text = "获得的所有护盾降低 25 %，回合结束时移除 1 层。"
  },
  State_2586_Name = {
    Text = "<FragileIconKeywords: 脆弱>"
  },
  State_2586_WeaponDesc = {
    Text = "获得的所有护盾降低 25 %。"
  },
  State_2587_Desc = {
    Text = "伤口伤害翻倍。每次造成实际伤害，都会获得[Layer]点护盾。"
  },
  State_2587_Name = {
    Text = "「噬天利齿」"
  },
  State_2587_WeaponDesc = {
    Text = "伤口伤害翻倍。每次造成实际伤害，都会获得[Layer]点护盾。"
  },
  State_2588_Desc = {
    Text = "回合结束后，受到 [Layer] 点<FixedDamage:纯粹伤害>并移除该状态。回复生命时移除双倍回复量的出血层数。"
  },
  State_2588_Name = {
    Text = "永久<BleedingColour: 出血>"
  },
  State_2588_WeaponDesc = {
    Text = "回合结束后，受到[Layer]点伤害并移除该状态，每次治疗可使层数减半。"
  },
  State_2589_Name = {
    Text = "饰品扭曲双子黑"
  },
  State_2589_WeaponDesc = {
    Text = "奇数回合开始后，将一张附加虚无和消耗的装备者的「打击」加入手牌。"
  },
  State_2590_Desc = {
    Text = "移动时获得 10 黑印"
  },
  State_2590_Name = {
    Text = "造物无底袋"
  },
  State_2590_WeaponDesc = {
    Text = "移动时获得 10 黑印"
  },
  State_2592_Desc = {
    Text = "每失去 1 点生命移除 1 层，层数为 0 时获得 [DescArg1] 的护盾。"
  },
  State_2592_Name = {
    Text = "维度壁障"
  },
  State_2593_Name = {
    Text = "状态@猩红血与沙的赞歌"
  },
  State_2594_Desc = {
    Text = "造成实际伤害获得护盾"
  },
  State_2594_Name = {
    Text = "「噬天利齿」"
  },
  State_2594_WeaponDesc = {
    Text = "造成实际伤害获得护盾"
  },
  State_2595_Desc = {
    Text = "每造成 1 次伤害，就获得 [StateArg2] 点临时力量。"
  },
  State_2595_Name = {
    Text = "知者女王之剑启"
  },
  State_2597_Desc = {
    Text = "回合开始后，获得 [Layer] 点护盾。"
  },
  State_2597_Name = {
    Text = "延迟护盾"
  },
  State_2597_WeaponDesc = {
    Text = "回合开始后，获得 [Layer] 点护盾。"
  },
  State_2600_Desc = {
    Text = "每当你失去生命时，狂气最低的唤醒体获得 10 狂气。每当你失去 5 次生命时，获得 1 层屏障。"
  },
  State_2600_Name = {
    Text = "时灵摆「解析」"
  },
  State_2601_Desc = {
    Text = "偶数回合受伤降低 50%，伤害提高 33%。"
  },
  State_2601_Name = {Text = "善变"},
  State_2601_WeaponDesc = {
    Text = "偶数回合受伤降低 50%，伤害提高 33%。"
  },
  State_2602_Desc = {
    Text = "你被锁定了！打出后永恒狂热者获得 [StateArg1] 点临时力量，移除该指令的深潜印记。"
  },
  State_2602_Name = {
    Text = "<CardKeyWord:深潜印记>"
  },
  State_2602_WeaponDesc = {
    Text = "卡牌打出后深潜者精英获得 [StateArg1] 点临时力量。"
  },
  State_2603_Desc = {
    Text = "若手牌中存在「胚胎」，消耗所有「胚胎」，每 1 张胚胎触发 1 次后续效果。"
  },
  State_2603_Name = {
    Text = "<UnlimitedDevouredIconKeywords:无限吞噬>"
  },
  State_2604_Desc = {
    Text = "本回合内暴击率提高 [Layer] %。"
  },
  State_2604_Name = {
    Text = "临时暴击率"
  },
  State_2604_WeaponDesc = {
    Text = "本回合内暴击率提高 [Layer] %。"
  },
  State_2605_Desc = {
    Text = "当生命低于95%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_2605_Name = {Text = "分裂"},
  State_2605_WeaponDesc = {
    Text = "当生命低于 30%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_2606_Desc = {
    Text = "当生命低于90%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_2606_Name = {Text = "分裂"},
  State_2606_WeaponDesc = {
    Text = "当生命低于 30%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_2607_Desc = {
    Text = "战斗结束时，回复 5 生命。"
  },
  State_2607_Name = {
    Text = "凸月侍女启灵3"
  },
  State_2607_WeaponDesc = {
    Text = "战斗结束时，回复 5 生命。"
  },
  State_2609_Desc = {
    Text = "当生命低于30%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_2609_Name = {Text = "分裂"},
  State_2609_WeaponDesc = {
    Text = "当生命低于 30%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_2610_Desc = {
    Text = "当生命低于70%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_2610_Name = {Text = "分裂"},
  State_2610_WeaponDesc = {
    Text = "当生命低于 30%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_2611_Desc = {
    Text = "当生命低于50%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_2611_Name = {Text = "分裂"},
  State_2611_WeaponDesc = {
    Text = "当生命低于 30%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_2612_Desc = {
    Text = "远古者模仿"
  },
  State_2612_Name = {
    Text = "远古者模仿"
  },
  State_2612_WeaponDesc = {
    Text = "远古者模仿"
  },
  State_2614_Desc = {
    Text = "队伍唯一：打出装备者的指令卡后，有 <WeaponEffect_Num:[StateArg1]%> 的概率将其从弃牌堆重新加入手牌，该效果单个回合只生效 1 次。"
  },
  State_2614_WeaponDesc = {
    Text = "打出装备者的指令卡后，有 <WeaponEffect_Num:[StateArg1]%> 的概率将其从弃牌堆重新加入手牌。该效果单个回合只生效 1 次。"
  },
  State_2617_Desc = {
    Text = "下回合开始时，额外抽 [DescArg1] 张牌。"
  },
  State_2617_Name = {
    Text = "症状：兴奋"
  },
  State_2619_Desc = {
    Text = "本场战斗内造成的主动伤害降低 [Layer] 点。"
  },
  State_2619_Name = {
    Text = "力量降低"
  },
  State_2619_WeaponDesc = {
    Text = "本场战斗内造成的伤害降低 [Layer] 点。"
  },
  State_2620_Desc = {
    Text = "造物锈蚀柳叶刀"
  },
  State_2620_Name = {
    Text = "锈蚀柳叶刀"
  },
  State_2623_Desc = {
    Text = "回合开始时获得 1 算力。"
  },
  State_2624_Desc = {
    Text = "打出后使所有敌人失去 [StateArg1] 点临时力量。"
  },
  State_2624_Name = {
    Text = "<Rune_18:衰竭>"
  },
  State_2625_Desc = {
    Text = "你的跃迁效果触发两次。进入超维回合时，所有敌人获得 5 点临时力量。"
  },
  State_2625_Name = {
    Text = "造物噩梦魂灯"
  },
  State_2626_Desc = {
    Text = "触腕上限减少 1 条。回合结束时额外使所有触腕攻击 1 次。"
  },
  State_2627_Name = {
    Text = "获得 [StateArg1] 钥能"
  },
  State_2627_WeaponDesc = {
    Text = "在“未完的蜡像”节点选择的卡牌获得钥能"
  },
  State_2628_Desc = {
    Text = "在“未完的蜡像”处复制的卡牌获得刻印效果"
  },
  State_2628_Name = {
    Text = "状态@章二_共鸣3"
  },
  State_2628_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制的卡牌获得刻印效果"
  },
  State_2629_Desc = {
    Text = "在“未完的蜡像”处发现可复制卡牌范围增加"
  },
  State_2629_Name = {
    Text = "状态@章二_共鸣2"
  },
  State_2629_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制的卡牌及其本体获得“固有”效果"
  },
  State_2630_Desc = {
    Text = "在“未完的蜡像”处复制的卡牌及其本体获得“保留”效果"
  },
  State_2630_Name = {
    Text = "状态@章二_共鸣4"
  },
  State_2630_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制的卡牌及其本体获得“保留”效果"
  },
  State_2631_Desc = {
    Text = "在“未完的蜡像”处多复制一张卡牌"
  },
  State_2631_Name = {
    Text = "状态@章二_共鸣6"
  },
  State_2631_WeaponDesc = {
    Text = "在“未完的蜡像”节点多复制一张卡牌"
  },
  State_2633_Desc = {
    Text = "每受到 1 次主动伤害，将 1 张【绿炎】置入手中并使其获得「消耗」，持续 [Layer] 回合。"
  },
  State_2633_Name = {
    Text = "诱蛾之火"
  },
  State_2633_WeaponDesc = {
    Text = "下回合前每次被攻击就将一张消耗【绿炎】加入手牌。"
  },
  State_2634_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_2634_Name = {Text = "被寄生"},
  State_2635_Desc = {
    Text = "状态@序章攻势推演标识"
  },
  State_2635_Name = {
    Text = "状态@序章攻势推演标识"
  },
  State_2635_WeaponDesc = {
    Text = "状态@序章攻势推演标识"
  },
  State_2636_Name = {
    Text = "状态@第四章共鸣@生效下回合抽牌数1"
  },
  State_2637_Desc = {
    Text = "回合开始时获得 [StateArg1] 算力。"
  },
  State_2637_Name = {
    Text = "造物活性注射器"
  },
  State_2637_WeaponDesc = {
    Text = "回合开始时获得 [StateArg1] 算力。"
  },
  State_2639_Desc = {
    Text = "在战斗中受到致命伤害时有概率保留 1 点生命。触发后在本次调查中概率减半，获得的死亡抵抗减半。"
  },
  State_2639_Name = {
    Text = "<DeathResistanceIconKeywords: 死亡抵抗>"
  },
  State_2640_Name = {
    Text = "通用重复生效1次"
  },
  State_2645_Desc = {
    Text = "状态@序章怪物被动1"
  },
  State_2645_Name = {
    Text = "状态@序章怪物被动1"
  },
  State_2645_WeaponDesc = {
    Text = "状态@序章怪物被动1"
  },
  State_2646_Desc = {
    Text = "状态@序章怪物被动2"
  },
  State_2646_Name = {
    Text = "状态@序章怪物被动2"
  },
  State_2646_WeaponDesc = {
    Text = "状态@序章怪物被动2"
  },
  State_2647_Desc = {
    Text = "状态@序章怪物被动3"
  },
  State_2647_Name = {
    Text = "状态@序章怪物被动3"
  },
  State_2647_WeaponDesc = {
    Text = "状态@序章怪物被动3"
  },
  State_2648_Desc = {
    Text = "状态@序章怪物被动4"
  },
  State_2648_Name = {
    Text = "状态@序章怪物被动4"
  },
  State_2648_WeaponDesc = {
    Text = "状态@序章怪物被动4"
  },
  State_2649_Desc = {
    Text = "状态@序章怪物被动5"
  },
  State_2649_Name = {
    Text = "状态@序章怪物被动5"
  },
  State_2649_WeaponDesc = {
    Text = "状态@序章怪物被动5"
  },
  State_2650_Desc = {
    Text = "状态@序章怪物被动6"
  },
  State_2650_Name = {
    Text = "状态@序章怪物被动6"
  },
  State_2650_WeaponDesc = {
    Text = "状态@序章怪物被动6"
  },
  State_2651_Desc = {
    Text = "状态@序章怪物被动7"
  },
  State_2651_Name = {
    Text = "状态@序章怪物被动7"
  },
  State_2651_WeaponDesc = {
    Text = "状态@序章怪物被动7"
  },
  State_2652_Desc = {
    Text = "状态@序章怪物被动8"
  },
  State_2652_Name = {
    Text = "状态@序章怪物被动8"
  },
  State_2652_WeaponDesc = {
    Text = "状态@序章怪物被动8"
  },
  State_2653_Desc = {
    Text = "状态@序章怪物被动9"
  },
  State_2653_Name = {
    Text = "状态@序章怪物被动9"
  },
  State_2653_WeaponDesc = {
    Text = "状态@序章怪物被动9"
  },
  State_2655_Desc = {
    Text = "造成未被格挡的伤害时，回复等量生命，造成伤害时移除。"
  },
  State_2655_Name = {Text = "吸血"},
  State_2656_Desc = {
    Text = "下回合开始就溜！！！！！！"
  },
  State_2656_Name = {Text = "逃跑"},
  State_2660_Desc = {
    Text = "战斗开始时，获得力量，但每次受到的伤害提高 5。"
  },
  State_2660_Name = {Text = "背水"},
  State_2661_Desc = {
    Text = "战斗开始时，所有敌人失去 [Arg1] 点力量。"
  },
  State_2662_Name = {
    Text = "状态@章三_测试状态"
  },
  State_2663_Desc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_2663_Name = {
    Text = "状态诅咒衰弱"
  },
  State_2663_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_2666_Name = {
    Text = "轮回匕首暴击率"
  },
  State_2667_Desc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_2667_Name = {
    Text = "打击牌伤害提高"
  },
  State_2667_WeaponDesc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_2668_Desc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_2668_Name = {
    Text = "通用永久攻击力百分比提高"
  },
  State_2668_WeaponDesc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_2669_Desc = {
    Text = "本场战斗内暴击伤害提高 [Layer] %。"
  },
  State_2669_Name = {
    Text = "暴击伤害"
  },
  State_2670_Desc = {
    Text = "你造成虚弱时，获得 [Arg1] 点护盾；造成易伤时，获得 [Arg2] 点力量。若在 1 回合内触发了这两个效果，额外获得 [Arg1] 点护盾和 [Arg2] 点力量。"
  },
  State_2670_Name = {
    Text = "沉重画框"
  },
  State_2671_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_2671_Name = {
    Text = "尚未觉醒"
  },
  State_2672_Desc = {
    Text = "每回合开始时，对我方队伍施加层【束缚】。"
  },
  State_2672_Name = {Text = "束缚"},
  State_2672_WeaponDesc = {
    Text = "每回合开始时，对我方队伍施加层【束缚】。"
  },
  State_2674_Desc = {
    Text = "本回合内暴击率提高 [Layer] %。"
  },
  State_2674_Name = {
    Text = "临时暴击率"
  },
  State_2676_Name = {
    Text = "饰品猩红之悸"
  },
  State_2676_WeaponDesc = {
    Text = "释放钥令后，装备者获得 15% 临时暴击率。若装备者当前暴击伤害大于 80%，额外获得 15% 临时暴击率。"
  },
  State_2677_Desc = {
    Text = "每回合前3次受到主动/触腕的伤害降低75%。"
  },
  State_2677_Name = {
    Text = "「不灭残躯」"
  },
  State_2677_WeaponDesc = {
    Text = "每回合前3次受到主动/触腕的伤害降低75%。"
  },
  State_2679_Name = {
    Text = "状态@章三_共鸣7_标志"
  },
  State_2680_Desc = {
    Text = "暴击率提高 20%。回合开始时若生命低于 25%，本回合必定暴击。"
  },
  State_2681_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_2681_Name = {
    Text = "尚未觉醒"
  },
  State_2682_Desc = {
    Text = "护盾和治疗强效提高 50%。"
  },
  State_2682_Name = {
    Text = "异化花园守护者"
  },
  State_2682_WeaponDesc = {
    Text = "护盾和治疗强效提高 50%。"
  },
  State_2683_Desc = {
    Text = "抽状态层数的牌。"
  },
  State_2683_Name = {Text = "抽牌"},
  State_2684_Desc = {
    Text = "队伍唯一：装备者的「打击」有  <WeaponEffect_Num:[StateArg1]%>  概率获得 1 算力并触发所有敌人 10％ 的<IntoxicationIconKeywords:中毒>，若当前界域为「深海」，触发该效果时使 1 条触腕攻击 1 次。该效果单个回合只生效 1 次。"
  },
  State_2684_WeaponDesc = {
    Text = "装备者的「打击」有  <WeaponEffect_Num:[StateArg1]%>  概率获得 1 算力并触发所有敌人 [DescArg1]％ 的<IntoxicationIconKeywords:中毒>，若当前界域为「深海」，触发该效果时使 1 条触腕攻击 1 次。该效果每回合最多触发 1 次。"
  },
  State_2685_Desc = {
    Text = "免疫虚弱、脆弱和易伤状态，回合结束时移除 1 层。"
  },
  State_2685_Name = {
    Text = "<BlessingIconKeywords: 祝福>"
  },
  State_2685_WeaponDesc = {
    Text = "本回合内免疫对己方施加的负面状态。"
  },
  State_2686_Desc = {
    Text = "战斗中给予的临时卡牌。"
  },
  State_2686_Name = {
    Text = "<CardKeyWord:状态卡>"
  },
  State_2687_Desc = {
    Text = "本回合内暴击率提升100%"
  },
  State_2687_Name = {
    Text = "临时必爆"
  },
  State_2687_WeaponDesc = {
    Text = "本回合内暴击率提升100%"
  },
  State_2688_Desc = {
    Text = "每回合打出第 3 张卡牌后，将 1 张「灵感」置入弃牌堆。每回合打出第 6 张卡牌后，从弃牌堆中将 1 张「灵感」置入手牌。"
  },
  State_2689_Desc = {
    Text = "回合开始时抽 2 张牌。超维卡槽容量提高 2。"
  },
  State_2689_Name = {
    Text = "造物诡术师的礼帽"
  },
  State_2689_WeaponDesc = {
    Text = "回合开始时抽 2 张牌。超维卡槽容量提高 2。"
  },
  State_2690_Desc = {
    Text = "美德骑士打出卡牌时，获得 [StateArg1] 点力量。"
  },
  State_2690_Name = {
    Text = "骑士热诚"
  },
  State_2691_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，获得 <WeaponEffect_Num:[StateArg1]> 点狂气与 <WeaponEffect_Num:[StateArg2]> 点银钥能量，每有 4 张手牌就重复 1 次。若当前界域为「超维」时，装备者的卡牌进入超维空间后，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg3]%> 的临时力量，每回合最多触发 2 次。"
  },
  State_2691_WeaponDesc = {
    Text = "装备者释放狂气爆发后，获得 <WeaponEffect_Num:[StateArg1]> 点狂气与 <WeaponEffect_Num:[StateArg2]> 点银钥能量，每有 4 张手牌就重复 1 次。若当前界域为「超维」时，装备者的卡牌进入超维空间后，获得 <WeaponEffect_Num:[Power:DescArg1]> 点临时力量，每回合最多触发 2 次。"
  },
  State_2693_Desc = {
    Text = "状态@序章狂气0_1_2效果"
  },
  State_2693_Name = {
    Text = "状态@序章狂气0_1_2效果"
  },
  State_2693_WeaponDesc = {
    Text = "状态@序章狂气0_1_2效果"
  },
  State_2694_Desc = {
    Text = "每消费 1 黑印所有唤醒体获得 1 狂气"
  },
  State_2694_Name = {
    Text = "造物逆生花状态"
  },
  State_2694_WeaponDesc = {
    Text = "每消费 1 黑印所有唤醒体获得 1 狂气"
  },
  State_2695_Desc = {
    Text = "每当一张唤醒体的卡进入超维空间后，使对应唤醒体获得 15 狂气。"
  },
  State_2696_Desc = {
    Text = "状态@序章狂气0_1_2生效"
  },
  State_2696_Name = {
    Text = "状态@序章狂气0_1_2生效"
  },
  State_2696_WeaponDesc = {
    Text = "状态@序章狂气0_1_2生效"
  },
  State_2698_Name = {
    Text = "下一回合开始时算力+1"
  },
  State_2699_Name = {
    Text = "下一回合开始时算力+2"
  },
  State_2701_Desc = {
    Text = "深海淑女获得护盾时，提高 [StateArg1] 临时触腕伤害。"
  },
  State_2701_Name = {
    Text = "受造之物"
  },
  State_2701_WeaponDesc = {
    Text = "深海淑女获得护盾时，提高 [StateArg1] 临时触腕伤害。"
  },
  State_2702_Desc = {
    Text = "拾取时获得 100% 死亡抵抗。触发死亡抵抗后，本场战斗每回合开始时回复 [Arg1] 点生命。"
  },
  State_2702_Name = {
    Text = "人工呼吸"
  },
  State_2703_Desc = {
    Text = "每回合打出的第一张唤醒体牌的临时复制会进入维度裂隙中，它们能用于在危险时刻保护自己！"
  },
  State_2703_Name = {
    Text = "维度裂隙"
  },
  State_2705_Desc = {Text = "——"},
  State_2705_Name = {
    Text = "复仇宣言"
  },
  State_2705_WeaponDesc = {Text = "——"},
  State_2706_Desc = {
    Text = "渐渐石化检测"
  },
  State_2706_Name = {
    Text = "渐渐石化检测"
  },
  State_2706_WeaponDesc = {
    Text = "渐渐石化检测"
  },
  State_2707_Desc = {
    Text = "本回合内触腕攻击全体敌方"
  },
  State_2707_Name = {
    Text = "触腕全体攻击"
  },
  State_2707_WeaponDesc = {
    Text = "本回合内触腕攻击全体敌方"
  },
  State_2708_Desc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，触腕伤害提高 [StateArg1]点 。"
  },
  State_2708_Name = {
    Text = "异化过往的贡物"
  },
  State_2708_WeaponDesc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，触腕伤害提高 [StateArg1]点 。"
  },
  State_2709_Desc = {
    Text = "造物锈蚀柳叶刀计数"
  },
  State_2710_Desc = {Text = "印记"},
  State_2710_Name = {Text = "印记"},
  State_2710_WeaponDesc = {Text = "印记"},
  State_2711_Desc = {
    Text = "临时改变卡牌算力"
  },
  State_2711_Name = {
    Text = "临时改变卡牌算力"
  },
  State_2711_WeaponDesc = {
    Text = "临时改变卡牌算力"
  },
  State_2712_Desc = {
    Text = "提高造成的护盾。"
  },
  State_2712_Name = {
    Text = "<AlertIconKeywords: 戒备>"
  },
  State_2712_WeaponDesc = {
    Text = "获得的护盾提高。"
  },
  State_2713_Desc = {
    Text = "复仇巨刃每回合都会获得力量。"
  },
  State_2713_Name = {
    Text = "复仇巨刃觉醒"
  },
  State_2713_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_2715_Desc = {
    Text = "本次关卡内造成的护盾提高 [Layer] 点。"
  },
  State_2715_Name = {
    Text = "永久戒备"
  },
  State_2715_WeaponDesc = {
    Text = "本次关卡内造成的护盾提高 [Layer] 点。"
  },
  State_2718_Desc = {
    Text = "队伍唯一：回合结束时装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气，获得等同于装备者银钥充能的银钥能量。"
  },
  State_2718_WeaponDesc = {
    Text = "回合结束时装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气，获得等同于装备者银钥充能的银钥能量。"
  },
  State_2720_Desc = {
    Text = "造成实际伤害时，降低狂气最高的唤醒体 10 狂气。"
  },
  State_2720_Name = {Text = "虚无"},
  State_2720_WeaponDesc = {
    Text = "造成实际伤害时，降低狂气最高的唤醒体 10 狂气。"
  },
  State_2721_Name = {
    Text = "状态@关卡2_9战斗5气泡1"
  },
  State_2722_Desc = {
    Text = "打出后将 [StateArg1] 张 「灵感」 洗入抽牌堆。「灵感」：获得 1 算力，抽 1 张牌，保留，消耗。"
  },
  State_2722_Name = {
    Text = "<Rune_17_High:高级灵感>"
  },
  State_2723_Desc = {
    Text = "打出后易伤所有敌人 [StateArg1] 回合。"
  },
  State_2723_Name = {
    Text = "<Rune_1_High:高级易伤>"
  },
  State_2724_Desc = {
    Text = "攻击次数提高 1。"
  },
  State_2724_Name = {
    Text = "幻梦之核反攻"
  },
  State_2726_Desc = {
    Text = "打出后对所有敌人施加 [StateArg1] 层中毒，使所有敌人触发 [StateArg2]% 中毒。"
  },
  State_2726_Name = {
    Text = "<Rune_10_High:高级毒素>"
  },
  State_2727_Desc = {
    Text = "即将死亡时，回复 1 生命并移除该状态。"
  },
  State_2727_Name = {Text = "根性"},
  State_2727_WeaponDesc = {
    Text = "即将死亡时，回复 1 生命并移除该状态。"
  },
  State_2728_Desc = {
    Text = "回合开始时每有一个其他友方，获得 1 层<ParcloseIconKeywords:屏障>。"
  },
  State_2728_Name = {
    Text = "链接障壁"
  },
  State_2728_WeaponDesc = {
    Text = "回合开始时每有一个其他友方，获得最大生命值百分之 [Layer] 的护盾。"
  },
  State_2729_Desc = {
    Text = "触发时抽一张对应唤醒体的牌。"
  },
  State_2729_Name = {
    Text = "异化空间偏折仪抽牌"
  },
  State_2729_WeaponDesc = {
    Text = "触发时抽一张对应唤醒体的牌。"
  },
  State_2730_Desc = {
    Text = "自身死亡后，海德拉减少 1 层「万蛇操使」状态。"
  },
  State_2730_Name = {Text = "眷属"},
  State_2732_Desc = {
    Text = "状态@序章狂气初始化0_2_3"
  },
  State_2732_Name = {
    Text = "状态@序章狂气初始化0_2_3"
  },
  State_2732_WeaponDesc = {
    Text = "状态@序章狂气初始化0_2_3"
  },
  State_2734_Name = {
    Text = "下一回合开始时抽牌数+1"
  },
  State_2735_Desc = {
    Text = "若此卡打出后触发「维度穿梭」或当前处于超维回合，触发后续效果。"
  },
  State_2735_Name = {
    Text = "<TransitionIconKeywords:跃迁>"
  },
  State_2735_WeaponDesc = {
    Text = "若当前处于超维回合，可触发跃迁效果。"
  },
  State_2737_Desc = {
    Text = "当我方队伍牌库重置时，获得 [Layer] 点力量。"
  },
  State_2737_Name = {
    Text = "永远凝结"
  },
  State_2738_Name = {
    Text = "虚弱效果提高"
  },
  State_2740_Desc = {
    Text = "在“未完的蜡像”处复制的卡牌及其本体算力消耗-1，同时获得一张症状卡"
  },
  State_2740_Name = {
    Text = "状态@章二_共鸣5_2"
  },
  State_2740_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制的卡牌及其本体算力消耗-1"
  },
  State_2741_Desc = {
    Text = "在“未完的蜡像”处复制的卡牌及其本体算力消耗-1，同时获得一张症状卡"
  },
  State_2741_Name = {
    Text = "状态@章二_共鸣5_1"
  },
  State_2741_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制的卡牌及其本体算力消耗-1"
  },
  State_2742_Desc = {
    Text = "嘀嗒人每造成 1 次伤害，获得 [StateArg2] 临时力量， 每获得 1 次护盾，获得 [StateArg3] 临时戒备。"
  },
  State_2742_Name = {
    Text = "参数拟合"
  },
  State_2744_Desc = {
    Text = "每当一张唤醒体的卡进入超维空间后，使其获得 15 狂气。"
  },
  State_2744_Name = {
    Text = "造物跃迁装置"
  },
  State_2744_WeaponDesc = {
    Text = "每当一张唤醒体的卡进入超维空间后，使其获得 15 狂气。"
  },
  State_2746_Desc = {
    Text = "攻击次数+1，失去[Layer]点力量"
  },
  State_2746_Name = {Text = "焦躁"},
  State_2747_Desc = {
    Text = "打出后其他唤醒体获得 [StateArg1] 狂气。"
  },
  State_2747_Name = {
    Text = "<Rune_16:催化>"
  },
  State_2748_Desc = {
    Text = "状态@提灯仪式"
  },
  State_2748_Name = {
    Text = "状态@提灯仪式"
  },
  State_2748_WeaponDesc = {
    Text = "状态@提灯仪式"
  },
  State_2749_Desc = {
    Text = "本回合内造成触腕伤害后，对目标施加 [Layer] 层中毒。"
  },
  State_2749_Name = {
    Text = "深邃暗流"
  },
  State_2750_Desc = {
    Text = "与我一同沉入大海吧·········"
  },
  State_2750_Name = {
    Text = "宁菲亚觉醒"
  },
  State_2752_Desc = {
    Text = "睡莲造成伤害时，获得 [StateArg2] 狂气。"
  },
  State_2752_Name = {
    Text = "沉逝苦海"
  },
  State_2752_WeaponDesc = {
    Text = "睡莲造成伤害时，获得 [StateArg2] 狂气。"
  },
  State_2753_Desc = {
    Text = "回合开始时若生命大于 [Arg1]，失去 [Arg1] 点生命，当回合内获得 [Arg2] 点力量和 [Arg3] 点戒备。"
  },
  State_2754_Name = {
    Text = "状态@临时打击卡暴击率提高"
  },
  State_2757_Desc = {
    Text = "下回合开始时，额外获得 [DescArg1] 点算力。"
  },
  State_2757_Name = {
    Text = "症状：多疑"
  },
  State_2758_Desc = {
    Text = "你的所有生命回复效果提高 [Arg1] 点，超额回复的生命会转化为等量护盾。"
  },
  State_2758_Name = {
    Text = "蝴蝶标本"
  },
  State_2760_Desc = {
    Text = "每当一名唤醒体进行过 1 次吞噬，其他唤醒体获得 10 狂气。"
  },
  State_2762_Desc = {
    Text = "打出后额外生效 [StateArg1] 次，获得 [StateArg2] 点黑印，消耗，固有。"
  },
  State_2762_Name = {
    Text = "<Rune_7_High:高级回声>"
  },
  State_2762_WeaponDesc = {
    Text = "打出后额外生效 [StateArg1] 次，消耗。"
  },
  State_2763_Desc = {
    Text = "沉睡之主每消耗 1 算力时，提高 [StateArg1] 触腕伤害。"
  },
  State_2763_Name = {
    Text = "不朽威仪"
  },
  State_2763_WeaponDesc = {
    Text = "沉睡之主每消耗 1 算力时，提高 [StateArg1] 触腕伤害。"
  },
  State_2764_Desc = {
    Text = "造成未被格挡的伤害时，附加 [StateArg1] 层出血。"
  },
  State_2764_Name = {
    Text = "恶意放血"
  },
  State_2765_Name = {
    Text = "状态@乔治@死亡时治疗"
  },
  State_2767_Name = {
    Text = "状态@黑印和银钥充能效率"
  },
  State_2769_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_2769_Name = {
    Text = "尚未觉醒"
  },
  State_2771_Desc = {
    Text = "怪物力量"
  },
  State_2771_Name = {
    Text = "怪物力量"
  },
  State_2772_Name = {
    Text = "状态@关卡2_5战斗3气泡1"
  },
  State_2773_Desc = {
    Text = "战斗开始时，将 1 张「美丽瞬间 - 将手中所有唤醒体的牌更换为「打击」，直到回合结束。保留，消耗。」加入手中。"
  },
  State_2775_Desc = {
    Text = "回归抽牌数"
  },
  State_2775_Name = {
    Text = "抽牌数回归"
  },
  State_2776_Name = {
    Text = "石之眼凝滞诅咒强化"
  },
  State_2777_Name = {
    Text = "状态@章三_空状态"
  },
  State_2778_Desc = {
    Text = "战斗开始时获得 [Arg1] 点护盾。在本场战斗内打出 7 次「防御」后，立刻获得 [Arg2] 点护盾。"
  },
  State_2778_Name = {
    Text = "普特尼晨报"
  },
  State_2779_Desc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为 3 只等量生命的「干涉型融蚀体」。"
  },
  State_2779_Name = {Text = "分裂"},
  State_2779_WeaponDesc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为2只等量生命的「II型融蚀体」。"
  },
  State_2780_Desc = {
    Text = "打出后获得 [StateArg1] 点算力。"
  },
  State_2780_Name = {
    Text = "<Rune_4:筹算>"
  },
  State_2781_Desc = {
    Text = "每打出 [Layer] 张牌，自身若没有屏障，添加一层<ParcloseIconKeywords:屏障>。"
  },
  State_2781_Name = {
    Text = "充能屏障"
  },
  State_2781_WeaponDesc = {
    Text = "我方队伍每打出 [Layer] 张牌，怪物刷新一层屏障"
  },
  State_2784_Desc = {
    Text = "即使不在超维回合，每回合也能够触发一次跃迁效果。超维空间容量提高 2。"
  },
  State_2785_Desc = {
    Text = "队伍唯一：装备者打出卡牌后，装备者获得 1 点狂气。战斗开始时，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量> ，若当前界域为「深海」，额外获得 <WeaponEffect_Num:[StateArg2]%> 的<CardKeyWord:触腕伤害>，后续的每个回合开始后，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg3]%> 的<PowerIconKeywords:力量> ，若当前界域为「深海」，额外获得 <WeaponEffect_Num:[StateArg4]%> 的<CardKeyWord:触腕伤害>。"
  },
  State_2785_WeaponDesc = {
    Text = "装备者打出卡牌后，装备者获得 1 点狂气。战斗开始时，获得 <WeaponEffect_Num:[Power:DescArg1]> 点<PowerIconKeywords:力量> 。若当前界域为「深海」，额外获得 <WeaponEffect_Num:[DescArg2]> 点<CardKeyWord:触腕伤害>，后续每个回合开始后，获得 <WeaponEffect_Num:[Power:DescArg3]> 点<PowerIconKeywords:力量> 。若当前界域为「深海」，额外获得 <WeaponEffect_Num:[DescArg4]> 点<CardKeyWord:触腕伤害>."
  },
  State_2786_Name = {
    Text = "造物染血鹅卵石计数"
  },
  State_2787_Desc = {
    Text = "回复生命，将 1 张【虚无终结】洗入弃牌堆。永续，销毁。"
  },
  State_2787_Name = {
    Text = "<CardKeyWord:真理追寻>"
  },
  State_2787_WeaponDesc = {
    Text = "回复生命，将 1 张【虚无终结】洗入弃牌堆。永续，销毁。"
  },
  State_2788_Desc = {
    Text = "回合开始时抽 [StateArg1] 张牌。"
  },
  State_2788_Name = {
    Text = "造物先知的许愿灯1"
  },
  State_2788_WeaponDesc = {
    Text = "回合开始时抽 [StateArg1] 张牌。"
  },
  State_2789_Desc = {
    Text = "卡牌被詹金做了手脚！打出后受到 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_2789_Name = {
    Text = "<CardKeyWord:打出后受到 [Layer] 点伤害>"
  },
  State_2789_WeaponDesc = {
    Text = "卡牌打出后受到 [StateArg1] 点伤害。"
  },
  State_2790_Desc = {
    Text = "回合结束时可以选择保留 [StateArg1] 张手牌。"
  },
  State_2790_Name = {
    Text = "造物先知的许愿灯2"
  },
  State_2790_WeaponDesc = {
    Text = "回合结束时可以选择保留 [StateArg1] 张手牌。"
  },
  State_2792_Desc = {
    Text = "战斗开始时，全体友方获得 3 层【蜡质铠甲】。回合开始时，将一张惊厥洗入我方队伍抽牌堆。"
  },
  State_2792_Name = {
    Text = "「蜡之淑女」"
  },
  State_2792_WeaponDesc = {
    Text = "战斗开始时，全体友方获得 3 层【蜡质铠甲】。回合开始时，将一张惊厥洗入我方队伍抽牌堆。"
  },
  State_2793_Desc = {
    Text = "状态@石之眼垂死之挣"
  },
  State_2793_Name = {
    Text = "状态@石之眼垂死之挣"
  },
  State_2793_WeaponDesc = {
    Text = "状态@石之眼垂死之挣"
  },
  State_2796_Desc = {
    Text = "每当你失去生命，对所有敌人添加 [Arg1] 层中毒。每回合使中毒值提高 [Arg2] 点"
  },
  State_2797_Desc = {
    Text = "回合开始时，将一张本回合内获得 [Arg1] 戒备的「阳伞」加入手中，打出 6 张卡牌后，使手牌中所有的「阳伞」戒备提高 [Arg2]。"
  },
  State_2798_Desc = {
    Text = "仁爱主祭施加护盾时，使 1 张随机手牌直到打出前算力消耗 -1。"
  },
  State_2798_Name = {
    Text = "父的慈悲"
  },
  State_2798_WeaponDesc = {
    Text = "仁爱主祭施加护盾时，使 1 张随机手牌直到打出前算力消耗 -1。"
  },
  State_2799_Desc = {
    Text = "海月造成主动伤害时，使 [StateArg1] 条触腕攻击该目标。"
  },
  State_2799_Name = {
    Text = "自我增殖"
  },
  State_2799_WeaponDesc = {
    Text = "海月造成伤害时，使 [StateArg1] 条触腕攻击该目标。"
  },
  State_2800_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_2800_Name = {
    Text = "状态@试作小刀爆伤"
  },
  State_2801_Desc = {
    Text = "受到实际伤害提升深度融蚀层数"
  },
  State_2801_Name = {
    Text = "受到伤害提升深度融蚀层数"
  },
  State_2801_WeaponDesc = {
    Text = "受到实际伤害提升深度融蚀层数"
  },
  State_2802_Desc = {
    Text = "回合开始增加临时力量"
  },
  State_2802_Name = {
    Text = "加临时力量"
  },
  State_2804_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_2804_Name = {
    Text = "状态@试作激光炮爆伤"
  },
  State_2805_Desc = {
    Text = "回合结束时，其他友方获得力量"
  },
  State_2805_Name = {
    Text = "「启明之火」"
  },
  State_2807_Desc = {
    Text = "回合开始时，将一张本回合内获得 [Arg1] 戒备的「阳伞」加入手中，打出 6 张卡牌后，使手牌中所有的「阳伞」戒备提高 [Arg2]。"
  },
  State_2808_Desc = {
    Text = "回合结束时生成 1 个胚胎融合度，如果手牌中有胚胎，回复 15 生命。"
  },
  State_2808_Name = {
    Text = "异化止血钳"
  },
  State_2808_WeaponDesc = {
    Text = "回合结束时生成 1 个胚胎融合度，如果手牌中有胚胎，回复 15 生命。"
  },
  State_2809_Desc = {
    Text = "拾取时永久失去 [Arg1] 力量。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  State_2809_Name = {
    Text = "七鳃鳗之吻"
  },
  State_2810_Desc = {
    Text = "回合结束时，回复 [Layer] %最大生命值。"
  },
  State_2810_Name = {Text = "自愈"},
  State_2810_WeaponDesc = {
    Text = "怪物回合结束时，回复最大生命值的 [Layer] %"
  },
  State_2811_Desc = {
    Text = "抽到症状卡时获得 [Arg1] 点力量。你每拥有 1 个诅咒刻印或诅咒造物，暴击率和暴击伤害就提高 10%。"
  },
  State_2812_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_2812_Name = {
    Text = "尚未觉醒"
  },
  State_2813_Desc = {
    Text = "回合开始时失去算力"
  },
  State_2813_Name = {
    Text = "失算了！"
  },
  State_2814_Desc = {
    Text = "战斗胜利时获得的刻印变为强大而危险的诅咒刻印。"
  },
  State_2817_Desc = {
    Text = "每层使受到的伤害降低 [StateArg1]，每次被暴击后减少 1 层。"
  },
  State_2817_Name = {
    Text = "蜡质铠甲"
  },
  State_2817_WeaponDesc = {
    Text = "免疫异常状态，被暴击后移除。"
  },
  State_2818_Desc = {
    Text = "分裂为融蚀三角小和融蚀三角小B。"
  },
  State_2818_Name = {Text = "分裂"},
  State_2818_WeaponDesc = {
    Text = "分裂为融蚀三角小和融蚀三角小B。"
  },
  State_2820_Desc = {
    Text = "打出后获得 [StateArg1] 点临时力量，该刻印卡牌也能享受力量加成。"
  },
  State_2820_Name = {
    Text = "<Rune_15:爆发>"
  },
  State_2821_Name = {
    Text = "临时免疫易伤"
  },
  State_2823_Desc = {
    Text = "队伍唯一：战斗开始时对前排敌人施加 2 层<VulnerabilityIconKeywords:易伤>。回合开始时，处于易伤状态的敌人失去等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>。若当前界域为「血肉」，装备者释放「狂气爆发」后，胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2823_WeaponDesc = {
    Text = "战斗开始时，对前排敌人施加 2 层<VulnerabilityIconKeywords:易伤>。回合开始时，处于易伤状态的敌人失去 <WeaponEffect_Num:[Power:DescArg1]> 点临时<PowerIconKeywords:力量>。若当前界域为「血肉」，装备者释放「狂气爆发」后，胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]>。"
  },
  State_2825_Desc = {
    Text = "怪物超维卡槽上限"
  },
  State_2825_Name = {
    Text = "怪物超维卡槽上限"
  },
  State_2825_WeaponDesc = {
    Text = "怪物超维卡槽上限"
  },
  State_2826_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，当前狂气最低的唤醒体获得 50 狂气。"
  },
  State_2826_Name = {
    Text = "造物阿尔卡纳遗物"
  },
  State_2827_Desc = {
    Text = "伤害次数和伤害提高。"
  },
  State_2827_Name = {
    Text = "<CardKeyWord:升级>"
  },
  State_2829_Desc = {
    Text = "造成实际伤害时，获得 [Layer] 点力量。"
  },
  State_2829_Name = {
    Text = "「纷乱人格」"
  },
  State_2830_Desc = {
    Text = "队伍中每有一名【深海】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_2830_Name = {
    Text = "深海加成"
  },
  State_2830_WeaponDesc = {
    Text = "队伍中每有一名【深海】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_2832_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_2832_Name = {
    Text = "状态@试作激光炮死抗"
  },
  State_2833_Desc = {
    Text = "回合开始时抽 1 张牌。每当你抽到 1 张牌时，随机变化其算力消耗（0-4）。"
  },
  State_2835_Desc = {
    Text = "每进行 1 次吞噬，偷取所有敌人 [Arg1] 临时力量。"
  },
  State_2836_Name = {
    Text = "状态@诅咒盲从"
  },
  State_2837_Name = {
    Text = "状态@诅咒盲从"
  },
  State_2838_Name = {
    Text = "状态@诅咒盲从"
  },
  State_2840_Desc = {
    Text = "回合结束后，受到 [Layer] 点<FixedDamage:纯粹伤害>并移除 [DescArg1]% 层数。回复生命时移除双倍回复量的出血层数。"
  },
  State_2840_Name = {
    Text = "<BleedingColour: 出血>"
  },
  State_2840_WeaponDesc = {
    Text = "回合结束后，受到[Layer]点伤害并移除该状态，每次治疗可使层数减半。"
  },
  State_2842_Desc = {
    Text = "打出后获得 [StateArg1] 层反击，对所有敌人造成 [StateArg2]% 反击的<FixedDamage:纯粹伤害>。"
  },
  State_2842_Name = {
    Text = "<Rune_9:尖刺>"
  },
  State_2843_Desc = {
    Text = "我方队伍每打出 1 张牌，获得 [StateArg1] 层护盾。持续 1 回合。"
  },
  State_2843_Name = {
    Text = "飞羽漫天"
  },
  State_2843_WeaponDesc = {
    Text = "我方队伍每打出 1 张牌，获得 [StateArg1] 层护盾。持续 1 回合。"
  },
  State_2844_Desc = {
    Text = "每场战斗中第 1 次失去生命时，获得 1 层免疫一次伤害的屏障。"
  },
  State_2845_Name = {
    Text = "饰品埋骨地絮语"
  },
  State_2845_WeaponDesc = {
    Text = "关卡开始时死亡抵抗提高 25%。触发死亡抵抗后，装备者获得 50 点狂气。"
  },
  State_2846_Desc = {
    Text = "免疫一次死亡，触发后回复 [Arg1] 生命并使该造物永久失效。"
  },
  State_2846_Name = {
    Text = "替身玩偶"
  },
  State_2847_Desc = {
    Text = "被狩猎唤醒体每使用一张卡牌，叠加1层狩猎印记，并抽取狩猎印记层数一半的卡牌。"
  },
  State_2847_Name = {
    Text = "狩猎仪式"
  },
  State_2849_Desc = {
    Text = "每当你失去生命，就获得 [Arg1] 点力量，最多堆叠 10 次。层数满时，回复已损失生命值 25% 的生命。"
  },
  State_2849_Name = {
    Text = "无上荣宠"
  },
  State_2853_Desc = {
    Text = "造物长眠安乐椅计数"
  },
  State_2854_Desc = {
    Text = "死亡后不为唤醒体提供狂气。"
  },
  State_2854_Name = {Text = "自私"},
  State_2854_WeaponDesc = {
    Text = "死亡后不为唤醒体提供狂气。"
  },
  State_2855_Desc = {
    Text = "打击卡伤害提高 [StateArg1]%，持续 [Layer] 回合。"
  },
  State_2855_Name = {
    Text = "绝境求生·打击"
  },
  State_2855_WeaponDesc = {
    Text = "本回合你的打击卡伤害提高 [Layer]%。"
  },
  State_2856_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]％>，并且造成护盾时，己方全员获得 <WeaponEffect_Num:[StateArg3]％> 临时暴击率和 <WeaponEffect_Num:[StateArg4]%> 装备者银钥充能的银钥能量，每回合最多生效 2 次。若当前界域为「深海」，每当有 1 条触腕攻击时，装备者获得 1 点狂气，每回合最多获得 <WeaponEffect_Num:[StateArg2]> 点。"
  },
  State_2856_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]％>，并且造成护盾时，己方全员获得 <WeaponEffect_Num:[StateArg3]％> 临时暴击率和 <WeaponEffect_Num:[StateArg4]%> 装备者银钥充能的银钥能量，每回合最多生效 2 次。若当前界域为「深海」，每当有 1 条触腕攻击时，装备者获得 1 点狂气，每回合最多获得 <WeaponEffect_Num:[StateArg2]> 点。"
  },
  State_2857_Desc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。最大生命降低 50%。"
  },
  State_2858_Name = {
    Text = "打出时额外获得两层屏障"
  },
  State_2859_Desc = {
    Text = "战斗开始后该卡固定在手牌中。"
  },
  State_2859_Name = {
    Text = "<CardKeyWord:固有>"
  },
  State_2860_Desc = {
    Text = "抽到时使自身最大生命降低 10%。使用后使所有唤醒体本回合暴击伤害提高 100%。无法出售。"
  },
  State_2860_Name = {
    Text = "状态诅咒融蚀"
  },
  State_2860_WeaponDesc = {
    Text = "抽到时使自身最大生命降低 10%。使用后使所有唤醒体本回合暴击伤害提高 100%。无法出售。"
  },
  State_2861_Name = {
    Text = "(剩余:[Layer])"
  },
  State_2862_Desc = {
    Text = "回合结束时额外受到一次中毒伤害"
  },
  State_2862_Name = {
    Text = "体质衰弱"
  },
  State_2863_Desc = {
    Text = "进化层数"
  },
  State_2863_Name = {
    Text = "进化层数"
  },
  State_2863_WeaponDesc = {
    Text = "进化层数"
  },
  State_2864_Desc = {
    Text = "「24」 已经觉醒，使用最后的「救救我」找到机会吧！"
  },
  State_2864_Name = {
    Text = "「24」觉醒！"
  },
  State_2864_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_2866_Desc = {
    Text = "队伍唯一：手牌上限 +2，回合结束时获得等同于装备者 <WeaponEffect_Num:[StateArg1]%> 银钥充能的银钥能量。每次释放钥令后，所有唤醒体获得 <WeaponEffect_Num:[StateArg2]> 点狂气，若当前界域为「血肉」，还会使胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_2866_WeaponDesc = {
    Text = "手牌上限 +2，回合结束时获得 <WeaponEffect_Num:[DescArg1]> 点银钥能量。每次释放钥令后，所有唤醒体获得 <WeaponEffect_Num:[StateArg2]> 点狂气，若当前界域为「血肉」，还会使胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_2868_Desc = {
    Text = "回合结束时手中每有 1 张未打出的卡牌，就使所有唤醒体获得 2 狂气。"
  },
  State_2871_Desc = {
    Text = "生命低于50%([StateArg1])召唤1个等量生命的融蚀三角中"
  },
  State_2871_Name = {Text = "召唤"},
  State_2871_WeaponDesc = {
    Text = "生命低于50%([StateArg1])召唤1个等量生命的融蚀三角中"
  },
  State_2874_Desc = {
    Text = "唤醒体在被猎颅者注视，使用其卡牌可以额外抽 2 张牌。"
  },
  State_2875_Desc = {
    Text = "打出后胚胎融合 +[StateArg1]。"
  },
  State_2875_Name = {
    Text = "<Rune_12_High:高级嗜血>"
  },
  State_2875_WeaponDesc = {
    Text = "打出后胚胎融合+ [Blood:StateArg1]。"
  },
  State_2876_Desc = {
    Text = "战斗结束后，额外获得 50 黑印和 1 张症状卡。"
  },
  State_2877_Desc = {
    Text = "红夫人每造成 1 次伤害，就获得 [StateArg2] 点临时力量。"
  },
  State_2877_Name = {
    Text = "迎客特权"
  },
  State_2878_Desc = {
    Text = "伤害次数提高 1，但伤害减少 25%。"
  },
  State_2878_Name = {Text = "狂乱"},
  State_2878_WeaponDesc = {
    Text = "伤害次数提高 1，但伤害减少 25%。"
  },
  State_2879_Name = {
    Text = "甜蜜蛞蝓"
  },
  State_2879_WeaponDesc = {
    Text = "使用「湮灭」后，若本回合处于静海姿态，装备者本回合护盾与治疗效果提高 30%。"
  },
  State_2880_Name = {
    Text = "状态@海之使徒启灵7"
  },
  State_2881_Desc = {
    Text = "每当将 1 张「圣礼」转化为「执妄」后，本场战斗弥利亚姆造成的基础伤害提高 15%。"
  },
  State_2881_Name = {
    Text = "泡影幻灭"
  },
  State_2883_Desc = {
    Text = "队伍唯一：装备者造成主动伤害后，有  <WeaponEffect_Num:[StateArg1]%> 的概率抽 1 张装备者的指令卡并使其算力消耗降低 1。该效果单个回合只生效 1 次。"
  },
  State_2883_WeaponDesc = {
    Text = "装备者造成主动伤害后，有  <WeaponEffect_Num:[StateArg1]%> 的概率抽 1 张装备者的指令卡并使其算力消耗降低 1。该效果单个回合只生效 1 次。"
  },
  State_2884_Name = {
    Text = "造成的伤害为<PunctureDamagewords:穿刺伤害>。使手中算力最高的 1 张牌算力消耗降低 1"
  },
  State_2885_Name = {
    Text = "状态@回合开始后抽牌加2"
  },
  State_2887_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，其本回合暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，手中所有装备者的卡牌都有 <WeaponEffect_Num:[StateArg2]%> 概率本回合内算力消耗降低 1 点。"
  },
  State_2887_WeaponDesc = {
    Text = "装备者释放狂气爆发后，其本回合暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，手中所有装备者的卡牌都有 <WeaponEffect_Num:[StateArg2]%> 概率本回合内算力消耗降低 1 点。"
  },
  State_2888_Desc = {
    Text = "若手牌中存在「胚胎」，消耗 1 张并触发后续效果。"
  },
  State_2888_Name = {
    Text = "<DevouredIconKeywords:吞噬>"
  },
  State_2888_WeaponDesc = {
    Text = "消耗手牌中的胚胎，触发强大的吞噬效果。"
  },
  State_2889_Name = {
    Text = "选择一名唤醒体获得 <Energy:[DescArg1]> 点狂气"
  },
  State_2890_Desc = {
    Text = "战斗开始时，对我方队伍造成 1 层脆弱。"
  },
  State_2890_Name = {Text = "破甲"},
  State_2890_WeaponDesc = {
    Text = "战斗开始时，对我方队伍造成 1 层脆弱。"
  },
  State_2891_Name = {
    Text = "狂气开场回复提升"
  },
  State_2892_Desc = {
    Text = "回合结束时，回复 [Layer] 点生命。"
  },
  State_2892_Name = {
    Text = "延迟生命回复"
  },
  State_2892_WeaponDesc = {
    Text = "直到回合结束，每次造成击杀，回复 [Layer] 点生命。"
  },
  State_2897_Desc = {
    Text = "释放本源降临时，降低敌人的临时力量。"
  },
  State_2897_Name = {
    Text = "畏惧狂气"
  },
  State_2899_Desc = {
    Text = "若对方手牌数大于等于 4，受到伤害时，就获得 [StateArg1] 点护盾。"
  },
  State_2899_Name = {Text = "蛇形"},
  State_2900_Desc = {
    Text = "本场战斗内造成的伤害提高 [Layer] 点。"
  },
  State_2900_Name = {Text = "力量"},
  State_2900_WeaponDesc = {
    Text = "本场战斗内造成的伤害提高 [Layer] 点。"
  },
  State_2901_Desc = {
    Text = "[狂气爆发]使自身获得 20 点狂气。"
  },
  State_2901_Name = {
    Text = "造物无名之神的面纱"
  },
  State_2901_WeaponDesc = {
    Text = "[狂气爆发]使自身获得 20 点狂气。"
  },
  State_2902_Desc = {
    Text = "缸中之脑回复生命翻倍。"
  },
  State_2902_Name = {
    Text = "灵肉两分"
  },
  State_2902_WeaponDesc = {
    Text = "缸中之脑回复生命翻倍。"
  },
  State_2903_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_2903_Name = {
    Text = "状态@试作小刀暴击"
  },
  State_2904_Desc = {
    Text = "每次受到实际伤害后，获得 10 护盾。"
  },
  State_2904_Name = {Text = "缓冲"},
  State_2904_WeaponDesc = {
    Text = "每次受到实际伤害后，获得 10 护盾。"
  },
  State_2905_Desc = {
    Text = "队伍唯一：装备者的「狂气爆发」造成的护盾提高 <WeaponEffect_Num:[StateArg2]%>。装备者释放「狂气爆发」后，获得等同于装备者防御力 <WeaponEffect_Num:[StateArg1]%> 层数的临时<PowerIconKeywords:力量>。若我方队伍处于<FragileIconKeywords:脆弱>状态，效果翻倍。"
  },
  State_2905_WeaponDesc = {
    Text = "装备者的「狂气爆发」造成的护盾提高 <WeaponEffect_Num:[StateArg2]%>。装备者释放「狂气爆发」后，获得 [Power:DescArg1] 点临时<PowerIconKeywords:力量>。若我方队伍处于<FragileIconKeywords:脆弱>状态，效果翻倍。"
  },
  State_2906_Desc = {
    Text = "造成实际伤害后，使我方队伍临时降低[Layer]点力量。"
  },
  State_2906_Name = {
    Text = "麻痹电击"
  },
  State_2909_Desc = {
    Text = "拥有 [Layer] 点狂气。若狂气大于等于 5，意图变为 「扭曲的死体狂宴」，狂气降低后恢复。"
  },
  State_2909_Name = {
    Text = "状态@怪物24扭曲的死体狂宴计数"
  },
  State_2909_WeaponDesc = {
    Text = "拥有 [Layer] 点狂气。若狂气大于等于 5，意图变为 「扭曲的死体狂宴」，狂气降低后恢复。"
  },
  State_2910_Desc = {
    Text = "队伍唯一：探索开始时将一张「灵感」和装备者的「打击」加入牌库，装备者「打击」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，打出后有 <WeaponEffect_Num:[StateArg2]%> 概率抽 1 张牌。该效果每回合最多触发 1 次。若当前界域为「超维」并在超维回合中，「打击」将 1 张「灵感」置入手中，当回合最多触发 1 次。"
  },
  State_2910_WeaponDesc = {
    Text = "探索开始时将一张「灵感」和装备者的「打击」加入牌库，装备者「打击」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，打出后有 <WeaponEffect_Num:[StateArg2]%> 概率抽 1 张牌。该效果每回合最多触发 1 次。若当前界域为「超维」并在超维回合中，「打击」将 1 张「灵感」置入手中，当回合最多触发 1 次。"
  },
  State_2911_Desc = {
    Text = "状态@纯白的空想世界改计数"
  },
  State_2911_Name = {
    Text = "状态@纯白的空想世界计数"
  },
  State_2911_WeaponDesc = {
    Text = "状态@纯白的空想世界改计数"
  },
  State_2912_Desc = {
    Text = "你被锁定了！打出后蹈海者亲卫获得 [StateArg1] 点临时力量，移除该指令的深潜印记。"
  },
  State_2912_Name = {
    Text = "<CardKeyWord:深潜印记>"
  },
  State_2912_WeaponDesc = {
    Text = "卡牌打出后深潜者亲卫获得 [StateArg1] 点临时力量。"
  },
  State_2913_Desc = {
    Text = "战斗开始时脆弱自身 3 回合。"
  },
  State_2913_Name = {
    Text = "造物古怪钩爪2"
  },
  State_2913_WeaponDesc = {
    Text = "战斗开始时脆弱自身 3 回合。"
  },
  State_2914_Desc = {
    Text = "生命低于 50% 时，意图变为召唤一个等量生命的 【融蚀三角中】。"
  },
  State_2914_Name = {Text = "裂变"},
  State_2914_WeaponDesc = {
    Text = "生命低于 50% 时，意图变为召唤一个等量生命的 【融蚀三角中】。"
  },
  State_2915_Desc = {
    Text = "使「绵绵恨怨」的伤害次数 +[Layer] 次。"
  },
  State_2915_Name = {Text = "恨意"},
  State_2915_WeaponDesc = {
    Text = "使「绵绵恨怨」的伤害次数 +[Layer] 次。"
  },
  State_2917_Desc = {
    Text = "回合结束时，每有 1 张剩余手牌，下回合开始时获得 1 点算力。"
  },
  State_2917_Name = {
    Text = "状态@幻梦银钥：演算"
  },
  State_2918_Desc = {
    Text = "受到的伤害降低 99%。受到主动伤害后移除 1 层，回合开始时恢复至 3 层。"
  },
  State_2918_Name = {
    Text = "「不灭残躯」"
  },
  State_2918_WeaponDesc = {
    Text = "受到的伤害降低 99%。受到主动伤害后移除 1 层，回合开始时恢复至 3 层。"
  },
  State_2919_Desc = {
    Text = "状态@翠火翡翠映像提前"
  },
  State_2919_Name = {
    Text = "状态@翠火翡翠映像提前"
  },
  State_2919_WeaponDesc = {
    Text = "状态@翠火翡翠映像提前"
  },
  State_2922_Desc = {
    Text = "每消耗 1 点算力，使对应的唤醒体获得 2 点狂气。"
  },
  State_2923_Desc = {
    Text = "回合结束时，力量提高 [Layer] 。"
  },
  State_2923_Name = {
    Text = "神降仪式"
  },
  State_2923_WeaponDesc = {
    Text = "每个回合结束时获得[Layer]点力量。"
  },
  State_2925_Desc = {
    Text = "翠火每次造成伤害，层数+1"
  },
  State_2925_Name = {
    Text = "翡翠映像计数"
  },
  State_2925_WeaponDesc = {
    Text = "翠火每次造成伤害，层数+1"
  },
  State_2927_Name = {
    Text = "状态@诅咒谵妄变化"
  },
  State_2929_Desc = {
    Text = "队伍唯一：装备者每造成 1 次伤害，有 <WeaponEffect_Num:[StateArg3]%> 几率使装备者获得 2% 临时暴击伤害。装备者释放狂气爆发后对随机敌人造成 3 次等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的主动伤害。若当前界域为「血肉」，装备者每吞噬一个胚胎，就使胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> 。"
  },
  State_2929_WeaponDesc = {
    Text = "装备者每造成 1 次伤害，有 <WeaponEffect_Num:[StateArg3]%> 几率使装备者获得 2% 临时暴击伤害。装备者释放狂气爆发后对随机敌人造成 3 次 [DescArg1] 点主动伤害。若当前界域为「血肉」，装备者每吞噬一个胚胎，就使胚胎融合 +<WeaponEffect_Num:[Blood:StateArg2]> 。"
  },
  State_2930_Name = {
    Text = "状态@乔治@死亡时获得力量"
  },
  State_2931_Desc = {
    Text = "每进行 1 次吞噬，偷取所有敌人 4 临时力量。"
  },
  State_2931_Name = {
    Text = "异化蚕丝玛瑙"
  },
  State_2933_Name = {
    Text = "饰品扭曲双子白"
  },
  State_2933_WeaponDesc = {
    Text = "偶数回合开始后，将一张附加虚无和消耗的装备者的「防御」加入手牌。"
  },
  State_2934_Desc = {
    Text = "承受的主动和触腕伤害提高 [DescArg1] %。"
  },
  State_2934_Name = {
    Text = "<VulnerabilityColour: 易伤>"
  },
  State_2934_WeaponDesc = {
    Text = "承受的所有伤害提高 50 %。"
  },
  State_2937_Desc = {
    Text = "每第 3 次获得护盾时，同时获得等量的反击。"
  },
  State_2938_Desc = {
    Text = "回合开始时抽 1 张牌，回合结束时可以选择保留 1 张手牌。"
  },
  State_2939_Name = {
    Text = "免疫脆弱"
  },
  State_2940_Desc = {
    Text = "再生力效果提高。"
  },
  State_2940_Name = {
    Text = "承受异端之血渐强"
  },
  State_2941_Desc = {
    Text = "打出后对所有敌人施加 [StateArg1] 层中毒，使所有敌人触发 [StateArg2]% 中毒。"
  },
  State_2941_Name = {
    Text = "<Rune_10:毒素>"
  },
  State_2942_Desc = {
    Text = "回合结束时为其他友方恢复  [Layer] % 生命并清除持续伤害。"
  },
  State_2942_Name = {
    Text = "战场救护"
  },
  State_2946_Desc = {
    Text = "疯狂连击获得极高额的护盾。"
  },
  State_2946_Name = {
    Text = "「不动要塞」"
  },
  State_2946_WeaponDesc = {
    Text = "疯狂连击获得极高额的护盾。"
  },
  State_2947_Name = {Text = "溶解2"},
  State_2948_Desc = {
    Text = "打出前改变卡牌算力"
  },
  State_2948_Name = {
    Text = "打出前改变卡牌算力"
  },
  State_2948_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_2949_Name = {
    Text = "命轮战斗放弃刻印"
  },
  State_2951_Desc = {
    Text = "造物长眠安乐椅"
  },
  State_2951_Name = {
    Text = "缄默手套"
  },
  State_2952_Desc = {
    Text = "回合结束后，回复 [Layer] 点生命。每失去 5 点生命时移除 1 层。"
  },
  State_2952_Name = {Text = "再生力"},
  State_2954_Name = {
    Text = "状态@2-8怪物24@救救我"
  },
  State_2955_Desc = {
    Text = "所有敌人失去生命。永续，销毁。"
  },
  State_2955_Name = {
    Text = "<CardKeyWord:虚无终结>"
  },
  State_2955_WeaponDesc = {
    Text = "所有敌人失去生命。永续，销毁。"
  },
  State_2956_Desc = {
    Text = "每受到一次伤害，所有唤醒体获得 [StateArg1] 点狂气。"
  },
  State_2956_Name = {
    Text = "幻想光束"
  },
  State_2956_WeaponDesc = {
    Text = "每受到一次伤害，所有唤醒体获得 [StateArg1] 点狂气。"
  },
  State_2957_Desc = {
    Text = "死亡后，原地召唤一个自身生命值 1/3 的【融蚀三角中】"
  },
  State_2957_Name = {Text = "融蚀"},
  State_2957_WeaponDesc = {
    Text = "死亡后，原地召唤一个自身生命值 1/3 的【融蚀三角中】"
  },
  State_2960_Desc = {
    Text = "偶数回合，当你的算力为 0 时，获得 2 算力。"
  },
  State_2960_Name = {
    Text = "异化老旧拼图"
  },
  State_2960_WeaponDesc = {
    Text = "偶数回合，当你的算力为 0 时，获得 2 算力。"
  },
  State_2961_Desc = {
    Text = "队伍唯一：装备者造成的<IntoxicationIconKeywords:中毒>提高 <WeaponEffect_Num:[StateArg1]%>，装备者释放狂气爆发前，先对所有敌人施加等同于装备者攻击力 <WeaponEffect_Num:[StateArg2]%> 的中毒。使用钥令后，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_2961_WeaponDesc = {
    Text = "装备者造成的<IntoxicationIconKeywords:中毒>提高 <WeaponEffect_Num:[StateArg1]%>，装备者释放狂气爆发前，先对所有敌人施加 <WeaponEffect_Num:[Poison:DescArg1]> 层中毒。使用钥令后，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_2962_Desc = {
    Text = "打出后虚弱所有敌人 [StateArg1] 回合。"
  },
  State_2962_Name = {
    Text = "<Rune_2:虚弱>"
  },
  State_2965_Name = {
    Text = "状态@凸月侍女启灵7"
  },
  State_2967_Desc = {
    Text = "使用症状卡时，潘迪娅的状态会在“焦躁”和“纵欲”之间变化。焦躁：造成的主动伤害次数+1，力量减少。纵欲：造成的主动伤害次数-1，力量增加。"
  },
  State_2967_Name = {
    Text = "潘迪娅觉醒！"
  },
  State_2967_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_2968_Name = {
    Text = "状态@关卡2_14战斗8气泡4"
  },
  State_2969_Name = {
    Text = "状态@关卡2_14战斗8气泡5"
  },
  State_2970_Desc = {
    Text = "原初子嗣"
  },
  State_2970_Name = {
    Text = "原初子嗣"
  },
  State_2970_WeaponDesc = {
    Text = "原初子嗣"
  },
  State_2971_Desc = {
    Text = "状态@序章扣半血"
  },
  State_2971_Name = {
    Text = "状态@序章扣半血"
  },
  State_2971_WeaponDesc = {
    Text = "状态@序章扣半血"
  },
  State_2972_Name = {
    Text = "状态@关卡2_14战斗8气泡2"
  },
  State_2973_Name = {
    Text = "状态@关卡2_14战斗8气泡3"
  },
  State_2975_Desc = {
    Text = "每场战斗的前 5 次跃迁效果额外生效 1 次。"
  },
  State_2976_Desc = {
    Text = "回合结束时，若你的护盾为 0 或 10 的倍数，获得 [Arg1] 点护盾。若你的生命为 10 的倍数，获得 [Arg2] 点力量。"
  },
  State_2976_Name = {
    Text = "求救信号"
  },
  State_2977_Desc = {
    Text = "奇数回合，当你的手牌为 0 时，抽 2 张牌"
  },
  State_2977_Name = {
    Text = "异化老旧拼图"
  },
  State_2977_WeaponDesc = {
    Text = "奇数回合，当你的手牌为 0 时，抽 2 张牌"
  },
  State_2978_Desc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_2978_Name = {
    Text = "卡牌计数"
  },
  State_2978_WeaponDesc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_2979_Desc = {
    Text = "队伍唯一：装备者造成的中毒和护盾提高 <WeaponEffect_Num:[StateArg3]%>。装备者的「打击」暴击率和暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，并获得最大生命 <WeaponEffect_Num:[StateArg2]%> 的护盾，护盾效果每回合最多生效 1 次。"
  },
  State_2979_Name = {
    Text = "跨越疼痛"
  },
  State_2979_WeaponDesc = {
    Text = "装备者造成的中毒和护盾提高 <WeaponEffect_Num:[StateArg3]%>。装备者的「打击」暴击率和暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，并获得最大生命 [StateArg2]%([DescArg1]) 的护盾，护盾效果每回合最多生效 1 次。"
  },
  State_2983_Desc = {
    Text = "若弃牌阶段仍在手牌中，卡牌将被消耗，本场战斗中不再出现。"
  },
  State_2983_Name = {
    Text = "<NothingnessIconKeywords:虚无>"
  },
  State_2983_WeaponDesc = {
    Text = "若弃牌阶段仍然在手牌中，则不进入弃牌堆，而是在本场战斗中无法再次使用。"
  },
  State_2985_Desc = {
    Text = "直到回合结束，每次造成伤害，回合结束时回复 [Layer] 点生命。"
  },
  State_2985_Name = {
    Text = "珠玉之卵"
  },
  State_2985_WeaponDesc = {
    Text = "直到回合结束，每次造成伤害，回复 [Layer] 点生命。"
  },
  State_2987_Desc = {Text = "事件19_1"},
  State_2987_Name = {Text = "事件19_1"},
  State_2987_WeaponDesc = {Text = "事件19_1"},
  State_2988_Desc = {
    Text = "当吞噬胚胎时，从弃牌堆回到手牌堆，算力变为0."
  },
  State_2988_Name = {Text = "孽生"},
  State_2988_WeaponDesc = {
    Text = "当吞噬胚胎时，从弃牌堆回到手牌堆，算力变为0."
  },
  State_2989_Desc = {
    Text = "出唤醒体的卡牌后，将费用降低 1 的该卡牌的临时复制洗入牌库。"
  },
  State_2990_Desc = {
    Text = "打出后使所有敌人失去 [StateArg1] 点临时力量。"
  },
  State_2990_Name = {
    Text = "<Rune_18_High:高级衰竭>"
  },
  State_2992_Desc = {
    Text = "抽到「空虚」后，本回合内使所有唤醒体获取的狂气降低50%。"
  },
  State_2992_Name = {Text = "空虚"},
  State_2992_WeaponDesc = {
    Text = "抽到「空虚」后，本回合内使所有唤醒体获取的狂气降低50%。"
  },
  State_2993_Name = {
    Text = "造物怪蛇残蜕计数"
  },
  State_2994_Desc = {
    Text = "触腕满溢时触腕伤害提高 [StateArg1]。"
  },
  State_2994_Name = {
    Text = "庇佑之力"
  },
  State_2994_WeaponDesc = {
    Text = "触腕满溢时触腕伤害提高 [StateArg1]。"
  },
  State_2996_Desc = {
    Text = "打出后使1条触腕攻击 [StateArg1] 次。"
  },
  State_2996_Name = {
    Text = "<Rune_11:统御>"
  },
  State_2997_Desc = {
    Text = "每回合造成第 3 次伤害后，获得 [Arg1] 点护盾。每回合造成第 6 次伤害后，获得 [Arg2] 点力量。"
  },
  State_2997_Name = {
    Text = "安全出口"
  },
  State_3001_Desc = {
    Text = "受到攻击时获得的狂气提高 2 点。"
  },
  State_3002_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3002_Name = {
    Text = "状态@试作激光炮幸运"
  },
  State_3003_Desc = {
    Text = "打出后不会进入弃牌堆，而是从牌库中移除。"
  },
  State_3003_Name = {
    Text = "<DepleteIconKeywords:消耗>"
  },
  State_3003_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_3004_Desc = {
    Text = "[Layer] 回合内免疫被施加的中毒状态。"
  },
  State_3004_Name = {
    Text = "免疫中毒"
  },
  State_3008_Desc = {
    Text = "每回合开始时，对手牌中剩余牌添加 1 层迟缓。对于算力消耗超过 5 的牌，将其变成石头。"
  },
  State_3008_Name = {
    Text = "艾继丝觉醒！"
  },
  State_3008_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_3011_Desc = {
    Text = "队伍唯一：装备者的「狂气爆发」暴击率和暴击伤害提高  <WeaponEffect_Num:[StateArg2]%>。装备者释放「狂气爆发」后，获得等同于装备者体质 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>。若本次狂气爆发触发了<CardKeyWord:吞噬>效果，额外获得 1 次<PowerIconKeywords:力量>。"
  },
  State_3011_WeaponDesc = {
    Text = "装备者的「狂气爆发」暴击率和暴击伤害提高  <WeaponEffect_Num:[StateArg2]%>。装备者释放「狂气爆发」后，获得 <WeaponEffect_Num:[Power:DescArg1]> 点力量。若本次狂气爆发触发了<CardKeyWord:吞噬>效果，额外获得 1 次<PowerIconKeywords:力量>。"
  },
  State_3012_Desc = {
    Text = "无用空状态"
  },
  State_3012_Name = {
    Text = "无用空状态"
  },
  State_3012_WeaponDesc = {
    Text = "无用空状态"
  },
  State_3013_Desc = {
    Text = "渴血患者使胚胎融合提高时，获得 [StateArg1]  点力量。"
  },
  State_3013_Name = {Text = "渴血者"},
  State_3014_Desc = {
    Text = "若对方手牌数大于等于 4，受到伤害时，就获得 [StateArg1] 点护盾。"
  },
  State_3014_Name = {Text = "蛇形"},
  State_3015_Desc = {
    Text = "状态@蜡质铠甲我方队伍"
  },
  State_3015_Name = {
    Text = "状态@蜡质铠甲我方队伍"
  },
  State_3015_WeaponDesc = {
    Text = "状态@蜡质铠甲我方队伍"
  },
  State_3016_Desc = {
    Text = "被召唤的怪物生命翻倍。"
  },
  State_3016_Name = {
    Text = "「横流愧意」"
  },
  State_3016_WeaponDesc = {
    Text = "被召唤的怪物生命翻倍。"
  },
  State_3017_Name = {
    Text = "状态@诅咒谵妄"
  },
  State_3018_Desc = {
    Text = "「梭行维度之犬」每失去 1 点生命移除 1 层，层数为 0 时，获得 [StateArg1] 护盾，并重新获得 [StateArg2] 层维度壁障。"
  },
  State_3018_Name = {
    Text = "维度壁障"
  },
  State_3019_Desc = {
    Text = "每消费 10 黑印回复 1% 生命"
  },
  State_3019_Name = {
    Text = "造物逆生根状态"
  },
  State_3019_WeaponDesc = {
    Text = "每消费 10 黑印回复 1% 生命"
  },
  State_3020_Desc = {
    Text = "若上回合受到了伤害，回合开始时获得 1 回合免疫。"
  },
  State_3020_Name = {Text = "适应"},
  State_3020_WeaponDesc = {
    Text = "若上回合受到了伤害，回合开始时获得 1 回合免疫。"
  },
  State_3021_Desc = {
    Text = "回合开始时获得 1 算力。"
  },
  State_3021_Name = {
    Text = "状态@最大算力-2"
  },
  State_3023_Desc = {
    Text = "本回合每次承受主动伤害时，对伤害来源造成 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3023_Name = {
    Text = "临时反击"
  },
  State_3023_WeaponDesc = {
    Text = "每次承受主动伤害时，对攻击者造成 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3024_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3024_Name = {
    Text = "状态@试作小刀死抗"
  },
  State_3025_Desc = {
    Text = "每打出 1 张牌，使本回合内的暴击率提高 10%。"
  },
  State_3026_Desc = {
    Text = "战斗开始后将 [StateArg1] 张临时复制洗入抽牌堆，原始卡牌和镜像卡牌均获得保留。"
  },
  State_3026_Name = {
    Text = "<Rune_8_High:高级镜像>"
  },
  State_3026_WeaponDesc = {
    Text = "战斗开始后将 [StateArg1] 张临时复制洗入抽牌堆。"
  },
  State_3027_Desc = {
    Text = "战斗结束后，额外获得 50 黑印和 1 张症状卡。"
  },
  State_3028_Name = {
    Text = "状态@回合开始后算力加2"
  },
  State_3029_Desc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_3029_Name = {
    Text = "卡牌计数"
  },
  State_3029_WeaponDesc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_3033_Desc = {
    Text = "每打出 10 张牌，就获得 1 层抵挡任意伤害的屏障。若你已拥有屏障，改为回复 [Arg1] 点生命。"
  },
  State_3034_Desc = {
    Text = "队伍唯一：每打出 1 张装备者的卡牌，就获得 <WeaponEffect_Num:[StateArg1]> 银钥能量。该效果单个回合最多生效 3 次。"
  },
  State_3034_WeaponDesc = {
    Text = "每打出 1 张装备者的卡牌，就获得 <WeaponEffect_Num:[StateArg1]> 银钥能量。该效果单个回合最多生效 3 次。"
  },
  State_3035_Desc = {
    Text = "打出后使1条触腕攻击 [StateArg1] 次。"
  },
  State_3035_Name = {
    Text = "<Rune_11_High:高级统御>"
  },
  State_3035_WeaponDesc = {
    Text = "打出后使1条触腕攻击所有敌人 [StateArg1] 次。"
  },
  State_30364_Desc = {
    Text = "此卡牌在手牌中时会使手牌上限 +1。"
  },
  State_30364_Name = {
    Text = "无视手牌上限"
  },
  State_30369_Desc = {
    Text = "本回合中手牌上限 +[Layer]。"
  },
  State_30369_Name = {
    Text = "手牌上限"
  },
  State_3036_Desc = {
    Text = "造成的脆弱和虚弱效果由 33% 变为 50%。"
  },
  State_3036_Name = {
    Text = "「寂灭余波」"
  },
  State_3036_WeaponDesc = {
    Text = "造成的脆弱和虚弱效果由 33% 变为 50%。"
  },
  State_3038_Desc = {
    Text = "队伍唯一：释放钥令后，装备者获得 <WeaponEffect_Num:[StateArg1]> 狂气。"
  },
  State_3038_WeaponDesc = {
    Text = "释放钥令后，装备者获得 <WeaponEffect_Num:[StateArg1]> 狂气。"
  },
  State_3040_Desc = {
    Text = "每回合开始时，对我方队伍施加 [Layer] 层【束缚】。"
  },
  State_3040_Name = {Text = "束缚"},
  State_3040_WeaponDesc = {
    Text = "每回合开始时，对我方队伍施加 [Layer] 层【束缚】。"
  },
  State_3041_Desc = {
    Text = "永久保留在牌库中。"
  },
  State_3041_Name = {
    Text = "<CardKeyWord:症状卡>"
  },
  State_3042_Desc = {
    Text = "每次造成伤害时，本回合内获得 [Arg1] 力量，最多堆叠 3 次。层数满时效果翻倍。"
  },
  State_3043_Desc = {
    Text = "偶数回合受伤降低 50%，伤害提高 33%。"
  },
  State_3043_Name = {Text = "善变"},
  State_3043_WeaponDesc = {
    Text = "偶数回合受伤降低 50%，伤害提高 33%。"
  },
  State_3045_Desc = {
    Text = "释放狂气爆发后，对应唤醒体获得 20 狂气。"
  },
  State_3045_Name = {
    Text = "无名之神的面纱"
  },
  State_3046_Desc = {
    Text = "队伍唯一：每有一个敌人死亡时获得 [StateArg1] 黑印。装备者击杀敌人后，本次关卡中装备者的暴击伤害永久提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 层。装备者每次触发跃迁效果，使装备者本回合造成的最终伤害提高 <WeaponEffect_Num:[StateArg3]%> ，至多叠加 3 层。"
  },
  State_3046_WeaponDesc = {
    Text = "每有一个敌人死亡时获得 [StateArg1] 黑印。装备者击杀敌人后，本次关卡中装备者的暴击伤害永久提高 <WeaponEffect_Num:[StateArg2]%> ，至多叠加 5 层。装备者每次触发跃迁效果，使装备者本回合造成的最终伤害提高 <WeaponEffect_Num:[StateArg3]%> ，至多叠加 3 层。"
  },
  State_3047_Desc = {
    Text = "回合开始时获得 [Arg1] 护盾，每过 1 回合就使这个护盾值提高 [Arg2]。"
  },
  State_3047_Name = {
    Text = "守护之手"
  },
  State_3048_Desc = {
    Text = "萝坦的战意永不停歇。每回合结束时，萝坦解除 3 层虚弱和易伤状态。"
  },
  State_3048_Name = {
    Text = "萝坦觉醒"
  },
  State_3049_Desc = {
    Text = "使乔治的下次攻击伤害次数提高 1 。"
  },
  State_3049_Name = {Text = "怨恨"},
  State_3049_WeaponDesc = {
    Text = "使乔治的下次攻击伤害次数提高 1 。"
  },
  State_3050_Desc = {
    Text = "战斗开始时，将 1 张【惊厥】洗入抽牌堆。"
  },
  State_3050_Name = {Text = "惊惧"},
  State_3050_WeaponDesc = {
    Text = "战斗开始时，将 1 张【惊厥】洗入抽牌堆。"
  },
  State_3051_Desc = {
    Text = "造成未被格挡的伤害时，将一张哭喊洗入抽牌堆。"
  },
  State_3051_Name = {
    Text = "灼燃蜡滴之欲"
  },
  State_3051_WeaponDesc = {
    Text = "造成实际伤害时，将一张哭喊洗入抽牌堆。"
  },
  State_3054_Name = {
    Text = "状态@诅咒休克"
  },
  State_3055_Desc = {
    Text = "战斗开始时，对我方队伍造成 1 层脆弱。"
  },
  State_3055_Name = {Text = "贯通"},
  State_3055_WeaponDesc = {
    Text = "战斗开始时，对我方队伍造成 1 层脆弱。"
  },
  State_3056_Desc = {
    Text = "回合结束时，移除 1 层虚弱和易伤。"
  },
  State_3056_Name = {Text = "威压"},
  State_3058_Desc = {
    Text = "每有 1 条触腕，回合结束时获得 [Arg1] 护盾。"
  },
  State_3058_Name = {
    Text = "无名附肢"
  },
  State_3060_Desc = {
    Text = "下回合开始时获得 [Layer] 点护盾。"
  },
  State_3060_Name = {
    Text = "精神重建"
  },
  State_3060_WeaponDesc = {
    Text = "下回合开始时抽 [Layer] 张牌。"
  },
  State_3063_Desc = {
    Text = "每次造成实际伤害时，附加[Layer]中毒。"
  },
  State_3063_Name = {Text = "毒素"},
  State_3064_Desc = {
    Text = "打出卡牌前就受到等量层数的伤害。回合结束后解除。"
  },
  State_3064_Name = {Text = "束缚"},
  State_3064_WeaponDesc = {
    Text = "打出卡牌前就受到等量层数的伤害。回合结束后解除。"
  },
  State_3065_Name = {
    Text = "状态@造物过往的贡物2"
  },
  State_3068_Desc = {
    Text = "回合结束后，受到 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3068_Name = {
    Text = "<IntoxicationColour:中毒>"
  },
  State_3068_WeaponDesc = {
    Text = "回合结束后，受到 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3069_Name = {
    Text = "饰品机械降神"
  },
  State_3069_WeaponDesc = {
    Text = "每场战斗的首个回合获得 1 点额外算力。"
  },
  State_3070_Desc = {
    Text = "队伍唯一：装备者的「打击」使目标敌人失去等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>。该效果一个回合内最多触发3次。"
  },
  State_3070_WeaponDesc = {
    Text = "装备者的「打击」使目标敌人临时降低 <WeaponEffect_Num:[Power:DescArg1]> 点<PowerIconKeywords:力量>。该效果一个回合内最多触发3次。"
  },
  State_3071_Desc = {
    Text = "队伍唯一：打出装备者的「防御」后，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>。"
  },
  State_3071_WeaponDesc = {
    Text = "打出装备者的「防御」后，获得  <WeaponEffect_Num:[Power:DescArg1]> 点临时<PowerIconKeywords:力量>。"
  },
  State_3072_Desc = {
    Text = "队伍唯一：装备者击杀敌方后，获得 <WeaponEffect_Num:[StateArg1]> 狂气，获得 1% 暴击伤害，整场探索有效。"
  },
  State_3072_WeaponDesc = {
    Text = "装备者击杀敌方后，获得 <WeaponEffect_Num:[StateArg1]> 狂气，获得 1% 暴击伤害，整场探索有效。"
  },
  State_3073_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，全体友方本回合暴击率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3073_WeaponDesc = {
    Text = "装备者释放狂气爆发后，全体友方本回合暴击率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3074_Desc = {
    Text = "队伍唯一：打出一张症状卡后，装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气。该效果一个回合内最多触发 2 次。装备者打出 1 张指令卡后，获得 1 点狂气。"
  },
  State_3074_WeaponDesc = {
    Text = "打出一张症状卡后，装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气。该效果一个回合内最多触发 2 次。装备者打出 1 张指令卡后，获得 1 点狂气。"
  },
  State_3075_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，获得等同于装备者防御力 <WeaponEffect_Num:[StateArg1]%> 的护盾。"
  },
  State_3075_Name = {
    Text = "心之壁垒"
  },
  State_3075_WeaponDesc = {
    Text = "装备者释放狂气爆发后，获得 <WeaponEffect_Num:[Block:DescArg1]> 点护盾。"
  },
  State_3076_Desc = {
    Text = "队伍唯一：装备者造成主动伤害后使其暴击率提高 <WeaponEffect_Num:[StateArg1]%>，造成暴击后清空该效果获得的暴击率。"
  },
  State_3076_WeaponDesc = {
    Text = "装备者造成主动伤害后使其暴击率提高 <WeaponEffect_Num:[StateArg1]%>，造成暴击后清空该效果获得的暴击率。"
  },
  State_3078_Desc = {
    Text = "本回合内造成伤害必定暴击。"
  },
  State_3078_Name = {
    Text = "临时必爆"
  },
  State_3078_WeaponDesc = {
    Text = "本回合内暴击率提升100%"
  },
  State_3082_Desc = {
    Text = "释放狂气爆发后，将一张对应唤醒体的随机卡牌置入手中，该卡牌获得消耗与虚无。"
  },
  State_3082_Name = {
    Text = "医生手提箱"
  },
  State_3084_Desc = {
    Text = "打出后将卡牌的 [StateArg1] 张复制加入临时<DimensionalSpaceIconKeywords:超维空间>。"
  },
  State_3084_Name = {
    Text = "<Rune_13_High:高级折跃>"
  },
  State_3084_WeaponDesc = {
    Text = "打出后消耗，但是会将 [StateArg1] 张临时原始复制进入超维空间。"
  },
  State_3087_Desc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_3087_Name = {
    Text = "打击牌伤害临时提高"
  },
  State_3087_WeaponDesc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_3088_Desc = {
    Text = "受到的主动伤害提高 [Layer] 。每次受到伤害融蚀伤口都会扩大，回合开始时恢复。"
  },
  State_3088_Name = {
    Text = "深度融蚀"
  },
  State_3088_WeaponDesc = {
    Text = "受到的主动伤害提高[Layer]。每次受到伤害融蚀伤口都会扩大，回合开始时恢复。"
  },
  State_3092_Name = {
    Text = "若是首领战，所有唤醒体获得 30 狂气并解除封印状态"
  },
  State_3093_Name = {
    Text = "状态@奇术师模仿秀计数"
  },
  State_3094_Desc = {
    Text = "抽到时使自身脆弱 1 回合。使用后易伤所有敌人 1 回合。无法出售。"
  },
  State_3094_Name = {
    Text = "状态诅咒崩溃"
  },
  State_3094_WeaponDesc = {
    Text = "抽到时使自身脆弱 1 回合。使用后易伤所有敌人 1 回合。无法出售。"
  },
  State_3095_Desc = {
    Text = "本次关卡内造成的伤害提高 [Layer] 点。"
  },
  State_3095_Name = {
    Text = "永久力量"
  },
  State_3095_WeaponDesc = {
    Text = "本次关卡内造成的伤害提高 [Layer] 点。"
  },
  State_3096_Desc = {
    Text = "说服萝坦的路还有很长一段要走。"
  },
  State_3096_Name = {
    Text = "萝坦觉醒"
  },
  State_3098_Desc = {
    Text = "拾取后选择一张卡牌，使其算力消耗永久变为 1。"
  },
  State_3099_Desc = {
    Text = "释放狂气爆发后，本回合内获得 [Arg1] 力量。"
  },
  State_3100_Desc = {
    Text = "每回合开始时死亡抵抗提高 10%。死亡抵抗在 100% 以上时，额外获得 30 点界域精通。"
  },
  State_3104_Desc = {
    Text = "本回合内，每受到 1 次主动伤害，就使「甜蜜恶鬼」伤害次数+1。"
  },
  State_3104_Name = {
    Text = "痛苦分享"
  },
  State_3104_WeaponDesc = {
    Text = "本回合内，每受到 1 次主动伤害，就使「甜蜜恶鬼」伤害次数+1。"
  },
  State_3106_Desc = {
    Text = "当生命低于50%([StateArg1]) 时，将会分裂为2只等量生命的「实验习作」。"
  },
  State_3106_Name = {Text = "分裂"},
  State_3106_WeaponDesc = {
    Text = "当生命低于 50%([StateArg1]) 时，将会分裂为3只等量生命的「II型融蚀体蜡像」。"
  },
  State_3108_Name = {
    Text = "饰品环形诗篇"
  },
  State_3108_WeaponDesc = {
    Text = "偶数回合开始后，获得 1 点算力。"
  },
  State_3109_Name = {
    Text = "状态@第四章共鸣@算力减1"
  },
  State_3109_WeaponDesc = {
    Text = "“天真的回礼”算力消耗减1"
  },
  State_3110_Name = {
    Text = "状态@第四章共鸣@算力减1"
  },
  State_3110_WeaponDesc = {
    Text = "“天真的回礼”算力消耗减1"
  },
  State_3111_Desc = {
    Text = "下回合开始时，将剩余的护盾转化为2倍生命"
  },
  State_3111_Name = {
    Text = "不灭之花"
  },
  State_3112_Desc = {
    Text = "队伍唯一：装备者造成的中毒提高 <WeaponEffect_Num:[StateArg3]%>。装备者释放狂气爆发后，回复等同于装备者体质 <WeaponEffect_Num:[StateArg1]%> 的生命，每剩余 1 点算力就额外回复装备者体质的 <WeaponEffect_Num:[StateArg2]%> 的生命。"
  },
  State_3112_Name = {
    Text = "无声欢宴"
  },
  State_3112_WeaponDesc = {
    Text = "装备者造成的中毒提高 <WeaponEffect_Num:[StateArg3]%>。装备者释放狂气爆发后，回复 <WeaponEffect_Num:[Heal:DescArg1]> 点生命，每剩余 1 点算力额外回复 <WeaponEffect_Num:[Heal:DescArg2]> 点生命。"
  },
  State_3113_Desc = {
    Text = "状态@序章狂气0_1_4"
  },
  State_3113_Name = {
    Text = "状态@序章狂气0_1_4"
  },
  State_3113_WeaponDesc = {
    Text = "状态@序章狂气0_1_4"
  },
  State_3114_Desc = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3114_Name = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3114_WeaponDesc = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3115_Desc = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3115_Name = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3115_WeaponDesc = {
    Text = "状态@序章狂气0_1_2"
  },
  State_3116_Name = {
    Text = "状态@序章狂气0_1_1"
  },
  State_3117_Desc = {
    Text = "队伍唯一：装备者「打击」和「狂气爆发」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者打出「打击」后，装备者获得 5% 临时暴击率，每回合最多 3 次，达到 3 次时获得 15% 临时暴击伤害。"
  },
  State_3117_WeaponDesc = {
    Text = "装备者「打击」和「狂气爆发」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者打出「打击」后，装备者获得 5% 临时暴击率，每回合最多 3 次，达到 3 次时获得 15% 临时暴击伤害。"
  },
  State_3118_Desc = {
    Text = "回合开始时回复 [Layer]% 已损失生命。"
  },
  State_3118_Name = {
    Text = "引舵之帆的庇护"
  },
  State_3120_Desc = {
    Text = "[防御]获得 [Arg1] 层反击。"
  },
  State_3121_Desc = {
    Text = "若敌人的意图不为攻击，对其造成主动或触腕伤害后，附加等同于一半伤害层数的出血。"
  },
  State_3123_Desc = {
    Text = "队伍唯一：装备者造成的<RetaliateIconKeywords: 反击>提高 <WeaponEffect_Num:[StateArg3]%>。每受到 1 次攻击，就获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>。装备者使用狂气爆发后，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg2]%> 的<RetaliateIconKeywords: 反击>。"
  },
  State_3123_WeaponDesc = {
    Text = "装备者造成的反击提高 <WeaponEffect_Num:[StateArg3]%>。每受到 1 次攻击，就获得 <WeaponEffect_Num:[Power:DescArg1]> 点临时<PowerIconKeywords:力量>。装备者使用狂气爆发后，获得 <WeaponEffect_Num:[Counterattack:DescArg2]> 点反击。"
  },
  State_3124_Desc = {
    Text = "幸运侦探获得的黑印翻倍。"
  },
  State_3124_Name = {
    Text = "绝佳运气"
  },
  State_3124_WeaponDesc = {
    Text = "幸运侦探获得的黑印翻倍。"
  },
  State_3127_Name = {
    Text = "状态@关卡2_10战斗3气泡1"
  },
  State_3128_Desc = {
    Text = "所有唤醒体造成的护盾和生命回复提高 [StateArg1]%。"
  },
  State_3128_Name = {Text = "摇篮"},
  State_3129_Desc = {
    Text = "下回合开始前每次承受主动伤害额外触发 [Layer] 次反击和触腕反击，造成 50% 伤害。"
  },
  State_3129_Name = {
    Text = "逆鳞之护"
  },
  State_3130_Desc = {
    Text = "本回合内造成的伤害提高 [Layer] 点。"
  },
  State_3130_Name = {
    Text = "临时力量"
  },
  State_3130_WeaponDesc = {
    Text = "本回合内造成的伤害提高 [Layer] 点。"
  },
  State_3135_Desc = {
    Text = "每拥有 1 层，造成的主动伤害次数+1。"
  },
  State_3135_Name = {
    Text = "<MadnessIconKeywords:疯狂>"
  },
  State_3136_Name = {Text = "狂气"},
  State_3137_Desc = {
    Text = "战斗开始时，获得 1 条触腕，触腕伤害永久提高 [Arg1]。"
  },
  State_3138_Name = {
    Text = "饰品二律背反"
  },
  State_3138_WeaponDesc = {
    Text = "装备者使用狂气爆发后，己方基于装备者防御力的 100% 获得<RetaliateIconKeywords:反击>。并使自身当前<RetaliateIconKeywords:反击>提高 10%。"
  },
  State_3139_Desc = {
    Text = "进入超维回合后解除自身虚弱和脆弱状态，并虚弱和易伤所有敌人 2 回合。"
  },
  State_3140_Desc = {
    Text = "战斗开始时，将「幻觉」置入超维空间，直到你的超维空间达到 4 张。"
  },
  State_3143_Desc = {
    Text = "造成实际伤害时，使我方队伍失去 [Layer] 临时力量。"
  },
  State_3143_Name = {Text = "麻痹"},
  State_3144_Name = {
    Text = "我方队伍\"中毒\"与\"出血\"层数减半"
  },
  State_3145_Desc = {
    Text = "在 [Layer] 回合内，不可使用卡牌。"
  },
  State_3145_Name = {
    Text = "无法打出卡牌"
  },
  State_3146_Desc = {
    Text = "海之使徒打出 1 张牌时，生成 [StateArg1] 条临时触腕，该触腕可以无视触腕上限。"
  },
  State_3146_Name = {
    Text = "代行权能"
  },
  State_3146_WeaponDesc = {
    Text = "海之使徒打出 1 张牌时，生成 [StateArg1] 条临时触腕，该触腕可以无视触腕上限。"
  },
  State_3149_Desc = {
    Text = "下回合开始时，承受的主动和触腕伤害提高 50 %。"
  },
  State_3149_Name = {
    Text = "延迟易伤"
  },
  State_3149_WeaponDesc = {
    Text = "承受的所有伤害提高 50 %。"
  },
  State_3150_Desc = {
    Text = "一回合内受到 3 次攻击后，获得 1 层临时<MadnessColour:疯狂>。"
  },
  State_3150_Name = {
    Text = "「甜蜜痛楚」"
  },
  State_3151_Desc = {
    Text = "拾取时永久获得 [Arg1] 点力量。"
  },
  State_3152_Name = {
    Text = "状态@饰品再衍化"
  },
  State_3152_WeaponDesc = {
    Text = "装备者回合结束后获得 3 点狂气。若装备者狂气回充大于 10 ，额外获得 2 点狂气。"
  },
  State_3153_Name = {
    Text = "状态@诅咒谵妄还原"
  },
  State_3154_Name = {Text = "暴击率"},
  State_3155_Desc = {
    Text = "每回合回复 10% 已损失生命。"
  },
  State_3155_Name = {Text = "医济"},
  State_3155_WeaponDesc = {
    Text = "每回合回复 10% 已损失生命。"
  },
  State_3156_Desc = {
    Text = "每回合受到的第一段伤害变为5倍。"
  },
  State_3156_Name = {
    Text = "惊慌失措"
  },
  State_3160_Desc = {
    Text = "回合开始时，将一张本回合内获得 [Arg1] 戒备的「阳伞」加入手中，打出 6 张卡牌后，使手牌中所有的「阳伞」戒备提高 [Arg2]。"
  },
  State_3161_Desc = {
    Text = "对手抽牌数量减少 [Layer] ，但所有牌获得保留。"
  },
  State_3161_WeaponDesc = {
    Text = "我方队伍抽牌数量减少 [Layer] ，所有牌获得保留"
  },
  State_3163_Desc = {
    Text = "触发死亡抵抗后，回复 [Layer] 点生命。"
  },
  State_3163_Name = {
    Text = "星之摇篮"
  },
  State_3163_WeaponDesc = {
    Text = "触发死亡抵抗后，回复 [Layer] 点生命。"
  },
  State_3164_Desc = {Text = "——"},
  State_3164_Name = {
    Text = "绵绵恨怨计数"
  },
  State_3164_WeaponDesc = {Text = "——"},
  State_3165_Name = {
    Text = "窜行者启灵3"
  },
  State_3166_Name = {
    Text = "本场战斗已触发"
  },
  State_3168_Desc = {
    Text = "回合开始时给全体怪物加攻击次数计数"
  },
  State_3168_Name = {
    Text = "状态@复仇巨刃斩首重创"
  },
  State_3168_WeaponDesc = {
    Text = "回合开始时给全体怪物加攻击次数计数"
  },
  State_3170_Desc = {
    Text = "施加冲动的代价"
  },
  State_3170_Name = {
    Text = "施加冲动的代价"
  },
  State_3170_WeaponDesc = {
    Text = "施加冲动的代价"
  },
  State_3171_Name = {
    Text = "状态@关卡2_1战斗3气泡1"
  },
  State_3172_Desc = {
    Text = "每次造成伤害时，获得 [StateArg1] 点临时力量，最多堆叠 [StateArg2] 次。层数满时效果翻倍。"
  },
  State_3172_Name = {
    Text = "造物染血鹅卵石"
  },
  State_3174_Desc = {
    Text = "生命上限降低 30%。"
  },
  State_3174_Name = {
    Text = "造物六分仪2"
  },
  State_3174_WeaponDesc = {
    Text = "生命上限降低 30%。"
  },
  State_3175_Desc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。"
  },
  State_3175_Name = {
    Text = "造物六分仪1"
  },
  State_3175_WeaponDesc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。"
  },
  State_3176_Desc = {
    Text = "序章重置牌库0_1_1_1"
  },
  State_3176_Name = {
    Text = "序章重置牌库0_1_1_1_2"
  },
  State_3176_WeaponDesc = {
    Text = "序章重置牌库0_1_1_1"
  },
  State_3177_Desc = {
    Text = "「警觉」达到 3 层时进行后退，并召唤一个「替身蜡像」。回合开始时清空层数。"
  },
  State_3177_Name = {Text = "警觉"},
  State_3177_WeaponDesc = {
    Text = "「警觉」达到 3 层时进行后退，并召唤一个「替身蜡像」。回合开始时清空层数。"
  },
  State_3178_Desc = {
    Text = "使卡牌的算力消耗提高。"
  },
  State_3178_Name = {
    Text = "<SlowIconKeywords: 迟缓>"
  },
  State_3178_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_3179_Desc = {
    Text = "战斗开始时获得 20 护盾。每回合开始时若有护盾，当回合护盾和治疗强效提高 50%。"
  },
  State_3179_Name = {
    Text = "异化花园守护者"
  },
  State_3179_WeaponDesc = {
    Text = "战斗开始时获得 20 护盾。每回合开始时若有护盾，当回合护盾和治疗强效提高 50%。"
  },
  State_3180_Desc = {
    Text = "暴击率提高 25%。造成生命回复后，有几率额外造成 1 次生命回复，概率等于造成回复者的暴击率。"
  },
  State_3180_Name = {
    Text = "状态@幻梦银钥：暴击治疗"
  },
  State_3181_Name = {Text = "暴击率"},
  State_3183_Desc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_3183_Name = {
    Text = "临时暴击伤害"
  },
  State_3185_Desc = {
    Text = "移动时增加额外压力"
  },
  State_3185_Name = {
    Text = "造物无底袋2"
  },
  State_3185_WeaponDesc = {
    Text = "移动时增加额外压力"
  },
  State_3189_Name = {
    Text = "怪物延迟力量"
  },
  State_3190_Name = {
    Text = "造物钥匙"
  },
  State_3193_Desc = {
    Text = "下回合开始后获得 [Layer] 护盾。"
  },
  State_3193_Name = {
    Text = "失落的艺术"
  },
  State_3193_WeaponDesc = {
    Text = "下回合开始后获得 [Layer] 护盾。"
  },
  State_3196_Desc = {
    Text = "打出后获得 [StateArg1] 点算力。"
  },
  State_3196_Name = {
    Text = "<Rune_4_High:高级筹算>"
  },
  State_3196_WeaponDesc = {
    Text = "打出后获得 [StateArg1] 点算力。"
  },
  State_3197_Desc = {
    Text = "「打击」回复 [Arg1] 点生命，并减半自身出血和中毒层数。"
  },
  State_3197_Name = {Text = "止血钳"},
  State_3200_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害和护盾提高 <WeaponEffect_Num:[StateArg1]%>。探索开始时将一张装备者的「打击」和「防御」加入牌库。装备者打出「防御」后，使装备者下一张「打击」暴击率与暴击伤害提高 15%，装备者打出「打击」后，使装备者下一张「防御」护盾提高 15%，可堆叠 3 次。"
  },
  State_3200_WeaponDesc = {
    Text = "装备者造成的基础伤害和护盾提高 <WeaponEffect_Num:[StateArg1]%>。探索开始时将一张装备者的「打击」和「防御」加入牌库。装备者打出「防御」后，使装备者下一张「打击」暴击率与暴击伤害提高 15%，装备者打出「打击」后，使装备者下一张「防御」护盾提高 15%，可堆叠 3 次。"
  },
  State_3201_Desc = {Text = "——"},
  State_3201_Name = {
    Text = "绵绵恨怨"
  },
  State_3201_WeaponDesc = {Text = "——"},
  State_3203_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg3]%>。装备者的「防御」对生命最高敌人造成装备者防御力  <WeaponEffect_Num:[StateArg1]%> 的<IntoxicationIconKeywords:中毒>。若当前界域为「血肉」，施加<IntoxicationIconKeywords:中毒>时<EmbryoFusionIconKeywords:胚胎融合> + <WeaponEffect_Num:[Blood:StateArg2]>，该效果每回合最多触发 3 次。"
  },
  State_3203_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg3]%>。装备者的「防御」对生命最高敌人造成 <WeaponEffect_Num:[Poison:DescArg1]> 层<IntoxicationIconKeywords:中毒>。若当前界域为「血肉」，施加<IntoxicationIconKeywords:中毒>时<EmbryoFusionIconKeywords:胚胎融合> +<WeaponEffect_Num:[Blood:StateArg2]>，该效果每回合最多触发 3 次。"
  },
  State_3204_Desc = {
    Text = "造成实际伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_3204_Name = {Text = "裂伤"},
  State_3204_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3206_Desc = {
    Text = "每打出 1 张牌，使本回合内的暴击率提高 [StateArg1]%，最多堆叠 [StateArg2] 次。层数满时效果翻倍。"
  },
  State_3206_Name = {
    Text = "造物孟菲斯仪式镜"
  },
  State_3206_WeaponDesc = {
    Text = "每打出 1 张牌，使本回合内的暴击率提高 [StateArg1]%，最多堆叠 [StateArg2] 次。层数满时效果翻倍。"
  },
  State_3207_Desc = {
    Text = "每失去 1 点生命移除 1 层，层数为 0 时获得 [DescArg1] 的护盾。"
  },
  State_3207_Name = {
    Text = "维度壁障"
  },
  State_3208_Desc = {
    Text = "石化中，无法行动，回合结束后移除。"
  },
  State_3208_Name = {
    Text = "<PetrifactionColour: 石化>"
  },
  State_3209_Name = {
    Text = "饰品生机榨取"
  },
  State_3209_WeaponDesc = {
    Text = "战斗开始后，若装备者职业为血肉，攻击力提高 25%。"
  },
  State_3210_Name = {
    Text = "状态@复仇巨刃启灵1"
  },
  State_3211_Desc = {
    Text = "手牌上限提高 2，回合结束时不再弃掉手牌。每当失去生命时，随机弃掉 2 张手牌。"
  },
  State_3212_Desc = {
    Text = "造成的主动和触腕伤害降低 25 %，回合结束时移除 1 层。"
  },
  State_3212_Name = {
    Text = "<WeaknessIconKeywords: 虚弱>"
  },
  State_3212_WeaponDesc = {
    Text = "造成的所有伤害降低 25 %。"
  },
  State_3213_Desc = {
    Text = "护盾和治疗的效果提高[Layer] %"
  },
  State_3213_Name = {
    Text = "临时护盾和治疗强效"
  },
  State_3213_WeaponDesc = {
    Text = "护盾和治疗的效果提高[Layer] %"
  },
  State_3215_Name = {
    Text = "时灵摆「隐秘」"
  },
  State_3216_Desc = {
    Text = "战斗结束后，额外获得 100 黑印，但得到一张症状卡。"
  },
  State_3216_Name = {
    Text = "造物好运戒指"
  },
  State_3216_WeaponDesc = {
    Text = "战斗结束后，额外获得 100 黑印，但得到一张症状卡。"
  },
  State_3220_Desc = {
    Text = "释放狂气爆发后，抽 1 张牌。若生命低于 25%，额外抽 1 张牌。"
  },
  State_3223_Desc = {
    Text = "造成的虛弱效果提高 10%。每 3 回合对所有敌人添加 1 层虚弱。"
  },
  State_3224_Name = {
    Text = "造物阿尔卡纳记录算力"
  },
  State_3225_Name = {
    Text = "断颈一击"
  },
  State_3226_Desc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_3226_Name = {Text = "消耗"},
  State_3226_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_3227_Desc = {
    Text = "所有造物价格降低 50%。"
  },
  State_3227_Name = {
    Text = "造物贸易勋章"
  },
  State_3227_WeaponDesc = {
    Text = "所有造物价格降低 50%。"
  },
  State_3228_Desc = {
    Text = "回合开始时，狂气最低唤醒体获得25狂气"
  },
  State_3228_Name = {
    Text = "造物阿尔卡纳狂气"
  },
  State_3228_WeaponDesc = {
    Text = "回合开始时，狂气最低唤醒体获得25狂气"
  },
  State_3229_Desc = {
    Text = "序章重置牌库0_1_1_1"
  },
  State_3229_Name = {
    Text = "序章重置牌库0_1_1_1"
  },
  State_3229_WeaponDesc = {
    Text = "序章重置牌库0_1_1_1"
  },
  State_3230_Name = {
    Text = "状态@通用延迟算力"
  },
  State_3232_Desc = {
    Text = "状态@怪物超维卡槽触发器"
  },
  State_3232_Name = {
    Text = "状态@怪物超维卡槽触发器"
  },
  State_3232_WeaponDesc = {
    Text = "状态@怪物超维卡槽触发器"
  },
  State_3234_Desc = {
    Text = "战斗开始时，获得 3 力量，但每次受到的伤害提高 5。"
  },
  State_3234_Name = {Text = "背水"},
  State_3235_Desc = {
    Text = "战斗开始时，获得 [Layer] 力量，但每次受到的伤害提高 5。"
  },
  State_3235_Name = {Text = "背水"},
  State_3236_Desc = {
    Text = "打出后其他唤醒体获得 [StateArg1] 狂气。"
  },
  State_3236_Name = {
    Text = "<Rune_16_High:高级催化>"
  },
  State_3237_Desc = {
    Text = "每 3 个回合获得 3 条触腕，该触腕无视触腕上限，回合结束时移除。"
  },
  State_3238_Desc = {
    Text = "战斗开始时给予怪物受到的所有伤害提高的状态"
  },
  State_3238_Name = {
    Text = "战斗开始时给予怪物受到的所有伤害提高的状态"
  },
  State_3238_WeaponDesc = {
    Text = "战斗开始时给予怪物受到的所有伤害提高的状态"
  },
  State_3239_Desc = {
    Text = "提高[Layer]点攻击力。"
  },
  State_3239_Name = {
    Text = "通用攻击力提高"
  },
  State_3239_WeaponDesc = {
    Text = "提高[Layer]点攻击力。"
  },
  State_3242_Name = {
    Text = "将 2 张<DerivativeCardKeywords_4:「灵感」>置入抽牌堆"
  },
  State_3243_Desc = {
    Text = "卡牌算力增加"
  },
  State_3243_Name = {
    Text = "卡牌算力增加"
  },
  State_3243_WeaponDesc = {
    Text = "卡牌算力增加"
  },
  State_3244_Desc = {
    Text = "被召唤的怪物生命翻倍。"
  },
  State_3244_Name = {
    Text = "「横流愧意」"
  },
  State_3244_WeaponDesc = {
    Text = "被召唤的怪物生命翻倍。"
  },
  State_3245_Desc = {
    Text = "战斗开始时，我方队伍暴击率下降 30%，暴击伤害提高 30%。"
  },
  State_3245_Name = {Text = "抑制"},
  State_3245_WeaponDesc = {
    Text = "战斗开始时，我方队伍暴击率下降 30%，暴击伤害提高 30%。"
  },
  State_3246_Desc = {
    Text = "战斗开始时普通敌人的生命增加 30 %，战斗胜利后额外提供25黑印。"
  },
  State_3246_Name = {
    Text = "造物残破战旗"
  },
  State_3246_WeaponDesc = {
    Text = "战斗开始时普通敌人的生命增加 30 %，战斗胜利后额外提供25黑印。"
  },
  State_3247_Desc = {
    Text = "【狂气爆发】使所有手牌算力消耗 -1。"
  },
  State_3247_Name = {
    Text = "异化文明之光"
  },
  State_3247_WeaponDesc = {
    Text = "【狂气爆发】使所有手牌算力消耗 -1。"
  },
  State_3249_Desc = {
    Text = "其他友方获得 1 层<MadnessColour:疯狂>，自身死亡后解除。"
  },
  State_3249_Name = {Text = "躁动"},
  State_3249_WeaponDesc = {
    Text = "其他友方获得 1 层疯狂，自身死亡后解除。"
  },
  State_3250_Desc = {
    Text = "战斗结束后仍然保留在牌库中，但打出或被消耗后将永久移除。"
  },
  State_3250_Name = {
    Text = "<DestructionKeywords:销毁>"
  },
  State_3250_WeaponDesc = {
    Text = "打出后将其永久移除。"
  },
  State_3251_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并减少 1 层，回合开始时移除。"
  },
  State_3251_Name = {
    Text = "<ParcloseColour: 临时屏障>"
  },
  State_3252_Desc = {
    Text = "淤泥之花施加护盾时，最大生命提高 [StateArg2]。"
  },
  State_3252_Name = {
    Text = "黏液汇集"
  },
  State_3252_WeaponDesc = {
    Text = "淤泥之花施加护盾时，最大生命提高 [StateArg2]。"
  },
  State_3253_Desc = {
    Text = "获得[StateArg1]点临时戒备。"
  },
  State_3253_Name = {
    Text = "<CardKeyWord:机械武装-盾>"
  },
  State_3253_WeaponDesc = {
    Text = "获得[StateArg1]点临时戒备"
  },
  State_3255_Name = {Text = "反击"},
  State_3256_Name = {
    Text = "状态@诅咒兴奋"
  },
  State_3259_Desc = {
    Text = "造成的主动伤害次数提高[Layer] 。"
  },
  State_3259_Name = {
    Text = "<MadnessColour:疯狂>"
  },
  State_3260_Desc = {
    Text = "超维空间达到上限时，获得一个额外回合，此回合不再抽牌，而是将超维空间卡牌置入手牌。"
  },
  State_3260_Name = {
    Text = "<DimensionalSpaceIconKeywords:超维空间>"
  },
  State_3260_WeaponDesc = {
    Text = "超维空间达到上限时，获得一个额外的超维回合，将所有超维空间卡牌加入手牌。"
  },
  State_3261_Desc = {
    Text = "其召唤的怪物伤害翻倍。"
  },
  State_3261_Name = {
    Text = "「蜡像军团」"
  },
  State_3261_WeaponDesc = {
    Text = "其召唤的怪物伤害翻倍。"
  },
  State_3262_Desc = {
    Text = "状态@蜡质镀层我方队伍"
  },
  State_3262_Name = {
    Text = "状态@蜡质镀层我方队伍"
  },
  State_3262_WeaponDesc = {
    Text = "状态@蜡质镀层我方队伍"
  },
  State_3263_Name = {
    Text = "状态@鹦鹉螺螺壳回击"
  },
  State_3264_Name = {Text = "必爆"},
  State_3265_Name = {
    Text = "弃掉时将其移除"
  },
  State_3266_Desc = {
    Text = "死梦之都的强化跃迁"
  },
  State_3266_Name = {
    Text = "状态@死梦之都强化跃迁"
  },
  State_3267_Desc = {
    Text = "战斗开始时，获得 5 层【蜡质铠甲】。"
  },
  State_3267_Name = {
    Text = "「蜡之绅士」"
  },
  State_3267_WeaponDesc = {
    Text = "战斗开始时，获得 5 层【蜡质铠甲】。"
  },
  State_3268_Desc = {
    Text = "回合开始时抽 1 张牌。每当你抽到 1 张牌时，随机变化其算力消耗（0-4）。"
  },
  State_3268_Name = {
    Text = "造物万花筒"
  },
  State_3268_WeaponDesc = {
    Text = "回合开始时抽 1 张牌。每当你抽到 1 张牌时，随机变化其算力消耗（0-4）。"
  },
  State_3269_Desc = {
    Text = "每回合获得第 2 次护盾后，获得 [Arg1] 层反击。每回合获得第 4 次护盾后，对所有敌人造成 1 次反击伤害。"
  },
  State_3269_Name = {
    Text = "知无不言"
  },
  State_3270_Name = {
    Text = "状态@章二共鸣复制"
  },
  State_3271_Desc = {
    Text = "[打击]对所有敌人施加 [Arg1] 层中毒。"
  },
  State_3272_Desc = {
    Text = "造成未被格挡的伤害时，回复 3 倍实际伤害值的生命，造成伤害时移除。"
  },
  State_3272_Name = {Text = "吸血"},
  State_3273_Desc = {
    Text = "队伍唯一：打出装备者的卡牌后，获得等同于装备者 <WeaponEffect_Num:[StateArg1]%> 防御力的护盾，每有 1 条触腕就使护盾提高装备者防御力的 <WeaponEffect_Num:[StateArg2]%>。该效果单个回合只生效 1 次。"
  },
  State_3273_Name = {
    Text = "珊瑚女之死"
  },
  State_3273_WeaponDesc = {
    Text = "打出装备者的卡牌后，获得 <WeaponEffect_Num:[Block:DescArg1]> 护盾，每有 1 条触腕就使护盾提高 <WeaponEffect_Num:[DescArg2]>。该效果单个回合只生效 1 次。"
  },
  State_3274_Desc = {
    Text = "每次收到主动伤害给我方队伍增加一层计数"
  },
  State_3274_Name = {
    Text = "状态@复仇巨刃斩首重创我方队伍计数"
  },
  State_3274_WeaponDesc = {
    Text = "每次收到主动伤害给我方队伍增加一层计数"
  },
  State_3277_Desc = {
    Text = "打出后所属唤醒体获得 [StateArg1] 点狂气。"
  },
  State_3277_Name = {
    Text = "<Rune_5:狂化>"
  },
  State_3280_Name = {
    Text = "命定之剑"
  },
  State_3281_Desc = {
    Text = "提高造成的主动伤害。"
  },
  State_3281_Name = {
    Text = "<PowerIconKeywords: 力量>"
  },
  State_3281_WeaponDesc = {
    Text = "造成的伤害提高。"
  },
  State_3282_Desc = {
    Text = "伤害次数和伤害提高。"
  },
  State_3282_Name = {
    Text = "<CardKeyWord:升级>"
  },
  State_3282_WeaponDesc = {
    Text = "增加一次伤害"
  },
  State_3283_Desc = {
    Text = "每回合开始时，回复 [StateArg1] 生命。如果生命低于 50% ，回复生命变为 [StateArg2]。"
  },
  State_3283_Name = {
    Text = "造物乳香制剂"
  },
  State_3283_WeaponDesc = {
    Text = "每回合开始时，回复 [StateArg1] 生命。如果生命低于 50% ，回复生命变为 [StateArg2]。"
  },
  State_3287_Desc = {
    Text = "战斗开始时，将 2 张「灵感」洗入你的牌库。每通过 1 场战斗都会使这个造物升级，最多 3 次。"
  },
  State_3288_Desc = {
    Text = "状态@空状态"
  },
  State_3288_Name = {
    Text = "状态@空状态"
  },
  State_3288_WeaponDesc = {
    Text = "状态@空状态"
  },
  State_3289_Desc = {
    Text = "每受到 1 点伤害降低 1 层。层数为 0 后，将意图替换为不灭之花，并使用偏向防御的技能组。"
  },
  State_3289_Name = {
    Text = "不灭之花"
  },
  State_3289_WeaponDesc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_3290_Desc = {
    Text = "曾为「弥利亚姆」的异怪陷入了极度的偏执与绝望，击碎她最后的妄执，终结这数千年的疯狂。"
  },
  State_3290_Name = {Text = "妄执"},
  State_3291_Desc = {
    Text = "造成实际伤害时，使我方队伍失去 3 临时力量。"
  },
  State_3291_Name = {Text = "麻痹"},
  State_3292_Desc = {
    Text = "释放狂气爆发时，敌人每将要造成 1 次伤害，就对其施加 [Arg1] 层中毒"
  },
  State_3293_Desc = {
    Text = "本次关卡内造成的伤害降低 [Layer] 点。"
  },
  State_3293_Name = {
    Text = "力量降低"
  },
  State_3293_WeaponDesc = {
    Text = "本次关卡内造成的伤害和触腕伤害降低 [Layer] 点。"
  },
  State_3294_Name = {
    Text = "状态@诅咒多疑"
  },
  State_3296_Desc = {
    Text = "弃掉或打出时将其移除。"
  },
  State_3296_Name = {
    Text = "弃掉或打出时将其移除"
  },
  State_3296_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3297_Desc = {
    Text = "状态@荆棘女王启明_形"
  },
  State_3297_Name = {
    Text = "状态@荆棘女王启明_形"
  },
  State_3297_WeaponDesc = {
    Text = "状态@荆棘女王启明_形"
  },
  State_3298_Desc = {
    Text = "本回合内下一次跃迁效果必定触发。"
  },
  State_3298_Name = {
    Text = "跃迁必定触发"
  },
  State_3298_WeaponDesc = {
    Text = "本回合内跃迁效果无需条件。"
  },
  State_3301_Name = {
    Text = "群星之酒计数"
  },
  State_3302_Desc = {
    Text = "施加永远凝结"
  },
  State_3302_Name = {
    Text = "施加永远凝结"
  },
  State_3302_WeaponDesc = {
    Text = "施加永远凝结"
  },
  State_3304_Desc = {
    Text = "每回合打出最后一张指令卡的对应唤醒体，在回合结束时获得 15 狂气，若同时拥有「母亲造像」，使其他唤醒体也获得 5 狂气。"
  },
  State_3305_Desc = {
    Text = "打出后将 [StateArg1] 张 「灵感」 洗入抽牌堆。「灵感」：获得 1 算力，抽 1 张牌，保留，消耗。"
  },
  State_3305_Name = {
    Text = "<Rune_17:灵感>"
  },
  State_3307_Name = {
    Text = "(剩余:[Layer])"
  },
  State_3308_Desc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 2 张，获得 2 算力。"
  },
  State_3309_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3309_Name = {
    Text = "状态@试作长剑死抗"
  },
  State_3310_Desc = {
    Text = "迁移者施加护盾时，获得 [Energy:StateArg2] 狂气。"
  },
  State_3310_Name = {
    Text = "自我封锁"
  },
  State_3310_WeaponDesc = {
    Text = "迁移者施加护盾时，获得 [Energy:StateArg2] 狂气。"
  },
  State_3312_Desc = {
    Text = "每当你回复生命时获得 [Arg1] 点反击，若生命值大于 75%，额外获得 [Arg2] 点反击。"
  },
  State_3313_Desc = {
    Text = "回合开始时使本回合内获得 [Arg1] 点力量，每打出 1 张卡牌就使本回合内失去 [Arg2] 点力量。"
  },
  State_3314_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3314_Name = {
    Text = "尚未觉醒"
  },
  State_3315_Desc = {
    Text = "每回合打出第一张卡牌后，使随机 2 张手牌变为其原始版复制，回合结束时恢复。"
  },
  State_3315_Name = {
    Text = "造物蛊惑风铃"
  },
  State_3316_Desc = {
    Text = "回合结束时护盾会保留。"
  },
  State_3316_Name = {
    Text = "守护防壁"
  },
  State_3316_WeaponDesc = {
    Text = "回合结束时护盾会保留。"
  },
  State_3317_Desc = {
    Text = "回合结束时失去所有护盾"
  },
  State_3317_Name = {
    Text = "枷锁：生父"
  },
  State_3318_Name = {
    Text = "状态@渴血者献媚者之拥吞噬标识"
  },
  State_3323_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3323_Name = {
    Text = "状态@试作长剑狂气"
  },
  State_3324_Desc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_3324_Name = {
    Text = "临时暴击伤害"
  },
  State_3324_WeaponDesc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_3325_Desc = {
    Text = "每次重置牌库时，将 2 张本回合内获得 [Arg1] 点力量的「渔叉」和 1 张本回合内获得 [Arg2] 点戒备的 「阳伞」加入手牌。"
  },
  State_3326_Desc = {
    Text = "每回合免疫首次主动伤害。"
  },
  State_3326_Name = {Text = "坚定"},
  State_3326_WeaponDesc = {
    Text = "每回合免疫首次主动伤害。"
  },
  State_3327_Desc = {
    Text = "怪物死亡前生命值。"
  },
  State_3327_Name = {
    Text = "怪物死前血量"
  },
  State_3327_WeaponDesc = {
    Text = "怪物死亡前生命值。"
  },
  State_3328_Desc = {
    Text = "本场战斗受到致死伤害时，复活一次并回复 [Layer] 点生命，无法驱散。"
  },
  State_3328_Name = {
    Text = "不死的极乐鸟"
  },
  State_3329_Desc = {
    Text = "每打出 5 张牌，获得一张你手中最左侧卡牌的复制，但附加虚无和消耗。"
  },
  State_3330_Desc = {
    Text = "卡牌算力消耗增加 [Layer] 点。打出卡牌后该负面效果会被移除。"
  },
  State_3330_Name = {
    Text = "<SlowColour:迟缓 [Layer]>"
  },
  State_3330_WeaponDesc = {
    Text = "卡牌算力消耗增加 [Layer]点。"
  },
  State_3332_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并减少 1 层。"
  },
  State_3332_Name = {
    Text = "<ParcloseColour: 屏障>"
  },
  State_3335_Desc = {
    Text = "战斗开始时，对所有敌人施加 1 层易伤。「凝滞诅咒」额外使敌人受到的易伤效果提高 25%。"
  },
  State_3335_Name = {
    Text = "石之眼启灵6"
  },
  State_3336_Name = {
    Text = "状态@乔治@死亡时治疗"
  },
  State_3337_Desc = {Text = "——"},
  State_3337_Name = {Text = "红祭礼"},
  State_3337_WeaponDesc = {Text = "——"},
  State_3339_Desc = {
    Text = "提高[Layer]点攻击力。"
  },
  State_3339_Name = {
    Text = "临时攻击力提高"
  },
  State_3339_WeaponDesc = {
    Text = "提高[Layer]点攻击力。"
  },
  State_3340_Desc = {
    Text = "释放狂气爆发后，本场战斗内狂气爆发伤害提高 [Arg1]，最多堆叠 5 次。堆叠满时释放该狂气爆发的唤醒体获得 100 狂气。"
  },
  State_3341_Desc = {
    Text = "状态@序章重置牌库0_1_2_1"
  },
  State_3341_Name = {
    Text = "状态@序章重置牌库0_1_2_1"
  },
  State_3341_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_1"
  },
  State_3342_Desc = {
    Text = "状态@序章重置牌库0_1_2_2"
  },
  State_3342_Name = {
    Text = "状态@序章重置牌库0_1_2_2"
  },
  State_3342_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_2"
  },
  State_3343_Desc = {
    Text = "状态@序章重置牌库0_1_2_3"
  },
  State_3343_Name = {
    Text = "状态@序章重置牌库0_1_2_3"
  },
  State_3343_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_3"
  },
  State_3344_Desc = {
    Text = "状态@序章重置牌库0_1_2_4"
  },
  State_3344_Name = {
    Text = "状态@序章重置牌库0_1_2_4"
  },
  State_3344_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_4"
  },
  State_3345_Desc = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3345_Name = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3345_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3346_Desc = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3346_Name = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3346_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_6"
  },
  State_3347_Desc = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3347_Name = {
    Text = "状态@序章重置牌库0_1_2_5"
  },
  State_3347_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_2_7"
  },
  State_3348_Desc = {
    Text = "打出后抽 [StateArg1] 张牌。"
  },
  State_3348_Name = {
    Text = "<Rune_3_High:高级妙手>"
  },
  State_3348_WeaponDesc = {
    Text = "打出后抽 [StateArg1] 张牌。"
  },
  State_3350_Desc = {
    Text = "释放狂气爆发后，失去 10% 当前生命，本回合内偷取所有敌人 [Arg1] 点力量。"
  },
  State_3351_Name = {
    Text = "状态@加入卡组后"
  },
  State_3352_Name = {
    Text = "造物秘典星象仪1"
  },
  State_3354_Name = {
    Text = "造物秘典星象仪2"
  },
  State_3356_Name = {
    Text = "回合结束窒息中毒"
  },
  State_3357_Desc = {
    Text = "下回合开始后，触腕伤害 +[Layer]。"
  },
  State_3357_Name = {
    Text = "延迟触腕伤害"
  },
  State_3358_Desc = {
    Text = "下回合开始后，获得 [Layer] 点护盾。"
  },
  State_3358_Name = {
    Text = "失落的艺术-护盾"
  },
  State_3359_Desc = {
    Text = "你每打出的第 3 张牌会生效 2 次。"
  },
  State_3359_Name = {
    Text = "造物群星之酒"
  },
  State_3359_WeaponDesc = {
    Text = "你每打出的第 3 张牌会生效 2 次。"
  },
  State_3360_Desc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3360_Name = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3360_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3362_Desc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3362_Name = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3362_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3364_Desc = {
    Text = "拾取时选择一张卡牌，将两个三选一强化效果赋予其上。（注：类似千面幻象捏卡）"
  },
  State_3365_Desc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3365_Name = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3365_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3366_Desc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3366_Name = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3366_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3368_Desc = {
    Text = "若弃牌阶段前算力消耗大于5，则变为石头。"
  },
  State_3368_Name = {Text = "石化"},
  State_3368_WeaponDesc = {
    Text = "弃牌阶段前将手牌变成石头"
  },
  State_3369_Desc = {
    Text = "你的所有吞噬效果均变为无限吞噬。"
  },
  State_3369_Name = {
    Text = "无限吞噬"
  },
  State_3369_WeaponDesc = {
    Text = "你的所有吞噬效果均变为无限吞噬。"
  },
  State_3370_Desc = {
    Text = "本次关卡内造成的护盾降低 [Layer] 点。"
  },
  State_3370_Name = {
    Text = "永久戒备降低"
  },
  State_3370_WeaponDesc = {
    Text = "本次关卡内造成的护盾降低 [Layer] 点。"
  },
  State_3372_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3372_Name = {
    Text = "尚未觉醒"
  },
  State_3373_Desc = {
    Text = "造成实际伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_3373_Name = {Text = "窒息"},
  State_3373_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3374_Desc = {
    Text = "回合结束后，获得等量层数的力量。"
  },
  State_3374_Name = {Text = "愤怒"},
  State_3376_Desc = {
    Text = "本场战斗内狂气爆发造成的伤害提高 [Layer] 点。"
  },
  State_3376_Name = {
    Text = "狂气爆发伤害提高"
  },
  State_3378_Desc = {
    Text = "释放狂气爆发后，下一张打出的卡牌生效 2 次。"
  },
  State_3378_Name = {
    Text = "状态@幻梦银钥：爆发"
  },
  State_3379_Desc = {
    Text = "生命低于 50% 时，破链者将会狂暴。"
  },
  State_3379_Name = {
    Text = "复仇之刻"
  },
  State_3379_WeaponDesc = {
    Text = "生命低于 50% 时，破链者将会狂暴。"
  },
  State_3380_Desc = {
    Text = "战斗开始时，将 1 张【迷惑】洗入抽牌堆。"
  },
  State_3380_Name = {Text = "幻惑"},
  State_3380_WeaponDesc = {
    Text = "战斗开始时，将 1 张【迷惑】洗入抽牌堆。"
  },
  State_3381_Name = {
    Text = "超维职业初始化"
  },
  State_3382_Desc = {
    Text = "获得一个任务。完成任务后，获得奖励。【任务事件占位】"
  },
  State_3383_Name = {
    Text = "超维职业初始化"
  },
  State_3385_Desc = {
    Text = "受到的主动和触腕伤害降低33%。"
  },
  State_3385_Name = {Text = "镜盾"},
  State_3385_WeaponDesc = {
    Text = "受到的主动和触腕伤害降低33%。"
  },
  State_3386_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3386_Name = {
    Text = "状态@试作长剑暴击"
  },
  State_3387_Name = {
    Text = "状态@关卡2_3战斗3气泡1"
  },
  State_3388_Desc = {
    Text = "打出后获得 [StateArg1] 点力量。"
  },
  State_3388_Name = {
    Text = "<Rune_14:蛮力>"
  },
  State_3389_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3389_Name = {
    Text = "尚未觉醒"
  },
  State_3390_Desc = {
    Text = "战斗开始时，虚弱和易伤所有敌人 1 回合。"
  },
  State_3392_Desc = {
    Text = "拾取时获得 [Arg1] 力量。每当有「胚胎」被融合，本回合内获得 [Arg2] 点力量。"
  },
  State_3393_Desc = {
    Text = "回合开始时胚胎融合+30%。你的所有吞噬效果均变为无限吞噬。"
  },
  State_3394_Name = {
    Text = "将 1 张<DerivativeCardKeywords_4:「灵感」>置入抽牌堆"
  },
  State_3395_Desc = {
    Text = "队伍唯一：装备者的「打击」基础伤害提高 25%，「防御」基础护盾提高 25%。打出装备者「打击」时获得装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>，打出装备者「防御」时获得装备者防御力 <WeaponEffect_Num:[StateArg2]%> 的临时<AlertIconKeywords:戒备>。若当前界域为「超维」，进入超维回合时获得一次临时<PowerIconKeywords:力量>与临时<AlertIconKeywords:戒备>。"
  },
  State_3395_WeaponDesc = {
    Text = "装备者的「打击」基础伤害提高 25%，「防御」基础护盾提高 25%。打出装备者「打击」时获得 <WeaponEffect_Num:[Power:DescArg1]> 点临时<PowerIconKeywords:力量>，打出装备者「防御」时获得<WeaponEffect_Num:[DescArg2]> 点临时<AlertIconKeywords:戒备>。若当前界域为「超维」，进入超维回合时获得一次临时<PowerIconKeywords:力量>与临时<AlertIconKeywords:戒备>。"
  },
  State_3397_Desc = {
    Text = "每打出第 10 张牌时，提高 [Arg1] 触腕伤害，使所有触腕攻击 1 次。"
  },
  State_3400_Desc = {
    Text = "精英敌人和首领敌人的生命上限降低 20%。"
  },
  State_3401_Desc = {
    Text = "打出后额外生效 [StateArg1] 次，获得 [StateArg2] 点黑印，消耗，固有。"
  },
  State_3401_Name = {
    Text = "<Rune_7:回声>"
  },
  State_3402_Desc = {
    Text = "「铁镐」卢森重击伤害提高 [Layer] %。"
  },
  State_3402_Name = {
    Text = "重击伤害提高"
  },
  State_3402_WeaponDesc = {
    Text = "铁镐卢森重击伤害提高 [Layer] %"
  },
  State_3403_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3403_Name = {
    Text = "尚未觉醒"
  },
  State_3405_Name = {
    Text = "所有敌人临时降低 [Power:StateArg1] 点<PowerIconKeywords:力量>， 1 回合内获得的护盾和<PowerIconKeywords:力量>降低 50%"
  },
  State_3406_Name = {
    Text = "获得 [StateArg1] 点<PowerIconKeywords:力量>"
  },
  State_3407_Name = {
    Text = "选择 1 张抽牌堆的卡牌置入手牌并使其算力消耗 -1"
  },
  State_3408_Name = {
    Text = "获得  <Posse:[DescArg1]>  点银钥能量。在本场战斗中「断颈一击」和「千面幻象」的基础伤害提高 10%"
  },
  State_3409_Name = {
    Text = "选择一名唤醒体获得 <Energy:[DescArg1]> 点狂气"
  },
  State_3410_Name = {
    Text = "此卡牌暴击率和暴击伤害提高 50%，造成穿刺伤害"
  },
  State_3411_Name = {
    Text = "自身免疫<FragileIconKeywords:脆弱>、<WeaknessIconKeywords:虚弱>、<VulnerabilityIconKeywords:易伤> 1 回合。获得 <Block:[Block:StateArg1]> 点护盾"
  },
  State_3412_Desc = {
    Text = "免疫负面状态，回合结束或被暴击后减少 1 层。"
  },
  State_3412_Name = {
    Text = "蜡质镀层"
  },
  State_3412_WeaponDesc = {
    Text = "每层使受到的伤害降低 10%，每次被暴击后减少 1 层。"
  },
  State_3415_Desc = {
    Text = "拾取时从 3 个腐化刻印中选择获得 1 个。腐化刻印比普通刻印更强大，但打出时消耗卡牌。"
  },
  State_3415_Name = {
    Text = "造物翠玉拓印"
  },
  State_3415_WeaponDesc = {
    Text = "拾取时从 3 个腐化刻印中选择获得 1 个。腐化刻印比普通刻印更强大，但打出时消耗卡牌。"
  },
  State_3416_Desc = {
    Text = "队伍唯一：战斗开始后，获得等同于装备者防御力 <WeaponEffect_Num:[StateArg1]%> 的反击。触发<DeathResistanceIconKeywords: 死亡抵抗>后，获得至多总计 2 层「摇篮」：全体友方造成的护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%> ，回合结束时移除 1 层，若当前界域为「血肉」，触发<DeathResistanceIconKeywords: 死亡抵抗>后胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3416_WeaponDesc = {
    Text = "战斗开始后，获得 <WeaponEffect_Num:[Counterattack:DescArg1]> 层反击。触发<DeathResistanceIconKeywords: 死亡抵抗>后，获得至多总计 2 层「摇篮」：全体友方造成的护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%> ，回合结束时移除 1 层，若当前界域为「血肉」，触发<DeathResistanceIconKeywords: 死亡抵抗>后胚胎融合 <WeaponEffect_Num:+[Blood:StateArg3]> 。"
  },
  State_3418_Desc = {
    Text = "回合结束后，失去临时力量"
  },
  State_3418_Name = {
    Text = "延迟衰竭"
  },
  State_3419_Desc = {
    Text = "拾取时展示 3 张具有高级或诅咒刻印的卡牌，选择一张赋予其对应刻印。"
  },
  State_3420_Desc = {
    Text = "每次行动造成出血，治疗可减半出血层数。"
  },
  State_3420_Name = {Text = "血溅"},
  State_3420_WeaponDesc = {
    Text = "每次行动造成出血，治疗可减半出血层数。"
  },
  State_3421_Desc = {
    Text = "回合开始时，将一张本回合内获得 [Arg1] 力量「渔叉」加入手中。释放狂气爆发后，使手牌中所有的「渔叉」力量提高 [Arg2]。"
  },
  State_3422_Name = {
    Text = "状态@饰品无垢启示录"
  },
  State_3422_WeaponDesc = {
    Text = "释放钥令后，回复 [DescArg1] 生命。若装备者银钥充能等级大于 20，额外回复 [DescArg1] 生命。同类效果无法重复生效。"
  },
  State_3423_Desc = {
    Text = "界域精通100，造成伤害加临时触腕伤害。"
  },
  State_3423_Name = {
    Text = "时灵摆「梦魇」"
  },
  State_3424_Desc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 3 张，抽 2 张牌。"
  },
  State_3425_Desc = {
    Text = "生命低于 50%([StateArg1]) 时，将意图变为「绝境求生」：移除脆弱、虚弱和中毒状态，对我方队伍造成 99 层虚弱和脆弱"
  },
  State_3425_Name = {
    Text = "复仇之刻"
  },
  State_3425_WeaponDesc = {
    Text = "生命低于 50%([StateArg1]) 时，将意图变为「绝境求生」：移除脆弱、虚弱和中毒状态，对我方队伍造成 99 层虚弱和脆弱"
  },
  State_3429_Desc = {
    Text = "每次行动附加出血，治疗可移除出血效果"
  },
  State_3429_Name = {Text = "重伤"},
  State_3429_WeaponDesc = {
    Text = "每次行动附加出血，治疗可移除出血效果"
  },
  State_3430_Desc = {
    Text = "释放狂气爆发后，获得 [Arg1] 点反击。若本场战斗内第 6 次触发，则使你的反击翻倍。"
  },
  State_3431_Name = {
    Text = "免疫中毒"
  },
  State_3432_Desc = {
    Text = "弃掉时将其消耗"
  },
  State_3432_Name = {
    Text = "弃牌消耗"
  },
  State_3432_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3434_Name = {
    Text = "状态@通用造成易伤修正"
  },
  State_3436_Desc = {
    Text = "有 [Layer] 名唤醒体正在被狩猎。"
  },
  State_3436_Name = {Text = "被狩猎"},
  State_3437_Desc = {
    Text = "状态@怪物鲸跃幻影星球初子_混沌之兽"
  },
  State_3437_Name = {
    Text = "状态@怪物鲸跃幻影星球初子_混沌之兽"
  },
  State_3437_WeaponDesc = {
    Text = "状态@怪物鲸跃幻影星球初子_混沌之兽"
  },
  State_3438_Desc = {
    Text = "获得[StateArg1]点临时力量。"
  },
  State_3438_Name = {
    Text = "<CardKeyWord:机械武装-剑>"
  },
  State_3439_Desc = {
    Text = "回合结束时图鲁获得 5 点狂气。"
  },
  State_3439_Name = {
    Text = "群星归位"
  },
  State_3440_Name = {
    Text = "黄金向导"
  },
  State_3441_Desc = {
    Text = "奇数回合，当你的手牌为 0 时，抽 2 张牌；偶数回合，当你的算力为 0 时，获得 2 算力。"
  },
  State_3441_Name = {
    Text = "异化老旧拼图"
  },
  State_3441_WeaponDesc = {
    Text = "奇数回合，当你的手牌为 0 时，抽 2 张牌；偶数回合，当你的算力为 0 时，获得 2 算力。"
  },
  State_3442_Desc = {
    Text = "拾取时永久失去 [Arg1] 力量。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  State_3442_Name = {
    Text = "七鳃鳗之吻"
  },
  State_3444_Desc = {
    Text = "回合开始时抽 1 张牌。"
  },
  State_3445_Desc = {
    Text = "提高[Layer]%防御力。"
  },
  State_3445_Name = {
    Text = "通用防御力百分比提高"
  },
  State_3445_WeaponDesc = {
    Text = "提高[Layer]%防御力。"
  },
  State_3446_Desc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_3446_Name = {Text = "爆弹"},
  State_3446_WeaponDesc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_3447_Desc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_3447_Name = {Text = "爆弹"},
  State_3447_WeaponDesc = {
    Text = "拥有 5 层【导火线】。打出卡牌后层数减少 1。当层数变为 0 时自爆，造成攻击力*2.5 的伤害。"
  },
  State_3448_Desc = {
    Text = "每回合结束后，激发所有触腕"
  },
  State_3448_Name = {
    Text = "触腕自动激发"
  },
  State_3448_WeaponDesc = {
    Text = "每回合结束后，激发所有触腕"
  },
  State_3449_Desc = {
    Text = "状态@序章狂气0_1_1生效"
  },
  State_3449_Name = {
    Text = "状态@序章狂气0_1_1生效"
  },
  State_3449_WeaponDesc = {
    Text = "状态@序章狂气0_1_1生效"
  },
  State_3450_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并移除 1 层。"
  },
  State_3450_Name = {
    Text = "<ParcloseIconKeywords: 屏障>"
  },
  State_3450_WeaponDesc = {
    Text = "承受的伤害降低 99%，承受伤害后降低 1 层。"
  },
  State_3451_Desc = {
    Text = "死亡时所有唤醒体获得 10 狂气。"
  },
  State_3451_Name = {
    Text = "弥留的银屑"
  },
  State_3451_WeaponDesc = {
    Text = "死亡时所有唤醒体获得 10 狂气。"
  },
  State_3452_Desc = {
    Text = "每次打出卡牌时受到 [StateArg1] 伤害并移除 1 层。回合结束时若仍存在，孵化一个「海中之物」，每有 1 层生命就提高 10%。"
  },
  State_3452_Name = {
    Text = "深渊侵食"
  },
  State_3453_Name = {
    Text = "状态@复仇巨刃力量倍数"
  },
  State_3455_Desc = {
    Text = "状态@序章狂气初始化0_2_3效果"
  },
  State_3455_Name = {
    Text = "状态@序章狂气初始化0_2_3效果"
  },
  State_3455_WeaponDesc = {
    Text = "状态@序章狂气初始化0_2_3效果"
  },
  State_3456_Desc = {
    Text = "[防御]获得 [StateArg1] 层反击。"
  },
  State_3456_Name = {
    Text = "造物刺荨麻背心"
  },
  State_3457_Name = {
    Text = "免疫易伤"
  },
  State_3458_Desc = {
    Text = "打出 [打击] 与 [防御] 后，对应唤醒体获得 35 狂气。但是它们的算力消耗+1。"
  },
  State_3459_Desc = {
    Text = "本场战斗内狂气爆发造成的伤害提高 [Layer] 点。"
  },
  State_3459_Name = {
    Text = "狂气爆发伤害提高"
  },
  State_3461_Desc = {
    Text = "你每造成的第 5 次伤害必定暴击。"
  },
  State_3462_Name = {
    Text = "状态@复仇巨刃力量倍数3"
  },
  State_3463_Name = {
    Text = "状态@复仇巨刃力量倍数2"
  },
  State_3464_Desc = {
    Text = "触腕上限提高 1 条。生命低于 50% 时，触腕伤害提高 [Arg1] 。"
  },
  State_3465_Desc = {
    Text = "该卡牌将携带出战斗，关卡内有效。"
  },
  State_3465_Name = {
    Text = "<CardKeyWord:永续>"
  },
  State_3465_WeaponDesc = {
    Text = "该卡牌能携带出战斗，关卡内有效。"
  },
  State_3466_Desc = {
    Text = "拾取时选择一名唤醒体将其觉醒，其觉醒卡算力消耗永久降低 1。"
  },
  State_34671_Desc = {
    Text = "打出后返回手牌。"
  },
  State_34671_Name = {
    Text = "<CardKeyWord:回手>"
  },
  State_34685_Name = {
    Text = "炸弹2玩家"
  },
  State_34689_Desc = {
    Text = "每失去 1 点生命，获得 1 层<PainWord:忍耐>，上限为最大生命的 100%。忍耐会继承至下场战斗。"
  },
  State_34689_Name = {
    Text = "<CardKeyWord:忍耐>"
  },
  State_3468_Desc = {
    Text = "状态@残次品的怨念"
  },
  State_3468_Name = {
    Text = "状态@残次品的怨念"
  },
  State_3468_WeaponDesc = {
    Text = "状态@残次品的怨念"
  },
  State_34691_Desc = {
    Text = "每失去 1 点生命，获得 1 层<PainWord:忍耐>。上限为 [DescArg1] 层。忍耐会继承至下场战斗。"
  },
  State_34691_Name = {
    Text = "<CardKeyWord:忍耐>"
  },
  State_34696_Desc = {
    Text = "此卡牌任何情况下都会在手牌中并使手牌上限 +1。"
  },
  State_34696_Name = {
    Text = "永久保留并无视手牌上限"
  },
  State_3469_Desc = {
    Text = "造成的主动和触腕伤害降低 [DescArg1] %。"
  },
  State_3469_Name = {
    Text = "<WeaknessColour:虚弱>"
  },
  State_3469_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_3470_Desc = {
    Text = "施加渐渐石化检测"
  },
  State_3470_Name = {
    Text = "施加渐渐石化检测"
  },
  State_3470_WeaponDesc = {
    Text = "施加渐渐石化检测"
  },
  State_3471_Desc = {
    Text = "你每打出的第 [StateArg1] 张牌会生效 2 次。"
  },
  State_3471_Name = {
    Text = "群星之酒计数"
  },
  State_3471_WeaponDesc = {
    Text = "你每打出的第 [StateArg1] 张牌会生效 2 次。"
  },
  State_3473_Desc = {
    Text = "生命低于 50% 时，「提灯教牧」将会祈求「神降」，吸收所有教众后狂暴。"
  },
  State_3473_Name = {
    Text = "灯芯的烙印"
  },
  State_3473_WeaponDesc = {
    Text = "生命低于 50% 时，「提灯教牧」将会祈求「神降」，吸收所有教众后狂暴。"
  },
  State_3475_Desc = {
    Text = "[打击]与[防御]算力消耗+1。"
  },
  State_3475_Name = {
    Text = "造物诅咒石碑"
  },
  State_3475_WeaponDesc = {
    Text = "[打击]与[防御]算力消耗+1。"
  },
  State_3476_Desc = {
    Text = "每当你损失生命，胚胎融合+10%。若生命低于 50% 时效果翻倍。"
  },
  State_3477_Desc = {
    Text = "受到攻击时恢复 [Layer] %最大生命值，受到超过最大生命值 15 %的伤害时，眩晕并移除此状态"
  },
  State_3477_Name = {
    Text = "黑色混沌"
  },
  State_3478_Name = {
    Text = "状态@饰品标准密契"
  },
  State_3479_Desc = {
    Text = "每消费 1 黑印所有唤醒体获得 1 狂气"
  },
  State_3479_Name = {
    Text = "造物逆生花"
  },
  State_3479_WeaponDesc = {
    Text = "每消费 1 黑印所有唤醒体获得 1 狂气"
  },
  State_3480_Desc = {
    Text = "直到回合结束，生命值不会降为0."
  },
  State_3480_Name = {
    Text = "珠玉之卵不死"
  },
  State_3480_WeaponDesc = {
    Text = "直到回合结束，生命值不会降为0."
  },
  State_3481_Desc = {
    Text = "关卡开始时，将你的死亡抵抗率和幸运刻印率翻倍。"
  },
  State_3481_Name = {
    Text = "状态@幻梦银钥：双倍幸运"
  },
  State_3482_Desc = {
    Text = "造成的易伤效果提高 25%。每 3 回合对所有敌人添加 1 层易伤。"
  },
  State_3483_Desc = {
    Text = "每次行动附加出血，治疗可移除出血效果"
  },
  State_3483_Name = {Text = "重伤"},
  State_3483_WeaponDesc = {
    Text = "每次行动附加出血，治疗可移除出血效果"
  },
  State_3484_Desc = {
    Text = "造成实际伤害时，获得力量。"
  },
  State_3484_Name = {
    Text = "「纷乱人格」"
  },
  State_3485_Desc = {
    Text = "状态@提灯仪式生效"
  },
  State_3485_Name = {
    Text = "状态@提灯仪式生效"
  },
  State_3485_WeaponDesc = {
    Text = "状态@提灯仪式生效"
  },
  State_3486_Name = {
    Text = "命定之剑"
  },
  State_3488_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_3488_Name = {
    Text = "被多次寄生"
  },
  State_3489_Name = {
    Text = "回合结束时若在手牌或<DimensionalSpaceIconKeywords:超维空间>，升级为「腐化绿炎」"
  },
  State_3489_WeaponDesc = {
    Text = "回合结束时若在手牌或超维空间会得到强化"
  },
  State_3490_Desc = {
    Text = "打出卡牌时受到 [StateArg1] 点伤害并移除 1 层。层数为 0 时孵化一个较弱的「海中之物」。若回合结束时仍存在被寄生状态，孵化一个生命随层数提高的「海中之物」。"
  },
  State_3490_Name = {
    Text = "被再次寄生"
  },
  State_3492_Desc = {
    Text = "每个偶数回合使我方队伍力量减少[Layer]。"
  },
  State_3492_Name = {Text = "卸力"},
  State_3495_Desc = {
    Text = "每次行动附加[Layer]出血"
  },
  State_3495_Name = {Text = "重伤"},
  State_3495_WeaponDesc = {
    Text = "每次行动附加[Layer]出血，治疗可移除出血效果"
  },
  State_34964_Desc = {
    Text = "回合开始后，获得 10% 最大生命的<PainWord:忍耐>。"
  },
  State_34964_Name = {
    Text = "永不遗忘"
  },
  State_3496_Name = {
    Text = "回合结束时若在手牌或<DimensionalSpaceIconKeywords:超维空间>，升级为「死灭绿炎」"
  },
  State_3496_WeaponDesc = {
    Text = "回合结束时若在手牌或超维空间会得到强化"
  },
  State_3497_Desc = {
    Text = "队伍由不同职业的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%"
  },
  State_3497_Name = {
    Text = "混搭加成"
  },
  State_3497_WeaponDesc = {
    Text = "队伍由不同职业的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%"
  },
  State_3499_Desc = {
    Text = "队伍唯一：装备者产生的狂气提高 <WeaponEffect_Num:[StateArg1]%> 。装备者释放狂气爆发后，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。"
  },
  State_3499_WeaponDesc = {
    Text = "装备者产生的狂气提高 <WeaponEffect_Num:[StateArg1]%> 。装备者释放狂气爆发后，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。"
  },
  State_3502_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3502_Name = {
    Text = "状态@试作小刀狂气"
  },
  State_3504_Desc = {
    Text = "每回合开始时，抽 [StateArg1] 张牌。"
  },
  State_3504_Name = {
    Text = "造物定向罗盘"
  },
  State_3504_WeaponDesc = {
    Text = "每回合开始时，抽 [StateArg1] 张牌。"
  },
  State_3507_Name = {
    Text = "饰品有机形态"
  },
  State_3507_WeaponDesc = {
    Text = "装备者使用狂气爆发后，本回合内自身护盾和治疗强效翻倍。"
  },
  State_3508_Name = {
    Text = "饰品少女之蛹"
  },
  State_3508_WeaponDesc = {
    Text = "战斗开始后，若装备者职业为混沌，攻击力提高 25%。"
  },
  State_3510_Desc = {
    Text = "唤醒体造成的护盾提高 [Layer] 点。"
  },
  State_3510_Name = {
    Text = "<AlertColour: 戒备>"
  },
  State_3511_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3511_Name = {
    Text = "状态@试作长剑幸运"
  },
  State_35120_Desc = {
    Text = "每受到 1 次主动伤害，对伤害来源施加 [StateArg1] 层中毒，持续 [Layer] 回合。"
  },
  State_35120_Name = {
    Text = "淤泥上的不灭之花"
  },
  State_3512_Name = {
    Text = "临时免疫脆弱"
  },
  State_3514_Desc = {
    Text = "回合结束时受到等量层数的<FixedDamage:纯粹伤害>并移除该状态。"
  },
  State_3514_Name = {
    Text = "<BleedingIconKeywords: 出血>"
  },
  State_3514_WeaponDesc = {
    Text = "回合开始时受到伤害。"
  },
  State_35158_Name = {
    Text = "时灵摆「入迷」"
  },
  State_3515_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3515_Name = {
    Text = "尚未觉醒"
  },
  State_35161_Name = {
    Text = "时灵摆「积蓄」"
  },
  State_3516_Name = {
    Text = "状态@诅咒颓丧"
  },
  State_3518_Desc = {
    Text = "奇术师每打出 1 张卡牌，就获得 [StateArg2] 临时力量。"
  },
  State_3518_Name = {
    Text = "演出序幕"
  },
  State_3519_Desc = {
    Text = "即使不在超维回合，每回合也能够触发一次跃迁效果。"
  },
  State_3519_Name = {
    Text = "空间偏折仪"
  },
  State_3519_WeaponDesc = {
    Text = "即使不在超维回合，每回合也能够触发一次跃迁效果。"
  },
  State_3520_Desc = {
    Text = "战斗开始时，选择一名唤醒体，给予其 50 狂气。"
  },
  State_35228_Name = {
    Text = "时灵摆「积蓄」"
  },
  State_3522_Name = {
    Text = "造物渔叉计数"
  },
  State_35238_Desc = {
    Text = "队伍唯一：装备者造成的护盾和中毒提高  <WeaponEffect_Num:[StateArg1]%>。每当触发死亡抵抗，所有唤醒体获得  <WeaponEffect_Num:[StateArg2]%> 临时暴击率和暴击伤害。"
  },
  State_35238_WeaponDesc = {
    Text = "装备者造成的护盾和中毒提高  <WeaponEffect_Num:[StateArg1]%>。每当触发死亡抵抗，所有唤醒体获得  <WeaponEffect_Num:[StateArg2]%> 临时暴击率和暴击伤害。"
  },
  State_3523_Desc = {
    Text = "打出后虚弱所有敌人 [StateArg1] 回合。"
  },
  State_3523_Name = {
    Text = "<Rune_1_High:高级虚弱>"
  },
  State_3524_Desc = {
    Text = "承受的伤害提高 [Layer] 点。"
  },
  State_3524_Name = {
    Text = "融蚀伤口"
  },
  State_3524_WeaponDesc = {
    Text = "承受的伤害提高 [Layer] 点。"
  },
  State_3525_Desc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 2 层【束缚】。"
  },
  State_3525_Name = {
    Text = "「东区特供」"
  },
  State_3525_WeaponDesc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 2 层【束缚】。"
  },
  State_35264_Desc = {
    Text = "本回合每打出1张牌后「奇术师」获得 1 层幻影。"
  },
  State_35264_Name = {
    Text = "移形换影记录"
  },
  State_35277_Name = {
    Text = "卡茜亚的魔术防御"
  },
  State_3527_Desc = {
    Text = "每回合打出第一张指令卡的对应唤醒体，在回合结束时获得 15 狂气，若同时拥有「奉献精神」，使其他唤醒体也获得 5 狂气。"
  },
  State_3528_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3528_Name = {
    Text = "状态@试作激光炮界域"
  },
  State_3529_Desc = {
    Text = "免疫一切伤害，回合开始后移除。"
  },
  State_3529_Name = {
    Text = "免疫伤害"
  },
  State_3530_Desc = {
    Text = "状态@幸运侦探肆意豪赌标识8"
  },
  State_3530_Name = {
    Text = "状态@幸运侦探肆意豪赌标识8"
  },
  State_3530_WeaponDesc = {
    Text = "状态@幸运侦探肆意豪赌标识8"
  },
  State_3531_Desc = {
    Text = "队伍唯一：战斗开始时，装备者获得 <WeaponEffect_Num:[StateArg1]> 狂气。每当其他唤醒体释放狂气爆发时，装备者获得 <WeaponEffect_Num:[StateArg2]> 狂气。若当前界域为「深海」，装备者释放狂气爆发后，获得等同于攻击力 <WeaponEffect_Num:[StateArg3]%> 的触腕伤害。"
  },
  State_3531_WeaponDesc = {
    Text = "战斗开始时，装备者获得 <WeaponEffect_Num:[StateArg1]> 狂气。每当其他唤醒体释放狂气爆发时，装备者获得 <WeaponEffect_Num:[StateArg2]> 狂气。若当前界域为「深海」，装备者释放狂气爆发后，触腕伤害 <WeaponEffect_Num:+[DescArg1]>。"
  },
  State_3532_Desc = {
    Text = "回合开始时获得 [StateArg1] 算力。"
  },
  State_3532_Name = {
    Text = "造物黑烛1"
  },
  State_3533_Desc = {
    Text = "一定在起始手牌中出现。"
  },
  State_3533_Name = {
    Text = "<GuyouKeywords:固有>"
  },
  State_3533_WeaponDesc = {
    Text = "战斗开始后该卡固定在手牌中。"
  },
  State_3535_Desc = {
    Text = "卡牌算力消耗增加 [Layer] 点。回合结束或打出卡牌后该负面效果会被移除。"
  },
  State_3535_Name = {
    Text = "<SlowColour:临时迟缓 [Layer]>"
  },
  State_3535_WeaponDesc = {
    Text = "卡牌算力消耗增加 [Layer]点。"
  },
  State_3536_Name = {
    Text = "首领战可使用 3 次"
  },
  State_3537_Desc = {
    Text = "获得\"天真的回礼\"时可进行一次刻印"
  },
  State_3537_Name = {
    Text = "状态@章一_共鸣4"
  },
  State_3537_WeaponDesc = {
    Text = "获得\"天真的回礼\"时可进行一次刻印"
  },
  State_3538_Desc = {
    Text = "使用“天真的回礼”回复狂气增加"
  },
  State_3538_Name = {
    Text = "状态@章一_共鸣1"
  },
  State_3538_WeaponDesc = {
    Text = "使用“天真的回礼”回复狂气增加"
  },
  State_3539_Desc = {
    Text = "“天真的回礼”算力消耗减1"
  },
  State_3539_Name = {
    Text = "状态@章一_共鸣3"
  },
  State_3539_WeaponDesc = {
    Text = "“天真的回礼”算力消耗减1"
  },
  State_3540_Desc = {
    Text = "“天真的回礼”可指定目标"
  },
  State_3540_Name = {
    Text = "状态@章一_共鸣2"
  },
  State_3540_WeaponDesc = {
    Text = "“天真的回礼”可指定目标"
  },
  State_3541_Desc = {
    Text = "库姆落入了你们布设的陷阱。"
  },
  State_3541_Name = {
    Text = "身陷陷阱"
  },
  State_3542_Desc = {
    Text = "战斗开始时，卡组中每拥有 1 个刻印，获得 [Arg1] 点力量，每拥有 1 个造物，回复 [Arg2] 点生命。"
  },
  State_3542_Name = {
    Text = "☆商会勋章☆"
  },
  State_3545_Name = {
    Text = "无边星彩抵抗"
  },
  State_3545_WeaponDesc = {
    Text = "每出 1 张牌获得 [StateArg1]% 死亡抵抗。获得死亡抵抗时，回复 [StateArg2] 生命。"
  },
  State_3546_Desc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 [Layer] 层【束缚】。"
  },
  State_3546_Name = {
    Text = "「东区特供」"
  },
  State_3546_WeaponDesc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 [Layer] 层【束缚】。"
  },
  State_3547_Desc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 [Layer] 层【束缚】。"
  },
  State_3547_Name = {
    Text = "「东区特供」"
  },
  State_3547_WeaponDesc = {
    Text = "我方队伍每打出 1 张卡牌，就对其施加 [Layer] 层【束缚】。"
  },
  State_3548_Desc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3548_Name = {
    Text = "状态诅咒衰弱"
  },
  State_3548_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_3549_Name = {
    Text = "状态饰品荒原狼"
  },
  State_3549_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 10%。若装备者伤害强效大于 20%，基础伤害额外提高 10%。"
  },
  State_35503_Name = {
    Text = "时灵摆「蔓延」"
  },
  State_3551_Desc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 [StateArg1] 张，获得 [StateArg2] 点算力。"
  },
  State_3551_Name = {
    Text = "造物银白差分机"
  },
  State_3551_WeaponDesc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 [StateArg1] 张，获得 [StateArg2] 点算力。"
  },
  State_35539_Desc = {
    Text = "受到的伤害翻倍，持续 [Layer] 回合。"
  },
  State_35539_Name = {
    Text = "行道之骸"
  },
  State_3553_Desc = {
    Text = "暴击率提高 25%。造成生命回复后，有几率额外造成 1 次生命回复，概率等于造成回复者的暴击率。"
  },
  State_3553_Name = {
    Text = "状态@幻梦银钥：暴击治疗"
  },
  State_3554_Desc = {
    Text = "护盾和治疗的效果提高[Layer] %"
  },
  State_3554_Name = {
    Text = "护盾和治疗强效"
  },
  State_3554_WeaponDesc = {
    Text = "护盾和治疗的效果提高[Layer] %"
  },
  State_3555_Desc = {
    Text = "拾取时获得 100% 死亡抵抗。触发死亡抵抗后，本场战斗每回合开始时回复 [Arg1] 点生命。"
  },
  State_3555_Name = {
    Text = "人工呼吸"
  },
  State_3556_Desc = {
    Text = "拾取该造物时选择一张卡牌，将一张它的复制加入牌库。"
  },
  State_3558_Desc = {
    Text = "回合开始时若黑印大于 10，消耗 10 黑印，当回合造成的伤害翻倍。"
  },
  State_3559_Desc = {
    Text = "造成未被格挡的伤害时，造成 1 层脆弱。"
  },
  State_3559_Name = {Text = "利爪"},
  State_3559_WeaponDesc = {
    Text = "造成实际伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_3561_Name = {
    Text = "状态@幻梦银钥：乱斩计数"
  },
  State_3562_Desc = {
    Text = "死亡后，其他友方力量提高[Layer]。"
  },
  State_3562_Name = {Text = "死语"},
  State_35635_Name = {
    Text = "状态@唤醒体卡茜亚隔空取物允许发动"
  },
  State_35636_Name = {
    Text = "状态@唤醒体卡茜亚添加隔空取物"
  },
  State_3563_Desc = {
    Text = "造成未被格挡的伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_3563_Name = {Text = "利刃"},
  State_3563_WeaponDesc = {
    Text = "造成实际伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_35645_Desc = {
    Text = "本回合抽牌数量减少 [Layer] 。"
  },
  State_35645_Name = {
    Text = "抽牌降低"
  },
  State_35646_Desc = {
    Text = "本回合抽牌数量减少 [Layer] 。"
  },
  State_35646_Name = {
    Text = "抽牌降低"
  },
  State_3564_Desc = {
    Text = "打出后获得 [StateArg1] 点临时力量，该刻印卡牌也能享受力量加成。"
  },
  State_3564_Name = {
    Text = "<Rune_15_High:高级爆发>"
  },
  State_3565_Desc = {
    Text = "雕砌者施加护盾时，提高 [StateArg1] 触腕伤害。"
  },
  State_3565_Name = {
    Text = "忘我之境"
  },
  State_3565_WeaponDesc = {
    Text = "雕砌者施加护盾时，提高 [StateArg1] 触腕伤害。"
  },
  State_3566_Desc = {
    Text = "回合开始时获得 3 临时力量，[狂气爆发]将这个临时力量翻倍，最多堆叠 2 次。"
  },
  State_3566_Name = {
    Text = "造物怪蛇残蜕"
  },
  State_3567_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3567_Name = {
    Text = "状态@试作激光炮暴击"
  },
  State_35684_Desc = {
    Text = "我方队伍释放狂气爆发后，自身当回合失去力量。一回合一次。"
  },
  State_35684_Name = {
    Text = "畏惧狂气"
  },
  State_35685_Desc = {
    Text = "释放本源降临时，降低敌人的临时力量。"
  },
  State_35685_Name = {
    Text = "畏惧狂气"
  },
  State_3568_Desc = {
    Text = "拉蒙娜造成伤害时，获得 [StateArg1] 算力。"
  },
  State_3568_Name = {
    Text = "第一哲学"
  },
  State_3568_WeaponDesc = {
    Text = "拉蒙娜造成伤害时，获得 [StateArg1] 算力。"
  },
  State_3570_Name = {
    Text = "下一回合开始时抽牌数+2"
  },
  State_3571_Name = {
    Text = "临时免疫虚弱"
  },
  State_3572_Desc = {
    Text = "其召唤的怪物伤害翻倍。"
  },
  State_3572_Name = {Text = "号令者"},
  State_3572_WeaponDesc = {
    Text = "其召唤的怪物伤害翻倍。"
  },
  State_3573_Desc = {
    Text = "每个回合首次受到的伤害翻5倍。"
  },
  State_3573_Name = {Text = "自傲"},
  State_3573_WeaponDesc = {
    Text = "每个回合首次受到的伤害翻倍。"
  },
  State_3574_Desc = {
    Text = "每当连续打出同一个唤醒体的牌，该唤醒体获得 10 狂气。"
  },
  State_35768_Name = {
    Text = "获得 300 点银钥能量"
  },
  State_35769_Name = {
    Text = "获得 1 点算力"
  },
  State_35770_Name = {
    Text = "驱散自身<IntoxicationIconKeywords:中毒>、封印、<SlowIconKeywords:迟缓>状态"
  },
  State_35771_Name = {
    Text = "获得 [DescArg1]%(<Block:[DescArg2]>) 最大生命的护盾"
  },
  State_35772_Name = {
    Text = "首领战可额外使用 [StateArg1] 次"
  },
  State_35774_Desc = {
    Text = "死亡前呼唤一次希莱斯特的援助，回复所有生命、狂气、银钥能量。"
  },
  State_35774_Name = {
    Text = "乌托邦帷幕"
  },
  State_3577_Name = {
    Text = "狂气自动回复提升"
  },
  State_35809_Desc = {
    Text = "造成的伤害降低 [StateArg1]%，持续 [Layer] 回合。"
  },
  State_35809_Name = {
    Text = "虚妄继承者"
  },
  State_35809_WeaponDesc = {
    Text = "状态@深海淑女红茶与蛋糕"
  },
  State_3580_Desc = {
    Text = "[Layer] 回合内触腕造成的伤害为穿刺伤害。"
  },
  State_3580_Name = {
    Text = "穿刺触腕"
  },
  State_35811_Desc = {
    Text = "受到主动或触腕伤害时，获得伤害一半的<SacrificeKeyWord:献祭>，持续 [Layer] 回合。"
  },
  State_35811_Name = {
    Text = "虚妄继承者"
  },
  State_35819_Desc = {
    Text = "回合结束时墨菲获得 5 点狂气。释放钥令后，移除 2% 最大生命的<SacrificeKeyWord:献祭>。"
  },
  State_35819_Name = {
    Text = "红茶与蛋糕"
  },
  State_3581_Desc = {
    Text = "状态@红夫人权欲轮舞计数"
  },
  State_3581_Name = {
    Text = "状态@红夫人权欲轮舞计数"
  },
  State_3582_Desc = {
    Text = "即使不在超维回合，每回合也能够触发一次跃迁效果。触发时抽一张对应唤醒体的牌。"
  },
  State_3582_Name = {
    Text = "异化空间偏折仪"
  },
  State_3582_WeaponDesc = {
    Text = "即使不在超维回合，每回合也能够触发一次跃迁效果。触发时抽一张对应唤醒体的牌。"
  },
  State_3584_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3584_Name = {
    Text = "状态@试作小刀界域"
  },
  State_35858_Desc = {
    Text = "回合结束时墨菲获得 5 点狂气。释放钥令后，获得墨菲 3% 攻击力的触腕伤害。"
  },
  State_35858_Name = {
    Text = "红茶与蛋糕"
  },
  State_3585_Desc = {
    Text = "生命低于 50%([StateArg1]) 时，「提灯教牧」将会祈求「神降」，吸收所有教众后狂暴。"
  },
  State_3585_Name = {
    Text = "灯芯的烙印"
  },
  State_3585_WeaponDesc = {
    Text = "生命低于 50%([StateArg1]) 时，「提灯教牧」将会祈求「神降」，吸收所有教众后狂暴。"
  },
  State_3588_Name = {
    Text = "造物阿尔卡纳遗物算力"
  },
  State_3589_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并减少 1 层。"
  },
  State_3589_Name = {
    Text = "<ParcloseColour: 屏障>"
  },
  State_3591_Desc = {
    Text = "队伍唯一：装备者造成的<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg1]%>。「防御」获得等同于装备者防御力  <WeaponEffect_Num:[StateArg2]%> 的临时反击，在首领战中，改为获得 3 倍临时反击。死亡抵抗触发后，对所有敌人触发 [StateArg3]％ <RetaliateIconKeywords:反击>。"
  },
  State_3591_Name = {
    Text = "伏于夜色"
  },
  State_3591_WeaponDesc = {
    Text = "装备者造成的<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg1]%>。打出「防御」后获得 <WeaponEffect_Num:[Counterattack:DescArg1]> 层临时反击，在首领战中，改为获得 3 倍临时反击。死亡抵抗触发后，对所有敌人触发 [StateArg3]％ <RetaliateIconKeywords:反击>。"
  },
  State_3592_Desc = {
    Text = "提高触腕造成的伤害。"
  },
  State_3592_Name = {
    Text = "<TentacleInjurieIconKeywords:触腕伤害>"
  },
  State_3592_WeaponDesc = {
    Text = "增加触腕造成的伤害量。"
  },
  State_3593_Desc = {
    Text = "队伍唯一：装备者造成的<IntoxicationIconKeywords:中毒>提高<WeaponEffect_Num:[StateArg1]%>。「打击」对目标敌人造成等同于攻击力 <WeaponEffect_Num:[StateArg2]%> 的<IntoxicationIconKeywords:中毒>。该效果每回合最多生效 3 次。"
  },
  State_3593_WeaponDesc = {
    Text = "装备者造成的<IntoxicationIconKeywords:中毒>提高<WeaponEffect_Num:[StateArg1]%>。「打击」对目标敌人造成 <WeaponEffect_Num:[Poison:DescArg1]> 层<IntoxicationIconKeywords:中毒>。该效果每回合最多生效 3 次。"
  },
  State_3596_Name = {
    Text = "残留的银芯"
  },
  State_35970_Desc = {
    Text = "死亡后，对玩家施加 1 回合的<VulnerabilityIconKeywords:易伤>。"
  },
  State_35970_Name = {Text = "早夭"},
  State_35971_Desc = {
    Text = "登场时，获得等同于最大生命 50% 的护盾。"
  },
  State_35971_Name = {Text = "卵壳"},
  State_3597_Name = {
    Text = "残留的银芯"
  },
  State_3598_Name = {
    Text = "残留的银芯"
  },
  State_3599_Desc = {
    Text = "打出 1 张实际算力消耗为 4 或以上的卡牌时，其他手牌算力消耗降低 1"
  },
  State_36006_Desc = {
    Text = "死亡后会在原地生成「睡梦之子」。"
  },
  State_36006_Name = {Text = "受肉"},
  State_3600_Name = {
    Text = "残留的银芯"
  },
  State_36013_Desc = {
    Text = "此状态也视为<SacrificeKeyWord:献祭>，下个回合开始时获得 [Layer] 层<SacrificeKeyWord:献祭>状态。"
  },
  State_36013_Name = {
    Text = "<BlueKeyWord:延迟献祭>"
  },
  State_36014_Desc = {
    Text = "回合结束时受到 [Layer] 点伤害并减少 50% <SacrificeKeyWord:献祭>层数。"
  },
  State_36014_Name = {
    Text = "<BlueKeyWord:献祭>"
  },
  State_3601_Name = {
    Text = "状态@幻梦银钥：轮舞计数"
  },
  State_36022_Desc = {
    Text = "受到来自<SacrificeKeyWord:献祭>以外的伤害时，获得伤害 50% 的<SacrificeKeyWord:献祭>。"
  },
  State_36022_Name = {Text = "拜谒"},
  State_36023_Desc = {
    Text = "死亡后若存在其他友方，生成「水之子」。"
  },
  State_36023_Name = {Text = "受肉"},
  State_36024_Desc = {
    Text = "死亡后若存在其他友方，生成「睡梦之子」。"
  },
  State_36024_Name = {Text = "受肉"},
  State_3603_Name = {
    Text = "首领战中可使用2次且首次使用后回手"
  },
  State_3604_Desc = {
    Text = "队伍由不同职业的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%"
  },
  State_3604_Name = {
    Text = "状态@混搭加成"
  },
  State_3604_WeaponDesc = {
    Text = "队伍由不同职业的唤醒体组成时，队伍生命与所有唤醒体的攻击与防御提高 200%"
  },
  State_3607_Desc = {
    Text = "打出后使唤醒体在本场战斗中获得特殊的能力提升。重复打出灵知觉醒无法叠加生效。"
  },
  State_3607_Name = {
    Text = "<ExaltIconKeywords:灵知觉醒>"
  },
  State_3607_WeaponDesc = {
    Text = "灵知觉醒打出后可以让唤醒体在本场战斗中获得特殊的能力提升。但重复打出的灵知觉醒不可叠加生效。"
  },
  State_3608_Name = {
    Text = "所有友方获得[StateArg1]点狂气"
  },
  State_36092_Desc = {
    Text = "死亡后若存在其他友方，则在原地生成「水之子」。"
  },
  State_36092_Name = {Text = "受肉"},
  State_36093_Desc = {
    Text = "每失去 1 点生命降低 1 层，当层数为 0 时，在怪物回合结束后，将会召唤 1 个「水之子」并重新获得 [DescArg1] 层「水之寄主」，最多存在 4 个「水之子」。"
  },
  State_36093_Name = {
    Text = "水之寄主"
  },
  State_36094_Desc = {
    Text = "每失去 1 点生命降低 1 层，当层数为0时，召唤 1 个「灵觉之子」，并重新获得 [DescArg1] 层「珊瑚寄主」，最多存在 4 个。"
  },
  State_36094_Name = {
    Text = "灵觉寄主"
  },
  State_3609_Name = {
    Text = "首领战中可使用2次且首次使用后回到手牌，重新抽取的牌本回合算力消耗降低 1"
  },
  State_36111_Desc = {
    Text = "死亡后，将 1 张「珊瑚赘生」加入玩家手中。"
  },
  State_36111_Name = {
    Text = "珊瑚赘生"
  },
  State_3611_Desc = {
    Text = "状态@序章怪物被动12"
  },
  State_3611_Name = {
    Text = "状态@序章怪物被动12"
  },
  State_3611_WeaponDesc = {
    Text = "状态@序章怪物被动12"
  },
  State_36124_Desc = {
    Text = "回合结束后受到 [Layer] 点伤害并减少 50% 「献祭」层数。"
  },
  State_36124_Name = {
    Text = "<BlueKeyWord:献祭>"
  },
  State_3612_Desc = {
    Text = "状态@序章怪物被动13"
  },
  State_3612_Name = {
    Text = "状态@序章怪物被动13"
  },
  State_3612_WeaponDesc = {
    Text = "状态@序章怪物被动13"
  },
  State_36136_Name = {
    Text = "在手中时，每打出 1 张其他卡牌，就受到 [StateArg1] 点<FixedDamage:纯粹伤害>。"
  },
  State_3613_Desc = {
    Text = "状态@序章怪物被动10"
  },
  State_3613_Name = {
    Text = "状态@序章怪物被动10"
  },
  State_3613_WeaponDesc = {
    Text = "状态@序章怪物被动10"
  },
  State_3614_Desc = {
    Text = "状态@序章怪物被动11"
  },
  State_3614_Name = {
    Text = "状态@序章怪物被动11"
  },
  State_3614_WeaponDesc = {
    Text = "状态@序章怪物被动11"
  },
  State_36152_Desc = {
    Text = "回合结束时受到等量层数的伤害，然后移除 50% <SacrificeKeyWord:献祭>层数。献祭会继承至下场战斗。"
  },
  State_36152_Name = {
    Text = "<SacrificeKeyWord:献祭>"
  },
  State_3615_Desc = {
    Text = "状态@序章怪物被动16"
  },
  State_3615_Name = {
    Text = "状态@序章怪物被动16"
  },
  State_3615_WeaponDesc = {
    Text = "状态@序章怪物被动16"
  },
  State_3616_Desc = {
    Text = "状态@序章怪物被动14"
  },
  State_3616_Name = {
    Text = "状态@序章怪物被动14"
  },
  State_3616_WeaponDesc = {
    Text = "状态@序章怪物被动14"
  },
  State_36173_Name = {
    Text = "首领战可使用 [DescArg1] 次"
  },
  State_36174_Name = {
    Text = "（还剩 [Layer] 次）"
  },
  State_3617_Desc = {
    Text = "状态@序章怪物被动15"
  },
  State_3617_Name = {
    Text = "状态@序章怪物被动15"
  },
  State_3617_WeaponDesc = {
    Text = "状态@序章怪物被动15"
  },
  State_36182_Name = {
    Text = "获得 [DescArg1]%(<Block:[DescArg2]>) 最大生命的护盾并回复等量的生命，护盾随已损生命提高"
  },
  State_3618_Desc = {
    Text = "受到实际伤害时获得护盾。"
  },
  State_3618_Name = {Text = "缓冲"},
  State_3618_WeaponDesc = {
    Text = "受到实际伤害时获得护盾。"
  },
  State_36196_Desc = {
    Text = "萝坦的「打击」伤害提高 30%。"
  },
  State_36196_Name = {
    Text = "不羁的剑风"
  },
  State_3619_Desc = {
    Text = "状态@青炎舞者打击防御"
  },
  State_3619_Name = {
    Text = "状态@青炎舞者打击防御"
  },
  State_3619_WeaponDesc = {
    Text = "状态@青炎舞者打击防御"
  },
  State_3620_Desc = {
    Text = "每当获得症状卡后，使最大生命提高 [Arg1] 点。"
  },
  State_3621_Desc = {
    Text = "原初信徒每打出 1 张牌，抽 [StateArg1] 张牌，触发所有敌人 5% 的中毒。"
  },
  State_3621_Name = {
    Text = "湮塞的执念"
  },
  State_3621_WeaponDesc = {
    Text = "原初信徒每打出 1 张牌，抽 [StateArg1] 张牌"
  },
  State_3622_Desc = {
    Text = "强化「暴走猎颅者」和「死者」的技能效果，每回合开始时获得 [StateArg1] 点临时力量，每层「狩猎印记」再提高 [StateArg1] 点。"
  },
  State_3622_Name = {
    Text = "狩猎印记"
  },
  State_36242_Desc = {
    Text = "战斗开始后获得 [StateArg1] 点护盾。失去生命后，「圣婴」将会结束酣睡，开始啼哭。"
  },
  State_36242_Name = {Text = "酣眠"},
  State_3624_Desc = {
    Text = "状态@知者攻势推演力量降低"
  },
  State_3624_Name = {
    Text = "状态@知者攻势推演力量降低"
  },
  State_3625_Desc = {
    Text = "当你拥有护盾时，造成的伤害提高 [Arg1]。在你的护盾高于当前生命时，造成的伤害额外提高 [Arg2]。"
  },
  State_36263_Desc = {
    Text = "不再受到伤害，准备释放「受诞之种」。"
  },
  State_36263_Name = {Text = "免疫"},
  State_3628_Name = {
    Text = "状态@打出后破防"
  },
  State_3629_Name = {
    Text = "抽 2 张牌"
  },
  State_3630_Name = {
    Text = "对所有敌人施加 2 层<VulnerabilityIconKeywords:易伤>"
  },
  State_36315_Desc = {
    Text = "回合结束时获得 [Layer] 点力量。"
  },
  State_36315_Name = {Text = "蒙恩"},
  State_3631_Name = {
    Text = "获得 2 点算力"
  },
  State_3632_Name = {
    Text = "获得 <Energy:[DescArg1]> 点狂气"
  },
  State_36332_Desc = {
    Text = "每回合开始时，选择获得 1 层神母权能或者消耗神母权能获得墨菲的 1 次帮助。"
  },
  State_36332_Name = {
    Text = "神母权能"
  },
  State_36334_Desc = {
    Text = "每回合结束时获得 1 条触腕。"
  },
  State_36334_Name = {
    Text = "螺湮呼唤"
  },
  State_3633_Name = {
    Text = "对所有敌人施加 2 层<WeaknessIconKeywords:虚弱>"
  },
  State_36346_Desc = {
    Text = "当生命降低至 0 时，使生命变为 1 点，不再受到伤害，准备释放「受诞之种」。"
  },
  State_36346_Name = {
    Text = "受诞之种"
  },
  State_3634_Name = {
    Text = "将 2 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆"
  },
  State_3635_Name = {
    Text = "其他唤醒体获得 <Energy:[DescArg1]> 点狂气"
  },
  State_36360_Desc = {
    Text = "回合开始后有 [DescArg1]% 概率获得 1 层触腕集结，超过 100% 时可获得多层。"
  },
  State_36360_Name = {Text = "海归线"},
  State_36361_Desc = {
    Text = "登场时，其他友方获得 [Layer] 点力量。"
  },
  State_36361_Name = {
    Text = "神降畸变"
  },
  State_3636_Desc = {
    Text = "状态@造物蛊惑风铃生效"
  },
  State_3636_Name = {
    Text = "状态@造物蛊惑风铃生效"
  },
  State_3637_Desc = {
    Text = "当你的生命低于 25% 且未死亡时，立刻回复 [Arg1] 点生命。触发 3 次后永久失效。"
  },
  State_3637_Name = {
    Text = "☆应急食品☆"
  },
  State_3638_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并减少 1 层。"
  },
  State_3638_Name = {
    Text = "<ParcloseColour: 屏障>"
  },
  State_3638_WeaponDesc = {
    Text = "承受的伤害降低 99%，每承受 1 次伤害减少 1 层。"
  },
  State_3639_Desc = {
    Text = "拉蒙娜造成伤害时，获得 [StateArg1] 算力。"
  },
  State_3639_Name = {
    Text = "第三哲学"
  },
  State_3639_WeaponDesc = {
    Text = "拉蒙娜造成伤害时，获得 [StateArg1] 算力。"
  },
  State_3641_Desc = {
    Text = "在“未完的蜡像”处选择一张卡算力减1"
  },
  State_3641_Name = {
    Text = "状态@章二_共鸣_基本效果"
  },
  State_3641_WeaponDesc = {
    Text = "在“未完的蜡像”节点复制卡牌的等级+1"
  },
  State_3642_Desc = {
    Text = "每当你失去生命，就获得 [Arg1] 层反击。若为单个回合内的第 3 次触发，对所有敌人造成 1 次反击伤害。"
  },
  State_3642_Name = {
    Text = "故人的怀表"
  },
  State_3646_Desc = {
    Text = "生命值无法降低值1以下，受到致命伤害时，将意图替换为绝境求生。【绝境求生】：恢复最大生命100%，力量翻倍，强化后续技能。"
  },
  State_3646_Name = {
    Text = "绝境求生"
  },
  State_3647_Name = {
    Text = "造物阿尔卡纳记录计数"
  },
  State_3648_Desc = {
    Text = "队伍唯一：装备者生命回复效果提高 <WeaponEffect_Num:[StateArg2]%> 。回合开始时，获得等同于上回合损失生命 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>和护盾。"
  },
  State_3648_WeaponDesc = {
    Text = "装备者生命回复效果提高 <WeaponEffect_Num:[StateArg2]%> 。回合开始时，获得等同于上回合损失生命 <WeaponEffect_Num:[StateArg1]%> 的临时<PowerIconKeywords:力量>和护盾。"
  },
  State_3649_Desc = {
    Text = "队伍中每有一名【超维】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_3649_Name = {
    Text = "超维加成"
  },
  State_3649_WeaponDesc = {
    Text = "队伍中每有一名【超维】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_3651_Desc = {
    Text = "打出前改变卡牌算力"
  },
  State_3651_Name = {
    Text = "打出前改变卡牌算力"
  },
  State_3651_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_3652_Desc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 [StateArg1] 张，抽 [StateArg2] 张牌。"
  },
  State_3652_Name = {
    Text = "造物魔术手套"
  },
  State_3652_WeaponDesc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 [StateArg1] 张，抽 [StateArg2] 张牌。"
  },
  State_3653_Name = {
    Text = "造物残破战旗2"
  },
  State_3654_Desc = {
    Text = "回合开始后获得 [Layer]% 临时暴击率。"
  },
  State_3654_Name = {
    Text = "绵音渐响"
  },
  State_3654_WeaponDesc = {
    Text = "直到下回合开始前未损失生命，下回合暴击率 +[StateArg1]%。"
  },
  State_3656_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3656_Name = {
    Text = "尚未觉醒"
  },
  State_3658_Desc = {
    Text = "打出手牌中最后 1 张牌时，抽 2 张牌。每回合最多触发 2 次。"
  },
  State_3659_Name = {
    Text = "状态@打击卡暴击率暴击伤害提高"
  },
  State_36613_Name = {
    Text = "状态@饰品机械降神计数"
  },
  State_3661_Desc = {
    Text = "受到实际伤害提升深度融蚀层数"
  },
  State_3661_Name = {
    Text = "受到伤害提升深度融蚀层数"
  },
  State_3661_WeaponDesc = {
    Text = "受到实际伤害提升深度融蚀层数"
  },
  State_3662_Desc = {
    Text = "本场战斗内暴击伤害提高 [Layer] %。"
  },
  State_3662_Name = {
    Text = "暴击伤害"
  },
  State_3662_WeaponDesc = {
    Text = "本场战斗内暴击伤害提高 [Layer] %。"
  },
  State_36631_Desc = {
    Text = "每次释放狂气爆发增加 1 层「孕育」，每层孕育获得 [StateArg1] 点力量，上限为 5 层。"
  },
  State_36631_Name = {
    Text = "假孕寄主"
  },
  State_36635_Desc = {
    Text = "每次释放狂气爆发增加 1 层「孕育」，每层孕育获得 [StateArg1] 点力量，上限为 5 层。"
  },
  State_36635_Name = {
    Text = "利莫里亚的最终降神"
  },
  State_36636_Desc = {
    Text = "当达到 5 层时，将会释放「利莫里亚的荣光！」，造成高额伤害并呼唤眷族。"
  },
  State_36636_Name = {Text = "孕育"},
  State_36637_Desc = {
    Text = "当达到 5 层时，将会释放「为了利莫里亚！」，造成高额伤害并呼唤眷族。"
  },
  State_36637_Name = {Text = "孕育"},
  State_3663_Desc = {
    Text = "每回合第一次打出卡牌后，将对应唤醒体的一张「打击」置入手中。"
  },
  State_3664_Desc = {
    Text = "打出后获得5点狂气。"
  },
  State_3664_Name = {Text = "追念"},
  State_3664_WeaponDesc = {
    Text = "打出后获得5点狂气。"
  },
  State_3665_Desc = {
    Text = "当胚胎融合达到上限后，将一张「胚胎」置入手中。"
  },
  State_3665_Name = {
    Text = "<EmbryoFusionIconKeywords:胚胎融合>"
  },
  State_3666_Desc = {
    Text = "暴击率提高 [Layer] %。"
  },
  State_3666_Name = {Text = "暴击率"},
  State_3666_WeaponDesc = {
    Text = "暴击率提高 [Layer] %。"
  },
  State_36670_Name = {
    Text = "状态@饰品再衍化计数"
  },
  State_36670_WeaponDesc = {
    Text = "装备者回合结束后获得 3 点狂气。若装备者狂气回充大于 10 ，额外获得 2 点狂气。"
  },
  State_3667_Desc = {
    Text = "队伍唯一：装备者造成的<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg4]%> 。装备者打出卡牌后获得等同于装备者防御力 <WeaponEffect_Num:[StateArg1]%> 的<RetaliateIconKeywords:反击>，每回合最多 2 次，若其进入超维空间，装备者还会获得 <WeaponEffect_Num:[StateArg2]> 点狂气。释放狂气爆发后，所有敌人失去等同于装备者防御力 <WeaponEffect_Num:[StateArg3]%> 的临时力量。"
  },
  State_3667_WeaponDesc = {
    Text = "装备者造成的<RetaliateIconKeywords:反击>提高 <WeaponEffect_Num:[StateArg4]%>。装备者打出卡牌后获得 <WeaponEffect_Num:[Counterattack:DescArg1]> 点<RetaliateIconKeywords:反击>，每回合最多触发 2 次，若其进入超维空间，装备者还会获得 <WeaponEffect_Num:[StateArg2]> 点狂气。释放狂气爆发后，所有敌人临时降低 <WeaponEffect_Num:[Power:DescArg2]> 点力量。"
  },
  State_3668_Desc = {
    Text = "状态@异化花园守护者标识"
  },
  State_3668_Name = {
    Text = "状态@异化花园守护者标识"
  },
  State_3668_WeaponDesc = {
    Text = "状态@异化花园守护者标识"
  },
  State_3669_Desc = {
    Text = "免疫虚弱、脆弱和易伤状态，持续[Layer] 回合。"
  },
  State_3669_Name = {
    Text = "<BlessingColour: 祝福>"
  },
  State_3669_WeaponDesc = {
    Text = "[Layer] 回合内免疫被施加的负面状态。"
  },
  State_36710_Name = {
    Text = "凸月之舞"
  },
  State_3673_Desc = {
    Text = "拾取时选择 2 张卡牌删除，获得 [StateArg1] 力量。"
  },
  State_3673_Name = {
    Text = "造物黑星燃烧之烬"
  },
  State_3674_Desc = {
    Text = "回合结束时，降低所有唤醒体 10 狂气。"
  },
  State_3674_Name = {Text = "寂灭"},
  State_3674_WeaponDesc = {
    Text = "回合结束时，降低所有唤醒体 10 狂气。"
  },
  State_3675_Name = {
    Text = "抽取弃牌数+ 1 张牌"
  },
  State_3676_Desc = {
    Text = "在对手回合时，受到伤害降低 [Layer] %。"
  },
  State_3676_Name = {Text = "机警"},
  State_3676_WeaponDesc = {
    Text = "我方队伍回合时怪物获得 [Layer] %减伤"
  },
  State_3677_Desc = {
    Text = "提高[Layer]%防御力。"
  },
  State_3677_Name = {
    Text = "临时防御力百分比提高"
  },
  State_3677_WeaponDesc = {
    Text = "提高[Layer]%防御力。"
  },
  State_36781_Desc = {
    Text = "力量被降低时，仅会降低 50% 的力量层数。"
  },
  State_36781_Name = {
    Text = "渴求受肉之意志"
  },
  State_3678_Name = {
    Text = "状态@事件造物1"
  },
  State_36797_Desc = {
    Text = "本回合内，触腕伤害降低 [Layer] 点。"
  },
  State_36797_Name = {
    Text = "触腕伤害降低"
  },
  State_3679_Name = {
    Text = "状态@事件造物2"
  },
  State_3680_Desc = {
    Text = "每造成 1 次伤害，对目标施加 [Arg1] 层中毒。若本场战斗内触发次数累计达 25 次，立刻触发全体敌方中毒。"
  },
  State_3681_Desc = {
    Text = "造成未被格挡的伤害时，对随机 2 张「指令卡」上施加 [DescArg1] 层<BrokenCard:暗中破坏>。"
  },
  State_3681_Name = {
    Text = "詹金觉醒！"
  },
  State_3681_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_3682_Desc = {
    Text = "生命每下降 10%，所有唤醒体获得 10 狂气，死亡后加触腕伤害。"
  },
  State_3682_Name = {
    Text = "深埋的银芯"
  },
  State_3682_WeaponDesc = {
    Text = "生命每下降 10%，所有唤醒体获得 10 狂气，死亡后加触腕伤害。"
  },
  State_3683_Desc = {
    Text = "队伍唯一：装备者指令卡造成的治疗提高 <WeaponEffect_Num:[StateArg2]%>。装备者释放「狂气爆发」前，其他唤醒体获得 <WeaponEffect_Num:[StateArg1]> 点狂气。若我方队伍处于<VulnerabilityIconKeywords:易伤>状态，效果翻倍。"
  },
  State_3683_WeaponDesc = {
    Text = "装备者指令卡造成的治疗提高 <WeaponEffect_Num:[StateArg2]%>。装备者释放狂气爆发前，其他唤醒体获得 <WeaponEffect_Num:[StateArg1]> 点狂气。若我方队伍处于<VulnerabilityIconKeywords:易伤>状态，效果翻倍。"
  },
  State_3684_Desc = {
    Text = "每受到 1 点伤害降低 1 层。层数为 0 后，将意图替换为不灭之花，并使用偏向防御的技能组。"
  },
  State_3684_Name = {
    Text = "不灭之花"
  },
  State_3684_WeaponDesc = {
    Text = "每受到 1 点伤害后降低 1 层。层数为 0 后，切换为防御模式。"
  },
  State_3685_Desc = {
    Text = "抽到时失去 1 算力，抽 1 张牌。"
  },
  State_3685_Name = {Text = "迷惑"},
  State_3685_WeaponDesc = {
    Text = "抽到时失去 1 算力，抽 1 张牌。"
  },
  State_3686_Desc = {
    Text = "抽到时失去 1 算力，抽 1 张牌。"
  },
  State_3686_Name = {
    Text = "维度封印"
  },
  State_3686_WeaponDesc = {
    Text = "抽到时失去 1 算力，抽 1 张牌。"
  },
  State_36884_Desc = {
    Text = "本场战斗最后的誓言不再可以通过主动触发死亡抵抗获得护盾。"
  },
  State_36884_Name = {
    Text = "最后的誓言"
  },
  State_3688_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 2 算力。"
  },
  State_3688_Name = {
    Text = "造物阿尔卡纳记录"
  },
  State_3688_WeaponDesc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 2 算力。"
  },
  State_3689_Desc = {
    Text = "回合开始时界域精通提高 30。当不处于负面状态时，界域精通提高变为 100。"
  },
  State_3692_Desc = {
    Text = "拥有千种姿态的神秘卡牌。从中选择你最需要的吧！"
  },
  State_3692_Name = {
    Text = "<CardKeyWord:千面幻象>"
  },
  State_3692_WeaponDesc = {
    Text = "拥有千种姿态的神秘卡牌。从中选择你最需要的吧！"
  },
  State_3693_Desc = {
    Text = "暴击率提高 25%。造成生命回复后，有几率额外造成 1 次生命回复，概率等于造成回复者的暴击率。"
  },
  State_3693_Name = {
    Text = "状态@幻梦银钥：暴击治疗"
  },
  State_3696_Desc = {
    Text = "每造成 1 次伤害，本回合内获得 [Arg1] 点戒备。回合开始时每有 3 点剩余护盾，本回合内获得 1 点力量。"
  },
  State_3696_Name = {
    Text = "时灵摆「隐秘」"
  },
  State_3697_Desc = {
    Text = "回合开始时抽 1 张牌。连续 2 次打出和上一张卡牌算力相同的牌时，额外抽 1 张牌。"
  },
  State_3698_Desc = {
    Text = "打出后将卡牌的 [StateArg1] 张复制加入临时<DimensionalSpaceIconKeywords:超维空间>。"
  },
  State_3698_Name = {
    Text = "<Rune_13:折跃>"
  },
  State_3699_Name = {
    Text = "残留的银芯"
  },
  State_3700_Desc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_3700_Name = {
    Text = "临时攻击力百分比提高"
  },
  State_3700_WeaponDesc = {
    Text = "提高[Layer]%攻击力。"
  },
  State_3702_Desc = {
    Text = "状态@通用改变最大生命"
  },
  State_3702_Name = {
    Text = "状态@通用改变最大生命"
  },
  State_3702_WeaponDesc = {
    Text = "状态@通用改变最大生命"
  },
  State_3703_Name = {
    Text = "状态@第四章共鸣@生效下回合抽牌数2"
  },
  State_3704_Desc = {
    Text = "界域精通提高 30。拾取时选择一个造物，将其更换为随机造物。"
  },
  State_3705_Name = {
    Text = "海月启灵3"
  },
  State_3707_Desc = {
    Text = "战斗开始后将 [StateArg1] 张临时复制洗入抽牌堆，原始卡牌和镜像卡牌均获得保留。"
  },
  State_3707_Name = {
    Text = "<Rune_8:镜像>"
  },
  State_3708_Desc = {
    Text = "偶数回合结束时，每张剩余手牌使你下回合开始获得 1 算力。"
  },
  State_3708_Name = {
    Text = "造物先贤断章2"
  },
  State_3708_WeaponDesc = {
    Text = "偶数回合结束时，每张剩余手牌使你下回合开始获得 1 算力。"
  },
  State_3709_Desc = {
    Text = "奇数回合结束时，每点剩余算力使你下回合开始抽 1 张牌。"
  },
  State_3709_Name = {
    Text = "造物先贤断章1"
  },
  State_3709_WeaponDesc = {
    Text = "奇数回合结束时，每点剩余算力使你下回合开始抽 1 张牌。"
  },
  State_3711_Desc = {
    Text = "每次行动造成 [Layer] 出血"
  },
  State_3711_Name = {Text = "血溅"},
  State_3711_WeaponDesc = {
    Text = "每次行动造成 [Layer] 出血，治疗可减半出血层数。"
  },
  State_3712_Desc = {
    Text = "打出卡牌后将其消耗，指令卡产生 3 倍伤害和防护，持续 1 回合。"
  },
  State_3712_Name = {Text = "溶解"},
  State_3714_Desc = {
    Text = "打出后获得 [StateArg1] 点护盾。"
  },
  State_3714_Name = {
    Text = "<Rune_6:铁壁>"
  },
  State_3716_Desc = {
    Text = "本场战斗内暴击率提高 [Layer] %。"
  },
  State_3716_Name = {Text = "暴击率"},
  State_3719_Desc = {
    Text = "承受主动伤害时，使触腕反击伤害来源，持续 [Layer] 回合。"
  },
  State_3719_Name = {
    Text = "承自异端之血"
  },
  State_3720_Desc = {
    Text = "提高[Layer]点防御力。"
  },
  State_3720_Name = {
    Text = "通用防御力提高"
  },
  State_3720_WeaponDesc = {
    Text = "提高[Layer]点防御力。"
  },
  State_3721_Desc = {
    Text = "打出后不会进入弃牌堆，而是从牌库中移除。"
  },
  State_3721_Name = {Text = "消耗"},
  State_3721_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_3722_Desc = {
    Text = "每次造成伤害时，临时提高 [StateArg1] 触腕伤害，最多堆叠 5 次。层数满时生成 1 条触腕。"
  },
  State_3722_Name = {
    Text = "造物祭司权杖"
  },
  State_3722_WeaponDesc = {
    Text = "每次造成伤害时，临时提高 [StateArg1] 触腕伤害，最多堆叠 5 次。层数满时生成 1 条触腕。"
  },
  State_3723_Name = {
    Text = "造物黑色镜面"
  },
  State_3724_Desc = {
    Text = "拾取时失去所有其他造物，随机获得 2 个黄金造物。"
  },
  State_3726_Name = {
    Text = "扭曲的死体狂宴"
  },
  State_3728_Desc = {
    Text = "战斗开始时，获得一张[打击]。"
  },
  State_3728_Name = {
    Text = "鲸跃启灵1"
  },
  State_3728_WeaponDesc = {
    Text = "战斗开始时，获得一张[打击]。"
  },
  State_3730_Desc = {
    Text = "状态@怪物甜蜜恶鬼蜜糖色悲惨幻象"
  },
  State_3730_Name = {
    Text = "状态@怪物甜蜜恶鬼蜜糖色悲惨幻象"
  },
  State_3730_WeaponDesc = {
    Text = "状态@怪物甜蜜恶鬼蜜糖色悲惨幻象"
  },
  State_3731_Desc = {
    Text = "每当我方队伍在商店购物后，下一场战斗每回合额外抽 1 张牌，获得 1 点算力。"
  },
  State_3732_Desc = {
    Text = "每 3 个回合，获得 3 条临时触腕，该触腕无视触腕上限。"
  },
  State_3732_Name = {
    Text = "造物无名附肢"
  },
  State_3732_WeaponDesc = {
    Text = "每 3 个回合，获得 3 条临时触腕，该触腕无视触腕上限。"
  },
  State_3733_Desc = {
    Text = "奇数回合结束时，剩余算力转换为下回合额外抽牌；偶数回合结束时，剩余手牌转换为下回合额外算力。"
  },
  State_3735_Name = {
    Text = "我方队伍\"中毒\"层数减半。"
  },
  State_3738_Desc = {
    Text = "回合结束时胚胎融合 +15%，若手牌中有「胚胎」，回复 [Arg1] 生命。"
  },
  State_3738_Name = {
    Text = "瘟疫诊断书"
  },
  State_3739_Name = {
    Text = "饰品有机形态效果"
  },
  State_3739_WeaponDesc = {
    Text = "装备者使用狂气爆发后，本回合内自身护盾和治疗强效翻倍。"
  },
  State_3740_Name = {
    Text = "状态@甜蜜恶鬼暴击记数"
  },
  State_3741_Desc = {
    Text = "第 3 回合开始时，将 1 张「过往回声—弃掉所有手牌，当前生命和护盾回到上回合结束时的状态。保留，消耗。」加入手中。"
  },
  State_3742_Desc = {
    Text = "打出后易伤所有敌人 [StateArg1] 回合。"
  },
  State_3742_Name = {
    Text = "<Rune_1:易伤>"
  },
  State_3743_Desc = {
    Text = "你每打出的第 6 张牌会生效 2 次。"
  },
  State_3743_Name = {
    Text = "造物群星之酒"
  },
  State_3744_Name = {
    Text = "造物孟菲斯仪式镜计数"
  },
  State_3747_Name = {
    Text = "选择 1 张抽牌堆的卡牌置入手牌"
  },
  State_3748_Name = {
    Text = "造成的伤害暴击率提高 [DescArg1]%，暴击伤害提高 [DescArg2]%"
  },
  State_3750_Name = {
    Text = "临时暴击率 +[DescArg1]%。在本场战斗中「断颈一击」和「千面幻象」的基础伤害提高 5%"
  },
  State_3751_Name = {
    Text = "获得 [StateArg1] 点<PowerIconKeywords:力量>"
  },
  State_3752_Name = {
    Text = "获得  <Posse:[DescArg1]>  点银钥能量。获得 <Block:[Block:StateArg1]> 点护盾"
  },
  State_3753_Desc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_3753_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_3753_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_3754_Desc = {
    Text = "造成主动伤害时，本回合内提高 [Arg1] 触腕伤害，最多堆叠 3 次。层数满时生成 1 条触腕，回合结束后移除。"
  },
  State_3755_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，生命回复提高 <WeaponEffect_Num:[StateArg1]%>。奇数回合结束时装备者暴击率 + <WeaponEffect_Num:[StateArg2]%>，获得  <WeaponEffect_Num:[StateArg3]> 点狂气；偶数回合结束时装备者暴击伤害  +<WeaponEffect_Num:[StateArg2]%>，获得  <WeaponEffect_Num:[StateArg4]> 银钥能量。若当前界域为「血肉」使猩红熔炉积攒上限提高  <WeaponEffect_Num:[StateArg5]%>。"
  },
  State_3755_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，生命回复提高 <WeaponEffect_Num:[StateArg1]%>。奇数回合结束时装备者暴击率 +<WeaponEffect_Num:[StateArg2]%>，获得  <WeaponEffect_Num:[StateArg3]> 点狂气；偶数回合结束时装备者暴击伤害  +<WeaponEffect_Num:[StateArg2]%>，获得  <WeaponEffect_Num:[StateArg4]> 银钥能量。若当前界域为「血肉」使猩红熔炉积攒上限提高  <WeaponEffect_Num:[StateArg5]%>。"
  },
  State_3757_Desc = {
    Text = "我方队伍每打出 1 张牌，获得 [StateArg1] 层护盾。持续 1 回合。"
  },
  State_3757_Name = {
    Text = "飞羽漫天"
  },
  State_3757_WeaponDesc = {
    Text = "我方队伍每打出 1 张牌，获得 [StateArg1] 层护盾。持续 1 回合。"
  },
  State_3759_Name = {
    Text = "机械武装1"
  },
  State_3760_Desc = {
    Text = "如果至少拥有 [StateArg1] 黑印，[狂气爆发]失去 [StateArg1] 黑印，易伤并虚弱所有敌人 1 回合。"
  },
  State_3760_Name = {
    Text = "造物厄运仪式鸟"
  },
  State_3760_WeaponDesc = {
    Text = "如果至少拥有 [StateArg1] 黑印，[狂气爆发]失去 [StateArg1] 黑印，易伤并虚弱所有敌人 1 回合。"
  },
  State_3761_Desc = {
    Text = "每当我方队伍抽到 1 张蹒跚，获得 [Layer] 点力量。"
  },
  State_3761_Name = {
    Text = "提灯仪式"
  },
  State_3761_WeaponDesc = {
    Text = "每当我方队伍抽到 1 张蹒跚，获得 [Layer] 点力量。"
  },
  State_3763_Desc = {
    Text = "窜行者每造成 1 次伤害，本回合暴击伤害提高 [StateArg3]%。"
  },
  State_3763_Name = {
    Text = "通道折叠"
  },
  State_3763_WeaponDesc = {
    Text = "窜行者每造成 1 次伤害，本回合暴击伤害提高 [StateArg3]%。"
  },
  State_3764_Name = {
    Text = "机械武装2"
  },
  State_3766_Name = {
    Text = "添加猩红力量倍数"
  },
  State_3767_Desc = {
    Text = "回合开始时对随机一名敌人造成 [Arg1] 点伤害。在本场战斗内打出 7 次「打击」后，造成伤害变为 [Arg2]。"
  },
  State_3767_Name = {
    Text = "老旧拼图"
  },
  State_3768_Desc = {
    Text = "受到的主动伤害必定暴击，回合结束后移除。"
  },
  State_3768_Name = {Text = "破绽"},
  State_3768_WeaponDesc = {
    Text = "受到的主动伤害必定暴击，回合结束后移除。"
  },
  State_3770_Name = {
    Text = "造物阿尔卡纳遗物计数"
  },
  State_3771_Desc = {
    Text = "战斗开始时，获得 3 点算力。"
  },
  State_3772_Desc = {
    Text = "复仇巨刃每造成 1 次伤害，提高等同于当前触腕伤害的临时力量。"
  },
  State_3772_Name = {
    Text = "复仇预行"
  },
  State_3773_Desc = {
    Text = "回合结束时受到等量层数的<FixedDamage:纯粹伤害>。"
  },
  State_3773_Name = {
    Text = "<IntoxicationIconKeywords:中毒>"
  },
  State_3773_WeaponDesc = {
    Text = "回合开始时受到伤害。"
  },
  State_3774_Desc = {
    Text = "每次释放狂气爆发，获得一张能够施加 [Arg1] 点中毒的「毒性侵染」。回合结束时若手中每 3 张「毒性侵染」可以合成一张触发中毒的 「毒性发作」。"
  },
  State_3776_Desc = {
    Text = "每次受到主动伤害，增加一层「警觉」。「警觉」达到 3 层时进行后退。"
  },
  State_3776_Name = {
    Text = "胆怯娃娃"
  },
  State_3776_WeaponDesc = {
    Text = "每次受到主动伤害，增加一层「警觉」。「警觉」达到 3 层时进行后退。"
  },
  State_3777_Desc = {
    Text = "打出后所属唤醒体获得 [StateArg1] 点狂气。"
  },
  State_3777_Name = {
    Text = "<Rune_5_High:高级狂化>"
  },
  State_3777_WeaponDesc = {
    Text = "打出后所属唤醒体获得 [StateArg1] 点狂气。"
  },
  State_3778_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 25%，击杀敌人后击杀者获得 20 狂气。"
  },
  State_3779_Desc = {
    Text = "触腕上限减少 2 条。回合结束时额外使所有触腕攻击 1 次。"
  },
  State_3779_Name = {
    Text = "造物苦痛圣腕"
  },
  State_3779_WeaponDesc = {
    Text = "触腕上限减少 2条。回合结束时额外使所有触腕攻击 1 次。"
  },
  State_3781_Desc = {
    Text = "回合开始时，对牌堆顶 2 张卡牌施加「凝滞诅咒」。"
  },
  State_3781_Name = {
    Text = "「深渊咒眼」"
  },
  State_3781_WeaponDesc = {
    Text = "回合开始时，对牌堆顶 2 张卡牌施加「凝滞诅咒」。"
  },
  State_3782_Desc = {
    Text = "队伍唯一：探索开始时，将一张装备者的「防御」加入牌库，装备者「防御」护盾提高  <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3782_WeaponDesc = {
    Text = "探索开始时，将一张装备者的「防御」加入牌库，装备者「防御」护盾提高  <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3783_Desc = {
    Text = "队伍唯一：装备者狂气爆发基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3783_WeaponDesc = {
    Text = "装备者狂气爆发基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3784_Desc = {
    Text = "队伍唯一：装备者指令卡基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3784_WeaponDesc = {
    Text = "装备者指令卡基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>。"
  },
  State_3786_Desc = {
    Text = "你被锁定了！打出后所有怪物获得 [StateArg1] 点临时力量，移除该指令的深潜印记。"
  },
  State_3786_Name = {
    Text = "<CardKeyWord:深潜印记>"
  },
  State_3786_WeaponDesc = {
    Text = "卡牌打出后深潜者获得 [StateArg1] 点临时力量。"
  },
  State_3787_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，所有友方获得 <WeaponEffect_Num:[StateArg1]> 狂气。"
  },
  State_3787_WeaponDesc = {
    Text = "装备者释放狂气爆发后，所有友方获得 <WeaponEffect_Num:[StateArg1]> 狂气。"
  },
  State_3788_Desc = {
    Text = "队伍唯一：探索开始时，将一张装备者的「打击」加入牌库，装备者「打击」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3788_WeaponDesc = {
    Text = "探索开始时，将一张装备者的「打击」加入牌库，装备者「打击」基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_3790_Desc = {
    Text = "状态@不定性物质计数"
  },
  State_3790_Name = {
    Text = "状态@不定性物质计数"
  },
  State_3790_WeaponDesc = {
    Text = "状态@不定性物质计数"
  },
  State_3791_Desc = {
    Text = "每当造成伤害时获得 [Arg1] 点护盾，每回合最多堆叠 5 次，层数满时将一张 「灵感」 置入手中。"
  },
  State_3792_Desc = {
    Text = "不再受到石化影响。"
  },
  State_3792_Name = {
    Text = "石化抗性"
  },
  State_3792_WeaponDesc = {
    Text = "不再受到石化作用，改为受到三倍伤害"
  },
  State_3793_Desc = {
    Text = "本次关卡内暴击伤害提高 [Layer] %。"
  },
  State_3793_Name = {
    Text = "永久暴击伤害"
  },
  State_3793_WeaponDesc = {
    Text = "本次关卡内暴击伤害提高 [Layer] %。"
  },
  State_3794_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3794_Name = {
    Text = "状态@试作长剑爆伤"
  },
  State_3796_Desc = {
    Text = "生命每下降 20%，所有唤醒体获得 10 狂气，死亡后加触腕伤害"
  },
  State_3796_Name = {
    Text = "析出的银粒"
  },
  State_3796_WeaponDesc = {
    Text = "生命每下降 20%，所有唤醒体获得 10 狂气，死亡后加触腕伤害"
  },
  State_3797_Desc = {
    Text = "每次受到伤害时获得 [StateArg1] 点临时力量，回合开始时移除。"
  },
  State_3797_Name = {
    Text = "鼠群的愤怒！"
  },
  State_37980_Desc = {
    Text = "本场战斗内界域精通提高 [Layer] 。"
  },
  State_37980_Name = {
    Text = "界域精通"
  },
  State_3798_Desc = {
    Text = "造成实际伤害后将会恢复生命。"
  },
  State_3798_Name = {
    Text = "吸血之刃"
  },
  State_3798_WeaponDesc = {
    Text = "造成实际伤害后将会恢复生命。"
  },
  State_3799_Desc = {
    Text = "队伍中每有一名【血肉】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_3799_Name = {
    Text = "血肉加成"
  },
  State_3799_WeaponDesc = {
    Text = "队伍中每有一名【血肉】职业唤醒体，全队最大生命(未完成)、防御、攻击提高 50%"
  },
  State_3800_Desc = {
    Text = "对所有敌人造成伤害。<CardKeyWord:力量>在此伤害上发挥多倍效果。"
  },
  State_3800_Name = {
    Text = "<CardKeyWord:巨刃之威>"
  },
  State_3801_Desc = {
    Text = "造成未被格挡的伤害时，附加 [StateArg1] 层出血。"
  },
  State_3801_Name = {Text = "放血"},
  State_3802_Desc = {
    Text = "在手牌中时，每使用 1 张指令卡就变为其算力为 0 的复制。"
  },
  State_3802_Name = {
    Text = "<CardKeyWord:圣洁之子>"
  },
  State_3802_WeaponDesc = {
    Text = "在手牌中时，每使用 1 张牌就变为其算力为 0 的复制。"
  },
  State_3803_Desc = {
    Text = "战斗开始时，使你所有当前算力消耗为 1 的卡牌在本场战斗内伤害、护盾和治疗提高 [Arg1] 点。"
  },
  State_3804_Desc = {
    Text = "异化渔叉计数"
  },
  State_3804_Name = {
    Text = "异化渔叉计数"
  },
  State_3804_WeaponDesc = {
    Text = "异化渔叉计数"
  },
  State_3807_Name = {
    Text = "饰品入药之梦"
  },
  State_3807_WeaponDesc = {
    Text = "战斗开始后，额外将装备者一套卡牌洗入抽牌堆中。"
  },
  State_3808_Desc = {
    Text = "状态@通用改变当前生命"
  },
  State_3808_Name = {
    Text = "状态@通用改变当前生命"
  },
  State_3808_WeaponDesc = {
    Text = "状态@通用改变当前生命"
  },
  State_3810_Desc = {
    Text = "死亡后，其他友方力量提高。"
  },
  State_3810_Name = {Text = "死语"},
  State_3811_Desc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3811_Name = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3811_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_4_1"
  },
  State_3813_Name = {
    Text = "免疫虚弱"
  },
  State_3815_Desc = {
    Text = "回合结束时所有唤醒体失去 [Layer] 点狂气。"
  },
  State_3815_Name = {
    Text = "<EnergyColour:空虚>"
  },
  State_3815_WeaponDesc = {
    Text = "获取狂气降低 [Layer]%。"
  },
  State_3817_Desc = {
    Text = "回合开始时，对对手造成 [DescArg1] 点衰竭。"
  },
  State_3817_Name = {Text = "逸散"},
  State_3817_WeaponDesc = {
    Text = "回合开始时，我方队伍获得 [DescArg1*Layer*0.01] 层衰竭"
  },
  State_3818_Name = {
    Text = "状态@知者启灵1"
  },
  State_3819_Name = {
    Text = "破链者启灵1"
  },
  State_3819_WeaponDesc = {
    Text = "远古者模仿"
  },
  State_3821_Desc = {
    Text = "回合开始时，获得上回合损失生命一半的护盾。"
  },
  State_3821_Name = {
    Text = "苦痛与欢愉"
  },
  State_3821_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_3824_Desc = {
    Text = "队伍唯一：装备者的狂气爆发基础伤害提高 [StateArg1]%。探索开始时，装备者进入学者人格状态。装备者释放狂气爆发后在学者人格和小丑人格之间切换。\n学者人格：回合结束时，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气。\n小丑人格：回合结束时，装备者暴击率和暴击伤害 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3824_WeaponDesc = {
    Text = "装备者的狂气爆发基础伤害提高 [StateArg1]%。探索开始时，装备者进入学者人格状态。装备者释放狂气爆发后在学者人格和小丑人格之间切换。\n学者人格：回合结束时，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气。\n小丑人格：回合结束时，装备者暴击率和暴击伤害 <WeaponEffect_Num:+[StateArg3]%>。"
  },
  State_3825_Desc = {
    Text = "承受主动伤害时，对伤害来源造成等量层数的<FixedDamage:纯粹伤害>。"
  },
  State_3825_Name = {
    Text = "<RetaliateIconKeywords: 反击>"
  },
  State_3825_WeaponDesc = {
    Text = "每次承受主动伤害时，对攻击者造成<FixedDamage:纯粹伤害>。"
  },
  State_3826_Name = {
    Text = "状态@幻梦银钥：爆发计数"
  },
  State_3827_Desc = {
    Text = "队伍唯一：装备者生命回复提高 <WeaponEffect_Num:[StateArg1]%>。释放狂气爆发后，下回合开始时回复 <WeaponEffect_Num:[StateArg2]%> 已损失生命。"
  },
  State_3827_WeaponDesc = {
    Text = "装备者生命回复提高 <WeaponEffect_Num:[StateArg1]%>。释放狂气爆发后，下回合开始时回复 <WeaponEffect_Num:[DescArg1]%> 已损失生命。"
  },
  State_3830_Name = {
    Text = "额外生效 1 次"
  },
  State_3831_Name = {
    Text = "造物逆生根"
  },
  State_3834_Desc = {
    Text = "迷宫蛛造成的中毒翻倍。"
  },
  State_3834_Name = {
    Text = "迷途之旅"
  },
  State_3835_Desc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_3835_Name = {
    Text = "临时暴击伤害"
  },
  State_3835_WeaponDesc = {
    Text = "本回合内暴击伤害提高 [Layer] %。"
  },
  State_3836_Desc = {Text = "测试123"},
  State_3836_Name = {Text = "测试123"},
  State_3837_Desc = {
    Text = "队伍唯一：装备者造成的狂气提高 <WeaponEffect_Num:[StateArg1]%>，造成的中毒提高 <WeaponEffect_Num:[StateArg2]%>。装备者造成主动伤害后，所有唤醒体临时暴击伤害提高，数值等同于装备者基础暴击伤害的 <WeaponEffect_Num:[StateArg3]%>，每回合最多生效 1 次。若当前界域为「深海」，战斗开始时，触腕上限和触腕数量 +1。"
  },
  State_3837_WeaponDesc = {
    Text = "装备者造成的狂气提高 <WeaponEffect_Num:[StateArg1]%>，造成的中毒提高 <WeaponEffect_Num:[StateArg2]%>。装备者造成主动伤害后所有唤醒体临时暴击伤害 +<WeaponEffect_Num:[DescArg1]%> ，每回合最多生效 1 次。若当前界域为「深海」，战斗开始时，触腕上限和触腕数量 +1。"
  },
  State_3839_Desc = {
    Text = "战斗开始时，卡组中每有 1 张症状卡就获得 [Arg1] 力量。你的所有症状卡获得虚无。"
  },
  State_3840_Desc = {
    Text = "生命值每次降低时，获得 [StateArg1] 的戒备。"
  },
  State_3840_Name = {Text = "警觉"},
  State_3842_Desc = {
    Text = "造成的主动和触腕伤害降低 [DescArg1] %。"
  },
  State_3842_Name = {Text = "虚弱"},
  State_3842_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_3843_Desc = {
    Text = "每次行动附加[Layer]出血"
  },
  State_3843_Name = {Text = "重伤"},
  State_3843_WeaponDesc = {
    Text = "每次行动附加[Layer]出血，治疗可移除出血效果"
  },
  State_3844_Desc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_3844_Name = {
    Text = "战欲难平"
  },
  State_3844_WeaponDesc = {
    Text = "鲸跃的所有伤害次数+1。"
  },
  State_3845_Desc = {
    Text = "卡牌算力降低"
  },
  State_3845_Name = {
    Text = "卡牌算力降低"
  },
  State_3845_WeaponDesc = {
    Text = "卡牌算力降低"
  },
  State_3846_Name = {
    Text = "造物翠玉拓印"
  },
  State_3848_Desc = {
    Text = "本场战斗内，随机一个唤醒体的狂气爆发被封印，不可使用。"
  },
  State_3848_Name = {Text = "封印"},
  State_3850_Desc = {
    Text = "每打出第 [StateArg1] 张牌时，提高 [StateArg2] 触腕伤害，使所有触腕攻击 1 次。"
  },
  State_3850_Name = {
    Text = "异化渔叉"
  },
  State_3850_WeaponDesc = {
    Text = "每打出第 [StateArg1] 张牌时，提高 [StateArg2] 触腕伤害，使所有触腕攻击 1 次。"
  },
  State_3851_Name = {
    Text = "饰品剧院猫"
  },
  State_3851_WeaponDesc = {
    Text = "造成的所有伤害提高，提高值等于装备者最大生命的 10%"
  },
  State_3852_Desc = {
    Text = "撕咬伤害次数提高[Layer]。"
  },
  State_3852_Name = {
    Text = "渐强撕咬"
  },
  State_3852_WeaponDesc = {
    Text = "撕咬伤害次数提高[Layer]。"
  },
  State_3853_Desc = {
    Text = "回合开始时随机变形为抽牌堆中一张指令卡的复制，其算力消耗固定为 3，回合结束时变回。"
  },
  State_3853_Name = {
    Text = "<CardKeyWord:谵妄>"
  },
  State_3853_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_3854_Desc = {
    Text = "抽 2 张牌，同时会引起猎颅者的注意。"
  },
  State_3854_Name = {
    Text = "<CardKeyWord:被狩猎>"
  },
  State_3855_Desc = {Text = "1"},
  State_3855_Name = {Text = "力量"},
  State_3856_Desc = {
    Text = "状态@序章重置牌库0_1_3_1"
  },
  State_3856_Name = {
    Text = "状态@序章重置牌库0_1_3_1"
  },
  State_3856_WeaponDesc = {
    Text = "状态@序章重置牌库0_1_3_1"
  },
  State_3859_Desc = {
    Text = "丰穰之息提供的狂气翻倍。"
  },
  State_3859_Name = {
    Text = "目见母亲"
  },
  State_3859_WeaponDesc = {
    Text = "丰穰之息提供的狂气翻倍。"
  },
  State_3860_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3860_Name = {
    Text = "状态@试作小刀幸运"
  },
  State_3862_Name = {
    Text = "状态@关卡2_15战斗4气泡1"
  },
  State_3863_Desc = {
    Text = "每释放 3 次狂气爆发后，所有手牌算力消耗降低 1。"
  },
  State_3866_Desc = {
    Text = "在本回合内，手牌上限 +[Layer]。"
  },
  State_3866_Name = {
    Text = "手牌上限增加"
  },
  State_3867_Name = {
    Text = "超维职业计数器"
  },
  State_3868_Desc = {
    Text = "本回合内造成的护盾提高 [Layer] 点。"
  },
  State_3868_Name = {
    Text = "临时戒备"
  },
  State_3868_WeaponDesc = {
    Text = "本回合内造成的护盾提高 [Layer] 点。"
  },
  State_3872_Desc = {
    Text = "受到伤害会取消临时力量。"
  },
  State_3872_Name = {Text = "破绽"},
  State_38730_Desc = {
    Text = "回合开始后有 [DescArg1]% 概率获得 1 层触腕集结，超过 100% 时可获得多层。"
  },
  State_38730_Name = {Text = "海归线"},
  State_38735_Desc = {
    Text = "造成的主动伤害减少 [StateArg1]% ，攻击次数翻倍，持续 [Layer] 回合。"
  },
  State_38735_Name = {Text = "呓语"},
  State_38738_Desc = {
    Text = "上限为 10 层，可继承到下场战斗。"
  },
  State_38738_Name = {Text = "梦引"},
  State_3873_Desc = {
    Text = "本场战斗内界域精通提高 [Layer] 点。"
  },
  State_3873_Name = {
    Text = "界域精通"
  },
  State_3874_Name = {
    Text = "状态@风铃卡牌还原"
  },
  State_3876_Desc = {
    Text = "每个偶数回合使我方队伍力量减少。"
  },
  State_3876_Name = {
    Text = "「死梦之孔」"
  },
  State_3878_Desc = {
    Text = "每损失 2 点生命，下回合开始时获得 [Layer] 点护盾。"
  },
  State_3878_Name = {
    Text = "苦痛与欢愉"
  },
  State_3878_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_3879_Desc = {
    Text = "拾取时最大生命提高 [Arg1] 点。若拾取时生命低于 25%，最大生命提高变为 [Arg2] 点。"
  },
  State_3881_Desc = {
    Text = "状态@怪物乔治吃蜡像小怪"
  },
  State_3881_Name = {
    Text = "状态@怪物乔治吃蜡像小怪"
  },
  State_3881_WeaponDesc = {
    Text = "状态@怪物乔治吃蜡像小怪"
  },
  State_3882_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3882_Name = {
    Text = "尚未觉醒"
  },
  State_3883_Desc = {
    Text = "本次关卡内暴击率提高 [Layer] % 。"
  },
  State_3883_Name = {
    Text = "永久暴击率"
  },
  State_3883_WeaponDesc = {
    Text = "本次关卡内暴击率提高 [Layer] % 。"
  },
  State_3884_Desc = {
    Text = "每回合额外生成 1 个胚胎融合度。你的所有吞噬效果均变为无限吞噬。"
  },
  State_3884_Name = {
    Text = "造物蠕动的脐带"
  },
  State_3884_WeaponDesc = {
    Text = "每回合额外生成 1 个胚胎融合度。你的所有吞噬效果均变为无限吞噬。"
  },
  State_3888_Desc = {
    Text = "无法释放狂气爆发，回合结束时移除 1 层。"
  },
  State_3888_Name = {
    Text = "<CardKeyWord:封印>"
  },
  State_3888_WeaponDesc = {
    Text = "所有唤醒体的狂气爆发不可使用。"
  },
  State_3890_Name = {
    Text = "抽取弃牌数+ [DescArg1] 张牌"
  },
  State_3893_Desc = {
    Text = "造成伤害时获得 [Arg1] 点护盾。回复生命时，获得 [Arg2] 点临时力量。"
  },
  State_3893_Name = {
    Text = "我们的家"
  },
  State_3894_Desc = {
    Text = "弃牌阶段前将手牌变成石头"
  },
  State_3894_Name = {Text = "石化"},
  State_3894_WeaponDesc = {
    Text = "弃牌阶段前将手牌变成石头"
  },
  State_3895_Desc = {
    Text = "本回合内暴击率提高 [Layer] %。"
  },
  State_3895_Name = {
    Text = "临时暴击率"
  },
  State_3895_WeaponDesc = {
    Text = "本回合内暴击率提高 [Layer] %。"
  },
  State_3898_Desc = {
    Text = "下回合开始时获得 [Layer] 点护盾。"
  },
  State_3898_Name = {
    Text = "苦痛与欢愉护盾"
  },
  State_3900_Name = {
    Text = "卡牌被封印，无法打出，弃掉时解除"
  },
  State_3901_Name = {
    Text = "造物祭司权杖计数"
  },
  State_3902_Desc = {
    Text = "本回合内造成的主动伤害降低 [Layer] 点。"
  },
  State_3902_Name = {
    Text = "力量降低"
  },
  State_3902_WeaponDesc = {
    Text = "本回合内造成的伤害降低 [Layer] 点。"
  },
  State_3904_Desc = {
    Text = "每失去 1 点生命移除 1 层，层数为 0 时，获得 [StateArg1] 护盾，并重新获得 [StateArg2] 层血之屏障。"
  },
  State_3904_Name = {
    Text = "觉醒-血之屏障"
  },
  State_3905_Desc = {
    Text = "每次承受主动伤害时，对伤害来源造成 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3905_Name = {Text = "反击"},
  State_3905_WeaponDesc = {
    Text = "每次承受主动伤害时，对攻击者造成 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_3906_Name = {
    Text = "残留的银芯"
  },
  State_3907_Name = {
    Text = "残留的银芯"
  },
  State_3908_Desc = {
    Text = "缸中之脑施加回复时，抽 [Arg2] 张牌。"
  },
  State_3908_Name = {
    Text = "虚实二象"
  },
  State_3908_WeaponDesc = {
    Text = "缸中之脑施加回复时，抽 [Arg2] 张牌。"
  },
  State_3909_Name = {
    Text = "残留的银芯"
  },
  State_3910_Name = {
    Text = "残留的银芯"
  },
  State_3911_Name = {
    Text = "残留的银芯"
  },
  State_3912_Name = {
    Text = "残留的银芯"
  },
  State_3913_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时，保留 <WeaponEffect_Num:[StateArg2]%> 剩余护盾，保留的护盾至多为 <WeaponEffect_Num:[StateArg3]%> 最大生命护盾。"
  },
  State_3913_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>。回合开始时，保留 <WeaponEffect_Num:[StateArg2]%> 剩余护盾，保留的护盾至多为 <WeaponEffect_Num:[StateArg3]%> 最大生命护盾。"
  },
  State_3914_Desc = {
    Text = "每回合释放第 2 次狂气爆发后，所有唤醒体获得 10 点狂气。每回合释放第 3 次狂气爆发后，所有唤醒体狂气冷却重置，并获得 10 点狂气。"
  },
  State_3915_Name = {
    Text = "残留的银芯"
  },
  State_3916_Name = {
    Text = "残留的银芯"
  },
  State_3917_Desc = {
    Text = "下回合加临时力量"
  },
  State_3917_Name = {Text = "蓄力"},
  State_3918_Desc = {
    Text = "每个回合开始时获得首次受到伤害翻倍的状态"
  },
  State_3918_Name = {Text = "自傲"},
  State_3918_WeaponDesc = {
    Text = "每个回合开始时获得首次受到伤害翻倍的状态"
  },
  State_3921_Desc = {
    Text = "本回合卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_3921_Name = {
    Text = "<RetainIconKeywords:保留>"
  },
  State_3921_WeaponDesc = {
    Text = "卡牌不会在弃牌阶段进入弃牌堆，而是保留在手牌中。"
  },
  State_3923_Desc = {
    Text = "卡牌算力降低"
  },
  State_3923_Name = {
    Text = "永久卡牌算力降低"
  },
  State_3923_WeaponDesc = {
    Text = "卡牌算力降低"
  },
  State_3925_Name = {
    Text = "状态@第四章共鸣@我方队伍回合开始算力2"
  },
  State_3926_Desc = {
    Text = "「扭曲死体狂宴」增加 [Layer] 点伤害。"
  },
  State_3926_Name = {Text = "扭曲"},
  State_3926_WeaponDesc = {
    Text = "增加「狂躁」伤害。"
  },
  State_3927_Desc = {
    Text = "抽到「空虚」后，本回合内使所有唤醒体获取的狂气降低[Layer]%。"
  },
  State_3927_Name = {Text = "空虚"},
  State_3927_WeaponDesc = {
    Text = "抽到「空虚」后，本回合内使所有唤醒体获取的狂气降低[Layer]%。"
  },
  State_3928_Desc = {
    Text = "甜蜜恶鬼造成伤害时，获得 [StateArg2] 反击。"
  },
  State_3928_Name = {Text = "施与受"},
  State_3929_Desc = {
    Text = "获得的力量和护盾降低 50%，回合结束时移除 1 层。"
  },
  State_3929_Name = {
    Text = "<CardKeyWord:诅咒>"
  },
  State_3929_WeaponDesc = {
    Text = "本回合内免疫对己方施加的正面状态"
  },
  State_3930_Name = {
    Text = "状态@第四章共鸣@我方队伍回合开始算力1"
  },
  State_3931_Name = {
    Text = "状态@猩红血与沙的赞歌"
  },
  State_3932_Desc = {
    Text = "使卡牌获得保留，每层凝滞诅咒使卡牌费用提高1点，打出后移除凝滞诅咒。"
  },
  State_3932_Name = {
    Text = "凝滞诅咒([Layer])"
  },
  State_3932_WeaponDesc = {
    Text = "使卡牌获得保留，每层凝滞诅咒使卡牌费用提高1点，打出后移除凝滞诅咒。"
  },
  State_3933_Desc = {
    Text = "提高[Layer]点防御力。"
  },
  State_3933_Name = {
    Text = "临时防御力提高"
  },
  State_3933_WeaponDesc = {
    Text = "提高[Layer]点防御力。"
  },
  State_3934_Desc = {
    Text = "获得的所有护盾降低 50 %。"
  },
  State_3934_Name = {
    Text = "寂灭脆弱"
  },
  State_3934_WeaponDesc = {
    Text = "获得的所有护盾降低 50 %。"
  },
  State_3935_Desc = {
    Text = "我方队伍每使用一张手牌，获得一层「观测」，达到十层时自身眩晕。"
  },
  State_3935_Name = {Text = "观测"},
  State_3936_Desc = {
    Text = "装备者造成伤害、护盾、治疗提高 [StateArg1]%。（临时）"
  },
  State_3936_Name = {
    Text = "状态@试作长剑界域"
  },
  State_3937_Desc = {
    Text = "荆棘女王施加反击时，获得一半反击的护盾。"
  },
  State_3937_Name = {
    Text = "活尸之墙"
  },
  State_3938_Name = {
    Text = "生成蜡像"
  },
  State_3941_Desc = {
    Text = "当吞噬胚胎时，从弃牌堆回到手牌堆"
  },
  State_3941_Name = {
    Text = "苍白回旋"
  },
  State_3941_WeaponDesc = {
    Text = "当吞噬胚胎时，从弃牌堆回到手牌堆"
  },
  State_3942_Name = {
    Text = "饰品海归线"
  },
  State_3942_WeaponDesc = {
    Text = "战斗开始后，若装备者职业为深海，攻击力提高 25%。"
  },
  State_3943_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_3943_Name = {
    Text = "尚未觉醒"
  },
  State_3944_Desc = {
    Text = "回合结束后所有唤醒体获得 5 狂气。每剩余 1 点算力，所有唤醒体就额外获得 3 狂气。"
  },
  State_3945_Desc = {
    Text = "所有造物价格降低 50%。"
  },
  State_39547_Desc = {
    Text = "战斗结束后额外获得 5 黑印，该效果受黑印掉落加成。旺达打出卡牌后，获得 1 层梦引，该效果每回合至多触发2次。当前还剩 [DescArg1] 次。"
  },
  State_39547_Name = {
    Text = "裘皮与维纳斯"
  },
  State_40483_Name = {
    Text = "破碎沉戟"
  },
  State_40484_Desc = {
    Text = "旺达技能触发跃迁效果时，若存在 5 层，消耗 5 层并获得额外效果。梦引上限为 10 层，会继承到下场战斗。"
  },
  State_40484_Name = {
    Text = "<PurpleKeyWord:梦引>"
  },
  State_41337_Desc = {
    Text = "回合结束时回复 [Layer] 点生命。"
  },
  State_41337_Name = {
    Text = "玫瑰的胜利-回复"
  },
  State_41340_Desc = {
    Text = "队伍唯一：装备者造成的护盾和反击提高 <WeaponEffect_Num:[StateArg1]%>。每当受到攻击时，有 <WeaponEffect_Num:[StateArg2]%> 概率使所有唤醒体获得 1 点狂气。"
  },
  State_41340_WeaponDesc = {
    Text = "装备者造成的护盾和反击提高 <WeaponEffect_Num:[StateArg1]%>。每当受到攻击时，有 <WeaponEffect_Num:[StateArg2]%> 概率使所有唤醒体获得 1 点狂气。"
  },
  State_41342_Name = {
    Text = "变化效果__「仅开发用」"
  },
  State_41344_Name = {
    Text = "变化效果"
  },
  State_41360_Desc = {
    Text = "消耗 5 层<DreamGuide:梦引>，旺达获得 <Energy:[StateArg1]> 点狂气，获得等同于 [StateArg2]% 永久<RetaliateIconKeywords:反击>的临时<RetaliateIconKeywords:反击>。"
  },
  State_41360_Name = {
    Text = "深眠反击"
  },
  State_41361_Desc = {
    Text = "消耗 10 层<DreamGuide:梦引>，使所有敌人进入 1 回合「呓语」状态：造成的主动伤害减少 [StateArg3]% ，攻击次数翻倍。"
  },
  State_41361_Name = {
    Text = "呓语回音"
  },
  State_43818_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_43818_Name = {
    Text = "尚未觉醒"
  },
  State_44398_Desc = {
    Text = "每回合第一次打出卡牌后，将对应唤醒体的一张「防御」置入手中。"
  },
  State_44484_Name = {
    Text = "首领战中可使用3次"
  },
  State_44485_Name = {
    Text = "(剩余:[Layer])"
  },
  State_44491_Name = {
    Text = "禁用效果__「仅开发用」"
  },
  State_44562_Name = {
    Text = "禁用效果"
  },
  State_44575_Desc = {
    Text = "本回合剩余的护盾不会移除，将保留至下 1 回合。"
  },
  State_44575_Name = {
    Text = "护盾保留"
  },
  State_44653_Desc = {
    Text = "每回合开始时所有唤醒体获得 20 狂气。拾取时最大生命降低 50%。"
  },
  State_44665_Desc = {
    Text = "本回合「打击」暴击率提高 [Layer] % 。"
  },
  State_44665_Name = {
    Text = "打击暴击率"
  },
  State_44667_Desc = {
    Text = "「打击」获得 [DescArg1] 点算力。若当前姿态为「怒涛」，不再获得算力，而是使 1 条触腕攻击 [DescArg2] 次。"
  },
  State_44667_Name = {
    Text = "巨人的霸道"
  },
  State_44671_Desc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 3 倍。"
  },
  State_44672_Name = {
    Text = "受祝·虫群意识"
  },
  State_44711_Desc = {
    Text = "造物上限+5, [融痕]中刷新次数+1。战斗结束后，获得 125 黑印，拾取时可以选择最多 6 张症状卡删除。"
  },
  State_44713_Desc = {
    Text = "战斗结束后，额外获得 100 黑印和 2 张症状卡。"
  },
  State_44730_Desc = {
    Text = "回合开始时，积攒 <Heal:[Heal:StateArg1]> 点猩红熔炉回复量。"
  },
  State_44730_Name = {
    Text = "予以救赎"
  },
  State_44731_Desc = {
    Text = "以苦消苦。消耗所有猩红熔炉剩余的回复量，每消耗 1 点就使伤害提高 3 点，若为首领战，则改为每消耗 1 点伤害提高 9 点。每消耗 1％ 最大生命的猩红熔炉就提高 [DescArg1]% 最终伤害。"
  },
  State_44731_Name = {Text = "超度"},
  State_44732_Desc = {
    Text = "以血施救。造成伤害后，失去 10% 当前生命，积攒与失去生命等量的猩红熔炉回复量。"
  },
  State_44732_Name = {Text = "奉献"},
  State_44739_Desc = {
    Text = "拾取时永久失去 [Arg1] 力量。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  State_44739_Name = {
    Text = "负罪·七鳃鳗之吻"
  },
  State_44740_Name = {
    Text = "受祝·七鳃鳗之吻"
  },
  State_44741_Desc = {
    Text = "拾取时永久失去 [Arg1] 力量。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  State_44741_Name = {
    Text = "负罪·七鳃鳗之吻"
  },
  State_44742_Desc = {
    Text = "拾取时永久失去 [Arg1] 力量。每当造成伤害时，回复 [Arg2] 点生命，每回合最多触发 6 次。"
  },
  State_44742_Name = {
    Text = "受祝·七鳃鳗之吻"
  },
  State_44743_WeaponDesc = {
    Text = "战斗开始时脆弱自身 3 回合。"
  },
  State_44744_WeaponDesc = {
    Text = "战斗开始时脆弱自身 3 回合。"
  },
  State_44750_Desc = {
    Text = "回合开始时获得 [StateArg1] 算力。"
  },
  State_44750_Name = {
    Text = "造物黑烛1"
  },
  State_44751_Desc = {
    Text = "回合开始时获得 [StateArg1] 算力。"
  },
  State_44751_Name = {
    Text = "造物黑烛1"
  },
  State_44752_Desc = {
    Text = "每当「索菲亚」失去 1 点生命值就下降 1 层，层数为 0 后，将意图替换为 「以牙还牙」并获得 [StateArg2] 护盾。第一次触发时会恢复所有层数。"
  },
  State_44752_Name = {
    Text = "埋藏的冲动"
  },
  State_44762_Desc = {
    Text = "打出「防御」时，将 1 张伤口洗入抽牌堆。"
  },
  State_44762_Name = {Text = "撕裂"},
  State_44763_Desc = {
    Text = "所有唤醒体暴击伤害属性减半。"
  },
  State_44763_Name = {
    Text = "<PurpleKeyWord: 致盲>"
  },
  State_44764_Desc = {
    Text = "打出「打击」时，将 1 张伤口洗入抽牌堆。"
  },
  State_44764_Name = {Text = "创伤"},
  State_44807_Desc = {
    Text = "当第一次即将被击败时，回复生命并转变意图为 「镜中判决」，强化自身。当第二次即将被击败时，回复生命并转变意图为 「癫狂撕咬」，造成超高额单次伤害。"
  },
  State_44807_Name = {
    Text = "埋藏的杀戮"
  },
  State_44819_Desc = {
    Text = "若没有<ParcloseIconKeywords:屏障>，则获得 1 层临时<ParcloseIconKeywords:屏障>，否则获得 10% 暴击率和暴击伤害。"
  },
  State_44819_Name = {
    Text = "<CardKeyWord:父神守护>"
  },
  State_44828_Desc = {
    Text = "队伍唯一：回合结束时，装备者获得 [StateArg1] 点狂气。承受主动和触腕伤害时，下回合开始时获得 <WeaponEffect_Num:[StateArg2]%> 伤害的护盾。若当前界域为血肉，不再获得延迟护盾，而是积攒 <WeaponEffect_Num:[StateArg2]%> 伤害的回复量到猩红熔炉。"
  },
  State_44828_WeaponDesc = {
    Text = "回合结束时，装备者获得 <WeaponEffect_Num:[StateArg1]> 点狂气。承受主动或触腕伤害时，下回合开始时获得 <WeaponEffect_Num:[Float:StateArg2]%> 伤害的护盾。若当前界域为血肉，不再获得延迟护盾，而是积攒 <WeaponEffect_Num:[Float:StateArg2]%> 伤害的回复量到猩红熔炉。"
  },
  State_44889_Name = {
    Text = "状态@人面犬BOSS@终焉之镜1"
  },
  State_44890_Name = {
    Text = "状态@人面犬BOSS@终焉之镜2"
  },
  State_44891_Name = {
    Text = "状态@人面犬BOSS@终焉之镜3"
  },
  State_44903_Desc = {
    Text = "承受主动或触腕伤害后，会将 [StateArg1]% 伤害转化为猩红熔炉回复量，持续 [Layer] 回合。"
  },
  State_44903_Name = {
    Text = "造主的庇佑"
  },
  State_44909_Name = {Text = "可消耗"},
  State_45018_Desc = {
    Text = "回合结束之前无法使用「打击」。"
  },
  State_45018_Name = {Text = "麻痹"},
  State_45025_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_45029_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_45032_Desc = {
    Text = "下回合结束时，受到 [Layer] 伤害。"
  },
  State_45032_Name = {Text = "出血"},
  State_45039_Desc = {
    Text = "直到下个回合开始时，每当承受主动或触腕伤害，下个回合开始时获得 [Layer]% 伤害的护盾。"
  },
  State_45039_Name = {
    Text = "神迹降临"
  },
  State_45040_Desc = {
    Text = "直到下个回合开始时，每当承受主动或触腕伤害，积攒 [Layer]% 伤害的回复量到猩红熔炉。"
  },
  State_45040_Name = {
    Text = "神迹降临"
  },
  State_45049_Desc = {
    Text = "抵消下次主动攻击伤害造成的生命损失，最多可堆叠 3 层，每层死斗会使屏障的可堆叠层数 -1 ，已获得的屏障不会因可堆叠层数减少而减少。"
  },
  State_45049_Name = {Text = "屏障"},
  State_45050_Desc = {
    Text = "抵消下次主动攻击伤害造成的生命损失，最多可堆叠 3 层，每层死斗会使屏障的可堆叠层数 -1 ，已获得的屏障不会因可堆叠层数减少而减少。"
  },
  State_45050_Name = {
    Text = "<ReinforceColour:屏障>"
  },
  State_45064_Name = {
    Text = "无声欢宴的计数器__「仅开发用」"
  },
  State_45069_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_45072_Name = {
    Text = "圣化计数"
  },
  State_45073_Desc = {
    Text = "卡牌算力降低"
  },
  State_45076_Desc = {
    Text = "施加时驱散目标身上的护盾和延迟治疗，回合结束之前，受到的治疗和护盾效果降低 50% 。"
  },
  State_45076_Name = {Text = "重创"},
  State_45137_Desc = {
    Text = "使用狂气爆发后封印所有唤醒体一回合，且获得一回合易伤。"
  },
  State_45137_Name = {
    Text = "原罪·行道之骸"
  },
  State_45139_Desc = {
    Text = "使用狂气爆发后，随机驱散 1 种负面状态。"
  },
  State_45139_Name = {
    Text = "受祝·行道之骸"
  },
  State_45148_Desc = {
    Text = "所有唤醒体暴击伤害属性减半。"
  },
  State_45148_Name = {
    Text = "<PurpleKeyWord: 致盲>"
  },
  State_45166_Desc = {
    Text = "回合结束之前所装备的命轮失效。"
  },
  State_45166_Name = {Text = "缠绕"},
  State_45206_Desc = {
    Text = "以信济世。消耗所有猩红熔炉剩余的回复量，获得 150% 消耗量的护盾，该护盾不受护盾加成和减益影响，但无视护盾上限。"
  },
  State_45206_Name = {Text = "救赎"},
  State_45248_Name = {
    Text = "计数器__「仅开发用」"
  },
  State_45328_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使自身获得<TauntKeywords:嘲讽>与 <Block:[Block:StateArg1]> 护盾。"
  },
  State_45328_Name = {
    Text = "35mm的魔法"
  },
  State_45329_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」可以选择目标，「打击」前<PVPRepelKeywords:击退>目标所有可驱散的正面状态到其身后唤醒体。"
  },
  State_45329_Name = {
    Text = "深海的呼唤"
  },
  State_45331_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时以及「打击」后，将手牌中装备者的非衍生「技能」会按顺序变成装备者的其他「技能」[ShowIfState:， <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_45331_Name = {
    Text = "往昔的花与诗"
  },
  State_45332_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每受到一次主动伤害使其他友方获得  <Energy:[Energy:StateArg1]>  狂气。"
  },
  State_45332_Name = {
    Text = "伊萨拉乌的目光"
  },
  State_45333_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 +[StateArg1]，「狂气爆发」后使自身获得 <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_45333_Name = {
    Text = "灼热的吻别"
  },
  State_45334_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」使本回合下一次「打击」改为随机目标并且额外攻击 [StateArg1] 名随机目标。"
  },
  State_45334_Name = {Text = "镜中人"},
  State_45345_Desc = {
    Text = "用于记录使用了几次1阶段生育技能"
  },
  State_45345_Name = {
    Text = "生育标识1"
  },
  State_45346_Desc = {
    Text = "用于记录使用了几次2阶段生育技能"
  },
  State_45346_Name = {
    Text = "生育标识2"
  },
  State_45354_Desc = {
    Text = "该卡牌无法被打出。__「仅开发用」"
  },
  State_45354_Name = {
    Text = "无法打出__「仅开发用」"
  },
  State_45356_Desc = {
    Text = "回合结束时，变为你最后打出的「技能」牌，使其算力消耗 -2，打出后「灰雾真容」洗入牌库。"
  },
  State_45356_Name = {
    Text = "<CardKeyWord:灰雾真容>"
  },
  State_45364_Desc = {
    Text = "下回合开始时，该唤醒体获得 [Layer] 张「打击」。"
  },
  State_45364_Name = {
    Text = "延迟获得打击"
  },
  State_45385_Desc = {
    Text = "本场战斗内造成的所有伤害降低 [Layer] 点，无法驱散，其中有 [DescArg1]  层临时力量降低，会在回合结束后移除。"
  },
  State_45385_Name = {
    Text = "力量降低"
  },
  State_45387_Desc = {
    Text = "本场战斗内造成的所有伤害提高 [Layer] 点，无法驱散，其中有 [DescArg1] 层临时力量，会在回合结束后移除。"
  },
  State_45387_Name = {Text = "力量"},
  State_45397_Desc = {
    Text = "回合开始时，将 1 层屏障转化为力量。"
  },
  State_45397_Name = {
    Text = "玫瑰的胜利"
  },
  State_45403_Desc = {
    Text = "下回合开始时，获得 [Layer] 层蓄力。"
  },
  State_45403_Name = {
    Text = "延迟蓄力"
  },
  State_45407_Desc = {
    Text = "获得的狂气和延迟狂气降低 50%，并立即移除所有延迟狂气。"
  },
  State_45407_Name = {Text = "空虚"},
  State_45656_Desc = {
    Text = "母树第三次复活，启动生育2技能"
  },
  State_45658_Desc = {
    Text = "母树第一次复活，启动生育技能"
  },
  State_45661_Desc = {
    Text = "当生命降低至 0 时，使生命变为 1 点，不再受到伤害，准备释放「多重融合」。"
  },
  State_45661_Name = {
    Text = "多重融合"
  },
  State_45715_Desc = {
    Text = "获得等同于 [StateArg1]% 触腕伤害的临时力量。"
  },
  State_45715_Name = {Text = "篡夺"},
  State_45716_Desc = {
    Text = "获得等同于 [StateArg1]% 触腕伤害的临时力量。戈利亚获得 25% 临时暴击率。"
  },
  State_45716_Name = {Text = "篡夺"},
  State_45717_Desc = {
    Text = "使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。戈利亚获得 <Energy:[Energy:StateArg2]> 点狂气。"
  },
  State_45717_Name = {Text = "蛰伏"},
  State_45718_Desc = {
    Text = "使「巨刃之威」和「斩首重创」基础伤害在本场战斗中提高 25%。"
  },
  State_45718_Name = {Text = "蛰伏"},
  State_46057_Name = {Text = "算力"},
  State_46079_Desc = {
    Text = "本回合内，每当目标被主动伤害，就回复损失生命最多的友方 [Layer] 生命。"
  },
  State_46079_Name = {
    Text = "圣血指引"
  },
  State_46119_Desc = {
    Text = "下次被攻击时对攻击者施加缠绕。"
  },
  State_46119_Name = {
    Text = "迷宫陷阱"
  },
  State_46124_Desc = {
    Text = "回合结束之前无法进行任何行动。"
  },
  State_46124_Name = {Text = "石化"},
  State_46138_Desc = {
    Text = " 变为对手打出的上一张「技能」，且使其费用 - 1。"
  },
  State_46138_Name = {
    Text = "<CardKeyWord:星彩拟态>"
  },
  State_46139_Desc = {
    Text = "每当被主动攻击使自身获得 [Layer] 层蓄力并对攻击者造成 [Layer] 层迟缓。"
  },
  State_46139_Name = {
    Text = "异常引力"
  },
  State_46155_Desc = {
    Text = "自身的「技能」后获得 [StateArg1] 层蓄力并使层数 - 1。回合结束时消耗所有层数，每层回复 [StateArg2] 生命。"
  },
  State_46155_Name = {
    Text = "异端之血"
  },
  State_46243_Name = {
    Text = "洞悉计数器__「仅开发用」"
  },
  State_46255_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46256_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46322_Desc = {
    Text = "回合开始时获得 30 胚胎融合。"
  },
  State_46322_Name = {
    Text = "尤乌哈希试玩"
  },
  State_46323_Desc = {
    Text = "超维回合开始后，获得 100 点狂气，回合开始后获得 7 点力量。"
  },
  State_46323_Name = {
    Text = "莉兹试玩"
  },
  State_46324_Desc = {
    Text = "每回合获得 1 张「灵感」。"
  },
  State_46324_Name = {
    Text = "詹金试玩"
  },
  State_46329_Desc = {
    Text = "战斗开始后，获得 600 点银钥能量，萝坦获得 50 点狂气，萝坦释放狂气爆发后，额外获得 44 点狂气。"
  },
  State_46329_Name = {
    Text = "试玩增益"
  },
  State_46330_Desc = {
    Text = "回合开始时获得 30 胚胎融合，10 点狂气，[DescArg1] 点力量，将 3 张「打击」加入抽牌堆。"
  },
  State_46330_Name = {
    Text = "希洛试玩"
  },
  State_46333_Name = {
    Text = "雷娅试玩"
  },
  State_46334_Desc = {
    Text = "第 4 回合开始后，获得 100 点狂气。"
  },
  State_46334_Name = {
    Text = "法洛思试玩"
  },
  State_46336_Desc = {
    Text = "回合开始时获得 30 胚胎融合，10 点狂气。"
  },
  State_46336_Name = {
    Text = "阿格里帕试玩"
  },
  State_46337_Desc = {
    Text = "回合开始时获得 10 点狂气。"
  },
  State_46337_Name = {
    Text = "凯刻斯试玩"
  },
  State_46338_Desc = {
    Text = "回合开始时获得 30 胚胎融合，10 点狂气。"
  },
  State_46338_Name = {
    Text = "菲茵特试玩"
  },
  State_46427_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46428_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46429_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46441_Desc = {
    Text = "免疫非穿刺伤害，回合开始后移除。"
  },
  State_46441_Name = {
    Text = "免疫伤害"
  },
  State_46442_Name = {
    Text = "卡牌禁止修改打击目标类型__「仅开发用」"
  },
  State_46500_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_46505_Desc = {
    Text = "本回合内，每当受到主动伤害，获得 [Layer] 狂气。"
  },
  State_46505_Name = {
    Text = "疼痛转化"
  },
  State_46508_Desc = {
    Text = "受到昏迷后获得抗性，拥有抗性时再次受到昏迷伤害时抵消昏迷效果并使伤害翻倍，无法驱散。"
  },
  State_46508_Name = {Text = "抗性"},
  State_46511_Desc = {
    Text = "该唤醒体的「千面重叠」伤害提升 [Layer]。"
  },
  State_46511_Name = {
    Text = "千面重叠"
  },
  State_46512_Desc = {
    Text = "回合结束之前，该唤醒体打出卡牌后受到 [Layer] 伤害。"
  },
  State_46512_Name = {
    Text = "卡牌封锁"
  },
  State_46513_Desc = {
    Text = "增幅下一个诗篇，使其获得额外效果，无法被驱散。"
  },
  State_46513_Name = {
    Text = "哀恸浓墨"
  },
  State_46536_Desc = {
    Text = "若状态参数1为0则抽牌，否则仅漂字"
  },
  State_46536_Name = {Text = "抽牌"},
  State_46538_Desc = {
    Text = "探索开始时，获得 [StateArg1] 点狂气。"
  },
  State_46538_Name = {
    Text = "疯狂预兆"
  },
  State_47072_Desc = {
    Text = "本回合打击卡暴击率 +[Layer]%。"
  },
  State_47072_Name = {
    Text = "打击暴击"
  },
  State_47089_Name = {
    Text = "测试效果__「仅开发用」"
  },
  State_47096_Desc = {
    Text = "每打出 1 张「灵感」就使达芙黛尔获得 [StateArg1] 点狂气，获得 [StateArg2] 点力量，每回合最多触发 5 次。（当前还剩 [DescArg1] 次）"
  },
  State_47096_Name = {
    Text = "原质沉淀"
  },
  State_47189_Name = {
    Text = "切换为躁狂人格。血肉·抑郁：<EmbryoFusionIconKeywords:胚胎融合> +[Blood:StateArg5]，积攒 [StateArg6] 点猩红熔炉回复量"
  },
  State_47192_Name = {
    Text = "抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气。躁狂人格：额外获得 [DescArg2] 倍狂气"
  },
  State_47199_Name = {
    Text = "切换为抑郁人格。血肉·躁狂：伤害享受 [DescArg1] 倍<PowerIconKeywords:力量>加成并对目标施加 200% 伤害的<BleedingIconKeywords:出血>，获得 [StateArg7] 点<PowerIconKeywords:力量>"
  },
  State_47204_Name = {
    Text = "切换为躁狂人格。混沌·抑郁：获得 <Posse:[StateArg1]> 点银钥能量，下次钥令生效 2 次"
  },
  State_47206_Name = {
    Text = "切换为躁狂人格。深海·抑郁：<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>目标 2 回合，生成 1 条触腕, <TentacleInjurieIconKeywords:触腕伤害>+ [TentaclePower:StateArg3]"
  },
  State_47209_Name = {
    Text = "切换为抑郁人格。超维·躁狂：获得 15% 造成伤害的<RetaliateIconKeywords:反击>，然后对其他敌人造成等量<FixedDamage:纯粹伤害>。本回合每打出 1 张「灵感」，使该伤害在本回合内提高 [StateArg9] 点，最多提高 [StateArg10] 点"
  },
  State_47211_Name = {
    Text = "抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 1 点，并获得临时<RetainIconKeywords:保留>。躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47212_Name = {
    Text = "使「24」在抑郁与躁狂人格之间切换，并根据当前界域与人格，触发额外的效果"
  },
  State_47216_Name = {
    Text = "切换为抑郁人格。深海·躁狂：该伤害享受 [StateArg4]% <TentacleInjurieIconKeywords:触腕伤害>加成，并对所有敌人造成 30% 伤害的<IntoxicationIconKeywords:中毒>"
  },
  State_47217_Name = {
    Text = "切换为抑郁人格。混沌·躁狂：造成 3 次伤害，使「24」造成的所有伤害提高 [StateArg2] 点"
  },
  State_47218_Name = {
    Text = "切换为躁狂人格。超维·抑郁：将 2 张「灵感」加入手中，使目标临时降低 [Power:StateArg8] 点<PowerIconKeywords:力量>"
  },
  State_47222_Name = {
    Text = "抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 1 点，并获得临时<RetainIconKeywords:保留>。<AwakerCard_24Lost:躁狂人格：额外造成 [DescArg2] 次伤害>"
  },
  State_47224_Name = {
    Text = "抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气。<AwakerCard_24Lost:躁狂人格：额外获得 [DescArg2] 倍狂气>"
  },
  State_47228_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气。>躁狂人格：额外获得 [DescArg2] 倍狂气"
  },
  State_47229_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 1 点，并获得临时<RetainIconKeywords:保留>。>躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47451_Name = {
    Text = "莱克钥令禁用命轮效果__「仅开发用」"
  },
  State_47485_Name = {
    Text = "抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 2 点，并获得临时<RetainIconKeywords:保留>。躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47486_Name = {
    Text = "抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 2 点，并获得临时<RetainIconKeywords:保留>。<AwakerCard_24Lost:躁狂人格：额外造成 [DescArg2] 次伤害>"
  },
  State_47488_Name = {
    Text = "抑郁人格：额外获得 <Energy: [DescArg1]> 点狂气。躁狂人格：额外获得 [DescArg2] 次护盾"
  },
  State_47489_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：使手牌中 [DescArg1] 张算力最高的卡牌算力消耗降低 2 点，并获得临时<RetainIconKeywords:保留>。>躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47492_Name = {
    Text = "抑郁人格：额外获得 <Energy: [DescArg1]> 点狂气。<AwakerCard_24Lost:躁狂人格：额外造成 [DescArg2] 次伤害>"
  },
  State_47493_Name = {
    Text = "抑郁人格：额外获得 <Energy: [DescArg1]> 点狂气。躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47494_Name = {
    Text = "抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气，<WeaknessIconKeywords:虚弱>所有敌人 [DescArg3] 回合。躁狂人格：额外获得 [DescArg2] 倍狂气，<VulnerabilityIconKeywords:易伤>所有敌人 [DescArg3] 回合"
  },
  State_47495_Name = {
    Text = "抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气，<WeaknessIconKeywords:虚弱>所有敌人 [DescArg3] 回合。<AwakerCard_24Lost:躁狂人格：额外获得 [DescArg2] 倍狂气，易伤所有敌人 [DescArg3] 回合>"
  },
  State_47496_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：也会使其他唤醒体获得 [DescArg1] 倍的狂气，虚弱所有敌人 [DescArg3] 回合。>躁狂人格：额外获得 [DescArg2] 倍狂气，<VulnerabilityIconKeywords:易伤>所有敌人 [DescArg3] 回合"
  },
  State_47498_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：额外获得 [DescArg1] 点狂气。>躁狂人格：额外造成 [DescArg2] 次伤害"
  },
  State_47499_Name = {
    Text = "<AwakerCard_24Lost:抑郁人格：额外获得 [DescArg1] 点狂气。>躁狂人格：额外获得 [DescArg2] 次护盾"
  },
  State_47500_Name = {
    Text = "抑郁人格：额外获得 <Energy: [DescArg1] > 点狂气。<AwakerCard_24Lost:躁狂人格：额外获得 [DescArg2] 次护盾>"
  },
  State_47517_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，弃掉其他唤醒体的 [StateArg1] 张卡牌，若成功弃牌则抽  [StateArg2]  张牌。"
  },
  State_47517_Name = {
    Text = "银鳕鱼的决心"
  },
  State_47518_Name = {
    Text = "银鳕鱼的决心的计数器__「仅开发用」"
  },
  State_47528_Desc = {
    Text = "本回合「打击」+ [DescArg1]% 伤害<PVPPenetrateKeywords:贯穿 1>。"
  },
  State_47528_Name = {Text = "余威"},
  State_47530_Desc = {
    Text = "视为本回合内上次打出的「技能」。"
  },
  State_47530_Name = {
    Text = "<CardKeyWord:模拟演绎>"
  },
  State_47557_Desc = {
    Text = "队伍唯一：探索开始后，装备者进入银鳕鱼人格状态。装备者释放狂气爆发后将在银鳕鱼人格和猫咪人格之间切换。\n银鳕鱼人格：装备者造成主动伤害后获得 <WeaponEffect_Num:[StateArg1]> 银钥能量。猫咪人格：装备者造成主动伤害后，装备者的临时暴击伤害 <WeaponEffect_Num:+[StateArg2]%> 。这两个效果共享每回合最多触发 5 次的机会。"
  },
  State_47557_WeaponDesc = {
    Text = "探索开始后，装备者进入银鳕鱼人格状态。装备者释放狂气爆发后将在银鳕鱼人格和猫咪人格之间切换。\n银鳕鱼人格：装备者造成主动伤害后获得 <WeaponEffect_Num:[StateArg1]> 银钥能量。猫咪人格：装备者造成主动伤害后，装备者的临时暴击伤害 <WeaponEffect_Num:+[StateArg2]%> 。这两个效果共享每回合最多触发 5 次的机会。"
  },
  State_47822_Desc = {
    Text = "若下回合再次受到「麻痹」，其所有「打击」变为「幻象」，无法驱散，持续到下回合结束。"
  },
  State_47822_Name = {
    Text = "有点麻了"
  },
  State_47825_Desc = {
    Text = "数个回合开始后才触发该效果。"
  },
  State_47825_Name = {
    Text = "<CardKeyWord:延迟>"
  },
  State_47826_Desc = {
    Text = "·目标处于「麻痹」时伤害翻倍，否则本回合其「打击」无法使用。\n·连续 2 回合处于「麻痹」，其所有「打击」变为「幻象」。"
  },
  State_47826_Name = {
    Text = "<WeaknessColour:麻痹>"
  },
  State_47827_Desc = {
    Text = "每层使本场战斗内造成的所有伤害降低 1 点，无法驱散。"
  },
  State_47827_Name = {
    Text = "<WeaknessColour:力量降低>"
  },
  State_47828_Desc = {
    Text = "·施加时造成等量伤害，若目标处于「缠绕」，则伤害翻倍，否则使目标在回合结束之前所装备的命轮失效。"
  },
  State_47828_Name = {
    Text = "<WeaknessColour:缠绕>"
  },
  State_47830_Desc = {
    Text = "施加时驱散目标身上的护盾和延迟治疗，回合结束之前，受到的治疗和护盾效果降低 50% 。"
  },
  State_47830_Name = {
    Text = "<PVPVulnerabilityIconColour:重创>"
  },
  State_47831_Desc = {
    Text = "回合结束之前无法进行任何行动，在受到昏迷伤害后会使目标获得抗性。拥有抗性时再次受到昏迷伤害时抵消昏迷效果并使伤害翻倍。"
  },
  State_47831_Name = {
    Text = "<ComaColour:石化>"
  },
  State_47832_Desc = {
    Text = "包括染疫小鼠、带电小鼠、失智小鼠。"
  },
  State_47832_Name = {
    Text = "<CardKeyWord:老鼠牌>"
  },
  State_47833_Desc = {
    Text = "包括白鸽手帕、反向分体魔术盒、心灵感应话筒。"
  },
  State_47833_Name = {
    Text = "<CardKeyWord:惊人魔术>"
  },
  State_47841_Desc = {
    Text = "本场战斗中下 [Layer] 次使用钥令将生效 2 次。"
  },
  State_47841_Name = {
    Text = "双发钥令"
  },
  State_47842_Desc = {
    Text = "获得的狂气和延迟狂气降低 50%，并立即移除所有延迟狂气。"
  },
  State_47842_Name = {
    Text = "<PVPEmptinessColour:空虚>"
  },
  State_47843_Desc = {
    Text = "使唤醒体脱离死亡状态，并将其整套卡牌置入抽牌堆。"
  },
  State_47843_Name = {
    Text = "<PVPResurrectionColour:复活>"
  },
  State_47844_Desc = {
    Text = "随机产生一个让人摸不着头脑的效果。"
  },
  State_47844_Name = {
    Text = "<PVPWonderfulEffectKeywords:奇妙效果>"
  },
  State_47845_Desc = {
    Text = "卡牌在手牌中时便会产生效果。"
  },
  State_47845_Name = {
    Text = "<CardKeyWord:持有>"
  },
  State_47873_Desc = {
    Text = "下回合结束时，造成等量于层数的伤害。"
  },
  State_47873_Name = {
    Text = "<PVPVulnerabilityIconColour:出血>"
  },
  State_47887_Name = {
    Text = "根据当前队伍界域获得不同的效果"
  },
  State_47888_Name = {
    Text = "血肉：「24」每消耗 1 点算力<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，获得 [StateArg3] 点<PowerIconKeywords:力量>，「24」狂气爆发额外享受 300% 力量加成"
  },
  State_47889_Name = {
    Text = "深海：「24」造成的伤害享受 [StateArg2]% <TentacleInjurieIconKeywords:触腕伤害>加成，并造成 10% 伤害的<IntoxicationIconKeywords:中毒>。「24」的狂气爆发能触发敌人 [StateArg6]％ 的<IntoxicationIconKeywords:中毒>"
  },
  State_47892_Name = {
    Text = "混沌：「24」的暴击率和暴击伤害 +[StateArg4]%。每次使用钥令后，使「24」狂气爆发最终伤害提高 [StateArg1]%"
  },
  State_47894_Name = {
    Text = "超维：「24」造成的伤害享受 [StateArg5]% <RetaliateIconKeywords:反击>伤害加成，回合结束时往弃牌堆洗入 1 张「灵感」，手牌上限 +2"
  },
  State_48009_Desc = {
    Text = "每回合第一次打出时额外生效 [StateArg1] 次。"
  },
  State_48009_Name = {
    Text = "<Rune_19:合奏>"
  },
  State_48010_Desc = {
    Text = "合奏标记"
  },
  State_48010_Name = {
    Text = "合奏标记"
  },
  State_48011_Desc = {
    Text = "每回合第一次打出时额外生效 [StateArg1] 次。"
  },
  State_48011_Name = {
    Text = "<Rune_19_High:高级合奏>"
  },
  State_48011_WeaponDesc = {
    Text = "打出后额外生效 [StateArg1] 次，消耗。"
  },
  State_48012_Desc = {
    Text = "使被刻印的卡牌在每回合第一次打出时生效 2 次。"
  },
  State_48012_Name = {
    Text = "<CardKeyWord:刻印：合奏>"
  },
  State_48013_Desc = {
    Text = "使被刻印的卡牌在每回合第一次打出时生效 3 次。"
  },
  State_48013_Name = {
    Text = "<CardKeyWord:刻印：高级合奏>"
  },
  State_48019_Name = {
    Text = "<CardKeyWord:模拟演绎>"
  },
  State_48020_Name = {
    Text = "<CardKeyWord:灵魂诞生>"
  },
  State_48021_Name = {
    Text = "<CardKeyWord:灰雾真容>"
  },
  State_48078_Name = {
    Text = "<CardKeyWord:星彩拟态>"
  },
  State_48099_Desc = {
    Text = "回合结束时 「24」 获得 [DescArg1] 点狂气，每次 「24」 释放狂气爆发，这个效果获得的狂气提高 1。"
  },
  State_48099_Name = {
    Text = "巴甫洛夫行为研究"
  },
  State_48099_WeaponDesc = {
    Text = "装备者回合结束后获得 3 点狂气。若装备者狂气回充大于 10 ，额外获得 2 点狂气。"
  },
  State_48100_Name = {
    Text = "状态@24巴甫洛夫行为研究计数"
  },
  State_48100_WeaponDesc = {
    Text = "装备者回合结束后获得 3 点狂气。若装备者狂气回充大于 10 ，额外获得 2 点狂气。"
  },
  State_48107_Desc = {
    Text = "每回合打出的第一张装备者的「技能」伤害提高 [StateArg1]%。"
  },
  State_48107_Name = {
    Text = "巨人之刃"
  },
  State_48108_Desc = {
    Text = "装备者每回合第一次打出「技能」后，将其一张算力消耗 - [StateArg1] 的复制洗入抽牌堆。"
  },
  State_48108_Name = {
    Text = "旋转，旋转"
  },
  State_48110_Desc = {
    Text = "「技能」使本回合下一次「打击」改为随机目标并且额外攻击 [StateArg1] 名随机目标。"
  },
  State_48110_Name = {Text = "镜中人"},
  State_48140_Desc = {
    Text = "探索开始时，「24」进入抑郁人格状态。\n<School_1:混沌·抑郁>：获得 <Posse:[StateArg1]> 点银钥能量，下次钥令生效 2 次。\n<School_1:混沌·躁狂>：造成 3 次伤害，使「24」造成的所有伤害提高 [StateArg2] 点。\n<School_2:深海·抑郁>：<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>目标 2 回合，生成 1 条触腕，<TentacleInjurieIconKeywords:触腕伤害>+ [StateArg3]。\n<School_2:深海·躁狂>：该伤害享受 [StateArg4]% <TentacleInjurieIconKeywords:触腕伤害>加成，并对所有敌人造成 30% 造成伤害的<IntoxicationIconKeywords:中毒>。\n<School_3:血肉·抑郁>：<EmbryoFusionIconKeywords:胚胎融合> +[Blood:StateArg5]，积攒 [StateArg6] 点猩红熔炉回复量。\n<School_3:血肉·躁狂>：伤害享受 6 倍<PowerIconKeywords:力量>加成并对目标施加 200% 造成伤害的<BleedingIconKeywords:出血>，获得 [StateArg7] 点<PowerIconKeywords:力量>。\n<School_4:超维·抑郁>：将 2 张「灵感」加入手中，使目标<PowerIconKeywords:力量>临时降低 [StateArg8] 点。\n<School_4:超维·躁狂>：获得 15% 造成伤害的<RetaliateIconKeywords:反击>，然后对其他敌人造成等量<FixedDamage:纯粹伤害>。本回合每打出 1 张「灵感」，使该伤害在本回合内提高 [StateArg9] 点，最多提高 [StateArg10] 点。"
  },
  State_48140_Name = {
    Text = "界域与人格效果"
  },
  State_48141_Desc = {
    Text = "<School_1:混沌>：「24」的暴击率和暴击伤害 +[StateArg4]%。每次使用钥令后，使「24」狂气爆发最终伤害提高 [StateArg1]%。\n<School_2:深海>：「24」造成的伤害享受 [StateArg2]% <TentacleInjurieIconKeywords:触腕伤害>加成，并造成 10% 伤害的<IntoxicationIconKeywords:中毒>。「24」的狂气爆发能触发敌人 50% 的<IntoxicationIconKeywords:中毒>。\n<School_3:血肉>：「24」每消耗 1 点算力<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，获得 [StateArg3] 点<PowerIconKeywords:力量>。「24」的狂气爆发额外享受 300% 力量加成\n<School_4:超维>：「24」造成的伤害享受 [StateArg5]% <RetaliateIconKeywords:反击>伤害加成，回合结束时往弃牌堆洗入 1 张「灵感」，手牌上限 +2。"
  },
  State_48141_Name = {
    Text = "界域效果"
  },
  State_48149_Name = {
    Text = "不可打出卡面特效__「仅开发用」"
  },
  State_48176_Desc = {
    Text = "在本次试玩中，每回合获得 1 点算力，「24」每消耗 1 点算力，获得 30 点银钥能量。"
  },
  State_48176_Name = {
    Text = "「24」试玩"
  },
  State_48198_Desc = {
    Text = "在本次试玩中，每回合获得 1 张「灵感」。"
  },
  State_48198_Name = {
    Text = "「24」试玩"
  },
  State_48199_Desc = {
    Text = "在本次试玩中，每回合获得 1 点算力。"
  },
  State_48199_Name = {
    Text = "「24」试玩"
  },
  State_48589_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命且变为原来的 2 倍并以真正的形态开始战斗。"
  },
  State_48589_Name = {
    Text = "尚未觉醒"
  },
  State_48607_Name = {
    Text = "通用卡牌原始算力降低__「仅开发用」"
  },
  State_48822_Desc = {
    Text = "血肉界域机制回合开始时，获得的胚胎融合提高 50%。"
  },
  State_48822_Name = {
    Text = "生生不息"
  },
  State_48923_Desc = {
    Text = "影子「24」 已经觉醒，使用最后的「救救我」找到机会吧！"
  },
  State_48923_Name = {
    Text = "影子「24」觉醒！"
  },
  State_48923_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_49063_Desc = {
    Text = "萝坦的「打击」伤害提高 30%。"
  },
  State_49063_Name = {
    Text = "昂扬的战意"
  },
  State_49109_Desc = {
    Text = "卡牌获得保留，回合结束时若在手中，则获得 1 张该指令卡的带有消耗的原始复制。"
  },
  State_49109_Name = {
    Text = "<Rune_20_High:孕育>"
  },
  State_49109_WeaponDesc = {
    Text = "打出后额外生效 [StateArg1] 次，消耗。"
  },
  State_49148_Desc = {
    Text = "死亡后，给 1 张算力消耗不为 0 的卡牌附加「畸变 1」。畸变：卡牌状态，战斗结束后仍然保留。每层使算力消耗降低 1，但打出后每层会将 1 张随机畸变加入手中（无视手牌上限），移除所有的畸变。"
  },
  State_49148_Name = {
    Text = "畸变之胎"
  },
  State_49149_Desc = {
    Text = "每层使卡牌算力消耗降低 1。打出后，每有 1 层畸变，将一张随机畸变卡牌加入手中，移除该状态。该状态在战斗结束后会保留。"
  },
  State_49149_Name = {
    Text = "<ExclamationPointColour:畸变 [Layer]>"
  },
  State_49149_WeaponDesc = {
    Text = "打出后将其永久移除。"
  },
  State_49207_Name = {
    Text = "获得 100 钥能"
  },
  State_49225_Desc = {
    Text = "回合结束后，使 1 条触腕攻击 [Layer] 次。"
  },
  State_49225_Name = {
    Text = "<CardKeyWord:触腕集结>"
  },
  State_49226_Desc = {
    Text = "回合结束时，每有 1 张手牌，触发所有敌人 3% 的中毒，并获得 3 点狂气。"
  },
  State_49226_Name = {
    Text = "微弱烛光"
  },
  State_49260_Desc = {
    Text = "回合结束时回复等同于体质 7.5% 的生命。"
  },
  State_49260_Name = {
    Text = "不被接纳之痛"
  },
  State_49270_Desc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_49270_Name = {
    Text = "打击牌伤害提高"
  },
  State_49270_WeaponDesc = {
    Text = "打击牌伤害提高 [Layer] %。"
  },
  State_49278_Desc = {
    Text = "回合结束时，回复等同于已损失生命 5% 的生命。若生命低于 50%([StateArg1])，还会获得 [StateArg2] 力量。"
  },
  State_49278_Name = {
    Text = "猩红圣坛"
  },
  State_49430_Desc = {
    Text = "受到的伤害降低，每层降低 1 %。其他友方死亡后移除该状态。"
  },
  State_49430_Name = {
    Text = "<AberrationColour:隐匿>"
  },
  State_49500_Desc = {
    Text = "每层使攻击次数加1，受到伤害失去一层，回合结束时失去全部。"
  },
  State_49500_Name = {Text = "祈祷"},
  State_49524_Desc = {
    Text = "回合结束时，回复等同于已损失生命 5% 的生命。每当玩家抽到 1 张状态卡或症状卡，所有「努比亚」获得 [StateArg1] 点临时力量。"
  },
  State_49524_Name = {
    Text = "血色福音"
  },
  State_49526_Desc = {
    Text = "死亡后立刻回复至 [StateArg2] 点生命并免疫伤害 1 回合 ，将意图调整为「秽乱播撒」。"
  },
  State_49526_Name = {Text = "播撒"},
  State_49542_Desc = {
    Text = "队伍唯一：战斗开始后，获得装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的力量，若当前界域为「深海」，还会提高装备者攻击力 <WeaponEffect_Num:[StateArg2]%> 的触腕伤害。"
  },
  State_49542_WeaponDesc = {
    Text = "战斗开始后，获得 <WeaponEffect_Num:[Power:DescArg1]> 点力量，若当前界域为「深海」，还会获得 <WeaponEffect_Num:[DescArg2]> 点触腕伤害。"
  },
  State_49546_Desc = {
    Text = "总是和 2 名精英护卫一起出现。自身死亡后它们也会死亡。"
  },
  State_49546_Name = {Text = "列阵"},
  State_49547_Desc = {
    Text = "死亡后，使亚兰卫队长获得 [StateArg1] 点力量，和 50% 最大生命的护盾。"
  },
  State_49547_Name = {Text = "忠诚"},
  State_49558_Desc = {
    Text = "每回合力量提高 [StateArg1] 点。"
  },
  State_49558_Name = {
    Text = "沙之祷祝"
  },
  State_49582_Desc = {
    Text = "本场战斗中每回合剩余的护盾不会移除，将一直保留。"
  },
  State_49582_Name = {
    Text = "护盾永久保留"
  },
  State_49583_Desc = {
    Text = "回合结束时，获得 [StateArg1] 点护盾，受戒备加成。"
  },
  State_49583_Name = {
    Text = "亚兰之盾"
  },
  State_49595_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_49595_Name = {
    Text = "尚未觉醒"
  },
  State_49596_Desc = {
    Text = "「空想利刃」已经觉醒，她将获得更多的护盾及力量。"
  },
  State_49596_Name = {
    Text = "艾尔瓦觉醒！"
  },
  State_49596_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_49597_Name = {
    Text = "本回合已经麻过了__「仅开发用」"
  },
  State_49600_Desc = {
    Text = "虚弱所有敌人 2 回合。"
  },
  State_49600_Name = {
    Text = "恐惧之血"
  },
  State_49601_Desc = {
    Text = "易伤所有敌人 2 回合。"
  },
  State_49601_Name = {
    Text = "溃烂之血"
  },
  State_49602_Desc = {
    Text = "易伤所有敌人 1 回合。"
  },
  State_49602_Name = {
    Text = "溃烂之血"
  },
  State_49603_Desc = {
    Text = "胚胎融合 +[Blood:DescArg1]。"
  },
  State_49603_Name = {
    Text = "生殖之血"
  },
  State_49604_Desc = {
    Text = "胚胎融合 +[Blood:DescArg1]。"
  },
  State_49604_Name = {
    Text = "生殖之血"
  },
  State_49605_Desc = {
    Text = "虚弱所有敌人 1 回合。"
  },
  State_49605_Name = {
    Text = "恐惧之血"
  },
  State_49623_Desc = {
    Text = "受到的生命回复降低 [DescArg1]%。回合结束时移除 1 层。"
  },
  State_49623_Name = {
    Text = "<BaseDamageColour:重创>"
  },
  State_49623_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_49627_Desc = {
    Text = "初始拥有 2 层<ParcloseIconKeywords:屏障>。死亡时，所有「努比亚」获得 [StateArg1] 点力量。"
  },
  State_49627_Name = {
    Text = "血脉奔涌"
  },
  State_49628_Desc = {
    Text = "死亡时，所有「努比亚」获得 [StateArg1] 点力量。"
  },
  State_49628_Name = {
    Text = "血脉链接"
  },
  State_49638_Desc = {
    Text = "识别是否为黑山羊系列怪物的状态"
  },
  State_49833_Desc = {
    Text = "回合结束时，对所有敌人施加 1 回合「致盲」状态。若自身护盾被击破，则取消「致盲」状态。"
  },
  State_49833_Name = {
    Text = "沙尘壁障"
  },
  State_49844_Desc = {
    Text = "队伍唯一：回合结束后获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。触发死亡抵抗后获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。使用应急灵知体后，算力上限提高 3，每回合抽牌数提高 3。"
  },
  State_49844_WeaponDesc = {
    Text = "回合结束后获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。触发死亡抵抗后获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。使用应急灵知体后，算力上限提高 3，每回合抽牌数提高 3。"
  },
  State_49877_Desc = {
    Text = "使卡牌算力消耗降低。打出后，每有 1 层畸变，将一张随机畸变卡牌加入手中，移除该状态。该状态在战斗结束后会保留。"
  },
  State_49877_Name = {
    Text = "<AberrationKeywords:畸变>"
  },
  State_49877_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_49954_Desc = {
    Text = "所有唤醒体暴击伤害属性减半。"
  },
  State_49954_Name = {
    Text = "<BlindingKeywords: 致盲>"
  },
  State_49954_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_49957_Desc = {
    Text = "承受主动伤害时封印攻击唤醒体的狂气爆发和所有卡牌 1 回合，移除 1 层<ResentChainsKeywords:怨恨锁链>。回合结束时清空。"
  },
  State_49957_Name = {
    Text = "<ResentChainsKeywords: 怨恨锁链>"
  },
  State_49957_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_49958_Desc = {
    Text = "承受主动和触腕伤害时，封印攻击唤醒体的狂气爆发和所有卡牌 1 回合，移除 1 层<ResentChainsKeywords:怨恨锁链>。"
  },
  State_49958_Name = {
    Text = "<ResentChainsKeywords1:怨恨锁链>"
  },
  State_49959_Desc = {
    Text = "每回合开始时，获得 1 层<ResentChainsKeywords:怨恨锁链>。"
  },
  State_49959_Name = {
    Text = "多维之锁"
  },
  State_50010_Desc = {
    Text = "受到的生命回复降低 25%。回合结束时移除 1 层。"
  },
  State_50010_Name = {
    Text = "<HeavyInjuryKeywords:重创>"
  },
  State_50021_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，获得等同于装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>。若当前界域为「血肉」，释放狂气爆发后，胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> 。"
  },
  State_50021_WeaponDesc = {
    Text = "装备者释放狂气爆发后，获得 <WeaponEffect_Num:[Power:DescArg1]> 点<PowerIconKeywords:力量>。若当前界域为「血肉」，释放狂气爆发后，胚胎融合 <WeaponEffect_Num:+[Blood:StateArg2]> 。"
  },
  State_50302_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：抵抗 1 次致死伤害并摧毁此「命轮」，获得 [StateArg1] 层<PVPProtectiveKeywords:屏障>，生效时若为唯一生存友方，使下回合开始时获得 [StateArg2] 张随机「钥令」。"
  },
  State_50302_Name = {
    Text = "极夜与破晓"
  },
  State_50323_Desc = {
    Text = "下回合开始前，获得 [Layer] 张随机钥令。"
  },
  State_50323_Name = {
    Text = "延迟钥令"
  },
  State_50333_Desc = {
    Text = "回合结束时所有唤醒体失去狂气。"
  },
  State_50333_Name = {
    Text = "<EmptinessKeywords: 空虚>"
  },
  State_50333_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_50352_Name = {
    Text = "泰旖丝试玩"
  },
  State_50353_Name = {
    Text = "泰旖丝试玩"
  },
  State_50358_Desc = {
    Text = "受到的伤害降低，每层降低 1 %。其他友方死亡后移除该状态。"
  },
  State_50358_Name = {
    Text = "<ConcealmentKeywords:隐匿>"
  },
  State_50375_Desc = {
    Text = "这些效果包括：自身获得 10 点狂气、其它友方获得 5 点狂气、对全体敌方施加 1 层易伤、对全体敌方施加 1 层虚弱、 抽 1 张牌、获得 200 点银钥能量。"
  },
  State_50375_Name = {
    Text = "<MysterybuffKeywords:奇妙正面效果>"
  },
  State_50389_Desc = {
    Text = "回合开始时，将一张「莱克的幸运骰子」置入手中。"
  },
  State_50389_Name = {
    Text = "莱克的支援"
  },
  State_50390_Desc = {
    Text = "回合开始时，获得 [StateArg1] 点力量。"
  },
  State_50390_Name = {
    Text = "战地卓识"
  },
  State_50491_Name = {
    Text = "时灵摆「均衡」"
  },
  State_50735_Desc = {
    Text = "当第一次即将被击败时，回复生命并转变意图为 「撕裂哀恸」，造成超高额单次伤害。"
  },
  State_50735_Name = {
    Text = "无谓的坚毅"
  },
  State_50854_Desc = {
    Text = "战斗开始时，获得 [StateArg1] 点<RetaliateIconKeywords:反击>。回合结束后获得 [StateArg2] 点护盾，每回合这个护盾提高  [StateArg3] 。"
  },
  State_50854_Name = {
    Text = "强韧树皮"
  },
  State_50861_Desc = {
    Text = "不再受到伤害，准备释放「万千子嗣之母」。"
  },
  State_50861_Name = {Text = "衍生"},
  State_50862_Desc = {
    Text = "不再受到伤害，准备释放「繁育」。"
  },
  State_50862_Name = {Text = "孵化"},
  State_50863_Desc = {
    Text = "不再受到伤害，准备释放「狂野树浆」。"
  },
  State_50863_Name = {Text = "免疫"},
  State_50864_Desc = {
    Text = "不再受到伤害，准备释放「树浆」。"
  },
  State_50864_Name = {Text = "免疫"},
  State_50891_Desc = {
    Text = "不再受到伤害，准备释放「多重融合」。"
  },
  State_50891_Name = {Text = "吞噬"},
  State_51016_Desc = {
    Text = "受到的中毒效果变为 1000%。"
  },
  State_51016_Name = {
    Text = "枯槁朽木"
  },
  State_51017_Desc = {
    Text = "受到的中毒效果变为 500%。"
  },
  State_51017_Name = {
    Text = "枯槁朽木"
  },
  State_51607_Desc = {
    Text = "免疫一切伤害，回合开始后移除。"
  },
  State_51607_Name = {
    Text = "免疫伤害"
  },
  State_51695_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_51695_Name = {
    Text = "尚未觉醒"
  },
  State_51696_Desc = {
    Text = "「海之使徒」已经觉醒，她对于狂气爆发有更强的反制。"
  },
  State_51696_Name = {
    Text = "弥利亚姆觉醒！"
  },
  State_51696_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_51739_Desc = {
    Text = "回合结束时随机获得 1 张「神国幻影」，无法驱散。"
  },
  State_51739_Name = {
    Text = "信仰的终结"
  },
  State_51740_Desc = {
    Text = "战斗开始时，将 1 张「执妄」置入手中。"
  },
  State_51740_Name = {
    Text = "不灭虔诚"
  },
  State_51741_Desc = {
    Text = "回合开始时获得 [Layer] 点护盾，无法驱散。"
  },
  State_51741_Name = {
    Text = "坚守自我"
  },
  State_51742_Desc = {
    Text = "回合开始时获得 [Layer] 点触腕伤害和力量，无法驱散。"
  },
  State_51742_Name = {
    Text = "投身启示"
  },
  State_51743_Desc = {
    Text = "本回合触腕每次攻击时，根据触腕姿态获得以下效果：潮涌：所有唤醒体获得 <Energy:[Energy:StateArg1]> 点狂气；静海：对所有敌人造成 [StateArg2] 点<IntoxicationIconKeywords:中毒>；怒涛：临时<TentacleInjurieIconKeywords:触腕伤害> +[StateArg3]。"
  },
  State_51743_Name = {
    Text = "母神的祝祷"
  },
  State_51745_Desc = {
    Text = "海之使徒打出 1 张牌时，生成 [StateArg1] 条临时触腕，该触腕可以无视触腕上限。"
  },
  State_51745_Name = {
    Text = "代行权能"
  },
  State_51745_WeaponDesc = {
    Text = "海之使徒打出 1 张牌时，生成 [StateArg1] 条临时触腕，该触腕可以无视触腕上限。"
  },
  State_51811_Name = {
    Text = "引舵之帆治疗效果__「仅开发用」"
  },
  State_51813_Desc = {
    Text = "回合结束后，算力消耗-[Layer]，被弃掉后也会触发该效果。"
  },
  State_51813_Name = {
    Text = "<PrepareKeypvewordscolour:预备[Layer]>"
  },
  State_51820_Desc = {
    Text = "「孕育」获得额外效果：5 层时立刻召唤1名「水之子」，最多存在2名「水之子」。"
  },
  State_51820_Name = {
    Text = "弥利亚姆觉醒"
  },
  State_51822_Desc = {
    Text = "每次释放狂气爆发增加 1 层「孕育」，每层孕育获得 [StateArg1] 点力量，上限为 5 层。"
  },
  State_51822_Name = {
    Text = "利莫里亚的最终降神"
  },
  State_52068_Desc = {
    Text = "将手中最多 3 张「圣礼」转化为「执妄」，根据转化的数量获得不同阶段的额外效果。"
  },
  State_52068_Name = {
    Text = "<CardKeyWord:祭仪>"
  },
  State_52087_Desc = {
    Text = "「不死的极乐鸟」在 [Layer] 回合后，才能再次施加可复活状态。"
  },
  State_52087_Name = {
    Text = "复活冷却"
  },
  State_52116_Desc = {
    Text = "回合结束之前，该唤醒体使用狂气爆发后受到 [Layer] 伤害。"
  },
  State_52116_Name = {
    Text = "爆发封锁"
  },
  State_52369_Desc = {
    Text = "打出 [DescArg1] 张症状卡后，获得图鲁的支援卡「王权」：造成大量伤害，并昏迷目标 1 回合。"
  },
  State_52369_Name = {
    Text = "神国必将再临"
  },
  State_53115_Desc = {
    Text = "本回合弥利亚姆下一次触发的「祭仪」效果提高 50%。"
  },
  State_53115_Name = {
    Text = "向深渊祝祷"
  },
  State_53144_Desc = {
    Text = "每个回合开始时获得 <Block:[Block:StateArg1]> 点护盾。"
  },
  State_53144_Name = {
    Text = "<CardKeyWord:坚守自我>"
  },
  State_53145_Desc = {
    Text = "每个回合开始时<PowerIconKeywords:力量>和<TentacleInjurieIconKeywords:触腕伤害> +[StateArg2]。"
  },
  State_53145_Name = {
    Text = "<CardKeyWord:投身启示>"
  },
  State_53673_Desc = {
    Text = "腺体分裂的数量最多拥有 10 张。"
  },
  State_53673_Name = {
    Text = "腺体分裂限制"
  },
  State_53674_Desc = {
    Text = "手牌上限 +2。回合开始时，弥利亚姆获得 20 点狂气。"
  },
  State_53674_Name = {
    Text = "弥利亚姆试玩"
  },
  State_53755_Desc = {
    Text = "所有唤醒体施加的<PowerIconKeywords:力量>、<RetaliateIconKeywords:反击>、<IntoxicationIconKeywords:中毒>提高 [DescArg1]%。「纷华篇章」施加的<PowerIconKeywords:力量>提高。"
  },
  State_53755_Name = {
    Text = "诡谲诗篇·惧"
  },
  State_53756_Desc = {
    Text = "所有唤醒体造成的狂气提高 [DescArg1]%，回合结束时的算力和指令卡可保留至下回合。「纷华篇章」造成的狂气提高 。"
  },
  State_53756_Name = {
    Text = "幻梦诗篇·喜"
  },
  State_53758_Desc = {
    Text = "所有唤醒体造成的最终伤害提高 [DescArg1]%，「纷华篇章」增加的暴击率和暴击伤害提高。"
  },
  State_53758_Name = {
    Text = "狂想诗篇·怒"
  },
  State_53759_Desc = {
    Text = "所有唤醒体造成护盾与回复生命、施加的<PowerIconKeywords:力量>降低效果提高 [DescArg1]%，「纷华篇章」造成回复提高。"
  },
  State_53759_Name = {
    Text = "哀恸诗篇·哀"
  },
  State_53772_Name = {
    Text = "饰品二律背反"
  },
  State_53772_WeaponDesc = {
    Text = "装备者使用狂气爆发后，己方基于装备者防御力的 100% 获得<RetaliateIconKeywords:反击>。并使自身当前<RetaliateIconKeywords:反击>提高 10%。"
  },
  State_53870_Name = {
    Text = "饰品36室之环"
  },
  State_53870_WeaponDesc = {
    Text = "抽到装备者的卡牌时，其算力会在 0-3 间随机变化。"
  },
  State_53981_Name = {
    Text = "饰品入药之梦黑印修正"
  },
  State_53981_WeaponDesc = {
    Text = "战斗开始后，额外将装备者一套卡牌洗入抽牌堆中。"
  },
  State_54002_Name = {
    Text = "状态@饰品入药之梦筛选标记"
  },
  State_54002_WeaponDesc = {
    Text = "装备者使用狂气爆发后，己方基于装备者防御力的 100% 获得<RetaliateIconKeywords:反击>。并使自身当前<RetaliateIconKeywords:反击>提高 10%。"
  },
  State_54011_Name = {
    Text = "状态@饰品入药之梦复制1可用"
  },
  State_54011_WeaponDesc = {
    Text = "装备者使用狂气爆发后，己方基于装备者防御力的 100% 获得<RetaliateIconKeywords:反击>。并使自身当前<RetaliateIconKeywords:反击>提高 10%。"
  },
  State_54012_Name = {
    Text = "状态@饰品入药之梦复制2可用"
  },
  State_54012_WeaponDesc = {
    Text = "装备者使用狂气爆发后，己方基于装备者防御力的 100% 获得<RetaliateIconKeywords:反击>。并使自身当前<RetaliateIconKeywords:反击>提高 10%。"
  },
  State_54013_Desc = {
    Text = "本回合内界域精通提高 [Layer] 点。"
  },
  State_54013_Name = {
    Text = "临时界域精通"
  },
  State_54014_Desc = {
    Text = "界域精通提高 [Layer] 点。"
  },
  State_54014_Name = {
    Text = "界域精通"
  },
  State_54043_WeaponDesc = {
    Text = "装备者使用狂气爆发后，本回合内自身护盾和治疗强效翻倍。"
  },
  State_54044_Desc = {
    Text = "造成双倍伤害并额外获得 600% 等同于环行拉蒙娜银钥充能的银钥能量，但打出后<DepleteIconKeywords:消耗>。"
  },
  State_54044_Name = {
    Text = "未来讴歌"
  },
  State_54045_Desc = {
    Text = "获得 3 点算力。"
  },
  State_54045_Name = {
    Text = "轮回之庭"
  },
  State_54046_Desc = {
    Text = "回合开始时，回复 [StateArg1] 点生命，持续 [Layer] 回合。"
  },
  State_54046_Name = {
    Text = "理性，真理与现实"
  },
  State_54071_Desc = {
    Text = "奥吉尔造成的主动伤害次数 +1，持续 [Layer] 回合。"
  },
  State_54071_Name = {
    Text = "七艺，八美德"
  },
  State_54121_Desc = {
    Text = "本场战斗中「混沌之兽」造成的基础伤害提高 [Layer]%。"
  },
  State_54121_Name = {
    Text = "混沌之兽"
  },
  State_54138_Desc = {
    Text = "索蕾尔下 [Layer] 张打出的指令卡生效 2 次。"
  },
  State_54138_Name = {
    Text = "权欲轮舞"
  },
  State_54384_Desc = {
    Text = "使宁菲亚造成的<IntoxicationIconKeywords:中毒>提高 50%，持续 [Layer] 回合。"
  },
  State_54384_Name = {
    Text = "自我的葬仪"
  },
  State_54416_Desc = {
    Text = "唤醒体最大积攒狂气翻倍。若狂气达到双倍基础狂气可释放超限爆发，释放狂气爆发后剩余狂气减半。"
  },
  State_54416_Name = {
    Text = "<OverLimitUtlSkillKeywords:超限爆发>"
  },
  State_54416_WeaponDesc = {
    Text = "消耗手牌中的胚胎，触发强大的吞噬效果。"
  },
  State_54561_Desc = {
    Text = "队伍唯一：装备者造成的伤害数值提高装备者攻击力的 <WeaponEffect_Num:[StateArg1]%>。若当前界域为「血肉」，装备者每当触发了吞噬效果，额外使装备者造成的伤害数值提高装备者攻击力的 3%。"
  },
  State_54561_WeaponDesc = {
    Text = "装备者造成的伤害提高 [DescArg1] 点。若当前界域为「血肉」，装备者每当触发了吞噬效果，额外使装备者造成的伤害提高 [DescArg2] 点。"
  },
  State_54568_Name = {
    Text = "直至星球终结"
  },
  State_54597_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：敌方唤醒体死亡后，获得 [StateArg1] <StrongEffectKeywords:强效>，将其算力消耗最高并附带<PVPVoidKeywords:虚无>的「技能」置入手中。"
  },
  State_54597_Name = {
    Text = "百万蒙宠之眼"
  },
  State_54704_Desc = {
    Text = "「24」的下一张指令卡生效 3 次。"
  },
  State_54704_Name = {
    Text = "扭曲的死体狂宴"
  },
  State_54798_Desc = {
    Text = "所有唤醒体造成护盾、生命回复、力量降低效果提高 [StateArg1]%，纷华篇章回复效果提高。"
  },
  State_54798_Name = {Text = "「哀」"},
  State_54799_Desc = {
    Text = "所有唤醒体造成反击、中毒、力量获取效果提高 [StateArg1]%。纷华篇章的力量提高。"
  },
  State_54799_Name = {Text = "「惧」"},
  State_54800_Desc = {
    Text = "所有唤醒体造成的最终伤害提高 [StateArg1]%，纷华篇章的暴击率和暴击伤害提高。"
  },
  State_54800_Name = {Text = "「怒」"},
  State_55108_Desc = {
    Text = "回合开始时将手中的「绿炎」或「腐化绿炎」升级为「死灭绿炎」，持续 [Layer] 回合。"
  },
  State_55108_Name = {
    Text = "死兆降临"
  },
  State_55108_WeaponDesc = {
    Text = "回合开始时若在手牌或超维空间会得到强化"
  },
  State_55113_Desc = {
    Text = "奥尔拉每回合打出第一张诗篇后，获得 10 点狂气。"
  },
  State_55113_Name = {
    Text = "花与诗的重逢"
  },
  State_55465_Name = {
    Text = "消耗 [Layer] 层隐喻「怒」，额外造成 [DescArg1] 次伤害"
  },
  State_55466_Name = {
    Text = "消耗 [Layer] 层隐喻「哀」，回复 <Heal:[Heal:DescArg1]> 点生命"
  },
  State_55467_Name = {
    Text = "消耗 [Layer] 层隐喻「惧」，额外获得 [Power:DescArg1] 点<PowerIconKeywords:力量>"
  },
  State_55469_Name = {
    Text = "消耗 [Layer] 层隐喻「喜」，额外获得 <Energy:[Energy:DescArg1]> 点狂气"
  },
  State_55470_Name = {
    Text = "断颈一击"
  },
  State_55485_Desc = {
    Text = "卡茜亚打出的下 [Layer] 张卡牌获得自身攻击力 10％ 的力量。"
  },
  State_55485_Name = {
    Text = "纵情欢笑"
  },
  State_55486_Name = {
    Text = "死梦之都超限爆发免除梦引消耗"
  },
  State_55487_Desc = {
    Text = "艾瑞卡的「打击」额外造成 2 次伤害，「防御」额外获得 2 次护盾，持续  [Layer] 回合。"
  },
  State_55487_Name = {
    Text = "多重计算"
  },
  State_55489_Name = {
    Text = "时空折跃"
  },
  State_55806_Name = {
    Text = "<PoetryKeywords:献诗>：给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果> 或 给予全体友方正面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 张牌，获得 1 算力。最后一次献诗生效 2 次"
  },
  State_55807_Name = {
    Text = "抽 1 张牌，获得 1 算力"
  },
  State_55808_Name = {
    Text = "<PoetryKeywords:献诗>：给予全体友方正面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 张牌，获得 1 算力。最后一次献诗生效 2 次"
  },
  State_55809_Name = {
    Text = "给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果>"
  },
  State_55811_Desc = {
    Text = "从列出的选项中选择一项生效。"
  },
  State_55811_Name = {
    Text = "<ComaColour:抉择>"
  },
  State_55813_Name = {
    Text = "<PoetryKeywords:献诗>：给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果> 或 抽 1 张牌，获得 1 算力。最后一次献诗生效 2 次"
  },
  State_55814_Name = {
    Text = "<PoetryKeywords:献诗>：给予全体敌方负面<PVPWonderfulEffectKeywords:奇妙效果> 或 给予全体友方正面<PVPWonderfulEffectKeywords:奇妙效果> 。最后一次献诗生效 2 次"
  },
  State_55816_Name = {
    Text = "给予全体友方正面<PVPWonderfulEffectKeywords:奇妙效果>"
  },
  State_55824_Desc = {
    Text = "从列出的选项中选择一项生效，选择后移除选择的选项，若有剩余选项则将此牌置入对手手牌。"
  },
  State_55824_Name = {
    Text = "<ComaColour:献诗>"
  },
  State_55836_Desc = {
    Text = "回合结束时，手中奥尔拉的指令卡算力消耗 -1。"
  },
  State_55836_Name = {
    Text = "墨染成诗"
  },
  State_55839_Desc = {
    Text = "拾取时失去所有其他造物，随机获得 2 个黄金造物。"
  },
  State_55866_Desc = {
    Text = "队伍唯一：战斗开始时抽 1 张装备者的指令卡，并有 <WeaponEffect_Num:[StateArg1]%> 的几率使其算力消耗降低 1。每当触发死亡抵抗，都会重复触发 1 次该效果。"
  },
  State_55866_WeaponDesc = {
    Text = "战斗开始时抽 1 张装备者的指令卡，并有 <WeaponEffect_Num:[StateArg1]%> 的几率使其算力消耗降低 1。每当触发死亡抵抗，都会重复触发 1 次该效果。"
  },
  State_55992_Desc = {
    Text = "算力不足时会给卡牌施加消耗和标记。"
  },
  State_55992_Name = {Text = "余烬"},
  State_55993_Name = {
    Text = "余烬标记"
  },
  State_56018_Desc = {
    Text = "本场战斗中，最大生命值提高 [Layer]%。"
  },
  State_56018_Name = {
    Text = "缪斯的眷顾-命"
  },
  State_56020_Desc = {
    Text = "本场战斗中，伤害提高 [Layer]%。"
  },
  State_56020_Name = {
    Text = "缪斯的眷顾-力"
  },
  State_56030_Desc = {
    Text = "本回合唤醒体造成的护盾和治疗提高 [Layer]%。"
  },
  State_56030_Name = {Text = "雪"},
  State_56031_Desc = {
    Text = "本回合每造成 1 次伤害，临时暴击率 +[Layer]%。"
  },
  State_56031_Name = {Text = "蝴蝶"},
  State_56034_Desc = {
    Text = "每种「隐喻」最多 3 层。不同「隐喻」会增幅诗篇的不同效果：\n<D06CardKeyWordnu:狂想诗篇>：消耗所有隐喻「怒」，每层隐喻额外造成 2 次伤害。\n<D06CardKeyWordai:哀恸诗篇>：消耗所有隐喻「哀」，每层隐喻额外回复生命。\n<D06CardKeyWordxi:幻梦诗篇>：消耗所有隐喻「喜」，每层隐喻额外获得 10 点狂气。\n<D06CardKeyWordju:诡谲诗篇>：消耗所有隐喻「惧」，每层隐喻额外获得<PowerIconKeywords:力量>。"
  },
  State_56034_Name = {Text = "隐喻"},
  State_56208_Desc = {
    Text = "雨颂：回复 <Heal:[DescArg1]> 点生命。\n风颂：获得 [DescArg2] 点<PowerIconKeywords:力量>。\n花颂：所有唤醒体获得 [DescArg3] 点狂气。\n月颂：临时暴击率提高 [DescArg4]%。"
  },
  State_56208_Name = {Text = "诗页"},
  State_56330_Desc = {
    Text = "获得 [DescArg1] 点护盾，若本回合内释放过 3 次狂气爆发，此卡额外生效 1 次。"
  },
  State_56330_Name = {
    Text = "高级意象"
  },
  State_56331_Desc = {
    Text = "从抽牌堆和弃牌堆选择 1 张指令卡置入手中，并使其算力消耗 -2。"
  },
  State_56331_Name = {
    Text = "高级意象"
  },
  State_56332_Desc = {
    Text = "获得 [DescArg1] 点临时<PowerIconKeywords:力量>。打出后本回合每造成 1 次伤害，临时暴击率 +3%。"
  },
  State_56332_Name = {
    Text = "高级意象"
  },
  State_56333_Desc = {
    Text = "回复 10% 已损失生命。若当前生命低于 25%，此卡额外生效 1 次。"
  },
  State_56333_Name = {
    Text = "高级意象"
  },
  State_56334_Desc = {
    Text = "下一个钥令生效 2 次。"
  },
  State_56334_Name = {
    Text = "高级意象"
  },
  State_56335_Desc = {
    Text = "造成等同于自身最大生命 150% 的<FixedDamage:纯粹伤害>，该伤害享受 10 倍<PowerIconKeywords:力量>加成。"
  },
  State_56335_Name = {
    Text = "高级意象"
  },
  State_56336_Desc = {
    Text = "抽 5 张牌。"
  },
  State_56336_Name = {
    Text = "高级意象"
  },
  State_56337_Desc = {
    Text = "获得 [DescArg1] 点临时<AlertIconKeywords:戒备>。打出后本回合造成的护盾和回复提高 [DescArg2]%。"
  },
  State_56337_Name = {
    Text = "高级意象"
  },
  State_56338_Desc = {
    Text = "获得 3 点算力。"
  },
  State_56338_Name = {
    Text = "高级意象"
  },
  State_56339_Desc = {
    Text = "驱散随机 1 个负面状态。此卡额外生效 3 次，消耗。"
  },
  State_56339_Name = {
    Text = "高级意象"
  },
  State_56340_Desc = {
    Text = "对所有敌人施加 3 回合<VulnerabilityIconKeywords:易伤>。每当有敌人死亡时，将此卡从牌堆置入手中。"
  },
  State_56340_Name = {
    Text = "高级意象"
  },
  State_56341_Desc = {
    Text = "界域精通 +25 点，临时界域精通 +125 点。"
  },
  State_56341_Name = {
    Text = "高级意象"
  },
  State_56342_Desc = {
    Text = "所有唤醒体获得 15 点狂气。"
  },
  State_56342_Name = {
    Text = "高级意象"
  },
  State_56343_Desc = {
    Text = "对所有敌人施加 3 回合<WeaknessIconKeywords:虚弱>，将 1 张此卡的复制置入弃牌堆，附加<DepleteIconKeywords:消耗>，<NothingnessIconKeywords:虚无>。"
  },
  State_56343_Name = {
    Text = "高级意象"
  },
  State_56372_Desc = {
    Text = "死亡时清除玩家最后获得的 1 种负面状态。"
  },
  State_56372_Name = {Text = "花与诗"},
  State_56400_Desc = {
    Text = "「打击」后，将手牌中自身的「技能」会按顺序变成其他「技能」 [ShowIfState:， <CardKeyWord:<SkillName3:>>→<CardKeyWord:<SkillName2:>>→<CardKeyWord:<SkillName1:>>→<CardKeyWord:<SkillName3:>>]。"
  },
  State_56400_Name = {
    Text = "往昔的花与诗"
  },
  State_56402_Desc = {
    Text = "拥有隐喻<D06CardKeyWordnu:「怒」> [DescArg2] 层：「狂想诗篇」触发跃迁时将额外造成伤害。\n拥有隐喻<D06CardKeyWordai:「哀」> [DescArg3] 层：「哀恸诗篇」触发跃迁时将额外回复生命。\n拥有隐喻<D06CardKeyWordxi:「喜」> [DescArg1] 层：「幻梦诗篇」触发跃迁时将额外使唤醒体获得狂气。\n拥有隐喻<D06CardKeyWordju:「惧」> [DescArg4] 层：「诡谲诗篇」触发跃迁时将额外获得力量。"
  },
  State_56402_Name = {Text = "隐喻"},
  State_57166_Desc = {
    Text = "唤醒体造成的伤害提高 25%。"
  },
  State_57170_Desc = {
    Text = "手牌上限+2，回合结束时选择 1 张手牌获得保留并使其算力消耗 -1，持续 3 回合。"
  },
  State_57170_Name = {
    Text = "迷航之光"
  },
  State_57316_Desc = {
    Text = "每回合开始时将 1 张「胚胎」转化为「圣洁之子」，若没有「胚胎」则<EmbryoFusionIconKeywords:胚胎融合> +[Blood:DescArg1]，不受胚胎融合提高效果影响。持续 [Layer] 回合。"
  },
  State_57316_Name = {
    Text = "永续圣骸的传承"
  },
  State_57317_Desc = {
    Text = "当此命轮在卡组中时，将可以看到手中的技能即将产生的变化。"
  },
  State_57317_Name = {
    Text = "<PVPFlowerKeywords:往昔的花与诗>"
  },
  State_57324_Desc = {
    Text = "若此唤醒体触发了「往昔的花与诗」，此牌将变化成 <CardKeyWord:<SkillName1:>> 。"
  },
  State_57324_Name = {
    Text = "往昔的花与诗"
  },
  State_57325_Desc = {
    Text = "若此唤醒体触发了「往昔的花与诗」，此牌将变化成 <CardKeyWord:<SkillName2:>> 。"
  },
  State_57325_Name = {
    Text = "往昔的花与诗"
  },
  State_57326_Desc = {
    Text = "若此唤醒体触发了「往昔的花与诗」，此牌将变化成 <CardKeyWord:<SkillName3:>> 。"
  },
  State_57326_Name = {
    Text = "往昔的花与诗"
  },
  State_57335_Name = {
    Text = "此卡伤害额外享受 [DescArg1] 倍力量加成"
  },
  State_57356_Name = {
    Text = "状态@沉渊者反击计算"
  },
  State_57368_Name = {
    Text = "状态@沉渊者反击跳板"
  },
  State_57413_Name = {
    Text = "每点护盾使此卡伤害提高 [DescArg1] 点"
  },
  State_57417_Desc = {
    Text = "每次触发死亡抵抗时，造成 100% 反击的<FixedDamage:纯粹伤害>，本场战斗中每次触发死亡抵抗，就使<FixedDamage:纯粹伤害>提高 25%。"
  },
  State_57417_Name = {
    Text = "爱之摇篮"
  },
  State_57566_Name = {
    Text = "绝境求生"
  },
  State_57587_Desc = {
    Text = "打出「腺体分裂」时抽 1 张牌，剩余 [Layer] 次。"
  },
  State_57587_Name = {
    Text = "水母集合！"
  },
  State_57665_Name = {
    Text = "神母的庇护"
  },
  State_57728_Desc = {
    Text = "尤乌哈希的伤害次数提高 1。"
  },
  State_57728_Name = {
    Text = "血涌的馈赠"
  },
  State_57751_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>。释放钥令后所有唤醒体获得 <WeaponEffect_Num:[StateArg2]%> 临时暴击率和暴击伤害，但附加最大生命 3% 的献祭。若当前界域为「深海」，释放钥令后还会使触腕伤害提高装备者攻击力的 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_57751_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>。释放钥令后所有唤醒体获得 <WeaponEffect_Num:[StateArg2]%> 临时暴击率和暴击伤害，但附加 [DescArg1] 点献祭。若当前界域为「深海」，释放钥令后还会使触腕伤害提高 [DescArg2] 点。"
  },
  State_57753_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] 层<PVPSleepKeywords:精致睡眠>。"
  },
  State_57753_Name = {
    Text = "冰川下的沉眠"
  },
  State_57766_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：每回合首次「狂气爆发」后临时<StrongEffectKeywords:强效> +[StateArg1]。"
  },
  State_57766_Name = {
    Text = "牧羊人的手杖"
  },
  State_57767_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，扣除 <Energy:[Energy:StateArg1]> 狂气转换为<PVPDerivativeCardKeywords_12:「小小心愿」>，若转换失败则获得 <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_57767_Name = {
    Text = "永不停歇的演奏"
  },
  State_57768_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」伤害提高 [StateArg1]%。「狂气爆发」后恢复自身已损生命的 [StateArg2]%。"
  },
  State_57768_Name = {
    Text = "待到雪山消融"
  },
  State_57769_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：打出装备者的技能卡后，抽 1 张装备者的技能卡，每回合至多生效 1 次。"
  },
  State_57769_Name = {
    Text = "真理之门"
  },
  State_57770_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」造成的伤害、治疗与护盾效果提高 [StateArg1]~[StateArg2]%(目前是  [Layer] %)，<PhantomKeywords:幻影>。"
  },
  State_57770_Name = {
    Text = "命运轮盘赌"
  },
  State_57814_Name = {
    Text = "当此标记存在时，表示正在更换命轮。部分逻辑会需要此标记识别。__「仅开发用」"
  },
  State_57817_Desc = {
    Text = "无法行动，回合结束时层数 - 1，层数耗尽后 <StrongEffectKeywords:强效> +5，无法被驱散，更换命轮将失去精致睡眠状态。"
  },
  State_57817_Name = {
    Text = "精致睡眠"
  },
  State_57854_Desc = {
    Text = "回合开始时获得 [StateArg1] 点护盾和 [StateArg2] 点触腕伤害，生成 2 条临时触腕，持续 [Layer] 回合。"
  },
  State_57854_Name = {
    Text = "自由誓愿"
  },
  State_57854_WeaponDesc = {
    Text = "状态@深海淑女红茶与蛋糕"
  },
  State_57864_Name = {
    Text = "刷新力量加成__「仅开发用」"
  },
  State_57942_Desc = {
    Text = "当前融合度 [Layer]%。融合度达到 100% 时，敌人会强制进入下一阶段，且释放更强大的转阶段技能。"
  },
  State_57942_Name = {Text = "融合度"},
  State_57952_Desc = {
    Text = "力量被降低时，仅会降低 50% 的力量层数。"
  },
  State_57952_Name = {Text = "深潜"},
  State_57953_Desc = {
    Text = "回合结束时，生成 1 条触腕。觉醒后移除该状态。"
  },
  State_57953_Name = {Text = "沉眠"},
  State_57955_Desc = {
    Text = "希洛造成的伤害提高 [StateArg1]%，持续 [Layer] 回合。"
  },
  State_57955_Name = {
    Text = "绝境求生·伤害"
  },
  State_57968_Desc = {
    Text = "受到了于丽埃特的影响，每个回合结束后双子融合度提高 10%，并将 1 张「畸变」洗入抽牌堆。"
  },
  State_57968_Name = {
    Text = "「于丽埃特之咏」"
  },
  State_57970_Name = {
    Text = "神母的庇护"
  },
  State_57976_Desc = {
    Text = "「暗之子」进行强行融合后，对「遗忘的伊始」造成等同于自身当前生命 3 倍的<FixedDamage:纯粹伤害>。"
  },
  State_57976_Name = {Text = "牺牲"},
  State_58051_Desc = {
    Text = "暴击伤害 +[Layer]%。"
  },
  State_58051_Name = {
    Text = "暴击伤害"
  },
  State_58052_Desc = {
    Text = "探索中每消耗 1 点黑印，就使「肆意豪赌」的基础伤害提高 0.5%。（已提高 [DescArg1]%）"
  },
  State_58052_Name = {
    Text = "稳赚不赔"
  },
  State_58061_Name = {
    Text = "拾金不昧"
  },
  State_58063_Desc = {
    Text = "唤醒体造成的伤害提高 25%，持续 [Layer] 回合。"
  },
  State_58063_Name = {
    Text = "超越万古的凝视"
  },
  State_58144_Desc = {
    Text = "本次关卡内暴击率提高 [Layer] % 。"
  },
  State_58144_Name = {
    Text = "永久暴击率"
  },
  State_58144_WeaponDesc = {
    Text = "本次关卡内暴击率提高 [Layer] % 。"
  },
  State_58259_Desc = {
    Text = "队伍唯一：装备者暴击率提高 <WeaponEffect_Num:[StateArg1]%>。装备者击杀敌人后获得 <WeaponEffect_Num:[StateArg2]> 点黑印，在探索中最多触发 3 次。触发 3 次后本次探索中装备者永久提高 <WeaponEffect_Num:[StateArg3]%> 暴击率。"
  },
  State_58259_WeaponDesc = {
    Text = "装备者暴击率提高 <WeaponEffect_Num:[StateArg1]%>。装备者击杀敌人后获得 <WeaponEffect_Num:[DescArg2]> 点黑印，在探索中最多触发 3 次([DescArg1]/3)。触发 3 次后本次探索中装备者永久提高 <WeaponEffect_Num:[StateArg3]%> 暴击率。"
  },
  State_58297_Desc = {
    Text = "莱克击杀敌人时获得 [DescArg3] 黑印，每场探索最多生效 5 次。（[DescArg1]/5）\n通过战斗获取 50/125/250 黑印后，造物上限提高 1，战斗结束时选择一个「混沌的遗赠」加入造物列表。（已获取 [DescArg2] 点黑印）"
  },
  State_58297_Name = {
    Text = "赢家通吃"
  },
  State_58447_Desc = {
    Text = "包括了以下三个造物：\n「幸运风衣」：所有唤醒体暴击率提高 10%。所有莱克和骰子的随机结果不会出现最小值。\n<TentacleInjurieIconKeywords:升级>: 暴击率提高改为 15%，使随机结果最大值提高 1。\n「偏方骰子」：每当释放钥令后，将 1 张「<C05_yansheng1:偏方骰子>」置入手中。\n<TentacleInjurieIconKeywords:升级>: 改为将 1 张「<C05_yansheng2:闪耀偏方骰子>」置入手中。\n「大嘴纽扣」：回合开始时以及莱克或骰子的随机效果触发时，获得 50 点银钥能量和 2% 暴击伤害，最多获得 30% 暴击伤害。\n<TentacleInjurieIconKeywords:升级>: 改为获得 100 点银钥能量和 4% 暴击伤害，最多获得 50% 暴击伤害。"
  },
  State_58447_Name = {
    Text = "<CardKeyWord:混沌的遗赠>"
  },
  State_58490_Desc = {
    Text = "当困意被全部移除时，将封印所有唤醒体和卡牌，并将「沉睡之主」意图调整为「王权之威」。"
  },
  State_58490_Name = {Text = "困意"},
  State_58491_Desc = {
    Text = "每当打出卡牌后移除 1 层「困意」。回合开始时回复到 12 层「困意」。"
  },
  State_58491_Name = {Text = "震怒"},
  State_58492_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_58492_Name = {
    Text = "尚未觉醒"
  },
  State_58493_Desc = {
    Text = "每当打出卡牌后移除 1 层「困意」。回合开始时回复到 12 层「困意」。"
  },
  State_58493_Name = {Text = "震怒"},
  State_58947_Desc = {
    Text = "本次关卡内暴击率提高 [Layer] % 。"
  },
  State_59078_Name = {
    Text = "，可以使用 1 次"
  },
  State_59079_Name = {
    Text = "，可以使用 2 次"
  },
  State_59080_Name = {
    Text = "，可以使用 3 次"
  },
  State_59117_Desc = {
    Text = "暴击伤害 +[Layer]%。"
  },
  State_59117_Name = {
    Text = "暴击伤害"
  },
  State_59160_Desc = {
    Text = "造成的所有伤害、治疗与护盾效果提高 10 %，无法驱散。"
  },
  State_59160_Name = {
    Text = "<CardKeyWord:强效>"
  },
  State_59161_Desc = {
    Text = "造成的伤害、治疗与护盾效果提高 [DescArg1] %，无法驱散。"
  },
  State_59161_Name = {Text = "强效"},
  State_59169_Desc = {
    Text = "此牌基础算力消耗不会大于算力上限。__「仅开发用」"
  },
  State_59169_Name = {
    Text = "均衡__「仅开发用」"
  },
  State_59173_Name = {
    Text = "当此标记存在时，表示正在进行多重打击，不会再次触发多重打击。__「仅开发用」"
  },
  State_59208_Desc = {
    Text = "造成的所有伤害、治疗与护盾效果降低 10 %，无法驱散。"
  },
  State_59208_Name = {
    Text = "<WeaknessColour:强效降低>"
  },
  State_59209_Desc = {
    Text = "造成的伤害、治疗与护盾效果降低 [DescArg1] %，无法驱散。"
  },
  State_59209_Name = {
    Text = "强效降低"
  },
  State_59423_Desc = {
    Text = "莱克击杀敌人时获得 5 黑印，莱克每有 1% 黑印掉落就使获得量提高 1%，每场探索最多生效 5 次。\n通过战斗获取 50/125/250 黑印后，造物上限提高 1，战斗结束时选择一个「混沌的遗赠」加入造物列表。"
  },
  State_59423_Name = {
    Text = "赢家通吃"
  },
  State_59424_Desc = {
    Text = "探索中每消耗 1 点黑印，就使「肆意豪赌」的基础伤害提高 0.5%。"
  },
  State_59424_Name = {
    Text = "稳赚不赔"
  },
  State_59439_Desc = {
    Text = "此状态用的是易伤乘区，假装是个独立乘区。__「仅开发用」"
  },
  State_59439_Name = {
    Text = "若拥有某状态则受到伤害翻倍__「仅开发用」"
  },
  State_59519_Name = {
    Text = "选择 1 张抽牌堆或弃牌堆的指令卡置入手中，使其算力消耗变为 0"
  },
  State_59520_Desc = {
    Text = "打出后抽 2 张牌，使它们算力消耗降低刻印卡牌的实际算力消耗，每场战斗仅生效 1 次。"
  },
  State_59520_Name = {
    Text = "<WhiteQuality:智识之理>"
  },
  State_59521_Name = {
    Text = "失去 10% 当前生命([DescArg1])"
  },
  State_59522_Desc = {
    Text = "打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。"
  },
  State_59522_Name = {
    Text = "<WhiteQuality:欢愉之理>"
  },
  State_59525_Name = {
    Text = "指令卡对应的唤醒体获得 50 点狂气"
  },
  State_59526_Desc = {
    Text = "打出后获得 3 张附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始复制，每场战斗仅生效 1 次。"
  },
  State_59526_Name = {
    Text = "<WhiteQuality:繁育之理>"
  },
  State_59534_Name = {
    Text = "当此标记存在时，表示此牌禁止触发幻影。__「仅开发用」"
  },
  State_59560_Name = {
    Text = "选择一张获得过三大质体刻印的卡牌加入手中"
  },
  State_59671_Desc = {
    Text = "本回合所有唤醒体最终伤害提高 15%。"
  },
  State_59671_Name = {
    Text = "超弦怀表"
  },
  State_59673_Name = {
    Text = "小八音盒"
  },
  State_59678_Desc = {
    Text = "拾取时失去所有其他造物，随机获得 2 个黄金造物。"
  },
  State_59878_Desc = {
    Text = "回合结束时，额外减少 1 层「混沌」并获得 [StateArg1] <PowerIconKeywords:力量>。后续召唤的「N」的分身血量提高 200%，死亡后不再使「N」减少「混沌」层数与获取<PowerIconKeywords:力量>。"
  },
  State_59878_Name = {
    Text = "混沌降临"
  },
  State_59991_Name = {
    Text = "，此牌打出时最多消耗 5 层<EnergyStorageKeywords:蓄力>"
  },
  State_59993_Name = {
    Text = "回复 10% 已损失生命([DescArg1])"
  },
  State_60000_Desc = {
    Text = "每当承受主动伤害时，获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  State_60000_Name = {Text = "积怒"},
  State_60028_Desc = {
    Text = "玩家回合开始时，随机使其一张手牌算力消耗在本回合中变化为 3。死亡后该效果失效，并使击杀者所有卡牌算力消耗本回合降低 1。"
  },
  State_60028_Name = {
    Text = "谵妄樊笼"
  },
  State_60044_Name = {
    Text = "使用 [Layer] 次后消耗"
  },
  State_60083_Desc = {
    Text = "本回合承受的伤害降低 [Layer] %。"
  },
  State_60083_Name = {
    Text = "<ReinforceColour:加固>"
  },
  State_60083_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60085_Desc = {
    Text = "战斗开始和回合开始时获得临时加固，玩家生命越高获得越多层数，最大为 50 层。"
  },
  State_60085_Name = {
    Text = "终极蛹化"
  },
  State_60085_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60086_Desc = {
    Text = "战斗开始和回合开始时获得临时加固，玩家生命越高获得越多层数，最大为 25 层。"
  },
  State_60086_Name = {Text = "蛹化"},
  State_60086_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60087_Desc = {
    Text = "造成的重创效果变为降低 [Layer]% 生命回复。"
  },
  State_60087_Name = {
    Text = "<Rune_14_High:重创加深>"
  },
  State_60087_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60088_Desc = {
    Text = "每层使承受的所有伤害降低 1%。"
  },
  State_60088_Name = {
    Text = "<ReinforcePVEKeywords:加固>"
  },
  State_60088_WeaponDesc = {
    Text = "获得的所有护盾降低 25 %。"
  },
  State_60089_Desc = {
    Text = "承受的所有伤害降低 [Layer] %。"
  },
  State_60089_Name = {
    Text = "<ReinforceColour:加固>"
  },
  State_60089_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60106_Desc = {
    Text = "回合开始后，随机其一张手牌算力消耗变化为 3，回合结束时恢复。"
  },
  State_60106_Name = {
    Text = "谵妄樊笼"
  },
  State_60112_Desc = {
    Text = "本回合内每打出一张指令卡，就使所有唤醒体获得 1 点狂气。"
  },
  State_60112_Name = {Text = "协奏曲"},
  State_60115_Desc = {
    Text = "本回合释放狂气爆发后，降低双子融合度 3%。"
  },
  State_60115_Name = {Text = "安魂曲"},
  State_60118_Desc = {
    Text = "本回合造成的伤害、中毒、反击提高 [Layer]%。"
  },
  State_60118_Name = {Text = "狂想曲"},
  State_60128_Desc = {
    Text = "打出前改变卡牌算力"
  },
  State_60128_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_60129_Desc = {
    Text = "你打出的下 [Layer] 张非衍生指令卡算力消耗-2。"
  },
  State_60129_Name = {Text = "下行音"},
  State_60130_Desc = {
    Text = "你打出的下 [Layer] 张非衍生指令卡算力消耗+2，生效 2 次。"
  },
  State_60130_Name = {Text = "上行音"},
  State_60148_Desc = {
    Text = "回合结束时根据状态获得不同效果：放-获得 1 层临时<MadnessIconKeywords:疯狂>。敛-获得 50 层临时<ReinforcePVEKeywords:加固>。"
  },
  State_60148_Name = {
    Text = "参数拟合"
  },
  State_60150_Desc = {
    Text = "每当感知到玩家释放钥令后，立刻在放和敛两个形态间切换。切换至放时，立刻获得[StateArg1] 点临时力量。切换至敛时，立刻获得 [StateArg2] 点护盾。"
  },
  State_60150_Name = {
    Text = "机能感应"
  },
  State_60151_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_60151_Name = {
    Text = "尚未觉醒"
  },
  State_60154_Desc = {
    Text = "当前为形态-敛。机械武装将获得护盾和戒备，且意图会以防御为主。"
  },
  State_60154_Name = {
    Text = "机械武装-敛"
  },
  State_60155_Desc = {
    Text = "当前为形态-放。机械武装将获得力量，且意图会以攻击为主。"
  },
  State_60155_Name = {
    Text = "机械武装-放"
  },
  State_60167_Desc = {
    Text = "打出前改变卡牌算力"
  },
  State_60167_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_60184_Desc = {
    Text = "每当打出卡牌后，「矛盾双子」都会变化意图。"
  },
  State_60184_Name = {Text = "矛盾"},
  State_60187_Desc = {
    Text = "对玩家造成的虚弱、脆弱、重创状态均为 50%。"
  },
  State_60187_Name = {
    Text = "终结即是开始"
  },
  State_60201_Name = {
    Text = "怪物延迟力量"
  },
  State_60263_Desc = {
    Text = "造成的脆弱效果变为降低 [Layer]% 获得护盾。"
  },
  State_60263_Name = {
    Text = "<Rune_14_High:脆弱加深>"
  },
  State_60264_Desc = {
    Text = "造成的出血效果回合结束只会自动移除 50%。"
  },
  State_60264_Name = {
    Text = "<Rune_14_High: 溶血>"
  },
  State_60265_Desc = {
    Text = "出血效果回合结束只会自动移除 50%。"
  },
  State_60265_Name = {
    Text = "<BleedingColour: 溶血>"
  },
  State_60279_Name = {
    Text = "回合结束时此卡将被消耗"
  },
  State_60284_Desc = {
    Text = "战斗开始和回合开始时获得临时加固，玩家生命越低获得越多层数，最大为 50 层。"
  },
  State_60284_Name = {
    Text = "不破剑阵"
  },
  State_60284_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60297_Desc = {
    Text = "「@2」以解放之姿现世，生命变为原来的 3 倍。且每回合都会对守密人提出疑问，将一张「回答塔薇」置入手中。"
  },
  State_60297_Name = {
    Text = "真理问询"
  },
  State_60297_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_60298_Desc = {
    Text = "未知存在的力量仍蛰伏黑池之下，即将被击败前将彻底复苏，回复生命并以解放之姿开始战斗。"
  },
  State_60298_Name = {Text = "蛰伏"},
  State_60312_Desc = {
    Text = "每回合累计受到 10% 生命的伤害时，获得 [Layer] 层临时「加固」。"
  },
  State_60312_Name = {
    Text = "融蚀雾盾"
  },
  State_60315_Desc = {
    Text = "本回合释放狂气爆发后，回复已损失生命 5% ([DescArg1])。"
  },
  State_60315_Name = {Text = "安魂曲"},
  State_60336_Name = {
    Text = "打出后获得 1 点算力和抽 1 张牌，但此卡将被消耗"
  },
  State_60339_Name = {
    Text = "本回合打出后获得 1 点算力和抽 1 张牌，但此卡牌将被消耗"
  },
  State_60367_Desc = {
    Text = "玩家回合开始时，随机使其一张手牌算力消耗在本回合中变化为 3。死亡后该效果失效，并使击杀者所有卡牌算力消耗本回合降低 1。"
  },
  State_60367_Name = {
    Text = "谵妄樊笼"
  },
  State_60386_Desc = {
    Text = "效果包括：造成 150% 伤害的出血、造成 75% 伤害的中毒、施加 1 层虚弱、施加 1 层易伤、临时降低 [DescArg1] 点力量。"
  },
  State_60386_Name = {
    Text = "<MysterydebuffKeywords:奇妙负面效果>"
  },
  State_60404_Desc = {
    Text = "每受到 1 次伤害，获得 2 层临时加固。"
  },
  State_60404_Name = {
    Text = "终焉蜕变"
  },
  State_60408_Desc = {
    Text = "每当生命降低至 33% 时(还差 [DescArg1] 点)，本回合将不再受到伤害，释放「鬼面撕咬」。"
  },
  State_60408_Name = {
    Text = "鬼面撕咬"
  },
  State_60409_Desc = {
    Text = "每当生命降低至 66% 时(还差 [DescArg1] 点)，本回合将不再受到伤害，释放「终焉蜕变」。"
  },
  State_60409_Name = {
    Text = "终焉之镜"
  },
  State_60429_Name = {
    Text = "状态@唤醒体哈姆林@原初的乐音"
  },
  State_60430_Desc = {
    Text = "打出实际算力消耗和意图展示一致的卡牌时会将其消耗，并使所有敌人失去 [DescArg1] 点临时力量。"
  },
  State_60430_Name = {
    Text = "音符律令"
  },
  State_60431_Name = {
    Text = "状态@唤醒体哈姆林@上行音"
  },
  State_60432_Name = {
    Text = "状态@唤醒体哈姆林@灵魂序曲"
  },
  State_60433_Name = {
    Text = "状态@唤醒体哈姆林@下行音"
  },
  State_60434_Name = {
    Text = "状态@唤醒体哈姆林@追忆回旋曲"
  },
  State_60435_Name = {
    Text = "状态@唤醒体哈姆林@灵魂序曲计数"
  },
  State_60436_Desc = {
    Text = "造成未被格挡的伤害时，将[StateArg1] 张 「伤口」 洗入抽牌堆。"
  },
  State_60436_Name = {
    Text = "灵魂序曲"
  },
  State_60438_Name = {
    Text = "状态@唤醒体哈姆林@上行音监听"
  },
  State_60439_Name = {
    Text = "状态@唤醒体哈姆林@下行音监听"
  },
  State_60440_Name = {
    Text = "状态@唤醒体哈姆林@灵魂序曲监听"
  },
  State_60441_Name = {
    Text = "状态@唤醒体哈姆林@追忆回旋曲监听"
  },
  State_60442_Name = {
    Text = "状态@唤醒体哈姆林@原初的乐音监听"
  },
  State_60486_Desc = {
    Text = "战斗开始时，所有唤醒体狂气减半。"
  },
  State_60486_Name = {
    Text = "母神汲取"
  },
  State_60487_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，最大生命提高 200%，回复生命并以真正的形态开始战斗。"
  },
  State_60487_Name = {
    Text = "尚未觉醒"
  },
  State_60490_Desc = {
    Text = "死亡后所有唤醒体获得 30 点狂气。"
  },
  State_60490_Name = {Text = "生之欲"},
  State_60491_Desc = {
    Text = "所有唤醒体造成的狂气降低 50%。"
  },
  State_60491_Name = {
    Text = "母树之仪"
  },
  State_60493_Desc = {
    Text = "生命每累计降低 [Layer] 点后，召唤一个拟态唤醒体。若场上拟态唤醒体数量已达 2 个，则使所有拟态唤醒体最大生命提高 50%。"
  },
  State_60493_Name = {
    Text = "孕育之母"
  },
  State_60500_Desc = {
    Text = "当前若存在拟态唤醒体时，自身获得 50 层「隐匿」。"
  },
  State_60500_Name = {
    Text = "隐于林中"
  },
  State_60511_Desc = {
    Text = "一定在起始手牌中出现。"
  },
  State_60511_Name = {
    Text = "<GuyouKeywords:固有>"
  },
  State_60511_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_60522_Desc = {
    Text = "造成的脆弱和重创效果提高至 50%。"
  },
  State_60522_Name = {Text = "破灭"},
  State_60523_Desc = {
    Text = "每层使攻击次数加1，受到伤害失去一层，回合结束时失去全部。"
  },
  State_60523_Name = {Text = "祈祷"},
  State_60524_Desc = {
    Text = "战斗开始和回合开始时获得 [Layer] 层加固，最大为 50 层。"
  },
  State_60524_Name = {Text = "圣化"},
  State_60524_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_60527_Desc = {
    Text = "打出后被消耗，但会降低敌人的临时力量。"
  },
  State_60527_Name = {
    Text = "<CardKeyWord:旋律天国>"
  },
  State_60543_Desc = {
    Text = "回合结束时获得 10 层「血誓」，「血誓」在受到伤害后会移除 1 层。"
  },
  State_60543_Name = {
    Text = "灯心之火"
  },
  State_60554_Name = {
    Text = "<HuihuanbKeywords:回环乐音>"
  },
  State_60558_Name = {
    Text = "<HuihuanbKeywords:回环乐音>"
  },
  State_60562_Desc = {
    Text = "打出后生效 2 次，改为「蓄势乐音」"
  },
  State_60562_Name = {
    Text = "<HuihuanaKeywords:回环乐音>"
  },
  State_60564_Desc = {
    Text = "当第一次即将被击败时，回复生命并转变意图为 「终焉进化」，获得力量和加固。当第二次即将被击败时，回复生命并转变意图为 「鬼面撕咬」，造成超高额单次伤害。"
  },
  State_60564_Name = {
    Text = "阴影的恶鬼"
  },
  State_60567_Desc = {
    Text = "打出后哈姆林获得 3 点狂气。"
  },
  State_60567_Name = {
    Text = "<XushiAKeywords:蓄势乐音>"
  },
  State_60568_Name = {
    Text = "<XushiAKeywords:蓄势乐音>"
  },
  State_60569_Name = {
    Text = "<XushiBKeywords:蓄势乐音>"
  },
  State_60570_Desc = {
    Text = "打出后哈姆林获得 3 点狂气。"
  },
  State_60570_Name = {
    Text = "<XushiBKeywords:蓄势乐音>"
  },
  State_60571_Name = {
    Text = "<HuihuanaKeywords:回环乐音>"
  },
  State_60576_Desc = {
    Text = "玩家回合开始时，随机使其一张手牌算力消耗在本回合中变化为 3。死亡后该效果失效，并使击杀者所有卡牌算力消耗本回合降低 1。"
  },
  State_60576_Name = {
    Text = "谵妄樊笼"
  },
  State_60578_Desc = {
    Text = "受到致命伤害时将会回复 50% 生命，免疫伤害 1 回合，意图变为「破蛹」。"
  },
  State_60578_Name = {Text = "破蛹"},
  State_60592_Desc = {
    Text = "队伍唯一：探索开始时，将 1 张「银钥曦光」洗入抽牌堆并附加<DestructionKeywords:销毁>。释放钥令后，装备者暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者造成主动伤害时，获得等同于装备者银钥充能 <WeaponEffect_Num:[StateArg2]%> 的银钥能量和 <WeaponEffect_Num:[StateArg3]%> 临时暴击率，每回合最多生效 5 次。"
  },
  State_60592_WeaponDesc = {
    Text = "探索开始时，将 1 张「银钥曦光」洗入抽牌堆并附加<DestructionKeywords:销毁>。释放钥令后，装备者暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者造成主动伤害时，获得 <WeaponEffect_Num:[DescArg1]> 点银钥能量和 <WeaponEffect_Num:[StateArg3]%> 临时暴击率，每回合最多生效 5 次。"
  },
  State_60594_Desc = {
    Text = "队伍唯一：回合结束后，装备者获得 5 点狂气。装备者释放狂气爆发后，本回合打出的下一张装备者的指令卡暴击率、暴击伤害、护盾、回复生命提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_60594_WeaponDesc = {
    Text = "回合结束后，装备者获得 5 点狂气。装备者释放狂气爆发后，本回合打出的下一张装备者的指令卡暴击率、暴击伤害、护盾、回复生命提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_60898_Desc = {
    Text = "承受主动和触腕伤害时，封印攻击唤醒体的狂气爆发和所有卡牌 1 回合，移除 1 层<ResentChainsKeywords:怨恨锁链>。"
  },
  State_60898_Name = {
    Text = "<ResentChainsKeywords1:怨恨锁链>"
  },
  State_60925_Desc = {
    Text = "回合结束时，回复 5% 已损失生命。每当玩家抽到 1 张症状或状态卡时，全体友方获得 [Layer] 点力量。"
  },
  State_60925_Name = {
    Text = "血之提灯"
  },
  State_60926_Desc = {
    Text = "回合结束时若当前生命低于 50%，则获得 [Layer] 点力量和 [StateArg1] 层屏障。"
  },
  State_60926_Name = {
    Text = "提灯圣坛"
  },
  State_60953_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」前对全体敌方造成 [StateArg1] 层<PVPSlowKeywords:迟缓>。"
  },
  State_60953_Name = {
    Text = "永恒安魂曲"
  },
  State_60962_Desc = {
    Text = "本场战斗中，最大生命值提高 [Layer]%。"
  },
  State_60962_Name = {
    Text = "生命提高"
  },
  State_60964_Desc = {
    Text = "本场战斗中，伤害提高 [Layer]%。"
  },
  State_60964_Name = {
    Text = "伤害提高"
  },
  State_61038_Name = {
    Text = "哈姆林试玩"
  },
  State_61050_Desc = {
    Text = "触发「乐音」效果或打出 「协乐的交响」后，哈姆林获得 1% 暴击率和暴击伤害(当前已获得 [DescArg1]% ) 。该效果每触发 10 次，本场战斗「灵魂序曲」和「原初的乐音」伤害次数提高 1，最多提高 3 次。"
  },
  State_61050_Name = {
    Text = "月下狂想"
  },
  State_61051_Desc = {
    Text = "触发「乐音」效果或打出 「协乐的交响」后，哈姆林获得 1% 暴击率和暴击伤害。该效果每触发 10 次，本场战斗「灵魂序曲」和「原初的乐音」伤害次数提高 1，最多提高 3 次。"
  },
  State_61051_Name = {
    Text = "月下狂想"
  },
  State_61056_Desc = {
    Text = "首回合获得 100 点临时力量。"
  },
  State_61056_Name = {Text = "狂暴"},
  State_61084_Desc = {
    Text = "本回合打出的下 [Layer] 张卡牌：若算力消耗大于等于 3，获得 2 点算力，否则抽 2 张牌。"
  },
  State_61084_Name = {
    Text = "第四乐章"
  },
  State_61085_Desc = {
    Text = "算力消耗- 2，打出后生效 2 次，改为「蓄势乐音」"
  },
  State_61085_Name = {
    Text = "<HuihuanbKeywords:回环乐音>"
  },
  State_61089_Desc = {
    Text = "打出的下 1 张指令卡生效 2 次。"
  },
  State_61089_Name = {
    Text = "乐团指挥棒"
  },
  State_61145_Name = {
    Text = "<BleedingColour: 出血>"
  },
  State_61174_Desc = {
    Text = "无法获得护盾。"
  },
  State_61174_Name = {
    Text = "余孽送葬"
  },
  State_61180_Desc = {
    Text = "血链·希洛的基础伤害在本场战斗中提高 [DescArg1] %。"
  },
  State_61180_Name = {
    Text = "复仇之刃"
  },
  State_61185_Desc = {
    Text = "会使敌人的技能得到增幅。每当受到伤害时失去一层。"
  },
  State_61185_Name = {Text = "血誓"},
  State_62213_Desc = {
    Text = "造成的虚弱效果变为降低 [Layer]% 造成的主动和触腕伤害。"
  },
  State_62213_Name = {
    Text = "<Rune_14_High:虚弱加深>"
  },
  State_62309_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] <StrongEffectKeywords:强效>。每当失去生命后，若当前生命低于 [StateArg2]%，获得<ReinforceKeywords:加固>和<StrengthenKeywords:强化>。"
  },
  State_62309_Name = {
    Text = "沉入殷红"
  },
  State_62317_Desc = {
    Text = "免疫一切伤害，回合开始后移除。"
  },
  State_62317_Name = {
    Text = "完全免疫伤害"
  },
  State_62336_Desc = {
    Text = "每打出 3 张卡牌(还剩 [Layer] 张)，抽 1 张卡并随机冻结手牌中的 1 张指令卡。"
  },
  State_62336_Name = {
    Text = "凛冬之寒"
  },
  State_62337_Desc = {
    Text = "每打出 3 张卡牌(还剩 [Layer] 张)，抽 1 张牌并随机冻结手牌中的 1 张指令卡。"
  },
  State_62337_Name = {
    Text = "凛冬之寒"
  },
  State_62338_Desc = {
    Text = "此卡不可打出，回合结束时不会丢弃，并使所属唤醒体获得 5 点狂气，所属唤醒体释放狂气爆发后，解除冻结。"
  },
  State_62338_Name = {
    Text = "<CardKeyWord:冻结>"
  },
  State_65332_Desc = {
    Text = "死亡后所有唤醒体获得 30 点狂气。"
  },
  State_65332_Name = {Text = "消融"},
  State_65342_Desc = {
    Text = "被击败后将会复活，额外增加 100% 最大生命并释放「霜寒彻骨」。"
  },
  State_65342_Name = {Text = "沉寂"},
  State_65346_Desc = {
    Text = "死亡后，冻结手牌堆的 2 张指令卡。"
  },
  State_65346_Name = {Text = "霜降"},
  State_65358_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者释放狂气爆发前，临时手牌上限 +1，抽 1 张装备者的指令卡。若当前界域为 「血肉」，装备者触发吞噬时临时暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，每回合最多生效 1 次。"
  },
  State_65358_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。装备者释放狂气爆发前，临时手牌上限 +1，抽 1 张装备者的指令卡。若当前界域为 「血肉」，装备者触发吞噬时临时暴击伤害提高 <WeaponEffect_Num:[StateArg1]%>，每回合最多生效 1 次。"
  },
  State_65360_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。战斗开始时，装备者获得 25 层「冰雪」，装备者打出卡牌后获得 2 点狂气并移除 1 层。「冰雪」被完全移除后，装备者获得 <WeaponEffect_Num:[StateArg2]%> 暴击率。"
  },
  State_65360_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。战斗开始时，装备者获得 25 层「冰雪」，装备者打出卡牌后获得 2 点狂气并移除 1 层。「冰雪」被完全移除后，装备者获得 <WeaponEffect_Num:[StateArg2]%> 暴击率(当前剩余 [DescArg1] 层冰雪)"
  },
  State_65362_Desc = {
    Text = "每累计受到 [StateArg1] 次主动伤害后（还剩 [Layer]）次，随机冻结手牌中 1 张指令卡。"
  },
  State_65362_Name = {Text = "霜返"},
  State_65463_Name = {
    Text = "获得 5 点黑印"
  },
  State_65490_Desc = {
    Text = "回合结束时获得 [StateArg1] 层霜盾和  [StateArg2]  点力量。"
  },
  State_65490_Name = {
    Text = "绝对零度"
  },
  State_65497_Name = {
    Text = "血链·希洛试玩"
  },
  State_65553_Desc = {
    Text = "回合结束时，根据剩余手牌数获得力量，每张获得 [Layer] 点。"
  },
  State_65553_Name = {
    Text = "冰之锋刃"
  },
  State_65557_Desc = {
    Text = "受到致命伤害后将回复所有生命，意图转化为「真·深空注目」，获得 80 层临时加固并移除自身负面状态和玩家正面状态。回合结束时，自身移除 20 层加固。"
  },
  State_65557_Name = {
    Text = "亘古混沌"
  },
  State_65558_Desc = {
    Text = "受到致命伤害后意图转化为「深空注目」并获得 80 层临时加固，回复所有生命，可触发 [DescArg1] 次。触发次数用尽后受到致命伤害后会保留 1 点生命，将意图变为「万千世界之眼」。回合结束时，自身移除 20 层加固。"
  },
  State_65558_Name = {Text = "星屑"},
  State_65559_Desc = {
    Text = "全部死亡后托乎瓦波将再度出现。"
  },
  State_65559_Name = {
    Text = "亘古碎屑"
  },
  State_65564_Name = {
    Text = "\n<D05EX_Relic:科考团成员们对希洛的怀疑不断加深，你必须在敌人逼近前做出选择，安抚混乱的团队>"
  },
  State_65565_Name = {
    Text = "\n<D05EX_Relic:无视团员的猜疑，继续前进>"
  },
  State_65566_Name = {
    Text = "\n<D05EX_Relic:和科考团员解释情况>"
  },
  State_65567_Name = {
    Text = "\n<D05EX_Relic:约束希洛来进一步保护团员>"
  },
  State_65568_Name = {
    Text = "\n<D05EX_Relic:约束希洛，并使用唤醒体的力量全力保护团员>"
  },
  State_65585_Desc = {
    Text = "此卡牌打出后回到手牌中，直到回合结束前刻印失效。"
  },
  State_65585_Name = {
    Text = "<CardKeyWord:回响>"
  },
  State_66305_Desc = {
    Text = "回合结束时，获得 1 层临时<ResentChainsKeywords:怨恨锁链>。"
  },
  State_66305_Name = {
    Text = "亘古穿今之锁"
  },
  State_66306_Desc = {
    Text = "承受主动和触腕伤害时，封印攻击唤醒体的狂气爆发和所有卡牌 1 回合，移除 1 层<ResentChainsKeywords:怨恨锁链>。"
  },
  State_66306_Name = {
    Text = "<ResentChainsKeywords1:怨恨锁链>"
  },
  State_66308_Desc = {
    Text = "受到致命伤害后锁定生命为 1。"
  },
  State_66308_Name = {
    Text = "亘古混沌"
  },
  State_66311_Desc = {
    Text = "与唤醒体们的记忆从你脑海边缘涌出，在你脑中扎根、生长。无论你将它们斩断多少次，无论融蚀将它们倾覆多少次，它们从未离开过。"
  },
  State_66311_Name = {
    Text = "破碎的记忆"
  },
  State_66313_Desc = {
    Text = "每打出 1 张指令卡，弃掉 1 张该唤醒体算力消耗最低的卡牌。"
  },
  State_66313_Name = {
    Text = "无上意志之威压"
  },
  State_66314_Desc = {
    Text = "免疫一切伤害。"
  },
  State_66314_Name = {
    Text = "完全免疫伤害"
  },
  State_66317_Desc = {
    Text = "与唤醒体们的记忆从你脑海边缘涌出，在你脑中扎根、生长。无论你将它们斩断多少次，无论融蚀将它们倾覆多少次，它们从未离开过。每回合开始时回复 1 点算力上限与 2 张手牌上限。"
  },
  State_66317_Name = {
    Text = "记忆碎片"
  },
  State_66325_Desc = {
    Text = "与唤醒体们的记忆从你脑海边缘涌出，在你脑中扎根、生长。无论你将它们斩断多少次，无论融蚀将它们倾覆多少次，它们从未离开过。每回合开始时回复 1 点算力上限与 2 张手牌上限。"
  },
  State_66325_Name = {
    Text = "记忆碎片"
  },
  State_66358_Desc = {
    Text = "探索中首次触发死亡抵抗时，将一张「<DerivativeCardKeywords_39:过往回声>」置入手中。"
  },
  State_66358_Name = {
    Text = "不存在的存在"
  },
  State_66359_Desc = {
    Text = "随机产生若干个选项来进行选择。"
  },
  State_66359_Name = {
    Text = "<FaxianKeywords:发现>"
  },
  State_66360_Desc = {
    Text = "本场战斗内暴击率提高 [Layer] %。"
  },
  State_66360_Name = {Text = "暴击率"},
  State_66362_Desc = {
    Text = "本场战斗内暴击伤害提高 [Layer] %。"
  },
  State_66362_Name = {
    Text = "暴击伤害"
  },
  State_66409_Name = {
    Text = "代行者之裁"
  },
  State_66410_Desc = {
    Text = "下 [DescArg1] 张打出的塔薇的指令卡生效 2 次。"
  },
  State_66410_Name = {
    Text = "万物归一"
  },
  State_66414_Desc = {
    Text = "在手牌中时，若抽牌堆顶部的卡牌为指令卡，变为其复制。"
  },
  State_66414_Name = {
    Text = "通晓万物之理"
  },
  State_66454_Desc = {
    Text = "技能卡算力消耗降低「隐匿」层数，最多可堆叠 5 层，受到伤害或打出技能后移除 1 层。"
  },
  State_66454_Name = {Text = "隐匿"},
  State_66456_Desc = {
    Text = "技能卡算力消耗降低「隐匿」层数，最多可堆叠 5 层，受到伤害或打出技能后移除 1 层。"
  },
  State_66456_Name = {
    Text = "<YinniColour:隐匿>"
  },
  State_66465_Desc = {
    Text = "使用狂气爆发后，受到对应层数的伤害。"
  },
  State_66465_Name = {
    Text = "<PVPfengsuoColour:爆发封锁>"
  },
  State_66522_Desc = {
    Text = "你每打出的第 8 张牌会生效 2 次。"
  },
  State_66522_Name = {
    Text = "群星之酒"
  },
  State_66553_Desc = {
    Text = "打出「打击」与「防御」后，对应唤醒体获得 35 狂气。但是它们的算力消耗+1。"
  },
  State_66553_Name = {
    Text = "残缺面孔"
  },
  State_66554_Desc = {
    Text = "拾取时，将 1 张<DerivativeCardKeywords_1:「遗影回响」>置入手中。"
  },
  State_66554_Name = {
    Text = "通讯设备"
  },
  State_66555_Desc = {
    Text = "最大算力提高 1 。"
  },
  State_66555_Name = {
    Text = "活性注射器"
  },
  State_66556_Desc = {
    Text = "每当连续打出同一个唤醒体的牌，该唤醒体获得 8 狂气。"
  },
  State_66556_Name = {
    Text = "精密计时器"
  },
  State_66557_Desc = {
    Text = "每当你失去生命，就获得 [DescArg1] 点<PowerIconKeywords:力量>，每场战斗最多堆叠 10 次。层数满时，回复已损失生命值 25% 的生命。"
  },
  State_66557_Name = {
    Text = "无上荣宠"
  },
  State_66558_Desc = {
    Text = "每 3 回合对所有敌人添加 1 层<WeaknessIconKeywords:虚弱>。对<WeaknessIconKeywords:虚弱>敌人造成伤害后获得  [DescArg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  State_66558_Name = {Text = "恶童"},
  State_66559_Desc = {
    Text = "打出 1 张算力消耗为 3 或以上的卡牌时，抽 1 张牌并获得 1 点算力。"
  },
  State_66559_Name = {
    Text = "失落之美"
  },
  State_66560_Desc = {
    Text = "「打击」获得 2 点算力，随机弃 1 张牌；「防御」抽 2 张牌，失去 1 点算力。每回合最多触发 3 次。"
  },
  State_66560_Name = {
    Text = "快乐唱片"
  },
  State_66561_Desc = {
    Text = "每 3 回合对所有敌人添加 1 层<VulnerabilityIconKeywords:易伤>。对<VulnerabilityIconKeywords:易伤>敌人造成伤害后，使其失去 [DescArg1] 点临时<PowerIconKeywords:力量>，每回合最多触发 3 次。"
  },
  State_66561_Name = {Text = "春之祭"},
  State_66562_Desc = {
    Text = "每 4 回合使所有敌人本回合受到的伤害翻倍，但在该回合中释放狂气爆发后，封印所有唤醒体 1 回合。"
  },
  State_66562_Name = {
    Text = "行道之骸"
  },
  State_66563_Desc = {
    Text = "回合开始时，如果上个回合打出卡牌数超过 3 张，抽 2 张牌。"
  },
  State_66563_Name = {
    Text = "崭新的钱包"
  },
  State_66564_Desc = {
    Text = "拾取时，获得 3 点算力。"
  },
  State_66564_Name = {Text = "怀表镜"},
  State_66565_Desc = {
    Text = "拾取时，对所有敌人施加 1 回合<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>。"
  },
  State_66565_Name = {
    Text = "变色拘束服"
  },
  State_66566_Desc = {
    Text = "每回合开始时<DeathResistanceIconKeywords:死亡抵抗>提高 10%（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。<DeathResistanceIconKeywords:死亡抵抗>在 100% 以上时，<ProficientInRealmsIconKeywords:界域精通>提高 100。"
  },
  State_66566_Name = {
    Text = "人鱼泪珠"
  },
  State_66703_Desc = {
    Text = "队伍唯一：银钥积攒上限提高 100%。手牌上限+2，无法和其他命轮提供的手牌上限叠加。装备者银钥充能提高 <WeaponEffect_Num:[StateArg1]%>。装备者打出卡牌后，本回合装备者指令卡暴击率和暴击伤害、造成的护盾、狂气和力量获取效果提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 层。"
  },
  State_66703_WeaponDesc = {
    Text = "银钥积攒上限提高 100%。手牌上限+2，无法和其他命轮提供的手牌上限叠加。装备者银钥充能提高 <WeaponEffect_Num:[DescArg2]>。装备者打出卡牌后，本回合装备者指令卡暴击率和暴击伤害、造成的护盾、狂气和力量提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 层(当前 [DescArg1] 层)。"
  },
  State_66722_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [StateArg1] 层<PVPProtectiveKeywords:屏障>，否则获得<StrengthenKeywords:强化>。"
  },
  State_66722_Name = {
    Text = "隐世的转轮"
  },
  State_66872_Desc = {
    Text = "塔薇造成的伤害、护盾、生命回复临时提高 [StateArg1]%，持续 [Layer] 回合。"
  },
  State_66872_Name = {
    Text = "无限亿万光辉"
  },
  State_66884_Desc = {
    Text = "回合结束时，算力消耗降低，被弃掉时也会触发该效果。"
  },
  State_66884_Name = {
    Text = "<PrepareKeypvewords:预备1>"
  },
  State_66888_Desc = {
    Text = "队伍唯一：释放钥令后，获得装备者攻击力 <WeaponEffect_Num:[StateArg1]%> 的<PowerIconKeywords:力量>和防御力 <WeaponEffect_Num:[StateArg2]%> 的护盾。使用应急灵知体后，回合结束时所有唤醒体获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_66888_Name = {
    Text = "纯银的初心"
  },
  State_66888_WeaponDesc = {
    Text = "释放钥令后，获得 <WeaponEffect_Num:[Power:DescArg1]> 点<PowerIconKeywords:力量>和 <WeaponEffect_Num:[Block:DescArg2]> 点护盾。使用应急灵知体后，回合结束时所有唤醒体获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_66893_Desc = {
    Text = "队伍唯一：战斗开始后，获得等同于装备者 <WeaponEffect_Num:[StateArg1]%> 银钥充能的银钥能量。每场战斗首次释放钥令后，重复一次该效果。"
  },
  State_66893_WeaponDesc = {
    Text = "战斗开始后，获得 <WeaponEffect_Num:[DescArg1]> 点银钥能量。每场战斗首次释放钥令后，重复一次该效果。"
  },
  State_66896_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_66900_Desc = {
    Text = "此卡牌伤害、治疗、护盾提高 [StateArg1]%"
  },
  State_66900_Name = {
    Text = "纯银的初心"
  },
  State_66901_Desc = {
    Text = "造成的伤害、治疗与护盾效果提高 [DescArg1] %，持续 1 回合"
  },
  State_66901_Name = {
    Text = "临时强效"
  },
  State_66902_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方唤醒体死亡后，获得 <Block:[Block:StateArg1]> 护盾，将其算力消耗最低的「技能」置入手中。"
  },
  State_66902_Name = {
    Text = "纯银的初心"
  },
  State_66971_Desc = {
    Text = "当生命降低至 0 时，使生命变为 1 点，不再受到伤害。"
  },
  State_66971_Name = {
    Text = "世界断绝"
  },
  State_67234_Desc = {
    Text = "回合结束时，召唤一名「缸中之脑分体」，持续 [Layer] 回合。"
  },
  State_67234_Name = {Text = "分离"},
  State_67235_Desc = {
    Text = "死亡时回复所有生命，生命上限+100%，释放「灵魂瘟疫」。"
  },
  State_67235_Name = {
    Text = "尚未觉醒"
  },
  State_67237_Desc = {
    Text = "达到 10 层时，意图改变为「虚无终结」：将对手的生命上限变为 1 。"
  },
  State_67237_Name = {Text = "终末"},
  State_67238_Desc = {
    Text = "回合结束时，获得 1 层「终末」。受到致死伤害后移除该状态并免疫 1 回合伤害，回复 15% 生命并获得 10 层「终末」。"
  },
  State_67238_Name = {
    Text = "灵魂瘟疫"
  },
  State_67240_Desc = {
    Text = "「知者」获得 25 层临时<ReinforcePVEKeywords:加固>和 [Power:StateArg1] 点临时<PowerIconKeywords:力量> ，移除该状态。"
  },
  State_67240_Name = {
    Text = "<TuiyanColour:推演>"
  },
  State_67241_Desc = {
    Text = "死亡时回复所有生命，生命上限+100%，释放「骑士热诚」。"
  },
  State_67241_Name = {
    Text = "尚未觉醒"
  },
  State_67242_Desc = {
    Text = "死亡时回复所有生命，生命上限+100%，释放「灵肉@1分」。"
  },
  State_67242_Name = {
    Text = "尚未觉醒"
  },
  State_67243_Desc = {
    Text = "回合结束时，召唤一名「缸中之脑分体」。缸中之脑分体触发「灵质分离」时，额外偷取玩家 5% 的力量。"
  },
  State_67243_Name = {
    Text = "灵肉@1分"
  },
  State_67245_Desc = {
    Text = "回合结束时，获得 [StateArg1] 点<PowerIconKeywords:力量>。"
  },
  State_67245_Name = {
    Text = "骑士热诚"
  },
  State_67246_Desc = {
    Text = "每回合首次被击破护盾时，失去 25％最大生命，获得 [Power:DescArg1] 点<PowerIconKeywords:临时力量>和 [Layer] 层临时加固。下回合开始时，重新获得 <Block:[Block:DescArg2]> 层护盾，每触发一次「骑士的信仰」额外获得 1 次护盾。"
  },
  State_67246_Name = {
    Text = "骑士的信仰"
  },
  State_67247_Desc = {
    Text = "每回合结束时都会补充敌人，至多同时存在 2 个敌人。敌人死亡后，「腐坏之脑」失去 5% 最大生命。"
  },
  State_67247_Name = {
    Text = "深渊之门"
  },
  State_67252_Desc = {
    Text = "受到致命伤害时，移动到后排并保留 1 点生命，之后无法再次受到任何伤害，<PowerIconKeywords:力量>提高 [DescArg1] 。自爆不会触发该效果。"
  },
  State_67252_Name = {
    Text = "灵质分离"
  },
  State_67253_Desc = {
    Text = "打出 [Layer] 张卡牌后，在前方生成 1 名「缸中之脑分体」，最多同时存在 3 个分体。"
  },
  State_67253_Name = {
    Text = "缸中之脑"
  },
  State_67255_Desc = {
    Text = "死亡时回复所有生命，生命上限+100%，释放「第一哲学」。"
  },
  State_67255_Name = {
    Text = "尚未觉醒"
  },
  State_67256_Desc = {
    Text = "抽牌阶段后，从手牌中随机展示三张指令卡，选择一张赋予「回声」刻印，弃掉其它卡牌。"
  },
  State_67256_Name = {
    Text = "第一哲学"
  },
  State_67257_Desc = {
    Text = "每回合首次释放钥令后，所有唤醒体获得 10 狂气，但释放钥令消耗永久提高 10%。"
  },
  State_67257_Name = {
    Text = "逐渐断裂的链接"
  },
  State_67258_Desc = {
    Text = "战斗开始时，获得 <Block:[Block:DescArg1]> 层护盾。回合结束时，护盾不会消失。"
  },
  State_67258_Name = {
    Text = "骑士的决心"
  },
  State_67347_Desc = {
    Text = "在手牌中时，若抽牌堆顶部的卡牌为指令卡，变为其算力消耗-1 的复制。"
  },
  State_67347_Name = {
    Text = "通晓万物之理"
  },
  State_67353_Desc = {
    Text = "死亡后「腐坏之脑」失去 5% 最大生命。"
  },
  State_67353_Name = {Text = "熔毁"},
  State_67358_Desc = {
    Text = "每当玩家消耗 1 点算力，立刻获得 <Block:[Block:StateArg1]> 点护盾和 3 层临时加固。"
  },
  State_67358_Name = {
    Text = "不定壁垒"
  },
  State_67414_Desc = {
    Text = "不可直视的眼目。不可违逆的气息。做到一切的碎片也只是碎片。现在，迎接注定毁灭的结局吧……"
  },
  State_67414_Name = {
    Text = "直面万千本源"
  },
  State_67418_Desc = {
    Text = "打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。"
  },
  State_67418_Name = {
    Text = "<WhiteQuality:高级欢愉之理>"
  },
  State_67419_Desc = {
    Text = "打出后获得 3 张附加<RetainIconKeywords:保留>和<DepleteIconKeywords:消耗>的原始复制并使它们算力消耗-1，每场战斗仅生效 1 次。"
  },
  State_67419_Name = {
    Text = "<WhiteQuality:高级繁育之理>"
  },
  State_67420_Desc = {
    Text = "打出后抽 4 张牌，使它们算力消耗降低刻印卡牌的实际算力消耗，每场战斗仅生效 1 次。"
  },
  State_67420_Name = {
    Text = "<WhiteQuality:高级智识之理>"
  },
  State_67598_Desc = {
    Text = "释放狂气爆发后，将一张对应唤醒体的随机卡牌置入手中，该卡牌获得<DepleteIconKeywords:消耗>与<NothingnessIconKeywords:虚无>。战斗结束后，回复 [DescArg1] 点生命。"
  },
  State_67598_Name = {
    Text = "医生手提箱"
  },
  State_67599_Desc = {
    Text = "非「打击」「防御」的指令卡打出后，对应唤醒体获得 15 点狂气，每回合最多触发 5 次。每回合第 1 次触发时，还会将打出的卡牌移回手中。"
  },
  State_67599_Name = {
    Text = "时灵摆·投射"
  },
  State_67600_Desc = {
    Text = "最大算力提高 4，每次重置牌库时将 4 张<DerivativeCardKeywords_4:「灵感」>加入抽牌堆。"
  },
  State_67600_Name = {
    Text = "受祝·黑烛"
  },
  State_67602_Name = {Text = "废弃"},
  State_67603_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 20%，击杀敌人后击杀者获得 20 狂气。"
  },
  State_67603_Name = {
    Text = "祭司权杖"
  },
  State_67604_Desc = {
    Text = "每打出一张与上一张所属唤醒体不同的指令卡，其所属唤醒体获得 3 点狂气，并积攒 1 层「活性」。积攒 10 层时将所有「活性」清空，将所有唤醒体各一张算力消耗减1且具备「消耗」的随机指令卡置入手中，每回合最多生效 1 次。"
  },
  State_67604_Name = {
    Text = "时灵摆·衍化"
  },
  State_67605_Desc = {
    Text = "当你拥有护盾时，该造物提供 [DescArg1] 点临时<PowerIconKeywords:力量>。在你的护盾高于当前生命时，额外提供 [DescArg2] 点临时<PowerIconKeywords:力量>。"
  },
  State_67605_Name = {Text = "鸽羽扇"},
  State_67606_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 1 算力。主动伤害击杀敌人时，对其他敌人造成等同于过量伤害的<BleedingIconKeywords:出血>。"
  },
  State_67606_Name = {
    Text = "群氓之歌"
  },
  State_67607_Desc = {
    Text = "每释放 5 次狂气爆发后，使释放狂气爆发的唤醒体获得 100 狂气。"
  },
  State_67607_Name = {
    Text = "小小襁褓"
  },
  State_67608_Name = {Text = "废弃"},
  State_67609_Desc = {
    Text = "释放狂气爆发后，失去 8% 当前生命，偷取所有敌人 [DescArg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [DescArg2] 点临时<PowerIconKeywords:力量>。"
  },
  State_67609_Name = {
    Text = "厄运仪式鸟"
  },
  State_67611_Desc = {
    Text = "每 2 回合使所有敌人受到的伤害翻倍，在本回合每释放 1 次狂气爆发，随机驱散 1 种负面状态。"
  },
  State_67611_Name = {
    Text = "受祝·行道之骸"
  },
  State_67612_Desc = {
    Text = "所有「打击」造成的暴击伤害提高 20%。拾取时，将 1 张<DerivativeCardKeywords_40:「美丽瞬间 」>加入手中。"
  },
  State_67612_Name = {
    Text = "美丽瞬间β"
  },
  State_67614_Desc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时，最大生命变为 1.5 倍。"
  },
  State_67614_Name = {
    Text = "受祝·噩梦表象β"
  },
  State_67615_Desc = {
    Text = "每打出的第 6 张指令卡使其从弃牌堆回到手中。"
  },
  State_67615_Name = {
    Text = "在夕光里"
  },
  State_67616_Name = {Text = "废弃"},
  State_67618_Desc = {
    Text = "每回合开始时所有唤醒体获得 25 狂气。拾取时最大生命变为 1.5 倍。"
  },
  State_67619_Desc = {
    Text = "手牌上限提高 5。拾取时，补充手牌至上限。回合开始时额外抽 1 张牌，回合结束时弃掉手中所有症状卡和状态卡，保留其他卡牌。"
  },
  State_67619_Name = {
    Text = "受祝·意识铭刻β"
  },
  State_67620_Desc = {
    Text = "每回合打出第 3 张卡牌后，将 1 张<DerivativeCardKeywords_4:「灵感」>置入弃牌堆。每回合打出第 6 张卡牌后，从弃牌堆中将 1 张<DerivativeCardKeywords_4:「灵感」>置入手牌。"
  },
  State_67620_Name = {
    Text = "文明之光"
  },
  State_67621_Desc = {
    Text = "释放狂气爆发后，获得 [DescArg1] 点临时力量，并偷取所有敌人 [DescArg1] 点临时<PowerIconKeywords:力量>，若只有 1 名敌人，额外偷取 [DescArg2] 点临时<PowerIconKeywords:力量>。"
  },
  State_67621_Name = {
    Text = "受祝·厄运仪式鸟"
  },
  State_67622_Desc = {
    Text = "耗尽最后 1 点算力时，获得 2 算力。每回合最多触发 2 次。"
  },
  State_67622_Name = {
    Text = "银白差分机"
  },
  State_67623_Desc = {
    Text = "拾取后永久获得 [DescArg1] <PowerIconKeywords:力量> 。每当造成伤害时，回复 [DescArg2] 点生命，每回合最多触发 6 次。"
  },
  State_67623_Name = {
    Text = "受祝·七鳃鳗之吻"
  },
  State_67624_Name = {Text = "废弃"},
  State_67625_Desc = {
    Text = "每回合首次打出指令卡进入弃牌堆后，将算力消耗降低 1 的该卡牌临时复制洗入抽牌堆。"
  },
  State_67625_Name = {
    Text = "失声唱机"
  },
  State_67626_Desc = {
    Text = "最大算力提高 1 。连续 2 次打出比上一张算力消耗更高的卡牌时，获得 1 算力。"
  },
  State_67626_Name = {
    Text = "阿尔卡纳记录"
  },
  State_67628_Name = {Text = "废弃"},
  State_67630_Name = {Text = "废弃"},
  State_67631_Desc = {
    Text = "最大算力提高 2。每次重置牌库时将 1 张<DerivativeCardKeywords_9:「蹒跚」>加入抽牌堆。"
  },
  State_67631_Name = {Text = "黑烛"},
  State_67632_Name = {Text = "废弃"},
  State_67634_Desc = {
    Text = "回合结束时手中每有 1 张未打出的卡牌，就使所有唤醒体获得 2 狂气。"
  },
  State_67634_Name = {
    Text = "失衡的天平"
  },
  State_67635_Desc = {
    Text = "拾取时，所有唤醒体获得 50 点狂气，将 2 张<DerivativeCardKeywords_1:「遗影回响」>洗入抽牌堆。"
  },
  State_67635_Name = {
    Text = "通讯设备+β"
  },
  State_67636_Desc = {
    Text = "暴击伤害提高 15%。对有护盾的敌方造成的伤害必然暴击。"
  },
  State_67636_Name = {
    Text = "美学原理"
  },
  State_67637_Desc = {
    Text = "回合开始时抽 2 张牌，获得 2 点算力。每当你抽到 1 张指令卡或灵知觉醒时，随机变化其算力消耗。（0-4）"
  },
  State_67637_Name = {
    Text = "诡术礼帽"
  },
  State_67638_Desc = {
    Text = "对处于负面状态的敌人造成的伤害提高 50%，击杀敌人后击杀者获得 100 狂气。"
  },
  State_67638_Name = {
    Text = "祭司权杖+"
  },
  State_67639_Desc = {
    Text = "暴击率提高 50%，暴击伤害提高 100%。"
  },
  State_67639_Name = {
    Text = "受祝·古怪钩爪"
  },
  State_67640_Desc = {
    Text = "暴击率、暴击伤害提高100%。每造成 1 次伤害/触腕伤害，本回合：所有唤醒体暴击暴伤降低 10%，至多降低 50%。造成的中毒和反击提高 10%，至多提高 50%。"
  },
  State_67640_Name = {
    Text = "时灵摆·移涌"
  },
  State_67641_Desc = {
    Text = "释放狂气爆发后，获得 [DescArg1] 点临时<PowerIconKeywords:力量>。"
  },
  State_67641_Name = {Text = "重锁"},
  State_67643_Desc = {
    Text = "造成主动伤害时获得 [DescArg1] 点护盾。回复生命时，获得 [DescArg2] 点临时<PowerIconKeywords:力量>。"
  },
  State_67643_Name = {
    Text = "我们的家"
  },
  State_67645_Desc = {
    Text = "暴击率提高 10%。每回合首次暴击后使暴击率额外提高 20%，每回合造成第 3 次暴击后使暴击伤害额外提高 50%。"
  },
  State_67645_Name = {
    Text = "节日祝福"
  },
  State_67646_Desc = {
    Text = "奇数回合结束时，若有剩余算力，下回合额外抽 2 张牌；偶数回合结束时，若有剩余手牌，下回合额外获得 2 算力。"
  },
  State_67646_Name = {
    Text = "日月轮盘"
  },
  State_67647_Desc = {
    Text = "你每打出的第 5 张指令卡会生效 2 次，打出后回到手中。"
  },
  State_67647_Name = {
    Text = "群星之酒+"
  },
  State_67649_Desc = {
    Text = "隐藏怪物意图。每回合获得 1 点算力，抽 1 张牌。"
  },
  State_67649_Name = {
    Text = "蛊惑风铃"
  },
  State_67650_Desc = {
    Text = "「打击」和 「防御」额外获得 50 点银钥能量。每当你打出 1 张算力消耗为 2 或以上的卡牌，抽 1 张算力消耗为 1 的牌并使其算力消耗变为 0，每回合最多生效 3 次。"
  },
  State_67650_Name = {
    Text = "时灵摆·双生"
  },
  State_67651_Desc = {
    Text = "拾取时队伍界域精通变为原始值的 150%。每回合打出第 5 张指令卡后，所有唤醒体获得 20 狂气。"
  },
  State_67651_Name = {
    Text = "时灵摆·不洁"
  },
  State_67653_Desc = {
    Text = "每回合释放狂气爆发 2 次后，所有唤醒体获得 8 点狂气，释放 3 次后，所有唤醒体再获得 8 点狂气。"
  },
  State_67653_Name = {
    Text = "被遗忘者之血"
  },
  State_67654_Name = {
    Text = "额外生效 [DescArg1] 次"
  },
  State_67656_Desc = {
    Text = "暴击率提高 50%，<FragileIconKeywords:脆弱>自身 3 回合。"
  },
  State_67656_Name = {
    Text = "古怪钩爪"
  },
  State_67657_Desc = {
    Text = "回合开始时抽 1 张牌。连续 2 次打出和上一张卡牌算力相同的牌时，额外抽 1 张牌，每回合最多生效 3 次。"
  },
  State_67657_Name = {
    Text = "万象灵知秘仪"
  },
  State_67658_Desc = {
    Text = "打出 1 张实际算力消耗为 3 的卡牌时，抽 1 张牌并获得 2 算力；打出 1 张实际算力消耗为 4 或以上的卡牌时，其他手牌算力消耗降低 1。"
  },
  State_67658_Name = {
    Text = "时灵摆·眼"
  },
  State_67659_Desc = {
    Text = "回合开始时每有 1 名敌人就获得 2 算力。主动伤害击杀敌人时，对其他敌人造成双倍过量伤害的<BleedingIconKeywords:出血>。"
  },
  State_67659_Name = {
    Text = "群氓之歌+"
  },
  State_67660_Desc = {
    Text = "每第 3 次打出「打击」后，对全体敌方造成 [DescArg1] 点伤害，对应唤醒体获得 15 狂气。"
  },
  State_67660_Name = {
    Text = "锈蚀柳叶刀"
  },
  State_67661_Desc = {
    Text = "每次消耗算力时，抽 1 张牌，每回合至多生效 5 次。每当牌库重置时，获得 2 点算力。"
  },
  State_67661_Name = {
    Text = "时灵摆·不眠"
  },
  State_67662_Desc = {
    Text = "每当你打出一张非唤醒体的卡牌时，狂气最低的唤醒体获得 10 狂气。"
  },
  State_67662_Name = {
    Text = "异乡邮票夹"
  },
  State_67665_Desc = {
    Text = "最大算力提高 2。打出「打击」或「防御」后，对应唤醒体获得 5 狂气。释放狂气爆发后，获得 1 张对应唤醒体附带消耗虚无的「打击」，释放钥令后，随机获得 1 张附带消耗虚无的「防御」。"
  },
  State_67665_Name = {
    Text = "时灵摆·羽翼"
  },
  State_67666_Desc = {
    Text = "每次造成伤害时，获得 [DescArg1] 点临时<PowerIconKeywords:力量>，最多堆叠 3 次。层数满时效果翻倍。"
  },
  State_67666_Name = {
    Text = "缠丝玛瑙"
  },
  State_67667_Desc = {
    Text = "回合结束后所有唤醒体获得 5 狂气。每剩余 1 点算力，所有唤醒体就额外获得 3 狂气。"
  },
  State_67667_Name = {
    Text = "原型电池"
  },
  State_67668_Desc = {
    Text = "暴击伤害提高 15%。「打击」暴击率提高 40%。"
  },
  State_67668_Name = {Text = "白鸦喙"},
  State_67669_Name = {Text = "废弃"},
  State_67670_Desc = {
    Text = "释放狂气爆发后，抽 1 张牌。若生命低于 25%，额外抽 1 张牌。"
  },
  State_67670_Name = {
    Text = "求知读书轮"
  },
  State_67671_Desc = {
    Text = "每造成 1 次主动伤害，回复 [DescArg1] 生命，对伤害目标施加 [DescArg2] 层<BleedingIconKeywords:出血>。"
  },
  State_67671_Name = {
    Text = "受祝·虫群意识"
  },
  State_67672_Desc = {
    Text = "造成的<WeaknessIconKeywords:虚弱>效果提高 8%，<VulnerabilityIconKeywords:易伤>效果提高 25%。施加<WeaknessIconKeywords:虚弱>或<VulnerabilityIconKeywords:易伤>时，临时偷取目标 [DescArg1] 点<PowerIconKeywords:力量>。"
  },
  State_67672_Name = {
    Text = "褪色照片+"
  },
  State_67673_Desc = {
    Text = "回合开始时抽 1 张牌。"
  },
  State_67673_Name = {
    Text = "定向罗盘"
  },
  State_67674_Desc = {
    Text = "每打出 1 张指令卡就获得 [DescArg2]% <DeathResistanceIconKeywords:死亡抵抗>（本次关卡内每触发 1 次死亡抵抗，获得的死亡抵抗减半）。若你<DeathResistanceIconKeywords:死亡抵抗>大于等于 100%，改为获得 [DescArg1] 点临时<PowerIconKeywords:力量>。"
  },
  State_67674_Name = {
    Text = "怪蛇残蜕"
  },
  State_67675_Desc = {
    Text = "回合结束时若有剩余算力，下回合额外抽 2 张牌；若有剩余手牌，下回合额外获得 2 点算力。"
  },
  State_67675_Name = {
    Text = "日月轮盘+"
  },
  State_67677_Desc = {
    Text = "你造成<WeaknessIconKeywords:虚弱>时，获得 [DescArg1] 点护盾；造成<VulnerabilityIconKeywords:易伤>时，获得 [DescArg2] 点临时<PowerIconKeywords:力量>。若在 1 回合内触发了这两个效果，额外获得 [DescArg1] 点护盾和 [DescArg2] 点临时<PowerIconKeywords:力量>。"
  },
  State_67677_Name = {
    Text = "沉重画框"
  },
  State_67703_Desc = {
    Text = "回合开始时，如果上个回合剩余的手牌数超过 3 张，获得 2 算力。"
  },
  State_67703_Name = {
    Text = "弥萨格徽章"
  },
  State_67704_Desc = {
    Text = "释放狂气爆发后，对应唤醒体获得 10 狂气，获得 [DescArg1] 点护盾。"
  },
  State_67704_Name = {
    Text = "无名之神的面纱"
  },
  State_67796_Name = {
    Text = "<TongxiaoKeywords:通晓万物之理>：打出后还原，获得 <Energy:[StateArg1]> 点狂气"
  },
  State_67841_WeaponDesc = {
    Text = "打出前改变卡牌算力"
  },
  State_67844_Desc = {
    Text = "受到致命伤害后回复所有生命，可触发@1次，当前已触发 [DescArg1] 次。"
  },
  State_67844_Name = {
    Text = "亘古混沌"
  },
  State_67866_Name = {
    Text = "<BleedingColour: 出血>"
  },
  State_68298_Desc = {
    Text = "受到致命伤害后意图转化为「深空注目」并获得 80 层临时加固，回复所有生命，可触发 [DescArg1] 次。回合结束时，自身移除 20 层加固。"
  },
  State_68298_Name = {Text = "星屑"},
  State_68554_Desc = {
    Text = "受到致命伤害后回复所有生命，其他敌人全部死亡后移除该状态。可触发@1次，当前已触发 [DescArg1] 次。"
  },
  State_68554_Name = {
    Text = "亘古混沌碎屑"
  },
  State_68621_Desc = {
    Text = "战斗开始及每回合结束时，获得 2 层临时<ResentChainsKeywords:怨恨锁链>。"
  },
  State_68621_Name = {
    Text = "诡谲之奔流"
  },
  State_68622_Desc = {
    Text = "唤醒体施加的力量效果降低 75%。每当失去生命，获得 [DescArg1] 点护盾和 1 层临时加固。"
  },
  State_68622_Name = {
    Text = "邪信之奔流"
  },
  State_68623_Desc = {
    Text = "每打出 1 张指令卡，弃掉 1 张该唤醒体算力消耗最低的卡牌。"
  },
  State_68623_Name = {
    Text = "疯狂之奔流"
  },
  State_68624_Desc = {
    Text = "回合结束时，恢复 10% 已损生命值，解除自身负面状态和玩家的正面状态。"
  },
  State_68624_Name = {
    Text = "诞临之奔流"
  },
  State_68626_Desc = {
    Text = "所有唤醒体的基础狂气提高 50%。每回合结束时，扣除所有唤醒体 10 点狂气，恢复自身 3％最大生命。"
  },
  State_68626_Name = {
    Text = "恐惧之奔流"
  },
  State_68627_Desc = {
    Text = "战斗开始时，获得 15 层「临时屏障」。回合结束时，获得 15 层「临时屏障」，对随机 10 张卡牌附加「临时溶解」。"
  },
  State_68627_Name = {
    Text = "刺骨之奔流"
  },
  State_68632_Desc = {
    Text = "所有指令卡算力消耗提高 1。每 3 个回合，回合结束时将 1 张「渐渐石化」置入手中。"
  },
  State_68632_Name = {
    Text = "悲泣之奔流"
  },
  State_68635_Name = {
    Text = "「纯银之芯· 恐惧」"
  },
  State_68637_Desc = {
    Text = "失去生命时，减少对应层数。层数为 0 时，使玩家获得 2 层临时屏障，自身获得 [DescArg1] 层护盾和 [DescArg2] 层临时加固，并重新获得 [DescArg3] 层维度壁障。"
  },
  State_68637_Name = {
    Text = "维度壁障"
  },
  State_68638_Name = {
    Text = "「纯银之芯· 邪信」"
  },
  State_68646_Desc = {
    Text = "基础伤害和护盾值提高 200％，但打出后会被消耗。"
  },
  State_68646_Name = {
    Text = "<RedQuality1:临时溶解>"
  },
  State_68647_Name = {
    Text = "「纯音之芯·疯狂」"
  },
  State_68680_Desc = {
    Text = "移除亘古碎屑"
  },
  State_68680_Name = {
    Text = "移除亘古碎屑"
  },
  State_68704_Desc = {
    Text = "距离托乎瓦波真正降临还有 [DescArg1] 回合……"
  },
  State_68704_Name = {Text = "降临"},
  State_68829_Desc = {
    Text = "承受主动或触腕伤害时，免疫伤害并减少 1 层，回合开始时移除。"
  },
  State_68829_Name = {
    Text = "<ParcloseColour: 临时屏障>"
  },
  State_68829_WeaponDesc = {
    Text = "承受的伤害降低 99%，每承受 1 次伤害减少 1 层。"
  },
  State_70026_Desc = {
    Text = "此卡牌拥有「保留」，打出后所有唤醒体临时暴击率提高 [StateArg1]％ 并移除「不朽支配」。若当前界域为深海，「不朽支配」移除后获得 1 点算力。"
  },
  State_70026_Name = {
    Text = "<OrangeQuality:不朽支配>"
  },
  State_70031_Desc = {
    Text = "队伍唯一：战斗开始时，赋予抽牌堆中装备者所有算力消耗大于等于 3 的指令卡「不朽支配」效果：此卡牌拥有「保留」，打出后所有唤醒体临时暴击率提高 <WeaponEffect_Num:[StateArg1]%> 并移除「不朽支配」。若当前界域为深海，「不朽支配」移除后获得 1 点算力。"
  },
  State_70031_WeaponDesc = {
    Text = "战斗开始时，赋予抽牌堆中装备者所有算力消耗大于等于 3 的指令卡「不朽支配」效果：此卡牌拥有「保留」，打出后所有唤醒体临时暴击率提高 <WeaponEffect_Num:[StateArg1]%> 并移除「不朽支配」。若当前界域为深海，「不朽支配」移除后获得 1 点算力。"
  },
  State_70182_Desc = {
    Text = "获得的所有护盾降低 [DescArg1] %。"
  },
  State_70182_Name = {
    Text = "<FragileColour:脆弱>"
  },
  State_70182_WeaponDesc = {
    Text = "获得的所有护盾降低 33 %。"
  },
  State_70277_Desc = {
    Text = "承受主动或触腕伤害后，会将 [StateArg1]% 伤害转化为猩红熔炉回复量，持续 [Layer] 回合。"
  },
  State_70277_Name = {
    Text = "创生之祭"
  },
  State_70287_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，使手牌中装备者所有「技能」造成的伤害、治疗与护盾提高 [StateArg1]%。"
  },
  State_70287_Name = {
    Text = "青石王座"
  },
  State_70288_Desc = {
    Text = "此卡牌造成的伤害、治疗和护盾提高 [DescArg1]%。"
  },
  State_70288_Name = {
    Text = "青石王座"
  },
  State_70313_Desc = {
    Text = "在首领战中，回合开始时及「熔毁朵尔」释放狂气爆发后，获得 1 层「<Zhongmowuqiling:终末>」。「终末」至多拥有 10 层，达到 10 层时，将 1 张「虚无终结」置入手中。"
  },
  State_70313_Name = {
    Text = "湮灭之路"
  },
  State_70318_Desc = {
    Text = "对所有敌人施加 [StateArg1] 回合<VulnerabilityIconKeywords:易伤>，获得 1 回合「兴奋」状态：伤害强效 +[StateArg2]％。"
  },
  State_70318_Name = {Text = "兴奋"},
  State_70322_Desc = {
    Text = "拥有 10 层终末时，将 1 张「虚无终结」置入手中。"
  },
  State_70322_Name = {Text = "终末"},
  State_70330_Desc = {
    Text = "获得 1 回合「兴奋」状态：伤害强效 +[StateArg2]％。"
  },
  State_70330_Name = {Text = "兴奋"},
  State_70346_Desc = {
    Text = "对所有敌人施加 [StateArg1] 回合 <WeaknessIconKeywords:虚弱>，并使它们在本回合中降低 [Exhaustion:StateArg3] 点<PowerIconKeywords:力量> 。"
  },
  State_70346_Name = {Text = "诅咒"},
  State_70347_Desc = {
    Text = "使所有敌人在本回合中降低 [Exhaustion:StateArg3] 点<PowerIconKeywords:力量> 。"
  },
  State_70347_Name = {Text = "诅咒"},
  State_70374_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备者每回合前 [StateArg1] 次受到攻击时，对攻击者造成<PVPEmptinessKeywords:空虚>。"
  },
  State_70374_Name = {
    Text = "坠入虚无的人偶"
  },
  State_70379_Desc = {
    Text = "对攻击者造成<PVPEmptinessKeywords:空虚>。在受到攻击后移除此状态。"
  },
  State_70379_Name = {
    Text = "空虚反击"
  },
  State_70443_Desc = {
    Text = "拥有 10 层终末时，将 1 张「虚无终结」置入手中。"
  },
  State_70443_Name = {Text = "终末"},
  State_70539_Name = {
    Text = "灵魂瘟疫"
  },
  State_70589_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更低的卡牌时，对所有敌人施加 40/80 中毒，每回合至多触发 5 次。"
  },
  State_70590_Desc = {
    Text = "每回合首次直接使用胚胎后，本回合内主动伤害会造成 15/30% 伤害等量的出血。"
  },
  State_70593_Desc = {
    Text = "打出非衍生指令卡后，将算力消耗降低 2 的该卡牌 1/2 张临时复制洗入抽牌堆，3 回合冷却。"
  },
  State_70594_Desc = {
    Text = "回合结束时，如果处于潮涌姿态，获得 32/64 触腕伤害，3 回合冷却。"
  },
  State_70595_Desc = {
    Text = "战斗开始时对所有敌人施加 1280 中毒，首领战效果翻倍。"
  },
  State_70598_Desc = {
    Text = "每当一张卡进入超维空间时，若这张卡与其他超维空间的卡牌归属者不同，则将 1/2 张灵感置入手中。"
  },
  State_70600_Desc = {
    Text = "回合结束时回复 32 点生命。"
  },
  State_70600_Name = {
    Text = "恩赐之血"
  },
  State_70602_Desc = {
    Text = "使用银钥觉醒后抽 4 张牌。"
  },
  State_70603_Desc = {
    Text = "使用银钥觉醒后所有唤醒体获得 10 狂气。"
  },
  State_70605_Desc = {
    Text = "使用银钥觉醒后获得 32 力量。"
  },
  State_70607_Desc = {
    Text = "连续 2 次打出比上一张算力消耗更高的卡牌时，获得 24/48 反击，每回合至多触发 5 次。"
  },
  State_70609_Desc = {
    Text = "使用银钥觉醒后获得 96 护盾。"
  },
  State_70609_Name = {
    Text = "蝴蝶标本"
  },
  State_70611_Desc = {
    Text = "使用银钥觉醒后使所有唤醒体造成的基础伤害提高 25%/50%。"
  },
  State_70614_Name = {
    Text = "镭射颌骨+"
  },
  State_70617_Desc = {
    Text = "每回合前五次造成的伤害提高 15%/30%。"
  },
  State_70618_Desc = {
    Text = "回合开始时抽 1 张牌。"
  },
  State_70619_Desc = {
    Text = "「打击」造成伤害 10%/20% 的中毒，每回合至多造成 320/640 点。"
  },
  State_70620_Desc = {
    Text = "受到敌人攻击时使其受到 1次 25%/50% 我方最大生命值的<FixedDamage:纯粹伤害>，该伤害享受 100%/200% 反击加成，每个敌人每回合最多触发 1 次。"
  },
  State_70620_Name = {
    Text = "遗落的祭祀刀"
  },
  State_70621_Desc = {
    Text = "使用银钥觉醒后获得 192 护盾。"
  },
  State_70621_Name = {
    Text = "蝴蝶标本+"
  },
  State_70623_Desc = {
    Text = "每回合开始时所有唤醒体获得 10 狂气。"
  },
  State_70624_Desc = {
    Text = "使用银钥觉醒后所有唤醒体获得 20 狂气。"
  },
  State_70628_Desc = {
    Text = "回合开始时抽 2 张牌。"
  },
  State_70629_Desc = {
    Text = "每回合首次吞噬时，其他唤醒体获得 10/20 狂气。"
  },
  State_70635_Desc = {
    Text = "使用银钥觉醒后获得 416 反击。"
  },
  State_70636_Desc = {
    Text = "失去生命时获得 10%/20% 生命损失量的猩红熔炉。"
  },
  State_70637_Desc = {
    Text = "战斗开始时，触婉上限+1/2，获得 1/2 条触腕。"
  },
  State_70641_Desc = {
    Text = "湮灭获得 160/320 护盾，3 回合冷却。"
  },
  State_70641_Name = {
    Text = "超弦怀表"
  },
  State_70643_Desc = {
    Text = "回合开始时获得 1 算力。"
  },
  State_70644_Desc = {
    Text = "释放狂气爆发后，获得 16/32 临时力量。"
  },
  State_70645_Desc = {
    Text = "回合开始时获得 2 算力。"
  },
  State_70646_Name = {
    Text = "遗落的祭祀刀+"
  },
  State_70647_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 30%。"
  },
  State_70648_Desc = {
    Text = "战斗开始时对所有敌人施加 640 中毒，首领战效果翻倍。"
  },
  State_70656_Desc = {
    Text = "「打击」额外造成 1/2 次 60% 唤醒体攻击力的伤害，每回合至多触发 3 次。"
  },
  State_70657_Desc = {
    Text = "战斗开始时获得 32 力量。"
  },
  State_70660_Desc = {
    Text = "战斗开始时获得 64 力量。"
  },
  State_70661_Desc = {
    Text = "回合结束时回复 64 点生命。"
  },
  State_70661_Name = {
    Text = "恩赐之血+"
  },
  State_70662_Desc = {
    Text = "使用银钥觉醒后获得 2 算力。"
  },
  State_70664_Desc = {
    Text = "使用银钥觉醒后获得 16 力量。"
  },
  State_70666_Desc = {
    Text = "战斗开始后，获得 100/200 界域精通。所有唤醒体造成的基础中毒与造物造成的中毒提高 10%/20%。"
  },
  State_70667_Desc = {
    Text = "使用银钥觉醒后获得 4 算力。"
  },
  State_70670_Desc = {
    Text = "战斗开始时获得 320 反击，首领战效果翻倍。"
  },
  State_70671_Desc = {
    Text = "进入超维回合后，第一张打出的非衍生指令卡额外生效 1/2 次。"
  },
  State_70678_Desc = {
    Text = "战斗开始时获得 640 反击，首领战效果翻倍。"
  },
  State_70681_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 60%。"
  },
  State_70682_Desc = {
    Text = "当手牌数小于等于 2 时，抽 1/2 张牌，每回合最多触发 2 次。"
  },
  State_70683_Desc = {
    Text = "湮灭使狂气最低的唤醒体获得 50/100 狂气，3 回合冷却。"
  },
  State_70684_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 72/144 临时力量。"
  },
  State_70685_Desc = {
    Text = "使用银钥觉醒后对所有敌人施加 416 中毒。"
  },
  State_70686_Desc = {
    Text = "释放狂气爆发后，使所有敌人受到 1 次 15%/30% 我方最大生命值的<FixedDamage:纯粹伤害>，并触发 10%/20% 中毒。"
  },
  State_70687_Name = {
    Text = "超限怀表+"
  },
  State_70689_Desc = {
    Text = "使用银钥觉醒后对所有敌人施加 832 中毒。"
  },
  State_70690_Desc = {
    Text = "战斗开始后，获得 100/200 界域精通。所有唤醒体造成的基础反击与造物造成的反击提高 10%/20%。"
  },
  State_70691_Desc = {
    Text = "每次造成伤害时获得 4/8 临时力量，每回合至多触发 15 次。"
  },
  State_70693_Desc = {
    Text = "胚胎融合自动获得量提高 100%/200%。"
  },
  State_70694_Desc = {
    Text = "使用银钥觉醒后抽 2 张牌。"
  },
  State_70695_Desc = {
    Text = "每回合开始时所有唤醒体获得 5 狂气。"
  },
  State_70696_Desc = {
    Text = "使用银钥觉醒后获得 208 反击。"
  },
  State_70698_Desc = {
    Text = "防御获得 200/400 临时反击，每回合至多触发 3 次。"
  },
  State_70804_Name = {
    Text = "生死时限"
  },
  State_70805_Desc = {
    Text = "战斗开始后，对所有敌人施加 1/2 层虚弱，对首领效果翻倍。所有唤醒体造成的基础伤害提高 15%/30%。"
  },
  State_70806_Name = {
    Text = "守护之手+"
  },
  State_70808_Desc = {
    Text = "使用静海姿态对所有敌人施加 64/128 衰竭，3 回合冷却。"
  },
  State_70809_Desc = {
    Text = "回合开始时，若生命低于 25%，获得 100/200 护盾。"
  },
  State_70809_Name = {
    Text = "守护之手"
  },
  State_70810_Desc = {
    Text = "使用怒涛姿态立即激发所有触腕攻击敌人 1/2 次，3 回合冷却。"
  },
  State_70812_Desc = {
    Text = "战斗开始后，对所有敌人施加 1/2 层易伤，对首领效果翻倍。所有唤醒体造成的基础伤害提高 15%/30%。"
  },
  State_70832_Desc = {
    Text = "队伍唯一：战斗开始时，装备者获得等同于 <WeaponEffect_Num:[StateArg1]%> 装备者狂气回充的狂气。装备者每场战斗首次释放狂气爆发后，重复一次该效果。"
  },
  State_70832_WeaponDesc = {
    Text = "战斗开始时，装备者获得等同于 <WeaponEffect_Num:[StateArg1]%> 装备者狂气回充的狂气（<WeaponEffect_Num:[DescArg1]>）。装备者每场战斗首次释放狂气爆发后，重复一次该效果。"
  },
  State_70835_Desc = {
    Text = "队伍唯一：装备者造成的狂气、中毒、生命回复提高 <WeaponEffect_Num:[StateArg1]%>。装备者释放狂气爆发后，获得等同于本次狂气消耗 <WeaponEffect_Num:[StateArg2]%> 的狂气。"
  },
  State_70835_WeaponDesc = {
    Text = "装备者造成的狂气、中毒、生命回复提高 <WeaponEffect_Num:[StateArg1]%>。装备者释放狂气爆发后，获得等同于本次狂气消耗 <WeaponEffect_Num:[StateArg2]%> 的狂气。"
  },
  State_70989_Desc = {
    Text = "在一回合释放 4 次狂气爆发后，获得 3/6 算力，3 回合冷却。"
  },
  State_71001_Desc = {
    Text = "在一回合内打出 4 张归属于不同唤醒体的指令卡后，所有唤醒体获得 20/40 狂气，3 回合冷却。"
  },
  State_71153_Desc = {
    Text = "回合开始时凯刻斯获得 15 狂气。凯刻斯获得护盾时回复 50% 护盾量的生命。"
  },
  State_71154_Desc = {
    Text = "回合开始时艾继丝获得 15 狂气。艾继丝对具有易伤的敌人造成伤害时还会偷取其 10 点临时力量，每回合最多生效 5 次。"
  },
  State_71155_Desc = {
    Text = "回合开始时雷娅获得 15 狂气。每当失去生命后获得 8 点力量，每场战斗最多叠加 10 次。叠加 10 次后，「苦痛与欢愉」算力消耗变为 1，伤害次数提高 1。"
  },
  State_71156_Desc = {
    Text = "回合开始时阿格里帕获得 15 狂气。「不耐的施舍」还会使阿格里帕在本回合中算力消耗降低 1，每回合最多生效 1 次。"
  },
  State_71157_Desc = {
    Text = "回合开始时珊获得 15 狂气。战斗开始时对珊的所有指令卡赋予保留、预备 1、获得 24 点护盾。"
  },
  State_71157_Name = {
    Text = "维度影像·珊"
  },
  State_71158_Desc = {
    Text = "回合开始时朵尔获得 15 狂气。战斗开始后使朵尔的「等价交换」算力消耗变为 0，打出后下回合额外抽 2 张牌。"
  },
  State_71159_Desc = {
    Text = "回合开始时法洛思获得 15 狂气。每造成 1 次触腕伤害，就使法洛思本场战斗造成的中毒提高 1%，最大为 100%。"
  },
  State_71160_Desc = {
    Text = "回合开始时「24」获得 15 狂气。回合开始时「24」若处于「抑郁人格」则额外获得 25 狂气，若处于「躁狂人格」则使「24」临时暴击率和临时暴击伤害提高 35%。"
  },
  State_71161_Desc = {
    Text = "回合开始时菲茵特获得 15 狂气。每当触发死亡抵抗就使菲茵特本场探索中造成的护盾、反击、生命回复提高 20%，最多生效 5 次。"
  },
  State_71162_Desc = {
    Text = "回合开始时戈利亚获得 15 狂气。若戈利亚 1 回合内造成了 3 次伤害，戈利亚造成的伤害本场战斗中额外享受 1 倍力量加成，3 回合冷却。"
  },
  State_71163_Desc = {
    Text = "回合开始时血链希洛获得 15 狂气。血链·希洛主动伤害附加 20% 出血，击杀敌人后对其他敌人造成等同于过量伤害的出血。"
  },
  State_71164_Desc = {
    Text = "回合开始时奥瑞塔获得 15 狂气。「腺体分裂」伤害次数提高 1，打出奥瑞塔的「防御」后将 1 张「腺体分裂」置入手中。"
  },
  State_71166_Desc = {
    Text = "回合开始时莉莉获得 15 狂气。莉莉忍耐上限提高 100%，释放「淤泥上的不灭之花」或「报偿打击」时，回复「忍耐」层数 8% 的生命。"
  },
  State_71167_Desc = {
    Text = "回合开始时萝坦获得 15 狂气。每回合首次打出萝坦的「防御」后，将 2 张附加消耗与虚无的「桀骜之刃」置入手中。"
  },
  State_71168_Desc = {
    Text = "回合开始时潘狄娅获得 15 狂气。回合开始时获得 64 点反击。每有 4 点非临时的反击「潘迪娅」指令卡造成的伤害就提高 1。"
  },
  State_71169_Desc = {
    Text = "回合开始时希洛获得 15 狂气。每当有 1 张牌被弃掉，都会使「希洛」获得 5 点狂气。"
  },
  State_71170_Desc = {
    Text = "回合开始时塔薇获得 15 狂气。若一回合内打出了 6 张塔薇的指令卡，将 1 张「银钥曦光」置入手中，冷却 3 回合。"
  },
  State_71171_Desc = {
    Text = "回合开始时弥利亚姆获得 15 狂气，并将 1 张「圣礼」置入手中。"
  },
  State_71172_Desc = {
    Text = "回合开始时熔毁·朵尔获得 15 狂气。熔毁朵尔释放狂气爆发后，每消耗 20 点狂气其他唤醒体就获得 1 点狂气。"
  },
  State_71173_Desc = {
    Text = "回合开始时萨尔瓦多获得 15 狂气。每次积攒猩红熔炉时还会获得积攒量 5% 的力量。萨尔瓦多的「打击」与「应消之苦」额外享受 1 倍力量加成。"
  },
  State_71175_Desc = {
    Text = "回合开始时诺谛拉获得 15 狂气。释放诺谛拉的「狂气爆发」后获得等同于当前护盾 50% 的反击，每回合最多触发 1 次。"
  },
  State_71177_Desc = {
    Text = "回合开始时莉兹获得 15 狂气。「告死之舞」弃掉的卡牌额外生效 1 次，3 回合冷却。"
  },
  State_71178_Desc = {
    Text = "回合开始时拉蒙娜获得 15 狂气。每第 3 张打出拉蒙娜的指令卡时，该指令卡额外生效 1 次。"
  },
  State_71179_Desc = {
    Text = "回合开始时尤乌哈希获得 15 狂气。尤乌哈希狂气消耗降低 10 点，每次释放狂气爆发狂气消耗额外降低 5 点，每回合能够释放 2 次狂气爆发。"
  },
  State_71180_Desc = {
    Text = "回合开始时艾尔瓦获得 15 狂气。上回合艾尔瓦若打出过 2 张「防御」，将一张消耗的「心眼利刃」置入手中；若打出过 2 张「打击」，将 1 张消耗的「临战体势」置入手中。"
  },
  State_71181_Desc = {
    Text = "回合开始时索蕾尔获得 15 狂气。索蕾尔每造成 1 次伤害胚胎融合+10，每回合最多生效 10 次。生效 10 次后使索蕾尔本场战斗暴击伤害+ 20%。"
  },
  State_71182_Desc = {
    Text = "回合开始时哈姆林获得 15 狂气。「灵魂序曲」算力消耗降低 1，基础伤害次数提高 1。"
  },
  State_71183_Desc = {
    Text = "回合开始时泰旖丝获得 15 狂气。泰旖丝在 1 回合内打出 2 张指令卡后，获得一张「圣洁之子」和 72 点临时力量，3 回合冷却。"
  },
  State_71187_Desc = {
    Text = "回合开始时希莱斯特获得 15 狂气。回合结束前手牌中每有 1 张希莱斯特的指令卡就使 1 条触腕攻击敌人并回复 8 点生命。"
  },
  State_71188_Desc = {
    Text = "回合开始时墨菲获得 15 狂气。墨菲的「打击」和「防御」能够将 25% 的「献祭」转化为临时触腕伤害，但每回合最多生效 1 次。"
  },
  State_71189_Desc = {
    Text = "回合开始时宁菲亚获得 15 狂气。打出宁菲亚的 「打击」后使「宁菲亚」本场战斗造成的中毒提高 20%，打出宁菲亚的 「防御」后触发所有敌人 50% 中毒。每回合最多各生效 1 次。"
  },
  State_71190_Desc = {
    Text = "回合开始时奥吉尔获得 15 狂气。每回合首次打出奥吉尔的「穿刺之枪」或「打击」后，使奥吉尔本回合内造成的护盾和力量提高 50%。"
  },
  State_71191_Desc = {
    Text = "回合开始时莱克获得 15 狂气。每回合首次骰子结果总是为 6。"
  },
  State_71192_Desc = {
    Text = "回合开始时环行·拉蒙娜获得 15 狂气。每回合首次触发「回环」时，获得 500 点银钥能量和 1 层「负熵」。"
  },
  State_71193_Desc = {
    Text = "回合开始时图鲁获得 15 狂气。图鲁的狂气消耗降低 10 点，释放狂气爆发后立刻生成 2 条临时触腕。"
  },
  State_71194_Desc = {
    Text = "回合开始时珈伦获得 15 狂气。打出「静默守望」会返还双倍消耗的算力，冷却 3 回合。"
  },
  State_71271_Desc = {
    Text = "回合开始时奥尔拉获得 15 狂气。战斗开始时获得所有情绪的隐喻各 1 层。「隐喻」效果提高 50％。"
  },
  State_71272_Desc = {
    Text = "回合开始时詹金获得 15 狂气，最终伤害+5%。「布朗出动」的基础伤害和造成的伤害成长提高 200%。"
  },
  State_71273_Desc = {
    Text = "回合开始时达芙黛尔获得 15 狂气和 1 张「灵感」。每次打出「异质潮汐」都会使其获得的力量在本场探索中永久提高 25%，最大为 300%。"
  },
  State_71274_Desc = {
    Text = "回合开始时汀克特获得 15 狂气。汀克特的指令卡触发跃迁后将其返回手中，每回合最多生效 3 次。"
  },
  State_71275_Desc = {
    Text = "回合开始时旺达获得 15 狂气并获得 1 层「梦引」。若当前为超维回合额外将 1 张临时的「脊刺锁链」和「迷途之守」置入手中。"
  },
  State_71276_Desc = {
    Text = "回合开始时艾瑞卡获得 15 狂气。艾瑞卡在 1 回合内打出 3 张指令卡后，获得 1 张「灵感」并使本场战斗「电磁爆破」享受的力量和戒备加成提高 1 倍。"
  },
  State_71277_Desc = {
    Text = "回合开始时卡茜亚获得 15 狂气。每抽 1 张牌就使卡茜亚获得 1 点狂气。卡茜亚释放狂气爆发时所有敌人失去 32 点力量。"
  },
  State_71278_Desc = {
    Text = "回合开始时温柯尔获得 15 狂气。每当其他唤醒体释放狂气爆发就会使温柯尔获得 5 点狂气，并使手中的「精神重建」算力消耗降低 1。"
  },
  State_71279_Desc = {
    Text = "伤害强效 +[StateArg1]％，持续 [Layer] 回合。"
  },
  State_71279_Name = {Text = "兴奋"},
  State_71503_Name = {
    Text = "「终末形态」：额外抽 3 张牌，获得 3 点算力，触发所有敌人 [DescArg1]％ <IntoxicationIconKeywords:中毒>，「熔毁·朵尔」的狂气上限提高 50 点，至多提高 3 次"
  },
  State_71581_Name = {
    Text = "灵塑适性"
  },
  State_71589_Name = {
    Text = "激发 1 条触腕攻击敌人并回复8。"
  },
  State_71605_Name = {
    Text = "获得 [StateArg1] 点护盾"
  },
  State_71650_Desc = {
    Text = "死亡后复活并召唤不同数量的分身，但它复活后居然不会获得任何加固和免疫。还能生效 [Layer] 次。"
  },
  State_71650_Name = {
    Text = "万千维度之兽"
  },
  State_71651_Desc = {
    Text = "每当失去生命就失去 [StateArg1] 点临时力量。还能生效 [Layer] 次，每回合重置生效次数。"
  },
  State_71651_Name = {
    Text = "绅士礼帽"
  },
  State_71707_Desc = {
    Text = "每受到 1 次主动伤害，回复 [StateArg1] 点生命，持续 [Layer] 回合。"
  },
  State_71707_Name = {
    Text = "凯刻斯·支援"
  },
  State_71708_Desc = {
    Text = "回合结束时，每有 1 张卡牌在手中，所有唤醒体获得 [DescArg1] 点狂气。"
  },
  State_71708_Name = {
    Text = "卡茜亚·支援"
  },
  State_71709_Desc = {
    Text = "回合结束时，获得 35 点狂气，持续 [Layer] 回合。"
  },
  State_71709_Name = {
    Text = "温柯尔·支援"
  },
  State_71711_Desc = {
    Text = "唤醒体造成的伤害提高 25%，持续 [Layer] 回合。"
  },
  State_71711_Name = {
    Text = "詹金·支援"
  },
  State_71712_Desc = {
    Text = "造成主动伤害时，使 1 条触腕攻击 1 次，持续 [Layer] 回合。"
  },
  State_71712_Name = {
    Text = "奥瑞塔·支援"
  },
  State_71712_WeaponDesc = {
    Text = "海月造成伤害时，使 [StateArg1] 条触腕攻击该目标。"
  },
  State_71713_Desc = {
    Text = "每次进行「吞噬」，都会抽 2 张「打击」并使它们算力消耗降低 1，持续 [Layer] 回合。"
  },
  State_71713_Name = {
    Text = "希洛·支援"
  },
  State_71740_Desc = {
    Text = "下回合开始时获得 [Layer] 点护盾。"
  },
  State_71740_Name = {
    Text = "雷娅·支援护盾"
  },
  State_71741_Desc = {
    Text = "下回合开始时，获得等同于本回合损失生命的护盾，持续 [Layer] 回合。"
  },
  State_71741_Name = {
    Text = "雷娅·支援"
  },
  State_71741_WeaponDesc = {
    Text = "下回合开始获得上回合损失生命等量的护盾。"
  },
  State_71742_Desc = {
    Text = "打击卡伤害提高 [Layer]％。"
  },
  State_71742_Name = {
    Text = "希洛·支援"
  },
  State_71742_WeaponDesc = {
    Text = "本回合你的打击卡伤害提高 [Layer]%。"
  },
  State_71837_Desc = {
    Text = "下回合开始时，获得易伤。"
  },
  State_71837_Name = {
    Text = "延迟易伤"
  },
  State_71839_Desc = {
    Text = "使用「苏醒」时，获得 [Layer] 点算力。若当前界域为「深海」，额外生成 [Layer] 条临时触腕。"
  },
  State_71839_Name = {
    Text = "星辰庇佑"
  },
  State_71856_Desc = {
    Text = "每当失去生命就失去 [StateArg1] 点临时力量。还能生效 [Layer] 次，每回合重置生效次数。"
  },
  State_71856_Name = {
    Text = "绅士礼帽"
  },
  State_72016_Name = {
    Text = "血肉精通"
  },
  State_72018_WeaponDesc = {
    Text = "每受到1次伤害，全体唤醒体增加 1 点狂气。"
  },
  State_72033_Desc = {Text = "——"},
  State_72033_Name = {Text = "触腕"},
  State_72033_WeaponDesc = {Text = "——"},
  State_72034_Desc = {Text = "——"},
  State_72034_WeaponDesc = {Text = "——"},
  State_72036_Name = {
    Text = "混沌职业初始化"
  },
  State_72079_Name = {Text = "怒涛"},
  State_72102_Desc = {
    Text = "经典的「忘却前夜」游玩体验。"
  },
  State_72102_Name = {Text = "忘却篇"},
  State_72137_Name = {
    Text = "算力满盈"
  },
  State_72206_Name = {
    Text = "研究进度「[DescArg1] / 15」"
  },
  State_72208_Name = {
    Text = "研究进度「[DescArg1] / 2」"
  },
  State_72212_Name = {
    Text = "研究进度「[DescArg1] / 10」"
  },
  State_72213_Name = {
    Text = "研究进度「[DescArg1] / 30」"
  },
  State_72220_Name = {
    Text = "研究进度「[DescArg1] / 5」"
  },
  State_73518_Desc = {
    Text = "造成的伤害提高 100％，失去生命后解除该状态，但获得 50％ 最大生命的护盾。"
  },
  State_73518_Name = {
    Text = "「暗杀者」"
  },
  State_73520_Desc = {
    Text = "死亡时，保留 1 点生命并免疫所有伤害，将意图转化为「连结解除」。"
  },
  State_73520_Name = {
    Text = "「连结者」"
  },
  State_73533_Desc = {
    Text = "玩家回合结束时不再丢弃手牌。战斗开始时，将玩家手牌上限变为 8。"
  },
  State_73533_Name = {
    Text = "巢群感应"
  },
  State_73535_Desc = {
    Text = "自身回合内，受到的伤害降低 75％。力量被降低时，仅会降低 50% 的力量层数。"
  },
  State_73535_Name = {
    Text = "自体保护"
  },
  State_73566_Desc = {
    Text = "每打出 1 张非指令卡，获得 [Power:StateArg1] 点<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 点护盾。"
  },
  State_73566_Name = {
    Text = "「通讯者」"
  },
  State_73567_Desc = {
    Text = "每打出 1 张非指令卡，获得 [Power:StateArg1] 点<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 点护盾。"
  },
  State_73567_Name = {
    Text = "「通讯者」"
  },
  State_73570_Desc = {
    Text = "每打出 1 张非指令卡，获得 [Power:StateArg1] 点<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 点护盾。"
  },
  State_73570_Name = {
    Text = "「通讯者」"
  },
  State_73573_Desc = {
    Text = "每打出 1 张非指令卡，获得 [Power:StateArg1] 点<PowerIconKeywords:力量> 和 <Block:[Block:StateArg2]> 点护盾。"
  },
  State_73573_Name = {
    Text = "「通讯者」"
  },
  State_73649_Desc = {
    Text = "队伍伤害强效提高 [Layer]％。"
  },
  State_73649_Name = {
    Text = "坠入虚无的人偶"
  },
  State_73655_Name = {
    Text = "有机形态标识"
  },
  State_73664_Name = {
    Text = "饰品有机形态效果"
  },
  State_73664_WeaponDesc = {
    Text = "装备者使用狂气爆发后，本回合内自身护盾和治疗强效翻倍。"
  },
  State_74012_Desc = {
    Text = "对所有敌人造成其最大生命 [StateArg1]％ 的<FixedDamage:纯粹伤害>(最低为[DescArg1])，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  State_74012_Name = {
    Text = "虚无终结"
  },
  State_74013_Desc = {
    Text = "对所有敌人造成其最大生命 [StateArg1]％ 的<FixedDamage:纯粹伤害>，该伤害不会低于自身最大生命的 500％，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  State_74013_Name = {
    Text = "虚无终结"
  },
  State_74014_Desc = {
    Text = "对所有敌人造成其最大生命 [StateArg1]％ 的<FixedDamage:纯粹伤害>（该伤害不会低于自身最大生命的 500％），恢复 30％已损生命，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  State_74014_Name = {
    Text = "虚无终结"
  },
  State_74015_Desc = {
    Text = "对所有敌人造成其最大生命 [StateArg1]％ 的<FixedDamage:纯粹伤害>(最低为[DescArg1])，恢复 <Heal:[Heal:DescArg2]> 点生命，使用后「熔毁·朵尔」的特定技能变更为「终末形态」。"
  },
  State_74015_Name = {
    Text = "虚无终结"
  },
  State_74019_Desc = {
    Text = "所有唤醒体造成的中毒、反击、基础伤害提高 [Layer]％。"
  },
  State_74019_Name = {
    Text = "癫狂感染"
  },
  State_74142_Desc = {
    Text = "探索开始后，体质、攻击、防御提升 [StateArg1] %"
  },
  State_74142_Name = {
    Text = "灵塑适性"
  },
  State_74219_Name = {
    Text = "打出后将其返还手中"
  },
  State_74273_Desc = {
    Text = "血链·希洛造成的主动伤害时，附加 [StateArg1]% 出血，持续 [Layer] 回合。"
  },
  State_74273_Name = {
    Text = "缚身锁链"
  },
  State_74771_Desc = {
    Text = "释放 1 次狂气爆发所需要的狂气值。"
  },
  State_74771_Name = {
    Text = "狂气上限"
  },
  State_74788_Desc = {
    Text = "\n·存在悖论：探索开始时，死亡抵抗的 75％ 转换为最大生命值加成，至多转换 300％ 死亡抵抗，至多提升 10％ 最大生命。每次触发死亡抵抗额外将 1 张「银钥微光」置入手中。\n·无底创痕：首领战中，我方受到的生命回复量每达到生命上限的 100%，就降低后续受到的生命回复效果 25%，但使当前死亡抵抗总量提高 25%，最多触发 3 次。\n·棱彩透镜：回合开始时，若反击超过 750％ 生命上限，将超出部分层数减半，且永久反击至多堆叠 2250％ 生命上限;若敌人中毒超过 1000％ 生命上限，将超出部分层数减半，且中毒至多堆叠至 3000％ 生命上限。唤醒体根据反击获得的伤害加成量降低 70%，但造成的所有中毒与反击提高 10%。敌方回合开始时，每有一个灵知觉醒被激活，获得 25％ 当前永久反击的临时反击，并触发所有敌人 25％ 中毒。\n·命运光锥：普通怪物释放「凝视」的回合数变为 6 回合。所有战斗拥有 15 回合的限制，但 15 回合开始时，将 1 张「光锥界限」置入手中：将银钥能量和所有的唤醒体的狂气填充至最大值。"
  },
  State_74788_Name = {
    Text = "（暂时弃用）"
  },
  State_74791_Desc = {
    Text = "\n·算力调和：单回合内出牌达到 10 张指令卡时，每打出 1 张指令卡获得 1 层「算力调和」。「算力调和」使本回合内每次打出指令卡算力消耗+1，因此消耗的每点额外算力转换为 100% 唤醒体银钥充能的银钥能量，可叠加。发动超维空间后，重置算力调和效果。\n·算力满盈：打出卡牌后移除其本回合内算力消耗降低效果。战斗中当前算力超过 12 时，自动将超出的每点算力转化为 300% 队伍平均银钥充能的银钥能量。\n·狂气调和：造成狂气百分比提高效果减半。唤醒体每次释放狂气爆发后，其基础狂气 +10。回合结束时每有 1 名唤醒体未释放狂气爆发，就获得 200％ 队伍平均银钥充能的银钥能量。"
  },
  State_74791_Name = {
    Text = "钥能调和"
  },
  State_74809_Name = {
    Text = "「终末形态」：额外抽 3 张牌，获得 3 点算力，触发所有敌人 [DescArg1]％ <IntoxicationIconKeywords:中毒>，「熔毁·朵尔」的狂气上限提高 50 点，至多提高 3 次"
  },
  State_74826_Name = {
    Text = "随机造成 [DescArg1] 点<FixedDamage:纯粹伤害> [DescArg2] 次（该伤害受到1倍力量加成）"
  },
  State_74827_Name = {
    Text = "本回合所有唤醒体暴击和暴击伤害提高 [DescArg1]%"
  },
  State_74828_Name = {
    Text = "对全体敌方造成 [DescArg1] 点中毒"
  },
  State_74829_Name = {
    Text = "对全体敌方造成已损失生命 [DescArg1]% 的<FixedDamage:纯粹伤害>"
  },
  State_74830_Name = {
    Text = "获得 [DescArg1] 点力量"
  },
  State_74831_Name = {
    Text = "所有唤醒体获得 [DescArg1] 点狂气"
  },
  State_74847_Desc = {
    Text = "队伍唯一：装备者每回合使用的第一张指令卡造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。若其进入了超维空间，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气。"
  },
  State_74847_WeaponDesc = {
    Text = "装备者每回合使用的第一张指令卡造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。若其进入了超维空间，装备者获得 <WeaponEffect_Num:[StateArg2]> 点狂气。"
  },
  State_74879_Name = {
    Text = "获得 [DescArg1] 点算力"
  },
  State_74881_Name = {
    Text = "选择一名唤醒体获得 [DescArg1] 点狂气"
  },
  State_74882_Name = {
    Text = "获得 [DescArg1] 点界域精通"
  },
  State_74883_Name = {
    Text = "下 [DescArg1] 张打出的指令卡额外获得 [DescArg2] 点钥能"
  },
  State_74884_Name = {
    Text = "本回合造成的中毒、反击、出血提高 [DescArg1]%"
  },
  State_74885_Name = {
    Text = "所有唤醒体获得 [DescArg1] 点狂气"
  },
  State_74887_Name = {
    Text = "获得 [DescArg1] 点护盾"
  },
  State_74888_Name = {
    Text = "获得 [DescArg1] 点死亡抵抗"
  },
  State_74889_Name = {
    Text = "获得 [DescArg1] 层反击"
  },
  State_74890_Name = {
    Text = "偷取所有敌人 [DescArg1] 点临时力量"
  },
  State_74891_Name = {
    Text = "随机造成 [DescArg1] 点<FixedDamage:纯粹伤害> [DescArg2] 次（该伤害受到1倍力量加成）"
  },
  State_74910_Desc = {
    Text = "队伍唯一：若装备者为唤醒体「拉蒙娜」，探索关卡所获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_74910_WeaponDesc = {
    Text = "若装备者为唤醒体「拉蒙娜」，完成关卡时获得的同调率提高 <WeaponEffect_Num:[StateArg1]%>。"
  },
  State_74932_Desc = {
    Text = "打出「打击」卡、「防御」卡、「技能」卡时会升级「禁忌的交易」中的对应效果。"
  },
  State_74932_Name = {
    Text = "禁忌的交易"
  },
  State_74947_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合开始时，对<HPAndShieldMin:生命与护盾最低>敌方附加 [StateArg1] 层行动封锁。装备者造成击杀后，立刻触发一次该效果。"
  },
  State_74947_Name = {
    Text = "魔女宽檐帽"
  },
  State_74948_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后使狂气最高的敌方失去 [StateArg1] 狂气并获得<PVPEmptinessKeywords:空虚>。"
  },
  State_74948_Name = {
    Text = "催眠灵摆"
  },
  State_76236_Desc = {
    Text = "\n·银钥觉醒：银钥能量满时，可以额外选择「银钥觉醒」来将指定唤醒体的灵知觉醒牌置入手中并使其获得「保留」，本场战斗有效。「银钥觉醒」每回合只能触发 1 次，与「钥令」独立冷却。\n·钥能超载：使用「银钥觉醒」时，每有一个已解锁灵知觉醒的唤醒体，就额外扣除 1000 点银钥能量，这个效果可能使银钥能量变为负数。\n·归档刻痕：守密人每拥有 1 个钥令，就使「物象研究深度」与「灵识研究深度」提高 1％，至多提高 50％。所有 R 命轮的效果变更为使装备者的维度影像造物出现的可能性提高 100%。"
  },
  State_76236_Name = {
    Text = "璀璨银辉"
  },
  State_76277_Desc = {
    Text = "队伍唯一：首领战开始后，消耗最多 50 黑印，每消耗 1 点黑印获得 <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: 死亡抵抗>。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76277_WeaponDesc = {
    Text = "首领战开始后，消耗最多 50 黑印，每消耗 1 点黑印获得 <WeaponEffect_Num:[StateArg1]%> <DeathResistanceIconKeywords: 死亡抵抗>。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76278_Desc = {
    Text = "队伍唯一：每走过一个新的格子，回复 <WeaponEffect_Num:[StateArg1]%> 已损失血量。使用应急灵知体后，所有唤醒体的暴击率和暴击伤害提高 100%。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76278_WeaponDesc = {
    Text = "每走过一个新的格子，回复[StateArg1]% 已损失血量([DescArg1])。使用应急灵知体后，所有唤醒体的暴击率和暴击伤害提高 100%。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76279_Desc = {
    Text = "队伍唯一：融痕中觉醒唤醒体的价格降低 <WeaponEffect_Num:[StateArg1]> 点黑印。装备者的灵知觉醒获得固有。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76279_WeaponDesc = {
    Text = "融痕中觉醒唤醒体的价格降低 <WeaponEffect_Num:[StateArg1]> 点黑印。装备者的灵知觉醒获得固有。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76280_Desc = {
    Text = "队伍唯一：休息处的回复量提高 <WeaponEffect_Num:[StateArg1]%>，选择回复生命后，将 2 张「灵感」加入牌库。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76280_WeaponDesc = {
    Text = "休息处的回复量提高 <WeaponEffect_Num:[StateArg1]%>，选择回复生命后，将 2 张「灵感」加入牌库。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76281_Desc = {
    Text = "队伍唯一：战斗结束后，狂气最低的唤醒体获得 <WeaponEffect_Num:[StateArg1]> 点狂气。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76281_WeaponDesc = {
    Text = "战斗结束后，狂气最低的唤醒体获得 <WeaponEffect_Num:[Energy:StateArg1]> 点狂气。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76282_Desc = {
    Text = "队伍唯一：融痕刷新次数 +1 ，刷新价格减少 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76282_WeaponDesc = {
    Text = "融痕刷新次数 +1，刷新价格减少 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76283_Desc = {
    Text = "队伍唯一：融痕造物栏变为 3 个，其中一个为诅咒造物。购买诅咒造物后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76283_WeaponDesc = {
    Text = "融痕造物栏变为 3 个，其中一个为诅咒造物。购买诅咒造物后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76284_Desc = {
    Text = "队伍唯一：关卡开始后，所有唤醒体获得 <WeaponEffect_Num:[StateArg1]> 点狂气。首领战开始后，抽 2 张牌。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76284_WeaponDesc = {
    Text = "关卡开始后，所有唤醒体获得 <WeaponEffect_Num:[Energy:StateArg1]> 点狂气。首领战开始后，抽 2 张牌。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76285_Desc = {
    Text = "队伍唯一：关卡开始后，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。首领战开始后，获得 2 点算力。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76285_WeaponDesc = {
    Text = "关卡开始后，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。首领战开始后，获得 2 点算力。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76286_Desc = {
    Text = "队伍唯一：休息处额外提供一个选项：消除至多 3 张症状，获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76286_WeaponDesc = {
    Text = "休息处额外提供一个选项：消除至多 3 张症状，获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76287_Desc = {
    Text = "队伍唯一：普通战斗结束后可选择的刻印数量变为 4 个，装备者卡牌的刻印有 <WeaponEffect_Num:[StateArg1]%> 概率升级为高级刻印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76287_WeaponDesc = {
    Text = "普通战斗结束后可选择的刻印数量变为 4 个，装备者卡牌的刻印有 <WeaponEffect_Num:[StateArg1]%> 概率升级为高级刻印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76288_Desc = {
    Text = "队伍唯一：战斗结束后，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76288_WeaponDesc = {
    Text = "战斗结束后，获得 <WeaponEffect_Num:[StateArg1]> 点银钥能量。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76289_Desc = {
    Text = "队伍唯一：探索中视野+1，地图视野全开后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。首领战开始时，<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76289_WeaponDesc = {
    Text = "探索中视野+1，地图视野全开后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。首领战开始时，<WeaknessIconKeywords:虚弱>和<VulnerabilityIconKeywords:易伤>所有敌人 1 回合。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76290_Desc = {
    Text = "队伍唯一：普通战斗结束后，可以选择放弃刻印，生命上限提高 <WeaponEffect_Num:[StateArg1]%>。该效果最多生效 2 次。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76290_WeaponDesc = {
    Text = "普通战斗结束后，可以选择放弃刻印，生命上限提高 <WeaponEffect_Num:[DescArg1]>。该效果最多生效 2 次。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76291_Desc = {
    Text = "队伍唯一：关卡开始后，获得 <WeaponEffect_Num:[StateArg1]> 点黑印。造物上限 +2。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76291_WeaponDesc = {
    Text = "关卡开始后，获得 <WeaponEffect_Num:[StateArg1]> 点黑印。造物上限 +2。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76292_Desc = {
    Text = "队伍唯一：融痕售卖卡牌处允许售卖症状卡，卖出症状卡后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76292_WeaponDesc = {
    Text = "融痕售卖卡牌处允许售卖症状卡，卖出症状卡后获得 <WeaponEffect_Num:[StateArg1]> 点黑印。在星辰篇中，效果改为「使装备者的维度影像造物出现的可能性提高 100％」。"
  },
  State_76321_Name = {
    Text = "棱彩透镜"
  },
  State_76323_Name = {
    Text = "狂气调和"
  },
  State_76324_Name = {
    Text = "算力调和"
  },
  State_76325_Desc = {
    Text = "打出 [DescArg1] 张指令卡后，进入「算力调和」状态。"
  },
  State_76325_Name = {
    Text = "算力调和"
  },
  State_76326_Name = {
    Text = "存在悖论"
  },
  State_76328_Name = {
    Text = "命运光锥"
  },
  State_76337_Name = {
    Text = "无底创痕"
  },
  State_76338_Desc = {
    Text = "玩家受到的治疗减少 [Layer]％。"
  },
  State_76338_Name = {
    Text = "无底创痕"
  },
  State_76430_Name = {
    Text = "维度影像·莉莉"
  },
  State_76433_Name = {
    Text = "算力调和"
  },
  State_76434_Desc = {
    Text = "每当打出指令卡时，若因算力调和额外消耗了算力，额外获得 100% 唤醒体银钥充能的银钥能量，可叠加。"
  },
  State_76434_Name = {
    Text = "算力调和"
  },
  State_76435_Name = {
    Text = "棱彩透镜"
  },
  State_76528_Name = {
    Text = "此卡视为「打击」"
  },
  State_76529_Desc = {
    Text = "拾取时选择一张唤醒体的卡牌，使其算力消耗降低 1，打出后抽 1 张牌，并将其视为「打击」。"
  },
  State_76533_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合结束时，赋予对手的随机 [StateArg1] 张手牌 [StateArg2]层<PVPAcheKeywords:隐没的痛楚>。"
  },
  State_76533_Name = {
    Text = "隐没的痛楚"
  },
  State_76553_Desc = {
    Text = "此卡牌算力消耗 -[StateArg1]。"
  },
  State_76553_Name = {
    Text = "百万蒙宠之眼"
  },
  State_77686_Name = {
    Text = "半机械形态"
  },
  State_77688_Desc = {
    Text = "第五回合开始或即将死亡时，免疫死亡并将意图调整为「机械飞升」。"
  },
  State_77688_Name = {
    Text = "肉体孱弱"
  },
  State_77690_Desc = {
    Text = "切换为「半机械形态」后，每有 1 层终末，额外获得 10％ 最大生命。「半机械形态」下「熔毁·朵尔」会随着「终末」层数的增加释放更具威胁性的技能。"
  },
  State_77690_Name = {Text = "终末"},
  State_77692_Desc = {
    Text = "回合结束时，召唤 2 个融蚀怪物，至多同时存在 2 个。召唤的融蚀怪物死亡后，「熔毁·朵尔」失去 5% 最大生命。"
  },
  State_77692_Name = {
    Text = "深渊之门"
  },
  State_77693_Desc = {
    Text = "死亡后「熔毁·朵尔」失去 5% 最大生命。"
  },
  State_77693_Name = {Text = "熔毁"},
  State_78102_Desc = {
    Text = "造成的伤害降低 15％，承受伤害提高 30％，持续至战斗结束。"
  },
  State_78102_Name = {
    Text = "超频瘫痪"
  },
  State_78694_Desc = {
    Text = "战斗开始时获得 [Arg1] 点力量。回合开始每有 [Arg2] 点永久力量获得 [Arg3] 点临时力量，最多获得 [Arg4] 点临时力量，并在回合结束时失去由该造物获得临时力量一半的护盾。"
  },
  State_78696_Desc = {
    Text = "使用银钥觉醒后选择对应唤醒体的 [Arg1] 张「技能」将其消耗，并把 [Arg2] 张附加消耗的复制洗入抽牌堆。"
  },
  State_78697_Desc = {
    Text = "回合开始时，被施加 [Arg2] 层中毒，超维空间每有 1 个空位就获得 [Arg1] 点力量。"
  },
  State_78698_Desc = {
    Text = "算力上限 -[Arg1]。每打出 1 张算力消耗大于等于 [Arg2] 的牌获得一点算力，每回合最多触发 [Arg3] 次。"
  },
  State_78699_Desc = {
    Text = "抽牌后额外抽 [Arg1] 张牌，但选择 [Arg2] 张手牌弃掉。"
  },
  State_78700_Desc = {
    Text = "所有唤醒体的基础伤害提高 [Arg1]%，每次重置牌库额外提高 [Arg2]%，但将 1 张「蹒跚」置入手中，提高值最多为 [Arg3]%。"
  },
  State_78701_Desc = {
    Text = "回合开始时若有超过 [Arg1] 条的永久触腕，失去 [Arg2] 条触腕获得 [Arg3] 条临时触腕，否则获得 [Arg4] 条临时触腕。"
  },
  State_78702_Desc = {
    Text = "银钥觉醒后额外消耗 [Arg1] 点银钥能量，使获得的灵知觉醒卡算力消耗变为 0，打出后使对应唤醒体额外获得 [Arg2] 点狂气。"
  },
  State_78703_Desc = {
    Text = "战斗开始时对所有敌人造成 [Arg1] 点中毒。回合开始前移除敌人 [Arg2]% 的中毒，对其施加 [Arg3]% 移除量的出血。"
  },
  State_78710_Desc = {
    Text = "每打出一张指令卡使对应唤醒体当回合造成最终伤害提高 [Arg1]%，但使其失去 [Arg2] 点狂气，每回合最多触发 [Arg3] 次。"
  },
  State_78712_Desc = {
    Text = "回合开始时胚胎融合度+ [Arg1]，你的胚胎会在回合结束时被弃掉。"
  },
  State_78713_Desc = {
    Text = "回合开始时获得 [Arg1] 点反击。在一回合内释放 [Arg2] 次狂气爆发后，移除自身 [Arg3]% 永久反击，获得 [Arg4]% 移除量的临时反击，[Arg5] 回合冷却。"
  },
  State_78781_Desc = {
    Text = "临时降低目标力量，获得等量临时力量。"
  },
  State_78781_Name = {
    Text = "<TouquKeywords: 偷取>"
  },
  State_79405_Desc = {
    Text = "打出后「清明之忆」提高 1，达到 10 时将其锁定 1 回合并获得 3 张「灵感」，下回合开始时重置为 5。"
  },
  State_79405_Name = {
    Text = "真实的往昔"
  },
  State_79406_Desc = {
    Text = "打出后「清明之忆」降低 1，达到 0 时将其锁定 1 回合并使所有唤醒体获得 30 点狂气，下回合开始时重置为 5。"
  },
  State_79406_Name = {
    Text = "浮华的迷梦"
  },
  State_80052_Desc = {Text = "测试"},
  State_80052_Name = {Text = "测试123"},
  State_80052_WeaponDesc = {Text = "测试"},
  State_80161_Desc = {
    Text = "队伍唯一：装备者狂气爆发造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，银钥充能提高 <WeaponEffect_Num:[StateArg2]%>。进入超维回合后，所有唤醒体获得 <WeaponEffect_Num:[StateArg4]> 点狂气。释放「湮灭」后，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_80161_WeaponDesc = {
    Text = "装备者狂气爆发造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，银钥充能提高 <WeaponEffect_Num:[DescArg1]>。进入超维回合后，所有唤醒体获得 <WeaponEffect_Num:[StateArg4]> 点狂气。释放「湮灭」后，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_80174_Desc = {
    Text = "队伍唯一:装备者银钥充能提高 <WeaponEffect_Num:[StateArg1]%>。首场战斗开始后，对所有敌人施加 1 层虚弱和易伤。"
  },
  State_80174_WeaponDesc = {
    Text = "装备者银钥充能提高 <WeaponEffect_Num:[DescArg1]>。首场战斗开始后，对所有敌人施加 1 层虚弱和易伤。"
  },
  State_80207_Desc = {
    Text = "若此卡打出后触发「维度穿梭」则触发后续效果，从超维空间取出时算力消耗 -1。"
  },
  State_80207_Name = {
    Text = "<WormholeKeywords:超距>"
  },
  State_80328_Desc = {
    Text = "她的情感、认知乃至一切，都与巢群意志永恒链接。至多堆叠 15 层。「共感」能够被克莱门汀的狂气爆发「生命重构治疗」转化为减益效果。"
  },
  State_80328_Name = {Text = "共感"},
  State_80331_Desc = {
    Text = "巢群侵蚀下，你的弱点展露无遗。本回合承受的主动和触腕伤害提高 [DescArg1]％。"
  },
  State_80331_Name = {
    Text = "<D13Colour:精神创伤>"
  },
  State_80332_Desc = {
    Text = "她的情感、认知乃至一切，都与巢群意志永恒链接，至多堆叠 10 层。「共感」能够被克莱门汀的狂气爆发「生命重构治疗」转化为减益效果。"
  },
  State_80332_Name = {Text = "共感"},
  State_80335_Desc = {
    Text = "巢群侵蚀下，你的弱点展露无遗。本回合承受的主动和触腕伤害提高 [DescArg1]％。"
  },
  State_80335_Name = {
    Text = "<D13Colour:精神创伤>"
  },
  State_80336_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。本回合造成的主动和触腕伤害降低 [DescArg1]％。"
  },
  State_80336_Name = {
    Text = "<D13Colour:恐惧固着>"
  },
  State_80338_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。本回合造成的主动和触腕伤害降低 [DescArg1]％。"
  },
  State_80338_Name = {
    Text = "<D13Colour:恐惧固着>"
  },
  State_80575_Desc = {
    Text = "承受主动伤害或触腕伤害后，移除等量的「旧日余烬」并失去 300％ 移除量的生命，承受其它伤害时移除一半。「旧日余烬」层数每回合重置。"
  },
  State_80575_Name = {
    Text = "旧日余烬"
  },
  State_80644_Name = {
    Text = "状态@超越之光中"
  },
  State_80773_Desc = {
    Text = "承受力量降低效果时，仅会降低 50% 的力量层数。自身回合内，承受的非主动和触腕伤害提高 100％。"
  },
  State_80773_Name = {
    Text = "异维抗体"
  },
  State_80774_Desc = {
    Text = "承受主动伤害或触腕伤害后，移除等量的「旧日余烬」并失去 300％ 移除量的生命，承受其它伤害时移除一半。「旧日余烬」层数每回合重置。「旧日余烬」被全部移除后，获得 50 层「加固」。"
  },
  State_80774_Name = {
    Text = "旧日余烬"
  },
  State_80777_Desc = {
    Text = "战斗开始时，降低所有唤醒体暴击率 10％。死亡后，其它友方获得 [DescArg1] 点力量和 [DescArg2] 层「旧日余烬」。"
  },
  State_80777_Name = {
    Text = "巢群共感-传承"
  },
  State_80778_Desc = {
    Text = "死亡后，其他友方获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  State_80778_Name = {
    Text = "巢群共感-融合"
  },
  State_80782_Desc = {
    Text = "本场战斗中，所有唤醒体暴击率降低 [Layer]％。"
  },
  State_80782_Name = {
    Text = "暴击率降低"
  },
  State_80783_Desc = {
    Text = "回合结束时，获得 1 层<MadnessIconKeywords:疯狂>。"
  },
  State_80783_Name = {
    Text = "同族羁绊"
  },
  State_80784_Desc = {
    Text = "生命低于 50％ 后，召唤一名「初变者」在后方，每场战斗仅触发 1 次。"
  },
  State_80784_Name = {
    Text = "巢群共感-裂变"
  },
  State_80785_Desc = {
    Text = "力量被降低时，仅会降低 50% 的力量层数。每当玩家释放狂气爆发，获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  State_80785_Name = {
    Text = "巢群共感-异维"
  },
  State_80788_Desc = {
    Text = "力量被降低时，仅会降低 25% 的力量层数。每当玩家释放狂气爆发，获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  State_80788_Name = {
    Text = "巢群共感-异维"
  },
  State_80789_Desc = {
    Text = "承受主动和触腕伤害提高 100％，持续 1 回合。"
  },
  State_80789_Name = {Text = "蛰伏"},
  State_80790_Desc = {
    Text = "在蜕变后，每层宇宙幽能会使其变得完美……"
  },
  State_80790_Name = {
    Text = "宇宙幽能"
  },
  State_80792_Desc = {
    Text = "每当玩家释放狂气爆发，获得 1 层临时<MadnessIconKeywords:疯狂>。"
  },
  State_80792_Name = {
    Text = "巢群共感-异维"
  },
  State_80794_Desc = {
    Text = "卡牌无法打出，且回合结束时依然保留在手中。"
  },
  State_80794_Name = {
    Text = "<Boundkeywords:缚身>"
  },
  State_80807_Desc = {
    Text = "第五回合开始或即将死亡时，移除所有其他敌人，将意图切换为「蜕变之刻」。"
  },
  State_80807_Name = {
    Text = "蜕变之刻"
  },
  State_80809_Desc = {
    Text = "回合结束时，手中带有虚无的牌会被丢弃。"
  },
  State_80809_Name = {
    Text = "<PVPVoidKeyColour:虚无>"
  },
  State_80810_Desc = {
    Text = "承受主动伤害或触腕伤害后，移除等量的「旧日余烬」并失去 300％ 移除量的生命，承受其它伤害时移除一半。「旧日余烬」层数每回合重置。"
  },
  State_80810_Name = {
    Text = "旧日余烬"
  },
  State_80827_Desc = {
    Text = "每累计打出 15 张卡牌，将当前的意图替换为「创伤猛击」（当前还剩 [Layer] 张)。"
  },
  State_80827_Name = {
    Text = "愤怒的惩罚"
  },
  State_81022_WeaponDesc = {
    Text = "每受到1次伤害，全体唤醒体增加 1 点狂气。"
  },
  State_81027_Desc = {
    Text = "此卡牌的所属者为「虫族」，算力消耗-1，打出后会被「消耗」。"
  },
  State_81027_Name = {
    Text = "生命仪式"
  },
  State_81054_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。每拥有 1 层本回合造成的主动和触腕伤害伤害降低 3％，至多堆叠 15 层。"
  },
  State_81054_Name = {
    Text = "<D13AFKeyWordQ1:恐惧固着>"
  },
  State_81055_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。每拥有 1 层本回合承受的主动和触腕伤害伤害提高 3％，至多堆叠 10 层。"
  },
  State_81055_Name = {
    Text = "<D13AFKeyWord2:精神创伤>"
  },
  State_81056_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。每拥有 1 层本回合承受的主动和触腕伤害伤害提高 3％，至多堆叠 15 层。"
  },
  State_81056_Name = {
    Text = "<D13AFKeyWordQ2:精神创伤>"
  },
  State_81057_Desc = {
    Text = "巢群侵蚀下，你的恐惧无所遁形。每拥有 1 层本回合造成的主动和触腕伤害伤害降低 3％，至多堆叠 10 层。"
  },
  State_81057_Name = {
    Text = "<D13AFKeyWord1:恐惧固着>"
  },
  State_81058_Desc = {
    Text = "她的情感、认知乃至一切，都与巢群意志永恒链接。「共感」能够被克莱门汀的狂气爆发「生命重构治疗」转化为减益效果，至多堆叠 15 层。"
  },
  State_81058_Name = {
    Text = "<AnalysisKeywords3:共感>"
  },
  State_81059_Desc = {
    Text = "她的情感、认知乃至一切，都与巢群意志永恒链接。「共感」能够被克莱门汀的狂气爆发「生命重构治疗」转化为减益效果，至多堆叠 10 层。"
  },
  State_81059_Name = {
    Text = "<AnalysisKeywords0:共感>"
  },
  State_81073_Desc = {
    Text = "受到致命伤害后立刻回复所有生命并获得 80％ 临时加固，召唤一名「初变者」在后方，可触发 2 次。"
  },
  State_81073_Name = {
    Text = "巢群共感-裂变"
  },
  State_81278_Desc = {
    Text = "每回合首次释放钥令后，所有唤醒体获得 10 狂气，但释放钥令消耗永久提高 10%。"
  },
  State_81278_Name = {
    Text = "银钥抑制"
  },
  State_81312_Desc = {
    Text = "受到致命伤害后，回复所有生命并获得 50 层临时加固。还能够触发 [Layer] 次。"
  },
  State_81312_Name = {
    Text = "宇宙轮回"
  },
  State_81331_Desc = {
    Text = "回合开始时，选择 1 名唤醒体，封印其所有卡牌和狂气爆发 3 回合。"
  },
  State_81331_Name = {
    Text = "意识幽禁"
  },
  State_81340_Desc = {
    Text = "此卡牌被封印无法打出， [Layer] 回合后封印解除。"
  },
  State_81340_Name = {
    Text = "<Seal1:卡牌封印>"
  },
  State_81341_Desc = {
    Text = "此唤醒体狂气爆发被封印无法使用， [Layer] 回合后封印解除。"
  },
  State_81341_Name = {
    Text = "<Seal1:狂气封印>"
  },
  State_81354_Desc = {
    Text = "打出后受到 [DescArg1] 点伤害，若回合结束时未打出会被消耗。"
  },
  State_81354_Name = {
    Text = "<BurningKeywords:燃烧>"
  },
  State_81356_Desc = {
    Text = "使卡牌燃烧，打出后受到 [DescArg1] 点伤害，若回合结束仍在手中将其消耗。"
  },
  State_81356_Name = {
    Text = "<BurningKeywords:燃烧>"
  },
  State_81356_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_83587_Desc = {
    Text = "能够提升选择「破浪启航」时的效果，上限10层。"
  },
  State_83587_Name = {
    Text = "「扬帆」"
  },
  State_83589_Desc = {
    Text = "能够提升选择「拢岸暂息」时的效果，上限10层。"
  },
  State_83589_Name = {
    Text = "「泊锚」"
  },
  State_83593_Desc = {
    Text = "本回合所有唤醒体造成的最终伤害提高"
  },
  State_83593_Name = {
    Text = "最终伤害"
  },
  State_83596_Desc = {
    Text = "手牌上限+1。回合开始时若牌库没有「引航员的抉择」，将其置入手中。每当首领失去 10% 最大生命，获得 1 层「扬帆」；每当自身失去 10% 最大生命，获得 1 层「泊锚」。"
  },
  State_83596_Name = {
    Text = "伊拉斯莫的指引-「扬帆」"
  },
  State_83607_Desc = {
    Text = "首领累积损失百分之十生命标识"
  },
  State_83607_Name = {
    Text = "状态@首领累积损失百分之十生命标识"
  },
  State_83609_Desc = {
    Text = "玩家累积损失百分之十生命标识"
  },
  State_83609_Name = {
    Text = "状态@玩家累积损失百分之十生命标识"
  },
  State_83614_Desc = {
    Text = "玩家10%血量值"
  },
  State_83614_Name = {
    Text = "状态@玩家百分之十血量值"
  },
  State_83615_Desc = {
    Text = "失去 [Layer] 点生命后，获得 1 层「扬帆」。"
  },
  State_83615_Name = {
    Text = "「扬帆」进度"
  },
  State_83616_Desc = {
    Text = "失去 [Layer] 点生命后，获得 1 层「泊锚」。"
  },
  State_83616_Name = {
    Text = "「泊锚」进度"
  },
  State_83617_Desc = {
    Text = "首领10%血量值"
  },
  State_83617_Name = {
    Text = "状态@首领百分之十血量值"
  },
  State_83618_Desc = {
    Text = "测试时当前生命为 [Layer] 点。"
  },
  State_83618_Name = {
    Text = "敌人当前生命计数"
  },
  State_83619_Desc = {
    Text = "测试时最大生命为 [Layer] 点。"
  },
  State_83619_Name = {
    Text = "敌人最大生命计数"
  },
  State_83620_Desc = {
    Text = "当前参数4的值乘100为 [Layer] 点。"
  },
  State_83620_Name = {
    Text = "参数打印"
  },
  State_83621_Desc = {
    Text = "首领百分之十血量损失计数中间值"
  },
  State_83621_Name = {
    Text = "状态@首领百分之十血量损失计数中间值"
  },
  State_83622_Desc = {
    Text = "玩家百分之十血量损失计数中间值"
  },
  State_83622_Name = {
    Text = "状态@玩家百分之十血量损失计数中间值"
  },
  State_83627_Desc = {
    Text = "失去[DescArg1]点生命后，获得1层「扬帆」"
  },
  State_83627_Name = {
    Text = "「扬帆」进度"
  },
  State_83805_Name = {Text = "余波"},
  State_83807_Name = {
    Text = "沉没于远海"
  },
  State_83808_Desc = {
    Text = "此卡牌被弃置时，触发「余波」效果。"
  },
  State_83808_Name = {
    Text = "<RippleKeywords:余波>"
  },
  State_83811_Desc = {
    Text = "额外承受 [Layer]％ 触腕伤害。"
  },
  State_83812_Desc = {
    Text = "额外承受 [Layer]％ 触腕伤害。"
  },
  State_83814_Desc = {
    Text = "首领10%血量值"
  },
  State_83814_Name = {
    Text = "首领百分之十血量值"
  },
  State_84140_Desc = {
    Text = "本场战斗已通过「喧嚣海洋」消耗了 [Layer] 张「腺体分裂」。"
  },
  State_84140_Name = {
    Text = "喧嚣海洋"
  },
  State_84184_Name = {
    Text = "该技能额外享受 [Layer]％ 力量加成"
  },
  State_84255_Desc = {
    Text = "队伍唯一：战斗开始时，获得等同于装备者防御力 <WeaponEffect_Num:[StateArg1]%> 的护盾。触发死亡抵抗后，下回合开始时再次触发该效果。"
  },
  State_84255_Name = {
    Text = "海上领航者"
  },
  State_84255_WeaponDesc = {
    Text = "战斗开始时，获得 <WeaponEffect_Num:[Block:DescArg1]> 点护盾。触发死亡抵抗后，下回合开始时再次触发该效果。"
  },
  State_84257_Desc = {
    Text = "队伍唯一：装备者狂气爆发造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，释放狂气爆发后所有唤醒体临时暴击伤害提高 <WeaponEffect_Num:[StateArg2]%>，每有 1 条触腕额外提高 1％。每次探索首次触发死亡抵抗后，下回合开始时回复最大生命的 <WeaponEffect_Num:[StateArg3]%>"
  },
  State_84257_WeaponDesc = {
    Text = "装备者狂气爆发造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，释放狂气爆发后所有唤醒体临时暴击伤害提高 <WeaponEffect_Num:[StateArg2]%>，每有 1 条触腕额外提高 1％。每次探索首次触发死亡抵抗后，下回合开始时回复最大生命的 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_84272_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，回复损失生命最多的友方 <Heal:[Heal:StateArg1]> 生命。"
  },
  State_84272_Name = {
    Text = "海上领航者"
  },
  State_84273_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合开始时，若自身没有<PVPProtectiveKeywords:屏障>获得 [StateArg1] 层<PVPProtectiveKeywords:屏障>，否则获得 <Energy:[Energy:StateArg2]> 狂气。"
  },
  State_84273_Name = {
    Text = "圣火中的指引"
  },
  State_84364_Desc = {
    Text = "暴击伤害 +[Layer]%。"
  },
  State_84364_Name = {
    Text = "暴击伤害"
  },
  State_84368_Desc = {
    Text = "剩余 [Layer] 回合冷却。"
  },
  State_84368_Name = {
    Text = "沉没于远海"
  },
  State_84375_Desc = {
    Text = "回合开始时，获得 [Layer] 点护盾。"
  },
  State_84375_Name = {
    Text = "海上领航者"
  },
  State_84376_Desc = {
    Text = "回合开始时，治疗 [Layer] 点生命。"
  },
  State_84376_Name = {
    Text = "圣火中的指引"
  },
  State_84399_Desc = {
    Text = "每回合结束时承受伤害提高 5% ，自身获得 2 层屏障。"
  },
  State_84399_Name = {
    Text = "沉没于远海"
  },
  State_84400_Desc = {
    Text = "下回合开始时每层屏障转化为 1 层<ReinforcePVEKeywords:加固>。"
  },
  State_84400_Name = {
    Text = "「领航」"
  },
  State_84402_Desc = {
    Text = "承受的所有伤害提高 [Layer]%。"
  },
  State_84402_Name = {
    Text = "透支力量"
  },
  State_89340_Desc = {
    Text = "额外承受 [Layer]％ 触腕伤害。"
  },
  State_89340_Name = {
    Text = "触腕易伤"
  },
  State_89422_Desc = {
    Text = "所有唤醒体产生的狂气提高 100%，每回合能够释放 2 次狂气爆发。"
  },
  State_89422_Name = {
    Text = "「不屈之心」"
  },
  State_89447_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：手牌上限 + [StateArg3]。「狂气爆发」后手中基础算力消耗为 [StateArg1] 的「技能」算力消耗减少 [StateArg2]。"
  },
  State_89447_Name = {
    Text = "不可承受的自由"
  },
  State_89448_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时使生命和护盾最低的友方获得  [StateArg1]  张<PVPDerivativeCardKeywords_16:「黑羽」>。"
  },
  State_89448_Name = {Text = "孤羽"},
  State_89554_Name = {
    Text = "命运光锥"
  },
  State_89555_Desc = {
    Text = "队伍唯一：装备者释放狂气爆发后，使狂气爆发基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 次。装备者探索所获得的同调率提高 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_89555_WeaponDesc = {
    Text = "装备者释放狂气爆发后，使狂气爆发基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，护盾和生命回复提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 5 次。完成探索后，装备者获得的同调率提高 <WeaponEffect_Num:[StateArg3]%>。"
  },
  State_89557_Name = {
    Text = "棱彩透镜"
  },
  State_89559_Desc = {
    Text = "\n·存在悖论：探索开始时，死亡抵抗的 75％ 转换为最大生命值加成，至多转换 300％ 死亡抵抗，至多提升 10％ 最大生命。每次触发死亡抵抗额外将 1 张「银钥微光」置入手中。\n·无底创痕：首领战中，我方受到的生命回复量每达到生命上限的 100%，就降低后续受到的生命回复效果 25%，但使当前死亡抵抗总量提高 25%，最多触发 3 次。\n·棱彩透镜：回合开始时，若反击超过 2000％ 生命上限，将超出部分层数减半，且永久反击至多堆叠 6000％ 生命上限;若敌人中毒超过 3000％ 生命上限，将超出部分层数减半，且中毒至多堆叠至 9000％ 生命上限。唤醒体根据反击获得的伤害加成量降低 70%，但造成的所有中毒与反击提高 10%。每觉醒一个唤醒体：回合结束后获得 25% 当前永久反击的临时反击，敌方回合结束时额外触发所有敌人 25% 中毒。\n·命运光锥：普通怪物释放「凝视」的回合数变为 6 回合。第 15 回合开始时，将 1 张「光锥界限」置入手中：将银钥能量和所有唤醒体的狂气填充至最大值。"
  },
  State_89559_Name = {
    Text = "时空扭曲"
  },
  State_89567_Desc = {
    Text = "此卡牌算力消耗 -[StateArg1]。"
  },
  State_89567_Name = {
    Text = "重生于湮土"
  },
  State_89568_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备者死亡后，将自身算力消耗 -[StateArg1] 的所有「技能」洗入抽牌堆，所属者改为剩余生命最高友方。"
  },
  State_89568_Name = {
    Text = "重生于湮土"
  },
  State_89571_Name = {
    Text = "「燃烧的剧场」"
  },
  State_89572_Desc = {
    Text = "回合开始时，对手牌堆随机 [DescArg1] 张牌附加<BurningKeywords:燃烧>，并获得 [DescArg2] 点临时力量。每过 2 个回合，附加燃烧的卡牌数提高 1，获得的临时力量提高 [DescArg3] 点。"
  },
  State_89572_Name = {
    Text = "「燃烧的剧场」"
  },
  State_89626_Desc = {
    Text = "使用银钥觉醒后，将 1 张「银钥微光」置入手中。所有唤醒体觉醒完成后，每回合开始时发现随机 1 张唤醒体的支援。"
  },
  State_89631_Desc = {
    Text = "额外 [Layer] 次跃迁"
  },
  State_89634_Desc = {
    Text = "灵知觉醒4"
  },
  State_89634_Name = {
    Text = "灵知觉醒4"
  },
  State_89637_Desc = {
    Text = "每回合第 1 张指令卡额外生效 1 次。湮灭时生成 1 条触腕。切换触腕为「怒涛」姿态后，本回合下 2 张指令卡跃迁效果必定发动并进入超维空间，3 回合冷却。"
  },
  State_89640_Desc = {
    Text = "界域精通提高 200 点。消耗猩红熔炉时，提高消耗量 15% 的触腕伤害。每次触腕攻击时，积累 [Arg3] 点猩红熔炉。"
  },
  State_89642_Desc = {
    Text = "手牌上限 +2 ，释放狂气爆发后临时最终伤害提高 10% 。卡牌进入超维空间后，手中 1 个「胚胎」转化为「圣洁之子」。每生成 1 个「胚胎」，超维空间一张随机卡牌算力消耗降低 1。"
  },
  State_89669_Desc = {
    Text = "银钥觉醒4"
  },
  State_89669_Name = {
    Text = "银钥觉醒4"
  },
  State_89759_Desc = {
    Text = "释放钥令后，拉蒙娜获得 50％ 临时暴击率。"
  },
  State_89759_Name = {
    Text = "珍贵的羁绊"
  },
  State_90023_Name = {
    Text = "常量表配置用的状态，暂时废弃了。"
  },
  State_90059_Desc = {
    Text = "本回合承受主动或触腕伤害时，移除等量侵蚀并失去移除量的 [DescArg1]％ 生命，承受其它伤害时移除 50% 伤害量的侵蚀。"
  },
  State_90059_Name = {Text = "侵蚀"},
  State_90094_Name = {Text = "黑羽"},
  State_90218_Desc = {
    Text = "队伍唯一：手牌上限+2，同类效果无法叠加。装备者造成的护盾和基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，进入超维回合后获得 <WeaponEffect_Num:[StateArg2]> 点狂气。释放「湮灭」后所有唤醒体临时暴击伤害+<WeaponEffect_Num:[StateArg3]%>，3 回合冷却。"
  },
  State_90218_WeaponDesc = {
    Text = "手牌上限+2，同类效果无法叠加。装备者造成的护盾和基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，进入超维回合后获得 <WeaponEffect_Num:[StateArg2]> 点狂气。释放「湮灭」后所有唤醒体临时暴击伤害+<WeaponEffect_Num:[StateArg3]%>，3 回合冷却。"
  },
  State_90221_Desc = {
    Text = "队伍唯一：装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，回合结束时获得装备者防御力 <WeaponEffect_Num:[StateArg2]%> 的护盾，每回合提高防御力的 2％。"
  },
  State_90221_Name = {Text = "孤羽"},
  State_90221_WeaponDesc = {
    Text = "装备者造成的护盾提高 <WeaponEffect_Num:[StateArg1]%>，回合结束时获得 <WeaponEffect_Num:[Block:DescArg1]> 点护盾。"
  },
  State_90294_Desc = {
    Text = "本回合承受主动或触腕伤害时，移除等量侵蚀并失去移除量的 [DescArg1]％ 生命，承受其它伤害时移除 50% 伤害量的侵蚀。"
  },
  State_90294_Name = {
    Text = "<Corrosion:侵蚀>"
  },
  State_90591_Name = {
    Text = "将 [Layer] 张「灵感」置入手中"
  },
  State_90594_Name = {
    Text = "和 [Layer] 点临时戒备"
  },
  State_90599_Name = {
    Text = "使所有唤醒体获得 [Layer] 点狂气"
  },
  State_90600_Name = {
    Text = "获得 [Layer] 点银钥能量"
  },
  State_90601_Name = {
    Text = "(剩余 [DescArg1] 次<harmonyKeyWord:「调和」>)"
  },
  State_90603_Name = {
    Text = "获得 [Layer] 点临时力量"
  },
  State_90604_Name = {
    Text = "回复 [Layer] 点生命，随已损生命提高"
  },
  State_90696_Desc = {
    Text = "打出前发现 1 味「调料」置入其中并触发其效果，首领战中增加 1 次调和次数。"
  },
  State_90696_Name = {
    Text = "<harmonyKeyWord:调和>"
  },
  State_91106_Desc = {
    Text = "每层狂热使造成的主动伤害和触腕伤害附带 10% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  State_91106_Name = {Text = "狂热"},
  State_91165_Name = {
    Text = "苍白之卵"
  },
  State_91235_Desc = {
    Text = "失去生命时减少等量数层，伤势归 0 时，所有唤醒体获得 10 狂气，重置伤势层数。"
  },
  State_91235_Name = {Text = "伤势"},
  State_91236_Name = {
    Text = "罗马活动施加首领生命计数"
  },
  State_91329_Desc = {
    Text = "此卡牌算力消耗 -[StateArg1]。"
  },
  State_91329_Name = {Text = "珍馐"},
  State_91521_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：回合结束时，将 [StateArg1] 张<PVPDerivativeCardKeywords_17:「灵感」>置入手牌。"
  },
  State_91521_Name = {
    Text = "搭档特训"
  },
  State_91522_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时和回合结束时，装备者对后排敌方造成 <Damage:[Damage:StateArg1]> 伤害。"
  },
  State_91522_Name = {Text = "开学日"},
  State_91676_Desc = {
    Text = "具体效果看通用打击逻辑。__「仅开发用」"
  },
  State_91706_Desc = {
    Text = "在下回合开始时获得等量层数算力。"
  },
  State_91706_Name = {
    Text = "<CardKeyWord:保留算力>"
  },
  State_91717_Desc = {
    Text = "至多积攒 3 具，达到上限后下次「生灵的盛筵」能够将其食用并强化其效果。残骸会继承至下场战斗。"
  },
  State_91717_Name = {Text = "残骸"},
  State_91759_Desc = {
    Text = "黑羽能够加强「圣子·黑羽」的能力。"
  },
  State_91759_Name = {Text = "黑羽"},
  State_91761_Desc = {
    Text = "「圣子·黑羽」未被击破护盾的 50% 会保留至下回合，回合结束后获得 1 层<Guaiwuheiyu:黑羽>。"
  },
  State_91761_Name = {
    Text = "翱翔夙愿"
  },
  State_91797_Desc = {
    Text = "此牌打出后和被弃置后为前排敌方施加等量层数护盾。"
  },
  State_91797_Name = {
    Text = "<PVPredKeyword:隐没的痛楚>"
  },
  State_91799_Desc = {
    Text = "此牌打出后为前排敌方施加 [Layer] 护盾。"
  },
  State_91799_Name = {
    Text = "<PVPredKeyword:隐没的痛楚 [Layer] >"
  },
  State_91809_Desc = {
    Text = "此卡牌算力消耗 -[Layer]。"
  },
  State_91809_Name = {
    Text = "专注精神"
  },
  State_91819_Desc = {
    Text = "根据战斗当前的回合数获得对应变化。"
  },
  State_91819_Name = {
    Text = "<CardKeyWord:成长>"
  },
  State_91827_Desc = {
    Text = "「打击」可以选择目标，「打击」前击退目标所有正面状态到其身后唤醒体。"
  },
  State_91827_Name = {
    Text = "<CardKeyWord:深海的呼唤>"
  },
  State_94410_Name = {
    Text = "每次回合开始和行动结束后会试图重置空的玩家牌库，若不为空则不重置。__「仅开发用」"
  },
  State_94411_Name = {
    Text = "每次回合开始和行动结束后会试图重置空的玩家牌库，若不为空则不重置。__「仅开发用」"
  },
  State_94426_Name = {
    Text = "被动护盾__「仅开发用」"
  },
  State_94540_Desc = {
    Text = "若目标背后没有其他唤醒体，则驱散目标正面状态。"
  },
  State_94540_Name = {
    Text = "<CardKeyWord:击退正面状态>"
  },
  State_94600_Desc = {
    Text = "受到致死伤害后移除 1 层并回复最大生命的 5%，本回合内每次触发使恢复量提高 1%。"
  },
  State_94600_Name = {
    Text = "死亡抵抗"
  },
  State_94603_Name = {
    Text = "食尸鬼标记"
  },
  State_94608_Name = {
    Text = "死亡抵抗承触发次数"
  },
  State_94623_Desc = {
    Text = "每层狂热使造成的主动伤害和触腕伤害附带 10% 伤害等量的<BleedingIconKeywords:出血>。"
  },
  State_94623_Name = {
    Text = "<Kuangre:狂热>"
  },
  State_94657_Desc = {
    Text = "击杀或触发敌人复活效果时，触发对应效果"
  },
  State_94657_Name = {
    Text = "<KillKeywords:击破>"
  },
  State_94692_Desc = {
    Text = "受到致死伤害后移除 1 层并回复最大生命的 5%，本回合内每次触发使恢复量提高 1%。"
  },
  State_94692_Name = {
    Text = "<Guaiwusiwangdikang: 死亡抵抗>"
  },
  State_94693_Desc = {
    Text = "回合开始时，若存在其他友方，失去 [DescArg1] 点生命，为生命最高友方增加 1 层<Guaiwusiwangdikang: 死亡抵抗>和 [DescArg2] 点 <PowerIconKeywords:力量>。"
  },
  State_94693_Name = {
    Text = "腐尸的分食"
  },
  State_94708_Desc = {
    Text = "回合开始时，若存在其他友方，失去 [DescArg1] 点生命，为生命最高友方增加 1 层<Guaiwusiwangdikang: 死亡抵抗>和 [DescArg2] 点<Duren:毒刃>。"
  },
  State_94708_Name = {
    Text = "深海的分食"
  },
  State_94730_Desc = {
    Text = "造成未被格挡的主动伤害时，施加 [Layer] 点<IntoxicationIconKeywords: 中毒>。"
  },
  State_94730_Name = {Text = "毒刃"},
  State_94993_Desc = {
    Text = "每回合重置惊天怒涛次数。"
  },
  State_94993_Name = {
    Text = "惊天怒涛次数重置"
  },
  State_94994_Desc = {
    Text = "每层使攻击次数加1，受到暴击伤害失去 1 层，最低为 1 层，在回合结束时失去全部。"
  },
  State_94994_Name = {
    Text = "惊天怒涛次数"
  },
  State_94995_Desc = {
    Text = "每次受到暴击伤害，获得 3% 的<Baojidikang:临时暴击抵抗>。每次造成伤害都会对一张随机卡牌附加「深潜印记」。"
  },
  State_94995_Name = {
    Text = "深海祭礼"
  },
  State_94996_Desc = {
    Text = "受到攻击时，获得等量层数的临时力量。"
  },
  State_94996_Name = {Text = "狂暴"},
  State_94997_Desc = {
    Text = "每次受到暴击伤害，获得 5% 的<Baojidikang:临时暴击抵抗>。每次造成伤害都会对一张随机卡牌附加「深潜印记」。"
  },
  State_94997_Name = {
    Text = "深海祭礼"
  },
  State_94998_Desc = {
    Text = "触发<Guaiwusiwangdikang: 死亡抵抗>时，对抽牌堆或手牌堆一张随机卡牌施加<SlowIconKeywords:迟缓>。"
  },
  State_94998_Name = {
    Text = "绝望化身"
  },
  State_94999_Desc = {
    Text = "每回合重置噬天巨浪次数。"
  },
  State_94999_Name = {
    Text = "噬天巨浪次数重置"
  },
  State_95000_Desc = {
    Text = "免疫负面状态。"
  },
  State_95000_Name = {
    Text = "负面状态免疫"
  },
  State_95001_Desc = {
    Text = "每层使攻击次数加1，受到暴击伤害失去 1 层，最低为 1 层，在回合结束时失去全部。"
  },
  State_95001_Name = {
    Text = "噬天巨浪次数"
  },
  State_95002_Desc = {
    Text = "本回合内受到暴击概率降低 [Layer]%。"
  },
  State_95002_Name = {
    Text = "临时暴击抵抗"
  },
  State_95002_WeaponDesc = {
    Text = "本回合内受到暴击概率降低 [Layer]%。"
  },
  State_95035_Desc = {
    Text = "造成未被格挡的主动伤害时，每有 1 层施加 1 点<IntoxicationIconKeywords: 中毒>。"
  },
  State_95035_Name = {
    Text = "<Duren: 毒刃>"
  },
  State_95038_Desc = {
    Text = "受到攻击时，获得等量层数的临时力量。"
  },
  State_95038_Name = {
    Text = "<Kuangbao: 狂暴>"
  },
  State_95040_Desc = {
    Text = "记录已损失生命"
  },
  State_95040_Name = {
    Text = "记录已损失生命"
  },
  State_95932_Name = {
    Text = "吸取食尸鬼等待"
  },
  State_95937_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后抽 [StateArg1] 张牌，优先抽取自身「技能」，并其算力消耗 - [StateArg2] 。"
  },
  State_95937_Name = {Text = "珍馐"},
  State_95938_Desc = {
    Text = "每移除一张牌，餍足层数+1，上限10层"
  },
  State_95938_Name = {Text = "餍足"},
  State_95943_Desc = {
    Text = "造成的伤害临时降低 30%。"
  },
  State_95943_Name = {
    Text = "正面干扰"
  },
  State_95944_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，每造成 1 次击杀就使装备者本次探索内暴击率提高 2％ 且狂气爆发造成的基础伤害提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 10 次。若当前界域为「血肉」，对装备者直接使用「胚胎」时额外获得 <WeaponEffect_Num:[StateArg4]> 点狂气，3 回合冷却。"
  },
  State_95944_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，每造成 1 次击杀就使装备者本次探索内暴击率提高 2％ 且狂气爆发造成的基础伤害提高 <WeaponEffect_Num:[StateArg2]%>，至多叠加 10 次。若当前界域为「血肉」，对装备者直接使用「胚胎」时额外获得 <WeaponEffect_Num:[StateArg4]> 点狂气，3 回合冷却。"
  },
  State_95948_Name = {
    Text = "吸取食尸鬼"
  },
  State_95949_Desc = {
    Text = "打出后使杜勒赛因失去一半<Guaiwucanhai:残骸>。"
  },
  State_95949_Name = {
    Text = "偷袭储备"
  },
  State_95953_Desc = {
    Text = "死亡抵抗的回复生命效果提高为 5 倍。"
  },
  State_95953_Name = {
    Text = "溟梦之帷"
  },
  State_95954_Name = {
    Text = "吸取食尸鬼觉醒版"
  },
  State_95960_Desc = {
    Text = "残骸数量会提高「残骸收取」的效果。"
  },
  State_95960_Name = {Text = "残骸"},
  State_95962_Name = {
    Text = "击杀数__「仅开发用」"
  },
  State_95964_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。若当前界域为「血肉」，装备者击杀敌方时积攒装备者攻击力 <WeaponEffect_Num:[StateArg2]%> 的猩红熔炉。"
  },
  State_95964_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。若当前界域为「血肉」，装备者击杀敌方时积攒 <WeaponEffect_Num:[DescArg1]> 点猩红熔炉。"
  },
  State_95966_Desc = {
    Text = "下回合开始时，抽 [Layer] 张牌该唤醒体卡牌。"
  },
  State_95966_Name = {
    Text = "残忍的致意"
  },
  State_95967_Desc = {
    Text = "残骸数量会提高「残骸收取」的效果。"
  },
  State_95967_Name = {
    Text = "<Guaiwucanhai:残骸>"
  },
  State_95968_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：装备时获得 [StateArg1] <StrongEffectKeywords:强效>。击杀敌方时溢出的伤害将向后方唤醒体传递。"
  },
  State_95968_Name = {
    Text = "安息之吻"
  },
  State_96167_Desc = {
    Text = "无法驱散，唤醒体被击杀后，其他友方获得 [StateArg1] <StrongEffectKeywords:强效>。"
  },
  State_96167_Name = {
    Text = "黑星燃烧之烬"
  },
  State_96183_Desc = {
    Text = "回合结束时，若场上没有其他友方，切换意图为自爆"
  },
  State_96183_Name = {
    Text = "食尸鬼自爆"
  },
  State_96193_Name = {
    Text = "餐前礼仪"
  },
  State_96330_Desc = {
    Text = "自身每损失 1％ 生命，杜勒赛因指令卡造成的基础伤害、护盾、狂气提高 1％。"
  },
  State_96330_Name = {
    Text = "幽魂絮语"
  },
  State_96352_Name = {
    Text = "最初的食尸鬼计数"
  },
  State_96354_Name = {
    Text = "起始最大生命"
  },
  State_96355_Desc = {
    Text = "受到暴击概率降低 [Layer]%。"
  },
  State_96355_Name = {
    Text = "暴击抵抗"
  },
  State_96355_WeaponDesc = {
    Text = "本场战斗内受到暴击概率降低 [Layer]%。"
  },
  State_96356_Desc = {
    Text = "每失去 [DescArg1] 点生命，获得 [DescArg2] 层<ReinforcePVEKeywords:加固>，最大为 [DescArg3]  层。触发「<Guaiwusiwangdikang:死亡抵抗>」后自身最大生命提高 [DescArg4] %。"
  },
  State_96356_Name = {
    Text = "伊莱娜的庇佑"
  },
  State_96357_Desc = {
    Text = "回合结束后，获得等量层数的力量。"
  },
  State_96357_Name = {
    Text = "<Fennu: 愤怒>"
  },
  State_96358_Desc = {
    Text = "受到暴击概率降低 [Layer] %。"
  },
  State_96358_Name = {
    Text = "<Baojidikang:暴击抵抗>"
  },
  State_96412_Name = {
    Text = "饕餮监听"
  },
  State_96416_Desc = {
    Text = "受到暴击概率降低 [Layer]%。"
  },
  State_96416_Name = {
    Text = "暴击抵抗"
  },
  State_96603_Name = {
    Text = "若本回合未打出，下回合开始时触发 1 次「调和」效果"
  },
  State_96610_Name = {
    Text = "首次死亡抵抗"
  },
  State_96613_Name = {
    Text = "巨浪监听"
  },
  State_96650_Desc = {
    Text = "每层使所有唤醒体暴击率提高 [DescArg1]%。"
  },
  State_96650_Name = {
    Text = "<ExclamationPointColour:深暗之焰>"
  },
  State_96719_Desc = {
    Text = "本回合打出<BurningKeywords:燃烧>的卡牌时，消耗 1 层<Heat:深暗之焰>使其生效 2 次，回合结束后清空<Heat:深暗之焰>。"
  },
  State_96719_Name = {
    Text = "无尽的爆炎"
  },
  State_96731_Desc = {
    Text = "本回合打出<BurningKeywords:燃烧>的卡牌时，消耗 1 层<Heat:深暗之焰>使其生效 2 次，回合结束后清空<Heat:深暗之焰>。"
  },
  State_96731_Name = {
    Text = "<Overload:无尽的爆炎>"
  },
  State_96732_Desc = {
    Text = "每层使所有唤醒体暴击率提高 [DescArg1]%。"
  },
  State_96732_Name = {
    Text = "<Heat:深暗之焰>"
  },
  State_96740_Desc = {
    Text = "受到的主动攻击伤害和出血层数提高 50%，受到伤害和回合开始时移除。"
  },
  State_96740_Name = {
    Text = "<CardKeyWord:破绽>"
  },
  State_96741_Desc = {
    Text = "打出后若剩余算力大于 [StateArg1] ，额外消耗 [StateArg1] 算力触发后续效果。__「仅开发用」"
  },
  State_96741_Name = {
    Text = "<CardKeyWord:算力超载>__「仅开发用」"
  },
  State_96742_Name = {
    Text = "算力超载触发标记__「仅开发用」"
  },
  State_96743_Desc = {
    Text = "打出后若剩余算力大于算力超载所需算力，额外消耗算力触发后续效果。"
  },
  State_96743_Name = {
    Text = "<CardKeyWord:算力超载>"
  },
  State_96744_Desc = {
    Text = "受到的主动攻击伤害和出血层数提高 50%，受到伤害和回合开始时移除。"
  },
  State_96744_Name = {Text = "破绽"},
  State_96774_Desc = {
    Text = "每次受到暴击伤害，获得 3% 的临时暴击抵抗。"
  },
  State_96774_Name = {
    Text = "深海怨灵"
  },
  State_96780_Desc = {
    Text = "卡牌获得保留，但打出或弃掉后会移除污染并召唤 1 个「深海分殖体」，最多 2 个。若无位置召唤会立刻使腐潮之傀获得 [DescArg1] 点力量和 [DescArg2] 点生命。"
  },
  State_96780_Name = {
    Text = "<Kuangluan:蹈海者狂乱>"
  },
  State_96783_Desc = {
    Text = "每回合为 2 张卡牌附加「<Kuangluan:蹈海者狂乱>」。"
  },
  State_96783_Name = {
    Text = "蹈海者祭仪"
  },
  State_96784_Desc = {
    Text = "能够降低腐潮之傀的攻势，最大为 5 层。"
  },
  State_96784_Name = {Text = "混乱"},
  State_96808_Desc = {
    Text = "每失去 [DescArg1] 生命就获得 15 层「<ReinforcePVEKeywords:加固>」，上限为 75 层，被击破后清空并获得 1 层「<Chaos:混乱>」。 若未释放过「骨血重组」，受到致命伤害后将意图切换为「骨血重组」并免疫一切伤害。"
  },
  State_96808_Name = {
    Text = "「嵌合之傀」"
  },
  State_96809_Name = {
    Text = "嵌合之傀计数"
  },
  State_96810_Desc = {
    Text = "造成的伤害降低 25%。"
  },
  State_96810_Name = {
    Text = "溟梦之帷"
  },
  State_96813_Name = {
    Text = "重组标记"
  },
  State_97114_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「打击」获得 [StateArg1] 算力，「技能」伤害提高 [StateArg2]%。"
  },
  State_97114_Name = {
    Text = "迫近的太阳"
  },
  State_97118_Name = {
    Text = "嵌合之傀击破"
  },
  State_97119_Desc = {
    Text = "卡牌获得保留，但打出或弃掉后会移除污染并召唤 1 个「深海分殖体」，最多 2 个。若无位置召唤会立刻使腐潮之傀获得 [DescArg1] 点力量和 [DescArg2] 点生命。"
  },
  State_97119_Name = {
    Text = "<Kuangluan:蹈海者狂乱>"
  },
  State_97120_Desc = {
    Text = "受到法阵保护，所有敌人造成的伤害降低 25%。"
  },
  State_97120_Name = {
    Text = "溟梦之帷"
  },
  State_97131_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「技能」每需要消耗 1 算力伤害提高 [StateArg1]%。造成击杀后「狂气爆发」造成伤害提高 [StateArg2]%，目前加成 [DescArg1]%。"
  },
  State_97131_Name = {
    Text = "琥珀色的死亡"
  },
  State_97134_Desc = {
    Text = "造成的最终伤害提高 50%。"
  },
  State_97134_Name = {
    Text = "赛琳涅的吟唱"
  },
  State_97135_Desc = {
    Text = "造成的最终伤害提高 25%。"
  },
  State_97135_Name = {
    Text = "赛琳涅的低语"
  },
  State_97136_Desc = {
    Text = "造成的最终伤害提高 100%。"
  },
  State_97136_Name = {
    Text = "赛琳涅的高歌"
  },
  State_97137_Desc = {
    Text = "弃掉后回到手中。"
  },
  State_97137_Name = {
    Text = "弃掉后回到手中"
  },
  State_97137_WeaponDesc = {
    Text = "抽到时使自身虚弱 1 回合。使用后虚弱所有敌人 1 回合。无法出售。"
  },
  State_97219_Desc = {
    Text = "旺达打出的下 [Layer] 张牌额外生效 1 次。"
  },
  State_97219_Name = {
    Text = "荆棘女王"
  },
  State_97251_Desc = {
    Text = "·不会成为对手优先攻击的目标，并且对手在选择单体目标时无法选择潜行唤醒体\n·在获得潜行时解除自身的嘲讽和其他友方的潜行。没有其他友方时或敌方获得嘲讽时，解除潜行。"
  },
  State_97251_Name = {Text = "潜行"},
  State_97252_Desc = {
    Text = "·不会成为对手优先攻击的目标，并且对手在选择单体目标时无法选择潜行唤醒体\n·在获得潜行时解除自身的嘲讽和其他友方的潜行。没有其他友方时或敌方获得嘲讽时，解除潜行。"
  },
  State_97252_Name = {
    Text = "<PVPSneakKeywords:潜行>"
  },
  State_97339_Name = {
    Text = "弥萨格夺冠金杯"
  },
  State_97742_Desc = {
    Text = "每次承受主动伤害时，对伤害来源造成 [Layer] 点<FixedDamage:纯粹伤害>。"
  },
  State_97742_Name = {Text = "反击"},
  State_97743_Desc = {
    Text = "造成的主动伤害提高 [Layer] 点。"
  },
  State_97743_Name = {
    Text = "<PowerColourKeywords:力量>"
  },
  State_97744_Desc = {
    Text = "承受的所有伤害降低 [Layer] %。"
  },
  State_97744_Name = {
    Text = "<ReinforceColour:加固>"
  },
  State_97744_WeaponDesc = {
    Text = "造成的所有伤害降低 [DescArg1] %。"
  },
  State_97938_Desc = {
    Text = "最终伤害提高 [DescArg1]%。"
  },
  State_97938_Name = {
    Text = "弥萨格夺冠金杯"
  },
  State_97939_Desc = {
    Text = "造成的最终伤害提高 50%。"
  },
  State_97939_Name = {
    Text = "弥萨格夺冠金杯"
  },
  State_97941_Desc = {
    Text = "基础伤害提高 100%。"
  },
  State_97941_Name = {
    Text = "弥萨格夺冠金杯"
  },
  State_97942_Desc = {
    Text = "释放狂气爆发时获得 35 点狂气。"
  },
  State_97942_Name = {
    Text = "弥萨格夺冠金杯"
  },
  State_97943_Name = {
    Text = "算力保留计数"
  },
  State_98055_Desc = {
    Text = "回合结束时，生成 1 条触腕。觉醒后移除该状态。"
  },
  State_98055_Name = {Text = "沉眠"},
  State_98060_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，回复生命并以真正的形态开始战斗。"
  },
  State_98060_Name = {
    Text = "尚未觉醒"
  },
  State_98068_Desc = {
    Text = "拥有 10 层「爆炎」时，获得 2 点算力并将所有「千兆耀斑」升级为「亿兆耀斑」。"
  },
  State_98068_Name = {
    Text = "<BaoyanKeywords:爆炎>"
  },
  State_98139_Desc = {
    Text = "对方回合开始后随机<BurningKeywords:燃烧> 1 张手牌。"
  },
  State_98139_Name = {
    Text = "业火重燃"
  },
  State_98140_Desc = {
    Text = "积攒 10 层<MonsterExFlameKeywords:爆炎>后将意图切换为极高伤害的「亿兆耀斑」！"
  },
  State_98140_Name = {
    Text = "<BurningColor:爆炎>"
  },
  State_98147_Desc = {
    Text = "敌人打出<BurningKeywords:燃烧>卡牌时，使自身获得 1 层<MonsterExFlameKeywords:爆炎>，但临时降低 [DescArg1] <PowerIconKeywords:力量>。"
  },
  State_98147_Name = {
    Text = "不熄之焰"
  },
  State_98148_Desc = {
    Text = "这位唤醒体还未觉醒…即将被击倒时会觉醒，弃置所有剩余手牌并赋予<BurningKeywords:燃烧>，回复生命并以真正的形态开始战斗。"
  },
  State_98148_Name = {
    Text = "尚未觉醒"
  },
  State_98302_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，力量获取效果提高 <WeaponEffect_Num:[StateArg2]%>。打出装备者指令卡后获得装备者攻击力 <WeaponEffect_Num:[StateArg3]%> 的临时力量，每回合最多触发 5 次。"
  },
  State_98302_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>，造成的力量提高 <WeaponEffect_Num:[StateArg2]%>。打出装备者的指令卡后获得 <WeaponEffect_Num:[Power:DescArg1]> 点临时力量，每回合最多触发 5 次(当前已触发 [DescArg2]/5 次)。"
  },
  State_98323_Desc = {
    Text = "卡牌被弃置后会重新回到手中。"
  },
  State_98323_Name = {
    Text = "弃置后回到手中"
  },
  State_98341_Desc = {
    Text = "可与其他原色进行调和，变成新的颜色。"
  },
  State_98341_Name = {
    Text = "<Yellow:原色·黄>"
  },
  State_98344_Desc = {
    Text = "可与其他原色进行调和，变成新的颜色。"
  },
  State_98344_Name = {
    Text = "<Red:原色·红>"
  },
  State_98345_Desc = {
    Text = "可与其他原色进行调和，变成新的颜色。"
  },
  State_98345_Name = {
    Text = "<Blue:原色·蓝>"
  },
  State_98366_Desc = {
    Text = "回合开始时，若银钥能量大于 [Arg1] ，则消耗 [Arg1] 点银钥能量将 1 张<DerivativeCardKeywords_115:「高级灵感」>置入手中。"
  },
  State_98435_Desc = {
    Text = "由红色与蓝色调和而来，每造成 1 次主动伤害，获得 <Block: [DescArg1]> 点护盾。"
  },
  State_98435_Name = {
    Text = "<PurpleKeyWord:异象·紫>"
  },
  State_98436_Desc = {
    Text = "由红色与黄色调和而来，释放狂气爆发后，对应唤醒体获得 <Energy:15> 点狂气。"
  },
  State_98436_Name = {
    Text = "<ExclamationPointColour:异象·橙>"
  },
  State_98437_Desc = {
    Text = "造成的最终伤害提高 10%。"
  },
  State_98437_Name = {
    Text = "<Red:原色·红>"
  },
  State_98438_Desc = {
    Text = "由黄色与蓝色调和而来，打出「防御」后，回复 <Heal:[DescArg1]> 点生命。"
  },
  State_98438_Name = {
    Text = "<GreenWord:异象·绿>"
  },
  State_98439_Desc = {
    Text = "由黄色与蓝色调和而来，打出「防御」后，回复 <Heal:[DescArg1]> 点生命。"
  },
  State_98439_Name = {
    Text = "<GreenWord:异象·绿>"
  },
  State_98440_Desc = {
    Text = "由红色与蓝色调和而来，每造成 1 次主动伤害，获得 <Block: [DescArg1]> 点护盾。"
  },
  State_98440_Name = {
    Text = "<PurpleKeyWord:异象·紫>"
  },
  State_98441_Desc = {
    Text = "由红色与黄色调和而来，释放狂气爆发后，对应唤醒体获得 <Energy:15> 点狂气。"
  },
  State_98441_Name = {
    Text = "<ExclamationPointColour:异象·橙>"
  },
  State_98444_Desc = {
    Text = "队伍唯一：装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。打出 5 张装备者的指令卡后，装备者获得 <WeaponEffect_Num:[StateArg2]%> 临时暴击率。该效果每回合只能触发 1 次。"
  },
  State_98444_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 <WeaponEffect_Num:[StateArg1]%>。打出 5 张装备者的指令卡后，装备者获得 <WeaponEffect_Num:[StateArg2]%> 临时暴击率，该效果每回合只能触发 1 次(当前已打出 [DescArg1]/5 张)。"
  },
  State_98466_Name = {
    Text = "<HuoyanKeywords1:活焰1>"
  },
  State_98468_Name = {
    Text = "<HuoyanKeywords3:活焰3>"
  },
  State_98470_Name = {
    Text = "<HuoyanKeywords2:活焰2>"
  },
  State_98474_Desc = {
    Text = "能混合调配出其他颜色的基本色，由红色、黄色、蓝色组成。"
  },
  State_98474_Name = {Text = "原色"},
  State_98484_Name = {
    Text = "沉逝苦海"
  },
  State_98485_Desc = {
    Text = "此卡牌造成的护盾、狂气提高 [DescArg2]％，最终伤害、力量提高 [DescArg1]％，获得「保留」，打出后消耗所有「活焰」并将 1 层「活焰」传导到手中其它 1 张凯蒂古拉的指令卡上。"
  },
  State_98485_Name = {
    Text = "<HuoyanKeywords2:活焰2>"
  },
  State_98486_Desc = {
    Text = "此卡牌造成的护盾、狂气提高 [DescArg2]％，最终伤害、力量提高 [DescArg1]％，获得「保留」，打出后消耗所有「活焰」并将 1 层「活焰」传导到手中其它 1 张凯蒂古拉的指令卡上。"
  },
  State_98486_Name = {
    Text = "<HuoyanKeywords3:活焰3>"
  },
  State_98487_Desc = {
    Text = "此卡牌造成的护盾、狂气提高 [DescArg2]％，最终伤害、力量提高 [DescArg1]％，获得「保留」，打出后消耗所有「活焰」并将 1 层「活焰」传导到手中其它 1 张凯蒂古拉的指令卡上。"
  },
  State_98487_Name = {
    Text = "<HuoyanKeywords1:活焰1>"
  },
  State_98488_Desc = {
    Text = "每层「活焰」使卡牌造成的最终伤害、护盾、狂气、力量提高 30%，至多叠加 3 层。拥有「活焰」的卡牌获得「保留」，打出后消耗所有「活焰」并将 1 层「活焰」传导到手中其它 1 张凯蒂古拉的指令卡上。"
  },
  State_98488_Name = {
    Text = "<HuoyanKeywords:活焰>"
  },
  State_98492_Desc = {
    Text = "探索开始后，体质、攻击、防御提升 [StateArg1] %"
  },
  State_98492_Name = {
    Text = "灵塑适性"
  },
  State_98495_Desc = {
    Text = "探索开始后，体质、攻击、防御提升 [StateArg1] %"
  },
  State_98495_Name = {
    Text = "灵塑适性"
  },
  State_98507_Desc = {
    Text = "探索开始后，体质、攻击、防御提升 [StateArg1] %"
  },
  State_98507_Name = {
    Text = "灵塑适性"
  },
  State_98511_Name = {
    Text = "获取衍生卡"
  },
  State_98551_Desc = {
    Text = "战斗开始时界域精通 +[Arg1]。奇数回合开始时抽 1 张牌，偶数回合开始时获得 1 点算力。"
  },
  State_98553_Desc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  State_98555_Desc = {
    Text = "战斗开始时获得 [Arg1]% 强效。每回合首次施加中毒后，抽 [Arg2] 张牌。"
  },
  State_98556_Desc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  State_98557_Desc = {
    Text = "每当生成 1 个「胚胎」，获得 [Arg1] 点猩红熔炉，每回合最多触发 3 次。"
  },
  State_98559_Desc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时力量 ，最多获得 [Arg2] 临时力量。"
  },
  State_98560_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  State_98561_Desc = {
    Text = "回合开始时，若生命低于 50% 临时伤害强效 +[Arg1]%。若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  State_98562_Desc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  State_98563_Desc = {
    Text = "战斗开始时获得 [Arg1] 力量。每打出一张 「消耗」 的牌就获得 [Arg2] 临时力量，最多触发 [Arg3] 次。"
  },
  State_98564_Desc = {
    Text = "「狂气爆发」获得 [Arg1] 银钥能量，每回合最多触发 3 次。"
  },
  State_98565_Desc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  State_98567_Desc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  State_98568_Desc = {
    Text = "战斗开始时获得伤害强效 +[Arg1]%。造成主动伤害后对所有敌人造成 [Arg2] 中毒，每回合最多额外触发 5 次。"
  },
  State_98569_Desc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层中毒，并获得 [Arg2] 层反击。"
  },
  State_98571_Desc = {
    Text = "使用银钥觉醒后回复 [Arg1] 生命，获得 [Arg2] 点银钥能量。"
  },
  State_98571_Name = {
    Text = "旅行阳伞"
  },
  State_98572_Desc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  State_98575_Desc = {
    Text = "战斗开始时获得伤害强效 +[Arg1]%。造成主动伤害后对所有敌人造成 [Arg2] 中毒，每回合最多额外触发 5 次。"
  },
  State_98576_Desc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层虚弱和易伤。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  State_98577_Desc = {
    Text = "所有唤醒体造成的基础伤害提高 [Arg1]%。释放狂气爆发前，使释放狂气爆发的唤醒体造成的基础伤害临时提高 [Arg2]%。"
  },
  State_98579_Desc = {
    Text = "回合开始时，若生命低于 50% 临时伤害强效 +[Arg1]%。若生命低于 25%，额外抽 [Arg2] 张牌并获得 [Arg2] 算力。"
  },
  State_98581_Desc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  State_98582_Desc = {
    Text = "每释放 5 次「狂气爆发」后，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  State_98583_Desc = {
    Text = "所有唤醒体每回合首次「指令卡」获得 [Arg1] 点银钥能量。"
  },
  State_98586_Desc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  State_98587_Desc = {
    Text = "每抽一张牌或弃一张牌获得 [Arg1] 临时力量 ，最多获得 [Arg2] 临时力量。"
  },
  State_98588_Desc = {
    Text = "回合结束前，手中每张指令卡的所属唤醒体获得 [Arg1] 狂气。"
  },
  State_98589_Desc = {
    Text = "战斗开始时使所有敌人临时失去 [Arg1] 力量。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  State_98590_Desc = {
    Text = "战斗开始时获得 [Arg1]% 强效。每回合首次施加中毒后，抽 [Arg2] 张牌。"
  },
  State_98591_Desc = {
    Text = "每回合首次「钥令」后对所有敌人施加 [Arg1] 层中毒，并获得 [Arg2] 层反击。"
  },
  State_98596_Desc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  State_98597_Desc = {
    Text = "使用银钥觉醒后回复 [Arg1] 生命，获得 [Arg2] 点银钥能量。"
  },
  State_98597_Name = {
    Text = "旅行阳伞+"
  },
  State_98598_Desc = {
    Text = "战斗开始时获得 [Arg1] 力量。每打出一张 「消耗」 的牌就获得 [Arg2] 临时力量，最多触发 [Arg3] 次。"
  },
  State_98600_Desc = {
    Text = "战斗开始时使所有敌人临时失去 [Arg1] 力量。使用「猩红熔炉」也会触发这个效果，但具有 3 回合冷却。"
  },
  State_98602_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次获得反击后，获得 1/2 算力。"
  },
  State_98603_Desc = {
    Text = "战斗开始时获得伤害强效 +[Arg1]%。受到主动或触腕伤害后获得 [Arg2] 反击，每回合最多触发 3 次。"
  },
  State_98604_Desc = {
    Text = "战斗开始时获得伤害强效 +[Arg1]%。受到主动或触腕伤害后获得 [Arg2] 反击，每回合最多触发 3 次。"
  },
  State_98606_Desc = {
    Text = "每当一张卡进入超维空间时，从抽牌堆抽 [Arg1] 张此卡归属者的指令卡，若无法抽取改为获得等量算力。每回合最多生效 2 次。"
  },
  State_98607_Desc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  State_98608_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 15/30% 临时伤害强效。"
  },
  State_98610_Desc = {
    Text = "使用银钥觉醒后使手中算力最高的 2/4 张卡牌在下次打出前获得保留和预备，获得 100/200 点银钥能量。"
  },
  State_98611_Desc = {
    Text = "战斗开始时界域精通 +[Arg1]。奇数回合开始时抽 1 张牌，偶数回合开始时获得 1 点算力。"
  },
  State_98612_Desc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg1]%，生命越低则效果越强。"
  },
  State_98613_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效，每打出一张不同唤醒体的指令卡额外获得 15/30% 临时伤害强效。"
  },
  State_98614_Desc = {
    Text = "每释放 5 次「狂气爆发」后，下 [Arg1] 张非衍生指令卡额外生效 1 次。"
  },
  State_98615_Desc = {
    Text = "每回合首次「钥令」返还消耗 [Arg1]% 消耗的银钥能量。"
  },
  State_98616_Desc = {
    Text = "所有唤醒体造成生命回复和护盾的基础效果提高 [Arg1]%。"
  },
  State_98617_Desc = {
    Text = "造成主动或触腕伤害后，使目标当回合受到的触腕伤害提高 [Arg1]%，每回合最多触发 20 次。"
  },
  State_98619_Desc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张「银钥微光」置入手牌。"
  },
  State_98621_Desc = {
    Text = "回合结束时若银钥能量已满，消耗 [Arg1] 点银钥能量将一张「银钥曦光」置入手牌。"
  },
  State_98623_Desc = {
    Text = "回合开始时，所有狂气不足以释放狂气爆发的唤醒体获得 [Arg1] 点狂气。"
  },
  State_98624_Desc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  State_98625_Desc = {
    Text = "战斗开始对所有敌人造成 [Arg1] 层虚弱和易伤。「湮灭」后也会触发这个效果，但具有 3 回合冷却。"
  },
  State_98626_Desc = {
    Text = "每回合首次「钥令」使临时伤害强效 +[Arg1]%，生命越低则效果越强。"
  },
  State_98627_Desc = {
    Text = "「狂气爆发」获得 [Arg1] 银钥能量，每回合最多触发 3 次。"
  },
  State_98628_Desc = {
    Text = "每回合首次「钥令」激发所有触腕攻击 [Arg1] 次敌方，造成 50% 伤害。"
  },
  State_98629_Desc = {
    Text = "每回合释放第二次「钥令」后获得 [Arg1] 点银钥能量，所有唤醒体获得 [Arg2] 点狂气。"
  },
  State_98630_Desc = {
    Text = "战斗开始时和触发死亡抵抗后，获得 [Arg1] 点银钥能量。"
  },
  State_98632_Desc = {
    Text = "战斗开始时获得 [Arg1]% 伤害强效。每回合首次获得反击后，获得 1/2 算力。"
  },
  State_98686_Desc = {
    Text = "下 [Layer] 张非衍生指令卡额外生效 1 次。"
  },
  State_98686_Name = {
    Text = "非衍生指令卡双发"
  },
  State_98739_Desc = {
    Text = "当意图转换为苍白回旋时，根据状态层数增加等量伤害次数，并在回合结束后清空状态。达到 3 层后，立刻将意图转换为苍白回旋。"
  },
  State_98739_Name = {
    Text = "蜘蛛女之吻"
  },
  State_98742_Desc = {
    Text = "施加的中毒提高100%，每个回合结束后获得 <Block:[Block:DescArg1]> 护盾。"
  },
  State_98742_Name = {
    Text = "迷途之旅"
  },
  State_98743_Desc = {
    Text = "在回合内受到 [DescArg1] 点伤害后，获得 75 层临时加固，将意图转换为「不耐的施舍」并会解除石化效果，获得 1 层「蜘蛛女之吻」。"
  },
  State_98743_Name = {Text = "僭越者"},
  State_98752_Desc = {
    Text = "使卡牌燃烧，打出后受到最大生命 5% 的伤害，若回合结束仍在手中将其消耗。"
  },
  State_98752_Name = {
    Text = "<BurningKeywords2:燃烧>"
  },
  State_98752_WeaponDesc = {
    Text = "每层迟缓使卡牌的算力消耗增加 1 点。"
  },
  State_98887_Name = {
    Text = "救世圣灯"
  },
  State_98889_Desc = {
    Text = "每回合首次打出带有<DepleteIconKeywords:消耗>的指令卡时将其置入弃牌堆。"
  },
  State_98889_Name = {
    Text = "救世圣灯"
  },
  State_98912_Desc = {
    Text = "每层使所有唤醒体造成的护盾和生命回复降低 10%。"
  },
  State_98912_Name = {
    Text = "<LostWay:迷失>"
  },
  State_98913_Desc = {
    Text = "每层使所有唤醒体造成的护盾和生命回复降低 10%。"
  },
  State_98913_Name = {Text = "迷失"},
  State_99007_Desc = {
    Text = "打出后不会进入弃牌堆，而是从牌库中移除。"
  },
  State_99007_Name = {
    Text = "<DepleteIconKeywords:消耗>"
  },
  State_99007_WeaponDesc = {
    Text = "打出后卡牌不会进入弃牌堆，在本场战斗中无法再次使用。"
  },
  State_99053_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：其他友方每回合首次「狂气爆发」后抽 [StateArg1] 张牌。"
  },
  State_99053_Name = {
    Text = "渴求的画笔"
  },
  State_99055_Desc = {
    Text = "<PVPWeaponKeywords:命轮>：「狂气爆发」后随机将 [StateArg1] 张装备者的「技能」置入手牌并使其算力消耗变为 0。"
  },
  State_99055_Name = {
    Text = "写实主义悖谬"
  },
  State_99056_Desc = {
    Text = "队伍唯一：释放钥令后，装备者的暴击率临时提高 <WeaponEffect_Num:[StateArg1]%> 。"
  },
  State_99056_WeaponDesc = {
    Text = "释放钥令后，装备者的暴击率临时提高 <WeaponEffect_Num:[StateArg1]%> 。"
  },
  State_99134_Desc = {
    Text = "「绘者」用于作画的染料，能加强技能效果，上限 10 层。"
  },
  State_99134_Name = {
    Text = "幻世染料"
  },
  State_99237_Name = {
    Text = "状态饰品飞升"
  },
  State_99237_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 10%。若装备者伤害强效大于 20%，基础伤害额外提高 10%。"
  },
  State_99238_Name = {
    Text = "状态饰品腐殖质"
  },
  State_99238_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 10%。若装备者伤害强效大于 20%，基础伤害额外提高 10%。"
  },
  State_99239_Name = {
    Text = "状态饰品斯提克斯"
  },
  State_99239_WeaponDesc = {
    Text = "装备者造成的基础伤害提高 10%。若装备者伤害强效大于 20%，基础伤害额外提高 10%。"
  },
  State_99258_Desc = {
    Text = "队伍唯一：每回合释放第 2 次钥令后，有 <WeaponEffect_Num:[StateArg1]%> 的几率抽 1 张装备者的指令卡。每回合打出第 3 张装备者的指令卡后，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。"
  },
  State_99258_WeaponDesc = {
    Text = "每回合释放第 2 次钥令后，有 <WeaponEffect_Num:[StateArg1]%> 的几率抽 1 张装备者的指令卡。每回合打出第 3 张装备者的指令卡后，获得 <WeaponEffect_Num:[StateArg2]> 点银钥能量。"
  },
  State_99294_Desc = {
    Text = "所有唤醒体造成的狂气提高 [DescArg1]%，回合结束时的算力和指令卡可保留至下回合。纷华篇章的狂气提高。"
  },
  State_99294_Name = {Text = "「喜」"},
  State_99295_Desc = {
    Text = "所有唤醒体造成的狂气提高 [StateArg1]%，回合结束时的算力和指令卡可保留至下回合。纷华篇章的狂气提高。"
  },
  State_99295_Name = {Text = "「喜」"},
  State_99336_Desc = {
    Text = "「绘者」用于作画的染料，能加强技能效果，上限 10 层。"
  },
  State_99336_Name = {
    Text = "<DecayDye:幻世染料>"
  },
  State_99533_Name = {
    Text = "饰品少女之蛹"
  },
  State_99533_WeaponDesc = {
    Text = "战斗开始后，若装备者职业为混沌，攻击力提高 25%。"
  },
  State_99534_Name = {
    Text = "甜蜜蛞蝓"
  },
  State_99534_WeaponDesc = {
    Text = "装备者造成的护盾与生命回复提高 6%。若装备者界域精通大于 50，护盾与生命回复额外提高 6%。"
  },
  State_99640_Desc = {
    Text = "若当前拥有 10 层创意，皮克曼释放狂气爆发后消耗所有创意，使所有唤醒体获得 15 点狂气并获得 1 层「狂想」。创意上限为 10层，能够继承至下场战斗。"
  },
  State_99640_Name = {Text = "创意"},
  State_99723_Desc = {
    Text = "队伍唯一：装备者造成的狂气和力量获取效果提高 <WeaponEffect_Num:[StateArg1]%>。释放狂气爆发后本回合下次其他唤醒体狂气爆发最终伤害、护盾、生命回复提高 <WeaponEffect_Num:[StateArg2]%>，若本次狂气爆发触发了「吞噬」，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  },
  State_99723_WeaponDesc = {
    Text = "装备者造成的狂气和力量提高 <WeaponEffect_Num:[StateArg1]%>。释放狂气爆发后本回合下次其他唤醒体狂气爆发最终伤害、护盾、生命回复提高 <WeaponEffect_Num:[StateArg2]%>，若本次狂气爆发触发了「吞噬」，装备者获得 <WeaponEffect_Num:[StateArg3]> 点狂气。"
  }
})
return Text_State
