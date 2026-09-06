-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TimedChallengeGameAgent.lua

module("logic.extensions.timedchallengegame.agent.TimedChallengeGameAgent", package.seeall)

local TimedChallengeGameAgent = class("TimedChallengeGameAgent", BaseAgent)

TimedChallengeGameAgent.PM_TimedChallengeGetInfoRes = "TimedChallengeGameAgent_PM_TimedChallengeGetInfoRes"
TimedChallengeGameAgent.PM_TimedChallengeStartGameRes = "TimedChallengeGameAgent_PM_TimedChallengeStartGameRes"
TimedChallengeGameAgent.PM_TimedChallengeEndGameRes = "TimedChallengeGameAgent_PM_TimedChallengeEndGameRes"

function TimedChallengeGameAgent:ctor()
	return
end

function TimedChallengeGameAgent:setExtId(extId)
	TimedChallengeGameAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function TimedChallengeGameAgent:sendPM_TimedChallengeGetInfoReq(challengeId, handler, handlerObj, errHandler)
	local req = TimedChallengeGameExtension_pb.PM_TimedChallengeGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeGameAgent.PM_TimedChallengeGetInfoRes, handler, handlerObj, errHandler)
end

function TimedChallengeGameAgent:handlePM_TimedChallengeGetInfoRes(status, msg)
	self:dispatch(TimedChallengeGameAgent.PM_TimedChallengeGetInfoRes, status, msg)
end

function TimedChallengeGameAgent:sendPM_TimedChallengeStartGameReq(challengeId, clientKey, handler, handlerObj, errHandler)
	local req = TimedChallengeGameExtension_pb.PM_TimedChallengeStartGameReq()

	req.challengeId = challengeId
	req.clientKey = clientKey

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeGameAgent.PM_TimedChallengeStartGameRes, handler, handlerObj, errHandler)
end

function TimedChallengeGameAgent:handlePM_TimedChallengeStartGameRes(status, msg)
	self:dispatch(TimedChallengeGameAgent.PM_TimedChallengeStartGameRes, status, msg)
end

function TimedChallengeGameAgent:sendPM_TimedChallengeEndGameReq(challengeId, dodgeTime, encryptedKey, handler, handlerObj, errHandler)
	local req = TimedChallengeGameExtension_pb.PM_TimedChallengeEndGameReq()

	req.challengeId = challengeId
	req.dodgeTime = dodgeTime
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
	self:addEventOnce(TimedChallengeGameAgent.PM_TimedChallengeEndGameRes, handler, handlerObj, errHandler)
end

function TimedChallengeGameAgent:handlePM_TimedChallengeEndGameRes(status, msg)
	self:dispatch(TimedChallengeGameAgent.PM_TimedChallengeEndGameRes, status, msg)
end

TimedChallengeGameAgent.instance = TimedChallengeGameAgent.New()

return TimedChallengeGameAgent
