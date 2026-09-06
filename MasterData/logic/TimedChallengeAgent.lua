-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeAgent.lua

module("logic.extensions.timedchallenge.agent.TimedChallengeAgent", package.seeall)

local TimedChallengeAgent = class("TimedChallengeAgent", BaseAgent)

TimedChallengeAgent.PM_TimedChallengeGetExchangeInfoRes = "TimedChallengeAgent_PM_TimedChallengeGetExchangeInfoRes"
TimedChallengeAgent.PM_TimedChallengeDoExchangeRes = "TimedChallengeAgent_PM_TimedChallengeDoExchangeRes"
TimedChallengeAgent.PM_TimedChallengeGetPetRankRes = "TimedChallengeAgent_PM_TimedChallengeGetPetRankRes"
TimedChallengeAgent.PM_TimedChallengeGetDamageRankRes = "TimedChallengeAgent_PM_TimedChallengeGetDamageRankRes"
TimedChallengeAgent.PM_TimedChallengeGetDamageVideoRes = "TimedChallengeAgent_PM_TimedChallengeGetDamageVideoRes"

function TimedChallengeAgent:ctor()
	return
end

function TimedChallengeAgent:setExtId(extId)
	TimedChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimedChallengeAgent:sendPM_TimedChallengeGetExchangeInfoReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeExtension_pb.PM_TimedChallengeGetExchangeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAgent.PM_TimedChallengeGetExchangeInfoRes, handler, handlerObj, errHandler)
end

function TimedChallengeAgent:handlePM_TimedChallengeGetExchangeInfoRes(status, msg)
	self:dispatch(TimedChallengeAgent.PM_TimedChallengeGetExchangeInfoRes, status, msg)
end

function TimedChallengeAgent:sendPM_TimedChallengeDoExchangeReq(challengeId, exchangeId, times, handler, handlerObj, errHandler)
	local req = TimedChallengeExtension_pb.PM_TimedChallengeDoExchangeReq()

	req.challengeId = challengeId
	req.exchangeId = exchangeId
	req.times = times

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAgent.PM_TimedChallengeDoExchangeRes, handler, handlerObj, errHandler)
end

function TimedChallengeAgent:handlePM_TimedChallengeDoExchangeRes(status, msg)
	self:dispatch(TimedChallengeAgent.PM_TimedChallengeDoExchangeRes, status, msg)
end

function TimedChallengeAgent:sendPM_TimedChallengeGetPetRankReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeExtension_pb.PM_TimedChallengeGetPetRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAgent.PM_TimedChallengeGetPetRankRes, handler, handlerObj, errHandler)
end

function TimedChallengeAgent:handlePM_TimedChallengeGetPetRankRes(status, msg)
	self:dispatch(TimedChallengeAgent.PM_TimedChallengeGetPetRankRes, status, msg)
end

function TimedChallengeAgent:sendPM_TimedChallengeGetDamageRankReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeExtension_pb.PM_TimedChallengeGetDamageRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAgent.PM_TimedChallengeGetDamageRankRes, handler, handlerObj, errHandler)
end

function TimedChallengeAgent:handlePM_TimedChallengeGetDamageRankRes(status, msg)
	self:dispatch(TimedChallengeAgent.PM_TimedChallengeGetDamageRankRes, status, msg)
end

function TimedChallengeAgent:sendPM_TimedChallengeGetDamageVideoReq(challengeId, rank, handler, handlerObj, errHandler)
	local req = TimedChallengeExtension_pb.PM_TimedChallengeGetDamageVideoReq()

	req.challengeId = challengeId
	req.rank = rank

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAgent.PM_TimedChallengeGetDamageVideoRes, handler, handlerObj, errHandler)
end

function TimedChallengeAgent:handlePM_TimedChallengeGetDamageVideoRes(status, msg)
	self:dispatch(TimedChallengeAgent.PM_TimedChallengeGetDamageVideoRes, status, msg)
end

TimedChallengeAgent.instance = TimedChallengeAgent.New()

return TimedChallengeAgent
