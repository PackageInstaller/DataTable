-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_settlement.lua

module("logicconfig.config.t_star_hall_settlement", package.seeall)

local title = {
	buffId = 4,
	typeName = 5,
	settlementId = 2,
	type = 3,
	typeDesc = 6,
	detailedDesc = 7,
	activityId = 1
}
local dataList = {
	{
		494001,
		1,
		"ACTIVE_NUM",
		0,
		"存活数",
		"以结束战斗时的存活精灵作为结算方式",
		"破阵成功且存活数等于%s可获得此积分"
	},
	{
		494001,
		2,
		"CIRCLE",
		0,
		"回合数",
		"以结束战斗时的回合数作为结算方式",
		"破阵成功且回合数等于%s可获得此积分"
	},
	{
		494001,
		3,
		"BUFF_NUM",
		30000031,
		"连击次数",
		"以战斗时的连击数作为结算方式",
		"破阵成功且连击次数等于%s可获得此积分"
	},
	{
		494001,
		4,
		"BUFF_NUM",
		30000059,
		"免疫次数",
		"以结束战斗时的免疫数作为结算方式",
		"破阵成功且免疫次数等于%s可获得此积分"
	},
	{
		494002,
		1,
		"ACTIVE_NUM",
		0,
		"存活数",
		"以结束战斗时的存活精灵作为结算方式",
		"破阵成功且存活数等于%s可获得此积分"
	},
	{
		494002,
		2,
		"CIRCLE",
		0,
		"回合数",
		"以结束战斗时的回合数作为结算方式",
		"破阵成功且回合数等于%s可获得此积分"
	},
	{
		494002,
		3,
		"BUFF_NUM",
		30000031,
		"连击次数",
		"以战斗时的连击数作为结算方式",
		"破阵成功且连击次数等于%s可获得此积分"
	},
	{
		494002,
		4,
		"BUFF_NUM",
		30000059,
		"免疫次数",
		"以结束战斗时的免疫数作为结算方式",
		"破阵成功且免疫次数等于%s可获得此积分"
	}
}
local t_star_hall_settlement = {
	[494001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[494002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_star_hall_settlement.dataList = dataList

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

return t_star_hall_settlement
