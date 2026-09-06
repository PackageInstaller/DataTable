-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/goddesscontest/agent/GoddessContestAgent.lua

module("logic.extensions.goddesscontest.agent.GoddessContestAgent", package.seeall)

local GoddessContestAgent = class("GoddessContestAgent", BaseAgent)

function GoddessContestAgent:sendPM_GoddessContestInfoReq(actId)
	local req = GoddessContestExtension_pb.PM_GoddessContestInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestInfoRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleGetInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestJoinFansGroupReq(actId, fansGroupId)
	local req = GoddessContestExtension_pb.PM_GoddessContestJoinFansGroupReq()

	req.actId = actId
	req.fansGroupId = fansGroupId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestJoinFansGroupRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleJoinFansGroup(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestGetFansGroupInfoReq(actId, fansGroupId)
	local req = GoddessContestExtension_pb.PM_GoddessContestGetFansGroupInfoReq()

	req.actId = actId
	req.fansGroupId = fansGroupId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestGetFansGroupInfoRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleGetGroupInfo(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestGoddessVoteReq(actId, faceId, nums)
	local req = GoddessContestExtension_pb.PM_GoddessContestGoddessVoteReq()

	req.actId = actId
	req.faceId = faceId
	req.nums = nums

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestGoddessVoteRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleVoteToGoddess(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestGetCampaignListReq(actId, pageIndex)
	local req = GoddessContestExtension_pb.PM_GoddessContestGetCampaignListReq()

	req.actId = actId
	req.pageIndex = pageIndex

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestGetCampaignListRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleGetCampaighList(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestDirectorVoteReq(actId, targetUserId, nums)
	local req = GoddessContestExtension_pb.PM_GoddessContestDirectorVoteReq()

	req.actId = actId
	req.targetUserId = targetUserId
	req.nums = nums

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestDirectorVoteRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleVoteToDirector(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestDirectorCampaignReq(actId)
	local req = GoddessContestExtension_pb.PM_GoddessContestDirectorCampaignReq()

	req.actId = actId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestDirectorCampaignRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleJoinCampaign(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestCampaignSearchReq(actId, params)
	local req = GoddessContestExtension_pb.PM_GoddessContestCampaignSearchReq()

	req.actId = actId
	req.params = params

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestCampaignSearchRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleSearchCampaign(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestPromptReq(actId, targetUserId)
	local req = GoddessContestExtension_pb.PM_GoddessContestPromptReq()

	req.actId = actId
	req.targetUserId = targetUserId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestPromptRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handlePrompt(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestReviseDeclarationReq(actId, declaration)
	local req = GoddessContestExtension_pb.PM_GoddessContestReviseDeclarationReq()

	req.actId = actId
	req.declaration = declaration

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestReviseDeclarationRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleReviseDeclaration(msg)
	else
		GlobalDispatcher:dispatch(GlobalNotify.GoddessContestError, status)
	end
end

function GoddessContestAgent:sendPM_GoddessContestGetRankViewReq(actId, fansGroupId)
	local req = GoddessContestExtension_pb.PM_GoddessContestGetRankViewReq()

	req.actId = actId
	req.fansGroupId = fansGroupId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestGetRankViewRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handleGetRankInfo(msg)
	end
end

function GoddessContestAgent:sendPM_GoddessContestGetCardInfoReq(actId)
	local req = GoddessContestExtension_pb.PM_GoddessContestGetCardInfoReq()

	req.actId = actId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestGetCardInfoRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handlePM_GoddessContestGetCardInfoRes(msg)
	end
end

function GoddessContestAgent:sendPM_GoddessContestSetCardReq(actId, stepId, cardIds)
	local req = GoddessContestExtension_pb.PM_GoddessContestSetCardReq()

	req.actId = actId
	req.stepId = stepId

	for _, v in ipairs(cardIds) do
		req.cardIds:append(v)
	end

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestSetCardRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handlePM_GoddessContestSetCardRes(msg)
	end
end

function GoddessContestAgent:sendPM_GoddessContestFlopReq(actId, stepId, cardId)
	local req = GoddessContestExtension_pb.PM_GoddessContestFlopReq()

	req.actId = actId
	req.stepId = stepId
	req.cardId = cardId

	self:sendMsg(req)
end

function GoddessContestAgent:handlePM_GoddessContestFlopRes(status, msg)
	if status == 0 then
		GoddessContestController.instance:handlePM_GoddessContestFlopRes(msg)
	end
end

GoddessContestAgent.instance = GoddessContestAgent.New()

return GoddessContestAgent
