-- chunkname: @modules/logic/fight/system/work/FightWorkNuoDiKaRandomAttackNum349.lua

module("modules.logic.fight.system.work.FightWorkNuoDiKaRandomAttackNum349", package.seeall)

local FightWorkNuoDiKaRandomAttackNum349 = class("FightWorkNuoDiKaRandomAttackNum349", FightEffectBase)

function FightWorkNuoDiKaRandomAttackNum349:onStart()
	local actEffectData = self.actEffectData

	self:com_sendFightEvent(FightEvent.Blood2BengFa, actEffectData)

	if (actEffectData.effectNum1 == 0 or nil) and false then
		self:com_registTimer(self.finishWork, 0.5)
	else
		self:onDone(true)
	end
end

return FightWorkNuoDiKaRandomAttackNum349
