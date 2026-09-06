-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_pupil_challenge_stage.lua

module("logicconfig.config.t_pupil_challenge_stage", package.seeall)

local title = {
	showFaceId = 10,
	name = 5,
	popCondition = 18,
	skipTime = 11,
	retreatMsgType = 15,
	battleDesc = 7,
	prize = 6,
	btlBg = 12,
	missionDesc = 8,
	creepsMasterId = 4,
	stage = 3,
	challengePlanId = 1,
	challengeType = 2,
	WinDesc = 9,
	formCondition = 16,
	btlMode = 13,
	winId = 14,
	popExplanation = 17
}
local dataList = {
	{
		1,
		1,
		1,
		1001,
		"不熄火种·其一",
		"104:2:10",
		"通关后会将战斗回合数变成火种数",
		"通关后会将战斗回合数变成火种数",
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
		1,
		1,
		2,
		1002,
		"不熄火种·其二",
		"104:2:10",
		"通关后会将战斗回合数变成火种数",
		"通关后会将战斗回合数变成火种数",
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
		1,
		1,
		3,
		1003,
		"不熄火种·其三",
		"104:2:10",
		"通关后会将战斗回合数变成火种数",
		"通关后会将战斗回合数变成火种数",
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
		1,
		1,
		4,
		1004,
		"不熄火种·其四",
		"104:2:10",
		"通关后会将战斗回合数变成火种数",
		"通关后会将战斗回合数变成火种数",
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
		1,
		2,
		1,
		2001,
		"复仇之焰·15",
		"104:2:10",
		"",
		"敌阵全体精灵攻击+<color=#F84F89FF>15</color>%",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"敌阵全体精灵攻击+<color=#F84F89FF>15</color>%",
		"击败敌方所有精灵"
	},
	{
		1,
		2,
		2,
		2002,
		"复仇之焰·11",
		"104:2:10",
		"",
		"敌阵全体精灵每回合恢复生命<color=#F84F89FF>11</color>%",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"敌阵全体精灵每回合恢复生命<color=#F84F89FF>11</color>%",
		"击败敌方所有精灵"
	},
	{
		1,
		2,
		3,
		2003,
		"复仇之焰·8",
		"104:2:10",
		"",
		"敌阵瞳首次可连续出手<color=#F84F89FF>8</color>次",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		0,
		"敌阵瞳首次可连续出手<color=#F84F89FF>8</color>次",
		"击败敌方所有精灵"
	},
	{
		1,
		3,
		1,
		3001,
		"恶魔双生·火",
		"104:2:10",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		11,
		"1.恶魔双生，分别击败2只瞳\r\n2.恶魔双生·火只能上阵火属性精灵\r\n3.恶魔双生·暗只能上阵暗属性精灵\r\n4.两次挑战的回合数相差在1回合以内\r\n5.无论胜负消耗挑战次数\r\n6.每天剩余量为0时，无法进入挑战\r\n7.通过恶魔双生任意模式，仅可获得一只瞳",
		"两次挑战回合数相差<color=#F84F89FF>1</color>以内"
	},
	{
		1,
		3,
		2,
		3002,
		"恶魔双生·暗",
		"104:2:10",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		13,
		"",
		"两次挑战回合数相差<color=#F84F89FF>1</color>以内"
	},
	{
		1,
		4,
		1,
		4001,
		"恶魔双生·火",
		"104:2:10",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		11,
		"1.更高难度的恶魔双生，分别击败2只瞳\r\n2.恶魔双生·火只能上阵火属性精灵\r\n3.恶魔双生·暗只能上阵暗属性精灵\r\n4.两次挑战的回合数相差在1回合以内\r\n5.无论胜负消耗挑战次数\r\n6.通过恶魔双生任意模式，仅可获得一只瞳",
		"两次挑战回合数相差<color=#F84F89FF>1</color>以内"
	},
	{
		1,
		4,
		2,
		4002,
		"恶魔双生·暗",
		"104:2:10",
		"",
		"",
		"击败敌方所有精灵",
		0,
		15,
		"",
		"",
		0,
		0,
		13,
		"",
		"两次挑战回合数相差<color=#F84F89FF>1</color>以内"
	}
}
local t_pupil_challenge_stage = {
	{
		{
			dataList[1],
			dataList[2],
			dataList[3],
			dataList[4]
		},
		{
			dataList[5],
			dataList[6],
			dataList[7]
		},
		{
			dataList[8],
			dataList[9]
		},
		{
			dataList[10],
			dataList[11]
		}
	}
}

t_pupil_challenge_stage.dataList = dataList

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

return t_pupil_challenge_stage
