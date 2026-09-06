-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/equipment/agent/PetCommentAgent.lua

module("logic.extensions.equipment.agent.PetCommentAgent", package.seeall)

local PetCommentAgent = class("PetCommentAgent", BaseAgent)

PetCommentAgent.PM_PetCommentUserInfoRes = "PetCommentAgent_PM_PetCommentUserInfoRes"
PetCommentAgent.PM_PetCommentInfoRes = "PetCommentAgent_PM_PetCommentInfoRes"
PetCommentAgent.PM_SendPetCommentRes = "PetCommentAgent_PM_SendPetCommentRes"
PetCommentAgent.PM_PetCommentLikeRes = "PetCommentAgent_PM_PetCommentLikeRes"
PetCommentAgent.PM_PetCommentReportRes = "PetCommentAgent_PM_PetCommentReportRes"

function PetCommentAgent:ctor()
	return
end

function PetCommentAgent:setExtId(extId)
	PetCommentAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function PetCommentAgent:sendPM_PetCommentUserInfoReq(raceId, handler, handlerObj, errHandler)
	local req = PetCommentExtension_pb.PM_PetCommentUserInfoReq()

	req.raceId = raceId

	self:sendMsg(req)
	self:addEventOnce(PetCommentAgent.PM_PetCommentUserInfoRes, handler, handlerObj, errHandler)
end

function PetCommentAgent:handlePM_PetCommentUserInfoRes(status, msg)
	self:dispatch(PetCommentAgent.PM_PetCommentUserInfoRes, status, msg)
end

function PetCommentAgent:sendPM_PetCommentInfoReq(raceId, handler, handlerObj, errHandler)
	local req = PetCommentExtension_pb.PM_PetCommentInfoReq()

	req.raceId = raceId

	self:sendMsg(req)
	self:addEventOnce(PetCommentAgent.PM_PetCommentInfoRes, handler, handlerObj, errHandler)
end

function PetCommentAgent:handlePM_PetCommentInfoRes(status, msg)
	self:dispatch(PetCommentAgent.PM_PetCommentInfoRes, status, msg)
end

function PetCommentAgent:sendPM_SendPetCommentReq(raceId, content, handler, handlerObj, errHandler)
	local req = PetCommentExtension_pb.PM_SendPetCommentReq()

	req.raceId = raceId
	req.content = content

	self:sendMsg(req)
	self:addEventOnce(PetCommentAgent.PM_SendPetCommentRes, handler, handlerObj, errHandler)
end

function PetCommentAgent:handlePM_SendPetCommentRes(status, msg)
	self:dispatch(PetCommentAgent.PM_SendPetCommentRes, status, msg)
end

function PetCommentAgent:sendPM_PetCommentLikeReq(raceId, commentId, handler, handlerObj, errHandler)
	local req = PetCommentExtension_pb.PM_PetCommentLikeReq()

	req.raceId = raceId
	req.commentId = commentId

	self:sendMsg(req)
	self:addEventOnce(PetCommentAgent.PM_PetCommentLikeRes, handler, handlerObj, errHandler)
end

function PetCommentAgent:handlePM_PetCommentLikeRes(status, msg)
	self:dispatch(PetCommentAgent.PM_PetCommentLikeRes, status, msg)
end

function PetCommentAgent:sendPM_PetCommentReportReq(raceId, commentId, reportType, content, handler, handlerObj, errHandler)
	local req = PetCommentExtension_pb.PM_PetCommentReportReq()

	req.raceId = raceId
	req.commentId = commentId
	req.reportType = reportType
	req.content = content

	self:sendMsg(req)
	self:addEventOnce(PetCommentAgent.PM_PetCommentReportRes, handler, handlerObj, errHandler)
end

function PetCommentAgent:handlePM_PetCommentReportRes(status, msg)
	self:dispatch(PetCommentAgent.PM_PetCommentReportRes, status, msg)
end

PetCommentAgent.instance = PetCommentAgent.New()

return PetCommentAgent
