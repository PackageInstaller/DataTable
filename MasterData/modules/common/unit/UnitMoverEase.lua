-- chunkname: @modules/common/unit/UnitMoverEase.lua

module("modules.common.unit.UnitMoverEase", package.seeall)

local UnitMoverEase = class("UnitMoverEase", LuaCompBase)

function UnitMoverEase:ctor()
	self._timeScale = 1
	self._currTime = 0
	self._duration = 0
	self._wayPointBegin = nil
	self._wayPointEnd = nil
	self._wayPointValue = nil
	self._easeType = EaseType.Linear
	self._getTimeFunction = nil
	self._getTimeObject = nil

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverEase:setEaseType(easeType)
	self._easeType = easeType
end

function UnitMoverEase:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function UnitMoverEase:simpleMove(startX, startY, startZ, endX, endY, endZ, duration)
	self:setPosDirectly(startX, startY, startZ)

	self._currTime = 0
	self._duration = duration
	self._wayPointBegin = {
		x = startX,
		y = startY,
		z = startZ
	}
	self._wayPointEnd = {
		x = endX,
		y = endY,
		z = endZ
	}
	self._wayPointValue = {
		x = endX - startX,
		y = endY - startY,
		z = endZ - startZ
	}
	self._lastStartPos = self._wayPointBegin
	self._lastEndPos = self._wayPointEnd
end

function UnitMoverEase:getLastStartPos()
	return self._lastStartPos
end

function UnitMoverEase:getLastEndPos()
	return self._lastEndPos
end

function UnitMoverEase:setPosDirectly(x, y, z)
	self._wayPointBegin = nil
	self._wayPointValue = nil
	self._posX = x
	self._posY = y
	self._posZ = z

	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverEase:setGetTimeFunction(getTimeFunction, getTimeObject)
	self._getTimeFunction = getTimeFunction
	self._getTimeObject = getTimeObject
end

function UnitMoverEase:getCurWayPoint()
	return self._curWayPoint
end

function UnitMoverEase:getPos()
	return self._posX, self._posY, self._posZ
end

function UnitMoverEase:onUpdate()
	if not self._wayPointBegin then
		return
	end

	self._currTime = self._getTimeFunction and self._getTimeFunction(self._getTimeObject) or self._currTime + Time.deltaTime * self._timeScale

	if self._currTime >= self._duration then
		self._posX = self._wayPointEnd.x
		self._posY = self._wayPointEnd.y
		self._posZ = self._wayPointEnd.z
		self._wayPointBegin = nil
		self._wayPointEnd = nil
		self._wayPointValue = nil

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
		self.dispatchEvent(self, UnitMoveEvent.Arrive, self)
	else
		self._posX = LuaTween.tween(self._currTime, self._wayPointBegin.x, self._wayPointValue.x, self._duration, self._easeType)
		self._posY = LuaTween.tween(self._currTime, self._wayPointBegin.y, self._wayPointValue.y, self._duration, self._easeType)
		self._posZ = LuaTween.tween(self._currTime, self._wayPointBegin.z, self._wayPointValue.z, self._duration, self._easeType)

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
	end
end

return UnitMoverEase
