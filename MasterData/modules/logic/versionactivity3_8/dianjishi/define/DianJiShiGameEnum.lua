-- chunkname: @modules/logic/versionactivity3_8/dianjishi/define/DianJiShiGameEnum.lua

module("modules.logic.versionactivity3_8.dianjishi.define.DianJiShiGameEnum", package.seeall)

local DianJiShiGameEnum = _M

DianJiShiGameEnum.OpType = {
	Remove = 2,
	Placed = 1
}
DianJiShiGameEnum.AreaTipsDir = {
	RightBottom = 4,
	LeftTop = 1,
	LeftBottom = 2,
	RightTop = 3
}
DianJiShiGameEnum.GameStatus = {
	Running = 1,
	Failed = 3,
	Success = 2
}
DianJiShiGameEnum.BlockStatus = {
	Placed = 2,
	Drag = 3,
	Wait = 1
}
DianJiShiGameEnum.ShadowType = {
	LeftTopAndTop = 6,
	LeftAndTop = 3,
	LeftAndLeftTop = 5,
	Top = 2,
	LeftTop = 4,
	Left = 1,
	None = 0
}
DianJiShiGameEnum.ShadowIcon = {
	[DianJiShiGameEnum.ShadowType.Left] = "v3a8_dianjishi_game_blockshadow5",
	[DianJiShiGameEnum.ShadowType.Top] = "v3a8_dianjishi_game_blockshadow6",
	[DianJiShiGameEnum.ShadowType.LeftAndTop] = "v3a8_dianjishi_game_blockshadow1",
	[DianJiShiGameEnum.ShadowType.LeftTop] = "v3a8_dianjishi_game_blockshadow4",
	[DianJiShiGameEnum.ShadowType.LeftAndLeftTop] = "v3a8_dianjishi_game_blockshadow2",
	[DianJiShiGameEnum.ShadowType.LeftTopAndTop] = "v3a8_dianjishi_game_blockshadow3"
}
DianJiShiGameEnum.NoneWaitBlockAlpha = 0.66
DianJiShiGameEnum.WaitBlockFrontHeight = 82
DianJiShiGameEnum.MapCellSize = {
	182,
	181
}
DianJiShiGameEnum.WaitBlockSpaceSize = {
	130,
	130
}
DianJiShiGameEnum.MinWaitBlockSize = {
	236,
	236
}
DianJiShiGameEnum.WaitBlockTagScale = 2
DianJiShiGameEnum.DragBlockTagScale = 1
DianJiShiGameEnum.UnfinishCountColor = "#FF001B"
DianJiShiGameEnum.FinishCountColor = "#25FF00"
DianJiShiGameEnum.GuideHoleSpace = {
	100,
	100
}
DianJiShiGameEnum.GuideHandMoveDuration = 2

return DianJiShiGameEnum
