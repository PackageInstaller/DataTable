-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_empress_extreme_clg_stage.lua

module("logicconfig.config.t_empress_extreme_clg_stage", package.seeall)

local title = {
	stageId = 2,
	name = 4,
	skinId = 5,
	creepsMasterId = 3,
	activityId = 1
}
local dataList = {
	{
		342001,
		1,
		1001,
		"第一关",
		17010
	},
	{
		342001,
		2,
		1002,
		"第二关",
		11012
	},
	{
		342001,
		3,
		1003,
		"第三关",
		12012
	},
	{
		342001,
		4,
		1004,
		"第四关",
		14014
	},
	{
		342001,
		5,
		1005,
		"第五关",
		15020
	},
	{
		342001,
		6,
		1006,
		"第六关",
		14020
	},
	{
		342002,
		1,
		1001,
		"第一关",
		17010
	},
	{
		342002,
		2,
		1002,
		"第二关",
		11012
	},
	{
		342002,
		3,
		1003,
		"第三关",
		12012
	},
	{
		342002,
		4,
		1004,
		"第四关",
		14014
	},
	{
		342002,
		5,
		1005,
		"第五关",
		15020
	},
	{
		342002,
		6,
		1006,
		"第六关",
		14020
	}
}
local t_empress_extreme_clg_stage = {
	[342001] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6]
	},
	[342002] = {
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10],
		dataList[11],
		dataList[12]
	}
}

t_empress_extreme_clg_stage.dataList = dataList

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

return t_empress_extreme_clg_stage
