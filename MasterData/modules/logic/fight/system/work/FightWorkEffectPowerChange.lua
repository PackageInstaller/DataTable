-- chunkname: @modules/logic/fight/system/work/FightWorkEffectPowerChange.lua

module("modules.logic.fight.system.work.FightWorkEffectPowerChange", package.seeall)

local FightWorkEffectPowerChange = class("FightWorkEffectPowerChange", FightEffectBase)

function FightWorkEffectPowerChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._powerId = self.actEffectData.configEffect
	self._powerData = self._entityMO and self._entityMO:getPowerInfo(self._powerId)
	self._oldValue = self._powerData and self._powerData.num
end

function FightWorkEffectPowerChange:onStart()
	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		self:onDone(true)

		return
	end

	if not self._entityMO then
		self:onDone(true)

		return
	end

	self._powerData = self._entityMO and self._entityMO:getPowerInfo(self._powerId)

	if not self._powerData then
		logError(string.format("找不到灵光数据,灵光id:%s, 角色或怪物id:%s, 步骤类型:%s, actId:%s", self._powerId, self._entityMO.modelId, self.fightStepData.actType, self.fightStepData.actId))
		self:onDone(true)

		return
	end

	self._newValue = self._powerData and self._powerData.num

	if self._oldValue ~= self._newValue then
		FightController.instance:dispatchEvent(FightEvent.PowerChange, self.actEffectData.targetId, self._powerId, self._oldValue, self._newValue)
	end

	self:onDone(true)
end

function FightWorkEffectPowerChange:clearWork()
	return
end

return FightWorkEffectPowerChange
