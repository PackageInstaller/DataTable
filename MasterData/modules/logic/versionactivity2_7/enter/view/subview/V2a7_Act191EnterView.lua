-- chunkname: @modules/logic/versionactivity2_7/enter/view/subview/V2a7_Act191EnterView.lua

module("modules.logic.versionactivity2_7.enter.view.subview.V2a7_Act191EnterView", package.seeall)

local V2a7_Act191EnterView = class("V2a7_Act191EnterView", VersionActivityEnterBaseSubView)

function V2a7_Act191EnterView:onInitView()
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "#btn_Shop/#txt_num")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V2a7_Act191EnterView:addEvents()
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
end

function V2a7_Act191EnterView:removeEvents()
	self._btnShop:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function V2a7_Act191EnterView:_btnShopOnClick()
	Activity191Controller.instance:openStoreView(VersionActivity2_7Enum.ActivityId.Act191Store)
end

function V2a7_Act191EnterView:_btnEnterOnClick()
	Activity191Controller.instance:enterActivity(self.actId)
end

function V2a7_Act191EnterView:_editableInitView()
	self.actId = VersionActivity2_7Enum.ActivityId.Act191

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc
end

function V2a7_Act191EnterView:onOpen()
	V2a7_Act191EnterView.super.onOpen(self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self:refreshCurrency()
end

function V2a7_Act191EnterView:everySecondCall()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V2a7_Act191EnterView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Act191)

	self._txtnum.text = currencyMo.quantity
end

return V2a7_Act191EnterView
