-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_mirror_trial_property_plan.lua

module("logicconfig.config.t_mirror_trial_property_plan", package.seeall)

local title = {
	planId = 1,
	icon = 4,
	propertyType = 2,
	percent = 3
}
local dataList = {
	{
		1,
		"装备",
		50,
		"rankracebuff_1"
	},
	{
		2,
		"种族",
		50,
		"rankracebuff_2"
	},
	{
		3,
		"天赋",
		50,
		"rankracebuff_3"
	}
}
local t_mirror_trial_property_plan = {
	{
		装备 = dataList[1]
	},
	{
		种族 = dataList[2]
	},
	{
		天赋 = dataList[3]
	}
}

t_mirror_trial_property_plan.dataList = dataList

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

return t_mirror_trial_property_plan
