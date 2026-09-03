-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopMonthCardMediator.lua

ShopMonthCardMediator = class("ShopMonthCardMediator", DmAreaViewMediator, _M)

ShopMonthCardMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopMonthCardMediator:has("_rechargeSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopMonthCardMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")
ShopMonthCardMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopMonthCardMediator:has("_gameServerAgent", {
	is = "r"
}):injectWith("GameServerAgent")

local kBtnHandlers = {
	["main.panelBg.vipBtn"] = {
		clickAction = true,
		clickAudio = "Se_Click_Common_1",
		func = "onClickVipBtn"
	},
	["main.panelBg.mkBtn"] = {
		clickAction = true,
		clickAudio = "Se_Click_Common_1",
		func = "onClickMkBtn"
	},
	["main.panelBg.dyBtn"] = {
		clickAction = true,
		clickAudio = "Se_Click_Common_1",
		func = "onClickDyBtn"
	},
	["main.panelBg.vipBtn.buyEndTip.getBtn"] = {
		clickAction = true,
		clickAudio = "Se_Click_Common_1",
		func = "onClickVipBtn"
	}
}

function ShopMonthCardMediator:initialize()
	super.initialize(self)
end

function ShopMonthCardMediator:dispose()
	self:shuttleTimers()
	self:getView():stopAllActions()
	super.dispose(self)
end

function ShopMonthCardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function ShopMonthCardMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), PAY_INIT_SUCCESS, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_BUY_MONTHCARD_SUCC, self, self.refreshShopData)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FefreshForeverCard, self, self.refreshForeverView)
end

function ShopMonthCardMediator:onRemove()
	super.onRemove(self)
end

function ShopMonthCardMediator:setupView()
	self._rechargeAndVipSystem:requestFefreshForeverCard()
	self:initMember()
end

function ShopMonthCardMediator:clearView()
	self:getView():stopAllActions()
end

function ShopMonthCardMediator:initMember()
	self._vipBtn = self:getView():getChildByFullName("main.panelBg.vipBtn")
	self._mkBtn = self:getView():getChildByFullName("main.panelBg.mkBtn")
	self._dyBtn = self:getView():getChildByFullName("main.panelBg.dyBtn")

	local buyEndTip = self._vipBtn:getChildByFullName("buyEndTip")

	self._mcfPhysicalPanel = buyEndTip:getChildByFullName("getRewardPanel.physicalPanel")

	self._mcfPhysicalPanel:addClickEventListener(function()
		self:onClickMCFPhysicalPanel()
	end)

	self._mcfRewardPanel = buyEndTip:getChildByFullName("getRewardPanel.rewardPanel")

	self._mcfRewardPanel:addClickEventListener(function()
		self:onClickMCFRewardPanel()
	end)
	self:adjustView()
end

function ShopMonthCardMediator:adjustView()
	return
end

function ShopMonthCardMediator:refreshData(data)
	self._shopId = data.shopId or nil
	self._parentMediator = data.parentMediator or nil
	self._enterData = data.enterData or nil

	self._rechargeAndVipSystem:requestFefreshForeverCard()
	self:setData()
end

function ShopMonthCardMediator:setData()
	self._data = self._shopSystem:getPackageListMonthcardMap()

	local mcfData = self._data[KMonthCardType.KMonthCardForever]
	local developSystem = self:getInjector():getInstance(DevelopSystem)
	local level = developSystem:getPlayer():getLevel()

	self._bagSystem = developSystem:getBagSystem()

	local powerLimit = self._bagSystem:getRecoveryPowerLimit(level)
	local curPower, lastRecoverTime = self._bagSystem:getPower()
	local entry = self._bagSystem:getEntryById(CurrencyIdKind.kPower)
	local curBagCount = entry.count

	self:shuttleTimers()

	self._addFCardStamina = 0

	if mcfData._fCardBuyFlag and powerLimit <= curPower then
		local cd = mcfData._stamina_CD

		if powerLimit <= curPower and curBagCount < powerLimit then
			lastRecoverTime = (powerLimit - curBagCount) * cd + lastRecoverTime
		end

		local remoteTimestamp = self._gameServerAgent:remoteTimestamp()

		self._addFCardStamina = math.min(mcfData._staminaLimit - mcfData._fCardStamina, math.floor((remoteTimestamp - lastRecoverTime) / cd))

		local function checkTimeFunc()
			local remoteTimestamp = self._gameServerAgent:remoteTimestamp()

			self._addFCardStamina = math.min(mcfData._staminaLimit - mcfData._fCardStamina, math.floor((remoteTimestamp - lastRecoverTime) / cd))

			if mcfData._fCardStamina + self._addFCardStamina >= mcfData._staminaLimit then
				self._addFCardStamina = mcfData._staminaLimit - mcfData._fCardStamina

				self:shuttleTimers()
			end

			self:setMonthCardViewF()
		end

		self._timer = LuaScheduler:getInstance():schedule(checkTimeFunc, 1, false)

		checkTimeFunc()
	end
end

function ShopMonthCardMediator:shuttleTimers()
	if self._timer then
		self._timer:stop()

		self._timer = nil
	end
end

function ShopMonthCardMediator:refreshView()
	self:getView():stopAllActions()
	self:setMonthCardView()
	self:setMonthCardViewF()
	self:setMonthCardSubscribeView()
	self:urlEnter()
end

function ShopMonthCardMediator:urlEnter()
	if self._enterData and self._enterData.packageId then
		if self._enterData.packageId == KMonthCardType.KMonthCardForever then
			self:onClickVipBtn()
		elseif self._enterData.packageId == KMonthCardType.KMonthCard then
			self:onClickMkBtn()
		elseif self._enterData.packageId == KMonthCardType.KMonthCardSubscribe then
			self:onClickDyBtn()
		end

		self._enterData = nil
	end
end

function ShopMonthCardMediator:setMonthCardView()
	local data = self._data[KMonthCardType.KMonthCard]
	local buyTip = self._mkBtn:getChildByFullName("buyTip")
	local buyEndTip = self._mkBtn:getChildByFullName("buyEndTip")

	buyTip:setVisible(false)
	buyEndTip:setVisible(false)

	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local sym, price = payOffSystem:getPaySymbolAndPrice(data._payId)

	if data._endTimes == -1 then
		buyTip:setVisible(true)

		local symbol = buyTip:getChildByFullName("symbol")
		local money = buyTip:getChildByFullName("money")
		local per = buyTip:getChildByFullName("per")

		symbol:setString(sym)
		money:setString(price)
		money:setPositionX(symbol:getPositionX() + symbol:getContentSize().width)
		per:setPositionX(money:getPositionX() + money:getContentSize().width)
	else
		buyEndTip:setVisible(true)

		local sy = buyEndTip:getChildByFullName("sy")
		local times = buyEndTip:getChildByFullName("times")
		local per = buyEndTip:getChildByFullName("per")
		local buytxt = buyEndTip:getChildByFullName("buytxt")
		local remainDays = self._rechargeAndVipSystem:getRemainDays(data._id)

		times:setString(tostring(remainDays))
		per:setPositionX(times:getPositionX() + times:getContentSize().width)

		if remainDays < data._dangerTime then
			times:setColor(cc.c3b(255, 73, 73))
		else
			times:setColor(cc.c3b(91, 230, 255))
		end

		local canContinueBuy = self._rechargeAndVipSystem:getCanContinueBuy(data._id)

		if canContinueBuy then
			buytxt:setString(Strings:get("MonthCard_Button_Renew"))
		else
			buytxt:setString(Strings:get("MonthCard_1_Button2_Received"))
		end
	end
end

function ShopMonthCardMediator:setMonthCardViewF(panel, data)
	local data = self._data[KMonthCardType.KMonthCardForever]
	local buyTip = self._vipBtn:getChildByFullName("buyTip")
	local buyEndTip = self._vipBtn:getChildByFullName("buyEndTip")

	buyTip:setVisible(false)
	buyEndTip:setVisible(false)

	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local sym, price = payOffSystem:getPaySymbolAndPrice(data._payId)

	if data._fCardBuyFlag then
		buyEndTip:setVisible(true)

		local sy = buyEndTip:getChildByFullName("sy")
		local times = buyEndTip:getChildByFullName("times")
		local per = buyEndTip:getChildByFullName("per")
		local buytxt = buyEndTip:getChildByFullName("buytxt")

		if data._fCardWeekFlag and data._fCardWeekFlag.value > 0 then
			if data._fCardStamina + self._addFCardStamina >= data._staminaLimit then
				buytxt:setString(Strings:get("MonthCardForever_Button_PowerMax"))
			else
				buytxt:setString(Strings:get("MonthCardForever_Button_NextWeek"))
			end
		else
			buytxt:setString(Strings:get("MonthCardForever_Button_Receive"))
		end

		self:setMCFPowerView()
	else
		buyTip:setVisible(true)

		local symbol = buyTip:getChildByFullName("symbol")
		local money = buyTip:getChildByFullName("money")

		symbol:setString(sym)
		money:setString(price)
		money:setPositionX(symbol:getPositionX() + symbol:getContentSize().width)
	end

	self:setRedPointForMonthCardF()
end

function ShopMonthCardMediator:setMCFPowerView()
	local data = self._data[KMonthCardType.KMonthCardForever]

	if data._fCardWeekFlag and data._fCardWeekFlag.value > 0 then
		self._mcfRewardPanel:getChildByFullName("icon"):setColor(cc.c3b(125, 125, 125))
		self._mcfRewardPanel:getChildByFullName("getEndBg"):setVisible(true)
	else
		self._mcfRewardPanel:getChildByFullName("getEndBg"):setVisible(false)
	end

	local rewards = RewardSystem:getRewardsById(tostring(data._weekReward))
	local rewardData = rewards[1]
	local iconBg = self._mcfRewardPanel:getChildByFullName("icon")

	iconBg:removeAllChildren()

	if rewardData then
		local icon = IconFactory:createRewardIcon(rewardData, {
			showAmount = true,
			isWidget = true
		})

		IconFactory:bindTouchHander(icon, IconTouchHandler:new(self), rewardData, {
			needDelay = true
		})
		icon:setScaleNotCascade(0.5)
		icon:addTo(iconBg):center(iconBg:getContentSize())
	end

	local r = (data._fCardStamina + self._addFCardStamina) / data._staminaLimit
	local ratia = tonumber(string.format("%.2f", tostring(r)))

	self._mcfPhysicalPanel:getChildByFullName("LoadingBar"):setPercent(ratia * 100)
	self._mcfPhysicalPanel:getChildByFullName("cur"):setString(data._fCardStamina + self._addFCardStamina .. "/" .. data._staminaLimit)

	local redPoint = self._mcfRewardPanel:getChildByName("redPoint")

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(self._mcfRewardPanel):posite(90, 60)
		redPoint:setLocalZOrder(99900)
		redPoint:setName("redPoint")
	end

	redPoint:setVisible(self._shopSystem:getRedPointForMCFWeekFlag())

	local redPoint = self._mcfPhysicalPanel:getChildByName("redPoint")

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(self._mcfPhysicalPanel):posite(70, 90)
		redPoint:setLocalZOrder(99900)
		redPoint:setName("redPoint")
	end

	redPoint:setVisible(self._shopSystem:getRedPointForMCFStamina())
end

function ShopMonthCardMediator:setRedPointForMonthCardF()
	local redPoint = self._vipBtn:getChildByName("redPoint" .. KMonthCardType.KMonthCardForever)
	local var_21_0

	if not redPoint then
		redPoint = RedPoint:createDefaultNode()

		redPoint:addTo(self._vipBtn):posite(190, 484)
		redPoint:setLocalZOrder(99900)
		redPoint:setName("redPoint" .. KMonthCardType.KMonthCardForever)

		var_21_0 = self._shopSystem:getRedPointForMCFStamina() or self._shopSystem:getRedPointForMCFWeekFlag()
	end

	redPoint:setVisible(var_21_0)
end

function ShopMonthCardMediator:setMonthCardSubscribeView(panel, data)
	local data = self._data[KMonthCardType.KMonthCardSubscribe]

	if not data then
		self._dyBtn:setVisible(false)

		return
	end

	self._dyBtn:setVisible(true)

	local buyTip = self._dyBtn:getChildByFullName("buyTip")
	local buyEndTip = self._dyBtn:getChildByFullName("buyEndTip")

	buyTip:setVisible(false)
	buyEndTip:setVisible(false)

	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local sym, price = payOffSystem:getPaySymbolAndPrice(data._payId)
	local subscribeIsPurchased = self._rechargeAndVipModel:getIsPurchased()
	local subscribeEndTime = self._rechargeAndVipModel:getEndTime()
	local subscribeType = self._rechargeAndVipModel:getType()
	local device = self._shopSystem:getPlatform()

	if device == "ios" then
		if subscribeIsPurchased then
			local remainDays = self._rechargeAndVipSystem:getRemainDaysForSubscribe()

			buyEndTip:setVisible(true)

			local sy = buyEndTip:getChildByFullName("sy")
			local times = buyEndTip:getChildByFullName("times")
			local per = buyEndTip:getChildByFullName("per")
			local buytxt = buyEndTip:getChildByFullName("buytxt")

			times:setString(tostring(remainDays))
			per:setPositionX(times:getPositionX() + times:getContentSize().width)

			if remainDays < data._dangerTime then
				times:setColor(cc.c3b(255, 73, 73))
			else
				times:setColor(cc.c3b(91, 230, 255))
			end
		elseif data._endTimes == -1 then
			buyTip:setVisible(true)

			local symbol = buyTip:getChildByFullName("symbol")
			local money = buyTip:getChildByFullName("money")

			symbol:setString(sym)
			money:setString(price)
			money:setPositionX(symbol:getPositionX() + symbol:getContentSize().width)
		else
			local remainDays = self._rechargeAndVipSystem:getRemainDays(data._id)

			buyEndTip:setVisible(true)

			local times = buyEndTip:getChildByFullName("times")
			local per = buyEndTip:getChildByFullName("per")

			times:setString(tostring(remainDays))
			per:setPositionX(times:getPositionX() + times:getContentSize().width)

			if remainDays < data._dangerTime then
				times:setColor(cc.c3b(255, 73, 73))
			else
				times:setColor(cc.c3b(91, 230, 255))
			end
		end
	elseif data._endTimes == -1 then
		if not subscribeIsPurchased then
			buyTip:setVisible(true)

			local symbol = buyTip:getChildByFullName("symbol")
			local money = buyTip:getChildByFullName("money")

			symbol:setString(sym)
			money:setString(price)
			money:setPositionX(symbol:getPositionX() + symbol:getContentSize().width)
		else
			local remainDays = self._rechargeAndVipSystem:getRemainDaysForSubscribe()

			buyEndTip:setVisible(true)

			local times = buyEndTip:getChildByFullName("times")
			local per = buyEndTip:getChildByFullName("per")

			times:setString(tostring(remainDays))
			per:setPositionX(times:getPositionX() + times:getContentSize().width)

			if remainDays < data._dangerTime then
				times:setColor(cc.c3b(255, 73, 73))
			else
				times:setColor(cc.c3b(91, 230, 255))
			end
		end
	else
		local remainDays = self._rechargeAndVipSystem:getRemainDays(data._id)

		buyEndTip:setVisible(true)

		local times = buyEndTip:getChildByFullName("times")
		local per = buyEndTip:getChildByFullName("per")

		times:setString(tostring(remainDays))
		per:setPositionX(times:getPositionX() + times:getContentSize().width)

		if remainDays < data._dangerTime then
			times:setColor(cc.c3b(255, 73, 73))
		else
			times:setColor(cc.c3b(91, 230, 255))
		end

		local canContinueBuy = self._rechargeAndVipSystem:getCanContinueBuy(data._id)

		if canContinueBuy then
			-- block empty
		else
			local bg = self._dyBtn:getChildByFullName("bg")

			bg:loadTexture("asset/ui/shop/sd_yk_img_ios.png")
			buyEndTip:setVisible(false)
		end
	end
end

function ShopMonthCardMediator:onClickMCFPhysicalPanel()
	local data = self._data[KMonthCardType.KMonthCardForever]

	local function callback()
		if data._fCardStamina <= 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Error_12417")
			}))

			return
		end

		local developSystem = self:getInjector():getInstance("DevelopSystem")

		self._bagSystem = developSystem:getBagSystem()

		local curPower, lastRecoverTime = self._bagSystem:getPower()

		if data._fCardStamina + curPower > data._stamina_Max then
			local num = math.max(0, data._stamina_Max - curPower)

			self:setPowerOverflow(num)

			return
		end

		self._rechargeAndVipSystem:requestFCardStaminaReward(nil, data._fCardStamina)
		self._shopSystem:resetRefresh()
	end

	self._rechargeAndVipSystem:requestFefreshForeverCard(callback)
end

function ShopMonthCardMediator:setPowerOverflow(num)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function func()
		self._rechargeAndVipSystem:requestFCardStaminaReward(nil, num)
		self._shopSystem:resetRefresh()
	end

	local outSelf, delegate = self, {}

	function delegate:willClose(popupMediator, data)
		if data.response == "ok" then
			func()
		elseif data.response == "cancel" then
			-- block empty
		elseif data.response == "close" then
			-- block empty
		end
	end

	local data = {
		title = Strings:get("MonthCardForever_Overflow_Title"),
		title1 = Strings:get("UITitle_EN_Tiliyichu"),
		content = Strings:get("MonthCardForever_Overflow_Desc"),
		sureBtn = {},
		cancelBtn = {}
	}
	local view = self:getInjector():getInstance("AlertView")

	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, data, delegate))
end

function ShopMonthCardMediator:onClickMCFRewardPanel()
	local data = self._data[KMonthCardType.KMonthCardForever]

	if data._fCardWeekFlag and data._fCardWeekFlag.value > 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._rechargeAndVipSystem:requestFCardWeekReward()
end

function ShopMonthCardMediator:refreshShopData()
	self:setData()
	self:refreshView()
end

function ShopMonthCardMediator:refreshForeverView()
	self:refreshShopData()
end

function ShopMonthCardMediator:onClickVipBtn()
	local data = self._data[KMonthCardType.KMonthCardForever]
	local view = self:getInjector():getInstance("ShopBuyMonthCardFView")

	self:openBuyView(data, view)
end

function ShopMonthCardMediator:onClickMkBtn()
	local data = self._data[KMonthCardType.KMonthCard]
	local view = self:getInjector():getInstance("ShopBuyMonthCardView")

	self:openBuyView(data, view)
end

function ShopMonthCardMediator:onClickDyBtn()
	local data = self._data[KMonthCardType.KMonthCardSubscribe]
	local view = self:getInjector():getInstance("ShopBuyMonthCardView")

	self:openBuyView(data, view)
end

function ShopMonthCardMediator:openBuyView(data, view)
	self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
		transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
	}, {
		shopId = ShopSpecialId.KShopTimelimitedmall,
		item = data
	}))
end
