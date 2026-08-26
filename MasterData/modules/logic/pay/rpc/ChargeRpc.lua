-- chunkname: @modules/logic/pay/rpc/ChargeRpc.lua

module("modules.logic.pay.rpc.ChargeRpc", package.seeall)

local ChargeRpc = class("ChargeRpc", BaseRpc)

function ChargeRpc:sendGetChargeInfoRequest(callback, callbackObj)
	local req = ChargeModule_pb.GetChargeInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function ChargeRpc:onReceiveGetChargeInfoReply(resultCode, msg)
	if resultCode == 0 then
		PayModel.instance:setSandboxInfo(msg.sandboxEnable, msg.sandboxBalance)
		PayModel.instance:setChargeInfo(msg.infos)
		StoreModel.instance:initChargeInfo(msg.infos)
		PayController.instance:dispatchEvent(PayEvent.PayInfoChanged)
	end
end

function ChargeRpc:sendNewOrderRequest(id, selectInfos)
	local req = ChargeModule_pb.NewOrderRequest()

	req.id = id

	if selectInfos then
		for areaIndex, itemIndex in pairs(selectInfos) do
			local info = ChargeModule_pb.SelectionInfo()

			info.regionId = areaIndex
			info.selectionPos = itemIndex - 1

			table.insert(req.selectionInfos, info)
		end
	end

	self:sendMsg(req)
end

function ChargeRpc:onReceiveNewOrderReply(resultCode, msg)
	if resultCode == 0 then
		PayModel.instance:setOrderInfo(msg)
		PayController.instance:dispatchEvent(PayEvent.GetSignSuccess)

		return
	end

	PayController.instance:dispatchEvent(PayEvent.GetSignFailed)
end

function ChargeRpc:onReceiveOrderCompletePush(resultCode, msg)
	ChargePushStatController.instance:statPayFinished(resultCode, msg)

	if resultCode == 0 then
		local goodsId = msg.id

		StoreModel.instance:chargeOrderComplete(goodsId)
		self:_tryUpdateMonthCard(msg)

		local chargeGoodCfg = StoreConfig.instance:getChargeGoodsConfig(goodsId)

		if chargeGoodCfg then
			self:_tryUpdateStoreLinkPackage(msg)
			ChargeRpc.instance:sendGetChargeInfoRequest()
		end

		PayController.instance:dispatchEvent(PayEvent.PayFinished)
	else
		PayController.instance:dispatchEvent(PayEvent.PayFailed)
	end
end

function ChargeRpc:sendGetMonthCardInfoRequest(callback, callbackObj)
	local req = ChargeModule_pb.GetMonthCardInfoRequest()

	return self:sendMsg(req, callback, callbackObj)
end

function ChargeRpc:onReceiveGetMonthCardInfoReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	StoreModel.instance:updateMonthCardInfo(msg.infos[1])
	StoreController.instance:dispatchEvent(StoreEvent.MonthCardInfoChanged)
end

function ChargeRpc:sendGetMonthCardBonusRequest(id)
	local req = ChargeModule_pb.GetMonthCardBonusRequest()

	req.id = id

	return self:sendMsg(req)
end

function ChargeRpc:onReceiveGetMonthCardBonusReply(resultCode, msg)
	return
end

function ChargeRpc:sendSandboxChargeRequset(gameOrderId)
	local req = ChargeModule_pb.SandboxChargeRequset()

	req.gameOrderId = gameOrderId

	return self:sendMsg(req)
end

function ChargeRpc:onReceiveSandboxChargeReply(resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	PayModel.instance:updateSandboxBalance(msg.sandboxBalance)
end

function ChargeRpc:sendReadChargeNewRequest(goodsIds, callback, callbackObj)
	local req = ChargeModule_pb.ReadChargeNewRequest()

	for i, goodsId in ipairs(goodsIds) do
		table.insert(req.goodsIds, goodsId)
	end

	return self:sendMsg(req, callback, callbackObj)
end

function ChargeRpc:onReceiveReadChargeNewReply(resultCode, msg)
	if resultCode == 0 then
		-- block empty
	end
end

function ChargeRpc:_tryUpdateMonthCard(msg)
	local goodsId = msg.id
	local monthCardConfig = StoreConfig.instance:getMonthCardConfig(goodsId)
	local isNeedUpdate = not not monthCardConfig

	if not isNeedUpdate then
		local chargeGoodsConfig = StoreConfig.instance:getChargeGoodsConfig(goodsId)

		if chargeGoodsConfig then
			isNeedUpdate = goodsId == StoreEnum.SeasonCardGoodsId
		end
	end

	if not isNeedUpdate then
		return
	end

	SignInController.instance:sendGetSignInInfoRequestIfUnlock()
end

function ChargeRpc:_tryUpdateStoreLinkPackage(msg)
	local goodsId = msg.id
	local chargeGoodCfg = StoreConfig.instance:getChargeGoodsConfig(goodsId)

	if chargeGoodCfg and chargeGoodCfg.taskid ~= 0 then
		StoreGoodsTaskController.instance:requestGoodsTaskList()
	end
end

ChargeRpc.instance = ChargeRpc.New()

return ChargeRpc
