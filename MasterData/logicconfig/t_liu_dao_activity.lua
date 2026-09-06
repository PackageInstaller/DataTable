-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_liu_dao_activity.lua

module("logicconfig.config.t_liu_dao_activity", package.seeall)

local title = {
	refreshCost = 3,
	racesDoubledPrize = 5,
	dailyStageMaxStorage = 4,
	weeklyRefreshLimit = 2,
	activityItemId = 6,
	activityId = 1
}
local dataList = {
	{
		198001,
		10,
		"105:188:50",
		8,
		{
			13006,
			17002
		},
		198002
	},
	{
		198002,
		10,
		"105:188:50",
		8,
		{
			16010,
			15015
		},
		198004
	},
	{
		198003,
		10,
		"105:188:50",
		8,
		{
			12009,
			12010
		},
		198006
	},
	{
		198004,
		10,
		"105:188:50",
		8,
		{
			11013,
			11011
		},
		198008
	},
	{
		198005,
		10,
		"105:188:50",
		8,
		{
			13017,
			13018
		},
		198010
	}
}
local t_liu_dao_activity = {
	[198001] = dataList[1],
	[198002] = dataList[2],
	[198003] = dataList[3],
	[198004] = dataList[4],
	[198005] = dataList[5]
}

t_liu_dao_activity.dataList = dataList

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

return t_liu_dao_activity
