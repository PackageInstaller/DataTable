-- chunkname: @modules/logic/fight/system/work/FightWorkCardHeatinit.lua

module("modules.logic.fight.system.work.FightWorkCardHeatinit", package.seeall)

local FightWorkCardHeatinit = class("FightWorkCardHeatinit", FightEffectBase)

function FightWorkCardHeatinit:onStart()
	self:onDone(true)
end

return FightWorkCardHeatinit
