-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionMoveCircleArc.lua

module("logicscene.scene.unit.action.UnitActionMoveCircleArc", package.seeall)

local UnitActionMoveCircleArc = class("UnitActionMoveCircleArc", UnitActionBase)

function UnitActionMoveCircleArc:ctor(arcStartX, arcStartY, arcDestX, arcDestY, radius)
	UnitActionMoveCircleArc.super.ctor(self)

	self._arcStartX = arcStartX
	self._arcStartY = arcStartY
	self._arcDestX = arcDestX
	self._arcDestY = arcDestY
	self._radius = radius
end

function UnitActionMoveCircleArc:start(unit)
	UnitActionMoveCircleArc.super.start(self, unit)

	self._transform = unit.transform
	self._spineMover = unit.spineMover

	self:_startMoveOnArc()
end

function UnitActionMoveCircleArc:stop()
	if not UnitCompActions.doNotStopAnimOnMoveActionFinish then
		if self._spineMover then
			self._spineMover:playIdleAnim()
		end

		UnitCompActions.doNotStopAnimOnMoveActionFinish = nil
	end

	UnitActionMoveTo.super.stop(self)
end

function UnitActionMoveCircleArc:_startMoveOnArc()
	local dirX, dirY = self._arcDestX - self._arcStartX, self._arcDestY - self._arcStartY

	print(self._arcStartX, self._arcStartY, self._arcDestX, self._arcDestY)

	local rAngle = dirX > 0 and 90 or -90
	local radian = rAngle * math.pi / 180
	local sin = math.sin(radian)
	local cos = math.cos(radian)
	local centerDirX = cos * dirX + sin * dirY
	local centerDirY = -sin * dirX + cos * dirY
	local length = math.sqrt(centerDirX * centerDirX + centerDirY * centerDirY)

	centerDirX = centerDirX / length
	centerDirY = centerDirY / length

	local chordCenterX = (self._arcStartX + self._arcDestX) * 0.5
	local chordCenterY = (self._arcStartY + self._arcDestY) * 0.5
	local chordHalfLength = math.sqrt(dirX * dirX + dirY * dirY) * 0.5

	chordHalfLength = math.min(chordHalfLength, self._radius)
	length = math.sqrt(self._radius * self._radius - chordHalfLength * chordHalfLength)
	self._centerX = chordCenterX + centerDirX * length
	self._centerY = chordCenterY + centerDirY * length
	self._startRadian = math.acos(math.max(-1, math.min(1, (self._arcStartX - self._centerX) / self._radius)))
	self._destRadian = math.acos(math.max(-1, math.min(1, (self._arcDestX - self._centerX) / self._radius)))

	local centerRadian = math.asin(chordHalfLength / self._radius)
	local arcLength = centerRadian * self._radius

	self._duration = arcLength / self._unit.transform:getMoveSpeed()
	self._dirX = dirX
	self._dirY = dirY
end

function UnitActionMoveCircleArc:step()
	local currRadian = self._startRadian + (self._destRadian - self._startRadian) * self._percent
	local posX, posY = self._centerX + self._radius * math.cos(currRadian), self._centerY + self._radius * math.sin(currRadian)

	self._transform:setPos(posX, posY)
	self._spineMover:playWalkAnim(self._dirX, self._dirY)
end

function UnitActionMoveCircleArc:reverse()
	return UnitActionMoveCircleArc.New(self._arcDestX, self._arcDestY, self._arcStartY, self._arcStartY, self._radius)
end

return UnitActionMoveCircleArc
