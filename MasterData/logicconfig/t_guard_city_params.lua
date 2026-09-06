-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_city_params.lua

module("logicconfig.config.t_guard_city_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CITY_HP_LIMIT",
		"3"
	},
	{
		"STRENGTH_LIMIT",
		"240"
	},
	{
		"STRENGTH_RECOVERY_EFFICIENCY",
		"720"
	},
	{
		"DAILY_FREE_REFRESH_TIMES",
		"10"
	},
	{
		"INHERIT_FRIEND_RANK",
		"3"
	},
	{
		"INHERIT_FRIEND_SCORE_RATIO",
		"1500"
	},
	{
		"CHALLENGE_STRENGTH_COST",
		"8"
	},
	{
		"STRONG_CHALLENGE_COST_MULTIPLE",
		"3"
	},
	{
		"STRONG_CHALLENGE_BUFF",
		"10020:99"
	},
	{
		"PRIZE_NUM_LIMIT",
		"30"
	},
	{
		"REPORT_NUM_LIMIT",
		"30"
	},
	{
		"SEEK_HELP_TIME_MINUTES",
		"60"
	},
	{
		"STRENGTH_PURCHASE_RECOVERY",
		"30"
	},
	{
		"PRIVILEGE_FREE_TIMES",
		"3"
	},
	{
		"INHERIT_REQUIRED_SCORE",
		"10"
	},
	{
		"MAIN_RULE_KEY",
		"tiaozhanmainview_rule"
	},
	{
		"GAME_RULE_KEY",
		"shouweiview_rule"
	},
	{
		"HELP_RULE_KEY",
		"qiuzhuview_rule"
	},
	{
		"DEFEATED_STRENGTH_PRIZE",
		"0"
	}
}
local t_guard_city_params = {
	CITY_HP_LIMIT = dataList[1],
	STRENGTH_LIMIT = dataList[2],
	STRENGTH_RECOVERY_EFFICIENCY = dataList[3],
	DAILY_FREE_REFRESH_TIMES = dataList[4],
	INHERIT_FRIEND_RANK = dataList[5],
	INHERIT_FRIEND_SCORE_RATIO = dataList[6],
	CHALLENGE_STRENGTH_COST = dataList[7],
	STRONG_CHALLENGE_COST_MULTIPLE = dataList[8],
	STRONG_CHALLENGE_BUFF = dataList[9],
	PRIZE_NUM_LIMIT = dataList[10],
	REPORT_NUM_LIMIT = dataList[11],
	SEEK_HELP_TIME_MINUTES = dataList[12],
	STRENGTH_PURCHASE_RECOVERY = dataList[13],
	PRIVILEGE_FREE_TIMES = dataList[14],
	INHERIT_REQUIRED_SCORE = dataList[15],
	MAIN_RULE_KEY = dataList[16],
	GAME_RULE_KEY = dataList[17],
	HELP_RULE_KEY = dataList[18],
	DEFEATED_STRENGTH_PRIZE = dataList[19]
}

t_guard_city_params.dataList = dataList

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

return t_guard_city_params
