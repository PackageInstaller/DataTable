-- chunkname: @modules/logic/store/model/StoreMO.lua

module("modules.logic.store.model.StoreMO", package.seeall)

local StoreMO = pureTable("StoreMO")

function StoreMO:init(info)
	self.id = info.id
	self.nextRefreshTime = info.nextRefreshTime
	self.goodsInfos = info.goodsInfos
	self.offlineTime = info.offlineTime

	self:_initstoreGoodsMOList()
end

function StoreMO:_initstoreGoodsMOList()
	self._storeGoodsMOList = {}

	if self.goodsInfos and #self.goodsInfos > 0 then
		for i, goodInfo in ipairs(self.goodsInfos) do
			local goodCo = StoreConfig.instance:getGoodsConfig(goodInfo.goodsId)

			if goodCo then
				local storeGoodsMO = StoreGoodsMO.New()

				storeGoodsMO:init(self.id, goodInfo)
				table.insert(self._storeGoodsMOList, storeGoodsMO)
			end
		end
	end
end

function StoreMO:buyGoodsReply(goodsId, num)
	if self._storeGoodsMOList and #self._storeGoodsMOList > 0 then
		for i, storeGoodsMO in ipairs(self._storeGoodsMOList) do
			if storeGoodsMO.goodsId == goodsId then
				storeGoodsMO:buyGoodsReply(num)

				return
			end
		end
	end
end

function StoreMO:getBuyCount(goodsId)
	if self._storeGoodsMOList and #self._storeGoodsMOList > 0 then
		for i, storeGoodsMO in ipairs(self._storeGoodsMOList) do
			if storeGoodsMO.goodsId == goodsId then
				return storeGoodsMO.buyCount or 0
			end
		end
	end

	return 0
end

function StoreMO:getGoodsList(order)
	local goodsList = self._storeGoodsMOList

	if order and #goodsList > 0 then
		table.sort(goodsList, self._goodsSortFunction)
	end

	return goodsList
end

function StoreMO:getGoodsCount()
	return (self._storeGoodsMOList or nil) and (#self._storeGoodsMOList or 0)
end

function StoreMO:getGoodsMO(goodsId)
	if self._storeGoodsMOList and #self._storeGoodsMOList > 0 then
		for i, storeGoodsMO in ipairs(self._storeGoodsMOList) do
			if storeGoodsMO.goodsId == goodsId then
				return storeGoodsMO
			end
		end
	end
end

function StoreMO._goodsSortFunction(xMO, yMO)
	local xSoldOut = xMO:isSoldOut()
	local ySoldOut = yMO:isSoldOut()
	local xHas = xMO:alreadyHas()
	local yHas = yMO:alreadyHas()

	if xHas and not yHas then
		return false
	elseif yHas and not xHas then
		return true
	end

	if xSoldOut and not ySoldOut then
		return false
	elseif ySoldOut and not xSoldOut then
		return true
	end

	local xConfig = StoreConfig.instance:getGoodsConfig(xMO.goodsId)
	local yConfig = StoreConfig.instance:getGoodsConfig(yMO.goodsId)

	if xConfig.order > yConfig.order then
		return true
	elseif xConfig.order < yConfig.order then
		return false
	end

	return xConfig.id < yConfig.id
end

return StoreMO
