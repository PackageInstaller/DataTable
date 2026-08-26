-- chunkname: @modules/logic/dungeon/defines/DungeonMazeEnum.lua

module("modules.logic.dungeon.defines.DungeonMazeEnum", package.seeall)

local DungeonMazeEnum = _M

DungeonMazeEnum.WordTxtInterval = 5
DungeonMazeEnum.WordTxtOpen = 0.7
DungeonMazeEnum.WordTxtIdle = 1.1
DungeonMazeEnum.WordTxtClose = 0.5
DungeonMazeEnum.dir = {
	up = 4,
	down = 3,
	left = 1,
	right = 2
}
DungeonMazeEnum.skillState = {
	cooling = 3,
	usable = 1,
	using = 2
}
DungeonMazeEnum.resultStat = {
	"成功",
	"失败",
	"主动中断",
	"重置"
}
DungeonMazeEnum.hideDialogTimeConstId = 2
DungeonMazeEnum.MaxChaosValue = 100

return DungeonMazeEnum
