-- chunkname: @IQIGame\\Definition\\Constant.lua

Constant = {}
Constant.Unity = {
	SortingOrderMaxValue = 32767,
	SortingOrderMinValue = -32768
}
Constant.LoginConst = {
	CodeRegisterUrl = "http://{0}/login/user_code_reg/",
	GetNoticeContentUrl = "http://{0}/login/get_notice_content/",
	RegisterUrl = "http://{0}/login/user_reg/",
	Send = "http://{0}/login/send/",
	ActiveAccountUrl = "http://{0}/login/user_activation/",
	CreateRechargeOrderUrl = "http://{0}/login/create_recharge_order/",
	NoticeUrl = "http://{0}/login/get_notice/",
	GuestAccountUrl = "http://{0}/login/get_guest_account/",
	Verify = "http://{0}/login/verify/",
	GetSimpleInfo = "http://{0}/login/get_simple_info/",
	LoginUrl = "http://{0}/login/user_login/"
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
Constant.PlayerPrefsConst = {
	ChatNormalEmo = "ChatNormalEmo",
	Notice_IsNew = "_Notice_IsNew",
	UserName = "_login_user_name",
	MainCity_Spine_BG = "_mainCity_spine_bg",
	PrivateChat_key = "PrivateChat_key",
	MazeStageSpeed = "_maze_stage_speed",
	UserSettingMessageChildSwitch = "_Setting_Message_Child_Switch",
	BattleSpeed = "_battle_speed",
	Open_ChallengeWorldBoss = "_Open_ChallengeWorldBoss",
	DualTeamExploreEasyMode = "_dual_team_explore_easy_mode",
	UserSoundVolume = "_sound_volume",
	Bingo = "_bingo",
	Open_DoubleFight = "Open_DoubleFight",
	VirtualPhotoNoticeDisabled = "_virtual_photo_notice_disabled",
	UICommonRecord = "_ui_common_record",
	OpenedRpgBefore = "_opened_rpg_before",
	DualTeamExploreTeam = "_dual_team_explore_team",
	LotteryPackUpCids = "_lottery_pack_up_cids",
	UserLoginBG = "_login_BG",
	Password = "_login_password",
	ChangeAccountPlatform = "_changeAccountPlatform",
	UserSettingUltimateAnimationSate = "_Setting_Ultimate_Animation_State",
	AutoFight = "_auto_fight",
	UserSettingMessageMainSwitch = "_Setting_Message_Main_Switch",
	UserCvVolume = "_cv_volume",
	UserSettingDark = "_Setting_Dark",
	ChallengeTowerCD = "_challengeTower_failure",
	gmCustom = "_gmCustom",
	ChatEmoGroup = "ChatEmoGroup",
	prefabIndex = "_prefabIndex",
	Open_MagicWaxMuseum = "_Open_MagicWaxMuseum",
	gmDebug = "_gmDebug",
	Offline = "_offline",
	OpenDrawCard = "_OpenDrawCard",
	ChallengeCD = "_challenge_failure",
	Maze_Save = "_maze_save",
	UserMusicVolume = "_music_volume",
	UserPID = "_login_user_pid",
	WorkRecord = "_workRecord",
	OpenHarmoniousResources = "_OpenHarmoniousResources",
	FormationTeamIndex = "_formation_team_index",
	CommonExpression_key = "CommonExpression_key",
	Open_CommandChallenge = "_Open_CommandChallenge",
	PlaceGameFormationTeamIndex = "_place_game_formation_team_index",
	UserTargetFrameRate = "_TargetFrameRate",
	DreamlandSpeed = "_dreamland_speed"
}
Constant.SaveServerDataKey = {
	LibraryFavorBgm = "_Library_Favor_Bgm",
	GirlOnDuty = "_girl_on_duty_list",
	LotteryDailyDawCount = "_lottery_daily_draw_count",
	GirlBackGround = "_girl_back_ground_set",
	LibraryBgm = "_Library_Bgm",
	GoodsBoughtTimes = "GoodsBoughtTimes"
}
Constant.Player = {
	DailyResetTimeSec = 0,
	DailyResetTimeHour = 4,
	DailyResetTimeMin = 0
}
Constant.FakeServerInfo = {
	ServerID = 0,
	Port = 0
}
Constant.ConditionConstant = {
	SUB_TYPE_ITEM_ID = 1,
	SUB_TYPE_DOLL_ATTR = 2,
	CONDITION_TYPE_WEEK = 2,
	SUB_TYPE_PLAYER_ATT_REFUNDS_GIFT = 30,
	TYPE_MAZE = 5,
	CONDITION_TYPE_DAY_OF_WEEK = 5,
	SUB_TYPE_PLAYER_RUNE_COUNT = 18,
	TYPE_FAIL = 0,
	SUB_TYPE_PLAYER_HAS_SERVICE_STATEFUL = 21,
	SUB_TYPE_ELEMENT_EXE_COUNT = 1,
	MEMORY_STORY = 3,
	SUB_TYPE_TIME_YEAR = 6,
	SUB_TYPE_PLAYER_PARAMS = 13,
	SUB_SOUL_FAVOR = 12,
	SUB_TYPE_PLAYER_ATT_SOUL_WHISPER = 28,
	SUB_TYPE_PLAYER_ATT_FISHING_SPECIMEN_COUNT = 29,
	SUB_TYPE_REGISTERED_TIME_STAMP_SEC = 1,
	SUB_TYPE_PLAYER_ITEM_DROP_COUNT = 20,
	SUB_TYPE_MAZE_PLAYER_PARAMS = 10,
	SUB_TYPE_ALL_DOLL_ATTR_PER = 6,
	SUB_TYPE_PLAYER_PLAYER_MAZE = 34,
	AREA_MAZE = 2,
	SUB_TYPE_CURR_NODE_ELEMENT = 6,
	SUB_TYPE_AREA_ELEMENT_COUNT_BY_PARAM = 8,
	SUB_TYPE_HAS_ITEM = 2,
	SUB_TYPE_PLAYER_ATT_TOWN_STORY = 19,
	SUB_TYPE_PLAYER_ATT_HAS_QUEST = 6,
	SUB_TYPE_DOLL_SKILL = 4,
	SUB_TYPE_FINISH_QUEST = 4,
	CONDITION_TYPE_COUNT_OF_MONTH = 3,
	SUB_TYPE_TIME_MINUTE = 1,
	SUB_TYPE_TIME_DAY = 3,
	SUB_TYPE_TIME_WEEK = 4,
	SUB_TYPE_TIME_MONTH = 5,
	SUB_TYPE_GAL_GAME_GIRL_REJECT_COUNT = 12,
	SUB_TYPE_TIME_TIMESTAMP = 7,
	TYPE_WEATHER = 7,
	SUB_TYPE_PLAYER_ATT_MAZE_SCORE = 17,
	SUB_TYPE_PLAYER_ATT_EQUIP_SKINS = 31,
	TYPE_MONSTER_ACADEMY = 10,
	SUB_SOUL_LEVEL = 11,
	SUB_TYPE_AREA_ELEMENT_COUNT = 3,
	AREA_NORMAL = 1,
	TYPE_MEMORY_STORY = 9,
	SUB_TYPE_UNLOCK_EVENT = 9,
	SUB_TYPE_MAZE_PREV_PATH_NODE_DIR = 11,
	SUB_TYPE_MEMORY_STORY_SUCCEED_TASK = 2,
	SUB_TYPE_GAL_GAME_PLAY_THROUGH_COUNT = 11,
	TYPE_ITEM = 2,
	SUB_TYPE_TYPE_ELEMENT_COUNT = 4,
	SUB_TYPE_FINISH_TARGET_QUEST = 7,
	SUB_TYPE_DATING_PARAMS = 14,
	SUB_TYPE_PLAYER_LOTTERY_SHOW_COUNT = 22,
	SUB_TYPE_MEMORY_STORY_SCENE_HAS_ELEMENT = 4,
	SUB_TYPE_MONSTER_ACADEMY_GIRLS_FAVOR = 5,
	SUB_TYPE_ELEMENT_COUNT = 2,
	TYPE_DOLL = 4,
	CONDITION_TYPE_DAY = 1,
	TYPE_OPERATION_EVENT = 12,
	SUB_TYPE_PLAYER_ATT_TOWER_MAX_FLOOR = 32,
	SUB_TYPE_UNLOCK_SOUL = 5,
	SUB_TYPE_PLAYER_BUFF = 15,
	SUB_TYPE_PLAYER_ATT_ENERGY = 2,
	CONDITION_TYPE_DAY_OF_MONTH = 6,
	SUB_TYPE_MONSTER_ACADEMY_TIME_TRIGGER_COUNT = 3,
	CONDITION_TYPE_COUNT_OF_WEEK = 2,
	SUB_TYPE_PLAYER_BUFF_COUNT = 16,
	SUB_TYPE_PASS_LEVEL = 3,
	TYPE_TIME = 6,
	CONDITION_TYPE_YEAR = 4,
	TYPE_ELEMENT = 3,
	SUB_TYPE_MAZE_CURR_MAZE_CID = 1,
	CONDITION_TYPE_COUNT_OF_YEAR = 4,
	CONDITION_TYPE_COUNT_OF_ALL = 5,
	SUB_TYPE_DOLL_EQUIP = 3,
	CONDITION_TYPE_MONTH = 3,
	SUB_TYPE_FORMATION_DOLL_NUM = 7,
	SUB_TYPE_WEATHER = 1,
	SUB_TYPE_MONSTER_ACADEMY_GIRLS_CONTACT = 6,
	SUB_TYPE_PATH_NODE_ELEMENT_COUNT = 9,
	SUB_TYPE_RELATIVE_PATH_NODE_ELEMENT_COUNT = 10,
	SUB_TYPE_PLAYER_ATT_SUM_PAY = 24,
	SUB_TYPE_MONSTER_ACADEMY_ITEM = 7,
	SUB_TYPE_MONSTER_ACADEMY_TIME_DAY_AT = 1,
	SUB_TYPE_MONSTER_ACADEMY_TIME_PHASE_OF_DAY = 2,
	SUB_TYPE_MAZE_CURR_PATH_NODE_CID = 2,
	SUB_TYPE_MONSTER_ACADEMY_FINISHED_TASK = 8,
	SUB_TYPE_AREA_TYPE_ELEMENT_COUNT = 5,
	SUB_TYPE_MEMORY_STORY_SUBMIT_TASK = 3,
	SUB_TYPE_PLAYER_MALL_BUY_COUNT = 23,
	SUB_TYPE_GAL_GAME_SCHEDULE = 13,
	SUB_TYPE_TIME_HOUR = 2,
	SUB_TYPE_GAL_GAME_ACHIEVEMENT = 14,
	SUB_TYPE_PLAYER_ATT_LV = 1,
	SUB_TYPE_GAL_GAME_MESSAGE_GROUP_COUNT = 16,
	TYPE_DAILY_DUP = 11,
	SUB_TYPE_ELEMENT_COUNT_BY_PARAM = 7,
	SUB_TYPE_DAILY_DUP_STATUS = 1,
	SUB_TYPE_MONSTER_ACADEMY_CANCEL_DATING_COUNT = 10,
	SUB_TYPE_PLAYER_ATT_FUNCTION_TYPE = 26,
	SUB_TYPE_OPERATION_EVENT_STATUS = 1,
	SUB_TYPE_MEMORY_STORY_ITEM_STATE = 5,
	CONDITION_TYPE_COUNT_OF_DAY = 1,
	SUB_TYPE_HORIZONTAL_RPG_DAY = 1,
	SUB_TYPE_ALL_DOLL_ATTR = 5,
	TYPE_REGISTERED_TIME = 8,
	SUB_TYPE_PLAYER_ATT_SOUL_OATH = 27,
	SUB_TYPE_PLAYER_PLAYER_HEAD = 33,
	TYPE_HORIZONTAL_RPG = 13,
	SUB_TYPE_PLAYER_ATT_HSA_DRESS = 25,
	SUB_TYPE_MEMORY_STORY_RECEIVE_TASK = 1,
	SUB_TYPE_MONSTER_ACADEMY_CALLBACK_COUNT = 9,
	TYPE_PLAYER_ATT = 1,
	SUB_TYPE_MONSTER_ACADEMY_ROLE_PROPERTIES = 4,
	SUB_TYPE_GAL_GAME_USE_ITEM_COUNT = 15,
	SUB_TYPE_DOLL_SOUL_CID = 1
}
Constant.ItemID = {
	CRYSTAL = 4,
	EXPRESS_STUB = 1201,
	LUNAR_CALENDAR = 12201,
	GUILD_FUNDS = 121,
	FURNITURE_BILL = 10008,
	PANDA_VOTE = 405,
	EXPLORATION_ORDER = 402,
	MONEY = 1,
	DREAM_MOVE_POINT_FAKE_ITEM = 204,
	GUILD_CHALLENGE_TICKETS = 124,
	Flight_Points = 447,
	WORLD_BOSS_PRESTIGE = 106,
	ENERGY = 104,
	GUILD_PURCHASE_COUPONS = 122,
	ACTIVE_POINT = 102,
	VACATION_TIME = 101,
	BOUNTY_REFRESH = 103,
	NEW_CHARACTER_SCORE = 301,
	COMFORT = 6,
	TOWER_SCORE = 105,
	SPIRIT_AMBER = 1201061,
	CONTRIBUTION = 3,
	ID_PAYPOINT_SHOW = 5,
	FISH_PATTERN = 411,
	JEWELRY_STAR_MATERIAL = 46100,
	ABYSS_COUNT = 108,
	GUIDE_LAMP = 1290000,
	TREASURE = 2,
	EVIL_EROSION_CURRENCY = 210,
	HorizontalRPG_Points = 469,
	FISH_CONDENSED_STONE = 11911,
	PUZZLE_PIECES = 119
}
Constant.EffectTypeID = {
	TYPE_UNLOCK_TOWN_NEW_ENTRY = 47,
	TYPE_UNLOCK_QUEST = 7,
	TYPE_ADD_ITEM = 17,
	TYPE_UNLOCK_FORMATION = 40,
	ID_GET_SOUL_1 = 2,
	TYPE_ADD_GLOBALBUFF = 22,
	TYPE_SOUL_FAVOR = 8,
	TYPE_UNLOCK_EVENT = 5,
	TYPE_OPEN_FUNCTIONTYPE = 38,
	TYPE_ADD_VIP_EXP = 13,
	TYPE_UNLOCK_HOMELAND_SUIT = 53,
	TYPE_UNLOCK_MANUFACTURE_ITEM = 10,
	TYPE_ATTRIBUTE_BONUS = 52,
	TYPE_UNLOCK_HEAD_ICON = 26,
	TYPE_UNLOCK_WHISPER = 64,
	TYPE_UNLOCK_SOUL_PLATE = 32,
	ID_DROP_1 = 1,
	TYPE_UNLOCK_LOGIN_BACKGROUND = 27,
	TYPE_UNLOCK_SOUL_NEW_STORY = 30,
	TYPE_UNLOCK_SHOP = 29,
	TYPE_ADD_SOUL_MEMERY_DRESS_PROGRESS = 28,
	TYPE_UNLOCK_TOWN_NPC_ITEM_ENTRY = 46,
	TYPE_GET_DRESS = 6,
	TYPE_UNLOCK_TOWN_AREA_ENTRY = 45,
	TYPE_UNLOCK_AVATAR_FRAME = 25,
	TYPE_ADD_EXP = 12,
	TYPE_UNLOCK_COOK_COMBINATION = 3,
	TYPE_UP_SOUL_FAVOR_MAX_LV_LIMIT = 41,
	TYPE_UNLOCK_TOWN_STORY = 50,
	TYPE_UNLOCK_QUEST_TYPE = 24,
	TYPE_ADD_SOUL_EXP = 39,
	TYPE_UNLOCK_RUNE = 51,
	TYPE_UNLOCK_ALIEN_EVENT = 49,
	TYPE_UNLOCK_LOTTERY_PACK = 31,
	TYPE_UNLOCK_TOWN_RUMOR_ENTRY = 48
}
Constant.ClientEffectTypeID = {
	CUSTOM_TYPE_UNLOCK_COOK = 1,
	TYPE_UNLOCK_FISH = 2,
	FISHING_ACTIVITY_UNLOCK_FISH = 3
}
Constant.Item = {
	USE_AREA_MAZE = 2,
	USE_AREA_NONE = 0,
	USE_AREA_LEAVE_MAZE = 3,
	USE_AREA_CITY = 1
}
Constant.Skill = {
	TYPE_CORE = 3,
	TYPE_DEAD = 7,
	TYPE_NORMAL = 5,
	TYPE_DERIVATION = 9,
	SHOW_TYPE_CORE2 = 3,
	RELEASE_TYPE_PASSIVE = 2,
	SHOW_TYPE_NONE = 0,
	SHOW_TYPE_OPTIONAL_SP_SKILL = 7,
	TYPE_RUSH = 6,
	TYPE_ULTIMATE = 2,
	SHOW_TYPE_RUSH = 5,
	SHOW_TYPE_CORE = 2,
	RELEASE_TYPE_ACTIVE = 1,
	TYPE_COUNTER_ATTACK = 8,
	SHOW_TYPE_SPECIALITY = 6,
	SHOW_TYPE_ULTIMATE = 4,
	SHOW_TYPE_NORMAL = 1,
	TYPE_MASTERY = 1,
	TYPE_CORE2 = 4
}
Constant.CardGameStep = {
	STEP_SHOW_CARD_COMPLETE = 6,
	STEP_NONE = 0,
	STEP_START_SHOW_ALL_CARD = 8,
	STEP_SHOWED_CARD_RETURN = 7,
	STEP_SHOWING_ALL_CARD = 9,
	STEP_START = 1,
	STEP_COPY_BUFF = 21,
	STEP_MOVE_TO_FINAL_POSITION = 3,
	STEP_MOVE_TO_CENTER = 2,
	STEP_CAN_CHOOSE_CARD = 4,
	STEP_START_SHOW_CARD = 5
}
Constant.CardGameBuffType = {
	CHANGE = 4,
	MARK = 5,
	REDRAW_COUNT = 3,
	COPY = 6,
	SHUFFLE_COUNT = 2,
	SHUFFLE_DURATION = 1
}
Constant.TurntableGameStep = {
	STEP_READY_TO_SPIN = 4,
	STEP_PREPARE_COMPLETE = 2,
	STEP_PREPARE = 1,
	STEP_MOVE_TO_FINAL_DESTINATION = 6,
	STEP_BUFF = 3,
	STEP_SPIN = 5,
	STEP_SHOW = 7,
	STEP_NONE = 0,
	STEP_RESTART = 8
}
Constant.TurntableGameBuffType = {
	SPEED = 103,
	REDRAW_COUNT = 104,
	COPY = 101,
	DELETE = 102
}
Constant.Notice = {
	FloatTypeMazeLimitTimeChange = 3,
	FloatTypeNormal = 1,
	FloatTypeGetItem = 2,
	BlankFloatNoticeID = 21040005,
	BlankOneBtnAlertNoticeID = 21040007,
	BlankRollingNoticeID = 21040006,
	BlankTwoBtnAlertNoticeID = 21040008
}
Constant.SoundGroup = {
	ENVIRONMENT = "ENVIRONMENT",
	LIVE2D = "LIVE2D",
	CHARACTER = "CHARACTER",
	UI = "UI",
	BGM = "BGM"
}
Constant.Maze = {
	ChapterTypeScroll = 8,
	RuneNoticeTypeSplit = 5,
	BuffNoticeTypeTrigger = 3,
	BuffNoticeTypeAdd = 1,
	RuneNoticeTypeUnseal = 2,
	RuneFeatureStrengthen = 1,
	InfiniteMazeActualNodeMargin = 1.5,
	EntityTypeMazePath = 2,
	EntityTypeMazeNode = 1,
	RuneNoticeTypeEvolution = 4,
	TypeMapResExplore = 2,
	StreamingTypeInScopeAndArea = 2,
	RuneFeatureGrow = 2,
	TypeMapResBattle = 1,
	RuneNoticeTypeStrengthen = 6,
	ChapterTypeRpg = 7,
	ChapterTypeLunaSysTeamScroll = 9,
	BuffNoticeTypeRemove = 2,
	EntityTypeMazeElement = 4,
	TYpeMapResBigComp = 4,
	StreamingTypeInScope = 1,
	NodeTypeExit = 2,
	MapUILimitTypeNone = 0,
	MapUILimitTypeArea = 1,
	ChapterTypeLunaFort = 10,
	NodeTypeSecretPassage = 3,
	SceneSizeToUI = 75,
	ChapterTypeEndless = 1,
	ChapterTypeNormal = 2,
	TypeMapResSmallComp = 3,
	RuneFeatureSeal = 4,
	RuneNoticeTypeEffect = 3,
	ChapterTypeDualTeamExplore = 11,
	RuneNoticeTypeGet = 1,
	ChapterTypeHorizontalChallenge = 14,
	StreamingTypeNone = 0,
	ChapterTypeHorizontalRPG = 13,
	ChapterTypeIllusion = 6,
	ChapterTypeEndlessPlus = 12,
	EntityTypeMazeHero = 3,
	RuneFeatureConsume = 3,
	InfiniteMazeLoadRectMargin = 0.5,
	NodeTypeEntry = 1
}
Constant.PauseMoveReason = {
	PreExecution = 1,
	QuickFight = 2
}
Constant.ScrollMazeAnim = {
	Phase_CustomStart = 1,
	AnimName_QuickFightDelete = "Delete_QuickFight",
	AnimName_TempStart = "Fight_Normal",
	AnimName_Start = "Start",
	AnimName_Born = "Born",
	AnimName_Quick_Fight = "QuickFight",
	AnimName_TempEnd = "Gather",
	AnimName_Run = "Run",
	Phase_Default = 0,
	Phase_CustomEnd = 2,
	AnimName_Reset = "Reset"
}
Constant.MazeSelectionType = {
	Auto = 3,
	Image = 2,
	HideAuto = 4,
	Normal = 1
}
Constant.MazeId = {
	IllusionMaze = 26010001
}
Constant.FriendType = {
	TYPE_FRIEND = 1,
	TYPE_MY_APPLICATION = 5,
	TYPE_MUTE = 4,
	TYPE_STRANGER = 3,
	TYPE_APPLICATION = 2
}
Constant.ShopGoodsBuyType = {
	SHOP = 2,
	MALL = 1
}
Constant.MallTimeLimitType = {
	LIMIT_SELL_TIME = 2,
	TIME_STAMP = 1,
	STAY = 0
}
Constant.GoodsType = {
	Base_Gift_Goods = 3,
	Base_Goods = 1
}
Constant.BattleTroopType = {
	Defend = 2,
	Attack = 1
}
Constant.BuffTag = {
	MatchMazeBuff = 10,
	MatchMazeDebuff = 11,
	JudgeWeather = 2,
	Bless = 1,
	JudgeDollPollution = 5,
	JudgeSkill = 3,
	JudgeDice = 4
}
Constant.LotteryType = {
	Lottery_Soul = 1,
	Lottery_Equip = 2,
	Lottery_furniture = 3
}
Constant.UnlockNoticeType = {
	Soul_CV = 3,
	Soul_CG = 2,
	Town_Area = 4,
	Town_NpcIntro = 5,
	Town_News = 6,
	HomeLand_Theme = 8,
	Event = 1,
	Town_Gossip = 7
}
Constant.BookType = {
	BookTypeDialog = 3,
	BookTypeCV = 2,
	BookTypeMovie = 4,
	BookTypeCG = 1,
	BookTypeSpineCV = 5
}
Constant.Number = {
	IntMinValue = -2147483648,
	IntMaxValue = 2147483647,
	FloatMaxValue = 3.402823e+38,
	FloatMinValue = -3.402823e+38
}
Constant.CompassAreaTargetStatus = {
	Disappear = 6,
	Changed = 2,
	FarAway = 4,
	Complete = 7,
	Detected = 1,
	Close = 3,
	Arrive = 5
}
Constant.TownHandBookType = {
	PlateTypeRumor = 4,
	PlateTypeNpc = 1,
	PlateTypeNew = 3,
	PlateTypeNpcItem = 2
}
Constant.LibraryTaskType = {
	TaskTypeEquipment = 2,
	TaskTypeNews = 1,
	TaskTypeStory = 4,
	TaskTypeMaze = 3
}
Constant.LibraryStoryResType = {
	NpcResBranchType = 7,
	TownResMainType = 1,
	SoulNewStoryResType = 4,
	SoulDatingResType = 5,
	MazeResType = 8,
	TownResBranchType = 2,
	ActionStoryBranchType = 10,
	SoulShopResType = 3,
	NpcShopResType = 6,
	ActionStoryMainType = 9
}
Constant.LibraryStoryType = {
	SoulStory = 2,
	MazeStory = 4,
	NPCStory = 3,
	TownStory = 1,
	StoryCG = 5,
	ActionStory = 7
}
Constant.LibraryBookType = {
	AlienEventTypeIllusionMaze = 2,
	AlienEventTypeNormal = 1
}
Constant.NPCType = {
	NpcResLike = 7,
	NpcResHate = 8,
	NpcResWeakness = 6,
	NpcResOccupation = 2,
	NpcResWeight = 4,
	NpcResSpeciality = 5,
	NpcResLabel = 9,
	NpcResHeight = 3,
	NpcResName = 1
}
Constant.HomelandPlantType = {
	landStatusGrowing = 4,
	landStatusSeedling = 3,
	landStatusIdle = 1,
	landStatusMature = 5,
	landStatusInit = 2
}
Constant.ItemType = {
	Item = 2,
	Equip = 3,
	AutoEffect = 5,
	JewelryEquip = 12,
	HomeDecoration = 8,
	Jewelry = 10,
	EvilErosionEquip = 9,
	Numerical = 6,
	PlaceGameEquip = 11
}
Constant.ItemSubType = {
	ItemSeasoning = 907,
	ItemEgg = 905,
	ItemCollectionTool = 33,
	ItemMeat = 901,
	ItemHomeWorkTicket = 18,
	ItemUnlockRune = 22,
	ItemCook = 19,
	EquipArmour = 2,
	Fish_Rod = 43,
	ItemToolPackage = 11,
	ItemMotionFragment = 6,
	EffectPowerMonthCard = 21,
	EffectDiamondMonthCard = 15,
	EquipWeapon = 1,
	ItemTool = 12,
	ItemEquip = 21,
	ItemMedicine = 16,
	ItemTask = 13,
	ItemGiftBox = 1,
	EquipRing = 5,
	ItemGift = 8,
	EquipNecklace = 6,
	ItemVitality = 4,
	EffectEquip = 1,
	ItemExchange = 17,
	EffectSkillCard = 2,
	ItemSoulFragment = 5,
	ItemMaterial = 2,
	EffectRough = 4,
	EffectMemoryFragment = 5,
	EffectVitality = 6,
	EffectFavor = 7,
	Fish_Bait = 42,
	EquipHelmet = 3,
	EffectLotterySoulFragment = 10,
	ItemStapleFood = 906,
	ItemFishingTool = 34,
	Fish_Sundries = 41,
	ItemWoodTool = 32,
	EffectSoul = 8,
	EffectExp = 9,
	ItemBerry = 904,
	EquipShoes = 4,
	ItemFashion = 14,
	ItemPlant = 902,
	Fish_Spear = 45,
	ItemExplore = 15,
	ItemStoryEvent = 100,
	Fish_Net = 44,
	Fish_Torpedo = 46,
	ItemEquipFragment = 20,
	ItemMineTool = 31,
	EffectPrivilegeMonthCard = 27,
	EffectAttributeCard = 3,
	Fish = 40,
	ItemConsumable = 10,
	ItemFormula = 9,
	ItemDate = 7,
	ItemFungus = 903,
	ItemFavour = 3
}
Constant.NPCTriggerType = {
	Standby = 4,
	TownExchangeSelectOpen = 6,
	TownExchangeSwitchTab = 5,
	BuyOnMall = 3,
	BuyOnShop = 2,
	OpenUI = 1
}
Constant.ShopType = {
	EvilErosion = 1
}
Constant.ShopShowType = {
	Maze = 2,
	Lottery = 3,
	Normal = 1
}
Constant.ShopRefreshType = {
	Free = 1,
	Pay = 3,
	Item = 2,
	Normal = 0
}
Constant.Function = {
	openTownExchangeUI = 118,
	openActivityUI = 103,
	openActivitySignUI = 129,
	openActivityCreditUI = 127,
	openGameGuideInfoUI = 133,
	openMemoryUI = 122,
	openLotteryUI = 106,
	openMazeDetailUI = 111,
	openMallUI = 104,
	openFurnitureLotteryUI = 107,
	openDailyDup = 115,
	openExploreHall = 135,
	openCelebrationGiftUI = 140,
	openSoulEvolutionUI = 120,
	openSoulListUI = 113,
	openEquipBg = 114,
	openSoulUnlockUI = 124,
	openSoulUI = 109,
	openWorldMazeChooseUI = 117,
	openRPGMaze = 132,
	newMemory = 1003,
	openActiveRookieUI = 123,
	plot = 1002,
	openTaskUI = 105,
	openTownHandbookUI = 108,
	openGirlUI = 110,
	openBuyExchangePanelUI = 128,
	openNoticeUI = 116,
	openActiveWeekendUI = 131,
	openShopUI = 101,
	openMonsterAcademySelectPanelUI = 136,
	openGiftSalesTimePanelUI = 138,
	openTown = 126,
	openFormationUI = 130,
	shopping = 1001,
	openMiningMainUI = 139,
	openBattleMonsterInfoUI = 125
}
Constant.TownFixedFunctionType = {
	Search = 10604001,
	Shop = 1111
}
Constant.SoulGiftType = {
	Sick = 1,
	Favor = 3,
	Normal = 2
}
Constant.BattleDamageType = {
	Shield = 11,
	Magic = 6,
	Fire = 2,
	Miss = 7,
	Heal = 9,
	ElementTypeNum = 6,
	AddSkillEnergy = 16,
	Parry = 13,
	Thunder = 3,
	Immune = 15,
	Physic = 5,
	Ice = 1,
	Resist = 8,
	Poison = 4,
	Thorns = 12,
	SuckBlood = 10,
	Block = 14
}
Constant.HomelandBuildType = {
	BuildBackGift = 36000007,
	BuildCooking = 36000005,
	BuildPlant = 36000003,
	BuildGold = 36000001,
	BuildWork = 36000006,
	BuildProcess = 36000008,
	BuildManufacture = 36000002,
	BuildDutyBoard = 36000004
}
Constant.UnlockType = {
	ACTIVITY_LUCKY_TURN = 30010080,
	SHOP_TOWN = 30010002,
	AUTO_FIGHT = 30010059,
	SIGN = 30010026,
	MAIN_TASK = 30010029,
	MEMORY = 30010013,
	MAZE_SWEEP = 30010048,
	ACTIVITY_WELCOME_BACK = 30010087,
	SOUL_PAINTING = 30010023,
	DAILY_ACTIVE = 30010025,
	ACTIVE_VIRTUAL_PHOTO = 30010094,
	FRIEND = 30010044,
	SOUL_UPGRADE = 30010030,
	SOUL_UP_STAR = 30010022,
	SOUL_START = 30010031,
	LOTTERY = 30010012,
	HOME = 30010005,
	MAZE_CHALLENGE_BONUS = 30010107,
	GIRL_BACKGROUND = 30010102,
	DRESS = 30010004,
	CHAT_BUBBLE = 30010103,
	GUILD = 30010100,
	DATING = 30010003,
	LIBRARY = 30010024,
	MAKE_MANUFACTURE = 30010055,
	JEWELRY = 30010105,
	ACTIVITY_WEEK = 30010068,
	WEEK_ACTIVE = 30010060,
	GM_CARD_GAME = 30010062,
	CHURCH = 30010015,
	ACTIVITY_HUNDRED_DAY = 30010077,
	SOUL_PREFAB = 30010028,
	COMMAND_CHALLENGE = 30010108,
	FISHING = 30010090,
	SPACE_TREASURE = 30010058,
	DENSE_FOREST = 30010036,
	TOWN = 30010007,
	MAKE_ITEM = 30010056,
	CHAT = 30010042,
	CHALLENGE = 30010027,
	SOUL_REBIRTH = 30010033,
	NOTICE = 30010050,
	GIRL_ON_DUTY = 30010096,
	SHOPPING = 30010035,
	MALL = 30010011,
	SOUL_DECOMPOSITION = 30010032,
	PERSONAL_LETTER = 30010034,
	SOUL = 30010045,
	ENDLESS_MAZE = 30010049,
	NEWSTORY = 30010014,
	MINING = 30010104,
	SOUL_SKILL_UP = 30010046,
	SKILLS_ENHANCEMENT = 30010046,
	SOUL_UP_LV = 30010021,
	FORMATION = 30010019,
	WAREHOUSE = 30010047,
	FURNITURELOTTERY = 30010018,
	NAVIGATION = 30010043,
	ACTIVITY_WELCOME_NEW = 30010086,
	ACTIVITY_SPACE_TREASURE = 30010079,
	WASTELAND_TEMPLE = 30010039,
	GIRLS = 30010010,
	DEVILS_LAIR = 30010037,
	WORLD_BOOS = 30010041,
	ACTIVE_ROOKIE = 30010054,
	WAR_COLLEGE = 30010038,
	SOUL_SKILL = 30010020,
	TOWER = 30010040,
	SOUL_TALENT = 30010017,
	ACTIVITY_FOOD = 30010057,
	MAZE = 30010001
}
Constant.NpcActionGroupId = {
	WorldShop = 2,
	ChurchMall = 5,
	ChurchShop = 3,
	Church = 1,
	WorldMall = 4
}
Constant.RedType = {
	TYPE_CHALLENGE = 5,
	TYPE_TOWN = 2,
	TYPE_TOWN_NEW_STORY = 6,
	TYPE_HOME = 1,
	TYPE_GIRL = 3,
	TYPE_LIBRARY = 4
}
Constant.RedClientType = {
	SoulChooseCellRed = 1
}
Constant.GuideTriggerType = {
	CustomTrigger = 3,
	GuideFinish = 2,
	SceneTrigger = 4,
	OpenUI = 1
}
Constant.GuideConditionConstant = {
	CheckIsMyHomeLand = "CheckIsMyHomeLand",
	CheckHaveSoul = "CheckHaveSoul",
	CheckIsEnterMaze = "CheckIsEnterMaze",
	CheckTownPlotEvent = "CheckTownPlotEvent",
	CheckDailyDupOpen = "CheckDailyDupOpen",
	CheckSoulPrefab = "CheckSoulPrefab",
	CheckTalentUnlock = "CheckTalentUnlock",
	CheckHomelandRoomUnlock = "CheckHomelandRoomUnlock",
	CheckInactivatedGuide = "CheckInactivatedGuide",
	CheckLunaBattleAnyZoneSeal = "CheckLunaBattleAnyZoneSeal",
	CustomsClearance = "CustomsClearance",
	CheckPlayerLv = "CheckPlayerLv",
	CheckItemNum = "CheckItemNum",
	CheckNewStoryId = "CheckNewStoryId",
	CheckTask = "CheckTask",
	CheckGuideID = "CheckGuideID",
	CheckSoulLv = "CheckSoulLv"
}
Constant.LockInputReason = {
	DreamlandExecution = 15,
	MemoryStorySceneShowDialog = 34,
	MazeQuickFight = 11,
	MazeAutoMoveCamera = 6,
	DreamlandMove = 17,
	DualTeamExploreInit = 19,
	MazeTransport = 1,
	MazeActiveNode = 2,
	DualTeamExploreSceneActive = 21,
	MemoryStorySceneChangeScene = 35,
	CardGameUI = 8,
	DualTeamExploreQuickFight = 25,
	MazeGather = 3,
	MagicTowerInit = 30,
	MagicTowerExecution = 32,
	DualTeamExploreGather = 22,
	MazeInit = 4,
	ScrollMaze = 14,
	MagicTowerResetEffect = 33,
	MazeStage = 13,
	DualTeamExploreTransport = 23,
	MagicTowerMove = 31,
	FullScreenUIOpened = 7,
	DreamlandInit = 16,
	DualTeamExploreMove = 20,
	DualTeamExplorePlayMoveCamera = 24,
	MazeMainUIBeforeStartExplore = 12,
	MazePlayPreExecAnimation = 5,
	DreamlandResetEffect = 18,
	TurntableGameUI = 10
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
Constant.Battle = {
	BulletTimeRatio = 0.1,
	MonsterTeamTypeBoss = 2,
	MonsterTeamTypeNormal = 1,
	AutoFightModeAutoNormal = 2,
	BattleStartEffectPlayTime = 1.8,
	BattleModuleStateNone = 0,
	AutoFightModeAutoSkill = 3,
	AutoFightModeManual = 1,
	BulletTimeDuration = 1,
	BattleModuleStateStarted = 1,
	BattleModuleShutdownByBackToLogin = 2,
	SpeedList = {
		1,
		2,
		3
	}
}
Constant.BattleType = {
	WorldBoss = 4,
	CommandChallenge = 20,
	DualTeamExploreNormal = 14,
	MagicMuseumBoss = 7,
	RPGBoss = 5,
	DoubleFight = 8,
	FlightChallenge = 21,
	GuildChallenge = 17,
	Tower = 3,
	DualTeamExploreBoss = 12,
	GuildTraining = 22,
	Mining = 18,
	Maze = 1,
	Challenge = 2,
	Panda = 9,
	EvilErosion = 15,
	RestaurantExBoss = 24,
	AmusementParkChallenge = 26,
	SingleWeakTower = 19,
	AmusementParkExBoss = 27,
	PlaceGameChallenge = 25,
	RPGExBoss = 6,
	RestaurantChallenge = 23,
	DualTeamExploreExBoss = 13
}
Constant.BattleOrderType = {
	TypeEnd = 3,
	TypeRole = 2,
	TypeRound = 1
}
Constant.BattlePositionArea = {
	All = 1,
	Back = 3,
	OnlySelf = 4,
	Front = 2
}
Constant.BattleFightResult = {
	TimeOut = 3,
	GiveUp = 5,
	Lose = 2,
	Draw = 4,
	Win = 1
}
Constant.SkillTargetArea = {
	All = 2,
	Single = 1,
	Row = 3
}
Constant.ChallengeType = {
	ChallengeTower = 100,
	ChallengeWordBoos = 200,
	ChallengeMaterial = 2,
	ChallengeIllusionMaze = 4,
	ChallengeGold = 1,
	ChallengeEvilErosion = 12,
	ChallengeSingleWeakTower = 300
}
Constant.SoulBookGetWayType = {
	GetWayType3 = 3,
	GetWayType4 = 4,
	GetWayType8 = 8,
	GetWayType6 = 6,
	GetWayType1 = 1,
	GetWayType7 = 7,
	GetWayType2 = 2,
	GetWayType5 = 5
}
Constant.MainFunShowRank = {
	Constant.UnlockType.MALL,
	Constant.UnlockType.GUILD,
	Constant.UnlockType.LIBRARY,
	Constant.UnlockType.MAIN_TASK,
	Constant.UnlockType.WAREHOUSE,
	Constant.UnlockType.SOUL_PAINTING,
	Constant.UnlockType.FORMATION,
	Constant.UnlockType.SOUL
}
Constant.BuffControlType = {
	Paralysis = 4,
	Silence = 7,
	PlayDead = 9,
	Sleep = 5,
	Charm = 10,
	Exile = 8,
	Stop = 6,
	Stun = 1,
	Stone = 3,
	Freeze = 2
}
Constant.DebuffType = {
	Tool = 3,
	Buff = 1,
	Debuff = 2
}
Constant.MailType = {
	TypeRewardWorldBoss = 2,
	TypeRewardTower = 1,
	TypeRewardMatchMaze = 4,
	TypeRewardExamMaze = 3,
	TypeSystem = 0
}
Constant.MatchMaze = {
	PlayerStateReady = 4,
	FightStateDefault = 1,
	PlayerStateView = 9,
	PlayerStateChooseSoul = 6,
	PlayerStateEnd = 8,
	FightStateChooseCard = 3,
	PlayerStateChooseCard = 5,
	PlayerStateAwait = 3,
	FightStateActive = 2,
	PlayerStateDefault = 1,
	EnterMazeCountdownDelta = 60,
	PlayerStateMatch = 2,
	FightStatePlaying = 4,
	FightStateEnd = 5,
	PlayerStateStart = 7
}
Constant.HomelandRoomFunBuild = {
	36000001,
	36000002,
	36000005,
	36000006
}
Constant.HomelandRoomFunDecorates = {
	401057,
	501052,
	501060,
	501061,
	501062,
	501064,
	501065,
	501066,
	501067,
	601056,
	701057,
	1301032,
	1301053,
	601063
}
Constant.HomeLandPlantDecorates = {
	501052,
	501060,
	501061,
	501062,
	501064,
	501065,
	501066,
	501067
}
Constant.HomelandRoomFunDecorateType = {
	BuildDecorateGold = 701057,
	BuildDecoratePlant = 501060,
	BuildDecorateGift = 1302058,
	BuildDecorateCooking = 401057,
	BuildDecorateManufacture = 601056,
	BuildDecorateWork = 1301032
}
Constant.ModuleTimerName = {
	Maze = "Maze",
	FlightGame = "FlightGame",
	GuildMission = "GuildMission",
	Dreamland = "Dreamland",
	RefundsGiftPack = "RefundsGiftPack",
	PurchaseTip = "PurchaseTip",
	MonsterAcademy = "MonsterAcademy",
	MagicTower = "MagicTower",
	MemoryStory = "MemoryStory",
	SurvivalFlyGame = "SurvivalFlyGame",
	Fishing = "Fishing",
	RestaurantOperationGame = "RestaurantOperationGame",
	BattleCastSkillButtonGroup = "BattleCastSkillButtonGroup",
	DualTeamExplore = "DualTeamExplore",
	AmusementPark = "AmusementPark",
	BattleActionSequenceCell = "BattleActionSequenceCell",
	Battle = "Battle",
	ShopUI = "ShopUI"
}
Constant.DialogPerformance = {
	TYPE_NPC = 2,
	TYPE_Background = 1
}
Constant.Dialog = {
	TypeSimple = 2,
	TypeNormal = 1,
	TypeCover = 3
}
Constant.TypeTipsType = {
	MONSTER = 4,
	DAMAGE = 3,
	POWER_SOURCE = 1,
	CLASS = 2
}
Constant.ItemTab = {
	GIFT = 1,
	FISHING_GEAR = 104,
	TREASURE = 102,
	DUAL_TEAM_EXPLORE = 201,
	BAIT = 103,
	OTHER = 4,
	FISH = 101,
	Jewelry = 5,
	MATERIAL = 3,
	SOUL = 2
}
Constant.UITransitionEffectType = {
	OpenClose = 1,
	Open = 3,
	Close = 2,
	None = 0
}
Constant.RankingType = {
	WorldBossRank = 1,
	SurvivalChallenge = 20,
	DualTeamExploreExBossRank = 4,
	AmusementParkStackedBlocksRank = 18,
	RestaurantOperationRank = 10,
	FishingActivityTotalWeightRank = 22,
	PlotChallengeBossRank = 3,
	AmusementParkExBossRank = 15,
	FishingActivitySingleBestRank = 23,
	AmusementParkFlyBirdRank = 17,
	AmusementParkDollMachineRank = 16,
	GuildTrainingRank = 8,
	FlightChallengeBoss = 7,
	FlightGameRank = 6,
	EndlessPlusEXBossRank = 5,
	PlaceGameRank = 14,
	RestaurantOperationPuzzleGameRank = 13,
	RestaurantOperationExBossRank = 9,
	MazeEXBossRank = 2,
	RestaurantOperationFruitCleanGameRank = 12,
	AmusementParkRank = 19,
	RestaurantOperationCardGameRank = 11,
	HorizontalRPGMazeEXBossRank = 21
}
Constant.BattleBuffStatus = {
	SEAL_CORE_2 = 3,
	CD_STOP = 10,
	STEALTH = 9,
	SEAL_BEAT_BACK = 6,
	MUST_HIT = 15,
	MUST_CRIT = 16,
	SEAL_ULTIMATE = 4,
	CAN_NOT_BLOCK = 18,
	CAN_NOT_CRIT = 20,
	SEAL_NORMAL = 1,
	SEAL_STAND_BY = 7,
	IMMUNITY_ICE = 21,
	IMMUNITY_FIRE = 22,
	MUST_DODGE = 13,
	IMMUNITY_THUNDER = 23,
	IMMUNITY_DARK = 26,
	TAUNT = 27,
	CAN_NOT_HIT = 19,
	DMG_LINK = 11,
	ENERGY_LIMIT = 12,
	SEAL_DERIVATION = 8,
	SEAL_CORE = 2,
	IMMUNITY_POISON = 24,
	PLAY_DEAD = 28,
	STATUS_NUM = 29,
	MUST_BLOCK = 14,
	IMMUNITY_LIGHT = 25,
	CAN_NOT_DODGE = 17,
	SEAL_DEAD_RATTLE = 5,
	NONE = 0
}
Constant.SoulPrefab = {
	PositionFront = 1,
	PositionBack = 2
}
Constant.EquipSortType = {
	TypeQuality = 1,
	TypeStrengthenLv = 3,
	TypeHasNum = 5,
	TypeStar = 2,
	TypeCID = 4
}
Constant.Soul = {
	WorkStatusExploringMaze = 2,
	WorkStatusWorking = 1,
	WorkStatusNone = 0
}
Constant.Mall_ShowItem = {
	HouseItem = 3,
	MultiItem = 2,
	NoItem = 0,
	OneItem = 1
}
Constant.Mall_LimitType = {
	Day = 1,
	Week = 3,
	Month = 4,
	Life = 2
}
Constant.Mall_SellType = {
	Free = 0,
	RMB = 3,
	Item = 1,
	PayPoint = 2
}
Constant.Mall_EntranceType = {
	PlotChallenge = 7,
	FishingShop = 10,
	MiningShop = 15,
	DropExchange = 8,
	EndlessPlusMaze = 13,
	Dreamland = 5,
	AmusementParkShop = 19,
	SurvivalShop = 20,
	RestaurantOperationShop = 17,
	Guild = 14,
	MainCity = 1,
	HorizontalRPGShop = 21,
	Lottery = 2,
	Panda = 6,
	LU_NA_BATTLE = 4,
	PlaceGameShop = 18,
	RpgMaze = 3,
	FlightChallengeShop = 16,
	MagicTower = 9,
	MonsterAcademyShop = 12,
	DualTeamExploreShop = 11,
	FishingActivityShop = 22
}
Constant.L2D_CustomStateName = {
	NewMail = "NewMail",
	FlickHead = "FlickHead",
	LibraryAction = "LibraryAction",
	Gift = "Gift",
	PrivateChat = "PrivateChat",
	FavorUp = "FavorUp",
	TownPlot = "TownPlot",
	Dating = "Dating",
	SelectSoul = "SelectSoul",
	GirlAction = "GirlAction"
}
Constant.Lottery = {
	PoolTypeSingle = 1,
	UIBoxFlyDuration = 1,
	PoolTypeMust = 3,
	PoolTypeTen = 2
}
Constant.GestureType = {
	Scale = 5,
	Tap = 1,
	Pan = 4,
	LongPress = 3,
	DoubleTap = 2
}
Constant.DressType = {
	Portrait = 2,
	Entity = 1
}
Constant.PushMessage = {
	FullStrength = 1,
	AlchemicalHarvest = 3,
	FreePhysicalStrength = 2,
	TheTransactionCompleted = 4
}
Constant.Activity_ID = {
	Food = 2,
	NationalDay = 6,
	Turn = 3,
	MoonLogin = 4,
	MoonTip = 5,
	LuckyTurntable = 7,
	ReplacementPass = 8
}
Constant.Activity_Operation_Sate = {
	STATUS_CLOSED = 3,
	STATUS_END = 2,
	STATUS_STARTED = 1
}
Constant.Activity_Operation_Type = {
	Activity_WelcomeNew = 15,
	Activity_NewYear_Gift = 14,
	Activity_Paid_Challenge = 13,
	Activity_FurnitureGashapon = 9,
	Activity_NewCharacter = 4,
	Activity_Panda = 11,
	Activity_Free_Reward = 20,
	Activity_SpaceTreasure = 10,
	Activity_DropExchange = 17,
	Activity_Limited_Turn = 19,
	Activity_Sign = 6,
	Activity_Cup_Voting = 21,
	Activity_AlienInvasion = 7,
	Activity_PicturePuzzle = 2,
	Activity_PureExhibition = 16,
	Activity_MagicWaxMuseum = 3,
	Activity_GroupBuy = 1,
	Activity_GachaPool = 5,
	Activity_Vote = 12,
	Activity_Turn = 18,
	Activity_Luna_Front = 8
}
Constant.KeywordTag = "<keyword=%d+>.-</keyword>"
Constant.Dreamland = {
	ExecutionTypeUnlockMap = 8,
	ExecutionTypeGetSpeItem = 3,
	ExecutionTypeUnlockTask = 9,
	ExecutionTypeOpenDialog = 6,
	ExecutionTypeGetItem = 2,
	ExecutionTypeShowEntity = 1
}
Constant.CustomIgnoreType = {
	IllusionMazeSweep = 1
}
Constant.ExecutionType = {
	ExitTheMazeExecution = 223,
	MonsterAcademyGameOver = 118,
	OpenMonsterSelectPanelUI = 131,
	DropItem = 102
}
Constant.ExecutionShowType = {
	Dreamland = 1
}
Constant.DualTeamExploreExecutionType = {
	ChangeNodeData = 7,
	Drop = 5,
	Notice = 13,
	CameraAnimation = 8,
	Battle = 4,
	EndLevel = 15,
	InputNumber = 11,
	Maze = 12,
	Gather = 14,
	Assemble = 3,
	ChangeHP = 2,
	Dialog = 1,
	ChangeNextNode = 10,
	Transport = 6,
	ModifyPlayerParam = 9,
	SetTeamActive = 16
}
Constant.DualTeamExploreMoveResult = {
	NeedSeparate = 2,
	Occupied = 3,
	Fail = 1,
	Success = 0
}
Constant.DualTeamExploreClientState = {
	Gather = 1,
	QuickFight = 2
}
Constant.FishEffectType = {
	Fish_Reduce_Speed = 3,
	Fish_Completion = 4,
	Fish_Buoy_length = 5,
	Fish_Weight = 2,
	Fish_quantity = 1
}
Constant.PlotChallengeType = {
	Type_Challenge = 2,
	Type_Plot = 1
}
Constant.GalleryPermission = {
	ShouldAsk = 2,
	UnKnown = -1,
	Granted = 1,
	Denied = 0
}
Constant.SDKSharePlatform = {
	WECHAT_MOMENTS = 20004,
	QQ_ZONE = 20002,
	WECHAT = 20003,
	SINA = 20005,
	ALL = 20000,
	QQ = 20001
}
Constant.PayCid = {
	GrowthFund = 1078
}
Constant.GirlOnDutyShowType = {
	ShowType_LIVE2D = 1,
	ShowType_Spine = 2,
	ShowType_Oath = 3
}
Constant.GirlOnDutyType = {
	OnDuty_ByShift = 2,
	OnDuty_Board = 4,
	OnDuty_Random = 3,
	OnDuty_All = 1
}
Constant.CupVotingStage = {
	CupVoting_FinalsStage = 2,
	CupVoting_FinishState = 3,
	CupVoting_GroupStage = 0,
	CupVoting_EliminatedStage = 1
}
Constant.GuildFunctionType = {
	Guild_Build = 2,
	Guild_Members = 1,
	Guild_Task = 4,
	Guild_Shop = 5,
	Guild_Offer_A_Reward = 3,
	Guild_Sign = 6,
	Guild_Trial = 8,
	Guild_Board = 7
}
Constant.GuildPosition = {
	Guild_President = 2,
	Guild_Ordinary_Members = 0,
	Guild_Vice_President = 1
}
Constant.GuildBuildingType = {
	Guild_Building_Fight = 2,
	Guild_Building_Base = 1
}
Constant.GuildBuilding = {
	Guild_BuildingLV = 1001
}
Constant.ResourceTag = {
	Whisper = 10
}
Constant.Type = {
	String = "string",
	Function = "function",
	Nil = "nil",
	Table = "table",
	Boolean = "boolean",
	UserData = "userdata",
	Thread = "thread",
	Number = "number"
}
Constant.MiningPlantState = {
	Mining_Plant_Default = 0,
	Mining_Plant_Complete = 2,
	Mining_Plant_Have_Reward = 1
}
Constant.MiningElementType = {
	MiningElementType_Silver_Ore = 3,
	MiningElementType_Descending_Stairs = 6,
	MiningElementType_Treasure_Chest = 1,
	MiningElementType_Empty = 9,
	MiningElementType_Climbing_Stairs = 7,
	MiningElementType_Monster = 10,
	MiningElementType_Plot = 11,
	MiningElementType_Coin = 8,
	MiningElementType_Gold_Mine = 2,
	MiningElementType_Iron_Ore = 5,
	MiningElementType_Copper_Mine = 4
}
Constant.SingleWeakTowerType = {
	TowerType_Physical = 3,
	TowerType_Frost = 5,
	TowerType_Fire = 2,
	TowerType_Thunder = 4,
	TowerType_Magic = 1
}
Constant.ServerSettingKey = {
	AutoLockEquip = 1
}
Constant.PlaceGameEquipType = {
	PlaceGame_Field_Arms = 1,
	PlaceGame_Field_Jewelry = 3,
	PlaceGame_Field_Equipment = 2
}
