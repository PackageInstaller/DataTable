-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pursue_dream_activity.lua

module("logicconfig.config.t_pursue_dream_activity", package.seeall)

local title = {
	activityId = 1,
	planId = 2
}
local dataList = {
	{
		39001,
		1
	}
}
local t_pursue_dream_activity = {
	[39001] = dataList[1]
}

t_pursue_dream_activity.dataList = dataList

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

return t_pursue_dream_activity
