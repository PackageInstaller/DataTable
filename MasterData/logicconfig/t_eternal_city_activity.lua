-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_eternal_city_activity.lua

module("logicconfig.config.t_eternal_city_activity", package.seeall)

local title = {
	ruleKeyMain = 7,
	dailyRecruitTimes = 2,
	ruleKeyStage = 8,
	ruleKeyBoss = 9,
	bossClgStoreTimesLimit = 5,
	refreshPoolCost = 3,
	ruleKeyPetShop = 10,
	redPointId = 6,
	refreshBossClgTime = 4,
	activityId = 1
}
local dataList = {
	{
		557001,
		12,
		"10:557001:1000",
		6,
		5,
		756,
		"eternalcity_mainview_rule",
		"eternalcity_list_rule",
		"eternalcity_boss_rule",
		"eternalcity_hire_rule"
	}
}
local t_eternal_city_activity = {
	[557001] = dataList[1]
}

t_eternal_city_activity.dataList = dataList

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

return t_eternal_city_activity
