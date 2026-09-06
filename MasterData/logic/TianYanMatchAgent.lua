-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/tianyanmatch/agent/TianYanMatchAgent.lua

module("logic.extensions.tianyanmatch.agent.TianYanMatchAgent", package.seeall)

local TianYanMatchAgent = class("TianYanMatchAgent", BaseAgent)

function TianYanMatchAgent:sendPM_TianYanMatchGetInfoReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchGetInfoRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchGetInfoRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchSelectToyReq(activityId, selectToyId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchSelectToyReq()

	req.activityId = activityId
	req.selectToyId = selectToyId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchSelectToyRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchSelectToyRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchUpFriendshipReq(activityId, targetFriendship)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchUpFriendshipReq()

	req.activityId = activityId
	req.targetFriendship = targetFriendship

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchUpFriendshipRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchUpFriendshipRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchSetWishToyReq(activityId, wishMatchToyId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchSetWishToyReq()

	req.activityId = activityId
	req.wishMatchToyId = wishMatchToyId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchSetWishToyRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchSetWishToyRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchMatchReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchMatchRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchMatchRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchCancelMatchReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchCancelMatchReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchCancelMatchRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchCancelMatchRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchGenKeyReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchGenKeyReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchGenKeyRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchGenKeyRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchMatchBuddyReq(activityId, targetPlayerId, encryptedKey)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchMatchBuddyReq()

	req.activityId = activityId
	req.targetPlayerId = targetPlayerId
	req.encryptedKey = encryptedKey

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchMatchBuddyRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchMatchBuddyRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchGainMatchPrizeReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchGainMatchPrizeReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchGainMatchPrizeRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchGainMatchPrizeRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchGainManualPrizeReq(activityId, manualId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchGainManualPrizeReq()

	req.activityId = activityId
	req.manualId = manualId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchGainManualPrizeRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchGainManualPrizeRes(msg)
	end
end

function TianYanMatchAgent:sendPM_TianYanMatchRankViewReq(activityId)
	local req = TianYanMatchExtension_pb.PM_TianYanMatchRankViewReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function TianYanMatchAgent:handlePM_TianYanMatchRankViewRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchRankViewRes(msg)
	end
end

function TianYanMatchAgent:handlePM_TianYanMatchNotifyMatchSucRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchNotifyMatchSucRes(msg)
	end
end

function TianYanMatchAgent:handlePM_TianYanMatchNotifyMatchFailRes(status, msg)
	if status == 0 then
		TianYanMatchController.instance:handlePM_TianYanMatchNotifyMatchFailRes(msg)
	end
end

TianYanMatchAgent.instance = TianYanMatchAgent.New()

return TianYanMatchAgent
