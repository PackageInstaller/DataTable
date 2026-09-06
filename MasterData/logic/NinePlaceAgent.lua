-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/nineplace/agent/NinePlaceAgent.lua

module("logic.extensions.nineplace.agent.NinePlaceAgent", package.seeall)

local NinePlaceAgent = class("NinePlaceAgent", BaseAgent)

NinePlaceAgent.PM_GetNinePlaceProcessInfoRes = "NinePlaceAgent_PM_GetNinePlaceProcessInfoRes"
NinePlaceAgent.PM_NinePlaceChallengeRes = "NinePlaceAgent_PM_NinePlaceChallengeRes"
NinePlaceAgent.PM_NinePlaceChallengeEndRes = "NinePlaceAgent_PM_NinePlaceChallengeEndRes"

function NinePlaceAgent:ctor()
	return
end

function NinePlaceAgent:setExtId(extId)
	NinePlaceAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function NinePlaceAgent:sendPM_GetNinePlaceProcessInfoReq(handler, handlerObj, errHandler)
	local req = NinePlaceExtension_pb.PM_GetNinePlaceProcessInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NinePlaceAgent.PM_GetNinePlaceProcessInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NinePlaceAgent:handlePM_GetNinePlaceProcessInfoRes(status, msg)
	self:dispatch(NinePlaceAgent.PM_GetNinePlaceProcessInfoRes, status, msg)
end

function NinePlaceAgent:sendPM_NinePlaceChallengeReq(stageId, masterIdx, handler, handlerObj, errHandler)
	local req = NinePlaceExtension_pb.PM_NinePlaceChallengeReq()

	req.stageId = stageId
	req.masterIdx = masterIdx

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(NinePlaceAgent.PM_NinePlaceChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function NinePlaceAgent:handlePM_NinePlaceChallengeRes(status, msg)
	self:dispatch(NinePlaceAgent.PM_NinePlaceChallengeRes, status, msg)
end

function NinePlaceAgent:handlePM_NinePlaceChallengeEndRes(status, msg)
	self:dispatch(NinePlaceAgent.PM_NinePlaceChallengeEndRes, status, msg)
end

NinePlaceAgent.instance = NinePlaceAgent.New()

return NinePlaceAgent
