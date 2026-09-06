-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/recalltask/agent/RegressInviteAgent.lua

module("logic.extensions.recalltask.agent.RegressInviteAgent", package.seeall)

local RegressInviteAgent = class("RegressInviteAgent", BaseAgent)

function RegressInviteAgent:sendPM_RIGetRegressUserInfoReq(actId)
	local req = RegressInviteExtension_pb.PM_RIGetRegressUserInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIGetRegressUserInfoRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csRegressUserInfo(msg)
	end
end

function RegressInviteAgent:sendPM_RIGetInviteUserInfoReq(actId)
	local req = RegressInviteExtension_pb.PM_RIGetInviteUserInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIGetInviteUserInfoRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csInviteUserInfo(msg)
	end
end

function RegressInviteAgent:sendPM_RIGainTaskPrizeReq(actId, taskId, partnerUserId)
	local req = RegressInviteExtension_pb.PM_RIGainTaskPrizeReq()

	req.actId = actId
	req.taskId = taskId
	req.partnerUserId = partnerUserId

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIGainTaskPrizeRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csGainTaskPrize(msg)
	end
end

function RegressInviteAgent:sendPM_RIGainInvitePrizeReq(actId, prizeId)
	local req = RegressInviteExtension_pb.PM_RIGainInvitePrizeReq()

	req.actId = actId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIGainInvitePrizeRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csGainInvitePrize(msg)
	end
end

function RegressInviteAgent:sendPM_RIUseCodeReq(actId, code)
	local req = RegressInviteExtension_pb.PM_RIUseCodeReq()

	req.actId = actId
	req.code = code

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIUseCodeRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csWriteUseCode(msg)
		FloatWordMgr.instance:show(lang("text_recall_desc_25"))
	end
end

function RegressInviteAgent:sendPM_RIGetTaskInviteInfoReq(actId, userId, taskId, needSenderHeadInfo)
	local req = RegressInviteExtension_pb.PM_RIGetTaskInviteInfoReq()

	req.actId = actId
	req.userId = userId
	req.taskId = taskId
	req.needSenderHeadInfo = needSenderHeadInfo

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIGetTaskInviteInfoRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csTaskInviteInfo(msg)
	end
end

function RegressInviteAgent:sendPM_RIAcceptTaskInviteReq(actId, userId, taskId)
	local req = RegressInviteExtension_pb.PM_RIAcceptTaskInviteReq()

	req.actId = actId
	req.userId = userId
	req.taskId = taskId

	self:sendMsg(req)
end

function RegressInviteAgent:handlePM_RIAcceptTaskInviteRes(status, msg)
	if status == 0 then
		RecallTaskController.instance:csAcceptTaskInvite(msg)
	end
end

RegressInviteAgent.instance = RegressInviteAgent.New()

return RegressInviteAgent
