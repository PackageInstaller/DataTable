-- chunkname: @modules/logic/versionactivity3_3/enter/define/VersionActivity3_3Enum.lua

module("modules.logic.versionactivity3_3.enter.define.VersionActivity3_3Enum", package.seeall)

local VersionActivity3_3Enum = _M

VersionActivity3_3Enum.ActivityId = {
	BossRush = 13315,
	BpOperAct = 13312,
	Dungeon = 13306,
	NationalGift = 13316,
	Igor = 13313,
	RoleStory = 13314,
	Rouge2 = 13209,
	DungeonStore = 13307,
	Marsha = 13310,
	EnterView = 13305,
	Arcade = 13309
}
VersionActivity3_3Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_3Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_3Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_3Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_3Enum.ActivityId.Arcade,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_3Enum.ActivityId.Marsha,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity3_3Enum.ActivityId.Marsha
	},
	{
		actId = VersionActivity3_3Enum.ActivityId.Igor,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = VersionActivity3_3Enum.ActivityId.Igor
	},
	{
		actId = VersionActivity3_3Enum.ActivityId.RoleStory,
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
VersionActivity3_3Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_3Enum.ActivityId.Dungeon
}
VersionActivity3_3Enum.TabSetting = {
	select = {
		fontSize = 40,
		cnColor = "#fcfbe8",
		enFontSize = 16,
		enColor = "#e8e7bd",
		enAlpha = 0.4,
		act2TabImg = {
			[VersionActivity3_3Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a3_mainactivity_singlebg/v3a3_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 40,
		cnColor = "#87816c",
		enFontSize = 16,
		enColor = "#FFFFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity3_3Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a3_mainactivity_singlebg/v3a3_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_3Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_3Enum.RedDotOffsetY = 56
VersionActivity3_3Enum.RedDotOffsetX = 10
VersionActivity3_3Enum.EnterLoopVideoName = "v3a3_kv_loop"
VersionActivity3_3Enum.EnterAnimVideoName = "v3a3_kv_open"
VersionActivity3_3Enum.EnterVideoDayKey = "v3a3_EnterVideoDayKey"
VersionActivity3_3Enum.Open1AnimDelayPlayTime = 7.6
VersionActivity3_3Enum.isHideStoreCurrencyAddBtn = true

return VersionActivity3_3Enum
