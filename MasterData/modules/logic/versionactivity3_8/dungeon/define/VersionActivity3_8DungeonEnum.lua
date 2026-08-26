-- chunkname: @modules/logic/versionactivity3_8/dungeon/define/VersionActivity3_8DungeonEnum.lua

module("modules.logic.versionactivity3_8.dungeon.define.VersionActivity3_8DungeonEnum", package.seeall)

local VersionActivity3_8DungeonEnum = _M

VersionActivity3_8DungeonEnum.DungeonChapterId = {
	ElementFight = 38102,
	Story = 38101,
	Hard = 38201,
	Story1 = 38101,
	Story2 = 38301,
	Story3 = 38401
}
VersionActivity3_8DungeonEnum.EpisodeStarType = {
	[VersionActivity3_8DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_8DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_8DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_8DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_8DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_8_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_8_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_8_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_8_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_8_OpenTaskView",
	FocusNewElement = "VersionActivity3_8_FocusNewElement"
}
VersionActivity3_8DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_8DungeonEnum.SceneRootName = "VersionActivity3_8DungeonMapScene"
VersionActivity3_8DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_8DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_8DungeonEnum.MaxHoleNum = 5
VersionActivity3_8DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_8DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_8DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_8DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_8DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_8DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_8DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity3_8DungeonEnum
