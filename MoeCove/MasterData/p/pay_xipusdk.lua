local Pay_XipuSDK = class("Pay_XipuSDK")

local PayChannel = require("Pay_Channel")
local XipuWrapSdk = require "XipuWrapSdk"

function Pay_XipuSDK:ctor(...)
end

function Pay_XipuSDK:IsPayInit(channel)
	local xipuSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(XipuSdkHandler))
	if xipuSdkHandler then
		return true
		-- return xipuSdkHandler.sdkInitSuccess
	end
	return false
end

function Pay_XipuSDK:hasClientReturn()
	return true
end

function Pay_XipuSDK:register_payresult()
	local xipuSdkHandler = GameMain.Instance.gameObject:GetComponent(typeof(XipuSdkHandler))
	if xipuSdkHandler then
		xipuSdkHandler.OnPaySuccess = function(payresult)
			LuaLogger.ds("pay success################lua!!!!")
			LuaLogger.ds(payresult)
			PayChannel.ProcessPurchase(self, payresult, true)
		end
		--xipuSdkHandler.OnPayCancel = function(payresult)
		--	print("pay cancel################lua!!!!")
		--	print(payresult)
		--	PayChannel.ProcessPurchase(self, payresult, false)
		--end
		xipuSdkHandler.OnPayFailed = function(payresult)
			LuaLogger.ds("pay failed################lua!!!!")
			LuaLogger.ds(payresult)
			PayChannel.ProcessPurchase(self, payresult, false)
		end
	end

end

function Pay_XipuSDK:register_initialStart()

end

function Pay_XipuSDK:register_initialEnd()

end


function Pay_XipuSDK:Init()
	PayChannel.PayInitial()
end

function Pay_XipuSDK:DoPay(pay_channel, id)
	--if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
	if false then
	else
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

		local orderinfo = DXipuSdk.OrderInfo.New()
		orderinfo.productId = goodsID
		orderinfo.amount = amount
		orderinfo.callback = callbackUrl
		orderinfo.notifyUrl = notifyUrl

		if SDKMgr:getConfigChannel() == GE.Channel.Channel_Xipu_Lianyun then
			orderinfo.productName = requestData.goodsName
			orderinfo.productDesc = requestData.goodsName
		end
		
		local gameRoleInfo = XipuWrapSdk.GenSdkRoleDataFromData(Me:getRoleQuickData())

		DXipuSdk.Instance:Pay(orderinfo, gameRoleInfo)
	end
end

function Pay_XipuSDK:ProcessPurchase(payresult, result)
	local rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg

	rt_receipt = nil
	rt_token = nil
	rt_pay_channel = GE.PayChannel.XipuSDK
	if result then
		print("#################ProcessPurchase xipusdk success")
		rt_success = true
	else
		print("#################ProcessPurchase xipusdk failed")
		rt_success = false
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg
end

function Pay_XipuSDK:DoConfirmPurchases(receipt)

end


function Pay_XipuSDK:Clear()
	--self:clear()
end


return Pay_XipuSDK