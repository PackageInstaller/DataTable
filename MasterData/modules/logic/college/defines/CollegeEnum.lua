-- chunkname: @modules/logic/college/defines/CollegeEnum.lua

module("modules.logic.college.defines.CollegeEnum", package.seeall)

local CollegeEnum = _M

CollegeEnum.CityPrefabPath = "modules/college/scene/scenes_prefab/v4a0_m_s08_college_p.prefab"
CollegeEnum.CityLowPrefabPath = "modules/college/scene/scenes_prefab/v4a0_m_s08_college_low_p.prefab"
CollegeEnum.MapPrefabPath = "modules/college/scene/scenes_prefab/v4a0_m_s08_map_p.prefab"
CollegeEnum.MapPrefabBgPath = "modules/college/scene/scenes_prefab/v4a0_m_s08_mapbg_p.prefab"
CollegeEnum.DungeonMapCameraSizeType = {
	High = 1,
	Middle = 2,
	Low = 3
}
CollegeEnum.DungeonMapCameraSize = {
	[CollegeEnum.DungeonMapCameraSizeType.High] = 12,
	[CollegeEnum.DungeonMapCameraSizeType.Middle] = 5,
	[CollegeEnum.DungeonMapCameraSizeType.Low] = 4
}
CollegeEnum.DungeonMapCameraSize2 = {
	[CollegeEnum.DungeonMapCameraSizeType.High] = 5,
	[CollegeEnum.DungeonMapCameraSizeType.Middle] = 4
}
CollegeEnum.SceneType = {
	Map = 2,
	City = 1
}
CollegeEnum.StoryParamType = {
	BuildingId = 2,
	Pos = 1,
	Custom = -1
}
CollegeEnum.DialogDir = {
	Left = 1,
	Right = 2
}
CollegeEnum.DialogEffectType = {
	Distress = 15,
	MemoryMask = 1,
	None = 0
}
CollegeEnum.MemoryMaskPath = "effects/prefabs/story/2_1_huiyimask_01.prefab"
CollegeEnum.ConstId = {
	ShowMaxTaskNum = 15,
	OutdoorChessDialogInterval = 20,
	CoinId = 13,
	GreenhouseEggProbability = 21,
	GreenhouseEggChessModel = 23,
	MapDefaultPos = 9,
	EndTurnCoinCost = 2,
	GreenhouseEggInterval = 22,
	ExtraBuildingPaths = 19,
	BubbleDialogIntervalTime = 10,
	CityDefaultPos = 8,
	CurrencyUpdateDuration = 14,
	ChessMoveRouteInterval = 18,
	MaxActorNum = 1
}
CollegeEnum.MsgPushType = {
	AreaUpdate = 5,
	CharacterDel = 4,
	PropUpdate = 8,
	CheckAndCompareScene = 1999,
	CharacterUpdate = 3,
	ItemUpdate = 1,
	ItemDel = 2,
	MilestoneUpdate = 9,
	StatusDel = 13,
	EventBoxUpdate = 14,
	MilestoneInfoUpdate = 18,
	PlayerInfoUpdate = 15,
	StatusUpdate = 12,
	CharacterChainUpdate = 7,
	BuildingUpdate = 11,
	TaskUpdate = 6
}
CollegeEnum.MsgPushTypeToName = GameUtil.listToDict(CollegeEnum.MsgPushType, nil, true)
CollegeEnum.Rare = {
	Bronze = 1,
	Silver = 2,
	Gold = 3
}
CollegeEnum.TaskState = {
	Finish = 2,
	Doing = 1,
	Reward = 3
}
CollegeEnum.TaskMixType = {
	Other = 2,
	First = 1
}
CollegeEnum.PrefabPath = {
	RolePanel = "modules/college/ui/viewres/college_rolepanelitem.prefab",
	RoleItem = "modules/college/ui/viewres/college_roleitem.prefab",
	MilestoneThemeItem = "modules/college/ui/viewres/college_milestonethemeitem.prefab",
	FlyEffect = "modules/college/ui/viewres/college_flyeffect.prefab",
	Currency = "modules/college/ui/viewres/college_currencybar.prefab"
}
CollegeEnum.ItemType = {
	Resource = 2,
	Story = 3,
	Power = 1
}
CollegeEnum.CurrencyItemTypeList = {
	CollegeEnum.ItemType.Resource
}
CollegeEnum.BuildingType = {
	ProduceResource = "produceResource",
	TrainCharacter = "trainCharacter",
	OpenReward = "openReward",
	RecruitCharacter = "recruitCharacter"
}
CollegeEnum.StoryType = {
	ImageText2 = 2,
	ImageText1 = 1
}
CollegeEnum.BuildingViewType = {
	Upgrade = 2,
	Info = 1,
	Dispatch = 3
}
CollegeEnum.BuildingActorSlotState = {
	Use = 2,
	Lock = 0,
	Empty = 1
}
CollegeEnum.ItemCostColorType = {
	Light = 1,
	Dark = 2
}
CollegeEnum.ItemCostColor = {
	[CollegeEnum.ItemCostColorType.Light] = {
		Enough = "#DDD4BC",
		NotEnough = "#C8364E"
	},
	[CollegeEnum.ItemCostColorType.Dark] = {
		Enough = "#000000",
		NotEnough = "#C8364E"
	}
}
CollegeEnum.ItemIdToAttrSuffix = {
	[4002003] = 3,
	[4002002] = 2,
	[4002001] = 1
}
CollegeEnum.AttrId = {
	AreaBaseItem3 = 3003,
	BuildingBaseItem3 = 1003,
	BuildingBaseItem2 = 1002,
	AreaItem3 = -23,
	AreaItem1 = -21,
	BuildingBaseItem1 = 1001,
	RoleRefineCostFix = 9012,
	BuildingItem2 = -12,
	PlayerRecruitCostFix = 9021,
	BuildingRefineCostFix = 9002,
	RoleUpgradeCostRate = 5000,
	BuildingRecruitCostFix = 9001,
	PlayerRefineCostFix = 9022,
	PlayerBaseItem3 = 6003,
	RoleRecruitCostFix = 9011,
	PlayerBaseItem2 = 6002,
	BuildingItem3 = -13,
	AreaBaseItem2 = 3002,
	AreaBaseItem1 = 3001,
	AreaItem2 = -22,
	PlayerBaseItem1 = 6001,
	BuildingItem1 = -11
}
CollegeEnum.StoryNodeStatus = {
	Unlocked = 1,
	Locked = 0,
	Active = 2
}
CollegeEnum.AreaStatus = {
	Suspend = 3,
	Unexplore = 1,
	Explored = 4,
	Exploring = 2,
	None = 0
}
CollegeEnum.ServerMsgReason = {
	RecruitCharacter = 11,
	EventReward = 9,
	None = 0
}
CollegeEnum.CharacterRelationColor = {
	SLFramework.UGUI.GuiHelper.ParseColor("#FFFFFF"),
	SLFramework.UGUI.GuiHelper.ParseColor("#154c98"),
	(SLFramework.UGUI.GuiHelper.ParseColor("#981528"))
}
CollegeEnum.RelationShipBoardPage = {
	Default = 1,
	Chapter13 = 2
}
CollegeEnum.PrefsKey = {
	RelationShipBoardFirstOpenCha = 2,
	RelationShipBoardFirstOpenLine = 3,
	RelationShipBoardFirstOpenTeam = 1,
	CampNewFlag = 4
}
CollegeEnum.MaxCampLocationIndex = 7
CollegeEnum.Page2_ChainId = 200000
CollegeEnum.ActorType = {
	Npc = "npc",
	Unique = "unique"
}
CollegeEnum.RewardStatus = {
	Canget = 2,
	Hasget = 3,
	None = 1
}
CollegeEnum.CharacterClickState = {
	Default = 0,
	NoClick = 1
}
CollegeEnum.StoryNodeType = {
	Milestone = 2,
	Instant = 3,
	MapElement = 1
}
CollegeEnum.ThemeScaleOffset = 200
CollegeEnum.ThemeCenterScale = 2

return CollegeEnum
