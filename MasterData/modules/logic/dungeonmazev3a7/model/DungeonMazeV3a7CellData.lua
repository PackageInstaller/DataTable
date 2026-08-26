-- chunkname: @modules/logic/dungeonmazev3a7/model/DungeonMazeV3a7CellData.lua

module("modules.logic.dungeonmazev3a7.model.DungeonMazeV3a7CellData", package.seeall)

local DungeonMazeV3a7CellData = pureTable("DungeonMazeV3a7CellData")

function DungeonMazeV3a7CellData:init(x, y)
	self.x = x
	self.y = y
	self.cellId = 0
	self.value = 0
	self.connectSet = {}
	self.entryConnect = {}
	self.entryCount = 0
	self.diagueId = 0
	self.obstacleDialog = ""
	self.obstacleToggled = false
	self.eventId = 0
	self.eventToggled = false
	self.pass = false
end

local _cacheTable = {}

function DungeonMazeV3a7CellData:getConnectValue()
	local len = 0
	local result = 0

	if self.entryConnect then
		for k, v in pairs(self.entryConnect) do
			table.insert(_cacheTable, k)

			len = len + 1
		end

		table.sort(_cacheTable)

		for _, v in ipairs(_cacheTable) do
			result = result * 10 + v
		end

		for i = 1, len do
			_cacheTable[i] = nil
		end
	end

	return result
end

function DungeonMazeV3a7CellData:getDirectionTo(cell)
	if cell.x == self.x then
		if cell.y > self.y then
			return DungeonMazeV3a7Enum.dir.right
		else
			return DungeonMazeV3a7Enum.dir.left
		end
	elseif cell.y == self.y then
		if cell.x > self.x then
			return DungeonMazeV3a7Enum.dir.down
		else
			return DungeonMazeV3a7Enum.dir.up
		end
	end

	return nil
end

function DungeonMazeV3a7CellData:cleanEntrySet()
	for k, v in pairs(self.entryConnect) do
		self.entryConnect[k] = nil
	end

	self.entryCount = 0
end

return DungeonMazeV3a7CellData
