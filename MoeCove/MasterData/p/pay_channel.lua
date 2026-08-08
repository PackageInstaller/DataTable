
local Pay_Channel = {}

function Pay_Channel.ctor(channel)
	channel.receipt_cache = {}
	channel:register_payresult()
	channel:register_initialStart()
	channel:register_initialEnd()
end


function Pay_Channel.Clear(channel)
	channel.loaderId = nil
	channel:Clear()
end


function Pay_Channel.Init(channel)
	channel:Init()
end


function Pay_Channel.PayResultCallBack(channel, func)
	channel.payResultCallBack = func
end

function Pay_Channel.InitializeCallBack(channel, func)
	channel.initializeCallBack = func
end

function Pay_Channel.ProcessPurchase(channel, ...)
	if channel._processPurchase then
		return
	end
	channel._processPurchase = true
	local self = channel
	local receipt, token, success, pay_channel, msg = self:ProcessPurchase(...)
	print("ProcessPurchase!!!!")
	if success then
		print("receipt!!!!", receipt)
		print("token!!!!", token)
		Me:payResultReq(receipt, token, true, pay_channel, nil, function(success, data)
			print("#################ProcessPurchase unitypay payResultReq")
			print("#################data.receipt_order", data.receipt_order)
			if data.receipt_order then
				self.receipt_cache[data.receipt_order] = receipt
			end

			Pay_Channel._doPayResult(channel, pay_channel,receipt, true)
		end)
	else
		Me:payResultReq(receipt, token, false, pay_channel, msg, function(success, data)
			if data.receipt_order then
				self.receipt_cache[data.receipt_order] = receipt
			end
			Pay_Channel._doPayResult(channel, pay_channel,"", false)
		end)
	end
end

function Pay_Channel.StartInitialize(channel)
	channel.loaderId = UIMgr:startLoad(0)
	--UICommonUtils.PopToast("初始化IAP")
end

function Pay_Channel.EndInitialize(channel, result)
    --UICommonUtils.PopToast("初始化IAP结束")
	if channel.loaderId then
		UIMgr:endLoad(channel.loaderId)
		channel.loaderId = nil
	end
	if channel.initializeCallBack then
		channel.initializeCallBack(result and true or false)
	end
	--UICommonUtils.PopToast("初始化IAP" .. (result and "成功" or "失败"))
end

function Pay_Channel._doPayResult(channel, pay_channel, receipt, result)
	local self = channel
	print("#################payResultReq 1")
	if self.payResultCallBack then
		print("#################payResultReq 2")
		self.payResultCallBack(pay_channel, receipt, result)
		print("#################payResultReq 3")
	end
	print("#################payResultReq 4")
	self._pay = nil
	self._processPurchase = nil
	if self.paySuccessData then
		print("#################payResultReq 5")
		Pay_Channel.paySuccess(self, self.paySuccessData)
		self.paySuccessData = nil
	end
	print("#################payResultReq 6")
end


function Pay_Channel.paySuccess(channel, data, callBack)
	local self = channel
	print("#################paySuccess 1", tablex.dump(data.success))
	if self._pay then
		print("#################paySuccess 2")
		self.paySuccessData = data
		Pay_Channel.onFocus(channel)
		return
	end

	if data.reason == ActionFailReason.PayValidate_Error then
		---支付异常
		return
	end
	if data.reason == ActionFailReason.PayValidate_Pending then
		---未知支付结果
		return
	end
	if data.reason == ActionFailReason.PayValidateFailed_CheckError then
		---不满足购买条件
		return
	end
	if not data.reason or data.reason == ActionFailReason.None or data.reason == ActionFailReason.PayValidateFailed or data.reason == ActionFailReason.PayOrderHaveDone or data.reason == ActionFailReason.PayRefund_Currency then
		local receipt_order = data.receipt_order
		print("#################!!data.receipt_order", data.receipt_order)
		if receipt_order then
			local receipt = self.receipt_cache[receipt_order]
			if receipt then
				self:DoConfirmPurchases(receipt)
			end
		end
	end
	if not data.success then
		UICommonUtils.PopToast("购买失败")
		return
	else
		if data.reason and data.reason == ActionFailReason.PaySuccess_MultiOrder_NotDone then
			UICommonUtils.PopFailReason(ActionFailReason.PaySuccess_MultiOrder_NotDone)
		end
	end

	if not data.reason or data.reason == ActionFailReason.None or data.reason == ActionFailReason.PaySuccess_MultiOrder_NotDone then
		print("#################paySuccess 3", tablex.dump(data))
		Me:ReceiveReward(data.rewards, Me:getPaySuccessCB())
		EngineUtil.DelayCallback(0.5, function()
			LuaLogger.ds("paySuccess 4  ===这边先去掉  正常的ClientCheck= ",tablex.dump(data))
			--Pay_Channel.ClientCheck(data.game_trade_no, nil, data.item_num)
		end)
	end
end

function Pay_Channel.PayInitial()
	if Me._pay_initial_ing then
		return
	end
	if Me._pay_initial then
		return
	end
	Me._pay_initial_ing = true
	GameNetHandler:SendMessage("user.payInitializeReq", {identify = NativeInfo.GetBundleIdentifier(), device = NativeInfoLua.GetDeviceID(), deviceType = UnityEngine.Application.platform:ToInt() }, function (data)
		print("!!!!!!!!payInitializeReq1")
		if data.ret == ActionFailReason.None then
			print("!!!!!!!!payInitializeReq2")
			LuaLogger.ds("user.payInitializeReqreturn  ==== ",tablex.dump(data))
			if data.item then
				local item = data.item
				local game_trade_no = data.game_trade_no
				Pay_Channel.ClientCheck(game_trade_no, item)
			end
		end
		Me._pay_initial_ing = nil
		Me._pay_initial = true
	end)
end

function Pay_Channel.ClientCheck(game_trade_no, item, item_num)
	LuaLogger.es("'user.payClientCheckReq'  Begin")
	GameNetHandler:SendWaitMessage("user.payClientCheckReq", {game_trade_no = game_trade_no }, function (data)
		LuaLogger.es("'user.payClientCheckReq'  End",tablex.dump(data))
		if data.ret == ActionFailReason.None and data.success then
			local item_id = item or data.item
			if item_id > 0 then
				if item_num and item_num > 1 then
					UICommonUtils.PopToast(string.format("%sx%d购买成功", Config.GetGiftInfo(item_id).Name, item_num))
				else
					UICommonUtils.PopToast(string.format("%s购买成功", Config.GetGiftInfo(item_id).Name))
				end
				GameMsgMgr:sendEvent(GameMsgType.PaySuccess, data.item)
			end
		end
	end)
	

end

function Pay_Channel.refundSuccess(channel, data, callBack)
	---暂时不做表现
end


function Pay_Channel.Pay(channel, pay_channel, id)
	local self = channel
	self._pay = true
	self._processPurchase = nil
	self:DoPay(pay_channel, id)
end

function Pay_Channel.CheckPayInit(channel, pay_channel)
	local self = channel
	return self:IsPayInit(pay_channel)
end


function Pay_Channel.onFocus(channel)
	print("###onFocus1")
	local self = channel
	local _onFocus = Me._onFocus

	if EngineUtil.IsWebGL() and (EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini or EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.WxWebMini) then
		_onFocus = true
	end
	print("###onFocus2", channel._pay, _onFocus)
	
	if channel._pay and _onFocus and not channel:hasClientReturn() and channel.paySuccessData then
		print("###onFocus3")
		Pay_Channel.ProcessPurchase(channel, channel.paySuccessData, channel.paySuccessData.success)
		print("###onFocus4")
	end
	print("###onFocus5")
end

return Pay_Channel