-- chunkname: @modules/logic/sp01/assassin2/define/VersionActivity2_9DungeonEnum.lua

module("modules.logic.sp01.assassin2.define.VersionActivity2_9DungeonEnum", package.seeall)

local VersionActivity2_9DungeonEnum = _M

VersionActivity2_9DungeonEnum.DungeonChapterId = {
	ElementFight = 305101,
	Story = 305101,
	Hard = 305101,
	Story1 = 305101,
	Story2 = 305301,
	Story3 = 305401
}
VersionActivity2_9DungeonEnum.BlockKey = {
	MapLevelViewPlayUnlockAnim = "VersionActivity2_9_MapLevelViewPlayUnlockAnim",
	MapViewPlayCloseAnim = "VersionActivity2_9_MapViewPlayCloseAnim",
	MapViewPlayOpenAnim = "VersionActivity2_9_MapViewPlayOpenAnim",
	TaskGetReward = "VersionActivity2_9_TaskItemGetReward",
	OpenTaskView = "VersionActivity2_9_OpenTaskView",
	FocusNewElement = "VersionActivity2_9_FocusNewElement"
}
VersionActivity2_9DungeonEnum.PlayerPrefsKey = {
	HasPlayedUnlockHardModeBtnAnim = "HasPlayedUnlockHardModeBtnAnim",
	ActivityDungeonSpecialEpisodeLastSelectMode = "ActivityDungeonSpecialEpisodeLastSelectMode",
	ActivityDungeonSpecialEpisodeLastUnLockMode = "ActivityDungeonSpecialEpisodeLastUnLockMode"
}
VersionActivity2_9DungeonEnum.SceneRootName = "VersionActivity2_9DungeonMapScene"
VersionActivity2_9DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity2_9DungeonEnum.DungeonMapCameraSize = 5
VersionActivity2_9DungeonEnum.MaxHoleNum = 5
VersionActivity2_9DungeonEnum.HoleHalfWidth = 3.5
VersionActivity2_9DungeonEnum.HoleHalfHeight = 1.75
VersionActivity2_9DungeonEnum.HoleAnimDuration = 0.33
VersionActivity2_9DungeonEnum.HoleAnimMaxZ = 3
VersionActivity2_9DungeonEnum.HoleAnimMinZ = 0
VersionActivity2_9DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity2_9DungeonEnum.EpisodeMode2Icon = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeonmap_icon_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeonmap_icon_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeonmap_icon_3"
}
VersionActivity2_9DungeonEnum.EpisodeMode2Bg = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "v2a9_dungeon_progress2_1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "v2a9_dungeon_progress2_2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "v2a9_dungeon_progress2_3"
}
VersionActivity2_9DungeonEnum.LittleGameType = {
	Point = 3,
	Eye = 1,
	Line = 2
}
VersionActivity2_9DungeonEnum.LittleGameType2EpisdoeConstId = {
	[VersionActivity2_9DungeonEnum.LittleGameType.Eye] = AssassinEnum.ConstId.EpisodeId_EyeGame,
	[VersionActivity2_9DungeonEnum.LittleGameType.Line] = AssassinEnum.ConstId.EpisodeId_LineGame,
	[VersionActivity2_9DungeonEnum.LittleGameType.Point] = AssassinEnum.ConstId.EpisodeId_PointGame
}
VersionActivity2_9DungeonEnum.LittleGameType2AfterStoryConstId = {
	[VersionActivity2_9DungeonEnum.LittleGameType.Eye] = AssassinEnum.ConstId.AfterStoryId_EyeGame,
	[VersionActivity2_9DungeonEnum.LittleGameType.Line] = AssassinEnum.ConstId.AfterStoryId_LineGame,
	[VersionActivity2_9DungeonEnum.LittleGameType.Point] = AssassinEnum.ConstId.AfterStoryId_PointGame
}
VersionActivity2_9DungeonEnum.LoadWorkType = {
	Layout = 2,
	Scene = 1
}
VersionActivity2_9DungeonEnum.FightGoalItemResUrl = "ui/viewres/sp01/assassin2/v2a9_fightgoalitem.prefab"
VersionActivity2_9DungeonEnum.EpisodeMaxProgress = 1
VersionActivity2_9DungeonEnum.EpisodeSelectDuration = 0.5
VersionActivity2_9DungeonEnum.Map_Visible_Tween_Time = 0.2
VersionActivity2_9DungeonEnum.Map_Hide_Root_PosY = -20
VersionActivity2_9DungeonEnum.TWEEN_TIME = 0.2
VersionActivity2_9DungeonEnum.MapTweenStopLerp = 0.1
VersionActivity2_9DungeonEnum.MapStopVelocityRate = 0.3
VersionActivity2_9DungeonEnum.MapScrollOffsetRate = 0.8
VersionActivity2_9DungeonEnum.Time_FocuysNewEpisode = 0.8
VersionActivity2_9DungeonEnum.MapBgAudioName = "s01_bg"
VersionActivity2_9DungeonEnum.MapMaxPosXRange = 162.3
VersionActivity2_9DungeonEnum.MapFocusScale = 2.3
VersionActivity2_9DungeonEnum.PixelPerUnit = 100
VersionActivity2_9DungeonEnum.MapStartWorldPos = Vector3(0, 0, 0)
VersionActivity2_9DungeonEnum.DNANodeClickSize = Vector2(2, 5)
