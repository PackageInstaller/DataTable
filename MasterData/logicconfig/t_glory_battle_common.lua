-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_glory_battle_common.lua

module("logicconfig.config.t_glory_battle_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_CLG_TIMES",
		"5"
	},
	{
		"END_NEED_WIN_TIMES",
		"9"
	},
	{
		"ORIGIN_BLOOD",
		"3"
	},
	{
		"INIT_MATCH_SCORE",
		"5"
	},
	{
		"BUY_TIMES_LIMIT",
		"3"
	},
	{
		"BUY_TIMES_COST",
		"8:1:10000000"
	},
	{
		"DRAW_GENRE_NUM",
		"3"
	},
	{
		"FIXED_GENRE_CURRENCY_NUM",
		"80"
	},
	{
		"RANDOM_GENRE_CURRENCY_NUM",
		"100"
	},
	{
		"SHOP_BLOCK_NUM",
		"8"
	},
	{
		"REFRESH_SHOP_COST",
		"5"
	},
	{
		"ORIGIN_SHOP_PET_NUM",
		"3"
	},
	{
		"UPGRADE_PET_GAIN_CUTE_PET_EXPERIENCE",
		"1"
	},
	{
		"CUTE_PET_UPGRADE_CARD_EXPERIENCE",
		"4"
	},
	{
		"BATTLE_GAIN_CUTE_PET_EXPERIENCE",
		"4"
	},
	{
		"PET_UPGRADE_CARD_INC_AWAKEN_LEVEL",
		"1"
	},
	{
		"GAIN_SAME_PET_INC_AWAKEN_LEVEL",
		"1"
	},
	{
		"SALE_PET_GAIN_CURRENCY_PERCENT",
		"5"
	},
	{
		"RANDOM_PET_NUM",
		"3"
	},
	{
		"GIVE_UP_DEC_SCORE",
		"0"
	},
	{
		"NEWLY_FIELD_GAIN_CURRENCY",
		"10"
	},
	{
		"REPORT_NUM_LIMIT",
		"10"
	},
	{
		"DRAW_ATTRIBUTE_PET_NUM",
		"3"
	},
	{
		"ORIGIN_HIDDEN_SCORE",
		"50"
	},
	{
		"STANDARD_VALUE",
		"10"
	},
	{
		"AWAKEN_LEVEL_PROPERTY_WAN_PERCENT",
		"2000"
	},
	{
		"FORMATION_LIMIT_NUM",
		"5"
	},
	{
		"ONE_STEP_TIME",
		"30"
	},
	{
		"SHOP_COST_MAT",
		"1004:1590:1"
	}
}
local t_glory_battle_common = {
	DAILY_CLG_TIMES = dataList[1],
	END_NEED_WIN_TIMES = dataList[2],
	ORIGIN_BLOOD = dataList[3],
	INIT_MATCH_SCORE = dataList[4],
	BUY_TIMES_LIMIT = dataList[5],
	BUY_TIMES_COST = dataList[6],
	DRAW_GENRE_NUM = dataList[7],
	FIXED_GENRE_CURRENCY_NUM = dataList[8],
	RANDOM_GENRE_CURRENCY_NUM = dataList[9],
	SHOP_BLOCK_NUM = dataList[10],
	REFRESH_SHOP_COST = dataList[11],
	ORIGIN_SHOP_PET_NUM = dataList[12],
	UPGRADE_PET_GAIN_CUTE_PET_EXPERIENCE = dataList[13],
	CUTE_PET_UPGRADE_CARD_EXPERIENCE = dataList[14],
	BATTLE_GAIN_CUTE_PET_EXPERIENCE = dataList[15],
	PET_UPGRADE_CARD_INC_AWAKEN_LEVEL = dataList[16],
	GAIN_SAME_PET_INC_AWAKEN_LEVEL = dataList[17],
	SALE_PET_GAIN_CURRENCY_PERCENT = dataList[18],
	RANDOM_PET_NUM = dataList[19],
	GIVE_UP_DEC_SCORE = dataList[20],
	NEWLY_FIELD_GAIN_CURRENCY = dataList[21],
	REPORT_NUM_LIMIT = dataList[22],
	DRAW_ATTRIBUTE_PET_NUM = dataList[23],
	ORIGIN_HIDDEN_SCORE = dataList[24],
	STANDARD_VALUE = dataList[25],
	AWAKEN_LEVEL_PROPERTY_WAN_PERCENT = dataList[26],
	FORMATION_LIMIT_NUM = dataList[27],
	ONE_STEP_TIME = dataList[28],
	SHOP_COST_MAT = dataList[29]
}

t_glory_battle_common.dataList = dataList

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

return t_glory_battle_common
