-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_send_flower_common_config.lua

module("logicconfig.config.t_send_flower_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"BALANCE_TIME",
		"05:00-05:30"
	},
	{
		"LOG_MAX_COUNT",
		"20"
	},
	{
		"TOP_SIZE",
		"100000"
	},
	{
		"TOP_SHOW_SIZE",
		"20"
	},
	{
		"SUPPORT_DAILY_TIMES_LIMIT",
		"3"
	},
	{
		"SUPPORT_PRIZE",
		"9:8000:1"
	},
	{
		"SUPPORT_ADD_VALUE",
		"10"
	},
	{
		"LOG_KEEP_DAYS",
		"7"
	},
	{
		"RANK_JUMP",
		"func#34#"
	},
	{
		"GIFT_LIST_JUMP",
		"func#43"
	}
}
local t_send_flower_common_config = {
	BALANCE_TIME = dataList[1],
	LOG_MAX_COUNT = dataList[2],
	TOP_SIZE = dataList[3],
	TOP_SHOW_SIZE = dataList[4],
	SUPPORT_DAILY_TIMES_LIMIT = dataList[5],
	SUPPORT_PRIZE = dataList[6],
	SUPPORT_ADD_VALUE = dataList[7],
	LOG_KEEP_DAYS = dataList[8],
	RANK_JUMP = dataList[9],
	GIFT_LIST_JUMP = dataList[10]
}

t_send_flower_common_config.dataList = dataList

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

return t_send_flower_common_config
