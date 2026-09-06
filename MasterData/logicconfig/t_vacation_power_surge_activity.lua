-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_vacation_power_surge_activity.lua

module("logicconfig.config.t_vacation_power_surge_activity", package.seeall)

local title = {
	taskPlanId = 3,
	item = 6,
	progressPlanId = 4,
	startOnePassDayBeforeEnd = 5,
	activityId = 1,
	desc = 2
}
local dataList = {
	{
		46001,
		"阵法/守护狂欢周",
		1,
		1,
		5,
		"1004:1010"
	},
	{
		46002,
		"星神狂欢周",
		2,
		2,
		5,
		"1004:1011"
	},
	{
		46003,
		"装备狂欢周",
		3,
		3,
		5,
		"1004:1012"
	}
}
local t_vacation_power_surge_activity = {
	[46001] = dataList[1],
	[46002] = dataList[2],
	[46003] = dataList[3]
}

t_vacation_power_surge_activity.dataList = dataList

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

return t_vacation_power_surge_activity
