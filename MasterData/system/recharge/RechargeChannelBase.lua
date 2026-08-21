-- chunkname: @E:/AntMan/AntMan_Android_pub1/Assets/Code/.LuaCode/System\\Recharge\\RechargeChannelBase.lua

local strClassName = "RechargeChannelBase"
local RechargeChannelBase = Class(strClassName)
local SDKConst = require("SDK/SDKConst")
local OpenServerConst = require("Network/OpenServerConst")
local UrlConfig = require("Network/UrlConfig")
local RechargeConst = require("System/Recharge/RechargeConst")
local EventCenter = EventCenter
local AttName = SDKConst.AttName
local HttpUtils = Framework.Network.HttpUtils
local ResponseCode = SDKConst.ResponseCode
local ChannelUtil = ChannelUtil
local SDKAgent = SDKAgent
local VERIFY_REQUEST_CD = 30

function RechargeChannelBase:ctor()
	self._rechargeChannel = ChannelUtil.getRechargeChannel()
	self.__verifyRequestCache = {}
	self._receiptUrlHead = UrlConfig.ReceiptIG
	self._receiptUrlTail = nil
end

function RechargeChannelBase:destroy()
	return
end

function RechargeChannelBase:overrideStartRecharge(rechargeId)
	return false
end

function RechargeChannelBase:getOpenOrderReqExtendStr()
	return nil
end

function RechargeChannelBase:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = {}

	sdkOrder[AttName.OPEN_ORDER_ID] = orderid
	sdkOrder[AttName.ZONE_ID] = svr_nodeid
	sdkOrder[AttName.PRODUCT_ID] = product_id

	return sdkOrder
end

function RechargeChannelBase:sdkPay(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)
	local sdkOrder = self:genSDKDataFromOrder(product_id, orderid, channel_account, svr_nodeid, extendInfo, gift_type)

	SDKAgent.sdkPay(ClientUtils.table2String(sdkOrder))

	return true
end

function RechargeChannelBase:isFinishedButNotVerified(productId)
	return self.__verifyRequestCache[productId] ~= nil
end

function RechargeChannelBase:verifyAll()
	for index, _ in pairs(self.__verifyRequestCache) do
		self:_verifyTransaction(index, false)
	end
end

function RechargeChannelBase:verifyWithProductId(productId, isForce)
	self:_verifyTransaction(productId, isForce)
end

function RechargeChannelBase:verifyOnRechargeFinish(data, openOrderId)
	local index, requestData = self:_getVerifyIndexAndData(data, openOrderId)

	if index and requestData then
		self.__verifyRequestCache[index] = requestData

		self:verifyAll()
	end
end

function RechargeChannelBase:_getVerifyIndexAndData(data, openOrderId)
	return nil, nil
end

function RechargeChannelBase:_onVerifyFinish(succ, index, requestData)
	if succ and index ~= nil then
		self.__verifyRequestCache[index] = nil
	end
end

function RechargeChannelBase:_getVerificationReceiptUrl()
	local url

	if self._receiptUrlHead ~= nil and self._receiptUrlTail ~= nil then
		url = self._receiptUrlHead

		url:SetUrlAppend(self._receiptUrlTail)
	end

	return url
end

function RechargeChannelBase:_verifyTransaction(index, isForce)
	local playerUid
	local data = self.__verifyRequestCache[index]

	if isForce then
		playerUid = self:_getPlayerUid()
	else
		playerUid = data[OpenServerConst.UID] or self:_getPlayerUid()
	end

	if data == nil or playerUid == nil then
		return
	end

	if data.lastVerifyTime == nil or data.lastVerifyTime + VERIFY_REQUEST_CD < Time.time then
		local url = self:_getVerificationReceiptUrl()

		if url ~= nil then
			data[OpenServerConst.RECEIPT_FORCE_APPLY] = isForce and 1 or 0
			data[OpenServerConst.UID] = playerUid
			data.lastVerifyTime = nil

			HttpHelper.post(url, ClientUtils.table2String(data), self:_getVerifyReceiptCallback(index, data), 1)

			data.lastVerifyTime = Time.time
		end
	end
end

function RechargeChannelBase:_getVerifyReceiptCallback(index, requestData)
	return function(responseCode, dataString)
		local succ = false

		if responseCode == 0 then
			local data = ClientUtils.string2Table(dataString)

			succ = (data and data.code) == 0
		end

		self:_onVerifyFinish(succ, index, requestData)
	end
end

function RechargeChannelBase:_getPlayerUid()
	local ca = CurAvatar

	if ca and ca.isAvatar then
		return ca.uid
	end

	return nil
end

return RechargeChannelBase
