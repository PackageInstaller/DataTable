-- chunkname: @modules/logic/currency/view/PowerBuyTipView.lua

module("modules.logic.currency.view.PowerBuyTipView", package.seeall)

local PowerBuyTipView = class("PowerBuyTipView", BaseView)

function PowerBuyTipView:onInitView()
	self._btntouchClose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_touchClose")
	self._simagetipbg = gohelper.findChildSingleImage(self.viewGO, "#simage_tipbg")
	self._txtbuytip = gohelper.findChildText(self.viewGO, "centerTip/#txt_buytip")
	self._txtremaincount = gohelper.findChildText(self.viewGO, "centerTip/#txt_remaincount")
	self._toggletip = gohelper.findChildToggle(self.viewGO, "centerTip/#toggle_tip")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PowerBuyTipView:addEvents()
	self._btntouchClose:AddClickListener(self._btntouchCloseOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._toggletip:AddOnValueChanged(self._toggleTipOnClick, self)
end

function PowerBuyTipView:removeEvents()
	self._btntouchClose:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._toggletip:RemoveOnValueChanged()
end

function PowerBuyTipView:_btntouchCloseOnClick()
	self:closeThis()
end

function PowerBuyTipView:_btncloseOnClick()
	self:closeThis()
end

function PowerBuyTipView:_btnbuyOnClick()
	if self._buyDiamondStep > 0 then
		if self._buyDiamondStep == 1 then
			if self:_checkExchangeFreeDiamond(self.deltaDiamond) then
				self:closeThis()
			end
		else
			StoreController.instance:checkAndOpenStoreView(StoreEnum.ChargeStoreTabId)
			ViewMgr.instance:closeView(ViewName.PowerView)
			self:closeThis()
		end
	else
		local isTipOn = self._toggletip.isOn

		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuyTipToggleOn, isTipOn)

		self.addPowerSuccess = true

		if self.buyinfo.isPowerPotion then
			ItemRpc.instance:sendUsePowerItemRequest(self.buyinfo.uid)
		elseif self:_checkFreeDiamondEnough(self._costParam[3]) then
			CurrencyRpc.instance:sendBuyPowerRequest()
		else
			self.addPowerSuccess = false
		end

		if self.addPowerSuccess then
			CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
			self:closeThis()
		end
	end
end

function PowerBuyTipView:_ExchangeFreeDiamondCallBack(cmd, resultCode, msg)
	if resultCode == 0 then
		CurrencyRpc.instance:sendBuyPowerRequest()
		CurrencyController.instance:dispatchEvent(CurrencyEvent.PowerBuySuccess)
	end
end

function PowerBuyTipView:_checkExchangeFreeDiamond(needDiamond)
	local payDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Diamond)

	if payDiamondMo then
		if needDiamond <= payDiamondMo.quantity then
			CurrencyRpc.instance:sendExchangeDiamondRequest(needDiamond, CurrencyEnum.PayDiamondExchangeSource.Power, self._ExchangeFreeDiamondCallBack, self)

			return true
		else
			self._buyDiamondStep = 2
			self._txtbuytip.text = MessageBoxConfig.instance:getMessage(MessageBoxIdDefine.PayDiamondNotEnough)

			return false
		end
	else
		logError("can't find payDiamond MO")

		return true
	end
end

function PowerBuyTipView:_checkFreeDiamondEnough(needDiamond)
	local freeDiamondMo = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.FreeDiamondCoupon)

	if freeDiamondMo then
		if needDiamond <= freeDiamondMo.quantity then
			return true
		else
			self.deltaDiamond = needDiamond - freeDiamondMo.quantity
			self._txtbuytip.text = string.format(luaLang("powerbuy_tip_2"), self.deltaDiamond)

			gohelper.setActive(self._txtremaincount.gameObject, false)

			self._buyDiamondStep = 1

			return false
		end
	else
		logError("can't find freeDiamond MO")

		return false
	end
end

function PowerBuyTipView:_toggleTipOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)
end

function PowerBuyTipView:_editableInitView()
	self._toggletip.isOn = false

	self._simagetipbg:LoadImage(ResUrl.getMessageIcon("bg_tanchuang"))
end

function PowerBuyTipView:onUpdateParam()
	return
end

function PowerBuyTipView:onOpen()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	self.buyinfo = self.viewParam

	local isPowerPotion = self.buyinfo.isPowerPotion

	gohelper.setActive(self._txtremaincount.gameObject, not isPowerPotion)
	gohelper.setActive(self._toggletip.gameObject, isPowerPotion)
	self:refreshCenterTip()

	self.addPowerSuccess = false
	self._buyDiamondStep = 0

	NavigateMgr.instance:addEscape(self.viewName, self._btncloseOnClick, self)
end

function PowerBuyTipView:refreshCenterTip()
	if not self.buyinfo.isPowerPotion then
		local buyCostStr = CommonConfig.instance:getConstStr(ConstEnum.PowerBuyCostId)

		self._powerMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.PowerMaxBuyCountId)
		self._costParamList = GameUtil.splitString2(buyCostStr, true)
		self._costParam = self._costParamList[self._powerMaxBuyCount - CurrencyModel.instance.powerCanBuyCount + 1]

		if self._costParam == nil then
			self._costParam = self._costParamList[#self._costParamList]
		end

		local level = PlayerModel.instance:getPlayinfo().level
		local addBuyRecoverPower = PlayerConfig.instance:getPlayerLevelCO(level).addBuyRecoverPower
		local config = ItemModel.instance:getItemConfig(self._costParam[1], self._costParam[2])
		local tag = {
			self._costParam[3],
			config.name,
			addBuyRecoverPower
		}
		local tip = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), tag)

		self._txtbuytip.text = string.format("%s（%s）", tip, string.format(luaLang("powerbuy_remaincount"), CurrencyModel.instance.powerCanBuyCount))
		self._txtremaincount.text = luaLang("powerbuy_tip_3")
	elseif self.buyinfo.type == MaterialEnum.PowerType.Small then
		local tag = {
			"",
			luaLang("power_item1_name"),
			60
		}

		self._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), tag)
	elseif self.buyinfo.type == MaterialEnum.PowerType.Big then
		local tag = {
			"",
			luaLang("power_item2_name"),
			120
		}

		self._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), tag)
	else
		local powerMo = ItemPowerModel.instance:getPowerByType(self.buyinfo.type)

		if powerMo then
			local powerConfig = ItemConfig.instance:getPowerItemCo(powerMo.id)

			if powerConfig then
				local tag = {
					"",
					powerConfig.name,
					powerConfig.effect
				}

				self._txtbuytip.text = GameUtil.getSubPlaceholderLuaLang(luaLang("powerbuy_tip"), tag)
			end
		end
	end
end

function PowerBuyTipView:onClose()
	if self.addPowerSuccess then
		return
	end
end

function PowerBuyTipView:onDestroyView()
	self._simagetipbg:UnLoadImage()
end

return PowerBuyTipView
