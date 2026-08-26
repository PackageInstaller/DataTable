-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleCircuitMO.lua

module("modules.logic.dungeon.model.DungeonPuzzleCircuitMO", package.seeall)

local DungeonPuzzleCircuitMO = pureTable("DungeonPuzzleCircuitMO")

function DungeonPuzzleCircuitMO:init(x, y)
	self.x = x
	self.y = y
	self.id = x * 100 + y
	self.value = 0
	self.rawValue = 0
	self.type = 0
end

function DungeonPuzzleCircuitMO:toString()
	return string.format("id:%s,x:%s,y:%s,type:%s,value:%s", self.id, self.x, self.y, self.type, self.value)
end

return DungeonPuzzleCircuitMO
