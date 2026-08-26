-- chunkname: @modules/logic/fight/system/work/FightWorkEffectPowerMaxAdd.lua

module("modules.logic.fight.system.work.FightWorkEffectPowerMaxAdd", package.seeall)

local FightWorkEffectPowerMaxAdd = class("FightWorkEffectPowerMaxAdd", FightEffectBase)

function FightWorkEffectPowerMaxAdd:onStart()
	local entityId = self.actEffectData.targetId
	local entity = FightHelper.getEntity(entityId)

	if not entity then
		self:onDone(true)

		return
	end

	local entity_mo = entity:getMO()

	if not entity_mo then
		self:onDone(true)

		return
	end

	local powerId = self.actEffectData.configEffect
	local powerData = entity_mo:getPowerInfo(powerId)

	if powerData then
		FightController.instance:dispatchEvent(FightEvent.PowerMaxChange, entityId, powerId, self.actEffectData.effectNum)
	end

	self:onDone(true)
end

function FightWorkEffectPowerMaxAdd:clearWork()
	return
end

return FightWorkEffectPowerMaxAdd
