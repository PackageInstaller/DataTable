-- chunkname: @modules/logic/versionactivity3_7/anniversary3/controller/Anniversary3ActBpController.lua

module("modules.logic.versionactivity3_7.anniversary3.controller.Anniversary3ActBpController", package.seeall)

local Anniversary3ActBpController = class("Anniversary3ActBpController", BaseController)

function Anniversary3ActBpController:onInit()
	self:reInit()
end

function Anniversary3ActBpController:reInit()
	self._hasGet = nil
end

function Anniversary3ActBpController:onInitFinish()
	return
end

function Anniversary3ActBpController:addConstEvents()
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function Anniversary3ActBpController:again‌RequestActivity()
	self._hasGet = nil

	self:onRefreshActivity()
end

function Anniversary3ActBpController:_onDailyRefresh()
	self._hasGet = nil

	self:onRefreshActivity()
end

function Anniversary3ActBpController:onRefreshActivity()
	local actId = VersionActivity3_7Enum.ActivityId.Anniversary3ActBp
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.ActBp
		})
		Activity233Rpc.instance:sendGetAct233BpInfoRequest(true, actId)
	end

	self._hasGet = couldGet
end

function Anniversary3ActBpController:showCommonPropView(rewards, hasKey, bpId, actId)
	if not rewards or #rewards <= 0 then
		return
	end

	PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.BpPropView, rewards)

	actId = actId or Anniversary3ActBpModel.instance:getCurActId()
	bpId = bpId or Anniversary3ActBpModel.instance:getCurBpId(actId)

	local hasPay = Anniversary3ActBpModel.instance:isPremiumPayed(bpId, actId)
	local showSp = not hasPay and hasKey

	if showSp then
		local data = {}

		data.bpId = bpId
		data.activityId = actId

		PopupController.instance:addPopupView(PopupEnum.PriorityType.CommonPropView, ViewName.Anniversary3ActBpPropView, data)
	end
end

function Anniversary3ActBpController:openAnniversary3ActBpPropView(bpId, actId)
	local data = {}

	data.bpId = bpId
	data.activityId = actId

	ViewMgr.instance:openView(ViewName.Anniversary3ActBpPropView, data)
end

Anniversary3ActBpController.instance = Anniversary3ActBpController.New()

return Anniversary3ActBpController
