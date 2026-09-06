-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionMoveTo.lua

module("logicscene.scene.unit.action.UnitActionMoveTo", package.seeall)

local UnitActionMoveTo = class("UnitActionMoveTo", UnitActionBase)

function UnitActionMoveTo:ctor(x, y, startX, startY)
	UnitActionMoveTo.super.ctor(self)

	self._posX = x
	self._posY = y
	self._posStartX = startX
	self._posStartY = startY
	self._speed = nil
	self._distance = nil
	self._moveDiff = nil
	self._moveDiffX = nil
	self._moveDiffY = nil
	self._moveDiffXLast = nil
	self._moveDiffYLast = nil
	self._transform = nil
	self._spineMover = nil
	self.isPause = nil
end

function UnitActionMoveTo:start(unit)
	UnitActionMoveTo.super.start(self, unit)

	self._transform = unit.transform
	self._spineMover = unit.spineMover

	if self._posX and self._posY then
		self:_setDest(self._posX, self._posY)
	end
end

function UnitActionMoveTo:_setDest(x, y, startX, startY)
	self._posStartX = startX
	self._posStartY = startY

	if not self._posStartX or not self._posStartY then
		self._posStartX, self._posStartY = self._transform:getPos()
	end

	local speedRate = self:_getMoveSpeedRate()

	self._posX = x
	self._posY = y
	self._speed = self._transform:getMoveSpeed() * speedRate
	self._distance, self._dirX, self._dirY = self._transform:distAndDir(x, y)
	self._duration = self._distance / self._speed
	self._elapsed = 0

	if self._dirX ~= 0 or self._dirY ~= 0 then
		self._unit.spine:setPlaySpeed(speedRate)

		if not self.isPause then
			self._spineMover:playWalkAnim(self._dirX, self._dirY)
		end
	end
end

function UnitActionMoveTo:stop()
	if self._unit then
		self._unit.spine:setPlaySpeed(1)
	end

	UnitActionMoveTo.super.stop(self)

	if not UnitCompActions.doNotStopAnimOnMoveActionFinish then
		if self._spineMover then
			self._spineMover:playIdleAnim()
		end

		UnitCompActions.doNotStopAnimOnMoveActionFinish = nil
	end

	self._dirX = nil
	self._spineMover = nil
	self._dirY = nil
	self._distance = nil
	self._speed = nil
	self._transform = nil
	self._moveDiff = nil
	self._moveDiffX = nil
	self._moveDiffY = nil
	self.isPause = nil
end

function UnitActionMoveTo:onPause()
	self.isPause = true

	if self._spineMover then
		self._spineMover:playIdleAnim()
	end
end

function UnitActionMoveTo:onResume()
	self.isPause = nil

	if self._spineMover and self._dirX and self._dirY and (self._dirX ~= 0 or self._dirY ~= 0) then
		self._spineMover:playWalkAnim(self._dirX, self._dirY)
	end
end

function UnitActionMoveTo:step()
	self._moveDiff = self._distance * self._percent
	self._moveDiffX = self._posStartX + self._dirX * self._moveDiff
	self._moveDiffY = self._posStartY + self._dirY * self._moveDiff

	if self._moveDiffXLast ~= self._moveDiffX or self._moveDiffXLast ~= self._moveDiffY then
		self._moveDiffXLast = self._moveDiffX
		self._moveDiffYLast = self._moveDiffY

		self._transform:setPos(self._moveDiffX, self._moveDiffY)
	end
end

function UnitActionMoveTo:reverse()
	if self._posStartX and self._posStartY then
		return UnitActionMoveTo.New(self._posStartX, self._posStartY, self._posX, self._posY)
	end
end

function UnitActionMoveTo:_getMoveSpeedRate()
	return 1
end

return UnitActionMoveTo
