-- chunkname: @modules/logic/dungeonmazev3a7/defines/DungeonMazeV3a7Event.lua

module("modules.logic.dungeonmazev3a7.defines.DungeonMazeV3a7Event", package.seeall)

local DungeonMazeV3a7Event = _M
local _get = GameUtil.getUniqueTb()

DungeonMazeV3a7Event.EnterDungeonMazeV3a7 = _get()
DungeonMazeV3a7Event.DungeonMazeV3a7Completed = _get()
DungeonMazeV3a7Event.DungeonMazeV3a7Exit = _get()
DungeonMazeV3a7Event.DungeonMazeV3a7ReStart = _get()
DungeonMazeV3a7Event.ShowMazeObstacleDialog = _get()
DungeonMazeV3a7Event.ArriveMazeGameCell = _get()
