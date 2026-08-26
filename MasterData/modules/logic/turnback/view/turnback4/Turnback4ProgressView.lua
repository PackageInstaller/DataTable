-- chunkname: @modules/logic/turnback/view/turnback4/Turnback4ProgressView.lua

module("modules.logic.turnback.view.turnback4.Turnback4ProgressView", package.seeall)

local Turnback4ProgressView = class("Turnback4ProgressView", BaseView)

function Turnback4ProgressView:onInitView()
	self._scrolllist = gohelper.findChildScrollRect(self.viewGO, "bg/#scroll_list")
	self._goItem = gohelper.findChild(self.viewGO, "bg/#scroll_list/viewport/content/item")
	self._txtnum = gohelper.findChildText(self.viewGO, "bg/Rest/#txt_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function Turnback4ProgressView:addEvents()
	self.addEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshTurnBack, self)
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshCurrency, self)
end

function Turnback4ProgressView:removeEvents()
	self.removeEventCb(self, TurnbackController.instance, TurnbackEvent.RefreshView, self._refreshTurnBack, self)
	self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseView, self)
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshCurrency, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshCurrency, self)
end

function Turnback4ProgressView:_refreshCurrency()
	self._isRefreshItem = true
end

function Turnback4ProgressView:_onCloseView(viewName)
	local isTop = ViewHelper.instance:checkViewOnTheTop(self.viewName)

	if isTop and self._isRefreshItem then
		TurnbackRpc.instance:sendGetTurnbackInfoRequest()

		self._isRefreshItem = false
	end
end

function Turnback4ProgressView:_editableInitView()
	gohelper.setActive(self._goItem, false)
end

function Turnback4ProgressView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._progressItems = {}

	local mos = TurnbackModel.instance:getDropInfos()

	if mos then
		for i, mo in ipairs(mos) do
			local item = self:_getItem(i)

			item:onUpdateMO(mo)
		end
	end

	AudioMgr.instance:trigger(AudioEnum.NewTurnabck.play_ui_call_back_Interface_entry_03)

	self._scrolllist.verticalNormalizedPosition = 1
	self._txtnum.text = TurnbackModel.instance:getTotalCouponCount()
end

function Turnback4ProgressView:_refreshTurnBack()
	for i, item in ipairs(self._progressItems) do
		item:refreshTurnBack()
	end

	self._txtnum.text = TurnbackModel.instance:getTotalCouponCount()
end

function Turnback4ProgressView:_getItem(index)
	local item = self._progressItems[index]

	if not item then
		local go = gohelper.cloneInPlace(self._goItem)

		item = MonoHelper.addNoUpdateLuaComOnceToGo(go, Turnback4ProgressItem)

		gohelper.setActive(go, true)
		table.insert(self._progressItems, item)
	end

	return item
end

return Turnback4ProgressView
