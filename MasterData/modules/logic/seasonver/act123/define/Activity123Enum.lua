-- chunkname: @modules/logic/seasonver/act123/define/Activity123Enum.lua

module("modules.logic.seasonver.act123.define.Activity123Enum", package.seeall)

local Activity123Enum = _M

Activity123Enum.ActType = 123
Activity123Enum.EmptyUid = "0"
Activity123Enum.TestActivityID = 11700
Activity123Enum.TestActivityStage = 1
Activity123Enum.PickHeroCount = 8
Activity123Enum.SupportPosIndex = 8
Activity123Enum.HeroCardNum = 2
Activity123Enum.MainCardNum = 1
Activity123Enum.TaskNormalType = 0
Activity123Enum.TaskRewardViewType = 1
Activity123Enum.CardPackageSubType = 22
Activity123Enum.RecordItemCount = 6
Activity123Enum.DisplayMark = 1
Activity123Enum.SeasonChapterId = 1201
Activity123Enum.SeasonEpisodeId = 120101
Activity123Enum.SeasonStageStepCount = 5
Activity123Enum.PreCondition = {
	OpenTime = 2,
	StagePass = 1
}
Activity123Enum.PlayerPrefsKeyItemUid = "Activity123ItemUid"
Activity123Enum.MainCharPos = 4
Activity123Enum.MainRoleHeroUid = "main_role"
Activity123Enum.isMainRole = 1
Activity123Enum.MainRoleHeadIconID = 300101
Activity123Enum.openAllCardPackage = -1
Activity123Enum.maxDecomposeCount = 100
Activity123Enum.Const = {
	StoryCoverTitle = 9,
	UttuTicketsCoin = 1,
	StoryCoverIconUrl = 3,
	HideRule = 10,
	EquipItemCoin = 2,
	StoryCoverDesc = 4,
	RetailOpenStage = 5,
	StoreActId = 7,
	StoreCoinId = 6
}
Activity123Enum.JumpId = {
	ForStage = 5,
	Trail = 4,
	MarketNoResult = 6,
	Retail = 2,
	Market = 1,
	MarketStageFinish = 7
}
Activity123Enum.JumpType = {
	Stage = 1
}
Activity123Enum.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
Activity123Enum.AnimRecord = {
	UnlockTweenPos = "UnlockTweenPos"
}
Activity123Enum.SceneFolderPath = "_m_s15_sj"
Activity123Enum.DefaultBackgroundPrefab = "_m_s15_background_a"
Activity123Enum.StageSceneAnim = {
	Switch = "switch",
	Idle = "idle",
	Close = "close",
	Open = "open"
}
Activity123Enum.SeasonID = {
	Season5 = 12115,
	Season2 = 11811,
	Season6 = 12315,
	Season1 = 11700,
	Season7 = 13513,
	Season4 = 12006,
	Season3 = 11906
}
Activity123Enum.SeasonIconFolder = {
	[Activity123Enum.SeasonID.Season1] = "v1a7_season_singlebg",
	[Activity123Enum.SeasonID.Season2] = "v1a8_season_singlebg",
	[Activity123Enum.SeasonID.Season3] = "v1a9_season_singlebg",
	[Activity123Enum.SeasonID.Season4] = "v2a0_season_singlebg",
	[Activity123Enum.SeasonID.Season5] = "v2a1_season_singlebg",
	[Activity123Enum.SeasonID.Season6] = "v2a3_season_singlebg",
	[Activity123Enum.SeasonID.Season7] = "v2a3_season_singlebg"
}
Activity123Enum.RuleTab = {
	Card = 2,
	Rule = 1
}
Activity123Enum.TaskHardType = {
	Hard = 2,
	Normal = 1
}
Activity123Enum.SeasonViewPrefix = {
	[Activity123Enum.SeasonID.Season1] = "",
	[Activity123Enum.SeasonID.Season2] = "_1_8",
	[Activity123Enum.SeasonID.Season3] = "_1_9",
	[Activity123Enum.SeasonID.Season4] = "_2_0",
	[Activity123Enum.SeasonID.Season5] = "_2_1",
	[Activity123Enum.SeasonID.Season6] = "_2_3",
	[Activity123Enum.SeasonID.Season7] = "_3_5"
}
Activity123Enum.SeasonVersionPrefix = {
	[Activity123Enum.SeasonID.Season1] = "1_7",
	[Activity123Enum.SeasonID.Season2] = "1_8",
	[Activity123Enum.SeasonID.Season3] = "1_9",
	[Activity123Enum.SeasonID.Season4] = "2_0",
	[Activity123Enum.SeasonID.Season5] = "2_1",
	[Activity123Enum.SeasonID.Season6] = "2_3",
	[Activity123Enum.SeasonID.Season7] = "3_5"
}
Activity123Enum.SeasonResourcePrefix = {
	[Activity123Enum.SeasonID.Season1] = "v1a7",
	[Activity123Enum.SeasonID.Season2] = "v1a8",
	[Activity123Enum.SeasonID.Season3] = "v1a9",
	[Activity123Enum.SeasonID.Season4] = "v2a0",
	[Activity123Enum.SeasonID.Season5] = "v2a1",
	[Activity123Enum.SeasonID.Season6] = "v2a3",
	[Activity123Enum.SeasonID.Season7] = "v3a5"
}
Activity123Enum.SeasonIconPrefix = {
	[Activity123Enum.SeasonID.Season7] = "v2a3"
}
Activity123Enum.EquipCardEffect = {
	AddHeroGroupCardSlot = 104,
	ReduceRoundCount = 107
}

return Activity123Enum
