-- chunkname: @/tmp/or_script/lua_compile/dm/battle/logic/BattleField.lua

BFCell = class("BFCell")

BFCell:has("_id", {
	is = "r"
})
BFCell:has("_number", {
	is = "r"
})
BFCell:has("_side", {
	is = "r"
})
BFCell:has("_position", {
	is = "r"
})
BFCell:has("_resident", {
	is = "rw"
})
BFCell:has("_oldResident", {
	is = "rw"
})
BFCell:has("_oldResidentDieRule", {
	is = "rw"
})
BFCell:has("_isLocked", {
	is = "rwb"
})
BFCell:has("_isBlocked", {
	is = "rwb"
})

BFCELL_MINNO = 1
BFCELL_MAXNO = 9

local __id2pos__ = {
	x = {
		1,
		1,
		1,
		2,
		2,
		2,
		3,
		3,
		3
	},
	y = {
		1,
		2,
		3,
		1,
		2,
		3,
		1,
		2,
		3
	}
}

function BFCell_id2pos(id)
	if id > 0 then
		return 1, __id2pos__.x[id], __id2pos__.y[id]
	else
		id = -id

		return -1, __id2pos__.x[id], __id2pos__.y[id]
	end
end

function BFCell_pos2id(zone, x, y)
	if zone > 0 then
		return (x - 1) * 3 + y
	elseif zone < 0 then
		return (1 - x) * 3 - y
	end
end

function BFCell_isValidPos(x, y)
	return x >= 1 and x <= 3 and y >= 1 and y <= 3
end

function BFCell:initialize(id)
	super.initialize(self)

	self._id = id

	local zone, x, y = BFCell_id2pos(id)

	self._position = {
		zone = zone,
		x = x,
		y = y
	}

	if zone > 0 then
		self._side = kBattleSideA
		self._number = id
	else
		self._side = kBattleSideB
		self._number = -id
	end
end

function BFCell:isNormalStatus()
	return not self._isLocked and not self._isBlocked
end

BattleField = class("BattleField")

function makeCellId(side, cellNo)
	if side == kBattleSideB then
		return -math.abs(cellNo)
	else
		return math.abs(cellNo)
	end
end

function BattleField:findEmptyCellId(side, arr)
	if side == kBattleSideA then
		if arr then
			for i = 1, #arr do
				if self:isEmptyCell(arr[i]) then
					return arr[i]
				end
			end
		end

		for i = BFCELL_MINNO, BFCELL_MAXNO do
			if self:isEmptyCell(i) then
				return i
			end
		end
	else
		if arr then
			for i = 1, #arr do
				if self:isEmptyCell(-arr[i]) then
					return -arr[i]
				end
			end
		end

		for i = BFCELL_MINNO, BFCELL_MAXNO do
			if self:isEmptyCell(-i) then
				return -i
			end
		end
	end

	return nil
end

local function removeArrayElement(arr, elem)
	for i = 1, #arr do
		if arr[i] == elem then
			return i, table.remove(arr, i)
		end
	end
end

function BattleField:initialize()
	super.initialize(self)

	self._cells = self:createCells()
	self._units = {}
end

function BattleField:createCells()
	local cells = {}

	for i = BFCELL_MINNO, BFCELL_MAXNO do
		cells[i] = BFCell:new(i)
		cells[-i] = BFCell:new(-i)
	end

	cells[108] = BFCell:new(108)
	cells[-108] = BFCell:new(-108)

	return cells
end

function BattleField:getCells()
	return self._cells
end

function BattleField:getCellById(cellId)
	return self._cells[cellId]
end

function BattleField:getCellBySideAndNo(side, cellNo)
	return self._cells[makeCellId(side, cellNo)]
end

local primaryTargetSearchOrders = {
	{
		1,
		4,
		7,
		2,
		5,
		8,
		3,
		6,
		9
	},
	{
		2,
		5,
		8,
		1,
		3,
		4,
		6,
		7,
		9
	},
	{
		3,
		6,
		9,
		2,
		5,
		8,
		1,
		4,
		7
	}
}

function BattleField:searchPrimaryTarget(actorCellId)
	local zone, x, y = BFCell_id2pos(actorCellId)
	local order = y and primaryTargetSearchOrders[y]
	local unit, id, steal_unit, steal_id

	if order ~= nil then
		local cells = self._cells

		if zone > 0 then
			for i = 1, #order do
				local tid = -order[i]
				local tunit = cells[tid]:getResident()

				if tunit ~= nil and tunit:isInStages(ULS_Normal) then
					if not tunit:getComponent("Flag"):hasStatus(kBEStealth) then
						if tunit:getComponent("Flag"):hasStatus(kBETaunt) then
							return tunit, tid
						end

						if unit == nil then
							unit = tunit
							id = tid
						end
					elseif steal_unit == nil then
						steal_unit = tunit
						steal_id = tid
					end
				end
			end
		else
			for i = 1, #order do
				local tid = order[i]
				local tunit = cells[tid]:getResident()

				if tunit ~= nil and tunit:isInStages(ULS_Normal) then
					if not tunit:getComponent("Flag"):hasStatus(kBEStealth) then
						if tunit:getComponent("Flag"):hasStatus(kBETaunt) then
							return tunit, tid
						end

						if unit == nil then
							unit = tunit
							id = tid
						end
					elseif steal_unit == nil then
						steal_unit = tunit
						steal_id = tid
					end
				end
			end
		end
	end

	if unit == nil then
		unit = steal_unit
		id = steal_id
	end

	return unit, id
end

function BattleField:searchPrimaryTargetRandom(actorCellId, battleContext)
	local zone, x, y = BFCell_id2pos(actorCellId)
	local result = zone > 0 and self:collectUnits({}, kBattleSideB) or self:collectUnits({}, kBattleSideA)

	if #result > 0 then
		local unit = result[battleContext:random(1, #result)]
		local pos = unit:getPosition()
		local id = BFCell_pos2id(pos.zone, pos.x, pos.y)

		return unit, id
	end
end

function BattleField:searchNearestEmptyCell(cellId)
	local cells = self._cells
	local cell = cells[cellId]

	if self:isEmptyCell(cellId) then
		return cell, cellId
	end

	if cellId > 0 then
		local prev, next, curId

		for i = 1, BFCELL_MAXNO - 1 do
			curId = cellId + i
			next = cells[cellId + i]

			if self:isEmptyCell(cellId + i) then
				return next, curId
			end

			curId = cellId - i
			prev = cellId - i > 0 and cells[curId] or nil

			if prev ~= nil then
				if self:isEmptyCell(curId) then
					return prev, curId
				end
			elseif next == nil then
				break
			end
		end
	elseif cellId < 0 then
		local prev, next, curId

		for i = -1, 1 - BFCELL_MAXNO, -1 do
			curId = cellId + i
			next = cells[cellId + i]

			if self:isEmptyCell(cellId + i) then
				return next, curId
			end

			curId = cellId - i
			prev = cellId - i < 0 and cells[curId] or nil

			if prev ~= nil then
				if self:isEmptyCell(curId) then
					return prev, curId
				end
			elseif next == nil then
				break
			end
		end
	end

	return nil
end

function BattleField:isEmptyCell(cellId)
	local cell = self._cells[cellId]

	return cell ~= nil and cell:getResident() == nil and cell:isNormalStatus()
end

function BattleField:lockCell(cellId)
	local cell = self._cells[cellId]

	if cell then
		cell:setIsLocked(true)
	end
end

function BattleField:unlockCell(cellId)
	local cell = self._cells[cellId]

	if cell then
		cell:setIsLocked(false)
	end
end

function BattleField:unlockAllCells()
	for i = BFCELL_MINNO, BFCELL_MAXNO do
		self:unlockCell(i)
		self:unlockCell(-i)
	end
end

function BattleField:blockCell(cellId)
	local cell = self._cells[cellId]

	if cell then
		cell:setIsBlocked(true)
	end
end

function BattleField:unblockCell(cellId)
	local cell = self._cells[cellId]

	if cell then
		cell:setIsBlocked(false)
	end
end

function BattleField:settleUnit(cellId, unit)
	local cell = self._cells[cellId]

	if cell == nil or not cell:isNormalStatus() then
		return false, nil
	end

	local oldUnit = cell:getResident()

	if oldUnit == unit then
		return true, nil
	end

	cell:setResident(unit)

	if unit then
		self._units[#self._units + 1] = unit

		local posComp = unit:getComponent("Position")

		posComp:setCell(cell)

		local pos = cell:getPosition()

		posComp:setPosition(pos.zone, pos.x, pos.y)
	end

	if oldUnit ~= nil then
		removeArrayElement(self._units, oldUnit)
	end

	return true, oldUnit
end

function BattleField:exchangeUnits(cellId1, cellId2)
	if cellId1 == cellId2 then
		return false
	end

	local cell1, cell2 = self._cells[cellId1], self._cells[cellId2]

	if cell1 == nil or cell2 == nil then
		return false
	end

	local unit1, unit2 = cell1:getResident(), cell2:getResident()
	local unit1Old, unit2Old = cell1:getOldResident(), cell2:getOldResident()

	cell1:setResident(unit2)
	cell1:setOldResident(unit2Old)

	if unit2 ~= nil then
		local posComp = unit2:getComponent("Position")

		posComp:setCell(cell1)

		local pos = cell1:getPosition()

		posComp:setPosition(pos.zone, pos.x, pos.y)
	end

	cell2:setResident(unit1)
	cell2:setOldResident(unit1Old)

	if unit1 ~= nil then
		local posComp = unit1:getComponent("Position")

		posComp:setCell(cell2)

		local pos = cell2:getPosition()

		posComp:setPosition(pos.zone, pos.x, pos.y)
	end

	return true, unit2, unit1
end

function BattleField:eraseUnit(unit)
	if unit == nil then
		return nil
	end

	unit:getFSM():changeState(nil)

	local posComp = unit:getComponent("Position")
	local removed = false

	if posComp then
		local cell = posComp:getCell()

		if cell:getOldResident() then
			if cell:getOldResident() == unit then
				cell:setOldResident(nil)

				removed = true

				return true
			end
		elseif cell:getResident() == unit then
			cell:setResident(nil)

			removed = true
		end
	end

	if not removed then
		for _, cell in pairs(self._cells) do
			if cell:getResident() == unit then
				cell:setResident(nil)
			end
		end
	end

	local _, removed = removeArrayElement(self._units, unit)

	return removed
end

local function calcLoopRange(side, descending)
	local start, guard, step

	if side == kBattleSideA then
		if descending then
			step = -1
			guard = BFCELL_MINNO
			start = BFCELL_MAXNO
		else
			step = 1
			guard = BFCELL_MAXNO
			start = BFCELL_MINNO
		end
	elseif descending then
		step = 1
		guard = -BFCELL_MINNO
		start = -BFCELL_MAXNO
	else
		step = -1
		guard = -BFCELL_MAXNO
		start = -BFCELL_MINNO
	end

	return start, guard, step
end

function BattleField:collectCells(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		result[#result + 1] = cells[id]
	end

	return result
end

function BattleField:collectFieldUnits(result, side)
	if result == nil then
		result = {}
	end

	local cells = self._cells

	if side == kBattleSideA then
		local unit = cells[108]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal) then
			result[#result + 1] = unit
		end
	else
		local unit = cells[-108]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal) then
			result[#result + 1] = unit
		end
	end

	return result
end

function BattleField:collectBlockCellIndex(side, descending)
	local result = {}
	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		if cells[id]:isBlocked() then
			result[#result + 1] = id
		end
	end

	return result
end

function BattleField:collectEmtpyCells(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)

	for id = start, guard, step do
		if self:isEmptyCell(id) then
			result[#result + 1] = self._cells[id]
		end
	end

	return result
end

function BattleField:collectUnits(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		local unit = cells[id]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal) then
			result[#result + 1] = unit
		end
	end

	return result
end

function BattleField:collectLivingUnits(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		local unit = cells[id]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal, ULS_Newborn, ULS_Reviving) then
			result[#result + 1] = unit
		end
	end

	return result
end

function BattleField:collectExistsUnits(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		local unit = cells[id]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal, ULS_Newborn, ULS_Reviving, ULS_Dying) then
			result[#result + 1] = unit
		end
	end

	return result
end

function BattleField:collectLinkedUnits(result, side)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, false)
	local cells = self._cells

	for id = start, guard, step do
		local unit = cells[id]:getResident()

		if unit ~= nil and unit:isInStages(ULS_Normal, ULS_Newborn, ULS_Reviving) then
			if unit:getComponent("Flag"):hasStatus(kBELinked) then
				result[#result + 1] = unit
			end
		end
	end

	return result
end

function BattleField:collectAllUnits(result, side, descending)
	if result == nil then
		result = {}
	end

	local start, guard, step = calcLoopRange(side, descending)
	local cells = self._cells

	for id = start, guard, step do
		local unit = cells[id]:getResident()

		if unit ~= nil then
			result[#result + 1] = unit
		end
	end

	return result
end

function BattleField:crossCollectUnits(result, priorSide)
	if result == nil then
		result = {}
	end

	local cells = self._cells

	if priorSide == kBattleSideB then
		for i = BFCELL_MINNO, BFCELL_MAXNO do
			local a = cells[-i]:getResident()
			local b = cells[i]:getResident()

			if a and a:isInStages(ULS_Normal) then
				result[#result + 1] = a
			end

			if b and b:isInStages(ULS_Normal) then
				result[#result + 1] = b
			end
		end
	else
		for i = BFCELL_MINNO, BFCELL_MAXNO do
			local a = cells[i]:getResident()
			local b = cells[-i]:getResident()

			if a and a:isInStages(ULS_Normal) then
				result[#result + 1] = a
			end

			if b and b:isInStages(ULS_Normal) then
				result[#result + 1] = b
			end
		end
	end

	return result
end

function BattleField:crossCollectBySpeed()
	local result = {}
	local left = {}
	local right = {}
	local cells = self._cells

	for i = BFCELL_MINNO, BFCELL_MAXNO do
		local a = cells[i]:getResident()
		local b = cells[-i]:getResident()

		if a then
			left[#left + 1] = a
		end

		if b then
			right[#right + 1] = b
		end
	end

	for i = BFCELL_MINNO, BFCELL_MAXNO do
		do
			local a = left[i]
			local b = right[i]

			if a ~= nil and b ~= nil then
				if a:getComponent("Numeric"):getAttrValue(kAttrSpeed) < b:getComponent("Numeric"):getAttrValue(kAttrSpeed) then
					if b and b:isInStages(ULS_Normal, ULS_Reviving) then
						result[#result + 1] = b
					end

					if a and a:isInStages(ULS_Normal, ULS_Reviving) then
						result[#result + 1] = a
					end

					goto label_37_0
				end
			end

			if a and a:isInStages(ULS_Normal, ULS_Reviving) then
				result[#result + 1] = a
			end

			if b and b:isInStages(ULS_Normal, ULS_Reviving) then
				result[#result + 1] = b
			end
		end

		::label_37_0::
	end

	return result
end

function BattleField:crossCollectDiligentUnits(result)
	if result == nil then
		result = {}
	end

	local cells = self._cells

	for i = BFCELL_MINNO, BFCELL_MAXNO do
		local a = cells[-i]:getResident()
		local b = cells[i]:getResident()

		if a and a:isInStages(ULS_Normal) then
			if a:getComponent("Flag"):hasStatus(kBEDiligent) then
				result[#result + 1] = a
			end
		end

		if b and b:isInStages(ULS_Normal) then
			if b:getComponent("Flag"):hasStatus(kBEDiligent) then
				result[#result + 1] = b
			end
		end
	end

	return result
end

function BattleField:getAllUnits()
	return self._units
end

function BattleField:visitAllCells(visitor)
	local cells = self._cells

	for i = BFCELL_MINNO, BFCELL_MAXNO do
		local a = cells[-i]
		local b = cells[i]

		if a then
			visitor(a)
		end

		if a then
			visitor(b)
		end
	end
end
