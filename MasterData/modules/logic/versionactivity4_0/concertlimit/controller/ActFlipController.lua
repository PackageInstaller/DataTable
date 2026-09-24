-- chunkname: @modules/logic/versionactivity4_0/concertlimit/controller/ActFlipController.lua

module("modules.logic.versionactivity4_0.concertlimit.controller.ActFlipController", package.seeall)

local ActFlipController = class("ActFlipController", BaseController)

function ActFlipController:onInit()
	self:reInit()
end

function ActFlipController:reInit()
	self._hasGet = nil
end

function ActFlipController:onInitFinish()
	return
end

function ActFlipController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._refreshActInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function ActFlipController:_onDailyRefresh()
	self._hasGet = nil

	self:_refreshActInfo()
end

function ActFlipController:_refreshActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity4_0Enum.ActivityId.ConcertActFlip]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ConcerActFlip
		})
		Activity246Rpc.instance:sendGet246InfoRequest(VersionActivity4_0Enum.ActivityId.ConcertActFlip)
	end

	self._hasGet = couldGet
end

function ActFlipController:openActFlipView()
	ViewMgr.instance:openView(ViewName.ActFlipView)
end

function ActFlipController:openActFlipRewardTipsView()
	ViewMgr.instance:openView(ViewName.ActFlipRewardTipsView)
end

ActFlipController.instance = ActFlipController.New()

return ActFlipController
