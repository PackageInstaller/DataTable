-- chunkname: @modules/logic/fight/config/FightRightElementEnum.lua

module("modules.logic.fight.config.FightRightElementEnum", package.seeall)

local FightRightElementEnum = _M
local EnumIndex = 0

local function GetEnum()
	EnumIndex = EnumIndex + 1

	return EnumIndex
end

FightRightElementEnum.Elements = {
	BossRush = GetEnum(),
	CharSupport = GetEnum(),
	MelodyLevel = GetEnum(),
	MelodySkill = GetEnum(),
	RougeCoin = GetEnum(),
	RougeGongMing = GetEnum(),
	RougeTongPin = GetEnum(),
	AssistBoss = GetEnum(),
	AssistBossScore = GetEnum(),
	DoomsdayClock = GetEnum(),
	DouQuQuDice = GetEnum(),
	Dice = GetEnum(),
	DouQuQuCoin = GetEnum(),
	DouQuQuHunting = GetEnum(),
	SurvivalTalent = GetEnum(),
	DeepScore_500M = GetEnum(),
	DouQuQuBoss = GetEnum(),
	SurvivalTalent2 = GetEnum(),
	Rouge2RevivalCoin = GetEnum(),
	Rouge2Treasure = GetEnum(),
	Rouge2Task = GetEnum(),
	AssistRole = GetEnum(),
	PaTaComposeScore = GetEnum(),
	Rouge2Slapstick = GetEnum(),
	CelebrityCard3_5 = GetEnum(),
	DeviceLV = GetEnum(),
	SystemFightTask = GetEnum()
}
FightRightElementEnum.Priority = {
	FightRightElementEnum.Elements.SystemFightTask,
	FightRightElementEnum.Elements.Rouge2Slapstick,
	FightRightElementEnum.Elements.CelebrityCard3_5,
	FightRightElementEnum.Elements.DouQuQuDice,
	FightRightElementEnum.Elements.Dice,
	FightRightElementEnum.Elements.BossRush,
	FightRightElementEnum.Elements.SurvivalTalent,
	FightRightElementEnum.Elements.MelodyLevel,
	FightRightElementEnum.Elements.MelodySkill,
	FightRightElementEnum.Elements.AssistBossScore,
	FightRightElementEnum.Elements.AssistBoss,
	FightRightElementEnum.Elements.DoomsdayClock,
	FightRightElementEnum.Elements.DouQuQuCoin,
	FightRightElementEnum.Elements.DouQuQuHunting,
	FightRightElementEnum.Elements.DouQuQuBoss,
	FightRightElementEnum.Elements.RougeCoin,
	FightRightElementEnum.Elements.RougeGongMing,
	FightRightElementEnum.Elements.RougeTongPin,
	FightRightElementEnum.Elements.CharSupport,
	FightRightElementEnum.Elements.DeepScore_500M,
	FightRightElementEnum.Elements.SurvivalTalent2,
	FightRightElementEnum.Elements.Rouge2RevivalCoin,
	FightRightElementEnum.Elements.Rouge2Treasure,
	FightRightElementEnum.Elements.Rouge2Task,
	FightRightElementEnum.Elements.PaTaComposeScore,
	FightRightElementEnum.Elements.AssistRole,
	FightRightElementEnum.Elements.DeviceLV
}
FightRightElementEnum.ElementsSizeDict = {
	[FightRightElementEnum.Elements.CelebrityCard3_5] = Vector2(200, 135),
	[FightRightElementEnum.Elements.DouQuQuDice] = Vector2(540, 120),
	[FightRightElementEnum.Elements.Dice] = Vector2(540, 150),
	[FightRightElementEnum.Elements.BossRush] = Vector2(200, 135),
	[FightRightElementEnum.Elements.CharSupport] = Vector2(200, 130),
	[FightRightElementEnum.Elements.MelodyLevel] = Vector2(300, 50),
	[FightRightElementEnum.Elements.MelodySkill] = Vector2(200, 175),
	[FightRightElementEnum.Elements.RougeCoin] = Vector2(220, 84),
	[FightRightElementEnum.Elements.RougeGongMing] = Vector2(327, 111),
	[FightRightElementEnum.Elements.RougeTongPin] = Vector2(412.9, 111),
	[FightRightElementEnum.Elements.AssistBoss] = Vector2(200, 200),
	[FightRightElementEnum.Elements.AssistBossScore] = Vector2(200, 100),
	[FightRightElementEnum.Elements.DoomsdayClock] = Vector2(200, 350),
	[FightRightElementEnum.Elements.DouQuQuCoin] = Vector2(400, 80),
	[FightRightElementEnum.Elements.DouQuQuHunting] = Vector2(220, 60),
	[FightRightElementEnum.Elements.SurvivalTalent] = Vector2(240, 200),
	[FightRightElementEnum.Elements.DeepScore_500M] = Vector2(300, 500),
	[FightRightElementEnum.Elements.DouQuQuBoss] = Vector2(200, 140),
	[FightRightElementEnum.Elements.SurvivalTalent2] = Vector2(200, 200),
	[FightRightElementEnum.Elements.Rouge2RevivalCoin] = Vector2(220, 80),
	[FightRightElementEnum.Elements.Rouge2Treasure] = Vector2(120, 290),
	[FightRightElementEnum.Elements.Rouge2Task] = Vector2(120, 120),
	[FightRightElementEnum.Elements.AssistRole] = Vector2(150, 150),
	[FightRightElementEnum.Elements.PaTaComposeScore] = Vector2(496, 104),
	[FightRightElementEnum.Elements.Rouge2Slapstick] = Vector2(200, 200),
	[FightRightElementEnum.Elements.DeviceLV] = Vector2(340, 130),
	[FightRightElementEnum.Elements.SystemFightTask] = Vector2(540, 160)
}
FightRightElementEnum.ElementsNodeName = {
	[FightRightElementEnum.Elements.BossRush] = "bossrush_score",
	[FightRightElementEnum.Elements.CharSupport] = "#go_charsupport",
	[FightRightElementEnum.Elements.MelodyLevel] = "melody_level",
	[FightRightElementEnum.Elements.MelodySkill] = "melody_skill",
	[FightRightElementEnum.Elements.RougeCoin] = "rougeCoin",
	[FightRightElementEnum.Elements.RougeGongMing] = "rougeGongMing",
	[FightRightElementEnum.Elements.RougeTongPin] = "rougeTongPin",
	[FightRightElementEnum.Elements.AssistBoss] = "assistboss",
	[FightRightElementEnum.Elements.AssistBossScore] = "assistbossscore",
	[FightRightElementEnum.Elements.DoomsdayClock] = "doomsdayclock",
	[FightRightElementEnum.Elements.DouQuQuDice] = "douququdice",
	[FightRightElementEnum.Elements.Dice] = "dice",
	[FightRightElementEnum.Elements.DouQuQuCoin] = "douququCoin",
	[FightRightElementEnum.Elements.DouQuQuHunting] = "douququHunting",
	[FightRightElementEnum.Elements.SurvivalTalent] = "survival_talent",
	[FightRightElementEnum.Elements.DeepScore_500M] = "deep_score_500m",
	[FightRightElementEnum.Elements.DouQuQuBoss] = "douququBoss",
	[FightRightElementEnum.Elements.SurvivalTalent2] = "survivalTalent2",
	[FightRightElementEnum.Elements.Rouge2RevivalCoin] = "rouge2_revival_coin",
	[FightRightElementEnum.Elements.Rouge2Treasure] = "rouge2_treasure",
	[FightRightElementEnum.Elements.Rouge2Task] = "rouge2_task",
	[FightRightElementEnum.Elements.AssistRole] = "assist_role",
	[FightRightElementEnum.Elements.PaTaComposeScore] = "tower_compose_score",
	[FightRightElementEnum.Elements.Rouge2Slapstick] = "rouge2_slapstick",
	[FightRightElementEnum.Elements.CelebrityCard3_5] = "celebrityCard3_5",
	[FightRightElementEnum.Elements.DeviceLV] = "device_lv",
	[FightRightElementEnum.Elements.SystemFightTask] = "system_fight_task"
}
FightRightElementEnum.AnchorTweenDuration = 0.2

return FightRightElementEnum
