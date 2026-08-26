-- chunkname: @modules/logic/versionactivity2_3/act174/view/outside/Act174StoreGoodsItem.lua

module("modules.logic.versionactivity2_3.act174.view.outside.Act174StoreGoodsItem", package.seeall)

local Act174StoreGoodsItem = class("Act174StoreGoodsItem", UserDataDispose)

function Act174StoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goClick = gohelper.getClick(go)
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

	self.goClick:AddClickListener(self.onClick, self)
end

function Act174StoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, self.storeGoodsCo)
end

function Act174StoreGoodsItem:updateInfo(storeGoodsCo)
	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = VersionActivity2_1EnterHelper.getItemTypeIdQuantity(self.storeGoodsCo.product)
	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId)
	local rare = MaterialEnum.ItemRareSSR

	if productItemConfig.rare then
		rare = productItemConfig.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	UISpriteSetMgr.instance:setAct174Sprite(self.imageRare, "act174_store_quality_" .. rare)
	gohelper.setActive(self.goMaxRareEffect, rare >= MaterialEnum.ItemRareSSR)

	if productItemType == MaterialEnum.MaterialType.Equip then
		local imgPath = ResUrl.getHeroDefaultEquipIcon(productItemConfig.icon)

		self.simageIcon:LoadImage(imgPath, self.setImageIconNative, self)
	else
		self.simageIcon:LoadImage(productIconUrl, self.setImageIconNative, self)
	end

	gohelper.setActive(self.txtName, false)

	if rare >= MaterialEnum.ItemRareR then
		local rareTxtName = gohelper.findChildText(self.go, "txt_name" .. rare)

		if rareTxtName then
			self.txtName = rareTxtName
		end
	end

	if self.txtName then
		self.txtName.text = productItemConfig.name
	end

	gohelper.setActive(self.txtName, true)
	gohelper.setActive(self.goQuantity, productItemQuantity > 1)

	self.txtQuantity.text = productItemQuantity > 1 and luaLang("multiple") .. productItemQuantity or ""
	self.costItemType, self.costItemId, self.costItemQuantity = VersionActivity2_1EnterHelper.getItemTypeIdQuantity(self.storeGoodsCo.cost)
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

function Act174StoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		local actId = VersionActivity2_3Enum.ActivityId.Act174Store

		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function Act174StoreGoodsItem:setImageIconNative()
	self.imageIcon:SetNativeSize()
end

function Act174StoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function Act174StoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function Act174StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return Act174StoreGoodsItem
