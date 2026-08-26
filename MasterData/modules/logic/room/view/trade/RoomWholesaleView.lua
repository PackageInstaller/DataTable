-- chunkname: @modules/logic/room/view/trade/RoomWholesaleView.lua

module("modules.logic.room.view.trade.RoomWholesaleView", package.seeall)

local RoomWholesaleView = class("RoomWholesaleView", BaseView)

function RoomWholesaleView:onInitView()
	self._txttip = gohelper.findChildText(self.viewGO, "#txt_tip")
	self._txtnum = gohelper.findChildText(self.viewGO, "tipsbg2/#txt_num")
	self._goroot = gohelper.findChild(self.viewGO, "#go_root")
	self._btnleft = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_left")
	self._btnright = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_right")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function RoomWholesaleView:addEvents()
	self._btnleft:AddClickListener(self._btnleftOnClick, self)
	self._btnright:AddClickListener(self._btnrightOnClick, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	RoomTradeController.instance:registerCallback(RoomTradeEvent.OnFinishOrder, self.finishOrder, self)
end

function RoomWholesaleView:removeEvents()
	self._btnleft:RemoveClickListener()
	self._btnright:RemoveClickListener()
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnGetTradeOrderInfo, self.onRefresh, self)
	RoomTradeController.instance:unregisterCallback(RoomTradeEvent.OnFinishOrder, self.finishOrder, self)
end

function RoomWholesaleView:_btnleftOnClick()
	if self._selectPageIndex <= 0 or self._isPlaySwitchAnim then
		return
	end

	self._selectPageIndex = self._selectPageIndex - 1

	self:_cutPage()
end

function RoomWholesaleView:_btnrightOnClick()
	if self._selectPageIndex >= RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() or self._isPlaySwitchAnim then
		return
	end

	self._selectPageIndex = self._selectPageIndex + 1

	self:_cutPage()
end

function RoomWholesaleView:_cutPage()
	self._isPlaySwitchAnim = true

	self.viewContainer:playAnim(RoomTradeEnum.TradeAnim.Swicth)
	TaskDispatcher.cancelTask(self.refreshOrderPage, self)
	TaskDispatcher.runDelay(self.refreshOrderPage, self, 0.16)
end

function RoomWholesaleView:_editableInitView()
	return
end

function RoomWholesaleView:onUpdateParam()
	return
end

function RoomWholesaleView:onOpen()
	self._selectPageIndex = 0

	self:onRefresh()
end

function RoomWholesaleView:onClose()
	TaskDispatcher.cancelTask(self.refreshOrderPage, self)
end

function RoomWholesaleView:onDestroyView()
	return
end

function RoomWholesaleView:onRefresh()
	self:refreshOrderPage()

	self._txtnum.text = RoomTradeModel.instance:getWeeklyWholesaleRevenue()
end

function RoomWholesaleView:_getOrderItem(index)
	local item = self._orderItems[index]

	if not item then
		local child = self:getResInst(RoomWholesaleItem.ResUrl, self._goroot)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(child, RoomWholesaleItem)
		self._orderItems[index] = item
	end

	return item
end

function RoomWholesaleView:refreshOrderPage()
	self._isPlaySwitchAnim = nil

	local orders = RoomTradeModel.instance:getWholesaleGoodsByPageIndex(self._selectPageIndex)

	self._orderItems = self._orderItems or self:getUserDataTb_()

	if orders then
		for i, order in ipairs(orders) do
			local item = self:_getOrderItem(i)

			item:onUpdateMo(order)
		end

		for i = 1, #self._orderItems do
			gohelper.setActive(self._orderItems[i].viewGO, i <= #orders)
		end
	end

	local isNotFirst = self._selectPageIndex > 0
	local isNotLastest = self._selectPageIndex < RoomTradeModel.instance:getWholesaleGoodsPageMaxCount() - 1

	gohelper.setActive(self._btnleft.gameObject, isNotFirst)
	gohelper.setActive(self._btnright.gameObject, isNotLastest)
	RoomTradeController.instance:dispatchEvent(RoomTradeEvent.OnCutOrderPage, self._selectPageIndex + 1)
end

function RoomWholesaleView:finishOrder(orderType)
	if orderType ~= RoomTradeEnum.Mode.Wholesale then
		return
	end

	self:onRefresh()
end

return RoomWholesaleView
