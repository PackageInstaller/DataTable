-- chunkname: @modules/logic/fight/system/work/FightWorkSkillWeightSelectContainer.lua

module("modules.logic.fight.system.work.FightWorkSkillWeightSelectContainer", package.seeall)

local FightWorkSkillWeightSelectContainer = class("FightWorkSkillWeightSelectContainer", FightStepEffectFlow)

function FightWorkSkillWeightSelectContainer:onStart()
	self:playAdjacentParallelEffect(nil, true)
end

function FightWorkSkillWeightSelectContainer:clearWork()
	return
end

return FightWorkSkillWeightSelectContainer
