-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/cloudcutfan/agent/CloudCutFanAgent.lua

module("logic.extensions.cloudcutfan.agent.CloudCutFanAgent", package.seeall)

local CloudCutFanAgent = class("CloudCutFanAgent", BaseAgent)

function CloudCutFanAgent:sendPM_CloudCutFanInfoReq(activityId)
	local req = CloudCutFanExtension_pb.PM_CloudCutFanInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CloudCutFanAgent:handlePM_CloudCutFanInfoRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanInfoRes(msg)
	end
end

function CloudCutFanAgent:sendPM_CloudCutFanBossClgReq(activityId, isPreview, form_pb)
	local req = CloudCutFanExtension_pb.PM_CloudCutFanBossClgReq()

	req.activityId = activityId
	req.isPreview = isPreview

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function CloudCutFanAgent:handlePM_CloudCutFanBossClgRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanBossClgRes(msg)
	end
end

function CloudCutFanAgent:sendPM_CloudCutFanMakeFanReq(activityId, face, frame, tail)
	local req = CloudCutFanExtension_pb.PM_CloudCutFanMakeFanReq()

	req.activityId = activityId
	req.face = face
	req.frame = frame
	req.tail = tail

	self:sendMsg(req)
end

function CloudCutFanAgent:handlePM_CloudCutFanMakeFanRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanMakeFanRes(msg)
	end
end

function CloudCutFanAgent:sendPM_CloudCutFanUnLockFaceReq(activityId, faceId)
	local req = CloudCutFanExtension_pb.PM_CloudCutFanUnLockFaceReq()

	req.activityId = activityId
	req.faceId = faceId

	self:sendMsg(req)
end

function CloudCutFanAgent:handlePM_CloudCutFanUnLockFaceRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanUnLockFaceRes(msg)
	end
end

function CloudCutFanAgent:sendPM_CloudCutFanGetRewardPrizeReq(activityId)
	local req = CloudCutFanExtension_pb.PM_CloudCutFanGetRewardPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function CloudCutFanAgent:handlePM_CloudCutFanGetRewardPrizeRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanGetRewardPrizeRes(msg)
	end
end

function CloudCutFanAgent:handlePM_CloudCutFanNotifyBossClgRes(status, msg)
	if status == 0 then
		CloudCutFanController.instance:handlePM_CloudCutFanNotifyBossClgRes(msg)
	end
end

CloudCutFanAgent.instance = CloudCutFanAgent.New()

return CloudCutFanAgent
