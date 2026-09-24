-- chunkname: @modules/logic/fight/system/work/FightWorkEntityStatusUpdate389.lua

module("modules.logic.fight.system.work.FightWorkEntityStatusUpdate389", package.seeall)

local FightWorkEntityStatusUpdate389 = class("FightWorkEntityStatusUpdate389", FightEffectBase)

function FightWorkEntityStatusUpdate389:onStart()
	local entity = FightHelper.getEntity(self.actEffectData.targetId)

	if not entity then
		return self:onDone(true)
	end

	local status = self.actEffectData.effectNum

	self:com_sendFightEvent(FightEvent.OnEntityDyingChange, self.actEffectData.targetId, status)

	return self:onDone(true)
end

return FightWorkEntityStatusUpdate389
