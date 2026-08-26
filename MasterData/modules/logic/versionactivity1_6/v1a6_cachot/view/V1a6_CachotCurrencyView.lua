-- chunkname: @modules/logic/versionactivity1_6/v1a6_cachot/view/V1a6_CachotCurrencyView.lua

module("modules.logic.versionactivity1_6.v1a6_cachot.view.V1a6_CachotCurrencyView", package.seeall)

local V1a6_CachotCurrencyView = class("V1a6_CachotCurrencyView", BaseView)

function V1a6_CachotCurrencyView:ctor(rootPath)
	self._rootPath = rootPath

	V1a6_CachotCurrencyView.super.ctor(self)
end

function V1a6_CachotCurrencyView:onInitView()
	self._rootGo = gohelper.findChild(self.viewGO, self._rootPath or "")
	self._txtcoin = gohelper.findChildText(self._rootGo, "#go_shop/#txt_num2")
	self._slidercurrency = gohelper.findChildSlider(self._rootGo, "#go_hope/bg/#slider_progress")
	self._txtcurrency = gohelper.findChildTextMesh(self._rootGo, "#go_hope/#txt_num2")
	self._txtcurrencytotal = gohelper.findChildTextMesh(self._rootGo, "#go_hope/#txt_num1")
	self._btnClickCurrency = gohelper.findChildButtonWithAudio(self._rootGo, "#go_hope/#btn_click")
	self._btnClickCoin = gohelper.findChildButtonWithAudio(self._rootGo, "#go_shop/#btn_click")
	self._goeffectcoinadd = gohelper.findChild(self._rootGo, "#go_shop/vx_vitality")
	self._goeffectcurrencyadd = gohelper.findChild(self._rootGo, "#go_hope/vx_vitality")
end

function V1a6_CachotCurrencyView:addEvents()
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self.updateCurrency, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCoin, self.updateCurrency, self)
	V1a6_CachotController.instance:registerCallback(V1a6_CachotEvent.OnUpdateCurrency, self.updateCurrency, self)

	if self._btnClickCurrency then
		self._btnClickCurrency:AddClickListener(self._clickCurrency, self)
	end

	if self._btnClickCoin then
		self._btnClickCoin:AddClickListener(self._clickCoin, self)
	end
end

function V1a6_CachotCurrencyView:removeEvents()
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateRogueInfo, self.updateCurrency, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCoin, self.updateCurrency, self)
	V1a6_CachotController.instance:unregisterCallback(V1a6_CachotEvent.OnUpdateCurrency, self.updateCurrency, self)

	if self._btnClickCurrency then
		self._btnClickCurrency:RemoveClickListener()
	end

	if self._btnClickCoin then
		self._btnClickCoin:RemoveClickListener()
	end
end

function V1a6_CachotCurrencyView:onOpen()
	self:hideEffect()
	self:updateCurrency()
end

function V1a6_CachotCurrencyView:_clickCurrency()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCurrency, false, nil, false)
end

function V1a6_CachotCurrencyView:_clickCoin()
	MaterialTipController.instance:showMaterialInfo(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.V1a6CachotCoin, false, nil, false)
end

function V1a6_CachotCurrencyView:updateCurrency()
	self._rogueInfo = V1a6_CachotModel.instance:getRogueInfo()
	self._txtcoin.text = self._rogueInfo.coin
	self._txtcurrency.text = math.min(self._rogueInfo.currency, self._rogueInfo.currencyTotal)
	self._txtcurrencytotal.text = self._rogueInfo.currencyTotal

	local isAdd = false

	if self._cacheCoin then
		if self._cacheCoin < self._rogueInfo.coin then
			gohelper.setActive(self._goeffectcoinadd, true)

			isAdd = true
		end

		if self._cacheCurrency < self._rogueInfo.currency then
			gohelper.setActive(self._goeffectcurrencyadd, true)

			isAdd = true
		end
	end

	self._cacheCoin = self._rogueInfo.coin
	self._cacheCurrency = self._rogueInfo.currency

	if self._rogueInfo.currencyTotal == 0 then
		self._slidercurrency:SetValue(0)
	else
		self._slidercurrency:SetValue(self._rogueInfo.currency / self._rogueInfo.currencyTotal)
	end

	if isAdd then
		TaskDispatcher.cancelTask(self.hideEffect, self)
		TaskDispatcher.runDelay(self.hideEffect, self, 2)
	end
end

function V1a6_CachotCurrencyView:hideEffect()
	gohelper.setActive(self._goeffectcoinadd, false)
	gohelper.setActive(self._goeffectcurrencyadd, false)
end

function V1a6_CachotCurrencyView:onClose()
	TaskDispatcher.cancelTask(self.hideEffect, self)
end

return V1a6_CachotCurrencyView
