-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_params.lua

module("logicconfig.config.t_timed_challenge_miya_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_PRIZE",
		"4:86:50"
	},
	{
		"RE_RANDOM_MODE_COST",
		"105:157:50"
	},
	{
		"DAILY_CHALLENGE_TIMES",
		"5"
	},
	{
		"PET_RANK_THRESHOLD",
		"9999"
	},
	{
		"PET_RANK_PRIZE",
		"14:9:1"
	},
	{
		"VIP_DAILY_TIMES",
		"7"
	},
	{
		"WORLD_ZDL_MOD_DAYS",
		"999"
	},
	{
		"FIND_FAULT_SUB_SEC",
		"1"
	},
	{
		"CLICK_CD",
		"0.2"
	},
	{
		"GOODS_ID",
		"529"
	}
}
local t_timed_challenge_miya_params = {
	DAILY_PRIZE = dataList[1],
	RE_RANDOM_MODE_COST = dataList[2],
	DAILY_CHALLENGE_TIMES = dataList[3],
	PET_RANK_THRESHOLD = dataList[4],
	PET_RANK_PRIZE = dataList[5],
	VIP_DAILY_TIMES = dataList[6],
	WORLD_ZDL_MOD_DAYS = dataList[7],
	FIND_FAULT_SUB_SEC = dataList[8],
	CLICK_CD = dataList[9],
	GOODS_ID = dataList[10]
}

t_timed_challenge_miya_params.dataList = dataList

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

return t_timed_challenge_miya_params
