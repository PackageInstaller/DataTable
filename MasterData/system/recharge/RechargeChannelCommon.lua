-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelCommon.lua

local RechargeChannelBase = require("System/Recharge/RechargeChannelBase")
local RechargeChannelCommon = Class("RechargeChannelCommon", RechargeChannelBase, true)
local OpenServerConst = require("Network/OpenServerConst")
local SDKConst = require("SDK/SDKConst")
local AttName = SDKConst.AttName

function RechargeChannelCommon:ctor()
	self._receiptUrlTail = nil
end

function RechargeChannelCommon:_getVerifyIndexAndData(data, openOrderId)
	return nil, nil
end

return RechargeChannelCommon
