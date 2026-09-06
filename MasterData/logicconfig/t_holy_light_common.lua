-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_holy_light_common.lua

module("logicconfig.config.t_holy_light_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DICE",
		"10:254016"
	},
	{
		"UNIVERSAL_DICE",
		"10:254017"
	},
	{
		"FUNCTION_CARD",
		"10:254018"
	},
	{
		"FUNCTION_CARD_DICE_NUM",
		"3"
	},
	{
		"SYSTEM_PET_MAX_LEVEL",
		"8"
	},
	{
		"SYSTEM_PET_RAND_NUM",
		"4"
	},
	{
		"PROGRESS_ITEM_NUMBER",
		"254019"
	},
	{
		"RANK_PROGRESS_LIMIT",
		"40"
	},
	{
		"RANK_LIMIT",
		"200"
	},
	{
		"FUNC_ID",
		"858"
	},
	{
		"MAIN_RULE_KEY",
		"holy_light_main_rule"
	},
	{
		"MAIN_RULE2_KEY",
		"holy_light_main_rule2"
	},
	{
		"BUFF_RULE_KEY",
		"holy_light_buff_rule"
	},
	{
		"PET_SHOP_RULE_KEY",
		"holy_light_pet_shop_rule"
	},
	{
		"INIT_SYS_PET_COIN",
		"100"
	},
	{
		"SYS_PET_COIN",
		"10:254020"
	},
	{
		"SYS_PET_STEP_TO_COIN",
		"10"
	},
	{
		"MAIN_VIEW_GOLD_COINS",
		"10:254019#10:254020"
	},
	{
		"PET_SHOP_GOLD_COINS",
		"10:254020"
	},
	{
		"TASK_RED_ID",
		"470"
	},
	{
		"ACTIVITY_RED_ID",
		"471"
	},
	{
		"PASSPORT_RED_ID",
		"475"
	},
	{
		"DAILY_RED_ID",
		"c17"
	},
	{
		"PLAYER_MOVE_SPEED_RATIO",
		"0.3"
	}
}
local t_holy_light_common = {
	DICE = dataList[1],
	UNIVERSAL_DICE = dataList[2],
	FUNCTION_CARD = dataList[3],
	FUNCTION_CARD_DICE_NUM = dataList[4],
	SYSTEM_PET_MAX_LEVEL = dataList[5],
	SYSTEM_PET_RAND_NUM = dataList[6],
	PROGRESS_ITEM_NUMBER = dataList[7],
	RANK_PROGRESS_LIMIT = dataList[8],
	RANK_LIMIT = dataList[9],
	FUNC_ID = dataList[10],
	MAIN_RULE_KEY = dataList[11],
	MAIN_RULE2_KEY = dataList[12],
	BUFF_RULE_KEY = dataList[13],
	PET_SHOP_RULE_KEY = dataList[14],
	INIT_SYS_PET_COIN = dataList[15],
	SYS_PET_COIN = dataList[16],
	SYS_PET_STEP_TO_COIN = dataList[17],
	MAIN_VIEW_GOLD_COINS = dataList[18],
	PET_SHOP_GOLD_COINS = dataList[19],
	TASK_RED_ID = dataList[20],
	ACTIVITY_RED_ID = dataList[21],
	PASSPORT_RED_ID = dataList[22],
	DAILY_RED_ID = dataList[23],
	PLAYER_MOVE_SPEED_RATIO = dataList[24]
}

t_holy_light_common.dataList = dataList

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

return t_holy_light_common
