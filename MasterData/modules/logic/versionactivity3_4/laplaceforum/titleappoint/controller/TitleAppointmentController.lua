-- chunkname: @modules/logic/versionactivity3_4/laplaceforum/titleappoint/controller/TitleAppointmentController.lua

module("modules.logic.versionactivity3_4.laplaceforum.titleappoint.controller.TitleAppointmentController", package.seeall)

local TitleAppointmentController = class("TitleAppointmentController", BaseController)

function TitleAppointmentController:onInit()
	self:reInit()
end

function TitleAppointmentController:reInit()
	self._hasGet = nil
end

function TitleAppointmentController:onInitFinish()
	return
end

function TitleAppointmentController:addConstEvents()
	ActivityController.instance:registerCallback(ActivityEvent.RefreshActivityState, self._refreshActInfo, self)
	TimeDispatcher.instance:registerCallback(TimeDispatcher.OnDailyRefresh, self._onDailyRefresh, self)
end

function TitleAppointmentController:_onDailyRefresh()
	self._hasGet = nil

	self:_refreshActInfo()
end

function TitleAppointmentController:_refreshActInfo()
	local actInfoMo = ActivityModel.instance:getActivityInfo()[VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint]

	if not actInfoMo then
		return
	end

	local isExpired = actInfoMo:getRealEndTimeStamp() - ServerTime.now() < 1
	local couldGet = actInfoMo:isOnline() and actInfoMo:isOpen() and not isExpired

	if couldGet and self._hasGet ~= couldGet then
		Activity224Rpc.instance:sendGet224InfoRequest(VersionActivity3_4Enum.ActivityId.LaplaceTitleAppoint)
	end

	self._hasGet = couldGet
end

TitleAppointmentController.instance = TitleAppointmentController.New()

return TitleAppointmentController
