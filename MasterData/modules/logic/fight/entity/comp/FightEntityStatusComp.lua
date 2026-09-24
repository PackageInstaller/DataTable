-- chunkname: @modules/logic/fight/entity/comp/FightEntityStatusComp.lua

module("modules.logic.fight.entity.comp.FightEntityStatusComp", package.seeall)

local FightEntityStatusComp = class("FightEntityStatusComp", FightBaseClass)

function FightEntityStatusComp:onConstructor(entity)
	self.entity = entity
	self.entityId = entity.entityId
	self.entityMo = self.entity:getMO()
end

function FightEntityStatusComp:onLogicEnter()
	self:com_registFightEvent(FightEvent.OnEntityDyingChange, self.onStatusChange)
	self:onStatusChange(self.entityId, self.entityMo and self.entityMo.status)
end

function FightEntityStatusComp:onStatusChange(entityId, curStatus)
	if entityId ~= self.entityId then
		return
	end

	if curStatus == FightEnum.EntityStatus.Dying then
		self:addDyingEffect()
	else
		self:removeDyingEffect()
	end
end

function FightEntityStatusComp:addDyingEffect()
	if self.dyingEffect then
		return
	end

	self.entity:resetAnimState()

	self.dyingEffect = self.entity.effect:addHangEffect("roleeffects/roleeffect_transparent", ModuleEnum.SpineHangPointRoot)

	self.dyingEffect:setLocalPos(0, 0, 0)
end

function FightEntityStatusComp:removeDyingEffect()
	if self.dyingEffect then
		self.entity:resetAnimState()
		self.entity.effect:removeEffect(self.dyingEffect)

		self.dyingEffect = nil
	end
end

function FightEntityStatusComp:onDestructor()
	self:removeDyingEffect()
end

return FightEntityStatusComp
