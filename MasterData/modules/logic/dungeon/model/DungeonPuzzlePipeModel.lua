-- chunkname: @modules/logic/dungeon/model/DungeonPuzzlePipeModel.lua

module("modules.logic.dungeon.model.DungeonPuzzlePipeModel", package.seeall)

local DungeonPuzzlePipeModel = class("DungeonPuzzlePipeModel", BaseModel)

DungeonPuzzlePipeModel.constWidth = 7
DungeonPuzzlePipeModel.constHeight = 5
DungeonPuzzlePipeModel.constEntry = 0

function DungeonPuzzlePipeModel:reInit()
	self:release()
end

function DungeonPuzzlePipeModel:release()
	self._cfgElement = nil
	self._startX = nil
	self._startY = nil
	self._gridDatas = nil
	self._isGameClear = false
	self._entryList = nil
end

function DungeonPuzzlePipeModel:initByElementCo(elementCo)
	self._cfgElement = elementCo

	if self._cfgElement then
		self:initData()

		if not string.nilorempty(self._cfgElement.param) then
			self:initPuzzle(self._cfgElement.param)
		end
	end
end

function DungeonPuzzlePipeModel:initData()
	self._gridDatas = {}

	local w, h = self:getGameSize()
	local mo

	for x = 1, w do
		for y = 1, h do
			self._gridDatas[x] = self._gridDatas[x] or {}
			mo = DungeonPuzzlePipeMO.New()

			mo:init(x, y)

			self._gridDatas[x][y] = mo
		end
	end

	self._startX = -w * 0.5 - 0.5
	self._startY = -h * 0.5 - 0.5
end

function DungeonPuzzlePipeModel:initPuzzle(str)
	self._entryList = {}

	local intArr = string.splitToNumber(str, ",")
	local w, h = self:getGameSize()

	if #intArr >= w * h then
		local index = 1

		for x = 1, w do
			for y = 1, h do
				local value = intArr[index]
				local mo = self._gridDatas[x][y]

				mo.value = value

				if value == DungeonPuzzlePipeModel.constEntry then
					table.insert(self._entryList, mo)
				end

				index = index + 1
			end
		end
	end
end

function DungeonPuzzlePipeModel:resetEntryConnect()
	local w, h = self:getGameSize()

	for x = 1, w do
		for y = 1, h do
			local mo = self._gridDatas[x][y]

			mo:cleanEntrySet()
		end
	end
end

function DungeonPuzzlePipeModel:setGameClear(value)
	self._isGameClear = value
end

function DungeonPuzzlePipeModel:getData(x, y)
	return self._gridDatas[x][y]
end

function DungeonPuzzlePipeModel:getGameSize()
	return DungeonPuzzlePipeModel.constWidth, DungeonPuzzlePipeModel.constHeight
end

function DungeonPuzzlePipeModel:getGameClear()
	return self._isGameClear
end

function DungeonPuzzlePipeModel:getEntryList()
	return self._entryList
end

function DungeonPuzzlePipeModel:getElementCo()
	return self._cfgElement
end

function DungeonPuzzlePipeModel:getRelativePosition(x, y, w, h)
	return (self._startX + x) * w, (self._startY + y) * h
end

function DungeonPuzzlePipeModel:getIndexByTouchPos(x, y, w, h)
	local x = math.floor((x - (self._startX + 0.5) * w) / w)
	local y = math.floor((y - (self._startY + 0.5) * h) / h)
	local totalW, totalH = self:getGameSize()

	if x >= 0 and x < totalW and y >= 0 and y < totalH then
		return x + 1, y + 1
	end

	return -1, -1
end

DungeonPuzzlePipeModel.instance = DungeonPuzzlePipeModel.New()

return DungeonPuzzlePipeModel
