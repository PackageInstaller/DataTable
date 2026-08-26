-- chunkname: @modules/logic/versionactivity3_9/dungeon/define/VersionActivity3_9DungeonEnum.lua

module("modules.logic.versionactivity3_9.dungeon.define.VersionActivity3_9DungeonEnum", package.seeall)

local VersionActivity3_9DungeonEnum = _M

VersionActivity3_9DungeonEnum.DungeonChapterId = {
	ElementFight = 39102,
	Story = 39101,
	Hard = 39201,
	Story1 = 39101,
	Story2 = 39301,
	Story3 = 39401
}
VersionActivity3_9DungeonEnum.EpisodeStarType = {
	[VersionActivity3_9DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_9DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_9DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_9DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_9DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_9_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_9_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_9_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_9_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_9_OpenTaskView",
	FocusNewElement = "VersionActivity3_9_FocusNewElement"
}
VersionActivity3_9DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_9DungeonEnum.SceneRootName = "VersionActivity3_9DungeonMapScene"
VersionActivity3_9DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_9DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_9DungeonEnum.MaxHoleNum = 5
VersionActivity3_9DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_9DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_9DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_9DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_9DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_9DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_9DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity3_9DungeonEnum
