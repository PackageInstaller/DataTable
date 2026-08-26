-- chunkname: @modules/logic/store/rpc/Activity107Rpc.lua

module("modules.logic.store.rpc.Activity107Rpc", package.seeall)

local Activity107Rpc = class("Activity107Rpc", BaseRpc)

function Activity107Rpc:sendGet107GoodsInfoRequest(activityId, callback, callbackObj)
	local req = Activity107Module_pb.Get107GoodsInfoRequest()

	req.activityId = activityId

	return self:sendMsg(req, callback, callbackObj)
end

function Activity107Rpc:onReceiveGet107GoodsInfoReply(resultCode, msg)
	if resultCode == 0 then
		ActivityStoreModel.instance:initActivityGoodsInfos(msg.activityId, msg.goodsInfos)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnGet107GoodsInfo, msg.activityId)
	end
end

function Activity107Rpc:sendBuy107GoodsRequest(activityId, goodsId, num)
	local req = Activity107Module_pb.Buy107GoodsRequest()

	req.activityId = activityId
	req.id = goodsId
	req.num = num

	return self:sendMsg(req)
end

function Activity107Rpc:onReceiveBuy107GoodsReply(resultCode, msg)
	if resultCode == 0 then
		ActivityStoreModel.instance:updateActivityGoodsInfos(msg.activityId, msg.goodsInfo)
		VersionActivityController.instance:dispatchEvent(VersionActivityEvent.OnBuy107GoodsSuccess, msg.activityId, msg.goodsInfo.id)
	end
end

Activity107Rpc.instance = Activity107Rpc.New()

return Activity107Rpc
