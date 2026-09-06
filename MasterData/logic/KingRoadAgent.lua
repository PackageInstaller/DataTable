-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/agent/KingRoadAgent.lua

module("logic.extensions.kingroad.agent.KingRoadAgent", package.seeall)

local KingRoadAgent = class("KingRoadAgent", BaseAgent)

KingRoadAgent.PM_GetMyKingRoadInfoRes = "KingRoadAgent_PM_GetMyKingRoadInfoRes"
KingRoadAgent.PM_ChallengeStageRes = "KingRoadAgent_PM_ChallengeStageRes"
KingRoadAgent.PM_UpdateVerifiedRes = "KingRoadAgent_PM_UpdateVerifiedRes"
KingRoadAgent.PM_ChallengeEndRes = "KingRoadAgent_PM_ChallengeEndRes"

function KingRoadAgent:ctor()
	return
end

function KingRoadAgent:setExtId(extId)
	KingRoadAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function KingRoadAgent:sendPM_GetMyKingRoadInfoReq(handler, handlerObj, errHandler)
	local req = KingRoadExtension_pb.PM_GetMyKingRoadInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(KingRoadAgent.PM_GetMyKingRoadInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function KingRoadAgent:handlePM_GetMyKingRoadInfoRes(status, msg)
	self:dispatch(KingRoadAgent.PM_GetMyKingRoadInfoRes, status, msg)
end

function KingRoadAgent:sendPM_ChallengeStageReq(challenge, stage, handler, handlerObj, errHandler)
	local req = KingRoadExtension_pb.PM_ChallengeStageReq()

	req.challenge = challenge
	req.stage = stage

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(KingRoadAgent.PM_ChallengeStageRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function KingRoadAgent:handlePM_ChallengeStageRes(status, msg)
	self:dispatch(KingRoadAgent.PM_ChallengeStageRes, status, msg)
end

function KingRoadAgent:handlePM_ChallengeEndRes(status, msg)
	self:dispatch(KingRoadAgent.PM_ChallengeEndRes, status, msg)
end

KingRoadAgent.instance = KingRoadAgent.New()

return KingRoadAgent
