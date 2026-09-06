-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_new_family_battle_params.lua

module("logicconfig.config.t_new_family_battle_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"FAMILY_LEVEL_LIMIT",
		"1"
	},
	{
		"MEMBER_NUM_LIMIT",
		"1"
	},
	{
		"GROUP_SCOPE",
		"25"
	},
	{
		"EACH_GROUP_NUM",
		"4"
	},
	{
		"HP_INCREASE_NUM",
		"0"
	},
	{
		"HP_INCREASE_RATE",
		"12"
	},
	{
		"REPORT_NUM_LIMIT",
		"20"
	},
	{
		"USER_RANK_NUM_LIMIT",
		"50"
	},
	{
		"FAMILY_INIT_ENERGY",
		"2000"
	},
	{
		"DIVINE_PILLAR_LAST_TIER_NUM",
		"0"
	},
	{
		"DIVINE_PILLAR_NEXT_TIER_NUM",
		"1"
	},
	{
		"DIVINE_PILLAR_TIER_NUM",
		"20"
	},
	{
		"SEASON_BADGE_STATE",
		"200,150,100,50"
	},
	{
		"AUTO_REGISTER_RECENT_LOGIN_DAYS",
		"2"
	},
	{
		"AUTO_REGISTER_FAMILY_LEVEL_LIMIT",
		"5"
	},
	{
		"AUTO_REGISTER_MEMBER_COUNT_LIMIT",
		"30"
	},
	{
		"BATCH_REGISTER_PLAYER_THRESHOLD",
		"5000"
	},
	{
		"ENERGY_INCREASE_RATE",
		"1"
	},
	{
		"RANK_MAX_NUM",
		"1000"
	},
	{
		"BEAT_FORM_FORM_INC_ENERGY",
		"500"
	},
	{
		"ZONE_RANK_VIEW",
		"100"
	}
}
local t_new_family_battle_params = {
	FAMILY_LEVEL_LIMIT = dataList[1],
	MEMBER_NUM_LIMIT = dataList[2],
	GROUP_SCOPE = dataList[3],
	EACH_GROUP_NUM = dataList[4],
	HP_INCREASE_NUM = dataList[5],
	HP_INCREASE_RATE = dataList[6],
	REPORT_NUM_LIMIT = dataList[7],
	USER_RANK_NUM_LIMIT = dataList[8],
	FAMILY_INIT_ENERGY = dataList[9],
	DIVINE_PILLAR_LAST_TIER_NUM = dataList[10],
	DIVINE_PILLAR_NEXT_TIER_NUM = dataList[11],
	DIVINE_PILLAR_TIER_NUM = dataList[12],
	SEASON_BADGE_STATE = dataList[13],
	AUTO_REGISTER_RECENT_LOGIN_DAYS = dataList[14],
	AUTO_REGISTER_FAMILY_LEVEL_LIMIT = dataList[15],
	AUTO_REGISTER_MEMBER_COUNT_LIMIT = dataList[16],
	BATCH_REGISTER_PLAYER_THRESHOLD = dataList[17],
	ENERGY_INCREASE_RATE = dataList[18],
	RANK_MAX_NUM = dataList[19],
	BEAT_FORM_FORM_INC_ENERGY = dataList[20],
	ZONE_RANK_VIEW = dataList[21]
}

t_new_family_battle_params.dataList = dataList

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

return t_new_family_battle_params
