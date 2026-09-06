-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/firedimension/agent/FireDimensionChallengeAgent.lua

module("logic.extensions.firedimension.agent.FireDimensionChallengeAgent", package.seeall)

local FireDimensionChallengeAgent = class("FireDimensionChallengeAgent", BaseAgent)

function FireDimensionChallengeAgent:sendPM_FireDimensionClgInfoReq(activityId)
	local req = FireDimensionChallengeExtension_pb.PM_FireDimensionClgInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FireDimensionChallengeAgent:handlePM_FireDimensionClgInfoRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:onFireDimensionClgInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FireDimensionClgInfoRes)
	end
end

function FireDimensionChallengeAgent:sendPM_FireDimensionChallengeReq(activityId, stageId, teamId, form)
	local req = FireDimensionChallengeExtension_pb.PM_FireDimensionChallengeReq()

	req.activityId = activityId
	req.stageId = stageId
	req.teamId = teamId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	self:sendMsg(req)
end

function FireDimensionChallengeAgent:handlePM_FireDimensionChallengeRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:onFireDimensionChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FireDimensionChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function FireDimensionChallengeAgent:sendPM_FireDimensionClgBanReq(activityId, stageId, banTeamIds)
	local req = FireDimensionChallengeExtension_pb.PM_FireDimensionClgBanReq()

	req.activityId = activityId
	req.stageId = stageId

	for i, v1 in ipairs(banTeamIds) do
		req.banTeamIds:append(v1)
	end

	self._temActivityId = activityId

	self:sendMsg(req)
end

function FireDimensionChallengeAgent:handlePM_FireDimensionClgBanRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:onFireDimensionClgBanRes(self._temActivityId, msg)
		GlobalDispatcher:dispatch(GlobalNotify.FireDimensionClgBanRes)
	end
end

function FireDimensionChallengeAgent:sendPM_FireDimensionClgResetReq(activityId)
	local req = FireDimensionChallengeExtension_pb.PM_FireDimensionClgResetReq()

	req.activityId = activityId
	self._temActivityId2 = activityId

	self:sendMsg(req)
end

function FireDimensionChallengeAgent:handlePM_FireDimensionClgResetRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:onFireDimensionClgResetRes(self._temActivityId2, msg)
		GlobalDispatcher:dispatch(GlobalNotify.FireDimensionClgResetRes)
	end
end

function FireDimensionChallengeAgent:handlePM_FireDimensionClgFightEndRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:onFireDimensionClgFightEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FireDimensionClgFightEndRes, msg)
	end
end

function FireDimensionChallengeAgent:sendPM_FireDimensionClgUpgradeSignInBuffReq(activityId)
	local req = FireDimensionChallengeExtension_pb.PM_FireDimensionClgUpgradeSignInBuffReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FireDimensionChallengeAgent:handlePM_FireDimensionClgUpgradeSignInBuffRes(status, msg)
	if status == 0 then
		FireDimensionModel.instance:gainDailyBuff(msg)
		GlobalDispatcher:dispatch(GlobalNotify.PM_FireDimensionClgUpgradeSignInBuffRes, msg)
	end
end

FireDimensionChallengeAgent.instance = FireDimensionChallengeAgent.New()

return FireDimensionChallengeAgent
