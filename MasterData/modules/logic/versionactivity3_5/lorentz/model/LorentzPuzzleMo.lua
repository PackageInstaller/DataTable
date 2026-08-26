-- chunkname: @modules/logic/versionactivity3_5/lorentz/model/LorentzPuzzleMo.lua

module("modules.logic.versionactivity3_5.lorentz.model.LorentzPuzzleMo", package.seeall)

local LorentzPuzzleMo = class("LorentzPuzzleMo")

function LorentzPuzzleMo:ctor(mo, type)
	self._mo = mo
	self.id = mo.id
	self.type = type
end

function LorentzPuzzleMo:init()
	if self.type == LorentzEnum.PuzzleType.OutCrystal then
		self:_initPuzzle()
		self:_initCorrectMo()

		self._canMove = true
		self._isCorrect = false
	elseif self.type == LorentzEnum.PuzzleType.OnCrystal then
		self:_initCorrectPuzzle()
	end
end

function LorentzPuzzleMo:updatePos(posX, posY)
	self.posX = posX
	self.posY = posY
end

function LorentzPuzzleMo:getPosXY()
	return self.posX, self.posY
end

function LorentzPuzzleMo:getRotation()
	return self.rotation
end

function LorentzPuzzleMo:getRotationRange()
	return LorentzEnum.Rotation[self.rotation]
end

function LorentzPuzzleMo:setRotation(rotation)
	self.rotation = rotation
end

function LorentzPuzzleMo:getId()
	return self.id
end

function LorentzPuzzleMo:getConfig()
	return self._config
end

function LorentzPuzzleMo:_initPuzzle()
	if self._mo and self._mo.initCo then
		local co = self._mo.initCo

		self:updatePos(co.x, co.y)
		self:setRotation(co.rotation)
	end
end

function LorentzPuzzleMo:_initCorrectPuzzle()
	if self._mo and self._mo.correctCo then
		local co = self._mo.correctCo

		self:updatePos(co.x, co.y)
		self:setRotation(co.rotation)
	end

	self._canMove = false
	self._isCorrect = true
end

function LorentzPuzzleMo:_initCorrectMo()
	if self._mo and self._mo.correctCo then
		local co = self._mo.correctCo

		self._correctX = co.x
		self._correctY = co.y
		self._correctRotation = co.rotation
	end
end

function LorentzPuzzleMo:initPos()
	if self._mo and self._mo.initCo then
		local co = self._mo.initCo

		self:updatePos(co.x, co.y)
	end
end

function LorentzPuzzleMo:getClickPuzzle()
	local rotation = self.rotation + 1

	if rotation > 4 then
		rotation = 1
	end

	return rotation
end

function LorentzPuzzleMo:checkCorrectPlace()
	if self:isInCanPlaceRange() and self:rotationIsCorrect() then
		self._isCorrect = true
		self._canMove = false

		return true
	end

	return false
end

function LorentzPuzzleMo:rotationIsCorrect()
	return self.rotation == self._correctRotation
end

function LorentzPuzzleMo:checkIsCorrect()
	return self._isCorrect
end

function LorentzPuzzleMo:setCanMove(state)
	self._canMove = state
end

function LorentzPuzzleMo:getCanMove()
	return self._canMove
end

function LorentzPuzzleMo:getCorrectPos()
	return self._correctX, self._correctY
end

function LorentzPuzzleMo:isInCanPlaceRange()
	if not self._correctX or not self._correctY then
		return
	end

	local dragSureRange, _, _, _ = LorentzConfig.instance:getPlaceRange()

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, self._correctX, self._correctY)
end

function LorentzPuzzleMo:isInCanShowTipRange()
	if not self._correctX or not self._correctY then
		return
	end

	local dragSureRange, _, _, _ = LorentzConfig.instance:getTipRange()

	return MathUtil.isPointInCircleRange(self.posX, self.posY, dragSureRange, self._correctX, self._correctY)
end

return LorentzPuzzleMo
