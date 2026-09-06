-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hoshigami_main_prop_plan.lua

module("logicconfig.config.t_hoshigami_main_prop_plan", package.seeall)

local title = {
	lvPlan = 3,
	mainPropId = 2,
	planId = 1
}
local dataList = {
	{
		1,
		1,
		1
	},
	{
		1,
		2,
		2
	},
	{
		2,
		1,
		3
	},
	{
		2,
		2,
		4
	}
}
local t_hoshigami_main_prop_plan = {
	{
		dataList[1],
		dataList[2]
	},
	{
		dataList[3],
		dataList[4]
	}
}

t_hoshigami_main_prop_plan.dataList = dataList

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

return t_hoshigami_main_prop_plan
