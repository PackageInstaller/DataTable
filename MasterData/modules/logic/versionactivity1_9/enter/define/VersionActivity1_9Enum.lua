-- chunkname: @modules/logic/versionactivity1_9/enter/define/VersionActivity1_9Enum.lua

module("modules.logic.versionactivity1_9.enter.define.VersionActivity1_9Enum", package.seeall)

local VersionActivity1_9Enum = _M

VersionActivity1_9Enum.ActivityId = {
	Warmup = 11720,
	BossRush = 11910,
	RoleStory1 = 11911,
	ToughBattle = 11905,
	Season = 11906,
	DoubleDrop = 11714,
	KaKaNia = 11909,
	Explore3 = 11922,
	RoleStory2 = 11912,
	DungeonStore = 11903,
	Lucy = 11908,
	Dungeon = 11902,
	SeasonStore = 11907,
	EnterView = 11901,
	Rouge = 11920
}
VersionActivity1_9Enum.ActLevel = {
	Second = 2,
	First = 1
}
VersionActivity1_9Enum.ActType = {
	Multi = 2,
	Single = 1
}
VersionActivity1_9Enum.EnterViewActIdList = {
	{
		actId = VersionActivity1_9Enum.ActivityId.Dungeon,
		actLevel = VersionActivity1_9Enum.ActLevel.First,
		actType = VersionActivity1_9Enum.ActType.Single,
		storeId = VersionActivity1_9Enum.ActivityId.DungeonStore
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.BossRush,
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Single
	},
	{
		actId = {
			VersionActivity1_9Enum.ActivityId.RoleStory1,
			VersionActivity1_9Enum.ActivityId.RoleStory2
		},
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Multi
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.Season,
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Single,
		storeId = VersionActivity1_9Enum.ActivityId.SeasonStore
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.Lucy,
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Single,
		redDotUid = VersionActivity1_9Enum.ActivityId.Lucy
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.KaKaNia,
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Single,
		redDotUid = VersionActivity1_9Enum.ActivityId.KaKaNia
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.Rouge,
		actLevel = VersionActivity1_9Enum.ActLevel.First,
		actType = VersionActivity1_9Enum.ActType.Single
	},
	{
		actId = VersionActivity1_9Enum.ActivityId.Explore3,
		actLevel = VersionActivity1_9Enum.ActLevel.Second,
		actType = VersionActivity1_9Enum.ActType.Single
	}
}
VersionActivity1_9Enum.EnterViewActIdListWithRedDot = {
	VersionActivity1_9Enum.ActivityId.Dungeon,
	VersionActivity1_9Enum.ActivityId.BossRush,
	VersionActivity1_9Enum.ActivityId.RoleStory1,
	VersionActivity1_9Enum.ActivityId.RoleStory2,
	VersionActivity1_9Enum.ActivityId.Season,
	VersionActivity1_9Enum.ActivityId.Lucy,
	VersionActivity1_9Enum.ActivityId.KaKaNia
}
VersionActivity1_9Enum.ActId2ShowReplayBtnDict = {
	[VersionActivity1_9Enum.ActivityId.Dungeon] = true,
	[VersionActivity1_9Enum.ActivityId.BossRush] = false,
	[VersionActivity1_9Enum.ActivityId.RoleStory1] = false,
	[VersionActivity1_9Enum.ActivityId.RoleStory2] = false,
	[VersionActivity1_9Enum.ActivityId.Season] = false,
	[VersionActivity1_9Enum.ActivityId.Lucy] = false,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = false,
	[VersionActivity1_9Enum.ActivityId.Rouge] = false,
	[VersionActivity1_9Enum.ActivityId.Explore3] = false
}
VersionActivity1_9Enum.AchievementBtnType = {
	Type1 = "#btn_achievementpreview",
	Type2 = "#btn_achievementpreview_rouge"
}
VersionActivity1_9Enum.ActId2ShowAchievementBtnDict = {
	[VersionActivity1_9Enum.ActivityId.Dungeon] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.BossRush] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.RoleStory1] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.RoleStory2] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.Season] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.Lucy] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = VersionActivity1_9Enum.AchievementBtnType.Type1,
	[VersionActivity1_9Enum.ActivityId.Rouge] = VersionActivity1_9Enum.AchievementBtnType.Type2,
	[VersionActivity1_9Enum.ActivityId.Explore3] = VersionActivity1_9Enum.AchievementBtnType.Type1
}
VersionActivity1_9Enum.ActId2ShowRemainTimeDict = {
	[VersionActivity1_9Enum.ActivityId.Dungeon] = false,
	[VersionActivity1_9Enum.ActivityId.BossRush] = false,
	[VersionActivity1_9Enum.ActivityId.RoleStory1] = true,
	[VersionActivity1_9Enum.ActivityId.RoleStory2] = true,
	[VersionActivity1_9Enum.ActivityId.Season] = false,
	[VersionActivity1_9Enum.ActivityId.Lucy] = true,
	[VersionActivity1_9Enum.ActivityId.KaKaNia] = true,
	[VersionActivity1_9Enum.ActivityId.Rouge] = false,
	[VersionActivity1_9Enum.ActivityId.Explore3] = false
}
VersionActivity1_9Enum.ActivityNameColor = {
	Select = Color(1, 1, 1, 1),
	UnSelect = Color(0.5529411764705883, 0.5529411764705883, 0.5529411764705883, 1)
}
VersionActivity1_9Enum.ActivityNameFontSize = {
	Select = 42,
	UnSelect = 38
}
VersionActivity1_9Enum.ActivityNameEnFontSize = {
	Select = 14,
	UnSelect = 12
}
VersionActivity1_9Enum.ActId2UnSelectImgPath = {
	[VersionActivity1_9Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected.png",
	[VersionActivity1_9Enum.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleunselected2.png"
}
VersionActivity1_9Enum.ActId2SelectImgPath = {
	[VersionActivity1_9Enum.ActivityId.Dungeon] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected.png",
	[VersionActivity1_9Enum.ActivityId.Rouge] = "singlebg_lang/txt_v1a9_mainactivity_singlebg/v1a9_enterview_itemtitleselected2.png"
}
VersionActivity1_9Enum.MaxShowTimeOffset = 3 * TimeUtil.OneDaySecond
VersionActivity1_9Enum.ScrollTabTopPadding = 16
VersionActivity1_9Enum.RedDotOffsetY = 56
VersionActivity1_9Enum.EnterAnimVideoPath = "videos/1_9_enter.mp4"

return VersionActivity1_9Enum
