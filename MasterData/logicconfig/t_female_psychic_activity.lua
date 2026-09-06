-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_female_psychic_activity.lua

module("logicconfig.config.t_female_psychic_activity", package.seeall)

local title = {
	raceIdAddScore = 4,
	activeFemaleAddScore = 8,
	recZdl = 9,
	raceIdBuffs = 5,
	signIdAddScore = 7,
	signInBuffId = 6,
	jumpToRank = 11,
	raceIdShouldOnForm = 3,
	jumpToShop = 10,
	jumpToFullRefund = 13,
	upgradeBuffPlanId = 14,
	psychicAddScore = 2,
	activityId = 1,
	jumpToLottery = 12
}
local dataList = {
	{
		253001,
		10,
		true,
		5,
		"20049101:99",
		20049102,
		2,
		2,
		50000,
		"mibao#nvshentehui1",
		"func#618#16014",
		"func#867",
		"",
		0
	},
	{
		253002,
		0,
		false,
		5,
		"20049101:99",
		20049102,
		2,
		0,
		50000,
		"mibao#jinglingyangcheng",
		"func#618#16029",
		"func#1119",
		"func#545#3",
		1
	}
}
local t_female_psychic_activity = {
	[253001] = dataList[1],
	[253002] = dataList[2]
}

t_female_psychic_activity.dataList = dataList

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

return t_female_psychic_activity
