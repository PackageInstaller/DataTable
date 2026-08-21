-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelGamota.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelGamota = Class("RechargeChannelGamota", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local SDKAgent = SDKAgent
local AttName = SDKConst.AttName

function RechargeChannelGamota:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelGamota:overrideStartRecharge(rechargeId)
	SDKAgent.showPaymentView()

	return true
end

return RechargeChannelGamota
