-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/farnas/agent/FarnasChallengeAgent.lua

module("logic.extensions.farnaschallenge.agent.FarnasChallengeAgent", package.seeall)

local FarnasChallengeAgent = class("FarnasChallengeAgent", BaseAgent)

function FarnasChallengeAgent:sendPM_FarnasClgGetInfoReq(activityId)
	local req = FarnasChallengeExtension_pb.PM_FarnasClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasClgGetInfoRes(status, msg)
	if status == 0 then
		FarnasController.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgGetInfoRes)
	end
end

function FarnasChallengeAgent:sendPM_FarnasClgExtremeFightReq(activityId, stageId, form)
	local req = FarnasChallengeExtension_pb.PM_FarnasClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasClgExtremeFightRes(status, msg)
	if status == 0 then
		FarnasController.instance:handlePM_FarnasClgExtremeFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgExtremeFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FarnasChallengeAgent:handlePM_FarnasClgNotifyExtremeFightResultRes(status, msg)
	if status == 0 then
		FarnasController.instance:handlePM_FarnasClgNotifyExtremeFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgNotifyExtremeFightResultRes)
	end
end

function FarnasChallengeAgent:sendPM_FarnasClgResetExtremeClgReq(activityId, stageId)
	local req = FarnasChallengeExtension_pb.PM_FarnasClgResetExtremeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasClgResetExtremeClgRes(status, msg)
	if status == 0 then
		FarnasModel.instance:resetExtremeClg(msg.activityId, msg.stageId)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgResetExtremeClgRes)
	end
end

function FarnasChallengeAgent:sendPM_FarnasClgGainExtremePrizeReq(activityId)
	local req = FarnasChallengeExtension_pb.PM_FarnasClgGainExtremePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasClgGainExtremePrizeRes(status, msg)
	if status == 0 then
		FarnasController.instance:gainExtremeClgPrize(msg.activityId)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgGainExtremePrizeRes)
	end
end

function FarnasChallengeAgent:sendPM_FarnasClgNormalFightReq(activityId, dataBitId, form)
	local req = FarnasChallengeExtension_pb.PM_FarnasClgNormalFightReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasClgNormalFightRes(status, msg)
	if status == 0 then
		FarnasController.instance:handlePM_FarnasClgNormalFightRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgNormalFightRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FarnasChallengeAgent:handlePM_FarnasClgNotifyNormalFightResultRes(status, msg)
	if status == 0 then
		FarnasController.instance:handlePM_FarnasClgNotifyNormalFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasClgNotifyNormalFightResultRes)
	end
end

function FarnasChallengeAgent:sendPM_FarnasGainNormalClgProgressPrizeReq(activityId, dataBitId)
	local req = FarnasChallengeExtension_pb.PM_FarnasGainNormalClgProgressPrizeReq()

	req.activityId = activityId
	req.dataBitId = dataBitId

	self:sendMsg(req)
end

function FarnasChallengeAgent:handlePM_FarnasGainNormalClgProgressPrizeRes(status, msg)
	if status == 0 then
		FarnasController.instance:gainNormalClgPrize(msg.activityId, msg.dataBitId)
		GlobalDispatcher:dispatch(GlobalNotify.FarnasGainNormalClgProgressPrizeRes)
	end
end

FarnasChallengeAgent.instance = FarnasChallengeAgent.New()

return FarnasChallengeAgent
