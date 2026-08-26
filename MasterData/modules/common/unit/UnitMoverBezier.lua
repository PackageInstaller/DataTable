-- chunkname: @modules/common/unit/UnitMoverBezier.lua

module("modules.common.unit.UnitMoverBezier", package.seeall)

local UnitMoverBezier = class("UnitMoverBezier", LuaCompBase)

function UnitMoverBezier:ctor()
	self._timeScale = 1
	self._currTime = 0
	self._duration = 0
	self._wayPointBegin = nil
	self._wayPointEnd = nil
	self._wayPointValue = nil
	self._animationCurve = nil
	self._getTimeFunction = nil
	self._getTimeObject = nil

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverBezier:setBezierParam(bezierParam)
	if not string.nilorempty(bezierParam) then
		local point = FightStrUtil.instance:getSplitToNumberCache(bezierParam, "#")

		if point and #point >= 2 then
			self._bezierX = tonumber(point[1]) or 0.5
			self._bezierY = tonumber(point[2]) or 0
		end
	end
end

function UnitMoverBezier:setEaseType(easeType)
	self._easeType = easeType or EaseType.Linear
end

function UnitMoverBezier:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function UnitMoverBezier:simpleMove(startX, startY, startZ, endX, endY, endZ, duration)
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
end

function UnitMoverBezier:setPosDirectly(x, y, z)
	self._wayPointBegin = nil
	self._wayPointValue = nil
	self._posX = x
	self._posY = y
	self._posZ = z

	self:updatePrePos()
	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverBezier:setGetTimeFunction(getTimeFunction, getTimeObject)
	self._getTimeFunction = getTimeFunction
	self._getTimeObject = getTimeObject
end

function UnitMoverBezier:getCurWayPoint()
	return self._curWayPoint
end

function UnitMoverBezier:getPos()
	return self._posX, self._posY + (self._yOffset or 0), self._posZ
end

function UnitMoverBezier:getPrePos()
	return self.prePosX, self.prePosY, self.prePosZ
end

function UnitMoverBezier:updatePrePos()
	self.prePosX = self._posX
	self.prePosY = self._posY
	self.prePosZ = self._posZ
end

function UnitMoverBezier:onUpdate()
	if not self._wayPointBegin then
		return
	end

	self:updatePrePos()

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
		if self._bezierX and self._bezierY then
			local percent = self._currTime / self._duration
			local t = LuaTween.tween(percent, 0, 1, 1, self._easeType)
			local bezierX = self._bezierX * self._wayPointEnd.x + (1 - self._bezierX) * self._wayPointBegin.x

			self._posX = (1 - t) * (1 - t) * self._wayPointBegin.x + 2 * t * (1 - t) * bezierX + t * t * self._wayPointEnd.x
			self._posY = (1 - t) * (1 - t) * self._wayPointBegin.y + 2 * t * (1 - t) * self._bezierY + t * t * self._wayPointEnd.y
			self._posZ = LuaTween.tween(self._currTime, self._wayPointBegin.z, self._wayPointValue.z, self._duration, self._easeType)
		else
			self._posX = LuaTween.tween(self._currTime, self._wayPointBegin.x, self._wayPointValue.x, self._duration, self._easeType)
			self._posY = LuaTween.tween(self._currTime, self._wayPointBegin.y, self._wayPointValue.y, self._duration, self._easeType)
			self._posZ = LuaTween.tween(self._currTime, self._wayPointBegin.z, self._wayPointValue.z, self._duration, self._easeType)
		end

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
	end
end

function UnitMoverBezier:onDestroy()
	self._animationCurve = nil
end

return UnitMoverBezier
