-- chunkname: @modules/logic/fight/system/work/FightWorkEnterFightDeal.lua

module("modules.logic.fight.system.work.FightWorkEnterFightDeal", package.seeall)

local FightWorkEnterFightDeal = class("FightWorkEnterFightDeal", FightEffectBase)

function FightWorkEnterFightDeal:onStart()
	local version = FightModel.instance:getVersion()

	if version < 4 then
		self:onDone(true)

		return
	end

	local flow = self:com_registWorkDoneFlowSequence()

	flow:registWork(FightWorkDistributeCard, true)
	flow:registWork(FightWorkFunction, self._afterDistribute, self)
	flow:start()
end

function FightWorkEnterFightDeal:_afterDistribute()
	return
end

function FightWorkEnterFightDeal:clearWork()
	return
end

return FightWorkEnterFightDeal
