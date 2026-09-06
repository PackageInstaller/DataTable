-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kunlunchallenge/agent/KunLunChallengeAgent.lua

module("logic.extensions.kunlunchallenge.agent.KunLunChallengeAgent", package.seeall)

local KunLunChallengeAgent = class("KunLunChallengeAgent", BaseAgent)

function KunLunChallengeAgent:sendPM_KunLunCommonClgInfoReq(activityId)
	local req = KunLunChallengeExtension_pb.PM_KunLunCommonClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunCommonClgInfoRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_KunLunCommonClgInfoRes(msg)
	end
end

function KunLunChallengeAgent:sendPM_KunLunCommonClgFightReq(activityId, form)
	local req = KunLunChallengeExtension_pb.PM_KunLunCommonClgFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunCommonClgFightRes(status, msg)
	KunLunChallengeController.instance:handlePM_KunLunCommonClgFightRes(status, msg)
end

function KunLunChallengeAgent:handlePM_NotifyKunLunCommonClgFightEndRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_NotifyKunLunCommonClgFightEndRes(msg)
	end
end

function KunLunChallengeAgent:sendPM_KunLunExtremeClgInfoReq(activityId)
	local req = KunLunChallengeExtension_pb.PM_KunLunExtremeClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunExtremeClgInfoRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_KunLunExtremeClgInfoRes(msg)
	end
end

function KunLunChallengeAgent:sendPM_KunLunExtremeClgSetCardReq(activityId, stageId, cardIds)
	local req = KunLunChallengeExtension_pb.PM_KunLunExtremeClgSetCardReq()

	req.activityId = activityId
	req.stageId = stageId

	for idx, v in ipairs(cardIds) do
		req.cardIds:append(v)
	end

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunExtremeClgSetCardRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_KunLunExtremeClgSetCardRes(msg)
	end
end

function KunLunChallengeAgent:sendPM_KunLunExtremeClgResetStageReq(activityId, stageId)
	local req = KunLunChallengeExtension_pb.PM_KunLunExtremeClgResetStageReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunExtremeClgResetStageRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_KunLunExtremeClgResetStageRes(msg)
	end
end

function KunLunChallengeAgent:sendPM_KunLunExtremeClgFightReq(activityId, stageId, form)
	local req = KunLunChallengeExtension_pb.PM_KunLunExtremeClgFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KunLunChallengeAgent:handlePM_KunLunExtremeClgFightRes(status, msg)
	KunLunChallengeController.instance:handlePM_KunLunExtremeClgFightRes(status, msg)
end

function KunLunChallengeAgent:handlePM_NotifyKunLunExtremeClgFightEndRes(status, msg)
	if status == 0 then
		KunLunChallengeController.instance:handlePM_NotifyKunLunExtremeClgFightEndRes(msg)
	end
end

KunLunChallengeAgent.instance = KunLunChallengeAgent.New()

return KunLunChallengeAgent
