-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dark_dragon_preheat_activity.lua

module("logicconfig.config.t_dark_dragon_preheat_activity", package.seeall)

local title = {
	taskPlanId = 3,
	fakeId = 5,
	progressPlanId = 4,
	activityId = 1,
	desc = 2
}
local dataList = {
	{
		52001,
		"暗龙预热",
		1,
		1,
		"1004:1013"
	}
}
local t_dark_dragon_preheat_activity = {
	[52001] = dataList[1]
}

t_dark_dragon_preheat_activity.dataList = dataList

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

return t_dark_dragon_preheat_activity
