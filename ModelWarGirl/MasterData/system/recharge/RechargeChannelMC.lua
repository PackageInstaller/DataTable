-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelMC.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelMC = Class("RechargeChannelMC", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local RechargeConst = require("System/Recharge/RechargeConst")
local AttName = SDKConst.AttName
local MsgManager = MsgManager

function RechargeChannelMC:ctor()
	self._receiptUrlTail = "mycard"
end

function RechargeChannelMC:_getVerifyIndexAndData(data, openOrderId)
	local result = ClientUtils.string2Table(data[AttName.PAY_RESULT_DATA])
	local openOrderId = result and result.facTradeSeq

	if openOrderId == nil then
		return nil, nil
	end

	local request = {}

	request[OpenServerConst.OPEN_ORDER_ID] = openOrderId

	return openOrderId, request
end

function RechargeChannelMC:_onVerifyFinish(succ, index, requestData)
	if not succ then
		MsgManager.notice(RechargeConst.VERIFY_ERROR_MSG_MC)
	end

	RechargeChannelMC.super._onVerifyFinish(self, succ, index, requestData)
end

return RechargeChannelMC
