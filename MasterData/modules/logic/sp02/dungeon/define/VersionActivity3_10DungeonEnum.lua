-- chunkname: @modules/logic/sp02/dungeon/define/VersionActivity3_10DungeonEnum.lua

module("modules.logic.sp02.dungeon.define.VersionActivity3_10DungeonEnum", package.seeall)

local VersionActivity3_10DungeonEnum = _M

VersionActivity3_10DungeonEnum.DungeonChapterId = {
	ElementFight = 385601,
	Story = 385101,
	Hard = 385201,
	Story1 = 385101,
	Story2 = 385301,
	Story3 = 385401
}
VersionActivity3_10DungeonEnum.SceneRootName = "VersionActivity3_10_DungeonMap"
VersionActivity3_10DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity3_10_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity3_10_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity3_10_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity3_10_TaskItemGetReward",
	OpenTaskView = "VersionActivity3_10_OpenTaskView",
	FocusNewElement = "VersionActivity3_10_FocusNewElement"
}
VersionActivity3_10DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode",
	HasUnlockEpisode = "HasUnlockEpisode"
}
VersionActivity3_10DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity3_10DungeonEnum.DungeonMapCameraSize = 5
VersionActivity3_10DungeonEnum.MaxHoleNum = 5
VersionActivity3_10DungeonEnum.HoleHalfWidth = 3.5
VersionActivity3_10DungeonEnum.HoleHalfHeight = 1.75
VersionActivity3_10DungeonEnum.HoleAnimDuration = 0.33
VersionActivity3_10DungeonEnum.HoleAnimMaxZ = 3
VersionActivity3_10DungeonEnum.HoleAnimMinZ = 0
VersionActivity3_10DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity3_10DungeonEnum.EpisodeMode2Icon = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeonmap_icon_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeonmap_icon_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeonmap_icon_3"
}
VersionActivity3_10DungeonEnum.EpisodeMode2Bg = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeon_progress2_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeon_progress2_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeon_progress2_3"
}
VersionActivity3_10DungeonEnum.EpisodeMaxProgress = 1
VersionActivity3_10DungeonEnum.EpisodeSelectDuration = 0.5
VersionActivity3_10DungeonEnum.Map_Visible_Tween_Time = 0.2
VersionActivity3_10DungeonEnum.Map_Hide_Root_PosY = -20
VersionActivity3_10DungeonEnum.TWEEN_TIME = 0.2
VersionActivity3_10DungeonEnum.MapTweenStopLerp = 0.1
VersionActivity3_10DungeonEnum.MapStopVelocityRate = 0.3
VersionActivity3_10DungeonEnum.MapScrollOffsetRate = 0.8
VersionActivity3_10DungeonEnum.Time_FocuysNewEpisode = 0.8
VersionActivity3_10DungeonEnum.MapBgAudioName = "s01_bg"
VersionActivity3_10DungeonEnum.PixelPerUnit = 100
VersionActivity3_10DungeonEnum.MapStartWorldPos = Vector3(0, 0, 0)
