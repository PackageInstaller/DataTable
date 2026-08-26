-- chunkname: @modules/logic/fight/system/work/FightWorkColdSaturdayHurt336Parallel.lua

module("modules.logic.fight.system.work.FightWorkColdSaturdayHurt336Parallel", package.seeall)

local FightWorkColdSaturdayHurt336Parallel = class("FightWorkColdSaturdayHurt336Parallel", FightStepEffectFlow)

function FightWorkColdSaturdayHurt336Parallel:onStart()
	self:onDone(true)
end

return FightWorkColdSaturdayHurt336Parallel
