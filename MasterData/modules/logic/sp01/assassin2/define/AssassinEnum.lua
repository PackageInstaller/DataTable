-- chunkname: @modules/logic/sp01/assassin2/define/AssassinEnum.lua

module("modules.logic.sp01.assassin2.define.AssassinEnum", package.seeall)

local AssassinEnum = _M

AssassinEnum.ConstId = {
	DialogId_EyeGame = 9,
	FocusEpisodeId = 17,
	RequireAssassinHeroId = 4,
	EpisodeId_PointGame = 8,
	AttachedEpisodeIds = 16,
	QuestMapTweenTime = 12,
	EpisodeId_EyeGame = 6,
	MapSize = 3,
	DialogId_PointGame = 11,
	StealthGameGridPoint = 5,
	MaxBagCapacity = 2,
	AfterStoryId_EyeGame = 13,
	AfterStoryId_PointGame = 15,
	AfterStoryId_LineGame = 14,
	DialogId_LineGame = 10,
	EpisodeId_LineGame = 7
}
AssassinEnum.Const = {
	EmptyAssassinItemType = 0,
	MapQuestMaxProgress = 1
}
AssassinEnum.BlockKey = {
	FinishMission = "AssassinStealthGameFinishMission",
	ClosingLoginView = "AssassinClosingLoginView",
	SelectedEnemy = "AssassinStealthGameSelectEnemy",
	PlayAttackEff = "AssassinStealthGamePlayAttackEff",
	EnterStealthGameEff = "AssassinEnterStealthGameEff",
	EnemyOperation = "AssassinStealthGameEnemyOperation",
	QuestMapTween = "AssassinQuestMapTween",
	LoadGameRes = "AssassinStealthGameLoadResBlockKey",
	PlayRoundAnim = "AssassinStealthGamePlayRoundAnim",
	TweenMapPos = "AssassinStealthGameTweenMapPos",
	EnemyScanEffPlaying = "AssassinStealthGameEnemyScanEffPlaying"
}
AssassinEnum.MapStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
AssassinEnum.QuestType = {
	Fight = 1,
	Stealth = 3,
	Dialog = 2
}
AssassinEnum.PlayerCacheDataKey = {
	AssassinHeroGroupCache = "AssassinHeroGroupCache",
	QuestItemOpenAnim = "ASSASSIN2_QUEST_HAS_PLAYED_OPEN_ANIM",
	MapPlayUnlockAnim = "ASSASSIN2_MAP_HAS_PLAYED_UNLOCK_ANIM",
	NewAssassinItem = "ASSASSIN2_NEW_ASSASSIN_ITEM",
	QuestItemFinishAnim = "ASSASSIN2_QUEST_HAS_PLAYED_FINISH_ANIM"
}
AssassinEnum.StealthConstId = {
	MaxRound = 1
}
AssassinEnum.StealthConst = {
	AdjacentDis = 1,
	ConfigExposeRatePoint = 10000,
	ShowExposeRatePoint = 100,
	MinMapScale = 0.35,
	MaxMapScale = 1,
	QuestMapGuide = 130527,
	HideMoveDis = 0,
	HpRatePoint = 100,
	MapTweenPosTime = 0.26,
	EnemyTurnWaitTime = 1.2,
	MinExposeRate = 0,
	HorWallSign = 1,
	MaxExposeRate = 1,
	MoveDis = 1,
	FirstStealthMap = 3011,
	VerWallSign = 2
}
AssassinEnum.EffectId = {
	GridFog = 18,
	EnemyAttack = 21,
	ScanEffectId = 3
}
AssassinEnum.StealthGameGridType = {
	Water = 3,
	Plain = 1,
	Roof = 2
}
AssassinEnum.StealthGamePointType = {
	HayStack = 1,
	Garden = 2,
	Tower = 3,
	Empty = 0
}
AssassinEnum.EventType = {
	NotExpose = 5,
	ChangExposeRate = 3
}
AssassinEnum.MissionType = {
	TargetEnemy = 3,
	TargetGrid2 = 5,
	TargetGrid3 = 7,
	TargetGrid1 = 4
}
AssassinEnum.ItemType = {
	AirCraft = 5,
	ThrowingKnife = 2,
	PoisonKnife = 4
}
AssassinEnum.StealGameBuffType = {
	Confuse = 1,
	Petrifaction = 2
}
AssassinEnum.EnemyType = {
	Heavy = 3
}
AssassinEnum.EnemyMoveType = {
	NotMove = 2,
	Normal = 1
}
AssassinEnum.StealGameTrapType = {
	Smog = 3,
	Locked = 2,
	Poison = 1
}
AssassinEnum.RoofEntranceDir = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
AssassinEnum.HeroStatus = {
	Dead = 4,
	Stealth = 1,
	Hide = 3,
	Expose = 2
}
AssassinEnum.HeroAct = {
	LeaveHide = 3,
	ClimbTower = 9,
	Hide = 2,
	AirAssassinate = 12,
	Ambush = 5,
	AttackTogether = 7,
	HideAssassinate = 13,
	HandleBody = 14,
	Attack = 4,
	AmbushTogether = 8,
	Jump = 11,
	Assassinate = 6,
	LeaveTower = 10,
	Move = 1
}
AssassinEnum.StealthRes = {
	HeroEntity = "ui/viewres/sp01/assassin2/assassinstealthgameheroitem.prefab",
	EnemyEntity = "ui/viewres/sp01/assassin2/assassinstealthgameemenyitem.prefab"
}
AssassinEnum.GameState = {
	Win = 1,
	Fail = 2,
	InProgress = 0
}
AssassinEnum.Skill = {
	Transfer = 11,
	CureAll = 7,
	LightGrid = 10,
	AddAp = 14,
	Petrifaction = 8,
	Cure = 6
}
AssassinEnum.SkillCostType = {
	AP = "actionability"
}
AssassinEnum.SkillPropTargetType = {
	Grid = "grid",
	Hero = "friend",
	Enemy = "enemy",
	None = ""
}
AssassinEnum.SkillPropTargetCheckType = {
	GridType = 1,
	EnemyRefreshPoint = 2
}
AssassinEnum.RangeType = {
	StraightLine = "StraightLine"
}
AssassinEnum.TowerPointIndex = {
	LeftTop = 13,
	RightBottom = 1,
	LeftBottom = 3,
	RightTop = 11
}
AssassinEnum.TowerPointPos = {
	[AssassinEnum.TowerPointIndex.RightBottom] = {
		x = 12,
		y = -12
	},
	[AssassinEnum.TowerPointIndex.RightTop] = {
		x = 12,
		y = 12
	},
	[AssassinEnum.TowerPointIndex.LeftBottom] = {
		x = -12,
		y = -12
	},
	[AssassinEnum.TowerPointIndex.LeftTop] = {
		x = -12,
		y = 12
	}
}
AssassinEnum.BuildingType = {
	Church = 5,
	Guild = 4,
	Barrack = 3,
	Mansion = 1,
	Hospital = 2
}
AssassinEnum.BuildingType2IconCls = {
	[AssassinEnum.BuildingType.Mansion] = AssassinBuildingItemIcon,
	[AssassinEnum.BuildingType.Hospital] = AssassinBuildingItemIcon,
	[AssassinEnum.BuildingType.Barrack] = AssassinBuildingItemIcon,
	[AssassinEnum.BuildingType.Guild] = AssassinBuildingItemIcon,
	[AssassinEnum.BuildingType.Church] = AssassinBuildingItemIcon
}
AssassinEnum.NeedPlayOpenAnimBuildingCount = 4
AssassinEnum.BuildingDelayOpenAnim = 0.06
AssassinEnum.BuildingStatus = {
	Unlocked = 2,
	Locked = 1,
	LevelUp = 3
}
AssassinEnum.LibraryType = {
	Geology = 2,
	Hero = 1,
	Culture = 3,
	Video = 4
}
AssassinEnum.LibraryType2LangId = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_type_Hero_1",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_type_Geology",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_type_Culture",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Video)] = "assassinlibrary_type_Video",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_type_Hero_2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_type_Geology",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_type_Culture",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Video)] = "assassinlibrary_type_Video"
}
AssassinEnum.LibraryStatus = {
	New = 2,
	Locked = 1,
	Unlocked = 3
}
AssassinEnum.LibraryInfoViewTabId = 2
AssassinEnum.LibraryType2TabViewId = {
	[AssassinEnum.LibraryType.Hero] = 1,
	[AssassinEnum.LibraryType.Geology] = 2,
	[AssassinEnum.LibraryType.Culture] = 2,
	[AssassinEnum.LibraryType.Video] = 3
}
AssassinEnum.LibrarySubItemTweenDuration = 0.03
AssassinEnum.LibraryReddotStyle = RedDotEnum.Style.Green
AssassinEnum.LibraryToastPath = "ui/viewres/sp01/assassin2/assassinlibrarytoastitem.prefab"
AssassinEnum.CurrencyToolPrefabPath = "ui/viewres/sp01/assassin2/assassincurrencyitem.prefab"
AssassinEnum.LibraryCategoryCameraParams = {
	perspFOV = 35,
	cameraPos = Vector3(0, 0, -18.5)
}
AssassinEnum.ActId2LibraryInfoBgName = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_aitemempty",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_citembg",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_citembg",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Video)] = "assassinlibrary_bitemempty",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_aitemempty2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_citembg2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_citembg2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Video)] = "assassinlibrary_bitemempty2"
}
AssassinEnum.ActId2LibraryCategoryIconName = {
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Outside, AssassinEnum.LibraryType.Video)] = "assassinlibrary_leftlisticon",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Hero)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Geology)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Culture)] = "assassinlibrary_leftlisticon2",
	[AssassinHelper.multipleKeys2OneKey(VersionActivity2_9Enum.ActivityId.Dungeon2, AssassinEnum.LibraryType.Video)] = "assassinlibrary_leftlisticon2"
}

return AssassinEnum
