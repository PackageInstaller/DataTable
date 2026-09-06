-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logicscene/scene/unit/action/UnitActionMoveToXZ.lua

module("logicscene.scene.unit.action.UnitActionMoveToXZ", package.seeall)

local UnitActionMoveToXZ = class("UnitActionMoveToXZ", UnitActionMoveTo)

function UnitActionMoveToXZ:step()
	self._moveDiff = self._distance * self._percent
	self._moveDiffX = self._posStartX + self._dirX * self._moveDiff
	self._moveDiffY = self._posStartY + self._dirY * self._moveDiff

	local _, posY, _ = self._transform:getPos()

	self._transform:setPos(self._moveDiffX, posY, self._moveDiffY)
end

function UnitActionMoveToXZ:_setDest(x, y, startX, startY)
	self._posStartX = startX
	self._posStartY = startY

	local pos = 0

	_, pos, _ = self._transform:getPos()

	if not self._posStartX or not self._posStartY then
		self._posStartX, pos, self._posStartY = self._transform:getPos()
	end

	local speedRate = self:_getMoveSpeedRate()

	self._posX = x
	self._posY = y
	self._speed = self._transform:getMoveSpeed() * speedRate
	self._distance, self._dirX, _, self._dirY = self._transform:distAndDir(x, pos, y)
	self._duration = self._distance / self._speed
	self._elapsed = 0

	if self._dirX ~= 0 or self._dirY ~= 0 then
		self._unit.spine:setPlaySpeed(speedRate)

		if not self.isPause then
			self._spineMover:playWalkAnim(self._dirX, self._dirY)
		end
	end
end

function UnitActionMoveToXZ:reverse()
	if self._posStartX and self._posStartY then
		return UnitActionMoveToXZ.New(self._posStartX, self._posStartY, self._posX, self._posY)
	end
end

return UnitActionMoveToXZ
