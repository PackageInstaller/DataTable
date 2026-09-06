-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/neverland/agent/NeverLandAgent.lua

module("logic.extensions.neverland.agent.NeverLandAgent", package.seeall)

local NeverLandAgent = class("NeverLandAgent", BaseAgent)

function NeverLandAgent:sendPM_NeverLandInfoReq(activityId)
	local req = NeverLandExtension_pb.PM_NeverLandInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NeverLandAgent:handlePM_NeverLandInfoRes(status, msg)
	if status == 0 then
		NeverLandController.instance:handlePM_NeverLandInfoRes(status, msg)
	end
end

function NeverLandAgent:sendPM_NeverLandChallengeReq(activityId, mode, form)
	local req = NeverLandExtension_pb.PM_NeverLandChallengeReq()

	req.activityId = activityId
	req.mode = mode

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function NeverLandAgent:handlePM_NeverLandNotifyChallengeResultRes(status, msg)
	if status == 0 then
		NeverLandController.instance:handlePM_NeverLandNotifyChallengeResultRes(status, msg)
	end
end

function NeverLandAgent:handlePM_NeverLandChallengeRes(status, msg)
	return
end

function NeverLandAgent:sendPM_NeverLandUpgradeBuffLvReq(activityId, buffId)
	local req = NeverLandExtension_pb.PM_NeverLandUpgradeBuffLvReq()

	req.activityId = activityId
	req.buffId = buffId

	self:sendMsg(req)
end

function NeverLandAgent:handlePM_NeverLandUpgradeBuffLvRes(status, msg)
	if status == 0 then
		NeverLandController.instance:handlePM_NeverLandUpgradeBuffLvRes(status, msg)
	end
end

function NeverLandAgent:sendPM_NeverLandGetRankReq(activityId, mode)
	local req = NeverLandExtension_pb.PM_NeverLandGetRankReq()

	req.activityId = activityId
	req.mode = mode

	self:sendMsg(req)
end

function NeverLandAgent:handlePM_NeverLandGetRankRes(status, msg)
	if status == 0 then
		NeverLandController.instance:handlePM_NeverLandGetRankRes(status, msg)
	end
end

NeverLandAgent.instance = NeverLandAgent.New()

return NeverLandAgent
