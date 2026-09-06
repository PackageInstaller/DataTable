-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/dodragonchallenge/agent/DisorderDragonChallengeAgent.lua

module("logic.extensions.dodragonchallenge.agent.DisorderDragonChallengeAgent", package.seeall)

local DisorderDragonChallengeAgent = class("DisorderDragonChallengeAgent", BaseAgent)

function DisorderDragonChallengeAgent:sendPM_DisorderDragonChallengeGetInfoReq(activityId)
	local req = DisorderDragonChallengeExtension_pb.PM_DisorderDragonChallengeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DisorderDragonChallengeAgent:handlePM_DisorderDragonChallengeGetInfoRes(status, msg)
	if status == 0 then
		DoDragonChallengeController.instance:handlePM_DisorderDragonChallengeGetInfoRes(msg)
	end
end

function DisorderDragonChallengeAgent:sendPM_DisorderDragonChallengeAllReq(activityId, challengeId, form)
	local req = DisorderDragonChallengeExtension_pb.PM_DisorderDragonChallengeAllReq()

	req.activityId = activityId
	req.challengeId = challengeId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DisorderDragonChallengeAgent:handlePM_DisorderDragonChallengeAllRes(status, msg)
	DoDragonChallengeController.instance:handlePM_DisorderDragonChallengeAllRes(status, msg)
end

function DisorderDragonChallengeAgent:sendPM_DisorderDragonChallengeExtremeReq(activityId, isTry, form)
	local req = DisorderDragonChallengeExtension_pb.PM_DisorderDragonChallengeExtremeReq()

	req.activityId = activityId
	req.isTry = isTry

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DisorderDragonChallengeAgent:handlePM_DisorderDragonChallengeExtremeRes(status, msg)
	DoDragonChallengeController.instance:handlePM_DisorderDragonChallengeExtremeRes(status, msg)
end

function DisorderDragonChallengeAgent:handlePM_DisorderDragonChallengeAllResultRes(status, msg)
	if status == 0 then
		DoDragonChallengeController.instance:handlePM_DisorderDragonChallengeAllResultRes(msg)
	end
end

function DisorderDragonChallengeAgent:handlePM_DisorderDragonChallengeExtremeResultRes(status, msg)
	if status == 0 then
		DoDragonChallengeController.instance:handlePM_DisorderDragonChallengeExtremeResultRes(msg)
	end
end

DisorderDragonChallengeAgent.instance = DisorderDragonChallengeAgent.New()

return DisorderDragonChallengeAgent
