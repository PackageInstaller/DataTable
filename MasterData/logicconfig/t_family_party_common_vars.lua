-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_party_common_vars.lua

module("logicconfig.config.t_family_party_common_vars", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"WEEKLY_OPEN_PARTY_TIMES",
		"1"
	},
	{
		"PARTY_BAN_OPEN_HOUR_RANGE",
		"22:31-08:00"
	},
	{
		"PARTY_PERIOD_MINUTES",
		"30"
	},
	{
		"PARTY_IDLE_PRIZE_1",
		"4:400002:20"
	},
	{
		"PARTY_IDLE_PRIZE_2",
		"8:25:60"
	},
	{
		"PARTY_IDLE_PRIZE_3",
		"4:12102:1"
	},
	{
		"IDLE_PRIZE_PERIOD",
		"60"
	},
	{
		"IDLE_PRIZE_LIMIT",
		"5"
	},
	{
		"QUESTION_GAME_BEGIN_MINUTES",
		"1"
	},
	{
		"QUESTION_COUNT",
		"5"
	},
	{
		"QUESTION_ANSWER_SEC",
		"30"
	},
	{
		"QUESTION_CORRECT_ANSWER_SHOW",
		"15"
	},
	{
		"QUESTION_CORRECT_PRIZE",
		"8:5:500"
	},
	{
		"QUESTION_FALSE_PRIZE",
		"8:5:200"
	},
	{
		"PARTY_OPEN_TIME_RANGE_SHOW",
		"08:00-22:30"
	},
	{
		"FIXED_OPEN_PARTY_DAY_TIME",
		"3#5@20:00"
	}
}
local t_family_party_common_vars = {
	WEEKLY_OPEN_PARTY_TIMES = dataList[1],
	PARTY_BAN_OPEN_HOUR_RANGE = dataList[2],
	PARTY_PERIOD_MINUTES = dataList[3],
	PARTY_IDLE_PRIZE_1 = dataList[4],
	PARTY_IDLE_PRIZE_2 = dataList[5],
	PARTY_IDLE_PRIZE_3 = dataList[6],
	IDLE_PRIZE_PERIOD = dataList[7],
	IDLE_PRIZE_LIMIT = dataList[8],
	QUESTION_GAME_BEGIN_MINUTES = dataList[9],
	QUESTION_COUNT = dataList[10],
	QUESTION_ANSWER_SEC = dataList[11],
	QUESTION_CORRECT_ANSWER_SHOW = dataList[12],
	QUESTION_CORRECT_PRIZE = dataList[13],
	QUESTION_FALSE_PRIZE = dataList[14],
	PARTY_OPEN_TIME_RANGE_SHOW = dataList[15],
	FIXED_OPEN_PARTY_DAY_TIME = dataList[16]
}

t_family_party_common_vars.dataList = dataList

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

return t_family_party_common_vars
