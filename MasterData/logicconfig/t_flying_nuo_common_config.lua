-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_flying_nuo_common_config.lua

module("logicconfig.config.t_flying_nuo_common_config", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_GAME_TIMES",
		"3"
	},
	{
		"RELIVE_CONSUMES",
		"105:153:20,105:153:20"
	},
	{
		"MIN_RANK_SCORE",
		"500"
	},
	{
		"SCORE_EXCHANGE",
		"5"
	},
	{
		"GRAVITY",
		"0.9"
	},
	{
		"JUMP_FORE",
		"12"
	},
	{
		"PIPE_SPEED",
		"400"
	},
	{
		"PIPE_A",
		"4"
	},
	{
		"PIPE_MAX_SPEED",
		"2000"
	},
	{
		"SAFE_DISTANCE",
		"500"
	},
	{
		"HP",
		"3"
	},
	{
		"PIPE_HEIFHT",
		"850"
	},
	{
		"PIPE_OFFSET",
		"[-150,150]"
	},
	{
		"PIPE_SPACE",
		"380"
	},
	{
		"WUDI_FLY_TIME",
		"3"
	},
	{
		"ITEM_SCORE",
		"5,10,15"
	},
	{
		"HP_ITEM_PR",
		"5"
	},
	{
		"SCORE_ITEM_PR",
		"10"
	},
	{
		"HP_ITEM_COUNT",
		"3"
	},
	{
		"SCORE_ITEM_COUNT",
		"3"
	},
	{
		"BG_MOVE_SPEED",
		"0"
	}
}
local t_flying_nuo_common_config = {
	MAX_GAME_TIMES = dataList[1],
	RELIVE_CONSUMES = dataList[2],
	MIN_RANK_SCORE = dataList[3],
	SCORE_EXCHANGE = dataList[4],
	GRAVITY = dataList[5],
	JUMP_FORE = dataList[6],
	PIPE_SPEED = dataList[7],
	PIPE_A = dataList[8],
	PIPE_MAX_SPEED = dataList[9],
	SAFE_DISTANCE = dataList[10],
	HP = dataList[11],
	PIPE_HEIFHT = dataList[12],
	PIPE_OFFSET = dataList[13],
	PIPE_SPACE = dataList[14],
	WUDI_FLY_TIME = dataList[15],
	ITEM_SCORE = dataList[16],
	HP_ITEM_PR = dataList[17],
	SCORE_ITEM_PR = dataList[18],
	HP_ITEM_COUNT = dataList[19],
	SCORE_ITEM_COUNT = dataList[20],
	BG_MOVE_SPEED = dataList[21]
}

t_flying_nuo_common_config.dataList = dataList

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

return t_flying_nuo_common_config
