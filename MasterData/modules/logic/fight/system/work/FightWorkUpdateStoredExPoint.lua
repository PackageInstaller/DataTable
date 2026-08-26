-- chunkname: @modules/logic/fight/system/work/FightWorkUpdateStoredExPoint.lua

module("modules.logic.fight.system.work.FightWorkUpdateStoredExPoint", package.seeall)

local FightWorkUpdateStoredExPoint = class("FightWorkUpdateStoredExPoint", FightEffectBase)

function FightWorkUpdateStoredExPoint:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO:getStoredExPoint()
end

function FightWorkUpdateStoredExPoint:onStart()
	local targetId = self.actEffectData.targetId
	local entityMo = FightDataHelper.entityMgr:getById(targetId)

	if not entityMo then
		self:onDone(true)

		return
	end

	self._newValue = self._entityMO and self._entityMO:getStoredExPoint()

	FightController.instance:dispatchEvent(FightEvent.OnStoreExPointChange, self._entityId, self._oldValue)
	self:onDone(true)
end

return FightWorkUpdateStoredExPoint
