-- chunkname: @modules/logic/store/view/NormalStoreGoodsView.lua

module("modules.logic.store.view.NormalStoreGoodsView", package.seeall)

local NormalStoreGoodsView = class("NormalStoreGoodsView", BaseView)

function NormalStoreGoodsView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "#simage_blur")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_leftbg")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "root/#simage_rightbg")
	self._simageicon = gohelper.findChildSingleImage(self.viewGO, "root/propinfo/goIcon/#simage_icon")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buynormal/cost/#simage_costicon")
	self._txtoriginalCost = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost")
	self._txtsalePrice = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buynormal/cost/#txt_originalCost/#txt_salePrice")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "root/propinfo/#txt_goodsNameCn")
	self._txtgoodsNameEn = gohelper.findChildText(self.viewGO, "root/propinfo/#txt_goodsNameEn")
	self._trsgoodsDesc = gohelper.findChild(self.viewGO, "root/propinfo/info/goodsDesc").transform
	self._txtgoodsDesc = gohelper.findChildText(self.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._txtgoodsUseDesc = gohelper.findChildText(self.viewGO, "root/propinfo/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtgoodsHave = gohelper.findChildText(self.viewGO, "root/propinfo/group/#go_goodsHavebg/bg/#txt_goodsHave")
	self._goitem = gohelper.findChild(self.viewGO, "root/propinfo/group/#go_item")
	self._txtitemcount = gohelper.findChildText(self.viewGO, "root/propinfo/group/#go_item/#txt_itemcount")
	self._txtvalue = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buynormal/valuebg/#txt_value")
	self._btnmin = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_min")
	self._btnsub = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_sub")
	self._btnadd = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_add")
	self._btnmax = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buynormal/#btn_max")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#btn_buy")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_close")
	self._trsinfo = gohelper.findChild(self.viewGO, "root/propinfo/info").transform
	self._goremain = gohelper.findChild(self.viewGO, "root/propinfo/info/#go_goodsheader/remain")
	self._txtremain = gohelper.findChildText(self.viewGO, "root/propinfo/info/#go_goodsheader/remain/#txt_remain")
	self._goLimit = gohelper.findChild(self.viewGO, "root/propinfo/info/#go_goodsheader/#go_Limit")
	self._gounique = gohelper.findChild(self.viewGO, "root/propinfo/info/#go_goodsheader/go_unique")
	self._inputvalue = gohelper.findChildTextMeshInputField(self.viewGO, "root/#go_buy/#go_buynormal/valuebg/#input_value")
	self._btnclick = gohelper.findChildButtonWithAudio(self.viewGO, "root/propinfo/#btn_click")
	self._gogoodsHavebg = gohelper.findChild(self.viewGO, "root/propinfo/group/#go_goodsHavebg")
	self._gobuy = gohelper.findChild(self.viewGO, "root/#go_buy")
	self._gobuynormal = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buynormal")
	self._gobuycost2 = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buycost2")
	self._gotips = gohelper.findChild(self.viewGO, "root/#go_tips")
	self._txtlocktips = gohelper.findChildText(self.viewGO, "root/#go_tips/#txt_locktips")
	self._goinclude = gohelper.findChild(self.viewGO, "root/#go_include")
	self._txtsalePrice2 = gohelper.findChildText(self.viewGO, "root/#go_include/cost/#txt_salePrice")
	self._imagecosticon2 = gohelper.findChildImage(self.viewGO, "root/#go_include/cost/#simage_costicon")
	self._btnbuy2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_include/#btn_buy")
	self._btncost1 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1")
	self._gounselect1 = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect")
	self._imageiconunselect1 = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/icon/simage_icon")
	self._txtcurpriceunselect1 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/txt_Num")
	self._txtoriginalpriceunselect1 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/unselect/#txt_original_price")
	self._goselect1 = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select")
	self._imageiconselect1 = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/icon/simage_icon")
	self._txtcurpriceselect1 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/txt_Num")
	self._txtoriginalpriceselect1 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost1/select/#txt_original_price")
	self._btncost2 = gohelper.findChildButtonWithAudio(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2")
	self._gounselect2 = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect")
	self._imageiconunselect2 = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/icon/simage_icon")
	self._txtcurpriceunselect2 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/txt_Num")
	self._txtoriginalpriceunselect2 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/unselect/#txt_original_price")
	self._goselect2 = gohelper.findChild(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select")
	self._imageiconselect2 = gohelper.findChildImage(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/icon/simage_icon")
	self._txtcurpriceselect2 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/txt_Num")
	self._txtoriginalpriceselect2 = gohelper.findChildText(self.viewGO, "root/#go_buy/#go_buycost2/#btn_cost2/select/#txt_original_price")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function NormalStoreGoodsView:addEvents()
	self._btnmin:AddClickListener(self._btnminOnClick, self)
	self._btnsub:AddClickListener(self._btnsubOnClick, self)
	self._btnadd:AddClickListener(self._btnaddOnClick, self)
	self._btnmax:AddClickListener(self._btnmaxOnClick, self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btnbuy2:AddClickListener(self._btnbuyOnClick, self)
	self._btnclose:AddClickListener(self._btnCloseOnClick, self)
	self._inputvalue:AddOnEndEdit(self._onEndEdit, self)
	self._inputvalue:AddOnValueChanged(self._onValueChanged, self)
	self._btnclick:AddClickListener(self._btnclickOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
end

function NormalStoreGoodsView:removeEvents()
	self._btnmin:RemoveClickListener()
	self._btnsub:RemoveClickListener()
	self._btnadd:RemoveClickListener()
	self._btnmax:RemoveClickListener()
	self._btnbuy:RemoveClickListener()
	self._btnbuy2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._inputvalue:RemoveOnEndEdit()
	self._inputvalue:RemoveOnValueChanged()
	self._btnclick:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
end

function NormalStoreGoodsView:_btnclickOnClick()
	MaterialTipController.instance:showMaterialInfo(self._itemType, self._itemId)
end

function NormalStoreGoodsView:_btnminOnClick()
	self._buyCount = 1

	self:_refreshBuyCount()
	self:_refreshGoods(self.goodsConfig)
end

function NormalStoreGoodsView:_btnsubOnClick()
	if self._buyCount <= 1 then
		return
	else
		self._buyCount = self._buyCount - 1

		self:_refreshBuyCount()
		self:_refreshGoods(self.goodsConfig)
	end
end

function NormalStoreGoodsView:_btnaddOnClick()
	if self._buyCount + 1 > self._maxBuyCount then
		self:_buyCountAddToast()

		return
	else
		self._buyCount = self._buyCount + 1

		self:_refreshBuyCount()
		self:_refreshGoods(self.goodsConfig)
	end
end

function NormalStoreGoodsView:_btnmaxOnClick()
	self._buyCount = math.max(self._maxBuyCount, 1)

	if self._buyCount > self._maxBuyCount then
		self:_buyCountAddToast()
	end

	self:_refreshBuyCount()
	self:_refreshGoods(self.goodsConfig)
end

function NormalStoreGoodsView:_btnCloseOnClick()
	self:closeThis()
end

function NormalStoreGoodsView:_btncost1OnClick()
	self:_btncostOnClick(1)
end

function NormalStoreGoodsView:_btncost2OnClick()
	self:_btncostOnClick(2)
end

function NormalStoreGoodsView:_btncostOnClick(index)
	if not self:_isBuyCost2() or self._buyCost2Index == index then
		return
	end

	self:_setBuyCost2(index)
end

function NormalStoreGoodsView:_onEndEdit(inputStr)
	local buyCount = tonumber(inputStr)

	buyCount = buyCount and math.floor(buyCount)

	if not buyCount or buyCount <= 0 then
		buyCount = 1

		GameFacade.showToast(ToastEnum.VersionActivityNormalStoreNoGoods)
	end

	if buyCount > self._maxBuyCount then
		self:_buyCountAddToast()
	end

	self._buyCount = math.max(math.min(buyCount, self._maxBuyCount), 1)

	self:_refreshBuyCount()
	self:_refreshGoods(self.goodsConfig)
end

function NormalStoreGoodsView:_onValueChanged(inputStr)
	return
end

function NormalStoreGoodsView:_btnbuyOnClick()
	local buildingSkinCo = RoomConfig.instance:getBuildingSkinCoByItemId(self._itemId)

	if buildingSkinCo and not self:_isHasBuiding(buildingSkinCo) then
		GameFacade.showMessageBox(MessageBoxIdDefine.RoomBuldingStoreBuy, MsgBoxEnum.BoxType.Yes_No, self._tryBuyGoods, nil, nil, self, nil, nil)

		return
	end

	if (self._itemType == MaterialEnum.MaterialType.Hero or nil) and CharacterModel.instance:isHeroFullDuplicateCount(self._itemId) then
		local duplicateItem2 = HeroConfig.instance:getHeroCO(self._itemId).duplicateItem2
		local arr = GameUtil.splitString2(duplicateItem2, true)
		local itemConfig = ItemConfig.instance:getItemConfig(arr[1][1], arr[1][2])

		MessageBoxController.instance:showMsgBox(MessageBoxIdDefine.HeroFullDuplicateCount, MsgBoxEnum.BoxType.Yes_No, self._tryBuyGoods, nil, nil, self, nil, nil, itemConfig.name)
	else
		self:_tryBuyGoods()
	end
end

function NormalStoreGoodsView:_isHasBuiding(buildingSkinCo)
	local buildingInfos = RoomModel.instance:getBuildingInfoList()

	if buildingInfos then
		for _, mo in ipairs(buildingInfos) do
			if buildingSkinCo.buildingId == mo.buildingId then
				return true
			end
		end
	end
end

function NormalStoreGoodsView:_tryBuyGoods()
	if self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		local cost = self._mo:getCost(self._buyCount)

		if CurrencyController.instance:checkFreeDiamondEnough(cost, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._buyGoods, self, self.closeThis, self) then
			self:_buyGoods()
		end
	elseif self._buyCount > self._maxBuyCount then
		self:_buyCountAddToast()
	elseif self._buyCount > 0 then
		self:_buyGoods()
	end
end

function NormalStoreGoodsView:_buyGoods()
	StoreController.instance:buyGoods(self._mo, self._buyCount, self._buyCallback, self, self._buyCost2Index)
end

function NormalStoreGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function NormalStoreGoodsView:_editableInitView()
	self._simageleftbg:LoadImage(ResUrl.getCommonIcon("bg_1"))
	self._simagerightbg:LoadImage(ResUrl.getCommonIcon("bg_2"))

	self._buyCount = 1
	self._maxBuyCount = 1

	gohelper.addUIClickAudio(self._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)

	self._goincludeContent = gohelper.findChild(self._goinclude, "#scroll_product/viewport/content")
	self._contentHorizontal = self._goincludeContent:GetComponent(typeof(UnityEngine.UI.HorizontalLayoutGroup))
	self._iconItemList = {}
end

function NormalStoreGoodsView:_refreshBuyCount()
	local costQuantity = self._mo:getCost(self._buyCount)

	self._txtsalePrice.text = costQuantity == 0 and luaLang("store_free") or tostring(costQuantity)
	self._txtsalePrice2.text = self._txtsalePrice.text

	self._inputvalue:SetText(tostring(self._buyCount))

	local canAffordQuantity = self._mo:canAffordQuantity()

	if canAffordQuantity == -1 or canAffordQuantity >= self._buyCount then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtsalePrice, "#393939")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtsalePrice2, "#393939")
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtsalePrice, "#bf2e11")
		SLFramework.UGUI.GuiHelper.SetColor(self._txtsalePrice2, "#bf2e11")
	end

	self._txtoriginalCost.text = ""
end

function NormalStoreGoodsView:ShowLockTips()
	local episodeId = StoreConfig.instance:getGoodsConfig(self._mo.goodsId).needEpisodeId

	if episodeId == StoreEnum.Need4RDEpisodeId then
		self._txtlocktips.text = string.format("%s%s", luaLang("dungeon_unlock_4RD"), luaLang("dungeon_unlock"))
	else
		local lvlimitchapter = self._mo.lvlimitchapter
		local lvlimitepisode = self._mo.lvlimitepisode

		self._txtlocktips.text = string.format(luaLang((self._mo.isHardChapter or nil) and "dungeon_unlock_episode_hard"), string.format("%s-%s", lvlimitchapter, lvlimitepisode))
	end
end

function NormalStoreGoodsView:_refreshUI()
	self.goodsConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)

	local items = string.splitToNumber(self.goodsConfig.product, "#")
	local itemType = items[1]
	local itemId = items[2]

	self._txtgoodsNameCn.text = ItemModel.instance:getItemConfig(itemType, itemId).name

	gohelper.setActive(self._txtgoodsDesc.gameObject, true)
	gohelper.setActive(self._txtgoodsUseDesc.gameObject, true)

	local isCost2 = self:_isBuyCost2()

	if isCost2 then
		if not self.costParam then
			self:_setBuyCost2Btn()
		end

		local costIds = {}
		local cost1 = string.splitToNumber(self.goodsConfig.cost, "#")
		local cost2 = string.splitToNumber(self.goodsConfig.cost2, "#")

		table.insert(costIds, cost2[2])
		table.insert(costIds, cost1[2])
		self.viewContainer:setCurrencyTypes(costIds)
	end

	gohelper.setActive(self._gobuy, self:_isStoreItemUnlock())
	gohelper.setActive(self._gotips, not self:_isStoreItemUnlock())
	gohelper.setActive(self._gobuynormal, not isCost2)
	gohelper.setActive(self._gobuycost2, isCost2)

	if not self:_isStoreItemUnlock() then
		self:ShowLockTips()
	end

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(self._mo.goodsId) then
		gohelper.setActive(self._gobuy, false)
		gohelper.setActive(self._gotips, true)

		self._txtlocktips.text = string.format(luaLang("weekwalk_layer_unlock"), self._mo.limitWeekWalkLayer)
	end

	self:_refreshGoods(self.goodsConfig)

	local isSpecial = false

	self._txtgoodsDesc.text = self._itemType == MaterialEnum.MaterialType.Hero and ItemModel.instance:getItemConfig(items[1], items[2]).desc2 or ItemModel.instance:getItemConfig(items[1], items[2]).desc
	self._txtgoodsUseDesc.text = ItemModel.instance:getItemConfig(items[1], items[2]).useDesc

	local cost = self.goodsConfig.cost

	if string.nilorempty(cost) then
		self._costType, self._costId = nil

		gohelper.setActive(self._imagecosticon.gameObject, false)
		gohelper.setActive(self._imagecosticon2.gameObject, false)
	else
		local costs = string.split(cost, "|")

		isSpecial = #costs > 1

		if not costs[self._mo.buyCount + 1] then
			local costParam = costs[#costs]
			local costInfo = string.split(costParam, "#")

			self._costType = tonumber(costInfo[1])
			self._costId = tonumber(costInfo[2])

			local costConfig, costIcon = ItemModel.instance:getItemConfigAndIcon(self._costType, self._costId)
			local id = costConfig.icon
			local str = string.format("%s_1", id)

			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, str)
			UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon2, str)
			gohelper.setActive(self._imagecosticon.gameObject, true)

			if not isCost2 then
				self.viewContainer:setCurrencyType(self._costId)
			end
		end
	end

	local maxBuyCount = self.goodsConfig.maxBuyCount
	local remain = maxBuyCount - self._mo.buyCount

	if isSpecial then
		self._txtremain.text = luaLang("store_multi_one")

		gohelper.setActive(self._goremain, true)
		gohelper.setActive(self._txtremain.gameObject, true)
	else
		local content = StoreConfig.instance:getRemain(self.goodsConfig, remain, self._mo.offlineTime)

		if string.nilorempty(content) then
			gohelper.setActive(self._goremain, false)
			gohelper.setActive(self._txtremain.gameObject, false)

			local infoHeight = recthelper.getHeight(self._trsinfo)

			recthelper.setHeight(self._trsgoodsDesc, infoHeight)
		else
			gohelper.setActive(self._goremain, true)
			gohelper.setActive(self._txtremain.gameObject, true)

			self._txtremain.text = content
		end
	end

	self._buyCount = 1

	self:_refreshBuyCount()
	self:_refreshInclude()
	self:_refreshGoUnique()
	self:_refreshLimitTag()
end

function NormalStoreGoodsView:_refreshGoUnique()
	gohelper.setActive(self._gounique, false)
end

function NormalStoreGoodsView:_refreshInclude()
	if not self:_isStoreItemUnlock() then
		return
	end

	local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)
	local showInclude = MaterialTipController.instance:isSpecifiedGift(itemConfig) or MaterialTipController.instance:isBpCustomSelect(itemConfig)

	if not showInclude then
		return
	end

	local includetype

	gohelper.setActive(self._gobuy, false)
	gohelper.setActive(self._goinclude, true)
	gohelper.setActive(self._txtgoodsDesc.gameObject, false)
	gohelper.setActive(self._txtgoodsUseDesc.gameObject, true)

	local count = 0

	if showInclude then
		local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)
		local includeItems = GameUtil.splitString2(itemConfig.effect, true)

		count = #includeItems

		for i, itemco in ipairs(includeItems) do
			local itemIcon = self._iconItemList[i]
			local itemtype = itemco[1]
			local itemid = itemco[2]
			local itemnum = itemco[3]

			local function callback()
				MaterialTipController.instance:showMaterialInfo(itemtype, itemid)
			end

			if itemIcon == nil then
				if itemtype == MaterialEnum.MaterialType.Equip then
					itemIcon = IconMgr.instance:getCommonEquipIcon(self._goincludeContent)

					itemIcon:setMOValue(itemtype, itemid, itemnum, nil, true)
					itemIcon:hideLv(true)
					itemIcon:customClick(callback)

					includetype = itemtype
				else
					itemIcon = IconMgr.instance:getCommonItemIcon(self._goincludeContent)

					itemIcon:setMOValue(itemtype, itemid, itemnum, nil, true)

					includetype = itemtype
				end

				table.insert(self._iconItemList, itemIcon)
			end
		end
	end

	if includetype == MaterialEnum.MaterialType.Equip then
		self._contentHorizontal.spacing = 6.62
		self._contentHorizontal.padding.left = -2
		self._contentHorizontal.padding.top = 10
	end

	for i = count + 1, #self._iconItemList do
		gohelper.setActive(self._iconItemList[i].go, false)
	end
end

function NormalStoreGoodsView:_refreshGoods(goodsConfig)
	local product = goodsConfig.product
	local productInfo = string.split(product, "#")

	self._itemType = tonumber(productInfo[1])
	self._itemId = tonumber(productInfo[2])
	self._itemQuantity = tonumber(productInfo[3])

	gohelper.setActive(self._goitem, true)

	self._txtitemcount.text = string.format("%s%s", luaLang("multiple"), GameUtil.numberDisplay(self._itemQuantity * self._buyCount))

	local itemConfig, itemIcon = ItemModel.instance:getItemConfigAndIcon(self._itemType, self._itemId, true)

	self._itemSubType = itemConfig.subType

	local var_27_0

	if tonumber(self._itemType) == MaterialEnum.MaterialType.Equip then
		itemIcon = ResUrl.getEquipSuit(itemConfig.icon)
		var_27_0 = false and function()
			self._simageicon.gameObject:GetComponent(gohelper.Type_Image):SetNativeSize()
		end or nil
	end

	self._simageicon:LoadImage(itemIcon, var_27_0)
	gohelper.setActive(self._gogoodsHavebg, true)

	self._txtgoodsHave.text = string.format("%s", GameUtil.numberDisplay(ItemModel.instance:getItemQuantity(self._itemType, self._itemId)))
end

function NormalStoreGoodsView:_refreshLimitTag()
	local items = string.splitToNumber(self.goodsConfig.product, "#")
	local itemType = items[1]
	local itemId = items[2]

	gohelper.setActive(self._goLimit, (itemType == MaterialEnum.MaterialType.Equip or nil) and EquipModel.instance:isLimit(itemId))
end

function NormalStoreGoodsView:_buyCountAddToast()
	local maxBuyCount, limitType

	if self._buyCost2Index == 2 then
		maxBuyCount, limitType = self._mo:getBuyMaxQuantityByCost2()
	else
		maxBuyCount, limitType = self._mo:getBuyMaxQuantity()
	end

	if self._buyCount + 1 >= CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount) or limitType == StoreEnum.LimitType.BuyLimit or limitType == StoreEnum.LimitType.Default then
		GameFacade.showToast(ToastEnum.StoreMaxBuyCount)
	elseif limitType == StoreEnum.LimitType.Currency then
		if self._costType and self._costId then
			local costConfig = ItemModel.instance:getItemConfig(self._costType, self._costId)

			GameFacade.showToast(ToastEnum.DiamondBuy, costConfig.name)
		end
	elseif limitType == StoreEnum.LimitType.CurrencyChanged then
		GameFacade.showToast(ToastEnum.CurrencyChanged)
	end
end

function NormalStoreGoodsView:_refreshMaxBuyCount()
	self._maxBuyCount = self._mo:getBuyMaxQuantity()

	local storeMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if storeMaxBuyCount < self._maxBuyCount or self._maxBuyCount == -1 then
		self._maxBuyCount = storeMaxBuyCount
	end
end

function NormalStoreGoodsView:_refreshMaxBuyCountByCost2()
	self._maxBuyCount = self._mo:getBuyMaxQuantityByCost2()

	local storeMaxBuyCount = CommonConfig.instance:getConstNum(ConstEnum.StoreMaxBuyCount)

	if storeMaxBuyCount < self._maxBuyCount or self._maxBuyCount == -1 then
		self._maxBuyCount = storeMaxBuyCount
	end
end

function NormalStoreGoodsView:onOpen()
	self._mo = self.viewParam

	self:_refreshMaxBuyCount()
	self:_refreshUI()

	local goodsConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)

	StoreController.instance:statOpenGoods(self._mo.belongStoreId, goodsConfig)

	local isCost2 = self:_isBuyCost2()

	if isCost2 then
		self:_setBuyCost2(1)
	end
end

function NormalStoreGoodsView:_isStoreItemUnlock()
	local episodeId = StoreConfig.instance:getGoodsConfig(self._mo.goodsId).needEpisodeId

	if StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(self._mo.goodsId) then
		return false
	end

	if not episodeId or episodeId == 0 then
		return true
	end

	if episodeId == StoreEnum.Need4RDEpisodeId then
		return false
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function NormalStoreGoodsView:_isBuyCost2()
	return not string.nilorempty(self.goodsConfig.cost2)
end

function NormalStoreGoodsView:_setBuyCost2(index)
	if not self.costParam or not self.costParam[index] then
		self:_setBuyCost2Btn()
	end

	self._buyCost2Index = index
	self._costType = self.costParam[index][1]
	self._costId = self.costParam[index][2]

	self:_refreshBuyCost2Btn()

	if index == 2 then
		self:_refreshMaxBuyCountByCost2()
	else
		self:_refreshMaxBuyCount()
	end
end

function NormalStoreGoodsView:_refreshBuyCost2Btn()
	gohelper.setActive(self._goselect1, self._buyCost2Index == 1)
	gohelper.setActive(self._goselect2, self._buyCost2Index == 2)
end

function NormalStoreGoodsView:_setBuyCost2Btn()
	self.costParam = {}

	local cost1 = string.splitToNumber(self.goodsConfig.cost, "#")
	local hadQuantity1 = ItemModel.instance:getItemQuantity(cost1[1], cost1[2])
	local co1 = ItemModel.instance:getItemConfigAndIcon(cost1[1], cost1[2])
	local color1 = "#393939"
	local color2 = "#bf2e11"

	if hadQuantity1 >= cost1[3] then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, color1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, color1)
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, color2)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, color2)
	end

	self._txtcurpriceunselect1.text = cost1[3]
	self._txtcurpriceselect1.text = cost1[3]

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect1, co1.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect1, co1.icon .. "_1", true)

	local cost2 = string.splitToNumber(self.goodsConfig.cost2, "#")
	local hadQuantity2 = ItemModel.instance:getItemQuantity(cost2[1], cost2[2])
	local co1 = ItemModel.instance:getItemConfigAndIcon(cost2[1], cost2[2])

	if hadQuantity2 >= cost2[3] then
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, color1)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, color1)
	else
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, color2)
		SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, color2)
	end

	self._txtcurpriceunselect2.text = cost2[3]
	self._txtcurpriceselect2.text = cost2[3]

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect2, co1.icon .. "_1", true)
	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect2, co1.icon .. "_1", true)

	self.costParam = {
		cost1,
		cost2
	}
end

function NormalStoreGoodsView:onClose()
	local goodsConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)

	StoreController.instance:statCloseGoods(goodsConfig)
end

function NormalStoreGoodsView:onUpdateParam()
	self._mo = self.viewParam

	self:_refreshMaxBuyCount()
	self:_refreshUI()
end

function NormalStoreGoodsView:onDestroyView()
	self._simageleftbg:UnLoadImage()
	self._simagerightbg:UnLoadImage()
end

return NormalStoreGoodsView
