-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weekly_big_box_client_params.lua

module("logicconfig.config.t_weekly_big_box_client_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_DAYS_OF_WEEK_STR",
		"五六日开放"
	},
	{
		"ROLLER_SPEED",
		"0.5"
	},
	{
		"SHOW_PRIZE_IDS",
		"7#8#9#10#1#2#3#4#5#6"
	},
	{
		"GAME_DROP_SPEED",
		"540#600"
	},
	{
		"GAME_TIME",
		"10"
	},
	{
		"GAME_GRID_X_COUNT",
		"3"
	},
	{
		"GAME_GENERATE_DELTA",
		"0.5"
	},
	{
		"GAME_COUNDOWN",
		"3"
	},
	{
		"GAME_DROP_ANGLE",
		"-20#20"
	},
	{
		"GAME_DROP_RATE",
		"0.9"
	},
	{
		"RED_PACKAGE_ITEM",
		"4:90259:1"
	}
}
local t_weekly_big_box_client_params = {
	OPEN_DAYS_OF_WEEK_STR = dataList[1],
	ROLLER_SPEED = dataList[2],
	SHOW_PRIZE_IDS = dataList[3],
	GAME_DROP_SPEED = dataList[4],
	GAME_TIME = dataList[5],
	GAME_GRID_X_COUNT = dataList[6],
	GAME_GENERATE_DELTA = dataList[7],
	GAME_COUNDOWN = dataList[8],
	GAME_DROP_ANGLE = dataList[9],
	GAME_DROP_RATE = dataList[10],
	RED_PACKAGE_ITEM = dataList[11]
}

t_weekly_big_box_client_params.dataList = dataList

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

return t_weekly_big_box_client_params
