-- chunkname: @modules/logic/chargepush/view/ChargePushMonthCardView.lua

module("modules.logic.chargepush.view.ChargePushMonthCardView", package.seeall)

local ChargePushMonthCardView = class("ChargePushMonthCardView", BaseView)

function ChargePushMonthCardView:onInitView()
	self.btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_Close")
	self.btnLeft = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyLeft")
	self.btnRight = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyRight")
	self.btnTop = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyTop")
	self.btnBottom = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_emptyBottom")
	self.txtDesc = gohelper.findChildTextMesh(self.viewGO, "root/info/#scroll_desc/Viewport/#txt_desc")
	self.txtTime = gohelper.findChildTextMesh(self.viewGO, "root/info/LimitTime/image_LimitTimeBG/#txt_LimitTime")
	self.btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/buy/#btn_buy")
	self.txtCost = gohelper.findChildText(self.viewGO, "root/buy/#txt_cost")
	self.txtCostIcon = gohelper.findChildTextMesh(self.viewGO, "root/buy/costicon")
	self.goIcon1 = gohelper.findChild(self.viewGO, "root/reward1/#go_icon1")
	self.goIcon2 = gohelper.findChild(self.viewGO, "root/reward1/#go_icon2")
	self.goIcon3 = gohelper.findChild(self.viewGO, "root/reward2/#go_icon1")
	self.goIcon4 = gohelper.findChild(self.viewGO, "root/reward2/#go_icon2")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChargePushMonthCardView:addEvents()
	self.addClickCb(self, self.btnClose, self.onClickClose, self)
	self.addClickCb(self, self.btnLeft, self.onClickClose, self)
	self.addClickCb(self, self.btnRight, self.onClickClose, self)
	self.addClickCb(self, self.btnTop, self.onClickClose, self)
	self.addClickCb(self, self.btnBottom, self.onClickClose, self)
	self.addClickCb(self, self.btnBuy, self.onClickBuy, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function ChargePushMonthCardView:removeEvents()
	self:removeClickCb(self.btnClose)
	self:removeClickCb(self.btnLeft)
	self:removeClickCb(self.btnRight)
	self:removeClickCb(self.btnTop)
	self:removeClickCb(self.btnBottom)
	self:removeClickCb(self.btnBuy)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function ChargePushMonthCardView:_editableInitView()
	return
end

function ChargePushMonthCardView:_payFinished()
	self:closeThis()
end

function ChargePushMonthCardView:onClickBuy()
	local packageMo = StoreModel.instance:getGoodsMO(self.goodsId)

	if not packageMo then
		return
	end

	StoreController.instance:openPackageStoreGoodsView(packageMo)
end

function ChargePushMonthCardView:onOpen()
	self:refreshParam()
	self:refreshView()
end

function ChargePushMonthCardView:onUpdateParam()
	self:refreshParam()
	self:refreshView()
end

function ChargePushMonthCardView:refreshParam()
	self.config = self.viewParam and self.viewParam.config
	self.goodsId = StoreEnum.MonthCardGoodsId
end

function ChargePushMonthCardView:refreshView()
	if not self.config then
		return
	end

	self.txtDesc.text = self.config.desc
	self.txtCost.text = PayModel.instance:getProductOriginPriceNum(self.goodsId)
	self.txtCostIcon.text = PayModel.instance:getProductOriginPriceSymbol(self.goodsId)

	self:updateMonthCardItem()
	self:refreshRemainDay()
end

function ChargePushMonthCardView:refreshRemainDay()
	if tonumber(self.config.listenerType) == ChargePushEnum.ListenerType.MonthCardAfter then
		self.txtTime.text = luaLang("hasExpire")

		return
	end

	local cardInfo = StoreModel.instance:getMonthCardInfo()

	if cardInfo then
		local remainDay = cardInfo:getRemainDay()

		self.txtTime.text = remainDay == StoreEnum.MonthCardStatus.NotPurchase and luaLang("hasExpire") or remainDay == StoreEnum.MonthCardStatus.NotEnoughOneDay and luaLang("not_enough_one_day") or formatLuaLang("remain_day", remainDay)
	else
		self.txtTime.text = luaLang("not_purchase")
	end
end

function ChargePushMonthCardView:updateMonthCardItem()
	local monthCardCo = StoreConfig.instance:getMonthCardConfig(self.goodsId)
	local onceBonus = GameUtil.splitString2(monthCardCo.onceBonus, true)
	local temp = onceBonus[1]
	local type = temp[1]
	local id = temp[2]
	local quantity = temp[3]

	self._monthCardItemIcon = self._monthCardItemIcon or IconMgr.instance:getCommonItemIcon(self.goIcon1)

	self:_setIcon(self._monthCardItemIcon, type, id, quantity)

	temp = onceBonus[2]
	type = onceBonus[2][1]
	id = onceBonus[2][2]
	quantity = onceBonus[2][3]
	self._monthCardItemIcon2 = self._monthCardItemIcon2 or IconMgr.instance:getCommonItemIcon(self.goIcon2)

	self:_setIcon(self._monthCardItemIcon2, type, id, quantity)

	local dailyBonus = GameUtil.splitString2(monthCardCo.dailyBonus, true)

	temp = dailyBonus[1]
	type = dailyBonus[1][1]
	id = dailyBonus[1][2]
	quantity = dailyBonus[1][3]
	self._monthCardDailyItemIcon = self._monthCardDailyItemIcon or IconMgr.instance:getCommonItemIcon(self.goIcon3)

	self:_setIcon(self._monthCardDailyItemIcon, type, id, quantity)

	temp = dailyBonus[2]
	type = dailyBonus[2][1]
	id = dailyBonus[2][2]
	quantity = dailyBonus[2][3]
	self._monthCardPowerItemIcon = self._monthCardPowerItemIcon or IconMgr.instance:getCommonItemIcon(self.goIcon4)

	self:_setIcon(self._monthCardPowerItemIcon, type, id, quantity)
end

function ChargePushMonthCardView:_setIcon(icon, type, id, quantity)
	if type == MaterialEnum.MaterialType.PowerPotion then
		icon:setMOValue(type, id, quantity, nil, true)
		icon:setCantJump(true)
		icon:setCountFontSize(36)
		icon:setScale(0.7)
		icon:SetCountLocalY(43.6)
		icon:SetCountBgHeight(25)
		icon:setItemIconScale(1.1)

		local icontrs = icon:getIcon().transform

		recthelper.setAnchor(icontrs, -7.2, 3.5)

		local deadline1 = icon:getDeadline1()

		recthelper.setAnchor(deadline1.transform, 78, 82.8)
		transformhelper.setLocalScale(deadline1.transform, 0.7, 0.7, 1)

		self._simgdeadline = gohelper.findChildImage(deadline1, "timebg")

		UISpriteSetMgr.instance:setStoreGoodsSprite(self._simgdeadline, "img_xianshi1")
	else
		icon:setMOValue(type, id, quantity, nil, true)
		icon:setCantJump(true)
		icon:setCountFontSize(36)
		icon:setScale(0.7)
		icon:SetCountLocalY(43.6)
		icon:SetCountBgHeight(25)
	end
end

function ChargePushMonthCardView:onClose()
	return
end

function ChargePushMonthCardView:onDestroyView()
	return
end

function ChargePushMonthCardView:onClickClose()
	self:closeThis()
end

function ChargePushMonthCardView:onClickModalMask()
	self:closeThis()
end

return ChargePushMonthCardView
