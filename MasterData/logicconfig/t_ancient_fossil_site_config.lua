-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ancient_fossil_site_config.lua

module("logicconfig.config.t_ancient_fossil_site_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_MAX_PLAY_TIMES",
		"3"
	},
	{
		"MAX_STEP_PER_GAME",
		"20"
	},
	{
		"PRIZE_TYPE",
		"8:1"
	},
	{
		"PRIZE_LIMIT",
		"100000"
	},
	{
		"PRIZE_RATIO",
		"100"
	}
}
local t_ancient_fossil_site_config = {
	DAILY_MAX_PLAY_TIMES = dataList[1],
	MAX_STEP_PER_GAME = dataList[2],
	PRIZE_TYPE = dataList[3],
	PRIZE_LIMIT = dataList[4],
	PRIZE_RATIO = dataList[5]
}

t_ancient_fossil_site_config.dataList = dataList

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

return t_ancient_fossil_site_config
