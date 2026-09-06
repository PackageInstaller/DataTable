-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dumpling_feast_activity.lua

module("logicconfig.config.t_dumpling_feast_activity", package.seeall)

local title = {
	dailyBossClgTimes = 5,
	oneClickMakeDumplingNeedBestTimes = 6,
	bowlNum = 8,
	supportPetPlan = 14,
	maxStuffFillingSeconds = 10,
	maxBoilSeconds = 11,
	bossCreepsMasterId = 4,
	feedLoveDumplingBonus = 13,
	rollDoughNeedItem = 12,
	maxRollDoughSeconds = 9,
	redPointId = 2,
	potNum = 7,
	ruleKeyMain = 15,
	activityId = 1,
	bossSkinId = 3
}
local dataList = {
	{
		562001,
		758,
		1202106,
		1001,
		3,
		10,
		3,
		3,
		6,
		6,
		9,
		"10:562004:1",
		2,
		1,
		"DumplingFeast_rule"
	}
}
local t_dumpling_feast_activity = {
	[562001] = dataList[1]
}

t_dumpling_feast_activity.dataList = dataList

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

return t_dumpling_feast_activity
