-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originkingmengmengclg/agent/OriginKingMengMengClgAgent.lua

module("logic.extensions.originkingmengmengclg.agent.OriginKingMengMengClgAgent", package.seeall)

local OriginKingMengMengClgAgent = class("OriginKingMengMengClgAgent", BaseAgent)

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgGetInfoReq(activityId)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgGetInfoRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgGetInfoRes(msg)
	end
end

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgExtremeFightReq(activityId, stageId, form)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgExtremeFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgExtremeFightRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgExtremeFightRes(msg)
	end
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgExtremeFightNotifyRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgExtremeFightNotifyRes(msg)
	end
end

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgBossFightReq(activityId, form)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgBossFightReq()

	req.activityId = activityId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgBossFightRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgBossFightRes(msg)
	end
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgBossFightNotifyRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgBossFightNotifyRes(msg)
	end
end

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgConfirmReq(activityId, stageId, save)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgConfirmReq()

	req.activityId = activityId
	req.stageId = stageId
	req.save = save

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgConfirmRes(status, msg)
	OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgConfirmRes(status, msg)
end

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgNormalFightReq(activityId, stageId, form)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgNormalFightReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgNormalFightRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgNormalFightRes(msg)
	end
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgNormalFightNotifyRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgNormalFightNotifyRes(msg)
	end
end

function OriginKingMengMengClgAgent:sendPM_OriginKingMengMengClgResetReq(activityId, stageId)
	local req = OriginKingMengMengClgExtension_pb.PM_OriginKingMengMengClgResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginKingMengMengClgAgent:handlePM_OriginKingMengMengClgResetRes(status, msg)
	if status == 0 then
		OriginKingMengMengClgController.instance:handlePM_OriginKingMengMengClgResetRes(msg)
	end
end

OriginKingMengMengClgAgent.instance = OriginKingMengMengClgAgent.New()

return OriginKingMengMengClgAgent
