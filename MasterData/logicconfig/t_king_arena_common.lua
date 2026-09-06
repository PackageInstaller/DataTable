-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_king_arena_common.lua

module("logicconfig.config.t_king_arena_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_FREE_FIGHT_TIMES",
		"10"
	},
	{
		"DAILY_PRIZE_TIMES",
		"5"
	},
	{
		"WIN_ADD_ARENA_SCORE",
		"100"
	},
	{
		"LOST_ADD_ARENA_SCORE",
		"100"
	},
	{
		"OP_COUNT_BEFORE_ME",
		"3"
	},
	{
		"OP_COUNT_AFTER_ME",
		"2"
	},
	{
		"REFRESH_OP_COUNT",
		"5"
	},
	{
		"MAX_ZONE_CAPACITY",
		"80000"
	},
	{
		"ROBOT_COUNT",
		"10000"
	},
	{
		"REPORT_COUNT_LIMIT",
		"5"
	},
	{
		"FIGHT_KING_TIMES_RANK_CAPACITY",
		"1000"
	},
	{
		"PET_RANK_THRESHOLD",
		"10"
	},
	{
		"FIGHT_CD",
		"3"
	},
	{
		"EMPTY_POSITION_CAN_REPLACE",
		"75000"
	},
	{
		"FIGHT_KING_RANK_CAPACITY",
		"5"
	},
	{
		"JUMPSTR_ONE",
		"func#191#426#426003"
	},
	{
		"MAIN_RULE_KEY",
		"kingarenamainview_rule"
	}
}
local t_king_arena_common = {
	DAILY_FREE_FIGHT_TIMES = dataList[1],
	DAILY_PRIZE_TIMES = dataList[2],
	WIN_ADD_ARENA_SCORE = dataList[3],
	LOST_ADD_ARENA_SCORE = dataList[4],
	OP_COUNT_BEFORE_ME = dataList[5],
	OP_COUNT_AFTER_ME = dataList[6],
	REFRESH_OP_COUNT = dataList[7],
	MAX_ZONE_CAPACITY = dataList[8],
	ROBOT_COUNT = dataList[9],
	REPORT_COUNT_LIMIT = dataList[10],
	FIGHT_KING_TIMES_RANK_CAPACITY = dataList[11],
	PET_RANK_THRESHOLD = dataList[12],
	FIGHT_CD = dataList[13],
	EMPTY_POSITION_CAN_REPLACE = dataList[14],
	FIGHT_KING_RANK_CAPACITY = dataList[15],
	JUMPSTR_ONE = dataList[16],
	MAIN_RULE_KEY = dataList[17]
}

t_king_arena_common.dataList = dataList

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

return t_king_arena_common
