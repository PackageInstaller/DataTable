-- chunkname: @modules/logic/versionactivity3_5/dungeon/define/VersionActivity3_5DungeonEnum.lua

module("modules.logic.versionactivity3_5.dungeon.define.VersionActivity3_5DungeonEnum", package.seeall)

local VersionActivity3_5DungeonEnum = _M

VersionActivity3_5DungeonEnum.DungeonChapterId = {
	ElementFight = 35102,
	Story = 35101,
	Hard = 35201,
	Story1 = 35101,
	Story2 = 35301,
	Story3 = 35401
}
VersionActivity3_5DungeonEnum.EpisodeStarType = {
	[VersionActivity3_5DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_5DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_5DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_5DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_5DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_5_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_5_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_5_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_5_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_5_OpenTaskView",
	FocusNewElement = "VersionActivity3_5_FocusNewElement"
}
VersionActivity3_5DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_5DungeonEnum.SceneRootName = "VersionActivity3_5DungeonMapScene"
VersionActivity3_5DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_5DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_5DungeonEnum.MaxHoleNum = 5
VersionActivity3_5DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_5DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_5DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_5DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_5DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_5DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_5DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity3_5DungeonEnum
