-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\rechargeChannelKomoe.lua

local ChannelUtil = require("SDK/ChannelUtil")
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelKomoe = Class("RechargeChannelKomoe", RechargeChannelBase, true)
local AttName = SDKConst.AttName

function RechargeChannelKomoe:ctor()
	return
end

function RechargeChannelKomoe:isFinishedButNotVerified(productId)
	return
end

function RechargeChannelKomoe:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelKomoe.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.MONEY]
	sdkOrder[AttName.PAY_SIGN] = extendInfo[OpenServerConst.PAY_SIGN]
	sdkOrder[AttName.PAY_CALL_BACK_URL] = extendInfo[OpenServerConst.NOTIFY_URL]
	sdkOrder[AttName.EXTRA] = extendInfo.extend
	sdkOrder[AttName.SERVER_ID] = extendInfo.server_id
	sdkOrder[AttName.SERVER_NAME] = extendInfo.server_name

	if gift_type == 20 then
		sdkOrder.product_type = "3"
	else
		sdkOrder.product_type = "1"
	end

	return sdkOrder
end

return RechargeChannelKomoe
