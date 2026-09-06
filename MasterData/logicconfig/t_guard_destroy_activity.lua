-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_guard_destroy_activity.lua

module("logicconfig.config.t_guard_destroy_activity", package.seeall)

local title = {
	signInPlanId = 3,
	activityId = 1,
	balancePrize = 2
}
local dataList = {
	{
		474001,
		"4:30006:50",
		1
	},
	{
		474002,
		"1:12025:-1:1",
		2
	}
}
local t_guard_destroy_activity = {
	[474001] = dataList[1],
	[474002] = dataList[2]
}

t_guard_destroy_activity.dataList = dataList

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

return t_guard_destroy_activity
