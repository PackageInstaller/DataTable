-- chunkname: @modules/logic/versionactivity2_0/dungeon/define/VersionActivity2_0DungeonEnum.lua

module("modules.logic.versionactivity2_0.dungeon.define.VersionActivity2_0DungeonEnum", package.seeall)

local VersionActivity2_0DungeonEnum = _M

VersionActivity2_0DungeonEnum.DungeonChapterId = {
	ElementFight = 20102,
	Story = 20101,
	Hard = 20201,
	Story1 = 20101,
	Story2 = 20301,
	Story3 = 20401
}
VersionActivity2_0DungeonEnum.EpisodeStarType = {
	[VersionActivity2_0DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a0_dungeon_star_1_locked",
		light = "v2a0_dungeon_star_1"
	},
	[VersionActivity2_0DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a0_dungeon_star_2_locked",
		light = "v2a0_dungeon_star_2"
	},
	[VersionActivity2_0DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	},
	[VersionActivity2_0DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a0_dungeon_star_3_locked",
		light = "v2a0_dungeon_star_3"
	}
}
VersionActivity2_0DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_0_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_0_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_0_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_0_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_0_OpenTaskView",
	FocusNewElement = "VersionActivity2_0_FocusNewElement"
}
VersionActivity2_0DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	DungeonLastSelectEpisode = "DungeonLastSelectEpisode"
}
VersionActivity2_0DungeonEnum.SceneRootName = "VersionActivity2_0DungeonMapScene"
VersionActivity2_0DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_0DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_0DungeonEnum.MaxHoleNum = 5
VersionActivity2_0DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_0DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_0DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_0DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_0DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_0DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_0DungeonEnum.restaurantElement = 2013001
VersionActivity2_0DungeonEnum.restaurantChapterMap = 2010102

return VersionActivity2_0DungeonEnum
