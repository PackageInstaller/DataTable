-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/challenge/agent/JiuGongFairyStrengthAgent.lua

module("logic.extensions.challenge.agent.JiuGongFairyStrengthAgent", package.seeall)

local JiuGongFairyStrengthAgent = class("JiuGongFairyStrengthAgent", BaseAgent)

JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthRes = "JiuGongFairyStrengthAgent_PM_JiuGongFairyStrengthRes"
JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthChallengeRes = "JiuGongFairyStrengthAgent_PM_JiuGongFairyStrengthChallengeRes"
JiuGongFairyStrengthAgent.PM_JiuGongFairyGainStrengthPrizeRes = "JiuGongFairyStrengthAgent_PM_JiuGongFairyGainStrengthPrizeRes"
JiuGongFairyStrengthAgent.PM_JiuGongFairyOneKeyClearCdRes = "JiuGongFairyStrengthAgent_PM_JiuGongFairyOneKeyClearCdRes"

function JiuGongFairyStrengthAgent:ctor()
	return
end

function JiuGongFairyStrengthAgent:setExtId(extId)
	JiuGongFairyStrengthAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function JiuGongFairyStrengthAgent:sendPM_JiuGongFairyStrengthReq(handler, handlerObj, errHandler)
	local req = JiuGongFairyStrengthExtension_pb.PM_JiuGongFairyStrengthReq()

	self:sendMsg(req)
	self:addEventOnce(JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthRes, handler, handlerObj, errHandler)
end

function JiuGongFairyStrengthAgent:handlePM_JiuGongFairyStrengthRes(status, msg)
	self:dispatch(JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthRes, status, msg)
end

function JiuGongFairyStrengthAgent:sendPM_JiuGongFairyStrengthChallengeReq(index, handler, handlerObj, errHandler)
	local req = JiuGongFairyStrengthExtension_pb.PM_JiuGongFairyStrengthChallengeReq()

	req.index = index

	self:sendMsg(req)
	self:addEventOnce(JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthChallengeRes, handler, handlerObj, errHandler)
end

function JiuGongFairyStrengthAgent:handlePM_JiuGongFairyStrengthChallengeRes(status, msg)
	self:dispatch(JiuGongFairyStrengthAgent.PM_JiuGongFairyStrengthChallengeRes, status, msg)
end

function JiuGongFairyStrengthAgent:sendPM_JiuGongFairyGainStrengthPrizeReq(prizeIndex, prizeReq_pb, handler, handlerObj, errHandler)
	self:sendMsg(req)
	self:addEventOnce(JiuGongFairyStrengthAgent.PM_JiuGongFairyGainStrengthPrizeRes, handler, handlerObj, errHandler)
end

function JiuGongFairyStrengthAgent:handlePM_JiuGongFairyGainStrengthPrizeRes(status, msg)
	self:dispatch(JiuGongFairyStrengthAgent.PM_JiuGongFairyGainStrengthPrizeRes, status, msg)
end

function JiuGongFairyStrengthAgent:sendPM_JiuGongFairyOneKeyClearCdReq(prizeIndex, handler, handlerObj, errHandler)
	local req = JiuGongFairyStrengthExtension_pb.PM_JiuGongFairyOneKeyClearCdReq()

	req.prizeIndex = prizeIndex

	self:sendMsg(req)
	self:addEventOnce(JiuGongFairyStrengthAgent.PM_JiuGongFairyOneKeyClearCdRes, handler, handlerObj, errHandler)
end

function JiuGongFairyStrengthAgent:handlePM_JiuGongFairyOneKeyClearCdRes(status, msg)
	self:dispatch(JiuGongFairyStrengthAgent.PM_JiuGongFairyOneKeyClearCdRes, status, msg)
end

JiuGongFairyStrengthAgent.instance = JiuGongFairyStrengthAgent.New()

return JiuGongFairyStrengthAgent
