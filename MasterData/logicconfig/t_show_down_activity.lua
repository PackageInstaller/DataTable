-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_show_down_activity.lua

module("logicconfig.config.t_show_down_activity", package.seeall)

local title = {
	recordCountLimit = 9,
	teamIconPlanId = 6,
	extrasGuessRate = 4,
	finalMatchGuessRank = 7,
	exchangeItem = 3,
	finalMatchGuessFloorNum = 8,
	comPlanId = 5,
	activityId = 1,
	guessItem = 2
}
local dataList = {
	{
		360001,
		"10:360002",
		"10:360001",
		30,
		1,
		1,
		3,
		12000,
		10
	},
	{
		360002,
		"",
		"10:360003",
		0,
		1,
		1,
		3,
		12000,
		10
	},
	{
		360003,
		"",
		"10:360004",
		0,
		1,
		1,
		3,
		12000,
		10
	},
	{
		360004,
		"",
		"10:360005",
		0,
		1,
		1,
		3,
		12000,
		10
	},
	{
		360005,
		"",
		"10:360006",
		0,
		1,
		1,
		3,
		12000,
		10
	}
}
local t_show_down_activity = {
	[360001] = dataList[1],
	[360002] = dataList[2],
	[360003] = dataList[3],
	[360004] = dataList[4],
	[360005] = dataList[5]
}

t_show_down_activity.dataList = dataList

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

return t_show_down_activity
