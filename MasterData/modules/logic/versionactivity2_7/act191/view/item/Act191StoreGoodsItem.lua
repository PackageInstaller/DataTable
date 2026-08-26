-- chunkname: @modules/logic/versionactivity2_7/act191/view/item/Act191StoreGoodsItem.lua

module("modules.logic.versionactivity2_7.act191.view.item.Act191StoreGoodsItem", package.seeall)

local Act191StoreGoodsItem = class("Act191StoreGoodsItem", UserDataDispose)

function Act191StoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtTag = gohelper.findChildText(self.go, "go_tag/txt_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "txt_limitbuy")
	self.goIcon = gohelper.findChild(self.go, "go_Icon")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "go_Icon/simage_icon")
	self.frame = gohelper.findChild(self.go, "go_Icon/frame")
	self.imageIcon = gohelper.findChildImage(self.go, "go_Icon/simage_icon")
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

function Act191StoreGoodsItem:onClick()
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

function Act191StoreGoodsItem:updateInfo(storeGoodsCo)
	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = Act191StoreGoodsItem.getItemTypeIdQuantity(self.storeGoodsCo.product)

	self.productItemType = productItemType

	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)
	local rare = MaterialEnum.ItemRareSSR

	if itemCo.rare then
		rare = itemCo.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_store_quality_" .. rare)
	gohelper.setActive(self.goMaxRareEffect, rare >= MaterialEnum.ItemRareSSR)

	if productItemType == MaterialEnum.MaterialType.Equip then
		itemIcon = ResUrl.getHeroDefaultEquipIcon(itemCo.icon)
	end

	if itemCo.subType == ItemEnum.SubType.Portrait then
		itemIcon = ResUrl.getPlayerHeadIcon(itemCo.icon)

		gohelper.setActive(self.frame, true)
	else
		gohelper.setActive(self.frame, false)
	end

	self.simageIcon:LoadImage(itemIcon, self.setImageIconNative, self)
	gohelper.setActive(self.txtName, false)

	if rare >= MaterialEnum.ItemRareR then
		local rareTxtName = gohelper.findChildText(self.go, "txt_name" .. rare)

		if rareTxtName then
			self.txtName = rareTxtName
		end
	end

	if self.txtName then
		self.txtName.text = itemCo.name
	end

	gohelper.setActive(self.txtName, true)
	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and luaLang("multiple") .. productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = Act191StoreGoodsItem.getItemTypeIdQuantity(self.storeGoodsCo.cost)
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

function Act191StoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		local actId = Activity191Controller.instance:getStoreId()

		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function Act191StoreGoodsItem:setImageIconNative()
	self.imageIcon:SetNativeSize()
end

function Act191StoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function Act191StoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function Act191StoreGoodsItem:onDestroy()
	self.btnClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

function Act191StoreGoodsItem.getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

return Act191StoreGoodsItem
