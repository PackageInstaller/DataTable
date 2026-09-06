-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/controller/VacationpowersurgeController.lua

module("logic.extensions.vacationpowersurge.controller.VacationpowersurgeController", package.seeall)

local VacationpowersurgeController = class("VacationpowersurgeController", BaseController)

VacationpowersurgeController.PM_VacationPowerSurgeGetInfoRes = "VacationpowersurgeController.PM_VacationPowerSurgeGetInfoRes"
VacationpowersurgeController.PM_VacationPowerSurgeGainProgressPrizeRes = "VacationpowersurgeController.PM_VacationPowerSurgeGainProgressPrizeRes"
VacationpowersurgeController.PM_VacationPowerSurgeOnePassRes = "VacationpowersurgeController.PM_VacationPowerSurgeOnePassRes"
VacationpowersurgeController.PM_VacationPowerSurgeGainTaskPrizeRes = "VacationpowersurgeController.PM_VacationPowerSurgeGainTaskPrizeRes"
VacationpowersurgeController.PM_VacationPowerSurgeNotifyTaskInfosRes = "VacationpowersurgeController.PM_VacationPowerSurgeNotifyTaskInfosRes"

function VacationpowersurgeController:ctor()
	return
end

function VacationpowersurgeController:onInit()
	GlobalDispatcher:addListener(VacationPowerSurgeAgent.PM_VacationPowerSurgeGetInfoRes, self._PM_VacationPowerSurgeGetInfoRes, self)
	GlobalDispatcher:addListener(VacationPowerSurgeAgent.PM_VacationPowerSurgeNotifyTaskInfosRes, self._PM_VacationPowerSurgeNotifyTaskInfosRes, self)
	self:onReset()
end

function VacationpowersurgeController:onReset()
	return
end

function VacationpowersurgeController:_PM_VacationPowerSurgeGetInfoRes(status, msg)
	if status == 0 then
		VacationpowersurgeModel.instance:setActInfos(msg.activityInfos)
	end

	GlobalDispatcher:dispatch(VacationpowersurgeController.PM_VacationPowerSurgeGetInfoRes, status, msg)
end

function VacationpowersurgeController:sendPM_VacationPowerSurgeGainProgressPrizeReq(activityId, id)
	VacationPowerSurgeAgent.instance:sendPM_VacationPowerSurgeGainProgressPrizeReq(activityId, id, function(msg)
		VacationpowersurgeModel.instance:gainProgressPrizeRes(activityId, id)
		GlobalDispatcher:dispatch(VacationpowersurgeController.PM_VacationPowerSurgeGainProgressPrizeRes, 0, msg)
	end)
end

function VacationpowersurgeController:sendPM_VacationPowerSurgeOnePassReq(activityId, taskId)
	VacationPowerSurgeAgent.instance:sendPM_VacationPowerSurgeOnePassReq(activityId, taskId, function(msg)
		VacationpowersurgeModel.instance:onePassRes(activityId, taskId)
		GlobalDispatcher:dispatch(VacationpowersurgeController.PM_VacationPowerSurgeOnePassRes, 0, msg)
	end)
end

function VacationpowersurgeController:sendPM_VacationPowerSurgeGainTaskPrizeReq(activityId, taskId)
	VacationPowerSurgeAgent.instance:sendPM_VacationPowerSurgeGainTaskPrizeReq(activityId, taskId, function(msg, status)
		VacationpowersurgeModel.instance:gainTaskPrizeRes(activityId, taskId)
		GlobalDispatcher:dispatch(VacationpowersurgeController.PM_VacationPowerSurgeGainTaskPrizeRes, status, msg)
	end)
end

function VacationpowersurgeController:_PM_VacationPowerSurgeNotifyTaskInfosRes(status, msg)
	if status == 0 then
		VacationpowersurgeModel.instance:notifyTaskInfos(msg)
	end

	GlobalDispatcher:dispatch(VacationpowersurgeController.PM_VacationPowerSurgeNotifyTaskInfosRes, status, msg)
end

VacationpowersurgeController.instance = VacationpowersurgeController.New()

return VacationpowersurgeController
