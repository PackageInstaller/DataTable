-- chunkname: @modules/logic/dungeon/defines/DungeonPuzzleEvent.lua

module("modules.logic.dungeon.defines.DungeonPuzzleEvent", package.seeall)

local DungeonPuzzleEvent = _M

DungeonPuzzleEvent.PipeGameClear = 20
DungeonPuzzleEvent.MazeDrawGameClear = 30
DungeonPuzzleEvent.ChangeColorGameClear = 4000
DungeonPuzzleEvent.InteractClick = 4001
DungeonPuzzleEvent.CircuitClick = 5000
DungeonPuzzleEvent.GuideClickGrid = 6000
DungeonPuzzleEvent.GuideEntryConnectClear = 6001
