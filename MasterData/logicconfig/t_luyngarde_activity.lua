-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_luyngarde_activity.lua

module("logicconfig.config.t_luyngarde_activity", package.seeall)

local title = {
	c2DailyTimes = 4,
	shopJump = 11,
	c4ShowSkinId = 12,
	lockRaceId = 14,
	c2BossHp = 3,
	c4CreepsMasterId = 8,
	c3RefreshCd = 7,
	c4TimesOneRound = 9,
	c3ShowSkinId = 6,
	c3HelpCd = 5,
	redPointId = 2,
	upgradeCostItem = 10,
	activityId = 1,
	ruleKey = 13
}
local dataList = {
	{
		466001,
		685,
		"20000000000000",
		3,
		60,
		15032,
		60,
		401,
		3,
		"10:466002",
		"func#191#466#466001",
		11028,
		"luyngarde_activity_rule_key",
		15032
	}
}
local t_luyngarde_activity = {
	[466001] = dataList[1]
}

t_luyngarde_activity.dataList = dataList

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

return t_luyngarde_activity
