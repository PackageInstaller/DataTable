-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/petsearch/agent/SeekPetAgent.lua

module("logic.extensions.seekpet.agent.SeekPetAgent", package.seeall)

local SeekPetAgent = class("SeekPetAgent", BaseAgent)

SeekPetAgent.PM_SeekPetInfoRes = "SeekPetAgent_PM_SeekPetInfoRes"
SeekPetAgent.PM_SeekPetRes = "SeekPetAgent_PM_SeekPetRes"
SeekPetAgent.PM_SeekPetRefreshRes = "SeekPetAgent_PM_SeekPetRefreshRes"
SeekPetAgent.PM_SeekPetDirectlyRes = "SeekPetAgent_PM_SeekPetDirectlyRes"
SeekPetAgent.PM_SeekPetChallengeRes = "SeekPetAgent_PM_SeekPetChallengeRes"
SeekPetAgent.NotifyAfterChallengeRes = "SeekPetAgent_NotifyAfterChallengeRes"

function SeekPetAgent:ctor()
	return
end

function SeekPetAgent:setExtId(extId)
	SeekPetAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function SeekPetAgent:sendPM_SeekPetInfoReq(handler, handlerObj, errHandler)
	local req = SeekPetExtension_pb.PM_SeekPetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(SeekPetAgent.PM_SeekPetInfoRes, handler, handlerObj, errHandler)
end

function SeekPetAgent:handlePM_SeekPetInfoRes(status, msg)
	self:dispatch(SeekPetAgent.PM_SeekPetInfoRes, status, msg)
end

function SeekPetAgent:sendPM_SeekPetReq(handler, handlerObj, errHandler)
	local req = SeekPetExtension_pb.PM_SeekPetReq()

	self:sendMsg(req)
	self:addEventOnce(SeekPetAgent.PM_SeekPetRes, handler, handlerObj, errHandler)
end

function SeekPetAgent:handlePM_SeekPetRes(status, msg)
	self:dispatch(SeekPetAgent.PM_SeekPetRes, status, msg)
end

function SeekPetAgent:sendPM_SeekPetRefreshReq(handler, handlerObj, errHandler)
	local req = SeekPetExtension_pb.PM_SeekPetRefreshReq()

	self:sendMsg(req)
	self:addEventOnce(SeekPetAgent.PM_SeekPetRefreshRes, handler, handlerObj, errHandler)
end

function SeekPetAgent:handlePM_SeekPetRefreshRes(status, msg)
	self:dispatch(SeekPetAgent.PM_SeekPetRefreshRes, status, msg)
end

function SeekPetAgent:sendPM_SeekPetDirectlyReq(bossId, handler, handlerObj, errHandler)
	local req = SeekPetExtension_pb.PM_SeekPetDirectlyReq()

	req.bossId = bossId

	self:sendMsg(req)
	self:addEventOnce(SeekPetAgent.PM_SeekPetDirectlyRes, handler, handlerObj, errHandler)
end

function SeekPetAgent:handlePM_SeekPetDirectlyRes(status, msg)
	self:dispatch(SeekPetAgent.PM_SeekPetDirectlyRes, status, msg)
end

function SeekPetAgent:sendPM_SeekPetChallengeReq(handler, handlerObj, errHandler)
	local req = SeekPetExtension_pb.PM_SeekPetChallengeReq()

	self:sendMsg(req)
	self:addEventOnce(SeekPetAgent.PM_SeekPetChallengeRes, handler, handlerObj, errHandler)
end

function SeekPetAgent:handlePM_SeekPetChallengeRes(status, msg)
	self:dispatch(SeekPetAgent.PM_SeekPetChallengeRes, status, msg)
end

function SeekPetAgent:handleNotifyAfterChallengeRes(status, msg)
	self:dispatch(SeekPetAgent.NotifyAfterChallengeRes, status, msg)
end

SeekPetAgent.instance = SeekPetAgent.New()

return SeekPetAgent
