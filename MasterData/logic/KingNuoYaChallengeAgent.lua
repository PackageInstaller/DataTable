-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/kingnuoya/agent/KingNuoYaChallengeAgent.lua

module("logic.extensions.kingnuoyachallenge.agent.KingNuoYaChallengeAgent", package.seeall)

local KingNuoYaChallengeAgent = class("KingNuoYaChallengeAgent", BaseAgent)

function KingNuoYaChallengeAgent:ctor()
	return
end

function KingNuoYaChallengeAgent:setExtId(extId)
	KingNuoYaChallengeAgent.super.setExtId(self, extId)
	self:_initDispatcher(extId)
end

function KingNuoYaChallengeAgent:sendPM_KingNuoYaChallengeInfoReq(activityId)
	local req = KingNuoYaChallengeExtension_pb.PM_KingNuoYaChallengeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function KingNuoYaChallengeAgent:handlePM_KingNuoYaChallengeInfoRes(status, msg)
	if status == 0 then
		KingNuoyaChallengeController.instance:handlePM_KingNuoYaChallengeInfoRes(msg)
	end
end

function KingNuoYaChallengeAgent:sendPM_KingNuoYaChallengeReq(activityId, type, stepId, stageId, buffId, form_pb)
	local req = KingNuoYaChallengeExtension_pb.PM_KingNuoYaChallengeReq()

	req.activityId = activityId
	req.type = type
	req.stepId = stepId
	req.stageId = stageId
	req.buffId = buffId

	if form_pb ~= nil then
		req.form:ParseFromString(form_pb:SerializeToString())
	end

	self:sendMsg(req)
end

function KingNuoYaChallengeAgent:handlePM_KingNuoYaChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function KingNuoYaChallengeAgent:handlePM_NotifyKingNuoYaChallengeFinishRes(status, msg)
	KingNuoyaChallengeController.instance:onGetFighMsg(msg)
end

KingNuoYaChallengeAgent.instance = KingNuoYaChallengeAgent.New()

return KingNuoYaChallengeAgent
