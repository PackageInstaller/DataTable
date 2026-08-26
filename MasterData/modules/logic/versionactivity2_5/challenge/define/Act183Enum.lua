-- chunkname: @modules/logic/versionactivity2_5/challenge/define/Act183Enum.lua

module("modules.logic.versionactivity2_5.challenge.define.Act183Enum", package.seeall)

local Act183Enum = _M

Act183Enum.EpisodeType = {
	Sub = 2,
	Boss = 1
}
Act183Enum.GroupType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
Act183Enum.EpisodeClsType = {
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.Daily, Act183Enum.EpisodeType.Boss)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.Daily, Act183Enum.EpisodeType.Sub)] = Act183DailyEpisodeItem,
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.NormalMain, Act183Enum.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.NormalMain, Act183Enum.EpisodeType.Sub)] = Act183MainNormalEpisodeItem,
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.HardMain, Act183Enum.EpisodeType.Boss)] = Act183MainBossEpisodeItem,
	[Act183Helper.getEpisodeClsKey(Act183Enum.GroupType.HardMain, Act183Enum.EpisodeType.Sub)] = Act183MainNormalEpisodeItem
}
Act183Enum.GroupEntranceItemClsType = {
	[Act183Enum.GroupType.Daily] = Act183DailyGroupEntranceItem,
	[Act183Enum.GroupType.NormalMain] = Act183MainGroupEntranceItem,
	[Act183Enum.GroupType.HardMain] = Act183MainGroupEntranceItem
}
Act183Enum.GroupCategoryClsType = {
	[Act183Enum.GroupType.Daily] = Act183DungeonBaseGroupItem,
	[Act183Enum.GroupType.NormalMain] = Act183DungeonBaseGroupItem,
	[Act183Enum.GroupType.HardMain] = Act183DungeonHardMainGroupItem
}
Act183Enum.EpisodeStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
Act183Enum.GroupStatus = {
	Finished = 3,
	Locked = 1,
	Unlocked = 2
}
Act183Enum.RuleStatus = {
	Repress = 2,
	Enabled = 0,
	Escape = 1
}
Act183Enum.TaskListItemType = {
	Head = 1,
	Task = 2,
	OneKey = 3
}
Act183Enum.TaskItemHeightMap = {
	[Act183Enum.TaskListItemType.Head] = 52,
	[Act183Enum.TaskListItemType.Task] = 158,
	[Act183Enum.TaskListItemType.OneKey] = 158
}
Act183Enum.TaskType = {
	NormalMain = 2,
	Daily = 1,
	HardMain = 3
}
Act183Enum.TaskSubType = {
	Core = 1,
	Addition = 2
}
Act183Enum.GroupTypeToTaskType = {
	[Act183Enum.GroupType.Daily] = Act183Enum.TaskType.Daily,
	[Act183Enum.GroupType.NormalMain] = Act183Enum.TaskType.NormalMain,
	[Act183Enum.GroupType.HardMain] = Act183Enum.TaskType.HardMain
}
Act183Enum.TaskNameLangId = {
	[Act183Enum.TaskType.Daily] = "act183taskview_dailytask",
	[Act183Enum.TaskType.NormalMain] = "act183taskview_normalmaintask",
	[Act183Enum.TaskType.HardMain] = "act183taskview_hardmaintask"
}
Act183Enum.HeroType = {
	Trial = 2,
	Normal = 1
}
Act183Enum.MaxMainSubEpisodesNum = 4
Act183Enum.MaxDailySubEpisodesNum = 3
Act183Enum.MainGroupBossEpisodeNum = 1
Act183Enum.BossEpisodeMaxHeroNum = 5
Act183Enum.Const = {
	MaxBadgeNum = 1,
	RoundStage = 5,
	PlayerClothIds = 7,
	BadgeItemId = 6,
	MainBannerUrl = 8
}
Act183Enum.RuleEscapeAnimType = {
	RightTop2Center = 10,
	RightTop2LeftBottom = 6,
	LeftTop2RightBottom = 5,
	LeftTop2Center = 9,
	LeftBottom2Center = 11,
	LeftBottom2RightTop = 7,
	Top2Bottom = 1,
	RightBottom2LeftTop = 8,
	RightBottom2Center = 12,
	Bottom2Top = 2,
	Right2Left = 4,
	Left2Right = 3
}
Act183Enum.ConditionStatus = {
	Pass = 2,
	Pass_Unselect = 3,
	Pass_Select = 4,
	Unpass = 1
}
Act183Enum.ConditionStarImgName = {
	[Act183Enum.ConditionStatus.Unpass] = "v2a5_challenge_settlement_bossstar1",
	[Act183Enum.ConditionStatus.Pass] = "v2a5_challenge_settlement_bossstar2",
	[Act183Enum.ConditionStatus.Pass_Unselect] = "v2a5_challenge_settlement_bossstar3",
	[Act183Enum.ConditionStatus.Pass_Select] = "v2a5_challenge_settlement_bossstar2"
}
Act183Enum.BattleNumToSnapShotType = {
	Default = ModuleEnum.HeroGroupSnapshotType.Act183Boss,
	[4] = ModuleEnum.HeroGroupSnapshotType.Act183Normal,
	[5] = ModuleEnum.HeroGroupSnapshotType.Act183Boss
}
Act183Enum.ActType = 183
Act183Enum.StoreEntryPrefabUrl = "ui/viewres/versionactivity_2_5/challenge/v2a5_challenge_storeentry.prefab"

return Act183Enum
