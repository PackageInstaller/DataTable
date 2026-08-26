-- chunkname: @modules/logic/versionactivity1_8/dungeon/define/VersionActivity1_8DungeonEnum.lua

module("modules.logic.versionactivity1_8.dungeon.define.VersionActivity1_8DungeonEnum", package.seeall)

local VersionActivity1_8DungeonEnum = _M

VersionActivity1_8DungeonEnum.DungeonChapterId = {
	ElementFight = 18102,
	Story = 18101,
	Hard = 18201,
	Story1 = 18101,
	Story4 = 18201,
	Story2 = 18301,
	Story3 = 18401
}
VersionActivity1_8DungeonEnum.EpisodeStarType = {
	[VersionActivity1_8DungeonEnum.DungeonChapterId.Story] = {
		empty = "v1a8_dungeon_star_1_locked",
		light = "v1a8_dungeon_star_1"
	},
	[VersionActivity1_8DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v1a8_dungeon_star_2_locked",
		light = "v1a8_dungeon_star_2"
	},
	[VersionActivity1_8DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v1a8_dungeon_star_3_locked",
		light = "v1a8_dungeon_star_3"
	},
	[VersionActivity1_8DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v1a8_dungeon_star_3_locked",
		light = "v1a8_dungeon_star_3"
	}
}
VersionActivity1_8DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity1_8_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity1_8_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity1_8_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity1_8_TaskItemGetReward",
	OpenTaskView = "VersionActivity1_8_OpenTaskView",
	FocusNewElement = "VersionActivity1_8_FocusNewElement",
	GetComponentRepairReward = "VersionActivity1_8_GetComponentRepairReward"
}
VersionActivity1_8DungeonEnum.PlayerPrefsKey = {
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	IsPlayedFactoryComponentUnlockANim = "Activity157IsPlayedFactoryComponentUnlockANim_",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	IsPlayedBlueprintAllFinish = "Activity157IsPlayedFactoryComponentUnlockANim",
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	IsPlayedBlueprintUnlockAnim = "Activity157IsPlayedBlueprintUnlockAnim",
	IsPlayedMissionNodeUnlocked = "Activity157IsPlayedUnlockMissionNode_",
	IsPlayedFactoryMapSwitchUnlockAnim = "Activity157IsPlayedFactoryMapSwitchUnlockAnim"
}
VersionActivity1_8DungeonEnum.SceneRootName = "VersionActivity1_8DungeonMapScene"
VersionActivity1_8DungeonEnum.DungeonMapCameraSize = 5
VersionActivity1_8DungeonEnum.MaxHoleNum = 5
VersionActivity1_8DungeonEnum.HoleHalfWidth = 3.5
VersionActivity1_8DungeonEnum.HoleHalfHeight = 1.75
VersionActivity1_8DungeonEnum.HoleAnimDuration = 0.33
VersionActivity1_8DungeonEnum.HoleAnimMaxZ = 3
VersionActivity1_8DungeonEnum.HoleAnimMinZ = 0
VersionActivity1_8DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity1_8DungeonEnum.ElementTimeOffsetY = 0.8
VersionActivity1_8DungeonEnum.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}

return VersionActivity1_8DungeonEnum
