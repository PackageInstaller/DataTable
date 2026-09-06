-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_general_world_progress_activity.lua

module("logicconfig.config.t_general_world_progress_activity", package.seeall)

local title = {
	activityType = 2,
	prizePlanId = 4,
	redPointId = 5,
	progressPlanId = 3,
	activityId = 1
}
local dataList = {
	{
		262001,
		262,
		1,
		1,
		472
	},
	{
		262002,
		262,
		2,
		2,
		472
	},
	{
		262003,
		262,
		2,
		2,
		472
	},
	{
		262004,
		262,
		2,
		4,
		472
	},
	{
		262005,
		262,
		2,
		5,
		472
	},
	{
		262006,
		262,
		2,
		6,
		472
	},
	{
		262007,
		262,
		3,
		7,
		472
	}
}
local t_general_world_progress_activity = {
	[262001] = dataList[1],
	[262002] = dataList[2],
	[262003] = dataList[3],
	[262004] = dataList[4],
	[262005] = dataList[5],
	[262006] = dataList[6],
	[262007] = dataList[7]
}

t_general_world_progress_activity.dataList = dataList

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

return t_general_world_progress_activity
