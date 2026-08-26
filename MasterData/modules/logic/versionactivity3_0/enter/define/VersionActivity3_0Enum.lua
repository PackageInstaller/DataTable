-- chunkname: @modules/logic/versionactivity3_0/enter/define/VersionActivity3_0Enum.lua

module("modules.logic.versionactivity3_0.enter.define.VersionActivity3_0Enum", package.seeall)

local VersionActivity3_0Enum = _M

VersionActivity3_0Enum.ActivityId = {
	BossRush = 13016,
	ReactivityStore = 13010,
	RoleStory1 = 13004,
	MaLiAnNa = 13011,
	Season = 13000,
	KaRong = 13015,
	DungeonStore = 13008,
	Dungeon = 13007,
	SeasonStore = 13003,
	EnterView = 13006,
	ActivityDrop = 13009,
	Reactivity = VersionActivity2_1Enum.ActivityId.Dungeon,
	StoryDeduction = VersionActivity2_1Enum.ActivityId.StoryDeduction
}
VersionActivity3_0Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_0Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_0Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_0Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity3_0Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity3_0Enum.ActivityId.MaLiAnNa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_0Enum.ActivityId.KaRong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity3_0Enum.ActivityId.KaRong
	},
	{
		actId = VersionActivity3_0Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_0Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity3_0Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_0Enum.ActivityId.ReactivityStore
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
VersionActivity3_0Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_0Enum.ActivityId.Dungeon
}
VersionActivity3_0Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#FFFFFF99",
		act2TabImg = {
			[VersionActivity3_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a0_mainactivity_singlebg/v3a0_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#FFFFFF24",
		act2TabImg = {
			[VersionActivity3_0Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a0_mainactivity_singlebg/v3a0_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity3_0Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_0Enum.RedDotOffsetY = 56
VersionActivity3_0Enum.RedDotOffsetX = 10
VersionActivity3_0Enum.EnterLoopVideoName = "3_0_loop"
VersionActivity3_0Enum.EnterAnimVideoName = "3_0_enter"
VersionActivity3_0Enum.EnterVideoDayKey = "v3a0_EnterVideoDayKey"

return VersionActivity3_0Enum
