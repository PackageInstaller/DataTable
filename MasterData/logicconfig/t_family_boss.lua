-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_family_boss.lua

module("logicconfig.config.t_family_boss", package.seeall)

local title = {
	familyLevel = 3,
	name = 10,
	onlineTime = 17,
	skipTime = 9,
	rewardShow = 7,
	openConsume = 2,
	btlBg = 12,
	enableGainExp = 15,
	challengeCount = 4,
	creepsMasterId = 5,
	heroSkillId = 13,
	contTime = 8,
	offlineTime = 18,
	rule = 11,
	btlMode = 16,
	rewardId = 6,
	id = 1,
	recommendZdl = 14
}
local dataList = {
	{
		1,
		0,
		1,
		2,
		1,
		1,
		"4:30001:0#4:50005:0#8:5:0",
		0,
		15,
		"试炼·合金猪",
		"敌方合金猪属性大幅提升",
		"",
		"",
		40000,
		false,
		"",
		"2021-04-01T05:00:00",
		"2030-12-31T05:00:00"
	},
	{
		2,
		10000,
		2,
		2,
		2,
		2,
		"4:30001:0#4:50005:0#4:50006:0#8:5:0",
		24,
		15,
		"试炼·黄金龙",
		"敌方黄金圣龙属性大幅提升",
		"",
		"",
		80000,
		false,
		"",
		"2021-04-01T05:00:00",
		"2022-12-23T05:00:00"
	},
	{
		3,
		50000,
		2,
		2,
		3,
		3,
		"4:30001:0#4:50008:0#4:50007:0#8:5:0",
		72,
		15,
		"试炼·青骨",
		"敌方青骨属性大幅提升",
		"",
		"",
		400000,
		false,
		"",
		"2022-12-23T05:00:00",
		"2030-12-31T05:00:00"
	}
}
local t_family_boss = {
	dataList[1],
	dataList[2],
	dataList[3]
}

t_family_boss.dataList = dataList

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

return t_family_boss
