-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/feedback/agent/FeedbackAgent.lua

module("logic.extensions.feedback.agent.FeedbackAgent", package.seeall)

local FeedbackAgent = class("FeedbackAgent", BaseAgent)

FeedbackAgent.PM_HandleLoadFeedbackInfosRes = "FeedbackAgent_PM_HandleLoadFeedbackInfosRes"
FeedbackAgent.PM_HandleSendFeedbackRes = "FeedbackAgent_PM_HandleSendFeedbackRes"
FeedbackAgent.PM_ReportRes = "FeedbackAgent_PM_ReportRes"
FeedbackAgent.PM_NewFeedbackPushRes = "FeedbackAgent_PM_NewFeedbackPushRes"

function FeedbackAgent:ctor()
	return
end

function FeedbackAgent:setExtId(extId)
	FeedbackAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function FeedbackAgent:sendPM_HandleLoadFeedbackInfosReq(curFeedbackId, handler, handlerObj, errHandler)
	local req = FeedbackExtension_pb.PM_HandleLoadFeedbackInfosReq()

	req.curFeedbackId = curFeedbackId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FeedbackAgent.PM_HandleLoadFeedbackInfosRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FeedbackAgent:handlePM_HandleLoadFeedbackInfosRes(status, msg)
	self:dispatch(FeedbackAgent.PM_HandleLoadFeedbackInfosRes, status, msg)
end

function FeedbackAgent:sendPM_HandleSendFeedbackReq(type, content, handler, handlerObj, errHandler)
	local req = FeedbackExtension_pb.PM_HandleSendFeedbackReq()

	req.type = type
	req.content = content

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FeedbackAgent.PM_HandleSendFeedbackRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FeedbackAgent:handlePM_HandleSendFeedbackRes(status, msg)
	self:dispatch(FeedbackAgent.PM_HandleSendFeedbackRes, status, msg)
end

function FeedbackAgent:sendPM_ReportReq(beReportUserId, type, remarks, content, handler, handlerObj, errHandler)
	local req = FeedbackExtension_pb.PM_ReportReq()

	req.beReportUserId = beReportUserId
	req.type = type
	req.remarks = remarks
	req.content = content

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(FeedbackAgent.PM_ReportRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function FeedbackAgent:handlePM_ReportRes(status, msg)
	self:dispatch(FeedbackAgent.PM_ReportRes, status, msg)
end

function FeedbackAgent:handlePM_NewFeedbackPushRes(status, msg)
	self:dispatch(FeedbackAgent.PM_NewFeedbackPushRes, status, msg)
end

FeedbackAgent.instance = FeedbackAgent.New()

return FeedbackAgent
