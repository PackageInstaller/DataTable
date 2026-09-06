-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_college_team.lua

module("logicconfig.config.t_battle_college_team", package.seeall)

local title = {
	description = 9,
	name = 2,
	perfectWinId = 13,
	skipTime = 6,
	rule = 10,
	btlMode = 8,
	btlBg = 4,
	redPoint = 14,
	faildescription = 11,
	winId = 12,
	creepsMasterId = 1,
	heroSkillId = 5,
	recommendZdl = 7,
	playerExp = 3
}
local dataList = {
	{
		1,
		"属性克制",
		0,
		"",
		"",
		5,
		0,
		"",
		"1、奥奇世界属性之间存在互相克制关系，<color=#c54949>水克火</color>、<color=#c54949>火克草</color>、<color=#c54949>草克水</color>\n2、熟练运用克制关系，即可在战斗中克敌制胜",
		"击败敌方阵容即可通关\n",
		"这个关卡的设计者没想到你会在第一关失败\r\n将<color=#c54949>蓝蓝露</color>放在<color=#c54949>第一横排</color>，<color=#c54949>爆爆龙</color>放在<color=#c54949>第二横排</color>，<color=#c54949>酷拉兽</color>放在<color=#c54949>第三横排</color>，即可过关",
		0,
		2,
		1
	},
	{
		2,
		"保护输出",
		0,
		"",
		"",
		5,
		0,
		"",
		"1、<color=#c54949>魔魔</color>具有强大的输出能力\n2、保护我方<color=#c54949>魔魔</color>，尽快<color=#c54949>击败敌方魔魔</color>，即可破敌制胜",
		"击败敌方阵容即可通关\n",
		"这里是院长的补习小课堂:\r\n将我方精灵放置在<color=#c54949>第三横排</color>，<color=#c54949>当当</color>放在<color=#c54949>魔魔</color>前面即可成功通关\r\n这样摆放的原因为：<color=#c54949>当当</color>是<color=#c54949>肉盾</color>精灵，可以为魔魔抵御输出，同时放在第三排可以<color=#c54949>集火</color>敌方<color=#c54949>输出核心</color>魔魔，解决掉敌方输出核心即可轻松致胜。",
		0,
		2,
		1
	},
	{
		3,
		"物理与魔法",
		0,
		"",
		"",
		5,
		0,
		"",
		"1、<color=#c54949>问问</color>具有强大的物理输出能力，<color=#c54949>魔魔</color>具有强大的魔法输出能力\n2、<color=#c54949>犀利哥</color>具有强大的物防能力，<color=#c54949>胖噜噜</color>具有强大的魔防能力，建议使用魔魔对阵犀利哥，问问对战胖噜噜，即可克敌制胜",
		"击败敌方阵容即可通关\n",
		"这里是院长的补习小课堂:\r\n将我方魔魔放置在<color=#c54949>第一横排</color>，对上敌方<color=#c54949>犀利哥</color>，我方问问放置在<color=#c54949>第三横排</color>，对上敌方<color=#c54949>胖噜噜</color>\r\n这样摆放的原因为：<color=#c54949>犀利哥</color>是<color=#c54949>物防系</color>的肉盾精灵，难以抵御<color=#c54949>魔法</color>输出，魔魔可迅速击杀<color=#c54949>犀利哥</color>；\r\n同时第三排胖噜噜是<color=#c54949>魔防系</color>的肉盾精灵，难以抵御<color=#c54949>物理</color>输出，问问可迅速击杀<color=#c54949>胖噜噜</color>。",
		0,
		2,
		1
	},
	{
		4,
		"英雄的作用",
		0,
		"",
		"",
		5,
		0,
		"",
		"<color=#c54949>龙炎</color>是火系最强英雄，至少上阵<color=#c54949>3只火系</color>精灵后，可<color=#c54949>触发龙炎英雄技</color>，龙炎英雄技能让龙炎<color=#c54949>登场满气势</color>，可以快速释放超杀获得战神效果",
		"击败敌方阵容即可通关\n",
		"上阵3只火系精灵，触发龙炎英雄技\r\n用龙炎抗住对方次元圣龙的攻击，即可获胜",
		0,
		4,
		1
	},
	{
		5,
		"辅助己方核心",
		0,
		"",
		"",
		5,
		0,
		"",
		"辅助我方<color=#c54949>核心输出-茜茜</color>，让其尽快<color=#c54949>释放超杀</color>是胜利的关键",
		"击败敌方阵容即可通关\n",
		"茜茜放在镭拉身后，快速释放出茜茜的超杀，攻击敌方全阵即可获胜",
		0,
		4,
		1
	},
	{
		6,
		"击杀敌方核心",
		0,
		"",
		"",
		5,
		0,
		"",
		"正确站位，优先<color=#c54949>击杀敌方核心输出</color>\r\n帝释天攻击后可以<color=#c54949>变身</color>成对手，让帝释天<color=#c54949>攻击敌方最强精灵</color>，能让帝释天发挥出最强效果",
		"击败敌方阵容即可通关\n",
		"帝释天可以直接攻击<color=#c54949>敌方后排</color>，让帝释天攻击敌方赤焰龙皇后即可获得胜利",
		0,
		4,
		1
	},
	{
		7,
		"压制敌方核心",
		0,
		"",
		"",
		5,
		0,
		"",
		"敌方赤焰龙皇<color=#c54949>登场即满气势</color>；\r\n维多利亚可以<color=#c54949>降低目标气势</color>，让维多利亚<color=#c54949>攻击敌方核心</color>，可以有效限制敌方核心释放超杀",
		"击败敌方阵容即可通关\n",
		"维多利亚可以直接攻击敌方后排，让维多利亚攻击敌方赤焰龙皇即可获得胜利",
		0,
		4,
		1
	},
	{
		8,
		"均摊伤害",
		0,
		"",
		"",
		5,
		0,
		"",
		"<color=#c54949>均摊伤害</color>，依靠草系强大的持续作战能力，用消耗战击败对手",
		"击败敌方阵容即可通关\n",
		"敌方部分精灵可以<color=#c54949>攻击后排</color>，将阿瑞斯、狄丝、双双放在同一横排(“---”为横排），均摊敌方伤害即可获胜",
		0,
		4,
		1
	},
	{
		9,
		"水系阵容",
		0,
		"",
		"",
		5,
		0,
		"",
		"击败对手已经难不倒你了，使用相同精灵，摆出<color=#c54949>不同站位</color>，零阵亡通关即可拿到完美通关奖励",
		"击败敌方阵容即可通关\n",
		"多尝试不同的摆位，利用好精灵的技能特性来达到零阵亡通关",
		0,
		4,
		1
	},
	{
		10,
		"草系阵容",
		0,
		"",
		"",
		5,
		0,
		"",
		"击败对手已经难不倒你了，使用相同精灵，摆出<color=#c54949>不同站位</color>，零阵亡通关即可拿到完美通关奖励",
		"击败敌方阵容即可通关\n",
		"多尝试不同的摆位，利用好精灵的技能特性来达到零阵亡通关",
		0,
		4,
		1
	},
	{
		11,
		"火系阵容",
		0,
		"",
		"",
		5,
		0,
		"",
		"击败对手已经难不倒你了，使用相同精灵，摆出<color=#c54949>不同站位</color>，零阵亡通关即可拿到完美通关奖励",
		"击败敌方阵容即可通关\n",
		"多尝试不同的摆位，利用好精灵的技能特性来达到零阵亡通关",
		0,
		4,
		1
	},
	{
		12,
		"光系阵容",
		0,
		"",
		"",
		5,
		0,
		"",
		"击败对手已经难不倒你了，使用相同精灵，摆出<color=#c54949>不同站位</color>，零阵亡通关即可拿到完美通关奖励",
		"击败敌方阵容即可通关\n",
		"多尝试不同的摆位，利用好精灵的技能特性来达到零阵亡通关",
		0,
		4,
		1
	},
	{
		13,
		"蓝龙湾的希望",
		0,
		"",
		"",
		5,
		0,
		"",
		"海黛丝的攻击会为目标施加<color=#c54949>海洋印记</color>，帮助星蓝龙触发连击效果",
		"击败敌方阵容即可通关\n",
		"尤烈放置在前排，海黛丝放在星蓝龙身前即可通关",
		0,
		4,
		1
	},
	{
		14,
		"通灵技触发",
		0,
		"",
		"",
		5,
		0,
		"",
		"1、己阵精灵<color=#c54949>每次出手</color>，蜜蕊可获得5点通灵进度；若该精灵是<color=#c54949>首次释放超杀</color>，则蜜蕊可20点通灵进度\r\n2、<color=#c54949>集齐100点通灵进度</color>后，通灵师将会使用通灵技",
		"击败敌方阵容即可通关\n",
		"尝试触发蜜蕊可的通灵技吧",
		0,
		4,
		1
	},
	{
		15,
		"通灵技触发复活",
		0,
		"",
		"",
		5,
		0,
		"",
		"1、通灵技触发时，若通灵师为<color=#c54949>死亡</color>状态，可<color=#c54949>复活并进入通灵状态</color>；\r\n2、尝试让<color=#c54949>蜜蕊可</color>被敌方解神意志·赤的域锁住，之后触发通灵技复活反败为胜",
		"击败敌方阵容即可通关\n",
		"尝试利用<color=#c54949>蜜蕊可</color>被敌方解神意志·赤的域锁住，之后触发通灵技复活反败为胜",
		0,
		5,
		1
	}
}
local t_battle_college_team = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10],
	dataList[11],
	dataList[12],
	dataList[13],
	dataList[14],
	dataList[15]
}

t_battle_college_team.dataList = dataList

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

return t_battle_college_team
