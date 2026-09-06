-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_lantern_festival_group.lua

module("logicconfig.config.t_lantern_festival_group", package.seeall)

local title = {
	interval = 4,
	openTime = 3,
	questionPlan = 5,
	showTimeStr = 6,
	groupId = 2,
	activityId = 1
}
local dataList = {
	{
		566001,
		1,
		"09:00:00#14:00:00",
		1,
		1,
		"09:00-14:00"
	},
	{
		566001,
		2,
		"18:00:00#22:00:00",
		1,
		1,
		"18:00-22:00"
	}
}
local t_lantern_festival_group = {
	[566001] = {
		dataList[1],
		dataList[2]
	}
}

t_lantern_festival_group.dataList = dataList

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

return t_lantern_festival_group
