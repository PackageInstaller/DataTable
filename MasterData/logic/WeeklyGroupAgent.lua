-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/weeklygroup/agent/WeeklyGroupAgent.lua

module("logic.extensions.weeklygroup.agent.WeeklyGroupAgent", package.seeall)

local WeeklyGroupAgent = class("WeeklyGroupAgent", BaseAgent)

function WeeklyGroupAgent:sendPM_WeeklyGroupGetInfoReq(activityId)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupGetInfoRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupGetInfoRes(status, msg)
	end
end

function WeeklyGroupAgent:sendPM_WeeklyGroupGainPrizeReq(activityId, prizeId)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupGainPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupGainPrizeRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupGainPrizeRes(status, msg)
	end
end

function WeeklyGroupAgent:sendPM_WeeklyGroupGainPersonPrizeReq(activityId, prizeId)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupGainPersonPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupGainPersonPrizeRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupGainPersonPrizeRes(status, msg)
	end
end

function WeeklyGroupAgent:sendPM_WeeklyGroupInviteReq(activityId, buddyIds)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupInviteReq()

	req.activityId = activityId

	for i, v in ipairs(buddyIds) do
		req.buddyIds:append(v)
	end

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupInviteRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupInviteRes(status, msg)
	end
end

function WeeklyGroupAgent:sendPM_WeeklyGroupJoinTeamReq(activityId, teamId)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupJoinTeamReq()

	req.activityId = activityId
	req.teamId = teamId

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupJoinTeamRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupJoinTeamRes(status, msg)
	end
end

function WeeklyGroupAgent:sendPM_WeeklyGroupRankViewReq(activityId, rankType)
	local req = WeeklyGroupExtension_pb.PM_WeeklyGroupRankViewReq()

	req.activityId = activityId
	req.rankType = rankType

	self:sendMsg(req)
end

function WeeklyGroupAgent:handlePM_WeeklyGroupRankViewRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_WeeklyGroupRankViewRes(status, msg)
	end
end

function WeeklyGroupAgent:handlePM_NotifyIniviteMsgRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_NotifyIniviteMsgRes(status, msg)
	end
end

function WeeklyGroupAgent:handlePM_NotifyNewTeamStateRes(status, msg)
	if status == 0 then
		WeeklyGroupController.instance:handlePM_NotifyNewTeamStateRes(status, msg)
	end
end

WeeklyGroupAgent.instance = WeeklyGroupAgent.New()

return WeeklyGroupAgent
