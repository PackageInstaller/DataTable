-- chunkname: @modules/logic/sodache/view/outside/comp/SodacheStoreGoodsItem.lua

module("modules.logic.sodache.view.outside.comp.SodacheStoreGoodsItem", package.seeall)

local SodacheStoreGoodsItem = class("SodacheStoreGoodsItem", UserDataDispose)

function SodacheStoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtTag = gohelper.findChildText(self.go, "go_tag/txt_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "txt_limitbuy")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "simage_icon")
	self.txtName = gohelper.findChildText(self.go, "txt_name")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")
	self.btnClick = gohelper.findChildButton(self.go, "click")

	self.btnClick:AddClickListener(self.onClick, self)
end

function SodacheStoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	if self.productItemType == MaterialEnum.MaterialType.HeroSkin then
		ViewMgr.instance:openView(ViewName.StoreSkinGoodsView, {
			isActivityStore = true,
			goodsMO = self.storeGoodsCo
		})
	else
		ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, self.storeGoodsCo)
	end
end

function SodacheStoreGoodsItem:updateInfo(storeGoodsCo)
	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = SodacheStoreGoodsItem.getItemTypeIdQuantity(self.storeGoodsCo.product)

	self.productItemType = productItemType

	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)
	local rare = MaterialEnum.ItemRareSSR

	if itemCo.rare then
		rare = itemCo.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	UISpriteSetMgr.instance:setV2a7MainActivitySprite(self.imageRare, "v2a7_store_quality_" .. rare)
	gohelper.setActive(self.goMaxRareEffect, rare >= MaterialEnum.ItemRareSSR)
	self.simageIcon:LoadImage((productItemType == MaterialEnum.MaterialType.Equip or nil) and ResUrl.getHeroDefaultEquipIcon(itemCo.icon), self.setImageIconNative, self)

	self.txtName.text = itemCo.name

	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and luaLang("multiple") .. productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = SodacheStoreGoodsItem.getItemTypeIdQuantity(self.storeGoodsCo.cost)
	self.txtCost.text = self.costItemQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costItemType, self.costItemId)

	if self.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end

	self:refreshTag()
	gohelper.setActive(self.go, true)
end

function SodacheStoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		local actId = VersionActivity3_7Enum.ActivityId.SodacheStore

		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function SodacheStoreGoodsItem:setImageIconNative()
	self.imageIcon:SetNativeSize()
end

function SodacheStoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function SodacheStoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function SodacheStoreGoodsItem:onDestroy()
	self.btnClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

function SodacheStoreGoodsItem.getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

return SodacheStoreGoodsItem
