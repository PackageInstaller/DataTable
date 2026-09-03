-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/cooperateBoss/view/CooperateBossBuyTimeMediator.lua

CooperateBossBuyTimeMediator = class("CooperateBossBuyTimeMediator", DmPopupViewMediator, _M)

CooperateBossBuyTimeMediator:has("_cooperateBossSystem", {
	is = "r"
}):injectWith("CooperateBossSystem")
CooperateBossBuyTimeMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
CooperateBossBuyTimeMediator:has("_bagSystem", {
	is = "r"
}):injectWith("BagSystem")

local kBtnHandlers = {
	buyBtn = {
		func = "onBuyClicked"
	}
}

function CooperateBossBuyTimeMediator:initialize()
	super.initialize(self)
end

function CooperateBossBuyTimeMediator:dispose()
	super.dispose(self)
end

function CooperateBossBuyTimeMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
	self:mapEventListeners()
end

function CooperateBossBuyTimeMediator:mapEventListeners()
	self.mapEventListener(self, self:getEventDispatcher(), EVT_COOPERATE_BOSS_BUYTIME, self, self.refreshView)
end

function CooperateBossBuyTimeMediator:setupView()
	return
end

function CooperateBossBuyTimeMediator:enterWithData()
	self:initView()
	self:refreshView()
end

function CooperateBossBuyTimeMediator:initData()
	self._cooperBoss = self._cooperateBossSystem:getCooperateBoss()
	self._buyTime = self._cooperBoss:getBoughtBossFightTimes()
end

function CooperateBossBuyTimeMediator:initView()
	bindWidget(self, self:getView():getChildByName("bgNode"), PopupNormalWidget, {
		title1 = "",
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = Strings:get("CooperateBoss_PopUp_UI01")
	})

	self._buyBtn = self:getView():getChildByName("buyBtn")
	self._des1 = self:getView():getChildByName("des1")
	self._des2 = self:getView():getChildByName("des2")
	self._isBuy = self:getView():getChildByName("img_buy")
	self._priceText = self._buyBtn:getChildByName("text_num")
	self._dirmendIcon = self._buyBtn:getChildByName("Image_14")
end

function CooperateBossBuyTimeMediator:refreshView()
	self:initData()

	local configBuyTimes = ConfigReader:getRecordById("ConfigValue", "CooperateBoss_PurchaseTime").content

	if #configBuyTimes <= self._buyTime then
		self._des1:setString(Strings:get("CooperateBoss_PopUp_UI06"))
		self._buyBtn:setVisible(true)
		self._buyBtn:setGray(true)
		self._isBuy:setVisible(false)
		self._priceText:setString(Strings:get("shop_UI43"))
		self._priceText:setPositionX(123)
		self._dirmendIcon:setVisible(false)
	else
		self._buyBtn:setVisible(true)
		self._isBuy:setVisible(false)

		local data = configBuyTimes[self._buyTime + 1]

		self._des1:setString(Strings:get("CooperateBoss_PopUp_UI02", {
			num = data[1],
			times = data[2]
		}))
		self._priceText:setString(data[1])
	end

	self._des2:setString(Strings:get("CooperateBoss_PopUp_UI03", {
		buy = tostring(#configBuyTimes - self._buyTime),
		num = #configBuyTimes
	}))
end

function CooperateBossBuyTimeMediator:onBuyClicked()
	local configBuyTimes = ConfigReader:getRecordById("ConfigValue", "CooperateBoss_PurchaseTime").content

	if #configBuyTimes <= self._buyTime then
		self:dispatch(ShowTipEvent({
			tip = Strings:get("CooperateBoss_PopUp_UI06")
		}))

		return
	end

	local data = configBuyTimes[self._buyTime + 1]
	local hasnum = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)
	local canBuy = hasnum >= data[1]

	if canBuy then
		self._cooperateBossSystem:requestBuyFightTime()
	else
		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._shopSystem:tryEnter({
					shopId = "Shop_Mall"
				})
			elseif data.response == "cancel" then
				outSelf:close()
			elseif data.response == "close" then
				-- block empty
			end
		end

		local data = {
			title1 = "Tips",
			title = Strings:get("Tip_Remind"),
			content = Strings:get("CooperateBoss_DimondTip"),
			sureBtn = {},
			cancelBtn = {}
		}
		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))

		return
	end
end

function CooperateBossBuyTimeMediator:onClickClose()
	self:close()
end
