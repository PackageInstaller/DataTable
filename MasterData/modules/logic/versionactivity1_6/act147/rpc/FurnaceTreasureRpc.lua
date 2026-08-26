-- chunkname: @modules/logic/versionactivity1_6/act147/rpc/FurnaceTreasureRpc.lua

module("modules.logic.versionactivity1_6.act147.rpc.FurnaceTreasureRpc", package.seeall)

local FurnaceTreasureRpc = class("FurnaceTreasureRpc", BaseRpc)

function FurnaceTreasureRpc:sendGetAct147InfosRequest(activityId)
	local req = Activity147Module_pb.GetAct147InfosRequest()

	req.activityId = activityId

	return self:sendMsg(req)
end

function FurnaceTreasureRpc:onReceiveGetAct147InfosReply(resultCode, msg)
	if resultCode == 0 then
		FurnaceTreasureModel.instance:setServerData(msg, true)
	end
end

function FurnaceTreasureRpc:sendBuyAct147GoodsRequest(activityId, storeId, goodsId, buyCount, cb, cbObj)
	local req = Activity147Module_pb.BuyAct147GoodsRequest()

	req.activityId = activityId
	req.goodsId = goodsId
	req.buyCount = buyCount
	req.storeId = storeId

	return self:sendMsg(req, cb, cbObj)
end

function FurnaceTreasureRpc:onReceiveBuyAct147GoodsReply(resultCode, msg)
	if resultCode == 0 then
		FurnaceTreasureModel.instance:updateGoodsData(msg)
		FurnaceTreasureModel.instance:decreaseTotalRemainCount(msg.activityId)
	end
end

FurnaceTreasureRpc.instance = FurnaceTreasureRpc.New()

return FurnaceTreasureRpc
