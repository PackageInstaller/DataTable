-- chunkname: @modules/logic/versionactivity3_8/echosong/define/V3a8EchoSongEnum.lua

module("modules.logic.versionactivity3_8.echosong.define.V3a8EchoSongEnum", package.seeall)

local V3a8EchoSongEnum = _M

V3a8EchoSongEnum.FirstGuideId = 38201
V3a8EchoSongEnum.ScenePath = "ui/viewres/versionactivity_3_8/v3a8_huishengyao/scene/%s.prefab"
V3a8EchoSongEnum.ColliderLayer = LayerMask.GetMask("Default")
V3a8EchoSongEnum.DragLength = 240
V3a8EchoSongEnum.MainPlayerId = -1
V3a8EchoSongEnum.LongPressTime = 0.3
V3a8EchoSongEnum.LongClickTime = 0.3
V3a8EchoSongEnum.DragShowCancelTime = 0.1
V3a8EchoSongEnum.BallConst = {
	PrewarmCount = 40,
	MaxReflectCount = 8,
	PrewarmPerFrame = 4,
	Num = 20,
	ReflectEpsilon = 0.01,
	TrailChaseEndRatio = 1,
	Speed = 4,
	TrailChaseStartRatio = 0.2,
	TrailChaseMaxRatio = 0.8
}
V3a8EchoSongEnum.BallRandom = {
	Angle = 0,
	Num = 0,
	Speed = 0,
	LifeTime = 0
}
V3a8EchoSongEnum.ParticleLifeTime = {
	Explore = 1.5,
	Short = 0.4,
	Enemy2 = 0.5,
	Long = 1.5,
	StandLong = 2.5,
	Tip = 0.4,
	HitTime = 1.5
}
V3a8EchoSongEnum.UnitType = {
	SpawnPoint = 101,
	Event3 = 107,
	Enemy1 = 201,
	Tip = 301,
	Wall = 103,
	Trap = 104,
	MainPlayer = 100,
	Enemy2WayPoint = 203,
	SavePoint = 302,
	EndPoint = 102,
	Story = 303,
	Event2 = 106,
	Event1 = 105,
	Enemy2 = 202
}
V3a8EchoSongEnum.ParticleType = {
	MainPlayer = 1,
	Explore = 5,
	Enemy2 = 6,
	Event2 = 4,
	Tip = 3,
	MainPlayerShort = 2
}
V3a8EchoSongEnum.TrapTriggerType = {
	Auto = 1,
	Close = 3,
	Open = 2
}
V3a8EchoSongEnum.SaveType = {
	Progress = 1
}
V3a8EchoSongEnum.BgType = {
	Purple = 2,
	Green = 1
}
V3a8EchoSongEnum.MainPlayerConst = {
	CircleCastRadius = 0.1,
	MoveSpeed = 1.3,
	StrengthThreshold = 0.95,
	MaxFootprint = 2,
	CircleCastDist = 0.4,
	SingleFootprintLifeTime = 2,
	StandFootprintIndex = 3,
	DoubleFootprintLifeTime = 0.2,
	EmitInterval = 0.8,
	StandFootprintInterval = 2
}
V3a8EchoSongEnum.FootprintType = {
	Light = 2,
	Normal = 1
}
V3a8EchoSongEnum.EnemyConst = {
	Enemy1WaitTime = 0.5,
	Enemy1Speed = 80,
	Enemy2Speed = 130,
	Enemy2HurtDistance = 100,
	Enemy1HurtDistance = 110
}
V3a8EchoSongEnum.TrapPassStatus = {
	Open = 1,
	Loop = 2,
	Close = 3,
	None = -1
}
V3a8EchoSongEnum.CancelState = {
	Light = 1,
	Dark = 2
}
V3a8EchoSongEnum.ExploreConst = {
	RaycastDist = 0.5,
	MoveSpeed = 8
}
V3a8EchoSongEnum.TouchEmittedType = {
	Long = 2,
	Short = 1
}
V3a8EchoSongEnum.Audio = {
	play_ui_shiji3_8_hsy_fashe = 380025,
	play_ui_shiji3_8_hsy_jigaun = 380027,
	play_ui_shiji3_8_hsy_level = 380024,
	play_ui_shiji3_8_hsy_fail = 380026,
	play_ui_shiji3_8_hsy_finish = 380028,
	play_ui_shiji3_8_hsy_win = 380029,
	play_ui_shiji3_8_hsy_fstp1 = 380030,
	play_ui_shiji3_8_hsy_fstp2 = 380031
}
V3a8EchoSongEnum.ScaleRange = {
	Max = 1,
	Min = 0.5
}
V3a8EchoSongEnum.SceneScale = 1

return V3a8EchoSongEnum
