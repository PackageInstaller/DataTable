-- chunkname: @modules/logic/store/model/StoreSkinPriceMO.lua

local ti = table.insert

module("modules.logic.store.model.StoreSkinPriceMO", package.seeall)

local StoreSkinPriceMO = class("StoreSkinPriceMO")

local function _doCalc_skinCo(self)
	local skinId = self.skinId

	if not skinId then
		return
	end

	local skinCo = self:getSkinCo(skinId)

	if not skinCo then
		return
	end

	local isChargePackageValid = StoreModel.instance:isStoreSkinChargePackageValid(skinId)

	if not isChargePackageValid then
		return
	end

	self.rmbCurPrice, self.rmbOriginalPrice = self:getSkinChargePriceStr(skinId)
end

local function _doCalc_goodsConfig(self, goodsConfig, optDeductionItemIndices)
	local skinId = self.skinId

	local function _doCalc_cost()
		local cost = goodsConfig.cost

		if string.nilorempty(cost) then
			return
		end

		local costItemCO = string.splitToNumber(cost, "#")

		self.coinsItemType = costItemCO[1]
		self.coinsItemId = costItemCO[2]
		self.coinsCostPrice = costItemCO[3]
		self.coinsCurPrice = costItemCO[3]
	end

	local function _doCalc_deductionItem()
		local deductionItem = goodsConfig.deductionItem

		if string.nilorempty(deductionItem) then
			return
		end

		local hasDeductionItem = false
		local deductionItemInfoList = {}
		local infoList = string.split(deductionItem, ",")

		for i, infoStr in ipairs(infoList) do
			local info = GameUtil.splitString2(infoStr, true)
			local itemCO = info[1]
			local itemType = itemCO[1]
			local itemId = itemCO[2]
			local itemNeedCount = itemCO[3]

			if not info[2][1] then
				local coinsReduction = 0
				local has = itemNeedCount <= ItemModel.instance:getItemQuantity(itemType, itemId)

				ti(deductionItemInfoList, {
					itemType = itemType,
					itemId = itemId,
					itemNeedCount = itemNeedCount,
					reduction = coinsReduction,
					has = has
				})

				hasDeductionItem = hasDeductionItem or has
			end
		end

		local coinsCurPrice = self.coinsCurPrice
		local coinsReduction = 0

		if hasDeductionItem then
			self.coinsOriginalPrice = self.coinsCostPrice

			for index, info in ipairs(deductionItemInfoList) do
				local reduction = info.reduction

				if info.has then
					self.containDeductionCount = self.containDeductionCount + 1

					if not optDeductionItemIndices then
						coinsReduction = coinsReduction + reduction
						coinsCurPrice = coinsCurPrice - reduction
					elseif optDeductionItemIndices[index] then
						coinsReduction = coinsReduction + reduction
						coinsCurPrice = coinsCurPrice - reduction
					end
				end
			end
		end

		self.coinsCurPrice = coinsCurPrice
		self.coinsReduction = coinsReduction
		self.deductionItemInfoList = deductionItemInfoList
		self.hasDeductionItem = hasDeductionItem
	end

	local function _doCalc_specialofferItem()
		local specialofferItem = goodsConfig.specialofferItem

		if string.nilorempty(specialofferItem) then
			return
		end

		local info = GameUtil.splitString2(specialofferItem, true)
		local itemCO = info[1]
		local itemType = itemCO[1]
		local itemId = itemCO[2]
		local itemNeedCount = itemCO[3]
		local numList = info[2]
		local rmbChargeGoodsIdNoSpecialItem, rmbChargeGoodsDiffSpecialItem = numList[1], numList[2]
		local coinsNoSpecialItem = numList[3]
		local coinsYsSpecialItem = tonumber(self.coinsCostPrice) or -199999
		local reduction = coinsNoSpecialItem - coinsYsSpecialItem
		local hasSpecialOfferItem = itemNeedCount <= ItemModel.instance:getItemQuantity(itemType, itemId)

		if hasSpecialOfferItem then
			self.containDeductionCount = self.containDeductionCount + 1
			self.rmbCurPrice = self:getSkinChargePriceStr(skinId)
		else
			self.rmbCurPrice = PayModel.instance:getProductPrice(rmbChargeGoodsIdNoSpecialItem)
		end

		local chargeGoodsConfig = StoreConfig.instance:getChargeGoodsConfig(rmbChargeGoodsDiffSpecialItem, true)

		if chargeGoodsConfig then
			self.rmbDiffAbsPrice = PayModel.instance:getProductPrice(rmbChargeGoodsDiffSpecialItem)
		elseif SettingsModel.instance:isNatives() then
			local symbol = PayModel.instance:getProductOriginPriceSymbol()

			self.rmbDiffAbsPrice = symbol .. tostring(rmbChargeGoodsDiffSpecialItem)
		end

		if self.hasDeductionItem then
			self.coinsOriginalPrice = coinsNoSpecialItem

			if hasSpecialOfferItem then
				self.coinsCurPrice = coinsYsSpecialItem - self.coinsReduction or coinsNoSpecialItem - self.coinsReduction
			end
		else
			self.coinsOriginalPrice = hasSpecialOfferItem and coinsNoSpecialItem or 0
			self.coinsCurPrice = hasSpecialOfferItem and coinsYsSpecialItem or coinsNoSpecialItem
		end

		if hasSpecialOfferItem then
			self.coinsReduction = self.coinsReduction + reduction
		end

		self.specialofferItemType = itemType
		self.specialofferItemId = itemId
		self.hasSpecialOfferItem = hasSpecialOfferItem
		self.specialofferReduction = reduction
	end

	_doCalc_cost()
	_doCalc_deductionItem()
	_doCalc_specialofferItem()
end

function StoreSkinPriceMO:ctor()
	self:clear()
end

function StoreSkinPriceMO:clear()
	self.hasSpecialOfferItem = false
	self.specialofferItemType = false
	self.specialofferItemId = false
	self.hasDeductionItem = false
	self.deductionItemInfoList = {}
	self.coinsReduction = 0
	self.rmbCurPrice = false
	self.rmbOriginalPrice = false
	self.rmbDiffAbsPrice = false
	self.coinsCurPrice = false
	self.coinsOriginalPrice = 0
	self.coinsItemType = false
	self.coinsItemId = false
	self.coinsCostPrice = false
	self.bCoinsEnough = false
	self.coinsCurPriceNumeric = 0
	self.goodsId = 0
	self.skinId = 0
	self.containDeductionCount = 0
end

function StoreSkinPriceMO:reset(goodsConfig, optSkinId, optDeductionItemIndices)
	self:clear()

	if not goodsConfig then
		return
	end

	self.goodsId = goodsConfig.id
	self.coinsOriginalPrice = goodsConfig.originalCost
	self.skinId = optSkinId or 0

	_doCalc_skinCo(self)
	_doCalc_goodsConfig(self, goodsConfig, optDeductionItemIndices)

	if self.coinsCurPrice then
		self.coinsCurPriceNumeric = self.coinsCurPrice

		if self.coinsItemType then
			local hasCoins = ItemModel.instance:getItemQuantity(self.coinsItemType, self.coinsItemId)

			self.bCoinsEnough = hasCoins >= self.coinsCurPrice
		end

		if self.coinsCurPrice < 0 then
			self.coinsCurPrice = 0
		end
	end
end

function StoreSkinPriceMO:getSkinChargePriceStr(optSkinId)
	optSkinId = optSkinId or self.skinId

	local price, originalPrice = "", ""
	local skinChargeGoodsCfg = StoreConfig.instance:getSkinChargeGoodsCfg(optSkinId)

	if skinChargeGoodsCfg then
		local lua_store_charge_goods_id = skinChargeGoodsCfg.id

		price = PayModel.instance:getProductPrice(lua_store_charge_goods_id)

		if skinChargeGoodsCfg.originalCostGoodsId then
			originalPrice = PayModel.instance:getProductPrice(skinChargeGoodsCfg.originalCostGoodsId)
		else
			local symbol = PayModel.instance:getProductOriginPriceSymbol(lua_store_charge_goods_id)

			originalPrice = symbol .. tostring(skinChargeGoodsCfg.originalCost)
		end
	end

	return price, originalPrice
end

function StoreSkinPriceMO:getSkinCo(optSkinId)
	optSkinId = optSkinId or self.skinId

	return SkinConfig.instance:getSkinCo(optSkinId)
end

return StoreSkinPriceMO
