-- chunkname: @modules/logic/fight/system/work/FightWorkSummonedDelete.lua

module("modules.logic.fight.system.work.FightWorkSummonedDelete", package.seeall)

local FightWorkSummonedDelete = class("FightWorkSummonedDelete", FightEffectBase)

function FightWorkSummonedDelete:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._uid = self.actEffectData.reserveId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if self._entityMO then
		local summonedInfo = self._entityMO:getSummonedInfo()

		self._oldValue = self._entityMO and self._entityMO:getData(self._uid)
	end
end

function FightWorkSummonedDelete:onStart()
	if not self._oldValue then
		self:onDone(true)

		return
	end

	local config = FightConfig.instance:getSummonedConfig(self._oldValue.summonedId, self._oldValue.level)

	if config then
		self:com_registTimer(self._delayDone, config.closeTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.PlayRemoveSummoned, self._entityId, self._uid)

		return
	end

	logError("挂件表找不到id:" .. self._oldValue.summonedId .. "  等级:" .. self._oldValue.level)
	self:onDone(true)
end

function FightWorkSummonedDelete:_delayDone()
	self:onDone(true)
end

function FightWorkSummonedDelete:clearWork()
	FightController.instance:dispatchEvent(FightEvent.SummonedDelete, self._entityId, self._uid)
end

return FightWorkSummonedDelete
