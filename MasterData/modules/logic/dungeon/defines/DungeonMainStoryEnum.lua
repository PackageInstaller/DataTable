-- chunkname: @modules/logic/dungeon/defines/DungeonMainStoryEnum.lua

module("modules.logic.dungeon.defines.DungeonMainStoryEnum", package.seeall)

local DungeonMainStoryEnum = _M

DungeonMainStoryEnum.ChapterWidth = {
	Special = 270,
	Section = 410,
	Normal = 340
}
DungeonMainStoryEnum.ChapterPosY = {
	Special = -110,
	Section = -100,
	Normal = -100
}
DungeonMainStoryEnum.ChapterStartPosX = 80
DungeonMainStoryEnum.SectionSpace = 100
DungeonMainStoryEnum.ChapterSpace = 0
DungeonMainStoryEnum.TipLineWidthOffsetX = -67
DungeonMainStoryEnum.FlowTipOffsetX = -80
DungeonMainStoryEnum.FlowLineOffsetWidth = 44
DungeonMainStoryEnum.FlowLineMinWidth = 392
DungeonMainStoryEnum.AnimTime = 0.16
DungeonMainStoryEnum.SectionAnimTime = 0.4
DungeonMainStoryEnum.FirstSectionId = 1
DungeonMainStoryEnum.PreviewOffsetX = 20
DungeonMainStoryEnum.Guide = {
	EarlyAccess = 28006,
	PreviouslyOn = 28005
}

return DungeonMainStoryEnum
