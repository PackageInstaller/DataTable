-- chunkname: @modules/logic/versionactivity2_7/lengzhou6/define/LengZhou6Enum.lua

module("modules.logic.versionactivity2_7.lengzhou6.define.LengZhou6Enum", package.seeall)

local LengZhou6Enum = class("LengZhou6Enum")

LengZhou6Enum.entityCamp = {
	enemy = 2,
	player = 1
}
LengZhou6Enum.TaskMOAllFinishId = -99999
LengZhou6Enum.SkillType = {
	passive = "passive",
	enemyActive = "enemyActive",
	active = "active"
}
LengZhou6Enum.BattleStep = {
	attackAfter = 208,
	attackComplete = 212,
	enemyCheckInterval = 900,
	attackBefore = 201,
	gameEnd = 1000,
	addBuff = 109,
	calHpBefore = 101,
	calHpAfter = 108,
	poisonSettlement = 910,
	gameBegin = 0
}
LengZhou6Enum.LoadingTime = 1
LengZhou6Enum.SkillEffect = {
	AddBuffByIntensified = "AddBuffByIntensified",
	EliminationDecreaseCd = "EliminationDecreaseCd",
	DealsDamage = "DealsDamage",
	DamageUpByIntensified = "DamageUpByIntensified",
	Heal = "Heal",
	AddBuff = "AddBuff",
	EliminationLevelUp = "EliminationLevelUp",
	Shuffle = "Shuffle",
	Contaminate = "Contaminate",
	HealUpByIntensified = "HealUpByIntensified",
	PetrifyEliminationBlock = "PetrifyEliminationBlock",
	EliminationCross = "EliminationCross",
	EliminationRange = "EliminationRange",
	EliminationDoubleAttack = "EliminationDoubleAttack",
	FreezeEliminationBlock = "FreezeEliminationBlock",
	SuccessiveElimination = "SuccessiveElimination",
	DamageUpByType = "DamageUpByType"
}
LengZhou6Enum.NormalEliminateEffect = "normal"
LengZhou6Enum.BuffEffect = {
	damageUp = "damageUp",
	petrify = "petrify",
	poison = "poison"
}
LengZhou6Enum.BattleModel = {
	infinite = "infinite",
	normal = "normal"
}
LengZhou6Enum.BattleProgress = {
	selectFinish = 2,
	selectSkill = 1
}
LengZhou6Enum.EnemySkillTime = 1
LengZhou6Enum.EnemySkillTime_2 = 0.5
LengZhou6Enum.EnemyBuffEffectShowTime = 0.5
LengZhou6Enum.enterGM = false
LengZhou6Enum.DebugPlayerHp = 10000000
LengZhou6Enum.PlayerSkillMaxCount = 3
LengZhou6Enum.DefaultEndLessBeginRound = 1
LengZhou6Enum.EndLessChangeSkillLayer = 5
LengZhou6Enum.BlockKey = {
	OneClickResetLevel = "LengZhou6OneClickResetLevelKey",
	OneClickClaimReward = "LengZhou6OneClickClaimRewardBlockKey"
}
LengZhou6Enum.openViewAniTime = 1.167
LengZhou6Enum.GameResult = {
	normalCancel = 3,
	lose = 2,
	infiniteCancel = 4,
	win = 1
}
LengZhou6Enum.defaultEnemy = 227101
LengZhou6Enum.defaultPlayerSkillSelectMax = 3

return LengZhou6Enum
