-- chunkname: @modules/logic/versionactivity2_3/enter/view/subview/VersionActivity2_3Act174EnterView.lua

module("modules.logic.versionactivity2_3.enter.view.subview.VersionActivity2_3Act174EnterView", package.seeall)

local VersionActivity2_3Act174EnterView = class("VersionActivity2_3Act174EnterView", BaseView)

function VersionActivity2_3Act174EnterView:onInitView()
	self._simagefullbg = gohelper.findChildSingleImage(self.viewGO, "#simage_fullbg")
	self._simagetitle = gohelper.findChildSingleImage(self.viewGO, "#simage_title")
	self._btnShop = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Shop")
	self._txtnum = gohelper.findChildText(self.viewGO, "#btn_Shop/#txt_num")
	self._btnEnter = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Enter")
	self._txttime = gohelper.findChildText(self.viewGO, "#txt_time")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity2_3Act174EnterView:addEvents()
	self._btnShop:AddClickListener(self._btnShopOnClick, self)
	self._btnEnter:AddClickListener(self._btnEnterOnClick, self)
end

function VersionActivity2_3Act174EnterView:removeEvents()
	self._btnShop:RemoveClickListener()
	self._btnEnter:RemoveClickListener()
end

function VersionActivity2_3Act174EnterView:_btnShopOnClick()
	Activity174Controller.instance:openStoreView(VersionActivity2_3Enum.ActivityId.Act174Store)
end

function VersionActivity2_3Act174EnterView:_btnEnterOnClick()
	Activity174Controller.instance:openMainView({
		actId = self.actId
	})
end

function VersionActivity2_3Act174EnterView:_editableInitView()
	self.animComp = VersionActivitySubAnimatorComp.get(self.viewGO, self)
	self.actId = VersionActivity2_3Enum.ActivityId.Act174

	local actCo = ActivityConfig.instance:getActivityCo(self.actId)

	self._txtdesc.text = actCo.actDesc
end

function VersionActivity2_3Act174EnterView:onOpen()
	self.animComp:playOpenAnim()
	self:refreshUI()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function VersionActivity2_3Act174EnterView:onClose()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshCurrency, self)
end

function VersionActivity2_3Act174EnterView:onDestroyView()
	TaskDispatcher.cancelTask(self.refreshLeftTime, self)
	self.animComp:destroy()
end

function VersionActivity2_3Act174EnterView:refreshUI()
	self:refreshLeftTime()
	self:refreshCurrency()
	TaskDispatcher.runRepeat(self.refreshLeftTime, self, TimeUtil.OneSecond)
end

function VersionActivity2_3Act174EnterView:refreshLeftTime()
	self._txttime.text = ActivityHelper.getActivityRemainTimeStr(self.actId)
end

function VersionActivity2_3Act174EnterView:refreshCurrency()
	local currencyMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.V2a3DouQuQu)

	self._txtnum.text = currencyMo.quantity
end

return VersionActivity2_3Act174EnterView
