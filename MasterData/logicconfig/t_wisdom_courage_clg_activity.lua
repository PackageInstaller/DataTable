-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wisdom_courage_clg_activity.lua

module("logicconfig.config.t_wisdom_courage_clg_activity", package.seeall)

local title = {
	ruleKeyMain = 3,
	activityId = 1,
	dailyBossTimes = 2
}
local dataList = {
	{
		456001,
		3,
		"nvshenshilian_rule"
	}
}
local t_wisdom_courage_clg_activity = {
	[456001] = dataList[1]
}

t_wisdom_courage_clg_activity.dataList = dataList

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

return t_wisdom_courage_clg_activity
