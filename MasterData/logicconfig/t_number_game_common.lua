-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_number_game_common.lua

module("logicconfig.config.t_number_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"OPEN_TIME",
		"08:30:00#23:30:00"
	},
	{
		"DAILY_COIN_ITEM_LIMIT",
		"500"
	},
	{
		"BEFORE_MATCH_TIME",
		"2"
	},
	{
		"NORMAL_MATCH_TIME",
		"10"
	},
	{
		"MATCH_TIME",
		"30"
	},
	{
		"OPERATE_TIME",
		"15"
	},
	{
		"CHAT_CD",
		"3"
	},
	{
		"BUBBLE_TIME",
		"3"
	},
	{
		"INIT_NUMBER_RANGE",
		"0,100"
	},
	{
		"ROBOT_OPERATE_TIME_RANGE",
		"3,6"
	},
	{
		"SHOP_ACTIVITYTYPE",
		"54"
	},
	{
		"SHOP_ACTIVITYID",
		"54003"
	},
	{
		"OPEN_TIME_TIPS",
		"08:30:00-23:30:00"
	},
	{
		"REWARD_ID",
		"10:54003:1"
	},
	{
		"SHOP_EXPLICIT_ID",
		"4:31:20"
	}
}
local t_number_game_common = {
	OPEN_TIME = dataList[1],
	DAILY_COIN_ITEM_LIMIT = dataList[2],
	BEFORE_MATCH_TIME = dataList[3],
	NORMAL_MATCH_TIME = dataList[4],
	MATCH_TIME = dataList[5],
	OPERATE_TIME = dataList[6],
	CHAT_CD = dataList[7],
	BUBBLE_TIME = dataList[8],
	INIT_NUMBER_RANGE = dataList[9],
	ROBOT_OPERATE_TIME_RANGE = dataList[10],
	SHOP_ACTIVITYTYPE = dataList[11],
	SHOP_ACTIVITYID = dataList[12],
	OPEN_TIME_TIPS = dataList[13],
	REWARD_ID = dataList[14],
	SHOP_EXPLICIT_ID = dataList[15]
}

t_number_game_common.dataList = dataList

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

return t_number_game_common
