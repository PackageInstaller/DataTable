-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/recruit/view/RecruitBuyCardMediator.lua

RecruitBuyCardMediator = class("RecruitBuyCardMediator", DmPopupViewMediator, _M)

RecruitBuyCardMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")
RecruitBuyCardMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
RecruitBuyCardMediator:has("_recruitSystem", {
	is = "r"
}):injectWith("RecruitSystem")
RecruitBuyCardMediator:has("_activitySystem", {
	is = "r"
}):injectWith("ActivitySystem")

local kBtnHandlers = {
	buyBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickBuy"
	},
	closeBtn = {
		clickAudio = "Se_Click_Common_1",
		func = "onClickCloseTip"
	}
}

function RecruitBuyCardMediator:initialize()
	super.initialize(self)
end

function RecruitBuyCardMediator:dispose()
	super.dispose(self)
end

function RecruitBuyCardMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)

	self._bagSystem = self._developSystem:getBagSystem()

	self.mapEventListener(self, self:getEventDispatcher(), EVT_PLAYER_SYNCHRONIZED, self, self.updateData)
end

function RecruitBuyCardMediator:enterWithData(data)
	self:initData(data)
	bindWidget(self, self:getView():getChildByName("bgNode"), PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onClickClose, self)
		},
		title = RecruitCurrencyStr.KBuyTitle[self._costId],
		title1 = RecruitCurrencyStr.KBuyTitle1[self._costId]
	})

	self._ensureBtn = self:bindWidget("sureBtn", OneLevelMainButton, {
		handler = {
			clickAudio = "Se_Click_Common_1",
			func = bind1(self.onClickEnsure, self)
		}
	})
	self._buyBtn = self:getView():getChildByName("buyBtn")
	self._closeBtn = self:getView():getChildByName("closeBtn")
	self._closeBtnSelectImg = self._closeBtn:getChildByName("image")
	self._tipLabel = self:getView():getChildByName("tipLabel")
	self._buyPanel = self:getView():getChildByName("buyPanel")

	self._ensureBtn:setVisible(false)
	self._tipLabel:setVisible(false)
	GameStyle:setCommonOutlineEffect(self._tipLabel)
	self._buyBtn:setVisible(false)
	self._buyPanel:setVisible(false)
	self:initView()
	self:onClickCloseTip()
end

function RecruitBuyCardMediator:initData(data)
	self._param = data.param
	self._costId = data.itemId

	local needCount = data.costCount

	self._activityId = data.activityId

	local hasCount = self._bagSystem:getItemCount(self._costId)

	self._num = needCount - hasCount

	if self._param.times == 1 then
		if not RecruitCurrencyStr.KBuyPrice.single[self._costId] then
			local price = RecruitCurrencyStr.KBuyPrice.ten[self._costId]

			self._cost = self._num * price

			local hasDiamondCount = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)

			self._canBuy = hasDiamondCount >= self._cost
		end
	end
end

function RecruitBuyCardMediator:updateData()
	local hasDiamondCount = self._bagSystem:getItemCount(CurrencyIdKind.kDiamond)

	self._canBuy = hasDiamondCount >= self._cost
end

function RecruitBuyCardMediator:initView()
	self._buyBtn:setVisible(true)
	self._buyPanel:setVisible(true)
	self._buyPanel:getChildByName("tipLabel"):setString(Strings:get(RecruitCurrencyStr.KBuyContent[self._costId], {
		cost = self._cost,
		num = self._num
	}))
	GameStyle:setCommonOutlineEffect(self._buyPanel:getChildByName("tipLabel"))
	self._buyBtn:getChildByName("text"):setString(self._cost)

	local icon = IconFactory:createIcon({
		id = self._costId,
		amount = self._num
	}, {
		showAmount = true
	})

	icon:addTo(self._buyPanel)
	icon:setPosition(cc.p(40, 40))
	icon:setScale(0.8)
end

function RecruitBuyCardMediator:onClickEnsure()
	self:closeView({
		callback = function()
			self._shopSystem:tryEnter({
				shopId = "Shop_Normal"
			})
		end
	})
end

function RecruitBuyCardMediator:onClickBuy()
	if not self._canBuy then
		local data = {
			title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
			content = RecruitCurrencyStr.KGoToShop[self._costId],
			sureBtn = {},
			cancelBtn = {}
		}

		self._developSystem:requstNotEnoughItem("DRAW", self._costId)

		local outSelf, delegate = self, {}

		function delegate:willClose(popupMediator, data)
			if data.response == "ok" then
				outSelf._shopSystem:tryEnter({
					shopId = "Shop_Mall"
				})
			end
		end

		local view = self:getInjector():getInstance("AlertView")

		self:dispatch(ViewEvent:new(EVT_SHOW_POPUP, view, {
			transition = ViewTransitionFactory:create(ViewTransitionType.kPopupEnter)
		}, data, delegate))
		self:closeView()

		return
	end

	self:closeView({
		callback = function()
			if self._activityId then
				self._activitySystem:requestRecruitActivity(self._activityId, self._param, nil)
			else
				self._recruitSystem:requestRecruit(self._param)
			end
		end
	})
end

function RecruitBuyCardMediator:onClickCloseTip(sender)
	if sender then
		self._closeBtnSelectImg:setVisible(not self._closeBtnSelectImg:isVisible())
	else
		local visible, userStr = self._recruitSystem:getBuyTipsStatus(self._costId)

		self._closeBtn:setVisible(visible)
		self._closeBtnSelectImg:setVisible(false)
	end
end

function RecruitBuyCardMediator:onClickClose()
	self:closeView()
end

function RecruitBuyCardMediator:closeView(data)
	self:close(data)
end

function RecruitBuyCardMediator:close(data)
	local isVisible = self._closeBtnSelectImg:isVisible()

	if isVisible then
		local visible, userStr = self._recruitSystem:getBuyTipsStatus(self._costId)

		cc.UserDefault:getInstance():setIntegerForKey(userStr, self:getInjector():getInstance("GameServerAgent"):remoteTimestamp())
	end

	super.close(self, data)
end
