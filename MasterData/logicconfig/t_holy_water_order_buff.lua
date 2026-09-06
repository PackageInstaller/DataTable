-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_water_order_buff.lua

module("logicconfig.config.t_holy_water_order_buff", package.seeall)

local title = {
	buffName = 4,
	buffDesc = 5,
	buffPlanId = 1,
	stars = 3,
	buffIcon = 6,
	difficulty = 2
}
local dataList = {
	{
		1,
		1,
		1,
		"全属性Ⅰ",
		"己阵全属性+50%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		2,
		2,
		"全属性Ⅱ",
		"己阵全属性+30%",
		"icon_expedition_ydnzhufu"
	},
	{
		1,
		3,
		3,
		"全属性Ⅲ",
		"己阵全属性+10%",
		"icon_expedition_ydnzhufu"
	},
	{
		2,
		1,
		1,
		"己阵气势Ⅰ",
		"己阵起始气势+100",
		"icon_expedition_kaichangqishi"
	},
	{
		2,
		2,
		2,
		"己阵气势Ⅱ",
		"己阵起始气势+50",
		"icon_expedition_kaichangqishi"
	},
	{
		2,
		3,
		3,
		"己阵气势Ⅲ",
		"己阵起始气势+10",
		"icon_expedition_kaichangqishi"
	},
	{
		3,
		1,
		1,
		"敌阵气势Ⅰ",
		"敌阵起始气势+10",
		"icon_expedition_bianyi01"
	},
	{
		3,
		2,
		2,
		"敌阵气势Ⅱ",
		"敌阵起始气势+50",
		"icon_expedition_bianyi01"
	},
	{
		3,
		3,
		3,
		"敌阵气势Ⅲ",
		"敌阵起始气势+100",
		"icon_expedition_bianyi01"
	},
	{
		4,
		1,
		1,
		"攻击降气Ⅰ",
		"敌阵攻击会降低目标10点气势",
		"icon_expedition_bianyi"
	},
	{
		4,
		2,
		2,
		"攻击降气Ⅱ",
		"敌阵攻击会降低目标30点气势",
		"icon_expedition_bianyi"
	},
	{
		4,
		3,
		3,
		"攻击降气Ⅲ",
		"敌阵攻击会降低目标50点气势",
		"icon_expedition_bianyi"
	},
	{
		5,
		1,
		1,
		"超杀出手Ⅰ",
		"敌阵超杀后令敌阵随机一只精灵立即出手一次",
		"icon_expedition_bianyi02"
	},
	{
		5,
		2,
		2,
		"超杀出手Ⅱ",
		"敌阵超杀后令敌阵随机一只精灵立即出手一次并获得30气势",
		"icon_expedition_bianyi02"
	},
	{
		5,
		3,
		3,
		"超杀出手Ⅲ",
		"敌阵超杀后令敌阵随机一只精灵立即出手一次并获得60气势",
		"icon_expedition_bianyi02"
	}
}
local t_holy_water_order_buff = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	},
	{
		dataList[7],
		dataList[8],
		dataList[9]
	},
	{
		dataList[10],
		dataList[11],
		dataList[12]
	},
	{
		dataList[13],
		dataList[14],
		dataList[15]
	}
}

t_holy_water_order_buff.dataList = dataList

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

return t_holy_water_order_buff
