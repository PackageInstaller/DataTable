-- chunkname: @modules/logic/versionactivity3_0/karong/define/KaRongDrawEnum.lua

module("modules.logic.versionactivity3_0.karong.define.KaRongDrawEnum", package.seeall)

local KaRongDrawEnum = _M

KaRongDrawEnum.dir = {
	down = -2,
	up = 2,
	left = -1,
	right = 1
}
KaRongDrawEnum.mazeDrawWidth = 7
KaRongDrawEnum.mazeDrawHeight = 4
KaRongDrawEnum.mazeUIGridWidth = 205
KaRongDrawEnum.mazeUIGridHeight = 205
KaRongDrawEnum.mazeUILineWidth = 176
KaRongDrawEnum.mazeUILineHorizonUIWidth = 204
KaRongDrawEnum.mazeUILineVerticalUIWidth = 204
KaRongDrawEnum.mazeMonsterHeight = 75
KaRongDrawEnum.mazeMonsterTouchOffsetX = 0
KaRongDrawEnum.MazeObjType = {
	CheckPoint = 4,
	End = 2,
	Start = 1,
	Block = 3
}
KaRongDrawEnum.MazeObjSubType = {
	Two = 2,
	Default = 1,
	Three = 3
}
KaRongDrawEnum.MazeAlertBlockOffsetX, KaRongDrawEnum.MazeAlertBlockOffsetY = 90.8, 48.5
KaRongDrawEnum.MazeAlertCrossOffsetX, KaRongDrawEnum.MazeAlertCrossOffsetY = 25.3, 33.1
KaRongDrawEnum.MazeMonsterIconOffset = {
	x = 0,
	y = 50
}
KaRongDrawEnum.MazeAlertResPath = "ui_maze_alert"
KaRongDrawEnum.AnimEvent_OnJump = "OnJump"
KaRongDrawEnum.MazeAlertType = {
	VisitBlock = 1,
	VisitRepeat = 2,
	DisconnectLine = 3,
	None = 0
}
KaRongDrawEnum.LineType = {
	Path = 2,
	Map = 1
}
KaRongDrawEnum.LineState = {
	Disconnect = 1,
	Switch_On = 3,
	Connect = 0,
	Switch_Off = 2
}
KaRongDrawEnum.PositionType = {
	Line = 2,
	Point = 1
}
KaRongDrawEnum.EffectType = {
	Guide = 3,
	Story = 2,
	Dialog = 1,
	AddSkill = 5,
	PopView = 4
}
KaRongDrawEnum.InteractIndexIcon = {
	"bianhao_a",
	"bianhao_b",
	"bianhao_c",
	"bianhao_d",
	"bianhao_e"
}
KaRongDrawEnum.GameResult = {
	Abort = 3,
	Restart = 4,
	Failed = 2,
	Success = 1
}

return KaRongDrawEnum
