-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/groupregress/agent/GroupRegressAgent.lua

module("logic.extensions.groupregress.agent.GroupRegressAgent", package.seeall)

local GroupRegressAgent = class("GroupRegressAgent", BaseAgent)

function GroupRegressAgent:sendPM_GroupRegressGetInfoReq(activityId)
	local req = GroupRegressExtension_pb.PM_GroupRegressGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GroupRegressAgent:handlePM_GroupRegressGetInfoRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressGetInfoRes(msg)
	end
end

function GroupRegressAgent:sendPM_GroupRegressBindReq(activityId, inviteCode)
	local req = GroupRegressExtension_pb.PM_GroupRegressBindReq()

	req.activityId = activityId
	req.inviteCode = inviteCode

	self:sendMsg(req)
end

function GroupRegressAgent:handlePM_GroupRegressBindRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressBindRes(msg)
	end
end

function GroupRegressAgent:sendPM_GroupRegressGainProgressPrizeReq(activityId, prizeIds, teamType)
	local req = GroupRegressExtension_pb.PM_GroupRegressGainProgressPrizeReq()

	req.activityId = activityId

	for _, v in ipairs(prizeIds) do
		req.prizeIds:append(v)
	end

	req.teamType = teamType

	self:sendMsg(req)
end

function GroupRegressAgent:handlePM_GroupRegressGainProgressPrizeRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressGainProgressPrizeRes(msg)
	end
end

function GroupRegressAgent:sendPM_GroupRegressGainOncePrizeReq(activityId, inviteNewPlayerPrize)
	local req = GroupRegressExtension_pb.PM_GroupRegressGainOncePrizeReq()

	req.activityId = activityId
	req.inviteNewPlayerPrize = inviteNewPlayerPrize

	self:sendMsg(req)
end

function GroupRegressAgent:handlePM_GroupRegressGainOncePrizeRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressGainOncePrizeRes(msg)
	end
end

function GroupRegressAgent:sendPM_GroupRegressGetTeamInfoReq(activityId, teamType)
	local req = GroupRegressExtension_pb.PM_GroupRegressGetTeamInfoReq()

	req.activityId = activityId
	req.teamType = teamType

	self:sendMsg(req)
end

function GroupRegressAgent:handlePM_GroupRegressGetTeamInfoRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressGetTeamInfoRes(msg)
	end
end

function GroupRegressAgent:handlePM_GroupRegressNotifyNewMemberRes(status, msg)
	if status == 0 then
		GroupRegressController.instance:handlePM_GroupRegressNotifyNewMemberRes(msg)
	end
end

GroupRegressAgent.instance = GroupRegressAgent.New()

return GroupRegressAgent
