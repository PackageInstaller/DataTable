-- chunkname: @modules/logic/fight/system/work/FightWorkEffectSpExpointMaxAdd.lua

module("modules.logic.fight.system.work.FightWorkEffectSpExpointMaxAdd", package.seeall)

local FightWorkEffectSpExpointMaxAdd = class("FightWorkEffectSpExpointMaxAdd", FightEffectBase)

function FightWorkEffectSpExpointMaxAdd:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO:getUniqueSkillPoint()
end

function FightWorkEffectSpExpointMaxAdd:onStart()
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

	if entity_mo.exPointType ~= FightEnum.ExPointType.Common then
		return
	end

	if not entity_mo:hasBuffFeature(FightEnum.BuffType_SpExPointMaxAdd) then
		self:onDone(true)

		return
	end

	FightController.instance:dispatchEvent(FightEvent.OnExpointMaxAdd, entityId, self.actEffectData.effectNum)

	self._newValue = entity_mo:getUniqueSkillPoint()

	FightController.instance:dispatchEvent(FightEvent.OnExSkillPointChange, entityId, self._oldValue, self._newValue)
	self:onDone(true)
end

return FightWorkEffectSpExpointMaxAdd
