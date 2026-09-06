-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_an_hei_mm_challenge_common.lua

module("logicconfig.config.t_an_hei_mm_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"8"
	},
	{
		"DAILY_PRIZE",
		"4:94:50"
	},
	{
		"RE_RANDOM_RULE_COST",
		"105:167:50"
	},
	{
		"DAILY_FREE_TIMES",
		"5"
	},
	{
		"PET_RANK_PRIZE",
		"14:13:1"
	},
	{
		"PET_RANK_LIMIT",
		"9999"
	},
	{
		"EVOLVE_PET_RACE_ID",
		"10344"
	},
	{
		"EXTRA_PRIZE",
		"62:51:1"
	},
	{
		"GOODS_ID",
		"532"
	}
}
local t_an_hei_mm_challenge_common = {
	CHALLENGE_ID = dataList[1],
	DAILY_PRIZE = dataList[2],
	RE_RANDOM_RULE_COST = dataList[3],
	DAILY_FREE_TIMES = dataList[4],
	PET_RANK_PRIZE = dataList[5],
	PET_RANK_LIMIT = dataList[6],
	EVOLVE_PET_RACE_ID = dataList[7],
	EXTRA_PRIZE = dataList[8],
	GOODS_ID = dataList[9]
}

t_an_hei_mm_challenge_common.dataList = dataList

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

return t_an_hei_mm_challenge_common
