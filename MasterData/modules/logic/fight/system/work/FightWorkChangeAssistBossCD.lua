-- chunkname: @modules/logic/fight/system/work/FightWorkChangeAssistBossCD.lua

module("modules.logic.fight.system.work.FightWorkChangeAssistBossCD", package.seeall)

local FightWorkChangeAssistBossCD = class("FightWorkChangeAssistBossCD", FightEffectBase)

function FightWorkChangeAssistBossCD:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnAssistBossCDChange)
	self:onDone(true)
end

function FightWorkChangeAssistBossCD:clearWork()
	return
end

return FightWorkChangeAssistBossCD
