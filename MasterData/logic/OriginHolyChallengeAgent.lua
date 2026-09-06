-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/originholychallenge/agent/OriginHolyChallengeAgent.lua

module("logic.extensions.originholychallenge.agent.OriginHolyChallengeAgent", package.seeall)

local OriginHolyChallengeAgent = class("OriginHolyChallengeAgent", BaseAgent)

function OriginHolyChallengeAgent:sendPM_OriginHolyChallengeGetInfoReq(activityId)
	local req = OriginHolyChallengeExtension_pb.PM_OriginHolyChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function OriginHolyChallengeAgent:handlePM_OriginHolyChallengeGetInfoRes(status, msg)
	if status == 0 then
		OriginHolyChallengeController.instance:handlePM_OriginHolyChallengeGetInfoRes(msg)
	end
end

function OriginHolyChallengeAgent:sendPM_OriginHolyChallengeChallengeReq(activityId, stageId, form)
	local req = OriginHolyChallengeExtension_pb.PM_OriginHolyChallengeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function OriginHolyChallengeAgent:handlePM_OriginHolyChallengeChallengeRes(status, msg)
	if status == 0 then
		OriginHolyChallengeController.instance:handlePM_OriginHolyChallengeChallengeRes(msg)
	end
end

function OriginHolyChallengeAgent:handlePM_Notify_OriginHolyChallengeChallengeResultRes(status, msg)
	if status == 0 then
		OriginHolyChallengeController.instance:handlePM_Notify_OriginHolyChallengeChallengeResultRes(msg)
	end
end

OriginHolyChallengeAgent.instance = OriginHolyChallengeAgent.New()

return OriginHolyChallengeAgent
