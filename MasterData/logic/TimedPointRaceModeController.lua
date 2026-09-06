-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/TimedPointRaceModeController.lua

module("logic.extensions.timelimitedchallenge.controller.TimedPointRaceModeController", package.seeall)

local TimedPointRaceModeController = class("TimedPointRaceModeController", BaseController)

function TimedPointRaceModeController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function TimedPointRaceModeController:_dailyReset()
	TimedPointRaceModeModel.instance:onReset()
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeDailyFresh)
end

function TimedPointRaceModeController:handleGetInfo(msg)
	TimedPointRaceModeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleBossChallenge(msg)
	TimedPointRaceModeModel.instance:onBossChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleBuffChallenge(msg)
	TimedPointRaceModeModel.instance:onBuffChallenge(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleBuyBossChallengeTime(msg)
	TimedPointRaceModeModel.instance:onBuyBossChallengeTime(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleBuyBuffChallengeTime(msg)
	TimedPointRaceModeModel.instance:onBuyBuffChallengeTime(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleGainPrize(msg)
	TimedPointRaceModeModel.instance:onGainPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:sendGetTotalRankInfo(challengeId, root, leaf)
	self.tempTotalRoot = root
	self.tempTotalLeaf = leaf

	TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreViewTotalRankReq(challengeId)
end

function TimedPointRaceModeController:handleGainTotalRankInfo(msg)
	RankModel.instance:_onTLCRankInfoRes(msg, self.tempTotalRoot, self.tempTotalLeaf)
end

function TimedPointRaceModeController:sendGetDailyRankInfo(challengeId, root, leaf)
	self.tempDailyRoot = root
	self.tempDailyLeaf = leaf

	TimedChallengeRankingScoreAgent.instance:sendPM_TimedChallengeRankingScoreViewDailyRankReq(challengeId)
end

function TimedPointRaceModeController:handleGainDailyRankInfo(msg)
	RankModel.instance:_onTLCRankInfoRes(msg, self.tempDailyRoot, self.tempDailyLeaf)
end

function TimedPointRaceModeController:handleNotifyBossBattleSuc(msg)
	TimedPointRaceModeModel.instance:onBossBattleSuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:handleNotifyBuffBattleSuc(msg)
	TimedPointRaceModeModel.instance:onBuffBattleSuc(msg)
	GlobalDispatcher:dispatch(GlobalNotify.TimedPointRaceModeInfoUpdate)
end

function TimedPointRaceModeController:onBattleEnd(challengeId, buffChallengeCfg)
	BattleFacade.instance:registerResultHandler(nil, nil)

	local commonCfg = TimedPointRaceModeConfig.instance:getCommonCfg(challengeId)

	UIStateManager.instance:push(commonCfg.settlementView, challengeId, buffChallengeCfg)

	return true
end

TimedPointRaceModeController.instance = TimedPointRaceModeController.New()

return TimedPointRaceModeController
