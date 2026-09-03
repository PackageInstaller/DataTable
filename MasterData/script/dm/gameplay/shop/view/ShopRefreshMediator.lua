-- chunkname: @/tmp/or_script/lua_compile/dm/gameplay/shop/view/ShopRefreshMediator.lua

ShopRefreshMediator = class("ShopRefreshMediator", DmPopupViewMediator, _M)

ShopRefreshMediator:has("_shopSystem", {
	is = "r"
}):injectWith("ShopSystem")
ShopRefreshMediator:has("_developSystem", {
	is = "r"
}):injectWith("DevelopSystem")

local kBtnHandlers = {}

function ShopRefreshMediator:initialize()
	super.initialize(self)
end

function ShopRefreshMediator:dispose()
	super.dispose(self)
end

function ShopRefreshMediator:onRegister()
	super.onRegister(self)
	self:mapButtonHandlersClick(kBtnHandlers)
end

function ShopRefreshMediator:enterWithData(data)
	self:bindWidget("main.bg", PopupNormalWidget, {
		btnHandler = {
			clickAudio = "Se_Click_Close_2",
			func = bind1(self.onCloseClicked, self)
		},
		title = Strings:get("SHOP_REFRESH_DESC_TEXT1"),
		title1 = Strings:get("UITitle_EN_Tishi")
	})
	self:bindWidget("main.yes_btn", OneLevelViceButton, {
		handler = {
			clickAudio = "Se_Click_Confirm",
			func = bind1(self.onClikcedYesBtn, self)
		}
	})
	self:initMember()

	self._shopGroupData = data

	self:refreshInfo()
end

function ShopRefreshMediator:onCloseClicked()
	self:close()
end

function ShopRefreshMediator:initMember()
	self._view = self:getView()
	self._bagSystem = self._developSystem:getBagSystem()
	self._node1 = self._view:getChildByFullName("main.node1")
	self._node2 = self._view:getChildByFullName("main.node2")
	self._moneyIcon = self._node1:getChildByFullName("money_icon")
	self._costText = self._node1:getChildByFullName("cost_text")
	self._timesText = self._node2:getChildByFullName("times_text")
	self._cost = 0

	GameStyle:setCommonOutlineEffect(self._costText, 127)
end

function ShopRefreshMediator:onClikcedYesBtn(sender, eventType)
	local shopId = self._shopGroupData:getShopId()
	local costType = self._shopGroupData:getRefreshCurrency()

	if self._bagSystem:checkCostEnough(CurrencyIdKind.kDiamond, self._cost, {
		type = "tip"
	}) then
		self._shopSystem:requestRefresh(tostring(shopId))
		self:close()
	end
end

function ShopRefreshMediator:refreshInfo()
	if self._shopGroupData then
		self._cost = self._shopGroupData:getRefreshCost()

		self._costText:setString(tostring(self._cost))
		self._moneyIcon:removeAllChildren()

		local costIcon = IconFactory:createPic({
			id = self._shopGroupData:getRefreshCurrency()
		})

		costIcon:addTo(self._moneyIcon):center(self._moneyIcon:getContentSize()):offset(0, 2)

		local times = self._shopGroupData:getRemainRefreshTimes()

		self._timesText:setString(Strings:get("Shop_Text12", {
			num = times
		}))

		local label1 = self._node1:getChildByFullName("Text_2")
		local width = label1:getContentSize().width

		self._moneyIcon:setPositionX(label1:getPositionX() + 5)

		width = width + costIcon:getContentSize().width - 5

		self._costText:setPositionX(self._moneyIcon:getPositionX() + self._moneyIcon:getContentSize().width - 6)

		width = width + self._costText:getContentSize().width - 7

		local label2 = self._node1:getChildByFullName("Text_4")

		label2:setPositionX(self._costText:getPositionX() + self._costText:getContentSize().width + 8)

		width = width + label2:getContentSize().width + 8
	end
end

function ShopRefreshMediator:getMoneyByType(costType)
	local bagSystem = self:getInjector():getInstance(DevelopSystem):getBagSystem()
	local cost = -1

	if costType == CurrencyIdKind.kGold then
		cost = bagSystem:getGold()
	elseif costType == CurrencyIdKind.kDiamond then
		cost = bagSystem:getDiamond()
	elseif costType == CurrencyIdKind.kPower then
		cost = bagSystem:getPower()
	end

	return cost
end
