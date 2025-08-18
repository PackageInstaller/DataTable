-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelIAB.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelIAB = Class("RechargeChannelIAB", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName

function RechargeChannelIAB:ctor()
	self._receiptUrlTail = "google"
end

function RechargeChannelIAB:_getVerifyIndexAndData(data, openOrderId)
	local productId = data and data[AttName.PRODUCT_ID]

	if productId == nil then
		return nil, nil
	end

	local request = {}

	request[OpenServerConst.UID] = self:_getPlayerUid()
	request[OpenServerConst.PRODUCT_ID] = productId
	request[OpenServerConst.RECEIPT] = data[AttName.PAY_RESULT_DATA]
	request[OpenServerConst.OPEN_ORDER_ID] = openOrderId
	request[OpenServerConst.PAY_SIGN] = data[AttName.PAY_RESULT_SIGNATURE]

	return productId, request
end

function RechargeChannelIAB:_onVerifyFinish(succ, index, requestData)
	if succ then
		local receipt = requestData[OpenServerConst.RECEIPT]
		local purchaseData = ClientUtils.string2Table(receipt)
		local purchaseToken = purchaseData.purchaseToken
		local data = {}

		data[AttName.PAY_TOKEN] = purchaseToken

		SDKAgent.finishTransaction(data)
	end

	RechargeChannelIAB.super._onVerifyFinish(self, succ, index, requestData)
end

return RechargeChannelIAB
