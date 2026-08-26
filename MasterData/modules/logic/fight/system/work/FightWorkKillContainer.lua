-- chunkname: @modules/logic/fight/system/work/FightWorkKillContainer.lua

module("modules.logic.fight.system.work.FightWorkKillContainer", package.seeall)

local FightWorkKillContainer = class("FightWorkKillContainer", FightStepEffectFlow)

function FightWorkKillContainer:onStart()
	self:playAdjacentParallelEffect(nil, true)
end

function FightWorkKillContainer:clearWork()
	return
end

return FightWorkKillContainer
