-- chunkname: @modules/logic/versionactivity4_0/sp_lilya/define/SpLilyaEnum.lua

module("modules.logic.versionactivity4_0.sp_lilya.define.SpLilyaEnum", package.seeall)

local SpLilyaEnum = _M

SpLilyaEnum.ConstId = {
	EnergySkill = 6,
	SpeedMin = 4,
	ShotLimit = 7,
	SpeedMax = 5,
	BulletRadius = 9,
	PowerTime = 2,
	DamageMin = 1,
	PowerMax = 3,
	WaveTime = 8
}
SpLilyaEnum.FireMode = {
	Ground = 1,
	Air = 2
}
SpLilyaEnum.BulletType = {
	NoGravity = 2,
	Gravity = 1,
	Energy = 3
}
SpLilyaEnum.EnemyType = {
	Static = 0,
	Move = 1
}
SpLilyaEnum.EnemyMoveType = {
	Point = 2,
	UniformVelocity = 1
}
SpLilyaEnum.EnemyMoveDirection = {
	Vertical = 0,
	Horizontal = -1
}
SpLilyaEnum.EnemyState = {
	Hit = 2,
	Enter = 1,
	Die = 3,
	Normal = 0
}
SpLilyaEnum.EntityAnim = {
	BarHit = "hit",
	SpineDie = "die",
	SpineIdle = "idle",
	HurtEnter = "enter",
	BarDie = "die",
	HurtIdle = "idle",
	BarIdle = "idle"
}
SpLilyaEnum.EnemyStateDuration = {
	[SpLilyaEnum.EnemyState.Enter] = 1.3,
	[SpLilyaEnum.EnemyState.Hit] = 0.667,
	[SpLilyaEnum.EnemyState.Die] = 1.3
}
SpLilyaEnum.EnemyHPOffset = 20
SpLilyaEnum.PlayerState = {
	Hit = 1,
	Normal = 0
}
SpLilyaEnum.PlayerStateDuration = {
	[SpLilyaEnum.PlayerState.Hit] = 0.5
}
SpLilyaEnum.VictoryType = {
	LimitTime = 2,
	LimitBulle = 1,
	Normal = 0
}
SpLilyaEnum.HealthDisplayMode = {
	Hide = 0,
	Show = 1
}
SpLilyaEnum.UseGravity = {
	Unuse = 0,
	Use = 1
}
SpLilyaEnum.UseEnergy = {
	Unuse = 0,
	Use = 1
}
SpLilyaEnum.AimState = {
	Aim = 1,
	Normal = 0
}
SpLilyaEnum.MinHeight = -140
SpLilyaEnum.TipCloseDelay = 2
SpLilyaEnum.GameResult = {
	Fail = 1,
	Success = 0
}
SpLilyaEnum.SceneDefaultSize = {
	width = 2230,
	height = 929
}
SpLilyaEnum.PlayerOriginPos = {
	x = 315,
	y = 564.5
}
SpLilyaEnum.RotateLimit = {
	Max = 85,
	Min = -85
}
SpLilyaEnum.GameTimeUpdateDuration = 0.25
SpLilyaEnum.DefaultLineLength = 500
SpLilyaEnum.DefaultGroundHeight = 200
SpLilyaEnum.DefaultGroundPosX = SpLilyaEnum.SceneDefaultSize.width
SpLilyaEnum.DefaultGroundPosY = SpLilyaEnum.SceneDefaultSize.height
SpLilyaEnum.BulletBoundaryMargin = 500
SpLilyaEnum.GroupXOffset = 100
SpLilyaEnum.DefaultShotSpeed = 1000
SpLilyaEnum.NormalBulletSpeed = 1800
SpLilyaEnum.EnergyBulletSpeed = 2400
SpLilyaEnum.EnergyBulletLaunchInterval = 0.05
SpLilyaEnum.EnergyBulletManeuverAngleMin = 0
SpLilyaEnum.EnergyBulletManeuverAngleMax = 60
SpLilyaEnum.EnergyBulletTrackAngularSpeed = 540
SpLilyaEnum.BulletVisualScale = 0.5
SpLilyaEnum.BulletScale = 1.25
SpLilyaEnum.DefaultGravity = 618
SpLilyaEnum.PlayerMoveSpeed = 300
SpLilyaEnum.AirPlayerMoveSpeed = 420
SpLilyaEnum.AirBackgroundScrollSpeed = 120
SpLilyaEnum.PlayerShotPreviewDistance = 500
SpLilyaEnum.BulletAimSampleCount = 64
SpLilyaEnum.BulletTrackAngularSpeed = 360
SpLilyaEnum.BulletExplodeDelayTime = 0.5
SpLilyaEnum.SuccessAnimatorName = {
	Fail = "fail",
	Idle = "idle",
	Success = "success"
}
SpLilyaEnum.WaveAnimatorName = {
	Idle = "idle",
	Update = "update"
}
SpLilyaEnum.EnergyTipAnimatorName = {
	Open = "tipsbg_open"
}
SpLilyaEnum.EnergyClickAnimatorName = {
	Idle = "idle",
	Click = "click"
}
SpLilyaEnum.AnimTime = {
	EnergyTip = 1,
	Update = 0.16,
	Result = 1
}
SpLilyaEnum.LockScreenKey = "SpLilyaLockScreen"
SpLilyaEnum.MaxTipCount = 1
SpLilyaEnum.EnemySpineResPath = "roles/%s_ui.prefab"
SpLilyaEnum.PlayerSpineResPath = "roles/v4a0_315501_sxnwhnj/315501_sxnwhnj_ui.prefab"
SpLilyaEnum.EnemySpineScale = {
	["v1a3_690113_lupaiguai/690113_lupaiguai"] = 0.5,
	["610301_daxingaolituou/610301_daxingaolituou"] = 0.6,
	["v1a3_690115_lupaiguai/690115_lupaiguai"] = 0.5,
	["v1a3_690116_lupaiguai/690116_lupaiguai"] = 0.5,
	["422602_enanzhongzi/422602_enanzhongzi"] = 0.6,
	["v2a0_620224_tzglwks/620224_tzglwks"] = 0.6,
	["v1a3_690114_lupaiguai/690114_lupaiguai"] = 0.5
}
SpLilyaEnum.EnemySpineAnimName = {
	Idle = "idle"
}
SpLilyaEnum.EnemySpineAnimName = {
	Idle = "idle"
}
SpLilyaEnum.PlayerSpineAnimName = {
	Skill1 = "skill1",
	Posture = "posture",
	Idle = "idle"
}
SpLilyaEnum.BulletEffectSize = {
	Height = 185,
	Width = 185
}
SpLilyaEnum.PlayerSpineScale = 0.8
SpLilyaEnum.PlayerSpineOffset = -168
SpLilyaEnum.EnemyBarLiftStep = 30
SpLilyaEnum.EnemyBarLiftMaxLevel = 3
SpLilyaEnum.EnemyBarHalfW = 60
SpLilyaEnum.EnemyBarHalfH = 10
SpLilyaEnum.EnemyHeadPath = "mountroot/mounthead"
SpLilyaEnum.EnemyBodyPath = "mountroot/mountbody"
SpLilyaEnum.DamageNumScale = {
	Player = 1.5,
	Enemy = 1
}
SpLilyaEnum.DamageNumTime = 1.0033
SpLilyaEnum.PlayerDamageNumOffsetY = 80
SpLilyaEnum.PlayerRotateLimit = {
	Max = 30,
	Min = -30
}
SpLilyaEnum.PlayerPoweringRootPath = "mountroot/special3"
SpLilyaEnum.ArrowScale = {
	Max = 1.2,
	Min = 0.7
}
SpLilyaEnum.PlayerBulletOffset = {
	[SpLilyaEnum.FireMode.Ground] = {
		-18,
		-41
	},
	[SpLilyaEnum.FireMode.Air] = {
		80,
		-80
	}
}
SpLilyaEnum.BulletPress = {
	0.333,
	0.667,
	1
}
SpLilyaEnum.PowerPress = {
	0.5,
	1
}
SpLilyaEnum.JoystickSpeed = 180
SpLilyaEnum.isHPMove = false
SpLilyaEnum.PowerChargeDelay = 0.1
SpLilyaEnum.ExplodeReason = {
	OutOfBounds = "OutOfBounds",
	CollisionHit = "CollisionHit",
	DyingExpire = "DyingExpire",
	GroundExplode = "GroundExplode"
}

return SpLilyaEnum
