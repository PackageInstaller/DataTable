-- chunkname: @modules/logic/versionactivity3_1/enter/view/subview/V3a1_Act191EnterView.lua

module("modules.logic.versionactivity3_1.enter.view.subview.V3a1_Act191EnterView", package.seeall)

local V3a1_Act191EnterView = class("V3a1_Act191EnterView", VersionActivityEnterBaseSubView)

function V3a1_Act191EnterView:onInitView()
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "#btn_Shop/#txt_num")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a1_Act191EnterView:addEvents()
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
end

function V3a1_Act191EnterView:removeEvents()
	self._btnShop:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function V3a1_Act191EnterView:_btnShopOnClick()
	Activity191Controller.instance:openStoreView()
end

function V3a1_Act191EnterView:_btnEnterOnClick()
	Activity191Controller.instance:enterActivity(self.actId)
end

function V3a1_Act191EnterView:_editableInitView()
	self.actId = Activity191Controller.instance:getActId()

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc
end

function V3a1_Act191EnterView:onOpen()
	V3a1_Act191EnterView.super.onOpen(self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
	self:refreshCurrency()
end

function V3a1_Act191EnterView:everySecondCall()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function V3a1_Act191EnterView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V3a8DouQuQu)

	self._txtnum.text = currencyMo.quantity
end

return V3a1_Act191EnterView
