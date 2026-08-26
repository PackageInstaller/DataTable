-- chunkname: @modules/logic/fight/system/work/FightWorkEffectRoundEnd.lua

module("modules.logic.fight.system.work.FightWorkEffectRoundEnd", package.seeall)

local FightWorkEffectRoundEnd = class("FightWorkEffectRoundEnd", FightEffectBase)

function FightWorkEffectRoundEnd:onStart()
	FightController.instance:dispatchEvent(FightEvent.OnMySideRoundEnd)
	self:onDone(true)
end

return FightWorkEffectRoundEnd
