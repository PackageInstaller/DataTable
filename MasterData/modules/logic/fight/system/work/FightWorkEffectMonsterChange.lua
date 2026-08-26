-- chunkname: @modules/logic/fight/system/work/FightWorkEffectMonsterChange.lua

module("modules.logic.fight.system.work.FightWorkEffectMonsterChange", package.seeall)

local FightWorkEffectMonsterChange = class("FightWorkEffectMonsterChange", FightEffectBase)

function FightWorkEffectMonsterChange:beforePlayEffectData()
	self._entityId = self.actEffectData.entity.id
	self._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(self._entityId)
end

function FightWorkEffectMonsterChange:onStart()
	self._newEntityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if not self._newEntityMO then
		self:onDone(true)

		return
	end

	local oldEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if not oldEntity then
		local work = self:registBuildNewEntityWork()

		self:playWorkAndDone(work)

		return
	end

	self.oldEntity = oldEntity
	self._newEntityMO.custom_refreshNameUIOp = true

	local flowDone = self:com_registWorkDoneFlowSequence()

	flowDone:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeBefore, self._oldEntityMO.modelId))

	local bossEvolutionConfig = lua_fight_boss_evolution_client.configDict[self._oldEntityMO.skin]

	if bossEvolutionConfig then
		oldEntity.beforeMonsterChangeSkin = self._oldEntityMO.skin

		local flow = FightWorkFlowSequence.New()
		local newEntityFlow = self:com_registFlowSequence()

		newEntityFlow:registWork(FightWorkFunction, self.setNilBeforeNewEntity, self)
		newEntityFlow:addWork(self:registBuildNewEntityWork())
		FightHelper.buildMonsterA2B(oldEntity, self._oldEntityMO, flow, newEntityFlow)
		flow:registWork(FightWorkDelayTimer, 0.01)
		flowDone:addWork(flow)
	else
		flowDone:addWork(self:registBuildNewEntityWork())
	end

	flowDone:addWork(Work2FightWork.New(FightWorkNormalDialog, FightViewDialog.Type.MonsterChangeAfter, self._newEntityMO.modelId))
	flowDone:registWork(FightWorkFunction, self._dispatchChangeEvent, self)
	flowDone:start()
end

function FightWorkEffectMonsterChange:registBuildNewEntityWork()
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkFunction, FightGameMgr.entityMgr.delEntity, FightGameMgr.entityMgr, self._newEntityMO.id)
	flow:registWork(FightWorkSendEvent, FightEvent.BeforeDestroyEntity, self.oldEntity)
	flow:addWork(FightGameMgr.entityMgr:registNewEntityWork(self._newEntityMO))
	flow:registWork(FightWorkFunction, self.dealBuffAfterNewEntity, self)

	return flow
end

function FightWorkEffectMonsterChange:setNilBeforeNewEntity()
	FightGameMgr.entityMgr.entityDic[self._newEntityMO.id] = nil
end

function FightWorkEffectMonsterChange:dealBuffAfterNewEntity()
	local entity = FightGameMgr.entityMgr:getById(self._newEntityMO.id)
	local buffComp = entity and entity.buff

	if buffComp then
		xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
	end
end

function FightWorkEffectMonsterChange:_dispatchChangeEvent()
	self:com_sendFightEvent(FightEvent.OnMonsterChange, self._oldEntityMO, self._newEntityMO)
end

function FightWorkEffectMonsterChange:clearWork()
	return
end

return FightWorkEffectMonsterChange
