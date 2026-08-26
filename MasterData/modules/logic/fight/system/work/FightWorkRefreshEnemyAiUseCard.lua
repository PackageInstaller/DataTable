-- chunkname: @modules/logic/fight/system/work/FightWorkRefreshEnemyAiUseCard.lua

module("modules.logic.fight.system.work.FightWorkRefreshEnemyAiUseCard", package.seeall)

local FightWorkRefreshEnemyAiUseCard = class("FightWorkRefreshEnemyAiUseCard", FightWorkItem)

function FightWorkRefreshEnemyAiUseCard:onStart()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		self:onDone(true)

		return
	end

	local flow = self:com_registFlowSequence()

	FightMsgMgr.sendMsg(FightMsgId.EntrustFightWork, flow)

	local _, workList = FightMsgMgr.sendMsg(FightMsgId.DiscardUnUsedEnemyAiCard)

	if workList then
		local parallel = flow:registWork(FightWorkFlowParallel)

		for i, work in ipairs(workList) do
			parallel:addWork(work)
		end
	end

	flow:registWork(FightWorkFunction, function()
		local aiUseCardsDic = roundData.entityAiUseCards
		local entityDataDic = FightDataHelper.entityMgr.entityDataDic

		for entityId, entityData in pairs(entityDataDic) do
			local exData = FightDataHelper.entityExMgr:getById(entityId)

			if not aiUseCardsDic[entityId] then
				FightDataUtil.coverData(aiUseCardsDic[entityId], exData.aiUseCardList)
			end
		end
	end)
	flow:registWork(FightWorkSendMsg, FightMsgId.RefreshEnemyAiUseCard)
	flow:start()
	self:onDone(true)
end

return FightWorkRefreshEnemyAiUseCard
