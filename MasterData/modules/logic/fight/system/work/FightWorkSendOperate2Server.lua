-- chunkname: @modules/logic/fight/system/work/FightWorkSendOperate2Server.lua

module("modules.logic.fight.system.work.FightWorkSendOperate2Server", package.seeall)

local FightWorkSendOperate2Server = class("FightWorkSendOperate2Server", FightWorkItem)

function FightWorkSendOperate2Server:onConstructor()
	return
end

function FightWorkSendOperate2Server:onStart()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.SendOperation2Server)

	local flow = self:com_registFlowSequence()

	flow:registWork(FightWorkForceUseCardByConfig)

	local cardAniWork = FightMsgMgr.sendMsg(FightMsgId.RegistCardEndAniFlow)

	if cardAniWork then
		local parallel = flow:registWork(FightWorkFlowParallel)

		parallel:addWork(cardAniWork)

		local cardSkin = FightCardDataHelper.getCardSkin()

		if cardSkin == 672802 then
			parallel:registWork(FightWorkSkinDownEffectExit672802)
		elseif cardSkin == 672803 then
			parallel:registWork(FightWorkSkinDownEffectExit672803)
		end
	end

	flow:addWork(self:meiLeierExRoundWork())
	flow:registFinishCallback(self.onFinish, self)
	self:playWorkAndDone(flow)
end

function FightWorkSendOperate2Server:onFinish()
	local cards = FightDataHelper.handCardMgr.handCard

	FightDataUtil.coverData(cards, FightLocalDataMgr.instance.handCardMgr:getHandCard())
	FightController.instance:dispatchEvent(FightEvent.SetBlockCardOperate, false)
	FightController.instance:dispatchEvent(FightEvent.BeforeSendOperate2ServerAnimDone)

	if FightDataHelper.stageMgr:inFightState(FightStageMgr.FightStateType.DouQuQu) then
		return
	end

	FightRpc.instance:sendBeginRoundRequest(FightDataHelper.operationDataMgr:getOpList())

	local version = FightModel.instance:getVersion()

	if version >= 1 then
		FightController.instance:dispatchEvent(FightEvent.ShowSimulateClientUsedCard)

		return
	end

	FightPlayCardModel.instance:updateClientOps()
	FightController.instance:dispatchEvent(FightEvent.UpdateWaitingArea)
end

function FightWorkSendOperate2Server:meiLeierExRoundWork()
	if not FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] then
		if FightDataHelper.fieldMgr.param[FightParamData.ParamKey.CUR_EXTRA_ROUND_FLAG] == 1 then
			local fightStepData = FightStepData.New(FightDef_pb.FightStep())

			fightStepData.fromId = "0"
			fightStepData.toId = "0"
			fightStepData.actId = 0
			fightStepData.actType = FightEnum.ActType.SKILL
			fightStepData.stepUid = FightTLEventEntityVisible.latestStepUid or 0

			FightController.instance:dispatchEvent(FightEvent.ShowSimulateClientUsedCard)

			return (FightGameMgr.entityMgr:getMyVertin().skill:registTimelineWork("xiaoruiannong_314601_special2", fightStepData))
		end
	end
end

return FightWorkSendOperate2Server
