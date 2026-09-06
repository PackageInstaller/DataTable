-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_ji_clg_activity.lua

module("logicconfig.config.t_ji_clg_activity", package.seeall)

local title = {
	activityId = 1,
	normalPassRedPointId = 10,
	dailyClgNormalStageTimes = 4,
	normalPassPrize = 6,
	extremeTotalScoreLimit = 7,
	exremePassPrize = 9,
	comPlanId = 2,
	dailyClgNormalBossTimes = 5,
	normalBossId = 3,
	extremeScoreRange = 8,
	prizeRedPointId = 11
}
local dataList = {
	{
		420001,
		1,
		1006,
		1,
		3,
		"100:16009:1:1",
		5000,
		{
			900,
			1100
		},
		"100:16009:1:1",
		637,
		638
	}
}
local t_ji_clg_activity = {
	[420001] = dataList[1]
}

t_ji_clg_activity.dataList = dataList

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

return t_ji_clg_activity
