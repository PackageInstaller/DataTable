-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_duo_la_mm_common.lua

module("logicconfig.config.t_duo_la_mm_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"6"
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
		"3"
	},
	{
		"EVOLVE_PET_RACE_ID",
		"10344"
	},
	{
		"EVOLVE_CONSUME",
		"4:6002:1#62:52:1"
	},
	{
		"NEED_PIECES",
		"4:89:120#4:90:120#4:91:120#4:92:120#4:93:120"
	},
	{
		"MAX_PIECE_SINGLE_GAME",
		"50"
	},
	{
		"GOODS_ID",
		"533"
	}
}
local t_duo_la_mm_common = {
	CHALLENGE_ID = dataList[1],
	GAME_PLAN_ID = dataList[2],
	GAME_BUY_TIMES_PLAN_ID = dataList[3],
	DAILY_FREE_GAME_TIMES = dataList[4],
	EVOLVE_PET_RACE_ID = dataList[5],
	EVOLVE_CONSUME = dataList[6],
	NEED_PIECES = dataList[7],
	MAX_PIECE_SINGLE_GAME = dataList[8],
	GOODS_ID = dataList[9]
}

t_duo_la_mm_common.dataList = dataList

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

return t_duo_la_mm_common
