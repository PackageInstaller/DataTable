---Unity支付(googleplay iOS)
local Pay_Unity = class("Pay_Unity", function (...)
    return AppleIAPManager.Instance
end)

local PayChannel = require("Pay_Channel")
local cjson = require "cjson"
function Pay_Unity:ctor(...)
end

function Pay_Unity:IsPayInit(channel)
	return self.sdkInit
end

function Pay_Unity:hasClientReturn()
	return true
end

function Pay_Unity:register_payresult()
	LuaLogger.ds("Pay_Unity:register_payresult   111111")
	self.payResult = function(receipt, result)

		LuaLogger.ds("Pay_Unity:payResult receipt:------------complete", tablex.dump(receipt))
		PayChannel.ProcessPurchase(self, receipt, result)
	end

	LuaLogger.ds("Pay_Unity:register_payresult   111111")
end

function Pay_Unity:register_initialStart()
	self.AppleInitializeStart = function()

		LuaLogger.ds("Pay_Unity:AppleInitializeStart   Begin")

		PayChannel.StartInitialize(self)

		LuaLogger.ds("Pay_Unity:AppleInitializeStart   End")
	end
end

function Pay_Unity:register_initialEnd()
	self.AppleInitializeEnd = function(result)
		LuaLogger.ds("Pay_Unity:AppleInitializeEnd   Begin")
		print("!!!!!!!!result", result)
		if result and not Standalone then
			print("!!!!!!!!###")
			PayChannel.PayInitial()
		end
		self.sdkInit = result
		PayChannel.EndInitialize(self, result)
		LuaLogger.ds("Pay_Unity:AppleInitializeEnd   End")
	end
end


function Pay_Unity:Init()
	if not self.bInit then
		local cache = {}
		local gifts = Config.GetAllGiftInfo()
		local products = System.Collections.Generic.List_AppleIAPManager_ApplePurchaseProduct.New()
		for i, v in pairs(gifts) do
			if v.Cost_type == 1 and v.storeSpecificId and string.len(v.storeSpecificId) > 0 and v.noUse == 0 and not cache[v.storeSpecificId] then
				local prouct = AppleIAPManager.ApplePurchaseProduct.New()
				prouct.id = self:_getPurchaseIDWithSpecificID(v.storeSpecificId)
				prouct.storeSpecificId = "." .. v.storeSpecificId
				prouct.productType = v.productType
				products:Add(prouct)
				cache[v.storeSpecificId] = true
			end
		end

		self:InitializePurchasing(products)
		self.bInit = true
	end
end


function Pay_Unity:DoPay(pay_channel, id)
	local gift = Config.GetGiftInfo(id)
	local storeSpecificId = gift.storeSpecificId
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
		self:BuyProductID(storeSpecificId)
	else
		self:BuyProductID(storeSpecificId)
	end
end

function Pay_Unity:ProcessPurchase(receiptData, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel
	local pay_channels, platform, pay_sdk = Me:getPlatform_()
	local rt_transactionID,rt_productID
	rt_pay_channel = pay_channels[1]
	if result == true then
		local receipt = receiptData.receipt
		local token = nil
		for i = 0, receiptData.details.Count - 1 do
			local detailData = receiptData.details[i]
			token = detailData.purchaseToken
			rt_transactionID = detailData.transactionID
			rt_productID = detailData.productID
			break
		end
		rt_receipt = receipt
		rt_token = token
		rt_success = true
	else

		rt_receipt = nil
		rt_token = nil
		rt_success = false
	end
	local receiptObj = {}
	receiptObj.Payload = rt_receipt
	receiptObj.TransactionID = rt_transactionID
	receiptObj.Store = rt_productID
	LuaLogger.ds("rt_receipt ==",rt_receipt)
	LuaLogger.ds("rt_transactionID ==",rt_transactionID)
	LuaLogger.ds("rt_productID ==",rt_productID)

	local receiptJson = cjson.encode(receiptObj)
	LuaLogger.ds("Pay_Unity:ProcessPurchase receiptJson", receiptJson)
	return receiptJson, rt_token, rt_success, rt_pay_channel
end

function Pay_Unity:DoConfirmPurchases(receipt)
	if receipt then
		self:ConfirmPurchases(receipt)
	end
end


function Pay_Unity:Clear()
	self.bInit = nil
	self.loaderId = nil
	self.sdkInit = false
	self:clear()
end

function Pay_Unity:_getPurchaseIDWithSpecificID(str)
	local k = "%."
	local ts = string.reverse(str)
	local  _, i = string.find(ts, k)
	if i then
		local m = string.len(ts) - i + 1
		return string.sub(str, m+1, string.len(str))
	else
		return str
	end
end


return Pay_Unity