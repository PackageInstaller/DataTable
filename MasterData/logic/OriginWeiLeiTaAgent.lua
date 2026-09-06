-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originweileita/agent/OriginWeiLeiTaAgent.lua

module("logic.extensions.originweileita.agent.OriginWeiLeiTaAgent", package.seeall)

local OriginWeiLeiTaAgent = class("OriginWeiLeiTaAgent", BaseAgent)

function OriginWeiLeiTaAgent:sendPM_OriginWeiLeiTaGetInfoReq(activityId)
	local req = OriginWeiLeiTaExtension_pb.PM_OriginWeiLeiTaGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginWeiLeiTaAgent:handlePM_OriginWeiLeiTaGetInfoRes(status, msg)
	if status == 0 then
		OriginWeiLeiTaModel.instance:setInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginWeiLeiTaGetInfoRes)
	end
end

function OriginWeiLeiTaAgent:sendPM_OriginWeiLeiTaExtremeChallengeReq(activityId, stageId, form)
	local req = OriginWeiLeiTaExtension_pb.PM_OriginWeiLeiTaExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginWeiLeiTaAgent:handlePM_OriginWeiLeiTaExtremeChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginWeiLeiTaExtremeChallengeRes)
	end
end

function OriginWeiLeiTaAgent:sendPM_OriginWeiLeiTaResetExtremeStageReq(activityId, stageId)
	local req = OriginWeiLeiTaExtension_pb.PM_OriginWeiLeiTaResetExtremeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginWeiLeiTaAgent:handlePM_OriginWeiLeiTaResetExtremeStageRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local stageId = msg.stageId

		OriginWeiLeiTaModel.instance:onResetExtremeStageRes(activityId, stageId)
		GlobalDispatcher:dispatch(GlobalNotify.OriginWeiLeiTaResetExtremeStageRes)
	end
end

function OriginWeiLeiTaAgent:sendPM_OriginWeiLeiTaNormalChallengeReq(activityId, stageId, form)
	local req = OriginWeiLeiTaExtension_pb.PM_OriginWeiLeiTaNormalChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function OriginWeiLeiTaAgent:handlePM_OriginWeiLeiTaNormalChallengeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.OriginWeiLeiTaNormalChallengeRes)
	end
end

function OriginWeiLeiTaAgent:sendPM_OriginWeiLeiTaGainProgressPrizeReq(activityId, prizeId)
	local req = OriginWeiLeiTaExtension_pb.PM_OriginWeiLeiTaGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function OriginWeiLeiTaAgent:handlePM_OriginWeiLeiTaGainProgressPrizeRes(status, msg)
	if status == 0 then
		OriginWeiLeiTaModel.instance:onGainNormalPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.OriginWeiLeiTaGainProgressPrizeRes)
	end
end

function OriginWeiLeiTaAgent:handlePM_Notify_OriginWeiLeiTaExtremePetRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginWeiLeiTaExtremePetRes)
	end
end

function OriginWeiLeiTaAgent:handlePM_Notify_OriginWeiLeiTaExtremeChallengeEndRes(status, msg)
	if status == 0 then
		OriginWeiLeiTaController.instance:onExtremeChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginWeiLeiTaExtremeChallengeEndRes)
	end
end

function OriginWeiLeiTaAgent:handlePM_Notify_OriginWeiLeiTaNormalChallengeEndRes(status, msg)
	if status == 0 then
		OriginWeiLeiTaController.instance:onNormalChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.Notify_OriginWeiLeiTaNormalChallengeEndRes)
	end
end

OriginWeiLeiTaAgent.instance = OriginWeiLeiTaAgent.New()

return OriginWeiLeiTaAgent
