-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeCircleFightAgent.lua

module("logic.extensions.timedchallengecirclefight.agent.TimedChallengeCircleFightAgent", package.seeall)

local TimedChallengeCircleFightAgent = class("TimedChallengeCircleFightAgent", BaseAgent)

TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightInfoRes = "TimedChallengeCircleFightAgent_PM_TimedChallengeCircleFightInfoRes"
TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightRes = "TimedChallengeCircleFightAgent_PM_TimedChallengeCircleFightRes"
TimedChallengeCircleFightAgent.PM_TimedChallengeCircleSweepRes = "TimedChallengeCircleFightAgent_PM_TimedChallengeCircleSweepRes"
TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightFinishRes = "TimedChallengeCircleFightAgent_PM_TimedChallengeCircleFightFinishRes"
TimedChallengeCircleFightAgent.PM_TimedChallengeCircleResetChallengeRes = "TimedChallengeCircleFightAgent_PM_TimedChallengeCircleResetChallengeRes"

function TimedChallengeCircleFightAgent:ctor()
	return
end

function TimedChallengeCircleFightAgent:setExtId(extId)
	TimedChallengeCircleFightAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimedChallengeCircleFightAgent:sendPM_TimedChallengeCircleFightInfoReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeCircleFightExtension_pb.PM_TimedChallengeCircleFightInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightInfoRes, handler, handlerObj, errHandler)
end

function TimedChallengeCircleFightAgent:handlePM_TimedChallengeCircleFightInfoRes(status, msg)
	self:dispatch(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightInfoRes, status, msg)
end

function TimedChallengeCircleFightAgent:sendPM_TimedChallengeCircleFightReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeCircleFightExtension_pb.PM_TimedChallengeCircleFightReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightRes, handler, handlerObj, errHandler)
end

function TimedChallengeCircleFightAgent:handlePM_TimedChallengeCircleFightRes(status, msg)
	self:dispatch(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightRes, status, msg)
end

function TimedChallengeCircleFightAgent:sendPM_TimedChallengeCircleSweepReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeCircleFightExtension_pb.PM_TimedChallengeCircleSweepReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleSweepRes, handler, handlerObj, errHandler)
end

function TimedChallengeCircleFightAgent:handlePM_TimedChallengeCircleSweepRes(status, msg)
	self:dispatch(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleSweepRes, status, msg)
end

function TimedChallengeCircleFightAgent:handlePM_TimedChallengeCircleFightFinishRes(status, msg)
	self:dispatch(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleFightFinishRes, status, msg)
end

function TimedChallengeCircleFightAgent:sendPM_TimedChallengeCircleResetChallengeReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeCircleFightExtension_pb.PM_TimedChallengeCircleResetChallengeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleResetChallengeRes, handler, handlerObj, errHandler)
end

function TimedChallengeCircleFightAgent:handlePM_TimedChallengeCircleResetChallengeRes(status, msg)
	self:dispatch(TimedChallengeCircleFightAgent.PM_TimedChallengeCircleResetChallengeRes, status, msg)
end

TimedChallengeCircleFightAgent.instance = TimedChallengeCircleFightAgent.New()

return TimedChallengeCircleFightAgent
