-- chunkname: @modules/logic/versionactivity3_1/enter/define/VersionActivity3_1Enum.lua

module("modules.logic.versionactivity3_1.enter.define.VersionActivity3_1Enum", package.seeall)

local VersionActivity3_1Enum = _M

VersionActivity3_1Enum.ActivityId = {
	YeShuMei = 13117,
	TowerDeep = 13112,
	DouQuQu3Store = 13115,
	NationalGift = 13122,
	Survival = 13106,
	RoleStory = 13107,
	DouQuQu3 = 13105,
	BpOperAct = 13123,
	GaoSiNiao = 13118,
	DungeonStore = 13104,
	BossRush = 13113,
	Dungeon = 13103,
	ReactivityStore = 13114,
	EnterView = 13102,
	SurvivalOperAct = 13111,
	Reactivity = VersionActivity2_4Enum.ActivityId.Dungeon
}
VersionActivity3_1Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_1Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_1Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.DouQuQu3,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.Survival,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.YeShuMei,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_1Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity3_1Enum.ActivityId.GaoSiNiao,
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
VersionActivity3_1Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_1Enum.ActivityId.Dungeon
}
VersionActivity3_1Enum.TabSetting = {
	select = {
		fontSize = 28,
		cnColor = "#F4FDF8",
		enFontSize = 16,
		cnAlpha = 1,
		enColor = "#C90F0D",
		enAlpha = 1,
		act2TabImg = {
			[VersionActivity3_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a1_mainactivity_singlebg/v3a1_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 28,
		cnColor = "#76877E",
		enFontSize = 16,
		cnAlpha = 1,
		enColor = "#FFFFFF",
		enAlpha = 0.3,
		act2TabImg = {
			[VersionActivity3_1Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a1_mainactivity_singlebg/v3a1_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity3_1Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_1Enum.RedDotOffsetY = 56
VersionActivity3_1Enum.EnterLoopVideoName = "v3a1_kv_loop"
VersionActivity3_1Enum.EnterAnimVideoName = "v3a1_kv_open"
VersionActivity3_1Enum.EnterVideoDayKey = "v3a1_EnterVideoDayKey"

return VersionActivity3_1Enum
