-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameBoat.lua

module("logic.extensions.fishinggame.model.FishingGameBoat", package.seeall)

local FishingGameBoat = class("FishingGameBoat")
local HookSize = 44

function FishingGameBoat:ctor(cfg)
	self.position = {
		x = 0,
		y = 231
	}
	self.angle = -90
	self.length = 0
	self.id = 0
	self._limitLength = 500
	self._isCasting = false
	self._isFrozen = false
	self._rodDirect = FishingGameEnum.RodDirect.None
	self._rodAddDirect = FishingGameEnum.RodAddDirect.Down
	self._boatDirect = FishingGameEnum.BoatDirect.None
	self._boatSpeed = cfg and checknumber(cfg.boatSpeed) or 120
	self._hookAddSpeed = cfg and checknumber(cfg.hookAddSpeed) or 120
	self._hookAngleSpeed = cfg and checknumber(cfg.hookAngleSpeed) or 8
	self._hookMaxAngle = cfg and checknumber(cfg.hookMaxAngle) or 10
end

function FishingGameBoat:setCom(containerCom)
	self._containerCom = containerCom

	if self._containerCom then
		self._containerCom:setUnit(self)
	end
end

function FishingGameBoat:getCom()
	return self._containerCom
end

function FishingGameBoat:startCast()
	self._isCasting = true
	self._rodAddDirect = FishingGameEnum.RodAddDirect.Down
end

function FishingGameBoat:forceRetract()
	self._isCasting = true
	self._rodAddDirect = FishingGameEnum.RodAddDirect.Up
end

function FishingGameBoat:stopCast()
	self._isCasting = false
	self._rodAddDirect = FishingGameEnum.RodAddDirect.None
	self.length = 0
	self.angle = -90
end

function FishingGameBoat:isRetracting()
	return self._rodAddDirect == FishingGameEnum.RodAddDirect.Up
end

function FishingGameBoat:isDropping()
	return self._rodAddDirect == FishingGameEnum.RodAddDirect.Down
end

function FishingGameBoat:isAtHome()
	return self.length <= 0
end

function FishingGameBoat:setFrozen(isFrozen)
	self._isFrozen = isFrozen
end

function FishingGameBoat:isFrozen()
	return self._isFrozen
end

function FishingGameBoat:update(deltaTime)
	if self._isFrozen then
		return
	end

	self:_moveBoat(deltaTime)
	self:_moveRod(deltaTime)
end

function FishingGameBoat:_moveBoat(deltaTime)
	local moveDistance = self._boatSpeed * self._boatDirect * deltaTime

	self.position.x = Mathf.Clamp(self.position.x + moveDistance, -640, 640)
end

function FishingGameBoat:_moveRod(deltaTime)
	if not self._isCasting then
		self:_updateRodDirect()
		self:_swingRod(deltaTime)

		return
	end

	local addLength = self._hookAddSpeed * self._rodAddDirect * deltaTime

	self.length = Mathf.Clamp(self.length + addLength, 0, self._limitLength)

	if self.length >= self._limitLength then
		self:forceRetract()
	elseif self.length <= 0 and self._rodAddDirect == FishingGameEnum.RodAddDirect.Up then
		self:stopCast()
	end

	self:_updateRodDirect()
	self:_swingRod(deltaTime)
end

function FishingGameBoat:_updateRodDirect()
	if self.angle >= -91 and self.angle <= -89 then
		self._rodDirect = self._boatDirect == FishingGameEnum.BoatDirect.Left and FishingGameEnum.RodDirect.Right or self._boatDirect == FishingGameEnum.BoatDirect.Right and FishingGameEnum.RodDirect.Left or FishingGameEnum.RodDirect.None
	elseif self.angle < -91 then
		if self._boatDirect == FishingGameEnum.BoatDirect.Right then
			self._rodDirect = FishingGameEnum.RodDirect.Left or FishingGameEnum.RodDirect.Right
		end
	elseif self._boatDirect == FishingGameEnum.BoatDirect.Left then
		self._rodDirect = FishingGameEnum.RodDirect.Right or FishingGameEnum.RodDirect.Left
	end
end

function FishingGameBoat:_swingRod(deltaTime)
	local addAngle = self._rodDirect * self._hookAngleSpeed * deltaTime

	self.angle = Mathf.Clamp(self.angle + addAngle, -90 - self._hookMaxAngle, -90 + self._hookMaxAngle)
end

function FishingGameBoat:setBoatDirect(direct)
	self._boatDirect = direct
end

function FishingGameBoat:getHookPosition()
	local rad = math.rad(self.angle)
	local hookX = self.position.x + math.cos(rad) * self.length
	local hookY = self.position.y + math.sin(rad) * self.length

	return hookX, hookY
end

function FishingGameBoat:getHookRect()
	local hookX, hookY = self:getHookPosition()

	return {
		x = hookX - HookSize * 0.5,
		y = hookY - HookSize * 0.5,
		w = HookSize,
		h = HookSize
	}
end

function FishingGameBoat:getBoatRect()
	return {
		w = 230,
		h = 20,
		x = self.position.x - 174,
		y = self.position.y - 110
	}
end

function FishingGameBoat:getPeopleRect()
	return {
		w = 94,
		h = 180,
		x = self.position.x - 166,
		y = self.position.y - 33
	}
end

return FishingGameBoat
