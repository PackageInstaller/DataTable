-- chunkname: @modules/versionactivitybase/dungeon/define/VersionActivityDungeonBaseEnum.lua

module("modules.versionactivitybase.dungeon.define.VersionActivityDungeonBaseEnum", package.seeall)

local VersionActivityDungeonBaseEnum = _M

VersionActivityDungeonBaseEnum.ModeSelectColor = Color.white
VersionActivityDungeonBaseEnum.ModeDisSelectColor = Color(0.4, 0.4, 0.4, 1)
VersionActivityDungeonBaseEnum.DungeonMode = {
	Story3 = 3,
	Story = 1,
	Hard = 4,
	Story1 = 1,
	Story2 = 2,
	None = 0
}
VersionActivityDungeonBaseEnum.DungeonMode2ChapterIdKey = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "story1ChapterId",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story1] = "story1ChapterId",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "story2ChapterId",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "story3ChapterId",
	[VersionActivityDungeonBaseEnum.DungeonMode.Hard] = "hardChapterId"
}
VersionActivityDungeonBaseEnum.ChapterModeNameKey = {
	[VersionActivityDungeonBaseEnum.DungeonMode.Story] = "p_versionactivitydungeonmaplevelview_type1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story1] = "p_versionactivitydungeonmaplevelview_type1",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story2] = "p_versionactivitydungeonmaplevelview_type2",
	[VersionActivityDungeonBaseEnum.DungeonMode.Story3] = "p_versionactivitydungeonmaplevelview_type3",
	[VersionActivityDungeonBaseEnum.DungeonMode.Hard] = "p_versionactivitydungeonmaplevelview_type4"
}

return VersionActivityDungeonBaseEnum
