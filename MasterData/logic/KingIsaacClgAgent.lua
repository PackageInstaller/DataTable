-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingisaacclg/agent/KingIsaacClgAgent.lua

module("logic.extensions.kingisaacclg.agent.KingIsaacClgAgent", package.seeall)

local KingIsaacClgAgent = class("KingIsaacClgAgent", BaseAgent)

function KingIsaacClgAgent:sendPM_KingIsaacClgInfoReq(activityId)
	local req = KingIsaacClgExtension_pb.PM_KingIsaacClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingIsaacClgAgent:handlePM_KingIsaacClgInfoRes(status, msg)
	if status == 0 then
		KingIsaacClgController.instance:handlePM_KingIsaacClgInfoRes(msg)
	end
end

function KingIsaacClgAgent:sendPM_KingIsaacClgChallengeReq(activityId, stageId, form)
	local req = KingIsaacClgExtension_pb.PM_KingIsaacClgChallengeReq()

	req.activityId = activityId
	req.stageId = stageId

	if form then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function KingIsaacClgAgent:handlePM_KingIsaacClgChallengeRes(status, msg)
	KingIsaacClgController.instance:handlePM_KingIsaacClgChallengeRes(status, msg)
end

function KingIsaacClgAgent:handlePM_NotifyKingIsaacClgChallengeEndRes(status, msg)
	if status == 0 then
		KingIsaacClgController.instance:handlePM_NotifyKingIsaacClgChallengeEndRes(msg)
	end
end

KingIsaacClgAgent.instance = KingIsaacClgAgent.New()

return KingIsaacClgAgent
