-- chunkname: @modules/logic/fight/system/work/FightWorkDistributeCard.lua

module("modules.logic.fight.system.work.FightWorkDistributeCard", package.seeall)

local FightWorkDistributeCard = class("FightWorkDistributeCard", FightWorkItem)

function FightWorkDistributeCard:onConstructor(isEnterDistribute)
	self.isEnterDistribute = isEnterDistribute
end

function FightWorkDistributeCard:onStart()
	local roundData = FightDataHelper.roundMgr:getRoundData()

	if not roundData then
		self:onDone(false)

		return
	end

	self:cancelFightWorkSafeTimer()
	FightDataHelper.stageMgr:enterFightState(FightStageMgr.FightStateType.DistributeCard)
	FightController.instance:GuideFlowPauseAndContinue("OnGuideDistributePause", FightEvent.OnGuideDistributePause, FightEvent.OnGuideDistributeContinue, self._distrubute, self)
end

function FightWorkDistributeCard:_distrubute()
	FightViewPartVisible.set(false, true, false, false, false)
	FightController.instance:registerCallback(FightEvent.OnDistributeCards, self._done, self)

	local beforeCards = FightDataHelper.handCardMgr.beforeCards1
	local teamAcards = FightDataHelper.handCardMgr.teamACards1

	FightController.instance:dispatchEvent(FightEvent.DistributeCards, beforeCards, teamAcards, self.isEnterDistribute)
end

function FightWorkDistributeCard:_done()
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, self._done, self)
	self:onDone(true)
end

function FightWorkDistributeCard:clearWork()
	FightDataHelper.stageMgr:exitFightState(FightStageMgr.FightStateType.DistributeCard)
	FightController.instance:unregisterCallback(FightEvent.OnDistributeCards, self._done, self)
end

return FightWorkDistributeCard
