-- chunkname: @modules/logic/defines/CurrencyEnum.lua

module("modules.logic.defines.CurrencyEnum", package.seeall)

local CurrencyEnum = _M

CurrencyEnum.CurrencyType = {
	Act145 = 1515,
	V3a3Dungeon = 3301,
	PartyGameStoreCoin = 3402,
	V1a6DungeonSkill = 1601,
	Act191 = 2702,
	ReactivityCurrency = 25,
	V2a4Dungeon = 2401,
	V1a9ToughEnter = 1902,
	V3a2Rouge = 3201,
	V2a3DouQuQu = 2302,
	Gold = 3,
	BossRushStore = 26,
	HeroExperience = 5,
	V3a9PartyGameStoreCoin = 3904,
	V2a6Dungeon = 2601,
	V1a6CachotCoin = 1603,
	V1a7Dungeon = 1701,
	SkinCard = 12,
	V1a8Dungeon = 1804,
	V3a8DouQuQu = 3803,
	V3a9Dungeon = 3901,
	TowerStore = 28,
	BulbCurrency = 2881,
	V3a10Dungeon = 38502,
	V1a9Dungeon = 1901,
	Act134Clue = 1414,
	V2a9Dungeon = 30501,
	V3a1DouQuQu = 3102,
	SurvivalCurrency = 3503,
	RoomTrade = 2202,
	Sodache = 3701,
	Act186 = 2503,
	LvHuEMen = 1201,
	RoomFishing = 3103,
	V2a5Dungeon = 2501,
	V1a5Dungeon = 1501,
	V1a8FactoryRawMat = 1811,
	V2a3Dungeon = 2301,
	V3a5Dungeon = 3501,
	RoleStory = 24,
	Act133 = 1413,
	Power = 4,
	DryForest = 1202,
	V3a2Dungeon = 3203,
	GlowingFilament = 7,
	V2a2Dungeon = 2201,
	FreeDiamondCoupon = 2,
	BlueSoul = 10,
	V3a4Dungeon = 3401,
	Competition = 6,
	OldTravelTicket = 27,
	Diamond = 1,
	V2a1Dungeon = 2101,
	V3a1Dungeon = 3101,
	V1a8FactoryPart = 1812,
	KeyCurrency = 2882,
	V2a0Dungeon = 2001,
	V3a0Dungeon = 3001,
	RoomCritterTrain = 280001,
	V2a8Dungeon = 2801,
	V1a6CachotCurrency = 1604,
	V1a6Dungeon = 1605,
	OrangeSoul = 11,
	V3a6Dungeon = 3601,
	Planet = 1301,
	LeiMiTeBei = 111,
	V2a7Dungeon = 2701,
	V3a8Dungeon = 3801,
	V1a5DungeonBuild = 1502,
	V3a7Dungeon = 3702
}
CurrencyEnum.SubType = {
	RoomFishingResourceItem = 3101
}
CurrencyEnum.AllCurrency = {
	CurrencyEnum.CurrencyType.Diamond,
	CurrencyEnum.CurrencyType.FreeDiamondCoupon,
	CurrencyEnum.CurrencyType.Gold,
	CurrencyEnum.CurrencyType.Power,
	CurrencyEnum.CurrencyType.HeroExperience,
	CurrencyEnum.CurrencyType.Competition,
	CurrencyEnum.CurrencyType.BlueSoul,
	CurrencyEnum.CurrencyType.OrangeSoul
}
CurrencyEnum.PayDiamondExchangeSource = {
	Store = 4,
	HUD = 1,
	SkinStore = 5,
	Summon = 3,
	Power = 2
}

return CurrencyEnum
