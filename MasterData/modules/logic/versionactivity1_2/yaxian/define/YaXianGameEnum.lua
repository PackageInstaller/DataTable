-- chunkname: @modules/logic/versionactivity1_2/yaxian/define/YaXianGameEnum.lua

module("modules.logic.versionactivity1_2.yaxian.define.YaXianGameEnum", package.seeall)

local YaXianGameEnum = YaXianEnum

YaXianGameEnum.TileBaseType = {
	Normal = 1,
	None = 0
}
YaXianGameEnum.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
YaXianGameEnum.TileSetting = {
	baffleOffsetX = 0.64,
	height = 1.619276,
	width = 2.563867,
	baffleOffsetY = 0.44
}
YaXianGameEnum.TileSetting.halfWidth = YaXianGameEnum.TileSetting.width / 2
YaXianGameEnum.TileSetting.halfHeight = YaXianGameEnum.TileSetting.height / 2
YaXianGameEnum.InteractType = {
	PickUpItem = 7,
	TriggerFail = 5,
	Enemy = 4,
	Player = 1,
	Item = 3,
	TriggerVictory = 6,
	Obstacle = 2,
	NoEffectItem = 8
}
YaXianGameEnum.MoveDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
YaXianGameEnum.OppositeDirection = {
	[YaXianGameEnum.MoveDirection.Bottom] = YaXianGameEnum.MoveDirection.Top,
	[YaXianGameEnum.MoveDirection.Left] = YaXianGameEnum.MoveDirection.Right,
	[YaXianGameEnum.MoveDirection.Right] = YaXianGameEnum.MoveDirection.Left,
	[YaXianGameEnum.MoveDirection.Top] = YaXianGameEnum.MoveDirection.Bottom
}
YaXianGameEnum.BaffleDirection = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
YaXianGameEnum.DirectionName = {
	[YaXianGameEnum.MoveDirection.Bottom] = "down",
	[YaXianGameEnum.MoveDirection.Left] = "left",
	[YaXianGameEnum.MoveDirection.Right] = "right",
	[YaXianGameEnum.MoveDirection.Top] = "up"
}
YaXianGameEnum.BaffleDirectionPowerPos = {
	Top = 8,
	Right = 6,
	Left = 4,
	Bottom = 2
}
YaXianGameEnum.BaffleType = {
	Second = 2,
	First = 1
}
YaXianGameEnum.ClickRangeX = 125
YaXianGameEnum.ClickRangeY = 80
YaXianGameEnum.ClickYWeight = 1.2
YaXianGameEnum.ChessBoardOffsetX = -7.85
YaXianGameEnum.ChessBoardOffsetY = -0.2
YaXianGameEnum.InteractSelectPriority = {
	[YaXianGameEnum.InteractType.Player] = 1
}
YaXianGameEnum.GameStateType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
YaXianGameEnum.GameStepType = {
	GameFinish = 2,
	CallEvent = 4,
	DeleteObject = 6,
	CreateObject = 5,
	InteractFinish = 8,
	PickUp = 7,
	NextRound = 1,
	UpdateObjectData = 9,
	Move = 3
}
YaXianGameEnum.SkillId = {
	InVisible = 1,
	ThroughWall = 2
}
YaXianGameEnum.SkillType = {
	InVisible = 1,
	ThroughWall = 2
}
YaXianGameEnum.ConditionType = {
	FinishAllInteract = 3,
	FinishInteract = 2,
	PassEpisode = 0,
	Round = 1
}
YaXianGameEnum.SceneResPath = {
	GreedLineHalf = "scenes/m_s12_dfw_yaxian/prefab/tou_green.prefab",
	LRBaffle1 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_r_b_1x1.prefab",
	FightEffect = "scenes/m_s12_dfw_yaxian/prefab/yanxian_zhandou.prefab",
	LRBaffle0 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_r_a_1x1.prefab",
	RedLine = "scenes/m_s12_dfw_yaxian/prefab/line_red.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	ExitDefaultPath = "scenes/m_s12_dfw_yaxian/prefab/picpe/interact_exit.prefab",
	RedLineHalf = "scenes/m_s12_dfw_yaxian/prefab/tou_red.prefab",
	SceneFormatPath = "scenes/m_s12_dfw_yaxian/prefab/%s.prefab",
	AssassinateEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_ansha.prefab",
	GroundItem = "scenes/m_s12_dfw_yaxian/prefab/m_s12_diban_1x1_b.prefab",
	PlayerAssassinateEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_dead.prefab",
	TBBaffle0 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_l_a_1x1.prefab",
	GreenLine = "scenes/m_s12_dfw_yaxian/prefab/line_green.prefab",
	TBBaffle1 = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_yaxian_zl_l_b_1x1.prefab",
	DefaultScene = "scenes/m_s12_dfw_yaxian/prefab/m_s12_yaxian_a_01_p.prefab",
	FightSuccessEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_win.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DieEffect = "scenes/m_s12_dfw_yaxian/prefab/yaxian_die.prefab",
	MonsterStatus = "scenes/m_s12_dfw_yaxian/prefab/picpe/yaxian_icon.prefab",
	TargetItem = "scenes/m_s12_dfw_yaxian/prefab/picpe/m_s12_diban_mubiao.prefab"
}
YaXianGameEnum.InteractHeight = {
	[10001] = 1,
	[10006] = 1
}
YaXianGameEnum.MinShowPriority = 0
YaXianGameEnum.InteractShowPriority = {
	[YaXianGameEnum.InteractType.TriggerVictory] = 1,
	[YaXianGameEnum.InteractType.Enemy] = 2,
	[YaXianGameEnum.InteractType.Player] = 3
}
YaXianGameEnum.IconStatus = {
	Fight = 2,
	Assassinate = 1,
	PlayerAssassinate = 5,
	ThroughWall = 4,
	InVisible = 3
}
YaXianGameEnum.DirectionIcon = {
	[YaXianGameEnum.IconStatus.PlayerAssassinate] = true,
	[YaXianGameEnum.IconStatus.Fight] = true
}
YaXianGameEnum.AIType = {
	NotLoop = 2,
	Loop = 1
}
YaXianGameEnum.AlertType = {
	SingleWay = 1,
	FourWay = 3
}
YaXianGameEnum.ContainerOffsetZ = {
	Interact = -2,
	Background = -0.5,
	TipArea = -1,
	Path = -1.5
}
YaXianGameEnum.AlertOffsetZ = -0.01
YaXianGameEnum.EffectType = {
	Fight = 1,
	Die = 3,
	Assassinate = 2,
	FightSuccess = 4,
	PlayerAssassinateEffect = 5
}
YaXianGameEnum.DefaultEffectDuration = 0.5
YaXianGameEnum.EffectDuration = {
	[YaXianGameEnum.EffectType.Die] = 0.8,
	[YaXianGameEnum.EffectType.FightSuccess] = 1.2
}
YaXianGameEnum.MoveDuration = 0.3
YaXianGameEnum.SmallMoveDuration = 0.2
YaXianGameEnum.IconAnimationSwitchInterval = 1
YaXianGameEnum.IconAnimationDuration = 0.333
YaXianGameEnum.StopAnimationDuration = 0.333
YaXianGameEnum.InteractAnimationName = {
	TwoEffect = "skill_two_open",
	TwoEffectClose = "skill_two_close",
	CloseInVisible = "skill_ys_close",
	ThroughWall = "skill_cq_open",
	InVisible = "skill_ys_open",
	Die = "die",
	CloseThroughWall = "skill_cq_close"
}
YaXianGameEnum.CloseAnimationName = {
	[YaXianGameEnum.InteractAnimationName.InVisible] = YaXianGameEnum.InteractAnimationName.CloseInVisible,
	[YaXianGameEnum.InteractAnimationName.ThroughWall] = YaXianGameEnum.InteractAnimationName.CloseThroughWall,
	[YaXianGameEnum.InteractAnimationName.TwoEffect] = YaXianGameEnum.InteractAnimationName.TwoEffectClose
}
YaXianGameEnum.InteractDefaultTopPosOffset = Vector3(0, 1.04, 0)
YaXianGameEnum.ResultSimageName = {
	FightFail = "img_zi1",
	RoundUseUp = "img_zi3",
	Success = "img_zi2"
}
YaXianGameEnum.EndTxtAnchorY = {
	HadTxt = Vector2(0.5, 0.2),
	NoneTxt = Vector2(0.5, 0.5)
}
YaXianGameEnum.DeleteInteractReason = {
	AssassinateKill = 1,
	FightKill = 3,
	Win = 2
}
YaXianGameEnum.LastEpisodeId = 21
YaXianGameEnum.BossInteractId = 30501
YaXianGameEnum.FakeBossStartPos = {
	posY = 3,
	posX = 0
}
YaXianGameEnum.FakeBossDirection = YaXianGameEnum.MoveDirection.Right
YaXianGameEnum.StepFinishDelay = 0.3
YaXianGameEnum.ScenePosYRange = {
	Max = 10,
	Min = -10
}
YaXianGameEnum.ScenePosYRangeArea = YaXianGameEnum.ScenePosYRange.Max - YaXianGameEnum.ScenePosYRange.Min
YaXianGameEnum.LevelScenePosZRange = {
	Max = 0,
	Min = -0.4
}
YaXianGameEnum.SwitchDirectionDelay = 0.15
YaXianGameEnum.EffectInterval = 1

return YaXianGameEnum
