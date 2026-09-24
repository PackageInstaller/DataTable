-- chunkname: @modules/logic/fight/system/work/FightWorkQTEPluginMaxChange385.lua

module("modules.logic.fight.system.work.FightWorkQTEPluginMaxChange385", package.seeall)

local FightWorkQTEPluginMaxChange385 = class("FightWorkQTEPluginMaxChange385", FightEffectBase)

function FightWorkQTEPluginMaxChange385:onStart()
	self:com_sendFightEvent(FightEvent.QTE_OnMaxChange, self.actEffectData.teamType)

	return self:onDone(true)
end

return FightWorkQTEPluginMaxChange385
