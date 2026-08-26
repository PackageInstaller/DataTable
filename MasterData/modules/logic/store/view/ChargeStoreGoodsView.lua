-- chunkname: @modules/logic/store/view/ChargeStoreGoodsView.lua

module("modules.logic.store.view.ChargeStoreGoodsView", package.seeall)

local ChargeStoreGoodsView = class("ChargeStoreGoodsView", BaseView)

function ChargeStoreGoodsView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "#simage_rightbg")
	self._txtsalePrice = gohelper.findChildText(self.viewGO, "buy/cost/#txt_salePrice")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "propinfo/#txt_goodsNameCn")
	self._txtgoodsNameEn = gohelper.findChildText(self.viewGO, "propinfo/#txt_goodsNameEn")
	self._txtgoodsDesc = gohelper.findChildText(self.viewGO, "propinfo/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._txtgoodsHave = gohelper.findChildText(self.viewGO, "propinfo/#txt_goodsHave")
	self._goitem = gohelper.findChild(self.viewGO, "propinfo/#go_item")
	self._txtitemcount = gohelper.findChildText(self.viewGO, "propinfo/#go_item/#txt_itemcount")
	self._txtvalue = gohelper.findChildText(self.viewGO, "buy/valuebg/#txt_value")
	self._btncharge = gohelper.findChildButtonWithAudio(self.viewGO, "buy/#btn_charge")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "propinfo/#btn_click")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "propinfo/#simage_icon")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChargeStoreGoodsView:addEvents()
	self._btncharge:AddClickListener(self._btnchargeOnClick, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
end

function ChargeStoreGoodsView:removeEvents()
	self._btncharge:RemoveClickListener()
	self._btnclick:RemoveClickListener()
end

function ChargeStoreGoodsView:_btnclickOnClick()
	MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId)
end

function ChargeStoreGoodsView:_btnchargeOnClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)
	PayController.instance:startPay(self._mo.id)
end

function ChargeStoreGoodsView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getStoreBottomBgIcon("bg_2"))
end

function ChargeStoreGoodsView:_refreshUI()
	local product = self._mo.config.product
	local productParams = string.splitToNumber(product, "#")

	self._itemType = productParams[1]
	self._itemId = productParams[2]
	self._itemQuantity = productParams[3]

	local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)

	self._simageicon:LoadImage(itemIcon)
	gohelper.setActive(self._goitem, self._itemQuantity > 1)

	self._txtitemcount.text = GameUtil.numberDisplay(self._itemQuantity)
	self._txtgoodsNameCn.text = itemConfig.name
	self._txtgoodsDesc.text = itemConfig.useDesc
	self._txtsalePrice.text = string.format("%s%s", StoreModel.instance:getCostStr(self._mo.config.price))
end

function ChargeStoreGoodsView:onOpen()
	self._mo = self.viewParam

	self.addEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
	self:_refreshUI()
end

function ChargeStoreGoodsView:_payFinished()
	self:closeThis()
end

function ChargeStoreGoodsView:onClose()
	self.removeEventCb(self, PayController.instance, PayEvent.PayFinished, self._payFinished, self)
end

function ChargeStoreGoodsView:onUpdateParam()
	self._mo = self.viewParam

	self:_refreshUI()
end

function ChargeStoreGoodsView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageicon:UnLoadImage()
end

return ChargeStoreGoodsView
