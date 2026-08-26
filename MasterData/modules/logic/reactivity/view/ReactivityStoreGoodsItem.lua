-- chunkname: @modules/logic/reactivity/view/ReactivityStoreGoodsItem.lua

module("modules.logic.reactivity.view.ReactivityStoreGoodsItem", package.seeall)

local ReactivityStoreGoodsItem = class("ReactivityStoreGoodsItem", UserDataDispose)

function ReactivityStoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goClick = gohelper.getClick(go)
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtTag = gohelper.findChildText(self.go, "go_tag/txt_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtName = gohelper.findChildText(self.go, "txt_name")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")
	self.goSwitch = gohelper.findChild(self.go, "switch_icon")
	self.simageSwitchIcon1 = gohelper.findChildSingleImage(self.go, "switch_icon/simage_icon1")
	self.imageSwitchIcon1 = gohelper.findChildImage(self.go, "switch_icon/simage_icon1")
	self.goQuantity1 = gohelper.findChild(self.go, "switch_icon/quantity1")
	self.txtQuantity1 = gohelper.findChildText(self.goQuantity1, "txt_quantity")
	self.simageSwitchIcon2 = gohelper.findChildSingleImage(self.go, "switch_icon/simage_icon2")
	self.imageSwitchIcon2 = gohelper.findChildImage(self.go, "switch_icon/simage_icon2")
	self.goQuantity2 = gohelper.findChild(self.go, "switch_icon/quantity2")
	self.txtQuantity2 = gohelper.findChildText(self.goQuantity2, "txt_quantity")
	self.goIconExchange = gohelper.findChild(self.go, "icon_exchange")

	self.goClick:AddClickListener(self.onClick, self)

	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
end

function ReactivityStoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.VersionActivityNormalStoreGoodsView, self.storeGoodsCo)
end

function ReactivityStoreGoodsItem:updateInfo(storeGoodsCo)
	gohelper.setActive(self.go, true)

	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = self:getItemTypeIdQuantity(self.storeGoodsCo.product)
	local productItemConfig = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId)
	local needConvert, convertPrice = ReactivityConfig.instance:checkItemNeedConvert(productItemType, productItemId)
	local rare

	if not productItemConfig.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		rare = 5
	else
		rare = productItemConfig.rare
	end

	gohelper.setActive(self.goMaxRareEffect, rare >= 5)

	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()

	local iconName = VersionActivityFixedHelper.getVersionActivityStoreRareIcon(self._bigVersion, self._smallVersion) .. rare

	VersionActivityFixedHelper.setMainActivitySprite(self.imageRare, iconName, true, self._bigVersion, self._smallVersion)

	if needConvert and self.remainBuyCount > 0 then
		gohelper.setActive(self.goIconExchange, true)
		gohelper.setActive(self.simageIcon, false)
		gohelper.setActive(self.goSwitch, false)
		gohelper.setActive(self.goSwitch, true)
		gohelper.setActive(self.goQuantity, false)
		self:loadItemSingleImage(self.simageSwitchIcon1, self.imageSwitchIcon1, productItemType, productItemId)
		self:setQuantityTxt(self.goQuantity1, self.txtQuantity1, productItemQuantity)

		local convertPriceList = string.splitToNumber(convertPrice, "#")

		self:loadItemSingleImage(self.simageSwitchIcon2, self.imageSwitchIcon2, convertPriceList[1], convertPriceList[2])
		self:setQuantityTxt(self.goQuantity2, self.txtQuantity2, convertPriceList[3])
	else
		gohelper.setActive(self.goIconExchange, false)
		gohelper.setActive(self.simageIcon, true)
		gohelper.setActive(self.goSwitch, false)
		self:loadItemSingleImage(self.simageIcon, self.imageIcon, productItemType, productItemId)
		self:setQuantityTxt(self.goQuantity, self.txtQuantity, productItemQuantity)
	end

	gohelper.setActive(self.txtName, false)

	if rare >= MaterialEnum.ItemRareR then
		local rareTxtName = gohelper.findChildText(self.go, "txt_name" .. rare)

		if rareTxtName then
			self.txtName = rareTxtName
		end
	else
		self.txtName = gohelper.findChildText(self.go, "txt_name")
	end

	gohelper.setActive(self.txtName, true)

	self.txtName.text = productItemConfig.name
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

function ReactivityStoreGoodsItem:setQuantityTxt(goQuantity, txtQuantity, quantity)
	gohelper.setActive(goQuantity, quantity > 1)

	if quantity > 1 then
		txtQuantity.text = luaLang("multiple") .. quantity
	end
end

function ReactivityStoreGoodsItem:loadItemSingleImage(simage, imageIcon, itemType, itemId)
	local itemConfig, iconUrl = ItemModel.instance:getItemConfigAndIcon(itemType, itemId)

	if itemType == MaterialEnum.MaterialType.Equip then
		simage:LoadImage(ResUrl.getHeroDefaultEquipIcon(itemConfig.icon), function()
			imageIcon:SetNativeSize()
		end)
	else
		simage:LoadImage(iconUrl, function()
			imageIcon:SetNativeSize()
		end)
	end
end

function ReactivityStoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.storeGoodsCo.activityId, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function ReactivityStoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function ReactivityStoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function ReactivityStoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function ReactivityStoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return ReactivityStoreGoodsItem
