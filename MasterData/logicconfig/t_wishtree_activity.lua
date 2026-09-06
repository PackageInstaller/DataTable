-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_wishtree_activity.lua

module("logicconfig.config.t_wishtree_activity", package.seeall)

local title = {
	activityId = 1,
	rewardPlanId = 3,
	wishPlanId = 2,
	rule = 5,
	content = 4
}
local dataList = {
	{
		228001,
		1,
		1,
		"大家好 我们展望未来吧！！！！",
		""
	}
}
local t_wishtree_activity = {
	[228001] = dataList[1]
}

t_wishtree_activity.dataList = dataList

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

return t_wishtree_activity
