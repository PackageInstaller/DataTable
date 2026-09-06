-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fruit_ninja_activity.lua

module("logicconfig.config.t_fruit_ninja_activity", package.seeall)

local title = {
	dailyGameTimes = 2,
	norGamePlanId = 5,
	redPointId = 4,
	exGamePlanId = 6,
	oneGameMaxScore = 3,
	criPlanId = 7,
	activityId = 1,
	ruleKey = 8
}
local dataList = {
	{
		475001,
		3,
		100000,
		0,
		1,
		2,
		1,
		"fruitninjiaview_rule"
	}
}
local t_fruit_ninja_activity = {
	[475001] = dataList[1]
}

t_fruit_ninja_activity.dataList = dataList

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

return t_fruit_ninja_activity
