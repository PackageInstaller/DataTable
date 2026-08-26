-- chunkname: @modules/logic/fight/mgr/FightOperateMgr.lua

module("modules.logic.fight.mgr.FightOperateMgr", package.seeall)

local FightOperateMgr = class("FightOperateMgr", FightBaseClass)

function FightOperateMgr:onConstructor()
	self.workComp = self:addComponent(FightWorkComponent)

	self:com_registFightEvent(FightEvent.StageChanged, self.onStageChanged)
end

function FightOperateMgr:isOperating()
	return self.workComp:hasAliveWork()
end

function FightOperateMgr:onStageChanged(curStage, preStage)
	if curStage == FightStageMgr.StageType.Play then
		self.workComp:disposeAllWork()
		self:com_sendFightEvent(FightEvent.OnOperateMgrDisposeAllWork)
		FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.SendOperation2Server)
	end
end

function FightOperateMgr:invokeCancelPlayerOperate()
	FightRpc.instance:sendResetRoundRequest()
	AudioMgr.instance:trigger(AudioEnum.UI.Play_UI_FightResetCard)
	FightAudioMgr.instance:stopAllCardAudio()
end

function FightOperateMgr:cancelAllOperate()
	self.workComp:disposeAllWork()
	self:com_sendFightEvent(FightEvent.OnOperateMgrDisposeAllWork)
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.SendOperation2Server)
end

function FightOperateMgr:beforeOperate()
	FightMsgMgr.sendMsg(FightMsgId.BeforeOperate)
end

function FightOperateMgr:afterOperate()
	FightMsgMgr.sendMsg(FightMsgId.AfterOperate)
end

function FightOperateMgr:newOperateFlow()
	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkFunction, self.beforeOperate, self)
	flow:registFinishCallback(self.afterOperate, self)

	return flow
end

function FightOperateMgr:playHandCard(index, toId, discardedIndex, selectedSkillId, cardParam1)
	local flow = self:newOperateFlow()

	flow:registWork(FightWorkPlayHandCard, index, toId, discardedIndex, selectedSkillId, cardParam1)
	flow:start()
end

function FightOperateMgr:sendOperate2Server()
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		if isDebugBuild then
			logError("sendOperate2Server ing, return ")
		end

		return
	end

	local flow = self.workComp:registWork(FightWorkFlowSequence)

	flow:registWork(FightWorkSendOperate2Server)
	flow:start()
end

function FightOperateMgr:requestAutoFight()
	if FightDataHelper.stageMgr:getCurStage() ~= FightStageMgr.StageType.Operate then
		return
	end

	if FightDataHelper.stateMgr.isReplay then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.AutoCardPlaying) then
		return
	end

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.SendOperation2Server) then
		return
	end

	local work = self.workComp:registWork(FightWorkRequestAutoFight)

	work:start()
end

function FightOperateMgr:onDestructor()
	return
end

return FightOperateMgr
