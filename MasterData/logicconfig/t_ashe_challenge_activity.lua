-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ashe_challenge_activity.lua

module("logicconfig.config.t_ashe_challenge_activity", package.seeall)

local title = {
	dailyBuffPlanId = 3,
	comPlanId = 6,
	dailyChallengeTimes = 5,
	selectBuffPlanId = 4,
	activityId = 1,
	difficultyPlanId = 2
}
local dataList = {
	{
		246001,
		1,
		1,
		1,
		3,
		1
	},
	{
		246002,
		2,
		2,
		2,
		3,
		2
	},
	{
		246003,
		3,
		3,
		3,
		3,
		3
	},
	{
		246004,
		4,
		4,
		4,
		3,
		4
	}
}
local t_ashe_challenge_activity = {
	[246001] = dataList[1],
	[246002] = dataList[2],
	[246003] = dataList[3],
	[246004] = dataList[4]
}

t_ashe_challenge_activity.dataList = dataList

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

return t_ashe_challenge_activity
