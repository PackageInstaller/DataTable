-- chunkname: @modules/logic/room/view/trade/RoomDailyOrderView.lua

module("modules.logic.room.view.trade.RoomDailyOrderView", package.seeall)

local RoomDailyOrderView = class("RoomDailyOrderView", BaseView)

function RoomDailyOrderView:onInitView()
	self._gotip = gohelper.findChild(self.viewGO, "tip")
	self._txttip1 = gohelper.findChildText(self.viewGO, "tip/#txt_tip1")
	self._txttip2 = gohelper.findChildText(self.viewGO, "tip/#txt_tip2")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._gonotorder = gohelper.findChild(self.viewGO, "#go_notorder")
	self._gorole = gohelper.findChild(self.viewGO, "#go_notorder/spine/#go_role")
	self._txtname = gohelper.findChildText(self.viewGO, "#go_notorder/barrage/namebg/#txt_name")
	self._scrollbarrage = gohelper.findChildScrollRect(self.viewGO, "#go_notorder/barrage/#scroll_barrage")
	self._txtbarrage = gohelper.findChildText(self.viewGO, "#go_notorder/barrage/#scroll_barrage/Viewport/#txt_barrage")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "#go_notorder/#simage_icon")
	self._gonotorder2 = gohelper.findChild(self.viewGO, "#go_notorder2")
	self._simageicon2 = gohelper.findChildSingleImage(self.viewGO, "#go_notorder2/#simage_icon")
	self._txtbarrage2 = gohelper.findChildText(self.viewGO, "#go_notorder2/barrage/#scroll_barrage/Viewport/#txt_barrage")
	self._txtname2 = gohelper.findChildText(self.viewGO, "#go_notorder2/barrage/namebg/#txt_name")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomDailyOrderView:addEvents()
	BackpackController.instance:registerCallback(BackpackEvent.UpdateItemList, self.refrshCurrency, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, self.finishOrder, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnRefreshDailyOrder, self.refreshOrder, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnTracedDailyOrder, self.refreshTraced, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnLockedDailyOrder, self.refreshLocked, self)
end

function RoomDailyOrderView:removeEvents()
	BackpackController.instance:unregisterCallback(BackpackEvent.UpdateItemList, self.refrshCurrency, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, self.finishOrder, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnRefreshDailyOrder, self.refreshOrder, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnTracedDailyOrder, self.refreshTraced, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnLockedDailyOrder, self.refreshLocked, self)
end

function RoomDailyOrderView:_editableInitView()
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function RoomDailyOrderView:onUpdateParam()
	return
end

function RoomDailyOrderView:onOpen()
	self:onRefresh()
end

function RoomDailyOrderView:onRefresh()
	self:refreshOrderItem()
	self:refreshFinishCount()
	self:refreshRefreshCount()
end

function RoomDailyOrderView:_getOrderItem(index)
	local item = self._orderItems[index]

	if not item then
		local child = self:getResInst(RoomDailyOrderItem.ResUrl, self._goroot, string.format("roomdailyorderitem%s", index))

		item = MonoHelper.addNoUpdateLuaComOnceToGo(child, RoomDailyOrderItem)
		item.viewContainer = self.viewContainer
		self._orderItems[index] = item

		item:playOpenAnim(index)
	end

	return item
end

function RoomDailyOrderView:refreshFinishCount()
	local lang = luaLang("room_tade_dailyorder_tip")
	local count, max = RoomTradeModel.instance:getDailyOrderFinishCount()
	local isFinishAll = max <= count
	local color = isFinishAll and "#a63838" or "#EFEFEF"

	self._txttip1.text = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, color, count, max)

	self:refreshFinishBarrage(isFinishAll)
end

function RoomDailyOrderView:refreshRefreshCount()
	local lang = luaLang("room_tade_dailyorder_active_refresh_tip")
	local count, max = RoomTradeModel.instance:getRefreshCount()

	count = max - count

	local isFinishAll = max <= count
	local color = isFinishAll and "#a63838" or "#EFEFEF"

	self._txttip2.text = GameUtil.getSubPlaceholderLuaLangThreeParam(lang, color, count, max)

	gohelper.setActive(self._txttip2, max > 0)
end

function RoomDailyOrderView:refreshFinishBarrage(isFinishAll)
	if isFinishAll then
		local barrageCo = RoomTradeModel.instance:getBarrageCo(RoomTradeEnum.BarrageType.DailyOrder)
		local heroId = barrageCo.heroId
		local barrageIcon = barrageCo.icon
		local config, icon

		if not string.nilorempty(barrageIcon) then
			local itemId = tonumber(barrageIcon)

			config, icon = ItemModel.instance:getItemConfigAndIcon(MaterialEnum.MaterialType.Item, itemId)
		end

		if heroId and heroId ~= 0 then
			local heroConfig = HeroConfig.instance:getHeroCO(heroId)
			local skinId = heroConfig.skinId

			self.skinCo = SkinConfig.instance:getSkinCo(skinId)
			self.smallSpine = self.smallSpine or GuiSpine.Create(self._gorole, false)

			self.smallSpine:stopVoice()
			self.smallSpine:setResPath(ResUrl.getSpineUIPrefab(self.skinCo.spine), self._onSpineLoaded, self, true)

			if not string.nilorempty(icon) then
				self._simageicon:LoadImage(icon)
			end

			if config then
				self._txtname.text = config.name
			end

			self._txtbarrage.text = barrageCo.desc

			gohelper.setActive(self._gonotorder, true)
			gohelper.setActive(self._gonotorder2, false)
		else
			if not string.nilorempty(icon) then
				self._simageicon2:LoadImage(icon)
			end

			if config then
				self._txtname2.text = config.name
			end

			self._txtbarrage2.text = barrageCo.desc

			gohelper.setActive(self._gonotorder, false)
			gohelper.setActive(self._gonotorder2, true)
		end

		self._animator:Play(RoomTradeEnum.TradeAnim.DailyOrderOpen, 0, 0)
	else
		gohelper.setActive(self._gonotorder, false)
		gohelper.setActive(self._gonotorder2, false)
	end

	gohelper.setActive(self._goroot, not isFinishAll)
	gohelper.setActive(self._gotip, not isFinishAll)
end

function RoomDailyOrderView:_onSpineLoaded()
	local offsets = SkinConfig.instance:getSkinOffset(self.skinCo.skinSpineOffset)

	recthelper.setAnchor(self._gorole.transform, tonumber(offsets[1]), tonumber(offsets[2]))
	transformhelper.setLocalScale(self._gorole.transform, tonumber(offsets[3]), tonumber(offsets[3]), tonumber(offsets[3]))
end

function RoomDailyOrderView:refreshOrderItem()
	local orders = RoomTradeModel.instance:getDailyOrders()

	self._orderItems = self._orderItems or self:getUserDataTb_()

	if orders then
		for i, order in ipairs(orders) do
			local item = self:_getOrderItem(i)

			item:onUpdateMo(order)
		end

		for i = #orders + 1, #self._orderItems do
			gohelper.setActive(self._orderItems[i].viewGO, false)
		end
	end
end

function RoomDailyOrderView:finishOrder(orderType)
	if orderType ~= RoomTradeEnum.Mode.DailyOrder then
		return
	end

	self:onRefresh()
end

function RoomDailyOrderView:refreshOrder()
	self:onRefresh()
end

function RoomDailyOrderView:refrshCurrency()
	local orders = RoomTradeModel.instance:getDailyOrders()

	if orders then
		for i = 1, #orders do
			local item = self:_getOrderItem(i)

			item:onRefresh()
		end
	end
end

function RoomDailyOrderView:refreshTraced(orderId)
	local _, index = RoomTradeModel.instance:getDailyOrderById(orderId)
	local item = self:_getOrderItem(index)

	item:refreshTraced()
end

function RoomDailyOrderView:refreshLocked(orderId)
	local _, index = RoomTradeModel.instance:getDailyOrderById(orderId)
	local item = self:_getOrderItem(index)

	item:refreshLocked()
end

function RoomDailyOrderView:onClose()
	return
end

function RoomDailyOrderView:onDestroyView()
	if self.smallSpine then
		self.smallSpine:stopVoice()

		self.smallSpine = nil
	end
end

return RoomDailyOrderView
