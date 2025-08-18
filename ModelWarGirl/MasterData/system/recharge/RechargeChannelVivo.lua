-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelVivo.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelVivo = Class("RechargeChannelVivo", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local UrlConfig = require("Network/UrlConfig")
local AttName = SDKConst.AttName

function RechargeChannelVivo:ctor()
	self._receiptUrlHead = UrlConfig.Resupply
	self._receiptUrlTail = "vivo"
end

function RechargeChannelVivo:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelVivo.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.USER_ID] = channel_account
	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.COST_MONEY]
	sdkOrder[AttName.PAY_SIGN] = extendInfo[OpenServerConst.PAY_SIGN]
	sdkOrder[AttName.ITEM_NAME] = extendInfo[OpenServerConst.PRODUCT_NAME]
	sdkOrder[AttName.ITEM_DESC] = extendInfo[OpenServerConst.PRODUCT_DESC]
	sdkOrder[AttName.PAY_CALL_BACK_URL] = extendInfo[OpenServerConst.NOTIFY_URL]

	return sdkOrder
end

function RechargeChannelVivo:_getVerifyIndexAndData(data, openOrderId)
	openOrderId = data and data[AttName.OPEN_ORDER_ID]

	local channelOrderId = data and data[AttName.SDK_ORDER_ID]
	local amount = data and data[AttName.REAL_PRICE]

	if channelOrderId == nil or amount == nil then
		return nil, nil
	end

	local request = {}

	request[OpenServerConst.CHANNEL_ORDER_ID] = channelOrderId
	request[OpenServerConst.PAY_AMOUNT] = amount
	request[OpenServerConst.OPEN_ORDER_ID] = openOrderId

	return openOrderId, request
end

function RechargeChannelVivo:_onVerifyFinish(succ, index, requestData)
	if succ then
		local data = {}

		data[AttName.OPEN_ORDER_ID] = requestData[OpenServerConst.OPEN_ORDER_ID]

		SDKAgent.finishTransaction(data)
	end

	RechargeChannelVivo.super._onVerifyFinish(self, succ, index, requestData)
end

return RechargeChannelVivo
