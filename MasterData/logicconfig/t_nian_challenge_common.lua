-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_nian_challenge_common.lua

module("logicconfig.config.t_nian_challenge_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_ID",
		"23"
	},
	{
		"VIP_LEVEL_LIMIT",
		"1"
	},
	{
		"VIP_BUY_TIMES_COST",
		"105:1:1"
	},
	{
		"VIP_BUY_TIMES_LIMIT",
		"3"
	},
	{
		"DAILY_FREE_TIMES",
		"3"
	},
	{
		"PET_GROWTH_PATH_ACTIVITY_ID",
		"76003"
	},
	{
		"TRIAL_CHALLENGE_ID",
		"25"
	},
	{
		"RANK_PET_RACE_ID",
		"11000"
	}
}
local t_nian_challenge_common = {
	CHALLENGE_ID = dataList[1],
	VIP_LEVEL_LIMIT = dataList[2],
	VIP_BUY_TIMES_COST = dataList[3],
	VIP_BUY_TIMES_LIMIT = dataList[4],
	DAILY_FREE_TIMES = dataList[5],
	PET_GROWTH_PATH_ACTIVITY_ID = dataList[6],
	TRIAL_CHALLENGE_ID = dataList[7],
	RANK_PET_RACE_ID = dataList[8]
}

t_nian_challenge_common.dataList = dataList

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

return t_nian_challenge_common
