-- chunkname: @modules/logic/versionactivity/define/VersionActivityEnum.lua

module("modules.logic.versionactivity.define.VersionActivityEnum", package.seeall)

local VersionActivityEnum = _M

VersionActivityEnum.DungeonMapCameraSize = 6.75
VersionActivityEnum.PuzzleColorEnum = {
	MatchErrorColor = "#725f5a",
	MatchCorrectColor = "#833d00"
}
VersionActivityEnum.ActivityId = {
	Act111 = 11113,
	Act108 = 11102,
	SeasonStore = 11115,
	Act104 = 11100,
	Act106 = 11111,
	Act112 = 11114,
	Act121 = 11209,
	Act109 = 11103,
	Act113 = 11104,
	Act105 = 11101,
	Act107 = 11112
}
VersionActivityEnum.EnterViewActIdList = {
	VersionActivityEnum.ActivityId.Act113,
	VersionActivityEnum.ActivityId.Act104,
	VersionActivityEnum.ActivityId.Act112,
	VersionActivityEnum.ActivityId.Act109,
	VersionActivityEnum.ActivityId.Act111,
	VersionActivityEnum.ActivityId.Act108
}
VersionActivityEnum.DungeonChapterId = {
	LeiMiTeBei4 = 11401,
	LeiMiTeBeiHard = 11201,
	LeiMiTeBei3 = 11301,
	ElementFight = 11102,
	LeiMiTeBei = 11101
}
VersionActivityEnum.ZeroEpisodeId = {
	Hard = 1120100,
	Story = 1110100
}
VersionActivityEnum.EpisodeItemMinWidth = 300
VersionActivityEnum.FirstVersionActivityPuzzleElementId = 11101061
VersionActivityEnum.EnterViewNormalAnimationPath = {
	[VersionActivityEnum.ActivityId.Act113] = "normal",
	[VersionActivityEnum.ActivityId.Act104] = "normal/changeColorContainer"
}

return VersionActivityEnum
