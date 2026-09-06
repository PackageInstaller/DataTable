-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_fame_hall_vote_activity.lua

module("logicconfig.config.t_fame_hall_vote_activity", package.seeall)

local title = {
	activityId = 1,
	ruleKeyMain = 3,
	dailyVoteTimes = 2
}
local dataList = {
	{
		541001,
		5,
		"divinekingshikonglongzunmain_rule"
	}
}
local t_fame_hall_vote_activity = {
	[541001] = dataList[1]
}

t_fame_hall_vote_activity.dataList = dataList

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

return t_fame_hall_vote_activity
