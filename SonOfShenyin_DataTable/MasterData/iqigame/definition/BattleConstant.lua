-- chunkname: @IQIGame\\Definition\\BattleConstant.lua

BattleConstant = {}
BattleConstant.BattleViewRootConfigID = 4
BattleConstant.BattleTilePosTroopTypeOffset = 100
BattleConstant.BattleUnitDefaultSortingOrder = 100
BattleConstant.BattleVirtualCameras = {
	default = "default",
	friendlyCenter = "friendlyCenter",
	self = "self",
	selectTarget = "selectTarget",
	enemyCenter = "enemyCenter",
	skillTarget = "skillTarget"
}
BattleConstant.BattleTeamActionState = {
	WaitPerform = 3,
	Performing = 1,
	Free = 4,
	ManualOperate = 2
}
BattleConstant.RoundState = {
	RoundBegin = 1,
	BattleTeamTurn = 3,
	RoundEnd = 4,
	Free = 0,
	WaitDieEnd = 5,
	Transition = -1,
	Standby = 2
}
BattleConstant.BattleTeamTurnState = {}
BattleConstant.SpecialBuffTag = 500
BattleConstant.NormalSkillShowTypeCfgID = 2004001
BattleConstant.BattleUpdatePoint = {
	SkillStart = 4,
	Priority = 0,
	TurnStart = 3,
	RoundStart = 2,
	SkillEnd = 6,
	BattleStart = 1,
	ChooseSkillCommand = 9,
	SkillHit = 5,
	RoundEnd = 8,
	TurnEnd = 7
}
BattleConstant.BattleUnitState = {
	selectTarget = 3,
	selectSkill = 2,
	idle = 1
}
BattleConstant.POWER_2_BUFF_ID = 22210
BattleConstant.Weak_Status = {
	locked = 3,
	hide = 2,
	show = 1
}
BattleConstant.UnitCommonHitEffect = {
	[Constant.ElementType.ELEMENT_TYPE_PHYSICS] = {
		parent = "fx_spine_center",
		cid = 40015
	},
	[Constant.ElementType.ELEMENT_TYPE_WIND] = {
		parent = "fx_spine_center",
		cid = 40011
	},
	[Constant.ElementType.ELEMENT_TYPE_FIRE] = {
		parent = "fx_spine_center",
		cid = 40012
	},
	[Constant.ElementType.ELEMENT_TYPE_THUNDER] = {
		parent = "fx_spine_center",
		cid = 40013
	},
	[Constant.ElementType.ELEMENT_TYPE_WATER] = {
		parent = "fx_spine_center",
		cid = 40014
	}
}
BattleConstant.BattlePosDirection = {
	Left = 0,
	Right = 1
}
BattleConstant.BattleStateTimelineType = {
	Born = 1,
	Die = 2,
	Hit = 3
}
BattleConstant.TileBlockName = {
	Land = "Land"
}
BattleConstant.BattleUnitCreateType = {
	Substitute = 2,
	Summon = 1,
	Normal = 0
}
BattleConstant.OnUnitDieEffectTime = 2
BattleConstant.AutoFightDefaultSelectBattlePos = -1
BattleConstant.RendererFeatureSourceType = {
	FightStatus = 2,
	Manual = 0,
	Buff = 1
}
BattleConstant.RendererFeatureID = {
	MoveStealth = 10,
	SelfTarget = 4,
	Frozen = 6,
	Selected = 1,
	FriendTarget = 3,
	Poison = 7,
	Stealth = 8,
	AttackTarget = 2,
	Ghost = 5,
	Hit = 9
}
BattleConstant.UnitAIType = {
	Close = 1,
	Open = 0
}
BattleConstant.BattleTileBlockColor = {
	None = Color.New(1, 1, 1, 0),
	NoneUnit = Color.New(1, 1, 1, 0.5),
	HaveUnit = Color.New(1, 1, 1, 1)
}
BattleConstant.BattleTileBlockWarningColor = {
	MainTarget = Color.New(1, 1, 1, 1),
	SubTarget = Color.New(1, 1, 1, 0.5)
}
BattleConstant.CastSkillCheckResult = {
	EnergyNotEnough = 2,
	Legal = 1,
	UseCountLimit = 3,
	InCommonCD = 5,
	Sealed = 6,
	InCD = 4
}
BattleConstant.BattleOrderType = {
	PreviewSkill = 5,
	Rest = 1,
	CastSkill = 3,
	StatusSwitch = 4,
	Move = 2
}
BattleConstant.TileMoveDisAngleMap = {
	90,
	-45,
	0,
	45,
	[-3] = 180,
	[-1] = -90,
	[-4] = -135,
	[-2] = 135
}
