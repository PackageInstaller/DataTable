-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_summon_master_ji_activity.lua

module("logicconfig.config.t_summon_master_ji_activity", package.seeall)

local title = {
	challengeId = 7,
	jumpTo2 = 9,
	activityId = 1,
	normalPassProgress = 5,
	jumpTo3 = 10,
	normalPrize = 6,
	redPointId = 11,
	jumpTo1 = 8,
	extremeDailyResetTimes = 4,
	extremePassScore = 2,
	extremePrize = 3
}
local dataList = {
	{
		348001,
		60,
		"100:16024:1:1",
		999,
		90,
		"100:16024:1:1",
		158,
		"func#545#25",
		"mibao#rexueguixin3",
		"func#618#16024",
		571
	}
}
local t_summon_master_ji_activity = {
	[348001] = dataList[1]
}

t_summon_master_ji_activity.dataList = dataList

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

return t_summon_master_ji_activity
