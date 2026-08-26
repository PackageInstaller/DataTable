-- chunkname: @modules/logic/room/model/common/RoomStoreItemListModel.lua

module("modules.logic.room.model.common.RoomStoreItemListModel", package.seeall)

local RoomStoreItemListModel = class("RoomStoreItemListModel", ListScrollModel)

function RoomStoreItemListModel:setStoreGoodsMO(_storeGoodsMO)
	self.storeGoodsMO = _storeGoodsMO

	local config = _storeGoodsMO.config
	local cost1, cost2 = _storeGoodsMO:getAllCostInfo()
	local costInfos = {
		cost1,
		cost2
	}

	self._costsId = 1

	local num2List = GameUtil.splitString2(config.product, true)
	local reductions = string.splitToNumber(config.reduction, "#")
	local molist = {}
	local reductionsInfo = {}

	for i, goodsId in ipairs(reductions) do
		local goodsConfig = StoreConfig.instance:getGoodsConfig(goodsId)
		local goodsCosts1 = GameUtil.splitString2(goodsConfig.cost, true)[1]
		local goodsCosts2 = GameUtil.splitString2(goodsConfig.cost2, true)[1]
		local product = GameUtil.splitString2(goodsConfig.product, true)[1]
		local pMaterialType = product[1]
		local pMaterialId = product[2]

		reductionsInfo[pMaterialType] = reductionsInfo[pMaterialType] or {}
		reductionsInfo[pMaterialType][pMaterialId] = {
			goodsCosts1[3],
			goodsCosts2[3]
		}
	end

	for i = 1, #num2List do
		local items = num2List[i]
		local mo = RoomStoreItemMO.New()

		mo:init(items[2], items[1], items[3], self._costId, _storeGoodsMO)

		for costId, costInfo in ipairs(costInfos) do
			if costInfo then
				local costParam = costInfo[1]

				mo:addCost(costId, costParam[2], costParam[1], (reductionsInfo[items[1]] and reductionsInfo[items[1]][items[2]] or nil) and reductionsInfo[items[1]][items[2]][costId])
			end
		end

		table.insert(molist, mo)
	end

	self:setList(molist)
	self:onModelUpdate()
end

function RoomStoreItemListModel:getCostId()
	return self._costsId or 1
end

function RoomStoreItemListModel:setCostId(costId)
	if costId == 1 or costId == 2 then
		self._costsId = costId

		self:onModelUpdate()
	end
end

function RoomStoreItemListModel:getTotalPriceByCostId(costId)
	local list = self:getList()

	costId = costId or self._costsId

	local totalPrice = 0

	for i = 1, #list do
		totalPrice = totalPrice + list[i]:getTotalPriceByCostId(costId)
	end

	return totalPrice
end

function RoomStoreItemListModel:getRoomStoreItemMOHasTheme()
	local list = self:getList()

	for i = 1, #list do
		local mo = list[i]

		if mo.themeId then
			return mo
		end
	end

	return nil
end

function RoomStoreItemListModel:setIsSelectCurrency(state)
	self.isSelectCurrency = state
end

function RoomStoreItemListModel:getIsSelectCurrency()
	return self.isSelectCurrency
end

RoomStoreItemListModel.instance = RoomStoreItemListModel.New()

return RoomStoreItemListModel
