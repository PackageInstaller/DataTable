-- chunkname: @modules/logic/monthcard/controller/MonthCardController.lua

module("modules.logic.monthcard.controller.MonthCardController", package.seeall)

local MonthCardController = class("MonthCardController", BaseController)

function MonthCardController:onInit()
	self:reInit()
end

function MonthCardController:reInit()
	self._hasGet = nil
end

function MonthCardController:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function MonthCardController:onRefreshActivity()
	self:_checkAndGetActInfo()
end

function MonthCardController:dailyRefresh()
	self._hasGet = nil

	self:_checkAndGetActInfo()
end

function MonthCardController:_checkAndGetActInfo()
	local actId = VersionActivity3_8Enum.ActivityId.FreeMonthCard
	local actInfoMo = ActivityModel.instance:getActivityInfo()[actId]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.V3A8FreeMonthCard
		})
		Activity240Rpc.instance:sendAct240GetInfoRequest(actId)
	end

	self._hasGet = couldGet
end

function MonthCardController:openV3a8PanelView()
	ViewMgr.instance:openView(ViewName.VersionActivity3_8FreeMonthCardPanelView)
end

function MonthCardController:openV3a8FullView()
	ViewMgr.instance:openView(ViewName.VersionActivity3_8FreeMonthCardFullView)
end

function MonthCardController:openV3a8TaskView()
	ViewMgr.instance:openView(ViewName.VersionActivity3_8FreeMonthCardTaskView)
end

function MonthCardController:closeV3a8RewardView()
	ViewMgr.instance:closeView(ViewName.VersionActivity3_8FreeMonthCardRewardView)
end

MonthCardController.instance = MonthCardController.New()

return MonthCardController
