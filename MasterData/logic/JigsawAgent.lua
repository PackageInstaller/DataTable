-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/jigsawcollect/agent/JigsawAgent.lua

module("logic.extensions.jigsaw.agent.JigsawAgent", package.seeall)

local JigsawAgent = class("JigsawAgent", BaseAgent)

JigsawAgent.PM_GetCurJigsawInfoRes = "JigsawAgent_PM_GetCurJigsawInfoRes"
JigsawAgent.PM_GainJigsawTaskPrizeRes = "JigsawAgent_PM_GainJigsawTaskPrizeRes"
JigsawAgent.PM_GainJigsawCollectPrizeRes = "JigsawAgent_PM_GainJigsawCollectPrizeRes"
JigsawAgent.PM_UnlockJigsawPieceRes = "JigsawAgent_PM_UnlockJigsawPieceRes"

function JigsawAgent:ctor()
	return
end

function JigsawAgent:setExtId(extId)
	JigsawAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function JigsawAgent:sendPM_GetCurJigsawInfoReq(handler, handlerObj, errHandler)
	local req = JigsawExtension_pb.PM_GetCurJigsawInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(JigsawAgent.PM_GetCurJigsawInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function JigsawAgent:handlePM_GetCurJigsawInfoRes(status, msg)
	self:dispatch(JigsawAgent.PM_GetCurJigsawInfoRes, status, msg)
end

function JigsawAgent:sendPM_GainJigsawTaskPrizeReq(actId, taskId, handler, handlerObj, errHandler)
	local req = JigsawExtension_pb.PM_GainJigsawTaskPrizeReq()

	req.actId = actId
	req.taskId = taskId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(JigsawAgent.PM_GainJigsawTaskPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function JigsawAgent:handlePM_GainJigsawTaskPrizeRes(status, msg)
	self:dispatch(JigsawAgent.PM_GainJigsawTaskPrizeRes, status, msg)
end

function JigsawAgent:sendPM_GainJigsawCollectPrizeReq(actId, progressId, handler, handlerObj, errHandler)
	local req = JigsawExtension_pb.PM_GainJigsawCollectPrizeReq()

	req.actId = actId
	req.progressId = progressId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(JigsawAgent.PM_GainJigsawCollectPrizeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function JigsawAgent:handlePM_GainJigsawCollectPrizeRes(status, msg)
	self:dispatch(JigsawAgent.PM_GainJigsawCollectPrizeRes, status, msg)
end

function JigsawAgent:sendPM_UnlockJigsawPieceReq(actId, pieceId, handler, handlerObj, errHandler)
	local req = JigsawExtension_pb.PM_UnlockJigsawPieceReq()

	req.actId = actId
	req.pieceId = pieceId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(JigsawAgent.PM_UnlockJigsawPieceRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function JigsawAgent:handlePM_UnlockJigsawPieceRes(status, msg)
	self:dispatch(JigsawAgent.PM_UnlockJigsawPieceRes, status, msg)
end

JigsawAgent.instance = JigsawAgent.New()

return JigsawAgent
