-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pet_card_lottery_period.lua

module("logicconfig.config.t_pet_card_lottery_period", package.seeall)

local title = {
	name = 5,
	daysOfWeek = 3,
	prizeMultiplier = 4,
	period = 2,
	activityId = 1
}
local dataList = {
	{
		271001,
		1,
		{
			5
		},
		1,
		"周末有喜乐"
	},
	{
		271001,
		2,
		{
			6
		},
		1,
		"周末有喜乐"
	},
	{
		271001,
		3,
		{
			7
		},
		1,
		"周末有喜乐"
	},
	{
		271002,
		1,
		{
			5
		},
		1,
		"周末有喜乐"
	},
	{
		271002,
		2,
		{
			6
		},
		1,
		"周末有喜乐"
	},
	{
		271002,
		3,
		{
			7
		},
		1,
		"周末有喜乐"
	}
}
local t_pet_card_lottery_period = {
	[271001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[271002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_pet_card_lottery_period.dataList = dataList

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

return t_pet_card_lottery_period
