-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_timed_challenge_miya_normal_monster.lua

module("logicconfig.config.t_timed_challenge_miya_normal_monster", package.seeall)

local title = {
	btlBg = 5,
	name = 2,
	winRule2 = 13,
	skipTime = 4,
	creepMasterHeadIcon = 3,
	playRule2 = 11,
	raidersText1 = 14,
	enableGainExp = 8,
	creepsMasterId = 1,
	heroSkillId = 7,
	formCondition = 6,
	winRule1 = 12,
	btlMode = 9,
	raidersCondition2 = 17,
	raidersCondition1 = 15,
	playRule1 = 10,
	raidersText2 = 16
}
local dataList = {
	{
		1,
		"时空乱局-简单",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		2,
		"时空乱局-简单",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		3,
		"时空乱局-简单",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		4,
		"时空乱局-适中",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		5,
		"时空乱局-适中",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		6,
		"时空乱局-适中",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		7,
		"时空乱局-困难",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		8,
		"时空乱局-困难",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		9,
		"时空乱局-困难",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	},
	{
		10,
		"时空乱局-深渊",
		10147,
		15,
		"",
		0,
		"",
		false,
		"",
		"无",
		"",
		"击败敌阵全部精灵，即可通关。",
		"",
		"",
		"",
		"",
		""
	}
}
local t_timed_challenge_miya_normal_monster = {
	dataList[1],
	dataList[2],
	dataList[3],
	dataList[4],
	dataList[5],
	dataList[6],
	dataList[7],
	dataList[8],
	dataList[9],
	dataList[10]
}

t_timed_challenge_miya_normal_monster.dataList = dataList

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

return t_timed_challenge_miya_normal_monster
