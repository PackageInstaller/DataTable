-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelUC.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelUC = Class("RechargeChannelUC", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local RechargeConst = require("System/Recharge/RechargeConst")
local AttName = SDKConst.AttName
local SDKPayType = SDKConst.PayType

function RechargeChannelUC:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelUC:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelUC.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.USER_ID] = channel_account
	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.COST_MONEY]
	sdkOrder[AttName.PAY_SIGN_TYPE] = extendInfo[OpenServerConst.PAY_SIGN_TYPE]
	sdkOrder[AttName.PAY_SIGN] = extendInfo[OpenServerConst.PAY_SIGN]

	return sdkOrder
end

return RechargeChannelUC
