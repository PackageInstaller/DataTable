-- chunkname: @modules/logic/store/view/StoreSkinConfirmView.lua

module("modules.logic.store.view.StoreSkinConfirmView", package.seeall)

local StoreSkinConfirmView = class("StoreSkinConfirmView", BaseView)

function StoreSkinConfirmView:onInitView()
	self._simagehuawen1 = gohelper.findChildSingleImage(self.viewGO, "bg/tipbg/#simage_huawen1")
	self._simagehuawen2 = gohelper.findChildSingleImage(self.viewGO, "bg/tipbg/#simage_huawen2")
	self._simagebeforeicon = gohelper.findChildSingleImage(self.viewGO, "cost/before/#simage_beforeicon")
	self._simageaftericon = gohelper.findChildSingleImage(self.viewGO, "cost/after/#simage_aftericon")
	self._txtbeforequantity = gohelper.findChildText(self.viewGO, "cost/before/numbg/#txt_beforequantity")
	self._txtafterquantity = gohelper.findChildText(self.viewGO, "cost/after/numbg/#txt_afterquantity")
	self._txtdesc = gohelper.findChildText(self.viewGO, "#txt_desc")
	self._btnyes = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_yes")
	self._btnno = gohelper.findChildButtonWithAudio(self.viewGO, "#btn_no")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function StoreSkinConfirmView:addEvents()
	self._btnyes:AddClickListener(self._btnyesOnClick, self)
	self._btnno:AddClickListener(self._btnnoOnClick, self)
end

function StoreSkinConfirmView:removeEvents()
	self._btnyes:RemoveClickListener()
	self._btnno:RemoveClickListener()
end

function StoreSkinConfirmView:_btnyesOnClick()
	self._yes = true

	CurrencyController.instance:checkExchangeFreeDiamond(self.viewParam.cost_quantity, CurrencyEnum.PayDiamondExchangeSource.SkinStore, self._callback, self._callbackObj, self.jumpCallBack, self)
	self:closeThis()
end

function StoreSkinConfirmView:_btnnoOnClick()
	self:closeThis()
end

function StoreSkinConfirmView:_editableInitView()
	self._simagehuawen1:LoadImage(ResUrl.getMessageIcon("huawen1_002"))
	self._simagehuawen2:LoadImage(ResUrl.getMessageIcon("huawen2_003"))
	gohelper.addUIClickAudio(self._btnyes.gameObject, AudioEnum.UI.UI_Common_Click)
	gohelper.addUIClickAudio(self._btnno.gameObject, AudioEnum.UI.UI_Common_Click)
end

function StoreSkinConfirmView:onUpdateParam()
	self:onOpen()
end

function StoreSkinConfirmView:onOpen()
	self._type = self.viewParam.type
	self._id = self.viewParam.id
	self._quantity = self.viewParam.quantity
	self._callback = self.viewParam.callback
	self._callbackObj = self.viewParam.callbackObj
	self._yes = false
	self.needTransform = self.viewParam.needTransform

	local config, icon = ItemModel.instance:getItemConfigAndIcon(self._type, self._id)

	self._simageaftericon:LoadImage(icon)

	local afterConfig, afterIcon = ItemModel.instance:getItemConfigAndIcon(self.viewParam.cost_type, self.viewParam.cost_id)

	self._simagebeforeicon:LoadImage(afterIcon)

	self._txtbeforequantity.text = GameUtil.numberDisplay(self.viewParam.cost_quantity)
	self._txtafterquantity.text = GameUtil.numberDisplay(self.viewParam.miss_quantity)

	local var_8_0 = {
		self.viewParam.miss_quantity
	}

	var_8_0[2] = (self._type == MaterialEnum.MaterialType.Currency and (self._id == CurrencyEnum.CurrencyType.Diamond or self._id == CurrencyEnum.CurrencyType.FreeDiamondCoupon) or nil) and true and luaLang("summon_confirm_quantifier1") or luaLang("skin_confirm_quantifier1")
	var_8_0[3] = config.name
	var_8_0[4] = self.viewParam.cost_quantity
	var_8_0[5] = afterConfig.name

	local tag = var_8_0

	self._txtdesc.text = GameUtil.getSubPlaceholderLuaLang(luaLang("skin_transform_desc"), tag)
end

function StoreSkinConfirmView:jumpCallBack()
	ViewMgr.instance:closeView(ViewName.StoreSkinGoodsView)
	ViewMgr.instance:closeView(ViewName.StoreSkinPreviewView)
	self:closeThis()
end

function StoreSkinConfirmView:onClose()
	return
end

function StoreSkinConfirmView:onCloseFinish()
	if self._yes and not self.viewParam.notEnough and self._callback then
		self._callback(self._callbackObj)
	end
end

function StoreSkinConfirmView:onDestroyView()
	self._simagehuawen1:UnLoadImage()
	self._simagehuawen2:UnLoadImage()
	self._simagebeforeicon:UnLoadImage()
	self._simageaftericon:UnLoadImage()
end

return StoreSkinConfirmView
