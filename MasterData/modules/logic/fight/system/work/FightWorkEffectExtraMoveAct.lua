-- chunkname: @modules/logic/fight/system/work/FightWorkEffectExtraMoveAct.lua

module("modules.logic.fight.system.work.FightWorkEffectExtraMoveAct", package.seeall)

local FightWorkEffectExtraMoveAct = class("FightWorkEffectExtraMoveAct", FightEffectBase)

function FightWorkEffectExtraMoveAct:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnEffectExtraMoveAct)
	self:onDone(true)
end

return FightWorkEffectExtraMoveAct
