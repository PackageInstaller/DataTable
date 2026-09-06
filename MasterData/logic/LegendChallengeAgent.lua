-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/legend/agent/LegendChallengeAgent.lua

module("logic.extensions.legendchallenge.agent.LegendChallengeAgent", package.seeall)

local LegendChallengeAgent = class("LegendChallengeAgent", BaseAgent)

LegendChallengeAgent.PM_ChallengeProcessInfoRes = "LegendChallengeAgent_PM_ChallengeProcessInfoRes"
LegendChallengeAgent.PM_LegendChallengeInfoRes = "LegendChallengeAgent_PM_LegendChallengeInfoRes"
LegendChallengeAgent.PM_ChallengeRes = "LegendChallengeAgent_PM_ChallengeRes"
LegendChallengeAgent.PM_BuyIndependentTimesRes = "LegendChallengeAgent_PM_BuyIndependentTimesRes"
LegendChallengeAgent.SweepsByTimesRes = "LegendChallengeAgent_SweepsByTimesRes"
LegendChallengeAgent.SweepAutoRes = "LegendChallengeAgent_SweepAutoRes"
LegendChallengeAgent.LegendChallengeTimesInfoRes = "LegendChallengeAgent_LegendChallengeTimesInfoRes"
LegendChallengeAgent.NotifyAfterChallengeRes = "LegendChallengeAgent_NotifyAfterChallengeRes"
LegendChallengeAgent.LegendChallengeTreasureInfoRes = "LegendChallengeAgent_LegendChallengeTreasureInfoRes"
LegendChallengeAgent.LegendChallengeGainTreasureRes = "LegendChallengeAgent_LegendChallengeGainTreasureRes"
LegendChallengeAgent.LegendChallengeSetFormRes = "LegendChallengeAgent_LegendChallengeSetFormRes"
LegendChallengeAgent.LegendChallengeFormRes = "LegendChallengeAgent_LegendChallengeFormRes"

function LegendChallengeAgent:ctor()
	return
end

function LegendChallengeAgent:setExtId(extId)
	LegendChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function LegendChallengeAgent:sendPM_ChallengeProcessInfoReq(handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.PM_ChallengeProcessInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.PM_ChallengeProcessInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handlePM_ChallengeProcessInfoRes(status, msg)
	forcePrint("LegendChallengeAgent:handlePM_ChallengeProcessInfoRes===", status)
	self:dispatch(LegendChallengeAgent.PM_ChallengeProcessInfoRes, status, msg)
end

function LegendChallengeAgent:sendPM_LegendChallengeInfoReq(challengeId, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.PM_LegendChallengeInfoReq()

	req.challengeId = challengeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.PM_LegendChallengeInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handlePM_LegendChallengeInfoRes(status, msg)
	self:dispatch(LegendChallengeAgent.PM_LegendChallengeInfoRes, status, msg)
end

function LegendChallengeAgent:sendPM_ChallengeReq(challengeId, stageId, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.PM_ChallengeReq()

	req.challengeId = challengeId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.PM_ChallengeRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handlePM_ChallengeRes(status, msg)
	self:dispatch(LegendChallengeAgent.PM_ChallengeRes, status, msg)
end

function LegendChallengeAgent:sendPM_BuyIndependentTimesReq(challengeId, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.PM_BuyIndependentTimesReq()

	req.challengeId = challengeId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.PM_BuyIndependentTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handlePM_BuyIndependentTimesRes(status, msg)
	self:dispatch(LegendChallengeAgent.PM_BuyIndependentTimesRes, status, msg)
end

function LegendChallengeAgent:sendSweepsByTimesReq(challengeId, times, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.SweepsByTimesReq()

	req.challengeId = challengeId
	req.times = times

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.SweepsByTimesRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleSweepsByTimesRes(status, msg)
	self:dispatch(LegendChallengeAgent.SweepsByTimesRes, status, msg)
end

function LegendChallengeAgent:sendSweepAutoReq(challengeId, materialType, materialId, num, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.SweepAutoReq()

	req.challengeId = challengeId
	req.materialType = materialType
	req.materialId = materialId
	req.num = num

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.SweepAutoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleSweepAutoRes(status, msg)
	self:dispatch(LegendChallengeAgent.SweepAutoRes, status, msg)
end

function LegendChallengeAgent:sendLegendChallengeTimesInfoReq(challengeIds_i32_Ary, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.LegendChallengeTimesInfoReq()

	for i, v1 in ipairs(challengeIds_i32_Ary) do
		req.challengeIds:append(v1)
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.LegendChallengeTimesInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleLegendChallengeTimesInfoRes(status, msg)
	self:dispatch(LegendChallengeAgent.LegendChallengeTimesInfoRes, status, msg)
end

function LegendChallengeAgent:handleNotifyAfterChallengeRes(status, msg)
	self:dispatch(LegendChallengeAgent.NotifyAfterChallengeRes, status, msg)
end

function LegendChallengeAgent:sendLegendChallengeTreasureInfoReq(handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.LegendChallengeTreasureInfoReq()

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.LegendChallengeTreasureInfoRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleLegendChallengeTreasureInfoRes(status, msg)
	self:dispatch(LegendChallengeAgent.LegendChallengeTreasureInfoRes, status, msg)
end

function LegendChallengeAgent:sendLegendChallengeGainTreasureReq(id, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.LegendChallengeGainTreasureReq()

	req.id = id

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.LegendChallengeGainTreasureRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleLegendChallengeGainTreasureRes(status, msg)
	self:dispatch(LegendChallengeAgent.LegendChallengeGainTreasureRes, status, msg)
end

function LegendChallengeAgent:sendLegendChallengeSetFormReq(challengeId, stageId, simpleForm_pb, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.LegendChallengeSetFormReq()

	req.challengeId = challengeId
	req.stageId = stageId

	if simpleForm_pb ~= nil then
		req.simpleForm:ParseFromString(simpleForm_pb:SerializeToString())
	end

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.LegendChallengeSetFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleLegendChallengeSetFormRes(status, msg)
	self:dispatch(LegendChallengeAgent.LegendChallengeSetFormRes, status, msg)
end

function LegendChallengeAgent:sendLegendChallengeFormReq(challengeId, stageId, handler, handlerObj, errHandler)
	local req = LegendChallengeExtension_pb.LegendChallengeFormReq()

	req.challengeId = challengeId
	req.stageId = stageId

	if not MsgFlowMgr.instance:isBlocked(req._cname) then
		self:addEventOnce(LegendChallengeAgent.LegendChallengeFormRes, handler, handlerObj, errHandler)
		self:sendMsg(req)
	end
end

function LegendChallengeAgent:handleLegendChallengeFormRes(status, msg)
	self:dispatch(LegendChallengeAgent.LegendChallengeFormRes, status, msg)
end

LegendChallengeAgent.instance = LegendChallengeAgent.New()

return LegendChallengeAgent
