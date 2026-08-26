-- chunkname: @modules/logic/versionactivity3_4/enter/define/VersionActivity3_4Enum.lua

module("modules.logic.versionactivity3_4.enter.define.VersionActivity3_4Enum", package.seeall)

local VersionActivity3_4Enum = _M

VersionActivity3_4Enum.ActivityId = {
	Chg = 13439,
	BpOperAct = 13419,
	LaplaceChatRoom = 13410,
	LaplaceMiniParty = 13413,
	Survival = 13406,
	PartyGameStore = 13416,
	Dungeon = 13402,
	ReactivityStore = 13440,
	Rouge2 = 13209,
	DungeonStore = 13403,
	LaplaceTitleAppoint = 13409,
	LaplaceMain = 13408,
	EnterView = 13401,
	LaplaceTowerAlbum = 13412,
	LaplaceObserverBox = 13414,
	LuSiJian = 13437,
	ActivityCollect = 13432,
	PartyGame = 13415,
	BossRush = 13420,
	RoleStory = 13422,
	Reactivity = VersionActivity2_5Enum.ActivityId.Dungeon
}
VersionActivity3_4Enum.CharacterActId = {
	[VersionActivity3_4Enum.ActivityId.LuSiJian] = true,
	[VersionActivity3_4Enum.ActivityId.Chg] = true
}
VersionActivity3_4Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_4Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_4Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.PartyGame,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.Survival,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.LuSiJian,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_4Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.Rouge2,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_4Enum.ActivityId.Chg,
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
VersionActivity3_4Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_4Enum.ActivityId.Dungeon
}
VersionActivity3_4Enum.TabSetting = {
	select = {
		fontSize = 28,
		cnColor = "#FFFFFF",
		enFontSize = 16,
		enColor = "#FFFFFF",
		act2TabImg = {
			[VersionActivity3_4Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a4_mainactivity_singlebg/v3a4_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 28,
		cnColor = "#A5A5A5",
		enFontSize = 16,
		enColor = "#FFFFFF",
		act2TabImg = {
			[VersionActivity3_4Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a4_mainactivity_singlebg/v3a4_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_4Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_4Enum.RedDotOffsetY = 56
VersionActivity3_0Enum.RedDotOffsetX = 10
VersionActivity3_4Enum.EnterLoopVideoName = "v3a4_kv_loop"
VersionActivity3_4Enum.EnterAnimVideoName = "v3a4_kv_open"
VersionActivity3_4Enum.EnterVideoDayKey = "v3a4_EnterVideoDayKey"
VersionActivity3_4Enum.OpenAnimDelayTime = 6.5
VersionActivity3_4Enum.Open1AnimTime = 1.5

return VersionActivity3_4Enum
