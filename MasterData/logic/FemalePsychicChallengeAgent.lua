-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/femalepsychic/agent/FemalePsychicChallengeAgent.lua

module("logic.extensions.femalepsychic.agent.FemalePsychicChallengeAgent", package.seeall)

local FemalePsychicChallengeAgent = class("FemalePsychicChallengeAgent", BaseAgent)

function FemalePsychicChallengeAgent:sendPM_FemalePsychicChallengeInfoReq(activityId)
	local req = FemalePsychicChallengeExtension_pb.PM_FemalePsychicChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FemalePsychicChallengeAgent:handlePM_FemalePsychicChallengeInfoRes(status, msg)
	if status == 0 then
		FemalePsychicController.instance:handlePM_FemalePsychicChallengeInfoRes(status, msg)
	end
end

function FemalePsychicChallengeAgent:sendPM_FemalePsychicChallengeReq(activityId, challengeId, stageId, form)
	local req = FemalePsychicChallengeExtension_pb.PM_FemalePsychicChallengeReq()

	req.activityId = activityId
	req.challengeId = challengeId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FemalePsychicChallengeAgent:handlePM_FemalePsychicChallengeRes(status, msg)
	FemalePsychicController.instance:handlePM_FemalePsychicChallengeRes(status, msg)
end

function FemalePsychicChallengeAgent:sendPM_FemalePsychicChallengeConformResultReq(activityId, conform)
	local req = FemalePsychicChallengeExtension_pb.PM_FemalePsychicChallengeConformResultReq()

	req.activityId = activityId
	req.conform = conform

	self:sendMsg(req)
end

function FemalePsychicChallengeAgent:handlePM_FemalePsychicChallengeConformResultRes(status, msg)
	if status == 0 then
		FemalePsychicController.instance:handlePM_FemalePsychicChallengeConformResultRes(status, msg)
	end
end

function FemalePsychicChallengeAgent:handlePM_NotifyFemalePsychicChallengeFinishRes(status, msg)
	if status == 0 then
		FemalePsychicController.instance:handlePM_NotifyFemalePsychicChallengeFinishRes(status, msg)
	end
end

function FemalePsychicChallengeAgent:sendPM_FemalePsychicChallengeUpgradeSignInBuffReq(activityId)
	local req = FemalePsychicChallengeExtension_pb.PM_FemalePsychicChallengeUpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FemalePsychicChallengeAgent:handlePM_FemalePsychicChallengeUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		local activityId = msg.activityId
		local signInBuffLv = msg.signInBuffLv

		FemalePsychicModel.instance:onUpdateBuffLv(activityId, signInBuffLv)
		GlobalDispatcher:dispatch(GlobalNotify.FemalePsychicChallengeUpgradeSignInBuffRes)
	end
end

FemalePsychicChallengeAgent.instance = FemalePsychicChallengeAgent.New()

return FemalePsychicChallengeAgent
