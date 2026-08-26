-- chunkname: @modules/logic/fight/system/work/FightWorkRequestAutoFight.lua

module("modules.logic.fight.system.work.FightWorkRequestAutoFight", package.seeall)

local FightWorkRequestAutoFight = class("FightWorkRequestAutoFight", FightWorkItem)

function FightWorkRequestAutoFight:onConstructor()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.AutoCardPlaying)
end

function FightWorkRequestAutoFight:onStart()
	self:com_registMsg(FightMsgId.AutoRoundReply, self.onAutoRoundReply)
	self:com_registMsg(FightMsgId.AutoRoundReplyFail, self.onAutoRoundReplyFail)
	self:com_registMsg(FightMsgId.UseClothSkillReplyFail, self.onUseClothSkillReplyFail)
	FightRpc.instance:sendAutoRoundRequest(FightDataHelper.operationDataMgr:getOpList())
	self:cancelFightWorkSafeTimer()
end

function FightWorkRequestAutoFight:onAutoRoundReply(msg)
	if msg:HasField("clothSkill") ~= 0 then
		local clothSkill = msg.clothSkill

		if clothSkill.skillId ~= 0 then
			FightRpc.instance:sendUseClothSkillRequest(clothSkill.skillId, clothSkill.fromId, clothSkill.toId, clothSkill.type)

			return
		end
	end

	local autoPlayCardList = {}

	for _, oper in ipairs(msg.opers) do
		local beginRoundOp = FightOperationItemData.New()

		beginRoundOp:setByProto(oper)
		table.insert(autoPlayCardList, beginRoundOp)
	end

	local flow = self:com_registFlowSequence()

	flow:addWork(FightWorkAutoSwitchDeviceSkill.New(msg.devicesOpers))

	if #autoPlayCardList > 0 then
		flow:registWork(FightWorkCheckUseAiJiAoQte)
		flow:registWork(FightWorkClearAiJiAoQteTempData)
		flow:registWork(FightAutoBindContractWork)
		flow:registWork(FightAutoDetectUpgradeWork)
		flow:registWork(FightAutoMeiLeiErExRoundWork)
		flow:registWork(FightAutoSelectCrystalWork)
		flow:registWork(FightSSWLAutoSelectCardWork)
		flow:registWork(FightWorkSelectBattleEvent)
		flow:registWork(FightWorkWaitAllOperateDone)

		if FightGameMgr.skipPerformance then
			for i, beginRoundOp in ipairs(autoPlayCardList) do
				FightDataHelper.operationDataMgr:addOperation(beginRoundOp)
			end
		else
			for i, beginRoundOp in ipairs(autoPlayCardList) do
				if beginRoundOp:isAssistBossPlayCard() then
					flow:addWork(WorkWaitSeconds.New(0.3))
					flow:addWork(FightAutoPlayAssistBossCardWork.New(beginRoundOp))
				elseif beginRoundOp:isSeason2ChangeHero() then
					-- block empty
				elseif beginRoundOp:isPlayerFinisherSkill() then
					flow:addWork(WorkWaitSeconds.New(0.1))
					flow:addWork(FightWorkAutoPlayerFinisherSkill.New(beginRoundOp))
				elseif beginRoundOp:isBloodPoolSkill() then
					logError("自动打牌  血池牌 todo")
				elseif beginRoundOp:isPlayCard() then
					flow:addWork(WorkWaitSeconds.New(0.01))
					flow:addWork(FightAutoPlayCardWork.New(beginRoundOp))
				end
			end
		end
	end

	flow:registWork(FightWorkSendOperate2Server)
	self:playWorkAndDone(flow)
end

function FightWorkRequestAutoFight:onAutoRoundReplyFail()
	self:onDone(true)
end

function FightWorkRequestAutoFight:onUseClothSkillReplyFail()
	self:onDone(true)
end

function FightWorkRequestAutoFight:onDestructor()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.AutoCardPlaying)
end

return FightWorkRequestAutoFight
