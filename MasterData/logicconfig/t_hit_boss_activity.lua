-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_hit_boss_activity.lua

module("logicconfig.config.t_hit_boss_activity", package.seeall)

local title = {
	bossId = 2,
	comPlanId = 6,
	dailyClgTimes = 3,
	raceId = 4,
	activityId = 1,
	desc = 5
}
local dataList = {
	{
		327001,
		1001,
		3,
		18001,
		"五个大回合后结束战斗",
		1
	},
	{
		327002,
		1002,
		3,
		12022,
		"五个大回合后结束战斗",
		2
	},
	{
		327003,
		1002,
		3,
		12022,
		"五个大回合后结束战斗",
		2
	}
}
local t_hit_boss_activity = {
	[327001] = dataList[1],
	[327002] = dataList[2],
	[327003] = dataList[3]
}

t_hit_boss_activity.dataList = dataList

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

return t_hit_boss_activity
