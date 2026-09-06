-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dream_island_prize.lua

module("logicconfig.config.t_dream_island_prize", package.seeall)

local title = {
	prize = 3,
	activityId = 1,
	needScore = 2
}
local dataList = {
	{
		33001,
		15,
		"4:36:10"
	},
	{
		33001,
		30,
		"4:36:10"
	},
	{
		33001,
		50,
		"4:36:10"
	},
	{
		33001,
		75,
		"4:36:10"
	},
	{
		33001,
		100,
		"4:36:10"
	},
	{
		33001,
		125,
		"4:90053:1"
	}
}
local t_dream_island_prize = {
	[33001] = {
		[15] = dataList[1],
		[30] = dataList[2],
		[50] = dataList[3],
		[75] = dataList[4],
		[100] = dataList[5],
		[125] = dataList[6]
	}
}

t_dream_island_prize.dataList = dataList

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

return t_dream_island_prize
