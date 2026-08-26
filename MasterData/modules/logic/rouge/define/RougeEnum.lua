-- chunkname: @modules/logic/rouge/define/RougeEnum.lua

module("modules.logic.rouge.define.RougeEnum", package.seeall)

local RougeEnum = _M

RougeEnum.ResPath = {
	rougepageprogress = "ui/viewres/rouge/rougepageprogress.prefab",
	CollectionLevelUpLeftItem = "ui/viewres/rouge/dlc/102/rougecollectionlevelupleftitem.prefab",
	CollectionLevelUpRightItem = "ui/viewres/rouge/dlc/102/rougecollectionleveluprightitem.prefab",
	CommonLvItem = "ui/viewres/rouge/rougeitemlv.prefab",
	rougedifficultyitem = "ui/viewres/rouge/rougedifficultyitem.prefab",
	CollectionIconItem = "ui/viewres/rouge/rougecollectioniconitem.prefab",
	rougefactionitem = "ui/viewres/rouge/rougefactionitem.prefab",
	CommonCollectionItem = "ui/viewres/rouge/rougeitemcollection.prefab",
	CommonHeroGroupItem = "ui/viewres/rouge/rougeitemherogroup.prefab",
	ActivityTaskEntryItem = "ui/viewres/rouge/rougeactivitytaskentryitem.prefab",
	CoinView = "ui/viewres/rouge/map/rougemapcoinview.prefab",
	CollectionDetailBtnItem = "ui/viewres/rouge/map/rougemapdetailview.prefab",
	CommonCollectionSlotItem = "ui/viewres/rouge/rougecollectionslotitem.prefab"
}
RougeEnum.TalentState = {
	CannotActivated = 4,
	CanActivated = 3,
	Activated = 1,
	Disabled = 5,
	SiblingActivated = 2
}
RougeEnum.HelpState = {
	Full = 3,
	UnSelected = 2,
	Selected = 1
}
RougeEnum.TeamType = {
	Treat = 2,
	View = 1,
	Assignment = 4,
	Revive = 3
}
RougeEnum.FavoriteType = {
	Illustration = 3,
	Collection = 1,
	Story = 4,
	Faction = 2
}
RougeEnum.FirstLayerId = 111
RougeEnum.CollectionListViewDelayTime = 0.3
RougeEnum.IllustrationNumOfPage = 6
RougeEnum.InitTeamHeroNum = 8
RougeEnum.FightTeamHeroNum = 8
RougeEnum.FightTeamNormalHeroNum = 4
RougeEnum.DefaultTeamHeroNum = 4
RougeEnum.HeroGroupEditType = {
	Fight = 2,
	FightAssit = 3,
	SelectHero = 4,
	Init = 1
}
RougeEnum.Const = {
	RecoverExtraPoint = 8001,
	EndingThreeContent = 6002,
	FourthEndingStoryId = 9002,
	FourthEndingChoiceIds = 9001,
	AchievementJumpId = 51,
	RoleCapacity = 2,
	MaxExtraPoint = 8002,
	TalentCost = 27,
	SelectHeroCapacity = 8,
	RewardTranslation = 1018,
	TalentTranslation = 1019,
	RoleHalfCapacity = 9,
	FavoriteEndingShow = 42,
	EndingThreeTitle = 6001,
	CompositeEntryVisible = 47,
	AddExraPoint = 8003,
	TalentBigNode = 25
}
RougeEnum.OutsideConst = {
	RewardPointLimit = 4,
	ActivityTaskId = 9003,
	RewardCost = 2,
	SkillPointLimit = 1,
	StartNode = 101
}
RougeEnum.BigRewardType = {
	Triple = 6,
	RoomItem = 2,
	Double = 4,
	Role = 1,
	Skin = 5,
	Artifice = 3
}
RougeEnum.CollectionHeight = {
	Big = 285,
	Small = 224
}
RougeEnum.CollectionListRowNum = 5
RougeEnum.MaxCollectionSlotSize = Vector2(8, 8)
RougeEnum.MaxCollectionBagSize = Vector2(8, 7)
RougeEnum.MinCollectionExtraTagID = 100
RougeEnum.CompositeCollectionCostCount = 1
RougeEnum.MaxLevelSpAttrId = 4001
RougeEnum.CollectionEditorParamType = {
	CenterPos = 4,
	Effect = "effectArea",
	DragPos = "dragPos",
	ShapeSize = "shapeSize",
	Shape = "shapeArea",
	IconOffset = "iconOffset",
	LeftTopPos = "leftTopPos",
	shapeMatrix = "shapeMatrix"
}
RougeEnum.LineState = {
	Blue = 4,
	Green = 3,
	Red = 2,
	Grey = 1
}
RougeEnum.SlotCellDirection = {
	Top = 1,
	Left = 3,
	Bottom = 2,
	Right = 4
}
RougeEnum.CollectionType = {
	Weapon = 103,
	Magic = 104,
	Price = 108,
	Special = 107,
	Baggage = 106,
	Decorate = 101,
	Enchant = 105,
	Protect = 102
}
RougeEnum.CollectionTypeSort = {
	[RougeEnum.CollectionType.Weapon] = 1,
	[RougeEnum.CollectionType.Protect] = 2,
	[RougeEnum.CollectionType.Decorate] = 3,
	[RougeEnum.CollectionType.Magic] = 4,
	[RougeEnum.CollectionType.Enchant] = 5,
	[RougeEnum.CollectionType.Baggage] = 6,
	[RougeEnum.CollectionType.Special] = 7,
	[RougeEnum.CollectionType.Price] = 8
}
RougeEnum.CollectionTipPos = {
	Slot = Vector2(310, 0),
	Bag = Vector2(-340, 0),
	CompositeBaseCollection = Vector2(-430, 0),
	OverView = Vector2(0, 0),
	HandBook = Vector2(-310, 0),
	MapRule = Vector2(-340, 0)
}
RougeEnum.EmptyEnchantId = 0
RougeEnum.CollectionRotation = {
	Rotation_270 = 3,
	Rotation_90 = 1,
	Rotation_0 = 0,
	Rotation_180 = 2
}
RougeEnum.OpenCollectionTipSource = {
	BagArea = 2,
	SlotArea = 1,
	ChoiceView = 3
}
RougeEnum.CollectionReason = {
	Composite = 2,
	Product = 1,
	Other = 0
}
RougeEnum.CollectionPlaceArea = {
	SlotArea = 1,
	BagArea = 2
}
RougeEnum.State = {
	Style = 3,
	isEnd = 5,
	LastReward = 2,
	Difficulty = 1,
	Start = 4,
	Empty = 0
}
RougeEnum.CollectionBgMaxSize = 4
RougeEnum.EffectActiveType = {
	Electric = 1,
	Engulf = 2,
	LevelUp = 3,
	Null = 0
}
RougeEnum.EffectTriggerType = {
	LevelUp = 2,
	Engulf = 1,
	Null = 0
}
RougeEnum.CollectionArtType = {
	LevelUpLine = 6,
	EngulfLine = 7,
	Place = 1,
	EngulfTrigger2 = 11,
	Effect = 2,
	LevelUPTrigger1 = 8,
	LevelUPTrigger2 = 9,
	EngulfTrigger1 = 10,
	LevelUP = 5,
	Lighting = 3,
	Engulf = 4,
	None = 0
}
RougeEnum.CollectionInfoType = {
	Complex = 2,
	Simple = 1
}
RougeEnum.DefaultCollectionInfoType = RougeEnum.CollectionInfoType.Simple
RougeEnum.CollectionEntryState = {
	Icon = 2,
	Grid = 1
}
RougeEnum.PopType = {
	ViewName = 1,
	Func = 2
}
RougeEnum.StartViewEnum = {
	point = "point",
	capacity = "capacity",
	coin = "coin",
	power = "power",
	powerLimit = "powerLimit"
}
RougeEnum.SkillType = {
	Style = "skill",
	Map = "mapSkill"
}
RougeEnum.SkillTypeSortEnum = {
	[RougeEnum.SkillType.Style] = 1,
	[RougeEnum.SkillType.Map] = 2
}
RougeEnum.CollectionDescType = {
	Text = 3,
	SpecialHeader = 4,
	BaseEffect = 2,
	ExtraEffect = 1,
	SpecialText = 5
}
RougeEnum.CollectionDescTypeSort = {
	[RougeEnum.CollectionDescType.SpecialHeader] = 1,
	[RougeEnum.CollectionDescType.ExtraEffect] = 2,
	[RougeEnum.CollectionDescType.BaseEffect] = 3,
	[RougeEnum.CollectionDescType.SpecialText] = 4,
	[RougeEnum.CollectionDescType.Text] = 5
}
RougeEnum.IllustrationType = {
	DLC = 2,
	Normal = 1
}
RougeEnum.CollectionDescSource = {
	Config = 1,
	Inst = 2
}
RougeEnum.EndingThreeId = 103

return RougeEnum
