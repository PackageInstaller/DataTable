-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/timelimitedchallenge/agent/TianManWangChallengeAgent.lua

module("logic.extensions.tianmanwangchallenge.agent.TianManWangChallengeAgent", package.seeall)

local TianManWangChallengeAgent = class("TianManWangChallengeAgent", BaseAgent)

function TianManWangChallengeAgent:sendPM_TMWCGetSummonsInfoReq()
	local req = TianManWangChallengeExtension_pb.PM_TMWCGetSummonsInfoReq()

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCGetSummonsInfoRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCGetSummonsInfoRes(msg)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCGetChallengeInfoReq()
	local req = TianManWangChallengeExtension_pb.PM_TMWCGetChallengeInfoReq()

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCGetChallengeInfoRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCGetChallengeInfoRes(msg)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCGetSingleChallengeInfoReq(challengeType)
	local req = TianManWangChallengeExtension_pb.PM_TMWCGetSingleChallengeInfoReq()

	req.challengeType = challengeType

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCGetSingleChallengeInfoRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCGetSingleChallengeInfoRes(msg)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCSelectSummonReq(summonId)
	local req = TianManWangChallengeExtension_pb.PM_TMWCSelectSummonReq()

	req.summonId = summonId

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCSelectSummonRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCSelectSummonRes()
	end
end

function TianManWangChallengeAgent:sendPM_TMWCGetFormReq()
	local req = TianManWangChallengeExtension_pb.PM_TMWCGetFormReq()

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCGetFormRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCGetFormRes(msg)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCSetFormReq(form)
	local req = TianManWangChallengeExtension_pb.PM_TMWCSetFormReq()

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCSetFormRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCSetForm(msg)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCChallengeStageReq(challengeType, stage)
	local req = TianManWangChallengeExtension_pb.PM_TMWCChallengeStageReq()

	req.challengeType = challengeType
	req.stage = stage

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCChallengeStageRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCChallengeStageRes()
	end
end

function TianManWangChallengeAgent:sendPM_TMWCBuyChallengeTimesReq(challengeType)
	local req = TianManWangChallengeExtension_pb.PM_TMWCBuyChallengeTimesReq()

	req.challengeType = challengeType

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCBuyChallengeTimesRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(TianmanKingController.PM_TMWCBuyChallengeTimesRes)
	end
end

function TianManWangChallengeAgent:sendPM_TMWCGainProgressPrizeReq(prizeId)
	local req = TianManWangChallengeExtension_pb.PM_TMWCGainProgressPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function TianManWangChallengeAgent:handlePM_TMWCGainProgressPrizeRes(status, msg)
	if status == 0 then
		TianmanKingController.instance:handlePM_TMWCGainProgressPrizeRes()
	end
end

function TianManWangChallengeAgent:handlePM_TMWCChallengeEndRes(status, msg)
	if status == 0 then
		if msg.challengeType == 3 then
			TLChallengeController.instance:_onTianManKingFightFinish(msg)
		elseif msg.challengeType == 2 then
			TianmanKingController.instance:onSenluoFightFinish(msg)
		end
	end
end

TianManWangChallengeAgent.instance = TianManWangChallengeAgent.New()

return TianManWangChallengeAgent
