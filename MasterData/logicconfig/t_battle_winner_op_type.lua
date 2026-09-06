-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicconfig/config/t_battle_winner_op_type.lua

module("logicconfig.config.t_battle_winner_op_type", package.seeall)

local title = {
	desc = 3,
	paramNames = 2,
	winDesc = 4,
	type = 1
}
local dataList = {
	{
		"RestraintAtt",
		{
			"rst"
		},
		"",
		""
	},
	{
		"RestraintDef",
		{
			"rst"
		},
		"",
		""
	},
	{
		"DamageTotalRange",
		{
			"totalDamage"
		},
		"伤害：%s<%s<%s",
		"伤害：%s<%s<%s"
	},
	{
		"RivalTotalDropHp",
		{
			"dropHp"
		},
		"",
		""
	},
	{
		"KillNum",
		{
			"killNum"
		},
		"击杀敌方精灵数目 %d只",
		"击杀敌方精灵数目 %d只"
	},
	{
		"DamageTotal",
		{
			"totalDamage"
		},
		"对敌方精灵造成的总伤害<color=#c54949>%d</color>点",
		"对敌方精灵造成的总伤害<color=#c54949>%d</color>点"
	},
	{
		"DieCount",
		{
			"dieCount"
		},
		"我方阵亡精灵数量不超过%d只",
		"我方阵亡精灵数量不超过%d只"
	},
	{
		"ActiveCount",
		{
			"activeCount"
		},
		"我方存活精灵数量大于等于%d只",
		"我方存活精灵数量大于等于%d只"
	},
	{
		"MyRaceIdMustActive",
		nil,
		"战斗胜利时，我方%s精灵存活",
		"战斗胜利时，我方%s精灵存活"
	},
	{
		"MyPosIdMustActive",
		nil,
		"战斗胜利时，我方%s号位精灵存活",
		"战斗胜利时，我方%s号位精灵存活"
	},
	{
		"EnemyRaceIdMustDie",
		nil,
		"",
		""
	},
	{
		"EnemyPosIdMustDie",
		nil,
		"",
		""
	},
	{
		"MyCriticalNum",
		{
			"critical"
		},
		"",
		""
	},
	{
		"MyDodgeNum",
		{
			"dodge"
		},
		"",
		""
	},
	{
		"EnemyDodgeNum",
		{
			"dodge"
		},
		"",
		""
	},
	{
		"CircleCount",
		nil,
		"%s回合内结束战斗",
		"%s回合内结束战斗"
	},
	{
		"MyActivePetContainsAttrs",
		{
			"count"
		},
		"我方%s属性精灵存活大于等于%s只",
		"我方%s属性精灵存活大于等于%s只"
	},
	{
		"PosHpRate",
		{
			"hpRate"
		},
		"我方%s号位战斗结束时，血量超过%d%%",
		"我方%s号位战斗结束时，血量超过%d%%"
	},
	{
		"TargetDodgeLimitNum",
		{
			"dodge"
		},
		"",
		""
	},
	{
		"TargetCriticalLimitNum",
		{
			"critical"
		},
		"",
		""
	},
	{
		"EqualCircleCount",
		nil,
		"必须坚持%s回合数后胜利",
		"必须坚持%s回合数后胜利"
	},
	{
		"CharacterActiveNum",
		{
			"count"
		},
		"符合布阵要求的存活精灵达到%s只",
		"符合布阵要求的存活精灵达到%s只"
	},
	{
		"BuffNum",
		{
			"buffNum"
		},
		"",
		""
	},
	{
		"EnemyBuffNum",
		{
			"buffNum"
		},
		"",
		""
	},
	{
		"ActiveCountLessThan",
		{
			"activeCount"
		},
		"我方存活精灵数量小于等于%d只",
		"我方存活精灵数量小于等于%d只"
	},
	{
		"EnemyActiveCount",
		{
			"enemyActiveCount"
		},
		"敌阵存活精灵数量大于等于%d只 <color=#%s>(%s/%s)</color>",
		"敌阵存活精灵数量大于等于%d只"
	},
	{
		"EnemyActiveLessThanCount",
		{
			"enemyActiveLessThanCount"
		},
		"敌阵存活精灵数量小于等于%d只 <color=#%s>(%s/%s)</color>",
		"敌阵存活精灵数量小于等于%d只"
	},
	{
		"RaceHpRate",
		{
			"hpRate"
		},
		"我方%s战斗结束时，血量超过%d%% <color=#%s>(%s/%s)</color>",
		"我方%s战斗结束时，血量超过%d%%"
	}
}
local t_battle_winner_op_type = {
	RestraintAtt = dataList[1],
	RestraintDef = dataList[2],
	DamageTotalRange = dataList[3],
	RivalTotalDropHp = dataList[4],
	KillNum = dataList[5],
	DamageTotal = dataList[6],
	DieCount = dataList[7],
	ActiveCount = dataList[8],
	MyRaceIdMustActive = dataList[9],
	MyPosIdMustActive = dataList[10],
	EnemyRaceIdMustDie = dataList[11],
	EnemyPosIdMustDie = dataList[12],
	MyCriticalNum = dataList[13],
	MyDodgeNum = dataList[14],
	EnemyDodgeNum = dataList[15],
	CircleCount = dataList[16],
	MyActivePetContainsAttrs = dataList[17],
	PosHpRate = dataList[18],
	TargetDodgeLimitNum = dataList[19],
	TargetCriticalLimitNum = dataList[20],
	EqualCircleCount = dataList[21],
	CharacterActiveNum = dataList[22],
	BuffNum = dataList[23],
	EnemyBuffNum = dataList[24],
	ActiveCountLessThan = dataList[25],
	EnemyActiveCount = dataList[26],
	EnemyActiveLessThanCount = dataList[27],
	RaceHpRate = dataList[28]
}

t_battle_winner_op_type.dataList = dataList

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

return t_battle_winner_op_type
