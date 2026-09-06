-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_riddle_activity.lua

module("logicconfig.config.t_lantern_riddle_activity", package.seeall)

local title = {
	activityId = 1,
	ruleKeyMain = 3,
	problemPlanId = 2
}
local dataList = {
	{
		441001,
		2,
		"lantern_riddle_activity_rule"
	}
}
local t_lantern_riddle_activity = {
	[441001] = dataList[1]
}

t_lantern_riddle_activity.dataList = dataList

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

return t_lantern_riddle_activity
