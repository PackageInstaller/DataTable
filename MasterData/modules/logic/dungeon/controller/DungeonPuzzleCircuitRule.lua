-- chunkname: @modules/logic/dungeon/controller/DungeonPuzzleCircuitRule.lua

module("modules.logic.dungeon.controller.DungeonPuzzleCircuitRule", package.seeall)

local DungeonPuzzleCircuitRule = class("DungeonPuzzleCircuitRule")
local LEFT = DungeonPuzzleCircuitEnum.dir.left
local RIGHT = DungeonPuzzleCircuitEnum.dir.right
local DOWN = DungeonPuzzleCircuitEnum.dir.down
local UP = DungeonPuzzleCircuitEnum.dir.up

function DungeonPuzzleCircuitRule:ctor()
	self._ruleChange = {
		[28] = 46,
		[248] = 468,
		[24] = 48,
		[46] = 28,
		[48] = 68,
		[246] = 248,
		[268] = 246,
		[468] = 268,
		[26] = 24,
		[68] = 26
	}
	self._ruleConnect = {}

	for k, v in pairs(self._ruleChange) do
		if k ~= 0 then
			local rule = {}
			local val = k

			while val > 0 do
				local mod = val % 10

				val = (val - mod) / 10
				rule[mod] = true
			end

			self._ruleConnect[k] = rule
		end
	end

	self._ruleTypeConnect = {}
	self._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.power1] = {
		[RIGHT] = true,
		[LEFT] = true
	}
	self._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.power2] = {
		[DOWN] = true,
		[UP] = true
	}
	self._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.capacitance] = {
		[RIGHT] = true,
		[LEFT] = true,
		[DOWN] = true,
		[UP] = true
	}
	self._ruleTypeConnect[DungeonPuzzleCircuitEnum.type.wrong] = {
		[RIGHT] = true,
		[LEFT] = true,
		[DOWN] = true,
		[UP] = true
	}
end

function DungeonPuzzleCircuitRule:changeDirection(x, y)
	local mo = DungeonPuzzleCircuitModel.instance:getData(x, y)

	if not mo then
		return
	end

	local nextVal = self._ruleChange[mo.value]

	if nextVal then
		mo.value = nextVal
	end

	return mo
end

function DungeonPuzzleCircuitRule:getOldCircuitList()
	return self._oldCircuiteList
end

function DungeonPuzzleCircuitRule:getOldCapacitanceList()
	return self._oldCapacitanceList
end

function DungeonPuzzleCircuitRule:getOldWrongList()
	return self._oldWrongList
end

function DungeonPuzzleCircuitRule:getCircuitList()
	return self._circuitList
end

function DungeonPuzzleCircuitRule:getCapacitanceList()
	return self._capacitanceList
end

function DungeonPuzzleCircuitRule:getWrongList()
	return self._wrongList
end

function DungeonPuzzleCircuitRule:isWin()
	return self._win
end

function DungeonPuzzleCircuitRule:refreshAllConnection()
	self._oldCircuiteList = self._circuitList
	self._oldCapacitanceList = self._capacitanceList

	self:_powerConnect()

	self._oldWrongList = self._wrongList

	self:_wrongConnect()
end

function DungeonPuzzleCircuitRule:_wrongConnect()
	self._wrongList = {}

	local wrongList = DungeonPuzzleCircuitModel.instance:getWrongList()

	for i, mo in ipairs(wrongList) do
		local x, y = mo.x, mo.y

		self:_addWrongList(self:_findSingle(x - 1, y, DOWN, UP, mo))
		self:_addWrongList(self:_findSingle(x + 1, y, UP, DOWN, mo))
		self:_addWrongList(self:_findSingle(x, y + 1, LEFT, RIGHT, mo))
		self:_addWrongList(self:_findSingle(x, y - 1, RIGHT, LEFT, mo))
	end
end

function DungeonPuzzleCircuitRule:_addWrongList(mo)
	if not mo then
		return
	end

	self._wrongList[mo.id] = mo
end

function DungeonPuzzleCircuitRule:_powerConnect()
	self._closeList = {}
	self._powerList = {}
	self._capacitanceList = {}
	self._circuitList = {}

	local powerList = DungeonPuzzleCircuitModel.instance:getPowerList()
	local capacitanceList = DungeonPuzzleCircuitModel.instance:getCapacitanceList()

	for i, mo in ipairs(powerList) do
		if mo.type == DungeonPuzzleCircuitEnum.type.power1 then
			self:_findConnectPath(mo)

			if #self._powerList == #powerList and #self._capacitanceList == #capacitanceList then
				self._win = true

				return
			end
		end
	end
end

function DungeonPuzzleCircuitRule:_findConnectPath(srcMo)
	local openList = {
		srcMo
	}

	while #openList > 0 do
		local mo = table.remove(openList)

		if not self._closeList[mo.id] then
			if mo.type == DungeonPuzzleCircuitEnum.type.power1 or mo.type == DungeonPuzzleCircuitEnum.type.power2 then
				table.insert(self._powerList, mo)
			elseif mo.type == DungeonPuzzleCircuitEnum.type.capacitance then
				table.insert(self._capacitanceList, mo)
			end
		end

		self._closeList[mo.id] = mo

		if mo.type ~= DungeonPuzzleCircuitEnum.type.capacitance and mo.type ~= DungeonPuzzleCircuitEnum.type.wrong then
			if mo.type >= DungeonPuzzleCircuitEnum.type.straight and mo.type <= DungeonPuzzleCircuitEnum.type.t_shape then
				table.insert(self._circuitList, mo)
			end

			local x, y = mo.x, mo.y

			self:_addToOpenList(self:_findSingle(x - 1, y, DOWN, UP, mo), openList, self._closeList)
			self:_addToOpenList(self:_findSingle(x + 1, y, UP, DOWN, mo), openList, self._closeList)
			self:_addToOpenList(self:_findSingle(x, y + 1, LEFT, RIGHT, mo), openList, self._closeList)
			self:_addToOpenList(self:_findSingle(x, y - 1, RIGHT, LEFT, mo), openList, self._closeList)
		end
	end
end

function DungeonPuzzleCircuitRule:_addToOpenList(mo, openList, closeList)
	if not mo or not openList or not closeList or closeList[mo.id] then
		return
	end

	table.insert(openList, mo)
end

function DungeonPuzzleCircuitRule:_findAround(mo)
	local x, y = mo.x, mo.y

	self:_findSingle(x - 1, y, DOWN, UP, mo)
	self:_findSingle(x + 1, y, UP, DOWN, mo)
	self:_findSingle(x, y + 1, LEFT, RIGHT, mo)
	self:_findSingle(x, y - 1, RIGHT, LEFT, mo)
end

function DungeonPuzzleCircuitRule:_findSingle(x, y, dir, reverse, centerMO)
	if x > 0 and x <= DungeonPuzzleCircuitModel.constHeight and y > 0 and y <= DungeonPuzzleCircuitModel.constWidth then
		local targetMO = DungeonPuzzleCircuitModel.instance:getData(x, y)

		if not targetMO then
			return
		end

		local targetRule = self:_getConnectRule(targetMO)
		local selfRule = self:_getConnectRule(centerMO)

		if targetRule[dir] then
			return targetRule[dir] and targetMO
		end
	end
end

function DungeonPuzzleCircuitRule:_getConnectRule(mo)
	return self._ruleConnect[mo.value] or self._ruleTypeConnect[mo.type]
end

return DungeonPuzzleCircuitRule
