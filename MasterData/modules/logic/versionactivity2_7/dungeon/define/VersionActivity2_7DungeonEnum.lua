-- chunkname: @modules/logic/versionactivity2_7/dungeon/define/VersionActivity2_7DungeonEnum.lua

module("modules.logic.versionactivity2_7.dungeon.define.VersionActivity2_7DungeonEnum", package.seeall)

local VersionActivity2_7DungeonEnum = _M

VersionActivity2_7DungeonEnum.DungeonChapterId = {
	ElementFight = 27102,
	Story = 27101,
	Hard = 27201,
	Story1 = 27101,
	Story2 = 27301,
	Story3 = 27401
}
VersionActivity2_7DungeonEnum.EpisodeStarType = {
	[VersionActivity2_7DungeonEnum.DungeonChapterId.Story1] = {
		empty = "v2a7_dungeon_star_1_locked",
		light = "v2a7_dungeon_star_1"
	},
	[VersionActivity2_7DungeonEnum.DungeonChapterId.Story2] = {
		empty = "v2a7_dungeon_star_2_locked",
		light = "v2a7_dungeon_star_2"
	},
	[VersionActivity2_7DungeonEnum.DungeonChapterId.Story3] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	},
	[VersionActivity2_7DungeonEnum.DungeonChapterId.Hard] = {
		empty = "v2a7_dungeon_star_3_locked",
		light = "v2a7_dungeon_star_3"
	}
}
VersionActivity2_7DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_7_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_7_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_7_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_7_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_7_OpenTaskView",
	FocusNewElement = "VersionActivity2_7_FocusNewElement"
}
VersionActivity2_7DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	OpenHardModeUnlockTip = "OpenHardModeUnlockTip",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode"
}
VersionActivity2_7DungeonEnum.SceneRootName = "VersionActivity2_7DungeonMapScene"
VersionActivity2_7DungeonEnum.EpisodeItemMinWidth = 250
VersionActivity2_7DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_7DungeonEnum.MaxHoleNum = 5
VersionActivity2_7DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_7DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_7DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_7DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_7DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_7DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_7DungeonEnum.SpaceSceneEpisodeIndexs = {
	18,
	19
}
VersionActivity2_7DungeonEnum.SceneLoadObj = "ui/viewres/versionactivity_2_7/v2a7_enter/v2a7_m_s08_hddt.prefab"
VersionActivity2_7DungeonEnum.SceneLoadAnim = "ui/animations/dynamic/hddt_camer.controller"
VersionActivity2_7DungeonEnum.SpaceScene = "scenes/v2a7_m_s08_hddt/scenes_prefab/v2a7_m_s08_hddt_002_p.prefab"
VersionActivity2_7DungeonEnum.GotoSpaceAnimName = "switch1"
VersionActivity2_7DungeonEnum.returnAnimName = "switch2"
VersionActivity2_7DungeonEnum.DragEndAnimTime = 1.2
VersionActivity2_7DungeonEnum.DragSpeed = 1
VersionActivity2_7DungeonEnum.SceneAnimType = {
	Normal = 3,
	ReturnEarth = 2,
	GotoSpace = 1
}

return VersionActivity2_7DungeonEnum
