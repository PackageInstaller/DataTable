-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelXgjoy.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelXgjoy = Class("RechargeChannelXgjoy", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local RechargeConst = require("System/Recharge/RechargeConst")
local AttName = SDKConst.AttName
local SDKPayType = SDKConst.PayType

function RechargeChannelXgjoy:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelXgjoy:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelXgjoy.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local payType = extendInfo.pay_type

	if payType == RechargeConst.PAY_TYPE.WNPAY then
		sdkOrder[AttName.PAY_TYPE] = SDKPayType.WNPAY

		local wxRequest = ClientUtils.string2Table(extendInfo.channel_return)

		sdkOrder[AttName.SDK_ORDER_ID] = wxRequest.prepayid
		sdkOrder[AttName.RANDOM_STR] = wxRequest.noncestr
		sdkOrder[AttName.TIME_STAMP] = wxRequest.timestamp
		sdkOrder[AttName.PAY_SIGN] = wxRequest.sign
	elseif payType == RechargeConst.PAY_TYPE.ABPAY then
		sdkOrder[AttName.PAY_TYPE] = SDKPayType.ABPAY
		sdkOrder[AttName.SDK_ORDER_ID] = extendInfo.channel_return
	end

	return sdkOrder
end

return RechargeChannelXgjoy
