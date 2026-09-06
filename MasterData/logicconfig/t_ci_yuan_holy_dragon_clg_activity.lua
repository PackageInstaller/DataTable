-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ci_yuan_holy_dragon_clg_activity.lua

module("logicconfig.config.t_ci_yuan_holy_dragon_clg_activity", package.seeall)

local title = {
	challengeClosedTimeRange = 3,
	dailyRankPrize = 4,
	activityId = 1,
	nDamage2OneScore = 2
}
local dataList = {
	{
		306001,
		10000,
		"02:00:00-09:00:00",
		"4:206:1"
	}
}
local t_ci_yuan_holy_dragon_clg_activity = {
	[306001] = dataList[1]
}

t_ci_yuan_holy_dragon_clg_activity.dataList = dataList

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

return t_ci_yuan_holy_dragon_clg_activity
