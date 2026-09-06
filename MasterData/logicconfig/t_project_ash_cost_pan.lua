-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_project_ash_cost_pan.lua

module("logicconfig.config.t_project_ash_cost_pan", package.seeall)

local title = {
	id = 2,
	cost = 3,
	costPlanId = 1
}
local dataList = {
	{
		1,
		1,
		"10:265001:1"
	},
	{
		1,
		2,
		"10:265002:1"
	},
	{
		1,
		3,
		"10:265003:1"
	},
	{
		2,
		1,
		"10:265001:1"
	},
	{
		2,
		2,
		"10:265002:1"
	},
	{
		2,
		3,
		"10:265003:1"
	}
}
local t_project_ash_cost_pan = {
	{
		dataList[1],
		dataList[2],
		dataList[3]
	},
	{
		dataList[4],
		dataList[5],
		dataList[6]
	}
}

t_project_ash_cost_pan.dataList = dataList

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

return t_project_ash_cost_pan
