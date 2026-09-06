-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_weekly_big_box_params.lua

module("logicconfig.config.t_weekly_big_box_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_DAYS_OF_WEEK",
		"5,6,7"
	},
	{
		"ADD_TIMES_DAILY_ACTIVITIES",
		"60,120"
	},
	{
		"DAILY_FREE_TIMES",
		"1"
	},
	{
		"RED_PACKAGE_MAX_NUM",
		"10"
	},
	{
		"MAX_RECORD_NUM",
		"50"
	},
	{
		"ONCE_DRAW_BIG_PRIZE_NUM",
		"1"
	},
	{
		"NEED_RECORD_BIG_PRIZE_IDS",
		"7,8,9,10"
	}
}
local t_weekly_big_box_params = {
	OPEN_DAYS_OF_WEEK = dataList[1],
	ADD_TIMES_DAILY_ACTIVITIES = dataList[2],
	DAILY_FREE_TIMES = dataList[3],
	RED_PACKAGE_MAX_NUM = dataList[4],
	MAX_RECORD_NUM = dataList[5],
	ONCE_DRAW_BIG_PRIZE_NUM = dataList[6],
	NEED_RECORD_BIG_PRIZE_IDS = dataList[7]
}

t_weekly_big_box_params.dataList = dataList

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

return t_weekly_big_box_params
