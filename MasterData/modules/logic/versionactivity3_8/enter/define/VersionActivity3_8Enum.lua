-- chunkname: @modules/logic/versionactivity3_8/enter/define/VersionActivity3_8Enum.lua

module("modules.logic.versionactivity3_8.enter.define.VersionActivity3_8Enum", package.seeall)

local VersionActivity3_8Enum = _M

VersionActivity3_8Enum.ActivityId = {
	DianJiShi = 13812,
	EnterView = 13801,
	EchoSong = 13811,
	DouQuQu4Store = 13819,
	RoleStory = 13821,
	DouQuQu4 = 13808,
	Abyss = 13810,
	DungeonStore = 13803,
	Dungeon = 13802,
	FreeMonthCard = 13813,
	ReactivityStore = 13804,
	Reactivity = VersionActivity3_1Enum.ActivityId.Dungeon
}
VersionActivity3_8Enum.CharacterActId = {
	[VersionActivity3_8Enum.ActivityId.DianJiShi] = true,
	[VersionActivity3_8Enum.ActivityId.EchoSong] = true
}
VersionActivity3_8Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_8Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_8Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.EchoSong,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.DianJiShi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_8Enum.ActivityId.ReactivityStore
	},
	{
		actId = BossRushConfig.instance:getActivityId(),
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.DouQuQu4,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.Abyss,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_8Enum.ActivityId.RoleStory,
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
VersionActivity3_8Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_8Enum.ActivityId.Dungeon
}
VersionActivity3_8Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#FFFAD7",
		enFontSize = 16,
		enColor = "#99DBB3",
		enAlpha = 0.5,
		act2TabImg = {
			[VersionActivity3_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a6_mainactivity_singlebg/v3a6_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#98947C",
		enFontSize = 16,
		enColor = "#7A9384",
		enAlpha = 0.5,
		act2TabImg = {
			[VersionActivity3_8Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a6_mainactivity_singlebg/v3a6_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_8Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_8Enum.RedDotOffsetY = 56
VersionActivity3_8Enum.RedDotOffsetX = 10
VersionActivity3_8Enum.EnterLoopVideoName = "v3a8_kv_loop"
VersionActivity3_8Enum.EnterAnimVideoName = "v3a8_kv_open"
VersionActivity3_8Enum.EnterVideoDayKey = "v3a8_EnterVideoDayKey"
VersionActivity3_8Enum.EnterVideoFirstKey = "v3a8_EnterVideoFirstKey"
VersionActivity3_8Enum.OpenAnimDelayTime = 6.4
VersionActivity3_8Enum.ScriptSuffix = 1

return VersionActivity3_8Enum
