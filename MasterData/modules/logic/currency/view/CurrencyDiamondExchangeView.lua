-- chunkname: @modules/logic/currency/view/CurrencyDiamondExchangeView.lua

module("modules.logic.currency.view.CurrencyDiamondExchangeView", package.seeall)

local CurrencyDiamondExchangeView = class("CurrencyDiamondExchangeView", BaseView)

function CurrencyDiamondExchangeView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "decorate/#simage_rightbg")
	self._txtleftproductname = gohelper.findChildText(self.viewGO, "left/#txt_leftproductname")
	self._simageleftproduct = gohelper.findChildSingleImage(self.viewGO, "left/#simage_leftproduct")
	self._txtrightproductname = gohelper.findChildText(self.viewGO, "right/#txt_rightproductname")
	self._simagerightproduct = gohelper.findChildSingleImage(self.viewGO, "right/#simage_rightproduct")
	self._gobuy = gohelper.findChild(self.viewGO, "#go_buy")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "#go_buy/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "#go_buy/#btn_buy")
	self._gobuylimit = gohelper.findChild(self.viewGO, "#go_buy/#go_buylimit")
	self._simagecosticon = gohelper.findChildImage(self.viewGO, "#go_buy/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "#go_buy/cost/#txt_originalCost")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function CurrencyDiamondExchangeView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
end

function CurrencyDiamondExchangeView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
end

function CurrencyDiamondExchangeView:_btncloseOnClick()
	self:closeThis()
end

CurrencyDiamondExchangeView.ClickStep = 1
CurrencyDiamondExchangeView.MinAmount = 0

function CurrencyDiamondExchangeView:_editableInitView()
	self._currenctAmount = CurrencyDiamondExchangeView.MinAmount

	local currencyType = MaterialEnum.MaterialType.Currency
	local currencyId = CurrencyEnum.CurrencyType.Diamond
	local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(currencyType, currencyId, true)

	self._txtleftproductname.text = string.format("%s %s1", itemConfig.name, luaLang("multiple"))
	currencyId = CurrencyEnum.CurrencyType.FreeDiamondCoupon
	itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(currencyType, CurrencyEnum.CurrencyType.FreeDiamondCoupon, true)
	self._txtrightproductname.text = string.format("%s %s1", itemConfig.name, luaLang("multiple"))

	self._inputvalue:AddOnEndEdit(self._onInputNameEndEdit, self)

	self._inputText = self._inputvalue.inputField.textComponent
	self._colorDefault = Color.New(0.9058824, 0.8941177, 0.8941177, 1)

	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))
	self._simageleftproduct:LoadImage(ResUrl.getCurrencyItemIcon("201"))
	self._simagerightproduct:LoadImage(ResUrl.getCurrencyItemIcon("202"))
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._simagecosticon, "201_1")
end

function CurrencyDiamondExchangeView:onDestroyView()
	self._inputvalue:RemoveOnEndEdit()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageleftproduct:UnLoadImage()
	self._simagerightproduct:UnLoadImage()
end

function CurrencyDiamondExchangeView:onUpdateParam()
	self:onOpen()
end

function CurrencyDiamondExchangeView:onOpen()
	self._currenctAmount = 1

	self:refreshAmount()
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshAmount, self)
end

function CurrencyDiamondExchangeView:onClose()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshAmount, self)
end

function CurrencyDiamondExchangeView:refreshAmount()
	self:checkCurrenctAmount()

	local strAmount = tostring(self._currenctAmount)
	local enough = self:getOwnAmount() >= self._currenctAmount

	if not enough then
		self._inputText.color = Color.red
	end

	self._inputvalue:SetText(strAmount)

	self._txtoriginalCost.text = strAmount

	gohelper.setActive(self._btnbuy.gameObject, self._currenctAmount > 0)
	gohelper.setActive(self._gobuylimit, self._currenctAmount <= 0)
end

function CurrencyDiamondExchangeView:_onInputNameEndEdit()
	self._currenctAmount = tonumber(self._inputvalue:GetText())

	self:refreshAmount()
end

function CurrencyDiamondExchangeView:_btnminOnClick()
	local ownQuantity = self:getOwnAmount()

	self._currenctAmount = ownQuantity <= 0 and 0 or 1

	self:refreshAmount()
end

function CurrencyDiamondExchangeView:_btnmaxOnClick()
	self._currenctAmount = self:getOwnAmount()

	self:refreshAmount()
end

function CurrencyDiamondExchangeView:_btnsubOnClick()
	if self._currenctAmount ~= nil then
		self._currenctAmount = self._currenctAmount - CurrencyDiamondExchangeView.ClickStep

		self:refreshAmount()
	end
end

function CurrencyDiamondExchangeView:_btnaddOnClick()
	if self._currenctAmount ~= nil then
		self._currenctAmount = self._currenctAmount + CurrencyDiamondExchangeView.ClickStep

		self:refreshAmount()
	end
end

function CurrencyDiamondExchangeView:_btnbuyOnClick()
	if self._currenctAmount ~= nil and self._currenctAmount > 0 then
		local ownAmount = self:getOwnAmount()

		if ownAmount >= self._currenctAmount then
			CurrencyRpc.instance:sendExchangeDiamondRequest(self._currenctAmount, CurrencyEnum.PayDiamondExchangeSource.HUD, self.closeThis, self)
		else
			local currencyType = MaterialEnum.MaterialType.Currency
			local currencyId = CurrencyEnum.CurrencyType.Diamond
			local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(currencyType, currencyId, true)

			GameFacade.showToast(ToastEnum.DiamondBuy, itemConfig.name)
		end
	end
end

function CurrencyDiamondExchangeView:checkCurrenctAmount()
	local ownQuantity = self:getOwnAmount()

	if self._currenctAmount == nil then
		self._currenctAmount = 1
	end

	if self._currenctAmount < CurrencyDiamondExchangeView.MinAmount then
		self._currenctAmount = CurrencyDiamondExchangeView.MinAmount
	end
end

function CurrencyDiamondExchangeView:getOwnAmount()
	return ItemModel.instance:getItemQuantity(MaterialEnum.MaterialType.Currency, CurrencyEnum.CurrencyType.Diamond)
end

function CurrencyDiamondExchangeView:onClickModalMask()
	self:closeThis()
end

return CurrencyDiamondExchangeView
