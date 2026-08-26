-- chunkname: @modules/logic/versionactivity3_7/enter/define/VersionActivity3_7Enum.lua

module("modules.logic.versionactivity3_7.enter.define.VersionActivity3_7Enum", package.seeall)

local VersionActivity3_7Enum = _M

VersionActivity3_7Enum.ActivityId = {
	DungeonStore = 13704,
	Anniversary3Sign = 13712,
	SodacheStore = 13705,
	XRuiAnYi = 13710,
	ReactivityStore = 13504,
	Anniversary3Main = 13718,
	Sodache = 13701,
	ArcadeV3a7 = 13720,
	Rouge2 = 13209,
	Anniversary3GuessGame = 13717,
	BossRush = 13742,
	Abyss = 13744,
	Anniversary3Skin = 13714,
	Wmz = 13723,
	EnterView = 13702,
	Anniversary3ActBp = 13716,
	Anniversary3Mail = 13711,
	Anniversary3Invite = 13715,
	Dungeon = 13703,
	Anniversary3Report = 13713,
	RoleStory = 13722,
	Reactivity = VersionActivity2_7Enum.ActivityId.Dungeon
}
VersionActivity3_7Enum.CharacterActId = {
	[VersionActivity3_7Enum.ActivityId.XRuiAnYi] = true,
	[VersionActivity3_7Enum.ActivityId.Wmz] = true
}
VersionActivity3_7Enum.EnterViewActSetting = {
	{
		actId = VersionActivity3_7Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity3_7Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.Sodache,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.ArcadeV3a7,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.BossRush,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.XRuiAnYi,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.RoleStory,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.Rouge2,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.Abyss,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity3_7Enum.ActivityId.Wmz,
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
VersionActivity3_7Enum.EnterViewActIdListWithRedDot = {
	VersionActivity3_7Enum.ActivityId.Dungeon
}
VersionActivity3_7Enum.TabSetting = {
	select = {
		fontSize = 30,
		cnColor = "#E3DED3",
		enFontSize = 16,
		enColor = "#FFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity3_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a7_mainactivity_singlebg/v3a7_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 30,
		cnColor = "#B4B4B4",
		enFontSize = 16,
		enColor = "#FFFFFF",
		enAlpha = 0.12,
		act2TabImg = {
			[VersionActivity3_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v3a7_mainactivity_singlebg/v3a7_enterview_itemtitleselected.png"
		}
	}
}
VersionActivity3_7Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity3_7Enum.RedDotOffsetY = 160
VersionActivity3_7Enum.RedDotOffsetX = 10
VersionActivity3_7Enum.EnterLoopVideoName = "v3a7_kv_loop"
VersionActivity3_7Enum.EnterAnimVideoName = "v3a7_kv_open"
VersionActivity3_7Enum.EnterVideoDayKey = "v3a7_EnterVideoDayKey"
VersionActivity3_7Enum.OpenAnimDelayTime = 5.2

return VersionActivity3_7Enum
