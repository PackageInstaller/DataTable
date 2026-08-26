-- chunkname: @modules/logic/fight/system/work/FightWorkMaxHpChange.lua

module("modules.logic.fight.system.work.FightWorkMaxHpChange", package.seeall)

local FightWorkMaxHpChange = class("FightWorkMaxHpChange", FightEffectBase)

function FightWorkMaxHpChange:onStart()
	self:_startChangeMaxHp()
end

function FightWorkMaxHpChange:beforePlayEffectData()
	self._entityId = self.actEffectData.targetId
	self._entityMO = FightDataHelper.entityMgr:getById(self._entityId)
	self._oldValue = self._entityMO and self._entityMO.attrMO.hp
end

function FightWorkMaxHpChange:_startChangeMaxHp()
	local entity = FightHelper.getEntity(self._entityId)

	if not entity then
		self:onDone(true)

		return
	end

	if not self._entityMO then
		self:onDone(true)

		return
	end

	self._newValue = self._entityMO and self._entityMO.attrMO.hp

	FightController.instance:dispatchEvent(FightEvent.OnMaxHpChange, self.actEffectData.targetId, self._oldValue, self._newValue)
	self:_onDone()
end

function FightWorkMaxHpChange:_onDone()
	self:clearWork()
	self:onDone(true)
end

function FightWorkMaxHpChange:clearWork()
	return
end

return FightWorkMaxHpChange
