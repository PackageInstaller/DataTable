
local UnityPurchaser = class("UnityPurchaser", function (...)
    return UnityPurchaseManager.Instance
end)

function UnityPurchaser:ctor(...)
	self.payResult = function(receipt, result)
		self:ProcessPurchase(receipt, result)
	end

	self.InitializeStart = function()
		self:StartInitialize()
	end

	self.InitializeEnd = function(result)
		if result and not Standalone then
			GameNetHandler:SendWaitMessage("user.payInitializeReq", {identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), deviceType = UnityEngine.Application.platform:ToInt() }, function (data)
				if data.ret == ActionFailReason.None then
					if data.item then
						local item = data.item
						GameNetHandler:SendWaitMessage("user.payClientCheckReq", {id = data.id }, function (data)
							if data.ret == ActionFailReason.None and data.success then
								if item > 0 then
									UICommonUtils.PopToast(string.format("%s购买成功", Config.GetGiftInfo(item).Name))
								else
									print("item null")
								end
							end
						end)
					end
				end
			end)
		end
		self:EndInitialize(result)
	end
end

function UnityPurchaser:getPurchaseIDWithSpecificID(str)
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

function UnityPurchaser:Init()
	if not self.bInit then
		local gifts = Config.GetAllGiftInfo()
		local products = System.Collections.Generic.List_UnityPurchaseManager_UnityPurchaseProduct.New()
		for i, v in pairs(gifts) do
			if v.Cost_type == 1 and v.storeSpecificId and string.len(v.storeSpecificId) > 0 and v.noUse == 0 then
				local prouct = UnityPurchaseManager.UnityPurchaseProduct.New()
				prouct.id = self:getPurchaseIDWithSpecificID(v.storeSpecificId)
				prouct.storeSpecificId = "." .. v.storeSpecificId
				prouct.productType = v.productType
				products:Add(prouct)
			end
		end
		
		self:InitializePurchasing(products)
		self.bInit = true
	end
end

function UnityPurchaser:Clear()
	self.bInit = nil
	self.loaderId = nil
    self:clear()
end

function UnityPurchaser:ProcessPurchase(receiptData, result)
	print("ProcessPurchase!!!!")
	if result == true then
		local receipt = receiptData.receipt
		local token = nil
		for i = 0, receiptData.details.Count - 1 do
			local detailData = receiptData.details[i]
			token = detailData.purchaseToken
			break
		end
		Me:payValidateReq(receipt, token, true, PayType.Unity, function(success, data)
			if data.ret == ActionFailReason.PayValidate_Error then
				---支付异常
				return
			end
			if data.ret == ActionFailReason.PayValidate_Pending then
				---未知支付结果
				return
			end
			if data.ret == ActionFailReason.PayValidateFailed_CheckError then
				---不满足购买条件
				return
			end
			if data.ret == ActionFailReason.None or data.ret == ActionFailReason.PayValidateFailed or data.ret == ActionFailReason.PayOrderHaveDone or data.ret == ActionFailReason.PayRefund_Currency then
				self:ConfirmPurchases(receipt)
			end
			self:doPayResult(data.payOrder, data.ret == ActionFailReason.None)
			if data.rewards and tablex.size(data.rewards) > 0 then
				UICommonUtils.PopRewardToast(data.rewards)
			end
			GameNetHandler:SendWaitMessage("user.payClientCheckReq", {id = data.orderId }, function (data)
				if data.ret == ActionFailReason.None and data.success then
					UICommonUtils.PopToast(string.format("%s购买成功", Config.GetGiftInfo(data.item).Name))
					GameMsgMgr:sendEvent(GameMsgType.PaySuccess)
				end
			end)
		end)
	else
		local receipt
		if receiptData ~= nil then
			receipt = receiptData.receipt
		end
		Me:payValidateReq(nil, nil, false, PayType.Unity, function(success, data)
			self:doPayResult("", false)
		end)
	end
end

function UnityPurchaser:StartInitialize()
	self.loaderId = UIMgr:startLoad(0)
	--UICommonUtils.PopToast("初始化IAP")
end

function UnityPurchaser:EndInitialize(result)
    --UICommonUtils.PopToast("初始化IAP结束")
	if self.loaderId then
		UIMgr:endLoad(self.loaderId)
		self.loaderId = nil
	end
	if self.initializeCallBack then
		self.initializeCallBack(result and true or false)
	end
	--UICommonUtils.PopToast("初始化IAP" .. (result and "成功" or "失败"))
end

function UnityPurchaser:doPayResult(receipt, result)
	if self.payResultCallBack then
		self.payResultCallBack(receipt, result)
	end
end

function UnityPurchaser:PayResultCallBack(func)
	self.payResultCallBack = func
end

function UnityPurchaser:InitializeCallBack(func)
	self.initializeCallBack = func
end


function UnityPurchaser:Pay(id)
	local gift = Config.GetGiftInfo(id)
	local storeSpecificId = gift.storeSpecificId
	if Application.platform == UnityEngine.RuntimePlatform.WindowsPlayer or Application.platform == UnityEngine.RuntimePlatform.WindowsEditor or Application.platform == UnityEngine.RuntimePlatform.OSXEditor then
		self:BuyProductID(storeSpecificId)
	else
		self:BuyProductID(storeSpecificId)
	end
end

return UnityPurchaser