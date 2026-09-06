-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingway/agent/HolyChallengeAgent.lua

module("logic.extensions.kingway.agent.HolyChallengeAgent", package.seeall)

local HolyChallengeAgent = class("HolyChallengeAgent", BaseAgent)

HolyChallengeAgent.PM_HCGetInfoRes = "HolyChallengeAgent_PM_HCGetInfoRes"
HolyChallengeAgent.PM_HCFirstOpenFuncRes = "HolyChallengeAgent_PM_HCFirstOpenFuncRes"
HolyChallengeAgent.PM_HCFirstOpenGuardRes = "HolyChallengeAgent_PM_HCFirstOpenGuardRes"
HolyChallengeAgent.PM_HCGainDailyEnergyRes = "HolyChallengeAgent_PM_HCGainDailyEnergyRes"
HolyChallengeAgent.PM_HCSaveFormRes = "HolyChallengeAgent_PM_HCSaveFormRes"
HolyChallengeAgent.PM_HCChallengeGuardRes = "HolyChallengeAgent_PM_HCChallengeGuardRes"
HolyChallengeAgent.PM_HCTrialRes = "HolyChallengeAgent_PM_HCTrialRes"
HolyChallengeAgent.PM_HCGainFinalPrizeRes = "HolyChallengeAgent_PM_HCGainFinalPrizeRes"
HolyChallengeAgent.PM_HCGetRankInfoRes = "HolyChallengeAgent_PM_HCGetRankInfoRes"
HolyChallengeAgent.PM_HCChallengeEndRes = "HolyChallengeAgent_PM_HCChallengeEndRes"

function HolyChallengeAgent:ctor()
	return
end

function HolyChallengeAgent:setExtId(extId)
	HolyChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function HolyChallengeAgent:sendPM_HCGetInfoReq(handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCGetInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCGetInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCGetInfoRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCGetInfoRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCFirstOpenFuncReq(handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCFirstOpenFuncReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCFirstOpenFuncRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCFirstOpenFuncRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCFirstOpenFuncRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCFirstOpenGuardReq(challengId, handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCFirstOpenGuardReq()

	req.challengId = challengId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCFirstOpenGuardRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCFirstOpenGuardRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCFirstOpenGuardRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCGainDailyEnergyReq(handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCGainDailyEnergyReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCGainDailyEnergyRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCGainDailyEnergyRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCGainDailyEnergyRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCSaveFormReq(challengeId, form_pb, handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCSaveFormReq()

	req.challengeId = challengeId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCSaveFormRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCSaveFormRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCSaveFormRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCChallengeGuardReq(challengeId, stageId, handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCChallengeGuardReq()

	req.challengeId = challengeId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCChallengeGuardRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCChallengeGuardRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCChallengeGuardRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCTrialReq(times, handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCTrialReq()

	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCTrialRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCTrialRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCTrialRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCGainFinalPrizeReq(handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCGainFinalPrizeReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCGainFinalPrizeRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCGainFinalPrizeRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCGainFinalPrizeRes, status, msg)
end

function HolyChallengeAgent:sendPM_HCGetRankInfoReq(startRank, endRank, handler, handlerObj, errHandler)
	local req = HolyChallengeExtension_pb.PM_HCGetRankInfoReq()

	req.startRank = startRank
	req.endRank = endRank

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(HolyChallengeAgent.PM_HCGetRankInfoRes, handler, handlerObj, errHandler)
	end

	self:sendMsg(req)
end

function HolyChallengeAgent:handlePM_HCGetRankInfoRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCGetRankInfoRes, status, msg)
end

function HolyChallengeAgent:handlePM_HCChallengeEndRes(status, msg)
	self:dispatch(HolyChallengeAgent.PM_HCChallengeEndRes, status, msg)
end

HolyChallengeAgent.instance = HolyChallengeAgent.New()

return HolyChallengeAgent
