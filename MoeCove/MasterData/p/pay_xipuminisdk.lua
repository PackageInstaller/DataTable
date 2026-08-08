local Pay_XipuMiniSDK = class("Pay_XipuMiniSDK")

local PayChannel = require("Pay_Channel")
local XipuMiniWrapSdk = require "XipuMiniWrapSdk"

function Pay_XipuMiniSDK:ctor(...)
end

function Pay_XipuMiniSDK:IsPayInit(channel)
	return true
end

function Pay_XipuMiniSDK:hasClientReturn()
	return false
end

function Pay_XipuMiniSDK:register_payresult()

end

function Pay_XipuMiniSDK:register_initialStart()

end

function Pay_XipuMiniSDK:register_initialEnd()

end

function Pay_XipuMiniSDK:Init()
	LuaLogger.ds("Pay_XipuMiniSDK Init!!!")
	PayChannel.PayInitial()
end

function Pay_XipuMiniSDK:DoPay(pay_channel, id)
	if EngineUtil.IsWebGL() then
		if SDKMgr.h5autiting and SDKMgr:needHidePay() then
			return
		end

		local orderString = Me.__orderString

		print("orderString1", orderString)

		local PayDataUtil = require("PayDataUtil")
		orderString = PayDataUtil.decryptPayData(orderString)

		print("orderString2", orderString)

		local json = require "cjson"
		local requestData = json.decode(orderString)
		local pay_order_id = requestData.cpOrderID
		local goodsID = requestData.goodsID
		local amount = requestData.amount
		local callbackUrl = pay_order_id
		local notifyUrl = requestData.notifyUrl

		local orderinfo = DXipuMiniSdk.XipuMiniPayData.New()
		orderinfo.product_id = goodsID
		orderinfo.amount = amount
		orderinfo.callback = callbackUrl
		orderinfo.notify_url = notifyUrl
		local gameRoleInfo = XipuMiniWrapSdk.GenSdkRoleDataFromData(Me:getRoleQuickData())

		local succ = function(payresult)
			print("pay success################lua!!!!")
			print(payresult)
			PayChannel.ProcessPurchase(self, payresult, true)
		end
		local fail = function(payresult)
			print("pay failed################lua!!!!")
			print(payresult)
			PayChannel.ProcessPurchase(self, payresult, false)
		end
		DXipuMiniSdk.Pay(orderinfo, gameRoleInfo, succ, fail)
	end
end

function Pay_XipuMiniSDK:ProcessPurchase(payresult, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg

	rt_receipt = nil
	rt_token = nil
	rt_pay_channel = GE.PayChannel.XipuMiniSDK
	if result then
		print("#################ProcessPurchase xipuMinisdk success")
		rt_success = true
	else
		print("#################ProcessPurchase xipuMinisdk failed")
		rt_success = false
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg
end

function Pay_XipuMiniSDK:DoConfirmPurchases(receipt)

end

function Pay_XipuMiniSDK:Clear()
	--self:clear()
end

return Pay_XipuMiniSDK