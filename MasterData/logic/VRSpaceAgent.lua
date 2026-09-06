-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/vrspace/agent/VRSpaceAgent.lua

module("logic.extensions.vrspace.agent.VRSpaceAgent", package.seeall)

local VRSpaceAgent = class("VRSpaceAgent", BaseAgent)

function VRSpaceAgent:sendPM_VRSpaceGetInfoReq(activityId)
	local req = VRSpaceExtension_pb.PM_VRSpaceGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceGetInfoRes(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetInfo(msg)
	end
end

function VRSpaceAgent:sendPM_VRSpaceSelectBuffReq(activityId, buffLv)
	local req = VRSpaceExtension_pb.PM_VRSpaceSelectBuffReq()

	req.activityId = activityId
	req.buffLv = buffLv

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceSelectBuffRes(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetSelectBuff(msg)
	end
end

function VRSpaceAgent:sendPM_VRSpaceChallengeVirtualReq(activityId, mode, stageId, form_pb)
	local req = VRSpaceExtension_pb.PM_VRSpaceChallengeVirtualReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceChallengeVirtualRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function VRSpaceAgent:sendPM_VRSpaceConfirmVirtualResultReq(activityId, mode, stageId, confirm)
	local req = VRSpaceExtension_pb.PM_VRSpaceConfirmVirtualResultReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId
	req.confirm = confirm

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceConfirmVirtualResultRes(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetVConfirm(msg)
	end
end

function VRSpaceAgent:sendPM_VRSpaceChallengeRealityReq(activityId, mode, stageId, form_pb)
	local req = VRSpaceExtension_pb.PM_VRSpaceChallengeRealityReq()

	req.activityId = activityId
	req.mode = mode
	req.stageId = stageId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceChallengeRealityRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function VRSpaceAgent:sendPM_VRSpaceResetRealityReq(activityId, mode)
	local req = VRSpaceExtension_pb.PM_VRSpaceResetRealityReq()

	req.activityId = activityId
	req.mode = mode

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceResetRealityRes(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetResetInfo(msg)
	end
end

function VRSpaceAgent:sendPM_VRSpaceGetRankInfoReq(activityId)
	local req = VRSpaceExtension_pb.PM_VRSpaceGetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VRSpaceAgent:handlePM_VRSpaceGetRankInfoRes(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetRankInfo(msg)
	end
end

function VRSpaceAgent:handlePM_Notify_VRSpaceChallengeVirtualResult(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetVFightMsg(msg)
	end
end

function VRSpaceAgent:handlePM_Notify_VRSpaceChallengeRealityResult(status, msg)
	if status == 0 then
		VRSpaceController.instance:onGetRFightMsg(msg)
	end
end

VRSpaceAgent.instance = VRSpaceAgent.New()

return VRSpaceAgent
