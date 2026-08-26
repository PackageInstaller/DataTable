-- chunkname: @modules/logic/battlepass/view/BpBuyBtn.lua

module("modules.logic.battlepass.view.BpBuyBtn", package.seeall)

local BpBuyBtn = class("BpBuyBtn", BaseView)

function BpBuyBtn:onInitView()
	self._gobtns = gohelper.findChild(self.viewGO, "right/btngroup")
	self._btnGetAll = gohelper.findChildButtonWithAudio(self.viewGO, "right/btngroup/#btnGetAll")
	self._btnSwitch = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btnSwitch")
	self._btnSwitch2 = gohelper.findChildButtonWithAudio(self.viewGO, "right/#btnSwitch2")
	self._goSwitchRed = gohelper.findChild(self.viewGO, "right/#btnSwitch/#go_reddot")
	self._btnPay = gohelper.findChildButtonWithAudio(self.viewGO, "right/btngroup/#btnPay", AudioEnum.UI.UI_vertical_first_tabs_click)
	self._imagePay = gohelper.findChildImage(self.viewGO, "right/btngroup/#btnPay/bg")
	self._txtPayStatus = gohelper.findChildText(self.viewGO, "right/btngroup/#btnPay/cn")
	self._txtPayStatusEn = gohelper.findChildText(self.viewGO, "right/btngroup/#btnPay/cn/en")
	self._btnGet = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_get")
end

function BpBuyBtn:addEvents()
	self._btnGetAll:AddClickListener(self._onClickbtnGetAll, self)
	self._btnPay:AddClickListener(self._onClickbtnPay, self)

	if self._btnSwitch then
		self._btnSwitch:AddClickListener(self._onClickSwitch, self)
	end

	if self._btnGet then
		self._btnGet:AddClickListener(self._onClickbtnGetAll, self)
	end

	self.addEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self.updatePayBtn, self)
	self.addEventCb(self, BpController.instance, BpEvent.SetGetAllCallBack, self._setGetAllCb, self)
	self.addEventCb(self, BpController.instance, BpEvent.SetGetAllEnable, self.setGetAllEnable, self)
	self.addEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimBegin, self.closeAnimBegin, self)
	self.addEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimEnd, self.closeAnimEnd, self)
end

function BpBuyBtn:removeEvents()
	self._btnGetAll:RemoveClickListener()
	self._btnPay:RemoveClickListener()

	if self._btnSwitch then
		self._btnSwitch:RemoveClickListener()
	end

	if self._btnGet then
		self._btnGet:RemoveClickListener()
	end

	self.removeEventCb(self, BpController.instance, BpEvent.OnUpdatePayStatus, self.updatePayBtn, self)
	self.removeEventCb(self, BpController.instance, BpEvent.SetGetAllCallBack, self._setGetAllCb, self)
	self.removeEventCb(self, BpController.instance, BpEvent.SetGetAllEnable, self.setGetAllEnable, self)
	self.removeEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimBegin, self.closeAnimBegin, self)
	self.removeEventCb(self, self.viewContainer, BpEvent.TapViewCloseAnimEnd, self.closeAnimEnd, self)
end

function BpBuyBtn:_setGetAllCb(getAllCb, cbObj)
	self.getAllCb = getAllCb
	self.cbObj = cbObj
end

function BpBuyBtn:onClose()
	self.getAllCb = nil
	self.cbObj = nil

	TaskDispatcher.cancelTask(self._delaySwitch, self)
end

function BpBuyBtn:_onClickbtnGetAll()
	self.getAllCb(self.cbObj)
end

function BpBuyBtn:_onClickbtnPay()
	if BpModel.instance:isBpChargeEnd() then
		GameFacade.showToast(ToastEnum.BPChargeEnd)

		return
	end

	ViewMgr.instance:openView(BpController.instance:getBpChargeView())
end

function BpBuyBtn:_onClickSwitch()
	if self.viewName == ViewName.BpSPView and BpModel.instance.firstShow then
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	else
		ViewMgr.instance:openView(ViewName.BpChangeView)
		TaskDispatcher.runDelay(self._delaySwitch, self, 0.5)
	end
end

function BpBuyBtn:_delaySwitch()
	if self.viewName == ViewName.BpView then
		BpController.instance:openBattlePassView(true, {
			isSwitch = true
		})
	else
		BpController.instance:openBattlePassView(false, {
			isSwitch = true
		})
	end
end

function BpBuyBtn:setGetAllEnable(enable)
	gohelper.setActive(self._btnGetAll, not self._btnGet and enable or false)
	gohelper.setActive(self._btnGet, enable)

	if not self._btnSwitch then
		return
	end

	local bpCo = BpConfig.instance:getBpCO(BpModel.instance.id)

	if bpCo and bpCo.isSp and not BpModel.instance.firstShowSp then
		gohelper.setActive(self._btnSwitch, true)
		gohelper.setActive(self._btnSwitch2, true)
	else
		gohelper.setActive(self._btnSwitch, false)
		gohelper.setActive(self._btnSwitch2, false)
	end
end

function BpBuyBtn:onOpen()
	if self._goSwitchRed then
		if self.viewName == ViewName.BpView then
			RedDotController.instance:addRedDot(self._goSwitchRed, RedDotEnum.DotNode.BattlePassSPMain)
		else
			RedDotController.instance:addRedDot(self._goSwitchRed, RedDotEnum.DotNode.BattlePass)
		end
	end

	self:updatePayBtn()
end

function BpBuyBtn:closeAnimBegin()
	gohelper.setActive(self._gobtns, false)
end

function BpBuyBtn:closeAnimEnd()
	gohelper.setActive(self._gobtns, true)
end

function BpBuyBtn:updatePayBtn()
	if BpModel.instance.payStatus == BpEnum.PayStatus.Pay2 or self.viewName == ViewName.BpSPView then
		gohelper.setActive(self._btnPay.gameObject, false)

		return
	end

	gohelper.setActive(self._btnPay.gameObject, true)

	if BpModel.instance.payStatus == BpEnum.PayStatus.NotPay then
		self._txtPayStatus.text = luaLang("bp_active_pay1")
		self._txtPayStatusEn.text = luaLang("bp_active_pay1_en")
	elseif BpModel.instance.payStatus == BpEnum.PayStatus.Pay1 then
		self._txtPayStatus.text = luaLang("bp_active_pay2")
		self._txtPayStatusEn.text = luaLang("bp_active_pay2_en")
	end

	local leftTime = BpModel.instance:getBpChargeLeftSec()

	if leftTime and leftTime < 0 then
		ZProj.UGUIHelper.SetGrayscale(self._imagePay.gameObject, true)
	end
end

return BpBuyBtn
