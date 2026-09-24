-- chunkname: @modules/logic/versionactivity4_0/concertlimit/rpc/Activity246Rpc.lua

module("modules.logic.versionactivity4_0.concertlimit.rpc.Activity246Rpc", package.seeall)

local Activity246Rpc = class("Activity246Rpc", BaseRpc)

function Activity246Rpc:sendGet246InfoRequest(activityId, callback, callbackObj)
	local req = Activity246Module_pb.GetAct246InfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity246Rpc:onReceiveGetAct246InfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ActFlipModel.instance:setCardInfos(msg.cardInfos)
	ActFlipController.instance:dispatchEvent(ActFlipEvent.RewardInfoChanged)
end

function Activity246Rpc:sendAct246ScratchRequest(activityId, cardId, index, callback, callbackObj)
	local req = Activity246Module_pb.Act246ScratchRequest()

	req.activityId = activityId
	req.cardId = cardId
	req.index = index

	return self:sendMsg(req, callback, callbackObj)
end

function Activity246Rpc:onReceiveAct246ScratchReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	ActFlipModel.instance:updateCardInfo(msg.card)
	ActFlipModel.instance:setCardUnlock(msg.unlockedCardId)
	ActFlipController.instance:dispatchEvent(ActFlipEvent.RewardBonusGet, msg.rewardId)
end

Activity246Rpc.instance = Activity246Rpc.New()

return Activity246Rpc
