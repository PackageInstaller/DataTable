-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_dragon_awaken_activity.lua

module("logicconfig.config.t_dragon_awaken_activity", package.seeall)

local title = {
	plotId = 6,
	holyStripeOpen = 11,
	mainCost = 3,
	ruleKey = 8,
	equipmentOpen = 9,
	starGodPlusOpen = 10,
	activityId = 1,
	awakenOpen = 12,
	shopGotoStr = 7,
	dailyTrainingTimes = 2,
	lvUpCost = 4,
	recruitCost = 5
}
local dataList = {
	{
		419001,
		3,
		"66:15:1",
		"10:419002:1",
		"10:419003:1",
		4730001,
		"func#191#419#419001",
		"dragonawakenview_rule",
		6,
		4,
		2,
		8
	},
	{
		419002,
		3,
		"66:17:1",
		"10:419005:1",
		"10:419006:1",
		4790001,
		"func#191#419#419002",
		"dragonawakenview_rule",
		6,
		4,
		2,
		8
	}
}
local t_dragon_awaken_activity = {
	[419001] = dataList[1],
	[419002] = dataList[2]
}

t_dragon_awaken_activity.dataList = dataList

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

return t_dragon_awaken_activity
