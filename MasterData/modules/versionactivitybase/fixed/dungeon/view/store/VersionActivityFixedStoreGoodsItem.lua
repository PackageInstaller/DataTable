-- chunkname: @modules/versionactivitybase/fixed/dungeon/view/store/VersionActivityFixedStoreGoodsItem.lua

module("modules.versionactivitybase.fixed.dungeon.view.store.VersionActivityFixedStoreGoodsItem", package.seeall)

local VersionActivityFixedStoreGoodsItem = class("VersionActivityFixedStoreGoodsItem", UserDataDispose)

function VersionActivityFixedStoreGoodsItem:onInitView(go)
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
	self.frame = gohelper.findChild(self.go, "#go_frame")
	self.txtName = gohelper.findChildText(self.go, "txt_name")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/txt_quantity")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")

	self.goClick:AddClickListener(self.onClick, self)

	self._gonode2 = gohelper.findChild(self.go, "node2")
	self._gospecial = gohelper.findChild(self.go, "go_special")
	self._goTag2 = gohelper.findChild(self.go, "go_tag2")
	self._txtTag2 = gohelper.findChildText(self.go, "go_tag2/#txt1")
	self._txtCost2 = gohelper.findChildText(self.go, "txt_cost2")
	self._bigVersion, self._smallVersion = VersionActivityFixedDungeonController.instance:getEnterVerison()
end

function VersionActivityFixedStoreGoodsItem:setActId(id)
	self.actId = id
end

function VersionActivityFixedStoreGoodsItem:onClick()
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
		ViewMgr.instance:openView(ViewName.VersionActivity1_6NormalStoreGoodsView, self.storeGoodsCo)
	end
end

function VersionActivityFixedStoreGoodsItem:updateInfo(storeGoodsCo)
	gohelper.setActive(self._gonode2, storeGoodsCo.specProduct == 1)
	gohelper.setActive(self._gospecial, storeGoodsCo.specProduct == 1)
	gohelper.setActive(self._goTag2, not string.nilorempty(storeGoodsCo.offTag))

	if not string.nilorempty(storeGoodsCo.offTag) then
		self._txtTag2.text = tonumber(storeGoodsCo.offTag) * 100 .. "%"
	end

	if self._txtCost2 then
		self._txtCost2.text = storeGoodsCo.originalCost

		gohelper.setActive(self._txtCost2.gameObject, storeGoodsCo.originalCost > 0)
	end

	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = VersionActivityFixedEnterHelper.getItemTypeIdQuantity(self.storeGoodsCo.product)

	self.productItemType = productItemType

	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)
	local rare = MaterialEnum.ItemRareSSR

	if not productItemConfig then
		logError("商品内容找不到对应的道具配置：" .. self.storeGoodsCo.id .. "    " .. self.storeGoodsCo.product)

		return
	end

	if productItemConfig.rare then
		rare = productItemConfig.rare
	else
		logWarn("material type : %s, material id : %s not had rare attribute")
	end

	local iconName = VersionActivityFixedHelper.getVersionActivityStoreRareIcon(self._bigVersion, self._smallVersion) .. rare

	VersionActivityFixedHelper.setMainActivitySprite(self.imageRare, iconName, true, self._bigVersion, self._smallVersion)
	gohelper.setActive(self.goMaxRareEffect, rare >= MaterialEnum.ItemRareSSR)
	gohelper.setActive(self.frame, productItemConfig.subType == ItemEnum.SubType.Portrait)

	if productItemConfig.subType == ItemEnum.SubType.Portrait then
		productIconUrl = ResUrl.getPlayerHeadIcon(productItemConfig.icon)
	elseif productItemType == MaterialEnum.MaterialType.Equip then
		productIconUrl = ResUrl.getHeroDefaultEquipIcon(productItemConfig.icon)
	end

	self.simageIcon:LoadImage(productIconUrl, self.setImageIconNative, self)
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
	self.costItemType, self.costItemId, self.costItemQuantity = VersionActivityFixedEnterHelper.getItemTypeIdQuantity(self.storeGoodsCo.cost)
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

function VersionActivityFixedStoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		local actId = self.actId

		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(actId, self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function VersionActivityFixedStoreGoodsItem:setImageIconNative()
	self.imageIcon:SetNativeSize()
end

function VersionActivityFixedStoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function VersionActivityFixedStoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function VersionActivityFixedStoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return VersionActivityFixedStoreGoodsItem
