-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/mmteampassport/agent/MMTeamPassportAgent.lua

module("logic.extensions.mmteampassport.agent.MMTeamPassportAgent", package.seeall)

local MMTeamPassportAgent = class("MMTeamPassportAgent", BaseAgent)

function MMTeamPassportAgent:sendPM_MMTeamPassportGetInfoReq(activityId)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportGetInfoRes(status, msg)
	if status == 0 then
		MMTeamPassportController.instance:handlePM_MMTeamPassportGetInfoRes(msg)
	end
end

function MMTeamPassportAgent:sendPM_MMTeamPassportGetTeamHallInfoReq(activityId, searchCaptainId)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportGetTeamHallInfoReq()

	req.activityId = activityId
	req.searchCaptainId = searchCaptainId

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportGetTeamHallInfoRes(status, msg)
	if status == 0 then
		MMTeamPassportController.instance:handlePM_MMTeamPassportGetTeamHallInfoRes(msg)
	end
end

function MMTeamPassportAgent:sendPM_MMTeamPassportApplyJoinTeamReq(activityId, captainId)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportApplyJoinTeamReq()

	req.activityId = activityId
	req.captainId = captainId

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportApplyJoinTeamRes(status, msg)
	MMTeamPassportController.instance:handlePM_MMTeamPassportApplyJoinTeamRes(status, msg)
end

function MMTeamPassportAgent:sendPM_MMTeamPassportApproveApplyReq(activityId, applyUserId, agree)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportApproveApplyReq()

	req.activityId = activityId
	req.applyUserId = applyUserId
	req.agree = agree

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportApproveApplyRes(status, msg)
	MMTeamPassportController.instance:handlePM_MMTeamPassportApproveApplyRes(status, msg)
end

function MMTeamPassportAgent:sendPM_MMTeamPassportOpenApplyListReq(activityId)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportOpenApplyListReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportOpenApplyListRes(status, msg)
	if status == 0 then
		MMTeamPassportController.instance:handlePM_MMTeamPassportOpenApplyListRes(msg)
	end
end

function MMTeamPassportAgent:sendPM_MMTeamPassportGainTeamPrizeReq(activityId, prizeId)
	local req = MMTeamPassportExtension_pb.PM_MMTeamPassportGainTeamPrizeReq()

	req.activityId = activityId
	req.prizeId = prizeId

	self:sendMsg(req)
end

function MMTeamPassportAgent:handlePM_MMTeamPassportGainTeamPrizeRes(status, msg)
	if status == 0 then
		MMTeamPassportController.instance:handlePM_MMTeamPassportGainTeamPrizeRes(msg)
	end
end

MMTeamPassportAgent.instance = MMTeamPassportAgent.New()

return MMTeamPassportAgent
