-- chunkname: @modules/logic/dungeon/defines/DungeonMazeEvent.lua

module("modules.logic.dungeon.defines.DungeonMazeEvent", package.seeall)

local DungeonMazeEvent = _M
local _get = GameUtil.getUniqueTb()

DungeonMazeEvent.EnterDungeonMaze = _get()
DungeonMazeEvent.DungeonMazeCompleted = _get()
DungeonMazeEvent.DungeonMazeExit = _get()
DungeonMazeEvent.DungeonMazeReStart = _get()
DungeonMazeEvent.ShowMazeObstacleDialog = _get()
DungeonMazeEvent.ArriveMazeGameCell = _get()
