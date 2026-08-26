-- chunkname: @modules/logic/versionactivity3_3/arcade/define/ArcadeEnum.lua

module("modules.logic.versionactivity3_3.arcade.define.ArcadeEnum", package.seeall)

local ArcadeEnum = _M

ArcadeEnum.ConstId = {
	HpColorList = 15,
	CharacterDefaultGamePos = 12,
	HallGridSize = 4,
	NegativeRoundLimit = 37,
	SubScoreInRound = 8,
	DiamondDifficultyFactor = 18,
	HpBarScale = 16,
	MaxShowHpCount = 13,
	GameGridSize = 27,
	NextStepTimeMS = 5,
	TargetAddSkillEnergy = 10,
	ExtraMonsterId = 28,
	GameSceneAnimationControllerRes = 46,
	PortalDefaultCol = 7,
	TalkIntervalTime = 35,
	DefaultEquipedHero = 1,
	GameSceneResName = 45,
	DiamondAddCount = 17,
	DangerWarningKeepTime = 47,
	ReturnRewardIntervalTime = 48,
	GameUIGridSize = 41,
	FlyingEffectTime = 42,
	CorpseKeepTime = 6,
	DefaultHallHeroPos = 3,
	HpItemSpace = 14,
	FirstGameGuideList = 36,
	CassetteAddCount = 19,
	StoreRoomResetTimes = 25,
	CharacterTurnWaitTime = 39,
	EntityTurnWaitTime = 40,
	CassetteDifficultyFactor = 20,
	RoundBeginWaitTime = 38,
	GameGridStartPos = 26,
	GuaranteePortal = 44,
	TargetAddScore = 9,
	AreaPortalId = 11,
	FlyingEffectOffsetY = 43
}
ArcadeEnum.AttributeConst = {
	Cassette = 207,
	DiamondCount = 202,
	CoinCount = 201,
	BombCount = 204
}
ArcadeEnum.CurrencyParams = {
	[ArcadeEnum.AttributeConst.CoinCount] = {
		nameConst = 29,
		icon = "v3a3_eliminate_currency2",
		descConst = 30
	},
	[ArcadeEnum.AttributeConst.DiamondCount] = {
		nameConst = 31,
		icon = "v3a3_eliminate_currency3",
		descConst = 32
	},
	[ArcadeEnum.AttributeConst.Cassette] = {
		nameConst = 33,
		icon = "v3a3_eliminate_currency1",
		descConst = 34
	}
}
ArcadeEnum.BlockKey = {
	LoadGameScene = "ArcadeLoadGameSceneBlockKey",
	LoadHallScene = "ArcadeLoadHallSceneBlockKey",
	ResultView = "ArcadeResultViewBlockKey",
	ChangingRoom = "ArcadeChangingRoomBlockKey"
}
ArcadeEnum.SceneResUrl = "scenes/v3a3_m_s12_bf/prefab/%s.prefab"
ArcadeEnum.Direction = {
	Down = 2,
	Up = 1,
	Left = 3,
	Right = 4
}
ArcadeEnum.DirChangeGridX = {
	[ArcadeEnum.Direction.Left] = -1,
	[ArcadeEnum.Direction.Right] = 1
}
ArcadeEnum.DirChangeGridY = {
	[ArcadeEnum.Direction.Up] = 1,
	[ArcadeEnum.Direction.Down] = -1
}
ArcadeEnum.Dir2RotationVal = {
	[ArcadeEnum.Direction.Up] = 90,
	[ArcadeEnum.Direction.Down] = 270,
	[ArcadeEnum.Direction.Left] = 180,
	[ArcadeEnum.Direction.Right] = 0
}
ArcadeEnum.HandBookType = {
	Floor = "floor",
	Item = "item",
	Monster = "monster",
	Character = "character"
}
ArcadeEnum.HandBookParams = {
	[ArcadeEnum.HandBookType.Character] = {
		DetailTitle = "arcade_hankbook_detail_character",
		InfoType = 1,
		sort = 1,
		MO = ArcadeHandBookCharacterMO
	},
	[ArcadeEnum.HandBookType.Monster] = {
		DetailTitle = "arcade_hankbook_detail_monster",
		InfoType = 4,
		sort = 2,
		MO = ArcadeHandBookMonsterMO
	},
	[ArcadeEnum.HandBookType.Item] = {
		DetailTitle = "arcade_hankbook_detail_item",
		InfoType = 2,
		sort = 3,
		MO = ArcadeHandBookItemMO
	},
	[ArcadeEnum.HandBookType.Floor] = {
		DetailTitle = "arcade_hankbook_detail_floor",
		InfoType = 3,
		sort = 4,
		MO = ArcadeHandBookFloorMO
	}
}
ArcadeEnum.HandBookItemParams = {
	MinSize = 128,
	RowCount = 3,
	StartY = 6,
	StartX = 16,
	SpaceY = 100,
	MaxWidth = 580,
	DiffY = 100,
	DiffX = 30,
	SpaceX = 22
}
ArcadeEnum.AttributeType = {
	Defense = 102,
	Attack = 101,
	Hp = 103
}
ArcadeEnum.AttributeParams = {
	[ArcadeEnum.AttributeType.Attack] = {
		Sort = 1,
		Icon = "v3a3_eliminate_baseicon_3"
	},
	[ArcadeEnum.AttributeType.Defense] = {
		Sort = 2,
		Icon = "v3a3_eliminate_baseicon_2"
	},
	[ArcadeEnum.AttributeType.Hp] = {
		Sort = 3,
		Icon = "v3a3_eliminate_heart_2"
	}
}
ArcadeEnum.EffectType = {
	Bomb = 2,
	Skill = 1,
	Collection = 3,
	Weapon = 4
}
ArcadeEnum.EffectParam = {
	[ArcadeEnum.EffectType.Skill] = {
		tipLineColor = "#88A598",
		tipBg = "v3a3_eliminate_game_tipsbg1",
		tipNameColor = "#DCEAE0"
	},
	[ArcadeEnum.EffectType.Bomb] = {
		tipLineColor = "#88A09C",
		tipBg = "v3a3_eliminate_game_tipsbg2",
		tipNameColor = "#E8F1EF"
	},
	[ArcadeEnum.EffectType.Collection] = {},
	[ArcadeEnum.EffectType.Weapon] = {
		tipLineColor = "#A49BB9",
		tipBg = "v3a3_eliminate_game_tipsbg3",
		tipNameColor = "#E6E0F2"
	}
}
ArcadeEnum.CollectionType = {
	Weapon = "weapon",
	Jewelry = "jewelry"
}
ArcadeEnum.Unknown = "???"
ArcadeEnum.TipType = {
	Building = 1,
	Skill = 4,
	Collection = 2,
	Hero = 3,
	Currency = 5
}
ArcadeEnum.MapCameraSize = 5
ArcadeEnum.PrefabPath = "ui/viewres/versionactivity_3_3/v3a3_eliminate"
ArcadeEnum.BuildingTipsViewRes = ArcadeEnum.PrefabPath .. "/tips/v3a3_eliminate_buildingtipsview.prefab"
ArcadeEnum.CollectionTipsViewRes = ArcadeEnum.PrefabPath .. "/tips/v3a3_eliminate_collectiontipsview.prefab"
ArcadeEnum.HeroTipsViewRes = ArcadeEnum.PrefabPath .. "/tips/v3a3_eliminate_herotipsview.prefab"
ArcadeEnum.SkillTipsViewRes = ArcadeEnum.PrefabPath .. "/tips/v3a3_eliminate_skilltipsview.prefab"
ArcadeEnum.CurrencyTipsViewRes = ArcadeEnum.PrefabPath .. "/tips/v3a3_eliminate_currencytipsview.prefab"
ArcadeEnum.ExitHallLoadView = ArcadeEnum.PrefabPath .. "/v3a3_eliminate_excessive.prefab"
ArcadeEnum.TipParams = {
	[ArcadeEnum.TipType.Building] = {
		View = ArcadeBuildingTipsView,
		ViewRes = ArcadeEnum.BuildingTipsViewRes
	},
	[ArcadeEnum.TipType.Collection] = {
		View = ArcadeCollectionTipsView,
		ViewRes = ArcadeEnum.CollectionTipsViewRes
	},
	[ArcadeEnum.TipType.Hero] = {
		View = ArcadeHeroTipsView,
		ViewRes = ArcadeEnum.HeroTipsViewRes
	},
	[ArcadeEnum.TipType.Skill] = {
		View = ArcadeSkillTipsView,
		ViewRes = ArcadeEnum.SkillTipsViewRes
	},
	[ArcadeEnum.TipType.Currency] = {
		View = ArcadeCurrencyTipsView,
		ViewRes = ArcadeEnum.CurrencyTipsViewRes
	}
}
ArcadeEnum.RewardItemStatus = {
	Gained = 2,
	CanGet = 1,
	Normal = 0
}
ArcadeEnum.TalentType = {
	Simple = "simple",
	Complicated = "complicated"
}
ArcadeEnum.ReddotType = {
	Normal = 1,
	New = 2,
	None = -1
}
ArcadeEnum.PlayerPrefsKey = {
	HankBookNew = "HankBookNew",
	HallNPCFirst = "HallNPCFirst",
	DevolopHeroPlayUnlockAnim = "DevolopHeroPlayUnlockAnim",
	DevolopHeroNew = "DevolopHeroNew"
}
ArcadeEnum.ActionShow = {
	Born = 1,
	Move = 2
}
ArcadeEnum.StateShow = {
	Idle = 1
}
ArcadeEnum.HeartIcon = {
	"v3a3_eliminate_heart_2",
	"v3a3_eliminate_heart_4",
	"v3a3_eliminate_heart_5",
	"v3a3_eliminate_heart_3",
	"v3a3_eliminate_heart_1"
}
ArcadeEnum.HeartShowCount = 4

return ArcadeEnum
