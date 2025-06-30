local ChannelManager = BaseClass("ChannelManager", Singleton)
local this = ChannelManager

if GameEvent == nil then
	GameEvent = {
		LoginSuccess = "login_success",
		ChooseLiShiMin = "choose_lishimin",
		ChooseCaoCao = "choose_caocao",
		
		BattleSkip = "battle_skip_click",  -- 战斗引导跳过
		GachaSkip = "gacha_skip_click",  -- 召唤引导跳过
		CharacterSkip = "character_skip_click", -- 角色引导跳过
		TeamSkip = "team_skip_click", -- 编程引导跳过
		AtkSkip = "atk_skip_click", -- 出击引导跳过

		HouseClick = "house_click", -- 首次进入自宅引导
		BattleTutorial = "battle_tutorial", -- 首次进入新手战斗引导
		GachaTutorial = "gacha_tutorial", -- 首次进入召唤引导
		CharacterTutorial = "character_tutorial", -- 首次进入超越者引导
		TeamTutorial = "team_tutorial", -- 首次进入编成引导
		AtkTutorial = "atk_tutorial", -- 首次进入出击引导
		TutorialComplete = "tutorial_completion", -- 完成新手引导

		OnSummon = "on_summon", -- 召唤
		BuySkin = "buy_skin", -- 购买皮肤
		DailyFree = "dailyfree_giftbag", -- 免费礼包

		Daily_Task = "daily_task",
		Weekly_Task = "weekly_task",
		
		-- 活动埋点
		View_MainTitle_Icon = "view_maintitle_icon",
		View_MainTitle_Banner = "view_maintitle_banner",
		Click_MainTitle_Icon = "click_maintitle_icon",
		Click_MainTitle_Banner = "click_maintitle_banner",
		View_Activity = "view_activity",
		Click_Activity = "click_activity",
		Start_Activity_Level = "start_activity_level",
		Finish_Activity_Level = "finish_activity_level",
		Gain_Activity_Source = "gain_activity_source",
		Click_Activity_Rewardlist = "click_activity_rewardlist",
		Click_Activity_Exchange = "click_activity_exchange",
		
		PurchaseSuccess = "purchase_success",
		CreateRole = "createRole",
		LogoutRole = "logoutRole",
		LevelUp = "level_up",
		StoryOpening1 = "story_opening",
		StoryOpening2 = "story_opening2",
		StoryOpening3 = "story_opening3",
		StoryOpening4 = "story_opening4",
		StoryOpening5 = "story_opening5",
		StoryOpening6 = "story_opening6",
		StoryOpening7 = "story_opening7",
		StoryOpening8 = "story_opening8",
		StoryOpening9 = "story_opening9",
		StoryOpening10 = "story_opening10",
	}
end

if ChannelType == nil then
	ChannelType = {
		Test = "Test",
		HKQoo = "HKQoo",
		JA = "JA",
		Asia = "Asia",
		TestQoo = "TestQoo",
		
		-- 对应的测试渠道（代码里不要用）
		TestHKQoo = "TestHKQoo",
		TestJA = "TestJA",
		TestAsia = "TestAsia",
	}
end

if ChannelCurrency == nil then
	ChannelCurrency = {
		CN = "CN",
		US = "US",
		JA = "JA",
	}
end

-- 构造函数
local function __init(self)
	self.CurrentChannel = nil -- 当前渠道
	self.isLogining = false -- 是否在登录中
end

-- 初始化渠道 -- 编辑器模式、测试渠道、线上渠道、线上测试渠道
function this.OnInit(self, name)
	Logger.Log("ChannelManager OnInit "..name)
	if name == ChannelType.Test then
		if self:SimulateInit() then
			return
		end
		self.CurrentChannel = TestChannel.New()
	elseif name == ChannelType.HKQoo then
		self.CurrentChannel = HKQooChannel.New()
	elseif name == ChannelType.JA then
		self.CurrentChannel = JAChannel.New()
	elseif name == ChannelType.Asia then
		self.CurrentChannel = AsiaChannel.New()
	elseif name == ChannelType.TestQoo then
		self.CurrentChannel = TestQooChannel.New()
	else
		Logger.LogError("need add channel: "..name)
	end
end

-- 测试服模拟其他渠道
function this.SimulateInit(self)
	local cacheChannel = ClientData:GetInstance().cacheChannel
	if cacheChannel == ChannelType.HKQoo or cacheChannel == ChannelType.TestHKQoo then
		self:OnInit(ChannelType.HKQoo)
		return true
	end
	if cacheChannel == ChannelType.Asia or cacheChannel == ChannelType.TestAsia then
		self:OnInit(ChannelType.Asia)
		return true
	end
	if cacheChannel == ChannelType.JA or cacheChannel == ChannelType.TestJA then
		self:OnInit(ChannelType.JA)
		return true
	end
	return false
end

-- 渠道判断
function this.IsChannel(self, ...)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return false
	end
	local params = ...
	if type(params) == "string" then
		return params == self.CurrentChannel.Name
	end
	local channel = table.first(params, function (v) return v == self.CurrentChannel.Name end)
	return channel ~= nil
end

-- 获取完整的商品id
function this.GetFullId(self, productId)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return ""
	end
	return self.CurrentChannel:GetFullId(productId)
end

-- 完整id装换成id
function this.GetId(self, fullId)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return ""
	end
	return self.CurrentChannel:GetId(fullId)
end

-- 服务器需要区分平台
function this.GetPlatform(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return 0
	end
	return self.CurrentChannel:GetPlatform()
end

-- 当前渠道的货币类型
function this.GetCurrencyType(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return ""
	end
	return self.CurrentChannel:GetCurrencyType()
end

-- 是否是多语言
function this.IsMultiLang(self)
	return true
end

-- 是否是第三方sdk
function this.IsSdk(self)
	if UNITY_EDITOR then
		return false
	end
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return false
	end
	-- Test渠道，需要选择是否开启sdk登录
	if CS.GameChannel.ChannelManager.instance.packageName == ChannelType.Test then
		return self.CurrentChannel:IsSdk() and ClientData:GetInstance().testSdk == "TestSdk"
	end
	return self.CurrentChannel:IsSdk()
end

-- SDK登录
function this.Login(self)
	if UNITY_EDITOR then
		return
	end
	if not self:IsSdk() then
		return
	end
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	if self.isLogining then
		Logger.LogError("is Logining")
		return
	end
	self.isLogining = true
	coroutine.start(function () 
		coroutine.waitforframes(1)
		CS.GameChannel.ChannelManager.instance:Login()
	end)
end

-- SDK登录成功
function this.OnLoginSuccess(self, json)
	Logger.AuthLog("Lua: OnLoginSuccess "..json)
	self.isLogining = false
	self.CurrentChannel:OnLoginSuccess(json)
end

-- SDK登录失败
function this.OnLoginFail(self, msg)
	Logger.AuthLog("Lua: OnLoginFail "..msg)
	self.isLogining = false
	local login = UIManager:GetInstance():GetWindow(UIWindowNames.UISsLogin)
	if login == nil or login.View == nil then
		return
	end
	login.View:OnLoginFail()
end

-- 登录游戏  补单
function this.OnEnterGame(self)
	if UNITY_EDITOR then
		return
	end
	if not self:IsSdk() then
		return
	end
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	self.CurrentChannel:OnEnterGame()

	self:CommonCallback(GameEvent.LoginSuccess)
end

-- 支付渠道区分
function this.Purchase(self, productId, orderId, isHideReward, successCallback)
	--self.CurrentChannel:Purchase(productId)
	self.orderId = orderId
	if UNITY_EDITOR then
		
		local verifyReqTable = {}
		verifyReqTable.order_id = orderId

		PublicRequest.SendRequest(
        PROTOCOL.VerifyPaymentOrderReq,verifyReqTable,
        function(response, error)
            if error == 0 and not isHideReward then
                UIPublic.OpenRewardUI(
					response.reward_result,
					nil,
					nil,
					nil,
					{RewardType.RewardTypeMonthlyCard}
				)
            end
			if error == 0 and successCallback ~= nil then
				successCallback(response.reward_result)
			end
        end)
		return
	end
	if not self:IsSdk() then
		return
	end
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	self.CurrentChannel:Purchase(productId, orderId)
end

-- 支付验证完成
function this.PurchaseVerify(self, json, data)
	coroutine.start(function ()
		coroutine.waitforframes(1)
		--print( "Purchasejson:" .. json)
		local tab = cjson.decode(data)
		--print( "PurchaseId:" .. tab.purchase_id)
		--print("cpOrderId:" .. tab.cpOrderId)
		--print("PurchaseData" .. data)
		-- local params = {}
		-- params.currency = "USD"
		-- params.quantity = "1"
		-- params.product_id = self:GetFullId(tab.ProductId)
		-- params.transaction_id = "1"
		-- params.order_id = tab.PurchaseId
		--CS.GameChannel.ChannelManager.instance:PurchaseVerifyComplete(cjson.encode(params))

		--if json ~= nil then
		local verifyReqTable = {}
        verifyReqTable.order_id = tab.cpOrderId
		verifyReqTable.channel_order_id = tab.purchase_id--self:GetFullId(tab.PurchaseId)
		verifyReqTable.channel_params = {
			data
		}

		PublicRequest.SendRequest(
            PROTOCOL.VerifyPaymentOrderReq,verifyReqTable,
            function(response, error)
                if error == 0 then
                    UIPublic.OpenRewardUI(response.reward_result,
						nil,
						nil,
						nil,
						{RewardType.RewardTypeMonthlyCard}
				)
                end
            end)
		--end
		
		-- Logger.AuthLog("lua => PurchaseVerify=============")
		-- local tab = cjson.decode(json)
		-- if data ~= nil then
		-- 	tab.Data = data
		-- end
		-- local val = self:GetId(tab.ProductId)
		-- local productId = tonumber(val)
		-- tab.ProductId = productId -- 商品id
		-- local request = coroutine.yieldstart(Game.Scene.Session.CoCall, nil, Game.Scene.Session,
		-- 		OuterOpcode.Name2Code.ETModel_C2M_PurchaseCheck, tab)
		-- if request == nil then
		-- 	Logger.LogError("request == nil!!!")
		-- 	return
		-- end
		-- Logger.AuthLog("lua => PurchaseVerify============productId="..productId)
		-- local config = table.first(Z_StarLightStoneShop, function (v) return v.Id == productId end)
		-- -- 只有这种情况服务器添加商品成功，客户端需要同步数据
		-- if request.Error == ErrorCode.ERR_Success then
		-- 	if productId == 0 or productId == 31 or productId == 32 then
		-- 		local monthCardComponent = Game.Scene.Player:GetComponent("MonthCardComponent")
		-- 		if productId == 0 then monthCardComponent.CurDay = 1 end
		-- 		if productId == 32 then monthCardComponent.SevenCurDay = 1 end
		-- 		if productId == 31 then monthCardComponent.ThreeCurDay = 1 end
		-- 		if UIManager:GetInstance():GetLastBgWindowName() == UIWindowNames.UIMonthCardShop then--当前窗口
		-- 			-- DataManager:GetInstance():Broadcast(DataMessageNames.ON_MONTH_CARD_INFO_CHG)
		-- 		else
		-- 			monthCardComponent:OpenMonthlyCardUI()
		-- 		end
		-- 		UIUtil.ToolTipFourth(LangUtil.GetSysLang(1081));--"够买月卡成功"
		-- 	else
		-- 		if config == nil then
		-- 			Logger.LogError("cannot find productId: "..productId)
		-- 			return
		-- 		end
		-- 		local player = Game.Scene.Player;
		-- 		if productId == 33 or productId == 34 then
		-- 			local view = UIManager:GetInstance():GetWindow(UIWindowNames.ToolTipGiftBag).View 
		-- 			if view ~= nil then
		-- 				view:OnClickCloseButton()
		-- 			else
		-- 				UIManager:GetInstance():CloseWindow(UIWindowNames.ToolTipGiftBag)
		-- 			end
					
		-- 		end
		-- 		-- 总购买
		-- 		local record = player:GetComponent("StarLightRebateComponent").PurchasesDetail
		-- 		local purchaseData = table.first(record,function(v) return v.Key == config.Id end)
		-- 		if purchaseData == nil then
		-- 			purchaseData = {Key = config.Id, Val = 0}
		-- 			table.insert(record, purchaseData)
		-- 		end
		-- 		purchaseData.Val = 1 +  purchaseData.Val
		-- 		-- 限制型商品
		-- 		if config.QuotaNum > 0 then
		-- 			local quotaDetail = player:GetComponent("StarLightRebateComponent").QuotaDetail
		-- 			local quotaData = table.first(quotaDetail,function(v) return v.Key == config.Id end)
		-- 			if quotaData == nil then
		-- 				quotaData = {Key = config.Id, Val = 0}
		-- 				table.insert(quotaDetail, quotaData)
		-- 			end
		-- 			quotaData.Val = 1 +  quotaData.Val 
		-- 		end
		-- 		-- 免费领取红点
		-- 		if config.QuotaPeriod == 1 and config.Price == 0 then
		-- 			Game.Scene:GetComponent("HintComponent").Shop:GetChild("GiftShop"):AddCount(-1)
		-- 		end
		-- 		DataManager:GetInstance():Broadcast(DataMessageNames.ON_STAR_LIGHT_INFO_CHG);
		-- 		UIUtil.ToolTipFourth(LangUtil.GetSysLang(1081));--"够买成功"
		-- 	end
		-- else
		-- 	Logger.LogError("--验证失败!")
		-- end
		-- -- 免费领取不消耗
		-- if config.QuotaPeriod == 1 and config.Price == 0 then
		-- 	return
		-- end
		-- Logger.AuthLog("lua => PurchaseVerifyComplete============productId="..productId)
		-- if ClientData:GetInstance().app_version == "1.0.0" then
		-- 	Logger.AuthLog("PurchaseVerify"..ClientData:GetInstance().app_version)
		-- 	if self.CurrentChannel.Name == "Asia" then
		-- 		local params = {}
		-- 		params.currency = "USD"
		-- 		params.quantity = "1"
		-- 		params.product_id = self:GetFullId(tab.ProductId)
		-- 		params.transaction_id = "1"
		-- 		params.order_id = tab.PurchaseId
		-- 		params.revenue = tostring(Z_StarLightStoneShop[tab.ProductId].Dollar)
		-- 		params.role_id = tostring(ClientData:GetInstance().uid)
		-- 		params.role_name = Game.Scene.Player.Nickname
		-- 		CS.GameChannel.ChannelManager.instance:PurchaseVerifyComplete(cjson.encode(params))
		-- 	else
		-- 		CS.GameChannel.ChannelManager.instance:PurchaseVerifyComplete(cjson.encode(request))
		-- 	end
		-- else
		-- 	CS.GameChannel.ChannelManager.instance:PurchaseVerifyComplete(cjson.encode(request))
		-- 	-- 支付成功埋点
		-- 	local params = {}
		-- 	params.currency = "USD"
		-- 	params.quantity = "1"
		-- 	params.product_id = self:GetFullId(tab.ProductId)
		-- 	params.transaction_id = "1"
		-- 	params.order_id = tab.PurchaseId
		-- 	params.revenue = tostring(Z_StarLightStoneShop[tab.ProductId].Dollar)
		-- 	params.role_id = tostring(ClientData:GetInstance().uid)
		-- 	params.role_name = Game.Scene.Player.Nickname or ""
		-- 	self:GameCallback(GameEvent.PurchaseSuccess, cjson.encode(params))
		-- end
	end)
end

function this.GetAddress(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	return self.CurrentChannel.Config.ReamlAddress
end

function this.GetCGAddress(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	return self.CurrentChannel.Config.LoadCGPath
end

function this.GetRKey(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	return self.CurrentChannel.Config.ReamKey, self.CurrentChannel.Config.ReamIv
end

function this.GetVKey(self)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	return self.CurrentChannel.Config.VerifyKey, self.CurrentChannel.Config.VerifyIv
end

-- 埋点回调
function this.GameCallback(self, evt, json)
	if self.CurrentChannel == nil then
		Logger.LogError("need add channel")
		return
	end
	if ClientData:GetInstance().app_version == "1.0.0" then
		Logger.AuthLog("GameCallback"..ClientData:GetInstance().app_version)
		return
	end
	-- TODO:目前聚美才需要埋点，避免其他渠道调用不了该接口报错
	if self.CurrentChannel.Name == ChannelType.Asia then
		CS.GameChannel.ChannelManager.instance:GameCallback(evt, json)
	end
end

-- 升级埋点
function this.LevelUpCallback(self, level)
	local params = self:SafeGetCommonTable()
	params.level = tostring(level)
	self:GameCallback(GameEvent.LevelUp, cjson.encode(params))
end

-- 剧情关卡埋点
function this.StoryLevelCallback(self, chapterId, storyId)
	local params = self:SafeGetCommonTable()
	if chapterId == 1 and storyId == 101 then
		self:GameCallback(GameEvent.StoryOpening1, cjson.encode(params))
	elseif chapterId == 1 and storyId == 102 then
		self:GameCallback(GameEvent.StoryOpening2, cjson.encode(params))
	elseif chapterId == 1 and storyId == 103 then
		self:GameCallback(GameEvent.StoryOpening3, cjson.encode(params))
	elseif chapterId == 1 and storyId == 104 then
		self:GameCallback(GameEvent.StoryOpening4, cjson.encode(params))
	elseif chapterId == 1 and storyId == 105 then
		self:GameCallback(GameEvent.StoryOpening5, cjson.encode(params))
	elseif chapterId == 1 and storyId == 106 then
		self:GameCallback(GameEvent.StoryOpening6, cjson.encode(params))
	elseif chapterId == 1 and storyId == 107 then
		self:GameCallback(GameEvent.StoryOpening7, cjson.encode(params))
	elseif chapterId == 1 and storyId == 108 then
		self:GameCallback(GameEvent.StoryOpening8, cjson.encode(params))
	elseif chapterId == 1 and storyId == 109 then
		self:GameCallback(GameEvent.StoryOpening9, cjson.encode(params))
	elseif chapterId == 1 and storyId == 110 then
		self:GameCallback(GameEvent.StoryOpening10, cjson.encode(params))
	end
end

-- 召唤埋点
function this.OnSummon(self, summonId, summonName, summonNum)
	local params = self:SafeGetCommonTable()
	params.summon_id = tostring(summonId)
	params.summon_name = summonName or ""
	params.summon_num = tostring(summonNum)
	self:GameCallback(GameEvent.OnSummon, cjson.encode(params))
end

-- 购买皮肤埋点
function this.BuySkin(self, skinId, skinName)
	local params = self:SafeGetCommonTable()
	params.skin_id = tostring(skinId)
	params.skin_name = skinName or ""
	self:GameCallback(GameEvent.BuySkin, cjson.encode(params))
end

-- 完成任务埋点
function this.CompleteTask(self, taskConfig)
	if taskConfig == nil then
		return
	end
	local params = self:SafeGetCommonTable()
	params.task_id = tostring(taskConfig.Id)
	params.task_name = taskConfig.Desc
	if taskConfig.MissionType == 0 then
		self:GameCallback(GameEvent.Daily_Task, cjson.encode(params))
	elseif taskConfig.MissionType == 1 then
		self:GameCallback(GameEvent.Weekly_Task, cjson.encode(params))
	end
end

-- 首页活动banner曝光次数（在看得到主界面的基础上，看不到不能算，每次刷新一次banner就调用一次） 参数：homeBanner的当前配置
function this.OnBannerBtnShow(self, bannerConfig)
	if bannerConfig == nil then
		return
	end
	local params = self:SafeGetCommonTable()
	params.banner_id = tostring(bannerConfig.Id)
	params.banner_name = bannerConfig.Name
	self:GameCallback(GameEvent.View_MainTitle_Banner, cjson.encode(params))
end

-- 首页活动icon点击次数（最新活动btn，ex关卡btn，幽魂碎片btn，夏侯惇活动……） 参数：btn的name
function this.OnActivityBtnClick(self, name)
	name = name or ""
	local params = self:SafeGetCommonTable()
	params.icon_name = name
	self:GameCallback(GameEvent.Click_MainTitle_Icon, cjson.encode(params))
end

-- 首页活动banner点击次数
function this.OnActivityBtnShow(self, bannerConfig)
	if bannerConfig == nil then
		return
	end
	local params = self:SafeGetCommonTable()
	params.banner_id = tostring(bannerConfig.Id)
	params.banner_name = bannerConfig.Name
	self:GameCallback(GameEvent.Click_MainTitle_Banner, cjson.encode(params))
end

-- 活动页面按钮点击次数
function this.OnActivityViewBtnClick(self, activityConfig)
	if activityConfig == nil then
		return
	end
	local params = self:SafeGetCommonTable()
	params.activity_id = tostring(activityConfig.Id)
	params.activity_name = activityConfig.Name
	self:GameCallback(GameEvent.Click_Activity, cjson.encode(params))
end

-- 进入活动关卡埋点
function this.StartActivityLevel(self, data)
	local params = self:SafeGetCommonTable()
	params.activity_id = tostring(data.ActivityId)
	local activity = table.first(Z_ActivityStory, function (v) return v.Id == data.ActivityId end)
	params.activity_name = activity and (activity.Title or "") or ""
	params.level_id = tostring(data.LevelId)
	params.level_name = tostring(data.LevelName)
	self:GameCallback(GameEvent.Start_Activity_Level, cjson.encode(params))
end

-- 通关活动关卡次数
function this.FinishActivityLevel(self, data)
	local params = self:SafeGetCommonTable()
	params.activity_id = tostring(data.ActivityId)
	local activity = table.first(Z_ActivityStory, function (v) return v.Id == data.ActivityId end)
	params.activity_name = activity and (activity.Title or "") or ""
	params.level_id = tostring(data.LevelId)
	params.level_name = tostring(data.LevelName)
	params.is_sweep = tostring(data.IsSweep)
	self:GameCallback(GameEvent.Finish_Activity_Level, cjson.encode(params))
end

-- 活动素材获得数
function this.GainActivitySource(self, data)
	local params = self:SafeGetCommonTable()
	params.activity_id = tostring(data.ActivityId)
	local activity = table.first(Z_ActivityStory, function (v) return v.Id == data.ActivityId end)
	params.activity_name = activity and (activity.Title or "") or ""
	params.item_name = activity.Name
	params.item_num = tostring(data.Num)
	self:GameCallback(GameEvent.Gain_Activity_Source, cjson.encode(params))
end

-- 通用埋点事件: 参数一样，事件不一样
function this.CommonCallback(self, evt)
	if string.IsNullOrEmpty(evt) then
		Logger.AuthLog("evt is nil")
		return
	end
	local params = self:SafeGetCommonTable()
	self:GameCallback(evt, cjson.encode(params))
end

-- 埋点通用参数
function this.SafeGetCommonTable(self)
	local params = {}
	params.role_id = tostring(ClientData:GetInstance().uid)
	if Game.Scene.Player == nil then
		params.role_name = ""
	else
		params.role_name = Game.Scene.Player.Nickname or ""
	end
	return params
end

ChannelManager.__init = __init

return ChannelManager