
local ChannelPay = class("ChannelPay", function (...)
    return PayManager.Instance
end)

function ChannelPay:ctor(...)
	self.payResult = function(resultStatus, result)
		-- --token result参数还没传
		-- print("################lua!!!!")
		-- print(resultStatus, result)
		-- self:ProcessPurchase(resultStatus, result)
	end
	
end

function ChannelPay:Init()
	-- GameNetHandler:SendWaitMessage("user.payInitializeReq", {identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), deviceType = UnityEngine.Application.platform:ToInt() }, function (data)
	-- 	if data.res.ret == ActionFailReason.None then
	-- 		if data.item then
	-- 			local item = data.item
	-- 			GameNetHandler:SendWaitMessage("user.payClientCheckReq", {id = data.id }, function (data)
	-- 				if data.res.ret == ActionFailReason.None and data.success then
	-- 					UICommonUtils.PopToast(string.format("%s购买成功", Config.GetGiftInfo(item).Name))
	-- 				end
	-- 			end)
	-- 		end
	-- 	end
	-- end)
end

function ChannelPay:Clear()
	self:clear()
	--self.payResultCallBack = nil
end

-- function ChannelPay:ProcessPurchase(resultStatus, receipt)
-- 	if resultStatus == "9000" then
-- 		print("#################ProcessPurchase success")
-- 		Me:payResultReq(receipt,true, PayType.AliPay, function(success, data)
-- 			print("#################ProcessPurchase payResultReq")
-- 			self:doPayResult(receipt, true)
-- 		end)
-- 	else
-- 		print("#################ProcessPurchase failed")
-- 		Me:payResultReq(nil,false, PayType.AliPay, function(success, data)
-- 			print("#################ProcessPurchase payResultReq")
-- 			self:doPayResult(nil, false)
-- 		end)
-- 	end
-- end

-- function ChannelPay:paySuccess(data, callBack)
-- 	print("#################paySuccess 1")
-- 	if self._pay then
-- 		print("#################paySuccess 2")
-- 		self.paySuccessData = data
-- 		return
-- 	end
-- 	print("#################paySuccess 3", tablex.dump(data))
-- 	-- Me:updateRewards(data.rewards)
-- 	EngineUtil.DelayCallback(0.5, function()
-- 		GameNetHandler:SendWaitMessage("user.payClientCheckReq", {id = data.orderId }, function (data)
-- 			if data.res.ret == ActionFailReason.None and data.success then
-- 				UICommonUtils.PopToast(string.format("%s购买成功", Config.GetGiftInfo(data.item).Name))
-- 				GameMsgMgr:sendEvent(GameMsgType.PaySuccess)
-- 			end
-- 		end)
-- 	end)
-- end

-- function ChannelPay:doPayResult(receipt, result)
-- 	print("#################payResultReq 1")
-- 	if self.payResultCallBack then
-- 		print("#################payResultReq 2")
-- 		self.payResultCallBack(receipt, result)
-- 		print("#################payResultReq 3")
-- 	end
-- 	print("#################payResultReq 4")
-- 	self._pay = nil
-- 	if self.paySuccessData then
-- 		print("#################payResultReq 5")
-- 		self:paySuccess(self.paySuccessData)
-- 	end
-- 	print("#################payResultReq 6")
-- end

function ChannelPay:PayResultCallBack(func)
	self.payResult = func
end

function ChannelPay:Pay(orderString)
	self._pay = true
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
		
	else
		self:AliPay(orderString)
	end
end

return ChannelPay