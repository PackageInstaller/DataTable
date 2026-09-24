-- chunkname: @modules/logic/fight/system/work/FightWorkQTETotalDamageUpdate388.lua

module("modules.logic.fight.system.work.FightWorkQTETotalDamageUpdate388", package.seeall)

local FightWorkQTETotalDamageUpdate388 = class("FightWorkQTETotalDamageUpdate388", FightEffectBase)

function FightWorkQTETotalDamageUpdate388:onStart()
	FightDataHelper.qteDataMgr:setQteTotal(self.actEffectData.effectNum)
	FightController.instance:dispatchEvent(FightEvent.QTE_TotalDamageChange, self.actEffectData.effectNum)

	return self:onDone(true)
end

return FightWorkQTETotalDamageUpdate388
