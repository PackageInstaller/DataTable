-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_elizabeth_clg_common.lua

module("logicconfig.config.t_elizabeth_clg_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"100"
	},
	{
		"GAME_PLAN_ID",
		"1"
	},
	{
		"GAME_BUY_TIMES_PLAN_ID",
		"1"
	},
	{
		"DAILY_FREE_GAME_TIMES",
		"2"
	},
	{
		"SCALE_PRIZE_PLAN_ID",
		"1"
	},
	{
		"PRIZE_PLAN_ID",
		"2"
	},
	{
		"RACE_ID",
		"10322"
	},
	{
		"PET_RANK_PRIZE",
		"14:24:1"
	},
	{
		"CLICK_NUMS",
		"1"
	},
	{
		"GAME_TIME",
		"10"
	},
	{
		"BALL_ADD_VOLUMN_PER_CLICK",
		"3.8:100"
	},
	{
		"BALL_MAX_VOLUMN",
		"100"
	},
	{
		"BALL_SUB_VOLUMN_PER_SEC",
		"2.5:100"
	},
	{
		"CLICK_DURATION",
		"0.3"
	},
	{
		"REVIVE_COST",
		"105:178:30"
	},
	{
		"BALL_DOTTED_LINE_VOLUMN",
		"92"
	},
	{
		"ONCE_GAIN_MAX_NUM",
		"110"
	},
	{
		"MAIN_VIEW_SKINID_LIST",
		"1032401#1601101#1009702#1600501"
	}
}
local t_elizabeth_clg_common = {
	CHALLENGE_ID = dataList[1],
	GAME_PLAN_ID = dataList[2],
	GAME_BUY_TIMES_PLAN_ID = dataList[3],
	DAILY_FREE_GAME_TIMES = dataList[4],
	SCALE_PRIZE_PLAN_ID = dataList[5],
	PRIZE_PLAN_ID = dataList[6],
	RACE_ID = dataList[7],
	PET_RANK_PRIZE = dataList[8],
	CLICK_NUMS = dataList[9],
	GAME_TIME = dataList[10],
	BALL_ADD_VOLUMN_PER_CLICK = dataList[11],
	BALL_MAX_VOLUMN = dataList[12],
	BALL_SUB_VOLUMN_PER_SEC = dataList[13],
	CLICK_DURATION = dataList[14],
	REVIVE_COST = dataList[15],
	BALL_DOTTED_LINE_VOLUMN = dataList[16],
	ONCE_GAIN_MAX_NUM = dataList[17],
	MAIN_VIEW_SKINID_LIST = dataList[18]
}

t_elizabeth_clg_common.dataList = dataList

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

return t_elizabeth_clg_common
