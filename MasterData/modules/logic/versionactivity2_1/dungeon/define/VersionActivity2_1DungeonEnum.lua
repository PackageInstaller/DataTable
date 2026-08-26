-- chunkname: @modules/logic/versionactivity2_1/dungeon/define/VersionActivity2_1DungeonEnum.lua

module("modules.logic.versionactivity2_1.dungeon.define.VersionActivity2_1DungeonEnum", package.seeall)

local VersionActivity2_1DungeonEnum = _M

VersionActivity2_1DungeonEnum.DungeonChapterId = {
	ElementFight = 21102,
	Story = 21101,
	Hard = 21201,
	Story1 = 21101,
	Story2 = 21301,
	Story3 = 21401
}
VersionActivity2_1DungeonEnum.EpisodeStarType = {
	[VersionActivity2_1DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a1_dungeon_star_1_locked",
		light = "v2a1_dungeon_star_1"
	},
	[VersionActivity2_1DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a1_dungeon_star_2_locked",
		light = "v2a1_dungeon_star_2"
	},
	[VersionActivity2_1DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a1_dungeon_star_3_locked",
		light = "v2a1_dungeon_star_3"
	},
	[VersionActivity2_1DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a1_dungeon_star_3_locked",
		light = "v2a1_dungeon_star_3"
	}
}
VersionActivity2_1DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_1_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_1_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_1_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_1_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_1_OpenTaskView",
	FocusNewElement = "VersionActivity2_1_FocusNewElement"
}
VersionActivity2_1DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
VersionActivity2_1DungeonEnum.SceneRootName = "VersionActivity2_1DungeonMapScene"
VersionActivity2_1DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_1DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_1DungeonEnum.MaxHoleNum = 5
VersionActivity2_1DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_1DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_1DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_1DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_1DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_1DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_1DungeonEnum.GuideAct165ElementId = 2110201
VersionActivity2_1DungeonEnum.GuideAct165ElementStepId = 21401

return VersionActivity2_1DungeonEnum
