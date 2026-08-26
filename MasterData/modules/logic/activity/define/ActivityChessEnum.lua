-- chunkname: @modules/logic/activity/define/ActivityChessEnum.lua

module("modules.logic.activity.define.ActivityChessEnum", package.seeall)

local ActivityChessEnum = _M

ActivityChessEnum.TileBaseType = {
	Normal = 1,
	None = 0
}
ActivityChessEnum.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
ActivityChessEnum.InteractType = {
	PickUpItem = 7,
	TriggerFail = 5,
	Enemy = 4,
	Player = 1,
	Item = 3,
	TriggerVictory = 6,
	Obstacle = 2,
	NoEffectItem = 8
}
ActivityChessEnum.InteractSelectPriority = {
	[ActivityChessEnum.InteractType.Player] = 1
}
ActivityChessEnum.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
ActivityChessEnum.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
ActivityChessEnum.GameStepType = {
	GameFinish = 2,
	CallEvent = 4,
	SyncInteractObj = 9,
	DeleteObject = 6,
	CreateObject = 5,
	InteractFinish = 8,
	PickUp = 7,
	NextRound = 1,
	Move = 3
}
ActivityChessEnum.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1
}
ActivityChessEnum.ChessSelectType = {
	UseItem = 2,
	Normal = 1
}
ActivityChessEnum.ClickRangeX = 125
ActivityChessEnum.ClickRangeY = 80
ActivityChessEnum.ClickYWeight = 1.2
ActivityChessEnum.ChessBoardOffsetX = -785
ActivityChessEnum.ChessBoardOffsetY = -20
ActivityChessEnum.TaskTypeClearEpisode = "Act109Star"
ActivityChessEnum.EpisodeId = 1160101
ActivityChessEnum.GuideIDForSwitchButton = 747
ActivityChessEnum.ResOffsetXY = {
	pingzi_a = {
		0,
		-14.5
	}
}
ActivityChessEnum.SceneResPath = {
	SceneFormatPath = "scenes/m_s12_dfw/prefab/%s.prefab",
	GroundItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DefaultScene = "scenes/m_s12_dfw/prefab/m_s12_pikelesi_a_01_p.prefab"
}
ActivityChessEnum.FailReason = {
	CanNotMove = 2,
	MaxRound = 3,
	Battle = 1,
	FailInteract = 4,
	None = 0
}
ActivityChessEnum.RoleAvatar = {
	WJYS = "wajueyishu_a",
	PKLS = "pikelese_a",
	Apple = "pingguo_a"
}
ActivityChessEnum.Res2SortOrder = {
	jingcha_b = 1,
	chuandan_b = 9,
	wendi_a = 2,
	pikelese_a = 3,
	interact_exit = 11,
	wajueyishu_a = 5,
	jingcha_a = 1,
	anbaoyuan_a = 6,
	youke_a = 7,
	pingzi_a = 8,
	pingguo_a = 4,
	chuandan_a = 10
}

return ActivityChessEnum
