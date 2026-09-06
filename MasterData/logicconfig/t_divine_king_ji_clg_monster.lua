-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_divine_king_ji_clg_monster.lua

module("logicconfig.config.t_divine_king_ji_clg_monster", package.seeall)

local title = {
	selfBuffProviderId = 10,
	name = 2,
	WinDesc = 4,
	skipTime = 5,
	retreatMsgType = 9,
	formCondition = 11,
	stageDesc = 13,
	btlMode = 7,
	btlBg = 6,
	missionDesc = 3,
	winId = 8,
	creepsMasterId = 1,
	heroSkillId = 12
}
local dataList = {
	{
		1001,
		"神曜王极-1",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1002,
		"神曜王极-2",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1003,
		"神曜王极-3",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1004,
		"神曜王极-4",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1005,
		"神曜王极-5",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1006,
		"神曜王极-6",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1007,
		"神曜王极-7",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		0,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1008,
		"神曜王极-8",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	},
	{
		1009,
		"神曜王极-9",
		"击败敌阵全体精灵即可过关",
		"击败敌阵全体精灵即可过关",
		3,
		"",
		"",
		0,
		0,
		411,
		0,
		"",
		"击败敌阵全体精灵，即可通关。"
	}
}
local t_divine_king_ji_clg_monster = {
	[1001] = dataList[1],
	[1002] = dataList[2],
	[1003] = dataList[3],
	[1004] = dataList[4],
	[1005] = dataList[5],
	[1006] = dataList[6],
	[1007] = dataList[7],
	[1008] = dataList[8],
	[1009] = dataList[9]
}

t_divine_king_ji_clg_monster.dataList = dataList

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

return t_divine_king_ji_clg_monster
