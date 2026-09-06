-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_long_nv_challenge_common.lua

module("logicconfig.config.t_long_nv_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"16"
	},
	{
		"PRE_CHALLENGE_ID",
		"15"
	},
	{
		"OPEN_TIME",
		"09:00:00#23:59:59,00:00:00#05:00:00"
	},
	{
		"SPACE_LIMIT",
		"500"
	},
	{
		"PASS_PRIZE",
		"100:10345:1:1#62:55:1"
	},
	{
		"RANK_SIZE",
		"5999"
	},
	{
		"RANK_PRIZE",
		"14:31:1"
	},
	{
		"FREE_CHALLENGE_TIMES",
		"20"
	},
	{
		"CHALLENGE_PRIZE",
		"104:2:5"
	},
	{
		"CHALLENGE_PRIZE_LIMIT",
		"5"
	},
	{
		"JUMP_ITEM",
		"100:10345"
	},
	{
		"JUMP_FUNC_ID",
		"mibao#Skin"
	}
}
local t_long_nv_challenge_common = {
	CHALLENGE_ID = dataList[1],
	PRE_CHALLENGE_ID = dataList[2],
	OPEN_TIME = dataList[3],
	SPACE_LIMIT = dataList[4],
	PASS_PRIZE = dataList[5],
	RANK_SIZE = dataList[6],
	RANK_PRIZE = dataList[7],
	FREE_CHALLENGE_TIMES = dataList[8],
	CHALLENGE_PRIZE = dataList[9],
	CHALLENGE_PRIZE_LIMIT = dataList[10],
	JUMP_ITEM = dataList[11],
	JUMP_FUNC_ID = dataList[12]
}

t_long_nv_challenge_common.dataList = dataList

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

return t_long_nv_challenge_common
