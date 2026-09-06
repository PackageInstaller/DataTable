-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_common.lua

module("logicconfig.config.t_arena_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"REFRESH_CD_SEC",
		"5"
	},
	{
		"MAX_DAILY_REFRESH_TIME",
		"9999"
	},
	{
		"WIN_ADD_ARENA_SCORE",
		"20"
	},
	{
		"LOST_ADD_ARENA_SCORE",
		"20"
	},
	{
		"DAILY_TASK_HOLIDAY_PRIZE_TIMES",
		"2"
	},
	{
		"MAX_REMAIN_BATTLE_RECORD",
		"5"
	},
	{
		"CHALLENGE_COUNT",
		"5"
	},
	{
		"ROBOT_COUNT",
		"5000"
	},
	{
		"ROBOT_NAME_PREFIX",
		"守卫"
	},
	{
		"CLEAR_CHALLENGE_CD_UNIT",
		"2"
	},
	{
		"AUTO_JOIN_GROUP_SIZE",
		"5"
	}
}
local t_arena_common = {
	REFRESH_CD_SEC = dataList[1],
	MAX_DAILY_REFRESH_TIME = dataList[2],
	WIN_ADD_ARENA_SCORE = dataList[3],
	LOST_ADD_ARENA_SCORE = dataList[4],
	DAILY_TASK_HOLIDAY_PRIZE_TIMES = dataList[5],
	MAX_REMAIN_BATTLE_RECORD = dataList[6],
	CHALLENGE_COUNT = dataList[7],
	ROBOT_COUNT = dataList[8],
	ROBOT_NAME_PREFIX = dataList[9],
	CLEAR_CHALLENGE_CD_UNIT = dataList[10],
	AUTO_JOIN_GROUP_SIZE = dataList[11]
}

t_arena_common.dataList = dataList

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

return t_arena_common
