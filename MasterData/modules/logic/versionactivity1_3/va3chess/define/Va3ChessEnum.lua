-- chunkname: @modules/logic/versionactivity1_3/va3chess/define/Va3ChessEnum.lua

module("modules.logic.versionactivity1_3.va3chess.define.Va3ChessEnum", package.seeall)

local Va3ChessEnum = _M

Va3ChessEnum.TileBaseType = {
	Normal = 1,
	None = 0
}
Va3ChessEnum.TileShowSettings = {
	width = 152.7,
	height = 54.6,
	offsetYX = 24.6,
	offsetY = -103.2,
	offsetX = 154.8,
	offsetXY = -29.3
}
Va3ChessEnum.InteractType = {
	Item = 3,
	PushedOnceBlock = 15,
	DestroyableItem = 14,
	DeductHpEnemy = 17,
	TriggerFail = 5,
	Trap = 13,
	PickUpItem = 7,
	TriggerInteract = 9,
	CollectCheckPoint = 16,
	NoEffectItem = 8,
	Enemy = 4,
	Obstacle = 2,
	AssistPlayer = 18,
	BoltLauncher = 21,
	StandbyTrackEnemy = 24,
	Brazier = 23,
	PushedBlock = 12,
	Pedal = 22,
	SentryEnemy = 25,
	TriggerVictory = 6,
	Player = 1,
	DestroyableTrap = 20,
	NextMap = 11
}
Va3ChessEnum.Direction = {
	Down = 2,
	Up = 8,
	Left = 4,
	Right = 6
}
Va3ChessEnum.InteractParamType = {
	Story = 4
}
Va3ChessEnum.EffectType = {
	ArrowHit = 1
}
Va3ChessEnum.EffectPath = {
	[Va3ChessEnum.EffectType.ArrowHit] = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_jian_hit.prefab"
}
Va3ChessEnum.ScenePosZRange = {
	Max = -0.2,
	Min = 0
}
Va3ChessEnum.InteractSelectPriority = {
	[Va3ChessEnum.InteractType.Player] = 1,
	[Va3ChessEnum.InteractType.AssistPlayer] = 1
}
Va3ChessEnum.SelectPosStatus = {
	SelectObjWaitPos = 2,
	None = 1
}
Va3ChessEnum.GameEventType = {
	FinishEvent = 3,
	Battle = 1,
	UseItem = 2,
	Lock = -1,
	Normal = 0
}
Va3ChessEnum.GameStepType = {
	MapUpdate = 14,
	NextRound = 1,
	CallEvent = 4,
	SyncInteractObj = 9,
	TargetUpdate = 15,
	DeleteObject = 6,
	NextMap = 12,
	RefreshPedalStatus = 20,
	Toast = 11,
	PickUp = 7,
	BulletUpdate = 16,
	HpUpdate = 13,
	GameFinish = 2,
	Story = 10,
	BrazierTrigger = 17,
	CreateObject = 5,
	InteractFinish = 8,
	Move = 3
}
Va3ChessEnum.GameEffectType = {
	Display = 5,
	Direction = 2,
	Sleep = 3,
	Hero = 1,
	Monster = 4
}
Va3ChessEnum.Act120StepType = {
	TilePosui = 13
}
Va3ChessEnum.Act142StepType = {
	TileBroken = 13,
	TileFragile = 19
}
Va3ChessEnum.DeleteReason = {
	Default = 0,
	MoveKill = 5,
	Change = 6,
	Falling = 1,
	EnemyKill = 2,
	Arrow = 3,
	FireBall = 4
}
Va3ChessEnum.ChessClearCondition = {
	InteractFinish = 2,
	RoundLimit = 1,
	HpLimit = 3,
	InteractAllFinish = 4
}
Va3ChessEnum.ChessSelectType = {
	UseItem = 2,
	Normal = 1
}
Va3ChessEnum.ClickRangeX = 125
Va3ChessEnum.ClickRangeY = 80
Va3ChessEnum.ClickYWeight = 1.2
Va3ChessEnum.ChessBoardOffsetX = -785
Va3ChessEnum.ChessBoardOffsetY = -20
Va3ChessEnum.TaskTypeClearEpisode = "Act109Star"
Va3ChessEnum.SWITCH_OPEN_ANIM = "swopen"
Va3ChessEnum.GuideIDForSwitchButton = 747
Va3ChessEnum.ResOffsetXY = {
	pingzi_a = {
		0,
		-14.5
	}
}
Va3ChessEnum.SceneResPath = {
	SceneFormatPath = "%s.prefab",
	AlarmItem3 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_red.prefab",
	GroundItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_1×1.prefab",
	AlarmItem2 = "scenes/v1a5_m_s12_dfw_krd/perefab/diban_yellow.prefab",
	AlarmItem = "scenes/common_m_s12_dfw/prefab/m_s12_qipan_red_1×1.prefab",
	DirItem = "scenes/common_m_s12_dfw/prefab/m_s12_diban_selected.prefab",
	AvatarItemPath = "%s.prefab",
	DefaultScene = "scenes/m_s12_dfw/prefab/m_s12_pikelesi_a_01_p.prefab"
}
Va3ChessEnum.FailReason = {
	CanNotMove = 2,
	MaxRound = 3,
	Battle = 1,
	FailInteract = 4,
	None = 0
}
Va3ChessEnum.Res2SortOrder = {
	jingcha_b = 1,
	chuandan_b = 9,
	youke_a = 7,
	pikelese_a = 3,
	["scenes/v1a5_m_s12_dfw_krd/perefab/jiguan"] = 3,
	wajueyishu_a = 5,
	jingcha_a = 1,
	anbaoyuan_a = 6,
	wendi_a = 2,
	pingzi_a = 8,
	pingguo_a = 4,
	chuandan_a = 10,
	interact_exit = 11
}
Va3ChessEnum.AlarmOrder = {
	AlarmItem = -100,
	DirItem = -150
}
Va3ChessEnum.ViewType = {
	Game = 1,
	Reward = 3,
	Result = 2
}
Va3ChessEnum.TileTrigger = {
	PoSui = 2,
	Broken = 3
}
Va3ChessEnum.TriggerStatus = {
	[Va3ChessEnum.TileTrigger.Broken] = {
		Broken = 3,
		Fragile = 2,
		Normal = 1
	}
}
Va3ChessEnum.ActivityId = {
	Act109 = 11103,
	Act122 = 11304,
	Act120 = 11306,
	Act142 = VersionActivity1_5Enum.ActivityId.Activity142
}
Va3ChessEnum.ObjState = {
	Idle = 1,
	Interoperable = 2
}
Va3ChessEnum.ComponentType = {
	Animator = typeof(UnityEngine.Animator),
	MeshRenderer = typeof(UnityEngine.MeshRenderer)
}
Va3ChessEnum.DEFAULT_BULLET_SPEED = 8
Va3ChessEnum.DEFAULT_BULLET_FLY_TIME = 1
Va3ChessEnum.Bullet = {
	Arrow = {
		speed = 8,
		path = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_jian.prefab"
	},
	FireBall = {
		speed = 8,
		path = "scenes/v1a5_m_s12_dfw_krd/perefab/vx_fire_ball.prefab"
	}
}

return Va3ChessEnum
