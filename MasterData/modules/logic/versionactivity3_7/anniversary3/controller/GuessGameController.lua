-- chunkname: @modules/logic/versionactivity3_7/anniversary3/controller/GuessGameController.lua

module("modules.logic.versionactivity3_7.anniversary3.controller.GuessGameController", package.seeall)

local GuessGameController = class("GuessGameController", BaseController)

function GuessGameController:onInit()
	self:reInit()
end

function GuessGameController:reInit()
	self._hasGet = nil
end

function GuessGameController:onInitFinish()
	return
end

function GuessGameController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function GuessGameController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function GuessGameController:onRefreshActivity()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3GuessGame
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		Activity234Rpc.instance:sendGet234InfoRequest(actId)
	end

	self._hasGet = couldGet
end

function GuessGameController:openGuessGamePlayView()
	ViewMgr.instance:openView(ViewName.GuessGamePlayView)
end

function GuessGameController:openGuessGamePlayGiftGuessView(param)
	ViewMgr.instance:openView(ViewName.GuessGamePlayGiftGuessView, param)
end

function GuessGameController:openGuessGamePlayRoundTipsView(param)
	ViewMgr.instance:openView(ViewName.GuessGamePlayRoundTipsView, param)
end

function GuessGameController:openGuessGamePlayResultView(param)
	ViewMgr.instance:openView(ViewName.GuessGamePlayResultView, param)
end

function GuessGameController:exitGame()
	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayView)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayGiftGuessView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayGiftGuessView)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayRoundTipsView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayRoundTipsView)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayResultView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayResultView)
	end
end

function GuessGameController:restartGame()
	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayView, true)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayGiftGuessView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayGiftGuessView, true)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayRoundTipsView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayRoundTipsView, true)
	end

	if ViewMgr.instance:isOpen(ViewName.GuessGamePlayResultView) then
		ViewMgr.instance:closeView(ViewName.GuessGamePlayResultView, true)
	end

	TaskDispatcher.runDelay(self.openGuessGamePlayView, self, 0.1)
end

GuessGameController.instance = GuessGameController.New()

return GuessGameController
