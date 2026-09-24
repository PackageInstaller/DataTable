-- chunkname: @modules/logic/store/model/DecorateStoreModel.lua

module("modules.logic.store.model.DecorateStoreModel", package.seeall)

local DecorateStoreModel = class("DecorateStoreModel", BaseModel)

function DecorateStoreModel:onInit()
	self._curGoodId = 0
	self._curViewType = 0
	self._curDecorateType = 0
	self._curCostIndex = 1
	self._readGoodList = {}
end

function DecorateStoreModel:reInit()
	self:onInit()
end

function DecorateStoreModel:setCurGood(goodId)
	self._curGoodId = goodId
end

function DecorateStoreModel:getCurGood(storeId)
	self._curGoodId = self._curGoodId or 0

	if self._curGoodId > 0 then
		local goodMo = StoreModel.instance:getGoodsMO(self._curGoodId)

		if not goodMo then
			self._curGoodId = 0
		end
	end

	if self._curGoodId == 0 then
		self._curGoodId = self:getDecorateGoodList(storeId)[1].goodsId
	else
		local curStoreId = tonumber(StoreConfig.instance:getGoodsConfig(self._curGoodId).storeId)

		if curStoreId ~= storeId then
			self._curGoodId = self:getDecorateGoodList(storeId)[1].goodsId
		end
	end

	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(self._curGoodId)

	if decorateConfig and decorateConfig.bundleType == 1 then
		self._curGoodId = self:getBundleSubGoods(self._curGoodId)[1].id
	end

	return self._curGoodId
end

function DecorateStoreModel:getDecorateGoodList(storeId)
	local allGoods = {}
	local storeMO = StoreModel.instance:getStoreMO(storeId)

	if storeMO then
		local goodsList = storeMO:getGoodsList()

		for _, mo in pairs(goodsList) do
			local isBundleSubGood = self:isBundleSubGood(mo.goodsId)

			if not isBundleSubGood then
				table.insert(allGoods, mo)
			end
		end
	end

	table.sort(allGoods, function(a, b)
		local isAItemOwned = self:isDecorateGoodItemOwned(a.goodsId)
		local isBItemOwned = self:isDecorateGoodItemOwned(b.goodsId)
		local aSoldOut = a.config.maxBuyCount > 0 and a.buyCount >= a.config.maxBuyCount and 1 or 0

		if isAItemOwned then
			aSoldOut = 1
		end

		local bSoldOut = b.config.maxBuyCount > 0 and b.buyCount >= b.config.maxBuyCount and 1 or 0

		if isBItemOwned then
			bSoldOut = 1
		end

		if aSoldOut ~= bSoldOut then
			return aSoldOut < bSoldOut
		else
			return a.config.order < b.config.order
		end
	end)

	return allGoods
end

function DecorateStoreModel:isBundleSubGood(goodsId)
	local goodsCo = DecorateStoreConfig.instance:getDecorateConfig(goodsId)

	if not goodsCo then
		return false
	end

	if not goodsCo.fatherGoods then
		return false
	end

	if goodsCo.fatherGoods <= 0 then
		return false
	end

	return true
end

function DecorateStoreModel:getBundleSubGoods(goodId)
	local goodList = DecorateStoreConfig.instance:getBundleGoodsIdList(goodId)

	table.sort(goodList, function(a, b)
		local aGoodConfig = StoreConfig.instance:getGoodsConfig(a.id)
		local bGoodConfig = StoreConfig.instance:getGoodsConfig(b.id)

		if aGoodConfig.order ~= bGoodConfig.order then
			return aGoodConfig.order < bGoodConfig.order
		else
			return a.id < b.id
		end
	end)

	return goodList
end

function DecorateStoreModel:getDecorateGoodIndex(storeId, goodId)
	local goodList = self:getDecorateGoodList(storeId)

	for index, goodMo in ipairs(goodList) do
		if goodMo.goodsId == goodId then
			return index
		end
	end

	return 0
end

function DecorateStoreModel:setCurViewType(viewType)
	self._curViewType = viewType
end

function DecorateStoreModel:getCurViewType()
	if self._curViewType == 0 then
		self._curViewType = DecorateStoreEnum.DecorateViewType.Fold
	end

	return self._curViewType
end

function DecorateStoreModel:setCurDecorateType(type)
	self._curDecorateType = type
end

function DecorateStoreModel:getCurDecorateType()
	if self._curDecorateType == 0 then
		self._curDecorateType = DecorateStoreEnum.DecorateType.New
	end

	return self._curDecorateType
end

function DecorateStoreModel:isGoodRead(goodId)
	return self._readGoodList[goodId]
end

function DecorateStoreModel:initDecorateReadState()
	local str = PlayerPrefsHelper.getString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), "")
	local readGoods = string.splitToNumber(str, "#")

	for _, good in pairs(readGoods) do
		self._readGoodList[good] = true
	end
end

function DecorateStoreModel:setGoodRead(goodId)
	self._readGoodList[goodId] = true

	local str = ""

	for good, _ in pairs(self._readGoodList) do
		str = str == "" and good or string.format("%s#%s", str, good)
	end

	PlayerPrefsHelper.setString(PlayerModel.instance:getPlayerPrefsKey(PlayerPrefsKey.DecorateStoreReadGoods), str)
end

function DecorateStoreModel.getItemTypeByGoodId(goodId)
	local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateConfig.productType == MaterialEnum.MaterialType.Item then
		if decorateConfig.subType == MaterialEnum.ItemSubType.Icon then
			return DecorateStoreEnum.DecorateItemType.Icon
		elseif decorateConfig.subType == MaterialEnum.ItemSubType.SelfCard then
			return DecorateStoreEnum.DecorateItemType.SelfCard
		elseif decorateConfig.subType == MaterialEnum.ItemSubType.MainScene then
			return DecorateStoreEnum.DecorateItemType.MainScene
		elseif decorateConfig.subType == ItemEnum.SubType.SkinSelelctGift then
			return DecorateStoreEnum.DecorateItemType.SkinGift
		elseif decorateConfig.subType == ItemEnum.SubType.SceneUIPackage then
			return DecorateStoreEnum.DecorateItemType.SceneUIPackage
		elseif decorateConfig.subType == ItemEnum.SubType.MainUISkin then
			return DecorateStoreEnum.DecorateItemType.MainUISkin
		end
	elseif decorateConfig.productType == MaterialEnum.MaterialType.Hero then
		return DecorateStoreEnum.DecorateItemType.Hero
	elseif decorateConfig.productType == MaterialEnum.MaterialType.HeroSkin then
		return DecorateStoreEnum.DecorateItemType.Skin
	elseif decorateConfig.productType == MaterialEnum.MaterialType.Building and decorateConfig.subType == RoomBuildingEnum.BuildingType.Interact then
		return DecorateStoreEnum.DecorateItemType.BuildingVideo
	end

	return DecorateStoreEnum.DecorateItemType.Default
end

function DecorateStoreModel.getItemType(storeId)
	local goodId = DecorateStoreModel.instance:getCurGood(storeId)

	return (DecorateStoreModel.getItemTypeByGoodId(goodId))
end

function DecorateStoreModel:setCurCostIndex(index)
	self._curCostIndex = index
end

function DecorateStoreModel:getCurCostIndex()
	return self._curCostIndex
end

function DecorateStoreModel:getGoodDiscount(goodsId)
	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

	if goodsConfig.discountItem == "" then
		return 0
	end

	local discounts = string.split(goodsConfig.discountItem, "|")

	if #discounts ~= 2 then
		return 0
	end

	local items = string.splitToNumber(discounts[1], "#")
	local itemCount = ItemModel.instance:getItemCount(items[2])

	if itemCount < items[3] then
		return 0
	end

	local itemCo = ItemModel.instance:getItemConfig(items[1], items[2])
	local ts = TimeUtil.stringToTimestamp(itemCo.expireTime)
	local offsetSecond = math.floor(ts - ServerTime.now())

	if offsetSecond <= 0 then
		return 0
	end

	return math.floor(tonumber(discounts[2]) / 10)
end

function DecorateStoreModel:getGoodItemLimitTime(goodsId)
	local discount = self:getGoodDiscount(goodsId)

	if discount > 0 and discount < 100 then
		local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)

		if goodsConfig.discountItem == "" then
			return 0
		end

		local discounts = string.split(goodsConfig.discountItem, "|")

		if #discounts ~= 2 then
			return 0
		end

		local items = string.splitToNumber(discounts[1], "#")
		local itemCount = ItemModel.instance:getItemCount(items[2])

		if itemCount < items[3] then
			return 0
		end

		local itemCo = ItemModel.instance:getItemConfig(items[1], items[2])
		local ts = TimeUtil.stringToTimestamp(itemCo.expireTime)

		return (math.floor(ts - ServerTime.now()))
	end

	return 0
end

function DecorateStoreModel:isDecorateGoodItemOwned(goodId)
	local itemHas = self:isDecorateGoodItemHas(goodId)

	if itemHas then
		local decorateConfig = DecorateStoreConfig.instance:getDecorateConfig(goodId)
		local isBundleGood = decorateConfig.bundleType > 0

		if isBundleGood then
			local subGoods = DecorateStoreModel.instance:getBundleSubGoods(goodId)

			if subGoods then
				for _, subGood in ipairs(subGoods) do
					local subHas = DecorateStoreModel.instance:isDecorateGoodItemHas(subGood.id)

					if not subHas then
						return false
					end
				end
			end

			return true
		else
			return true
		end
	else
		return false
	end
end

function DecorateStoreModel:isDecorateGoodItemHas(goodId)
	local v3a4PackageGoodsIds = self:getV3a4PackageStoreGoodsIds()

	if v3a4PackageGoodsIds and goodId == v3a4PackageGoodsIds[1] then
		local isCanBuy = self:isCanBuySceneUIPackage()

		return not isCanBuy
	end

	local goodsCo = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if not goodsCo then
		return
	end

	local subType = goodsCo.subType

	if subType == ItemEnum.SubType.DecorateBundle then
		local bundleGoodsIdList = DecorateStoreConfig.instance:getBundleGoodsIdList(goodId)

		if bundleGoodsIdList then
			for _, sonGoodsId in ipairs(bundleGoodsIdList) do
				if not self:isDecorateGoodItemHas(sonGoodsId) then
					return
				end
			end
		end

		return true
	end

	if goodsCo.bundleType > 0 then
		return not DecorateModel.instance:isCanBuyGoods(goodId)
	end

	if goodsCo.fatherGoods > 0 then
		local curItemType = DecorateStoreModel.getItemTypeByGoodId(goodsCo.id)

		if curItemType == DecorateStoreEnum.DecorateItemType.Hero then
			return false
		end

		local fatherGoodsCo = DecorateStoreConfig.instance:getDecorateConfig(goodsCo.fatherGoods)

		if fatherGoodsCo.bundleType > 0 then
			return not DecorateModel.instance:isCanBuyGoods(goodId)
		end
	end

	return self:_isDecorateGoodItemHas(goodId)
end

function DecorateStoreModel:_isDecorateGoodItemHas(goodId)
	local decorateCo = DecorateStoreConfig.instance:getDecorateConfig(goodId)

	if decorateCo.maxbuycountType ~= DecorateStoreEnum.MaxBuyTipType.Owned then
		return false
	end

	local goodsConfig = StoreConfig.instance:getGoodsConfig(goodId)
	local items = string.splitToNumber(goodsConfig.product, "#")

	if decorateCo.productType == MaterialEnum.MaterialType.Item and decorateCo.subType == ItemEnum.SubType.SkinSelelctGift then
		local config = ItemConfig.instance:getItemCo(items[2])

		if config then
			if not config.effect then
				local effect = ""
				local param = GameUtil.splitString2(effect, true)

				if not param then
					return false
				end

				local skinList = param[1]

				for i, v in ipairs(skinList) do
					if not HeroModel.instance:checkHasSkin(v) then
						return false
					end
				end

				return true
			end
		end
	end

	local itemCount = ItemModel.instance:getItemQuantity(items[1], items[2])

	return itemCount > 0
end

function DecorateStoreModel:isAutoHideUIType(type)
	if type == DecorateStoreEnum.DecorateItemType.MainScene then
		return true
	end

	if type == DecorateStoreEnum.DecorateItemType.SelfCard then
		return true
	end

	if type == DecorateStoreEnum.DecorateItemType.Skin then
		return true
	end

	if type == DecorateStoreEnum.DecorateItemType.SkinGift then
		return true
	end

	return false
end

function DecorateStoreModel:hasDiscountItem(goodsId)
	local storeMo = StoreModel.instance:getGoodsMO(goodsId)

	if storeMo then
		local goodsConfig = storeMo.config

		if not string.nilorempty(goodsConfig.discountItem) then
			local discounts = string.split(goodsConfig.discountItem, "|")
			local items = string.splitToNumber(discounts[1], "#")

			return ItemModel.instance:getItemQuantity(items[1], items[2]) > 0, items, discounts[2] and tonumber(discounts[2])
		end
	else
		local type = MaterialEnum.MaterialType.Item
		local id = V3a4GiftRecommendEnum.OffItemId
		local has = ItemModel.instance:getItemQuantity(type, id) > 0

		return has, {
			type,
			id
		}, 500
	end
end

function DecorateStoreModel:isCanClaimDiscountItem(items)
	if items then
		if items[2] then
			local actId = DecorateStoreEnum.DiscountItemActId[items[2]]

			if actId then
				local cos = ActivityConfig.instance:getNorSignActivityCos(actId)

				if cos then
					for _, co in pairs(cos) do
						if not string.nilorempty(co.bonus) then
							local bonus = GameUtil.splitString2(co.bonus, true, "|", "#")

							for _, v in ipairs(bonus) do
								if v[1] == items[1] and v[2] == items[2] then
									local couldGet = ActivityType101Model.instance:isType101RewardCouldGet(actId, co.id)

									if couldGet then
										return couldGet
									end
								end
							end
						end
					end
				end
			end
		end
	end
end

function DecorateStoreModel:isCanBuySceneUIPackage()
	local goodsIds = self:getV3a4PackageStoreGoodsIds()
	local hasScene = self:isDecorateGoodItemHas(goodsIds[2])
	local hasUI = self:isDecorateGoodItemHas(goodsIds[3])

	if not hasScene and not hasUI then
		return true
	end

	return false
end

function DecorateStoreModel:getV3a4PackageStoreGoodsIds()
	if not self._v3a4PackageStoreGoodsIds then
		self:_initPackageStoreGoodsIds()
	end

	return self._v3a4PackageStoreGoodsIds
end

function DecorateStoreModel:_initPackageStoreGoodsIds()
	local str = CommonConfig.instance:getConstStr(ConstEnum.V3a4PackageStoreGoodsId)

	self._v3a4PackageStoreGoodsIds = string.splitToNumber(str, "#")
end

function DecorateStoreModel:isCanBuyGoods(goodsId)
	local goodsCo = DecorateStoreConfig.instance:getDecorateConfig(goodsId)

	if not goodsCo then
		return
	end

	local isHas = self:isDecorateGoodItemHas(goodsId)
	local subType = goodsCo.subType

	if not isHas and subType == ItemEnum.SubType.DecorateBundle then
		local bundleGoodsIdList = DecorateStoreConfig.instance:getBundleGoodsIdList(goodsId)

		if bundleGoodsIdList then
			for _, sonGoodsId in ipairs(bundleGoodsIdList) do
				if self:isDecorateGoodItemHas(sonGoodsId) then
					return
				end
			end
		end

		return true
	end

	return not isHas
end

DecorateStoreModel.instance = DecorateStoreModel.New()

return DecorateStoreModel
