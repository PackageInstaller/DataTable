-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelIAP.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelIAP = Class("RechargeChannelIAP", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName

function RechargeChannelIAP:ctor()
	self._receiptUrlTail = "apple"
end

function RechargeChannelIAP:_getVerifyIndexAndData(data, openOrderId)
	local productId = data and data[AttName.PRODUCT_ID]

	if productId == nil then
		return nil, nil
	end

	local request = {}

	request[OpenServerConst.UID] = self:_getPlayerUid()
	request[OpenServerConst.PRODUCT_ID] = productId
	request[OpenServerConst.RECEIPT] = data[AttName.PAY_RESULT_DATA]
	request[OpenServerConst.OPEN_ORDER_ID] = openOrderId

	return productId, request
end

function RechargeChannelIAP:_onVerifyFinish(succ, index, requestData)
	if succ then
		local data = {}

		data[AttName.PRODUCT_ID] = requestData[OpenServerConst.PRODUCT_ID]

		SDKAgent.finishTransaction(data)
	end

	RechargeChannelIAP.super._onVerifyFinish(self, succ, index, requestData)
end

return RechargeChannelIAP
