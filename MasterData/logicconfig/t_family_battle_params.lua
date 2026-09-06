-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_battle_params.lua

module("logicconfig.config.t_family_battle_params", package.seeall)

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
		"5"
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
		"NEST_ATTACK_TIMES_LIMIT",
		"2"
	},
	{
		"DIVINE_PILLAR_ATTACK_TIMES_LIMIT",
		"2"
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
		"PILLAR_WORN_STATE",
		"1800,2500"
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
	}
}
local t_family_battle_params = {
	FAMILY_LEVEL_LIMIT = dataList[1],
	MEMBER_NUM_LIMIT = dataList[2],
	GROUP_SCOPE = dataList[3],
	EACH_GROUP_NUM = dataList[4],
	HP_INCREASE_NUM = dataList[5],
	HP_INCREASE_RATE = dataList[6],
	NEST_ATTACK_TIMES_LIMIT = dataList[7],
	DIVINE_PILLAR_ATTACK_TIMES_LIMIT = dataList[8],
	REPORT_NUM_LIMIT = dataList[9],
	USER_RANK_NUM_LIMIT = dataList[10],
	FAMILY_INIT_ENERGY = dataList[11],
	DIVINE_PILLAR_LAST_TIER_NUM = dataList[12],
	DIVINE_PILLAR_NEXT_TIER_NUM = dataList[13],
	DIVINE_PILLAR_TIER_NUM = dataList[14],
	PILLAR_WORN_STATE = dataList[15],
	SEASON_BADGE_STATE = dataList[16],
	AUTO_REGISTER_RECENT_LOGIN_DAYS = dataList[17],
	AUTO_REGISTER_FAMILY_LEVEL_LIMIT = dataList[18],
	AUTO_REGISTER_MEMBER_COUNT_LIMIT = dataList[19],
	BATCH_REGISTER_PLAYER_THRESHOLD = dataList[20]
}

t_family_battle_params.dataList = dataList

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

return t_family_battle_params
