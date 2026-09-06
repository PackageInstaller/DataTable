-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_snowman_car_activity.lua

module("logicconfig.config.t_snowman_car_activity", package.seeall)

local title = {
	carScoreRate = 7,
	gameTime = 6,
	dailyGameTimes = 2,
	redPointId = 3,
	planId = 8,
	ruleKeyMain = 5,
	activityId = 1,
	carBlood = 4
}
local dataList = {
	{
		432001,
		3,
		657,
		3,
		"snowmancar_rule",
		60,
		1,
		1
	}
}
local t_snowman_car_activity = {
	[432001] = dataList[1]
}

t_snowman_car_activity.dataList = dataList

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

return t_snowman_car_activity
