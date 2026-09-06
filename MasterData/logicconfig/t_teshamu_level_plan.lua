-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_teshamu_level_plan.lua

module("logicconfig.config.t_teshamu_level_plan", package.seeall)

local title = {
	banPetCount = 4,
	levelPlanId = 1,
	prize = 3,
	level = 2
}
local dataList = {
	{
		1,
		1,
		"4:510208:200",
		1
	},
	{
		1,
		2,
		"4:510208:300",
		2
	},
	{
		1,
		3,
		"4:510208:500",
		3
	},
	{
		1,
		4,
		"4:510208:1000",
		4
	},
	{
		288002,
		1,
		"4:253:10",
		1
	},
	{
		288002,
		2,
		"4:253:10",
		2
	},
	{
		288002,
		3,
		"4:253:20",
		3
	},
	{
		288002,
		4,
		"4:253:40",
		4
	}
}
local t_teshamu_level_plan = {
	{
		dataList[1],
		dataList[2],
		dataList[3],
		dataList[4]
	},
	[288002] = {
		dataList[5],
		dataList[6],
		dataList[7],
		dataList[8]
	}
}

t_teshamu_level_plan.dataList = dataList

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

return t_teshamu_level_plan
