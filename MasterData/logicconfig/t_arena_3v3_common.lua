-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_arena_3v3_common.lua

module("logicconfig.config.t_arena_3v3_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MEMBER_LIMIT",
		"100000"
	},
	{
		"COPY_PLAYER_DATA",
		"[5001,15000]"
	},
	{
		"SETTLE_BEGIN_TIME",
		"22:00:00"
	},
	{
		"SETTLE_END_TIME",
		"22:20:00"
	},
	{
		"CHALLENGE_USE",
		"703"
	},
	{
		"CHALLENGE_USE_LIMIT",
		"5"
	},
	{
		"REFRESH_CD",
		"5"
	},
	{
		"INIT_SCORE",
		"1000"
	},
	{
		"RATIO",
		"50"
	},
	{
		"AUTO_JOIN_GROUP_SIZE",
		"1"
	},
	{
		"CHALLENGE_TARGET_TIME",
		"5"
	},
	{
		"HANG_UP_UPPER_LIMIT",
		"5000"
	},
	{
		"HANG_UP_TIME",
		"3600"
	},
	{
		"HANG_UP_PRIZE_TYPE",
		"16"
	},
	{
		"HANG_UP_PRIZE_RED_POINT_RATIO",
		"0.8"
	}
}
local t_arena_3v3_common = {
	MEMBER_LIMIT = dataList[1],
	COPY_PLAYER_DATA = dataList[2],
	SETTLE_BEGIN_TIME = dataList[3],
	SETTLE_END_TIME = dataList[4],
	CHALLENGE_USE = dataList[5],
	CHALLENGE_USE_LIMIT = dataList[6],
	REFRESH_CD = dataList[7],
	INIT_SCORE = dataList[8],
	RATIO = dataList[9],
	AUTO_JOIN_GROUP_SIZE = dataList[10],
	CHALLENGE_TARGET_TIME = dataList[11],
	HANG_UP_UPPER_LIMIT = dataList[12],
	HANG_UP_TIME = dataList[13],
	HANG_UP_PRIZE_TYPE = dataList[14],
	HANG_UP_PRIZE_RED_POINT_RATIO = dataList[15]
}

t_arena_3v3_common.dataList = dataList

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

return t_arena_3v3_common
