-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/rankverify/agent/VerificationTaskPrizeAgent.lua

module("logic.extensions.rankverify.agent.VerificationTaskPrizeAgent", package.seeall)

local VerificationTaskPrizeAgent = class("VerificationTaskPrizeAgent", BaseAgent)

function VerificationTaskPrizeAgent:sendPM_VerificationTaskPrizeGetInfoReq(activityId)
	local req = VerificationTaskPrizeExtension_pb.PM_VerificationTaskPrizeGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function VerificationTaskPrizeAgent:handlePM_VerificationTaskPrizeGetInfoRes(status, msg)
	if status == 0 then
		RankVerifyController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.RankVerifyError, status)
	end
end

function VerificationTaskPrizeAgent:sendPM_VerificationTaskPrizeVerifyTaskReq(activityId, taskId)
	local req = VerificationTaskPrizeExtension_pb.PM_VerificationTaskPrizeVerifyTaskReq()

	req.activityId = activityId
	req.taskId = taskId

	self:sendMsg(req)
end

function VerificationTaskPrizeAgent:handlePM_VerificationTaskPrizeVerifyTaskRes(status, msg)
	if status == 0 then
		RankVerifyController.instance:handleVerifyTask(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.RankVerifyError, status)
	end
end

function VerificationTaskPrizeAgent:sendPM_VerificationTaskPrizeGainPrizeReq(activityId, prizeId)
	local req = VerificationTaskPrizeExtension_pb.PM_VerificationTaskPrizeGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function VerificationTaskPrizeAgent:handlePM_VerificationTaskPrizeGainPrizeRes(status, msg)
	if status == 0 then
		RankVerifyController.instance:handleGainPrize(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.RankVerifyError, status)
	end
end

VerificationTaskPrizeAgent.instance = VerificationTaskPrizeAgent.New()

return VerificationTaskPrizeAgent
