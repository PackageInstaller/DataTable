local Pay_UnionPayWeb = class("Pay_UnionPayWeb")

local PayChannel = require("Pay_Channel")

function Pay_UnionPayWeb:ctor(...)
end

function Pay_UnionPayWeb:IsPayInit(channel)
	return true
end

function Pay_UnionPayWeb:hasClientReturn()
	return false
end

function Pay_UnionPayWeb:register_payresult()

end

function Pay_UnionPayWeb:register_initialStart()

end

function Pay_UnionPayWeb:register_initialEnd()

end

function Pay_UnionPayWeb:Init()
	PayChannel.PayInitial()
end

function Pay_UnionPayWeb:DoPay(pay_channel, id)
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
		local url = requestData.url

		Application.OpenURL(url)
	end
end

function Pay_UnionPayWeb:ProcessPurchase(paySuccessData)
	local rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg

	rt_receipt = nil
	rt_token = nil
	rt_pay_channel = GE.PayChannel.XipuWebSDK
	if paySuccessData then
		print("#################ProcessPurchase PayXipuWeb success")
		rt_success = true
	else
		print("#################ProcessPurchase PayXipuWeb failed")
		rt_success = false
	end
	return rt_receipt, rt_token, rt_success, rt_pay_channel, rt_msg
end

function Pay_UnionPayWeb:DoConfirmPurchases(receipt)

end


function Pay_UnionPayWeb:Clear()
	--self:clear()
end


return Pay_UnionPayWeb