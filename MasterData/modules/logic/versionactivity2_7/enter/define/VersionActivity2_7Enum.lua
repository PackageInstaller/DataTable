-- chunkname: @modules/logic/versionactivity2_7/enter/define/VersionActivity2_7Enum.lua

module("modules.logic.versionactivity2_7.enter.define.VersionActivity2_7Enum", package.seeall)

local VersionActivity2_7Enum = _M

VersionActivity2_7Enum.ActivityId = {
	Act191 = 12701,
	ReactivityStore = 12713,
	RoleStory1 = 12714,
	CooperGarland = 12703,
	DungeonStore = 12707,
	LengZhou6 = 12702,
	Dungeon = 12706,
	Act191Store = 12718,
	Challenge = 12704,
	EnterView = 12705,
	Reactivity = VersionActivity2_0Enum.ActivityId.Dungeon,
	DungeonGraffiti = VersionActivity2_0Enum.ActivityId.DungeonGraffiti
}
VersionActivity2_7Enum.EnterViewActSetting = {
	{
		actId = VersionActivity2_7Enum.ActivityId.Dungeon,
		actLevel = VersionActivityEnterViewEnum.ActLevel.First,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_7Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity2_7Enum.ActivityId.Act191,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_7Enum.ActivityId.CooperGarland,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_7Enum.ActivityId.LengZhou6,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = VersionActivity2_7Enum.ActivityId.Reactivity,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		storeId = VersionActivity2_7Enum.ActivityId.ReactivityStore
	},
	{
		actId = VersionActivity2_7Enum.ActivityId.Challenge,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single
	},
	{
		actId = {
			VersionActivity2_7Enum.ActivityId.RoleStory1
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
		actId = ActivityEnum.Activity.WeekWalkHeartShow,
		actLevel = VersionActivityEnterViewEnum.ActLevel.Second,
		actType = VersionActivityEnterViewEnum.ActType.Single,
		redDotUid = ActivityEnum.Activity.WeekWalkHeartShow
	}
}
VersionActivity2_7Enum.EnterViewActIdListWithRedDot = {
	VersionActivity2_7Enum.ActivityId.Dungeon
}
VersionActivity2_7Enum.TabSetting = {
	select = {
		fontSize = 42,
		cnColor = "#FFFFFF",
		enFontSize = 14,
		enColor = "#337C61",
		act2TabImg = {
			[VersionActivity2_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a7_mainactivity_singlebg/v2a7_enterview_itemtitleselected.png"
		}
	},
	unselect = {
		fontSize = 38,
		cnColor = "#8D8D8D",
		enFontSize = 14,
		enColor = "#485143",
		act2TabImg = {
			[VersionActivity2_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v2a7_mainactivity_singlebg/v2a7_enterview_itemtitleunselected.png"
		}
	}
}
VersionActivity2_7Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity2_7Enum.RedDotOffsetY = 56
VersionActivity2_7Enum.Audio = {
	FirstOpenDungeonTab = AudioEnum2_7.VersionActivity2_7Enter.play_ui_yuzhou_open,
	ReturnDungeonTab = AudioEnum2_7.VersionActivity2_7Enter.play_ui_qiutu_revelation_open
}

return VersionActivity2_7Enum
