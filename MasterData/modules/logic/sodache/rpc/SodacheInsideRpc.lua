-- chunkname: @modules/logic/sodache/rpc/SodacheInsideRpc.lua

module("modules.logic.sodache.rpc.SodacheInsideRpc", package.seeall)

local SodacheInsideRpc = class("SodacheInsideRpc", BaseRpc)

function SodacheInsideRpc:sendSodacheInsideEnterScene(copyId, ticketId, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideEnterSceneRequest()

	req.copyId = copyId
	req.ticketId = ticketId

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideEnterSceneReply(resultCode, msg)
	if resultCode == 0 then
		SodacheModel.instance:updateInsideMo(msg.scene)
		SodacheUtil.setInside(true)
	end
end

function SodacheInsideRpc:sendSodacheInsideBuy(unitUid, id, quantity, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideBuyRequest()

	req.unitUid = unitUid
	req.id = id
	req.quantity = quantity

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideBuyReply(resultCode, msg)
	if resultCode == 0 then
		local insideMo = SodacheModel.instance:getInsideMo()

		if not insideMo then
			return
		end

		local unitMo = insideMo.unitBox.unitsMap[msg.unitUid]
		local shopItemMo = unitMo.shop.itemsMap[msg.item.id]

		if shopItemMo then
			shopItemMo:init(msg.item)
		end

		SodacheController.instance:dispatchEvent(SodacheEvent.OnShopItemUpdate)
	end
end

function SodacheInsideRpc:sendSodacheInsideSell(unitUid, itemId, count, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideSellRequest()

	req.unitUid = unitUid
	req.itemId = itemId
	req.count = count

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideSellReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideBatchBuy(unitUid, items, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideBatchBuyRequest()

	req.unitUid = unitUid

	if items then
		for i, v in ipairs(items) do
			local item = SodacheDef_pb.SodacheBatchVo()

			item.id = v.id
			item.count = v.count

			table.insert(req.items, item)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideBatchBuyReply(resultCode, msg)
	if resultCode == 0 then
		local insideMo = SodacheModel.instance:getInsideMo()

		if not insideMo then
			return
		end

		local updateShopItemIds = {}
		local unitMo = insideMo.unitBox.unitsMap[msg.unitUid]

		for i, item in ipairs(msg.items) do
			local shopItemMo = unitMo.shop.itemsMap[item.id]

			if shopItemMo then
				updateShopItemIds[item.id] = true

				shopItemMo:init(item)
			end
		end

		SodacheController.instance:dispatchEvent(SodacheEvent.OnShopItemUpdate, updateShopItemIds)
	end
end

function SodacheInsideRpc:sendSodacheInsideGetScene(callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideGetSceneRequest()

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideGetSceneReply(resultCode, msg)
	if resultCode == 0 then
		SodacheModel.instance:updateInsideMo(msg.scene)
	end
end

function SodacheInsideRpc:sendSodacheInsideSceneOperation(type, param, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideSceneOperationRequest()

	req.type = type
	req.param = param

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideSceneOperationReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideClosePanel(callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideClosePanelRequest()

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideClosePanelReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideAbandonScene(callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideAbandonSceneRequest()

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideAbandonSceneReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideSubmitMaterialSettle(items, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideSubmitMaterialSettleRequest()

	if items then
		for _, v in ipairs(items) do
			local itemParam = SodacheDef_pb.SodacheItemParam()

			itemParam.itemId = v.itemId
			itemParam.count = v.count

			table.insert(req.params, itemParam)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideSubmitMaterialSettleReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:onReceiveSodacheInsideSceneFinishSettlePush(resultCode, msg)
	if resultCode == 0 then
		SodacheMapUtil.instance:addPushToFlow("SodacheInsideSceneFinishSettlePush", msg)
	end
end

function SodacheInsideRpc:sendSodacheInsideStatisticGet(callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideStatisticGetRequest()

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideStatisticGetReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:onReceiveSodacheInsideStatisticPush(resultCode, msg)
	if resultCode == 0 then
		SodacheStatHelper.instance:endStat(msg)
	end
end

function SodacheInsideRpc:sendSodacheInsideHotfix1(intParam, strParam, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideHotfix1Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideHotfix1Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideHotfix2(intParam, strParam, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideHotfix2Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideHotfix2Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:sendSodacheInsideHotfix3(intParam, strParam, callback, callobj)
	local req = SodacheInsideModule_pb.SodacheInsideHotfix3Request()

	if intParam then
		for _, v in ipairs(intParam) do
			table.insert(req.intParam, v)
		end
	end

	if strParam then
		for _, v in ipairs(strParam) do
			table.insert(req.strParam, v)
		end
	end

	return self:sendMsg(req, callback, callobj)
end

function SodacheInsideRpc:onReceiveSodacheInsideHotfix3Reply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function SodacheInsideRpc:onReceiveMsg(resultCode, cmd, recvProtoName, msg, downTag, socketId)
	SodacheInsideRpc.super.onReceiveMsg(self, resultCode, cmd, recvProtoName, msg, downTag, socketId)

	if resultCode == 0 and string.find(recvProtoName, "Reply$") then
		SodacheMapUtil.instance:tryStartFlow(recvProtoName, true)
	end
end

SodacheInsideRpc.instance = SodacheInsideRpc.New()

return SodacheInsideRpc
