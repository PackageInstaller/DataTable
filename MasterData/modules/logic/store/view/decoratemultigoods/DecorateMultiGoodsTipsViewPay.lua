-- chunkname: @modules/logic/store/view/decoratemultigoods/DecorateMultiGoodsTipsViewPay.lua

module("modules.logic.store.view.decoratemultigoods.DecorateMultiGoodsTipsViewPay", package.seeall)

local DecorateMultiGoodsTipsViewPay = class("DecorateMultiGoodsTipsViewPay", BaseView)

function DecorateMultiGoodsTipsViewPay:onInitView()
	self._goInfoContent = gohelper.findChild(self.viewGO, "right/#go_buyContent/scroll_Info/viewport/content")
	self._goInfoItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/scroll_Info/viewport/content/#go_InfoItem")
	self._goTips = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_Tips")
	self._txtTips = gohelper.findChildText(self.viewGO, "right/#go_buyContent/#go_Tips/#txt_Tips")
	self._goPay = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_Pay")
	self._goPayItem = gohelper.findChild(self.viewGO, "right/#go_buyContent/#go_Pay/#go_PayItem")
	self._goDiscount = gohelper.findChild(self.viewGO, "right/#go_buyContent/buy/#go_Discount")
	self._txtDiscount = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#go_Discount/#txt_Discount")
	self._txtCostNum = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_CostNum")
	self._imageCostIcon = gohelper.findChildImage(self.viewGO, "right/#go_buyContent/buy/#txt_CostNum/#image_CostIcon")
	self._txtOriginalPrice = gohelper.findChildText(self.viewGO, "right/#go_buyContent/buy/#txt_CostNum/#txt_Original_Price")
	self._btnBuy = gohelper.findChildButtonWithAudio(self.viewGO, "right/#go_buyContent/buy/#btn_Buy")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function DecorateMultiGoodsTipsViewPay:addEvents()
	self._btnBuy:AddClickListener(self._btnBuyOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self._refreshSelectCost, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self._refreshSelectCost, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSelectDecorateMultiGoods, self._onSelectGoodsItem, self)
	self.addEventCb(self, StoreController.instance, StoreEvent.OnSelectDecoratePayItem, self._onSelectDecoratePayItem, self)
end

function DecorateMultiGoodsTipsViewPay:removeEvents()
	self._btnBuy:RemoveClickListener()
end

function DecorateMultiGoodsTipsViewPay:_btnBuyOnClick()
	local has, items = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	self._discountItems = items

	local isCanBuySceneUIPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()
	local goodsMo = StoreModel.instance:getGoodsMO(self._goodsId)

	if goodsMo then
		if has and items and self._decorateCo.subType ~= ItemEnum.SubType.SceneUIPackage and isCanBuySceneUIPackage then
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

function DecorateMultiGoodsTipsViewPay:_checkDiscounnt()
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

function DecorateMultiGoodsTipsViewPay:_onJumpGetDiscountItemView()
	if self._discountItems[2] then
		if self._discountItems[2] then
			ActivityModel.instance:setTargetActivityCategoryId(self._discountItems[2])
			ActivityController.instance:openActivityBeginnerView()
		end
	end
end

function DecorateMultiGoodsTipsViewPay:_readyBuy()
	if self._costList then
		local costParam = self._costList[self._selectCostIndex]
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
end

function DecorateMultiGoodsTipsViewPay:_buyGood()
	local storeGoodsMO = StoreModel.instance:getGoodsMO(self._goodsId)

	if not storeGoodsMO then
		return
	end

	StoreController.instance:buyGoods(storeGoodsMO, 1, self._onBuyCallback, self, self._selectCostIndex)
end

function DecorateMultiGoodsTipsViewPay:_storeCurrencyNotEnoughCallback()
	GameFacade.jump(JumpEnum.JumpId.GlowCharge)
end

function DecorateMultiGoodsTipsViewPay:_exchangeFinished()
	self:_buyGood()
end

function DecorateMultiGoodsTipsViewPay:_onBuyCallback()
	self:closeThis()
end

function DecorateMultiGoodsTipsViewPay:onClickModalMask()
	self:closeThis()
end

function DecorateMultiGoodsTipsViewPay:onOpen()
	self._selectCostIndex = 1

	self:_refreshGoods(self.viewParam and self.viewParam.goodsId)
end

function DecorateMultiGoodsTipsViewPay:_refreshGoods(goodsId)
	self._goodsId = goodsId
	self._decorateCo = DecorateStoreConfig.instance:getDecorateConfig(self._goodsId)
	self._storeCo = StoreConfig.instance:getGoodsConfig(self._goodsId)

	self:initCostList()
	self:refreshDiscountTips()
	self:refreshPayItemList()
	self:refreshSubProductList()
end

function DecorateMultiGoodsTipsViewPay:refreshDiscountTips()
	if self._decorateCo then
		local hasOffTag = self._decorateCo.offTag > 0

		if hasOffTag then
			self._txtDiscount.text = string.format("-%s%%", self._decorateCo.offTag)
		end

		gohelper.setActive(self._goDiscount, hasOffTag)

		local has = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

		gohelper.setActive(self._goTips, has)
	end
end

function DecorateMultiGoodsTipsViewPay:refreshSubProductList()
	local productList = GameUtil.splitString2(self._storeCo.product, true)

	gohelper.CreateObjList(self, self._refreshSubGoodsItem, productList or {}, self._goInfoContent, self._goInfoItem, DecorateMultiGoodsTipsSubGoodsItem)
end

function DecorateMultiGoodsTipsViewPay:_refreshSubGoodsItem(subGoodsItem, productInfo, index)
	subGoodsItem:onUpdateMO(self._decorateCo, productInfo, self._selectCostIndex, index)
end

function DecorateMultiGoodsTipsViewPay:_getCostNum()
	local has, _, discount = DecorateStoreModel.instance:hasDiscountItem(self._goodsId)

	if self._costList then
		local costInfo = self._costList[self._selectCostIndex]

		if costInfo then
			if not costInfo[3] then
				local costNum = 0

				if discount then
					self._txtTips.text = string.format("-%s%%", discount * 0.1)

					return (has or nil) and (costNum * discount * 0.001 or costNum), costInfo
				end

				return costNum, costInfo
			end
		end
	end
end

function DecorateMultiGoodsTipsViewPay:initCostList()
	self._costList = {}

	if not string.nilorempty(self._storeCo.cost) then
		table.insert(self._costList, string.splitToNumber(self._storeCo.cost, "#"))
	end

	if not string.nilorempty(self._storeCo.cost2) then
		table.insert(self._costList, string.splitToNumber(self._storeCo.cost2, "#"))
	end
end

function DecorateMultiGoodsTipsViewPay:refreshPayItemList()
	local costNum, costInfo = self:_getCostNum()

	self._txtCostNum.text = costNum

	local str = DecorateMultiGoodsTipsPayItem._getCostIcon(costInfo)

	UISpriteSetMgr.instance:setCurrencyItemSprite(self._imageCostIcon, str)

	local quantity = ItemModel.instance:getItemQuantity(costInfo[1], costInfo[2])

	if self._decorateCo then
		self._txtOriginalPrice.text = self._decorateCo

		SLFramework.UGUI.GuiHelper.SetColor(self._txtCostNum, quantity and costNum <= quantity and "#595959" or "#BF2E11")
		gohelper.CreateObjList(self, self._refreshPayItem, self._costList, self._goPay, self._goPayItem, DecorateMultiGoodsTipsPayItem)
	end
end

function DecorateMultiGoodsTipsViewPay:_refreshPayItem(payItem, costInfo, index)
	payItem:onUpdateMO(costInfo, index, self._selectCostIndex == index)
end

function DecorateMultiGoodsTipsViewPay:_onSelectGoodsItem(goodsId)
	self:_refreshGoods(goodsId)
end

function DecorateMultiGoodsTipsViewPay:_onSelectDecoratePayItem(index)
	self._selectCostIndex = index

	self:_refreshSelectCost()
end

function DecorateMultiGoodsTipsViewPay:_refreshSelectCost()
	self:refreshDiscountTips()
	self:refreshPayItemList()
	self:refreshSubProductList()
end

function DecorateMultiGoodsTipsViewPay:onDestroyView()
	return
end

return DecorateMultiGoodsTipsViewPay
