-- chunkname: @modules/logic/versionactivity4_0/concertlimit/controller/MusicGameController.lua

module("modules.logic.versionactivity4_0.concertlimit.controller.MusicGameController", package.seeall)

local MusicGameController = class("MusicGameController", BaseController)

function MusicGameController:onInit()
	self:reInit()
end

function MusicGameController:reInit()
	self._hasGet = nil
end

function MusicGameController:onInitFinish()
	return
end

function MusicGameController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function MusicGameController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function MusicGameController:onRefreshActivity()
	local actId = VersionActivity4_0Enum.ActivityId.ConcertMusicGame
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

function MusicGameController:openMusicGameEnterView()
	ViewMgr.instance:openView(ViewName.MusicGameEnterView)
end

function MusicGameController:openMusicGameMainView()
	ViewMgr.instance:openView(ViewName.MusicGameMainView)
end

function MusicGameController:openMusicGameResultView(score)
	ViewMgr.instance:openView(ViewName.MusicGameResultView, score)
end

function MusicGameController:exitGame()
	if ViewMgr.instance:isOpen(ViewName.MusicGameMainView) then
		ViewMgr.instance:closeView(ViewName.MusicGameMainView)
	end

	if ViewMgr.instance:isOpen(ViewName.MusicGameResultView) then
		ViewMgr.instance:closeView(ViewName.MusicGameResultView)
	end

	MusicGameModel.instance:clearGameData()
end

function MusicGameController:restartGame()
	if ViewMgr.instance:isOpen(ViewName.MusicGameResultView) then
		ViewMgr.instance:closeView(ViewName.MusicGameResultView)
	end

	MusicGameModel.instance:resetBlockMap()
	self:openMusicGameMainView()
end

MusicGameController.instance = MusicGameController.New()

return MusicGameController
