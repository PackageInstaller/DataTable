-- chunkname: @modules/logic/store/model/StoreNormalGoodsItemListModel.lua

module("modules.logic.store.model.StoreNormalGoodsItemListModel", package.seeall)

local StoreNormalGoodsItemListModel = class("StoreNormalGoodsItemListModel", ListScrollModel)

function StoreNormalGoodsItemListModel:setMOList(moList, storeId)
	self._moList = {}

	if storeId then
		local extraActGoodsList = FurnaceTreasureModel.instance:getGoodsListByStoreId(storeId)

		for _, actGoodsId in ipairs(extraActGoodsList) do
			local goodsRemainBuyCount = FurnaceTreasureModel.instance:getGoodsRemainCount(storeId, actGoodsId)

			if goodsRemainBuyCount and goodsRemainBuyCount > 0 then
				local poolId = FurnaceTreasureModel.instance:getGoodsPoolId(storeId, actGoodsId)
				local storeGoodsMO = StoreGoodsMO.New()

				storeGoodsMO:intiActGoods(storeId, actGoodsId, poolId)

				self._moList[#self._moList + 1] = storeGoodsMO
			end
		end
	end

	if moList then
		for _, mo in pairs(moList) do
			table.insert(self._moList, mo)
		end
	end

	StoreNormalGoodsItemListModel.StoreId = storeId

	self:allHeroRecommendEquip()

	if #self._moList > 1 then
		table.sort(self._moList, self._sortFunction)
	end

	self:setList(self._moList)
end

function StoreNormalGoodsItemListModel._sortFunction(x, y)
	local xIsActGoods = x:getIsActGoods()
	local yIsActGoods = y:getIsActGoods()

	if xIsActGoods ~= yIsActGoods then
		return xIsActGoods
	end

	if xIsActGoods then
		local xActGoodsId = x:getActGoodsId()
		local yActGoodsId = y:getActGoodsId()

		return xActGoodsId < yActGoodsId
	end

	local xConfig = StoreConfig.instance:getGoodsConfig(x.goodsId)
	local yConfig = StoreConfig.instance:getGoodsConfig(y.goodsId)
	local xCountLimit = StoreNormalGoodsItemListModel._isStoreItemCountLimit(x)
	local yCountLimit = StoreNormalGoodsItemListModel._isStoreItemCountLimit(y)

	if xCountLimit and not yCountLimit then
		return false
	elseif not xCountLimit and yCountLimit then
		return true
	end

	local xSoldOut = StoreNormalGoodsItemListModel._isStoreItemSoldOut(x.goodsId)
	local ySoldOut = StoreNormalGoodsItemListModel._isStoreItemSoldOut(y.goodsId)
	local xUnlock = StoreNormalGoodsItemListModel._isStoreItemUnlock(x.goodsId)
	local yUnlock = StoreNormalGoodsItemListModel._isStoreItemUnlock(y.goodsId)

	if not xSoldOut and ySoldOut then
		return true
	elseif xSoldOut and not ySoldOut then
		return false
	end

	local xHas = x:alreadyHas()
	local yHas = y:alreadyHas()

	if xHas ~= yHas then
		return yHas
	end

	if xUnlock and not yUnlock then
		return true
	elseif not xUnlock and yUnlock then
		return false
	end

	if StoreNormalGoodsItemListModel.IsEquipSort and StoreNormalGoodsItemListModel.StoreId == StoreEnum.StoreId.SummonEquipExchange and not xHas and not yHas and not xSoldOut and not ySoldOut then
		local xProduct = string.splitToNumber(xConfig.product, "#")
		local yProduct = string.splitToNumber(yConfig.product, "#")
		local xRecommondEquip = false
		local yRecommondEquip = false

		if xProduct[1] == MaterialEnum.MaterialType.Equip then
			if xProduct[2] == 1000 then
				return true
			end

			xRecommondEquip = LuaUtil.tableContains(StoreNormalGoodsItemListModel._recommendEquips, xProduct[2])
		end

		if yProduct[1] == MaterialEnum.MaterialType.Equip then
			if yProduct[2] == 1000 then
				return false
			end

			yRecommondEquip = LuaUtil.tableContains(StoreNormalGoodsItemListModel._recommendEquips, yProduct[2])
		end

		if xRecommondEquip ~= yRecommondEquip then
			local xItemCo = ItemModel.instance:getItemConfig(xProduct[1], xProduct[2])
			local yItemCo = ItemModel.instance:getItemConfig(yProduct[1], yProduct[2])

			if xItemCo.rare ~= yItemCo.rare then
				return xConfig.order < yConfig.order
			else
				return xRecommondEquip
			end
		elseif xRecommondEquip == true and yRecommondEquip == true then
			return xProduct[2] > yProduct[2]
		end
	end

	local xWeekWalkLock = StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(x.goodsId)
	local yWeekWalkLock = StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(y.goodsId)

	if xWeekWalkLock ~= yWeekWalkLock then
		if xWeekWalkLock then
			return false
		end

		return true
	end

	if xConfig.order < yConfig.order then
		return true
	elseif xConfig.order > yConfig.order then
		return false
	end

	if xConfig.id < yConfig.id then
		return true
	elseif xConfig.id > yConfig.id then
		return false
	end
end

function StoreNormalGoodsItemListModel._isStoreItemUnlock(goodsId)
	local episodeId = StoreConfig.instance:getGoodsConfig(goodsId).needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function StoreNormalGoodsItemListModel.needWeekWalkLayerUnlock(goodsId)
	local needWeekwalkLayer = StoreConfig.instance:getGoodsConfig(goodsId).needWeekwalkLayer

	if needWeekwalkLayer <= 0 then
		return false
	end

	if not WeekWalkModel.instance:getInfo() then
		return true
	end

	local maxLayer = WeekWalkModel.instance:getMaxLayerId()

	return maxLayer < needWeekwalkLayer
end

function StoreNormalGoodsItemListModel._isStoreItemSoldOut(goodsId)
	local mo = StoreModel.instance:getGoodsMO(goodsId)

	return mo:isSoldOut()
end

function StoreNormalGoodsItemListModel._isStoreItemCountLimit(goodItemMo)
	local limitNum = goodItemMo:getLimitSoldNum()

	if not limitNum or limitNum == 0 then
		return false
	end

	local product = goodItemMo.config.product
	local productArr = GameUtil.splitString2(product, true)
	local itemType = productArr[1][1]
	local itemId = productArr[1][2]

	if itemType == MaterialEnum.MaterialType.Equip then
		local hasEquipNum = EquipModel.instance:getEquipQuantity(itemId)

		return limitNum <= hasEquipNum
	end
end

function StoreNormalGoodsItemListModel:initSortEquip()
	StoreNormalGoodsItemListModel.IsEquipSort = false

	self:_sortEquip()

	return StoreNormalGoodsItemListModel.IsEquipSort
end

function StoreNormalGoodsItemListModel:setSortEquip()
	StoreNormalGoodsItemListModel.IsEquipSort = not StoreNormalGoodsItemListModel.IsEquipSort

	self:_sortEquip()

	return StoreNormalGoodsItemListModel.IsEquipSort
end

function StoreNormalGoodsItemListModel:_sortEquip()
	if self._moList and #self._moList > 1 then
		table.sort(self._moList, self._sortFunction)
	end

	self:setList(self._moList)
end

function StoreNormalGoodsItemListModel:allHeroRecommendEquip()
	StoreNormalGoodsItemListModel._recommendEquips = StoreNormalGoodsItemListModel._recommendEquips or {}

	local allHero = HeroModel.instance:getAllHero()

	if allHero then
		for _, heroMo in pairs(allHero) do
			if heroMo.config.rare == 5 then
				local recommondEquips = heroMo:getRecommendEquip()

				if recommondEquips then
					for _, equip in ipairs(recommondEquips) do
						if not LuaUtil.tableContains(StoreNormalGoodsItemListModel._recommendEquips, equip) then
							table.insert(StoreNormalGoodsItemListModel._recommendEquips, equip)
						end
					end
				end
			end
		end
	end
end

StoreNormalGoodsItemListModel.instance = StoreNormalGoodsItemListModel.New()

return StoreNormalGoodsItemListModel
