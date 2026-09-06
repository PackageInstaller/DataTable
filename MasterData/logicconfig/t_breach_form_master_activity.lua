-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_breach_form_master_activity.lua

module("logicconfig.config.t_breach_form_master_activity", package.seeall)

local title = {
	coin = 6,
	challengeClosedTimeRange = 5,
	defenseBattleReportLimit = 4,
	attackRankDesc = 9,
	jumpToShop = 7,
	defenseRankDesc = 10,
	defenseFormZdlWanPercent = 3,
	dailySetDefenseFormTimes = 2,
	playerBattleSkipTime = 8,
	activityId = 1
}
local dataList = {
	{
		593001,
		1,
		{
			2200000,
			99999999
		},
		30,
		"02:00:00-09:00:00",
		"10:593001:1",
		"func#191#593#593001",
		5,
		"根据破阵分排名，前8名将成为下周的守卫。",
		"根据本周成为守卫的奥奇防守积分进行排名。"
	}
}
local t_breach_form_master_activity = {
	[593001] = dataList[1]
}

t_breach_form_master_activity.dataList = dataList

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

return t_breach_form_master_activity
