-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/newsummonpetobtain/agent/NewSummonPetObtainAgent.lua

module("logic.extensions.newsummonpetobtain.agent.NewSummonPetObtainAgent", package.seeall)

local NewSummonPetObtainAgent = class("NewSummonPetObtainAgent", BaseAgent)

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGetInfoReq(activityId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGetInfoRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGetInfoRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGainPrizeReq(activityId, prizeId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGainPrizeRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGainPrizeRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGetPlayerInfoReq(activityId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGetPlayerInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGetPlayerInfoRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGetPlayerInfoRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGameEndReq(activityId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGameEndReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGameEndRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGameEndRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGainTaskScoreReq(activityId, taskId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGainTaskScoreReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGainTaskScoreRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGainTaskScoreRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGetBalanceTierReq(activityId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGetBalanceTierReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGetBalanceTierRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGetBalanceTierRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainGetBalanceInfoReq(activityId, stageId)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainGetBalanceInfoReq()

	req.activityId = activityId
	req.stageId = stageId

	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainGetBalanceInfoRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainGetBalanceInfoRes(msg)
	end
end

function NewSummonPetObtainAgent:sendPM_NewSummonPetObtainChallengeReq(activityId, stageId, isBlack, form)
	local req = NewSummonPetObtainExtension_pb.PM_NewSummonPetObtainChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.isBlack = isBlack

	req.form:ParseFromString(form:SerializeToString())
	self:sendMsg(req)
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainChallengeRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainChallengeRes(msg)
	end
end

function NewSummonPetObtainAgent:handlePM_NewSummonPetObtainChallengeResultRes(status, msg)
	if status == 0 then
		NewSummonPetObtainController.instance:handlePM_NewSummonPetObtainChallengeResultRes(msg)
	end
end

NewSummonPetObtainAgent.instance = NewSummonPetObtainAgent.New()

return NewSummonPetObtainAgent
