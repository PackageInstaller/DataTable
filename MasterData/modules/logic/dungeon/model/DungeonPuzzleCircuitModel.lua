-- chunkname: @modules/logic/dungeon/model/DungeonPuzzleCircuitModel.lua

module("modules.logic.dungeon.model.DungeonPuzzleCircuitModel", package.seeall)

local DungeonPuzzleCircuitModel = class("DungeonPuzzleCircuitModel", BaseModel)

DungeonPuzzleCircuitModel.constWidth = 10
DungeonPuzzleCircuitModel.constHeight = 6

function DungeonPuzzleCircuitModel:reInit()
	self:release()
end

function DungeonPuzzleCircuitModel:release()
	self._cfgElement = nil
	self._gridDatas = nil
end

function DungeonPuzzleCircuitModel:getElementCo()
	return self._cfgElement
end

function DungeonPuzzleCircuitModel:getEditIndex()
	return self._editIndex
end

function DungeonPuzzleCircuitModel:setEditIndex(value)
	self._editIndex = value
end

function DungeonPuzzleCircuitModel:initByElementCo(elementCo)
	self._cfgElement = elementCo

	if self._cfgElement then
		self:initPuzzle(self._cfgElement.param)
	end
end

function DungeonPuzzleCircuitModel:initPuzzle(str)
	self._powerList = {}
	self._wrongList = {}
	self._capacitanceList = {}
	self._gridDatas = {}

	local list = string.split(str, ",")
	local w, h = self:getGameSize()
	local index = 1

	for x = 1, h do
		for y = 1, w do
			local str = list[index]

			index = index + 1

			local paramList = string.splitToNumber(str, "#")
			local type = paramList[1]
			local value = paramList[2]

			if type and type > 0 then
				local mo = self:_getMo(x, y)

				mo.type = type
				mo.value = value
				mo.rawValue = value

				if type == DungeonPuzzleCircuitEnum.type.power1 or type == DungeonPuzzleCircuitEnum.type.power2 then
					table.insert(self._powerList, mo)
				elseif type == DungeonPuzzleCircuitEnum.type.wrong then
					table.insert(self._wrongList, mo)
				elseif type == DungeonPuzzleCircuitEnum.type.capacitance then
					table.insert(self._capacitanceList, mo)
				end
			end
		end
	end
end

function DungeonPuzzleCircuitModel:getPowerList()
	return self._powerList
end

function DungeonPuzzleCircuitModel:getWrongList()
	return self._wrongList
end

function DungeonPuzzleCircuitModel:getCapacitanceList()
	return self._capacitanceList
end

function DungeonPuzzleCircuitModel:_getMo(x, y)
	self._gridDatas[x] = self._gridDatas[x] or {}

	local mo = DungeonPuzzleCircuitMO.New()

	mo:init(x, y)

	self._gridDatas[x][y] = mo

	return mo
end

function DungeonPuzzleCircuitModel:debugData()
	local str
	local w, h = self:getGameSize()

	for x = 1, h do
		for y = 1, w do
			local mo = self:getData(x, y)
			local appendStr

			if not mo or mo.type <= 0 then
				appendStr = string.format("%s", 0)
			elseif mo.type >= DungeonPuzzleCircuitEnum.type.straight and mo.type <= DungeonPuzzleCircuitEnum.type.t_shape then
				appendStr = string.format("%s#%s", mo.type, mo.value)
			end

			str = string.format("%s%s", (str or nil) and (str .. "," or ""), (string.format("%s", mo.type)))
		end
	end

	print("data:", str)
end

function DungeonPuzzleCircuitModel:getData(x, y)
	local row = self._gridDatas[x]

	return row and row[y]
end

function DungeonPuzzleCircuitModel:getGameSize()
	return DungeonPuzzleCircuitModel.constWidth, DungeonPuzzleCircuitModel.constHeight
end

function DungeonPuzzleCircuitModel:getRelativePosition(x, y, w, h)
	return (y - 1) * w, (x - 1) * -h
end

function DungeonPuzzleCircuitModel:getIndexByTouchPos(x, y, w, h)
	y = math.abs(y - 0.5 * h)
	x = math.abs(x + 0.5 * w)

	local row = math.floor(y / h)
	local column = math.floor(x / w)
	local totalW, totalH = self:getGameSize()

	if column >= 0 and column < totalW and row >= 0 and row < totalH then
		return row + 1, column + 1
	end

	return -1, -1
end

DungeonPuzzleCircuitModel.instance = DungeonPuzzleCircuitModel.New()

return DungeonPuzzleCircuitModel
