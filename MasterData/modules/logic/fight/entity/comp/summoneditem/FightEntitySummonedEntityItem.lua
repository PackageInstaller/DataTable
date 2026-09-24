-- chunkname: @modules/logic/fight/entity/comp/summoneditem/FightEntitySummonedEntityItem.lua

module("modules.logic.fight.entity.comp.summoneditem.FightEntitySummonedEntityItem", package.seeall)

local FightEntitySummonedEntityItem = class("FightEntitySummonedEntityItem", FightBaseClass)

function FightEntitySummonedEntityItem:onConstructor(entity, data, config)
	self.entity = entity
	self.entityData = entity.entityData

	if not self.entityData then
		return
	end

	self.data = data
	self.config = config
	self.uid = data.uid

	local replaceConfig = lua_fight_entity_summoned_replace_by_skin.configDict[config.keyForEntiySummon][self.entityData.skin]

	replaceConfig = replaceConfig or lua_fight_entity_summoned_replace_by_skin.configDict[config.keyForEntiySummon][0]
	self.skin = replaceConfig.keyForEntiySummonSkinId
	self.skinConfig = lua_monster_skin

	local stanceConfig = lua_fight_summoned_stance.configDict[config.stanceId]

	if stanceConfig then
		local tab = stanceConfig["pos" .. data.stanceIndex]

		self.posZ = tab[3] or 0
		self.posY = tab[2] or 0
		self.posX = tab[1] or 0
	else
		self.posX, self.posY, self.posZ = 0, 0, 0
	end

	self:com_registFightEvent(FightEvent.SummonedDelete, self.onSummonedDelete)
	self:com_registFightEvent(FightEvent.SetEntityAlpha, self._onSetEntityAlpha)
	self:com_registFightEvent(FightEvent.BeforeDeadEffect, self._onBeforeDeadEffect)
	self:com_registFightEvent(FightEvent.SetSpinePosByTimeline, self._onSetSpinePosByTimeline)
	self:com_registMsg(FightMsgId.GetSummonedEntity, self.onGetSummonedEntity)
	self:showSpine()
end

function FightEntitySummonedEntityItem:_onBeforeDeadEffect(entityId)
	if entityId ~= self.entity.id then
		return
	end

	if not self.summonedEntity or not self.summonedEntity.spine then
		return
	end

	self.summonedEntity.spine:play(SpineAnimState.die, false, false, true)
end

function FightEntitySummonedEntityItem:_onSetSpinePosByTimeline(entityId, posX, posY, posZ)
	if entityId ~= self.entity.id then
		return
	end

	if not self.summonedEntity or not self.summonedEntity.spine then
		return
	end

	local obj = self.summonedEntity.spine:getSpineGO()

	if obj then
		transformhelper.setLocalPos(obj.transform, posX, posY, posZ)
	end
end

function FightEntitySummonedEntityItem:_onSetEntityAlpha(entityId, isShow, duration)
	if entityId ~= self.entity.id then
		return
	end

	if not self.summonedEntity then
		return
	end

	local alpha = self.entity.marked_alpha

	if alpha == nil then
		alpha = isShow and 1 or 0
	end

	self.summonedEntity:setAlpha(alpha, duration or 0)
end

function FightEntitySummonedEntityItem:onGetSummonedEntity(entityId)
	if entityId == self.entity.id then
		FightMsgMgr.replyMsg(FightMsgId.GetSummonedEntity, self.summonedEntity)
	end
end

function FightEntitySummonedEntityItem:showSpine()
	local fakeEntityData = FightEntityMO.New()

	self.fakeEntityData = fakeEntityData

	fakeEntityData:init(FightDef_pb.FightEntityInfo())

	fakeEntityData.uid = "summonedFakeEntity" .. FightObject.Counter
	fakeEntityData.id = fakeEntityData.uid
	fakeEntityData.skin = self.skin
	fakeEntityData.side = self.entityData.side
	fakeEntityData.IS_SUMMONED_ENTITY = true
	fakeEntityData.SUMMONED_ENTITY_FROM_ID = self.entity.id
	self._containerGO = self.entity.go
	self.summonedEntity = self:newClass(FightSummonedFakeEntityObject, fakeEntityData.id, fakeEntityData)

	local flow = self:com_registFlowSequence()

	flow:addWork(self.summonedEntity:registLoadSpineWork())
	flow:registWork(FightWorkFunction, self.setSpinePos, self)
	flow:start()
end

function FightEntitySummonedEntityItem:setSpinePos()
	local obj = self.summonedEntity.spine:getSpineGO()

	if obj then
		transformhelper.setLocalPos(obj.transform, self.posX, self.posY, self.posZ)
	end

	self.summonedEntity:setAlpha(0, 0)

	if not self.entity.marked_alpha then
		self.summonedEntity:setAlpha(self.entity.marked_alpha, 1)
	end
end

function FightEntitySummonedEntityItem:onSummonedDelete()
	if self._isDyingForDelete then
		return
	end

	if self.summonedEntity then
		local spine = self.summonedEntity.spine

		if not spine or not spine:hasAnimation(SpineAnimState.die) then
			self:disposeSelf()

			return
		end

		self._isDyingForDelete = true

		spine:addAnimEventCallback(self._onDieAnimEventForDelete, self)
		spine:play(SpineAnimState.die, false, true, true)
		self:com_registTimer(self._disposeAfterDieAnim, 3)
	end
end

function FightEntitySummonedEntityItem:_onDieAnimEventForDelete(actionName, eventName, eventArgs)
	if actionName == SpineAnimState.die and eventName == SpineAnimEvent.ActionComplete then
		self:_disposeAfterDieAnim()
	end
end

function FightEntitySummonedEntityItem:_disposeAfterDieAnim()
	if not self._isDyingForDelete then
		return
	end

	self._isDyingForDelete = false

	if self.summonedEntity and self.summonedEntity.spine then
		self.summonedEntity.spine:removeAnimEventCallback(self._onDieAnimEventForDelete, self)
	end

	self:disposeSelf()
end

function FightEntitySummonedEntityItem:onDestructor()
	return
end

return FightEntitySummonedEntityItem
