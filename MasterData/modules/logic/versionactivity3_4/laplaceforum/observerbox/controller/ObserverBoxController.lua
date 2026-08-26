-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/observerbox/controller/ObserverBoxController.lua

module("modules.logic.versionactivity3_4.laplaceforum.observerbox.controller.ObserverBoxController", package.seeall)

local ObserverBoxController = class("ObserverBoxController", BaseController)

function ObserverBoxController:onInit()
	self:reInit()
end

function ObserverBoxController:reInit()
	self._hasGet = nil
end

function ObserverBoxController:onInitFinish()
	return
end

function ObserverBoxController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._refreshActInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._refreshActInfo, self)
end

function ObserverBoxController:_onDailyRefresh()
	self._hasGet = nil

	self:_refreshActInfo()
end

function ObserverBoxController:_refreshActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.LaplaceObserverBox]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ObserverBox
		})
		Activity226Rpc.instance:sendGet226InfoRequest(VersionActivity3_4Enum.ActivityId.LaplaceObserverBox)
	end

	self._hasGet = couldGet
end

ObserverBoxController.instance = ObserverBoxController.New()

return ObserverBoxController
