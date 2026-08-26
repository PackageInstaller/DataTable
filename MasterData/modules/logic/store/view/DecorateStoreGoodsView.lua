-- chunkname: @modules/logic/store/view/DecorateStoreGoodsView.lua

module("modules.logic.store.view.DecorateStoreGoodsView", package.seeall)

local DecorateStoreGoodsView = class("DecorateStoreGoodsView", BaseView)

function DecorateStoreGoodsView:onInitView()
	self._simageblur = gohelper.findChildSingleImage(self.viewGO, "view/#simage_blur")
	self._simagerightbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_rightbg")
	self._simageleftbg = gohelper.findChildSingleImage(self.viewGO, "view/bg/#simage_leftbg")
	self._txtgoodsNameCn = gohelper.findChildText(self.viewGO, "view/common/title/#txt_goodsNameCn")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/#btn_buy")
	self._godiscount = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "view/common/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "view/common/#btn_buy/#go_discount2/#txt_discount")
	self._gocost = gohelper.findChild(self.viewGO, "view/common/cost")
	self._btncost1 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost1")
	self._gounselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/unselect")
	self._imageiconunselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/unselect/icon/simage_icon")
	self._txtcurpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/txt_Num")
	self._txtoriginalpriceunselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/unselect/#txt_original_price")
	self._goselect1 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost1/select")
	self._imageiconselect1 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost1/select/icon/simage_icon")
	self._txtcurpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/txt_Num")
	self._txtoriginalpriceselect1 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost1/select/#txt_original_price")
	self._btncost2 = gohelper.findChildButtonWithAudio(self.viewGO, "view/common/cost/#btn_cost2")
	self._gounselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/unselect")
	self._imageiconunselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/unselect/icon/simage_icon")
	self._txtcurpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/txt_Num")
	self._txtoriginalpriceunselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/unselect/#txt_original_price")
	self._goselect2 = gohelper.findChild(self.viewGO, "view/common/cost/#btn_cost2/select")
	self._imageiconselect2 = gohelper.findChildImage(self.viewGO, "view/common/cost/#btn_cost2/select/icon/simage_icon")
	self._txtcurpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/txt_Num")
	self._txtoriginalpriceselect2 = gohelper.findChildText(self.viewGO, "view/common/cost/#btn_cost2/select/#txt_original_price")
	self._gocostsingle = gohelper.findChild(self.viewGO, "view/common/cost_single")
	self._imageiconsingle = gohelper.findChildImage(self.viewGO, "view/common/cost_single/simage_material")
	self._txtcurpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_materialNum")
	self._txtoriginalpricesingle = gohelper.findChildText(self.viewGO, "view/common/cost_single/#txt_price")
	self._gonormal = gohelper.findChild(self.viewGO, "view/normal")
	self._gonormalremain = gohelper.findChild(self.viewGO, "view/normal/info/remain")
	self._gonormalleftbg = gohelper.findChild(self.viewGO, "view/normal/info/remain/#go_leftbg")
	self._txtnormalleftremain = gohelper.findChildText(self.viewGO, "view/normal/info/remain/#go_leftbg/#txt_remain")
	self._gonormalrightbg = gohelper.findChild(self.viewGO, "view/normal/info/remain/#go_rightbg")
	self._txtnormalrightremain = gohelper.findChildText(self.viewGO, "view/normal/info/remain/#go_rightbg/#txt_remaintime")
	self._txtgoodsUseDesc = gohelper.findChildText(self.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtgoodsDesc = gohelper.findChildText(self.viewGO, "view/normal/info/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._gonormaldetail = gohelper.findChild(self.viewGO, "view/normal_detail")
	self._godetailremain = gohelper.findChild(self.viewGO, "view/normal_detail/remain")
	self._godetailleftbg = gohelper.findChild(self.viewGO, "view/normal_detail/remain/#go_leftbg")
	self._txtdetailleftremain = gohelper.findChildText(self.viewGO, "view/normal_detail/remain/#go_leftbg/#txt_remain")
	self._godetailrightbg = gohelper.findChild(self.viewGO, "view/normal_detail/remain/#go_rightbg")
	self._txtdetailrightremain = gohelper.findChildText(self.viewGO, "view/normal_detail/remain/#go_rightbg/#txt_remaintime")
	self._gonormaldetailinfo = gohelper.findChild(self.viewGO, "view/normal_detail/info")
	self._txtnormaldetailUseDesc = gohelper.findChildText(self.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsUseDesc")
	self._txtnormaldetaildesc = gohelper.findChildText(self.viewGO, "view/normal_detail/info/goodsDesc/Viewport/Content/#txt_goodsDesc")
	self._btnclose = gohelper.findChildButtonWithAudio(self.viewGO, "view/#btn_close")
	self._simagetype1 = gohelper.findChildSingleImage(self.viewGO, "view/right/type1")
	self._simagetype2 = gohelper.findChildSingleImage(self.viewGO, "view/right/type2")
	self._goType3 = gohelper.findChild(self.viewGO, "view/right/type3")
	self._simagetype3 = gohelper.findChildSingleImage(self.viewGO, "view/right/type3/#simage_icon")
	self._gohadnumber = gohelper.findChild(self.viewGO, "view/right/type3/#go_hadnumber")
	self._txttype3num = gohelper.findChildText(self.viewGO, "view/right/type3/#go_hadnumber/#txt_hadnumber")
	self._btnicon = gohelper.findChildButtonWithAudio(self.viewGO, "view/right/#btn_click")
	self.btnSelfSelect = gohelper.findChildButtonWithAudio(self.viewGO, "view/tag/#go_selfselect")
	self._gotopright = gohelper.findChild(self.viewGO, "#go_topright")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateStoreGoodsView:addEvents()
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self._btncost1:AddClickListener(self._btncost1OnClick, self)
	self._btncost2:AddClickListener(self._btncost2OnClick, self)
	self._btnclose:AddClickListener(self._btncloseOnClick, self)
	self._btnicon:AddClickListener(self._btniconOnClick, self)
	self.btnSelfSelect:AddClickListener(self._btnSelfSelectOnClick, self)
	self.addEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function DecorateStoreGoodsView:removeEvents()
	self._btnbuy:RemoveClickListener()
	self._btncost1:RemoveClickListener()
	self._btncost2:RemoveClickListener()
	self._btnclose:RemoveClickListener()
	self._btnicon:RemoveClickListener()
	self.btnSelfSelect:RemoveClickListener()
	self.removeEventCb(self, ActivityController.instance, ActivityEvent.RefreshNorSignActivity, self._refreshUI, self)
end

function DecorateStoreGoodsView:_btncloseOnClick()
	self:closeThis()
end

function DecorateStoreGoodsView:_btnSelfSelectOnClick()
	local products = string.splitToNumber(self._goodConfig.product, "#")

	ViewMgr.instance:openView(ViewName.DecorateSkinListView, {
		itemId = products[2]
	})
end

function DecorateStoreGoodsView:_btniconOnClick()
	local products = string.splitToNumber(self._goodConfig.product, "#")

	MaterialTipController.instance:showMaterialInfo(products[1], products[2])
end

function DecorateStoreGoodsView:_btncost1OnClick()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	if curIndex == 1 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(1)
	self:_refreshCost()
end

function DecorateStoreGoodsView:_btncost2OnClick()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	if curIndex == 2 then
		return
	end

	DecorateStoreModel.instance:setCurCostIndex(2)
	self:_refreshCost()
end

function DecorateStoreGoodsView:_btnbuyOnClick()
	local has, items = DecorateStoreModel.instance:hasDiscountItem(self._mo.goodsId)

	self._discountItems = items

	local isCanBuySceneUIPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()

	if has and items and isCanBuySceneUIPackage then
		local co = ItemModel.instance:getItemConfig(items[1], items[2])

		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateDiscountTip2, MsgBoxEnum.BoxType.Yes_No, self._checkDiscounnt, self.closeThis, nil, self, self, nil, (co or nil) and (co.name or ""), self._mo.config.name)
	else
		self:_checkDiscounnt()
	end
end

function DecorateStoreGoodsView:_checkDiscounnt()
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

function DecorateStoreGoodsView:_onJumpGetDiscountItemView()
	if self._discountItems[2] then
		if self._discountItems[2] then
			ActivityModel.instance:setTargetActivityCategoryId(self._discountItems[2])
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function DecorateStoreGoodsView:_readyBuy()
	local isFree = string.nilorempty(self._mo.config.cost) and string.nilorempty(self._mo.config.cost2)

	if isFree then
		self:_buyGood()

		return
	end

	local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._mo.goodsId)
	local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._mo.goodsId) or 100

	discount2 = discount2 == 0 and 100 or discount2

	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	if curIndex == 1 then
		local costs = string.splitToNumber(self._mo.config.cost, "#")

		self._costType = costs[1]
		self._costId = costs[2]
		self._costQuantity = 0.01 * discount2 * costs[3]
	else
		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		self._costType = cost2s[1]
		self._costId = cost2s[2]
		self._costQuantity = 0.01 * discount2 * cost2s[3]
	end

	if self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
		if CurrencyController.instance:checkFreeDiamondEnough(self._costQuantity, CurrencyEnum.PayDiamondExchangeSource.Store, nil, self._exchangeFinished, self, self.closeThis, self) then
			self:_buyGood(curIndex)
		end
	elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.Diamond then
		if CurrencyController.instance:checkDiamondEnough(self._costQuantity, self.closeThis, self) then
			self:_buyGood(curIndex)
		end
	elseif self._costType == MaterialEnum.MaterialType.Currency and self._costId == CurrencyEnum.CurrencyType.OldTravelTicket then
		local currencyMo = CurrencyModel.instance:getCurrency(self._costId)

		if currencyMo then
			if currencyMo.quantity >= self._costQuantity then
				self:_buyGood(curIndex)
			else
				GameFacade.showToast(ToastEnum.CurrencyNotEnough)

				return false
			end
		end
	elseif ItemModel.instance:goodsIsEnough(self._costType, self._costId, self._costQuantity) then
		self:_buyGood(curIndex)
	else
		GameFacade.showMessageBox(MessageBoxIdDefine.DecorateStoreCurrencyNotEnough, MsgBoxEnum.BoxType.Yes_No, self._storeCurrencyNotEnoughCallback, nil, nil, self, nil)
	end
end

function DecorateStoreGoodsView:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function DecorateStoreGoodsView:_exchangeFinished()
	local curIndex = DecorateStoreModel.instance:getCurCostIndex()

	self:_buyGood(curIndex)
end

function DecorateStoreGoodsView:_buyGood(index)
	StoreController.instance:buyGoods(self._mo, 1, self._buyCallback, self, index)
end

function DecorateStoreGoodsView:_buyCallback(cmd, resultCode, msg)
	if resultCode == 0 then
		self:closeThis()
	end
end

function DecorateStoreGoodsView:_editableInitView()
	gohelper.addUIClickAudio(self._btnbuy.gameObject, AudioEnum.UI.Store_Good_Click)
	DecorateStoreModel.instance:setCurCostIndex(1)
end

function DecorateStoreGoodsView:_refreshUI()
	self._goodConfig = StoreConfig.instance:getGoodsConfig(self._mo.goodsId)
	self._curItemType = DecorateStoreModel.getItemType(tonumber(self._goodConfig.storeId))

	self:_refreshIcon()
	self:_refreshGoodDetail()
	self:_refreshCost()
end

function DecorateStoreGoodsView:_refreshIcon()
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._mo.goodsId)

	gohelper.setActive(self._simagetype1.gameObject, false)
	gohelper.setActive(self._simagetype2.gameObject, false)
	gohelper.setActive(self._goType3, false)

	if not string.nilorempty(decorateCo.buylmg) then
		local icon = ResUrl.getDecorateStoreImg(decorateCo.buylmg)

		if self._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
			self._simagetype2:LoadImage(icon)
			gohelper.setActive(self._simagetype2.gameObject, true)
		else
			self._simagetype1:LoadImage(icon)
			gohelper.setActive(self._simagetype1.gameObject, true)
		end
	else
		local products = string.splitToNumber(self._goodConfig.product, "#")
		local _, icon = ItemModel.instance:getItemConfigAndIcon(products[1], products[2], true)
		local itemCount = ItemModel.instance:getItemQuantity(products[1], products[2])

		gohelper.setActive(self._goType3, true)
		gohelper.setActive(self._gohadnumber, decorateCo.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut)
		self._simagetype3:LoadImage(icon)

		if decorateCo.maxbuycountType == DecorateStoreEnum.MaxBuyTipType.SoldOut then
			self._txttype3num.text = itemCount
		end
	end

	gohelper.setActive(self.btnSelfSelect, self._curItemType == DecorateStoreEnum.DecorateItemType.SkinGift)
end

function DecorateStoreGoodsView:_refreshGoodDetail()
	local items = string.splitToNumber(self._goodConfig.product, "#")
	local itemConfig = ItemModel.instance:getItemConfig(items[1], items[2])

	self._txtgoodsNameCn.text = self._mo.config.name

	gohelper.setActive(self._gonormal, self._curItemType == DecorateStoreEnum.DecorateItemType.Skin)
	gohelper.setActive(self._gonormaldetail, self._curItemType ~= DecorateStoreEnum.DecorateItemType.Skin)

	if self._curItemType == DecorateStoreEnum.DecorateItemType.Skin then
		local offlineTime = self._mo:getOfflineTime()

		if offlineTime > 0 then
			local limitSec = math.floor(offlineTime - ServerTime.now())

			gohelper.setActive(self._gonormalremain, true)

			self._txtnormalrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
		else
			gohelper.setActive(self._gonormalremain, false)
		end

		if self._goodConfig.maxBuyCount and self._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(self._gonormalleftbg, true)

			self._txtnormalleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				self._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(self._gonormalleftbg, false)
		end

		local skinCo = SkinConfig.instance:getSkinCo(items[2])
		local heroname = lua_character.configDict[skinCo.characterId].name

		self._txtgoodsUseDesc.text = string.format(CommonConfig.instance:getConstStr(ConstEnum.StoreSkinGood), heroname)
		self._txtgoodsDesc.text = skinCo.skinDescription
	else
		local offlineTime = self._mo:getOfflineTime()

		if offlineTime > 0 then
			local limitSec = math.floor(offlineTime - ServerTime.now())

			gohelper.setActive(self._godetailrightbg, true)

			self._txtdetailrightremain.text = string.format("%s%s", TimeUtil.secondToRoughTime(limitSec))
		else
			gohelper.setActive(self._godetailrightbg, false)
		end

		if self._goodConfig.maxBuyCount and self._goodConfig.maxBuyCount > 0 then
			gohelper.setActive(self._godetailleftbg, true)

			self._txtdetailleftremain.text = GameUtil.getSubPlaceholderLuaLang(luaLang("store_buylimit_count"), {
				self._goodConfig.maxBuyCount
			})
		else
			gohelper.setActive(self._godetailleftbg, false)
		end

		self._txtnormaldetailUseDesc.text = itemConfig.useDesc
		self._txtnormaldetaildesc.text = itemConfig.desc
	end

	if self._godetailleftbg.gameObject.activeSelf then
		local isShowRemain = self._godetailrightbg.gameObject.activeSelf

		gohelper.setActive(self._godetailremain, isShowRemain)
	end
end

function DecorateStoreGoodsView:_refreshCost()
	gohelper.setActive(self._btncost1, not string.nilorempty(self._goodConfig.cost))
	gohelper.setActive(self._btncost2, not string.nilorempty(self._goodConfig.cost2))

	if string.nilorempty(self._goodConfig.cost) then
		gohelper.setActive(self._gocost, false)

		return
	end

	gohelper.setActive(self._gocost, true)

	local curIndex = DecorateStoreModel.instance:getCurCostIndex()
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._mo.goodsId)

	if decorateCo.offTag > 0 then
		if not decorateCo.offTag then
			local discount = 100

			if discount > 0 and discount < 100 then
				gohelper.setActive(self._godiscount, true)

				self._txtdiscount.text = string.format("-%s%%", discount)
			else
				gohelper.setActive(self._godiscount, false)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._mo.goodsId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._mo.goodsId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local hasDiscount = discount2 > 0 and discount2 < 100

			if hasDiscount then
				gohelper.setActive(self._godiscount, false)
				gohelper.setActive(self._godiscount2, true)

				self._txtdiscount2.text = string.format("-%s%%", discount2)
			else
				gohelper.setActive(self._godiscount2, false)
			end

			local offsetSecond = DecorateStoreModel.instance:getGoodItemLimitTime(self._mo.goodsId)
			local discount2 = offsetSecond > 0 and DecorateStoreModel.instance:getGoodDiscount(self._mo.goodsId) or 100

			discount2 = discount2 == 0 and 100 or discount2

			local costs = string.splitToNumber(self._goodConfig.cost, "#")

			if string.nilorempty(self._mo.config.cost2) then
				gohelper.setActive(self._gocost, false)
				gohelper.setActive(self._gocostsingle, true)

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconsingle, costCo.icon .. "_1", true)

				local hadQuantity = ItemModel.instance:getItemQuantity(costs[1], costs[2])

				if hadQuantity >= costs[3] then
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#393939")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpricesingle, "#bf2e11")
				end

				self._txtcurpricesingle.text = 0.01 * discount2 * costs[3]

				if decorateCo.originalCost1 > 0 then
					gohelper.setActive(self._txtoriginalpricesingle.gameObject, true)

					self._txtoriginalpricesingle.text = decorateCo.originalCost1
				else
					gohelper.setActive(self._txtoriginalpricesingle.gameObject, false)
				end
			else
				gohelper.setActive(self._gocost, true)
				gohelper.setActive(self._gocostsingle, false)

				local costCo, _ = ItemModel.instance:getItemConfigAndIcon(costs[1], costs[2])

				self._txtcurpriceunselect1.text = 0.01 * discount2 * costs[3]
				self._txtcurpriceselect1.text = 0.01 * discount2 * costs[3]

				local hadQuantity = ItemModel.instance:getItemQuantity(costs[1], costs[2])

				if hadQuantity >= costs[3] then
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#393939")
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#ffffff")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect1, "#bf2e11")
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect1, "#bf2e11")
				end

				if decorateCo.originalCost1 > 0 then
					gohelper.setActive(self._txtoriginalpriceselect1.gameObject, true)
					gohelper.setActive(self._txtoriginalpriceunselect1.gameObject, true)

					self._txtoriginalpriceselect1.text = decorateCo.originalCost1
					self._txtoriginalpriceunselect1.text = decorateCo.originalCost1
				else
					gohelper.setActive(self._txtoriginalpriceselect1.gameObject, false)
					gohelper.setActive(self._txtoriginalpriceunselect1.gameObject, false)
				end

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect1, costCo.icon .. "_1", true)
				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect1, costCo.icon .. "_1", true)
				gohelper.setActive(self._goselect1, curIndex == 1)
				gohelper.setActive(self._gounselect1, curIndex ~= 1)

				if string.nilorempty(self._goodConfig.cost2) then
					gohelper.setActive(self._txtoriginalpriceselect2.gameObject, false)
					gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, false)

					return
				end

				local costs2 = string.splitToNumber(self._goodConfig.cost2, "#")
				local cost2Co, _ = ItemModel.instance:getItemConfigAndIcon(costs2[1], costs2[2])

				self._txtcurpriceunselect2.text = 0.01 * discount2 * costs2[3]
				self._txtcurpriceselect2.text = 0.01 * discount2 * costs2[3]

				local hadQuantity2 = ItemModel.instance:getItemQuantity(costs2[1], costs2[2])

				if hadQuantity2 >= costs2[3] then
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#393939")
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#ffffff")
				else
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceunselect2, "#bf2e11")
					SLFramework.UGUI.GuiHelper.SetColor(self._txtcurpriceselect2, "#bf2e11")
				end

				if decorateCo.originalCost2 > 0 then
					gohelper.setActive(self._txtoriginalpriceselect2.gameObject, true)
					gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, true)

					self._txtoriginalpriceselect2.text = decorateCo.originalCost2
					self._txtoriginalpriceunselect2.text = decorateCo.originalCost2
				else
					gohelper.setActive(self._txtoriginalpriceselect2.gameObject, false)
					gohelper.setActive(self._txtoriginalpriceunselect2.gameObject, false)
				end

				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconselect2, cost2Co.icon .. "_1", true)
				UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageiconunselect2, cost2Co.icon .. "_1", true)
				gohelper.setActive(self._goselect2, curIndex == 2)
				gohelper.setActive(self._gounselect2, curIndex ~= 2)
			end
		end
	end
end

function DecorateStoreGoodsView:onOpen()
	self._mo = self.viewParam

	self:_setCurrency()
	self:_refreshUI()
	AudioMgr.instance:trigger(AudioEnum.TeachNote.play_ui_mail_open)
	StoreController.instance:statOpenChargeGoods(self._mo.belongStoreId, self._mo.config)
end

function DecorateStoreGoodsView:_setCurrency()
	local currencyParam = {}

	if self._mo.config.cost ~= "" then
		local costs = string.splitToNumber(self._mo.config.cost, "#")

		table.insert(currencyParam, costs[2])
	end

	if self._mo.config.cost2 ~= "" then
		local cost2s = string.splitToNumber(self._mo.config.cost2, "#")

		table.insert(currencyParam, cost2s[2])
	end

	for _, v in pairs(currencyParam) do
		if v == CurrencyEnum.CurrencyType.FreeDiamondCoupon then
			table.insert(currencyParam, CurrencyEnum.CurrencyType.Diamond)
		end
	end

	local result = LuaUtil.getReverseArrTab(currencyParam)

	self.viewContainer:setCurrencyType(result)
end

function DecorateStoreGoodsView:onClose()
	return
end

function DecorateStoreGoodsView:onUpdateParam()
	self._mo = self.viewParam

	self:_refreshUI()
end

function DecorateStoreGoodsView:onDestroyView()
	self._simagetype1:UnLoadImage()
	self._simagetype2:UnLoadImage()
end

return DecorateStoreGoodsView
