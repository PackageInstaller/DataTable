-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_disorder_power_activity.lua

module("logicconfig.config.t_disorder_power_activity", package.seeall)

local title = {
	trainingCost = 2,
	redPointId = 3,
	skinId = 5,
	ruleKeyMain = 4,
	activityId = 1
}
local dataList = {
	{
		422001,
		"10:422001:1",
		640,
		"disorderpowerview_rule",
		16030
	}
}
local t_disorder_power_activity = {
	[422001] = dataList[1]
}

t_disorder_power_activity.dataList = dataList

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

return t_disorder_power_activity
