-- chunkname: @modules/logic/versionactivity3_0/maLiAnNaAct201/define/Activity201MaLiAnNaEnum.lua

module("modules.logic.versionactivity3_0.maLiAnNaAct201.define.Activity201MaLiAnNaEnum", package.seeall)

local Activity201MaLiAnNaEnum = _M

Activity201MaLiAnNaEnum.EpisodeStatus = {
	BeforeStory = 0,
	MapGame = 1,
	Finished = 3,
	AfterStory = 2
}
Activity201MaLiAnNaEnum.SoldierType = {
	hero = 1,
	soldier = 0
}
Activity201MaLiAnNaEnum.CampType = {
	Player = 1,
	Middle = 3,
	Enemy = 2
}
Activity201MaLiAnNaEnum.RoadType = {
	RailWay = 1,
	HighWay = 2
}
Activity201MaLiAnNaEnum.SoliderState = {
	Moving = 1,
	Attack = 2,
	AttackSlot = 6,
	StopMove = 5,
	InSlot = 3,
	Dead = 4
}
Activity201MaLiAnNaEnum.ConditionType = {
	gameOverAndWin = 4,
	gameStart = 3,
	occupySlot = 1,
	useSkill = 5,
	soldierHeroDead = 2
}
Activity201MaLiAnNaEnum.bulletHideRange = 10
Activity201MaLiAnNaEnum.defaultDragRange = 50
Activity201MaLiAnNaEnum.defaultHideRange = 30
Activity201MaLiAnNaEnum.defaultOffsetX = 0
Activity201MaLiAnNaEnum.defaultOffsetY = 0
Activity201MaLiAnNaEnum.defaultHideLineRange = 120
Activity201MaLiAnNaEnum.bulletDamage = 1
Activity201MaLiAnNaEnum.refreshViewInterval = 0.1
Activity201MaLiAnNaEnum.attackTime = 0.5
Activity201MaLiAnNaEnum.attackTime2 = 1
Activity201MaLiAnNaEnum.enemyLineShowTime = 1.5
Activity201MaLiAnNaEnum.MaLiAnNaSoliderEntityDefaultScale = 0.5
Activity201MaLiAnNaEnum.attackSlotTime = 0.1
Activity201MaLiAnNaEnum.SkillAction = {
	addSlotSolider = 1,
	killSolider = 1005,
	removeSlotSolider = 2,
	releaseBullet = 1003,
	moveSlotSolider = 4,
	pauseSlotGenerateSolider = 3,
	upSlotGenerateSoliderSpeed = 1001,
	enterSlotAddSolider = 1002,
	slotShield = 1004
}
Activity201MaLiAnNaEnum.SkillType = {
	passive = 1,
	active = 2
}
Activity201MaLiAnNaEnum.SkillOpt = {
	add = 1,
	delete = 0
}
Activity201MaLiAnNaEnum.SlotType = {
	trench = 2,
	bunker = 3,
	obstacle = 1,
	normal = 0
}
Activity201MaLiAnNaEnum.CampImageName = {
	[Activity201MaLiAnNaEnum.CampType.Player] = "v3a0_malianna_game_rolehead1",
	[Activity201MaLiAnNaEnum.CampType.Enemy] = "v3a0_malianna_game_rolehead2",
	[Activity201MaLiAnNaEnum.CampType.Middle] = "v3a0_malianna_game_rolehead3"
}
Activity201MaLiAnNaEnum.BulletEffect = {
	"ui/viewres/versionactivity_3_0/v3a0_malianna/v3a0_malianna_effectview.prefab"
}
Activity201MaLiAnNaEnum.SlotAIFuncType = {
	retreat = 3,
	attackRoad = 2,
	helpSlot = 4,
	attAckSlot = 1
}
Activity201MaLiAnNaEnum.AllSlotAIFuncType = {
	Activity201MaLiAnNaEnum.SlotAIFuncType.attAckSlot,
	Activity201MaLiAnNaEnum.SlotAIFuncType.attackRoad,
	Activity201MaLiAnNaEnum.SlotAIFuncType.retreat,
	Activity201MaLiAnNaEnum.SlotAIFuncType.helpSlot
}
Activity201MaLiAnNaEnum.soliderGenerateIdByCamp = {
	middleSolider = 13,
	enemySolider = 12,
	mySolider = 11
}
Activity201MaLiAnNaEnum.tipBgByCamp = {
	[Activity201MaLiAnNaEnum.CampType.Player] = "v3a0_malianna_game_tipbg5",
	[Activity201MaLiAnNaEnum.CampType.Enemy] = "v3a0_malianna_game_tipbg6"
}
Activity201MaLiAnNaEnum.tipIconByCamp = {
	[Activity201MaLiAnNaEnum.CampType.Player] = "v3a0_malianna_game_tipicon1",
	[Activity201MaLiAnNaEnum.CampType.Enemy] = "v3a0_malianna_game_tipicon2"
}
Activity201MaLiAnNaEnum.slotAnimName = {
	skill = "skill",
	my = "occupy_my",
	enemy = "occupy_enemy",
	help = "help",
	attack = "attck",
	middle = "idle",
	myIdle = "occupy_my_idle",
	enemyIdle = "occupy_enemy_idle"
}
Activity201MaLiAnNaEnum.resultType = {
	success = "成功",
	cancel = "主动返回",
	fail = "失败",
	reset = "重置"
}
Activity201MaLiAnNaEnum.FailResultType = {
	myHeroDead = "英雄剩余血量归零",
	timeOut = "计时超时",
	mySlotDead = "己方大本营被攻占"
}

return Activity201MaLiAnNaEnum
