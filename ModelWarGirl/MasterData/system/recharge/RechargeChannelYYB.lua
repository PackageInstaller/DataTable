-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelYYB.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelYYB = Class("RechargeChannelYYB", RechargeChannelBase, true)
local SDKCore = require("SDK/SDKCore")
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local UrlConfig = require("Network/UrlConfig")
local UIManager = UIManager
local AttName = SDKConst.AttName
local PAY_ZONE_ID = 1

function RechargeChannelYYB:ctor()
	self._receiptUrlHead = UrlConfig.Receipt
	self._receiptUrlTail = "yyb"
end

function RechargeChannelYYB:getOpenOrderReqExtendStr()
	local data = {}
	local userData = SDKCore.getUserData()
	local serverId, serverName = SvrListManager.getConnectServer()

	data[OpenServerConst.OPEN_ID] = userData[AttName.TENCENT_OPEN_ID]
	data[OpenServerConst.APP_ID] = userData[AttName.APP_ID]
	data[OpenServerConst.PF] = userData[AttName.PF]
	data[OpenServerConst.PF_KEY] = userData[AttName.PFKEY]
	data[OpenServerConst.SESSION_ID] = userData[AttName.SESSION_ID]
	data[OpenServerConst.SESSION_TYPE] = userData[AttName.SESSION_TYPE]
	data[OpenServerConst.OPEN_KEY] = userData[AttName.OPENKEY]
	data[OpenServerConst.ZONE_ID] = PAY_ZONE_ID

	return ClientUtils.table2String(data)
end

function RechargeChannelYYB:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelYYB.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.USER_ID] = channel_account
	sdkOrder[AttName.REAL_PRICE] = extendInfo.need_money
	sdkOrder[AttName.PAY_ZONE_ID] = PAY_ZONE_ID

	return sdkOrder
end

function RechargeChannelYYB:sdkPay(product_id, orderid, channel_account, svr_nodeid, extendInfo)
	local sdkOrder = self:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo)
	local price = sdkOrder[AttName.REAL_PRICE]

	price = price and tonumber(price)

	if price then
		if price > 0 then
			SDKAgent.sdkPay(ClientUtils.table2String(sdkOrder))
		else
			local confirmFunc = Functor(RechargeChannelYYB._onConfirmBuyWithBalance, self, product_id, orderid, channel_account, svr_nodeid, extendInfo)

			UIManager.showConfirm(UIConst.CONFIRM_TWOBTN, Lang.get(5), Lang.get(30057), confirmFunc, nil)
		end
	end
end

function RechargeChannelYYB:_getVerifyIndexAndData(data, openOrderId)
	openOrderId = data and data[AttName.OPEN_ORDER_ID]

	local productId = data and data[AttName.PRODUCT_ID]

	if openOrderId == nil then
		return nil, nil
	end

	local userData = SDKCore.getUserData()
	local serverId, serverName = SvrListManager.getConnectServer()
	local request = {}

	request[OpenServerConst.OPEN_ORDER_ID] = openOrderId
	request[OpenServerConst.OPEN_ID] = userData[AttName.TENCENT_OPEN_ID]
	request[OpenServerConst.APP_ID] = userData[AttName.APP_ID]
	request[OpenServerConst.PF] = userData[AttName.PF]
	request[OpenServerConst.PF_KEY] = userData[AttName.PFKEY]
	request[OpenServerConst.SESSION_ID] = userData[AttName.SESSION_ID]
	request[OpenServerConst.SESSION_TYPE] = userData[AttName.SESSION_TYPE]
	request[OpenServerConst.OPEN_KEY] = userData[AttName.OPENKEY]
	request[OpenServerConst.ZONE_ID] = PAY_ZONE_ID
	request[OpenServerConst.BILL_NO] = openOrderId
	request[OpenServerConst.PRODUCT_ID] = productId

	return productId, request
end

function RechargeChannelYYB:_onVerifyFinish(succ, index, requestData)
	if succ then
		local data = {}

		data[AttName.OPEN_ORDER_ID] = requestData[OpenServerConst.OPEN_ORDER_ID]

		SDKAgent.finishTransaction(data)
	end

	RechargeChannelYYB.super._onVerifyFinish(self, succ, index, requestData)
end

function RechargeChannelYYB:_onConfirmBuyWithBalance(product_id, orderid, channel_account, svr_nodeid, extendInfo)
	local data = {}

	data[AttName.PAY_RESULT] = "1"
	data[AttName.OPEN_ORDER_ID] = orderid
	data[AttName.PRODUCT_ID] = product_id

	SDKAgent._onPayResult(data)
end

return RechargeChannelYYB
