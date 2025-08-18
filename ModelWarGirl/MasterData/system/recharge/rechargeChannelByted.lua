-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\rechargeChannelByted.lua

local ChannelUtil = require("SDK/ChannelUtil")
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelByted = Class("RechargeChannelByted", RechargeChannelBase, true)
local AttName = SDKConst.AttName

function RechargeChannelByted:ctor()
	return
end

function RechargeChannelByted:isFinishedButNotVerified(productId)
	return
end

function RechargeChannelByted:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = RechargeChannelByted.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.MONEY]
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

return RechargeChannelByted
