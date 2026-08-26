-- chunkname: @modules/logic/versionactivity2_5/dungeon/define/VersionActivity2_5DungeonEnum.lua

module("modules.logic.versionactivity2_5.dungeon.define.VersionActivity2_5DungeonEnum", package.seeall)

local VersionActivity2_5DungeonEnum = _M

VersionActivity2_5DungeonEnum.DungeonChapterId = {
	ElementFight = 25102,
	Story = 25101,
	Hard = 25201,
	Story1 = 25101,
	Story2 = 25301,
	Story3 = 25401
}
VersionActivity2_5DungeonEnum.EpisodeStarType = {
	[VersionActivity2_5DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a3_dungeon_star_1_locked",
		light = "v2a3_dungeon_star_1"
	},
	[VersionActivity2_5DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a3_dungeon_star_2_locked",
		light = "v2a3_dungeon_star_2"
	},
	[VersionActivity2_5DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	},
	[VersionActivity2_5DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a3_dungeon_star_3_locked",
		light = "v2a3_dungeon_star_3"
	}
}
VersionActivity2_5DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_5_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_5_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_5_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_5_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_5_OpenTaskView",
	FocusNewElement = "VersionActivity2_5_FocusNewElement"
}
VersionActivity2_5DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
VersionActivity2_5DungeonEnum.SceneRootName = "VersionActivity2_5DungeonMapScene"
VersionActivity2_5DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_5DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_5DungeonEnum.MaxHoleNum = 5
VersionActivity2_5DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_5DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_5DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_5DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_5DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_5DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_5DungeonEnum.GuideAct165ElementId = 2110201
VersionActivity2_5DungeonEnum.GuideAct165ElementStepId = 21401

return VersionActivity2_5DungeonEnum
