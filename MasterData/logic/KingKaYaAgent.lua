-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingkaya/agent/KingKaYaAgent.lua

module("logic.extensions.kingkaya.agent.KingKaYaAgent", package.seeall)

local KingKaYaAgent = class("KingKaYaAgent", BaseAgent)

function KingKaYaAgent:sendPM_KingKaYaGetInfoReq(activityId)
	local req = KingKaYaExtension_pb.PM_KingKaYaGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingKaYaAgent:handlePM_KingKaYaGetInfoRes(status, msg)
	if status == 0 then
		KingKaYaController.instance:handlePM_KingKaYaGetInfoRes(msg)
	end
end

function KingKaYaAgent:sendPM_KingKaYaExtremeChallengeReq(activityId, stageId, form)
	local req = KingKaYaExtension_pb.PM_KingKaYaExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingKaYaAgent:handlePM_KingKaYaExtremeChallengeRes(status, msg)
	KingKaYaController.instance:handlePM_KingKaYaExtremeChallengeRes(status, msg)
end

function KingKaYaAgent:sendPM_KingKaYaResetExtremeStageReq(activityId, stageId)
	local req = KingKaYaExtension_pb.PM_KingKaYaResetExtremeStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function KingKaYaAgent:handlePM_KingKaYaResetExtremeStageRes(status, msg)
	if status == 0 then
		KingKaYaController.instance:handlePM_KingKaYaResetExtremeStageRes(msg)
	end
end

function KingKaYaAgent:sendPM_KingKaYaNormalChallengeReq(activityId, difficulty, form)
	local req = KingKaYaExtension_pb.PM_KingKaYaNormalChallengeReq()

	req.activityId = activityId
	req.difficulty = difficulty

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingKaYaAgent:handlePM_KingKaYaNormalChallengeRes(status, msg)
	KingKaYaController.instance:handlePM_KingKaYaNormalChallengeRes(status, msg)
end

function KingKaYaAgent:sendPM_KingKaYaGainProgressPrizeReq(activityId, prizeId)
	local req = KingKaYaExtension_pb.PM_KingKaYaGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function KingKaYaAgent:handlePM_KingKaYaGainProgressPrizeRes(status, msg)
	if status == 0 then
		KingKaYaController.instance:handlePM_KingKaYaGainProgressPrizeRes(msg)
	end
end

function KingKaYaAgent:handlePM_Notify_KingKaYaExtremeChallengeEndRes(status, msg)
	if status == 0 then
		KingKaYaController.instance:handlePM_Notify_KingKaYaExtremeChallengeEndRes(msg)
	end
end

function KingKaYaAgent:handlePM_Notify_KingKaYaNormalChallengeEndRes(status, msg)
	if status == 0 then
		KingKaYaController.instance:handlePM_Notify_KingKaYaNormalChallengeEndRes(msg)
	end
end

KingKaYaAgent.instance = KingKaYaAgent.New()

return KingKaYaAgent
