-- chunkname: @modules/logic/versionactivity2_8/enter/define/VersionActivity2_8Enum.lua

module("modules.logic.versionactivity2_8.enter.define.VersionActivity2_8Enum", package.seeall)

local VersionActivity2_8Enum = _M

VersionActivity2_8Enum.ActivityId = {
	MoLiDeEr = 12811,
	Survival = 12806,
	RoleStory1 = 12805,
	Dungeon = 12802,
	Season = 12618,
	NuoDiKa = 12810,
	DungeonBoss = 12812,
	DungeonStore = 12803,
	AutoChess = 12807,
	BossRush = 12617,
	Challenge = 12813,
	EnterView = 12801,
	ActivityDrop = 12804
}
VersionActivity2_8Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_8Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_8Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_8Enum.ActivityId.Survival,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_8Enum.ActivityId.RoleStory1
		},
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Multi
	},
	{
		actId = VersionActivity2_8Enum.ActivityId.MoLiDeEr,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_8Enum.ActivityId.NuoDiKa,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_8Enum.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_8Enum.ActivityId.Challenge,
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
VersionActivity2_8Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_8Enum.ActivityId.Dungeon
}
VersionActivity2_8Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a8_mainactivity_singlebg/v2a8_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a8_mainactivity_singlebg/v2a8_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity2_8Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_8Enum.RedDotOffsetY = 56

return VersionActivity2_8Enum
