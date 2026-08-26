-- chunkname: @modules/logic/fight/system/work/FightWorkEmitterExtraDemage367.lua

module("modules.logic.fight.system.work.FightWorkEmitterExtraDemage367", package.seeall)

local FightWorkEmitterExtraDemage367 = class("FightWorkEmitterExtraDemage367", FightEffectBase)

function FightWorkEmitterExtraDemage367:onStart()
	return self:onDone(true)
end

return FightWorkEmitterExtraDemage367
