-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_extreme_clg_buff.lua

module("logicconfig.config.t_empress_extreme_clg_buff", package.seeall)

local title = {
	name = 4,
	buffId = 2,
	icon = 5,
	activityId = 1,
	desc = 3
}
local dataList = {
	{
		342001,
		1,
		"进入战斗时，敌阵生命最高的精灵获得嘲讽（持续2次超杀）及免疫（持续2次攻击）",
		"嘲讽免疫",
		"icon_expedition_6huihezhongjie"
	},
	{
		342001,
		2,
		"己阵除空系精灵外的精灵攻击力减少70%",
		"降低攻击",
		"icon_expedition_baojilv"
	},
	{
		342001,
		3,
		"2个大回合内结束战斗",
		"限定回合",
		"icon_expedition_baojilv1"
	},
	{
		342001,
		4,
		"敌阵攻击时会对目标造成自身最大生命值*50%的伤害",
		"附带伤害",
		"icon_expedition_baotou"
	},
	{
		342001,
		5,
		"每个大回合结束时，敌阵全体存活精灵获得1次免疫",
		"全体免疫",
		"icon_expedition_bianyi"
	},
	{
		342001,
		6,
		"敌阵精灵获得50%减伤，己阵每次免疫时降低敌阵10%减伤",
		"全体减伤",
		"icon_expedition_bianyi01"
	},
	{
		342002,
		1,
		"进入战斗时，敌阵生命最高的精灵获得嘲讽（持续2次超杀）及免疫（持续2次攻击）",
		"嘲讽免疫",
		"icon_expedition_6huihezhongjie"
	},
	{
		342002,
		2,
		"己阵除空系精灵外的精灵攻击力减少70%",
		"降低攻击",
		"icon_expedition_baojilv"
	},
	{
		342002,
		3,
		"2个大回合内结束战斗",
		"限定回合",
		"icon_expedition_baojilv1"
	},
	{
		342002,
		4,
		"敌阵攻击时会对目标造成自身最大生命值*50%的伤害",
		"附带伤害",
		"icon_expedition_baotou"
	},
	{
		342002,
		5,
		"每个大回合结束时，敌阵全体存活精灵获得1次免疫",
		"全体免疫",
		"icon_expedition_bianyi"
	},
	{
		342002,
		6,
		"敌阵精灵获得50%减伤，己阵每次免疫时降低敌阵10%减伤",
		"全体减伤",
		"icon_expedition_bianyi01"
	}
}
local t_empress_extreme_clg_buff = {
	[342001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[342002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_empress_extreme_clg_buff.dataList = dataList

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

return t_empress_extreme_clg_buff
