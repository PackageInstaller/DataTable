-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelHuawei.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelHuawei = Class("RechargeChannelHuawei", RechargeChannelBase, true)
local UrlConfig = require("Network/UrlConfig")
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName

function RechargeChannelHuawei:ctor()
	self._receiptUrlHead = UrlConfig.Receipt
	self._receiptUrlTail = "huawei"
end

function RechargeChannelHuawei:_getVerifyIndexAndData(data, openOrderId)
	local productId = data and data[AttName.PRODUCT_ID]
	local channelOrderId = data and data[AttName.SDK_ORDER_ID]
	local token = data and data[AttName.PAY_TOKEN]

	if channelOrderId == nil or token == nil or productId == nil then
		return nil, nil
	end

	local request = {}

	request[OpenServerConst.UID] = self:_getPlayerUid()
	request[OpenServerConst.PRODUCT_ID] = productId
	request[OpenServerConst.CHANNEL_ORDER_ID] = channelOrderId
	request[OpenServerConst.RECEIPT] = token

	return productId, request
end

function RechargeChannelHuawei:_onVerifyFinish(succ, index, requestData)
	if succ then
		local data = {}

		data[AttName.PAY_TOKEN] = requestData[OpenServerConst.RECEIPT]

		SDKAgent.finishTransaction(data)
	end

	RechargeChannelHuawei.super._onVerifyFinish(self, succ, index, requestData)
end

return RechargeChannelHuawei
