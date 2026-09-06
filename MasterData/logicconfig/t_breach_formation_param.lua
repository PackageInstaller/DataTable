-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_formation_param.lua

module("logicconfig.config.t_breach_formation_param", package.seeall)

local title = {
	conditionDesc = 4,
	desc = 3,
	paramVal = 2,
	paramName = 1
}
local dataList = {
	{
		"rankScoreThreshold",
		"10000",
		"",
		""
	},
	{
		"rankNotInVideo",
		"10",
		"",
		""
	},
	{
		"ShotTimes",
		"1",
		"出手次数",
		"击败敌阵时，己方出手次数越少，获得评分越高"
	},
	{
		"MyAliveNum",
		"1",
		"存活精灵",
		"击败敌阵时，己方存活精灵数量越多，获得评分越高"
	},
	{
		"UltimateNum",
		"1",
		"释放超杀",
		"击败敌阵时，释放超杀次数越少，获得评分越高"
	},
	{
		"hellNeedScore",
		"18000",
		"",
		""
	},
	{
		"quickPassScore",
		"700",
		"",
		""
	},
	{
		"quickPassCost",
		"4:9001:1",
		"",
		""
	}
}
local t_breach_formation_param = {
	rankScoreThreshold = dataList[1],
	rankNotInVideo = dataList[2],
	ShotTimes = dataList[3],
	MyAliveNum = dataList[4],
	UltimateNum = dataList[5],
	hellNeedScore = dataList[6],
	quickPassScore = dataList[7],
	quickPassCost = dataList[8]
}

t_breach_formation_param.dataList = dataList

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

return t_breach_formation_param
