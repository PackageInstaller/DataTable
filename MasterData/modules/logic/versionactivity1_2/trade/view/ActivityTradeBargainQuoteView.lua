-- chunkname: @modules/logic/versionactivity1_2/trade/view/ActivityTradeBargainQuoteView.lua

module("modules.logic.versionactivity1_2.trade.view.ActivityTradeBargainQuoteView", package.seeall)

local ActivityTradeBargainQuoteView = class("ActivityTradeBargainQuoteView", BaseView)

function ActivityTradeBargainQuoteView:onInitView()
	self._gotrade = gohelper.findChild(self.viewGO, "#go_trade")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ActivityTradeBargainQuoteView:addEvents()
	return
end

function ActivityTradeBargainQuoteView:removeEvents()
	return
end

function ActivityTradeBargainQuoteView:_editableInitView()
	self.tradeItem = ActivityQuoteTradeItem.New(self._gotrade)
end

function ActivityTradeBargainQuoteView:onDestroyView()
	if self.tradeItem then
		self.tradeItem:destory()

		self.tradeItem = nil
	end
end

function ActivityTradeBargainQuoteView:onOpen()
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.refreshUI, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.RefreshQuoteView, self.refreshUI, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveDeal, self.refreshUI, self)
	self.addEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveNegotiate, self.onNegotiate, self)
	self:_refreshUI()
end

function ActivityTradeBargainQuoteView:onClose()
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveInfos, self.refreshUI, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.RefreshQuoteView, self.refreshUI, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveDeal, self.refreshUI, self)
	self.removeEventCb(self, Activity117Controller.instance, Activity117Event.ReceiveNegotiate, self.onNegotiate, self)
end

function ActivityTradeBargainQuoteView:_refreshUI()
	local actId = self.viewContainer:getActId()

	self.tradeItem:refresh(actId)
end

function ActivityTradeBargainQuoteView:refreshUI(actId)
	if actId ~= self.viewContainer:getActId() then
		return
	end

	self:_refreshUI()
end

function ActivityTradeBargainQuoteView:onNegotiate(actId)
	if actId ~= self.viewContainer:getActId() then
		return
	end

	self.tradeItem:onNegotiate()
end

return ActivityTradeBargainQuoteView
