-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\rechargeChannelPlat.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local rechargeChannelPlat = Class("rechargeChannelPlat", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local RechargeConst = require("System/Recharge/RechargeConst")
local AttName = SDKConst.AttName
local SDKPayType = SDKConst.PayType

function rechargeChannelPlat:ctor()
	self._receiptUrlTail = nil
end

function rechargeChannelPlat:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = rechargeChannelPlat.super.genSDKDataFromOrder(self, product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	sdkOrder[AttName.REAL_PRICE] = extendInfo[OpenServerConst.COST_MONEY]
	sdkOrder[AttName.PAY_SIGN] = extendInfo[OpenServerConst.PAY_SIGN]
	sdkOrder[AttName.PAY_CALL_BACK_URL] = extendInfo[OpenServerConst.NOTIFY_URL]

	local signParam = extendInfo.sign_param

	sdkOrder[AttName.SERVER_ID] = signParam.server_id
	sdkOrder[AttName.SERVER_NAME] = signParam.server_name
	sdkOrder[AttName.EXTRA] = signParam.extend
	sdkOrder[AttName.PRODUCT_PACKAGE_NAME] = signParam.props_name
	sdkOrder[AttName.ROLE_ID] = signParam.game_player_id
	sdkOrder[AttName.ROLE_NAME] = signParam.game_player_name

	return sdkOrder
end

return rechargeChannelPlat
