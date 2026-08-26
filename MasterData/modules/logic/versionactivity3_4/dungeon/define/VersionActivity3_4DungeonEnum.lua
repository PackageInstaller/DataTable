-- chunkname: @modules/logic/versionactivity3_4/dungeon/define/VersionActivity3_4DungeonEnum.lua

module("modules.logic.versionactivity3_4.dungeon.define.VersionActivity3_4DungeonEnum", package.seeall)

local VersionActivity3_4DungeonEnum = _M

VersionActivity3_4DungeonEnum.DungeonChapterId = {
	ElementFight = 34102,
	Story = 34101,
	Hard = 34201,
	Story1 = 34101,
	Story2 = 34301,
	Story3 = 34401
}
VersionActivity3_4DungeonEnum.EpisodeStarType = {
	[VersionActivity3_4DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_4DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_4DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_4DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_4DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_4_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_4_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_4_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_4_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_4_OpenTaskView",
	FocusNewElement = "VersionActivity3_4_FocusNewElement"
}
VersionActivity3_4DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_4DungeonEnum.SceneRootName = "VersionActivity3_4DungeonMapScene"
VersionActivity3_4DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_4DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_4DungeonEnum.MaxHoleNum = 5
VersionActivity3_4DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_4DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_4DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_4DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_4DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_4DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_4DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity3_4DungeonEnum
