-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vacationpowersurge/agent/VacationPowerSurgeAgent.lua

module("logic.extensions.vacationpowersurge.agent.VacationPowerSurgeAgent", package.seeall)

local VacationPowerSurgeAgent = class("VacationPowerSurgeAgent", BaseAgent)

VacationPowerSurgeAgent.PM_VacationPowerSurgeGetInfoRes = "VacationPowerSurgeAgent_PM_VacationPowerSurgeGetInfoRes"
VacationPowerSurgeAgent.PM_VacationPowerSurgeGainProgressPrizeRes = "VacationPowerSurgeAgent_PM_VacationPowerSurgeGainProgressPrizeRes"
VacationPowerSurgeAgent.PM_VacationPowerSurgeOnePassRes = "VacationPowerSurgeAgent_PM_VacationPowerSurgeOnePassRes"
VacationPowerSurgeAgent.PM_VacationPowerSurgeGainTaskPrizeRes = "VacationPowerSurgeAgent_PM_VacationPowerSurgeGainTaskPrizeRes"
VacationPowerSurgeAgent.PM_VacationPowerSurgeNotifyTaskInfosRes = "VacationPowerSurgeAgent_PM_VacationPowerSurgeNotifyTaskInfosRes"

function VacationPowerSurgeAgent:ctor()
	return
end

function VacationPowerSurgeAgent:setExtId(extId)
	VacationPowerSurgeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function VacationPowerSurgeAgent:sendPM_VacationPowerSurgeGetInfoReq(handler, handlerObj, errHandler)
	local req = VacationPowerSurgeExtension_pb.PM_VacationPowerSurgeGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(VacationPowerSurgeAgent.PM_VacationPowerSurgeGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function VacationPowerSurgeAgent:handlePM_VacationPowerSurgeGetInfoRes(status, msg)
	self:dispatch(VacationPowerSurgeAgent.PM_VacationPowerSurgeGetInfoRes, status, msg)
end

function VacationPowerSurgeAgent:sendPM_VacationPowerSurgeGainProgressPrizeReq(activityId, id, handler, handlerObj, errHandler)
	local req = VacationPowerSurgeExtension_pb.PM_VacationPowerSurgeGainProgressPrizeReq()

	req.activityId = activityId
	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(VacationPowerSurgeAgent.PM_VacationPowerSurgeGainProgressPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function VacationPowerSurgeAgent:handlePM_VacationPowerSurgeGainProgressPrizeRes(status, msg)
	self:dispatch(VacationPowerSurgeAgent.PM_VacationPowerSurgeGainProgressPrizeRes, status, msg)
end

function VacationPowerSurgeAgent:sendPM_VacationPowerSurgeOnePassReq(activityId, taskId, handler, handlerObj, errHandler)
	local req = VacationPowerSurgeExtension_pb.PM_VacationPowerSurgeOnePassReq()

	req.activityId = activityId
	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(VacationPowerSurgeAgent.PM_VacationPowerSurgeOnePassRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function VacationPowerSurgeAgent:handlePM_VacationPowerSurgeOnePassRes(status, msg)
	self:dispatch(VacationPowerSurgeAgent.PM_VacationPowerSurgeOnePassRes, status, msg)
end

function VacationPowerSurgeAgent:sendPM_VacationPowerSurgeGainTaskPrizeReq(activityId, taskId, handler, handlerObj, errHandler)
	local req = VacationPowerSurgeExtension_pb.PM_VacationPowerSurgeGainTaskPrizeReq()

	req.activityId = activityId
	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(VacationPowerSurgeAgent.PM_VacationPowerSurgeGainTaskPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function VacationPowerSurgeAgent:handlePM_VacationPowerSurgeGainTaskPrizeRes(status, msg)
	self:dispatch(VacationPowerSurgeAgent.PM_VacationPowerSurgeGainTaskPrizeRes, status, msg)
end

function VacationPowerSurgeAgent:handlePM_VacationPowerSurgeNotifyTaskInfosRes(status, msg)
	self:dispatch(VacationPowerSurgeAgent.PM_VacationPowerSurgeNotifyTaskInfosRes, status, msg)
end

VacationPowerSurgeAgent.instance = VacationPowerSurgeAgent.New()

return VacationPowerSurgeAgent
