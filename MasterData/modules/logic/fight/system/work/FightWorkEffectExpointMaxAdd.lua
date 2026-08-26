-- chunkname: @modules/logic/fight/system/work/FightWorkEffectExpointMaxAdd.lua

module("modules.logic.fight.system.work.FightWorkEffectExpointMaxAdd", package.seeall)

local FightWorkEffectExpointMaxAdd = class("FightWorkEffectExpointMaxAdd", FightEffectBase)

function FightWorkEffectExpointMaxAdd:onStart()
	local entityId = self.actEffectData.targetId

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, entityId, self.actEffectData.effectNum)
	self:onDone(true)
end

function FightWorkEffectExpointMaxAdd:_startAddExpointMax()
	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		self:onDone(true)

		return
	end

	local entity_mo = entity:getMO()

	if not entity_mo then
		self:onDone(true)

		return
	end

	if entity_mo:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		self:onDone(true)

		return
	end

	entity_mo:changeExpointMaxAdd(self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, entityId, self.actEffectData.effectNum)
	self:_onDone()
end

function FightWorkEffectExpointMaxAdd:_onDone()
	self:clearWork()
	self:onDone(true)
end

function FightWorkEffectExpointMaxAdd:clearWork()
	return
end

return FightWorkEffectExpointMaxAdd
