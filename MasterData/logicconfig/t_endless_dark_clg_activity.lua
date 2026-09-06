-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_endless_dark_clg_activity.lua

module("logicconfig.config.t_endless_dark_clg_activity", package.seeall)

local title = {
	redPointId = 2,
	jumpTo = 4,
	buffNumLimit = 3,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		555001,
		755,
		3,
		{
			"func#1306"
		},
		"wujinanshi_charule"
	}
}
local t_endless_dark_clg_activity = {
	[555001] = dataList[1]
}

t_endless_dark_clg_activity.dataList = dataList

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

return t_endless_dark_clg_activity
