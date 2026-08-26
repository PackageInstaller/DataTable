-- chunkname: @modules/logic/achievement/define/AchievementEnum.lua

module("modules.logic.achievement.define.AchievementEnum", package.seeall)

local AchievementEnum = _M

AchievementEnum.Type = {
	GamePlay = 3,
	Activity = 4,
	Story = 1,
	GameCenter = 9999,
	NamePlate = 5,
	Normal = 2
}
AchievementEnum.AchievementType = {
	Group = 2,
	Single = 1
}
AchievementEnum.ViewType = {
	Tile = 2,
	List = 1
}
AchievementEnum.SortType = {
	RareDown = 2,
	RareUp = 1
}
AchievementEnum.SearchFilterType = {
	All = 1,
	Unlocked = 2,
	Locked = 3
}
AchievementEnum.AchievementState = {
	Online = 1,
	Offline = 2
}
AchievementEnum.ToastType = {
	GroupFinished = 4,
	TaskFinished = 1,
	GroupUnlocked = 2,
	GroupUpgrade = 3
}
AchievementEnum.FilterTypeName = {
	[AchievementEnum.SearchFilterType.All] = "achievementmainview_filterType_total",
	[AchievementEnum.SearchFilterType.Unlocked] = "achievementmainview_filterType_unlocked",
	[AchievementEnum.SearchFilterType.Locked] = "achievementmainview_filterType_locked"
}
AchievementEnum.TypeName = {
	[AchievementEnum.Type.Normal] = "achievement_category_normal",
	[AchievementEnum.Type.GamePlay] = "achievement_category_play",
	[AchievementEnum.Type.Story] = "achievement_category_story",
	[AchievementEnum.Type.Activity] = "achievement_category_action",
	[AchievementEnum.Type.NamePlate] = "achievement_category_nameplate"
}
AchievementEnum.TypeNameEn = {
	[AchievementEnum.Type.Normal] = "LOG",
	[AchievementEnum.Type.GamePlay] = "CHALLENGE",
	[AchievementEnum.Type.Story] = "REVIEW",
	[AchievementEnum.Type.Activity] = "BROCHURE",
	[AchievementEnum.Type.NamePlate] = "Plates"
}
AchievementEnum.GroupParamType = {
	Player = 1,
	List = 2
}
AchievementEnum.SpGroupType = {
	Tower = 6,
	Journey = 1,
	Room = 3,
	BossRush = 5,
	Explore = 4,
	WeekWalk = 2
}
AchievementEnum.SpGroupNameLangId = {
	[AchievementEnum.SpGroupType.Journey] = "achievementmainview_spgroup_journey",
	[AchievementEnum.SpGroupType.WeekWalk] = "achievementmainview_spgroup_weekwalk",
	[AchievementEnum.SpGroupType.Room] = "achievementmainview_spgroup_room",
	[AchievementEnum.SpGroupType.Explore] = "achievementmainview_spgroup_explore",
	[AchievementEnum.SpGroupType.BossRush] = "achievementmainview_spgroup_bossrush",
	[AchievementEnum.SpGroupType.Tower] = "achievementmainview_spgroup_tower"
}
AchievementEnum.SourceType = {
	Tower = 1
}
AchievementEnum.MainTileGroupItemHeight = 460
AchievementEnum.MainTileLineItemHeight = 300
AchievementEnum.SpGroupTitleBarHeight = 74
AchievementEnum.MainSpGroupLineCount = 5
AchievementEnum.MainListLineCount = 5
AchievementEnum.ShowMaxSingleCount = 6
AchievementEnum.ShowMaxGroupCount = 1
AchievementEnum.ShowMaxNamePlateCount = 1
AchievementEnum.ShowMaxToastCount = 10
AchievementEnum.MainIconPath = "ui/viewres/achievement/achievementmainicon.prefab"
AchievementEnum.AchievementToastPath = "ui/viewres/achievement/achievementtoastitem.prefab"
AchievementEnum.AchievementPreViewPrefabPath = "ui/viewres/achievement/grouppreview"
AchievementEnum.HideType = {
	[AchievementEnum.Type.GameCenter] = true
}

return AchievementEnum
