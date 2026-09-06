-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/controller/PerfectRuleModeController.lua

module("logic.extensions.timelimitedchallenge.controller.PerfectRuleModeController", package.seeall)

local PerfectRuleModeController = class("PerfectRuleModeController", BaseController)

function PerfectRuleModeController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._dailyReset, self)
end

function PerfectRuleModeController:_dailyReset()
	PerfectRuleModeModel.instance:onReset()
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeDailyRresh)
end

function PerfectRuleModeController:handleGetInfo(msg)
	PerfectRuleModeModel.instance:onGetInfo(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleGainDailyPrize(msg)
	PerfectRuleModeModel.instance:onGainDailyPrize(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleBuyTime(msg)
	PerfectRuleModeModel.instance:onBuyTime(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleChooseMode(msg)
	PerfectRuleModeModel.instance:onChooseMode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleReChooseMode(msg)
	PerfectRuleModeModel.instance:onReChooseMode(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleStartFight(msg)
	PerfectRuleModeModel.instance:onStartFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleConfirmResult(msg)
	PerfectRuleModeModel.instance:onConfirmResult(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleGiveUpFight(msg)
	PerfectRuleModeModel.instance:onGiveUpFight(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:handleChallengeEnd(msg)
	PerfectRuleModeModel.instance:onChallengeEnd(msg)
	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeInfoUpdate)
end

function PerfectRuleModeController:openResultView(challengeId)
	local commonCfg = PerfectRuleModeConfig.instance:getCommonCfg(challengeId)

	UIStateManager.instance:push(commonCfg.resultview, challengeId)
end

function PerfectRuleModeController:sendPM_PerfectRuleFightGainProgressPrizeReq(challengeId, prizeId)
	self._challengeId = challengeId
	self._prizeId = prizeId

	PerfectRuleFightAgent.instance:sendPM_PerfectRuleFightGainProgressPrizeReq(challengeId, prizeId)
end

function PerfectRuleModeController:handleProgressUpdate()
	PerfectRuleModeModel.instance:updateRewardGeted(self._challengeId, self._prizeId)

	self._challengeId = nil
	self._prizeId = nil

	GlobalDispatcher:dispatch(GlobalNotify.PerfectRuleModeProgressUpdate)
end

PerfectRuleModeController.instance = PerfectRuleModeController.New()

return PerfectRuleModeController
