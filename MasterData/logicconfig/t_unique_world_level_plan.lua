-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_unique_world_level_plan.lua

module("logicconfig.config.t_unique_world_level_plan", package.seeall)

local title = {
	level = 3,
	mapId = 4,
	length = 5,
	width = 6,
	cellWidth = 7,
	cellHeight = 8,
	activityId = 1,
	gameId = 2
}
local dataList = {
	{
		584001,
		1,
		1,
		1,
		10,
		10,
		226,
		128
	},
	{
		584001,
		1,
		2,
		2,
		10,
		10,
		226,
		128
	},
	{
		584001,
		1,
		3,
		3,
		15,
		15,
		226,
		128
	},
	{
		584001,
		2,
		1,
		4,
		10,
		10,
		226,
		128
	},
	{
		584001,
		2,
		2,
		5,
		10,
		10,
		226,
		128
	},
	{
		584001,
		2,
		3,
		6,
		15,
		15,
		226,
		128
	},
	{
		584001,
		3,
		1,
		7,
		10,
		10,
		226,
		128
	},
	{
		584001,
		3,
		2,
		8,
		10,
		10,
		226,
		128
	},
	{
		584001,
		3,
		3,
		9,
		15,
		15,
		226,
		128
	}
}
local t_unique_world_level_plan = {
	[584001] = {
		{
			dataList[1],
			dataList[2],
			dataList[3]
		},
		{
			dataList[4],
			dataList[5],
			dataList[6]
		},
		{
			dataList[7],
			dataList[8],
			dataList[9]
		}
	}
}

t_unique_world_level_plan.dataList = dataList

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

return t_unique_world_level_plan
