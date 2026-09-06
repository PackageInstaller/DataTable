-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/pettrial/agent/KingLoadAgent.lua

module("logic.extensions.pettrial.agent.KingLoadAgent", package.seeall)

local KingLoadAgent = class("KingLoadAgent", BaseAgent)

KingLoadAgent.GetMyKingLoadInfoRes = "KingLoadAgent_GetMyKingLoadInfoRes"
KingLoadAgent.ChallengeStageRes = "KingLoadAgent_ChallengeStageRes"
KingLoadAgent.ChallengeEndRes = "KingLoadAgent_ChallengeEndRes"

function KingLoadAgent:ctor()
	return
end

function KingLoadAgent:setExtId(extId)
	KingLoadAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function KingLoadAgent:sendGetMyKingLoadInfoReq(handler, handlerObj, errHandler)
	local req = KingLoadExtension_pb.GetMyKingLoadInfoReq()

	self:sendMsg(req)
	self:addEventOnce(KingLoadAgent.GetMyKingLoadInfoRes, handler, handlerObj, errHandler)
end

function KingLoadAgent:handleGetMyKingLoadInfoRes(status, msg)
	self:dispatch(KingLoadAgent.GetMyKingLoadInfoRes, status, msg)
end

function KingLoadAgent:sendChallengeStageReq(stage, handler, handlerObj, errHandler)
	local req = KingLoadExtension_pb.ChallengeStageReq()

	req.stage = stage

	self:sendMsg(req)
	self:addEventOnce(KingLoadAgent.ChallengeStageRes, handler, handlerObj, errHandler)
end

function KingLoadAgent:handleChallengeStageRes(status, msg)
	self:dispatch(KingLoadAgent.ChallengeStageRes, status, msg)
end

function KingLoadAgent:handleChallengeEndRes(status, msg)
	self:dispatch(KingLoadAgent.ChallengeEndRes, status, msg)
end

KingLoadAgent.instance = KingLoadAgent.New()

return KingLoadAgent
