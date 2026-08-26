-- chunkname: @modules/logic/rouge2/outside/view/Rouge2_StoreGoodsItem.lua

module("modules.logic.rouge2.outside.view.Rouge2_StoreGoodsItem", package.seeall)

local Rouge2_StoreGoodsItem = class("Rouge2_StoreGoodsItem", UserDataDispose)

function Rouge2_StoreGoodsItem:onInitView(go)
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
	self.go_LevelLimit = gohelper.findChild(self.go, "go_levellimit")
	self.txt_LevelLimit = gohelper.findChildTextMesh(self.go, "go_levellimit/bg/txt")

	self.goClick:AddClickListener(self.onClick, self)
end

function Rouge2_StoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	local isOpen = Rouge2_StoreModel.instance:isCurStoreOpen(true)

	if not isOpen then
		return
	end

	local curStageId = Rouge2_StoreModel.instance:getCurStageId()
	local isBuyLimit = self.storeGoodsCo.maxBuyCount == 0 and not Rouge2_StoreModel.instance:isStoreAllClaimed(curStageId)

	if isBuyLimit then
		GameFacade.showToast(ToastEnum.Rouge2_Store_Buy_Limit)

		return
	end

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.Rouge2_NormalStoreGoodsView, self.storeGoodsCo)
end

function Rouge2_StoreGoodsItem:updateInfo(storeGoodsCo)
	gohelper.setActive(self.go, true)

	self.storeGoodsCo = storeGoodsCo

	self:refreshRemainBuyCount()

	local productItemType, productItemId, productItemQuantity = self:getItemTypeIdQuantity(self.storeGoodsCo.value)
	local productItemConfig, productIconUrl = ItemModel.instance:getItemConfigAndIcon(productItemType, productItemId, true)
	local rare

	if not productItemConfig.rare then
		logWarn("material type : %s, material id : %s not had rare attribute")

		rare = 5
	else
		rare = productItemConfig.rare
	end

	UISpriteSetMgr.instance:setV2a7MainActivitySprite(self.imageRare, "v2a7_store_quality_" .. rare)
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
	self.costItemType = MaterialEnum.MaterialType.Currency
	self.costItemId = CurrencyEnum.CurrencyType.V3a2Rouge
	self.costItemQuantity = self.storeGoodsCo.num
	self.txtCost.text = self.costItemQuantity

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costItemType, self.costItemId)

	if self.costItemType == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self.imageCoin, costCo.icon .. "_1")
	else
		self.simageCoin:LoadImage(costIconUrl)
	end

	self:refreshTag()

	local stageConfigId = Rouge2_StoreModel.instance:getCurStageId()
	local config = Rouge2_OutSideConfig.instance:getRewardStageConfigById(stageConfigId)

	if config == nil then
		logError("Rouge2 Store stageConfig is nil stageId" .. stageConfigId)
	end

	self.stageConfig = config
end

function Rouge2_StoreGoodsItem:refreshRemainBuyCount()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999

		local curStageId = Rouge2_StoreModel.instance:getCurStageId()
		local isBuyLimit = not Rouge2_StoreModel.instance:isStoreAllClaimed(curStageId)

		gohelper.setActive(self.go_LevelLimit, isBuyLimit)

		if isBuyLimit then
			self.txt_LevelLimit.text = luaLang("v3a9_rouge2_buy_limit_tip")
		end
	else
		gohelper.setActive(self.go_LevelLimit, false)
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self.storeGoodsCo.maxBuyCount - Rouge2_StoreModel.instance:getGoodsBuyCount(self.storeGoodsCo.id)
		self.txtLimitBuy.text = formatLuaLang("v1a4_bossrush_storeview_buylimit", self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function Rouge2_StoreGoodsItem:refreshTag()
	if self.storeGoodsCo.tag == nil or self.storeGoodsCo.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)

	self.txtTag.text = ActivityStoreConfig.instance:getTagName(self.storeGoodsCo.tag)
end

function Rouge2_StoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function Rouge2_StoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function Rouge2_StoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

return Rouge2_StoreGoodsItem
