-- chunkname: @modules/common/unit/UnitMoverBezier3.lua

module("modules.common.unit.UnitMoverBezier3", package.seeall)

local UnitMoverBezier3 = class("UnitMoverBezier3", LuaCompBase)

function UnitMoverBezier3:ctor()
	self._timeScale = 1
	self._currTime = 0
	self._duration = 0
	self._getTimeFunction = nil
	self._getTimeObject = nil
	self._start = nil

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverBezier3:setEaseType(easeType)
	self._easeType = easeType or EaseType.Linear
end

function UnitMoverBezier3:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function UnitMoverBezier3:simpleMove(p1, p2, p3, p4, duration)
	self:setPosDirectly(p1.x, p1.y, p1.z)

	self.p1 = p1
	self.p2 = p2
	self.p3 = p3
	self.p4 = p4
	self.startPos = p1
	self.endPos = p4
	self._duration = duration
	self._currTime = 0
	self._start = true
end

function UnitMoverBezier3:setPosDirectly(x, y, z)
	self._posX = x
	self._posY = y
	self._posZ = z

	self:updatePrePos()
	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverBezier3:updatePrePos()
	self.prePosX = self._posX
	self.prePosY = self._posY
	self.prePosZ = self._posZ
end

function UnitMoverBezier3:setGetTimeFunction(getTimeFunction, getTimeObject)
	self._getTimeFunction = getTimeFunction
	self._getTimeObject = getTimeObject
end

function UnitMoverBezier3:getPos()
	return self._posX, self._posY, self._posZ
end

function UnitMoverBezier3:getPrePos()
	return self.prePosX, self.prePosY, self.prePosZ
end

function UnitMoverBezier3:onUpdate()
	if not self._start then
		return
	end

	self:updatePrePos()

	self._currTime = self._getTimeFunction and self._getTimeFunction(self._getTimeObject) or self._currTime + Time.deltaTime * self._timeScale

	if self._currTime >= self._duration then
		self._posX = self.endPos.x
		self._posY = self.endPos.y
		self._posZ = self.endPos.z

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
		self.dispatchEvent(self, UnitMoveEvent.Arrive, self)

		self._start = nil
	else
		local percent = self._currTime / self._duration
		local t = LuaTween.tween(percent, 0, 1, 1, self._easeType)

		self._posX = self:calculateValue(t, self.p1.x, self.p2.x, self.p3.x, self.p4.x)
		self._posY = self:calculateValue(t, self.p1.y, self.p2.y, self.p3.y, self.p4.y)
		self._posZ = self:calculateValue(t, self.p1.z, self.p2.z, self.p3.z, self.p4.z)

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
	end
end

function UnitMoverBezier3:calculateValue(t, p1, p2, p3, p4)
	local a1 = (1 - t) * (1 - t) * (1 - t) * p1
	local a2 = 3 * t * (1 - t) * (1 - t) * p2
	local a3 = 3 * t * t * (1 - t) * p3
	local a4 = t * t * t * p4

	return a1 + a2 + a3 + a4
end

function UnitMoverBezier3:onDestroy()
	self._start = nil
	self._animationCurve = nil
end

return UnitMoverBezier3
