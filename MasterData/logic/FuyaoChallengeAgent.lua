-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/fuyao/agent/FuyaoChallengeAgent.lua

module("logic.extensions.fuyaochallenge.agent.FuyaoChallengeAgent", package.seeall)

local FuyaoChallengeAgent = class("FuyaoChallengeAgent", BaseAgent)

function FuyaoChallengeAgent:sendPM_FuyaoGetInfoReq(activityId)
	local req = FuyaoChallengeExtension_pb.PM_FuyaoGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FuyaoChallengeAgent:handlePM_FuyaoGetInfoRes(status, msg)
	if status == 0 then
		FuYaoController.instance:handlePM_FuyaoGetInfoRes(status, msg)
	end
end

function FuyaoChallengeAgent:sendPM_FuyaoCommonChallengeReq(activityId, puzzleId, form)
	local req = FuyaoChallengeExtension_pb.PM_FuyaoCommonChallengeReq()

	req.activityId = activityId
	req.puzzleId = puzzleId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FuyaoChallengeAgent:handlePM_FuyaoCommonChallengeRes(status, msg)
	FuYaoController.instance:handlePM_FuyaoCommonChallengeRes(status, msg)
end

function FuyaoChallengeAgent:handlePM_FuyaoNotifyCommonChallengeResultRes(status, msg)
	if status == 0 then
		FuYaoController.instance:handlePM_FuyaoNotifyCommonChallengeResultRes(status, msg)
	end
end

function FuyaoChallengeAgent:sendPM_FuyaoExtremeChallengeReq(activityId, stageId, form)
	local req = FuyaoChallengeExtension_pb.PM_FuyaoExtremeChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FuyaoChallengeAgent:handlePM_FuyaoExtremeChallengeRes(status, msg)
	FuYaoController.instance:handlePM_FuyaoExtremeChallengeRes(status, msg)
end

function FuyaoChallengeAgent:handlePM_FuyaoNotifyExtremeChallengeResultRes(status, msg)
	if status == 0 then
		FuYaoController.instance:handlePM_FuyaoNotifyExtremeChallengeResultRes(status, msg)
	end
end

FuyaoChallengeAgent.instance = FuyaoChallengeAgent.New()

return FuyaoChallengeAgent
