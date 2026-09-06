-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summer_treasure_snatch_common.lua

module("logicconfig.config.t_summer_treasure_snatch_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CAMP_MAX_POWER_DIFFERENCE",
		"2000000"
	},
	{
		"DAILY_PVP_TIMES",
		"3"
	},
	{
		"DAILY_BOSS_CLG_FREE_TIMES",
		"3"
	},
	{
		"REMAIN_BUY_BOSS_TIMES_REFUND_PERCENT",
		"50"
	},
	{
		"PRESET_FORMATION_NUM",
		"3"
	},
	{
		"WEEK_ADVANCE_SETTLE_HOURS",
		"5"
	}
}
local t_summer_treasure_snatch_common = {
	CAMP_MAX_POWER_DIFFERENCE = dataList[1],
	DAILY_PVP_TIMES = dataList[2],
	DAILY_BOSS_CLG_FREE_TIMES = dataList[3],
	REMAIN_BUY_BOSS_TIMES_REFUND_PERCENT = dataList[4],
	PRESET_FORMATION_NUM = dataList[5],
	WEEK_ADVANCE_SETTLE_HOURS = dataList[6]
}

t_summer_treasure_snatch_common.dataList = dataList

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

return t_summer_treasure_snatch_common
