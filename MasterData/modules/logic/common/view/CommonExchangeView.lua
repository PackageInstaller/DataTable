-- chunkname: @modules/logic/common/view/CommonExchangeView.lua

module("modules.logic.common.view.CommonExchangeView", package.seeall)

local CommonExchangeView = class("CommonExchangeView", BaseView)
local DEFAULT_COLOR = "#E7E4E4"
local NOT_ENOUGH_COLOR = "#FF0000"
local MIN_EXCHANGE_TIMES = 1

function CommonExchangeView:onInitView()
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_leftbg")
	self._txtleftproductname = gohelper.findChildText(self.viewGO, "left/#txt_leftproductname")
	self._simageleftproduct = gohelper.findChildSingleImage(self.viewGO, "left/#simage_leftproduct")
	self._txtrightproductname = gohelper.findChildText(self.viewGO, "right/#txt_rightproductname")
	self._simagerightproduct = gohelper.findChildSingleImage(self.viewGO, "right/#simage_rightproduct")
	self._gobuy = gohelper.findChild(self.viewGO, "#go_buy")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_buy/valuebg/#input_value")
	self._inputText = self._inputvalue.inputField.textComponent
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_buy")
	self._gobuylimit = gohelper.findChild(self.viewGO, "#go_buy/#go_buylimit")
	self._gocost = gohelper.findChild(self.viewGO, "#go_buy/cost")
	self._simagecosticon = gohelper.findChildImage(self.viewGO, "#go_buy/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "#go_buy/cost/#txt_originalCost")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CommonExchangeView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._inputvalue:AddOnValueChanged(self._onInputChangeExchangeTimesValue, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
end

function CommonExchangeView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._inputvalue:RemoveOnValueChanged()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._onCurrencyChange, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._onItemChanged, self)
end

function CommonExchangeView:_btnminOnClick()
	self:changeExchangeTimes(MIN_EXCHANGE_TIMES)
end

function CommonExchangeView:_btnsubOnClick()
	self:changeExchangeTimes(self.exchangeTimes - 1)
end

function CommonExchangeView:_btnaddOnClick()
	self:changeExchangeTimes(self.exchangeTimes + 1)
end

function CommonExchangeView:_btnmaxOnClick()
	local maxCanExchangeTimes = self:getMaxExchangeTimes()

	self:changeExchangeTimes(maxCanExchangeTimes)
end

function CommonExchangeView:_onInputChangeExchangeTimesValue(value)
	local times = tonumber(value)

	if not times then
		return
	end

	self:changeExchangeTimes(times)
end

function CommonExchangeView:_btnbuyOnClick()
	if not self._exchangeFunc then
		logError("CommonExchangeView._btnbuyOnClick error, no _exchangeFunc")

		return
	end

	self._exchangeFunc(self._exchangeFuncObj, self.exchangeTimes, self._afterExchange, self)
end

function CommonExchangeView:_afterExchange(cmd, resultCode, msg)
	if resultCode and resultCode ~= 0 then
		return
	end

	self:_btncloseOnClick()
end

function CommonExchangeView:_btncloseOnClick()
	self:closeThis()
end

function CommonExchangeView:onClickModalMask()
	self:_btncloseOnClick()
end

function CommonExchangeView:_onCurrencyChange(changeIds)
	if self.costMatData then
		local costIsCurrency = self.costMatData.materilType == MaterialEnum.MaterialType.Currency

		if self.targetMatData then
			local targetIsCurrency = self.targetMatData.materilType == MaterialEnum.MaterialType.Currency

			if costIsCurrency or targetIsCurrency then
				self:refreshUI()
			end
		end
	end
end

function CommonExchangeView:_onItemChanged()
	self:refreshUI()
end

function CommonExchangeView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
end

function CommonExchangeView:onUpdateParam()
	self.costMatData = self.viewParam.costMatData
	self.targetMatData = self.viewParam.targetMatData
	self._exchangeFunc = self.viewParam.exchangeFunc
	self._exchangeFuncObj = self.viewParam.exchangeFuncObj
	self._getMaxTimeFunc = self.viewParam.getMaxTimeFunc
	self._getMaxTimeFuncObj = self.viewParam.getMaxTimeFuncObj
	self._getExchangeNumFunc = self.viewParam.getExchangeNumFunc
	self._getExchangeNumFuncObj = self.viewParam.getExchangeNumFuncObj
end

function CommonExchangeView:onOpen()
	self:onUpdateParam()

	local costItemCfg, costItemIcon = ItemModel.instance:getItemConfigAndIcon(self.costMatData.materilType, self.costMatData.materilId, true)
	local targetItemCfg, targetItemIcon = ItemModel.instance:getItemConfigAndIcon(self.targetMatData.materilType, self.targetMatData.materilId, true)

	self._simageleftproduct:LoadImage(costItemIcon)
	self._simagerightproduct:LoadImage(targetItemIcon)

	local isCostCurrency = self.costMatData.materilType == MaterialEnum.MaterialType.Currency

	if isCostCurrency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagecosticon, costItemCfg.icon .. "_1", true)
	end

	gohelper.setActive(self._gocost, isCostCurrency)

	self.costItemCfg = costItemCfg
	self.targetItemCfg = targetItemCfg

	self:_btnminOnClick()
end

function CommonExchangeView:changeExchangeTimes(exchangeTimes, isNotify)
	local _, maxLimit = self:getMaxExchangeTimes()

	self.exchangeTimes = Mathf.Clamp(exchangeTimes, MIN_EXCHANGE_TIMES, maxLimit)

	if isNotify then
		self._inputvalue:SetText(tostring(self.exchangeTimes))
	else
		self._inputvalue:SetTextWithoutNotify(tostring(self.exchangeTimes))
	end

	self:refreshUI()
end

function CommonExchangeView:getMaxExchangeTimes()
	local maxCanExchangeTimes, maxLimit

	if self._getMaxTimeFunc then
		maxCanExchangeTimes, maxLimit = self._getMaxTimeFunc(self._getMaxTimeFuncObj)
	end

	maxCanExchangeTimes = Mathf.Max(MIN_EXCHANGE_TIMES, maxCanExchangeTimes or MIN_EXCHANGE_TIMES)
	maxLimit = Mathf.Max(MIN_EXCHANGE_TIMES, maxLimit or maxCanExchangeTimes)

	return maxCanExchangeTimes, maxLimit
end

function CommonExchangeView:refreshUI()
	local costNum = self.exchangeTimes * ((not self.costMatData.quantity or nil) and 0)
	local targetNum = self.exchangeTimes * ((not self.targetMatData.quantity or nil) and 0)

	if self._getExchangeNumFunc then
		costNum, targetNum = self._getExchangeNumFunc(self._getExchangeNumFuncObj, self.exchangeTimes)
	end

	local hasNum = ItemModel.instance:getItemQuantity(self.costMatData.materilType, self.costMatData.materilId)
	local isEnough = costNum <= hasNum

	UIColorHelper.set(self._inputText, (isEnough or nil) and (DEFAULT_COLOR or NOT_ENOUGH_COLOR))

	if self.costItemCfg then
		self._txtleftproductname.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), self.costItemCfg.name, costNum)
	end

	self._txtoriginalCost.text = costNum

	if self.targetItemCfg then
		self._txtrightproductname.text = GameUtil.getSubPlaceholderLuaLangTwoParam(luaLang("multiple_2"), self.targetItemCfg.name, targetNum)
	end

	local hasExchangeTimes = self.exchangeTimes > 0

	gohelper.setActive(self._btnbuy, hasExchangeTimes and isEnough)
	gohelper.setActive(self._gobuylimit, not hasExchangeTimes or not isEnough)
end

function CommonExchangeView:onClose()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageleftproduct:UnLoadImage()
	self._simagerightproduct:UnLoadImage()
end

return CommonExchangeView
