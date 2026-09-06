-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_night_feast_boss_clg_activity.lua

module("logicconfig.config.t_night_feast_boss_clg_activity", package.seeall)

local title = {
	buffPointName = 11,
	creepsMasterId = 5,
	buffIconPath = 12,
	storyId = 8,
	dailyFightBossCount = 4,
	exchangeJumpTo = 10,
	dailyResetBuffCount = 7,
	redPointId = 2,
	raceId = 3,
	dailyGenStageCount = 6,
	activityId = 1,
	ruleKey = 9
}
local dataList = {
	{
		335001,
		550,
		1402201,
		5,
		9999,
		6,
		3,
		4600004,
		"",
		"",
		"",
		""
	},
	{
		335002,
		550,
		1402201,
		5,
		9999,
		6,
		3,
		4600004,
		"NightFeastBossClg_RuleKey",
		"func#191#530#530001",
		"Buff点名字",
		"com_icon_xingyunge"
	}
}
local t_night_feast_boss_clg_activity = {
	[335001] = dataList[1],
	[335002] = dataList[2]
}

t_night_feast_boss_clg_activity.dataList = dataList

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

return t_night_feast_boss_clg_activity
