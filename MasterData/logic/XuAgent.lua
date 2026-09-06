-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/xuchallenge/agent/XuAgent.lua

module("logic.extensions.xuchallenge.agent.XuAgent", package.seeall)

local XuAgent = class("XuAgent", BaseAgent)

function XuAgent:sendPM_XuChallengeInfoReq(activityId)
	local req = XuChallengeExtension_pb.PM_XuChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XuAgent:handlePM_XuChallengeInfoRes(status, msg)
	if status == 0 then
		XuChallengeController.instance:handlePM_XuChallengeInfoRes(msg)
	end
end

function XuAgent:sendPM_XuChallengeClgReq(activityId, stageId, stageToPetId, form)
	local req = XuChallengeExtension_pb.PM_XuChallengeClgReq()

	req.activityId = activityId
	req.stageId = stageId

	for _, v in ipairs(stageToPetId or {}) do
		local pair = req.stageToPetId:add()

		pair.left = v.stageId
		pair.right = v.petId
	end

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function XuAgent:handlePM_XuChallengeClgRes(status, msg)
	if status == 0 then
		XuChallengeController.instance:handlePM_XuChallengeClgRes(msg)
	end
end

function XuAgent:handlePM_XuChallengeNotifyClgRes(status, msg)
	if status == 0 then
		XuChallengeController.instance:handlePM_XuChallengeNotifyClgRes(msg)
	end
end

function XuAgent:sendPM_XuChallengeResetReq(activityId)
	local req = XuChallengeExtension_pb.PM_XuChallengeResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function XuAgent:handlePM_XuChallengeResetRes(status, msg)
	if status == 0 then
		XuChallengeController.instance:handlePM_XuChallengeResetRes(msg)
	end
end

function XuAgent:sendPM_XuChallengeReplacePetReq(activityId, stageToPetId)
	local req = XuChallengeExtension_pb.PM_XuChallengeReplacePetReq()

	req.activityId = activityId

	for _, v in ipairs(stageToPetId or {}) do
		local pair = req.stageToPetId:add()

		pair.left = v.stageId
		pair.right = v.petId
	end

	self:sendMsg(req)
end

function XuAgent:handlePM_XuChallengeReplacePetRes(status, msg)
	if status == 0 then
		XuChallengeController.instance:handlePM_XuChallengeReplacePetRes(msg)
	end
end

XuAgent.instance = XuAgent.New()

return XuAgent
