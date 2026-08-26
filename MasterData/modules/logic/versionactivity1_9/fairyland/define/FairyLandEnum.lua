-- chunkname: @modules/logic/versionactivity1_9/fairyland/define/FairyLandEnum.lua

module("modules.logic.versionactivity1_9.fairyland.define.FairyLandEnum", package.seeall)

local FairyLandEnum = _M

FairyLandEnum.ElementId = 100701
FairyLandEnum.StartCameraPosX = 228
FairyLandEnum.StartCameraPosY = 199
FairyLandEnum.ElementType = {
	Text = 999,
	NPC = 6,
	Character = 1,
	Rectangle = 5,
	Door = 7,
	Triangle = 4,
	Circle = 2,
	Square = 3
}
FairyLandEnum.ConfigType2ElementType = {
	[0] = FairyLandEnum.ElementType.Character,
	FairyLandEnum.ElementType.Circle,
	FairyLandEnum.ElementType.NPC,
	FairyLandEnum.ElementType.Square,
	FairyLandEnum.ElementType.NPC,
	FairyLandEnum.ElementType.Triangle,
	FairyLandEnum.ElementType.NPC,
	FairyLandEnum.ElementType.Rectangle,
	FairyLandEnum.ElementType.NPC,
	FairyLandEnum.ElementType.Door
}
FairyLandEnum.ShapeState = {
	Hide = 4,
	LockClick = 3,
	CanClick = 1,
	NextCanClick = 2
}
FairyLandEnum.DialogType = {
	Bubble = 1,
	Option = 2
}
FairyLandEnum.Puzzle2ShapeType = {
	1,
	2,
	3,
	[10] = 4
}

return FairyLandEnum
