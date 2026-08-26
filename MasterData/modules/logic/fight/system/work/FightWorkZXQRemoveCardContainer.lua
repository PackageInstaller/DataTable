-- chunkname: @modules/logic/fight/system/work/FightWorkZXQRemoveCardContainer.lua

module("modules.logic.fight.system.work.FightWorkZXQRemoveCardContainer", package.seeall)

local FightWorkZXQRemoveCardContainer = class("FightWorkZXQRemoveCardContainer", FightStepEffectFlow)

function FightWorkZXQRemoveCardContainer:onStart()
	self:playAdjacentSequenceEffect(nil, true)
end

function FightWorkZXQRemoveCardContainer:clearWork()
	return
end

return FightWorkZXQRemoveCardContainer
