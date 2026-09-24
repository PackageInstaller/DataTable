-- chunkname: @modules/logic/fight/system/work/FightWorkPlay2QteOperate.lua

module("modules.logic.fight.system.work.FightWorkPlay2QteOperate", package.seeall)

local FightWorkPlay2QteOperate = class("FightWorkPlay2QteOperate", FightWorkItem)

function FightWorkPlay2QteOperate:onConstructor()
	return
end

function FightWorkPlay2QteOperate:dispatchAfterEffectWorkDoneEvent()
	FightController.instance:dispatchEvent(FightEvent.AfterEffectWorkDone)
end

function FightWorkPlay2QteOperate:onStart()
	if FightScene.isLowMemory then
		FightHelper.clearNoUseEffect()
	end

	FightGameMgr.checkCrashMgr:play2Operate()
	FightViewPartVisible.set(true, true, true, false, false)
	FightDataHelper.stageMgr:setStage(FightStageMgr.StageType.Operate)

	local flow = self:com_registFlowSequence()

	flow:addWork(FunctionWork.New(self.dispatchAfterEffectWorkDoneEvent, self))

	if FightDataHelper.stateMgr.isReplay then
		self:playWorkAndDone(flow)

		return
	end

	if FightDataHelper.fieldMgr:isDouQuQu() then
		self:playWorkAndDone(flow)

		return
	end

	if FightModel.instance:isFinish() then
		self:playWorkAndDone(flow)

		return
	end

	if FightDataHelper.stateMgr:getIsAuto() then
		flow:registWork(FightWorkRequestAutoFight)
	end

	self:playWorkAndDone(flow)
end

return FightWorkPlay2QteOperate
