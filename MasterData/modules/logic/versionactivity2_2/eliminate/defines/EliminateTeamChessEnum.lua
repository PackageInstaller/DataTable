-- chunkname: @modules/logic/versionactivity2_2/eliminate/defines/EliminateTeamChessEnum.lua

module("modules.logic.versionactivity2_2.eliminate.defines.EliminateTeamChessEnum", package.seeall)

local EliminateTeamChessEnum = class("EliminateTeamChessEnum")

EliminateTeamChessEnum.TeamChessTeamType = {
	enemy = 2,
	player = 1
}
EliminateTeamChessEnum.StepActionType = {
	roundBegin = 0,
	chessSkill = 1,
	strongHoldSkill = 4,
	chessMove = 6,
	placeChess = 3,
	useMainCharacterSkill = 5,
	chessSettle = 2
}
EliminateTeamChessEnum.StepEffectType = {
	placeChess = 6
}
EliminateTeamChessEnum.ChessPlaceType = {
	activeMove = 1,
	place = 0
}
EliminateTeamChessEnum.SoliderSkillType = {
	Die = "Die",
	GrowUp = "GrowUp",
	Raw = "Raw"
}
EliminateTeamChessEnum.StepWorkType = {
	removeChess = 10,
	mainCharacterHpChange = 2,
	chessGrowUpChange = 15,
	teamChessBeginViewShow = 10004,
	teamChessCheckRoundState = 10003,
	chessPowerChange = 1,
	strongHoldPowerChange = 9,
	teamChessShowVxEffect = 10005,
	teamChessUpdateForecast = 10006,
	effectNestStruct = 7,
	teamChessFightResult = 10000,
	callChess = 4,
	strongHoldSettle = 11,
	resourceChange = 8,
	mainCharacterPowerChange = 3,
	chessActiveMove = 12,
	chessDie = 5,
	teamChessServerDataDiff = 10001,
	placeChess = 6,
	strongHoldSettleFinish = 13
}
EliminateTeamChessEnum.ResourceType = {
	blue = "blue",
	green = "green",
	yellow = "yellow",
	red = "red"
}
EliminateTeamChessEnum.ResourceTypeToImagePath = {
	blue = "v2a2_eliminate_chess_energy_quality_02",
	yellow = "v2a2_eliminate_chess_energy_quality_04",
	brown = "v2a2_eliminate_chess_energy_quality_03",
	red = "v2a2_eliminate_chess_energy_quality_05",
	green = "v2a2_eliminate_chess_energy_quality_01"
}
EliminateTeamChessEnum.ResourceTypeToCircleImagePath = {
	blue = "v2a2_eliminate_chess_resource_quality_02",
	yellow = "v2a2_eliminate_chess_resource_quality_04",
	brown = "v2a2_eliminate_chess_resource_quality_03",
	red = "v2a2_eliminate_chess_resource_quality_05",
	green = "v2a2_eliminate_chess_resource_quality_01"
}
EliminateTeamChessEnum.SoliderChessQualityImage = {
	"v2a2_eliminate_builditem_quality_01",
	"v2a2_eliminate_builditem_quality_02",
	"v2a2_eliminate_builditem_quality_03",
	"v2a2_eliminate_builditem_quality_04",
	"v2a2_eliminate_builditem_quality_05"
}
EliminateTeamChessEnum.TeamChessRoundType = {
	settlement = 3,
	enemy = 2,
	player = 1
}
EliminateTeamChessEnum.StrongHoldState = {
	enemySide = 2,
	neutral = 3,
	mySide = 1
}
EliminateTeamChessEnum.ChessTipType = {
	showSell = 2,
	showDesc = 1,
	showDragTip = 3
}
EliminateTeamChessEnum.FightResult = {
	win = 1,
	lose = 2,
	draw = 3,
	notSettlement = 0
}
EliminateTeamChessEnum.ResultRewardType = {
	slot = 3,
	character = 1,
	chessPiece = 2
}
EliminateTeamChessEnum.placeSkillEffectParamConfigEnum = {
	Move = {
		["8"] = {
			limitStrongHold = false,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		},
		["9"] = {
			limitStrongHold = false,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		},
		["10"] = {
			limitStrongHold = false,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		},
		["11"] = {
			limitStrongHold = false,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.enemy
		}
	},
	PowerDecrease = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.enemy
		},
		["5"] = {
			limitStrongHold = true,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		}
	},
	TriggerRaw = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		}
	},
	Kill = {
		["1"] = {
			limitStrongHold = true,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.enemy
		},
		["2"] = {
			limitStrongHold = true,
			count = 1,
			teamType = EliminateTeamChessEnum.TeamChessTeamType.player
		}
	}
}
EliminateTeamChessEnum.battleFormatType = {
	["0"] = "<b>%s</b>",
	["1"] = "<color=#18636d>%s</color>",
	["2"] = "<color=#206524>%s</color>",
	["5"] = "<color=#5e3d1d>%s</color>",
	["3"] = "<color=#645501>%s</color>",
	["4"] = "<color=#933f2b>%s</color>"
}
EliminateTeamChessEnum.PreBattleFormatType = {
	["0"] = "<b>%s</b>",
	["1"] = "<color=#9ecbeb>%s</color>",
	["2"] = "<color=#addeae>%s</color>",
	["5"] = "<color=#e4b991>%s</color>",
	["3"] = "<color=#ffdc8f>%s</color>",
	["4"] = "<color=#ffa896>%s</color>"
}
EliminateTeamChessEnum.ModeType = {
	Gray = 1,
	Outline = 2,
	Normal = 0
}
EliminateTeamChessEnum.HpDamageType = {
	Chess = 1,
	GrowUpToChess = 3,
	Character = 2
}
EliminateTeamChessEnum.tempPieceUid = 9999
EliminateTeamChessEnum.beginViewShowTime = 1.5
EliminateTeamChessEnum.addResourceTipTime = 1
EliminateTeamChessEnum.teamChessPlaceStep = 0.4
EliminateTeamChessEnum.soliderChessOutAniTime = 0.4
EliminateTeamChessEnum.StrongHoldBattleVxTime = 1.4
EliminateTeamChessEnum.entityMoveTime = 1
EliminateTeamChessEnum.teamChessUpdateActiveMoveStepTime = EliminateTeamChessEnum.entityMoveTime
EliminateTeamChessEnum.powerChangeTime = 1
EliminateTeamChessEnum.hpChangeTime = 0.5
EliminateTeamChessEnum.hpDamageJumpTime = 1
EliminateTeamChessEnum.characterHpDamageFlyTime = 1
EliminateTeamChessEnum.characterHpDamageFlyTimeTipHpChange = 0.6
EliminateTeamChessEnum.teamChessHpChangeStepTime = EliminateTeamChessEnum.hpChangeTime + EliminateTeamChessEnum.characterHpDamageFlyTime
EliminateTeamChessEnum.teamChessPowerJumpTime = 0.7
EliminateTeamChessEnum.teamChessPowerChangeStepTime = 0.7
EliminateTeamChessEnum.teamChessWinOpenTime = 1
EliminateTeamChessEnum.chessShowMoveStateAniTime = 0.33
EliminateTeamChessEnum.teamChessGrowUpChangeStepTime = 0.5
EliminateTeamChessEnum.teamChessForecastUpdateStep = 0.45
EliminateTeamChessEnum.CharacterHpDamageSize = 80
EliminateTeamChessEnum.ChessDamageSize = 32
EliminateTeamChessEnum.VxEffectType = {
	PowerUp = "PowerUp",
	StrongHoldBattle = "StrongHoldBattle",
	Die = "Die",
	Move = "Move",
	PowerDown = "PowerDown",
	WangYu = "WangYu",
	ZhanHou = "ZhanHou"
}
EliminateTeamChessEnum.VxEffectTypePlayTime = {
	WangYu = 1.5,
	ZhanHou = 0.7,
	StrongHoldBattle = EliminateTeamChessEnum.StrongHoldBattleVxTime,
	PowerDown = EliminateTeamChessEnum.teamChessPowerChangeStepTime,
	PowerUp = EliminateTeamChessEnum.teamChessPowerChangeStepTime
}
EliminateTeamChessEnum.VxEffectTypeToPath = {
	Move = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_qianjin_jiantou.prefab",
	StrongHoldBattle = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_fight.prefab",
	PowerUp = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_shuxingzengjia.prefab",
	Die = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_siwang.prefab",
	PowerDown = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_shuxingjiangdi.prefab",
	WangYu = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_wangyu.prefab",
	ZhanHou = "scenes/v2a2_m_s12_xdwf/vx/prefab/vx_zhanhou.prefab"
}
EliminateTeamChessEnum.powerItemRectPosX = 110
EliminateTeamChessEnum.powerItemRectPosY = -10
EliminateTeamChessEnum.soliderTipOffsetX = 1
EliminateTeamChessEnum.soliderTipOffsetY = 0.9
EliminateTeamChessEnum.soliderSellTipOffsetX = 1.4
EliminateTeamChessEnum.soliderSellTipOffsetY = 3.1
EliminateTeamChessEnum.playerSoliderWatchTipOffsetX = 1.4
EliminateTeamChessEnum.playerSoliderWatchTipOffsetY = 2.5
EliminateTeamChessEnum.soliderItemTipOffsetX = -1.6
EliminateTeamChessEnum.soliderItemTipOffsetY = 2.4
EliminateTeamChessEnum.soliderItemDragTipOffsetX = 1.1
EliminateTeamChessEnum.soliderItemDragTipOffsetY = 0.9
EliminateTeamChessEnum.powerOffsetY = -25
EliminateTeamChessEnum.chessMoveOffsetX = 0.9
EliminateTeamChessEnum.chessMoveOffsetY = 0.8
EliminateTeamChessEnum.teamChessGrowUpToChangePowerStepTime = 0.1
EliminateTeamChessEnum.teamChessGrowUpZhanHouStepTime = 0.1
EliminateTeamChessEnum.teamChessGrowUpToChangePowerJumpTime = 0.1
EliminateTeamChessEnum.teamChessToMatchStepTime = 1
EliminateTeamChessEnum.matchToTeamChessStepTime = 0.5

return EliminateTeamChessEnum
