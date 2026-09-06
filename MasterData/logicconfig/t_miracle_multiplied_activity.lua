-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_miracle_multiplied_activity.lua

module("logicconfig.config.t_miracle_multiplied_activity", package.seeall)

local title = {
	redPointId = 3,
	ruleKey = 4,
	activityId = 1,
	materialCount = 2
}
local dataList = {
	{
		380001,
		25,
		586,
		"doublemiracle_rule"
	}
}
local t_miracle_multiplied_activity = {
	[380001] = dataList[1]
}

t_miracle_multiplied_activity.dataList = dataList

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

return t_miracle_multiplied_activity
