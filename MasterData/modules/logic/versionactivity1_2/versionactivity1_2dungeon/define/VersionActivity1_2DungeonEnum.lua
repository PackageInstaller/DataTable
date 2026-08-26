-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeon/define/VersionActivity1_2DungeonEnum.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeon.define.VersionActivity1_2DungeonEnum", package.seeall)

local VersionActivity1_2DungeonEnum = _M

VersionActivity1_2DungeonEnum.DungeonChapterId = {
	Activity1_2DungeonNormal2 = 12301,
	Activity1_2DungeonHard = 12201,
	Activity1_2DungeonNormal3 = 12401,
	Activity1_2DungeonNormal1 = 12101
}
VersionActivity1_2DungeonEnum.DungeonMode = {
	Hard = 2,
	Story = 1
}
VersionActivity1_2DungeonEnum.DungeonChapterId2ViewShowId = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
}
VersionActivity1_2DungeonEnum.DungeonChapterId2UIModel = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = 1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2] = 1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3] = 1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard] = 2
}
VersionActivity1_2DungeonEnum.DungeonChapterIdChangeModel = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
}
VersionActivity1_2DungeonEnum.DungeonChapterId2EndChapterId = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3
}
VersionActivity1_2DungeonEnum.DungeonChapterId2StartChapterId = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1,
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1
}
VersionActivity1_2DungeonEnum.DungeonChapterId2ActivityID = {
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal1] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal2] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonNormal3] = VersionActivity1_2DungeonModel.instance:getCurActivityID(),
	[VersionActivity1_2DungeonEnum.DungeonChapterId.Activity1_2DungeonHard] = VersionActivity1_2DungeonModel.instance:getCurActivityID()
}

return VersionActivity1_2DungeonEnum
