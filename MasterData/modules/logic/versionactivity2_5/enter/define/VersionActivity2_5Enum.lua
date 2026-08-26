-- chunkname: @modules/logic/versionactivity2_5/enter/define/VersionActivity2_5Enum.lua

module("modules.logic.versionactivity2_5.enter.define.VersionActivity2_5Enum", package.seeall)

local VersionActivity2_5Enum = _M

VersionActivity2_5Enum.ActivityId = {
	Challenge = 12505,
	LanternFestival = 12520,
	RoleStory1 = 12517,
	Act186Sign = 12519,
	FeiLinShiDuo = 12513,
	BossRush = 12516,
	ReactivityStore = 12514,
	Act186 = 12518,
	DungeonStore = 12503,
	AutoChess = 12504,
	Dungeon = 12502,
	LiangYue = 12512,
	EnterView = 12501,
	Reactivity = VersionActivity1_6Enum.ActivityId.Dungeon
}
VersionActivity2_5Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_5Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_5Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_5Enum.ActivityId.Challenge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_5Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_5Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity2_5Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_5Enum.ActivityId.LiangYue,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_5Enum.ActivityId.FeiLinShiDuo,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_5Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
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
		actId = VersionActivity2_5Enum.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity2_5Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_5Enum.ActivityId.Dungeon
}
VersionActivity2_5Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_5Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a5_mainactivity_singlebg/v2a5_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_5Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a5_mainactivity_singlebg/v2a5_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_5Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_5Enum.RedDotOffsetY = 56

return VersionActivity2_5Enum
