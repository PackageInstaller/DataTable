-- chunkname: @modules/logic/survival/view/store/SurvivalStoreGoodsItem.lua

module("modules.logic.survival.view.store.SurvivalStoreGoodsItem", package.seeall)

local SurvivalStoreGoodsItem = class("SurvivalStoreGoodsItem", SimpleListItem)

function SurvivalStoreGoodsItem:onInit()
	self.goTag = gohelper.findChild(self.viewGO, "go_tag")
	self.txtLimitBuy = gohelper.findChildText(self.viewGO, "layout/txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.viewGO, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.viewGO, "eff_rare5")
	self.simageIcon = gohelper.findChildSingleImage(self.viewGO, "goIcon/simage_icon")
	self.imageIcon = gohelper.findChildImage(self.viewGO, "goIcon/simage_icon")
	self.goQuantity = gohelper.findChild(self.viewGO, "quantity")
	self.txtQuantity = gohelper.findChildText(self.viewGO, "quantity/bg/txt_quantity")
	self.txtCost = gohelper.findChildText(self.viewGO, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.viewGO, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.viewGO, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.viewGO, "go_soldout")
	self.goClick = gohelper.findChildButtonWithAudio(self.viewGO, "goClick")
	self.reddot = gohelper.findChild(self.viewGO, "#go_reddot")
	self._btnClickItem = self.goClick
end

function SurvivalStoreGoodsItem:_onClickItem()
	SurvivalStoreGoodsItem.super._onClickItem(self)
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.SurvivalStoreGoodsView, self._mo)
end

function SurvivalStoreGoodsItem:onItemShow(mo)
	self._mo = mo
	self._co = mo.config

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = self:getItemTypeIdQuantity(self._co.product)
	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId)
	local rare

	if not productItemConfig.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		rare = 5
	else
		rare = productItemConfig.rare
	end

	UISpriteSetMgr.instance:setStoreGoodsSprite(self.imageRare, "rare" .. rare)
	gohelper.setActive(self.goMaxRareEffect, rare >= 5)

	local _

	if productItemConfig.subType == ItemEnum.SubType.Portrait then
		productIconUrl = ResUrl.getPlayerHeadIcon(productItemConfig.icon)
	elseif productItemType == MaterialEnum.MaterialType.Equip then
		productIconUrl = ResUrl.getHeroDefaultEquipIcon(productItemConfig.icon)
	elseif productItemType == MaterialEnum.MaterialType.Hero then
		_, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)
	end

	self.simageIcon:LoadImage(productIconUrl, function()
		self.imageIcon:SetNativeSize()
	end)
	gohelper.setActive(self.txtName, false)

	self.txtName = gohelper.findChildText(self.viewGO, "layout/txt_name")

	gohelper.setActive(self.txtName, true)

	self.txtName.text = productItemConfig.name

	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = self:getItemTypeIdQuantity(self._co.cost)
	self.txtCost.text = self.costItemQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costItemType, self.costItemId)

	if self.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end

	self:refreshTag()
end

function SurvivalStoreGoodsItem:refreshRemainBuyCount()
	if self._mo:getMaxBuyCount() == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self._mo:getRemainBuyCount()
		self.txtLimitBuy.text = string.format(luaLang("v1a4_bossrush_storeview_buylimit"), self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function SurvivalStoreGoodsItem:refreshTag()
	if self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)
end

function SurvivalStoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function SurvivalStoreGoodsItem:onDestroy()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
end

return SurvivalStoreGoodsItem
