-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekunlun/agent/DivineKunLunClgAgent.lua

module("logic.extensions.divinekunlunclg.agent.DivineKunLunClgAgent", package.seeall)

local DivineKunLunClgAgent = class("DivineKunLunClgAgent", BaseAgent)

function DivineKunLunClgAgent:sendPM_DivineKunLunClgGetInfoReq(activityId)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgGetInfoRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:onGetInfo(msg)
	end
end

function DivineKunLunClgAgent:sendPM_DivineKunLunClgNormalChallengeReq(activityId, stageArrIndex, form_pb)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgNormalChallengeReq()

	req.activityId = activityId
	req.stageArrIndex = stageArrIndex

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgNormalChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineKunLunClgAgent:sendPM_DivineKunLunClgExtremeChallengeReq(activityId, stageId, form_pb)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function DivineKunLunClgAgent:sendPM_DivineKunLunClgConfirmExtremeChallengeReq(activityId, stageId, confirm)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgConfirmExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgConfirmExtremeChallengeRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:onConfirm(msg)
	end
end

function DivineKunLunClgAgent:sendPM_DivineKunLunClgGainNormalProgressPrizeReq(activityId, prizeId)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgGainNormalProgressPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgGainNormalProgressPrizeRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:onGetNorPrize(msg)
	end
end

function DivineKunLunClgAgent:sendPM_DivineKunLunClgGainExtremePrizeReq(activityId)
	local req = DivineKunLunClgExtension_pb.PM_DivineKunLunClgGainExtremePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKunLunClgAgent:handlePM_DivineKunLunClgGainExtremePrizeRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:onGetExtPrize(msg)
	end
end

function DivineKunLunClgAgent:handlePM_Notify_DivineKunLunClgNormalChallengeRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:handleNorFightRes(msg)
	end
end

function DivineKunLunClgAgent:handlePM_Notify_DivineKunLunClgExtremeChallengeRes(status, msg)
	if status == 0 then
		DivineKunlunController.instance:handleExtFightRes(msg)
	end
end

DivineKunLunClgAgent.instance = DivineKunLunClgAgent.New()

return DivineKunLunClgAgent
