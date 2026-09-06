-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_2023_annual_fee_preheat_monster.lua

module("logicconfig.config.t_2023_annual_fee_preheat_monster", package.seeall)

local title = {
	retreatMsgType = 12,
	name = 2,
	WinDesc = 6,
	skipTime = 8,
	battleDesc = 4,
	formCondition = 13,
	prize = 3,
	btlMode = 10,
	btlBg = 9,
	missionDesc = 5,
	popCondition = 15,
	winId = 11,
	creepsMasterId = 1,
	showFaceId = 7,
	popExplanation = 14
}
local dataList = {
	{
		1001,
		"混乱精灵战斗",
		"8:1:30000",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"通关后会将战斗回合数变成火种数",
		"击败敌方所有精灵"
	},
	{
		1002,
		"混乱精灵战斗",
		"8:1:30000",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"通关后会将战斗回合数变成火种数",
		"击败敌方所有精灵"
	},
	{
		1003,
		"混乱精灵战斗",
		"8:1:30000",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"通关后会将战斗回合数变成火种数",
		"击败敌方所有精灵"
	}
}
local t_2023_annual_fee_preheat_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3]
}

t_2023_annual_fee_preheat_monster.dataList = dataList

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

return t_2023_annual_fee_preheat_monster
