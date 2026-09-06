-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dreampainter/agent/DreamPainterAgent.lua

module("logic.extensions.dreampainter.agent.DreamPainterAgent", package.seeall)

local DreamPainterAgent = class("DreamPainterAgent", BaseAgent)

function DreamPainterAgent:ctor()
	return
end

function DreamPainterAgent:setExtId(extId)
	DreamPainterAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function DreamPainterAgent:sendPM_DreamPainterInfoReq(activityId)
	local req = DreamPainterExtension_pb.PM_DreamPainterInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DreamPainterAgent:handlePM_DreamPainterInfoRes(status, msg)
	if status == 0 then
		DreamPainterController.instance:handleGetInfo(msg)
	end
end

function DreamPainterAgent:sendPM_DreamPainterVoteReq(activityId, phaseId, workId)
	local req = DreamPainterExtension_pb.PM_DreamPainterVoteReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.workId = workId

	self:sendMsg(req)
end

function DreamPainterAgent:handlePM_DreamPainterVoteRes(status, msg)
	if status == 0 then
		DreamPainterController.instance:handlePainterVote(msg)
	end
end

DreamPainterAgent.instance = DreamPainterAgent.New()

return DreamPainterAgent
