-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_awaken_oath_ancestor_activity.lua

module("logicconfig.config.t_awaken_oath_ancestor_activity", package.seeall)

local title = {
	requiredBlood = 3,
	activityId = 1,
	redPointId = 5,
	pointNum = 6,
	ruleKeyMain = 7,
	prize = 2,
	gainBlood = 4
}
local dataList = {
	{
		496001,
		"4:36:10",
		20,
		10,
		714,
		8,
		"fuyao_story2_rule"
	}
}
local t_awaken_oath_ancestor_activity = {
	[496001] = dataList[1]
}

t_awaken_oath_ancestor_activity.dataList = dataList

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

return t_awaken_oath_ancestor_activity
