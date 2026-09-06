-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/grouprecharge/agent/GroupRechargeAgent.lua

module("logic.extensions.grouprecharge.agent.GroupRechargeAgent", package.seeall)

local GroupRechargeAgent = class("GroupRechargeAgent", BaseAgent)

function GroupRechargeAgent:sendPM_GroupRechargeInfoReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeInfoReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeInfoRes(status, msg)
	GroupRechargeController.instance:handleInfoRes(status, msg)
end

function GroupRechargeAgent:sendGroupRechargeRequest(headInfo, teamId, memberNum, totalRecharge)
	local req = GroupRechargeExtension_pb.GroupRechargeRequest()

	req.headInfo = headInfo
	req.teamId = teamId
	req.memberNum = memberNum
	req.totalRecharge = totalRecharge

	self:sendMsg(req)
end

function GroupRechargeAgent:sendPM_GroupRechargeRequestListReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeRequestListReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeRequestListRes(status, msg)
	GroupRechargeController.instance:handleRequestListRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeInviteBuddyListReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeInviteBuddyListReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeInviteBuddyListRes(status, msg)
	GroupRechargeController.instance:handleInviteBuddyListRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeSendRequestReq(targetUserId)
	local req = GroupRechargeExtension_pb.PM_GroupRechargeSendRequestReq()

	for i, v in ipairs(targetUserId) do
		req.targetUserId:append(v)
	end

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeSendRequestRes(status, msg)
	GroupRechargeController.instance:handleSendRequestRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeHandlerRequestReq(userId, action)
	local req = GroupRechargeExtension_pb.PM_GroupRechargeHandlerRequestReq()

	req.userId = userId
	req.action = action

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeHandlerRequestRes(status, msg)
	GroupRechargeController.instance:handleHandlerRequestRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargePersonalMatchingReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargePersonalMatchingReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargePersonalMatchingRes(status, msg)
	GroupRechargeController.instance:handlePersonalMatchingRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeTeamMatchingReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeTeamMatchingReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeTeamMatchingRes(status, msg)
	GroupRechargeController.instance:handleTeamMatchingRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeCancelMatchingReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeCancelMatchingReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeCancelMatchingRes(status, msg)
	GroupRechargeController.instance:handleCancelMatchingRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeGainPersonalPrizeReq(prizeId)
	local req = GroupRechargeExtension_pb.PM_GroupRechargeGainPersonalPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeGainPersonalPrizeRes(status, msg)
	GroupRechargeController.instance:handleGainPersonalPrizeRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeOneKeyGainPersonalPrzieReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeOneKeyGainPersonalPrzieReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeOneKeyGainPersonalPrzieRes(status, msg)
	GroupRechargeController.instance:handleGainPersonalPrizeRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeGainTeamPrizeReq(prizeId)
	local req = GroupRechargeExtension_pb.PM_GroupRechargeGainTeamPrizeReq()

	req.prizeId = prizeId

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeGainTeamPrizeRes(status, msg)
	GroupRechargeController.instance:handleGainTeamPrizeRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeOneKeyGainTeamPrizeReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeOneKeyGainTeamPrizeReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeOneKeyGainTeamPrizeRes(status, msg)
	GroupRechargeController.instance:handleGainTeamPrizeRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargePersonalRankReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargePersonalRankReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargePersonalRankRes(status, msg)
	GroupRechargeController.instance:handlePersonalRankRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeTeamRankReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeTeamRankReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeTeamRankRes(status, msg)
	GroupRechargeController.instance:handleTeamRankRes(status, msg)
end

function GroupRechargeAgent:sendPM_GroupRechargeFirstTeamInfoReq()
	local req = GroupRechargeExtension_pb.PM_GroupRechargeFirstTeamInfoReq()

	self:sendMsg(req)
end

function GroupRechargeAgent:handlePM_GroupRechargeFirstTeamInfoRes(status, msg)
	GroupRechargeController.instance:handleFirstTeamInfoRes(status, msg)
end

function GroupRechargeAgent:handlePM_NotifyReceivedRequestRes(status, msg)
	GroupRechargeController.instance:handleNotifyReceivedRequestRes(status, msg)
end

function GroupRechargeAgent:handlePM_NotifySomeOneJoinTeamRes(status, msg)
	GroupRechargeController.instance:handleNotifySomeOneJoinTeamRes(status, msg)
end

function GroupRechargeAgent:handlePM_NotifyJoinTeamRes(status, msg)
	GroupRechargeController.instance:handleNotifyJoinTeamRes(status, msg)
end

function GroupRechargeAgent:handlePM_NotifyMatchingSuccessRes(status, msg)
	GroupRechargeController.instance:handleNotifyMatchingSuccessRes(status, msg)
end

function GroupRechargeAgent:handlePM_NotifyMatchingFailRes(status, msg)
	GroupRechargeController.instance:handleNotifyMatchingFailRes(status, msg)
end

GroupRechargeAgent.instance = GroupRechargeAgent.New()

return GroupRechargeAgent
