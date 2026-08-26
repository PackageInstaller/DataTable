-- chunkname: @modules/logic/versionactivity1_5/dungeon/view/store/VersionActivity1_5NormalStoreGoodsView.lua

module("modules.logic.versionactivity1_5.dungeon.view.store.VersionActivity1_5NormalStoreGoodsView", package.seeall)

local VersionActivity1_5NormalStoreGoodsView = class("VersionActivity1_5NormalStoreGoodsView", BaseView)

function VersionActivity1_5NormalStoreGoodsView:onInitView()
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_rightbg")
	self._goremain = gohelper.findChild(self.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	self._txtremain = gohelper.findChildText(self.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	self._gounique = gohelper.findChild(self.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	self._goIcon = gohelper.findChild(self.viewGO, "root/propinfo/goIcon")
	self._simageicon = gohelper.findChildSingleImage(self._goIcon, "#simage_icon")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "root/propinfo/#txt_goodsNameCn")
	self._txtgoodsUseDesc = gohelper.findChildText(self.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtgoodsDesc = gohelper.findChildText(self.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/propinfo/#btn_click")
	self._goitem = gohelper.findChild(self.viewGO, "root/propinfo/group/#go_item")
	self._txtitemcount = gohelper.findChildText(self.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	self._gogoodsHavebg = gohelper.findChild(self.viewGO, "root/propinfo/group/#go_goodsHavebg")
	self._txtgoodsHave = gohelper.findChildText(self.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	self._gobuy = gohelper.findChild(self.viewGO, "root/#go_buy")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "root/#go_buy/#go_buynormal/valuebg/#input_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost")
	self._txtsalePrice = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost/#txt_salePrice")
	self._simagecosticon = gohelper.findChildSingleImage(self.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "root/#go_tips/#txt_locktips")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function VersionActivity1_5NormalStoreGoodsView:addEvents()
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._inputvalue:AddOnEndEdit(self._onEndEdit, self)
end

function VersionActivity1_5NormalStoreGoodsView:removeEvents()
	self._btnclick:RemoveClickListener()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._inputvalue:RemoveOnEndEdit()
end

function VersionActivity1_5NormalStoreGoodsView:_onEndEdit(value)
	local buyCount = tonumber(value)

	buyCount = buyCount and math.floor(buyCount)

	if not buyCount or buyCount < 1 then
		self.currentBuyCount = 1

		self:refreshByCount()
		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)

		return
	end

	if buyCount > self.maxBuyCount then
		self.currentBuyCount = math.max(self.maxBuyCount, 1)

		self:refreshByCount()

		return
	end

	self.currentBuyCount = buyCount

	self:refreshByCount()
end

function VersionActivity1_5NormalStoreGoodsView:_btnclickOnClick()
	MaterialTipController.instance:showMaterialInfo(self.itemType, self.itemId)
end

function VersionActivity1_5NormalStoreGoodsView:_btnminOnClick()
	self.currentBuyCount = 1

	self:refreshByCount()
end

function VersionActivity1_5NormalStoreGoodsView:_btnsubOnClick()
	if self.currentBuyCount <= 1 then
		return
	end

	self.currentBuyCount = self.currentBuyCount - 1

	self:refreshByCount()
end

function VersionActivity1_5NormalStoreGoodsView:_btnaddOnClick()
	if self.storeGoodsCo.maxBuyCount ~= 0 and self.currentBuyCount >= self.remainBuyCount then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)

		return
	end

	if self.currentBuyCount >= self.maxBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, self.costName)

		return
	end

	self.currentBuyCount = self.currentBuyCount + 1

	self:refreshByCount()
end

function VersionActivity1_5NormalStoreGoodsView:_btnmaxOnClick()
	self.currentBuyCount = math.max(self.maxBuyCount, 1)

	self:refreshByCount()
end

function VersionActivity1_5NormalStoreGoodsView:_btnbuyOnClick()
	if self.currentBuyCount > self.maxBuyCount then
		GameFacade.showToast(ToastEnum.DiamondBuy, self.costName)

		return
	end

	Activity107Rpc.instance:sendBuy107GoodsRequest(self.storeGoodsCo.activityId, self.storeGoodsCo.id, self.currentBuyCount)
end

function VersionActivity1_5NormalStoreGoodsView:_btncloseOnClick()
	self:closeThis()
end

function VersionActivity1_5NormalStoreGoodsView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._imagecosticon = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")

	gohelper.setActive(self._gotips, false)
	gohelper.setActive(self._gobuy, true)
	gohelper.addUIClickAudio(self._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	self.addEventCb(self, VersionActivityController.instance, VersionActivityEvent.OnBuy107GoodsSuccess, self.onBuyGoodsSuccess, self)
end

function VersionActivity1_5NormalStoreGoodsView:onUpdateParam()
	return
end

function VersionActivity1_5NormalStoreGoodsView:onOpen()
	self.storeGoodsCo = self.viewParam

	local itemParam = string.splitToNumber(self.storeGoodsCo.product, "#")

	self.itemType = itemParam[1]
	self.itemId = itemParam[2]
	self.oneItemCount = itemParam[3]

	local costs = string.split(self.storeGoodsCo.cost, "#")

	self.costType = costs[1]
	self.costId = costs[2]
	self.oneCostQuantity = tonumber(costs[3])
	self.hadQuantity = ItemModel.instance:getItemQuantity(self.costType, self.costId)

	local costCo = ItemModel.instance:getItemConfig(self.costType, self.costId)

	if costCo then
		self.costName = costCo.name or ""
	end

	self.maxBuyCount = math.floor(self.hadQuantity / self.oneCostQuantity)
	self.remainBuyCount = self.storeGoodsCo.maxBuyCount - ActivityStoreModel.instance:getActivityGoodsBuyCount(self.storeGoodsCo.activityId, self.storeGoodsCo.id)

	if self.storeGoodsCo.maxBuyCount ~= 0 then
		self.maxBuyCount = math.min(self.maxBuyCount, self.remainBuyCount)
	end

	self.currentBuyCount = 1

	self:refreshUI()
end

function VersionActivity1_5NormalStoreGoodsView:refreshUI()
	local itemCo, itemIcon = ItemModel.instance:getItemConfigAndIcon(self.itemType, self.itemId)

	self._txtgoodsNameCn.text = itemCo.name
	self._txtgoodsDesc.text = itemCo.desc
	self._txtgoodsUseDesc.text = itemCo.useDesc

	if tonumber(self.itemType) == MaterialEnum.MaterialType.Equip then
		itemIcon = ResUrl.getEquipSuit(itemCo.icon)
	end

	if itemCo.subType == ItemEnum.SubType.Portrait then
		gohelper.setActive(self._simageicon.gameObject, false)

		self.headIconItem = self.headIconItem or IconMgr.instance:getCommonHeadIcon(self._goIcon)

		self.headIconItem:setItemId(itemCo.id)
	else
		gohelper.setActive(self._simageicon.gameObject, true)
		self._simageicon:LoadImage(itemIcon)

		if self.headIconItem then
			self.headIconItem:setVisible(false)
		end
	end

	self._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(self.itemType, self.itemId)))

	self:refreshByCount()
	self:refreshRemain()
	self:refreshGoUnique()
end

function VersionActivity1_5NormalStoreGoodsView:refreshByCount()
	self._inputvalue:SetText(tostring(self.currentBuyCount))

	self._txtitemcount.text = string.format("x%s", GameUtil.numberDisplay(self.oneItemCount * self.currentBuyCount))

	local cost = self.oneCostQuantity * self.currentBuyCount

	self._txtsalePrice.text = cost > self.hadQuantity and string.format("<color=#BF2E11>%s</color>", cost) or string.format("%s", cost)

	local costCo, costIconUrl = ItemModel.instance:getItemConfigAndIcon(self.costType, self.costId)

	if tonumber(self.costType) == MaterialEnum.MaterialType.Currency then
		UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, costCo.icon .. "_1")
	else
		self._simagecosticon:LoadImage(costIconUrl)
	end
end

function VersionActivity1_5NormalStoreGoodsView:refreshRemain()
	if self.storeGoodsCo.maxBuyCount == 0 then
		gohelper.setActive(self._goRemain, false)
	else
		gohelper.setActive(self._goRemain, true)

		self._txtremain.text = string.format("%s:%d", luaLang("store_buylimit"), self.remainBuyCount)
	end
end

function VersionActivity1_5NormalStoreGoodsView:refreshGoUnique()
	gohelper.setActive(self._gounique, ItemConfig.instance:isUniqueById(self.itemType, self.itemId))
end

function VersionActivity1_5NormalStoreGoodsView:onBuyGoodsSuccess()
	self:closeThis()
end

function VersionActivity1_5NormalStoreGoodsView:onClose()
	AudioMgr.instance:trigger(AudioEnum.UI.UI_Mail_switch)
end

function VersionActivity1_5NormalStoreGoodsView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
	self._simageicon:UnLoadImage()
	self._simagecosticon:UnLoadImage()
end

return VersionActivity1_5NormalStoreGoodsView
