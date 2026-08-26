-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftBuyTipView.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftBuyTipView", package.seeall)

local NationalGiftBuyTipView = class("NationalGiftBuyTipView", BaseView)

function NationalGiftBuyTipView:onInitView()
	self._gotip = gohelper.findChild(self.viewGO, "Title/image_TitleTips")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "Title/image_TitleTips/#btn_click")
	self._gobonusitem = gohelper.findChild(self.viewGO, "layout/#go_bonusitem")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Buy")
	self._txtPrice = gohelper.findChildText(self.viewGO, "#btn_Buy/#txt_Price")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txtlimit = gohelper.findChildText(self.viewGO, "#go_time/txt_limit")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._btnClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NationalGiftBuyTipView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self._btnClose:AddClickListener(self._btnCloseOnClick, self)
end

function NationalGiftBuyTipView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
	self._btnClose:RemoveClickListener()
end

function NationalGiftBuyTipView:_btnclickOnClick()
	local desc = CommonConfig.instance:getConstStr(ConstEnum.NationalGiftDesc)

	HelpController.instance:openStoreTipView(desc)
end

function NationalGiftBuyTipView:_btnBuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local packageStoreId = NationalGiftModel.instance:getNationalGiftStoreId()

	PayController.instance:startPay(packageStoreId)
end

function NationalGiftBuyTipView:_btnCloseOnClick()
	self:closeThis()
end

function NationalGiftBuyTipView:_editableInitView()
	self._bonusItems = {}
end

function NationalGiftBuyTipView:_addSelfEvents()
	self.addEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, self._refresh, self)
	self.addEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, self._refresh, self)
	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._onBonusPush, self)
end

function NationalGiftBuyTipView:_removeSelfEvents()
	self.removeEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, self._refresh, self)
	self.removeEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, self._refresh, self)
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._onBonusPush, self)
end

function NationalGiftBuyTipView:onOpen()
	self:_addSelfEvents()
	self:_initView()
	self:_refresh()

	if self.viewParam then
		if self.viewParam then
			StoreController.instance:statOpenChargeGoods(self.viewParam.belongStoreId, self.viewParam.config)
		end
	end
end

function NationalGiftBuyTipView:_initView()
	local packageStoreId = NationalGiftModel.instance:getNationalGiftStoreId()

	self._txtPrice.text = PayModel.instance:getProductPrice(packageStoreId)

	AudioMgr.instance:trigger(AudioEnum3_1.NationalGift.play_ui_leimi_souvenir_open)
end

function NationalGiftBuyTipView:_onBonusPush()
	self.addEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCall, self)
end

function NationalGiftBuyTipView:_onCloseViewCall(viewName)
	if viewName == ViewName.CommonPropView then
		self.removeEventCb(self, ViewMgr.instance, ViewEvent.OnCloseView, self._onCloseViewCall, self)
		GameFacade.showMessageBox(MessageBoxIdDefine.NationalGiftJumpTip, MsgBoxEnum.BoxType.Yes_No, self._onYesCallback, self._onNoCallback, nil, self, self)
	end
end

function NationalGiftBuyTipView:_onYesCallback()
	ViewMgr.instance:closeView(ViewName.StoreView)

	local jumpParam = string.format("%s#%s", JumpEnum.JumpView.ActivityView, NationalGiftModel.instance:getCurVersionActId())

	JumpController.instance:jumpByParam(jumpParam)
	self:closeThis()
end

function NationalGiftBuyTipView:_onNoCallback()
	self:closeThis()
end

function NationalGiftBuyTipView:_refresh()
	self:_checkAutoGetReward()
	self:_refreshUI()
	self:_refreshTime()
	self:_refreshBonusItems()
end

function NationalGiftBuyTipView:_checkAutoGetReward()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if not isGiftHasBuy then
		return
	end

	local isCouldGet = NationalGiftModel.instance:isBonusCouldGet(1)

	if not isCouldGet then
		return
	end

	Activity212Rpc.instance:sendAct212ReceiveBonusRequest(NationalGiftModel.instance:getCurVersionActId(), 1)
end

function NationalGiftBuyTipView:_refreshUI()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	gohelper.setActive(self._btnBuy.gameObject, not isGiftHasBuy)
	gohelper.setActive(self._gotip, not isGiftHasBuy)
end

function NationalGiftBuyTipView:_refreshTime()
	local isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()
	local nowTime = ServerTime.now()

	if not isGiftHasBuy then
		local endTime = NationalGiftModel.instance:getBuyEndTime()

		if endTime <= nowTime then
			gohelper.setActive(self._gotime, false)

			return
		end

		local dataStr = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)

		self._txtlimit.text = luaLang("buy_limit_time")
		self._txttime.text = dataStr
	else
		local endTime = NationalGiftModel.instance:getBonusEndTime()

		if endTime <= nowTime then
			gohelper.setActive(self._gotime, false)

			return
		end

		local dataStr = TimeUtil.SecondToActivityTimeFormat(endTime - nowTime)

		self._txtlimit.text = luaLang("receive_limit_time")
		self._txttime.text = dataStr
	end
end

function NationalGiftBuyTipView:_refreshBonusItems()
	local bonusCos = NationalGiftConfig.instance:getBonusCos()

	for _, bonusCo in ipairs(bonusCos) do
		if not self._bonusItems[bonusCo.id] then
			self._bonusItems[bonusCo.id] = NationalGiftBuyTipBonusItem.New()

			local go = gohelper.cloneInPlace(self._gobonusitem)

			self._bonusItems[bonusCo.id]:init(go, bonusCo)
		end

		self._bonusItems[bonusCo.id]:refresh()
	end
end

function NationalGiftBuyTipView:onClose()
	self:_removeSelfEvents()

	if self._bonusItems then
		for _, item in ipairs(self._bonusItems) do
			item:destroy()
		end

		self._bonusItems = nil
	end
end

function NationalGiftBuyTipView:onDestroyView()
	return
end

return NationalGiftBuyTipView
