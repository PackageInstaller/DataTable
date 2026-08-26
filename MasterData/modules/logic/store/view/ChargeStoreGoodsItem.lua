-- chunkname: @modules/logic/store/view/ChargeStoreGoodsItem.lua

module("modules.logic.store.view.ChargeStoreGoodsItem", package.seeall)

local ChargeStoreGoodsItem = class("ChargeStoreGoodsItem", ListScrollCellExtend)

function ChargeStoreGoodsItem:onInitView()
	self._imageicon = gohelper.findChildImage(self.viewGO, "#image_icon")
	self._txtname = gohelper.findChildText(self.viewGO, "#image_icon/#txt_name")
	self._txtnum = gohelper.findChildText(self.viewGO, "#image_icon/huan/#txt_num")
	self._gorecharge = gohelper.findChild(self.viewGO, "#image_icon/#go_recharge")
	self._txtrecharge = gohelper.findChildText(self.viewGO, "#image_icon/#go_recharge/#txt_recharge")
	self._txtrechargenum = gohelper.findChildText(self.viewGO, "#image_icon/#go_recharge/#txt_recharge_num")
	self._goexcharge = gohelper.findChild(self.viewGO, "#image_icon/#go_excharge")
	self._txtexcharge = gohelper.findChildText(self.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge")
	self._txtexchargenum = gohelper.findChildText(self.viewGO, "#image_icon/#go_excharge/excharge/#txt_excharge_num")
	self._txtbtnnum = gohelper.findChildText(self.viewGO, "btn_bg/#txt_btn_num")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function ChargeStoreGoodsItem:addEvents()
	return
end

function ChargeStoreGoodsItem:removeEvents()
	return
end

function ChargeStoreGoodsItem:_editableInitView()
	self._btnGO = gohelper.findChild(self.viewGO, "clickArea")
	self._btn = gohelper.getClickWithAudio(self._btnGO)

	self._btn:AddClickListener(self._onClick, self)

	self._lastStartPayTime = 0
	self._animator = self.viewGO:GetComponent(typeof(UnityEngine.Animator))
end

function ChargeStoreGoodsItem:_editableAddEvents()
	return
end

function ChargeStoreGoodsItem:_editableRemoveEvents()
	return
end

function ChargeStoreGoodsItem:_onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.play_ui_payment_click)

	if Time.time - self._lastStartPayTime > 0.3 then
		PayController.instance:startPay(self._mo.id)

		self._lastStartPayTime = Time.time

		StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
	end
end

function ChargeStoreGoodsItem:onUpdateMO(mo)
	self._mo = mo

	self:_refreshGoods()
	self:_refreshDiscount()
end

function ChargeStoreGoodsItem:_refreshGoods()
	local product = self._mo.config.product
	local productParams = string.splitToNumber(product, "#")
	local quantity = productParams[3]

	UISpriteSetMgr.instance:setStoreGoodsSprite(self._imageicon, self._mo.config.id, true)

	self._txtnum.text = quantity
	self._txtbtnnum.text = PayModel.instance:getProductPrice(self._mo.id)
	self._txtname.text = self._mo.config.name
end

function ChargeStoreGoodsItem:_refreshDiscount()
	gohelper.setActive(self._gorecharge, false)
	gohelper.setActive(self._goexcharge, false)

	local isFirst = self._mo.firstCharge

	if isFirst then
		if self._mo.config.firstDiamond > 0 then
			gohelper.setActive(self._gorecharge, true)
			gohelper.setActive(self._gorechargeTip, true)

			self._txtrechargenum.text = string.format("<size=24>+</size>%s", self._mo.config.firstDiamond)
			self._txtrecharge.text = luaLang("store_charge_firstdouble")
		end
	elseif self._mo.config.extraDiamond > 0 then
		gohelper.setActive(self._goexcharge, true)

		self._txtexcharge.text = string.format(luaLang("store_charge_extra"), self._mo.config.extraDiamond)
		self._txtexchargenum.text = string.format("<voffset=1><size=24>+</size></voffset>%s", self._mo.config.extraDiamond)
	end
end

function ChargeStoreGoodsItem:onSelect(isSelect)
	return
end

function ChargeStoreGoodsItem:getAnimator()
	return self._animator
end

function ChargeStoreGoodsItem:onDestroyView()
	self._btn:RemoveClickListener()
end

return ChargeStoreGoodsItem
