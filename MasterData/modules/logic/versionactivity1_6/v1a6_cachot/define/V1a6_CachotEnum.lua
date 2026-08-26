-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/define/V1a6_CachotEnum.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.define.V1a6_CachotEnum", package.seeall)

local V1a6_CachotEnum = _M

V1a6_CachotEnum.EventType = {
	Battle = 1,
	CollectionSelect = 9,
	CharacterCure = 5,
	Random = 3,
	Tip = 11,
	HeroPosUpgrade = 10,
	Store = 4,
	CharacterRebirth = 6,
	ChoiceSelect = 2,
	CharacterGet = 7,
	Empty = 8
}
V1a6_CachotEnum.NoLimit = "3"
V1a6_CachotEnum.HeroCountInGroup = 4
V1a6_CachotEnum.MaxHeroCountInGroup = 4
V1a6_CachotEnum.InitTeamMaxHeroCountInGroup = 8
V1a6_CachotEnum.ActivityId = 11610
V1a6_CachotEnum.SecondLayerFirstRoom = 1012001
V1a6_CachotEnum.EventStatus = {
	Finish = 2,
	NoStart = 0,
	Start = 1
}
V1a6_CachotEnum.BossType = {
	Elite = 2,
	Boss = 3,
	Normal = 1
}
V1a6_CachotEnum.EventPauseType = {
	Tips = 3,
	Choice = 2,
	GetCollecttions = 4,
	Request = 1,
	Normal = 0
}
V1a6_CachotEnum.TipStyle = {
	ChangeConclusion = 2,
	Normal = 1
}
V1a6_CachotEnum.DropType = {
	HeroPosUpgrade = 6,
	Collection = 5,
	ReviveEvent = 7,
	SelectCollection = 4,
	CureEvent = 2,
	CharacterGet = 3,
	Currency = 1
}
V1a6_CachotEnum.DropCurrencyType = {
	Coin = 1,
	Currency = 2
}
V1a6_CachotEnum.CureEventType = {
	All = 3,
	Single = 1,
	Random = 2
}
V1a6_CachotEnum.CollectionCategoryType = {
	All = 1,
	UnGet = 3,
	HasGet = 2
}
V1a6_CachotEnum.CollectionState = {
	UnLocked = 2,
	Locked = 3,
	HasGet = 1
}
V1a6_CachotEnum.CollectionType = {
	Weapon = 1,
	Magic = 4,
	Protect = 2,
	Enchant = 5,
	Decorate = 3
}
V1a6_CachotEnum.CollectionShowRare = {
	Enchant = 2,
	Boss = 3,
	Normal = 1
}
V1a6_CachotEnum.EmptyEnchantId = 0
V1a6_CachotEnum.CollectionInHandBook = 1
V1a6_CachotEnum.SpecialCollection = 91320070
V1a6_CachotEnum.HelpUnlockGuideId = 16503
V1a6_CachotEnum.Const = {
	LayerBGM = 14,
	MoveSpeed = 1,
	StoryNode2 = 10,
	StoryNode4 = 12,
	MainViewCollectionList = 3,
	RecoverEvent = 7,
	StoryNode3 = 11,
	HeartConst = 6,
	DoubleScoreLimit = 2,
	ChangeConclusion = 8,
	LayerFightScene = 15,
	FirstRoomValue = 19,
	StoryNode1 = 9,
	GiveupUpgrade = 5
}
V1a6_CachotEnum.CollectionTypeName = {
	[V1a6_CachotEnum.CollectionType.Weapon] = "cachot_CollectionTypeName_Weapon",
	[V1a6_CachotEnum.CollectionType.Protect] = "cachot_CollectionTypeName_Protect",
	[V1a6_CachotEnum.CollectionType.Decorate] = "cachot_CollectionTypeName_Decorate",
	[V1a6_CachotEnum.CollectionType.Magic] = "cachot_CollectionTypeName_Magic",
	[V1a6_CachotEnum.CollectionType.Enchant] = "cachot_CollectionTypeName_Enchant"
}
V1a6_CachotEnum.MainViewLevelID = 90001
V1a6_CachotEnum.ChoiceConditionType = {
	CoinCount = 3,
	CollectionCountGreater = 4,
	CollectionCountLess = 5,
	AllHeroLifeLess = 11,
	AllHeroLifeGreater = 10,
	CollectionGroupCountLess = 7,
	HeartRange = 2,
	HeartLess = 13,
	HeartGreater = 12,
	OneHeroLifeGreater = 8,
	CollectionGroupCountGreater = 6,
	OneHeroLifeLess = 9,
	HaveCollection = 1
}
V1a6_CachotEnum.HeroGroupEditType = {
	Fight = 2,
	Event = 3,
	Init = 1
}
V1a6_CachotEnum.GuideDragTipType = {
	Hide = 0,
	Right = 2,
	Left = 1
}
V1a6_CachotEnum.MilestonesState = {
	UnFinish = 0,
	Locked = 3,
	CanReceive = 1,
	HasReceived = 2
}
V1a6_CachotEnum.UnLockedRewardItemWidth = 240
V1a6_CachotEnum.LockedRewardItemWidth = 1033
V1a6_CachotEnum.CollectionHole = {
	Left = 1,
	Right = 2
}
V1a6_CachotEnum.DifficultyView = {
	HardMask = 3,
	NormalMask = 1,
	MiddleMask = 2
}
V1a6_CachotEnum.PlayerEffect = {
	RoleTransEffect = "RoleTransEffect",
	RoleBornEffect = "RoleBornEffect"
}
V1a6_CachotEnum.CoinId = 1603
V1a6_CachotEnum.CurrencyId = 1604

return V1a6_CachotEnum
