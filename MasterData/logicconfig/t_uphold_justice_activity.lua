-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_uphold_justice_activity.lua

module("logicconfig.config.t_uphold_justice_activity", package.seeall)

local title = {
	interval = 2,
	activityItemId = 5,
	skinId = 6,
	showMsgCount = 4,
	intervalAddStrength = 3,
	activityId = 1
}
local dataList = {
	{
		581001,
		4,
		500,
		10,
		581001,
		1702601
	}
}
local t_uphold_justice_activity = {
	[581001] = dataList[1]
}

t_uphold_justice_activity.dataList = dataList

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

return t_uphold_justice_activity
