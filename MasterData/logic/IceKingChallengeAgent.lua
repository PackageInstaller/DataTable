-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/IceKingChallengeAgent.lua

module("logic.extensions.icekingchallenge.agent.IceKingChallengeAgent", package.seeall)

local IceKingChallengeAgent = class("IceKingChallengeAgent", BaseAgent)

function IceKingChallengeAgent:ctor()
	return
end

function IceKingChallengeAgent:setExtId(extId)
	IceKingChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function IceKingChallengeAgent:sendPM_IKCGetInfoReq(challengeId)
	local req = IceKingChallengeExtension_pb.PM_IKCGetInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCGetInfoRes(status, msg)
	if status == 0 then
		BinglingwangModel.instance:onGetInfo(msg)
	end
end

function IceKingChallengeAgent:sendPM_IKCGetChallengeInfoReq(challengeId)
	local req = IceKingChallengeExtension_pb.PM_IKCGetChallengeInfoReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCGetChallengeInfoRes(status, msg)
	if status == 0 then
		BinglingwangModel.instance:onGetChanllengeInfo(msg)
	end
end

function IceKingChallengeAgent:sendPM_IKCGainDailyPrizeReq(challengeId)
	local req = IceKingChallengeExtension_pb.PM_IKCGainDailyPrizeReq()

	req.challengeId = challengeId

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCGainDailyPrizeRes(status, msg)
	if status == 0 then
		BinglingwangModel.instance:onGetDailyPrize(msg)
	end
end

function IceKingChallengeAgent:sendPM_IKCGainProgressPrizeReq(challengeId, prizeId)
	local req = IceKingChallengeExtension_pb.PM_IKCGainProgressPrizeReq()

	req.challengeId = challengeId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCGainProgressPrizeRes(status, msg)
	if status == 0 then
		BinglingwangModel.instance:onGetProgressPrize(msg)
	end
end

function IceKingChallengeAgent:sendPM_IKCChallengeStageReq(challengeId, stage)
	local req = IceKingChallengeExtension_pb.PM_IKCChallengeStageReq()

	req.challengeId = challengeId
	req.stage = stage

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCChallengeStageRes(status, msg)
	if status == 0 then
		-- block empty
	else
		BattleFacade.instance:registerResultHandler(nil, nil)
		UIJumper.instance:clear()
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function IceKingChallengeAgent:sendPM_IKCSweepStageReq(challengeId, stage)
	local req = IceKingChallengeExtension_pb.PM_IKCSweepStageReq()

	req.challengeId = challengeId
	req.stage = stage

	self:sendMsg(req)
end

function IceKingChallengeAgent:handlePM_IKCSweepStageRes(status, msg)
	if status == 0 then
		BinglingwangModel.instance:onGetSweepStage(msg)
	end
end

function IceKingChallengeAgent:handlePM_IKCChallengeEndRes(status, msg)
	BinglingwangModel.instance:onChallengeEndRes(msg)
end

IceKingChallengeAgent.instance = IceKingChallengeAgent.New()

return IceKingChallengeAgent
