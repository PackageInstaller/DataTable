-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/finalecho/agent/FinalEchoAgent.lua

module("logic.extensions.finalecho.agent.FinalEchoAgent", package.seeall)

local FinalEchoAgent = class("FinalEchoAgent", BaseAgent)

function FinalEchoAgent:sendPM_FinalEchoInfoReq(activityId)
	local req = FinalEchoExtension_pb.PM_FinalEchoInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FinalEchoAgent:handlePM_FinalEchoInfoRes(status, msg)
	if status == 0 then
		FinalEchoController.instance:handleGetInfo(msg)
	end
end

function FinalEchoAgent:sendPM_FinalEchoChallengeReq(activityId, bossId, form_pb)
	local req = FinalEchoExtension_pb.PM_FinalEchoChallengeReq()

	req.activityId = activityId
	req.bossId = bossId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function FinalEchoAgent:handlePM_FinalEchoChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end
end

function FinalEchoAgent:sendPM_FinalEchoConfirmReq(activityId, bossId, save)
	local req = FinalEchoExtension_pb.PM_FinalEchoConfirmReq()

	req.activityId = activityId
	req.bossId = bossId
	req.save = save

	self:sendMsg(req)
end

function FinalEchoAgent:handlePM_FinalEchoConfirmRes(status, msg)
	if status == 0 then
		FinalEchoController.instance:handleConfirmResult(msg)
	end
end

function FinalEchoAgent:sendPM_FinalEchoResetReq(activityId)
	local req = FinalEchoExtension_pb.PM_FinalEchoResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FinalEchoAgent:handlePM_FinalEchoResetRes(status, msg)
	if status == 0 then
		FinalEchoController.instance:handleResetInfo(msg)
	end
end

function FinalEchoAgent:sendPM_FinalEchoRankInfoReq(activityId)
	local req = FinalEchoExtension_pb.PM_FinalEchoRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FinalEchoAgent:handlePM_FinalEchoRankInfoRes(status, msg)
	if status == 0 then
		FinalEchoController.instance:handleGetRankInfo(msg)
	end
end

function FinalEchoAgent:handlePM_NotifyFinalEchoChallengeFinishRes(status, msg)
	if status == 0 then
		FinalEchoController.instance:handleNotifyClgFinish(msg)
	end
end

FinalEchoAgent.instance = FinalEchoAgent.New()

return FinalEchoAgent
