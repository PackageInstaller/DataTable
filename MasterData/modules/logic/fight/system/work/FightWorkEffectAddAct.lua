-- chunkname: @modules/logic/fight/system/work/FightWorkEffectAddAct.lua

module("modules.logic.fight.system.work.FightWorkEffectAddAct", package.seeall)

local FightWorkEffectAddAct = class("FightWorkEffectAddAct", FightEffectBase)

function FightWorkEffectAddAct:onStart()
	self:onDone(true)
end

return FightWorkEffectAddAct
