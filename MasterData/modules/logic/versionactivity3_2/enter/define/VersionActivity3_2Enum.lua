-- chunkname: @modules/logic/versionactivity3_2/enter/define/VersionActivity3_2Enum.lua

module("modules.logic.versionactivity3_2.enter.define.VersionActivity3_2Enum", package.seeall)

local VersionActivity3_2Enum = _M

VersionActivity3_2Enum.ActivityId = {
	BossRush = 13230,
	BpOperAct = 13225,
	RoleStory = 13227,
	Rouge2 = 13209,
	ActivityCollect = 13232,
	CruiseGame = 13217,
	CruiseMain = 13212,
	BeiLiEr = 13231,
	CruiseTripleDrop = 13216,
	EnterView = 13222,
	CruiseGlobalTask = 13213,
	HuiDiaoLan = 13229,
	CruiseSelfTask = 13215,
	DungeonStore = 13224,
	AutoChess = 13211,
	Dungeon = 13223,
	ReactivityStore = 13114,
	CruiseOpenCeremony = 13214,
	Reactivity = VersionActivity2_4Enum.ActivityId.Dungeon
}
VersionActivity3_2Enum.CharacterActId = {
	[VersionActivity3_2Enum.ActivityId.BeiLiEr] = true,
	[VersionActivity3_2Enum.ActivityId.HuiDiaoLan] = true
}
VersionActivity3_2Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_2Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_2Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.BeiLiEr,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.HuiDiaoLan,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_2Enum.ActivityId.Rouge2,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkDeepShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkDeepShow
	},
	{
		actId = ActivityEnum.Activity.Tower,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	}
}
VersionActivity3_2Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_2Enum.ActivityId.Dungeon
}
VersionActivity3_2Enum.TabSetting = {
	select = {
		fontSize = 28,
		cnColor = "#D4CCB8",
		enFontSize = 16,
		enColor = "#898268",
		act2TabImg = {}
	},
	unselect = {
		fontSize = 28,
		cnColor = "#BCB5A2",
		enFontSize = 16,
		enColor = "#5B554B",
		act2TabImg = {}
	}
}
VersionActivity3_2Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_2Enum.RedDotOffsetY = 56
VersionActivity3_0Enum.RedDotOffsetX = 10
VersionActivity3_2Enum.EnterLoopVideoName = "v3a2_kv_loop"
VersionActivity3_2Enum.EnterAnimVideoName = "v3a2_kv_open"
VersionActivity3_2Enum.EnterVideoDayKey = "v3a2_EnterVideoDayKey"

return VersionActivity3_2Enum
