-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_assistance_box_param.lua

module("logicconfig.config.t_assistance_box_param", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"INIT_TRIGGER_RATE",
		"200"
	},
	{
		"ADD_TRIGGER_RATE",
		"9"
	},
	{
		"DAILY_TRIGGER_LIMIT",
		"1"
	},
	{
		"WEEKLY_TRIGGER_LIMIT",
		"3"
	},
	{
		"DAILY_HELP_TIME",
		"3"
	},
	{
		"HELP_PRIZE",
		"10:170001:5"
	},
	{
		"REPLY_AFTER_HELP",
		"谢谢你帮我助力宝箱宝箱！"
	},
	{
		"MAX_MSG_COUNT",
		"20"
	},
	{
		"RULE",
		"holystripebox_rule"
	},
	{
		"ENTER_NAME",
		"助力宝箱"
	},
	{
		"ENTER_PRIZE",
		"9:80036:0#4:30006:0#8:1:0"
	},
	{
		"ENTER_PATH",
		"board_lingwenmijing_06"
	},
	{
		"INVITATION_CD",
		"30"
	},
	{
		"INVITATION_SHOW_CD",
		"30"
	}
}
local t_assistance_box_param = {
	INIT_TRIGGER_RATE = dataList[1],
	ADD_TRIGGER_RATE = dataList[2],
	DAILY_TRIGGER_LIMIT = dataList[3],
	WEEKLY_TRIGGER_LIMIT = dataList[4],
	DAILY_HELP_TIME = dataList[5],
	HELP_PRIZE = dataList[6],
	REPLY_AFTER_HELP = dataList[7],
	MAX_MSG_COUNT = dataList[8],
	RULE = dataList[9],
	ENTER_NAME = dataList[10],
	ENTER_PRIZE = dataList[11],
	ENTER_PATH = dataList[12],
	INVITATION_CD = dataList[13],
	INVITATION_SHOW_CD = dataList[14]
}

t_assistance_box_param.dataList = dataList

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

return t_assistance_box_param
