---华为
local Pay_HuaWei = class("Pay_HuaWei", function (...)
    return HuaWeiPurchaseManager.Instance
end)

local PayChannel = require("Pay_Channel")

function Pay_HuaWei:ctor(...)
end

function Pay_HuaWei:register_payresult()
	self.payResult = function(receipt, result)
		PayChannel.ProcessPurchase(self, receipt, result)
	end
end

function Pay_HuaWei:register_initialStart()
	self.InitializeStart = function()
		PayChannel.StartInitialize(self)
	end
end

function Pay_HuaWei:register_initialEnd()
	self.InitializeEnd = function(result)
		print("!!!!!!!!result", result)
		if result and not Standalone then
			print("!!!!!!!!###")
			PayChannel.PayInitial()
		end
		PayChannel.EndInitialize(self, result)
	end
end


function Pay_HuaWei:Init()
	if not self.bInit then
		self:InitializeIAP()
		self.bInit = true
	end
end


function Pay_HuaWei:DoPay(pay_channel, id)
	local gift = Config.GetGiftInfo(id)
	local storeSpecificId = gift.storeSpecificId
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
		self:PurchaseProduct(storeSpecificId)
	else
		self:PurchaseProduct(storeSpecificId)
	end
end

function Pay_HuaWei:ProcessPurchase(receiptData, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel
	local pay_channels, platform, pay_sdk = Me:getPlatform_()
	rt_pay_channel = GE.PayChannel.HuaWei
	if result == true then
		local receipt = receiptData.receipt
		local token = nil
		for i = 0, receiptData.details.Count - 1 do
			local detailData = receiptData.details[i]
			token = detailData.purchaseToken
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
	return rt_receipt, rt_token, rt_success, rt_pay_channel
end

function Pay_HuaWei:DoConfirmPurchases(receipt)
	if receipt then
		self:ConsumePurchaseWithToken(receipt)
	end
end


function Pay_HuaWei:Clear()
	self.bInit = nil
	self.loaderId = nil
	--self:clear()
end


return Pay_HuaWei