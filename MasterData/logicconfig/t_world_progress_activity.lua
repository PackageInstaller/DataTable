-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_world_progress_activity.lua

module("logicconfig.config.t_world_progress_activity", package.seeall)

local title = {
	activityType = 2,
	redPointId = 3,
	activityId = 1
}
local dataList = {
	{
		443001,
		443,
		673
	},
	{
		532001,
		532,
		673
	},
	{
		525001,
		525,
		738
	},
	{
		540001,
		540,
		673
	},
	{
		540002,
		540,
		673
	},
	{
		595001,
		595,
		738
	}
}
local t_world_progress_activity = {
	[443001] = dataList[1],
	[532001] = dataList[2],
	[525001] = dataList[3],
	[540001] = dataList[4],
	[540002] = dataList[5],
	[595001] = dataList[6]
}

t_world_progress_activity.dataList = dataList

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

return t_world_progress_activity
