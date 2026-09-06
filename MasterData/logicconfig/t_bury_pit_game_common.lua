-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_bury_pit_game_common.lua

module("logicconfig.config.t_bury_pit_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_FREE_GAME_TIMES",
		"2"
	},
	{
		"MAX_SCORE",
		"1020"
	},
	{
		"MAX_SPECIAL_PRIZE_COUNT",
		"50"
	},
	{
		"RANK_THRESHOLD",
		"500"
	},
	{
		"t2",
		"10"
	},
	{
		"t3",
		"5"
	},
	{
		"t4",
		"45"
	},
	{
		"t5",
		"5"
	}
}
local t_bury_pit_game_common = {
	DAILY_FREE_GAME_TIMES = dataList[1],
	MAX_SCORE = dataList[2],
	MAX_SPECIAL_PRIZE_COUNT = dataList[3],
	RANK_THRESHOLD = dataList[4],
	t2 = dataList[5],
	t3 = dataList[6],
	t4 = dataList[7],
	t5 = dataList[8]
}

t_bury_pit_game_common.dataList = dataList

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

return t_bury_pit_game_common
