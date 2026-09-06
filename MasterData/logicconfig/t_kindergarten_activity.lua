-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_kindergarten_activity.lua

module("logicconfig.config.t_kindergarten_activity", package.seeall)

local title = {
	showMat = 11,
	classTimeSec = 3,
	strengthPoint = 5,
	autoUnlockLvLimit = 9,
	schedulePlanSize = 8,
	operaId = 10,
	dailyItem = 2,
	activityId = 1,
	redPointId = 12,
	autoUnlockCost = 4,
	intellectPoint = 7,
	artPoint = 6
}
local dataList = {
	{
		353001,
		"10:353004:5#10:353003:100",
		2700,
		"10:353002:500",
		20,
		20,
		20,
		3,
		3,
		4640001,
		"10:353002",
		"569"
	}
}
local t_kindergarten_activity = {
	[353001] = dataList[1]
}

t_kindergarten_activity.dataList = dataList

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

return t_kindergarten_activity
