-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_compose_cost_plan.lua

module("logicconfig.config.t_compose_cost_plan", package.seeall)

local title = {
	costMaterial = 3,
	costPlanId = 1,
	times = 2
}
local dataList = {
	{
		2,
		1,
		"4:8002:50"
	},
	{
		3,
		1,
		"4:8003:100"
	},
	{
		4,
		1,
		"4:2000:30#4:2001:50"
	},
	{
		5,
		1,
		"4:2000:30#4:2002:40"
	},
	{
		6,
		1,
		"4:2000:30#4:2003:25"
	},
	{
		7,
		1,
		"8:1:2000000"
	},
	{
		8,
		1,
		"105:204:500"
	},
	{
		9,
		1,
		"105:204:1500"
	}
}
local t_compose_cost_plan = {
	[2] = {
		dataList[1]
	},
	[3] = {
		dataList[2]
	},
	[4] = {
		dataList[3]
	},
	[5] = {
		dataList[4]
	},
	[6] = {
		dataList[5]
	},
	[7] = {
		dataList[6]
	},
	[8] = {
		dataList[7]
	},
	[9] = {
		dataList[8]
	}
}

t_compose_cost_plan.dataList = dataList

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

return t_compose_cost_plan
