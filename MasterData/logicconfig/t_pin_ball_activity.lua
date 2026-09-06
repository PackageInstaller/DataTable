-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pin_ball_activity.lua

module("logicconfig.config.t_pin_ball_activity", package.seeall)

local title = {
	dailyGameLimit = 2,
	redPointId = 3,
	jumpTo = 4,
	activityId = 1,
	ruleKey = 5
}
local dataList = {
	{
		554001,
		3,
		754,
		{
			"func#1306"
		},
		"pinballgame_rule"
	},
	{
		554002,
		3,
		754,
		{
			"func#1306"
		},
		"pinballgame_rule"
	}
}
local t_pin_ball_activity = {
	[554001] = dataList[1],
	[554002] = dataList[2]
}

t_pin_ball_activity.dataList = dataList

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

return t_pin_ball_activity
