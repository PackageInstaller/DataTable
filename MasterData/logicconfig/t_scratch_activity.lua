-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_scratch_activity.lua

module("logicconfig.config.t_scratch_activity", package.seeall)

local title = {
	activityItem = 5,
	normalPlanId = 3,
	id = 1,
	bigPlanId = 2,
	taskPlanId = 4
}
local dataList = {
	{
		2001,
		1,
		1,
		1,
		"10:2001:1"
	},
	{
		2002,
		2,
		2,
		2,
		"10:2002:1"
	},
	{
		2003,
		3,
		3,
		3,
		"10:2003:1"
	}
}
local t_scratch_activity = {
	[2001] = dataList[1],
	[2002] = dataList[2],
	[2003] = dataList[3]
}

t_scratch_activity.dataList = dataList

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

return t_scratch_activity
