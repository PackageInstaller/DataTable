-- chunkname: @modules/logic/versionactivity3_9/enter/define/VersionActivity3_9Enum.lua

module("modules.logic.versionactivity3_9.enter.define.VersionActivity3_9Enum", package.seeall)

local VersionActivity3_9Enum = _M

VersionActivity3_9Enum.ActivityId = {
	RougeActivityTask = 13910,
	V3_A9_PartyGameStore = 13915,
	Naxisuosi = 13918,
	Racing = 13920,
	ReactivityStore = 13923,
	V3_A9_PartyGame = 13914,
	Bird = 13921,
	RoleStory = 13912,
	DungeonStore = 13903,
	V3a9BossRushAct = 13919,
	Dungeon = 13902,
	Hedone = 13904,
	EnterView = 13901,
	Reactivity = VersionActivity3_2Enum.ActivityId.Dungeon
}
VersionActivity3_9Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_9Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_9Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.Hedone,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.Naxisuosi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.V3_A9_PartyGame,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_9Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.RougeActivityTask,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_9Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = BossRushConfig.instance:getActivityId(),
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
	},
	{
		actId = AbyssConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	}
}
VersionActivity3_9Enum.CharacterActId = {
	[VersionActivity3_9Enum.ActivityId.Hedone] = true,
	[VersionActivity3_9Enum.ActivityId.Naxisuosi] = true
}
VersionActivity3_9Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_9Enum.ActivityId.Dungeon
}
VersionActivity3_9Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#FAF9E6",
		enFontSize = 14,
		enColor = "#144844",
		act2TabImg = {
			[VersionActivity3_9Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a9_mainactivity_singlebg/v3a9_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#857d71",
		enFontSize = 14,
		enColor = "#144844",
		act2TabImg = {
			[VersionActivity3_9Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a9_mainactivity_singlebg/v3a9_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_9Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_9Enum.RedDotOffsetY = 56
VersionActivity3_9Enum.RedDotOffsetX = 10
VersionActivity3_9Enum.EnterLoopVideoName = "v3a9_kv_loop"
VersionActivity3_9Enum.EnterAnimVideoName = "v3a9_kv_open"
VersionActivity3_9Enum.EnterVideoDayKey = "v3a9_EnterVideoDayKey"
VersionActivity3_9Enum.EnterVideoFirstKey = "v3a9_EnterVideoFirstKey"
VersionActivity3_9Enum.OpenAnimDelayTime = 6
VersionActivity3_9Enum.ScriptSuffix = 1

return VersionActivity3_9Enum
