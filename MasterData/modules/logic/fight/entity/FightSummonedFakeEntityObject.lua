-- chunkname: @modules/logic/fight/entity/FightSummonedFakeEntityObject.lua

module("modules.logic.fight.entity.FightSummonedFakeEntityObject", package.seeall)

local FightSummonedFakeEntityObject = class("FightSummonedFakeEntityObject", FightEntityObject)

FightSummonedFakeEntityObject.isFightSummonedFakeEntityObject = true

function FightSummonedFakeEntityObject:getTag()
	return SceneTag.UnitNpc
end

function FightSummonedFakeEntityObject:onConstructor()
	self.fromEntityId = self.entityData.SUMMONED_ENTITY_FROM_ID

	FightRenderOrderMgr.instance:unregister(self.id)
	self:com_registMsg(FightMsgId.OnSetEntityRederOrder, self.onSetEntityRederOrder)
	self:com_registFightEvent(FightEvent.AfterInitSpine, self.onAfterInitSpine)
end

function FightSummonedFakeEntityObject:onAfterInitSpine(handle)
	if handle == self.spine then
		local fromEntity = FightGameMgr.entityMgr:getById(self.fromEntityId)

		self.spine:setRenderOrder((fromEntity.spine._renderOrder or 0) + 1)
	end
end

function FightSummonedFakeEntityObject:onSetEntityRederOrder(entityId, order, force)
	if entityId == self.fromEntityId then
		self.spine:setRenderOrder(order + 1, force)
	end
end

function FightSummonedFakeEntityObject:initComponents()
	self.spine = self:addEntityComponent(FightUnitSpine)
	self.spineRenderer = self:addEntityComponent(FightSpineRendererComp)
	self.effect = self:addEntityComponent(FightEffectComp)
	self.moveComp = self:addEntityComponent(FightEntityMoveComp)
end

function FightSummonedFakeEntityObject:getMO()
	return self.entityData
end

return FightSummonedFakeEntityObject
