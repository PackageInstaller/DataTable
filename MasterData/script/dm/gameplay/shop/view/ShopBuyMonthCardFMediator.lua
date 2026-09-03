-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuyMonthCardFMediator.lua

ShopBuyMonthCardFMediator = class("ShopBuyMonthCardFMediator", DmPopupViewMediator, _M)

ShopBuyMonthCardFMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuyMonthCardFMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopBuyMonthCardFMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")

local kBtnHandlers = {
	["main.btnBuy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedBuyBtn"
	}
}

function ShopBuyMonthCardFMediator:initialize()
	super.initialize(self)
end

function ShopBuyMonthCardFMediator:dispose()
	super.dispose(self)
end

function ShopBuyMonthCardFMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self.mapEventListener(self, self:getEventDispatcher(), EVT_FefreshForeverCard, self, self.refreshForeverView)
end

function ShopBuyMonthCardFMediator:enterWithData(data)
	self._data = data.item
	self._callBack = data.callback or nil

	self:initMember()
	self:refreshData()
	self:refreshView()
	self._rechargeAndVipSystem:requestFefreshForeverCard()
end

function ShopBuyMonthCardFMediator:refreshForeverView()
	self:refreshData()
	self:refreshView()
end

function ShopBuyMonthCardFMediator:initMember()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._iconLayout = mainPanel:getChildByFullName("iconPanel")
	self._noBuyPanel = mainPanel:getChildByFullName("noBuyPanel")
	self._moneySymbol = mainPanel:getChildByFullName("noBuyPanel.moneySymbol")
	self._moneyNum = mainPanel:getChildByFullName("noBuyPanel.moneyNum")
	self._per = mainPanel:getChildByFullName("noBuyPanel.per")
	self._getText = mainPanel:getChildByFullName("getText")
	self._btnBuy = mainPanel:getChildByFullName("btnBuy")
	self._imgGot = mainPanel:getChildByFullName("got")
	self._listView = self._view:getChildByFullName("main.listView")

	if getCurrentLanguage() ~= GameLanguageType.CN then
		local count_text = mainPanel:getChildByFullName("noBuyPanel.count_text")
		local width = count_text:getContentSize().width - 121

		self._noBuyPanel:setPositionX(640.34 + width)
	end
end

function ShopBuyMonthCardFMediator:refreshData()
	self._data = self._shopSystem:getPackageListDirectPurchaseMCF()
end

function ShopBuyMonthCardFMediator:refreshView()
	self:refreshIcon()
	self:refreshBuyStatus()
	self._listView:removeAllChildren()
	self._listView:setScrollBarEnabled(false)

	local desc = self._view:getChildByFullName("main.desc")

	desc:setVisible(false)

	local s = desc:getContentSize()
	local node = desc:clone()

	node:setPosition(cc.p(0, 0))
	node:setVisible(true)
	node:setString(Strings:get("MonthCardForever_Desc"))
	node:getVirtualRenderer():setDimensions(self._listView:getContentSize().width, 0)
	node:getVirtualRenderer():setLineSpacing(5)
	self._listView:pushBackCustomItem(node)
end

function ShopBuyMonthCardFMediator:refreshIcon()
	self._iconLayout:removeAllChildren()

	local pic = self._data._buyIcon

	if pic == nil or pic == "" then
		pic = self._data._icon
	end

	local icon = ccui.ImageView:create("asset/ui/shop/" .. pic .. ".png")

	if icon then
		self._iconLayout:addChild(icon)
		icon:setAnchorPoint(cc.p(0.5, 0.5))

		local pos = cc.p(self._iconLayout:getContentSize().width / 2, self._iconLayout:getContentSize().height / 2)

		icon:setPosition(pos)
	end
end

function ShopBuyMonthCardFMediator:refreshBuyStatus()
	self._btnBuy:setVisible(false)
	self._imgGot:setVisible(false)
	self._getText:setVisible(false)
	self._noBuyPanel:setVisible(false)

	if self._data._fCardBuyFlag then
		self._imgGot:setVisible(true)
		self._getText:setVisible(true)
	else
		local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
		local symbol, price = payOffSystem:getPaySymbolAndPrice(self._data._payId)

		self._moneySymbol:setString(symbol)
		self._moneyNum:setString(price)
		self._moneyNum:setPositionX(94 + self._moneySymbol:getContentSize().width + 2)
		self._per:setPositionX(94 + self._moneySymbol:getContentSize().width + self._moneyNum:getContentSize().width + 8)
		self._btnBuy:setVisible(true)
		self._noBuyPanel:setVisible(true)
	end
end

function ShopBuyMonthCardFMediator:onClickedBuyBtn()
	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._rechargeAndVipSystem:requestBuyForeverCard()
	self:close()
end

function ShopBuyMonthCardFMediator:onClickRewardPanel()
	if self._data._fCardWeekFlag and self._data._fCardWeekFlag.value > 0 then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)
	self._rechargeAndVipSystem:requestFCardWeekReward()
	self:close()
end

function ShopBuyMonthCardFMediator:onClickPhysicalPanel()
	local function callback()
		if self._data._fCardStamina <= 0 then
			self:dispatch(ShowTipEvent({
				tip = Strings:get("Error_12417")
			}))

			return
		end

		local developSystem = self:getInjector():getInstance("DevelopSystem")

		self._bagSystem = developSystem:getBagSystem()

		local curPower, lastRecoverTime = self._bagSystem:getPower()

		if self._data._fCardStamina + curPower >= self._data._stamina_Max then
			self:getPower()

			return
		end

		self._rechargeAndVipSystem:requestFCardStaminaReward(nil, self._data._fCardStamina)
		self:close()
	end

	self._rechargeAndVipSystem:requestFefreshForeverCard(callback)
end

function ShopBuyMonthCardFMediator:getPower(taskData)
	AudioEngine:getInstance():playEffect("Se_Click_Common_2", false)

	local function func()
		self._rechargeAndVipSystem:requestFCardStaminaReward(nil, self._data._fCardStamina)
		self:close()
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
