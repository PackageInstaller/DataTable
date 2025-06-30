-- chunkname: @IQIGame\\Definition\\ServerPOD.lua

local ItemShowPOD = {
	tag = 0,
	num = 0,
	cid = 0
}
local FormationEquipPOD = {
	star = 0,
	lv = 0,
	cid = 0
}
local FormationSoulPrefabPOD = {}
local FormationInfoPOD = {}
local FormationPOD = {}
local MazeInfoPOD = {}
local DailyDupPOD = {
	common = {
		status = 0,
		openDate = 0,
		openCount = 0,
		cid = 0
	}
}
local GirlPOD = {}
local LunaBattleLineDataPOD = {
	common = {
		status = 0,
		openDate = 0,
		openCount = 0,
		cid = 0,
		centerLunaBattleLineDataPOD = {}
	},
	lunaBattleLineDataPOD = {
		participation = 0
	}
}
local LunaBattleLineZonePOD = {
	zoneId = 0
}
local DreamMapPOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	dreamMapPOD = {
		spRewardsCount = 0
	}
}
local DreamMapDataPOD = {
	combo = 0,
	mapId = 0,
	currDialog = 0,
	roleY = 0,
	roleX = 0,
	resetCount = 0,
	movePo = 0
}
local DreamMapCellPOD = {
	showType = false,
	isOpen = false,
	elementId = 0,
	y = 0,
	markType = 0,
	dataId = 0,
	x = 0
}
local DreamMapExecutionItemPOD = {
	getMovePo = 0,
	getSpAwardId = 0,
	exectionId = 0
}
local DreamDropData = {}
local DualTeamExplorePOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	dualTeamExplorePOD = {
		currLevelCid = 0
	}
}
local DualTeamExploreLevelPOD = {}
local DualTeamExploreNodePOD = {}
local DualTeamExploreTeamPOD = {}
local MagicTowerPOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	magicTowerPOD = {}
}
local MagicTowerMapDataPOD = {}
local MagicTowerMapCellPOD = {}
local MagicTowerRolePOD = {}
local MagicTowerMapExecutionItemPOD = {}
local MonsterAcademyPOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	miniGalGameDataPOD = {
		saveList = {},
		achievementData = {}
	}
}
local MiniGalGameSavaDataPOD = {
	dayOfPhase = 0,
	slot = 0,
	gameOver = false,
	saveTime = 0,
	day = 0
}
local MiniGalGameSavaDataDetailPOD = {
	playthrough = 0,
	dialogId = 0,
	girls = {},
	taskList = {},
	shopRecord = {},
	items = {},
	scheduleList = {},
	towerRecord = {},
	triggeredCount = {},
	itemUsedCount = {},
	localAchievementData = {},
	messageGroupCount = {}
}
local MiniGalGameSchedulePOD = {
	functionId = 0,
	dayOfPhase = 0,
	areaId = 0,
	status = 0,
	id = 0,
	girlId = 0,
	day = 0
}
local MiniGalGameBasePOD = {
	dayOfPhase = 0,
	day = 0,
	areaList = {},
	baseProps = {}
}
local MiniGalGameCountPOD = {
	countId = 0,
	recordCountOfWeek = 0,
	recordCountOfTotal = 0,
	recordCountOfYear = 0,
	recordCountOfMonth = 0,
	recordCountOfDay = 0
}
local MiniGalGameGirlDataPOD = {
	favorAbility = 0,
	rejectCount = 0,
	callCount = 0,
	noShow = 0,
	phoneLock = 0,
	girlId = 0,
	messageGroups = {}
}
local MiniGalGameMessageGroupPOD = {
	id = 0,
	dayOfPhase = 0,
	day = 0,
	messageIds = {}
}
local MiniGalGameItemPOD = {
	itemId = 0,
	itemNum = 0
}
local EvilErosionPOD = {
	common = {
		status = 0,
		openDate = 0,
		openCount = 0,
		cid = 0
	},
	evilErosionPOD = {
		currLevel = 0
	}
}
local CenterEvilErosionPOD = {}
local EvilErosionSoulPrefabPOD = {}
local SoulOathPOD = {
	activation = false,
	dateData = {},
	countData = {}
}
local TurntableDataPOD = {
	dailyFreeDrawCount = 0
}
local EndlessPlusMazeDailyDupPOD = {
	common = {
		status = 0,
		openCount = 0,
		openDate = 0,
		cid = 0
	},
	abyssPlusPOD = {}
}
local LimitTurnTableDataPOD = {
	insureTimes = 0,
	getAwards = {}
}
local LimitTurnTableHistoryPOD = {
	time = 0,
	rewardId = 0
}
local CenterCupMatchVoteDataPOD = {
	knockoutTime = 0,
	stage = 0,
	finishTime = 0,
	finalTime = 0
}
local CupMatchVoteDataPOD = {
	tickets = 0
}
local GuildPOD = {
	impeachmentTime = 0,
	banNotice = false,
	notice = "",
	fund = 0,
	newAuditCount = 0,
	fundDailyGetRecord = 0,
	buildings = {},
	questProgress = {},
	members = {}
}
local GuildBasePOD = {
	id = 0,
	memberNum = 0,
	auditType = 0,
	memberMaxNum = 0,
	avatarFrame = 0,
	headIcon = 0,
	policy = 0,
	level = 0
}
local GuildBuildingPOD = {
	buyEffectExpTime = 0
}
local GuildMemberPOD = {
	joinTime = 0,
	score = 0,
	activeNum = 0,
	online = false,
	position = 0,
	lastLoginTime = 0
}
local GuildAuditPOD = {
	online = false,
	lastLoginTime = 0
}
local PlayerSimplePOD = {
	headIcon = 0,
	leaderCid = 0,
	vip = 0,
	serverId = 0,
	avatarFrame = 0,
	title = 0,
	guid = 0,
	showGirlDressId = 0,
	pLv = 0,
	guildId = 0
}
local CenterGuildChallengePOD = {
	bossType = 0,
	buffOrder = 0
}
local GuildChallengePOD = {
	currBossLevel = 0,
	getRewards = {}
}
local CenterGuildTrainingPlayerRankPOD = {
	pid = "",
	name = ""
}
local GuildTrainingPOD = {
	getAward = {}
}
local CenterGuildTrainingPOD = {}
local ChatRoomPOD = {
	roomNumber = 0,
	onlineCount = 0,
	msg = {}
}
local CChatPOD = {
	target = "",
	content = "",
	channel = 0,
	type = 0
}
local SChatPOD = {
	target = "",
	content = "",
	time = 0,
	type = 0,
	sender = 0,
	channel = 0
}
local MiningPOD = {
	floorNow = 0,
	dialogId = 0,
	floorMax = 0
}
local MiningLayerPOD = {
	floor = 0,
	grids = {}
}
local MiningGridPOD = {
	state = 0,
	skinId = 0,
	y = 0,
	dataCid = 0,
	x = 0
}
local SingleWeakTowerPOD = {
	towerFloor = {}
}
local FlightChallengePOD = {
	record = 0,
	flightChallengeMechas = {}
}
local FlightChallengeMechaPOD = {
	id = 0,
	growthAttribute = {},
	firingSpeed = {}
}
local RankingPOD = {
	pid = "",
	customData = "",
	name = "",
	serverId = "",
	userData = ""
}
local RestaurantOperationPOD = {
	exBossLock = false,
	combatTraining = {},
	event = {}
}
local RestaurantOperationEventPOD = {
	date = 0,
	value = 0,
	status = false,
	id = 0,
	achievement = false
}
local RestaurantOperationAttributePOD = {
	allAtt = 0,
	dialogId = 0,
	level = 0,
	postInfo = {},
	positionInformation = {},
	income = {},
	plot = {}
}
local PostPOD = {
	restaurantMarkUp = 0,
	type = 0,
	value = 0,
	number = 0,
	positionInformation = {}
}
local PostFigurePOD = {
	location = 0
}
local PositionInformationPOD = {
	postType = 0,
	count = 0,
	location = 0,
	id = 0,
	att = {}
}
local RestaurantOperationQuestionPOD = {
	state = 0,
	rightNumber = 0,
	date = 0,
	id = 0,
	number = 0
}
local RestaurantOperationDrawPOD = {
	id = 0,
	cumulativeSteps = 0,
	time = 0
}
local RestaurantOperationLinkGamePOD = {
	id = 0,
	time = 0
}
local PlaceGamePOD = {
	award = 0,
	customs = 0,
	placeGameSoulPODs = {},
	placeGameFormationPODs = {},
	placeGameSoulPrefabPODs = {},
	firingSoulPODs = {},
	plot = {}
}
local PlaceGameDollPOD = {
	experience = 0,
	level = 1
}
local PlaceGameFormationPOD = {
	id = 0,
	name = "",
	index = 0,
	formation = {}
}
local PlaceGameSoulPrefabPOD = {
	formationPos = 0,
	position = 1,
	soulCid = 0,
	id = 0,
	power = 0,
	lv = 0,
	attr = {},
	equipments = {}
}
local PlaceGameEquipPOD = {
	lock = false,
	level = 0,
	property = {},
	pAbilityIDEffect1 = {},
	pAbilityIDEffect2 = {}
}
local PlaceGamePropertyPOD = {
	id = 0,
	value = 0
}
local AmusementParkPOD = {
	numberOfReturns = 0,
	exBossIsLock = false,
	event = {}
}
local AmusementParkEventPOD = {
	status = false,
	date = 0,
	value = 0,
	eventCfgId = 0,
	achievement = false
}
local AmusementParkInfoPOD = {
	dialogId = 0,
	postList = {},
	unitList = {},
	amusementParkVoRoles = {},
	amusementParkVoRolesHave = {},
	boss = {},
	plot = {}
}
local AmusementParkAttPOD = {
	number = 0,
	level = 0,
	attr = {}
}
local AmusementParkLandPOD = {
	post = 0,
	unitID = 0,
	level = 0,
	property = {},
	doll = {},
	roleAdd = {}
}
local AmusementParkVoRolePOD = {
	id = 0,
	status = false,
	level = 0,
	attr = {}
}
local AmusementParkVoCachePOD = {
	unit = 0,
	post = 0
}
local AmusementParkGameShowInfoPOD = {
	score = 0,
	level = 0
}
local NewJewelryEquipmentVoPOD = {
	star = 0,
	soul = {}
}
local SurvivalPOD = {
	dialogId = 0,
	level = 1,
	pass = {}
}
local SurvivalPassStatusPOD = {
	id = 0,
	award = {}
}
local HorizontalRPGPOD = {
	tickets = 0,
	weather = 0,
	exBoss = false,
	freeChallengeBossCount = 0,
	starUpperLimit = 0,
	dialog = 0,
	star = 0,
	levelDialog = 0,
	task = {},
	taskTips = {},
	boss = {},
	killBoss = {},
	dolls = {},
	finnishLevels = {},
	unlockedDifficulty = {}
}
local HorizontalRPGMapPOD = {
	id = 0,
	region = 0,
	currLevelCid = 0,
	born = 0
}
local HorizontalRPGResPOD = {
	elementId = 0,
	id = 0,
	type = 0
}
local HorizontalRPGElementPOD = {
	id = 0,
	effect = 0
}
local FishingActivityPOD = {
	totalWeight = 0,
	autoFishingRewardsTime = 0,
	roleLevel = 0,
	book = {},
	getStoryList = {},
	skillLevel = {},
	actionLevel = {}
}
local FishingActivityItemPOD = {
	fishId = 0,
	num = 0,
	weight = 0
}
