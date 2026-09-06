-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/projectash/agent/ProjectAshAgent.lua

module("logic.extensions.projectash.agent.ProjectAshAgent", package.seeall)

local ProjectAshAgent = class("ProjectAshAgent", BaseAgent)

function ProjectAshAgent:sendPM_ProjectAshInfoReq(activityId)
	local req = ProjectAshExtension_pb.PM_ProjectAshInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ProjectAshAgent:handlePM_ProjectAshInfoRes(status, msg)
	if status == 0 then
		ProjectAshModel.instance:onProjectAshInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ProjectAshInfoRes)
	end
end

function ProjectAshAgent:sendPM_ProjectAshGainPrizeReq(activityId, prizeType, prizeId)
	local req = ProjectAshExtension_pb.PM_ProjectAshGainPrizeReq()

	req.activityId = activityId
	req.prizeType = prizeType
	req.prizeId = prizeId

	self:sendMsg(req)
end

function ProjectAshAgent:handlePM_ProjectAshGainPrizeRes(status, msg)
	if status == 0 then
		ProjectAshModel.instance:onProjectAshGainPrizeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ProjectAshGainPrizeRes, msg.prizeType)
	end
end

function ProjectAshAgent:sendPM_ProjectAshStage1LotteryReq(activityId, costId)
	local req = ProjectAshExtension_pb.PM_ProjectAshStage1LotteryReq()

	req.activityId = activityId
	req.costId = costId

	self:sendMsg(req)
end

function ProjectAshAgent:handlePM_ProjectAshStage1LotteryRes(status, msg)
	if status == 0 then
		MaterialController.instance:saveChangeSetToTemp(msg.changeSetId)
		ProjectAshModel.instance:onProjectAshStage1LotteryRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ProjectAshStage1LotteryRes, msg.changeSetId)
	end
end

function ProjectAshAgent:sendPM_ProjectAshStage2ChallengeReq(activityId, form, costId, buffIds)
	local req = ProjectAshExtension_pb.PM_ProjectAshStage2ChallengeReq()

	req.activityId = activityId

	req.form:ParseFromString(form:SerializeToString())

	for i, v1 in ipairs(costId) do
		req.costId:append(v1)
	end

	for i, v1 in ipairs(buffIds) do
		req.buffIds:append(v1)
	end

	self:sendMsg(req)
end

function ProjectAshAgent:handlePM_ProjectAshStage2ChallengeRes(status, msg)
	if status == 0 then
		ProjectAshModel.instance:onProjectAshStage2ChallengeRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ProjectAshStage2ChallengeRes)
	else
		GlobalDispatcher:dispatch(GlobalNotify.OnMissionBattleResBack, status)
	end
end

function ProjectAshAgent:handlePM_NotifyProjectAshStage2ChallengeEndRes(status, msg)
	if status == 0 then
		ProjectAshModel.instance:onNotifyProjectAshStage2ChallengeEndRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.NotifyProjectAshStage2ChallengeEndRes)
	end
end

function ProjectAshAgent:sendPM_ProjectAshStage2GetRankInfoReq(activityId)
	local req = ProjectAshExtension_pb.PM_ProjectAshStage2GetRankInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function ProjectAshAgent:handlePM_ProjectAshStage2GetRankInfoRes(status, msg)
	if status == 0 then
		ProjectAshModel.instance:onProjectAshStage2GetRankInfoRes(msg)
		GlobalDispatcher:dispatch(GlobalNotify.ProjectAshStage2GetRankInfoRes)
	end
end

ProjectAshAgent.instance = ProjectAshAgent.New()

return ProjectAshAgent
