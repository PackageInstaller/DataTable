-- chunkname: @modules/logic/fight/system/work/FightWorkAssistBossChange.lua

module("modules.logic.fight.system.work.FightWorkAssistBossChange", package.seeall)

local FightWorkAssistBossChange = class("FightWorkAssistBossChange", FightEffectBase)

function FightWorkAssistBossChange:beforePlayEffectData()
	self._entityId = self.actEffectData.entity.id
	self._oldEntityMO = FightDataHelper.entityMgr:getOldEntityMO(self._entityId)
end

function FightWorkAssistBossChange:onStart()
	self:com_sendFightEvent(FightEvent.OnStartSwitchAssistBoss, self._entityId)

	self._newEntityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if not self._newEntityMO then
		self:onDone(true)

		return
	end

	local oldEntity = FightHelper.getEntity(self.actEffectData.targetId)

	if not oldEntity then
		self:_buildNewEntity()
		self:_dispatchChangeEvent()

		return self:onDone(true)
	end

	local switchBossFlow = self:com_registWorkDoneFlowSequence()
	local bossEvolutionConfig = lua_fight_boss_evolution_client.configDict[self._oldEntityMO.skin]

	if bossEvolutionConfig then
		oldEntity.beforeMonsterChangeSkin = self._oldEntityMO.skin

		switchBossFlow:registWork(FightWorkPlayTimeline, oldEntity, bossEvolutionConfig.timeline)
		switchBossFlow:registWork(FightWorkFunction, self._removeOldEntity, self, oldEntity)
		switchBossFlow:addWork(FightWorkFunction.New(self._buildNewEntity, self))
		switchBossFlow:registWork(FightWorkDelayTimer, 0.01)
	else
		switchBossFlow:registWork(FightWorkFunction, self._removeOldEntity, self, oldEntity)
		switchBossFlow:addWork(FightWorkFunction.New(self._buildNewEntity, self))
	end

	switchBossFlow:addWork(FightWorkFunction.New(self._dispatchChangeEvent, self))
	switchBossFlow:start()
end

function FightWorkAssistBossChange:_removeOldEntity(oldEntity)
	local entityMgr = FightGameMgr.entityMgr

	entityMgr:delEntity(oldEntity.id)
end

function FightWorkAssistBossChange:_buildNewEntity()
	local entityMgr = FightGameMgr.entityMgr
	local newEntity = entityMgr:newEntity(self._newEntityMO)
	local buffComp = newEntity and newEntity.buff

	if buffComp then
		xpcall(buffComp.dealStartBuff, __G__TRACKBACK__, buffComp)
	end
end

function FightWorkAssistBossChange:_dispatchChangeEvent()
	self:com_sendFightEvent(FightEvent.OnSwitchAssistBossSpine)
end

return FightWorkAssistBossChange
