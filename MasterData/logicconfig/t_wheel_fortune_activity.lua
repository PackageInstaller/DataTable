-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wheel_fortune_activity.lua

module("logicconfig.config.t_wheel_fortune_activity", package.seeall)

local title = {
	id = 1,
	activityItem = 3,
	prizePool = 2
}
local dataList = {
	{
		227001,
		1,
		"10:227001:10"
	}
}
local t_wheel_fortune_activity = {
	[227001] = dataList[1]
}

t_wheel_fortune_activity.dataList = dataList

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

return t_wheel_fortune_activity
