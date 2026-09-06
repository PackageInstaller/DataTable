-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_dragon_arya_clg_activity.lua

module("logicconfig.config.t_divine_dragon_arya_clg_activity", package.seeall)

local title = {
	dailyRankLimit = 5,
	minScore2SubmitGodRank = 3,
	godRankLimit = 4,
	challengeClosedTimeRange = 2,
	dailyRankStartTime = 6,
	dailyRankEndTime = 7,
	activityId = 1,
	rankPrize = 8
}
local dataList = {
	{
		337001,
		"02:00:00-09:00:00",
		150,
		1000,
		300,
		"2026-04-03T05:00:00",
		"2038-12-31T05:00:00",
		"4:510256:100"
	}
}
local t_divine_dragon_arya_clg_activity = {
	[337001] = dataList[1]
}

t_divine_dragon_arya_clg_activity.dataList = dataList

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

return t_divine_dragon_arya_clg_activity
