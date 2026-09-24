-- chunkname: @modules/logic/fight/system/work/FightWorkQTEPluginCreate384.lua

module("modules.logic.fight.system.work.FightWorkQTEPluginCreate384", package.seeall)

local FightWorkQTEPluginCreate384 = class("FightWorkQTEPluginCreate384", FightEffectBase)

function FightWorkQTEPluginCreate384:onStart()
	self:com_sendFightEvent(FightEvent.QTE_OnCreate, self.actEffectData.teamType)

	return self:onDone(true)
end

return FightWorkQTEPluginCreate384
