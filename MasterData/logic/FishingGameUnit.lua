-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fishinggame/model/FishingGameUnit.lua

module("logic.extensions.fishinggame.model.FishingGameUnit", package.seeall)

local FishingGameUnit = class("FishingGameUnit")

function FishingGameUnit:ctor()
	self.position = {
		x = 0,
		y = 0
	}
	self.rect = SimpleQuadTree.createRect(0, 0, 0, 0)
	self.id = 0
	self.width = 0
	self.height = 0
	self._isActive = false
	self._containerCom = nil
	self._state = FishingGameEnum.UnitState.Idle
	self._unitType = 0
end

function FishingGameUnit:reset()
	self.position.x = 0
	self.position.y = 0
	self.id = 0
	self.width = 0
	self.height = 0
	self._isActive = false
	self._state = FishingGameEnum.UnitState.Idle
	self._unitType = 0

	self:_syncRect()

	if self._containerCom then
		self._containerCom:reset()

		self._containerCom = nil
	end
end

function FishingGameUnit:setCom(containerCom)
	self._containerCom = containerCom

	if self._containerCom then
		self._containerCom:setUnit(self)
	end
end

function FishingGameUnit:getCom()
	return self._containerCom
end

function FishingGameUnit:clearCom()
	self._containerCom = nil
end

function FishingGameUnit:isActive()
	return self._isActive
end

function FishingGameUnit:setActive(active)
	self._isActive = active

	if self._containerCom then
		self._containerCom:setVisible(active)
	end
end

function FishingGameUnit:getUnitId()
	return self.id
end

function FishingGameUnit:setUnitId(id)
	self.id = id
end

function FishingGameUnit:getName()
	return string.format("%s_%s", tostring(self:getType()), tostring(self.id))
end

function FishingGameUnit:getType()
	return self._unitType
end

function FishingGameUnit:getCurState()
	return self._state
end

function FishingGameUnit:setState(state)
	self._state = state or FishingGameEnum.UnitState.Idle
end

function FishingGameUnit:setPosition(posX, posY)
	self.position.x = checknumber(posX)
	self.position.y = checknumber(posY)

	self:_syncRect()
end

function FishingGameUnit:beOutOfScreen()
	self._isActive = false
end

function FishingGameUnit:beforeUpdate()
	return
end

function FishingGameUnit:update(deltaTime)
	return
end

function FishingGameUnit:afterUpdate()
	return
end

function FishingGameUnit:_syncRect()
	self.rect.x = self.position.x - self.width * 0.5
	self.rect.y = self.position.y - self.height * 0.5
	self.rect.w = self.width
	self.rect.h = self.height
end

return FishingGameUnit
