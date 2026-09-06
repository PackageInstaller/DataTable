-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_animals_params.lua

module("logicconfig.config.t_animals_params", package.seeall)

local title = {
	value = 2,
	key = 1
}
local dataList = {
	{
		"MAX_MOOD_VAL",
		"100"
	},
	{
		"MAX_ENERGY_VAL",
		"100"
	},
	{
		"INITIAL_MOOD_VAL",
		"50"
	},
	{
		"INITIAL_ENERGY_VAL",
		"50"
	},
	{
		"MOOD_DEC_INTERVAL",
		"2100"
	},
	{
		"ENERGY_DEC_INTERVAL",
		"900"
	},
	{
		"FEED_BACK_EVENT_TIMES",
		"05:00:00"
	},
	{
		"ADVENTURE_PRIZE_COUNT",
		"60"
	},
	{
		"ADVENTURE_PRIZE_INTERVAL",
		"600"
	},
	{
		"FEED_COST_ITEM",
		"4:35:1"
	},
	{
		"FEED_INC_INTIMACY",
		"10"
	},
	{
		"FEED_INC_ENERGY",
		"5"
	},
	{
		"TOUCH_DAILY_COUNT",
		"3"
	},
	{
		"TOUCH_CD",
		"3"
	},
	{
		"TOUCH_INC_INTIMACY",
		"50"
	},
	{
		"TOUCH_INC_MOOD",
		"15"
	},
	{
		"RENAME_ITEM",
		"105:164:200"
	}
}
local t_animals_params = {
	MAX_MOOD_VAL = dataList[1],
	MAX_ENERGY_VAL = dataList[2],
	INITIAL_MOOD_VAL = dataList[3],
	INITIAL_ENERGY_VAL = dataList[4],
	MOOD_DEC_INTERVAL = dataList[5],
	ENERGY_DEC_INTERVAL = dataList[6],
	FEED_BACK_EVENT_TIMES = dataList[7],
	ADVENTURE_PRIZE_COUNT = dataList[8],
	ADVENTURE_PRIZE_INTERVAL = dataList[9],
	FEED_COST_ITEM = dataList[10],
	FEED_INC_INTIMACY = dataList[11],
	FEED_INC_ENERGY = dataList[12],
	TOUCH_DAILY_COUNT = dataList[13],
	TOUCH_CD = dataList[14],
	TOUCH_INC_INTIMACY = dataList[15],
	TOUCH_INC_MOOD = dataList[16],
	RENAME_ITEM = dataList[17]
}

t_animals_params.dataList = dataList

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

return t_animals_params
