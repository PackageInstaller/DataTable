-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_star_hall_stage.lua

module("logicconfig.config.t_star_hall_stage", package.seeall)

local title = {
	stageId = 2,
	numberScore = 3,
	activityId = 1,
	openTime = 4
}
local dataList = {
	{
		494001,
		1,
		10,
		"2025-06-27T05:00:00"
	},
	{
		494001,
		2,
		10,
		"2025-06-27T05:00:00"
	},
	{
		494001,
		3,
		10,
		"2025-06-27T05:00:00"
	},
	{
		494001,
		4,
		10,
		"2025-06-27T05:00:00"
	},
	{
		494001,
		5,
		10,
		"2025-06-27T05:00:00"
	},
	{
		494002,
		1,
		10,
		"2025-07-04T05:00:00"
	},
	{
		494002,
		2,
		10,
		"2025-07-04T05:00:00"
	},
	{
		494002,
		3,
		10,
		"2025-07-04T05:00:00"
	},
	{
		494002,
		4,
		10,
		"2025-07-04T05:00:00"
	},
	{
		494002,
		5,
		10,
		"2025-07-04T05:00:00"
	}
}
local t_star_hall_stage = {
	[494001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	[494002] = {
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_star_hall_stage.dataList = dataList

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

return t_star_hall_stage
