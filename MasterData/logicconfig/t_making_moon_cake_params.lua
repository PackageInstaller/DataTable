-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_making_moon_cake_params.lua

module("logicconfig.config.t_making_moon_cake_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"DAILY_TIMES",
		"3"
	},
	{
		"GAME_TIME",
		"60"
	},
	{
		"MATERIAL_SCORE",
		"2"
	},
	{
		"MAX_MATERIAL_NUM",
		"12"
	},
	{
		"BUBBLE_RANGE",
		"4"
	},
	{
		"QUALITY_FACTOR",
		"4"
	},
	{
		"QUALITY_PERCENTAGE",
		"80"
	},
	{
		"MAX_SCORE",
		"9999"
	},
	{
		"SCORE_PRIZE",
		"8:1:100"
	},
	{
		"PROGRESS_NAME",
		"秩序#永恒#无烬#真龙"
	},
	{
		"PROGRESS_REWARD",
		"60:1:1200#8:1:2000000"
	},
	{
		"PROGRESS_SELECT_PET",
		"board_tangyuandasai_juese02#board_tangyuandasai_juese04#board_tangyuandasai_juese01#board_tangyuandasai_juese03"
	},
	{
		"PROGRESS_SELECT_PET_NAME",
		"秩序#永恒#无烬#真龙"
	},
	{
		"PROGRESS_AUTO_SCORE",
		"36"
	}
}
local t_making_moon_cake_params = {
	DAILY_TIMES = dataList[1],
	GAME_TIME = dataList[2],
	MATERIAL_SCORE = dataList[3],
	MAX_MATERIAL_NUM = dataList[4],
	BUBBLE_RANGE = dataList[5],
	QUALITY_FACTOR = dataList[6],
	QUALITY_PERCENTAGE = dataList[7],
	MAX_SCORE = dataList[8],
	SCORE_PRIZE = dataList[9],
	PROGRESS_NAME = dataList[10],
	PROGRESS_REWARD = dataList[11],
	PROGRESS_SELECT_PET = dataList[12],
	PROGRESS_SELECT_PET_NAME = dataList[13],
	PROGRESS_AUTO_SCORE = dataList[14]
}

t_making_moon_cake_params.dataList = dataList

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

return t_making_moon_cake_params
