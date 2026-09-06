-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_game_collection_params.lua

module("logicconfig.config.t_game_collection_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_MAX_PLAY_TIMES",
		"3"
	},
	{
		"DAILY_MAX_BUY_TIMES",
		"10"
	},
	{
		"BUY_TIMES_COST",
		"8:2:100"
	},
	{
		"GAME_PRIZE",
		"8:1:1"
	},
	{
		"SX_MAX_STEP_PER_GAME",
		"20"
	},
	{
		"SX_DAILY_MAX_TIMES",
		"3"
	},
	{
		"SX_SPECIAL_AWARD",
		"4:90284:1"
	},
	{
		"SX_SPECIAL_AWARDTXT",
		"累计5300积分\\可获得圣骑神器自选+圣骑传说魂自选+1200体力"
	},
	{
		"SX_GIFT_BAG",
		"11001"
	},
	{
		"SX_GIFT_BAG_TXT",
		"获得星神"
	},
	{
		"SX_AWARD_TXT",
		"分数达到 %s/%s \n 可领取奖励"
	},
	{
		"SX_AWARD_LAST_TXT",
		"已解锁全部奖励"
	}
}
local t_game_collection_params = {
	DAILY_MAX_PLAY_TIMES = dataList[1],
	DAILY_MAX_BUY_TIMES = dataList[2],
	BUY_TIMES_COST = dataList[3],
	GAME_PRIZE = dataList[4],
	SX_MAX_STEP_PER_GAME = dataList[5],
	SX_DAILY_MAX_TIMES = dataList[6],
	SX_SPECIAL_AWARD = dataList[7],
	SX_SPECIAL_AWARDTXT = dataList[8],
	SX_GIFT_BAG = dataList[9],
	SX_GIFT_BAG_TXT = dataList[10],
	SX_AWARD_TXT = dataList[11],
	SX_AWARD_LAST_TXT = dataList[12]
}

t_game_collection_params.dataList = dataList

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

return t_game_collection_params
