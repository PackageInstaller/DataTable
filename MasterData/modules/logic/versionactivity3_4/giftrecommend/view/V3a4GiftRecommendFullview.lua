-- chunkname: @modules/logic/versionactivity3_4/giftrecommend/view/V3a4GiftRecommendFullview.lua

module("modules.logic.versionactivity3_4.giftrecommend.view.V3a4GiftRecommendFullview", package.seeall)

local V3a4GiftRecommendFullview = class("V3a4GiftRecommendFullview", V3a4GiftRecommendBaseView)

function V3a4GiftRecommendFullview:onInitView()
	self._btncheck = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_check")
	self._btnbuy = gohelper.findChildButtonWithAudio(self.viewGO, "root/#btn_buy")
	self._gosingle = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_single")
	self._txtoriginalprice = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/#txt_original_price")
	self._godoubleprice = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_doubleprice")
	self._txtoriginalprice1 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/#txt_original_price1")
	self._txtoriginalprice2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/#txt_original_price1")
	self._gofree = gohelper.findChild(self.viewGO, "root/#btn_buy/cost/#go_free")
	self._godiscount = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount")
	self._txtdiscount = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount/#txt_discount")
	self._godiscount2 = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_discount2")
	self._txtdiscount2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_discount2/#txt_discount")
	self._gotips = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_tips")
	self._txttips = gohelper.findChildText(self.viewGO, "root/#btn_buy/#go_tips/#txt_tips")
	self._gocostclick = gohelper.findChild(self.viewGO, "root/#btn_buy/#go_costclick")
	self._goowned = gohelper.findChild(self.viewGO, "root/#go_owned")
	self._txttime = gohelper.findChildText(self.viewGO, "root/timebg/#txt_time")

	if self._editableInitView then
		self:_editableInitView()
	end
end

function V3a4GiftRecommendFullview:addEvents()
	V3a4GiftRecommendFullview.super.addEvents(self)
	self._btnbuy:AddClickListener(self._btnbuyOnClick, self)
	self.addEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshView, self)
	self.addEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function V3a4GiftRecommendFullview:removeEvents()
	V3a4GiftRecommendFullview.super.removeEvents(self)
	self._btnbuy:RemoveClickListener()
	self.removeEventCb(self, CurrencyController.instance, CurrencyEvent.CurrencyChange, self.refreshView, self)
	self.removeEventCb(self, BackpackController.instance, BackpackEvent.UpdateItemList, self.refreshView, self)
end

function V3a4GiftRecommendFullview:_btnbuyOnClick()
	ViewMgr.instance:openView(ViewName.MainSceneSkinMaterialTipView2, {
		canJump = true,
		isShowTop = false,
		goodsId = self._storeGoodsId
	})
end

function V3a4GiftRecommendFullview:_editableInitView()
	V3a4GiftRecommendFullview.super._editableInitView(self)

	self._txtmaterialNum = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_single/txt_materialNum")
	self._imagematerialicon = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_single/icon/simage_material")
	self._txtmaterialNum1 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/txt_materialNum")
	self._imagematerialicon1 = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency1/simage_material")
	self._txtmaterialNum2 = gohelper.findChildText(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/txt_materialNum")
	self._imagematerialicon2 = gohelper.findChildImage(self.viewGO, "root/#btn_buy/cost/#go_doubleprice/currency2/simage_material")

	gohelper.setActive(self._goowned, false)
	gohelper.setActive(self._btnbuy.gameObject, false)

	self._goodsIds = DecorateStoreModel.instance:getV3a4PackageStoreGoodsIds()
end

function V3a4GiftRecommendFullview:onOpen()
	V3a4GiftRecommendFullview.super.onOpen(self)

	local parentGO = self.viewParam.parent

	if parentGO then
		gohelper.addChild(parentGO, self.viewGO)
	end
end

function V3a4GiftRecommendFullview:refreshView()
	V3a4GiftRecommendFullview.super.refreshView(self)

	local canBuyPackage = DecorateStoreModel.instance:isCanBuySceneUIPackage()
	local hasScene = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[2])
	local hasUI = DecorateStoreModel.instance:isDecorateGoodItemHas(self._goodsIds[3])

	gohelper.setActive(self._godiscount, canBuyPackage)

	local storeGoodsId

	if canBuyPackage then
		storeGoodsId = self._goodsIds[1]
	elseif hasScene and not hasUI then
		storeGoodsId = self._goodsIds[3]
	elseif hasUI and not hasScene then
		storeGoodsId = self._goodsIds[2]
	end

	local hasOffItem = DecorateStoreModel.instance:hasDiscountItem(storeGoodsId)
	local isCanBuy = storeGoodsId ~= nil

	if isCanBuy then
		local storeGoodsCo = StoreConfig.instance:getGoodsConfig(storeGoodsId)
		local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(storeGoodsId)
		local isCost2 = not string.nilorempty(storeGoodsCo.cost2)

		if isCost2 then
			self._txtoriginalprice1.text = decorateCo.originalCost1
			self._txtoriginalprice2.text = decorateCo.originalCost2

			if not string.nilorempty(storeGoodsCo.cost) then
				local split = string.splitToNumber(storeGoodsCo.cost, "#")

				if hasOffItem then
					if not (split[3] * 0.5) then
						local num = split[3]

						self._txtmaterialNum1.text = num

						local co = ItemModel.instance:getItemConfig(split[1], split[2])

						UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerialicon1, co.icon .. "_1", true)
						gohelper.setActive(self._txtoriginalprice1.gameObject, num ~= decorateCo.originalCost1)
					end
				end
			end

			if not string.nilorempty(storeGoodsCo.cost2) then
				local split = string.splitToNumber(storeGoodsCo.cost2, "#")

				if hasOffItem then
					if not (split[3] * 0.5) then
						local num = split[3]

						self._txtmaterialNum2.text = num

						local co = ItemModel.instance:getItemConfig(split[1], split[2])

						UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerialicon2, co.icon .. "_1", true)
						gohelper.setActive(self._txtoriginalprice2.gameObject, num ~= decorateCo.originalCost2)
					end
				end
			end
		else
			if not string.nilorempty(storeGoodsCo.cost) then
				local split = string.splitToNumber(storeGoodsCo.cost, "#")

				if hasOffItem then
					if not (split[3] * 0.5) then
						local num = split[3]

						self._txtmaterialNum.text = num

						local co = ItemModel.instance:getItemConfig(split[1], split[2])

						UISpriteSetMgr.instance:setCurrencyItemSprite(self._imagematerialicon, co.icon .. "_1", true)
						gohelper.setActive(self._txtoriginalprice.gameObject, num ~= decorateCo.originalCost1)
					end
				end
			end

			self._txtoriginalprice.text = decorateCo.originalCost1
		end

		if hasScene or hasUI then
			local lang = luaLang("v3a4_giftrecommend_tip")

			self._txttips.text = GameUtil.getSubPlaceholderLuaLangOneParam(lang, storeGoodsCo.name)
		end

		self._txtdiscount.text = string.format("-%s%%", decorateCo.offTag)

		gohelper.setActive(self._gotips, hasScene or hasUI)
		gohelper.setActive(self._gosingle, not isCost2)
		gohelper.setActive(self._godoubleprice, isCost2)

		self._storeGoodsId = storeGoodsId
	end

	gohelper.setActive(self._goowned, not isCanBuy)
	gohelper.setActive(self._btnbuy.gameObject, isCanBuy)
	gohelper.setActive(self._godiscount, canBuyPackage)
	gohelper.setActive(self._godiscount2, hasOffItem)
end

function V3a4GiftRecommendFullview:_hasStoreGoods(storeGoodsId)
	local co = StoreConfig.instance:getGoodsConfig(storeGoodsId)
	local product = co.product
	local productArr = GameUtil.splitString2(product, true, "|", "#")

	for _, arr in ipairs(productArr) do
		local itemType = arr[1]
		local itemId = arr[2]
		local hasQuantity = ItemModel.instance:getItemQuantity(itemType, itemId)

		if hasQuantity <= 0 then
			return
		end
	end

	return true
end

function V3a4GiftRecommendFullview:onDestroyView()
	V3a4GiftRecommendFullview.super.onDestroyView(self)
end

return V3a4GiftRecommendFullview
