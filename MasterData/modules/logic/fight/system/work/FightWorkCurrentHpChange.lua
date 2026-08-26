-- chunkname: @modules/logic/fight/system/work/FightWorkCurrentHpChange.lua

module("modules.logic.fight.system.work.FightWorkCurrentHpChange", package.seeall)

local FightWorkCurrentHpChange = class("FightWorkCurrentHpChange", FightEffectBase)

function FightWorkCurrentHpChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO.currentHp
end

function FightWorkCurrentHpChange:onStart()
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

	FightController.instance:dispatchEvent(FightEvent.OnCurrentHpChange, self.actEffectData.targetId, self._oldValue, self._newValue)
	self:onDone(true)
end

function FightWorkCurrentHpChange:clearWork()
	return
end

return FightWorkCurrentHpChange
