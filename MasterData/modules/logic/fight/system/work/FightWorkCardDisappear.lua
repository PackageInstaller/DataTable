-- chunkname: @modules/logic/fight/system/work/FightWorkCardDisappear.lua

module("modules.logic.fight.system.work.FightWorkCardDisappear", package.seeall)

local FightWorkCardDisappear = class("FightWorkCardDisappear", FightEffectBase)

function FightWorkCardDisappear:onStart(context)
	FightController.instance:dispatchEvent(FightEvent.CardDisappear)
	self:onDone(true)
end

return FightWorkCardDisappear
