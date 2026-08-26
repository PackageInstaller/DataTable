-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleMazeDrawMO.lua

module("modules.logic.dungeon.model.DungeonPuzzleMazeDrawMO", package.seeall)

local DungeonPuzzleMazeDrawMO = pureTable("DungeonPuzzleMazeDrawMO")

function DungeonPuzzleMazeDrawMO:initByPos(x, y, objType, val)
	self.x, self.y = x, y
	self.objType = objType
	self.val = val or 0
	self.isPos = true
end

function DungeonPuzzleMazeDrawMO:initByLine(x1, y1, x2, y2, objType, val)
	self.x1, self.y1, self.x2, self.y2 = x1, y1, x2, y2
	self.objType = objType
	self.val = val or 0
	self.isPos = false
end

return DungeonPuzzleMazeDrawMO
