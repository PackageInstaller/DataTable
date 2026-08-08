---官方(支付宝 微信)
local Pay_Official = class("Pay_Official", function (...)
    return PayManager.Instance
end)

local PayChannel = require("Pay_Channel")

function Pay_Official:ctor(...)
end

function Pay_Official:IsPayInit(channel)
	return true
end

function Pay_Official:hasClientReturn()
	return true
end

function Pay_Official:register_payresult()
	self.payResult = function(payType, resultStatus, data)
		--token result参数还没传
		print("################lua!!!!")
		print(payType, resultStatus, data)
		PayChannel.ProcessPurchase(self, payType, resultStatus, data)
	end
end

function Pay_Official:register_initialStart()

end

function Pay_Official:register_initialEnd()

end


function Pay_Official:Init()
	PayChannel.PayInitial()
end



function Pay_Official:DoPay(pay_channel, id)
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then

	else
		local orderString = Me.__orderString

		--print("orderString1", orderString)

		local PayDataUtil = require("PayDataUtil")
		orderString = PayDataUtil.decryptPayData(orderString)

		--print("orderString2", orderString)

		if pay_channel == GE.PayChannel.Alipay then
			self:AliPay(orderString)
		elseif pay_channel == GE.PayChannel.WXpay then
			local json = require "cjson"
			local requestData = json.decode(orderString)
			local APP_ID = requestData.appId
			local MCH_ID = requestData.partnerId
			local prepayid = requestData.prepayId
			local packageValue = requestData.packageValue
			local noncestr = requestData.nonceStr
			local timestamp = requestData.timeStamp
			local sign = requestData.sign

			--[[			LuaLogger.ds("wxpay request APP_ID", APP_ID)
                        LuaLogger.ds("wxpay request MCH_ID", MCH_ID)
                        LuaLogger.ds("wxpay request prepayid", prepayid)
                        LuaLogger.ds("wxpay request packageValue", packageValue)
                        LuaLogger.ds("wxpay request noncestr", noncestr)
                        LuaLogger.ds("wxpay request timestamp", timestamp)
                        LuaLogger.ds("wxpay request sign", sign)]]
			self:WXPay(APP_ID, MCH_ID, prepayid, packageValue, noncestr, timestamp, sign)
		end

	end
end

function Pay_Official:ProcessPurchase(payType, resultStatus, data)
	local rt_receipt, rt_token, rt_success, rt_pay_channel

	if payType == "alipay" then
		rt_receipt = nil
		rt_token = nil
		rt_pay_channel = GE.PayChannel.Alipay
		---支付宝是90000代码支付成功
		if resultStatus == "9000" then
			print("#################ProcessPurchase alipay success")
			rt_success = true
		else
			print("#################ProcessPurchase alipay failed")
			rt_success = false
		end
	elseif payType == "wxpay" then
		rt_receipt = nil
		rt_token = nil
		rt_pay_channel = GE.PayChannel.WXpay
		---微信是success表示支付成功
		if resultStatus == "success" then
			print("#################ProcessPurchase wxpay success")
			rt_success = true
		else
			print("#################ProcessPurchase wxpay failed")
			rt_success = false
		end
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel
end

function Pay_Official:DoConfirmPurchases(receipt)

end


function Pay_Official:Clear()
	--self:clear()
end


return Pay_Official