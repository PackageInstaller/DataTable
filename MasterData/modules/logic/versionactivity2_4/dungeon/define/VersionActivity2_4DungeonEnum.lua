-- chunkname: @modules/logic/versionactivity2_4/dungeon/define/VersionActivity2_4DungeonEnum.lua

module("modules.logic.versionactivity2_4.dungeon.define.VersionActivity2_4DungeonEnum", package.seeall)

local VersionActivity2_4DungeonEnum = _M

VersionActivity2_4DungeonEnum.DungeonChapterId = {
	ElementFight = 24102,
	Story = 24101,
	Hard = 24201,
	Story1 = 24101,
	Story2 = 24301,
	Story3 = 24401
}
VersionActivity2_4DungeonEnum.EpisodeStarType = {
	[VersionActivity2_4DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a4_dungeon_star_1_locked",
		light = "v2a4_dungeon_star_1"
	},
	[VersionActivity2_4DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a4_dungeon_star_2_locked",
		light = "v2a4_dungeon_star_2"
	},
	[VersionActivity2_4DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a4_dungeon_star_3_locked",
		light = "v2a4_dungeon_star_3"
	},
	[VersionActivity2_4DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a4_dungeon_star_3_locked",
		light = "v2a4_dungeon_star_3"
	}
}
VersionActivity2_4DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_4_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_4_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_4_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_4_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_4_OpenTaskView",
	FocusNewElement = "VersionActivity2_4_FocusNewElement"
}
VersionActivity2_4DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
VersionActivity2_4DungeonEnum.SceneRootName = "VersionActivity2_4DungeonMapScene"
VersionActivity2_4DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_4DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_4DungeonEnum.MaxHoleNum = 5
VersionActivity2_4DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_4DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_4DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_4DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_4DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_4DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}

return VersionActivity2_4DungeonEnum
