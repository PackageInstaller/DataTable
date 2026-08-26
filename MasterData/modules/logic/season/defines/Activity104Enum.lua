-- chunkname: @modules/logic/season/defines/Activity104Enum.lua

module("modules.logic.season.defines.Activity104Enum", package.seeall)

local Activity104Enum = _M

Activity104Enum.SeasonChapterId = 1201
Activity104Enum.SeasonEpisodeId = 120101
Activity104Enum.SeasonType = {
	Season5 = 11500,
	Season2 = 11200,
	Season6 = 11600,
	Season1 = 11100,
	SeasonV3A0 = 13000,
	Season4 = 11400,
	Season3 = 11300
}
Activity104Enum.SeasonStore = {
	[Activity104Enum.SeasonType.Season1] = 11115,
	[Activity104Enum.SeasonType.Season2] = 11210,
	[Activity104Enum.SeasonType.Season3] = 11308,
	[Activity104Enum.SeasonType.Season4] = 11410,
	[Activity104Enum.SeasonType.Season5] = 11512,
	[Activity104Enum.SeasonType.Season6] = 11607,
	[Activity104Enum.SeasonType.SeasonV3A0] = 13003
}
Activity104Enum.StoreUTTU = {
	[Activity104Enum.SeasonType.Season1] = 1112,
	[Activity104Enum.SeasonType.Season2] = 1212,
	[Activity104Enum.SeasonType.Season3] = 1312,
	[Activity104Enum.SeasonType.Season4] = 1412,
	[Activity104Enum.SeasonType.Season5] = 1512,
	[Activity104Enum.SeasonType.Season6] = 1612,
	[Activity104Enum.SeasonType.SeasonV3A0] = 3012
}
Activity104Enum.SeasonViewPrefix = {
	[Activity104Enum.SeasonType.Season1] = "",
	[Activity104Enum.SeasonType.Season2] = "1_2",
	[Activity104Enum.SeasonType.Season3] = "1_3",
	[Activity104Enum.SeasonType.Season4] = "1_4",
	[Activity104Enum.SeasonType.Season5] = "1_5",
	[Activity104Enum.SeasonType.Season6] = "1_6",
	[Activity104Enum.SeasonType.SeasonV3A0] = "3_0"
}
Activity104Enum.SeasonIconFolder = {
	[Activity104Enum.SeasonType.Season3] = "v1a3_season",
	[Activity104Enum.SeasonType.Season4] = "v1a4_season",
	[Activity104Enum.SeasonType.Season5] = "v1a5_season",
	[Activity104Enum.SeasonType.Season6] = "v1a6_season",
	[Activity104Enum.SeasonType.SeasonV3A0] = "v3a0_season"
}
Activity104Enum.CurSeasonId = Activity104Enum.SeasonType.SeasonV3A0
Activity104Enum.BuffType = {
	Buff = 2,
	Debuff = 1
}
Activity104Enum.RuleTab = {
	Card = 2,
	Rule = 1
}
Activity104Enum.CareerType = {
	Shou = "4",
	Ling_Or_Zhi = "5",
	Xing = "2",
	Mu = "3",
	Yan = "1"
}
Activity104Enum.PlayerPrefsKeyItemUid = "Activity104ItemUid"
Activity104Enum.Rare_Orange = 4
Activity104Enum.MainRoleRare = 5
Activity104Enum.MainRoleHeadIconID = 300101
Activity104Enum.MainRoleSkinPath = "560501_vertin"
Activity104Enum.JumpId = {
	Market = 1,
	Discount = 3,
	Trail = 4,
	Retail = 2
}
Activity104Enum.ConstEnum = {
	BlueToPurple = 2,
	LastSeasonId = 12,
	ReadProcessHead = 6,
	ReadProcessLayer = 5,
	StoryCoverIconUrl = 16,
	RetailTicket = 1,
	SumMailLangKey = 15,
	SumReviewChapter = 13,
	StoryCoverTitle = 18,
	PurpleToGold = 3,
	GoldToOrange = 4,
	StoryCoverDesc = 17,
	SumReviewCard = 14,
	SpecialOpenLayer = 8,
	SpecialOpenDayCount = 7,
	RuleTips = 11,
	RetailGuidePos = 10,
	SeasonOpenStorys = 9
}
Activity104Enum.ViewName = {
	RetailView = "RetailView",
	SettlementView = "SettlementView",
	CelebrityCardTipView = "CelebrityCardTipView",
	FightSuccView = "FightSuccView",
	MainView = "MainView",
	MarketView = "MarketView",
	HeroGroupFightView = "HeroGroupFightView",
	CelebrityCardGetlView = "CelebrityCardGetlView",
	FightFailView = "FightFailView",
	StoryView = "StoryView",
	EquipHeroView = "EquipHeroView",
	EquipBookView = "EquipBookView",
	EquipSelfChoiceView = "EquipSelfChoiceView",
	StoryPagePopView = "StoryPagePopView",
	StoreView = "StoreView",
	RetailLevelInfoView = "RetailLevelInfoView",
	SumView = "SumView",
	AdditionRuleTipView = "AdditionRuleTipView",
	EquipView = "EquipView",
	SpecialMarketView = "SpecialMarketView",
	FightRuleTipView = "FightRuleTipView",
	TaskView = "TaskView"
}

return Activity104Enum
