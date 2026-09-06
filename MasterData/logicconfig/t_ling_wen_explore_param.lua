-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_explore_param.lua

module("logicconfig.config.t_ling_wen_explore_param", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"INIT_TRIGGER_RATE",
		"300"
	},
	{
		"ADD_TRIGGER_RATE",
		"50"
	},
	{
		"DAILY_TRIGGER_LIMIT",
		"2"
	},
	{
		"WEEKLY_TRIGGER_LIMIT",
		"7"
	},
	{
		"COUNT_DOWN",
		"14400"
	},
	{
		"INIT_STEP_COUNT",
		"6"
	},
	{
		"BUY_STEP_PRICE",
		"105:2:50"
	},
	{
		"GAME_COUNT_DOWN",
		"30"
	},
	{
		"RULE",
		"holystripeexplore_rule"
	},
	{
		"BUY_TIME_LIMIT",
		"10"
	},
	{
		"ENTER_NAME",
		"灵纹探险"
	},
	{
		"ENTER_PRIZE",
		"9:80036:0#4:30006:0#4:30005:0"
	},
	{
		"ENTER_PATH",
		"board_lingwenmijing_05"
	},
	{
		"ONE_KEY_STEP_UNIT",
		"6"
	}
}
local t_ling_wen_explore_param = {
	INIT_TRIGGER_RATE = dataList[1],
	ADD_TRIGGER_RATE = dataList[2],
	DAILY_TRIGGER_LIMIT = dataList[3],
	WEEKLY_TRIGGER_LIMIT = dataList[4],
	COUNT_DOWN = dataList[5],
	INIT_STEP_COUNT = dataList[6],
	BUY_STEP_PRICE = dataList[7],
	GAME_COUNT_DOWN = dataList[8],
	RULE = dataList[9],
	BUY_TIME_LIMIT = dataList[10],
	ENTER_NAME = dataList[11],
	ENTER_PRIZE = dataList[12],
	ENTER_PATH = dataList[13],
	ONE_KEY_STEP_UNIT = dataList[14]
}

t_ling_wen_explore_param.dataList = dataList

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

return t_ling_wen_explore_param
