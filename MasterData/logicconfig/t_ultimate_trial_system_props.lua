-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ultimate_trial_system_props.lua

module("logicconfig.config.t_ultimate_trial_system_props", package.seeall)

local title = {
	systemPropPlanId = 1,
	extraPercent = 3,
	buffPath = 4,
	days = 2
}
local dataList = {
	{
		1,
		0,
		500,
		"ui/icon/skill/skill_bd"
	},
	{
		1,
		1,
		600,
		"ui/icon/skill/skill_bd"
	},
	{
		1,
		2,
		700,
		"ui/icon/skill/skill_bd"
	},
	{
		1,
		3,
		800,
		"ui/icon/skill/skill_bd"
	},
	{
		1,
		4,
		900,
		"ui/icon/skill/skill_bd"
	}
}
local t_ultimate_trial_system_props = {
	{
		[0] = dataList[1],
		dataList[2],
		dataList[3],
		dataList[4],
		dataList[5]
	}
}

t_ultimate_trial_system_props.dataList = dataList

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

return t_ultimate_trial_system_props
