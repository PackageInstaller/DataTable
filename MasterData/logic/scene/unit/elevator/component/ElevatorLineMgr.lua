-- chunkname: @/Users/baioo/builds/866EVqtU/3/spacex/spacex-client/UnityProj/Assets/Scripts/Lua/logic/scene/unit/elevator/component/ElevatorLineMgr.lua

module("logic.scene.unit.elevator.component.ElevatorLineMgr", package.seeall)

local M = class("ElevatorLineMgr", UnitComponentBase)
local ElevatorMoveStatus = SceneEnum.ElevatorMoveStatus
local kMaxWait = 2

function M:ctor(unit)
	M.super.ctor(self, unit)

	self._pointPosList = {}
	self._tempWaitPos = nil
	self._waitUnitQueue = {}
end

function M:onInit()
	self:_initPoint()
end

function M:clear()
	table.clear(self._pointPosList)
	table.clear(self._waitUnitQueue)

	self._pointPosList = nil
	self._waitUnitQueue = nil
	self._tempWaitPos = nil
end

function M:_initPoint()
	local goParent = goutil.findChild(self._unit.go, "waitPoint")

	for i = 1, kMaxWait do
		local goPoint = goutil.findChild(goParent, i)
		local posX, posY, posZ = Astral.TransformUtil.GetPos(goPoint.transform, 0, 0, 0)
		local pointPos = Vector3.New()

		pointPos:Set(posX, posY, posZ)

		self._pointPosList[i] = pointPos
	end

	local pos = self._pointPosList[kMaxWait]

	self._tempWaitPos = Vector3.New()

	self._tempWaitPos:Set(pos.x, pos.y, pos.z + 2)
end

function M:getWaitPosByUnit(unit)
	local idx = self:getWaitQueueIdx(unit)

	if idx then
		return self:getWaitPos(idx)
	end
end

function M:getWaitPos(index)
	return self._pointPosList[index] or false
end

function M:getTempWaitPos()
	return self._tempWaitPos
end

function M:isWaitQueueFull()
	for i = 1, kMaxWait do
		if self._waitUnitQueue[i] == nil then
			return false
		end
	end

	return true
end

function M:addWaitUnit(unit)
	if not self:getWaitQueueIdx(unit) then
		for i = 1, kMaxWait do
			if self._waitUnitQueue[i] == nil then
				self._waitUnitQueue[i] = unit

				return true
			end
		end
	end

	return false
end

function M:removeWaitUnit(unit)
	for i = 1, kMaxWait do
		if self._waitUnitQueue[i] == unit then
			self._waitUnitQueue[i] = nil

			break
		end
	end
end

function M:getWaitQueueIdx(unit)
	for i = 1, kMaxWait do
		if self._waitUnitQueue[i] == unit then
			return i
		end
	end
end

function M:getWaitList()
	local units = {}

	for i = 1, kMaxWait do
		local unit = self._waitUnitQueue[i]

		if unit then
			table.insert(units, unit)
		end
	end

	return units
end

function M:getWaitListWithMoveDir(moveDir)
	local idxList = {}

	if moveDir ~= ElevatorMoveStatus.Hold then
		for i = 1, kMaxWait do
			local unit = self._waitUnitQueue[i]

			if unit and unit.model:getTowardDirection() == moveDir then
				table.insert(idxList, i)
			end
		end
	end

	for i = 1, kMaxWait do
		if not table.indexof(idxList, i) then
			table.insert(idxList, i)
		end
	end

	local units = {}

	for _, idx in ipairs(idxList) do
		local unit = self._waitUnitQueue[idx]

		if unit then
			table.insert(units, unit)
		end
	end

	return units
end

return M
