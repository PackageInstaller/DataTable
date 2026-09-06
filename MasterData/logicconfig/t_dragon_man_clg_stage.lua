-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_man_clg_stage.lua

module("logicconfig.config.t_dragon_man_clg_stage", package.seeall)

local title = {
	stageId = 2,
	ruleDesc = 5,
	supportPlanId = 4,
	lineRParams = 8,
	targetDesc = 9,
	pos = 6,
	lineLParams = 7,
	fmtAddTips = 10,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		552001,
		1,
		1001,
		1001,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥3",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		2,
		1002,
		1002,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥3",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		3,
		1003,
		1003,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥3",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		4,
		1004,
		1004,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥4",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		5,
		1005,
		1005,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥4",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		6,
		1006,
		1006,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥4",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		7,
		1007,
		1007,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥5",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		8,
		1008,
		1008,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥5",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		9,
		1009,
		1009,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥5",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		10,
		1010,
		1010,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥6",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		11,
		1011,
		1011,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			-100
		},
		nil,
		nil,
		"破阵，且己方精灵存活数量≥6",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	},
	{
		552001,
		12,
		1012,
		1012,
		"1、敌阵精灵攻击时给目标施加封魔印（降低目标<color=#20B376FF>25%</color>的物防及魔防，可叠加，持续<color=#20B376FF>1</color>个大回合）\r\n2、敌阵精灵每次出手获得<color=#20B376FF>1</color>点能量，能量达到<color=#20B376FF>3</color>点，对己阵全体造成造成血量上限<color=#20B376FF>15%</color>的非直接伤害，变身铠甲勇士可以减免<color=#20B376FF>15%</color>的直接伤害\r\n3、己方击杀在敌阵中且与自己<color=#20B376FF>相同且拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士",
		{
			0,
			100
		},
		{
			400,
			125
		},
		{
			400,
			-125
		},
		"破阵，且己方精灵存活数量≥6",
		"击杀敌阵中与自己<color=#20B376FF>相同</color>且<color=#20B376FF>拥有铠甲</color>的精灵（进化态和进化前态均视为相同精灵），变身为铠甲勇士"
	}
}
local t_dragon_man_clg_stage = {
	[552001] = {
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
		dataList[12]
	}
}

t_dragon_man_clg_stage.dataList = dataList

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

return t_dragon_man_clg_stage
