-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_sword_storm_activity.lua

module("logicconfig.config.t_sword_storm_activity", package.seeall)

local title = {
	activityId = 1,
	jumpTo = 2
}
local dataList = {
	{
		579001,
		"func#1440"
	}
}
local t_sword_storm_activity = {
	[579001] = dataList[1]
}

t_sword_storm_activity.dataList = dataList

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

return t_sword_storm_activity
