-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/MoYanChallengeAgent.lua

module("logic.extensions.moyanchallenge.agent.MoYanChallengeAgent", package.seeall)

local MoYanChallengeAgent = class("MoYanChallengeAgent", BaseAgent)

function MoYanChallengeAgent:ctor()
	return
end

function MoYanChallengeAgent:setExtId(extId)
	MoYanChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function MoYanChallengeAgent:sendPM_MYCGetProgressInfoReq(challengeId)
	local req = MoYanChallengeExtension_pb.PM_MYCGetProgressInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCGetProgressInfoRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onGetInfo(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCGetChallengeInfoReq(challengeId)
	local req = MoYanChallengeExtension_pb.PM_MYCGetChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCGetChallengeInfoRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onGetBattleEnterInfo(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCGetSingleChallengeInfoReq(challengeId, challengeType)
	local req = MoYanChallengeExtension_pb.PM_MYCGetSingleChallengeInfoReq()

	req.challengeId = challengeId
	req.challengeType = challengeType

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCGetSingleChallengeInfoRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onSingleChanllengeInfo(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCGainProgressPrizeReq(challengeId, prizeId)
	local req = MoYanChallengeExtension_pb.PM_MYCGainProgressPrizeReq()

	req.challengeId = challengeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCGainProgressPrizeRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onGetProgressPrize(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCSweepReq(challengeId, challengeType)
	local req = MoYanChallengeExtension_pb.PM_MYCSweepReq()

	req.challengeId = challengeId
	req.challengeType = challengeType

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCSweepRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onGetSweepStage(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCChallengeStageReq(challengeId, challengeType, stage, form_pb)
	local req = MoYanChallengeExtension_pb.PM_MYCChallengeStageReq()

	req.challengeId = challengeId
	req.challengeType = challengeType
	req.stage = stage

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCChallengeStageRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function MoYanChallengeAgent:sendPM_MYCResetChallengeReq(challengeId, challengeType)
	local req = MoYanChallengeExtension_pb.PM_MYCResetChallengeReq()

	req.challengeId = challengeId
	req.challengeType = challengeType

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCResetChallengeRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onResetChallenge(msg)
	end
end

function MoYanChallengeAgent:sendPM_MYCBuyChallengeTimesReq(challengeId, challengeType)
	local req = MoYanChallengeExtension_pb.PM_MYCBuyChallengeTimesReq()

	req.challengeId = challengeId
	req.challengeType = challengeType

	self:sendMsg(req)
end

function MoYanChallengeAgent:handlePM_MYCBuyChallengeTimesRes(status, msg)
	if status == 0 then
		MoyanModel.instance:onRecBuyTimes(msg)
	end
end

function MoYanChallengeAgent:handlePM_MYCChallengeEndRes(status, msg)
	MoyanModel.instance:onChallengeEndRes(msg)
end

MoYanChallengeAgent.instance = MoYanChallengeAgent.New()

return MoYanChallengeAgent
