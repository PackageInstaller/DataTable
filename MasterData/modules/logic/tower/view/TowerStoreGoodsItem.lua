-- chunkname: @modules/logic/tower/view/TowerStoreGoodsItem.lua

module("modules.logic.tower.view.TowerStoreGoodsItem", package.seeall)

local TowerStoreGoodsItem = class("TowerStoreGoodsItem", UserDataDispose)

function TowerStoreGoodsItem:onInitView(go)
	self:__onInit()

	self.go = go
	self.goTag = gohelper.findChild(self.go, "go_tag")
	self.txtLimitBuy = gohelper.findChildText(self.go, "layout/txt_limitbuy")
	self.imageRare = gohelper.findChildImage(self.go, "image_rare")
	self.goMaxRareEffect = gohelper.findChild(self.go, "eff_rare5")
	self.simageIcon = gohelper.findChildSingleImage(self.go, "goIcon/simage_icon")
	self.imageIcon = gohelper.findChildImage(self.go, "goIcon/simage_icon")
	self.goQuantity = gohelper.findChild(self.go, "quantity")
	self.txtQuantity = gohelper.findChildText(self.go, "quantity/bg/txt_quantity")
	self.txtCost = gohelper.findChildText(self.go, "txt_cost")
	self.simageCoin = gohelper.findChildSingleImage(self.go, "txt_cost/simage_coin")
	self.imageCoin = gohelper.findChildImage(self.go, "txt_cost/simage_coin")
	self.goSoldout = gohelper.findChild(self.go, "go_soldout")
	self.goClick = gohelper.findChildButtonWithAudio(self.go, "goClick")
	self.reddot = gohelper.findChild(self.go, "#go_reddot")

	self.goClick:AddClickListener(self.onClick, self)
end

function TowerStoreGoodsItem:onClick()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Common_Click)

	if self.remainBuyCount <= 0 then
		GameFacade.showToast(ToastEnum.ActivityNoRemainBuyCount)

		return
	end

	ViewMgr.instance:openView(ViewName.NormalStoreGoodsView, self._mo)
	TowerController.instance:dispatchEvent(TowerEvent.OnHandleInStoreView)
	self:clearNewTag()
end

function TowerStoreGoodsItem:updateInfo(mo)
	gohelper.setActive(self.go, true)

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

	self.txtName = gohelper.findChildText(self.go, "layout/txt_name")

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

function TowerStoreGoodsItem:refreshRemainBuyCount()
	if self._co.maxBuyCount == 0 then
		gohelper.setActive(self.txtLimitBuy.gameObject, false)
		gohelper.setActive(self.goSoldout, false)

		self.remainBuyCount = 9999
	else
		gohelper.setActive(self.txtLimitBuy.gameObject, true)

		self.remainBuyCount = self._co.maxBuyCount - self._mo.buyCount
		self.txtLimitBuy.text = string.format(luaLang("v1a4_bossrush_storeview_buylimit"), self.remainBuyCount)

		gohelper.setActive(self.goSoldout, self.remainBuyCount <= 0)
	end
end

function TowerStoreGoodsItem:refreshTag()
	if self._co.tag == 0 or self.remainBuyCount <= 0 then
		gohelper.setActive(self.goTag, false)

		return
	end

	gohelper.setActive(self.goTag, true)
end

function TowerStoreGoodsItem:getItemTypeIdQuantity(coStr)
	local attribute = string.splitToNumber(coStr, "#")

	return attribute[1], attribute[2], attribute[3]
end

function TowerStoreGoodsItem:hide()
	gohelper.setActive(self.go, false)
end

function TowerStoreGoodsItem:onDestroy()
	self.goClick:RemoveClickListener()
	self.simageIcon:UnLoadImage()
	self.simageCoin:UnLoadImage()
	self:__onDispose()
end

function TowerStoreGoodsItem:updateNewData(newTagData)
	local _isNew = newTagData and newTagData.isNew

	gohelper.setActive(self.reddot, _isNew)
end

function TowerStoreGoodsItem:clearNewTag()
	TowerStoreModel.instance:onClickGoodsItem(self._mo.belongStoreId, self._mo.goodsId)
	gohelper.setActive(self.reddot, false)
end

return TowerStoreGoodsItem
