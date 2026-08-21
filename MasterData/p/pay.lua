
local Pay = class("Pay")
local Pay_Channel = require("Pay_Channel")

local paychannel_cls = {
	[GE.PayChannel.Unknown] = "Pay_Unity",
	[GE.PayChannel.GooglePlay] = "Pay_Unity",
	[GE.PayChannel.Apple] = "Pay_Unity",
	[GE.PayChannel.Alipay] = "Pay_Official",
	[GE.PayChannel.WXpay] = "Pay_Official",
	[GE.PayChannel.QuickSDK] = "Pay_QuickSDK",
	[GE.PayChannel.XipuSDK] = "Pay_XipuSDK",
	[GE.PayChannel.XipuMiniSDK] = "Pay_XipuMiniSDK",
	[GE.PayChannel.XipuAbroadSDK] = "Pay_XipuAbroadSDK",
	[GE.PayChannel.XipuWebSDK] = "Pay_XipuWebSDK",
	[GE.PayChannel.UnionPayWeb] = "Pay_UnionPayWeb",
	[GE.PayChannel.TestPay] = "Pay_TestPay",
--[[	[GE.PayChannel.HuaWei] = "Pay_HuaWei",
	[GE.PayChannel.Oppo] = "Pay_Oppo",
	[GE.PayChannel.Vivo] = "Pay_Vivo",]]
}

local channel_csharp = {
	Pay_Unity = "AppleIAPManager",
	Pay_Official = "PayManager",
	--Pay_HuaWei = "HuaWeiPurchaseManager",
}

function Pay:ctor(obj)
	self.obj = obj
	self.loaderId = nil
	self.channels = nil

	--if GV.GlobalConfig.IsChannelTest()
	self.beforePayAccumulate = -1
end

function Pay:Init()
	Me.__orderString = nil
	Me.__game_trade_no = nil
	if not self.channels then

		if AppleIAPManager and not TypeInfo.AppleIAPManager then
			TypeInfo.AppleIAPManager = typeof(AppleIAPManager)
		end

		if PayManager and not TypeInfo.PayManager then
			TypeInfo.PayManager = typeof(PayManager)
		end

		if HuaWeiPurchaseManager and not TypeInfo.HuaWeiPurchaseManager then
			TypeInfo.HuaWeiPurchaseManager = typeof(HuaWeiPurchaseManager)
		end


		self.channels = {}
		local cls = {}
		local pay_channels, platform, pay_sdk = Me:getPlatform_(nil)
		print("pay_channels", tablex.dump(pay_channels))
		pay_channels = clone(pay_channels)
		table.insert(pay_channels, GE.PayChannel.XipuWebSDK)
		for _, v in pairs(pay_channels) do
			if not self.channels[v] then
				local lua_cls = paychannel_cls[v]
				local csharp = channel_csharp[lua_cls]
				print("csharp", csharp)
				print("TypeInfo[csharp]", TypeInfo[csharp])
				if lua_cls then
					local channel
					if cls[lua_cls] then
						channel = cls[lua_cls]
					else
						if TypeInfo[csharp] then
							self.obj:GetOrAddComponent(TypeInfo[csharp])
						end
						channel = require(lua_cls):new()
						Pay_Channel.ctor(channel)
						cls[lua_cls] = channel
					end
					self.channels[v] = channel
				end
			end
		end
	end

	self.paychannel = nil

	for _, channel in pairs(self.channels) do
		Pay_Channel.Init(channel)
		Pay_Channel.PayResultCallBack(channel,function(pay_channel, receipt, result)
			-- body
			self:ClientPayResult(pay_channel, receipt, result)
		end)
		Pay_Channel.InitializeCallBack(channel,function(success)
			-- body
			if success then

			end
		end)
	end
end

function Pay:Clear()
	print("pay clear!!!")
	if not self.channels then
		return
	end
	for _, channel in pairs(self.channels) do
		Pay_Channel.Clear(channel)
	end
end

function Pay:paySuccess(data)
	local pay_channel = data.pay_channel
	self.last_pay_success_channel = pay_channel
	if pay_channel and self.channels[pay_channel] then
		Pay_Channel.paySuccess(self.channels[pay_channel], data)
		if self.loaderId then
			UIMgr:endLoad(self.loaderId)
			self.loaderId = nil
		end
		
		--[[ local feedSubscribeExperience = MyPrefs:GetBool("FeedSubscribeExperience", false)
		LuaLogger.ds("================= Pay:Pay ", feedSubscribeExperience, Me:getTag(121100))
		if data and data.success and Me:getTag(121100) and not feedSubscribeExperience then		-- 首充Feed流请求订阅 
			LuaLogger.ds("=========0feed  ")
			if EngineUtil.IsWebGL() and EngineUtil.GetWebGLPlatform() == GE.WebGLMiniPlatform.TikTokMini then
				LuaLogger.ds("=========1feed")
				local subscribeCfg = Config.GetTikTokSubscribeTable()
				local info = subscribeCfg[1]
				if WXLuaManager.subscribedFeedList and not WXLuaManager.subscribedFeedList[info.TemplateId] then
					LuaLogger.ds("=========3 历练战斗结束请求订阅 feed")
					EngineUtil.DelayCallback(0.5, function()
						LuaLogger.ds("=========4 历练战斗结束请求订阅Delay feed")
						WXLuaManager:RequestFeedSubscribe(false, info.scene, {info.TemplateId})
						MyPrefs:SetBool("FeedSubscribeExperience", true)
					end)
				end
			end
		end ]]
	else
		LuaLogger.es("pay success no pay_channel")
	end
end

function Pay:refundSuccess(data)
	local pay_channel = data.pay_channel
	if pay_channel and self.channels[pay_channel] then
		Pay_Channel.refundSuccess(self.channels[pay_channel], data)
	else
		LuaLogger.es("refund success no pay_channel")
	end
end

function Pay:ClientPayResult(pay_channel, receipt, result)
	print("#################ClientPayResult")
	-- body
	if self.loaderId and not result then
        print("#################pay load over")
		UIMgr:endLoad(self.loaderId)
		self.loaderId = nil
	end
end

function Pay:Pay(itemId, pay_channel)
	self.paychannel = pay_channel
	print("11111", pay_channel)
	print("222", tablex.dump(self.channels))
	if pay_channel and self.channels[pay_channel] then
		if not self.channels[pay_channel]:hasClientReturn() then
			self.loaderId = nil
		else
			self.loaderId = UIMgr:startLoad(0)
		end
		self.beforePayAccumulate = Me.goldStoreInfo and Me.goldStoreInfo.accumulate or -1
		LuaLogger.ds("================= Pay:Pay ", self.beforePayAccumulate)
		Pay_Channel.Pay(self.channels[pay_channel], pay_channel, itemId)
	else
		LuaLogger.es("pay no pay_channel")
	end
end


function Pay:CheckPayInit(pay_channel)
	if GV.GlobalConfig.IsLocalServerTest() then
		return true
	end
	if pay_channel and self.channels[pay_channel] then
		return Pay_Channel.CheckPayInit(self.channels[pay_channel], pay_channel)
	else
		return false
	end
end

function Pay:onFocus()
	if self.last_pay_success_channel and self.channels[self.last_pay_success_channel] then
		Pay_Channel.onFocus(self.channels[self.last_pay_success_channel])
	end
end

return Pay