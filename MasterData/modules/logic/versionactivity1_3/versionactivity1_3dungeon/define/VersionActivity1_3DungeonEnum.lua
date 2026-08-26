-- chunkname: @modules/logic/versionactivity1_3/versionactivity1_3dungeon/define/VersionActivity1_3DungeonEnum.lua

module("modules.logic.versionactivity1_3.versionactivity1_3dungeon.define.VersionActivity1_3DungeonEnum", package.seeall)

local VersionActivity1_3DungeonEnum = _M

VersionActivity1_3DungeonEnum.DungeonMapCameraSize = 5
VersionActivity1_3DungeonEnum.DungeonChapterId = {
	LeiMiTeBei4 = 13401,
	LeiMiTeBeiHard = 13201,
	LeiMiTeBei3 = 13301,
	ElementFight = 13102,
	Daily = 13501,
	LeiMiTeBei = 13101
}
VersionActivity1_3DungeonEnum.EpisodeStarType = {
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_2",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_4",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_3",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_4"
}
VersionActivity1_3DungeonEnum.EpisodeStarEmptyType = {
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei] = "v1a3_dungeon_star_1",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBeiHard] = "v1a3_dungeon_star_5",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei3] = "v1a3_dungeon_star_1",
	[VersionActivity1_3DungeonEnum.DungeonChapterId.LeiMiTeBei4] = "v1a3_dungeon_star_5"
}
VersionActivity1_3DungeonEnum.ConstKey = {
	Daily = 2
}
VersionActivity1_3DungeonEnum.EpisodeItemMinWidth = 300
VersionActivity1_3DungeonEnum.DailyEpisodeId = 1310108
VersionActivity1_3DungeonEnum.ExtraEpisodeId = 1310194
VersionActivity1_3DungeonEnum.JumpDaily = 10011312

return VersionActivity1_3DungeonEnum
