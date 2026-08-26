-- chunkname: @modules/logic/fight/system/work/FightWorkBuffDelReason352.lua

module("modules.logic.fight.system.work.FightWorkBuffDelReason352", package.seeall)

local FightWorkBuffDelReason352 = class("FightWorkBuffDelReason352", FightEffectBase)

function FightWorkBuffDelReason352:onStart()
	local targetId = self.actEffectData.targetId
	local buffUid = self.actEffectData.reserveId
	local reason = self.actEffectData.effectNum

	FightController.instance:dispatchEvent(FightEvent.OnPushBuffDeleteReason, targetId, buffUid, reason)

	return self:onDone(true)
end

return FightWorkBuffDelReason352
