-- chunkname: @modules/logic/versionactivity1_7/enter/define/VersionActivity1_7Enum.lua

module("modules.logic.versionactivity1_7.enter.define.VersionActivity1_7Enum", package.seeall)

local VersionActivity1_7Enum = _M

VersionActivity1_7Enum.ActivityId = {
	Warmup = 11720,
	BossRush = 11704,
	RoleStory1 = 11715,
	DoubleDrop = 11714,
	Season = 11700,
	Marcus = 11707,
	Reactivity = 11208,
	ReactivityStore = 11713,
	RoleStory2 = 11716,
	Isolde = 11706,
	DungeonStore = 11703,
	Dungeon = 11702,
	SeasonStore = 11705,
	EnterView = 11701
}
VersionActivity1_7Enum.ActLevel = {
	Second = 2,
	First = 1
}
VersionActivity1_7Enum.ActType = {
	Multi = 2,
	Single = 1
}
VersionActivity1_7Enum.EnterViewActIdList = {
	{
		actId = VersionActivity1_7Enum.ActivityId.Dungeon,
		actLevel = VersionActivity1_7Enum.ActLevel.First,
		actType = VersionActivity1_7Enum.ActType.Single,
		storeId = VersionActivity1_7Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity1_7Enum.ActivityId.Isolde,
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Single,
		redDotUid = VersionActivity1_7Enum.ActivityId.Isolde
	},
	{
		actId = VersionActivity1_7Enum.ActivityId.Marcus,
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Single,
		redDotUid = VersionActivity1_7Enum.ActivityId.Marcus
	},
	{
		actId = VersionActivity1_7Enum.ActivityId.BossRush,
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Single
	},
	{
		actId = VersionActivity1_7Enum.ActivityId.Reactivity,
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Single,
		storeId = VersionActivity1_7Enum.ActivityId.ReactivityStore
	},
	{
		actId = {
			VersionActivity1_7Enum.ActivityId.RoleStory1,
			VersionActivity1_7Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Multi
	},
	{
		actId = VersionActivity1_7Enum.ActivityId.Season,
		actLevel = VersionActivity1_7Enum.ActLevel.Second,
		actType = VersionActivity1_7Enum.ActType.Single,
		storeId = VersionActivity1_7Enum.ActivityId.SeasonStore
	}
}
VersionActivity1_7Enum.EnterViewActIdListWithRedDot = {
	VersionActivity1_7Enum.ActivityId.Dungeon,
	VersionActivity1_7Enum.ActivityId.Isolde,
	VersionActivity1_7Enum.ActivityId.Marcus,
	VersionActivity1_7Enum.ActivityId.BossRush,
	VersionActivity1_7Enum.ActivityId.Reactivity,
	VersionActivity1_7Enum.ActivityId.RoleStory1,
	VersionActivity1_7Enum.ActivityId.RoleStory2,
	VersionActivity1_7Enum.ActivityId.Season
}
VersionActivity1_7Enum.ActId2ShowReplayBtnDict = {
	[VersionActivity1_7Enum.ActivityId.Dungeon] = true,
	[VersionActivity1_7Enum.ActivityId.Isolde] = false,
	[VersionActivity1_7Enum.ActivityId.Marcus] = false,
	[VersionActivity1_7Enum.ActivityId.BossRush] = false,
	[VersionActivity1_7Enum.ActivityId.Reactivity] = false,
	[VersionActivity1_7Enum.ActivityId.RoleStory1] = false,
	[VersionActivity1_7Enum.ActivityId.RoleStory2] = false,
	[VersionActivity1_7Enum.ActivityId.Season] = false
}
VersionActivity1_7Enum.ActId2ShowAchievementBtnDict = {
	[VersionActivity1_7Enum.ActivityId.Dungeon] = true,
	[VersionActivity1_7Enum.ActivityId.Isolde] = true,
	[VersionActivity1_7Enum.ActivityId.Marcus] = true,
	[VersionActivity1_7Enum.ActivityId.BossRush] = true,
	[VersionActivity1_7Enum.ActivityId.Reactivity] = false,
	[VersionActivity1_7Enum.ActivityId.RoleStory1] = true,
	[VersionActivity1_7Enum.ActivityId.RoleStory2] = true,
	[VersionActivity1_7Enum.ActivityId.Season] = true
}
VersionActivity1_7Enum.ActId2ShowRemainTimeDict = {
	[VersionActivity1_7Enum.ActivityId.Dungeon] = false,
	[VersionActivity1_7Enum.ActivityId.Isolde] = true,
	[VersionActivity1_7Enum.ActivityId.Marcus] = true,
	[VersionActivity1_7Enum.ActivityId.BossRush] = false,
	[VersionActivity1_7Enum.ActivityId.Reactivity] = false,
	[VersionActivity1_7Enum.ActivityId.RoleStory1] = true,
	[VersionActivity1_7Enum.ActivityId.RoleStory2] = true,
	[VersionActivity1_7Enum.ActivityId.Season] = false
}
VersionActivity1_7Enum.ActivityNameColor = {
	Select = Color(1, 1, 1, 1),
	UnSelect = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1)
}
VersionActivity1_7Enum.ActivityNameFontSize = {
	Select = 42,
	UnSelect = 38
}
VersionActivity1_7Enum.ActivityNameEnFontSize = {
	Select = 14,
	UnSelect = 12
}
VersionActivity1_7Enum.ActId2UnSelectImgPath = {
	[VersionActivity1_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleunselected.png"
}
VersionActivity1_7Enum.ActId2SelectImgPath = {
	[VersionActivity1_7Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a7_mainactivity_singlebg/v1a7_enterview_itemtitleselected.png"
}
VersionActivity1_7Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity1_7Enum.ScrollTabTopPadding = 16
VersionActivity1_7Enum.RedDotOffsetY = 56

return VersionActivity1_7Enum
