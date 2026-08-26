-- chunkname: @modules/logic/fight/system/work/FightWorkKill.lua

module("modules.logic.fight.system.work.FightWorkKill", package.seeall)

local FightWorkKill = class("FightWorkKill", FightEffectBase)

function FightWorkKill:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO.currentHp
end

function FightWorkKill:onStart()
	local entity = FightHelper.getEntity(self._entityId)

	if not entity then
		self:onDone(true)

		return
	end

	if not self._entityMO then
		self:onDone(true)

		return
	end

	self._newValue = self._entityMO and self._entityMO.currentHp

	FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, self._entityId, self._oldValue, self._newValue)
	self:onDone(true)
end

function FightWorkKill:clearWork()
	return
end

return FightWorkKill
