-- chunkname: @modules/logic/versionactivity3_2/beilier/model/BeiLiErPuzzleMo.lua

module("modules.logic.versionactivity3_2.beilier.model.BeiLiErPuzzleMo", package.seeall)

local BeiLiErPuzzleMo = class("BeiLiErPuzzleMo")

function BeiLiErPuzzleMo:ctor(mo, type)
	self._mo = mo
	self.id = mo.id
	self.type = type
end

function BeiLiErPuzzleMo:init()
	if self.type == BeiLiErEnum.PuzzleType.OutCrystal then
		self:_initPuzzle()
		self:_initCorrectMo()

		self._canMove = true
		self._isCorrect = false
	elseif self.type == BeiLiErEnum.PuzzleType.OnCrystal then
		self:_initCorrectPuzzle()
	end
end

function BeiLiErPuzzleMo:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function BeiLiErPuzzleMo:getPosXY()
	return self.posX, self.posY
end

function BeiLiErPuzzleMo:getRotation()
	return self.rotation
end

function BeiLiErPuzzleMo:getRotationRange()
	return BeiLiErEnum.Rotation[self.rotation]
end

function BeiLiErPuzzleMo:setRotation(rotation)
	self.rotation = rotation
end

function BeiLiErPuzzleMo:getId()
	return self.id
end

function BeiLiErPuzzleMo:getConfig()
	return self._config
end

function BeiLiErPuzzleMo:_initPuzzle()
	if self._mo and self._mo.initCo then
		local co = self._mo.initCo

		self:updatePos(co.x, co.y)
		self:setRotation(co.rotation)
	end
end

function BeiLiErPuzzleMo:_initCorrectPuzzle()
	if self._mo and self._mo.correctCo then
		local co = self._mo.correctCo

		self:updatePos(co.x, co.y)
		self:setRotation(co.rotation)
	end

	self._canMove = false
	self._isCorrect = true
end

function BeiLiErPuzzleMo:_initCorrectMo()
	if self._mo and self._mo.correctCo then
		local co = self._mo.correctCo

		self._correctX = co.x
		self._correctY = co.y
		self._correctRotation = co.rotation
	end
end

function BeiLiErPuzzleMo:initPos()
	if self._mo and self._mo.initCo then
		local co = self._mo.initCo

		self:updatePos(co.x, co.y)
	end
end

function BeiLiErPuzzleMo:getClickPuzzle()
	local rotation = self.rotation + 1

	if rotation > 4 then
		rotation = 1
	end

	return rotation
end

function BeiLiErPuzzleMo:checkCorrectPlace()
	if self:isInCanPlaceRange() and self:rotationIsCorrect() then
		self._isCorrect = true
		self._canMove = false

		return true
	end

	return false
end

function BeiLiErPuzzleMo:rotationIsCorrect()
	return self.rotation == self._correctRotation
end

function BeiLiErPuzzleMo:checkIsCorrect()
	return self._isCorrect
end

function BeiLiErPuzzleMo:setCanMove(state)
	self._canMove = state
end

function BeiLiErPuzzleMo:getCanMove()
	return self._canMove
end

function BeiLiErPuzzleMo:getCorrectPos()
	return self._correctX, self._correctY
end

function BeiLiErPuzzleMo:isInCanPlaceRange()
	if not self._correctX or not self._correctY then
		return
	end

	local dragSureRange, _, _, _ = BeiLiErConfig.instance:getPlaceRange()

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, self._correctX, self._correctY)
end

function BeiLiErPuzzleMo:isInCanShowTipRange()
	if not self._correctX or not self._correctY then
		return
	end

	local dragSureRange, _, _, _ = BeiLiErConfig.instance:getTipRange()

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, self._correctX, self._correctY)
end

return BeiLiErPuzzleMo
