-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeAccumulateAgent.lua

module("logic.extensions.timedchallengeaccumulate.agent.TimedChallengeAccumulateAgent", package.seeall)

local TimedChallengeAccumulateAgent = class("TimedChallengeAccumulateAgent", BaseAgent)

TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateInfoRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateInfoRes"
TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateFightRes"
TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateRandomBuffRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateRandomBuffRes"
TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightFinishRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateFightFinishRes"
TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetPetRankRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateGetPetRankRes"
TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetDamageRankRes = "TimedChallengeAccumulateAgent_PM_TimedChallengeAccumulateGetDamageRankRes"

function TimedChallengeAccumulateAgent:ctor()
	return
end

function TimedChallengeAccumulateAgent:setExtId(extId)
	TimedChallengeAccumulateAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimedChallengeAccumulateAgent:sendPM_TimedChallengeAccumulateInfoReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeAccumulateExtension_pb.PM_TimedChallengeAccumulateInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateInfoRes, handler, handlerObj, errHandler)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateInfoRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateInfoRes, status, msg)
end

function TimedChallengeAccumulateAgent:sendPM_TimedChallengeAccumulateFightReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeAccumulateExtension_pb.PM_TimedChallengeAccumulateFightReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightRes, handler, handlerObj, errHandler)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateFightRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightRes, status, msg)
end

function TimedChallengeAccumulateAgent:sendPM_TimedChallengeAccumulateRandomBuffReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeAccumulateExtension_pb.PM_TimedChallengeAccumulateRandomBuffReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateRandomBuffRes, handler, handlerObj, errHandler)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateRandomBuffRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateRandomBuffRes, status, msg)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateFightFinishRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateFightFinishRes, status, msg)
end

function TimedChallengeAccumulateAgent:sendPM_TimedChallengeAccumulateGetPetRankReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeAccumulateExtension_pb.PM_TimedChallengeAccumulateGetPetRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetPetRankRes, handler, handlerObj, errHandler)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateGetPetRankRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetPetRankRes, status, msg)
end

function TimedChallengeAccumulateAgent:sendPM_TimedChallengeAccumulateGetDamageRankReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeAccumulateExtension_pb.PM_TimedChallengeAccumulateGetDamageRankReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetDamageRankRes, handler, handlerObj, errHandler)
end

function TimedChallengeAccumulateAgent:handlePM_TimedChallengeAccumulateGetDamageRankRes(status, msg)
	self:dispatch(TimedChallengeAccumulateAgent.PM_TimedChallengeAccumulateGetDamageRankRes, status, msg)
end

TimedChallengeAccumulateAgent.instance = TimedChallengeAccumulateAgent.New()

return TimedChallengeAccumulateAgent
