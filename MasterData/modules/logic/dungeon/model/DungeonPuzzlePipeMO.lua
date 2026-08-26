-- chunkname: @modules/logic/dungeon/model/DungeonPuzzlePipeMO.lua

module("modules.logic.dungeon.model.DungeonPuzzlePipeMO", package.seeall)

local DungeonPuzzlePipeMO = pureTable("DungeonPuzzlePipeMO")

function DungeonPuzzlePipeMO:init(x, y)
	self.x = x
	self.y = y
	self.value = 0
	self.connectSet = {}
	self.entryConnect = {}
	self.entryCount = 0
end

local _cacheTable = {}

function DungeonPuzzlePipeMO:getConnectValue()
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

function DungeonPuzzlePipeMO:cleanEntrySet()
	for k, v in pairs(self.entryConnect) do
		self.entryConnect[k] = nil
	end

	self.entryCount = 0
end

function DungeonPuzzlePipeMO:isEntry()
	return DungeonPuzzlePipeModel.constEntry == self.value
end

return DungeonPuzzlePipeMO
