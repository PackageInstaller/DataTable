-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/divinekingciyuan/agent/DivineKingCiYuanAgent.lua

module("logic.extensions.divinekingciyuan.agent.DivineKingCiYuanAgent", package.seeall)

local DivineKingCiYuanAgent = class("DivineKingCiYuanAgent", BaseAgent)

function DivineKingCiYuanAgent:sendPM_DivineKingCiYuanGetInfoReq(activityId)
	local req = DivineKingCiYuanExtension_pb.PM_DivineKingCiYuanGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function DivineKingCiYuanAgent:handlePM_DivineKingCiYuanGetInfoRes(status, msg)
	if status == 0 then
		DivineKingCiYuanModel.instance:onDivineKingCiYuanGetInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingCiYuanGetInfoRes)
	end
end

function DivineKingCiYuanAgent:sendPM_DivineKingCiYuanFightReq(activityId, phaseId, stageId, form)
	local req = DivineKingCiYuanExtension_pb.PM_DivineKingCiYuanFightReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function DivineKingCiYuanAgent:handlePM_DivineKingCiYuanFightRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingCiYuanFightRes)
	end
end

function DivineKingCiYuanAgent:handlePM_DivineKingCiYuanNotifyFightResultRes(status, msg)
	if status == 0 then
		DivineKingCiYuanModel.instance:onDivineKingCiYuanNotifyFightResultRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingCiYuanNotifyFightResultRes)
	end
end

function DivineKingCiYuanAgent:sendPM_DivineKingCiYuanResetReq(activityId, phaseId, stageId)
	local req = DivineKingCiYuanExtension_pb.PM_DivineKingCiYuanResetReq()

	req.activityId = activityId
	req.phaseId = phaseId
	req.stageId = stageId

	self:sendMsg(req)
end

function DivineKingCiYuanAgent:handlePM_DivineKingCiYuanResetRes(status, msg)
	if status == 0 then
		DivineKingCiYuanModel.instance:onDivineKingCiYuanResetRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.DivineKingCiYuanResetRes)
	end
end

DivineKingCiYuanAgent.instance = DivineKingCiYuanAgent.New()

return DivineKingCiYuanAgent
