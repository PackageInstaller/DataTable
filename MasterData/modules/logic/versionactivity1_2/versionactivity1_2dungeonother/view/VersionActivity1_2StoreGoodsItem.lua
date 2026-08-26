-- chunkname: @modules/logic/versionactivity1_2/versionactivity1_2dungeonother/view/VersionActivity1_2StoreGoodsItem.lua

module("modules.logic.versionactivity1_2.versionactivity1_2dungeonother.view.VersionActivity1_2StoreGoodsItem", package.seeall)

local VersionActivity1_2StoreGoodsItem = class("VersionActivity1_2StoreGoodsItem", UserDataDispose)

function VersionActivity1_2StoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goClick = gohelper.getClick(go)
	self.imageBg = gohelper.findChildImage(self.go, "image_bg")
	self._goDiscount = gohelper.findChild(self.go, "go_discount")
	self.txtDiscount = gohelper.findChildText(self.go, "go_discount/txt_discount")
	self.txtLimitBuy = gohelper.findChildText(self.go, "layout/txt_remain")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageBar = gohelper.findChildImage(self.go, "layout/image_bar")
	self.imageIcon = gohelper.findChildImage(self.go, "simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtName = gohelper.findChildText(self.go, "layout/txt_goodsName")
	self.txtCost = gohelper.findChildText(self.go, "cost/txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "cost/txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "cost/txt_cost/simage_coin")
	self.goOriginCost = gohelper.findChild(self.go, "cost/go_origincost")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")

	self.goClick:AddClickListener(self.onClick, self)
	gohelper.setActive(self.goOriginCost, false)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)

	self._txtOutlineColor = {
		"#D0D0D0FF",
		"#D0D0D0FF",
		"#745A7CFF",
		"#997C2EFF",
		"#B36B24FF"
	}
end

function VersionActivity1_2StoreGoodsItem:onClick()
	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, self.storeGoodsCo)
end

function VersionActivity1_2StoreGoodsItem:onBuyGoodsSuccess(activityId, goodsId)
	if activityId ~= self.storeGoodsCo.activityId or goodsId ~= self.storeGoodsCo.id then
		return
	end

	self:refreshRemainBuyCount()
end

function VersionActivity1_2StoreGoodsItem:updateInfo(storeGoodsCo)
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

	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(self.imageRare, "img_pinzhi_" .. rare + 1)
	UISpriteSetMgr.instance:setVersionActivity1_2Sprite(self.imageBg, "shangpin_di_" .. rare + 1)

	if rare > 2 then
		UISpriteSetMgr.instance:setVersionActivity1_2Sprite(self.imageBar, "bg_zhongdian_" .. rare + 1)
	end

	gohelper.setActive(self.imageBar.gameObject, rare > 2)
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

	gohelper.setActive(self._goDiscount, self.storeGoodsCo.tag > 0)

	self.txtDiscount.text = self.storeGoodsCo.tag > 0 and luaLang("versionactivity_1_2_storeview_tagtype_" .. self.storeGoodsCo.tag) or ""
	self.fontMaterial = self.fontMaterial or UnityEngine.Object.Instantiate(self.txtName.fontMaterial)
	self.txtName.fontMaterial = self.fontMaterial

	self.txtName.fontMaterial:SetFloat("_OutlineWidth", rare > 2 and 0.03 or 0)
	self.txtName.fontMaterial:SetColor("_OutlineColor", GameUtil.parseColor(self._txtOutlineColor[rare]))
end

function VersionActivity1_2StoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(VersionActivity1_2Enum.ActivityId.DungeonStore, self.storeGoodsCo.id)
		self.txtLimitBuy.text = luaLang("store_buylimit") .. ":" .. self.remainBuyCount

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function VersionActivity1_2StoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function VersionActivity1_2StoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function VersionActivity1_2StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self.removeEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
	self:__onDispose()
end

return VersionActivity1_2StoreGoodsItem
