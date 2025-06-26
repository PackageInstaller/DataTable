-- chunkname: @IQIGame\\Definition\\Constant.lua

Constant = {}
Constant.Unity = {
	SortingOrderMaxValue = 32767,
	SortingOrderMinValue = -32768
}
Constant.LoginConst = {
	CodeRegisterUrl = "{0}/login/user_code_reg/",
	GetNoticeContentUrl = "{0}/login/get_notice_content/",
	GetDistricts = "{0}/login/get_districts",
	RegisterUrl = "{0}/login/user_reg/",
	ActiveAccountUrl = "{0}/login/user_activation/",
	ServerParamUrl = "{0}/login/get_serverParam/",
	NoticeUrl = "{0}/login/get_notice/",
	GuestAccountUrl = "{0}/login/get_guest_account/",
	FBQuickJumpKey = "facebookTZ",
	TempPayServerCallBack = "{0}/pay/TestPay/",
	PayServerCallBack = "{0}/pay/kuaiShouPay/",
	SensitiveFilterUrl = "https://gamecloud-api.gamed.kuaishou.com/game/sensitive/filter",
	QucikJumpKey = "syzz20220829test",
	LoadHtmlUrl = "{0}/loadhtml?",
	PaySignUrl = "{0}/login/create_recharge_order",
	LoginUrl = "{0}/login/user_login/"
}
Constant.DisconnectionType = {
	LOGIN = 1,
	UPDATE = 2,
	SERVER = 0
}
Constant.UILayer = {
	UI = "UI",
	AboveAll = "AboveAll",
	Top = "Top",
	DefaultUI = "DefaultUI",
	Mid = "Mid",
	Bottom = "Bottom",
	Tooltip = "Tooltip"
}
Constant.GamoObjectLayer = {
	StoryNpc = 23,
	MainCityInteraction = 26
}
Constant.SceneState = {
	StorySceneState = "StorySceneState",
	LoginSceneState = "LoginSceneState",
	BattleSceneState = "BattleSceneState",
	LotterySceneState = "LotterySceneState",
	MainCitySceneState = "MainCitySceneState"
}
Constant.PlayerPrefsConst = {
	AgreeProtocol = "_agree_protocol",
	MaintainAutoBattleSwitch = "MaintainAutoBattleSwitch",
	Opaquedownsampling = "Opaquedownsampling",
	TargetFrameRate = "TargetFrameRate",
	UserSettingMessageMainSwitch = "_Setting_Message_Main_Switch",
	UserSoundVolume = "_sound_volume",
	PostProcessing = "PostProcessing",
	EquipSkinTogetherSwitch = "EquipSkinTogetherSwitch",
	UserLoginBG = "_login_BG",
	HadConfirmEquipSkinMode = "HadConfirmEquipSkinMode",
	UrpLevel = "UrpLevel",
	LoginLastClickTime = "_login_lastclicktime",
	BattleSpeed = "BattleSpeed",
	FormationHeroFirstRecord = "FormationHeroFirstRecord",
	Key_Change_To_Test_Pack = "Key_Change_To_Test_Pack",
	WaterEffect = "WaterEffect",
	BattleUnitAITypeRecord = "BattleUnitAITypeRecord",
	HeroNewTagRecord = "HeroNewTagRecord",
	autoDialogueStateIndex = "autoDialogueStateIndex",
	LastLoginSeverID = "_LastLoginSeverID",
	LoginClickCount = "_login_clickcount",
	PowerSavingSate = "_PowerSavingSate",
	Password = "_login_password_",
	Scattering = "Scattering",
	MASS = "MASS",
	MazeDiffSelectIndex = "MazeDiffSelectIndex",
	UserSettingUltimateAnimationSate = "_Setting_Ultimate_Animation_State",
	SimpleGuideRecord = "SimpleGuideRecord",
	PersonalActive = "_PersonalActive",
	UserCvVolume = "_cv_volume",
	LimitedTimeGiftPop = "LimitedTimeGiftPop",
	HideUIControl = "HideUIControl",
	StoryGMFight = "StoryGMFight",
	Bloom = "Bloom",
	ChallengeTipData = "ChallengeTipData",
	PlayerPosShow = "PlayerPosShow",
	UserAllAudioVolume = "_all_audio_volume",
	UserSettingMessageChildSwitch = "_Setting_Message_Child_Switch",
	LamplighNum = "LamplighNum",
	CVContinuous = "CVContinuous",
	RoleDisplayRandomState = "RoleDisplayRandomState",
	Notice_IsNew = "_Notice_IsNew",
	MazeLastRoomCid = "MazeLastRoomCid",
	MaintainBattleSpeedSwitch = "MaintainBattleSpeedSwitch",
	GradingMode = "GradingMode",
	StoryMultipleSpeed = "StoryMultipleSpeed",
	SelectAccountIndex = "_login_accountindex",
	RoleNum = "RoleNum",
	UserName = "_login_user_name_",
	MazeUIPlayDialogue = "MazeUIPlayDialogue",
	_gmDebug = "_gmDebug",
	SSAO = "SSAO",
	OpenStorySecondSound = "OpenStorySecondSound",
	UserMusicVolume = "_music_volume",
	OpenSecondSound = "OpenSecondSound",
	GradingModeValue = "GradingModeValue",
	AffinityMsgGroupInfo = "AffinityMsgGroupInfo",
	AutoBattle = "AutoBattle",
	PayActiveRecordData = "PayActiveRecordData",
	RoleInvertedImage = "RoleInvertedImage",
	Depthoffield = "Depthoffield"
}
Constant.ActivityID = {
	StrengthActivity = 60001001,
	AccumulateRechargeActivity_3 = 60001103,
	Novice_7_SIGN = 60001002,
	Novice_7_TASK = 60001004,
	RECHARGEREBATE = 60002101,
	BattleActivity = 60006001,
	AccumulateRechargeActivity_2 = 60001102,
	OpenServerSignActivity = 60001005,
	MainLinePassActivity = 60002004,
	DailyDupStage = 1,
	LevelPassActivity = 60002003,
	MayDaySignActivity = 60001008,
	Pass = 60002002,
	AccumulateRechargeActivity_1 = 60001101,
	NOVICE_7_GRADE = 60001003
}
Constant.ActivityType = {
	ActivityType_MainLine = 19,
	ActivityType_Questionnaire = 15,
	ActivityType_SummerSign = 23,
	ActivityType_Ghost = 24,
	ActivityType_DupMultiple_12 = 12,
	ActivityType_GhostBoss = 25,
	ActivityType_Maze = 13,
	ActivityType_GhostGame = 26,
	ActivityType_DiceGame = 20,
	ActivityType_LevelPass = 18,
	ActivityType_ChallengeWorldBoss = 27,
	ActivityType_Normal = 2,
	ActivityType_Summer = 22,
	ActivityType_DupMultiple_11 = 11
}
Constant.Notice = {
	BlankOneBtnAlertNoticeID = 21040007,
	BlankRollingNoticeID = 21040006,
	BlankTwoBtnAlertNoticeID = 21040008,
	BlankFloatNoticeID = 21040005
}
Constant.UITransitionEffectType = {
	OpenClose = 1,
	Open = 3,
	Close = 2,
	None = 0
}
Constant.Number = {
	IntMinValue = -2147483648,
	IntMaxValue = 2147483647
}
Constant.SoundGroup = {
	CHARACTERVOICE = "CHARACTERVOICE",
	ENVIRONMENT = "ENVIRONMENT",
	CHARACTER = "CHARACTER",
	UI = "UI",
	BGM = "BGM"
}
Constant.DepotType = {
	Skill = 4,
	Equip = 3,
	Item = 2,
	Hero = 5
}
Constant.DropItemTag = {
	Multiple = 5,
	Extra = 2,
	Random = 4,
	FirstPass = 3,
	New = 1,
	None = 0
}
Constant.ItemType = {
	Skill = 4,
	Equip = 3,
	AchievementItem = 18,
	EquipSuitPreview = 19,
	HighPass = 10,
	HeroDebris = 5,
	MazeItem = 22,
	Currency = 1,
	SuperPass = 11,
	Item = 0,
	Hero = 2,
	Skin = 7,
	Gift = 6
}
Constant.ItemUseType = {
	ManualUse = 2,
	CannotUse = 3,
	AutoUse = 1
}
Constant.ItemSubType = {
	None = 0,
	[Constant.ItemType.Currency] = {
		MazeIntegral = 5,
		Currency = 0
	},
	[Constant.ItemType.Item] = {
		EquipUpgradeMat = 7,
		FavorGift = 3,
		MazeGem = 9,
		HeroUpgradeMat = 6,
		SkillUpgradeMat = 8,
		LifeCore = 2,
		SkillRefineMat = 13
	},
	[Constant.ItemType.HeroDebris] = {
		Other = 2,
		Hero = 1
	},
	[Constant.ItemType.Gift] = {
		NonSelection = 1,
		Skin = 3,
		Random = 4,
		SubGift = 5,
		Selection = 2
	},
	[Constant.ItemType.AchievementItem] = {
		BigIcon = 3,
		SmallIcon = 1,
		MiddleIcon = 2
	},
	[Constant.ItemType.Skin] = {
		Normal = 1
	}
}
Constant.ItemHideType = {
	All = 1
}
Constant.Item = {
	USE_AREA_MAZE = 2,
	USE_AREA_NONE = 0,
	USE_AREA_LEAVE_MAZE = 3,
	USE_AREA_CITY = 1
}
Constant.ActionType = {
	UnlockOperaAction = 11,
	UnlockHeroAction = 4,
	SecensAction = 17,
	ActiveHeroDeedAction = 16,
	MailAction = 18,
	AddPlayerExpAction = 2,
	UnlockTaskAction = 9,
	PassExpAction = 20,
	UnlockPassAction = 8,
	UseItemAction = 10,
	ActiveHeroVoviceAction = 15,
	ActiveMonthAction = 12,
	AddEquipExpAction = 7,
	ActiveSkinAction = 14,
	FavorabilityExpAction = 13,
	UnlockFunc = 5,
	AddHeroExpAction = 3,
	AddItemAction = 1,
	AddSkillExpAction = 6
}
Constant.LotteryType = {
	Novice = 1,
	Hero = 3,
	Skill = 4,
	Normal = 2
}
Constant.LotteryMovieType = {
	SSR = 2,
	FirstGetHero = 3,
	Normal = 1
}
Constant.GuideConditionConstant = {
	CheckPlayerLv = "CheckPlayerLv",
	CheckChapterNoFinished = "CheckChapterNoFinished",
	CheckGuideNoFinished = "CheckGuideNoFinished",
	CheckChapterFinished = "CheckChapterFinished",
	CheckDate = "CheckDate",
	CheckTaskState = "CheckTaskState",
	CheckPlayerInRoom = "CheckPlayerInRoom",
	CheckGuideFinished = "CheckGuideFinished",
	CheckActiveOpen = "CheckActiveOpen",
	CheckMonsterTeamID = "CheckMonsterTeamID"
}
Constant.ConditionConstant = {
	SUB_TYPE_HaveItem = 25,
	SUB_TYPE_FINISH_QUEST = 3,
	SUB_TYPE_UNLOCKMAP = 5,
	CHECK_CURRENT_RPG_MAIN_TASK = 40,
	SUB_TYPE_PurchasedItem = 24,
	LABYRINTH_BUFF_POLL_ELEMENT = 41,
	SUB_TYPE_ActivityPassLv = 20,
	Maze_Explore_Condition = 27,
	SUB_TYPE_MonthCardDayRemain = 22,
	Maze_Special_Event_Condition = 29,
	Maze_Talent_Level_Condition = 31,
	SUB_TYPE_PASS_LEVEL = 2,
	SUB_TYPE_TALENT = 6,
	SUB_TYPE_FINISH_OPENFUNC = 4,
	Favor = 8,
	LABYRINTH_BUFF_POLL_FORCES = 44,
	Maze_Event_Condition = 28,
	LABYRINTH_BUFF_POLL_EVENT = 45,
	Check_AreaHasTriggerAction = 51,
	Maze_Kill_Monster_Type = 34,
	LABYRINTH_MAP = 48,
	ShopLevel = 11,
	LABYRINTH_WEA = 49,
	LABYRINTH_TAKE = 50,
	SUB_TYPE_HAS_ITEM = 2,
	LABYRINTH_SEED = 54,
	TYPE_FAIL = 0,
	Check_Target_ActionCount = 55,
	LABYRINTH_KILL_MONSTER = 47,
	SUB_TYPE_PLAYER_ATT_LV = 1,
	Check_RoomHasPlot = 56,
	SUB_TYPE_HASHERO = 7,
	SUB_TYPE_TASK_EXIST = 19,
	Check_TaskPickUp = 57,
	Check_Time = 59,
	Maze_Clearance_Number = 32,
	CHECK_RUNNING_TASK_TYPE = 53,
	TYPE_ITEM = 2,
	SUB_TYPE_Activity_State = 26,
	Maze_Talent_Condition = 30,
	SUB_TYPE_ITEM_ID = 1,
	LABYRINTH_EVENT_COUNT = 46,
	CURRENT_FIGHT = 60,
	SUB_TYPE_ACTIVITY_OPEN = 18,
	Maze_Senro_Level_Condition = 37,
	TRIGGER_MAP_ACTION = 38,
	Check_TaskState = 58,
	LABYRINTH_BUFF_POLL_PROFESSION = 42,
	Check_RegularState = 52,
	LABYRINTH_BUFF_POLL_SEX = 43,
	TYPE_PLAYER_ATT = 1,
	CHECK_TIME_SPAN = 39
}
Constant.FriendType = {
	TYPE_FRIEND = 1,
	TYPE_MY_APPLICATION = 5,
	TYPE_MUTE = 4,
	TYPE_STRANGER = 3,
	TYPE_APPLICATION = 2
}
Constant.MailType = {
	Special = 2,
	TypeSystem = 1
}
Constant.SkillType = {
	TYPE_ULTIMATE = 2,
	TYPE_PROFESSION = 5,
	TYPE_PASSIVE = 3,
	TYPE_NORMAL = 1,
	TYPE_LORE = 4,
	TYPE_DISPLACEMENT = 13
}
Constant.DIYSkillEquipPos = {
	POS_1 = 10,
	POS_3 = 12,
	POS_2 = 11
}
Constant.DIYSkillPosMapping = {
	Constant.DIYSkillEquipPos.POS_1,
	Constant.DIYSkillEquipPos.POS_2,
	Constant.DIYSkillEquipPos.POS_3
}
Constant.DIYSkillDisplayAttrTable = {
	41,
	42,
	43
}
Constant.ElementType = {
	ELEMENT_TYPE_WIND = 1,
	ELEMENT_TYPE_NONE_2 = 12,
	ELEMENT_TYPE_WATER = 4,
	ELEMENT_TYPE_NONE_1 = 11,
	ELEMENT_TYPE_NONE_4 = 14,
	ELEMENT_TYPE_NONE_3 = 13,
	ELEMENT_TYPE_FIRE = 2,
	ELEMENT_TYPE_THUNDER = 3,
	ELEMENT_TYPE_PHYSICS = 0
}
Constant.DamageType = {
	TYPE_DMG_DOT = 4,
	TYPE_HEAL_DOT = 5,
	TYPE_DMG = 1,
	TYPE_HEAL = 3,
	TYPE_FIX_HEAL = 6,
	TYPE_NONE = 0,
	TYPE_FIX_DMG = 2
}
Constant.SkillChangeType = {
	TYPE_CHANGE_COST = 16,
	TYPE_CHANGE_SKILL_CD = 19,
	TYPE_CHANGE_AP = 17,
	TYPE_ADD_PABLITY = 100
}
Constant.GuideTriggerType = {
	SceneTrigger = 4,
	GuideFinish = 2,
	CloseUI = 5,
	CustomTrigger = 3,
	OpenUI = 1
}
Constant.MapType = {
	TYPE_VOLCANO = 1,
	TYPE_SWAMP = 2,
	TYPE_NORMAL = 0
}
Constant.ChapterPassType = {
	TYPE_Favor = 9,
	TYPE_SummerActivity = 13,
	TYPE_RANDOMDAILY = 8,
	TYPE_BattleActivity = 11,
	Type_RPGHunt = 18,
	TYPE_Challenge = 12,
	TYPE_Ghost = 14,
	TYPE_Maze = 10,
	TYPE_STORY_FIGHT = 5,
	Type_ChallengeWorldBoss = 17,
	TYPE_StoryGuide = 0,
	TYPE_EQUIP = 3,
	TYPE_CLIMB_TOWER = 6,
	TYPE_BOSS = 4,
	Type_GhostBoss = 16,
	TYPE_RESOURCES = 2,
	TYPE_MAINLINE = 1,
	TYPE_StoryReview = 98,
	TYPE_OTHER = 99,
	TYPE_BRANCH = 7
}
Constant.DupTagID = {
	BaseResource = 2,
	Equip = 1,
	MainLine = 4,
	MazeDup = 5,
	RoleDevelopment = 3
}
Constant.ChapterPassEnemyType = {
	TYPE_NORMAL = 1,
	TYPE_BOSS = 2
}
Constant.EaseElement = {
	EaseIce = 5,
	EaseFire = 2,
	EaseMine = 3,
	EaseWater = 4,
	EaseWind = 1
}
Constant.EaseProfession = {
	EaseImplement = 2,
	EaseConjuring = 1,
	EaseRune = 4,
	EaseSpeech = 3,
	EaseCurtain = 5,
	EaseProvide = 6
}
Constant.EaseInfluence = {
	EaseInfluence_2 = 2,
	EaseInfluence_1 = 1,
	EaseInfluence_5 = 5,
	EaseInfluence_4 = 4,
	EaseInfluence_3 = 3,
	EaseInfluence_6 = 6
}
Constant.SkillConditionType = {
	PROFRESSION = 2,
	POWER = 3,
	ELEMENT = 1
}
Constant.PoolObjName = {
	MainUIRole = "MainUIRole",
	BattleDamageNumber = "BattleDamageNumber",
	Formation = "Formation",
	FormatRoleUIRole = "FormatRoleUIRole",
	PlotScene = "PlotScene"
}
Constant.TaskType = {
	AchievementPlayerParent = 200,
	AchievementStory = 301,
	Maze = 10,
	Other = 5,
	DayActivity = 7,
	Favorability = 9,
	AchievementFightParent = 400,
	Day = 3,
	AchievementRoleParent = 500,
	Week = 4,
	WeekActivity = 8,
	Branch = 2,
	Trunk = 1,
	Copy = 6,
	AchievementRole = 501,
	AchievementPlayer = 201,
	AchievementStoryParent = 300,
	AchievementFight = 401
}
Constant.MainTaskType = {
	GhostBoss = 101,
	Novice_7_DAY_SIGN = 6,
	Weekly = 3,
	Community = 9,
	RPGBranch = 1002,
	Recharge = 11,
	RPGMain = 1001,
	Achievement = 2001,
	Novice_7_DAY_TASK = 8,
	Main = 1,
	Pass = 5,
	Daily = 2,
	Novice_7_DAY_GRADE = 7
}
Constant.ExtendTaskType = {
	Main_Hidden = {
		0
	},
	Main_Main = {
		1
	},
	Main_Branch = {
		2
	},
	Main_Favorability = {
		3
	},
	Daily_Mission = {
		1
	},
	Daily_Activity = {
		2
	},
	Weekly_Mission = {
		1
	},
	Weekly_Activity = {
		2
	},
	Achievement = {
		0
	},
	AchievementEquip = {
		2
	},
	AchievementRole = {
		1
	},
	AchievementFight = {
		4
	},
	AchievementStory = {
		3
	},
	Pass_NormalMission = {
		1,
		1
	},
	Pass_DailyMission = {
		1,
		2
	},
	Pass_WeeklyMission = {
		1,
		3
	},
	Pass_AllLevelReward = {
		2
	},
	Pass_NormalLevelReward = {
		2,
		1
	},
	Pass_PaidLevelReward = {
		2,
		2
	},
	Pass_ApexLevelReward = {
		2,
		3
	},
	AchievementParent = {
		-1,
		0
	},
	Recharge_Frist = {
		1
	},
	Recharge_LevelPassNormal = {
		2,
		1
	},
	Recharge_LevelPassHigh = {
		2,
		2
	},
	Recharge_MainLinePassNormal = {
		3,
		1
	},
	Recharge_MainLinePassHigh = {
		3,
		2
	},
	DiceGame = {
		5
	},
	SummerSign = {
		6,
		1
	},
	SummerActivityTask = {
		6,
		4
	},
	RPGMain_Main = {
		1
	},
	RPGMain_Branch = {
		2
	}
}
Constant.TaskStatus = {
	hadGot = 3,
	doing = 1,
	hasDone = 2
}
Constant.ShopItemType = {
	NoLimit = 1,
	CirculationRefresh = 3,
	NoTimeLimit = 2,
	TimerLimit = 4
}
Constant.ShopRefreshType = {
	Day = 1,
	Weekly = 2,
	Month = 3,
	Timer = 4,
	None = 0
}
Constant.ShopBuyLimitType = {
	Limit = 1,
	Unlimited = 2
}
Constant.ShopSellType = {
	SellOut = 2,
	NonSellOut = 1
}
Constant.ShopType = {
	Energy = 50100210,
	Diamond = 50100200,
	Pass = 50100220,
	Recommend = {
		Type = -1
	},
	LongTime = {
		Type = 0
	},
	RoleSkin = {
		Type = 1
	},
	GiftBag = {
		Type = 2
	},
	Token = {
		Type = 3
	},
	SoulStone = {
		Type = 4
	},
	MonthCard = {
		Type = 5
	},
	PassShop = {
		Type = 6
	},
	RechargeGift = {
		Type = 7
	},
	LimitedTimeGift = {
		LimtedTime = 50100030,
		Type = 11
	},
	MazeShop = {
		ShopCid = 50102000,
		Type = 10
	},
	SummerShop = {
		Type = 12
	},
	GhostShop = {
		Type = 13
	},
	HuangQuanShi = {
		Type = 14
	}
}
Constant.ShopEnterType = {
	SummerActivity = 2,
	Normal = 1
}
Constant.ShopShowType = {
	Recommend = 2,
	LongTrem = 3,
	Normal = 1
}
Constant.BuyShopType = {
	Item = 2,
	Rmb = 1
}
Constant.ShopOpenType = {
	FreeShop = 2,
	PayShop = 1
}
Constant.ShopScrollType = {
	Recharge = 4,
	GiftScroll = 1,
	Skin = 3,
	Resource = 2
}
Constant.MonthCardCfgID = {
	DayTipsID = 1400044,
	GetTipsID = 1400045,
	DayReward = 63,
	HelpTipsID = 1010000,
	BuyReward = 36
}
Constant.MoneyType = {
	FreeDiamand = 2,
	Gold = 1,
	WeekActivity = 6,
	DayActivity = 5,
	PayDiamand = 3,
	BToken = 8,
	AToken = 7,
	Power = 4
}
Constant.PlotSceneChangeType = {
	ContinueNextScene = 2,
	WaitPlay = 0,
	EndTalk = 1,
	ContinueCurSceneAndDelePlot = 4,
	EnterBattleScenes = 3,
	ContinueCurSceneAndNoDelePlot = 7
}
Constant.PlotSceneTriggeredType = {
	TriggeredShowThreadUI = 2,
	Triggered = 1,
	BehaviorTreeSend = 0
}
Constant.PlotSceneAnnexType = {
	NilAnnex = 2,
	Spline = 1,
	Scenes = 3
}
Constant.PlotSceneType = {
	Talk = 1,
	Battle = 2
}
Constant.TopMoneyType = {
	MazeUI = 501,
	ShopUIRolePerformance = 12,
	SkillBreachUI = 6,
	MazeShopUI = 504,
	ShopUIRecommend = 17,
	LotteryUI = 15,
	RoleUpgradeUI = 3,
	RoleDevelopmentUI = 3,
	DiySkillStrengthUI = 9,
	EquipDetailsUI = 8,
	ShopUIToken = 14,
	SkillReplaceUI = 7,
	GameLevelUI = 2,
	ShopUISoulStone = 11,
	HeroSkinUI = 27,
	WorldHunt = 29,
	HomeLandMissionUI = 203,
	SkillStrengthenUI = 5,
	WarehouseUI = 10,
	ActivityShop = 402,
	ActivityShop_New = 403,
	MainPhoneUI = 28,
	MainFakeUI = 100,
	EquipChoosePanelUI = 16,
	MainUI = 1,
	MazeBattleUI = 502,
	MazeSenroUI = 503,
	RoleBreachUI = 4,
	ShopUIGiftBag = 13,
	SummerActivityStage = 401
}
Constant.ItemCid = {
	MAZE_CREDITS = 20,
	MAZE_TICKET = 21,
	TALENT = 15,
	NORMAL_MONEY = 3,
	Exp = 5,
	MAZE_MONEY = 22,
	MAZE_TALENT_POINT = 23,
	HomePower = 16,
	STRENGTH = 11,
	NoviceActivity = 105,
	WeeklyActivity = 102,
	DayActivity = 101,
	MAZE_POWER = 24,
	TOLL_MONEY = 2,
	GOLD = 4
}
Constant.Function = {
	openMailUI = 109,
	openConvertUI = 115,
	openChapterUI = 112,
	openActivityPassUI = 116,
	openNoviceSignUI = 113,
	openBuyEnergyUI = 114,
	openWarehouseUI = 108,
	openLotteryUI = 105,
	EnterRoom = 122,
	openHomeLandUI = 107,
	openNoviceTaskUI = 118,
	openActivityListUI = 120,
	SummerActivity = 121,
	openFriendUI = 103,
	openUserInfoUI = 106,
	openComposeUI = 119,
	openActivityPassBuyHightViewUI = 124,
	openWarlockChooseUI = 111,
	openNoviceGradeUI = 117,
	openShopFreeUI = 125,
	openShopUI = 104,
	openGameLevel = 102,
	openTowerUI = 123,
	openFormationUI = 110,
	openRoleDevelopmentUI = 101
}
Constant.Other = {
	BreakLvWeight = 30
}
Constant.FightResult = {
	ATTACKER_WIN = 1,
	ALL_FAIL = 4,
	DEFENDER_WIN = 2,
	EXIT_FORMATION = 6,
	GIVE_UP = 5,
	TIME_OUT = 3,
	NOT_END = 0
}
Constant.BattleSPStatus = {
	SellOut = 5,
	Dead = 4
}
Constant.BattleFightStatus = {
	SEAL_CORE_2 = 3,
	CD_STOP = 10,
	IMMUNITY_THUNDER = 23,
	MUST_CRIT = 16,
	IMMUNITY_ICE = 21,
	MUST_HIT = 15,
	SEAL_ULTIMATE = 4,
	SEAL_BEAT_BACK = 6,
	SLEEP = 34,
	IMMUNITY_POISON = 24,
	CHARM = 31,
	DIZZY = 33,
	IMMUNITY_DARK = 26,
	TYRANTS = 35,
	MOVE_LIMIT = 36,
	CAN_NOT_HIT = 19,
	ENERGY_LIMIT = 12,
	SEAL_HEAL = 32,
	IMMUNITY_LIGHT = 25,
	CAN_NOT_DODGE = 17,
	CAN_NOT_BLOCK = 18,
	IMMUNITY_FIRE = 22,
	STEALTH = 9,
	CAN_NOT_CRIT = 20,
	SEAL_NORMAL = 1,
	SEAL_STAND_BY = 7,
	MUST_DODGE = 13,
	CHAOS = 30,
	PLAY_DEAD = 28,
	DMG_LINK = 11,
	STATUS_NUM = 37,
	SEAL_DERIVATION = 8,
	SEAL_CORE = 2,
	TAUNT = 27,
	MUST_BLOCK = 14,
	AP_LIMIT = 29,
	SEAL_DEAD_RATTLE = 5,
	NONE = 0
}
Constant.BuffConfigIDToEnergy2 = 22210
Constant.BattleProfession = {
	PO = 3,
	SHI = 2,
	YU = 1,
	ZHOU = 4
}
Constant.SkillFunction = {
	TYPE_DMG_DOT = 4,
	TYPE_HEAL_DOT = 5,
	TYPE_DMG = 1,
	TYPE_HEAL = 3,
	TYPE_FIX_HEAL = 6,
	TYPE_NONE = 0,
	TYPE_FIX_DMG = 2
}
Constant.SkillEffectMountType = {
	TARGET_ROW = 3,
	SELF = 1,
	TARGET_UNATTACHED = 12,
	SCENE = 4,
	SELF_UNATTACHED = 11,
	UI = 5,
	TARGET = 2
}
Constant.MountPoint = {
	PointSkillEffect01 = 10500,
	PointSkillEffect02 = 10501,
	PointSkillFlight = 40001,
	PointSkillEffect03 = 10502,
	PointText = 20011,
	PointSkillEffect04 = 10503,
	PointSkill = 10200,
	PointSkillEffect05 = 10504,
	PointSkillEffect = 40002,
	PointBlood = 10202,
	PointHead = 10203,
	PointSceneEffect = 40003,
	PointRoot = 50000,
	PointBuff = 10206,
	PointBottom = 10204,
	PointChest = 20010,
	PointHit = 10201,
	PointScene01 = 30000,
	PointScene02 = 30001
}
Constant.UpdateScope = {
	BattleTile = 1,
	BattleUnit = 0,
	BattleTroopUnit = 2
}
Constant.UpdateType = {
	CHANGE_MAX_AP = 22,
	UPDATE_WEAK_NUM_OLD = 20,
	UPDATE_SHIELD = 10,
	REMOVE_STATUS = 8,
	CHANGE_COMMON_CD = 32,
	UPDATE_WAKE_NUM = 37,
	UPDATE_WEAK_MAX_NUM = 36,
	CHANGE_POS = 24,
	REMOVE_BUFF = 5,
	SUMMON_REMOVE = 28,
	BUFF_IMMUNE = 15,
	UPDATE_WEAK_MAX_NUM_OLD = 19,
	ADD_SP_STATUS = 9,
	CHANE_SIZE = 33,
	AI_TYPE_CHANGE = 40,
	REMOVE_WEAK_TYPE = 39,
	SUMMON_ADD = 27,
	UPDATE_WAKE_STATUS = 38,
	UPDATE_MAX_HP = 2,
	REMOVE_SKILL = 42,
	SEAL_SKILL = 29,
	CHANGE_SKILL_ENERGY = 26,
	ADD_SKILL = 43,
	CHANGE_SKILL_TARGET = 30,
	CHANGE_PREVIEW_SKILL = 45,
	CHANGE_SKILL_AP = 44,
	UPDATE_SKIN_ICON = 41,
	UPDATE_SPEED = 17,
	CHANGE_SKILL_CD = 6,
	CHANGE_SKILL_COUNT = 25,
	UPDATE_DMG_RECORDS = 14,
	CHANGE_MAX_ENERGY = 23,
	ADD_STATUS = 7,
	UPDATE_BUFF = 4,
	CHANGE_TILE_TERRAIN = 31,
	CHANGE_ENERGY = 3,
	ADD_WEAK_TYPE = 35,
	TRIGGER_BUFF = 12,
	CHANGE_AP = 21,
	UPDATE_WEAK_TYPE_OLD = 18,
	CHANGE_HP = 1,
	BUFF_EFFECT_IMMUNE = 16,
	SHOW_DIALOG = 34
}
Constant.ControlType = {
	FREEZE = 2,
	POISON = 11,
	DIZZY = 1,
	NONE = 0
}
Constant.BattleDamageShowType = {
	Critical = "Critical",
	Normal = "Normal",
	Element = "Element",
	Indirect = "Indirect",
	Dot = "Dot",
	Shield = "Shield",
	Total = "Total",
	NONE = "NONE"
}
Constant.BattleDamageTMPMaterialID = {
	Wind = 205,
	ShieldReduce = 206,
	Physical = 200,
	Others = 208,
	DOT = 207,
	RANGE_MAX = 208,
	RANGE_MIN = 200,
	Cure = 201,
	Water = 202,
	Fire = 203,
	Thunder = 204
}
Constant.E_RedDotPath = {
	Archives_Achievement_Hero = 81002,
	MobilePhone_NoviceActivity = 40001,
	WelfareList = 112000,
	Warehouse = 50001,
	Task = 10001,
	Archives = 80000,
	Task_Achieve = 10006,
	Community = 50003,
	MobilePhone_NoviceActivity_TaskTab = 40003,
	DiceGame = 120001,
	BattleActivity = 120002,
	PassActivity_TaskTab = 71000,
	LeftMenu_Friend_Application = 20003,
	LeftMenu_Friend = 20002,
	Warlock = 60001,
	NoviceSign = 112002,
	ActivityList = 111000,
	Shop_FreeItem = 101000,
	Task_Branch = 10003,
	LeftMenu = 20001,
	Warehouse_Character = 50002,
	BattleActivity_Chapter = 120003,
	BattleActivity_Chapter_Reward = 120004,
	BattleActivity_Chapter_Reward_List_Get = 120006,
	GhostActivityUI = 140004,
	Archives_Achievement_Player = 81001,
	MobilePhone = 1001,
	Archives_Achievement_Fight = 81003,
	Home_Mail = 30001,
	PassActivity_Normal = 71003,
	Task_Main = 10002,
	PassActivity_Daily = 71001,
	Archives_Achievement_Story = 81004,
	HomeLand_Task = 130002,
	PassActivity = 70000,
	MobilePhone_NoviceActivity_LevelRewardTab = 40004,
	PassActivity_Week = 71002,
	MobilePhone_NoviceActivity_SignInTab = 40002,
	BattleActivity_Chapter_Reward_List = 120005,
	HomeLand = 130001,
	PassActivity_RewardTab = 72000,
	FirstRecharge = 112001,
	Archives_Achievement = 81000,
	Task_Daily = 10004,
	Task_Weekly = 10005,
	MobilePhone_Questionnair = 30002
}
Constant.RedDotPerformanceType = {
	ShowOrHide = 1
}
Constant.ReportDataType = {
	LEVEL_UPGRADE = 4,
	CREATE_GAME_ROLE = 2,
	ENTER_GAME = 3,
	SELECT_GAME_SERVER = 1,
	EXIT_GAME = 5
}
Constant.ReportType = {
	LOGIN = 0,
	LEVEL = 2,
	CREATE = 1,
	EXIT = 3
}
Constant.ReportDataType = {
	LEVEL_UPGRADE = 3,
	CREATE_GAME_ROLE = 1,
	ENTER_GAME = 2,
	SELECT_GAME_SERVER = 0,
	EXIT_GAME = 4
}
Constant.ProtocolType = {
	ALLIN = "allin",
	PRIVACY = "privacy",
	POLICY = "policy",
	CHILD = "privacy_child"
}
Constant.passTaskStatus = {
	hadGot = 3,
	doing = 1,
	hasDone = 2
}
Constant.passTaskType = {
	level = 4,
	normal = 3,
	extra = 5,
	daily = 1,
	weekly = 2
}
Constant.passShopType = {
	pass = 6,
	passExp = 7
}
Constant.passShopCommodityTeamID = {
	Difference = 3,
	SuperPassShopCommodityID = 2,
	HighPassShopCommodityID = 1
}
Constant.passGiftAwardType = {
	High = 2,
	normal = 1
}
Constant.passWeeklyExpMaxID = 50
Constant.passExtraExpMaxID = 51
Constant.passCfgCycleID = 201
Constant.passCfgHelpTipsID = 1000000
Constant.UnlockType = {
	FUNC_HOME = 4,
	FUNC_LIMITTIME_STAGE = 21,
	FUNC_MAIL = 1,
	FUNC_WeekTask = 26,
	FUNC_DayTask = 25,
	FUNC_EQUIP_SYS = 23,
	FUNC_EQUIP_DUP = 6,
	FUNC_FRIEND = 2,
	FUNC_CHAPTER_EXPLORE = 19,
	FUNC_DRAW = 12,
	FUNC_QUESTIONNAIR = 29,
	FUNC_Branch = 34,
	FUNC_ChallengeWorldBoss = 35,
	FUNC_AchievementTask = 27,
	FUNC_REFRESH_MAIN = 22,
	FUNC_SmallPhone = 31,
	FUNC_SING = 10,
	FUNC_Affinity = 37,
	FUNC_DAILY_DUP = 7,
	FUNC_Close = 9999,
	FUNC_TASK = 11,
	FUNC_CDKEY = 14,
	FUNC_WorldMap = 32,
	FUNC_STORE = 9,
	FUNC_PLOT_DUP = 5,
	FUNC_CHAPTER_TOWER = 16,
	FUNC_PASS_CARD = 13,
	FUNC_STAR_RISE = 20,
	FUNC_CHAPTER_BOOS = 17,
	FUNC_Compound = 28,
	FUNC_CHAT = 3,
	FUNC_MAZE = 24,
	Saunter = 30,
	FUNC_GM_TOOL = 15,
	FUNC_Daily = 39,
	FUNC_MONTHCARD = 18
}
Constant.LockShowType = {
	isDefaultHide = 0,
	isDefaultShow = 1
}
Constant.FormationType = {
	FIXNPCANDBANMANUAL = 2,
	FIXNPCANDCANMANUAL = 3,
	UNLIMITED = 1
}
Constant.FormationGointoBattleType = {
	BAN = 0,
	NORMAL = 1
}
Constant.FormationOpenType = {
	Maze = 3,
	Normal = 1
}
Constant.StoryBattleResult = {
	Lose = 0,
	Win = 1
}
Constant.StoryCompleteReason = {
	QUIT_LEVEL = 2,
	BATTLE_LOSE = 1,
	COMPLETE_LEVEL = 0
}
Constant.CinemachineBlendDefinitionStyle = {
	Cut = 0,
	HardOut = 5,
	Linear = 6,
	HardIn = 4,
	EaseOut = 3,
	EaseIn = 2,
	Custom = 7,
	EaseInOut = 1
}
Constant.StoryCharacterType = {
	SceneObjectNPC = 3,
	RoleNPC = 2,
	Player = 1
}
Constant.StoryCharacterSoundType = {
	Run = 2,
	Walk = 1
}
Constant.DialogueReviewType = {
	Option = 2,
	Chat = 1
}
Constant.StoryCommunicationType = {
	Option = 2,
	Line = 3,
	Chat = 1
}
Constant.StoryType = {
	Maze = 2,
	Normal = 1
}
Constant.StoryMazeDirection = {
	Left = 3,
	Right = 4,
	Top = 1,
	Bottom = 2,
	Center = 5
}
Constant.MazeWarningDefine = {
	High = 3,
	Medium = 2,
	Low = 1
}
Constant.MazeEventDefine = {
	MeetMonster = 5,
	Box = 1,
	Boss = 3,
	Dialogue = 4,
	BoostMonster = 2
}
Constant.BehaviorGlobalDefine = {
	AbsMoveZ = "操纵杆Z方向移动绝对值",
	MemoryFilterDuration = "回忆滤镜动画时间",
	LoopMapDistance = "循环地图移动值",
	ThinkingFilterDuration = "思考滤镜动画时间",
	AbsMoveX = "操纵杆X方向移动绝对值",
	StoryMultipleSpeed = "剧情倍速速度",
	RegularFilterDuration = "律象之眼动画时间"
}
Constant.StoryVariableType = {
	String = IQIGame.Onigao.Game.VariableSetting.VariableType.String,
	Int = IQIGame.Onigao.Game.VariableSetting.VariableType.Int,
	Float = IQIGame.Onigao.Game.VariableSetting.VariableType.Float,
	Bool = IQIGame.Onigao.Game.VariableSetting.VariableType.Bool
}
Constant.StoryUI = {
	Return = 5,
	Regular = 4,
	MythButton = 7,
	ButtonCollection = 8,
	AutoDialogue = 9,
	SurveyTarget = 3,
	Joystick = 2,
	RegularEffect = 6,
	Puzzle = 1
}
Constant.StoryEventDataType = {
	Text = 1,
	Icon = 2,
	Image = 3
}
Constant.StoryInterActType = {
	Role = 1,
	Location = 2
}
Constant.StoryReviewType = {
	Continue = 0,
	Challenge = 3,
	Other = 2,
	Main = 1
}
Constant.PlayerSex = {
	WoMen = 1,
	Man = 0
}
Constant.StoryState = {
	Interact = 2,
	Normal = 1
}
Constant.StoryMazeNpcID = 0
Constant.StoryMazeRoomID = "StoryMazeRoomID"
Constant.StoryMazeMeetFight = "StoryMazeMeetFight"
Constant.StoryMazeEvent = "StoryMazeEvent"
Constant.StoryMazeArrivedRoom = "StoryMazeArrivedRoom"
Constant.StoryMazeInfo = "StoryMazeInfo"
Constant.MazeExploreProgress = "extension_maze_progress"
Constant.StoryEventData = "StoryEventData"
Constant.StoryMythData = "StoryMythData"
Constant.extension_maze_event = "extension_maze_event"
Constant.extension_maze_boss = "extension_maze_boss"
Constant.StoryNameIconShow = "NameIconShow"
Constant.DiscreteData = {
	StoryMultipleSpeedShowTime = 85,
	WorldMapRPGTime = 118,
	AchievementDisplayMaxCount = 68,
	ActivityPassBuyCommodityID = 58,
	StoryMultipleSpeedTime = 86,
	StorySkipConversationTime = 47,
	LOTTERYBUYITEM = 67,
	StoryChatBubbleCharacterTime = 84,
	PassActivityPriceDifferenceAward = 114,
	CurrencyNotEnough = 71,
	WorldMapRPGResetRoom = 119,
	TodayShoppingCount = 121,
	DialogTextTime = 120,
	RPGPlayerMoveSpeed = 124,
	RPGDailySpeakTime = 206,
	SKIN_ID = 20001,
	CurrencyNotEnoughNormal = 70,
	DialogueReviewMaxCount = 75,
	PassActivityHighAward = 112,
	CommunityTaskID = 10003,
	PassActivityCommodityID = 59,
	BOSS_COUNT = 111,
	MazeStageRefreshData = 200,
	MaxSoloInviteCount = 207,
	MazeMeetEnemyTime = 104,
	ActivityPassInfo = 53,
	BuyMonthCardNeedDayNum = 125,
	CommunityReward = 108,
	PassActivitySuperAward = 113
}
Constant.Resource = {
	LotteryQuality = 2003,
	TaskSystemUIRightBg = 1100039,
	RoleElement = 17001
}
Constant.NoticeType = {
	RightFloatTips = 7,
	FloatTips = 1,
	BoxDoubleButton = 5,
	AchievementNotice = 6,
	BoxSingleButton = 4
}
Constant.CluesGetType = {
	Add = 1,
	Refresh = 2
}
Constant.NoviceActivityDayIndexRange = {
	START = 1,
	END = 7
}
Constant.StoryScreenEffectType = {
	BlackAlphaIn = 7,
	WhiteInkIn = 5,
	BlackScreen = 3,
	BlackInkOut = 2,
	ThinkingFilter = 4,
	BlackInkIn = 1,
	WhiteInkOut = 6,
	StoryCutTo = 11,
	WhiteAlphaOut = 10,
	WhiteAlphaIn = 9,
	BlackAlphaOut = 8
}
Constant.StoryDialogueType = {
	Conversation = 0,
	IntroNarration = 1,
	StandPaint = 2
}
Constant.AchievementDisplayHasSelectType = {
	Has = 2,
	All = 1,
	NotHave = 3
}
Constant.AchievementDisplayIconSelectType = {
	All = 1,
	BigIcon = 2,
	MediumIcon = 3,
	SmallIcon = 4
}
Constant.LogType = {
	Story = false,
	Normal = true
}
Constant.SkinType = {
	SpineElementEntity = 2,
	StaticImage = 1
}
Constant.SkinImageType = {
	HeroResourcesShowImg = 8,
	AssistInFightingImg = 7,
	DynamicPrefab = 10,
	FriendHeadImg = 4,
	ShopShowImg = 13,
	HeroSmartHead = 5,
	HeroLotteryResources = 11,
	HeroSkillChangeHeadImg = 6,
	HeadIcon = 2,
	FormationShowImg = 9,
	DialogSpine = 14,
	HeroResourcesVerticalDraw = 1,
	HeroResourcesHead = 3,
	DetailsHeadIcon = 12
}
Constant.SkinState = {
	NotOwnAndCanNotGet = 4,
	OwnedAndNotEquipping = 2,
	OwnedAndEquipping = 1,
	NotOwnAndCanGet = 3,
	NONE = 0
}
Constant.StrengthType = {
	SkillBreach = 3,
	HeroUpgrade = 1,
	SkillUpgrade = 2,
	EquipUpgrade = 4
}
Constant.BGMSoundID = {
	EMPTY = 11100004
}
Constant.StoryOptionType = {
	Dialogue = 1,
	ClueTrigger = 2
}
Constant.MailTips = {
	SpaceNotEnough = 1,
	ExpiringSoon = 2,
	HasDelMail = 3
}
Constant.Equip = {
	ResourceID_Part = 1200113,
	Part = {
		Tong = 1,
		Hun = 6,
		Gu = 5,
		Chu = 3,
		Xing = 4,
		Mian = 2
	},
	SuitType = {
		Awaken = 2,
		Normal = 1
	}
}
Constant.MapStageType = {
	MainLine = 1,
	Equip = 4,
	BranchLine = 7,
	Challenge = 12,
	Explore = 2,
	Summer = 13,
	Favor = 9,
	Resource = 3,
	Tower = 6,
	Boss = 5,
	Daily = 8
}
Constant.WarehouseDepotType = {
	Role = 5,
	Equip = 3,
	Item = 2,
	Skill = 4
}
Constant.AdvantageType = {
	OneHero = 1,
	AllHero = 3,
	Element = 2
}
Constant.AttributeUIType = {
	HeroAttribute = 1,
	EquipAttribute = 2
}
Constant.SkillLimitType = {
	Profession = 1,
	Force = 3,
	Element = 2
}
Constant.TalentAttrType = {
	PHYSICAL_MAX_LIMIT = 1,
	EQUIP_UPGRADE_EXP_ADDITION = 3,
	PHYSICAL_RECOVER_COUNT = 7,
	PHYSICAL_RECOVER_TIME = 8,
	PLAYER_MAIL_LIMIT = 6,
	HERO_UPGRADE_GOLD_COST = 9,
	EQUIP_UPGRADE_GOLD_COST = 10,
	PLAYER_UPGRADE_EXP_ADDITION = 2,
	PLAYER_FIGHT_SPEED = 4,
	PLAYER_WAREHOUSE_LIMIT = 5
}
Constant.TalentEffectType = {
	CHANGE_DSP_REWARD = 3,
	CHANGE_PLAYER_ATTR = 1,
	CHANGE_DSP_PS_COST = 2,
	None = 0
}
Constant.ModuleTimerName = {
	DialogControlTimer = "DialogControlTimer",
	Lottery = "Lottery",
	BubbleDialogueTimer = "BubbleDialogueTimer",
	StandPaintDialogTimer = "StandPaintDialogTimer",
	Battle = "Battle",
	RoleDevelopmentPanel = "RoleDevelopmentPanel",
	SceneTransfer = "SceneTransfer",
	Home = "Home",
	MazeBattle = "MazeBattle"
}
Constant.HeroSoundType = {
	Interact = 1,
	Fight = 2
}
Constant.CombinationType = {
	HeroRecycle = 3,
	HeroCombination = 1,
	ItemTransform = 5,
	ItemCombination = 4
}
Constant.TransformUIFilterType = {
	LevelMaterial = 2,
	All = 1,
	SoulMaterial = 4,
	SkillMaterial = 3
}
Constant.TransformUIFilterItemType = {
	Soul = 0,
	Skill = 0,
	roleBreakTrough = 4
}
Constant.AssetUtilErrorCode = {
	RepeatLoad = 1
}
Constant.GetPanelType = {
	Maze = 3,
	Story = 2,
	ReturnMaterials = 4,
	Normal = 1
}
Constant.LoopMapCellType = {
	Converter = 5,
	End = 3,
	Block = 4,
	Light = 6,
	Start = 2,
	Normal = 1
}
Constant.LoopMapDirection = {
	Bottom = 3,
	Right = 2,
	Top = 1,
	Left = 4,
	Null = 5
}
Constant.EquipSortNormalValue = 0
Constant.CommonScreenType = {
	Role = 1,
	Equip = 2,
	Skill = 3
}
Constant.CommonScreenAllValueID = 0
Constant.EquipScreenType = {
	Part = 5,
	Quality = 2,
	SubProperty = 4,
	Suit = 1,
	MainProperty = 3
}
Constant.SkillScreenType = {
	ElementProperty = 3,
	Quality = 2,
	OpType = 1,
	PurifyLevel = 4
}
Constant.WarlockSortType = {
	Quality = 2,
	Level = 1,
	Favor = 3,
	Element = 4
}
Constant.EquipReplacePanelType = {
	DiySkill = 2,
	Equip = 1
}
Constant.TriggerEvent = {
	Facebook = 1
}
Constant.PushGiftTriggerUI = {
	UI_Main = {
		UIName = "MainUI",
		Type = 1
	},
	UI_Shop = {
		UIName = "ShopUI",
		Type = 2
	},
	UI_Development = {
		UIName = "RoleDevelopmentPanel",
		Type = 3
	},
	UI_ChapterStageMap = {
		UIName = "ChapterStageMapUI",
		Type = 4
	}
}
Constant.ActivityListTeamID = {
	Activity = 2,
	Welfare = 1,
	SummerActivity = 3,
	GhostActivity = 4
}
Constant.ActivityListCfgType = {
	GlobalChannelActivity = 666,
	NoviceSignActivityType = 108,
	FirstRechargeActivityType = 106,
	LotteryActivityType = 109,
	SummerSignActivityType = 110,
	SummerActivityType = 301,
	GhostActivity = 302,
	AccRechargeActivity = 888,
	LevelPassActivityType = 102,
	TreasureHuntActivity = 999,
	MainLinePassActivityType = 101,
	DiceGameActivityType = 107,
	StrengthActivityType = 103,
	DupMultipleActivityType = 104,
	BattleActivityType = 105
}
Constant.ActivityStageUI_stagePanelViewType = {
	reward = 2,
	stage = 1
}
Constant.ResourceStageUI_DupTagShowType = {
	BaseResource = 1,
	Equip = 4,
	Tower = 5,
	Boss = 3,
	RoleDevelopment = 2
}
Constant.HomeSceneActorType = {
	Article = 4,
	Player = 0,
	Npc = 3,
	WorkActor = 2,
	TranslateDoorActor = 1
}
Constant.HomePartType = {
	SceneUI = 1,
	TranslateDoor = 2
}
Constant.HomeUIControlType = {
	HomeLandDispTask = 3,
	UIChapterBtn = 1,
	DelayTaskBtn = 2,
	MainCityBanner = 5,
	SummerActivity = 6,
	Painting = 7,
	CommonUIBtn = 99,
	UpGradeBtn = 4
}
Constant.HomeLandDispTaskType = {
	Ready = 1,
	Running = 2,
	Receive = 4,
	Finish = 3
}
Constant.HomeLandDispTaskAdvType = {
	Level = 3,
	Profession = 1,
	Elemental = 2
}
Constant.CVActionType = {
	FightBeLightAttack = 13,
	RoleLevelUp = 1,
	LoginUIClick = 4,
	RoleDetailUIClick = 3,
	FightDIYFire = 10,
	FightSkillSelect = 9,
	FightRest = 17,
	FightSkillFire = 21,
	FightRoleDead = 15,
	RoleFirstGet = 5,
	RoleUpgrade = 2,
	FightBeWightAttack = 14,
	FightAttackSelect = 8,
	FightStart = 6,
	FightRoleSelect = 7,
	HomeLandInteract = 19,
	FightAttackFire = 20,
	FightKillEnemy = 11,
	FightSpecialCompanion = 18,
	FightSuccess = 12,
	FightFailed = 16
}
Constant.ServerParams = {
	CHANNEL_CDKEY_OPEN_LIST = "CHANNEL_CDKEY_OPEN_LIST",
	INTERNAL_RECHARGE = "INTERNAL_RECHARGE",
	GM_QUESTIONNAIRE_SWITCH = "GM_QUESTIONNAIRE_SWITCH",
	GM_COMMUNITY = "GM_COMMUNITY"
}
Constant.SkinTag = {
	skillTag = 2,
	battleTag = 1
}
Constant.SkinUIOpenType = {
	HeroDetailsUI = 1,
	ShopDetailsUI = 2
}
Constant.GuideEvent = {
	LotteryComplete = 101
}
Constant.PushGiftUITable = {
	{
		UIName = "MainUI",
		Type = 1
	},
	{
		UIName = "ShopUI",
		Type = 2
	},
	{
		UIName = "RoleDevelopmentPanel",
		Type = 3
	},
	{
		UIName = "ChapterStageMapUI",
		Type = 4
	}
}
Constant.MainUIAsyncPopupKey = {
	DelSpecialMail = 1
}
Constant.TowerStageType = {
	special = 2,
	normal = 1
}
Constant.BossChapterTag = {
	ghost = 2,
	normal = 1
}
Constant.GhostGameBuffType = {
	ChangeAttackInterval = 3,
	ChangeAttackPower = 2,
	ChangeAttackNum = 1,
	Frozen = 5,
	SlowDown = 4
}
Constant.MazeMoveDir = {
	Top = 1,
	Bottom = 3,
	Right = 2,
	Left = 4
}
Constant.MazeShowEventImgType = {
	Portal = 8,
	Businessman = 4,
	Battle = 1,
	MazeInteractive = 6,
	TreasureChest = 2
}
Constant.MazeEventType = {
	SelectBuff = 3,
	ChangeNpc = 11,
	Businessman = 4,
	ChangeScene = 12,
	Portal = 8,
	Performance = 10,
	Video = 7,
	Behavior = 9,
	Battle = 1,
	DialogueInteractive = 5,
	MazeInteractive = 6,
	TreasureChest = 2
}
Constant.MazeStageEventState = {
	EventState = 1,
	NeedSelectBuff = 2,
	Success = 3,
	None = 0
}
Constant.MazeSenroTalenState = {
	MaxLevel = 12,
	Locked = 1,
	CanUnlock = 2,
	Active = 10,
	CanLevelUp = 11
}
Constant.MazeOptionType = {
	TreasureChest = 1,
	Event = 2,
	Battle = 3
}
Constant.MazeMapType = {
	5,
	6,
	7,
	8
}
Constant.MazeStageExploreState = {
	NormalSettle = 3,
	HerosDeath = 1,
	NormalExplore = 0,
	TimeOut = 2
}
Constant.MazeBuffType = {
	BattleBuff = 1,
	MazeBuff = 3,
	TalentBuff = 2
}
Constant.MazeBuffDataAndItemCorrespondTable = {
	Constant.MazeBuffType.BattleBuff,
	Constant.MazeBuffType.MazeBuff,
	Constant.MazeBuffType.TalentBuff
}
Constant.MazeSettlementType = {
	ArriveExit = 2,
	AfterRoom = 1,
	GetItem = 4,
	KillMonster = 3
}
Constant.MazeHpChangeState = {
	Unchanged = 0,
	Reduce = 2,
	Add = 1
}
Constant.MazeEffectOrSoundDestoryType = {
	StepEnd = 1,
	ByEventID = 4,
	EventLinkEnd = 2,
	ByStep = 3
}
Constant.MazeClientDataType = {
	Performance = 2,
	Npc = 1
}
Constant.MazeSenroEffectType = {
	ShopDiscount = 11,
	ShopPartDiscount = 17,
	FreeRefresh = 13,
	JumpMapConsume = 16,
	RefreshBuff = 14,
	OpenShopRefresh = 12
}
Constant.CommonDialogActionType = {
	SetDialogueImageShow = 1015,
	OpenHuntUI = 1025,
	PlayAnimation = 101,
	OpenBox = 1005,
	Wish = 1006,
	ChangeRoleDirection = 1014,
	PlayMusic = 102,
	SetHudOpen = 1024,
	EndDialog = 106,
	ShowActionSelect = 105,
	SetActorActive = 1010,
	DailyEater = 4002,
	DailyHunt = 4004,
	SetActorPos = 1022,
	OpenInteractionUI = 1023,
	DailyNonUI = 4005,
	ChangeRole = 1009,
	ShowDialog = 104,
	EnterStory = 1002,
	ActorMove = 1012,
	ActorsMove = 1020,
	SwitchVirtualCamera = 1011,
	ChangeBGM = 107,
	GetTask = 1003,
	CreateTempActor = 1019,
	WorldMapComponentActionEnd = 1004,
	EnterRoom = 1001,
	CreateActor = 1016,
	SwitchTime = 1007,
	DailyLottery = 4003,
	ShowLocationInfo = 1017,
	ShowFilter = 1013,
	PlayStandPaintAnimation = 203,
	RemoveEffect = 108,
	SetStandPaintPos = 202,
	PlayEffect = 103,
	RefreshRoomActor = 1021,
	RefreshStandPaint = 201
}
Constant.WorldRoomActionType = {
	RoomTransport = 2001,
	OpenHuntUI = 1025,
	GetTask = 1003,
	OpenBox = 1005,
	Wish = 1006,
	DailyHunt = 4004,
	ShowActionSelect = 105,
	BanNpcNameShow = 4001,
	EnterRoom = 1001,
	DailyNonUI = 4005,
	SwitchTime = 1007,
	DailyLottery = 4003,
	OpenInteractionUI = 1023,
	RandomSelectAction = 1008,
	ShowDialog = 104,
	EnterStory = 1002,
	DailyEater = 4002
}
Constant.RoomComponentsType = {
	Role = 2,
	Transport = 3,
	Article = 1
}
Constant.WorldMapTimeState = {
	Day = 1,
	Night = 2
}
Constant.WorldMapStatus = {
	Show = 1,
	Remove = -1,
	Hide = 2,
	Null = 0
}
Constant.FSMType = {
	RPGActorFSM = 1
}
Constant.RPGActorFSMState = {
	Idle = "RPGActorState_Idle",
	Animate = "RPGActorState_Animate",
	Chat = "RPGActorState_Chat",
	Saunter = "RPGActorState_Saunter",
	AnimationGroup = "RPGActorState_AnimationGroup"
}
Constant.RPGAIActionType = {
	Animate = 1002,
	Saunter = 1001
}
Constant.RPGTaskTimeType = {
	Day = 1,
	Night = 2,
	Normal = 0
}
Constant.RPGActionTriggerType = {
	Initiative = 1,
	Passively = 2
}
Constant.RPGActionTagType = {
	RandomChest = 6,
	State = 4,
	Tag = 3,
	Saunter = 1,
	Normal = 2
}
Constant.RPGTagType = {
	SaunterEvent = 3004,
	MainTag = 3001,
	SmallEvent = 3005,
	Daily = 3007,
	Affinity = 3006,
	BranchTag_RPG = 3003,
	Hunt = 3008,
	BranchTag = 3002
}
Constant.RPGTaskType = {
	DungeonChildTask = 4,
	MainTask = 1,
	LvChildTask = 3,
	DialogChildTask = 2
}
Constant.WorldMapDailyActionType = {
	InviteSpeak = 1002,
	PlayAnimation = 1001
}
Constant.WorldDailyHuntState = {
	HadHunted = 2,
	HasGet = 1,
	Normal = 0
}
Constant.WorldDailyLotteryType = {
	Content = 101,
	Draw = 201
}
Constant.DirectRefreshDuration = 0.5
Constant.DynamicSkinShowPosition = {
	BattleResultUI = 8,
	SkinPanel = 2,
	DetailsPreviewUI = 7,
	MobilePhone_Skin = 9,
	RoleInfoDetails = 6,
	UserInfo = 5,
	RoleDevelopmentPanel = 1,
	MobilePhone = 3,
	GetHero = 4
}
Constant.DynamicSkinDisplayActionType = {
	Greeting_Evening = 23,
	Greeting_Noon = 22,
	Touch = 4,
	BattleWin = 5,
	Greeting_Morning = 21,
	Standby = 3,
	Idle = 1,
	BattleLost = 6,
	Greeting = 2,
	Greeting_LateEvening = 24
}
Constant.CommonDialogPanelType = {
	LRDialog = 99,
	StandPaint = 2,
	Bubble = 1,
	DialogSelect = 3
}
Constant.CommonDialogCfgType = {
	Main = 1
}
Constant.MainCameraStackType = {
	Battle = 2,
	Normal = 1
}
Constant.WorldAreaUIToggleType = {
	Day = 1,
	Activity = 3,
	Trunk = 2
}
Constant.SoundGroupType = {
	Battle = 2,
	Story = 1
}
Constant.CommonConditionSelectionType = {
	Color = 2,
	Quality = 1
}
Constant.FavorEntryType = {
	Text = 1,
	Image = 2,
	Event = 3,
	Cheat = 4
}
Constant.NPCTriggerType = {
	Standby = 3,
	BuyOnShop = 2,
	OpenUI = 1
}
Constant.NPCTalkGroupType = {
	WorldBoss = 3,
	Shop = 1,
	FreeShop = 2
}
Constant.CenterRankID = {
	ChallengeWorldBoss = 1
}
Constant.CenterRankRankType = {
	Percentage = 2,
	Specific = 1
}
Constant.GlobalBuffEffectType = {
	All = 0,
	Gain = 1,
	Battle = 2
}
Constant.GlobalBuffStatus = {
	Remove = 3,
	Update = 2,
	Add = 1
}
Constant.CenterChatChannelType = {
	CHAT_CHANNEL_PERSON = 4,
	CHAT_CHANNEL_UNION = 5,
	CHAT_CHANNEL_SYS_ROLL = 2,
	CHAT_CHANNEL_SYS = 1,
	CHAT_CHANNEL_WORLD = 3
}
Constant.SaveDataKey = {
	PaintingItemCid = "PaintingItemCid"
}
Constant.MailNameColor = {
	Select = Color.New(1, 1, 1, 1),
	UnRead = Color.New(0.8, 0.8, 0.8, 1),
	Read = Color.New(0.30196078431372547, 0.30196078431372547, 0.30196078431372547, 1)
}
Constant.RechargeActivityItemState = {
	Finished = 3,
	Open = 2,
	Disable = 1
}
