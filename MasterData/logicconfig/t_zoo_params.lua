-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_zoo_params.lua

module("logicconfig.config.t_zoo_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_ANIMAL_NUM",
		"100"
	},
	{
		"MAX_ANIMAL_EGG_NUM",
		"100"
	},
	{
		"MAX_MATCH_TIMES",
		"10"
	},
	{
		"INVITE_PAIR_TIME",
		"30"
	},
	{
		"PAIR_TIME",
		"60"
	},
	{
		"RECYCLE_ANIMAL_GAIN",
		"4:102:100"
	},
	{
		"CHANGE_ANIMAL_NAME_COST",
		"4:101:1"
	},
	{
		"ZOO_FRUIT_ITEM",
		"4:100:1"
	},
	{
		"FEED_COST_ITEM",
		"4:100:1"
	},
	{
		"FEED_INC_EXP",
		"10"
	},
	{
		"HATCH_SPEED_UP_TIME",
		"3600"
	},
	{
		"STEAL_FRUIT_MAX_NUM",
		"50"
	},
	{
		"STEAL_FRUIT_FACTOR",
		"10"
	},
	{
		"BE_STOLEN_FRUIT_MAX_NUM",
		"30"
	},
	{
		"DAYS_PER_LOST_ANIMAL",
		"3"
	},
	{
		"MAX_LOST_ANIMAL_NUM",
		"3"
	},
	{
		"TRAVEL_MAN_NEED_ZOO_LV",
		"1"
	},
	{
		"TRAVEL_MAN_CD",
		"1800"
	},
	{
		"MAX_MORAL_VALUE",
		"999"
	},
	{
		"MIN_MORAL_VALUE",
		"0"
	},
	{
		"GOOD_ACT_INC_MORAL",
		"10"
	},
	{
		"BAD_ACT_INC_MORAL",
		"-10"
	},
	{
		"FEED_BUDDY_ANIMAL_TIMES",
		"3"
	},
	{
		"FEED_BUDDY_ANIMAL_GAIN",
		"4:29:10"
	},
	{
		"DIG_TREASURE_MAX_TIMES",
		"5"
	},
	{
		"DIG_TREASURE_GAIN",
		"8:1:10"
	},
	{
		"MAX_ABSORB_TIME",
		"1"
	},
	{
		"ABSORB_NEED_REST_HATCH_TIME",
		"30"
	},
	{
		"ABSORB_DEVICE_PRIZE",
		"4:99:1"
	},
	{
		"ABSORB_DEVICE_CD_INTERVAL",
		"60"
	},
	{
		"FIRST_OPEN_PRESENT",
		"12:1:1:1#4:99:1"
	},
	{
		"MATCH_CD_INTERVAL",
		"1"
	},
	{
		"RECYCLE_ANIMAL_NEED_LV",
		"1"
	},
	{
		"IN_ZOO_INTERACT_DAILY_NUM",
		"30"
	},
	{
		"IN_ZOO_INTERACT_PRIZE",
		"8:1:1"
	}
}
local t_zoo_params = {
	MAX_ANIMAL_NUM = dataList[1],
	MAX_ANIMAL_EGG_NUM = dataList[2],
	MAX_MATCH_TIMES = dataList[3],
	INVITE_PAIR_TIME = dataList[4],
	PAIR_TIME = dataList[5],
	RECYCLE_ANIMAL_GAIN = dataList[6],
	CHANGE_ANIMAL_NAME_COST = dataList[7],
	ZOO_FRUIT_ITEM = dataList[8],
	FEED_COST_ITEM = dataList[9],
	FEED_INC_EXP = dataList[10],
	HATCH_SPEED_UP_TIME = dataList[11],
	STEAL_FRUIT_MAX_NUM = dataList[12],
	STEAL_FRUIT_FACTOR = dataList[13],
	BE_STOLEN_FRUIT_MAX_NUM = dataList[14],
	DAYS_PER_LOST_ANIMAL = dataList[15],
	MAX_LOST_ANIMAL_NUM = dataList[16],
	TRAVEL_MAN_NEED_ZOO_LV = dataList[17],
	TRAVEL_MAN_CD = dataList[18],
	MAX_MORAL_VALUE = dataList[19],
	MIN_MORAL_VALUE = dataList[20],
	GOOD_ACT_INC_MORAL = dataList[21],
	BAD_ACT_INC_MORAL = dataList[22],
	FEED_BUDDY_ANIMAL_TIMES = dataList[23],
	FEED_BUDDY_ANIMAL_GAIN = dataList[24],
	DIG_TREASURE_MAX_TIMES = dataList[25],
	DIG_TREASURE_GAIN = dataList[26],
	MAX_ABSORB_TIME = dataList[27],
	ABSORB_NEED_REST_HATCH_TIME = dataList[28],
	ABSORB_DEVICE_PRIZE = dataList[29],
	ABSORB_DEVICE_CD_INTERVAL = dataList[30],
	FIRST_OPEN_PRESENT = dataList[31],
	MATCH_CD_INTERVAL = dataList[32],
	RECYCLE_ANIMAL_NEED_LV = dataList[33],
	IN_ZOO_INTERACT_DAILY_NUM = dataList[34],
	IN_ZOO_INTERACT_PRIZE = dataList[35]
}

t_zoo_params.dataList = dataList

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

return t_zoo_params
