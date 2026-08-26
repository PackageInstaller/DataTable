-- chunkname: @modules/logic/versionactivity2_2/eliminate/defines/EliminateEnum.lua

module("modules.logic.versionactivity2_2.eliminate.defines.EliminateEnum", package.seeall)

local EliminateEnum = class("EliminateEnum")

EliminateEnum.ChessState = {
	Frost = 1000,
	SpecialSkill = 10000,
	Selected = 10,
	Die = 100,
	Normal = 1
}
EliminateEnum.StepWorkType = {
	StartShowView = 5,
	LengZhou6PlayAudio = 23,
	RefreshEliminate = 10,
	PlayAudio = 9,
	ChangeState = 13,
	EliminateChessRevert = 16,
	EliminateChessUpdateGameInfo = 18,
	LengZhou6EnemyReleaseSkillStep = 19,
	Arrange = 2,
	LengZhou6EnemyGenerateSkillStep = 21,
	ChessItemUpdateInfo = 20,
	Debug = 4,
	EndShowView = 6,
	EliminateCheckAndRefresh = 22,
	Arrange_XY = 11,
	HandleData = 3,
	Die = 1,
	DieEffect = 12,
	CheckEliminate = 14,
	ShowEvaluate = 7,
	PlayEffect = 8,
	EliminateChessUpdateDamage = 17,
	EliminateChessDebug2_7 = 15,
	Move = 0
}
EliminateEnum.EffectType = {
	exchange_2 = 3,
	crossEliminate = 0,
	exchange_1 = 2,
	blockEliminate = 1
}
EliminateEnum.ChessBoardType = {
	Normal = 0,
	Empty = -1
}
EliminateEnum.RoundType = {
	Match3Chess = 0,
	TeamChess = 1
}
EliminateEnum.GetInfoType = {
	All = 0,
	OnlyMovePint = 1
}
EliminateEnum.AnimType = {
	drop = 1,
	init = 0,
	move = 2
}
EliminateEnum.AudioFightStep = {
	FightNormal = 1,
	ComeShow = 0,
	Victory = 2
}
EliminateEnum.ConditionType = {
	SettleAndToHaveDamage = "SettleAndToHaveDamage",
	TeamChessRoundBegin = "TeamChessRoundBegin",
	ClickMainCharacter = "ClickMainCharacter",
	MatchEvaluateViewClosed = "MatchEvaluateViewClosed",
	TeamChessEnemyPlaceBefore = "TeamChessEnemyPlaceBefore",
	MatchRoundBegin = "MatchRoundBegin"
}
EliminateEnum.ChessMaxRowValue = 7
EliminateEnum.ChessMaxLineValue = 6
EliminateEnum.ChessWidth = 124
EliminateEnum.ChessHeight = 124
EliminateEnum.AniTime = {
	Die = EliminateConfig.instance:getConstValue(24) / 1000,
	Move = EliminateConfig.instance:getConstValue(21) / 1000,
	MoveRevert = EliminateConfig.instance:getConstValue(22) / 1000,
	Drop = EliminateConfig.instance:getConstValue(23) / 1000,
	InitDrop = EliminateConfig.instance:getConstValue(28) / 1000
}
EliminateEnum.DotMoveTipInterval = EliminateConfig.instance:getConstValue(27) / 1000
EliminateEnum.ShowStartTime = EliminateConfig.instance:getConstValue(25) / 1000
EliminateEnum.ShowEndTime = EliminateConfig.instance:getConstValue(26) / 1000
EliminateEnum.ResourceFlyTime = EliminateConfig.instance:getConstValue(31) / 1000
EliminateEnum.DieToFlyOffsetTime = EliminateConfig.instance:getConstValue(32) / 1000
EliminateEnum.DieStepTime = EliminateConfig.instance:getConstValue(33) / 1000
EliminateEnum.ChessDropAngleThreshold = EliminateConfig.instance:getConstValue(29)
EliminateEnum.ShowEvaluateTime = EliminateConfig.instance:getConstValue(37) / 1000
EliminateEnum.chessFrameBgMaxWidth = 1140
EliminateEnum.chessFrameBgMaxHeight = 900
EliminateEnum.teamChessDescTipOffsetX = -140
EliminateEnum.teamChessDescTipOffsetY = -220
EliminateEnum.teamChessDescMinAnchorX = -737
EliminateEnum.levelTargetTipShowTime = EliminateConfig.instance:getConstValue(30) / 1000
EliminateEnum.levelTargetTipShowTimeInTeamChess = 0.5
EliminateEnum.dieEffectCacheCount = 30
EliminateEnum.damageCacheCount = 10
EliminateEnum.hpDamageCacheCount = 10
EliminateEnum.InvalidId = -1

return EliminateEnum
