-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityQuoteBargainItem.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityQuoteBargainItem", package.seeall)

local ActivityQuoteBargainItem = class("ActivityQuoteBargainItem", UserDataDispose)

function ActivityQuoteBargainItem:ctor(go, gotarget)
	self:__onInit()

	self.viewGO = go

	local gotargetParent = gohelper.findChild(self.viewGO, "#go_target")

	self._gotarget = gohelper.clone(gotarget, gotargetParent)

	recthelper.setAnchor(self._gotarget.transform, 0, 0)

	self._scrollinfo = gohelper.findChildScrollRect(self.viewGO, "#scroll_info")
	self._content = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content")
	self._goquoteitem = gohelper.findChild(self.viewGO, "#scroll_info/Viewport/Content/#go_quoteitem")

	self:initDailySelected()
	self:addEvents()
end

function ActivityQuoteBargainItem:addEvents()
	return
end

function ActivityQuoteBargainItem:removeEvents()
	return
end

function ActivityQuoteBargainItem:refresh(actId)
	self.actId = actId

	if self:noSelectOrder() then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local mo = Activity117Model.instance:getOrderDataById(self.actId, self:getSelectOrderId())

	self.quoteItem = self.quoteItem or ActivityQuoteItem.New(self._goquoteitem)

	self.quoteItem:setData(mo)
	self._selectItem:setData(mo)
end

function ActivityQuoteBargainItem:initDailySelected()
	self._selectItem = ActivityQuoteDemandItem.New(self._gotarget, true)
end

function ActivityQuoteBargainItem:getSelectOrderId()
	return Activity117Model.instance:getSelectOrder(self.actId)
end

function ActivityQuoteBargainItem:noSelectOrder()
	return not self:getSelectOrderId()
end

function ActivityQuoteBargainItem:onDeal()
	if self:noSelectOrder() then
		gohelper.setActive(self.viewGO, false)

		return
	end

	gohelper.setActive(self.viewGO, true)

	local mo = Activity117Model.instance:getOrderDataById(self.actId, self:getSelectOrderId())

	self.quoteItem = self.quoteItem or ActivityQuoteItem.New(self._goquoteitem)

	self.quoteItem:setData(mo)
	self._selectItem:setData(mo)
end

function ActivityQuoteBargainItem:onNegotiate()
	if self:noSelectOrder() then
		gohelper.setActive(self.viewGO, false)

		return
	end

	local mo = Activity117Model.instance:getOrderDataById(self.actId, self:getSelectOrderId())

	if self.quoteItem then
		self.quoteItem:onNegotiate(mo)
	end
end

function ActivityQuoteBargainItem:destory()
	if self.quoteItem then
		self.quoteItem:destory()

		self.quoteItem = nil
	end

	if self._selectItem then
		self._selectItem:destory()

		self._selectItem = nil
	end

	self:removeEvents()
	self:__onDispose()
end

return ActivityQuoteBargainItem
