-- chunkname: @modules/logic/mainsceneswitch/view/MainSceneSkinMaterialTipView2.lua

module("modules.logic.mainsceneswitch.view.MainSceneSkinMaterialTipView2", package.seeall)

local MainSceneSkinMaterialTipView2 = class("MainSceneSkinMaterialTipView2", MainSceneSkinMaterialTipView)

function MainSceneSkinMaterialTipView2:onInitView()
	self._gotop = gohelper.findChild(self.viewGO, "left/top")
	self._gotab1 = gohelper.findChild(self.viewGO, "left/top/#go_tab1")
	self._goselect = gohelper.findChild(self.viewGO, "left/top/#go_tab1/#go_select")
	self._txttab1 = gohelper.findChildText(self.viewGO, "left/top/#go_tab1/txt_tab1")
	self._txttab1_1 = gohelper.findChildText(self.viewGO, "left/top/#go_tab1/#go_select/txt_tab1")
	self._btntab1 = gohelper.findChildButtonWithAudio(self.viewGO, "left/top/#go_tab1/#btn_tab")
	self._godiscount = gohelper.findChild(self.viewGO, "left/top/#go_tab1/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "left/top/#go_tab1/#go_discount/#txt_discount")
	self._gotab2 = gohelper.findChild(self.viewGO, "left/top/#go_tab2")
	self._goselect2 = gohelper.findChild(self.viewGO, "left/top/#go_tab2/#go_select")
	self._txttab2 = gohelper.findChildText(self.viewGO, "left/top/#go_tab2/txt_tab2")
	self._txttab2_1 = gohelper.findChildText(self.viewGO, "left/top/#go_tab2/#go_select/txt_tab2")
	self._btntab2 = gohelper.findChildButtonWithAudio(self.viewGO, "left/top/#go_tab2/#btn_tab")
	self._gotips = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_tips")
	self._txtdiscounttips = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_tips/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "right/#go_buyContent/buy/#go_discount")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#go_discount/#txt_discount")
	self._simageSceneLogo = gohelper.findChildSingleImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._imageSceneLogo = gohelper.findChildImage(self.viewGO, "left/banner/#go_bannerContent/#go_roominfoItem/image_frame/#go_SceneLogo")
	self._txtcostnum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum")
	self._imagecosticon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#simage_costicon")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_costnum/#txt_original_price")
	self._gobuyContent = gohelper.findChild(self.viewGO, "right/#go_buyContent")
	self._goblockInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_blockInfoItem")
	self._scrollblockInfo = gohelper.findChildScrollRect(self.viewGO, "right/#go_buyContent/scroll_blockpackage")

	MainSceneSkinMaterialTipView2.super.onInitView(self)
end

function MainSceneSkinMaterialTipView2:addEvents()
	MainSceneSkinMaterialTipView2.super.addEvents(self)
	self._btntab1:AddClickListener(self._btntab1OnClick, self)
	self._btntab2:AddClickListener(self._btntab2OnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSelectCost, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshSelectCost, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function MainSceneSkinMaterialTipView2:removeEvents()
	MainSceneSkinMaterialTipView2.super.removeEvents(self)
	self._btntab1:RemoveClickListener()
	self._btntab2:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSelectCost, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshSelectCost, self)
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function MainSceneSkinMaterialTipView2:_btntab1OnClick()
	if self._selectTabIndex == 1 then
		return
	end

	self._selectTabIndex = 1
	self._goodsId = self._goodsIds[1]

	self:_refreshGoods()
	self.viewContainer:setGoodsTab(self._selectTabIndex)
end

function MainSceneSkinMaterialTipView2:_btntab2OnClick()
	if self._selectTabIndex == 2 then
		return
	end

	self._selectTabIndex = 2
	self._goodsId = self.viewParam.goodsId

	self:_refreshGoods()
	self.viewContainer:setGoodsTab(self._selectTabIndex)
end

function MainSceneSkinMaterialTipView2:_btninsightOnClick()
	local has, items = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	self._discountItems = items

	local isCanBuySceneUIPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()
	local goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)

	if goodsMo then
		if has and items and self._decorateConfig.subType ~= ItemEnum.SubType.SceneUIPackage and isCanBuySceneUIPackage then
			local co = ItemModel.instance:getItemConfig(items[1], items[2])

			GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip2, MsgBoxEnum.BoxType.Yes_No, self._checkDiscounnt, self.closeThis, nil, self, self, nil, (co or nil) and (co.name or ""), self._storeCo.name)
		else
			self:_checkDiscounnt()
		end
	else
		local storeId = StoreEnum.StoreId.DecorateStore
		local isOpenStore = StoreModel.instance:isTabOpen(storeId)

		if not isOpenStore then
			local storeConfig = StoreConfig.instance:getTabConfig(storeId)
			local openCo = OpenConfig.instance:getOpenCo(storeConfig.openId)

			if VersionValidator.instance:isInReviewing() then
				if not openCo.verifingEpisodeId then
					local episodeId = openCo.episodeId

					if episodeId and episodeId ~= 0 then
						local episodeDisplay = DungeonConfig.instance:getEpisodeDisplay(episodeId)

						GameFacade.showToast(ToastEnum.V3a4SceneUIPackageLockTip, episodeDisplay)
					end
				end
			end
		end
	end
end

function MainSceneSkinMaterialTipView2:_checkDiscounnt()
	if self._discountItems then
		if self._discountItems then
			local isCanClaim = DecorateStoreModel.instance:isCanClaimDiscountItem(self._discountItems)

			if not isCanClaim then
				self:_readyBuy()
			else
				local co = ItemModel.instance:getItemConfig(self._discountItems[1], self._discountItems[2])

				GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip1, MsgBoxEnum.BoxType.Yes_No, self._onJumpGetDiscountItemView, self._readyBuy, nil, self, self, nil, (co or nil) and (co.name or ""))
			end
		else
			self:_readyBuy()
		end
	end
end

function MainSceneSkinMaterialTipView2:_onJumpGetDiscountItemView()
	if self._discountItems[2] then
		if self._discountItems[2] then
			ActivityModel.instance:setTargetActivityCategoryId(self._discountItems[2])
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function MainSceneSkinMaterialTipView2:_readyBuy()
	local item = self._payItemTbList[self._selectCostIndex]
	local costParam = item.cost
	local costNum = self:_getCostNum()

	if costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(costNum, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._exchangeFinished, self, self.closeThis, self) then
			self:_buyGood()
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(costNum, self.closeThis, self) then
			self:_buyGood()
		end
	elseif costParam[1] == MaterialEnum.MaterialType.Currency and costParam[2] == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(costParam[2])

		if currencyMo then
			if costNum <= currencyMo.quantity then
				self:_buyGood()
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return
			end
		end
	elseif ItemModel.instance:goodsIsEnough(costParam[1], costParam[2], costNum) then
		self:_buyGood()
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self._storeCurrencyNotEnoughCallback, nil, nil, self, nil)
	end
end

function MainSceneSkinMaterialTipView2:_buyGood()
	local storeGoodsMO = StoreModel.instance:getGoodsMO(self._goodsId)

	if not storeGoodsMO then
		return
	end

	StoreController.instance:buyGoods(storeGoodsMO, 1, self._onBuyCallback, self, self._selectCostIndex)
end

function MainSceneSkinMaterialTipView2:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function MainSceneSkinMaterialTipView2:_exchangeFinished()
	self:_buyGood()
end

function MainSceneSkinMaterialTipView2:_onBuyCallback()
	self:closeThis()
end

function MainSceneSkinMaterialTipView2:onClickModalMask()
	self:closeThis()
end

function MainSceneSkinMaterialTipView2:_editableInitView()
	MainSceneSkinMaterialTipView2.super._editableInitView(self)

	self._payItemTbList = self:getUserDataTb_()
	self._infoItemTbList = self:getUserDataTb_()

	gohelper.setActive(self._gosource, false)
	gohelper.setActive(self._gobuyContent, true)
	gohelper.setActive(self._goblockInfoItem, false)

	self._goodsIds = DecorateStoreModel.instance:getV3a4PackageStoreGoodsIds()
end

function MainSceneSkinMaterialTipView2:_refreshUI()
	self._canJump = self.viewParam.canJump
	self._goodsId = self.viewParam.goodsId
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._isSceneUIPackage = self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage
	self._selectTabIndex = self._isSceneUIPackage and 1 or 2

	local isShowTop = self:_showTopTab()

	if isShowTop then
		local packageConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsIds[1])

		self._txttab1.text = packageConfig.typeName
		self._txttab2.text = self._decorateConfig.typeName
		self._txttab1_1.text = packageConfig.typeName
		self._txttab2_1.text = self._decorateConfig.typeName

		if packageConfig.offTag > 0 then
			self._txtdiscount.text = string.format("-%s%%", packageConfig.offTag)
		end

		gohelper.setActive(self._godiscount, packageConfig.offTag > 0)
	end

	self:_refreshGoods()
end

function MainSceneSkinMaterialTipView2:_showTopTab()
	local isShowTop = false

	if self._isSceneUIPackage then
		isShowTop = false
	elseif self.viewParam.isShowTop then
		isShowTop = self._decorateConfig.subType == ItemEnum.SubType.MainSceneSkin and not DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[3]) or self._decorateConfig.subType == ItemEnum.SubType.MainUISkin and not DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[2]) or true
	end

	gohelper.setActive(self._gotop, isShowTop)

	return isShowTop
end

function MainSceneSkinMaterialTipView2:_refreshLogo()
	local info = MainSwitchClassifyEnum.ItemInfo[self._decorateConfig.subType]

	self._simageSceneLogo:LoadImage(ResUrl.getMainSceneSwitchLangIcon(info.Logo), function()
		self._imageSceneLogo:SetNativeSize()
		recthelper.setAnchor(self._imageSceneLogo.transform, info.LogoAnchor.x, info.LogoAnchor.y)
	end)
end

function MainSceneSkinMaterialTipView2:_refreshGoods()
	self._decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._storeCo = StoreConfig.instance:getGoodsConfig(self._goodsId)
	self._productsList = GameUtil.splitString2(self._storeCo.product, true, "|", "#")

	if self._decorateConfig.subType ~= ItemEnum.SubType.SceneUIPackage then
		local products = self._productsList[1]

		self._config = ItemModel.instance:getItemConfig(products[1], products[2])
	end

	if self._decorateConfig.offTag > 0 then
		self._txtdiscount2.text = string.format("-%s%%", self._decorateConfig.offTag)
	end

	gohelper.setActive(self._godiscount2, self._decorateConfig.offTag > 0)

	local has = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	gohelper.setActive(self._gotips, has)
	self:_refreshBuyUI()
	self:_refreshSelectTab()
	self:_refreshSelectCost()
	self:_refreshLogo()
end

function MainSceneSkinMaterialTipView2:_refreshBuyUI()
	gohelper.setActive(self._gochange.gameObject, false)
	gohelper.setActive(self._gopayitem.gameObject, false)
	gohelper.setActive(self._gobuyContent.gameObject, true)

	local cost1 = string.splitToNumber(self._storeCo.cost, "#")

	self:_refreshPayItemUI(1, cost1)

	if not string.nilorempty(self._storeCo.cost2) then
		local cost2 = string.splitToNumber(self._storeCo.cost2, "#")

		self:_refreshPayItemUI(2, cost2)
	end

	self:_onSelectPayItemUI(self._selectCostIndex or 1)
end

function MainSceneSkinMaterialTipView2:_getBuyItem(index)
	local item = self._payItemTbList[index]

	if not item then
		item = self:getUserDataTb_()

		local goItem = gohelper.cloneInPlace(self._gopayitem, "go_payitem" .. index)

		item._go = goItem
		item._gonormalbg = gohelper.findChild(goItem, "go_normalbg")
		item._goselectbg = gohelper.findChild(goItem, "go_selectbg")
		item._imageicon = gohelper.findChildImage(goItem, "txt_desc/simage_icon")
		item._txtdesc = gohelper.findChildText(goItem, "txt_desc")
		item._btnpay = gohelper.findChildButtonWithAudio(goItem, "btn_pay")

		item._btnpay:AddClickListener(self._onSelectPayItemUI, self, index)

		self._payItemTbList[index] = item
	end

	return item
end

function MainSceneSkinMaterialTipView2:_refreshPayItemUI(index, cost)
	local item1 = self:_getBuyItem(index)

	item1.cost = cost

	local str = self:_getCostIcon(item1.cost)

	UISpriteSetMgr.instance:setCurrencyItemSprite(item1._imageicon, str)

	local itemCfg, _ = ItemModel.instance:getItemConfigAndIcon(item1.cost[1], item1.cost[2], true)

	if itemCfg then
		item1._txtdesc.text = itemCfg.name or ""
	end

	gohelper.setActive(item1._go.gameObject, true)
end

function MainSceneSkinMaterialTipView2:_getCostIcon(cost)
	return (string.format("%s_1", string.len(cost[2]) == 1 and cost[1] .. "0" .. cost[2] or cost[1] .. cost[1]))
end

function MainSceneSkinMaterialTipView2:_onSelectPayItemUI(index)
	if self._selectCostIndex == index then
		return
	end

	for i, item in ipairs(self._payItemTbList) do
		local isSelect = i == index

		gohelper.setActive(item._goselectbg, isSelect)
		gohelper.setActive(item._gonormalbg, not isSelect)
		SLFramework.UGUI.GuiHelper.SetColor(item._txtdesc, isSelect and "#FFFFFF" or "#4C4341")
	end

	self._selectCostIndex = index

	self:_refreshSelectCost()
end

function MainSceneSkinMaterialTipView2:_refreshSelectCost()
	local item = self._payItemTbList[self._selectCostIndex]
	local quantity = ItemModel.instance:getItemQuantity(item.cost[1], item.cost[2])
	local costNum = self:_getCostNum()
	local str = self:_getCostIcon(item.cost)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagecosticon, str)
	self:_showTopTab()

	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)
	local isSceneUIPackage = self._decorateConfig.subType == ItemEnum.SubType.SceneUIPackage
	local count = 0

	for i, product in ipairs(self._productsList) do
		local goodsMo = self:_getGoodsMoByItemId(product)

		count = count + 1

		local item = self:_getInfoItem(count)
		local config = ItemModel.instance:getItemConfig(product[1], product[2])

		item._txtname.text = config.name

		local quantity = ItemModel.instance:getItemQuantity(product[1], product[2])

		item._txtnum.text = string.format("%s/%s", quantity, product[3])

		if goodsMo then
			local cost1, cost2 = goodsMo:getAllCostInfo()

			if self._selectCostIndex == 1 and cost1 then
				if not cost1[1] then
					if cost2 then
						::label_26_0::

						local cost = cost2[1]

						if cost then
							if not cost[3] then
								local _costNum = 0

								_costNum = has and discount and _costNum * discount * 0.001 or _costNum

								if isSceneUIPackage then
									item._txtgold.text = _costNum * (1 - self._decorateConfig.offTag * 0.01) or _costNum
								end

								gohelper.setActive(item._goprice.gameObject, not isSceneUIPackage)

								local str = self:_getCostIcon(cost)

								UISpriteSetMgr.instance:setCurrencyItemSprite(item._imagegold, str)
							end
						end
					end
				end
			end
		else
			gohelper.setActive(item._goprice.gameObject, false)
		end
	end

	for i = 1, #self._infoItemTbList do
		local item = self._infoItemTbList[i]

		gohelper.setActive(item._go, i <= count)
	end

	self._txtcostnum.text = costNum
	self._txtoriginalprice.text = self._decorateConfig["originalCost" .. self._selectCostIndex]

	SLFramework.UGUI.GuiHelper.SetColor(self._txtcostnum, quantity and costNum <= quantity and "#595959" or "#BF2E11")
end

function MainSceneSkinMaterialTipView2:_getGoodsMoByItemId(product)
	local storeMo = StoreModel.instance:getStoreMO(self._decorateConfig.storeld)

	if storeMo and storeMo:getGoodsList() then
		for _, mo in pairs(storeMo:getGoodsList()) do
			if not string.nilorempty(mo.config.product) then
				local productArr = GameUtil.splitString2(mo.config.product, true)

				for _, _product in pairs(productArr) do
					if product[1] == _product[1] and product[2] == _product[2] then
						return mo
					end
				end
			end
		end
	end
end

function MainSceneSkinMaterialTipView2:_refreshSelectTab()
	gohelper.setActive(self._goselect, self._selectTabIndex == 1)
	gohelper.setActive(self._goselect2, self._selectTabIndex == 2)
end

function MainSceneSkinMaterialTipView2:_getCostNum()
	local item = self._payItemTbList[self._selectCostIndex]
	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)
	local costNum = item.cost[3]

	if discount then
		self._txtdiscounttips.text = string.format("-%s%%", discount * 0.1)

		return (has or nil) and (costNum * discount * 0.001 or costNum)
	end

	return costNum
end

function MainSceneSkinMaterialTipView2:_getInfoItem(index)
	local item = self._infoItemTbList[index]

	if not item then
		item = self:getUserDataTb_()
		item._go = gohelper.clone(self._goblockInfoItem, self._scrollblockInfo.content.gameObject, index)
		item._index = index
		item._goprice = gohelper.findChild(item._go, "go_price")
		item._gofinish = gohelper.findChild(item._go, "go_finish")
		item._txtgold = gohelper.findChildText(item._go, "go_price/txt_gold")
		item._imagegold = gohelper.findChildImage(item._go, "go_price/image_gold")
		item._txtname = gohelper.findChildText(item._go, "txt_name")
		item._txtnum = gohelper.findChildText(item._go, "txt_num")
		item._gobg = gohelper.findChild(item._go, "go_bg")
		item._txtowner = gohelper.findChildText(item._go, "go_finish/txt_owner")

		table.insert(self._infoItemTbList, item)
	end

	return item
end

function MainSceneSkinMaterialTipView2:onClose()
	MainSceneSkinMaterialTipView2.super.onClose(self)

	for _, item in pairs(self._payItemTbList) do
		item._btnpay:RemoveClickListener()
	end

	self._simageSceneLogo:UnLoadImage()
end

return MainSceneSkinMaterialTipView2
