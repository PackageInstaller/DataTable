-- chunkname: @modules/logic/fight/system/work/FightWorkQTEPluginUpdate386.lua

module("modules.logic.fight.system.work.FightWorkQTEPluginUpdate386", package.seeall)

local FightWorkQTEPluginUpdate386 = class("FightWorkQTEPluginUpdate386", FightEffectBase)

function FightWorkQTEPluginUpdate386:onStart()
	self:com_sendFightEvent(FightEvent.QTE_OnUpdate, self.actEffectData.teamType)

	return self:onDone(true)
end

return FightWorkQTEPluginUpdate386
