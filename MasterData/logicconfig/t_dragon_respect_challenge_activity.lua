-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_respect_challenge_activity.lua

module("logicconfig.config.t_dragon_respect_challenge_activity", package.seeall)

local title = {
	universalChallengePlanId = 3,
	extremeChallengePlanId = 2,
	activityId = 1,
	fusionDrawPlanId = 4
}
local dataList = {
	{
		194001,
		1,
		1,
		1
	}
}
local t_dragon_respect_challenge_activity = {
	[194001] = dataList[1]
}

t_dragon_respect_challenge_activity.dataList = dataList

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

return t_dragon_respect_challenge_activity
