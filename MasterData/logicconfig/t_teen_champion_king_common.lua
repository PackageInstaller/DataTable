-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teen_champion_king_common.lua

module("logicconfig.config.t_teen_champion_king_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"QUALIFIER_RANK_SHOW_COUNT",
		"350"
	},
	{
		"KNOCKOUT_BATTLE_START_TIME",
		"300"
	},
	{
		"KNOCKOUT_BATTLE_OVER_TIME",
		"240"
	},
	{
		"RACE_STATIC_RANK_VIEW_COUNT",
		"30"
	},
	{
		"MATCH_OPEN_TIME",
		"10:00-24:00"
	},
	{
		"MAX_MATCH_SEC",
		"30"
	},
	{
		"CHAMPION_SCORE_ROUND_NAME",
		"冠军积分赛"
	}
}
local t_teen_champion_king_common = {
	QUALIFIER_RANK_SHOW_COUNT = dataList[1],
	KNOCKOUT_BATTLE_START_TIME = dataList[2],
	KNOCKOUT_BATTLE_OVER_TIME = dataList[3],
	RACE_STATIC_RANK_VIEW_COUNT = dataList[4],
	MATCH_OPEN_TIME = dataList[5],
	MAX_MATCH_SEC = dataList[6],
	CHAMPION_SCORE_ROUND_NAME = dataList[7]
}

t_teen_champion_king_common.dataList = dataList

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

return t_teen_champion_king_common
