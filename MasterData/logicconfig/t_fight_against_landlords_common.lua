-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fight_against_landlords_common.lua

module("logicconfig.config.t_fight_against_landlords_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_TIMES",
		"20"
	},
	{
		"MATCH_TIME",
		"120"
	},
	{
		"INIT_CARD_COUNT",
		"7"
	},
	{
		"LANDLORD_CARD_COUNT",
		"3"
	},
	{
		"DAILY_LAND_GAIN_SCORE",
		"800"
	},
	{
		"DAILY_GAIN_SCORE_LIMIT",
		"999999"
	},
	{
		"SUPPLY_GAIN_INTERVAL_TIME_SCORE",
		"20"
	},
	{
		"SUPPLY_GAIN_INTERVAL_TIME",
		"1"
	},
	{
		"SUPPLY_GAIN_INTERVAL_TIME_MAX_LIMIT",
		"60"
	},
	{
		"SUPPLY_GAIN_TIME_MAX_LIMIT",
		"60"
	},
	{
		"COIN_EXCHANGE_RATE",
		"0.1"
	},
	{
		"SURE_LANDLORD_TIME",
		"30"
	},
	{
		"FMT_TIME",
		"60"
	},
	{
		"DISTRIBUTE_CARD_TIME",
		"7"
	},
	{
		"LANDLORD_NAME",
		"领主"
	},
	{
		"FRAMER_NAME",
		"协作"
	},
	{
		"JUMP_SHOP",
		"func#191#243#243007"
	},
	{
		"MAIN_RULE_KEY",
		"doudizhu_rule"
	},
	{
		"SHOP_ACTIVITYID",
		"243007"
	},
	{
		"CP_BUFF_SWITCH",
		"false"
	},
	{
		"CARD_SET_NUM",
		"4"
	},
	{
		"DAILY_LOSE_PRIZE_TIMES",
		"10"
	}
}
local t_fight_against_landlords_common = {
	DAILY_TIMES = dataList[1],
	MATCH_TIME = dataList[2],
	INIT_CARD_COUNT = dataList[3],
	LANDLORD_CARD_COUNT = dataList[4],
	DAILY_LAND_GAIN_SCORE = dataList[5],
	DAILY_GAIN_SCORE_LIMIT = dataList[6],
	SUPPLY_GAIN_INTERVAL_TIME_SCORE = dataList[7],
	SUPPLY_GAIN_INTERVAL_TIME = dataList[8],
	SUPPLY_GAIN_INTERVAL_TIME_MAX_LIMIT = dataList[9],
	SUPPLY_GAIN_TIME_MAX_LIMIT = dataList[10],
	COIN_EXCHANGE_RATE = dataList[11],
	SURE_LANDLORD_TIME = dataList[12],
	FMT_TIME = dataList[13],
	DISTRIBUTE_CARD_TIME = dataList[14],
	LANDLORD_NAME = dataList[15],
	FRAMER_NAME = dataList[16],
	JUMP_SHOP = dataList[17],
	MAIN_RULE_KEY = dataList[18],
	SHOP_ACTIVITYID = dataList[19],
	CP_BUFF_SWITCH = dataList[20],
	CARD_SET_NUM = dataList[21],
	DAILY_LOSE_PRIZE_TIMES = dataList[22]
}

t_fight_against_landlords_common.dataList = dataList

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

return t_fight_against_landlords_common
