__reload_all = true
local System = require("System.System")
local readonly = System.readonly
local Text_Event = readonly({
  Event_116371_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116371_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_116371_Name = {Text = "联络点"},
  Event_116372_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116372_Desc = {
    Text = "你触发了不明房间。"
  },
  Event_116372_Name = {Text = "不明"},
  Event_116373_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116373_Desc = {
    Text = "你找到了财宝。"
  },
  Event_116373_Name = {Text = "财宝"},
  Event_116374_ChoiceDesc1 = {
    Text = "【接通】回复Arg2点生命。"
  },
  Event_116374_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_116374_Name = {Text = "联络点"},
  Event_116389_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116389_Desc = {
    Text = "捏奥还在睡觉...zzZZ"
  },
  Event_116389_Name = {Text = "捏奥"},
  Event_116429_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116429_Desc = {
    Text = "你触发了随机事件3。"
  },
  Event_116429_Name = {
    Text = "随机事件3"
  },
  Event_116430_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116430_Desc = {
    Text = "你触发了随机事件1。"
  },
  Event_116430_Name = {
    Text = "随机事件1"
  },
  Event_116431_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_116431_Desc = {
    Text = "你触发了随机事件2。"
  },
  Event_116431_Name = {
    Text = "随机事件2"
  },
  Event_117279_ChoiceDesc1 = {
    Text = "【你曾渴望天真】将 3 张「(Skill.Arg1)」置入牌库。"
  },
  Event_117279_Desc = {
    Text = "\n海平面上升起淡薄的白雾，将万物笼罩在一片朦胧之中。\n跨越生与死的界限，跨越门扉内外的距离，跨越漫长得褪色的记忆，你看见撑着阳伞的淑女逆光的身影。\n与她共度的时光已经逝去，正如她那单薄却鲜妍的亮色青春。\n等待虚假的日轮升起，薄雾破碎于无形，她的侧影也在梦中摇晃着化为轻飘的虚妄泡沫，向你致以无声的告别。"
  },
  Event_117279_Name = {
    Text = "墨菲的幻影"
  },
  Event_117280_ChoiceDesc1 = {
    Text = "【你曾渴望天真】选择 2 张卡牌赋予「渊海回声」刻印。"
  },
  Event_117280_Desc = {
    Text = "\n海平面上升起淡薄的白雾，将万物笼罩在一片朦胧之中。\n跨越生与死的界限，跨越门扉内外的距离，跨越漫长得褪色的记忆，你看见撑着阳伞的淑女逆光的身影。\n与她共度的时光已经逝去，正如她那单薄却鲜妍的亮色青春。\n等待虚假的日轮升起，薄雾破碎于无形，她的侧影也在梦中摇晃着化为轻飘的虚妄泡沫，向你致以无声的告别。"
  },
  Event_117280_Name = {
    Text = "墨菲的幻影"
  },
  Event_118414_ChoiceDesc1 = {
    Text = "【三点】"
  },
  Event_118414_ChoiceDesc2 = {
    Text = "【六点】"
  },
  Event_118414_ChoiceDesc3 = {
    Text = "【一点】"
  },
  Event_118414_Desc = {
    Text = "骰子转起来，发出咕噜噜的声音。\n它会在什么时候停下？\n你不知道，但你必须给出一个答案。"
  },
  Event_118414_Name = {
    Text = "命运博弈"
  },
  Event_118415_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118415_Desc = {
    Text = "你的回应令「天空」越发温柔。\n。它轻轻在你的额头落下一吻。\n然后，你的额头开出了一朵浪花。"
  },
  Event_118415_Name = {
    Text = "海洋的拥抱"
  },
  Event_118416_ChoiceDesc1 = {
    Text = "【沉迷幻想】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118416_ChoiceDesc2 = {
    Text = "【保持理智】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_118416_ChoiceDesc3 = {
    Text = "【强行离开】获得3选1刻印"
  },
  Event_118416_Desc = {
    Text = "或许是长期的战斗令你产生了恍惚，也或许只是你的大脑背叛了你的身体。\n某种失重感出现在你的脑海。\n一瞬间，你的脑海突然变成了万花筒，绚烂，斑斓，闪动着五颜六色的光彩。\n数不清的灵感、迷思和狂想挤入大脑，占据你大脑沟壑的每一个角落。\n再这样下去，你的脑子很快就会被这些乱七八糟的东西撑爆。"
  },
  Event_118416_Name = {
    Text = "思维万花筒"
  },
  Event_118417_ChoiceDesc1 = {
    Text = "【加入赌局】感染「(Skill.Arg1)」，进入赌局"
  },
  Event_118417_ChoiceDesc2 = {
    Text = "【还是算了】获得25黑印"
  },
  Event_118417_Desc = {
    Text = "一阵恍惚中，你的意识穿过层层迷雾，飘散到了未知的空间。\n两个骰子被甩到了你的面前，将你强制带到这里的未知存在却仍未露面。\n你只能听到那存在来自四面八方的混沌声音。\n「想回去吗？那就来一局吧。」\n「以你的生命为筹码，和命运来场博弈。」"
  },
  Event_118417_Name = {
    Text = "命运博弈"
  },
  Event_118418_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118418_Desc = {
    Text = "超脱的体验总是短暂的。它们无声而至，又突然消失。\n但至少你的脑袋还在这里，没有真的爆炸。"
  },
  Event_118418_Name = {
    Text = "思维万花筒"
  },
  Event_118419_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_118419_Desc = {
    Text = "你没有输，但也没有赢，结果不好不坏。\n「平局……」\n未知存在叹了口气，声音里却听不出惋惜。\n「真是个不错的乐子。」"
  },
  Event_118419_Name = {
    Text = "命运博弈"
  },
  Event_118420_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118420_Desc = {
    Text = "渐渐地，那狂乱的乐音在你耳中变得和谐，圣洁。\n你终于顿悟，理解它为什么会被称为「完美圣歌」。\n因为它确实「完美无瑕」。"
  },
  Event_118420_Name = {
    Text = "「完美」圣歌"
  },
  Event_118421_ChoiceDesc1 = {
    Text = "【感知大脑】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118421_ChoiceDesc2 = {
    Text = "【感知灵魂】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_118421_Desc = {
    Text = "人的第一个囚笼，就是自己的躯壳。\n在这躯壳囚笼里，大脑，是最后的也是最重要的牢笼。\n「甜心，你以为自己活着，还在呼吸，就安全了吗？」\n当你的大脑背叛你的灵魂时，你会体会到世间最痛苦的折磨。\n而这折磨，会伴随你一生。"
  },
  Event_118421_Name = {
    Text = "脑际囚笼"
  },
  Event_118422_ChoiceDesc1 = {
    Text = "【碰触蝴蝶】删除2张卡牌"
  },
  Event_118422_ChoiceDesc2 = {
    Text = "【驱赶蝴蝶】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118422_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_118422_Desc = {
    Text = "深海里没有蝴蝶。是被囚禁在房间里的少女构想出了这些生命。\n它们是那么美丽，在空中自由地翩翩飞舞。\n「如果……如果我也能像它们，飞离这里就好了……」\n一只蝴蝶发出了啜泣，但这声音掩盖在无数的振翅声里，掩盖在噼啪的打字音里，几不可闻。"
  },
  Event_118422_Name = {
    Text = "灵魂如蝴蝶飞舞"
  },
  Event_118423_ChoiceDesc1 = {
    Text = "【剪断绳子】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_118423_ChoiceDesc2 = {
    Text = "【替他松绑】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_118423_ChoiceDesc3 = {
    Text = "【助他解脱】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_118423_Desc = {
    Text = "「有人说，无尽的欲望是使人前进的动力。」\n「但当这欲望强大到不可忽视，不可斩断时，我却只觉得这来自自身的欲望，化为了困住我的牢笼。」\n黑暗中传来了有气无力的声音，你看不见对方的面容，只见到一双被捆缚的双手。\n「这些欲望以我的恐惧、懦弱、希望、痛苦为食，又反过来增进了我的欲望。」\n那有气无力的声音，发出最后的哀求。\n「我愿意献出一切！好心人，拯救我……或者给予我解脱……」"
  },
  Event_118423_Name = {
    Text = "缠缚之欲"
  },
  Event_118424_ChoiceDesc1 = {
    Text = "【感知大脑】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118424_Desc = {
    Text = "你感觉自己的脑髓抽动了一下。\n「这有什么特殊的意义吗？」\n你询问自己，而大脑寂静无声。\n不是每一次对于自身的追问都能获得答案。"
  },
  Event_118424_Name = {
    Text = "脑际囚笼"
  },
  Event_118425_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118425_Desc = {
    Text = "你奋力上游，终于跃出了水面。\n混着海腥味的空气涌入你的肺叶，提醒你并未真正逃离危险。\n但你知道，真正的天空就在你的头顶。\n就像真相，永远不会被温柔的谎言遮蔽。"
  },
  Event_118425_Name = {
    Text = "海洋的拥抱"
  },
  Event_118426_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118426_Desc = {
    Text = "当你碰触那欲望之绳的刹那，一种刺痛自你的灵魂深处涌起。\n你的恐惧、懦弱、希望、痛苦全部自你的体内涌出，转化为沾满血腥的绳子，捆住了你的双手。\n这时，你听到了那声音带着恶意的欢呼。\n「好心人，你会获得报酬的……当然，还有诅咒。」"
  },
  Event_118426_Name = {
    Text = "缠缚之欲"
  },
  Event_118427_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118427_Desc = {
    Text = "你的碰触令蝴蝶们颤抖。\n自诞生以来，它们从没有感受过这样温柔的对待。\n蝴蝶们被不知所措的情绪掌控，甚至忘记了飞翔。\n于是，数不清的蝴蝶坠落，露出那曾被无数翅膀遮掩的打字机。\n那已经失去生命的可怜东西，用最后的力量，打出了「自由」两个字。"
  },
  Event_118427_Name = {
    Text = "灵魂如蝴蝶飞舞"
  },
  Event_118428_ChoiceDesc1 = {
    Text = "【准备战斗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118428_ChoiceDesc2 = {
    Text = "【尝试绕路】获得25黑印"
  },
  Event_118428_Desc = {
    Text = "于星光垂落的深海里，蹈海者们蛰伏了千百年的岁月。\n无垠的海水见证了他们的疯狂，见证了他们的忍耐，也见证了他们对神明最虔诚的信仰。\n没有人可以阻挡神明的伟大降临。\n任何碍事者，都会在蹈海者的怒火中化为灰烬。"
  },
  Event_118428_Name = {
    Text = "群星下的等待"
  },
  Event_118429_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118429_Desc = {
    Text = "你下意识捂住了耳朵。\n不可思议的，那些来自灵魂深处的乐音消失了。\n当然，只是暂时的。"
  },
  Event_118429_Name = {
    Text = "亵渎琴音"
  },
  Event_118430_ChoiceDesc1 = {
    Text = "【重温过去】获得3选1高级刻印"
  },
  Event_118430_ChoiceDesc2 = {
    Text = "【窥视未来】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118430_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_118430_Desc = {
    Text = "世间没有什么能够稳固不变。\n即便是神母塑造的乐园也是如此。\n在短暂的刹那，你从时空裂隙里瞥到了一些东西。\n过去、现在、未来交织在那布满裂痕的罅隙里，不停变化。\n等待你好奇的窥探。"
  },
  Event_118430_Name = {
    Text = "时空裂隙"
  },
  Event_118431_ChoiceDesc1 = {
    Text = "【获得100黑印】"
  },
  Event_118431_ChoiceDesc2 = {
    Text = "【随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_118431_Desc = {
    Text = "无形意志不接受你的选择。它愿意再给你一次机会，让你做出改变——\n小心，哪怕音乐无形，也能收割性命。"
  },
  Event_118431_Name = {
    Text = "「完美」圣歌"
  },
  Event_118432_ChoiceDesc1 = {
    Text = "【喂食老鼠】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_118432_ChoiceDesc2 = {
    Text = "【驱赶老鼠】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118432_ChoiceDesc3 = {
    Text = "【无视老鼠】获得25黑印"
  },
  Event_118432_Desc = {
    Text = "这艘船上的一切，都在轮回。\n那些在船上讨生活的，令人厌恶且长满肮脏绒毛的小东西们自然也无法避免这样的命运。\n一次又一次轮回中，它们吃所能看到的一切，却仍无法满足。\n「好……饿啊……」\n成群的老鼠们发出病态又刺耳的尖啸。\n一次次轮回令它们饥饿难忍，它们必须吃些什么。\n立刻，马上！"
  },
  Event_118432_Name = {
    Text = "饥饿的鼠群"
  },
  Event_118433_ChoiceDesc1 = {
    Text = "【回避视线】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118433_ChoiceDesc2 = {
    Text = "【直视眼睛】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_118433_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_118433_Desc = {
    Text = "和天空的群星相同，深海里当然也有许多眼睛。\n那些眼睛来自生活于海底的鱼，来自亵渎的腮类，也来自海洋本身。\n嘘，不要惊动他们。\n不要，惊动深海的疯狂。"
  },
  Event_118433_Name = {
    Text = "深海之眼"
  },
  Event_118434_ChoiceDesc1 = {
    Text = "【无视耳语】"
  },
  Event_118434_ChoiceDesc2 = {
    Text = "【聆听耳语】"
  },
  Event_118434_ChoiceDesc3 = {
    Text = "【反向宣传】"
  },
  Event_118434_Desc = {
    Text = "「渴望获得神明的垂青吗？想要知晓自身的意义吗？」\n一声叹息响在你的耳边，犹如精神病患的自我呢喃，又似无形之物的亲昵耳语。\n理智与警惕之下，你出声拒绝，那声音却仍旧自说自话。\n「请耐心聆听。你将知晓的，是关乎世界命运的真相……」"
  },
  Event_118434_Name = {
    Text = "无形者的布道"
  },
  Event_118435_ChoiceDesc1 = {
    Text = "【感知大脑】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118435_ChoiceDesc2 = {
    Text = "【感知灵魂】感染「(Skill.Arg1)」，再次随机刻印"
  },
  Event_118435_Desc = {
    Text = "被安全保护在头颅里的大脑向你传达了某些信息。\n你不知道这些信息是否在神经递质的转换和生物电流的传递里受到了磨损。\n唯一可以确定的事实是，你接收到了这信息，并在躯体的客观存在里，感知到了自己的存活。"
  },
  Event_118435_Name = {
    Text = "脑际囚笼"
  },
  Event_118436_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_118436_Desc = {
    Text = "「不错的答案，但很可惜，不是正确答案。」\n「那什么是正确答案？」\n未知存在没有回答你的问题，只是发出了一声嗤笑。\n「谁告诉你命运有正确答案？」"
  },
  Event_118436_Name = {
    Text = "命运博弈"
  },
  Event_118437_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118437_Desc = {
    Text = "「你以为我没有尝试过剪断它们？不，当你抗拒欲望时，它们只会变得更加强烈！」\n感受着欲望化成的绳子越来越紧，甚至勒入血肉，那声音发出绝望的狂呼。\n「我永远摆脱不了它们……永远！」"
  },
  Event_118437_Name = {
    Text = "缠缚之欲"
  },
  Event_118438_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_118438_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_118438_Desc = {
    Text = "漆黑的乌鸦在哭泣。\n漆黑的乌鸦在呐喊。\n漆黑的乌鸦在狂啸。\n然而在人们听来，它只是在唱歌。\n「啊，多么无忧无虑的歌声啊。真希望我也是一只乌鸦，远离人世的烦恼。」"
  },
  Event_118438_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118439_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118439_Desc = {
    Text = "蝴蝶散去，你终于看清了下方的打字机。\n那已经失去生命的可怜东西，用最后的力量，打出了「离开」两个字。"
  },
  Event_118439_Name = {
    Text = "灵魂如蝴蝶飞舞"
  },
  Event_118440_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118440_Desc = {
    Text = "过去的影像里，披着毛绒大衣的少女向着你挥手。\n你听不清她说了什么，但你看到了少女的笑容。"
  },
  Event_118440_Name = {
    Text = "时空裂隙"
  },
  Event_118441_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118441_Desc = {
    Text = "深海再次恢复了漆黑与寂静。\n在这漆黑与寂静里，你再次听到了心跳声。\n那声音来自你的体内。\n在别人眼中，你也只是一个游曳在漆黑深海的跳动心脏。"
  },
  Event_118441_Name = {
    Text = "弱肉强食"
  },
  Event_118442_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118442_Desc = {
    Text = "这次，化为灰烬的并非碍事者，而是蹈海者。\n群星无声俯视着这一幕，一如过去千百年那样，保持沉默。"
  },
  Event_118442_Name = {
    Text = "群星下的等待"
  },
  Event_118443_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118443_Desc = {
    Text = "尽管在数量上占据优势，那些肮脏鼠类的胆量却比它们的身体更小。\n它们被你强势的态度所恐吓，一哄而散。"
  },
  Event_118443_Name = {
    Text = "饥饿的鼠群"
  },
  Event_118444_ChoiceDesc1 = {
    Text = "【伸出援手】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_118444_ChoiceDesc2 = {
    Text = "【静默旁观】获得3选1刻印"
  },
  Event_118444_Desc = {
    Text = "一只跳动的心脏游曳在漆黑的深海。\n它或许属于一只游鱼，或许属于某个生有鱼鳃的生物。\n你看不清。你唯一能够看清的，就是那不停跳动的心脏，和那心脏后方，逐渐张开的血盆大口。\n狩猎，或者被狩猎，是大自然的法则。\n无论是在陆地，还是海洋。"
  },
  Event_118444_Name = {
    Text = "弱肉强食"
  },
  Event_118445_ChoiceDesc1 = {
    Text = "【挥手驱赶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118445_ChoiceDesc2 = {
    Text = "【任由停留】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118445_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_118445_Desc = {
    Text = "黑暗里传来了轻微的声响。\n那是一只蝴蝶礼貌地问询。\n「我可以落在你的掌心吗？」\n「我只是太累了，想要休息一下……」\n如此问询着，蝴蝶穿越过黑暗，盘旋在你的面前。\n漆黑的粘液自它的翅膀滴落——那是蝴蝶穿越黑暗时，来自黑暗的馈赠。"
  },
  Event_118445_Name = {
    Text = "蝴蝶的请求"
  },
  Event_118446_ChoiceDesc1 = {
    Text = "【离开】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_118446_Desc = {
    Text = "一阵沉默后，什么东西被抛到了你的怀里。\n「拿着它离开吧。」\n「命运对于好运者，一向慷慨。」"
  },
  Event_118446_Name = {
    Text = "命运博弈"
  },
  Event_118447_ChoiceDesc1 = {
    Text = "【跟随指引】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118447_ChoiceDesc2 = {
    Text = "【无视指引】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118447_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_118447_Desc = {
    Text = "祭典已经开始。\n在灵的焰火与血的祝祷下，数不清的信徒灵魂化作了航标——\n缥缈的灵分散在你的周围，犹如引路的精灵，闪着光等待你的选择。"
  },
  Event_118447_Name = {
    Text = "灵魂航标"
  },
  Event_118448_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_118448_Desc = {
    Text = "「无知的人类！」\n那声音发出懊恼的抱怨，却未至愤怒的程度。\n因它知晓，无知者总有开悟的时刻。\n它只需等待那一日的到来。\n并在那一日的到来前，于你身上刻下神明的烙印，确认你灵魂的归属。"
  },
  Event_118448_Name = {
    Text = "无形者的布道"
  },
  Event_118449_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118449_Desc = {
    Text = "「@2的@3……」\n庞杂的知识随同亵渎的乐音，灌入你的大脑。\n但人类的身体，却限制了你，让你无法理解来自宇宙的学识。\n真是可悲的遗憾。"
  },
  Event_118449_Name = {
    Text = "亵渎琴音"
  },
  Event_118450_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_118450_Desc = {
    Text = "「其实，我也有一个世界的真相想要告诉你……」\n「世界是由长有两个智慧的肉丸眼睛，和象征无限能力的意面组成的飞天意面神所创造……」\n你认真地胡诌着听来的趣事，等待对方的反应。\n但过了许久，对面都毫无动静。\n「唉，看来狂信者不懂得幽默。」\n你叹息一声，只能离开。"
  },
  Event_118450_Name = {
    Text = "无形者的布道"
  },
  Event_118451_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118451_Desc = {
    Text = "你的调律并未使这错乱的音节变得和谐。\n但至少，无形意志看到了你的尝试。\n这是个好的开始。"
  },
  Event_118451_Name = {
    Text = "「完美」圣歌"
  },
  Event_118452_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118452_Desc = {
    Text = "三个人影颤抖着，无声啜泣。\n它们的信仰被你质疑，而这，是狂信者最不能容忍的冒犯。"
  },
  Event_118452_Name = {
    Text = "最好的祭品"
  },
  Event_118453_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118453_Desc = {
    Text = "未来的影像里，生出腕足的少女骄矜地瞥了你一眼，出声呵斥。\n「神母的真容不容亵渎。」\n于是，影像消失，时空裂隙也瞬间关闭。徒留你回忆着刚才的景象。"
  },
  Event_118453_Name = {
    Text = "时空裂隙"
  },
  Event_118454_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118454_Desc = {
    Text = "你成功摆脱了蹈海者，继续向前奔袭。\n在你的头顶，群星静静闪耀，一如过去的千百年。"
  },
  Event_118454_Name = {
    Text = "群星下的等待"
  },
  Event_118455_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118455_Desc = {
    Text = "未知存在没有阻拦你。\n「总有一天，你会再回来的。」\n「没有人，可以拒绝命运。」"
  },
  Event_118455_Name = {
    Text = "命运博弈"
  },
  Event_118456_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118456_Desc = {
    Text = "干脆利落的动作下，那双手无力地垂下。\n但你没有错过对方最后的叹息。\n他终于从自身无尽的欲望里，真正解脱。"
  },
  Event_118456_Name = {
    Text = "缠缚之欲"
  },
  Event_118457_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118457_Desc = {
    Text = "不被感知是世间必然的宿命。\n没有谁能够完全共情另一个生命。"
  },
  Event_118457_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118458_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_118458_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_118458_Desc = {
    Text = "漆黑的乌鸦在哭泣。\n漆黑的乌鸦在呐喊。\n漆黑的乌鸦在狂啸。\n然而在人们听来，它只是在唱歌。\n「啊，多么无忧无虑的歌声啊。真希望我也是一只乌鸦，远离人世的烦恼。」"
  },
  Event_118458_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118459_ChoiceDesc1 = {
    Text = "【侧耳聆听】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118459_ChoiceDesc2 = {
    Text = "【堵住耳朵】获得3选1刻印"
  },
  Event_118459_Desc = {
    Text = "无形的狂乱中，你似乎看到了一架钢琴。\n有一双看不清形状的手，在这无形的琴键上跃动，弹奏着亵渎的乐音。\n吊诡的音乐自你的灵魂深处响起，通过血管的线路，直达你颤动的大脑。"
  },
  Event_118459_Name = {
    Text = "亵渎琴音"
  },
  Event_118460_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118460_Desc = {
    Text = "那些灵感、迷思和狂想混杂在一起，调和成世间最绚烂的颜色。\n你看到空间在自己体内折叠，时间随自己的意愿盘旋。\n此刻，你洞察了时空，无所不能，无所不知。\n当然，你也付出了代价。"
  },
  Event_118460_Name = {
    Text = "思维万花筒"
  },
  Event_118461_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118461_Desc = {
    Text = "混沌的灵魂以尖锐的嚎哭为你指引前路。\n那是安全的前路吗？你不知道。\n你唯一的选择，只有继续前行。"
  },
  Event_118461_Name = {
    Text = "灵魂航标"
  },
  Event_118462_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_118462_ChoiceDesc2 = {
    Text = "【放任不管】获得25黑印，离开"
  },
  Event_118462_Desc = {
    Text = "漆黑的乌鸦在哭泣。\n漆黑的乌鸦在呐喊。\n漆黑的乌鸦在狂啸。\n然而在人们听来，它只是在唱歌。\n「啊，多么无忧无虑的歌声啊。真希望我也是一只乌鸦，远离人世的烦恼。」"
  },
  Event_118462_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118463_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118463_Desc = {
    Text = "混沌的灵魂发出一声哀怨的叹息。\n它渐渐消散了，但那哀怨的叹息，如有实质，落上了你的心脏。\n咚咚，你的心跳和祭典的乐音同频响起。"
  },
  Event_118463_Name = {
    Text = "灵魂航标"
  },
  Event_118464_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_118464_Desc = {
    Text = "「啊，啊，这是多么虔诚的羔羊啊！」\n那声音慨叹着，充满了赞誉的狂喜。\n「当吾主苏醒时，像你这样的羔羊必然能在那崇高而伟大的神国里找到一处容身之所……」"
  },
  Event_118464_Name = {
    Text = "无形者的布道"
  },
  Event_118465_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118465_Desc = {
    Text = "「天空」包容着你的任性。\n总有一日，迷途的孩子会回归母亲的怀抱。\n因为，你无处可逃。"
  },
  Event_118465_Name = {
    Text = "海洋的拥抱"
  },
  Event_118466_ChoiceDesc1 = {
    Text = "【接受拥抱】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc2 = {
    Text = "【拒绝拥抱】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118466_ChoiceDesc3 = {
    Text = "【游出水面】获得25黑印"
  },
  Event_118466_Desc = {
    Text = "世界在你的眼中倾倒。\n此刻，环绕你的深海才是「天空」。\n在几近溺亡的痛苦里，这片深蓝的「天空」温柔地靠近，意图将你拥入怀中。\n它不会评判，只会给予。"
  },
  Event_118466_Name = {
    Text = "海洋的拥抱"
  },
  Event_118467_ChoiceDesc1 = {
    Text = "【呵斥它们】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_118467_ChoiceDesc2 = {
    Text = "【回应它们】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_118467_ChoiceDesc3 = {
    Text = "【无视他们】获得50黑印"
  },
  Event_118467_Desc = {
    Text = "三个形状模糊的灵魂拦住了你的前路。\n一个人影虔诚地向你行礼，恳请你赐予鲜血。你流动的血液，是献给神最好的祭品。\n一个人影冷漠地向你举刀，意图割下你的血肉。那未变异的人肉，定能俘获神的青睐。\n最后一个只无声注视你，希望你收走自己的生命，以此证明最虔诚的信仰。"
  },
  Event_118467_Name = {
    Text = "最好的祭品"
  },
  Event_118468_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_118468_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_118468_Desc = {
    Text = "漆黑的乌鸦在哭泣。\n漆黑的乌鸦在呐喊。\n漆黑的乌鸦在狂啸。\n然而在人们听来，它只是在唱歌。\n「啊，多么无忧无虑的歌声啊。真希望我也是一只乌鸦，远离人世的烦恼。」"
  },
  Event_118468_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118469_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_118469_ChoiceDesc2 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_118469_ChoiceDesc3 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_118469_Desc = {
    Text = "「不！我们不要这些！我们要更加……美味的东西。」\n「那就是……你的血肉！」\n成群的老鼠发出尖啸，向你涌来。\n看来泛滥的善心，有时反而会惹来麻烦。"
  },
  Event_118469_Name = {
    Text = "饥饿的鼠群"
  },
  Event_118470_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118470_Desc = {
    Text = "你的尊重博得了那些眼睛的好感。\n消失前，它们透过涌动的海水，赠送给你一个礼物。\n那是深海驯服你的证物。"
  },
  Event_118470_Name = {
    Text = "深海之眼"
  },
  Event_118471_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118471_Desc = {
    Text = "在你毫不遮掩的目光下，深海慢慢苏醒。\n海水狂乱地涌动在你的周围，带来不可名状的呓语。\n感受深海的愤怒吧，这是赐福，也是诅咒。"
  },
  Event_118471_Name = {
    Text = "深海之眼"
  },
  Event_118472_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_118472_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_118472_Desc = {
    Text = "漆黑的乌鸦在哭泣。\n漆黑的乌鸦在呐喊。\n漆黑的乌鸦在狂啸。\n然而在人们听来，它只是在唱歌。\n「啊，多么无忧无虑的歌声啊。真希望我也是一只乌鸦，远离人世的烦恼。」"
  },
  Event_118472_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118473_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118473_Desc = {
    Text = "鲜血、肉块，生命。\n祭品已经备好，接下来只需要静静等待神的飨宴。"
  },
  Event_118473_Name = {
    Text = "最好的祭品"
  },
  Event_118474_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118474_Desc = {
    Text = "蝴蝶明白了你的拒绝。\n沾满漆黑粘液的翅膀再次震动，在黑暗中摇摇晃晃地飞舞。\n很快，黑暗再次吞噬了蝴蝶。这次，它已无力挣扎。"
  },
  Event_118474_Name = {
    Text = "蝴蝶的请求"
  },
  Event_118475_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118475_Desc = {
    Text = "蝴蝶落到了你的掌心，一同落下的，还有那斑斓翅膀上的漆黑粘液。\n在你的叹息声中，斑斓的翅膀渐渐融化，与漆黑的粘液嵌合成未知的混沌形状。\n这只蝴蝶再也不用经历黑暗了。\n它安眠于你的掌心。"
  },
  Event_118475_Name = {
    Text = "蝴蝶的请求"
  },
  Event_118477_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118477_Desc = {
    Text = "声嘶力竭的乌鸦终于闭上了眼睛。\n在无人知晓、不被感知的怨恨里，它咽下最后一口气，化为一滩黑色的浓浆。"
  },
  Event_118477_Name = {
    Text = "不被感知的怨叹"
  },
  Event_118478_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118478_Desc = {
    Text = "「谢谢你……」\n跳动的心脏雀跃地奔向远方。\n不久后，漆黑的深海里传来了咀嚼血肉的声音。"
  },
  Event_118478_Name = {
    Text = "弱肉强食"
  },
  Event_118479_ChoiceDesc1 = {
    Text = "【接受邀请】感染「(Skill.Arg1)」，获得诅咒造物-「(RelicConfig.Arg2)」"
  },
  Event_118479_ChoiceDesc2 = {
    Text = "【拒绝邀请】选择销毁1个造物，获得1个奖励"
  },
  Event_118479_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_118479_Desc = {
    Text = "「这艘船上的一切，都必须成为这不断溃散又重启的循环乐园的一部分。」\n狂乱的乐音奏响在你的脑海，那是无形意志对你的启迪。\n「这里没有哭泣，没有悲伤，只有纯洁的圣乐和永恒的欢笑。」\n「你愿意加入乐园，成为这完美乐音的一部分吗？」"
  },
  Event_118479_Name = {
    Text = "「完美」圣歌"
  },
  Event_118480_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_118480_Desc = {
    Text = "在你的静默中，灵魂们无声消散。\n不理解信仰者，不值得它们浪费时间。"
  },
  Event_118480_Name = {
    Text = "最好的祭品"
  },
  Event_123616_ChoiceDesc1 = {
    Text = "【领取标准造物】"
  },
  Event_123616_Desc = {
    Text = "将所有唤醒体狂气设置为 100，银钥设置为 1000，生命设置为 80％。\n移除 2 张卡牌，置入 3 张症状卡。\n猩红熔炉设置为 12.5％，选择 4 张卡牌置入超维空间。\n获得标准造物包。"
  },
  Event_123616_Name = {
    Text = "一键跳过道中"
  },
  Event_125696_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125696_Desc = {
    Text = "无来由的愤怒驱使着你，你抬起手，奋力驱赶。你在谜题里停留了太久，或许你渴盼的是一场酣畅的战斗，甚至只是渴盼着终结……\n但鸦群什么也没有做。在你的注视下，深渊消散。\n鸦群消失在舞台的尽头，那个你将要去往的地方。"
  },
  Event_125696_Name = {
    Text = "群鸦深渊"
  },
  Event_125697_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125697_Desc = {
    Text = "「胆小。」女声丝毫不掩饰她笑声中的嘲弄。\n「走吧，走得越远越好。」"
  },
  Event_125697_Name = {
    Text = "命运之锁"
  },
  Event_125698_ChoiceDesc1 = {
    Text = "【驱赶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125698_ChoiceDesc2 = {
    Text = "【聆听】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125698_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_125698_Desc = {
    Text = "黑暗里传来了轻微的声响。一只蝴蝶落入你的掌心。你记得它。\n「阿拉克涅小姐……你从没有抛弃过我们，对吗？」\n蝴蝶美丽的花纹，望向你身边的人。"
  },
  Event_125698_Name = {
    Text = "蝴蝶的余生"
  },
  Event_125699_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125699_Desc = {
    Text = "那声音与文字如同蜂群般钻入你的脑海。你屏息凝神，将那无用的杂念摒除在头脑之外。\n无视比阅读要困难太多太多，但你做到了。"
  },
  Event_125699_Name = {
    Text = "维度电报"
  },
  Event_125700_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125700_Desc = {
    Text = "那是敌人制造的幻觉！\n你摇摇头，清醒了过来，再次握紧手中的银钥。"
  },
  Event_125700_Name = {
    Text = "酒中倒影"
  },
  Event_125701_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125701_Desc = {
    Text = "你认真凝望那只眼，努力地注视、倾听。你尝试走进演员的内心，体察他正经历的苦痛。\n你靠近，靠近。你穿过他的身躯，触碰到他的灵魂……\n你猛地睁开眼，发现自己正站在舞台的中央，眼泪顺着指尖流下。\n那是你献给观众的剖白。"
  },
  Event_125701_Name = {
    Text = "演员的剖白"
  },
  Event_125702_ChoiceDesc1 = {
    Text = "【与她讨论】删除1张指令卡，获得Arg1黑印"
  },
  Event_125702_ChoiceDesc2 = {
    Text = "【沉默不语】"
  },
  Event_125702_Desc = {
    Text = "「欢乐的结局固然美好，可那虚假的欢乐，永远无法触及观众的心……」\n剧作者闭目沉思。她对这个结局并不满意。"
  },
  Event_125702_Name = {
    Text = "剧作的结局"
  },
  Event_125703_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_125703_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_125703_Desc = {
    Text = "「吱呀——吱呀——命运的女神转动她的纺机。\n吱呀——吱呀——命运的丝线在她手中汇集。」"
  },
  Event_125703_Name = {
    Text = "最后的预言"
  },
  Event_125704_ChoiceDesc1 = {
    Text = "【自己】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_125704_ChoiceDesc2 = {
    Text = "【威廉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125704_ChoiceDesc3 = {
    Text = "【谁也不是】获得25黑印"
  },
  Event_125704_Desc = {
    Text = "你肯定自己没有喝醉，但望向酒精的时候，你坠入一片宁静的湖泊。\n优雅的杯中映出一个身影，那是谁？"
  },
  Event_125704_Name = {
    Text = "酒中倒影"
  },
  Event_125705_ChoiceDesc1 = {
    Text = "【聆听】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_125705_ChoiceDesc2 = {
    Text = "【驱赶】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_125705_Desc = {
    Text = "在你靠近体内质体的力量时，一群乌鸦出现在你的脑海，在你紊乱的精神空间中盘旋。\n\n群鸦环绕着你，一道深渊在你头顶倒置流转。\n十万只乌鸦齐声鸣叫，如同一道嘲讽的预言。"
  },
  Event_125705_Name = {
    Text = "群鸦深渊"
  },
  Event_125706_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125706_Desc = {
    Text = "你与阿拉克涅尝试稳定住身侧崩毁的命运。你们的努力收效甚微，但这已经足够。利用争取到的时间，你们继续靠近涅芙蕾亚。\n你来到这里，是为了将解脱带给她。"
  },
  Event_125706_Name = {
    Text = "命运之网谢幕"
  },
  Event_125707_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_125707_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_125707_Desc = {
    Text = "「它们与巨网一同死去，悄无声息。」"
  },
  Event_125707_Name = {
    Text = "最后的预言"
  },
  Event_125708_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125708_Desc = {
    Text = "那是一封寄给渊狱的电报。\n「不要着急，我的孩子们。监牢的大门即将开启，你们的自由就要来临。」"
  },
  Event_125708_Name = {
    Text = "维度电报"
  },
  Event_125709_ChoiceDesc1 = {
    Text = "【驱赶】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125709_ChoiceDesc2 = {
    Text = "【聆听】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125709_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_125709_Desc = {
    Text = "一只蝴蝶轻轻停驻在你的手中。美丽的花纹如同眼珠，静静望向你。\n或许，它想要告诉你什么？"
  },
  Event_125709_Name = {
    Text = "蝴蝶的小憩"
  },
  Event_125710_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125710_Desc = {
    Text = "二十双哀戚的眼睛望向你。乌鸦停止了歌唱，带着最后的预言离开了这张摇摇欲坠的网。"
  },
  Event_125710_Name = {
    Text = "最后的预言"
  },
  Event_125711_ChoiceDesc1 = {
    Text = "【弯腰探出】感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」"
  },
  Event_125711_ChoiceDesc2 = {
    Text = "【放弃查看】获得50黑印"
  },
  Event_125711_Desc = {
    Text = "走过街角的时候，你看到一座简朴的放映厅。你并不记得伦蒂尼恩有这样一家店存在。"
  },
  Event_125711_Name = {
    Text = "记忆影厅"
  },
  Event_125712_ChoiceDesc1 = {
    Text = "【接受命运】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125712_ChoiceDesc2 = {
    Text = "【反抗命运】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_125712_Desc = {
    Text = "「啊，我们又见面了，亲爱的。」\n你开始享受那道在你大脑中回荡的年轻女声。它温柔，诱惑，如同诱捕飞虫的网。\n「来吧，告诉我，你愿意接受你的命运吗？」"
  },
  Event_125712_Name = {
    Text = "宿命囚笼"
  },
  Event_125713_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125713_Desc = {
    Text = "「愚蠢的人类，我跟你很熟吗？」\n黑猫嫌弃地白了你一眼，转过身去。\n「离开这里吧。下次不要再做这种蠢事了。」"
  },
  Event_125713_Name = {
    Text = "幻化易形"
  },
  Event_125714_ChoiceDesc1 = {
    Text = "【拍摄照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125714_ChoiceDesc2 = {
    Text = "【更换姿势】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，可以使用两次"
  },
  Event_125714_Desc = {
    Text = "一架相机孤零零地站在舞台上，漆黑的镜头望向你，像是机械神明创造出的神秘复眼。\n「这座剧院已经很久没有观众了……欢迎！欢迎！来拍张照吧！完全免费！」\n相机兴奋地喊叫着。在这座无人在意的舞台上，它是唯一的主角。"
  },
  Event_125714_Name = {
    Text = "观众席的留影"
  },
  Event_125715_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125715_Desc = {
    Text = "「对命运没有疑问的人，要如何期盼命运的回答呢？」"
  },
  Event_125715_Name = {
    Text = "命运之锁"
  },
  Event_125716_ChoiceDesc1 = {
    Text = "【思考破局】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125716_ChoiceDesc2 = {
    Text = "【顺其自然】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_125716_ChoiceDesc3 = {
    Text = "【浮出水面】获得25黑印"
  },
  Event_125716_Desc = {
    Text = "一座新的舞台，两个交叠的人生……躲避警员的路上，你整理着阿拉克涅告诉你的这些事。\n繁杂的思绪中，你坠入宁静的深海。"
  },
  Event_125716_Name = {Text = "宁静"},
  Event_125717_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125717_Desc = {
    Text = "蝴蝶飞到你的肩头，凑到你的耳边。你认真倾听，但你只听到了它翅膀的翕动，如同无声的叹息。\n在你的聆听里，那双斑斓的翅膀渐渐融化，蝴蝶于你的肩头安眠。\n你再也无法得知它想告知你的话语。"
  },
  Event_125717_Name = {
    Text = "蝴蝶的余生"
  },
  Event_125718_ChoiceDesc1 = {
    Text = "【咀嚼】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_125718_ChoiceDesc2 = {
    Text = "【拒绝】获得3选1刻印"
  },
  Event_125718_Desc = {
    Text = "「饿了吧，亲爱的客人？」\n一道黏腻的声音从吧台后方响起。你回过身去，没有看到任何东西。\n「午夜假面酒吧的小吃也远近闻名。要试试看吗？」"
  },
  Event_125718_Name = {
    Text = "命运的味道"
  },
  Event_125719_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125719_Desc = {
    Text = "你不敢随意阅读上面的文字，只是仔细打量那个精致的信封。\n信封上的火漆刻印着一个模糊的族徽，上面用漂亮的花体字写下：\n「致新生的阿拉克涅小姐。」\n「您忠诚的管家，埃德加。」"
  },
  Event_125719_Name = {
    Text = "晚安，埃德加先生"
  },
  Event_125720_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125720_Desc = {
    Text = "「原来如此，我明白了，姐姐……」\n「剧作者从来无法改写角色的结局。那凄惨的命运早已注定，即便是你，也从来无法改变……」\n悲伤的哽咽消失了。剧作者的打字机化成一只只蝴蝶，散入空旷的命运剧院，再也看不见踪迹。"
  },
  Event_125720_Name = {
    Text = "剧作的结局"
  },
  Event_125721_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125721_Desc = {
    Text = "不知名的演员，危险的舞步……那又有什么关系？不会有什么比命运本身更糟糕了。\n你伸出手，踏上舞台。木偶拉起你的手，跳起欢快的舞。\n你听见了掌声。"
  },
  Event_125721_Name = {Text = "三人舞"},
  Event_125722_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_125722_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_125722_Desc = {
    Text = "「它们跳舞。它们欢唱。吱呀——吱呀——」"
  },
  Event_125722_Name = {
    Text = "最后的预言"
  },
  Event_125723_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125723_Desc = {
    Text = "指引者，战友，孤独维度里仅有的同伴。\n你们会一起解决掉这里的一切，返回卡达斯。你从未质疑过这一点。"
  },
  Event_125723_Name = {
    Text = "酒中倒影"
  },
  Event_125724_ChoiceDesc1 = {
    Text = "【赌一把】感染「(Skill.Arg1)」，进入赌局"
  },
  Event_125724_ChoiceDesc2 = {
    Text = "【还是算了】获得25黑印"
  },
  Event_125724_Desc = {
    Text = "在小巷的街角，一双肮脏的手拦住了你。\n一个衣衫褴褛的乞丐悄悄凑近你，眼神贪婪得如同看到腐肉的鬣狗。\n「来！来一把！我会告诉你你想知道的全部！只要你赢下来……」"
  },
  Event_125724_Name = {
    Text = "街头赌局"
  },
  Event_125725_ChoiceDesc1 = {
    Text = "【无视】删除1张指令卡，获得25黑印"
  },
  Event_125725_ChoiceDesc2 = {
    Text = "【阅读】复制一张牌库中的牌，感染「(Skill.Arg1)」"
  },
  Event_125725_Desc = {
    Text = "嗒嗒嗒，嗒嗒嗒……\n酒吧的角落空无一人，传真电报机清脆地响着，如同一支优美的钢琴曲。"
  },
  Event_125725_Name = {
    Text = "维度电报"
  },
  Event_125726_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125726_Desc = {
    Text = "「闭嘴，我是一只猫，我不想听你们那些愚蠢的故事。」\n黑猫叹了口气，转过身去。\n「离开这里吧。下次不要再做这种蠢事了。」"
  },
  Event_125726_Name = {
    Text = "幻化易形"
  },
  Event_125727_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125727_Desc = {
    Text = "她说的或许没错，那就是你，是你内心深处最隐晦最肮脏的想法。\n每个人都是自私的，你从未如他人所想的那样高尚。\n你品尝着那卑劣的痛苦。你知道过去的已经过去，而你的救赎就在前方。"
  },
  Event_125727_Name = {
    Text = "苦痛蔓延"
  },
  Event_125728_ChoiceDesc1 = {
    Text = "【与她讨论】删除1张指令卡，获得Arg1黑印"
  },
  Event_125728_ChoiceDesc2 = {
    Text = "【沉默不语】"
  },
  Event_125728_Desc = {
    Text = "「壮烈的结局是多么真实，可我们的现实已如此凄惨，就连在故事里，我们也无法给她一个美好的归宿吗……」\n剧作者闭目沉思。她对这个结局并不满意。"
  },
  Event_125728_Name = {
    Text = "剧作的结局"
  },
  Event_125729_ChoiceDesc1 = {
    Text = "【离开】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_125729_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「为什么……为什么永远没有人能够赢下来！……」"
  },
  Event_125729_Name = {
    Text = "街头赌局"
  },
  Event_125730_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125730_Desc = {
    Text = "你尽力靠近它，认真地倾听它。\n蝴蝶扇动翅膀，离开了你的掌心。\n你什么也没有听见。"
  },
  Event_125730_Name = {
    Text = "蝴蝶的小憩"
  },
  Event_125731_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125731_Desc = {
    Text = "面对你的驱赶，蝴蝶无动于衷。\n它执着地追逐着你的手掌，在你最后一次挥动手臂时，它终于选择离开。\n你有些后悔。或许，你该听听它的话？"
  },
  Event_125731_Name = {
    Text = "蝴蝶的小憩"
  },
  Event_125732_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125732_Desc = {
    Text = "黑色的烟雾失落地抖动，乞丐痛苦的哭喊声嘶力竭。\n骰子与乞丐在你一次眨眼后消失不见。破旧的礼帽中，留下了游戏的奖励。"
  },
  Event_125732_Name = {
    Text = "街头赌局"
  },
  Event_125733_ChoiceDesc1 = {
    Text = "【加入狂欢】感染「(Skill.Arg1)」，获得诅咒造物-「(RelicConfig.Arg2)」"
  },
  Event_125733_ChoiceDesc2 = {
    Text = "【阻止奏乐】选择销毁1个造物，获得1个奖励"
  },
  Event_125733_ChoiceDesc3 = {
    Text = "【捂住耳朵】获得50黑印"
  },
  Event_125733_Desc = {
    Text = "「啊！音乐！伟大的剧目怎么能没有音乐！！」\n不谐的交响在破碎的剧院响起，如同一场混沌的狂欢。来自渊狱的演员们在这无序的颂歌中舞蹈、欢呼，那是他们赖以为生的音符。"
  },
  Event_125733_Name = {
    Text = "命运颂歌"
  },
  Event_125734_ChoiceDesc1 = {
    Text = "【获得100黑印】"
  },
  Event_125734_ChoiceDesc2 = {
    Text = "【随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_125734_Desc = {
    Text = "无形的命运丝线在音符中起舞，在那杂乱的声音中，你渐渐抓到了那道迷人的旋律——没错，那正是命运应有的声音。\n渊狱的遗弃者们向你欢呼，他们簇拥着你，将你带入他们无序的狂欢。\n恭喜你，幸运的观众！现在，你将与演员们一起向命运谢幕。"
  },
  Event_125734_Name = {
    Text = "命运颂歌"
  },
  Event_125735_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125735_Desc = {
    Text = "你无法辨识这声音的意义，但你知道，它必须停下。\n银光如同发疯的利刃般挥砍，那节奏竟和音符万般契合。\n在你反应过来时，音符不知从何时便已停下。你再也听不见任何声音。你看到的唯有黑夜，你听到的唯有寂静。\n无序的嘈杂与绝对的寂静，究竟哪个更可怕呢……守密人？"
  },
  Event_125735_Name = {
    Text = "命运颂歌"
  },
  Event_125736_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125736_Desc = {
    Text = "你伸出手，一只蝴蝶轻轻停在你的手上。\n没错。死亡，消散，流逝……蝴蝶于茧中诞生，痛苦是艺术永恒的土壤。\n作为一个优秀的观众，这是你不得不明白的真理。"
  },
  Event_125736_Name = {
    Text = "于消散中绽放"
  },
  Event_125737_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125737_Desc = {
    Text = "这或许又是涅芙蕾亚的什么把戏。\n蝴蝶听懂了你的话，黑暗中响起它无声的叹息。流淌着漆黑粘液的翅膀震动，很快，蝴蝶沉重的身影淹没在无垠的黑暗里。\n你再也无法得知它想告知你的话语。"
  },
  Event_125737_Name = {
    Text = "蝴蝶的余生"
  },
  Event_125738_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_125738_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「为什么……为什么永远没有人能够赢下来！……」"
  },
  Event_125738_Name = {
    Text = "街头赌局"
  },
  Event_125739_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125739_Desc = {
    Text = "现在任凭思绪胡乱涌动是危险的。你摇了摇头，赶紧浮出了水面……"
  },
  Event_125739_Name = {Text = "宁静"},
  Event_125740_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125740_Desc = {
    Text = "并非所有的音符都需要听众，并非所有的命运都需要答案。\n你紧紧捂住耳朵，离开了这座嘈杂的舞台。\n你仍会好奇那不谐乐声的意义，但你知道，你做了唯一正确的抉择。"
  },
  Event_125740_Name = {
    Text = "命运颂歌"
  },
  Event_125741_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125741_Desc = {
    Text = "银光刺破幻影，黑猫们化作一滩滩黑色的粘液。\n想幻化成黑猫来躲避，可逃不过你的眼睛。"
  },
  Event_125741_Name = {
    Text = "幻化易形"
  },
  Event_125742_ChoiceDesc1 = {
    Text = "【接受命运】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125742_Desc = {
    Text = "「没有人能真正反抗命运，亲爱的。我们从来就没有选择的权利。」\n女声变得失落、遥远。你不确定，她想要对话的是你，还是另外的什么东西。"
  },
  Event_125742_Name = {
    Text = "宿命囚笼"
  },
  Event_125743_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_125743_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_125743_Desc = {
    Text = "「木偶们排队入场，踏入命运的巨网。」"
  },
  Event_125743_Name = {
    Text = "最后的预言"
  },
  Event_125744_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125744_Desc = {
    Text = "你抬头仰望那涡流般的深渊，试图倾听鸦群的神谕。\n但鸦群什么也没有说。在你的注视下，深渊消散。\n鸦群消失在舞台的尽头，那个你将要去往的地方。"
  },
  Event_125744_Name = {
    Text = "群鸦深渊"
  },
  Event_125745_ChoiceDesc1 = {
    Text = "【赞同蝴蝶】删除2张卡牌"
  },
  Event_125745_ChoiceDesc2 = {
    Text = "【反对蝴蝶】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125745_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_125745_Desc = {
    Text = "舞台的帷幕在风中翕动，在尸体落下的黑色粘液中，你看到了一群蝴蝶。\n「真正的艺术，总是于消散中绽放……对吧，守密人？」\n舞者的尸体正向你微笑。你听见蝴蝶振翅的声音。"
  },
  Event_125745_Name = {
    Text = "于消散中绽放"
  },
  Event_125746_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125746_Desc = {
    Text = "诡辩永远无法干扰你，你清晰地知道自己正走在一条什么样的道路，知道自己的终点是在何方。\n荆棘在你的体内消散。你踏上道路，一如往日。"
  },
  Event_125746_Name = {
    Text = "苦痛蔓延"
  },
  Event_125747_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125747_Desc = {
    Text = "你转过身去，尝试忘记身后那些眼睛。但你发现自己的身体似乎难以像往常那样控制。\n你知道，那些凝望的目光，你永远无法逃离。"
  },
  Event_125747_Name = {Text = "观众"},
  Event_125748_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125748_Desc = {
    Text = "无论是出于尊重还是畏惧，你都不愿轻易触碰，将信封放回原处。在你准备离开的时候，一道浑浊但温和的声音从信封后的黑暗中响起。\n「谢谢您还记得我，阿拉克涅小姐……」"
  },
  Event_125748_Name = {
    Text = "晚安，埃德加先生"
  },
  Event_125749_ChoiceDesc1 = {
    Text = "【守护的力量】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc2 = {
    Text = "【逃离的自由】随机1张卡牌获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125749_ChoiceDesc3 = {
    Text = "【拒绝回答】获得50黑印"
  },
  Event_125749_Desc = {
    Text = "午夜假面的酒精爬进你的脑袋，如同锁链般束缚住你。顺着冰冷的链条，年轻女性的声音在你脑海中萦绕。\n「告诉我，亲爱的。你想要的命运，究竟是什么？」"
  },
  Event_125749_Name = {
    Text = "命运之锁"
  },
  Event_125750_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125750_Desc = {
    Text = "即便再复杂的事务，也需要由你们来解决。\n感到愈发沉重的同时，你也感受到了新的力量。"
  },
  Event_125750_Name = {Text = "宁静"},
  Event_125751_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125751_Desc = {
    Text = "不知名的演员，危险的舞步。没错，逃离总是最保险的。\n你转身奔跑，拉开剧场的帷幕，然后，你站在了舞台上。木偶拉起你的手，跳起欢快的舞。\n命运的舞台，从来没有选择。"
  },
  Event_125751_Name = {Text = "三人舞"},
  Event_125752_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125752_Desc = {
    Text = "现在可不是去看一部电影的时候。"
  },
  Event_125752_Name = {
    Text = "记忆影厅"
  },
  Event_125753_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125753_Desc = {
    Text = "路途上的危险丝毫没有进入你的脑海。你走过身侧崩毁的命运，继续靠近涅芙蕾亚。\n你来到这里，是为了将解脱带给她。"
  },
  Event_125753_Name = {
    Text = "命运之网谢幕"
  },
  Event_125754_ChoiceDesc1 = {
    Text = "【阅读信封】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125754_ChoiceDesc2 = {
    Text = "【阅读信件】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125754_ChoiceDesc3 = {
    Text = "【放回原处】获得50黑印"
  },
  Event_125754_Desc = {
    Text = "你们的动作将密密麻麻的蛛网扯碎，一封陈旧的信件从蛛网里掉落下来。\n它的分量远比薄薄的纸张沉重。"
  },
  Event_125754_Name = {
    Text = "晚安，埃德加先生"
  },
  Event_125755_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125755_Desc = {
    Text = "乌鸦的眼中落出泪水。乌鸦的嘴角流淌鲜血。乌鸦用尽全部的生命，为你唱出它最后的预言。"
  },
  Event_125755_Name = {
    Text = "最后的预言"
  },
  Event_125756_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125756_Desc = {
    Text = "「呵呵……哈哈哈哈！」\n「怎么样，我的客人？命运的味道，你会疯狂地想念的……」"
  },
  Event_125756_Name = {
    Text = "命运的味道"
  },
  Event_125757_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125757_Desc = {
    Text = "「无趣。」女声打了一个慵懒的哈欠。\n「带上你的力量，去俱乐部参加搏击去吧。」"
  },
  Event_125757_Name = {
    Text = "命运之锁"
  },
  Event_125758_ChoiceDesc1 = {
    Text = "【稳定命运之网】获得3选1高级刻印"
  },
  Event_125758_ChoiceDesc2 = {
    Text = "【无视危险】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125758_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_125758_Desc = {
    Text = "她是美好的宠儿。她是命运的弃婴。她是循着黯淡光点、自深渊爬出的复仇者。她来到这里，为一切带来解脱。\n命运之网在你们身周崩塌倾毁。你站在剧院的舞台，与涅芙蕾亚隔着并不遥远的距离。"
  },
  Event_125758_Name = {
    Text = "命运之网谢幕"
  },
  Event_125759_ChoiceDesc1 = {
    Text = "【不明所以】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_125759_ChoiceDesc2 = {
    Text = "【感同身受】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125759_Desc = {
    Text = "舞台上传来撕心裂肺的哭喊，唯一的灯光落在孤独的身影上。\n他正为你献上他最诚挚的表演——将他的腑脏剖开，呈给每一位观众看。\n是什么让这个角色如此痛苦？"
  },
  Event_125759_Name = {
    Text = "演员的剖白"
  },
  Event_125760_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125760_Desc = {
    Text = "你的手伸向右边。\n那是你的未来，你最强烈的渴盼，你的归宿，你将要抵达的地方。\n你的存在，是为了追逐前方的太阳。"
  },
  Event_125760_Name = {
    Text = "过去，未来"
  },
  Event_125761_ChoiceDesc1 = {
    Text = "【三点】"
  },
  Event_125761_ChoiceDesc2 = {
    Text = "【六点】"
  },
  Event_125761_ChoiceDesc3 = {
    Text = "【一点】"
  },
  Event_125761_Desc = {
    Text = "你当然可以直接离开，但那枚精巧的骰子彻底吸引了你。\n你忘记了身后的追兵，将它虔诚地拿起，扔进礼帽里——"
  },
  Event_125761_Name = {
    Text = "街头赌局"
  },
  Event_125762_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_125762_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「为什么……为什么永远没有人能够赢下来！……」"
  },
  Event_125762_Name = {
    Text = "街头赌局"
  },
  Event_125763_ChoiceDesc1 = {
    Text = "【接受命运】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125763_ChoiceDesc2 = {
    Text = "【反抗命运】感染「(Skill.Arg1)」，再次随机刻印"
  },
  Event_125763_Desc = {
    Text = "「啊，淘气鬼。命运总是仁慈的……但所有的反抗都有代价。现在，你愿意接受它吗？」"
  },
  Event_125763_Name = {
    Text = "宿命囚笼"
  },
  Event_125764_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125764_Desc = {
    Text = "你环顾着那些目光，向它们挥手致意。\n很快，你便会将故事的高潮赐予它们。"
  },
  Event_125764_Name = {Text = "观众"},
  Event_125765_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125765_Desc = {
    Text = "「亲爱的阿拉克涅小姐，今天是您出生的日子，我为老爷与夫人、也为您感到喜悦。欢迎您来到这个美丽的世界。我将这首温柔的安眠曲献予您，愿您从诞生的这一天起，度过无忧无虑的一生……」"
  },
  Event_125765_Name = {
    Text = "晚安，埃德加先生"
  },
  Event_125766_ChoiceDesc1 = {
    Text = "【拍摄照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125766_ChoiceDesc2 = {
    Text = "【再次更换】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，还可以使用一次"
  },
  Event_125766_Desc = {
    Text = "面对镜头你有些惶恐。或许这个姿势拍出来会更好？或许那个？"
  },
  Event_125766_Name = {
    Text = "观众席的留影"
  },
  Event_125767_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125767_Desc = {
    Text = "你想要看看上面的内容，可幕布上什么也没有，放映厅里只回荡着胶片转动的声音。\n或许要很久之后，你才能有机会知晓胶片中的内容了。"
  },
  Event_125767_Name = {
    Text = "记忆影厅"
  },
  Event_125768_ChoiceDesc1 = {
    Text = "【回避目光】随机觉醒1名唤醒体"
  },
  Event_125768_ChoiceDesc2 = {
    Text = "【直视目光】选择觉醒1名唤醒体，并降低其觉醒卡算力消耗2点。感染「(Skill.Arg1)」"
  },
  Event_125768_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_125768_Desc = {
    Text = "踏上舞台的时候，你听到一阵窃窃私语。你回过头去，一万名观众的眼睛浮在舞台的四周，凝望着你。\n来呀！它们说。精彩的戏剧，莫非就停在这里？\n跳吧！它们说。为我们带来这舞曲的高潮！"
  },
  Event_125768_Name = {Text = "观众"},
  Event_125769_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125769_Desc = {
    Text = "你不理解他的痛苦，也不需要理解。\n剧场有如此多的舞台，舞台上有如此多的木偶，你也不过是其中之一。\n你还有更重要的事情要做。"
  },
  Event_125769_Name = {
    Text = "演员的剖白"
  },
  Event_125770_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125770_Desc = {
    Text = "死亡，消散，流逝……艺术不是为了带来痛苦而存在的。如果美只存在于痛苦，那这样的美不要也罢。\n你奋力地驱赶着。蝴蝶散去，留下一具悲伤的尸体。"
  },
  Event_125770_Name = {
    Text = "于消散中绽放"
  },
  Event_125771_ChoiceDesc1 = {
    Text = "【聆听歌唱】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_125771_ChoiceDesc2 = {
    Text = "【放任不管】获得25黑印，离开"
  },
  Event_125771_Desc = {
    Text = "曾经与你相遇过的鸦群汇集成同一只。它站在你的身前对你歌唱，歌声凄凉，如同最后的预言。"
  },
  Event_125771_Name = {
    Text = "最后的预言"
  },
  Event_125772_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125772_Desc = {
    Text = "你的手伸向左边。\n那是你的过去，你最珍贵的回忆，你来时的路，你将要回归的地方。\n过去的一切，构成了你的全部。"
  },
  Event_125772_Name = {
    Text = "过去，未来"
  },
  Event_125773_ChoiceDesc1 = {
    Text = "【拍摄照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125773_Desc = {
    Text = "面对镜头你有些惶恐。或许这个姿势拍出来会更好？或许那个？\n你仍在犹豫，可你看出来，相机已经很不耐烦了。"
  },
  Event_125773_Name = {
    Text = "观众席的留影"
  },
  Event_125774_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125774_Desc = {
    Text = "你摆好姿势，站在相机面前。端正，好奇，投入，如同一位真正的观众。\n咕嘟——\n相机按下快门，黑色的粘浆从机身里炸开，喷溅在整座舞台。\n相机的尸体中央，胶卷上空无一物。"
  },
  Event_125774_Name = {
    Text = "观众席的留影"
  },
  Event_125775_ChoiceDesc1 = {
    Text = "【接受】获得3选1白银造物"
  },
  Event_125775_ChoiceDesc2 = {
    Text = "【逃离】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_125775_Desc = {
    Text = "哒哒，哒哒……鞋跟与木板碰撞，发出愉悦的脆响。\n两个穿着学生制服的木偶正在舞台上跳舞。忽然，他们停下了舞步，转身向你伸出手来。"
  },
  Event_125775_Name = {Text = "三人舞"},
  Event_125776_ChoiceDesc1 = {
    Text = "【忍受痛苦】提高 Arg1 点最大生命"
  },
  Event_125776_ChoiceDesc2 = {
    Text = "【反驳痛苦】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染1张「(Skill.Arg2)」"
  },
  Event_125776_Desc = {
    Text = "「你从未在意过莉兹的死。你从未在意过任何人。」\n「你在意的只有自己……你身边的所有人，都只是你通往自由与平静的工具。」\n「不是吗……守密人？」\n报幕人的窃语在你耳边响起。你的心脏揪紧，收缩，强烈的痛苦随着她的话语在你的身体里蔓延……"
  },
  Event_125776_Name = {
    Text = "苦痛蔓延"
  },
  Event_125777_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125777_Desc = {
    Text = "放纵意识的下坠吧，海水自有浮力，命运将向你们指明一切的道路。"
  },
  Event_125777_Name = {Text = "宁静"},
  Event_125778_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125778_Desc = {
    Text = "那是你自己。力量的来源，职责的担负者，唯一忠诚的对象。\n你走在那条只属于你的道路上。"
  },
  Event_125778_Name = {
    Text = "酒中倒影"
  },
  Event_125779_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125779_Desc = {
    Text = "「真是遗憾，我的客人。命运的味道，你再也没有机会品尝了……」"
  },
  Event_125779_Name = {
    Text = "命运的味道"
  },
  Event_125780_ChoiceDesc1 = {
    Text = "【与她讨论】删除1张指令卡，获得Arg1黑印"
  },
  Event_125780_ChoiceDesc2 = {
    Text = "【沉默不语】"
  },
  Event_125780_Desc = {
    Text = "「这真是一出令人难过的戏剧……那可怜的女孩，是被自己所眷恋之人抛弃了吗，姐姐？」\n在这道熟悉的声音里，你没有听到任何的疯狂与仇恨。那道声音清澈，哀伤，如同林地里那道温柔的溪流。\n「那位歌唱者，一片无力飘荡的枯叶，只能任凭命运摧残……多么可怜的人啊……」\n「你说，如果我是那位执笔者……我应该为她书写一个怎样的结局呢？」"
  },
  Event_125780_Name = {
    Text = "剧作的结局"
  },
  Event_125781_ChoiceDesc1 = {
    Text = "【抚摸】50%概率获得125黑印，50%概率感染「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc2 = {
    Text = "【解释】75%概率获得100黑印，25%概率感染「(Skill.Arg2)」"
  },
  Event_125781_ChoiceDesc3 = {
    Text = "【破解】获得50黑印"
  },
  Event_125781_Desc = {
    Text = "你追向酒吧的后街时，怪物的身影消失不见，一群黑猫拦在你的身前。\n「 喂，你。」一只黑猫舔了舔自己的爪子，向你望来。\n「 你来我们的地方做什么？」"
  },
  Event_125781_Name = {
    Text = "幻化易形"
  },
  Event_125782_ChoiceDesc1 = {
    Text = "【拥抱过去】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125782_ChoiceDesc2 = {
    Text = "【迎接未来】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_125782_ChoiceDesc3 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_125782_Desc = {
    Text = "涅芙蕾亚的出现干扰了丝线。紊乱的命运中，你看到两道模糊的幻影。\n那是你的过去，那是你的未来。你走向它们，伸出了手……"
  },
  Event_125782_Name = {
    Text = "过去，未来"
  },
  Event_125855_ChoiceDesc1 = {
    Text = "【感知】选择1个造物变化为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_125855_ChoiceDesc2 = {
    Text = "【凝视】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125855_ChoiceDesc3 = {
    Text = "【无视】获得25黑印"
  },
  Event_125855_Desc = {
    Text = "卡萨利姆的街头，一家水晶店耀目的光芒吸引了你。你来到店铺前，拾起一块银芯形状的水晶。"
  },
  Event_125855_Name = {
    Text = "水晶的秘密"
  },
  Event_125856_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125856_Desc = {
    Text = "你闭上眼，仔细感知着它。\n一道微光在你的意识中闪烁，它想要告诉你些什么……"
  },
  Event_125856_Name = {
    Text = "水晶的秘密"
  },
  Event_125857_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125857_Desc = {
    Text = "任何对命运的反抗与窥探都是徒劳的。你静静闭上眼，任凭命运把你带往你将去到的地方。"
  },
  Event_125857_Name = {
    Text = "缚命之网"
  },
  Event_125858_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125858_Desc = {
    Text = "「情感是存续的意义。但愿你不会为自己的选择后悔。」"
  },
  Event_125858_Name = {
    Text = "选择的代价"
  },
  Event_125859_ChoiceDesc1 = {
    Text = "【情感】回复 Arg1 点生命"
  },
  Event_125859_ChoiceDesc2 = {
    Text = "【理智】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_125859_ChoiceDesc3 = {
    Text = "【拒绝选择】获得25黑印"
  },
  Event_125859_Desc = {
    Text = "一座天平出现在舞台。\n「大脑与心脏，理智与情感，灰与红……我们无法逃避选择，这是我们的命运。」\n「舞台的终点已经划定。现在，为这个舞台选择它将走过的道路吧。」"
  },
  Event_125859_Name = {
    Text = "选择的代价"
  },
  Event_125860_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125860_Desc = {
    Text = "「不要抬头。离开这里。」\n你听见了命运的声音。你无比渴望望向天空，但你知道，她是对的。"
  },
  Event_125860_Name = {Text = "仰望"},
  Event_125861_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125861_Desc = {
    Text = "你永不接受命运。你永不接受囚禁。\n你奋力挣扎，在献祭了一块飞蛾的肢体后，你终于得以逃离……"
  },
  Event_125861_Name = {
    Text = "缚命之网"
  },
  Event_125862_ChoiceDesc1 = {
    Text = "【友谊】获得50黑印"
  },
  Event_125862_ChoiceDesc2 = {
    Text = "【帮助】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_125862_Desc = {
    Text = "酒吧的后街，你再次遇到了那些黑猫。\n「我听说了。那些黑色的粘液化成我们的样子，给你添了不少麻烦。」\n「作为赔礼，告诉我吧，你想要什么？」\n黑猫在你的腿边绕了两圈，抬头望向你。"
  },
  Event_125862_Name = {
    Text = "初见赠礼"
  },
  Event_125863_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125863_Desc = {
    Text = "蛮力无法破解命运，但或许智慧可以？\n你仔细观察着这张网，试图从中窥视出一些命运的轨迹……"
  },
  Event_125863_Name = {
    Text = "缚命之网"
  },
  Event_125864_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125864_Desc = {
    Text = "你凑过去，仔细地凝视着它。\n一道微光在你的眼中闪烁，它想要告诉你些什么……"
  },
  Event_125864_Name = {
    Text = "水晶的秘密"
  },
  Event_125865_ChoiceDesc1 = {
    Text = "【挣扎】从牌库中随机获取3张指令卡，选择1张卡进行删除，获得75黑印"
  },
  Event_125865_ChoiceDesc2 = {
    Text = "【思考】从牌库中随机获取3张指令卡，选择1张卡的原始复制进入牌库，获得25黑印"
  },
  Event_125865_ChoiceDesc3 = {
    Text = "【歇息】获得50黑印"
  },
  Event_125865_Desc = {
    Text = "一股熟悉的感觉向你袭来，不同的是，那种黏腻的触感、无力反抗的直觉，比上次更加强烈，更加致命。\n飞蛾坠入蛛网，而你也已踏入舞台。"
  },
  Event_125865_Name = {
    Text = "缚命之网"
  },
  Event_125866_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125866_Desc = {
    Text = "「理智是存续的手段。但愿你不会为自己的选择后悔。」"
  },
  Event_125866_Name = {
    Text = "选择的代价"
  },
  Event_125867_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125867_Desc = {
    Text = "好奇心被点燃。你来到人群中，像他们一样抬起头来。\n那里什么都没有，但不知道为什么，你就是不愿意将目光放下。你想就这样望着，一直望着……"
  },
  Event_125867_Name = {Text = "仰望"},
  Event_125868_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125868_Desc = {
    Text = "「放弃选择也是一种选择，这是命运的诅咒。但愿你不会为自己的选择后悔。」"
  },
  Event_125868_Name = {
    Text = "选择的代价"
  },
  Event_125869_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125869_Desc = {
    Text = "「现在，你已经拥有它了。」\n黑猫蹭了蹭你的小腿，很快消失不见。\n在它们消失之处，一份礼物在等待着你。"
  },
  Event_125869_Name = {
    Text = "初见赠礼"
  },
  Event_125870_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_125870_Desc = {
    Text = "「现在，你已经拥有它了。」\n黑猫蹭了蹭你的小腿，很快消失不见。\n在它们消失之处，一份礼物在等待着你。"
  },
  Event_125870_Name = {
    Text = "初见赠礼"
  },
  Event_125871_ChoiceDesc1 = {
    Text = "【抬头】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_125871_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_125871_Desc = {
    Text = "嘈杂的声音短暂地消失了。街头的人群陷入沉默，抬头望向天空。"
  },
  Event_125871_Name = {Text = "仰望"},
  Event_129176_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129176_Name = {
    Text = "忘却第1章@"
  },
  Event_129177_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129177_Name = {
    Text = "星辰第1章@"
  },
  Event_129178_ChoiceDesc1 = {
    Text = "【指示方向】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129178_ChoiceDesc2 = {
    Text = "【一同祷告】获得3选1刻印，重复 2 次"
  },
  Event_129178_Desc = {
    Text = "钢琴和管风琴的声音在灰暗的风中交织。仿佛有魔力的旋律飘荡在无人的街巷。\n一位无名的修女在琴声中祷告。\n「简单的祷告无需隆重的典仪，伟大的父神会为我们播撒希望，正如他曾赐予我们虔诚的教导。」"
  },
  Event_129178_Name = {
    Text = "管风琴的祷告"
  },
  Event_129179_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129179_Name = {
    Text = "星辰第1章@"
  },
  Event_129180_ChoiceDesc1 = {
    Text = "【主动迎战】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129180_ChoiceDesc2 = {
    Text = "【放弃抵抗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129180_ChoiceDesc3 = {
    Text = "【赶紧开溜】获得50黑印"
  },
  Event_129180_Desc = {
    Text = "几个蜡像泥坯挡住了你的去路。\n它们歪歪扭扭，面容粗粝，望之不似罗杰斯应有的制作水准。\n「命令……大人的命令……」"
  },
  Event_129180_Name = {Text = "习作"},
  Event_129181_ChoiceDesc1 = {
    Text = "【放弃思考】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129181_ChoiceDesc2 = {
    Text = "【追上灵感】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129181_Desc = {
    Text = "港口遇袭，有来无回的神秘货轮和有鳍的「新朋友」……这是精心筹备的陷阱吗？还是又一场意外频发的旅行？\n现实与理智互相拉扯纠缠，无数的灵感与念头从脑海喷涌而出。"
  },
  Event_129181_Name = {
    Text = "灵感迸发"
  },
  Event_129182_ChoiceDesc1 = {
    Text = "【加入】感染「(Skill.Arg1)」，重复 2 次，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」，重复 2 次"
  },
  Event_129182_ChoiceDesc2 = {
    Text = "【驱赶】感染「(Skill.Arg1)」，重复 2 次，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」，重复 2 次"
  },
  Event_129182_ChoiceDesc3 = {
    Text = "【漠视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129182_Desc = {
    Text = "你听到远处若隐若现的骨螺号角声。\n鼠群循声从黑泥中涌现，啃噬着干枯河床上躺着的无名尸体。\n它们围成一个圆，圆心是那具已然空洞的遗体，圆周则是一个以遗忘为法律的新王国。\n而你，正站在这个王国的入口。"
  },
  Event_129182_Name = {
    Text = "流放王国"
  },
  Event_129183_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129183_Name = {
    Text = "忘却第5章@"
  },
  Event_129184_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129184_Name = {
    Text = "忘却第8章@"
  },
  Event_129185_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129185_Name = {
    Text = "忘却第1章@"
  },
  Event_129186_ChoiceDesc1 = {
    Text = "【解救肖像】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129186_ChoiceDesc2 = {
    Text = "【接受空白】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129186_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129186_Desc = {
    Text = "你站在皮克曼的赠礼面前。\n那是一幅肖像画，由鲜血绘就，漆黑的火焰安静地燃烧着。\n透过画中人空洞的眼眶，你看到——\n你的记忆正翻涌燃烧，拉长、扭曲、发光，仿佛某种无形之火正舔舐你脑中的回廊。恍惚间你听见一道人声。\n「该下锅了，这火候正好。」\n这正是你自己绘出的记忆之景，你在火焰中挣扎变形。"
  },
  Event_129186_Name = {
    Text = "燃烧肖像"
  },
  Event_129187_ChoiceDesc1 = {
    Text = "【您愿意付出怎样的代价呢？】随机提升1张卡牌的刻印品质，重复 2 次"
  },
  Event_129187_ChoiceDesc2 = {
    Text = "【请他们喝一杯过期的血腥玛丽吧】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129187_Desc = {
    Text = "「欢迎光临，我珍贵的客人。尽情挑选吧，这满目琳琅皆为等候你而存在。」\n「额，打扰了，请问您是……达芙黛尔女士的孪生姐妹吗？」\n「我即是达芙黛尔本人，请问客人您今日到此，有何贵干……？」\n「抱歉抱歉，您比之前更有风韵了，我竟没认出。您还记得吗？二十年前，您替我的酒吧赶走了一个怪胎……昨天，噩梦重现了，它占领了酒吧，带着它的同胞们，成群结队地……」"
  },
  Event_129187_Name = {
    Text = "回忆碎片·旧梦重现"
  },
  Event_129188_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129188_Name = {
    Text = "星辰第3章@"
  },
  Event_129189_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129189_Name = {
    Text = "忘却第8章@"
  },
  Event_129190_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129190_Name = {
    Text = "忘却第1章@"
  },
  Event_129191_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129191_Name = {
    Text = "忘却第6章@"
  },
  Event_129192_ChoiceDesc1 = {
    Text = "【握紧火种】提高 Arg1 点最大生命"
  },
  Event_129192_ChoiceDesc2 = {
    Text = "【直面内心】随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染2张「(Skill.Arg2)」，重复 2 次"
  },
  Event_129192_Desc = {
    Text = "在这场声势浩大的狩猎中，戈利亚的追逐如幽夜中的猛兽，企图吞噬一切希望的光。然而，这无情的追逐并未将你冻结，反而点燃了内心深处的火种，它在胸膛里蔓延、燃烧，变得越来越炽热。"
  },
  Event_129192_Name = {Text = "逐光"},
  Event_129193_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129193_Name = {
    Text = "忘却第6章@"
  },
  Event_129194_ChoiceDesc1 = {
    Text = "【阅读前人的路】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129194_ChoiceDesc2 = {
    Text = "【书写自己的路】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129194_ChoiceDesc3 = {
    Text = "【目视黑暗】获得25黑印"
  },
  Event_129194_Desc = {
    Text = "如果你是一个人在密境中摸索前进，一定不会像现在这般笃定自己的前路。\n密境中的足迹分为了三条，印下的每道足印，都书写着不可见的未来。"
  },
  Event_129194_Name = {Text = "出路"},
  Event_129195_ChoiceDesc1 = {
    Text = "【指出错误】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129195_ChoiceDesc2 = {
    Text = "【听完弹奏】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_129195_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_129195_Desc = {
    Text = "男孩蜡像坐在钢琴前弹奏练习曲。\n他的老师——同样也是蜡像做的，正在一旁指导。\n133，355，244……\n错了，每个音都错了。"
  },
  Event_129195_Name = {Text = "钢琴课"},
  Event_129196_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129196_Name = {
    Text = "忘却第5章@"
  },
  Event_129197_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129197_Name = {
    Text = "星辰第4章@"
  },
  Event_129198_ChoiceDesc1 = {
    Text = "【聆听悲伤】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129198_ChoiceDesc2 = {
    Text = "【聆听喜悦】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_129198_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印，重复 2 次"
  },
  Event_129198_Desc = {
    Text = "悠扬、抒情、欢欣、哀伤……曲调在密境空间回荡，难以辨别其来源。\n这是幽灵船音响流淌出的奏鸣曲，还是被束缚在密境中的夜半狂想？"
  },
  Event_129198_Name = {
    Text = "无名之音"
  },
  Event_129199_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129199_Name = {
    Text = "星辰第1章@"
  },
  Event_129200_ChoiceDesc1 = {
    Text = "【打开信封】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129200_ChoiceDesc2 = {
    Text = "【阅读】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129200_ChoiceDesc3 = {
    Text = "【放回原处】获得50黑印"
  },
  Event_129200_Desc = {
    Text = "无人关注的角落里，遗落了一封信件。\n信件上的许多字迹已经无法辨认，但唯有一个词。力透纸背。\n那个词是「母亲」。"
  },
  Event_129200_Name = {
    Text = "消逝的思念"
  },
  Event_129201_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129201_Name = {
    Text = "星辰第4章@"
  },
  Event_129202_ChoiceDesc1 = {
    Text = "【仔细聆听】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129202_ChoiceDesc2 = {
    Text = "【捂住耳朵】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_129202_ChoiceDesc3 = {
    Text = "【查看】获得3选1刻印，重复 2 次"
  },
  Event_129202_Desc = {
    Text = "你们进入遗骸所在的楼层时，空旷的废弃工厂内突兀地传来悦耳的叮咚之声，钢琴鸣奏的清泠之感与锈蚀的钢铁废墟格格不入。"
  },
  Event_129202_Name = {
    Text = "诡异音阶"
  },
  Event_129203_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129203_Name = {
    Text = "忘却第3章@"
  },
  Event_129204_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129204_Name = {
    Text = "忘却第6章@"
  },
  Event_129205_ChoiceDesc1 = {
    Text = "【放过她】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129205_ChoiceDesc2 = {
    Text = "【帮助她】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129205_ChoiceDesc3 = {
    Text = "【我要走自己的路】获得50黑印"
  },
  Event_129205_Desc = {
    Text = "三个人影拦住了你的去路。\n「你可以放过她，」双手抱着沾满融蚀浆的小熊玩偶的人影开口，「她只是胆怯，而不邪恶。她不想伤害任何人。」\n「你可以帮助她，」双手捧着一把包装精致的糖果的人影开口，「你能够做到她不能做到的事情，你能够结束这一切。」\n「你不需要听我们的，」双手空空如也的人影开口，「你有你自己的路。」"
  },
  Event_129205_Name = {
    Text = "分岔的小径"
  },
  Event_129206_ChoiceDesc1 = {
    Text = "【喂食老鼠】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_129206_ChoiceDesc2 = {
    Text = "【驱赶老鼠】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129206_ChoiceDesc3 = {
    Text = "【无视老鼠】获得25黑印"
  },
  Event_129206_Desc = {
    Text = "这艘船上的一切，都在轮回。\n那些在船上讨生活的，令人厌恶且长满肮脏绒毛的小东西们自然也无法避免这样的命运。\n一次又一次轮回中，它们吃所能看到的一切，却仍无法满足。\n「好……饿啊……」\n成群的老鼠们发出病态又刺耳的尖啸。\n一次次轮回令它们饥饿难忍，它们必须吃些什么。\n立刻，马上！"
  },
  Event_129206_Name = {
    Text = "饥饿的鼠群"
  },
  Event_129207_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129207_Name = {
    Text = "忘却第8章@"
  },
  Event_129208_ChoiceDesc1 = {
    Text = "【触摸大脑】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129208_ChoiceDesc2 = {
    Text = "【触摸心脏】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_129208_Desc = {
    Text = "你走入那间无人低语的灰厅，一架天平在黑雾中若隐若现。\n左边，是一枚沉静如湖的大脑，银白色的沟壑闪着微光；右边，是一颗火红色的、蒸腾着热气的心脏。\n忽然之间，你闻到一阵香气，饥渴的欲望不断膨胀，理智被祂无边的黑暗挤压。\n你伸出了手。"
  },
  Event_129208_Name = {
    Text = "饥饿游戏"
  },
  Event_129209_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129209_Name = {
    Text = "忘却第4章@"
  },
  Event_129210_ChoiceDesc1 = {
    Text = "【斩杀人影】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129210_ChoiceDesc2 = {
    Text = "【碾碎胚胎】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129210_ChoiceDesc3 = {
    Text = "【闭上双眼】获得25黑印"
  },
  Event_129210_Desc = {
    Text = "恍惚中你看到曾在亚兰见过的人们向你靠近。\n他们欢笑着邀请你饮酒、跳舞、品尝美食。\n然后他们的血肉层层剥落，掉落在地又蠕动着长出新的胚胎。\n他们向你伸出手，邀请你加入血肉与新生的狂欢。"
  },
  Event_129210_Name = {
    Text = "旧日的阴影"
  },
  Event_129211_ChoiceDesc1 = {
    Text = "【投喂他们】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_129211_ChoiceDesc2 = {
    Text = "【不做理会】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129211_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129211_Desc = {
    Text = "居住者来来去去，鼠群却长久绵延。\n和人类相比，它们才是这座古堡的「原住民」\n但它们对于人类的进驻没有异议。\n因为那些香软的、白嫩的丑东西，会投喂它们同样香软的、白嫩的丑东西。\n「而你，丑东西，属于哪一种？」"
  },
  Event_129211_Name = {
    Text = "古堡的秘密"
  },
  Event_129212_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129212_Name = {
    Text = "忘却第5章@"
  },
  Event_129213_ChoiceDesc1 = {
    Text = "【分辨男人的声音】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_129213_ChoiceDesc2 = {
    Text = "【分辨女人的声音】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129213_ChoiceDesc3 = {
    Text = "【分辨老人的声音】获得25黑印"
  },
  Event_129213_Desc = {
    Text = "你独自站立在一片黑暗沼泽中。\n朦胧间你听见混沌交错的呓语如潮水般涌来，有的来自耄耋之年的老人，有的来自牙牙学语的孩子，有些来自焦虑难耐的女人，有些来自恐惧莫名的男人……"
  },
  Event_129213_Name = {
    Text = "遗言呓语"
  },
  Event_129214_ChoiceDesc1 = {
    Text = "【仔细看看】获得3选1刻印，重复 2 次"
  },
  Event_129214_ChoiceDesc2 = {
    Text = "【撕下海报】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129214_Desc = {
    Text = "一个蜡像馆内随处可见的烛台。\n借着病态的橙光，你发现墙壁上张贴着一则手绘的海报。"
  },
  Event_129214_Name = {
    Text = "黑暗中的笑声"
  },
  Event_129215_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129215_Name = {
    Text = "忘却第4章@"
  },
  Event_129216_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129216_Name = {
    Text = "忘却第7章@"
  },
  Event_129217_ChoiceDesc1 = {
    Text = "【凝视】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129217_ChoiceDesc2 = {
    Text = "【无视】获得3选1刻印，重复 2 次"
  },
  Event_129217_Desc = {
    Text = "亚兰人在沙暴中跪伏。\n风暴抽打着他们的躯壳，砂砾席卷他们的虔心。\n沙尘的漩涡之中，似乎有无数只巨眼俯瞰着扭曲的大地。"
  },
  Event_129217_Name = {
    Text = "沙尘巨物"
  },
  Event_129218_ChoiceDesc1 = {
    Text = "【驱赶蝴蝶】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129218_ChoiceDesc2 = {
    Text = "【聆听心愿】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129218_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129218_Desc = {
    Text = "小小的蝴蝶，也有许多梦想。\n这些梦想散落在花海里、病房里、还有充满许多血肉的@2祭坛里。\n而今，它终于等到了羁绊之人，不知你是否愿意聆听它小小的、小小的心愿。"
  },
  Event_129218_Name = {
    Text = "蝴蝶的梦想"
  },
  Event_129219_ChoiceDesc1 = {
    Text = "【跟随指引】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129219_ChoiceDesc2 = {
    Text = "【无视指引】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129219_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129219_Desc = {
    Text = "祭典已经开始。\n在灵的焰火与血的祝祷下，数不清的信徒灵魂化作了航标——\n缥缈的灵分散在你的周围，犹如引路的精灵，闪着光等待你的选择。"
  },
  Event_129219_Name = {
    Text = "灵魂航标"
  },
  Event_129220_ChoiceDesc1 = {
    Text = "【无视铃声】获得3选1高级刻印，重复 2 次"
  },
  Event_129220_ChoiceDesc2 = {
    Text = "【拿起听筒】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129220_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_129220_Desc = {
    Text = "它本不该响起——那只电话，蜷缩在画布背后。\n听筒的线缠绕在大块头机身上，如同生锈的脐带，似乎从你的脑中延伸。\n你仔细辨别震动的频率，诡异的声响犹如皮克曼的超现实艺术。"
  },
  Event_129220_Name = {
    Text = "未接来电"
  },
  Event_129221_ChoiceDesc1 = {
    Text = "【我们一切平安】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129221_ChoiceDesc2 = {
    Text = "【你是谁？】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129221_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129221_Desc = {
    Text = "打字机突兀地喷出油墨，上面的惊叹号多得刺目。\n「朵尔你还好吗？？？为什么守密人消失了你也消失了！！！拜托平安的话回个消息！！！再等下去威廉的头发都要掉完了！！！」"
  },
  Event_129221_Name = {
    Text = "紧急通讯"
  },
  Event_129222_ChoiceDesc1 = {
    Text = "【切断红绸】删除1张指令卡，获得Arg1黑印"
  },
  Event_129222_ChoiceDesc2 = {
    Text = "【对抗】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_129222_ChoiceDesc3 = {
    Text = "【呼唤拉蒙娜】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129222_Desc = {
    Text = "卡茜亚甩出红绸，瞬间缠住了你的手提箱。"
  },
  Event_129222_Name = {
    Text = "绞缠之绸"
  },
  Event_129223_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129223_Name = {
    Text = "忘却第6章@"
  },
  Event_129224_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129224_Name = {
    Text = "星辰第3章@"
  },
  Event_129225_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129225_Name = {
    Text = "忘却第3章@"
  },
  Event_129226_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129226_Name = {
    Text = "忘却第4章@"
  },
  Event_129227_ChoiceDesc1 = {
    Text = "【挥手驱赶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129227_ChoiceDesc2 = {
    Text = "【任由停留】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129227_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129227_Desc = {
    Text = "黑暗里传来了轻微的声响。\n那是一只蝴蝶礼貌地问询。\n「我可以落在你的掌心吗？」\n「我只是太累了，想要休息一下……」\n如此问询着，蝴蝶穿越过黑暗，盘旋在你的面前。\n漆黑的粘液自它的翅膀滴落——那是蝴蝶穿越黑暗时，来自黑暗的馈赠。"
  },
  Event_129227_Name = {
    Text = "蝴蝶的请求"
  },
  Event_129228_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129228_Name = {
    Text = "忘却第7章@"
  },
  Event_129229_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129229_Name = {
    Text = "忘却第7章@"
  },
  Event_129230_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129230_Name = {
    Text = "忘却第1章@"
  },
  Event_129231_ChoiceDesc1 = {
    Text = "【辨认歌词】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129231_ChoiceDesc2 = {
    Text = "【轻轻哼唱】获得3选1刻印，重复 2 次"
  },
  Event_129231_Desc = {
    Text = "古老的船歌在密境中回荡。\n被密境困住的记忆用着你闻所未闻的语言，吟唱着海浪、天空与烈酒。"
  },
  Event_129231_Name = {
    Text = "海洋歌谣"
  },
  Event_129232_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129232_Name = {
    Text = "忘却第8章@"
  },
  Event_129233_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129233_Name = {
    Text = "星辰第1章@"
  },
  Event_129234_ChoiceDesc1 = {
    Text = "【割开手掌】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129234_ChoiceDesc2 = {
    Text = "【接受生长】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129234_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129234_Desc = {
    Text = "那只蝴蝶并非飞来，而是从你的掌心慢慢生长。\n你一开始以为只是汗水，却在指缝间看见黑色液体如血管反流般悄然渗出，凝结成冰冷而脉动的翅膀。\n每一次翕动，便在你的血液中激起涟漪。"
  },
  Event_129234_Name = {
    Text = "寄生上流"
  },
  Event_129235_ChoiceDesc1 = {
    Text = "【继续翻阅】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129235_ChoiceDesc2 = {
    Text = "【离开】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_129235_Desc = {
    Text = "一架用于称重的天平。\n在它的背后，无数器官浸泡在红色的福尔马林中。\n它们被整整齐齐地堆叠在储物架上。\n你顺手捡起一旁的笔记本翻阅：\n「心脏：8盎司，大脑：50盎司……」"
  },
  Event_129235_Name = {
    Text = "器官登记"
  },
  Event_129236_ChoiceDesc1 = {
    Text = "【绕路而行】删除1张指令卡，获得Arg1黑印"
  },
  Event_129236_ChoiceDesc2 = {
    Text = "【询问为何沉没】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_129236_ChoiceDesc3 = {
    Text = "【向船员问好】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129236_Desc = {
    Text = "行走在前往动力室的路上，你再次遇见了一些被固定在密境中的「记忆」。\n他们不是幽魂，只是埃尔顿船长对逝去船员的牵挂。"
  },
  Event_129236_Name = {
    Text = "索纳尼尔号的主人"
  },
  Event_129237_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129237_Name = {
    Text = "忘却第3章@"
  },
  Event_129238_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129238_Name = {
    Text = "星辰第1章@"
  },
  Event_129239_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129239_Name = {
    Text = "忘却第6章@"
  },
  Event_129240_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129240_Name = {
    Text = "忘却第5章@"
  },
  Event_129241_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129241_Name = {
    Text = "星辰第4章@"
  },
  Event_129242_ChoiceDesc1 = {
    Text = "【为他演奏】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129242_ChoiceDesc2 = {
    Text = "【聆听琴声】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_129242_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印，重复 2 次"
  },
  Event_129242_Desc = {
    Text = "「亲爱的约翰：\n    最近我突然意识到，距离你上次为我们进行钢琴演奏，已经过去了数年时间。\n    我今年81岁了，年龄越是增长，就越会意识到年轻时回忆的可贵。\n    若你收到这份信，就请你下次经过伦蒂尼恩时，在我的公寓前驻足，前来演奏一曲吧。」"
  },
  Event_129242_Name = {
    Text = "遗憾的奏鸣"
  },
  Event_129243_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129243_Name = {
    Text = "星辰第3章@"
  },
  Event_129244_ChoiceDesc1 = {
    Text = "【说自己没有钱包】获得3选1刻印，重复 2 次"
  },
  Event_129244_ChoiceDesc2 = {
    Text = "【将网打破】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129244_Desc = {
    Text = "橙黄色的网在空中静静地漂浮，它孔洞稀疏，远不如墙根上栖息了一只蜘蛛的远亲来得精致。\n你忍不住伸手触碰，脆弱的网瞬间溶解，孩子们的欢笑在你耳边响起。\n「金的银的黄的红的，所有钱包的都是我们的！」"
  },
  Event_129244_Name = {
    Text = "迷走网路"
  },
  Event_129245_ChoiceDesc1 = {
    Text = "【选择感性】回复 Arg1 点生命"
  },
  Event_129245_ChoiceDesc2 = {
    Text = "【维持理性】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129245_ChoiceDesc3 = {
    Text = "【拒绝选择】获得25黑印"
  },
  Event_129245_Desc = {
    Text = "「选择吧，选择。」\n狂奔的黑暗中，传来了无数的呢喃。\n这声音温柔催眠，似乎带着无限的魔力，令你产生某种癫狂的幻觉。\n你的大脑陷入狂悖，蠕动着脱离身体，而心脏则似乎生发了某种意识，向你惊叫着呼唤。\n「选择吧，选择。」\n「维持理性还是感性，你必须做出选择。」"
  },
  Event_129245_Name = {
    Text = "人性的代价"
  },
  Event_129246_ChoiceDesc1 = {
    Text = "【消灭祭品】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129246_ChoiceDesc2 = {
    Text = "【解开绳索】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129246_ChoiceDesc3 = {
    Text = "【继续前进】获得50黑印"
  },
  Event_129246_Desc = {
    Text = "三名亚兰人被捆缚于高台之上。\n他们的身上浮现出你在婴孩身上曾见过的树皮状深色纹路，口中念念有词。"
  },
  Event_129246_Name = {
    Text = "三枚祭品"
  },
  Event_129247_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129247_Name = {
    Text = "星辰第3章@"
  },
  Event_129248_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129248_Name = {
    Text = "忘却第6章@"
  },
  Event_129249_ChoiceDesc1 = {
    Text = "【挣扎向前】删除1张指令卡，获得Arg1黑印"
  },
  Event_129249_ChoiceDesc2 = {
    Text = "【扯断丝线】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_129249_ChoiceDesc3 = {
    Text = "【隐忍不发】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129249_Desc = {
    Text = "一路上你被推着前进，你的所有选择都被无形的丝线操纵着。\n你努力挣动双手，想要抓住在意的一切。\n世界的命运悬挂在你指尖之前。\n无数丝线缠绕而来，束缚住你的全身。"
  },
  Event_129249_Name = {
    Text = "被操纵的双手"
  },
  Event_129250_ChoiceDesc1 = {
    Text = "【向他问路】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129250_ChoiceDesc2 = {
    Text = "【离开它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129250_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129250_Desc = {
    Text = "影子站在瘦长的路灯下。\n「方便借个火吗，先生。」\n你没有@2的习惯，但你不介意使用一点小小的「魔法」。\n在你的帮助下，影子将点燃的@2深入那看不见底的黑色漩涡里。\n不一会，你便看见白色的烟雾蒸腾而出。\n「啊——」\n影子发出愉悦的叹息声。"
  },
  Event_129250_Name = {
    Text = "路灯下的身影"
  },
  Event_129251_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129251_Name = {
    Text = "忘却第1章@"
  },
  Event_129252_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129252_Name = {
    Text = "忘却第8章@"
  },
  Event_129253_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129253_Name = {
    Text = "忘却第3章@"
  },
  Event_129254_ChoiceDesc1 = {
    Text = "【接受幻觉】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129254_ChoiceDesc2 = {
    Text = "【否认幻觉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129254_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129254_Desc = {
    Text = "厚重黑暗的铁架桥下，芦苇丛生的寂静河滩上，忽然飞出一只闪光的蝴蝶。\n蝴蝶轻盈地落在你的掌心，糟糕的嚎叫声停息了，取而代之的是火车碾过锈蚀钢架的轰鸣声，煤炭燃烧的噼啪声，轮轴转动的金属摩擦声……"
  },
  Event_129254_Name = {
    Text = "铁路的幻觉"
  },
  Event_129255_ChoiceDesc1 = {
    Text = "【选择拒绝】删除1张指令卡，获得Arg1黑印"
  },
  Event_129255_ChoiceDesc2 = {
    Text = "【选择遵从】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_129255_ChoiceDesc3 = {
    Text = "【选择拥抱】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129255_Desc = {
    Text = "「我是一只笼中鸟，被关在充满许多房间的院子里。」\n黑暗中徘徊着模糊的人影，那是逝去者留下的执念。\n「他们说，那是疯人院，可我却知道，那是人类的特殊囚笼，关押着不愿遵从社会规则的自由鸟。」\n「可是鸟儿如果不能飞翔，还能被称为鸟吗？」\n执念们向你靠拢，祈求着救赎。\n「请折断我的翅膀，我已厌倦了飞翔。」"
  },
  Event_129255_Name = {Text = "空心人"},
  Event_129256_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129256_Name = {
    Text = "忘却第2章@"
  },
  Event_129257_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129257_Name = {
    Text = "星辰第2章@"
  },
  Event_129258_ChoiceDesc1 = {
    Text = "【放飞蝴蝶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129258_ChoiceDesc2 = {
    Text = "【成为蝴蝶】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129258_ChoiceDesc3 = {
    Text = "【吞回肚子】获得25黑印"
  },
  Event_129258_Desc = {
    Text = "这一夜发生了太多事。\n码头围攻，幽灵货轮，蹈海者，图鲁，墨菲，拉蒙娜……一切的一切都在漩涡中回转，被搅成了弥萨格餐厅早上七点的燕麦粥。\n想要向眼前的唤醒体提问，却根本不知道怎样提起，如鲠在咽——或者说，胃里的蝴蝶。"
  },
  Event_129258_Name = {
    Text = "蝴蝶效应"
  },
  Event_129259_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129259_Name = {
    Text = "忘却第8章@"
  },
  Event_129260_ChoiceDesc1 = {
    Text = "【任由停留】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129260_ChoiceDesc2 = {
    Text = "【挥手驱赶】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129260_ChoiceDesc3 = {
    Text = "【迎接蝴蝶】获得25黑印"
  },
  Event_129260_Desc = {
    Text = "你们逡巡于寒风凌冽的疗养院中，一只这个季节不应存在的黑色蝴蝶翩跹而来。\n蝴蝶翕动的翅膀上拖着黑色的粘液，高低摇晃着飞过，翅膀上溢出的一层层黑浆，在凝固后被风化剥落。\n它飞累了，停在了你的指尖。"
  },
  Event_129260_Name = {
    Text = "不应存在之物"
  },
  Event_129261_ChoiceDesc1 = {
    Text = "【重温过去】获得3选1高级刻印，重复 2 次"
  },
  Event_129261_ChoiceDesc2 = {
    Text = "【窥视未来】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129261_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_129261_Desc = {
    Text = "世间没有什么能够稳固不变。\n即便是神母塑造的乐园也是如此。\n在短暂的刹那，你从时空裂隙里瞥到了一些东西。\n过去、现在、未来交织在那布满裂痕的罅隙里，不停变化。\n等待你好奇的窥探。"
  },
  Event_129261_Name = {
    Text = "时空裂隙"
  },
  Event_129262_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129262_Name = {
    Text = "忘却第7章@"
  },
  Event_129263_ChoiceDesc1 = {
    Text = "【无视它】获得3选1刻印，重复 2 次"
  },
  Event_129263_ChoiceDesc2 = {
    Text = "【碰触它】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129263_Desc = {
    Text = "类似孢子的奇怪东西引起了你的注意。\n它犹如血肉组成的纤细水母，又似大脑深处寄存着信号的神经纤维。\n「来碰触我吧。」它无声诱惑着你，「我会，向你展示一段残酷的记忆。」"
  },
  Event_129263_Name = {
    Text = "深度记忆"
  },
  Event_129264_ChoiceDesc1 = {
    Text = "【沉迷幻想】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129264_ChoiceDesc2 = {
    Text = "【保持理智】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_129264_ChoiceDesc3 = {
    Text = "【强行离开】获得3选1刻印，重复 2 次"
  },
  Event_129264_Desc = {
    Text = "或许是长期的战斗令你产生了恍惚，也或许只是你的大脑背叛了你的身体。\n某种失重感出现在你的脑海。\n一瞬间，你的脑海突然变成了万花筒，绚烂，斑斓，闪动着五颜六色的光彩。\n数不清的灵感、迷思和狂想挤入大脑，占据你大脑沟壑的每一个角落。\n再这样下去，你的脑子很快就会被这些乱七八糟的东西撑爆。"
  },
  Event_129264_Name = {
    Text = "思维万花筒"
  },
  Event_129265_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129265_Name = {
    Text = "忘却第5章@"
  },
  Event_129266_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129266_Name = {
    Text = "忘却第4章@"
  },
  Event_129267_ChoiceDesc1 = {
    Text = "【聆听】获得3选1高级刻印，重复 2 次"
  },
  Event_129267_ChoiceDesc2 = {
    Text = "【呼喊】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129267_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_129267_Desc = {
    Text = "自从意外发生后，你再也没有收到搭档的消息。\n无数联络发出，如同石沉大海毫无回音。\n在你已经不抱希望的时刻，联络器突然发出了声响。\n你打开手提箱，将电话听筒靠近耳朵。\n“守密人……”\n恍惚中你听到了那个一直思念的声音，像是隔着层层虚空遥远地回响。"
  },
  Event_129267_Name = {
    Text = "思念的回音"
  },
  Event_129268_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129268_Name = {
    Text = "忘却第1章@"
  },
  Event_129269_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129269_Name = {
    Text = "星辰第1章@"
  },
  Event_129270_ChoiceDesc1 = {
    Text = "【直视地狱犬来源】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129270_ChoiceDesc2 = {
    Text = "【专注战斗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129270_Desc = {
    Text = "地狱犬的轮廓变化着。\n他的身躯连接着墙壁的罅隙，透露出诡丽的幻象。"
  },
  Event_129270_Name = {
    Text = "来自角度"
  },
  Event_129271_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129271_Name = {
    Text = "忘却第2章@"
  },
  Event_129272_ChoiceDesc1 = {
    Text = "【拼合纸张】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129272_ChoiceDesc2 = {
    Text = "【阅读】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次"
  },
  Event_129272_ChoiceDesc3 = {
    Text = "【丢弃它】获得50黑印"
  },
  Event_129272_Desc = {
    Text = "一页泛黄的纸从提灯教众的罩袍下脱落。\n纸上密密麻麻撰写着古怪的文本，有些像是象形符号，有些怪异地上扬，有些字体甚至重叠在一起，只有少量文字勉强可以辨认。\n标题是《@2 圣子的诞生》"
  },
  Event_129272_Name = {
    Text = "密令·下"
  },
  Event_129273_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129273_Name = {
    Text = "忘却第2章@"
  },
  Event_129274_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129274_Name = {
    Text = "星辰第2章@"
  },
  Event_129275_ChoiceDesc1 = {
    Text = "【准备战斗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129275_ChoiceDesc2 = {
    Text = "【尝试绕路】获得25黑印"
  },
  Event_129275_Desc = {
    Text = "于星光垂落的深海里，蹈海者们蛰伏了千百年的岁月。\n无垠的海水见证了他们的疯狂，见证了他们的忍耐，也见证了他们对神明最虔诚的信仰。\n没有人可以阻挡神明的伟大降临。\n任何碍事者，都会在蹈海者的怒火中化为灰烬。"
  },
  Event_129275_Name = {
    Text = "群星下的等待"
  },
  Event_129276_ChoiceDesc1 = {
    Text = "【弹几个音】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129276_ChoiceDesc2 = {
    Text = "【将盖子盖上】获得3选1刻印，重复 2 次"
  },
  Event_129276_Desc = {
    Text = "墙边的钢琴敞着盖子。它有着泛黄的琴键和露出木色的开裂的边缘，但每一个琴键都被擦拭得非常干净。\n它是那么多人的快乐源泉。"
  },
  Event_129276_Name = {
    Text = "童年的旋律"
  },
  Event_129277_ChoiceDesc1 = {
    Text = "【接受幻觉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129277_ChoiceDesc2 = {
    Text = "【否认幻觉】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129277_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_129277_Desc = {
    Text = "厚重黑暗的铁架桥下，芦苇丛生的寂静河滩上，忽然飞出一只闪光的蝴蝶。\n蝴蝶轻盈地落在你的掌心，糟糕的嚎叫声停息了，取而代之的是搬运钢筋的工人整齐的号子声，钉头锤的敲打声，铆钉碰撞的清脆金属声……"
  },
  Event_129277_Name = {
    Text = "钢桥的幻觉"
  },
  Event_129278_ChoiceDesc1 = {
    Text = "【展示诅咒】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，重复 2 次，感染「(Skill.Arg2)」，重复 2 次"
  },
  Event_129278_ChoiceDesc2 = {
    Text = "【拒绝乌鸦】获得3选1刻印，重复 2 次"
  },
  Event_129278_ChoiceDesc3 = {
    Text = "【无视】"
  },
  Event_129278_Desc = {
    Text = "漆黑而病态的多颅乌鸦自一名提灯教众的黑袍中飞出，落在你的肩膀上。\n「看见我的头了吗？只要品尝诅咒，我就会长出新的头颅。让我看看吧，你的诅咒！」"
  },
  Event_129278_Name = {
    Text = "诅咒怪鸦"
  },
  Event_129279_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129279_Name = {
    Text = "忘却第7章@"
  },
  Event_129280_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129280_Name = {
    Text = "忘却第3章@"
  },
  Event_129281_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129281_Name = {
    Text = "忘却第4章@"
  },
  Event_129282_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129282_Name = {
    Text = "忘却第2章@"
  },
  Event_129283_ChoiceDesc1 = {
    Text = "【占位】临时文本。"
  },
  Event_129283_Name = {
    Text = "星辰第2章@"
  },
  Event_129900_ChoiceDesc1 = {
    Text = "【安葬】回复 Arg2 点生命[ExDesc1]，选择 1 张指令卡删除。"
  },
  Event_129900_ChoiceDesc2 = {
    Text = "【祷告】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_129900_Desc = {
    Text = "一截苍白的骸骨，半数浸没于漆黑的融蚀浆中。"
  },
  Event_129900_Name = {
    Text = "褪色遗骨"
  },
  Event_130337_ChoiceDesc1 = {
    Text = "【入座】将「提线木偶」置入牌库。"
  },
  Event_130337_Desc = {
    Text = "当你的双足踏上剧院的台阶，目光便再无法从这座舞台移开。\n命运丝线牵引着长河沙数的故事在此流转——过往的尘埃、此刻的光影、未来的迷雾，皆在台前翻涌不息。\n你遗忘了自己来自何方、想要去往何处，关于「自我」的印记在帷幕的阴影里消融殆尽。此刻，你是座下静默的观者，也是台上燃烧的伶人。\n你存在的全部意义，坍缩成两道刻痕：凝望，与献演。"
  },
  Event_130337_Name = {
    Text = "宿命舞台"
  },
  Event_131264_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131264_Desc = {
    Text = "你们选择了力量，选择了坚定的信念与一往无前的勇气。\n可，代价……代价存在的意义，就是用来承受的，不是吗？"
  },
  Event_131264_Name = {
    Text = "旧日凝望"
  },
  Event_131265_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131265_Desc = {
    Text = "你忍受着脑海中的痛楚，用力攥紧那些飘散、破碎的记忆。在你艰难的忍耐下，那些裂隙开始缝补。\n你为铭记而离开，为铭记而战斗。你不会允许任何记忆离开自己。"
  },
  Event_131265_Name = {
    Text = "破碎记忆"
  },
  Event_131266_ChoiceDesc1 = {
    Text = "【保护回忆】获得3选1刻印"
  },
  Event_131266_ChoiceDesc2 = {
    Text = "【阻止裂隙】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131266_Desc = {
    Text = "你从未质疑过自己的回忆。它们温暖，坚固，是你最可靠的港湾与最珍视的珍宝。\n但现在，在渊狱的干扰之下，那些记忆开始出现紊乱的裂痕。"
  },
  Event_131266_Name = {
    Text = "破碎记忆"
  },
  Event_131267_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131267_Desc = {
    Text = "精神力量涌入脑海，修补那些可怖的缝隙。你用尽全力，终于让那些裂隙归于完好。\n你为铭记而离开，为铭记而战斗。你不会允许任何记忆离开自己。"
  },
  Event_131267_Name = {
    Text = "破碎记忆"
  },
  Event_131268_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131268_Desc = {
    Text = "「呜呜呜呜……哈哈哈哈！！」\n没有人听懂你的问询，他们用哭喊与尖笑回应。"
  },
  Event_131268_Name = {
    Text = "被遗弃者"
  },
  Event_131269_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131269_Desc = {
    Text = "你们向它们回望。丝线拨动，温柔的目光将回忆拥入怀中。\n你沉默地望着那位命运的操控者。如果再来一次，她会作何选择呢？"
  },
  Event_131269_Name = {
    Text = "旧日凝望"
  },
  Event_131270_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_131270_Desc = {
    Text = "「呜呜呜呜……哈哈哈哈！！」\n哭喊与尖笑在你的身前逐渐消散。没有魂灵前来伤害你——他们早已习惯了被无视。"
  },
  Event_131270_Name = {
    Text = "被遗弃者"
  },
  Event_131271_ChoiceDesc1 = {
    Text = "【凝视回忆】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131271_ChoiceDesc2 = {
    Text = "【遗忘回忆】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_131271_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_131271_Desc = {
    Text = "在女孩的身体里，你听见罐子破碎的声音。回忆离开它们的容器，来到你们身边。\n儿时的玩伴，父母的礼物，白云与飞鸟最纯真的想象，洁白如天空般的理想……所有的回忆睁开眼，静静地望向你们。\n它们询问。它们哭泣。它们等待。"
  },
  Event_131271_Name = {
    Text = "旧日凝望"
  },
  Event_131272_ChoiceDesc1 = {
    Text = "【询问】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131272_ChoiceDesc2 = {
    Text = "【无视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_131272_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_131272_Desc = {
    Text = "尖锐的哭嚎声在你耳畔响起，痛苦的魂灵在你面前撕扯着自己的面孔与身躯……\n他们是谁？渊狱的囚徒？被遗弃的命运？被埋藏的回忆？"
  },
  Event_131272_Name = {
    Text = "被遗弃者"
  },
  Event_133380_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_133380_Desc = {
    Text = "你坐上了属于你的天鹅绒座椅，鲜红的幕布悄然拉开。\n亲爱的观众，舞台将回应你的期待。\n这出剧目的主演，已经站上了舞台。"
  },
  Event_133380_Name = {
    Text = "宿命舞台"
  },
  Event_141995_ChoiceDesc1 = {
    Text = "【简单尝试】删除至多 5 张任意卡牌"
  },
  Event_141995_ChoiceDesc2 = {
    Text = "【由他研究】随机删除 5 张指令卡，获得受祝造物「(RelicConfig.Arg1)」。"
  },
  Event_141995_ChoiceDesc3 = {
    Text = "【反向思考？】选择至多两个唤醒体，生成一套他们的全套基础卡牌置入牌库"
  },
  Event_141995_Desc = {
    Text = "你来到一处广场，不少人行色匆匆，或许可以在这里找到些有趣的东西。\n你敲开了一间点着昏黄灯光的房门，一名研究员打扮的人从中探出头。你看到许多不知名的科学器械，他拉着你坐下，声称自己是名「进化学家」。他满脸狂热，极力向你推荐他的「科学方法 」。\n「唯有删去人类身上无趣的冗余，才是真正的进化之路！」"
  },
  Event_141995_Name = {
    Text = "进化学家"
  },
  Event_141996_ChoiceDesc1 = {
    Text = "【针对进攻进行特训】为所有不带有刻印的基础打击附加随机刻印"
  },
  Event_141996_ChoiceDesc2 = {
    Text = "【针对防守进行特训】为所有不带有刻印的基础防御附加随机刻印"
  },
  Event_141996_ChoiceDesc3 = {
    Text = "【不顾一切地特训】为随机 15 张指令卡附加随机刻印，获得 5 张随机症状卡"
  },
  Event_141996_Desc = {
    Text = "你来到一处广场，不少人行色匆匆，或许可以在这里找到些有趣的东西。\n金属撞击的脆响在空地上回响，几人正在这里相互比试，提升武艺，一名身着旧式铠甲的年轻人注意到你，将一把剑丢了过来，邀请你与他们一同锻炼。"
  },
  Event_141996_Name = {
    Text = "特训时间"
  },
  Event_141997_ChoiceDesc1 = {
    Text = "【押大】50%机会获得随机刻印并重新下注，50%机会获得 75 黑印"
  },
  Event_141997_ChoiceDesc2 = {
    Text = "【押小】50%机会获得随机刻印并重新下注，50%机会获得 75 黑印"
  },
  Event_141997_Desc = {
    Text = "服务生维持着不变的笑容，抬起骰盅，清脆的声音回响，其他玩家纷纷做出了自己的选择。「买定离手。」他说，「请下注——」"
  },
  Event_141997_Name = {
    Text = "喧嚣赌场"
  },
  Event_141998_ChoiceDesc1 = {
    Text = "【老实下注】删除一张指令卡"
  },
  Event_141998_ChoiceDesc2 = {
    Text = "【试试出千】删除一张症状卡"
  },
  Event_141998_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_141998_Desc = {
    Text = "你来到一处极为热闹的地方，人人脸上洋溢着幸福，肆意闪烁光芒的彩灯将夜色挤得无处可去。而随处可见的标牌上写着：「欢迎来到嘉年华！这里的梦境永无终结，这里的欢愉永不落幕！」\n随着拥挤的人流，你被推搡着闯入了一栋华丽的建筑，厅内金碧辉煌，人声鼎沸，空气中弥漫着甜腻的酒香。一枚骰子恰好咕噜咕噜地滚到你的脚边，服务生挂着谄媚的笑，告诉你这是好运的象征。怀揣着好奇心，你向前迈进一步，或许，可以在这场游戏中大显身手一番。"
  },
  Event_141998_Name = {
    Text = "喧嚣赌场"
  },
  Event_141999_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 个造物，50%概率获得3选1黄金造物，50%概率获得 25 黑印"
  },
  Event_141999_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_141999_Desc = {
    Text = "你来到一处极为热闹的地方，人人脸上洋溢着幸福，肆意闪烁光芒的彩灯将夜色挤得无处可去。而随处可见的标牌上写着：「欢迎来到嘉年华！这里的梦境永无终结，这里的欢愉永不落幕！」\n人群中，一名衣着褴褛，却带着大得惊人的包裹的商人朝你挥手，他拍了拍身旁的包，凑近并压低声音，向你提出了以物易物的邀请，那只破旧的布包随着他的说话声轻轻晃动，还时不时发出咔咔的响声。"
  },
  Event_141999_Name = {
    Text = "褴褛行商"
  },
  Event_142000_ChoiceDesc1 = {
    Text = "【试着许愿】消耗50%当前生命值，获得 2 个随机黄金造物"
  },
  Event_142000_ChoiceDesc2 = {
    Text = "【全身心许愿】消耗99%当前生命值，获得时灵摆「(RelicConfig.Arg2)」"
  },
  Event_142000_ChoiceDesc3 = {
    Text = "【伸手摸索池底】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_142000_Desc = {
    Text = "风吹过郊野，四下一片寂静，只有树木的哗哗声作响。\n忽然，你听到何物汩汩流动的声响，循声走去，浓重的腥甜先一步扑来，你终于看清了那水流声的源头——是一座许愿池，盛满了赤色，无数人的血液正于池中涌动，仿佛在液面之下有什么将要跃出。\n声音贴着你的心底响起：「奉上你的血吧，我会赐你恩惠。」"
  },
  Event_142000_Name = {Text = "血泉"},
  Event_142001_ChoiceDesc1 = {
    Text = "【简单地供奉】选择删除 2 个造物，获得负罪造物「(RelicConfig.Arg1)」"
  },
  Event_142001_ChoiceDesc2 = {
    Text = "【虔诚地供奉】选择删除 4 个造物，获得受祝造物「(RelicConfig.Arg1)」"
  },
  Event_142001_ChoiceDesc3 = {
    Text = "【偷点贡品，没人知道】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_142001_Desc = {
    Text = "风吹过郊野，四下一片寂静，只有树木的哗哗声作响。\n不知不觉间，你来到一座古老的祭坛前，巨大的雕像居高临下地凝视你，似乎想从你的手中拿走什么。你看到祭坛的正下方刻着模糊的文字——「得失相称」。"
  },
  Event_142001_Name = {
    Text = "得失祭坛"
  },
  Event_142002_ChoiceDesc1 = {
    Text = "【免费体验】随机 Arg2 个白银造物升级"
  },
  Event_142002_ChoiceDesc2 = {
    Text = "【普通服务】消耗 Arg1 黑印：随机 Arg2 个白银造物升级"
  },
  Event_142002_ChoiceDesc3 = {
    Text = "【豪华服务】消耗 Arg1 黑印：随机 Arg2 个白银造物升级"
  },
  Event_142002_Desc = {
    Text = "你来到一处广场，不少人行色匆匆，或许可以在这里找到些有趣的东西。\n点着温暖灯光的小楼静静矗立在广场一角，似乎是一家高级会馆，但墙上挂着的深色牌匾却赫然写着「本店只为生物以外的存在服务。」"
  },
  Event_142002_Name = {
    Text = "特别会馆"
  },
  Event_142003_ChoiceDesc1 = {
    Text = "【抽一次】获得一张症状卡"
  },
  Event_142003_ChoiceDesc2 = {
    Text = "【离开】获得 75 黑印"
  },
  Event_142003_Desc = {
    Text = "你来到一处极为热闹的地方，人人脸上洋溢着幸福，肆意闪烁光芒的彩灯将夜色挤得无处可去。而随处可见的标牌上写着：「欢迎来到嘉年华！这里的梦境永无终结，这里的欢愉永不落幕！」\n你注意到路旁有一家抽奖摊，围满了人，所有人的目光聚焦在被遮得严严实实的大奖上——摊主极力宣扬它的珍稀，人们争相参与其中。"
  },
  Event_142003_Name = {
    Text = "抽奖挑战"
  },
  Event_142004_ChoiceDesc1 = {
    Text = "【借用一下】"
  },
  Event_142004_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_142004_Desc = {
    Text = "风吹过郊野，四下一片寂静，只有树木的哗哗声作响。\n忽然，你看到一间破旧的草棚，正中央摆放着一个铁砧，一旁还有许多生了锈的金属兵器，这里似乎是一间荒废许久的铁匠铺。铁砧旁放着详细的使用说明，告知你可以将造物放在这里改造。"
  },
  Event_142004_Name = {Text = "铁匠铺"},
  Event_142005_ChoiceDesc1 = {
    Text = "【老实下注】删除一张指令卡"
  },
  Event_142005_ChoiceDesc2 = {
    Text = "【试试出千】删除一张症状卡"
  },
  Event_142005_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_142005_Desc = {
    Text = "旁人的喝彩宣告了你的胜利，嘈杂的人声中，你终于也和他们一样，沉醉于这场押上一切的光怪陆离的梦。你看向手中的筹码，仿佛它们是为你带来荣耀的最忠实的友伴，低语自赌桌深处传来，裹挟着某种暧昧的请求：「再来一次吧，再赢一次吧。」"
  },
  Event_142005_Name = {
    Text = "喧嚣赌场"
  },
  Event_142013_ChoiceDesc1 = {
    Text = "【押大】50%机会获得随机白银造物并重新下注，50%机会获得 75 黑印并进入精英战斗"
  },
  Event_142013_ChoiceDesc2 = {
    Text = "【押小】50%机会获得随机白银造物并重新下注，50%机会获得 75 黑印并进入精英战斗"
  },
  Event_142013_Desc = {
    Text = "服务生维持着不变的笑容，抬起骰盅，清脆的声音回响，其他玩家纷纷做出了自己的选择。「买定离手。」他说，「请下注——」"
  },
  Event_142013_Name = {
    Text = "喧嚣赌场"
  },
  Event_142073_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142073_Desc = {
    Text = "服务生掀起骰盅，短短几秒，空气仿佛都凝滞了。答案揭晓的顷刻，你听到欢呼与哀嚎混在一起。幸运并未眷顾你，桌上静静躺着的几枚骰子给出了与你相反的答案。你最后扫视了一圈，看了看那些疯狂的赌徒。该走了。"
  },
  Event_142073_Name = {
    Text = "喧嚣赌场"
  },
  Event_142074_ChoiceDesc1 = {
    Text = "【进入战斗】"
  },
  Event_142074_Desc = {
    Text = "在你满怀期待地紧盯赌桌时，你的手忽然被牢牢箍住，抬头看去，赌场的老板正俯视着，准备把一切不守规则的客人请出此地。霎时间，所有视线聚焦于你一人，惊诧的，充满敌意的，幸灾乐祸的......你意识到，一个人或许可以作弊很多次，但只要被发现一次，便要迎来彻底的身败名裂了。"
  },
  Event_142074_Name = {
    Text = "喧嚣赌场"
  },
  Event_142103_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142103_Desc = {
    Text = "你通过物理手段从赌场中成功脱身，人群的喧哗声被你抛在身后，你加快脚步离去——至于这一片狼藉，自会有人去收拾的。"
  },
  Event_142103_Name = {
    Text = "喧嚣赌场"
  },
  Event_142105_ChoiceDesc1 = {
    Text = "【再抽一次】获得一张症状卡"
  },
  Event_142105_ChoiceDesc2 = {
    Text = "【离开】获得 75 黑印"
  },
  Event_142105_Desc = {
    Text = "你试着抽了一次，无事发生。但卡片的背面写着：「下一次更容易」\n......要再试一次吗？"
  },
  Event_142105_Name = {
    Text = "抽奖挑战"
  },
  Event_142106_ChoiceDesc1 = {
    Text = "【再抽一次】获得一张症状卡"
  },
  Event_142106_ChoiceDesc2 = {
    Text = "【离开】获得 75 黑印"
  },
  Event_142106_Desc = {
    Text = "你试着抽了一次，无事发生。但卡片的背面写着：「下一次更容易」\n......要再试一次吗？"
  },
  Event_142106_Name = {
    Text = "抽奖挑战"
  },
  Event_142107_ChoiceDesc1 = {
    Text = "【再抽一次】获得一张症状卡"
  },
  Event_142107_Desc = {
    Text = "你试着抽了一次，无事发生。但卡片的背面写着：「下一次更容易」\n......要再试一次吗？"
  },
  Event_142107_Name = {
    Text = "抽奖挑战"
  },
  Event_142108_ChoiceDesc1 = {
    Text = "【再抽一次】获得一张症状卡"
  },
  Event_142108_ChoiceDesc2 = {
    Text = "【离开】获得 75 黑印"
  },
  Event_142108_Desc = {
    Text = "你试着抽了一次，无事发生。但卡片的背面写着：「下一次更容易」\n......要再试一次吗？"
  },
  Event_142108_Name = {
    Text = "抽奖挑战"
  },
  Event_142109_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142109_Desc = {
    Text = "听着心跳声，你揭开了抽奖票，耀眼的金色文字跳进你的眼中。摊主兴奋地摇动铃铛，所有路人都向你投来羡慕的目光。\n「大奖已被抽出！」"
  },
  Event_142109_Name = {
    Text = "抽奖挑战"
  },
  Event_142110_ChoiceDesc1 = {
    Text = "【再抽一次】获得一张症状卡"
  },
  Event_142110_ChoiceDesc2 = {
    Text = "【离开】获得 75 黑印"
  },
  Event_142110_Desc = {
    Text = "你试着抽了一次，无事发生。但卡片的背面写着：「下一次更容易」\n......要再试一次吗？"
  },
  Event_142110_Name = {
    Text = "抽奖挑战"
  },
  Event_142118_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 个造物，25%概率获得3选1时灵摆，50%概率获得随机 2 个黄金造物，25%概率获得 25 黑印"
  },
  Event_142118_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_142118_Desc = {
    Text = "商人接过了你递来的物品，对着月光翻来覆去地看，眼睛都快要瞪出来。你等了许久，他才裂开嘴角，从包里掏出一个生锈的铁盒。「来拆拆看吧，这可是时下最流行的盲盒。」\n你打开了它，却发现里面只有些许不尽如人意的黑色印记。商人搓了搓手，满眼歉疚地表示可以再试一次。"
  },
  Event_142118_Name = {
    Text = "褴褛行商"
  },
  Event_142119_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142119_Desc = {
    Text = "商人接过了你递来的物品，对着月光翻来覆去地看，眼睛都快要瞪出来。你等了许久，他才裂开嘴角，从包里掏出一个生锈的铁盒。「来拆拆看吧，这可是时下最流行的盲盒。」\n你打开了它，里面躺着某样东西。"
  },
  Event_142119_Name = {
    Text = "褴褛行商"
  },
  Event_142120_ChoiceDesc1 = {
    Text = "【以物易物】移除 1 个黄金造物，50%概率获得3选1时灵摆，50%概率获得3选1受祝造物"
  },
  Event_142120_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_142120_Desc = {
    Text = "你再次打开盲盒，却发现仍没有你想要的物品。商人赶忙赔笑，又翻出了一个铁盒，双手捧着递到你面前。\n「别生气，客人！我发誓，这次一定有顶天的好东西......」他嘴上这样说着，却悄悄挪出了一只手，朝你摊开，「当然，宝物自然要用宝物来换。」"
  },
  Event_142120_Name = {
    Text = "褴褛行商"
  },
  Event_142138_ChoiceDesc1 = {
    Text = "【借用一下】"
  },
  Event_142138_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_142138_Desc = {
    Text = "你成功使用了这些工具，尽管有所损坏，但好像还能用。"
  },
  Event_142138_Name = {Text = "铁匠铺"},
  Event_142139_ChoiceDesc1 = {
    Text = "【碎铸】选择 1 个黄金造物删除，获得2个白银造物，获得 50 黑印"
  },
  Event_142139_ChoiceDesc2 = {
    Text = "【淬炼】选择 2 个造物删除，获得黄金造物「(RelicConfig.Arg1)」。"
  },
  Event_142139_ChoiceDesc3 = {
    Text = "【高阶淬炼】选择 2 个黄金造物删除，获得时灵摆「(RelicConfig.Arg1)」。"
  },
  Event_142139_Desc = {
    Text = "你拿起一旁的锤子，打算......"
  },
  Event_142139_Name = {Text = "铁匠铺"},
  Event_142140_ChoiceDesc1 = {
    Text = "【借用一下】"
  },
  Event_142140_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_142140_Desc = {
    Text = "你成功使用了这些工具，尽管有所损坏，但好像还能用。"
  },
  Event_142140_Name = {Text = "铁匠铺"},
  Event_142141_ChoiceDesc1 = {
    Text = "【碎铸】选择 1 个黄金造物删除，获得2个白银造物，获得 50 黑印"
  },
  Event_142141_ChoiceDesc2 = {
    Text = "【淬炼】选择 2 个造物删除，获得黄金造物「(RelicConfig.Arg1)」。"
  },
  Event_142141_ChoiceDesc3 = {
    Text = "【高阶淬炼】选择 2 个黄金造物删除，获得时灵摆「(RelicConfig.Arg1)」。"
  },
  Event_142141_Desc = {
    Text = "你拿起一旁的锤子，打算......"
  },
  Event_142141_Name = {Text = "铁匠铺"},
  Event_142142_ChoiceDesc1 = {
    Text = "【碎铸】选择 1 个黄金造物删除，获得2个白银造物，获得 50 黑印"
  },
  Event_142142_ChoiceDesc2 = {
    Text = "【淬炼】选择 2 个造物删除，获得黄金造物「(RelicConfig.Arg1)」。"
  },
  Event_142142_ChoiceDesc3 = {
    Text = "【高阶淬炼】选择 2 个黄金造物删除，获得时灵摆「(RelicConfig.Arg1)」。"
  },
  Event_142142_Desc = {
    Text = "你拿起一旁的锤子，打算......"
  },
  Event_142142_Name = {Text = "铁匠铺"},
  Event_142167_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142167_Desc = {
    Text = "经过了三轮使用，铁砧彻底凹陷下去，锤上也满是磨损，看起来已经无法再用了。"
  },
  Event_142167_Name = {Text = "铁匠铺"},
  Event_142235_ChoiceDesc1 = {
    Text = "【我会坚定向前】获得「纯粹」：所有指令卡获得20层永久强化"
  },
  Event_142235_ChoiceDesc2 = {
    Text = "【我不会逃避】获得「升华」：银钥上限、狂气上限永久降低 20%"
  },
  Event_142235_Desc = {
    Text = "你的眼前忽然蒙上了一层雾，世界开始变得模糊不堪，恍惚间，一个声音于你心底响起：\n「你还要前进吗？」"
  },
  Event_142235_Name = {
    Text = "终站将近"
  },
  Event_142925_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142925_Desc = {
    Text = "会馆的工作人员收下报酬，为你进行了基础服务。他们将你交付出去的物品带入一间漆黑的隔间，等待的时间不长，他重新出现时，东西已经放回了托盘上，似乎和原来的不太一样了。"
  },
  Event_142925_Name = {
    Text = "特别会馆"
  },
  Event_142926_ChoiceDesc1 = {
    Text = "【删除一个黄金造物】（需有黄金造物）"
  },
  Event_142926_ChoiceDesc2 = {
    Text = "【有强化（Forged）造物可选】"
  },
  Event_142926_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_142926_Desc = {
    Text = "测试「造物数量」「选择造物列表」"
  },
  Event_142927_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142927_Desc = {
    Text = "会馆的工作人员收下报酬，为你进行了豪华服务。他们郑重地将你的物品放入匣子，带入一间漆黑的隔间。你等候了许久，直到他再度出现，将物品双手奉上，神色一如既往地平静。"
  },
  Event_142927_Name = {
    Text = "特别会馆"
  },
  Event_142928_ChoiceDesc1 = {
    Text = "【选最多2个唤醒体充满狂气】"
  },
  Event_142928_ChoiceDesc2 = {
    Text = "【必须选择2个唤醒体充满狂气】"
  },
  Event_142928_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_142928_Desc = {
    Text = "测试「条件选择唤醒体」"
  },
  Event_142929_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142929_Desc = {
    Text = "研究员围着你转了一圈又一圈，细细打量了许久，才开始工作——他没有征询你的意见。一段时间过去，当你准备离开这间奇怪的研究所时，你清楚自己的确失去了许多，但他却拍着手祝贺你：「这就是进化的真谛！」"
  },
  Event_142929_Name = {
    Text = "进化学家"
  },
  Event_142930_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142930_Desc = {
    Text = "你伸出手，向一片猩红的池水中探去，摸到了一些有用的东西。"
  },
  Event_142930_Name = {Text = "血泉"},
  Event_142931_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142931_Desc = {
    Text = "声音远去，你心中充满决心，感觉力量涌现。"
  },
  Event_142931_Name = {
    Text = "终站将近"
  },
  Event_142932_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142932_Desc = {
    Text = "声音远去，你心中充满决心，头脑更加清醒。"
  },
  Event_142932_Name = {
    Text = "终站将近"
  },
  Event_142933_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142933_Desc = {
    Text = "你在堆成小山的贡品堆里随便拿了一点，随后便迅速溜走了，在你离开时，雕像的双眼似乎动了一下。"
  },
  Event_142933_Name = {
    Text = "得失祭坛"
  },
  Event_142934_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142934_Desc = {
    Text = "你针对防守方向展开了训练，面对对手的突袭，你不断用武器抵御，你的防御能力和反应都有所提升。"
  },
  Event_142934_Name = {
    Text = "特训时间"
  },
  Event_142935_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142935_Desc = {
    Text = "研究员带上手套，从柜子上拿了一些形状古怪的器械，在你面前比划了一番。你不知道他究竟做了什么，但似乎的确觉得轻松了些。"
  },
  Event_142935_Name = {
    Text = "进化学家"
  },
  Event_142936_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142936_Desc = {
    Text = "你没有选择针对的方向，而是不顾自己身体极限地与人对练，直至所有人都筋疲力尽。你知道自己提高了不少，但同样，你也付出了代价。"
  },
  Event_142936_Name = {
    Text = "特训时间"
  },
  Event_142937_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142937_Desc = {
    Text = "你从包里随意拿了些东西供奉上去，得到了等价的赏赐。"
  },
  Event_142937_Name = {
    Text = "得失祭坛"
  },
  Event_142938_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142938_Desc = {
    Text = "你献上了一些珍贵的贡品，得到了等价的赏赐。"
  },
  Event_142938_Name = {
    Text = "得失祭坛"
  },
  Event_142939_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142939_Desc = {
    Text = "你对他的研究方法充满质疑，在一番争论后，他同意让你自己使用这些器械，选择其他方式追求「进化」。\n同样的道具，你却在误打误撞中让本该被「删去」的事物大量「增殖」，在临走前，你听到了研究员的哀嚎。"
  },
  Event_142939_Name = {
    Text = "进化学家"
  },
  Event_142940_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142940_Desc = {
    Text = "会馆的工作者为你进行了免费服务，他们将你交付出去的物品带入一间漆黑的隔间，片刻后他折返，将东西放回你手中，一言不发。"
  },
  Event_142940_Name = {
    Text = "特别会馆"
  },
  Event_142941_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142941_Desc = {
    Text = "你向许愿池奉上了大量血液，珍贵的馈赠于池中浮现。"
  },
  Event_142941_Name = {Text = "血泉"},
  Event_142942_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142942_Desc = {
    Text = "你针对进攻方向展开了训练，在钢铁碰撞中，你的打击技巧和速度都有所提升。"
  },
  Event_142942_Name = {
    Text = "特训时间"
  },
  Event_142943_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_142943_Desc = {
    Text = "你向许愿池奉上了少许血液，馈赠自池中浮现。"
  },
  Event_142943_Name = {Text = "血泉"},
  Event_142944_ChoiceDesc1 = {
    Text = "【选择升级造物】"
  },
  Event_142944_ChoiceDesc2 = {
    Text = "【随机升级造物】"
  },
  Event_142944_ChoiceDesc3 = {
    Text = "【离开（测试）】"
  },
  Event_142944_Desc = {
    Text = "测试「升级造物功能」，造物自己加"
  },
  Event_146258_ChoiceDesc1 = {
    Text = "【呼唤他】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146258_ChoiceDesc2 = {
    Text = "【回应它们】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146258_ChoiceDesc3 = {
    Text = "【无视他们】获得50黑印"
  },
  Event_146258_Desc = {
    Text = "祭坛之上，于丽埃特的白袍浸在浓重的烟雾里，香灰混着某种腥甜的气味。\n「持灯者垂怜世间罪子，」她的声音不高，却清晰地压过了满殿窸窣的祈祷，「如同慈母垂怜襁褒中的婴孩。」\n祭台上的供品在烛火中泛着油光，一缕缕青烟顺着它的轮廓扭曲上升，模糊了台下众人的脸。\n卡斯托尔隔着那片摇晃的烟雾望向波吕克斯，他站在信众之中，垂着眼，脸上是被训练出来的、恰到好处的虔诚。"
  },
  Event_146258_Name = {Text = "故梦 Ⅲ"},
  Event_146259_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146259_Desc = {
    Text = "别在意，只是雪风的呼啸，冰湖的叹息，或群峰的哀悼。\n是已然枯朽的残枝，彼此摩挲的絮语。\n它们永恒哀婉地呢喃，为曾经葬身于冰缝的每一名先驱者。"
  },
  Event_146259_Name = {
    Text = "冰湖的咏叹"
  },
  Event_146260_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146260_Desc = {
    Text = "如果绝对平等是公平，那么血链·希洛是否和你们平等享有许愿的机会？\n那么，对于被她捷足先登甚至驱赶竞争者的行动，你是否应该淡然处之？\n「或者别再胡思乱想了，赶紧继续爬吧！」耳畔响起卡拉布的呼唤声。"
  },
  Event_146260_Name = {
    Text = "荒诞的公平"
  },
  Event_146261_ChoiceDesc1 = {
    Text = "【山恐惧饥饿】"
  },
  Event_146261_ChoiceDesc2 = {
    Text = "【山恐惧失去】"
  },
  Event_146261_ChoiceDesc3 = {
    Text = "【山恐惧死亡】"
  },
  Event_146261_Desc = {
    Text = "你行走于山的身躯。\n山的颤抖暴露了它的秘密。\n山的贪婪，决定了山的恐惧。"
  },
  Event_146261_Name = {
    Text = "山的秘密"
  },
  Event_146262_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146262_Desc = {
    Text = "你享受着光滑柔软的皮毛，你被囚禁在自己的欲望中。\n你很满意它的手感。\n表象之下究竟是什么，真的关键吗？"
  },
  Event_146262_Name = {
    Text = "伏行之黑猫"
  },
  Event_146263_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146263_Desc = {
    Text = "你安静地接过红绳的尾端，把它系在了你的手腕上。\n波吕克斯依法炮制，两个孩子的手很快就被细细的红绳牵在了一起。\n虽然同样时间内的搜索面积变得更小了，不过你们注定要同生同死，不是吗？\n剩下的，就交给命运来安排吧。"
  },
  Event_146263_Name = {Text = "故梦 Ⅰ"},
  Event_146264_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146264_Desc = {
    Text = "「我当然知道这很难，亲爱的孩子。」\n「但世界对任何人而言都从未简单过。」\n「总有一天，那只蝴蝶会飞离你的掌心，然后永远不见。」"
  },
  Event_146264_Name = {
    Text = "是幻非真"
  },
  Event_146265_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146265_Desc = {
    Text = "威廉抬眼，目光快速掠过你，然后落在远方堆满积雪的山脊上。\n「你没做任何需要道歉的事情，」他说得郑重，「有些命题是属于我自己的，也只能由我自己来解答。」\n「但感谢你的敏锐和洞察。」"
  },
  Event_146265_Name = {
    Text = "温柔的沉没"
  },
  Event_146266_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146266_Desc = {
    Text = "威廉的目光闪烁。\n你张了张口，但什么也没说。沉默是此刻最好的选择。\n你们之间还存在着可贵的默契，不要破坏它。"
  },
  Event_146266_Name = {
    Text = "温柔的沉没"
  },
  Event_146267_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_146267_Desc = {
    Text = "「还给我，还给我，那是我的力量！」\n山在哭叫，山在哀嚎。\n山无法承受，它曾拥有的一切被剥夺殆尽。"
  },
  Event_146267_Name = {
    Text = "山的秘密"
  },
  Event_146268_ChoiceDesc1 = {
    Text = "【继续逃跑】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146268_ChoiceDesc2 = {
    Text = "【静待时机】获得3选1刻印"
  },
  Event_146268_ChoiceDesc3 = {
    Text = "【缓慢离开】"
  },
  Event_146268_Desc = {
    Text = "「哥哥，小心点，有乌鸦在看。」\n少年的卡斯托尔背着波吕克斯疾行，眼神慌乱地扫过每一个可疑的角落，却什么也没发现。\n「在上面。」\n你浑身一颤，抬头望去。\n檐角的阴影里，一只乌鸦静静蹲踞着，朝向四面八方的怪眼纷纷盯紧了你。"
  },
  Event_146268_Name = {Text = "故梦 Ⅱ"},
  Event_146269_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146269_Desc = {
    Text = "你牢记训练中的叮嘱，不能依赖安全绳。\n踢踏之下，你勉强稳住身形。\n但背包里有什么沿着山壁滚落，化作小得看不清的一点。\n不重要了，至少你还活着。"
  },
  Event_146269_Name = {
    Text = "无声坠落"
  },
  Event_146270_ChoiceDesc1 = {
    Text = "【侧耳聆听】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146270_ChoiceDesc2 = {
    Text = "【堵住耳朵】获得3选1刻印"
  },
  Event_146270_Desc = {
    Text = "风雪撞在岩壁上，混着冰层深处传来的若有若无的裂响，碎成一串断续的呜咽。\n你站在寂无一人的高处，忽然听清了山的旋律。\n它苍凉而庄严，低沉地吟唱一支只属于亡者的曲子。"
  },
  Event_146270_Name = {
    Text = "自然幻奏"
  },
  Event_146271_ChoiceDesc1 = {
    Text = "【是铃声】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146271_ChoiceDesc2 = {
    Text = "【是食物】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146271_ChoiceDesc3 = {
    Text = "【是狗的期待】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146271_Desc = {
    Text = "「巴甫洛夫摇动铃铛，然后给狗喂食。长此以往，只要摇动铃铛，狗就会分泌唾液。」\n「那么，让狗分泌唾液的，究竟是什么？」"
  },
  Event_146271_Name = {
    Text = "巴甫洛夫反射"
  },
  Event_146272_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146272_Desc = {
    Text = "别去回忆。\n威廉就在你触手可及的距离。\n别让痛苦吞没你。\n你错过了很多，但还来得及。"
  },
  Event_146272_Name = {
    Text = "自彼岸来"
  },
  Event_146273_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146273_Desc = {
    Text = "「合拢手掌吧。」\n「曾经曼妙之物，在你的掌中只会剩下一团黑色的泥浆。」"
  },
  Event_146273_Name = {
    Text = "是幻非真"
  },
  Event_146274_ChoiceDesc1 = {
    Text = "【变回去】获得50黑印"
  },
  Event_146274_ChoiceDesc2 = {
    Text = "【抚摸】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_146274_Desc = {
    Text = "「喵。」一只绿色瞳孔的黑猫踏着柔软的猫步蹭上你的小腿。\n同时,「N」不见了。"
  },
  Event_146274_Name = {
    Text = "伏行之黑猫"
  },
  Event_146275_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146275_Desc = {
    Text = "你没有出声，只是任由那道目光穿过烟雾，落回波吕克斯的眼底，一寸也不肯挪开。\n他也没有躲，弟弟总是这样，宁愿把倔强藏在最深处，也不肯先低头。\n殿内的诵唱声、香灰的气味、于丽埃特关于慈悲与献祭的言辞，忽然都变得遥远起来，好像只剩下你们两个人，隔着这满殿虚伪的怜悯，隔着漫长的时光，相互凝望。"
  },
  Event_146275_Name = {Text = "故梦 Ⅲ"},
  Event_146276_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146276_Desc = {
    Text = "此刻，你是你苍白而漫长的记忆的唯一卫兵。\n温迪戈伸长枯槎般的手，指尖直逼你的心口，却在最后一刻被你硬生生挡了回去。\n它踉跄着退回雾中，只留下一句低哑的呓语——\n「你迟早会心甘情愿地，把它们都交给我的……」"
  },
  Event_146276_Name = {Text = "贪食者"},
  Event_146277_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146277_Desc = {
    Text = "那是遥远的梦，名为童年的梦。\n清醒一点。你不在那里。\n你在风雪中，在层层提灯信徒的包围下，而波吕克斯的刀尖正指向你的胸膛。"
  },
  Event_146277_Name = {Text = "故梦 Ⅰ"},
  Event_146278_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146278_Desc = {
    Text = "「我接纳死亡的发生。」\n「我甘愿葬身于苦旅。」\n「绝壁之下，天地为我铸碑。」"
  },
  Event_146278_Name = {
    Text = "死兆将至"
  },
  Event_146279_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146279_Desc = {
    Text = "倒影不过是光的反射现象。\n汀克特看见的，多半也只是她自己的影子。\n她的母星远在千万光年之外，最微小的航路偏差也会使她们坠落在不同的星系。\n如此自我安慰着，你不再执着于脚下的倒影。"
  },
  Event_146279_Name = {
    Text = "湖底倒影"
  },
  Event_146280_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146280_Desc = {
    Text = "来自群星。来自太古。来自人类的尚且未知，或许永恒无知。\n别向祂索求答案。\n你不知晓代价。"
  },
  Event_146280_Name = {
    Text = "冰湖的咏叹"
  },
  Event_146281_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146281_Desc = {
    Text = "你停下脚步，任由那阵苍凉的乐音灌满耳畔。\n风声是提琴，雪粒是鼓点，远处冰层崩裂的轰鸣，是某种压抑已久的、低沉的和声。\n你听不出它的主题，但你知晓，它过往或未来，都将为无数葬身此地的旅人反复奏响。"
  },
  Event_146281_Name = {
    Text = "自然幻奏"
  },
  Event_146283_ChoiceDesc1 = {
    Text = "【仰望天光】所有唤醒体回复Arg1狂气"
  },
  Event_146283_ChoiceDesc2 = {
    Text = "【脚踏冰峰】选择觉醒2名唤醒体"
  },
  Event_146283_Desc = {
    Text = "峰顶在云雾中沉默地闪光。\n山谷、岩壁、风暴，盘踞此处之物从来不是为了人而存在。\n身处其中，你是如此脆弱。"
  },
  Event_146283_Name = {
    Text = "触及巅峰"
  },
  Event_146284_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146284_Desc = {
    Text = "「不，不是你的错。」\n「你只是被上了发条的，命运的玩具罢了。」"
  },
  Event_146284_Name = {
    Text = "贪吃的老鼠"
  },
  Event_146285_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146285_Desc = {
    Text = "「听出来了，你是擅长总结客观经验的那类人。但别忘记，有时候，相似的表象下，其实潜藏着不同的可能性。」铃声笑着远去了。"
  },
  Event_146285_Name = {
    Text = "巴甫洛夫反射"
  },
  Event_146286_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146286_Desc = {
    Text = "如果善恶有报是公平，那么谁来裁定善恶？\n由阿努比斯那个天平吗？\n如果冥界的重力符合物理学原理，你不是很有信心自己的心脏会比那根羽毛更轻。"
  },
  Event_146286_Name = {
    Text = "荒诞的公平"
  },
  Event_146287_ChoiceDesc1 = {
    Text = "【追问】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146287_ChoiceDesc2 = {
    Text = "【沉默】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146287_ChoiceDesc3 = {
    Text = "【道歉】获得25黑印"
  },
  Event_146287_Desc = {
    Text = "「威廉学长，所有人都受到温迪戈蛊惑的时候，你好像第一个醒过来了。接下来就要正面迎战温迪戈群了，有什么秘诀可以传授吗？」\n威廉眸色微动，从他的眼神中你隐约窥见不可捉摸的恍惚，悲伤和宁静。\n像是浸泡在透着光的海水之中，飘飘摇摇地向着晦暗的海底坠去。\n「抱歉，恐怕我没什么能帮上的。」"
  },
  Event_146287_Name = {
    Text = "温柔的沉没"
  },
  Event_146288_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146288_Desc = {
    Text = "「不通人性，不通人性啊。」黑色的身影摇着头出现了，「真相可能是刺骨的毒药。有时候，接受幻象更能维系当下的幸福，不是吗？」"
  },
  Event_146288_Name = {
    Text = "伏行之黑猫"
  },
  Event_146290_ChoiceDesc1 = {
    Text = "【谁是凶手】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146290_ChoiceDesc2 = {
    Text = "【是我的错】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_146290_ChoiceDesc3 = {
    Text = "【贪吃的代价】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146290_Desc = {
    Text = "「小老鼠，爬呀爬。下水道，黑又长。忽然嗅到奶酪香。」\n「小老鼠，拖奶酪，往家跑。脑袋嗡嗡响，脑袋嗡嗡响。」\n「推开门，推开门，家里静无声。」\n「兄弟姐妹躺地上，肚子都有一个洞，一个洞。」"
  },
  Event_146290_Name = {
    Text = "贪吃的老鼠"
  },
  Event_146291_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146291_Desc = {
    Text = "你蹲下身，替她抹去脸颊上的泪痕，没有去问那滴泪的真假。\n「不管是真是假，」你说，「用不着还要证明给谁看。」\n卡拉布张了张口，那句准备好的、用来敷衍的俏皮话终究没能说出来。\n她的眼泪毫无预兆地决堤，砸落在你的手背上。"
  },
  Event_146291_Name = {
    Text = "鳄鱼的眼泪"
  },
  Event_146292_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146292_Desc = {
    Text = "「不要问比较好哦。有些问题不需要知道答案。」"
  },
  Event_146292_Name = {
    Text = "贪吃的老鼠"
  },
  Event_146293_ChoiceDesc1 = {
    Text = "【出声提醒】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146293_ChoiceDesc2 = {
    Text = "【继续聆听】所有唤醒体回复50狂气，感染「(Skill.Arg1)」"
  },
  Event_146293_ChoiceDesc3 = {
    Text = "【耸肩无视】获得3选1刻印"
  },
  Event_146293_Desc = {
    Text = "纳拉卡坠落之地只有黑暗。\n泥泞之中传来潮湿的旋律，如同一双冰冷苍白的手，缠绵地抚过你的面颊。\n它轻声低唱，「来吧，在夜的寂静中到我这来。」"
  },
  Event_146293_Name = {
    Text = "留恋之声"
  },
  Event_146294_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146294_Desc = {
    Text = "你低下头，任由那片烟雾模糊了波吕克斯的轮廓，连同他此刻的表情，一并藏进了灰白的雾气里。\n这样最安全——你告诉自己，不必去看，不必去想。\n于丽埃特的宣讲仍在耳边流淌，你死死盯着自己交叠的双手，一言不发。\n直到仪式的钟声敲响，你才敢重新抬眼。\n而波吕克斯始终保持着他虔诚的姿态。\n隔着漫长的时光与幻想，你不清楚是否有什么东西在那个刹那溜走了。"
  },
  Event_146294_Name = {Text = "故梦 Ⅲ"},
  Event_146295_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146295_Desc = {
    Text = "「波吕克斯——」你的声音刚冲出喉咽，就被自己死死咽了回去，只余下气音般的一点残响，散在香烟里。\n身侧信徒诵经的声浪不曾停顿，却有几道目光不易察觉地扫了过来。\n波吕克斯猛地一僵，眼底闪过一丝惊慌，随即又迅速被那副训练出来的恭顺神情盖住。\n他没有回应，只是垂着眼，指尖却在袖中悄悄蜷紧——你知道，他听见了。"
  },
  Event_146295_Name = {Text = "故梦 Ⅲ"},
  Event_146297_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146297_Desc = {
    Text = "至少在那个时刻，你做不到眼睁睁地看着她一个人被驱离队伍。\n当下需要解决的问题，就交给当下的自己吧。"
  },
  Event_146297_Name = {Text = "计中计"},
  Event_146298_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146298_Desc = {
    Text = "「波吕克斯，我们最好向不同的方向走。这样，我们就会有更大的几率找到森林的边界。」\n「那你要怎么找到我呢，哥哥？」\n隔着朦胧的时光，你望见他失落的神情。痛楚的感觉绞住了你的心脏。你深吸一口气，缓缓吐出。\n「我们是双子。我们能阅读彼此的心跳。」\n「我们永不分离。」"
  },
  Event_146298_Name = {Text = "故梦 Ⅰ"},
  Event_146299_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146299_Desc = {
    Text = "它在审判，它在质问。它赐予所有无还的挑战者冰冷的死亡。"
  },
  Event_146299_Name = {
    Text = "雪线的审判"
  },
  Event_146300_ChoiceDesc1 = {
    Text = "【重新开始】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146300_ChoiceDesc2 = {
    Text = "【这很艰难】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146300_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_146300_Desc = {
    Text = "蠕虫教会她谎言。\n除此之外，她从未学过如何生存。\n但谎言终究只是谎言，从某一天开始，你必须在没有它支撑的情况下活下去。"
  },
  Event_146300_Name = {
    Text = "是幻非真"
  },
  Event_146301_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146301_Desc = {
    Text = "「是啊，可是那么小的老鼠，怎么会知道贪吃的代价是什么呢？」"
  },
  Event_146301_Name = {
    Text = "贪吃的老鼠"
  },
  Event_146302_ChoiceDesc1 = {
    Text = "【系上红绳】删除1张指令卡，获得Arg1黑印"
  },
  Event_146302_ChoiceDesc2 = {
    Text = "【拒绝红绳】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_146302_ChoiceDesc3 = {
    Text = "【回到现实】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146302_Desc = {
    Text = "第一场梦。在森林里的梦。两个不足十岁的孩子，被教主抛在幽深的森林中。\n「入夜后，那些沉睡的野兽就要开始猎食了。在那之前逃出去吧。逃出去的，才是我的好孩子噢。」\n弟弟拉住他的手，掏出一截红绳。\n「哥哥，把手系在一起吧。这样，我们就不会走散了。」"
  },
  Event_146302_Name = {Text = "故梦 Ⅰ"},
  Event_146304_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146304_Desc = {
    Text = "你听见了嬉笑声。\n喜悦的，挑衅的，饱含趣味的。\n人类倾尽全力对宇宙的探索，在祂们的眼中不过蚂蚁的攀行。"
  },
  Event_146304_Name = {
    Text = "被俯瞰者"
  },
  Event_146306_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146306_Desc = {
    Text = "它将净化。它将消融。它将所有无还的攀登者纳入其中。"
  },
  Event_146306_Name = {
    Text = "雪线的审判"
  },
  Event_146307_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146307_Desc = {
    Text = "你和乌鸦陷入了僵持。\n显而易见的是，在这场对峙中，你无法成为最后的赢家。\n在与于丽埃特的对抗中，你们仿佛永远不会是。"
  },
  Event_146307_Name = {Text = "故梦 Ⅱ"},
  Event_146308_ChoiceDesc1 = {
    Text = "【谁在看我？】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_146308_ChoiceDesc2 = {
    Text = "【专注眼下】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146308_Desc = {
    Text = "裹挟着冰雪的风呼啸过人类足迹的至高之地。\n你仰头而望，更高处只有亘古不熄的太阳。\n但你知道，在更高更远的某处，还有无数双眼睛，或张，或合。\n其中几双，正静静地俯瞰着你脚下的整个世界。"
  },
  Event_146308_Name = {
    Text = "被俯瞰者"
  },
  Event_146309_ChoiceDesc1 = {
    Text = "【我仍怀不舍】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146309_ChoiceDesc2 = {
    Text = "【我已然忘却】随机1张卡牌获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146309_Desc = {
    Text = "你试着封闭大脑中存储「记忆」的模块。\n那座秘密的匣子中藏匿着构成你全部的答案，你所有羞于启齿的念头，你所有不愿示人的遐思。\n可欲望是潜意识的魔咒，你无法抵抗的痴迷幻梦。"
  },
  Event_146309_Name = {
    Text = "潜意识魔咒"
  },
  Event_146310_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146310_Desc = {
    Text = "威廉避开了你的目光。\n「意识是对抗蛊惑的武装。而每个人的人生经历决定了他的意识，无法替代，也无法传授。」\n「我能告诉你的只有，不要放任自己被软弱吞没。」"
  },
  Event_146310_Name = {
    Text = "温柔的沉没"
  },
  Event_146311_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146311_Desc = {
    Text = "「听出来了，你是想当哲学家的那类人。但别忘记，没有期待，不等于没有痛苦。」铃声笑着远去了。"
  },
  Event_146311_Name = {
    Text = "巴甫洛夫反射"
  },
  Event_146312_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_146312_Desc = {
    Text = "「饿啊，饿啊。」\n山在哭叫，山在哀嚎。\n山无法承受，它的腹内空空。"
  },
  Event_146312_Name = {
    Text = "山的秘密"
  },
  Event_146313_ChoiceDesc1 = {
    Text = "【踢踏岩壁】删除1张指令卡，并回复 Arg1 点生命"
  },
  Event_146313_ChoiceDesc2 = {
    Text = "【抓住安全绳】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146313_Desc = {
    Text = "五光十色的幻觉在你的脑海中翻搅。\n最初是松动的粉雪。\n然后是坍塌的雪檐。\n你无法阻止自己滑落，安全绳在绳扣的摩擦下激起刺目的火花。\n但在群山面前，它是那么渺小而脆弱。"
  },
  Event_146313_Name = {
    Text = "无声坠落"
  },
  Event_146314_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146314_Desc = {
    Text = "「在梦中到我这来吧，让我能够重新活过我的生命。」\n留声机发出一声呜咽，然后呼吸声逐渐在黑暗里淡去。\n只余回声。只有回声。"
  },
  Event_146314_Name = {
    Text = "留恋之声"
  },
  Event_146315_ChoiceDesc1 = {
    Text = "【心生悔意】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_146315_ChoiceDesc2 = {
    Text = "【都是命运的安排】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146315_Desc = {
    Text = "你一直都知道这趟旅程并不如想象中简单，这支登山队中的攀登者多半各怀鬼胎。\n但你望着卡拉布渐入疯狂的狂妄笑脸时，仍有一丝玻璃碎裂的声音在你胸口炸开。\n或许当纳拉卡要将她逐出队伍的时候，你应该做出另一个选择。"
  },
  Event_146315_Name = {Text = "计中计"},
  Event_146316_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146316_Desc = {
    Text = "有多少人曾被吞噬于此？\n黏稠的深潭伸出黑色的手，试图将你拖入他们的世界。\n而你只是前行，它们似乎也无意挽留，一一退去了。\n前面还有顶峰在等你。"
  },
  Event_146316_Name = {
    Text = "留恋之声"
  },
  Event_146317_ChoiceDesc1 = {
    Text = "【放弃】获得25黑印"
  },
  Event_146317_ChoiceDesc2 = {
    Text = "【俯身查看】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146317_Desc = {
    Text = "循着汀克特的目光，你忍不住凝视湖底。\n那倒影中究竟有什么在吸引着她？\n但你看不清，冰面上影影绰绰地只倒映出你自己的影子。"
  },
  Event_146317_Name = {
    Text = "湖底倒影"
  },
  Event_146318_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146318_Desc = {
    Text = "抵抗吞噬的方式唯有舍弃。\n任何人都无法失去自己不曾拥有之物。\n温迪戈龇着牙，喉间发出不甘的低吼，一步步退回雾里。"
  },
  Event_146318_Name = {
    Text = "潜意识魔咒"
  },
  Event_146319_ChoiceDesc1 = {
    Text = "【雪将净化我】随机提升1张卡牌的刻印品质"
  },
  Event_146319_ChoiceDesc2 = {
    Text = "【雪将审判我】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146319_Desc = {
    Text = "眼前是最后的攀援，雪线冰冷而绵延。\n积雪白得晃眼，连死亡在这里都显得干净。"
  },
  Event_146319_Name = {
    Text = "雪线的审判"
  },
  Event_146320_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146320_Desc = {
    Text = "别遗漏那画面中的任何细节。\n把它们烙进脑海里。\n把那个瞬间涌现的茫然、空洞和随之涌现的痛苦也烙印下来。\n永远也别忘记。"
  },
  Event_146320_Name = {
    Text = "自彼岸来"
  },
  Event_146321_ChoiceDesc1 = {
    Text = "【共同作战】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_146321_ChoiceDesc2 = {
    Text = "【安抚】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146321_Desc = {
    Text = "山峰猛烈震颤，像一头濒死的活物。\n环节状的苍白血肉从龟裂的岩层下汹涌钻出，一节又一节地拔高、绞缠，将卡拉布狠狠摔下。\n再次出现在你们面前的时候，她的脸颊上已经挂了一行眼泪。\n那是痛苦的泪痕吗？\n你不确定。\n无数谎言曾由她的口中说出，谁还会相信鳄鱼的眼泪？"
  },
  Event_146321_Name = {
    Text = "鳄鱼的眼泪"
  },
  Event_146322_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146322_Desc = {
    Text = "你没有去追问答案，只是站到了她身侧。\n「起来吧，」你说，「戏演到一半，别半途退场。」\n卡拉布怔了一下，随即用力抹了把脸。\n她跌跌撞撞地爬起来，重新握紧了武器，肩并肩地迎向那再度合拢的血盆巨口。\n谎言说了太多，连她自己都快分不清哪滴眼泪的真假了。\n但至少这一次，没有人计算真假。"
  },
  Event_146322_Name = {
    Text = "鳄鱼的眼泪"
  },
  Event_146323_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146323_Desc = {
    Text = "「听出来了，你是擅长破除表象的那类人。但别忘记，在那一刻的现实里，食物只存在你的经验和幻想中。」铃声笑着远去了。"
  },
  Event_146323_Name = {
    Text = "巴甫洛夫反射"
  },
  Event_146324_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146324_Desc = {
    Text = "你放轻放慢了脚步。\n轻轻地、慢慢的、悄无声息地……\n你就这么绕过下一个转角溜走了。\n那只乌鸦究竟有没有追上来呢？\n你早已不记得了。"
  },
  Event_146324_Name = {Text = "故梦 Ⅱ"},
  Event_146325_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146325_Desc = {
    Text = "旋律戛然而止。\n黑色的泥淖中睁开一双渴盼的眼睛。\n那双眼睛湿漉漉地望着你，低声细语着你难以辨别的内容。\n然后缓缓、缓缓地合上了。"
  },
  Event_146325_Name = {
    Text = "留恋之声"
  },
  Event_146326_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146326_Desc = {
    Text = "你没有多停留，将那阵旋律甩在身后，脚步踩碎积雪，发出比风声更急促的声响。\n可即便你走得再快，那苍凉的乐音仍固执地跟在你身后，一步不落。\n你无法逃离——它是这片雪山本身的呼吸，而你，只是恰好途经的渺小听众。"
  },
  Event_146326_Name = {
    Text = "自然幻奏"
  },
  Event_146327_ChoiceDesc1 = {
    Text = "【那就聆听吧】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146327_ChoiceDesc2 = {
    Text = "【不必在意】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_146327_ChoiceDesc3 = {
    Text = "【强行离开】获得3选1刻印"
  },
  Event_146327_Desc = {
    Text = "风中夹杂着悠远的歌声。\n歌声像是从四面八方，或是自地底而来。\n无论你向哪个方向追寻，它都以同样的烈度在耳边回响。"
  },
  Event_146327_Name = {
    Text = "冰湖的咏叹"
  },
  Event_146328_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146328_Desc = {
    Text = "「死兆之星啊，此刻并非你闪耀之时。」\n「我的旅程仍存未抵之终点。」\n「请你暂且熄灭，令今夜的天空重归安宁。」"
  },
  Event_146328_Name = {
    Text = "死兆将至"
  },
  Event_146329_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146329_Desc = {
    Text = "无用的悔意翻涌而上。\n人总是不得已要为过往的自己收拾烂摊子。"
  },
  Event_146329_Name = {Text = "计中计"},
  Event_146330_ChoiceDesc1 = {
    Text = "【咀嚼】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_146330_ChoiceDesc2 = {
    Text = "【拒绝】获得3选1刻印"
  },
  Event_146330_Desc = {
    Text = "雪雾深处伏着一具瘦骨如柴的躯体，肋骨支起干裂的皮囊，头顶两支枯槎般的枝角刺破雾气。\n它的腹中传来空洞的咕鸣。\n你与它对视的刹那，那双深陷的眼窝里翻涌起破碎的画面——那是你的记忆。它已经尝到了滋味。\n「还不够，还不够啊……」它嘶哑地呻吟，朝你伸出干枯的手，姿态竟带着几分祈求。"
  },
  Event_146330_Name = {Text = "贪食者"},
  Event_146332_ChoiceDesc1 = {
    Text = "【天葬】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_146332_ChoiceDesc2 = {
    Text = "【驱赶】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_146332_Desc = {
    Text = "胡兀鹫借着上升气流在高空盘旋，巡视领地。\n在攀登者中，这向来是个坏兆头。\n「它们在觅食。兀鹫能嗅到死亡将近的气息。」"
  },
  Event_146332_Name = {
    Text = "死兆将至"
  },
  Event_146333_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146333_Desc = {
    Text = "信任自己的双腿。\n你将征服巅峰。"
  },
  Event_146333_Name = {
    Text = "触及巅峰"
  },
  Event_146334_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146334_Desc = {
    Text = "不舍的念头蹿上脑海的瞬间，你意识到自己已经无力抵抗，只能任由它长驱直入你那尘封已久的记忆宝库。\n森白的犬齿探入你的太阳穴，一帧一帧的画面被连根拔起。"
  },
  Event_146334_Name = {
    Text = "潜意识魔咒"
  },
  Event_146335_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146335_Desc = {
    Text = "它俯身向你，鼻尖几乎触到你的额头，它的深情陶醉，像是嗅着一块蜜糖。\n那些翻涌不安的情绪被舔食得干干净净。\n它心满意足地哼鸣着退开，眼底翻涌起妖冶的光。\n你的心口空了一块，却又诡异地……轻松了不少。"
  },
  Event_146335_Name = {Text = "贪食者"},
  Event_146336_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146336_Desc = {
    Text = "「注意脚下，每一步都踩严实了，」纳拉卡的声音在你耳畔响起，「别总指望别人帮你兜底。」"
  },
  Event_146336_Name = {
    Text = "被俯瞰者"
  },
  Event_146337_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146337_Desc = {
    Text = "人类应该触碰天空。\n目标能让人忘记危险。\n开阔的天地正在头顶等你。"
  },
  Event_146337_Name = {
    Text = "触及巅峰"
  },
  Event_146338_ChoiceDesc1 = {
    Text = "【驱散回忆】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_146338_ChoiceDesc2 = {
    Text = "【捕捉幻想】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_146338_ChoiceDesc3 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_146338_Desc = {
    Text = "杀死威廉的凶手，此刻就在你的眼前。\n亚兰的帐篷内，令人作呕的空气中，威廉惨白的面庞，漂浮的身体，还有桌上解剖的那枚小提灯，再次浮现在你的脑海。"
  },
  Event_146338_Name = {
    Text = "自彼岸来"
  },
  Event_146339_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146339_Desc = {
    Text = "安全绳应声而断。\n你重重摔进雪堆里，五脏六腑都在钝痛中发出致命的警报。\n顶着目眩睁开眼，一具无名的尸骨与你面面相觑。\n在他空洞的瞳孔中，有什么正闪闪发光。"
  },
  Event_146339_Name = {
    Text = "无声坠落"
  },
  Event_146340_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146340_Desc = {
    Text = "躲不过了。\n你咬咬牙，然后腾身疾驰，妄图凭借速度甩掉监视者。\n乌鸦怪叫一声，扑了扑翅膀，游刃有余地跟在你们上空，甚至轻松地盘绕了一圈。\n冰冷的绝望顺着它的目光渗进身体。\n你们逃不掉的。"
  },
  Event_146340_Name = {Text = "故梦 Ⅱ"},
  Event_146341_ChoiceDesc1 = {
    Text = "【善恶有报】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_146341_ChoiceDesc2 = {
    Text = "【绝对平等】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_146341_Desc = {
    Text = "你吊悬在崖壁上，脑海里却突然浮起一个无关的问题：何谓公平？"
  },
  Event_146341_Name = {
    Text = "荒诞的公平"
  },
  Event_146342_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_146342_Desc = {
    Text = "「我还不能死去！」\n山在哭叫，山在哀嚎。\n山无法承受，它因贪婪而失去了明天的可能。"
  },
  Event_146342_Name = {
    Text = "山的秘密"
  },
  Event_146343_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_146343_Desc = {
    Text = "你俯下身去，直至面颊与冰面相接。\n彻骨的寒冷从皮肤渗入骨髓，你忍不住打了个哆嗦。\n难以辩明的存在在封冻的冰层下缓慢翻滚，是水流或是某种生物？\n无论是哪一者，都与你的旅程无关。"
  },
  Event_146343_Name = {
    Text = "湖底倒影"
  },
  Event_148532_ChoiceDesc1 = {
    Text = "【领受赐福】战斗开始后，生成 1 张随机「万化之果」置入牌库。"
  },
  Event_148532_Desc = {
    Text = "茫茫雪原一望无际，寒风卷不起半点声响，一道说不清来处的幻影悄然浮现，递来一枚温热的果实。\n甜香混着雾气，扑进旅人冻得发麻的鼻腔。 \n这片雪域早已被死亡浸透，空气里飘着腐败与冰寒的反胃气味，唯有掌心这颗果实饱满欲滴，宛如少女诱人的许诺。"
  },
  Event_148532_Name = {
    Text = "上现蜃景"
  },
  Event_20778_ChoiceDesc1 = {
    Text = "【交给她吧】所有唤醒体回复Arg1狂气"
  },
  Event_20778_ChoiceDesc2 = {
    Text = "【需要支援】选择觉醒2名唤醒体"
  },
  Event_20778_Desc = {
    Text = "「这里是来自弥萨格的通讯，监测到唤醒体的异常诺斯指数波动，请问是否需要支援？」"
  },
  Event_20778_Name = {
    Text = "支援通讯"
  },
  Event_20779_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_20779_Desc = {
    Text = "「已为您提供紧急援助，请于查收后敲击三次胸针确认。」"
  },
  Event_20779_Name = {
    Text = "支援通讯"
  },
  Event_20780_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_20780_Desc = {
    Text = "来自遥远未来的幻影，隐没在艾尔沃斯的山隘。"
  },
  Event_20780_Name = {
    Text = "火山幻影"
  },
  Event_20781_ChoiceDesc1 = {
    Text = "【远望幻影】所有唤醒体回复Arg1狂气"
  },
  Event_20781_ChoiceDesc2 = {
    Text = "【靠近幻影】选择觉醒2名唤醒体"
  },
  Event_20781_Desc = {
    Text = "远方似有火山锥喷发，狂风肆虐的天空中升腾起人形的烟雾。\n这可是艾尔沃斯，艾尔沃斯只有连绵不绝的高耸雪山和石灰石岩层的溶洞。\n是连日的异状让你精神错乱了吗？"
  },
  Event_20781_Name = {
    Text = "火山幻影"
  },
  Event_20782_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_20782_Desc = {
    Text = "幻影向你招了招手，然后消失了。留给你的只有寒冷的冰雪和巍峨的山脉。"
  },
  Event_20782_Name = {
    Text = "火山幻影"
  },
  Event_20783_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_20783_Desc = {
    Text = "「收到，我们将进行基础资源输送，请注意查收。」"
  },
  Event_20783_Name = {
    Text = "支援通讯"
  },
  Event_21398_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_21398_Desc = {
    Text = "机械被拆解，真相被揭露。\n鼎沸人生消弭于无形之中，留给你真相大白的满足。"
  },
  Event_21398_Name = {
    Text = "目击证言"
  },
  Event_21399_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_21399_ChoiceDesc2 = {
    Text = "【检查胶卷】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，还可以使用一次"
  },
  Event_21399_Desc = {
    Text = "好奇驱使着你，将视线探向了显影池。\n那些图像浸泡在殷红药水中，而那浑身有着漆黑污渍的罪人，赫然有着与你相同的脸庞。"
  },
  Event_21399_Name = {
    Text = "目击证言"
  },
  Event_21400_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_21400_Desc = {
    Text = "机械被拆解，真相被揭露。\n鼎沸人生消弭于无形之中，留给你真相大白的满足。"
  },
  Event_21400_Name = {
    Text = "目击证言"
  },
  Event_21811_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_21811_Desc = {
    Text = "“二十五年……是的，她让我沉睡了二十五年。”\n少女阴沉、低落地回应着你。\n只一觉醒来，那些从小照顾她的仆从，就伴随年岁的增长变成了彻头彻尾的蹈海者。\n不再有人理解她的苦闷，不再有人关心她的疼痛，让她在教团孤身一人。\n她宁愿沉睡前的那一天，就是「星辰正位之时」。"
  },
  Event_21811_Name = {
    Text = "被禁锢的生命"
  },
  Event_22058_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22058_Desc = {
    Text = "「不，我并不饿。」\n你礼貌推拒了这场盛宴的热烈邀请。\n攫取灵魂的代价，你从不愿为此抵押。"
  },
  Event_22058_Name = {
    Text = "肌体盛宴"
  },
  Event_22059_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22059_Desc = {
    Text = "你胡乱啃咬着淌血的司康，用胡椒腌制的心脏与面团烘烤的香气混杂，你嗅到了熟悉的味道。\n「获取力量，需要付出代价。」\n你饮下最后一口鲜血。"
  },
  Event_22059_Name = {
    Text = "肌体盛宴"
  },
  Event_22060_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22060_Desc = {
    Text = "你将白汤和碎肉囫囵咽下，用衣袖擦尽了唇角的留痕。\n肉质嫩滑，汤底鲜香，至于它曾属于谁？\n不过是你所遗失之物的冰山一角。"
  },
  Event_22060_Name = {
    Text = "肌体盛宴"
  },
  Event_22061_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22061_Desc = {
    Text = "你细细查看着风铃上镌刻的古老刻印。\n它们以常人无法想象的程度扭曲着，似乎并不打算被人理解。\n不被理解，便不被打扰。"
  },
  Event_22061_Name = {
    Text = "锈蚀风铃"
  },
  Event_22062_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22062_Desc = {
    Text = "「不错，你很谨慎。」\n风铃中忽然传来遥远的声音。\n「谨慎会为你带来一点小奖励，但也仅此而已了。」"
  },
  Event_22062_Name = {
    Text = "锈蚀风铃"
  },
  Event_22063_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22063_Desc = {
    Text = "你抚摸着风铃上镌刻的古老刻印。\n它们以常人无法想象的程度扭曲着，似乎并不打算被人理解。\n不被理解，便不被打扰。"
  },
  Event_22063_Name = {
    Text = "锈蚀风铃"
  },
  Event_22064_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22064_Desc = {
    Text = "「啊，真是遗憾……那我只有继续我孤单的独奏了。」 你不知道琴与手是什么时候消失的，但溪水般的琴声永远留在了你心中。"
  },
  Event_22064_Name = {
    Text = "琴边幽灵"
  },
  Event_22065_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22065_Desc = {
    Text = "「啊，能有这样一位朋友，真是荣幸！」 那双手兴奋起来，你完全无法跟上它的速度。直到演奏结束很久，那振奋人心的声音仍然让你心潮澎湃。"
  },
  Event_22065_Name = {
    Text = "琴边幽灵"
  },
  Event_22175_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22175_Desc = {
    Text = "乩板自信满满地滑动着，你的视线也随之来回梭巡。\n然而，祂不过刚指出两个字母，就在凄惨的尖叫中化为了粘稠的黑色浆液。"
  },
  Event_22175_Name = {Text = "通灵板"},
  Event_22176_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22176_Desc = {
    Text = "「数学！数学！！」\n女声咬牙切齿，乩板飞速在数字之间滑动，发出刺耳的木质摩擦声。\n「带着你的数学滚出我的视线！」"
  },
  Event_22176_Name = {Text = "通灵板"},
  Event_22177_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22177_Desc = {
    Text = "「等等，等等！！」\n「问我啊！你为什么不问！」"
  },
  Event_22177_Name = {Text = "通灵板"},
  Event_22178_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22178_Desc = {
    Text = "它从未同此时此刻般跃动，但相对的，内心的孔洞正在被撕裂……"
  },
  Event_22178_Name = {
    Text = "诅咒渴望"
  },
  Event_22179_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22179_Desc = {
    Text = "魂与灵充盈着你的肺部，在寂静中，你不断上浮。\n世界的声音逐一响起，奏鸣着生命的交响。"
  },
  Event_22179_Name = {
    Text = "往世之水"
  },
  Event_22180_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22180_Desc = {
    Text = "一切照常发生，毁灭如约而至，未燃尽的残渣里掩埋着珍贵之物，沉没在阴影中熠熠生辉。"
  },
  Event_22180_Name = {
    Text = "针端之外"
  },
  Event_22181_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22181_Desc = {
    Text = "相遇，离开，擦肩而过。"
  },
  Event_22181_Name = {
    Text = "星月之音"
  },
  Event_22182_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22182_Desc = {
    Text = "心动渐缓，但也许「良心」已得到了少许慰藉……"
  },
  Event_22182_Name = {
    Text = "诅咒渴望"
  },
  Event_22183_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22183_Desc = {
    Text = "你闭上眼，享受这难得的虚无与自由时刻。渐渐地，你感到世界从寂静里孵化而出，生命在寂静中无声绽放。"
  },
  Event_22183_Name = {
    Text = "往世之水"
  },
  Event_22184_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22184_Desc = {
    Text = "你拦住指针，银片闪烁着割开柔软的手心，毁灭尚未降临，你脚下的影子却被浓墨般的夜色生吞。"
  },
  Event_22184_Name = {
    Text = "针端之外"
  },
  Event_22185_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22185_Desc = {
    Text = "「你逃不掉，没有人能抵抗内在的邪恶」\n恶念撕扯着神经，试图将你拉进深渊。但疼痛只让你的神智感到前所未有的清朗。\n恶念无法拥有你，你只会是你自己。"
  },
  Event_22185_Name = {
    Text = "无妄之念"
  },
  Event_22186_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22186_Desc = {
    Text = "「为什么不呢？」\n只要拥抱了那些可怖的念头，所有难题都将迎刃而解，世界上将不再存在名为「伦理」的悖论。"
  },
  Event_22186_Name = {
    Text = "无妄之念"
  },
  Event_22187_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22187_Desc = {
    Text = "银色光幕在眼前闪过，一整沉闷的风带走了所有声音。"
  },
  Event_22187_Name = {
    Text = "无妄之念"
  },
  Event_22188_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22188_Desc = {
    Text = "善变，凄冷，若即若离。"
  },
  Event_22188_Name = {
    Text = "星月之音"
  },
  Event_22189_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22189_Desc = {
    Text = "膨胀，收缩，一触即发。"
  },
  Event_22189_Name = {
    Text = "星月之音"
  },
  Event_22190_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22190_Desc = {
    Text = "虽然稍显鲁莽，可为什么不呢？\n打破一切壁垒，冲向终点。\n就算将思维的湖泊搅出惊天巨浪，就算成为逐日的伊卡洛斯，可你至少达成了目的，不是么？"
  },
  Event_22190_Name = {
    Text = "思维迷宫"
  },
  Event_22191_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22191_Desc = {
    Text = "你的大脑是一所迷宫，而你是它的阿里阿德涅。\n这个宇宙中，没人比你更懂如何走出迷宫。\n没有人。"
  },
  Event_22191_Name = {
    Text = "思维迷宫"
  },
  Event_22192_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22192_Desc = {
    Text = "在正确的调律下，不协和的音程柔和了些许。\n但或许，你还有什么能做到的。"
  },
  Event_22192_Name = {
    Text = "不协和音"
  },
  Event_22193_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22193_Desc = {
    Text = "你是音乐大师，也是普通的音痴。\n音符在你的思维控制下各司其职，流动的生命终于在密境中奏响。"
  },
  Event_22193_Name = {
    Text = "不协和音"
  },
  Event_22194_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22194_Desc = {
    Text = "你的声音湮没在寂静里。寂静的声音越来越大，越来越响，直到彻底破碎，留下一地残骸。"
  },
  Event_22194_Name = {
    Text = "往世之水"
  },
  Event_22195_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22195_Desc = {
    Text = "你并不会轻易上当，干脆利落地转身，离开了这里。"
  },
  Event_22195_Name = {
    Text = "爬行裂痕"
  },
  Event_22293_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22293_Desc = {
    Text = "提笔瞬间，信纸在密境中燃烧，烟灰簌簌落在手中，\n回过神来时，有什么东西随着信纸一同消散了。"
  },
  Event_22293_Name = {
    Text = "单向倾诉"
  },
  Event_22294_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22294_Desc = {
    Text = "信纸消散在密境中的瞬间，你听见了温和而虚弱的关心。\n「在这种境况下能想起我，是我身为老师的荣幸。\n不过，我上次行走于密境中，已经是太久太久前的事情。如今的我，只能帮到你这些……」"
  },
  Event_22294_Name = {
    Text = "单向倾诉"
  },
  Event_22295_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22295_Desc = {
    Text = "信纸消散在密境中的瞬间，你听见了急切的惊呼。\n「守密人，如果有任何不舒服的地方，请一定要让我知道。\n作为搭档，我会不留余力帮助你。」"
  },
  Event_22295_Name = {
    Text = "单向倾诉"
  },
  Event_22296_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22296_Desc = {
    Text = "信纸消散在密境中的瞬间，你听见了一声冷淡的叹息。\n「如果你在考试不合格时，也能这么积极寻求帮助就好了。」"
  },
  Event_22296_Name = {
    Text = "单向倾诉"
  },
  Event_22397_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22397_Desc = {
    Text = "你的出现让影子们面面相觑，一束星光从鞋尖拂过后，那人群陡然消散，只在你的手中留下了最凝实的影子。"
  },
  Event_22397_Name = {
    Text = "星月之约"
  },
  Event_22398_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_22398_Desc = {
    Text = "嘈杂的私语戛然而止，漆黑如墨的影子接连转向你，凝视你。从那无五官的脸上，你竟读出了几分讥讽之意……"
  },
  Event_22398_Name = {
    Text = "星月之约"
  },
  Event_22399_ChoiceDesc1 = {
    Text = "【冷静观察】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_22399_ChoiceDesc2 = {
    Text = "【出声问询】获得25黑印"
  },
  Event_22399_Desc = {
    Text = " 在星与月的交织中，窃窃私语不绝于耳。\n「就是这个人吗？@4之人……」\n「人类之身，终究还是@3…」"
  },
  Event_22399_Name = {
    Text = "星月之约"
  },
  Event_22411_ChoiceDesc1 = {
    Text = "【大功告成】"
  },
  Event_22411_Desc = {
    Text = "廉价但好用的陷阱！"
  },
  Event_22411_Name = {
    Text = "制作陷阱"
  },
  Event_24254_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24254_Desc = {
    Text = "灵知的风暴环绕在图鲁周身，你与他对视一眼，前后脚深入黑暗。"
  },
  Event_24254_Name = {
    Text = "自海中而来"
  },
  Event_24255_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24255_Desc = {
    Text = "灵知的风暴环绕在图鲁周身，而那长久不散的悲伤与内疚，则在空间中蔓延开来。"
  },
  Event_24255_Name = {
    Text = "直面深渊"
  },
  Event_24256_ChoiceDesc1 = {
    Text = "【握住触肢】接受图鲁的帮助"
  },
  Event_24256_Desc = {
    Text = "他的威仪如巨物坠海般，激荡着眼前的密境。\n那力量古朴、久远、足以超越万古。\n值得庆幸的是，你不会与他为敌，至少当下不会。"
  },
  Event_24256_Name = {
    Text = "自海中而来"
  },
  Event_24257_ChoiceDesc1 = {
    Text = "【握住触肢】与图鲁同行"
  },
  Event_24257_Desc = {
    Text = "图鲁深呼吸一口气，远远看着弥利亚姆。\n仿佛在怀念历史、怀念故人、怀念自己的生命……\n他脸上的复杂神色停留了不过须臾时间，他就从弥利亚姆脸上移开了目光。\n「走吧，离开她。」"
  },
  Event_24257_Name = {
    Text = "直面深渊"
  },
  Event_24277_ChoiceDesc1 = {
    Text = "【关上舱门】"
  },
  Event_24277_Desc = {
    Text = "拉蒙娜拉住了自门外闯入的学生。\n那无畏而坚强的守密人，明明除了浑身狼狈不堪外并无异样，身影在她镜片下的碧蓝眼中竟显得影影绰绰。\n直到拉住手的瞬间，拉蒙娜才得以确认：你们得到了重逢。"
  },
  Event_24277_Name = {
    Text = "喜悦的重逢"
  },
  Event_24278_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24278_Desc = {
    Text = "拉蒙娜没给你留解释的机会，她将你拉进了昏暗的舱室，小心翼翼阖上了舱门……"
  },
  Event_24278_Name = {
    Text = "喜悦的重逢"
  },
  Event_24540_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24540_Desc = {
    Text = "「她是你坚实的护盾，是你手中的利剑。\n她是你的伙伴，你的搭档，你信赖的朋友——不论她变成什么样。」"
  },
  Event_24540_Name = {
    Text = "陌生且熟悉的存在"
  },
  Event_24541_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24541_Desc = {
    Text = "「是你……不，这不可能，这个轮回的你已经……我也已经……」\n声音随着身影消散，只有悲伤仍在水雾中徘徊。"
  },
  Event_24541_Name = {
    Text = "熟悉且陌生的身影"
  },
  Event_24542_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24542_Desc = {
    Text = "「为了世界，为了人类，为了我们所珍视的一切。\n当然，还有最重要的——她是为了你。」"
  },
  Event_24542_Name = {
    Text = "陌生且熟悉的存在"
  },
  Event_24543_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_24543_Desc = {
    Text = "你还未靠近人影便注意到了你，祂身形一顿，像是震惊，又像是骤然陷入了巨大的悲哀。\n还未等你说些什么，祂便与雾气一同消散了。"
  },
  Event_24543_Name = {
    Text = "熟悉且陌生的身影"
  },
  Event_24544_ChoiceDesc1 = {
    Text = "【她是谁？】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_24544_ChoiceDesc2 = {
    Text = "【她为什么变成这样？】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24544_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_24544_Desc = {
    Text = "又一道迷雾，又一道身影。与先前不同，这次你将对方看得一清二楚。\n与你一模一样的身形，与你一模一样的制服，与你一模一样的面容。\n「你知道你为什么在这里，」那个人说，「正如你知道她为什么变成那副模样。」"
  },
  Event_24544_Name = {
    Text = "陌生且熟悉的存在"
  },
  Event_24545_ChoiceDesc1 = {
    Text = "【出声安慰】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24545_ChoiceDesc2 = {
    Text = "【试图靠近】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_24545_ChoiceDesc3 = {
    Text = "【转身离开】获得25黑印"
  },
  Event_24545_Desc = {
    Text = "迷雾笼罩了你前行的道路。\n一个身影在朦胧的光影中浮现，你眯起眼睛，却怎么也看不清祂的面容，只能听到断断续续的低语。\n「为什么……为什么无法救下……命运，真的无法改变吗……」"
  },
  Event_24545_Name = {
    Text = "熟悉且陌生的身影"
  },
  Event_35039_ChoiceDesc1 = {
    Text = "【求助合伙人】获得3选1高级刻印"
  },
  Event_35039_ChoiceDesc2 = {
    Text = "【进行片场统筹】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_35039_ChoiceDesc3 = {
    Text = "【引导现象级狂热】获得造物「(RelicConfig.Arg1)」"
  },
  Event_35039_Desc = {
    Text = "“《霍迪妮大师的片场指南》中明确指出，卡茜亚，也就是本人，作为制片人兼导演，有对整部影片负责的义务和权力。因此卡茜亚勇敢的员工啊，请选择你接下来的行动排期吧！”\n“排、排期？等等，我什么时候变成了你的员工？！”\n“机不可失时不再来，别再犹豫！”"
  },
  Event_35039_Name = {
    Text = "制片人的迷思"
  },
  Event_35103_ChoiceDesc1 = {
    Text = "【接通】回复 Arg2 点生命[ExDesc1][ExDesc2]。"
  },
  Event_35103_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_35103_ChoiceDesc3 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_35103_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_35103_Name = {Text = "联络点"},
  Event_35103_Tips3 = {
    Text = "当前并未拥有症状卡"
  },
  Event_35165_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35165_Desc = {
    Text = "犹豫之间，你主动发出了对神秘资助人的通讯请求。\n“事已至此，骑虎难下。还请勋爵慷慨解囊……”\n银芯通讯器对面传来了格外豪爽的笑声，对方最终笑着应承下了你的请求。\n“对了，还有……这件事请务必对拉蒙娜保密。”"
  },
  Event_35165_Name = {
    Text = "制片人的迷思"
  },
  Event_35236_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35236_Desc = {
    Text = "片场统筹是做什么的？你掏出了卡茜亚不知何时塞进灵知转印器中的一沓文件，仔细看了起来。\n然后，你开始头痛。\n片场布置过程中萝坦造成的损耗、奥瑞塔和布朗吃掉的零嘴、卡茜亚购置魔法小球的报销申请……一笔笔结算款项摆在你面前，你不得不痛苦地蹲在地上进行演算。\n话说回来，卡茜亚的魔法小球是什么？"
  },
  Event_35236_Name = {
    Text = "制片人的迷思"
  },
  Event_35259_ChoiceDesc1 = {
    Text = "【驱散幻象】感染症状[ExDesc1][ExDesc2]。"
  },
  Event_35259_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_35259_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_35259_Name = {Text = "幻象"},
  Event_35497_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35497_Desc = {
    Text = "现象级狂热的背后需要推手，而一谈到「推手」，一个绿色短发的少女身影就跃入了脑海。\n“弥萨格大学第一掮客，汉娜·皮斯利竭诚为您服务！”\n“如果是守密人的首次服务需求，只需要付出3顿食堂咖喱套餐的报酬哦！”"
  },
  Event_35497_Name = {
    Text = "制片人的迷思"
  },
  Event_35887_ChoiceDesc1 = {
    Text = "【前行】"
  },
  Event_35887_Desc = {
    Text = "你掀起了船帆，那下面竟一无所有。回过神时，那船帆也已消失不见。\n纯白之帆和少女若隐若现的面庞，变成了一个讯息，提醒你不论前路如何，你都不是孤单一人。"
  },
  Event_35887_Name = {
    Text = "纯白之帆"
  },
  Event_35888_ChoiceDesc1 = {
    Text = "【掀起船帆】"
  },
  Event_35888_Desc = {
    Text = "这里没有风，却有一艘洁白无瑕的帆船，它的帆蓬勃地升起，挺立在幽静的湛蓝海面上。\n你隐约看到了一个少女的面容，她的五官模糊不清，就像是通过一层薄雾或是一片流动的水面。她的存在似乎与周围的一切隔绝，却又是这一幕的核心。\n尽管她的形象不断地在波动中变得清晰或模糊，但毫无疑问，你知道她是谁。"
  },
  Event_35888_Name = {
    Text = "纯白之帆"
  },
  Event_35894_ChoiceDesc1 = {
    Text = "【向下坠落】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_35894_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_35894_Desc = {
    Text = "少女的声音在空气中弥散开，如泡影般模糊悠远。"
  },
  Event_35894_Name = {
    Text = "死生边缘"
  },
  Event_35895_ChoiceDesc1 = {
    Text = "【周而复始】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_35895_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_35895_Desc = {
    Text = "肢体分外沉重，雾霾紧锁着羸弱的身躯。"
  },
  Event_35895_Name = {
    Text = "死生边缘"
  },
  Event_35896_ChoiceDesc1 = {
    Text = "【阅读前人的路】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35896_ChoiceDesc2 = {
    Text = "【书写自己的路】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35896_ChoiceDesc3 = {
    Text = "【目视黑暗】获得25黑印"
  },
  Event_35896_Desc = {
    Text = "如果你是一个人在密境中摸索前进，一定不会像现在这般笃定自己的前路。\n密境中的足迹分为了三条，印下的每道足印，都书写着不可见的未来。"
  },
  Event_35896_Name = {Text = "出路"},
  Event_35897_ChoiceDesc1 = {
    Text = "【搀扶她】"
  },
  Event_35897_ChoiceDesc2 = {
    Text = "【看着她】"
  },
  Event_35897_Desc = {
    Text = "她呢喃着，跌转着停在了你的面前。\n不知何人惊扰了她的安眠，她的意识被现实束缚，灵魂却停留在了失落的国度中。"
  },
  Event_35897_Name = {
    Text = "失落的幻影"
  },
  Event_35898_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35898_Desc = {
    Text = "在这片混沌未辨的黑暗中，一连串模糊的脚印伸展开去，像是夜行者在无形的沙漠上留下的深邃足迹。"
  },
  Event_35898_Name = {Text = "出路"},
  Event_35899_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35899_Desc = {
    Text = "眼里映出了一座远方的灯塔，她孤独地矗立在黑暗的边缘，发出微弱却坚定的光芒，像是夜海中的向导，召唤着彷徨的灵魂向往彼岸的安宁。\n你忍不住追了上去，然而，脚下突然不再坚实。\n你踩进了一片隐匿在暗影之下的水域。水面柔和如丝，无声地吞噬了你的脚步。"
  },
  Event_35899_Name = {Text = "闪烁"},
  Event_35900_ChoiceDesc1 = {
    Text = "【倾听她】"
  },
  Event_35900_ChoiceDesc2 = {
    Text = "【无视她】"
  },
  Event_35900_Desc = {
    Text = "你看清了灯火的源头，那赫然是一名有着女性身姿的角色。\n流光从异形的头颅下倾泻而出，铺就一条通往未知之路。\n「回到……利@2亚……」"
  },
  Event_35900_Name = {
    Text = "长明灯火"
  },
  Event_35901_ChoiceDesc1 = {
    Text = "【靠近灯塔】"
  },
  Event_35901_ChoiceDesc2 = {
    Text = "【远离灯塔】"
  },
  Event_35901_Desc = {
    Text = "转过了现实与梦境交错的拐角，在那个转瞬即逝的瞬间，眼前铺展开一幅风暴的可怖图景。\n仿佛被一只巨大无形的手掀起，狂风如猛兽咆哮，卷起了尘埃与希望，天空沉沉，压抑至极。\n在风暴的心脏，那不应存在的灯塔矗立着，似乎是幻想的产物，又仿佛是古老传说中的遗迹。它在狂风肆虐的舞台上，孤独而顽强地发出微弱的亮光。"
  },
  Event_35901_Name = {
    Text = "风暴中央"
  },
  Event_35902_ChoiceDesc1 = {
    Text = "【离开】获得 50 黑印"
  },
  Event_35902_Desc = {
    Text = "「密境中，灯火长明、身怀触肢的幻影……」\n图鲁闭眼思忖，片刻后，长叹一口悠长的气。\n「利莫里亚的守门人……余的侍从之一。她终究也没能逃过执念的捆绑。」"
  },
  Event_35902_Name = {
    Text = "索纳尼尔号的沉没"
  },
  Event_35903_ChoiceDesc1 = {
    Text = "【触碰银光】获得25黑印"
  },
  Event_35903_ChoiceDesc2 = {
    Text = "【与银光对话】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35903_Desc = {
    Text = "严丝合缝的通讯器被撬开了一道缝隙，黯淡的光从中流溢而出——这恐怕是银芯被封入通讯器中枢后，首次与外部世界的对话。"
  },
  Event_35903_Name = {
    Text = "秘银丰碑"
  },
  Event_35904_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」"
  },
  Event_35904_Desc = {
    Text = "「头颅发光的女人？」埃尔顿面露惊愕，显然，他对货轮密境中偶现的身影有所耳闻，只是——\n「索纳尼尔号沉没那夜……也就是我唤醒希莱斯特的那一夜，我曾在风暴中见过那样的影子。」\n「我绝对没有看错。」"
  },
  Event_35904_Name = {
    Text = "索纳尼尔号的沉没"
  },
  Event_35905_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35905_Desc = {
    Text = "密境前路危机四伏，深不可测。\n你的眼睛死死盯着不可见的混沌，但在你被混沌吞噬前，解决追兵的拉蒙娜就一把擒住了你，将你拐向了另一头。"
  },
  Event_35905_Name = {Text = "出路"},
  Event_35906_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35906_Desc = {
    Text = "那是你神秘灵魂孕育出的果实吗？现在所经历的一切都是自我与超我的对撞吗？\n越去想，脑中的杂音越响亮清澈。视线闯进了一片迷雾，在你马上就能窥见迷雾中人的上一秒，灵魂拒绝了你。"
  },
  Event_35906_Name = {
    Text = "倒错的命运"
  },
  Event_35907_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35907_Desc = {
    Text = "它在体内涌动，化为无畏的力量，支撑你冲破迷雾、撕裂恐惧。"
  },
  Event_35907_Name = {Text = "逐光"},
  Event_35908_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35908_Desc = {
    Text = "随着意识的集中和内心的平静混乱的幻象开始慢慢溶解，最后像是潮水般退去。\n最终，大脑中的噪音也消失得无影无踪——只是，你会错过多少？无从得知。"
  },
  Event_35908_Name = {
    Text = "未来预警"
  },
  Event_35909_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35909_Desc = {
    Text = "灵魂彻底迷失在了耳鸣中，你努力地想要挣脱，想要解读这份痛苦，却无论如何都只是在意识的边缘徘徊……"
  },
  Event_35909_Name = {
    Text = "死生边缘"
  },
  Event_35910_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_35910_Desc = {
    Text = "你能感受到那灯塔发出的每一个光点，它们在风暴中燃烧、跳跃，就像是灵魂深处的呼唤，即使是在最汹涌澎湃的恐惧中，也不曾放弃引领归途的使命。"
  },
  Event_35910_Name = {
    Text = "风暴中央"
  },
  Event_35911_ChoiceDesc1 = {
    Text = "【离开】获得3选1高级刻印"
  },
  Event_35911_Desc = {
    Text = "是希望的象征，还是毁灭的预兆？\n你不再看它，仿若它的存在只是一场精心编排的幻梦。"
  },
  Event_35911_Name = {
    Text = "风暴中央"
  },
  Event_35912_ChoiceDesc1 = {
    Text = "【沉沦迷离】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_35912_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_35912_Desc = {
    Text = "然后，你的眼前蒙上了一层异常的灰纱。须臾后，你意识到那是你半透明的上眼睑。"
  },
  Event_35912_Name = {
    Text = "死生边缘"
  },
  Event_35913_ChoiceDesc1 = {
    Text = "【离开】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_35913_Desc = {
    Text = "你的心中涌起了一种说不清的共鸣。\n但理智告诉你：无视她。"
  },
  Event_35913_Name = {
    Text = "长明灯火"
  },
  Event_35914_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35914_Desc = {
    Text = "她的语言不曾刻在任何已知碑文之上，却在空气中凝结成了最深沉的忏悔与呼唤。像是从时光的另一端飘来，穿越了岁月的沉淀，带着对一个遥远家园的深情眷恋。"
  },
  Event_35914_Name = {
    Text = "长明灯火"
  },
  Event_35915_ChoiceDesc1 = {
    Text = "【握住她的手】随机1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_35915_ChoiceDesc2 = {
    Text = "【出声关心】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35915_ChoiceDesc3 = {
    Text = "【注视她】获得25黑印"
  },
  Event_35915_Desc = {
    Text = "墨菲落在队伍的最后，她与希莱斯特并肩行走。\n你忍不住频频回头去看她，但墨菲始终低头看着自己的鞋尖，将神情藏在未知中。"
  },
  Event_35915_Name = {
    Text = "疼痛管理"
  },
  Event_35915_Tips1 = {
    Text = "尚未拥有白银造物"
  },
  Event_35916_ChoiceDesc1 = {
    Text = "【无法抽身】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_35916_ChoiceDesc2 = {
    Text = "【拥抱现实】获得25黑印"
  },
  Event_35916_Desc = {
    Text = "@1@1重获新生，灵魂穿越@2的边缘，却还未完全拥抱肉身。\n墨菲关切的话语与你的意识渐行渐远，如同乌鸦的哀嚎，萦绕在耳畔，却始终被心灵的壁垒挡在窗外。"
  },
  Event_35916_Name = {
    Text = "死生边缘"
  },
  Event_35917_ChoiceDesc1 = {
    Text = "【离开】选择复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_35917_Desc = {
    Text = "她只是遗留在现实中的幽灵，一个无法触及，却又挥之不去的远古残章。"
  },
  Event_35917_Name = {
    Text = "失落的幻影"
  },
  Event_35918_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_35918_Desc = {
    Text = "在那一刹那，你听见了灵魂深处细微的碎裂声。如逐渐消散的烟雾，她的形象开始晕染，变得越来越不真实。\n她并非存在于此，这只是埃尔顿船长记忆的投射。\n但停留在内心的，属于她的失落与迷茫，不似作假。"
  },
  Event_35918_Name = {
    Text = "失落的幻影"
  },
  Event_35919_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35919_Desc = {
    Text = "在指尖接触的瞬间，一种复杂的感觉突然涌上心头——它既滚烫又冰冷。\n被世界遗忘的灵魂，正呼啸着寻求永世。"
  },
  Event_35919_Name = {
    Text = "秘银丰碑"
  },
  Event_35920_ChoiceDesc1 = {
    Text = "【握紧火种】提高 Arg1 点最大生命"
  },
  Event_35920_ChoiceDesc2 = {
    Text = "【直面内心】随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染2张「(Skill.Arg2)」"
  },
  Event_35920_Desc = {
    Text = "在这场声势浩大的狩猎中，戈利亚的追逐如幽夜中的猛兽，企图吞噬一切希望的光。然而，这无情的追逐并未将你冻结，反而点燃了内心深处的火种，它在胸膛里蔓延、燃烧，变得越来越炽热。"
  },
  Event_35920_Name = {Text = "逐光"},
  Event_35921_ChoiceDesc1 = {
    Text = "【解读它】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_35921_ChoiceDesc2 = {
    Text = "【成为它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35921_ChoiceDesc3 = {
    Text = "【无视它】获得25黑印"
  },
  Event_35921_Desc = {
    Text = "在迈出脚步的瞬间，一种无形的震颤硬生生扯住了你的意识，迫使你的双眼看向密境混沌虚无的边界。"
  },
  Event_35921_Name = {
    Text = "未来预警"
  },
  Event_35922_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35922_Desc = {
    Text = "有的是光怪陆离的色彩在眼前舞动，有的是声音在耳边低语，又或是闪过的场景和模糊的面孔，它们交织在一起，仿佛在讲述着一个又一个未知的故事。这些幻象让你感觉自己逐渐分离现实，陷入了一个既熟悉又陌生的梦境之中。"
  },
  Event_35922_Name = {
    Text = "未来预警"
  },
  Event_35923_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35923_Desc = {
    Text = "震颤并非来自外界的噪音或是触觉上的震动，而是一阵难以名状的、内心深处的预感。就像是某种未来的呼声，在你的知觉上跳动。"
  },
  Event_35923_Name = {
    Text = "未来预警"
  },
  Event_35924_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35924_Desc = {
    Text = "她的手不自觉地抚向胸口，力图控制那种让人窒息的感觉。\n这种恐惧让她咬紧牙关，强迫自己忽略肆虐于胸腔的阵痛。墨菲脸上的每一次微小的扭曲都被她迅速掩饰过去，用一种拙劣的伪装来隐藏着痛苦。\n——直到你握住她的手，惊讶才成为了她脸上的颜色。"
  },
  Event_35924_Name = {
    Text = "疼痛管理"
  },
  Event_35925_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35925_Desc = {
    Text = "「墨菲？你还好吗？」\n——她没有回应你。\n有形的怪异腐蚀着她的心，让她几乎无法呼吸。"
  },
  Event_35925_Name = {
    Text = "疼痛管理"
  },
  Event_35926_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35926_Desc = {
    Text = "你不再犹豫，一脚踏入了漆黑的未知中。所行之处，描绘出一条朝着微光蔓延的路线图。"
  },
  Event_35926_Name = {Text = "出路"},
  Event_35927_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35927_Desc = {
    Text = "你的眼前有一团跳动的火。\n它热烈、鲜活，包裹着一束摇曳的冷焰火，明晃晃地驱散了那些不谐之音。\n你回过神来，只发现眼前是回头疑惑看着你的墨菲——\n「你真的还好吗？」"
  },
  Event_35927_Name = {
    Text = "死生边缘"
  },
  Event_35928_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35928_Desc = {
    Text = "你感觉意识开始分离，慢慢地被拽离身体。\n仿佛看见自己的灵魂正与这银芯残存意识共舞，然后沉沉地落进一个不可见的深渊……\n那里是纯粹的虚无。"
  },
  Event_35928_Name = {
    Text = "秘银丰碑"
  },
  Event_35929_ChoiceDesc1 = {
    Text = "【离开】获得 25 黑印"
  },
  Event_35929_Desc = {
    Text = "没等你继续深究灯火的源头，它猛然震颤后，搅碎在了空气中。\n灯光在密境中泛起层层涟漪，向四周扩散。\n然后什么都没能留下。"
  },
  Event_35929_Name = {Text = "闪烁"},
  Event_35930_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35930_Desc = {
    Text = "那怎么可能是你呢？\n如果那是你，为什么在悲伤降临时，祂不救赎你？\n如果那是你，为什么在历经苦难时，祂不帮助你？\n所以，都是错觉。"
  },
  Event_35930_Name = {
    Text = "倒错的命运"
  },
  Event_35931_ChoiceDesc1 = {
    Text = "【询问船长】"
  },
  Event_35931_ChoiceDesc2 = {
    Text = "【询问图鲁】"
  },
  Event_35931_Desc = {
    Text = "又一次，你又一次看见了那个神秘身影走入舱壁，消失得无影无踪。荧光的长发从某处开始，化为数条垂落在地的触腕。\n你无比清楚，她就算不是蹈海者的一员，身份也一定和失落之国有着千丝万缕的关系。"
  },
  Event_35931_Name = {
    Text = "索纳尼尔号的沉没"
  },
  Event_35932_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35932_Desc = {
    Text = "你在恐惧，一切都是肾上腺素在捣鬼。\n你害怕自己的决策会伤害那些同你分担黑暗的灵魂。"
  },
  Event_35932_Name = {Text = "逐光"},
  Event_35933_ChoiceDesc1 = {
    Text = "【无处可逃】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_35933_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_35933_Desc = {
    Text = "每一根神经都在呼啸着对@2的渴望。"
  },
  Event_35933_Name = {
    Text = "死生边缘"
  },
  Event_35934_ChoiceDesc1 = {
    Text = "【追上去】"
  },
  Event_35934_ChoiceDesc2 = {
    Text = "【无视它】"
  },
  Event_35934_Desc = {
    Text = "密境中的远处，亮起了轻微而迷人的光。\n它像水面折射的阳光般波光粼粼，又像摇曳着的星光，或是一点烛火……\n就在你想向它靠近时，那光芒陡然消失。\n它似乎在引诱着你，像引诱着靠直觉而活的蛾。"
  },
  Event_35934_Name = {Text = "闪烁"},
  Event_35935_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_35935_Desc = {
    Text = "去纠结这些，又有什么用呢？\n你是一叶悬浮半空的落叶，命运的风推着你走，只此而已。"
  },
  Event_35935_Name = {
    Text = "倒错的命运"
  },
  Event_35936_ChoiceDesc1 = {
    Text = "【自嘲】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_35936_ChoiceDesc2 = {
    Text = "【追问到底】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_35936_ChoiceDesc3 = {
    Text = "【不再想】获得25黑印"
  },
  Event_35936_Desc = {
    Text = "生命的风拂动着你的灵魂，让你搅动在现实的漩涡中，卷进迷雾重重的未知。\n你忍不住向着脑中的声音发问：「那是我吗？」"
  },
  Event_35936_Name = {
    Text = "倒错的命运"
  },
  Event_36146_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36146_Desc = {
    Text = "墨菲终于注意到了你的视线，或许，它确实是太过炙热了。\n她深呼吸了几口气，从鼻腔里发出了一声轻轻的「哼」。最后，她拉着希莱斯特跟了上来，紧紧跟在了你身后。"
  },
  Event_36146_Name = {
    Text = "疼痛管理"
  },
  Event_36722_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36722_Desc = {
    Text = "在指尖接触的瞬间，一种复杂的感觉突然涌上心头——它既滚烫又冰冷。\n被世界遗忘的灵魂，正呼啸着寻求永世。"
  },
  Event_36722_Name = {
    Text = "灵知丰碑"
  },
  Event_36723_ChoiceDesc1 = {
    Text = "【触碰它】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_36723_ChoiceDesc2 = {
    Text = "【加入旋转】获得3选1刻印"
  },
  Event_36723_Desc = {
    Text = "迈动步子的瞬间，精神的最深处默然裂开了一道缝隙。不可名状的深邃气息透过裂缝，吹皱你的脑海。\n你感觉到一颗银色的混沌星球正在内心暗自旋转、滋长。"
  },
  Event_36723_Name = {
    Text = "灵知丰碑"
  },
  Event_36724_ChoiceDesc1 = {
    Text = "【跟上它们】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36724_ChoiceDesc2 = {
    Text = "【抚摸它们】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_36724_ChoiceDesc3 = {
    Text = "【不去惊扰】获得25黑印"
  },
  Event_36724_Desc = {
    Text = "在转过一道意外的拐角之后，一幅奇异的景象显现在你的视野里。\n数只猫的影子，若隐若现，飘忽在冰冷的舱壁边。"
  },
  Event_36724_Name = {Text = "船猫"},
  Event_36725_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36725_Desc = {
    Text = "「记忆」没有回应，他们贴在舱壁上，目不转睛地盯着你，直到你走过下一个拐角。"
  },
  Event_36725_Name = {
    Text = "索纳尼尔号的主人"
  },
  Event_36726_ChoiceDesc1 = {
    Text = "【绕路而行】删除1张指令卡，获得Arg1黑印"
  },
  Event_36726_ChoiceDesc2 = {
    Text = "【询问为何沉没】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_36726_ChoiceDesc3 = {
    Text = "【向船员问好】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36726_Desc = {
    Text = "行走在前往动力室的路上，你再次遇见了一些被固定在密境中的「记忆」。\n他们不是幽魂，只是埃尔顿船长对逝去船员的牵挂。"
  },
  Event_36726_Name = {
    Text = "索纳尼尔号的主人"
  },
  Event_36727_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36727_Desc = {
    Text = "「记忆」从舱壁上剥离而下，他扭曲着面容，从喉咙里发出悲鸣。\n——灯塔。\n——孤立的灯塔，将他们引入了风暴。"
  },
  Event_36727_Name = {
    Text = "索纳尼尔号的主人"
  },
  Event_36728_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36728_Desc = {
    Text = "你选择了跟随，跟随那些温柔而自由的灵魂所勾勒出的轨迹，即使前方是黑暗留下的陷阱。"
  },
  Event_36728_Name = {Text = "船猫"},
  Event_36729_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36729_Desc = {
    Text = "不要打扰逝者，不要搅动沉眠的记忆。"
  },
  Event_36729_Name = {
    Text = "索纳尼尔号的主人"
  },
  Event_36730_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36730_Desc = {
    Text = "你感觉意识开始分离，慢慢地被拽离身体。\n仿佛看见自己的灵魂正与星球共舞，然后沉沉地落进一个不可见的深渊……\n那里是纯粹的虚无。"
  },
  Event_36730_Name = {
    Text = "灵知丰碑"
  },
  Event_36731_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36731_Desc = {
    Text = "作为温柔的生灵，它们是这密境所不允许的奢望，无非是幻影而已。\n你虽然明白这一点，心底却仍泛起了一丝温暖的涟漪。"
  },
  Event_36731_Name = {Text = "船猫"},
  Event_36732_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36732_Desc = {
    Text = "它们的身影，模糊如同被时空洪流冲刷过的油画。幽深的黑色斑点宛若夜空中飘动的云，它们的眼睛却更像是遥远星辰的闪光，散发着神秘而深邃的光芒。\n你无法抵抗它们的诱惑，伸手摸入了一片虚无。"
  },
  Event_36732_Name = {Text = "船猫"},
  Event_36733_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36733_Desc = {
    Text = "你知道你必须要继续前行，哪怕是踉跄，哪怕是跌倒。"
  },
  Event_36733_Name = {
    Text = "肉体苦痛"
  },
  Event_36734_ChoiceDesc1 = {
    Text = "【尝试呼唤他】提升 Arg1 点生命"
  },
  Event_36734_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_36734_Desc = {
    Text = "这里是充满了隐匿的愿望和未曾触及的恐惧的地方，是由他的梦想和记忆交织而成的丰富画卷。"
  },
  Event_36734_Name = {
    Text = "进化的蜕变"
  },
  Event_36735_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36735_Desc = {
    Text = "「守密人，如果没有办法坚持了，请不要一个人忍受痛苦。」\n你不会逃避疼痛，它们是浮光掠影的生命的一部分。\n你不会躲避夜晚的阴影，因为你不怕被其中的黑暗吞噬。"
  },
  Event_36735_Name = {
    Text = "肉体苦痛"
  },
  Event_36736_ChoiceDesc1 = {
    Text = "【继续呼唤他】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_36736_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_36736_Desc = {
    Text = "天真的涂鸦组成了这个世界。"
  },
  Event_36736_Name = {
    Text = "进化的蜕变"
  },
  Event_36737_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36737_Desc = {
    Text = "蹈海者的祈祷在耳边回旋，疯狂而令人窒息。\n但它们不会影响到你的意志，绝对不会。"
  },
  Event_36737_Name = {Text = "自海中"},
  Event_36738_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36738_Desc = {
    Text = "这些注视深沉而清澈，如同深海中的光，明亮而温暖。\n它们不言语，也不显形，但你能感觉到它们的存在，就像夏夜里微风轻拂的抚慰。"
  },
  Event_36738_Name = {
    Text = "善意窥探"
  },
  Event_36739_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36739_Desc = {
    Text = "你强制自己将注意力落在眼前的危机上，强硬地要求自己无视那些痛苦。"
  },
  Event_36739_Name = {
    Text = "肉体苦痛"
  },
  Event_36740_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36740_Desc = {
    Text = "那是生命的印记，是存在的证明。它讲述着故事，却在这风暴的肆虐下，渐渐失去了声音。"
  },
  Event_36740_Name = {
    Text = "再见，伊卡洛斯"
  },
  Event_36741_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36741_Desc = {
    Text = "这些注视深沉而清澈，如同深海中的光，明亮而温暖。\n它们不言语，也不显形，但你能感觉到它们的存在，就像夏夜里微风轻拂的抚慰。"
  },
  Event_36741_Name = {
    Text = "善意窥探"
  },
  Event_36742_ChoiceDesc1 = {
    Text = "【最后一次呼唤他】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_36742_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_36742_Desc = {
    Text = "痛苦的裂痕组成了这个世界。"
  },
  Event_36742_Name = {
    Text = "进化的蜕变"
  },
  Event_36743_ChoiceDesc1 = {
    Text = "【拥抱疼痛】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36743_ChoiceDesc2 = {
    Text = "【拒绝疼痛】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_36743_ChoiceDesc3 = {
    Text = "【无视疼痛】获得25黑印"
  },
  Event_36743_Desc = {
    Text = "疼痛有如顽石，植根于脑海。扩散开来的苦楚像是藤蔓，缠绕着每一寸神经，扭曲着你的意识。"
  },
  Event_36743_Name = {
    Text = "肉体苦痛"
  },
  Event_36744_ChoiceDesc1 = {
    Text = "【坚定地呼唤他】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_36744_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_36744_Desc = {
    Text = "对承认的向往组成了这个世界。"
  },
  Event_36744_Name = {
    Text = "进化的蜕变"
  },
  Event_36745_ChoiceDesc1 = {
    Text = "【注视它们】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36745_ChoiceDesc2 = {
    Text = "【向它们求助】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，可以使用两次"
  },
  Event_36745_Desc = {
    Text = "在密境流动的色彩中，你感到了一种神秘的注视，它们是无形的眼睛，隐藏在这密境的神秘褶皱之中。\n在它们望向你的那一刻，你的内心涌起了一种强烈的欲望。"
  },
  Event_36745_Name = {
    Text = "善意窥探"
  },
  Event_36746_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36746_Desc = {
    Text = "如果不去理解它们，那你将无法走出这片混乱的炼狱。\n星辰映照在水面上时，那些跳动的心愿与恳求，那些祈祷便如同泡沫一般，缓缓升向海面，却又不觉中被黑暗吞没。"
  },
  Event_36746_Name = {Text = "自海中"},
  Event_36747_ChoiceDesc1 = {
    Text = "【急切地呼唤他】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_36747_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_36747_Desc = {
    Text = "丑恶的言语组成了这个世界。"
  },
  Event_36747_Name = {
    Text = "进化的蜕变"
  },
  Event_36748_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36748_Desc = {
    Text = "你站在他的面前，目睹着他的灵魂被奇异的回忆所吞噬。"
  },
  Event_36748_Name = {
    Text = "进化的蜕变"
  },
  Event_36749_ChoiceDesc1 = {
    Text = "【那是泪水】删除1张卡牌"
  },
  Event_36749_ChoiceDesc2 = {
    Text = "【那是鲜血】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36749_Desc = {
    Text = "几滴液体在甲板上恣意地晕染开，顺着甲板缝隙悄无声息四下蔓延。\n那痕迹轻柔而坚定，每一道湿痕都带着决绝的意味，在海风的咆哮和帆船的呻吟中，交织出一幅生与死，宁静与喧嚣的图画。"
  },
  Event_36749_Name = {
    Text = "再见，伊卡洛斯"
  },
  Event_36750_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36750_Desc = {
    Text = "你凝望着那些缓缓扩散的斑点，试图辨认它们的本质，然而在这天地交接的边际，雨水和血液的差异变得模糊不清。\n他们是雨水吗？是海洋的眼泪吗？\n你不知道。"
  },
  Event_36750_Name = {
    Text = "再见，伊卡洛斯"
  },
  Event_36751_ChoiceDesc1 = {
    Text = "【拒绝同频】获得3选1白银造物"
  },
  Event_36751_ChoiceDesc2 = {
    Text = "【加入同频】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_36751_Desc = {
    Text = "蹈海者的絮语与「圣婴」的心跳交织成隐秘的交响乐，每一次震动，都让无垠的液态宇宙引发一场呼啸。"
  },
  Event_36751_Name = {Text = "自海中"},
  Event_36752_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_36752_ChoiceDesc2 = {
    Text = "【检查胶卷】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，还可以使用一次"
  },
  Event_36752_Desc = {
    Text = "它们并无恶意，这种感觉如同直觉，植根于你的骨血之中。\n于是，你放下戒备，试着向这些隐秘的守望者求助：向那隐约的存在倾诉你的困惑和渴望，如同向一位老友叙说心事，真切无比。"
  },
  Event_36752_Name = {
    Text = "善意窥探"
  },
  Event_36874_ChoiceDesc1 = {
    Text = "【讲述学校的趣事】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_36874_ChoiceDesc2 = {
    Text = "【没有上过学】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_36874_Desc = {
    Text = "路过一处废墟时，奥瑞塔的眼睛倏地亮了起来。\n「婆婆说，这里以前是学校，但是因为没有学生，早就荒废啦！」\n「奥瑞塔没有上过学，朋友呢？你有没有去过学校？」"
  },
  Event_36874_Name = {
    Text = "失落的快乐"
  },
  Event_36875_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36875_Desc = {
    Text = "从你口中得到了否定的答案，奥瑞塔闷闷不乐地摇了摇头。\n「原来，外面的世界也没有学生……那最开始建学校，是为了什么呢？」"
  },
  Event_36875_Name = {
    Text = "失落的快乐"
  },
  Event_36876_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36876_Desc = {
    Text = "「济贫院、小老鼠、蜡像……好耶！探险，是探险！」\n奥瑞塔说着，脑袋上飘出一个不可视的问号。\n「不过，婆婆说学校是一个会让奥瑞塔变聪明的地方，可是……」\n在奥瑞塔继续思考下去前，你推着她走过了又一个转角。"
  },
  Event_36876_Name = {
    Text = "失落的快乐"
  },
  Event_36877_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36877_Desc = {
    Text = "「为、为什么？」\n奥瑞塔被你吓了一跳，板着脸继续指挥你。\n「这里是奥瑞塔的家，奥瑞塔知道，广场——就在那个里面！」"
  },
  Event_36877_Name = {
    Text = "不可视的黑暗"
  },
  Event_36878_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36878_Desc = {
    Text = "「我不想走这条路，奥瑞塔知道其他前往广场的方法吗？」\n奥瑞塔嘟起了嘴，感到有些摸不着头脑，但最终还是扯着你的披风，指挥向了另一个方向。"
  },
  Event_36878_Name = {
    Text = "不可视的黑暗"
  },
  Event_36879_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_36879_Desc = {
    Text = "这是梦境，这只是梦境。\n你反复告诫，或者说反复安慰着自己，领着奥瑞塔一头闯入不可视的黑暗。"
  },
  Event_36879_Name = {
    Text = "不可视的黑暗"
  },
  Event_36880_ChoiceDesc1 = {
    Text = "【听从她】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_36880_ChoiceDesc2 = {
    Text = "【反对她】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_36880_ChoiceDesc3 = {
    Text = "【同她商量】获得25黑印"
  },
  Event_36880_Desc = {
    Text = "奥瑞塔牵着你的披风，一步步踩着你的脚印向前走。\n「咦……错啦！广场在那个方向！」\n你转头看向奥瑞塔指出的方向，密境中的巷道俨然一片漆黑。融蚀浆、异变体蠕动着互相纠缠，将现实世界也一同拖入陨落的深渊。"
  },
  Event_36880_Name = {
    Text = "不可视的黑暗"
  },
  Event_37983_ChoiceDesc1 = {
    Text = "【获取经费】获得 Arg1 黑印。"
  },
  Event_37983_ChoiceDesc2 = {
    Text = "【获取经费】获得 Arg1 黑印[ExDesc1]。"
  },
  Event_37983_Desc = {
    Text = "「没有领主会放任一个来历不明的家伙，更何况一个修士。」\n女王端坐于高高的王座上，眼里不期然闪过一丝暴虐。\n「证明你还有别的用处，不然……」\n别的用处？你望向窗外荒芜的田地，一个念头忽然升起：或许可以运用所学的经济学知识，帮助旺达管理庄园？\n你竭力在贫瘠光滑的大脑中搜刮——要知道在弥萨格，经济学只是一门不起眼的选修课……\n耐心耗尽。女王打了个呵欠。\n「令人失望。放——」\n就在铡刀坠下的那一刻，亚当·斯密、马尔萨斯、大卫·李嘉图等伟大先烈的英灵纷纷降临在你的小脑瓜里。\n劳动分工！征税！人口，见鬼的人口！\n你也许、大概想起来了。"
  },
  Event_37983_Name = {
    Text = "代行密令"
  },
  Event_37984_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_37984_Desc = {
    Text = "你硬着头皮提出政令。\n女王草草看过，露出冰冷微笑：\n「若是没有用的话，你知道会发生什么。」"
  },
  Event_37984_Name = {
    Text = "代行密令"
  },
  Event_37985_ChoiceDesc1 = {
    Text = "【提出政令】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_37985_ChoiceDesc2 = {
    Text = "【提出政令】获得诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_37985_ChoiceDesc3 = {
    Text = "【提出政令】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_37985_Desc = {
    Text = "「收了我的钱，就要替我卖命。」\n女王单手托腮，漫不经心地看着你。\n不管承认与否，她的确对此抱有好奇。\n「那么，告诉我你的计划吧，大改革家。」"
  },
  Event_37985_Name = {
    Text = "代行密令"
  },
  Event_38700_ChoiceDesc1 = {
    Text = "【接通】回复 Arg2 点生命[ExDesc1]。"
  },
  Event_38700_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_38700_ChoiceDesc3 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_38700_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_38700_Name = {Text = "联络点"},
  Event_38700_Tips3 = {
    Text = "当前并未拥有症状卡"
  },
  Event_38707_ChoiceDesc1 = {
    Text = "【驱散幻象】感染症状。"
  },
  Event_38707_ChoiceDesc2 = {
    Text = "【吸收幻象】失去 Arg1 生命，获得 Arg2 黑印"
  },
  Event_38707_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_38707_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_38707_Name = {Text = "幻象"},
  Event_38715_ChoiceDesc1 = {
    Text = "【提出政令】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」"
  },
  Event_38715_ChoiceDesc2 = {
    Text = "【提出政令】获得诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_38715_ChoiceDesc3 = {
    Text = "【提出政令】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_38715_Desc = {
    Text = "「收了我的钱，就要替我卖命。」\n女王单手托腮，漫不经心地看着你。\n不管承认与否，她的确对此抱有好奇。\n「那么，告诉我你的计划吧，大改革家。」"
  },
  Event_38715_Name = {
    Text = "代行密令"
  },
  Event_40452_ChoiceDesc1 = {
    Text = "【询问身份】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_40452_ChoiceDesc2 = {
    Text = "【离开】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_40452_Desc = {
    Text = "三个鬼魂阻挡了前进的步伐。\n他们围在赌桌前，全神贯注地盯着骰子的动向。\n「咕噜，咕噜。」\n骰子被无数次抛起、落下。\n这是一场永远没有尽头的赌局。"
  },
  Event_40452_Name = {
    Text = "无尽的赌局"
  },
  Event_40453_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40453_Desc = {
    Text = "「你好，我们分别是旺达的第一、第二以及第三任丈夫。」\n「什么，你问第四任丈夫在哪里？\n唔……老实说，约翰有点缺乏幽默感，所以被夫人变成了盲眼侍从。」\n「失去他我们都很遗憾。当然，只有一点点。」"
  },
  Event_40453_Name = {
    Text = "无尽的赌局"
  },
  Event_40454_ChoiceDesc1 = {
    Text = "【与之握手】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_40454_ChoiceDesc2 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_40454_Desc = {
    Text = "路过牢笼时，一只手从里面伸出。\n「别离开我，丽贝卡……」\n声音苍老干瘪，如同破旧的风箱。"
  },
  Event_40454_Name = {Text = "囚徒"},
  Event_40455_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40455_Desc = {
    Text = "手心传来黏糊糊的触感——是融蚀浆。\n声音的主人不知何时早已消失，隐匿在角落暮气沉沉的阴影里。"
  },
  Event_40455_Name = {Text = "囚徒"},
  Event_40456_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40456_Desc = {
    Text = "你毫不在乎地离开了，因而错过了信纸背后那段充满戏剧性的过往。\n但那又有什么关系呢？\n浩瀚的海洋、黎明和黄昏、赤道沙漠……\n你将遇见更多，也将错过更多。"
  },
  Event_40456_Name = {
    Text = "致敬爱的夫人"
  },
  Event_40457_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40457_Desc = {
    Text = "某种意义而言，你和这个囚徒别无二致。\n现在还不是打草惊蛇的时候。\n你无视囚徒的哀求，转身离去。"
  },
  Event_40457_Name = {Text = "囚徒"},
  Event_40458_ChoiceDesc1 = {
    Text = "【撕掉信件】选择1个造物变化为诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_40458_ChoiceDesc2 = {
    Text = "【无视信件】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_40458_ChoiceDesc3 = {
    Text = "【回信】获得25黑印"
  },
  Event_40458_Desc = {
    Text = "Ⅰ.书信  约翰·坎贝里安 致旺达（洪积前@2年）\n\n丈夫有权处置自己的妻子，至少在坎布里安如此。\n但我显然低估了你的疯狂程度。现在我的双眼近乎全瞎，我的四肢也即将被砍掉。\n恶魔的女儿。恶魔的女儿……不，你就是恶魔本身。\n我诅咒你@1诅咒你@2诅咒你诅咒你……"
  },
  Event_40458_Name = {
    Text = "致敬爱的夫人"
  },
  Event_40459_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40459_Desc = {
    Text = "你采用了最朴实无华的手段解开诅咒。\n什么都没有发生。纸片毫无生气地落到地上。\n你耸耸肩离开了，心里却总觉得有什么地方不太对劲。"
  },
  Event_40459_Name = {
    Text = "致敬爱的夫人"
  },
  Event_40460_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40460_Desc = {
    Text = "你心无旁骛地路过赌桌。\n临走前，鬼魂们齐声开口：\n「请代我们向我们共同的前妻——旺达女士问好。」"
  },
  Event_40460_Name = {
    Text = "无尽的赌局"
  },
  Event_40461_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_40461_Desc = {
    Text = "你在信纸末端工整地写上回信：\n「诅咒已收到，祝一切安好。」\n最后一笔落下的瞬间，信纸上燃起愤怒的青色火焰。\n你收获了灰烬。"
  },
  Event_40461_Name = {
    Text = "致敬爱的夫人"
  },
  Event_44187_ChoiceDesc1 = {
    Text = "【面对黑暗】[ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc2 = {
    Text = "【面对黑暗】[ExDesc1][ExDesc2]"
  },
  Event_44187_ChoiceDesc3 = {
    Text = "【逃避黑暗】获得随机黄金造物"
  },
  Event_44187_Desc = {
    Text = "你眼前的灵魂晦暗污浊——光明与黑暗在它身上同时存在。它们争夺主导，灵魂则陷入迷茫。\n「我很同情他们，那些失去一切的可怜人，但这个世界不是就是这样的吗？\n「有人获得，就有人失去。\n「难道为了其他人的快乐，就要放弃我的快乐吗？」"
  },
  Event_44187_Name = {
    Text = "内心的黑暗"
  },
  Event_44188_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44188_Desc = {
    Text = "「这是我的罪孽，是我的负担。我该如何拯救你，我矛盾的灵魂？」"
  },
  Event_44188_Name = {
    Text = "内心的黑暗"
  },
  Event_44299_ChoiceDesc1 = {
    Text = "【向主教祈求】净化负罪造物，若无负罪造物，获得随机黄金造物。"
  },
  Event_44299_Desc = {
    Text = "「我坑蒙拐骗，获得了想要的人生——金钱变成了数字，珍馐变成了家常，商业上我说一不二，政治上我手腕强硬。但为什么，为什么我忘不了那些人，那些被我夺走一切的人？为什么我忘不了他们脸上的绝望？\n「酒精只能提供短暂的逃避，我的灵魂在自我撕扯，痛苦几乎将我淹没。\n「我究竟该怎么做？」"
  },
  Event_44299_Name = {
    Text = "愧疚与宽恕"
  },
  Event_44301_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44301_Desc = {
    Text = "「你行在苦难的道路上，你偏离了父神的荣光。\n「回来吧，迷途的羔羊，听从父神的教导，行到正路上来。」"
  },
  Event_44301_Name = {
    Text = "愧疚与宽恕"
  },
  Event_44395_ChoiceDesc1 = {
    Text = "【求取外物】主教承受你的 1 张症状，你获得 Arg1 黑印。若无症状，直接获得黑印"
  },
  Event_44395_ChoiceDesc2 = {
    Text = "【求取鲜血】主教承受你的 2 张症状，你获得刻印「(EnchantConfig.Arg1)」。"
  },
  Event_44395_ChoiceDesc3 = {
    Text = "【求取更多】主教承受更多症状(至少4张)"
  },
  Event_44395_Desc = {
    Text = "虚幻的灵魂凝出模糊的轮廓，它跪在主教身前展示自己残破的躯体与残留了黑色的内心。\n「你给予我指引，给予我宽恕，给予我救赎，但慈悲的主教啊，这远远不够。\n「我穷困潦倒，疾病缠身。我命悬一线，而你是我唯一的救赎。救救我，主教，让我能不再痛苦。」"
  },
  Event_44395_Name = {
    Text = "主教的「赐福」"
  },
  Event_44396_ChoiceDesc1 = {
    Text = "【行礼并离开】"
  },
  Event_44396_Desc = {
    Text = "主教取下戒指，摘下胸针。那些象征父神的蓝色宝石被一一放在灵魂手中，主教弯下腰，握住可怜灵魂的双手。\n「拿走我身上的金银，拿走我所有的财物——只要那是你需要的。我有父神的教导便足够生活。」"
  },
  Event_44396_Name = {
    Text = "主教的「赐福」"
  },
  Event_44400_ChoiceDesc1 = {
    Text = "【沉溺其中】感染「(Skill.Arg1)」，觉醒随机唤醒体"
  },
  Event_44400_ChoiceDesc2 = {
    Text = "【放弃】"
  },
  Event_44400_Desc = {
    Text = "迷失的灵魂不愿放弃黑暗。\n你知道等待它的是什么。荒诞的人生即将上演，而你是唯一的观众。"
  },
  Event_44400_Name = {
    Text = "内心的黑暗"
  },
  Event_44401_ChoiceDesc1 = {
    Text = "【眼疾手快】获得 Arg1 黑印"
  },
  Event_44401_ChoiceDesc2 = {
    Text = "【肆意攫取】获得 3 选 1高级刻印，感染「(Skill.Arg1)」。"
  },
  Event_44401_Desc = {
    Text = "在密境中发现的黑色印记，可向融痕献祭以换取造物等精神投影。离开当前区域后很快会消散为黑色泥浆。"
  },
  Event_44401_Name = {Text = "黑印"},
  Event_44407_ChoiceDesc1 = {
    Text = "【驱散幻象】感染症状。"
  },
  Event_44407_ChoiceDesc2 = {
    Text = "【拥抱虚妄】获得 2 张随机症状，获得 Arg1 黑印。"
  },
  Event_44407_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_44407_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_44407_Name = {Text = "幻象"},
  Event_44445_ChoiceDesc1 = {
    Text = "【离开】寻找探照灯"
  },
  Event_44445_ChoiceDesc2 = {
    Text = "【闯入雾气】失去 Arg2 点生命"
  },
  Event_44445_ChoiceDesc3 = {
    Text = "【舍弃外物】扣除 5 黑印，获得 1 张「灵感」"
  },
  Event_44445_Desc = {
    Text = "前方是一片浓厚的黑色雾气，贸然进入将招致灾厄。\n或许你应该找到「探照灯」驱散雾气。"
  },
  Event_44445_Name = {Text = "未知"},
  Event_44469_ChoiceDesc1 = {
    Text = "【求取骨肉】主教承受你的 4 张症状，你获得 3 选 1 黄金造物+。"
  },
  Event_44469_ChoiceDesc2 = {
    Text = "【求取赐福】主教承受你的 6 张症状，你获得 3 选 1 时灵摆。"
  },
  Event_44469_ChoiceDesc3 = {
    Text = "【返回】"
  },
  Event_44469_Desc = {
    Text = "虚幻的灵魂凝出模糊的轮廓，它跪在主教身前展示自己残破的躯体与残留了黑色的内心。\n「你给予我指引，给予我宽恕，给予我救赎，但慈悲的主教啊，这远远不够。\n「我穷困潦倒，疾病缠身。我命悬一线，而你是我唯一的救赎。救救我，主教，让我能不再痛苦。」"
  },
  Event_44469_Name = {
    Text = "主教的「赐福」"
  },
  Event_44474_ChoiceDesc1 = {
    Text = "【索求】获得主教的祝福"
  },
  Event_44474_ChoiceDesc2 = {
    Text = "【索求】获得主教的祝福"
  },
  Event_44474_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_44474_Desc = {
    Text = "「这是我的罪孽，是我的负担。我该如何拯救你，我矛盾的灵魂？」"
  },
  Event_44474_Name = {
    Text = "内心的黑暗"
  },
  Event_44911_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44911_Desc = {
    Text = "「所有，所有……没错，我要所有……！」\n灵魂伸出手，徒劳地在空中抓取。\n它获得了什么，却什么也没获得。"
  },
  Event_44911_Name = {
    Text = "你所得为何"
  },
  Event_44913_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44913_Desc = {
    Text = "「那就只要最重要的那个，最重要的……」\n灵魂蹲了下来，从虚无的泥土中挖出了明亮的愿望，并将它捧在了手心。"
  },
  Event_44913_Name = {
    Text = "你所得为何"
  },
  Event_44916_ChoiceDesc1 = {
    Text = "【抓住所有】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_44916_ChoiceDesc2 = {
    Text = "【学会放下】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_44916_Desc = {
    Text = "暗淡的灵魂陷入了痛苦。\n它在原地徘徊，为所有可能的选择及后果迷茫。\n「我该怎么选？」它轻声呢喃，「我该怎么做？」\n「我要如何才能拥有一切？」"
  },
  Event_44916_Name = {
    Text = "你所得为何"
  },
  Event_44919_ChoiceDesc1 = {
    Text = "【内省自身】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_44919_ChoiceDesc2 = {
    Text = "【外看旁人】获得3选1刻印"
  },
  Event_44919_Desc = {
    Text = "漂浮的灵魂陷入了两难。\n它停下脚步，在欲望之间踌躇。\n「我该怎么选？」它轻声呢喃，「我该怎么做？」\n「究竟哪个才是我真正的所求？」"
  },
  Event_44919_Name = {
    Text = "你所欲为何"
  },
  Event_44920_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44920_Desc = {
    Text = "「你是对的，我得看看，我得看看……」\n它低下头，双手探入胸腔，从里面掏出一颗虚幻的心脏：一半如墨般漆黑，一半如星般明亮。"
  },
  Event_44920_Name = {
    Text = "你所欲为何"
  },
  Event_44921_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44921_Desc = {
    Text = "「也是，也是……人说他人可做镜……我得看看……」\n它凑到你身前，用没有五官的面孔望着你。\n「你为什么不会为难？好羡慕，好羡慕……」"
  },
  Event_44921_Name = {
    Text = "你所欲为何"
  },
  Event_44998_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_44998_Desc = {
    Text = "「他们说，现在的苦难是暂时的，死后我们自会在父神的怀抱中永享喜乐。\n「我不想等到死后。」\n阴影贪婪地吞噬着一切，灵魂暗淡下去，几乎与周遭的黑暗融为一体。\n你想做什么，却无能为力。"
  },
  Event_44998_Name = {
    Text = "内心的黑暗"
  },
  Event_45000_ChoiceDesc1 = {
    Text = "【行礼并离开】"
  },
  Event_45000_Desc = {
    Text = "主教用利刃割开掌心，滴落在石板上的鲜血化作治愈的蓝光，将灵魂缺失的血补全。\n「拿走我的血液，填补你的生命——只要那是你需要的。这便是父神希望我行的事。」"
  },
  Event_45000_Name = {
    Text = "主教的「赐福」"
  },
  Event_45001_ChoiceDesc1 = {
    Text = "【行礼并离开】"
  },
  Event_45001_Desc = {
    Text = "主教从胸腔深处掏出自己的灵魂。温润的光点融入石板，化作治愈的蓝光，将灵魂上所有的裂痕填满。\n「领受吧，这是父神的赠礼，是祂爱的证明。愿你躯体康健，灵魂完满，不再受任何苦楚。」"
  },
  Event_45001_Name = {
    Text = "主教的「赐福」"
  },
  Event_45002_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_45002_Desc = {
    Text = "你向那些面孔走去，再次睁开眼时，眼前已经归于黑暗。只有不明来源的笑声在周围回荡。"
  },
  Event_45002_Name = {Text = "幻象"},
  Event_45036_ChoiceDesc1 = {
    Text = "【删除所有造物】"
  },
  Event_45036_Desc = {
    Text = "「这是我的罪孽，是我的负担。我该如何拯救你，我矛盾的灵魂？」"
  },
  Event_45036_Name = {
    Text = "内心的黑暗"
  },
  Event_45196_ChoiceDesc1 = {
    Text = "【行礼并离开】"
  },
  Event_45196_Desc = {
    Text = "主教用利刃剜下骨肉，苍白的骨与猩红的肉融入石板，化作治愈的蓝光，将灵魂折断的骨补全。\n「拿走我的骨肉，填补你缺失的躯体——只要那是你需要的。这便是父神希望我行的事。」"
  },
  Event_45196_Name = {
    Text = "主教的「赐福」"
  },
  Event_46144_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_46144_Desc = {
    Text = "朦胧的人影逐渐清晰，那不是什么融蚀体，也不是灾厄，而是没有翅膀，神色如常的克莱门汀。\n「真巧啊，你也是来欣赏月光的吗？」她笑着说，你却感到一阵晕眩，「浓雾之夜，还是要多加小心哦。\n「这儿的小家伙们，可不怎么安分。」"
  },
  Event_46144_Name = {
    Text = "雾气中的身影"
  },
  Event_46145_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_46145_Desc = {
    Text = "你不动声色。一位贵妇人忽然冲上舞台。 \n她疯狂地掰开男孩的嘴，将手中的木棍狠狠捅进去。 \n「说话，给我说话。」 \n男孩嘴里流出黑色的血。他含混不清地念了下去。 \n「献给妈妈的歌……」"
  },
  Event_46145_Name = {
    Text = "终幕礼Ⅲ"
  },
  Event_47309_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47309_Desc = {
    Text = "到那日，神必用他刚硬有力的大刀刑罚非利士人，\n因着他们所「犯下」的杀戮之罪。\n什么，你说这不公平？\n不，这才是猎食者的命运。"
  },
  Event_47309_Name = {
    Text = "水手歌谣"
  },
  Event_47310_ChoiceDesc1 = {
    Text = "【继续听】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_47310_ChoiceDesc2 = {
    Text = "【离开】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_47310_Desc = {
    Text = "神说：就叫他非利士人吧。\n让他肩负杀戮的职责，让他背负贪婪的诅咒。\n让他行的路发着光，令人想深渊如同白发。\n浩渺的海洋中，没有比这更雄伟的巨鲨。\n让他被所有生灵畏惧、崇敬，\n直到审判来临的时刻。"
  },
  Event_47310_Name = {
    Text = "水手歌谣"
  },
  Event_47311_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_47311_ChoiceDesc2 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_47311_ChoiceDesc3 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_47311_Desc = {
    Text = "男孩是卑贱的奴隶。\n主人待他亲如父子，却被刺死在床上。\n「我爱您，父亲。我只是不愿再做奴隶。」\n后来，男孩站在「父亲」的墓前，想起祭司的话：\n<Small:不要离开生养你的故土。\n届时，你的双手沾满鲜血，你毫无尊严地死去。\n野狗、秃鹫和海鱼都唾弃你。>\n名为以格伦的男孩最终还是离开了。\n他将谱写自己那臭名昭著的故事。"
  },
  Event_47311_Name = {
    Text = "木桶里的男孩"
  },
  Event_47312_ChoiceDesc1 = {
    Text = "【往前翻页】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_47312_ChoiceDesc2 = {
    Text = "【往后翻页】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_47312_ChoiceDesc3 = {
    Text = "【丢弃】获得25黑印"
  },
  Event_47312_Desc = {
    Text = "你捡到一本由莎草纸装订而成的书册：\n……\n男孩躲在木桶里，一路飘来非利士人的小岛。\n他羸弱、下流、野心勃勃。\n当不朽巨人的荣光使所有人叹服，\n唯有男孩躲在阴影中，不让那光靠近自己半分。\n后来，他被戈利亚委以重任。\n至于原因嘛——"
  },
  Event_47312_Name = {
    Text = "木桶里的男孩"
  },
  Event_47313_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47313_Desc = {
    Text = "巨人接着说：\n「我把他放在我身边，是因为他既忧郁、又滑稽。\n并且他永远杀不死我。」"
  },
  Event_47313_Name = {
    Text = "木桶里的男孩"
  },
  Event_47314_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47314_Desc = {
    Text = "你未能听到后面的部分，但它的歌词使你想起另一首歌：\n「这条罕见的巨鲨呵，置身在狂风暴雨中，\n海洋就是它的家，\n既然强权就是公理，它就是强权的巨人，\n是无边无际的海洋之王。」"
  },
  Event_47314_Name = {
    Text = "水手歌谣"
  },
  Event_47315_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47315_Desc = {
    Text = "现在不是阅读的好时机。\n你匆匆丢开书册，未能看到最后的内容：\n……\n他之所以躲在阴影中，并非出于妒忌。\n而是纯粹的畏惧。\n一旦站在光下，卑琐的灵魂将被彻底湮没。\n连灰烬都不会剩下。"
  },
  Event_47315_Name = {
    Text = "木桶里的男孩"
  },
  Event_47463_ChoiceDesc1 = {
    Text = "【进入催眠】指定一名唤醒体使其精神分裂，失去初始的四张指令卡。"
  },
  Event_47463_Desc = {
    Text = "医生从卷帙浩繁的书本中抬起头：\n「你是稀有的样本，因此我不会对你收费。\n但我需要另外的回报：一次催眠。\n这是一种新型的治疗手段，它带来毫无保留、完全赤裸的意识。\n怎么样，愿意试试吗？」"
  },
  Event_47463_Name = {
    Text = "「催眠蛇」"
  },
  Event_47464_ChoiceDesc1 = {
    Text = "【闪亮的记忆】[ExDesc1][ExDesc2]"
  },
  Event_47464_ChoiceDesc2 = {
    Text = "【暗淡的记忆】将牌库中所有合奏刻印升级为高级合奏刻印"
  },
  Event_47464_Desc = {
    Text = "她徘徊在意识之海的沙滩上。\n海浪的裙摆舔舐双脚，将散落的记忆送来岸边。\n它们有的闪亮，有的暗淡，还有的闻起来就像伦蒂尼恩的雨季。\n你选择拾起哪一块记忆？她徘徊在意识之海的沙滩上。"
  },
  Event_47464_Name = {
    Text = "「主体融合」"
  },
  Event_47465_ChoiceDesc1 = {
    Text = "【拒绝尝试】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_47465_ChoiceDesc2 = {
    Text = "【砸碎溶剂】净化负罪造物"
  },
  Event_47465_ChoiceDesc3 = {
    Text = "【接受实验】获得 1 个时灵摆「(RelicConfig.Arg1)」"
  },
  Event_47465_Desc = {
    Text = "医生摇晃着碧绿的溶剂，兴奋地告诉她：\n「喝下一口，你就能进入清醒的梦境。\n它是集体潜意识的念力再现。\n现在，你将和万千生灵共享同一片意识之海，\n要来尝尝吗？」"
  },
  Event_47465_Name = {
    Text = "「清醒梦」"
  },
  Event_47466_ChoiceDesc1 = {
    Text = "【回应声音】获得精神分裂唤醒体的1张指令卡"
  },
  Event_47466_Desc = {
    Text = "肉体是囚笼，监禁着四分五裂的人格们。\n名为「24」的监狱现在人满为患。\n「不要昏睡，不要心平气和。」\n黑暗中，有个声音轻轻说。"
  },
  Event_47466_Name = {
    Text = "「自性觉知」"
  },
  Event_47848_ChoiceDesc1 = {
    Text = "【闭上双眼】获得3选1黄金造物"
  },
  Event_47848_ChoiceDesc2 = {
    Text = "【偷瞄一眼】选择觉醒 2 名唤醒体，并使其觉醒卡算力消耗降低 1 。"
  },
  Event_47848_ChoiceDesc3 = {
    Text = "【睁开双眼】获得白银造物「(RelicConfig.Arg1)」，「(RelicConfig.Arg2)」，「(RelicConfig.Arg3)」"
  },
  Event_47848_Desc = {
    Text = "进入催眠前，医生说：\n「没有我的允许，不要睁开眼睛。」\n于是她紧闭双眼，吸气……吐气……\n半睡半醒间，她似乎听到了「嘶嘶」的气声。\n随后她沐浴在冰冷的目光下——\n有什么东西正在看着她。\n要不要睁开眼睛，悄悄看一眼呢？"
  },
  Event_47848_Name = {
    Text = "「催眠蛇」"
  },
  Event_47876_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47876_Desc = {
    Text = "她弯腰拾起闪闪发光的记忆。\n一个、两个……无数快乐纷至沓来，\n她张开双臂，围绕它们转起了圈圈。"
  },
  Event_47876_Name = {
    Text = "「主体融合」"
  },
  Event_47877_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47877_Desc = {
    Text = "她弯腰拾起暗淡的记忆。\n一个、两个……无数卑琐纷至沓来，\n她张开双臂，将它们全部拥入怀中。"
  },
  Event_47877_Name = {
    Text = "「主体融合」"
  },
  Event_47878_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47878_Desc = {
    Text = "你拒绝成为这些古怪溶剂的牺牲品。\n医生有些失落，但他并不勉强你。\n「我原谅人类的怯懦与短见。」"
  },
  Event_47878_Name = {
    Text = "「清醒梦」"
  },
  Event_47879_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47879_Desc = {
    Text = "哗啦！你一把砸碎瓶子。\n绿色的溶液很快腐蚀了地板。\n「很好，无知的冲动。但我希望不要有下次了。\n不然我会因此而伤心落泪的。」"
  },
  Event_47879_Name = {
    Text = "「清醒梦」"
  },
  Event_47880_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47880_Desc = {
    Text = "你咕嘟一口喝了下去。\n咕嘟咕嘟……你的大脑跟喉咙同时冒出无数泡泡。\n就像噼啪作响的小小烟花。\n「赞美你，勇敢的人类。你将有机会接触无限。\n而我，将见证无限。」"
  },
  Event_47880_Name = {
    Text = "「清醒梦」"
  },
  Event_47881_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47881_Desc = {
    Text = "她睁开双眼，说：\n「是的，这一切都是不对的。\n应当流泪，应当反抗。」\n黑暗中响起窸窸窣窣的声音，她收获了善意的回应。"
  },
  Event_47881_Name = {
    Text = "「自性觉知」"
  },
  Event_47900_ChoiceDesc1 = {
    Text = "【看见蛇】获得黄金造物+「(RelicConfig.Arg1)」"
  },
  Event_47900_ChoiceDesc2 = {
    Text = "【看见你】获得负罪造物「(RelicConfig.Arg1)」"
  },
  Event_47900_Desc = {
    Text = "啪。\n一个轻轻的响指将她拽回现实。\n医生不知何时将脸凑了上来，钴黄色的眼睛兴奋地眯了起来。\n「告诉我，刚才你都看到了什么？」"
  },
  Event_47900_Name = {
    Text = "「催眠蛇」"
  },
  Event_47901_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47901_Desc = {
    Text = "她睁开双眼。\n光影迷蒙间，她似乎看到一条宁静的白色巨蛇在黑暗中盘踞、缓慢蠕动。\n哦，还有它的眼睛——\n那是纯净到不掺一丝杂质的金色。\n无悲无喜，不带任何评判，\n足以叫睡鼠从盛夏的噩梦中惊醒。"
  },
  Event_47901_Name = {
    Text = "「催眠蛇」"
  },
  Event_47909_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47909_Desc = {
    Text = "她悄悄睁开一只眼。\n视线所及是一团模糊的白色光影，在黑暗中缓慢蠕动。\n浅淡的金色在光影中一闪而过，似在警告她的违规。\n她不敢继续看了。"
  },
  Event_47909_Name = {
    Text = "「催眠蛇」"
  },
  Event_47910_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47910_Desc = {
    Text = "她谨遵医生的嘱托，一刻也不曾睁开双眼。\n冰冷的气息刮过她周围的空气，在她脸上久久驻足。\n不知过了多久，一切恢复如常。\n仿佛什么都不曾发生。"
  },
  Event_47910_Name = {
    Text = "「催眠蛇」"
  },
  Event_47911_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47911_Desc = {
    Text = "「我看见……一条很漂亮的蛇。」\n医生握着钢笔的手顿了一瞬。\n「什么样的蛇？」\n「很漂亮！周身泛白，上面还有金色的纹路……」\n医生不再言语，嘴角微不可闻地扬了起来。\n「谢谢。」"
  },
  Event_47911_Name = {
    Text = "「催眠蛇」"
  },
  Event_47912_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47912_Desc = {
    Text = "她直直望进医生钴黄色的眼睛。\n「我看见你变成了一条蛇。」\n「噢。为什么你确定那是我？」\n因为它神秘，静止，繁复。\n并且……\n它看上去很倦怠，仿佛刚从一场历时千年的冬眠中苏醒。"
  },
  Event_47912_Name = {
    Text = "「催眠蛇」"
  },
  Event_47992_ChoiceDesc1 = {
    Text = "【接通】回复 Arg2 点生命。"
  },
  Event_47992_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_47992_ChoiceDesc3 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_47992_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_47992_Name = {Text = "联络点"},
  Event_47992_Tips3 = {
    Text = "当前并未拥有症状卡"
  },
  Event_47993_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_47993_ChoiceDesc2 = {
    Text = "【离开】随机 1 张指令卡获得刻印：「(EnchantConfig.Arg1)」并复制 1 张该卡牌的原始版本"
  },
  Event_47993_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_47993_Name = {Text = "联络点"},
  Event_48225_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48225_Desc = {
    Text = "猫咪开心地舔了舔你的手背。\n「谢谢你，不必为我难过喵。\n这里的人格随时都在死亡、新生，\n我一定会回来的！\n喵喵，喵喵喵！」"
  },
  Event_48225_Name = {
    Text = "临终嘱托"
  },
  Event_48226_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48226_Desc = {
    Text = "猫咪认为你没有理解它的意思，于是讨好地蹭了蹭你的手背。\n「只要你肯答应喵，喵会将私藏的零食都献给你。\n它们被妥善保管在坎布雷街区@2号……」"
  },
  Event_48226_Name = {
    Text = "临终嘱托"
  },
  Event_48227_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48227_Desc = {
    Text = "你向乔治表达了诚挚的歉意。\n「哼，你还算是个知晓礼节的家伙。\n乔治会考虑将诅咒力度下调10%，\n最多15%——这是乔治的底线。」"
  },
  Event_48227_Name = {
    Text = "乔治的幽灵"
  },
  Event_48228_ChoiceDesc1 = {
    Text = "【答应它】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48228_ChoiceDesc2 = {
    Text = "【拒绝它】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_48228_ChoiceDesc3 = {
    Text = "【保持沉默】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_48228_Desc = {
    Text = "「猫咪24」受了很严重的伤，它挣扎着告诉你：\n「呜呜，命不久矣喵。\n我有个朋友，是一条银鳕鱼喵。\n如果哪天你见到它，就说我出远门了喵。\n要离开很久很久喵。\n会给它带回来很多没有炸鱼的薯条喵。\n一定要告诉它哦！」"
  },
  Event_48228_Name = {
    Text = "临终嘱托"
  },
  Event_48229_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48229_Desc = {
    Text = "猫咪有些失望。\n但它一直是一只听话乖巧的猫咪，从不勉强别人。\n最后它带着遗憾合上了双眼。"
  },
  Event_48229_Name = {
    Text = "临终嘱托"
  },
  Event_48230_ChoiceDesc1 = {
    Text = "【向它道歉】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48230_ChoiceDesc2 = {
    Text = "【嘲讽它】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_48230_ChoiceDesc3 = {
    Text = "【无视它】获得25黑印"
  },
  Event_48230_Desc = {
    Text = "一个幽灵，乔治的幽灵在你们上空盘旋。\n「乔治死得毫无尊严。\n不过没关系，乔治永远铭记这次羞辱。\n守密人，你要倒大霉了，哼哼哼……」"
  },
  Event_48230_Name = {
    Text = "乔治的幽灵"
  },
  Event_48231_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48231_Desc = {
    Text = "「呵呵，竟敢嘲讽乔治。\n放心吧，在你吃饭的时候、睡觉的时候、唱歌的时候……\n乔治都会在一旁飘来飘去，提醒你、折磨你。\n好叫你永远铭记自己的罪孽。\n你永远抓不到一只幽灵，啦啦啦~」"
  },
  Event_48231_Name = {
    Text = "乔治的幽灵"
  },
  Event_48232_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_48232_Desc = {
    Text = "你大步向前，将乔治的诅咒抛诸脑后。\n身后传来抽噎声，乔治竟大哭起来。\n「呜呜……如此可爱的我，竟然被你的屁股——\n恶心！恶心！\n乔治宁愿死在潘狄娅的皮鞭下！」"
  },
  Event_48232_Name = {
    Text = "乔治的幽灵"
  },
  Event_49055_ChoiceDesc1 = {
    Text = "【呼唤唤醒体】扣除所有唤醒体 100 狂气，删除 1 张症状卡"
  },
  Event_49055_ChoiceDesc2 = {
    Text = "【奋力挣扎】回复 Arg1 点生命，感染2张「(Skill.Arg2)」"
  },
  Event_49055_ChoiceDesc3 = {
    Text = "【插入银钥匙】清空所有银钥能量"
  },
  Event_49055_Desc = {
    Text = "影影绰绰的血污池在你踏上的瞬间现出了真身。\n赤黑色的血污伸出不可计数的手臂，攀附在你的脚踝，不断向上攀扯，意图将你拖入不可测的深渊。"
  },
  Event_49055_Name = {
    Text = "血污之池"
  },
  Event_49097_ChoiceDesc1 = {
    Text = "【前行】"
  },
  Event_49097_Desc = {
    Text = "腹腔内翻江倒海，数秒后奇迹般恢复平静，不知为何，你仿佛在体内聆听到另一个鼓动的心跳……"
  },
  Event_49097_Name = {
    Text = "孕育之母"
  },
  Event_49098_ChoiceDesc1 = {
    Text = "【一饮而尽】选择 [ExDesc3][ExDesc4] 张指令卡，使其获得刻印：「(EnchantConfig.Arg1)」[ExDesc1][ExDesc2]"
  },
  Event_49098_Desc = {
    Text = "破旧的陶罐在低矮岩壁的狭缝中凝望着你。\n水源是沙漠中最珍贵的物资，酒精是疯狂与迷幻世界的引药。\n在这贫瘠地带，一个尚存理智的人很难拒绝它的邀约。"
  },
  Event_49098_Name = {
    Text = "孕育之母"
  },
  Event_49312_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49312_Desc = {
    Text = "银钥匙辉光闪烁，手臂们似被某种力量震慑，纷纷隐入池水，然后消失不见。"
  },
  Event_49312_Name = {
    Text = "血污之池"
  },
  Event_49313_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49313_Desc = {
    Text = "你奋力挣扎，却越陷越深，脑海中响起诅咒般呓语之声。\n回过神时，血色触手们心满意足地退去了。你竟觉得浑身畅快，只是冥冥之中似乎已经失去了什么……"
  },
  Event_49313_Name = {
    Text = "血污之池"
  },
  Event_49314_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49314_Desc = {
    Text = "应声而来的唤醒体未有片刻迟疑便将你拽出了血污之池，连接着你的手臂被撕裂，混浊的泥水飞溅，水中无数肉眼难以分辨的生物蠕动着，仿佛渴求和吞噬着什么。"
  },
  Event_49314_Name = {
    Text = "血污之池"
  },
  Event_49867_ChoiceDesc1 = {
    Text = "随机唤醒体加50狂气"
  },
  Event_49867_Name = {Text = "事件"},
  Event_49907_ChoiceDesc1 = {
    Text = "【询问真假】"
  },
  Event_49907_ChoiceDesc2 = {
    Text = "【请求抚摸】"
  },
  Event_49907_Desc = {
    Text = "「你总是一脸好奇地盯着我的角看，有什么问题吗？」\n泰旖丝突然贴近你的肩膀，蜂蜜色的珠坠摇摇晃晃地轻拂着你的脸颊。"
  },
  Event_49907_Name = {
    Text = "犄角之人"
  },
  Event_49908_ChoiceDesc1 = {
    Text = "【朝上看去】"
  },
  Event_49908_ChoiceDesc2 = {
    Text = "【走向泰旖丝】"
  },
  Event_49908_Desc = {
    Text = "废墟中烟尘四散，一角的破窗外，突然出现泰旖丝的身影。她毫无芥蒂地伏身在落满灰尘的窗沿，神神秘秘地指了指屋梁上。"
  },
  Event_49908_Name = {
    Text = "潜行之人"
  },
  Event_49909_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49909_Desc = {
    Text = "你抬起头，锈迹斑斑的铜管四通八达，如同巨大的蜘蛛网般覆盖在头顶。一个阴影掠过，是觅食的野猫还是躲在阴影中的怪物？\n再回过头，泰旖丝也不见了踪影。"
  },
  Event_49909_Name = {
    Text = "潜行之人"
  },
  Event_49910_ChoiceDesc1 = {
    Text = "【注视她】"
  },
  Event_49910_ChoiceDesc2 = {
    Text = "【呼唤她】"
  },
  Event_49910_Desc = {
    Text = "你又见到了那个「幻影」。\n这一次，你已经知道了她的名字。\n泰旖丝站在遥远的母树之下，虔诚地向树祈祷。\n她的轮廓影影绰绰，与母树的幻影仿若一体。"
  },
  Event_49910_Name = {
    Text = "祈愿之人"
  },
  Event_49911_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49911_Desc = {
    Text = "你远眺着泰旖丝的身影，她的轮廓在这末日般的风暴中宛若一座神圣庄严的孤峰，纵使沙暴肆虐亦不能丝毫削弱其威严。\n她的迈步缓慢而稳健，她的身姿高贵而不可侵犯，令你看得入迷。"
  },
  Event_49911_Name = {
    Text = "永生之人"
  },
  Event_49912_ChoiceDesc1 = {
    Text = "【离开】选择复制1张指令卡"
  },
  Event_49912_Desc = {
    Text = "「你猜呢？」\n她「嘘」了一声，躬身凑得更近，你感觉角的末梢已经蹭上了你的脸颊，带着微凉微痒的感觉……"
  },
  Event_49912_Name = {
    Text = "犄角之人"
  },
  Event_49913_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49913_Desc = {
    Text = "「想摸就大方点说嘛，我难道会拒绝你吗？」\n她轻笑着拉着你的手，指尖触碰的质感温热而滑腻，让你几乎想要深陷其中……"
  },
  Event_49913_Name = {
    Text = "犄角之人"
  },
  Event_49914_ChoiceDesc1 = {
    Text = "【离开】选择觉醒1名唤醒体，使其觉醒卡费用-1，感染「(Skill.Arg1)」"
  },
  Event_49914_Desc = {
    Text = "你与众人一同跪伏于地。\n「我就知道、我就知道，女王，女王大人一直在守护我们！」\n喜极而泣的哭喊声、悠长的呼唤声夹杂着风的呼啸，与你的脑腔共鸣震荡。\n隐约中，有什么关键的思绪一闪而过，却无法捕捉。"
  },
  Event_49914_Name = {
    Text = "永生之人"
  },
  Event_49915_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_49915_Desc = {
    Text = "你向她挥了挥手。\n「你在做什么？」拉蒙娜疑惑地看向你。\n「那里……」\n话未出口，远方那位女性已经不见踪影。\n难道是错觉？"
  },
  Event_49915_Name = {
    Text = "鞠水之人"
  },
  Event_49916_ChoiceDesc1 = {
    Text = "【回应她】"
  },
  Event_49916_ChoiceDesc2 = {
    Text = "【犹豫】"
  },
  Event_49916_Desc = {
    Text = "远远望去，一名女性正在河岸边鞠水。\n似乎是意识到你的目光，她回身向你招手。\n你注意到，她转身的方式似乎有些异样。"
  },
  Event_49916_Name = {
    Text = "鞠水之人"
  },
  Event_49917_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印「(EnchantConfig.Arg1)」"
  },
  Event_49917_Desc = {
    Text = "在你犹豫间，女人一转身跃入绿洲间不见了。\n你不太敢相信自己的眼睛……她似乎长着羊的蹄子？"
  },
  Event_49917_Name = {
    Text = "鞠水之人"
  },
  Event_49918_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印「(EnchantConfig.Arg1)」"
  },
  Event_49918_Desc = {
    Text = "「树啊，请聆听@1人的祈愿，我将沐浴您的乳汁而重生，成为您的代行者，为您行走于黄沙之间，令您的根系触达勒姆瓦希的每个角落……」\n\n此起彼伏的稚嫩祈祷之声在空间中回荡。"
  },
  Event_49918_Name = {
    Text = "祈愿之人"
  },
  Event_49919_ChoiceDesc1 = {
    Text = "【离开】随机觉醒1名唤醒体"
  },
  Event_49919_Desc = {
    Text = "泰旖丝暧昧莫名的目光牵扯了你的注意，某种诡谲的力量令你在不由间神魂颠倒，你似被牵引，忍不住向她走去。\n「其实，看不见的事物，也依然存在。」\n她轻轻对你耳语，你似有所悟，却像是笼罩了一层白纱，看不明晰。\n这是某种预言吗？恍然间，泰旖丝已不见了踪影。"
  },
  Event_49919_Name = {
    Text = "潜行之人"
  },
  Event_49920_ChoiceDesc1 = {
    Text = "【眺望】"
  },
  Event_49920_ChoiceDesc2 = {
    Text = "【跪伏】"
  },
  Event_49920_Desc = {
    Text = "羊的黑蹄踏上风沙的大地。\n泰旖丝唱诵着不知名的祷文，无数亚兰人迎着她踏沙而来的方向跪伏。"
  },
  Event_49920_Name = {
    Text = "永生之人"
  },
  Event_49921_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_49921_Desc = {
    Text = "巨树探出万千粗壮的枝条，如绞缠的触肢，将泰旖丝的手腕足踝紧紧缚住，不顾她的挣扎抗拒，蛮横地将她的躯干纳入膨胀的树茎腹腔……\n\n尽管只是遥远的虚影，她的痛苦依然随着水波的震荡直抵你的内心。"
  },
  Event_49921_Name = {
    Text = "祈愿之人"
  },
  Event_49922_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」"
  },
  Event_49922_Desc = {
    Text = "瘫软的肢体随着树的浆液流淌于枝干，她竭尽全力挣扎，肢体却像是蹒跚扭曲的蠕虫不听使唤。\n「骨骼已经完全溶解了，」泰旖丝的眼角眉梢被悲哀侵染，「她已经是树的一部分了。」\n「我们需要逆转的力量……超越时间的力量。」"
  },
  Event_49922_Name = {
    Text = "腐蚀之人"
  },
  Event_49923_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_49923_Desc = {
    Text = "「而且，那位“倒悬的无目之瞳”，不知为何，有一种发自肺腑的强烈感召力……」\n「哎呀，在聊我的事情吗？」\n「美迪奈特在盛赞你讲故事的能力呢。」\n\n那个篝火悄然燃烧的夜晚，她曾为你添过一杯酒。"
  },
  Event_49923_Name = {
    Text = "腐蚀之人"
  },
  Event_49924_ChoiceDesc1 = {
    Text = "【剖开树瘤】"
  },
  Event_49924_ChoiceDesc2 = {
    Text = "【回忆】"
  },
  Event_49924_Desc = {
    Text = "一枚树瘤。\n它邪恶而肿胀地跳动着，脆弱透明的血色表皮内侧透出一张乖戾而痛楚的脸，仿佛随时要破茧而出。\n「美迪奈特。」泰旖丝面露悲伤之色，温柔地呼唤那张脸的名字。"
  },
  Event_49924_Name = {
    Text = "腐蚀之人"
  },
  Event_49939_ChoiceDesc1 = {
    Text = "【相信莱克】所有唤醒体回复Arg1狂气"
  },
  Event_49939_ChoiceDesc2 = {
    Text = "【担忧莱克】选择觉醒2名唤醒体"
  },
  Event_49939_Desc = {
    Text = "「相信我的好运吧。」"
  },
  Event_49939_Name = {
    Text = "好运侦探"
  },
  Event_49940_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49940_Desc = {
    Text = "莱克擅长的事只有三件：侦查、聆听、掷骰。\n换句话说，并不以战斗见长。\n你内心的担忧难以抑制，疯狂滋长。"
  },
  Event_49940_Name = {
    Text = "好运侦探"
  },
  Event_49941_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49941_Desc = {
    Text = "相信的心是魔法，他定能战胜眼前的一切阻碍。"
  },
  Event_49941_Name = {
    Text = "好运侦探"
  },
  Event_49943_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49943_Desc = {
    Text = "你感到很不好意思，却还是充满企求地望向了仍在病中的拉蒙娜。\n“我来吧。”\n她涨红着脸，从那个无限容量的随身手提箱中拿出一枚簇新的采集瓶，眼疾手快地将蜘蛛罩住。"
  },
  Event_49943_Name = {Text = "毒蛛"},
  Event_49944_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49944_Desc = {
    Text = "莱克打了个响指，然后将毛茸茸的食指伸向高举前足的大蜘蛛。\n这类花纹斑斓的物种多半有剧毒，你刚要提醒他小心，刚才还充满敌意的蜘蛛却轻巧地蹦上他的指节，蜷缩了起来。\n算了，人各有命。"
  },
  Event_49944_Name = {Text = "毒蛛"},
  Event_49945_ChoiceDesc1 = {
    Text = "【看向拉蒙娜】获得3选1刻印"
  },
  Event_49945_ChoiceDesc2 = {
    Text = "【看向莱克】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49945_Desc = {
    Text = "多重复眼与你面面相觑。\n复眼的主人后退了半步，张牙舞爪地对你发出威吓。\n从那高抬的步足和触肢和支撑身体的两对足看起来，这的确是一只罕见的蛛形纲生物。\n临行前诃勒特的叮嘱言犹在耳：“额外任务，请采集当地物种样本并留存至当地勘测站。”\n你晃了晃背包里的采集瓶，经过数周跋涉，里面已经虫满为患。"
  },
  Event_49945_Name = {Text = "毒蛛"},
  Event_49946_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49946_Desc = {
    Text = "「不顾时机的贪婪是一种疾病。」"
  },
  Event_49946_Name = {
    Text = "你的答案"
  },
  Event_49947_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49947_Desc = {
    Text = "「照本宣科并不能为你博得好感，孩子。」"
  },
  Event_49947_Name = {
    Text = "你的答案"
  },
  Event_49948_ChoiceDesc1 = {
    Text = "【金钥匙】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_49948_ChoiceDesc2 = {
    Text = "【铁钥匙】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_49948_ChoiceDesc3 = {
    Text = "【银钥匙】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_49948_Desc = {
    Text = "正午时分，圣河蒸腾的水气凝成两具虚空的幻影。\n幻影朦胧的声音向你发问：这是你掉的金钥匙、银钥匙、还是铁钥匙？"
  },
  Event_49948_Name = {
    Text = "你的答案"
  },
  Event_49949_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_49949_Desc = {
    Text = "「诚实往往会带来更稳妥的结果，但在同时，你或许也会错失什么。」"
  },
  Event_49949_Name = {
    Text = "你的答案"
  },
  Event_50013_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50013_Desc = {
    Text = "你仔细辨认，那个人的面容却随着水波浮荡，朦胧不清。\n\n你越是定睛凝神，呼吸就越是迟滞，大脑传来缺氧般的迷幻感，直至听见拉蒙娜呼唤你的声音，才勉强被拉回现实。\n水面倒映的烈日异常刺眼，但水面下似乎有什么闪闪发光。"
  },
  Event_50013_Name = {
    Text = "死亡幻影"
  },
  Event_50014_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50014_Desc = {
    Text = "幻影一触即溃，你的手中空无一物，唯有太阳穴突然爆发的剧烈刺痛。\n水面倒映的烈日异常刺眼，但水面下似乎有什么闪闪发光。"
  },
  Event_50014_Name = {
    Text = "死亡幻影"
  },
  Event_50015_ChoiceDesc1 = {
    Text = "【努力辨认】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50015_ChoiceDesc2 = {
    Text = "【伸手触碰】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50015_ChoiceDesc3 = {
    Text = "【揉揉眼睛】获得25黑印"
  },
  Event_50015_Desc = {
    Text = "你被努比亚一推，半条腿陷入圣河之中。\n你勉力稳住身形，却在摇晃的水波中见到了不应见的倒影。\n那是一位身穿弥萨格校服、身姿颀长的青年，他瘫软的躯体倒陷于圣河的水流之中。"
  },
  Event_50015_Name = {
    Text = "死亡幻影"
  },
  Event_50016_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50016_Desc = {
    Text = "恐慌腐蚀着你的心智，痛苦让意识变得模糊，你极力撕扯，藤蔓却越收越紧，鼻腔渗入了散发异味的黏液，每一次呼吸都带着黏稠的绝望。\n拉蒙娜一剑刺下，努比亚断足而逃，你扯下最后一截黏附脸侧的触手，上面竟然沾着层模糊的血肉。"
  },
  Event_50016_Name = {
    Text = "扑面而来"
  },
  Event_50017_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50017_Desc = {
    Text = "银光刺入努比亚的身躯，血肉爆裂的感受顺着银钥匙传递至你的指尖与手腕。\n努比亚扭曲的触肢向天空高举，尖啸般发出恐怖而哀怨的嘶鸣，通体化作黏稠的不明液体。"
  },
  Event_50017_Name = {
    Text = "扑面而来"
  },
  Event_50018_ChoiceDesc1 = {
    Text = "【撕扯】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50018_ChoiceDesc2 = {
    Text = "【穿刺】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50018_Desc = {
    Text = "努比亚缠藤状的触手扭曲飞舞，趁隙扑上你的脸颊，狂暴地侵入你的口鼻。"
  },
  Event_50018_Name = {
    Text = "扑面而来"
  },
  Event_50019_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50019_Desc = {
    Text = "水面上只有粼粼波光。\n你拔起湿漉漉的腿，倒出鞋中潮湿的砂砾。\n刚才的影像仍徘徊在脑海中，挥之不去。"
  },
  Event_50019_Name = {
    Text = "死亡幻影"
  },
  Event_50029_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50029_Desc = {
    Text = "「他会回来吗？还是永远将你遗落在这无垠沙海之中呢？」\n「他能找到你吗？还是会因为风向与沙丘的流变而迷失你的坐标呢？」\n「你寄托于他人身上的希望，果真有那么可靠吗？」"
  },
  Event_50029_Name = {
    Text = "失落沙洲"
  },
  Event_50030_ChoiceDesc1 = {
    Text = "【寻求救援】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_50030_ChoiceDesc2 = {
    Text = "【共同前进】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50030_Desc = {
    Text = "一个古老而悠远的声音混合在潺潺水流声中向你发问。\n「你迷失于漫漫黄沙之中。」\n「摆在你面前的有两个选择。你的同伴脚程更快，让他带着食物和水去寻求救援，你们以最小的消耗留在原地。」\n「或者你们共享一切，继续前行。」"
  },
  Event_50030_Name = {
    Text = "失落沙洲"
  },
  Event_50031_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50031_Desc = {
    Text = "「你们未必能走得更远，但你们的灵与肉紧紧相依，从中获得鼓舞彼此的力量。」\n「这便是你的选择。」\n说着，高空中灼人的烈日合上了眼。"
  },
  Event_50031_Name = {
    Text = "失落沙洲"
  },
  Event_50064_ChoiceDesc1 = {
    Text = "【切断红绸】删除1张指令卡，获得Arg1黑印"
  },
  Event_50064_ChoiceDesc2 = {
    Text = "【对抗】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_50064_ChoiceDesc3 = {
    Text = "【呼唤拉蒙娜】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50064_Desc = {
    Text = "卡茜亚甩出红绸，瞬间缠住了你的手提箱。"
  },
  Event_50064_Name = {
    Text = "绞缠之绸"
  },
  Event_50065_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50065_Desc = {
    Text = "时断时续的清脆敲击声在你们头顶纵横交错的管道间回旋起伏，像一个独自跳舞的幽魂，在这片死寂的空间里摆动无力的双臂。\n这种遐想在你的心底召唤起古老恐惧的森严寒意。"
  },
  Event_50065_Name = {
    Text = "诡异音阶"
  },
  Event_50066_ChoiceDesc1 = {
    Text = "【在洞口探索】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_50066_ChoiceDesc2 = {
    Text = "【深入岩洞】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50066_Desc = {
    Text = "「这儿有个岩洞。」\n泰旖丝侧身向你发出邀请。\n「要不要进去看看？」\n狭窄的岩洞幽暗深邃，犹如恶魔的巨口，伸展向无尽的黑暗。任谁踏入这片荒凉之地，都无法摆脱脊髓深处升腾的不祥预感。仿佛在这岩洞的每个角落，都潜伏着那些不敢直视阳光的古老生物，静待着闯入者的到来。"
  },
  Event_50066_Name = {
    Text = "黑暗洞窟"
  },
  Event_50067_ChoiceDesc1 = {
    Text = "【逐一击破】随机1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_50067_ChoiceDesc2 = {
    Text = "【包围二人】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50067_ChoiceDesc3 = {
    Text = "【偷听谈话】获得25黑印"
  },
  Event_50067_Desc = {
    Text = "两名亚兰人看守着工厂大门。\n其中一个无所事事地闲晃着，找另一位搭话。\n「有人说，于丽埃特大人又在清点尝试突破风暴之壁的队伍了。」\n「我可千万千万别选上啊。」"
  },
  Event_50067_Name = {
    Text = "闲散的看门人"
  },
  Event_50067_Tips1 = {
    Text = "尚未拥有白银造物"
  },
  Event_50068_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50068_Desc = {
    Text = "不看、不听、不想。\n不去幻想那不合时宜的音色从何而来，你直奔母树遗骸的所在。"
  },
  Event_50068_Name = {
    Text = "诡异音阶"
  },
  Event_50069_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50069_Desc = {
    Text = "拉蒙娜一剑刺向挥舞红绸的卡茜亚，卡茜亚急忙避让，纠缠你的红绸也在瞬间松脱。"
  },
  Event_50069_Name = {
    Text = "绞缠之绸"
  },
  Event_50070_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50070_Desc = {
    Text = "你们兵分两路，你和拉蒙娜自左，莱克自右，从两侧夹击。\n你抬手示意，拉蒙娜和莱克一齐出手，两名亚兰守卫无声倒地。"
  },
  Event_50070_Name = {
    Text = "闲散的看门人"
  },
  Event_50071_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50071_Desc = {
    Text = "此时不宜深入陷阱。你们仅在洞口徘徊，就几乎能感受到岩石脉搏中蕴藏的邪恶跳动。"
  },
  Event_50071_Name = {
    Text = "黑暗洞窟"
  },
  Event_50072_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50072_Desc = {
    Text = "在你的示意下，莱克一骰子砸晕了沉默的亚兰看守，然后悄悄靠近了另一个仍在喋喋不休的家伙。\n「嘿，兄弟，如果那个什么于丽埃特大人是个骗子，你说怎么办？」\n「我也不知道怎么办。」\n莱克快乐地龇牙，看守浑身一颤，正欲尖叫，被莱克捂住了口鼻。"
  },
  Event_50072_Name = {
    Text = "闲散的看门人"
  },
  Event_50073_ChoiceDesc1 = {
    Text = "【仔细聆听】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50073_ChoiceDesc2 = {
    Text = "【捂住耳朵】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_50073_ChoiceDesc3 = {
    Text = "【查看】获得3选1刻印"
  },
  Event_50073_Desc = {
    Text = "你们进入遗骸所在的楼层时，空旷的废弃工厂内突兀地传来悦耳的叮咚之声，钢琴鸣奏的清泠之感与锈蚀的钢铁废墟格格不入。"
  },
  Event_50073_Name = {
    Text = "诡异音阶"
  },
  Event_50074_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50074_Desc = {
    Text = "「嘿，兄弟，如果那个什么于丽埃特大人是个骗子，你说怎么办？」\n「别乱说，自从于丽埃特到来，一切都被打理得井井有条。她是个骗子，为什么要帮亚兰人这么多？」\n他们闲谈间，莱克悄无声息地选好了埋伏的位置，砰砰两枚骰子飞出，将二人击倒在地。"
  },
  Event_50074_Name = {
    Text = "闲散的看门人"
  },
  Event_50075_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50075_Desc = {
    Text = "你鼓起勇气瞪视回去。\n幕布的巨眼陡然扭曲狞笑，你的顽强抵抗动摇溃败。"
  },
  Event_50075_Name = {
    Text = "魔术之眼"
  },
  Event_50076_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50076_Desc = {
    Text = "你心无旁骛地撕裂幕布。\n巨眼在你的手下化作一片缺乏立体感的破碎布料。"
  },
  Event_50076_Name = {
    Text = "魔术之眼"
  },
  Event_50077_ChoiceDesc1 = {
    Text = "【回瞪】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50077_ChoiceDesc2 = {
    Text = "【撕裂幕布】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50077_Desc = {
    Text = "幕布张开无数扭曲的巨眼。\n潜匿在眼瞳之后的巨物流露出异常的饥渴，蠢蠢欲动。"
  },
  Event_50077_Name = {
    Text = "魔术之眼"
  },
  Event_50078_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50078_Desc = {
    Text = "原来是一截废弃的长条状零件被你们的动静震动，摇摇晃晃地敲打铁质管道。"
  },
  Event_50078_Name = {
    Text = "诡异音阶"
  },
  Event_50079_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50079_Desc = {
    Text = "泰旖丝泰然踏入岩洞之中，你在背后亦步亦趋地探索。\n「小心！」你被猝然拉开，跌坐在一个柔软的怀抱中。你们身前，一只漆黑的巨兽迅猛无匹地冲出了洞穴。\n「看这里，」你仍惊魂未定之际，泰旖丝开口了，她的眼睛在黑暗中闪着微弱的荧光，「恐怕是它的宝藏呢。」"
  },
  Event_50079_Name = {
    Text = "黑暗洞窟"
  },
  Event_50080_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50080_Desc = {
    Text = "你拼命拽住手提箱的提手，与红绸对抗。\n但那红绸力大无穷，你的手提箱脱手，杂物散落一地。"
  },
  Event_50080_Name = {
    Text = "绞缠之绸"
  },
  Event_50081_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50081_Desc = {
    Text = "你讨厌被束缚的感觉。\n你拽住红绸，滋啦一声将它一撕两断。\n剩余的半截红绸像是一条红蛇般游走。"
  },
  Event_50081_Name = {
    Text = "绞缠之绸"
  },
  Event_50276_ChoiceDesc1 = {
    Text = "【消灭祭品】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50276_ChoiceDesc2 = {
    Text = "【解开绳索】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50276_ChoiceDesc3 = {
    Text = "【继续前进】获得50黑印"
  },
  Event_50276_Desc = {
    Text = "三名亚兰人被捆缚于高台之上。\n他们的身上浮现出你在婴孩身上曾见过的树皮状深色纹路，口中念念有词。"
  },
  Event_50276_Name = {
    Text = "三枚祭品"
  },
  Event_50277_ChoiceDesc1 = {
    Text = "【凝视】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50277_ChoiceDesc2 = {
    Text = "【无视】获得3选1刻印"
  },
  Event_50277_Desc = {
    Text = "亚兰人在沙暴中跪伏。\n风暴抽打着他们的躯壳，砂砾席卷他们的虔心。\n沙尘的漩涡之中，似乎有无数只巨眼俯瞰着扭曲的大地。"
  },
  Event_50277_Name = {
    Text = "沙尘巨物"
  },
  Event_50278_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50278_Desc = {
    Text = "你不愿意回想的画面再次在眼前浮现。\n摇摇摆摆的触肢，玻璃破片切割的汩汩血痕……\n你作呕起来。"
  },
  Event_50278_Name = {Text = "孤旅Ⅱ"},
  Event_50279_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50279_Desc = {
    Text = "她不在这里，她不在最危险的热潮之中。\n这就足够让你安心了。"
  },
  Event_50279_Name = {Text = "孤旅Ⅰ"},
  Event_50280_ChoiceDesc1 = {
    Text = "【偷袭】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_50280_ChoiceDesc2 = {
    Text = "【攻击】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50280_Desc = {
    Text = "一只努比亚在剧烈的沙暴中挣扎。\n它的四蹄深深嵌入黄沙，竭力避免被卷入漩涡。"
  },
  Event_50280_Name = {
    Text = "自然沙暴"
  },
  Event_50281_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50281_Desc = {
    Text = "你毅然闯入，在亚兰人的惊呼声中将绳索扯开。\n一名亚兰战士试探着逼近，你劈手夺过他手中的长矛，指向黑洞洞的人群。"
  },
  Event_50281_Name = {
    Text = "三枚祭品"
  },
  Event_50282_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50282_Desc = {
    Text = "理智告诉你，他不会来了。\n是啊，谁会指望一个赌徒信守诺言呢？\n你只能孤独。你只有孤独。"
  },
  Event_50282_Name = {Text = "孤旅Ⅲ"},
  Event_50283_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50283_Desc = {
    Text = "那异常的高烧会随着母树的复生而加剧吗？\n拉蒙娜独自在风暴之壁外能照顾好自己吗？\n现在不是分心的时候，但你忍不住担忧起你的搭档。"
  },
  Event_50283_Name = {Text = "孤旅Ⅰ"},
  Event_50284_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50284_Desc = {
    Text = "你决意正面迎击，努比亚反而像是找到了难得的落脚点，一跃而上攀住了你的头颅。\n你陷入沙暴与努比亚的双重纠缠之中。\n「一味蛮勇并非取胜之法，」威廉冰冷的话音在被堵住耳腔的你听来简直是天使的福音，「学会把握机会。」"
  },
  Event_50284_Name = {
    Text = "自然沙暴"
  },
  Event_50285_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50285_Desc = {
    Text = "现在可不是悠闲读报的时候。"
  },
  Event_50285_Name = {
    Text = "她的叮咛"
  },
  Event_50286_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50286_Desc = {
    Text = "你不去想，你不去回忆。\n你不愿想，你不愿回忆。\n弥萨格的传奇会落幕，但弥萨格的历程不会中止。\n你必须走下去。你必须走下去。"
  },
  Event_50286_Name = {Text = "孤旅Ⅱ"},
  Event_50287_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50287_Desc = {
    Text = "「亲爱的守密人：\n见信安。\n很抱歉在这次勒姆瓦希之旅中因为没打理好自己的身体，不能一直陪在你身边。\n但在关键的时刻，请相信你唯一的助手。\n你需要我的时候，我永远都在。」\n时间原因，你无法再阅读下去了。\n但熟悉的字迹带给你一种令心绪平和的安定感。"
  },
  Event_50287_Name = {
    Text = "她的叮咛"
  },
  Event_50288_ChoiceDesc1 = {
    Text = "【他还会来】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_50288_ChoiceDesc2 = {
    Text = "【他不会来了】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50288_Desc = {
    Text = "最后一个离开的人是莱克。\n为了阻止卡茜亚，他选择了留在营帐中。\n他曾经答应你，最后要硬闯仪式现场去焚烧母树，他也绝对奉陪。\n可他现在还是没有来到你身边。\n只留你孤身一人。"
  },
  Event_50288_Name = {Text = "孤旅Ⅲ"},
  Event_50289_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50289_Desc = {
    Text = "咕噜咕噜，三枚圆圆的恐怖之物在仪式现场滚动。\n你觉得自己不像是自己了，病态狂热的仪式氛围将你卷入不可名状的虚无之中。"
  },
  Event_50289_Name = {
    Text = "三枚祭品"
  },
  Event_50290_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50290_Desc = {
    Text = "亚兰的信仰如此虔诚，甘愿一次次被黄沙埋葬。\n可你抬头仰望，风暴中没有太阳。"
  },
  Event_50290_Name = {
    Text = "沙尘巨物"
  },
  Event_50291_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50291_Desc = {
    Text = "愿沙海回应他们的虔诚。"
  },
  Event_50291_Name = {
    Text = "沙尘巨物"
  },
  Event_50292_ChoiceDesc1 = {
    Text = "【挣脱回忆】随机提升1张卡牌的刻印品质"
  },
  Event_50292_ChoiceDesc2 = {
    Text = "【捕捉回忆】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50292_Desc = {
    Text = "第二个离开的人是威廉。"
  },
  Event_50292_Name = {Text = "孤旅Ⅱ"},
  Event_50293_ChoiceDesc1 = {
    Text = "【安心】获得25黑印"
  },
  Event_50293_ChoiceDesc2 = {
    Text = "【担忧】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50293_Desc = {
    Text = "你突然回忆起踏上旅程的那天。\n拉蒙娜提醒你收拾好行囊，威廉为你准备了沿途纪录的手册，莱克偷偷往你的包里塞了一瓶威士忌。\n现在他们已经离开了。\n\n第一个离开的人是拉蒙娜，塔薇的力量与风暴之壁的权能相互排斥，她溃败于沿途的高烧。"
  },
  Event_50293_Name = {Text = "孤旅Ⅰ"},
  Event_50294_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50294_Desc = {
    Text = "你偷袭努比亚的足部，它站立不稳，几条藤蔓状的触肢在空中急促而凌乱舞动，最终被卷入了尘暴之中。"
  },
  Event_50294_Name = {
    Text = "自然沙暴"
  },
  Event_50295_ChoiceDesc1 = {
    Text = "【阅读】删除1张卡牌"
  },
  Event_50295_ChoiceDesc2 = {
    Text = "【收起】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_50295_Desc = {
    Text = "咔哒咔哒。\n在这不似人间的狂热祭坛之下，沉重的鼓声顺着沙风滚滚而来。在不绝于耳的咏唱声中，你却听到了打字机微弱的轻响——那是来自弥萨格的呼唤，慰藉你浮躁不安的心灵。"
  },
  Event_50295_Name = {
    Text = "她的叮咛"
  },
  Event_50296_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50296_Desc = {
    Text = "莱克拥有超越世俗的好运。\n他答应过你的事情，绝对会做到。\n绝对。"
  },
  Event_50296_Name = {Text = "孤旅Ⅲ"},
  Event_50297_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_50297_Desc = {
    Text = "与你无关。\n现在你最需要的，是尽快接触和破坏母树遗骸。"
  },
  Event_50297_Name = {
    Text = "三枚祭品"
  },
  Event_52373_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52373_Desc = {
    Text = "你活了下来。你看到无数被垒起的土堆，被焚烧的躯体。\n你似乎也烧掉了些什么，但那已经无关紧要。\n你听见，神国的钟声已然敲响。"
  },
  Event_52373_Name = {
    Text = "瘟疫的侵袭"
  },
  Event_52374_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52374_Desc = {
    Text = "你活了下来。你看到无数被垒起的土堆，被焚烧的躯体。\n你奋力保护着那些自己所珍视的事物，为此，你付出了惨痛的代价。但那已经无关紧要。\n你听见，神国的钟声已然敲响。"
  },
  Event_52374_Name = {
    Text = "瘟疫的侵袭"
  },
  Event_52375_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52375_Desc = {
    Text = "巨人的怒火暂时消却了。云销雨霁，风平浪静。海洋如同永恒的慈母，用温柔的潮汐轻轻抚摸利莫里亚的背脊。只留下利莫里亚身上，满身狼藉的尸首与废墟。\n你奋力保护着那些自己所珍视的事物，为此，你付出了惨痛的代价。但那已经无关紧要。\n在海洋中，你窥视到了神国的轮廓。"
  },
  Event_52375_Name = {
    Text = "海洋的轰鸣"
  },
  Event_52376_ChoiceDesc1 = {
    Text = "【献上额外祭品】删除 1 张指令卡，将 3 种「神国幻影」各 1 张加入牌库。"
  },
  Event_52376_Desc = {
    Text = "站立在利莫里亚坍塌的王座之前，你献上最后的祭品。\n无尽的深渊展露在你面前。你跪拜，微笑，泪流满面。\n“看呐，父亲，黛博拉。看呐，我至高的王——神国，已于我身前降临！”"
  },
  Event_52376_Name = {
    Text = "迎接吧，神国"
  },
  Event_52377_ChoiceDesc1 = {
    Text = "[ExDesc1][ExDesc2]"
  },
  Event_52377_ChoiceDesc2 = {
    Text = "【保护珍视之物】失去 Arg1 生命，获得 1 张随机症状卡。"
  },
  Event_52377_Desc = {
    Text = "大地。沉默的大地，平稳的大地。承载人类的大地，永恒不朽的大地。可大地在战栗。它裂出深不见底的豁口，所承托的一切都摇摇欲坠。\n你将一切希望寄托于大地，当大地开始震颤，你又将去往何处？\n献祭吧，利莫里亚的子民们向你呼唤。献祭出你的一切，让无灾的神国降临。"
  },
  Event_52377_Name = {
    Text = "大地的战栗"
  },
  Event_52378_ChoiceDesc1 = {
    Text = "[ExDesc1][ExDesc2]"
  },
  Event_52378_ChoiceDesc2 = {
    Text = "【保护珍视之物】失去 Arg1 生命，获得 1 张随机症状卡。"
  },
  Event_52378_Desc = {
    Text = "海洋。海洋是孕育利莫里亚的母亲，是你的生活，你的信仰。而此刻，海洋如传说中愤怒的巨神般站起身。祂呐喊，呼号，将温润的海水化为坚硬的巨岩与利刺，挥向身前的一切。祂冷漠地俯视在脚边战栗的利莫里亚，俯视那些昆虫般惊窜的利莫里亚人。祂将毁灭利莫里亚，这与利莫里亚无关。\n献祭吧，利莫里亚的子民们向你呼唤。献祭出你的一切，让无灾的神国降临。"
  },
  Event_52378_Name = {
    Text = "海洋的轰鸣"
  },
  Event_52379_ChoiceDesc1 = {
    Text = "[ExDesc1][ExDesc2]"
  },
  Event_52379_ChoiceDesc2 = {
    Text = "【保护珍视之物】失去 Arg1 生命，获得 1 张随机症状卡。"
  },
  Event_52379_Desc = {
    Text = "瘟疫。瘟疫无处不在。瘟疫是最为无耻的仆从，当大地与海洋的神罚过去，它便替神明宣判那些不可诉诸于口的死亡。埋葬亲人的尸体，焚烧亲人的尸体，祈祷那些为保护自己而死的至亲，离自己越远越好。生命与人性，在瘟疫面前不堪一击。\n献祭吧，利莫里亚的子民们向你呼唤。献祭出你的一切，让无灾的神国降临。"
  },
  Event_52379_Name = {
    Text = "瘟疫的侵袭"
  },
  Event_52380_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52380_Desc = {
    Text = "强烈的震动平息了。街道上沾染着殷红的血迹，倒塌的房屋下，无数的人被掩埋。\n你奋力保护着那些自己所珍视的事物，为此，你付出了惨痛的代价。但那已经无关紧要。\n唯一重要的是，你距离神国，又近了一步。"
  },
  Event_52380_Name = {
    Text = "大地的战栗"
  },
  Event_52381_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52381_Desc = {
    Text = "站立在利莫里亚坍塌的王座之前，你颂念最后的祷言。\n无尽的深渊展露在你面前。你跪拜，微笑，泪流满面。\n“看呐，父亲，黛博拉。看呐，我至高的王——神国，已于我身前降临！”"
  },
  Event_52381_Name = {
    Text = "迎接吧，神国"
  },
  Event_52382_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52382_Desc = {
    Text = "强烈的震动平息了。街道上沾染着殷红的血迹，倒塌的房屋下，无数的人被掩埋。\n你的某样东西似乎也被埋葬在了废墟之下，但那已经无关紧要。\n唯一重要的是，你距离神国，又近了一步。"
  },
  Event_52382_Name = {
    Text = "大地的战栗"
  },
  Event_52383_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_52383_Desc = {
    Text = "巨人的怒火暂时消却了。云销雨霁，风平浪静。海洋如同永恒的慈母，用温柔的潮汐轻轻抚摸利莫里亚的背脊。只留下利莫里亚身上，满身狼藉的尸首与废墟。\n你的某样东西似乎葬身于大海，但那已经无关紧要。\n在海洋中，你窥视到了神国的轮廓。"
  },
  Event_52383_Name = {
    Text = "海洋的轰鸣"
  },
  Event_52384_ChoiceDesc1 = {
    Text = "【虔心祷告】将牌库中每1张普通症状卡变为1张 「神国幻影」并再获得2张「神国幻影」。"
  },
  Event_52384_ChoiceDesc2 = {
    Text = "【虔心祷告】将牌库中每1张普通症状卡变为1张 「神国幻影」并再获得2张「神国幻影」。"
  },
  Event_52384_Desc = {
    Text = "大地不再战栗，海洋不再轰鸣，瘟疫不再侵袭。天灾毁灭了利莫里亚利，留下了你。你抬头环顾身周，满目疮痍。你低头看向双手，空空如也。\n可那又怎么样呢，尊敬的主祭？踩踏着利莫里亚的残墟与尸首，继续向前爬行吧。\n你离神国，只有一步之遥。"
  },
  Event_52384_Name = {
    Text = "迎接吧，神国"
  },
  Event_53140_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_53140_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_53140_Name = {Text = "联络点"},
  Event_53141_ChoiceDesc1 = {
    Text = "【接通】回复 Arg2 点生命。"
  },
  Event_53141_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_53141_ChoiceDesc3 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_53141_ChoiceDesc4 = {
    Text = "【堕入疯狂】随机觉醒 2 名唤醒体，获得 1 张随机症状"
  },
  Event_53141_ChoiceDesc5 = {
    Text = "【踌躇】其他"
  },
  Event_53141_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_53141_Name = {Text = "联络点"},
  Event_53141_Tips3 = {
    Text = "当前并未拥有症状卡"
  },
  Event_53142_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_53142_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_53142_Name = {Text = "联络点"},
  Event_53143_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_53143_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_53143_Name = {Text = "联络点"},
  Event_53147_ChoiceDesc1 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_53147_ChoiceDesc2 = {
    Text = "【堕入疯狂】随机觉醒 2 名唤醒体，获得 1 张随机症状"
  },
  Event_53147_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_53147_Name = {Text = "联络点"},
  Event_53147_Tips1 = {
    Text = "当前并未拥有症状卡"
  },
  Event_53148_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_53148_Desc = {
    Text = "你接通了通讯。通讯器那头响起的，是一道疯狂的、令你如痴如醉的声音。\n“铭记吧。这是神国予你的恩赐。”"
  },
  Event_53148_Name = {Text = "联络点"},
  Event_55782_ChoiceDesc1 = {
    Text = "【斩断荆棘】下一场战斗敌人生命提高 30%，伤害提高 15%，获得 Arg1 张意象「(Skill.Arg2)」。"
  },
  Event_55782_ChoiceDesc2 = {
    Text = "【斩断荆棘】下一场战斗敌人生命提高 30%，伤害提高 15%，获得 Arg1 张意象「(Skill.Arg2)」。"
  },
  Event_55782_ChoiceDesc3 = {
    Text = "【拨开荆棘】感染「(Skill.Arg3)」，将 Arg1 张意象「(Skill.Arg2)」置入牌库。"
  },
  Event_55782_ChoiceDesc4 = {
    Text = "【拨开荆棘】感染「(Skill.Arg3)」，将 Arg1 张意象「(Skill.Arg2)」置入牌库。"
  },
  Event_55782_ChoiceDesc5 = {
    Text = "【离开荆棘】「奥尔拉的笔与墨」获得 Arg1 层「笔墨」。"
  },
  Event_55782_Desc = {
    Text = "某个东西触动了你的心弦。你停下了脚步，望向花园的角落。在层层荆棘之下，一个光点正在跃动着，尝试解除掉身上的束缚。\n那是什么？蝴蝶？飞鸟？你靠近它。"
  },
  Event_55782_Name = {
    Text = "缪斯的眷顾"
  },
  Event_55782_Tips1 = {
    Text = "下一场战斗敌人已被增强，不可再次选择"
  },
  Event_55783_ChoiceDesc1 = {
    Text = "【创作献诗】选择 3 张「意象」卡，让奥尔拉为你创作「献诗」。"
  },
  Event_55783_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_55783_Desc = {
    Text = "你来到一座美丽的花房前，透过窗户，你向花房里张望，但你什么也看不见。\n一阵风吹起，花房中的花瓣与落叶被风卷动，在空中飞舞、聚拢。在花与叶中，你看到了一个少女的身影。\n“啊！花、花园里来客人了！”少女惊喜又紧张地望向你。“抱歉，柯蕾特出门了……买花的话，我不太清楚这些花的价格……”\n少女忽然停了下来，靠近你打量了两眼。“啊，这位客人，我在你身上感受到了诗的意象……或许，我们可以一起创作一首诗？”"
  },
  Event_55783_Name = {
    Text = "春天的赠礼"
  },
  Event_55783_Tips1 = {
    Text = "「意象」数量不足 3 张，不可合成"
  },
  Event_55799_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_55799_Desc = {
    Text = "活过来的荆棘似乎有些躁动,但这些代价无足轻重——在那个光点上,你听见了缪斯的呼唤。"
  },
  Event_55799_Name = {
    Text = "缪斯的眷顾"
  },
  Event_55819_ChoiceDesc1 = {
    Text = "【顺应躯体的记忆】跳过战斗立即胜利，但失去 Arg1 点生命值。"
  },
  Event_55819_ChoiceDesc2 = {
    Text = "【离开】进入战斗"
  },
  Event_55819_Desc = {
    Text = "面对熟悉的敌人，接下来的战斗你已经了然于心。"
  },
  Event_55819_Name = {
    Text = "肌肉记忆"
  },
  Event_55997_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_55997_Desc = {
    Text = "从搜集的意象里，你选出了几个，交到少女的手上。\n“好美的意象！这位客人，请等等……给。这是春天带来的，独属于你的献诗！”\n一首诗出现在你的手上，像是专门为你而开的花朵。\n你想感谢少女。但当你抬起头时，少女的身形已经消失不见。孤独的花房里，只剩满地枯萎的花与叶。\n——那是春天燃尽后，留下的余灰。"
  },
  Event_55997_Name = {
    Text = "春天的赠礼"
  },
  Event_55999_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_55999_Desc = {
    Text = "重重荆棘让你望而却步。你离开了光点，但刚刚的短暂凝视，依然让你心里充盈着新的灵感——在那个光点上，你听见了缪斯的呼唤。"
  },
  Event_55999_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56000_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_56000_Desc = {
    Text = "你用手拨开了荆棘，为此你受了一些伤，但这些代价无足轻重——在那个光点上，你听见了缪斯的呼唤。"
  },
  Event_56000_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56024_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_56024_Desc = {
    Text = "还不够……你继续向那个光点靠近。荆棘被激怒了，向你露出了尖利的刺。但一切都是值得的。\n那个光点从你的手心散开，在漫天的光幕中，你清晰地感受到了缪斯的眷顾。"
  },
  Event_56024_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56025_ChoiceDesc1 = {
    Text = "【靠近光点】下一场战斗敌人生命额外提高 30%，伤害额外提高 15%，可选择 1 张「意象」升级。"
  },
  Event_56025_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_56025_Desc = {
    Text = "你用随身的工具斩断了荆棘，那些活过来的荆棘似乎有些躁动，但这些代价无足轻重——在那个光点上，你听见了缪斯的呼唤。"
  },
  Event_56025_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56146_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_56146_Desc = {
    Text = "还不够……你继续向那个光点靠近。尖利的刺割破了你的手，让你血流不止。但一切都是值得的。\n那个光点从你的手心散开，在漫天的光幕中，你清晰地感受到了缪斯的眷顾。"
  },
  Event_56146_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56147_ChoiceDesc1 = {
    Text = "【创作冲动】所有唤醒体失去所有狂气，选择 3 张「意象」卡，让奥尔拉为你创作「献诗」。"
  },
  Event_56147_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_56147_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_56147_Name = {Text = "联络点"},
  Event_56147_Tips1 = {
    Text = "「意象」数量不足 3 张，不可合成"
  },
  Event_56148_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_56148_Desc = {
    Text = "校徽上的银光让你一阵心潮起伏。遵循着心里的指引，你将手里的东西扔进了荆棘。荆棘下的光芒开始闪耀——在那光芒之中，你领悟到了新的灵感。"
  },
  Event_56148_Name = {Text = "联络点"},
  Event_56149_ChoiceDesc1 = {
    Text = "【靠近光点】降低 10% 生命上限，可选择一张「意象」升级。"
  },
  Event_56149_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_56149_Desc = {
    Text = "你用手拨开了荆棘，为此你受了一些伤，但这些代价无足轻重——在那个光点上，你听见了缪斯的呼唤。"
  },
  Event_56149_Name = {
    Text = "缪斯的眷顾"
  },
  Event_56149_Tips1 = {
    Text = "无可升级的「意象」"
  },
  Event_56150_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_56150_Desc = {
    Text = "校徽上的银光让你一阵心潮起伏。你感到一阵强烈的冲动，将脑海中的诗句记录了下来。"
  },
  Event_56150_Name = {Text = "联络点"},
  Event_56151_ChoiceDesc1 = {
    Text = "【新的灵感】选择 1 张「意象」移除，随机升级 1 张「意象」。"
  },
  Event_56151_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_56151_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_56151_Name = {Text = "联络点"},
  Event_56151_Tips1 = {
    Text = "当前无「意象」卡"
  },
  Event_57738_ChoiceDesc1 = {
    Text = "【硬闯】所有唤醒体获得 30 点狂气，但将两张「(Skill.Arg1)」塞入卡组"
  },
  Event_57738_ChoiceDesc2 = {
    Text = "【缴械】下一场战斗敌人生命提高 60%，伤害提高 30%。"
  },
  Event_57738_ChoiceDesc3 = {
    Text = "【伏击】消耗所有唤醒体狂气，获得 30 黑印并移除守卫威胁。"
  },
  Event_57738_Desc = {
    Text = "你从拐角处的视野盲区向外窥视。审查会的探员正在监视另一个方向，并没有注意到你们的存在。\n曾经训练的画面在你脑海中一一闪过，对这个拦在必经之路上的敌人，你很快想到了合适的处理方式。"
  },
  Event_57738_Name = {
    Text = "审查会探员"
  },
  Event_57738_Tips3 = {
    Text = "当前所有唤醒体没有狂气"
  },
  Event_57739_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_57739_Desc = {
    Text = "你仔细观察着。审查会的探员拦在你们的必经之路上，正认真地监视着你面前的这块区域。\n面对人数众多的敌人，你无法与他们抗衡。\n是进，还是退？"
  },
  Event_57739_Name = {Text = "羁押点"},
  Event_57776_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_57776_ChoiceDesc2 = {
    Text = "【诈降】探索完该区域后，传送至羁押点，获得 2 张随机「症状」。"
  },
  Event_57776_ChoiceDesc3 = {
    Text = "【闯入】探索完该区域后，传送至羁押点，失去 Arg1 点生命。"
  },
  Event_57776_Desc = {
    Text = "你仔细观察着。审查会的探员拦在你们的必经之路上，正认真地监视着你面前的这块区域。\n面对人数众多的敌人，你无法与他们抗衡。\n是进，还是退？"
  },
  Event_57776_Name = {Text = "监察点"},
  Event_57776_Tips3 = {
    Text = "当前生命不足"
  },
  Event_59193_ChoiceDesc1 = {
    Text = "【阿利斯泰尔的祝福】将一张「极夜微光」加入牌库。"
  },
  Event_59193_Desc = {
    Text = "这枚入学证书一直被你压在手提箱的底部，你抚摸着仿佛镀上星辰余辉的精致边框，轻嗅着独属于纸张的淡淡墨香，弥萨格的校徽仿佛通往未来的光辉之门，吸引着你渴求的眼睛——一如那日，一如今日。"
  },
  Event_59193_Name = {
    Text = "入学仪式"
  },
  Event_59527_ChoiceDesc1 = {
    Text = "选择一张卡牌领悟「智识之理」刻印。「智识之理」：打出后抽 2 张牌，它们算力消耗降低刻印卡牌实际消耗算力，每场战斗仅生效 1 次。"
  },
  Event_59527_Desc = {
    Text = "象征智识的标记刻印在你的证件上。\n塔薇的思绪汇入你的脑海。在那无尽的可能性中，你正走向唯一正确的道路。"
  },
  Event_59527_Name = {
    Text = "入学仪式"
  },
  Event_59528_ChoiceDesc1 = {
    Text = "选择一张卡牌领悟「欢愉之理」刻印。「欢愉之理」：打出后弃掉所有该唤醒体以外的卡牌，获得 5 张随机非唤醒体卡牌，每场战斗仅生效 1 次。"
  },
  Event_59528_Desc = {
    Text = "象征欢愉的标记刻印在你的证件上。\n透过印记，N正在打量你。祂期待着，你为祂带来不曾妄言过的结局。"
  },
  Event_59528_Name = {
    Text = "入学仪式"
  },
  Event_59529_ChoiceDesc1 = {
    Text = "选择一张卡牌领悟「繁育之理」刻印。「繁育之理」：打出后获得 3 张附加「保留」和「消耗」的原始复制，每场战斗仅生效 1 次。"
  },
  Event_59529_Desc = {
    Text = "象征繁育的标记刻印在你的证件上。\n泰旖丝将祂的希望寄托于你，祂将与你在一切世界中共生。"
  },
  Event_59529_Name = {
    Text = "入学仪式"
  },
  Event_59566_ChoiceDesc1 = {
    Text = "【擦拭血泪】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59566_ChoiceDesc2 = {
    Text = "【坚持睁眼】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59566_Desc = {
    Text = "无数个你的愿望融为一体，曾经你们共同拥有同一个来处，现在你们共同拥有同一副身体。\n无数只眼一起睁开，要去直面那巨大的眼瞳。\n无数只眼一起破碎，流下痛苦而干涸的血泪。"
  },
  Event_59566_Name = {
    Text = "我的融合"
  },
  Event_59567_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59567_Desc = {
    Text = "你试图与那疯狂的声音争辩，辩驳那虚无的理念。\n“万物都会走向死亡，难道生命本身就毫无意义吗？”\n你据理力争，然而那笑声丝毫不减，仿佛在嘲笑你的愚蠢。"
  },
  Event_59567_Name = {
    Text = "待死的羔羊"
  },
  Event_59568_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59568_Desc = {
    Text = "你注视着那扇门，不想再忍受无知的痛苦。\n你想要看到门后的景象。\n虚幻的门扉迷幻地摇曳着，你看到无数世界的虚影一闪而过。\n来不及看清，无穷的信息冲垮了你的精神，你的大脑充满了混乱的噪点。"
  },
  Event_59568_Name = {
    Text = "门扉之后"
  },
  Event_59569_ChoiceDesc1 = {
    Text = "【坚定指挥】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_59569_ChoiceDesc2 = {
    Text = "【共同商谈】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59569_Desc = {
    Text = "一切发生得如此突然，你感到周围笼罩着一片朦胧的烟雾，你努力四处眺望，却什么都看不清。\n唤醒体们等待着你的指令。\n现在你孤立无援，只能依靠自己的力量。"
  },
  Event_59569_Name = {
    Text = "无知之目"
  },
  Event_59570_ChoiceDesc1 = {
    Text = "【以牺牲】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59570_ChoiceDesc2 = {
    Text = "【以勇敢】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59570_ChoiceDesc3 = {
    Text = "【以直视】获得50黑印"
  },
  Event_59570_Desc = {
    Text = "无数个你站在无数的世界中，肩并着肩、手牵着手，仿佛亲如一体的兄弟姐妹。\n现在你们共同站在那片巨大的阴影下，抬起头颅，不后退半步。\n要怎样做？\n要怎样做才能打败那个最终的你？"
  },
  Event_59570_Name = {
    Text = "我的自答"
  },
  Event_59571_ChoiceDesc1 = {
    Text = "【寻找答案】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_59571_ChoiceDesc2 = {
    Text = "【放弃】获得25黑印，离开"
  },
  Event_59571_Desc = {
    Text = "经过门扉的幻影，无数个你经历的一切闪回在你的脑海。\n他们有的死亡、有的疯狂、有的坚持、有的堕落。\n无数条道路、无数种选择在你面前闪回，你仿佛一瞬间活过了漫长无尽的一生。\n现在无数个头脑、无数张嘴同时运转。\n你试图跨越时空与无数个自己对话，从无尽的记忆中打捞答案。"
  },
  Event_59571_Name = {
    Text = "我的自问"
  },
  Event_59572_ChoiceDesc1 = {
    Text = "【交换力量】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59572_ChoiceDesc2 = {
    Text = "【交换幸运】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_59572_Desc = {
    Text = "一切选择皆有代价。\n生命、精神、情感、记忆……\n你想向命运交换什么，又选择将什么放上天平？"
  },
  Event_59572_Name = {
    Text = "命运抉择"
  },
  Event_59573_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59573_Desc = {
    Text = "人怎么可以没有心脏呢？\n你慌乱地四处找寻，你的呼吸渐渐急促，死亡的恐惧笼罩在你的大脑。\n“喘不上气了……心跳要停止了……”\n等等，你好像已经不再需要心跳了。\n你恍然大悟，开心地笑了起来。"
  },
  Event_59573_Name = {
    Text = "胸口空洞"
  },
  Event_59574_ChoiceDesc1 = {
    Text = "【直视】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59574_ChoiceDesc2 = {
    Text = "【逃避】 随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_59574_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_59574_Desc = {
    Text = "你感到虚空中有某种存在注视着你。\n无论你走到哪里，那目光都如影随形。\n你觉得自己像是被盯上的渺小猎物，你的后背开始针刺一样疼痛起来。"
  },
  Event_59574_Name = {
    Text = "祂的目光"
  },
  Event_59575_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59575_Desc = {
    Text = "你在狂乱的演奏中不为所动，始终默默坚持自己的步调。\n对方的攻击与引诱对你无效，钢琴上同时弹奏着两种曲调，谁坚持到最后，谁就能驾驭全部音符。"
  },
  Event_59575_Name = {
    Text = "末日狂欢曲"
  },
  Event_59576_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59576_Desc = {
    Text = "你拿出所有勇气，无论要面对什么，你都会和并肩作战的伙伴们走下去。"
  },
  Event_59576_Name = {
    Text = "未来定格"
  },
  Event_59577_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59577_Desc = {
    Text = "“你现在在哪里？”\n“老师们有什么打算？”\n“我接下来该怎么做？”\n你急迫地追问着，想要像往常一样依赖那个可靠的存在。\n联络器如同卡顿般失去了反应，你摇晃着机器，晃动中回信上的字迹扭曲变作了一群蝴蝶，哗啦啦扑在了你的脸上。\n你揉了揉眼睛，发现一切不过是你的幻觉。\n回信的纸张上空无一字。"
  },
  Event_59577_Name = {
    Text = "迷幻的回音"
  },
  Event_59578_ChoiceDesc1 = {
    Text = "【慌张寻找】提升 Arg1 点最大生命"
  },
  Event_59578_ChoiceDesc2 = {
    Text = "【尝试填充】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59578_Desc = {
    Text = "你感到胸腔内部变得空虚而轻盈，你低头看去，胸口洞开成了锁孔的形状。\n你的心脏不翼而飞。"
  },
  Event_59578_Name = {
    Text = "胸口空洞"
  },
  Event_59579_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59579_Desc = {
    Text = "你大声质问着他的目的，然而只收获了丝毫未变的笑容。\n\n他早已背离了世界，无牵无挂的人不需要对任何事负责。\n你只能徒劳地反抗。"
  },
  Event_59579_Name = {
    Text = "疯狂的绅士"
  },
  Event_59580_ChoiceDesc1 = {
    Text = "【打乱节奏】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59580_ChoiceDesc2 = {
    Text = "【保持自我】获得3选1刻印"
  },
  Event_59580_Desc = {
    Text = "你仿佛与一个癫狂的人一同演奏，她将你绑架在琴键上，将你裹挟进她疯狂的曲目。\n你在她的节奏中艰难弹奏，踉踉跄跄。\n你费力与她博弈，试图把控曲调的旋律。"
  },
  Event_59580_Name = {
    Text = "末日狂欢曲"
  },
  Event_59581_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59581_Desc = {
    Text = "你希望自己拥有无可匹敌的力量，能够打碎一切枷锁与障碍。\n然而人力有穷，以渺小之躯挑战神明，终将会如火柴般燃尽自己的生命。"
  },
  Event_59581_Name = {
    Text = "命运抉择"
  },
  Event_59582_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59582_Desc = {
    Text = "“没了……没了……”\n空虚的感觉很不好受，你拿起了怀表、苹果和校服外套，试图填满胸口的空洞。\n你的胸腔重新变得满满当当，只不过你有种过于饱腹的错觉。\n没关系，事情总是不会很完美。"
  },
  Event_59582_Name = {
    Text = "胸口空洞"
  },
  Event_59583_ChoiceDesc1 = {
    Text = "【说服】获得25黑印"
  },
  Event_59583_ChoiceDesc2 = {
    Text = "【质问】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59583_Desc = {
    Text = "N的皮鞋停在你面前，你看到那张漆黑的面孔上夸张的笑容。\n他惯常穿着体面，但你知道那绅士的外表之下只有最纯粹的疯狂。\n他没有朋友，也鲜有敌人。\n因为那些人都会以最戏剧的方式彻底消失。\n\n很不幸，现在你被他选为了戏剧的下一个主角。\n请准备你的开场白吧，要如何才能让这最挑剔的观众满意？"
  },
  Event_59583_Name = {
    Text = "疯狂的绅士"
  },
  Event_59584_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59584_Desc = {
    Text = "唤醒体们并不比你多了解什么，但他们早已是你最忠诚的伙伴、战友与后盾。\n你与唤醒体们商讨对策，尽管你们内心依然彷徨，但已经拥有了重新出发的勇气。"
  },
  Event_59584_Name = {
    Text = "无知之目"
  },
  Event_59585_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59585_Desc = {
    Text = "仿佛为自己下定决心一般，你坚定地大声应答。\n你的声音回荡在无数的泡泡之间，仿佛有无数个你一起宣誓。\n你已经准备好面对一切。"
  },
  Event_59585_Name = {
    Text = "祂的质问"
  },
  Event_59586_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59586_Desc = {
    Text = "你没有动弹，只是紧盯着回信上的字迹。\n在你的注视下，那些字句逐渐模糊扭曲，最终变作了一群蝴蝶哗啦啦扑飞到你的脸上。\n你挥舞双手驱赶蝴蝶，转头回看时回信的纸张上已经空无一字。\n果然，过于美好的美梦都是虚假的。"
  },
  Event_59586_Name = {
    Text = "迷幻的回音"
  },
  Event_59587_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59587_Desc = {
    Text = "你憎恨着这些卑鄙的丝线。\n你狠狠扯向它们，有的线崩断，无数的线又重新缠来。\n你用尽所有力量，与它们不断对抗。"
  },
  Event_59587_Name = {
    Text = "被操纵的双手"
  },
  Event_59588_ChoiceDesc1 = {
    Text = "【斩杀人影】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59588_ChoiceDesc2 = {
    Text = "【碾碎胚胎】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59588_ChoiceDesc3 = {
    Text = "【闭上双眼】获得25黑印"
  },
  Event_59588_Desc = {
    Text = "恍惚中你看到曾在亚兰见过的人们向你靠近。\n他们欢笑着邀请你饮酒、跳舞、品尝美食。\n然后他们的血肉层层剥落，掉落在地又蠕动着长出新的胚胎。\n他们向你伸出手，邀请你加入血肉与新生的狂欢。"
  },
  Event_59588_Name = {
    Text = "旧日的阴影"
  },
  Event_59589_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59589_Desc = {
    Text = "在伸出手前，你忽然想起，你并没有养过这样一只猫。\n你与猫隔着空气对视，猫对你眨了眨眼。\n猫并不在意你的冷漠，它看起来还是一样爱你。"
  },
  Event_59589_Name = {
    Text = "猫的诱惑"
  },
  Event_59590_ChoiceDesc1 = {
    Text = "【镶嵌】选择1个造物变化为诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_59590_ChoiceDesc2 = {
    Text = "【吞下】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59590_ChoiceDesc3 = {
    Text = "【收起】获得25黑印"
  },
  Event_59590_Desc = {
    Text = "体内三大质体的力量正在交融，你艰难地驾驭着这股庞大的力量。\n精神空间不断膨胀，一条银河在此诞生、扩散。\n面对源源不断的敌人，你由衷地向这片星空祈祷，许愿这力量的帮助。\n一颗星星从银河中坠落到你的手心，散发着诱人的光芒。"
  },
  Event_59590_Name = {Text = "许愿星"},
  Event_59591_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59591_Desc = {
    Text = "你也以沉默相对，你们没有交流，沉默是一切的答案。\n你已经准备好面对一切。"
  },
  Event_59591_Name = {
    Text = "祂的质问"
  },
  Event_59592_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59592_Desc = {
    Text = "那只猫是个骗子吗？\n你开始怀疑那双池水一样的蓝眼睛，耳畔的笑声不停回荡。\n“骗子，骗子，你被骗了！”\n你内心涌出一股担忧。"
  },
  Event_59592_Name = {
    Text = "秘密呢喃"
  },
  Event_59593_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59593_Desc = {
    Text = "你仿佛一个旁观者，默默观看着渐渐陌生的情绪。\n你克制了一切留恋的欲望，感受着自己的灵魂逐渐变得冰冷。\n这是你的命运，这是你的必经之路。"
  },
  Event_59593_Name = {
    Text = "情感结晶"
  },
  Event_59594_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59594_Desc = {
    Text = "那张笑脸无动于衷，你无法用理性或感性的沟通打动他。\n人类的一切欲求与他无关。\n你的话语能超越人类的想象吗？"
  },
  Event_59594_Name = {
    Text = "疯狂的绅士"
  },
  Event_59595_ChoiceDesc1 = {
    Text = "【应答】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59595_ChoiceDesc2 = {
    Text = "【沉默】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_59595_Desc = {
    Text = "无数的泡泡好像无数只圆圆的眼睛，祂沉默地看着你，仿佛无声的质问。\n你准备好了吗？\n准备好放弃一切了吗？\n准备好承担一切了吗？"
  },
  Event_59595_Name = {
    Text = "祂的质问"
  },
  Event_59596_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59596_Desc = {
    Text = "在对方发动攻击的刹那，你立刻展开了回击。\n你明智地辨明了他们真正的面目，这本就是一群亮出獠牙的野兽。\n你幸运地胜利了。\n现在努力逃亡吧，千万不要被他们抓到。"
  },
  Event_59596_Name = {
    Text = "沉入深渊"
  },
  Event_59597_ChoiceDesc1 = {
    Text = "【寻找答案】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_59597_ChoiceDesc2 = {
    Text = "【放弃】离开"
  },
  Event_59597_Desc = {
    Text = "你该怎么办？\n你看向无数个自己，无数张与你相同的面孔注视着你，他们的嘴一张一合。\n仿佛抓住了希望的稻草，你努力搜寻着、聆听着，期许能获得最终的答案。"
  },
  Event_59597_Name = {
    Text = "我的自问"
  },
  Event_59598_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59598_Desc = {
    Text = "时机未到，你需要隐忍等候。\n你咽下不甘与仇恨，等待着孤注一掷的那一刻。"
  },
  Event_59598_Name = {
    Text = "被操纵的双手"
  },
  Event_59599_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59599_Desc = {
    Text = "你感到某种冥冥中的吸引，你想要看清那些目光的源头。\n你痴迷地望向虚空，感到自己仿佛看到了什么。\n视线一瞬间被雪花般的模糊覆盖，眼中的世界好像有什么地方变得不同。\n你揉了揉眼睛，发现眼角流出两行血泪。"
  },
  Event_59599_Name = {
    Text = "祂的目光"
  },
  Event_59600_ChoiceDesc1 = {
    Text = "【努力回想】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59600_ChoiceDesc2 = {
    Text = "【品味悲伤】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59600_ChoiceDesc3 = {
    Text = "【默默接受】获得25黑印"
  },
  Event_59600_Desc = {
    Text = "如同经历了最精密的脑部手术，你清晰地感觉到一段段珍藏的记忆正在从你的脑海中抽离，你的大脑变得一片模糊，仿佛快要融化。\n你痛苦地颤抖着，按住自己想要阻止的手。\n晶莹的眼泪从眼眶流下，可是，它们是为什么而流的呢？\n你好像有些想不起来了。\n你莫名感到十分悲伤。"
  },
  Event_59600_Name = {
    Text = "记忆解离"
  },
  Event_59601_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59601_Desc = {
    Text = "你与猫的情谊不容置疑，挥了挥手，你头也不回地继续前进。\n“蠢货！蠢货！”\n耳畔的声音气急败坏。"
  },
  Event_59601_Name = {
    Text = "秘密呢喃"
  },
  Event_59602_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59602_Desc = {
    Text = "你下定决心，无论付出怎样的代价，你都要带着大家的希望战斗到最后一刻。"
  },
  Event_59602_Name = {
    Text = "未来定格"
  },
  Event_59603_ChoiceDesc1 = {
    Text = "【克制】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_59603_ChoiceDesc2 = {
    Text = "【注视】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59603_Desc = {
    Text = "塔薇守护的大门后是无尽的世界与无尽的真理。\n你不知道她在门后看到了什么，但你知道她知晓一切。\n现在这扇门在你面前洞开，所有的真相在门扉之后发出无声的邀请。"
  },
  Event_59603_Name = {
    Text = "门扉之后"
  },
  Event_59604_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59604_Desc = {
    Text = "对于未知的存在应心怀敬意，避其锋芒是谨慎的选择。\n你低下头，握紧了胸口的银钥匙，感到稍稍安慰。\n至少你还有力量，还有唤醒体们。\n你努力忽视那些目光，专注于眼前的路。\n但那些目光真的消失了吗？你心知肚明。"
  },
  Event_59604_Name = {
    Text = "祂的目光"
  },
  Event_59605_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59605_Desc = {
    Text = "如果一切对抗神明的手段都是蚍蜉撼树，你唯一能够坚持的只有不放弃的勇气。\n当无尽的毁灭从天穹压来，你会成为顶在最前面的那个。"
  },
  Event_59605_Name = {
    Text = "我的自答"
  },
  Event_59606_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59606_Desc = {
    Text = "你怔愣地触摸着不断流下的泪滴，仔细回味着那股不知来处的悲伤。\n好像有许多非常珍贵的东西被你亲手丢掉了，但你已经想不起那是什么。\n真是遗憾啊。\n你无力地擦拭着泪水，在眼泪中露出一个苦涩的微笑。"
  },
  Event_59606_Name = {
    Text = "记忆解离"
  },
  Event_59607_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59607_Desc = {
    Text = "你无视了他们的声音。\n你不在乎猫是否是骗子，你只相信自己的力量。\n耳畔的声音叹息起来。"
  },
  Event_59607_Name = {
    Text = "秘密呢喃"
  },
  Event_59608_ChoiceDesc1 = {
    Text = "【寻找答案】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_59608_ChoiceDesc2 = {
    Text = "【放弃】离开"
  },
  Event_59608_Desc = {
    Text = "有人癫狂大笑。\n那个自己认定一切都是无用的挣扎，不如尽早放弃。\n你皱起眉头，那个自己忽然微笑转身，TA说不如亲手结束众人的生命，好过让人们经历痛苦。\n你挥手驱离了那阵声音，坚定着自己的信念。"
  },
  Event_59608_Name = {
    Text = "我的自问"
  },
  Event_59609_ChoiceDesc1 = {
    Text = "【追问】删除2张卡牌"
  },
  Event_59609_ChoiceDesc2 = {
    Text = "【戳破】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59609_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_59609_Desc = {
    Text = "漫长的等待中，你再一次打开了联络器，或许是你的思念与祈祷有了作用，你看见回信的纸张上不断涌出她熟悉而亲切的回应。\n她现在非常安全，师长们早有安排，弥萨格的运转一切顺利……\n你看着雪花一样飞来的好消息，心中忍不住一动。"
  },
  Event_59609_Name = {
    Text = "迷幻的回音"
  },
  Event_59610_ChoiceDesc1 = {
    Text = "【捕捉星星】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_59610_ChoiceDesc2 = {
    Text = "【捏碎星星】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_59610_ChoiceDesc3 = {
    Text = "【沉默观看】获得25黑印"
  },
  Event_59610_Desc = {
    Text = "你的情绪随着记忆一同被剥离，你感到自己正在成为某种庞大的存在，像是怪物回到了它远古的、温暖的巢穴。\n无数的喜怒哀乐浓缩，化为一颗颗闪亮的星星，在你的精神维度下起了光亮的雨。\n你生存过的痕迹化为流星消逝。\n你静默地注视着，拾起一颗面前的星星，那里面传来你开怀的笑声。\n于是你也一起笑了，你甘之如饴。"
  },
  Event_59610_Name = {
    Text = "情感结晶"
  },
  Event_59611_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59611_Desc = {
    Text = "你知道这些不过是过去的残影，你面无表情地屠杀着曾经与你畅谈的人们。\n他们的笑与泪在你的手中破碎，你不能有丝毫停顿。\n如果这是必要的考验，你会充当最无情刽子手。"
  },
  Event_59611_Name = {
    Text = "旧日的阴影"
  },
  Event_59612_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59612_Desc = {
    Text = "它柔软的毛皮与清澈的双眼天然让你感到信任。\n你走近猫，猫也走近了你。\n你们互相没有言语，但它的尾巴高高竖起。"
  },
  Event_59612_Name = {
    Text = "猫的诱惑"
  },
  Event_59613_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59613_Desc = {
    Text = "你克制住了好奇的冲动，你知道这扇门不应该开启。\n太多的真实有时是一种诅咒。\n你握紧了胸口的银钥匙，决心将这扇门永远关上。"
  },
  Event_59613_Name = {
    Text = "门扉之后"
  },
  Event_59614_ChoiceDesc1 = {
    Text = "【勇气】随机升级2张卡牌的刻印效果"
  },
  Event_59614_ChoiceDesc2 = {
    Text = "【决心】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59614_Desc = {
    Text = "塔薇的话语回荡在你的脑海。\n无数结局中唯有一条是正确的道路。\n恍惚中你看到许多世界的虚影在你眼前如同胶卷的片段般闪过，等待着按下按钮定格的那一刻。\n这一秒过后，世界究竟会迎来怎样的结局？"
  },
  Event_59614_Name = {
    Text = "未来定格"
  },
  Event_59615_ChoiceDesc1 = {
    Text = "【忽视怀疑】获得50黑印"
  },
  Event_59615_ChoiceDesc2 = {
    Text = "【独断专行】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_59615_Desc = {
    Text = "随着N的嘲笑，你开始怀疑起见过的所有人。\n到底哪些是他的化身，哪些是你真心的师友？\n他的影子不停变幻，那其中好像有无数面孔，正冲着你咧开嘴角。"
  },
  Event_59615_Name = {
    Text = "影子的一百张面孔"
  },
  Event_59616_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59616_Desc = {
    Text = "如果所有人都有可能背叛，那么就不要依赖任何人。\n在黑暗之中，你只能确认唯一的真实。\n起码你还有自己——最忠诚的自己可以信任。"
  },
  Event_59616_Name = {
    Text = "影子的一百张面孔"
  },
  Event_59617_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59617_Desc = {
    Text = "你用力一捏，闪耀的晶石在你的指尖破碎成粉末。\n你贪婪地吸入那些来自过去的情绪。\n一瞬之间浓郁的快乐冲入你的大脑，而后幻觉一般缓缓消散。\n你的嘴角随之高高翘起，而后慢慢落下。\n你的面庞逐渐平静无波。"
  },
  Event_59617_Name = {
    Text = "情感结晶"
  },
  Event_59618_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59618_Desc = {
    Text = "你知道一切都有代价，如果拯救的代价注定是牺牲，那么就让这份代价全部由自己支付。\n你准备好了随时付出全部。"
  },
  Event_59618_Name = {
    Text = "我的自答"
  },
  Event_59619_ChoiceDesc1 = {
    Text = "【寻找答案】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_59619_ChoiceDesc2 = {
    Text = "【放弃】离开"
  },
  Event_59619_Desc = {
    Text = "有人在呐喊。\n那个自己急切地想要逃跑，TA说对抗注定着失败。\n只有永无止境的逃亡才能够延缓最终的湮灭。\n你将信将疑。"
  },
  Event_59619_Name = {
    Text = "我的自问"
  },
  Event_59620_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59620_Desc = {
    Text = "你知道那些胚胎繁殖速度的可怖，新生在这里是蝗虫一般的诅咒。\n你在那些新生儿发出啼哭前就将它们碾碎。\n血肉组成的人们怨毒地看着你，质问你为何亵渎神圣的生命。\n你以无尽的杀戮回应。"
  },
  Event_59620_Name = {
    Text = "旧日的阴影"
  },
  Event_59621_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59621_Desc = {
    Text = "此时此刻你希望自己会是最幸运的人，能够得到最圆满的结局。\n但好运的代价有时更加残酷，幸运与不幸往往相伴而生，当你得到的那一刻，别忘了检查失去了什么。"
  },
  Event_59621_Name = {
    Text = "命运抉择"
  },
  Event_59622_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59622_Desc = {
    Text = "你仿佛在与人争抢同一辆汽车的方向盘，你的双手全力飞舞，试图掌控乐曲的节奏。\n在艰难的对抗中，你突然重重地按下一排琴键。\n狂乱的弹奏被你打乱，你咧开嘴角，陷入疯狂与更加疯狂的对抗。"
  },
  Event_59622_Name = {
    Text = "末日狂欢曲"
  },
  Event_59623_ChoiceDesc1 = {
    Text = "【亲近】获得25黑印"
  },
  Event_59623_ChoiceDesc2 = {
    Text = "【注视】50%机会获得50黑印，50%机会一无所有"
  },
  Event_59623_Desc = {
    Text = "你身旁跟着一只猫，它的毛发顺滑洁净，它的前爪是踏雪一样的白色。\n猫始终陪伴在你左右，亦步亦趋，像是你最忠诚的仆人。\n你心中一切迷茫与无助、痛苦与不安都被抚平了。"
  },
  Event_59623_Name = {
    Text = "猫的诱惑"
  },
  Event_59624_ChoiceDesc1 = {
    Text = "【否定】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_59624_ChoiceDesc2 = {
    Text = "【辩驳】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_59624_ChoiceDesc3 = {
    Text = "【沉默】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_59624_Desc = {
    Text = "你陷入某种虚无的幻境。\n你看到无数的人们在末日的阴影下沉默，渺小如灰尘。\n他们呆滞，灰暗，失去希望。\n你听到某人尖锐的笑声。\n“看吧，这就是你们坚持的结果。”\n“世界从来就没有结局，一切的一切都没有意义。”"
  },
  Event_59624_Name = {
    Text = "待死的羔羊"
  },
  Event_59625_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59625_Desc = {
    Text = "不，这不对，这不是真实的。\n你不停否定着那疯狂的声音，然而灰暗的人影无动于衷，仿佛印证着虚无的结局。\n那笑声越来越大，嘲讽着你的无力。"
  },
  Event_59625_Name = {
    Text = "待死的羔羊"
  },
  Event_59626_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59626_Desc = {
    Text = "你感到一股巨大的遗憾和不舍，你下意识拼命回想着，试图在记忆的碎片中寻找过去的影子。\n那些模糊的倒影飞速向后退去，你努力想要伸手抓住，却只能看到那些影像从指间流逝。\n你意识到，你即将一无所有。"
  },
  Event_59626_Name = {
    Text = "记忆解离"
  },
  Event_59627_ChoiceDesc1 = {
    Text = "【亲近】获得25黑印"
  },
  Event_59627_ChoiceDesc2 = {
    Text = "【注视】50%机会获得50黑印，50%机会一无所有"
  },
  Event_59627_Desc = {
    Text = "你身旁跟着一只猫，它的毛发顺滑洁净，它的前爪是踏雪一样的白色。\n猫始终陪伴在你左右，亦步亦趋，像是你最忠诚的仆人。\n你心中一切迷茫与无助、痛苦与不安都被抚平了。"
  },
  Event_59627_Name = {
    Text = "猫的诱惑"
  },
  Event_59628_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59628_Desc = {
    Text = "你与最终的你在此相见，毁灭整个世界的战斗其实只是你们目光的对视。\n当祂看向你，你必须坚定地直视祂，直到其中一道目光消失的那刻。"
  },
  Event_59628_Name = {
    Text = "我的自答"
  },
  Event_59629_ChoiceDesc1 = {
    Text = "【呼吸】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59629_ChoiceDesc2 = {
    Text = "【反击】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_59629_ChoiceDesc3 = {
    Text = "【挣扎】获得25黑印"
  },
  Event_59629_Desc = {
    Text = "密集的脚步声响起，一群审查会的探员拦住了你的去路。\n“请配合我们的调查。”\n冷漠的声音隐含恶意。\n扑通一声，平静的水面被打破，他们将你投入深潭。"
  },
  Event_59629_Name = {
    Text = "沉入深渊"
  },
  Event_59630_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59630_Desc = {
    Text = "你拼命挣扎。\n向前，再向前一点。\n无论要付出什么代价，你一定要守护这一切。\n你努力伸出手，丝线切入你的皮肉，你浑然不觉。"
  },
  Event_59630_Name = {
    Text = "被操纵的双手"
  },
  Event_59631_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59631_Desc = {
    Text = "你用力摇晃脑袋，将纷乱的记忆从大脑里甩出。\n很快嘈杂的声音逐渐消失，你的意识终于恢复了独立。\n你无法从失败的过去中获得帮助，只有专注当下才能找到希望。"
  },
  Event_59631_Name = {
    Text = "我的自问"
  },
  Event_59632_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_59632_Desc = {
    Text = "在伸出手前，你忽然想起，你并没有养过这样一只猫。\n你与猫隔着空气对视，猫对你眨了眨眼。\n猫并不在意你的冷漠，它看起来还是一样爱你。"
  },
  Event_59632_Name = {
    Text = "猫的诱惑"
  },
  Event_59633_ChoiceDesc1 = {
    Text = "【寻找答案】获得Arg1黑印，感染「(Skill.Arg2)」"
  },
  Event_59633_ChoiceDesc2 = {
    Text = "【放弃】离开"
  },
  Event_59633_Desc = {
    Text = "有人悲伤流泪。\n那个自己满目悲怆，想要拥抱最爱的人。\n毁灭之时没能和在乎的人们在一起是TA最大的遗憾。\n你心头一痛，忍不住一起悲伤起来。"
  },
  Event_59633_Name = {
    Text = "我的自问"
  },
  Event_59634_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59634_Desc = {
    Text = "你望着无数灰色的人影，对那嘲讽的笑声置之不理。\n要怎么才能拯救崩塌的世界？\n你在沉默的灭亡中不停思考。"
  },
  Event_59634_Name = {
    Text = "待死的羔羊"
  },
  Event_59635_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59635_Desc = {
    Text = "肺泡中的空气逐渐消失，你尝试在水下呼吸。\n多么愚蠢的行为，但你成功了。\n你的肺泡重新充盈，你可以畅快地吐息。\n但你不断吸入的到底什么呢？"
  },
  Event_59635_Name = {
    Text = "沉入深渊"
  },
  Event_59636_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59636_Desc = {
    Text = "你沉入了黏稠的液体。\n尽管你极力挣动，却只是越陷越深。\n你无法独自逃离这片泥沼。"
  },
  Event_59636_Name = {
    Text = "沉入深渊"
  },
  Event_59637_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59637_Desc = {
    Text = "你强迫自己遗忘掉这些怀疑。\n你知道此刻怀疑是最没有用处的，你只能尽量相信。\n在密封的盒子揭开之前，你无从得知盒子内的真相。\n有些时候，做一个糊涂的傻子更容易获得安宁。"
  },
  Event_59637_Name = {
    Text = "影子的一百张面孔"
  },
  Event_59638_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59638_Desc = {
    Text = "大家的目光聚集在你身上，你必须作为所有人的领袖，不能流露出任何脆弱。\n“前往黑池，一切都会好起来的。”\n你镇定地发出指令，许下自己也未必相信的诺言。"
  },
  Event_59638_Name = {
    Text = "无知之目"
  },
  Event_59639_ChoiceDesc1 = {
    Text = "【怀疑】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_59639_ChoiceDesc2 = {
    Text = "【不屑】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_59639_ChoiceDesc3 = {
    Text = "【无视】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_59639_Desc = {
    Text = "面前有三个彷徨的人影，他们口中絮絮呢喃着什么。\n你将耳朵凑近去听，吐字的声音与气息一同变得清晰。\n“不要相信那只猫，它是个骗子。”\n你猛地回过头，却发现身旁空无一人。"
  },
  Event_59639_Name = {
    Text = "秘密呢喃"
  },
  Event_59640_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59640_Desc = {
    Text = "星星看起来是如此可口，你觊觎它的力量，将它一口吞下。\n咕咚。\n你感到精神前所未有的充盈，有种光芒在你的余光里闪耀。\n低头看去，星星仍在你的胃袋中发光。"
  },
  Event_59640_Name = {Text = "许愿星"},
  Event_59641_ChoiceDesc1 = {
    Text = "【挣扎向前】删除1张指令卡，获得Arg1黑印"
  },
  Event_59641_ChoiceDesc2 = {
    Text = "【扯断丝线】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_59641_ChoiceDesc3 = {
    Text = "【隐忍不发】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_59641_Desc = {
    Text = "一路上你被推着前进，你的所有选择都被无形的丝线操纵着。\n你努力挣动双手，想要抓住在意的一切。\n世界的命运悬挂在你指尖之前。\n无数丝线缠绕而来，束缚住你的全身。"
  },
  Event_59641_Name = {
    Text = "被操纵的双手"
  },
  Event_59642_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59642_Desc = {
    Text = "你擦掉眼角的血泪，无数的血泪又不断流下。\n红色弥漫你的视野，仿佛预示着血腥的牺牲。\n你不断擦拭着，痛苦使你颤抖，但不能使你有一丝畏惧。"
  },
  Event_59642_Name = {
    Text = "我的融合"
  },
  Event_59643_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59643_Desc = {
    Text = "你摩挲着这块神奇的宝石，将它镶嵌到了银钥匙上。\n星星的光芒照耀着你。\n你目眩神迷。"
  },
  Event_59643_Name = {Text = "许愿星"},
  Event_59644_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59644_Desc = {
    Text = "你不管不顾，始终睁着眼，心中的坚持化为倔强的怒吼。\n哪怕会破碎消散，你也不会退缩半步。"
  },
  Event_59644_Name = {
    Text = "我的融合"
  },
  Event_59645_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59645_Desc = {
    Text = "有人沉默不语。\n看着那个自己绝望沉默的面孔，你知道他们都没有走到最后。\n你是所有自己中走得最远的一个，只有你自己的答案才是最后的希望。"
  },
  Event_59645_Name = {
    Text = "我的自问"
  },
  Event_59646_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59646_Desc = {
    Text = "你伸出手，从无数颗流星中不断抓握着，闪耀的晶石划过你的指尖。\n快乐、悲伤、愤怒、恐惧……\n你贪婪地攫取着每一缕情绪，又眼睁睁看着它们从你的手中消失。\n绚丽的光芒照耀着你的脸，你的眼瞳逐渐变得漆黑而幽深。"
  },
  Event_59646_Name = {
    Text = "情感结晶"
  },
  Event_59657_ChoiceDesc1 = {
    Text = "【呼唤】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_59657_ChoiceDesc2 = {
    Text = "【触碰】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_59657_Desc = {
    Text = "你目睹人偶陷入崩溃。\n她曾是最理性的存在，也是最忠诚的助手，认真保管你们获得的一切信息。\n而现在她似乎已不再记得你们相处的所有。\n你看到人偶的眼角滴落晶莹的液体。"
  },
  Event_59657_Name = {
    Text = "人偶的眼泪"
  },
  Event_59658_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59658_Desc = {
    Text = "你没有死心，试图接触她的能源核心。\n只要是机械，重新启动一定能修好的吧。\n可惜无情的人偶并没有给你天真的机会。\n你的留手并没有换来人偶的手下留情，你只好全力战斗。"
  },
  Event_59658_Name = {
    Text = "人偶的眼泪"
  },
  Event_59659_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_59659_Desc = {
    Text = "你并不想损毁曾经的伙伴。\n你拼命呼唤她的名字，报出所有的指令，然而毫无作用。\n人偶背叛了你们，回归了无机物的冰冷。"
  },
  Event_59659_Name = {
    Text = "人偶的眼泪"
  },
  Event_60944_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60944_Desc = {
    Text = "留给你的时间不多，你选择了最为直接的处理方式，闯过了封锁。唤醒体们受到激励，也变得兴奋起来。\n至于变得更加警觉的敌人，不足为虑。"
  },
  Event_60944_Name = {
    Text = "审查会探员"
  },
  Event_60945_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60945_Desc = {
    Text = "在那名探员反应过来之前，你们绕到他的背后，收缴了他的武器。在增援赶到之前，你们成功离开了这里。\n遗憾的是消息已经传开，后面的敌人有了准备，或许会变得更加难以应对。做好准备。"
  },
  Event_60945_Name = {
    Text = "审查会探员"
  },
  Event_60946_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60946_Desc = {
    Text = "探员被一阵口哨声吸引，向你们的藏身之处走来。在他靠近的一瞬间，等待已久的唤醒体们一起发起了攻击。\n一次完美的伏击，这里的危机被永远地解决了。"
  },
  Event_60946_Name = {
    Text = "审查会探员"
  },
  Event_60947_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60947_Desc = {
    Text = "面对人数众多的敌人，你无法与他们抗衡。你主动走入他们的视野中，并没有进行抵抗。\n你知道，你们即将被送往羁押点，这正是计划的一环。\n你们将从那里逃离，寻找新的路径。"
  },
  Event_60947_Name = {Text = "监察点"},
  Event_60948_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60948_Desc = {
    Text = "面对人数众多的敌人，你无法与他们抗衡。短暂地战斗后，你们放弃了抵抗。\n你知道，你们即将被送往羁押点，这正是计划的一环。\n你们将从那里逃离，寻找新的路径。"
  },
  Event_60948_Name = {Text = "监察点"},
  Event_60949_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_60949_Desc = {
    Text = "面对人数众多的敌人，你无法与他们抗衡。\n你选择暂时离开这里，寻找新的路径。"
  },
  Event_60949_Name = {Text = "监察点"},
  Event_61058_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61058_Desc = {
    Text = "你注视着自己的双手，自己的全身，心中充满了希望与决心。\n如果这所有都是命运的安排，你已经准备好面对一切。\n在最终的时刻若真有通往天堂或地狱的大门，那么就由你来为世界亲手开启门扉。"
  },
  Event_61058_Name = {Text = "窥视"},
  Event_61059_ChoiceDesc1 = {
    Text = "【准备迎战】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61059_ChoiceDesc2 = {
    Text = "【继续观察】感染「(Skill.Arg1)」，重新刻印，最多进行1次"
  },
  Event_61059_Desc = {
    Text = "你没有急于迎战，冷静地尝试理清现状。 这个突然出现的指挥家似敌似友，你并不清楚他准备做什么。 无论如何，你决定做好充分准备，先迎接他的挑战，再慢慢观察他到底想要做些什么。"
  },
  Event_61059_Name = {
    Text = "魔鬼指挥家"
  },
  Event_61060_ChoiceDesc1 = {
    Text = "【聆听】获得3选1高级刻印"
  },
  Event_61060_ChoiceDesc2 = {
    Text = "【呼喊】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61060_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_61060_Desc = {
    Text = "自从意外发生后，你再也没有收到搭档的消息。\n无数联络发出，如同石沉大海毫无回音。\n在你已经不抱希望的时刻，联络器突然发出了声响。\n你打开手提箱，将电话听筒靠近耳朵。\n“守密人……”\n恍惚中你听到了那个一直思念的声音，像是隔着层层虚空遥远地回响。"
  },
  Event_61060_Name = {
    Text = "思念的回音"
  },
  Event_61061_ChoiceDesc1 = {
    Text = "【接纳黑暗】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61061_ChoiceDesc2 = {
    Text = "【尝试游泳】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61061_ChoiceDesc3 = {
    Text = "【呼喊幽灵】获得25黑印"
  },
  Event_61061_Desc = {
    Text = "你向前奔去，脚下的土地忽然变成一片无法行走的汪洋。\n你坠入土壤。\n如同墓园中的幽灵一起出现，无数粘稠的黑暗包围了你，贪婪地侵入你的口鼻。"
  },
  Event_61061_Name = {
    Text = "陷入地底"
  },
  Event_61062_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61062_Desc = {
    Text = "你瞪大眼睛，努力搜寻所有的蛛丝马迹。\n一百只眼睛同时转动，你看到身前人面犬奔跑的趾爪，你看到身后哈姆林指挥棒挥舞的轨迹。\n你贪婪地观察着所有。\n忽然，你看到地上滚落了一只熟悉的眼球。\n那好像是你自己的眼睛。"
  },
  Event_61062_Name = {
    Text = "求知的贪婪"
  },
  Event_61063_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61063_Desc = {
    Text = "不对，你不可能看到这么多东西。\n你明明只有……只有几只眼睛来着？\n你连忙闭上眼睛，伸手到脸上摸索。\n一、二……\n再睁眼时你的视野重新变得狭窄而无知。\n原来你只有两只眼睛啊，可惜，可惜。"
  },
  Event_61063_Name = {
    Text = "求知的贪婪"
  },
  Event_61064_ChoiceDesc1 = {
    Text = "【搜寻】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61064_ChoiceDesc2 = {
    Text = "【闭眼】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61064_Desc = {
    Text = "越来越多的线索线头一般杂乱地缠成了团，你焦急、迷茫、愤恨，你恨自己为什么一无所知。\n巨大的压力让你的精神绷紧成一条细线。\n嘣的一声，你感到头皮忽然放松了下来，你忽然能看到周围全部的景象，看到虚空之中摇曳的阴影。\n更多，你还需要看到更多……"
  },
  Event_61064_Name = {
    Text = "求知的贪婪"
  },
  Event_61065_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61065_Desc = {
    Text = "你在土壤中游泳，想象自己是最灵活的鱼。\n想变成鱼，就要舍弃人类的双腿。\n这是交易的代价。\n很快，你感到前所未有的轻松，你成为了地底最自由的存在。\n你游回了地面，却已经忘记如何走路。"
  },
  Event_61065_Name = {
    Text = "陷入地底"
  },
  Event_61066_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61066_Desc = {
    Text = "你的指尖碰到银钥匙熟悉的触感，那是所有光芒的核心。\n这是你生命的浓缩，这是你命运的化身。\n过往的经历一幕幕闪过眼前。\n你的选择已经与这世界的选择牢牢绑定。\n你的命运已经与许许多多的人紧紧相连。"
  },
  Event_61066_Name = {Text = "窥视"},
  Event_61067_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61067_Desc = {
    Text = "你感到有许多亲切的存在包围着你。\n你尝试呼喊那些未必存在的幽灵。\n奇迹发生，你重新回到地面之上。\n无数的墓碑依然缄默。"
  },
  Event_61067_Name = {
    Text = "陷入地底"
  },
  Event_61068_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61068_Desc = {
    Text = "你没有时间感慨，你只想尽快拯救这崩塌的一切。\n如果你变成了星星，那就让你化作流星吧。\n只要能照耀夜空，哪怕终将陨落。"
  },
  Event_61068_Name = {Text = "窥视"},
  Event_61069_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61069_Desc = {
    Text = "你将耳朵贴得更紧，将所有细碎的声音收入脑袋。\n“我……”\n“你一定……”\n你只能听见残缺的字句，无法分辨任何含义。\n但你不敢出声，生怕错过任何一个字。\n然而命运没有给你更多垂怜。\n仅剩的一点声音也这样消失了，四周重归寂静。"
  },
  Event_61069_Name = {
    Text = "思念的回音"
  },
  Event_61070_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61070_Desc = {
    Text = "你没有再继续思考下去，指挥唤醒体们列队，迎接他的挑战。"
  },
  Event_61070_Name = {
    Text = "魔鬼指挥家"
  },
  Event_61071_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61071_Desc = {
    Text = "你不断呼喊着她的名字，试图传递哪怕一丝的心情。\n你不知道她有没有听见，你努力辨别话筒中模糊的声音。\n那好像是她的回应，又好像是无数过去的碎片在循环播放。\n播放着你们共同经历的悲欢与相遇。"
  },
  Event_61071_Name = {
    Text = "思念的回音"
  },
  Event_61072_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_61072_Desc = {
    Text = "或许这片黑暗才是真实的世界，加入其中有什么不好？\n你彻底接纳了黑暗，黑暗同样不再排斥你，你能够自如呼吸。\n下一秒你回到了地面之上，或许有什么东西永远留在了地下，但那已经不重要了。"
  },
  Event_61072_Name = {
    Text = "陷入地底"
  },
  Event_61073_ChoiceDesc1 = {
    Text = "【注视光芒】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_61073_ChoiceDesc2 = {
    Text = "【触碰胸口】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_61073_ChoiceDesc3 = {
    Text = "【继续奔跑】获得25黑印"
  },
  Event_61073_Desc = {
    Text = "你心中迷茫，只能拼命奔跑，无暇思考许多。\n忽然，你感到胸口空落落。\n你低头看去，原本心脏的位置出现了一团钥匙形状的光芒。\n那光芒越来越亮，逐渐蔓延到你的全身。\n你看到自己化为了一颗星星。\n你忽然明白，或许这就是你一直以来的使命。"
  },
  Event_61073_Name = {Text = "窥视"},
  Event_61074_ChoiceDesc1 = {
    Text = "【准备迎战】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61074_ChoiceDesc2 = {
    Text = "【仔细观察】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_61074_Desc = {
    Text = "「喂……等等！什么情况……」\n「排练。」\n男子面无表情地看着你。\n「用乐声维持唤醒体链接，是一个新的尝试。确保乐团的水准，才能确保演出的完美。」\n他抬起的指挥棒清晰挥下，在空中划出一道优雅的起奏符。\n「演奏吧，守密人。让我看看，你能做到些什么。」"
  },
  Event_61074_Name = {
    Text = "魔鬼指挥家"
  },
  Event_61075_ChoiceDesc1 = {
    Text = "【准备迎战】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_61075_Desc = {
    Text = "无论他有什么目的，至少是他将你从审查会的围攻下救了出来。如果他想要对你不利，根本就没有必要帮助你。 你冷静下来，做好了最后的准备。"
  },
  Event_61075_Name = {
    Text = "魔鬼指挥家"
  },
  Event_65400_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65400_Desc = {
    Text = "联络员传达了外界对你们实施援救的承诺，听到救援队已经在想办法进山，所有人心中重新燃起了希望。"
  },
  Event_65400_Name = {Text = "联络处"},
  Event_65401_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65401_Desc = {
    Text = "所有科考团的成员没有一人走出雪山，在灾难面前，你永远只选择自己，普通人的性命在你眼中一文不值，你舍弃了人性，安全走到了最后。\n救援人员复杂地看着你，你无动于衷，回头走进了风雪之中。或许在午夜梦回时，那些因为你的冷漠而丧命的亡魂会围绕在你的床前，默默地注视着你。"
  },
  Event_65401_Name = {
    Text = "安全撤离点"
  },
  Event_65402_ChoiceDesc1 = {
    Text = "【民众撤离】移除造物「科考团」，根据科考团人数，获得不同等级的「救难勋章」。"
  },
  Event_65402_Desc = {
    Text = "你将科考团安全送达了撤离点，救援队接管了一切，获救的人们瘫倒在地，恍如隔世。\n然而你知道，真正的危机远远没有解决，那只巨兽仍然盘踞在群山之中，饥肠辘辘地等待着你们。"
  },
  Event_65402_Name = {
    Text = "安全撤离点"
  },
  Event_65403_ChoiceDesc1 = {
    Text = "【补给兑换】获得 25 个黑印，每有 1 名科考团员额外获得 1 个黑印（Arg1）。"
  },
  Event_65403_ChoiceDesc2 = {
    Text = "【援救承诺】选择获得 1 个刻印。补充 2 个科考团人员。"
  },
  Event_65403_ChoiceDesc3 = {
    Text = "【效益至上】失去 10 名科考团员，选择获得一个黄金+造物。"
  },
  Event_65403_Desc = {
    Text = "你们在风雪中艰难跋涉，追随着远方应急联络处忽明忽灭的灯光。\n    ○ 终于，在第无数次祈祷后，你们看见了那座蕴藏希望的小屋。"
  },
  Event_65403_Name = {Text = "联络处"},
  Event_65403_Tips3 = {
    Text = "科考团人数不足"
  },
  Event_65404_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65404_Desc = {
    Text = "你们从联络员口中得知了联络处仓库的密码，并在其中找到了所有人两天份的物资，恭喜你们至少不会在雪山中饥寒而死了。"
  },
  Event_65404_Name = {Text = "联络处"},
  Event_65415_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_65415_Desc = {
    Text = "雪山瞬间完成了进食，有两个人永远消失在了深不见底的冰缝中，而你们对此一无所知。"
  },
  Event_65415_Name = {Text = "幻象"},
  Event_65416_ChoiceDesc1 = {
    Text = "【离开】寻找探照灯"
  },
  Event_65416_ChoiceDesc2 = {
    Text = "【闯入大雪】损失 2 名科考团员。"
  },
  Event_65416_Desc = {
    Text = "雪山上忽然挂起一阵狂风，耳畔呼啸的风声仿佛是巨兽的尖啸，白茫茫的雪雾一瞬迷住了你们的眼睛，似乎有什么东西在无尽的白雾中穿行。\n你们被迫停住了脚步，努力将双腿深深扎进积雪，以防自己滚下山坡。"
  },
  Event_65416_Name = {Text = "未知"},
  Event_65417_ChoiceDesc1 = {
    Text = "【无声蒸发】损失 2 名科考团员。"
  },
  Event_65417_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_65417_Desc = {
    Text = "雪山的腹部传来轰隆隆的怒吼，如饥饿的野兽发出不满的咆哮，大地颤动，积雪下的冰层悄然开裂，像是雪山咧开了嘴巴。\n当大地的震颤终于停止，人们茫然四顾，你回过头查看队伍。"
  },
  Event_65417_Name = {Text = "幻象"},
  Event_65468_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65468_Desc = {
    Text = "为了保证队伍的行动力，你放弃了行动艰难的那部分人，将他们留在了这座孤立的小屋中。这或许能够提高剩余人员的存活率，但看着那些不甘怨恨的眼神，你的内心完全没有波动吗？"
  },
  Event_65468_Name = {Text = "联络处"},
  Event_65483_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65483_Desc = {
    Text = "你救下了一些人，但更多的人永远留在了雪山，不管怎么说，你至少尽了力。\n救援人员表示你的贡献随后将被表彰，你挥了挥手，回头走进了风雪之中。"
  },
  Event_65483_Name = {
    Text = "安全撤离点"
  },
  Event_65484_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65484_Desc = {
    Text = "你无暇他顾，为了走出雪山，采取了效益最大的方式，在最后的幸存者眼里，你或许形同恶魔。\n救援人员表示你的贡献随后将被表彰，你挥了挥手，回头走进了风雪之中。"
  },
  Event_65484_Name = {
    Text = "安全撤离点"
  },
  Event_65485_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65485_Desc = {
    Text = "在你不遗余力的保护下，科考团全员毫无伤亡，遇到你是他们不幸中最大的幸运，你是他们货真价实的救世主。\n你创造了灾难中的奇迹，关于雪山英雄的传闻或许很快就要传播四方。救援人员郑重表示你的卓越贡献随后将被表彰，你笑着挥了挥手，回头走进了风雪之中。"
  },
  Event_65485_Name = {
    Text = "安全撤离点"
  },
  Event_65486_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65486_Desc = {
    Text = "你真切地在乎着人们的生命，大部分人被你挽救，人们痛哭流涕，不停感谢着你的一路保护。\n救援人员郑重表示你的杰出贡献随后将被表彰，你笑着挥了挥手，回头走进了风雪之中。"
  },
  Event_65486_Name = {
    Text = "安全撤离点"
  },
  Event_65487_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_65487_Desc = {
    Text = "你与无常的灾难抗衡，并将人们从死神手中抢回，经过你的努力，悲剧的结局稍稍发生了偏移。\n救援人员郑重表示你的宝贵贡献随后将被表彰，你笑着挥了挥手，回头走进了风雪之中。"
  },
  Event_65487_Name = {
    Text = "安全撤离点"
  },
  Event_6817_ChoiceDesc1 = {
    Text = "【适可而止】获得3选1刻印"
  },
  Event_6817_ChoiceDesc2 = {
    Text = "【坚持阅读】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6817_Desc = {
    Text = "在木质书架的最高处，摆放着一本金黄色封面的书册。从地面的视角看不见书的名字。\n不知为何，你产生了阅读它的渴望……这种渴望在转瞬之间就膨胀到难以遏制，你不顾惊动他人的风险，踏上书架旁的木梯，取下了那本书，急不可耐地阅读起来……\n朦胧的印象在你的思维之海中升起，你沉没在幻象的海洋之中……"
  },
  Event_6817_Name = {
    Text = "黄色书卷"
  },
  Event_6818_ChoiceDesc1 = {
    Text = "【聆听】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6818_ChoiceDesc2 = {
    Text = "【合奏】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_6818_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_6818_Desc = {
    Text = "琴声是突然传到你耳中的。幽绿的手指在琴键上跳跃，优雅的声音如同溪水般流淌。\n「亲爱的朋友，想跟我和奏一曲吗？」\n手不会说话，它用琴声向你问道。"
  },
  Event_6818_Name = {
    Text = "琴边幽灵"
  },
  Event_6819_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6819_Desc = {
    Text = "拉蒙娜望向声音的来源，却只来得及看到一个逐渐消散的幻影，看上去像是融在墙上的留声机。"
  },
  Event_6819_Name = {
    Text = "他人之耳"
  },
  Event_6820_ChoiceDesc1 = {
    Text = "【清理打字机】删除1张指令卡，获得25黑印"
  },
  Event_6820_ChoiceDesc2 = {
    Text = "【尝试辨识文字】复制一张牌库中的牌，感染「(Skill.Arg1)」"
  },
  Event_6820_Desc = {
    Text = "手提箱中的打字机突然喷薄出稠厚的浓墨，伴随着列车的摇晃飞溅成线性的流瀑。"
  },
  Event_6820_Name = {
    Text = "打字机的低语"
  },
  Event_6821_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6821_Desc = {
    Text = "在拳头挥散幻影的刹那，记忆猛地冲进你的大脑，回忆一段段撞击着灵魂，生闷发痛。"
  },
  Event_6821_Name = {
    Text = "海市蜃楼"
  },
  Event_6822_ChoiceDesc1 = {
    Text = "【扔掉信纸】删除1张卡牌"
  },
  Event_6822_ChoiceDesc2 = {
    Text = "【贴身放好】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6822_Desc = {
    Text = "将几张卷入打字机中的信纸抽出，洇开的字体散发着浓郁的油墨香气，你扫视过信件的内容，下意识皱起了眉。\n信件的内容大多被涂抹掉了，仅剩的那些也都字不成句，没剩下什么可读的。"
  },
  Event_6822_Name = {
    Text = "涂字信件"
  },
  Event_6823_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6823_Desc = {
    Text = "你努力辨认纸上模糊的字迹。它们不断扭曲，随后显现出截然不同的内容。\n「@2我想你应该从报纸上看到那则消息了。\n是的，你的父亲已经将你从继承人顺位中剔除……我们也不愿意@2\n魔鬼，魔鬼……\n请立刻停止与那位赫伯特先生的交往，否则我会停止对你的经济援助……」"
  },
  Event_6823_Name = {
    Text = "见字如晤"
  },
  Event_6824_ChoiceDesc1 = {
    Text = "【握住银钥】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6824_ChoiceDesc2 = {
    Text = "【闭上双眼】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_6824_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_6824_Desc = {
    Text = "你被一阵巨大的荒诞撕扯着，肢体扭曲地爬行于地面，仿佛被来自维度以外的@2操纵。\n「不……不……」\n你的理智寸寸垮塌，神志不清的狞笑和尖叫交织，如一道巨网缚住你的意识，溢到嘴边的只有含混不清的哀鸣。"
  },
  Event_6824_Name = {
    Text = "凝望之眼"
  },
  Event_6825_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6825_Desc = {
    Text = "将它交给守密人处置吧，不知会唤醒怎样的个体。"
  },
  Event_6825_Name = {
    Text = "孤独银芯"
  },
  Event_6826_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6826_Desc = {
    Text = "悲伤的小调流淌耳畔，苦闷与疼痛充斥着大脑与灵魂。在反应过来时，某人的眼角已然湿润。"
  },
  Event_6826_Name = {
    Text = "无名之音"
  },
  Event_6827_ChoiceDesc1 = {
    Text = "【推开左侧的门】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_6827_ChoiceDesc2 = {
    Text = "【推开右侧的门】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6827_Desc = {
    Text = "门。门。无数扇门。\n门的数量似乎比你和拉蒙娜巡视时要多出不少。\n你们在走廊上站定，准备推开下一扇门。\n左侧的门后寂静无声，含蓄克制地等待着你们的光临。\n右侧的门后传出含混不清的交谈声。"
  },
  Event_6827_Name = {
    Text = "无限之门"
  },
  Event_6828_ChoiceDesc1 = {
    Text = "【侧耳聆听】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6828_ChoiceDesc2 = {
    Text = "【堵住耳朵】获得3选1刻印"
  },
  Event_6828_Desc = {
    Text = "你只能听见狂乱的琴键敲击声，如暴风骤雨般侵袭而来，如陨石砸在地面上的震响，整架琴都随之战栗。\n击弦的木槌在吱呀乱叫，乱跳的踏板溢出沉痛的悲鸣。\n在诡谲的乐声中，熟悉的音律被裹挟着，剐蹭过你的耳膜。"
  },
  Event_6828_Name = {
    Text = "禁忌音色"
  },
  Event_6829_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6829_Desc = {
    Text = "「威廉调查员已为您提供紧急物资输送，请于查收后敲击三次胸针确认。」"
  },
  Event_6829_Name = {
    Text = "支援通讯"
  },
  Event_6830_ChoiceDesc1 = {
    Text = "【推开左侧的门】获得3选1刻印"
  },
  Event_6830_ChoiceDesc2 = {
    Text = "【推开右侧的门】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6830_Desc = {
    Text = "门。门。无数扇门。\n门的数量似乎比你和拉蒙娜巡视时要多出不少。\n你们在走廊上站定，准备推开下一扇门。\n左侧的门后寂静无声，含蓄克制地等待着你们的光临。\n右侧的门后传出含混不清的交谈声。"
  },
  Event_6830_Name = {
    Text = "无尽门扉"
  },
  Event_6831_ChoiceDesc1 = {
    Text = "【阅读书信】删除1张指令卡，获得Arg1黑印"
  },
  Event_6831_ChoiceDesc2 = {
    Text = "【关好箱子】"
  },
  Event_6831_Desc = {
    Text = "手提箱震颤不止，宛如某种生命正撕咬着蛋壳，即将破茧而出。\n你不受控制地打开箱子，信纸如放飞的蝴蝶般四散喷涌。"
  },
  Event_6831_Name = {
    Text = "不速来信"
  },
  Event_6832_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6832_Desc = {
    Text = "急促的铃声惹人心焦，你拿起听筒搁在桌面上。铃声像被掐住了脖子般猝然中断，只留下脑海中残留的回响。"
  },
  Event_6832_Name = {
    Text = "列车来电"
  },
  Event_6833_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6833_ChoiceDesc2 = {
    Text = "【检查胶卷】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，可以使用两次"
  },
  Event_6833_Desc = {
    Text = "工作室的角落放着一台老旧的相机、几卷胶片和零星散落的照片。 它们忠实地记录着蜡像师的工作与美学。"
  },
  Event_6833_Name = {
    Text = "如实记录"
  },
  Event_6834_ChoiceDesc1 = {
    Text = "【继续盘问】提升 Arg1 点最大生命"
  },
  Event_6834_ChoiceDesc2 = {
    Text = "【抓住影子】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6834_Desc = {
    Text = "影子在金色尘埃中诵念：\n「那些知晓真理的……\n以钥匙为权柄，必将指引世人道路。」\n这是一句古老的箴言。\n直觉告诉你，它离你寻找的真相很近很近。\n而你的直觉一向很准。"
  },
  Event_6834_Name = {Text = "银钥使"},
  Event_6835_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6835_Desc = {
    Text = "你毫不掩饰自己对痴狂呓语的认同，在对方癫狂的诱惑下，你差点被绑上了那位存在的餐桌。"
  },
  Event_6835_Name = {
    Text = "水中祭典"
  },
  Event_6836_ChoiceDesc1 = {
    Text = "【呼唤乌鸦】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_6836_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_6836_Desc = {
    Text = "你不离去，它们也不曾离开。\n奇异的绳索将你们的精神相连，它们似乎有什么话想要和你说。"
  },
  Event_6836_Name = {
    Text = "离群之鸦"
  },
  Event_6837_ChoiceDesc1 = {
    Text = "【放弃抵抗】删除1张指令卡，获得Arg1黑印"
  },
  Event_6837_ChoiceDesc2 = {
    Text = "【抽回双手】"
  },
  Event_6837_Desc = {
    Text = "一只、两只、三只……\n脸上、手指上，成群的蝴蝶像是空中绽放的烟花，在黑暗中闪动着宝石般的光芒。\n这台打字机没有任何实际功用，但它对创造美却很在行。"
  },
  Event_6837_Name = {
    Text = "灵感迸发"
  },
  Event_6838_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6838_Desc = {
    Text = "更重要的事情就在你面前，你合上箱子打定主意不去理会，而打字机也渐渐沉默。"
  },
  Event_6838_Name = {
    Text = "不请自来的警告"
  },
  Event_6839_ChoiceDesc1 = {
    Text = "【聆听月亮】感染「(Skill.Arg1)」"
  },
  Event_6839_ChoiceDesc2 = {
    Text = "【聆听矮星】感染「(Skill.Arg1)」"
  },
  Event_6839_ChoiceDesc3 = {
    Text = "【聆听流星】失去25黑印"
  },
  Event_6839_Desc = {
    Text = "热烈，明亮，永不落幕。"
  },
  Event_6839_Name = {
    Text = "星月之音"
  },
  Event_6840_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6840_Desc = {
    Text = "光辉的中心是一滴固化的银芯，可理智告诉你，它并没有发光。\n视线追逐着光线的源头，却一眼撞入了黑暗与未知的陷阱……"
  },
  Event_6840_Name = {
    Text = "暗夜荧光"
  },
  Event_6841_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6841_Desc = {
    Text = "北边，北侧出口！\n和拉蒙娜的决策一样，北方一定有出路。"
  },
  Event_6841_Name = {
    Text = "一路向北"
  },
  Event_6842_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6842_Desc = {
    Text = "哦……无瑕的银色，代表了灵魂对你开的玩笑。\n那么，你的下一个选择是？"
  },
  Event_6842_Name = {
    Text = "好戏开场"
  },
  Event_6843_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6843_Desc = {
    Text = "你甩甩头，把声音抛之脑后。\n一声若有似无的叹息，送来了一些帮助。"
  },
  Event_6843_Name = {
    Text = "一路向北"
  },
  Event_6844_ChoiceDesc1 = {
    Text = "【深入回廊】感染「(Skill.Arg1)」，是否还要继续前进"
  },
  Event_6844_ChoiceDesc2 = {
    Text = "【背道而驰】获得25黑印"
  },
  Event_6844_Desc = {
    Text = "月光消逝，被回廊吞噬，只剩透着不祥气息的门扉留在眼前。"
  },
  Event_6844_Name = {
    Text = "寂静回廊"
  },
  Event_6845_ChoiceDesc1 = {
    Text = "【深入回廊】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，是否还要继续前进"
  },
  Event_6845_ChoiceDesc2 = {
    Text = "【背道而驰】获得25黑印"
  },
  Event_6845_Desc = {
    Text = "未知全貌，不应深入。"
  },
  Event_6845_Name = {
    Text = "寂静回廊"
  },
  Event_6846_ChoiceDesc1 = {
    Text = "【深入回廊】感染「(Skill.Arg1)」，是否还要继续前进"
  },
  Event_6846_ChoiceDesc2 = {
    Text = "【背道而驰】获得25黑印"
  },
  Event_6846_Desc = {
    Text = "左侧的门扉发出了诡异的狞笑声，祂轻微震动着，抖落丝缕恶意。"
  },
  Event_6846_Name = {
    Text = "寂静回廊"
  },
  Event_6847_ChoiceDesc1 = {
    Text = "【深入回廊】获得白银造物「(RelicConfig.Arg1)」，是否还要继续前进"
  },
  Event_6847_ChoiceDesc2 = {
    Text = "【背道而驰】获得25黑印"
  },
  Event_6847_Desc = {
    Text = "右侧的门扉敞开着，鲜血在地面上绵延出既定的轨迹。"
  },
  Event_6847_Name = {
    Text = "寂静回廊"
  },
  Event_6848_ChoiceDesc1 = {
    Text = "【已经没有任何东西了，你退了出来】"
  },
  Event_6848_Desc = {
    Text = "谁说 一定要横冲直撞呢？退一步，或许真的有海阔天空。"
  },
  Event_6848_Name = {
    Text = "寂静回廊"
  },
  Event_6849_ChoiceDesc1 = {
    Text = "【修复蜡像】选择卡牌并使其算力消耗降低1"
  },
  Event_6849_Desc = {
    Text = "蜡像的修复工作正持续进行着。\n你并非专业的蜡像师，也未曾接受过系统的美学教育。\n但你依然熟练地开始倒模、塑形、上色……\n就像你生来便该手持刻刀。\n就像它生来便该残缺，只为等待你的雕琢。"
  },
  Event_6849_Name = {
    Text = "未完的蜡像"
  },
  Event_6850_ChoiceDesc1 = {
    Text = "【修复蜡像】选择卡牌并使其算力消耗降低1"
  },
  Event_6850_Desc = {
    Text = "伽拉忒亚，伽拉忒亚……\n你循着呼唤声再次找到了未完的蜡像。\n她看上去完美极了，甚至令人不安。\n「丑陋是撕开完美的一道口子。」\n在最后的时刻，你决定做点什么。"
  },
  Event_6850_Name = {
    Text = "未完的蜡像"
  },
  Event_6851_ChoiceDesc1 = {
    Text = "【接受幻觉】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6851_ChoiceDesc2 = {
    Text = "【否认幻觉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6851_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_6851_Desc = {
    Text = "厚重黑暗的铁架桥下，芦苇丛生的寂静河滩上，忽然飞出一只闪光的蝴蝶。\n蝴蝶轻盈地落在你的掌心，糟糕的嚎叫声停息了，取而代之的是火车碾过锈蚀钢架的轰鸣声，煤炭燃烧的噼啪声，轮轴转动的金属摩擦声……"
  },
  Event_6851_Name = {
    Text = "铁路的幻觉"
  },
  Event_6852_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6852_Desc = {
    Text = "是的，逃亡，你在被某种生物追逐，求生的本能让你拔腿狂飙，直至无路可逃。 不对，应该无路可逃的……不是地狱犬才对吗？"
  },
  Event_6852_Name = {Text = "奔跑"},
  Event_6853_ChoiceDesc1 = {
    Text = "【这不是真的】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_6853_ChoiceDesc2 = {
    Text = "【下坠、下坠……】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6853_Desc = {
    Text = "掉落在地上的镜子有着精致的方框，方框里面又有方框，方框里面又有方框……\n爱丽丝一跃而下，在永无止境的兔子洞里不断下坠，她看见一块又一块镜子，一个又一个精神困在这里，唯独看不见自己。"
  },
  Event_6853_Name = {Text = "镜中镜"},
  Event_6854_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6854_Desc = {
    Text = "你隔着风雪的窗纱俯瞰雪山，许多只黑色的蚂蚁追逐着一只黑色的蚂蚁……\n你的思路中断了。"
  },
  Event_6854_Name = {
    Text = "火山追忆"
  },
  Event_6855_ChoiceDesc1 = {
    Text = "【上前握住】获得25黑印"
  },
  Event_6855_ChoiceDesc2 = {
    Text = "【友好回应】50%机会获得50黑印，50%机会一无所有"
  },
  Event_6855_Desc = {
    Text = "一只不知从何而来的猫端坐在融蚀浆之间，轮廓模糊的躯体说明它应当是精神维度的住民。\n这个看不清面孔的投影用智慧的目光望着拉蒙娜，它抬起洁白的前爪，招手一般朝她示意。"
  },
  Event_6855_Name = {
    Text = "游走的住民"
  },
  Event_6856_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6856_Desc = {
    Text = "一幅喜气洋洋的人物群像。\n蜡像们盛装打扮，整齐地坐在椅子上，脸上带着同样夸张的微笑。\n它们和谐得就像你能在任何一家疯人院里见到的那样。\n\n落款：洪积305年，@2罗杰斯"
  },
  Event_6856_Name = {
    Text = "肖像回廊"
  },
  Event_6857_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6857_Desc = {
    Text = "你小心地摘下碎片，仔细检查。它又一动不动了。\n「笨手笨脚的，别乱动，」朵尔轻敲你的后脑勺，「短时间内我可没办法给你捣鼓出第二片来。」"
  },
  Event_6857_Name = {
    Text = "不安的胸针"
  },
  Event_6858_ChoiceDesc1 = {
    Text = "【使用钥匙】"
  },
  Event_6858_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_6858_Desc = {
    Text = "一扇门堵住了你的去路。你用尽了各种方法，它依然纹丝不动。"
  },
  Event_6858_Name = {
    Text = "锈蚀门扉"
  },
  Event_6858_Tips1 = {
    Text = "需要获得「锈蚀钥匙」"
  },
  Event_6859_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6859_Desc = {
    Text = "你为自己的武断感到羞愧。\n一位合格的守密人必须严谨，你不应贸然做出它们不是「高档货」的判断。\n于是你决定仔细观察它们。五分钟过去了，十分钟过去了……\n好了，现在你可以下判断了——\n确实是垃圾货。"
  },
  Event_6859_Name = {
    Text = "被缚的灵魂"
  },
  Event_6860_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6860_Desc = {
    Text = "你和你的同伴们放下了武器。\n这并非大发善心，而是你明白它们摇摇欲坠的身躯无法坚持太久。\n事实证明你的判断是正确的。"
  },
  Event_6860_Name = {Text = "习作"},
  Event_6861_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6861_Desc = {
    Text = "「来追我啊！」\n「来啊，笨蛋！」\n「有本事就把我们抓起来啊！」\n孩子们的声音得意洋洋。\n「混账东西！给我站住！」\n成年人的声音气喘吁吁。"
  },
  Event_6861_Name = {
    Text = "我们的回忆"
  },
  Event_6862_ChoiceDesc1 = {
    Text = "【进入】穿过迷雾，抵达另一端。"
  },
  Event_6862_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_6862_Desc = {
    Text = "这是你要找的人，你完成了任务。"
  },
  Event_6862_Name = {
    Text = "单行密道26"
  },
  Event_6863_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_6863_Desc = {
    Text = "啊！只差了一点！等一下，三个骰子为什么投出了十点！\n骰子们安分地躺在你面前，看上去乖巧又无辜。"
  },
  Event_6863_Name = {
    Text = "无止境的赌局"
  },
  Event_6864_ChoiceDesc1 = {
    Text = "【离开】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_6864_Desc = {
    Text = "可恶！不是六点，但是还有有些赚的。\n所以，它们到底是几点？"
  },
  Event_6864_Name = {
    Text = "无止境的赌局"
  },
  Event_6865_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_6865_Desc = {
    Text = "虽然没有猜中，但也能接受。\n哎，它们到底投的是几点？"
  },
  Event_6865_Name = {
    Text = "无止境的赌局"
  },
  Event_6866_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6866_Desc = {
    Text = "你低头挑拣着石膏碎块，将她一块块拼补回去，她躯体的一部分在你手下渐渐成形。"
  },
  Event_6866_Name = {
    Text = "拼凑残躯"
  },
  Event_6867_ChoiceDesc1 = {
    Text = "【拾取钥匙】"
  },
  Event_6867_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  Event_6867_Name = {
    Text = "锈蚀钥匙"
  },
  Event_6868_ChoiceDesc1 = {
    Text = "【正面】50%概率获得黄金造物「(RelicConfig.Arg2)」，50%概率感染「(Skill.Arg3)」"
  },
  Event_6868_ChoiceDesc2 = {
    Text = "【反面】50%概率获得75黑印，50%概率感染「(Skill.Arg3)」"
  },
  Event_6868_ChoiceDesc3 = {
    Text = "【请对方先选】50%概率获得诅咒造物「(RelicConfig.Arg2)」，50%概率感染「(Skill.Arg3)」"
  },
  Event_6868_Desc = {
    Text = "一场赌局而已，你不会输的。\n镌刻着纹理的硬币被高高抛起，再迅速下落，被你的掌心侵染上温热。"
  },
  Event_6868_Name = {
    Text = "驰名的赌徒"
  },
  Event_6869_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_6869_Desc = {
    Text = "「寄托于命运的眷顾者，也将为命运所倾覆。」\n你选择离开。"
  },
  Event_6869_Name = {
    Text = "驰名的赌徒"
  },
  Event_6870_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6870_Desc = {
    Text = "「守密人。」\n拉蒙娜的声音让你清醒过来，但，下坠的感觉并没有就此消失。"
  },
  Event_6870_Name = {Text = "镜中镜"},
  Event_6871_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6871_Desc = {
    Text = "据说，小夜曲是一种源自爱情的歌曲。\n是在夏日的夜晚、恋人的窗外，人们三两作伴，演奏出来的缱绻乐曲。\n随性、肤浅，并不符合罗杰斯的审美，但依旧成为了他的保留曲目。\n恐怕只有他自己才知道原因了。"
  },
  Event_6871_Name = {
    Text = "糟糕的品味"
  },
  Event_6872_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6872_Desc = {
    Text = "你拒绝被它们的呓语诱惑。\n你说：「谎话连篇！你们被困在漆黑的永夜里，如何穿行宇宙？」\n眼睛们笑了起来。无数笑声汇成巨大的声浪，你的心脏也随之震颤。\n眼睛说：「通过掠夺其它眼睛。每一只眼睛都是一个宇宙。当你拥有一千只眼睛，你将踏上真正的时空之旅。」"
  },
  Event_6872_Name = {Text = "眼"},
  Event_6873_ChoiceDesc1 = {
    Text = "【领取】获得3选1黄金造物"
  },
  Event_6873_Desc = {
    Text = "哦是的，那个可憎的倒影就是你自己。\n喷薄而出的恶意与你脚下的黑浆融作一团，扭曲地共舞着，如果不介意，它也想攀上你的肩头。"
  },
  Event_6873_Name = {
    Text = "镜面之下"
  },
  Event_6874_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6874_Desc = {
    Text = "没过多时，束缚陡然松开，让你摔了个踉跄。\n你回头看向安静的丝线——「切勿搅动流沙」，这句话，在密境中或许也适用。"
  },
  Event_6874_Name = {Text = "深陷"},
  Event_6875_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6875_Desc = {
    Text = "灵知之火亮起，燃尽了所有束缚——\n至少，你是这么认为的。"
  },
  Event_6875_Name = {Text = "深陷"},
  Event_6876_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6876_Desc = {
    Text = "全力挣脱束缚，丝线割破衣物，在皮肤上留下细微的血痕。\n尽管蛛网留下了什么作为通行费，但心情依然如释重负——你自由了。"
  },
  Event_6876_Name = {Text = "深陷"},
  Event_6877_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6877_Desc = {
    Text = "融蚀的赘生物产生的信笺，其所产生的信息也大多会被抹杀。\n你没能从信纸上获取有价值的信息，索性撕掉了信纸，随手洒落。"
  },
  Event_6877_Name = {
    Text = "蝴蝶篇目"
  },
  Event_6878_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6878_Desc = {
    Text = "就算文字被刻意抹去，你也依旧能清晰地察觉到——信件的价值。"
  },
  Event_6878_Name = {
    Text = "蝴蝶篇目"
  },
  Event_6879_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6879_Desc = {
    Text = "小心为上。\n拉蒙娜躬着腰，回到走廊上，潜入下一个房间。"
  },
  Event_6879_Name = {
    Text = "窗中倒影"
  },
  Event_6880_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6880_Desc = {
    Text = "你发出一声绝望的尖啸。\n群鸦似是被你的声音所惑，很快便消失无踪，留下漆黑的印记。"
  },
  Event_6880_Name = {
    Text = "群鸦之歌"
  },
  Event_6881_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6881_Desc = {
    Text = "你蜷缩身体，试图将自己缩成一个黑点。\n这样它们就不会注意到你了吧。\n不知过了过久，你睁开双眼。\n你看见光。"
  },
  Event_6881_Name = {
    Text = "群鸦之歌"
  },
  Event_6882_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6882_Desc = {
    Text = "阴影从指缝间轻轻流走，留下一地金色尘埃。"
  },
  Event_6882_Name = {Text = "银钥使"},
  Event_6883_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6883_Desc = {
    Text = "你胡乱地揉搓着自己的头发，臆想和狂思争先恐后在你的脑中迸发，包裹着黑色粘液的团块藏于深处。\n剖开它，会给予你怎样的馈赠？"
  },
  Event_6883_Name = {
    Text = "搅动大脑"
  },
  Event_6884_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6884_Desc = {
    Text = "彩色油污渐渐胀满视野，你的情绪陷入无序的狂欢。"
  },
  Event_6884_Name = {
    Text = "搅动大脑"
  },
  Event_6885_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_6885_Desc = {
    Text = "一种近水银态的银色物质，由融蚀黏液中提炼而出，蕴含强大精神力，主要用于在仪式中链接更多唤醒体。"
  },
  Event_6885_Name = {Text = "银芯"},
  Event_6886_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6886_Desc = {
    Text = "欢乐的笑声从盒子内倾泻而出，温暖的荧光消散后，你看到一张卡片，上面画着三个火柴人：你，银发的拉蒙娜，金发的奥吉尔。旁边还有一行字。\n   「谢谢你们！」"
  },
  Event_6886_Name = {
    Text = "善意的礼物"
  },
  Event_6887_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6887_Desc = {
    Text = "你的肉身躲过了蝶群，但她们没有失去自己的目标，钻入你的手提箱中，贪婪地吮吸着打字机中的油墨。"
  },
  Event_6887_Name = {
    Text = "妄念喷涌"
  },
  Event_6888_ChoiceDesc1 = {
    Text = "【指出错误】选择1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6888_ChoiceDesc2 = {
    Text = "【听完弹奏】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_6888_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_6888_Desc = {
    Text = "男孩蜡像坐在钢琴前弹奏练习曲。\n他的老师——同样也是蜡像做的，正在一旁指导。\n133，355，244……\n错了，每个音都错了。"
  },
  Event_6888_Name = {Text = "钢琴课"},
  Event_6889_ChoiceDesc1 = {
    Text = "【放弃抵抗】删除1张指令卡，获得Arg1黑印"
  },
  Event_6889_ChoiceDesc2 = {
    Text = "【抽回双手】"
  },
  Event_6889_Desc = {
    Text = "你无力抵抗内心的冲动。\n手指像迷失在树林里的孩童，在键盘上游荡、嬉戏……\n渐渐地，有蝴蝶从打字机中飞了出来。\n一只、两只、三只……\n脸上、手指上，成群的蝴蝶像是空中绽放的烟花，在黑暗中闪动着宝石般的光芒。\n这台打字机没有任何实际功用，但它对创造美却很在行。"
  },
  Event_6889_Name = {
    Text = "灵感迸发"
  },
  Event_6890_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6890_Desc = {
    Text = "你将纸张举到暗红的灯光下，唯恐错过一个细节。\n这是一张体检报告，受检人正是梅森。\n「体重40kg，血氧浓度正常，同调率30%，共鸣值……」\n你还想接着看下去，字迹却逐渐消失了。\n干净得像什么都没发生过。"
  },
  Event_6890_Name = {Text = "打字机"},
  Event_6891_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6891_Desc = {
    Text = "是的，你不是在逃亡，你在追逐确定的目标——在阴湿狭窄的积雪小巷中左冲右突的「地狱犬」。 你不会忘记这件事，就像你不会忘记通古斯那天将你从废墟中拉起的人的面庞。 ……是谁来着？"
  },
  Event_6891_Name = {Text = "奔跑"},
  Event_6892_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6892_Desc = {
    Text = "在这个隔离之外的空间，你所能依靠的仅仅只有自己。"
  },
  Event_6892_Name = {
    Text = "噩梦行者"
  },
  Event_6893_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6893_Desc = {
    Text = "危机与风险并存。触摸铁锁的瞬间，腐蚀性的黏液灼痛了你的手掌。希望门扉后的造物物有所值。"
  },
  Event_6893_Name = {
    Text = "铁门之后"
  },
  Event_6894_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6894_Desc = {
    Text = "在尚未接触过的世界横冲直撞，你摇摇欲坠的精神并没有退化到丧失理智的地步。\n未知之物的可怖，你深以为然。"
  },
  Event_6894_Name = {
    Text = "噩梦行者"
  },
  Event_6895_ChoiceDesc1 = {
    Text = "【大声喊叫】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6895_ChoiceDesc2 = {
    Text = "【感受寂静】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_6895_ChoiceDesc3 = {
    Text = "【浮出水面】获得25黑印"
  },
  Event_6895_Desc = {
    Text = "你听到了寂静。\n一种放大了的寂静，就像海浪声一样，填满了整个空间。\n\n你抬起头，就像一个凝望星空的小点。"
  },
  Event_6895_Name = {
    Text = "往世之水"
  },
  Event_6896_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6896_Desc = {
    Text = "你竖起耳朵，循声寻觅着声音的来源，试图揪出这个作乱的恶徒。\n可就像是有意戏弄般，就在你以为将人逼入绝境后，总会撞上鬼打墙般的循环，你又被绕回了原地。\n你气馁地踢了一脚砖墙，却从墙上掉下一块砖石，秘藏闪烁在墙上的空洞里。"
  },
  Event_6896_Name = {
    Text = "迷踪留声"
  },
  Event_6897_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6897_Desc = {
    Text = "一定是播放的问题，一定是这样。\n你不信邪地拨回了唱针，艰难忍受了前半段难听的乐声后，记忆中的敲击声却没有响起。\n在你空无一物的身后，地上的小小黑影，正悄然溜走。"
  },
  Event_6897_Name = {
    Text = "迷踪留声"
  },
  Event_6898_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6898_Desc = {
    Text = "你身边并没有人，敲击的秘密必定藏在留声机内部的机括中。\n出于对自己判断的自信，你拆开了老旧的留声机。\n除了内部腐化的金属原件和厚厚一层积灰外，你什么都没有发现。\n只有一句哼笑，逸散在雾气中，轻得仿佛置身梦中."
  },
  Event_6898_Name = {
    Text = "迷踪留声"
  },
  Event_6899_ChoiceDesc1 = {
    Text = "【愚者的白质】回复 Arg1 点生命"
  },
  Event_6899_ChoiceDesc2 = {
    Text = "【狂人的心脏】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6899_ChoiceDesc3 = {
    Text = "【拒绝食用】获得25黑印"
  },
  Event_6899_Desc = {
    Text = "「愚者的白质鲜美得如同煮沸的鱼汤，狂人的心脏则烤成了一块热烘烘、血淋淋的司康。」\n黑影狞笑着，将含有不明食材的菜色，递到了你眼前。\n你深吸了一口，四溢的香气蛮横地钻进鼻腔，你那毫无尊严的唾液腺先行缴械，胃肠悲哀地痉挛着，发出渴求的咕哝哀吟。"
  },
  Event_6899_Name = {
    Text = "肌体盛宴"
  },
  Event_6900_ChoiceDesc1 = {
    Text = "【触摸风铃】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_6900_ChoiceDesc2 = {
    Text = "【观察风铃】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_6900_ChoiceDesc3 = {
    Text = "【什么也不做】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6900_Desc = {
    Text = "叮叮，叮叮......\n这是一只锈蚀的风铃，笨拙的乐音自缝隙里蜿蜒而出。"
  },
  Event_6900_Name = {
    Text = "锈蚀风铃"
  },
  Event_6901_ChoiceDesc1 = {
    Text = "【静观其变】尝试存活"
  },
  Event_6901_ChoiceDesc2 = {
    Text = "【挥动武器】尝试突围"
  },
  Event_6901_ChoiceDesc3 = {
    Text = "【握住一只手】获得25黑印"
  },
  Event_6901_Desc = {
    Text = "你脚下的地面忽然生出一片黑色沼泽，无数只手从中涌了出来。\n它们有着各式各样的肤色、材质和纹理，孔雀蓝的、带鳞片的、长眼睛的，像是穿越无数维度和空间而来，正试图将下一个倒霉蛋拉入它们的大家庭。\n你决定——"
  },
  Event_6901_Name = {
    Text = "黯色沼泽"
  },
  Event_6902_ChoiceDesc1 = {
    Text = "【按住它】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_6902_ChoiceDesc2 = {
    Text = "【摇晃一下】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6902_ChoiceDesc3 = {
    Text = "【什么也不做】获得25黑印"
  },
  Event_6902_Desc = {
    Text = "叮叮，叮叮......\n这是一只锈蚀的风铃，笨拙的乐音自缝隙里蜿蜒而出。"
  },
  Event_6902_Name = {Text = "小风铃"},
  Event_6903_ChoiceDesc1 = {
    Text = "【反驳它们】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_6903_ChoiceDesc2 = {
    Text = "【附和它们】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6903_ChoiceDesc3 = {
    Text = "【提出新观点】获得25黑印"
  },
  Event_6903_Desc = {
    Text = "「请和我们保持距离。」\n成群的老鼠将你围在中心，与你保持着至少五英尺的距离。\n「我们努力繁衍，我们茁壮成长，我们从不挑食——于是我们带给人类疾病、焦虑和痛苦。」\n「我们和人类不应该走得太近，这不是你该来的地方。」\n为了使老鼠们放松警惕，你决定——"
  },
  Event_6903_Name = {Text = "鼠疫"},
  Event_6904_ChoiceDesc1 = {
    Text = "【继续坠落】感染「(Skill.Arg1)」，是否继续下坠"
  },
  Event_6904_ChoiceDesc2 = {
    Text = "【抽身离开】获得25黑印"
  },
  Event_6904_Desc = {
    Text = "「你」邀请着你。\n在螺旋的深处，过去与未来的「你」向你送上了来自不同维度的「赠礼」。"
  },
  Event_6904_Name = {
    Text = "螺旋深渊"
  },
  Event_6905_ChoiceDesc1 = {
    Text = "【摁住乌鸦】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_6905_ChoiceDesc2 = {
    Text = "【放任不管】获得25黑印，离开"
  },
  Event_6905_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。"
  },
  Event_6905_Name = {
    Text = "融浆之泪"
  },
  Event_6906_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6906_Desc = {
    Text = "红色，热情、奔放、艳丽，我正巧认识一位这样的美人，假以时日你们会相见的。\n那么，你的下一个选择是？"
  },
  Event_6906_Name = {
    Text = "好戏开场"
  },
  Event_6907_ChoiceDesc1 = {
    Text = "【大声喝彩】"
  },
  Event_6907_ChoiceDesc2 = {
    Text = "【昏昏欲睡】"
  },
  Event_6907_Desc = {
    Text = "你做了一个很长的梦。\n梦里，你坐在观众席上，看着舞台上歌唱的男孩。\n「老查理有一只他很爱很爱的虎斑猫\n当她无故失踪的时候他到处找」\n……\n空洞干涩的声音机械地重复着，无休无止……"
  },
  Event_6907_Name = {
    Text = "终幕礼Ⅳ"
  },
  Event_6908_ChoiceDesc1 = {
    Text = "【解开上方的枝节】"
  },
  Event_6908_ChoiceDesc2 = {
    Text = "【解开下方的枝节】"
  },
  Event_6908_Desc = {
    Text = "残留密境的灵知互相勾连，纠缠出一片不稳定的力场。\n或许，你能解开缠绕的灵，为自己梳理出前进的道路。"
  },
  Event_6908_Name = {
    Text = "纠缠之路"
  },
  Event_6909_ChoiceDesc1 = {
    Text = "【离开】选择觉醒2名唤醒体"
  },
  Event_6909_Desc = {
    Text = "你站起身，立刻冲向门口。\n 「你掀开了盖布……\n 秘密，你发现了秘密……」\n 声浪汇成喧嚣的海洋，地板在可怕的共振中剧烈抖动。\n 你不敢回头，以最快的速度逃离了现场。"
  },
  Event_6909_Name = {
    Text = "终幕礼Ⅴ"
  },
  Event_6910_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6910_Desc = {
    Text = "你不反抗，当然，你也并不会选择沉湎。"
  },
  Event_6910_Name = {
    Text = "颅中疮孔"
  },
  Event_6911_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6911_Desc = {
    Text = "你不再抗拒，任由污秽吞噬躯体和精神，长眠过后，银光落入你交握的手中。"
  },
  Event_6911_Name = {
    Text = "颅中疮孔"
  },
  Event_6912_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6912_Desc = {
    Text = "越是挣扎，脑中的污秽就陷得越深，而在淤积着罪恶的大脑最深处，埋藏着不知来由的馈赠。"
  },
  Event_6912_Name = {
    Text = "颅中疮孔"
  },
  Event_6913_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6913_Desc = {
    Text = "随着网的破碎，有什么东西在你脑海中一闪而过，似乎是几个孩子的笑脸。"
  },
  Event_6913_Name = {
    Text = "迷走网路"
  },
  Event_6914_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_6914_Desc = {
    Text = "猫满意地点点头，随即化作一道阴影原地消散，留下了几个黑色的圆形物件。"
  },
  Event_6914_Name = {
    Text = "游走的住民"
  },
  Event_6915_ChoiceDesc1 = {
    Text = "【阅读书信】删除1张指令卡，获得Arg1黑印"
  },
  Event_6915_ChoiceDesc2 = {
    Text = "【关好箱子】"
  },
  Event_6915_Desc = {
    Text = "飞舞的信纸铺天盖地，像极了无声的催促。"
  },
  Event_6915_Name = {
    Text = "不速来信"
  },
  Event_6916_ChoiceDesc1 = {
    Text = "【进入】穿过迷雾，抵达另一端。"
  },
  Event_6916_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_6916_Desc = {
    Text = "面前的道路上出现了一条隐藏隧道，隧道中黑雾弥漫，不知通往何方。"
  },
  Event_6916_Name = {Text = "隧道"},
  Event_6917_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6917_Desc = {
    Text = "你决心终结它的苦难，于是伸手握住它柔软的身躯，收紧，再收紧……\n它在你掌心绝望地挣扎着，最终炸成一团温暖的水浆。"
  },
  Event_6917_Name = {
    Text = "融浆之泪"
  },
  Event_6918_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6918_Desc = {
    Text = "安心吧，这只是维度中碎裂的他人的记忆。你拥有影子。只是，影子里的那个人，真的还是你吗？"
  },
  Event_6918_Name = {
    Text = "记忆碎片·啤酒"
  },
  Event_6919_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6919_Desc = {
    Text = "你用力掰回了乌鸦意图啃咬羽毛的尖喙，它却不依不饶地拧过去，力气之大甚至将你的骨头震得咔咔作响。\n你涨得满脸通红，拼尽全身力气才制住乌鸦的身体，遏止了它疯狂自残的行径。\n正在你松了口气时，乌鸦那已经半秃的脖颈向后猛地一拧，身体瘫软下来，在你的手里化成了一滩黑色的浓浆。"
  },
  Event_6919_Name = {
    Text = "融浆之泪"
  },
  Event_6920_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6920_Desc = {
    Text = "你冷酷地无视了那些绝望的铃声。\n哪怕下一秒就要被炸回原始世界，哪怕你和你的伟大使命就要一起陪葬。\n不该接的电话，就是不能接。\n你深知这个朴素的道理。"
  },
  Event_6920_Name = {
    Text = "请接电话"
  },
  Event_6921_ChoiceDesc1 = {
    Text = "【低头看】获得25黑印"
  },
  Event_6921_ChoiceDesc2 = {
    Text = "【我一定要找到】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6921_Desc = {
    Text = "你追着黑影向前，突然踏入一片浅水之中。看不清颜色的液体没过鞋面，透进丝丝寒意。\n一个声音在水中说：「你不会想要找到。」"
  },
  Event_6921_Name = {
    Text = "你不会想要找到"
  },
  Event_6922_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6922_Desc = {
    Text = "安全的选择。"
  },
  Event_6922_Name = {
    Text = "草垛之后"
  },
  Event_6923_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_6923_ChoiceDesc2 = {
    Text = "【无视】获得25黑印，离开"
  },
  Event_6923_Desc = {
    Text = "疗养院的房间中怎么会有乌鸦？\n但你切实听见了乌鸦的狞笑声，暗影中有某个尚未登上舞台的势力，从那双空洞的鸟眼中窥视着你们。那些漆黑的生物扭曲脖颈，站在巷口的吊灯上，用包含恶意的眼神俯视着你。那重影般的头颅，似乎共用着同一个浸没在融蚀浆中的身体。"
  },
  Event_6923_Name = {
    Text = "提灯黑鸦"
  },
  Event_6924_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6924_Desc = {
    Text = "不要恐惧污秽，你从中获取的比失去的更多。"
  },
  Event_6924_Name = {
    Text = "草垛之后"
  },
  Event_6925_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6925_Desc = {
    Text = "灵知的风暴环绕在图鲁周身，你与他对视一眼，前后脚深入黑暗。"
  },
  Event_6925_Name = {
    Text = "代行者的承诺"
  },
  Event_6926_ChoiceDesc1 = {
    Text = "【进入】穿过迷雾，抵达另一端。"
  },
  Event_6926_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_6926_Desc = {
    Text = "你坠入了一片黑暗之中。\n在视线的尽头，只有一缕光线，从狭小如钥匙孔的缝隙中透出。\n银钥匙发出呼吸般的微光，指引你踏入那条密道。"
  },
  Event_6926_Name = {
    Text = "单行密道"
  },
  Event_6927_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得造物：(「(RelicConfig.Arg2)」】"
  },
  Event_6927_ChoiceDesc2 = {
    Text = "【从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6927_Desc = {
    Text = "事件203（开发中），非最终效果"
  },
  Event_6927_Name = {
    Text = "事件203（开发中）"
  },
  Event_6928_ChoiceDesc1 = {
    Text = "【拼补】删除一张指令卡，获得造物：「(RelicConfig.Arg1)」"
  },
  Event_6928_ChoiceDesc2 = {
    Text = "【抚摸】删除一张打击/防御卡，获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6928_ChoiceDesc3 = {
    Text = "【厌恶】获得25黑印"
  },
  Event_6928_Desc = {
    Text = "「你喜欢我的残躯吗？可以的话，能请你帮我拼凑身体吗？」\n只剩下半边身子的石膏像嘴唇瓮动，如轻纱落在耳畔的柔弱嗓音，从她本该坚硬冰凉的唇齿中溢出。"
  },
  Event_6928_Name = {
    Text = "拼凑残躯"
  },
  Event_6929_ChoiceDesc1 = {
    Text = "【丢弃信封】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6929_ChoiceDesc2 = {
    Text = "【揣进怀里】感染「(Skill.Arg1)」，获得造物：「(RelicConfig.Arg2)」"
  },
  Event_6929_Desc = {
    Text = "这是一封求救的信件，写信者竭力保持镇静，那时而歪斜的笔迹，却将他深藏的恐惧展露无遗。\n「这一切完全超出了的预料，如果现在有人说我深中诅咒，我发誓一定深信不疑。」\n「有人说我是疯子，他只说对了一半，我正在在疯癫的边界摇摇欲坠。」\n「但我真的看到了！它在变异和消散，增殖的黑漆漆黏着物试图往我全身攀爬！」\n「我逃了！逃得飞快，但注视的目光从未从我身上移开，我有预感，它一定会找到我！那可憎的黑泥会再次灌入我的头骨，无论是谁收到了信，求求你，救我——」"
  },
  Event_6929_Name = {
    Text = "一封求救信"
  },
  Event_6930_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6930_Desc = {
    Text = "「冷静，」拉蒙娜敲了敲你的脑袋，「只是往昔的碎片。不知道是谁遗落在这条维度通道的。」\n确实，有股怀念的味道。"
  },
  Event_6930_Name = {
    Text = "紧急通讯"
  },
  Event_6931_ChoiceDesc1 = {
    Text = "【随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_ChoiceDesc2 = {
    Text = "【随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_ChoiceDesc3 = {
    Text = "【随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_6931_Desc = {
    Text = "事件205（开发中），非最终效果"
  },
  Event_6931_Name = {
    Text = "事件205（开发中）"
  },
  Event_6932_ChoiceDesc1 = {
    Text = "【获得造物：(「(RelicConfig.Arg1)」】"
  },
  Event_6932_ChoiceDesc2 = {
    Text = "【获得造物：(「(RelicConfig.Arg1)」】"
  },
  Event_6932_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_6932_Desc = {
    Text = "事件204（开发中），非最终效果"
  },
  Event_6932_Name = {
    Text = "事件204（开发中）"
  },
  Event_6933_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6933_Desc = {
    Text = "孤月高悬于天，你却能听清它祝祷的颂词，古怪的音调，像极了污秽之物的细语呢喃。\n祷告停止，你正要离开。身后却亮起一道白色的虚影。\n「窥伺命运和祝祷的亵渎之人，恩赐与代价都将如约而至。」"
  },
  Event_6933_Name = {
    Text = "银月碎片"
  },
  Event_6934_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6934_Desc = {
    Text = "背后传来清脆的碎裂声响，你沉吟片刻，转身离开。"
  },
  Event_6934_Name = {
    Text = "银月碎片"
  },
  Event_6935_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6935_Desc = {
    Text = "掬于掌心的一捧月光，被洒落在石碑上。\n有人被埋在了厚重的淤泥之下，旁观的人群声称，此人迎来了自然凋亡，将安眠于地下。\n可那埋藏的淤泥涌动，惨叫声中，却爬出了一团瘫软的月亮。"
  },
  Event_6935_Name = {
    Text = "银月碎片"
  },
  Event_6936_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6936_Desc = {
    Text = "不过是挣扎求生的生灵，求得一块歇脚的浮木罢了……\n你叹息一声，任由蝴蝶尾部的黑浆流淌。"
  },
  Event_6936_Name = {
    Text = "不应存在之物"
  },
  Event_6937_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6937_Desc = {
    Text = "这是一场事先张扬的陷阱，而你，深知它的危险。\n相较于首饰，你本人——显然是更为珍稀的宝石。"
  },
  Event_6937_Name = {
    Text = "翻覆魔爪"
  },
  Event_6938_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_6938_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_6938_Name = {Text = "析出点"},
  Event_6939_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6939_Desc = {
    Text = "你应下请求，却遇到了一点小小的问题。\n「那尊蜡像……是什么样子的？」\n「那是我的半身，当然和我长得一模一样了。」\n「可是……」\n「您的脸，早就彻底烂掉了啊。您不知道吗？」"
  },
  Event_6939_Name = {
    Text = "我的半身"
  },
  Event_6940_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6940_Desc = {
    Text = "你紧紧握住了身侧同伴的手，拉蒙娜侧目对你投来了疑惑的目光，但她最终默许了你的失礼。"
  },
  Event_6940_Name = {
    Text = "梦境祷文"
  },
  Event_6941_ChoiceDesc1 = {
    Text = "【问它是谁】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6941_ChoiceDesc2 = {
    Text = "【与它对视】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_6941_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_6941_Desc = {
    Text = "强烈的被注视的感觉让你停下脚步。\n「是谁？」你在浓雾中张望，「詹金，是你吗？」\n雾气茫茫，庭院深处隐隐传来融蚀体的尖叫。你一无所获，只能回头，却险些撞上一只悬在空中的眼睛。"
  },
  Event_6941_Name = {
    Text = "盲目注视"
  },
  Event_6942_ChoiceDesc1 = {
    Text = "【不碰硬币】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6942_ChoiceDesc2 = {
    Text = "【触碰硬币】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_6942_Desc = {
    Text = "你捡到了一枚陷入黑泥的古币。\n它一面镂空刻着青红相间的血管，一面用浮雕工艺细细描画了纯白色的头像——纤尘不染的女公爵噙着笑，凝视着你的苍白眼珠翕动了一瞬，开始胡乱转动。"
  },
  Event_6942_Name = {
    Text = "双面古币"
  },
  Event_6943_ChoiceDesc1 = {
    Text = "【转身】获得25黑印"
  },
  Event_6943_ChoiceDesc2 = {
    Text = "【继续前行】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6943_Desc = {
    Text = "又来了，那个奇怪的脚步声。\n它紧跟在你身后，从工作室到馆长室，再从馆长室到地下室。\n你知道那是个谨慎的家伙。\n他小心翼翼地维持着你们之间的距离，使其不至于太远，但也不会令人感到冒犯。\n但你还是被深深地困扰了。"
  },
  Event_6943_Name = {Text = "脚步声"},
  Event_6944_ChoiceDesc1 = {
    Text = "【观察它】可以获得25黑印"
  },
  Event_6944_ChoiceDesc2 = {
    Text = "【抚摸它】50%机会获得50黑印，50%机会一无所有"
  },
  Event_6944_Desc = {
    Text = "小巷中突然蹿出一只黑猫，异常亲热地缠绕在你们的脚边，幽绿的竖瞳闪烁着令人不寒而栗的光芒，仿佛在说「别追了，陪我玩一会儿吧。」\n 「你已经看见祂了，祂就在你的身侧，那些被疯狂污染的，狂热的影子……不要直视祂的轮廓。」"
  },
  Event_6944_Name = {
    Text = "夜色精灵"
  },
  Event_6945_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6945_Desc = {
    Text = "唤醒体们等待着你的指令，你无暇他顾。"
  },
  Event_6945_Name = {
    Text = "来自角度"
  },
  Event_6946_ChoiceDesc1 = {
    Text = "【检查胶片】感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」"
  },
  Event_6946_ChoiceDesc2 = {
    Text = "【检查相机】获得50黑印"
  },
  Event_6946_Desc = {
    Text = "像拉出一截内脏般，相机肚子里的胶片被扯得稀烂，开膛破肚地丢弃在这里，无人问津。\n一道刺目的白光闪过，遗弃在街角的相机歪斜着，快门被凭空按动。\n「咔擦——」\n你那错愕的、愣怔的神情，被忠实记载于相机中的胶卷上。"
  },
  Event_6946_Name = {
    Text = "记录无罪"
  },
  Event_6947_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6947_Desc = {
    Text = "只是风摇晃铁锁的声音罢了，没什么好在意的，不必理会。"
  },
  Event_6947_Name = {
    Text = "铁门之后"
  },
  Event_6948_ChoiceDesc1 = {
    Text = "【选择】感染「(Skill.Arg1)」"
  },
  Event_6948_ChoiceDesc2 = {
    Text = "【选择】感染「(Skill.Arg1)」"
  },
  Event_6948_ChoiceDesc3 = {
    Text = "【选择】感染「(Skill.Arg1)」"
  },
  Event_6948_Desc = {
    Text = "「我」是独一无二的我，自千万宇宙中，绝无仅有。"
  },
  Event_6948_Name = {
    Text = "灵魂共振"
  },
  Event_6949_ChoiceDesc1 = {
    Text = "【领取】选择1个白银造物"
  },
  Event_6949_Desc = {
    Text = "那或许是「我」。\n穿越时间之影，穿越维度壁垒，透过一线裂缝与我对视的「我」。"
  },
  Event_6949_Name = {
    Text = "灵魂共振"
  },
  Event_6950_ChoiceDesc1 = {
    Text = "【指出问题】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_6950_ChoiceDesc2 = {
    Text = "【咽下疑问】感染「(Skill.Arg1)」，重新刻印，还能再进行1次"
  },
  Event_6950_Desc = {
    Text = "这对少女而言，也是难言之隐。\n你咽下了疑问，她却抚着心口娓娓道来，说着一场持续二十五年的长梦，说着梦醒后自己的孤立无援。"
  },
  Event_6950_Name = {
    Text = "被禁锢的生命"
  },
  Event_6951_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6951_Desc = {
    Text = "你将纸张与碎木屑投入火苗里。火苗贪婪地将它们吞吃入腹，并满足地打了一个饱嗝。它已经准备好要去毁灭世界了，临走前不忘给了你一点祝福。"
  },
  Event_6951_Name = {
    Text = "微暗的火"
  },
  Event_6952_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6952_Desc = {
    Text = "你无情地踩灭了这仅存的仇恨火种，萦绕四周的怨恨与不甘似乎减轻了。"
  },
  Event_6952_Name = {
    Text = "微暗的火"
  },
  Event_6953_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得Arg1黑印，感染「(Skill.Arg2)」"
  },
  Event_6953_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_6953_Desc = {
    Text = "你想要抓住乌鸦，它却只是从卧室的这一头飞向那一头，然后继续发出诡异的叫声。乌鸦飞离之处，滴落的黑色黏液化为黑色的印记。"
  },
  Event_6953_Name = {
    Text = "提灯黑鸦"
  },
  Event_6954_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6954_Desc = {
    Text = "「你很会捕捉重点，」男人笑容满溢，「那是这世上最美味的口粮，值得每一位饕餮小心料理，细心品鉴。」\n「很遗憾，这次没办法请你尝试了。作为补偿，我身上也有些其他美味佳肴，就送给你吧。」\n说完，男人抛下一块嫩红色的软肉。软肉砸在桥面上，黏腻的触肢扭曲地蠕动着。你再抬头去看时，男人的身影已经隐没在错综的钢架后，无迹可寻。"
  },
  Event_6954_Name = {
    Text = "怪异旅伴Ⅵ"
  },
  Event_6955_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6955_Desc = {
    Text = "抽丝剥茧，层层递进，这是你的拿手好戏。\n灵感的闪光让大脑格外清明，你得以看清目前的现实——\n不管是谁在幕后操纵着木偶，逃出去，活下来。"
  },
  Event_6955_Name = {
    Text = "灵感迸发"
  },
  Event_6956_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6956_Desc = {
    Text = "蝴蝶在你的掌心碎裂，如同被猛然击碎的玻璃天花板，破缺的残片向着地心引力坠落，坠落，坠落——"
  },
  Event_6956_Name = {
    Text = "铁路的幻觉"
  },
  Event_6957_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6957_Desc = {
    Text = "见拉蒙娜不愿靠近，猫摇了摇头，化作一道阴影原地消散。"
  },
  Event_6957_Name = {
    Text = "游走的住民"
  },
  Event_6958_ChoiceDesc1 = {
    Text = "【许下承诺】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6958_ChoiceDesc2 = {
    Text = "【拒绝】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6958_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_6958_Desc = {
    Text = "「那真是一段难忘的回忆。 \n我的头和四肢被用力摁进石膏里。\n窒息和濒死的幻觉将我深深包裹，又将我用力拽起，抛在黑暗的海岸上。\n我看着它，感到自己的一部分也被一齐夺走了。 \n那失落的另一半灵魂，自此便寄居在那尊小小的，最初的蜡像里。 \n所以……你能帮我找到我的半身吗？」"
  },
  Event_6958_Name = {
    Text = "我的半身"
  },
  Event_6959_ChoiceDesc1 = {
    Text = "【离开】获得3选1高级刻印"
  },
  Event_6959_Desc = {
    Text = "你是记忆的旁观者，只能眼睁睁看着少女向无光之海坠落。\n水流将裙摆向上推，她却在下沉，像极了一支未开的花。"
  },
  Event_6959_Name = {Text = "沉海"},
  Event_6960_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_6960_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_6960_Name = {Text = "析出点"},
  Event_6961_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6961_Desc = {
    Text = "不必理会敌人的诱惑，说不定是某种陷阱。"
  },
  Event_6961_Name = {
    Text = "诅咒怪鸦"
  },
  Event_6962_ChoiceDesc1 = {
    Text = "【帮助他】"
  },
  Event_6962_ChoiceDesc2 = {
    Text = "【冷眼旁观】"
  },
  Event_6962_Desc = {
    Text = "男孩站在舞台上，惨白的灯光打在他脸上。\n「献、献给……」\n男孩涨红了脸。他张开嘴，却发不出一个音节。\n黑洞洞的嘴越张越大，越张越大……"
  },
  Event_6962_Name = {
    Text = "终幕礼Ⅲ"
  },
  Event_6963_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6963_Desc = {
    Text = "「好可恶，好可恶！」像是被你触碰到某个开关，黑猫忽然凶相毕露，张口咬向你的胳膊，幸亏你躲避及时，只咬坏一节衣角。黑猫蹿向街角，消失在巷子的下水道中。"
  },
  Event_6963_Name = {
    Text = "夜色精灵"
  },
  Event_6964_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6964_Desc = {
    Text = "被脑中那些翻涌的浆水裹挟着，你推开门，踏上了一条不归的道路。\n门外炽热的白光，是救赎，抑或是毁灭？"
  },
  Event_6964_Name = {
    Text = "重门之外"
  },
  Event_6965_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6965_Desc = {
    Text = "你大着胆子上前查看，覆盖在桌面上的黏液突然裂开，露出底下的东西来。"
  },
  Event_6965_Name = {
    Text = "重门之外"
  },
  Event_6966_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6966_Desc = {
    Text = "咽下口水，压下疑问，专心迎敌。\n让蝴蝶暂时停留在身体中，即使它的振翅会将你的器官划得支离破碎。"
  },
  Event_6966_Name = {
    Text = "蝴蝶效应"
  },
  Event_6967_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_6967_Desc = {
    Text = "猫满意地点点头，随即化作一道阴影原地消散，留下了几个黑色的圆形物件。"
  },
  Event_6967_Name = {
    Text = "游走的住民"
  },
  Event_6968_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_6968_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_6968_Name = {Text = "析出点"},
  Event_6969_ChoiceDesc1 = {
    Text = "【离开】获得1个随机黄金造物，感染「(Skill.Arg1)」"
  },
  Event_6969_Desc = {
    Text = "见你仍在犹疑，库姆扑向土堆，用两只前爪快速地刨出了什么，推到你的面前。"
  },
  Event_6969_Name = {
    Text = "深埋之物"
  },
  Event_6970_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6970_Desc = {
    Text = "纸张上端正地印着「梅里美」，从来就没有什么梅森。\n疑心病太重可不是好征兆啊，守密人。"
  },
  Event_6970_Name = {Text = "打字机"},
  Event_6971_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_6971_Desc = {
    Text = "土堆中掩埋着雕塑家协会罄竹难书的罪恶。"
  },
  Event_6971_Name = {
    Text = "深埋之物"
  },
  Event_6972_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6972_Desc = {
    Text = "禽鸟之间自有规则，它们不依照你的意志而行动，你也无权干涉自然的规律。"
  },
  Event_6972_Name = {
    Text = "离群之鸦"
  },
  Event_6973_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_6973_Desc = {
    Text = "为什么呢，为什么会沉呢？\n那一天没有雷雨，没有风暴。夜空澄净如洗，一颗星星都没有，满月低垂在海平面之上，犹如冰冷的太阳。"
  },
  Event_6973_Name = {Text = "沉海"},
  Event_6974_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6974_Desc = {
    Text = "「列车长！我们遭遇了恐怖袭击！……嗞啦……」\n看来是驾驶员的通报电话，你本打算就此挂机。\n「重复一遍，这里是弥萨格外勤组第四小队，我们在搭乘北线夜间特快列车护送救援人质的途中遭遇了……咿啊！」\n电话中的语调变成嘶哑的低语，夹杂着令人毛骨悚然的刺耳尖叫。\n「圣礼已成。迷途的羔羊啊，愿这神圣的沐浴荡涤你的灵魂……」"
  },
  Event_6974_Name = {
    Text = "列车来电"
  },
  Event_6975_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6975_Desc = {
    Text = "搜集银芯也是守密人的工作之一。\n漂流在纯白晶体内的灵魂，未来将以全新的面貌重返世间。"
  },
  Event_6975_Name = {
    Text = "被缚的灵魂"
  },
  Event_6976_ChoiceDesc1 = {
    Text = "【继续坠落】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，是否继续下坠"
  },
  Event_6976_ChoiceDesc2 = {
    Text = "【抽身离开】获得25黑印"
  },
  Event_6976_Desc = {
    Text = "「你」邀请着你。\n在螺旋的深处，过去与未来的「你」向你送上了来自不同维度的「赠礼」。"
  },
  Event_6976_Name = {
    Text = "螺旋深渊"
  },
  Event_6977_ChoiceDesc1 = {
    Text = "【弯腰探出】感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」"
  },
  Event_6977_ChoiceDesc2 = {
    Text = "【放弃查看】获得50黑印"
  },
  Event_6977_Desc = {
    Text = "手术台的底层似乎夹着一卷胶片。"
  },
  Event_6977_Name = {
    Text = "记忆光影"
  },
  Event_6978_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6978_Desc = {
    Text = "拒绝干扰，专注眼前。\n你还有更重要的事情要做。"
  },
  Event_6978_Name = {
    Text = "我的半身"
  },
  Event_6979_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6979_Desc = {
    Text = "遗失的圣器，价值连城的传承遗物，实现愿望的仪器……\n或许只有宝物才会如此诱人。"
  },
  Event_6979_Name = {
    Text = "谜团输入法"
  },
  Event_6980_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6980_Desc = {
    Text = "「你是莉莉的『妈妈』，却只将她作为研究和战斗的工具驱使，」你回应道，「幼年的孩子或许会服从母亲，但你不该是莉莉的『妈妈』。」"
  },
  Event_6980_Name = {
    Text = "她的选择"
  },
  Event_69813_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_69813_Desc = {
    Text = "银钥匙辉光闪烁，手臂们似被某种力量震慑，纷纷隐入池水，然后消失不见。"
  },
  Event_69813_Name = {
    Text = "血污之池"
  },
  Event_69814_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_69814_Desc = {
    Text = "你越陷越深，脑海中响起无上意志混乱的低语。你闭上眼，调用自己体内的权柄。\n忽然之间，一切声音与异常的触感都消失了，你站在门扉之后，身边的血色触手无影无踪，仿佛从未存在过。\n你感到浑身畅快。你明白你付出的代价，但这无足轻重——你将以更强的形态，面对那至高的存在。"
  },
  Event_69814_Name = {
    Text = "血污之池"
  },
  Event_69815_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_69815_Desc = {
    Text = "你用记忆所塑造出的唤醒体未有片刻迟疑，将你拽出了血污之池，连接着你的手臂被撕裂，混浊的泥水飞溅，水中无数肉眼难以分辨的生物蠕动着，原初的造物主与毁灭者，正渴求着吞噬。"
  },
  Event_69815_Name = {
    Text = "血污之池"
  },
  Event_69816_ChoiceDesc1 = {
    Text = "【呼唤唤醒体】扣除所有唤醒体 100 狂气，删除 1 张症状卡"
  },
  Event_69816_ChoiceDesc2 = {
    Text = "【吸收血池】提高 Arg1 点最大生命，感染2张「(Skill.Arg2)」"
  },
  Event_69816_ChoiceDesc3 = {
    Text = "【插入银钥匙】清空所有银钥能量"
  },
  Event_69816_Desc = {
    Text = "生命的权柄，在原初的眼中以死亡的形态呈现。在你踏上这处影影绰绰的地界时，腥臭的血污池瞬间现出了真身。\n赤黑色的血污伸出不可计数的手臂，攀附在你的脚踝，不断向上攀扯，意图将你拖入不可测的深渊。"
  },
  Event_69816_Name = {
    Text = "血污之池"
  },
  Event_6981_ChoiceDesc1 = {
    Text = "【拾取钥匙】"
  },
  Event_6981_Desc = {
    Text = "一串锈迹斑斑的钥匙。可用于开启门锁。"
  },
  Event_6981_Name = {
    Text = "锈蚀钥匙"
  },
  Event_6982_ChoiceDesc1 = {
    Text = "【离开】选择复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_6982_Desc = {
    Text = "在船歌和希莱斯特的指引下，你看向了幽深无光的船舱深处——你们的生机，是否就在那无边的黑暗中？"
  },
  Event_6982_Name = {Text = "船歌"},
  Event_6983_ChoiceDesc1 = {
    Text = "【一起离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_6983_ChoiceDesc2 = {
    Text = "【拒绝离开】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_6983_Desc = {
    Text = "是幻觉吗？你见到乌鸦盘旋在上空，哼唱着一曲熟悉的歌谣：\n「那么就一起离开吧，我和你\n趁黑夜刚落下帷幕\n像一个濒死的酒鬼倒在大街上」"
  },
  Event_6983_Name = {
    Text = "群鸦之声"
  },
  Event_6984_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6984_Desc = {
    Text = "追溯之力短时间内无法再次为你寻找联络点，可你至少获得了暂时的抚慰。"
  },
  Event_6984_Name = {
    Text = "异常联络"
  },
  Event_6985_ChoiceDesc1 = {
    Text = "【坠入螺旋】向螺旋的尽头眺望"
  },
  Event_6985_ChoiceDesc2 = {
    Text = "【抽身离开】获得25黑印"
  },
  Event_6985_Desc = {
    Text = "舷窗外已经看不见海面了。\n玻璃映照出你苍白的脸，而在你的瞳孔中，「你」也凝视着舷窗。\n现实与密境重叠、交织，最终扭曲成交错的多重螺旋。"
  },
  Event_6985_Name = {
    Text = "螺旋深渊"
  },
  Event_6986_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6986_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_6986_Name = {Text = "联络点"},
  Event_6987_ChoiceDesc1 = {
    Text = "【表示肯定】"
  },
  Event_6987_ChoiceDesc2 = {
    Text = "【表示否定】"
  },
  Event_6987_ChoiceDesc3 = {
    Text = "【不置可否】"
  },
  Event_6987_Desc = {
    Text = "「好久不见，朋友们。」你们从与提灯教众的战斗中脱身，获得稍许喘息的机会，突然发现那个长发的男人再次出现在道路旁，向你们微笑着打招呼，仿佛刚才的战斗从未发生过。\n「跟上次见面时相比，你身上刻耳柏洛斯的味道变得浓郁了许多。这段时间，你肯定去了很远的地方吧？」\n"
  },
  Event_6987_Name = {
    Text = "怪异旅伴Ⅴ"
  },
  Event_6988_ChoiceDesc1 = {
    Text = "【向他问路】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6988_ChoiceDesc2 = {
    Text = "【离开它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6988_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_6988_Desc = {
    Text = "影子站在瘦长的路灯下。\n「方便借个火吗，先生。」\n你没有@2的习惯，但你不介意使用一点小小的「魔法」。\n在你的帮助下，影子将点燃的@2深入那看不见底的黑色漩涡里。\n不一会，你便看见白色的烟雾蒸腾而出。\n「啊——」\n影子发出愉悦的叹息声。"
  },
  Event_6988_Name = {
    Text = "路灯下的身影"
  },
  Event_6989_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_6989_Desc = {
    Text = "棋盘之中，所见非真\n\n阻挡你前进的也许并不是墙壁，而是你枯竭的好奇心。"
  },
  Event_6989_Name = {
    Text = "幻影空间"
  },
  Event_6990_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6990_Desc = {
    Text = "「我好痛，好痛啊……莎莎姐姐……」\n你看向莎拉，她紧张地护着两个孩子，似乎是没有听见。\n声音逐渐消散。"
  },
  Event_6990_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_6991_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_6991_Desc = {
    Text = "你起身向男孩鼓掌。 \n似乎是感受到你的鼓励，男孩挺起小小的胸脯。 \n黑色的血自口中不断涌出，却再也无法阻挡歌声。"
  },
  Event_6991_Name = {
    Text = "终幕礼Ⅳ"
  },
  Event_6992_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6992_Desc = {
    Text = "一部分的悲伤正在蒸发，可泪水却仍不停歇地流向奇诡往世。"
  },
  Event_6992_Name = {
    Text = "冥滩之泪"
  },
  Event_6993_ChoiceDesc1 = {
    Text = "【掐住歌者的喉咙】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_6993_ChoiceDesc2 = {
    Text = "【绊倒舞者的步伐】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_6993_ChoiceDesc3 = {
    Text = "【绕路离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_6993_Desc = {
    Text = "你被三个粘稠的人影挡住去路。\n一个人影唱着歌，声音嘶哑，歌词诡异，你捂住耳朵，绕开了它。\n一个人影跳着舞，动作僵硬，步伐犹疑，你闭上眼睛，躲开了它。\n一个人影吟着诗，韵律破碎，语句不通，你忍无可忍，于是——"
  },
  Event_6993_Name = {
    Text = "狭路上的恶徒"
  },
  Event_6994_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_6994_Desc = {
    Text = "一部分的愤怒正在沸腾，可泪水却仍不停歇地流向未知往世。"
  },
  Event_6994_Name = {
    Text = "冥滩之泪"
  },
  Event_6995_ChoiceDesc1 = {
    Text = "【置若罔闻】感染「(Skill.Arg1)」"
  },
  Event_6995_ChoiceDesc2 = {
    Text = "【转身离开】随机觉醒1名唤醒体"
  },
  Event_6995_Desc = {
    Text = "残酷的宿命匍匐在行者的脚下，路途如明镜光洁，背后有轻微的碎裂声响。\n究竟是谁踩碎了脚下的宿命？是虚妄，是陷阱，或仅仅只是呓语，是诳言……\n在你眼前，碎出了一道缓慢爬行的裂痕。\n<Italic:仿佛它将为觉醒的灵知沉沦。>"
  },
  Event_6995_Name = {
    Text = "爬行裂痕"
  },
  Event_6996_ChoiceDesc1 = {
    Text = "【进行试炼】感染「(Skill.Arg1)」，胜利获得1个黄金造物，失败获得50黑印"
  },
  Event_6996_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_6996_Desc = {
    Text = "你窥见过一些秘辛，从脚下那滩镜面般反光的黑浆中。\n它的倒影边缘模糊，周身萦绕着挥之不去的黑气，你感到莫名熟悉，却又辨认不清它究竟是何物。"
  },
  Event_6996_Name = {
    Text = "镜面之下"
  },
  Event_6997_ChoiceDesc1 = {
    Text = "【学猫叫】50%概率获得125黑印，50%概率感染「(Skill.Arg2)」"
  },
  Event_6997_ChoiceDesc2 = {
    Text = "【投喂食物】75%概率获得100黑印，25%概率感染「(Skill.Arg2)」"
  },
  Event_6997_ChoiceDesc3 = {
    Text = "【拔腿就跑】获得50黑印"
  },
  Event_6997_Desc = {
    Text = "你误入了黑猫的地盘。\n无数眼睛在黑暗中倏然睁开，带着探究、审视、戒备……唯独没有善意。\n祖母绿、琥珀黄、孔雀蓝……\n你仿佛置身一片闪耀的宝石之海。\n为了脱身，你——"
  },
  Event_6997_Name = {Text = "猫之城"},
  Event_6998_ChoiceDesc1 = {
    Text = "【关于达芙黛尔】随机2张指令卡分别获得刻印：「(EnchantConfig.Arg1)」，「(EnchantConfig.Arg2)」"
  },
  Event_6998_ChoiceDesc2 = {
    Text = "【关于地狱犬】获得诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_6998_ChoiceDesc3 = {
    Text = "【关于莉莉】感染「(Skill.Arg1)」"
  },
  Event_6998_Desc = {
    Text = "「这里是达芙黛尔的提示时间。」"
  },
  Event_6998_Name = {
    Text = "提示时间"
  },
  Event_6999_ChoiceDesc1 = {
    Text = "【放任指针】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6999_ChoiceDesc2 = {
    Text = "【摁住指针】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_6999_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_6999_Desc = {
    Text = "咔擦，咔嚓，咔——\n宿命的指针寸寸拨动，机括的弹响声冷漠挪移着，向那个你绝对不愿看到的方向狂奔而去。"
  },
  Event_6999_Name = {
    Text = "针端之外"
  },
  Event_7000_ChoiceDesc1 = {
    Text = "【置若罔闻】从牌库中随机获取3张指令卡，选择1张卡进行删除，获得75黑印"
  },
  Event_7000_ChoiceDesc2 = {
    Text = "【谨慎检查】从牌库中随机获取3张指令卡，选择1张卡的原始复制进入牌库，获得25黑印"
  },
  Event_7000_ChoiceDesc3 = {
    Text = "【转身离开】获得50黑印"
  },
  Event_7000_Desc = {
    Text = "残酷的宿命匍匐在行者的脚下，路途如明镜光洁，背后有轻微的碎裂声响。\n究竟是谁踩碎了脚下的宿命？是虚妄，是陷阱，或仅仅只是呓语，是诳言……\n在你眼前，碎出了一道缓慢爬行的裂痕。"
  },
  Event_7000_Name = {
    Text = "爬行裂痕"
  },
  Event_7001_ChoiceDesc1 = {
    Text = "【呼唤乌鸦】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7001_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_7001_Desc = {
    Text = "利爪划破披风，深深陷入肩头。"
  },
  Event_7001_Name = {
    Text = "离群之鸦"
  },
  Event_7002_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7002_Desc = {
    Text = "恐惧有时候并不来源于实体。\n「地狱犬」所过之处，残留着红色的液滴，倒影出你的轮廓。"
  },
  Event_7002_Name = {
    Text = "无形倒影"
  },
  Event_7003_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7003_Desc = {
    Text = "伴随轻微的电流，你听到女子的低语。\n她哭泣着，一刻不停地讲述自己的遭遇。\n一小时过去，一天过去……直到你早已忘记她因何悲伤。\n最后她愉快地挂断电话，并许诺送你一份大礼。\n你收下了礼物。无论如何，礼物总是令人愉快的。"
  },
  Event_7003_Name = {
    Text = "请接电话"
  },
  Event_7004_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7004_Desc = {
    Text = "你在伙伴们不解的目光中，低头单膝跪地，又将右手握拳放在额头。\n很好，这样就能完美地遮住你的脸了。"
  },
  Event_7004_Name = {
    Text = "以假乱真"
  },
  Event_7005_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7005_Desc = {
    Text = "「你已为我披上面纱。」\n蜡像恬静地向你微笑。\n「我将真相献予你，作为辛勤劳作的奖励。」\n她的肚子不断淌出黑色粘液，将你紧紧包裹。\n世界漆黑一片，却无比温暖。\n你蜷缩着打了个哈欠，第@1次进入梦乡……"
  },
  Event_7005_Name = {
    Text = "未完的蜡像"
  },
  Event_7006_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7006_Desc = {
    Text = "你在迷雾中一无所获"
  },
  Event_7006_Name = {
    Text = "混沌迷雾"
  },
  Event_7007_ChoiceDesc1 = {
    Text = "【接起电话】获得3选1高级刻印"
  },
  Event_7007_ChoiceDesc2 = {
    Text = "【无视铃声】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7007_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7007_Desc = {
    Text = "「叮铃铃……」\n角落里传来刺耳的电话铃声，急促嘈杂，一声高过一声，几乎令你产生了一种错觉：如果你不接的话，它会立刻发疯爆炸，然后毁灭世界。"
  },
  Event_7007_Name = {
    Text = "请接电话"
  },
  Event_7008_ChoiceDesc1 = {
    Text = "【靠近幻影】获得3选1白银造物"
  },
  Event_7008_ChoiceDesc2 = {
    Text = "【打散幻影】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_7008_Desc = {
    Text = "是密境中的海市蜃楼吗？还是又一段无法离去的记忆？\n你揉了揉眼睛，远处的幻影向你靠近——是人声鼎沸的市场，是于融蚀中消失的蜡像馆，是风雪交加的小镇疯人院，还是风景早已模糊的阿库特？"
  },
  Event_7008_Name = {
    Text = "海市蜃楼"
  },
  Event_7009_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7009_Desc = {
    Text = "仿佛被滚水烫过一般，你条件反射地捂住了耳朵，将那些恶毒的乐声隔绝在外。"
  },
  Event_7009_Name = {
    Text = "禁忌音色"
  },
  Event_7010_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7010_Desc = {
    Text = "明亮的大调弹走了紧张与恐惧，你热情似火，你含苞待放，你欢欣雀跃，你大步流星把拉蒙娜远远甩在了身后——「守密人？！别走这么快！」"
  },
  Event_7010_Name = {
    Text = "无名之音"
  },
  Event_7011_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7011_Desc = {
    Text = "「停下步子！！！匍匐爬行的融蚀怪物都比你熟悉自己的四肢！」\n放过观众……\n你在心里这样祈祷。"
  },
  Event_7011_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7012_ChoiceDesc1 = {
    Text = "【抽身离开】"
  },
  Event_7012_Desc = {
    Text = "这只是密境。\n你想要保护的，所要逃离的，是独一无二的现实。"
  },
  Event_7012_Name = {
    Text = "螺旋深渊"
  },
  Event_7013_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7013_Desc = {
    Text = "「你才是最可恨的。」\n你将稿纸撕成碎片，扬在风中，碎成几团飞花。\n诗人仰头看着字符在风中纷飞，嘴角染上痴迷的弧度。\n「好美……」"
  },
  Event_7013_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7014_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7014_Desc = {
    Text = "你将海报整张撕了下来，发现背面潦草地记录着蜡像馆的各项开支。\n笔迹的主人显然没什么算术的耐心和天分，这些账目无论如何都抹不平。\n你草草看了一下，最大的开支应属「蜡像养护清洁」。\n员工开支则少得可怜，最近的花销是12支马鬃毛皮鞭，价格大约20坊。\n还有一项特殊的开支——「它们的食物」。\n「它们」是指谁？"
  },
  Event_7014_Name = {
    Text = "黑暗中的笑声"
  },
  Event_7015_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7015_Desc = {
    Text = "「狡猾……而正确的回答。」\n声音的主人对这个回答颇感兴趣，一个银色的物件被甩出水面。\n「记住，一切都有代价。」"
  },
  Event_7015_Name = {
    Text = "界外之音"
  },
  Event_7016_ChoiceDesc1 = {
    Text = "【抓住第二只蝴蝶】删除1张指令卡，获得Arg1黑印"
  },
  Event_7016_ChoiceDesc2 = {
    Text = "【不再流连】"
  },
  Event_7016_Desc = {
    Text = "祂们是精神维度的居民吗？还是自融蚀诞生的生命。\n怀着疑问，你走进一场蝴蝶的风暴。"
  },
  Event_7016_Name = {
    Text = "灵知风暴"
  },
  Event_7017_ChoiceDesc1 = {
    Text = "【观察第三只蝴蝶】删除1张指令卡，获得Arg1黑印"
  },
  Event_7017_ChoiceDesc2 = {
    Text = "【不再流连】"
  },
  Event_7017_Desc = {
    Text = "指间疼痛难耐，你猛地放开了手。"
  },
  Event_7017_Name = {
    Text = "灵知风暴"
  },
  Event_7018_ChoiceDesc1 = {
    Text = "【离开】获得25黑印，感染「(Skill.Arg1)」"
  },
  Event_7018_Desc = {
    Text = "「你们人类再没有别的答案了吗？」\n声音的主人发出不耐的低吼，整个空间随之震颤。\n「贪婪且无知……这便是我厌倦你们的原因了。」"
  },
  Event_7018_Name = {
    Text = "界外之音"
  },
  Event_7019_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7019_Desc = {
    Text = "「放心吧，我只是给了贪得无厌的客人一点小小的惩罚而已。没办法，谁让我不爱喝啤酒呢~」"
  },
  Event_7019_Name = {
    Text = "记忆碎片·啤酒"
  },
  Event_7020_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7020_Desc = {
    Text = "「别再唱了——」\n你警告五音不全的歌者，休想再来祸害你的耳朵。"
  },
  Event_7020_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7021_ChoiceDesc1 = {
    Text = "【离开】选择觉醒2名唤醒体"
  },
  Event_7021_Desc = {
    Text = "你转身离去，却迷失在长长的走廊中。 \n永无止境的回廊几乎耗尽你的全部耐心，直到你发现一个小小的破旧舞台。\n 你眨眨眼，舞台便消失了。"
  },
  Event_7021_Name = {
    Text = "终幕礼Ⅱ"
  },
  Event_7022_ChoiceDesc1 = {
    Text = "【拾起酒杯】获得特殊卡牌"
  },
  Event_7022_Desc = {
    Text = "一杯澄澈如夕阳余晖，摇曳如晚秋麦浪的金色液体，散发出如蜂蜜一般甜蜜诱人的香气。它是什么成分？是何人置于此处？为何无人照看？\n在这些问题得到解答之前，一个神秘的念头爬上你的脑海：你必须要立刻、马上喝掉它。\n此刻，你突然化身被火焰蛊惑的灯蛾，被猪笼草诱捕的飞虫，不可自抑地拾起那杯甜酒——"
  },
  Event_7022_Name = {
    Text = "蜂蜜甜酒"
  },
  Event_7023_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7023_Desc = {
    Text = "你试图检查这扇门扉，在触摸的时候，门扉竟然消失了，远处传来什么东西被开启的声音"
  },
  Event_7023_Name = {
    Text = "奇怪的门扉"
  },
  Event_7024_ChoiceDesc1 = {
    Text = "【不做处理】"
  },
  Event_7024_ChoiceDesc2 = {
    Text = "【拂去掌印】"
  },
  Event_7024_Desc = {
    Text = "弗朗西斯的办公室冰冷而整洁，呈现出主人的一丝不苟。\n在角落的盒子上，你发现了一枚5英寸见方的灰尘拓印。\n掌印的形状怪异——外围轮廓似是野兽的足印，中间却镶嵌着小小的人类女孩的手印。像是先留下了人类的掌印，然后野兽的巨掌覆盖其上。\n你当然可以幻想温馨的画面，例如某只驯服顺从的野兽将脚爪覆盖在女孩的手背，致以温柔的抚慰。\n但你知晓实情——那是某只被残忍实验融合的怪物留下的印痕。"
  },
  Event_7024_Name = {
    Text = "巨兽足印"
  },
  Event_7025_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7025_Desc = {
    Text = "游荡的实验体已经让你很是疲惫，短暂的喘息也像是干涸沙漠中的甘霖。"
  },
  Event_7025_Name = {
    Text = "无限之门"
  },
  Event_7026_ChoiceDesc1 = {
    Text = "【主人】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7026_ChoiceDesc2 = {
    Text = "【带走它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7026_ChoiceDesc3 = {
    Text = "【拆开它】获得50黑印"
  },
  Event_7026_Desc = {
    Text = "你正向前走着，脚边踢到了一个东西。\n那是个罗盘，玻璃罩已经破了，剩下的部分也沾满了融蚀浆，你小心地将它翻过来，依稀看到背面阴刻的弥萨格大学校徽。"
  },
  Event_7026_Name = {
    Text = "她的选择"
  },
  Event_7027_ChoiceDesc1 = {
    Text = "【阅读书信】删除1张指令卡，获得Arg1黑印"
  },
  Event_7027_ChoiceDesc2 = {
    Text = "【关好箱子】"
  },
  Event_7027_Desc = {
    Text = "一封，一封，又一封。\n信纸上写满了你的过去，又描绘着你的未来。受到异样的蛊惑，你止不住地撕扯、吞食着信纸。\n「喂？你又在发什么疯？喝空气？」\n墨菲一脚把你从幻觉中踢醒，回过神来，眼前什么都没有。"
  },
  Event_7027_Name = {
    Text = "不速来信"
  },
  Event_7028_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_7028_Desc = {
    Text = "听到你的声音，人影停了下来，克莱门汀的声音穿透水雾而来。\n「是你啊，」她的声音模模糊糊，朦朦胧胧，像是被水化开的月光，「不用担心，你会没事的，他想，但他做不到。」\n「等你结束这里，我们还会再见。」"
  },
  Event_7028_Name = {
    Text = "雾气中的身影"
  },
  Event_7029_ChoiceDesc1 = {
    Text = "【收件人：教务处】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7029_ChoiceDesc2 = {
    Text = "【收件人：搭档】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7029_Desc = {
    Text = "在写下收件人的刹那，信纸升腾起浓烟。无形的手穿越虚空，强硬地从你手中夺走了信纸——\n伴随一阵类似咀嚼的声响，身体倏地沉重了下来。\n但手中的造物告诉你，此行也并非全无收获。"
  },
  Event_7029_Name = {
    Text = "单向倾诉"
  },
  Event_7030_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_7030_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_7030_Name = {Text = "析出点"},
  Event_7031_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7031_Desc = {
    Text = "等他们从暗影中现身再说吧。"
  },
  Event_7031_Name = {
    Text = "提灯黑鸦"
  },
  Event_7032_ChoiceDesc1 = {
    Text = "【呼唤乌鸦】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7032_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_7032_Desc = {
    Text = "漆黑之鸟受到感召，它们身体膨胀，将什么东西吐在了你的手中。\n它们展翅回到桅杆之上，死死盯着你，目光灼灼。"
  },
  Event_7032_Name = {
    Text = "离群之鸦"
  },
  Event_7033_ChoiceDesc1 = {
    Text = "【进入洞穴】"
  },
  Event_7033_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7033_Desc = {
    Text = "「咳，咳咳……」\n好熟悉的声音……想起来了吱！\n人类生病或者快死的时候就会发出这种声音！\n快过去看看吱！"
  },
  Event_7033_Name = {
    Text = "洞穴深处"
  },
  Event_7034_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7034_Desc = {
    Text = "你曾学习过有关银芯的一切知识，包括如何鉴定它们的品阶。\n显然，这些银芯无法达到精炼的基础要求。\n你不得不放弃它们，以及可能被困在其中的破碎灵魂。\n学会舍弃也是守密人的必修课。"
  },
  Event_7034_Name = {
    Text = "被缚的灵魂"
  },
  Event_7035_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7035_Desc = {
    Text = "这是一个单向通道，你无法通过它回到入口"
  },
  Event_7035_Name = {Text = "通道"},
  Event_7036_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7036_Desc = {
    Text = "早结束，早安心。弥萨格的调查员从不畏惧危险。"
  },
  Event_7036_Name = {
    Text = "无限之门"
  },
  Event_7037_ChoiceDesc1 = {
    Text = "【请你让让，我有急事】"
  },
  Event_7037_ChoiceDesc2 = {
    Text = "【愿闻其详】"
  },
  Event_7037_Desc = {
    Text = "「这位同学，请留步。看你们面色凝重，行色匆匆，或许是陷入了某种困境吧。\n但人生不应当因为眼前的困局而放弃全盘的视角和冷静的头脑。\n比如我这几天认真想了想，刻耳柏洛斯的传说中有很多与现状不符之处。」"
  },
  Event_7037_Name = {
    Text = "怪异旅伴Ⅱ"
  },
  Event_7038_ChoiceDesc1 = {
    Text = "【接过礼物】"
  },
  Event_7038_ChoiceDesc2 = {
    Text = "【婉言谢绝】"
  },
  Event_7038_Desc = {
    Text = "男孩坐在窗台望着你。他已经等你很久了。\n「演出很成功，谢、谢你。」\n「我就要离开了……这是给你的礼物。」\n男孩向你摊开手。\n你看到一个包装精美的礼盒，鲜血从中流淌而出，染红了男孩的手。"
  },
  Event_7038_Name = {
    Text = "终幕礼Ⅵ"
  },
  Event_7039_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7039_Desc = {
    Text = "但愿你永远能有这样的自信。"
  },
  Event_7039_Name = {
    Text = "无形倒影"
  },
  Event_7040_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7040_Desc = {
    Text = "你收下了这枚小小的、柔软的耳朵。\n它裹在粘稠的油蜡里，安静地躺在你的掌心中央。\n你的心底升起一股强烈的责任感。\n首先酒吧是不能随便去的，那里的音乐过于秽乱。\n其次威灵顿花园剧院也不能去，那里的管弦乐早就老掉牙了。\n然后……\n你和你的同伴们很好地接受自己多了一个小宠物的事实。"
  },
  Event_7040_Name = {
    Text = "侧耳倾听"
  },
  Event_7041_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7041_Desc = {
    Text = "「阿利斯泰尔教授是弥萨格的基石，离开他，弥萨格的一切体系都将停止运转。」\n 你隐约记得某节令人昏昏欲睡的课堂上，诃勒特绷着脸敲着黑板说出这句话。\n如若这基石坍塌成碎块，你又当如何自处？ 巨大的恐惧笼罩了你。 \n「你要去哪儿？」拉蒙娜的呼唤声将你拉回现实。\n那是过去还是未来，是真实还是想象，或者是另一个维度的幻梦？你也不知道了。\n 你的手中，出现了一枚「赠礼」。"
  },
  Event_7041_Name = {
    Text = "混沌哀嚎"
  },
  Event_7042_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7042_Desc = {
    Text = "「这副轮椅就是我的第二双腿脚，这辈子大概都离不开它了，」阿利斯泰尔教授苦笑着，「可惜的是让我变矮了很多。」 \n\n所以，这不可能是真正的阿利斯泰尔教授。"
  },
  Event_7042_Name = {
    Text = "混沌哀嚎"
  },
  Event_7043_ChoiceDesc1 = {
    Text = "【是谁在说话？】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7043_ChoiceDesc2 = {
    Text = "【什么威士忌，给我也尝尝】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7043_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7043_Desc = {
    Text = "「你真的不尝一口吗？这可是上好的威士忌呢。要不是那家酒吧的老板大方地送了我一整瓶，我可一滴都舍不得分给你喝呢。」\n「所以说，你帮他赶走了那个干瘪瘦削的，皮肤像橡胶一样紧绷，只喝血腥玛丽的家伙，这是老板给你的全部酬劳。为那次调查你付出了一个月时间，走访了三十户人家，吃了十一个闭门羹，消耗了十七枚左轮子弹。一瓶威士忌，你连本都收不回来。」\n「好啦好啦，不要计较那么多嘛。至少，我们现在有这瓶威士忌，不是吗？」"
  },
  Event_7043_Name = {
    Text = "回忆碎片·威士忌"
  },
  Event_7044_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7044_Desc = {
    Text = "你拉住了唤醒体的触肢，他回头看着你，眼中闪过晦暗不明的光。\n他什么都没说，你却读懂了他潜藏的话语——\n「僭越。」"
  },
  Event_7044_Name = {
    Text = "蝴蝶效应"
  },
  Event_7045_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7045_Desc = {
    Text = "电报机已经彻底损坏。你能想象电报机的主人在风暴中的绝望……因为此刻的你也是。"
  },
  Event_7045_Name = {
    Text = "前人遗物"
  },
  Event_7046_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7046_Desc = {
    Text = "姓名：雷娅\n年龄：20\n并发症：渴血症伴随严重歇斯底里\n赘生物：深红触手@2口器\n嫁接物：直系血亲器官组织@3\n移交理由：没什么特别的理由。我不喜欢她。\n（后面的内容被划掉了）"
  },
  Event_7046_Name = {
    Text = "器官登记"
  },
  Event_7047_ChoiceDesc1 = {
    Text = "【选择「接受赐福」】失去所有黑印。获得1个黄金造物。"
  },
  Event_7047_Desc = {
    Text = "一团黑泥出现在你面前，颤巍巍递来一份文件。\n「我现在不方便出面......不过您可以了解一下我们的定制服务......」\n女声自黑泥胸腔内飘出，略显慌乱，似乎正在躲避什么东西。\n「仙女赐福根据会员档次生效，保证童叟无欺。」\n「签，快签！」"
  },
  Event_7047_Name = {
    Text = "仙女赐福"
  },
  Event_7048_ChoiceDesc1 = {
    Text = "【侧耳倾听】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7048_ChoiceDesc2 = {
    Text = "【上前查看】所有唤醒体回复50狂气，感染「(Skill.Arg1)」"
  },
  Event_7048_ChoiceDesc3 = {
    Text = "【直接离开】获得3选1刻印"
  },
  Event_7048_Desc = {
    Text = "「你知道吗？」在拉蒙娜搜寻神秘人的身影时，一个声音突然响起，像是谁在悄声议论，「你知道那个事儿吗？那个大事儿？」"
  },
  Event_7048_Name = {
    Text = "他人之耳"
  },
  Event_7049_ChoiceDesc1 = {
    Text = "【专注】删除最多2张症状卡。"
  },
  Event_7049_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_7049_ChoiceDesc3 = {
    Text = "【接通】回复 Arg2 点生命。"
  },
  Event_7049_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_7049_Name = {Text = "联络点"},
  Event_7050_ChoiceDesc1 = {
    Text = "【谨慎应对】提升 Arg1 点最大生命"
  },
  Event_7050_ChoiceDesc2 = {
    Text = "【迎上前】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7050_Desc = {
    Text = "密境幻化出的影子向你伸出了手， 身姿影影绰绰。\n你记得，曾有一名弥萨格调查员登上了这艘船，会是他吗？\n还是说，这只是又一个被密境束缚的可怜回忆。"
  },
  Event_7050_Name = {Text = "银钥使"},
  Event_7051_ChoiceDesc1 = {
    Text = "【离开】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7051_Desc = {
    Text = "「你看，因为我的一句闲话，就忽略了最紧急的情况，这可不好。\n再耽误下去，你们的猎物就要逃远了。\n为了表示抱歉，这些东西就送给你们吧。」\n\n男人自说自话地岔开话题，将某件物品递给你们。"
  },
  Event_7051_Name = {
    Text = "怪异旅伴Ⅱ"
  },
  Event_7052_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7052_Desc = {
    Text = "「祝你能得偿所愿。」\n男人不以为意，侧身让开一条道路。"
  },
  Event_7052_Name = {
    Text = "怪异旅伴Ⅱ"
  },
  Event_7053_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_7053_Desc = {
    Text = "一种近水银态的银色物质，由融蚀黏液中提炼而出，蕴含强大精神力，主要用于在仪式中链接更多唤醒体。"
  },
  Event_7053_Name = {Text = "银芯"},
  Event_7054_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7054_Desc = {
    Text = "你又走入新的岔路。\n太阳照常升起，人类照常死亡，而你照常迷路。\n没有什么是新鲜的。"
  },
  Event_7054_Name = {
    Text = "眼睛的迷宫"
  },
  Event_7055_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7055_Desc = {
    Text = "那似乎是被光折射出的扭曲的影子。"
  },
  Event_7055_Name = {
    Text = "桶中浮物"
  },
  Event_7056_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7056_Desc = {
    Text = "你转过身，只看到一双孤零零的皮鞋。\n「抱歉，我没有恶意。」\n「如果你见到我的身体，请帮我转告一声，它最忠实的步行伴侣正静候在1号展厅的45号陈列柜。」\n「——记住，是牛皮的那一双，不是山羊皮。」"
  },
  Event_7056_Name = {Text = "牛津鞋"},
  Event_7057_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7057_Desc = {
    Text = "一定是校友——你对着祂张开双臂，可随之而来的，是阴森入骨的疼痛。\n那疼痛消失后，四肢竟变得格外有力，前所未有。"
  },
  Event_7057_Name = {Text = "银钥使"},
  Event_7058_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7058_Desc = {
    Text = "你感受到眼前的迷雾似乎淡了\n\n你感觉接下来的行动中，自己的视线变得更敏锐了"
  },
  Event_7058_Name = {
    Text = "修罗试炼"
  },
  Event_7059_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7059_Desc = {
    Text = "幻影也向你靠近，记忆猛然回笼，眼前一片清明。"
  },
  Event_7059_Name = {
    Text = "海市蜃楼"
  },
  Event_7060_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7060_Desc = {
    Text = "祂的无意识仍在冥冥中改变了什么。"
  },
  Event_7060_Name = {
    Text = "祂的注视"
  },
  Event_7061_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7061_Desc = {
    Text = "危急当前，现在不是收集银芯的时候。"
  },
  Event_7061_Name = {
    Text = "存在的证明"
  },
  Event_7062_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_7062_Desc = {
    Text = "朦胧的人影逐渐清晰，那不是什么融蚀体，也不是灾厄，而是没有翅膀，神色如常的克莱门汀。\n「真巧啊，你也是来欣赏月光的吗？」她笑着说，你却感到一阵晕眩，「浓雾之夜，还是要多加小心哦。\n「这儿的小家伙们，可不怎么安分。」"
  },
  Event_7062_Name = {
    Text = "雾气中的身影"
  },
  Event_7063_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7063_Desc = {
    Text = "随着石膏块掷向地面的破裂声，她的躯体应声而碎。 不甘的嘶吼充斥着你的脑海里，但所幸，你及时悬崖勒马。"
  },
  Event_7063_Name = {
    Text = "补完残躯"
  },
  Event_7064_ChoiceDesc1 = {
    Text = "【聆听悲伤】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7064_ChoiceDesc2 = {
    Text = "【聆听喜悦】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_7064_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_7064_Desc = {
    Text = "悠扬、抒情、欢欣、哀伤……曲调在密境空间回荡，难以辨别其来源。\n这是幽灵船音响流淌出的奏鸣曲，还是被束缚在密境中的夜半狂想？"
  },
  Event_7064_Name = {
    Text = "无名之音"
  },
  Event_7065_ChoiceDesc1 = {
    Text = "【他们在寻找某个人】删除1张指令卡，获得25黑印"
  },
  Event_7065_ChoiceDesc2 = {
    Text = "【他们在寻找某件物品】复制一张牌库中的牌，感染「(Skill.Arg1)」"
  },
  Event_7065_Desc = {
    Text = "提灯教众为何会突然出现在拉伊小镇？这里的谜团太多了。\n地狱犬刻耳柏洛斯、拉伊疯人院院长弗朗西斯、雕塑家协会，提灯教会……\n一定有某个源头将他们汇聚在这个人丁并不兴旺的小镇。\n打字机突然自动喷发出油墨，仿佛引你前去输入什么。"
  },
  Event_7065_Name = {
    Text = "谜团输入法"
  },
  Event_7066_ChoiceDesc1 = {
    Text = "【紧闭双眼】"
  },
  Event_7066_ChoiceDesc2 = {
    Text = "【逃离现场】"
  },
  Event_7066_Desc = {
    Text = "演出戛然而止。你环顾四周，发现身边坐满了观众。\n它们长着和男孩一样的脸，正齐刷刷地看着你。\n啊——\n它们无声地朝你张开黑洞洞的嘴。"
  },
  Event_7066_Name = {
    Text = "终幕礼Ⅴ"
  },
  Event_7067_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7067_ChoiceDesc2 = {
    Text = "【检查胶卷】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，还可以使用一次"
  },
  Event_7067_Desc = {
    Text = "你将胶卷置于昏红的灯光下，半透明的片基隐约透出影像。\n手、脚、眼球、内脏……包含一切你能想象到的、想象不到的人体器官，都被忠实地记录在胶片中。\n它们被精心洗净、摆放，工整得如同你写的第一首格律诗。"
  },
  Event_7067_Name = {
    Text = "如实记录"
  },
  Event_7068_ChoiceDesc1 = {
    Text = "【公主的侍卫】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7068_ChoiceDesc2 = {
    Text = "【沉思者】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7068_Desc = {
    Text = "「嗒，嗒，嗒……」\n脚步声由远及近，眼看有人就要推开工作室的大门。\n你们退无可退，只能借着昏暗的光线假扮成蜡像，企图躲过那双审视之眼。"
  },
  Event_7068_Name = {
    Text = "以假乱真"
  },
  Event_7069_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7069_Desc = {
    Text = "「太好了，太好了！」声音充满了喜悦，「你终于变得和我一样了，莎莎姐姐！」"
  },
  Event_7069_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_7070_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7070_Desc = {
    Text = "或许是某个人将他们引至这里。\n随着你的探索，那个人的身份终将浮出水面。"
  },
  Event_7070_Name = {
    Text = "谜团输入法"
  },
  Event_7071_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7071_Desc = {
    Text = "早结束，早安心。弥萨格的调查员从不畏惧危险。"
  },
  Event_7071_Name = {
    Text = "无尽门扉"
  },
  Event_7072_ChoiceDesc1 = {
    Text = "【选择道德】回复 Arg1 点生命"
  },
  Event_7072_ChoiceDesc2 = {
    Text = "【选择生命】回复全部血量，感染「(Skill.Arg2)」"
  },
  Event_7072_Desc = {
    Text = "你或许曾有一颗金子般的心。\n它不分昼夜地鼓动着，为了你的生命和生活竭尽全力……温暖、热烈而充满希冀。\n可它不知何时，速度逐渐慢了下来。仿佛生命与道德，它只能再承受其一……"
  },
  Event_7072_Name = {
    Text = "诅咒渴望"
  },
  Event_7073_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7073_ChoiceDesc2 = {
    Text = "【检查胶卷】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，可以使用两次"
  },
  Event_7073_Desc = {
    Text = "「所以，你如实记录下了所有的一切。」\n「是的，胶卷里就是真相。」\n交谈的声音陡然停下，无数双无形的眼睛齐齐指向了你，似乎在等待你最后的判决。"
  },
  Event_7073_Name = {
    Text = "目击证言"
  },
  Event_7074_ChoiceDesc1 = {
    Text = "【离开】提升 Arg1 点生命，并获得25黑印"
  },
  Event_7074_Desc = {
    Text = "你的呼声被风的呼啸吞没。\n「你不必认识我，」夹杂在语句中的嘶嘶声愈发清晰，「赫伯特，赫伯特才是你们要找的人。让那家伙坠落吧，从虚假的幻梦里，坠入严酷冰冷的现实。」\n「我将赐福于你们，赐予你们这世间最美味的……」"
  },
  Event_7074_Name = {
    Text = "怪异旅伴Ⅵ"
  },
  Event_7075_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7075_Desc = {
    Text = "「是啊，可怜的迷失者，拥有力量却没能认清自己之人。\n你要施以援手吗？还是向祂举起武器呢？」\n男人纵身跃入湍急的流水，在他跃下的瞬间，你与他的视线恰好对上。那是一双滴落的蜂蜜般金黄的，属于蛇的竖瞳。\n而在他刚才站立的位置，留着一盏小小的，散发着紫色烟雾的灯。"
  },
  Event_7075_Name = {
    Text = "怪异旅伴Ⅵ"
  },
  Event_7076_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7076_Desc = {
    Text = "「谨慎是一种美德，但过度谨慎则是一种不合时宜，」一成不变的平稳声音中暗含不满，「星辰的运转会干扰唤醒体沉睡的本源，而恰当的时机能够让祂们的狂气像吹气球那样快速膨胀充盈起来。总之，现在还来得及抓住彗星的尾巴，下次记得优化你那和乌龟不分伯仲的反应速度。」"
  },
  Event_7076_Name = {Text = "仰角"},
  Event_7077_ChoiceDesc1 = {
    Text = "【回复】当前压力减少一半。"
  },
  Event_7077_Desc = {
    Text = "你接触了稳压舱，可以回复当前压力值"
  },
  Event_7077_Name = {
    Text = "压力稳定点"
  },
  Event_7078_ChoiceDesc1 = {
    Text = "【安慰她】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7078_ChoiceDesc2 = {
    Text = "【指责她】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7078_Desc = {
    Text = "「我是那死去调查员的阴影，凶手是那把银色的钥匙。」\n女子痛苦地捂住头。她的头发很浓密，上面有无数只亮晶晶的眼睛眨啊，眨啊……\n「他们总说：不行，夏洛特！唉，夏洛特！\n所以我想，如果我能一次性链接很多唤醒体，所有人都会闭嘴。」\n「然后……我也不知道发生了什么，醒来后我就成了这副模样。唉！」"
  },
  Event_7078_Name = {
    Text = "调查员的阴影"
  },
  Event_7079_ChoiceDesc1 = {
    Text = "【翻过高墙】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7079_ChoiceDesc2 = {
    Text = "【进入迷宫】随机1张卡牌获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7079_Desc = {
    Text = "你的大脑是一所迷宫。\n太多的念头纠缠其中，出口就在目光可及之处，思维的高墙林立于你们之间。"
  },
  Event_7079_Name = {
    Text = "思维迷宫"
  },
  Event_7080_ChoiceDesc1 = {
    Text = "【远望幻影】获得3选1白银造物"
  },
  Event_7080_ChoiceDesc2 = {
    Text = "【凑近幻影】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_7080_Desc = {
    Text = "远方似有火山锥喷发，狂风肆虐的天空中升腾起人形的烟雾。\n这可是艾尔沃斯，艾尔沃斯只有连绵不绝的高耸雪山和石灰石岩层的溶洞。\n是连日的异状让你精神错乱了吗？"
  },
  Event_7080_Name = {
    Text = "火山幻影"
  },
  Event_7081_ChoiceDesc1 = {
    Text = "【我看见了什么】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7081_ChoiceDesc2 = {
    Text = "【我什么都没看见】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7081_Desc = {
    Text = "你的眼底渗漏出液体，粘稠的触感让人心惊。\n归根究底，它因你所见之物而起，而你——真的什么都没看见吗？"
  },
  Event_7081_Name = {
    Text = "不可直视"
  },
  Event_7082_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7082_Desc = {
    Text = "你也会欢喜，也会忧愁，但此刻淹没你的不是你的情感。你捂住耳朵，银钥匙闪烁耀眼的光。\n终于，你能呼吸了。"
  },
  Event_7082_Name = {Text = "沉溺"},
  Event_7083_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7083_Desc = {
    Text = "持匕者发出了鸣叫，如午夜墓园的报丧鸟一般。\n声音转瞬即逝，连带另外两个蹈海者也不见踪影……原来只是密境映照出的一段幻象。"
  },
  Event_7083_Name = {
    Text = "穷追不舍"
  },
  Event_7084_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7084_Desc = {
    Text = "它就那么静静地悬在空中，一眨不眨，目光恳切，似乎是想告诉你什么。\n眼睛或许寄宿了灵魂，但如果没有言语，你也只能感到一丝急切，一丝悲伤。\n它凭空消散了。"
  },
  Event_7084_Name = {
    Text = "盲目注视"
  },
  Event_7085_ChoiceDesc1 = {
    Text = "【表示赞同】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7085_ChoiceDesc2 = {
    Text = "【送上礼物】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7085_ChoiceDesc3 = {
    Text = "【转身离开】获得25黑印"
  },
  Event_7085_Desc = {
    Text = "「如果有一天我必将坠落，那么我希望能落在水中。\n漫过鼻腔的流水像一场温柔的旧梦，\n我沉没的液体，\n是@2最渴望的碗盏。」"
  },
  Event_7085_Name = {
    Text = "水中祭典"
  },
  Event_7086_ChoiceDesc1 = {
    Text = "【抵抗幻觉】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7086_ChoiceDesc2 = {
    Text = "【汲取狂气】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_7086_Desc = {
    Text = "残缺的维度逐渐崩塌，其他维度的幻觉涌入病态的房间。"
  },
  Event_7086_Name = {
    Text = "维度幻象"
  },
  Event_7087_ChoiceDesc1 = {
    Text = "【离开】随机觉醒1名唤醒体"
  },
  Event_7087_Desc = {
    Text = "少女一怔，抬手在裙边抚过。\n「我能为你做的……只有这些了。」"
  },
  Event_7087_Name = {
    Text = "白裙少女"
  },
  Event_7088_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7088_Desc = {
    Text = "是谁在说话？\n你低下头，只看到一个模糊的倒影——它穿着与你相同的衣服，但手里握着一把刀，正在冲你露出微笑。"
  },
  Event_7088_Name = {
    Text = "你不会想要找到"
  },
  Event_70892_ChoiceDesc1 = {
    Text = "【顺应躯体的记忆】跳过战斗立即胜利，但失去 Arg1 点生命值。"
  },
  Event_70892_ChoiceDesc2 = {
    Text = "【离开】进入战斗"
  },
  Event_70892_Desc = {
    Text = "尽管敌人异常强大，但你已熟知战胜它们的技巧。"
  },
  Event_70892_Name = {
    Text = "肌肉记忆"
  },
  Event_7089_ChoiceDesc1 = {
    Text = "【拉开库姆】"
  },
  Event_7089_ChoiceDesc2 = {
    Text = "【攻击实验体】"
  },
  Event_7089_Desc = {
    Text = "库姆撕咬住一个实验体的后脖颈，正准备甩动，实验体突然像猫头鹰一样180°扭过头颅，朝着库姆的面部啄去。"
  },
  Event_7089_Name = {Text = "斗兽场"},
  Event_7090_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7090_Desc = {
    Text = "你握紧银钥匙，在维度的暗涌中感应本源的呼唤。\n为对抗正体不明的邪恶地狱犬，你必须尽可能借用一切可能的力量。"
  },
  Event_7090_Name = {
    Text = "维度幻象"
  },
  Event_7091_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7091_Desc = {
    Text = "「至于那个调查员，馆长大人打算亲自问讯……\n留活口……」\n声音逐渐低弱，最终隐入黑暗。"
  },
  Event_7091_Name = {
    Text = "隔墙有耳"
  },
  Event_7092_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7092_Desc = {
    Text = "失重感让你猛地清醒过来，脚下的地面坚实可靠，而在你脚边躺着的，是一块精致的方形镜子。"
  },
  Event_7092_Name = {Text = "镜中镜"},
  Event_7093_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7093_Desc = {
    Text = "你从不和已陷入疯狂、无药可救的人论辩，这会让你的灵魂在午夜的质问中被彻底吞噬，饶过你吧！"
  },
  Event_7093_Name = {
    Text = "水中祭典"
  },
  Event_7094_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7094_Desc = {
    Text = "蜡像的脸，应该是什么模样呢？\n你闭上双眼，脑海中浮现千万张模糊的脸孔。\n它们像一支支拖着苍白的火焰的蜡烛，在黑暗的河流中涌现、消失……\n你沿着河流走到尽头，那里伫立着唯一的、最后的蜡像。\n靠近它的时候，你看到了……@2。"
  },
  Event_7094_Name = {
    Text = "未完的蜡像"
  },
  Event_7095_ChoiceDesc1 = {
    Text = "【袭击持匕者】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_7095_ChoiceDesc2 = {
    Text = "【埋伏持刀者】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_7095_ChoiceDesc3 = {
    Text = "【绊倒持矛者】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7095_Desc = {
    Text = "三名蹈海者死死咬着你们不放，疯狂炙热的目光几乎要点燃你的斗篷。\n回头一瞥，你注意到他们三个各有不同——\n举着巨刀的蹈海者喊声最为暴躁，行事却有些漫不经心。\n手持长矛的蹈海者亦步亦趋，像牙牙学语的孩童。\n紧握匕首的蹈海者落在最后，口中喋喋吐出的祈祷证明了其狂热。"
  },
  Event_7095_Name = {
    Text = "穷追不舍"
  },
  Event_7096_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7096_Desc = {
    Text = "你接过礼物，小心翼翼地拆开。\n 一对眼球静静躺在礼盒里。 \n「我把我的眼睛送给你。」 \n「就像他曾经对我做的那样。」"
  },
  Event_7096_Name = {
    Text = "终幕礼Ⅵ"
  },
  Event_7097_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7097_Desc = {
    Text = "伸手穿过光辉的中心，你拾起了一滴固化的银芯。这滴记忆与灵魂的珍贵载体滚烫无比，折射着异样的色彩。\n在它将所有的光都扭曲搅匀前，火烧的灼痛让你忍不住将它重新投入了黑暗。"
  },
  Event_7097_Name = {
    Text = "暗夜荧光"
  },
  Event_7098_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_7098_Desc = {
    Text = "你拒绝了男孩的礼物。 \n男孩用他空洞的眼眶注视着你。他轻轻叹了一口气。\n 「那么，再见了。」 \n男孩说罢，向你摆出谢幕的姿势，然后倒向窗外。 \n他消失了，像一只翩然起舞的蝴蝶，又像一阵风。"
  },
  Event_7098_Name = {
    Text = "终幕礼Ⅵ"
  },
  Event_7099_ChoiceDesc1 = {
    Text = "选择普通刻印"
  },
  Event_7099_Name = {Text = "21"},
  Event_7100_ChoiceDesc1 = {
    Text = "【收下耳朵】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7100_ChoiceDesc2 = {
    Text = "【拒绝请求】获得3选1刻印"
  },
  Event_7100_Desc = {
    Text = "一连串华丽的音符自指尖倾泻而出。\n忧郁的蜡像钢琴师独坐窗前。\n自有意识起，蜡像馆就是他全部的世界。\n他长久闭塞，也想听点不一样的东西，尤其是……一种名为爵士的音乐。\n最后他撕下自己的一只耳朵，请求你将它带走。\n「让我听听外面的音乐吧……只需要把它装进口袋。」"
  },
  Event_7100_Name = {
    Text = "侧耳倾听"
  },
  Event_7101_ChoiceDesc1 = {
    Text = "【接通】回复 Arg2 点生命。[ExDesc1]"
  },
  Event_7101_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。[ExDesc1]"
  },
  Event_7101_ChoiceDesc3 = {
    Text = "【驱逐】移除最多 3 张症状卡，获得 Arg2 黑印。"
  },
  Event_7101_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_7101_Name = {Text = "联络点"},
  Event_7101_Tips3 = {
    Text = "当前并未拥有症状卡"
  },
  Event_7102_ChoiceDesc1 = {
    Text = "【接受挑战】"
  },
  Event_7102_ChoiceDesc2 = {
    Text = "【给祂一拳】获得25黑印"
  },
  Event_7102_Desc = {
    Text = "消瘦的人形自阴影浮现，挡住了你的去路。\n一段永远被束缚的记忆凭空闯入密境，自称「N」的虚影抛玩着手中筹码，用含糊不清的呜咽邀请你加入祂的游戏。\n三色筹码在你面前铺开，不和祂玩一局「游戏」，祂恐怕不会轻易放你离开。"
  },
  Event_7102_Name = {
    Text = "好戏开场"
  },
  Event_7103_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_7103_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_7103_Name = {Text = "析出点"},
  Event_7104_ChoiceDesc1 = {
    Text = "【挣扎着醒来】提高 Arg1 点最大生命"
  },
  Event_7104_ChoiceDesc2 = {
    Text = "【纵容自己沉眠】随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染2张「(Skill.Arg2)」"
  },
  Event_7104_Desc = {
    Text = "你怀里捧着一块晶亮的珍宝。\n它自胸口攀附向你的全身，那散发着烛火光芒的温热记忆，最终被倒灌入脑中。\n噼啪作响的炭火、炉边拥毯的安乐椅、醇厚的热茶和蜷在脚边的猫肚皮……\n在这舒适的困倦中，你头脑昏沉，坠入一片绵软。"
  },
  Event_7104_Name = {
    Text = "沉湎旧日"
  },
  Event_7105_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7105_Desc = {
    Text = "你毫不留情地扯出了另外半截胶片，它们藏身于相机肚内，骤然被拉出，上面的画面却叫你久久无言。\n未经冲洗的胶片，忠实地记录下了——你倒在一滩黑泥中的画面。"
  },
  Event_7105_Name = {
    Text = "记录无罪"
  },
  Event_7106_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7106_Desc = {
    Text = "你妥善检查了一番相机，皮革与黑金嵌在机体中，折射出几分油亮的光泽。\n它的镜头对准了你，仿佛在凝视，在窥探……"
  },
  Event_7106_Name = {
    Text = "记录无罪"
  },
  Event_7107_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7107_Desc = {
    Text = "掬于掌心的一捧月光，被洒落在石碑上。\n有人被埋在了厚重的淤泥之下，旁观的人群声称，此人迎来了自然凋亡，将安眠于地下。\n可那埋藏的淤泥涌动，惨叫声中，却爬出了一团瘫软的月亮。"
  },
  Event_7107_Name = {
    Text = "银月碎片"
  },
  Event_7108_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7108_Desc = {
    Text = "你轻轻触摸蝴蝶纤薄的黑翼，蝴蝶轻轻振翅，然后化作漆黑的液滴，落在你的掌心。"
  },
  Event_7108_Name = {
    Text = "不应存在之物"
  },
  Event_7109_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7109_Desc = {
    Text = "孤月高悬于天，你却能听清它祝祷的颂词，古怪的音调，像极了污秽之物的细语呢喃。\n祷告停止，你正要离开。身后却亮起一道白色的虚影。\n「窥伺命运和祝祷的亵渎之人，恩赐与代价都将如约而至。」"
  },
  Event_7109_Name = {
    Text = "银月碎片"
  },
  Event_7110_ChoiceDesc1 = {
    Text = "【三点】"
  },
  Event_7110_ChoiceDesc2 = {
    Text = "【六点】"
  },
  Event_7110_ChoiceDesc3 = {
    Text = "【一点】"
  },
  Event_7110_Desc = {
    Text = "看样子你今天的运气还不错。\n骰子颤动起来，发出兴奋的嗡鸣声。\n你决定猜一个点数"
  },
  Event_7110_Name = {
    Text = "无止境的赌局"
  },
  Event_7111_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7111_Desc = {
    Text = "这场赌局是个巨大的骗局！\n你「噌」地站起身，却感到一阵头晕目眩。\n骰子们发出鼓噪的嗡鸣声，充满魅惑的声音不断萦绕在你的脑海：\n「唯一一把……最后一把……」"
  },
  Event_7111_Name = {
    Text = "无止境的赌局"
  },
  Event_7112_ChoiceDesc1 = {
    Text = "【使用银芯】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7112_ChoiceDesc2 = {
    Text = "【收起银芯】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7112_ChoiceDesc3 = {
    Text = "【放回抽屉】获得25黑印"
  },
  Event_7112_Desc = {
    Text = "在办公桌右手边第二个的抽屉中，孤零零地摆放着一枚成型的银芯。轻轻触摸时，你听见了风暴的呼啸，夹杂着雪粒摩擦的粉碎声，夹杂着呜咽的笛声……"
  },
  Event_7112_Name = {
    Text = "孤独银芯"
  },
  Event_7113_ChoiceDesc1 = {
    Text = "【侧耳倾听】感染「(Skill.Arg1)」，获得诅咒造物-「(RelicConfig.Arg2)」"
  },
  Event_7113_ChoiceDesc2 = {
    Text = "【做出改变】选择销毁1个造物，获得1个奖励"
  },
  Event_7113_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7113_Desc = {
    Text = "不是所有乐曲都动人。\n纯粹的不协和音组成了一段悲鸣。"
  },
  Event_7113_Name = {
    Text = "不协和音"
  },
  Event_7114_ChoiceDesc1 = {
    Text = "【拾起它】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_7114_ChoiceDesc2 = {
    Text = "【放弃它】获得25黑印。"
  },
  Event_7114_Desc = {
    Text = "隐蔽腐臭的草垛角落，开裂的融蚀痕之中，静静地躺着某件物什。"
  },
  Event_7114_Name = {
    Text = "草垛之后"
  },
  Event_7115_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7115_Desc = {
    Text = "那身影未靠得更近，祂在凝视你片刻后，化为了一抔银沙。"
  },
  Event_7115_Name = {Text = "银钥使"},
  Event_7116_ChoiceDesc1 = {
    Text = "【握住触肢】接受图鲁的帮助"
  },
  Event_7116_Desc = {
    Text = "一声叹息后，图鲁追了上来。\n沉重、冰凉的触肢勾住了你，浇灭了想要单刀直入敌阵的可怕念头。\n「余将成为你的助力，仅限当下。」"
  },
  Event_7116_Name = {
    Text = "代行者的承诺"
  },
  Event_7117_ChoiceDesc1 = {
    Text = "【获得钥匙】"
  },
  Event_7117_Desc = {
    Text = "1、2、3……\n詹金和书桌的距离有10英尺。\n这是一个很短的距离，却又长得像她的一生。\n她想起柔软的缎带，想起金色的蝴蝶糖纸，也想起母亲的眼泪。\n她还想了很多，很多……\n瘦弱的身躯淌过黑色河流，一点点靠近书桌。\n钥匙就在抽屉里，获得它需要付出的代价也很简单：勇气、灵巧，外加那么一丁点运气。\n除了运气，詹金什么都不缺。"
  },
  Event_7117_Name = {
    Text = "最终的钥匙"
  },
  Event_7118_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7118_Desc = {
    Text = "一场赌局而已，你不会输的。\n镌刻着纹理的硬币被高高抛起，再迅速下落，被你的掌心侵染上温热。"
  },
  Event_7118_Name = {
    Text = "驰名的赌徒"
  },
  Event_7119_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7119_Desc = {
    Text = "一场赌局而已，你不会输的。\n镌刻着纹理的硬币被高高抛起，再迅速下落，被你的掌心侵染上温热。"
  },
  Event_7119_Name = {
    Text = "驰名的赌徒"
  },
  Event_7120_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7120_Desc = {
    Text = "一场赌局而已，你不会输的。\n镌刻着纹理的硬币被高高抛起，再迅速下落，被你的掌心侵染上温热。"
  },
  Event_7120_Name = {
    Text = "驰名的赌徒"
  },
  Event_7121_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7121_Desc = {
    Text = "你无意加入这场严肃的钢琴课。\n每当弹完一个小节，学生都会吃力地拧转头颅，做出倾听的模样。\n而他的老师也会稍稍弯腰，嘴唇一张一合，圆圆的眼睛看着根本不存在的乐谱。\n他们显然不知道自己在做什么，也永远不会明白为什么人类会花费数年来进行这种机械的练习。\n他们只是模仿罢了。"
  },
  Event_7121_Name = {Text = "钢琴课"},
  Event_7122_ChoiceDesc1 = {
    Text = "【插入银钥匙】"
  },
  Event_7122_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_7122_Name = {Text = "析出点"},
  Event_7123_ChoiceDesc1 = {
    Text = "【辨认歌词】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7123_ChoiceDesc2 = {
    Text = "【轻轻哼唱】获得3选1刻印"
  },
  Event_7123_Desc = {
    Text = "古老的船歌在密境中回荡。\n被密境困住的记忆用着你闻所未闻的语言，吟唱着海浪、天空与烈酒。"
  },
  Event_7123_Name = {
    Text = "海洋歌谣"
  },
  Event_7124_ChoiceDesc1 = {
    Text = "【呼唤乌鸦】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7124_ChoiceDesc2 = {
    Text = "【远远离开】"
  },
  Event_7124_Desc = {
    Text = "漆黑之鸟紧紧盯着你，许久过后，从它们的羽毛下落出了什么……"
  },
  Event_7124_Name = {
    Text = "离群之鸦"
  },
  Event_7125_ChoiceDesc1 = {
    Text = "【上前握住】获得25黑印"
  },
  Event_7125_ChoiceDesc2 = {
    Text = "【友好回应】50%机会获得50黑印，50%机会一无所有"
  },
  Event_7125_Desc = {
    Text = "一只不知从何而来的猫端坐在融蚀浆之间，轮廓模糊的躯体说明它应当是精神维度的住民。\n这个看不清面孔的投影用智慧的目光望着拉蒙娜，它抬起洁白的前爪，招手一般朝她示意。"
  },
  Event_7125_Name = {
    Text = "游走的住民"
  },
  Event_7126_ChoiceDesc1 = {
    Text = "【向北狂奔】"
  },
  Event_7126_ChoiceDesc2 = {
    Text = "【忽略声音】"
  },
  Event_7126_Desc = {
    Text = "敌人的攻势骤雨般落在身后，刀锋数次从斗篷上划过，惊起停留码头的一群鸥鸟。\n「向北…或上船……」\n再傻的人也能意识到，有什么力量在暗中帮助着你。"
  },
  Event_7126_Name = {
    Text = "一路向北"
  },
  Event_7127_ChoiceDesc1 = {
    Text = "【聆听太阳】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7127_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_7127_Desc = {
    Text = " 在现实与虚幻的交织中，天体顺着既定轨道永恒回转。\n无数次的擦肩而过，奏出了一曲又一曲奇异诡谲的乐章……"
  },
  Event_7127_Name = {
    Text = "星月之音"
  },
  Event_7128_ChoiceDesc1 = {
    Text = "【随悲伤离去】复制卡牌，如果复制症状卡，获得75黑印"
  },
  Event_7128_ChoiceDesc2 = {
    Text = "【随愤怒离去】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7128_Desc = {
    Text = "液体从瞳孔喷涌而出，冰冷而汹涌地带走了部分灵魂。"
  },
  Event_7128_Name = {
    Text = "冥滩之泪"
  },
  Event_7129_ChoiceDesc1 = {
    Text = "【深入回廊】"
  },
  Event_7129_ChoiceDesc2 = {
    Text = "【背道而驰】获得25黑印"
  },
  Event_7129_Desc = {
    Text = "惨白月光无视了时间的流转，倾泻在寂静回廊之上。\n门洞在月光的照射下，发出诡谲的光。"
  },
  Event_7129_Name = {
    Text = "寂静回廊"
  },
  Event_7130_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7130_Desc = {
    Text = "你决定修复这尊蜡像。\n蜡像的附近散落着一些工具，你选中一种名为「普鲁士蓝」的染料。\n它蓝得就像一种疾病。"
  },
  Event_7130_Name = {
    Text = "未完的蜡像"
  },
  Event_7131_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7131_Desc = {
    Text = "脓疱发出一声尖锐而令人毛骨悚然的啸叫，耳后传来不应存在的呼啸风声、幻觉般的笛声、脓液涌动的禁断之声。\n脓疱古怪地抽搐了片刻，然后僵硬着陷入死寂。目睹此景，你身旁的唤醒体仿佛受到了某种感召。"
  },
  Event_7131_Name = {
    Text = "古怪脓疱"
  },
  Event_7132_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7132_Desc = {
    Text = "你的指尖触碰着雕像，触感却时有意外柔软的凹陷，你总以为那是错觉。"
  },
  Event_7132_Name = {
    Text = "拼凑残躯"
  },
  Event_7133_ChoiceDesc1 = {
    Text = "【为她落泪】"
  },
  Event_7133_ChoiceDesc2 = {
    Text = "【向她祈祷】"
  },
  Event_7133_Desc = {
    Text = "身体接触到船舷的瞬间，不属于自己的记忆涌入脑海。\n人们给她换上圣洁的白裙，用珠宝把她装点得精致素雅，人们把她架上高高的祭坛，小镇居民在脚下匍匐跪拜。\n那是一双双充满希冀的眼睛：水手希望她能庇佑航行，渔民希望迎来无风无浪的渔季，更多的镇民希望获得一年的顺遂。\n跪拜的人群中，有她儿时的玩伴，也有朝夕相处的父母手足。\n她什么都不想要，她不知道自己想要什么。\n被动回应祈愿，仿佛是她生命中唯一的职责。"
  },
  Event_7133_Name = {
    Text = "航前典仪"
  },
  Event_7134_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7134_Desc = {
    Text = "那具残缺的身体苍白的瞳仁缓慢地转动着，注视着你抽身离去的身影，露出了一个惨淡的笑容。"
  },
  Event_7134_Name = {
    Text = "拼凑残躯"
  },
  Event_7135_ChoiceDesc1 = {
    Text = "【主动迎战】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7135_ChoiceDesc2 = {
    Text = "【放弃抵抗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7135_ChoiceDesc3 = {
    Text = "【赶紧开溜】获得50黑印"
  },
  Event_7135_Desc = {
    Text = "几个蜡像泥坯挡住了你的去路。\n它们歪歪扭扭，面容粗粝，望之不似罗杰斯应有的制作水准。\n「命令……大人的命令……」"
  },
  Event_7135_Name = {Text = "习作"},
  Event_7136_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7136_Desc = {
    Text = "你选择勇敢地直视眼睛。\n它们是璀璨的繁星，在黑暗中闪闪发光。\n随后它们笑了起来，又变成无数个弯弯的月亮。\n「你不惧怕目光。你也不应当惧怕……\n好久不见，@2」\n消失前，它们送给你一件小小的礼物，作为「重逢的纪念」。"
  },
  Event_7136_Name = {Text = "眼"},
  Event_7137_ChoiceDesc1 = {
    Text = "【打开开关】扩大当前视野[ExDesc1]。"
  },
  Event_7137_Desc = {
    Text = "前人遗留下来的照明装置，能驱散四周的黑色迷雾。\n它周围的雾气规律地波动着，像是被它的呼吸惊扰。"
  },
  Event_7137_Name = {Text = "探照灯"},
  Event_7138_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7138_Desc = {
    Text = "你的背部撑开透明的羽翼，盘旋着，盘旋着，与乌鸦一同流入静寂的海底。"
  },
  Event_7138_Name = {
    Text = "群鸦之声"
  },
  Event_7139_ChoiceDesc1 = {
    Text = "【消灭它】获得「畸变之心」"
  },
  Event_7139_Desc = {
    Text = "被不知什么人遗弃在道路旁的畸形脓疱，表面流转着污浊油绿的光泽，此刻正在躁动不安地变形蠕动着。\n相较于怪物，它更像裸露在烈日下接受灼烧的冰淇淋，很快就要化成一滩粘稠的浊水，然后消失于空气中。"
  },
  Event_7139_Name = {
    Text = "古怪脓疱"
  },
  Event_7140_ChoiceDesc1 = {
    Text = "【放下捂耳的双手】感染「(Skill.Arg1)」，选择获取一个奖励"
  },
  Event_7140_ChoiceDesc2 = {
    Text = "【抓住一只乌鸦】获得「(Skill.Arg1)」，选择获取一个奖励"
  },
  Event_7140_ChoiceDesc3 = {
    Text = "【闭上双眼】获得50黑印"
  },
  Event_7140_Desc = {
    Text = "尖啸，毫无尽头的尖啸——\n乌鸦歌者披着黑亮的皮毛，尖喙上泛着冷硬的寒光，嘹亮的悲鸣一次次划破你的耳膜。\n放下你捂耳的手吧！\n夜间纵情引吭的鸦群，要畅饮你蜷缩之躯内，那未经淬炼的战栗。\n"
  },
  Event_7140_Name = {
    Text = "群鸦之歌"
  },
  Event_7141_ChoiceDesc1 = {
    Text = "【离开】没有任何发现"
  },
  Event_7141_Desc = {
    Text = "不是你要找的人"
  },
  Event_7141_Name = {Text = "2_6临时"},
  Event_7142_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7142_Desc = {
    Text = "你选择继续前行。\n相比那些糟糕的蜡像艺术对你造成的精神与物理伤害，这点小小的困扰实在算不得什么。\n你还有更伟大的事业要完成。"
  },
  Event_7142_Name = {Text = "脚步声"},
  Event_7143_ChoiceDesc1 = {
    Text = "【指出问题】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7143_Desc = {
    Text = "「干嘛！就这么喜欢戳别人伤口吗！」\n「是啦！我现在就是平白无故年纪大了二十五岁！现在你要叫我墨菲姐姐！」"
  },
  Event_7143_Name = {
    Text = "被禁锢的生命"
  },
  Event_7144_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_7144_Desc = {
    Text = "少女的面容沉静如今夜的月光，她没有回应你，却高高举起了手中的罗盘——她在颤抖，举起着小小的罗盘仿佛就用尽了她的生命。"
  },
  Event_7144_Name = {
    Text = "白裙少女"
  },
  Event_7145_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7145_Desc = {
    Text = "「美味！美味！」乌鸦怪笑着，腐败的气息随着它展开的双翼弥散至你的鼻腔。"
  },
  Event_7145_Name = {
    Text = "诅咒怪鸦"
  },
  Event_7146_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7146_Desc = {
    Text = "要我说，噪音绝对是新世代的楷模。\n它们坚定地踏着毫无规律的节拍以及令人崩溃的旋律在世上横行肆虐。\n没有怜悯，没有动摇，也没有妥协。\n厌恶规律，摒弃主题，噪音从不取悦他人——\n当然，这其中也包括我们的蜡像师。"
  },
  Event_7146_Name = {
    Text = "糟糕的品味"
  },
  Event_7147_ChoiceDesc1 = {
    Text = "【领路】"
  },
  Event_7147_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7147_Desc = {
    Text = "有人在轻轻拉动你的衣角。\n是刚才见过的男孩。他蹲在角落忧郁地望向你。\n「我要参、参加学院的演出。\n可是，我找不到去舞台的路。」"
  },
  Event_7147_Name = {
    Text = "终幕礼Ⅱ"
  },
  Event_7148_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7148_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7148_Desc = {
    Text = "鼻尖闻到了熟悉的气味，家常而令人满足，当你想再嗅一嗅食堂香气时，那飘溢的香气却消失得一干二净。"
  },
  Event_7148_Name = {
    Text = "异常联络"
  },
  Event_7149_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7149_Desc = {
    Text = "祂们是温暖的色彩。\n热烈的，温柔的，爱怜的色彩。\n祂们给予了女孩一个令人怀念的拥抱，像风一般消失。"
  },
  Event_7149_Name = {
    Text = "怀念的色彩"
  },
  Event_7150_ChoiceDesc1 = {
    Text = "【你究竟是什么人？】"
  },
  Event_7150_ChoiceDesc2 = {
    Text = "【要怎么转变思路？】"
  },
  Event_7150_Desc = {
    Text = "长发的男人再次拦在了你们的道路前方。有了上次的经历，拉蒙娜面色不善。\n「稍安勿躁，我的朋友。」男人缓缓开口，他的声音磁性而魅惑，发声的方式好似气流通过狭窄的气道，夹杂着嘶嘶的摩擦声响。\n「我已经观察好些时候了，转变思路才能使你接近目标。」"
  },
  Event_7150_Name = {
    Text = "怪异旅伴Ⅲ"
  },
  Event_7151_ChoiceDesc1 = {
    Text = "【我在寻找】提升 Arg1 点最大生命"
  },
  Event_7151_ChoiceDesc2 = {
    Text = "【我在回避】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7151_Desc = {
    Text = "「我看到有人在寻找，寻找那不可寻找之物，那悲哀的相对之物，那被称为真相之物。\n我看到有人在回避，回避那不可回避之物，那被掩藏的残酷之物，那被称为真相之物。\n你是哪一个？」"
  },
  Event_7151_Name = {
    Text = "追寻之物"
  },
  Event_7152_ChoiceDesc1 = {
    Text = "【仔细查看】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7152_ChoiceDesc2 = {
    Text = "【尝试聆听】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7152_ChoiceDesc3 = {
    Text = "【小心收好】获得25黑印"
  },
  Event_7152_Desc = {
    Text = "前方的迷雾被一个细小的东西映亮，那看上去像是玻璃或者晶体的碎片，里面涌动着无数或显眼或暗淡的色彩。"
  },
  Event_7152_Name = {
    Text = "我们的回忆"
  },
  Event_7153_ChoiceDesc1 = {
    Text = "【接受挑战】胜利获得白银造物，失败获得症状。无论胜负，都不影响后续调查。"
  },
  Event_7153_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_7153_Desc = {
    Text = "倒影中的人是谁？\n祂有着与你同步的呼吸、同频的心跳，共享着同一个诡异的坏点子。\n是密境的恶作剧，还是跨越维度之影？\n似乎这是一个虚幻的挑战邀请？"
  },
  Event_7153_Name = {
    Text = "灵魂共振"
  },
  Event_7154_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7154_Desc = {
    Text = "视线超越了历史与时间，它也许是非线性的，它也许正从星球诞生前的混沌中俯视你。\n也或许，它在未来的某一日等着你。"
  },
  Event_7154_Name = {Text = "窥视"},
  Event_7155_ChoiceDesc1 = {
    Text = "【领取】获得50黑印"
  },
  Event_7155_Desc = {
    Text = "那里空无一物，漆黑的液体横流于地面上，倒映不出任何。\n是你的错觉吗？你感觉什么东西在指缝溜走。"
  },
  Event_7155_Name = {
    Text = "镜面之下"
  },
  Event_7156_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7156_Desc = {
    Text = "「您真是个大方的好人，祝您今天、明天、后天都心想事成。」\n「顺便说一句，我们这是一锤子买卖......」\n仙女满意地咂咂嘴，依依不舍和您道了个别。"
  },
  Event_7156_Name = {
    Text = "仙女赐福"
  },
  Event_7157_ChoiceDesc1 = {
    Text = "【把钱包还给我！】获得3选1刻印"
  },
  Event_7157_ChoiceDesc2 = {
    Text = "【犹豫】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7157_Desc = {
    Text = "「来呀，来取回你的钱包！」远方的孩童挥着手。\n你向前奔去，伸出手的瞬间，脑中突然响起巨大而杂乱的噪声。\n「哪来的脏孩子！」\n「是街头的小老鼠，怎么敢触碰公爵夫人的纱裙！」\n「快把他赶出去！」\n「你带了硬币吗？没有硬币，一个黑面包也别想拿走！」"
  },
  Event_7157_Name = {Text = "无之书"},
  Event_7158_ChoiceDesc1 = {
    Text = "【追寻歌声】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7158_ChoiceDesc2 = {
    Text = "【随之歌唱】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_7158_Desc = {
    Text = "渺远的歌声被崩碎成几点星屑：\n「我诅咒夜巷的一滩脏水，颓圮的墙根处缀着腐败的花，锁链攀附着大脑坠入泥淖，在浓雾抹去我的存在前，暮色将沉入最深的@2。」"
  },
  Event_7158_Name = {
    Text = "白质诅咒"
  },
  Event_7159_ChoiceDesc1 = {
    Text = "【留下供奉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7159_ChoiceDesc2 = {
    Text = "【带祂离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7159_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7159_Desc = {
    Text = "在你靠近时，无序的混沌灵魂从泥潭中骤然出现。\n黑色的上肢紧紧缠绕着你，祂哭泣着，祈求着——\n献上供奉，或带祂离开。"
  },
  Event_7159_Name = {
    Text = "混沌之灵"
  },
  Event_7160_ChoiceDesc1 = {
    Text = "【留下供奉】随机提升1张卡牌的刻印品质"
  },
  Event_7160_ChoiceDesc2 = {
    Text = "【带它离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7160_Desc = {
    Text = "在你靠近时，无序的混沌灵魂从泥潭中骤然出现。\n黑色的上肢紧紧缠绕着你，祂哭泣着，祈求着——\n献上供奉，或带祂离开。"
  },
  Event_7160_Name = {
    Text = "混沌之灵"
  },
  Event_7161_ChoiceDesc1 = {
    Text = "【挥手驱赶】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7161_ChoiceDesc2 = {
    Text = "【任由停留】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7161_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7161_Desc = {
    Text = "蝴蝶翕动的翅膀上拖着黑色的粘液，高低摇晃着飞过，翅膀上溢出的一层层黑浆，在凝固后被风化剥落。\n它飞累了，停在了你的鼻尖。"
  },
  Event_7161_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7162_ChoiceDesc1 = {
    Text = "【挥手驱赶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7162_ChoiceDesc2 = {
    Text = "【任由停留】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7162_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7162_Desc = {
    Text = "蝴蝶翕动的翅膀上拖着黑色的粘液，高低摇晃着飞过，翅膀上溢出的一层层黑浆，在凝固后被风化剥落。\n它飞累了，停在了你的鼻尖。"
  },
  Event_7162_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7163_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7163_Desc = {
    Text = "「我看到勇气，看到意志，看到耀眼如星的精神。朝着那个以蜡封存的记忆前进，你必能如愿以偿。」"
  },
  Event_7163_Name = {
    Text = "追寻之物"
  },
  Event_7164_ChoiceDesc1 = {
    Text = "【任由停留】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7164_ChoiceDesc2 = {
    Text = "【挥手驱赶】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7164_ChoiceDesc3 = {
    Text = "【迎接蝴蝶】获得25黑印"
  },
  Event_7164_Desc = {
    Text = "你们逡巡于寒风凌冽的疗养院中，一只这个季节不应存在的黑色蝴蝶翩跹而来。\n蝴蝶翕动的翅膀上拖着黑色的粘液，高低摇晃着飞过，翅膀上溢出的一层层黑浆，在凝固后被风化剥落。\n它飞累了，停在了你的指尖。"
  },
  Event_7164_Name = {
    Text = "不应存在之物"
  },
  Event_7165_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_7165_Desc = {
    Text = "你开始感觉疲惫。\n意识牵引着你， 越过池塘，越过高山， \n飞向太阳之外，飞向光年之外，\n飞向那独一无二的......宇宙温床。"
  },
  Event_7165_Name = {
    Text = "终幕礼Ⅳ"
  },
  Event_7166_ChoiceDesc1 = {
    Text = "【再找找看】"
  },
  Event_7166_Desc = {
    Text = "巨大的阴影把你彻底笼罩，腥臭的唾液又将你淋成落汤鸡。\n「小老鼠，快过来。就一小会……」\n「我发誓，我绝没有想要吃你的意思……」\n「我绝不对你肥美多汁的肚皮多看一眼！」"
  },
  Event_7166_Name = {
    Text = "素材12号"
  },
  Event_7167_ChoiceDesc1 = {
    Text = "【再找找看】"
  },
  Event_7167_Desc = {
    Text = "枯槁的蜡像哲人吸着烟，笼罩在白色的烟幕中。\n「彼岸存在但不可知，所以彼岸无从知晓。」\n「把这个世界想象成一个游戏……\n你要找的东西，或许就在地图的另一边。」"
  },
  Event_7167_Name = {
    Text = "素材45号"
  },
  Event_7168_ChoiceDesc1 = {
    Text = "【再找找看】"
  },
  Event_7168_Desc = {
    Text = "「抱歉，无意针对……」\n「我不喜欢老鼠。老鼠的问题是它们从不惧怕人类……」\n胡子拉碴的老者躺在角落，忧郁的双眼紧盯着你。\n「当然，你们非常有进取心。\n这很好，但还不足以帮助你们躲过灾厄……」"
  },
  Event_7168_Name = {Text = "素材4号"},
  Event_7169_ChoiceDesc1 = {
    Text = "【展示诅咒】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7169_ChoiceDesc2 = {
    Text = "【拒绝乌鸦】获得3选1刻印"
  },
  Event_7169_ChoiceDesc3 = {
    Text = "【无视】"
  },
  Event_7169_Desc = {
    Text = "漆黑而病态的多颅乌鸦自一名提灯教众的黑袍中飞出，落在你的肩膀上。\n「看见我的头了吗？只要品尝诅咒，我就会长出新的头颅。让我看看吧，你的诅咒！」"
  },
  Event_7169_Name = {
    Text = "诅咒怪鸦"
  },
  Event_7170_ChoiceDesc1 = {
    Text = "【响应呼唤】删除1张指令卡，并回复 Arg1 点生命"
  },
  Event_7170_ChoiceDesc2 = {
    Text = "【我不是在逃亡】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7170_Desc = {
    Text = "你在小巷中急速奔跑。肾上腺素激发，乳酸生成，葡萄糖消耗……混沌侵蚀了你的大脑，占据了你的思维，在五光十色的迷幻中催促你向终点逃亡。\n是的，逃亡。如果你真的不是在逃亡，那么等待你的，为何是混沌和虚无、一无所获和无疾而终呢？"
  },
  Event_7170_Name = {Text = "奔跑"},
  Event_7171_ChoiceDesc1 = {
    Text = "【追溯声音源头】"
  },
  Event_7171_ChoiceDesc2 = {
    Text = "【呼唤莉莉和库姆】"
  },
  Event_7171_Desc = {
    Text = "维度通道的远方，传来低沉粗重的喉音，夹杂着恐惧、期盼、不安，像是在呼唤着你们。紧接着是女孩子模糊不清的絮语，随后两种声音都渐渐低了下去。"
  },
  Event_7171_Name = {
    Text = "指引之声"
  },
  Event_7172_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_7172_Desc = {
    Text = "一种近水银态的银色物质，由融蚀黏液中提炼而出，蕴含强大精神力，主要用于在仪式中链接更多唤醒体。"
  },
  Event_7172_Name = {Text = "银芯"},
  Event_7173_ChoiceDesc1 = {
    Text = "【请他让开道路】"
  },
  Event_7173_ChoiceDesc2 = {
    Text = "【询问身份】"
  },
  Event_7173_Desc = {
    Text = "你们迈入一节昏暗的车厢，异样感浮上心头。\n这节车厢内空荡荡的，乘客早已逃窜离去，地面上散落着怪物的残躯，正在逐渐消散。\n车厢的中央，站着那个男人。\n「我相信世间存在缘分，也是缘分让我们搭乘了同一班地铁。」"
  },
  Event_7173_Name = {
    Text = "怪异旅伴Ⅳ"
  },
  Event_7174_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7174_Desc = {
    Text = "「你的眼睛真漂亮，像星星一样。」\n夏洛特咯咯笑着，疯狂游荡的头发柔顺地垂了下来。\n「你在学校里一定很受欢迎吧，我也喜欢你。」\n临走前，她吻了吻你的额角。\n你感到身体暖洋洋的，有什么东西似乎变得不一样了。"
  },
  Event_7174_Name = {
    Text = "调查员的阴影"
  },
  Event_7175_ChoiceDesc1 = {
    Text = "【阅读】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7175_ChoiceDesc2 = {
    Text = "【收入手提箱】感染「(Skill.Arg1)」，获得造物：「(RelicConfig.Arg2)」"
  },
  Event_7175_Desc = {
    Text = "一页泛黄的纸从提灯教众的罩袍下脱落。\n纸上密密麻麻撰写着形状奇特的古怪文本，有些像是象形符号，有些怪异地上扬，有些字体甚至重叠在一起，只有少量文字勉强可以辨认。"
  },
  Event_7175_Name = {
    Text = "密令·上"
  },
  Event_7176_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7176_Desc = {
    Text = "你说：「唉，夏洛特！不行！」\n夏洛特的头发疯狂地扭动着，她生气了。\n「我会证明给你看的！瞧瞧我的本事！」"
  },
  Event_7176_Name = {
    Text = "调查员的阴影"
  },
  Event_7177_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」】"
  },
  Event_7177_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_7177_Desc = {
    Text = "事件302（开发中），非最终效果"
  },
  Event_7177_Name = {
    Text = "事件302（开发中）"
  },
  Event_7178_ChoiceDesc1 = {
    Text = "【接收请求】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_7178_ChoiceDesc2 = {
    Text = "【拒绝请求】获得25黑印"
  },
  Event_7178_Desc = {
    Text = "颌骨咔吱响动着，声音带着某种规律的节奏，而你的同伴恰好懂得一些密码学的知识。\n破译后的文字如下：\n「你好，请叫我@2博士。我曾是一位收藏家、博物学家……\n（此处为长篇累牍的生涯及头衔介绍，略）\n总而言之，能帮我找到我的另一半吗？那是一块小小的上颌骨。\n只要能找到它，鄙人的私人宝库将向你敞开大门。」"
  },
  Event_7178_Name = {
    Text = "咔吱作响"
  },
  Event_7179_ChoiceDesc1 = {
    Text = "【投入一百坊】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_7179_ChoiceDesc2 = {
    Text = "【投入五片什】获得25黑印。"
  },
  Event_7179_Desc = {
    Text = "刺绣钱包蠕动着，向你张开黑漆漆的大口。\n自从离开富有的女主人，它已饥肠辘辘数十年，亟待填饱肚子。\n你朝钱包内看了看，里面空无一物，只有浓郁得看不见底的黑暗。"
  },
  Event_7179_Name = {
    Text = "贪吃钱包"
  },
  Event_7180_ChoiceDesc1 = {
    Text = "【是坚定的决心】删除1张指令卡，并回复 Arg1 点生命"
  },
  Event_7180_ChoiceDesc2 = {
    Text = "【是对成功的渴望】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7180_Desc = {
    Text = "「两个固执的家伙，济贫院已经很危险了，」通讯器里突然传来朵尔的声音，「你们打算下一步怎么行动，帮她把头缝上？」\n「现在不是说风凉话的时候，朵尔！」\n「我知道，我听得出来。」朵尔说，「冷静一点，知道成功的关键是什么吗？」"
  },
  Event_7180_Name = {
    Text = "罗格斯定则"
  },
  Event_7181_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」】"
  },
  Event_7181_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_7181_Desc = {
    Text = "事件304（开发中），非最终效果"
  },
  Event_7181_Name = {
    Text = "事件304（开发中）"
  },
  Event_7182_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」】"
  },
  Event_7182_ChoiceDesc2 = {
    Text = "【离开】获得25黑印"
  },
  Event_7182_Desc = {
    Text = "事件305（开发中），非最终效果"
  },
  Event_7182_Name = {
    Text = "事件305（开发中）"
  },
  Event_7183_ChoiceDesc1 = {
    Text = "【搁置听筒】获得3选1高级刻印"
  },
  Event_7183_ChoiceDesc2 = {
    Text = "【接起电话】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7183_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7183_Desc = {
    Text = "你们途经列车长的休憩室，隐蔽的角落里，电话铃声尖锐地响起。"
  },
  Event_7183_Name = {
    Text = "列车来电"
  },
  Event_7184_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7184_Desc = {
    Text = "光辉黯淡，却是真切存在着的。\n如此黯淡的银芯难以召唤唤醒体，用于强化倒是极好的——所谓银芯科技，就是这么回事儿。"
  },
  Event_7184_Name = {
    Text = "存在的证明"
  },
  Event_7185_ChoiceDesc1 = {
    Text = "【女士肖像画】随机提升1张卡牌的刻印品质"
  },
  Event_7185_ChoiceDesc2 = {
    Text = "【蜡像全家福】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7185_Desc = {
    Text = "蜡像馆内同时收藏了不少绘画作品。\n人物、风景、静物，写实的、抽象的……\n它们装点了原本单调的墙面，使其不至于显得无趣。\n你的目光被其中之一深深吸引，它是一幅——"
  },
  Event_7185_Name = {
    Text = "肖像回廊"
  },
  Event_7186_ChoiceDesc1 = {
    Text = "【继续翻阅】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7186_ChoiceDesc2 = {
    Text = "【离开】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_7186_Desc = {
    Text = "一架用于称重的天平。\n在它的背后，无数器官浸泡在红色的福尔马林中。\n它们被整整齐齐地堆叠在储物架上。\n你顺手捡起一旁的笔记本翻阅：\n「心脏：8盎司，大脑：50盎司……」"
  },
  Event_7186_Name = {
    Text = "器官登记"
  },
  Event_7187_ChoiceDesc1 = {
    Text = "【打开礼物】获得特殊卡牌"
  },
  Event_7187_Desc = {
    Text = "孩子的虚影在你面前一晃而过，你无法分辨那究竟是真正的孩童，还是密境之中的某种精神的投影。但——你看向地面上遗留的盒子，上面用稚嫩的字体写了「礼物」。"
  },
  Event_7187_Name = {
    Text = "善意的礼物"
  },
  Event_7188_ChoiceDesc1 = {
    Text = "【呼唤乌鸦】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7188_ChoiceDesc2 = {
    Text = "【远远离开】获得25黑印"
  },
  Event_7188_Desc = {
    Text = "白鸥停留在桅杆之上，桅杆之上覆盖白霜。\n鸣管齐齐共振，它们排斥着黑色的存在，也排斥那不属于远洋的漆黑之鸟。"
  },
  Event_7188_Name = {
    Text = "离群之鸦"
  },
  Event_7189_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7189_Desc = {
    Text = "你听出那歌谣改编自一首情歌。\n在那首情歌的末尾，诗人说：\n「直到人类的声音把我们唤醒，我们便溺水而亡。」\n不是现在。你心说。\n你还在等待人类将你唤醒。"
  },
  Event_7189_Name = {
    Text = "群鸦之声"
  },
  Event_7190_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7190_Desc = {
    Text = "一卷落满灰尘的胶片。但这屋内并无放映机，此刻也不是悠闲地享受庄园、胶片和下午茶的时候。\n或许要很久之后，你才能有机会知晓胶片中的内容了。"
  },
  Event_7190_Name = {
    Text = "记忆光影"
  },
  Event_7191_ChoiceDesc1 = {
    Text = "【离开】获得3选1高级刻印，感染「(Skill.Arg1)」"
  },
  Event_7191_Desc = {
    Text = "你跟在男孩身后，不远也不近。 \n嗒。嗒。嗒…… 男孩在街角停下。\n你看到他身后摇摇欲坠的红色微光，直觉告诉你，蜡像馆就在前方。 \n男孩转过身来。他没有眼睛，眼眶里一片漆黑。 \n他对你微笑。"
  },
  Event_7191_Name = {
    Text = "终幕礼Ⅰ"
  },
  Event_7192_ChoiceDesc1 = {
    Text = "【离开】获得50黑印，感染「(Skill.Arg1)」"
  },
  Event_7192_Desc = {
    Text = "你拍了拍他的肩。\n男孩转过身来，他没有眼睛，眼眶里一片漆黑。\n 「晚上好。我在寻找去蜡像馆的路。」 \n男孩指了指前方。你看到他身后摇摇欲坠的红色微光。\n直觉告诉你，蜡像馆就在那里。 \n回过神来，男孩早已离开，只留下路灯拖长的影子。"
  },
  Event_7192_Name = {
    Text = "终幕礼Ⅰ"
  },
  Event_7193_ChoiceDesc1 = {
    Text = "【摁住乌鸦】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7193_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_7193_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。"
  },
  Event_7193_Name = {
    Text = "融浆之泪"
  },
  Event_7194_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7194_Desc = {
    Text = "无价的知识涌入你的脑海，然后化为迷雾……当你清醒过来时，那本怪异的黄色封皮书籍已经不翼而飞……"
  },
  Event_7194_Name = {
    Text = "黄色书卷"
  },
  Event_7195_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7195_Desc = {
    Text = "你轻松击倒了这些蜡像。它们垂着头倒在你的面前。\n蜡像的底部似乎书写了几行文字。\n「洪积@2年11月\n罗杰斯制作于@2学院」\n你记得罗杰斯曾就读于某艺术学院的雕塑专业，这些笨拙的蜡像想必是他当年的习作吧。"
  },
  Event_7195_Name = {Text = "习作"},
  Event_7196_ChoiceDesc1 = {
    Text = "【为什么呢】"
  },
  Event_7196_ChoiceDesc2 = {
    Text = "【向深海下坠】"
  },
  Event_7196_Desc = {
    Text = "「冒牌货！把我的儿子还回来！」\n「你不是航船圣女吗？你的职责不是庇佑航船吗？为什么只有一艘船回来了，你说啊，你说啊！」\n「溺死她！我父亲死前受的苦，她也必须尝！」\n「溺死她，溺死她！」\n「溺死这个冒牌货！把她捆在石头上！」\n海水涌入口鼻，空气被从肺泡的每个角落挤出去时，她也穿着那身华贵高洁的白裙。\n几乎是成为圣女后的第一个念头，从脑袋最阴暗的角落爬了出来，姗姗来迟。\n「是啊，那些船，为什么会沉呢？」"
  },
  Event_7196_Name = {Text = "沉海"},
  Event_7197_ChoiceDesc1 = {
    Text = "【摁住乌鸦】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7197_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_7197_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。"
  },
  Event_7197_Name = {
    Text = "融浆之泪"
  },
  Event_7198_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7198_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7198_Desc = {
    Text = "似乎有一双手搭上了你的肩头，有力而坚定，可当你回头寻找时，那一度切实的触感又变得飘渺难寻。"
  },
  Event_7198_Name = {
    Text = "异常联络"
  },
  Event_7199_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7199_Desc = {
    Text = "铁路桥，伦蒂尼恩的血管与神经，连接城市的心脏与四肢，拉伊疯人院正位于四肢的末梢，安静地等待血液和讯号的输送。"
  },
  Event_7199_Name = {
    Text = "铁路的幻觉"
  },
  Event_7200_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7200_Desc = {
    Text = "你把手提箱放在地上用力踩了几脚，确认它不再震颤后才重新拾起它。\n拍了拍上面的尘土，在墨菲疑惑的眼神中，你们继续前进。"
  },
  Event_7200_Name = {
    Text = "不速来信"
  },
  Event_7201_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7201_Desc = {
    Text = "危险隔着一层木门对你虎视眈眈，不适合消磨太多时间。将它收入手提箱中。"
  },
  Event_7201_Name = {
    Text = "黄色书卷"
  },
  Event_7202_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7202_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_7202_Desc = {
    Text = "它，或者说它们，在卧室盘旋，将灯罩撞得哗啦作响。"
  },
  Event_7202_Name = {
    Text = "提灯黑鸦"
  },
  Event_7203_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7203_Desc = {
    Text = "这里是精神的维度，是灵知的世界。\n除了搅乱你的脑子，祂们什么都做不到。"
  },
  Event_7203_Name = {
    Text = "灵知风暴"
  },
  Event_7204_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7204_Desc = {
    Text = "颅骨：汉克·蒂林哈斯特 A.F.186-A.F.203 克里奥尔岛\n脊椎：安迪·克劳福特 A.F.177-A.F.203 纳拉甘西特\n……不能细想。"
  },
  Event_7204_Name = {Text = "铭牌"},
  Event_7205_ChoiceDesc1 = {
    Text = "【检查碎片】从牌库中随机获取3张指令卡，选择1张卡进行删除，获得75黑印"
  },
  Event_7205_ChoiceDesc2 = {
    Text = "【询问朵尔】从牌库中随机获取3张指令卡，选择1张卡的原始复制进入牌库，获得25黑印"
  },
  Event_7205_ChoiceDesc3 = {
    Text = "【无视】获得50黑印"
  },
  Event_7205_Desc = {
    Text = "朵尔给你的金属碎片在你的胸口不安的翕动着，像是受到惊扰的蝴蝶。"
  },
  Event_7205_Name = {
    Text = "不安的胸针"
  },
  Event_7206_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7206_Desc = {
    Text = "「祂在终点静静等候，无论你将终点定在何处——看看那位年轻的管理，她的逃避终究招致疯狂。」"
  },
  Event_7206_Name = {
    Text = "追寻之物"
  },
  Event_7207_ChoiceDesc1 = {
    Text = "【离开】没有任何发现"
  },
  Event_7207_Desc = {
    Text = "开发中，特殊事件"
  },
  Event_7207_Name = {Text = "2_16临时"},
  Event_7208_ChoiceDesc1 = {
    Text = "【安慰它】提高 Arg1 点最大生命"
  },
  Event_7208_ChoiceDesc2 = {
    Text = "【忽视它】随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染2张「(Skill.Arg2)」"
  },
  Event_7208_Desc = {
    Text = "链接温暖着尚为人类之心的器官。\n它模仿着链接那头呼吸的节奏鼓动着，就好像这么做，它就不会被抛下，它就拥有了永远与链接同行的权利。"
  },
  Event_7208_Name = {Text = "左心房"},
  Event_7209_ChoiceDesc1 = {
    Text = "随机高级刻印"
  },
  Event_7209_Name = {Text = "12"},
  Event_7210_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_7210_Desc = {
    Text = "你的冷淡让声音的主人颇感遗憾，水面恹恹地荡出几个涟漪，再无波澜。"
  },
  Event_7210_Name = {
    Text = "界外之音"
  },
  Event_7211_ChoiceDesc1 = {
    Text = "【选择1张卡牌获得刻印：「(EnchantConfig.Arg1)」】测试刻印"
  },
  Event_7211_ChoiceDesc2 = {
    Text = "【选择1张卡牌获得刻印：「(EnchantConfig.Arg1)」】测试掉落包"
  },
  Event_7211_Desc = {
    Text = "测试指定刻印"
  },
  Event_7211_Name = {
    Text = "指定刻印测试1"
  },
  Event_7212_ChoiceDesc1 = {
    Text = "【离开】选择觉醒1名唤醒体"
  },
  Event_7212_Desc = {
    Text = "你摸了摸男孩的头，引导他和你一起念下去。 \n「献给妈妈的歌——」 \n声音像暗夜里的飞蛾，并肩飘出空荡荡的舞台，\n轻轻降落在漆黑一片的观众席里。"
  },
  Event_7212_Name = {
    Text = "终幕礼Ⅲ"
  },
  Event_7213_ChoiceDesc1 = {
    Text = "【离开】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_7213_Desc = {
    Text = "你不动声色。一位贵妇人忽然冲上舞台。 \n她疯狂地掰开男孩的嘴，将手中的木棍狠狠捅进去。 \n「说话，给我说话。」 \n男孩嘴里流出黑色的血。他含混不清地念了下去。 \n「献给妈妈的歌……」"
  },
  Event_7213_Name = {
    Text = "终幕礼Ⅲ"
  },
  Event_7215_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7215_Desc = {
    Text = "那不是窗户，是一面镜子。镜中倒映出拉蒙娜神经紧绷的脸。\n这个房间中为何没有窗户，只在墙面上挂了一面巨大的镜子？"
  },
  Event_7215_Name = {
    Text = "窗中倒影"
  },
  Event_7216_ChoiceDesc1 = {
    Text = "【握住银钥】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7216_ChoiceDesc2 = {
    Text = "【闭上双眼】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7216_Desc = {
    Text = "你被一阵巨大的荒诞撕扯着，肢体扭曲地爬行于地面，仿佛被来自维度以外的@2操纵。\n「不……不……」\n你的理智寸寸垮塌，神志不清的狞笑和尖叫交织，如一道巨网缚住你的意识，溢到嘴边的只有含混不清的哀鸣。"
  },
  Event_7216_Name = {
    Text = "凝望之眼"
  },
  Event_7217_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7217_Desc = {
    Text = "星河色泽变幻，在你的脚下绘出不可名状的图案，瑰丽如红宝石，却浮肿如水母。手提箱内随之泛起红光……"
  },
  Event_7217_Name = {
    Text = "群星岔路"
  },
  Event_7218_ChoiceDesc1 = {
    Text = "【驱散幻象】压力+10。"
  },
  Event_7218_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7218_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_7218_Name = {Text = "幻象"},
  Event_7221_ChoiceDesc1 = {
    Text = "【接住】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7221_ChoiceDesc2 = {
    Text = "【低头查看】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7221_Desc = {
    Text = "乌鸦在被小巷切割成积木型的天空中盘旋，发出令人心绪不宁的喑哑鸣叫。\n 鸦群突然躁乱，像是某种病态的天性被扭曲或是觉醒，它们急躁而凶狠地相互扑打追逐，撕扯中有什么东西落了下来。"
  },
  Event_7221_Name = {
    Text = "躁乱鸦群"
  },
  Event_7222_ChoiceDesc1 = {
    Text = "【遵从指示】提升 Arg1 点生命"
  },
  Event_7222_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7222_Desc = {
    Text = "你尝试用银钥匙的追溯之力寻找最近的联络点，但获得的信息中夹杂着难以察觉的异常，似乎被干扰了。"
  },
  Event_7222_Name = {
    Text = "异常联络"
  },
  Event_7223_ChoiceDesc1 = {
    Text = "【交给朵尔】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7223_ChoiceDesc2 = {
    Text = "【阅读铭牌】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_7223_Desc = {
    Text = "从被你击败的雕塑家协会实验体身上，掉下一块金属外框的铭牌。银钥匙感应着铭牌，微微闪光。"
  },
  Event_7223_Name = {Text = "铭牌"},
  Event_7224_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7224_Desc = {
    Text = "持刀者发出长啸，好似一声能斩断山海的巨响。\n声音转瞬即逝，连带另外两个蹈海者也不见踪影……原来只是密境映照出的一段幻象。"
  },
  Event_7224_Name = {
    Text = "穷追不舍"
  },
  Event_7225_ChoiceDesc1 = {
    Text = "【修复蜡像】选择卡牌并使其算力消耗降低1"
  },
  Event_7225_Desc = {
    Text = "你手持蜡烛，穿过迷蒙的雾霭，来到她的面前。\n这是一尊未完的蜡像。\n柔美的面庞被一分为二，一半微笑，一半@1。\n成为她的神明吧。\n给予她美貌，给予她眼泪。\n雕琢她，或是毁灭她。"
  },
  Event_7225_Name = {
    Text = "未完的蜡像"
  },
  Event_7226_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7226_Desc = {
    Text = "「当然，我曾亲眼目睹消亡。」你回答道。\n是的，那不过是一只小鼠的暴死，一颗心脏的溃烂，和一束鸢尾浸入夜色的葬礼。"
  },
  Event_7226_Name = {
    Text = "亡佚神国"
  },
  Event_7227_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7227_Desc = {
    Text = "「神国……消亡……虚无缥缈的议题……我并不知晓，如何才算消亡。」\n两道人影轻声笑了，周身洒落雪白的光芒碎屑。\n「那此刻，你即将见证一次真正的消亡。」"
  },
  Event_7227_Name = {
    Text = "亡佚神国"
  },
  Event_7228_ChoiceDesc1 = {
    Text = "【拼合纸张】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7228_ChoiceDesc2 = {
    Text = "【阅读】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7228_ChoiceDesc3 = {
    Text = "【丢弃它】获得50黑印"
  },
  Event_7228_Desc = {
    Text = "一页泛黄的纸从提灯教众的罩袍下脱落。\n纸上密密麻麻撰写着古怪的文本，有些像是象形符号，有些怪异地上扬，有些字体甚至重叠在一起，只有少量文字勉强可以辨认。\n标题是《@2 圣子的诞生》"
  },
  Event_7228_Name = {
    Text = "密令·下"
  },
  Event_7229_ChoiceDesc1 = {
    Text = "【挣扎】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7229_ChoiceDesc2 = {
    Text = "【沉沦】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7229_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7229_Desc = {
    Text = "「我好痛苦，好痛苦啊……」\n「为什么是我，为什么我要经历这个？」\n「仁慈的父神啊，我到底做错了什么？」\n悲伤、痛苦、愤怒、不甘……「病人」们的情感沉重地压在你的身上，你捂着胸口，无法呼吸。"
  },
  Event_7229_Name = {Text = "沉溺"},
  Event_7230_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7230_Desc = {
    Text = "视线穿透了皮肉，将烙印打在了先行者的视网膜上。\n没有人可以逃离，正如没有人@2"
  },
  Event_7230_Name = {Text = "窥视"},
  Event_7231_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7231_Desc = {
    Text = "集中精神，辨认歌词，然后被杂乱无章的词句冲击后脑。\n那不是人类能够理解的词语。"
  },
  Event_7231_Name = {
    Text = "海洋歌谣"
  },
  Event_7232_ChoiceDesc1 = {
    Text = "【进行试炼】感染「(Skill.Arg1)」，胜利获得黄金造物，失败获得50黑印"
  },
  Event_7232_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_7232_Desc = {
    Text = "你窥见过一些秘辛，从脚下那滩镜面般反光的黑浆中。\n它的倒影边缘模糊，周身萦绕着挥之不去的黑气，你感到莫名熟悉，却又辨认不清它究竟是何物。"
  },
  Event_7232_Name = {
    Text = "镜面之下"
  },
  Event_7233_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7233_Desc = {
    Text = "你对神神叨叨的佚名信件不屑一顾，随手烧掉的信笺化作飞灰。"
  },
  Event_7233_Name = {
    Text = "又一封求救信"
  },
  Event_7234_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7234_Desc = {
    Text = "你检查信件的本体，封口处黏糊糊的液体，似乎是血液和黑浆的混合物，混杂着几根发丝，被黏在封口处。"
  },
  Event_7234_Name = {
    Text = "又一封求救信"
  },
  Event_7235_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7235_Desc = {
    Text = "从信件飘落的方向寻去，在拐弯的墙角处，你瞥见了闪亮的物什。"
  },
  Event_7235_Name = {
    Text = "又一封求救信"
  },
  Event_7236_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7236_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7236_Desc = {
    Text = "隐约的光芒出现在眼前，明亮而温暖，想要循光而去时，它却忽地消失了。"
  },
  Event_7236_Name = {
    Text = "异常联络"
  },
  Event_7237_ChoiceDesc1 = {
    Text = "【离开】所有唤醒体回复Arg1狂气"
  },
  Event_7237_Desc = {
    Text = "你害怕得紧紧闭上双眼。\n「你掀开了盖布……\n秘密，你发现了秘密……」 \n声浪汇成喧嚣的海洋，地板在可怕的共振中剧烈抖动。\n你忍无可忍，猛地睁开双眼，却发现四周空无一物。"
  },
  Event_7237_Name = {
    Text = "终幕礼Ⅴ"
  },
  Event_7238_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7238_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7238_Desc = {
    Text = "鼻尖闻到了熟悉的气味，家常而令人满足，当你想再嗅一嗅食堂香气时，那飘溢的香气却消失得一干二净。"
  },
  Event_7238_Name = {
    Text = "异常联络"
  },
  Event_7239_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7239_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7239_Desc = {
    Text = "耳边传来了熟悉的话语，亲切而令人安心，想要循声寻找时，声音却戛然而止。"
  },
  Event_7239_Name = {
    Text = "异常联络"
  },
  Event_7240_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7240_Desc = {
    Text = "追溯之力短时间内无法再次为你寻找联络点，可你至少获得了暂时的抚慰。"
  },
  Event_7240_Name = {
    Text = "异常联络"
  },
  Event_7241_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7241_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7241_Desc = {
    Text = "似乎有一双手搭上了你的肩头，有力而坚定，可当你回头寻找时，那一度切实的触感又变得飘渺难寻。"
  },
  Event_7241_Name = {
    Text = "异常联络"
  },
  Event_7242_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7242_Desc = {
    Text = "「N」的影子被拳风打散，黑色微粒与密境浓雾融为一体，难寻踪迹。\n「没意思，又有趣的家伙。我很期待和你真正的会面……」"
  },
  Event_7242_Name = {
    Text = "好戏开场"
  },
  Event_7243_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7243_Desc = {
    Text = "「乖孩子。不过，还是要给你一点小小的惩罚才行。」\n达芙黛尔的轻笑声消散在维度裂隙中。"
  },
  Event_7243_Name = {
    Text = "提示时间"
  },
  Event_7244_ChoiceDesc1 = {
    Text = "【正面】50%概率获得黄金造物「(RelicConfig.Arg2)」，50%概率感染「(Skill.Arg3)」"
  },
  Event_7244_ChoiceDesc2 = {
    Text = "【反面】50%概率获得75黑印，50%概率感染「(Skill.Arg3)」"
  },
  Event_7244_ChoiceDesc3 = {
    Text = "【黑色筹码】50%概率获得诅咒造物「(RelicConfig.Arg2)」，50%概率感染「(Skill.Arg3)」"
  },
  Event_7244_Desc = {
    Text = "很好…很好……\n那么，选择你想要的筹码吧。"
  },
  Event_7244_Name = {
    Text = "好戏开场"
  },
  Event_7245_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7245_Desc = {
    Text = "「好吧好吧。那家伙，对跨越维度的生物总是纠缠不休呢，我也很是费了一番工夫才能够自如地穿梭在这些维度的破洞中。啊，那得是三千年前的事情了吧？」"
  },
  Event_7245_Name = {
    Text = "提示时间"
  },
  Event_7246_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7246_Desc = {
    Text = "相信科研主任不会在你的胸口安装炸弹。"
  },
  Event_7246_Name = {
    Text = "不安的胸针"
  },
  Event_7247_ChoiceDesc1 = {
    Text = "【离开】删除1张指令卡，获得25黑印"
  },
  Event_7247_Desc = {
    Text = "「是好心的路人，为迷途者提供正确的指引，」他的笑容不怀好意，「轻装简行吧，刻耳柏洛斯在等待着你们。」\n手中的指挥装置猝然震动了一下。"
  },
  Event_7247_Name = {
    Text = "怪异旅伴Ⅲ"
  },
  Event_7248_ChoiceDesc1 = {
    Text = "【慢慢挪动】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7248_ChoiceDesc2 = {
    Text = "【俯身躺平】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7248_Desc = {
    Text = "「遇到沼泽时，千万不要挣扎。」\n你谨记这条生存法则，像复活节岛的雕像一样岿然不动。\n五分钟，十分钟，一小时……黑泥终于失去耐心，从你的脚底消失了。"
  },
  Event_7248_Name = {
    Text = "黯色沼泽"
  },
  Event_7249_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7249_Desc = {
    Text = "你注意到一只与众不同的手。它细嫩、白皙，从始至终都表现得很平静。\n更重要的是——你认出来了，那是你自己的手。\n你轻轻握住了它。\n那只手也回握住你的。你感受到刺骨的寒冷与虚无，随后沼泽便消失了。"
  },
  Event_7249_Name = {
    Text = "黯色沼泽"
  },
  Event_7250_ChoiceDesc1 = {
    Text = "【斩断一只手】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7250_ChoiceDesc2 = {
    Text = "【安抚它们】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7250_Desc = {
    Text = "你挥舞手中的利刃，将它们逐一斩断。\n各式各样的血溅到你的身上、脸上、头发上，你却浑然不觉。\n无数只手一齐发出痛苦的哀嚎，沼泽消失了。\n直到一星期后，你才不会在噩梦里听到那些哭声。"
  },
  Event_7250_Name = {
    Text = "黯色沼泽"
  },
  Event_7251_ChoiceDesc1 = {
    Text = "【拾起银芯】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7251_ChoiceDesc2 = {
    Text = "【尝试唤醒】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7251_ChoiceDesc3 = {
    Text = "【置之不理】获得25黑印"
  },
  Event_7251_Desc = {
    Text = "松动的甲板横木下，溢出一股污浊的黑浆。\n而黑浆中的闪光，是你再熟悉不过的「银芯」。"
  },
  Event_7251_Name = {
    Text = "存在的证明"
  },
  Event_7252_ChoiceDesc1 = {
    Text = "【选择老鼠】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7252_ChoiceDesc2 = {
    Text = "【选择蜡烛】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_7252_Desc = {
    Text = "融蚀体在你面前消散，黑冷的飞灰融入迷雾，凭空凝聚出一个古怪的天平。天平的一端是一只沉睡的老鼠，另一端则是一根雕刻成男孩模样的蜡烛。\n冥冥中你知道，你必须做出选择。"
  },
  Event_7252_Name = {
    Text = "理智与情感"
  },
  Event_7253_ChoiceDesc1 = {
    Text = "【出声试探】"
  },
  Event_7253_ChoiceDesc2 = {
    Text = "【偷偷跟上】"
  },
  Event_7253_Desc = {
    Text = "走过某个转角，周围的一切愈发模糊，只有可怖的吼叫仍旧清晰。\n脚步声响起，你一回头，依稀看到一个古怪的身影：那似乎是个人，同时背后有着成对的阴影，乍看上去像一只巨大的飞蛾。\n「小心，」拉蒙娜低声提醒，「密境之中，眼见不一定为实，若是贸然跟上去，恐怕会有危险。」"
  },
  Event_7253_Name = {
    Text = "雾气中的身影"
  },
  Event_7254_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7254_Desc = {
    Text = "你掏出了银钥匙，哀戚虔诚地将它握在手心，薄雾般的微光包裹住你。\n一片寂静中，只余喟叹。"
  },
  Event_7254_Name = {
    Text = "凝望之眼"
  },
  Event_7255_ChoiceDesc1 = {
    Text = "【选择星河之路】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7255_ChoiceDesc2 = {
    Text = "【选择虹彩之路】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_7255_Desc = {
    Text = "扑通、扑通、扑通。\n心跳像擂鼓，口干舌燥，高空之中的目光从脊椎刺穿你的胸膛。\n眼前出现了分岔的道路，一条星河流淌，一条虹彩泛光。"
  },
  Event_7255_Name = {
    Text = "群星岔路"
  },
  Event_7256_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7256_Desc = {
    Text = "残留的目光仍在注视着你，你皮肤下的血肉细胞正疯狂叫嚣和逃逸，血管在皮肤下蠕动如虫豸。\n你感到一阵流淌着的力量，在肢体诡谲的异状中迸发。"
  },
  Event_7256_Name = {
    Text = "凝望之眼"
  },
  Event_7257_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_7257_ChoiceDesc2 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_7257_ChoiceDesc3 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_7257_Desc = {
    Text = "「不，这不是真的。比起蟑螂，你们至少有毛茸茸的身体。\n没人能拒绝毛茸茸的身体。」\n老鼠们窃窃私语，最终勉强同意了你的观点。\n「还好啦……其实也没有很多毛。」\n被夸赞总是令人高兴的。临走前，老鼠们送了你一件小小的礼物。"
  },
  Event_7257_Name = {Text = "鼠疫"},
  Event_7258_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7258_Desc = {
    Text = "「我同意！人类和老鼠不共戴天！」\n老鼠们有点生气，露出白花花的獠牙。\n「那你还在这里做什么？拿走你的东西，永远不要回来。」"
  },
  Event_7258_Name = {Text = "鼠疫"},
  Event_7259_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7259_Desc = {
    Text = "奇异的振翅声萦绕在你周围，恍惚间你看到，罗杰斯抱着玩偶乔治躺在诊疗床上，双手满是鲜血。\n你睁开眼，发现克莱门汀已经不见了踪迹。\n苏醒过来，克莱门汀已经离开。"
  },
  Event_7259_Name = {
    Text = "催眠疗法"
  },
  Event_7260_ChoiceDesc1 = {
    Text = "【开启】使用钥匙。"
  },
  Event_7260_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7260_Desc = {
    Text = "一扇门堵住了你的去路。你用尽了各种方法，它依然纹丝不动。"
  },
  Event_7260_Name = {
    Text = "锈蚀门扉"
  },
  Event_7260_Tips1 = {
    Text = "需要获得「锈蚀钥匙」"
  },
  Event_7261_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7261_Desc = {
    Text = "你朝你认为是目光源头的方向望去。工坊的天花板骤然变得高远，巨大瞳仁的虚影层层叠叠，尽管只有一部分与你对望，你仍感到巨大的压力。"
  },
  Event_7261_Name = {
    Text = "谁的目光"
  },
  Event_7262_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7262_Desc = {
    Text = "黑猫谨慎地踱步靠近，在你手心呕出一团漆黑。"
  },
  Event_7262_Name = {
    Text = "夜猫之祸"
  },
  Event_7263_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7263_Desc = {
    Text = "「嗯，聪明的选择。大敌当前，肯定会想要知己知彼？不过，知晓太多关于维度的秘密可是会干扰神志的哦？」\n「那家伙，对跨越维度的生物总是纠缠不休呢，我也很是费了一番工夫才能够自如地穿梭在这些维度的破洞中。啊，那得是三千年前的事情了吧？」"
  },
  Event_7263_Name = {
    Text = "提示时间"
  },
  Event_7264_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7264_Desc = {
    Text = "「喵，喵喵，喵喵喵……」\n你捏着嗓子，竭力使自己显得柔弱无害。\n「喵！喵喵！喵喵喵！」\n猫群似乎接受了你的善意，回以嘹亮的呼喊。你们的叫声此起彼伏，昼夜不歇，月亮都被吓得躲进云里。"
  },
  Event_7264_Name = {Text = "猫之城"},
  Event_7265_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7265_Desc = {
    Text = "你用力掰回了乌鸦意图啃咬羽毛的尖喙，它却不依不饶地拧过去，力气之大甚至将你的骨头震得咔咔作响。\n你涨得满脸通红，拼尽全身力气才制住乌鸦的身体，遏止了它疯狂自残的行径。\n正在你松了口气时，乌鸦那已经半秃的脖颈向后猛地一拧，身体瘫软下来，在你的手里化成了一滩黑色的浓浆。"
  },
  Event_7265_Name = {
    Text = "融浆之泪"
  },
  Event_7266_ChoiceDesc1 = {
    Text = "【摁住乌鸦】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7266_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_7266_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。"
  },
  Event_7266_Name = {
    Text = "融浆之泪"
  },
  Event_7267_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7267_Desc = {
    Text = "乌鸦撕咬着自己的羽毛，就如人类啃噬自己的身体一样。\n在这个恐惧的世界里，此事屡见不鲜，你救不了所有生灵。"
  },
  Event_7267_Name = {
    Text = "融浆之泪"
  },
  Event_7268_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7268_Desc = {
    Text = "「我会带着学生们回来的。」女孩拽着唤醒体的裙角，笃定地说，「照顾好自己……你可别掉海里了。」"
  },
  Event_7268_Name = {
    Text = "航船圣女的庇佑"
  },
  Event_7269_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7269_Desc = {
    Text = "哈哈，黑色，我最喜欢的黑色。无序、混乱、痛苦……你早该知道的，黑色可不是什么好兆头。\n那么，你的下一个选择是？"
  },
  Event_7269_Name = {
    Text = "好戏开场"
  },
  Event_7270_ChoiceDesc1 = {
    Text = "【摁住乌鸦】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7270_ChoiceDesc2 = {
    Text = "【放任不管】离开"
  },
  Event_7270_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。"
  },
  Event_7270_Name = {
    Text = "融浆之泪"
  },
  Event_7271_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7271_Desc = {
    Text = "那是年久失修，缺少灯光与指引的船舱深处。\n女孩会带着航船圣女的祝福出发，这是她们的约定。"
  },
  Event_7271_Name = {
    Text = "航船圣女的庇佑"
  },
  Event_7272_ChoiceDesc1 = {
    Text = "【追寻歌声】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7272_ChoiceDesc2 = {
    Text = "【随之歌唱】感染「(Skill.Arg1)」，再次随机刻印"
  },
  Event_7272_Desc = {
    Text = "渺远的歌声被崩碎成几点星屑：\n「我诅咒夜巷的一滩脏水，颓圮的墙根处缀着腐败的花，锁链攀附着大脑坠入泥淖，在浓雾抹去我的存在前，暮色将沉入最深的@3。」"
  },
  Event_7272_Name = {
    Text = "白质诅咒"
  },
  Event_7273_ChoiceDesc1 = {
    Text = "【追寻歌声】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7273_Desc = {
    Text = "渺远的歌声被崩碎成几点星屑：\n「我诅咒夜巷的一滩脏水，颓圮的墙根处缀着腐败的花，锁链攀附着大脑坠入泥淖，在浓雾抹去我的存在前，暮色将沉入最深的@4。」"
  },
  Event_7273_Name = {
    Text = "白质诅咒"
  },
  Event_7274_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7274_Desc = {
    Text = "银芯没有响应你的唤醒，但散发出温暖的气息。"
  },
  Event_7274_Name = {
    Text = "孤独银芯"
  },
  Event_7275_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7275_Desc = {
    Text = "缭绕的黑色雾气爬上脊椎，直到摔倒在地面为止，你一直重复着这句话。"
  },
  Event_7275_Name = {
    Text = "不可直视"
  },
  Event_7276_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7276_Desc = {
    Text = "是的，自瞳孔缓缓流出的玻璃体液，是你被禁忌腐蚀的证明。\n诚实，在此时与美德背道而驰。"
  },
  Event_7276_Name = {
    Text = "不可直视"
  },
  Event_7277_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7277_Desc = {
    Text = "古币上黏湿一片，像被污秽呕出的残渣，飘着肉眼可见的黑气。"
  },
  Event_7277_Name = {
    Text = "双面古币"
  },
  Event_7278_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7278_Desc = {
    Text = "敏锐的神经末梢发出致命的警告，你猛地一震，只得悻悻收手。\n又让你逃过了……\n诅咒？或是一次重生？"
  },
  Event_7278_Name = {
    Text = "双面古币"
  },
  Event_7279_ChoiceDesc1 = {
    Text = "【放飞蝴蝶】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7279_ChoiceDesc2 = {
    Text = "【成为蝴蝶】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7279_ChoiceDesc3 = {
    Text = "【吞回肚子】获得25黑印"
  },
  Event_7279_Desc = {
    Text = "这一夜发生了太多事。\n码头围攻，幽灵货轮，蹈海者，图鲁，墨菲，拉蒙娜……一切的一切都在漩涡中回转，被搅成了弥萨格餐厅早上七点的燕麦粥。\n想要向眼前的唤醒体提问，却根本不知道怎样提起，如鲠在咽——或者说，胃里的蝴蝶。"
  },
  Event_7279_Name = {
    Text = "蝴蝶效应"
  },
  Event_7280_ChoiceDesc1 = {
    Text = "【驱散幻象】失去(Arg3)点生命。"
  },
  Event_7280_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7280_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_7280_Name = {Text = "幻象"},
  Event_7281_ChoiceDesc1 = {
    Text = "【加入祈祷】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7281_ChoiceDesc2 = {
    Text = "【沉入大海】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」，「(Skill.Arg3)」"
  },
  Event_7281_ChoiceDesc3 = {
    Text = "【浮出水面】获得25黑印"
  },
  Event_7281_Desc = {
    Text = "「温柔的神明，无上的神明。\n请您平息凶恶的风暴，请您阻断湍急的水流。\n请让海洋成为我们深邃的家园，让它为我们的国蒙上永恒的面纱……」\n信徒的低语终于连成了你能理解的话语，但随之而来的，是难以摆脱的窒息。"
  },
  Event_7281_Name = {
    Text = "梦境祷文"
  },
  Event_7282_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7282_Desc = {
    Text = "你将手中剩余的肉块丢进猫群。\n群猫如黑色的潮水涌上前。它们发疯般撕咬肉块，又迅速一哄而散。\n很不幸，这是一块过期肉。能填饱干瘪的肚皮，却不怎么叫人痛快。"
  },
  Event_7282_Name = {Text = "猫之城"},
  Event_7283_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_7283_Desc = {
    Text = "一种近水银态的银色物质，由融蚀黏液中提炼而出，蕴含强大精神力，主要用于在仪式中链接更多唤醒体。"
  },
  Event_7283_Name = {Text = "银芯"},
  Event_7284_ChoiceDesc1 = {
    Text = "【离开】选择觉醒1名唤醒体，并降低其觉醒卡算力消耗2点。感染「(Skill.Arg1)」"
  },
  Event_7284_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7284_Desc = {
    Text = "或许此刻仍无法传达，但他们迟早会听见你们的呼唤声。"
  },
  Event_7284_Name = {
    Text = "指引之声"
  },
  Event_7285_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7285_Desc = {
    Text = "游荡的实验体已经让你很是疲惫，短暂的喘息也像是干涸沙漠中的甘霖。"
  },
  Event_7285_Name = {
    Text = "无尽门扉"
  },
  Event_7286_ChoiceDesc1 = {
    Text = "【离开】随机觉醒1名唤醒体"
  },
  Event_7286_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7286_Desc = {
    Text = "那声音必将指引你们的终点，这趟调查的答案。"
  },
  Event_7286_Name = {
    Text = "指引之声"
  },
  Event_7287_ChoiceDesc1 = {
    Text = "【仔细观察】"
  },
  Event_7287_Desc = {
    Text = "通过水晶球，你可以观察远方"
  },
  Event_7287_Name = {Text = "水晶球"},
  Event_7288_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7288_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_7288_Desc = {
    Text = "乌鸦停留在了衣柜上，尖锐的喙在木门上刻出诡异的纹路。"
  },
  Event_7288_Name = {
    Text = "提灯黑鸦"
  },
  Event_7289_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7289_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_7289_Name = {Text = "联络点"},
  Event_7290_ChoiceDesc1 = {
    Text = "【停留在此】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7290_ChoiceDesc2 = {
    Text = "【寻觅出口】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7290_Desc = {
    Text = "你跨入一片苍白的寂静中，交叠的大门无度地旋转着，漩涡般将你的身躯卷入其中。\n你头晕目眩地挣扎于颠倒的大门内，依稀辨认着逃离的方向，却不可避免地一次次坠入另一扇门。\n这次，你再次停在了一扇门前，门后涌动的未知散发着致命的吸引，你的理智却绷紧了弦。\n是，它的确致命。"
  },
  Event_7290_Name = {
    Text = "重门之外"
  },
  Event_7291_ChoiceDesc1 = {
    Text = "【陷入狂喜】删除1张指令卡，并回复 Arg1 点生命"
  },
  Event_7291_ChoiceDesc2 = {
    Text = "【停下脚步】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7291_Desc = {
    Text = "像被轻易撬开了头骨，你的脑内一阵呕吐般的眩晕，无形之手翻动搅弄大脑，本就趋于流体的物质碎成一滩。\n仿佛未经消化的粥状肠胃积物，早已摆脱了地心引力，倒灌入你空洞贫乏的大脑皮质。\n它揉搓、拌匀、抓弄，撒上剪碎的欢愉，将落日的遗篇揉进肉里。"
  },
  Event_7291_Name = {
    Text = "搅动大脑"
  },
  Event_7292_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7292_Desc = {
    Text = "跟骤然现身的地狱犬相比，常见的落雪不值得你投注精力。你无视了渐渐飘落的雪花，冲入暗夜。"
  },
  Event_7292_Name = {Text = "雪"},
  Event_7293_ChoiceDesc1 = {
    Text = "【接通】回复Arg2点生命。"
  },
  Event_7293_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_7293_Name = {Text = "联络点"},
  Event_7294_ChoiceDesc1 = {
    Text = "【感到恐惧】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7294_ChoiceDesc2 = {
    Text = "【坚定意志】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7294_Desc = {
    Text = "诡异的哀嚎声回荡不绝，伦蒂尼恩的万物却对此不做表态，像是已经死去，或是睡着。\n你无意识地徘徊在铁路桥下，回忆起阿利斯泰尔的叮嘱。\n他彬彬有礼地起身走来，口中似乎向你诉说着什么，话语却粘滞不清。\n你抬头，黑色浓稠液滴从他的口齿中溢出，封堵他的喉咙，阻塞他的语句——"
  },
  Event_7294_Name = {
    Text = "混沌哀嚎"
  },
  Event_7295_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_7295_Desc = {
    Text = "「当然，那是当然。不介意的话，我还会助你们一臂之力呢。」\n他为你们递上一把古朴的手持镜。\n「骑士已经登上棋盘，国王也不会在后盘等待太久。你们大概很快就要见到他了吧。真是令人期待。」"
  },
  Event_7295_Name = {
    Text = "怪异旅伴Ⅳ"
  },
  Event_7296_ChoiceDesc1 = {
    Text = "【撕碎信纸】删除2张卡牌"
  },
  Event_7296_ChoiceDesc2 = {
    Text = "【继续阅读】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7296_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_7296_Desc = {
    Text = "你眼前是喷涌而出的黑色蝶群，它们不断地溢出、拍击翅膀、再不断摔落在书桌上。\n铺展开的空白信纸溅满了墨迹，摔伤的蝴蝶们，奄奄一息地瘫在信纸表面。\n翅膀上附带的黑色黏液连缀成篇，被涂抹成禁忌的文字。\n你从打字机里抽出这张信纸。"
  },
  Event_7296_Name = {
    Text = "蝴蝶篇目"
  },
  Event_7297_ChoiceDesc1 = {
    Text = "【迎向蝴蝶】删除1张指令卡，获得Arg1黑印"
  },
  Event_7297_ChoiceDesc2 = {
    Text = "【不再流连】"
  },
  Event_7297_Desc = {
    Text = "最近的伦蒂尼恩流行着这样一句话：「蝴蝶在阿库特林地的一次振翅，或许能引起雷欧王国的一场风暴。」\n在看见蝴蝶喷涌而出时，你不由想起了这句话。\n这些蝴蝶，或许足以掀起一场淹没星球的 灾难。"
  },
  Event_7297_Name = {
    Text = "灵知风暴"
  },
  Event_7298_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_7298_Desc = {
    Text = "你将一根手指抵在唇角，示意自己将为此事噤声。\n黑猫幻影般一闪而过，在你脚边留下了黑亮的馈赠。"
  },
  Event_7298_Name = {
    Text = "夜猫之祸"
  },
  Event_7299_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7299_Desc = {
    Text = "祂像一段丝绸般滑入了你的提包，随着轻微的重量增加，你仿佛听到了一声轻微的道谢。\n此后再无声响。"
  },
  Event_7299_Name = {
    Text = "混沌之灵"
  },
  Event_7300_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7300_Desc = {
    Text = "混沌之灵的哭泣愈发尖锐，直到最后变为了刺耳的尖叫，响彻周身。\n祂带着你的供奉和无法脱身的悲苦，再次沉入泥潭。"
  },
  Event_7300_Name = {
    Text = "混沌之灵"
  },
  Event_7301_ChoiceDesc1 = {
    Text = "【如实填写】"
  },
  Event_7301_ChoiceDesc2 = {
    Text = "【乱写一气】"
  },
  Event_7301_Desc = {
    Text = "东区的街道错综复杂，不一会儿你就丢失了孩子们的身影。\n当你一筹莫展之时，一个神秘的女人向你搭话。\n「我知道孩子们去了哪里，不过，在告诉你之前，能否帮我一个小忙呢？」\n她拿出一张纸，冲你友好地微笑。\n「我叫克莱门汀，是一名心理医生，正在进行有关伦蒂尼恩居民的心理调查。如果你能帮我填写一下这个问卷。\n如实填写的话，我会很乐意为你和你的同伴提供一些帮助。」"
  },
  Event_7301_Name = {
    Text = "心理评估"
  },
  Event_7302_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7302_Desc = {
    Text = "「这也是我的选择。」捧着糖果的人影说，「但她会成为他的筹码，你将必须选择。\n世上并不存在完美的结局。」\n深重的悲伤将你淹没。人影消散，你扶着心口，不知刚才的究竟是投影，还是精神在重压下产生的幻觉。"
  },
  Event_7302_Name = {
    Text = "分岔的小径"
  },
  Event_7303_ChoiceDesc1 = {
    Text = "【金斧头】"
  },
  Event_7303_ChoiceDesc2 = {
    Text = "【银斧头】"
  },
  Event_7303_ChoiceDesc3 = {
    Text = "【我没有掉东西】"
  },
  Event_7303_Desc = {
    Text = "「跨越维度的先行者啊。」\n耳畔传来苍老的声音，似来自史前，似穿越万古。\n在极度紧张中，你听见那个声音问出了一个有些耳熟的问题。\n「你掉的，是这把金斧头，还是这把银斧头呢？」"
  },
  Event_7303_Name = {
    Text = "界外之音"
  },
  Event_7304_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_7304_Desc = {
    Text = "「哎呀，这……」她收回问卷，露出了有些无奈的神色，「算了，你毕竟赶时间。孩子们往那里去了，应该没走多远。」\n你匆匆转身，险些没能听清身后的低语。\n「反正，我们会再次见面的。」"
  },
  Event_7304_Name = {
    Text = "心理评估"
  },
  Event_7305_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7305_Desc = {
    Text = "「你是谁？」\n「我是那惨遭杀害的银钥使的阴影，凶手是一条狡猾的白化蛇。」\n「白化蛇？那是什么？」\n「一个失误。人与蛇杂交而生的……亵渎之物。」\n你还想继续追问，影子倏然散去，留下一地金色的尘埃。"
  },
  Event_7305_Name = {Text = "银钥使"},
  Event_7306_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」】"
  },
  Event_7306_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_7306_Desc = {
    Text = "事件355（开发中），非最终效果"
  },
  Event_7306_Name = {
    Text = "事件355（开发中）"
  },
  Event_7307_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7307_Desc = {
    Text = "沉进胃里，和蝴蝶共同飞舞。\n思绪的鳞粉与蝴蝶的交织洒落，在胃里下起一场簌簌白雪。\n你逐渐捋清了一切，下一个机会到来时，你一定会开口。"
  },
  Event_7307_Name = {
    Text = "蝴蝶效应"
  },
  Event_7308_ChoiceDesc1 = {
    Text = "【反驳它们】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7308_ChoiceDesc2 = {
    Text = "【附和它们】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7308_ChoiceDesc3 = {
    Text = "【提出新观点】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7308_Desc = {
    Text = "「请和我们保持距离。」\n成群的老鼠将你围在中心，与你保持着至少五英尺的距离。\n「我们努力繁衍，我们茁壮成长，我们从不挑食——于是我们带给人类疾病、焦虑和痛苦。」\n「我们和人类不应该走得太近，这不是你该来的地方。」\n为了使老鼠们放松警惕，你决定——"
  },
  Event_7308_Name = {Text = "鼠疫"},
  Event_7309_ChoiceDesc1 = {
    Text = "【打开铁门】感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」"
  },
  Event_7309_ChoiceDesc2 = {
    Text = "【不做理会】获得50黑印"
  },
  Event_7309_Desc = {
    Text = "这是一座典型的下承式拱桥，铁道旁的阶梯隐约通向一座铁门。门后传来规律而异常的咯噔咯噔声。\n你驻足观察门扉，只见其上挂着一把沉重的挂锁，但并未扣合。"
  },
  Event_7309_Name = {
    Text = "铁门之后"
  },
  Event_7310_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_7310_Desc = {
    Text = "面对诱惑，你不为所动。\n声音的主人颇感遗憾，水面恹恹地荡出几个涟漪，再无波澜。"
  },
  Event_7310_Name = {
    Text = "界外之音"
  },
  Event_7311_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」】"
  },
  Event_7311_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_7311_Desc = {
    Text = "事件353（开发中），非最终效果"
  },
  Event_7311_Name = {
    Text = "事件353（开发中）"
  },
  Event_7312_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」，获得50黑印"
  },
  Event_7312_Desc = {
    Text = "「你们人类再没有别的答案了吗？」\n声音的主人发出不耐的低吼，整个空间随之震颤。\n「贪婪且无知……这便是我厌倦你们的原因了。」"
  },
  Event_7312_Name = {
    Text = "界外之音"
  },
  Event_7313_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7313_Desc = {
    Text = "接受密境的安排，于得到中失去，享受被诅咒的拥抱。"
  },
  Event_7313_Name = {
    Text = "妄念喷涌"
  },
  Event_7314_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7314_Desc = {
    Text = "眼睛缓慢地眨了一下，不知道是否听懂了你的问话。\n一滴金红相间的泪水从眼角滴落，像一颗微小的星星，散发着太阳一样的暖光。它下落，下落，带着悲伤，带着哀悯，在砖石上碎成一小片尘埃。\n你猛地回过神，那个眼睛已经不见了。"
  },
  Event_7314_Name = {
    Text = "盲目注视"
  },
  Event_7315_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7315_Desc = {
    Text = "几个穿着简单，甚至有些脏兮兮的孩子在街上奔跑，身后追着一个穿着警服的大人。 其中一个孩子戴着令你有些眼熟的棕色兜帽。"
  },
  Event_7315_Name = {
    Text = "我们的回忆"
  },
  Event_7316_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7316_Desc = {
    Text = "「别再唱了——」\n你警告五音不全的歌者，休想再来祸害你的耳朵。"
  },
  Event_7316_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7317_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7317_Desc = {
    Text = "「停下步子！！！匍匐爬行的融蚀怪物都比你熟悉自己的四肢！」\n放过观众……\n你在心里这样祈祷。"
  },
  Event_7317_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7318_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7318_Desc = {
    Text = "黑泥滴落在你脸上，泛起了一阵麻痒。\n你无法忍受，伸手将蝴蝶拍开。\n蝴蝶躲过你不怀好意的动作，无声无息地消失在尽头。"
  },
  Event_7318_Name = {
    Text = "不应存在之物"
  },
  Event_7319_ChoiceDesc1 = {
    Text = "【表扬它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7319_Desc = {
    Text = "詹金说：快醒醒，强尼！写诗还不了你欠下的债务，也解决不了你家地板漏水的问题。\n你说：很不幸，你那些追求真理的细胞会以每天10万个的速度凋零，很快你就会变成一个真正的脑干。\n脑子无所谓地耸了耸肩——如果它有的话。\n脑子说：我思故我在。当你能达到我这样的思想深度，就再也不会关心脑干了。"
  },
  Event_7319_Name = {
    Text = "哲学之脑"
  },
  Event_7320_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7320_Desc = {
    Text = "钢琴轻轻地发出一声叹息，似是宽慰，又似是留恋，像极了什么人在一曲终了时的笑容。\n「只要孩子们……只要……」\n你还没来得及听清，钢琴的幻影便随风飘散。"
  },
  Event_7320_Name = {
    Text = "童年的旋律"
  },
  Event_7321_ChoiceDesc1 = {
    Text = "【离开】获得白银造物3选1，感染「(Skill.Arg1)」"
  },
  Event_7321_Desc = {
    Text = "你接过厚实的病历本并打开，发现扉页上写了「G·R」两个字。\n「哎呀，哎呀，这不是你的病历吗？」克莱门汀似乎毫不介意，「不过，钻研他人心理，也能提升对自己的认知呢。」\n还没等你询问，她的身影便彻底消失。"
  },
  Event_7321_Name = {Text = "病历本"},
  Event_7322_ChoiceDesc1 = {
    Text = "【离开】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7322_Desc = {
    Text = "你接过薄薄的病历本并打开，发现里面只有一张纸，上面只写了一句话。\n「在亘古的混沌之中，苍白的无目之眼在永恒注视。」\n你想要询问克莱门汀，却发现她早已不见了踪影。"
  },
  Event_7322_Name = {Text = "病历本"},
  Event_7323_ChoiceDesc1 = {
    Text = "【接通】回复所有生命。"
  },
  Event_7323_ChoiceDesc2 = {
    Text = "【冥想】选择觉醒1名唤醒体。"
  },
  Event_7323_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_7323_Name = {Text = "联络点"},
  Event_7324_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7324_Desc = {
    Text = "重要的物证，还是认真保存，交由历史系研究解析为宜。"
  },
  Event_7324_Name = {
    Text = "密令·上"
  },
  Event_7325_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7325_Desc = {
    Text = "骄阳自高天普照大地，刺穿迷障，唤醒倦怠的灵魂。"
  },
  Event_7325_Name = {Text = "仰角"},
  Event_7326_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7326_Desc = {
    Text = "你感到满足，祂们的窥视闪烁在你头顶的夜空，将目光聚焦彼身。"
  },
  Event_7326_Name = {
    Text = "穹顶之瞳"
  },
  Event_7327_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7327_Desc = {
    Text = "你无法逃避如坐针毡的注视，自然，也根本不能抗拒诸神的馈赠。"
  },
  Event_7327_Name = {
    Text = "穹顶之瞳"
  },
  Event_7328_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7328_Desc = {
    Text = "「你究竟是什么人？」你骇然发问。\n「不必关心这些。敌人的敌人就是朋友，不是吗？」男人微笑。\n「礼物留在座椅上了，祝你们好运。」"
  },
  Event_7328_Name = {
    Text = "怪异旅伴Ⅳ"
  },
  Event_7329_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7329_Desc = {
    Text = "拉蒙娜凑上前去，期望听到更多关于「白大褂」的消息。 「有人偷听！」留声机的声音骤然变大，「偷听，偷听，偷听！」"
  },
  Event_7329_Name = {
    Text = "他人之耳"
  },
  Event_7330_ChoiceDesc1 = {
    Text = "【离开】所有唤醒体回复Arg1狂气"
  },
  Event_7330_Desc = {
    Text = "你牵着男孩柔软的小手，穿过一扇又一扇门，最终来到一个小小的破旧舞台前。 \n男孩捏了捏你的手，以示感谢。\n 「谢谢你，再见。」"
  },
  Event_7330_Name = {
    Text = "终幕礼Ⅱ"
  },
  Event_7331_ChoiceDesc1 = {
    Text = "【继续坠落】获得白银造物「(RelicConfig.Arg1)」，是否继续下坠"
  },
  Event_7331_ChoiceDesc2 = {
    Text = "【抽身离开】获得25黑印"
  },
  Event_7331_Desc = {
    Text = "「你」邀请着你。\n在螺旋的深处，过去与未来的「你」向你送上来了来自不同维度的「赠礼」。"
  },
  Event_7331_Name = {
    Text = "螺旋深渊"
  },
  Event_7332_ChoiceDesc1 = {
    Text = "【守口如瓶】获得25黑印"
  },
  Event_7332_ChoiceDesc2 = {
    Text = "【伸手触碰】50%机会获得50黑印，50%机会一无所有"
  },
  Event_7332_Desc = {
    Text = "「我要说的只有一句箴言——没有人能杀死一只猫！」\n「那该死的黑猫本该被开膛破肚、曝尸荒野，它却刨开了我的家族墓穴，残存的人类腐肉被它吞吃殆尽，尸骨肢体则七零八落地散落。」\n「阴冷幽暗的竖瞳注视下，暗黄的脓液浮起一层恶臭，我连滚带爬地逃离了那里，被噩梦折磨得精神萎靡。」\n「等等……你们要做什么，我没有疯！我没有！你们一定是想掩盖什么！这是真的——」\n这的确是真的，目送癫狂之人的黑影消散，你和脚边安静蹲坐的黑猫对视一眼。"
  },
  Event_7332_Name = {
    Text = "夜猫之祸"
  },
  Event_7333_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7333_Desc = {
    Text = "你向他询问蜡像馆所在的方位。\n真奇怪，算上这回，今夜你们已经见了五次了。你为他点了五次火，问了五次路。\n可你还是不记得蜡像馆的位置，正如你和他还是会不断相遇。"
  },
  Event_7333_Name = {
    Text = "路灯下的身影"
  },
  Event_7334_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7334_ChoiceDesc2 = {
    Text = "【继续追逐孩子】离开"
  },
  Event_7334_Desc = {
    Text = "第三只乌鸦离开了，飞向了目光不可及之处，飞向了永恒的黑暗。"
  },
  Event_7334_Name = {
    Text = "黑鸦凝视"
  },
  Event_7335_ChoiceDesc1 = {
    Text = "【离开】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7335_Desc = {
    Text = "触手处的皮毛柔软细腻，还残留着库姆生命的温热。\n那是日落前的最后一缕夕阳，转瞬即逝的余温。"
  },
  Event_7335_Name = {Text = "余温"},
  Event_7336_ChoiceDesc1 = {
    Text = "【追上去】"
  },
  Event_7336_Desc = {
    Text = "你仔细搜索了墙面，终于在草丛后发现一个掩藏的下水道入口。你钻过下水道，但怪物早已跑远。"
  },
  Event_7336_Name = {Text = "死路"},
  Event_7337_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7337_Desc = {
    Text = "禽鸟之间自有规则，它们不依照你的意志而行动，你也无权干涉自然的规律。"
  },
  Event_7337_Name = {
    Text = "离群之鸦"
  },
  Event_7338_ChoiceDesc1 = {
    Text = "【俯瞰倒影】获得25黑印"
  },
  Event_7338_ChoiceDesc2 = {
    Text = "【你还好吗？】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7338_Desc = {
    Text = "「你、你知道吗……隔壁新来的那个老板娘，总是闭门不出的……我那天请她喝了一杯啤酒，在泡沫完全消失之后，我突然发现……酒杯里的她、她没有影子！」"
  },
  Event_7338_Name = {
    Text = "记忆碎片·啤酒"
  },
  Event_7339_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7339_Desc = {
    Text = "「我好想和你再一起唱歌……」\n莎拉癫狂扭曲的哀鸣骤然停顿，变形的面部透露出一丝迷茫。"
  },
  Event_7339_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_7340_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_7340_Desc = {
    Text = "「好开心！好开心！」嘈杂尖锐而充满童真的声音在你的耳边响起，「送给你，送给你！」"
  },
  Event_7340_Name = {
    Text = "夜色精灵"
  },
  Event_7341_ChoiceDesc1 = {
    Text = "【厚实的病历本】"
  },
  Event_7341_ChoiceDesc2 = {
    Text = "【薄薄的病历本】"
  },
  Event_7341_Desc = {
    Text = "一个颇为熟悉的声音叫住了你，你眯起眼睛，却怎么也看不清她的身形。\n「我知道你在赶时间，」克莱门汀医生语调轻快，「我保证不会耽误你太久。」\n两只手穿透脑中的迷雾而来，上面各拿了一本病历本，一本厚实且有磨损，一本薄而簇新。\n「根据你的问卷结果，我擅自给你做了一份病历。不过，我一时忘了哪本是你的，不如你来挑选一下？」\n不知为何，薄的病历本上传来了一股熟悉的气息，和你与唤醒体之间的精神联系隐隐共鸣。"
  },
  Event_7341_Name = {Text = "病历本"},
  Event_7342_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7342_Desc = {
    Text = "一面寻常的墙壁，你忍不住敲了敲，却觉得似乎不是实心"
  },
  Event_7342_Name = {
    Text = "奇怪的墙壁"
  },
  Event_7343_ChoiceDesc1 = {
    Text = "【我又不在水面上】随机1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7343_ChoiceDesc2 = {
    Text = "【低头查看】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7343_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7343_Desc = {
    Text = "「嘻嘻，守密人，你还记得温柯尔的叮嘱吗？听着，不·要·在·正·午·时·分·俯·瞰·自·己·的·倒·影。」"
  },
  Event_7343_Name = {
    Text = "无形倒影"
  },
  Event_7343_Tips1 = {
    Text = "尚未拥有白银造物"
  },
  Event_7344_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7344_Desc = {
    Text = "来自遥远未来的幻影，隐没在艾尔沃斯的山隘。"
  },
  Event_7344_Name = {
    Text = "火山幻影"
  },
  Event_7345_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7345_Desc = {
    Text = "蝴蝶在你的掌心碎裂，如同被猛然击碎的玻璃天花板，破缺的残片向着地心引力坠落，坠落，坠落——"
  },
  Event_7345_Name = {
    Text = "钢桥的幻觉"
  },
  Event_7346_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7346_Desc = {
    Text = "等他们从暗影中现身再说吧。"
  },
  Event_7346_Name = {
    Text = "提灯黑鸦"
  },
  Event_7347_ChoiceDesc1 = {
    Text = "【打开开关】扩大当前视野。"
  },
  Event_7347_Desc = {
    Text = "前人遗留下来的照明装置，能驱散四周的黑色迷雾。\n它周围的雾气规律地波动着，像是被它的呼吸惊扰。"
  },
  Event_7347_Name = {Text = "探照灯"},
  Event_7348_ChoiceDesc1 = {
    Text = "【指出问题】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7348_ChoiceDesc2 = {
    Text = "【咽下疑问】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_7348_Desc = {
    Text = "直到现在，你还在回味墨菲讲述的过去。\n回忆让与你共感，紧紧桎梏、挤压着你的大脑，就连最后戈利亚对墨菲的那番开解都没能让你感到慰藉。\n……等等，他们说，星辰正位之时在二十五年后……\n可眼前的墨菲，分明只是个半大孩子……"
  },
  Event_7348_Name = {
    Text = "被禁锢的生命"
  },
  Event_7349_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_7349_Desc = {
    Text = "她应该落泪的，没人比她更有资格哭泣。\n可是，她为什么没有呢？她为什么只是置身事外呢，就好像那些人跪拜的不是她一样……"
  },
  Event_7349_Name = {
    Text = "航前典仪"
  },
  Event_7350_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7350_Desc = {
    Text = "无论如何，打探他人隐私是不礼貌的行为。"
  },
  Event_7350_Name = {
    Text = "见字如晤"
  },
  Event_7351_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7351_Desc = {
    Text = "一定只是一时眼花。"
  },
  Event_7351_Name = {
    Text = "黑鸦凝视"
  },
  Event_7352_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_7352_Desc = {
    Text = "记忆中所有人都对她祈祷着，哀求着。你忍不住也在心中默念着……"
  },
  Event_7352_Name = {
    Text = "航前典仪"
  },
  Event_7353_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_7353_Desc = {
    Text = "黑猫的身下淅淅沥沥地滴下不少黑色粘液，粘液汇聚的小溪直连向巷口的下水道。见你没有凑近的意思，黑猫掉头跃入下水道，不见踪影。"
  },
  Event_7353_Name = {
    Text = "夜色精灵"
  },
  Event_7354_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7354_Desc = {
    Text = "你惊慌不已，发出刺耳的尖叫声。\n似是被你的声音所惑，原本焦躁不安的手迟疑了一瞬。\n你抓住这个机会立刻逃了出去。"
  },
  Event_7354_Name = {
    Text = "黯色沼泽"
  },
  Event_7355_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7355_Desc = {
    Text = "扭曲、蠕动、爬行……你用尽一切方法来摆脱这些恼人的手臂。\n最终你还是逃了出去，代价是一套簇新的校服、两根肋骨和几百根头发。"
  },
  Event_7355_Name = {
    Text = "黯色沼泽"
  },
  Event_7356_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7356_Desc = {
    Text = "「正常现象，别大惊小怪的，像是个初出茅庐的新手一样，」\n朵尔凑近前，帮你正了正胸针的位置，「说明附近有特殊维度的通道。看起来就在疯人院的方向。」"
  },
  Event_7356_Name = {
    Text = "不安的胸针"
  },
  Event_7357_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7357_Desc = {
    Text = "你没有道理接受提灯教众饲喂之物的要求。\n乌鸦不满地晃动着污浊可怖的堆叠头颅，发出你在坟墓边才会听见的怪声，嚎叫着飞走了。"
  },
  Event_7357_Name = {
    Text = "诅咒怪鸦"
  },
  Event_7358_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7358_Desc = {
    Text = "「这也是我的选择。」抱着小熊的人影说，「但她会成为他的傀儡，而他们都会死去。\n你，将是那个罪恶的帮凶。」\n强烈的愧疚将你淹没。人影消散，你扶着心口，不知刚才的究竟是投影，还是精神在重压下产生的幻觉。"
  },
  Event_7358_Name = {
    Text = "分岔的小径"
  },
  Event_7359_ChoiceDesc1 = {
    Text = "【继续捂住耳朵】获得狂气值最高的唤醒体狂气值等同数量黑印(Arg1)"
  },
  Event_7359_ChoiceDesc2 = {
    Text = "【继续捂住耳朵】回复(Arg1)点生命，拥有的黑印将提高回复量"
  },
  Event_7359_Desc = {
    Text = "你依从了耳畔不怀好意的劝慰，尖啸如针尖般扭动着刺入你的耳孔。\n「停下——快停下——我都已经按你说的做了——快停——」\n你痛苦地捂住头颅，恍惚间听见了鸦群的嘲弄。"
  },
  Event_7359_Name = {
    Text = "群鸦之歌"
  },
  Event_7360_ChoiceDesc1 = {
    Text = "【抓住一只乌鸦】每拥有1名已觉醒唤醒体获得25黑印"
  },
  Event_7360_ChoiceDesc2 = {
    Text = "【发出尖啸】选择觉醒1名唤醒体并对其觉醒卡添加「固有」与「保留」效果"
  },
  Event_7360_Desc = {
    Text = "你玩心骤起，伸手抓住了一只乌鸦。\n它在你掌心绝望地挣扎着，最终炸成一团温暖的水浆。"
  },
  Event_7360_Name = {
    Text = "群鸦之歌"
  },
  Event_7361_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7361_Desc = {
    Text = "你捂着耳朵闭起双眼。\n咚咚，咚咚……你的心跳与尖啸声交织，谱写出一曲纷乱的死亡之歌。\n这一刻，你感到前所未有的宁静。"
  },
  Event_7361_Name = {
    Text = "群鸦之歌"
  },
  Event_7362_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7362_Desc = {
    Text = "密境中危机四伏，不是所有的光都是指引前路的灯塔。\n那也可能是引诱飞蛾的烛火。"
  },
  Event_7362_Name = {
    Text = "暗夜荧光"
  },
  Event_7363_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7363_Desc = {
    Text = "「你早就死了，也回不了家。」 你的声音冷酷得像罗斯雪原上呼啸的风。 旅人的表情没有任何变化，仿佛事情本该如此。他再度抓住你的手，「请救救我。 我是一名士兵，奉命前往遥远的东方……」"
  },
  Event_7363_Name = {Text = "吞噬者"},
  Event_7364_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7364_Desc = {
    Text = "电报机已经损坏。你能想象电报机的主人在风暴中的绝望……因为此刻的你也是。"
  },
  Event_7364_Name = {
    Text = "无声电报"
  },
  Event_7365_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7365_Desc = {
    Text = "「向前五十码左拐，然后右拐，再左拐……\n然后一直走到头，你家就在那里。」\n旅人开心极了。他向你挥挥手，随后便离开了。\n你长舒一口气，忽然感觉有人抓住了你的手。耳畔再度响起那个熟悉的声音：\n「请救救我。\n我是一名士兵，奉命前往遥远的东方……」"
  },
  Event_7365_Name = {Text = "吞噬者"},
  Event_7366_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7366_Desc = {
    Text = "你终于走出了这座迷宫。\n那一刻你忽然明白了，这座蜡像馆是个活物。\n一切诡谲、美和残酷，都以一种古老的仪式联结在一起。\n而仪式的眼睛，就是罗杰斯。"
  },
  Event_7366_Name = {
    Text = "眼睛的迷宫"
  },
  Event_7367_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7367_Desc = {
    Text = "「角色扮演有意思吗，守密人？」拉蒙娜扯了扯你的袖口，「出口离我们不远了，希望您在达芙黛尔夫人面前也能保持此刻的风趣。」"
  },
  Event_7367_Name = {
    Text = "回忆碎片·旧梦重现"
  },
  Event_7368_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7368_Desc = {
    Text = "「唤醒体很难反抗链接者的意志，」你回应道，「但我们不会放弃。」"
  },
  Event_7368_Name = {
    Text = "她的选择"
  },
  Event_7369_ChoiceDesc1 = {
    Text = "【进入】穿过墙壁，一探究竟。"
  },
  Event_7369_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7369_Desc = {
    Text = "你靠近墙壁，墙面突然扭曲起来，似乎想要将你吸入"
  },
  Event_7369_Name = {
    Text = "扭曲的空间"
  },
  Event_7370_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7370_Desc = {
    Text = "「不，这不是真的。比起蟑螂，你们至少有毛茸茸的身体。\n没人能拒绝毛茸茸的身体。」\n老鼠们窃窃私语，最终勉强同意了你的观点。\n「还好啦……其实也没有很多毛。」\n被夸赞总是令人高兴的。临走前，老鼠们送了你一件小小的礼物。"
  },
  Event_7370_Name = {Text = "鼠疫"},
  Event_7371_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7371_Desc = {
    Text = "「我同意！人类和老鼠不共戴天！」\n老鼠们有点生气，露出白花花的獠牙。\n「那你还在这里做什么？拿走你的东西，永远不要回来。」"
  },
  Event_7371_Name = {Text = "鼠疫"},
  Event_7372_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7372_Desc = {
    Text = "欢迎来到深海之下，这里每走一步都会有重重压力。\n\n不可透光的混沌迷雾将一切隐匿其中，你能在重压之下通过这片无光之海么？"
  },
  Event_7372_Name = {
    Text = "覆潮之下"
  },
  Event_7373_ChoiceDesc1 = {
    Text = "【随便看看】删除1张卡牌"
  },
  Event_7373_ChoiceDesc2 = {
    Text = "【仔细看看】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7373_Desc = {
    Text = "「嗒嗒……」\n打字机如同喝多了威士忌的老酒鬼，吞吞吐吐地往外吐出黑色的油墨。\n你敏锐地捕捉到「梅森」的字样，立刻将打字纸抽出。"
  },
  Event_7373_Name = {Text = "打字机"},
  Event_7374_ChoiceDesc1 = {
    Text = "【直视眼睛】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7374_ChoiceDesc2 = {
    Text = "【闭上双眼】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_7374_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7374_Desc = {
    Text = "无数眼睛环绕在你耳边低语。\n「我们旅行，我们停下，我们大步流星走过了数万年甚至更长时间。\n当太阳在凝望中逐渐暗淡，当旧地球的生命被洪水湮没。\n我们早已被宇宙的奥秘深深吸引。」"
  },
  Event_7374_Name = {Text = "眼"},
  Event_7375_ChoiceDesc1 = {
    Text = "【遵从指示】提升 Arg1 点生命"
  },
  Event_7375_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7375_Desc = {
    Text = "你尝试用银钥匙的追溯之力寻找最近的联络点，但获得的信息中夹杂着难以察觉的异常，似乎被干扰了。"
  },
  Event_7375_Name = {
    Text = "异常联络"
  },
  Event_7376_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7376_Desc = {
    Text = "你用弥萨格学生套装中配置的标准亚麻布手帕轻轻揩拭打字机的表面。\n打字机又恢复了平静。至于脏污的手帕……就让它留在密境中吧。"
  },
  Event_7376_Name = {
    Text = "打字机的低语"
  },
  Event_7377_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7377_Desc = {
    Text = "你定睛去细看，晃动重叠的墨痕中依稀浮现出一个名字，「Fingal Johansen」。\n这是谁？"
  },
  Event_7377_Name = {
    Text = "打字机的低语"
  },
  Event_7378_ChoiceDesc1 = {
    Text = "【仰头直视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7378_ChoiceDesc2 = {
    Text = "【太阳的仰角？】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7378_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7378_Desc = {
    Text = "「现在，立刻抬头看向东南方，太阳的仰角正在其位。」通讯器中传来朵尔的指令。"
  },
  Event_7378_Name = {Text = "仰角"},
  Event_7379_ChoiceDesc1 = {
    Text = "【感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」】"
  },
  Event_7379_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_7379_Desc = {
    Text = "事件354（开发中），非最终效果"
  },
  Event_7379_Name = {
    Text = "事件354（开发中）"
  },
  Event_7380_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7380_Desc = {
    Text = "孩子们的声音从琴键下流出。\n「老查理有一只他很爱的虎斑猫……」\n孩子们的歌声之下，一个年轻女性的声音也在轻轻温柔歌唱。\n是你听错了吗？"
  },
  Event_7380_Name = {
    Text = "童年的旋律"
  },
  Event_7381_ChoiceDesc1 = {
    Text = "【转身】获得25黑印"
  },
  Event_7381_ChoiceDesc2 = {
    Text = "【继续前行】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7381_Desc = {
    Text = "身后传来脚步声。\n如影子一般不疾不徐、不紧不慢。\n和你的脚步声交织在一起，回荡在空旷的陈列室里。"
  },
  Event_7381_Name = {Text = "牛津鞋"},
  Event_7382_ChoiceDesc1 = {
    Text = "【收起信纸】删除2张卡牌"
  },
  Event_7382_ChoiceDesc2 = {
    Text = "【保留信纸】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7382_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_7382_Desc = {
    Text = "一台新式打字机。\n它有一套与众不同的字母键，就像显微镜一样华丽又精巧。\n你正沉迷于它完美的机械结构，黑色的字迹忽然显现。\n「尊敬的罗杰斯先生，\n我们怀着沉重的心情通知您，您已经被学院开除。\n众所周知，@2学院一直以严谨的治学态度闻名王国境内，那些惊世骇俗的传言@3深深的困扰……」"
  },
  Event_7382_Name = {
    Text = "见字如晤"
  },
  Event_7383_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7383_Desc = {
    Text = "远方的停滞的怀表像是某种催促，提醒你们不要沦陷于时空的陷阱中。"
  },
  Event_7383_Name = {
    Text = "祂的注视"
  },
  Event_7384_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7384_Desc = {
    Text = "黑泥滴落在你脸上，泛起了一阵麻痒。\n你无法忍受，伸手将蝴蝶拍开。\n蝴蝶躲过你不怀好意的动作，无声无息地消失在尽头。"
  },
  Event_7384_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7385_ChoiceDesc1 = {
    Text = "【仔细观察】"
  },
  Event_7385_ChoiceDesc2 = {
    Text = "【挖掘】"
  },
  Event_7385_Desc = {
    Text = "库姆背着你们三人在疯人院内寻找入口。\n突然，它一个急刹，险些将你们震下背脊。\n在你们的疑问声中，库姆低着头，在松软的土面上嗅探着，扭头向你们示意，似乎是下方埋着什么"
  },
  Event_7385_Name = {
    Text = "深埋之物"
  },
  Event_7386_ChoiceDesc1 = {
    Text = "【领取】获得3选1黄金造物"
  },
  Event_7386_Desc = {
    Text = "那里空无一物，漆黑的液体横流于地面上，倒映不出任何。\n是你的错觉吗？你感觉什么东西在指缝溜走。"
  },
  Event_7386_Name = {
    Text = "镜面之下"
  },
  Event_7387_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7387_Desc = {
    Text = "黑色的羽翼落在小巷潮湿的泥土底上，化为黑泥状的融蚀浆。"
  },
  Event_7387_Name = {
    Text = "躁乱鸦群"
  },
  Event_7388_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7388_Desc = {
    Text = "「达芙黛尔女士会喜欢你的幽默的。」拉蒙娜挥挥手，薄雾般的幻影随之流散，「别让自己成为维度旅行的代价。」"
  },
  Event_7388_Name = {
    Text = "回忆碎片·旧梦重现"
  },
  Event_7389_ChoiceDesc1 = {
    Text = "【领取】获得3选1黄金造物"
  },
  Event_7389_Desc = {
    Text = "哦是的，那个可憎的倒影就是你自己。\n喷薄而出的恶意与你脚下的黑浆融作一团，扭曲地共舞着，如果不介意，它也想攀上你的肩头。"
  },
  Event_7389_Name = {
    Text = "镜面之下"
  },
  Event_7390_ChoiceDesc1 = {
    Text = "【原地不动】获得25黑印"
  },
  Event_7390_ChoiceDesc2 = {
    Text = "【随意走动】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7390_Desc = {
    Text = "你将自己的影子踩得粉碎，坠入了一滩夜色中。\n那破损得七零八落的黑影，是那个失去行踪的世界里，与你相连的唯一之物。\n真的要在漆黑的噩梦中行走吗？你还尚未寻到方向。"
  },
  Event_7390_Name = {
    Text = "噩梦行者"
  },
  Event_7391_ChoiceDesc1 = {
    Text = "【寻找源头】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7391_ChoiceDesc2 = {
    Text = "【重播唱片】所有唤醒体回复50狂气，感染「(Skill.Arg1)」"
  },
  Event_7391_ChoiceDesc3 = {
    Text = "【拆掉留声机】获得3选1刻印"
  },
  Event_7391_Desc = {
    Text = "你遇见一个废旧的老式留声机。\n拧上了发条，你将唱针抵上遍布划痕的黑胶唱片，交响乐失真得仿佛胶带撕黏后的拉扯，管乐和弦乐互殴，没有一个声部能从这首曲子中全身而退。\n乐曲滋滋啦啦的结尾处，你却听见了一阵规律的敲击。\n「咚咚……咚咚咚……咚……」\n你皱起眉，拨开了唱针，可敲击声依旧如故。"
  },
  Event_7391_Name = {
    Text = "迷踪留声"
  },
  Event_7392_ChoiceDesc1 = {
    Text = "【端详光辉】选择1个造物变化为诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_7392_ChoiceDesc2 = {
    Text = "【触摸光辉】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7392_ChoiceDesc3 = {
    Text = "【转身离开】获得25黑印"
  },
  Event_7392_Desc = {
    Text = "幻梦视野之下，密境迷雾为现实披上了墨色的纱。入目一切都若隐若现，似有若无。\n朦胧中，有什么东西的光辉穿透了迷雾。如灯塔之于游船，炊烟之于迷童，指引着安全的方向。"
  },
  Event_7392_Name = {
    Text = "暗夜荧光"
  },
  Event_7393_ChoiceDesc1 = {
    Text = "【暂停音乐】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7393_ChoiceDesc2 = {
    Text = "【与它对话】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7393_ChoiceDesc3 = {
    Text = "【静心聆听】获得25黑印"
  },
  Event_7393_Desc = {
    Text = "你从一滩污浊的黑浆中，捻起几粒破碎的记忆。\n晶体透亮含光，几缕游丝在其内摇曳翻飞，残存的记忆碎屑如被风吹散的沙砾，飞扬在半空。\n混乱、离奇、吊诡的画面在你身侧升腾。\n你看向——\n"
  },
  Event_7393_Name = {
    Text = "银月碎片"
  },
  Event_7394_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7394_Desc = {
    Text = "你伸手接住几枚落雪，定睛细看。那雪花融化成的并非晶莹的水滴，而是浓稠黑暗的融蚀浆。"
  },
  Event_7394_Name = {Text = "雪"},
  Event_7395_ChoiceDesc1 = {
    Text = "【我又不在水面上】随机1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7395_ChoiceDesc2 = {
    Text = "【低头查看】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7395_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7395_Desc = {
    Text = "雾气散去，一只枯瘦的手掌，递到了你的面前。\n它似乎被腐蚀掉了血肉，崎岖不平的掌面上覆盖着粘稠的黑浆，而它身上，则坠满了流淌着金光的戒指项链。\n它朝你勾了勾手，似乎是在引你靠近。\n只有在危机的阴翳下，珍宝才显得尤为闪耀。"
  },
  Event_7395_Name = {
    Text = "翻覆魔爪"
  },
  Event_7395_Tips1 = {
    Text = "尚未拥有白银造物"
  },
  Event_7396_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7396_Desc = {
    Text = "幻影向你招了招手，然后消失了。留给你的只有寒冷的冰雪和巍峨的山脉。"
  },
  Event_7396_Name = {
    Text = "火山幻影"
  },
  Event_7397_ChoiceDesc1 = {
    Text = "【银月的葬礼】选择1个造物变化为诅咒造物「(RelicConfig.Arg1)」"
  },
  Event_7397_ChoiceDesc2 = {
    Text = "【银月的祷告】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7397_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7397_Desc = {
    Text = "你从一滩污浊的黑浆中，捻起几粒破碎的记忆。\n晶体透亮含光，几缕游丝在其内摇曳翻飞，残存的记忆碎屑如被风吹散的沙砾，飞扬在半空。\n混乱、离奇、吊诡的画面在你身侧升腾。\n你看向——"
  },
  Event_7397_Name = {
    Text = "银月碎片"
  },
  Event_7398_ChoiceDesc1 = {
    Text = "【加点燃料】获得3选1刻印"
  },
  Event_7398_ChoiceDesc2 = {
    Text = "【熄灭它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7398_Desc = {
    Text = "「我是那惨遭杀害的侍女的阴影，凶手是那片虚假的碧绿火焰。」\n微红的暗淡火苗身姿摇曳，向你控诉。\n「我曾活在那片映出的凸月湖畔，灿烂夺目，光芒万丈。」"
  },
  Event_7398_Name = {
    Text = "微暗的火"
  },
  Event_7399_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7399_Desc = {
    Text = "你和影子站在路灯下，谁也没有说话。\n今天晚上没有月亮，所有的房子都静悄悄的。\n你朝影子挥了挥手，转身离去。"
  },
  Event_7399_Name = {
    Text = "路灯下的身影"
  },
  Event_7400_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得Arg1黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7400_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_7400_Desc = {
    Text = "乌鸦停留在了床头，用泛红的双眼注视着你。"
  },
  Event_7400_Name = {
    Text = "提灯黑鸦"
  },
  Event_7401_ChoiceDesc1 = {
    Text = "【说自己没有钱包】获得3选1刻印"
  },
  Event_7401_ChoiceDesc2 = {
    Text = "【将网打破】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7401_Desc = {
    Text = "橙黄色的网在空中静静地漂浮，它孔洞稀疏，远不如墙根上栖息了一只蜘蛛的远亲来得精致。\n你忍不住伸手触碰，脆弱的网瞬间溶解，孩子们的欢笑在你耳边响起。\n「金的银的黄的红的，所有钱包的都是我们的！」"
  },
  Event_7401_Name = {
    Text = "迷走网路"
  },
  Event_7402_ChoiceDesc1 = {
    Text = "【维修电报机】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7402_ChoiceDesc2 = {
    Text = "【掩埋电报机】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_7402_ChoiceDesc3 = {
    Text = "【无视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7402_Desc = {
    Text = "你躲进狭长的山洞裂隙，暂避风雪。但你深知自己无法在这里停滞太久，若是那群黑袍的怪人找到此处，你将无路可逃。\n在狭缝的角落里，你居然发现了一台破损的电报机。"
  },
  Event_7402_Name = {
    Text = "前人遗物"
  },
  Event_7403_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7403_Desc = {
    Text = "你曾在王国境内许多地方见过这样的肖像画。\n「那位女王」位于画面中央，在黑色玫瑰的簇拥下熠熠生辉。\n只除了一点——她的脸被无情剜掉，留下一片烧焦的黑色空洞。\n你至今仍无法得见女王的真实面目。"
  },
  Event_7403_Name = {
    Text = "肖像回廊"
  },
  Event_7404_ChoiceDesc1 = {
    Text = "【放过她】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7404_ChoiceDesc2 = {
    Text = "【帮助她】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7404_ChoiceDesc3 = {
    Text = "【我要走自己的路】获得50黑印"
  },
  Event_7404_Desc = {
    Text = "三个人影拦住了你的去路。\n「你可以放过她，」双手抱着沾满融蚀浆的小熊玩偶的人影开口，「她只是胆怯，而不邪恶。她不想伤害任何人。」\n「你可以帮助她，」双手捧着一把包装精致的糖果的人影开口，「你能够做到她不能做到的事情，你能够结束这一切。」\n「你不需要听我们的，」双手空空如也的人影开口，「你有你自己的路。」"
  },
  Event_7404_Name = {
    Text = "分岔的小径"
  },
  Event_7405_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7405_Desc = {
    Text = "达芙黛尔的声音停顿了片刻。\n「哦呀，你选择了这个吗？不错的选择，作为奖励，我会特别送你一个礼物。」\n「我对那个孩子并不熟悉，但我对弗朗西斯有一个猜想。我觉得，支配她、让她获得了「看见」的力量的情绪，是强烈的悔恨。不知道她会为这悔恨做出怎样的选择呢……」"
  },
  Event_7405_Name = {
    Text = "提示时间"
  },
  Event_74068_ChoiceDesc1 = {
    Text = "【纳入脑缸】将「备用脑缸」洗入抽牌堆。"
  },
  Event_74068_Desc = {
    Text = "浮雕繁复的圆拱门内，红砖外墙的斜顶上、墙壁豁口的排屋前，拉长的影子跃动着，渴求着问题的答案。\n平庸就意味着死亡吗？\n安于现状就注定薪尽火灭吗？"
  },
  Event_74068_Name = {
    Text = "尚未流失的意识"
  },
  Event_74069_ChoiceDesc1 = {
    Text = "【继续容纳】选择至多 2 张指令卡从牌库中删除，并将它们置入「备用脑缸」。"
  },
  Event_74069_Desc = {
    Text = "「我看见了他们。许多人，许多梦呓，智慧的，肤浅的，理智的，疯狂的。有时候，灰烬中也会诞生希望的火星。」"
  },
  Event_74069_Name = {
    Text = "尚未流失的意识"
  },
  Event_7406_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7406_Desc = {
    Text = "你小心地将老鼠从天平上取下，它平缓地呼吸着，毛茸茸的躯体温暖了你的掌心。"
  },
  Event_7406_Name = {
    Text = "理智与情感"
  },
  Event_7407_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7407_Desc = {
    Text = "黯淡的银芯迸发出耀目光芒，转瞬即逝，手中只剩下一把与沙土无异的灰烬。\n银芯耗尽了最后的灵知，不知名的灵魂未能重铸肉身，但在完全消逝前，也留下了存在过的痕迹。"
  },
  Event_7407_Name = {
    Text = "存在的证明"
  },
  Event_7408_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7408_Desc = {
    Text = "「我对那个孩子并不熟悉，但我对弗朗西斯有一个猜想。我觉得，支配她、让她获得了『看见』的力量的情绪，是强烈的悔恨。不知道她会为这悔恨做出怎样的选择呢……」"
  },
  Event_7408_Name = {
    Text = "提示时间"
  },
  Event_7409_ChoiceDesc1 = {
    Text = "【把纸抽出来】删除1张卡牌"
  },
  Event_7409_ChoiceDesc2 = {
    Text = "【现在不是时候】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7409_Desc = {
    Text = "手提箱内的便携打字机忽然自己活动起来，打出半页歪歪扭扭的文字。\n 「你已经看见祂了，祂就在你的身侧，那些被疯狂污染的，狂热的影子……不要直视祂的轮廓。」"
  },
  Event_7409_Name = {
    Text = "不请自来的警告"
  },
  Event_7410_ChoiceDesc1 = {
    Text = "【向左走】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7410_ChoiceDesc2 = {
    Text = "【向右走】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7410_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7410_Desc = {
    Text = "你似乎走入了一个迷宫。\n向左、向右、再向左……你逐渐失却耐心，直到你抬起头，看见了那只眼睛。\n眼睛注视着你们，平静威严，仿佛它才是这里的主宰。"
  },
  Event_7410_Name = {
    Text = "眼睛的迷宫"
  },
  Event_7411_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7411_Desc = {
    Text = "你奋力抽回双手，并清晰地听到了骨头碎裂的声音。\n这是你为好奇心付出的代价。"
  },
  Event_7411_Name = {
    Text = "灵感迸发"
  },
  Event_7412_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7412_Desc = {
    Text = "你妥善检查了一番相机，皮革与黑金嵌在机体中，折射出几分油亮的光泽。\n它的镜头对准了你，仿佛在凝视，在窥探……"
  },
  Event_7412_Name = {
    Text = "记录无罪"
  },
  Event_7413_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7413_Desc = {
    Text = "你毫不留情地扯出了另外半截胶片，它们藏身于相机肚内，骤然被拉出，上面的画面却叫你久久无言。\n未经冲洗的胶片，忠实地记录下了——你倒在一滩黑泥中的画面。"
  },
  Event_7413_Name = {
    Text = "记录无罪"
  },
  Event_74145_ChoiceDesc1 = {
    Text = "【阅读】删除1张指令卡，获得25黑印"
  },
  Event_74145_ChoiceDesc2 = {
    Text = "【继续打字】复制一张牌库中的牌，感染「(Skill.Arg1)」"
  },
  Event_74145_Desc = {
    Text = "打印机猛烈地喷吐着油墨。\n黑色的油墨如同幽灵般从喷嘴中喷涌而出，弥漫在空气中，形成了一片浓烈而压抑的黑雾。\n键盘上似乎藏着某种暗示，等待无辜的手指触碰。"
  },
  Event_74145_Name = {
    Text = "幽灵油墨"
  },
  Event_74146_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74146_Desc = {
    Text = "你侧身踏入暗巷，雾气啃噬着衣角，可那影子却在身后裂变成无数双眼睛。锈蚀的钟声裹挟着潮湿的预兆。\n\n你知道，所有迂回的道路终将坍缩成循环的茧——在腐烂的黎明前，你与自己的倒影终会重逢。"
  },
  Event_74146_Name = {
    Text = "时间灰烬"
  },
  Event_74147_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74147_Desc = {
    Text = "你在胸口默默绘下轮廓，为逝者献上无言的祷告。\n在这个湮灭的世界中，有太多你无法拯救的东西。\n骨骸闪烁着，主人生前珍藏的宝物透出一角。"
  },
  Event_74147_Name = {
    Text = "褪色遗骨"
  },
  Event_74148_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74148_Desc = {
    Text = "「父神感念你的慈悲。父神将看顾我们，救赎我们脱离苦难的重担。」\n\n她的幻影渐渐消散，圣乐之声也化作无情的风呼啸而过。"
  },
  Event_74148_Name = {
    Text = "管风琴的祷告"
  },
  Event_74149_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74149_Desc = {
    Text = "你轻轻推了推裸露的骸骨，它自然而迟缓地陷没入黑色的黏液，消失得无影无踪。\n愿灵魂在虚无中得到安息。"
  },
  Event_74149_Name = {
    Text = "褪色遗骨"
  },
  Event_7414_ChoiceDesc1 = {
    Text = "【离开】你战胜了对手，无事发生"
  },
  Event_7414_Desc = {
    Text = "「看来，小家伙得吃点苦头，才能知道女人的秘密是不能轻易打探的。」\n随着达芙黛尔的话音落地，庞大的怪物出现在你的面前。"
  },
  Event_7414_Name = {
    Text = "提示时间"
  },
  Event_74150_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74150_Desc = {
    Text = "小小老鼠藏身的钟楼里不应存在这种病态的玩具，这声音来源于你的头脑，你的记忆。\n你回忆起身为缸中之脑时曾经感受过的，通过声波转化的电流。\n那异响逐渐变得正常平缓，化成一首流畅的古典乐，在你的脑中循环播放。"
  },
  Event_74150_Name = {
    Text = "钟楼上的异响"
  },
  Event_74151_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74151_Desc = {
    Text = "那不是猫……那是耸动的提灯教众。\n黑色的轻纱下透出憎恶和敌意，絮语声刮擦着你的意识，带来诡异莫名的幻觉。"
  },
  Event_74151_Name = {
    Text = "猫的呢喃"
  },
  Event_74152_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74152_Desc = {
    Text = "他们抓住了你的鞋子，抓住了你的脚腕，他们贪婪，他们渴求，他们要将你拖入他们身处的深渊。\n你勉力挣扎，才维持住身形，后退几步以求脱身。\n不经意间，有什么东西掉落下来。"
  },
  Event_74152_Name = {
    Text = "噩梦倒影"
  },
  Event_74153_ChoiceDesc1 = {
    Text = "【闪避】获得3选1刻印"
  },
  Event_74153_ChoiceDesc2 = {
    Text = "【阻止】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74153_Desc = {
    Text = "似曾相识的画面，让你的神经跳跃着，抽搐着，恐惧着。\n「又一次……」\n惨无人道的噩梦降临，庞大的无力感笼罩了你。\n你真的不能改写她的命运吗？\n来不及了，莎拉开裂的头颅内，泛着银光的巨口亟待将你一口咬断，吞噬咀嚼。"
  },
  Event_74153_Name = {
    Text = "噩梦重现"
  },
  Event_74154_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74154_Desc = {
    Text = "你听见令人不安的呢喃。\n\n「我们来自遥远星辰上的群山与沼泽。我们的身躯是提灯的灯芯与燃料，我们将点燃来自大地的薪火，照亮通往新世界的坦途。」"
  },
  Event_74154_Name = {
    Text = "猫的呢喃"
  },
  Event_74155_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74155_Desc = {
    Text = "夕阳，钟楼，飞鸟……\n那个女孩摘下眼罩，她灰暗瞳孔的注视令你动弹不得。\n幻象如同蜃景，在眼前一触即散，但担忧的思绪挥之不去。"
  },
  Event_74155_Name = {
    Text = "白色眼罩"
  },
  Event_74156_ChoiceDesc1 = {
    Text = "【拾起】获得3选1白银造物"
  },
  Event_74156_ChoiceDesc2 = {
    Text = "【回想】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_74156_Desc = {
    Text = "在转角的融蚀黏液中，躺着一枚小小的白色眼罩。 \n回忆攫住了你的心脏。"
  },
  Event_74156_Name = {
    Text = "白色眼罩"
  },
  Event_74157_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74157_Desc = {
    Text = "透明的手掌在黑白的琴键上自如地舞动，传出的音浪却支离破碎，像一枚走调的八音盒，每个音符都发出不和谐的哀鸣，仿佛挣扎的求救。\n最终，演奏在一个无奈的和弦中戛然而止。\n生前未能获得的，在此刻只留下怅惘。"
  },
  Event_74157_Name = {
    Text = "遗憾的奏鸣"
  },
  Event_74158_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74158_Desc = {
    Text = "「尊敬的莎拉女士：\n我请求辞去济贫院护工一职。\n我已经不认可您的理念了。您的教导是错误的，东区的孩子不应该在您的荫蔽下长大，不应当相信纯粹的善意和无私的赋予。\n他们总有一天要离开您的羽翼，去学习东区生存的法则。\n\n……」\n\n后续的字迹被黑色的液体濡湿，一片模糊。"
  },
  Event_74158_Name = {
    Text = "幽灵油墨"
  },
  Event_74159_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74159_Desc = {
    Text = "「我能提供给孩子们的，只有一片遮雨的屋檐，和一口勉强不至于饿死的饭食。如果不是好心的罗杰斯先生叫来的医生，她们生病时连一剂药片都没法获得。\n我没有读过许多书，让他们不至于冻饿死在街头就是我能做到的全部了。\n我从来不曾干涉孩子们去成为什么样的人，但她们需要活下去。\n……」"
  },
  Event_74159_Name = {
    Text = "幽灵油墨"
  },
  Event_7415_ChoiceDesc1 = {
    Text = "【探寻来源】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7415_ChoiceDesc2 = {
    Text = "【丢弃信件】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7415_ChoiceDesc3 = {
    Text = "【检查信件】获得50黑印"
  },
  Event_7415_Desc = {
    Text = "又一封信落在了你的身前，被划烂的信纸让人心下一沉，你掀开了信纸。\n「它又来了，我预告的那些都不是妄言！@4从这里开始，也将从这里结束。」\n「我想逃……缩进了木柜里，手在控制不住地抖，但黏腻的肢体砸在地板上的声音，还步步紧逼……我听见了一个名字！就是它！@5！」"
  },
  Event_7415_Name = {
    Text = "又一封求救信"
  },
  Event_74160_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74160_Desc = {
    Text = "「感谢你，父神的创生之力终将重塑我们的形体，为我们带来永恒的光明与火焰。\n\n当我抵达终点时，会在父神面前为你祝福。」\n\n她的幻影渐渐消散，圣乐之声也化作无情的风呼啸而过。"
  },
  Event_74160_Name = {
    Text = "管风琴的祷告"
  },
  Event_74161_ChoiceDesc1 = {
    Text = "【安葬】回复 Arg2 点生命[ExDesc1]，选择 1 张指令卡删除。"
  },
  Event_74161_ChoiceDesc2 = {
    Text = "【祷告】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74161_Desc = {
    Text = "一截苍白的骸骨，半数浸没于漆黑的融蚀浆中。"
  },
  Event_74161_Name = {
    Text = "褪色遗骨"
  },
  Event_74162_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74162_Desc = {
    Text = "你径直踏入那团迷雾，幻影如蛛网般缠上你的身躯，冰冷的触感渗入骨髓。\n他们的低语化作记忆的碎片，刺穿你的胸膛。\n当你穿过，身后只余一片虚无，而前方，浓雾中隐约浮现出更多模糊的影子，等待吞噬。"
  },
  Event_74162_Name = {
    Text = "时间灰烬"
  },
  Event_74163_ChoiceDesc1 = {
    Text = "【绕开幻影】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74163_ChoiceDesc2 = {
    Text = "【穿过幻影】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_74163_ChoiceDesc3 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_74163_Desc = {
    Text = "尘霾如厚重的帷幕，笼罩着街道，每一步都像是踩在时间的灰烬上。\n远处，两个朦胧的影子在雾气中若隐若现，仿佛是过去的幽灵，低语着那些早已被遗忘的故事。\n失控的想象力又从中幻化出一个个可怖的影子，它们扭曲、蔓延，像是未来的预兆，压得你喘不过气。\n你知道，前方的路只会更加昏暗，而你的脚步，却不能也不应停下。"
  },
  Event_74163_Name = {
    Text = "时间灰烬"
  },
  Event_74164_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74164_Desc = {
    Text = "你堪堪闪过了莎拉的第一次迅猛攻击。\n接下来，就未必会那么幸运了。"
  },
  Event_74164_Name = {
    Text = "噩梦重现"
  },
  Event_74165_ChoiceDesc1 = {
    Text = "【指示方向】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74165_ChoiceDesc2 = {
    Text = "【一同祷告】获得3选1刻印"
  },
  Event_74165_Desc = {
    Text = "钢琴和管风琴的声音在灰暗的风中交织。仿佛有魔力的旋律飘荡在无人的街巷。\n一位无名的修女在琴声中祷告。\n「简单的祷告无需隆重的典仪，伟大的父神会为我们播撒希望，正如他曾赐予我们虔诚的教导。」"
  },
  Event_74165_Name = {
    Text = "管风琴的祷告"
  },
  Event_74166_ChoiceDesc1 = {
    Text = "【招架怪物】选择1个造物变化为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_74166_ChoiceDesc2 = {
    Text = "【拾起星辰】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74166_ChoiceDesc3 = {
    Text = "【无视】获得25黑印"
  },
  Event_74166_Desc = {
    Text = "流星的雨幕坠落在钟楼。\n一颗透亮的晶体恰落在你的脚边，砸出一块小小的陷坑。\n你仍深陷包围，形态各异的融蚀体像是扭曲的影子，咆哮、嘶吼声不绝于耳。\n你决定——"
  },
  Event_74166_Name = {
    Text = "陨落的星"
  },
  Event_74167_ChoiceDesc1 = {
    Text = "【揉揉眼睛】获得50黑印"
  },
  Event_74167_ChoiceDesc2 = {
    Text = "【闭上眼睛】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_74167_Desc = {
    Text = "面目可憎的黑色猫群蜂拥在于丽埃特身后，呢喃着不知名的音调，散发出隐秘的恶意威胁。"
  },
  Event_74167_Name = {
    Text = "猫的呢喃"
  },
  Event_74168_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74168_Desc = {
    Text = "廉价的布料摸在手里有些粗糙，但仍被细心地清洗干净。\n好好保存它，等待物归原主的一天吧。"
  },
  Event_74168_Name = {
    Text = "白色眼罩"
  },
  Event_74169_ChoiceDesc1 = {
    Text = "【保持距离】获得25黑印"
  },
  Event_74169_ChoiceDesc2 = {
    Text = "【施以怜悯】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74169_Desc = {
    Text = "他们自你的脚下蜂拥而来。\n在他们模糊的苦痛面庞中，你见到自己被拉扯的影子。\n你当真享有审判他们的特权吗？"
  },
  Event_74169_Name = {
    Text = "噩梦倒影"
  },
  Event_7416_ChoiceDesc1 = {
    Text = "【扔掉碎块】有特殊造物，感染携带刻印：「(EnchantConfig.Arg1)」的-症状：融蚀之癫狂"
  },
  Event_7416_ChoiceDesc2 = {
    Text = "【补完碎块】无特殊造物，感染「(Skill.Arg1)」，获得感染「(Skill.Arg2)」"
  },
  Event_7416_Desc = {
    Text = "苍白的肢体在你面前缓慢扭动着，她伏下身，将断裂的手臂伸到你面前，她因疼痛而眯起的双眼中，溢出死白的石膏泪珠。\n「只差……只差最后一块，我就可以……」"
  },
  Event_7416_Name = {
    Text = "补完残躯"
  },
  Event_74170_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74170_Desc = {
    Text = "你要试着拯救它们。\n但不要被它们同化。"
  },
  Event_74170_Name = {
    Text = "噩梦倒影"
  },
  Event_74171_ChoiceDesc1 = {
    Text = "【移开视线】提高 Arg1 点最大生命"
  },
  Event_74171_ChoiceDesc2 = {
    Text = "【保持注视】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染1张「(Skill.Arg2)」"
  },
  Event_74171_Desc = {
    Text = "「终焉已经降临。」\n你的心脏揪紧，收缩。\n于丽埃特确信的语气中无疑包含着某些催眠以及心灵感应的力量。\n这个维度的于丽埃特的目的与过去你认识的于丽埃特的有何区别？\n谜团太多，迷障重重。\n你抬眼观察于丽埃特，却发现她也凝视着你。"
  },
  Event_74171_Name = {
    Text = "终焉的目视"
  },
  Event_74172_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74172_Desc = {
    Text = "你抬手在虚幻的琴键上生涩地敲击。\n琴键叮叮咚咚地交错响起，每一枚音符都宛如滴落的露珠，清澈而透明，纯熟而精湛的演奏技巧并不出自你的指尖。\n恍然间，你见到一双无形而纤长的大手覆盖在你的手背，随着演奏的进展起起落落。\n时间仿佛静止，直至琴音的最后一尾余韵。\n你听见一声满足的叹息。"
  },
  Event_74172_Name = {
    Text = "遗憾的奏鸣"
  },
  Event_74173_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74173_Desc = {
    Text = "频繁转移的意识并不稳固，你需要排除无意义的干扰。\n你将注意力集中在眼前的詹金身上，留声机的声音便逐渐淡化，消散在雾气中。"
  },
  Event_74173_Name = {
    Text = "钟楼上的异响"
  },
  Event_74174_ChoiceDesc1 = {
    Text = "【寻找声源】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74174_ChoiceDesc2 = {
    Text = "【回忆】所有唤醒体回复50狂气，感染「(Skill.Arg1)」"
  },
  Event_74174_ChoiceDesc3 = {
    Text = "【无视噪音】获得3选1刻印"
  },
  Event_74174_Desc = {
    Text = "你听见了留声机指针畸变的声音。\n扭曲的指针划过破损的螺旋槽纹，不紧不慢地发出令人毛骨悚然的颤动。"
  },
  Event_74174_Name = {
    Text = "钟楼上的异响"
  },
  Event_74175_ChoiceDesc1 = {
    Text = "【为他演奏】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74175_ChoiceDesc2 = {
    Text = "【聆听琴声】每有一名狂气值在50及以上的唤醒体，获得15黑印"
  },
  Event_74175_ChoiceDesc3 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_74175_Desc = {
    Text = "「亲爱的约翰：\n    最近我突然意识到，距离你上次为我们进行钢琴演奏，已经过去了数年时间。\n    我今年81岁了，年龄越是增长，就越会意识到年轻时回忆的可贵。\n    若你收到这份信，就请你下次经过伦蒂尼恩时，在我的公寓前驻足，前来演奏一曲吧。」"
  },
  Event_74175_Name = {
    Text = "遗憾的奏鸣"
  },
  Event_74176_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74176_Desc = {
    Text = "求生的欲望激荡在胸腔中，你毫不犹豫地发出指令。\n等待你突出重围，回身去看时，那颗星辰已经被融蚀浆淹没。\n在涌动的融蚀浆中，响起一串尖锐的有规律的声响。\n你触碰融蚀浆的表面，一颗腐朽的星辰落入你的掌心。"
  },
  Event_74176_Name = {
    Text = "陨落的星"
  },
  Event_74177_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74177_Desc = {
    Text = "你拾起了那颗星辰，它在你的掌心却失去了光华。\n一阵压迫感倏忽袭来，一股恶寒令你的脊背发凉。\n生死瞬息之间，你侧身闪避，恰躲过一次凶狠的攻击，但手臂上仍留下了一道两英寸长的擦痕。"
  },
  Event_74177_Name = {
    Text = "陨落的星"
  },
  Event_74178_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74178_Desc = {
    Text = "触肢内隐藏的利齿撕开了你的袖口，淅沥的血浆如殷红的细流，顺着腕骨汩汩滑落。\n你无法分辨莎拉的眼神，但那绽裂的头颅隐约发出苦痛颤抖的嘶吼。"
  },
  Event_74178_Name = {
    Text = "噩梦重现"
  },
  Event_74179_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74179_Desc = {
    Text = "你环顾四周，左右游走，声音像只和你捉迷藏的老鼠，时左时右，忽远忽近。\n你兜兜转转，可声音愈发嘈杂，金属刮擦的异响令你陷入愈深的不安。\n你突发奇想，摸了摸自己的口袋，虽然没有发现声源，却拾到一件小小的宝物。"
  },
  Event_74179_Name = {
    Text = "钟楼上的异响"
  },
  Event_7417_ChoiceDesc1 = {
    Text = "【离开】你失去了(Arg1)点生命，感染「(Skill.Arg2)」"
  },
  Event_7417_Desc = {
    Text = "「乖孩子。不过，还是要给你一点小小的惩罚才行。」\n达芙黛尔的轻笑声消散在维度裂隙中。"
  },
  Event_7417_Name = {
    Text = "提示时间"
  },
  Event_74180_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74180_Desc = {
    Text = "你移开视线，不与她碰撞。\n然而某种力量仍旧让你的心脏不安地砰砰跳动。"
  },
  Event_74180_Name = {
    Text = "终焉的目视"
  },
  Event_74181_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74181_Desc = {
    Text = "于丽埃特与你四目相对。\n下一秒，她露出完全癫狂的笑容，仿佛在嘲笑你的狂妄与无知。\n然而那笑容转瞬即逝，其他人也并未对此做出表态……似乎只是你的幻觉。"
  },
  Event_74181_Name = {
    Text = "终焉的目视"
  },
  Event_7418_ChoiceDesc1 = {
    Text = "【有任务造物1，获得黄金造物「(RelicConfig.Arg1)」】"
  },
  Event_7418_ChoiceDesc2 = {
    Text = "【有任务造物2，获得黄金造物「(RelicConfig.Arg1)」】"
  },
  Event_7418_ChoiceDesc3 = {
    Text = "【随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7418_Desc = {
    Text = "事件254（开发中），非最终效果"
  },
  Event_7418_Name = {
    Text = "事件254（开发中）"
  },
  Event_7419_ChoiceDesc1 = {
    Text = "【提交特殊刻印1，随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7419_ChoiceDesc2 = {
    Text = "【提交特殊刻印2，随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7419_ChoiceDesc3 = {
    Text = "【感染「(Skill.Arg1)」以及「(Skill.Arg2)」，获得黄金造物「(RelicConfig.Arg3)」】"
  },
  Event_7419_Desc = {
    Text = "事件255（开发中），非最终效果"
  },
  Event_7419_Name = {
    Text = "事件255（开发中）"
  },
  Event_7420_ChoiceDesc1 = {
    Text = "【躲开蝴蝶牌】删除2张卡牌"
  },
  Event_7420_ChoiceDesc2 = {
    Text = "【拥抱蝴蝶】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7420_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_7420_Desc = {
    Text = "一个转角，又一个转角，追击地狱犬的道路仿佛永无尽头。\n酸痛的脚腕，发胀的大脑，混乱中你又见到了蝴蝶，你知道那是癫狂的妄念，密境的呓语。它们扑棱棱地从四面八方涌出。"
  },
  Event_7420_Name = {
    Text = "妄念喷涌"
  },
  Event_7421_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7421_Desc = {
    Text = "你轻轻按住风铃。铃声轻响数下便陷入沉默。它已然隐退——只会在梦魇里再度回归。"
  },
  Event_7421_Name = {Text = "小风铃"},
  Event_7422_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7422_Desc = {
    Text = "铃声轻响数下便陷入沉默。它已然隐退——只会在梦魇里再度回归。"
  },
  Event_7422_Name = {Text = "小风铃"},
  Event_7423_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7423_Desc = {
    Text = "「不错，你很谨慎。」\n风铃中忽然传来遥远的声音。\n「谨慎会为你带来一点小奖励，但也仅此而已了。」"
  },
  Event_7423_Name = {Text = "小风铃"},
  Event_74245_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_74245_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「你输了。不过，作为陪我玩乐的酬劳，你依然可以得到奖励。」"
  },
  Event_74245_Name = {Text = "N的寄语"},
  Event_74246_ChoiceDesc1 = {
    Text = "【关闭闸门】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_74246_ChoiceDesc2 = {
    Text = "【仓皇远离】感染「(Skill.Arg1)」，随机1张指令卡获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_74246_ChoiceDesc3 = {
    Text = "【无视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_74246_Desc = {
    Text = "你深陷这座蒸汽与齿轮构筑的迷宫，黄铜管道在头顶虬结成蛛网，每一次呼吸都搅动粘稠的机油雾气。\n失控的机械表盘在墙壁上抽搐，指针划破刻度时溅出零星火花，如同维多利亚实验室里濒死的萤火虫。铆钉接缝渗出铜锈，像这座钢铁巨兽溃烂的伤口，而你的怀表早已停摆——时间在这里不过是齿轮咬合的祷文。"
  },
  Event_74246_Name = {
    Text = "蒸汽迷城"
  },
  Event_74247_ChoiceDesc1 = {
    Text = "【赌一把】感染「(Skill.Arg1)」，进入赌局"
  },
  Event_74247_ChoiceDesc2 = {
    Text = "【还是算了】获得25黑印"
  },
  Event_74247_Desc = {
    Text = "在街角深邃的黑雾中，令人窒息的气息弥漫开来。\n雾气中，两个古老而阴冷的骰子悄然浮现，表面布满了无法解读的符号与诡异的图案。\n它们静静地躺在湿滑的石板上，仿佛在等待着某个不明的召唤。\n「你知道我是谁。要来赌一把吗？」"
  },
  Event_74247_Name = {Text = "N的寄语"},
  Event_74248_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74248_Desc = {
    Text = "「我梦见一场席卷一切的浩劫，淹没昔日的光辉。我对生活感到愤怒，更对未来的毫无希望感到无奈。我的心灵被恐惧撕裂，愿在这即将崩塌的时刻，你们能警觉，不要让这可怕的命运降临。」"
  },
  Event_74248_Name = {
    Text = "遗言呓语"
  },
  Event_74249_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74249_Desc = {
    Text = "黑色的烟雾失落地抖动。\n随后骰子在一次眨眼后消失不见。\n\n萦绕在你的脑海中的问题仅剩了一个：\n这些骰子到底是由什么东西构成的？"
  },
  Event_74249_Name = {Text = "N的寄语"},
  Event_7424_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7424_Desc = {
    Text = "你转过身，看到一双皮鞋，还有模糊的人形倒影。\n看起来似乎是一位年轻的绅士。\n「无意打扰，请问你见过一双黑色的牛津皮鞋吗？」\n「你面前就有一双。」\n「不，不……这是山羊皮的，不是牛皮的。\n我已经被困在这座蜡馆十二年了，一定是鞋子不对的缘故……」\n声音嘟囔着，渐渐微弱。"
  },
  Event_7424_Name = {Text = "脚步声"},
  Event_74250_ChoiceDesc1 = {
    Text = "【分辨男人的声音】从牌库中随机获取3张指令卡选择1张复制"
  },
  Event_74250_ChoiceDesc2 = {
    Text = "【分辨女人的声音】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_74250_ChoiceDesc3 = {
    Text = "【分辨老人的声音】获得25黑印"
  },
  Event_74250_Desc = {
    Text = "你独自站立在一片黑暗沼泽中。\n朦胧间你听见混沌交错的呓语如潮水般涌来，有的来自耄耋之年的老人，有的来自牙牙学语的孩子，有些来自焦虑难耐的女人，有些来自恐惧莫名的男人……"
  },
  Event_74250_Name = {
    Text = "遗言呓语"
  },
  Event_74251_ChoiceDesc1 = {
    Text = "【前进】从牌库中随机获取3张指令卡，选择1张卡进行删除，获得75黑印"
  },
  Event_74251_ChoiceDesc2 = {
    Text = "【歇息】从牌库中随机获取3张指令卡，选择1张卡的原始复制进入牌库，获得25黑印"
  },
  Event_74251_ChoiceDesc3 = {
    Text = "【回望】获得50黑印"
  },
  Event_74251_Desc = {
    Text = "你行走在无人的街道上，脚步在灰烬上踏出深深的凹痕。\n\n城市的道路如同蛛网，你是被捆缚的飞蛾。"
  },
  Event_74251_Name = {
    Text = "阴霾之都"
  },
  Event_74252_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74252_Desc = {
    Text = "当蒸汽闸门轰然闭合的刹那，你听见自己的影子正被精密啮合的螺纹一寸寸绞碎。"
  },
  Event_74252_Name = {
    Text = "蒸汽迷城"
  },
  Event_74253_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74253_Desc = {
    Text = "重复的光景接续刷新在眼前，你无路可逃。"
  },
  Event_74253_Name = {
    Text = "蒸汽迷城"
  },
  Event_74254_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74254_Desc = {
    Text = "时间是无用的坐标，你期待的唯有真理。"
  },
  Event_74254_Name = {
    Text = "蒸汽迷城"
  },
  Event_74255_ChoiceDesc1 = {
    Text = "【三点】"
  },
  Event_74255_ChoiceDesc2 = {
    Text = "【六点】"
  },
  Event_74255_ChoiceDesc3 = {
    Text = "【一点】"
  },
  Event_74255_Desc = {
    Text = "谁会敢掷下这意味着不幸与疯狂的骰子？\n你，当然是你。\n你选择——"
  },
  Event_74255_Name = {Text = "N的寄语"},
  Event_74256_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_74256_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「你输了。不过，作为陪我玩乐的酬劳，你依然可以得到奖励。」"
  },
  Event_74256_Name = {Text = "N的寄语"},
  Event_74257_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74257_Desc = {
    Text = "来路是无穷无尽的黑暗和茫茫一片的混沌。\n没有时间来考虑自己的命运了，你必须削除恐惧，在宣判降临之前抵达自己的终点。"
  },
  Event_74257_Name = {
    Text = "阴霾之都"
  },
  Event_74258_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74258_Desc = {
    Text = "「当我坐在岁月的阴影中，感受到死亡冷酷的手掌逐渐逼近。窗外的世界变得愈加昏暗，充斥着灾难的低语。我畏惧即将到来的审判，对我们愚昧的清算。街道充满了不祥的气息，我担心我们的审判日即将到来。我们的文明摇摇欲坠，仿佛要被毁灭所吞噬，受困于我们自己愚蠢的傲慢。」"
  },
  Event_74258_Name = {
    Text = "遗言呓语"
  },
  Event_74259_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74259_Desc = {
    Text = "死里逃生已属不易，你不应苛求更多。\n残垣断柱和废墟的阴影仍在召唤着你。"
  },
  Event_74259_Name = {
    Text = "阴霾之都"
  },
  Event_7425_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_7425_Desc = {
    Text = "「这样么……非常有趣。」\n她收回问卷，向你指了孩子们离开的方向。你匆匆离去，险些没有听到身后的低语。\n「期待我们的下次会面。」"
  },
  Event_7425_Name = {
    Text = "心理评估"
  },
  Event_74260_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74260_Desc = {
    Text = "你处在某种巨大的力量或强大的命运的支配之下。\n短暂的歇息不能改变这一现状，但至少能带给酸软的双腿前进的动力。"
  },
  Event_74260_Name = {
    Text = "阴霾之都"
  },
  Event_74261_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_74261_Desc = {
    Text = "「……城市不再是温暖的避风港，而是隐秘的墓穴，孕育着恐怖与绝望。那些曾经鲜活的梦想，如今只剩下恐惧的残片。我无法再假装无所畏惧，眼前的世界如同一场噩梦，无法醒来。」"
  },
  Event_74261_Name = {
    Text = "遗言呓语"
  },
  Event_74262_ChoiceDesc1 = {
    Text = "【离开】获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_74262_Desc = {
    Text = "骨碌骨碌，骰子在骰盅里兴奋地起舞，舞到筋疲力竭。\n\n「你输了。不过，作为陪我玩乐的酬劳，你依然可以得到奖励。」"
  },
  Event_74262_Name = {Text = "N的寄语"},
  Event_7426_ChoiceDesc1 = {
    Text = "【离开】随机1张指令卡获得刻印：镜像"
  },
  Event_7426_Desc = {
    Text = "「没关系，我已经从你的眼睛里看见了答案。我还有些杂务需要处理，暂时先退场了。你也一样有事要处理吧？看那边，有人来找你了。」\n你回头，提灯教会的身影出现在道路的尽头。"
  },
  Event_7426_Name = {
    Text = "怪异旅伴Ⅴ"
  },
  Event_7427_ChoiceDesc1 = {
    Text = "【离开】随机1张指令卡获得刻印：筹算"
  },
  Event_7427_Desc = {
    Text = "「看来你还不愿对我敞开心扉。我很失望，不过没关系，我依然会为你提供最亲切的提示：提灯教会出现在这里，究竟是想要寻找什么呢？」\n「哎呀，看来有人不希望我们闲聊了。看那边，有人来找你了。」\n你回头，提灯教众的身影出现在道路的尽头。"
  },
  Event_7427_Name = {
    Text = "怪异旅伴Ⅴ"
  },
  Event_7428_ChoiceDesc1 = {
    Text = "【离开】随机1张指令卡获得刻印：灵感"
  },
  Event_7428_Desc = {
    Text = "「你很诚实，值得嘉奖。所以，我决定给你一个小小的提示：为什么你刚来到拉伊小镇，就被祂盯上了呢？」\n「哎呀，看来有人不希望我们闲聊了。看那边，有人来找你了。」\n你回头，提灯教众的身影出现在道路的尽头。"
  },
  Event_7428_Name = {
    Text = "怪异旅伴Ⅴ"
  },
  Event_7429_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7429_Desc = {
    Text = "杂乱的声音渐渐平息，你的手中空空如也，但瞬间的情绪已经被银钥记录下来。"
  },
  Event_7429_Name = {Text = "无之书"},
  Event_7430_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7430_Desc = {
    Text = "你在混乱中伸出手四处乱抓，一片混沌中有什么触感奇异的物品落入你的手中，渐渐汇聚成型。"
  },
  Event_7430_Name = {Text = "无之书"},
  Event_7431_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7431_Desc = {
    Text = "「你听说过蛇的捕猎方式吗？蛇只能匍匐于地，蜿蜒爬行，所以无法像猎豹那样发力追逐，也不能像狼群那样凭包围猎物。与之相对的，蛇学会了静静守候。」\n「他们等待猎物放松警惕的时刻，然后发动突袭，一击将它们吞入腹中。」"
  },
  Event_7431_Name = {
    Text = "怪异旅伴Ⅲ"
  },
  Event_7432_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7432_Desc = {
    Text = "似乎被惊扰了，黑猫油亮的皮毛仅仅在你指尖留下了一丝灼痛，随即消失在迷雾深处。"
  },
  Event_7432_Name = {
    Text = "夜猫之祸"
  },
  Event_7433_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7433_Desc = {
    Text = "无非是那群愚蠢无稽的疯狂信徒的荒诞梦呓。"
  },
  Event_7433_Name = {
    Text = "密令·下"
  },
  Event_7434_ChoiceDesc1 = {
    Text = "【继续偷听】获得3选1刻印"
  },
  Event_7434_ChoiceDesc2 = {
    Text = "【大声咳嗽】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7434_Desc = {
    Text = "墙角裂开了许多细缝，血管般蜿蜒而出。\n伴随轻微的嗡鸣声，你听到对面传来男人低沉的声音。\n「昆丁区5，威灵顿区10，诺曼区15……\n本月素材均已装货完毕，准备发车，货号I-0234……\n……\n另外，托弥萨格那帮人的福，白教堂区目前处于戒严状态，我们丢失了最大的素材来源。」"
  },
  Event_7434_Name = {
    Text = "隔墙有耳"
  },
  Event_7435_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_7435_ChoiceDesc2 = {
    Text = "【继续追逐孩子】离开"
  },
  Event_7435_Desc = {
    Text = "在你的驱吓下，所有乌鸦向四面八方哗啦啦飞去，扑腾坠落的漆黑羽翼融成黏液，滴落成黑印的模样。"
  },
  Event_7435_Name = {
    Text = "黑鸦凝视"
  },
  Event_7436_ChoiceDesc1 = {
    Text = "【放弃抵抗】删除1张指令卡，获得Arg1黑印"
  },
  Event_7436_ChoiceDesc2 = {
    Text = "【抽回双手】"
  },
  Event_7436_Desc = {
    Text = "一台新式打字机。\n它有一套与众不同的字母键，就像显微镜一样华丽又精巧。\n你好奇地将手放了上去，却发现它们不受控制地在键盘上下翻飞，速度越来越快，越来越快……"
  },
  Event_7436_Name = {
    Text = "灵感迸发"
  },
  Event_7437_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7437_Desc = {
    Text = "不过是挣扎求生的生灵，求得一块歇脚的浮木罢了……\n你叹息一声，任由蝴蝶尾部的黑浆淌至脸颊。"
  },
  Event_7437_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7438_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7438_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_7438_Name = {Text = "联络点"},
  Event_7439_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7439_Desc = {
    Text = "你接受了来自学校的联络请求，熟悉的声音使你心神安定。你振作精神，继续向前。"
  },
  Event_7439_Name = {Text = "联络点"},
  Event_7440_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7440_Desc = {
    Text = "你的疑惑坠进空气，无人答复，暖黄的光线自窗外透入，像回忆一般温暖。"
  },
  Event_7440_Name = {
    Text = "火山追忆"
  },
  Event_7441_ChoiceDesc1 = {
    Text = "【拾起】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_7441_ChoiceDesc2 = {
    Text = "【犹豫】获得25黑印"
  },
  Event_7441_Desc = {
    Text = "小巷角落的木桶中，漂浮着某件色彩怪异的物品。异常的出现仿佛在警告你，「请勿触碰」。"
  },
  Event_7441_Name = {
    Text = "桶中浮物"
  },
  Event_7442_ChoiceDesc1 = {
    Text = "【交给她吧】获得3选1白银造物"
  },
  Event_7442_ChoiceDesc2 = {
    Text = "【有点情况】获得白银造物「(RelicConfig.Arg1)」「(RelicConfig.Arg2)」，感染两次「(Skill.Arg3)」"
  },
  Event_7442_Desc = {
    Text = "「这里是来自弥萨格的通讯，我是艾瑞卡。监测到唤醒体萝坦的异常诺斯指数波动，请问是否需要支援？」"
  },
  Event_7442_Name = {
    Text = "支援通讯"
  },
  Event_7443_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7443_Desc = {
    Text = "你依从了耳畔不怀好意的劝慰，尖啸如针尖般扭动着刺入你的耳孔。\n「停下——快停下——我都已经按你说的做了——快停——」\n你痛苦地捂住头颅，恍惚间听见了鸦群的嘲弄。"
  },
  Event_7443_Name = {
    Text = "鸦群之歌"
  },
  Event_7444_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7444_Desc = {
    Text = "被放置在这个位置，不外乎两种可能：被忽视之物，或被珍重之物。如果是后者，那还是留给原主吧。"
  },
  Event_7444_Name = {
    Text = "孤独银芯"
  },
  Event_7445_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7445_Desc = {
    Text = "最幸福的，莫过于无知。"
  },
  Event_7445_Name = {Text = "窥视"},
  Event_7446_ChoiceDesc1 = {
    Text = "【生成普通怪物】"
  },
  Event_7446_ChoiceDesc2 = {
    Text = "【生成空白地块】"
  },
  Event_7446_ChoiceDesc3 = {
    Text = "【生成虚空】"
  },
  Event_7446_Desc = {
    Text = "看看可以生成什么"
  },
  Event_7446_Name = {
    Text = "【待包装】"
  },
  Event_7447_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7447_Desc = {
    Text = "「冷静，」拉蒙娜敲了敲你的脑袋，「只是往昔的碎片。不知道是谁遗落在这条维度通道的。」\n确实，有股怀念的味道。"
  },
  Event_7447_Name = {
    Text = "回忆碎片·威士忌"
  },
  Event_7448_ChoiceDesc1 = {
    Text = "【收集起来】将1个白银造物升级为黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7448_ChoiceDesc2 = {
    Text = "【扔掉它们】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7448_ChoiceDesc3 = {
    Text = "【仔细观察】获得25黑印"
  },
  Event_7448_Desc = {
    Text = "这里有许多碎裂的银芯。\n黯淡、破碎……显然不是什么高档货。\n或许它们正是这些蜡像能「活过来」的原因之一吧。\n即使是最粗糙的银芯，也拥有创造奇迹的可能。"
  },
  Event_7448_Name = {
    Text = "被缚的灵魂"
  },
  Event_7449_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_7449_Desc = {
    Text = "库姆已经献出了她能献出的一切。\n接下来，轮到你让她的牺牲不是毫无意义了。"
  },
  Event_7449_Name = {Text = "余温"},
  Event_7450_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7450_Desc = {
    Text = "愿风雪赐予你们永恒的宁静。"
  },
  Event_7450_Name = {
    Text = "前人遗物"
  },
  Event_7451_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7451_Desc = {
    Text = "你仍然显得顽强，在吟唱中仍能依循自我。\n你不相信耳畔的呓语，所仰赖之物只有人类的理性。\n不过……赖以维生的坚实地面，被粘稠的黑浆笼罩的那一天，挖出眼球作为窥伺之物，将是你弥留之际的唯一选择。"
  },
  Event_7451_Name = {
    Text = "鸦群之歌"
  },
  Event_7452_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7452_Desc = {
    Text = "库姆被你猛然扯开，堪堪躲过一击。她朝你点了点头以示感激，再次朝着实验体冲了过去。"
  },
  Event_7452_Name = {Text = "斗兽场"},
  Event_7453_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7453_Desc = {
    Text = "叮叮当当……\n硬币坠入钱包，发出清脆悦耳的回响。\n钱包满足地咀嚼着，最后打了一个饱嗝。\n它折服于你的大方，对你卸下全部的心防。\n现在，它将为你所用。"
  },
  Event_7453_Name = {
    Text = "贪吃钱包"
  },
  Event_7454_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7454_Desc = {
    Text = "黄铜硬币如同坠入不见底的深渊，一点声音都没发出。\n你耐心等待了五分钟。钱包发出痛苦的呻吟，最后吐出一滩漆黑的粘液。\n这是它无声的抗议。"
  },
  Event_7454_Name = {
    Text = "贪吃钱包"
  },
  Event_7455_ChoiceDesc1 = {
    Text = "【看向远处】"
  },
  Event_7455_ChoiceDesc2 = {
    Text = "【细细聆听】"
  },
  Event_7455_Desc = {
    Text = "希莱斯特摇动了手中罗盘，她并没有说话，身边却隐隐响起了歌谣。\n水手的歌谣跨越了时间在此交织重合，一曲混乱却有力的船歌指引着你，让你看向船的另一头。"
  },
  Event_7455_Name = {Text = "船歌"},
  Event_7456_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7456_Desc = {
    Text = "你上前打断了这场小小的授课练习。\n从弹琴的手势到基础乐理，你毫不留情一一点评。\n乐音骤停，男孩和老师齐刷刷看向你，脸上挂着同样诡谲的微笑。\n133，355，244……\n琴声再度响起，依旧错得离谱。\n原来他们什么都听不见。"
  },
  Event_7456_Name = {Text = "钢琴课"},
  Event_7457_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_7457_Desc = {
    Text = "在密境中发现的黑色印记，可向融痕献祭以换取造物等精神投影。离开当前区域后很快会消散为黑色泥浆。"
  },
  Event_7457_Name = {Text = "黑印"},
  Event_7458_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7458_Desc = {
    Text = "眼下还是找到那个神秘人更重要。拉蒙娜这么想着，快步离开。"
  },
  Event_7458_Name = {
    Text = "他人之耳"
  },
  Event_7459_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7459_Desc = {
    Text = "放纵意识，循着祷言的来路向深海沉没。\n你看见了沉于水底的黄金之国，看见了不朽的石雕，最终与幽暗之处那闪烁的眼眸对视……\n「未流淌神血之人……离开，离开。」"
  },
  Event_7459_Name = {
    Text = "梦境祷文"
  },
  Event_7460_ChoiceDesc1 = {
    Text = "【离开】选择1个诅咒造物，感染「(Skill.Arg1)」"
  },
  Event_7460_Desc = {
    Text = "拉蒙娜一剑刺穿了实验体的喉咙，库姆将已然失去生命体征的实验体甩开，奔向下一个目标。"
  },
  Event_7460_Name = {Text = "斗兽场"},
  Event_7461_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7461_Desc = {
    Text = "乌鸦撕咬着自己的羽毛，就如人类啃噬自己的身体一样。\n在这个恐惧的世界里，此事屡见不鲜，你救不了所有生灵。"
  },
  Event_7461_Name = {
    Text = "融浆之泪"
  },
  Event_7462_ChoiceDesc1 = {
    Text = "【安抚库姆】"
  },
  Event_7462_ChoiceDesc2 = {
    Text = "【帮库姆呼喊】"
  },
  Event_7462_Desc = {
    Text = "巨大的怪兽朝着小小的人竭力地嘶吼着，想要唤醒往日的伙伴。但被摧残过的声带只震出低沉怪异的喉音。"
  },
  Event_7462_Name = {
    Text = "友情的呼唤"
  },
  Event_7463_ChoiceDesc1 = {
    Text = "【离开】寻找探照灯"
  },
  Event_7463_ChoiceDesc2 = {
    Text = "【闯入雾气】失去 Arg2 点生命"
  },
  Event_7463_Desc = {
    Text = "前方是一片浓厚的黑色雾气，贸然进入将招致灾厄。\n或许你应该找到「探照灯」驱散雾气。"
  },
  Event_7463_Name = {Text = "未知"},
  Event_7464_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7464_Desc = {
    Text = "「像你一样咔吱作响的上颌骨？这辈子从未见过。」\n你拒绝了颌骨先生的无礼请求。颌骨先生失望极了，但勉强保持住了风度。\n为了感谢你的耐心倾听，他送了你一点小礼物。"
  },
  Event_7464_Name = {
    Text = "咔吱作响"
  },
  Event_7465_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7465_Desc = {
    Text = "你答应了这个奇异的请求，并带上了这位颌骨先生。\n它躺在你的口袋里，一刻不停地咔吱作响。根据同伴的翻译，它的发言大致包含感激、怀旧以及悔恨。\n至于他为何会变成这副模样？颌骨先生不愿多谈，只说：\n「你知道的。当你凝望@2时，@2也会回望你。」"
  },
  Event_7465_Name = {
    Text = "咔吱作响"
  },
  Event_7466_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7466_Desc = {
    Text = "祂像一段丝绸般滑入了你的提包，随着轻微的重量增加，你仿佛听到了一声轻微的道谢。\n此后再无声响。"
  },
  Event_7466_Name = {
    Text = "混沌之灵"
  },
  Event_7467_ChoiceDesc1 = {
    Text = "【前进】"
  },
  Event_7467_Desc = {
    Text = "咔嚓。\n你将钥匙插入锁孔，轻轻把门推开。\n整个开门的过程都无比顺利，让你对接下来的调查又有了信心。"
  },
  Event_7467_Name = {
    Text = "锈蚀门扉"
  },
  Event_7468_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7468_Desc = {
    Text = "那个声音沉沉地笑了，你脚下的液体泛起涟漪。\n「你很快就会明白，除了死亡，没有什么是一定要做的。」"
  },
  Event_7468_Name = {
    Text = "你不会想要找到"
  },
  Event_7469_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7469_Desc = {
    Text = "你丢掉了这块记忆，将自己的意识从虚幻的抚慰中抽离。"
  },
  Event_7469_Name = {
    Text = "沉湎旧日"
  },
  Event_7470_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7470_Desc = {
    Text = "只是浅睡片刻罢了，若无抚慰，你要如何度过这漫漫长夜呢……"
  },
  Event_7470_Name = {
    Text = "沉湎旧日"
  },
  Event_7471_ChoiceDesc1 = {
    Text = "【拾起照片】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7471_Desc = {
    Text = "这是一组群像照。\n萎靡不振的人们蹲在铁栅栏后方，满脸困苦。\n其中一张照片吸引了你的注意。那应当是个瘦弱的年轻女性，脸部一片空白。\n那无比亵渎的赘生物，正一圈圈缠绕在她的身体周围。\n你看不见她脸，但在你的想象里，她应该是没有表情的。"
  },
  Event_7471_Name = {
    Text = "如实记录"
  },
  Event_7472_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7472_Desc = {
    Text = "那是鸟的残骸。"
  },
  Event_7472_Name = {
    Text = "躁乱鸦群"
  },
  Event_7473_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7473_Desc = {
    Text = "你冷酷地拒绝了钢琴师的请求。\n钢琴师失望极了。他将另一只耳朵也撕了下来，将它们全部扔出窗外。\n「反正我也用不着它们。」\n忧郁的钢琴师哭丧着脸，低头敲下一连串哀伤的音符。"
  },
  Event_7473_Name = {
    Text = "侧耳倾听"
  },
  Event_7474_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7474_Desc = {
    Text = "混沌之灵的哭泣愈发尖锐，直到最后变为了刺耳的尖叫，响彻周身。\n祂带着你的供奉和无法脱身的悲苦，再次沉入泥潭。"
  },
  Event_7474_Name = {
    Text = "混沌之灵"
  },
  Event_7475_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7475_Desc = {
    Text = "这是一个单向通道，你无法通过它回到入口。"
  },
  Event_7475_Name = {Text = "通道"},
  Event_7476_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7476_Desc = {
    Text = "「那么，请合上双眼，静心感受它来临的脚步声吧。」\n你依言闭眼，霎时间，诡异的野兽喘息声在耳侧轰鸣。\n惊魂未定地睁开眼时，刚才的男人已经消失不见。"
  },
  Event_7476_Name = {
    Text = "怪异旅伴Ⅰ"
  },
  Event_7477_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_7477_Desc = {
    Text = "「那可真是太遗憾了。」\n男人声音低落，扶了扶眼镜。\n「不过，既然你们没听说过它，又为何要深夜来此呢？」\n不等你们回应，男人侧身离开了。"
  },
  Event_7477_Name = {
    Text = "怪异旅伴Ⅰ"
  },
  Event_7478_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7478_Desc = {
    Text = "你迈着坚定的步伐，继续前进。\n一步、两步、三步……\n身后的脚步声隐入黑暗。\n你们还会相遇的。"
  },
  Event_7478_Name = {Text = "牛津鞋"},
  Event_7479_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7479_Desc = {
    Text = "你半躬起身子，将一旁桌上的托盘举在手中，摇身一变成了公主的侍卫。\n至于谁成了那位幸运的公主——自然是你最忠实的搭档了。\n「敢把茶杯倒在我脸上，下个月的课堂笔记就别指望了。」\n这是公主对你发出的警告。"
  },
  Event_7479_Name = {
    Text = "以假乱真"
  },
  Event_7480_ChoiceDesc1 = {
    Text = "【静静听着】随机提升1张卡牌的刻印品质"
  },
  Event_7480_ChoiceDesc2 = {
    Text = "【她就是】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7480_Desc = {
    Text = "莎拉的嘶吼在你的脑海中回荡，一个有些熟悉的细微声音不知从何而来，它微弱地呢喃着「莎莎姐姐」，「莎莎姐姐」。\n「莎莎姐姐，你在哪里？」"
  },
  Event_7480_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_7481_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7481_Desc = {
    Text = "「……我竟然觉得你说的有一丝道理，但渴望可不能帮你解决融蚀体。还是干点实际的吧。」"
  },
  Event_7481_Name = {
    Text = "罗格斯定则"
  },
  Event_7482_ChoiceDesc1 = {
    Text = "【获得100黑印】"
  },
  Event_7482_ChoiceDesc2 = {
    Text = "【随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」】"
  },
  Event_7482_Desc = {
    Text = "造物由稳定的灵知凝滞而成，或许，它们能换来和谐的曲调。"
  },
  Event_7482_Name = {
    Text = "不协和音"
  },
  Event_7483_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7483_Desc = {
    Text = "「是进入过这个维度的某个人的记忆碎片，」拉蒙娜回应道，「穿行在维度中很容易遇见这种情况。小心不要和自己的记忆混淆。」"
  },
  Event_7483_Name = {
    Text = "回忆碎片·威士忌"
  },
  Event_7484_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7484_Desc = {
    Text = "跟随心跳的韵律，追寻闪光。你们不会分开，正如没人能精准地区分日与夜。"
  },
  Event_7484_Name = {Text = "左心房"},
  Event_7485_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7485_Desc = {
    Text = "你不断抚摸这些焦躁不安的手，试图让它们安静下来。\n不一会儿，你的世界便彻底清净了。\n爱总是能获得回报。"
  },
  Event_7485_Name = {
    Text = "黯色沼泽"
  },
  Event_7486_ChoiceDesc1 = {
    Text = "【挣扎】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」】"
  },
  Event_7486_ChoiceDesc2 = {
    Text = "【放弃】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_7486_ChoiceDesc3 = {
    Text = "【警惕】获得25黑印"
  },
  Event_7486_Desc = {
    Text = "你的脑中涌入了浊物，那样污秽的异物感分外清晰。\n那浑浊的、散发着恶臭的积液渗漏并占据了你的全部思绪，痛苦爬满了充斥着恐惧的侧脸，你陷入无穷无尽的噩梦轮回，难以挣脱。"
  },
  Event_7486_Name = {
    Text = "颅中疮孔"
  },
  Event_7487_ChoiceDesc1 = {
    Text = "【是孟菲斯仪式镜】"
  },
  Event_7487_ChoiceDesc2 = {
    Text = "【是定向罗盘】"
  },
  Event_7487_ChoiceDesc3 = {
    Text = "【我没有掉东西】"
  },
  Event_7487_Desc = {
    Text = "「跨越维度的先行者啊。」\n\n耳畔传来苍老的声音，似来自史前，似穿越万古。\n\n在极度紧张中，你听见那个声音问出了一个有些耳熟的问题。\n\n「你掉的，这个圆圆的，能让你在回合开始抽牌的东西是什么呢？」"
  },
  Event_7487_Name = {
    Text = "界外之音"
  },
  Event_7488_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7488_Desc = {
    Text = "「我这里又不是废品回收站，」朵尔嘟囔着收下，「算了，多少还能提取点有用的。」"
  },
  Event_7488_Name = {Text = "铭牌"},
  Event_7489_ChoiceDesc1 = {
    Text = "随机普通刻印"
  },
  Event_7489_Name = {Text = "11"},
  Event_7490_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7490_Desc = {
    Text = "你阅读着斑驳残破的纸张，「双生」、「浸润」、「献祭」、「无效」……\n依然是支离破碎的概念和难以解读的行文，唯有发胀的大脑能证明你曾经阅读过这一页废纸。"
  },
  Event_7490_Name = {
    Text = "密令·下"
  },
  Event_7491_ChoiceDesc1 = {
    Text = "【您愿意付出怎样的代价呢？】随机提升1张卡牌的刻印品质"
  },
  Event_7491_ChoiceDesc2 = {
    Text = "【请他们喝一杯过期的血腥玛丽吧】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7491_Desc = {
    Text = "「欢迎光临，我珍贵的客人。尽情挑选吧，这满目琳琅皆为等候你而存在。」\n「额，打扰了，请问您是……达芙黛尔女士的孪生姐妹吗？」\n「我即是达芙黛尔本人，请问客人您今日到此，有何贵干……？」\n「抱歉抱歉，您比之前更有风韵了，我竟没认出。您还记得吗？二十年前，您替我的酒吧赶走了一个怪胎……昨天，噩梦重现了，它占领了酒吧，带着它的同胞们，成群结队地……」"
  },
  Event_7491_Name = {
    Text = "回忆碎片·旧梦重现"
  },
  Event_7492_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7492_ChoiceDesc2 = {
    Text = "【继续追逐孩子】离开"
  },
  Event_7492_Desc = {
    Text = "第二只乌鸦离开了，祂的尾羽在扑腾间露出了一抹白，恍若白骨。"
  },
  Event_7492_Name = {
    Text = "黑鸦凝视"
  },
  Event_7493_ChoiceDesc1 = {
    Text = "【赌一把】感染「(Skill.Arg1)」，进入赌局"
  },
  Event_7493_ChoiceDesc2 = {
    Text = "【还是算了】获得25黑印"
  },
  Event_7493_Desc = {
    Text = "「来赌一把吧？猜猜我们的点数！只要一点点的代价！」\n被丢弃的骰子们发出聒噪的嗡鸣声，仿佛在对你说话。\n「投我！投我！」\n「唯一一把！最后一把！」\n好吧，就一把——\n你拿起一个筹码。你决定——"
  },
  Event_7493_Name = {
    Text = "无止境的赌局"
  },
  Event_7494_ChoiceDesc1 = {
    Text = "【抵抗恶念】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7494_ChoiceDesc2 = {
    Text = "【拥抱恶念】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7494_ChoiceDesc3 = {
    Text = "【清醒离开】获得25黑印"
  },
  Event_7494_Desc = {
    Text = "恶念成为了利刃，又仿佛是尖锐的牙。\n祂们撕咬着在密境中渐弱的理智，吞噬着残存的意志，一如现实对你所施的恶行一般……"
  },
  Event_7494_Name = {
    Text = "无妄之念"
  },
  Event_7495_ChoiceDesc1 = {
    Text = "【全力挣扎】删除1张指令卡，获得Arg1黑印"
  },
  Event_7495_ChoiceDesc2 = {
    Text = "【点燃蛛网】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_7495_ChoiceDesc3 = {
    Text = "【安静等待】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7495_Desc = {
    Text = "细密的丝线如蛛网般缠绕着你，此刻，你赫然成为了密境的猎物。"
  },
  Event_7495_Name = {Text = "深陷"},
  Event_7496_ChoiceDesc1 = {
    Text = "【收件人：∞】感染「(Skill.Arg1)」"
  },
  Event_7496_ChoiceDesc2 = {
    Text = "【收件人：自己】删除1张卡牌"
  },
  Event_7496_ChoiceDesc3 = {
    Text = "【收件人：老师】获得25黑印"
  },
  Event_7496_Desc = {
    Text = "祂给了密境行者一个机会：一个向未知连通的机会。\n几张残破的纸，一台逸散着油墨的打字机，与一个未知的、单向的收件人。\n意志或许能决定你的信息能传达向何方……"
  },
  Event_7496_Name = {
    Text = "单向倾诉"
  },
  Event_7497_ChoiceDesc1 = {
    Text = "【欣然应允】"
  },
  Event_7497_ChoiceDesc2 = {
    Text = "【断然回绝】"
  },
  Event_7497_Desc = {
    Text = "空空荡荡的环境中回荡着私语。\n「噢，就是那个傻子，念叨着要么死要么赢的知名赌徒，废人一个，你可离他远点。」\n身形颓丧瘦削的虚影向你抛来几枚硬币，金属撞击的脆响漏进你掌心。\n「来一局。」"
  },
  Event_7497_Name = {
    Text = "驰名的赌徒"
  },
  Event_7498_ChoiceDesc1 = {
    Text = "【我们一切平安】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7498_ChoiceDesc2 = {
    Text = "【你是谁？】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7498_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7498_Desc = {
    Text = "打字机突兀地喷出油墨，上面的惊叹号多得刺目。\n「朵尔你还好吗？？？为什么守密人消失了你也消失了！！！拜托平安的话回个消息！！！再等下去威廉的头发都要掉完了！！！」"
  },
  Event_7498_Name = {
    Text = "紧急通讯"
  },
  Event_7499_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7499_Desc = {
    Text = "你将最后一块石膏补上，她爆发出一阵尖刻的笑声，一阵黑气缠绕而上，她漂浮的身影消散在你的视野中。"
  },
  Event_7499_Name = {
    Text = "补完残躯"
  },
  Event_7500_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7500_Desc = {
    Text = "你掏出了银钥匙，哀戚虔诚地将它握在手心，薄雾般的微光包裹住你。\n一片寂静中，只余喟叹。"
  },
  Event_7500_Name = {
    Text = "凝望之眼"
  },
  Event_7501_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7501_Desc = {
    Text = "残留的目光仍在注视着你，你皮肤下的血肉细胞正疯狂叫嚣和逃逸，血管在皮肤下蠕动如虫豸。\n你感到一阵流淌着的力量，在肢体诡谲的异状中迸发。"
  },
  Event_7501_Name = {
    Text = "凝望之眼"
  },
  Event_7502_ChoiceDesc1 = {
    Text = "【回避目光】随机觉醒1名唤醒体"
  },
  Event_7502_ChoiceDesc2 = {
    Text = "【直视目光】选择觉醒1名唤醒体，并降低其觉醒卡算力消耗2点。感染「(Skill.Arg1)」"
  },
  Event_7502_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7502_Desc = {
    Text = "维度隧道链接着万千宇宙，在至高的通道上，无数双眼睛瞪视着潜行的你们。"
  },
  Event_7502_Name = {
    Text = "祂的注视"
  },
  Event_7503_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7503_Desc = {
    Text = "太乱了，太乱了。\n所有想法在瞬间被思维长河卷走，被洪流裹挟着流向远方。\n在大脑的洼地中，只留下数不尽的迷茫与苦痛共同沉沦。"
  },
  Event_7503_Name = {
    Text = "灵感迸发"
  },
  Event_7504_ChoiceDesc1 = {
    Text = "【收入囊中】"
  },
  Event_7504_Desc = {
    Text = "过饱和的融蚀浆中似乎蕴藏着某些物质…用银钥匙观测，将它转化为自身的力量吧。"
  },
  Event_7504_Name = {Text = "析出点"},
  Event_7505_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7505_ChoiceDesc2 = {
    Text = "【继续追逐孩子】离开"
  },
  Event_7505_Desc = {
    Text = "一只乌鸦离开了，一根漆黑的羽毛缓缓飘落。"
  },
  Event_7505_Name = {
    Text = "黑鸦凝视"
  },
  Event_7506_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7506_Desc = {
    Text = "这里是深渊的血战之地，战斗不仅需要勇气，更需要智慧。\n\n擦亮你的眼睛，观察你的对手，你不需要打到他们全部，你只需要打到他们的领袖！"
  },
  Event_7506_Name = {
    Text = "修罗试炼"
  },
  Event_7507_ChoiceDesc1 = {
    Text = "【接通】回复Arg2点生命。"
  },
  Event_7507_Desc = {
    Text = "你在迷雾中探索，突然，胸前的校徽放出微弱的银光。是谁在通讯器的那头呼唤你？"
  },
  Event_7507_Name = {Text = "联络点"},
  Event_7508_ChoiceDesc1 = {
    Text = "【尾随他】"
  },
  Event_7508_ChoiceDesc2 = {
    Text = "【打招呼】"
  },
  Event_7508_Desc = {
    Text = "嗒。嗒。嗒。\n白色的身影在浓雾中缓步前行，像帆船驶向寂静的黑夜。\n从背影来看，似乎是个男孩。\n你倾听着他倦怠的脚步声，在心中下了一个决定。"
  },
  Event_7508_Name = {
    Text = "终幕礼Ⅰ"
  },
  Event_7509_ChoiceDesc1 = {
    Text = "【欣然同意】"
  },
  Event_7509_ChoiceDesc2 = {
    Text = "【抱有戒心】"
  },
  Event_7509_Desc = {
    Text = "融蚀体哀嚎着倒下，你惊讶地发现克莱门汀站在其后。\n「我是来道别的，」面对你的质问，她不予回答，「为了表达对你的感谢，我可以告诉你一些线索。不过……那将需要你的信任。\n让我催眠你，你就能知道我知道的一切。」\n你能相信她吗？\n「小心，」拉蒙娜警告道，「她不可能别无所图。」"
  },
  Event_7509_Name = {
    Text = "催眠疗法"
  },
  Event_7510_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7510_Desc = {
    Text = "你集中精神，幻象如水墨一般散去。你继续向前，却无法彻底清除心头的阴霾。"
  },
  Event_7510_Name = {Text = "幻象"},
  Event_7511_ChoiceDesc1 = {
    Text = "【可怜的生物？】"
  },
  Event_7511_ChoiceDesc2 = {
    Text = "【进化的人类？】"
  },
  Event_7511_ChoiceDesc3 = {
    Text = "【你究竟是谁？】"
  },
  Event_7511_Desc = {
    Text = "你们第六次见到的男人，站在钢架的高处，俯瞰着大地。猎猎的风卷起他的长发，露出蛇的真容。\n他的视线聚焦在你们身上，片刻后又抛向远方的黑暗。\n「啊，这是怎样可怜的生物啊。\n被背叛的感觉，一定像<Bold:进化>的人类一样甘美吧。」"
  },
  Event_7511_Name = {
    Text = "怪异旅伴Ⅵ"
  },
  Event_7512_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7512_Desc = {
    Text = "谁会在地狱犬的凝视下关注一卷胶片？"
  },
  Event_7512_Name = {
    Text = "记忆光影"
  },
  Event_7513_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7513_Desc = {
    Text = "不去看，不去讨论，不去听，甚至不要去想——聪明人的选择。"
  },
  Event_7513_Name = {
    Text = "符文狂意"
  },
  Event_7514_ChoiceDesc1 = {
    Text = "【离开】删除2张卡牌"
  },
  Event_7514_Desc = {
    Text = "在周围嘈杂的声音之中，你依稀听到了奇异的振翅声。银钥匙在你胸口猛然振动，你被某种力量驱使着仰头，看到空中出现的巨大黑洞。\n「可惜，可惜，不过没关系。我们还会再次相见，我尊敬的无目之眼。」"
  },
  Event_7514_Name = {
    Text = "催眠疗法"
  },
  Event_7515_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7515_Desc = {
    Text = "你可以忽视周围的一切，却无法忽略心脏的跳动。它加快了鼓动频率，催促着你，也埋怨着你。"
  },
  Event_7515_Name = {Text = "左心房"},
  Event_7516_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7516_Desc = {
    Text = "「那就好！！！威廉学长的头发保住了！！！」\n虽然只是文字信息，电报上的内容却让你幻听了那种声嘶力竭的咆哮。"
  },
  Event_7516_Name = {
    Text = "紧急通讯"
  },
  Event_7517_ChoiceDesc1 = {
    Text = "【告诉他真相】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7517_ChoiceDesc2 = {
    Text = "【隐瞒真相】获得3选1刻印"
  },
  Event_7517_Desc = {
    Text = "「请救救我。」\n忧郁的旅人抓住你的手。他已在这里徘徊了数百年。\n「我是一名士兵，奉命前往遥远的东方征伐异教徒。\n我穿过密林，淌过河流，却迷失了方向，一次又一次地回到同样的地方。\n有什么东西在黑暗中看着我。我看不见，但我知道。它一直看着我。\n现在我只想回家……」\n你望向它背后漂浮不定的残影。它们先是模糊，随后逐渐清晰——那是一个张开的大嘴，正亟待享用已经腌制百年的迷失魂灵。"
  },
  Event_7517_Name = {Text = "吞噬者"},
  Event_7518_ChoiceDesc1 = {
    Text = "【深入黑暗】"
  },
  Event_7518_ChoiceDesc2 = {
    Text = "【道别】"
  },
  Event_7518_Desc = {
    Text = "「希莱斯特，你会帮我这一次的吧。」\n女孩踌躇不安地原地踱步，不时回头看向安静的唤醒体。\n她没有回应女孩，在女孩神情越发焦急时，微风卷起白纱，轻轻地将女孩推向了某个方向。\n「我会庇佑你。」\n我会庇佑你，即便在「庇佑」一事上，我曾失职过一次。\n但这次，我不会让你一个人迷失在黑暗中。"
  },
  Event_7518_Name = {
    Text = "航船圣女的庇佑"
  },
  Event_7519_ChoiceDesc1 = {
    Text = "【离开】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7519_Desc = {
    Text = "那些歌声有的古老，古老到在洪水蔓延前就已失传；也有的很新颖，唱着上一个新年，妻子在伦蒂尼恩百货买的新手套……情绪重合的混乱过后，留下的是一片心中的空洞。"
  },
  Event_7519_Name = {Text = "船歌"},
  Event_7520_ChoiceDesc1 = {
    Text = "【驱逐色彩】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7520_ChoiceDesc2 = {
    Text = "【拥抱色彩】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_7520_ChoiceDesc3 = {
    Text = "【转身离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7520_Desc = {
    Text = "墨菲跟在身后寸步不离，却在路过某个拐角时僵在原地。\n流动的溢彩在眼前翻滚，将空气卷出了叹息的声音。\n「墨@1……」\n是身陷索纳尼尔号囹圄的溺者幽魂吗？还是追随生者而来的往生亲朋？"
  },
  Event_7520_Name = {
    Text = "怀念的色彩"
  },
  Event_7521_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7521_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7521_Desc = {
    Text = "耳边传来了熟悉的话语，亲切而令人安心，想要循声寻找时，声音却戛然而止。"
  },
  Event_7521_Name = {
    Text = "异常联络"
  },
  Event_7522_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7522_Desc = {
    Text = "「那是一段亵渎的乐声。」\n你捂着耳孔里流出的血水，这样确信道。"
  },
  Event_7522_Name = {
    Text = "禁忌音色"
  },
  Event_7523_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7523_Desc = {
    Text = "那色彩隐约扭曲成两个人类的形状，但祂们只在那个角落伫立不动，用目光为你们送上最后的祝福。"
  },
  Event_7523_Name = {
    Text = "怀念的色彩"
  },
  Event_7524_ChoiceDesc1 = {
    Text = "【聆听】获得3选1黄金造物"
  },
  Event_7524_Desc = {
    Text = "达芙黛尔的声音停顿了片刻。\n「哦呀，你选择了这个吗？不错的选择，作为奖励，我会特别送你一个礼物。」"
  },
  Event_7524_Name = {
    Text = "提示时间"
  },
  Event_7525_ChoiceDesc1 = {
    Text = "【坚持询问】感染「(Skill.Arg1)」"
  },
  Event_7525_ChoiceDesc2 = {
    Text = "【放弃询问】选择1张卡牌删除"
  },
  Event_7525_Desc = {
    Text = "「嗯，聪明的选择。大敌当前，肯定会想要知己知彼？不过，知晓太多关于维度的秘密可是会干扰神志的哦？」"
  },
  Event_7525_Name = {
    Text = "提示时间"
  },
  Event_7526_ChoiceDesc1 = {
    Text = "【坚持询问】激怒达芙黛尔，进入战斗"
  },
  Event_7526_ChoiceDesc2 = {
    Text = "【放弃询问】承受一些小小的惩罚"
  },
  Event_7526_Desc = {
    Text = "「哦？这种时候你还惦记着追踪我吗？小家伙，太贪心可不好哦？」"
  },
  Event_7526_Name = {
    Text = "提示时间"
  },
  Event_7527_ChoiceDesc1 = {
    Text = "【定睛细看】提高 Arg1 点最大生命"
  },
  Event_7527_ChoiceDesc2 = {
    Text = "【无视】随机2张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染2张「(Skill.Arg2)」"
  },
  Event_7527_Desc = {
    Text = "你们追着地狱犬的身影，在小镇的道路上奔行。\n天空中开始飘落冰冷的雪花，温柔地落在脸颊，落在胸口，抚慰你那躁动不安的内心。"
  },
  Event_7527_Name = {Text = "雪"},
  Event_7528_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7528_Desc = {
    Text = "你挥舞双臂，试图驱散这些恼人的乌鸦。\n它们发出嘎嘎的笑声，似乎是在嘲讽你的愚蠢和弱小。\n不管怎么说，你的勇气依旧打动了它们，你获得了应有的奖励。"
  },
  Event_7528_Name = {
    Text = "群鸦之歌"
  },
  Event_7529_ChoiceDesc1 = {
    Text = "【关于莉莉】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7529_ChoiceDesc2 = {
    Text = "【关于地狱犬】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7529_Desc = {
    Text = "穿越无尽之门扉，从遥远得无法触及之地，传来了达芙黛尔的声音。\n「这里是达芙黛尔的提示时间。」"
  },
  Event_7529_Name = {
    Text = "提示时间"
  },
  Event_7530_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7530_Desc = {
    Text = "你仍然显得顽强，在吟唱中仍能依循自我。\n你不相信耳畔的呓语，所仰赖之物只有人类的理性。\n不过……赖以维生的坚实地面，被粘稠的黑浆笼罩的那一天，挖出眼球作为窥伺之物，将是你弥留之际的唯一选择。"
  },
  Event_7530_Name = {
    Text = "群鸦之歌"
  },
  Event_7531_ChoiceDesc1 = {
    Text = "【直视地狱犬来源】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7531_ChoiceDesc2 = {
    Text = "【专注战斗】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7531_Desc = {
    Text = "地狱犬的轮廓变化着。\n他的身躯连接着墙壁的罅隙，透露出诡丽的幻象。"
  },
  Event_7531_Name = {
    Text = "来自角度"
  },
  Event_7532_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7532_Desc = {
    Text = "「喵，喵喵，喵喵喵……」\n你捏着嗓子，竭力使自己显得柔弱无害。\n「喵！喵喵！喵喵喵！」\n猫群似乎接受了你的善意，回以嘹亮的呼喊。你们的叫声此起彼伏，昼夜不歇，月亮都被吓得躲进云里。"
  },
  Event_7532_Name = {Text = "猫之城"},
  Event_7533_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7533_Desc = {
    Text = "不过是挣扎求生的生灵，求得一块歇脚的浮木罢了……\n你叹息一声，任由蝴蝶尾部的黑浆淌至脸颊。"
  },
  Event_7533_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7534_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7534_Desc = {
    Text = "你使出了吃奶的力气，直到离猫群远远的。\n待回望时，猫咪们早已各自回位。梳毛的、打盹的、还有互相打架的……\n说实话，它们不关心人类。"
  },
  Event_7534_Name = {Text = "猫之城"},
  Event_7535_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7535_Desc = {
    Text = "你将手中剩余的肉块丢进猫群。\n群猫如黑色的潮水涌上前。它们发疯般撕咬肉块，又迅速一哄而散。\n很不幸，这是一块过期肉。能填饱干瘪的肚皮，却不怎么叫人痛快。"
  },
  Event_7535_Name = {Text = "猫之城"},
  Event_7536_ChoiceDesc1 = {
    Text = "【直视眼睛】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7536_ChoiceDesc2 = {
    Text = "【放弃抵抗】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_7536_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7536_Desc = {
    Text = "无数眼睛环绕在你耳边低语。\n「我们旅行，我们停下，我们大步流星走过了数万年甚至更长时间。\n当太阳在凝望中逐渐暗淡，当旧地球的生命被洪水湮没。\n我们早已被宇宙的奥秘深深吸引。」"
  },
  Event_7536_Name = {Text = "眼"},
  Event_7537_ChoiceDesc1 = {
    Text = "【感到惶恐】随机觉醒1名唤醒体"
  },
  Event_7537_ChoiceDesc2 = {
    Text = "【感到满足】选择觉醒1名唤醒体，并降低其觉醒卡算力消耗2点。感染「(Skill.Arg1)」"
  },
  Event_7537_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7537_Desc = {
    Text = "你见过一个没有月亮和群星的天空，空中高悬的是无数颗放大的瞳仁。\n仿佛你一伸手，就能将它们拧下，溅得血肉横飞。\n可你张开五指，触及之地空无一物。\n命运的眼睛一眨不眨地注视着你，祂们从混沌的宇宙中，捡到了一粒晶莹的沙砾。"
  },
  Event_7537_Name = {
    Text = "穹顶之瞳"
  },
  Event_7538_ChoiceDesc1 = {
    Text = "【放下捂耳的双手】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7538_ChoiceDesc2 = {
    Text = "【继续捂住耳朵】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7538_Desc = {
    Text = "尖啸，毫无尽头的尖啸——\n乌鸦歌者披着黑亮的皮毛，尖喙上泛着冷硬的寒光，嘹亮的悲鸣一次次划破你的耳膜。\n放下你捂耳的手吧！\n夜间纵情引吭的鸦群，要畅饮你蜷缩之躯内，那未经淬炼的战栗。"
  },
  Event_7538_Name = {
    Text = "鸦群之歌"
  },
  Event_7539_ChoiceDesc1 = {
    Text = "【学猫叫】获得50黑印"
  },
  Event_7539_ChoiceDesc2 = {
    Text = "【投喂食物】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7539_Desc = {
    Text = "你误入了黑猫的地盘。\n无数眼睛在黑暗中倏然睁开，带着探究、审视、戒备……唯独没有善意。\n祖母绿、琥珀黄、孔雀蓝……\n你仿佛置身一片闪耀的宝石之海。\n为了脱身，你——"
  },
  Event_7539_Name = {Text = "猫之城"},
  Event_7540_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7540_Desc = {
    Text = "你注意到一只与众不同的手。它细嫩、白皙，从始至终都表现得很平静。\n更重要的是——你认出来了，那是你自己的手。\n你当机立断，将它狠狠拧断。\n耳畔传来无数刺耳的尖啸，沼泽终于消失了。"
  },
  Event_7540_Name = {
    Text = "黯色沼泽"
  },
  Event_7541_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7541_Desc = {
    Text = "「明智的决定。」两手空空的人影说，「已经被验证的选择有着既定的结局，未知的行为则会导向新的未来。」\n细微的希望将你温柔笼罩。人影消散，你扶着心口，不知刚才的究竟是投影，还是精神在重压下产生的幻觉。"
  },
  Event_7541_Name = {
    Text = "分岔的小径"
  },
  Event_7542_ChoiceDesc1 = {
    Text = "【表扬它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7542_ChoiceDesc2 = {
    Text = "【嘲讽它】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_7542_Desc = {
    Text = "脑子说：锁链困住了我的前脑、我的脑干，我的大脑皮层，却无法束缚100多亿个追求真理的小小细胞。\n你说：谁把你困在这里的？你的身体呢？\n脑子说：身体？快别说笑了。过去它们都叫我「卖猪肉的老强尼」。\n有身体的时候，我连十以内的加减法都算不明白。\n可当馆长为我剔除冗余的肉身后，瞧瞧我变成什么样了！一位物理学家，哲学家，以及业余诗人。"
  },
  Event_7542_Name = {
    Text = "哲学之脑"
  },
  Event_7543_ChoiceDesc1 = {
    Text = "【证明哥德巴赫猜想】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7543_ChoiceDesc2 = {
    Text = "【旅程的终点】随机1张卡牌获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7543_ChoiceDesc3 = {
    Text = "【拒绝提问】获得50黑印"
  },
  Event_7543_Desc = {
    Text = "捡起通灵板时，年轻女性的声音冲进了你的大脑。\n「向我提问吧，我无所不知。」\n「从我的回答中，你能得到命运的赠礼。」"
  },
  Event_7543_Name = {Text = "通灵板"},
  Event_7544_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7544_Desc = {
    Text = "你阅读着斑驳残破的纸张，支离破碎的句子从你口中流出，「先祖」、「圣子」、「永恒的死亡」、「漫长的记忆」等名词冲刷着脑海，刺激着你本就因梦魇而变得敏感脆弱的神经。"
  },
  Event_7544_Name = {
    Text = "密令·上"
  },
  Event_7545_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7545_Desc = {
    Text = "黑泥滴落在你脸上，泛起了一阵麻痒。\n你无法忍受，伸手将蝴蝶拍开。\n蝴蝶躲过你不怀好意的动作，无声无息地消失在尽头。"
  },
  Event_7545_Name = {
    Text = "黑液蝴蝶"
  },
  Event_7546_ChoiceDesc1 = {
    Text = "【离开】寻找探照灯"
  },
  Event_7546_ChoiceDesc2 = {
    Text = "【闯入雾气】失去 Arg2 点生命"
  },
  Event_7546_ChoiceDesc3 = {
    Text = "【直接进入】"
  },
  Event_7546_Desc = {
    Text = "前方是一片浓厚的黑色雾气，贸然进入将招致灾厄。\n或许你应该找到「探照灯」驱散雾气。"
  },
  Event_7546_Name = {Text = "未知"},
  Event_7547_ChoiceDesc1 = {
    Text = "【接受幻觉】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7547_ChoiceDesc2 = {
    Text = "【否认幻觉】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7547_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7547_Desc = {
    Text = "厚重黑暗的铁架桥下，芦苇丛生的寂静河滩上，忽然飞出一只闪光的蝴蝶。\n蝴蝶轻盈地落在你的掌心，糟糕的嚎叫声停息了，取而代之的是搬运钢筋的工人整齐的号子声，钉头锤的敲打声，铆钉碰撞的清脆金属声……"
  },
  Event_7547_Name = {
    Text = "钢桥的幻觉"
  },
  Event_7548_ChoiceDesc1 = {
    Text = "【驱赶乌鸦】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_7548_ChoiceDesc2 = {
    Text = "【继续追逐孩子】获得25黑印，离开"
  },
  Event_7548_Desc = {
    Text = "一只乌鸦伫立在吊灯。\n两只乌鸦伫立在吊灯。\n三只乌鸦伫立在吊灯。\n……\n那些漆黑的生物扭曲脖颈，站在巷口的吊灯上，用包含恶意的眼神俯视着你。那重影般的头颅，似乎共用着同一个浸没在融蚀浆中的身体。"
  },
  Event_7548_Name = {
    Text = "黑鸦凝视"
  },
  Event_7549_ChoiceDesc1 = {
    Text = "【离开】觉醒唤醒体数量少于3名时，获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7549_ChoiceDesc2 = {
    Text = "【离开】已觉醒唤醒体数量至少拥有3名时，获得黄金造物「(RelicConfig.Arg1)」"
  },
  Event_7549_Desc = {
    Text = "你没有理会这道痕迹，迈步向前。\n<Italic:觉醒的灵知何其沉重>，痕迹随着你的步子愈发扩大、愈发蜿蜒，似乎随时能从裂口中伸出一只手，将你拖入深处。"
  },
  Event_7549_Name = {
    Text = "爬行裂痕"
  },
  Event_7550_ChoiceDesc1 = {
    Text = "【回应目光】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7550_ChoiceDesc2 = {
    Text = "【躲开目光】 随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_7550_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_7550_Desc = {
    Text = "你能感觉到一股视线，一个超脱维度、远高于密境的目光正在注视，注视着你，也注视着你面前的女孩。\n你的呼吸开始急促，理智深处，原始的恐惧开始尖叫。"
  },
  Event_7550_Name = {
    Text = "谁的目光"
  },
  Event_7551_ChoiceDesc1 = {
    Text = "【继续寻找】提升 Arg1 点生命，感染「(Skill.Arg2)」"
  },
  Event_7551_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7551_Desc = {
    Text = "隐约的光芒出现在眼前，明亮而温暖，想要循光而去时，它却忽地消失了。"
  },
  Event_7551_Name = {
    Text = "异常联络"
  },
  Event_7552_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7552_Desc = {
    Text = "轻声附和着祂们的吟唱，温暖的水流为你送来了归乡的祝福。"
  },
  Event_7552_Name = {
    Text = "海洋歌谣"
  },
  Event_7553_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7553_Desc = {
    Text = "你在前方发现了隐约的光亮，你终于穿出了这片令人窒息的浓雾"
  },
  Event_7553_Name = {
    Text = "混沌迷雾"
  },
  Event_7554_ChoiceDesc1 = {
    Text = "【解开下方的枝节】"
  },
  Event_7554_Desc = {
    Text = "残留密境的灵知互相勾连，纠缠出一片不稳定的力场。\n或许，你能解开缠绕的灵，为自己梳理出前进的道路。"
  },
  Event_7554_Name = {
    Text = "纠缠之路"
  },
  Event_7555_ChoiceDesc1 = {
    Text = "【解开上方的枝节】"
  },
  Event_7555_Desc = {
    Text = "残留密境的灵知互相勾连，纠缠出一片不稳定的力场。\n或许，你能解开缠绕的灵，为自己梳理出前进的道路。"
  },
  Event_7555_Name = {
    Text = "纠缠之路"
  },
  Event_7556_ChoiceDesc1 = {
    Text = "【解开左侧的枝节】"
  },
  Event_7556_Desc = {
    Text = "残留密境的灵知互相勾连，纠缠出一片不稳定的力场。\n或许，你能解开缠绕的灵，为自己梳理出前进的道路。"
  },
  Event_7556_Name = {
    Text = "纠缠之路"
  },
  Event_7557_ChoiceDesc1 = {
    Text = "【解开左侧的枝节】"
  },
  Event_7557_Desc = {
    Text = "残留密境的灵知互相勾连，纠缠出一片不稳定的力场。\n或许，你能解开缠绕的灵，为自己梳理出前进的道路。"
  },
  Event_7557_Name = {
    Text = "纠缠之路"
  },
  Event_7558_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7558_Desc = {
    Text = "你们还面临数场恶战，现在可不是悠哉调查的时候。"
  },
  Event_7558_Name = {
    Text = "器官登记"
  },
  Event_7559_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7559_Desc = {
    Text = "纸张上的字符忽然变得完整而鲜活，令人惊骇的言辞足以撼动一切无意识的痛苦者的信念和根基。你越读越迷茫，越读越恐惧，止不住用指尖抓挠自己的头皮。\n突然之间，那些充满诅咒的符号消失了。拉蒙娜打断了你的阅读，然后强行将书页塞进了手提箱中。"
  },
  Event_7559_Name = {
    Text = "密令·下"
  },
  Event_7560_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7560_Desc = {
    Text = "欢喜，忧愁，悲伤，苦闷……这些都是你的情感。\n你，和无数身处维度外的其他世界的各种各样的你。"
  },
  Event_7560_Name = {Text = "沉溺"},
  Event_7561_ChoiceDesc1 = {
    Text = "【静静听着】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7561_ChoiceDesc2 = {
    Text = "【她在这儿】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7561_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7561_Desc = {
    Text = "怪物的哀鸣在你的脑海中回荡，不成人形的黑色黏液中，一个声音微弱地呢喃着「莎莎姐姐」，「莎莎姐姐」。\n「莎莎姐姐，你在哪里？」"
  },
  Event_7561_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_7562_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7562_Desc = {
    Text = "「加入他，加入他们，加入我们。\n成为祂的守护者，成为祂的代行者。\n以祂的梦境作为你前进的方向……」\n混乱的祷言搅动着你的意识，那些声音消失后，你才惊觉自己早已满头大汗。"
  },
  Event_7562_Name = {
    Text = "梦境祷文"
  },
  Event_7563_ChoiceDesc1 = {
    Text = "【没听说过】"
  },
  Event_7563_ChoiceDesc2 = {
    Text = "【听说过】"
  },
  Event_7563_Desc = {
    Text = "「这位同学，能占用你一点时间吗？\n我希望能耽误你们几分钟，向你们介绍一下本地的乡野传说。\n你们听说过一种叫做『刻耳柏洛斯』的生物吗？」"
  },
  Event_7563_Name = {
    Text = "怪异旅伴Ⅰ"
  },
  Event_7564_ChoiceDesc1 = {
    Text = "【放弃思考】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7564_ChoiceDesc2 = {
    Text = "【追上灵感】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7564_Desc = {
    Text = "港口遇袭，有来无回的神秘货轮和有鳍的「新朋友」……这是精心筹备的陷阱吗？还是又一场意外频发的旅行？\n现实与理智互相拉扯纠缠，无数的灵感与念头从脑海喷涌而出。"
  },
  Event_7564_Name = {
    Text = "灵感迸发"
  },
  Event_7565_ChoiceDesc1 = {
    Text = "【艾尔沃斯的火山？】提升 Arg1 点最大生命"
  },
  Event_7565_ChoiceDesc2 = {
    Text = "【努力回忆】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7565_Desc = {
    Text = "莉莉的两颊，落下黑色的泪水。「我们见过的，妈妈，」她轻声呢喃，「在艾尔沃斯的火山……」"
  },
  Event_7565_Name = {
    Text = "火山追忆"
  },
  Event_7566_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7566_Desc = {
    Text = "「蹈@1…海……」\n符文在眼前若隐若现，你控制不住地向虚空伸手，想要抓住它们——\n「愣着干嘛！他们可要追上来了！」\n神秘少女拽着你往甲板另一头跑去，打断了你与符文的交流。\n但确实有什么力量，在你指尖留下了痕迹。"
  },
  Event_7566_Name = {
    Text = "符文狂意"
  },
  Event_7567_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7567_Desc = {
    Text = "你对神神叨叨的呓语毫无兴趣，更不想冒着癫狂的风险走入暗夜。"
  },
  Event_7567_Name = {
    Text = "一封求救信"
  },
  Event_7568_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7568_Desc = {
    Text = "无论如何，守密人的职责在你胸口膨胀，你不能放弃寻到寄件人的希望，即使它是如此模糊不清、晦暗不明。"
  },
  Event_7568_Name = {
    Text = "一封求救信"
  },
  Event_7569_ChoiceDesc1 = {
    Text = "【观察它】可以获得25黑印"
  },
  Event_7569_ChoiceDesc2 = {
    Text = "【抚摸它】50%机会获得50黑印，50%机会一无所有"
  },
  Event_7569_Desc = {
    Text = "小巷中突然蹿出一只黑猫，异常亲热地缠绕在你们的脚边，幽绿的竖瞳闪烁着令人不寒而栗的光芒，仿佛在说「别追了，陪我玩一会儿吧。」\n 「你已经看见祂了，祂就在你的身侧，那些被疯狂污染的，狂热的影子……不要直视祂的轮廓。」"
  },
  Event_7569_Name = {
    Text = "夜色精灵"
  },
  Event_7570_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7570_Desc = {
    Text = "「不可能，我不相信！」声音尖叫起来，「这个把我送给恶魔的女人，才不是我的莎莎姐姐！」"
  },
  Event_7570_Name = {
    Text = "「莎莎姐姐」"
  },
  Event_7571_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7571_Desc = {
    Text = "「收到，我们将进行基础物资输送，请注意查收。」"
  },
  Event_7571_Name = {
    Text = "支援通讯"
  },
  Event_7572_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7572_Desc = {
    Text = "已是无用之物。"
  },
  Event_7572_Name = {
    Text = "前人遗物"
  },
  Event_7573_ChoiceDesc1 = {
    Text = "【仔细看看】获得3选1刻印"
  },
  Event_7573_ChoiceDesc2 = {
    Text = "【撕下海报】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7573_Desc = {
    Text = "一个蜡像馆内随处可见的烛台。\n借着病态的橙光，你发现墙壁上张贴着一则手绘的海报。"
  },
  Event_7573_Name = {
    Text = "黑暗中的笑声"
  },
  Event_7574_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7574_Desc = {
    Text = "「莉莉有她自己的心，不需要听从任何人。」你不卑不亢地作答。\n弗朗西斯冷哼一声，没有回应。"
  },
  Event_7574_Name = {
    Text = "她的选择"
  },
  Event_7575_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7575_Desc = {
    Text = "这是一组群像照。\n萎靡不振的人们蹲在铁栅栏后方，满脸困苦。\n其中一张照片吸引了你的注意。那应当是个瘦弱的年轻女性，脸部一片空白。\n那无比亵渎的赘生物，正一圈圈缠绕在她的身体周围。\n你看不见她脸，但在你的想象里，她应该是没有表情的。"
  },
  Event_7575_Name = {
    Text = "如实记录"
  },
  Event_7576_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7576_Desc = {
    Text = "你痴迷地凝望着这些闪耀的首饰，一时不察，已经握住了干瘦的黑色黏液之手。\n而它只是略微握紧了手，随后放开。\n什么都没有发生，只有一缕黑气，顺着你的指尖滑入衣袖。"
  },
  Event_7576_Name = {
    Text = "翻覆魔爪"
  },
  Event_7577_ChoiceDesc1 = {
    Text = "【弹几个音】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7577_ChoiceDesc2 = {
    Text = "【将盖子盖上】获得3选1刻印"
  },
  Event_7577_Desc = {
    Text = "墙边的钢琴敞着盖子。它有着泛黄的琴键和露出木色的开裂的边缘，但每一个琴键都被擦拭得非常干净。\n它是那么多人的快乐源泉。"
  },
  Event_7577_Name = {
    Text = "童年的旋律"
  },
  Event_7578_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7578_Desc = {
    Text = "持矛者闷哼一声，像一个饱受欺负的孩子似地呜咽着。\n声音转瞬即逝，连带另外两个蹈海者也不见踪影……原来只是密境映照出的一段幻象。"
  },
  Event_7578_Name = {
    Text = "穷追不舍"
  },
  Event_7579_ChoiceDesc1 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7579_Desc = {
    Text = "「正确的回答。」\n声音的主人对这个回答十分满意，一个闪闪发光的物件被甩出水面。\n「记住，一切都有代价。」"
  },
  Event_7579_Name = {
    Text = "界外之音"
  },
  Event_7580_ChoiceDesc1 = {
    Text = "【驱散幻象】感染症状。"
  },
  Event_7580_ChoiceDesc2 = {
    Text = "【离开】"
  },
  Event_7580_Desc = {
    Text = "模糊的面孔突然出现，它们围绕在你周围，用不存在的声带绝望地呻吟。"
  },
  Event_7580_Name = {Text = "幻象"},
  Event_7581_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7581_Desc = {
    Text = "你没有理会这道痕迹，迈步向前。\n却像被激怒了一般，痕迹随着你的步子愈发扩大、愈发蜿蜒，似乎随时能从裂口中伸出一只手，将你拖入深处。"
  },
  Event_7581_Name = {
    Text = "爬行裂痕"
  },
  Event_7582_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7582_Desc = {
    Text = "你并不会轻易上当，干脆利落地转身，离开了这里。"
  },
  Event_7582_Name = {
    Text = "爬行裂痕"
  },
  Event_7583_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7583_Desc = {
    Text = "你意识到裂痕的不同寻常，蹲下察看，奇怪的是，方才还在蔓延的裂痕，却如同突然死亡一样，陷入了永恒的寂静。"
  },
  Event_7583_Name = {
    Text = "爬行裂痕"
  },
  Event_7584_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7584_Desc = {
    Text = "「不，是清醒的头脑。决心可没法帮你解决融蚀体，守密人，好好思考对策吧。」"
  },
  Event_7584_Name = {
    Text = "罗格斯定则"
  },
  Event_7585_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7585_Desc = {
    Text = "你无力抵抗内心的冲动。\n手指像迷失在树林里的孩童，在键盘上游荡、嬉戏……\n渐渐地，有蝴蝶从打字机中飞了出来。\n一只、两只、三只……\n脸上、手指上，成群的蝴蝶像是空中绽放的烟花，在黑暗中闪动着宝石般的光芒。\n这台打字机没有任何实际功用，但它对创造美却很在行。"
  },
  Event_7585_Name = {Text = "眼"},
  Event_7586_ChoiceDesc1 = {
    Text = "【拴好母鸡】"
  },
  Event_7586_Desc = {
    Text = "拉伊特产，活蹦乱跳的母鸡，美食的诱惑。"
  },
  Event_7586_Name = {
    Text = "制作陷阱"
  },
  Event_7587_ChoiceDesc1 = {
    Text = "【大功告成】"
  },
  Event_7587_Desc = {
    Text = "廉价但好用的陷阱！"
  },
  Event_7587_Name = {
    Text = "制作陷阱"
  },
  Event_7588_ChoiceDesc1 = {
    Text = "【放置捕兽夹】"
  },
  Event_7588_Desc = {
    Text = "金属制的捕兽夹，懒惰猎人的好帮手。"
  },
  Event_7588_Name = {
    Text = "制作陷阱"
  },
  Event_7589_ChoiceDesc1 = {
    Text = "【查看电报机】感染「(Skill.Arg1)」，获得黄金造物「(RelicConfig.Arg2)」"
  },
  Event_7589_ChoiceDesc2 = {
    Text = "【无视】获得50黑印"
  },
  Event_7589_Desc = {
    Text = "你躲进狭长的山洞裂隙，暂避风雪。但你深知自己无法在这里停滞太久，若是那群黑袍的怪人找到此处，你将无路可逃。\n在狭缝的角落里，你居然发现了一台电报机。"
  },
  Event_7589_Name = {
    Text = "无声电报"
  },
  Event_7590_ChoiceDesc1 = {
    Text = "【检查胶片】随机升级2张卡牌的刻印效果"
  },
  Event_7590_ChoiceDesc2 = {
    Text = "【检查相机】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7590_Desc = {
    Text = "像拉出一截内脏般，相机肚子里的胶片被扯得稀烂，开膛破肚地丢弃在这里，无人问津。\n一道刺目的白光闪过，遗弃在街角的相机歪斜着，快门被凭空按动。\n「咔擦——」\n你那错愕的、愣怔的神情，被忠实记载于相机中的胶卷上。"
  },
  Event_7590_Name = {
    Text = "记录无罪"
  },
  Event_7591_ChoiceDesc1 = {
    Text = "【掐住歌者的喉咙】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7591_ChoiceDesc2 = {
    Text = "【绊倒舞者的步伐】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7591_ChoiceDesc3 = {
    Text = "【夺走诗人的稿纸】获得50黑印"
  },
  Event_7591_Desc = {
    Text = "你被三个粘稠的人影挡住去路。\n一个人影唱着歌，声音嘶哑，歌词诡异，你捂住耳朵，绕开了它。\n一个人影跳着舞，动作僵硬，步伐犹疑，你闭上眼睛，躲开了它。\n一个人影吟着诗，韵律破碎，语句不通，你忍无可忍，于是——"
  },
  Event_7591_Name = {
    Text = "狭路上的恶徒"
  },
  Event_7592_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7592_Desc = {
    Text = "「不！人类的进步靠的不是历史，也不是科技，而是老鼠。」\n「是老鼠开启了那个黑暗的时代，随后人类才迎来复兴的曙光。」\n「人类需要你们——虽然不是每个人都理解这一点。」\n老鼠们被你的长篇大论说得有些迷糊，不过还是放你离开了。"
  },
  Event_7592_Name = {Text = "鼠疫"},
  Event_7593_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7593_Desc = {
    Text = "你忍住视神经的抽搐，勉强辨识着……\n那里似乎绘制着一个已经撕裂的正圆形法阵。\n法阵内部由无数的弧线构成，似是静态又像在流动，令人目眩神迷。"
  },
  Event_7593_Name = {
    Text = "来自角度"
  },
  Event_7594_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7594_Desc = {
    Text = "<Bold>罗杰斯蜡像馆\n南华克街44号，伦蒂尼恩市@2区\n参观时间：21：00-6:00\n3:00停止入场（周末闭馆）\n\n<Bold>当前展览\n弗拉基米尔·@2：\n微笑的哲学"
  },
  Event_7594_Name = {
    Text = "黑暗中的笑声"
  },
  Event_7595_ChoiceDesc1 = {
    Text = "【对视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7595_ChoiceDesc2 = {
    Text = "【闭眼】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7595_ChoiceDesc3 = {
    Text = "【背对】获得25黑印"
  },
  Event_7595_Desc = {
    Text = "本不该看见星空的。\n在索纳尼尔号的密境中，天幕流转华光，星月身形皆隐。\n在昏暗的船舱中，你也不该看见星空的。\n这里只该有零星的白炽灯和老灯笼——可为什么，你还是感受到了高悬天际的目光？"
  },
  Event_7595_Name = {Text = "窥视"},
  Event_7596_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7596_Desc = {
    Text = "你选择勇敢地直视眼睛。\n它们是璀璨的繁星，在黑暗中闪闪发光。\n随后它们笑了起来，又变成无数个弯弯的月亮。\n眼睛说：「你不惧怕目光。你也不应当惧怕……好久不见，@2」\n消失前，它们送给你一件小小的礼物，作为「重逢的纪念」。"
  },
  Event_7596_Name = {Text = "眼"},
  Event_7597_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7597_Desc = {
    Text = "铁路桥，伦蒂尼恩的血管与神经，连接城市的心脏与四肢，只要太阳还没有从此处落下，伦蒂尼恩的心脏就将永远激昂搏动。"
  },
  Event_7597_Name = {
    Text = "钢桥的幻觉"
  },
  Event_7598_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7598_Desc = {
    Text = "一首无比华丽的赋格曲，作曲者不详。\n无数声部带着相近的主题交织涌出，每个音符就像外科医生的手术刀一般精准、冷酷。\n精确而华丽——这就是罗杰斯的美学。\nFuga，飞翔吧！"
  },
  Event_7598_Name = {
    Text = "糟糕的品味"
  },
  Event_7599_ChoiceDesc1 = {
    Text = "【出声问好】"
  },
  Event_7599_ChoiceDesc2 = {
    Text = "【寻求帮助】"
  },
  Event_7599_Desc = {
    Text = "手扶上船舷的瞬间，你看见了一个白裙少女。\n高贵、圣洁、虚幻……和几分眼熟。\n究竟是在什么地方见过她呢？你正艰难地挖掘着混乱的记忆，她却突然意识到你的存在一般，隔着虚空与你对视。\n她的眼睛平静如初春的海洋，你却奇异地从中读出了什么……\n她似乎在等待你向她问好，哪怕只是谈论今天的天气。"
  },
  Event_7599_Name = {
    Text = "白裙少女"
  },
  Event_7600_ChoiceDesc1 = {
    Text = "【表扬它】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_7600_ChoiceDesc2 = {
    Text = "【嘲讽它】感染「(Skill.Arg1)」，再次随机刻印"
  },
  Event_7600_Desc = {
    Text = "詹金说：强尼！你和以前还真是……大不相同，不管从哪方面来看。\n你说：你真是一个既勤奋又有追求的脑子。\n脑子扭捏了蠕动了几下，显然非常高兴。\n脑子说：来吧！既然你们如此认可我现在的成就，那我将授予你们我的毕生所学……"
  },
  Event_7600_Name = {
    Text = "哲学之脑"
  },
  Event_7601_ChoiceDesc1 = {
    Text = "【华丽的赋格】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7601_ChoiceDesc2 = {
    Text = "【简单的小夜曲】所有唤醒体回复50狂气，感染「(Skill.Arg1)」"
  },
  Event_7601_ChoiceDesc3 = {
    Text = "【毫无意义的噪音】获得3选1刻印"
  },
  Event_7601_Desc = {
    Text = "「我个人不太赞同馆长的音乐品味，你懂的......\n那太花哨了，而我是个脚踏实地的人。」\n嘎吱转动的留声机里传来疲惫的男声，孤苦伶仃地控诉着。\n「但这是我的工作......好了，咱们节约时间，选一张吧。」"
  },
  Event_7601_Name = {
    Text = "糟糕的品味"
  },
  Event_7602_ChoiceDesc1 = {
    Text = "【有特殊造物，获得黄金造物「(RelicConfig.Arg1)」】"
  },
  Event_7602_ChoiceDesc2 = {
    Text = "【离开】获得50黑印"
  },
  Event_7602_Desc = {
    Text = "事件253（开发中），非最终效果"
  },
  Event_7602_Name = {
    Text = "事件253（开发中）"
  },
  Event_7603_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7603_Desc = {
    Text = "你以最快的速度奔离现场。\n现在你们正面临有史以来最难缠、最恶心的怪物——那些密密麻麻的蜡像们。\n和它们比起来，这几个简陋的泥坯着实有点不够看的。\n凡事分清轻重缓急——这是守密人应当恪守的原则之一。"
  },
  Event_7603_Name = {Text = "习作"},
  Event_7604_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7604_Desc = {
    Text = "银钥闪烁，白银辉光填满空间，将浓稠流动的彩色染成纯净的银。\n光芒须臾即逝，只有风留下了哀婉的恸哭。"
  },
  Event_7604_Name = {
    Text = "怀念的色彩"
  },
  Event_7605_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7605_Desc = {
    Text = "那虹彩令你目眩神迷，不知不觉中，你陶醉其中……"
  },
  Event_7605_Name = {
    Text = "群星岔路"
  },
  Event_7606_ChoiceDesc1 = {
    Text = "【继续坠落】感染「(Skill.Arg1)」，是否继续下坠"
  },
  Event_7606_ChoiceDesc2 = {
    Text = "【抽身离开】获得25黑印"
  },
  Event_7606_Desc = {
    Text = "「你」邀请着你。\n在螺旋的深处，过去与未来的「你」向你送上来了来自不同维度的「赠礼」。"
  },
  Event_7606_Name = {
    Text = "螺旋深渊"
  },
  Event_7607_ChoiceDesc1 = {
    Text = "【了然于心】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7607_ChoiceDesc2 = {
    Text = "【一无所知】获得3选1黄金造物，感染「(Skill.Arg1)」"
  },
  Event_7607_ChoiceDesc3 = {
    Text = "【离开】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_7607_Desc = {
    Text = "两个银白的发光人影浮现在你的眼前，呈现出浓稠的液态，漂浮在空气中。\n「这里正是我所消亡的地方。」一个人影蹲了下来。\n「无病无灾的神国里，没有所谓渴望和失去，你并不真的知晓——如何才算是消亡。」\n另一个人影叹息道，将视线转向了你。"
  },
  Event_7607_Name = {
    Text = "亡佚神国"
  },
  Event_7608_ChoiceDesc1 = {
    Text = "【离开】寻找探照灯"
  },
  Event_7608_ChoiceDesc2 = {
    Text = "【闯入雾气】感染「(Skill.Arg2)」"
  },
  Event_7608_ChoiceDesc3 = {
    Text = "【直接进入】"
  },
  Event_7608_Desc = {
    Text = "前方是一片浓厚的黑色雾气，贸然进入将招致灾厄。\n或许你应该找到「探照灯」驱散雾气。"
  },
  Event_7608_Name = {Text = "未知"},
  Event_7609_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7609_Desc = {
    Text = "「那是记忆的投影，」拉蒙娜向你解释道，「可能属于某个人，也可能是几个人的共同回忆。」\n宝贵的回忆，值得小心看管。"
  },
  Event_7609_Name = {
    Text = "我们的回忆"
  },
  Event_7610_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7610_Desc = {
    Text = "就算现在无法解读，你也没有放弃，而是将它耐心叠好塞进口袋，等返校后寻求另外的方法读取信息。\n只是，随着信件诡异地凭空皱缩，你的胸口也开始隐隐作痛。"
  },
  Event_7610_Name = {
    Text = "涂字信件"
  },
  Event_7611_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7611_Desc = {
    Text = "蜡烛离开天平的瞬间就自动点燃，它流下乳白的泪水，迅速从你的指缝间滴落，消失不见。"
  },
  Event_7611_Name = {
    Text = "理智与情感"
  },
  Event_7612_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7612_Desc = {
    Text = "你一把将纸抽了出来，打字机却仍在运转。它将一张卡牌卷入，在上面糊满了油墨。\n你仔细辨认，上面好像反复写着「不要直视不要直视不要直视不要直视不要直视」。"
  },
  Event_7612_Name = {
    Text = "不请自来的警告"
  },
  Event_7613_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7613_Desc = {
    Text = "手指触碰到足以令骨髓冻结的冰冷杯沿时，你忽然打了个激灵，清醒了过来。\n不管怎么说，它都不适宜被搁置在路边。还是将它收纳进手提箱吧。"
  },
  Event_7613_Name = {
    Text = "蜂蜜甜酒"
  },
  Event_7614_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7614_Desc = {
    Text = "你狠狠咳嗽。\n声音似乎吓了一跳，随后陷入死寂。\n你感到自己似乎错过了一条重要的线索……\n但人生总是充满错过与遗憾，不是么？"
  },
  Event_7614_Name = {
    Text = "隔墙有耳"
  },
  Event_7615_ChoiceDesc1 = {
    Text = "【守口如瓶】获得25黑印"
  },
  Event_7615_ChoiceDesc2 = {
    Text = "【伸手触碰】50%机会获得50黑印，50%机会一无所有"
  },
  Event_7615_Desc = {
    Text = "「我要说的只有一句箴言——没有人能杀死一只猫！」\n「那该死的黑猫本该被开膛破肚、曝尸荒野，它却刨开了我的家族墓穴，残存的人类腐肉被它吞吃殆尽，尸骨肢体则七零八落地散落。」\n「阴冷幽暗的竖瞳注视下，暗黄的脓液浮起一层恶臭，我连滚带爬地逃离了那里，被噩梦折磨得精神萎靡。」\n「等等……你们要做什么，我没有疯！我没有！你们一定是想掩盖什么！这是真的——」\n这的确是真的，目送癫狂之人的黑影消散，你和脚边安静蹲坐的黑猫对视一眼。"
  },
  Event_7615_Name = {
    Text = "夜猫之祸"
  },
  Event_7616_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7616_Desc = {
    Text = "在你犹豫间，它下沉着溶入融蚀痕，很快消失不见。"
  },
  Event_7616_Name = {
    Text = "桶中浮物"
  },
  Event_7617_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7617_Desc = {
    Text = "你厌烦地将信纸揉成团，扔在了脚边。"
  },
  Event_7617_Name = {
    Text = "涂字信件"
  },
  Event_7618_ChoiceDesc1 = {
    Text = "【确定】"
  },
  Event_7618_Desc = {
    Text = "你集中精神，幻象如水墨一般散去。你继续向前，却无法彻底清除心头的阴霾。"
  },
  Event_7618_Name = {Text = "幻象"},
  Event_7619_ChoiceDesc1 = {
    Text = "【谨慎查看】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7619_ChoiceDesc2 = {
    Text = "【避让人影】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7619_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_7619_Desc = {
    Text = "拉蒙娜的神经紧绷，小心地在疯人院中避开人群移动。\n她躲进一个狭小的房间。\n窗外突然映出人影。"
  },
  Event_7619_Name = {
    Text = "窗中倒影"
  },
  Event_7620_ChoiceDesc1 = {
    Text = "【离开】获得50黑印"
  },
  Event_7620_Desc = {
    Text = "现在更重要的事是将造成这一切的罪魁祸首绳之以法。但愤怒的种子依然在你的心中生根发芽。不等你们回应，男人侧身离开了。"
  },
  Event_7620_Name = {
    Text = "巨兽足印"
  },
  Event_7621_ChoiceDesc1 = {
    Text = "【离开】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_7621_Desc = {
    Text = "自幼在弥萨格接受的教育让你无法对这个拓印坐视不理。你伸手拂去了灰尘脚印，在那个瞬间，你似乎听到了来自遥远维度的回应，「谢谢」。"
  },
  Event_7621_Name = {
    Text = "巨兽足印"
  },
  Event_7622_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7622_Desc = {
    Text = "你握紧银钥匙，柔和的银光和微弱的振动让你感到一阵安心。目光似乎消失了，又似乎没有，不论如何，它在你身上留下了属于它的无形痕迹。"
  },
  Event_7622_Name = {
    Text = "谁的目光"
  },
  Event_7623_ChoiceDesc1 = {
    Text = "【寻找暗道】"
  },
  Event_7623_Desc = {
    Text = "你和拉蒙娜、萝坦兵分三路，开始追击地狱犬。\n\n你疾跑过几条小巷，庞大的身躯出现在你面前。\n它见你追来，立刻拐入下一个转角。\n你拔腿追上，面前出现的却是一条死路，三面高墙围堵出狭窄的方形天空。"
  },
  Event_7623_Name = {Text = "死路"},
  Event_7624_ChoiceDesc1 = {
    Text = "【走过】"
  },
  Event_7624_ChoiceDesc2 = {
    Text = "【抚摸】"
  },
  Event_7624_Desc = {
    Text = "洁净柔软的手术床旁，躺着库姆已经瘫软的躯体。\n她依然很高大，像一座小山，像你初见时那样。\n只是，跟高空中的真正的「地狱犬」相比，她又是那么小，小到像是一个孩子。"
  },
  Event_7624_Name = {Text = "余温"},
  Event_7625_ChoiceDesc1 = {
    Text = "【获得银芯】"
  },
  Event_7625_Desc = {
    Text = "咦，前面似乎有很多亮晶晶的东西！\n闻一闻……香香的。\n舔一舔……冰冰凉凉！\n看起来是很珍贵的东西，快收起来交给小詹金，说不定能换好多奶酪吱！"
  },
  Event_7625_Name = {Text = "亮晶晶"},
  Event_7626_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7626_Desc = {
    Text = "一阵不属于你的失望在你心头漫起，虚幻的网缓缓消散，让出了一条通路。"
  },
  Event_7626_Name = {
    Text = "迷走网路"
  },
  Event_7627_ChoiceDesc1 = {
    Text = "【领悟它】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_7627_ChoiceDesc2 = {
    Text = "【无视它】获得3选1刻印"
  },
  Event_7627_Desc = {
    Text = "流动的符文从鱼形生命的的咆哮中涌出，它们填满了你的耳道，你的鼻腔，你的喉管。它们烧灼着你的身体，只需下一个十秒，你就能领会咆哮中的深意……"
  },
  Event_7627_Name = {
    Text = "符文狂意"
  },
  Event_7628_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7628_Desc = {
    Text = "你咬牙尝试着抵御那迷乱的幻觉。拉蒙娜将某件冰冷的物件置于你的掌心。\n「我刚才发现的造物，或许能帮上你。」"
  },
  Event_7628_Name = {
    Text = "维度幻象"
  },
  Event_7629_ChoiceDesc1 = {
    Text = "选择高级刻印"
  },
  Event_7629_Name = {Text = "22"},
  Event_7630_ChoiceDesc1 = {
    Text = "【摁住乌鸦】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_7630_ChoiceDesc2 = {
    Text = "【杀死乌鸦】获得3选1刻印"
  },
  Event_7630_ChoiceDesc3 = {
    Text = "【离开】"
  },
  Event_7630_Desc = {
    Text = "孤单的乌鸦哑着嗓子，将自己漆黑的羽毛一根根拔下。\n它疼得直颤，尖声高呼，却止不住自己越来越快的动作。\n「嘎——嘎——」\n它眼里流出伴着黑浆的蓝色泪水，除了你，无人目睹。\n"
  },
  Event_7630_Name = {
    Text = "融浆之泪"
  },
  Event_7631_ChoiceDesc1 = {
    Text = "【离开】提升 Arg1 点最大生命"
  },
  Event_7631_Desc = {
    Text = "「交给我来吧，」你在怪兽的脊骨上摸了摸，像是安抚一只发怒的小猫，「她一定会醒过来的，我们不会伤害她。」"
  },
  Event_7631_Name = {
    Text = "友情的呼唤"
  },
  Event_7632_ChoiceDesc1 = {
    Text = "【离开】提升 Arg1 点最大生命，感染「(Skill.Arg2)」以及「(Skill.Arg3)」"
  },
  Event_7632_Desc = {
    Text = "「醒一醒，莉莉，库姆也希望你早点醒过来——」"
  },
  Event_7632_Name = {
    Text = "友情的呼唤"
  },
  Event_7633_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_7633_Desc = {
    Text = "已是无用之物。"
  },
  Event_7633_Name = {
    Text = "无声电报"
  },
  Event_79429_ChoiceDesc1 = {
    Text = "选择一名唤醒体，通过生命仪式将其转化为「虫族」。「虫族」的指令卡算力消耗-1，但打出后消耗。"
  },
  Event_79429_Desc = {
    Text = "「认知自我的过程中，总是伴随着痛苦，蜕变和新生也是如此。」\n她温柔地笑着，怜爱地抚摸你的面庞。\n「不用害怕，我就在这里陪着你，所以敞开你的灵与一切，接受它们。」\n「乖孩子，我等着你的新生，等着你……成为我们的一员。」"
  },
  Event_79429_Name = {
    Text = "生命的蜕变"
  },
  Event_80463_ChoiceDesc1 = {
    Text = "【离开】获得白银造物3选1，感染「(Skill.Arg1)」"
  },
  Event_80463_Desc = {
    Text = "你选定道路，拉着小威廉拼命狂奔。\n所幸，你的选择是正确的。\n那些精神污染，那些一模一样的克莱门汀，终于被你甩脱。\n当然，你付出了一些代价。"
  },
  Event_80463_Name = {
    Text = "「克莱门汀」们"
  },
  Event_80464_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80464_Desc = {
    Text = "一段超出认知的记忆被灌输进你的大脑，直接将你的理智击溃。\n在那犹如超速快进的画面里，你只记住了一个场景：三角形的神殿\n那是@2虫族为了伟大痴愚的@4而建的伟业。"
  },
  Event_80464_Name = {
    Text = "深度记忆"
  },
  Event_80465_ChoiceDesc1 = {
    Text = "【离开】选择觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_80465_Desc = {
    Text = "你选定道路，拉着小威廉拼命狂奔。\n所幸，你的选择是正确的。\n那些精神污染，那些一模一样的克莱门汀，终于被你甩脱。\n当然，你付出了一些代价。"
  },
  Event_80465_Name = {
    Text = "「克莱门汀」们"
  },
  Event_80466_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80466_Desc = {
    Text = "「咔哒。咔哒。咔哒」\n「工作」终于完成了，然而除了「工作」本身，你又得到了什么？"
  },
  Event_80466_Name = {
    Text = "无尽的折磨"
  },
  Event_80467_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_80467_Desc = {
    Text = "「很高兴听到你的真心回答。」\n「期待我们的，下次会面。」"
  },
  Event_80467_Name = {
    Text = "迷梦中的呼唤"
  },
  Event_80468_ChoiceDesc1 = {
    Text = "【离开】获得25黑印"
  },
  Event_80468_Desc = {
    Text = "「哎呀，真是个不诚实的孩子。」\n「不过没关系，下次，我会让你说出真心话的。」\n「所有的，呕自内心和灵魂的，真话。」"
  },
  Event_80468_Name = {
    Text = "迷梦中的呼唤"
  },
  Event_80469_ChoiceDesc1 = {
    Text = "【开始「工作」】删除1张指令卡，获得Arg1黑印"
  },
  Event_80469_ChoiceDesc2 = {
    Text = "【后退远离】"
  },
  Event_80469_Desc = {
    Text = "「咔哒。」\n打字机的声音响起，在「工作」完成前，你永远是它的奴隶。"
  },
  Event_80469_Name = {
    Text = "无尽的折磨"
  },
  Event_80470_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80470_Desc = {
    Text = "「真是可惜，你的谨慎让你错失了知道真相的唯一机会。」\n它叹息着，无声溃散。"
  },
  Event_80470_Name = {
    Text = "深度记忆"
  },
  Event_80471_ChoiceDesc1 = {
    Text = "【全力进攻】"
  },
  Event_80471_ChoiceDesc2 = {
    Text = "【且战且退】"
  },
  Event_80471_Desc = {
    Text = "意料之外的身影出现在你面前，是克莱门汀。\n「不必惊讶，我只是想要做一个特殊的测试。」\n「至于测试什么，是秘密。」克莱门汀微笑着，「对于你来说，测试的唯一内容——」\n「就是活下去。」"
  },
  Event_80471_Name = {
    Text = "特殊测试"
  },
  Event_80472_ChoiceDesc1 = {
    Text = "【回忆过去】"
  },
  Event_80472_ChoiceDesc2 = {
    Text = "【拔掉虫鳞】"
  },
  Event_80472_Desc = {
    Text = "「请你相信，我没有恶意，我只是想要帮助你。」\n克莱门汀追赶着你，大声呼喊。\n她的声音听起来无比真诚，然而你已经无法再相信什么。\n你的道德已被「具身认知理论」击穿，理智也即将崩溃。\n你必须、必须做些什么，抵抗血肉中生长的虫鳞，抵抗逐渐渗入灵魂的疯狂与绝望。"
  },
  Event_80472_Name = {
    Text = "挣扎的灵魂"
  },
  Event_80473_ChoiceDesc1 = {
    Text = "【离开】删除2张卡牌"
  },
  Event_80473_Desc = {
    Text = "「想要保留力量应对最后的决战吗？」\n「很聪明的选择。但是人在获得同时，其实也在失去。」\n「因为在这个燃烧的残酷世界，生存本身，就需要付出代价。」"
  },
  Event_80473_Name = {
    Text = "特殊测试"
  },
  Event_80474_ChoiceDesc1 = {
    Text = "【无视它】获得3选1刻印"
  },
  Event_80474_ChoiceDesc2 = {
    Text = "【碰触它】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80474_Desc = {
    Text = "类似孢子的奇怪东西引起了你的注意。\n它犹如血肉组成的纤细水母，又似大脑深处寄存着信号的神经纤维。\n「来碰触我吧。」它无声诱惑着你，「我会，向你展示一段残酷的记忆。」"
  },
  Event_80474_Name = {
    Text = "深度记忆"
  },
  Event_80475_ChoiceDesc1 = {
    Text = "【离开】获得3选1刻印"
  },
  Event_80475_Desc = {
    Text = "「拉蒙娜、朵尔、萝坦、奥吉尔……」\n你神经质地不断重复呢喃着这些名字。\n你崩溃的理智已经无法再想起他们的模样，但这姓名代表的存在，依旧能够温暖你的心扉与灵魂。\n他们存在过，他们欢笑过，他们……是你此刻维持住人性的底线与锚点。"
  },
  Event_80475_Name = {
    Text = "挣扎的灵魂"
  },
  Event_80476_ChoiceDesc1 = {
    Text = "【离开】获得3选1白银造物，感染「(Skill.Arg1)」"
  },
  Event_80476_Desc = {
    Text = "「啊啊啊啊——」\n你张开嘴，高喊出声，声音与其说是嘶喊，不如说是在嘶鸣。\n那被拔掉的虫鳞又重新生长，而崩溃的理智，一去不回。"
  },
  Event_80476_Name = {
    Text = "挣扎的灵魂"
  },
  Event_80477_ChoiceDesc1 = {
    Text = "【离开】获得造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80477_Desc = {
    Text = "你没有任何隐瞒，全力以赴。这幅姿态显然愉悦了克莱门汀。\n「真是个好孩子」。\n「这样的话，就稍微奖励你一下吧。当然，是有代价的。」\n「在这个燃烧的残酷世界，生存本身，就需要付出代价。」"
  },
  Event_80477_Name = {
    Text = "特殊测试"
  },
  Event_80478_ChoiceDesc1 = {
    Text = "【开始「工作」】删除1张指令卡，获得Arg1黑印"
  },
  Event_80478_ChoiceDesc2 = {
    Text = "【后退远离】"
  },
  Event_80478_Desc = {
    Text = "「咔哒。咔哒。」\n打字机的声音响起，在「工作」进行时，你只是完成「工作」的工具。"
  },
  Event_80478_Name = {
    Text = "无尽的折磨"
  },
  Event_80479_ChoiceDesc1 = {
    Text = "【向左跑】"
  },
  Event_80479_ChoiceDesc2 = {
    Text = "【向右跑】"
  },
  Event_80479_Desc = {
    Text = "熟悉的身影紧紧追随在你身后，不是一个两个，而是数十数百个。\n狭小的走廊难以承载如此多数量的「克莱门汀」，因此，有「克莱门汀」被推搡在地，有「克莱门汀」被踩踏成泥。\n但她们统一呼唤着你，重复着那句让你陷入精神污染的语句。\n「为什么要逃跑？我只是想给你做一场心理咨询而已。」\n而你，于疗养院的廊道狂奔，面临岔路的抉择。"
  },
  Event_80479_Name = {
    Text = "「克莱门汀」们"
  },
  Event_80480_ChoiceDesc1 = {
    Text = "【开始「工作」】删除1张指令卡，获得Arg1黑印"
  },
  Event_80480_ChoiceDesc2 = {
    Text = "【后退远离】"
  },
  Event_80480_Desc = {
    Text = "「修改！工作！不要停下！」\n无数嗡鸣回响在你耳边，令你不由自主靠近那台突然出现的打字机。\n「怎么办，怎么办，明明从早敲到晚，但工作却怎么也做不完。」\n「修改！修改！修改方案、提出需求、完成工作！」\n「工作！工作！！工作！！！」\n嗡鸣着的灵魂撞向不停敲击的打字机，终于，那打字机终于停下了。\n然而片刻后，那打字机又再次运转\n「修改！工作！不要停下！」\n因为工作，永无尽头。"
  },
  Event_80480_Name = {
    Text = "无尽的折磨"
  },
  Event_80481_ChoiceDesc1 = {
    Text = "【如实回答】"
  },
  Event_80481_ChoiceDesc2 = {
    Text = "【拒绝回答】"
  },
  Event_80481_Desc = {
    Text = "刹那间，面前的景色变得迷蒙虚幻。\n你以为是房间在扭曲变换，但后来，你才明白，那是你的视神经遭到了入侵。\n「我们又见面了。」\n模糊的视线里，克莱门汀笑得温柔。\n「虽然比想象中更早见面，但我仍旧很开心，不知%player%你是否也有这种感觉？」"
  },
  Event_80481_Name = {
    Text = "迷梦中的呼唤"
  },
  Event_80595_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80595_Desc = {
    Text = "\n面对你的驱赶，蝴蝶无动于衷。\n它执着地追逐着你的手掌，在你的手心里失去生息。\n「啊，好温暖……」\n这是它最后的心声。"
  },
  Event_80595_Name = {
    Text = "蝴蝶的梦想"
  },
  Event_80596_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80596_Desc = {
    Text = "「我想鲜花一直盛开，我想微笑永恒长存。」\n「我想所有患上融蚀的人都能痊愈平安，我想这个世界回复往昔，不再燃烧。」\n「我想……」\n小小的蝴蝶扇动着翅膀，在你的手心里失去生息。\n至少，有人聆听过它的声音。"
  },
  Event_80596_Name = {
    Text = "蝴蝶的梦想"
  },
  Event_80597_ChoiceDesc1 = {
    Text = "【驱赶蝴蝶】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80597_ChoiceDesc2 = {
    Text = "【聆听心愿】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80597_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_80597_Desc = {
    Text = "小小的蝴蝶，也有许多梦想。\n这些梦想散落在花海里、病房里、还有充满许多血肉的@2祭坛里。\n而今，它终于等到了羁绊之人，不知你是否愿意聆听它小小的、小小的心愿。"
  },
  Event_80597_Name = {
    Text = "蝴蝶的梦想"
  },
  Event_80610_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80610_Desc = {
    Text = "「理性吗？有趣的回答。」\n「但愿你不会为自己的选择后悔。」"
  },
  Event_80610_Name = {
    Text = "人性的代价"
  },
  Event_80612_ChoiceDesc1 = {
    Text = "【投喂他们】获得白银造物「(RelicConfig.Arg1)」，选择感染1次症状"
  },
  Event_80612_ChoiceDesc2 = {
    Text = "【不做理会】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80612_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_80612_Desc = {
    Text = "居住者来来去去，鼠群却长久绵延。\n和人类相比，它们才是这座古堡的「原住民」\n但它们对于人类的进驻没有异议。\n因为那些香软的、白嫩的丑东西，会投喂它们同样香软的、白嫩的丑东西。\n「而你，丑东西，属于哪一种？」"
  },
  Event_80612_Name = {
    Text = "古堡的秘密"
  },
  Event_80613_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80613_Desc = {
    Text = "\n黑暗中传来温柔的笑声。\n「我等着你，来见我。」\n「勇敢的小虫子。」"
  },
  Event_80613_Name = {
    Text = "「她」的窥视"
  },
  Event_80614_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80614_Desc = {
    Text = "「闭嘴闭嘴，难听死了。」\n黑猫人性化地捂着耳朵。\n「人类，你的猫语真得很差，说得什么乱七八糟的话！」\n虽然嘴上这么说着，但黑猫的神色却平和下来。\n「看在你喵喵叫取悦我的份上，送你个礼物吧。」\n「至于礼物的内容，取决于你的运气。」"
  },
  Event_80614_Name = {
    Text = " 尼格尔曼"
  },
  Event_80615_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80615_Desc = {
    Text = "\n「母亲，在失去朋友、丈夫、儿子后，我又永远的失去了戴安娜，我的小女儿。」\n「当她在我面前化为灰烬时，我的大脑一片空白……」后续的字迹已无法看清。\n你只能转而阅读下一行字。\n我已经下定了决心。如果再见到我，请不要责备我，我只是……太想你们了。"
  },
  Event_80615_Name = {
    Text = "消逝的思念"
  },
  Event_80616_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80616_Desc = {
    Text = "你的驱赶产生了效果。少数看不清形貌的身躯扭曲着逃离，大部分仍留在原地。\n他们不再嬉笑，不再吟诵，反而嚎啕大哭。\n孩子的哭声骤响在你耳边，只重复着一句话。\n「打死怪胎！」"
  },
  Event_80616_Name = {
    Text = "「他」的童年"
  },
  Event_80617_ChoiceDesc1 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_80617_ChoiceDesc2 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_80617_ChoiceDesc3 = {
    Text = "【离开】感染「(Skill.Arg1)」"
  },
  Event_80617_Desc = {
    Text = "你的投喂取悦了鼠群。\n那庞大的鼠群涌动着，赠送你一件粗陋包装的礼物。\n你看不出那礼物的模样，只看到浸染在包装上的大量鲜血。"
  },
  Event_80617_Name = {
    Text = "古堡的秘密"
  },
  Event_80618_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80618_Desc = {
    Text = "「……」\n「…………」\n「………………」\n黑影沉默着，他想要哭泣，却已经失去流泪的能力。\n最终，他只是深深地叹了口气。\n「朋友，但愿你能守护住自己最珍贵的东西。」"
  },
  Event_80618_Name = {Text = "空心人"},
  Event_80619_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80619_Desc = {
    Text = "你的呵斥毫无作用，反而令他们更加狂热欢欣。\n嬉笑吟诵声越发高昂，唱着另一个童谣。\n「小威廉，住古堡，食人鼠，墙中跑。\n待到人牲献祭时，所有人都被啃倒。」"
  },
  Event_80619_Name = {
    Text = "「他」的童年"
  },
  Event_80620_ChoiceDesc1 = {
    Text = "【回避目光】随机觉醒1名唤醒体"
  },
  Event_80620_ChoiceDesc2 = {
    Text = "【直视目光】选择觉醒1名唤醒体，并降低其觉醒卡算力消耗2点。感染「(Skill.Arg1)」"
  },
  Event_80620_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_80620_Desc = {
    Text = "疗养院的一切，都在她的掌控与窥视之下。当然，你也是。\n但她愿意为你睁一只眼闭一只眼。\n毕竟，游戏要有来有往，才更有趣。"
  },
  Event_80620_Name = {
    Text = "「她」的窥视"
  },
  Event_80621_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80621_Desc = {
    Text = "你将信封放回原处，准备离开，却忽然听到迷离的低喃。\n「在我的请求下，克莱门汀医生终于松口了。\n她向我描述的那广袤的宇宙、神秘的宇宙里，一定有着能够救回你们的办法。\n我已经做好了「新生」的准备，无论要漂流多少光年，我都渴望再见你们一面。」"
  },
  Event_80621_Name = {
    Text = "消逝的思念"
  },
  Event_80622_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80622_Desc = {
    Text = "克莱门汀医生救下了我。\n她真的是一个非常、非常好的人，愿意倾听我的声音。\n我真的很想说一些开心的事、快乐的事，然而此刻的我，除了痛苦与绝望，别无他物。\n恐怕，我要辜负医生的心意了。\n在失去你们后，生活对于我来说，只有荒芜。"
  },
  Event_80622_Name = {
    Text = "消逝的思念"
  },
  Event_80623_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80623_Desc = {
    Text = "「你、你……」\n「哼，手法还不赖嘛，这次就算你过关。下次可没那么容易！」\n黑猫一跃，轻巧地跑远了。"
  },
  Event_80623_Name = {
    Text = " 尼格尔曼"
  },
  Event_80624_ChoiceDesc1 = {
    Text = "【攻击黑猫】50%概率获得125黑印，50%概率感染「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc2 = {
    Text = "【学猫叫】75%概率获得100黑印，25%概率感染「(Skill.Arg2)」"
  },
  Event_80624_ChoiceDesc3 = {
    Text = "【尝试撸猫】获得50黑印"
  },
  Event_80624_Desc = {
    Text = "「嘿！你，禁止向前。」\n黑猫们突然跳出，阻拦你继续前行。\n它们优雅地舔着爪子，神态桀骜又骄傲。\n「前方充满了危险，可不是你这种弱小的人类可以探索的。」\n你表达了必须向前的决心，这时领头黑猫的竖瞳转了转，展露玩弄猎物的残酷天性。「那就向我们展示你的决心吧。」"
  },
  Event_80624_Name = {
    Text = " 尼格尔曼"
  },
  Event_80625_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80625_Desc = {
    Text = "\n你的无视激怒了鼠群，它们嘶叫着涌向了你，而你，早在鼠群涌动前，就已跑远。"
  },
  Event_80625_Name = {
    Text = "古堡的秘密"
  },
  Event_80626_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80626_Desc = {
    Text = "「啊，就是这样，折断我的翅膀吧。」\n「时间、健康、尊严、生命，他们已经从我这里掠走了太多。」\n「这最后的梦想，当然也不属于我。」\n「因为，我只是被关起来失去自由的鸟。」"
  },
  Event_80626_Name = {Text = "空心人"},
  Event_80627_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80627_Desc = {
    Text = "「感性吗？有趣的回答。」\n「但愿你不会为自己的选择后悔。」"
  },
  Event_80627_Name = {
    Text = "人性的代价"
  },
  Event_80628_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80628_Desc = {
    Text = "「我接受你的祈求。」\n嗡鸣声凑近，通过耳道缓缓钻入你的大脑。\n你的大脑在战栗，而在这战栗中，你聆听到了宇宙的「声音」。\n「与我，链接。」"
  },
  Event_80628_Name = {
    Text = "黑暗救赎"
  },
  Event_80629_ChoiceDesc1 = {
    Text = "【祈求】随机觉醒1名唤醒体，感染「(Skill.Arg1)」"
  },
  Event_80629_ChoiceDesc2 = {
    Text = "【拒绝】获得3选1刻印"
  },
  Event_80629_Desc = {
    Text = "「不该是这样的，不该是这样的。」\n「我明明、明明应该脱离人类这种低级的生命，进化为更高级的……」\n黑暗中，传来痛苦的抽泣。\n这些抽泣汇聚、涌动，形成巨大的嗡鸣。\n「这个燃烧的世界，如同永不餍足的黑洞，吞噬着每一个人，所以——」\n「向我祈求吧，无尽的宇宙会给予你救赎。」"
  },
  Event_80629_Name = {
    Text = "黑暗救赎"
  },
  Event_80630_ChoiceDesc1 = {
    Text = "【打开信封】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_80630_ChoiceDesc2 = {
    Text = "【阅读】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80630_ChoiceDesc3 = {
    Text = "【放回原处】获得50黑印"
  },
  Event_80630_Desc = {
    Text = "无人关注的角落里，遗落了一封信件。\n信件上的许多字迹已经无法辨认，但唯有一个词。力透纸背。\n那个词是「母亲」。"
  },
  Event_80630_Name = {
    Text = "消逝的思念"
  },
  Event_80631_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80631_Desc = {
    Text = "「呵，渺小的人类，你做出了错误的选择。」\n黑猫们冷酷地望着你，骤然突袭。\n「你必须付出代价——当然，我们也尊敬强者。」"
  },
  Event_80631_Name = {
    Text = " 尼格尔曼"
  },
  Event_80632_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80632_Desc = {
    Text = "\n黑暗中传来温柔的笑声。\n「我等着你，来见我。」\n「可爱的小虫子。」"
  },
  Event_80632_Name = {
    Text = "「她」的窥视"
  },
  Event_80633_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80633_Desc = {
    Text = "在你的攻击下，这群扭曲古怪的身影终于逃离了。\n四周静谧，唯有你的心跳在无声哭泣。\n原来，这就是「他」的童年。"
  },
  Event_80633_Name = {
    Text = "「他」的童年"
  },
  Event_80635_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80635_Desc = {
    Text = "「啊，小小的文字陷阱被窥破了。」\n「这是奖励。因为啊……」\n「不是每一次的选择，都必须选择。」"
  },
  Event_80635_Name = {
    Text = "人性的代价"
  },
  Event_80636_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80636_Desc = {
    Text = "「@3忤逆者」\n嗡鸣声渐渐虚弱，直至消失。只留下最后的言语。\n「维持人性，可无法在这残酷的世界生存。」"
  },
  Event_80636_Name = {
    Text = "黑暗救赎"
  },
  Event_80637_ChoiceDesc1 = {
    Text = "【选择拒绝】删除1张指令卡，获得Arg1黑印"
  },
  Event_80637_ChoiceDesc2 = {
    Text = "【选择遵从】复制1张指令卡，感染「(Skill.Arg1)」"
  },
  Event_80637_ChoiceDesc3 = {
    Text = "【选择拥抱】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80637_Desc = {
    Text = "「我是一只笼中鸟，被关在充满许多房间的院子里。」\n黑暗中徘徊着模糊的人影，那是逝去者留下的执念。\n「他们说，那是疯人院，可我却知道，那是人类的特殊囚笼，关押着不愿遵从社会规则的自由鸟。」\n「可是鸟儿如果不能飞翔，还能被称为鸟吗？」\n执念们向你靠拢，祈求着救赎。\n「请折断我的翅膀，我已厌倦了飞翔。」"
  },
  Event_80637_Name = {Text = "空心人"},
  Event_80638_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_80638_Desc = {
    Text = "「……」\n「…………」\n「………………」\n黑影忽然颤动着，消融进了你的身体。\n「朋友，前进吧，为了保护自己最珍贵的东西。」\n「虽然我们已经逝去，但仍愿意为你梦想，献上最后的祝福。」"
  },
  Event_80638_Name = {Text = "空心人"},
  Event_80639_ChoiceDesc1 = {
    Text = "【选择感性】回复 Arg1 点生命"
  },
  Event_80639_ChoiceDesc2 = {
    Text = "【维持理性】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_80639_ChoiceDesc3 = {
    Text = "【拒绝选择】获得25黑印"
  },
  Event_80639_Desc = {
    Text = "「选择吧，选择。」\n狂奔的黑暗中，传来了无数的呢喃。\n这声音温柔催眠，似乎带着无限的魔力，令你产生某种癫狂的幻觉。\n你的大脑陷入狂悖，蠕动着脱离身体，而心脏则似乎生发了某种意识，向你惊叫着呼唤。\n「选择吧，选择。」\n「维持理性还是感性，你必须做出选择。」"
  },
  Event_80639_Name = {
    Text = "人性的代价"
  },
  Event_80641_ChoiceDesc1 = {
    Text = "【呵斥「他们」】感染「(Skill.Arg1)」，获得诅咒造物「(RelicConfig.Arg2)」"
  },
  Event_80641_ChoiceDesc2 = {
    Text = "【驱赶「他们」】感染两次「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」以及「(RelicConfig.Arg3)」"
  },
  Event_80641_ChoiceDesc3 = {
    Text = "【攻击「他们」】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_80641_Desc = {
    Text = "「小威廉，是怪胎，睡坟堆，没人爱。不要和他有往来，小心被他暗中害。」\n看不清形貌的身躯扭曲着，声音却如幼童。\n他们嬉笑着、吟诵着，以一种轻蔑又热切的眼神望着你。\n带着恶意。"
  },
  Event_80641_Name = {
    Text = "「他」的童年"
  },
  Event_90571_ChoiceDesc1 = {
    Text = "【享用它】将 1 张「祭灵夜特调」置入牌库。"
  },
  Event_90571_Desc = {
    Text = "华丽的餐桌，热烈的舞池，精致的餐具，馥郁的尸体……\n噢，我知道你已经急不可耐了，但请再等等，亲爱的客人。\n这杯由宴会主人特别调制的饮品，是只属于尊贵客人的赠礼。\n握住它。啜饮它。在它的余味里，尽情享受这场欢愉吧！"
  },
  Event_90571_Name = {
    Text = "宴前仪礼"
  },
  Event_91460_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91460_Desc = {
    Text = "你无从抵抗，只能任由声音穿透。\n尖刻的啼叫剖开了你的大脑，一些被遗忘的恐惧流淌而出，你感受到它的饥饿。\n可怕的食人生物……"
  },
  Event_91460_Name = {
    Text = "无声告白"
  },
  Event_91461_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91461_Desc = {
    Text = "你不再克制，让那份灼热彻底释放，所有未说出的言语从你的头颅中不断迸发。\n你感受到奇妙的灵感，沉醉于皮克曼的才华。"
  },
  Event_91461_Name = {
    Text = "休眠火山"
  },
  Event_91462_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91462_Desc = {
    Text = "火舌缠上墨渍，留下一片血迹斑斑。\n那一刻，你在梦境和现实的边缘坠落。你看到自己变成了一个小女孩，牵起杜勒赛因的手与之共舞。\n当你醒来再次望向杜勒赛因之时，沉重的悲伤席卷了你的大脑。"
  },
  Event_91462_Name = {
    Text = "梦的启示"
  },
  Event_91463_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91463_Desc = {
    Text = "你冲上去，火焰隐没于你的皮肤。至于那幅画，任谁看也不过是一幅平平无奇的肖像画。\n此后的梦中，你总会看到燃烧的自己，炙烤得恰到好处，然后在某天端上你自己的餐桌。"
  },
  Event_91463_Name = {
    Text = "燃烧肖像"
  },
  Event_91464_ChoiceDesc1 = {
    Text = "【聆听】获得30黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_91464_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_91464_Desc = {
    Text = "在无声的嘈杂中，你逐渐明白了乌鸦的言语……"
  },
  Event_91464_Name = {
    Text = "无声告白"
  },
  Event_91465_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91465_Desc = {
    Text = "你捡起石子，惊醒那些专注啃噬的鼠影。\n它们贪婪地与你对视。\n你闻到它们身上潮湿的污秽气味，仿佛是某种预兆。"
  },
  Event_91465_Name = {
    Text = "流放王国"
  },
  Event_91466_ChoiceDesc1 = {
    Text = "【聆听】获得25黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_91466_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_91466_Desc = {
    Text = "它在欢迎。欢迎谁？\n当然是你！\n也许它把你视作明天的美餐。"
  },
  Event_91466_Name = {
    Text = "无声告白"
  },
  Event_91467_ChoiceDesc1 = {
    Text = "【割开手掌】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91467_ChoiceDesc2 = {
    Text = "【接受生长】获得白银造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91467_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_91467_Desc = {
    Text = "那只蝴蝶并非飞来，而是从你的掌心慢慢生长。\n你一开始以为只是汗水，却在指缝间看见黑色液体如血管反流般悄然渗出，凝结成冰冷而脉动的翅膀。\n每一次翕动，便在你的血液中激起涟漪。"
  },
  Event_91467_Name = {
    Text = "寄生上流"
  },
  Event_91468_ChoiceDesc1 = {
    Text = "【解救肖像】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91468_ChoiceDesc2 = {
    Text = "【接受空白】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91468_ChoiceDesc3 = {
    Text = "【离开】获得25黑印"
  },
  Event_91468_Desc = {
    Text = "你站在皮克曼的赠礼面前。\n那是一幅肖像画，由鲜血绘就，漆黑的火焰安静地燃烧着。\n透过画中人空洞的眼眶，你看到——\n你的记忆正翻涌燃烧，拉长、扭曲、发光，仿佛某种无形之火正舔舐你脑中的回廊。恍惚间你听见一道人声。\n「该下锅了，这火候正好。」\n这正是你自己绘出的记忆之景，你在火焰中挣扎变形。"
  },
  Event_91468_Name = {
    Text = "燃烧肖像"
  },
  Event_91469_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91469_Desc = {
    Text = "你拒绝接听，静静地看着它震颤至停歇。\n这么多年来，你早已学会了与疯狂对抗。"
  },
  Event_91469_Name = {
    Text = "未接来电"
  },
  Event_91470_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91470_Desc = {
    Text = "你后退一步，任由画布在火焰中燃烧。\n你看到自己被火烤出诱人的焦黄，油脂泛起发出噼啪的脆响，仿佛能够透过画布闻见肉的香气。\n杜勒赛因感受到的，就是这种诱惑吗？"
  },
  Event_91470_Name = {
    Text = "燃烧肖像"
  },
  Event_91471_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91471_Desc = {
    Text = "怀着一种近乎亵渎的好奇，亦或是对抗未知的绝望勇气，你在往日的幻影中找寻启示。\n你看到一位女孩和身旁面目模糊的高大男人共舞，莫名的快乐充盈着你的心脏。"
  },
  Event_91471_Name = {
    Text = "往日之影"
  },
  Event_91472_ChoiceDesc1 = {
    Text = "【终止记录】删除2张卡牌"
  },
  Event_91472_ChoiceDesc2 = {
    Text = "【继续书写】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91472_ChoiceDesc3 = {
    Text = "【离开】获得 Arg1 黑印"
  },
  Event_91472_Desc = {
    Text = "你总算是从食尸鬼的集市上暂时解脱，寻得一处安静的角落如往常一样开始记录。\n打字机突然狂暴地震动，按键自行起落，黑色的粘液从缝隙中喷涌而出，溅湿了你指尖的理智。\n你看到纸张之上渐渐浮现呼之欲出的蝶影……"
  },
  Event_91472_Name = {
    Text = "蝶影重重"
  },
  Event_91473_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91473_Desc = {
    Text = "奇怪的是，明明是未曾学习的言语，但你仿佛明白了其中的含义。\n诗句中写满了对亲人的思念，这份思念跨越生与死，在你的梦中得以传递。\n你隐约地在诗的末尾辨认出字迹——\n是「赛琳涅」。"
  },
  Event_91473_Name = {
    Text = "梦的启示"
  },
  Event_91474_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91474_Desc = {
    Text = "你忍痛割开手心的皮肤，用火焰灼烧那片新生的肉翅。\n黑液蒸腾，蝴蝶破碎。\n一切变得干净无痕，但你却总觉得掌心传来微弱的振翅之声，如同某个未能完全孵化的思想，仍在你的血管中缓缓呼吸。\n杜勒赛因对此不置可否，只是要走了你留下的鲜血。"
  },
  Event_91474_Name = {
    Text = "寄生上流"
  },
  Event_91475_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91475_Desc = {
    Text = "你知道狂热的灵感总会造成灾厄，于是你用理性将一切封存。"
  },
  Event_91475_Name = {
    Text = "休眠火山"
  },
  Event_91476_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91476_Desc = {
    Text = "你逼视那只眼，试图理解它传递的信息。\n虽然你早已身经百战，但是此次面对戈利亚……恐惧扼住了你的心脏。\n「近乎正常，就是灾厄发生前最沉默的形状。」"
  },
  Event_91476_Name = {
    Text = "近乎正常"
  },
  Event_91477_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91477_Desc = {
    Text = "你闭上眼，转身走入旷野。\n你能察觉潜藏的渴望与预兆，但永远无法亲手止息。\n你看向周围无字的墓碑，或许这就是你的结局。"
  },
  Event_91477_Name = {
    Text = "群鸦盛宴"
  },
  Event_91478_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91478_Desc = {
    Text = "你缓缓抬起头，那一刻，光刺穿瞳孔，炽热在脑中开出空白的花。\n葬骸城的星星与别处的并无不同，而看似拥有永恒的食尸鬼也只能生存在群星之下，不得自由。"
  },
  Event_91478_Name = {
    Text = "群星之夜"
  },
  Event_91479_ChoiceDesc1 = {
    Text = "【投于炉火】删除1张卡牌"
  },
  Event_91479_ChoiceDesc2 = {
    Text = "【尝试解读】获得「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91479_Desc = {
    Text = "你的意识在无边的黑雾中浮沉，穿梭于无数生者与亡者的精神图景。\n在梦中，神奇的打字机中吐出一段陌生的诗句。这又是谁的故事？\n它刻印在未知来历的纸上，扭曲的字迹仿佛是清醒的醉酒者手写而成。\n你被梦中的无法言喻的冲动驱使，拿起那张纸，油墨在炉火的光影之间跳跃。"
  },
  Event_91479_Name = {
    Text = "梦的启示"
  },
  Event_91480_ChoiceDesc1 = {
    Text = "【加入】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc2 = {
    Text = "【驱赶】感染「(Skill.Arg1)」，随机1张卡牌获得刻印：「(EnchantConfig.Arg2)」"
  },
  Event_91480_ChoiceDesc3 = {
    Text = "【漠视】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91480_Desc = {
    Text = "你听到远处若隐若现的骨螺号角声。\n鼠群循声从黑泥中涌现，啃噬着干枯河床上躺着的无名尸体。\n它们围成一个圆，圆心是那具已然空洞的遗体，圆周则是一个以遗忘为法律的新王国。\n而你，正站在这个王国的入口。"
  },
  Event_91480_Name = {
    Text = "流放王国"
  },
  Event_91481_ChoiceDesc1 = {
    Text = "【抬头注视】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_91481_ChoiceDesc2 = {
    Text = "【低头离开】获得75黑印，感染「(Skill.Arg2)」"
  },
  Event_91481_Desc = {
    Text = "群鸦在天空中盘旋，像一把迟疑的锯，反复切割天空的脊骨。\n它们围绕着你低飞，仿佛预见了你的死亡，耐心地等待盛宴的开始。"
  },
  Event_91481_Name = {
    Text = "群鸦盛宴"
  },
  Event_91482_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91482_Desc = {
    Text = "你让它继续书写，用你的脉搏、你的痛觉、你的往昔与猜想。\n蝴蝶冲破纸张的束缚，你的心灵随之放飞。\n你开始想象自己在游乐园的快乐。你没有告诉杜勒赛因的是，其实你非常喜欢游乐园，哪怕是尸体游乐园……\n应该……不会很猎奇吧？"
  },
  Event_91482_Name = {
    Text = "蝶影重重"
  },
  Event_91483_ChoiceDesc1 = {
    Text = "【重新观察】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91483_Desc = {
    Text = "往日清晰的晚餐变成了血肉模糊的盛宴，你回忆起灶台上的食材，腐烂的气味刺激着鼻腔。\n恐惧扼住了你的心脏，你不得不做出抉择。"
  },
  Event_91483_Name = {
    Text = "往日之影"
  },
  Event_91484_ChoiceDesc1 = {
    Text = "【无视铃声】获得3选1高级刻印"
  },
  Event_91484_ChoiceDesc2 = {
    Text = "【拿起听筒】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91484_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_91484_Desc = {
    Text = "它本不该响起——那只电话，蜷缩在画布背后。\n听筒的线缠绕在大块头机身上，如同生锈的脐带，似乎从你的脑中延伸。\n你仔细辨别震动的频率，诡异的声响犹如皮克曼的超现实艺术。"
  },
  Event_91484_Name = {
    Text = "未接来电"
  },
  Event_91485_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91485_Desc = {
    Text = "你捧起那颗冰冷的大脑，瞬间它化作流水从你的指缝无声地滑落。\n天平随即失衡，心脏如腐果般迅速塌陷、消融，化作一滩沉默的黑水。\n所有的饥饿消失了，你拥有了冷静、不悔与短暂的清明。"
  },
  Event_91485_Name = {
    Text = "饥饿游戏"
  },
  Event_91486_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91486_Desc = {
    Text = "没有声音，无人回应。或许只是一个恶作剧？\n就当你放下听筒时，某种沉重的感情倒流回你的体内。"
  },
  Event_91486_Name = {
    Text = "未接来电"
  },
  Event_91487_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91487_Desc = {
    Text = "乌鸦消失了。\n但是你看见自己站在另一个夜晚的镜中，凝视这只乌鸦。\n它仍在无声啸叫，仿佛等待你的回应。"
  },
  Event_91487_Name = {
    Text = "无声告白"
  },
  Event_91488_ChoiceDesc1 = {
    Text = "【重新观察】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91488_ChoiceDesc2 = {
    Text = "【放弃抵抗】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，还可以使用一次"
  },
  Event_91488_Desc = {
    Text = "你果断地移开目光，可是那些图像却如同幽影浮现在你的眼中……\n那是一支忧伤的双人舞。"
  },
  Event_91488_Name = {
    Text = "往日之影"
  },
  Event_91489_ChoiceDesc1 = {
    Text = "【享用】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91489_ChoiceDesc2 = {
    Text = "【婉拒】感染「(Skill.Arg1)」，重新刻印，最多进行2次"
  },
  Event_91489_Desc = {
    Text = "那是杜勒赛因为辛苦调查的你们精心准备的。\n不加香料却没有腐味，就如杜勒赛因所说，这是最好的食材。\n宴席为你而设，而大脑在盘中静默无言。\n「要尝尝吗？」"
  },
  Event_91489_Name = {
    Text = "赏味佳肴"
  },
  Event_91490_ChoiceDesc1 = {
    Text = "【聆听】获得40黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_91490_ChoiceDesc2 = {
    Text = "【无视】获得25黑印，离开"
  },
  Event_91490_Desc = {
    Text = "那是一只乌鸦。\n它站在骷髅灯盏之上，张嘴，却没有发出任何声音。"
  },
  Event_91490_Name = {
    Text = "无声告白"
  },
  Event_91491_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91491_Desc = {
    Text = "你缓缓将手伸向那颗尚热的心脏，它跃动着、收缩着，直到化作一股馨香的热气消散。\n天平剧烈一震，大脑跌落于无尽的黑暗。\n充盈的饱腹感取代了饥饿，你领悟了热烈、痛苦与真正的记忆。"
  },
  Event_91491_Name = {
    Text = "饥饿游戏"
  },
  Event_91492_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91492_Desc = {
    Text = "你仰起头，迎接那无声的旋转，像古老祭祀的朝圣者。\n它们欢快地享用你的血肉，你感到痛，却也清明。\n你看见了失落的自己，那些未能死去的部分，终于被带走了。\n当意识回归，你发现自己安然无恙。"
  },
  Event_91492_Name = {
    Text = "群鸦盛宴"
  },
  Event_91493_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91493_Desc = {
    Text = "你用记忆与情绪的水泥将锁孔封死，真理再也不能将你诱惑。\n看着你如临大敌的模样，杜勒赛因舔了舔嘴角。\n「还想尝尝吗？这可是为守密人阁下特制的脑叶马苏里拉。」"
  },
  Event_91493_Name = {Text = "启示录"},
  Event_91494_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91494_Desc = {
    Text = "其实你一直好奇食尸鬼的体验。\n「于是你走入鼠群，成为了它们的一员——」\n你不得不承认，蹈海者的到来让你的脑子变得不太清醒。"
  },
  Event_91494_Name = {
    Text = "流放王国"
  },
  Event_91495_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91495_Desc = {
    Text = "你不愿沾染腐败与混乱。\n你早已习惯，一切腐朽如同常态。"
  },
  Event_91495_Name = {
    Text = "流放王国"
  },
  Event_91496_ChoiceDesc1 = {
    Text = "【享用】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91496_ChoiceDesc2 = {
    Text = "【婉拒】感染「(Skill.Arg1)」，再次随机刻印"
  },
  Event_91496_Desc = {
    Text = "杜勒赛因优雅地帮你切了一块「大脑」。\n这甜美的滋味……\n这松软而绵密的口感……\n你很想要再尝一口。"
  },
  Event_91496_Name = {
    Text = "赏味佳肴"
  },
  Event_91497_ChoiceDesc1 = {
    Text = "【我在做梦】获得白银造物「(RelicConfig.Arg1)」"
  },
  Event_91497_ChoiceDesc2 = {
    Text = "【这不正常】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91497_Desc = {
    Text = "光滑的墓碑照出一只正在缓慢扭曲的眼睛。\n像是在承载某种肉眼无法描摹的图像，一段记忆不属于你，却已深植于你眼底的褶皱。\n你试图眨眼、用指腹擦拭，可那只眼睛不再属于你，它开始反射出万花筒般的景象。"
  },
  Event_91497_Name = {
    Text = "近乎正常"
  },
  Event_91498_ChoiceDesc1 = {
    Text = "【继续观察】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91498_ChoiceDesc2 = {
    Text = "【移开目光】感染「(Skill.Arg1)」，更换选项1中所获得的刻印，可以使用两次"
  },
  Event_91498_Desc = {
    Text = "在古堡潮湿的角落里，你发现了那盘胶卷。\n影像如同溺毙于时间之河的幻影，在缓慢的定格中凝固，时而膨胀成难以名状的巨物，时而坍缩成闪烁不定的星点。\n你沉浸其中，一阵晕眩提醒了你时间的流逝。"
  },
  Event_91498_Name = {
    Text = "往日之影"
  },
  Event_91499_ChoiceDesc1 = {
    Text = "【凝视群星】获得黄金造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91499_ChoiceDesc2 = {
    Text = "【闭上眼睛】随机觉醒2名唤醒体，感染两次「(Skill.Arg1)」"
  },
  Event_91499_ChoiceDesc3 = {
    Text = "【离开】获得50黑印"
  },
  Event_91499_Desc = {
    Text = "你站在空无一人的墓地，星星的存在让黑夜亮如明昼。\n那些漂浮在时间深海中的光球不曾言语，却在漫长如梦呓的旋转中，缓缓聚焦。\n它们注视着被遗忘的孤星。\n祂注视着你，注视一切死亡与永恒。"
  },
  Event_91499_Name = {
    Text = "群星之夜"
  },
  Event_91500_ChoiceDesc1 = {
    Text = "【聆听】获得20黑印，感染「(Skill.Arg2)」"
  },
  Event_91500_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_91500_Desc = {
    Text = "你与它对视。\n在一片漆黑中，你看到了贪婪的野火。"
  },
  Event_91500_Name = {
    Text = "无声告白"
  },
  Event_91501_ChoiceDesc1 = {
    Text = "【开启锁孔】获得诅咒造物「(RelicConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91501_ChoiceDesc2 = {
    Text = "【封闭锁孔】随机1张卡牌获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91501_Desc = {
    Text = "面对杜勒赛因递来的脑叶，你几番推拒，终究是抵不过智慧的诱惑。\n知识并非缓慢降临，而是骤然倾泻。\n大脑开始胀痛，思维像发酵的面包持续膨胀。当你终于倒下，痛觉如潮水退却，意识好像中空了一块，留下一个干净的、古老的锁孔。\n原来这就是知识的形状！你感受到前所未有的智慧。\n或许……你可以获得更多？"
  },
  Event_91501_Name = {Text = "启示录"},
  Event_91502_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91502_Desc = {
    Text = "你用意识残留的锋刃撬动那个锁孔。\n你不知钥匙为何物，只用执念作尝试。那一刻，你的思想燃烧殆尽，只留下某种非人之理在空洞的锁孔里低语。\n难道这就是启示？你兴奋地与杜勒赛因分享。\n「还想尝尝吗？这可是为守密人阁下特制的脑叶马苏里拉。」"
  },
  Event_91502_Name = {Text = "启示录"},
  Event_91503_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91503_Desc = {
    Text = "你既不引爆它，也不压抑它。\n在一种玄妙的旁观者境界中，你将那喷涌的思想视作天气变化的一部分，让它自行流向未知的结局。\n在血与肉的画作中，你领略了永恒的艺术。"
  },
  Event_91503_Name = {
    Text = "休眠火山"
  },
  Event_91504_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91504_Desc = {
    Text = "按键猛然停下，蝶影瞬息消散。\n是幻觉吗？你若有所失。\n或许该听杜勒赛因的话去记忆罐头商店买点脑叶了。\n「不对，我在想什么？」"
  },
  Event_91504_Name = {
    Text = "蝶影重重"
  },
  Event_91505_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91505_Desc = {
    Text = "你不再挣扎，任那翅膀与黑液穿透掌纹。\n你成了它的器皿，而它以你为壳，继续思考。\n蝴蝶越长越大，你终于承受不住重量。\n见此，杜勒赛因兴致勃勃地用餐刀切断了你与蝴蝶的连接。他跃跃欲试的眼神，分明是想要……\n你拒绝了他的申请。"
  },
  Event_91505_Name = {
    Text = "寄生上流"
  },
  Event_91506_ChoiceDesc1 = {
    Text = "【聆听】获得35黑印，感染「(Skill.Arg2)」，继续选择"
  },
  Event_91506_ChoiceDesc2 = {
    Text = "【无视】离开"
  },
  Event_91506_Desc = {
    Text = "你本以为它沉默，直到你的意识忽然倾斜，仿佛无数只乌鸦的头颅在你脑中啼叫。\n你跪倒在地，世界在你的眼中旋转。"
  },
  Event_91506_Name = {
    Text = "无声告白"
  },
  Event_91507_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91507_Desc = {
    Text = "你闭上眼，踏入那无尽、柔软的尘雾之中，星云拥抱你，而你失去了形状，一种比身体更稳固的存在于你的体内沉淀。\n那一夜，群星继续旋转，一如往日明亮。\n对于长生者而言，星空意味着什么呢？或许你该去问问杜勒赛因。"
  },
  Event_91507_Name = {
    Text = "群星之夜"
  },
  Event_91508_ChoiceDesc1 = {
    Text = "【享用】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91508_Desc = {
    Text = "原来是奶酪呀。\n你在庆幸的同时，又有几分遗憾。"
  },
  Event_91508_Name = {
    Text = "赏味佳肴"
  },
  Event_91509_ChoiceDesc1 = {
    Text = "【点燃】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」】"
  },
  Event_91509_ChoiceDesc2 = {
    Text = "【等待】感染「(Skill.Arg1)」，获得白银造物「(RelicConfig.Arg2)」"
  },
  Event_91509_ChoiceDesc3 = {
    Text = "【封存】获得25黑印"
  },
  Event_91509_Desc = {
    Text = "你凝视着皮克曼的画作，令人作呕的腐烂气息让你陷入眩晕。\n思绪从脑中缓慢升起，起初只是热气，后来是薄雾，再后来——"
  },
  Event_91509_Name = {
    Text = "休眠火山"
  },
  Event_91510_ChoiceDesc1 = {
    Text = "【触摸大脑】随机1张指令卡获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91510_ChoiceDesc2 = {
    Text = "【触摸心脏】提升 Arg1 点最大生命，感染「(Skill.Arg2)」"
  },
  Event_91510_Desc = {
    Text = "你走入那间无人低语的灰厅，一架天平在黑雾中若隐若现。\n左边，是一枚沉静如湖的大脑，银白色的沟壑闪着微光；右边，是一颗火红色的、蒸腾着热气的心脏。\n忽然之间，你闻到一阵香气，饥渴的欲望不断膨胀，理智被祂无边的黑暗挤压。\n你伸出了手。"
  },
  Event_91510_Name = {
    Text = "饥饿游戏"
  },
  Event_91511_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91511_Desc = {
    Text = "这一定是一场梦。你反复说服自己。\n在不知不觉间，你真的陷入了梦乡。\n也许是因为最近交流太多，你竟梦见了杜勒赛因——主动让杜勒赛因食用自己的血肉？什么恐怖故事？"
  },
  Event_91511_Name = {
    Text = "近乎正常"
  },
  Event_91660_ChoiceDesc1 = {
    Text = "【另辟蹊径】从3张指令卡中选择1张获得刻印：「(EnchantConfig.Arg1)」"
  },
  Event_91660_ChoiceDesc2 = {
    Text = "【任其存在】随机3张指令卡获得刻印：「(EnchantConfig.Arg1)」，感染「(Skill.Arg2)」"
  },
  Event_91660_Desc = {
    Text = "「驱使灵魂，你需要引领亡者走到尽头。」\n伴随着杜勒赛因的话语，你如有明悟。\n并不是知识，也不是记忆——那东西更像是一种重量，从你的眼眶摄入，像洪水一样灌入你的大脑。\n你的情绪似乎不再属于此时此地，它退开，显露出一处宇宙疏忽的缝隙。\n你所能感知的一切，就在那里停止，像走到了一条路的最末端。"
  },
  Event_91660_Name = {
    Text = "灵魂尽头"
  },
  Event_91661_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91661_Desc = {
    Text = "你让灵魂远走。\n在「自我」的边界，你仿佛听到了亡者的低语。\n但当你仔细聆听时，一切都消失了。"
  },
  Event_91661_Name = {
    Text = "灵魂尽头"
  },
  Event_91662_ChoiceDesc1 = {
    Text = "【离开】"
  },
  Event_91662_Desc = {
    Text = "你将自己的意识包裹起来，从而隔绝了未知的诱惑。\n你在灵魂的尽头迷失，只看到了自己。\n果然，身为活人的你无法拥有食尸鬼的能力。"
  },
  Event_91662_Name = {
    Text = "灵魂尽头"
  }
})
return Text_Event
