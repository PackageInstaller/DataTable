-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelXiaoMi.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelXiaoMi = Class("RechargeChannelXiaoMi", RechargeChannelBase, true)
local UrlConfig = require("Network/UrlConfig")
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName

function RechargeChannelXiaoMi:ctor()
	self._receiptUrlHead = UrlConfig.Receipt
	self._receiptUrlTail = "xiaomi"
end

function RechargeChannelXiaoMi:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelXiaoMi.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.USER_ID] = channel_account
	sdkOrder[AttName.REAL_PRICE] = extendInfo.cost_money

	return sdkOrder
end

return RechargeChannelXiaoMi
