-- chunkname: @modules/logic/fight/system/work/FightWorkCardHeatValueChange.lua

module("modules.logic.fight.system.work.FightWorkCardHeatValueChange", package.seeall)

local FightWorkCardHeatValueChange = class("FightWorkCardHeatValueChange", FightEffectBase)

function FightWorkCardHeatValueChange:onStart()
	self:com_sendFightEvent(FightEvent.RefreshCardHeatShow)
	self:onDone(true)
end

return FightWorkCardHeatValueChange
