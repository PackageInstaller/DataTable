-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopBuyMonthCardMediator.lua

ShopBuyMonthCardMediator = class("ShopBuyMonthCardMediator", DmPopupViewMediator, _M)

ShopBuyMonthCardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
ShopBuyMonthCardMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopBuyMonthCardMediator:has("_rechargeAndVipSystem", {
	is = "r"
}):injectWith("RechargeAndVipSystem")
ShopBuyMonthCardMediator:has("_rechargeAndVipModel", {
	is = "r"
}):injectWith("RechargeAndVipModel")

local kBtnHandlers = {
	["main.btnBuy"] = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickedBuyBtn"
	}
}

function ShopBuyMonthCardMediator:initialize()
	super.initialize(self)
end

function ShopBuyMonthCardMediator:dispose()
	super.dispose(self)
end

function ShopBuyMonthCardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ShopBuyMonthCardMediator:enterWithData(data)
	self._data = data.item
	self._callBack = data.callback or nil
	self._canBuy = true

	self:initMember()
	self:refreshData()
	self:refreshView()
end

function ShopBuyMonthCardMediator:initMember()
	self._view = self:getView()

	local mainPanel = self._view:getChildByFullName("main")

	self._iconLayout = mainPanel:getChildByFullName("iconPanel")
	self._moneySymbol = mainPanel:getChildByFullName("moneySymbol")
	self._moneyNum = mainPanel:getChildByFullName("moneyNum")
	self._per = mainPanel:getChildByFullName("per")
	self._noBuy = mainPanel:getChildByFullName("buyStatusPanel.nobuy")
	self._remainBuy = mainPanel:getChildByFullName("buyStatusPanel.buy")
	self._remainBuyDay = mainPanel:getChildByFullName("buyStatusPanel.buyday")
	self._remainBuyDay1 = mainPanel:getChildByFullName("buyStatusPanel.buyday_0")
	self._buyBtnText = mainPanel:getChildByFullName("btnBuy.text")
	self._subscribePanel = mainPanel:getChildByFullName("subscribePanel")

	self._subscribePanel:setTouchEnabled(true)
	self._subscribePanel:addTouchEventListener(function(sender, eventType)
		self:onClickSubscribeDesc(sender, eventType)
	end)
	self._subscribePanel:setVisible(false)

	self._btnBuy = mainPanel:getChildByFullName("btnBuy")
	self._recoverBtn = self._btnBuy:clone()

	self._recoverBtn:addTo(self._btnBuy):posite(-100, 25)
	self._recoverBtn:getChildByFullName("text"):setString(Strings:get("Right_Recover"))
	self._recoverBtn:setVisible(false)

	local function callFunc(sender, eventType)
		self:onClickedBuyBtn(KPayToSdkType.KRecover)
	end

	mapButtonHandlerClick(nil, self._recoverBtn, {
		func = callFunc
	})

	self._buyEnd = mainPanel:getChildByFullName("buyEnd")

	self._buyEnd:setVisible(false)
end

function ShopBuyMonthCardMediator:refreshData()
	return
end

function ShopBuyMonthCardMediator:refreshView()
	local payOffSystem = DmGame:getInstance()._injector:getInstance(PayOffSystem)
	local symbol, price = payOffSystem:getPaySymbolAndPrice(self._data._payId)

	self._moneySymbol:setString(symbol)
	self._moneyNum:setString(price)
	self._moneyNum:setPositionX(739 + self._moneySymbol:getContentSize().width + 2)
	self._per:setPositionX(739 + self._moneySymbol:getContentSize().width + self._moneyNum:getContentSize().width + 8)
	self._view:getChildByFullName("main.name"):setString(self._data._name)
	self:addDesc()
	self:refreshIcon()

	if self._data._id == KMonthCardType.KMonthCardSubscribe then
		self:refreshBuyStatusForSubscribe()
	else
		self:refreshBuyStatus()
	end
end

function ShopBuyMonthCardMediator:addDesc()
	local listView = self._view:getChildByFullName("main.goods_listview")

	listView:removeAllChildren()
	listView:setScrollBarEnabled(false)

	local desx = self._view:getChildByFullName("main.desc")

	desx:setVisible(false)

	local str = desx:clone()

	str:setVisible(true)

	local p = self._shopSystem:getPlatform()

	str:setString((self._data._id == KMonthCardType.KMonthCardSubscribe and p == "ios" or nil) and Strings:get("MonthCard_Subscribe_iosDesc"))
	str:getVirtualRenderer():setDimensions(listView:getContentSize().width, 0)
	str:getVirtualRenderer():setLineSpacing(5)
	listView:pushBackCustomItem(str)
end

function ShopBuyMonthCardMediator:refreshIcon()
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

function ShopBuyMonthCardMediator:refreshBuyStatus()
	if self._data._endTimes == -1 then
		self._noBuy:setVisible(true)
		self._remainBuy:setVisible(false)
		self._remainBuyDay:setVisible(false)
		self._remainBuyDay1:setVisible(false)
		self._buyBtnText:setString(Strings:get("MonthCard_1_Button2_purchase"))
	else
		self._noBuy:setVisible(false)
		self._remainBuy:setVisible(true)
		self._remainBuyDay:setVisible(true)
		self._remainBuyDay1:setVisible(true)

		local remainDays = self._rechargeAndVipSystem:getRemainDays(self._data._id)

		self._remainBuyDay:setString(tostring(remainDays))

		if remainDays < self._data._dangerTime then
			self._remainBuyDay:setColor(cc.c3b(255, 73, 73))
		else
			self._remainBuyDay:setColor(cc.c3b(91, 230, 255))
		end

		self._remainBuyDay1:setString(Strings:get("MonthCard_1_RemainTime_Text2"))
		self._remainBuyDay1:setPositionX(self._remainBuyDay:getPositionX() + self._remainBuyDay:getContentSize().width)

		local canContinueBuy = self._rechargeAndVipSystem:getCanContinueBuy(self._data._id)

		if canContinueBuy then
			self._buyBtnText:setString(Strings:get("MonthCard_1_Button2_Receive"))
		else
			self._canBuy = false

			self._buyBtnText:setString(Strings:get("MonthCard_1_Button2_Received"))
			self._buyEnd:setVisible(true)
			self._btnBuy:setVisible(false)
		end
	end
end

function ShopBuyMonthCardMediator:onClickedBuyBtn(isRecover)
	if not self._canBuy then
		AudioEngine:getInstance():playEffect("Se_Alert_Error", false)

		return
	end

	AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

	local p = self._shopSystem:getPlatform()

	if self._data._id == KMonthCardType.KMonthCardSubscribe and p == "ios" then
		local isRecover = isRecover == KPayToSdkType.KRecover and isRecover or KPayToSdkType.KSubscribe

		self._rechargeAndVipSystem:requestPurchaseSubscribe(self._data._id, isRecover)
	else
		self._rechargeAndVipSystem:requestBuyMonthCard(self._data._id)
	end

	self:close()
end

function ShopBuyMonthCardMediator:refreshBuyStatusForSubscribe()
	self._subscribePanel:setVisible(true)

	local subscribeIsPurchased = self._rechargeAndVipModel:getIsPurchased()
	local subscribeEndTime = self._rechargeAndVipModel:getEndTime()
	local subscribeType = self._rechargeAndVipModel:getType()
	local device = self._shopSystem:getPlatform()

	self._btnBuy:setVisible(true)
	self._buyEnd:setVisible(false)

	if device == "ios" then
		if subscribeIsPurchased then
			self._noBuy:setVisible(false)
			self._remainBuy:setVisible(true)
			self._remainBuyDay:setVisible(true)
			self._remainBuyDay1:setVisible(true)
			self._remainBuy:setString(Strings:get("Subscribe_Surplus"))

			local remainDays = self._rechargeAndVipSystem:getRemainDaysForSubscribe()

			self._remainBuyDay:setString(tostring(remainDays))

			if remainDays < self._data._dangerTime then
				self._remainBuyDay:setColor(cc.c3b(255, 73, 73))
			else
				self._remainBuyDay:setColor(cc.c3b(91, 230, 255))
			end

			self._remainBuyDay1:setString(Strings:get("MonthCard_1_RemainTime_Text2"))
			self._remainBuyDay1:setPositionX(self._remainBuyDay:getPositionX() + self._remainBuyDay:getContentSize().width)
			self._buyBtnText:setString(Strings:get("Subscribe_Already"))

			self._canBuy = false
		else
			self._recoverBtn:setVisible(true)

			if self._data._endTimes == -1 then
				self._noBuy:setVisible(true)
				self._remainBuy:setVisible(false)
				self._remainBuyDay:setVisible(false)
				self._remainBuyDay1:setVisible(false)
				self._buyBtnText:setString(Strings:get("shop_UI3"))
			else
				self._noBuy:setVisible(false)
				self._remainBuy:setVisible(true)
				self._remainBuyDay:setVisible(true)
				self._remainBuyDay1:setVisible(true)
				self._remainBuy:setString(Strings:get("Subscribe_Surplus"))

				local remainDays = self._rechargeAndVipSystem:getRemainDays(self._data._id)

				self._remainBuyDay:setString(tostring(remainDays))

				if remainDays < self._data._dangerTime then
					self._remainBuyDay:setColor(cc.c3b(255, 73, 73))
				else
					self._remainBuyDay:setColor(cc.c3b(91, 230, 255))
				end

				self._remainBuyDay1:setString(Strings:get("MonthCard_1_RemainTime_Text2"))
				self._remainBuyDay1:setPositionX(self._remainBuyDay:getPositionX() + self._remainBuyDay:getContentSize().width)
				self._buyBtnText:setString(Strings:get("shop_UI3"))
			end
		end
	elseif self._data._endTimes == -1 then
		if not subscribeIsPurchased then
			self._noBuy:setVisible(true)
			self._remainBuy:setVisible(false)
			self._remainBuyDay:setVisible(false)
			self._remainBuyDay1:setVisible(false)
			self._buyBtnText:setString(Strings:get("shop_UI3"))
		else
			self._noBuy:setVisible(false)
			self._remainBuy:setVisible(true)
			self._remainBuyDay:setVisible(true)
			self._remainBuyDay1:setVisible(true)
			self._remainBuy:setString(Strings:get("Subscribe_Surplus"))

			local remainDays = self._rechargeAndVipSystem:getRemainDaysForSubscribe()

			self._remainBuyDay:setString(tostring(remainDays))

			if remainDays < self._data._dangerTime then
				self._remainBuyDay:setColor(cc.c3b(255, 73, 73))
			else
				self._remainBuyDay:setColor(cc.c3b(91, 230, 255))
			end

			self._remainBuyDay1:setString(Strings:get("MonthCard_1_RemainTime_Text2"))
			self._remainBuyDay1:setPositionX(self._remainBuyDay:getPositionX() + self._remainBuyDay:getContentSize().width)
			self._buyBtnText:setString(Strings:get("shop_UI3"))
		end
	else
		self._noBuy:setVisible(false)
		self._remainBuy:setVisible(true)
		self._remainBuyDay:setVisible(true)
		self._remainBuyDay1:setVisible(true)
		self._remainBuy:setString(Strings:get("Subscribe_Surplus"))

		local remainDays = self._rechargeAndVipSystem:getRemainDays(self._data._id)

		self._remainBuyDay:setString(tostring(remainDays))

		if remainDays < self._data._dangerTime then
			self._remainBuyDay:setColor(cc.c3b(255, 73, 73))
		else
			self._remainBuyDay:setColor(cc.c3b(91, 230, 255))
		end

		self._remainBuyDay1:setString(Strings:get("MonthCard_1_RemainTime_Text2"))
		self._remainBuyDay1:setPositionX(self._remainBuyDay:getPositionX() + self._remainBuyDay:getContentSize().width)

		local canContinueBuy = self._rechargeAndVipSystem:getCanContinueBuy(self._data._id)

		if canContinueBuy then
			self._buyBtnText:setString(Strings:get("Subscribe_Renew"))
		else
			self._canBuy = false

			self._buyBtnText:setString(Strings:get("Subscribe_InForce"))
			self._btnBuy:setVisible(false)
			self._buyEnd:setVisible(true)
		end
	end
end

function ShopBuyMonthCardMediator:addSubscribeDesc()
	local listView = self._view:getChildByFullName("main.goods_listview_subdesc")

	listView:removeAllChildren()
	listView:setScrollBarEnabled(false)

	for i = 1, 10 do
		local desc = Strings:get("Announce_Club_Recruit")

		listView:pushBackCustomItem(self:addTxt(desc))
	end
end

function ShopBuyMonthCardMediator:addTxt(desc)
	local function openUrlView(url)
		cc.Application:getInstance():openURL(url)
		self:dispatch(ShowTipEvent({
			duration = 0.35,
			tip = url
		}))
	end

	local contentText = ccui.RichText:createWithXML(desc, {})

	contentText:setTouchEnabled(true)
	contentText:setSwallowTouches(false)
	contentText:setWrapMode(1)
	contentText:setAnchorPoint(cc.p(0, 1))
	contentText:setPosition(cc.p(0, 0))
	contentText:setOpenUrlHandler(function(url)
		openUrlView(url)
	end)
	contentText:setFontSize(18)

	local listView = self._view:getChildByFullName("main.goods_listview_subdesc")

	contentText:renderContent(listView:getContentSize().width, 0, true)

	return contentText
end

function ShopBuyMonthCardMediator:onClickSubscribeDesc(sender, eventType)
	if eventType == ccui.TouchEventType.ended then
		AudioEngine:getInstance():playEffect("Se_Click_Common_1", false)

		local p = self._shopSystem:getPlatform()
		local Rule = ConfigReader:getDataByNameIdAndKey("ConfigValue", (p == "ios" or nil) and "MonthCard_Subscribe_Ios_Detail", "content")
		local view = self:getInjector():getInstance("ExplorePointRule")

		local function urlCallBack(url)
			cc.Application:getInstance():openURL(url)
		end

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, {
			rule = Rule,
			urlCallBack = urlCallBack
		}))
	end
end
