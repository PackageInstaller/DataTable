-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_villain_pet_trial_activity.lua

module("logicconfig.config.t_villain_pet_trial_activity", package.seeall)

local title = {
	stagePlanId = 2,
	lineupsPlanId = 4,
	aliveScore = 5,
	prizePlanId = 3,
	name = 6,
	activityId = 1,
	des = 7
}
local dataList = {
	{
		163001,
		{
			1,
			2,
			3,
			4,
			5,
			6
		},
		1,
		1,
		2,
		"灵力狂潮",
		"1、打通第一层即可上榜\r\n2、排行榜每日5:00重置"
	}
}
local t_villain_pet_trial_activity = {
	[163001] = dataList[1]
}

t_villain_pet_trial_activity.dataList = dataList

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

return t_villain_pet_trial_activity
