-- chunkname: @C:/GitLab-Runner/builds/sTUwNpCg/0/aqmobile/aqmobile-client/UnityProj/Assets/Scripts/Lua/logic/extensions/bargain/agent/FriendBargainAgent.lua

module("logic.extensions.bargain.agent.FriendBargainAgent", package.seeall)

local FriendBargainAgent = class("FriendBargainAgent", BaseAgent)

function FriendBargainAgent:sendPM_FriendBargainGetInfoReq(activityId)
	local req = FriendBargainExtension_pb.PM_FriendBargainGetInfoReq()

	req.activityId = activityId

	self:sendMsg(req)
end

function FriendBargainAgent:handlePM_FriendBargainGetInfoRes(status, msg)
	if status == 0 then
		BargainModel.instance:setBargainInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FriendBargainInfoRes)
	end
end

function FriendBargainAgent:sendPM_FriendBargainChatReq(activityId, friendUserId, goodsId)
	local req = FriendBargainExtension_pb.PM_FriendBargainChatReq()

	req.activityId = activityId

	if friendUserId then
		for i, v in ipairs(friendUserId) do
			req.friendUserId:append(v)
		end
	end

	req.goodsId = goodsId

	self:sendMsg(req)
end

function FriendBargainAgent:handlePM_FriendBargainChatRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FriendBargainChatRes)
	end
end

function FriendBargainAgent:sendPM_FriendBargainBuyReq(activityId, goodsId)
	local req = FriendBargainExtension_pb.PM_FriendBargainBuyReq()

	req.activityId = activityId
	req.goodsId = goodsId

	self:sendMsg(req)
end

function FriendBargainAgent:handlePM_FriendBargainBuyRes(status, msg)
	if status == 0 then
		BargainModel.instance:setGoodsInfo(msg)
		GlobalDispatcher:dispatch(GlobalNotify.FriendBargainInfoRes)
	end
end

function FriendBargainAgent:sendPM_FriendBargainReduceReq(activityId, goodsId, reduceUserId)
	local req = FriendBargainExtension_pb.PM_FriendBargainReduceReq()

	req.activityId = activityId
	req.goodsId = goodsId
	req.reduceUserId = reduceUserId

	self:sendMsg(req)
end

function FriendBargainAgent:handlePM_FriendBargainReduceRes(status, msg)
	if status == 0 then
		local reduce = msg.reduce

		GlobalDispatcher:dispatch(GlobalNotify.FriendBargainRedpackRes, reduce)
	end
end

function FriendBargainAgent:sendPM_FriendBargainFindReq(activityId, reduceUserId, goodsId)
	local req = FriendBargainExtension_pb.PM_FriendBargainFindReq()

	req.activityId = activityId
	req.reduceUserId = reduceUserId
	req.goodsId = goodsId

	self:sendMsg(req)
end

function FriendBargainAgent:handlePM_FriendBargainFindRes(status, msg)
	if status == 0 then
		GlobalDispatcher:dispatch(GlobalNotify.FriendBargainRedpackInfoRes, msg)
	end
end

FriendBargainAgent.instance = FriendBargainAgent.New()

return FriendBargainAgent
