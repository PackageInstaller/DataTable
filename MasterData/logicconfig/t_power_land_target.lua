-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_land_target.lua

module("logicconfig.config.t_power_land_target", package.seeall)

local title = {
	iconPath = 4,
	desc = 5,
	targetName = 3,
	targetId = 1,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"战意燃烧",
		"icon_expedition_yadao01",
		"己方上阵精灵初始气势+30"
	},
	{
		1,
		2,
		"战意燃烧",
		"icon_expedition_yadao01",
		"己方上阵精灵初始气势+60"
	},
	{
		1,
		3,
		"战意燃烧",
		"icon_expedition_yadao01",
		"己方上阵精灵初始气势+100"
	},
	{
		1,
		4,
		"战意燃烧",
		"icon_expedition_yadao01",
		"己方上阵精灵初始气势+150"
	},
	{
		1,
		5,
		"战意燃烧",
		"icon_expedition_yadao01",
		"己方上阵精灵初始气势+200且每回合结束时+25气势"
	},
	{
		2,
		1,
		"反射罩体",
		"icon_expedition_guijia01",
		"己方上阵精灵反弹8%的伤害给攻击者"
	},
	{
		2,
		2,
		"反射罩体",
		"icon_expedition_guijia01",
		"己方上阵精灵反弹16%的伤害给攻击者"
	},
	{
		2,
		3,
		"反射罩体",
		"icon_expedition_guijia01",
		"己方上阵精灵反弹28%的伤害给攻击者"
	},
	{
		2,
		4,
		"反射罩体",
		"icon_expedition_guijia01",
		"己方上阵精灵反弹40%的伤害给攻击者"
	},
	{
		2,
		5,
		"反射罩体",
		"icon_expedition_guijia01",
		"己方上阵精灵反弹60%的伤害给攻击者"
	},
	{
		3,
		1,
		"烈火焚烧",
		"icon_expedition_zengshang",
		"己方上阵精灵攻击令目标灼烧5回合（灼烧：出手后受到8%攻击的魔法伤害）"
	},
	{
		3,
		2,
		"烈火焚烧",
		"icon_expedition_zengshang",
		"己方上阵精灵攻击令目标灼烧5回合（灼烧：出手后受到16%攻击的魔法伤害）"
	},
	{
		3,
		3,
		"烈火焚烧",
		"icon_expedition_zengshang",
		"己方上阵精灵攻击令目标灼烧5回合（灼烧：出手后受到24%攻击的魔法伤害）"
	},
	{
		3,
		4,
		"烈火焚烧",
		"icon_expedition_zengshang",
		"己方上阵精灵攻击令目标灼烧5回合（灼烧：出手后受到32%攻击的魔法伤害）"
	},
	{
		3,
		5,
		"烈火焚烧",
		"icon_expedition_zengshang",
		"己方上阵精灵攻击令目标灼烧5回合（灼烧：出手后受到50%攻击的魔法伤害）"
	},
	{
		4,
		1,
		"终极时刻",
		"icon_expedition_zhansha",
		"己方上阵精灵超杀伤害+10%"
	},
	{
		4,
		3,
		"终极时刻",
		"icon_expedition_zhansha",
		"己方上阵精灵超杀伤害+35%"
	},
	{
		4,
		5,
		"终极时刻",
		"icon_expedition_zhansha",
		"己方上阵精灵超杀伤害+90%"
	},
	{
		5,
		1,
		"生命辉光",
		"icon_expedition_xueliang",
		"己方上阵精灵生命上限+6%"
	},
	{
		5,
		3,
		"生命辉光",
		"icon_expedition_xueliang",
		"己方上阵精灵生命上限+20%"
	},
	{
		5,
		5,
		"生命辉光",
		"icon_expedition_xueliang",
		"己方上阵精灵生命上限+60%"
	},
	{
		6,
		1,
		"灾厄炼狱",
		"icon_expedition_baotou",
		"敌阵精灵受到的非直接伤害增加+20%"
	},
	{
		6,
		3,
		"灾厄炼狱",
		"icon_expedition_baotou",
		"敌阵精灵受到的非直接伤害增加+40%"
	},
	{
		6,
		5,
		"灾厄炼狱",
		"icon_expedition_baotou",
		"敌阵精灵受到的非直接伤害增加+100%"
	},
	{
		7,
		2,
		"无限追击",
		"icon_expedition_zhuiji",
		"己方上阵精灵20%概率额外出手（每个回合仅触发一次）"
	},
	{
		7,
		4,
		"无限追击",
		"icon_expedition_zhuiji",
		"己方上阵精灵50%概率额外出手（每个回合仅触发一次）"
	},
	{
		7,
		6,
		"无限追击",
		"icon_expedition_zhuiji",
		"己方上阵精灵100%概率额外出手（每个回合仅触发一次）"
	},
	{
		8,
		2,
		"气体源流",
		"icon_expedition_bianyi01",
		"己方上阵精灵攻击目标后吸收目标10点气势"
	},
	{
		8,
		4,
		"气体源流",
		"icon_expedition_bianyi01",
		"己方上阵精灵攻击目标后吸收目标20点气势"
	},
	{
		8,
		6,
		"气体源流",
		"icon_expedition_bianyi01",
		"己方上阵精灵攻击目标后吸收目标40点气势"
	},
	{
		9,
		2,
		"嗜血狂袭",
		"icon_expedition_chaoshahuixue",
		"己阵上阵精灵拥有10%攻击吸血"
	},
	{
		9,
		4,
		"嗜血狂袭",
		"icon_expedition_chaoshahuixue",
		"己阵上阵精灵拥有20%攻击吸血"
	},
	{
		9,
		6,
		"嗜血狂袭",
		"icon_expedition_chaoshahuixue",
		"己阵上阵精灵拥有40%攻击吸血"
	},
	{
		10,
		1,
		"余烬焱火",
		"icon_expedition_chaoshazhuiji",
		"昼夜王者·诺雅攻击对目标相邻精灵造成50%的溅射伤害"
	}
}
local t_power_land_target = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	{
		dataList[11],
		dataList[12],
		dataList[13],
		dataList[14],
		dataList[15]
	},
	{
		dataList[16],
		[3] = dataList[17],
		[5] = dataList[18]
	},
	{
		dataList[19],
		[3] = dataList[20],
		[5] = dataList[21]
	},
	{
		dataList[22],
		[3] = dataList[23],
		[5] = dataList[24]
	},
	{
		[2] = dataList[25],
		[4] = dataList[26],
		[6] = dataList[27]
	},
	{
		[2] = dataList[28],
		[4] = dataList[29],
		[6] = dataList[30]
	},
	{
		[2] = dataList[31],
		[4] = dataList[32],
		[6] = dataList[33]
	},
	{
		dataList[34]
	}
}

t_power_land_target.dataList = dataList

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

return t_power_land_target
