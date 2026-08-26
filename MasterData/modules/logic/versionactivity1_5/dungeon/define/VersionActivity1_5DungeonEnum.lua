-- chunkname: @modules/logic/versionactivity1_5/dungeon/define/VersionActivity1_5DungeonEnum.lua

module("modules.logic.versionactivity1_5.dungeon.define.VersionActivity1_5DungeonEnum", package.seeall)

local VersionActivity1_5DungeonEnum = _M

VersionActivity1_5DungeonEnum.DungeonMapCameraSize = 5
VersionActivity1_5DungeonEnum.DungeonChapterId = {
	ElementFight = 15102,
	Story = 15101,
	Hard = 15201,
	Story1 = 15101,
	Story4 = 15201,
	Story2 = 15301,
	Story3 = 15401
}
VersionActivity1_5DungeonEnum.SceneRootName = "VersionActivity1_5DungeonMapScene"
VersionActivity1_5DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity1_5DungeonEnum.EpisodeStarType = {
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story1] = "v1a5_dungeon_star_2",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story2] = "v1a5_dungeon_star_3",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story3] = "v1a5_dungeon_star_5",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story4] = "v1a5_dungeon_star_5"
}
VersionActivity1_5DungeonEnum.EpisodeStarEmptyType = {
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story1] = "v1a5_dungeon_star_1",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story2] = "v1a5_dungeon_star_1",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story3] = "v1a5_dungeon_star_4",
	[VersionActivity1_5DungeonEnum.DungeonChapterId.Story4] = "v1a5_dungeon_star_4"
}
VersionActivity1_5DungeonEnum.SceneEffect = {
	DayTime = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_a.prefab",
	Night = "scenes/v1a5_m_s14_hddt_hd/scenes_prefab/hddt_fog_b.prefab"
}
VersionActivity1_5DungeonEnum.MapId2Light = {
	[1510101] = true,
	[1510108] = true,
	[1510115] = true,
	[1510107] = true,
	[1510114] = false,
	[1510106] = true,
	[1510113] = false,
	[1510105] = true,
	[1510112] = false,
	[1510104] = false,
	[1510111] = false,
	[1510103] = true,
	[1510110] = true,
	[1510102] = true,
	[1510109] = true
}
VersionActivity1_5DungeonEnum.ElementTimeOffsetY = 0.8
VersionActivity1_5DungeonEnum.HardModeUnlockAnimDuration = 1.33
VersionActivity1_5DungeonEnum.MapDir = {
	Top = 3,
	Left = 1,
	Right = 2,
	Bottom = 4
}
VersionActivity1_5DungeonEnum.MapDirCenterViewPortPos = Vector2(0.5, 0.5)
VersionActivity1_5DungeonEnum.MapRateEqualRange = 0.001
VersionActivity1_5DungeonEnum.MapHeroItemAnchorYOffset = 10
VersionActivity1_5DungeonEnum.OutSideAreaPos = {
	X = -1000,
	Y = -1000
}
VersionActivity1_5DungeonEnum.MaxHoleNum = 5
VersionActivity1_5DungeonEnum.HoleHalfWidth = 3.5
VersionActivity1_5DungeonEnum.HoleHalfHeight = 1.75
VersionActivity1_5DungeonEnum.HoleAnimDuration = 0.33
VersionActivity1_5DungeonEnum.HoleAnimMaxZ = 3
VersionActivity1_5DungeonEnum.HoleAnimMinZ = 0
VersionActivity1_5DungeonEnum.AreaItemOffsetY = 36
VersionActivity1_5DungeonEnum.DispatchStatus = {
	Finished = 3,
	NotDispatch = 1,
	Dispatching = 2
}
VersionActivity1_5DungeonEnum.ExploreTaskId = 0
VersionActivity1_5DungeonEnum.ExploreTaskLineCount = 20
VersionActivity1_5DungeonEnum.ExploreTipOffsetX = 55
VersionActivity1_5DungeonEnum.ExploreTipAnchorY = {
	Max = 180,
	Min = -220
}
VersionActivity1_5DungeonEnum.ExploreTabImageSelect = "v1a5_revival_btn_hotspot1"
VersionActivity1_5DungeonEnum.ExploreTabImageNotSelect = "v1a5_revival_btn_hotspot1_1"
VersionActivity1_5DungeonEnum.ExploreProgressPointLight = "v1a5_revival_img_point1_2"
VersionActivity1_5DungeonEnum.ExploreProgressPointDark = "v1a5_revival_img_point1_1"
VersionActivity1_5DungeonEnum.ExploreTaskUnLockType = {
	FinishAnyOneElement = 4,
	FinishEpisodeAndAnyOneElement = 5,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishElementAndEpisode = 3
}
VersionActivity1_5DungeonEnum.ExploreTaskType = {
	Fight = 2,
	Dispatch = 1
}
VersionActivity1_5DungeonEnum.ExploreTaskStatus = {
	GainedReward = 5,
	Running = 3,
	Finished = 4,
	Lock = 1,
	Normal = 2
}
VersionActivity1_5DungeonEnum.SubHeroTaskStatus = {
	Finished = 3,
	GainedReward = 4,
	Lock = 1,
	Normal = 2
}
VersionActivity1_5DungeonEnum.DispatchShortedType = {
	Career = 1,
	HeroId = 2
}
VersionActivity1_5DungeonEnum.SubHeroTaskUnLockType = {
	FinishElementAndEpisode = 4,
	FinishSubHeroTask = 3,
	FinishElement = 1,
	FinishEpisode = 2,
	FinishSubHeroTaskAndEpisode = 5
}
VersionActivity1_5DungeonEnum.HeroTaskDescShowCount = 90
VersionActivity1_5DungeonEnum.Suffix = string.rep(".", 3)
VersionActivity1_5DungeonEnum.HeroTaskRedDotAnchor = {
	Lock = Vector2(-100, 88),
	Normal = Vector2(-124, 95)
}
VersionActivity1_5DungeonEnum.BuildType = {
	First = 1,
	Second = 2,
	None = 0
}
VersionActivity1_5DungeonEnum.BuildType2SmallImage = {
	[VersionActivity1_5DungeonEnum.BuildType.First] = "v1a5_building_smallicon_1",
	[VersionActivity1_5DungeonEnum.BuildType.Second] = "v1a5_building_smallicon_2",
	[VersionActivity1_5DungeonEnum.BuildType.None] = "v1a5_building_smallicon_3"
}
VersionActivity1_5DungeonEnum.BuildType2Image = {
	[VersionActivity1_5DungeonEnum.BuildType.First] = "v1a5_building_icon_1",
	[VersionActivity1_5DungeonEnum.BuildType.Second] = "v1a5_building_icon_2",
	[VersionActivity1_5DungeonEnum.BuildType.None] = "v1a5_building_icon_3"
}
VersionActivity1_5DungeonEnum.BuildType2TitleBgImage = {
	[VersionActivity1_5DungeonEnum.BuildType.None] = "v1a5_building_buffbg_1",
	[VersionActivity1_5DungeonEnum.BuildType.First] = "v1a5_building_buffbg_3",
	[VersionActivity1_5DungeonEnum.BuildType.Second] = "v1a5_building_buffbg_2"
}
VersionActivity1_5DungeonEnum.BuildType2TextColor = {
	[VersionActivity1_5DungeonEnum.BuildType.None] = "#FFFAF3",
	[VersionActivity1_5DungeonEnum.BuildType.First] = "#36AE8B",
	[VersionActivity1_5DungeonEnum.BuildType.Second] = "#FFDC97"
}
VersionActivity1_5DungeonEnum.BuildCount = 3
VersionActivity1_5DungeonEnum.BuildMaxScale = 1.3
VersionActivity1_5DungeonEnum.BuildFocusAnimTime = 0.5
VersionActivity1_5DungeonEnum.SliderAnimTime = 1

return VersionActivity1_5DungeonEnum
