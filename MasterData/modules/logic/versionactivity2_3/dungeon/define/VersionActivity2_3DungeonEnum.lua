-- chunkname: @modules/logic/versionactivity2_3/dungeon/define/VersionActivity2_3DungeonEnum.lua

module("modules.logic.versionactivity2_3.dungeon.define.VersionActivity2_3DungeonEnum", package.seeall)

local VersionActivity2_3DungeonEnum = _M

VersionActivity2_3DungeonEnum.DungeonChapterId = {
	ElementFight = 23102,
	Story = 23101,
	Hard = 23201,
	Story1 = 23101,
	Story2 = 23301,
	Story3 = 23401
}
VersionActivity2_3DungeonEnum.EpisodeStarType = {
	[VersionActivity2_3DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a3_dungeon_star_1_locked",
		light = "v2a3_dungeon_star_1"
	},
	[VersionActivity2_3DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a3_dungeon_star_2_locked",
		light = "v2a3_dungeon_star_2"
	},
	[VersionActivity2_3DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	},
	[VersionActivity2_3DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	}
}
VersionActivity2_3DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_3_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_3_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_3_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_3_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_3_OpenTaskView",
	FocusNewElement = "VersionActivity2_3_FocusNewElement"
}
VersionActivity2_3DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
VersionActivity2_3DungeonEnum.SceneRootName = "VersionActivity2_3DungeonMapScene"
VersionActivity2_3DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_3DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_3DungeonEnum.MaxHoleNum = 5
VersionActivity2_3DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_3DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_3DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_3DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_3DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_3DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_3DungeonEnum.GuideAct165ElementId = 2110201
VersionActivity2_3DungeonEnum.GuideAct165ElementStepId = 21401

return VersionActivity2_3DungeonEnum
