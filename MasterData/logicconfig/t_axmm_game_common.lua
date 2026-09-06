-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_axmm_game_common.lua

module("logicconfig.config.t_axmm_game_common", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"CHALLENGE_CURRENCY",
		"10:281004"
	},
	{
		"RANK_FUNC",
		"func#618#11007"
	},
	{
		"POOL_FUNC",
		"ui#publicdragontabview#2#4"
	},
	{
		"SCENE_MOVE_SPEED",
		"350"
	},
	{
		"SCENE_MOVE_SPEED_MAX",
		"600"
	},
	{
		"INTO_MAX_SPEED_TIME",
		"50"
	},
	{
		"WY_INIT_POWER",
		"50"
	},
	{
		"FBB_INIT_POWER",
		"18"
	},
	{
		"WY_INIT_RATIO",
		"20"
	},
	{
		"WY_MOVE_SPEED",
		"450"
	},
	{
		"WARINING_TIP_SLOT",
		"261"
	},
	{
		"BATTLE_SLOT",
		"272"
	},
	{
		"WARNING_TIME",
		"1.8"
	},
	{
		"EVERY_HIT_TIME",
		"1"
	},
	{
		"EVERY_HIT_REDUCE_HP_RATIO",
		"10"
	}
}
local t_axmm_game_common = {
	CHALLENGE_CURRENCY = dataList[1],
	RANK_FUNC = dataList[2],
	POOL_FUNC = dataList[3],
	SCENE_MOVE_SPEED = dataList[4],
	SCENE_MOVE_SPEED_MAX = dataList[5],
	INTO_MAX_SPEED_TIME = dataList[6],
	WY_INIT_POWER = dataList[7],
	FBB_INIT_POWER = dataList[8],
	WY_INIT_RATIO = dataList[9],
	WY_MOVE_SPEED = dataList[10],
	WARINING_TIP_SLOT = dataList[11],
	BATTLE_SLOT = dataList[12],
	WARNING_TIME = dataList[13],
	EVERY_HIT_TIME = dataList[14],
	EVERY_HIT_REDUCE_HP_RATIO = dataList[15]
}

t_axmm_game_common.dataList = dataList

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

return t_axmm_game_common
