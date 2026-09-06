-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fusion_soul_activity.lua

module("logicconfig.config.t_fusion_soul_activity", package.seeall)

local title = {
	activityId = 1,
	finalStoryId = 3,
	energyKey = 2
}
local dataList = {
	{
		498001,
		"66:20",
		4820003
	}
}
local t_fusion_soul_activity = {
	[498001] = dataList[1]
}

t_fusion_soul_activity.dataList = dataList

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

return t_fusion_soul_activity
