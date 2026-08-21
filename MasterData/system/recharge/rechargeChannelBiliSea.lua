-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\rechargeChannelBiliSea.lua

local ChannelUtil = require("SDK/ChannelUtil")
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelBiliSea = Class("RechargeChannelBiliSea", RechargeChannelBase, true)
local AttName = SDKConst.AttName

function RechargeChannelBiliSea:ctor()
	return
end

function RechargeChannelBiliSea:isFinishedButNotVerified(productId)
	return
end

function RechargeChannelBiliSea:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelBiliSea.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

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

return RechargeChannelBiliSea
