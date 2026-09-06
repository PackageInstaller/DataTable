-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originchenclg/agent/OriginChenClgAgent.lua

module("logic.extensions.originchenclg.agent.OriginChenClgAgent", package.seeall)

local OriginChenClgAgent = class("OriginChenClgAgent", BaseAgent)

function OriginChenClgAgent:sendPM_OriginChenClgGetInfoReq(activityId)
	local req = OriginChenClgExtension_pb.PM_OriginChenClgGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginChenClgAgent:handlePM_OriginChenClgGetInfoRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_OriginChenClgGetInfoRes(msg)
	end
end

function OriginChenClgAgent:sendPM_OriginChenClgChallengeExtremeReq(activityId, stageId, form)
	local req = OriginChenClgExtension_pb.PM_OriginChenClgChallengeExtremeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginChenClgAgent:handlePM_OriginChenClgChallengeExtremeRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_OriginChenClgChallengeExtremeRes(msg)
	end
end

function OriginChenClgAgent:handlePM_Notify_OriginChenClgChallengeExtremeResultRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_Notify_OriginChenClgChallengeExtremeResultRes(msg)
	end
end

function OriginChenClgAgent:sendPM_OriginChenClgResetExtremeReq(activityId)
	local req = OriginChenClgExtension_pb.PM_OriginChenClgResetExtremeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginChenClgAgent:handlePM_OriginChenClgResetExtremeRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_OriginChenClgResetExtremeRes(msg)
	end
end

function OriginChenClgAgent:sendPM_OriginChenClgChallengeNormalReq(activityId, stageId, form)
	local req = OriginChenClgExtension_pb.PM_OriginChenClgChallengeNormalReq()

	req.activityId = activityId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginChenClgAgent:handlePM_OriginChenClgChallengeNormalRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_OriginChenClgChallengeNormalRes(msg)
	end
end

function OriginChenClgAgent:handlePM_Notify_OriginChenClgChallengeNormalResultRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_Notify_OriginChenClgChallengeNormalResultRes(msg)
	end
end

function OriginChenClgAgent:sendPM_OriginChenClgConfirmExtremeReq(activityId, stageId, confirm)
	local req = OriginChenClgExtension_pb.PM_OriginChenClgConfirmExtremeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function OriginChenClgAgent:handlePM_OriginChenClgConfirmExtremeRes(status, msg)
	if status == 0 then
		OriginChenClgController.instance:handlePM_OriginChenClgConfirmExtremeRes(msg)
	end
end

OriginChenClgAgent.instance = OriginChenClgAgent.New()

return OriginChenClgAgent
