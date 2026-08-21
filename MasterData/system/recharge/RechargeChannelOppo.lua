-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelOppo.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelOppo = Class("RechargeChannelOppo", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local UrlConfig = require("Network/UrlConfig")
local AttName = SDKConst.AttName

function RechargeChannelOppo:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelOppo:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelOppo.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.USER_ID] = channel_account
	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.COST_MONEY]
	sdkOrder[AttName.ITEM_NAME] = extendInfo[OpenServerConst.PRODUCT_NAME]
	sdkOrder[AttName.ITEM_DESC] = extendInfo[OpenServerConst.PRODUCT_DESC]
	sdkOrder[AttName.EXTRA] = extendInfo[OpenServerConst.PAY_ATTACH]
	sdkOrder[AttName.PAY_CALL_BACK_URL] = extendInfo[OpenServerConst.NOTIFY_URL]

	return sdkOrder
end

return RechargeChannelOppo
