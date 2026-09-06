-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_demon_descend_activity.lua

module("logicconfig.config.t_demon_descend_activity", package.seeall)

local title = {
	bossChallengeBuffNum = 5,
	wineItem = 6,
	signInGainRedWine = 3,
	dailyUnlockStage = 4,
	dailyBossChallengeTime = 2,
	redPointId = 7,
	creepsMasterId = 9,
	ruleKeyMain = 8,
	activityId = 1
}
local dataList = {
	{
		497001,
		3,
		10,
		2,
		1,
		"1004:1551",
		715,
		"fuyao_story3_rule",
		1007
	}
}
local t_demon_descend_activity = {
	[497001] = dataList[1]
}

t_demon_descend_activity.dataList = dataList

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

return t_demon_descend_activity
