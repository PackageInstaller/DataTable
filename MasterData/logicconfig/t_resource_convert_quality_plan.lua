-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_resource_convert_quality_plan.lua

module("logicconfig.config.t_resource_convert_quality_plan", package.seeall)

local title = {
	periodType = 4,
	realCostQuality = 2,
	returnMp = 6,
	desc = 3,
	timeLimit = 5,
	materialType = 1
}
local dataList = {
	{
		7,
		1,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		2,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		3,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		4,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		5,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		6,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		7,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		8,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		9,
		"已选中",
		"none",
		0,
		""
	},
	{
		7,
		10,
		"已选中",
		"none",
		0,
		""
	},
	{
		15,
		2,
		"已选中",
		"none",
		0,
		"4:207:5"
	},
	{
		15,
		3,
		"已选中",
		"none",
		0,
		"4:207:10"
	},
	{
		15,
		4,
		"已选中",
		"none",
		0,
		"4:207:15"
	}
}
local t_resource_convert_quality_plan = {
	[7] = {
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	},
	[15] = {
		[2] = dataList[11],
		[3] = dataList[12],
		[4] = dataList[13]
	}
}

t_resource_convert_quality_plan.dataList = dataList

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

return t_resource_convert_quality_plan
