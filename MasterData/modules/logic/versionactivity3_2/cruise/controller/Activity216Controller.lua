-- chunkname: @modules/logic/versionactivity3_2/cruise/controller/Activity216Controller.lua

module("modules.logic.versionactivity3_2.cruise.controller.Activity216Controller", package.seeall)

local Activity216Controller = class("Activity216Controller", BaseController)

function Activity216Controller:onInit()
	return
end

function Activity216Controller:reInit()
	return
end

function Activity216Controller:onInitFinish()
	return
end

function Activity216Controller:addConstEvents()
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self.dailyRefresh, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
end

function Activity216Controller:onRefreshActivity()
	self:_checkAndGetActInfo()
end

function Activity216Controller:dailyRefresh()
	self:_checkAndGetActInfo()
end

function Activity216Controller:_checkAndGetActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_2Enum.ActivityId.CruiseSelfTask]

	if actInfoMo and actInfoMo:isOnline() and actInfoMo:isOpen() and not actInfoMo:isExpired() then
		Activity216Rpc.instance:sendGetAct216InfoRequest(VersionActivity3_2Enum.ActivityId.CruiseSelfTask)
	end
end

Activity216Controller.instance = Activity216Controller.New()

return Activity216Controller
