-- chunkname: @modules/logic/fight/system/work/FightWorkExitQTE.lua

module("modules.logic.fight.system.work.FightWorkExitQTE", package.seeall)

local FightWorkExitQTE = class("FightWorkExitQTE", FightWorkItem)
local WaitDuration = 1.5

function FightWorkExitQTE:onStart()
	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkSendEvent, FightEvent.QTE_BeforeExitQte)

	if not FightDataHelper.qteDataMgr:checkEnteredSecondStage() then
		local myVertin = FightGameMgr.entityMgr:getMyVertin()

		if myVertin then
			local timelineName = lua_fight_qte_const.configDict[5].value
			local fightStepData = FightStepData.New()

			fightStepData.actEffect = LuaUtil.emptyTable
			fightStepData.fromId = myVertin.id
			fightStepData.toId = FightEntityScene.EnemySideId

			local timelineWork = myVertin.skill:registTimelineWork(timelineName, fightStepData)

			flow:addWork(timelineWork)
		end
	end

	flow:addWork(WorkWaitSeconds.New(WaitDuration / FightModel.instance:getSpeed()))
	flow:addWork(FunctionWork.New(FightWorkEnterQTE.showEntityEffect))
	flow:registFinishCallback(self.onExitQteDone, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkExitQTE:onExitQteDone()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.QTE)
	ViewMgr.instance:closeView(ViewName.FightQteView)
	FightController.instance:dispatchEvent(FightEvent.QTE_AfterExitQte)
end

return FightWorkExitQTE
