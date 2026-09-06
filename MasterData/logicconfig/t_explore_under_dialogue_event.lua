-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_explore_under_dialogue_event.lua

module("logicconfig.config.t_explore_under_dialogue_event", package.seeall)

local title = {
	content = 4,
	answerIcon = 7,
	dialogueId = 2,
	id = 3,
	isEnd = 11,
	continueHandler = 8,
	waitAnswer = 6,
	answerHandler = 9,
	dialoguePlanId = 1,
	tag = 5,
	extInfoHandler = 10
}
local dataList = {
	{
		1,
		1,
		1,
		"末炎：\r\n这家店的赤茸龙虾很不错，给你一个请我吃饭的机会，怎么样？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 1,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		1,
		2,
		"你：我的荣幸！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		1,
		3,
		"你：区区1000块，全款拿下！",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		1,
		1,
		4,
		"末炎：多谢~你的好意，我会记在心上的~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		1,
		5,
		"你：（翻了翻钱包）啊……今天没带够钱，抱歉",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		1,
		1,
		6,
		"末炎：没关系，那下次吧\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		1,
		7,
		"你：我没有钱…",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = -50
		},
		nil,
		false
	},
	{
		1,
		1,
		8,
		"末炎：\r\n哼，小气鬼！\r\n(好感度-50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		2,
		1,
		"混混：你跑不掉了，乖乖跟我们走吧，不然可别怪我们不客气！",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 1,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		2,
		2,
		"末炎：你是说，就凭你们，还想拦得住我？",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		1,
		2,
		3,
		"A、轮到我出手了！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1007,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		2,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		1,
		2,
		5,
		"末炎：干得不错，挺帅的嘛！\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		2,
		6,
		"你且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		1,
		2,
		7,
		"末炎：有点棘手，先撤！\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		2,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		1,
		2,
		9,
		"末炎：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		3,
		1,
		"你被一个牛仔诺拦住，他对你说：你看看你是不是少了什么东西？",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		3,
		2,
		"你看了一下，发现背包里少了一个袋子，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		1,
		3,
		3,
		"牛仔诺问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		1,
		3,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		3,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		3,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		3,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		3,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		3,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		3,
		10,
		"你看着脚上的大包陷入沉思……",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		1,
		3,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		4,
		1,
		"末炎：\r\n是我最喜欢吃的炎椒珍味锅！你欠我那顿饭，不如现在请了吧？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 1,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		4,
		2,
		"你：没问题！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		4,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		1,
		4,
		4,
		"末炎：你和美味，我都不会忘记的~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		4,
		5,
		"你：（掏了掏口袋）对不起，我忘记带钱包了",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		1,
		4,
		6,
		"末炎：哼，我的耐心可是有限的！\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		4,
		7,
		"你：别吃了，减减肥吧",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = -20
		},
		nil,
		false
	},
	{
		1,
		4,
		8,
		"末炎：\r\n哈？吃我一拳！\r\n(好感度-20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		5,
		1,
		"杀手：你已经走投无路了，乖乖束手就擒，说不定还能留你一条全尸。",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 1,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		5,
		2,
		"末炎：我不想弄脏自己的手，别逼我改变主意。",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		1,
		5,
		3,
		"A、别和他废话，动手！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1008,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		5,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		1,
		5,
		5,
		"末炎：以前没看出来，你为我冲锋陷阵的样子，还是很帅的~\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		5,
		6,
		"你被杀手捅了一刀，且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		1,
		5,
		7,
		"末炎一把搂住你，开始逃跑\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		5,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 1,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		1,
		5,
		9,
		"末炎：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		1,
		6,
		1,
		"你被一块石头绊倒",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		1,
		6,
		2,
		"你的背包掉了，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		1,
		6,
		3,
		"旁边突然出现一个牛仔诺，问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		1,
		6,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		6,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		6,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		1,
		6,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		6,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		6,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		1,
		6,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		1,
		6,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		1,
		1,
		"光耀神女：\r\n虽然我没带钱，但这个压缩蛋白棒实在物美价廉，是补充能量的不二之选，你觉得呢？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 2,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		1,
		2,
		"你：我来买下它！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		1,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		2,
		1,
		4,
		"光耀神女：谢谢你~你真是个好人~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		1,
		5,
		"你：（翻了翻钱包）啊……今天没带够钱，抱歉",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		2,
		1,
		6,
		"光耀神女：好吧，可惜蛋白棒怕是要落入他人之手了。\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		1,
		7,
		"你：我也没有钱",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = -50
		},
		nil,
		false
	},
	{
		2,
		1,
		8,
		"光耀神女：\r\n哼，这里的人都是小气鬼！\r\n(好感度-50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		2,
		1,
		"混混：你跑不掉了，乖乖跟我们走吧，不然可别怪我们不客气！",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 2,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		2,
		2,
		"光耀神女：奇怪的家伙们，需要统统除掉！",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		2,
		2,
		3,
		"A、是时候展示真正的实力了！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1007,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		2,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		2,
		2,
		5,
		"光耀神女：奥奇城的伙伴们都像你一样帅吗！\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		2,
		6,
		"你且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		2,
		2,
		7,
		"光耀神女：看到飞船了吗，跑！\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		2,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		2,
		2,
		9,
		"光耀神女：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		3,
		1,
		"你被一个牛仔诺拦住，他对你说：你看看你是不是少了什么东西？",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		3,
		2,
		"你看了一下，发现背包里少了一个袋子，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		2,
		3,
		3,
		"牛仔诺问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		2,
		3,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		3,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		3,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		3,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		3,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		3,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		3,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		2,
		3,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		4,
		1,
		"光耀神女：\r\n是我最喜欢吃的全能营养啫喱！这次不要再错过了，可以吗？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 2,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		4,
		2,
		"你：没问题！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		4,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		2,
		4,
		4,
		"光耀神女：谢谢你~你买给我的食物简直美味到身边的人睡着了都不知道！\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		4,
		5,
		"你：（掏了掏口袋）对不起，我忘记带钱包了",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		2,
		4,
		6,
		"光耀神女：那好吧，下次我一定会提醒你的！\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		4,
		7,
		"你：别吃了，减减肥吧",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = -20
		},
		nil,
		false
	},
	{
		2,
		4,
		8,
		"光耀神女：\r\n哈？我讨厌没有礼貌的人！\r\n(好感度-20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		5,
		1,
		"杀手：你已经走投无路了，乖乖束手就擒，说不定还能留你一条全尸。",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 2,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		5,
		2,
		"光耀神女：反派死于话多，这是我新学会的奥奇话，说的是你吗？",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		2,
		5,
		3,
		"A、别怕，我来助你！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1008,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		5,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		2,
		5,
		5,
		"光耀神女：你实在是太帅了！\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		5,
		6,
		"你被杀手捅了一刀，且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		2,
		5,
		7,
		"光耀神女一把抱住你，开始逃跑\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		5,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 2,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		2,
		5,
		9,
		"光耀神女：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		2,
		6,
		1,
		"你被一块石头绊倒",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		2,
		6,
		2,
		"你的背包掉了，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		2,
		6,
		3,
		"旁边突然出现一个牛仔诺，问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		2,
		6,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		6,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		6,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		2,
		6,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		6,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		6,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		2,
		6,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		2,
		6,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		1,
		1,
		"弥梦离：\r\n这个露灵蜜饯很不错，可是我忘了带钱，可以拜托你帮我买点吗？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 3,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		1,
		2,
		"你：当然没问题！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		1,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		3,
		1,
		4,
		"弥梦离：谢谢你~我记住你啦~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		1,
		5,
		"你：（翻了翻钱包）啊……今天没带够钱，抱歉",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		3,
		1,
		6,
		"弥梦离：好吧，那下次吧\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		1,
		7,
		"你：不要，我也没有钱",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = -50
		},
		nil,
		false
	},
	{
		3,
		1,
		8,
		"弥梦离：\r\n唔，被拒绝了呢…...\r\n(好感度-50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		2,
		1,
		"混混：你跑不掉了，乖乖跟我们走吧，不然可别怪我们不客气！",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 3,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		2,
		2,
		"弥梦离：想拦我，你们还不够资格！",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		3,
		2,
		3,
		"A、放开她，让我来！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1007,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		2,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		3,
		2,
		5,
		"弥梦离：这么厉害的你，总觉得在哪里见过呢…?\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		2,
		6,
		"你且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		3,
		2,
		7,
		"弥梦离：抓紧我，快走！\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		2,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		3,
		2,
		9,
		"弥梦离：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		3,
		1,
		"你被一个牛仔诺拦住，他对你说：你看看你是不是少了什么东西？",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		3,
		2,
		"你看了一下，发现背包里少了一个袋子，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		3,
		3,
		3,
		"牛仔诺问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		3,
		3,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		3,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		3,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		3,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		3,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		3,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		3,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		3,
		3,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		4,
		1,
		"弥梦离：\r\n是我最喜欢吃的月光果布丁！我记得你好像说过要请我吃饭，不如就现在吧！",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 3,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		4,
		2,
		"你：没问题！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		4,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		3,
		4,
		4,
		"弥梦离：谢谢你~你真是个好人~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		4,
		5,
		"你：（掏了掏口袋）对不起，我忘记带钱包了",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		3,
		4,
		6,
		"弥梦离：没关系，那下次吧\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		4,
		7,
		"你：别吃了，减减肥吧",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = -20
		},
		nil,
		false
	},
	{
		3,
		4,
		8,
		"弥梦离：\r\n啊，我真的有很胖吗？才不是呢！\r\n(好感度-20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		5,
		1,
		"杀手：你已经走投无路了，乖乖束手就擒，说不定还能留你一条全尸。",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 3,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		5,
		2,
		"弥梦离：这里不适合打斗，请你离开！",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		3,
		5,
		3,
		"A、别和他废话，动手！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1008,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		5,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		3,
		5,
		5,
		"弥梦离：你实在是太帅了！\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		5,
		6,
		"你被杀手捅了一刀，且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		3,
		5,
		7,
		"弥梦离一把扶住你，开始逃跑\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		5,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 3,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		3,
		5,
		9,
		"弥梦离：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		3,
		6,
		1,
		"你被一块石头绊倒",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		3,
		6,
		2,
		"你的背包掉了，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		3,
		6,
		3,
		"旁边突然出现一个牛仔诺，问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		3,
		6,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		6,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		6,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		3,
		6,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		6,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		6,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		3,
		6,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		3,
		6,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		1,
		1,
		"尘：\r\n这个神泽贡果很不错，但是我没带钱，你能帮我买点吗？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 4,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		1,
		2,
		"你：当然可以！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		1,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		4,
		1,
		4,
		"尘：谢谢了\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		1,
		5,
		"你：（翻了翻钱包）啊……今天没带够钱，抱歉",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		4,
		1,
		6,
		"尘：没关系，那下次吧\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		1,
		7,
		"你：不要，我也没有钱",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = -50
		},
		nil,
		false
	},
	{
		4,
		1,
		8,
		"尘：\r\n哼，小气鬼！\r\n(好感度-50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		2,
		1,
		"混混：你跑不掉了，乖乖跟我们走吧，不然可别怪我们不客气！",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 4,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		2,
		2,
		"尘：不自量力的家伙们！",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		4,
		2,
		3,
		"A、轮到我出手了！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1007,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		2,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		4,
		2,
		5,
		"尘：还挺厉害的嘛\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		2,
		6,
		"你且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		4,
		2,
		7,
		"尘：情况危急，小心！\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		2,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		4,
		2,
		9,
		"尘：哼，胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		3,
		1,
		"你被一个牛仔诺拦住，他对你说：你看看你是不是少了什么东西？",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		3,
		2,
		"你看了一下，发现背包里少了一个袋子，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		4,
		3,
		3,
		"牛仔诺问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		4,
		3,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		3,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		3,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		3,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		3,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		3,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		3,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		4,
		3,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		4,
		1,
		"尘：\r\n是我最喜欢吃的遗妖魂泪！你欠我那顿饭，不如现在请了吧？",
		1,
		{
			2,
			7
		},
		nil,
		nil,
		nil,
		{
			girlFetter = 4,
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		4,
		2,
		"你：没问题！",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				3,
				5
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		4,
		3,
		"你：区区1000块，全款拿下",
		2,
		nil,
		nil,
		{
			next = 4,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 100
		},
		nil,
		false
	},
	{
		4,
		4,
		4,
		"尘：谢谢你~你真是个好人~\r\n(好感度+100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		4,
		5,
		"你：（掏了掏口袋）对不起，我忘记带钱包了",
		2,
		nil,
		nil,
		{
			next = 6,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		4,
		4,
		6,
		"尘：没关系，那下次吧\r\n(好感度+20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		4,
		7,
		"你：别吃了，减减肥吧",
		2,
		nil,
		nil,
		{
			next = 8,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = -20
		},
		nil,
		false
	},
	{
		4,
		4,
		8,
		"尘：\r\n哈？吃我一拳！\r\n(好感度-20)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		5,
		1,
		"杀手：你已经走投无路了，乖乖束手就擒，说不定还能留你一条全尸。",
		1,
		nil,
		nil,
		{
			next = 2,
			type = "auto"
		},
		nil,
		{
			girlFetter = 4,
			showMoney = false,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		5,
		2,
		"尘：我不想弄脏自己的手，别逼我改变主意。",
		2,
		{
			3,
			8
		},
		nil,
		nil,
		nil,
		nil,
		false
	},
	{
		4,
		5,
		3,
		"A、别和他废话，动手！(进入战斗)",
		2,
		nil,
		nil,
		{
			creepsMasterId = 1008,
			ratio = 10000,
			type = "fight",
			ifelse = {
				4,
				6
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		5,
		4,
		"你成功击退了敌方",
		2,
		nil,
		nil,
		{
			next = 5,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 50
		},
		nil,
		false
	},
	{
		4,
		5,
		5,
		"尘：你实在是太帅了！\r\n(好感度+50)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		5,
		6,
		"你被杀手捅了一刀，且战且退",
		2,
		nil,
		nil,
		{
			next = 7,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = 20
		},
		nil,
		false
	},
	{
		4,
		5,
		7,
		"尘一把拽住你，开始逃跑\r\n(好感度+20)",
		2,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		5,
		8,
		"B、你不要过来啊！(逃跑)",
		2,
		nil,
		nil,
		{
			next = 9,
			type = "auto"
		},
		{
			type = "surroundByGirl_ChangeFetter",
			girl = 4,
			activityId = 459001,
			fetter = -100
		},
		nil,
		false
	},
	{
		4,
		5,
		9,
		"尘：胆小鬼！\r\n(好感度-100)",
		1,
		nil,
		nil,
		nil,
		nil,
		nil,
		true
	},
	{
		4,
		6,
		1,
		"你被一块石头绊倒",
		2,
		nil,
		nil,
		{
			activityId = 459001,
			money = -1000,
			type = "surroundByGirl_ChangeMoney",
			ifelse = {
				2,
				10
			}
		},
		nil,
		{
			showMoney = true,
			activityId = 459001,
			type = "surroundByGirl_extInfo"
		},
		false
	},
	{
		4,
		6,
		2,
		"你的背包掉了，财富-1000",
		2,
		nil,
		nil,
		{
			next = 3,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		4,
		6,
		3,
		"旁边突然出现一个牛仔诺，问你：年轻人哟，你掉的是这个金背包，还是银背包，还是破烂咸鱼背包啊？",
		1,
		{
			4,
			5,
			6
		},
		{
			"icon/items/icon_lihe05",
			"icon/items/icon_lihe03",
			"icon/items/icon_wuwang_lidai"
		},
		nil,
		nil,
		nil,
		false
	},
	{
		4,
		6,
		4,
		"你选择了【金背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				10,
				30,
				60
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		6,
		5,
		"你选择了【银背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				30,
				30,
				30
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		6,
		6,
		"你选择了【破烂咸鱼背包】",
		2,
		nil,
		nil,
		{
			type = "random",
			answers = {
				7,
				8,
				9
			},
			weights = {
				60,
				30,
				10
			}
		},
		nil,
		nil,
		false
	},
	{
		4,
		6,
		7,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+3000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 3000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		6,
		8,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+2000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 2000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		6,
		9,
		"牛仔诺：你这年轻人真有意思，我要奖励你！\r\n(财富+1000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 1000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	},
	{
		4,
		6,
		10,
		"你看着脚上的大包陷入沉思",
		2,
		nil,
		nil,
		{
			next = 11,
			type = "auto"
		},
		nil,
		nil,
		false
	},
	{
		4,
		6,
		11,
		"旁边突然出现一个牛仔诺，对你说：年轻人，虽然你现在很穷，但是不要气馁，灿烂的明天在等着你！\r\n(财富+5000)",
		1,
		nil,
		nil,
		nil,
		{
			activityId = 459001,
			money = 5000,
			type = "surroundByGirl_ChangeMoney"
		},
		nil,
		true
	}
}
local t_explore_under_dialogue_event = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4],
			dataList[5],
			dataList[6],
			dataList[7],
			dataList[8]
		},
		{
			dataList[9],
			dataList[10],
			dataList[11],
			dataList[12],
			dataList[13],
			dataList[14],
			dataList[15],
			dataList[16],
			dataList[17]
		},
		{
			dataList[18],
			dataList[19],
			dataList[20],
			dataList[21],
			dataList[22],
			dataList[23],
			dataList[24],
			dataList[25],
			dataList[26],
			dataList[27],
			dataList[28]
		},
		{
			dataList[29],
			dataList[30],
			dataList[31],
			dataList[32],
			dataList[33],
			dataList[34],
			dataList[35],
			dataList[36]
		},
		{
			dataList[37],
			dataList[38],
			dataList[39],
			dataList[40],
			dataList[41],
			dataList[42],
			dataList[43],
			dataList[44],
			dataList[45]
		},
		{
			dataList[46],
			dataList[47],
			dataList[48],
			dataList[49],
			dataList[50],
			dataList[51],
			dataList[52],
			dataList[53],
			dataList[54],
			dataList[55],
			dataList[56]
		}
	},
	{
		{
			dataList[57],
			dataList[58],
			dataList[59],
			dataList[60],
			dataList[61],
			dataList[62],
			dataList[63],
			dataList[64]
		},
		{
			dataList[65],
			dataList[66],
			dataList[67],
			dataList[68],
			dataList[69],
			dataList[70],
			dataList[71],
			dataList[72],
			dataList[73]
		},
		{
			dataList[74],
			dataList[75],
			dataList[76],
			dataList[77],
			dataList[78],
			dataList[79],
			dataList[80],
			dataList[81],
			dataList[82],
			dataList[83],
			dataList[84]
		},
		{
			dataList[85],
			dataList[86],
			dataList[87],
			dataList[88],
			dataList[89],
			dataList[90],
			dataList[91],
			dataList[92]
		},
		{
			dataList[93],
			dataList[94],
			dataList[95],
			dataList[96],
			dataList[97],
			dataList[98],
			dataList[99],
			dataList[100],
			dataList[101]
		},
		{
			dataList[102],
			dataList[103],
			dataList[104],
			dataList[105],
			dataList[106],
			dataList[107],
			dataList[108],
			dataList[109],
			dataList[110],
			dataList[111],
			dataList[112]
		}
	},
	{
		{
			dataList[113],
			dataList[114],
			dataList[115],
			dataList[116],
			dataList[117],
			dataList[118],
			dataList[119],
			dataList[120]
		},
		{
			dataList[121],
			dataList[122],
			dataList[123],
			dataList[124],
			dataList[125],
			dataList[126],
			dataList[127],
			dataList[128],
			dataList[129]
		},
		{
			dataList[130],
			dataList[131],
			dataList[132],
			dataList[133],
			dataList[134],
			dataList[135],
			dataList[136],
			dataList[137],
			dataList[138],
			dataList[139],
			dataList[140]
		},
		{
			dataList[141],
			dataList[142],
			dataList[143],
			dataList[144],
			dataList[145],
			dataList[146],
			dataList[147],
			dataList[148]
		},
		{
			dataList[149],
			dataList[150],
			dataList[151],
			dataList[152],
			dataList[153],
			dataList[154],
			dataList[155],
			dataList[156],
			dataList[157]
		},
		{
			dataList[158],
			dataList[159],
			dataList[160],
			dataList[161],
			dataList[162],
			dataList[163],
			dataList[164],
			dataList[165],
			dataList[166],
			dataList[167],
			dataList[168]
		}
	},
	{
		{
			dataList[169],
			dataList[170],
			dataList[171],
			dataList[172],
			dataList[173],
			dataList[174],
			dataList[175],
			dataList[176]
		},
		{
			dataList[177],
			dataList[178],
			dataList[179],
			dataList[180],
			dataList[181],
			dataList[182],
			dataList[183],
			dataList[184],
			dataList[185]
		},
		{
			dataList[186],
			dataList[187],
			dataList[188],
			dataList[189],
			dataList[190],
			dataList[191],
			dataList[192],
			dataList[193],
			dataList[194],
			dataList[195],
			dataList[196]
		},
		{
			dataList[197],
			dataList[198],
			dataList[199],
			dataList[200],
			dataList[201],
			dataList[202],
			dataList[203],
			dataList[204]
		},
		{
			dataList[205],
			dataList[206],
			dataList[207],
			dataList[208],
			dataList[209],
			dataList[210],
			dataList[211],
			dataList[212],
			dataList[213]
		},
		{
			dataList[214],
			dataList[215],
			dataList[216],
			dataList[217],
			dataList[218],
			dataList[219],
			dataList[220],
			dataList[221],
			dataList[222],
			dataList[223],
			dataList[224]
		}
	}
}

t_explore_under_dialogue_event.dataList = dataList

local mt = {
	__index = function(t, key)
		local index = title[key]

		if index then
			return rawget(t, index)
		end
	end
}

for i, v in ipairs(dataList) do
	setmetatable(v, mt)
end

return t_explore_under_dialogue_event
