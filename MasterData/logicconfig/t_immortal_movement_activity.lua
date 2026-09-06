-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_immortal_movement_activity.lua

module("logicconfig.config.t_immortal_movement_activity", package.seeall)

local title = {
	bubblePrize = 5,
	redPointId = 2,
	skinId = 4,
	activityId = 1,
	ruleKey = 3
}
local dataList = {
	{
		484001,
		703,
		"immortal_movement_rule",
		16038,
		"4:295:20"
	}
}
local t_immortal_movement_activity = {
	[484001] = dataList[1]
}

t_immortal_movement_activity.dataList = dataList

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

return t_immortal_movement_activity
