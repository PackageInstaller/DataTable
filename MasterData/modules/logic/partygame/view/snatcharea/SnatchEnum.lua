-- chunkname: @modules/logic/partygame/view/snatcharea/SnatchEnum.lua

module("modules.logic.partygame.view.snatcharea.SnatchEnum", package.seeall)

local SnatchEnum = _M

SnatchEnum.GameState = {
	Settlement = 4,
	Playing = 3,
	ShowOperate = 2,
	StartRound = 1
}
SnatchEnum.AreaType = {
	Two = 2,
	Three = 3,
	Four = 4,
	One = 1,
	None = 0
}
SnatchEnum.ColorId = {
	Blue = 4,
	Red = 2,
	Green = 1,
	Yellow = 3,
	White = 0
}
SnatchEnum.Color = {
	[SnatchEnum.ColorId.White] = "#FFFFFF",
	[SnatchEnum.ColorId.Green] = "#82B873",
	[SnatchEnum.ColorId.Red] = "#CA6E6E",
	[SnatchEnum.ColorId.Yellow] = "#CFB871",
	[SnatchEnum.ColorId.Blue] = "#6298bb"
}
SnatchEnum.Color = {
	[SnatchEnum.AreaType.None] = "#FFFFFF",
	[SnatchEnum.AreaType.One] = "#82B873",
	[SnatchEnum.AreaType.Two] = "#CA6E6E",
	[SnatchEnum.AreaType.Three] = "#CFB871",
	[SnatchEnum.AreaType.Four] = "#6298bb"
}
SnatchEnum.AreaTypeName = {
	[SnatchEnum.AreaType.None] = "空白区域",
	[SnatchEnum.AreaType.One] = "区域1",
	[SnatchEnum.AreaType.Two] = "区域2",
	[SnatchEnum.AreaType.Three] = "区域3",
	[SnatchEnum.AreaType.Four] = "区域4"
}
SnatchEnum.Dir = {
	Up = Vector2(0, -1),
	Down = Vector2(0, 1),
	Left = Vector2(-1, 0),
	Right = Vector2(1, 0)
}
SnatchEnum.Space = 5

return SnatchEnum
