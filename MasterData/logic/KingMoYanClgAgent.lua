-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingmoyanclg/agent/KingMoYanClgAgent.lua

module("logic.extensions.kingmoyanclg.agent.KingMoYanClgAgent", package.seeall)

local KingMoYanClgAgent = class("KingMoYanClgAgent", BaseAgent)

function KingMoYanClgAgent:sendPM_KingMoYanClgInfoReq(activityId)
	local req = KingMoYanClgExtension_pb.PM_KingMoYanClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingMoYanClgAgent:handlePM_KingMoYanClgInfoRes(status, msg)
	if status == 0 then
		KingMoYanClgController.instance:handlePM_KingMoYanClgInfoRes(msg)
	end
end

function KingMoYanClgAgent:sendPM_KingMoYanClgChallengeReq(activityId, stageId, form)
	local req = KingMoYanClgExtension_pb.PM_KingMoYanClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingMoYanClgAgent:handlePM_KingMoYanClgChallengeRes(status, msg)
	if status == 0 then
		KingMoYanClgController.instance:handlePM_KingMoYanClgChallengeRes(msg)
	end
end

function KingMoYanClgAgent:sendPM_KingMoYanClgConfirmReq(activityId, save)
	local req = KingMoYanClgExtension_pb.PM_KingMoYanClgConfirmReq()

	req.activityId = activityId
	req.save = save

	self:sendMsg(req)
end

function KingMoYanClgAgent:handlePM_KingMoYanClgConfirmRes(status, msg)
	KingMoYanClgController.instance:handlePM_KingMoYanClgConfirmRes(status, msg)
end

function KingMoYanClgAgent:sendPM_KingMoYanClgResetReq(activityId)
	local req = KingMoYanClgExtension_pb.PM_KingMoYanClgResetReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingMoYanClgAgent:handlePM_KingMoYanClgResetRes(status, msg)
	if status == 0 then
		KingMoYanClgController.instance:handlePM_KingMoYanClgResetRes(msg)
	end
end

function KingMoYanClgAgent:handlePM_NotifyKingMoYanClgFinishRes(status, msg)
	if status == 0 then
		KingMoYanClgController.instance:handlePM_NotifyKingMoYanClgFinishRes(msg)
	end
end

KingMoYanClgAgent.instance = KingMoYanClgAgent.New()

return KingMoYanClgAgent
