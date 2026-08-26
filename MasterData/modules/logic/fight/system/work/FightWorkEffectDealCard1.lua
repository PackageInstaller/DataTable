-- chunkname: @modules/logic/fight/system/work/FightWorkEffectDealCard1.lua

module("modules.logic.fight.system.work.FightWorkEffectDealCard1", package.seeall)

local FightWorkEffectDealCard1 = class("FightWorkEffectDealCard1", FightEffectBase)

function FightWorkEffectDealCard1:onStart()
	local version = FightModel.instance:getVersion()

	if version < 4 then
		self:onDone(true)

		return
	end

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(FightWorkDistributeCard)
	flow:registWork(FightWorkFunction, self._afterDistribute, self)
	flow:start()
end

function FightWorkEffectDealCard1:_afterDistribute()
	return
end

function FightWorkEffectDealCard1:clearWork()
	return
end

return FightWorkEffectDealCard1
