-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_shen_ji_challenge_boss.lua

module("logicconfig.config.t_shen_ji_challenge_boss", package.seeall)

local title = {
	stageDesc = 3,
	bossId = 2,
	prize = 5,
	buffDesc = 6,
	creepsMasterId = 4,
	actId = 1
}
local dataList = {
	{
		312001,
		1,
		"乌波·萨斯拉",
		201,
		"4:383:20",
		"无特殊加成"
	},
	{
		312001,
		2,
		"伊波·兹特尔",
		202,
		"4:383:40",
		"无特殊加成"
	},
	{
		312001,
		3,
		"艾布·格萨尔",
		203,
		"4:383:60",
		"无特殊加成"
	},
	{
		312002,
		1,
		"堕心",
		401,
		"4:36:5",
		"无特殊加成"
	},
	{
		312002,
		2,
		"狼化",
		402,
		"4:36:5",
		"无特殊加成"
	},
	{
		312002,
		3,
		"修罗狱",
		403,
		"4:260:100",
		"无特殊加成"
	},
	{
		312003,
		1,
		"暗月·噬夜者",
		2001,
		"4:510780:20",
		"每个大回合开始时，己阵随机两位当前没有伤口撕裂的精灵被施加伤口撕裂（3回合）\r\n伤口撕裂：拥有伤口撕裂的精灵每次出手前，受到自身攻击150%的伤害，每出手一次，撕裂的伤害倍率+40%（最高达270%）\r\n2、BOSS闪避率提高30%"
	},
	{
		312003,
		2,
		"寒光·斩风刃",
		2002,
		"4:510780:30",
		"1、每个大回合开始时，己阵随机两位当前没有伤口撕裂的精灵被施加伤口撕裂（3回合）\r\n伤口撕裂：拥有伤口撕裂的精灵每次出手前，受到自身攻击150%的伤害，每出手一次，撕裂的伤害倍率+40%（最高达270%）\r\n2、BOSS闪避率提高40%"
	},
	{
		312003,
		3,
		"曙月·破晓天",
		2003,
		"4:510780:50",
		"每个大回合开始时，己阵随机两位当前没有伤口撕裂的精灵被施加伤口撕裂（3回合）\r\n伤口撕裂：拥有伤口撕裂的精灵每次出手前，受到自身攻击150%的伤害，每出手一次，撕裂的伤害倍率+40%（最高达270%）\r\n2、BOSS闪避率提高50%"
	}
}
local t_shen_ji_challenge_boss = {
	[312001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[312002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[312003] = {
		dataList[7],
		dataList[8],
		dataList[9]
	}
}

t_shen_ji_challenge_boss.dataList = dataList

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

return t_shen_ji_challenge_boss
