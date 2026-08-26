-- chunkname: @modules/logic/versionactivity3_1/nationalgift/view/NationalGiftFullView.lua

module("modules.logic.versionactivity3_1.nationalgift.view.NationalGiftFullView", package.seeall)

local NationalGiftFullView = class("NationalGiftFullView", BaseView)

function NationalGiftFullView:onInitView()
	self._gotip = gohelper.findChild(self.viewGO, "txt_tips")
	self._gotime = gohelper.findChild(self.viewGO, "#go_time")
	self._txtlimit = gohelper.findChildText(self.viewGO, "#go_time/txt_limit")
	self._txttime = gohelper.findChildText(self.viewGO, "#go_time/#txt_time")
	self._btntips = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_tips")
	self._gonode1 = gohelper.findChild(self.viewGO, "content/#go_node1")
	self._gonode2 = gohelper.findChild(self.viewGO, "content/#go_node2")
	self._gonode3 = gohelper.findChild(self.viewGO, "content/#go_node3")
	self._gonode4 = gohelper.findChild(self.viewGO, "content/#go_node4")
	self._gonode5 = gohelper.findChild(self.viewGO, "content/#go_node5")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_Buy")
	self._txtPrice = gohelper.findChildText(self.viewGO, "#btn_Buy/#txt_Price")
	self._gohasbuy = gohelper.findChild(self.viewGO, "#go_hasbuy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NationalGiftFullView:addEvents()
	self._btntips:AddClickListener(self._btntipsOnClick, self)
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
end

function NationalGiftFullView:removeEvents()
	self._btntips:RemoveClickListener()
	self._btnBuy:RemoveClickListener()
end

function NationalGiftFullView:_btntipsOnClick()
	local desc = CommonConfig.instance:getConstStr(ConstEnum.NationalGiftDesc)

	HelpController.instance:openStoreTipView(desc)
end

function NationalGiftFullView:_btnBuyOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	local packageStoreId = NationalGiftModel.instance:getNationalGiftStoreId()

	PayController.instance:startPay(packageStoreId)
end

function NationalGiftFullView:_buyCallback(cmd, resultCode, msg)
	if resultCode ~= 0 then
		return
	end

	self:_refresh()
end

function NationalGiftFullView:_editableInitView()
	self._anim = self._gonode1:GetComponent(typeof(UnityEngine.Animator))
end

function NationalGiftFullView:_addSelfEvents()
	self.addEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, self._refresh, self)
	self.addEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, self._refresh, self)
	self.addEventCb(self, NationalGiftController.instance, NationalGiftEvent.OnAct212BonusUpdate, self._onBonusUpdate, self)
end

function NationalGiftFullView:_removeSelfEvents()
	self.removeEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoGet, self._refresh, self)
	self.removeEventCb(self, NationalGiftController.instance, NationalGiftEvent.onAct212InfoUpdate, self._refresh, self)
	self.removeEventCb(self, NationalGiftController.instance, NationalGiftEvent.OnAct212BonusUpdate, self._onBonusUpdate, self)
end

function NationalGiftFullView:_onBonusUpdate()
	local hasBuy = NationalGiftModel.instance:isGiftHasBuy()

	if not self._isGiftHasBuy and hasBuy then
		self._anim:Play("buy", 0, 0)
		gohelper.setActive(self._gohasbuy, true)
	end

	self:_refresh()
end

function NationalGiftFullView:onOpen()
	local parentGO = self.viewParam.parent

	gohelper.addChild(parentGO, self.viewGO)

	self._actId = VersionActivity3_1Enum.ActivityId.SurvivalOperAct
	self._bonusItems = {}

	self:_addSelfEvents()
	self:_initView()
	self:_refresh()
end

function NationalGiftFullView:_initView()
	local packageStoreId = NationalGiftModel.instance:getNationalGiftStoreId()

	self._txtPrice.text = PayModel.instance:getProductPrice(packageStoreId)

	AudioMgr.instance:trigger(AudioEnum3_1.NationalGift.play_ui_mln_page_turn)
end

function NationalGiftFullView:_refresh()
	self._isGiftHasBuy = NationalGiftModel.instance:isGiftHasBuy()

	self:_refreshUI()
	self:_refreshTime()
	self:_refreshBonusItems()
end

function NationalGiftFullView:_refreshUI()
	gohelper.setActive(self._btnBuy.gameObject, not self._isGiftHasBuy)
	gohelper.setActive(self._gotip, not self._isGiftHasBuy)
	gohelper.setActive(self._gohasbuy, self._isGiftHasBuy)
end

function NationalGiftFullView:_refreshTime()
	local nowTime = ServerTime.now()

	if not self._isGiftHasBuy then
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

function NationalGiftFullView:_refreshBonusItems()
	local bonusCos = NationalGiftConfig.instance:getBonusCos()

	for _, bonusCo in ipairs(bonusCos) do
		if not self._bonusItems[bonusCo.id] then
			self._bonusItems[bonusCo.id] = NationalGiftFullBonusItem.New()

			self._bonusItems[bonusCo.id]:init(self["_gonode" .. tostring(bonusCo.id)], bonusCo)
		end

		self._bonusItems[bonusCo.id]:refresh()
	end
end

function NationalGiftFullView:onClose()
	self:_removeSelfEvents()

	if self._bonusItems then
		for _, item in pairs(self._bonusItems) do
			item:destroy()
		end

		self._bonusItems = nil
	end
end

function NationalGiftFullView:onDestroyView()
	return
end

return NationalGiftFullView
