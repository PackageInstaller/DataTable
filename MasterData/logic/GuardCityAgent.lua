-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/guardcity/agent/GuardCityAgent.lua

module("logic.extensions.guardcity.agent.GuardCityAgent", package.seeall)

local GuardCityAgent = class("GuardCityAgent", BaseAgent)

GuardCityAgent.PM_GuardCityGetInfoRes = "GuardCityAgent.PM_GuardCityGetInfoRes"
GuardCityAgent.PM_GuardCityChallengeRes = "GuardCityAgent.PM_GuardCityChallengeRes"
GuardCityAgent.PM_GuardCityChallengeResultRes = "GuardCityAgent.PM_GuardCityChallengeResultRes"
GuardCityAgent.PM_GuardCityRefreshRes = "GuardCityAgent.PM_GuardCityRefreshRes"
GuardCityAgent.PM_GuardCityGetPrizeInfoRes = "GuardCityAgent.PM_GuardCityGetPrizeInfoRes"
GuardCityAgent.PM_GuardCityGainPrizeRes = "GuardCityAgent.PM_GuardCityGainPrizeRes"
GuardCityAgent.PM_GuardCityGetReportInfoRes = "GuardCityAgent.PM_GuardCityGetReportInfoRes"
GuardCityAgent.PM_GuardCityConveneFriendRes = "GuardCityAgent.PM_GuardCityConveneFriendRes"
GuardCityAgent.PM_GuardCityViewSeekHelpRes = "GuardCityAgent.PM_GuardCityViewSeekHelpRes"
GuardCityAgent.PM_GuardCityViewFriendScoreRes = "GuardCityAgent.PM_GuardCityViewFriendScoreRes"
GuardCityAgent.PM_GuardCityGainFriendPrizeRes = "GuardCityAgent.PM_GuardCityGainFriendPrizeRes"
GuardCityAgent.PM_GuardCityGainProgressPrizeRes = "GuardCityAgent.PM_GuardCityGainProgressPrizeRes"
GuardCityAgent.PM_GuardCityViewRankRes = "GuardCityAgent.PM_GuardCityViewRankRes"
GuardCityAgent.PM_GuardCityBuyStrengthRes = "GuardCityAgent.PM_GuardCityBuyStrengthRes"

function GuardCityAgent:sendPM_GuardCityGetInfoReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGetInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGetInfoRes, status, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityChallengeReq(activityId, targetPlayerId, masterUniqueId, form, strongChallenge)
	local req = GuardCityExtension_pb.PM_GuardCityChallengeReq()

	req.activityId = activityId
	req.targetPlayerId = targetPlayerId
	req.masterUniqueId = masterUniqueId

	if form ~= nil then
		req.form:ParseFromString(form:SerializeToString())
	end

	req.strongChallenge = strongChallenge

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityChallengeRes(status, msg)
	if status == 0 then
		-- block empty
	end

	GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityChallengeRes, status, msg)
end

function GuardCityAgent:handlePM_GuardCityChallengeResultRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityChallengeResultRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityRefreshReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityRefreshReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityRefreshRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityRefreshRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityGetPrizeInfoReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityGetPrizeInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGetPrizeInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGetPrizeInfoRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityGainPrizeReq(activityId, prizeIds)
	local req = GuardCityExtension_pb.PM_GuardCityGainPrizeReq()

	req.activityId = activityId

	for i, v1 in ipairs(prizeIds) do
		req.prizeIds:append(v1)
	end

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGainPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGainPrizeRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityGetReportInfoReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityGetReportInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGetReportInfoRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGetReportInfoRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityConveneFriendReq(activityId, masterUniqueId, friendIds, creepsMasterId)
	local req = GuardCityExtension_pb.PM_GuardCityConveneFriendReq()

	req.activityId = activityId
	req.masterUniqueId = masterUniqueId

	for i, v1 in ipairs(friendIds) do
		req.friendIds:append(v1)
	end

	req.creepsMasterId = creepsMasterId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityConveneFriendRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityConveneFriendRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityViewSeekHelpReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityViewSeekHelpReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityViewSeekHelpRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityViewSeekHelpRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityViewFriendScoreReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityViewFriendScoreReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityViewFriendScoreRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityViewFriendScoreRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityGainFriendPrizeReq(activityId, friendIds)
	local req = GuardCityExtension_pb.PM_GuardCityGainFriendPrizeReq()

	req.activityId = activityId

	for i, v1 in ipairs(friendIds) do
		req.friendIds:append(v1)
	end

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGainFriendPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGainFriendPrizeRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityGainProgressPrizeReq(activityId, prizeIds)
	local req = GuardCityExtension_pb.PM_GuardCityGainProgressPrizeReq()

	req.activityId = activityId
	req.prizeIds = prizeIds

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityGainProgressPrizeRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityGainProgressPrizeRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityViewRankReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityViewRankReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityViewRankRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityViewRankRes, msg)
	end
end

function GuardCityAgent:sendPM_GuardCityBuyStrengthReq(activityId)
	local req = GuardCityExtension_pb.PM_GuardCityBuyStrengthReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function GuardCityAgent:handlePM_GuardCityBuyStrengthRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GuardCityAgent.PM_GuardCityBuyStrengthRes, msg)
	end
end

GuardCityAgent.instance = GuardCityAgent.New()

return GuardCityAgent
