-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ling_wen_common.lua

module("logicconfig.config.t_ling_wen_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MULTIPLY_TIME",
		"2026-08-07 04:59:58#2026-08-14 04:59:57"
	},
	{
		"GROUP_TIP",
		"队伍中有好友（含跨服）可享受奖励加成"
	},
	{
		"GROUP_COUNT_DOWN",
		"10"
	},
	{
		"MAIL_ID",
		"10"
	},
	{
		"RULE",
		"holystripecopyrule"
	},
	{
		"FUNC_ID",
		"611"
	},
	{
		"GAME_TIME_STORAGE",
		"30"
	},
	{
		"DAILY_RECOVER_GAME_TIME",
		"8"
	},
	{
		"MULTIPLY_GAME_TIME",
		"20"
	},
	{
		"PLAY_TIME_RULE",
		"holystripecopyrule_Times"
	},
	{
		"SINGLE_GAME_TIME",
		"3"
	},
	{
		"GROUP_GAME_TIME",
		"4"
	},
	{
		"MULTIPLY_SINGLE_GAME_TIME",
		"6"
	},
	{
		"MULTIPLY_GROUP_GAME_TIME",
		"8"
	},
	{
		"SINGLE_GAME_TIME_STORAGE",
		"9"
	},
	{
		"GROUP_GAME_TIME_STORAGE",
		"12"
	}
}
local t_ling_wen_common = {
	MULTIPLY_TIME = dataList[1],
	GROUP_TIP = dataList[2],
	GROUP_COUNT_DOWN = dataList[3],
	MAIL_ID = dataList[4],
	RULE = dataList[5],
	FUNC_ID = dataList[6],
	GAME_TIME_STORAGE = dataList[7],
	DAILY_RECOVER_GAME_TIME = dataList[8],
	MULTIPLY_GAME_TIME = dataList[9],
	PLAY_TIME_RULE = dataList[10],
	SINGLE_GAME_TIME = dataList[11],
	GROUP_GAME_TIME = dataList[12],
	MULTIPLY_SINGLE_GAME_TIME = dataList[13],
	MULTIPLY_GROUP_GAME_TIME = dataList[14],
	SINGLE_GAME_TIME_STORAGE = dataList[15],
	GROUP_GAME_TIME_STORAGE = dataList[16]
}

t_ling_wen_common.dataList = dataList

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

return t_ling_wen_common
