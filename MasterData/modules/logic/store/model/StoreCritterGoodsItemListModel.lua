-- chunkname: @modules/logic/store/model/StoreCritterGoodsItemListModel.lua

module("modules.logic.store.model.StoreCritterGoodsItemListModel", package.seeall)

local StoreCritterGoodsItemListModel = class("StoreCritterGoodsItemListModel", ListScrollModel)

function StoreCritterGoodsItemListModel:setMOList(storeId)
	local storeMo = StoreModel.instance:getStoreMO(storeId)

	if storeMo then
		self._moList = storeMo:getGoodsList()

		if #self._moList > 1 then
			table.sort(self._moList, self._sortFunction)
		end

		self:setList(self._moList)
	end
end

function StoreCritterGoodsItemListModel._sortFunction(x, y)
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
	local xCountLimit = StoreCritterGoodsItemListModel._isStoreItemCountLimit(x)
	local yCountLimit = StoreCritterGoodsItemListModel._isStoreItemCountLimit(y)

	if xCountLimit and not yCountLimit then
		return false
	elseif not xCountLimit and yCountLimit then
		return true
	end

	local xSoldOut = StoreCritterGoodsItemListModel._isStoreItemSoldOut(x.goodsId)
	local ySoldOut = StoreCritterGoodsItemListModel._isStoreItemSoldOut(y.goodsId)
	local xUnlock = StoreCritterGoodsItemListModel._isStoreItemUnlock(x.goodsId)
	local yUnlock = StoreCritterGoodsItemListModel._isStoreItemUnlock(y.goodsId)

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

	local xWeekWalkLock = StoreCritterGoodsItemListModel.needWeekWalkLayerUnlock(x.goodsId)
	local yWeekWalkLock = StoreCritterGoodsItemListModel.needWeekWalkLayerUnlock(y.goodsId)

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

function StoreCritterGoodsItemListModel._isStoreItemUnlock(goodsId)
	local episodeId = StoreConfig.instance:getGoodsConfig(goodsId).needEpisodeId

	if not episodeId or episodeId == 0 then
		return true
	end

	return DungeonModel.instance:hasPassLevelAndStory(episodeId)
end

function StoreCritterGoodsItemListModel.needWeekWalkLayerUnlock(goodsId)
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

function StoreCritterGoodsItemListModel._isStoreItemSoldOut(goodsId)
	local mo = StoreModel.instance:getGoodsMO(goodsId)

	return mo:isSoldOut()
end

function StoreCritterGoodsItemListModel._isStoreItemCountLimit(goodItemMo)
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

StoreCritterGoodsItemListModel.instance = StoreCritterGoodsItemListModel.New()

return StoreCritterGoodsItemListModel
