-- chunkname: @modules/logic/versionactivity3_5/enter/define/VersionActivity3_5Enum.lua

module("modules.logic.versionactivity3_5.enter.define.VersionActivity3_5Enum", package.seeall)

local VersionActivity3_5Enum = _M

VersionActivity3_5Enum.ActivityId = {
	ReactivityStore = 13504,
	BpOperAct = 13507,
	BossRush = 13519,
	Lorentz = 13510,
	Season = 13513,
	RoleStory = 13508,
	ActivityCollect = 13518,
	Survival = 13523,
	DungeonStore = 13503,
	AutoChess = 13511,
	Dungeon = 13502,
	SeasonStore = 13514,
	EnterView = 13501,
	Lamona = 13505,
	Reactivity = VersionActivity2_7Enum.ActivityId.Dungeon
}
VersionActivity3_5Enum.CharacterActId = {
	[VersionActivity3_5Enum.ActivityId.Lamona] = true,
	[VersionActivity3_5Enum.ActivityId.Lorentz] = true
}
VersionActivity3_5Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_5Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_5Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_5Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.Lamona,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.Lorentz,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.AutoChess,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_5Enum.ActivityId.Season,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_5Enum.ActivityId.SeasonStore
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
VersionActivity3_5Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_5Enum.ActivityId.Dungeon
}
VersionActivity3_5Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#E3DED3",
		enFontSize = 16,
		enColor = "#FFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity3_5Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a5_mainactivity_singlebg/v3a5_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#E3DED3",
		enFontSize = 16,
		enColor = "#FFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity3_5Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a5_mainactivity_singlebg/v3a5_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_5Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_5Enum.RedDotOffsetY = 56
VersionActivity3_5Enum.RedDotOffsetX = 10
VersionActivity3_5Enum.EnterLoopVideoName = "v3a5_kv_loop"
VersionActivity3_5Enum.EnterAnimVideoName = "v3a5_kv_open"
VersionActivity3_5Enum.EnterVideoDayKey = "v3a5_EnterVideoDayKey"
VersionActivity3_5Enum.OpenAnimDelayTime = 5

return VersionActivity3_5Enum
