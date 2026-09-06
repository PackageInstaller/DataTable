-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/operationsignin/agent/OperationCheckInAgent.lua

module("logic.extensions.operationcheckin.agent.OperationCheckInAgent", package.seeall)

local OperationCheckInAgent = class("OperationCheckInAgent", BaseAgent)

OperationCheckInAgent.PM_OperationCheckInGetInfoRes = "OperationCheckInAgent_PM_OperationCheckInGetInfoRes"
OperationCheckInAgent.PM_OperationCheckInGainPrizeRes = "OperationCheckInAgent_PM_OperationCheckInGainPrizeRes"

function OperationCheckInAgent:ctor()
	return
end

function OperationCheckInAgent:setExtId(extId)
	OperationCheckInAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function OperationCheckInAgent:sendPM_OperationCheckInGetInfoReq(activityId, handler, handlerObj, errHandler)
	local req = OperationCheckInExtension_pb.PM_OperationCheckInGetInfoReq()

	req.activityId = activityId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationCheckInAgent.PM_OperationCheckInGetInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationCheckInAgent:handlePM_OperationCheckInGetInfoRes(status, msg)
	self:dispatch(OperationCheckInAgent.PM_OperationCheckInGetInfoRes, status, msg)
end

function OperationCheckInAgent:sendPM_OperationCheckInGainPrizeReq(activityId, day, handler, handlerObj, errHandler)
	local req = OperationCheckInExtension_pb.PM_OperationCheckInGainPrizeReq()

	req.activityId = activityId
	req.day = day

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(OperationCheckInAgent.PM_OperationCheckInGainPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function OperationCheckInAgent:handlePM_OperationCheckInGainPrizeRes(status, msg)
	self:dispatch(OperationCheckInAgent.PM_OperationCheckInGainPrizeRes, status, msg)
end

OperationCheckInAgent.instance = OperationCheckInAgent.New()

return OperationCheckInAgent
