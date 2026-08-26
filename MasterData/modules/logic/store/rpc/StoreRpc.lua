-- chunkname: @modules/logic/store/rpc/StoreRpc.lua

module("modules.logic.store.rpc.StoreRpc", package.seeall)

local StoreRpc = class("StoreRpc", BaseRpc)

function StoreRpc:sendGetStoreInfosRequest(storeIds, callback, callbackObj)
	local req = StoreModule_pb.GetStoreInfosRequest()

	if not storeIds or #storeIds <= 0 then
		storeIds = StoreConfig.instance:getAllStoreIds()
	end

	for i, storeId in ipairs(storeIds) do
		table.insert(req.storeIds, storeId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function StoreRpc:onReceiveGetStoreInfosReply(resultCode, msg)
	if resultCode == 0 then
		StoreModel.instance:getStoreInfosReply(msg)
		StoreController.instance:dispatchEvent(StoreEvent.StoreInfoChanged)
	end
end

function StoreRpc:sendBuyGoodsRequest(storeId, goodsId, num, callback, callbackObj, selectCost)
	local req = StoreModule_pb.BuyGoodsRequest()

	req.storeId = storeId
	req.goodsId = goodsId
	req.num = num
	req.selectCost = selectCost or 1

	return self:sendMsg(req, callback, callbackObj)
end

function StoreRpc:onReceiveBuyGoodsReply(resultCode, msg)
	if resultCode == 0 then
		StoreModel.instance:buyGoodsReply(msg)

		local storeIds = {}

		table.insert(storeIds, msg.storeId)

		if msg.storeId ~= StoreEnum.StoreId.NewRoomStore and msg.storeId ~= StoreEnum.StoreId.OldRoomStore then
			StoreRpc.instance:sendGetStoreInfosRequest(storeIds)
		end

		StoreController.instance:dispatchEvent(StoreEvent.GoodsModelChanged, msg.goodsId)
		RedDotController.instance:dispatchEvent(RedDotEvent.UpdateRelateDotInfo, {
			[RedDotEnum.DotNode.StoreBtn] = true
		})
	end

	ChargePushStatController.instance:statBuyFinished(resultCode, msg)
end

function StoreRpc:sendReadStoreNewRequest(goodsIds, callback, callbackObj)
	local req = StoreModule_pb.ReadStoreNewRequest()

	for i, goodsId in ipairs(goodsIds) do
		table.insert(req.goodsIds, goodsId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function StoreRpc:onReceiveReadStoreNewReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

StoreRpc.instance = StoreRpc.New()

return StoreRpc
