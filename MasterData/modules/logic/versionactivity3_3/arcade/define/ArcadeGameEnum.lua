-- chunkname: @modules/logic/versionactivity3_3/arcade/define/ArcadeGameEnum.lua

module("modules.logic.versionactivity3_3.arcade.define.ArcadeGameEnum", package.seeall)

local ArcadeGameEnum = _M

ArcadeGameEnum.Const = {
	AreaNodePortalName = "nodePortal",
	EntityZLevel = -0.1,
	MonsterGroupColName = "column",
	RoomSize = 8,
	DefaultCharacterTurnTime = 5000,
	DualWieldingCarryWeapon = 2,
	FightFloatWaitTime = 0.1,
	GuideDifficulty = 0,
	HpZLevel = -0.1,
	HpItemResName = "v3a3_m_s12_dj_a01",
	EffectZLevel = -0.1,
	NormalCarryWeapon = 1,
	RoomMinCoordinateValue = 1,
	MaxDropProbability = 1000,
	SkillBombLongPressTime = 0.5,
	MaxPasswordLength = 8,
	GameSceneName = "ArcadeGameScene",
	MaxGenerateMonsterProbability = 1000,
	DefaultEntityDirection = ArcadeEnum.Direction.Right
}
ArcadeGameEnum.BaseAttr = {
	defense = 102,
	attack = 101,
	hp = 103,
	hpCap = 104
}
ArcadeGameEnum.GameAttribute = {
	AddSkillDamage = 301,
	AddBombDamage = 302,
	GoodsDiscount = 304,
	AddWeaponDurability = 305,
	ResetStoreCost = 306,
	AddBombRange = 303,
	ExtraMonster = 307
}
ArcadeGameEnum.GameSwitch = {
	BombNotAttackSelf = 401,
	DualWielding = 403,
	BombAddFloor = 404,
	CanResetStore = 402
}
ArcadeGameEnum.SkillHitName = {
	Summon = "summon"
}
ArcadeGameEnum.PlayerActType = {
	Move = 1,
	Attack = 2,
	UseBomb = 4,
	UseSkill = 3,
	None = 0
}
ArcadeGameEnum.DropItemType = {
	Collection = 2,
	Character = 3,
	Resource = 1
}
ArcadeGameEnum.CharacterResource = {
	Score = 205,
	Diamond = 202,
	GameCoin = 201,
	SkillEnergy = 203,
	Bomb = 204,
	RespawnTimes = 206,
	Cassette = 207
}
ArcadeGameEnum.GameCounter = {
	SpecBuffMonsterKillsSinceAddSkill = "SpecBuffMonsterKillsSinceAddSkill",
	MonsterKillsSinceAddSkill = "MonsterKillsSinceAddSkill",
	AttackTimesSinceAddSkill = "AttackTimesSinceAddSkill",
	RoundSinceAddSkill = "RoundSinceAddSkill"
}
ArcadeGameEnum.NeedSaveGameCounter = {
	[ArcadeGameEnum.GameCounter.MonsterKillsSinceAddSkill] = true,
	[ArcadeGameEnum.GameCounter.SpecBuffMonsterKillsSinceAddSkill] = true
}
ArcadeGameEnum.GameCounterCls = {}
ArcadeGameEnum.CollectionType = {
	Weapon = "weapon",
	Jewelry = "jewelry"
}
ArcadeGameEnum.AttackType = {
	Bomb = 4,
	Skill = 3,
	Link = 2,
	Normal = 1
}
ArcadeGameEnum.RoomType = {
	Reward = "reward",
	Store = "store",
	Boss = "boss",
	Elite = "elite",
	Rest = "rest",
	Event = "event",
	Normal = "normal"
}
ArcadeGameEnum.RoomTypeCls = {
	[ArcadeGameEnum.RoomType.Normal] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Store] = ArcadeStoreRoom,
	[ArcadeGameEnum.RoomType.Boss] = ArcadeBossRoom,
	[ArcadeGameEnum.RoomType.Elite] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Reward] = ArcadeNormalRoom,
	[ArcadeGameEnum.RoomType.Event] = ArcadeInteractRoom,
	[ArcadeGameEnum.RoomType.Rest] = ArcadeInteractRoom
}
ArcadeGameEnum.RoomDropMethodType = {
	Fixed = "fixed",
	Random = "random"
}
ArcadeGameEnum.EventOptionType = {
	TriggerPassiveSkill = "triggerPassiveSkill",
	Buy = "buy",
	ChangeRoom = "transmitRoom",
	NextArea = "enterNextArea",
	ConfirmPassword = "confirmPassword",
	StorePassword = "storePassword",
	ResetPassword = "resetPassword"
}
ArcadeGameEnum.EventOptionHandler = {
	[ArcadeGameEnum.EventOptionType.ChangeRoom] = ArcadeGameHelper._eventChangeRoom,
	[ArcadeGameEnum.EventOptionType.NextArea] = ArcadeGameHelper._eventNextArea,
	[ArcadeGameEnum.EventOptionType.Buy] = ArcadeGameHelper._eventBuy,
	[ArcadeGameEnum.EventOptionType.TriggerPassiveSkill] = ArcadeGameHelper._eventTriggerPassiveSkill,
	[ArcadeGameEnum.EventOptionType.StorePassword] = ArcadeGameHelper._eventStorePassword,
	[ArcadeGameEnum.EventOptionType.ConfirmPassword] = ArcadeGameHelper._eventConfirmPassword,
	[ArcadeGameEnum.EventOptionType.ResetPassword] = ArcadeGameHelper._eventResetPassword
}
ArcadeGameEnum.EventOptionConditionCheck = {
	CheckCollection = "checkHaveCollection",
	CheckAttribute = "checkAttrValue",
	CheckSkillSummon = "checkCanSkillSummon"
}
ArcadeGameEnum.EventOptionConditionCheckHandler = {
	[ArcadeGameEnum.EventOptionConditionCheck.CheckAttribute] = ArcadeGameHelper._checkAttribute,
	[ArcadeGameEnum.EventOptionConditionCheck.CheckCollection] = ArcadeGameHelper._checkCollection,
	[ArcadeGameEnum.EventOptionConditionCheck.CheckSkillSummon] = ArcadeGameHelper._checkSkillCanSummon
}
ArcadeGameEnum.EntityType = {
	Floor = "floor",
	PWDValidator = "pwdValidator",
	Goods = "goods",
	Bomb = "bomb",
	Portal = "portal",
	BaseInteractive = "baseInteractive",
	Grid = "grid",
	Character = "character",
	Monster = "monster"
}
ArcadeGameEnum.IconEntityTypes = {
	ArcadeGameEnum.EntityType.Character,
	ArcadeGameEnum.EntityType.Monster,
	ArcadeGameEnum.EntityType.BaseInteractive,
	ArcadeGameEnum.EntityType.Goods,
	ArcadeGameEnum.EntityType.Portal,
	ArcadeGameEnum.EntityType.PWDValidator
}
ArcadeGameEnum.EntityLayer = {
	Floor = 2,
	Bomb = 3,
	Normal = 1
}
ArcadeGameEnum.EntityType2Layer = {
	[ArcadeGameEnum.EntityType.Character] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.Monster] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.Grid] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.BaseInteractive] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.Portal] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.Goods] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.PWDValidator] = ArcadeGameEnum.EntityLayer.Normal,
	[ArcadeGameEnum.EntityType.Bomb] = ArcadeGameEnum.EntityLayer.Bomb,
	[ArcadeGameEnum.EntityType.Floor] = ArcadeGameEnum.EntityLayer.Floor
}
ArcadeGameEnum.HandBookType = {
	Floor = 3,
	Collection = 2,
	Character = 1,
	Monster = 4
}
ArcadeGameEnum.EntityTypeMOCls = {
	[ArcadeGameEnum.EntityType.Character] = ArcadeGameCharacterMO,
	[ArcadeGameEnum.EntityType.Monster] = ArcadeGameMonsterMO,
	[ArcadeGameEnum.EntityType.Bomb] = ArcadeGameBombMO,
	[ArcadeGameEnum.EntityType.Floor] = ArcadeGameFloorMO,
	[ArcadeGameEnum.EntityType.BaseInteractive] = ArcadeGameBaseInteractiveMO,
	[ArcadeGameEnum.EntityType.Portal] = ArcadeGameBaseInteractiveMO,
	[ArcadeGameEnum.EntityType.Goods] = ArcadeGameGoodsMO,
	[ArcadeGameEnum.EntityType.PWDValidator] = ArcadeGamePWDValidatorMO
}
ArcadeGameEnum.EntityTypeCls = {
	[ArcadeGameEnum.EntityType.Character] = ArcadeGameCharacterEntity,
	[ArcadeGameEnum.EntityType.Monster] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.Bomb] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.Floor] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.BaseInteractive] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.Portal] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.Goods] = ArcadeGameBaseEntity,
	[ArcadeGameEnum.EntityType.PWDValidator] = ArcadeGameBaseEntity
}
ArcadeGameEnum.MonsterRace = {
	Boss = "boss"
}
ArcadeGameEnum.MoveType = {
	NoDrop = "noDrop",
	NormalDrop = "normalDrop"
}
ArcadeGameEnum.TriggerPoint = {
	AfterAddFloor721 = 721,
	Character813 = 813,
	BeforeRemoveFloor722 = 722,
	HitBefore251 = 251,
	RoundBegin815 = 815,
	BeforeDoMove303 = 303,
	AfterRemoveFloor723 = 723,
	EnterRoom = 10,
	DeathAfter720 = 720,
	DeathAfter712 = 712,
	Death702 = 702,
	AfterBombExplode505 = 505,
	Monster805 = 805,
	Death701 = 701,
	MoveEnd302 = 302,
	MoveEnd = 301,
	Monster814 = 814,
	GameStart = 1,
	Monster812 = 812,
	None = 0,
	Character801 = 801,
	Monster804 = 804,
	Character803 = 803,
	AfterGainCollection501 = 501,
	Monster802 = 802,
	Atk203 = 203,
	DeathAfter724 = 724,
	Character811 = 811,
	HitBefore202 = 202,
	BeforeRemoveCollection503 = 503,
	AfterPlaceBomb502 = 502,
	AtkBefore201 = 201,
	Hit204 = 204,
	AfterRemoveCollection504 = 504
}
ArcadeGameEnum.SortType = {
	DownUpLeftRight = 1
}
ArcadeGameEnum.TriggerPoint2SortType = {
	[ArcadeGameEnum.TriggerPoint.Monster802] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster804] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster812] = ArcadeGameEnum.SortType.DownUpLiftRight,
	[ArcadeGameEnum.TriggerPoint.Monster814] = ArcadeGameEnum.SortType.DownUpLiftRight
}
ArcadeGameEnum.AttrType = {
	GameSwitch = 4,
	Attack = 1,
	GameAttr = 3,
	Resource = 2
}
ArcadeGameEnum.BuffEffectName = {
	OnlySpecAttack = "OnlySpecAttack",
	NotBeAttack = "NotBeAttack",
	SpecAttackDamageFactor = "SpecAttackDamageFactor",
	StopMove = "StopMove",
	NotBeCountered = "NotBeCountered"
}
ArcadeGameEnum.TriggerCfgKeys = {
	Condition = {
		"condition1",
		"condition2",
		"condition3",
		"condition4",
		"condition5"
	},
	Effect = {
		"effect1",
		"effect2",
		"effect3",
		"effect4",
		"effect5"
	},
	TriggerPoint = {
		"triggerPoint1",
		"triggerPoint2",
		"triggerPoint3",
		"triggerPoint4",
		"triggerPoint5"
	},
	Limit = {
		"limit1",
		"limit2",
		"limit3",
		"limit4",
		"limit5"
	},
	EffectId = {
		"effectId1",
		"effectId2",
		"effectId3",
		"effectId4",
		"effectId5"
	},
	AtkEffectId = {
		"atkEffectId1",
		"atkEffectId2",
		"atkEffectId3",
		"atkEffectId4",
		"atkEffectId5"
	}
}
ArcadeGameEnum.ActionShowId = {
	Remove = 6,
	BaseAttack = 3,
	ElectricHit = 19,
	AddHp = 8,
	BombWarn = 15,
	GainBuff = 13,
	Born = 1,
	BombAttack = 9,
	EnterDead = 5,
	ActiveSkillHit = 12,
	ActiveSkill = 11,
	DropCoin = 16,
	Interactive = 17,
	BombExposeRange = 14,
	BombHit = 7,
	RemovePWDValidator = 18,
	Respawn = 10,
	BaseHit = 4,
	Move = 2
}
ArcadeGameEnum.StateShowId = {
	Idle = 1,
	Dead = 2
}
ArcadeGameEnum.SettleType = {
	Abandon = 1,
	Fail = 3,
	Win = 2
}
ArcadeGameEnum.TalkTriggerType = {
	EnterRoom = "3",
	BeBombAttack = "5",
	Interactive = "4",
	Near = "2"
}
ArcadeGameEnum.MaxSkillTriggerCount = 500
ArcadeGameEnum.PrintLog = false
ArcadeGameEnum.FloorIceID = 102

return ArcadeGameEnum
