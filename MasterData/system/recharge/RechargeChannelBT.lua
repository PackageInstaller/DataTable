-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelBT.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelBT = Class("RechargeChannelBT", RechargeChannelBase, true)
local RechargeManager = require("System/Recharge/RechargeManager")
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local DeviceHelper = require("Helper/DeviceHelper")
local AttName = SDKConst.AttName

function RechargeChannelBT:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelBT:_getVerifyIndexAndData(data, openOrderId)
	return nil, nil
end

function RechargeChannelBT:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelBT.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local stringExtend = string.gsub(extendInfo.extend, "\\", "")
	local tableExtend = ClientUtils.string2Table(stringExtend)

	sdkOrder[AttName.EXTRA] = extendInfo.extend
	sdkOrder[AttName.PAY_CALL_BACK_URL] = tableExtend[OpenServerConst.NOTIFY_URL]

	if DeviceHelper.isAndroid() then
		sdkOrder[AttName.REAL_PRICE] = tonumber(tableExtend.money) / 100
		sdkOrder[AttName.SERVER_ID] = SvrListManager.getSelectedSvrID()
		sdkOrder[AttName.SERVER_NAME] = SvrListManager.getCurServerName()
		sdkOrder[AttName.PRODUCT_PACKAGE_NAME] = RechargeManager.nowProductName
	end

	if DeviceHelper.isIOS() then
		sdkOrder[AttName.REAL_PRICE] = tonumber(tableExtend.money)
	end

	return sdkOrder
end

return RechargeChannelBT
