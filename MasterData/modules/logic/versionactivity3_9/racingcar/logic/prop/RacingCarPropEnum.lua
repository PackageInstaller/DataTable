-- chunkname: @modules/logic/versionactivity3_9/racingcar/logic/prop/RacingCarPropEnum.lua

module("modules.logic.versionactivity3_9.racingcar.logic.prop.RacingCarPropEnum", package.seeall)

local RacingCarPropEnum = _M

RacingCarPropEnum.GMSpeed = 0
RacingCarPropEnum.RacingParamId = {
	CurrentSpeed = 1004,
	UltimateEnergy = 1012,
	MaxFov = 3002,
	BaseSpeed2 = 2001,
	Acceleration = 1005,
	LaneSwitchLaneCount = 3011,
	FollowHeight = 3004,
	BaseAcceleration = 2002,
	TiltAtMaxSpeed2 = 3008,
	LaneSwitchInputThreshold = 3009,
	ShakeAtMaxSpeed2 = 3007,
	SpeedMultiplier = 1003,
	TiltAtMaxSpeed = 3006,
	BaseFov = 3001,
	ShakeAtMaxSpeed = 3005,
	BaseSpeed3 = 1021,
	LaneSwitchSpeed = 3010,
	BaseSpeed1 = 1001,
	MaxSpeed = 1002,
	Accelerated2 = 1022,
	FollowDistance = 3003
}
RacingCarPropEnum.TriggerType = {
	GetBuff = "GetBuff",
	ChangeLane = "ChangeLane",
	Rank = "Rank",
	FightStart = "FightStart",
	Dodge = "Dodge",
	GetElement = "GetElement",
	UseSkill = "UseSkill",
	GetItem = "GetItem",
	BeImpact = "BeImpact",
	CarOverlap = "CarOverlap",
	GetItemRand = "GetItemRand",
	UseItem = "UseItem",
	None = "None"
}
RacingCarPropEnum.PassiveTriggerType = {
	[RacingCarPropEnum.TriggerType.BeImpact] = true,
	[RacingCarPropEnum.TriggerType.GetBuff] = true,
	[RacingCarPropEnum.TriggerType.GetItem] = true,
	[RacingCarPropEnum.TriggerType.GetElement] = true,
	[RacingCarPropEnum.TriggerType.Dodge] = true,
	[RacingCarPropEnum.TriggerType.Rank] = true,
	[RacingCarPropEnum.TriggerType.GetItemRand] = true
}
RacingCarPropEnum.MultiIdTriggerType = {
	[RacingCarPropEnum.TriggerType.GetBuff] = true,
	[RacingCarPropEnum.TriggerType.GetItem] = true,
	[RacingCarPropEnum.TriggerType.GetElement] = true
}
RacingCarPropEnum.TargetType = {
	TriggerTarget = 3,
	Self = 0,
	RankAheadOne = 2,
	RankFirst = 1
}
RacingCarPropEnum.SkillParamType = {
	TempFix = "TempFix",
	AddRangBuff = "AddRangBuff",
	ItemConversion = "ItemConversion",
	FlashMove = "FlashMove",
	TempSet = "TempSet",
	AddBuff = "AddBuff",
	JumpTrack = "JumpTrack",
	AddItem = "AddItem",
	AddSkill = "AddSkill",
	RemoveBuff = "RemoveBuff"
}
RacingCarPropEnum.BuffParamType = {
	Invisible = "Invisible",
	Height = "Height",
	Hide = "Hide",
	Absorb = "Absorb",
	Restrict = "Restrict",
	Immunity = "Immunity",
	Attr = "Attr",
	Penetrate = "Penetrate"
}
RacingCarPropEnum.BuffStackRule = {
	KeepOldRejectNew = 4,
	DurationAdd = 1,
	Independent = 3,
	HighReplaceLow = 2
}
RacingCarPropEnum.UltimateEnergyType = {
	All = 1,
	PerSecond = 2,
	Segmentation = 3
}

return RacingCarPropEnum
