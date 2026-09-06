-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_team_play_common_config.lua

module("logicconfig.config.t_team_play_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"SIEGE_PLAY_TIMES",
		"3"
	},
	{
		"SEASON_PLAY_TIMES",
		"3"
	},
	{
		"BOSS_PRACTICE_TIMES",
		"1"
	},
	{
		"PLAY_CONSUME_STRENGTH",
		"5"
	},
	{
		"START_TIME",
		"10:00:00"
	},
	{
		"END_TIME",
		"22:00:00"
	},
	{
		"BALANCE_TIME",
		"22:30:00"
	},
	{
		"INNER_TOP_SIZE",
		"3"
	},
	{
		"FAMILY_TOP_SIZE",
		"1000"
	},
	{
		"FAMILY_VIEW_SIZE",
		"100"
	},
	{
		"PET_LEVEL_LIMIT",
		"50"
	},
	{
		"UNSEAL_TIME",
		"23:00:00"
	},
	{
		"FAMILY_ZONE_TOP_SIZE",
		"2000"
	}
}
local t_team_play_common_config = {
	SIEGE_PLAY_TIMES = dataList[1],
	SEASON_PLAY_TIMES = dataList[2],
	BOSS_PRACTICE_TIMES = dataList[3],
	PLAY_CONSUME_STRENGTH = dataList[4],
	START_TIME = dataList[5],
	END_TIME = dataList[6],
	BALANCE_TIME = dataList[7],
	INNER_TOP_SIZE = dataList[8],
	FAMILY_TOP_SIZE = dataList[9],
	FAMILY_VIEW_SIZE = dataList[10],
	PET_LEVEL_LIMIT = dataList[11],
	UNSEAL_TIME = dataList[12],
	FAMILY_ZONE_TOP_SIZE = dataList[13]
}

t_team_play_common_config.dataList = dataList

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

return t_team_play_common_config
