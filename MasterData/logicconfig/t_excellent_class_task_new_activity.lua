-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_excellent_class_task_new_activity.lua

module("logicconfig.config.t_excellent_class_task_new_activity", package.seeall)

local title = {
	activityId = 1,
	startCreateTime = 3,
	redPointId = 2,
	endCreateTime = 4
}
local dataList = {
	{
		106001,
		200
	},
	{
		106002,
		431,
		"2022-12-23T05:00:00",
		"2129-01-13T05:00:00"
	},
	{
		106003,
		432,
		"2022-12-23T05:00:00",
		"2129-01-13T05:00:00"
	},
	{
		106004,
		693,
		"2025-04-03T05:00:00",
		"2129-01-13T05:00:00"
	},
	{
		106005,
		694,
		"2025-04-03T05:00:00",
		"2129-01-13T05:00:00"
	}
}
local t_excellent_class_task_new_activity = {
	[106001] = dataList[1],
	[106002] = dataList[2],
	[106003] = dataList[3],
	[106004] = dataList[4],
	[106005] = dataList[5]
}

t_excellent_class_task_new_activity.dataList = dataList

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

return t_excellent_class_task_new_activity
