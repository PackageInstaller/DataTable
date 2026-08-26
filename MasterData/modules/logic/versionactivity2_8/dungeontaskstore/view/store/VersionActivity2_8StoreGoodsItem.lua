-- chunkname: @modules/logic/versionactivity2_8/dungeontaskstore/view/store/VersionActivity2_8StoreGoodsItem.lua

module("modules.logic.versionactivity2_8.dungeontaskstore.view.store.VersionActivity2_8StoreGoodsItem", package.seeall)

local VersionActivity2_8StoreGoodsItem = class("VersionActivity2_8StoreGoodsItem", ListScrollCell)

function VersionActivity2_8StoreGoodsItem:init(go)
	self.go = go
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtTag = gohelper.findChildText(self.go, "go_tag/txt_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")
	self._gonode2 = gohelper.findChild(self.go, "node2")
	self._gospecial = gohelper.findChild(self.go, "go_special")
	self._goTag2 = gohelper.findChild(self.go, "go_tag2")
	self._txtTag2 = gohelper.findChildText(self.go, "go_tag2/#txt1")
	self._txt2 = gohelper.findChildText(self.go, "node2/#txt2")
	self._imagekeyicon = gohelper.findChildImage(self.go, "node2/icon")
	self._txtCost2 = gohelper.findChildText(self.go, "txt_cost2")
	self.goClick = gohelper.getClickWithDefaultAudio(go)

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity2_8StoreGoodsItem:addEvents()
	return
end

function VersionActivity2_8StoreGoodsItem:removeEvents()
	return
end

function VersionActivity2_8StoreGoodsItem:onClick()
	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_5NormalStoreGoodsView, self.goodsCo)
end

function VersionActivity2_8StoreGoodsItem:onUpdateMO(goodsCo)
	self.goodsCo = goodsCo

	self:updateProductCo()
	self:updateRare()
	self:refreshRemainBuyCount()
	gohelper.setActive(self.go, true)
	self:refreshUI()
end

function VersionActivity2_8StoreGoodsItem:updateProductCo()
	self.productItemType, self.productItemId, self.productQuantity = self:getItemTypeIdQuantity(self.goodsCo.product)
	self.productConfig, self.productIconUrl = ItemModel.instance:getItemConfigAndIcon(self.productItemType, self.productItemId)
end

function VersionActivity2_8StoreGoodsItem:updateRare()
	self.rare = self.productConfig.rare

	if not self.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		self.rare = 5
	end
end

function VersionActivity2_8StoreGoodsItem:refreshRemainBuyCount()
	if self.goodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.goodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity2_8DungeonTaskStoreController.instance:getModuleConfig().DungeonStore, self.goodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function VersionActivity2_8StoreGoodsItem:refreshUI()
	self:refreshRareBg()
	self:refreshIcon()
	self:refreshTag()
	self:refreshName()
	self:refreshQuantity()
	self:refreshCost()
	self:refreshSpecProduct()
end

function VersionActivity2_8StoreGoodsItem:refreshSpecProduct()
	gohelper.setActive(self._gonode2, self.goodsCo.specProduct == 1)
	gohelper.setActive(self._gospecial, self.goodsCo.specProduct == 1)
	gohelper.setActive(self._goTag2, not string.nilorempty(self.goodsCo.offTag))

	if not string.nilorempty(self.goodsCo.offTag) then
		self._txtTag2.text = tonumber(self.goodsCo.offTag) * 100 .. "%"
	end

	self._txtCost2.text = self.goodsCo.originalCost

	gohelper.setActive(self._txtCost2.gameObject, self.goodsCo.originalCost > 0)

	if self.goodsCo.specProduct ~= 1 then
		return
	end

	local itemType, id, quantity = VersionActivityFixedEnterHelper.getItemTypeIdQuantity(self.goodsCo.product)
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(itemType, id)

	if itemCo.subType == ItemEnum.SubType.HeroExpBox then
		local keyCount = HeroExpBoxModel.instance:getKeyCount()
		local needKeyCount = HeroExpBoxModel.instance:getNeedKeyCount(itemCo.id)
		local icon = HeroExpBoxModel.instance:getKeyIcon()

		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagekeyicon, icon .. "_1", true)

		self._txt2.text = needKeyCount <= keyCount and string.format("%d/%d", keyCount, needKeyCount) or string.format("<color=%s>%d</color>/%d", "#FF0000", keyCount, needKeyCount)
	end
end

function VersionActivity2_8StoreGoodsItem:refreshRareBg()
	UISpriteSetMgr.instance:setV2a6MainActivitySprite(self.imageRare, "v2a6_store_quality_" .. self.rare)
	gohelper.setActive(self.goMaxRareEffect, self.rare >= 5)
end

function VersionActivity2_8StoreGoodsItem:refreshIcon()
	if self.productItemType == MaterialEnum.MaterialType.Equip then
		self.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(self.productConfig.icon), self.setNativeSize, self)
	else
		self.simageIcon:LoadImage(self.productIconUrl, self.setNativeSize, self)
	end
end

function VersionActivity2_8StoreGoodsItem:setNativeSize()
	self.imageIcon:SetNativeSize()
end

function VersionActivity2_8StoreGoodsItem:refreshTag()
	if self.goodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.goodsCo.tag)
end

function VersionActivity2_8StoreGoodsItem:refreshName()
	gohelper.setActive(self.txtName, false)

	self.txtName = self.rare >= MaterialEnum.ItemRareR and gohelper.findChildText(self.go, "txt_name" .. self.rare) or gohelper.findChildText(self.go, "txt_name")

	gohelper.setActive(self.txtName, true)

	self.txtName.text = self.productConfig.name
end

function VersionActivity2_8StoreGoodsItem:refreshQuantity()
	local showQuantity = self.productQuantity > 1

	gohelper.setActive(self.goQuantity, showQuantity)

	if showQuantity then
		self.txtQuantity.text = luaLang("multiple") .. self.productQuantity
	end
end

function VersionActivity2_8StoreGoodsItem:refreshCost()
	local costType, costId, costQuantity = self:getItemTypeIdQuantity(self.goodsCo.cost)

	self.txtCost.text = costQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(costType, costId)

	if costType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end
end

function VersionActivity2_8StoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity2_8StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
end

return VersionActivity2_8StoreGoodsItem
