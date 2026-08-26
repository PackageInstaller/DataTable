-- chunkname: @modules/logic/fight/system/work/FightWorkSummonedLevelUp.lua

module("modules.logic.fight.system.work.FightWorkSummonedLevelUp", package.seeall)

local FightWorkSummonedLevelUp = class("FightWorkSummonedLevelUp", FightEffectBase)

function FightWorkSummonedLevelUp:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._uid = self.actEffectData.reserveId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)

	if self._entityMO then
		local summonedInfo = self._entityMO:getSummonedInfo()

		self._summonedData = self._entityMO and self._entityMO:getData(self._uid)
		self._oldLevel = self._summonedData and self._summonedData.level
	end
end

function FightWorkSummonedLevelUp:onStart()
	if not self._summonedData then
		self:onDone(true)

		return
	end

	self._newLevel = self._summonedData.level

	local config = FightConfig.instance:getSummonedConfig(self._summonedData.summonedId, self._summonedData.level)

	if config then
		self:com_registTimer(self._delayDone, config.enterTime / 1000 / FightModel.instance:getSpeed())
		FightController.instance:dispatchEvent(FightEvent.SummonedLevelChange, self._entityId, self._uid, self._oldLevel, self._newLevel)

		return
	end

	logError("挂件表找不到id:" .. self._summonedData.summonedId .. "  等级:" .. self._summonedData.level)
	self:onDone(true)
end

function FightWorkSummonedLevelUp:_delayDone()
	self:onDone(true)
end

function FightWorkSummonedLevelUp:clearWork()
	return
end

return FightWorkSummonedLevelUp
