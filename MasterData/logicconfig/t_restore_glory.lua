-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_restore_glory.lua

module("logicconfig.config.t_restore_glory", package.seeall)

local title = {
	storyId = 5,
	progressPlanId = 2,
	restorePlanId = 3,
	activityId = 1,
	startTime = 4
}
local dataList = {
	{
		248001,
		1,
		1,
		"2023-03-31T05:00:00",
		4450003
	}
}
local t_restore_glory = {
	[248001] = dataList[1]
}

t_restore_glory.dataList = dataList

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

return t_restore_glory
