-- chunkname: @modules/logic/versionactivity3_1/dungeon/define/VersionActivity3_1DungeonEnum.lua

module("modules.logic.versionactivity3_1.dungeon.define.VersionActivity3_1DungeonEnum", package.seeall)

local VersionActivity3_1DungeonEnum = _M

VersionActivity3_1DungeonEnum.DungeonChapterId = {
	ElementFight = 31102,
	Story = 31101,
	Hard = 31201,
	Story1 = 31101,
	Story2 = 31301,
	Story3 = 31401
}
VersionActivity3_1DungeonEnum.EpisodeStarType = {
	[VersionActivity3_1DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a1_dungeon_star_1_locked",
		light = "v3a1_dungeon_star_1"
	},
	[VersionActivity3_1DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a1_dungeon_star_2_locked",
		light = "v3a1_dungeon_star_2"
	},
	[VersionActivity3_1DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a1_dungeon_star_3_locked",
		light = "v3a1_dungeon_star_3"
	},
	[VersionActivity3_1DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a1_dungeon_star_3_locked",
		light = "v3a1_dungeon_star_3"
	}
}
VersionActivity3_1DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_1_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_1_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_1_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_1_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_1_OpenTaskView",
	FocusNewElement = "VersionActivity3_1_FocusNewElement"
}
VersionActivity3_1DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_1DungeonEnum.SceneRootName = "VersionActivity3_1DungeonMapScene"
VersionActivity3_1DungeonEnum.EpisodeItemMinWidth = 250
VersionActivity3_1DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_1DungeonEnum.MaxHoleNum = 5
VersionActivity3_1DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_1DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_1DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_1DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_1DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_1DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_1DungeonEnum.LevelAnim = {
	loop = "loop",
	right_close = "right_close",
	right_open = "right_open",
	left_close = "left_close",
	left_open = "left_open"
}
VersionActivity3_1DungeonEnum.LevelAnimDelayTime = 0.1

return VersionActivity3_1DungeonEnum
