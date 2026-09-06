-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_auto_chess_activity.lua

module("logicconfig.config.t_auto_chess_activity", package.seeall)

local title = {
	battleTimeSec = 8,
	matchingWaitSec = 12,
	refreshShopMoney = 6,
	initBuffTimeSec = 9,
	playerNum = 2,
	settleTimeSec = 10,
	selectEquipTimeSec = 11,
	shopIndex = 5,
	initBuffNum = 4,
	packageLimit = 14,
	openTime = 13,
	fullStarBuffNum = 7,
	prizeEndRoundId = 15,
	initHp = 3,
	activityId = 1
}
local dataList = {
	{
		286001,
		6,
		100,
		2,
		6,
		1,
		3,
		15,
		15,
		3,
		15,
		30,
		"09:00:00#23:59:59",
		10,
		2
	},
	{
		286002,
		6,
		100,
		2,
		6,
		1,
		3,
		15,
		15,
		3,
		15,
		30,
		"09:00:00#23:59:59",
		10,
		2
	},
	{
		286003,
		6,
		100,
		2,
		6,
		1,
		3,
		15,
		15,
		3,
		15,
		30,
		"09:00:00#23:59:59",
		10,
		2
	},
	{
		286004,
		6,
		100,
		2,
		6,
		1,
		3,
		15,
		15,
		3,
		15,
		30,
		"09:00:00#23:59:59",
		10,
		2
	},
	{
		286005,
		6,
		100,
		2,
		6,
		1,
		3,
		15,
		15,
		3,
		15,
		30,
		"09:00:00#23:59:59",
		10,
		2
	}
}
local t_auto_chess_activity = {
	[286001] = dataList[1],
	[286002] = dataList[2],
	[286003] = dataList[3],
	[286004] = dataList[4],
	[286005] = dataList[5]
}

t_auto_chess_activity.dataList = dataList

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

return t_auto_chess_activity
