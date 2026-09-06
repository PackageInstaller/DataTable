-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_buddy_common_config.lua

module("logicconfig.config.t_buddy_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_UNHANDLE_REQUEST",
		"500"
	},
	{
		"MAX_BUDDY_GROUP_COUNT",
		"100,20,100"
	},
	{
		"MAX_BATCH_SEND_TO_BUDDY_COUNT",
		"5"
	},
	{
		"MAX_GAIN_OR_SEND_HEART_COUNT",
		"5"
	},
	{
		"MAX_DAILY_GAIN_HEART_COUNT",
		"20"
	},
	{
		"MAX_DAILY_SEND_HEART_COUNT",
		"20"
	},
	{
		"BUDDY_HEART_EXPIRE_DAYS",
		"3"
	},
	{
		"MAX_BATCH_SEND_TO_BUDDY__CLIENT_COUNT",
		"5"
	},
	{
		"TEXT_DETECT_CHAT_CHECK_SWITCH",
		"true"
	},
	{
		"TEXT_DETECTION_CHAT_CHECK_BAN_SWITCH",
		"true"
	},
	{
		"NO_CHATTING_PERIOD",
		"2023-06-04 05:00:00#2023-06-05 00:00:00"
	},
	{
		"NO_RENAME_PERIOD",
		"2026-06-02 00:00:00#2026-06-06 00:00:00"
	},
	{
		"CHANNEL_ALL_LIMIT_FUN_ID",
		"479"
	},
	{
		"CHANNEL_ALL_LIMIT_DAILY_SEND_TIMES",
		"99999"
	},
	{
		"CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID",
		"479"
	},
	{
		"CHANNEL_ASK_FOR_HELP_LIMIT_DAILY_SEND_TIMES",
		"99999"
	}
}
local t_buddy_common_config = {
	MAX_UNHANDLE_REQUEST = dataList[1],
	MAX_BUDDY_GROUP_COUNT = dataList[2],
	MAX_BATCH_SEND_TO_BUDDY_COUNT = dataList[3],
	MAX_GAIN_OR_SEND_HEART_COUNT = dataList[4],
	MAX_DAILY_GAIN_HEART_COUNT = dataList[5],
	MAX_DAILY_SEND_HEART_COUNT = dataList[6],
	BUDDY_HEART_EXPIRE_DAYS = dataList[7],
	MAX_BATCH_SEND_TO_BUDDY__CLIENT_COUNT = dataList[8],
	TEXT_DETECT_CHAT_CHECK_SWITCH = dataList[9],
	TEXT_DETECTION_CHAT_CHECK_BAN_SWITCH = dataList[10],
	NO_CHATTING_PERIOD = dataList[11],
	NO_RENAME_PERIOD = dataList[12],
	CHANNEL_ALL_LIMIT_FUN_ID = dataList[13],
	CHANNEL_ALL_LIMIT_DAILY_SEND_TIMES = dataList[14],
	CHANNEL_ASK_FOR_HELP_LIMIT_FUN_ID = dataList[15],
	CHANNEL_ASK_FOR_HELP_LIMIT_DAILY_SEND_TIMES = dataList[16]
}

t_buddy_common_config.dataList = dataList

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

return t_buddy_common_config
