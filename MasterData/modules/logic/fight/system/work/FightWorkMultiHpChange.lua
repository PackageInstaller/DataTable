-- chunkname: @modules/logic/fight/system/work/FightWorkMultiHpChange.lua

module("modules.logic.fight.system.work.FightWorkMultiHpChange", package.seeall)

local FightWorkMultiHpChange = class("FightWorkMultiHpChange", FightEffectBase)

function FightWorkMultiHpChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(self._entityId)
end

function FightWorkMultiHpChange:onStart()
	self._newEntityMO = FightDataHelper.entityMgr:getById(self._entityId)

	local entity = FightHelper.getEntity(self._entityId)

	if not entity or not self._oldEntityMO then
		self:onDone(true)

		return
	end

	local flow = self:com_registWorkDoneFlowSequence()

	if self._newEntityMO then
		entity.beforeMonsterChangeSkin = self._oldEntityMO.skin

		local afterChangeFlow = FightWorkFlowSequence.New()

		afterChangeFlow:registWork(FightWorkFunction, self._buildNewEntity, self)
		afterChangeFlow:registWork(FightWorkSendEvent, FightEvent.MultiHpChange, self._newEntityMO.id)
		FightHelper.buildMonsterA2B(entity, self._oldEntityMO, flow, afterChangeFlow)
	end

	flow:start()
end

function FightWorkMultiHpChange:_buildNewEntity()
	local evolutionConfig = lua_fight_boss_evolution_client.configDict[self._oldEntityMO.skin]

	if evolutionConfig then
		local oldEntity = FightHelper.getEntity(self._newEntityMO.id)

		if oldEntity then
			FightGameMgr.entityMgr:delEntity(oldEntity.id)
		end

		local newEntity = FightGameMgr.entityMgr:newEntity(self._newEntityMO)
		local buffComp = newEntity and newEntity.buff

		if buffComp then
			xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
		end
	end
end

function FightWorkMultiHpChange:clearWork()
	return
end

return FightWorkMultiHpChange
