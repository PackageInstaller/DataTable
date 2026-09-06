-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/youtharenathird/data/YouthArenaThirdEnum.lua

module("logic.extensions.youtharenathird.data.YouthArenaThirdEnum", package.seeall)

local YouthArenaThirdEnum = {}

YouthArenaThirdEnum.TabState = {
	End = 3,
	Lock = 1,
	Open = 2
}
YouthArenaThirdEnum.TabPromotionState = {
	Out = 2,
	In = 1,
	None = 0
}
YouthArenaThirdEnum.TabKey = {
	ScoreMatch = "scoreMatch",
	ChampionScoreMatch = "championScoreMatch",
	ChampionKnockout = "championKnockout",
	Fun = "fun",
	Qualifier = "qualifier"
}
YouthArenaThirdEnum.BattleMode = {
	Three = 2,
	One = 1
}
YouthArenaThirdEnum.ReportVideoExpireSeconds = 1209600
YouthArenaThirdEnum.RoundType = {
	ScoreMatch = "SCORE_MATCH",
	Display = "DISPLAY",
	Top16Knockout = "TOP_16_KNOCKOUT",
	Qualify = "QUALIFY",
	Top8ScoreMatch3v3 = "TOP_8_SCORE_MATCH_3V3",
	Top8ScoreMatch1v1 = "TOP_8_SCORE_MATCH_1V1",
	CommonKnockout = "COMMON_KNOCKOUT"
}
YouthArenaThirdEnum.ChampionScoreRoundTypeMap = {
	[YouthArenaThirdEnum.RoundType.Top8ScoreMatch1v1] = true,
	[YouthArenaThirdEnum.RoundType.Top8ScoreMatch3v3] = true
}
YouthArenaThirdEnum.MatchStepId = {
	ScoreMatch = 2,
	Fun = 9999999,
	Qualifier = 1
}
YouthArenaThirdEnum.RankStage = {
	ScoreMatch = 2,
	ChampionScore = 3,
	Qualifier = 1
}
YouthArenaThirdEnum.RankType = {
	PetWinRate = 2,
	PetUse = 3,
	PlayerScore = 1
}
YouthArenaThirdEnum.TimeStepId = {
	KnockoutStart = 3,
	QualifierStart = 1,
	ScoreMatchStart = 2
}
YouthArenaThirdEnum.ChampionRoundId = {
	KnockoutEnd = 6,
	KnockoutStart = 3
}
YouthArenaThirdEnum.ChampionKnockoutTabKey = {
	MySchedule = "mySchedule",
	Round128To16 = "round128To16",
	ScheduleRoot = "scheduleRoot",
	Round16To8 = "round16To8"
}
YouthArenaThirdEnum.ChampionKnockoutDefaultLeaf = {
	NotStart = 1,
	Ended = 2
}
YouthArenaThirdEnum.ChampionKnockoutTabCfg = {
	{
		secTabId = 0,
		tabName = "我的赛程",
		roundId = 0,
		viewName = "youtharenathirdchampionmyscheduleview",
		headTabId = 1,
		tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey.MySchedule
	},
	{
		secTabId = 0,
		tabName = "比赛赛程",
		roundId = 0,
		headTabId = 2,
		tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey.ScheduleRoot
	},
	{
		secTabId = 1,
		tabName = "128进16",
		viewName = "youtharenathirdchampionraceroundview",
		headTabId = 2,
		tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey.Round128To16,
		roundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutStart
	},
	{
		secTabId = 2,
		tabName = "16进8",
		viewName = "youtharenathirdchampionquarterfinalistsview",
		headTabId = 2,
		tabKey = YouthArenaThirdEnum.ChampionKnockoutTabKey.Round16To8,
		roundId = YouthArenaThirdEnum.ChampionRoundId.KnockoutEnd
	}
}
YouthArenaThirdEnum.ChampionScoreTabKey = {
	MySchedule = "scoreMySchedule",
	Score3v3Root = "score3v3Root",
	Score1v1Root = "score1v1Root"
}
YouthArenaThirdEnum.ChampionScoreTabGroupCfg = {
	{
		modeName = "1v1",
		rootName = "1v1积分赛",
		rootKey = YouthArenaThirdEnum.ChampionScoreTabKey.Score1v1Root,
		roundType = YouthArenaThirdEnum.RoundType.Top8ScoreMatch1v1,
		mode = YouthArenaThirdEnum.BattleMode.One
	},
	{
		modeName = "3v3",
		rootName = "3v3积分赛",
		rootKey = YouthArenaThirdEnum.ChampionScoreTabKey.Score3v3Root,
		roundType = YouthArenaThirdEnum.RoundType.Top8ScoreMatch3v3,
		mode = YouthArenaThirdEnum.BattleMode.Three
	}
}

return YouthArenaThirdEnum
