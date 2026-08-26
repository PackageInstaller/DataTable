-- chunkname: @modules/common/unit/UnitMoverCurve.lua

module("modules.common.unit.UnitMoverCurve", package.seeall)

local UnitMoverCurve = class("UnitMoverCurve", LuaCompBase)

function UnitMoverCurve:ctor()
	self._timeScale = 1
	self._currTime = 0
	self._duration = 0
	self._wayPointBegin = nil
	self._wayPointEnd = nil
	self._wayPointValue = nil
	self._animationCurve = nil
	self._tCurve = nil
	self._getTimeFunction = nil
	self._getTimeObject = nil
	self._x_move_curve = nil
	self._y_move_curve = nil
	self._z_move_curve = nil

	LuaEventSystem.addEventMechanism(self)
end

function UnitMoverCurve:setCurveParam(curveParam)
	self._animationCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(curveParam)

	if not self._animationCurve then
		logError("动画曲线参数错误")
	end
end

function UnitMoverCurve:setTCurveParam(curveParam)
	self._tCurve = nil

	if not string.nilorempty(curveParam) then
		self._tCurve = ZProj.AnimationCurveHelper.GetAnimationCurve(curveParam)
	end
end

function UnitMoverCurve:setEaseType(easeType)
	self._easeType = easeType or EaseType.Linear
end

function UnitMoverCurve:setTimeScale(timeScale)
	self._timeScale = timeScale
end

function UnitMoverCurve:simpleMove(startX, startY, startZ, endX, endY, endZ, duration)
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

function UnitMoverCurve:setPosDirectly(x, y, z)
	self._wayPointBegin = nil
	self._wayPointValue = nil
	self._yOffset = nil
	self._posX = x
	self._posY = y
	self._posZ = z

	self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
end

function UnitMoverCurve:setGetTimeFunction(getTimeFunction, getTimeObject)
	self._getTimeFunction = getTimeFunction
	self._getTimeObject = getTimeObject
end

function UnitMoverCurve:getCurWayPoint()
	return self._curWayPoint
end

function UnitMoverCurve:getPos()
	return self._posX, self._posY + (self._yOffset or 0), self._posZ
end

function UnitMoverCurve:onUpdate()
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
		local percent = self._currTime / self._duration
		local t = LuaTween.tween(percent, 0, 1, 1, self._easeType)

		if self._animationCurve then
			self._yOffset = self._animationCurve:Evaluate(t)
		end

		if self._tCurve then
			local exPercent = self._tCurve:Evaluate(t) / 10

			self._posX = self._wayPointBegin.x * (1 - exPercent) + self._wayPointEnd.x * exPercent
			self._posY = self._wayPointBegin.y * (1 - exPercent) + self._wayPointEnd.y * exPercent
			self._posZ = self._wayPointBegin.z * (1 - exPercent) + self._wayPointEnd.z * exPercent
		else
			self._posX = self._x_move_curve and self._wayPointBegin.x + (self._wayPointEnd.x - self._wayPointBegin.x) * self._x_move_curve:Evaluate(t) / 10 or LuaTween.tween(self._currTime, self._wayPointBegin.x, self._wayPointValue.x, self._duration, self._easeType)
			self._posY = self._y_move_curve and self._wayPointBegin.y + (self._wayPointEnd.y - self._wayPointBegin.y) * self._y_move_curve:Evaluate(t) / 10 or LuaTween.tween(self._currTime, self._wayPointBegin.y, self._wayPointValue.y, self._duration, self._easeType)
			self._posZ = self._z_move_curve and self._wayPointBegin.z + (self._wayPointEnd.z - self._wayPointBegin.z) * self._z_move_curve:Evaluate(t) / 10 or LuaTween.tween(self._currTime, self._wayPointBegin.z, self._wayPointValue.z, self._duration, self._easeType)
		end

		self.dispatchEvent(self, UnitMoveEvent.PosChanged, self)
	end
end

function UnitMoverCurve:setXMoveCruve(curveParam)
	if string.nilorempty(curveParam) then
		return
	end

	self._x_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(curveParam)

	if not self._x_move_curve then
		logError("X轴位移曲线参数错误")
	end
end

function UnitMoverCurve:setYMoveCruve(curveParam)
	if string.nilorempty(curveParam) then
		return
	end

	self._y_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(curveParam)

	if not self._y_move_curve then
		logError("Y轴位移曲线参数错误")
	end
end

function UnitMoverCurve:setZMoveCruve(curveParam)
	if string.nilorempty(curveParam) then
		return
	end

	self._z_move_curve = ZProj.AnimationCurveHelper.GetAnimationCurve(curveParam)

	if not self._z_move_curve then
		logError("Z轴位移曲线参数错误")
	end
end

function UnitMoverCurve:onDestroy()
	self._animationCurve = nil
	self._tCurve = nil
	self._x_move_curve = nil
	self._y_move_curve = nil
	self._z_move_curve = nil
	self._yOffset = nil
end

return UnitMoverCurve
