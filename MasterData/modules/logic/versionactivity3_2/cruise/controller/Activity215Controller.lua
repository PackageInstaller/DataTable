-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/Activity215Controller.lua

module("modules.logic.versionactivity3_2.cruise.controller.Activity215Controller", package.seeall)

local Activity215Controller = class("Activity215Controller", BaseController)

function Activity215Controller:onInit()
	return
end

function Activity215Controller:reInit()
	return
end

function Activity215Controller:onInitFinish()
	return
end

function Activity215Controller:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity215Controller:onRefreshActivity()
	self:_checkAndGetActInfo()
end

function Activity215Controller:dailyRefresh()
	self:_checkAndGetActInfo()
end

function Activity215Controller:_checkAndGetActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseGlobalTask]

	if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
		TaskRpc.instance:sendGetTaskInfoRequest({
			TaskEnum.TaskType.Activity173
		})
		Activity215Rpc.instance:sendGetAct215InfoRequest(VersionActivity3_2Enum.ActivityId.CruiseGlobalTask)
	end
end

Activity215Controller.instance = Activity215Controller.New()

return Activity215Controller
