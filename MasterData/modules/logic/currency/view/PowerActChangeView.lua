-- chunkname: @modules/logic/currency/view/PowerActChangeView.lua

module("modules.logic.currency.view.PowerActChangeView", package.seeall)

local PowerActChangeView = class("PowerActChangeView", BaseView)

function PowerActChangeView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_leftbg")
	self._txtleftproductname = gohelper.findChildText(self.viewGO, "left/#txt_leftproductname")
	self._simageleftproduct = gohelper.findChildSingleImage(self.viewGO, "left/leftproduct_icon")
	self._txtrightproductname = gohelper.findChildText(self.viewGO, "right/#txt_rightproductname")
	self._gobuy = gohelper.findChild(self.viewGO, "#go_buy")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_buy/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_buy")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "#go_buy/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "#go_buy/cost/#txt_originalCost")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function PowerActChangeView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function PowerActChangeView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function PowerActChangeView:_btnminOnClick()
	self:changeUseCount(1)
end

function PowerActChangeView:_btnsubOnClick()
	if self.buyCount < 2 then
		return
	end

	self:changeUseCount(self.buyCount - 1)
end

function PowerActChangeView:_btnaddOnClick()
	if self.buyCount >= self.maxBuyCount then
		return
	end

	self:changeUseCount(self.buyCount + 1)
end

function PowerActChangeView:_btnmaxOnClick()
	self:changeUseCount(self.maxBuyCount)
end

function PowerActChangeView:_btnbuyOnClick()
	local list = ItemPowerModel.instance:getUsePower(self._powerId, self.buyCount)

	ItemRpc.instance:sendUsePowerItemListRequest(list)
	BackpackController.instance:dispatchEvent(BackpackEvent.BeforeUsePowerPotionList)

	if self._powerId == MaterialEnum.PowerId.OverflowPowerId then
		ItemRpc.instance:sendGetPowerMakerInfoRequest()
	end
end

function PowerActChangeView:changeUseCount(count)
	self._inputvalue:SetText(count)

	if count == self.buyCount then
		return
	end

	self.buyCount = count

	self:refreshUI()
end

function PowerActChangeView:_btncloseOnClick()
	self:closeThis()
end

function PowerActChangeView:onClickBg()
	self:closeThis()
end

function PowerActChangeView:onCountValueChange(value)
	local count = tonumber(value)

	if not count then
		return
	end

	if count < 1 then
		count = 1
	end

	if count > self.maxBuyCount then
		count = self.maxBuyCount
	end

	self:changeUseCount(count)
end

function PowerActChangeView:_editableInitView()
	self.bgClick = gohelper.findChildClickWithDefaultAudio(self.viewGO, "Mask")

	self.bgClick:AddClickListener(self.onClickBg, self)
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._inputvalue:AddOnValueChanged(self.onCountValueChange, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.onCurrencyChange, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshActivityState, self.onRefreshActivity, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UsePowerPotionListFinish, self._onUsePowerPotionListFinish, self)
	NavigateMgr.instance:addEscape(self.viewName, self.closeThis, self)
end

function PowerActChangeView:onOpen()
	if self.viewParam then
		self._powerId = self.viewParam.PowerId or MaterialEnum.PowerId.ActPowerId
	end

	self.actPowerConfig = ItemConfig.instance:getPowerItemCo(self._powerId)
	self.powerConfig = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power)
	self.currencyMO = CurrencyModel.instance:getCurrency(CurrencyEnum.CurrencyType.Power)
	self.oneActPowerEffect = self.actPowerConfig.effect

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, self._powerId .. "_1")
	self._simageleftproduct:LoadImage(ResUrl.getPropItemIcon(self.actPowerConfig.icon))

	self.buyCount = 1

	self:updateMaxBuyCount()
	self._inputvalue:SetText(self.buyCount)
	self:refreshUI()
end

function PowerActChangeView:updateMaxBuyCount()
	local maxPower = CurrencyConfig.instance:getCurrencyCo(CurrencyEnum.CurrencyType.Power).maxLimit
	local currentPower = self.currencyMO.quantity
	local offsetPower = maxPower - currentPower
	local maxUseCount = math.floor(offsetPower / self.oneActPowerEffect)

	self.maxBuyCount = math.min(maxUseCount, ItemPowerModel.instance:getPowerCount(self._powerId))
end

function PowerActChangeView:refreshUI()
	self:refreshLeftItem()
	self:refreshRightItem()
	self:showOriginalCostTxt(self.buyCount, self.maxBuyCount)
end

function PowerActChangeView:refreshLeftItem()
	self._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		self.actPowerConfig.name,
		self.buyCount
	})
end

function PowerActChangeView:refreshRightItem()
	self._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLang(luaLang("poweractchangeview_productNameFormat"), {
		self.powerConfig.name,
		self.buyCount * self.oneActPowerEffect
	})
end

function PowerActChangeView:onCurrencyChange(changeIds)
	if changeIds and not changeIds[CurrencyEnum.CurrencyType.Power] then
		return
	end

	self:updateMaxBuyCount()
	self:showOriginalCostTxt(self.buyCount, self.maxBuyCount)

	if self.buyCount > self.maxBuyCount then
		self:changeUseCount(self.maxBuyCount)
	end
end

function PowerActChangeView:showOriginalCostTxt(buyCount, maxBuyCount)
	self._txtoriginalCost.text = string.format("<color=#ab4211>%s</color><color=#494440>/%s</color>", buyCount, maxBuyCount)
end

function PowerActChangeView:onRefreshActivity(actId)
	if actId ~= MaterialEnum.ActPowerBindActId then
		return
	end

	local activityStatus = ActivityHelper.getActivityStatus(actId)
	local count = ItemPowerModel.instance:getPowerCount(self._powerId)

	if activityStatus ~= ActivityEnum.ActivityStatus.Normal then
		if count < 1 then
			self:closeThis()

			return
		end

		local limitSec = ItemPowerModel.instance:getPowerMinExpireTimeOffset(self._powerId)

		if limitSec <= 0 then
			self:closeThis()
		end
	end
end

function PowerActChangeView:_onUsePowerPotionListFinish()
	self:closeThis()
end

function PowerActChangeView:onClose()
	self.bgClick:RemoveClickListener()
end

function PowerActChangeView:onDestroyView()
	self._simagerightbg:UnLoadImage()
	self._simageleftbg:UnLoadImage()
	self._simageleftproduct:UnLoadImage()
	self._inputvalue:RemoveOnValueChanged()
end

return PowerActChangeView
