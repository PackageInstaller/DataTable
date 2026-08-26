-- chunkname: @modules/logic/versionactivity2_3/zhixinquaner/maze/base/define/PuzzleEnum.lua

module("modules.logic.versionactivity2_3.zhixinquaner.maze.base.define.PuzzleEnum", package.seeall)

local PuzzleEnum = _M

PuzzleEnum.dir = {
	down = 2,
	up = 8,
	left = 4,
	right = 6
}
PuzzleEnum.mazeDrawWidth = 4
PuzzleEnum.mazeDrawHeight = 3
PuzzleEnum.mazeUIGridWidth = 204
PuzzleEnum.mazeUIGridHeight = 204
PuzzleEnum.mazeUILineWidth = 176
PuzzleEnum.mazeUILineHorizonUIWidth = 204
PuzzleEnum.mazeUILineVerticalUIWidth = 204
PuzzleEnum.mazeMonsterHeight = 102
PuzzleEnum.mazeMonsterTouchOffsetX = 0
PuzzleEnum.MazeObjType = {
	End = 2,
	Switch = 5,
	CheckPoint = 4,
	Start = 1,
	Block = 3
}
PuzzleEnum.MazeObjSubType = {
	Default = 1
}
PuzzleEnum.MazeAlertBlockOffsetX, PuzzleEnum.MazeAlertBlockOffsetY = 90.8, 48.5
PuzzleEnum.MazeAlertCrossOffsetX, PuzzleEnum.MazeAlertCrossOffsetY = 25.3, 33.1
PuzzleEnum.MazePawnPath = {
	"ui_maze_pawn",
	3.1,
	65.5
}
PuzzleEnum.MazeMonsterIconOffset = {
	x = 0,
	y = 70.4
}
PuzzleEnum.MazeAlertResPath = "ui_maze_alert"
PuzzleEnum.AnimEvent_OnJump = "OnJump"
PuzzleEnum.MazeAlertType = {
	VisitBlock = 1,
	VisitRepeat = 2,
	DisconnectLine = 3,
	None = 0
}
PuzzleEnum.LineType = {
	Path = 2,
	Map = 1
}
PuzzleEnum.LineState = {
	Disconnect = 1,
	Switch_On = 3,
	Connect = 0,
	Switch_Off = 2
}
PuzzleEnum.PositionType = {
	Line = 2,
	Point = 1
}
PuzzleEnum.EffectType = {
	Guide = 3,
	Story = 2,
	Dialog = 1
}
PuzzleEnum.InteractIndexIcon = {
	"bianhao_a",
	"bianhao_b",
	"bianhao_c",
	"bianhao_d",
	"bianhao_e"
}
PuzzleEnum.GameResult = {
	Abort = 3,
	Restart = 4,
	Failed = 2,
	Success = 1
}

return PuzzleEnum
