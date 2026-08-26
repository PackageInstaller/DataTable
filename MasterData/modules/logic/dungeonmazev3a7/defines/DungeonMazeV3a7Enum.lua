-- chunkname: @modules/logic/dungeonmazev3a7/defines/DungeonMazeV3a7Enum.lua

module("modules.logic.dungeonmazev3a7.defines.DungeonMazeV3a7Enum", package.seeall)

local DungeonMazeV3a7Enum = _M

DungeonMazeV3a7Enum.FirstGuideId = 37001
DungeonMazeV3a7Enum.WordTxtInterval = 5
DungeonMazeV3a7Enum.WordTxtOpen = 0.7
DungeonMazeV3a7Enum.WordTxtIdle = 1.1
DungeonMazeV3a7Enum.WordTxtClose = 0.5
DungeonMazeV3a7Enum.dir = {
	up = 4,
	down = 3,
	left = 1,
	right = 2
}
DungeonMazeV3a7Enum.skillState = {
	cooling = 3,
	usable = 1,
	using = 2
}
DungeonMazeV3a7Enum.resultStat = {
	"成功",
	"失败",
	"主动中断",
	"重置"
}
DungeonMazeV3a7Enum.RoleOrder = {
	PlayerVertin = 1,
	Player14 = 0
}
DungeonMazeV3a7Enum.MazeGamePlayEpisode = {
	[11316] = true
}
DungeonMazeV3a7Enum.CellType = {
	End = 2,
	Road = 1,
	Obstacle = 4,
	Start = 3,
	None = 0
}
DungeonMazeV3a7Enum.hideDialogTimeConstId = 2
DungeonMazeV3a7Enum.MaxChaosValue = 100

return DungeonMazeV3a7Enum
