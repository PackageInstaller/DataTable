-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mahjong_battle_common.lua

module("logicconfig.config.t_mahjong_battle_common", package.seeall)

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
		"5"
	},
	{
		"ORIGIN_BLOOD",
		"3"
	},
	{
		"ORIGIN_GRANT_MAHJONG_NUM",
		"13"
	},
	{
		"MAX_CAN_HOLD_RACE_NUM",
		"10"
	},
	{
		"SINGLE_ROUND_DRAW_MAHJONG_NUM",
		"3"
	},
	{
		"DRAW_GENRE_NUM",
		"3"
	},
	{
		"REPORT_NUM_LIMIT",
		"10"
	},
	{
		"AWAKEN_LEVEL_PROPERTY_WAN_PERCENT",
		"2000"
	},
	{
		"SINGLE_MAHJONG_NUM",
		"4"
	}
}
local t_mahjong_battle_common = {
	DAILY_CLG_TIMES = dataList[1],
	END_NEED_WIN_TIMES = dataList[2],
	ORIGIN_BLOOD = dataList[3],
	ORIGIN_GRANT_MAHJONG_NUM = dataList[4],
	MAX_CAN_HOLD_RACE_NUM = dataList[5],
	SINGLE_ROUND_DRAW_MAHJONG_NUM = dataList[6],
	DRAW_GENRE_NUM = dataList[7],
	REPORT_NUM_LIMIT = dataList[8],
	AWAKEN_LEVEL_PROPERTY_WAN_PERCENT = dataList[9],
	SINGLE_MAHJONG_NUM = dataList[10]
}

t_mahjong_battle_common.dataList = dataList

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

return t_mahjong_battle_common
