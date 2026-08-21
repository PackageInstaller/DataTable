--测试支付
local Pay_TestPay = class("Pay_TestPay")

local PayChannel = require("Pay_Channel")

function Pay_TestPay:ctor(...)
end

function Pay_TestPay:IsPayInit(channel)
	return self.sdkInit
end

function Pay_TestPay:hasClientReturn()
	return true
end

function Pay_TestPay:register_payresult()

end

function Pay_TestPay:register_initialStart()

end

function Pay_TestPay:register_initialEnd()
	PayChannel.PayInitial()
	self.sdkInit = true
end


function Pay_TestPay:Init()
	if not self.bInit then
		self.bInit = true
	end
	self:register_initialEnd()
end


function Pay_TestPay:DoPay(pay_channel, id)
	local gift = Config.GetGiftInfo(id)
	PayChannel.ProcessPurchase(self, {}, true)
end

function Pay_TestPay:ProcessPurchase(receiptData, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel
	rt_pay_channel = GE.PayChannel.TestPay
	if result == true then
		rt_receipt = "this is test pay"
		rt_token = "this is test pay"
		rt_success = true
	else

		rt_receipt = nil
		rt_token = nil
		rt_success = false
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel
end

function Pay_TestPay:DoConfirmPurchases(receipt)
end


function Pay_TestPay:Clear()
	self.bInit = nil
	self.loaderId = nil
	self.sdkInit = false
end


return Pay_TestPay