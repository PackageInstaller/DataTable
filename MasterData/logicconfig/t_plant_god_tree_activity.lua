-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_plant_god_tree_activity.lua

module("logicconfig.config.t_plant_god_tree_activity", package.seeall)

local title = {
	seedItem = 2,
	redPointId = 3,
	jumpTo = 6,
	nextStepWaterCount = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		556001,
		"10:556001",
		755,
		10,
		"shengmingshenshu_rule",
		{
			"func#1307",
			"func#1308"
		}
	}
}
local t_plant_god_tree_activity = {
	[556001] = dataList[1]
}

t_plant_god_tree_activity.dataList = dataList

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

return t_plant_god_tree_activity
