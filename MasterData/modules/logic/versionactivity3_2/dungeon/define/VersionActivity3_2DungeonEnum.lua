-- chunkname: @modules/logic/versionactivity3_2/dungeon/define/VersionActivity3_2DungeonEnum.lua

module("modules.logic.versionactivity3_2.dungeon.define.VersionActivity3_2DungeonEnum", package.seeall)

local VersionActivity3_2DungeonEnum = _M

VersionActivity3_2DungeonEnum.DungeonChapterId = {
	ElementFight = 32102,
	Story = 32101,
	Hard = 32201,
	Story1 = 32101,
	Story2 = 32301,
	Story3 = 32401
}
VersionActivity3_2DungeonEnum.EpisodeStarType = {
	[VersionActivity3_2DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_2DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_2DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_2DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_2DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_2_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_2_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_2_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_2_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_2_OpenTaskView",
	FocusNewElement = "VersionActivity3_2_FocusNewElement"
}
VersionActivity3_2DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_2DungeonEnum.SceneRootName = "VersionActivity3_2DungeonMapScene"
VersionActivity3_2DungeonEnum.EpisodeItemMinWidth = 250
VersionActivity3_2DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_2DungeonEnum.MaxHoleNum = 5
VersionActivity3_2DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_2DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_2DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_2DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_2DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_2DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_2DungeonEnum.LevelAnim = {
	loop = "loop",
	right_close = "right_close",
	right_open = "right_open",
	left_close = "left_close",
	left_open = "left_open"
}
VersionActivity3_2DungeonEnum.LevelAnimDelayTime = 0.1

return VersionActivity3_2DungeonEnum
