-- chunkname: @modules/logic/versionactivity3_6/dungeon/define/VersionActivity3_6DungeonEnum.lua

module("modules.logic.versionactivity3_6.dungeon.define.VersionActivity3_6DungeonEnum", package.seeall)

local VersionActivity3_6DungeonEnum = _M

VersionActivity3_6DungeonEnum.DungeonChapterId = {
	ElementFight = 36102,
	Story = 36101,
	Hard = 36201,
	Story1 = 36101,
	Story2 = 36301,
	Story3 = 36401
}
VersionActivity3_6DungeonEnum.EpisodeStarType = {
	[VersionActivity3_6DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v3a2_dungeon_star_1_locked",
		light = "v3a2_dungeon_star_1"
	},
	[VersionActivity3_6DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v3a2_dungeon_star_2_locked",
		light = "v3a2_dungeon_star_2"
	},
	[VersionActivity3_6DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	},
	[VersionActivity3_6DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v3a2_dungeon_star_3_locked",
		light = "v3a2_dungeon_star_3"
	}
}
VersionActivity3_6DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_6_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_6_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_6_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_6_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_6_OpenTaskView",
	FocusNewElement = "VersionActivity3_6_FocusNewElement"
}
VersionActivity3_6DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity3_6DungeonEnum.SceneRootName = "VersionActivity3_6DungeonMapScene"
VersionActivity3_6DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_6DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_6DungeonEnum.MaxHoleNum = 5
VersionActivity3_6DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_6DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_6DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_6DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_6DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_6DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_6DungeonEnum.MapLevelCostPowerNormalColor = "#FFFFFF"

return VersionActivity3_6DungeonEnum
