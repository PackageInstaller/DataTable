-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsummary/controller/ForceSlideController.lua

module("logic.extensions.forceslide.controller.ForceSlideController", package.seeall)

local ForceSlideController = class("ForceSlideController", BaseController)

ForceSlideController.AfterGetInfoResponse = "ForceSlideController.AfterGetInfoResponse"

function ForceSlideController:ctor()
	return
end

function ForceSlideController:onInit()
	ClockMgr.instance:addListener(ClockMgr.TickDailyRefresh, self._TickDailyRefreshData, self)
	GlobalDispatcher:addListener(GlobalNotify.RoleLogined, self._TickDailyRefreshData, self)
	self:_TickDailyRefreshData()
end

function ForceSlideController:onReset()
	return
end

function ForceSlideController:_TickDailyRefreshData()
	local activityId = ForceSlideModel.instance:getActivityId()
	local activityConf = ActivityDefineConfig.instance:getCfgById(GameEnum.ActivityType.ForceSlide, activityId)

	if activityConf and GameUtil.checkIsInTimePeriod(activityConf.startTime, activityConf.endTime) then
		RedPointController.instance:regUserDayRedPoint(RedPointModel.ID_FORCE_SLIDE)
	end
end

function ForceSlideController:sendGetInfo()
	local activityId = ForceSlideModel.instance:getActivityId()

	ForceSlideAgent.instance:sendPM_ForceSlideGetInfoReq(activityId)
end

function ForceSlideController:handleGetInfo(status, msg)
	if status == 0 then
		ForceSlideModel.instance:handleGetInfo(msg)
		GlobalDispatcher:dispatch(ForceSlideController.AfterGetInfoResponse)
	end
end

ForceSlideController.instance = ForceSlideController.New()

return ForceSlideController
