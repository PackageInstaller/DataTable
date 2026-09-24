-- chunkname: @modules/logic/fight/system/work/FightWorkTryEnterQte.lua

module("modules.logic.fight.system.work.FightWorkTryEnterQte", package.seeall)

local FightWorkTryEnterQte = class("FightWorkTryEnterQte", FightWorkItem)

function FightWorkTryEnterQte:onConstructor()
	return
end

function FightWorkTryEnterQte:onStart()
	local qteDataMgr = FightDataHelper.qteDataMgr
	local qteInfo = qteDataMgr:getQteInfo()

	if not qteInfo then
		return self:onDone(true)
	end

	if qteInfo:getStatus() == FightEnum.QTEStage.Normal then
		return self:onDone(true)
	end

	if qteInfo:getStatus() == FightEnum.QTEStage.QTE_SECOND then
		FightDataHelper.qteDataMgr:setEnteredSecondStage()
	end

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkSendEvent, FightEvent.QTE_BeforeEnterQte)
	flow:addWork(FunctionWork.New(self.enterFightQteState, self))

	local myVertin = FightGameMgr.entityMgr:getMyVertin()

	if myVertin then
		local timelineName = lua_fight_qte_const.configDict[4].value
		local fightStepData = FightStepData.New()

		fightStepData.actEffect = LuaUtil.emptyTable
		fightStepData.fromId = myVertin.id
		fightStepData.toId = FightEntityScene.EnemySideId

		local timelineWork = myVertin.skill:registTimelineWork(timelineName, fightStepData)

		flow:addWork(timelineWork)
	end

	flow:addWork(FunctionWork.New(FightWorkEnterQTE.hideEntityEffect))
	flow:registFinishCallback(self.onEnterQteDone, self)
	self:playWorkAndDone(flow, {})
end

function FightWorkTryEnterQte:enterFightQteState()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.QTE)
end

function FightWorkTryEnterQte:onEnterQteDone()
	ViewMgr.instance:openView(ViewName.FightQteView)
	FightController.instance:dispatchEvent(FightEvent.QTE_AfterEnterQte)
end

return FightWorkTryEnterQte
