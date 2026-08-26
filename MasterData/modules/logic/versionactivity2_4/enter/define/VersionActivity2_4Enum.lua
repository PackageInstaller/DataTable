-- chunkname: @modules/logic/versionactivity2_4/enter/define/VersionActivity2_4Enum.lua

module("modules.logic.versionactivity2_4.enter.define.VersionActivity2_4Enum", package.seeall)

local VersionActivity2_4Enum = _M

VersionActivity2_4Enum.ActivityId = {
	WuErLiXi = 12406,
	Pinball = 12404,
	RoleStory1 = 12407,
	MusicGame = 12405,
	Season = 12400,
	ReactivityStore = 12408,
	BossRush = 12410,
	Tower = 12320,
	DungeonStore = 12403,
	Dungeon = 12402,
	EnterView = 12401,
	Rouge = 12409,
	Reactivity = VersionActivity1_8Enum.ActivityId.Dungeon,
	ReactivityFactory = VersionActivity1_8Enum.ActivityId.DungeonReturnToWork
}
VersionActivity2_4Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_4Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_4Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.Pinball,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.MusicGame,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_4Enum.ActivityId.MusicGame
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.WuErLiXi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_4Enum.ActivityId.WuErLiXi
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_4Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.Rouge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity2_4Enum.ActivityId.Rouge
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_4Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity2_4Enum.ActivityId.BossRush,
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
	}
}
VersionActivity2_4Enum.EnterViewActIdListWithRedDot = {}
VersionActivity2_4Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_4Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a4_mainactivity_singlebg/v2a4_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {}
	}
}
VersionActivity2_4Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_4Enum.RedDotOffsetY = 56
VersionActivity2_4Enum.SudokuEpisodeId = 2410103

return VersionActivity2_4Enum
