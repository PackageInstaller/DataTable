__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Tutorial = readonly({
  Tutorial_120371_Desc_1 = {
    Text = "可在战斗中返回经历过的回合，可返回至战斗的前 25 回合中的任意一个回合。"
  },
  Tutorial_120371_Title_1 = {
    Text = "时序逆行"
  },
  Tutorial_124999_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈-轮选模式>中，点击界面右下角的「开始匹配」进入匹配，无需预组队伍。"
  },
  Tutorial_124999_Desc_2 = {
    Text = "对战前系统会随机选取一个<TutorialHighlight:造物>，在对战中生效。根据每局的造物效果，在随机出的有限选项的卡池中轮流选取所需的唤醒体、命轮、钥令，来构建自己的编队与对方进行对战。"
  },
  Tutorial_124999_Desc_3 = {
    Text = "通过点击两个唤醒体进行位置互换，以此来调整自己队伍在对战中的站位。站位前后按1-4的顺序进行排列。"
  },
  Tutorial_124999_Title_1 = {
    Text = "轮选编队"
  },
  Tutorial_126878_Desc_1 = {
    Text = "部分唤醒体的人格深化达到 +12 时自动获得「最终法则」效果，每个唤醒体所获得的效果都有所不同。"
  },
  Tutorial_126878_Desc_2 = {
    Text = "唤醒体的「最终法则」解锁后，会收到一条相应唤醒体专属的通讯器讯息，请守密人记得查收。"
  },
  Tutorial_126878_Title_1 = {
    Text = "最终法则"
  },
  Tutorial_126878_Title_2 = {
    Text = "专属讯息"
  },
  Tutorial_148475_Desc_1 = {
    Text = "唤醒体同调率达到 <TutorialHighlight:Lv20> 后，可获得专属 <TutorialHighlight:曜闪>。"
  },
  Tutorial_148475_Desc_2 = {
    Text = " <TutorialHighlight:曜闪>是你与唤醒体彼此为我的证明。"
  },
  Tutorial_148475_Desc_3 = {
    Text = "现在，该唤醒体的指令卡在战斗中将会特别呈现，并可在社交场合向其他守密人展示。"
  },
  Tutorial_148475_Title_1 = {
    Text = "彼此为我"
  },
  Tutorial_17805_Desc_1 = {
    Text = "点击敌人可以查看它的所有状态。<TutorialHighlight:警示>状态需要更加重点关注，它代表敌人的特殊机制，守密人未能顺利完成调查的多数原因往往是未关注到敌人的特殊机制。"
  },
  Tutorial_17805_Title_1 = {
    Text = "敌人状态"
  },
  Tutorial_17806_Desc_1 = {
    Text = "战胜敌人后可以选择<TutorialHighlight:刻印>，也可以在<TutorialHighlight:融痕>中花费<TutorialHighlight:黑印>进行购买。<TutorialHighlight:刻印>可以让指定卡获得不同的额外效果。每张指定卡最多只能刻印 <TutorialHighlight:1> 次。优先为更经常打出的指令卡进行刻印，可以提升刻印带来的收益。"
  },
  Tutorial_17806_Title_1 = {Text = "刻印"},
  Tutorial_17807_Desc_1 = {
    Text = "为唤醒体提供多种属性，若组成<TutorialHighlight:套装>还会有特殊效果。共有6个部位，不同部位的<TutorialHighlight:主属性>不同，暴击率和暴击伤害会出现在I、II、III部位；狂气回充等级和银钥充能等级会出现在I、IV、V部位；界域精通和黑印掉落会出现在II、IV、VI部位；伤害强效和死亡抵抗会出现在III、V、VI部位。可以通过密契完成度来较为直观的感受密契与密契套装的强度。密契完成度可以通过升级与转录的方式进行强化。"
  },
  Tutorial_17807_Title_1 = {Text = "密契"},
  Tutorial_17808_Desc_1 = {
    Text = "<TutorialHighlight:幻梦深潜>玩法中，每次挑战关卡会随机进入一张地图。挑战成功后，根据挑战的关卡难度、强化唤醒体与关卡内评分项获得相应积分。 每周挑战会有不同的初始造物与强化唤醒体。"
  },
  Tutorial_17808_Desc_2 = {
    Text = "幻梦深潜通常每 28 天会更新赛季，在赛季内通关一次幻梦深潜即可参与<TutorialHighlight:赛季排行>，赛季结束时将会结算排名，并通过邮箱发送排名奖励。"
  },
  Tutorial_17808_Desc_3 = {
    Text = "「深潜纪录」设立有多个目标，达成后可获得相应奖励。每次完成「深潜纪录」目标或深潜挑战胜利后都可获得<TutorialHighlight:深潜经验>。深潜经验达到一定值时<TutorialHighlight:深潜等级>会提升，可以获得丰富的奖励。可以通过界面左下角的「深潜纪录」与「深潜等级」进行查看。"
  },
  Tutorial_17808_Title_1 = {
    Text = "幻梦深潜"
  },
  Tutorial_17809_Desc_1 = {
    Text = "通过事件、融痕可以获得<TutorialHighlight:造物>，<TutorialHighlight:造物>可以强化我方队伍的作战能力。优秀守密人往往可以根据队伍的需要，选择更契合的<TutorialHighlight:造物>。"
  },
  Tutorial_17809_Title_1 = {Text = "造物"},
  Tutorial_17810_Desc_1 = {
    Text = "驱散迷雾，地图视野提升 <TutorialHighlight:2> 格，可以利用它做出更好的路线规划。"
  },
  Tutorial_17810_Title_1 = {Text = "探照灯"},
  Tutorial_17811_Desc_1 = {
    Text = "处于<TutorialHighlight:中毒>状态的目标在回合结束时，受到等同于<TutorialHighlight:中毒>层数的伤害。<TutorialHighlight:中毒>伤害<TutorialHighlight:无法暴击>。"
  },
  Tutorial_17811_Title_1 = {Text = "中毒"},
  Tutorial_17812_Desc_1 = {
    Text = "处于<TutorialHighlight:易伤>状态的目标，受到的伤害提升 50% ，回合结束时自动移除 1 层<TutorialHighlight:易伤>。利用敌人处于<TutorialHighlight:易伤>状态的时机，对其造成更多伤害。"
  },
  Tutorial_17812_Title_1 = {Text = "易伤"},
  Tutorial_17813_Desc_1 = {
    Text = "「融蚀之墟」、「禁忌纂录」、「超验存在」中关卡通关后，该关卡与更低难度的关卡可以进行<TutorialHighlight:重现>。通过<TutorialHighlight:重现>可以快速获得关卡奖励。"
  },
  Tutorial_17813_Title_1 = {Text = "重现"},
  Tutorial_17814_Desc_1 = {
    Text = "<TutorialHighlight:护盾>可以代替生命承担伤害，回合结束时<TutorialHighlight:自动移除>所有护盾，护盾的上限等于队伍的<TutorialHighlight:生命上限>。尽可能地<TutorialHighlight:让护盾等同于本回合所有敌人的伤害总量>，用最小的代价获得战斗胜利。"
  },
  Tutorial_17814_Title_1 = {Text = "护盾"},
  Tutorial_17815_Desc_1 = {
    Text = "重复获得唤醒体会将其转化为<TutorialHighlight:残片>。消耗<TutorialHighlight:残片>提升唤醒体启灵等级，可以使唤醒体的技能获得额外的特殊能力。唤醒体启灵等级已满时再获得对应残片，将转化为<TutorialHighlight:灵魂回溯碎片>。"
  },
  Tutorial_17815_Title_1 = {Text = "残片"},
  Tutorial_17816_Desc_1 = {
    Text = "算力为<TutorialHighlight:全队共享>，打出卡牌需要消耗<TutorialHighlight:算力>。算力会在回合开始时<TutorialHighlight:自动恢复至上限>，在回合结束后<TutorialHighlight:自动清空>。为了提升算力利用效率，请尽量<TutorialHighlight:消耗所有算力后再结束回合>。"
  },
  Tutorial_17816_Title_1 = {Text = "算力"},
  Tutorial_17817_Desc_1 = {
    Text = "战胜<TutorialHighlight:超验存在>中的敌人，可以获得高阶的<TutorialHighlight:技能升级素材>，每周可以获取1次奖励。各种材料还可以在<TutorialHighlight:冶炼室>进行合成和置换。"
  },
  Tutorial_17817_Title_1 = {
    Text = "超验存在"
  },
  Tutorial_17818_Desc_1 = {
    Text = "获得后可在<TutorialHighlight:物资中使用>，能按照预设值快速提升唤醒体等级和技能等级。"
  },
  Tutorial_17818_Title_1 = {
    Text = "灵知增幅器"
  },
  Tutorial_17819_Desc_1 = {
    Text = "当唤醒体狂气达到 <TutorialHighlight:100> 时可以释放<TutorialHighlight:狂气爆发>。不同唤醒体的狂气爆发效果不同，合理利用可以<TutorialHighlight:事半功倍>。"
  },
  Tutorial_17819_Title_1 = {
    Text = "狂气爆发"
  },
  Tutorial_17820_Desc_1 = {
    Text = "处于<TutorialHighlight:脆弱>状态的目标，获得的护盾降低 25% ，回合结束时自动移除 1 层<TutorialHighlight:脆弱>。若我方队伍处于<TutorialHighlight:脆弱>状态，记得在防守前想办法移除<TutorialHighlight:脆弱>状态，或者改变策略，在本回合中全力进攻。"
  },
  Tutorial_17820_Title_1 = {Text = "脆弱"},
  Tutorial_17821_Desc_1 = {
    Text = "为唤醒体装备<TutorialHighlight:命轮>，可以提升唤醒体的属性，还可以获得特殊能力。"
  },
  Tutorial_17821_Title_1 = {Text = "命轮"},
  Tutorial_17822_Desc_1 = {
    Text = "处于<TutorialHighlight:出血>状态的目标在回合结束时，受到等同于<TutorialHighlight:出血>层数的伤害然后<TutorialHighlight:移除出血状态>。\n<TutorialHighlight:回复生命>时移除等同于<TutorialHighlight:回复量 2 倍>的出血层数。出血伤害<TutorialHighlight:无法暴击>。"
  },
  Tutorial_17822_Title_1 = {Text = "出血"},
  Tutorial_17823_Desc_1 = {
    Text = "混沌唤醒体可以<TutorialHighlight:突破界域限制>与其他界域的唤醒体编队，并且会有不同的共生效果。任意队伍中如果存在混沌唤醒体，可以额外获得 100% 死亡抵抗。"
  },
  Tutorial_17823_Desc_2 = {
    Text = "相较于其他界域的队伍，混沌界域队伍获得银钥能量的速度更快，且释放第二次钥令时，能够在所有钥令中进行选择，并且选择的钥令会触发 2 次。因此混沌界域队伍更依赖与钥令间的协作，选择合适的钥令可以极大增强混沌界域队伍的实力！"
  },
  Tutorial_17823_Title_1 = {Text = "混沌"},
  Tutorial_17824_Desc_1 = {
    Text = "每拥有 1 点<TutorialHighlight:戒备>，每次获得护盾时将额外获得 1 点护盾。"
  },
  Tutorial_17824_Title_1 = {Text = "戒备"},
  Tutorial_17825_Desc_1 = {
    Text = "首次完成调查行动后可以获得<TutorialHighlight:共鸣激活材料>，它们可用于激活强大的<TutorialHighlight:共鸣>，共鸣会在这一章的所有关卡中生效。"
  },
  Tutorial_17825_Title_1 = {Text = "共鸣"},
  Tutorial_17826_Desc_1 = {
    Text = "我方队伍处于<TutorialHighlight:狂气封印>状态时，无法释放狂气爆发。在敌人即将造成<TutorialHighlight:狂气封印>前，可以释放狂气爆发避免浪费狂气。"
  },
  Tutorial_17826_Title_1 = {
    Text = "狂气封印"
  },
  Tutorial_17827_Desc_1 = {
    Text = "消耗<TutorialHighlight:灵知制剂>可以提升唤醒体等级，唤醒体升级后属性将会提升。达到等级上限之后需要先进行升格，升格后会提高唤醒体等级上限。"
  },
  Tutorial_17827_Title_1 = {
    Text = "灵知制剂"
  },
  Tutorial_17828_Desc_1 = {
    Text = "<TutorialHighlight:力量>每降低 1 点，每次造成<TutorialHighlight:主动伤害>时将降低 1 点伤害。"
  },
  Tutorial_17828_Title_1 = {
    Text = "力量降低"
  },
  Tutorial_17829_Desc_1 = {
    Text = "每次受到伤害前，免疫伤害并移除 1 层<TutorialHighlight:屏障>。单次伤害越高，<TutorialHighlight:屏障>带来的收益越高。"
  },
  Tutorial_17829_Title_1 = {Text = "屏障"},
  Tutorial_17830_Desc_1 = {
    Text = "处于<TutorialHighlight:虚弱>状态的目标，造成的伤害降低 25% ，回合结束时自动移除 1 层<TutorialHighlight:虚弱>。若我方队伍处于<TutorialHighlight:虚弱>状态，记得在进攻前想办法移除<TutorialHighlight:虚弱>状态，或者改变策略，在本回合中全力防守。"
  },
  Tutorial_17830_Title_1 = {Text = "虚弱"},
  Tutorial_17831_Desc_1 = {
    Text = "战胜<TutorialHighlight:禁忌纂录>中的敌人，可以获得提升唤醒体能力的<TutorialHighlight:密契>。每通关一章主线会解锁新的<TutorialHighlight:禁忌纂录>关卡。密契还可以通过商店进行兑换。"
  },
  Tutorial_17831_Title_1 = {
    Text = "禁忌纂录"
  },
  Tutorial_17832_Desc_1 = {
    Text = "超维队伍每回合打出的<TutorialHighlight:第 1 张>指令卡的临时复制会进入<TutorialHighlight:超维空间>并触发强大的跃迁效果。当超维空间达到上限时，获得 1 个额外的<TutorialHighlight:超维回合>，<TutorialHighlight:超维回合能触发所有跃迁效果>。玩好超维队伍的基础秘诀：仔细规划每回合打出的第 1 张牌。"
  },
  Tutorial_17832_Title_1 = {Text = "超维"},
  Tutorial_17833_Desc_1 = {
    Text = "当我方队伍生命值耗尽时，可以启用<TutorialHighlight:应急灵知体>恢复所有状态。应急灵知体每天自动恢复 <TutorialHighlight:1 >个，上限 <TutorialHighlight:5 >个。合理地将应急灵知体应用在<TutorialHighlight:高难战斗>中，切勿随意浪费。"
  },
  Tutorial_17833_Title_1 = {
    Text = "应急灵知体"
  },
  Tutorial_17834_Desc_1 = {
    Text = "仔细搜寻地图上微微发光的地点，前往调查说不定会有意外收获。"
  },
  Tutorial_17834_Title_1 = {Text = "析出点"},
  Tutorial_17835_Desc_1 = {
    Text = "代表所有敌人本回合的伤害总量。一条简单实用的守密人作战经验：<TutorialHighlight:尽可能让护盾等同于敌方伤害总量>。"
  },
  Tutorial_17835_Title_1 = {
    Text = "敌方伤害总量"
  },
  Tutorial_17837_Desc_1 = {
    Text = "血肉队伍的<TutorialHighlight:胚胎融合>达到上限时将会获得  1 张<TutorialHighlight:「胚胎」>，释放狂气爆发会消耗<TutorialHighlight:「胚胎」>触发强大<TutorialHighlight:吞噬>效果，因此尽可能地在手牌中有<TutorialHighlight:「胚胎」>时释放狂气爆发，否则无法发挥血肉队伍的最大实力。"
  },
  Tutorial_17837_Desc_2 = {
    Text = "每场战斗结束后会积攒5%最大生命的回复量进入猩红熔炉，若有未使用的<TutorialHighlight:「胚胎」>，每个胚胎也会积攒5%最大生命的回复量进入熔炉。 猩红熔炉可用于回复我方队伍的生命，每回合可以转化熔炉为生命1次。守密人需合理规划猩红熔炉的使用时机，从而达到扭转战局的效果。"
  },
  Tutorial_17837_Title_1 = {Text = "血肉"},
  Tutorial_17838_Desc_1 = {
    Text = "在联络点中，你可以选择恢复我方队伍已损失生命的50%，或指定觉醒 1 名唤醒体。当我方队伍生命较低时，推荐选择回复生命，否则推荐选择觉醒唤醒体。"
  },
  Tutorial_17838_Title_1 = {Text = "联络处"},
  Tutorial_17839_Desc_1 = {
    Text = "用于消耗黑印强化我方队伍的场所，一般会提供1栏刻印，1栏白银造物，1栏黄金造物。如果这里没有需要的物品，可以点击右上角的<TutorialHighlight:刷新>，融痕会提供新的物品。"
  },
  Tutorial_17839_Title_1 = {Text = "融痕"},
  Tutorial_17840_Desc_1 = {
    Text = "强行通过<TutorialHighlight:幻象>将会感染「症状」。"
  },
  Tutorial_17840_Title_1 = {Text = "幻象"},
  Tutorial_17841_Desc_1 = {
    Text = "通过指令卡可以让唤醒体获得<TutorialHighlight:狂气>，指令卡的技能等级越高，获得的狂气越多。"
  },
  Tutorial_17841_Title_1 = {Text = "狂气"},
  Tutorial_17842_Desc_1 = {
    Text = "战胜敌人、调查事件可以获得<TutorialHighlight:黑印>，唤醒体的<TutorialHighlight:黑印掉落>属性可以提升获得的黑印数量。"
  },
  Tutorial_17842_Desc_2 = {
    Text = "在融痕中可以消耗<TutorialHighlight:黑印>购买刻印和造物，也可以用来觉醒唤醒体。在最终战前，请尽可能地花光所有的黑印强化我方队伍。"
  },
  Tutorial_17842_Title_1 = {Text = "黑印"},
  Tutorial_17843_Desc_1 = {
    Text = "受到攻击时，对攻击者造成等同于<TutorialHighlight:反击>层数的伤害。<TutorialHighlight:反击>伤害<TutorialHighlight:无法暴击>。"
  },
  Tutorial_17843_Title_1 = {Text = "反击"},
  Tutorial_17844_Desc_1 = {
    Text = "每拥有 1 点<TutorialHighlight:力量>，每次造成主动伤害时将额外提升 1 点伤害。"
  },
  Tutorial_17844_Title_1 = {Text = "力量"},
  Tutorial_17845_Desc_1 = {
    Text = "派遣唤醒体完成研究任务，完成后可以获得相应的奖励。派遣唤醒体<TutorialHighlight:总等级>越高，奖励越丰富，最高按240总等级计算。"
  },
  Tutorial_17845_Title_1 = {Text = "派遣"},
  Tutorial_17847_Desc_1 = {
    Text = "受到致命伤害时，有<TutorialHighlight:等同于死亡抵抗的概率>免疫此伤害并保留 1 点生命，<TutorialHighlight:成功触发后死亡抵抗减半>。队伍的死亡抵抗等同于所有唤醒体死亡抵抗之和，提升队伍死亡抵抗有助于提升战斗时的容错率。"
  },
  Tutorial_17847_Title_1 = {
    Text = "死亡抵抗"
  },
  Tutorial_17848_Desc_1 = {
    Text = "深海队伍战斗开始时生成 1 条<TutorialHighlight:触腕>，<TutorialHighlight:触腕>在回合结束时攻击前排敌人，可以通过触腕图标下方的算式了解当前的触腕伤害和攻击次数。部分唤醒体可以提升触腕数量和触腕伤害，在回合结束时造成大量的伤害。"
  },
  Tutorial_17848_Title_1 = {Text = "深海"},
  Tutorial_17850_Desc_1 = {
    Text = "打出手牌需消耗算力，回合结束时所有手牌将进入<TutorialHighlight:弃牌堆>。合理规划<TutorialHighlight:出牌顺序>将是战斗胜利的关键。"
  },
  Tutorial_17850_Title_1 = {Text = "手牌"},
  Tutorial_17851_Desc_1 = {
    Text = "代表敌人下回合即将要采取的行动，利用<TutorialHighlight:意图>进行本回合的决策是战斗的核心玩法。"
  },
  Tutorial_17851_Title_1 = {
    Text = "敌方意图"
  },
  Tutorial_17852_Desc_1 = {
    Text = "<TutorialHighlight:技能升级>可以提升唤醒体属性，强化指令卡的效果。在唤醒体技能界面点击下一级可以预览升级后的效果。"
  },
  Tutorial_17852_Desc_2 = {
    Text = "不同界域的唤醒体需要不同的<TutorialHighlight:技能升级素材>。"
  },
  Tutorial_17852_Title_1 = {
    Text = "技能强化"
  },
  Tutorial_20768_Desc_1 = {
    Text = "唤醒体打出指令卡或灵知觉醒消耗算力时可以获得<TutorialHighlight:银钥能量>。唤醒体的<TutorialHighlight:银钥充能>属性可以提升获得的<TutorialHighlight:银钥能量>。"
  },
  Tutorial_20768_Title_1 = {
    Text = "银钥能量"
  },
  Tutorial_20769_Desc_1 = {
    Text = "<TutorialHighlight:锈蚀门扉>会阻挡重要的调查路线，尝试在地图中搜寻一种称为<TutorialHighlight:锈蚀钥匙>的物件，它可以用于开启<TutorialHighlight:锈蚀门扉>。"
  },
  Tutorial_20769_Title_1 = {
    Text = "锈蚀门扉"
  },
  Tutorial_20770_Desc_1 = {
    Text = "<TutorialHighlight:锈蚀钥匙>可以开启阻挡你前进的<TutorialHighlight:锈蚀门扉>。"
  },
  Tutorial_20770_Title_1 = {
    Text = "锈蚀钥匙"
  },
  Tutorial_20771_Desc_1 = {
    Text = " <TutorialHighlight:无光之境>包含四个界域的系列关卡，通关后可以获得银芯、灵知制剂等奖励，累计星级达到指定要求后还可以额外获得银芯、无垢之芯等奖励！"
  },
  Tutorial_20771_Desc_2 = {
    Text = "不同界域的间隙关卡，会对调查队伍中的唤醒体界域做出要求， <TutorialHighlight:满足要求>的队伍才可以进行调查。"
  },
  Tutorial_20771_Title_1 = {
    Text = "无光之境"
  },
  Tutorial_20772_Desc_1 = {
    Text = "当银钥能量达到 <TutorialHighlight:1000> 时可以释放携带的<TutorialHighlight:钥令>。每回合可以释放 2 次钥令，但第二次释放钥令时会改为从 3 个随机钥令中选择 1 个释放，且选择的钥令在本次探索中无法再次被选择。在编队时为我方队伍选择合适的钥令，可以使调查过程更加顺利。"
  },
  Tutorial_20772_Title_1 = {Text = "钥令"},
  Tutorial_20773_Desc_1 = {
    Text = "消耗相同的<TutorialHighlight:命轮>进行叠位，或使用<TutorialHighlight:循环母版>对<TutorialHighlight:SSR命轮>进行叠位，可以提升<TutorialHighlight:命轮>的属性和特殊能力。叠位1次至3次时，命轮的效果会增强；叠位4次至15次时，命轮的属性会增强。可以在叠位界面点击「下一阶」按钮预览叠位后的变化。\n通过唤醒等途径获得已有命轮时，系统将会自动与已有命轮进行叠位，无需守密人单独操作。"
  },
  Tutorial_20773_Title_1 = {
    Text = "命轮叠位"
  },
  Tutorial_22247_Desc_1 = {
    Text = "<TutorialHighlight:密契升级>可以提升密契的属性强度，最高升至12级。密契分解可以获得对应的残本，在物资中进行材料置换可以获得<TutorialHighlight:千面印章>。密契升级需消耗<TutorialHighlight:千面印章>，分解已升级的密契也会返还升级消耗的<TutorialHighlight:千面印章>。"
  },
  Tutorial_22247_Title_1 = {
    Text = "密契升级"
  },
  Tutorial_22248_Desc_1 = {
    Text = "通过转录可以使<TutorialHighlight:密契>获得随机种类和强度的属性，副词条属性与部位无关，可能出现暴击率、暴击伤害、狂气回充等级、银钥充能等级、界域精通、黑印掉落、伤害强效、死亡抵抗这8种。在转录时，如果想要保留某项属性，可以选择<TutorialHighlight:锁定>，锁定的属性在转录时将不会发生变化。"
  },
  Tutorial_22248_Title_1 = {
    Text = "密契转录"
  },
  Tutorial_23466_Desc_1 = {
    Text = "随着守密人等级的提升，<TutorialHighlight:造物和刻印的强度>会跟随提升，唤醒体<TutorialHighlight:每点体质对队伍生命的影响>也会提升。通过调查行动、幕间演习可以获取大量的守密人经验。每消耗1点体力会获得1点守密人经验。"
  },
  Tutorial_23466_Title_1 = {
    Text = "守密人等级"
  },
  Tutorial_47538_Desc_1 = {
    Text = "融灾禁区是一个难度较高的玩法系统。守密人需要灵活搭配多个挑战队伍，尽可能地获取更多的特训值，从而获得更多的奖励。高警戒难度除了敌方单位变得更强，还会具有各种减益效果。"
  },
  Tutorial_47538_Desc_2 = {
    Text = "在融灾禁区中有其独特的限制法则：同一唤醒体和钥令、同名命轮无法重复上场，守密人可以根据初始造物、怪物和推荐等级，灵活选择本次挑战的队伍，采用田忌赛马的策略尽可能获得更多的特训值。通过<TutorialHighlight:助战>方式上阵的唤醒体不受该限制影响。"
  },
  Tutorial_47538_Title_1 = {
    Text = "融灾禁区"
  },
  Tutorial_54390_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，战斗界面内敌我双方唤醒体所拥有的<TutorialHighlight:状态>都会显示在其生命及狂气的下方，点击即可查看具体的效果。"
  },
  Tutorial_54390_Desc_2 = {
    Text = "属于<TutorialHighlight:正面状态>的如下（点击查看详情）：<TauntKeywords:嘲讽>、<PVPPowerIconKeywords:力量>、<EnergyStorageKeywords:蓄力>、<PVPProtectiveKeywords:屏障>、<PVPRetaliateIconKeywords:反击>、<ReinforceKeywords:加固>、<StrengthenKeywords:强化>。"
  },
  Tutorial_54390_Desc_3 = {
    Text = "属于<TutorialHighlight:负面状态>的如下（点击查看详情）：<PVPEntanglementKeywords:缠绕>、<PVPVulnerabilityIconKeywords:易伤>、<PVPSlowKeywords:迟缓>、<ComaKeywords:石化>、<DisarmKeywords:麻痹>、<PVPMethysisKeywords:中毒>、<PVPEmptinessKeywords:空虚>、<PVPBleedingKeywords:出血>、<PVPSeriousInjuryKeywords:重创>、<ComaKeywords:昏迷>。"
  },
  Tutorial_54390_Title_1 = {Text = "状态"},
  Tutorial_54391_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，有些唤醒体的卡牌会有不同的<TutorialHighlight:词缀>效果，可以在<TutorialHighlight:收藏>系统中查看或战斗中长按卡牌查看。属于词缀的有（点击查看详情）：<PVPPenetrateKeywords:贯穿>、<PrepareKeywords:预备>、<PVPResurrectionKeywords:复活>、<PVPHoldingKeywords:持有>、<PhantomKeywords:幻影>、<PVPRaidKeywords:突袭>。"
  },
  Tutorial_54391_Title_1 = {Text = "词缀"},
  Tutorial_54392_Desc_1 = {
    Text = "在一些特殊玩法中会有<TutorialHighlight:赛季>玩法，在赛季期间参与特殊玩法的排行榜即可在赛季结束时根据排行结算奖励。\n随着调查行动进度的推进，未来会有更多玩法参与<TutorialHighlight:赛季>玩法。"
  },
  Tutorial_54392_Desc_2 = {
    Text = "每个赛季期间都会有<TutorialHighlight:赛季任务>，完成赛季任务即可领取丰富的奖励，赛季任务将会在赛季刷新时重置。"
  },
  Tutorial_54392_Title_1 = {Text = "赛季"},
  Tutorial_54393_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，唤醒体阵亡后，手牌中属于该唤醒体的卡牌会变为<TutorialHighlight:幻象>。将<TutorialHighlight:命轮>装备给已阵亡唤醒体也获得1张幻象，同时返还消耗的算力。幻象还可以被特定命轮的效果合成<TutorialHighlight:小小心愿>。"
  },
  Tutorial_54393_Title_1 = {Text = "幻象"},
  Tutorial_54394_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，在第1回合时双方都是3点<TutorialHighlight:算力>及上限，后手会补偿一张<TutorialHighlight:后发制人>卡牌。之后每回合开始时，算力上限及回复量都会增长1点直到10点。除自动增长外，也有其他手段可以提高或降低算力上限，算力上限达到10后再增加，则每1点溢出上限会替换为抽1张牌。"
  },
  Tutorial_54394_Title_1 = {Text = "算力"},
  Tutorial_54395_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，每个唤醒体也有<TutorialHighlight:狂气>以及<TutorialHighlight:狂气爆发>。可以通过使用<TutorialHighlight:打击>卡或特定<TutorialHighlight:技能>卡来获得狂气，受到伤害损失生命时也会获得狂气（每损失2%生命或等量护盾获得1点狂气），狂气满100后点击对应唤醒体即可选择释放狂气爆发。"
  },
  Tutorial_54395_Title_1 = {Text = "狂气"},
  Tutorial_54396_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，在匹配对战中完成「对弈纪录」中的指定目标，可以领取对应的奖励。该奖励为一次性奖励，不随赛季重置，可以通过界面左下方的「对弈纪录」进行查看。"
  },
  Tutorial_54396_Title_1 = {
    Text = "对弈纪录"
  },
  Tutorial_54397_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，界面左侧的「收藏」页签内可以浏览全部唤醒体、命轮、钥令的信息。"
  },
  Tutorial_54397_Title_1 = {Text = "收藏"},
  Tutorial_54398_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，每个唤醒体都有2张<TutorialHighlight:打击>牌，3张<TutorialHighlight:技能>牌。通常，不同的技能牌会有不同的算力消耗。"
  },
  Tutorial_54398_Title_1 = {Text = "技能"},
  Tutorial_54399_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，每回合自动抽牌数也是5张，默认<TutorialHighlight:手牌上限>也是10张，可以在战斗界面的右下角看到我方当前手牌数及手牌上限数，右上角看到对方的情况。可以通过其他方式来让每回合抽牌数及手牌上限发生变化。"
  },
  Tutorial_54399_Title_1 = {Text = "手牌"},
  Tutorial_54400_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，不同的唤醒体有不同的<TutorialHighlight:定位>，总共5个。具体分别是<TutorialHighlight:守护>、<TutorialHighlight:斗争>、<TutorialHighlight:灵智>、<TutorialHighlight:凶星>、<TutorialHighlight:祝福>。进行<TutorialHighlight:编队>时需要选出4名不同定位的唤醒体来组成队伍。"
  },
  Tutorial_54400_Title_1 = {Text = "定位"},
  Tutorial_54401_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈-预组模式>中，点击界面右下角的「开始匹配」就会进入到编队界面。也可以在界面左侧的<TutorialHighlight:预组编队>中提前进行队伍构筑。"
  },
  Tutorial_54401_Desc_2 = {
    Text = "编队预组支持保存多套，左上角还能编辑队伍名称，每支队伍由4名唤醒体，4件命轮，2件钥令组成。"
  },
  Tutorial_54401_Title_1 = {
    Text = "预组编队"
  },
  Tutorial_54705_Desc_1 = {
    Text = "在<TutorialHighlight:相位对弈>模式中，点击自己的<TutorialHighlight:头像>，选择想要发送的<TutorialHighlight:对战表情>，向你的对手表达心意吧！"
  },
  Tutorial_54705_Title_1 = {Text = "表情"},
  Tutorial_54706_Desc_1 = {
    Text = "<TutorialHighlight:相位对弈>是两人对抗游戏，双方使用各自预组队伍进行<TutorialHighlight:匹配对战>，在匹配时会就近匹配旗鼓相当的对手。"
  },
  Tutorial_54706_Desc_2 = {
    Text = "通过对战可以获得<TutorialHighlight:预组经验>与<TutorialHighlight:轮选经验>，根据获得的经验，可以在<TutorialHighlight:预组等级>与<TutorialHighlight:轮选等级>中解锁<TutorialHighlight:一次性奖励>！"
  },
  Tutorial_54706_Desc_3 = {
    Text = "每赛季会根据积分排名获得<TutorialHighlight:头衔>，赛季结束时将会结算排名，并通过邮箱发送排名奖励。"
  },
  Tutorial_54706_Title_1 = {
    Text = "对弈简介"
  },
  Tutorial_74798_Desc_1 = {
    Text = "不同关卡会存在不同的 <TutorialHighlight:关卡篇章> 环境，大幅改变整体规则和造物效果。具体可在各个关卡界面点击相关页签查看。"
  },
  Tutorial_74798_Title_1 = {
    Text = "关卡篇章"
  },
  Tutorial_81370_Desc_1 = {
    Text = "<TutorialHighlight:唤醒体回溯>可以返还唤醒体的各种养成消耗。"
  },
  Tutorial_81370_Desc_2 = {
    Text = "<TutorialHighlight:养成回溯>将会重置唤醒体的等级、升格、技能、灵知深化状态，消耗的材料和金券均会全数返还。"
  },
  Tutorial_81370_Desc_3 = {
    Text = "<TutorialHighlight:启灵回溯>将会重置唤醒体的启灵状态，并重置启灵带来的等级上限，消耗的材料会全数返还。"
  },
  Tutorial_81370_Desc_4 = {
    Text = "<TutorialHighlight:黑池归还>将会包含「养成回溯」的效果，还会额外将唤醒体本身也重置，变为未解锁状态。"
  },
  Tutorial_81370_Title_1 = {
    Text = "唤醒体回溯"
  },
  Tutorial_81371_Desc_1 = {
    Text = "<TutorialHighlight:唤醒体升级>是最快速提升唤醒体属性的方式之一。消耗<TutorialHighlight:灵知制剂>可以提升唤醒体等级。"
  },
  Tutorial_81371_Desc_2 = {
    Text = "唤醒体达到等级上限之后需要通过<TutorialHighlight:升格>来提升等级上限，不同界域的唤醒体需要不同的<TutorialHighlight:升格素材>。"
  },
  Tutorial_81371_Title_1 = {
    Text = "唤醒体升级"
  },
  Tutorial_81372_Desc_1 = {
    Text = "<TutorialHighlight:启灵激活>可以极大的提升唤醒体的指令卡效果。启灵等级7级可以解锁<TutorialHighlight:超限爆发>，使唤醒体狂气爆发时获得额外效果。启灵等级11级和15级可以提高5级的唤醒体等级上限"
  },
  Tutorial_81372_Title_1 = {
    Text = "启灵激活"
  }
})
return Text_Tutorial
