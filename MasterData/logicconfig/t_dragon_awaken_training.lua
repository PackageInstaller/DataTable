-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_training.lua

module("logicconfig.config.t_dragon_awaken_training", package.seeall)

local title = {
	prize = 4,
	openTime = 3,
	trainingFormPlan = 5,
	hardDesc = 6,
	activityId = 1,
	hard = 2
}
local dataList = {
	{
		419001,
		1,
		"2024-09-27T05:00:00",
		"10:419002:200",
		1,
		"简单"
	},
	{
		419001,
		2,
		"2024-09-27T05:00:00",
		"10:419002:400",
		2,
		"普通"
	},
	{
		419001,
		3,
		"2024-11-25T05:00:00",
		"10:419002:600",
		3,
		"困难"
	},
	{
		419002,
		1,
		"2025-03-14T05:00:00",
		"10:419005:200",
		4,
		"简单"
	},
	{
		419002,
		2,
		"2025-03-14T05:00:00",
		"10:419005:400",
		5,
		"普通"
	},
	{
		419002,
		3,
		"2025-03-15T05:00:00",
		"10:419005:600",
		6,
		"困难"
	}
}
local t_dragon_awaken_training = {
	[419001] = {
		dataList[1],
		dataList[2],
		dataList[3]
	},
	[419002] = {
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_dragon_awaken_training.dataList = dataList

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

return t_dragon_awaken_training
