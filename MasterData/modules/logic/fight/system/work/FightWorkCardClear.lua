-- chunkname: @modules/logic/fight/system/work/FightWorkCardClear.lua

module("modules.logic.fight.system.work.FightWorkCardClear", package.seeall)

local FightWorkCardClear = class("FightWorkCardClear", FightEffectBase)

function FightWorkCardClear:onStart()
	self:com_sendFightEvent(FightEvent.CardClear)
	self:onDone(true)
end

return FightWorkCardClear
