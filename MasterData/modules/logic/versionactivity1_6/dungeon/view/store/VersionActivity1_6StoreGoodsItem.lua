-- chunkname: @modules/logic/versionactivity1_6/dungeon/view/store/VersionActivity1_6StoreGoodsItem.lua

module("modules.logic.versionactivity1_6.dungeon.view.store.VersionActivity1_6StoreGoodsItem", package.seeall)

local VersionActivity1_6StoreGoodsItem = class("VersionActivity1_6StoreGoodsItem", UserDataDispose)

function VersionActivity1_6StoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goClick = gohelper.getClick(go)
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

	self.goClick:AddClickListener(self.onClick, self)
end

function VersionActivity1_6StoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, self.storeGoodsCo)
end

function VersionActivity1_6StoreGoodsItem:updateInfo(storeGoodsCo)
	gohelper.setActive(self.go, true)

	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = self:getItemTypeIdQuantity(self.storeGoodsCo.product)
	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId)
	local rare

	if not productItemConfig.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		rare = 5
	else
		rare = productItemConfig.rare
	end

	UISpriteSetMgr.instance:setV1a6DungeonStoreSprite(self.imageRare, "v1a6_store_quality_" .. rare)
	gohelper.setActive(self.goMaxRareEffect, rare >= 5)

	if productItemType == MaterialEnum.MaterialType.Equip then
		self.simageIcon:LoadImage(ResUrl.getHeroDefaultEquipIcon(productItemConfig.icon), function()
			self.imageIcon:SetNativeSize()
		end)
	else
		self.simageIcon:LoadImage(productIconUrl, function()
			self.imageIcon:SetNativeSize()
		end)
	end

	gohelper.setActive(self.txtName, false)

	self.txtName = rare >= MaterialEnum.ItemRareR and gohelper.findChildText(self.go, "txt_name" .. rare) or gohelper.findChildText(self.go, "txt_name")

	gohelper.setActive(self.txtName, true)

	self.txtName.text = productItemConfig.name

	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and luaLang("multiple") .. productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = self:getItemTypeIdQuantity(self.storeGoodsCo.cost)
	self.txtCost.text = self.costItemQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costItemType, self.costItemId)

	if self.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end

	self:refreshTag()
end

function VersionActivity1_6StoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_6Enum.ActivityId.DungeonStore, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function VersionActivity1_6StoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function VersionActivity1_6StoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity1_6StoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function VersionActivity1_6StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return VersionActivity1_6StoreGoodsItem
