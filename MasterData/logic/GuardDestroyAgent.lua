-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guarddestroy/agent/GuardDestroyAgent.lua

module("logic.extensions.guarddestroy.agent.GuardDestroyAgent", package.seeall)

local GuardDestroyAgent = class("GuardDestroyAgent", BaseAgent)

function GuardDestroyAgent:sendPM_GuardDestroyGetInfoReq(activityId)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyGetInfoRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyGetInfoRes(msg)
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyChallengeReq(activityId, stageId, stageType, form)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.stageType = stageType

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyConfirmChallengeResultReq(activityId, stageId, stageType, replace)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyConfirmChallengeResultReq()

	req.activityId = activityId
	req.stageId = stageId
	req.stageType = stageType
	req.replace = replace

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyConfirmChallengeResultRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyConfirmChallengeResultRes(msg)
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyGainBalancePrizeReq(activityId)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyGainBalancePrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyGainBalancePrizeRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyGainBalancePrizeRes(msg)
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyGainProgressPrizeReq(activityId, stageType, prizeId)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyGainProgressPrizeReq()

	req.activityId = activityId
	req.stageType = stageType
	req.prizeId = prizeId

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyGainProgressPrizeRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyGainProgressPrizeRes(msg)
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyGetRankViewReq(activityId)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyGetRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyGetRankViewRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyGetRankViewRes(msg)
	end
end

function GuardDestroyAgent:handlePM_Notify_GuardDestroyChallengeRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_Notify_GuardDestroyChallengeRes(msg)
	end
end

function GuardDestroyAgent:sendPM_GuardDestroyUpgradeSignInBuffReq(activityId)
	local req = GuardDestroyExtension_pb.PM_GuardDestroyUpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardDestroyAgent:handlePM_GuardDestroyUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		GuardDestroyController.instance:handlePM_GuardDestroyUpgradeSignInBuffRes(msg)
	end
end

GuardDestroyAgent.instance = GuardDestroyAgent.New()

return GuardDestroyAgent
