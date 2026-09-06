-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_goddess_waken_quality_plan.lua

module("logicconfig.config.t_goddess_waken_quality_plan", package.seeall)

local title = {
	prize = 4,
	name = 3,
	storyId = 6,
	progress = 5,
	planId = 1,
	qualityId = 2
}
local dataList = {
	{
		1,
		1,
		"真诚",
		"4:36:10",
		5,
		4180022
	},
	{
		1,
		2,
		"善良",
		"4:41004:1",
		10,
		4180023
	},
	{
		1,
		3,
		"勇气",
		"4:41004:1",
		18,
		4180024
	},
	{
		1,
		4,
		"智慧",
		"4:90184:1",
		26,
		4180025
	},
	{
		1,
		5,
		"希望",
		"4:70023:1",
		34,
		4180026
	},
	{
		2,
		1,
		"责任",
		"4:36:10",
		5,
		4200001
	},
	{
		2,
		2,
		"信念",
		"4:90185:1",
		10,
		4200002
	},
	{
		2,
		3,
		"纪律",
		"4:90185:1",
		18,
		4200003
	},
	{
		2,
		4,
		"突破",
		"4:90185:1",
		26,
		4200004
	},
	{
		2,
		5,
		"正义",
		"4:90185:1",
		34,
		4200005
	}
}
local t_goddess_waken_quality_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	},
	{
		dataList[6],
		dataList[7],
		dataList[8],
		dataList[9],
		dataList[10]
	}
}

t_goddess_waken_quality_plan.dataList = dataList

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

return t_goddess_waken_quality_plan
