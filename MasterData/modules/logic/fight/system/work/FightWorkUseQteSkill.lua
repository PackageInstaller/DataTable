-- chunkname: @modules/logic/fight/system/work/FightWorkUseQteSkill.lua

module("modules.logic.fight.system.work.FightWorkUseQteSkill", package.seeall)

local FightWorkUseQteSkill = class("FightWorkUseQteSkill", FightWorkItem)

function FightWorkUseQteSkill:onStart()
	local roundData = FightDataHelper.roundMgr:getRoundData()
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkSendEvent, FightEvent.QTE_BeforeUseQteSkill)

	local stepWorkList = FightStepBuilder.buildStepWorkList(roundData and roundData.fightStep)

	if stepWorkList then
		local i = 1

		while i <= #stepWorkList do
			local work = stepWorkList[i]

			i = i + 1

			flow:addWork(work)
		end
	end

	flow:addWork(WorkWaitSeconds.New(0.1 / FightModel.instance:getSpeed()))
	flow:addWork(FightWorkCompareDataAfterPlay.New())
	flow:registFinishCallback(self.onEnterQteDone, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkUseQteSkill:onEnterQteDone()
	FightController.instance:dispatchEvent(FightEvent.QTE_AfterUseQteSkill)
end

return FightWorkUseQteSkill
