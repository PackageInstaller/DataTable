-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originpowersclg/agent/OriginPowersClgAgent.lua

module("logic.extensions.originpowersclg.agent.OriginPowersClgAgent", package.seeall)

local OriginPowersClgAgent = class("OriginPowersClgAgent", BaseAgent)

function OriginPowersClgAgent:sendPM_OriginPowersExtremeInfoReq(activityId)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersExtremeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersExtremeInfoRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_OriginPowersExtremeInfoRes(msg)
	end
end

function OriginPowersClgAgent:sendPM_OriginPowersExtremeChallengeReq(activityId, stageId, form)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersExtremeChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginPowersClgAgent:handlePM_NotifyOriginPowersExtremeClgFinishRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_NotifyOriginPowersExtremeClgFinishRes(msg)
	end
end

function OriginPowersClgAgent:sendPM_OriginPowersExtremeResetReq(activityId, stageId)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersExtremeResetReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersExtremeResetRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_OriginPowersExtremeResetRes(msg)
	end
end

function OriginPowersClgAgent:sendPM_OriginPowersCommonInfoReq(activityId)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersCommonInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersCommonInfoRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_OriginPowersCommonInfoRes(msg)
	end
end

function OriginPowersClgAgent:sendPM_OriginPowersCommonFightReq(activityId, indexId, form)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersCommonFightReq()

	req.activityId = activityId
	req.indexId = indexId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersCommonFightRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function OriginPowersClgAgent:handlePM_NotifyPM_OriginPowersCommonClgFinishRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_NotifyPM_OriginPowersCommonClgFinishRes(msg)
	end
end

function OriginPowersClgAgent:sendPM_OriginPowersCommonGainPrizeReq(activityId, prizeId)
	local req = OriginPowersClgExtension_pb.PM_OriginPowersCommonGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function OriginPowersClgAgent:handlePM_OriginPowersCommonGainPrizeRes(status, msg)
	if status == 0 then
		OriginPowersClgController.instance:handlePM_OriginPowersCommonGainPrizeRes(msg)
	end
end

OriginPowersClgAgent.instance = OriginPowersClgAgent.New()

return OriginPowersClgAgent
