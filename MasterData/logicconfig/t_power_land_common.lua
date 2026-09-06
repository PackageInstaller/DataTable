-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_power_land_common.lua

module("logicconfig.config.t_power_land_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"INITIAL_PET_REFRESH_COUNT",
		"5"
	},
	{
		"INITIAL_PET_SELECTION_COUNT",
		"5"
	},
	{
		"SELECT_PET_COUNT",
		"3"
	},
	{
		"REFRESH_SHOP_COST",
		"3"
	},
	{
		"SHOP_PET_COUNT",
		"9"
	},
	{
		"START_GAME_TIME",
		"2"
	},
	{
		"DAILY_GAME_TIME",
		"1"
	},
	{
		"WEEKLY_GAME_TIME",
		"7"
	},
	{
		"TOTAL_GAME_TIME",
		"7"
	},
	{
		"SHOW_ITEM",
		"1004:1211"
	},
	{
		"RULE_TIPS_KEY",
		"powerland_rule"
	},
	{
		"HOME_VIEW_BOTTOM_TIPS",
		"活动期间每天增加1次挑战次数，每周增加次数上限为7次，活动期间最多可存储7次挑战。"
	},
	{
		"AwardDes",
		"可获得:淬源晶石、随机金色星神碎片、神唤券"
	},
	{
		"SHOP_JUMP",
		"func#191#156#156004"
	}
}
local t_power_land_common = {
	INITIAL_PET_REFRESH_COUNT = dataList[1],
	INITIAL_PET_SELECTION_COUNT = dataList[2],
	SELECT_PET_COUNT = dataList[3],
	REFRESH_SHOP_COST = dataList[4],
	SHOP_PET_COUNT = dataList[5],
	START_GAME_TIME = dataList[6],
	DAILY_GAME_TIME = dataList[7],
	WEEKLY_GAME_TIME = dataList[8],
	TOTAL_GAME_TIME = dataList[9],
	SHOW_ITEM = dataList[10],
	RULE_TIPS_KEY = dataList[11],
	HOME_VIEW_BOTTOM_TIPS = dataList[12],
	AwardDes = dataList[13],
	SHOP_JUMP = dataList[14]
}

t_power_land_common.dataList = dataList

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

return t_power_land_common
