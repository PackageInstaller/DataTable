-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/LightKingChallengeAgent.lua

module("logic.extensions.lightkingchallenge.agent.LightKingChallengeAgent", package.seeall)

local LightKingChallengeAgent = class("LightKingChallengeAgent", BaseAgent)

LightKingChallengeAgent.PM_LightKingChallengeGetInfoRes = "LightKingChallengeAgent_PM_LightKingChallengeGetInfoRes"
LightKingChallengeAgent.PM_LightKingChallengeSetFormRes = "LightKingChallengeAgent_PM_LightKingChallengeSetFormRes"
LightKingChallengeAgent.PM_LightKingChallengeGetFormRes = "LightKingChallengeAgent_PM_LightKingChallengeGetFormRes"
LightKingChallengeAgent.PM_LightKingChallengeUpgradeRes = "LightKingChallengeAgent_PM_LightKingChallengeUpgradeRes"
LightKingChallengeAgent.PM_LightKingChallengeFightRes = "LightKingChallengeAgent_PM_LightKingChallengeFightRes"
LightKingChallengeAgent.PM_LightKingChallengeGainProgressPrizeRes = "LightKingChallengeAgent_PM_LightKingChallengeGainProgressPrizeRes"
LightKingChallengeAgent.PM_LightKingChallengeBuyTimesRes = "LightKingChallengeAgent_PM_LightKingChallengeBuyTimesRes"
LightKingChallengeAgent.PM_LightKingChallengeCheatRes = "LightKingChallengeAgent_PM_LightKingChallengeCheatRes"
LightKingChallengeAgent.PM_LightKingChallengeGetRanksRes = "LightKingChallengeAgent_PM_LightKingChallengeGetRanksRes"
LightKingChallengeAgent.PM_LightKingChallengeAfterFightRes = "LightKingChallengeAgent_PM_LightKingChallengeAfterFightRes"

function LightKingChallengeAgent:ctor()
	return
end

function LightKingChallengeAgent:setExtId(extId)
	LightKingChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeGetInfoReq(handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeGetInfoReq()

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeGetInfoRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeGetInfoRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeGetInfoRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeSetFormReq(challengeType, stage, simpleForm_pb, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeSetFormReq()

	req.challengeType = challengeType
	req.stage = stage

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeSetFormRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeSetFormRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeSetFormRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeGetFormReq(challengeType, stage, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeGetFormReq()

	req.challengeType = challengeType
	req.stage = stage

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeGetFormRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeGetFormRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeGetFormRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeUpgradeReq(handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeUpgradeReq()

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeUpgradeRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeUpgradeRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeUpgradeRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeFightReq(challengeType, stage, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeFightReq()

	req.challengeType = challengeType
	req.stage = stage

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeFightRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeFightRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeFightRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeGainProgressPrizeReq(id, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeGainProgressPrizeReq()

	req.id = id

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeGainProgressPrizeRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeGainProgressPrizeRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeGainProgressPrizeRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeBuyTimesReq(challengeType, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeBuyTimesReq()

	req.challengeType = challengeType

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeBuyTimesRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeBuyTimesRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeBuyTimesRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeCheatReq(challengeType, stage, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeCheatReq()

	req.challengeType = challengeType
	req.stage = stage

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeCheatRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeCheatRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeCheatRes, status, msg)
end

function LightKingChallengeAgent:sendPM_LightKingChallengeGetRanksReq(startRank, endRank, handler, handlerObj, errHandler)
	local req = LightKingChallengeExtension_pb.PM_LightKingChallengeGetRanksReq()

	req.startRank = startRank
	req.endRank = endRank

	self:sendMsg(req)
	self:addEventOnce(LightKingChallengeAgent.PM_LightKingChallengeGetRanksRes, handler, handlerObj, errHandler)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeGetRanksRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeGetRanksRes, status, msg)
end

function LightKingChallengeAgent:handlePM_LightKingChallengeAfterFightRes(status, msg)
	self:dispatch(LightKingChallengeAgent.PM_LightKingChallengeAfterFightRes, status, msg)
end

LightKingChallengeAgent.instance = LightKingChallengeAgent.New()

return LightKingChallengeAgent
